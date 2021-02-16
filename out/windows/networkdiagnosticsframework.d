module windows.networkdiagnosticsframework;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.networkdrivers : SOCKET_ADDRESS_LIST;
public import windows.security : SID;
public import windows.systemservices : BOOL;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Enums


enum : int
{
    AT_INVALID      = 0x00000000,
    AT_BOOLEAN      = 0x00000001,
    AT_INT8         = 0x00000002,
    AT_UINT8        = 0x00000003,
    AT_INT16        = 0x00000004,
    AT_UINT16       = 0x00000005,
    AT_INT32        = 0x00000006,
    AT_UINT32       = 0x00000007,
    AT_INT64        = 0x00000008,
    AT_UINT64       = 0x00000009,
    AT_STRING       = 0x0000000a,
    AT_GUID         = 0x0000000b,
    AT_LIFE_TIME    = 0x0000000c,
    AT_SOCKADDR     = 0x0000000d,
    AT_OCTET_STRING = 0x0000000e,
}
alias ATTRIBUTE_TYPE = int;

enum : int
{
    RS_SYSTEM      = 0x00000000,
    RS_USER        = 0x00000001,
    RS_APPLICATION = 0x00000002,
    RS_PROCESS     = 0x00000003,
}
alias REPAIR_SCOPE = int;

enum : int
{
    RR_NOROLLBACK = 0x00000000,
    RR_ROLLBACK   = 0x00000001,
    RR_NORISK     = 0x00000002,
}
alias REPAIR_RISK = int;

enum : int
{
    UIT_INVALID       = 0x00000000,
    UIT_NONE          = 0x00000001,
    UIT_SHELL_COMMAND = 0x00000002,
    UIT_HELP_PANE     = 0x00000003,
    UIT_DUI           = 0x00000004,
}
alias UI_INFO_TYPE = int;

enum : int
{
    DS_NOT_IMPLEMENTED = 0x00000000,
    DS_CONFIRMED       = 0x00000001,
    DS_REJECTED        = 0x00000002,
    DS_INDETERMINATE   = 0x00000003,
    DS_DEFERRED        = 0x00000004,
    DS_PASSTHROUGH     = 0x00000005,
}
alias DIAGNOSIS_STATUS = int;

enum : int
{
    RS_NOT_IMPLEMENTED = 0x00000000,
    RS_REPAIRED        = 0x00000001,
    RS_UNREPAIRED      = 0x00000002,
    RS_DEFERRED        = 0x00000003,
    RS_USER_ACTION     = 0x00000004,
}
alias REPAIR_STATUS = int;

enum : int
{
    PT_INVALID               = 0x00000000,
    PT_LOW_HEALTH            = 0x00000001,
    PT_LOWER_HEALTH          = 0x00000002,
    PT_DOWN_STREAM_HEALTH    = 0x00000004,
    PT_HIGH_UTILIZATION      = 0x00000008,
    PT_HIGHER_UTILIZATION    = 0x00000010,
    PT_UP_STREAM_UTILIZATION = 0x00000020,
}
alias PROBLEM_TYPE = int;

// Structs


struct OCTET_STRING
{
    uint   dwLength;
    ubyte* lpValue;
}

struct LIFE_TIME
{
    FILETIME startTime;
    FILETIME endTime;
}

struct DIAG_SOCKADDR
{
    ushort    family;
    byte[126] data;
}

struct HELPER_ATTRIBUTE
{
    const(wchar)*  pwszName;
    ATTRIBUTE_TYPE type;
    union
    {
        BOOL          Boolean;
        byte          Char;
        ubyte         Byte;
        short         Short;
        ushort        Word;
        int           Int;
        uint          DWord;
        long          Int64;
        ulong         UInt64;
        const(wchar)* PWStr;
        GUID          Guid;
        LIFE_TIME     LifeTime;
        DIAG_SOCKADDR Address;
        OCTET_STRING  OctetString;
    }
}

struct ShellCommandInfo
{
    const(wchar)* pwszOperation;
    const(wchar)* pwszFile;
    const(wchar)* pwszParameters;
    const(wchar)* pwszDirectory;
    uint          nShowCmd;
}

struct UiInfo
{
    UI_INFO_TYPE type;
    union
    {
        const(wchar)*    pwzNull;
        ShellCommandInfo ShellInfo;
        const(wchar)*    pwzHelpUrl;
        const(wchar)*    pwzDui;
    }
}

struct RepairInfo
{
    GUID          guid;
    const(wchar)* pwszClassName;
    const(wchar)* pwszDescription;
    uint          sidType;
    int           cost;
    uint          flags;
    REPAIR_SCOPE  scope_;
    REPAIR_RISK   risk;
    UiInfo        UiInfo90;
    int           rootCauseIndex;
}

struct RepairInfoEx
{
    RepairInfo repair;
    ushort     repairRank;
}

struct RootCauseInfo
{
    const(wchar)* pwszDescription;
    GUID          rootCauseID;
    uint          rootCauseFlags;
    GUID          networkInterfaceID;
    RepairInfoEx* pRepairs;
    ushort        repairCount;
}

struct HYPOTHESIS
{
    const(wchar)*     pwszClassName;
    const(wchar)*     pwszDescription;
    uint              celt;
    HELPER_ATTRIBUTE* rgAttributes;
}

