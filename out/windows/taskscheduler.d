module windows.taskscheduler;

public import windows.core;
public import windows.automation : BSTR, IDispatch, SAFEARRAY, VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.controls : HPROPSHEETPAGE;
public import windows.systemservices : BOOL;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : SYSTEMTIME;

extern(Windows):


// Enums


enum : int
{
    TASK_TIME_TRIGGER_ONCE            = 0x00000000,
    TASK_TIME_TRIGGER_DAILY           = 0x00000001,
    TASK_TIME_TRIGGER_WEEKLY          = 0x00000002,
    TASK_TIME_TRIGGER_MONTHLYDATE     = 0x00000003,
    TASK_TIME_TRIGGER_MONTHLYDOW      = 0x00000004,
    TASK_EVENT_TRIGGER_ON_IDLE        = 0x00000005,
    TASK_EVENT_TRIGGER_AT_SYSTEMSTART = 0x00000006,
    TASK_EVENT_TRIGGER_AT_LOGON       = 0x00000007,
}
alias TASK_TRIGGER_TYPE = int;

enum : int
{
    TASKPAGE_TASK     = 0x00000000,
    TASKPAGE_SCHEDULE = 0x00000001,
    TASKPAGE_SETTINGS = 0x00000002,
}
alias TASKPAGE = int;

enum : int
{
    TASK_RUN_NO_FLAGS           = 0x00000000,
    TASK_RUN_AS_SELF            = 0x00000001,
    TASK_RUN_IGNORE_CONSTRAINTS = 0x00000002,
    TASK_RUN_USE_SESSION_ID     = 0x00000004,
    TASK_RUN_USER_SID           = 0x00000008,
}
alias TASK_RUN_FLAGS = int;

enum : int
{
    TASK_ENUM_HIDDEN = 0x00000001,
}
alias TASK_ENUM_FLAGS = int;

enum : int
{
    TASK_LOGON_NONE                          = 0x00000000,
    TASK_LOGON_PASSWORD                      = 0x00000001,
    TASK_LOGON_S4U                           = 0x00000002,
    TASK_LOGON_INTERACTIVE_TOKEN             = 0x00000003,
    TASK_LOGON_GROUP                         = 0x00000004,
    TASK_LOGON_SERVICE_ACCOUNT               = 0x00000005,
    TASK_LOGON_INTERACTIVE_TOKEN_OR_PASSWORD = 0x00000006,
}
alias TASK_LOGON_TYPE = int;

enum : int
{
    TASK_RUNLEVEL_LUA     = 0x00000000,
    TASK_RUNLEVEL_HIGHEST = 0x00000001,
}
alias TASK_RUNLEVEL_TYPE = int;

enum : int
{
    TASK_PROCESSTOKENSID_NONE         = 0x00000000,
    TASK_PROCESSTOKENSID_UNRESTRICTED = 0x00000001,
    TASK_PROCESSTOKENSID_DEFAULT      = 0x00000002,
}
alias TASK_PROCESSTOKENSID_TYPE = int;

enum : int
{
    TASK_STATE_UNKNOWN  = 0x00000000,
    TASK_STATE_DISABLED = 0x00000001,
    TASK_STATE_QUEUED   = 0x00000002,
    TASK_STATE_READY    = 0x00000003,
    TASK_STATE_RUNNING  = 0x00000004,
}
alias TASK_STATE = int;

enum : int
{
    TASK_VALIDATE_ONLY                = 0x00000001,
    TASK_CREATE                       = 0x00000002,
    TASK_UPDATE                       = 0x00000004,
    TASK_CREATE_OR_UPDATE             = 0x00000006,
    TASK_DISABLE                      = 0x00000008,
    TASK_DONT_ADD_PRINCIPAL_ACE       = 0x00000010,
    TASK_IGNORE_REGISTRATION_TRIGGERS = 0x00000020,
}
alias TASK_CREATION = int;

