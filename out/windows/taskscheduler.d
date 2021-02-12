module windows.taskscheduler;

public import system;
public import windows.automation;
public import windows.com;
public import windows.controls;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

enum TASK_TRIGGER_TYPE
{
    TASK_TIME_TRIGGER_ONCE = 0,
    TASK_TIME_TRIGGER_DAILY = 1,
    TASK_TIME_TRIGGER_WEEKLY = 2,
    TASK_TIME_TRIGGER_MONTHLYDATE = 3,
    TASK_TIME_TRIGGER_MONTHLYDOW = 4,
    TASK_EVENT_TRIGGER_ON_IDLE = 5,
    TASK_EVENT_TRIGGER_AT_SYSTEMSTART = 6,
    TASK_EVENT_TRIGGER_AT_LOGON = 7,
}

struct DAILY
{
    ushort DaysInterval;
}

struct WEEKLY
{
    ushort WeeksInterval;
    ushort rgfDaysOfTheWeek;
}

struct MONTHLYDATE
{
    uint rgfDays;
    ushort rgfMonths;
}

struct MONTHLYDOW
{
    ushort wWhichWeek;
    ushort rgfDaysOfTheWeek;
    ushort rgfMonths;
}

struct TRIGGER_TYPE_UNION
{
    DAILY Daily;
    WEEKLY Weekly;
    MONTHLYDATE MonthlyDate;
    MONTHLYDOW MonthlyDOW;
}

struct TASK_TRIGGER
{
    ushort cbTriggerSize;
    ushort Reserved1;
    ushort wBeginYear;
    ushort wBeginMonth;
    ushort wBeginDay;
    ushort wEndYear;
    ushort wEndMonth;
    ushort wEndDay;
    ushort wStartHour;
    ushort wStartMinute;
    uint MinutesDuration;
    uint MinutesInterval;
    uint rgFlags;
    TASK_TRIGGER_TYPE TriggerType;
    TRIGGER_TYPE_UNION Type;
    ushort Reserved2;
    ushort wRandomMinutesInterval;
}

const GUID IID_ITaskTrigger = {0x148BD52B, 0xA2AB, 0x11CE, [0xB1, 0x1F, 0x00, 0xAA, 0x00, 0x53, 0x05, 0x03]};
@GUID(0x148BD52B, 0xA2AB, 0x11CE, [0xB1, 0x1F, 0x00, 0xAA, 0x00, 0x53, 0x05, 0x03]);
interface ITaskTrigger : IUnknown
{
    HRESULT SetTrigger(const(TASK_TRIGGER)* pTrigger);
    HRESULT GetTrigger(TASK_TRIGGER* pTrigger);
    HRESULT GetTriggerString(ushort** ppwszTrigger);
}

const GUID IID_IScheduledWorkItem = {0xA6B952F0, 0xA4B1, 0x11D0, [0x99, 0x7D, 0x00, 0xAA, 0x00, 0x68, 0x87, 0xEC]};
@GUID(0xA6B952F0, 0xA4B1, 0x11D0, [0x99, 0x7D, 0x00, 0xAA, 0x00, 0x68, 0x87, 0xEC]);
interface IScheduledWorkItem : IUnknown
{
    HRESULT CreateTrigger(ushort* piNewTrigger, ITaskTrigger* ppTrigger);
    HRESULT DeleteTrigger(ushort iTrigger);
    HRESULT GetTriggerCount(ushort* pwCount);
    HRESULT GetTrigger(ushort iTrigger, ITaskTrigger* ppTrigger);
    HRESULT GetTriggerString(ushort iTrigger, ushort** ppwszTrigger);
    HRESULT GetRunTimes(const(SYSTEMTIME)* pstBegin, const(SYSTEMTIME)* pstEnd, ushort* pCount, SYSTEMTIME** rgstTaskTimes);
    HRESULT GetNextRunTime(SYSTEMTIME* pstNextRun);
    HRESULT SetIdleWait(ushort wIdleMinutes, ushort wDeadlineMinutes);
    HRESULT GetIdleWait(ushort* pwIdleMinutes, ushort* pwDeadlineMinutes);
    HRESULT Run();
    HRESULT Terminate();
    HRESULT EditWorkItem(HWND hParent, uint dwReserved);
    HRESULT GetMostRecentRunTime(SYSTEMTIME* pstLastRun);
    HRESULT GetStatus(int* phrStatus);
    HRESULT GetExitCode(uint* pdwExitCode);
    HRESULT SetComment(const(wchar)* pwszComment);
    HRESULT GetComment(ushort** ppwszComment);
    HRESULT SetCreator(const(wchar)* pwszCreator);
    HRESULT GetCreator(ushort** ppwszCreator);
    HRESULT SetWorkItemData(ushort cbData, ubyte* rgbData);
    HRESULT GetWorkItemData(ushort* pcbData, ubyte** prgbData);
    HRESULT SetErrorRetryCount(ushort wRetryCount);
    HRESULT GetErrorRetryCount(ushort* pwRetryCount);
    HRESULT SetErrorRetryInterval(ushort wRetryInterval);
    HRESULT GetErrorRetryInterval(ushort* pwRetryInterval);
    HRESULT SetFlags(uint dwFlags);
    HRESULT GetFlags(uint* pdwFlags);
    HRESULT SetAccountInformation(const(wchar)* pwszAccountName, const(wchar)* pwszPassword);
    HRESULT GetAccountInformation(ushort** ppwszAccountName);
}

const GUID IID_ITask = {0x148BD524, 0xA2AB, 0x11CE, [0xB1, 0x1F, 0x00, 0xAA, 0x00, 0x53, 0x05, 0x03]};
@GUID(0x148BD524, 0xA2AB, 0x11CE, [0xB1, 0x1F, 0x00, 0xAA, 0x00, 0x53, 0x05, 0x03]);
interface ITask : IScheduledWorkItem
{
    HRESULT SetApplicationName(const(wchar)* pwszApplicationName);
    HRESULT GetApplicationName(ushort** ppwszApplicationName);
    HRESULT SetParameters(const(wchar)* pwszParameters);
    HRESULT GetParameters(ushort** ppwszParameters);
    HRESULT SetWorkingDirectory(const(wchar)* pwszWorkingDirectory);
    HRESULT GetWorkingDirectory(ushort** ppwszWorkingDirectory);
    HRESULT SetPriority(uint dwPriority);
    HRESULT GetPriority(uint* pdwPriority);
    HRESULT SetTaskFlags(uint dwFlags);
    HRESULT GetTaskFlags(uint* pdwFlags);
    HRESULT SetMaxRunTime(uint dwMaxRunTimeMS);
    HRESULT GetMaxRunTime(uint* pdwMaxRunTimeMS);
}

