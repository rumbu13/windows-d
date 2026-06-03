// Written in the D programming language.

module windows.win32.system.performance;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, BSTR, FILETIME, HANDLE,
                                         HRESULT, HWND, PSTR, PWSTR, SYSTEMTIME,
                                         VARIANT_BOOL;
public import windows.win32.system.com : IDispatch, IUnknown, SAFEARRAY;
public import windows.win32.system.ole : IFontDisp;
public import windows.win32.system.variant : VARIANT;

extern(Windows) @nogc nothrow:


// Enums


alias PERF_DETAIL = uint;
enum : uint
{
    PERF_DETAIL_NOVICE   = 0x00000064U,
    PERF_DETAIL_ADVANCED = 0x000000c8U,
    PERF_DETAIL_EXPERT   = 0x0000012cU,
    PERF_DETAIL_WIZARD   = 0x00000190U,
}

alias REAL_TIME_DATA_SOURCE_ID_FLAGS = uint;
enum : uint
{
    DATA_SOURCE_REGISTRY = 0x00000001U,
    DATA_SOURCE_WBEM     = 0x00000004U,
}

alias PDH_PATH_FLAGS = uint;
enum : uint
{
    PDH_PATH_WBEM_RESULT = 0x00000001U,
    PDH_PATH_WBEM_INPUT  = 0x00000002U,
    PDH_PATH_WBEM_NONE   = 0x00000000U,
}

alias PDH_FMT = uint;
enum : uint
{
    PDH_FMT_DOUBLE = 0x00000200U,
    PDH_FMT_LARGE  = 0x00000400U,
    PDH_FMT_LONG   = 0x00000100U,
}

alias PDH_LOG_TYPE = uint;
enum : uint
{
    PDH_LOG_TYPE_UNDEFINED = 0x00000000U,
    PDH_LOG_TYPE_CSV       = 0x00000001U,
    PDH_LOG_TYPE_SQL       = 0x00000007U,
    PDH_LOG_TYPE_TSV       = 0x00000002U,
    PDH_LOG_TYPE_BINARY    = 0x00000008U,
    PDH_LOG_TYPE_PERFMON   = 0x00000006U,
}

alias PDH_LOG = uint;
enum : uint
{
    PDH_LOG_READ_ACCESS   = 0x00010000U,
    PDH_LOG_WRITE_ACCESS  = 0x00020000U,
    PDH_LOG_UPDATE_ACCESS = 0x00040000U,
}

alias PDH_SELECT_DATA_SOURCE_FLAGS = uint;
enum : uint
{
    PDH_FLAGS_FILE_BROWSER_ONLY = 0x00000001U,
    PDH_FLAGS_NONE              = 0x00000000U,
}

alias PDH_DLL_VERSION = uint;
enum : uint
{
    PDH_CVERSION_WIN50 = 0x00000500U,
    PDH_VERSION        = 0x00000503U,
}

