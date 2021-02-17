// Written in the D programming language.

module windows.wia;

public import windows.core;
public import windows.automation : BSTR;
public import windows.com : HRESULT, IUnknown, STGMEDIUM;
public import windows.structuredstorage : IEnumSTATPROPSTG, IStream, PROPSPEC, PROPVARIANT,
                                          STATPROPSETSTG;
public import windows.systemservices : BOOL;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Enums


///The <b>WIAVIDEO_STATE</b> enumeration is used to specify the current state of a video stream. <div
///class="alert"><b>Note</b> Windows Image Acquisition (WIA) does not support video devices in Windows Server 2003,
///Windows Vista, and later. For those versions of the Windows, use DirectShow to acquire images from video.</div><div>
///</div>
alias WIAVIDEO_STATE = int;
enum : int
{
    ///No video stream exists. Call IWiaVideo::CreateVideoByWiaDevID, IWiaVideo::CreateVideoByDevNum, or
    ///IWiaVideo::CreateVideoByName to create a video.
    WIAVIDEO_NO_VIDEO         = 0x00000001,
    ///One of the IWiaVideo CreateVideo methods was called and WIA is in the process of creating the video stream.
    WIAVIDEO_CREATING_VIDEO   = 0x00000002,
    ///A video stream has been successfully created, but playback has not yet started.
    WIAVIDEO_VIDEO_CREATED    = 0x00000003,
    ///A video stream has been successfully created, and the video is playing. The application can now call the
    ///IWiaVideo::TakePicture method.
    WIAVIDEO_VIDEO_PLAYING    = 0x00000004,
    ///A video stream has been successfully created, and the video is paused. The application can now call the
    ///IWiaVideo::TakePicture method.
    WIAVIDEO_VIDEO_PAUSED     = 0x00000005,
    ///The application called IWiaVideo::DestroyVideo method, and WIA is in the process of destroying the video stream.
    WIAVIDEO_DESTROYING_VIDEO = 0x00000006,
}

// Structs


///The <b>WIA_DITHER_PATTERN_DATA</b> structure specifies a dither pattern for scanners. It is used in conjunction with
///the scanner device property constant WIA_DPS_DITHER_PATTERN_DATA.
struct WIA_DITHER_PATTERN_DATA
{
    ///Type: <b>LONG</b> Specifies the size of this structure in bytes. Should be set to
    ///<b>sizeof(WIA_DITHER_PATTERN_DATA)</b>.
    int    lSize;
    ///Type: <b>BSTR</b> Specifies a string that contains the name of this dither pattern.
    BSTR   bstrPatternName;
    ///Type: <b>LONG</b> Indicates the width of the dither pattern in bytes.
    int    lPatternWidth;
    ///Type: <b>LONG</b> Indicates the length of the dither pattern in bytes.
    int    lPatternLength;
    ///Type: <b>LONG</b> Specifies the total number of bytes in the array pointed to by the <b>pbPattern</b> member.
    int    cbPattern;
    ubyte* pbPattern;
}

///Provides a quick means by which applications can look up the standard Windows Image Acquisition (WIA) property name
///from the WIA property ID (or vice versa). If the <b>propid</b> does not exist in this array, it is likely not a
///standard WIA property. Other ways to get the property name from the property ID include using the
///<b>IEnumSTATPROPSTG</b> retrieved by calling IWiaPropertyStorage::Enum on a particular item.
struct WIA_PROPID_TO_NAME
{
    ///Type: <b>PROPID</b> WIA property ID.
    uint    propid;
    ushort* pszName;
}

///The <b>WIA_FORMAT_INFO</b> structure specifies valid format and media type pairs for a device.
struct WIA_FORMAT_INFO
{
    ///Type: <b>GUID</b> GUID that identifies the format.
    GUID guidFormatID;
    int  lTymed;
}

///The <b>WIA_DATA_CALLBACK_HEADER</b> is transmitted to an application during a series of calls by the Windows Image
///Acquisition (WIA) run-time system to the IWiaDataCallback::BandedDataCallback method.
struct WIA_DATA_CALLBACK_HEADER
{
    ///Type: <b>LONG</b> Must contain the size of this structure in bytes. Should be initialized to
    ///<b>sizeof(WIA_DATA_CALLBACK_HEADER)</b>.
    int  lSize;
    ///Type: <b>GUID</b> Indicates the image clipboard format. For a list of clipboard formats, see SetClipboardData
    ///Function. This parameter is queried during a callback to the IWiaDataCallback::BandedDataCallback method with the
    ///<i>lMessage</i> parameter set to IT_MSG_DATA_HEADER.
    GUID guidFormatID;
    ///Type: <b>LONG</b> Specifies the size in bytes of the buffer needed for a complete data transfer. This value can
    ///be zero, which indicates that the total image size is unknown. (when using compressed data formats, for example).
    ///In this case, the application should dynamically increase the size of its buffer. For more information, see
    ///Common WIA Item Property Constants in WIA_IPA_ITEM_SIZE.
    int  lBufferSize;
    int  lPageCount;
}

///The <b>WIA_DATA_TRANSFER_INFO</b> structure is used by applications to describe the buffer used to retrieve bands of
///data from Windows Image Acquisition (WIA) devices. It is primarily used in conjunction with the methods of the
///IWiaDataTransfer interface.
struct WIA_DATA_TRANSFER_INFO
{
    ///Type: <b>ULONG</b> Contains the size of this structure. Must be set to <b>sizeof(WIA_DATA_TRANSFER_INFO)</b>
    ///before your application passes this structure to any WIA interface methods.
    uint ulSize;
    ///Type: <b>ULONG</b> Specifies an optional handle to a shared section of memory allocated by the application. If
    ///this member is set to <b>NULL</b>, IWiaDataTransfer::idtGetBandedData allocates the shared memory itself.
    uint ulSection;
    ///Type: <b>ULONG</b> The size in bytes of the buffer that is used for the data transfer.
    uint ulBufferSize;
    ///Type: <b>BOOL</b> Contains <b>TRUE</b> if the device is double buffered, <b>FALSE</b> if the device is not double
    ///buffered.
    BOOL bDoubleBuffer;
    ///Type: <b>ULONG</b> Reserved for use by the WIA system DLLs. Must be set to zero.
    uint ulReserved1;
    ///Type: <b>ULONG</b> Reserved for use by the WIA system DLLs. Must be set to zero.
    uint ulReserved2;
    uint ulReserved3;
}

///The <b>WIA_EXTENDED_TRANSFER_INFO</b> structure specifies extended transfer information for the
///IWiaDataTransfer::idtGetExtendedTransferInfo method.
struct WIA_EXTENDED_TRANSFER_INFO
{
    ///Type: <b>ULONG</b> Size of this structure.
    uint ulSize;
    ///Type: <b>ULONG</b> Minimum buffer size the application should request in a call to
    ///IWiaDataTransfer::idtGetBandedData.
    uint ulMinBufferSize;
    ///Type: <b>ULONG</b> Driver-recommended buffer size the application should request in a call to
    ///IWiaDataTransfer::idtGetBandedData.
    uint ulOptimalBufferSize;
    ///Type: <b>ULONG</b> Driver-recommended maximum buffer size the application could request in a call to
    ///IWiaDataTransfer::idtGetBandedData. Going over this limit is not detrimental, however, the driver can simply not
    ///use the whole buffer and limit each band of data to this maximum size.
    uint ulMaxBufferSize;
    uint ulNumBuffers;
}

///Applications use the <b>WIA_DEV_CAP</b> structure to enumerate device capabilities. A device capability is defined by
///an event or command that the device supports. For more information, see IEnumWIA_DEV_CAPS.
struct WIA_DEV_CAP
{
    ///Type: <b>GUID</b> Specifies a GUID that identifies the device capability. This member can be set to any of the
    ///values specified in WIA Device Commands or WIA Event Identifiers.
    GUID guid;
    ///Type: <b>ULONG</b> Used when enumerating event handlers. The possible values are listed in this table. <table
    ///class="clsStd"> <tr> <th>Value</th> <th>Description</th> </tr> <tr> <td>WIA_IS_DEFAULT_HANDLER</td> <td>The
    ///currently registered handler should be used. This is the only valid value when enumerating event handlers. It is
    ///not a valid value when enumerating event capabilities of a device.</td> </tr> <tr> <td>WIA_ACTION_EVENT</td>
    ///<td>The event is of the action type, so programs that use persistent registration APIs,
    ///IWiaDevMgr::RegisterEventCallbackProgram and IWiaDevMgr::RegisterEventCallbackCLSID, can receive it. </td> </tr>
    ///<tr> <td>WIA_NOTIFICATION_EVENT</td> <td>The event is of the notification type, so programs that use the runtime
    ///registration function, IWiaDevMgr::RegisterEventCallbackInterface, can receive it. </td> </tr> </table>
    uint ulFlags;
    ///Type: <b>BSTR</b> Specifies a string that contains a short version of the capability name.
    BSTR bstrName;
    ///Type: <b>BSTR</b> Specifies a string that contains a description of the capability that is displayed to the user.
    BSTR bstrDescription;
    ///Type: <b>BSTR</b> Specifies a string that represents the location and resource ID of the icon that represents
    ///this capability or handler. The string must be of the following form:
    ///<i>drive</i><b>:\\</b><i>path</i><b>\\</b><i>module</i><b>,</b><i>n</i>, where <i>n</i> is the icon's negated
    ///resource ID (that is, if the resource ID of the icon is 100, then <i>n</i> is -100).
    BSTR bstrIcon;
    BSTR bstrCommandline;
}

