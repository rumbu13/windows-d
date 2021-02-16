module windows.perf;

public import windows.core;
public import windows.systemservices : BOOL, HANDLE, LARGE_INTEGER;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME, SYSTEMTIME;

extern(Windows):


// Enums


enum PerfRegInfoType : int
{
    PERF_REG_COUNTERSET_STRUCT       = 0x00000001,
    PERF_REG_COUNTER_STRUCT          = 0x00000002,
    PERF_REG_COUNTERSET_NAME_STRING  = 0x00000003,
    PERF_REG_COUNTERSET_HELP_STRING  = 0x00000004,
    PERF_REG_COUNTER_NAME_STRINGS    = 0x00000005,
    PERF_REG_COUNTER_HELP_STRINGS    = 0x00000006,
    PERF_REG_PROVIDER_NAME           = 0x00000007,
    PERF_REG_PROVIDER_GUID           = 0x00000008,
    PERF_REG_COUNTERSET_ENGLISH_NAME = 0x00000009,
    PERF_REG_COUNTER_ENGLISH_NAMES   = 0x0000000a,
}

enum PerfCounterDataType : int
{
    PERF_ERROR_RETURN       = 0x00000000,
    PERF_SINGLE_COUNTER     = 0x00000001,
    PERF_MULTIPLE_COUNTERS  = 0x00000002,
    PERF_MULTIPLE_INSTANCES = 0x00000004,
    PERF_COUNTERSET         = 0x00000006,
}

// Callbacks

alias PERFLIBREQUEST = uint function(uint RequestCode, void* Buffer, uint BufferSize);
alias PERF_MEM_ALLOC = void* function(size_t AllocSize, void* pContext);
alias PERF_MEM_FREE = void function(void* pBuffer, void* pContext);
alias CounterPathCallBack = int function(size_t param0);
alias PM_COLLECT_PROC = uint function(const(wchar)* lpValueName, void** lppData, uint* lpcbTotalBytes, 
                                      uint* lpNumObjectTypes);
alias PM_CLOSE_PROC = uint function();

// Structs


alias PerfProviderHandle = ptrdiff_t;

alias PerfQueryHandle = ptrdiff_t;

struct PERF_COUNTERSET_INFO
{
    GUID CounterSetGuid;
    GUID ProviderGuid;
    uint NumCounters;
    uint InstanceType;
}

struct PERF_COUNTER_INFO
{
    uint  CounterId;
    uint  Type;
    ulong Attrib;
    uint  Size;
    uint  DetailLevel;
    int   Scale;
    uint  Offset;
}

struct PERF_COUNTERSET_INSTANCE
{
    GUID CounterSetGuid;
    uint dwSize;
    uint InstanceId;
    uint InstanceNameOffset;
    uint InstanceNameSize;
}

struct PERF_COUNTER_IDENTITY
{
    GUID CounterSetGuid;
    uint BufferSize;
    uint CounterId;
    uint InstanceId;
    uint MachineOffset;
    uint NameOffset;
    uint Reserved;
}

struct PERF_PROVIDER_CONTEXT
{
    uint           ContextSize;
    uint           Reserved;
    PERFLIBREQUEST ControlCallback;
    PERF_MEM_ALLOC MemAllocRoutine;
    PERF_MEM_FREE  MemFreeRoutine;
    void*          pMemContext;
}

struct PERF_INSTANCE_HEADER
{
    uint Size;
    uint InstanceId;
}

struct PERF_COUNTERSET_REG_INFO
{
    GUID CounterSetGuid;
    uint CounterSetType;
    uint DetailLevel;
    uint NumCounters;
    uint InstanceType;
}

struct PERF_COUNTER_REG_INFO
{
    uint  CounterId;
    uint  Type;
    ulong Attrib;
    uint  DetailLevel;
    int   DefaultScale;
    uint  BaseCounterId;
    uint  PerfTimeId;
    uint  PerfFreqId;
    uint  MultiId;
    uint  AggregateFunc;
    uint  Reserved;
}

struct PERF_STRING_BUFFER_HEADER
{
    uint dwSize;
    uint dwCounters;
}

struct PERF_STRING_COUNTER_HEADER
{
    uint dwCounterId;
    uint dwOffset;
}

struct PERF_COUNTER_IDENTIFIER
{
    GUID CounterSetGuid;
    uint Status;
    uint Size;
    uint CounterId;
    uint InstanceId;
    uint Index;
    uint Reserved;
}

struct PERF_DATA_HEADER
{
    uint       dwTotalSize;
    uint       dwNumCounters;
    long       PerfTimeStamp;
    long       PerfTime100NSec;
    long       PerfFreq;
    SYSTEMTIME SystemTime;
}

struct PERF_COUNTER_HEADER
{
    uint                dwStatus;
    PerfCounterDataType dwType;
    uint                dwSize;
    uint                Reserved;
}

