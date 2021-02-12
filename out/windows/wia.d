module windows.wia;

public import system;
public import windows.automation;
public import windows.com;
public import windows.structuredstorage;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

struct WIA_DITHER_PATTERN_DATA
{
    int lSize;
    BSTR bstrPatternName;
    int lPatternWidth;
    int lPatternLength;
    int cbPattern;
    ubyte* pbPattern;
}

struct WIA_PROPID_TO_NAME
{
    uint propid;
    ushort* pszName;
}

struct WIA_FORMAT_INFO
{
    Guid guidFormatID;
    int lTymed;
}

const GUID IID_IWiaDevMgr = {0x5EB2502A, 0x8CF1, 0x11D1, [0xBF, 0x92, 0x00, 0x60, 0x08, 0x1E, 0xD8, 0x11]};
@GUID(0x5EB2502A, 0x8CF1, 0x11D1, [0xBF, 0x92, 0x00, 0x60, 0x08, 0x1E, 0xD8, 0x11]);
interface IWiaDevMgr : IUnknown
{
    HRESULT EnumDeviceInfo(int lFlag, IEnumWIA_DEV_INFO* ppIEnum);
    HRESULT CreateDevice(BSTR bstrDeviceID, IWiaItem* ppWiaItemRoot);
    HRESULT SelectDeviceDlg(HWND hwndParent, int lDeviceType, int lFlags, BSTR* pbstrDeviceID, IWiaItem* ppItemRoot);
    HRESULT SelectDeviceDlgID(HWND hwndParent, int lDeviceType, int lFlags, BSTR* pbstrDeviceID);
    HRESULT GetImageDlg(HWND hwndParent, int lDeviceType, int lFlags, int lIntent, IWiaItem pItemRoot, BSTR bstrFilename, Guid* pguidFormat);
    HRESULT RegisterEventCallbackProgram(int lFlags, BSTR bstrDeviceID, const(Guid)* pEventGUID, BSTR bstrCommandline, BSTR bstrName, BSTR bstrDescription, BSTR bstrIcon);
    HRESULT RegisterEventCallbackInterface(int lFlags, BSTR bstrDeviceID, const(Guid)* pEventGUID, IWiaEventCallback pIWiaEventCallback, IUnknown* pEventObject);
    HRESULT RegisterEventCallbackCLSID(int lFlags, BSTR bstrDeviceID, const(Guid)* pEventGUID, const(Guid)* pClsID, BSTR bstrName, BSTR bstrDescription, BSTR bstrIcon);
    HRESULT AddDeviceDlg(HWND hwndParent, int lFlags);
}

const GUID IID_IEnumWIA_DEV_INFO = {0x5E38B83C, 0x8CF1, 0x11D1, [0xBF, 0x92, 0x00, 0x60, 0x08, 0x1E, 0xD8, 0x11]};
@GUID(0x5E38B83C, 0x8CF1, 0x11D1, [0xBF, 0x92, 0x00, 0x60, 0x08, 0x1E, 0xD8, 0x11]);
interface IEnumWIA_DEV_INFO : IUnknown
{
    HRESULT Next(uint celt, IWiaPropertyStorage* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumWIA_DEV_INFO* ppIEnum);
    HRESULT GetCount(uint* celt);
}

const GUID IID_IWiaEventCallback = {0xAE6287B0, 0x0084, 0x11D2, [0x97, 0x3B, 0x00, 0xA0, 0xC9, 0x06, 0x8F, 0x2E]};
@GUID(0xAE6287B0, 0x0084, 0x11D2, [0x97, 0x3B, 0x00, 0xA0, 0xC9, 0x06, 0x8F, 0x2E]);
interface IWiaEventCallback : IUnknown
{
    HRESULT ImageEventCallback(const(Guid)* pEventGUID, BSTR bstrEventDescription, BSTR bstrDeviceID, BSTR bstrDeviceDescription, uint dwDeviceType, BSTR bstrFullItemName, uint* pulEventType, uint ulReserved);
}

struct WIA_DATA_CALLBACK_HEADER
{
    int lSize;
    Guid guidFormatID;
    int lBufferSize;
    int lPageCount;
}

