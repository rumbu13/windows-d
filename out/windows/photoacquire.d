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


enum : int
{
    USER_INPUT_DEFAULT      = 0x00000000,
    USER_INPUT_PATH_ELEMENT = 0x00000001,
}
alias USER_INPUT_STRING_TYPE = int;

enum : int
{
    PHOTOACQUIRE_ERROR_SKIPRETRYCANCEL = 0x00000000,
    PHOTOACQUIRE_ERROR_RETRYCANCEL     = 0x00000001,
    PHOTOACQUIRE_ERROR_YESNO           = 0x00000002,
    PHOTOACQUIRE_ERROR_OK              = 0x00000003,
}
alias ERROR_ADVISE_MESSAGE_TYPE = int;

enum : int
{
    PHOTOACQUIRE_RESULT_YES      = 0x00000000,
    PHOTOACQUIRE_RESULT_NO       = 0x00000001,
    PHOTOACQUIRE_RESULT_OK       = 0x00000002,
    PHOTOACQUIRE_RESULT_SKIP     = 0x00000003,
    PHOTOACQUIRE_RESULT_SKIP_ALL = 0x00000004,
    PHOTOACQUIRE_RESULT_RETRY    = 0x00000005,
    PHOTOACQUIRE_RESULT_ABORT    = 0x00000006,
}
alias ERROR_ADVISE_RESULT = int;

enum : int
{
    PROGRESS_DIALOG_ICON_SMALL       = 0x00000000,
    PROGRESS_DIALOG_ICON_LARGE       = 0x00000001,
    PROGRESS_DIALOG_ICON_THUMBNAIL   = 0x00000002,
    PROGRESS_DIALOG_BITMAP_THUMBNAIL = 0x00000003,
}
alias PROGRESS_DIALOG_IMAGE_TYPE = int;

enum : int
{
    PROGRESS_DIALOG_CHECKBOX_ID_DEFAULT = 0x00000000,
}
alias PROGRESS_DIALOG_CHECKBOX_ID = int;

enum : int
{
    DST_UNKNOWN_DEVICE = 0x00000000,
    DST_WPD_DEVICE     = 0x00000001,
    DST_WIA_DEVICE     = 0x00000002,
    DST_STI_DEVICE     = 0x00000003,
    DSF_TWAIN_DEVICE   = 0x00000004,
    DST_FS_DEVICE      = 0x00000005,
    DST_DV_DEVICE      = 0x00000006,
}
alias DEVICE_SELECTION_DEVICE_TYPE = int;

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

@GUID("00F21C97-28BF-4C02-B842-5E4E90139A30")
interface IPhotoAcquireItem : IUnknown
{
    HRESULT GetItemName(BSTR* pbstrItemName);
    HRESULT GetThumbnail(SIZE sizeThumbnail, HBITMAP* phbmpThumbnail);
    HRESULT GetProperty(const(PROPERTYKEY)* key, PROPVARIANT* pv);
    HRESULT SetProperty(const(PROPERTYKEY)* key, const(PROPVARIANT)* pv);
    HRESULT GetStream(IStream* ppStream);
    HRESULT CanDelete(int* pfCanDelete);
    HRESULT Delete();
    HRESULT GetSubItemCount(uint* pnCount);
    HRESULT GetSubItemAt(uint nItemIndex, IPhotoAcquireItem* ppPhotoAcquireItem);
}

@GUID("00F243A1-205B-45BA-AE26-ABBC53AA7A6F")
interface IUserInputString : IUnknown
{
    HRESULT GetSubmitButtonText(BSTR* pbstrSubmitButtonText);
    HRESULT GetPrompt(BSTR* pbstrPromptTitle);
    HRESULT GetStringId(BSTR* pbstrStringId);
    HRESULT GetStringType(USER_INPUT_STRING_TYPE* pnStringType);
    HRESULT GetTooltipText(BSTR* pbstrTooltipText);
    HRESULT GetMaxLength(uint* pcchMaxLength);
    HRESULT GetDefault(BSTR* pbstrDefault);
    HRESULT GetMruCount(uint* pnMruCount);
    HRESULT GetMruEntryAt(uint nIndex, BSTR* pbstrMruEntry);
    HRESULT GetImage(uint nSize, HBITMAP* phBitmap, HICON* phIcon);
}

