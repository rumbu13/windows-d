// Written in the D programming language.

module windows.photoacquire;

public import windows.core;
public import windows.audio : IPropertyStore;
public import windows.automation : BSTR;
public import windows.com : HRESULT, IEnumString, IUnknown;
public import windows.displaydevices : SIZE;
public import windows.gdi : HBITMAP, HICON;
public import windows.structuredstorage : IStream, PROPVARIANT;
public import windows.systemservices : BOOL;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME;
public import windows.windowspropertiessystem : PROPERTYKEY;

extern(Windows):


// Enums


///The <code>USER_INPUT_STRING_TYPE</code> enumeration type indicates the type of string to obtain from the user in
///IPhotoAcquireProgressCB::GetUserInput.
alias USER_INPUT_STRING_TYPE = int;
enum : int
{
    ///Indicates that any string is allowed.
    USER_INPUT_DEFAULT      = 0x00000000,
    ///Indicates that the string will not accept characters that are illegal in file or directory names (such as * or
    ////).
    USER_INPUT_PATH_ELEMENT = 0x00000001,
}

///The <code>ERROR_ADVISE_MESSAGE_TYPE</code> enumeration type indicates the type of error values that can be passed to
///the <i>nMessageType</i> parameter of IPhotoAcquireProgressCB::ErrorAdvise.
alias ERROR_ADVISE_MESSAGE_TYPE = int;
enum : int
{
    ///Specifies that the error that occurred requires a Skip, Retry, or Cancel response. The <i>pnErrorAdviseResult</i>
    ///parameter to IPhotoAcquireProgressDialogCB::ErrorAdvise must be one of the following:
    ///<b>PHOTOACQUIRE_RESULT_SKIP</b>, <b>PHOTOACQUIRE_RESULT_SKIP_ALL</b>, <b>PHOTOACQUIRE_RESULT_RETRY</b>, or
    ///<b>PHOTOACQUIRE_RESULT_ABORT</b>.
    PHOTOACQUIRE_ERROR_SKIPRETRYCANCEL = 0x00000000,
    ///Specifies that the error that occurred requires a Retry or Cancel response. The <i>pnErrorAdviseResult</i>
    ///parameter to IPhotoAcquireProgressDialogCB::ErrorAdvise must be one of the following:
    ///<b>PHOTOACQUIRE_RESULT_RETRY</b> or <b>PHOTOACQUIRE_RESULT_ABORT</b>.
    PHOTOACQUIRE_ERROR_RETRYCANCEL     = 0x00000001,
    ///Specifies that the error that occurred requires a Yes or No response. The <i>pnErrorAdviseResult</i> parameter to
    ///IPhotoAcquireProgressDialogCB::ErrorAdvise must be one of the following: <b>PHOTOACQUIRE_RESULT_YES</b> or
    ///<b>PHOTOACQUIRE_RESULT_NO</b>.
    PHOTOACQUIRE_ERROR_YESNO           = 0x00000002,
    ///Specifies that the error that occurred requires an OK response. The <i>pnErrorAdviseResult</i> parameter to
    ///IPhotoAcquireProgressDialogCB::ErrorAdvise must be <b>PHOTOACQUIRE_RESULT_OK</b>.
    PHOTOACQUIRE_ERROR_OK              = 0x00000003,
}

///The <code>ERROR_ADVISE_RESULT</code> enumeration type indicates the type of error values that can be assigned to the
///<i>pnErrorAdviseResult</i> parameter of IPhotoAcquireProgressCB::ErrorAdvise.
alias ERROR_ADVISE_RESULT = int;
enum : int
{
    ///Specifies a Yes response to an error dialog. Valid only if the <i>nMessageType</i> parameter to
    ///IPhotoAcquireProgressCB::ErrorAdvise is PHOTOACQUIRE_ERROR_YESNO.
    PHOTOACQUIRE_RESULT_YES      = 0x00000000,
    ///Specifies a No response to an error dialog. Valid only if the <i>nMessageType</i> parameter to
    ///IPhotoAcquireProgressCB::ErrorAdvise is PHOTOACQUIRE_ERROR_YESNO.
    PHOTOACQUIRE_RESULT_NO       = 0x00000001,
    ///Specifies an OK response to an error dialog. Valid only if the <i>nMessageType</i> parameter to
    ///IPhotoAcquireProgressCB::ErrorAdvise is PHOTOACQUIRE_ERROR_OK.
    PHOTOACQUIRE_RESULT_OK       = 0x00000002,
    ///Specifies a Skip response to an error dialog. Valid only if the <i>nMessageType</i> parameter to
    ///IPhotoAcquireProgressCB::ErrorAdvise is PHOTOACQUIRE_ERROR_SKIPRETRYCANCEL.
    PHOTOACQUIRE_RESULT_SKIP     = 0x00000003,
    ///Specifies a Skip All response to an error dialog. Valid only if the <i>nMessageType</i> parameter to
    ///IPhotoAcquireProgressCB::ErrorAdvise is PHOTOACQUIRE_ERROR_SKIPRETRYCANCEL.
    PHOTOACQUIRE_RESULT_SKIP_ALL = 0x00000004,
    ///Specifies a Retry response to an error dialog. Valid only if the <i>nMessageType</i> parameter to
    ///IPhotoAcquireProgressCB::ErrorAdvise is PHOTOACQUIRE_ERROR_SKIPRETRYCANCEL or PHOTOACQUIRE_ERROR_RETRYCANCEL.
    PHOTOACQUIRE_RESULT_RETRY    = 0x00000005,
    ///Specifies a Cancel response to an error dialog. Valid only if the <i>nMessageType</i> parameter to
    ///IPhotoAcquireProgressCB::ErrorAdvise is PHOTOACQUIRE_ERROR_SKIPRETRYCANCEL or PHOTOACQUIRE_ERROR_RETRYCANCEL.
    PHOTOACQUIRE_RESULT_ABORT    = 0x00000006,
}

///The <code>PROGRESS_DIALOG_IMAGE_TYPE</code> enumeration type indicates the image type set in
///IPhotoProgressDialog::SetImage.
alias PROGRESS_DIALOG_IMAGE_TYPE = int;
enum : int
{
    ///Specifies the small icon used in the title bar (normally 16 x 16 pixels).
    PROGRESS_DIALOG_ICON_SMALL       = 0x00000000,
    ///Specifies the icon used to represent the progress dialog box in ALT+TAB key combination windows (normally 32 x 32
    ///pixels).
    PROGRESS_DIALOG_ICON_LARGE       = 0x00000001,
    ///Specifies an icon used in place of the thumbnail (up to 128 x 128 pixels).
    PROGRESS_DIALOG_ICON_THUMBNAIL   = 0x00000002,
    ///Specifies a bitmap thumbnail (up to 128 x 128 pixels, although it will be scaled to fit if it is too large).
    PROGRESS_DIALOG_BITMAP_THUMBNAIL = 0x00000003,
}

///The <code>PROGRESS_DIALOG_CHECKBOX_ID</code> enumeration type indicates the check box on the IPhotoProgressDialog
///object.
alias PROGRESS_DIALOG_CHECKBOX_ID = int;
enum : int
{
    ///Specifies PROGRESS_DIALOG_CHECKBOX_ID_DEFAULT .
    PROGRESS_DIALOG_CHECKBOX_ID_DEFAULT = 0x00000000,
}