const GUID IID_IEnumWorkItems = {0x148BD528, 0xA2AB, 0x11CE, [0xB1, 0x1F, 0x00, 0xAA, 0x00, 0x53, 0x05, 0x03]};
@GUID(0x148BD528, 0xA2AB, 0x11CE, [0xB1, 0x1F, 0x00, 0xAA, 0x00, 0x53, 0x05, 0x03]);
interface IEnumWorkItems : IUnknown
{
    HRESULT Next(uint celt, ushort*** rgpwszNames, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumWorkItems* ppEnumWorkItems);
}

const GUID IID_ITaskScheduler = {0x148BD527, 0xA2AB, 0x11CE, [0xB1, 0x1F, 0x00, 0xAA, 0x00, 0x53, 0x05, 0x03]};
@GUID(0x148BD527, 0xA2AB, 0x11CE, [0xB1, 0x1F, 0x00, 0xAA, 0x00, 0x53, 0x05, 0x03]);
interface ITaskScheduler : IUnknown
{
    HRESULT SetTargetComputer(const(wchar)* pwszComputer);
    HRESULT GetTargetComputer(ushort** ppwszComputer);
    HRESULT Enum(IEnumWorkItems* ppEnumWorkItems);
    HRESULT Activate(const(wchar)* pwszName, const(Guid)* riid, IUnknown* ppUnk);
    HRESULT Delete(const(wchar)* pwszName);
    HRESULT NewWorkItem(const(wchar)* pwszTaskName, const(Guid)* rclsid, const(Guid)* riid, IUnknown* ppUnk);
    HRESULT AddWorkItem(const(wchar)* pwszTaskName, IScheduledWorkItem pWorkItem);
    HRESULT IsOfType(const(wchar)* pwszName, const(Guid)* riid);
}

enum TASKPAGE
{
    TASKPAGE_TASK = 0,
    TASKPAGE_SCHEDULE = 1,
    TASKPAGE_SETTINGS = 2,
}

const GUID IID_IProvideTaskPage = {0x4086658A, 0xCBBB, 0x11CF, [0xB6, 0x04, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x65]};
@GUID(0x4086658A, 0xCBBB, 0x11CF, [0xB6, 0x04, 0x00, 0xC0, 0x4F, 0xD8, 0xD5, 0x65]);
interface IProvideTaskPage : IUnknown
{
    HRESULT GetPage(TASKPAGE tpType, BOOL fPersistChanges, HPROPSHEETPAGE* phPage);
}

const GUID CLSID_TaskScheduler = {0x0F87369F, 0xA4E5, 0x4CFC, [0xBD, 0x3E, 0x73, 0xE6, 0x15, 0x45, 0x72, 0xDD]};
@GUID(0x0F87369F, 0xA4E5, 0x4CFC, [0xBD, 0x3E, 0x73, 0xE6, 0x15, 0x45, 0x72, 0xDD]);
struct TaskScheduler;

const GUID CLSID_TaskHandlerPS = {0xF2A69DB7, 0xDA2C, 0x4352, [0x90, 0x66, 0x86, 0xFE, 0xE6, 0xDA, 0xCA, 0xC9]};
@GUID(0xF2A69DB7, 0xDA2C, 0x4352, [0x90, 0x66, 0x86, 0xFE, 0xE6, 0xDA, 0xCA, 0xC9]);
struct TaskHandlerPS;

const GUID CLSID_TaskHandlerStatusPS = {0x9F15266D, 0xD7BA, 0x48F0, [0x93, 0xC1, 0xE6, 0x89, 0x5F, 0x6F, 0xE5, 0xAC]};
@GUID(0x9F15266D, 0xD7BA, 0x48F0, [0x93, 0xC1, 0xE6, 0x89, 0x5F, 0x6F, 0xE5, 0xAC]);
struct TaskHandlerStatusPS;

enum TASK_RUN_FLAGS
{
    TASK_RUN_NO_FLAGS = 0,
    TASK_RUN_AS_SELF = 1,
    TASK_RUN_IGNORE_CONSTRAINTS = 2,
    TASK_RUN_USE_SESSION_ID = 4,
    TASK_RUN_USER_SID = 8,
}

enum TASK_ENUM_FLAGS
{
    TASK_ENUM_HIDDEN = 1,
}

enum TASK_LOGON_TYPE
{
    TASK_LOGON_NONE = 0,
    TASK_LOGON_PASSWORD = 1,
    TASK_LOGON_S4U = 2,
    TASK_LOGON_INTERACTIVE_TOKEN = 3,
    TASK_LOGON_GROUP = 4,
    TASK_LOGON_SERVICE_ACCOUNT = 5,
    TASK_LOGON_INTERACTIVE_TOKEN_OR_PASSWORD = 6,
}

enum TASK_RUNLEVEL_TYPE
{
    TASK_RUNLEVEL_LUA = 0,
    TASK_RUNLEVEL_HIGHEST = 1,
}

enum TASK_PROCESSTOKENSID_TYPE
{
    TASK_PROCESSTOKENSID_NONE = 0,
    TASK_PROCESSTOKENSID_UNRESTRICTED = 1,
    TASK_PROCESSTOKENSID_DEFAULT = 2,
}

enum TASK_STATE
{
    TASK_STATE_UNKNOWN = 0,
    TASK_STATE_DISABLED = 1,
    TASK_STATE_QUEUED = 2,
    TASK_STATE_READY = 3,
    TASK_STATE_RUNNING = 4,
}

enum TASK_CREATION
{
    TASK_VALIDATE_ONLY = 1,
    TASK_CREATE = 2,
    TASK_UPDATE = 4,
    TASK_CREATE_OR_UPDATE = 6,
    TASK_DISABLE = 8,
    TASK_DONT_ADD_PRINCIPAL_ACE = 16,
    TASK_IGNORE_REGISTRATION_TRIGGERS = 32,
}

enum TASK_TRIGGER_TYPE2
{
    TASK_TRIGGER_EVENT = 0,
    TASK_TRIGGER_TIME = 1,
    TASK_TRIGGER_DAILY = 2,
    TASK_TRIGGER_WEEKLY = 3,
    TASK_TRIGGER_MONTHLY = 4,
    TASK_TRIGGER_MONTHLYDOW = 5,
    TASK_TRIGGER_IDLE = 6,
    TASK_TRIGGER_REGISTRATION = 7,
    TASK_TRIGGER_BOOT = 8,
    TASK_TRIGGER_LOGON = 9,
    TASK_TRIGGER_SESSION_STATE_CHANGE = 11,
    TASK_TRIGGER_CUSTOM_TRIGGER_01 = 12,
}

enum TASK_SESSION_STATE_CHANGE_TYPE
{
    TASK_CONSOLE_CONNECT = 1,
    TASK_CONSOLE_DISCONNECT = 2,
    TASK_REMOTE_CONNECT = 3,
    TASK_REMOTE_DISCONNECT = 4,
    TASK_SESSION_LOCK = 7,
    TASK_SESSION_UNLOCK = 8,
}