struct PERF_MULTI_INSTANCES
{
    uint dwTotalSize;
    uint dwInstances;
}

struct PERF_MULTI_COUNTERS
{
    uint dwSize;
    uint dwCounters;
}

struct PERF_COUNTER_DATA
{
    uint dwDataSize;
    uint dwSize;
}

struct PDH_RAW_COUNTER
{
    uint     CStatus;
    FILETIME TimeStamp;
    long     FirstValue;
    long     SecondValue;
    uint     MultiCount;
}

struct PDH_RAW_COUNTER_ITEM_A
{
    const(char)*    szName;
    PDH_RAW_COUNTER RawValue;
}

struct PDH_RAW_COUNTER_ITEM_W
{
    const(wchar)*   szName;
    PDH_RAW_COUNTER RawValue;
}

struct PDH_FMT_COUNTERVALUE
{
    uint CStatus;
    union
    {
        int           longValue;
        double        doubleValue;
        long          largeValue;
        const(char)*  AnsiStringValue;
        const(wchar)* WideStringValue;
    }
}

struct PDH_FMT_COUNTERVALUE_ITEM_A
{
    const(char)*         szName;
    PDH_FMT_COUNTERVALUE FmtValue;
}

struct PDH_FMT_COUNTERVALUE_ITEM_W
{
    const(wchar)*        szName;
    PDH_FMT_COUNTERVALUE FmtValue;
}

struct PDH_STATISTICS
{
    uint                 dwFormat;
    uint                 count;
    PDH_FMT_COUNTERVALUE min;
    PDH_FMT_COUNTERVALUE max;
    PDH_FMT_COUNTERVALUE mean;
}

struct PDH_COUNTER_PATH_ELEMENTS_A
{
    const(char)* szMachineName;
    const(char)* szObjectName;
    const(char)* szInstanceName;
    const(char)* szParentInstance;
    uint         dwInstanceIndex;
    const(char)* szCounterName;
}

struct PDH_COUNTER_PATH_ELEMENTS_W
{
    const(wchar)* szMachineName;
    const(wchar)* szObjectName;
    const(wchar)* szInstanceName;
    const(wchar)* szParentInstance;
    uint          dwInstanceIndex;
    const(wchar)* szCounterName;
}

struct PDH_DATA_ITEM_PATH_ELEMENTS_A
{
    const(char)* szMachineName;
    GUID         ObjectGUID;
    uint         dwItemId;
    const(char)* szInstanceName;
}

struct PDH_DATA_ITEM_PATH_ELEMENTS_W
{
    const(wchar)* szMachineName;
    GUID          ObjectGUID;
    uint          dwItemId;
    const(wchar)* szInstanceName;
}

struct PDH_COUNTER_INFO_A
{
    uint         dwLength;
    uint         dwType;
    uint         CVersion;
    uint         CStatus;
    int          lScale;
    int          lDefaultScale;
    size_t       dwUserData;
    size_t       dwQueryUserData;
    const(char)* szFullPath;
    union
    {
        PDH_DATA_ITEM_PATH_ELEMENTS_A DataItemPath;
        PDH_COUNTER_PATH_ELEMENTS_A CounterPath;
        struct
        {
            const(char)* szMachineName;
            const(char)* szObjectName;
            const(char)* szInstanceName;
            const(char)* szParentInstance;
            uint         dwInstanceIndex;
            const(char)* szCounterName;
        }
    }
    const(char)* szExplainText;
    uint[1]      DataBuffer;
}

struct PDH_COUNTER_INFO_W
{
    uint          dwLength;
    uint          dwType;
    uint          CVersion;
    uint          CStatus;
    int           lScale;
    int           lDefaultScale;
    size_t        dwUserData;
    size_t        dwQueryUserData;
    const(wchar)* szFullPath;
    union
    {
        PDH_DATA_ITEM_PATH_ELEMENTS_W DataItemPath;
        PDH_COUNTER_PATH_ELEMENTS_W CounterPath;
        struct
        {
            const(wchar)* szMachineName;
            const(wchar)* szObjectName;
            const(wchar)* szInstanceName;
            const(wchar)* szParentInstance;
            uint          dwInstanceIndex;
            const(wchar)* szCounterName;
        }
    }
    const(wchar)* szExplainText;
    uint[1]       DataBuffer;
}

struct PDH_TIME_INFO
{
    long StartTime;
    long EndTime;
    uint SampleCount;
}

struct PDH_RAW_LOG_RECORD
{
    uint     dwStructureSize;
    uint     dwRecordType;
    uint     dwItems;
    ubyte[1] RawBytes;
}