///The <code>DEVICE_SELECTION_DEVICE_TYPE</code> enumeration type indicates the type of a selected device.
alias DEVICE_SELECTION_DEVICE_TYPE = int;
enum : int
{
    ///Specifies that the type of the selected device is unknown.
    DST_UNKNOWN_DEVICE = 0x00000000,
    ///Specifies that the type of the selected device is Windows Portable Devices (WPD).
    DST_WPD_DEVICE     = 0x00000001,
    ///Specifies that the type of the selected device is Windows Image Acquisition (WIA).
    DST_WIA_DEVICE     = 0x00000002,
    ///Specifies that the type of the selected device is Still Image Architecture (STI).
    DST_STI_DEVICE     = 0x00000003,
    ///Not supported.
    DSF_TWAIN_DEVICE   = 0x00000004,
    ///Specifies that the selected device is a removable drive in the file system.
    DST_FS_DEVICE      = 0x00000005,
    DST_DV_DEVICE      = 0x00000006,
}

// Interfaces

@GUID("00F26E02-E9F2-4A9F-9FDD-5A962FB26A98")
struct PhotoAcquire;

@GUID("00F20EB5-8FD6-4D9D-B75E-36801766C8F1")
struct PhotoAcquireAutoPlayDropTarget;

@GUID("00F2B433-44E4-4D88-B2B0-2698A0A91DBA")
struct PhotoAcquireAutoPlayHWEventHandler;

@GUID("00F210A1-62F0-438B-9F7E-9618D72A1831")
struct PhotoAcquireOptionsDialog;

@GUID("00F24CA0-748F-4E8A-894F-0E0357C6799F")
struct PhotoProgressDialog;

@GUID("00F29A34-B8A1-482C-BCF8-3AC7B0FE8F62")
struct PhotoAcquireDeviceSelectionDialog;

///The <code>IPhotoAcquireItem</code> interface provides methods for working with items as they are acquired from a
///device.
@GUID("00F21C97-28BF-4C02-B842-5E4E90139A30")
interface IPhotoAcquireItem : IUnknown
{
    ///The <code>GetItemName</code> method retrieves the file name for an item.
    ///Params:
    ///    pbstrItemName = Pointer to a string containing the name of the item.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetItemName(BSTR* pbstrItemName);
    ///The <code>GetThumbnail</code> method retrieves the thumbnail provided for an item.
    ///Params:
    ///    sizeThumbnail = Specifies the size of the thumbnail.
    ///    phbmpThumbnail = Specifies a handle to the thumbnail bitmap.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetThumbnail(SIZE sizeThumbnail, HBITMAP* phbmpThumbnail);
    ///The <code>GetProperty</code> method retrieves the value of a property of an item.
    ///Params:
    ///    key = Specifies a key for the property.
    ///    pv = Pointer to a property variant containing the property value.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetProperty(const(PROPERTYKEY)* key, PROPVARIANT* pv);
    ///The <code>SetProperty</code> method sets a property for an item.
    ///Params:
    ///    key = Specifies a key for the property to set.
    ///    pv = Pointer to a property variant containing the value to set the property to.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetProperty(const(PROPERTYKEY)* key, const(PROPVARIANT)* pv);
    ///The <code>GetStream</code> method retrieves a read-only stream containing the contents of an item.
    ///Params:
    ///    ppStream = Returns a stream object with the file contents.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetStream(IStream* ppStream);
    ///The <code>CanDelete</code> method indicates whether an item may be deleted.
    ///Params:
    ///    pfCanDelete = Pointer to a flag that, when set to <b>TRUE</b>, indicates that the item can be deleted.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT CanDelete(int* pfCanDelete);
    ///The <code>Delete</code> method deletes an item.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Delete();
    ///The <code>GetSubItemCount</code> method retrieves the number of subitems contained in an item.
    ///Params:
    ///    pnCount = Pointer to an integer containing the count of subitems.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetSubItemCount(uint* pnCount);
    ///The <code>GetSubItemAt</code> method retrieves a subitem of an item, given the index of the subitem.
    ///Params:
    ///    nItemIndex = Integer containing the index of the item.
    ///    ppPhotoAcquireItem = Returns the IPhotoAcquireItem object at the given index.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetSubItemAt(uint nItemIndex, IPhotoAcquireItem* ppPhotoAcquireItem);
}

///The <b>IUserInputString</b> interface represents the object created when asking the user for a string—for example,
///when obtaining the name of a tag.
@GUID("00F243A1-205B-45BA-AE26-ABBC53AA7A6F")
interface IUserInputString : IUnknown
{
    ///The <code>GetSubmitButtonText</code> method retrieves the text for the submit button.
    ///Params:
    ///    pbstrSubmitButtonText = Pointer to a string containing the submit button text.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A <b>NULL</b> pointer was passed where a
    ///    non-<b>NULL</b> pointer is expected. </td> </tr> </table>
    ///    
    HRESULT GetSubmitButtonText(BSTR* pbstrSubmitButtonText);
    ///The <code>GetPrompt</code> method retrieves the title of a prompt if the prompt is a modal dialog box.
    ///Params:
    ///    pbstrPromptTitle = Pointer to a string containing the title of the prompt.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A <b>NULL</b> pointer was passed where a
    ///    non-<b>NULL</b> pointer is expected. </td> </tr> </table>
    ///    
    HRESULT GetPrompt(BSTR* pbstrPromptTitle);
    ///The <b>GetStringId</b> method retrieves the unlocalized canonical name for the requested string. For example,
    ///when requesting a tag name, the canonical name might be "TagName".
    ///Params:
    ///    pbstrStringId = Pointer to a string containing the string identifier (ID).
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A <b>NULL</b> pointer was passed where a
    ///    non-<b>NULL</b> pointer is expected. </td> </tr> </table>
    ///    
    HRESULT GetStringId(BSTR* pbstrStringId);
    ///The <code>GetStringType</code> method retrieves a value indicating the type of string to obtain from the user.
    ///Params:
    ///    pnStringType = Pointer to an integer value containing the string type. <table> <tr> <th>Value </th> <th>Description </th>
    ///                   </tr> <tr> <td><b>USER_INPUT_DEFAULT</b></td> <td>Specifies that any string is allowed.</td> </tr> <tr>
    ///                   <td><b>USER_INPUT_PATH_ELEMENT</b></td> <td>Specifies that the string will not accept characters that are
    ///                   illegal in file or directory names (such as * or /).</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A <b>NULL</b> pointer was passed where a
    ///    non-<b>NULL</b> pointer is expected. </td> </tr> </table>
    ///    
    HRESULT GetStringType(USER_INPUT_STRING_TYPE* pnStringType);
    ///The <code>GetTooltipText</code> method retrieves the tooltip text displayed for a control.
    ///Params:
    ///    pbstrTooltipText = Pointer to a string containing the tooltip text.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A <b>NULL</b> pointer was passed where a
    ///    non-<b>NULL</b> pointer is expected. </td> </tr> </table>
    ///    
    HRESULT GetTooltipText(BSTR* pbstrTooltipText);
    ///The <code>GetMaxLength</code> method retrieves the maximum string length the user interface (UI) should allow.
    ///Params:
    ///    pcchMaxLength = Pointer to the size of the maximum string length in characters.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A <b>NULL</b> pointer was passed where a
    ///    non-<b>NULL</b> pointer is expected. </td> </tr> </table>
    ///    
    HRESULT GetMaxLength(uint* pcchMaxLength);
    ///The <code>GetDefault</code> method retrieves the default string used to initialize an edit control (or
    ///equivalent).
    ///Params:
    ///    pbstrDefault = Pointer to a string containing the default value used to initialize the edit control.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> The pointer passed was <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetDefault(BSTR* pbstrDefault);
    ///The <code>GetMruCount</code> method retrieves the number of items in the list of most recently used items.
    ///Params:
    ///    pnMruCount = Pointer to an integer value containing the number of items in the list of most recently used items.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A <b>NULL</b> pointer was passed where a
    ///    non-<b>NULL</b> pointer is expected. </td> </tr> </table>
    ///    
    HRESULT GetMruCount(uint* pnMruCount);
    ///The <code>GetMruEntryAt</code> method retrieves the entry at the given index in the most recently used list.
    ///Params:
    ///    nIndex = Integer containing the index at which to retrieve the entry.
    ///    pbstrMruEntry = Pointer to a string containing the most recently used entry.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A <b>NULL</b> pointer was passed where a
    ///    non-<b>NULL</b> pointer is expected. </td> </tr> </table>
    ///    
    HRESULT GetMruEntryAt(uint nIndex, BSTR* pbstrMruEntry);
    ///The <code>GetImage</code> method retrieves the default image used to initialize an edit control.
    ///Params:
    ///    nSize = Integer containing the size of the image.
    ///    phBitmap = Pointer to the handle that specifies the image bitmap.
    ///    phIcon = Pointer to the handle that specifies the image icon.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A <b>NULL</b> pointer was passed where a
    ///    non-<b>NULL</b> pointer is expected. </td> </tr> </table>
    ///    
    HRESULT GetImage(uint nSize, HBITMAP* phBitmap, HICON* phIcon);
}

