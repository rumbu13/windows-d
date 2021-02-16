module windows.performancelogandalerts;

public import windows.core;
public import windows.automation : BSTR, IDispatch, SAFEARRAY, VARIANT;
public import windows.com : HRESULT, IUnknown;

extern(Windows):


// Enums


enum DataCollectorType : int
{
    plaPerformanceCounter = 0x00000000,
    plaTrace              = 0x00000001,
    plaConfiguration      = 0x00000002,
    plaAlert              = 0x00000003,
    plaApiTrace           = 0x00000004,
}

enum FileFormat : int
{
    plaCommaSeparated = 0x00000000,
    plaTabSeparated   = 0x00000001,
    plaSql            = 0x00000002,
    plaBinary         = 0x00000003,
}

enum AutoPathFormat : int
{
    plaNone               = 0x00000000,
    plaPattern            = 0x00000001,
    plaComputer           = 0x00000002,
    plaMonthDayHour       = 0x00000100,
    plaSerialNumber       = 0x00000200,
    plaYearDayOfYear      = 0x00000400,
    plaYearMonth          = 0x00000800,
    plaYearMonthDay       = 0x00001000,
    plaYearMonthDayHour   = 0x00002000,
    plaMonthDayHourMinute = 0x00004000,
}

enum DataCollectorSetStatus : int
{
    plaStopped   = 0x00000000,
    plaRunning   = 0x00000001,
    plaCompiling = 0x00000002,
    plaPending   = 0x00000003,
    plaUndefined = 0x00000004,
}

enum ClockType : int
{
    plaTimeStamp   = 0x00000000,
    plaPerformance = 0x00000001,
    plaSystem      = 0x00000002,
    plaCycle       = 0x00000003,
}

enum StreamMode : int
{
    plaFile      = 0x00000001,
    plaRealTime  = 0x00000002,
    plaBoth      = 0x00000003,
    plaBuffering = 0x00000004,
}

enum CommitMode : int
{
    plaCreateNew             = 0x00000001,
    plaModify                = 0x00000002,
    plaCreateOrModify        = 0x00000003,
    plaUpdateRunningInstance = 0x00000010,
    plaFlushTrace            = 0x00000020,
    plaValidateOnly          = 0x00001000,
}

enum ValueMapType : int
{
    plaIndex      = 0x00000001,
    plaFlag       = 0x00000002,
    plaFlagArray  = 0x00000003,
    plaValidation = 0x00000004,
}

enum WeekDays : int
{
    plaRunOnce   = 0x00000000,
    plaSunday    = 0x00000001,
    plaMonday    = 0x00000002,
    plaTuesday   = 0x00000004,
    plaWednesday = 0x00000008,
    plaThursday  = 0x00000010,
    plaFriday    = 0x00000020,
    plaSaturday  = 0x00000040,
    plaEveryday  = 0x0000007f,
}

enum ResourcePolicy : int
{
    plaDeleteLargest = 0x00000000,
    plaDeleteOldest  = 0x00000001,
}

enum DataManagerSteps : int
{
    plaCreateReport    = 0x00000001,
    plaRunRules        = 0x00000002,
    plaCreateHtml      = 0x00000004,
    plaFolderActions   = 0x00000008,
    plaResourceFreeing = 0x00000010,
}

enum FolderActionSteps : int
{
    plaCreateCab    = 0x00000001,
    plaDeleteData   = 0x00000002,
    plaSendCab      = 0x00000004,
    plaDeleteCab    = 0x00000008,
    plaDeleteReport = 0x00000010,
}

// Callbacks

alias PLA_CABEXTRACT_CALLBACK = void function(const(wchar)* FileName, void* Context);

// Interfaces

@GUID("03837521-098B-11D8-9414-505054503030")
struct DataCollectorSet;

@GUID("0383751C-098B-11D8-9414-505054503030")
struct TraceSession;

@GUID("03837530-098B-11D8-9414-505054503030")
struct TraceSessionCollection;

@GUID("03837513-098B-11D8-9414-505054503030")
struct TraceDataProvider;

@GUID("03837511-098B-11D8-9414-505054503030")
struct TraceDataProviderCollection;

@GUID("03837525-098B-11D8-9414-505054503030")
struct DataCollectorSetCollection;