struct PDH_LOG_SERVICE_QUERY_INFO_A
{
    uint         dwSize;
    uint         dwFlags;
    uint         dwLogQuota;
    const(char)* szLogFileCaption;
    const(char)* szDefaultDir;
    const(char)* szBaseFileName;
    uint         dwFileType;
    uint         dwReserved;
    union
    {
        struct
        {
            uint         PdlAutoNameInterval;
            uint         PdlAutoNameUnits;
            const(char)* PdlCommandFilename;
            const(char)* PdlCounterList;
            uint         PdlAutoNameFormat;
            uint         PdlSampleInterval;
            FILETIME     PdlLogStartTime;
            FILETIME     PdlLogEndTime;
        }
        struct
        {
            uint         TlNumberOfBuffers;
            uint         TlMinimumBuffers;
            uint         TlMaximumBuffers;
            uint         TlFreeBuffers;
            uint         TlBufferSize;
            uint         TlEventsLost;
            uint         TlLoggerThreadId;
            uint         TlBuffersWritten;
            uint         TlLogHandle;
            const(char)* TlLogFileName;
        }
    }
}

struct PDH_LOG_SERVICE_QUERY_INFO_W
{
    uint          dwSize;
    uint          dwFlags;
    uint          dwLogQuota;
    const(wchar)* szLogFileCaption;
    const(wchar)* szDefaultDir;
    const(wchar)* szBaseFileName;
    uint          dwFileType;
    uint          dwReserved;
    union
    {
        struct
        {
            uint          PdlAutoNameInterval;
            uint          PdlAutoNameUnits;
            const(wchar)* PdlCommandFilename;
            const(wchar)* PdlCounterList;
            uint          PdlAutoNameFormat;
            uint          PdlSampleInterval;
            FILETIME      PdlLogStartTime;
            FILETIME      PdlLogEndTime;
        }
        struct
        {
            uint          TlNumberOfBuffers;
            uint          TlMinimumBuffers;
            uint          TlMaximumBuffers;
            uint          TlFreeBuffers;
            uint          TlBufferSize;
            uint          TlEventsLost;
            uint          TlLoggerThreadId;
            uint          TlBuffersWritten;
            uint          TlLogHandle;
            const(wchar)* TlLogFileName;
        }
    }
}

struct PDH_BROWSE_DLG_CONFIG_HW
{
    uint                _bitfield91;
    HWND                hWndOwner;
    ptrdiff_t           hDataSource;
    const(wchar)*       szReturnPathBuffer;
    uint                cchReturnPathLength;
    CounterPathCallBack pCallBack;
    size_t              dwCallBackArg;
    int                 CallBackStatus;
    uint                dwDefaultDetailLevel;
    const(wchar)*       szDialogBoxCaption;
}

struct PDH_BROWSE_DLG_CONFIG_HA
{
    uint                _bitfield92;
    HWND                hWndOwner;
    ptrdiff_t           hDataSource;
    const(char)*        szReturnPathBuffer;
    uint                cchReturnPathLength;
    CounterPathCallBack pCallBack;
    size_t              dwCallBackArg;
    int                 CallBackStatus;
    uint                dwDefaultDetailLevel;
    const(char)*        szDialogBoxCaption;
}

struct PDH_BROWSE_DLG_CONFIG_W
{
    uint                _bitfield93;
    HWND                hWndOwner;
    const(wchar)*       szDataSource;
    const(wchar)*       szReturnPathBuffer;
    uint                cchReturnPathLength;
    CounterPathCallBack pCallBack;
    size_t              dwCallBackArg;
    int                 CallBackStatus;
    uint                dwDefaultDetailLevel;
    const(wchar)*       szDialogBoxCaption;
}

struct PDH_BROWSE_DLG_CONFIG_A
{
    uint                _bitfield94;
    HWND                hWndOwner;
    const(char)*        szDataSource;
    const(char)*        szReturnPathBuffer;
    uint                cchReturnPathLength;
    CounterPathCallBack pCallBack;
    size_t              dwCallBackArg;
    int                 CallBackStatus;
    uint                dwDefaultDetailLevel;
    const(char)*        szDialogBoxCaption;
}

struct PERF_DATA_BLOCK
{
    ushort[4]     Signature;
    uint          LittleEndian;
    uint          Version;
    uint          Revision;
    uint          TotalByteLength;
    uint          HeaderLength;
    uint          NumObjectTypes;
    int           DefaultObject;
    SYSTEMTIME    SystemTime;
    LARGE_INTEGER PerfTime;
    LARGE_INTEGER PerfFreq;
    LARGE_INTEGER PerfTime100nSec;
    uint          SystemNameLength;
    uint          SystemNameOffset;
}

struct PERF_OBJECT_TYPE
{
    uint          TotalByteLength;
    uint          DefinitionLength;
    uint          HeaderLength;
    uint          ObjectNameTitleIndex;
    const(wchar)* ObjectNameTitle;
    uint          ObjectHelpTitleIndex;
    const(wchar)* ObjectHelpTitle;
    uint          DetailLevel;
    uint          NumCounters;
    int           DefaultCounter;
    int           NumInstances;
    uint          CodePage;
    LARGE_INTEGER PerfTime;
    LARGE_INTEGER PerfFreq;
}

