module windows.perf;

public import system;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

alias PerfProviderHandle = int;
alias PerfQueryHandle = int;
struct PERF_COUNTERSET_INFO
{
    Guid CounterSetGuid;
    Guid ProviderGuid;
    uint NumCounters;
    uint InstanceType;
}

struct PERF_COUNTER_INFO
{
    uint CounterId;
    uint Type;
    ulong Attrib;
    uint Size;
    uint DetailLevel;
    int Scale;
    uint Offset;
}

struct PERF_COUNTERSET_INSTANCE
{
    Guid CounterSetGuid;
    uint dwSize;
    uint InstanceId;
    uint InstanceNameOffset;
    uint InstanceNameSize;
}

struct PERF_COUNTER_IDENTITY
{
    Guid CounterSetGuid;
    uint BufferSize;
    uint CounterId;
    uint InstanceId;
    uint MachineOffset;
    uint NameOffset;
    uint Reserved;
}

alias PERFLIBREQUEST = extern(Windows) uint function(uint RequestCode, void* Buffer, uint BufferSize);
alias PERF_MEM_ALLOC = extern(Windows) void* function(uint AllocSize, void* pContext);
alias PERF_MEM_FREE = extern(Windows) void function(void* pBuffer, void* pContext);
struct PERF_PROVIDER_CONTEXT
{
    uint ContextSize;
    uint Reserved;
    PERFLIBREQUEST ControlCallback;
    PERF_MEM_ALLOC MemAllocRoutine;
    PERF_MEM_FREE MemFreeRoutine;
    void* pMemContext;
}

struct PERF_INSTANCE_HEADER
{
    uint Size;
    uint InstanceId;
}

enum PerfRegInfoType
{
    PERF_REG_COUNTERSET_STRUCT = 1,
    PERF_REG_COUNTER_STRUCT = 2,
    PERF_REG_COUNTERSET_NAME_STRING = 3,
    PERF_REG_COUNTERSET_HELP_STRING = 4,
    PERF_REG_COUNTER_NAME_STRINGS = 5,
    PERF_REG_COUNTER_HELP_STRINGS = 6,
    PERF_REG_PROVIDER_NAME = 7,
    PERF_REG_PROVIDER_GUID = 8,
    PERF_REG_COUNTERSET_ENGLISH_NAME = 9,
    PERF_REG_COUNTER_ENGLISH_NAMES = 10,
}

struct PERF_COUNTERSET_REG_INFO
{
    Guid CounterSetGuid;
    uint CounterSetType;
    uint DetailLevel;
    uint NumCounters;
    uint InstanceType;
}

struct PERF_COUNTER_REG_INFO
{
    uint CounterId;
    uint Type;
    ulong Attrib;
    uint DetailLevel;
    int DefaultScale;
    uint BaseCounterId;
    uint PerfTimeId;
    uint PerfFreqId;
    uint MultiId;
    uint AggregateFunc;
    uint Reserved;
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
    Guid CounterSetGuid;
    uint Status;
    uint Size;
    uint CounterId;
    uint InstanceId;
    uint Index;
    uint Reserved;
}

struct PERF_DATA_HEADER
{
    uint dwTotalSize;
    uint dwNumCounters;
    long PerfTimeStamp;
    long PerfTime100NSec;
    long PerfFreq;
    SYSTEMTIME SystemTime;
}

enum PerfCounterDataType
{
    PERF_ERROR_RETURN = 0,
    PERF_SINGLE_COUNTER = 1,
    PERF_MULTIPLE_COUNTERS = 2,
    PERF_MULTIPLE_INSTANCES = 4,
    PERF_COUNTERSET = 6,
}

struct PERF_COUNTER_HEADER
{
    uint dwStatus;
    PerfCounterDataType dwType;
    uint dwSize;
    uint Reserved;
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
    uint CStatus;
    FILETIME TimeStamp;
    long FirstValue;
    long SecondValue;
    uint MultiCount;
}

struct PDH_RAW_COUNTER_ITEM_A
{
    const(char)* szName;
    PDH_RAW_COUNTER RawValue;
}

struct PDH_RAW_COUNTER_ITEM_W
{
    const(wchar)* szName;
    PDH_RAW_COUNTER RawValue;
}