enum : int
{
    TASK_TRIGGER_EVENT                = 0x00000000,
    TASK_TRIGGER_TIME                 = 0x00000001,
    TASK_TRIGGER_DAILY                = 0x00000002,
    TASK_TRIGGER_WEEKLY               = 0x00000003,
    TASK_TRIGGER_MONTHLY              = 0x00000004,
    TASK_TRIGGER_MONTHLYDOW           = 0x00000005,
    TASK_TRIGGER_IDLE                 = 0x00000006,
    TASK_TRIGGER_REGISTRATION         = 0x00000007,
    TASK_TRIGGER_BOOT                 = 0x00000008,
    TASK_TRIGGER_LOGON                = 0x00000009,
    TASK_TRIGGER_SESSION_STATE_CHANGE = 0x0000000b,
    TASK_TRIGGER_CUSTOM_TRIGGER_01    = 0x0000000c,
}
alias TASK_TRIGGER_TYPE2 = int;

enum : int
{
    TASK_CONSOLE_CONNECT    = 0x00000001,
    TASK_CONSOLE_DISCONNECT = 0x00000002,
    TASK_REMOTE_CONNECT     = 0x00000003,
    TASK_REMOTE_DISCONNECT  = 0x00000004,
    TASK_SESSION_LOCK       = 0x00000007,
    TASK_SESSION_UNLOCK     = 0x00000008,
}
alias TASK_SESSION_STATE_CHANGE_TYPE = int;

enum : int
{
    TASK_ACTION_EXEC         = 0x00000000,
    TASK_ACTION_COM_HANDLER  = 0x00000005,
    TASK_ACTION_SEND_EMAIL   = 0x00000006,
    TASK_ACTION_SHOW_MESSAGE = 0x00000007,
}
alias TASK_ACTION_TYPE = int;

enum : int
{
    TASK_INSTANCES_PARALLEL      = 0x00000000,
    TASK_INSTANCES_QUEUE         = 0x00000001,
    TASK_INSTANCES_IGNORE_NEW    = 0x00000002,
    TASK_INSTANCES_STOP_EXISTING = 0x00000003,
}
alias TASK_INSTANCES_POLICY = int;

enum : int
{
    TASK_COMPATIBILITY_AT   = 0x00000000,
    TASK_COMPATIBILITY_V1   = 0x00000001,
    TASK_COMPATIBILITY_V2   = 0x00000002,
    TASK_COMPATIBILITY_V2_1 = 0x00000003,
    TASK_COMPATIBILITY_V2_2 = 0x00000004,
    TASK_COMPATIBILITY_V2_3 = 0x00000005,
    TASK_COMPATIBILITY_V2_4 = 0x00000006,
}
alias TASK_COMPATIBILITY = int;

// Structs


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
    uint   rgfDays;
    ushort rgfMonths;
}

struct MONTHLYDOW
{
    ushort wWhichWeek;
    ushort rgfDaysOfTheWeek;
    ushort rgfMonths;
}

union TRIGGER_TYPE_UNION
{
    DAILY       Daily;
    WEEKLY      Weekly;
    MONTHLYDATE MonthlyDate;
    MONTHLYDOW  MonthlyDOW;
}

struct TASK_TRIGGER
{
    ushort             cbTriggerSize;
    ushort             Reserved1;
    ushort             wBeginYear;
    ushort             wBeginMonth;
    ushort             wBeginDay;
    ushort             wEndYear;
    ushort             wEndMonth;
    ushort             wEndDay;
    ushort             wStartHour;
    ushort             wStartMinute;
    uint               MinutesDuration;
    uint               MinutesInterval;
    uint               rgFlags;
    TASK_TRIGGER_TYPE  TriggerType;
    TRIGGER_TYPE_UNION Type;
    ushort             Reserved2;
    ushort             wRandomMinutesInterval;
}

// Interfaces

@GUID("0F87369F-A4E5-4CFC-BD3E-73E6154572DD")
struct TaskScheduler;

@GUID("F2A69DB7-DA2C-4352-9066-86FEE6DACAC9")
struct TaskHandlerPS;

@GUID("9F15266D-D7BA-48F0-93C1-E6895F6FE5AC")
struct TaskHandlerStatusPS;