enum TASK_ACTION_TYPE
{
    TASK_ACTION_EXEC = 0,
    TASK_ACTION_COM_HANDLER = 5,
    TASK_ACTION_SEND_EMAIL = 6,
    TASK_ACTION_SHOW_MESSAGE = 7,
}

enum TASK_INSTANCES_POLICY
{
    TASK_INSTANCES_PARALLEL = 0,
    TASK_INSTANCES_QUEUE = 1,
    TASK_INSTANCES_IGNORE_NEW = 2,
    TASK_INSTANCES_STOP_EXISTING = 3,
}

enum TASK_COMPATIBILITY
{
    TASK_COMPATIBILITY_AT = 0,
    TASK_COMPATIBILITY_V1 = 1,
    TASK_COMPATIBILITY_V2 = 2,
    TASK_COMPATIBILITY_V2_1 = 3,
    TASK_COMPATIBILITY_V2_2 = 4,
    TASK_COMPATIBILITY_V2_3 = 5,
    TASK_COMPATIBILITY_V2_4 = 6,
}

const GUID IID_ITaskFolderCollection = {0x79184A66, 0x8664, 0x423F, [0x97, 0xF1, 0x63, 0x73, 0x56, 0xA5, 0xD8, 0x12]};
@GUID(0x79184A66, 0x8664, 0x423F, [0x97, 0xF1, 0x63, 0x73, 0x56, 0xA5, 0xD8, 0x12]);
interface ITaskFolderCollection : IDispatch
{
    HRESULT get_Count(int* pCount);
    HRESULT get_Item(VARIANT index, ITaskFolder* ppFolder);
    HRESULT get__NewEnum(IUnknown* ppEnum);
}

const GUID IID_ITaskService = {0x2FABA4C7, 0x4DA9, 0x4013, [0x96, 0x97, 0x20, 0xCC, 0x3F, 0xD4, 0x0F, 0x85]};
@GUID(0x2FABA4C7, 0x4DA9, 0x4013, [0x96, 0x97, 0x20, 0xCC, 0x3F, 0xD4, 0x0F, 0x85]);
interface ITaskService : IDispatch
{
    HRESULT GetFolder(BSTR path, ITaskFolder* ppFolder);
    HRESULT GetRunningTasks(int flags, IRunningTaskCollection* ppRunningTasks);
    HRESULT NewTask(uint flags, ITaskDefinition* ppDefinition);
    HRESULT Connect(VARIANT serverName, VARIANT user, VARIANT domain, VARIANT password);
    HRESULT get_Connected(short* pConnected);
    HRESULT get_TargetServer(BSTR* pServer);
    HRESULT get_ConnectedUser(BSTR* pUser);
    HRESULT get_ConnectedDomain(BSTR* pDomain);
    HRESULT get_HighestVersion(uint* pVersion);
}

const GUID IID_ITaskHandler = {0x839D7762, 0x5121, 0x4009, [0x92, 0x34, 0x4F, 0x0D, 0x19, 0x39, 0x4F, 0x04]};
@GUID(0x839D7762, 0x5121, 0x4009, [0x92, 0x34, 0x4F, 0x0D, 0x19, 0x39, 0x4F, 0x04]);
interface ITaskHandler : IUnknown
{
    HRESULT Start(IUnknown pHandlerServices, BSTR data);
    HRESULT Stop(int* pRetCode);
    HRESULT Pause();
    HRESULT Resume();
}

const GUID IID_ITaskHandlerStatus = {0xEAEC7A8F, 0x27A0, 0x4DDC, [0x86, 0x75, 0x14, 0x72, 0x6A, 0x01, 0xA3, 0x8A]};
@GUID(0xEAEC7A8F, 0x27A0, 0x4DDC, [0x86, 0x75, 0x14, 0x72, 0x6A, 0x01, 0xA3, 0x8A]);
interface ITaskHandlerStatus : IUnknown
{
    HRESULT UpdateStatus(short percentComplete, BSTR statusMessage);
    HRESULT TaskCompleted(HRESULT taskErrCode);
}

const GUID IID_ITaskVariables = {0x3E4C9351, 0xD966, 0x4B8B, [0xBB, 0x87, 0xCE, 0xBA, 0x68, 0xBB, 0x01, 0x07]};
@GUID(0x3E4C9351, 0xD966, 0x4B8B, [0xBB, 0x87, 0xCE, 0xBA, 0x68, 0xBB, 0x01, 0x07]);
interface ITaskVariables : IUnknown
{
    HRESULT GetInput(BSTR* pInput);
    HRESULT SetOutput(BSTR input);
    HRESULT GetContext(BSTR* pContext);
}

const GUID IID_ITaskNamedValuePair = {0x39038068, 0x2B46, 0x4AFD, [0x86, 0x62, 0x7B, 0xB6, 0xF8, 0x68, 0xD2, 0x21]};
@GUID(0x39038068, 0x2B46, 0x4AFD, [0x86, 0x62, 0x7B, 0xB6, 0xF8, 0x68, 0xD2, 0x21]);
interface ITaskNamedValuePair : IDispatch
{
    HRESULT get_Name(BSTR* pName);
    HRESULT put_Name(BSTR name);
    HRESULT get_Value(BSTR* pValue);
    HRESULT put_Value(BSTR value);
}

const GUID IID_ITaskNamedValueCollection = {0xB4EF826B, 0x63C3, 0x46E4, [0xA5, 0x04, 0xEF, 0x69, 0xE4, 0xF7, 0xEA, 0x4D]};
@GUID(0xB4EF826B, 0x63C3, 0x46E4, [0xA5, 0x04, 0xEF, 0x69, 0xE4, 0xF7, 0xEA, 0x4D]);
interface ITaskNamedValueCollection : IDispatch
{
    HRESULT get_Count(int* pCount);
    HRESULT get_Item(int index, ITaskNamedValuePair* ppPair);
    HRESULT get__NewEnum(IUnknown* ppEnum);
    HRESULT Create(BSTR name, BSTR value, ITaskNamedValuePair* ppPair);
    HRESULT Remove(int index);
    HRESULT Clear();
}

const GUID IID_IRunningTask = {0x653758FB, 0x7B9A, 0x4F1E, [0xA4, 0x71, 0xBE, 0xEB, 0x8E, 0x9B, 0x83, 0x4E]};
@GUID(0x653758FB, 0x7B9A, 0x4F1E, [0xA4, 0x71, 0xBE, 0xEB, 0x8E, 0x9B, 0x83, 0x4E]);
interface IRunningTask : IDispatch
{
    HRESULT get_Name(BSTR* pName);
    HRESULT get_InstanceGuid(BSTR* pGuid);
    HRESULT get_Path(BSTR* pPath);
    HRESULT get_State(TASK_STATE* pState);
    HRESULT get_CurrentAction(BSTR* pName);
    HRESULT Stop();
    HRESULT Refresh();
    HRESULT get_EnginePID(uint* pPID);
}