struct PDH_FMT_COUNTERVALUE
{
    uint CStatus;
    _Anonymous_e__Union Anonymous;
}

struct PDH_FMT_COUNTERVALUE_ITEM_A
{
    const(char)* szName;
    PDH_FMT_COUNTERVALUE FmtValue;
}

struct PDH_FMT_COUNTERVALUE_ITEM_W
{
    const(wchar)* szName;
    PDH_FMT_COUNTERVALUE FmtValue;
}

struct PDH_STATISTICS
{
    uint dwFormat;
    uint count;
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
    uint dwInstanceIndex;
    const(char)* szCounterName;
}

struct PDH_COUNTER_PATH_ELEMENTS_W
{
    const(wchar)* szMachineName;
    const(wchar)* szObjectName;
    const(wchar)* szInstanceName;
    const(wchar)* szParentInstance;
    uint dwInstanceIndex;
    const(wchar)* szCounterName;
}

struct PDH_DATA_ITEM_PATH_ELEMENTS_A
{
    const(char)* szMachineName;
    Guid ObjectGUID;
    uint dwItemId;
    const(char)* szInstanceName;
}

struct PDH_DATA_ITEM_PATH_ELEMENTS_W
{
    const(wchar)* szMachineName;
    Guid ObjectGUID;
    uint dwItemId;
    const(wchar)* szInstanceName;
}

struct PDH_COUNTER_INFO_A
{
    uint dwLength;
    uint dwType;
    uint CVersion;
    uint CStatus;
    int lScale;
    int lDefaultScale;
    uint dwUserData;
    uint dwQueryUserData;
    const(char)* szFullPath;
    _Anonymous_e__Union Anonymous;
    const(char)* szExplainText;
    uint DataBuffer;
}

struct PDH_COUNTER_INFO_W
{
    uint dwLength;
    uint dwType;
    uint CVersion;
    uint CStatus;
    int lScale;
    int lDefaultScale;
    uint dwUserData;
    uint dwQueryUserData;
    const(wchar)* szFullPath;
    _Anonymous_e__Union Anonymous;
    const(wchar)* szExplainText;
    uint DataBuffer;
}

struct PDH_TIME_INFO
{
    long StartTime;
    long EndTime;
    uint SampleCount;
}

struct PDH_RAW_LOG_RECORD
{
    uint dwStructureSize;
    uint dwRecordType;
    uint dwItems;
    ubyte RawBytes;
}

struct PDH_LOG_SERVICE_QUERY_INFO_A
{
    uint dwSize;
    uint dwFlags;
    uint dwLogQuota;
    const(char)* szLogFileCaption;
    const(char)* szDefaultDir;
    const(char)* szBaseFileName;
    uint dwFileType;
    uint dwReserved;
    _Anonymous_e__Union Anonymous;
}

struct PDH_LOG_SERVICE_QUERY_INFO_W
{
    uint dwSize;
    uint dwFlags;
    uint dwLogQuota;
    const(wchar)* szLogFileCaption;
    const(wchar)* szDefaultDir;
    const(wchar)* szBaseFileName;
    uint dwFileType;
    uint dwReserved;
    _Anonymous_e__Union Anonymous;
}

alias CounterPathCallBack = extern(Windows) int function(uint param0);
struct PDH_BROWSE_DLG_CONFIG_HW
{
    uint _bitfield;
    HWND hWndOwner;
    int hDataSource;
    const(wchar)* szReturnPathBuffer;
    uint cchReturnPathLength;
    CounterPathCallBack pCallBack;
    uint dwCallBackArg;
    int CallBackStatus;
    uint dwDefaultDetailLevel;
    const(wchar)* szDialogBoxCaption;
}

struct PDH_BROWSE_DLG_CONFIG_HA
{
    uint _bitfield;
    HWND hWndOwner;
    int hDataSource;
    const(char)* szReturnPathBuffer;
    uint cchReturnPathLength;
    CounterPathCallBack pCallBack;
    uint dwCallBackArg;
    int CallBackStatus;
    uint dwDefaultDetailLevel;
    const(char)* szDialogBoxCaption;
}