@GUID("00F2CE1E-935E-4248-892C-130F32C45CB4")
interface IPhotoAcquireProgressCB : IUnknown
{
    HRESULT Cancelled(int* pfCancelled);
    HRESULT StartEnumeration(IPhotoAcquireSource pPhotoAcquireSource);
    HRESULT FoundItem(IPhotoAcquireItem pPhotoAcquireItem);
    HRESULT EndEnumeration(HRESULT hr);
    HRESULT StartTransfer(IPhotoAcquireSource pPhotoAcquireSource);
    HRESULT StartItemTransfer(uint nItemIndex, IPhotoAcquireItem pPhotoAcquireItem);
    HRESULT DirectoryCreated(const(wchar)* pszDirectory);
    HRESULT UpdateTransferPercent(BOOL fOverall, uint nPercent);
    HRESULT EndItemTransfer(uint nItemIndex, IPhotoAcquireItem pPhotoAcquireItem, HRESULT hr);
    HRESULT EndTransfer(HRESULT hr);
    HRESULT StartDelete(IPhotoAcquireSource pPhotoAcquireSource);
    HRESULT StartItemDelete(uint nItemIndex, IPhotoAcquireItem pPhotoAcquireItem);
    HRESULT UpdateDeletePercent(uint nPercent);
    HRESULT EndItemDelete(uint nItemIndex, IPhotoAcquireItem pPhotoAcquireItem, HRESULT hr);
    HRESULT EndDelete(HRESULT hr);
    HRESULT EndSession(HRESULT hr);
    HRESULT GetDeleteAfterAcquire(int* pfDeleteAfterAcquire);
    HRESULT ErrorAdvise(HRESULT hr, const(wchar)* pszErrorMessage, ERROR_ADVISE_MESSAGE_TYPE nMessageType, 
                        ERROR_ADVISE_RESULT* pnErrorAdviseResult);
    HRESULT GetUserInput(const(GUID)* riidType, IUnknown pUnknown, PROPVARIANT* pPropVarResult, 
                         const(PROPVARIANT)* pPropVarDefault);
}

@GUID("00F242D0-B206-4E7D-B4C1-4755BCBB9C9F")
interface IPhotoProgressActionCB : IUnknown
{
    HRESULT DoAction(HWND hWndParent);
}

@GUID("00F246F9-0750-4F08-9381-2CD8E906A4AE")
interface IPhotoProgressDialog : IUnknown
{
    HRESULT Create(HWND hwndParent);
    HRESULT GetWindow(HWND* phwndProgressDialog);
    HRESULT Destroy();
    HRESULT SetTitle(const(wchar)* pszTitle);
    HRESULT ShowCheckbox(PROGRESS_DIALOG_CHECKBOX_ID nCheckboxId, BOOL fShow);
    HRESULT SetCheckboxText(PROGRESS_DIALOG_CHECKBOX_ID nCheckboxId, const(wchar)* pszCheckboxText);
    HRESULT SetCheckboxCheck(PROGRESS_DIALOG_CHECKBOX_ID nCheckboxId, BOOL fChecked);
    HRESULT SetCheckboxTooltip(PROGRESS_DIALOG_CHECKBOX_ID nCheckboxId, const(wchar)* pszCheckboxTooltipText);
    HRESULT IsCheckboxChecked(PROGRESS_DIALOG_CHECKBOX_ID nCheckboxId, int* pfChecked);
    HRESULT SetCaption(const(wchar)* pszTitle);
    HRESULT SetImage(PROGRESS_DIALOG_IMAGE_TYPE nImageType, HICON hIcon, HBITMAP hBitmap);
    HRESULT SetPercentComplete(int nPercent);
    HRESULT SetProgressText(const(wchar)* pszProgressText);
    HRESULT SetActionLinkCallback(IPhotoProgressActionCB pPhotoProgressActionCB);
    HRESULT SetActionLinkText(const(wchar)* pszCaption);
    HRESULT ShowActionLink(BOOL fShow);
    HRESULT IsCancelled(int* pfCancelled);
    HRESULT GetUserInput(const(GUID)* riidType, IUnknown pUnknown, PROPVARIANT* pPropVarResult, 
                         const(PROPVARIANT)* pPropVarDefault);
}