///The <code>IPhotoAcquireProgressCB</code> interface may be implemented if you wish to do extra processing at various
///stages in the acquisition process.
@GUID("00F2CE1E-935E-4248-892C-130F32C45CB4")
interface IPhotoAcquireProgressCB : IUnknown
{
    ///The <code>Cancelled</code> method provides extended functionality when a cancellation occurs during an
    ///acquisition session. The application provides the implementation of the <code>Cancelled</code> method.
    ///Params:
    ///    pfCancelled = Pointer to a flag that, when set to <b>TRUE</b>, indicates that the operation was canceled.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Your implementation is not limited to the following return values. Any
    ///    failing HRESULT other than E_NOTIMPL is fatal and will cause the transfer to abort. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl>
    ///    </td> <td width="60%"> The method is not implemented. </td> </tr> </table>
    ///    
    HRESULT Cancelled(int* pfCancelled);
    ///The <code>StartEnumeration</code> method provides extended functionality when the enumeration of items to acquire
    ///begins. The application provides the implementation of the <code>StartEnumeration</code> method.
    ///Params:
    ///    pPhotoAcquireSource = Pointer to the IPhotoAcquireSource object that items are being enumerated from.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Your implementation is not limited to the following return values. Any
    ///    failing HRESULT other than E_NOTIMPL is fatal and will cause the transfer to abort. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl>
    ///    </td> <td width="60%"> The method is not implemented. </td> </tr> </table>
    ///    
    HRESULT StartEnumeration(IPhotoAcquireSource pPhotoAcquireSource);
    ///The <code>FoundItem</code> method provides extended functionality each time an item is found during enumeration
    ///of items from the device. This method can be used to exclude an item from the list of items to acquire. The
    ///application provides the implementation of the <code>FoundItem</code> method.
    ///Params:
    ///    pPhotoAcquireItem = Pointer to the found IPhotoAcquireItem object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Your implementation is not limited to the following return values. Any
    ///    failing HRESULT other than E_NOTIMPL is fatal and will cause the transfer to abort. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td>
    ///    <td width="60%"> Exclude this item from the list of files to acquire. </td> </tr> </table>
    ///    
    HRESULT FoundItem(IPhotoAcquireItem pPhotoAcquireItem);
    ///The <code>EndEnumeration</code> method provides extended functionality when enumeration of files from the image
    ///source is complete. The application provides the implementation of the <code>EndEnumeration</code> method.
    ///Params:
    ///    hr = Specifies the result of the enumeration operation.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Your implementation is not limited to the following return values. Any
    ///    failing HRESULT other than E_NOTIMPL is fatal and will cause the transfer to abort. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl>
    ///    </td> <td width="60%"> The method is not yet implemented </td> </tr> </table>
    ///    
    HRESULT EndEnumeration(HRESULT hr);
    ///The <code>StartTransfer</code> method provides additional processing when transfer of items from the device
    ///begins. The application provides the implementation of the <code>StartTransfer</code> method.
    ///Params:
    ///    pPhotoAcquireSource = Pointer to the IPhotoAcquireSource from which items are being retrieved.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Your implementation is not limited to the following return values. Any
    ///    Failing HRESULT other than E_NOTIMPL is fatal and will cause the transfer to abort. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl>
    ///    </td> <td width="60%"> The method is not implemented. </td> </tr> </table>
    ///    
    HRESULT StartTransfer(IPhotoAcquireSource pPhotoAcquireSource);
    ///The <code>StartItemTransfer</code> method provides extended functionality each time the transfer of an item
    ///begins. The application provides the implementation of the <code>StartItemTransfer</code> method.
    ///Params:
    ///    nItemIndex = Integer value containing the item index in the list of items to transfer.
    ///    pPhotoAcquireItem = Pointer to the IPhotoAcquireItem object that is to be transferred.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Your implementation is not limited to the following return values. Any
    ///    failing HRESULT other than E_NOTIMPL is fatal and will cause the transfer to abort. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl>
    ///    </td> <td width="60%"> The method is not implemented. </td> </tr> </table>
    ///    
    HRESULT StartItemTransfer(uint nItemIndex, IPhotoAcquireItem pPhotoAcquireItem);
    ///The <code>DirectoryCreated</code> method provides extended functionality when a destination directory is created
    ///during the acquisition process. The application provides the implementation of the <code>DirectoryCreated</code>
    ///method.
    ///Params:
    ///    pszDirectory = Pointer to a null-terminated string containing the directory.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Your implementation is not limited to the following return values. Any
    ///    failing HRESULT other than E_NOTIMPL is fatal and will cause the transfer to abort. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl>
    ///    </td> <td width="60%"> The method is not yet implemented. </td> </tr> </table>
    ///    
    HRESULT DirectoryCreated(const(wchar)* pszDirectory);
    ///The <code>UpdateTransferPercent</code> method provides extended functionality when the percentage of items
    ///transferred changes. The application provides the implementation of the <code>UpdateTransferPercent</code>
    ///method.
    ///Params:
    ///    fOverall = Flag that, when set to <b>TRUE</b>, indicates that the value contained in <i>nPercent</i> is a percentage of
    ///               the overall transfer progress, rather than a percentage of an individual item's progress.
    ///    nPercent = Integer value containing the percentage of items transferred.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Your implementation is not limited to the following return values. Any
    ///    failing HRESULT other than E_NOTIMPL is fatal and will cause the transfer to abort. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl>
    ///    </td> <td width="60%"> The method is not implemented. </td> </tr> </table>
    ///    
    HRESULT UpdateTransferPercent(BOOL fOverall, uint nPercent);
    ///The <code>EndItemTransfer</code> method provides extended functionality each time a file is transferred from the
    ///image source. The application provides the implementation of the <code>EndItemTransfer</code> method.
    ///Params:
    ///    nItemIndex = Integer value containing the item index.
    ///    pPhotoAcquireItem = Pointer to a photo acquire item object.
    ///    hr = Specifies the result of the transfer operation.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Your implementation is not limited to the following return values. Any
    ///    failing HRESULT other than E_NOTIMPL is fatal and will cause the transfer to abort. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl>
    ///    </td> <td width="60%"> The method is not yet implemented </td> </tr> </table>
    ///    
    HRESULT EndItemTransfer(uint nItemIndex, IPhotoAcquireItem pPhotoAcquireItem, HRESULT hr);
    ///The <code>EndTransfer</code> method provides extended functionality when the transfer of all files is complete.
    ///The application provides the implementation of the <code>EndTransfer</code> method.
    ///Params:
    ///    hr = Specifies the result of the transfer.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Your implementation is not limited to the following return values. Any
    ///    failing HRESULT other than E_NOTIMPL is fatal and will cause the transfer to abort. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl>
    ///    </td> <td width="60%"> The method is not yet implemented </td> </tr> </table>
    ///    
    HRESULT EndTransfer(HRESULT hr);
    ///The <code>StartDelete</code> method provides extended functionality when deletion of items from the device
    ///begins. The implementation of <code>StartDelete</code> is provided by the application.
    ///Params:
    ///    pPhotoAcquireSource = Pointer to the IPhotoAcquireSource that items are being deleted from.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Your implementation is not limited to the following return values. Any
    ///    failing HRESULT other than E_NOTIMPL is fatal and will cause the transfer to abort. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl>
    ///    </td> <td width="60%"> The method is not yet implemented </td> </tr> </table>
    ///    
    HRESULT StartDelete(IPhotoAcquireSource pPhotoAcquireSource);
    ///The <code>StartItemDelete</code> method provides extended functionality each time the deletion of an individual
    ///item from the device begins. The application provides the implementation of the <code>StartItemDelete</code>
    ///method.
    ///Params:
    ///    nItemIndex = Integer value containing the item index in the list of items to delete.
    ///    pPhotoAcquireItem = Pointer to the IPhotoAcquireItem object that is being deleted.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Your implementation is not limited to the following return values. Any
    ///    failing HRESULT other than E_NOTIMPL is fatal and will cause the transfer to abort. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl>
    ///    </td> <td width="60%"> The method is not implemented. </td> </tr> </table>
    ///    
    HRESULT StartItemDelete(uint nItemIndex, IPhotoAcquireItem pPhotoAcquireItem);
    ///The <code>UpdateDeletePercent</code> method provides extended functionality when the percentage of items deleted
    ///changes. The application provides the implementation of the <code>UpdateDeletePercent</code> method.
    ///Params:
    ///    nPercent = Integer value containing the percentage of items deleted.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Your implementation is not limited to the following return values. Any
    ///    failing HRESULT other than E_NOTIMPL is fatal and will cause the transfer to abort. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl>
    ///    </td> <td width="60%"> The method is not implemented </td> </tr> </table>
    ///    
    HRESULT UpdateDeletePercent(uint nPercent);
    ///The <code>EndItemDelete</code> method provides extended functionality each time a file is deleted from the image
    ///source. The application provides the implementation of the <code>EndItemDelete</code> method.
    ///Params:
    ///    nItemIndex = Integer value containing the item index.
    ///    pPhotoAcquireItem = Pointer to the deleted IPhotoAcquireItem object.
    ///    hr = Specifies the result of the delete operation.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Your implementation is not limited to the following return values. Any
    ///    failing HRESULT other than E_NOTIMPL is fatal and will cause the transfer to abort. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl>
    ///    </td> <td width="60%"> This method is not yet implemented </td> </tr> </table>
    ///    
    HRESULT EndItemDelete(uint nItemIndex, IPhotoAcquireItem pPhotoAcquireItem, HRESULT hr);
    ///The <code>EndDelete</code> method provides extended functionality when deletion of files from the image source is
    ///complete. The application provides the implementation of the <code>EndDelete</code> method.
    ///Params:
    ///    hr = Specifies the result of the delete operation.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Your implementation is not limited to the following return values. Any
    ///    failing HRESULT other than E_NOTIMPL is fatal and will cause the transfer to abort. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl>
    ///    </td> <td width="60%"> The method is not yet implemented </td> </tr> </table>
    ///    
    HRESULT EndDelete(HRESULT hr);
    ///The <code>EndSession</code> method provides extended functionality when an acquisition session is completed. The
    ///application provides the implementation of the <code>EndSession</code> method.
    ///Params:
    ///    hr = Specifies the result of the acquisition.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Your implementation is not limited to the following return values. Any
    ///    failing HRESULT other than E_NOTIMPL is fatal and will cause the transfer to abort. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl>
    ///    </td> <td width="60%"> The method is not yet implemented </td> </tr> </table>
    ///    
    HRESULT EndSession(HRESULT hr);
    ///The <code>GetDeleteAfterAcquire</code> method returns a value indicating whether photos should be deleted after
    ///acquisition.
    ///Params:
    ///    pfDeleteAfterAcquire = Pointer to a flag that, when set to <b>TRUE</b>, indicates that photos should be deleted after acquisition.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Your implementation is not limited to the following return values. Any
    ///    failing HRESULT other than E_NOTIMPL is fatal and will cause the transfer to abort. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl>
    ///    </td> <td width="60%"> The method is not yet implemented </td> </tr> </table>
    ///    
    HRESULT GetDeleteAfterAcquire(int* pfDeleteAfterAcquire);
    ///The <code>ErrorAdvise</code> method provides custom error handling for errors that occur during acquisition. The
    ///application provides the implementation of the <code>ErrorAdvise</code> method.
    ///Params:
    ///    hr = Specifies the error that occurred.
    ///    pszErrorMessage = Pointer to a null-terminated string containing the error message.
    ///    nMessageType = Integer value containing the message type. May be one of the following. <table> <tr> <th>Value </th>
    ///                   <th>Description </th> </tr> <tr> <td><b>PHOTOACQUIRE_ERROR_SKIPRETRYCANCEL </b></td> <td>Specifies that the
    ///                   error that occurred requires a Skip, Retry, or Cancel response. The <i>pnErrorAdviseResult</i> parameter must
    ///                   be set to one of the following: <b>PHOTOACQUIRE_RESULT_SKIP</b>, <b>PHOTOACQUIRE_RESULT_SKIP_ALL</b>,
    ///                   <b>PHOTOACQUIRE_RESULT_RETRY</b>, or <b>PHOTOACQUIRE_RESULT_ABORT</b>.</td> </tr> <tr>
    ///                   <td><b>PHOTOACQUIRE_ERROR_RETRYCANCEL</b></td> <td>Specifies that the error that occurred requires a Retry or
    ///                   Cancel response. The <i>pnErrorAdviseResult</i> parameter must be set to one of the following:
    ///                   <b>PHOTOACQUIRE_RESULT_RETRY</b> or <b>PHOTOACQUIRE_RESULT_ABORT</b>.</td> </tr> <tr>
    ///                   <td><b>PHOTOACQUIRE_ERROR_YESNO</b></td> <td>Specifies that the error that occurred requires a Yes or No
    ///                   response. The <i>pnErrorAdviseResult</i> parameter must be set to one of the following:
    ///                   <b>PHOTOACQUIRE_RESULT_YES</b> or <b>PHOTOACQUIRE_RESULT_NO</b>.</td> </tr> <tr>
    ///                   <td><b>PHOTOACQUIRE_ERROR_OK</b></td> <td>Specifies that the error that occurred requires an OK response. The
    ///                   <i>pnErrorAdviseResult</i> parameter must be set to <b>PHOTOACQUIRE_RESULT_OK</b>.</td> </tr> </table>
    ///    pnErrorAdviseResult = Pointer to an integer value containing the error advise result. The result should be one of the acceptable
    ///                          types indicated by the <i>nMessageType</i> parameter, and must be one of the following: <table> <tr>
    ///                          <th>Value </th> <th>Description </th> </tr> <tr> <td><b>PHOTOACQUIRE_RESULT_YES</b></td> <td>Specifies a Yes
    ///                          response. Valid if <i>nMessageType</i> is <b>PHOTOACQUIRE_ERROR_YESNO</b>.</td> </tr> <tr>
    ///                          <td><b>PHOTOACQUIRE_RESULT_NO</b></td> <td>Specifies a No response. Valid if <i>nMessageType</i> is
    ///                          <b>PHOTOACQUIRE_ERROR_YESNO</b>.</td> </tr> <tr> <td><b>PHOTOACQUIRE_RESULT_OK</b></td> <td>Specifies an OK
    ///                          response. Valid if <i>nMessageType</i> is <b>PHOTOACQUIRE_ERROR_OK</b>.</td> </tr> <tr>
    ///                          <td><b>PHOTOACQUIRE_RESULT_SKIP</b></td> <td>Specifies a Skip response. Valid if <i>nMessageType</i> is
    ///                          <b>PHOTOACQUIRE_ERROR_SKIPRETRYCANCEL</b>.</td> </tr> <tr> <td><b>PHOTOACQUIRE_RESULT_SKIP_ALL</b></td>
    ///                          <td>Specifies a Skip All response. Valid if <i>nMessageType</i> is
    ///                          <b>PHOTOACQUIRE_ERROR_SKIPRETRYCANCEL</b>.</td> </tr> <tr> <td><b>PHOTOACQUIRE_RESULT_RETRY</b></td>
    ///                          <td>Specifies a Retry response. Valid if <i>nMessageType</i> is <b>PHOTOACQUIRE_ERROR_SKIPRETRYCANCEL</b> or
    ///                          <b>PHOTOACQUIRE_ERROR_RETRYCANCEL</b>.</td> </tr> <tr> <td><b>PHOTOACQUIRE_RESULT_ABORT</b></td>
    ///                          <td>Specifies a Cancel response. Valid if <i>nMessageType</i> is <b>PHOTOACQUIRE_ERROR_SKIPRETRYCANCEL</b> or
    ///                          <b>PHOTOACQUIRE_ERROR_RETRYCANCEL</b>.</td> </tr> </table>
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Your implementation is not limited to the following return values. Any
    ///    failing HRESULT other than E_NOTIMPL is fatal and will cause the transfer to abort. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl>
    ///    </td> <td width="60%"> The method is not yet implemented </td> </tr> </table>
    ///    
    HRESULT ErrorAdvise(HRESULT hr, const(wchar)* pszErrorMessage, ERROR_ADVISE_MESSAGE_TYPE nMessageType, 
                        ERROR_ADVISE_RESULT* pnErrorAdviseResult);
    ///The <code>GetUserInput</code> method overrides the default functionality that displays a message prompting the
    ///user for string input during acquisition. The application provides the implementation of the
    ///<code>GetUserInput</code> method.
    ///Params:
    ///    riidType = Specifies the interface ID of the prompt type. This may only be IID_IUserInputString.
    ///    pUnknown = Pointer to an object of the prompt class. Currently, this must be an IUserInputString object.
    ///    pPropVarResult = Pointer to a property variant object representing the descriptive input to be obtained. Must be freed by the
    ///                     caller using PropVariantClear. If the application's implementation of <code>GetUserInput</code> returns a
    ///                     value other than E_NOTIMPL, the value of <i>pPropVarDefault</i> must be copied to the <i>pPropVarResult</i>
    ///                     parameter.
    ///    pPropVarDefault = Pointer to a property variant object representing the default value of the input being requested.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Your implementation is not limited to the following return values. Any
    ///    failing HRESULT other than E_NOTIMPL is fatal and will cause the transfer to abort. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl>
    ///    </td> <td width="60%"> Return E_NOTIMPL if the default functionality is desired </td> </tr> </table>
    ///    
    HRESULT GetUserInput(const(GUID)* riidType, IUnknown pUnknown, PROPVARIANT* pPropVarResult, 
                         const(PROPVARIANT)* pPropVarDefault);
}