// Interfaces

@GUID("3908C3CD-4478-4536-AF2F-10C25D4EF89A")
struct WiaVideo;

///Applications use the <b>IWiaDevMgr</b> interface to create and manage image acquisition devices. They also use it to
///register to receive device events. <div class="alert"><b>Note</b> For Windows Vista applications, use IWiaDevMgr2
///instead of <b>IWiaDevMgr</b>.</div><div> </div>
@GUID("5EB2502A-8CF1-11D1-BF92-0060081ED811")
interface IWiaDevMgr : IUnknown
{
    ///Applications use the <b>IWiaDevMgr::EnumDeviceInfo</b> method to enumerate property information for each
    ///available Windows Image Acquisition (WIA) device.
    ///Params:
    ///    lFlag = Type: <b>LONG</b> Specifies the types of WIA devices to enumerate. Should be set to WIA_DEVINFO_ENUM_LOCAL.
    ///    ppIEnum = Type: <b>IEnumWIA_DEV_INFO**</b> Receives the address of a pointer to the IEnumWIA_DEV_INFO interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnumDeviceInfo(int lFlag, IEnumWIA_DEV_INFO* ppIEnum);
    ///The <b>IWiaDevMgr::CreateDevice</b> creates a hierarchical tree of IWiaItem objects for a Windows Image
    ///Acquisition (WIA) device.
    ///Params:
    ///    bstrDeviceID = Type: <b>BSTR</b> Specifies the unique identifier of the WIA device.
    ///    ppWiaItemRoot = Type: <b>IWiaItem**</b> Pointer to a pointer to the IWiaItem interface of the root item in the hierarchical
    ///                    tree for the WIA device.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateDevice(BSTR bstrDeviceID, IWiaItem* ppWiaItemRoot);
    ///The <b>IWiaDevMgr::SelectDeviceDlg</b> displays a dialog box that enables the user to select a hardware device
    ///for image acquisition.
    ///Params:
    ///    hwndParent = Type: <b>HWND</b> Handle of the window that owns the <b>Select Device</b> dialog box.
    ///    lDeviceType = Type: <b>LONG</b> Specifies which type of WIA device to use. Can be set to <b>StiDeviceTypeDefault</b>,
    ///                  <b>StiDeviceTypeScanner</b>, or <b>StiDeviceTypeDigitalCamera</b>.
    ///    lFlags = Type: <b>LONG</b> Specifies dialog box behavior. Can be set to any of the following values: <table
    ///             class="clsStd"> <tr> <th>Constant</th> <th>Meaning</th> </tr> <tr> <td>0</td> <td>Use the default
    ///             behavior.</td> </tr> <tr> <td>WIA_SELECT_DEVICE_NODEFAULT</td> <td>Display the dialog box even if there is
    ///             only one matching device. For more information, see the <b>Remarks</b> section of this reference page.</td>
    ///             </tr> </table>
    ///    pbstrDeviceID = Type: <b>BSTR*</b> On output, receives a string which contains the device's identifier string. On input, pass
    ///                    the address of a pointer if this information is needed, or <b>NULL</b> if it is not needed.
    ///    ppItemRoot = Type: <b>IWiaItem**</b> Receives the address of a pointer to the IWiaItem interface of the root item of the
    ///                 tree that represents the selected WIA device. If no devices are found, it contains the value <b>NULL</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns the following values: <table class="clsStd"> <tr> <th>Return
    ///    Value</th> <th>Meaning</th> </tr> <tr> <td>S_OK</td> <td>A device was successfully selected.</td> </tr> <tr>
    ///    <td>S_FALSE</td> <td>The user canceled the dialog box.</td> </tr> <tr> <td>WIA_S_NO_DEVICE_AVAILABLE</td>
    ///    <td>There are no WIA hardware devices that match the specifications given in the <i>lDeviceType</i>
    ///    parameter.</td> </tr> </table>
    ///    
    HRESULT SelectDeviceDlg(HWND hwndParent, int lDeviceType, int lFlags, BSTR* pbstrDeviceID, 
                            IWiaItem* ppItemRoot);
    ///The <b>IWiaDevMgr::SelectDeviceDlgID</b> method displays a dialog box that enables the user to select a hardware
    ///device for image acquisition.
    ///Params:
    ///    hwndParent = Type: <b>HWND</b> Handle of the window that owns the <b>Select Device</b> dialog box.
    ///    lDeviceType = Type: <b>LONG</b> Specifies which type of WIA device to use. Can be set to <b>StiDeviceTypeDefault</b>,
    ///                  <b>StiDeviceTypeScanner</b>, or <b>StiDeviceTypeDigitalCamera</b>.
    ///    lFlags = Type: <b>LONG</b> Specifies dialog box behavior. Can be set to any of the following values: <table
    ///             class="clsStd"> <tr> <th>Constant</th> <th>Meaning</th> </tr> <tr> <td>0</td> <td>Use the default
    ///             behavior.</td> </tr> <tr> <td>WIA_SELECT_DEVICE_NODEFAULT</td> <td>Display the dialog box even if there is
    ///             only one matching device. For more information, see the <b>Remarks</b> section of this reference page.</td>
    ///             </tr> </table>
    ///    pbstrDeviceID = Type: <b>BSTR*</b> Pointer to a string that receives the identifier string of the device.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns the following values: <table class="clsStd"> <tr> <th>Return
    ///    Value</th> <th>Meaning</th> </tr> <tr> <td>S_OK</td> <td>A device was successfully selected.</td> </tr> <tr>
    ///    <td>S_FALSE</td> <td>The user canceled the dialog box.</td> </tr> <tr> <td>WIA_S_NO_DEVICE_AVAILABLE</td>
    ///    <td>There are no WIA hardware devices attached to the user's computer that match the specifications.</td>
    ///    </tr> </table>
    ///    
    HRESULT SelectDeviceDlgID(HWND hwndParent, int lDeviceType, int lFlags, BSTR* pbstrDeviceID);
    ///The <b>IWiaDevMgr::GetImageDlg</b> method displays one or more dialog boxes that enable a user to acquire an
    ///image from a Windows Image Acquisition (WIA) device and write the image to a specified file. This method combines
    ///the functionality of IWiaDevMgr::SelectDeviceDlg to completely encapsulate image acquisition within a single API
    ///call.
    ///Params:
    ///    hwndParent = Type: <b>HWND</b> Handle of the window that owns the <b>Get Image</b> dialog box.
    ///    lDeviceType = Type: <b>LONG</b> Specifies which type of WIA device to use. Is set to <b>StiDeviceTypeDefault</b>,
    ///                  <b>StiDeviceTypeScanner</b>, or <b>StiDeviceTypeDigitalCamera</b>.
    ///    lFlags = Type: <b>LONG</b> Specifies dialog box behavior. Can be set to the following values: <table class="clsStd">
    ///             <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td>0</td> <td>Default behavior.</td> </tr> <tr>
    ///             <td>WIA_SELECT_DEVICE_NODEFAULT</td> <td>Force this method to display the <b>Select Device</b> dialog box.
    ///             For more information, see the <b>Remarks</b> section of this reference page.</td> </tr> <tr>
    ///             <td>WIA_DEVICE_DIALOG_SINGLE_IMAGE</td> <td>Restrict image selection to a single image in the device image
    ///             acquisition dialog box.</td> </tr> <tr> <td>WIA_DEVICE_DIALOG_USE_COMMON_UI</td> <td>Use the system UI, if
    ///             available, rather than the vendor-supplied UI. If the system UI is not available, the vendor UI is used. If
    ///             neither UI is available, the function returns E_NOTIMPL.</td> </tr> </table>
    ///    lIntent = Type: <b>LONG</b> Specifies what type of data the image is intended to represent. For a list of image intent
    ///              values, see Image Intent Constants.
    ///    pItemRoot = Type: <b>IWiaItem*</b> Pointer to the interface of the hierarchical tree of IWiaItem objects returned by
    ///                IWiaDevMgr::CreateDevice.
    ///    bstrFilename = Type: <b>BSTR</b> Specifies the name of the file to which the image data is written.
    ///    pguidFormat = Type: <b>GUID*</b> On input, contains a pointer to a GUID that specifies the format to use. On output, holds
    ///                  the format used. Pass IID_NULL to use the default format.
    ///Returns:
    ///    Type: <b>HRESULT</b> <b>IWiaDevMgr::GetImageDlg</b> returns S_FALSE if the user cancels the device selection
    ///    or image acquisition dialog boxes, WIA_S_NO_DEVICE_AVAILABLE if no WIA device is currently available,
    ///    E_NOTIMPL if no UI is available, and S_OK if the data is transferred successfully.
    ///    <b>IWiaDevMgr::GetImageDlg</b> returns a value specified in Error Codes, or a standard COM error if it fails
    ///    for any reason other than those specified.
    ///    
    HRESULT GetImageDlg(HWND hwndParent, int lDeviceType, int lFlags, int lIntent, IWiaItem pItemRoot, 
                        BSTR bstrFilename, GUID* pguidFormat);
    ///The <b>IWiaDevMgr::RegisterEventCallbackProgram</b> method registers an application to receive device events. It
    ///is primarily provided for backward compatibility with applications that were not written for WIA.
    ///Params:
    ///    lFlags = Type: <b>LONG</b> Specifies registration flags. Can be set to the following values: <table class="clsStd">
    ///             <tr> <th>Registration Flag</th> <th>Meaning</th> </tr> <tr> <td>WIA_REGISTER_EVENT_CALLBACK</td> <td>Register
    ///             for the event.</td> </tr> <tr> <td>WIA_UNREGISTER_EVENT_CALLBACK</td> <td>Delete the registration for the
    ///             event.</td> </tr> <tr> <td>WIA_SET_DEFAULT_HANDLER</td> <td>Set the application as the default event
    ///             handler.</td> </tr> </table>
    ///    bstrDeviceID = Type: <b>BSTR</b> Specifies a device identifier. Pass <b>NULL</b> to register for the event on all WIA
    ///                   devices.
    ///    pEventGUID = Type: <b>const GUID*</b> Specifies the event for which the application is registering. For a list of valid
    ///                 event GUIDs, see WIA Event Identifiers.
    ///    bstrCommandline = Type: <b>BSTR</b> Specifies a string that contains the full path name and the appropriate command-line
    ///                      arguments needed to invoke the application. Two pairs of quotation marks should be used, for example,
    ///                      "\"C:\Program Files\MyExe.exe\" /arg1".
    ///    bstrName = Type: <b>BSTR</b> Specifies the name of the application. This name is displayed to the user when multiple
    ///               applications register for the same event.
    ///    bstrDescription = Type: <b>BSTR</b> Specifies the description of the application. This description is displayed to the user
    ///                      when multiple applications register for the same event.
    ///    bstrIcon = Type: <b>BSTR</b> Specifies the icon that represents the application. The icon is displayed to the user when
    ///               multiple applications register for the same event. The string contains the name of the application and the
    ///               0-based index of the icon (there may be more than one icon that represent application) separated by a comma.
    ///               For example, "MyApp, 0".
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RegisterEventCallbackProgram(int lFlags, BSTR bstrDeviceID, const(GUID)* pEventGUID, 
                                         BSTR bstrCommandline, BSTR bstrName, BSTR bstrDescription, BSTR bstrIcon);
    ///The <b>IWiaDevMgr::RegisterEventCallbackInterface</b> method registers a running application Windows Image
    ///Acquisition (WIA) event notification.
    ///Params:
    ///    lFlags = Type: <b>LONG</b> Currently unused. Should be set to zero.
    ///    bstrDeviceID = Type: <b>BSTR</b> Specifies a device identifier. Pass <b>NULL</b> to register for the event on all WIA
    ///                   devices.
    ///    pEventGUID = Type: <b>const GUID*</b> Specifies the event for which the application is registering. For a list of standard
    ///                 events, see WIA Event Identifiers.
    ///    pIWiaEventCallback = Type: <b>IWiaEventCallback*</b> Pointer to the IWiaEventCallback interface that the WIA system used to send
    ///                         the event notification.
    ///    pEventObject = Type: <b>IUnknown**</b> Receives the address of a pointer to the IUnknown interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RegisterEventCallbackInterface(int lFlags, BSTR bstrDeviceID, const(GUID)* pEventGUID, 
                                           IWiaEventCallback pIWiaEventCallback, IUnknown* pEventObject);
    ///The <b>IWiaDevMgr::RegisterEventCallbackCLSID</b> method registers an application to receive events even if the
    ///application may not be running.
    ///Params:
    ///    lFlags = Type: <b>LONG</b> Specifies registration flags. Can be set to the following values: <table class="clsStd">
    ///             <tr> <th>Registration Flag</th> <th>Meaning</th> </tr> <tr> <td>WIA_REGISTER_EVENT_CALLBACK</td> <td>Register
    ///             for the event.</td> </tr> <tr> <td>WIA_UNREGISTER_EVENT_CALLBACK</td> <td>Delete the registration for the
    ///             event.</td> </tr> <tr> <td>WIA_SET_DEFAULT_HANDLER</td> <td>Set the application as the default event
    ///             handler.</td> </tr> </table>
    ///    bstrDeviceID = Type: <b>BSTR</b> Specifies a device identifier. Pass <b>NULL</b> to register for the event on all WIA
    ///                   devices.
    ///    pEventGUID = Type: <b>const GUID*</b> Specifies the event for which the application is registering. For a list of standard
    ///                 events, see WIA Event Identifiers.
    ///    pClsID = Type: <b>const GUID*</b> Pointer to the application's class ID (<b>CLSID</b>). The WIA run-time system uses
    ///             the application's <b>CLSID</b> to start the application when an event occurs for which it is registered.
    ///    bstrName = Type: <b>BSTR</b> Specifies the name of the application that registers for the event.
    ///    bstrDescription = Type: <b>BSTR</b> Specifies a text description of the application that registers for the event.
    ///    bstrIcon = Type: <b>BSTR</b> Specifies the name of an image file to be used for the icon for the application that
    ///               registers for the event.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RegisterEventCallbackCLSID(int lFlags, BSTR bstrDeviceID, const(GUID)* pEventGUID, const(GUID)* pClsID, 
                                       BSTR bstrName, BSTR bstrDescription, BSTR bstrIcon);
    ///This method is not implemented.
    ///Params:
    ///    hwndParent = Type: <b>HWND</b>
    ///    lFlags = Type: <b>LONG</b>
    HRESULT AddDeviceDlg(HWND hwndParent, int lFlags);
}