@GUID("03837526-098B-11D8-9414-505054503030")
struct LegacyDataCollectorSet;

@GUID("03837527-098B-11D8-9414-505054503030")
struct LegacyDataCollectorSetCollection;

@GUID("03837528-098B-11D8-9414-505054503030")
struct LegacyTraceSession;

@GUID("03837529-098B-11D8-9414-505054503030")
struct LegacyTraceSessionCollection;

@GUID("03837531-098B-11D8-9414-505054503030")
struct ServerDataCollectorSet;

@GUID("03837532-098B-11D8-9414-505054503030")
struct ServerDataCollectorSetCollection;

@GUID("03837546-098B-11D8-9414-505054503030")
struct SystemDataCollectorSet;

@GUID("03837547-098B-11D8-9414-505054503030")
struct SystemDataCollectorSetCollection;

@GUID("03837538-098B-11D8-9414-505054503030")
struct BootTraceSession;

@GUID("03837539-098B-11D8-9414-505054503030")
struct BootTraceSessionCollection;

@GUID("03837520-098B-11D8-9414-505054503030")
interface IDataCollectorSet : IDispatch
{
    HRESULT get_DataCollectors(IDataCollectorCollection* collectors);
    HRESULT get_Duration(uint* seconds);
    HRESULT put_Duration(uint seconds);
    HRESULT get_Description(BSTR* description);
    HRESULT put_Description(BSTR description);
    HRESULT get_DescriptionUnresolved(BSTR* Descr);
    HRESULT get_DisplayName(BSTR* DisplayName);
    HRESULT put_DisplayName(BSTR DisplayName);
    HRESULT get_DisplayNameUnresolved(BSTR* name);
    HRESULT get_Keywords(SAFEARRAY** keywords);
    HRESULT put_Keywords(SAFEARRAY* keywords);
    HRESULT get_LatestOutputLocation(BSTR* path);
    HRESULT put_LatestOutputLocation(BSTR path);
    HRESULT get_Name(BSTR* name);
    HRESULT get_OutputLocation(BSTR* path);
    HRESULT get_RootPath(BSTR* folder);
    HRESULT put_RootPath(BSTR folder);
    HRESULT get_Segment(short* segment);
    HRESULT put_Segment(short segment);
    HRESULT get_SegmentMaxDuration(uint* seconds);
    HRESULT put_SegmentMaxDuration(uint seconds);
    HRESULT get_SegmentMaxSize(uint* size);
    HRESULT put_SegmentMaxSize(uint size);
    HRESULT get_SerialNumber(uint* index);
    HRESULT put_SerialNumber(uint index);
    HRESULT get_Server(BSTR* server);
    HRESULT get_Status(DataCollectorSetStatus* status);
    HRESULT get_Subdirectory(BSTR* folder);
    HRESULT put_Subdirectory(BSTR folder);
    HRESULT get_SubdirectoryFormat(AutoPathFormat* format);
    HRESULT put_SubdirectoryFormat(AutoPathFormat format);
    HRESULT get_SubdirectoryFormatPattern(BSTR* pattern);
    HRESULT put_SubdirectoryFormatPattern(BSTR pattern);
    HRESULT get_Task(BSTR* task);
    HRESULT put_Task(BSTR task);
    HRESULT get_TaskRunAsSelf(short* RunAsSelf);
    HRESULT put_TaskRunAsSelf(short RunAsSelf);
    HRESULT get_TaskArguments(BSTR* task);
    HRESULT put_TaskArguments(BSTR task);
    HRESULT get_TaskUserTextArguments(BSTR* UserText);
    HRESULT put_TaskUserTextArguments(BSTR UserText);
    HRESULT get_Schedules(IScheduleCollection* ppSchedules);
    HRESULT get_SchedulesEnabled(short* enabled);
    HRESULT put_SchedulesEnabled(short enabled);
    HRESULT get_UserAccount(BSTR* user);
    HRESULT get_Xml(BSTR* xml);
    HRESULT get_Security(BSTR* pbstrSecurity);
    HRESULT put_Security(BSTR bstrSecurity);
    HRESULT get_StopOnCompletion(short* Stop);
    HRESULT put_StopOnCompletion(short Stop);
    HRESULT get_DataManager(IDataManager* DataManager);
    HRESULT SetCredentials(BSTR user, BSTR password);
    HRESULT Query(BSTR name, BSTR server);
    HRESULT Commit(BSTR name, BSTR server, CommitMode mode, IValueMap* validation);
    HRESULT Delete();
    HRESULT Start(short Synchronous);
    HRESULT Stop(short Synchronous);
    HRESULT SetXml(BSTR xml, IValueMap* validation);
    HRESULT SetValue(BSTR key, BSTR value);
    HRESULT GetValue(BSTR key, BSTR* value);
}