@GUID("00F242D0-B206-4E7D-B4C1-4755BCBB9C9F")
interface IPhotoProgressActionCB : IUnknown
{
    HRESULT DoAction(HWND hWndParent);
}

///Provides the progress dialog box that may be displayed when enumerating or importing images. The dialog box is modal
///and runs in its own thread.
@GUID("00F246F9-0750-4F08-9381-2CD8E906A4AE")
interface IPhotoProgressDialog : IUnknown
{
    ///The <code>Create</code> method creates and displays a progress dialog box that can be shown during image
    ///enumeration and acquisition.
    ///Params:
    ///    hwndParent = Handle of the parent window.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Create(HWND hwndParent);
    ///The <code>GetWindow</code> method retrieves the handle to the progress dialog box.
    ///Params:
    ///    phwndProgressDialog = Specifies the handle to the progress dialog box.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Pointer passed was <b>NULL</b> </td> </tr>
    ///    </table>
    ///    
    HRESULT GetWindow(HWND* phwndProgressDialog);
    ///The <code>Destroy</code> method closes and disposes of the progress dialog box shown during image enumeration and
    ///acquisition.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Destroy();
    ///The <code>SetTitle</code> method sets the title of the progress dialog box.
    ///Params:
    ///    pszTitle = Pointer to a null-terminated string containing the title.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetTitle(const(wchar)* pszTitle);
    ///The <code>ShowCheckbox</code> method indicates whether to show the check box in the progress dialog box
    ///indicating whether to delete images after transfer.
    ///Params:
    ///    nCheckboxId = Integer containing the check box identifier (ID).
    ///    fShow = Flag that, when set to <b>TRUE</b>, indicates that the check box will appear.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT ShowCheckbox(PROGRESS_DIALOG_CHECKBOX_ID nCheckboxId, BOOL fShow);
    ///The <code>SetCheckboxText</code> method sets the text for the check box in the progress dialog box indicating
    ///whether to delete images after transfer.
    ///Params:
    ///    nCheckboxId = Integer containing the check box identifier (ID).
    ///    pszCheckboxText = Pointer to a null-terminated string containing the check box text.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetCheckboxText(PROGRESS_DIALOG_CHECKBOX_ID nCheckboxId, const(wchar)* pszCheckboxText);
    HRESULT SetCheckboxCheck(PROGRESS_DIALOG_CHECKBOX_ID nCheckboxId, BOOL fChecked);
    ///The <code>SetCheckboxTooltip</code> method sets the tooltip text for the check box in the progress dialog box.
    ///Params:
    ///    nCheckboxId = Integer containing the check box identifier (ID).
    ///    pszCheckboxTooltipText = Pointer to a null-terminated string containing the check box tooltip text.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetCheckboxTooltip(PROGRESS_DIALOG_CHECKBOX_ID nCheckboxId, const(wchar)* pszCheckboxTooltipText);
    ///The <code>IsCheckboxChecked</code> method indicates whether the check box in the progress dialog box (typically
    ///indicating whether to delete files after transfer) is selected.
    ///Params:
    ///    nCheckboxId = Integer value containing the check box identifier (ID).
    ///    pfChecked = Pointer to a flag that, if set to <b>TRUE</b>, indicates that the check box is selected.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A <b>NULL</b> pointer was passed where a
    ///    non-<b>NULL</b> pointer was expected. </td> </tr> </table>
    ///    
    HRESULT IsCheckboxChecked(PROGRESS_DIALOG_CHECKBOX_ID nCheckboxId, int* pfChecked);
    ///Sets the caption of the progress dialog box.
    ///Params:
    ///    pszTitle = Pointer to a null-terminated string containing the title of the progress dialog box.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetCaption(const(wchar)* pszTitle);
    ///Sets either the thumbnail image displayed in the progress dialog box, the icon in the title bar of the progress
    ///dialog box, or the icon in ALT+TAB key combination windows.
    ///Params:
    ///    nImageType = Integer value indicating the image type to set. Only one type of image type may be set at a time. The values
    ///                 passed to this parameter should not be considered a bit field and may not be combined with bitwise OR.
    ///                 <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///                 id="PROGRESS_DIALOG_ICON_SMALL"></a><a id="progress_dialog_icon_small"></a><dl>
    ///                 <dt><b>PROGRESS_DIALOG_ICON_SMALL</b></dt> </dl> </td> <td width="60%"> The small icon used in the title bar
    ///                 (normally 16 x 16 pixels). </td> </tr> <tr> <td width="40%"><a id="PROGRESS_DIALOG_ICON_LARGE"></a><a
    ///                 id="progress_dialog_icon_large"></a><dl> <dt><b>PROGRESS_DIALOG_ICON_LARGE</b></dt> </dl> </td> <td
    ///                 width="60%"> The icon used to represent the progress dialog box in Alt-Tab windows (normally 32 x 32 pixels).
    ///                 </td> </tr> <tr> <td width="40%"><a id="PROGRESS_DIALOG_ICON_THUMBNAIL"></a><a
    ///                 id="progress_dialog_icon_thumbnail"></a><dl> <dt><b>PROGRESS_DIALOG_ICON_THUMBNAIL</b></dt> </dl> </td> <td
    ///                 width="60%"> An icon used in place of the thumbnail (up to 128 x 128 pixels). </td> </tr> <tr> <td
    ///                 width="40%"><a id="PROGRESS_DIALOG_BITMAP_THUMBNAIL"></a><a id="progress_dialog_bitmap_thumbnail"></a><dl>
    ///                 <dt><b>PROGRESS_DIALOG_BITMAP_THUMBNAIL</b></dt> </dl> </td> <td width="60%"> A bitmap thumbnail (up to 128 x
    ///                 128 pixels, although it will be scaled to fit if it is too large). </td> </tr> </table>
    ///    hIcon = Handle to an icon object.
    ///    hBitmap = Handle to a bitmap object representing the thumbnail image.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetImage(PROGRESS_DIALOG_IMAGE_TYPE nImageType, HICON hIcon, HBITMAP hBitmap);
    ///The <code>SetPercentComplete</code> method sets a value indicating the completed portion of the current
    ///operation.
    ///Params:
    ///    nPercent = Integer value indicating the percentage of the operation that has completed. This value may be between 0 and
    ///               100 only.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetPercentComplete(int nPercent);
    ///The <code>SetProgressText</code> method sets the text for the progress bar in the progress dialog box.
    ///Params:
    ///    pszProgressText = Pointer to a null-terminated string containing the progress text.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetProgressText(const(wchar)* pszProgressText);
    HRESULT SetActionLinkCallback(IPhotoProgressActionCB pPhotoProgressActionCB);
    HRESULT SetActionLinkText(const(wchar)* pszCaption);
    HRESULT ShowActionLink(BOOL fShow);
    ///The <code>IsCancelled</code> method indicates whether the operation has been canceled via the progress dialog
    ///box.
    ///Params:
    ///    pfCancelled = Pointer to a flag that, if set to <b>TRUE</b>, indicates the action has been canceled.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A <b>NULL</b> pointer was passed </td> </tr>
    ///    </table>
    ///    
    HRESULT IsCancelled(int* pfCancelled);
    ///Retrieves descriptive information entered by the user, such as the tag name of the images to store.
    ///Params:
    ///    riidType = Specifies the interface identifier (ID) of the prompt type. Currently, the only supported value is
    ///               IID_IUserInputString.
    ///    pUnknown = Pointer to an object of the prompt class. Currently, the only supported type is IUserInputString.
    ///    pPropVarResult = Pointer to a property variant that stores the user input. Must be freed by the caller using
    ///                     <b>ClearPropVariant</b>.
    ///    pPropVarDefault = Pointer to a property variant containing the default value to be used if no input is supplied.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The progress dialog has been suppressed </td> </tr>
    ///    </table>
    ///    
    HRESULT GetUserInput(const(GUID)* riidType, IUnknown pUnknown, PROPVARIANT* pPropVarResult, 
                         const(PROPVARIANT)* pPropVarDefault);
}

