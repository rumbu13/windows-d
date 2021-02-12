module windows.networkdiagnosticsframework;

public import system;
public import windows.com;
public import windows.networkdrivers;
public import windows.security;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

enum ATTRIBUTE_TYPE
{
    AT_INVALID = 0,
    AT_BOOLEAN = 1,
    AT_INT8 = 2,
    AT_UINT8 = 3,
    AT_INT16 = 4,
    AT_UINT16 = 5,
    AT_INT32 = 6,
    AT_UINT32 = 7,
    AT_INT64 = 8,
    AT_UINT64 = 9,
    AT_STRING = 10,
    AT_GUID = 11,
    AT_LIFE_TIME = 12,
    AT_SOCKADDR = 13,
    AT_OCTET_STRING = 14,
}

struct OCTET_STRING
{
    uint dwLength;
    ubyte* lpValue;
}

struct LIFE_TIME
{
    FILETIME startTime;
    FILETIME endTime;
}

struct DIAG_SOCKADDR
{
    ushort family;
    byte data;
}

struct HELPER_ATTRIBUTE
{
    const(wchar)* pwszName;
    ATTRIBUTE_TYPE type;
    _Anonymous_e__Union Anonymous;
}

enum REPAIR_SCOPE
{
    RS_SYSTEM = 0,
    RS_USER = 1,
    RS_APPLICATION = 2,
    RS_PROCESS = 3,
}

enum REPAIR_RISK
{
    RR_NOROLLBACK = 0,
    RR_ROLLBACK = 1,
    RR_NORISK = 2,
}

enum UI_INFO_TYPE
{
    UIT_INVALID = 0,
    UIT_NONE = 1,
    UIT_SHELL_COMMAND = 2,
    UIT_HELP_PANE = 3,
    UIT_DUI = 4,
}

struct ShellCommandInfo
{
    const(wchar)* pwszOperation;
    const(wchar)* pwszFile;
    const(wchar)* pwszParameters;
    const(wchar)* pwszDirectory;
    uint nShowCmd;
}

struct UiInfo
{
    UI_INFO_TYPE type;
    _Anonymous_e__Union Anonymous;
}

struct RepairInfo
{
    Guid guid;
    const(wchar)* pwszClassName;
    const(wchar)* pwszDescription;
    uint sidType;
    int cost;
    uint flags;
    REPAIR_SCOPE scope;
    REPAIR_RISK risk;
    UiInfo UiInfo;
    int rootCauseIndex;
}

struct RepairInfoEx
{
    RepairInfo repair;
    ushort repairRank;
}

struct RootCauseInfo
{
    const(wchar)* pwszDescription;
    Guid rootCauseID;
    uint rootCauseFlags;
    Guid networkInterfaceID;
    RepairInfoEx* pRepairs;
    ushort repairCount;
}

enum DIAGNOSIS_STATUS
{
    DS_NOT_IMPLEMENTED = 0,
    DS_CONFIRMED = 1,
    DS_REJECTED = 2,
    DS_INDETERMINATE = 3,
    DS_DEFERRED = 4,
    DS_PASSTHROUGH = 5,
}

enum REPAIR_STATUS
{
    RS_NOT_IMPLEMENTED = 0,
    RS_REPAIRED = 1,
    RS_UNREPAIRED = 2,
    RS_DEFERRED = 3,
    RS_USER_ACTION = 4,
}

enum PROBLEM_TYPE
{
    PT_INVALID = 0,
    PT_LOW_HEALTH = 1,
    PT_LOWER_HEALTH = 2,
    PT_DOWN_STREAM_HEALTH = 4,
    PT_HIGH_UTILIZATION = 8,
    PT_HIGHER_UTILIZATION = 16,
    PT_UP_STREAM_UTILIZATION = 32,
}

struct HYPOTHESIS
{
    const(wchar)* pwszClassName;
    const(wchar)* pwszDescription;
    uint celt;
    HELPER_ATTRIBUTE* rgAttributes;
}

struct HelperAttributeInfo
{
    const(wchar)* pwszName;
    ATTRIBUTE_TYPE type;
}

struct DiagnosticsInfo
{
    int cost;
    uint flags;
}