const GUID IID_IRunningTaskCollection = {0x6A67614B, 0x6828, 0x4FEC, [0xAA, 0x54, 0x6D, 0x52, 0xE8, 0xF1, 0xF2, 0xDB]};
@GUID(0x6A67614B, 0x6828, 0x4FEC, [0xAA, 0x54, 0x6D, 0x52, 0xE8, 0xF1, 0xF2, 0xDB]);
interface IRunningTaskCollection : IDispatch
{
    HRESULT get_Count(int* pCount);
    HRESULT get_Item(VARIANT index, IRunningTask* ppRunningTask);
    HRESULT get__NewEnum(IUnknown* ppEnum);
}

const GUID IID_IRegisteredTask = {0x9C86F320, 0xDEE3, 0x4DD1, [0xB9, 0x72, 0xA3, 0x03, 0xF2, 0x6B, 0x06, 0x1E]};
@GUID(0x9C86F320, 0xDEE3, 0x4DD1, [0xB9, 0x72, 0xA3, 0x03, 0xF2, 0x6B, 0x06, 0x1E]);
interface IRegisteredTask : IDispatch
{
    HRESULT get_Name(BSTR* pName);
    HRESULT get_Path(BSTR* pPath);
    HRESULT get_State(TASK_STATE* pState);
    HRESULT get_Enabled(short* pEnabled);
    HRESULT put_Enabled(short enabled);
    HRESULT Run(VARIANT params, IRunningTask* ppRunningTask);
    HRESULT RunEx(VARIANT params, int flags, int sessionID, BSTR user, IRunningTask* ppRunningTask);
    HRESULT GetInstances(int flags, IRunningTaskCollection* ppRunningTasks);
    HRESULT get_LastRunTime(double* pLastRunTime);
    HRESULT get_LastTaskResult(int* pLastTaskResult);
    HRESULT get_NumberOfMissedRuns(int* pNumberOfMissedRuns);
    HRESULT get_NextRunTime(double* pNextRunTime);
    HRESULT get_Definition(ITaskDefinition* ppDefinition);
    HRESULT get_Xml(BSTR* pXml);
    HRESULT GetSecurityDescriptor(int securityInformation, BSTR* pSddl);
    HRESULT SetSecurityDescriptor(BSTR sddl, int flags);
    HRESULT Stop(int flags);
    HRESULT GetRunTimes(const(SYSTEMTIME)* pstStart, const(SYSTEMTIME)* pstEnd, uint* pCount, SYSTEMTIME** pRunTimes);
}

const GUID IID_ITrigger = {0x09941815, 0xEA89, 0x4B5B, [0x89, 0xE0, 0x2A, 0x77, 0x38, 0x01, 0xFA, 0xC3]};
@GUID(0x09941815, 0xEA89, 0x4B5B, [0x89, 0xE0, 0x2A, 0x77, 0x38, 0x01, 0xFA, 0xC3]);
interface ITrigger : IDispatch
{
    HRESULT get_Type(TASK_TRIGGER_TYPE2* pType);
    HRESULT get_Id(BSTR* pId);
    HRESULT put_Id(BSTR id);
    HRESULT get_Repetition(IRepetitionPattern* ppRepeat);
    HRESULT put_Repetition(IRepetitionPattern pRepeat);
    HRESULT get_ExecutionTimeLimit(BSTR* pTimeLimit);
    HRESULT put_ExecutionTimeLimit(BSTR timelimit);
    HRESULT get_StartBoundary(BSTR* pStart);
    HRESULT put_StartBoundary(BSTR start);
    HRESULT get_EndBoundary(BSTR* pEnd);
    HRESULT put_EndBoundary(BSTR end);
    HRESULT get_Enabled(short* pEnabled);
    HRESULT put_Enabled(short enabled);
}

const GUID IID_IIdleTrigger = {0xD537D2B0, 0x9FB3, 0x4D34, [0x97, 0x39, 0x1F, 0xF5, 0xCE, 0x7B, 0x1E, 0xF3]};
@GUID(0xD537D2B0, 0x9FB3, 0x4D34, [0x97, 0x39, 0x1F, 0xF5, 0xCE, 0x7B, 0x1E, 0xF3]);
interface IIdleTrigger : ITrigger
{
}

const GUID IID_ILogonTrigger = {0x72DADE38, 0xFAE4, 0x4B3E, [0xBA, 0xF4, 0x5D, 0x00, 0x9A, 0xF0, 0x2B, 0x1C]};
@GUID(0x72DADE38, 0xFAE4, 0x4B3E, [0xBA, 0xF4, 0x5D, 0x00, 0x9A, 0xF0, 0x2B, 0x1C]);
interface ILogonTrigger : ITrigger
{
    HRESULT get_Delay(BSTR* pDelay);
    HRESULT put_Delay(BSTR delay);
    HRESULT get_UserId(BSTR* pUser);
    HRESULT put_UserId(BSTR user);
}

const GUID IID_ISessionStateChangeTrigger = {0x754DA71B, 0x4385, 0x4475, [0x9D, 0xD9, 0x59, 0x82, 0x94, 0xFA, 0x36, 0x41]};
@GUID(0x754DA71B, 0x4385, 0x4475, [0x9D, 0xD9, 0x59, 0x82, 0x94, 0xFA, 0x36, 0x41]);
interface ISessionStateChangeTrigger : ITrigger
{
    HRESULT get_Delay(BSTR* pDelay);
    HRESULT put_Delay(BSTR delay);
    HRESULT get_UserId(BSTR* pUser);
    HRESULT put_UserId(BSTR user);
    HRESULT get_StateChange(TASK_SESSION_STATE_CHANGE_TYPE* pType);
    HRESULT put_StateChange(TASK_SESSION_STATE_CHANGE_TYPE type);
}

const GUID IID_IEventTrigger = {0xD45B0167, 0x9653, 0x4EEF, [0xB9, 0x4F, 0x07, 0x32, 0xCA, 0x7A, 0xF2, 0x51]};
@GUID(0xD45B0167, 0x9653, 0x4EEF, [0xB9, 0x4F, 0x07, 0x32, 0xCA, 0x7A, 0xF2, 0x51]);
interface IEventTrigger : ITrigger
{
    HRESULT get_Subscription(BSTR* pQuery);
    HRESULT put_Subscription(BSTR query);
    HRESULT get_Delay(BSTR* pDelay);
    HRESULT put_Delay(BSTR delay);
    HRESULT get_ValueQueries(ITaskNamedValueCollection* ppNamedXPaths);
    HRESULT put_ValueQueries(ITaskNamedValueCollection pNamedXPaths);
}

const GUID IID_ITimeTrigger = {0xB45747E0, 0xEBA7, 0x4276, [0x9F, 0x29, 0x85, 0xC5, 0xBB, 0x30, 0x00, 0x06]};
@GUID(0xB45747E0, 0xEBA7, 0x4276, [0x9F, 0x29, 0x85, 0xC5, 0xBB, 0x30, 0x00, 0x06]);
interface ITimeTrigger : ITrigger
{
    HRESULT get_RandomDelay(BSTR* pRandomDelay);
    HRESULT put_RandomDelay(BSTR randomDelay);
}