struct HelperAttributeInfo
{
    const(wchar)*  pwszName;
    ATTRIBUTE_TYPE type;
}

struct DiagnosticsInfo
{
    int  cost;
    uint flags;
}

struct HypothesisResult
{
    HYPOTHESIS       hypothesis;
    DIAGNOSIS_STATUS pathStatus;
}

// Functions

@DllImport("NDFAPI")
HRESULT NdfCreateIncident(const(wchar)* helperClassName, uint celt, char* attributes, void** handle);

@DllImport("NDFAPI")
HRESULT NdfCreateWinSockIncident(size_t sock, const(wchar)* host, ushort port, const(wchar)* appId, SID* userId, 
                                 void** handle);

@DllImport("NDFAPI")
HRESULT NdfCreateWebIncident(const(wchar)* url, void** handle);

@DllImport("NDFAPI")
HRESULT NdfCreateWebIncidentEx(const(wchar)* url, BOOL useWinHTTP, const(wchar)* moduleName, void** handle);

@DllImport("NDFAPI")
HRESULT NdfCreateSharingIncident(const(wchar)* UNCPath, void** handle);

@DllImport("NDFAPI")
HRESULT NdfCreateDNSIncident(const(wchar)* hostname, ushort queryType, void** handle);

@DllImport("NDFAPI")
HRESULT NdfCreateConnectivityIncident(void** handle);

@DllImport("NDFAPI")
HRESULT NdfCreateNetConnectionIncident(void** handle, GUID id);

@DllImport("NDFAPI")
HRESULT NdfCreatePnrpIncident(const(wchar)* cloudname, const(wchar)* peername, BOOL diagnosePublish, 
                              const(wchar)* appId, void** handle);

@DllImport("NDFAPI")
HRESULT NdfCreateGroupingIncident(const(wchar)* CloudName, const(wchar)* GroupName, const(wchar)* Identity, 
                                  const(wchar)* Invitation, SOCKET_ADDRESS_LIST* Addresses, const(wchar)* appId, 
                                  void** handle);

@DllImport("NDFAPI")
HRESULT NdfExecuteDiagnosis(void* handle, HWND hwnd);

@DllImport("NDFAPI")
HRESULT NdfCloseIncident(void* handle);

@DllImport("NDFAPI")
HRESULT NdfDiagnoseIncident(void* Handle, uint* RootCauseCount, RootCauseInfo** RootCauses, uint dwWait, 
                            uint dwFlags);

@DllImport("NDFAPI")
HRESULT NdfRepairIncident(void* Handle, RepairInfoEx* RepairEx, uint dwWait);

@DllImport("NDFAPI")
HRESULT NdfCancelIncident(void* Handle);

@DllImport("NDFAPI")
HRESULT NdfGetTraceFile(void* Handle, ushort** TraceFileLocation);


// Interfaces

@GUID("C0B35746-EBF5-11D8-BBE9-505054503030")
interface INetDiagHelper : IUnknown
{
    HRESULT Initialize(uint celt, char* rgAttributes);
    HRESULT GetDiagnosticsInfo(DiagnosticsInfo** ppInfo);
    HRESULT GetKeyAttributes(uint* pcelt, char* pprgAttributes);
    HRESULT LowHealth(const(wchar)* pwszInstanceDescription, ushort** ppwszDescription, int* pDeferredTime, 
                      DIAGNOSIS_STATUS* pStatus);
    HRESULT HighUtilization(const(wchar)* pwszInstanceDescription, ushort** ppwszDescription, int* pDeferredTime, 
                            DIAGNOSIS_STATUS* pStatus);
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

@GUID("104613FB-BC57-4178-95BA-88809698354A")
interface INetDiagHelperUtilFactory : IUnknown
{
    HRESULT CreateUtilityInstance(const(GUID)* riid, void** ppvObject);
}

@GUID("972DAB4D-E4E3-4FC6-AE54-5F65CCDE4A15")
interface INetDiagHelperEx : IUnknown
{
    HRESULT ReconfirmLowHealth(uint celt, char* pResults, ushort** ppwszUpdatedDescription, 
                               DIAGNOSIS_STATUS* pUpdatedStatus);
    HRESULT SetUtilities(INetDiagHelperUtilFactory pUtilities);
    HRESULT ReproduceFailure();
}

@GUID("C0B35747-EBF5-11D8-BBE9-505054503030")
interface INetDiagHelperInfo : IUnknown
{
    HRESULT GetAttributeInfo(uint* pcelt, char* pprgAttributeInfos);
}

@GUID("C0B35748-EBF5-11D8-BBE9-505054503030")
interface INetDiagExtensibleHelper : IUnknown
{
    HRESULT ResolveAttributes(uint celt, char* rgKeyAttributes, uint* pcelt, char* prgMatchValues);
}


// GUIDs


const GUID IID_INetDiagExtensibleHelper  = GUIDOF!INetDiagExtensibleHelper;
const GUID IID_INetDiagHelper            = GUIDOF!INetDiagHelper;
const GUID IID_INetDiagHelperEx          = GUIDOF!INetDiagHelperEx;
const GUID IID_INetDiagHelperInfo        = GUIDOF!INetDiagHelperInfo;
const GUID IID_INetDiagHelperUtilFactory = GUIDOF!INetDiagHelperUtilFactory;