@GUID("03837541-098B-11D8-9414-505054503030")
interface IDataManager : IDispatch
{
    HRESULT get_Enabled(short* pfEnabled);
    HRESULT put_Enabled(short fEnabled);
    HRESULT get_CheckBeforeRunning(short* pfCheck);
    HRESULT put_CheckBeforeRunning(short fCheck);
    HRESULT get_MinFreeDisk(uint* MinFreeDisk);
    HRESULT put_MinFreeDisk(uint MinFreeDisk);
    HRESULT get_MaxSize(uint* pulMaxSize);
    HRESULT put_MaxSize(uint ulMaxSize);
    HRESULT get_MaxFolderCount(uint* pulMaxFolderCount);
    HRESULT put_MaxFolderCount(uint ulMaxFolderCount);
    HRESULT get_ResourcePolicy(ResourcePolicy* pPolicy);
    HRESULT put_ResourcePolicy(ResourcePolicy Policy);
    HRESULT get_FolderActions(IFolderActionCollection* Actions);
    HRESULT get_ReportSchema(BSTR* ReportSchema);
    HRESULT put_ReportSchema(BSTR ReportSchema);
    HRESULT get_ReportFileName(BSTR* pbstrFilename);
    HRESULT put_ReportFileName(BSTR pbstrFilename);
    HRESULT get_RuleTargetFileName(BSTR* Filename);
    HRESULT put_RuleTargetFileName(BSTR Filename);
    HRESULT get_EventsFileName(BSTR* pbstrFilename);
    HRESULT put_EventsFileName(BSTR pbstrFilename);
    HRESULT get_Rules(BSTR* pbstrXml);
    HRESULT put_Rules(BSTR bstrXml);
    HRESULT Run(DataManagerSteps Steps, BSTR bstrFolder, IValueMap* Errors);
    HRESULT Extract(BSTR CabFilename, BSTR DestinationPath);
}

@GUID("03837543-098B-11D8-9414-505054503030")
interface IFolderAction : IDispatch
{
    HRESULT get_Age(uint* pulAge);
    HRESULT put_Age(uint ulAge);
    HRESULT get_Size(uint* pulAge);
    HRESULT put_Size(uint ulAge);
    HRESULT get_Actions(FolderActionSteps* Steps);
    HRESULT put_Actions(FolderActionSteps Steps);
    HRESULT get_SendCabTo(BSTR* pbstrDestination);
    HRESULT put_SendCabTo(BSTR bstrDestination);
}

@GUID("03837544-098B-11D8-9414-505054503030")
interface IFolderActionCollection : IDispatch
{
    HRESULT get_Count(uint* Count);
    HRESULT get_Item(VARIANT Index, IFolderAction* Action);
    HRESULT get__NewEnum(IUnknown* Enum);
    HRESULT Add(IFolderAction Action);
    HRESULT Remove(VARIANT Index);
    HRESULT Clear();
    HRESULT AddRange(IFolderActionCollection Actions);
    HRESULT CreateFolderAction(IFolderAction* FolderAction);
}