struct PDH_BROWSE_DLG_CONFIG_W
{
    uint _bitfield;
    HWND hWndOwner;
    const(wchar)* szDataSource;
    const(wchar)* szReturnPathBuffer;
    uint cchReturnPathLength;
    CounterPathCallBack pCallBack;
    uint dwCallBackArg;
    int CallBackStatus;
    uint dwDefaultDetailLevel;
    const(wchar)* szDialogBoxCaption;
}

struct PDH_BROWSE_DLG_CONFIG_A
{
    uint _bitfield;
    HWND hWndOwner;
    const(char)* szDataSource;
    const(char)* szReturnPathBuffer;
    uint cchReturnPathLength;
    CounterPathCallBack pCallBack;
    uint dwCallBackArg;
    int CallBackStatus;
    uint dwDefaultDetailLevel;
    const(char)* szDialogBoxCaption;
}

@DllImport("loadperf.dll")
uint LoadPerfCounterTextStringsA(const(char)* lpCommandLine, BOOL bQuietModeArg);

@DllImport("loadperf.dll")
uint LoadPerfCounterTextStringsW(const(wchar)* lpCommandLine, BOOL bQuietModeArg);

@DllImport("loadperf.dll")
uint UnloadPerfCounterTextStringsW(const(wchar)* lpCommandLine, BOOL bQuietModeArg);

@DllImport("loadperf.dll")
uint UnloadPerfCounterTextStringsA(const(char)* lpCommandLine, BOOL bQuietModeArg);

@DllImport("loadperf.dll")
uint UpdatePerfNameFilesA(const(char)* szNewCtrFilePath, const(char)* szNewHlpFilePath, const(char)* szLanguageID, uint dwFlags);

@DllImport("loadperf.dll")
uint UpdatePerfNameFilesW(const(wchar)* szNewCtrFilePath, const(wchar)* szNewHlpFilePath, const(wchar)* szLanguageID, uint dwFlags);

@DllImport("loadperf.dll")
uint SetServiceAsTrustedA(const(char)* szReserved, const(char)* szServiceName);

@DllImport("loadperf.dll")
uint SetServiceAsTrustedW(const(wchar)* szReserved, const(wchar)* szServiceName);

@DllImport("loadperf.dll")
uint BackupPerfRegistryToFileW(const(wchar)* szFileName, const(wchar)* szCommentString);

@DllImport("loadperf.dll")
uint RestorePerfRegistryFromFileW(const(wchar)* szFileName, const(wchar)* szLangId);

@DllImport("ADVAPI32.dll")
uint PerfStartProvider(Guid* ProviderGuid, PERFLIBREQUEST ControlCallback, PerfProviderHandle* phProvider);

@DllImport("ADVAPI32.dll")
uint PerfStartProviderEx(Guid* ProviderGuid, PERF_PROVIDER_CONTEXT* ProviderContext, PerfProviderHandle* Provider);

@DllImport("ADVAPI32.dll")
uint PerfStopProvider(PerfProviderHandle ProviderHandle);

@DllImport("ADVAPI32.dll")
uint PerfSetCounterSetInfo(HANDLE ProviderHandle, char* Template, uint TemplateSize);

@DllImport("ADVAPI32.dll")
PERF_COUNTERSET_INSTANCE* PerfCreateInstance(PerfProviderHandle ProviderHandle, Guid* CounterSetGuid, const(wchar)* Name, uint Id);

@DllImport("ADVAPI32.dll")
uint PerfDeleteInstance(PerfProviderHandle Provider, PERF_COUNTERSET_INSTANCE* InstanceBlock);

@DllImport("ADVAPI32.dll")
PERF_COUNTERSET_INSTANCE* PerfQueryInstance(HANDLE ProviderHandle, Guid* CounterSetGuid, const(wchar)* Name, uint Id);

@DllImport("ADVAPI32.dll")
uint PerfSetCounterRefValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, void* Address);

@DllImport("ADVAPI32.dll")
uint PerfSetULongCounterValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, uint Value);

@DllImport("ADVAPI32.dll")
uint PerfSetULongLongCounterValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, ulong Value);

@DllImport("ADVAPI32.dll")
uint PerfIncrementULongCounterValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, uint Value);

@DllImport("ADVAPI32.dll")
uint PerfIncrementULongLongCounterValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, ulong Value);

@DllImport("ADVAPI32.dll")
uint PerfDecrementULongCounterValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, uint Value);