const GUID IID_IDailyTrigger = {0x126C5CD8, 0xB288, 0x41D5, [0x8D, 0xBF, 0xE4, 0x91, 0x44, 0x6A, 0xDC, 0x5C]};
@GUID(0x126C5CD8, 0xB288, 0x41D5, [0x8D, 0xBF, 0xE4, 0x91, 0x44, 0x6A, 0xDC, 0x5C]);
interface IDailyTrigger : ITrigger
{
    HRESULT get_DaysInterval(short* pDays);
    HRESULT put_DaysInterval(short days);
    HRESULT get_RandomDelay(BSTR* pRandomDelay);
    HRESULT put_RandomDelay(BSTR randomDelay);
}

const GUID IID_IWeeklyTrigger = {0x5038FC98, 0x82FF, 0x436D, [0x87, 0x28, 0xA5, 0x12, 0xA5, 0x7C, 0x9D, 0xC1]};
@GUID(0x5038FC98, 0x82FF, 0x436D, [0x87, 0x28, 0xA5, 0x12, 0xA5, 0x7C, 0x9D, 0xC1]);
interface IWeeklyTrigger : ITrigger
{
    HRESULT get_DaysOfWeek(short* pDays);
    HRESULT put_DaysOfWeek(short days);
    HRESULT get_WeeksInterval(short* pWeeks);
    HRESULT put_WeeksInterval(short weeks);
    HRESULT get_RandomDelay(BSTR* pRandomDelay);
    HRESULT put_RandomDelay(BSTR randomDelay);
}

const GUID IID_IMonthlyTrigger = {0x97C45EF1, 0x6B02, 0x4A1A, [0x9C, 0x0E, 0x1E, 0xBF, 0xBA, 0x15, 0x00, 0xAC]};
@GUID(0x97C45EF1, 0x6B02, 0x4A1A, [0x9C, 0x0E, 0x1E, 0xBF, 0xBA, 0x15, 0x00, 0xAC]);
interface IMonthlyTrigger : ITrigger
{
    HRESULT get_DaysOfMonth(int* pDays);
    HRESULT put_DaysOfMonth(int days);
    HRESULT get_MonthsOfYear(short* pMonths);
    HRESULT put_MonthsOfYear(short months);
    HRESULT get_RunOnLastDayOfMonth(short* pLastDay);
    HRESULT put_RunOnLastDayOfMonth(short lastDay);
    HRESULT get_RandomDelay(BSTR* pRandomDelay);
    HRESULT put_RandomDelay(BSTR randomDelay);
}

const GUID IID_IMonthlyDOWTrigger = {0x77D025A3, 0x90FA, 0x43AA, [0xB5, 0x2E, 0xCD, 0xA5, 0x49, 0x9B, 0x94, 0x6A]};
@GUID(0x77D025A3, 0x90FA, 0x43AA, [0xB5, 0x2E, 0xCD, 0xA5, 0x49, 0x9B, 0x94, 0x6A]);
interface IMonthlyDOWTrigger : ITrigger
{
    HRESULT get_DaysOfWeek(short* pDays);
    HRESULT put_DaysOfWeek(short days);
    HRESULT get_WeeksOfMonth(short* pWeeks);
    HRESULT put_WeeksOfMonth(short weeks);
    HRESULT get_MonthsOfYear(short* pMonths);
    HRESULT put_MonthsOfYear(short months);
    HRESULT get_RunOnLastWeekOfMonth(short* pLastWeek);
    HRESULT put_RunOnLastWeekOfMonth(short lastWeek);
    HRESULT get_RandomDelay(BSTR* pRandomDelay);
    HRESULT put_RandomDelay(BSTR randomDelay);
}

const GUID IID_IBootTrigger = {0x2A9C35DA, 0xD357, 0x41F4, [0xBB, 0xC1, 0x20, 0x7A, 0xC1, 0xB1, 0xF3, 0xCB]};
@GUID(0x2A9C35DA, 0xD357, 0x41F4, [0xBB, 0xC1, 0x20, 0x7A, 0xC1, 0xB1, 0xF3, 0xCB]);
interface IBootTrigger : ITrigger
{
    HRESULT get_Delay(BSTR* pDelay);
    HRESULT put_Delay(BSTR delay);
}

const GUID IID_IRegistrationTrigger = {0x4C8FEC3A, 0xC218, 0x4E0C, [0xB2, 0x3D, 0x62, 0x90, 0x24, 0xDB, 0x91, 0xA2]};
@GUID(0x4C8FEC3A, 0xC218, 0x4E0C, [0xB2, 0x3D, 0x62, 0x90, 0x24, 0xDB, 0x91, 0xA2]);
interface IRegistrationTrigger : ITrigger
{
    HRESULT get_Delay(BSTR* pDelay);
    HRESULT put_Delay(BSTR delay);
}

const GUID IID_IAction = {0xBAE54997, 0x48B1, 0x4CBE, [0x99, 0x65, 0xD6, 0xBE, 0x26, 0x3E, 0xBE, 0xA4]};
@GUID(0xBAE54997, 0x48B1, 0x4CBE, [0x99, 0x65, 0xD6, 0xBE, 0x26, 0x3E, 0xBE, 0xA4]);
interface IAction : IDispatch
{
    HRESULT get_Id(BSTR* pId);
    HRESULT put_Id(BSTR Id);
    HRESULT get_Type(TASK_ACTION_TYPE* pType);
}

const GUID IID_IExecAction = {0x4C3D624D, 0xFD6B, 0x49A3, [0xB9, 0xB7, 0x09, 0xCB, 0x3C, 0xD3, 0xF0, 0x47]};
@GUID(0x4C3D624D, 0xFD6B, 0x49A3, [0xB9, 0xB7, 0x09, 0xCB, 0x3C, 0xD3, 0xF0, 0x47]);
interface IExecAction : IAction
{
    HRESULT get_Path(BSTR* pPath);
    HRESULT put_Path(BSTR path);
    HRESULT get_Arguments(BSTR* pArgument);
    HRESULT put_Arguments(BSTR argument);
    HRESULT get_WorkingDirectory(BSTR* pWorkingDirectory);
    HRESULT put_WorkingDirectory(BSTR workingDirectory);
}

const GUID IID_IExecAction2 = {0xF2A82542, 0xBDA5, 0x4E6B, [0x91, 0x43, 0xE2, 0xBF, 0x4F, 0x89, 0x87, 0xB6]};
@GUID(0xF2A82542, 0xBDA5, 0x4E6B, [0x91, 0x43, 0xE2, 0xBF, 0x4F, 0x89, 0x87, 0xB6]);
interface IExecAction2 : IExecAction
{
    HRESULT get_HideAppWindow(short* pHideAppWindow);
    HRESULT put_HideAppWindow(short hideAppWindow);
}