///The <code>IPhotoAcquireSource</code> interface is used for acquisition of items from a device.
@GUID("00F2C703-8613-4282-A53B-6EC59C5883AC")
interface IPhotoAcquireSource : IUnknown
{
    ///The <code>GetFriendlyName</code> method retrieves the name of the device, formatted for display.
    ///Params:
    ///    pbstrFriendlyName = Pointer to a string containing the friendly name.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A null value was passed where non-null is
    ///    expected. </td> </tr> </table>
    ///    
    HRESULT GetFriendlyName(BSTR* pbstrFriendlyName);
    ///The <code>GetDeviceIcons</code> method retrieves the icons that are used to represent the device.
    ///Params:
    ///    nSize = Integer value containing the size of the icon to retrieve.
    ///    phLargeIcon = Specifies the large icon used for the device.
    ///    phSmallIcon = Specifies the small icon used for the device.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A null pointer was passed where non-null was
    ///    expected. </td> </tr> </table>
    ///    
    HRESULT GetDeviceIcons(uint nSize, HICON* phLargeIcon, HICON* phSmallIcon);
    ///The <code>InitializeItemList</code> method enumerates transferable items on the device and passes each item to
    ///the optional progress callback, if it is supplied.
    ///Params:
    ///    fForceEnumeration = Flag that, if set to <b>TRUE</b>, indicates that enumeration will be repeated even if the item list has
    ///                        already been initialized. If set to <b>FALSE</b>, this flag indicates that repeated calls to
    ///                        <code>InitializeItemList</code> after the item list has already been initialized will not enumerate items
    ///                        again.
    ///    pPhotoAcquireProgressCB = Optional. Pointer to an IPhotoAcquireProgressCB object.
    ///    pnItemCount = Returns the number of items found.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Non-<b>NULL</b> pointer was expected. </td> </tr>
    ///    </table>
    ///    
    HRESULT InitializeItemList(BOOL fForceEnumeration, IPhotoAcquireProgressCB pPhotoAcquireProgressCB, 
                               uint* pnItemCount);
    ///The <code>GetItemCount</code> method retrieves the number of items found by the InitializeItemList method.
    ///Params:
    ///    pnItemCount = Pointer to an integer value containing the item count.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> NULL was passed where a non-NULL pointer was
    ///    expected. </td> </tr> </table>
    ///    
    HRESULT GetItemCount(uint* pnItemCount);
    ///The <code>GetItemAt</code> method retrieves the IPhotoAcquireItem object at the given index in the list of items.
    ///Params:
    ///    nIndex = Integer value containing the index.
    ///    ppPhotoAcquireItem = Pointer to the address of an IPhotoAcquireItem object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetItemAt(uint nIndex, IPhotoAcquireItem* ppPhotoAcquireItem);
    ///The <code>GetPhotoAcquireSettings</code> method obtains an IPhotoAcquireSettings object for working with
    ///acquisition settings.
    ///Params:
    ///    ppPhotoAcquireSettings = Pointer to the address of a photo acquire settings object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Null value passed where non-null is expected.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetPhotoAcquireSettings(IPhotoAcquireSettings* ppPhotoAcquireSettings);
    ///The <code>GetDeviceId</code> method retrieves the identifier (ID) of the device.
    ///Params:
    ///    pbstrDeviceId = Pointer to a string containing the device ID.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetDeviceId(BSTR* pbstrDeviceId);
    HRESULT BindToObject(const(GUID)* riid, void** ppv);
}