@GUID("148BD52B-A2AB-11CE-B11F-00AA00530503")
interface ITaskTrigger : IUnknown
{
    HRESULT SetTrigger(const(TASK_TRIGGER)* pTrigger);
    HRESULT GetTrigger(TASK_TRIGGER* pTrigger);
    HRESULT GetTriggerString(ushort** ppwszTrigger);
}

@GUID("A6B952F0-A4B1-11D0-997D-00AA006887EC")
interface IScheduledWorkItem : IUnknown
{
    HRESULT CreateTrigger(ushort* piNewTrigger, ITaskTrigger* ppTrigger);
    HRESULT DeleteTrigger(ushort iTrigger);
    HRESULT GetTriggerCount(ushort* pwCount);
    HRESULT GetTrigger(ushort iTrigger, ITaskTrigger* ppTrigger);
    HRESULT GetTriggerString(ushort iTrigger, ushort** ppwszTrigger);
    HRESULT GetRunTimes(const(SYSTEMTIME)* pstBegin, const(SYSTEMTIME)* pstEnd, ushort* pCount, 
                        SYSTEMTIME** rgstTaskTimes);
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

@GUID("148BD524-A2AB-11CE-B11F-00AA00530503")
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

@GUID("148BD528-A2AB-11CE-B11F-00AA00530503")
interface IEnumWorkItems : IUnknown
{
    HRESULT Next(uint celt, ushort*** rgpwszNames, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumWorkItems* ppEnumWorkItems);
}

@GUID("148BD527-A2AB-11CE-B11F-00AA00530503")
interface ITaskScheduler : IUnknown
{
    HRESULT SetTargetComputer(const(wchar)* pwszComputer);
    HRESULT GetTargetComputer(ushort** ppwszComputer);
    HRESULT Enum(IEnumWorkItems* ppEnumWorkItems);
    HRESULT Activate(const(wchar)* pwszName, const(GUID)* riid, IUnknown* ppUnk);
    HRESULT Delete(const(wchar)* pwszName);
    HRESULT NewWorkItem(const(wchar)* pwszTaskName, const(GUID)* rclsid, const(GUID)* riid, IUnknown* ppUnk);
    HRESULT AddWorkItem(const(wchar)* pwszTaskName, IScheduledWorkItem pWorkItem);
    HRESULT IsOfType(const(wchar)* pwszName, const(GUID)* riid);
}

@GUID("4086658A-CBBB-11CF-B604-00C04FD8D565")
interface IProvideTaskPage : IUnknown
{
    HRESULT GetPage(TASKPAGE tpType, BOOL fPersistChanges, HPROPSHEETPAGE* phPage);
}

@GUID("79184A66-8664-423F-97F1-637356A5D812")
interface ITaskFolderCollection : IDispatch
{
    HRESULT get_Count(int* pCount);
    HRESULT get_Item(VARIANT index, ITaskFolder* ppFolder);
    HRESULT get__NewEnum(IUnknown* ppEnum);
}

@GUID("2FABA4C7-4DA9-4013-9697-20CC3FD40F85")
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

@GUID("839D7762-5121-4009-9234-4F0D19394F04")
interface ITaskHandler : IUnknown
{
    HRESULT Start(IUnknown pHandlerServices, BSTR data);
    HRESULT Stop(int* pRetCode);
    HRESULT Pause();
    HRESULT Resume();
}

@GUID("EAEC7A8F-27A0-4DDC-8675-14726A01A38A")
interface ITaskHandlerStatus : IUnknown
{
    HRESULT UpdateStatus(short percentComplete, BSTR statusMessage);
    HRESULT TaskCompleted(HRESULT taskErrCode);
}

@GUID("3E4C9351-D966-4B8B-BB87-CEBA68BB0107")
interface ITaskVariables : IUnknown
{
    HRESULT GetInput(BSTR* pInput);
    HRESULT SetOutput(BSTR input);
    HRESULT GetContext(BSTR* pContext);
}

@GUID("39038068-2B46-4AFD-8662-7BB6F868D221")
interface ITaskNamedValuePair : IDispatch
{
    HRESULT get_Name(BSTR* pName);
    HRESULT put_Name(BSTR name);
    HRESULT get_Value(BSTR* pValue);
    HRESULT put_Value(BSTR value);
}

@GUID("B4EF826B-63C3-46E4-A504-EF69E4F7EA4D")
interface ITaskNamedValueCollection : IDispatch
{
    HRESULT get_Count(int* pCount);
    HRESULT get_Item(int index, ITaskNamedValuePair* ppPair);
    HRESULT get__NewEnum(IUnknown* ppEnum);
    HRESULT Create(BSTR name, BSTR value, ITaskNamedValuePair* ppPair);
    HRESULT Remove(int index);
    HRESULT Clear();
}

@GUID("653758FB-7B9A-4F1E-A471-BEEB8E9B834E")
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

@GUID("6A67614B-6828-4FEC-AA54-6D52E8F1F2DB")
interface IRunningTaskCollection : IDispatch
{
    HRESULT get_Count(int* pCount);
    HRESULT get_Item(VARIANT index, IRunningTask* ppRunningTask);
    HRESULT get__NewEnum(IUnknown* ppEnum);
}

@GUID("9C86F320-DEE3-4DD1-B972-A303F26B061E")
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
    HRESULT GetRunTimes(const(SYSTEMTIME)* pstStart, const(SYSTEMTIME)* pstEnd, uint* pCount, 
                        SYSTEMTIME** pRunTimes);
}