const GUID IID_IShowMessageAction = {0x505E9E68, 0xAF89, 0x46B8, [0xA3, 0x0F, 0x56, 0x16, 0x2A, 0x83, 0xD5, 0x37]};
@GUID(0x505E9E68, 0xAF89, 0x46B8, [0xA3, 0x0F, 0x56, 0x16, 0x2A, 0x83, 0xD5, 0x37]);
interface IShowMessageAction : IAction
{
    HRESULT get_Title(BSTR* pTitle);
    HRESULT put_Title(BSTR title);
    HRESULT get_MessageBody(BSTR* pMessageBody);
    HRESULT put_MessageBody(BSTR messageBody);
}

const GUID IID_IComHandlerAction = {0x6D2FD252, 0x75C5, 0x4F66, [0x90, 0xBA, 0x2A, 0x7D, 0x8C, 0xC3, 0x03, 0x9F]};
@GUID(0x6D2FD252, 0x75C5, 0x4F66, [0x90, 0xBA, 0x2A, 0x7D, 0x8C, 0xC3, 0x03, 0x9F]);
interface IComHandlerAction : IAction
{
    HRESULT get_ClassId(BSTR* pClsid);
    HRESULT put_ClassId(BSTR clsid);
    HRESULT get_Data(BSTR* pData);
    HRESULT put_Data(BSTR data);
}

const GUID IID_IEmailAction = {0x10F62C64, 0x7E16, 0x4314, [0xA0, 0xC2, 0x0C, 0x36, 0x83, 0xF9, 0x9D, 0x40]};
@GUID(0x10F62C64, 0x7E16, 0x4314, [0xA0, 0xC2, 0x0C, 0x36, 0x83, 0xF9, 0x9D, 0x40]);
interface IEmailAction : IAction
{
    HRESULT get_Server(BSTR* pServer);
    HRESULT put_Server(BSTR server);
    HRESULT get_Subject(BSTR* pSubject);
    HRESULT put_Subject(BSTR subject);
    HRESULT get_To(BSTR* pTo);
    HRESULT put_To(BSTR to);
    HRESULT get_Cc(BSTR* pCc);
    HRESULT put_Cc(BSTR cc);
    HRESULT get_Bcc(BSTR* pBcc);
    HRESULT put_Bcc(BSTR bcc);
    HRESULT get_ReplyTo(BSTR* pReplyTo);
    HRESULT put_ReplyTo(BSTR replyTo);
    HRESULT get_From(BSTR* pFrom);
    HRESULT put_From(BSTR from);
    HRESULT get_HeaderFields(ITaskNamedValueCollection* ppHeaderFields);
    HRESULT put_HeaderFields(ITaskNamedValueCollection pHeaderFields);
    HRESULT get_Body(BSTR* pBody);
    HRESULT put_Body(BSTR body);
    HRESULT get_Attachments(SAFEARRAY** pAttachements);
    HRESULT put_Attachments(SAFEARRAY* pAttachements);
}

const GUID IID_ITriggerCollection = {0x85DF5081, 0x1B24, 0x4F32, [0x87, 0x8A, 0xD9, 0xD1, 0x4D, 0xF4, 0xCB, 0x77]};
@GUID(0x85DF5081, 0x1B24, 0x4F32, [0x87, 0x8A, 0xD9, 0xD1, 0x4D, 0xF4, 0xCB, 0x77]);
interface ITriggerCollection : IDispatch
{
    HRESULT get_Count(int* pCount);
    HRESULT get_Item(int index, ITrigger* ppTrigger);
    HRESULT get__NewEnum(IUnknown* ppEnum);
    HRESULT Create(TASK_TRIGGER_TYPE2 type, ITrigger* ppTrigger);
    HRESULT Remove(VARIANT index);
    HRESULT Clear();
}

const GUID IID_IActionCollection = {0x02820E19, 0x7B98, 0x4ED2, [0xB2, 0xE8, 0xFD, 0xCC, 0xCE, 0xFF, 0x61, 0x9B]};
@GUID(0x02820E19, 0x7B98, 0x4ED2, [0xB2, 0xE8, 0xFD, 0xCC, 0xCE, 0xFF, 0x61, 0x9B]);
interface IActionCollection : IDispatch
{
    HRESULT get_Count(int* pCount);
    HRESULT get_Item(int index, IAction* ppAction);
    HRESULT get__NewEnum(IUnknown* ppEnum);
    HRESULT get_XmlText(BSTR* pText);
    HRESULT put_XmlText(BSTR text);
    HRESULT Create(TASK_ACTION_TYPE type, IAction* ppAction);
    HRESULT Remove(VARIANT index);
    HRESULT Clear();
    HRESULT get_Context(BSTR* pContext);
    HRESULT put_Context(BSTR context);
}

const GUID IID_IPrincipal = {0xD98D51E5, 0xC9B4, 0x496A, [0xA9, 0xC1, 0x18, 0x98, 0x02, 0x61, 0xCF, 0x0F]};
@GUID(0xD98D51E5, 0xC9B4, 0x496A, [0xA9, 0xC1, 0x18, 0x98, 0x02, 0x61, 0xCF, 0x0F]);
interface IPrincipal : IDispatch
{
    HRESULT get_Id(BSTR* pId);
    HRESULT put_Id(BSTR Id);
    HRESULT get_DisplayName(BSTR* pName);
    HRESULT put_DisplayName(BSTR name);
    HRESULT get_UserId(BSTR* pUser);
    HRESULT put_UserId(BSTR user);
    HRESULT get_LogonType(TASK_LOGON_TYPE* pLogon);
    HRESULT put_LogonType(TASK_LOGON_TYPE logon);
    HRESULT get_GroupId(BSTR* pGroup);
    HRESULT put_GroupId(BSTR group);
    HRESULT get_RunLevel(TASK_RUNLEVEL_TYPE* pRunLevel);
    HRESULT put_RunLevel(TASK_RUNLEVEL_TYPE runLevel);
}

const GUID IID_IPrincipal2 = {0x248919AE, 0xE345, 0x4A6D, [0x8A, 0xEB, 0xE0, 0xD3, 0x16, 0x5C, 0x90, 0x4E]};
@GUID(0x248919AE, 0xE345, 0x4A6D, [0x8A, 0xEB, 0xE0, 0xD3, 0x16, 0x5C, 0x90, 0x4E]);
interface IPrincipal2 : IDispatch
{
    HRESULT get_ProcessTokenSidType(TASK_PROCESSTOKENSID_TYPE* pProcessTokenSidType);
    HRESULT put_ProcessTokenSidType(TASK_PROCESSTOKENSID_TYPE processTokenSidType);
    HRESULT get_RequiredPrivilegeCount(int* pCount);
    HRESULT get_RequiredPrivilege(int index, BSTR* pPrivilege);
    HRESULT AddRequiredPrivilege(BSTR privilege);
}