const GUID IID_INetDiagHelper = {0xC0B35746, 0xEBF5, 0x11D8, [0xBB, 0xE9, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0xC0B35746, 0xEBF5, 0x11D8, [0xBB, 0xE9, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
interface INetDiagHelper : IUnknown
{
    HRESULT Initialize(uint celt, char* rgAttributes);
    HRESULT GetDiagnosticsInfo(DiagnosticsInfo** ppInfo);
    HRESULT GetKeyAttributes(uint* pcelt, char* pprgAttributes);
    HRESULT LowHealth(const(wchar)* pwszInstanceDescription, ushort** ppwszDescription, int* pDeferredTime, DIAGNOSIS_STATUS* pStatus);
    HRESULT HighUtilization(const(wchar)* pwszInstanceDescription, ushort** ppwszDescription, int* pDeferredTime, DIAGNOSIS_STATUS* pStatus);
    HRESULT GetLowerHypotheses(uint* pcelt, char* pprgHypotheses);
    HRESULT GetDownStreamHypotheses(uint* pcelt, char* pprgHypotheses);
    HRESULT GetHigherHypotheses(uint* pcelt, char* pprgHypotheses);
    HRESULT GetUpStreamHypotheses(uint* pcelt, char* pprgHypotheses);
    HRESULT Repair(RepairInfo* pInfo, int* pDeferredTime, REPAIR_STATUS* pStatus);
    HRESULT Validate(PROBLEM_TYPE problem, int* pDeferredTime, REPAIR_STATUS* pStatus);
    HRESULT GetRepairInfo(PROBLEM_TYPE problem, uint* pcelt, char* ppInfo);
    HRESULT GetLifeTime(LIFE_TIME* pLifeTime);
    HRESULT SetLifeTime(LIFE_TIME lifeTime);
    HRESULT GetCacheTime(FILETIME* pCacheTime);
    HRESULT GetAttributes(uint* pcelt, char* pprgAttributes);
    HRESULT Cancel();
    HRESULT Cleanup();
}

struct HypothesisResult
{
    HYPOTHESIS hypothesis;
    DIAGNOSIS_STATUS pathStatus;
}

const GUID IID_INetDiagHelperUtilFactory = {0x104613FB, 0xBC57, 0x4178, [0x95, 0xBA, 0x88, 0x80, 0x96, 0x98, 0x35, 0x4A]};
@GUID(0x104613FB, 0xBC57, 0x4178, [0x95, 0xBA, 0x88, 0x80, 0x96, 0x98, 0x35, 0x4A]);
interface INetDiagHelperUtilFactory : IUnknown
{
    HRESULT CreateUtilityInstance(const(Guid)* riid, void** ppvObject);
}

const GUID IID_INetDiagHelperEx = {0x972DAB4D, 0xE4E3, 0x4FC6, [0xAE, 0x54, 0x5F, 0x65, 0xCC, 0xDE, 0x4A, 0x15]};
@GUID(0x972DAB4D, 0xE4E3, 0x4FC6, [0xAE, 0x54, 0x5F, 0x65, 0xCC, 0xDE, 0x4A, 0x15]);
interface INetDiagHelperEx : IUnknown
{
    HRESULT ReconfirmLowHealth(uint celt, char* pResults, ushort** ppwszUpdatedDescription, DIAGNOSIS_STATUS* pUpdatedStatus);
    HRESULT SetUtilities(INetDiagHelperUtilFactory pUtilities);
    HRESULT ReproduceFailure();
}

const GUID IID_INetDiagHelperInfo = {0xC0B35747, 0xEBF5, 0x11D8, [0xBB, 0xE9, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0xC0B35747, 0xEBF5, 0x11D8, [0xBB, 0xE9, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
interface INetDiagHelperInfo : IUnknown
{
    HRESULT GetAttributeInfo(uint* pcelt, char* pprgAttributeInfos);
}

const GUID IID_INetDiagExtensibleHelper = {0xC0B35748, 0xEBF5, 0x11D8, [0xBB, 0xE9, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0xC0B35748, 0xEBF5, 0x11D8, [0xBB, 0xE9, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
interface INetDiagExtensibleHelper : IUnknown
{
    HRESULT ResolveAttributes(uint celt, char* rgKeyAttributes, uint* pcelt, char* prgMatchValues);
}

@DllImport("NDFAPI.dll")
HRESULT NdfCreateIncident(const(wchar)* helperClassName, uint celt, char* attributes, void** handle);

@DllImport("NDFAPI.dll")
HRESULT NdfCreateWinSockIncident(uint sock, const(wchar)* host, ushort port, const(wchar)* appId, SID* userId, void** handle);

@DllImport("NDFAPI.dll")
HRESULT NdfCreateWebIncident(const(wchar)* url, void** handle);

@DllImport("NDFAPI.dll")
HRESULT NdfCreateWebIncidentEx(const(wchar)* url, BOOL useWinHTTP, const(wchar)* moduleName, void** handle);

@DllImport("NDFAPI.dll")
HRESULT NdfCreateSharingIncident(const(wchar)* UNCPath, void** handle);

@DllImport("NDFAPI.dll")
HRESULT NdfCreateDNSIncident(const(wchar)* hostname, ushort queryType, void** handle);

@DllImport("NDFAPI.dll")
HRESULT NdfCreateConnectivityIncident(void** handle);

@DllImport("NDFAPI.dll")
HRESULT NdfCreateNetConnectionIncident(void** handle, Guid id);

@DllImport("NDFAPI.dll")
HRESULT NdfCreatePnrpIncident(const(wchar)* cloudname, const(wchar)* peername, BOOL diagnosePublish, const(wchar)* appId, void** handle);

@DllImport("NDFAPI.dll")
HRESULT NdfCreateGroupingIncident(const(wchar)* CloudName, const(wchar)* GroupName, const(wchar)* Identity, const(wchar)* Invitation, SOCKET_ADDRESS_LIST* Addresses, const(wchar)* appId, void** handle);

@DllImport("NDFAPI.dll")
HRESULT NdfExecuteDiagnosis(void* handle, HWND hwnd);

@DllImport("NDFAPI.dll")
HRESULT NdfCloseIncident(void* handle);

@DllImport("NDFAPI.dll")
HRESULT NdfDiagnoseIncident(void* Handle, uint* RootCauseCount, RootCauseInfo** RootCauses, uint dwWait, uint dwFlags);

@DllImport("NDFAPI.dll")
HRESULT NdfRepairIncident(void* Handle, RepairInfoEx* RepairEx, uint dwWait);

@DllImport("NDFAPI.dll")
HRESULT NdfCancelIncident(void* Handle);

@DllImport("NDFAPI.dll")
HRESULT NdfGetTraceFile(void* Handle, ushort** TraceFileLocation);