struct PERF_COUNTER_DEFINITION
{
    uint          ByteLength;
    uint          CounterNameTitleIndex;
    const(wchar)* CounterNameTitle;
    uint          CounterHelpTitleIndex;
    const(wchar)* CounterHelpTitle;
    int           DefaultScale;
    uint          DetailLevel;
    uint          CounterType;
    uint          CounterSize;
    uint          CounterOffset;
}

struct PERF_INSTANCE_DEFINITION
{
    uint ByteLength;
    uint ParentObjectTitleIndex;
    uint ParentObjectInstance;
    int  UniqueID;
    uint NameOffset;
    uint NameLength;
}

struct PERF_COUNTER_BLOCK
{
    uint ByteLength;
}

// Functions

@DllImport("loadperf")
uint LoadPerfCounterTextStringsA(const(char)* lpCommandLine, BOOL bQuietModeArg);

@DllImport("loadperf")
uint LoadPerfCounterTextStringsW(const(wchar)* lpCommandLine, BOOL bQuietModeArg);

@DllImport("loadperf")
uint UnloadPerfCounterTextStringsW(const(wchar)* lpCommandLine, BOOL bQuietModeArg);

@DllImport("loadperf")
uint UnloadPerfCounterTextStringsA(const(char)* lpCommandLine, BOOL bQuietModeArg);

@DllImport("loadperf")
uint UpdatePerfNameFilesA(const(char)* szNewCtrFilePath, const(char)* szNewHlpFilePath, const(char)* szLanguageID, 
                          size_t dwFlags);

@DllImport("loadperf")
uint UpdatePerfNameFilesW(const(wchar)* szNewCtrFilePath, const(wchar)* szNewHlpFilePath, 
                          const(wchar)* szLanguageID, size_t dwFlags);

@DllImport("loadperf")
uint SetServiceAsTrustedA(const(char)* szReserved, const(char)* szServiceName);

@DllImport("loadperf")
uint SetServiceAsTrustedW(const(wchar)* szReserved, const(wchar)* szServiceName);

@DllImport("loadperf")
uint BackupPerfRegistryToFileW(const(wchar)* szFileName, const(wchar)* szCommentString);

@DllImport("loadperf")
uint RestorePerfRegistryFromFileW(const(wchar)* szFileName, const(wchar)* szLangId);

@DllImport("ADVAPI32")
uint PerfStartProvider(GUID* ProviderGuid, PERFLIBREQUEST ControlCallback, PerfProviderHandle* phProvider);

@DllImport("ADVAPI32")
uint PerfStartProviderEx(GUID* ProviderGuid, PERF_PROVIDER_CONTEXT* ProviderContext, PerfProviderHandle* Provider);

@DllImport("ADVAPI32")
uint PerfStopProvider(PerfProviderHandle ProviderHandle);

@DllImport("ADVAPI32")
uint PerfSetCounterSetInfo(HANDLE ProviderHandle, char* Template, uint TemplateSize);

@DllImport("ADVAPI32")
PERF_COUNTERSET_INSTANCE* PerfCreateInstance(PerfProviderHandle ProviderHandle, GUID* CounterSetGuid, 
                                             const(wchar)* Name, uint Id);

@DllImport("ADVAPI32")
uint PerfDeleteInstance(PerfProviderHandle Provider, PERF_COUNTERSET_INSTANCE* InstanceBlock);

@DllImport("ADVAPI32")
PERF_COUNTERSET_INSTANCE* PerfQueryInstance(HANDLE ProviderHandle, GUID* CounterSetGuid, const(wchar)* Name, 
                                            uint Id);

@DllImport("ADVAPI32")
uint PerfSetCounterRefValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, void* Address);

@DllImport("ADVAPI32")
uint PerfSetULongCounterValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, uint Value);

@DllImport("ADVAPI32")
uint PerfSetULongLongCounterValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, ulong Value);

@DllImport("ADVAPI32")
uint PerfIncrementULongCounterValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, 
                                    uint Value);

@DllImport("ADVAPI32")
uint PerfIncrementULongLongCounterValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, 
                                        ulong Value);

@DllImport("ADVAPI32")
uint PerfDecrementULongCounterValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, 
                                    uint Value);

@DllImport("ADVAPI32")
uint PerfDecrementULongLongCounterValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, 
                                        ulong Value);

@DllImport("ADVAPI32")
uint PerfEnumerateCounterSet(const(wchar)* szMachine, char* pCounterSetIds, uint cCounterSetIds, 
                             uint* pcCounterSetIdsActual);

@DllImport("ADVAPI32")
uint PerfEnumerateCounterSetInstances(const(wchar)* szMachine, GUID* pCounterSetId, char* pInstances, 
                                      uint cbInstances, uint* pcbInstancesActual);