const GUID IID_IRegistrationInfo = {0x416D8B73, 0xCB41, 0x4EA1, [0x80, 0x5C, 0x9B, 0xE9, 0xA5, 0xAC, 0x4A, 0x74]};
@GUID(0x416D8B73, 0xCB41, 0x4EA1, [0x80, 0x5C, 0x9B, 0xE9, 0xA5, 0xAC, 0x4A, 0x74]);
interface IRegistrationInfo : IDispatch
{
    HRESULT get_Description(BSTR* pDescription);
    HRESULT put_Description(BSTR description);
    HRESULT get_Author(BSTR* pAuthor);
    HRESULT put_Author(BSTR author);
    HRESULT get_Version(BSTR* pVersion);
    HRESULT put_Version(BSTR version);
    HRESULT get_Date(BSTR* pDate);
    HRESULT put_Date(BSTR date);
    HRESULT get_Documentation(BSTR* pDocumentation);
    HRESULT put_Documentation(BSTR documentation);
    HRESULT get_XmlText(BSTR* pText);
    HRESULT put_XmlText(BSTR text);
    HRESULT get_URI(BSTR* pUri);
    HRESULT put_URI(BSTR uri);
    HRESULT get_SecurityDescriptor(VARIANT* pSddl);
    HRESULT put_SecurityDescriptor(VARIANT sddl);
    HRESULT get_Source(BSTR* pSource);
    HRESULT put_Source(BSTR source);
}

const GUID IID_ITaskDefinition = {0xF5BC8FC5, 0x536D, 0x4F77, [0xB8, 0x52, 0xFB, 0xC1, 0x35, 0x6F, 0xDE, 0xB6]};
@GUID(0xF5BC8FC5, 0x536D, 0x4F77, [0xB8, 0x52, 0xFB, 0xC1, 0x35, 0x6F, 0xDE, 0xB6]);
interface ITaskDefinition : IDispatch
{
    HRESULT get_RegistrationInfo(IRegistrationInfo* ppRegistrationInfo);
    HRESULT put_RegistrationInfo(IRegistrationInfo pRegistrationInfo);
    HRESULT get_Triggers(ITriggerCollection* ppTriggers);
    HRESULT put_Triggers(ITriggerCollection pTriggers);
    HRESULT get_Settings(ITaskSettings* ppSettings);
    HRESULT put_Settings(ITaskSettings pSettings);
    HRESULT get_Data(BSTR* pData);
    HRESULT put_Data(BSTR data);
    HRESULT get_Principal(IPrincipal* ppPrincipal);
    HRESULT put_Principal(IPrincipal pPrincipal);
    HRESULT get_Actions(IActionCollection* ppActions);
    HRESULT put_Actions(IActionCollection pActions);
    HRESULT get_XmlText(BSTR* pXml);
    HRESULT put_XmlText(BSTR xml);
}

const GUID IID_ITaskSettings = {0x8FD4711D, 0x2D02, 0x4C8C, [0x87, 0xE3, 0xEF, 0xF6, 0x99, 0xDE, 0x12, 0x7E]};
@GUID(0x8FD4711D, 0x2D02, 0x4C8C, [0x87, 0xE3, 0xEF, 0xF6, 0x99, 0xDE, 0x12, 0x7E]);
interface ITaskSettings : IDispatch
{
    HRESULT get_AllowDemandStart(short* pAllowDemandStart);
    HRESULT put_AllowDemandStart(short allowDemandStart);
    HRESULT get_RestartInterval(BSTR* pRestartInterval);
    HRESULT put_RestartInterval(BSTR restartInterval);
    HRESULT get_RestartCount(int* pRestartCount);
    HRESULT put_RestartCount(int restartCount);
    HRESULT get_MultipleInstances(TASK_INSTANCES_POLICY* pPolicy);
    HRESULT put_MultipleInstances(TASK_INSTANCES_POLICY policy);
    HRESULT get_StopIfGoingOnBatteries(short* pStopIfOnBatteries);
    HRESULT put_StopIfGoingOnBatteries(short stopIfOnBatteries);
    HRESULT get_DisallowStartIfOnBatteries(short* pDisallowStart);
    HRESULT put_DisallowStartIfOnBatteries(short disallowStart);
    HRESULT get_AllowHardTerminate(short* pAllowHardTerminate);
    HRESULT put_AllowHardTerminate(short allowHardTerminate);
    HRESULT get_StartWhenAvailable(short* pStartWhenAvailable);
    HRESULT put_StartWhenAvailable(short startWhenAvailable);
    HRESULT get_XmlText(BSTR* pText);
    HRESULT put_XmlText(BSTR text);
    HRESULT get_RunOnlyIfNetworkAvailable(short* pRunOnlyIfNetworkAvailable);
    HRESULT put_RunOnlyIfNetworkAvailable(short runOnlyIfNetworkAvailable);
    HRESULT get_ExecutionTimeLimit(BSTR* pExecutionTimeLimit);
    HRESULT put_ExecutionTimeLimit(BSTR executionTimeLimit);
    HRESULT get_Enabled(short* pEnabled);
    HRESULT put_Enabled(short enabled);
    HRESULT get_DeleteExpiredTaskAfter(BSTR* pExpirationDelay);
    HRESULT put_DeleteExpiredTaskAfter(BSTR expirationDelay);
    HRESULT get_Priority(int* pPriority);
    HRESULT put_Priority(int priority);
    HRESULT get_Compatibility(TASK_COMPATIBILITY* pCompatLevel);
    HRESULT put_Compatibility(TASK_COMPATIBILITY compatLevel);
    HRESULT get_Hidden(short* pHidden);
    HRESULT put_Hidden(short hidden);
    HRESULT get_IdleSettings(IIdleSettings* ppIdleSettings);
    HRESULT put_IdleSettings(IIdleSettings pIdleSettings);
    HRESULT get_RunOnlyIfIdle(short* pRunOnlyIfIdle);
    HRESULT put_RunOnlyIfIdle(short runOnlyIfIdle);
    HRESULT get_WakeToRun(short* pWake);
    HRESULT put_WakeToRun(short wake);
    HRESULT get_NetworkSettings(INetworkSettings* ppNetworkSettings);
    HRESULT put_NetworkSettings(INetworkSettings pNetworkSettings);
}

const GUID IID_ITaskSettings2 = {0x2C05C3F0, 0x6EED, 0x4C05, [0xA1, 0x5F, 0xED, 0x7D, 0x7A, 0x98, 0xA3, 0x69]};
@GUID(0x2C05C3F0, 0x6EED, 0x4C05, [0xA1, 0x5F, 0xED, 0x7D, 0x7A, 0x98, 0xA3, 0x69]);
interface ITaskSettings2 : IDispatch
{
    HRESULT get_DisallowStartOnRemoteAppSession(short* pDisallowStart);
    HRESULT put_DisallowStartOnRemoteAppSession(short disallowStart);
    HRESULT get_UseUnifiedSchedulingEngine(short* pUseUnifiedEngine);
    HRESULT put_UseUnifiedSchedulingEngine(short useUnifiedEngine);
}