@DllImport("ADVAPI32.dll")
uint PerfDecrementULongLongCounterValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, ulong Value);

@DllImport("ADVAPI32.dll")
uint PerfEnumerateCounterSet(const(wchar)* szMachine, char* pCounterSetIds, uint cCounterSetIds, uint* pcCounterSetIdsActual);

@DllImport("ADVAPI32.dll")
uint PerfEnumerateCounterSetInstances(const(wchar)* szMachine, Guid* pCounterSetId, char* pInstances, uint cbInstances, uint* pcbInstancesActual);

@DllImport("ADVAPI32.dll")
uint PerfQueryCounterSetRegistrationInfo(const(wchar)* szMachine, Guid* pCounterSetId, PerfRegInfoType requestCode, uint requestLangId, char* pbRegInfo, uint cbRegInfo, uint* pcbRegInfoActual);

@DllImport("ADVAPI32.dll")
uint PerfOpenQueryHandle(const(wchar)* szMachine, PerfQueryHandle* phQuery);

@DllImport("ADVAPI32.dll")
uint PerfCloseQueryHandle(HANDLE hQuery);

@DllImport("ADVAPI32.dll")
uint PerfQueryCounterInfo(PerfQueryHandle hQuery, char* pCounters, uint cbCounters, uint* pcbCountersActual);

@DllImport("ADVAPI32.dll")
uint PerfQueryCounterData(PerfQueryHandle hQuery, char* pCounterBlock, uint cbCounterBlock, uint* pcbCounterBlockActual);

@DllImport("ADVAPI32.dll")
uint PerfAddCounters(PerfQueryHandle hQuery, char* pCounters, uint cbCounters);

@DllImport("ADVAPI32.dll")
uint PerfDeleteCounters(PerfQueryHandle hQuery, char* pCounters, uint cbCounters);

@DllImport("pdh.dll")
int PdhGetDllVersion(uint* lpdwVersion);

@DllImport("pdh.dll")
int PdhOpenQueryW(const(wchar)* szDataSource, uint dwUserData, int* phQuery);

@DllImport("pdh.dll")
int PdhOpenQueryA(const(char)* szDataSource, uint dwUserData, int* phQuery);

@DllImport("pdh.dll")
int PdhAddCounterW(int hQuery, const(wchar)* szFullCounterPath, uint dwUserData, int* phCounter);

@DllImport("pdh.dll")
int PdhAddCounterA(int hQuery, const(char)* szFullCounterPath, uint dwUserData, int* phCounter);

@DllImport("pdh.dll")
int PdhAddEnglishCounterW(int hQuery, const(wchar)* szFullCounterPath, uint dwUserData, int* phCounter);

@DllImport("pdh.dll")
int PdhAddEnglishCounterA(int hQuery, const(char)* szFullCounterPath, uint dwUserData, int* phCounter);

@DllImport("pdh.dll")
int PdhCollectQueryDataWithTime(int hQuery, long* pllTimeStamp);

@DllImport("pdh.dll")
int PdhValidatePathExW(int hDataSource, const(wchar)* szFullPathBuffer);

@DllImport("pdh.dll")
int PdhValidatePathExA(int hDataSource, const(char)* szFullPathBuffer);

@DllImport("pdh.dll")
int PdhRemoveCounter(int hCounter);

@DllImport("pdh.dll")
int PdhCollectQueryData(int hQuery);

@DllImport("pdh.dll")
int PdhCloseQuery(int hQuery);

@DllImport("pdh.dll")
int PdhGetFormattedCounterValue(int hCounter, uint dwFormat, uint* lpdwType, PDH_FMT_COUNTERVALUE* pValue);

@DllImport("pdh.dll")
int PdhGetFormattedCounterArrayA(int hCounter, uint dwFormat, uint* lpdwBufferSize, uint* lpdwItemCount, char* ItemBuffer);

@DllImport("pdh.dll")
int PdhGetFormattedCounterArrayW(int hCounter, uint dwFormat, uint* lpdwBufferSize, uint* lpdwItemCount, char* ItemBuffer);

@DllImport("pdh.dll")
int PdhGetRawCounterValue(int hCounter, uint* lpdwType, PDH_RAW_COUNTER* pValue);

