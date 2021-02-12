module windows.performancelogandalerts;

public import system;
public import windows.automation;
public import windows.com;

extern(Windows):

const GUID CLSID_DataCollectorSet = {0x03837521, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837521, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
struct DataCollectorSet;

const GUID CLSID_TraceSession = {0x0383751C, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x0383751C, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
struct TraceSession;

const GUID CLSID_TraceSessionCollection = {0x03837530, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837530, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
struct TraceSessionCollection;

const GUID CLSID_TraceDataProvider = {0x03837513, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837513, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
struct TraceDataProvider;

const GUID CLSID_TraceDataProviderCollection = {0x03837511, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837511, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
struct TraceDataProviderCollection;

const GUID CLSID_DataCollectorSetCollection = {0x03837525, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837525, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
struct DataCollectorSetCollection;

const GUID CLSID_LegacyDataCollectorSet = {0x03837526, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837526, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
struct LegacyDataCollectorSet;

const GUID CLSID_LegacyDataCollectorSetCollection = {0x03837527, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837527, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
struct LegacyDataCollectorSetCollection;

const GUID CLSID_LegacyTraceSession = {0x03837528, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837528, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
struct LegacyTraceSession;

const GUID CLSID_LegacyTraceSessionCollection = {0x03837529, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837529, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
struct LegacyTraceSessionCollection;

const GUID CLSID_ServerDataCollectorSet = {0x03837531, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837531, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
struct ServerDataCollectorSet;

const GUID CLSID_ServerDataCollectorSetCollection = {0x03837532, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837532, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
struct ServerDataCollectorSetCollection;

const GUID CLSID_SystemDataCollectorSet = {0x03837546, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837546, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
struct SystemDataCollectorSet;

const GUID CLSID_SystemDataCollectorSetCollection = {0x03837547, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837547, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
struct SystemDataCollectorSetCollection;

const GUID CLSID_BootTraceSession = {0x03837538, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837538, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
struct BootTraceSession;

const GUID CLSID_BootTraceSessionCollection = {0x03837539, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837539, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
struct BootTraceSessionCollection;

enum DataCollectorType
{
    plaPerformanceCounter = 0,
    plaTrace = 1,
    plaConfiguration = 2,
    plaAlert = 3,
    plaApiTrace = 4,
}

enum FileFormat
{
    plaCommaSeparated = 0,
    plaTabSeparated = 1,
    plaSql = 2,
    plaBinary = 3,
}

enum AutoPathFormat
{
    plaNone = 0,
    plaPattern = 1,
    plaComputer = 2,
    plaMonthDayHour = 256,
    plaSerialNumber = 512,
    plaYearDayOfYear = 1024,
    plaYearMonth = 2048,
    plaYearMonthDay = 4096,
    plaYearMonthDayHour = 8192,
    plaMonthDayHourMinute = 16384,
}

enum DataCollectorSetStatus
{
    plaStopped = 0,
    plaRunning = 1,
    plaCompiling = 2,
    plaPending = 3,
    plaUndefined = 4,
}

enum ClockType
{
    plaTimeStamp = 0,
    plaPerformance = 1,
    plaSystem = 2,
    plaCycle = 3,
}

enum StreamMode
{
    plaFile = 1,
    plaRealTime = 2,
    plaBoth = 3,
    plaBuffering = 4,
}

enum CommitMode
{
    plaCreateNew = 1,
    plaModify = 2,
    plaCreateOrModify = 3,
    plaUpdateRunningInstance = 16,
    plaFlushTrace = 32,
    plaValidateOnly = 4096,
}

enum ValueMapType
{
    plaIndex = 1,
    plaFlag = 2,
    plaFlagArray = 3,
    plaValidation = 4,
}

enum WeekDays
{
    plaRunOnce = 0,
    plaSunday = 1,
    plaMonday = 2,
    plaTuesday = 4,
    plaWednesday = 8,
    plaThursday = 16,
    plaFriday = 32,
    plaSaturday = 64,
    plaEveryday = 127,
}

enum ResourcePolicy
{
    plaDeleteLargest = 0,
    plaDeleteOldest = 1,
}

enum DataManagerSteps
{
    plaCreateReport = 1,
    plaRunRules = 2,
    plaCreateHtml = 4,
    plaFolderActions = 8,
    plaResourceFreeing = 16,
}

enum FolderActionSteps
{
    plaCreateCab = 1,
    plaDeleteData = 2,
    plaSendCab = 4,
    plaDeleteCab = 8,
    plaDeleteReport = 16,
}

alias PLA_CABEXTRACT_CALLBACK = extern(Windows) void function(const(wchar)* FileName, void* Context);
const GUID IID_IDataCollectorSet = {0x03837520, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837520, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
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

const GUID IID_IDataManager = {0x03837541, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837541, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
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

const GUID IID_IFolderAction = {0x03837543, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837543, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
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

const GUID IID_IFolderActionCollection = {0x03837544, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837544, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
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

const GUID IID_IDataCollector = {0x038374FF, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x038374FF, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
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

const GUID IID_IPerformanceCounterDataCollector = {0x03837506, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837506, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
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

const GUID IID_ITraceDataCollector = {0x0383750B, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x0383750B, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
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
    HRESULT get_Guid(Guid* guid);
    HRESULT put_Guid(Guid guid);
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

const GUID IID_IConfigurationDataCollector = {0x03837514, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837514, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
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

const GUID IID_IAlertDataCollector = {0x03837516, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837516, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
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

const GUID IID_IApiTracingDataCollector = {0x0383751A, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x0383751A, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
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

const GUID IID_IDataCollectorCollection = {0x03837502, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837502, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
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

const GUID IID_IDataCollectorSetCollection = {0x03837524, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837524, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
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

const GUID IID_ITraceDataProvider = {0x03837512, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837512, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
interface ITraceDataProvider : IDispatch
{
    HRESULT get_DisplayName(BSTR* name);
    HRESULT put_DisplayName(BSTR name);
    HRESULT get_Guid(Guid* guid);
    HRESULT put_Guid(Guid guid);
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

const GUID IID_ITraceDataProviderCollection = {0x03837510, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837510, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
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

const GUID IID_ISchedule = {0x0383753A, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x0383753A, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
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

const GUID IID_IScheduleCollection = {0x0383753D, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x0383753D, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
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

const GUID IID_IValueMapItem = {0x03837533, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837533, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
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

const GUID IID_IValueMap = {0x03837534, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]};
@GUID(0x03837534, 0x098B, 0x11D8, [0x94, 0x14, 0x50, 0x50, 0x54, 0x50, 0x30, 0x30]);
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