@GUID("038374FF-098B-11D8-9414-505054503030")
interface IDataCollector : IDispatch
{
    HRESULT get_DataCollectorSet(IDataCollectorSet* group);
    HRESULT put_DataCollectorSet(IDataCollectorSet group);
    HRESULT get_DataCollectorType(DataCollectorType* type);
    HRESULT get_FileName(BSTR* name);
    HRESULT put_FileName(BSTR name);
    HRESULT get_FileNameFormat(AutoPathFormat* format);
    HRESULT put_FileNameFormat(AutoPathFormat format);
    HRESULT get_FileNameFormatPattern(BSTR* pattern);
    HRESULT put_FileNameFormatPattern(BSTR pattern);
    HRESULT get_LatestOutputLocation(BSTR* path);
    HRESULT put_LatestOutputLocation(BSTR path);
    HRESULT get_LogAppend(short* append);
    HRESULT put_LogAppend(short append);
    HRESULT get_LogCircular(short* circular);
    HRESULT put_LogCircular(short circular);
    HRESULT get_LogOverwrite(short* overwrite);
    HRESULT put_LogOverwrite(short overwrite);
    HRESULT get_Name(BSTR* name);
    HRESULT put_Name(BSTR name);
    HRESULT get_OutputLocation(BSTR* path);
    HRESULT get_Index(int* index);
    HRESULT put_Index(int index);
    HRESULT get_Xml(BSTR* Xml);
    HRESULT SetXml(BSTR Xml, IValueMap* Validation);
    HRESULT CreateOutputLocation(short Latest, BSTR* Location);
}

@GUID("03837506-098B-11D8-9414-505054503030")
interface IPerformanceCounterDataCollector : IDataCollector
{
    HRESULT get_DataSourceName(BSTR* dsn);
    HRESULT put_DataSourceName(BSTR dsn);
    HRESULT get_PerformanceCounters(SAFEARRAY** counters);
    HRESULT put_PerformanceCounters(SAFEARRAY* counters);
    HRESULT get_LogFileFormat(FileFormat* format);
    HRESULT put_LogFileFormat(FileFormat format);
    HRESULT get_SampleInterval(uint* interval);
    HRESULT put_SampleInterval(uint interval);
    HRESULT get_SegmentMaxRecords(uint* records);
    HRESULT put_SegmentMaxRecords(uint records);
}

@GUID("0383750B-098B-11D8-9414-505054503030")
interface ITraceDataCollector : IDataCollector
{
    HRESULT get_BufferSize(uint* size);
    HRESULT put_BufferSize(uint size);
    HRESULT get_BuffersLost(uint* buffers);
    HRESULT put_BuffersLost(uint buffers);
    HRESULT get_BuffersWritten(uint* buffers);
    HRESULT put_BuffersWritten(uint buffers);
    HRESULT get_ClockType(ClockType* clock);
    HRESULT put_ClockType(ClockType clock);
    HRESULT get_EventsLost(uint* events);
    HRESULT put_EventsLost(uint events);
    HRESULT get_ExtendedModes(uint* mode);
    HRESULT put_ExtendedModes(uint mode);
    HRESULT get_FlushTimer(uint* seconds);
    HRESULT put_FlushTimer(uint seconds);
    HRESULT get_FreeBuffers(uint* buffers);
    HRESULT put_FreeBuffers(uint buffers);
    HRESULT get_Guid(GUID* guid);
    HRESULT put_Guid(GUID guid);
    HRESULT get_IsKernelTrace(short* kernel);
    HRESULT get_MaximumBuffers(uint* buffers);
    HRESULT put_MaximumBuffers(uint buffers);
    HRESULT get_MinimumBuffers(uint* buffers);
    HRESULT put_MinimumBuffers(uint buffers);
    HRESULT get_NumberOfBuffers(uint* buffers);
    HRESULT put_NumberOfBuffers(uint buffers);
    HRESULT get_PreallocateFile(short* allocate);
    HRESULT put_PreallocateFile(short allocate);
    HRESULT get_ProcessMode(short* process);
    HRESULT put_ProcessMode(short process);
    HRESULT get_RealTimeBuffersLost(uint* buffers);
    HRESULT put_RealTimeBuffersLost(uint buffers);
    HRESULT get_SessionId(ulong* id);
    HRESULT put_SessionId(ulong id);
    HRESULT get_SessionName(BSTR* name);
    HRESULT put_SessionName(BSTR name);
    HRESULT get_SessionThreadId(uint* tid);
    HRESULT put_SessionThreadId(uint tid);
    HRESULT get_StreamMode(StreamMode* mode);
    HRESULT put_StreamMode(StreamMode mode);
    HRESULT get_TraceDataProviders(ITraceDataProviderCollection* providers);
}