alias PERF_COUNTER_AGGREGATE_FUNC = uint;
enum : uint
{
    PERF_AGGREGATE_UNDEFINED = 0x00000000U,
    PERF_AGGREGATE_TOTAL     = 0x00000001U,
    PERF_AGGREGATE_AVG       = 0x00000002U,
    PERF_AGGREGATE_MIN       = 0x00000003U,
    PERF_AGGREGATE_MAX       = 0x00000004U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/ne-pla-datacollectortype
enum DataCollectorType : int
{
    plaPerformanceCounter = 0x00000000,
    plaTrace              = 0x00000001,
    plaConfiguration      = 0x00000002,
    plaAlert              = 0x00000003,
    plaApiTrace           = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/ne-pla-fileformat
enum FileFormat : int
{
    plaCommaSeparated = 0x00000000,
    plaTabSeparated   = 0x00000001,
    plaSql            = 0x00000002,
    plaBinary         = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/ne-pla-autopathformat
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/ne-pla-datacollectorsetstatus
enum DataCollectorSetStatus : int
{
    plaStopped   = 0x00000000,
    plaRunning   = 0x00000001,
    plaCompiling = 0x00000002,
    plaPending   = 0x00000003,
    plaUndefined = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/ne-pla-clocktype
enum ClockType : int
{
    plaTimeStamp   = 0x00000000,
    plaPerformance = 0x00000001,
    plaSystem      = 0x00000002,
    plaCycle       = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/ne-pla-streammode
enum StreamMode : int
{
    plaFile      = 0x00000001,
    plaRealTime  = 0x00000002,
    plaBoth      = 0x00000003,
    plaBuffering = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/ne-pla-commitmode
enum CommitMode : int
{
    plaCreateNew             = 0x00000001,
    plaModify                = 0x00000002,
    plaCreateOrModify        = 0x00000003,
    plaUpdateRunningInstance = 0x00000010,
    plaFlushTrace            = 0x00000020,
    plaValidateOnly          = 0x00001000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/ne-pla-valuemaptype
enum ValueMapType : int
{
    plaIndex      = 0x00000001,
    plaFlag       = 0x00000002,
    plaFlagArray  = 0x00000003,
    plaValidation = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/ne-pla-weekdays
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/ne-pla-resourcepolicy
enum ResourcePolicy : int
{
    plaDeleteLargest = 0x00000000,
    plaDeleteOldest  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/ne-pla-datamanagersteps
enum DataManagerSteps : int
{
    plaCreateReport    = 0x00000001,
    plaRunRules        = 0x00000002,
    plaCreateHtml      = 0x00000004,
    plaFolderActions   = 0x00000008,
    plaResourceFreeing = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/ne-pla-folderactionsteps
enum FolderActionSteps : int
{
    plaCreateCab    = 0x00000001,
    plaDeleteData   = 0x00000002,
    plaSendCab      = 0x00000004,
    plaDeleteCab    = 0x00000008,
    plaDeleteReport = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/perflib/ne-perflib-perfreginfotype
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/perflib/ne-perflib-perfcounterdatatype
enum PerfCounterDataType : int
{
    PERF_ERROR_RETURN       = 0x00000000,
    PERF_SINGLE_COUNTER     = 0x00000001,
    PERF_MULTIPLE_COUNTERS  = 0x00000002,
    PERF_MULTIPLE_INSTANCES = 0x00000004,
    PERF_COUNTERSET         = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/isysmon/ne-isysmon-displaytypeconstants
enum DisplayTypeConstants : int
{
    sysmonLineGraph        = 0x00000001,
    sysmonHistogram        = 0x00000002,
    sysmonReport           = 0x00000003,
    sysmonChartArea        = 0x00000004,
    sysmonChartStackedArea = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/isysmon/ne-isysmon-reportvaluetypeconstants
enum ReportValueTypeConstants : int
{
    sysmonDefaultValue = 0x00000000,
    sysmonCurrentValue = 0x00000001,
    sysmonAverage      = 0x00000002,
    sysmonMinimum      = 0x00000003,
    sysmonMaximum      = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/isysmon/ne-isysmon-datasourcetypeconstants
enum DataSourceTypeConstants : int
{
    sysmonNullDataSource  = 0xffffffff,
    sysmonCurrentActivity = 0x00000001,
    sysmonLogFiles        = 0x00000002,
    sysmonSqlLog          = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/isysmon/ne-isysmon-sysmonfiletype
enum SysmonFileType : int
{
    sysmonFileHtml       = 0x00000001,
    sysmonFileReport     = 0x00000002,
    sysmonFileCsv        = 0x00000003,
    sysmonFileTsv        = 0x00000004,
    sysmonFileBlg        = 0x00000005,
    sysmonFileRetiredBlg = 0x00000006,
    sysmonFileGif        = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/isysmon/ne-isysmon-sysmondatatype
enum SysmonDataType : int
{
    sysmonDataAvg   = 0x00000001,
    sysmonDataMin   = 0x00000002,
    sysmonDataMax   = 0x00000003,
    sysmonDataTime  = 0x00000004,
    sysmonDataCount = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/isysmon/ne-isysmon-sysmonbatchreason
enum SysmonBatchReason : int
{
    sysmonBatchNone                 = 0x00000000,
    sysmonBatchAddFiles             = 0x00000001,
    sysmonBatchAddCounters          = 0x00000002,
    sysmonBatchAddFilesAutoCounters = 0x00000003,
}

// Constants


enum uint MAX_COUNTER_PATH = 0x00000100U;
enum uint PDH_MAX_COUNTER_NAME = 0x00000400U;
enum uint PDH_MAX_INSTANCE_NAME = 0x00000400U;
enum uint PDH_MAX_COUNTER_PATH = 0x00000800U;
enum uint PDH_MAX_DATASOURCE_PATH = 0x00000400U;
enum int H_WBEM_DATASOURCE = 0xffffffff;
enum int PDH_MAX_SCALE = 0x00000007;
enum int PDH_MIN_SCALE = 0xfffffff9;

enum : uint
{
    PDH_NOEXPANDCOUNTERS  = 0x00000001U,
    PDH_NOEXPANDINSTANCES = 0x00000002U,
}

enum uint PDH_REFRESHCOUNTERS = 0x00000004U;

enum : uint
{
    PDH_LOG_TYPE_RETIRED_BIN   = 0x00000003U,
    PDH_LOG_TYPE_TRACE_KERNEL  = 0x00000004U,
    PDH_LOG_TYPE_TRACE_GENERIC = 0x00000005U,
}

enum : uint
{
    PERF_PROVIDER_USER_MODE   = 0x00000000U,
    PERF_PROVIDER_KERNEL_MODE = 0x00000001U,
    PERF_PROVIDER_DRIVER      = 0x00000002U,
}

enum : uint
{
    PERF_COUNTERSET_FLAG_MULTIPLE    = 0x00000002U,
    PERF_COUNTERSET_FLAG_AGGREGATE   = 0x00000004U,
    PERF_COUNTERSET_FLAG_HISTORY     = 0x00000008U,
    PERF_COUNTERSET_FLAG_INSTANCE    = 0x00000010U,
    PERF_COUNTERSET_SINGLE_INSTANCE  = 0x00000000U,
    PERF_COUNTERSET_MULTI_INSTANCES  = 0x00000002U,
    PERF_COUNTERSET_SINGLE_AGGREGATE = 0x00000004U,
}

enum : ulong
{
    PERF_ATTRIB_BY_REFERENCE       = 0x0000000000000001UL,
    PERF_ATTRIB_NO_DISPLAYABLE     = 0x0000000000000002UL,
    PERF_ATTRIB_NO_GROUP_SEPARATOR = 0x0000000000000004UL,
}

enum : ulong
{
    PERF_ATTRIB_DISPLAY_AS_REAL = 0x0000000000000008UL,
    PERF_ATTRIB_DISPLAY_AS_HEX  = 0x0000000000000010UL,
}

enum uint PERF_WILDCARD_COUNTER = 0xffffffffU;
enum const(wchar)* PERF_WILDCARD_INSTANCE = "*";
enum const(wchar)* PERF_AGGREGATE_INSTANCE = "_Total";
enum uint PERF_MAX_INSTANCE_NAME = 0x00000400U;
enum uint PERF_ADD_COUNTER = 0x00000001U;
enum uint PERF_REMOVE_COUNTER = 0x00000002U;
enum uint PERF_ENUM_INSTANCES = 0x00000003U;

enum : uint
{
    PERF_COLLECT_START = 0x00000005U,
    PERF_COLLECT_END   = 0x00000006U,
}

enum : uint
{
    PERF_FILTER        = 0x00000009U,
    PERF_DATA_VERSION  = 0x00000001U,
    PERF_DATA_REVISION = 0x00000001U,
}

enum int PERF_NO_INSTANCES = 0xffffffff;

enum : int
{
    PERF_METADATA_MULTIPLE_INSTANCES = 0xfffffffe,
    PERF_METADATA_NO_INSTANCES       = 0xfffffffd,
}

enum : uint
{
    PERF_SIZE_DWORD        = 0x00000000U,
    PERF_SIZE_LARGE        = 0x00000100U,
    PERF_SIZE_ZERO         = 0x00000200U,
    PERF_SIZE_VARIABLE_LEN = 0x00000300U,
}

enum : uint
{
    PERF_TYPE_NUMBER  = 0x00000000U,
    PERF_TYPE_COUNTER = 0x00000400U,
    PERF_TYPE_TEXT    = 0x00000800U,
    PERF_TYPE_ZERO    = 0x00000c00U,
}

enum : uint
{
    PERF_NUMBER_HEX      = 0x00000000U,
    PERF_NUMBER_DECIMAL  = 0x00010000U,
    PERF_NUMBER_DEC_1000 = 0x00020000U,
}

enum : uint
{
    PERF_COUNTER_VALUE     = 0x00000000U,
    PERF_COUNTER_RATE      = 0x00010000U,
    PERF_COUNTER_FRACTION  = 0x00020000U,
    PERF_COUNTER_BASE      = 0x00030000U,
    PERF_COUNTER_ELAPSED   = 0x00040000U,
    PERF_COUNTER_QUEUELEN  = 0x00050000U,
    PERF_COUNTER_HISTOGRAM = 0x00060000U,
    PERF_COUNTER_PRECISION = 0x00070000U,
}

enum : uint
{
    PERF_TEXT_UNICODE = 0x00000000U,
    PERF_TEXT_ASCII   = 0x00010000U,
}

enum : uint
{
    PERF_TIMER_TICK  = 0x00000000U,
    PERF_TIMER_100NS = 0x00100000U,
}

enum uint PERF_OBJECT_TIMER = 0x00200000U;

enum : uint
{
    PERF_DELTA_COUNTER = 0x00400000U,
    PERF_DELTA_BASE    = 0x00800000U,
}

enum uint PERF_INVERSE_COUNTER = 0x01000000U;
enum uint PERF_MULTI_COUNTER = 0x02000000U;

enum : uint
{
    PERF_DISPLAY_NO_SUFFIX = 0x00000000U,
    PERF_DISPLAY_PER_SEC   = 0x10000000U,
    PERF_DISPLAY_PERCENT   = 0x20000000U,
    PERF_DISPLAY_SECONDS   = 0x30000000U,
    PERF_DISPLAY_NOSHOW    = 0x40000000U,
}

enum uint PERF_COUNTER_HISTOGRAM_TYPE = 0x80000000U;
enum int PERF_NO_UNIQUE_ID = 0xffffffff;
enum int MAX_PERF_OBJECTS_IN_QUERY_FUNCTION = 0x00000040;

enum : uint
{
    WINPERF_LOG_NONE    = 0x00000000U,
    WINPERF_LOG_USER    = 0x00000001U,
    WINPERF_LOG_DEBUG   = 0x00000002U,
    WINPERF_LOG_VERBOSE = 0x00000003U,
}

enum GUID LIBID_SystemMonitor = GUID("1b773e42-2509-11cf-942f-008029004347");
enum GUID DIID_DICounterItem = GUID("c08c4ff2-0e2e-11cf-942c-008029004347");
enum GUID DIID_DILogFileItem = GUID("8d093ffc-f777-4917-82d1-833fbc54c58f");

enum : GUID
{
    DIID_DISystemMonitor         = GUID("13d73d81-c32e-11cf-9398-00aa00a3ddea"),
    DIID_DISystemMonitorInternal = GUID("194eb242-c32c-11cf-9398-00aa00a3ddea"),
    DIID_DISystemMonitorEvents   = GUID("84979930-4ab3-11cf-943a-008029004347"),
}

enum : uint
{
    PDH_CSTATUS_VALID_DATA  = 0x00000000U,
    PDH_CSTATUS_NEW_DATA    = 0x00000001U,
    PDH_CSTATUS_NO_MACHINE  = 0x800007d0U,
    PDH_CSTATUS_NO_INSTANCE = 0x800007d1U,
}

enum uint PDH_MORE_DATA = 0x800007d2U;
enum uint PDH_CSTATUS_ITEM_NOT_VALIDATED = 0x800007d3U;

enum : uint
{
    PDH_RETRY   = 0x800007d4U,
    PDH_NO_DATA = 0x800007d5U,
}

enum : uint
{
    PDH_CALC_NEGATIVE_DENOMINATOR = 0x800007d6U,
    PDH_CALC_NEGATIVE_TIMEBASE    = 0x800007d7U,
    PDH_CALC_NEGATIVE_VALUE       = 0x800007d8U,
}

enum uint PDH_DIALOG_CANCELLED = 0x800007d9U;
enum uint PDH_END_OF_LOG_FILE = 0x800007daU;
enum uint PDH_ASYNC_QUERY_TIMEOUT = 0x800007dbU;
enum uint PDH_CANNOT_SET_DEFAULT_REALTIME_DATASOURCE = 0x800007dcU;
enum uint PDH_UNABLE_MAP_NAME_FILES = 0x80000bd5U;
enum uint PDH_PLA_VALIDATION_WARNING = 0x80000bf3U;

enum : uint
{
    PDH_CSTATUS_NO_OBJECT    = 0xc0000bb8U,
    PDH_CSTATUS_NO_COUNTER   = 0xc0000bb9U,
    PDH_CSTATUS_INVALID_DATA = 0xc0000bbaU,
}

enum uint PDH_MEMORY_ALLOCATION_FAILURE = 0xc0000bbbU;

enum : uint
{
    PDH_INVALID_HANDLE   = 0xc0000bbcU,
    PDH_INVALID_ARGUMENT = 0xc0000bbdU,
}

enum uint PDH_FUNCTION_NOT_FOUND = 0xc0000bbeU;

enum : uint
{
    PDH_CSTATUS_NO_COUNTERNAME  = 0xc0000bbfU,
    PDH_CSTATUS_BAD_COUNTERNAME = 0xc0000bc0U,
}

enum uint PDH_INVALID_BUFFER = 0xc0000bc1U;
enum uint PDH_INSUFFICIENT_BUFFER = 0xc0000bc2U;
enum uint PDH_CANNOT_CONNECT_MACHINE = 0xc0000bc3U;

enum : uint
{
    PDH_INVALID_PATH     = 0xc0000bc4U,
    PDH_INVALID_INSTANCE = 0xc0000bc5U,
    PDH_INVALID_DATA     = 0xc0000bc6U,
}

enum uint PDH_NO_DIALOG_DATA = 0xc0000bc7U;
enum uint PDH_CANNOT_READ_NAME_STRINGS = 0xc0000bc8U;

enum : uint
{
    PDH_LOG_FILE_CREATE_ERROR = 0xc0000bc9U,
    PDH_LOG_FILE_OPEN_ERROR   = 0xc0000bcaU,
}

enum uint PDH_LOG_TYPE_NOT_FOUND = 0xc0000bcbU;
enum uint PDH_NO_MORE_DATA = 0xc0000bccU;
enum uint PDH_ENTRY_NOT_IN_LOG_FILE = 0xc0000bcdU;

enum : uint
{
    PDH_DATA_SOURCE_IS_LOG_FILE  = 0xc0000bceU,
    PDH_DATA_SOURCE_IS_REAL_TIME = 0xc0000bcfU,
}

enum uint PDH_UNABLE_READ_LOG_HEADER = 0xc0000bd0U;

enum : uint
{
    PDH_FILE_NOT_FOUND      = 0xc0000bd1U,
    PDH_FILE_ALREADY_EXISTS = 0xc0000bd2U,
}

enum uint PDH_NOT_IMPLEMENTED = 0xc0000bd3U;
enum uint PDH_STRING_NOT_FOUND = 0xc0000bd4U;

enum : uint
{
    PDH_UNKNOWN_LOG_FORMAT     = 0xc0000bd6U,
    PDH_UNKNOWN_LOGSVC_COMMAND = 0xc0000bd7U,
}

enum : uint
{
    PDH_LOGSVC_QUERY_NOT_FOUND = 0xc0000bd8U,
    PDH_LOGSVC_NOT_OPENED      = 0xc0000bd9U,
}

enum uint PDH_WBEM_ERROR = 0xc0000bdaU;
enum uint PDH_ACCESS_DENIED = 0xc0000bdbU;
enum uint PDH_LOG_FILE_TOO_SMALL = 0xc0000bdcU;

enum : uint
{
    PDH_INVALID_DATASOURCE = 0xc0000bddU,
    PDH_INVALID_SQLDB      = 0xc0000bdeU,
}

enum uint PDH_NO_COUNTERS = 0xc0000bdfU;

enum : uint
{
    PDH_SQL_ALLOC_FAILED    = 0xc0000be0U,
    PDH_SQL_ALLOCCON_FAILED = 0xc0000be1U,
}

enum uint PDH_SQL_EXEC_DIRECT_FAILED = 0xc0000be2U;
enum uint PDH_SQL_FETCH_FAILED = 0xc0000be3U;
enum uint PDH_SQL_ROWCOUNT_FAILED = 0xc0000be4U;
enum uint PDH_SQL_MORE_RESULTS_FAILED = 0xc0000be5U;
enum uint PDH_SQL_CONNECT_FAILED = 0xc0000be6U;
enum uint PDH_SQL_BIND_FAILED = 0xc0000be7U;
enum uint PDH_CANNOT_CONNECT_WMI_SERVER = 0xc0000be8U;
enum uint PDH_PLA_COLLECTION_ALREADY_RUNNING = 0xc0000be9U;
enum uint PDH_PLA_ERROR_SCHEDULE_OVERLAP = 0xc0000beaU;
enum uint PDH_PLA_COLLECTION_NOT_FOUND = 0xc0000bebU;

enum : uint
{
    PDH_PLA_ERROR_SCHEDULE_ELAPSED = 0xc0000becU,
    PDH_PLA_ERROR_NOSTART          = 0xc0000bedU,
    PDH_PLA_ERROR_ALREADY_EXISTS   = 0xc0000beeU,
    PDH_PLA_ERROR_TYPE_MISMATCH    = 0xc0000befU,
    PDH_PLA_ERROR_FILEPATH         = 0xc0000bf0U,
}

enum uint PDH_PLA_SERVICE_ERROR = 0xc0000bf1U;
enum uint PDH_PLA_VALIDATION_ERROR = 0xc0000bf2U;
enum uint PDH_PLA_ERROR_NAME_TOO_LONG = 0xc0000bf4U;
enum uint PDH_INVALID_SQL_LOG_FORMAT = 0xc0000bf5U;
enum uint PDH_COUNTER_ALREADY_IN_QUERY = 0xc0000bf6U;
enum uint PDH_BINARY_LOG_CORRUPT = 0xc0000bf7U;
enum uint PDH_LOG_SAMPLE_TOO_SMALL = 0xc0000bf8U;
enum uint PDH_OS_LATER_VERSION = 0xc0000bf9U;
enum uint PDH_OS_EARLIER_VERSION = 0xc0000bfaU;
enum uint PDH_INCORRECT_APPEND_TIME = 0xc0000bfbU;
enum uint PDH_UNMATCHED_APPEND_COUNTER = 0xc0000bfcU;
enum uint PDH_SQL_ALTER_DETAIL_FAILED = 0xc0000bfdU;
enum uint PDH_QUERY_PERF_DATA_TIMEOUT = 0xc0000bfeU;

enum : uint
{
    PLA_CAPABILITY_LOCAL          = 0x10000000U,
    PLA_CAPABILITY_V1_SVC         = 0x00000001U,
    PLA_CAPABILITY_V1_SESSION     = 0x00000002U,
    PLA_CAPABILITY_V1_SYSTEM      = 0x00000004U,
    PLA_CAPABILITY_LEGACY_SESSION = 0x00000008U,
    PLA_CAPABILITY_LEGACY_SVC     = 0x00000010U,
    PLA_CAPABILITY_AUTOLOGGER     = 0x00000020U,
}

enum : uint
{
    PLAL_ALERT_CMD_LINE_SINGLE = 0x00000100U,
    PLAL_ALERT_CMD_LINE_A_NAME = 0x00000200U,
    PLAL_ALERT_CMD_LINE_C_NAME = 0x00000400U,
    PLAL_ALERT_CMD_LINE_D_TIME = 0x00000800U,
    PLAL_ALERT_CMD_LINE_L_VAL  = 0x00001000U,
    PLAL_ALERT_CMD_LINE_M_VAL  = 0x00002000U,
    PLAL_ALERT_CMD_LINE_U_TEXT = 0x00004000U,
    PLAL_ALERT_CMD_LINE_MASK   = 0x00007f00U,
}

enum GUID S_PDH = GUID("04d66358-c4a1-419b-8023-23b73902de2c");

// Callbacks

alias PLA_CABEXTRACT_CALLBACK = void function(const(PWSTR) FileName, void* Context);
alias PERFLIBREQUEST = uint function(uint RequestCode, void* Buffer, uint BufferSize);
alias PERF_MEM_ALLOC = void* function(size_t AllocSize, void* pContext);
alias PERF_MEM_FREE = void function(void* pBuffer, void* pContext);
alias PM_OPEN_PROC = uint function(PWSTR pContext);
alias PM_COLLECT_PROC = uint function(PWSTR pValueName, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void** ppData, 
                                      uint* pcbTotalBytes, uint* pNumObjectTypes);
alias PM_CLOSE_PROC = uint function();
alias CounterPathCallBack = int function(size_t param0);

// Structs


@RAIIFree!PdhCloseLog
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct PDH_HLOG
{
    void* Value;
}

@RAIIFree!PdhCloseQuery
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct PDH_HQUERY
{
    void* Value;
}

struct PDH_HCOUNTER
{
    void* Value;
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winperf/ns-winperf-perf_object_type
    struct PERF_OBJECT_TYPE
    {
        uint TotalByteLength;
        uint DefinitionLength;
        uint HeaderLength;
        uint ObjectNameTitleIndex;
        uint ObjectNameTitle;
        uint ObjectHelpTitleIndex;
        uint ObjectHelpTitle;
        uint DetailLevel;
        uint NumCounters;
        int  DefaultCounter;
        int  NumInstances;
        uint CodePage;
        long PerfTime;
        long PerfFreq;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winperf/ns-winperf-perf_object_type
    struct PERF_OBJECT_TYPE
    {
        uint TotalByteLength;
        uint DefinitionLength;
        uint HeaderLength;
        uint ObjectNameTitleIndex;
        uint ObjectNameTitle;
        uint ObjectHelpTitleIndex;
        uint ObjectHelpTitle;
        uint DetailLevel;
        uint NumCounters;
        int  DefaultCounter;
        int  NumInstances;
        uint CodePage;
        long PerfTime;
        long PerfFreq;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winperf/ns-winperf-perf_counter_definition
    struct PERF_COUNTER_DEFINITION
    {
        uint ByteLength;
        uint CounterNameTitleIndex;
        uint CounterNameTitle;
        uint CounterHelpTitleIndex;
        uint CounterHelpTitle;
        int  DefaultScale;
        uint DetailLevel;
        uint CounterType;
        uint CounterSize;
        uint CounterOffset;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winperf/ns-winperf-perf_counter_definition
    struct PERF_COUNTER_DEFINITION
    {
        uint ByteLength;
        uint CounterNameTitleIndex;
        uint CounterNameTitle;
        uint CounterHelpTitleIndex;
        uint CounterHelpTitle;
        int  DefaultScale;
        uint DetailLevel;
        uint CounterType;
        uint CounterSize;
        uint CounterOffset;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/perflib/ns-perflib-perf_counterset_info
struct PERF_COUNTERSET_INFO
{
    GUID CounterSetGuid;
    GUID ProviderGuid;
    uint NumCounters;
    uint InstanceType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/perflib/ns-perflib-perf_counter_info
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/perflib/ns-perflib-perf_counterset_instance
struct PERF_COUNTERSET_INSTANCE
{
    GUID CounterSetGuid;
    uint dwSize;
    uint InstanceId;
    uint InstanceNameOffset;
    uint InstanceNameSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/perflib/ns-perflib-perf_counter_identity
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/perflib/ns-perflib-perf_provider_context
struct PERF_PROVIDER_CONTEXT
{
    uint           ContextSize;
    uint           Reserved;
    PERFLIBREQUEST ControlCallback;
    PERF_MEM_ALLOC MemAllocRoutine;
    PERF_MEM_FREE  MemFreeRoutine;
    void*          pMemContext;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/perflib/ns-perflib-perf_instance_header
struct PERF_INSTANCE_HEADER
{
    uint Size;
    uint InstanceId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/perflib/ns-perflib-perf_counterset_reg_info
struct PERF_COUNTERSET_REG_INFO
{
    GUID CounterSetGuid;
    uint CounterSetType;
    uint DetailLevel;
    uint NumCounters;
    uint InstanceType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/perflib/ns-perflib-perf_counter_reg_info
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
    PERF_COUNTER_AGGREGATE_FUNC AggregateFunc;
    uint  Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/perflib/ns-perflib-perf_string_buffer_header
struct PERF_STRING_BUFFER_HEADER
{
    uint dwSize;
    uint dwCounters;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/perflib/ns-perflib-perf_string_counter_header
struct PERF_STRING_COUNTER_HEADER
{
    uint dwCounterId;
    uint dwOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/perflib/ns-perflib-perf_counter_identifier
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/perflib/ns-perflib-perf_data_header
struct PERF_DATA_HEADER
{
    uint       dwTotalSize;
    uint       dwNumCounters;
    long       PerfTimeStamp;
    long       PerfTime100NSec;
    long       PerfFreq;
    SYSTEMTIME SystemTime;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/perflib/ns-perflib-perf_counter_header
struct PERF_COUNTER_HEADER
{
    uint                dwStatus;
    PerfCounterDataType dwType;
    uint                dwSize;
    uint                Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/perflib/ns-perflib-perf_multi_instances
struct PERF_MULTI_INSTANCES
{
    uint dwTotalSize;
    uint dwInstances;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/perflib/ns-perflib-perf_multi_counters
struct PERF_MULTI_COUNTERS
{
    uint dwSize;
    uint dwCounters;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/perflib/ns-perflib-perf_counter_data
struct PERF_COUNTER_DATA
{
    uint dwDataSize;
    uint dwSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winperf/ns-winperf-perf_data_block
struct PERF_DATA_BLOCK
{
    wchar[4]   Signature;
    uint       LittleEndian;
    uint       Version;
    uint       Revision;
    uint       TotalByteLength;
    uint       HeaderLength;
    uint       NumObjectTypes;
    int        DefaultObject;
    SYSTEMTIME SystemTime;
    long       PerfTime;
    long       PerfFreq;
    long       PerfTime100nSec;
    uint       SystemNameLength;
    uint       SystemNameOffset;
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winperf/ns-winperf-perf_object_type
    struct PERF_OBJECT_TYPE
    {
        uint  TotalByteLength;
        uint  DefinitionLength;
        uint  HeaderLength;
        uint  ObjectNameTitleIndex;
        PWSTR ObjectNameTitle;
        uint  ObjectHelpTitleIndex;
        PWSTR ObjectHelpTitle;
        uint  DetailLevel;
        uint  NumCounters;
        int   DefaultCounter;
        int   NumInstances;
        uint  CodePage;
        long  PerfTime;
        long  PerfFreq;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winperf/ns-winperf-perf_counter_definition
    struct PERF_COUNTER_DEFINITION
    {
        uint  ByteLength;
        uint  CounterNameTitleIndex;
        PWSTR CounterNameTitle;
        uint  CounterHelpTitleIndex;
        PWSTR CounterHelpTitle;
        int   DefaultScale;
        uint  DetailLevel;
        uint  CounterType;
        uint  CounterSize;
        uint  CounterOffset;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winperf/ns-winperf-perf_instance_definition
struct PERF_INSTANCE_DEFINITION
{
    uint ByteLength;
    uint ParentObjectTitleIndex;
    uint ParentObjectInstance;
    int  UniqueID;
    uint NameOffset;
    uint NameLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winperf/ns-winperf-perf_counter_block
struct PERF_COUNTER_BLOCK
{
    uint ByteLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pdh/ns-pdh-pdh_raw_counter
struct PDH_RAW_COUNTER
{
    uint     CStatus;
    FILETIME TimeStamp;
    long     FirstValue;
    long     SecondValue;
    uint     MultiCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pdh/ns-pdh-pdh_raw_counter_item_a
struct PDH_RAW_COUNTER_ITEM_A
{
    PSTR            szName;
    PDH_RAW_COUNTER RawValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pdh/ns-pdh-pdh_raw_counter_item_w
struct PDH_RAW_COUNTER_ITEM_W
{
    PWSTR           szName;
    PDH_RAW_COUNTER RawValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pdh/ns-pdh-pdh_fmt_countervalue
struct PDH_FMT_COUNTERVALUE
{
    uint CStatus;
    union
    {
        int          longValue;
        double       doubleValue;
        long         largeValue;
        const(PSTR)  AnsiStringValue;
        const(PWSTR) WideStringValue;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pdh/ns-pdh-pdh_fmt_countervalue_item_a
struct PDH_FMT_COUNTERVALUE_ITEM_A
{
    PSTR                 szName;
    PDH_FMT_COUNTERVALUE FmtValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pdh/ns-pdh-pdh_fmt_countervalue_item_w
struct PDH_FMT_COUNTERVALUE_ITEM_W
{
    PWSTR                szName;
    PDH_FMT_COUNTERVALUE FmtValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pdh/ns-pdh-pdh_statistics
struct PDH_STATISTICS
{
    uint                 dwFormat;
    uint                 count;
    PDH_FMT_COUNTERVALUE min;
    PDH_FMT_COUNTERVALUE max;
    PDH_FMT_COUNTERVALUE mean;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pdh/ns-pdh-pdh_counter_path_elements_a
struct PDH_COUNTER_PATH_ELEMENTS_A
{
    PSTR szMachineName;
    PSTR szObjectName;
    PSTR szInstanceName;
    PSTR szParentInstance;
    uint dwInstanceIndex;
    PSTR szCounterName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pdh/ns-pdh-pdh_counter_path_elements_w
struct PDH_COUNTER_PATH_ELEMENTS_W
{
    PWSTR szMachineName;
    PWSTR szObjectName;
    PWSTR szInstanceName;
    PWSTR szParentInstance;
    uint  dwInstanceIndex;
    PWSTR szCounterName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pdh/ns-pdh-pdh_data_item_path_elements_a
struct PDH_DATA_ITEM_PATH_ELEMENTS_A
{
    PSTR szMachineName;
    GUID ObjectGUID;
    uint dwItemId;
    PSTR szInstanceName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pdh/ns-pdh-pdh_data_item_path_elements_w
struct PDH_DATA_ITEM_PATH_ELEMENTS_W
{
    PWSTR szMachineName;
    GUID  ObjectGUID;
    uint  dwItemId;
    PWSTR szInstanceName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pdh/ns-pdh-pdh_counter_info_a
struct PDH_COUNTER_INFO_A
{
    uint    dwLength;
    uint    dwType;
    uint    CVersion;
    uint    CStatus;
    int     lScale;
    int     lDefaultScale;
    size_t  dwUserData;
    size_t  dwQueryUserData;
    PSTR    szFullPath;
    union
    {
        PDH_DATA_ITEM_PATH_ELEMENTS_A DataItemPath;
        PDH_COUNTER_PATH_ELEMENTS_A CounterPath;
        struct
        {
            PSTR szMachineName;
            PSTR szObjectName;
            PSTR szInstanceName;
            PSTR szParentInstance;
            uint dwInstanceIndex;
            PSTR szCounterName;
        }
    }
    PSTR    szExplainText;
    uint[1] DataBuffer; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pdh/ns-pdh-pdh_counter_info_w
struct PDH_COUNTER_INFO_W
{
    uint    dwLength;
    uint    dwType;
    uint    CVersion;
    uint    CStatus;
    int     lScale;
    int     lDefaultScale;
    size_t  dwUserData;
    size_t  dwQueryUserData;
    PWSTR   szFullPath;
    union
    {
        PDH_DATA_ITEM_PATH_ELEMENTS_W DataItemPath;
        PDH_COUNTER_PATH_ELEMENTS_W CounterPath;
        struct
        {
            PWSTR szMachineName;
            PWSTR szObjectName;
            PWSTR szInstanceName;
            PWSTR szParentInstance;
            uint  dwInstanceIndex;
            PWSTR szCounterName;
        }
    }
    PWSTR   szExplainText;
    uint[1] DataBuffer; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pdh/ns-pdh-pdh_time_info
struct PDH_TIME_INFO
{
    long StartTime;
    long EndTime;
    uint SampleCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pdh/ns-pdh-pdh_raw_log_record
struct PDH_RAW_LOG_RECORD
{
    uint         dwStructureSize;
    PDH_LOG_TYPE dwRecordType;
    uint         dwItems;
    ubyte[1]     RawBytes; // Flexible array
}

struct PDH_LOG_SERVICE_QUERY_INFO_A
{
    uint dwSize;
    uint dwFlags;
    uint dwLogQuota;
    PSTR szLogFileCaption;
    PSTR szDefaultDir;
    PSTR szBaseFileName;
    uint dwFileType;
    uint dwReserved;
    union
    {
        struct
        {
            uint     PdlAutoNameInterval;
            uint     PdlAutoNameUnits;
            PSTR     PdlCommandFilename;
            PSTR     PdlCounterList;
            uint     PdlAutoNameFormat;
            uint     PdlSampleInterval;
            FILETIME PdlLogStartTime;
            FILETIME PdlLogEndTime;
        }
        struct
        {
            uint TlNumberOfBuffers;
            uint TlMinimumBuffers;
            uint TlMaximumBuffers;
            uint TlFreeBuffers;
            uint TlBufferSize;
            uint TlEventsLost;
            uint TlLoggerThreadId;
            uint TlBuffersWritten;
            uint TlLogHandle;
            PSTR TlLogFileName;
        }
    }
}

struct PDH_LOG_SERVICE_QUERY_INFO_W
{
    uint  dwSize;
    uint  dwFlags;
    uint  dwLogQuota;
    PWSTR szLogFileCaption;
    PWSTR szDefaultDir;
    PWSTR szBaseFileName;
    uint  dwFileType;
    uint  dwReserved;
    union
    {
        struct
        {
            uint     PdlAutoNameInterval;
            uint     PdlAutoNameUnits;
            PWSTR    PdlCommandFilename;
            PWSTR    PdlCounterList;
            uint     PdlAutoNameFormat;
            uint     PdlSampleInterval;
            FILETIME PdlLogStartTime;
            FILETIME PdlLogEndTime;
        }
        struct
        {
            uint  TlNumberOfBuffers;
            uint  TlMinimumBuffers;
            uint  TlMaximumBuffers;
            uint  TlFreeBuffers;
            uint  TlBufferSize;
            uint  TlEventsLost;
            uint  TlLoggerThreadId;
            uint  TlBuffersWritten;
            uint  TlLogHandle;
            PWSTR TlLogFileName;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pdh/ns-pdh-pdh_browse_dlg_config_hw
struct PDH_BROWSE_DLG_CONFIG_HW
{
    // Native bit field: bIncludeInstanceIndex: [0], bSingleCounterPerAdd: [1], bSingleCounterPerDialog: [2], bLocalCountersOnly: [3], bWildCardInstances: [4], bHideDetailBox: [5], bInitializePath: [6], bDisableMachineSelection: [7], bIncludeCostlyObjects: [8], bShowObjectBrowser: [9], bReserved: [10-31]
    uint                _bitfield0;
    HWND                hWndOwner;
    PDH_HLOG            hDataSource;
    PWSTR               szReturnPathBuffer;
    uint                cchReturnPathLength;
    CounterPathCallBack pCallBack;
    size_t              dwCallBackArg;
    int                 CallBackStatus;
    PERF_DETAIL         dwDefaultDetailLevel;
    PWSTR               szDialogBoxCaption;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pdh/ns-pdh-pdh_browse_dlg_config_ha
struct PDH_BROWSE_DLG_CONFIG_HA
{
    // Native bit field: bIncludeInstanceIndex: [0], bSingleCounterPerAdd: [1], bSingleCounterPerDialog: [2], bLocalCountersOnly: [3], bWildCardInstances: [4], bHideDetailBox: [5], bInitializePath: [6], bDisableMachineSelection: [7], bIncludeCostlyObjects: [8], bShowObjectBrowser: [9], bReserved: [10-31]
    uint                _bitfield0;
    HWND                hWndOwner;
    PDH_HLOG            hDataSource;
    PSTR                szReturnPathBuffer;
    uint                cchReturnPathLength;
    CounterPathCallBack pCallBack;
    size_t              dwCallBackArg;
    int                 CallBackStatus;
    PERF_DETAIL         dwDefaultDetailLevel;
    PSTR                szDialogBoxCaption;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pdh/ns-pdh-pdh_browse_dlg_config_w
struct PDH_BROWSE_DLG_CONFIG_W
{
    // Native bit field: bIncludeInstanceIndex: [0], bSingleCounterPerAdd: [1], bSingleCounterPerDialog: [2], bLocalCountersOnly: [3], bWildCardInstances: [4], bHideDetailBox: [5], bInitializePath: [6], bDisableMachineSelection: [7], bIncludeCostlyObjects: [8], bShowObjectBrowser: [9], bReserved: [10-31]
    uint                _bitfield0;
    HWND                hWndOwner;
    PWSTR               szDataSource;
    PWSTR               szReturnPathBuffer;
    uint                cchReturnPathLength;
    CounterPathCallBack pCallBack;
    size_t              dwCallBackArg;
    int                 CallBackStatus;
    PERF_DETAIL         dwDefaultDetailLevel;
    PWSTR               szDialogBoxCaption;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pdh/ns-pdh-pdh_browse_dlg_config_a
struct PDH_BROWSE_DLG_CONFIG_A
{
    // Native bit field: bIncludeInstanceIndex: [0], bSingleCounterPerAdd: [1], bSingleCounterPerDialog: [2], bLocalCountersOnly: [3], bWildCardInstances: [4], bHideDetailBox: [5], bInitializePath: [6], bDisableMachineSelection: [7], bIncludeCostlyObjects: [8], bShowObjectBrowser: [9], bReserved: [10-31]
    uint                _bitfield0;
    HWND                hWndOwner;
    PSTR                szDataSource;
    PSTR                szReturnPathBuffer;
    uint                cchReturnPathLength;
    CounterPathCallBack pCallBack;
    size_t              dwCallBackArg;
    int                 CallBackStatus;
    PERF_DETAIL         dwDefaultDetailLevel;
    PSTR                szDialogBoxCaption;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL QueryPerformanceCounter(long* lpPerformanceCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL QueryPerformanceFrequency(long* lpFrequency);

@DllImport("loadperf.dll")
uint InstallPerfDllW(const(PWSTR) szComputerName, const(PWSTR) lpIniFile, size_t dwFlags);

@DllImport("loadperf.dll")
uint InstallPerfDllA(const(PSTR) szComputerName, const(PSTR) lpIniFile, size_t dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("loadperf.dll")
uint LoadPerfCounterTextStringsA(PSTR lpCommandLine, BOOL bQuietModeArg);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("loadperf.dll")
uint LoadPerfCounterTextStringsW(PWSTR lpCommandLine, BOOL bQuietModeArg);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("loadperf.dll")
uint UnloadPerfCounterTextStringsW(PWSTR lpCommandLine, BOOL bQuietModeArg);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("loadperf.dll")
uint UnloadPerfCounterTextStringsA(PSTR lpCommandLine, BOOL bQuietModeArg);

@DllImport("loadperf.dll")
uint UpdatePerfNameFilesA(const(PSTR) szNewCtrFilePath, const(PSTR) szNewHlpFilePath, PSTR szLanguageID, 
                          size_t dwModes);

@DllImport("loadperf.dll")
uint UpdatePerfNameFilesW(const(PWSTR) szNewCtrFilePath, const(PWSTR) szNewHlpFilePath, PWSTR szLanguageID, 
                          size_t dwModes);

@DllImport("loadperf.dll")
uint SetServiceAsTrustedA(const(PSTR) szReserved, const(PSTR) szServiceName);

@DllImport("loadperf.dll")
uint SetServiceAsTrustedW(const(PWSTR) szReserved, const(PWSTR) szServiceName);

@DllImport("loadperf.dll")
uint BackupPerfRegistryToFileW(const(PWSTR) szFileName, const(PWSTR) szCommentString);

@DllImport("loadperf.dll")
uint RestorePerfRegistryFromFileW(const(PWSTR) szFileName, const(PWSTR) szLangId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
uint PerfStartProvider(GUID* ProviderGuid, PERFLIBREQUEST ControlCallback, 
                       /*PARAM ATTR: RAIIFreeAttribute : CustomAttributeSig([FixedArgSig(ElementSig(PerfStopProvider))], [])*/HANDLE* phProvider);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
uint PerfStartProviderEx(GUID* ProviderGuid, PERF_PROVIDER_CONTEXT* ProviderContext, 
                         /*PARAM ATTR: RAIIFreeAttribute : CustomAttributeSig([FixedArgSig(ElementSig(PerfStopProvider))], [])*/HANDLE* Provider);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
uint PerfStopProvider(HANDLE ProviderHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
uint PerfSetCounterSetInfo(HANDLE ProviderHandle, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PERF_COUNTERSET_INFO* Template, 
                           uint TemplateSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
PERF_COUNTERSET_INSTANCE* PerfCreateInstance(HANDLE ProviderHandle, const(GUID)* CounterSetGuid, const(PWSTR) Name, 
                                             uint Id);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
uint PerfDeleteInstance(HANDLE Provider, PERF_COUNTERSET_INSTANCE* InstanceBlock);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
PERF_COUNTERSET_INSTANCE* PerfQueryInstance(HANDLE ProviderHandle, const(GUID)* CounterSetGuid, const(PWSTR) Name, 
                                            uint Id);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
uint PerfSetCounterRefValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, void* Address);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
uint PerfSetULongCounterValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, uint Value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
uint PerfSetULongLongCounterValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, ulong Value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
uint PerfIncrementULongCounterValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, 
                                    uint Value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
uint PerfIncrementULongLongCounterValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, 
                                        ulong Value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
uint PerfDecrementULongCounterValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, 
                                    uint Value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
uint PerfDecrementULongLongCounterValue(HANDLE Provider, PERF_COUNTERSET_INSTANCE* Instance, uint CounterId, 
                                        ulong Value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
@DllImport("ADVAPI32.dll")
uint PerfEnumerateCounterSet(const(PWSTR) szMachine, GUID* pCounterSetIds, uint cCounterSetIds, 
                             uint* pcCounterSetIdsActual);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
@DllImport("ADVAPI32.dll")
uint PerfEnumerateCounterSetInstances(const(PWSTR) szMachine, const(GUID)* pCounterSetId, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PERF_INSTANCE_HEADER* pInstances, 
                                      uint cbInstances, uint* pcbInstancesActual);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
@DllImport("ADVAPI32.dll")
uint PerfQueryCounterSetRegistrationInfo(const(PWSTR) szMachine, const(GUID)* pCounterSetId, 
                                         PerfRegInfoType requestCode, uint requestLangId, 
                                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* pbRegInfo, 
                                         uint cbRegInfo, uint* pcbRegInfoActual);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
@DllImport("ADVAPI32.dll")
uint PerfOpenQueryHandle(const(PWSTR) szMachine, 
                         /*PARAM ATTR: RAIIFreeAttribute : CustomAttributeSig([FixedArgSig(ElementSig(PerfCloseQueryHandle))], [])*/HANDLE* phQuery);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
@DllImport("ADVAPI32.dll")
uint PerfCloseQueryHandle(HANDLE hQuery);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
@DllImport("ADVAPI32.dll")
uint PerfQueryCounterInfo(HANDLE hQuery, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PERF_COUNTER_IDENTIFIER* pCounters, 
                          uint cbCounters, uint* pcbCountersActual);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
@DllImport("ADVAPI32.dll")
uint PerfQueryCounterData(HANDLE hQuery, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PERF_DATA_HEADER* pCounterBlock, 
                          uint cbCounterBlock, uint* pcbCounterBlockActual);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
@DllImport("ADVAPI32.dll")
uint PerfAddCounters(HANDLE hQuery, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PERF_COUNTER_IDENTIFIER* pCounters, 
                     uint cbCounters);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.14393))], [])
@DllImport("ADVAPI32.dll")
uint PerfDeleteCounters(HANDLE hQuery, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PERF_COUNTER_IDENTIFIER* pCounters, 
                        uint cbCounters);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhGetDllVersion(PDH_DLL_VERSION* lpdwVersion);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhOpenQueryW(const(PWSTR) szDataSource, size_t dwUserData, PDH_HQUERY* phQuery);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhOpenQueryA(const(PSTR) szDataSource, size_t dwUserData, PDH_HQUERY* phQuery);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhAddCounterW(PDH_HQUERY hQuery, const(PWSTR) szFullCounterPath, size_t dwUserData, PDH_HCOUNTER* phCounter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhAddCounterA(PDH_HQUERY hQuery, const(PSTR) szFullCounterPath, size_t dwUserData, PDH_HCOUNTER* phCounter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("pdh.dll")
uint PdhAddEnglishCounterW(PDH_HQUERY hQuery, const(PWSTR) szFullCounterPath, size_t dwUserData, 
                           PDH_HCOUNTER* phCounter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("pdh.dll")
uint PdhAddEnglishCounterA(PDH_HQUERY hQuery, const(PSTR) szFullCounterPath, size_t dwUserData, 
                           PDH_HCOUNTER* phCounter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("pdh.dll")
uint PdhCollectQueryDataWithTime(PDH_HQUERY hQuery, long* pllTimeStamp);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("pdh.dll")
uint PdhValidatePathExW(PDH_HLOG hDataSource, const(PWSTR) szFullPathBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("pdh.dll")
uint PdhValidatePathExA(PDH_HLOG hDataSource, const(PSTR) szFullPathBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhRemoveCounter(PDH_HCOUNTER hCounter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhCollectQueryData(PDH_HQUERY hQuery);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhCloseQuery(PDH_HQUERY hQuery);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhGetFormattedCounterValue(PDH_HCOUNTER hCounter, PDH_FMT dwFormat, uint* lpdwType, 
                                 PDH_FMT_COUNTERVALUE* pValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhGetFormattedCounterArrayA(PDH_HCOUNTER hCounter, PDH_FMT dwFormat, uint* lpdwBufferSize, 
                                  uint* lpdwItemCount, PDH_FMT_COUNTERVALUE_ITEM_A* ItemBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhGetFormattedCounterArrayW(PDH_HCOUNTER hCounter, PDH_FMT dwFormat, uint* lpdwBufferSize, 
                                  uint* lpdwItemCount, PDH_FMT_COUNTERVALUE_ITEM_W* ItemBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhGetRawCounterValue(PDH_HCOUNTER hCounter, uint* lpdwType, PDH_RAW_COUNTER* pValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhGetRawCounterArrayA(PDH_HCOUNTER hCounter, uint* lpdwBufferSize, uint* lpdwItemCount, 
                            PDH_RAW_COUNTER_ITEM_A* ItemBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhGetRawCounterArrayW(PDH_HCOUNTER hCounter, uint* lpdwBufferSize, uint* lpdwItemCount, 
                            PDH_RAW_COUNTER_ITEM_W* ItemBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhCalculateCounterFromRawValue(PDH_HCOUNTER hCounter, PDH_FMT dwFormat, PDH_RAW_COUNTER* rawValue1, 
                                     PDH_RAW_COUNTER* rawValue2, PDH_FMT_COUNTERVALUE* fmtValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhComputeCounterStatistics(PDH_HCOUNTER hCounter, PDH_FMT dwFormat, uint dwFirstEntry, uint dwNumEntries, 
                                 PDH_RAW_COUNTER* lpRawValueArray, PDH_STATISTICS* data);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhGetCounterInfoW(PDH_HCOUNTER hCounter, BOOLEAN bRetrieveExplainText, uint* pdwBufferSize, 
                        PDH_COUNTER_INFO_W* lpBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhGetCounterInfoA(PDH_HCOUNTER hCounter, BOOLEAN bRetrieveExplainText, uint* pdwBufferSize, 
                        PDH_COUNTER_INFO_A* lpBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhSetCounterScaleFactor(PDH_HCOUNTER hCounter, int lFactor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhConnectMachineW(const(PWSTR) szMachineName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhConnectMachineA(const(PSTR) szMachineName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhEnumMachinesW(const(PWSTR) szDataSource, 
                      /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR mszMachineList, 
                      uint* pcchBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhEnumMachinesA(const(PSTR) szDataSource, 
                      /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR mszMachineList, 
                      uint* pcchBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhEnumObjectsW(const(PWSTR) szDataSource, const(PWSTR) szMachineName, 
                     /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR mszObjectList, 
                     uint* pcchBufferSize, PERF_DETAIL dwDetailLevel, BOOL bRefresh);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhEnumObjectsA(const(PSTR) szDataSource, const(PSTR) szMachineName, 
                     /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR mszObjectList, 
                     uint* pcchBufferSize, PERF_DETAIL dwDetailLevel, BOOL bRefresh);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhEnumObjectItemsW(const(PWSTR) szDataSource, const(PWSTR) szMachineName, const(PWSTR) szObjectName, 
                         /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR mszCounterList, 
                         uint* pcchCounterListLength, 
                         /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR mszInstanceList, 
                         uint* pcchInstanceListLength, PERF_DETAIL dwDetailLevel, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhEnumObjectItemsA(const(PSTR) szDataSource, const(PSTR) szMachineName, const(PSTR) szObjectName, 
                         /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR mszCounterList, 
                         uint* pcchCounterListLength, 
                         /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR mszInstanceList, 
                         uint* pcchInstanceListLength, PERF_DETAIL dwDetailLevel, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhMakeCounterPathW(PDH_COUNTER_PATH_ELEMENTS_W* pCounterPathElements, PWSTR szFullPathBuffer, 
                         uint* pcchBufferSize, PDH_PATH_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhMakeCounterPathA(PDH_COUNTER_PATH_ELEMENTS_A* pCounterPathElements, PSTR szFullPathBuffer, 
                         uint* pcchBufferSize, PDH_PATH_FLAGS dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhParseCounterPathW(const(PWSTR) szFullPathBuffer, PDH_COUNTER_PATH_ELEMENTS_W* pCounterPathElements, 
                          uint* pdwBufferSize, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhParseCounterPathA(const(PSTR) szFullPathBuffer, PDH_COUNTER_PATH_ELEMENTS_A* pCounterPathElements, 
                          uint* pdwBufferSize, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhParseInstanceNameW(const(PWSTR) szInstanceString, PWSTR szInstanceName, uint* pcchInstanceNameLength, 
                           PWSTR szParentName, uint* pcchParentNameLength, uint* lpIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhParseInstanceNameA(const(PSTR) szInstanceString, PSTR szInstanceName, uint* pcchInstanceNameLength, 
                           PSTR szParentName, uint* pcchParentNameLength, uint* lpIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhValidatePathW(const(PWSTR) szFullPathBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhValidatePathA(const(PSTR) szFullPathBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhGetDefaultPerfObjectW(const(PWSTR) szDataSource, const(PWSTR) szMachineName, PWSTR szDefaultObjectName, 
                              uint* pcchBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhGetDefaultPerfObjectA(const(PSTR) szDataSource, const(PSTR) szMachineName, PSTR szDefaultObjectName, 
                              uint* pcchBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhGetDefaultPerfCounterW(const(PWSTR) szDataSource, const(PWSTR) szMachineName, const(PWSTR) szObjectName, 
                               PWSTR szDefaultCounterName, uint* pcchBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhGetDefaultPerfCounterA(const(PSTR) szDataSource, const(PSTR) szMachineName, const(PSTR) szObjectName, 
                               PSTR szDefaultCounterName, uint* pcchBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhBrowseCountersW(PDH_BROWSE_DLG_CONFIG_W* pBrowseDlgData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhBrowseCountersA(PDH_BROWSE_DLG_CONFIG_A* pBrowseDlgData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhExpandCounterPathW(const(PWSTR) szWildCardPath, 
                           /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR mszExpandedPathList, 
                           uint* pcchPathListLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhExpandCounterPathA(const(PSTR) szWildCardPath, 
                           /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR mszExpandedPathList, 
                           uint* pcchPathListLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhLookupPerfNameByIndexW(const(PWSTR) szMachineName, uint dwNameIndex, PWSTR szNameBuffer, 
                               uint* pcchNameBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhLookupPerfNameByIndexA(const(PSTR) szMachineName, uint dwNameIndex, PSTR szNameBuffer, 
                               uint* pcchNameBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhLookupPerfIndexByNameW(const(PWSTR) szMachineName, const(PWSTR) szNameBuffer, uint* pdwIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhLookupPerfIndexByNameA(const(PSTR) szMachineName, const(PSTR) szNameBuffer, uint* pdwIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhExpandWildCardPathA(const(PSTR) szDataSource, const(PSTR) szWildCardPath, 
                            /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR mszExpandedPathList, 
                            uint* pcchPathListLength, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhExpandWildCardPathW(const(PWSTR) szDataSource, const(PWSTR) szWildCardPath, 
                            /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR mszExpandedPathList, 
                            uint* pcchPathListLength, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhOpenLogW(const(PWSTR) szLogFileName, PDH_LOG dwAccessFlags, PDH_LOG_TYPE* lpdwLogType, PDH_HQUERY hQuery, 
                 uint dwMaxSize, const(PWSTR) szUserCaption, PDH_HLOG* phLog);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhOpenLogA(const(PSTR) szLogFileName, PDH_LOG dwAccessFlags, PDH_LOG_TYPE* lpdwLogType, PDH_HQUERY hQuery, 
                 uint dwMaxSize, const(PSTR) szUserCaption, PDH_HLOG* phLog);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhUpdateLogW(PDH_HLOG hLog, const(PWSTR) szUserString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhUpdateLogA(PDH_HLOG hLog, const(PSTR) szUserString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhUpdateLogFileCatalog(PDH_HLOG hLog);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhGetLogFileSize(PDH_HLOG hLog, long* llSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhCloseLog(PDH_HLOG hLog, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhSelectDataSourceW(HWND hWndOwner, PDH_SELECT_DATA_SOURCE_FLAGS dwFlags, PWSTR szDataSource, 
                          uint* pcchBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhSelectDataSourceA(HWND hWndOwner, PDH_SELECT_DATA_SOURCE_FLAGS dwFlags, PSTR szDataSource, 
                          uint* pcchBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
BOOL PdhIsRealTimeQuery(PDH_HQUERY hQuery);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhSetQueryTimeRange(PDH_HQUERY hQuery, PDH_TIME_INFO* pInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhGetDataSourceTimeRangeW(const(PWSTR) szDataSource, uint* pdwNumEntries, PDH_TIME_INFO* pInfo, 
                                uint* pdwBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhGetDataSourceTimeRangeA(const(PSTR) szDataSource, uint* pdwNumEntries, PDH_TIME_INFO* pInfo, 
                                uint* pdwBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhCollectQueryDataEx(PDH_HQUERY hQuery, uint dwIntervalTime, HANDLE hNewDataEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhFormatFromRawValue(uint dwCounterType, PDH_FMT dwFormat, long* pTimeBase, PDH_RAW_COUNTER* pRawValue1, 
                           PDH_RAW_COUNTER* pRawValue2, PDH_FMT_COUNTERVALUE* pFmtValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhGetCounterTimeBase(PDH_HCOUNTER hCounter, long* pTimeBase);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhReadRawLogRecord(PDH_HLOG hLog, FILETIME ftRecord, PDH_RAW_LOG_RECORD* pRawLogRecord, 
                         uint* pdwBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhSetDefaultRealTimeDataSource(REAL_TIME_DATA_SOURCE_ID_FLAGS dwDataSourceId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhBindInputDataSourceW(PDH_HLOG* phDataSource, const(PWSTR) LogFileNameList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhBindInputDataSourceA(PDH_HLOG* phDataSource, const(PSTR) LogFileNameList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhOpenQueryH(PDH_HLOG hDataSource, size_t dwUserData, PDH_HQUERY* phQuery);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhEnumMachinesHW(PDH_HLOG hDataSource, 
                       /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR mszMachineList, 
                       uint* pcchBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhEnumMachinesHA(PDH_HLOG hDataSource, 
                       /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR mszMachineList, 
                       uint* pcchBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhEnumObjectsHW(PDH_HLOG hDataSource, const(PWSTR) szMachineName, 
                      /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR mszObjectList, 
                      uint* pcchBufferSize, PERF_DETAIL dwDetailLevel, BOOL bRefresh);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhEnumObjectsHA(PDH_HLOG hDataSource, const(PSTR) szMachineName, 
                      /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR mszObjectList, 
                      uint* pcchBufferSize, PERF_DETAIL dwDetailLevel, BOOL bRefresh);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhEnumObjectItemsHW(PDH_HLOG hDataSource, const(PWSTR) szMachineName, const(PWSTR) szObjectName, 
                          /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR mszCounterList, 
                          uint* pcchCounterListLength, 
                          /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR mszInstanceList, 
                          uint* pcchInstanceListLength, PERF_DETAIL dwDetailLevel, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhEnumObjectItemsHA(PDH_HLOG hDataSource, const(PSTR) szMachineName, const(PSTR) szObjectName, 
                          /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR mszCounterList, 
                          uint* pcchCounterListLength, 
                          /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR mszInstanceList, 
                          uint* pcchInstanceListLength, PERF_DETAIL dwDetailLevel, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhExpandWildCardPathHW(PDH_HLOG hDataSource, const(PWSTR) szWildCardPath, 
                             /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR mszExpandedPathList, 
                             uint* pcchPathListLength, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhExpandWildCardPathHA(PDH_HLOG hDataSource, const(PSTR) szWildCardPath, 
                             /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR mszExpandedPathList, 
                             uint* pcchPathListLength, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhGetDataSourceTimeRangeH(PDH_HLOG hDataSource, uint* pdwNumEntries, PDH_TIME_INFO* pInfo, 
                                uint* pdwBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhGetDefaultPerfObjectHW(PDH_HLOG hDataSource, const(PWSTR) szMachineName, PWSTR szDefaultObjectName, 
                               uint* pcchBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhGetDefaultPerfObjectHA(PDH_HLOG hDataSource, const(PSTR) szMachineName, PSTR szDefaultObjectName, 
                               uint* pcchBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhGetDefaultPerfCounterHW(PDH_HLOG hDataSource, const(PWSTR) szMachineName, const(PWSTR) szObjectName, 
                                PWSTR szDefaultCounterName, uint* pcchBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhGetDefaultPerfCounterHA(PDH_HLOG hDataSource, const(PSTR) szMachineName, const(PSTR) szObjectName, 
                                PSTR szDefaultCounterName, uint* pcchBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhBrowseCountersHW(PDH_BROWSE_DLG_CONFIG_HW* pBrowseDlgData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhBrowseCountersHA(PDH_BROWSE_DLG_CONFIG_HA* pBrowseDlgData);

@DllImport("pdh.dll")
uint PdhVerifySQLDBW(const(PWSTR) szDataSource);

@DllImport("pdh.dll")
uint PdhVerifySQLDBA(const(PSTR) szDataSource);

@DllImport("pdh.dll")
uint PdhCreateSQLTablesW(const(PWSTR) szDataSource);

@DllImport("pdh.dll")
uint PdhCreateSQLTablesA(const(PSTR) szDataSource);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhEnumLogSetNamesW(const(PWSTR) szDataSource, 
                         /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR mszDataSetNameList, 
                         uint* pcchBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("pdh.dll")
uint PdhEnumLogSetNamesA(const(PSTR) szDataSource, 
                         /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR mszDataSetNameList, 
                         uint* pcchBufferLength);

@DllImport("pdh.dll")
uint PdhGetLogSetGUID(PDH_HLOG hLog, GUID* pGuid, int* pRunId);

@DllImport("pdh.dll")
uint PdhSetLogSetRunID(PDH_HLOG hLog, int RunId);


// Interfaces

@GUID("03837521-098b-11d8-9414-505054503030")
struct DataCollectorSet;

@GUID("0383751c-098b-11d8-9414-505054503030")
struct TraceSession;

@GUID("03837530-098b-11d8-9414-505054503030")
struct TraceSessionCollection;

@GUID("03837513-098b-11d8-9414-505054503030")
struct TraceDataProvider;

@GUID("03837511-098b-11d8-9414-505054503030")
struct TraceDataProviderCollection;

@GUID("03837525-098b-11d8-9414-505054503030")
struct DataCollectorSetCollection;

@GUID("03837526-098b-11d8-9414-505054503030")
struct LegacyDataCollectorSet;

@GUID("03837527-098b-11d8-9414-505054503030")
struct LegacyDataCollectorSetCollection;

@GUID("03837528-098b-11d8-9414-505054503030")
struct LegacyTraceSession;

@GUID("03837529-098b-11d8-9414-505054503030")
struct LegacyTraceSessionCollection;

@GUID("03837531-098b-11d8-9414-505054503030")
struct ServerDataCollectorSet;

@GUID("03837532-098b-11d8-9414-505054503030")
struct ServerDataCollectorSetCollection;

@GUID("03837546-098b-11d8-9414-505054503030")
struct SystemDataCollectorSet;

@GUID("03837547-098b-11d8-9414-505054503030")
struct SystemDataCollectorSetCollection;

@GUID("03837538-098b-11d8-9414-505054503030")
struct BootTraceSession;

@GUID("03837539-098b-11d8-9414-505054503030")
struct BootTraceSessionCollection;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SysMon/systemmonitor
@GUID("c4d2d8e0-d1dd-11ce-940f-008029004347")
struct SystemMonitor;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SysMon/counteritem
@GUID("c4d2d8e0-d1dd-11ce-940f-008029004348")
struct CounterItem;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SysMon/counters
@GUID("b2b066d2-2aac-11cf-942f-008029004347")
struct Counters;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SysMon/logfileitem
@GUID("16ec5be8-df93-4237-94e4-9ee918111d71")
struct LogFileItem;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SysMon/logfiles
@GUID("2735d9fd-f6b9-4f19-a5d9-e2d068584bc5")
struct LogFiles;

@GUID("43196c62-c31f-4ce3-a02e-79efe0f6a525")
struct CounterItem2;

@GUID("7f30578c-5f38-4612-acfe-6ed04c7b7af8")
struct SystemMonitor2;

@GUID("e49741e9-93a8-4ab1-8e96-bf4482282e9c")
struct AppearPropPage;

@GUID("c3e5d3d2-1a03-11cf-942d-008029004347")
struct GeneralPropPage;

@GUID("c3e5d3d3-1a03-11cf-942d-008029004347")
struct GraphPropPage;

@GUID("0cf32aa1-7571-11d0-93c4-00aa00a3ddea")
struct SourcePropPage;

@GUID("cf948561-ede8-11ce-941e-008029004347")
struct CounterPropPage;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nn-pla-idatacollectorset
@GUID("03837520-098b-11d8-9414-505054503030")
interface IDataCollectorSet : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_datacollectors
    HRESULT get_DataCollectors(IDataCollectorCollection* collectors);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_duration
    HRESULT get_Duration(uint* seconds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-put_duration
    HRESULT put_Duration(uint seconds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_description
    HRESULT get_Description(BSTR* description);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-put_description
    HRESULT put_Description(BSTR description);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_descriptionunresolved
    HRESULT get_DescriptionUnresolved(BSTR* Descr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_displayname
    HRESULT get_DisplayName(BSTR* DisplayName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-put_displayname
    HRESULT put_DisplayName(BSTR DisplayName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_displaynameunresolved
    HRESULT get_DisplayNameUnresolved(BSTR* name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_keywords
    HRESULT get_Keywords(SAFEARRAY** keywords);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-put_keywords
    HRESULT put_Keywords(SAFEARRAY* keywords);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_latestoutputlocation
    HRESULT get_LatestOutputLocation(BSTR* path);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-put_latestoutputlocation
    HRESULT put_LatestOutputLocation(BSTR path);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_name
    HRESULT get_Name(BSTR* name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_outputlocation
    HRESULT get_OutputLocation(BSTR* path);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_rootpath
    HRESULT get_RootPath(BSTR* folder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-put_rootpath
    HRESULT put_RootPath(BSTR folder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_segment
    HRESULT get_Segment(VARIANT_BOOL* segment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-put_segment
    HRESULT put_Segment(VARIANT_BOOL segment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_segmentmaxduration
    HRESULT get_SegmentMaxDuration(uint* seconds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-put_segmentmaxduration
    HRESULT put_SegmentMaxDuration(uint seconds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_segmentmaxsize
    HRESULT get_SegmentMaxSize(uint* size);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-put_segmentmaxsize
    HRESULT put_SegmentMaxSize(uint size);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_serialnumber
    HRESULT get_SerialNumber(uint* index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-put_serialnumber
    HRESULT put_SerialNumber(uint index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_server
    HRESULT get_Server(BSTR* server);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_status
    HRESULT get_Status(DataCollectorSetStatus* status);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_subdirectory
    HRESULT get_Subdirectory(BSTR* folder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-put_subdirectory
    HRESULT put_Subdirectory(BSTR folder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_subdirectoryformat
    HRESULT get_SubdirectoryFormat(AutoPathFormat* format);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-put_subdirectoryformat
    HRESULT put_SubdirectoryFormat(AutoPathFormat format);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_subdirectoryformatpattern
    HRESULT get_SubdirectoryFormatPattern(BSTR* pattern);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-put_subdirectoryformatpattern
    HRESULT put_SubdirectoryFormatPattern(BSTR pattern);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_task
    HRESULT get_Task(BSTR* task);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-put_task
    HRESULT put_Task(BSTR task);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_taskrunasself
    HRESULT get_TaskRunAsSelf(VARIANT_BOOL* RunAsSelf);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-put_taskrunasself
    HRESULT put_TaskRunAsSelf(VARIANT_BOOL RunAsSelf);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_taskarguments
    HRESULT get_TaskArguments(BSTR* task);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-put_taskarguments
    HRESULT put_TaskArguments(BSTR task);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_taskusertextarguments
    HRESULT get_TaskUserTextArguments(BSTR* UserText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-put_taskusertextarguments
    HRESULT put_TaskUserTextArguments(BSTR UserText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_schedules
    HRESULT get_Schedules(IScheduleCollection* ppSchedules);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_schedulesenabled
    HRESULT get_SchedulesEnabled(VARIANT_BOOL* enabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-put_schedulesenabled
    HRESULT put_SchedulesEnabled(VARIANT_BOOL enabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_useraccount
    HRESULT get_UserAccount(BSTR* user);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_xml
    HRESULT get_Xml(BSTR* xml);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_security
    HRESULT get_Security(BSTR* pbstrSecurity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-put_security
    HRESULT put_Security(BSTR bstrSecurity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_stoponcompletion
    HRESULT get_StopOnCompletion(VARIANT_BOOL* Stop);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-put_stoponcompletion
    HRESULT put_StopOnCompletion(VARIANT_BOOL Stop);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-get_datamanager
    HRESULT get_DataManager(IDataManager* DataManager);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-setcredentials
    HRESULT SetCredentials(BSTR user, BSTR password);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-query
    HRESULT Query(BSTR name, BSTR server);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-commit
    HRESULT Commit(BSTR name, BSTR server, CommitMode mode, IValueMap* validation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-delete
    HRESULT Delete();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-start
    HRESULT Start(VARIANT_BOOL Synchronous);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-stop
    HRESULT Stop(VARIANT_BOOL Synchronous);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-setxml
    HRESULT SetXml(BSTR xml, IValueMap* validation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-setvalue
    HRESULT SetValue(BSTR key, BSTR value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorset-getvalue
    HRESULT GetValue(BSTR key, BSTR* value);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nn-pla-idatamanager
@GUID("03837541-098b-11d8-9414-505054503030")
interface IDataManager : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatamanager-get_enabled
    HRESULT get_Enabled(VARIANT_BOOL* pfEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatamanager-put_enabled
    HRESULT put_Enabled(VARIANT_BOOL fEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatamanager-get_checkbeforerunning
    HRESULT get_CheckBeforeRunning(VARIANT_BOOL* pfCheck);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatamanager-put_checkbeforerunning
    HRESULT put_CheckBeforeRunning(VARIANT_BOOL fCheck);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatamanager-get_minfreedisk
    HRESULT get_MinFreeDisk(uint* MinFreeDisk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatamanager-put_minfreedisk
    HRESULT put_MinFreeDisk(uint MinFreeDisk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatamanager-get_maxsize
    HRESULT get_MaxSize(uint* pulMaxSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatamanager-put_maxsize
    HRESULT put_MaxSize(uint ulMaxSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatamanager-get_maxfoldercount
    HRESULT get_MaxFolderCount(uint* pulMaxFolderCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatamanager-put_maxfoldercount
    HRESULT put_MaxFolderCount(uint ulMaxFolderCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatamanager-get_resourcepolicy
    HRESULT get_ResourcePolicy(ResourcePolicy* pPolicy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatamanager-put_resourcepolicy
    HRESULT put_ResourcePolicy(ResourcePolicy Policy);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatamanager-get_folderactions
    HRESULT get_FolderActions(IFolderActionCollection* Actions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatamanager-get_reportschema
    HRESULT get_ReportSchema(BSTR* ReportSchema);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatamanager-put_reportschema
    HRESULT put_ReportSchema(BSTR ReportSchema);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatamanager-get_reportfilename
    HRESULT get_ReportFileName(BSTR* pbstrFilename);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatamanager-put_reportfilename
    HRESULT put_ReportFileName(BSTR pbstrFilename);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatamanager-get_ruletargetfilename
    HRESULT get_RuleTargetFileName(BSTR* Filename);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatamanager-put_ruletargetfilename
    HRESULT put_RuleTargetFileName(BSTR Filename);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatamanager-get_eventsfilename
    HRESULT get_EventsFileName(BSTR* pbstrFilename);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatamanager-put_eventsfilename
    HRESULT put_EventsFileName(BSTR pbstrFilename);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatamanager-get_rules
    HRESULT get_Rules(BSTR* pbstrXml);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatamanager-put_rules
    HRESULT put_Rules(BSTR bstrXml);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatamanager-run
    HRESULT Run(DataManagerSteps Steps, BSTR bstrFolder, IValueMap* Errors);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatamanager-extract
    HRESULT Extract(BSTR CabFilename, BSTR DestinationPath);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nn-pla-ifolderaction
@GUID("03837543-098b-11d8-9414-505054503030")
interface IFolderAction : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ifolderaction-get_age
    HRESULT get_Age(uint* pulAge);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ifolderaction-put_age
    HRESULT put_Age(uint ulAge);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ifolderaction-get_size
    HRESULT get_Size(uint* pulAge);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ifolderaction-put_size
    HRESULT put_Size(uint ulAge);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ifolderaction-get_actions
    HRESULT get_Actions(FolderActionSteps* Steps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ifolderaction-put_actions
    HRESULT put_Actions(FolderActionSteps Steps);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ifolderaction-get_sendcabto
    HRESULT get_SendCabTo(BSTR* pbstrDestination);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ifolderaction-put_sendcabto
    HRESULT put_SendCabTo(BSTR bstrDestination);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nn-pla-ifolderactioncollection
@GUID("03837544-098b-11d8-9414-505054503030")
interface IFolderActionCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ifolderactioncollection-get_count
    HRESULT get_Count(uint* Count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ifolderactioncollection-get_item
    HRESULT get_Item(VARIANT Index, IFolderAction* Action);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ifolderactioncollection-get__newenum
    HRESULT get__NewEnum(IUnknown* Enum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ifolderactioncollection-add
    HRESULT Add(IFolderAction Action);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ifolderactioncollection-remove
    HRESULT Remove(VARIANT Index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ifolderactioncollection-clear
    HRESULT Clear();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ifolderactioncollection-addrange
    HRESULT AddRange(IFolderActionCollection Actions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ifolderactioncollection-createfolderaction
    HRESULT CreateFolderAction(IFolderAction* FolderAction);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nn-pla-idatacollector
@GUID("038374ff-098b-11d8-9414-505054503030")
interface IDataCollector : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollector-get_datacollectorset
    HRESULT get_DataCollectorSet(IDataCollectorSet* group);
    HRESULT put_DataCollectorSet(IDataCollectorSet group);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollector-get_datacollectortype
    HRESULT get_DataCollectorType(DataCollectorType* type);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollector-get_filename
    HRESULT get_FileName(BSTR* name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollector-put_filename
    HRESULT put_FileName(BSTR name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollector-get_filenameformat
    HRESULT get_FileNameFormat(AutoPathFormat* format);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollector-put_filenameformat
    HRESULT put_FileNameFormat(AutoPathFormat format);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollector-get_filenameformatpattern
    HRESULT get_FileNameFormatPattern(BSTR* pattern);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollector-put_filenameformatpattern
    HRESULT put_FileNameFormatPattern(BSTR pattern);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollector-get_latestoutputlocation
    HRESULT get_LatestOutputLocation(BSTR* path);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollector-put_latestoutputlocation
    HRESULT put_LatestOutputLocation(BSTR path);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollector-get_logappend
    HRESULT get_LogAppend(VARIANT_BOOL* append);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollector-put_logappend
    HRESULT put_LogAppend(VARIANT_BOOL append);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollector-get_logcircular
    HRESULT get_LogCircular(VARIANT_BOOL* circular);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollector-put_logcircular
    HRESULT put_LogCircular(VARIANT_BOOL circular);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollector-get_logoverwrite
    HRESULT get_LogOverwrite(VARIANT_BOOL* overwrite);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollector-put_logoverwrite
    HRESULT put_LogOverwrite(VARIANT_BOOL overwrite);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollector-get_name
    HRESULT get_Name(BSTR* name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollector-put_name
    HRESULT put_Name(BSTR name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollector-get_outputlocation
    HRESULT get_OutputLocation(BSTR* path);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollector-get_index
    HRESULT get_Index(int* index);
    HRESULT put_Index(int index);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollector-get_xml
    HRESULT get_Xml(BSTR* Xml);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollector-setxml
    HRESULT SetXml(BSTR Xml, IValueMap* Validation);
    HRESULT CreateOutputLocation(VARIANT_BOOL Latest, BSTR* Location);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nn-pla-iperformancecounterdatacollector
@GUID("03837506-098b-11d8-9414-505054503030")
interface IPerformanceCounterDataCollector : IDataCollector
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iperformancecounterdatacollector-get_datasourcename
    HRESULT get_DataSourceName(BSTR* dsn);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iperformancecounterdatacollector-put_datasourcename
    HRESULT put_DataSourceName(BSTR dsn);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iperformancecounterdatacollector-get_performancecounters
    HRESULT get_PerformanceCounters(SAFEARRAY** counters);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iperformancecounterdatacollector-put_performancecounters
    HRESULT put_PerformanceCounters(SAFEARRAY* counters);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iperformancecounterdatacollector-get_logfileformat
    HRESULT get_LogFileFormat(FileFormat* format);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iperformancecounterdatacollector-put_logfileformat
    HRESULT put_LogFileFormat(FileFormat format);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iperformancecounterdatacollector-get_sampleinterval
    HRESULT get_SampleInterval(uint* interval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iperformancecounterdatacollector-put_sampleinterval
    HRESULT put_SampleInterval(uint interval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iperformancecounterdatacollector-get_segmentmaxrecords
    HRESULT get_SegmentMaxRecords(uint* records);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iperformancecounterdatacollector-put_segmentmaxrecords
    HRESULT put_SegmentMaxRecords(uint records);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nn-pla-itracedatacollector
@GUID("0383750b-098b-11d8-9414-505054503030")
interface ITraceDataCollector : IDataCollector
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-get_buffersize
    HRESULT get_BufferSize(uint* size);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-put_buffersize
    HRESULT put_BufferSize(uint size);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-get_bufferslost
    HRESULT get_BuffersLost(uint* buffers);
    HRESULT put_BuffersLost(uint buffers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-get_bufferswritten
    HRESULT get_BuffersWritten(uint* buffers);
    HRESULT put_BuffersWritten(uint buffers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-get_clocktype
    HRESULT get_ClockType(ClockType* clock);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-put_clocktype
    HRESULT put_ClockType(ClockType clock);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-get_eventslost
    HRESULT get_EventsLost(uint* events);
    HRESULT put_EventsLost(uint events);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-get_extendedmodes
    HRESULT get_ExtendedModes(uint* mode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-put_extendedmodes
    HRESULT put_ExtendedModes(uint mode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-get_flushtimer
    HRESULT get_FlushTimer(uint* seconds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-put_flushtimer
    HRESULT put_FlushTimer(uint seconds);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-get_freebuffers
    HRESULT get_FreeBuffers(uint* buffers);
    HRESULT put_FreeBuffers(uint buffers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-get_guid
    HRESULT get_Guid(GUID* guid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-put_guid
    HRESULT put_Guid(GUID guid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-get_iskerneltrace
    HRESULT get_IsKernelTrace(VARIANT_BOOL* kernel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-get_maximumbuffers
    HRESULT get_MaximumBuffers(uint* buffers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-put_maximumbuffers
    HRESULT put_MaximumBuffers(uint buffers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-get_minimumbuffers
    HRESULT get_MinimumBuffers(uint* buffers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-put_minimumbuffers
    HRESULT put_MinimumBuffers(uint buffers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-get_numberofbuffers
    HRESULT get_NumberOfBuffers(uint* buffers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-put_numberofbuffers
    HRESULT put_NumberOfBuffers(uint buffers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-get_preallocatefile
    HRESULT get_PreallocateFile(VARIANT_BOOL* allocate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-put_preallocatefile
    HRESULT put_PreallocateFile(VARIANT_BOOL allocate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-get_processmode
    HRESULT get_ProcessMode(VARIANT_BOOL* process);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-put_processmode
    HRESULT put_ProcessMode(VARIANT_BOOL process);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-get_realtimebufferslost
    HRESULT get_RealTimeBuffersLost(uint* buffers);
    HRESULT put_RealTimeBuffersLost(uint buffers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-get_sessionid
    HRESULT get_SessionId(ulong* id);
    HRESULT put_SessionId(ulong id);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-get_sessionname
    HRESULT get_SessionName(BSTR* name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-put_sessionname
    HRESULT put_SessionName(BSTR name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-get_sessionthreadid
    HRESULT get_SessionThreadId(uint* tid);
    HRESULT put_SessionThreadId(uint tid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-get_streammode
    HRESULT get_StreamMode(StreamMode* mode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-put_streammode
    HRESULT put_StreamMode(StreamMode mode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedatacollector-get_tracedataproviders
    HRESULT get_TraceDataProviders(ITraceDataProviderCollection* providers);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nn-pla-iconfigurationdatacollector
@GUID("03837514-098b-11d8-9414-505054503030")
interface IConfigurationDataCollector : IDataCollector
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iconfigurationdatacollector-get_filemaxcount
    HRESULT get_FileMaxCount(uint* count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iconfigurationdatacollector-put_filemaxcount
    HRESULT put_FileMaxCount(uint count);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iconfigurationdatacollector-get_filemaxrecursivedepth
    HRESULT get_FileMaxRecursiveDepth(uint* depth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iconfigurationdatacollector-put_filemaxrecursivedepth
    HRESULT put_FileMaxRecursiveDepth(uint depth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iconfigurationdatacollector-get_filemaxtotalsize
    HRESULT get_FileMaxTotalSize(uint* size);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iconfigurationdatacollector-put_filemaxtotalsize
    HRESULT put_FileMaxTotalSize(uint size);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iconfigurationdatacollector-get_files
    HRESULT get_Files(SAFEARRAY** Files);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iconfigurationdatacollector-put_files
    HRESULT put_Files(SAFEARRAY* Files);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iconfigurationdatacollector-get_managementqueries
    HRESULT get_ManagementQueries(SAFEARRAY** Queries);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iconfigurationdatacollector-put_managementqueries
    HRESULT put_ManagementQueries(SAFEARRAY* Queries);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iconfigurationdatacollector-get_querynetworkadapters
    HRESULT get_QueryNetworkAdapters(VARIANT_BOOL* network);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iconfigurationdatacollector-put_querynetworkadapters
    HRESULT put_QueryNetworkAdapters(VARIANT_BOOL network);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iconfigurationdatacollector-get_registrykeys
    HRESULT get_RegistryKeys(SAFEARRAY** query);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iconfigurationdatacollector-put_registrykeys
    HRESULT put_RegistryKeys(SAFEARRAY* query);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iconfigurationdatacollector-get_registrymaxrecursivedepth
    HRESULT get_RegistryMaxRecursiveDepth(uint* depth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iconfigurationdatacollector-put_registrymaxrecursivedepth
    HRESULT put_RegistryMaxRecursiveDepth(uint depth);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iconfigurationdatacollector-get_systemstatefile
    HRESULT get_SystemStateFile(BSTR* FileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iconfigurationdatacollector-put_systemstatefile
    HRESULT put_SystemStateFile(BSTR FileName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nn-pla-ialertdatacollector
@GUID("03837516-098b-11d8-9414-505054503030")
interface IAlertDataCollector : IDataCollector
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ialertdatacollector-get_alertthresholds
    HRESULT get_AlertThresholds(SAFEARRAY** alerts);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ialertdatacollector-put_alertthresholds
    HRESULT put_AlertThresholds(SAFEARRAY* alerts);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ialertdatacollector-get_eventlog
    HRESULT get_EventLog(VARIANT_BOOL* log);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ialertdatacollector-put_eventlog
    HRESULT put_EventLog(VARIANT_BOOL log);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ialertdatacollector-get_sampleinterval
    HRESULT get_SampleInterval(uint* interval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ialertdatacollector-put_sampleinterval
    HRESULT put_SampleInterval(uint interval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ialertdatacollector-get_task
    HRESULT get_Task(BSTR* task);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ialertdatacollector-put_task
    HRESULT put_Task(BSTR task);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ialertdatacollector-get_taskrunasself
    HRESULT get_TaskRunAsSelf(VARIANT_BOOL* RunAsSelf);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ialertdatacollector-put_taskrunasself
    HRESULT put_TaskRunAsSelf(VARIANT_BOOL RunAsSelf);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ialertdatacollector-get_taskarguments
    HRESULT get_TaskArguments(BSTR* task);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ialertdatacollector-put_taskarguments
    HRESULT put_TaskArguments(BSTR task);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ialertdatacollector-get_taskusertextarguments
    HRESULT get_TaskUserTextArguments(BSTR* task);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ialertdatacollector-put_taskusertextarguments
    HRESULT put_TaskUserTextArguments(BSTR task);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ialertdatacollector-get_triggerdatacollectorset
    HRESULT get_TriggerDataCollectorSet(BSTR* name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ialertdatacollector-put_triggerdatacollectorset
    HRESULT put_TriggerDataCollectorSet(BSTR name);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nn-pla-iapitracingdatacollector
@GUID("0383751a-098b-11d8-9414-505054503030")
interface IApiTracingDataCollector : IDataCollector
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iapitracingdatacollector-get_logapinamesonly
    HRESULT get_LogApiNamesOnly(VARIANT_BOOL* logapinames);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iapitracingdatacollector-put_logapinamesonly
    HRESULT put_LogApiNamesOnly(VARIANT_BOOL logapinames);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iapitracingdatacollector-get_logapisrecursively
    HRESULT get_LogApisRecursively(VARIANT_BOOL* logrecursively);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iapitracingdatacollector-put_logapisrecursively
    HRESULT put_LogApisRecursively(VARIANT_BOOL logrecursively);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iapitracingdatacollector-get_exepath
    HRESULT get_ExePath(BSTR* exepath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iapitracingdatacollector-put_exepath
    HRESULT put_ExePath(BSTR exepath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iapitracingdatacollector-get_logfilepath
    HRESULT get_LogFilePath(BSTR* logfilepath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iapitracingdatacollector-put_logfilepath
    HRESULT put_LogFilePath(BSTR logfilepath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iapitracingdatacollector-get_includemodules
    HRESULT get_IncludeModules(SAFEARRAY** includemodules);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iapitracingdatacollector-put_includemodules
    HRESULT put_IncludeModules(SAFEARRAY* includemodules);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iapitracingdatacollector-get_includeapis
    HRESULT get_IncludeApis(SAFEARRAY** includeapis);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iapitracingdatacollector-put_includeapis
    HRESULT put_IncludeApis(SAFEARRAY* includeapis);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iapitracingdatacollector-get_excludeapis
    HRESULT get_ExcludeApis(SAFEARRAY** excludeapis);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-iapitracingdatacollector-put_excludeapis
    HRESULT put_ExcludeApis(SAFEARRAY* excludeapis);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nn-pla-idatacollectorcollection
@GUID("03837502-098b-11d8-9414-505054503030")
interface IDataCollectorCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorcollection-get_count
    HRESULT get_Count(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorcollection-get_item
    HRESULT get_Item(VARIANT index, IDataCollector* collector);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorcollection-get__newenum
    HRESULT get__NewEnum(IUnknown* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorcollection-add
    HRESULT Add(IDataCollector collector);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorcollection-remove
    HRESULT Remove(VARIANT collector);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorcollection-clear
    HRESULT Clear();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorcollection-addrange
    HRESULT AddRange(IDataCollectorCollection collectors);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorcollection-createdatacollectorfromxml
    HRESULT CreateDataCollectorFromXml(BSTR bstrXml, IValueMap* pValidation, IDataCollector* pCollector);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorcollection-createdatacollector
    HRESULT CreateDataCollector(DataCollectorType Type, IDataCollector* Collector);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nn-pla-idatacollectorsetcollection
@GUID("03837524-098b-11d8-9414-505054503030")
interface IDataCollectorSetCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorsetcollection-get_count
    HRESULT get_Count(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorsetcollection-get_item
    HRESULT get_Item(VARIANT index, IDataCollectorSet* set);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorsetcollection-get__newenum
    HRESULT get__NewEnum(IUnknown* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorsetcollection-add
    HRESULT Add(IDataCollectorSet set);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorsetcollection-remove
    HRESULT Remove(VARIANT set);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorsetcollection-clear
    HRESULT Clear();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorsetcollection-addrange
    HRESULT AddRange(IDataCollectorSetCollection sets);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-idatacollectorsetcollection-getdatacollectorsets
    HRESULT GetDataCollectorSets(BSTR server, BSTR filter);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nn-pla-itracedataprovider
@GUID("03837512-098b-11d8-9414-505054503030")
interface ITraceDataProvider : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovider-get_displayname
    HRESULT get_DisplayName(BSTR* name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovider-put_displayname
    HRESULT put_DisplayName(BSTR name);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovider-get_guid
    HRESULT get_Guid(GUID* guid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovider-put_guid
    HRESULT put_Guid(GUID guid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovider-get_level
    HRESULT get_Level(IValueMap* ppLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovider-get_keywordsany
    HRESULT get_KeywordsAny(IValueMap* ppKeywords);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovider-get_keywordsall
    HRESULT get_KeywordsAll(IValueMap* ppKeywords);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovider-get_properties
    HRESULT get_Properties(IValueMap* ppProperties);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovider-get_filterenabled
    HRESULT get_FilterEnabled(VARIANT_BOOL* FilterEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovider-put_filterenabled
    HRESULT put_FilterEnabled(VARIANT_BOOL FilterEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovider-get_filtertype
    HRESULT get_FilterType(uint* pulType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovider-put_filtertype
    HRESULT put_FilterType(uint ulType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovider-get_filterdata
    HRESULT get_FilterData(SAFEARRAY** ppData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovider-put_filterdata
    HRESULT put_FilterData(SAFEARRAY* pData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovider-query
    HRESULT Query(BSTR bstrName, BSTR bstrServer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovider-resolve
    HRESULT Resolve(IDispatch pFrom);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovider-setsecurity
    HRESULT SetSecurity(BSTR Sddl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovider-getsecurity
    HRESULT GetSecurity(uint SecurityInfo, BSTR* Sddl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovider-getregisteredprocesses
    HRESULT GetRegisteredProcesses(IValueMap* Processes);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nn-pla-itracedataprovidercollection
@GUID("03837510-098b-11d8-9414-505054503030")
interface ITraceDataProviderCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovidercollection-get_count
    HRESULT get_Count(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovidercollection-get_item
    HRESULT get_Item(VARIANT index, ITraceDataProvider* ppProvider);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovidercollection-get__newenum
    HRESULT get__NewEnum(IUnknown* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovidercollection-add
    HRESULT Add(ITraceDataProvider pProvider);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovidercollection-remove
    HRESULT Remove(VARIANT vProvider);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovidercollection-clear
    HRESULT Clear();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovidercollection-addrange
    HRESULT AddRange(ITraceDataProviderCollection providers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovidercollection-createtracedataprovider
    HRESULT CreateTraceDataProvider(ITraceDataProvider* Provider);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovidercollection-gettracedataproviders
    HRESULT GetTraceDataProviders(BSTR server);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-itracedataprovidercollection-gettracedataprovidersbyprocess
    HRESULT GetTraceDataProvidersByProcess(BSTR Server, uint Pid);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nn-pla-ischedule
@GUID("0383753a-098b-11d8-9414-505054503030")
interface ISchedule : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ischedule-get_startdate
    HRESULT get_StartDate(VARIANT* start);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ischedule-put_startdate
    HRESULT put_StartDate(VARIANT start);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ischedule-get_enddate
    HRESULT get_EndDate(VARIANT* end);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ischedule-put_enddate
    HRESULT put_EndDate(VARIANT end);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ischedule-get_starttime
    HRESULT get_StartTime(VARIANT* start);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ischedule-put_starttime
    HRESULT put_StartTime(VARIANT start);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ischedule-get_days
    HRESULT get_Days(WeekDays* days);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ischedule-put_days
    HRESULT put_Days(WeekDays days);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nn-pla-ischedulecollection
@GUID("0383753d-098b-11d8-9414-505054503030")
interface IScheduleCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ischedulecollection-get_count
    HRESULT get_Count(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ischedulecollection-get_item
    HRESULT get_Item(VARIANT index, ISchedule* ppSchedule);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ischedulecollection-get__newenum
    HRESULT get__NewEnum(IUnknown* ienum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ischedulecollection-add
    HRESULT Add(ISchedule pSchedule);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ischedulecollection-remove
    HRESULT Remove(VARIANT vSchedule);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ischedulecollection-clear
    HRESULT Clear();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ischedulecollection-addrange
    HRESULT AddRange(IScheduleCollection pSchedules);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ischedulecollection-createschedule
    HRESULT CreateSchedule(ISchedule* Schedule);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nn-pla-ivaluemapitem
@GUID("03837533-098b-11d8-9414-505054503030")
interface IValueMapItem : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ivaluemapitem-get_description
    HRESULT get_Description(BSTR* description);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ivaluemapitem-put_description
    HRESULT put_Description(BSTR description);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ivaluemapitem-get_enabled
    HRESULT get_Enabled(VARIANT_BOOL* enabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ivaluemapitem-put_enabled
    HRESULT put_Enabled(VARIANT_BOOL enabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ivaluemapitem-get_key
    HRESULT get_Key(BSTR* key);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ivaluemapitem-put_key
    HRESULT put_Key(BSTR key);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ivaluemapitem-get_value
    HRESULT get_Value(VARIANT* Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ivaluemapitem-put_value
    HRESULT put_Value(VARIANT Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ivaluemapitem-get_valuemaptype
    HRESULT get_ValueMapType(ValueMapType* type);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ivaluemapitem-put_valuemaptype
    HRESULT put_ValueMapType(ValueMapType type);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nn-pla-ivaluemap
@GUID("03837534-098b-11d8-9414-505054503030")
interface IValueMap : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ivaluemap-get_count
    HRESULT get_Count(int* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ivaluemap-get_item
    HRESULT get_Item(VARIANT index, IValueMapItem* value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ivaluemap-get__newenum
    HRESULT get__NewEnum(IUnknown* retVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ivaluemap-get_description
    HRESULT get_Description(BSTR* description);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ivaluemap-put_description
    HRESULT put_Description(BSTR description);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ivaluemap-get_value
    HRESULT get_Value(VARIANT* Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ivaluemap-put_value
    HRESULT put_Value(VARIANT Value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ivaluemap-get_valuemaptype
    HRESULT get_ValueMapType(ValueMapType* type);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ivaluemap-put_valuemaptype
    HRESULT put_ValueMapType(ValueMapType type);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ivaluemap-add
    HRESULT Add(VARIANT value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ivaluemap-remove
    HRESULT Remove(VARIANT value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ivaluemap-clear
    HRESULT Clear();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ivaluemap-addrange
    HRESULT AddRange(IValueMap map);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/pla/nf-pla-ivaluemap-createvaluemapitem
    HRESULT CreateValueMapItem(IValueMapItem* Item);
}

@GUID("771a9520-ee28-11ce-941e-008029004347")
interface ICounterItem : IUnknown
{
    HRESULT get_Value(double* pdblValue);
    HRESULT put_Color(uint Color);
    HRESULT get_Color(uint* pColor);
    HRESULT put_Width(int iWidth);
    HRESULT get_Width(int* piValue);
    HRESULT put_LineStyle(int iLineStyle);
    HRESULT get_LineStyle(int* piValue);
    HRESULT put_ScaleFactor(int iScale);
    HRESULT get_ScaleFactor(int* piValue);
    HRESULT get_Path(BSTR* pstrValue);
    HRESULT GetValue(double* Value, int* Status);
    HRESULT GetStatistics(double* Max, double* Min, double* Avg, int* Status);
}

@GUID("eefcd4e1-ea1c-4435-b7f4-e341ba03b4f9")
interface ICounterItem2 : ICounterItem
{
    HRESULT put_Selected(VARIANT_BOOL bState);
    HRESULT get_Selected(VARIANT_BOOL* pbState);
    HRESULT put_Visible(VARIANT_BOOL bState);
    HRESULT get_Visible(VARIANT_BOOL* pbState);
    HRESULT GetDataAt(int iIndex, SysmonDataType iWhich, VARIANT* pVariant);
}

@GUID("de1a6b74-9182-4c41-8e2c-24c2cd30ee83")
interface _ICounterItemUnion : IUnknown
{
    HRESULT get_Value(double* pdblValue);
    HRESULT put_Color(uint Color);
    HRESULT get_Color(uint* pColor);
    HRESULT put_Width(int iWidth);
    HRESULT get_Width(int* piValue);
    HRESULT put_LineStyle(int iLineStyle);
    HRESULT get_LineStyle(int* piValue);
    HRESULT put_ScaleFactor(int iScale);
    HRESULT get_ScaleFactor(int* piValue);
    HRESULT get_Path(BSTR* pstrValue);
    HRESULT GetValue(double* Value, int* Status);
    HRESULT GetStatistics(double* Max, double* Min, double* Avg, int* Status);
    HRESULT put_Selected(VARIANT_BOOL bState);
    HRESULT get_Selected(VARIANT_BOOL* pbState);
    HRESULT put_Visible(VARIANT_BOOL bState);
    HRESULT get_Visible(VARIANT_BOOL* pbState);
    HRESULT GetDataAt(int iIndex, SysmonDataType iWhich, VARIANT* pVariant);
}

@GUID("c08c4ff2-0e2e-11cf-942c-008029004347")
interface DICounterItem : IDispatch
{
}

@GUID("79167962-28fc-11cf-942f-008029004347")
interface ICounters : IDispatch
{
    HRESULT get_Count(int* pLong);
    HRESULT get__NewEnum(IUnknown* ppIunk);
    HRESULT get_Item(VARIANT index, DICounterItem* ppI);
    HRESULT Add(BSTR pathname, DICounterItem* ppI);
    HRESULT Remove(VARIANT index);
}

@GUID("d6b518dd-05c7-418a-89e6-4f9ce8c6841e")
interface ILogFileItem : IUnknown
{
    HRESULT get_Path(BSTR* pstrValue);
}

@GUID("8d093ffc-f777-4917-82d1-833fbc54c58f")
interface DILogFileItem : IDispatch
{
}

@GUID("6a2a97e6-6851-41ea-87ad-2a8225335865")
interface ILogFiles : IDispatch
{
    HRESULT get_Count(int* pLong);
    HRESULT get__NewEnum(IUnknown* ppIunk);
    HRESULT get_Item(VARIANT index, DILogFileItem* ppI);
    HRESULT Add(BSTR pathname, DILogFileItem* ppI);
    HRESULT Remove(VARIANT index);
}

@GUID("194eb241-c32c-11cf-9398-00aa00a3ddea")
interface ISystemMonitor : IUnknown
{
    HRESULT get_Appearance(int* iAppearance);
    HRESULT put_Appearance(int iAppearance);
    HRESULT get_BackColor(uint* pColor);
    HRESULT put_BackColor(uint Color);
    HRESULT get_BorderStyle(int* iBorderStyle);
    HRESULT put_BorderStyle(int iBorderStyle);
    HRESULT get_ForeColor(uint* pColor);
    HRESULT put_ForeColor(uint Color);
    HRESULT get_Font(IFontDisp* ppFont);
    HRESULT putref_Font(IFontDisp pFont);
    HRESULT get_Counters(ICounters* ppICounters);
    HRESULT put_ShowVerticalGrid(VARIANT_BOOL bState);
    HRESULT get_ShowVerticalGrid(VARIANT_BOOL* pbState);
    HRESULT put_ShowHorizontalGrid(VARIANT_BOOL bState);
    HRESULT get_ShowHorizontalGrid(VARIANT_BOOL* pbState);
    HRESULT put_ShowLegend(VARIANT_BOOL bState);
    HRESULT get_ShowLegend(VARIANT_BOOL* pbState);
    HRESULT put_ShowScaleLabels(VARIANT_BOOL bState);
    HRESULT get_ShowScaleLabels(VARIANT_BOOL* pbState);
    HRESULT put_ShowValueBar(VARIANT_BOOL bState);
    HRESULT get_ShowValueBar(VARIANT_BOOL* pbState);
    HRESULT put_MaximumScale(int iValue);
    HRESULT get_MaximumScale(int* piValue);
    HRESULT put_MinimumScale(int iValue);
    HRESULT get_MinimumScale(int* piValue);
    HRESULT put_UpdateInterval(float fValue);
    HRESULT get_UpdateInterval(float* pfValue);
    HRESULT put_DisplayType(DisplayTypeConstants eDisplayType);
    HRESULT get_DisplayType(DisplayTypeConstants* peDisplayType);
    HRESULT put_ManualUpdate(VARIANT_BOOL bState);
    HRESULT get_ManualUpdate(VARIANT_BOOL* pbState);
    HRESULT put_GraphTitle(BSTR bsTitle);
    HRESULT get_GraphTitle(BSTR* pbsTitle);
    HRESULT put_YAxisLabel(BSTR bsTitle);
    HRESULT get_YAxisLabel(BSTR* pbsTitle);
    HRESULT CollectSample();
    HRESULT UpdateGraph();
    HRESULT BrowseCounters();
    HRESULT DisplayProperties();
    HRESULT Counter(int iIndex, ICounterItem* ppICounter);
    HRESULT AddCounter(BSTR bsPath, ICounterItem* ppICounter);
    HRESULT DeleteCounter(ICounterItem pCtr);
    HRESULT get_BackColorCtl(uint* pColor);
    HRESULT put_BackColorCtl(uint Color);
    HRESULT put_LogFileName(BSTR bsFileName);
    HRESULT get_LogFileName(BSTR* bsFileName);
    HRESULT put_LogViewStart(double StartTime);
    HRESULT get_LogViewStart(double* StartTime);
    HRESULT put_LogViewStop(double StopTime);
    HRESULT get_LogViewStop(double* StopTime);
    HRESULT get_GridColor(uint* pColor);
    HRESULT put_GridColor(uint Color);
    HRESULT get_TimeBarColor(uint* pColor);
    HRESULT put_TimeBarColor(uint Color);
    HRESULT get_Highlight(VARIANT_BOOL* pbState);
    HRESULT put_Highlight(VARIANT_BOOL bState);
    HRESULT get_ShowToolbar(VARIANT_BOOL* pbState);
    HRESULT put_ShowToolbar(VARIANT_BOOL bState);
    HRESULT Paste();
    HRESULT Copy();
    HRESULT Reset();
    HRESULT put_ReadOnly(VARIANT_BOOL bState);
    HRESULT get_ReadOnly(VARIANT_BOOL* pbState);
    HRESULT put_ReportValueType(ReportValueTypeConstants eReportValueType);
    HRESULT get_ReportValueType(ReportValueTypeConstants* peReportValueType);
    HRESULT put_MonitorDuplicateInstances(VARIANT_BOOL bState);
    HRESULT get_MonitorDuplicateInstances(VARIANT_BOOL* pbState);
    HRESULT put_DisplayFilter(int iValue);
    HRESULT get_DisplayFilter(int* piValue);
    HRESULT get_LogFiles(ILogFiles* ppILogFiles);
    HRESULT put_DataSourceType(DataSourceTypeConstants eDataSourceType);
    HRESULT get_DataSourceType(DataSourceTypeConstants* peDataSourceType);
    HRESULT put_SqlDsnName(BSTR bsSqlDsnName);
    HRESULT get_SqlDsnName(BSTR* bsSqlDsnName);
    HRESULT put_SqlLogSetName(BSTR bsSqlLogSetName);
    HRESULT get_SqlLogSetName(BSTR* bsSqlLogSetName);
}

@GUID("08e3206a-5fd2-4fde-a8a5-8cb3b63d2677")
interface ISystemMonitor2 : ISystemMonitor
{
    HRESULT put_EnableDigitGrouping(VARIANT_BOOL bState);
    HRESULT get_EnableDigitGrouping(VARIANT_BOOL* pbState);
    HRESULT put_EnableToolTips(VARIANT_BOOL bState);
    HRESULT get_EnableToolTips(VARIANT_BOOL* pbState);
    HRESULT put_ShowTimeAxisLabels(VARIANT_BOOL bState);
    HRESULT get_ShowTimeAxisLabels(VARIANT_BOOL* pbState);
    HRESULT put_ChartScroll(VARIANT_BOOL bScroll);
    HRESULT get_ChartScroll(VARIANT_BOOL* pbScroll);
    HRESULT put_DataPointCount(int iNewCount);
    HRESULT get_DataPointCount(int* piDataPointCount);
    HRESULT ScaleToFit(VARIANT_BOOL bSelectedCountersOnly);
    HRESULT SaveAs(BSTR bstrFileName, SysmonFileType eSysmonFileType);
    HRESULT Relog(BSTR bstrFileName, SysmonFileType eSysmonFileType, int iFilter);
    HRESULT ClearData();
    HRESULT get_LogSourceStartTime(double* pDate);
    HRESULT get_LogSourceStopTime(double* pDate);
    HRESULT SetLogViewRange(double StartTime, double StopTime);
    HRESULT GetLogViewRange(double* StartTime, double* StopTime);
    HRESULT BatchingLock(VARIANT_BOOL fLock, SysmonBatchReason eBatchReason);
    HRESULT LoadSettings(BSTR bstrSettingFileName);
}

@GUID("c8a77338-265f-4de5-aa25-c7da1ce5a8f4")
interface _ISystemMonitorUnion : IUnknown
{
    HRESULT get_Appearance(int* iAppearance);
    HRESULT put_Appearance(int iAppearance);
    HRESULT get_BackColor(uint* pColor);
    HRESULT put_BackColor(uint Color);
    HRESULT get_BorderStyle(int* iBorderStyle);
    HRESULT put_BorderStyle(int iBorderStyle);
    HRESULT get_ForeColor(uint* pColor);
    HRESULT put_ForeColor(uint Color);
    HRESULT get_Font(IFontDisp* ppFont);
    HRESULT putref_Font(IFontDisp pFont);
    HRESULT get_Counters(ICounters* ppICounters);
    HRESULT put_ShowVerticalGrid(VARIANT_BOOL bState);
    HRESULT get_ShowVerticalGrid(VARIANT_BOOL* pbState);
    HRESULT put_ShowHorizontalGrid(VARIANT_BOOL bState);
    HRESULT get_ShowHorizontalGrid(VARIANT_BOOL* pbState);
    HRESULT put_ShowLegend(VARIANT_BOOL bState);
    HRESULT get_ShowLegend(VARIANT_BOOL* pbState);
    HRESULT put_ShowScaleLabels(VARIANT_BOOL bState);
    HRESULT get_ShowScaleLabels(VARIANT_BOOL* pbState);
    HRESULT put_ShowValueBar(VARIANT_BOOL bState);
    HRESULT get_ShowValueBar(VARIANT_BOOL* pbState);
    HRESULT put_MaximumScale(int iValue);
    HRESULT get_MaximumScale(int* piValue);
    HRESULT put_MinimumScale(int iValue);
    HRESULT get_MinimumScale(int* piValue);
    HRESULT put_UpdateInterval(float fValue);
    HRESULT get_UpdateInterval(float* pfValue);
    HRESULT put_DisplayType(DisplayTypeConstants eDisplayType);
    HRESULT get_DisplayType(DisplayTypeConstants* peDisplayType);
    HRESULT put_ManualUpdate(VARIANT_BOOL bState);
    HRESULT get_ManualUpdate(VARIANT_BOOL* pbState);
    HRESULT put_GraphTitle(BSTR bsTitle);
    HRESULT get_GraphTitle(BSTR* pbsTitle);
    HRESULT put_YAxisLabel(BSTR bsTitle);
    HRESULT get_YAxisLabel(BSTR* pbsTitle);
    HRESULT CollectSample();
    HRESULT UpdateGraph();
    HRESULT BrowseCounters();
    HRESULT DisplayProperties();
    HRESULT Counter(int iIndex, ICounterItem* ppICounter);
    HRESULT AddCounter(BSTR bsPath, ICounterItem* ppICounter);
    HRESULT DeleteCounter(ICounterItem pCtr);
    HRESULT get_BackColorCtl(uint* pColor);
    HRESULT put_BackColorCtl(uint Color);
    HRESULT put_LogFileName(BSTR bsFileName);
    HRESULT get_LogFileName(BSTR* bsFileName);
    HRESULT put_LogViewStart(double StartTime);
    HRESULT get_LogViewStart(double* StartTime);
    HRESULT put_LogViewStop(double StopTime);
    HRESULT get_LogViewStop(double* StopTime);
    HRESULT get_GridColor(uint* pColor);
    HRESULT put_GridColor(uint Color);
    HRESULT get_TimeBarColor(uint* pColor);
    HRESULT put_TimeBarColor(uint Color);
    HRESULT get_Highlight(VARIANT_BOOL* pbState);
    HRESULT put_Highlight(VARIANT_BOOL bState);
    HRESULT get_ShowToolbar(VARIANT_BOOL* pbState);
    HRESULT put_ShowToolbar(VARIANT_BOOL bState);
    HRESULT Paste();
    HRESULT Copy();
    HRESULT Reset();
    HRESULT put_ReadOnly(VARIANT_BOOL bState);
    HRESULT get_ReadOnly(VARIANT_BOOL* pbState);
    HRESULT put_ReportValueType(ReportValueTypeConstants eReportValueType);
    HRESULT get_ReportValueType(ReportValueTypeConstants* peReportValueType);
    HRESULT put_MonitorDuplicateInstances(VARIANT_BOOL bState);
    HRESULT get_MonitorDuplicateInstances(VARIANT_BOOL* pbState);
    HRESULT put_DisplayFilter(int iValue);
    HRESULT get_DisplayFilter(int* piValue);
    HRESULT get_LogFiles(ILogFiles* ppILogFiles);
    HRESULT put_DataSourceType(DataSourceTypeConstants eDataSourceType);
    HRESULT get_DataSourceType(DataSourceTypeConstants* peDataSourceType);
    HRESULT put_SqlDsnName(BSTR bsSqlDsnName);
    HRESULT get_SqlDsnName(BSTR* bsSqlDsnName);
    HRESULT put_SqlLogSetName(BSTR bsSqlLogSetName);
    HRESULT get_SqlLogSetName(BSTR* bsSqlLogSetName);
    HRESULT put_EnableDigitGrouping(VARIANT_BOOL bState);
    HRESULT get_EnableDigitGrouping(VARIANT_BOOL* pbState);
    HRESULT put_EnableToolTips(VARIANT_BOOL bState);
    HRESULT get_EnableToolTips(VARIANT_BOOL* pbState);
    HRESULT put_ShowTimeAxisLabels(VARIANT_BOOL bState);
    HRESULT get_ShowTimeAxisLabels(VARIANT_BOOL* pbState);
    HRESULT put_ChartScroll(VARIANT_BOOL bScroll);
    HRESULT get_ChartScroll(VARIANT_BOOL* pbScroll);
    HRESULT put_DataPointCount(int iNewCount);
    HRESULT get_DataPointCount(int* piDataPointCount);
    HRESULT ScaleToFit(VARIANT_BOOL bSelectedCountersOnly);
    HRESULT SaveAs(BSTR bstrFileName, SysmonFileType eSysmonFileType);
    HRESULT Relog(BSTR bstrFileName, SysmonFileType eSysmonFileType, int iFilter);
    HRESULT ClearData();
    HRESULT get_LogSourceStartTime(double* pDate);
    HRESULT get_LogSourceStopTime(double* pDate);
    HRESULT SetLogViewRange(double StartTime, double StopTime);
    HRESULT GetLogViewRange(double* StartTime, double* StopTime);
    HRESULT BatchingLock(VARIANT_BOOL fLock, SysmonBatchReason eBatchReason);
    HRESULT LoadSettings(BSTR bstrSettingFileName);
}

@GUID("13d73d81-c32e-11cf-9398-00aa00a3ddea")
interface DISystemMonitor : IDispatch
{
}

@GUID("194eb242-c32c-11cf-9398-00aa00a3ddea")
interface DISystemMonitorInternal : IDispatch
{
}

@GUID("ee660ea0-4abd-11cf-943a-008029004347")
interface ISystemMonitorEvents : IUnknown
{
    void OnCounterSelected(int Index);
    void OnCounterAdded(int Index);
    void OnCounterDeleted(int Index);
    void OnSampleCollected();
    void OnDblClick(int Index);
}

@GUID("84979930-4ab3-11cf-943a-008029004347")
interface DISystemMonitorEvents : IDispatch
{
}


// GUIDs

const GUID CLSID_AppearPropPage                   = GUIDOF!AppearPropPage;
const GUID CLSID_BootTraceSession                 = GUIDOF!BootTraceSession;
const GUID CLSID_BootTraceSessionCollection       = GUIDOF!BootTraceSessionCollection;
const GUID CLSID_CounterItem                      = GUIDOF!CounterItem;
const GUID CLSID_CounterItem2                     = GUIDOF!CounterItem2;
const GUID CLSID_CounterPropPage                  = GUIDOF!CounterPropPage;
const GUID CLSID_Counters                         = GUIDOF!Counters;
const GUID CLSID_DataCollectorSet                 = GUIDOF!DataCollectorSet;
const GUID CLSID_DataCollectorSetCollection       = GUIDOF!DataCollectorSetCollection;
const GUID CLSID_GeneralPropPage                  = GUIDOF!GeneralPropPage;
const GUID CLSID_GraphPropPage                    = GUIDOF!GraphPropPage;
const GUID CLSID_LegacyDataCollectorSet           = GUIDOF!LegacyDataCollectorSet;
const GUID CLSID_LegacyDataCollectorSetCollection = GUIDOF!LegacyDataCollectorSetCollection;
const GUID CLSID_LegacyTraceSession               = GUIDOF!LegacyTraceSession;
const GUID CLSID_LegacyTraceSessionCollection     = GUIDOF!LegacyTraceSessionCollection;
const GUID CLSID_LogFileItem                      = GUIDOF!LogFileItem;
const GUID CLSID_LogFiles                         = GUIDOF!LogFiles;
const GUID CLSID_ServerDataCollectorSet           = GUIDOF!ServerDataCollectorSet;
const GUID CLSID_ServerDataCollectorSetCollection = GUIDOF!ServerDataCollectorSetCollection;
const GUID CLSID_SourcePropPage                   = GUIDOF!SourcePropPage;
const GUID CLSID_SystemDataCollectorSet           = GUIDOF!SystemDataCollectorSet;
const GUID CLSID_SystemDataCollectorSetCollection = GUIDOF!SystemDataCollectorSetCollection;
const GUID CLSID_SystemMonitor                    = GUIDOF!SystemMonitor;
const GUID CLSID_SystemMonitor2                   = GUIDOF!SystemMonitor2;
const GUID CLSID_TraceDataProvider                = GUIDOF!TraceDataProvider;
const GUID CLSID_TraceDataProviderCollection      = GUIDOF!TraceDataProviderCollection;
const GUID CLSID_TraceSession                     = GUIDOF!TraceSession;
const GUID CLSID_TraceSessionCollection           = GUIDOF!TraceSessionCollection;

const GUID IID_DICounterItem                    = GUIDOF!DICounterItem;
const GUID IID_DILogFileItem                    = GUIDOF!DILogFileItem;
const GUID IID_DISystemMonitor                  = GUIDOF!DISystemMonitor;
const GUID IID_DISystemMonitorEvents            = GUIDOF!DISystemMonitorEvents;
const GUID IID_DISystemMonitorInternal          = GUIDOF!DISystemMonitorInternal;
const GUID IID_IAlertDataCollector              = GUIDOF!IAlertDataCollector;
const GUID IID_IApiTracingDataCollector         = GUIDOF!IApiTracingDataCollector;
const GUID IID_IConfigurationDataCollector      = GUIDOF!IConfigurationDataCollector;
const GUID IID_ICounterItem                     = GUIDOF!ICounterItem;
const GUID IID_ICounterItem2                    = GUIDOF!ICounterItem2;
const GUID IID_ICounters                        = GUIDOF!ICounters;
const GUID IID_IDataCollector                   = GUIDOF!IDataCollector;
const GUID IID_IDataCollectorCollection         = GUIDOF!IDataCollectorCollection;
const GUID IID_IDataCollectorSet                = GUIDOF!IDataCollectorSet;
const GUID IID_IDataCollectorSetCollection      = GUIDOF!IDataCollectorSetCollection;
const GUID IID_IDataManager                     = GUIDOF!IDataManager;
const GUID IID_IFolderAction                    = GUIDOF!IFolderAction;
const GUID IID_IFolderActionCollection          = GUIDOF!IFolderActionCollection;
const GUID IID_ILogFileItem                     = GUIDOF!ILogFileItem;
const GUID IID_ILogFiles                        = GUIDOF!ILogFiles;
const GUID IID_IPerformanceCounterDataCollector = GUIDOF!IPerformanceCounterDataCollector;
const GUID IID_ISchedule                        = GUIDOF!ISchedule;
const GUID IID_IScheduleCollection              = GUIDOF!IScheduleCollection;
const GUID IID_ISystemMonitor                   = GUIDOF!ISystemMonitor;
const GUID IID_ISystemMonitor2                  = GUIDOF!ISystemMonitor2;
const GUID IID_ISystemMonitorEvents             = GUIDOF!ISystemMonitorEvents;
const GUID IID_ITraceDataCollector              = GUIDOF!ITraceDataCollector;
const GUID IID_ITraceDataProvider               = GUIDOF!ITraceDataProvider;
const GUID IID_ITraceDataProviderCollection     = GUIDOF!ITraceDataProviderCollection;
const GUID IID_IValueMap                        = GUIDOF!IValueMap;
const GUID IID_IValueMapItem                    = GUIDOF!IValueMapItem;
const GUID IID__ICounterItemUnion               = GUIDOF!_ICounterItemUnion;
const GUID IID__ISystemMonitorUnion             = GUIDOF!_ISystemMonitorUnion;