///The <b>IEnumWIA_DEV_INFO</b> interface enumerates the currently available Windows Image Acquisition (WIA) hardware
///devices and their properties. Device information properties describe the installation and configuration of WIA
///hardware devices.
@GUID("5E38B83C-8CF1-11D1-BF92-0060081ED811")
interface IEnumWIA_DEV_INFO : IUnknown
{
    ///The <b>IEnumWIA_DEV_INFO::Next</b> method fills an array of pointers to IWiaPropertyStorage interfaces.
    ///Params:
    ///    celt = Type: <b>ULONG</b> Specifies the number of array elements in the array indicated by the <i>rgelt</i>
    ///           parameter.
    ///    rgelt = Type: <b>IWiaPropertyStorage**</b> Receives the address of an array of IWiaPropertyStorage interface
    ///            pointers. <b>IEnumWIA_DEV_INFO::Next</b> fills this array with interface pointers.
    ///    pceltFetched = Type: <b>ULONG*</b> On output, this parameter contains the number of interface pointers actually stored in
    ///                   the array indicated by the <i>rgelt</i> parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> While there are devices left to enumerate, this method returns S_OK. It returns S_FALSE
    ///    when the enumeration is finished. If the method fails, it returns a standard COM error code.
    ///    
    HRESULT Next(uint celt, IWiaPropertyStorage* rgelt, uint* pceltFetched);
    ///The <b>IEnumWIA_DEV_INFO::Skip</b> method skips the specified number of hardware devices during an enumeration of
    ///available devices.
    ///Params:
    ///    celt = Type: <b>ULONG</b> Specifies the number of devices to skip.
    HRESULT Skip(uint celt);
    ///The <b>IEnumWIA_DEV_INFO::Reset</b> method is used by applications to restart the enumeration of device
    ///information.
    HRESULT Reset();
    ///The <b>IEnumWIA_DEV_INFO::Clone</b> method creates an additional instance of the IEnumWIA_DEV_INFO interface and
    ///sends back a pointer to it.
    ///Params:
    ///    ppIEnum = Type: <b>IEnumWIA_DEV_INFO**</b> Pointer to an IEnumWIA_DEV_INFO interface. This parameter contains a pointer
    ///              to the <b>IEnumWIA_DEV_INFO</b> interface instance that <b>IEnumWIA_DEV_INFO::Clone</b> creates.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Clone(IEnumWIA_DEV_INFO* ppIEnum);
    ///The <b>IEnumWIA_DEV_INFO::GetCount</b> method returns the number of elements stored by this enumerator.
    ///Params:
    ///    celt = Type: <b>ULONG*</b> This parameter points to a <b>ULONG</b> that receives the number of elements in the
    ///           enumeration.
    HRESULT GetCount(uint* celt);
}

