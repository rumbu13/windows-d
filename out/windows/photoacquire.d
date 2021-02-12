module windows.photoacquire;

public import system;
public import windows.audio;
public import windows.automation;
public import windows.com;
public import windows.displaydevices;
public import windows.gdi;
public import windows.structuredstorage;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;
public import windows.windowspropertiessystem;

extern(Windows):

const GUID CLSID_PhotoAcquire = {0x00F26E02, 0xE9F2, 0x4A9F, [0x9F, 0xDD, 0x5A, 0x96, 0x2F, 0xB2, 0x6A, 0x98]};
@GUID(0x00F26E02, 0xE9F2, 0x4A9F, [0x9F, 0xDD, 0x5A, 0x96, 0x2F, 0xB2, 0x6A, 0x98]);
struct PhotoAcquire;

const GUID CLSID_PhotoAcquireAutoPlayDropTarget = {0x00F20EB5, 0x8FD6, 0x4D9D, [0xB7, 0x5E, 0x36, 0x80, 0x17, 0x66, 0xC8, 0xF1]};
@GUID(0x00F20EB5, 0x8FD6, 0x4D9D, [0xB7, 0x5E, 0x36, 0x80, 0x17, 0x66, 0xC8, 0xF1]);
struct PhotoAcquireAutoPlayDropTarget;

const GUID CLSID_PhotoAcquireAutoPlayHWEventHandler = {0x00F2B433, 0x44E4, 0x4D88, [0xB2, 0xB0, 0x26, 0x98, 0xA0, 0xA9, 0x1D, 0xBA]};
@GUID(0x00F2B433, 0x44E4, 0x4D88, [0xB2, 0xB0, 0x26, 0x98, 0xA0, 0xA9, 0x1D, 0xBA]);
struct PhotoAcquireAutoPlayHWEventHandler;

const GUID CLSID_PhotoAcquireOptionsDialog = {0x00F210A1, 0x62F0, 0x438B, [0x9F, 0x7E, 0x96, 0x18, 0xD7, 0x2A, 0x18, 0x31]};
@GUID(0x00F210A1, 0x62F0, 0x438B, [0x9F, 0x7E, 0x96, 0x18, 0xD7, 0x2A, 0x18, 0x31]);
struct PhotoAcquireOptionsDialog;

const GUID CLSID_PhotoProgressDialog = {0x00F24CA0, 0x748F, 0x4E8A, [0x89, 0x4F, 0x0E, 0x03, 0x57, 0xC6, 0x79, 0x9F]};
@GUID(0x00F24CA0, 0x748F, 0x4E8A, [0x89, 0x4F, 0x0E, 0x03, 0x57, 0xC6, 0x79, 0x9F]);
struct PhotoProgressDialog;

const GUID CLSID_PhotoAcquireDeviceSelectionDialog = {0x00F29A34, 0xB8A1, 0x482C, [0xBC, 0xF8, 0x3A, 0xC7, 0xB0, 0xFE, 0x8F, 0x62]};
@GUID(0x00F29A34, 0xB8A1, 0x482C, [0xBC, 0xF8, 0x3A, 0xC7, 0xB0, 0xFE, 0x8F, 0x62]);
struct PhotoAcquireDeviceSelectionDialog;

const GUID IID_IPhotoAcquireItem = {0x00F21C97, 0x28BF, 0x4C02, [0xB8, 0x42, 0x5E, 0x4E, 0x90, 0x13, 0x9A, 0x30]};
@GUID(0x00F21C97, 0x28BF, 0x4C02, [0xB8, 0x42, 0x5E, 0x4E, 0x90, 0x13, 0x9A, 0x30]);
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

enum USER_INPUT_STRING_TYPE
{
    USER_INPUT_DEFAULT = 0,
    USER_INPUT_PATH_ELEMENT = 1,
}

const GUID IID_IUserInputString = {0x00F243A1, 0x205B, 0x45BA, [0xAE, 0x26, 0xAB, 0xBC, 0x53, 0xAA, 0x7A, 0x6F]};
@GUID(0x00F243A1, 0x205B, 0x45BA, [0xAE, 0x26, 0xAB, 0xBC, 0x53, 0xAA, 0x7A, 0x6F]);
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

enum ERROR_ADVISE_MESSAGE_TYPE
{
    PHOTOACQUIRE_ERROR_SKIPRETRYCANCEL = 0,
    PHOTOACQUIRE_ERROR_RETRYCANCEL = 1,
    PHOTOACQUIRE_ERROR_YESNO = 2,
    PHOTOACQUIRE_ERROR_OK = 3,
}