@GUID("09941815-EA89-4B5B-89E0-2A773801FAC3")
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

@GUID("D537D2B0-9FB3-4D34-9739-1FF5CE7B1EF3")
interface IIdleTrigger : ITrigger
{
}

@GUID("72DADE38-FAE4-4B3E-BAF4-5D009AF02B1C")
interface ILogonTrigger : ITrigger
{
    HRESULT get_Delay(BSTR* pDelay);
    HRESULT put_Delay(BSTR delay);
    HRESULT get_UserId(BSTR* pUser);
    HRESULT put_UserId(BSTR user);
}

@GUID("754DA71B-4385-4475-9DD9-598294FA3641")
interface ISessionStateChangeTrigger : ITrigger
{
    HRESULT get_Delay(BSTR* pDelay);
    HRESULT put_Delay(BSTR delay);
    HRESULT get_UserId(BSTR* pUser);
    HRESULT put_UserId(BSTR user);
    HRESULT get_StateChange(TASK_SESSION_STATE_CHANGE_TYPE* pType);
    HRESULT put_StateChange(TASK_SESSION_STATE_CHANGE_TYPE type);
}

@GUID("D45B0167-9653-4EEF-B94F-0732CA7AF251")
interface IEventTrigger : ITrigger
{
    HRESULT get_Subscription(BSTR* pQuery);
    HRESULT put_Subscription(BSTR query);
    HRESULT get_Delay(BSTR* pDelay);
    HRESULT put_Delay(BSTR delay);
    HRESULT get_ValueQueries(ITaskNamedValueCollection* ppNamedXPaths);
    HRESULT put_ValueQueries(ITaskNamedValueCollection pNamedXPaths);
}

@GUID("B45747E0-EBA7-4276-9F29-85C5BB300006")
interface ITimeTrigger : ITrigger
{
    HRESULT get_RandomDelay(BSTR* pRandomDelay);
    HRESULT put_RandomDelay(BSTR randomDelay);
}

@GUID("126C5CD8-B288-41D5-8DBF-E491446ADC5C")
interface IDailyTrigger : ITrigger
{
    HRESULT get_DaysInterval(short* pDays);
    HRESULT put_DaysInterval(short days);
    HRESULT get_RandomDelay(BSTR* pRandomDelay);
    HRESULT put_RandomDelay(BSTR randomDelay);
}

@GUID("5038FC98-82FF-436D-8728-A512A57C9DC1")
interface IWeeklyTrigger : ITrigger
{
    HRESULT get_DaysOfWeek(short* pDays);
    HRESULT put_DaysOfWeek(short days);
    HRESULT get_WeeksInterval(short* pWeeks);
    HRESULT put_WeeksInterval(short weeks);
    HRESULT get_RandomDelay(BSTR* pRandomDelay);
    HRESULT put_RandomDelay(BSTR randomDelay);
}