///The <b>IWiaEventCallback</b> interface is used by applications to receive notification of Windows Image Acquisition
///(WIA) hardware device events. An application registers itself to receive event notifications by passing a pointer to
///the <b>IWiaEventCallback</b> interface to the IWiaDevMgr::RegisterEventCallbackInterface method.
@GUID("AE6287B0-0084-11D2-973B-00A0C9068F2E")
interface IWiaEventCallback : IUnknown
{
    ///The <b>IWiaEventCallback::ImageEventCallback</b> method is invoked by the Windows Image Acquisition (WIA)
    ///run-time system when a hardware device event occurs.
    ///Params:
    ///    pEventGUID = Type: <b>const GUID*</b> Specifies the unique identifier of the event. For a complete list of device events,
    ///                 see WIA Event Identifiers.
    ///    bstrEventDescription = Type: <b>BSTR</b> Specifies the string description of the event.
    ///    bstrDeviceID = Type: <b>BSTR</b> Specifies the unique identifier of the WIA device.
    ///    bstrDeviceDescription = Type: <b>BSTR</b> Specifies the string description of the device.
    ///    dwDeviceType = Type: <b>DWORD</b> Specifies the type of the device. See WIA Device Type Specifiers for a list of possible
    ///                   values.
    ///    bstrFullItemName = Type: <b>BSTR</b> Specifies the full name of the WIA item that represents the device.
    ///    pulEventType = Type: <b>ULONG*</b> Pointer to a <b>ULONG</b> that specifies whether an event is a notification event, an
    ///                   action event, or both. A value of 1 indicates a notification event, a value of 2 indicates an action event,
    ///                   and a value of 3 indicates that the event is of both notification and action type.
    ///    ulReserved = Type: <b>ULONG</b> Reserved for user information.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ImageEventCallback(const(GUID)* pEventGUID, BSTR bstrEventDescription, BSTR bstrDeviceID, 
                               BSTR bstrDeviceDescription, uint dwDeviceType, BSTR bstrFullItemName, 
                               uint* pulEventType, uint ulReserved);
}

///Provides an application callback mechanism during data transfers from Windows Image Acquisition (WIA) hardware
///devices to applications. <div class="alert"><b>Note</b> For Windows Vista applications, use IWiaTransferCallback
///instead of <b>IWiaDataCallback</b>.</div><div> </div>
@GUID("A558A866-A5B0-11D2-A08F-00C04F72DC3C")
interface IWiaDataCallback : IUnknown
{
    ///Provides data transfer status notifications. Windows Image Acquisition (WIA) data transfer methods of the
    ///IWiaDataTransfer interface periodically call this method.
    ///Params:
    ///    lMessage = Type: <b>LONG</b> Specifies a constant that indicates the reason for the callback. Can be one of the
    ///               following values:
    ///    lStatus = Type: <b>LONG</b> Specifies a constant that indicates the status of the WIA device. Can be set to a
    ///              combination of the following:
    ///    lPercentComplete = Type: <b>LONG</b> Specifies the percentage of the total data that has been transferred so far.
    ///    lOffset = Type: <b>LONG</b> Specifies an offset, in bytes, from the beginning of the buffer where the current band of
    ///              data begins.
    ///    lLength = Type: <b>LONG</b> Specifies the length, in bytes, of the current band of data.
    ///    lReserved = Type: <b>LONG</b> Reserved for internal use by the WIA run-time system.
    ///    lResLength = Type: <b>LONG</b> Reserved for internal use by the WIA run-time system.
    ///    pbBuffer = Type: <b>BYTE*</b> Pointer to the data buffer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the method returns S_OK. To cancel the data transfer, it returns
    ///    S_FALSE. If the method fails, it returns a standard COM error code.
    ///    
    HRESULT BandedDataCallback(int lMessage, int lStatus, int lPercentComplete, int lOffset, int lLength, 
                               int lReserved, int lResLength, ubyte* pbBuffer);
}

///The <b>IWiaDataTransfer</b> interface is a high performance data transfer interface. This interface supports a shared
///memory window to transfer data from the device object to the application, and eliminates unnecessary data copies
///during marshalling. A callback mechanism is provided in the form of the IWiaDataCallback interface. It enables
///applications to obtain data transfer status notification, transfer data from the Windows Image Acquisition (WIA)
///device to the application, and cancel pending data transfers. <div class="alert"><b>Note</b> For Windows Vista
///applications, use IWiaTransfer instead of <b>IWiaDataTransfer</b>.</div><div> </div>
@GUID("A6CEF998-A5B0-11D2-A08F-00C04F72DC3C")
interface IWiaDataTransfer : IUnknown
{
    ///The <b>IWiaDataTransfer::idtGetData</b> method retrieves complete files from a Windows Image Acquisition (WIA)
    ///device.
    ///Params:
    ///    pMedium = Type: <b>LPSTGMEDIUM</b> Pointer to the STGMEDIUM structure.
    ///    pIWiaDataCallback = Type: <b>IWiaDataCallback*</b> Pointer to the IWiaDataCallback interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method can return any one of the following values: <table class="clsStd"> <tr>
    ///    <th>Return Value</th> <th>Meaning</th> </tr> <tr> <td>E_INVALIDARG</td> <td>One or more parameters to this
    ///    method contain invalid data.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>This method cannot allocate enough
    ///    memory to complete its operation.</td> </tr> <tr> <td>E_UNEXPECTED</td> <td>An unknown error occurred.</td>
    ///    </tr> <tr> <td>S_FALSE</td> <td>The application canceled the operation.</td> </tr> <tr> <td>S_OK</td> <td>The
    ///    image was successfully acquired.</td> </tr> <tr> <td>STG_E_MEDIUMFULL</td> <td>The storage medium the
    ///    application is using to acquire the image is full.</td> </tr> <tr> <td>WIA_S_NO_DEVICE_AVAILABLE</td>
    ///    <td>There are no WIA hardware devices attached to the user's computer.</td> </tr> </table> This method will
    ///    return a value specified in Error Codes, or a standard COM error if it fails for any reason other than those
    ///    specified in the preceding table.
    ///    
    HRESULT idtGetData(STGMEDIUM* pMedium, IWiaDataCallback pIWiaDataCallback);
    ///The <b>IWiaDataTransfer::idtGetBandedData</b> method transfers a band of data from a hardware device to an
    ///application. For efficiency, applications retrieve data from Windows Image Acquisition (WIA) hardware devices in
    ///successive bands.
    ///Params:
    ///    pWiaDataTransInfo = Type: <b>PWIA_DATA_TRANSFER_INFO</b> Pointer to the WIA_DATA_TRANSFER_INFO structure.
    ///    pIWiaDataCallback = Type: <b>IWiaDataCallback*</b> Pointer to the IWiaDataCallback interface. Periodically, this method will call
    ///                        the BandedDataCallback method to provide the application with data transfer status notification.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method can return any one of the following values: <table class="clsStd"> <tr>
    ///    <th>Return Value</th> <th>Meaning</th> </tr> <tr> <td>E_INVALIDARG</td> <td>One or more parameters to this
    ///    method contain invalid data.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>This method cannot allocate enough
    ///    memory to complete its operation.</td> </tr> <tr> <td>E_UNEXPECTED</td> <td>An unknown error occurred.</td>
    ///    </tr> <tr> <td>S_FALSE</td> <td>The application canceled the operation.</td> </tr> <tr> <td>S_OK</td> <td>The
    ///    image was successfully acquired.</td> </tr> <tr> <td>STG_E_MEDIUMFULL</td> <td>The storage medium the
    ///    application is using to acquire the image is full.</td> </tr> <tr> <td>WIA_S_NO_DEVICE_AVAILABLE</td>
    ///    <td>There are no WIA hardware devices attached to the user's computer.</td> </tr> </table> This method will
    ///    return a value specified in Error Codes, or a standard COM error if it fails for any reason other than those
    ///    specified in the preceding table.
    ///    
    HRESULT idtGetBandedData(WIA_DATA_TRANSFER_INFO* pWiaDataTransInfo, IWiaDataCallback pIWiaDataCallback);
    ///The <b>IWiaDataTransfer::idtQueryGetData</b> method is used by applications to query a Windows Image Acquisition
    ///(WIA) device to determine what types of data formats it supports.
    ///Params:
    ///    pfe = Type: <b>WIA_FORMAT_INFO*</b> Pointer to a WIA_FORMAT_INFO structure.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns S_OK. Otherwise it returns a value specified in
    ///    Error Codes, or a standard COM error.
    ///    
    HRESULT idtQueryGetData(WIA_FORMAT_INFO* pfe);
    ///The <b>IWiaDataTransfer::idtEnumWIA_FORMAT_INFO</b> method creates a banded transfer implementation of the
    ///IEnumWIA_FORMAT_INFO interface.
    ///Params:
    ///    ppEnum = Type: <b>IEnumWIA_FORMAT_INFO**</b> Receives the address of a pointer to the IEnumWIA_FORMAT_INFO interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If it fails for any reason other than those specified in the following table, this
    ///    method will return a standard COM error. <table class="clsStd"> <tr> <th>Return Value</th> <th>Meaning</th>
    ///    </tr> <tr> <td>E_INVALIDARG</td> <td>The <i>ppEnum</i> parameter is not the address of a pointer to the
    ///    IEnumWIA_FORMAT_INFO interface.</td> </tr> <tr> <td>E_OUTOFMEMORY</td> <td>There is not enough memory to
    ///    create the enumerator object.</td> </tr> <tr> <td>S_OK</td> <td>The enumerator object was successfully
    ///    created.</td> </tr> </table>
    ///    
    HRESULT idtEnumWIA_FORMAT_INFO(IEnumWIA_FORMAT_INFO* ppEnum);
    ///The <b>IWiaDataTransfer::idtGetExtendedTransferInfo</b> retrieves extended information relating to data transfer
    ///buffers in the case of banded data transfers. Applications typically use this method to retrieve driver
    ///recommended settings for minimum buffer size, maximum buffer size, and optimal buffer size for banded data
    ///transfers.
    ///Params:
    ///    pExtendedTransferInfo = Type: <b>PWIA_EXTENDED_TRANSFER_INFO</b> Pointer to a WIA_EXTENDED_TRANSFER_INFO structure containing the
    ///                            extended information.
    HRESULT idtGetExtendedTransferInfo(WIA_EXTENDED_TRANSFER_INFO* pExtendedTransferInfo);
}