enum ERROR_ADVISE_RESULT
{
    PHOTOACQUIRE_RESULT_YES = 0,
    PHOTOACQUIRE_RESULT_NO = 1,
    PHOTOACQUIRE_RESULT_OK = 2,
    PHOTOACQUIRE_RESULT_SKIP = 3,
    PHOTOACQUIRE_RESULT_SKIP_ALL = 4,
    PHOTOACQUIRE_RESULT_RETRY = 5,
    PHOTOACQUIRE_RESULT_ABORT = 6,
}

const GUID IID_IPhotoAcquireProgressCB = {0x00F2CE1E, 0x935E, 0x4248, [0x89, 0x2C, 0x13, 0x0F, 0x32, 0xC4, 0x5C, 0xB4]};
@GUID(0x00F2CE1E, 0x935E, 0x4248, [0x89, 0x2C, 0x13, 0x0F, 0x32, 0xC4, 0x5C, 0xB4]);
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
    HRESULT ErrorAdvise(HRESULT hr, const(wchar)* pszErrorMessage, ERROR_ADVISE_MESSAGE_TYPE nMessageType, ERROR_ADVISE_RESULT* pnErrorAdviseResult);
    HRESULT GetUserInput(const(Guid)* riidType, IUnknown pUnknown, PROPVARIANT* pPropVarResult, const(PROPVARIANT)* pPropVarDefault);
}

const GUID IID_IPhotoProgressActionCB = {0x00F242D0, 0xB206, 0x4E7D, [0xB4, 0xC1, 0x47, 0x55, 0xBC, 0xBB, 0x9C, 0x9F]};
@GUID(0x00F242D0, 0xB206, 0x4E7D, [0xB4, 0xC1, 0x47, 0x55, 0xBC, 0xBB, 0x9C, 0x9F]);
interface IPhotoProgressActionCB : IUnknown
{
    HRESULT DoAction(HWND hWndParent);
}

enum PROGRESS_DIALOG_IMAGE_TYPE
{
    PROGRESS_DIALOG_ICON_SMALL = 0,
    PROGRESS_DIALOG_ICON_LARGE = 1,
    PROGRESS_DIALOG_ICON_THUMBNAIL = 2,
    PROGRESS_DIALOG_BITMAP_THUMBNAIL = 3,
}

enum PROGRESS_DIALOG_CHECKBOX_ID
{
    PROGRESS_DIALOG_CHECKBOX_ID_DEFAULT = 0,
}

const GUID IID_IPhotoProgressDialog = {0x00F246F9, 0x0750, 0x4F08, [0x93, 0x81, 0x2C, 0xD8, 0xE9, 0x06, 0xA4, 0xAE]};
@GUID(0x00F246F9, 0x0750, 0x4F08, [0x93, 0x81, 0x2C, 0xD8, 0xE9, 0x06, 0xA4, 0xAE]);
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
    HRESULT GetUserInput(const(Guid)* riidType, IUnknown pUnknown, PROPVARIANT* pPropVarResult, const(PROPVARIANT)* pPropVarDefault);
}

const GUID IID_IPhotoAcquireSource = {0x00F2C703, 0x8613, 0x4282, [0xA5, 0x3B, 0x6E, 0xC5, 0x9C, 0x58, 0x83, 0xAC]};
@GUID(0x00F2C703, 0x8613, 0x4282, [0xA5, 0x3B, 0x6E, 0xC5, 0x9C, 0x58, 0x83, 0xAC]);
interface IPhotoAcquireSource : IUnknown
{
    HRESULT GetFriendlyName(BSTR* pbstrFriendlyName);
    HRESULT GetDeviceIcons(uint nSize, HICON* phLargeIcon, HICON* phSmallIcon);
    HRESULT InitializeItemList(BOOL fForceEnumeration, IPhotoAcquireProgressCB pPhotoAcquireProgressCB, uint* pnItemCount);
    HRESULT GetItemCount(uint* pnItemCount);
    HRESULT GetItemAt(uint nIndex, IPhotoAcquireItem* ppPhotoAcquireItem);
    HRESULT GetPhotoAcquireSettings(IPhotoAcquireSettings* ppPhotoAcquireSettings);
    HRESULT GetDeviceId(BSTR* pbstrDeviceId);
    HRESULT BindToObject(const(Guid)* riid, void** ppv);
}