const GUID IID_IWiaDataCallback = {0xA558A866, 0xA5B0, 0x11D2, [0xA0, 0x8F, 0x00, 0xC0, 0x4F, 0x72, 0xDC, 0x3C]};
@GUID(0xA558A866, 0xA5B0, 0x11D2, [0xA0, 0x8F, 0x00, 0xC0, 0x4F, 0x72, 0xDC, 0x3C]);
interface IWiaDataCallback : IUnknown
{
    HRESULT BandedDataCallback(int lMessage, int lStatus, int lPercentComplete, int lOffset, int lLength, int lReserved, int lResLength, ubyte* pbBuffer);
}

struct WIA_DATA_TRANSFER_INFO
{
    uint ulSize;
    uint ulSection;
    uint ulBufferSize;
    BOOL bDoubleBuffer;
    uint ulReserved1;
    uint ulReserved2;
    uint ulReserved3;
}

struct WIA_EXTENDED_TRANSFER_INFO
{
    uint ulSize;
    uint ulMinBufferSize;
    uint ulOptimalBufferSize;
    uint ulMaxBufferSize;
    uint ulNumBuffers;
}

const GUID IID_IWiaDataTransfer = {0xA6CEF998, 0xA5B0, 0x11D2, [0xA0, 0x8F, 0x00, 0xC0, 0x4F, 0x72, 0xDC, 0x3C]};
@GUID(0xA6CEF998, 0xA5B0, 0x11D2, [0xA0, 0x8F, 0x00, 0xC0, 0x4F, 0x72, 0xDC, 0x3C]);
interface IWiaDataTransfer : IUnknown
{
    HRESULT idtGetData(STGMEDIUM* pMedium, IWiaDataCallback pIWiaDataCallback);
    HRESULT idtGetBandedData(WIA_DATA_TRANSFER_INFO* pWiaDataTransInfo, IWiaDataCallback pIWiaDataCallback);
    HRESULT idtQueryGetData(WIA_FORMAT_INFO* pfe);
    HRESULT idtEnumWIA_FORMAT_INFO(IEnumWIA_FORMAT_INFO* ppEnum);
    HRESULT idtGetExtendedTransferInfo(WIA_EXTENDED_TRANSFER_INFO* pExtendedTransferInfo);
}

const GUID IID_IWiaItem = {0x4DB1AD10, 0x3391, 0x11D2, [0x9A, 0x33, 0x00, 0xC0, 0x4F, 0xA3, 0x61, 0x45]};
@GUID(0x4DB1AD10, 0x3391, 0x11D2, [0x9A, 0x33, 0x00, 0xC0, 0x4F, 0xA3, 0x61, 0x45]);
interface IWiaItem : IUnknown
{
    HRESULT GetItemType(int* pItemType);
    HRESULT AnalyzeItem(int lFlags);
    HRESULT EnumChildItems(IEnumWiaItem* ppIEnumWiaItem);
    HRESULT DeleteItem(int lFlags);
    HRESULT CreateChildItem(int lFlags, BSTR bstrItemName, BSTR bstrFullItemName, IWiaItem* ppIWiaItem);
    HRESULT EnumRegisterEventInfo(int lFlags, const(Guid)* pEventGUID, IEnumWIA_DEV_CAPS* ppIEnum);
    HRESULT FindItemByName(int lFlags, BSTR bstrFullItemName, IWiaItem* ppIWiaItem);
    HRESULT DeviceDlg(HWND hwndParent, int lFlags, int lIntent, int* plItemCount, IWiaItem** ppIWiaItem);
    HRESULT DeviceCommand(int lFlags, const(Guid)* pCmdGUID, IWiaItem* pIWiaItem);
    HRESULT GetRootItem(IWiaItem* ppIWiaItem);
    HRESULT EnumDeviceCapabilities(int lFlags, IEnumWIA_DEV_CAPS* ppIEnumWIA_DEV_CAPS);
    HRESULT DumpItemData(BSTR* bstrData);
    HRESULT DumpDrvItemData(BSTR* bstrData);
    HRESULT DumpTreeItemData(BSTR* bstrData);
    HRESULT Diagnostic(uint ulSize, char* pBuffer);
}