///Each Windows Image Acquisition (WIA) hardware device is represented to an application as a hierarchical tree of
///<b>IWiaItem</b> objects. The <b>IWiaItem</b> interface provides applications with the ability to query devices to
///discover their capabilities. It also provides access to data transfer interfaces and item properties. In addition,
///the <b>IWiaItem</b> interface provides methods to enable applications to control the device. <div
///class="alert"><b>Note</b> For Windows Vista applications, use IWiaItem2 instead of <b>IWiaItem</b>.</div><div> </div>
@GUID("4DB1AD10-3391-11D2-9A33-00C04FA36145")
interface IWiaItem : IUnknown
{
    ///The <b>IWiaItem::GetItemType</b> method is called by applications to obtain the type information of an item.
    ///Params:
    ///    pItemType = Type: <b>LONG*</b> Receives the address of a <b>LONG</b> variable that contains a combination of WIA Item
    ///                Type Flags.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetItemType(int* pItemType);
    ///The <b>IWiaItem::AnalyzeItem</b> method causes the Windows Image Acquisition (WIA) hardware device to acquire and
    ///try to detect what data types are present.
    ///Params:
    ///    lFlags = Type: <b>LONG</b> Currently unused. Should be set to zero.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AnalyzeItem(int lFlags);
    ///The <b>IWiaItem::EnumChildItems</b> method creates an enumerator object and passes back a pointer to its
    ///IEnumWiaItem interface for non-empty folders in a IWiaItem tree of a Windows Image Acquisition (WIA) device.
    ///Params:
    ///    ppIEnumWiaItem = Type: <b>IEnumWiaItem**</b> Receives the address of a pointer to the IEnumWiaItem interface that
    ///                     <b>IWiaItem::EnumChildItems</b> creates.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnumChildItems(IEnumWiaItem* ppIEnumWiaItem);
    ///The <b>IWiaItem::DeleteItem</b> method removes the current IWiaItem object from the object tree of the device.
    ///Params:
    ///    lFlags = Type: <b>LONG</b> Currently unused. Should be set to zero.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns S_OK regardless of how many items were deleted. If the method fails,
    ///    it returns a standard COM error code.
    ///    
    HRESULT DeleteItem(int lFlags);
    ///The <b>IWiaItem::CreateChildItem</b> method is used by applications to add IWiaItem objects to the
    ///<b>IWiaItem</b> tree of a device.
    ///Params:
    ///    lFlags = Type: <b>LONG</b> Specifies the WIA item type. Must be set to one of the values listed in WIA Item Type
    ///             Flags.
    ///    bstrItemName = Type: <b>BSTR</b> Specifies the WIA item name, such as "Top". You can think of this parameter as being
    ///                   equivalent to a file name.
    ///    bstrFullItemName = Type: <b>BSTR</b> Specifies the full WIA item name. You can think of this parameter as equivalent to a full
    ///                       path to a file, such as "003\Root\Top".
    ///    ppIWiaItem = Type: <b>IWiaItem**</b> Receives the address of a pointer to the IWiaItem interface that sets the
    ///                 <b>IWiaItem::CreateChildItem</b> method.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateChildItem(int lFlags, BSTR bstrItemName, BSTR bstrFullItemName, IWiaItem* ppIWiaItem);
    ///The <b>IWiaItem::EnumRegisterEventInfo</b> method creates an enumerator used to obtain information about events
    ///for which an application is registered.
    ///Params:
    ///    lFlags = Type: <b>LONG</b> Currently unused. Should be set to zero.
    ///    pEventGUID = Type: <b>const GUID*</b> Pointer to an identifier that specifies the hardware event for which you want
    ///                 registration information.
    ///    ppIEnum = Type: <b>IEnumWIA_DEV_CAPS**</b> Receives the address of a pointer to the IEnumWIA_DEV_CAPS interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnumRegisterEventInfo(int lFlags, const(GUID)* pEventGUID, IEnumWIA_DEV_CAPS* ppIEnum);
    ///The <b>IWiaItem::FindItemByName</b> method searches an item's tree of sub-items using the name as the search key.
    ///Each IWiaItem object has a name as one of its standard properties.
    ///Params:
    ///    lFlags = Type: <b>LONG</b> Currently unused. Should be set to zero.
    ///    bstrFullItemName = Type: <b>BSTR</b> Specifies the name of the item for which to search.
    ///    ppIWiaItem = Type: <b>IWiaItem**</b> Pointer to the IWiaItem interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns S_OK if it finds the item, or S_FALSE if it does not find the item.
    ///    If the method fails, it returns a standard COM error code.
    ///    
    HRESULT FindItemByName(int lFlags, BSTR bstrFullItemName, IWiaItem* ppIWiaItem);
    ///The <b>IWiaItem::DeviceDlg</b> method is used by applications to display a dialog box to the user to prepare for
    ///image acquisition.
    ///Params:
    ///    hwndParent = Type: <b>HWND</b> Handle of the parent window of the dialog box.
    ///    lFlags = Type: <b>LONG</b> Specifies a set of flags that control the dialog box's operation. Can be set to any of the
    ///             following values: <table class="clsStd"> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td>0</td>
    ///             <td>Default behavior.</td> </tr> <tr> <td>WIA_DEVICE_DIALOG_SINGLE_IMAGE</td> <td>Restrict image selection to
    ///             a single image in the device image acquisition dialog box.</td> </tr> <tr>
    ///             <td>WIA_DEVICE_DIALOG_USE_COMMON_UI</td> <td>Use the system UI, if available, rather than the vendor-supplied
    ///             UI. If the system UI is not available, the vendor UI is used. If neither UI is available, the function
    ///             returns E_NOTIMPL.</td> </tr> </table>
    ///    lIntent = Type: <b>LONG</b> Specifies what type of data the image is intended to represent. For a list of image intent
    ///              values, see Image Intent Constants. <div class="alert"><b>Note</b> This method ignores all WIA_INTENT_IMAGE_*
    ///              image intents.</div> <div> </div>
    ///    plItemCount = Type: <b>LONG*</b> Receives the number of items in the array indicated by the <i>ppIWiaItem</i> parameter.
    ///    ppIWiaItem = Type: <b>IWiaItem***</b> Receives the address of an array of pointers to IWiaItem interfaces.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DeviceDlg(HWND hwndParent, int lFlags, int lIntent, int* plItemCount, IWiaItem** ppIWiaItem);
    ///The <b>IWiaItem::DeviceCommand</b> issues a command to a Windows Image Acquisition (WIA) hardware device.
    ///Params:
    ///    lFlags = Type: <b>LONG</b> Currently unused. Should be set to zero.
    ///    pCmdGUID = Type: <b>const GUID*</b> Specifies a unique identifier that specifies the command to send to the WIA hardware
    ///               device. For a list of valid device commands, see WIA Device Commands.
    ///    pIWiaItem = Type: <b>IWiaItem**</b> On output, this pointer points to the item created by the command, if any.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DeviceCommand(int lFlags, const(GUID)* pCmdGUID, IWiaItem* pIWiaItem);
    ///The <b>IWiaItem::GetRootItem</b> method retrieves the root item of a tree of item objects used to represent a
    ///Windows Image Acquisition (WIA) hardware device.
    ///Params:
    ///    ppIWiaItem = Type: <b>IWiaItem**</b> Receives the address of a pointer to the IWiaItem interface that contains a pointer
    ///                 to the <b>IWiaItem</b> interface of the root item.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRootItem(IWiaItem* ppIWiaItem);
    ///The <b>IWiaItem::EnumDeviceCapabilities</b> method creates an enumerator that is used to ascertain the commands
    ///and events a Windows Image Acquisition (WIA) device supports.
    ///Params:
    ///    lFlags = Type: <b>LONG</b> Specifies a flag that selects the type of capabilities to enumerate. Can be set to one or
    ///             more of the following values: <table class="clsStd"> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr>
    ///             <td>WIA_DEVICE_COMMANDS</td> <td>Enumerate device commands.</td> </tr> <tr> <td>WIA_DEVICE_EVENTS</td>
    ///             <td>Enumerate device events.</td> </tr> </table>
    ///    ppIEnumWIA_DEV_CAPS = Type: <b>IEnumWIA_DEV_CAPS**</b> Pointer to IEnumWIA_DEV_CAPS interface created by
    ///                          <b>IWiaItem::EnumDeviceCapabilities</b>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EnumDeviceCapabilities(int lFlags, IEnumWIA_DEV_CAPS* ppIEnumWIA_DEV_CAPS);
    ///This method is not supported.
    ///Params:
    ///    bstrData = Type: <b>BSTR*</b>
    HRESULT DumpItemData(BSTR* bstrData);
    ///This method is not supported.
    ///Params:
    ///    bstrData = Type: <b>BSTR*</b>
    HRESULT DumpDrvItemData(BSTR* bstrData);
    ///This method is not supported.
    ///Params:
    ///    bstrData = Type: <b>BSTR*</b>
    HRESULT DumpTreeItemData(BSTR* bstrData);
    ///This method is not supported.
    ///Params:
    ///    ulSize = Type: <b>ULONG</b>
    ///    pBuffer = Type: <b>BYTE*</b>
    HRESULT Diagnostic(uint ulSize, char* pBuffer);
}