@GUID("97C45EF1-6B02-4A1A-9C0E-1EBFBA1500AC")
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

@GUID("77D025A3-90FA-43AA-B52E-CDA5499B946A")
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

@GUID("2A9C35DA-D357-41F4-BBC1-207AC1B1F3CB")
interface IBootTrigger : ITrigger
{
    HRESULT get_Delay(BSTR* pDelay);
    HRESULT put_Delay(BSTR delay);
}

@GUID("4C8FEC3A-C218-4E0C-B23D-629024DB91A2")
interface IRegistrationTrigger : ITrigger
{
    HRESULT get_Delay(BSTR* pDelay);
    HRESULT put_Delay(BSTR delay);
}

@GUID("BAE54997-48B1-4CBE-9965-D6BE263EBEA4")
interface IAction : IDispatch
{
    HRESULT get_Id(BSTR* pId);
    HRESULT put_Id(BSTR Id);
    HRESULT get_Type(TASK_ACTION_TYPE* pType);
}

@GUID("4C3D624D-FD6B-49A3-B9B7-09CB3CD3F047")
interface IExecAction : IAction
{
    HRESULT get_Path(BSTR* pPath);
    HRESULT put_Path(BSTR path);
    HRESULT get_Arguments(BSTR* pArgument);
    HRESULT put_Arguments(BSTR argument);
    HRESULT get_WorkingDirectory(BSTR* pWorkingDirectory);
    HRESULT put_WorkingDirectory(BSTR workingDirectory);
}

@GUID("F2A82542-BDA5-4E6B-9143-E2BF4F8987B6")
interface IExecAction2 : IExecAction
{
    HRESULT get_HideAppWindow(short* pHideAppWindow);
    HRESULT put_HideAppWindow(short hideAppWindow);
}

@GUID("505E9E68-AF89-46B8-A30F-56162A83D537")
interface IShowMessageAction : IAction
{
    HRESULT get_Title(BSTR* pTitle);
    HRESULT put_Title(BSTR title);
    HRESULT get_MessageBody(BSTR* pMessageBody);
    HRESULT put_MessageBody(BSTR messageBody);
}

@GUID("6D2FD252-75C5-4F66-90BA-2A7D8CC3039F")
interface IComHandlerAction : IAction
{
    HRESULT get_ClassId(BSTR* pClsid);
    HRESULT put_ClassId(BSTR clsid);
    HRESULT get_Data(BSTR* pData);
    HRESULT put_Data(BSTR data);
}

@GUID("10F62C64-7E16-4314-A0C2-0C3683F99D40")
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
    HRESULT put_Body(BSTR body_);
    HRESULT get_Attachments(SAFEARRAY** pAttachements);
    HRESULT put_Attachments(SAFEARRAY* pAttachements);
}

@GUID("85DF5081-1B24-4F32-878A-D9D14DF4CB77")
interface ITriggerCollection : IDispatch
{
    HRESULT get_Count(int* pCount);
    HRESULT get_Item(int index, ITrigger* ppTrigger);
    HRESULT get__NewEnum(IUnknown* ppEnum);
    HRESULT Create(TASK_TRIGGER_TYPE2 type, ITrigger* ppTrigger);
    HRESULT Remove(VARIANT index);
    HRESULT Clear();
}

@GUID("02820E19-7B98-4ED2-B2E8-FDCCCEFF619B")
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

@GUID("D98D51E5-C9B4-496A-A9C1-18980261CF0F")
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

@GUID("248919AE-E345-4A6D-8AEB-E0D3165C904E")
interface IPrincipal2 : IDispatch
{
    HRESULT get_ProcessTokenSidType(TASK_PROCESSTOKENSID_TYPE* pProcessTokenSidType);
    HRESULT put_ProcessTokenSidType(TASK_PROCESSTOKENSID_TYPE processTokenSidType);
    HRESULT get_RequiredPrivilegeCount(int* pCount);
    HRESULT get_RequiredPrivilege(int index, BSTR* pPrivilege);
    HRESULT AddRequiredPrivilege(BSTR privilege);
}