const GUID IID_IWiaPropertyStorage = {0x98B5E8A0, 0x29CC, 0x491A, [0xAA, 0xC0, 0xE6, 0xDB, 0x4F, 0xDC, 0xCE, 0xB6]};
@GUID(0x98B5E8A0, 0x29CC, 0x491A, [0xAA, 0xC0, 0xE6, 0xDB, 0x4F, 0xDC, 0xCE, 0xB6]);
interface IWiaPropertyStorage : IUnknown
{
    HRESULT ReadMultiple(uint cpspec, char* rgpspec, char* rgpropvar);
    HRESULT WriteMultiple(uint cpspec, const(PROPSPEC)* rgpspec, const(PROPVARIANT)* rgpropvar, uint propidNameFirst);
    HRESULT DeleteMultiple(uint cpspec, char* rgpspec);
    HRESULT ReadPropertyNames(uint cpropid, char* rgpropid, char* rglpwstrName);
    HRESULT WritePropertyNames(uint cpropid, char* rgpropid, char* rglpwstrName);
    HRESULT DeletePropertyNames(uint cpropid, char* rgpropid);
    HRESULT Commit(uint grfCommitFlags);
    HRESULT Revert();
    HRESULT Enum(IEnumSTATPROPSTG* ppenum);
    HRESULT SetTimes(const(FILETIME)* pctime, const(FILETIME)* patime, const(FILETIME)* pmtime);
    HRESULT SetClass(const(Guid)* clsid);
    HRESULT Stat(STATPROPSETSTG* pstatpsstg);
    HRESULT GetPropertyAttributes(uint cpspec, char* rgpspec, char* rgflags, char* rgpropvar);
    HRESULT GetCount(uint* pulNumProps);
    HRESULT GetPropertyStream(Guid* pCompatibilityId, IStream* ppIStream);
    HRESULT SetPropertyStream(Guid* pCompatibilityId, IStream pIStream);
}

const GUID IID_IEnumWiaItem = {0x5E8383FC, 0x3391, 0x11D2, [0x9A, 0x33, 0x00, 0xC0, 0x4F, 0xA3, 0x61, 0x45]};
@GUID(0x5E8383FC, 0x3391, 0x11D2, [0x9A, 0x33, 0x00, 0xC0, 0x4F, 0xA3, 0x61, 0x45]);
interface IEnumWiaItem : IUnknown
{
    HRESULT Next(uint celt, IWiaItem* ppIWiaItem, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumWiaItem* ppIEnum);
    HRESULT GetCount(uint* celt);
}

struct WIA_DEV_CAP
{
    Guid guid;
    uint ulFlags;
    BSTR bstrName;
    BSTR bstrDescription;
    BSTR bstrIcon;
    BSTR bstrCommandline;
}

const GUID IID_IEnumWIA_DEV_CAPS = {0x1FCC4287, 0xACA6, 0x11D2, [0xA0, 0x93, 0x00, 0xC0, 0x4F, 0x72, 0xDC, 0x3C]};
@GUID(0x1FCC4287, 0xACA6, 0x11D2, [0xA0, 0x93, 0x00, 0xC0, 0x4F, 0x72, 0xDC, 0x3C]);
interface IEnumWIA_DEV_CAPS : IUnknown
{
    HRESULT Next(uint celt, WIA_DEV_CAP* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumWIA_DEV_CAPS* ppIEnum);
    HRESULT GetCount(uint* pcelt);
}

const GUID IID_IEnumWIA_FORMAT_INFO = {0x81BEFC5B, 0x656D, 0x44F1, [0xB2, 0x4C, 0xD4, 0x1D, 0x51, 0xB4, 0xDC, 0x81]};
@GUID(0x81BEFC5B, 0x656D, 0x44F1, [0xB2, 0x4C, 0xD4, 0x1D, 0x51, 0xB4, 0xDC, 0x81]);
interface IEnumWIA_FORMAT_INFO : IUnknown
{
    HRESULT Next(uint celt, WIA_FORMAT_INFO* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumWIA_FORMAT_INFO* ppIEnum);
    HRESULT GetCount(uint* pcelt);
}

const GUID IID_IWiaLog = {0xA00C10B6, 0x82A1, 0x452F, [0x8B, 0x6C, 0x86, 0x06, 0x2A, 0xAD, 0x68, 0x90]};
@GUID(0xA00C10B6, 0x82A1, 0x452F, [0x8B, 0x6C, 0x86, 0x06, 0x2A, 0xAD, 0x68, 0x90]);
interface IWiaLog : IUnknown
{
    HRESULT InitializeLog(int hInstance);
    HRESULT hResult(HRESULT hResult);
    HRESULT Log(int lFlags, int lResID, int lDetail, BSTR bstrText);
}