const GUID IID_ITaskSettings3 = {0x0AD9D0D7, 0x0C7F, 0x4EBB, [0x9A, 0x5F, 0xD1, 0xC6, 0x48, 0xDC, 0xA5, 0x28]};
@GUID(0x0AD9D0D7, 0x0C7F, 0x4EBB, [0x9A, 0x5F, 0xD1, 0xC6, 0x48, 0xDC, 0xA5, 0x28]);
interface ITaskSettings3 : ITaskSettings
{
    HRESULT get_DisallowStartOnRemoteAppSession(short* pDisallowStart);
    HRESULT put_DisallowStartOnRemoteAppSession(short disallowStart);
    HRESULT get_UseUnifiedSchedulingEngine(short* pUseUnifiedEngine);
    HRESULT put_UseUnifiedSchedulingEngine(short useUnifiedEngine);
    HRESULT get_MaintenanceSettings(IMaintenanceSettings* ppMaintenanceSettings);
    HRESULT put_MaintenanceSettings(IMaintenanceSettings pMaintenanceSettings);
    HRESULT CreateMaintenanceSettings(IMaintenanceSettings* ppMaintenanceSettings);
    HRESULT get_Volatile(short* pVolatile);
    HRESULT put_Volatile(short Volatile);
}

const GUID IID_IMaintenanceSettings = {0xA6024FA8, 0x9652, 0x4ADB, [0xA6, 0xBF, 0x5C, 0xFC, 0xD8, 0x77, 0xA7, 0xBA]};
@GUID(0xA6024FA8, 0x9652, 0x4ADB, [0xA6, 0xBF, 0x5C, 0xFC, 0xD8, 0x77, 0xA7, 0xBA]);
interface IMaintenanceSettings : IDispatch
{
    HRESULT put_Period(BSTR value);
    HRESULT get_Period(BSTR* target);
    HRESULT put_Deadline(BSTR value);
    HRESULT get_Deadline(BSTR* target);
    HRESULT put_Exclusive(short value);
    HRESULT get_Exclusive(short* target);
}

const GUID IID_IRegisteredTaskCollection = {0x86627EB4, 0x42A7, 0x41E4, [0xA4, 0xD9, 0xAC, 0x33, 0xA7, 0x2F, 0x2D, 0x52]};
@GUID(0x86627EB4, 0x42A7, 0x41E4, [0xA4, 0xD9, 0xAC, 0x33, 0xA7, 0x2F, 0x2D, 0x52]);
interface IRegisteredTaskCollection : IDispatch
{
    HRESULT get_Count(int* pCount);
    HRESULT get_Item(VARIANT index, IRegisteredTask* ppRegisteredTask);
    HRESULT get__NewEnum(IUnknown* ppEnum);
}

const GUID IID_ITaskFolder = {0x8CFAC062, 0xA080, 0x4C15, [0x9A, 0x88, 0xAA, 0x7C, 0x2A, 0xF8, 0x0D, 0xFC]};
@GUID(0x8CFAC062, 0xA080, 0x4C15, [0x9A, 0x88, 0xAA, 0x7C, 0x2A, 0xF8, 0x0D, 0xFC]);
interface ITaskFolder : IDispatch
{
    HRESULT get_Name(BSTR* pName);
    HRESULT get_Path(BSTR* pPath);
    HRESULT GetFolder(BSTR path, ITaskFolder* ppFolder);
    HRESULT GetFolders(int flags, ITaskFolderCollection* ppFolders);
    HRESULT CreateFolder(BSTR subFolderName, VARIANT sddl, ITaskFolder* ppFolder);
    HRESULT DeleteFolder(BSTR subFolderName, int flags);
    HRESULT GetTask(BSTR path, IRegisteredTask* ppTask);
    HRESULT GetTasks(int flags, IRegisteredTaskCollection* ppTasks);
    HRESULT DeleteTask(BSTR name, int flags);
    HRESULT RegisterTask(BSTR path, BSTR xmlText, int flags, VARIANT userId, VARIANT password, TASK_LOGON_TYPE logonType, VARIANT sddl, IRegisteredTask* ppTask);
    HRESULT RegisterTaskDefinition(BSTR path, ITaskDefinition pDefinition, int flags, VARIANT userId, VARIANT password, TASK_LOGON_TYPE logonType, VARIANT sddl, IRegisteredTask* ppTask);
    HRESULT GetSecurityDescriptor(int securityInformation, BSTR* pSddl);
    HRESULT SetSecurityDescriptor(BSTR sddl, int flags);
}

const GUID IID_IIdleSettings = {0x84594461, 0x0053, 0x4342, [0xA8, 0xFD, 0x08, 0x8F, 0xAB, 0xF1, 0x1F, 0x32]};
@GUID(0x84594461, 0x0053, 0x4342, [0xA8, 0xFD, 0x08, 0x8F, 0xAB, 0xF1, 0x1F, 0x32]);
interface IIdleSettings : IDispatch
{
    HRESULT get_IdleDuration(BSTR* pDelay);
    HRESULT put_IdleDuration(BSTR delay);
    HRESULT get_WaitTimeout(BSTR* pTimeout);
    HRESULT put_WaitTimeout(BSTR timeout);
    HRESULT get_StopOnIdleEnd(short* pStop);
    HRESULT put_StopOnIdleEnd(short stop);
    HRESULT get_RestartOnIdle(short* pRestart);
    HRESULT put_RestartOnIdle(short restart);
}

const GUID IID_INetworkSettings = {0x9F7DEA84, 0xC30B, 0x4245, [0x80, 0xB6, 0x00, 0xE9, 0xF6, 0x46, 0xF1, 0xB4]};
@GUID(0x9F7DEA84, 0xC30B, 0x4245, [0x80, 0xB6, 0x00, 0xE9, 0xF6, 0x46, 0xF1, 0xB4]);
interface INetworkSettings : IDispatch
{
    HRESULT get_Name(BSTR* pName);
    HRESULT put_Name(BSTR name);
    HRESULT get_Id(BSTR* pId);
    HRESULT put_Id(BSTR id);
}

const GUID IID_IRepetitionPattern = {0x7FB9ACF1, 0x26BE, 0x400E, [0x85, 0xB5, 0x29, 0x4B, 0x9C, 0x75, 0xDF, 0xD6]};
@GUID(0x7FB9ACF1, 0x26BE, 0x400E, [0x85, 0xB5, 0x29, 0x4B, 0x9C, 0x75, 0xDF, 0xD6]);
interface IRepetitionPattern : IDispatch
{
    HRESULT get_Interval(BSTR* pInterval);
    HRESULT put_Interval(BSTR interval);
    HRESULT get_Duration(BSTR* pDuration);
    HRESULT put_Duration(BSTR duration);
    HRESULT get_StopAtDurationEnd(short* pStop);
    HRESULT put_StopAtDurationEnd(short stop);
}