///The <b>IWiaPropertyStorage</b> interface is used to access information about the IWiaItem object's properties.
///Applications must query an item to obtain its <b>IWiaPropertyStorage</b> interface.
@GUID("98B5E8A0-29CC-491A-AAC0-E6DB4FDCCEB6")
interface IWiaPropertyStorage : IUnknown
{
    HRESULT ReadMultiple(uint cpspec, char* rgpspec, char* rgpropvar);
    HRESULT WriteMultiple(uint cpspec, const(PROPSPEC)* rgpspec, const(PROPVARIANT)* rgpropvar, 
                          uint propidNameFirst);
    HRESULT DeleteMultiple(uint cpspec, char* rgpspec);
    HRESULT ReadPropertyNames(uint cpropid, char* rgpropid, char* rglpwstrName);
    HRESULT WritePropertyNames(uint cpropid, char* rgpropid, char* rglpwstrName);
    HRESULT DeletePropertyNames(uint cpropid, char* rgpropid);
    HRESULT Commit(uint grfCommitFlags);
    HRESULT Revert();
    HRESULT Enum(IEnumSTATPROPSTG* ppenum);
    HRESULT SetTimes(const(FILETIME)* pctime, const(FILETIME)* patime, const(FILETIME)* pmtime);
    HRESULT SetClass(const(GUID)* clsid);
    HRESULT Stat(STATPROPSETSTG* pstatpsstg);
    ///The <b>IWiaPropertyStorage::GetPropertyAttributes</b> method retrieves access rights and legal value information
    ///for a specified set of properties.
    ///Params:
    ///    cpspec = Type: <b>ULONG</b> Specifies the number of property attributes to query.
    ///    rgpspec = Type: <b>PROPSPEC[]</b> Specifies an array of Device Information Property Constants. Each constant in the
    ///              array selects a property to query.
    ///    rgflags = Type: <b>ULONG[]</b> An array that receives a property attribute descriptor for each property specified in
    ///              the <i>rgpspec</i> array. Each element in the array is one or more descriptor values combined with a bitwise
    ///              <b>OR</b> operation.
    ///    rgpropvar = Type: <b>PROPVARIANT[]</b> An array that receives a property attribute descriptor for each property specified
    ///                in the <i>pPROPSPEC</i> array. For more information, see PROPVARIANT.
    ///Returns:
    ///    Type: <b>HRESULT</b> This method returns one of the following values or a standard COM error code: <table
    ///    class="clsStd"> <tr> <th>Return Value</th> <th>Meaning</th> </tr> <tr> <td>S_OK</td> <td>This method
    ///    succeeded.</td> </tr> <tr> <td>S_FALSE</td> <td>The specified property names do not exist. No attributes were
    ///    retrieved.</td> </tr> <tr> <td>STG_E_ACCESSDENIED</td> <td>The application does not have access to the
    ///    property stream or the stream may already be open.</td> </tr> <tr> <td>STG_E_INSUFFICIENTMEMORY</td>
    ///    <td>There is not enough memory to complete the operation.</td> </tr> <tr> <td>ERROR_NOT_SUPPORTED</td>
    ///    <td>The property type is not supported.</td> </tr> <tr> <td>STG_E_INVALIDPARAMETER</td> <td>One or more
    ///    parameters are invalid. One or more of the PROPSPEC structures contain invalid data.</td> </tr> <tr>
    ///    <td>STG_E_INVALIDPOINTER</td> <td>One or more of the pointers passed to this method are invalid.</td> </tr>
    ///    <tr> <td>ERROR_NO_UNICODE_TRANSLATION</td> <td>A translation from Unicode to ANSI or ANSI to Unicode
    ///    failed.</td> </tr> </table>
    ///    
    HRESULT GetPropertyAttributes(uint cpspec, char* rgpspec, char* rgflags, char* rgpropvar);
    ///The <b>IWiaPropertyStorage::GetCount</b> method returns the number of properties stored in the property storage.
    ///Params:
    ///    pulNumProps = Type: <b>ULONG*</b> Receives the number of properties stored in the property storage.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCount(uint* pulNumProps);
    ///The <b>IWiaPropertyStorage::GetPropertyStream</b> method retrieves the property stream of an item.
    ///Params:
    ///    pCompatibilityId = Type: <b>GUID*</b> Receives a unique identifier for a set of property values.
    ///    ppIStream = Type: <b>IStream**</b> Pointer to a stream that receives the item properties. For more information, see
    ///                IStream.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPropertyStream(GUID* pCompatibilityId, IStream* ppIStream);
    ///The <b>IWiaPropertyStorage::SetPropertyStream</b> sets the property stream of an item in the tree of IWiaItem
    ///objects of a Windows Image Acquisition (WIA) hardware device.
    ///Params:
    ///    pCompatibilityId = Type: <b>GUID*</b> Specifies a unique identifier for a set of property values.
    ///    pIStream = Type: <b>IStream*</b> Pointer to the property stream that is used to set the current item's property stream.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetPropertyStream(GUID* pCompatibilityId, IStream pIStream);
}

///The <b>IEnumWiaItem</b> interface is used by applications to enumerate IWiaItem objects in the tree's current folder.
///The Windows Image Acquisition (WIA) run-time system represents every WIA hardware device to applications as a
///hierarchical tree of <b>IWiaItem</b> objects. <div class="alert"><b>Note</b> For Windows Vista applications, use
///IEnumWiaItem2 instead of <b>IEnumWiaItem</b>.</div><div> </div>
@GUID("5E8383FC-3391-11D2-9A33-00C04FA36145")
interface IEnumWiaItem : IUnknown
{
    ///The <b>IEnumWiaItem::Next</b> method fills an array of pointers to IWiaItem interfaces.
    ///Params:
    ///    celt = Type: <b>ULONG</b> Specifies the number of array elements in the array indicated by the <i>ppIWiaItem</i>
    ///           parameter.
    ///    ppIWiaItem = Type: <b>IWiaItem**</b> Receives the address of an array of IWiaItem interface pointers.
    ///                 <b>IEnumWiaItem::Next</b> fills this array with interface pointers.
    ///    pceltFetched = Type: <b>ULONG*</b> On output, this parameter receives the number of interface pointers actually stored in
    ///                   the array indicated by the <i>ppIWiaItem</i> parameter. When the enumeration is complete, this parameter will
    ///                   contain zero.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds, the method returns S_OK. When the enumeration is complete, it
    ///    returns S_FALSE. If the method fails, it returns a standard COM error code.
    ///    
    HRESULT Next(uint celt, IWiaItem* ppIWiaItem, uint* pceltFetched);
    ///The <b>IEnumWiaItem::Skip</b> method skips the specified number of items during an enumeration of available
    ///IWiaItem objects.
    ///Params:
    ///    celt = Type: <b>ULONG</b> Specifies the number of items to skip.
    HRESULT Skip(uint celt);
    ///The <b>IEnumWiaItem::Reset</b> method is used by applications to restart the enumeration of item information.
    HRESULT Reset();
    ///The <b>IEnumWiaItem::Clone</b> method creates an additional instance of the IEnumWiaItem interface and sends back
    ///a pointer to it.
    ///Params:
    ///    ppIEnum = Type: <b>IEnumWiaItem**</b> Pointer to the IEnumWiaItem interface. Receives the address of the
    ///              <b>IEnumWiaItem</b> interface instance that <b>IEnumWiaItem::Clone</b> creates.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Clone(IEnumWiaItem* ppIEnum);
    ///The <b>IEnumWiaItem::GetCount</b> method returns the number of elements stored by this enumerator.
    ///Params:
    ///    celt = Type: <b>ULONG*</b> Pointer to a <b>ULONG</b> that receives the number of elements in the enumeration.
    HRESULT GetCount(uint* celt);
}