const GUID IID_IWiaLogEx = {0xAF1F22AC, 0x7A40, 0x4787, [0xB4, 0x21, 0xAE, 0xB4, 0x7A, 0x1F, 0xBD, 0x0B]};
@GUID(0xAF1F22AC, 0x7A40, 0x4787, [0xB4, 0x21, 0xAE, 0xB4, 0x7A, 0x1F, 0xBD, 0x0B]);
interface IWiaLogEx : IUnknown
{
    HRESULT InitializeLogEx(ubyte* hInstance);
    HRESULT hResult(HRESULT hResult);
    HRESULT Log(int lFlags, int lResID, int lDetail, BSTR bstrText);
    HRESULT hResultEx(int lMethodId, HRESULT hResult);
    HRESULT LogEx(int lMethodId, int lFlags, int lResID, int lDetail, BSTR bstrText);
}

const GUID IID_IWiaNotifyDevMgr = {0x70681EA0, 0xE7BF, 0x4291, [0x9F, 0xB1, 0x4E, 0x88, 0x13, 0xA3, 0xF7, 0x8E]};
@GUID(0x70681EA0, 0xE7BF, 0x4291, [0x9F, 0xB1, 0x4E, 0x88, 0x13, 0xA3, 0xF7, 0x8E]);
interface IWiaNotifyDevMgr : IUnknown
{
    HRESULT NewDeviceArrival();
}

const GUID IID_IWiaItemExtras = {0x6291EF2C, 0x36EF, 0x4532, [0x87, 0x6A, 0x8E, 0x13, 0x25, 0x93, 0x77, 0x8D]};
@GUID(0x6291EF2C, 0x36EF, 0x4532, [0x87, 0x6A, 0x8E, 0x13, 0x25, 0x93, 0x77, 0x8D]);
interface IWiaItemExtras : IUnknown
{
    HRESULT GetExtendedErrorInfo(BSTR* bstrErrorText);
    HRESULT Escape(uint dwEscapeCode, char* lpInData, uint cbInDataSize, char* pOutData, uint dwOutDataSize, uint* pdwActualDataSize);
    HRESULT CancelPendingIO();
}

const GUID CLSID_WiaVideo = {0x3908C3CD, 0x4478, 0x4536, [0xAF, 0x2F, 0x10, 0xC2, 0x5D, 0x4E, 0xF8, 0x9A]};
@GUID(0x3908C3CD, 0x4478, 0x4536, [0xAF, 0x2F, 0x10, 0xC2, 0x5D, 0x4E, 0xF8, 0x9A]);
struct WiaVideo;

enum WIAVIDEO_STATE
{
    WIAVIDEO_NO_VIDEO = 1,
    WIAVIDEO_CREATING_VIDEO = 2,
    WIAVIDEO_VIDEO_CREATED = 3,
    WIAVIDEO_VIDEO_PLAYING = 4,
    WIAVIDEO_VIDEO_PAUSED = 5,
    WIAVIDEO_DESTROYING_VIDEO = 6,
}

const GUID IID_IWiaVideo = {0xD52920AA, 0xDB88, 0x41F0, [0x94, 0x6C, 0xE0, 0x0D, 0xC0, 0xA1, 0x9C, 0xFA]};
@GUID(0xD52920AA, 0xDB88, 0x41F0, [0x94, 0x6C, 0xE0, 0x0D, 0xC0, 0xA1, 0x9C, 0xFA]);
interface IWiaVideo : IUnknown
{
    HRESULT get_PreviewVisible(int* pbPreviewVisible);
    HRESULT put_PreviewVisible(BOOL bPreviewVisible);
    HRESULT get_ImagesDirectory(BSTR* pbstrImageDirectory);
    HRESULT put_ImagesDirectory(BSTR bstrImageDirectory);
    HRESULT CreateVideoByWiaDevID(BSTR bstrWiaDeviceID, HWND hwndParent, BOOL bStretchToFitParent, BOOL bAutoBeginPlayback);
    HRESULT CreateVideoByDevNum(uint uiDeviceNumber, HWND hwndParent, BOOL bStretchToFitParent, BOOL bAutoBeginPlayback);
    HRESULT CreateVideoByName(BSTR bstrFriendlyName, HWND hwndParent, BOOL bStretchToFitParent, BOOL bAutoBeginPlayback);
    HRESULT DestroyVideo();
    HRESULT Play();
    HRESULT Pause();
    HRESULT TakePicture(BSTR* pbstrNewImageFilename);
    HRESULT ResizeVideo(BOOL bStretchToFitParent);
    HRESULT GetCurrentState(WIAVIDEO_STATE* pState);
}