@DllImport("pdh.dll")
int PdhGetRawCounterArrayA(int hCounter, uint* lpdwBufferSize, uint* lpdwItemCount, char* ItemBuffer);

@DllImport("pdh.dll")
int PdhGetRawCounterArrayW(int hCounter, uint* lpdwBufferSize, uint* lpdwItemCount, char* ItemBuffer);

@DllImport("pdh.dll")
int PdhCalculateCounterFromRawValue(int hCounter, uint dwFormat, PDH_RAW_COUNTER* rawValue1, PDH_RAW_COUNTER* rawValue2, PDH_FMT_COUNTERVALUE* fmtValue);

@DllImport("pdh.dll")
int PdhComputeCounterStatistics(int hCounter, uint dwFormat, uint dwFirstEntry, uint dwNumEntries, PDH_RAW_COUNTER* lpRawValueArray, PDH_STATISTICS* data);

@DllImport("pdh.dll")
int PdhGetCounterInfoW(int hCounter, ubyte bRetrieveExplainText, uint* pdwBufferSize, char* lpBuffer);

@DllImport("pdh.dll")
int PdhGetCounterInfoA(int hCounter, ubyte bRetrieveExplainText, uint* pdwBufferSize, char* lpBuffer);

@DllImport("pdh.dll")
int PdhSetCounterScaleFactor(int hCounter, int lFactor);

@DllImport("pdh.dll")
int PdhConnectMachineW(const(wchar)* szMachineName);

@DllImport("pdh.dll")
int PdhConnectMachineA(const(char)* szMachineName);

@DllImport("pdh.dll")
int PdhEnumMachinesW(const(wchar)* szDataSource, const(wchar)* mszMachineList, uint* pcchBufferSize);

@DllImport("pdh.dll")
int PdhEnumMachinesA(const(char)* szDataSource, const(char)* mszMachineList, uint* pcchBufferSize);

@DllImport("pdh.dll")
int PdhEnumObjectsW(const(wchar)* szDataSource, const(wchar)* szMachineName, const(wchar)* mszObjectList, uint* pcchBufferSize, uint dwDetailLevel, BOOL bRefresh);

@DllImport("pdh.dll")
int PdhEnumObjectsA(const(char)* szDataSource, const(char)* szMachineName, const(char)* mszObjectList, uint* pcchBufferSize, uint dwDetailLevel, BOOL bRefresh);

@DllImport("pdh.dll")
int PdhEnumObjectItemsW(const(wchar)* szDataSource, const(wchar)* szMachineName, const(wchar)* szObjectName, const(wchar)* mszCounterList, uint* pcchCounterListLength, const(wchar)* mszInstanceList, uint* pcchInstanceListLength, uint dwDetailLevel, uint dwFlags);

@DllImport("pdh.dll")
int PdhEnumObjectItemsA(const(char)* szDataSource, const(char)* szMachineName, const(char)* szObjectName, const(char)* mszCounterList, uint* pcchCounterListLength, const(char)* mszInstanceList, uint* pcchInstanceListLength, uint dwDetailLevel, uint dwFlags);

@DllImport("pdh.dll")
int PdhMakeCounterPathW(PDH_COUNTER_PATH_ELEMENTS_W* pCounterPathElements, const(wchar)* szFullPathBuffer, uint* pcchBufferSize, uint dwFlags);

@DllImport("pdh.dll")
int PdhMakeCounterPathA(PDH_COUNTER_PATH_ELEMENTS_A* pCounterPathElements, const(char)* szFullPathBuffer, uint* pcchBufferSize, uint dwFlags);

@DllImport("pdh.dll")
int PdhParseCounterPathW(const(wchar)* szFullPathBuffer, char* pCounterPathElements, uint* pdwBufferSize, uint dwFlags);

@DllImport("pdh.dll")
int PdhParseCounterPathA(const(char)* szFullPathBuffer, char* pCounterPathElements, uint* pdwBufferSize, uint dwFlags);

@DllImport("pdh.dll")
int PdhParseInstanceNameW(const(wchar)* szInstanceString, const(wchar)* szInstanceName, uint* pcchInstanceNameLength, const(wchar)* szParentName, uint* pcchParentNameLength, uint* lpIndex);