@GUID("416D8B73-CB41-4EA1-805C-9BE9A5AC4A74")
interface IRegistrationInfo : IDispatch
{
    HRESULT get_Description(BSTR* pDescription);
    HRESULT put_Description(BSTR description);
    HRESULT get_Author(BSTR* pAuthor);
    HRESULT put_Author(BSTR author);
    HRESULT get_Version(BSTR* pVersion);
    HRESULT put_Version(BSTR version_);
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

@GUID("F5BC8FC5-536D-4F77-B852-FBC1356FDEB6")
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

@GUID("8FD4711D-2D02-4C8C-87E3-EFF699DE127E")
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

@GUID("2C05C3F0-6EED-4C05-A15F-ED7D7A98A369")
interface ITaskSettings2 : IDispatch
{
    HRESULT get_DisallowStartOnRemoteAppSession(short* pDisallowStart);
    HRESULT put_DisallowStartOnRemoteAppSession(short disallowStart);
    HRESULT get_UseUnifiedSchedulingEngine(short* pUseUnifiedEngine);
    HRESULT put_UseUnifiedSchedulingEngine(short useUnifiedEngine);
}

@GUID("0AD9D0D7-0C7F-4EBB-9A5F-D1C648DCA528")
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

@GUID("A6024FA8-9652-4ADB-A6BF-5CFCD877A7BA")
interface IMaintenanceSettings : IDispatch
{
    HRESULT put_Period(BSTR value);
    HRESULT get_Period(BSTR* target);
    HRESULT put_Deadline(BSTR value);
    HRESULT get_Deadline(BSTR* target);
    HRESULT put_Exclusive(short value);
    HRESULT get_Exclusive(short* target);
}

@GUID("86627EB4-42A7-41E4-A4D9-AC33A72F2D52")
interface IRegisteredTaskCollection : IDispatch
{
    HRESULT get_Count(int* pCount);
    HRESULT get_Item(VARIANT index, IRegisteredTask* ppRegisteredTask);
    HRESULT get__NewEnum(IUnknown* ppEnum);
}

@GUID("8CFAC062-A080-4C15-9A88-AA7C2AF80DFC")
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
    HRESULT RegisterTask(BSTR path, BSTR xmlText, int flags, VARIANT userId, VARIANT password, 
                         TASK_LOGON_TYPE logonType, VARIANT sddl, IRegisteredTask* ppTask);
    HRESULT RegisterTaskDefinition(BSTR path, ITaskDefinition pDefinition, int flags, VARIANT userId, 
                                   VARIANT password, TASK_LOGON_TYPE logonType, VARIANT sddl, 
                                   IRegisteredTask* ppTask);
    HRESULT GetSecurityDescriptor(int securityInformation, BSTR* pSddl);
    HRESULT SetSecurityDescriptor(BSTR sddl, int flags);
}

@GUID("84594461-0053-4342-A8FD-088FABF11F32")
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

@GUID("9F7DEA84-C30B-4245-80B6-00E9F646F1B4")
interface INetworkSettings : IDispatch
{
    HRESULT get_Name(BSTR* pName);
    HRESULT put_Name(BSTR name);
    HRESULT get_Id(BSTR* pId);
    HRESULT put_Id(BSTR id);
}

@GUID("7FB9ACF1-26BE-400E-85B5-294B9C75DFD6")
interface IRepetitionPattern : IDispatch
{
    HRESULT get_Interval(BSTR* pInterval);
    HRESULT put_Interval(BSTR interval);
    HRESULT get_Duration(BSTR* pDuration);
    HRESULT put_Duration(BSTR duration);
    HRESULT get_StopAtDurationEnd(short* pStop);
    HRESULT put_StopAtDurationEnd(short stop);
}


// GUIDs

const GUID CLSID_TaskHandlerPS       = GUIDOF!TaskHandlerPS;
const GUID CLSID_TaskHandlerStatusPS = GUIDOF!TaskHandlerStatusPS;
const GUID CLSID_TaskScheduler       = GUIDOF!TaskScheduler;