///The <b>IEnumWIA_DEV_CAPS</b> interface enumerates the currently available Windows Image Acquisition (WIA) hardware
///device capabilities. Device capabilities include commands and events that the device supports.
@GUID("1FCC4287-ACA6-11D2-A093-00C04F72DC3C")
interface IEnumWIA_DEV_CAPS : IUnknown
{
    ///The <b>IEnumWIA_DEV_CAPS::Next</b> method fills an array of pointers to WIA_DEV_CAP structures.
    ///Params:
    ///    celt = Type: <b>ULONG</b> Specifies the number of array elements in the array indicated by the <i>rgelt</i>
    ///           parameter.
    ///    rgelt = Type: <b>WIA_DEV_CAP*</b> Pointer to an array of WIA_DEV_CAP structures. <b>IEnumWIA_DEV_CAPS::Next</b> fills
    ///            this array of structures.
    ///    pceltFetched = Type: <b>ULONG*</b> On output, this parameter contains the number of structure pointers actually stored in
    ///                   the array indicated by the <i>rgelt</i> parameter.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Next(uint celt, WIA_DEV_CAP* rgelt, uint* pceltFetched);
    ///The <b>IEnumWIA_DEV_CAPS::Skip</b> method skips the specified number of hardware device capabilities during an
    ///enumeration of available device capabilities.
    ///Params:
    ///    celt = Type: <b>ULONG</b> Specifies the number of items to skip.
    HRESULT Skip(uint celt);
    ///The <b>IEnumWIA_DEV_CAPS::Reset</b> method is used by applications to restart the enumeration of device
    ///capabilities.
    HRESULT Reset();
    ///The <b>IEnumWIA_DEV_CAPS::Clone</b> method creates an additional instance of the IEnumWIA_DEV_CAPS interface and
    ///sends back a pointer to it.
    ///Params:
    ///    ppIEnum = Type: <b>IEnumWIA_DEV_CAPS**</b> Contains the address of a pointer to the instance of IEnumWIA_DEV_CAPS that
    ///              <b>IEnumWIA_DEV_CAPS::Clone</b> creates.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Clone(IEnumWIA_DEV_CAPS* ppIEnum);
    ///The <b>IEnumWIA_DEV_CAPS::GetCount</b> method returns the number of elements stored by this enumerator.
    ///Params:
    ///    pcelt = Type: <b>ULONG*</b> Pointer to a <b>ULONG</b> that receives the number of elements in the enumeration.
    HRESULT GetCount(uint* pcelt);
}

///Use the <b>IEnumWIA_FORMAT_INFO</b> interface to enumerate the format and media type information for a device.
@GUID("81BEFC5B-656D-44F1-B24C-D41D51B4DC81")
interface IEnumWIA_FORMAT_INFO : IUnknown
{
    ///The <b>IEnumWIA_FORMAT_INFO::Next</b> method returns an array of WIA_FORMAT_INFO structures.
    ///Params:
    ///    celt = Type: <b>ULONG</b> Specifies the number of elements requested.
    ///    rgelt = Type: <b>WIA_FORMAT_INFO*</b> Receives the address of the array of WIA_FORMAT_INFO structures.
    ///    pceltFetched = Type: <b>ULONG*</b> On output, receives the address of a <b>ULONG</b> that contains the number of
    ///                   WIA_FORMAT_INFO structures actually returned in the <i>rgelt</i> parameter.
    HRESULT Next(uint celt, WIA_FORMAT_INFO* rgelt, uint* pceltFetched);
    ///The <b>IEnumWIA_FORMAT_INFO::Skip</b> method skips the specified number of structures in the enumeration.
    ///Params:
    ///    celt = Type: <b>ULONG</b> Specifies the number of structures to skip.
    HRESULT Skip(uint celt);
    ///The <b>IEnumWIA_FORMAT_INFO::Reset</b> method sets the enumeration back to the first WIA_FORMAT_INFO structure.
    HRESULT Reset();
    ///The <b>IEnumWIA_FORMAT_INFO::Clone</b> method creates an additional instance of the IEnumWIA_FORMAT_INFO
    ///interface and returns an interface pointer to the new interface.
    ///Params:
    ///    ppIEnum = Type: <b>IEnumWIA_FORMAT_INFO**</b> Pointer to a new IEnumWIA_FORMAT_INFO interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Clone(IEnumWIA_FORMAT_INFO* ppIEnum);
    ///The <b>IEnumWIA_FORMAT_INFO::GetCount</b> method returns the number of elements stored by this enumerator.
    ///Params:
    ///    pcelt = Type: <b>ULONG*</b> Pointer to a <b>ULONG</b> that receives the number of elements in the enumeration.
    HRESULT GetCount(uint* pcelt);
}

///This interface is not supported.
@GUID("A00C10B6-82A1-452F-8B6C-86062AAD6890")
interface IWiaLog : IUnknown
{
    ///This method is not supported.
    ///Params:
    ///    hInstance = Type: <b>LONG</b>
    HRESULT InitializeLog(int hInstance);
    ///This method is not supported.
    ///Params:
    ///    hResult = Type: <b>HRESULT</b>
    HRESULT hResult(HRESULT hResult);
    ///This method is not supported.
    ///Params:
    ///    lFlags = Type: <b>LONG</b>
    ///    lResID = Type: <b>LONG</b>
    ///    lDetail = Type: <b>LONG</b>
    ///    bstrText = Type: <b>BSTR</b>
    HRESULT Log(int lFlags, int lResID, int lDetail, BSTR bstrText);
}

///This interface is not supported.
@GUID("AF1F22AC-7A40-4787-B421-AEB47A1FBD0B")
interface IWiaLogEx : IUnknown
{
    ///This method is not supported.
    ///Params:
    ///    hInstance = Type: <b>BYTE*</b>
    HRESULT InitializeLogEx(ubyte* hInstance);
    ///This method is not supported.
    ///Params:
    ///    hResult = Type: <b>HRESULT</b>
    HRESULT hResult(HRESULT hResult);
    ///This method is not supported.
    ///Params:
    ///    lFlags = Type: <b>LONG</b>
    ///    lResID = Type: <b>LONG</b>
    ///    lDetail = Type: <b>LONG</b>
    ///    bstrText = Type: <b>BSTR</b>
    HRESULT Log(int lFlags, int lResID, int lDetail, BSTR bstrText);
    ///This method is not supported.
    ///Params:
    ///    lMethodId = Type: <b>LONG</b>
    ///    hResult = Type: <b>HRESULT</b>
    HRESULT hResultEx(int lMethodId, HRESULT hResult);
    ///This method is not supported.
    ///Params:
    ///    lMethodId = Type: <b>LONG</b>
    ///    lFlags = Type: <b>LONG</b>
    ///    lResID = Type: <b>LONG</b>
    ///    lDetail = Type: <b>LONG</b>
    ///    bstrText = Type: <b>BSTR</b>
    HRESULT LogEx(int lMethodId, int lFlags, int lResID, int lDetail, BSTR bstrText);
}

///This interface is not implemented.
@GUID("70681EA0-E7BF-4291-9FB1-4E8813A3F78E")
interface IWiaNotifyDevMgr : IUnknown
{
    ///This method is not implemented.
    HRESULT NewDeviceArrival();
}

///The <b>IWiaItemExtras</b> interface provides several methods that enable applications to communicate with hardware
///drivers.
@GUID("6291EF2C-36EF-4532-876A-8E132593778D")
interface IWiaItemExtras : IUnknown
{
    ///The <b>IWiaItemExtras::GetExtendedErrorInfo</b> method gets a string from the device driver that contains
    ///information about the most recent error. Call this method after an error during an operation on a Windows Image
    ///Acquisition (WIA) item (such as data transfer).
    ///Params:
    ///    bstrErrorText = Type: <b>BSTR*</b> Pointer to a string that contains the error information.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetExtendedErrorInfo(BSTR* bstrErrorText);
    ///The <b>IWiaItemExtras::Escape</b> method sends a request for a vendor-specific I/O operation to a still image
    ///device.
    ///Params:
    ///    dwEscapeCode = Type: <b>DWORD</b> Calling application-supplied, vendor-defined, DWORD-sized value that represents an I/O
    ///                   operation.
    ///    lpInData = Type: <b>BYTE*</b> Pointer to a calling application-supplied buffer that contains data to be sent to the
    ///               device.
    ///    cbInDataSize = Type: <b>DWORD</b> Calling application-supplied length, in bytes, of the data contained in the buffer pointed
    ///                   to by <i>lpInData</i>.
    ///    pOutData = Type: <b>BYTE*</b> Pointer to a calling application-supplied memory buffer to receive data from the device.
    ///    dwOutDataSize = Type: <b>DWORD</b> Calling application-supplied length, in bytes, of the buffer pointed to by
    ///                    <i>pOutData</i>.
    ///    pdwActualDataSize = Type: <b>DWORD*</b> Receives the number of bytes actually written to <i>pOutData</i>.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Escape(uint dwEscapeCode, char* lpInData, uint cbInDataSize, char* pOutData, uint dwOutDataSize, 
                   uint* pdwActualDataSize);
    ///The <b>IWiaItemExtras::CancelPendingIO</b> method cancels all pending input/output operations on the driver.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CancelPendingIO();
}