@DllImport("ADVAPI32")
uint PerfQueryCounterSetRegistrationInfo(const(wchar)* szMachine, GUID* pCounterSetId, PerfRegInfoType requestCode, 
                                         uint requestLangId, char* pbRegInfo, uint cbRegInfo, uint* pcbRegInfoActual);

@DllImport("ADVAPI32")
uint PerfOpenQueryHandle(const(wchar)* szMachine, PerfQueryHandle* phQuery);

@DllImport("ADVAPI32")
uint PerfCloseQueryHandle(HANDLE hQuery);

@DllImport("ADVAPI32")
uint PerfQueryCounterInfo(PerfQueryHandle hQuery, char* pCounters, uint cbCounters, uint* pcbCountersActual);

@DllImport("ADVAPI32")
uint PerfQueryCounterData(PerfQueryHandle hQuery, char* pCounterBlock, uint cbCounterBlock, 
                          uint* pcbCounterBlockActual);

@DllImport("ADVAPI32")
uint PerfAddCounters(PerfQueryHandle hQuery, char* pCounters, uint cbCounters);

@DllImport("ADVAPI32")
uint PerfDeleteCounters(PerfQueryHandle hQuery, char* pCounters, uint cbCounters);

@DllImport("pdh")
int PdhGetDllVersion(uint* lpdwVersion);

@DllImport("pdh")
int PdhOpenQueryW(const(wchar)* szDataSource, size_t dwUserData, ptrdiff_t* phQuery);

@DllImport("pdh")
int PdhOpenQueryA(const(char)* szDataSource, size_t dwUserData, ptrdiff_t* phQuery);

@DllImport("pdh")
int PdhAddCounterW(ptrdiff_t hQuery, const(wchar)* szFullCounterPath, size_t dwUserData, ptrdiff_t* phCounter);

@DllImport("pdh")
int PdhAddCounterA(ptrdiff_t hQuery, const(char)* szFullCounterPath, size_t dwUserData, ptrdiff_t* phCounter);

@DllImport("pdh")
int PdhAddEnglishCounterW(ptrdiff_t hQuery, const(wchar)* szFullCounterPath, size_t dwUserData, 
                          ptrdiff_t* phCounter);

@DllImport("pdh")
int PdhAddEnglishCounterA(ptrdiff_t hQuery, const(char)* szFullCounterPath, size_t dwUserData, 
                          ptrdiff_t* phCounter);

@DllImport("pdh")
int PdhCollectQueryDataWithTime(ptrdiff_t hQuery, long* pllTimeStamp);

@DllImport("pdh")
int PdhValidatePathExW(ptrdiff_t hDataSource, const(wchar)* szFullPathBuffer);

@DllImport("pdh")
int PdhValidatePathExA(ptrdiff_t hDataSource, const(char)* szFullPathBuffer);

@DllImport("pdh")
int PdhRemoveCounter(ptrdiff_t hCounter);

@DllImport("pdh")
int PdhCollectQueryData(ptrdiff_t hQuery);

@DllImport("pdh")
int PdhCloseQuery(ptrdiff_t hQuery);

@DllImport("pdh")
int PdhGetFormattedCounterValue(ptrdiff_t hCounter, uint dwFormat, uint* lpdwType, PDH_FMT_COUNTERVALUE* pValue);

@DllImport("pdh")
int PdhGetFormattedCounterArrayA(ptrdiff_t hCounter, uint dwFormat, uint* lpdwBufferSize, uint* lpdwItemCount, 
                                 char* ItemBuffer);

@DllImport("pdh")
int PdhGetFormattedCounterArrayW(ptrdiff_t hCounter, uint dwFormat, uint* lpdwBufferSize, uint* lpdwItemCount, 
                                 char* ItemBuffer);

@DllImport("pdh")
int PdhGetRawCounterValue(ptrdiff_t hCounter, uint* lpdwType, PDH_RAW_COUNTER* pValue);

@DllImport("pdh")
int PdhGetRawCounterArrayA(ptrdiff_t hCounter, uint* lpdwBufferSize, uint* lpdwItemCount, char* ItemBuffer);

@DllImport("pdh")
int PdhGetRawCounterArrayW(ptrdiff_t hCounter, uint* lpdwBufferSize, uint* lpdwItemCount, char* ItemBuffer);

@DllImport("pdh")
int PdhCalculateCounterFromRawValue(ptrdiff_t hCounter, uint dwFormat, PDH_RAW_COUNTER* rawValue1, 
                                    PDH_RAW_COUNTER* rawValue2, PDH_FMT_COUNTERVALUE* fmtValue);

@DllImport("pdh")
int PdhComputeCounterStatistics(ptrdiff_t hCounter, uint dwFormat, uint dwFirstEntry, uint dwNumEntries, 
                                PDH_RAW_COUNTER* lpRawValueArray, PDH_STATISTICS* data);