@GUID("03837514-098B-11D8-9414-505054503030")
interface IConfigurationDataCollector : IDataCollector
{
    HRESULT get_FileMaxCount(uint* count);
    HRESULT put_FileMaxCount(uint count);
    HRESULT get_FileMaxRecursiveDepth(uint* depth);
    HRESULT put_FileMaxRecursiveDepth(uint depth);
    HRESULT get_FileMaxTotalSize(uint* size);
    HRESULT put_FileMaxTotalSize(uint size);
    HRESULT get_Files(SAFEARRAY** Files);
    HRESULT put_Files(SAFEARRAY* Files);
    HRESULT get_ManagementQueries(SAFEARRAY** Queries);
    HRESULT put_ManagementQueries(SAFEARRAY* Queries);
    HRESULT get_QueryNetworkAdapters(short* network);
    HRESULT put_QueryNetworkAdapters(short network);
    HRESULT get_RegistryKeys(SAFEARRAY** query);
    HRESULT put_RegistryKeys(SAFEARRAY* query);
    HRESULT get_RegistryMaxRecursiveDepth(uint* depth);
    HRESULT put_RegistryMaxRecursiveDepth(uint depth);
    HRESULT get_SystemStateFile(BSTR* FileName);
    HRESULT put_SystemStateFile(BSTR FileName);
}

@GUID("03837516-098B-11D8-9414-505054503030")
interface IAlertDataCollector : IDataCollector
{
    HRESULT get_AlertThresholds(SAFEARRAY** alerts);
    HRESULT put_AlertThresholds(SAFEARRAY* alerts);
    HRESULT get_EventLog(short* log);
    HRESULT put_EventLog(short log);
    HRESULT get_SampleInterval(uint* interval);
    HRESULT put_SampleInterval(uint interval);
    HRESULT get_Task(BSTR* task);
    HRESULT put_Task(BSTR task);
    HRESULT get_TaskRunAsSelf(short* RunAsSelf);
    HRESULT put_TaskRunAsSelf(short RunAsSelf);
    HRESULT get_TaskArguments(BSTR* task);
    HRESULT put_TaskArguments(BSTR task);
    HRESULT get_TaskUserTextArguments(BSTR* task);
    HRESULT put_TaskUserTextArguments(BSTR task);
    HRESULT get_TriggerDataCollectorSet(BSTR* name);
    HRESULT put_TriggerDataCollectorSet(BSTR name);
}

@GUID("0383751A-098B-11D8-9414-505054503030")
interface IApiTracingDataCollector : IDataCollector
{
    HRESULT get_LogApiNamesOnly(short* logapinames);
    HRESULT put_LogApiNamesOnly(short logapinames);
    HRESULT get_LogApisRecursively(short* logrecursively);
    HRESULT put_LogApisRecursively(short logrecursively);
    HRESULT get_ExePath(BSTR* exepath);
    HRESULT put_ExePath(BSTR exepath);
    HRESULT get_LogFilePath(BSTR* logfilepath);
    HRESULT put_LogFilePath(BSTR logfilepath);
    HRESULT get_IncludeModules(SAFEARRAY** includemodules);
    HRESULT put_IncludeModules(SAFEARRAY* includemodules);
    HRESULT get_IncludeApis(SAFEARRAY** includeapis);
    HRESULT put_IncludeApis(SAFEARRAY* includeapis);
    HRESULT get_ExcludeApis(SAFEARRAY** excludeapis);
    HRESULT put_ExcludeApis(SAFEARRAY* excludeapis);
}

@GUID("03837502-098B-11D8-9414-505054503030")
interface IDataCollectorCollection : IDispatch
{
    HRESULT get_Count(int* retVal);
    HRESULT get_Item(VARIANT index, IDataCollector* collector);
    HRESULT get__NewEnum(IUnknown* retVal);
    HRESULT Add(IDataCollector collector);
    HRESULT Remove(VARIANT collector);
    HRESULT Clear();
    HRESULT AddRange(IDataCollectorCollection collectors);
    HRESULT CreateDataCollectorFromXml(BSTR bstrXml, IValueMap* pValidation, IDataCollector* pCollector);
    HRESULT CreateDataCollector(DataCollectorType Type, IDataCollector* Collector);
}