@DllImport("pdh.dll")
int PdhParseInstanceNameA(const(char)* szInstanceString, const(char)* szInstanceName, uint* pcchInstanceNameLength, const(char)* szParentName, uint* pcchParentNameLength, uint* lpIndex);

@DllImport("pdh.dll")
int PdhValidatePathW(const(wchar)* szFullPathBuffer);

@DllImport("pdh.dll")
int PdhValidatePathA(const(char)* szFullPathBuffer);

@DllImport("pdh.dll")
int PdhGetDefaultPerfObjectW(const(wchar)* szDataSource, const(wchar)* szMachineName, const(wchar)* szDefaultObjectName, uint* pcchBufferSize);

@DllImport("pdh.dll")
int PdhGetDefaultPerfObjectA(const(char)* szDataSource, const(char)* szMachineName, const(char)* szDefaultObjectName, uint* pcchBufferSize);

@DllImport("pdh.dll")
int PdhGetDefaultPerfCounterW(const(wchar)* szDataSource, const(wchar)* szMachineName, const(wchar)* szObjectName, const(wchar)* szDefaultCounterName, uint* pcchBufferSize);

@DllImport("pdh.dll")
int PdhGetDefaultPerfCounterA(const(char)* szDataSource, const(char)* szMachineName, const(char)* szObjectName, const(char)* szDefaultCounterName, uint* pcchBufferSize);

@DllImport("pdh.dll")
int PdhBrowseCountersW(PDH_BROWSE_DLG_CONFIG_W* pBrowseDlgData);

@DllImport("pdh.dll")
int PdhBrowseCountersA(PDH_BROWSE_DLG_CONFIG_A* pBrowseDlgData);

@DllImport("pdh.dll")
int PdhExpandCounterPathW(const(wchar)* szWildCardPath, const(wchar)* mszExpandedPathList, uint* pcchPathListLength);

@DllImport("pdh.dll")
int PdhExpandCounterPathA(const(char)* szWildCardPath, const(char)* mszExpandedPathList, uint* pcchPathListLength);

@DllImport("pdh.dll")
int PdhLookupPerfNameByIndexW(const(wchar)* szMachineName, uint dwNameIndex, const(wchar)* szNameBuffer, uint* pcchNameBufferSize);

@DllImport("pdh.dll")
int PdhLookupPerfNameByIndexA(const(char)* szMachineName, uint dwNameIndex, const(char)* szNameBuffer, uint* pcchNameBufferSize);

@DllImport("pdh.dll")
int PdhLookupPerfIndexByNameW(const(wchar)* szMachineName, const(wchar)* szNameBuffer, uint* pdwIndex);

@DllImport("pdh.dll")
int PdhLookupPerfIndexByNameA(const(char)* szMachineName, const(char)* szNameBuffer, uint* pdwIndex);

@DllImport("pdh.dll")
int PdhExpandWildCardPathA(const(char)* szDataSource, const(char)* szWildCardPath, const(char)* mszExpandedPathList, uint* pcchPathListLength, uint dwFlags);

@DllImport("pdh.dll")
int PdhExpandWildCardPathW(const(wchar)* szDataSource, const(wchar)* szWildCardPath, const(wchar)* mszExpandedPathList, uint* pcchPathListLength, uint dwFlags);

@DllImport("pdh.dll")
int PdhOpenLogW(const(wchar)* szLogFileName, uint dwAccessFlags, uint* lpdwLogType, int hQuery, uint dwMaxSize, const(wchar)* szUserCaption, int* phLog);

@DllImport("pdh.dll")
int PdhOpenLogA(const(char)* szLogFileName, uint dwAccessFlags, uint* lpdwLogType, int hQuery, uint dwMaxSize, const(char)* szUserCaption, int* phLog);

@DllImport("pdh.dll")
int PdhUpdateLogW(int hLog, const(wchar)* szUserString);

@DllImport("pdh.dll")
int PdhUpdateLogA(int hLog, const(char)* szUserString);

@DllImport("pdh.dll")
int PdhUpdateLogFileCatalog(int hLog);

@DllImport("pdh.dll")
int PdhGetLogFileSize(int hLog, long* llSize);

@DllImport("pdh.dll")
int PdhCloseLog(int hLog, uint dwFlags);