const GUID IID_IAction                    = GUIDOF!IAction;
const GUID IID_IActionCollection          = GUIDOF!IActionCollection;
const GUID IID_IBootTrigger               = GUIDOF!IBootTrigger;
const GUID IID_IComHandlerAction          = GUIDOF!IComHandlerAction;
const GUID IID_IDailyTrigger              = GUIDOF!IDailyTrigger;
const GUID IID_IEmailAction               = GUIDOF!IEmailAction;
const GUID IID_IEnumWorkItems             = GUIDOF!IEnumWorkItems;
const GUID IID_IEventTrigger              = GUIDOF!IEventTrigger;
const GUID IID_IExecAction                = GUIDOF!IExecAction;
const GUID IID_IExecAction2               = GUIDOF!IExecAction2;
const GUID IID_IIdleSettings              = GUIDOF!IIdleSettings;
const GUID IID_IIdleTrigger               = GUIDOF!IIdleTrigger;
const GUID IID_ILogonTrigger              = GUIDOF!ILogonTrigger;
const GUID IID_IMaintenanceSettings       = GUIDOF!IMaintenanceSettings;
const GUID IID_IMonthlyDOWTrigger         = GUIDOF!IMonthlyDOWTrigger;
const GUID IID_IMonthlyTrigger            = GUIDOF!IMonthlyTrigger;
const GUID IID_INetworkSettings           = GUIDOF!INetworkSettings;
const GUID IID_IPrincipal                 = GUIDOF!IPrincipal;
const GUID IID_IPrincipal2                = GUIDOF!IPrincipal2;
const GUID IID_IProvideTaskPage           = GUIDOF!IProvideTaskPage;
const GUID IID_IRegisteredTask            = GUIDOF!IRegisteredTask;
const GUID IID_IRegisteredTaskCollection  = GUIDOF!IRegisteredTaskCollection;
const GUID IID_IRegistrationInfo          = GUIDOF!IRegistrationInfo;
const GUID IID_IRegistrationTrigger       = GUIDOF!IRegistrationTrigger;
const GUID IID_IRepetitionPattern         = GUIDOF!IRepetitionPattern;
const GUID IID_IRunningTask               = GUIDOF!IRunningTask;
const GUID IID_IRunningTaskCollection     = GUIDOF!IRunningTaskCollection;
const GUID IID_IScheduledWorkItem         = GUIDOF!IScheduledWorkItem;
const GUID IID_ISessionStateChangeTrigger = GUIDOF!ISessionStateChangeTrigger;
const GUID IID_IShowMessageAction         = GUIDOF!IShowMessageAction;
const GUID IID_ITask                      = GUIDOF!ITask;
const GUID IID_ITaskDefinition            = GUIDOF!ITaskDefinition;
const GUID IID_ITaskFolder                = GUIDOF!ITaskFolder;
const GUID IID_ITaskFolderCollection      = GUIDOF!ITaskFolderCollection;
const GUID IID_ITaskHandler               = GUIDOF!ITaskHandler;
const GUID IID_ITaskHandlerStatus         = GUIDOF!ITaskHandlerStatus;
const GUID IID_ITaskNamedValueCollection  = GUIDOF!ITaskNamedValueCollection;
const GUID IID_ITaskNamedValuePair        = GUIDOF!ITaskNamedValuePair;
const GUID IID_ITaskScheduler             = GUIDOF!ITaskScheduler;
const GUID IID_ITaskService               = GUIDOF!ITaskService;
const GUID IID_ITaskSettings              = GUIDOF!ITaskSettings;
const GUID IID_ITaskSettings2             = GUIDOF!ITaskSettings2;
const GUID IID_ITaskSettings3             = GUIDOF!ITaskSettings3;
const GUID IID_ITaskTrigger               = GUIDOF!ITaskTrigger;
const GUID IID_ITaskVariables             = GUIDOF!ITaskVariables;
const GUID IID_ITimeTrigger               = GUIDOF!ITimeTrigger;
const GUID IID_ITrigger                   = GUIDOF!ITrigger;
const GUID IID_ITriggerCollection         = GUIDOF!ITriggerCollection;
const GUID IID_IWeeklyTrigger             = GUIDOF!IWeeklyTrigger;