@GUID("03837524-098B-11D8-9414-505054503030")
interface IDataCollectorSetCollection : IDispatch
{
    HRESULT get_Count(int* retVal);
    HRESULT get_Item(VARIANT index, IDataCollectorSet* set);
    HRESULT get__NewEnum(IUnknown* retVal);
    HRESULT Add(IDataCollectorSet set);
    HRESULT Remove(VARIANT set);
    HRESULT Clear();
    HRESULT AddRange(IDataCollectorSetCollection sets);
    HRESULT GetDataCollectorSets(BSTR server, BSTR filter);
}

@GUID("03837512-098B-11D8-9414-505054503030")
interface ITraceDataProvider : IDispatch
{
    HRESULT get_DisplayName(BSTR* name);
    HRESULT put_DisplayName(BSTR name);
    HRESULT get_Guid(GUID* guid);
    HRESULT put_Guid(GUID guid);
    HRESULT get_Level(IValueMap* ppLevel);
    HRESULT get_KeywordsAny(IValueMap* ppKeywords);
    HRESULT get_KeywordsAll(IValueMap* ppKeywords);
    HRESULT get_Properties(IValueMap* ppProperties);
    HRESULT get_FilterEnabled(short* FilterEnabled);
    HRESULT put_FilterEnabled(short FilterEnabled);
    HRESULT get_FilterType(uint* pulType);
    HRESULT put_FilterType(uint ulType);
    HRESULT get_FilterData(SAFEARRAY** ppData);
    HRESULT put_FilterData(SAFEARRAY* pData);
    HRESULT Query(BSTR bstrName, BSTR bstrServer);
    HRESULT Resolve(IDispatch pFrom);
    HRESULT SetSecurity(BSTR Sddl);
    HRESULT GetSecurity(uint SecurityInfo, BSTR* Sddl);
    HRESULT GetRegisteredProcesses(IValueMap* Processes);
}

@GUID("03837510-098B-11D8-9414-505054503030")
interface ITraceDataProviderCollection : IDispatch
{
    HRESULT get_Count(int* retVal);
    HRESULT get_Item(VARIANT index, ITraceDataProvider* ppProvider);
    HRESULT get__NewEnum(IUnknown* retVal);
    HRESULT Add(ITraceDataProvider pProvider);
    HRESULT Remove(VARIANT vProvider);
    HRESULT Clear();
    HRESULT AddRange(ITraceDataProviderCollection providers);
    HRESULT CreateTraceDataProvider(ITraceDataProvider* Provider);
    HRESULT GetTraceDataProviders(BSTR server);
    HRESULT GetTraceDataProvidersByProcess(BSTR Server, uint Pid);
}

@GUID("0383753A-098B-11D8-9414-505054503030")
interface ISchedule : IDispatch
{
    HRESULT get_StartDate(VARIANT* start);
    HRESULT put_StartDate(VARIANT start);
    HRESULT get_EndDate(VARIANT* end);
    HRESULT put_EndDate(VARIANT end);
    HRESULT get_StartTime(VARIANT* start);
    HRESULT put_StartTime(VARIANT start);
    HRESULT get_Days(WeekDays* days);
    HRESULT put_Days(WeekDays days);
}

@GUID("0383753D-098B-11D8-9414-505054503030")
interface IScheduleCollection : IDispatch
{
    HRESULT get_Count(int* retVal);
    HRESULT get_Item(VARIANT index, ISchedule* ppSchedule);
    HRESULT get__NewEnum(IUnknown* ienum);
    HRESULT Add(ISchedule pSchedule);
    HRESULT Remove(VARIANT vSchedule);
    HRESULT Clear();
    HRESULT AddRange(IScheduleCollection pSchedules);
    HRESULT CreateSchedule(ISchedule* Schedule);
}

@GUID("03837533-098B-11D8-9414-505054503030")
interface IValueMapItem : IDispatch
{
    HRESULT get_Description(BSTR* description);
    HRESULT put_Description(BSTR description);
    HRESULT get_Enabled(short* enabled);
    HRESULT put_Enabled(short enabled);
    HRESULT get_Key(BSTR* key);
    HRESULT put_Key(BSTR key);
    HRESULT get_Value(VARIANT* Value);
    HRESULT put_Value(VARIANT Value);
    HRESULT get_ValueMapType(ValueMapType* type);
    HRESULT put_ValueMapType(ValueMapType type);
}

