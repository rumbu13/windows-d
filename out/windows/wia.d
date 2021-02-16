module windows.wia;

public import windows.core;
public import windows.automation : BSTR;
public import windows.com : HRESULT, IUnknown, STGMEDIUM;
public import windows.structuredstorage : IEnumSTATPROPSTG, IStream, PROPSPEC, PROPVARIANT, STATPROPSETSTG;
public import windows.systemservices : BOOL;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Enums


enum : int
{
    WIAVIDEO_NO_VIDEO         = 0x00000001,
    WIAVIDEO_CREATING_VIDEO   = 0x00000002,
    WIAVIDEO_VIDEO_CREATED    = 0x00000003,
    WIAVIDEO_VIDEO_PLAYING    = 0x00000004,
    WIAVIDEO_VIDEO_PAUSED     = 0x00000005,
    WIAVIDEO_DESTROYING_VIDEO = 0x00000006,
}
alias WIAVIDEO_STATE = int;

// Structs


struct WIA_DITHER_PATTERN_DATA
{
    int    lSize;
    BSTR   bstrPatternName;
    int    lPatternWidth;
    int    lPatternLength;
    int    cbPattern;
    ubyte* pbPattern;
}

struct WIA_PROPID_TO_NAME
{
    uint    propid;
    ushort* pszName;
}

struct WIA_FORMAT_INFO
{
    GUID guidFormatID;
    int  lTymed;
}

struct WIA_DATA_CALLBACK_HEADER
{
    int  lSize;
    GUID guidFormatID;
    int  lBufferSize;
    int  lPageCount;
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

struct WIA_DEV_CAP
{
    GUID guid;
    uint ulFlags;
    BSTR bstrName;
    BSTR bstrDescription;
    BSTR bstrIcon;
    BSTR bstrCommandline;
}

// Interfaces

@GUID("3908C3CD-4478-4536-AF2F-10C25D4EF89A")
struct WiaVideo;

@GUID("5EB2502A-8CF1-11D1-BF92-0060081ED811")
interface IWiaDevMgr : IUnknown
{
    HRESULT EnumDeviceInfo(int lFlag, IEnumWIA_DEV_INFO* ppIEnum);
    HRESULT CreateDevice(BSTR bstrDeviceID, IWiaItem* ppWiaItemRoot);
    HRESULT SelectDeviceDlg(HWND hwndParent, int lDeviceType, int lFlags, BSTR* pbstrDeviceID, 
                            IWiaItem* ppItemRoot);
    HRESULT SelectDeviceDlgID(HWND hwndParent, int lDeviceType, int lFlags, BSTR* pbstrDeviceID);
    HRESULT GetImageDlg(HWND hwndParent, int lDeviceType, int lFlags, int lIntent, IWiaItem pItemRoot, 
                        BSTR bstrFilename, GUID* pguidFormat);
    HRESULT RegisterEventCallbackProgram(int lFlags, BSTR bstrDeviceID, const(GUID)* pEventGUID, 
                                         BSTR bstrCommandline, BSTR bstrName, BSTR bstrDescription, BSTR bstrIcon);
    HRESULT RegisterEventCallbackInterface(int lFlags, BSTR bstrDeviceID, const(GUID)* pEventGUID, 
                                           IWiaEventCallback pIWiaEventCallback, IUnknown* pEventObject);
    HRESULT RegisterEventCallbackCLSID(int lFlags, BSTR bstrDeviceID, const(GUID)* pEventGUID, const(GUID)* pClsID, 
                                       BSTR bstrName, BSTR bstrDescription, BSTR bstrIcon);
    HRESULT AddDeviceDlg(HWND hwndParent, int lFlags);
}

@GUID("5E38B83C-8CF1-11D1-BF92-0060081ED811")
interface IEnumWIA_DEV_INFO : IUnknown
{
    HRESULT Next(uint celt, IWiaPropertyStorage* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumWIA_DEV_INFO* ppIEnum);
    HRESULT GetCount(uint* celt);
}

@GUID("AE6287B0-0084-11D2-973B-00A0C9068F2E")
interface IWiaEventCallback : IUnknown
{
    HRESULT ImageEventCallback(const(GUID)* pEventGUID, BSTR bstrEventDescription, BSTR bstrDeviceID, 
                               BSTR bstrDeviceDescription, uint dwDeviceType, BSTR bstrFullItemName, 
                               uint* pulEventType, uint ulReserved);
}

@GUID("A558A866-A5B0-11D2-A08F-00C04F72DC3C")
interface IWiaDataCallback : IUnknown
{
    HRESULT BandedDataCallback(int lMessage, int lStatus, int lPercentComplete, int lOffset, int lLength, 
                               int lReserved, int lResLength, ubyte* pbBuffer);
}

@GUID("A6CEF998-A5B0-11D2-A08F-00C04F72DC3C")
interface IWiaDataTransfer : IUnknown
{
    HRESULT idtGetData(STGMEDIUM* pMedium, IWiaDataCallback pIWiaDataCallback);
    HRESULT idtGetBandedData(WIA_DATA_TRANSFER_INFO* pWiaDataTransInfo, IWiaDataCallback pIWiaDataCallback);
    HRESULT idtQueryGetData(WIA_FORMAT_INFO* pfe);
    HRESULT idtEnumWIA_FORMAT_INFO(IEnumWIA_FORMAT_INFO* ppEnum);
    HRESULT idtGetExtendedTransferInfo(WIA_EXTENDED_TRANSFER_INFO* pExtendedTransferInfo);
}

@GUID("4DB1AD10-3391-11D2-9A33-00C04FA36145")
interface IWiaItem : IUnknown
{
    HRESULT GetItemType(int* pItemType);
    HRESULT AnalyzeItem(int lFlags);
    HRESULT EnumChildItems(IEnumWiaItem* ppIEnumWiaItem);
    HRESULT DeleteItem(int lFlags);
    HRESULT CreateChildItem(int lFlags, BSTR bstrItemName, BSTR bstrFullItemName, IWiaItem* ppIWiaItem);
    HRESULT EnumRegisterEventInfo(int lFlags, const(GUID)* pEventGUID, IEnumWIA_DEV_CAPS* ppIEnum);
    HRESULT FindItemByName(int lFlags, BSTR bstrFullItemName, IWiaItem* ppIWiaItem);
    HRESULT DeviceDlg(HWND hwndParent, int lFlags, int lIntent, int* plItemCount, IWiaItem** ppIWiaItem);
    HRESULT DeviceCommand(int lFlags, const(GUID)* pCmdGUID, IWiaItem* pIWiaItem);
    HRESULT GetRootItem(IWiaItem* ppIWiaItem);
    HRESULT EnumDeviceCapabilities(int lFlags, IEnumWIA_DEV_CAPS* ppIEnumWIA_DEV_CAPS);
    HRESULT DumpItemData(BSTR* bstrData);
    HRESULT DumpDrvItemData(BSTR* bstrData);
    HRESULT DumpTreeItemData(BSTR* bstrData);
    HRESULT Diagnostic(uint ulSize, char* pBuffer);
}

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
    HRESULT GetPropertyAttributes(uint cpspec, char* rgpspec, char* rgflags, char* rgpropvar);
    HRESULT GetCount(uint* pulNumProps);
    HRESULT GetPropertyStream(GUID* pCompatibilityId, IStream* ppIStream);
    HRESULT SetPropertyStream(GUID* pCompatibilityId, IStream pIStream);
}