///The <b>IWiaVideo</b> interface provides methods that allow an application that uses Windows Image Acquisition (WIA)
///services to acquire still images from a streaming video device. <div class="alert"><b>Note</b> WIA does not support
///video devices in Windows Server 2003, Windows Vista, and later. For those versions of the Windows, use DirectShow to
///acquire images from video.</div><div> </div>
@GUID("D52920AA-DB88-41F0-946C-E00DC0A19CFA")
interface IWiaVideo : IUnknown
{
    ///The <b>IWiaVideo::PreviewVisible</b> property specifies whether the video playback is visible in its parent
    ///window. This does not affect the WIAVIDEO_STATE of the video. This property is read/write.
    HRESULT get_PreviewVisible(int* pbPreviewVisible);
    ///The <b>IWiaVideo::PreviewVisible</b> property specifies whether the video playback is visible in its parent
    ///window. This does not affect the WIAVIDEO_STATE of the video. This property is read/write.
    HRESULT put_PreviewVisible(BOOL bPreviewVisible);
    ///The <b>IWiaVideo::ImagesDirectory</b> property specifies the full path and directory where images are stored when
    ///calling the IWiaVideo::TakePicture method. This property is read/write.
    HRESULT get_ImagesDirectory(BSTR* pbstrImageDirectory);
    ///The <b>IWiaVideo::ImagesDirectory</b> property specifies the full path and directory where images are stored when
    ///calling the IWiaVideo::TakePicture method. This property is read/write.
    HRESULT put_ImagesDirectory(BSTR bstrImageDirectory);
    ///The <b>IWiaVideo::CreateVideoByWiaDevID</b> method creates a connection to a streaming video device from its
    ///WIA_DIP_DEV_ID property.
    ///Params:
    ///    bstrWiaDeviceID = Type: <b>BSTR</b> Specifies the value of the video device's WIA_DIP_DEV_ID property.
    ///    hwndParent = Type: <b>HWND</b> Specifies the window in which to display the streaming video.
    ///    bStretchToFitParent = Type: <b>BOOL</b> Specifies whether the video display is stretched to fit the parent window. Set this
    ///                          parameter to <b>TRUE</b> if the display should be stretched to fit the parent window; otherwise, set to
    ///                          <b>FALSE</b>.
    ///    bAutoBeginPlayback = Type: <b>BOOL</b> Specifies whether the streaming video begins playback as soon as this method returns. Set
    ///                         this parameter to <b>TRUE</b> to cause immediate playback; set it to <b>FALSE</b> to require a call to
    ///                         IWiaVideo::Play before video playback begins.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateVideoByWiaDevID(BSTR bstrWiaDeviceID, HWND hwndParent, BOOL bStretchToFitParent, 
                                  BOOL bAutoBeginPlayback);
    ///The <b>IWiaVideo::CreateVideoByDevNum</b> method creates a connection to a streaming video device with the device
    ///number obtained from a Directshow enumeration.
    ///Params:
    ///    uiDeviceNumber = Type: <b>UINT</b> Specifies the video device's Directshow device number.
    ///    hwndParent = Type: <b>HWND</b> Specifies the window in which to display the streaming video.
    ///    bStretchToFitParent = Type: <b>BOOL</b> Specifies whether the video display is stretched to fit the parent window. Set this
    ///                          parameter to <b>TRUE</b> if the display should be stretched to fit the parent window; otherwise, set to
    ///                          <b>FALSE</b>.
    ///    bAutoBeginPlayback = Type: <b>BOOL</b> Specifies whether the streaming video begins playback as soon as this method returns. Set
    ///                         this parameter to <b>TRUE</b> to cause immediate playback; set it to <b>FALSE</b> to require a call to
    ///                         IWiaVideo::Play before video playback begins.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateVideoByDevNum(uint uiDeviceNumber, HWND hwndParent, BOOL bStretchToFitParent, 
                                BOOL bAutoBeginPlayback);
    ///The <b>IWiaVideo::CreateVideoByName</b> method creates a connection to a streaming video device with the friendly
    ///device name obtained from a Directshow enumeration.
    ///Params:
    ///    bstrFriendlyName = Type: <b>BSTR</b> Specifies the video device's friendly name obtained from a Directshow device enumeration.
    ///    hwndParent = Type: <b>HWND</b> Specifies the window in which to display the streaming video.
    ///    bStretchToFitParent = Type: <b>BOOL</b> Specifies whether the video display is stretched to fit the parent window. Set this
    ///                          parameter to <b>TRUE</b> if the display should be stretched to fit the parent window; otherwise, set to
    ///                          <b>FALSE</b>.
    ///    bAutoBeginPlayback = Type: <b>BOOL</b> Specifies whether the streaming video begins playback as soon as this method returns. Set
    ///                         this parameter to <b>TRUE</b> to cause immediate playback; set it to <b>FALSE</b> to require a call to
    ///                         IWiaVideo::Play before video playback begins.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateVideoByName(BSTR bstrFriendlyName, HWND hwndParent, BOOL bStretchToFitParent, 
                              BOOL bAutoBeginPlayback);
    ///The <b>IWiaVideo::DestroyVideo</b> method shuts down the streaming video. To restart video playback, the
    ///application must call one of the IWiaVideo CreateVideo methods again.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DestroyVideo();
    ///Begins playback of streaming video.
    ///Returns:
    ///    Type: <b>HRESULT</b> If the method succeeds or the video is already playing, this method returns S_OK. If the
    ///    method fails, it returns a standard COM error code.
    ///    
    HRESULT Play();
    ///The <b>IWiaVideo::Pause</b> method pauses video playback.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Pause();
    ///The <b>IWiaVideo::TakePicture</b> method extracts a still image from the video stream, and saves the image as a
    ///JPEG file.
    ///Params:
    ///    pbstrNewImageFilename = Type: <b>BSTR*</b> Receives the full path and filename of the JPEG file that this method creates.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT TakePicture(BSTR* pbstrNewImageFilename);
    ///The <b>IWiaVideo::ResizeVideo</b> method resizes the video playback to the largest supported resolution that fits
    ///inside the parent window. Call this method whenever the parent window is moved or resized.
    ///Params:
    ///    bStretchToFitParent = Type: <b>BOOL</b> Specifies whether the video playback is stretched to fill the parent window.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ResizeVideo(BOOL bStretchToFitParent);
    ///The <b>IWiaVideo::GetCurrentState</b> method specifies the state of the video stream as a member of the
    ///WIAVIDEO_STATE enumeration.
    ///Params:
    ///    pState = Type: <b>WIAVIDEO_STATE*</b> A member of the WIAVIDEO_STATE enumeration that specifies the current state of
    ///             the video stream.
    HRESULT GetCurrentState(WIAVIDEO_STATE* pState);
}


// GUIDs

const GUID CLSID_WiaVideo = GUIDOF!WiaVideo;

const GUID IID_IEnumWIA_DEV_CAPS    = GUIDOF!IEnumWIA_DEV_CAPS;
const GUID IID_IEnumWIA_DEV_INFO    = GUIDOF!IEnumWIA_DEV_INFO;
const GUID IID_IEnumWIA_FORMAT_INFO = GUIDOF!IEnumWIA_FORMAT_INFO;
const GUID IID_IEnumWiaItem         = GUIDOF!IEnumWiaItem;
const GUID IID_IWiaDataCallback     = GUIDOF!IWiaDataCallback;
const GUID IID_IWiaDataTransfer     = GUIDOF!IWiaDataTransfer;
const GUID IID_IWiaDevMgr           = GUIDOF!IWiaDevMgr;
const GUID IID_IWiaEventCallback    = GUIDOF!IWiaEventCallback;
const GUID IID_IWiaItem             = GUIDOF!IWiaItem;
const GUID IID_IWiaItemExtras       = GUIDOF!IWiaItemExtras;
const GUID IID_IWiaLog              = GUIDOF!IWiaLog;
const GUID IID_IWiaLogEx            = GUIDOF!IWiaLogEx;
const GUID IID_IWiaNotifyDevMgr     = GUIDOF!IWiaNotifyDevMgr;
const GUID IID_IWiaPropertyStorage  = GUIDOF!IWiaPropertyStorage;
const GUID IID_IWiaVideo            = GUIDOF!IWiaVideo;