@GUID("00F2C703-8613-4282-A53B-6EC59C5883AC")
interface IPhotoAcquireSource : IUnknown
{
    HRESULT GetFriendlyName(BSTR* pbstrFriendlyName);
    HRESULT GetDeviceIcons(uint nSize, HICON* phLargeIcon, HICON* phSmallIcon);
    HRESULT InitializeItemList(BOOL fForceEnumeration, IPhotoAcquireProgressCB pPhotoAcquireProgressCB, 
                               uint* pnItemCount);
    HRESULT GetItemCount(uint* pnItemCount);
    HRESULT GetItemAt(uint nIndex, IPhotoAcquireItem* ppPhotoAcquireItem);
    HRESULT GetPhotoAcquireSettings(IPhotoAcquireSettings* ppPhotoAcquireSettings);
    HRESULT GetDeviceId(BSTR* pbstrDeviceId);
    HRESULT BindToObject(const(GUID)* riid, void** ppv);
}

@GUID("00F23353-E31B-4955-A8AD-CA5EBF31E2CE")
interface IPhotoAcquire : IUnknown
{
    HRESULT CreatePhotoSource(const(wchar)* pszDevice, IPhotoAcquireSource* ppPhotoAcquireSource);
    HRESULT Acquire(IPhotoAcquireSource pPhotoAcquireSource, BOOL fShowProgress, HWND hWndParent, 
                    const(wchar)* pszApplicationName, IPhotoAcquireProgressCB pPhotoAcquireProgressCB);
    HRESULT EnumResults(IEnumString* ppEnumFilePaths);
}

@GUID("00F2B868-DD67-487C-9553-049240767E91")
interface IPhotoAcquireSettings : IUnknown
{
    HRESULT InitializeFromRegistry(const(wchar)* pszRegistryKey);
    HRESULT SetFlags(uint dwPhotoAcquireFlags);
    HRESULT SetOutputFilenameTemplate(const(wchar)* pszTemplate);
    HRESULT SetSequencePaddingWidth(uint dwWidth);
    HRESULT SetSequenceZeroPadding(BOOL fZeroPad);
    HRESULT SetGroupTag(const(wchar)* pszGroupTag);
    HRESULT SetAcquisitionTime(const(FILETIME)* pftAcquisitionTime);
    HRESULT GetFlags(uint* pdwPhotoAcquireFlags);
    HRESULT GetOutputFilenameTemplate(BSTR* pbstrTemplate);
    HRESULT GetSequencePaddingWidth(uint* pdwWidth);
    HRESULT GetSequenceZeroPadding(int* pfZeroPad);
    HRESULT GetGroupTag(BSTR* pbstrGroupTag);
    HRESULT GetAcquisitionTime(FILETIME* pftAcquisitionTime);
}

@GUID("00F2B3EE-BF64-47EE-89F4-4DEDD79643F2")
interface IPhotoAcquireOptionsDialog : IUnknown
{
    HRESULT Initialize(const(wchar)* pszRegistryRoot);
    HRESULT Create(HWND hWndParent, HWND* phWndDialog);
    HRESULT Destroy();
    HRESULT DoModal(HWND hWndParent, ptrdiff_t* ppnReturnCode);
    HRESULT SaveData();
}

@GUID("00F28837-55DD-4F37-AAF5-6855A9640467")
interface IPhotoAcquireDeviceSelectionDialog : IUnknown
{
    HRESULT SetTitle(const(wchar)* pszTitle);
    HRESULT SetSubmitButtonText(const(wchar)* pszSubmitButtonText);
    HRESULT DoModal(HWND hWndParent, uint dwDeviceFlags, BSTR* pbstrDeviceId, 
                    DEVICE_SELECTION_DEVICE_TYPE* pnDeviceType);
}

@GUID("00F2DCEB-ECB8-4F77-8E47-E7A987C83DD0")
interface IPhotoAcquirePlugin : IUnknown
{
    HRESULT Initialize(IPhotoAcquireSource pPhotoAcquireSource, IPhotoAcquireProgressCB pPhotoAcquireProgressCB);
    HRESULT ProcessItem(uint dwAcquireStage, IPhotoAcquireItem pPhotoAcquireItem, IStream pOriginalItemStream, 
                        const(wchar)* pszFinalFilename, IPropertyStore pPropertyStore);
    HRESULT TransferComplete(HRESULT hr);
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