@DllImport("pdh")
int PdhGetCounterInfoW(ptrdiff_t hCounter, ubyte bRetrieveExplainText, uint* pdwBufferSize, char* lpBuffer);

@DllImport("pdh")
int PdhGetCounterInfoA(ptrdiff_t hCounter, ubyte bRetrieveExplainText, uint* pdwBufferSize, char* lpBuffer);

@DllImport("pdh")
int PdhSetCounterScaleFactor(ptrdiff_t hCounter, int lFactor);

@DllImport("pdh")
int PdhConnectMachineW(const(wchar)* szMachineName);

@DllImport("pdh")
int PdhConnectMachineA(const(char)* szMachineName);

@DllImport("pdh")
int PdhEnumMachinesW(const(wchar)* szDataSource, const(wchar)* mszMachineList, uint* pcchBufferSize);

@DllImport("pdh")
int PdhEnumMachinesA(const(char)* szDataSource, const(char)* mszMachineList, uint* pcchBufferSize);

@DllImport("pdh")
int PdhEnumObjectsW(const(wchar)* szDataSource, const(wchar)* szMachineName, const(wchar)* mszObjectList, 
                    uint* pcchBufferSize, uint dwDetailLevel, BOOL bRefresh);

@DllImport("pdh")
int PdhEnumObjectsA(const(char)* szDataSource, const(char)* szMachineName, const(char)* mszObjectList, 
                    uint* pcchBufferSize, uint dwDetailLevel, BOOL bRefresh);

@DllImport("pdh")
int PdhEnumObjectItemsW(const(wchar)* szDataSource, const(wchar)* szMachineName, const(wchar)* szObjectName, 
                        const(wchar)* mszCounterList, uint* pcchCounterListLength, const(wchar)* mszInstanceList, 
                        uint* pcchInstanceListLength, uint dwDetailLevel, uint dwFlags);

@DllImport("pdh")
int PdhEnumObjectItemsA(const(char)* szDataSource, const(char)* szMachineName, const(char)* szObjectName, 
                        const(char)* mszCounterList, uint* pcchCounterListLength, const(char)* mszInstanceList, 
                        uint* pcchInstanceListLength, uint dwDetailLevel, uint dwFlags);

@DllImport("pdh")
int PdhMakeCounterPathW(PDH_COUNTER_PATH_ELEMENTS_W* pCounterPathElements, const(wchar)* szFullPathBuffer, 
                        uint* pcchBufferSize, uint dwFlags);

@DllImport("pdh")
int PdhMakeCounterPathA(PDH_COUNTER_PATH_ELEMENTS_A* pCounterPathElements, const(char)* szFullPathBuffer, 
                        uint* pcchBufferSize, uint dwFlags);

@DllImport("pdh")
int PdhParseCounterPathW(const(wchar)* szFullPathBuffer, char* pCounterPathElements, uint* pdwBufferSize, 
                         uint dwFlags);

@DllImport("pdh")
int PdhParseCounterPathA(const(char)* szFullPathBuffer, char* pCounterPathElements, uint* pdwBufferSize, 
                         uint dwFlags);

@DllImport("pdh")
int PdhParseInstanceNameW(const(wchar)* szInstanceString, const(wchar)* szInstanceName, 
                          uint* pcchInstanceNameLength, const(wchar)* szParentName, uint* pcchParentNameLength, 
                          uint* lpIndex);

@DllImport("pdh")
int PdhParseInstanceNameA(const(char)* szInstanceString, const(char)* szInstanceName, uint* pcchInstanceNameLength, 
                          const(char)* szParentName, uint* pcchParentNameLength, uint* lpIndex);

@DllImport("pdh")
int PdhValidatePathW(const(wchar)* szFullPathBuffer);

@DllImport("pdh")
int PdhValidatePathA(const(char)* szFullPathBuffer);

@DllImport("pdh")
int PdhGetDefaultPerfObjectW(const(wchar)* szDataSource, const(wchar)* szMachineName, 
                             const(wchar)* szDefaultObjectName, uint* pcchBufferSize);

@DllImport("pdh")
int PdhGetDefaultPerfObjectA(const(char)* szDataSource, const(char)* szMachineName, 
                             const(char)* szDefaultObjectName, uint* pcchBufferSize);

@DllImport("pdh")
int PdhGetDefaultPerfCounterW(const(wchar)* szDataSource, const(wchar)* szMachineName, const(wchar)* szObjectName, 
                              const(wchar)* szDefaultCounterName, uint* pcchBufferSize);

@DllImport("pdh")
int PdhGetDefaultPerfCounterA(const(char)* szDataSource, const(char)* szMachineName, const(char)* szObjectName, 
                              const(char)* szDefaultCounterName, uint* pcchBufferSize);