@GUID("03837534-098B-11D8-9414-505054503030")
interface IValueMap : IDispatch
{
    HRESULT get_Count(int* retVal);
    HRESULT get_Item(VARIANT index, IValueMapItem* value);
    HRESULT get__NewEnum(IUnknown* retVal);
    HRESULT get_Description(BSTR* description);
    HRESULT put_Description(BSTR description);
    HRESULT get_Value(VARIANT* Value);
    HRESULT put_Value(VARIANT Value);
    HRESULT get_ValueMapType(ValueMapType* type);
    HRESULT put_ValueMapType(ValueMapType type);
    HRESULT Add(VARIANT value);
    HRESULT Remove(VARIANT value);
    HRESULT Clear();
    HRESULT AddRange(IValueMap map);
    HRESULT CreateValueMapItem(IValueMapItem* Item);
}


// GUIDs

const GUID CLSID_BootTraceSession                 = GUIDOF!BootTraceSession;
const GUID CLSID_BootTraceSessionCollection       = GUIDOF!BootTraceSessionCollection;
const GUID CLSID_DataCollectorSet                 = GUIDOF!DataCollectorSet;
const GUID CLSID_DataCollectorSetCollection       = GUIDOF!DataCollectorSetCollection;
const GUID CLSID_LegacyDataCollectorSet           = GUIDOF!LegacyDataCollectorSet;
const GUID CLSID_LegacyDataCollectorSetCollection = GUIDOF!LegacyDataCollectorSetCollection;
const GUID CLSID_LegacyTraceSession               = GUIDOF!LegacyTraceSession;
const GUID CLSID_LegacyTraceSessionCollection     = GUIDOF!LegacyTraceSessionCollection;
const GUID CLSID_ServerDataCollectorSet           = GUIDOF!ServerDataCollectorSet;
const GUID CLSID_ServerDataCollectorSetCollection = GUIDOF!ServerDataCollectorSetCollection;
const GUID CLSID_SystemDataCollectorSet           = GUIDOF!SystemDataCollectorSet;
const GUID CLSID_SystemDataCollectorSetCollection = GUIDOF!SystemDataCollectorSetCollection;
const GUID CLSID_TraceDataProvider                = GUIDOF!TraceDataProvider;
const GUID CLSID_TraceDataProviderCollection      = GUIDOF!TraceDataProviderCollection;
const GUID CLSID_TraceSession                     = GUIDOF!TraceSession;
const GUID CLSID_TraceSessionCollection           = GUIDOF!TraceSessionCollection;

const GUID IID_IAlertDataCollector              = GUIDOF!IAlertDataCollector;
const GUID IID_IApiTracingDataCollector         = GUIDOF!IApiTracingDataCollector;
const GUID IID_IConfigurationDataCollector      = GUIDOF!IConfigurationDataCollector;
const GUID IID_IDataCollector                   = GUIDOF!IDataCollector;
const GUID IID_IDataCollectorCollection         = GUIDOF!IDataCollectorCollection;
const GUID IID_IDataCollectorSet                = GUIDOF!IDataCollectorSet;
const GUID IID_IDataCollectorSetCollection      = GUIDOF!IDataCollectorSetCollection;
const GUID IID_IDataManager                     = GUIDOF!IDataManager;
const GUID IID_IFolderAction                    = GUIDOF!IFolderAction;
const GUID IID_IFolderActionCollection          = GUIDOF!IFolderActionCollection;
const GUID IID_IPerformanceCounterDataCollector = GUIDOF!IPerformanceCounterDataCollector;
const GUID IID_ISchedule                        = GUIDOF!ISchedule;
const GUID IID_IScheduleCollection              = GUIDOF!IScheduleCollection;
const GUID IID_ITraceDataCollector              = GUIDOF!ITraceDataCollector;
const GUID IID_ITraceDataProvider               = GUIDOF!ITraceDataProvider;
const GUID IID_ITraceDataProviderCollection     = GUIDOF!ITraceDataProviderCollection;
const GUID IID_IValueMap                        = GUIDOF!IValueMap;
const GUID IID_IValueMapItem                    = GUIDOF!IValueMapItem;