@GUID("5E8383FC-3391-11D2-9A33-00C04FA36145")
interface IEnumWiaItem : IUnknown
{
    HRESULT Next(uint celt, IWiaItem* ppIWiaItem, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumWiaItem* ppIEnum);
    HRESULT GetCount(uint* celt);
}

@GUID("1FCC4287-ACA6-11D2-A093-00C04F72DC3C")
interface IEnumWIA_DEV_CAPS : IUnknown
{
    HRESULT Next(uint celt, WIA_DEV_CAP* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumWIA_DEV_CAPS* ppIEnum);
    HRESULT GetCount(uint* pcelt);
}

@GUID("81BEFC5B-656D-44F1-B24C-D41D51B4DC81")
interface IEnumWIA_FORMAT_INFO : IUnknown
{
    HRESULT Next(uint celt, WIA_FORMAT_INFO* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumWIA_FORMAT_INFO* ppIEnum);
    HRESULT GetCount(uint* pcelt);
}

@GUID("A00C10B6-82A1-452F-8B6C-86062AAD6890")
interface IWiaLog : IUnknown
{
    HRESULT InitializeLog(int hInstance);
    HRESULT hResult(HRESULT hResult);
    HRESULT Log(int lFlags, int lResID, int lDetail, BSTR bstrText);
}

@GUID("AF1F22AC-7A40-4787-B421-AEB47A1FBD0B")
interface IWiaLogEx : IUnknown
{
    HRESULT InitializeLogEx(ubyte* hInstance);
    HRESULT hResult(HRESULT hResult);
    HRESULT Log(int lFlags, int lResID, int lDetail, BSTR bstrText);
    HRESULT hResultEx(int lMethodId, HRESULT hResult);
    HRESULT LogEx(int lMethodId, int lFlags, int lResID, int lDetail, BSTR bstrText);
}

@GUID("70681EA0-E7BF-4291-9FB1-4E8813A3F78E")
interface IWiaNotifyDevMgr : IUnknown
{
    HRESULT NewDeviceArrival();
}

@GUID("6291EF2C-36EF-4532-876A-8E132593778D")
interface IWiaItemExtras : IUnknown
{
    HRESULT GetExtendedErrorInfo(BSTR* bstrErrorText);
    HRESULT Escape(uint dwEscapeCode, char* lpInData, uint cbInDataSize, char* pOutData, uint dwOutDataSize, 
                   uint* pdwActualDataSize);
    HRESULT CancelPendingIO();
}

@GUID("D52920AA-DB88-41F0-946C-E00DC0A19CFA")
interface IWiaVideo : IUnknown
{
    HRESULT get_PreviewVisible(int* pbPreviewVisible);
    HRESULT put_PreviewVisible(BOOL bPreviewVisible);
    HRESULT get_ImagesDirectory(BSTR* pbstrImageDirectory);
    HRESULT put_ImagesDirectory(BSTR bstrImageDirectory);
    HRESULT CreateVideoByWiaDevID(BSTR bstrWiaDeviceID, HWND hwndParent, BOOL bStretchToFitParent, 
                                  BOOL bAutoBeginPlayback);
    HRESULT CreateVideoByDevNum(uint uiDeviceNumber, HWND hwndParent, BOOL bStretchToFitParent, 
                                BOOL bAutoBeginPlayback);
    HRESULT CreateVideoByName(BSTR bstrFriendlyName, HWND hwndParent, BOOL bStretchToFitParent, 
                              BOOL bAutoBeginPlayback);
    HRESULT DestroyVideo();
    HRESULT Play();
    HRESULT Pause();
    HRESULT TakePicture(BSTR* pbstrNewImageFilename);
    HRESULT ResizeVideo(BOOL bStretchToFitParent);
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