@DllImport("pdh")
int PdhBrowseCountersW(PDH_BROWSE_DLG_CONFIG_W* pBrowseDlgData);

@DllImport("pdh")
int PdhBrowseCountersA(PDH_BROWSE_DLG_CONFIG_A* pBrowseDlgData);

@DllImport("pdh")
int PdhExpandCounterPathW(const(wchar)* szWildCardPath, const(wchar)* mszExpandedPathList, 
                          uint* pcchPathListLength);

@DllImport("pdh")
int PdhExpandCounterPathA(const(char)* szWildCardPath, const(char)* mszExpandedPathList, uint* pcchPathListLength);

@DllImport("pdh")
int PdhLookupPerfNameByIndexW(const(wchar)* szMachineName, uint dwNameIndex, const(wchar)* szNameBuffer, 
                              uint* pcchNameBufferSize);

@DllImport("pdh")
int PdhLookupPerfNameByIndexA(const(char)* szMachineName, uint dwNameIndex, const(char)* szNameBuffer, 
                              uint* pcchNameBufferSize);

@DllImport("pdh")
int PdhLookupPerfIndexByNameW(const(wchar)* szMachineName, const(wchar)* szNameBuffer, uint* pdwIndex);

@DllImport("pdh")
int PdhLookupPerfIndexByNameA(const(char)* szMachineName, const(char)* szNameBuffer, uint* pdwIndex);

@DllImport("pdh")
int PdhExpandWildCardPathA(const(char)* szDataSource, const(char)* szWildCardPath, 
                           const(char)* mszExpandedPathList, uint* pcchPathListLength, uint dwFlags);

@DllImport("pdh")
int PdhExpandWildCardPathW(const(wchar)* szDataSource, const(wchar)* szWildCardPath, 
                           const(wchar)* mszExpandedPathList, uint* pcchPathListLength, uint dwFlags);

@DllImport("pdh")
int PdhOpenLogW(const(wchar)* szLogFileName, uint dwAccessFlags, uint* lpdwLogType, ptrdiff_t hQuery, 
                uint dwMaxSize, const(wchar)* szUserCaption, ptrdiff_t* phLog);

@DllImport("pdh")
int PdhOpenLogA(const(char)* szLogFileName, uint dwAccessFlags, uint* lpdwLogType, ptrdiff_t hQuery, 
                uint dwMaxSize, const(char)* szUserCaption, ptrdiff_t* phLog);

@DllImport("pdh")
int PdhUpdateLogW(ptrdiff_t hLog, const(wchar)* szUserString);

@DllImport("pdh")
int PdhUpdateLogA(ptrdiff_t hLog, const(char)* szUserString);

@DllImport("pdh")
int PdhUpdateLogFileCatalog(ptrdiff_t hLog);

@DllImport("pdh")
int PdhGetLogFileSize(ptrdiff_t hLog, long* llSize);

@DllImport("pdh")
int PdhCloseLog(ptrdiff_t hLog, uint dwFlags);

@DllImport("pdh")
int PdhSelectDataSourceW(HWND hWndOwner, uint dwFlags, const(wchar)* szDataSource, uint* pcchBufferLength);

@DllImport("pdh")
int PdhSelectDataSourceA(HWND hWndOwner, uint dwFlags, const(char)* szDataSource, uint* pcchBufferLength);

@DllImport("pdh")
BOOL PdhIsRealTimeQuery(ptrdiff_t hQuery);

@DllImport("pdh")
int PdhSetQueryTimeRange(ptrdiff_t hQuery, PDH_TIME_INFO* pInfo);

@DllImport("pdh")
int PdhGetDataSourceTimeRangeW(const(wchar)* szDataSource, uint* pdwNumEntries, char* pInfo, uint* pdwBufferSize);

@DllImport("pdh")
int PdhGetDataSourceTimeRangeA(const(char)* szDataSource, uint* pdwNumEntries, char* pInfo, uint* pdwBufferSize);

@DllImport("pdh")
int PdhCollectQueryDataEx(ptrdiff_t hQuery, uint dwIntervalTime, HANDLE hNewDataEvent);

@DllImport("pdh")
int PdhFormatFromRawValue(uint dwCounterType, uint dwFormat, long* pTimeBase, PDH_RAW_COUNTER* pRawValue1, 
                          PDH_RAW_COUNTER* pRawValue2, PDH_FMT_COUNTERVALUE* pFmtValue);

@DllImport("pdh")
int PdhGetCounterTimeBase(ptrdiff_t hCounter, long* pTimeBase);

@DllImport("pdh")
int PdhReadRawLogRecord(ptrdiff_t hLog, FILETIME ftRecord, char* pRawLogRecord, uint* pdwBufferLength);

@DllImport("pdh")
int PdhSetDefaultRealTimeDataSource(uint dwDataSourceId);