@DllImport("pdh.dll")
int PdhSelectDataSourceW(HWND hWndOwner, uint dwFlags, const(wchar)* szDataSource, uint* pcchBufferLength);

@DllImport("pdh.dll")
int PdhSelectDataSourceA(HWND hWndOwner, uint dwFlags, const(char)* szDataSource, uint* pcchBufferLength);

@DllImport("pdh.dll")
BOOL PdhIsRealTimeQuery(int hQuery);

@DllImport("pdh.dll")
int PdhSetQueryTimeRange(int hQuery, PDH_TIME_INFO* pInfo);

@DllImport("pdh.dll")
int PdhGetDataSourceTimeRangeW(const(wchar)* szDataSource, uint* pdwNumEntries, char* pInfo, uint* pdwBufferSize);

@DllImport("pdh.dll")
int PdhGetDataSourceTimeRangeA(const(char)* szDataSource, uint* pdwNumEntries, char* pInfo, uint* pdwBufferSize);

@DllImport("pdh.dll")
int PdhCollectQueryDataEx(int hQuery, uint dwIntervalTime, HANDLE hNewDataEvent);

@DllImport("pdh.dll")
int PdhFormatFromRawValue(uint dwCounterType, uint dwFormat, long* pTimeBase, PDH_RAW_COUNTER* pRawValue1, PDH_RAW_COUNTER* pRawValue2, PDH_FMT_COUNTERVALUE* pFmtValue);

@DllImport("pdh.dll")
int PdhGetCounterTimeBase(int hCounter, long* pTimeBase);

@DllImport("pdh.dll")
int PdhReadRawLogRecord(int hLog, FILETIME ftRecord, char* pRawLogRecord, uint* pdwBufferLength);

@DllImport("pdh.dll")
int PdhSetDefaultRealTimeDataSource(uint dwDataSourceId);

@DllImport("pdh.dll")
int PdhBindInputDataSourceW(int* phDataSource, const(wchar)* LogFileNameList);

@DllImport("pdh.dll")
int PdhBindInputDataSourceA(int* phDataSource, const(char)* LogFileNameList);

@DllImport("pdh.dll")
int PdhOpenQueryH(int hDataSource, uint dwUserData, int* phQuery);

@DllImport("pdh.dll")
int PdhEnumMachinesHW(int hDataSource, const(wchar)* mszMachineList, uint* pcchBufferSize);

@DllImport("pdh.dll")
int PdhEnumMachinesHA(int hDataSource, const(char)* mszMachineList, uint* pcchBufferSize);

@DllImport("pdh.dll")
int PdhEnumObjectsHW(int hDataSource, const(wchar)* szMachineName, const(wchar)* mszObjectList, uint* pcchBufferSize, uint dwDetailLevel, BOOL bRefresh);

@DllImport("pdh.dll")
int PdhEnumObjectsHA(int hDataSource, const(char)* szMachineName, const(char)* mszObjectList, uint* pcchBufferSize, uint dwDetailLevel, BOOL bRefresh);

@DllImport("pdh.dll")
int PdhEnumObjectItemsHW(int hDataSource, const(wchar)* szMachineName, const(wchar)* szObjectName, const(wchar)* mszCounterList, uint* pcchCounterListLength, const(wchar)* mszInstanceList, uint* pcchInstanceListLength, uint dwDetailLevel, uint dwFlags);

@DllImport("pdh.dll")
int PdhEnumObjectItemsHA(int hDataSource, const(char)* szMachineName, const(char)* szObjectName, const(char)* mszCounterList, uint* pcchCounterListLength, const(char)* mszInstanceList, uint* pcchInstanceListLength, uint dwDetailLevel, uint dwFlags);

@DllImport("pdh.dll")
int PdhExpandWildCardPathHW(int hDataSource, const(wchar)* szWildCardPath, const(wchar)* mszExpandedPathList, uint* pcchPathListLength, uint dwFlags);

@DllImport("pdh.dll")
int PdhExpandWildCardPathHA(int hDataSource, const(char)* szWildCardPath, const(char)* mszExpandedPathList, uint* pcchPathListLength, uint dwFlags);

@DllImport("pdh.dll")
int PdhGetDataSourceTimeRangeH(int hDataSource, uint* pdwNumEntries, char* pInfo, uint* pdwBufferSize);