///The <code>IPhotoAcquire</code> interface provides methods for acquiring photos from a device.
@GUID("00F23353-E31B-4955-A8AD-CA5EBF31E2CE")
interface IPhotoAcquire : IUnknown
{
    ///The <code>CreatePhotoSource</code> method initializes an IPhotoAcquireSource object to pass to
    ///IPhotoAcquire::Acquire.
    ///Params:
    ///    pszDevice = Pointer to a null-terminated string containing the device name.
    ///    ppPhotoAcquireSource = Returns the initialized photo source to acquire photos from.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A non-<b>NULL</b> pointer was expected. </td>
    ///    </tr> </table>
    ///    
    HRESULT CreatePhotoSource(const(wchar)* pszDevice, IPhotoAcquireSource* ppPhotoAcquireSource);
    ///The <code>Acquire</code> method acquires photos from a device.
    ///Params:
    ///    pPhotoAcquireSource = Pointer to an IPhotoAcquireSource object representing the device from which to acquire photos. Initialize
    ///                          this object by calling CreatePhotoSource.
    ///    fShowProgress = Flag that, when set to <b>TRUE</b>, indicates that a progress dialog will be shown.
    ///    hWndParent = Handle to a parent window.
    ///    pszApplicationName = Pointer to a null-terminated string containing the application name.
    ///    pPhotoAcquireProgressCB = Pointer to an optional IPhotoAcquireProgressCB object.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> Non-<b>NULL</b> pointer was expected. </td> </tr>
    ///    </table>
    ///    
    HRESULT Acquire(IPhotoAcquireSource pPhotoAcquireSource, BOOL fShowProgress, HWND hWndParent, 
                    const(wchar)* pszApplicationName, IPhotoAcquireProgressCB pPhotoAcquireProgressCB);
    ///The <code>EnumResults</code> method retrieves an enumeration containing the paths of all files successfully
    ///transferred during the most recent call to Acquire.
    ///Params:
    ///    ppEnumFilePaths = Returns an enumeration containing the paths to all the transferred files.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A non-<b>NULL</b> pointer was expected. </td>
    ///    </tr> </table>
    ///    
    HRESULT EnumResults(IEnumString* ppEnumFilePaths);
}