@DllImport("pdh")
int PdhBindInputDataSourceW(ptrdiff_t* phDataSource, const(wchar)* LogFileNameList);

@DllImport("pdh")
int PdhBindInputDataSourceA(ptrdiff_t* phDataSource, const(char)* LogFileNameList);

@DllImport("pdh")
int PdhOpenQueryH(ptrdiff_t hDataSource, size_t dwUserData, ptrdiff_t* phQuery);

@DllImport("pdh")
int PdhEnumMachinesHW(ptrdiff_t hDataSource, const(wchar)* mszMachineList, uint* pcchBufferSize);

@DllImport("pdh")
int PdhEnumMachinesHA(ptrdiff_t hDataSource, const(char)* mszMachineList, uint* pcchBufferSize);

@DllImport("pdh")
int PdhEnumObjectsHW(ptrdiff_t hDataSource, const(wchar)* szMachineName, const(wchar)* mszObjectList, 
                     uint* pcchBufferSize, uint dwDetailLevel, BOOL bRefresh);

@DllImport("pdh")
int PdhEnumObjectsHA(ptrdiff_t hDataSource, const(char)* szMachineName, const(char)* mszObjectList, 
                     uint* pcchBufferSize, uint dwDetailLevel, BOOL bRefresh);

@DllImport("pdh")
int PdhEnumObjectItemsHW(ptrdiff_t hDataSource, const(wchar)* szMachineName, const(wchar)* szObjectName, 
                         const(wchar)* mszCounterList, uint* pcchCounterListLength, const(wchar)* mszInstanceList, 
                         uint* pcchInstanceListLength, uint dwDetailLevel, uint dwFlags);

@DllImport("pdh")
int PdhEnumObjectItemsHA(ptrdiff_t hDataSource, const(char)* szMachineName, const(char)* szObjectName, 
                         const(char)* mszCounterList, uint* pcchCounterListLength, const(char)* mszInstanceList, 
                         uint* pcchInstanceListLength, uint dwDetailLevel, uint dwFlags);

@DllImport("pdh")
int PdhExpandWildCardPathHW(ptrdiff_t hDataSource, const(wchar)* szWildCardPath, const(wchar)* mszExpandedPathList, 
                            uint* pcchPathListLength, uint dwFlags);

@DllImport("pdh")
int PdhExpandWildCardPathHA(ptrdiff_t hDataSource, const(char)* szWildCardPath, const(char)* mszExpandedPathList, 
                            uint* pcchPathListLength, uint dwFlags);

@DllImport("pdh")
int PdhGetDataSourceTimeRangeH(ptrdiff_t hDataSource, uint* pdwNumEntries, char* pInfo, uint* pdwBufferSize);

@DllImport("pdh")
int PdhGetDefaultPerfObjectHW(ptrdiff_t hDataSource, const(wchar)* szMachineName, 
                              const(wchar)* szDefaultObjectName, uint* pcchBufferSize);

@DllImport("pdh")
int PdhGetDefaultPerfObjectHA(ptrdiff_t hDataSource, const(char)* szMachineName, const(char)* szDefaultObjectName, 
                              uint* pcchBufferSize);

@DllImport("pdh")
int PdhGetDefaultPerfCounterHW(ptrdiff_t hDataSource, const(wchar)* szMachineName, const(wchar)* szObjectName, 
                               const(wchar)* szDefaultCounterName, uint* pcchBufferSize);

@DllImport("pdh")
int PdhGetDefaultPerfCounterHA(ptrdiff_t hDataSource, const(char)* szMachineName, const(char)* szObjectName, 
                               const(char)* szDefaultCounterName, uint* pcchBufferSize);

@DllImport("pdh")
int PdhBrowseCountersHW(PDH_BROWSE_DLG_CONFIG_HW* pBrowseDlgData);

@DllImport("pdh")
int PdhBrowseCountersHA(PDH_BROWSE_DLG_CONFIG_HA* pBrowseDlgData);

@DllImport("pdh")
int PdhVerifySQLDBW(const(wchar)* szDataSource);

@DllImport("pdh")
int PdhVerifySQLDBA(const(char)* szDataSource);

@DllImport("pdh")
int PdhCreateSQLTablesW(const(wchar)* szDataSource);

@DllImport("pdh")
int PdhCreateSQLTablesA(const(char)* szDataSource);

@DllImport("pdh")
int PdhEnumLogSetNamesW(const(wchar)* szDataSource, const(wchar)* mszDataSetNameList, uint* pcchBufferLength);

@DllImport("pdh")
int PdhEnumLogSetNamesA(const(char)* szDataSource, const(char)* mszDataSetNameList, uint* pcchBufferLength);

@DllImport("pdh")
int PdhGetLogSetGUID(ptrdiff_t hLog, GUID* pGuid, int* pRunId);

@DllImport("pdh")
int PdhSetLogSetRunID(ptrdiff_t hLog, int RunId);