@DllImport("pdh.dll")
int PdhGetDefaultPerfObjectHW(int hDataSource, const(wchar)* szMachineName, const(wchar)* szDefaultObjectName, uint* pcchBufferSize);

@DllImport("pdh.dll")
int PdhGetDefaultPerfObjectHA(int hDataSource, const(char)* szMachineName, const(char)* szDefaultObjectName, uint* pcchBufferSize);

@DllImport("pdh.dll")
int PdhGetDefaultPerfCounterHW(int hDataSource, const(wchar)* szMachineName, const(wchar)* szObjectName, const(wchar)* szDefaultCounterName, uint* pcchBufferSize);

@DllImport("pdh.dll")
int PdhGetDefaultPerfCounterHA(int hDataSource, const(char)* szMachineName, const(char)* szObjectName, const(char)* szDefaultCounterName, uint* pcchBufferSize);

@DllImport("pdh.dll")
int PdhBrowseCountersHW(PDH_BROWSE_DLG_CONFIG_HW* pBrowseDlgData);

@DllImport("pdh.dll")
int PdhBrowseCountersHA(PDH_BROWSE_DLG_CONFIG_HA* pBrowseDlgData);

@DllImport("pdh.dll")
int PdhVerifySQLDBW(const(wchar)* szDataSource);

@DllImport("pdh.dll")
int PdhVerifySQLDBA(const(char)* szDataSource);

@DllImport("pdh.dll")
int PdhCreateSQLTablesW(const(wchar)* szDataSource);

@DllImport("pdh.dll")
int PdhCreateSQLTablesA(const(char)* szDataSource);

@DllImport("pdh.dll")
int PdhEnumLogSetNamesW(const(wchar)* szDataSource, const(wchar)* mszDataSetNameList, uint* pcchBufferLength);

@DllImport("pdh.dll")
int PdhEnumLogSetNamesA(const(char)* szDataSource, const(char)* mszDataSetNameList, uint* pcchBufferLength);

@DllImport("pdh.dll")
int PdhGetLogSetGUID(int hLog, Guid* pGuid, int* pRunId);

@DllImport("pdh.dll")
int PdhSetLogSetRunID(int hLog, int RunId);

struct PERF_DATA_BLOCK
{
    ushort Signature;
    uint LittleEndian;
    uint Version;
    uint Revision;
    uint TotalByteLength;
    uint HeaderLength;
    uint NumObjectTypes;
    int DefaultObject;
    SYSTEMTIME SystemTime;
    LARGE_INTEGER PerfTime;
    LARGE_INTEGER PerfFreq;
    LARGE_INTEGER PerfTime100nSec;
    uint SystemNameLength;
    uint SystemNameOffset;
}

struct PERF_OBJECT_TYPE
{
    uint TotalByteLength;
    uint DefinitionLength;
    uint HeaderLength;
    uint ObjectNameTitleIndex;
    const(wchar)* ObjectNameTitle;
    uint ObjectHelpTitleIndex;
    const(wchar)* ObjectHelpTitle;
    uint DetailLevel;
    uint NumCounters;
    int DefaultCounter;
    int NumInstances;
    uint CodePage;
    LARGE_INTEGER PerfTime;
    LARGE_INTEGER PerfFreq;
}

struct PERF_COUNTER_DEFINITION
{
    uint ByteLength;
    uint CounterNameTitleIndex;
    const(wchar)* CounterNameTitle;
    uint CounterHelpTitleIndex;
    const(wchar)* CounterHelpTitle;
    int DefaultScale;
    uint DetailLevel;
    uint CounterType;
    uint CounterSize;
    uint CounterOffset;
}

struct PERF_INSTANCE_DEFINITION
{
    uint ByteLength;
    uint ParentObjectTitleIndex;
    uint ParentObjectInstance;
    int UniqueID;
    uint NameOffset;
    uint NameLength;
}

struct PERF_COUNTER_BLOCK
{
    uint ByteLength;
}

alias PM_COLLECT_PROC = extern(Windows) uint function(const(wchar)* lpValueName, void** lppData, uint* lpcbTotalBytes, uint* lpNumObjectTypes);
alias PM_CLOSE_PROC = extern(Windows) uint function();