///The <code>IPhotoAcquireSettings</code> interface is used to work with image acquisition settings, such as file name
///format.
@GUID("00F2B868-DD67-487C-9553-049240767E91")
interface IPhotoAcquireSettings : IUnknown
{
    ///The <code>InitializeFromRegistry</code> method specifies a registry key from which to initialize settings.
    ///Params:
    ///    pszRegistryKey = Pointer to a null-terminated string containing the registry key.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> This method is not yet implemented. </td> </tr>
    ///    </table>
    ///    
    HRESULT InitializeFromRegistry(const(wchar)* pszRegistryKey);
    ///The <code>SetFlags</code> method sets the photo acquire flags.
    ///Params:
    ///    dwPhotoAcquireFlags = Double word value containing the photo acquire flags.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetFlags(uint dwPhotoAcquireFlags);
    ///The <code>SetOutputFilenameTemplate</code> method specifies a format string (template) that specifies the format
    ///of file names.
    ///Params:
    ///    pszTemplate = Pointer to a null-terminated string containing the format string.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetOutputFilenameTemplate(const(wchar)* pszTemplate);
    ///The <code>SetSequencePaddingWidth</code> method sets a value indicating how wide sequential fields in filenames
    ///will be.
    ///Params:
    ///    dwWidth = Double word value containing the width of sequential fields.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetSequencePaddingWidth(uint dwWidth);
    ///The <code>SetSequenceZeroPadding</code> method sets a value indicating whether zeros or spaces are used to pad
    ///sequential file names.
    ///Params:
    ///    fZeroPad = Flag that, if set to <b>TRUE</b>, indicates that zeros pad sequential file names.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetSequenceZeroPadding(BOOL fZeroPad);
    ///The <code>SetGroupTag</code> method sets the group tag for an acquisition session.
    ///Params:
    ///    pszGroupTag = Pointer to a null-terminated string containing the group tag.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetGroupTag(const(wchar)* pszGroupTag);
    ///The <code>SetAcquisitionTime</code> method sets the acquisition time explicitly.
    ///Params:
    ///    pftAcquisitionTime = Specifies the acquisition time.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetAcquisitionTime(const(FILETIME)* pftAcquisitionTime);
    ///The <code>GetFlags</code> method retrieves the photo acquire flags.
    ///Params:
    ///    pdwPhotoAcquireFlags = Pointer to a double word value containing the photo acquire flags.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A non-NULL value was expected. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetFlags(uint* pdwPhotoAcquireFlags);
    ///The <code>GetOutputFilenameTemplate</code> method retrieves a format string (template) that specifies the format
    ///of file names.
    ///Params:
    ///    pbstrTemplate = Pointer to a string containing the format string.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetOutputFilenameTemplate(BSTR* pbstrTemplate);
    ///The <code>GetSequencePaddingWidth</code> method retrieves a value indicating how wide sequential fields in file
    ///names will be.
    ///Params:
    ///    pdwWidth = Pointer to a double word value containing the width of sequential fields.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A non-NULL value was expected. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetSequencePaddingWidth(uint* pdwWidth);
    ///The <code>GetSequenceZeroPadding</code> method retrieves a value that indicates whether zeros or spaces will be
    ///used to pad sequential file names.
    ///Params:
    ///    pfZeroPad = Pointer to a flag that, if set to <b>TRUE</b>, indicates that zeros will pad sequential file names.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetSequenceZeroPadding(int* pfZeroPad);
    ///The <code>GetGroupTag</code> method retrieves a tag string for the group of files being downloaded from the
    ///device.
    ///Params:
    ///    pbstrGroupTag = Pointer to a string containing the group tag.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT GetGroupTag(BSTR* pbstrGroupTag);
    ///The <code>GetAcquisitionTime</code> method retrieves the acquisition time of the current session.
    ///Params:
    ///    pftAcquisitionTime = Specifies acquisition time.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A non-NULL value was expected. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetAcquisitionTime(FILETIME* pftAcquisitionTime);
}

///The <code>IPhotoAcquireOptionsDialog</code> interface is used to display an options dialog box in which the user can
///select photo acquisition settings such as file name formats, as well as whether or not to rotate images, to prompt
///for a tag name, or to erase photos from the camera after importing.
@GUID("00F2B3EE-BF64-47EE-89F4-4DEDD79643F2")
interface IPhotoAcquireOptionsDialog : IUnknown
{
    ///Initializes the options dialog box and reads any saved options from the registry.
    ///Params:
    ///    pszRegistryRoot = (optional) Pointer to a null-terminated string containing the registry root of a custom location to read the
    ///                      acquisition settings from. If this parameter is set to <b>NULL</b>, the default location will be used.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Initialize(const(wchar)* pszRegistryRoot);
    ///The <code>Create</code> method creates and displays a modeless instance of the photo options dialog box, hosted
    ///within a parent window.
    ///Params:
    ///    hWndParent = Handle to the parent window.
    ///    phWndDialog = Specifies the created dialog box.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Create(HWND hWndParent, HWND* phWndDialog);
    ///The <code>Destroy</code> method closes and destroys the modeless dialog box created with the Create method.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT Destroy();
    ///The <code>DoModal</code> method creates and displays the options dialog box as a modal dialog box.
    ///Params:
    ///    hWndParent = Handle to the dialog's parent window.
    ///    ppnReturnCode = Specifies the code returned when the window is closed.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT DoModal(HWND hWndParent, ptrdiff_t* ppnReturnCode);
    ///The <code>SaveData</code> method saves acquisition settings from the options dialog box to the registry so that a
    ///subsequent instance of the dialog can be initialized with the same settings.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SaveData();
}