const GUID IID_IPhotoAcquire = {0x00F23353, 0xE31B, 0x4955, [0xA8, 0xAD, 0xCA, 0x5E, 0xBF, 0x31, 0xE2, 0xCE]};
@GUID(0x00F23353, 0xE31B, 0x4955, [0xA8, 0xAD, 0xCA, 0x5E, 0xBF, 0x31, 0xE2, 0xCE]);
interface IPhotoAcquire : IUnknown
{
    HRESULT CreatePhotoSource(const(wchar)* pszDevice, IPhotoAcquireSource* ppPhotoAcquireSource);
    HRESULT Acquire(IPhotoAcquireSource pPhotoAcquireSource, BOOL fShowProgress, HWND hWndParent, const(wchar)* pszApplicationName, IPhotoAcquireProgressCB pPhotoAcquireProgressCB);
    HRESULT EnumResults(IEnumString* ppEnumFilePaths);
}

const GUID IID_IPhotoAcquireSettings = {0x00F2B868, 0xDD67, 0x487C, [0x95, 0x53, 0x04, 0x92, 0x40, 0x76, 0x7E, 0x91]};
@GUID(0x00F2B868, 0xDD67, 0x487C, [0x95, 0x53, 0x04, 0x92, 0x40, 0x76, 0x7E, 0x91]);
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

const GUID IID_IPhotoAcquireOptionsDialog = {0x00F2B3EE, 0xBF64, 0x47EE, [0x89, 0xF4, 0x4D, 0xED, 0xD7, 0x96, 0x43, 0xF2]};
@GUID(0x00F2B3EE, 0xBF64, 0x47EE, [0x89, 0xF4, 0x4D, 0xED, 0xD7, 0x96, 0x43, 0xF2]);
interface IPhotoAcquireOptionsDialog : IUnknown
{
    HRESULT Initialize(const(wchar)* pszRegistryRoot);
    HRESULT Create(HWND hWndParent, HWND* phWndDialog);
    HRESULT Destroy();
    HRESULT DoModal(HWND hWndParent, int* ppnReturnCode);
    HRESULT SaveData();
}

enum DEVICE_SELECTION_DEVICE_TYPE
{
    DST_UNKNOWN_DEVICE = 0,
    DST_WPD_DEVICE = 1,
    DST_WIA_DEVICE = 2,
    DST_STI_DEVICE = 3,
    DSF_TWAIN_DEVICE = 4,
    DST_FS_DEVICE = 5,
    DST_DV_DEVICE = 6,
}

const GUID IID_IPhotoAcquireDeviceSelectionDialog = {0x00F28837, 0x55DD, 0x4F37, [0xAA, 0xF5, 0x68, 0x55, 0xA9, 0x64, 0x04, 0x67]};
@GUID(0x00F28837, 0x55DD, 0x4F37, [0xAA, 0xF5, 0x68, 0x55, 0xA9, 0x64, 0x04, 0x67]);
interface IPhotoAcquireDeviceSelectionDialog : IUnknown
{
    HRESULT SetTitle(const(wchar)* pszTitle);
    HRESULT SetSubmitButtonText(const(wchar)* pszSubmitButtonText);
    HRESULT DoModal(HWND hWndParent, uint dwDeviceFlags, BSTR* pbstrDeviceId, DEVICE_SELECTION_DEVICE_TYPE* pnDeviceType);
}

const GUID IID_IPhotoAcquirePlugin = {0x00F2DCEB, 0xECB8, 0x4F77, [0x8E, 0x47, 0xE7, 0xA9, 0x87, 0xC8, 0x3D, 0xD0]};
@GUID(0x00F2DCEB, 0xECB8, 0x4F77, [0x8E, 0x47, 0xE7, 0xA9, 0x87, 0xC8, 0x3D, 0xD0]);
interface IPhotoAcquirePlugin : IUnknown
{
    HRESULT Initialize(IPhotoAcquireSource pPhotoAcquireSource, IPhotoAcquireProgressCB pPhotoAcquireProgressCB);
    HRESULT ProcessItem(uint dwAcquireStage, IPhotoAcquireItem pPhotoAcquireItem, IStream pOriginalItemStream, const(wchar)* pszFinalFilename, IPropertyStore pPropertyStore);
    HRESULT TransferComplete(HRESULT hr);
    HRESULT DisplayConfigureDialog(HWND hWndParent);
}