///Provides a dialog box for selecting the device to acquire images from.
@GUID("00F28837-55DD-4F37-AAF5-6855A9640467")
interface IPhotoAcquireDeviceSelectionDialog : IUnknown
{
    ///The <code>SetTitle</code> method sets the title of the device selection dialog box.
    ///Params:
    ///    pszTitle = Pointer to a null-terminated string containing the title.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetTitle(const(wchar)* pszTitle);
    ///The <code>SetPrompt</code> method sets the text displayed in the dialog box that prompts the user to select a
    ///device.
    ///Params:
    ///    pszSubmitButtonText = Pointer to a null-terminated string containing the prompt.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT SetSubmitButtonText(const(wchar)* pszSubmitButtonText);
    ///The <code>DoModal</code> method displays a device selection dialog box. The function returns when the user
    ///selects a device using the modal dialog box.
    ///Params:
    ///    hWndParent = Handle to a parent window.
    ///    dwDeviceFlags = Double word value containing a combination of device flags that indicate which type of devices to display.
    ///                    The device flags may be a combination of any of the following: <table> <tr> <th>Flag </th> <th>Description
    ///                    </th> </tr> <tr> <td><b>DSF_WPD_DEVICES</b></td> <td>Show devices of type Windows Portable Devices
    ///                    (WPD).</td> </tr> <tr> <td><b>DSF_WIA_CAMERAS</b></td> <td>Show cameras of type Windows Image Acquisition
    ///                    (WIA).</td> </tr> <tr> <td><b>DSF_WIA_SCANNERS</b></td> <td>Show scanners of type Windows Image Acquisition
    ///                    (WIA).</td> </tr> <tr> <td><b>DSF_STI_DEVICES</b></td> <td>Show devices of type Still Image Architecture
    ///                    (STI).</td> </tr> <tr> <td><b>DSF_FS_DEVICES</b></td> <td>Show removable storage devices, such as CD drives
    ///                    or card readers.</td> </tr> <tr> <td><b>DSF_DV_DEVICES</b></td> <td>Show digital video camera devices.</td>
    ///                    </tr> <tr> <td><b>DSF_ALL_DEVICES</b></td> <td>Show all devices.</td> </tr> <tr>
    ///                    <td><b>DSF_SHOW_OFFLINE</b></td> <td>Show devices that are offline. Not supported by all device types.</td>
    ///                    </tr> </table>
    ///    pbstrDeviceId = Pointer to a string containing the ID of the selected device.
    ///    pnDeviceType = Pointer to the DEVICE_SELECTION_DEVICE_TYPE of the selected device.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Possible values include, but are not limited to, those in the following
    ///    table. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method succeeded. </td> </tr> </table>
    ///    
    HRESULT DoModal(HWND hWndParent, uint dwDeviceFlags, BSTR* pbstrDeviceId, 
                    DEVICE_SELECTION_DEVICE_TYPE* pnDeviceType);
}

///Implement the <code>IPhotoAcquirePlugin</code> interface when you want to create a plug-in to run alongside the
///Windows Vista user interface (UI) for image acquisition. Registry settings are required to enable the plug-in.
@GUID("00F2DCEB-ECB8-4F77-8E47-E7A987C83DD0")
interface IPhotoAcquirePlugin : IUnknown
{
    ///The <code>Initialize</code> method provides extended functionality when the plug-in is initialized. The
    ///application provides the implementation of the <code>Initialize</code> method.
    ///Params:
    ///    pPhotoAcquireSource = Specifies the source from which photos are being acquired.
    ///    pPhotoAcquireProgressCB = Specifies the callback that will provide additional processing during acquisition.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Your implementation is not limited to the following return values.
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
    ///    </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The method is not implemented </td> </tr> </table>
    ///    
    HRESULT Initialize(IPhotoAcquireSource pPhotoAcquireSource, IPhotoAcquireProgressCB pPhotoAcquireProgressCB);
    ///The <code>ProcessItem</code> method provides additional functionality each time an item is processed. The
    ///application provides the implementation of the <code>ProcessItem</code> method.
    ///Params:
    ///    dwAcquireStage = Specifies a double word value indicating whether this method is being called before or after processing an
    ///                     item. Must be one of: PAPS_PRESAVE, PAPS_POSTSAVE, or PAPS_CLEANUP. <table> <tr> <th>Value </th>
    ///                     <th>Description </th> </tr> <tr> <td>PAPS_PRESAVE</td> <td>Indicates that the method is being called before
    ///                     saving the acquired file. During PAPS_PRESAVE, pPhotoAcquireItem::GetProperty should be used to retrieve
    ///                     metadata from the original file, while new metadata to be written to the file should be added to
    ///                     <i>pPropertyStore</i>.</td> </tr> <tr> <td>PAPS_POSTSAVE</td> <td>Indicates that the method is being called
    ///                     after saving the acquired file.</td> </tr> <tr> <td>PAPS_CLEANUP</td> <td>Indicates that the user has
    ///                     canceled the acquire operation and any work done by the plug-in should be cleaned up.</td> </tr> </table>
    ///    pPhotoAcquireItem = Pointer to an IPhotoAcquireItem object for the item being processed.
    ///    pOriginalItemStream = Pointer to an <b>IStream</b> object for the original item. <b>NULL</b> if <i>dwAcquireStage</i> is
    ///                          PAPS_POSTSAVE.
    ///    pszFinalFilename = The file name of the destination of the item. <b>NULL</b> if <i>dwAcquireStage</i> is PAPS_PRESAVE.
    ///    pPropertyStore = The item's property store. <b>NULL</b> if <i>dwAcquireStage</i> is PAPS_POSTSAVE.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Your implementation is not limited to the following return values.
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
    ///    </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The method is not implemented. </td> </tr> </table>
    ///    
    HRESULT ProcessItem(uint dwAcquireStage, IPhotoAcquireItem pPhotoAcquireItem, IStream pOriginalItemStream, 
                        const(wchar)* pszFinalFilename, IPropertyStore pPropertyStore);
    ///Provides extended functionality when a transfer session is completed. The application provides the implementation
    ///of the <b>TransferComplete</b> method.
    ///Params:
    ///    hr = Specifies the result of the transfer operation.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Your implementation is not limited to the following return values.
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
    ///    </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The method is not implemented </td> </tr> </table>
    ///    
    HRESULT TransferComplete(HRESULT hr);
    ///The <code>DisplayConfigureDialog</code> method provides extended functionality when the configuration dialog is
    ///displayed. The application provides the implementation of the <code>DisplayConfigureDialog</code> method.
    ///Params:
    ///    hWndParent = Specifies the handle to the configuration dialog window.
    ///Returns:
    ///    The method returns an <b>HRESULT</b>. Your implementation is not limited to the following return values.
    ///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
    ///    </dl> </td> <td width="60%"> The method succeeded. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The method is not implemented </td> </tr> </table>
    ///    
    HRESULT DisplayConfigureDialog(HWND hWndParent);
}


// GUIDs

const GUID CLSID_PhotoAcquire                       = GUIDOF!PhotoAcquire;
const GUID CLSID_PhotoAcquireAutoPlayDropTarget     = GUIDOF!PhotoAcquireAutoPlayDropTarget;
const GUID CLSID_PhotoAcquireAutoPlayHWEventHandler = GUIDOF!PhotoAcquireAutoPlayHWEventHandler;
const GUID CLSID_PhotoAcquireDeviceSelectionDialog  = GUIDOF!PhotoAcquireDeviceSelectionDialog;
const GUID CLSID_PhotoAcquireOptionsDialog          = GUIDOF!PhotoAcquireOptionsDialog;
const GUID CLSID_PhotoProgressDialog                = GUIDOF!PhotoProgressDialog;

const GUID IID_IPhotoAcquire                      = GUIDOF!IPhotoAcquire;
const GUID IID_IPhotoAcquireDeviceSelectionDialog = GUIDOF!IPhotoAcquireDeviceSelectionDialog;
const GUID IID_IPhotoAcquireItem                  = GUIDOF!IPhotoAcquireItem;
const GUID IID_IPhotoAcquireOptionsDialog         = GUIDOF!IPhotoAcquireOptionsDialog;
const GUID IID_IPhotoAcquirePlugin                = GUIDOF!IPhotoAcquirePlugin;
const GUID IID_IPhotoAcquireProgressCB            = GUIDOF!IPhotoAcquireProgressCB;
const GUID IID_IPhotoAcquireSettings              = GUIDOF!IPhotoAcquireSettings;
const GUID IID_IPhotoAcquireSource                = GUIDOF!IPhotoAcquireSource;
const GUID IID_IPhotoProgressActionCB             = GUIDOF!IPhotoProgressActionCB;
const GUID IID_IPhotoProgressDialog               = GUIDOF!IPhotoProgressDialog;
const GUID IID_IUserInputString                   = GUIDOF!IUserInputString;
