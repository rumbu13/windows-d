// Written in the D programming language.

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


///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
///product. Please use the Task Scheduler 2.0 Enumerated Types instead.] ] Defines the types of triggers associated with
///a task.
alias TASK_TRIGGER_TYPE = int;
enum : int
{
    ///Trigger is set to run the task a single time. When this value is specified, the <b>Type</b> member of the
    ///TASK_TRIGGER structure is ignored.
    TASK_TIME_TRIGGER_ONCE            = 0x00000000,
    ///Trigger is set to run the task on a daily interval. When this value is specified, the <b>DAILY</b> member of the
    ///TRIGGER_TYPE_UNION structure is used.
    TASK_TIME_TRIGGER_DAILY           = 0x00000001,
    ///Trigger is set to run the work item on specific days of a specific week of a specific month. When this value is
    ///specified, the <b>WEEKLY</b> member of the TRIGGER_TYPE_UNION structure is used.
    TASK_TIME_TRIGGER_WEEKLY          = 0x00000002,
    ///Trigger is set to run the task on a specific day(s) of the month. When this value is specified, the
    ///<b>MONTHLYDATE</b> member of the TRIGGER_TYPE_UNION structure is used.
    TASK_TIME_TRIGGER_MONTHLYDATE     = 0x00000003,
    ///Trigger is set to run the task on specific days, weeks, and months. When this value is specified, the
    ///<b>MONTHLYDOW</b> member of the TRIGGER_TYPE_UNION structure is used.
    TASK_TIME_TRIGGER_MONTHLYDOW      = 0x00000004,
    ///Trigger is set to run the task if the system remains idle for the amount of time specified by the idle wait time
    ///of the task. When this value is specified, the <b>wStartHour</b>, <b>wStartMinute</b>, and <b>Type</b> member of
    ///the TASK_TRIGGER structure are ignored.
    TASK_EVENT_TRIGGER_ON_IDLE        = 0x00000005,
    ///Trigger is set to run the task at system startup. When this value is specified, the <b>Type</b> member of the
    ///TASK_TRIGGER structure is ignored.
    TASK_EVENT_TRIGGER_AT_SYSTEMSTART = 0x00000006,
    ///Trigger is set to run the task when a user logs on. When this value is specified, the <b>Type</b> member of the
    ///TASK_TRIGGER structure is ignored.
    TASK_EVENT_TRIGGER_AT_LOGON       = 0x00000007,
}

///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
///product. Please use the Task Scheduler 2.0 Enumerated Types instead.] ] Defines the type of task page to be
///retrieved. Each property page can be used to define the properties of a task object.
alias TASKPAGE = int;
enum : int
{
    ///Specifies the Task page for the task. This page provides the following UI elements: <ul> <li> Run: This field
    ///specifies the name of the application associated with the task.</li> <li>This property can also be set
    ///programmatically by calling ITask::SetApplicationName.</li> <li><b>Start in</b>: This field specifies the working
    ///directory for the task.</li> <li>This property can also be set programmatically by calling
    ///ITask::SetWorkingDirectory.</li> <li><b>Comments</b>: This field specifies any application-defined comments for
    ///the task.</li> <li>This property can also be set programmatically by calling IScheduledWorkItem::SetComment.</li>
    ///<li><b>Run as</b>: (Windows Server 2003, Windows XP, and Windows 2000 only.) This field specifies the account
    ///name under which the task will run. To the right of this field is a <b>Password</b> button for specifying the
    ///password for the account.</li> <li>This property can also be set programmatically by calling
    ///IScheduledWorkItem::SetAccountInformation.</li> <li><b>Enabled</b> (scheduled task runs at specific time): This
    ///checkbox specifies whether the TASK_TRIGGER_FLAG_DISABLED flag is set.</li> <li>This property can also be set by
    ///setting this flag in the <b>rgFlags</b> member of the TASK_TRIGGER structure.</li> </ul>
    TASKPAGE_TASK     = 0x00000000,
    ///Specifies the Schedule page for the task. This page is used to manage the triggers for the task. The user can
    ///create triggers, edit triggers, and delete triggers from this page. This page provides the following UI elements:
    ///<ul> <li><b>Trigger</b> list box: This list box is displayed only if multiple triggers exist.</li>
    ///<li><b>Schedule Task</b>: This field specifies how often the task will run: daily, weekly, monthly, once, at
    ///system startup, at logon, or when idle.</li> <li><b>Start Time</b>: This field specifies the time of day the task
    ///will run.</li> <li><b>Advanced</b>: This button allows you to set the start date and end date for running the
    ///task.</li> <li><b>Schedule Task</b> group box: This group box is only displayed if the <b>Schedule Task</b> field
    ///specifies daily, weekly, monthly, or once.</li> <li><b>Show multiple schedules</b>: Shows all triggers. When
    ///checked, Trigger list box is displayed.</li> </ul>
    TASKPAGE_SCHEDULE = 0x00000001,
    ///Specifies the Settings page for the task. The user can specify what happens when the task is completed, idle
    ///conditions, and power management properties for the task. This page provides the following UI elements: <ul>
    ///<li><b>Scheduled Task Completed</b> group box: This group box includes check boxes for setting the
    ///TASK_FLAG_DELETE_WHEN_DONE flag and the maximum run time for the task.</li> <li>The TASK_FLAG_DELETE_WHEN_DONE
    ///flag can also be set programmatically by calling IScheduledWorkItem::SetFlags. The maximum run time can be set by
    ///calling ITask::SetMaxRunTime.</li> <li><b>Idle Time</b> group box: This group box includes fields for setting
    ///idle conditions.</li> <li>The idle time can also be set programmatically by calling
    ///IScheduledWorkItem::SetIdleWait. The TASK_FLAG_START_ONLY_IF_IDLE and TASK_FLAG_KILL_ON_IDLE_END flags can be set
    ///by calling IScheduledWorkItem::SetFlags.</li> <li><b>Power management</b> group box: (Windows 95 only) This group
    ///box includes check boxes for indicating how the task behaves when the system is losing power.</li> <li>These
    ///properties can also be set programmatically by setting the TASK_FLAG_DONT_START_IF_ON_BATTERIES and
    ///TASK_FLAG_KILL_IF_GOING_ON_BATTERIES flags using IScheduledWorkItem::SetFlags.</li> </ul>
    TASKPAGE_SETTINGS = 0x00000002,
}

///Defines how a task is run.
alias TASK_RUN_FLAGS = int;
enum : int
{
    ///The task is run with all flags ignored.
    TASK_RUN_NO_FLAGS           = 0x00000000,
    ///The task is run as the user who is calling the Run method.
    TASK_RUN_AS_SELF            = 0x00000001,
    ///The task is run regardless of constraints such as "do not run on batteries" or "run only if idle".
    TASK_RUN_IGNORE_CONSTRAINTS = 0x00000002,
    ///The task is run using a terminal server session identifier.
    TASK_RUN_USE_SESSION_ID     = 0x00000004,
    ///The task is run using a security identifier.
    TASK_RUN_USER_SID           = 0x00000008,
}

///Defines how the Task Scheduler enumerates through registered tasks.
alias TASK_ENUM_FLAGS = int;
enum : int
{
    ///Enumerates all tasks, including tasks that are hidden.
    TASK_ENUM_HIDDEN = 0x00000001,
}

///Defines what logon technique is required to run a task.
alias TASK_LOGON_TYPE = int;
enum : int
{
    ///The logon method is not specified. Used for non-NT credentials.
    TASK_LOGON_NONE                          = 0x00000000,
    ///Use a password for logging on the user. The password must be supplied at registration time.
    TASK_LOGON_PASSWORD                      = 0x00000001,
    ///The service will log the user on using Service For User (S4U), and the task will run in a non-interactive
    ///desktop. When an S4U logon is used, no password is stored by the system and there is no access to either the
    ///network or to encrypted files.
    TASK_LOGON_S4U                           = 0x00000002,
    ///User must already be logged on. The task will be run only in an existing interactive session.
    TASK_LOGON_INTERACTIVE_TOKEN             = 0x00000003,
    ///Group activation. The <b>groupId</b> field specifies the group.
    TASK_LOGON_GROUP                         = 0x00000004,
    ///Indicates that a Local System, Local Service, or Network Service account is being used as a security context to
    ///run the task.
    TASK_LOGON_SERVICE_ACCOUNT               = 0x00000005,
    ///Not in use; currently identical to TASK_LOGON_PASSWORD. <b>Windows 10, version 1511, Windows 10, version 1507,
    ///Windows 8.1, Windows Server 2012 R2, Windows 8, Windows Server 2012, Windows Vista and Windows Server 2008:
    ///</b>First use the interactive token. If the user is not logged on (no interactive token is available), then the
    ///password is used. The password must be specified when a task is registered. This flag is not recommended for new
    ///tasks because it is less reliable than TASK_LOGON_PASSWORD.
    TASK_LOGON_INTERACTIVE_TOKEN_OR_PASSWORD = 0x00000006,
}

///Defines LUA elevation flags that specify with what privilege level the task will be run.
alias TASK_RUNLEVEL_TYPE = int;
enum : int
{
    ///Tasks will be run with the least privileges.
    TASK_RUNLEVEL_LUA     = 0x00000000,
    ///Tasks will be run with the highest privileges.
    TASK_RUNLEVEL_HIGHEST = 0x00000001,
}

///Defines the types of process security identifier (SID) that can be used by tasks. These changes are used to specify
///the type of process SID in the IPrincipal2 interface.
alias TASK_PROCESSTOKENSID_TYPE = int;
enum : int
{
    ///No changes will be made to the process token groups list.
    TASK_PROCESSTOKENSID_NONE         = 0x00000000,
    ///A task SID that is derived from the task name will be added to the process token groups list, and the token
    ///default discretionary access control list (DACL) will be modified to allow only the task SID and local system
    ///full control and the account SID read control.
    TASK_PROCESSTOKENSID_UNRESTRICTED = 0x00000001,
    ///A Task Scheduler will apply default settings to the task process.
    TASK_PROCESSTOKENSID_DEFAULT      = 0x00000002,
}

///Defines the different states that a registered task can be in.
alias TASK_STATE = int;
enum : int
{
    ///The state of the task is unknown.
    TASK_STATE_UNKNOWN  = 0x00000000,
    ///The task is registered but is disabled and no instances of the task are queued or running. The task cannot be run
    ///until it is enabled.
    TASK_STATE_DISABLED = 0x00000001,
    ///Instances of the task are queued.
    TASK_STATE_QUEUED   = 0x00000002,
    ///The task is ready to be executed, but no instances are queued or running.
    TASK_STATE_READY    = 0x00000003,
    ///One or more instances of the task is running.
    TASK_STATE_RUNNING  = 0x00000004,
}

///Defines how the Task Scheduler service creates, updates, or disables the task.
alias TASK_CREATION = int;
enum : int
{
    ///The Task Scheduler service checks the syntax of the XML that describes the task but does not register the task.
    ///This constant cannot be combined with the <b>TASK_CREATE</b>, <b>TASK_UPDATE</b>, or <b>TASK_CREATE_OR_UPDATE</b>
    ///values.
    TASK_VALIDATE_ONLY                = 0x00000001,
    ///The Task Scheduler service registers the task as a new task.
    TASK_CREATE                       = 0x00000002,
    ///The Task Scheduler service registers the task as an updated version of an existing task. When a task with a
    ///registration trigger is updated, the task will execute after the update occurs.
    TASK_UPDATE                       = 0x00000004,
    ///The Task Scheduler service either registers the task as a new task or as an updated version if the task already
    ///exists. Equivalent to TASK_CREATE | TASK_UPDATE.
    TASK_CREATE_OR_UPDATE             = 0x00000006,
    ///The Task Scheduler service registers the disabled task. A disabled task cannot run until it is enabled. For more
    ///information, see Enabled Property of ITaskSettings and Enabled Property of IRegisteredTask.
    TASK_DISABLE                      = 0x00000008,
    ///The Task Scheduler service is prevented from adding the allow access-control entry (ACE) for the context
    ///principal. When the ITaskFolder::RegisterTaskDefinition or ITaskFolder::RegisterTask functions are called with
    ///this flag to update a task, the Task Scheduler service does not add the ACE for the new context principal and
    ///does not remove the ACE from the old context principal.
    TASK_DONT_ADD_PRINCIPAL_ACE       = 0x00000010,
    ///The Task Scheduler service creates the task, but ignores the registration triggers in the task. By ignoring the
    ///registration triggers, the task will not execute when it is registered unless a time-based trigger causes it to
    ///execute on registration.
    TASK_IGNORE_REGISTRATION_TRIGGERS = 0x00000020,
}

///Defines the type of triggers that can be used by tasks.
alias TASK_TRIGGER_TYPE2 = int;
enum : int
{
    ///Triggers the task when a specific event occurs. For more information about event triggers, see IEventTrigger.
    TASK_TRIGGER_EVENT                = 0x00000000,
    ///Triggers the task at a specific time of day. For more information about time triggers, see ITimeTrigger.
    TASK_TRIGGER_TIME                 = 0x00000001,
    ///Triggers the task on a daily schedule. For example, the task starts at a specific time every day, every other
    ///day, or every third day. For more information about daily triggers, see IDailyTrigger.
    TASK_TRIGGER_DAILY                = 0x00000002,
    ///Triggers the task on a weekly schedule. For example, the task starts at 8:00 AM on a specific day every week or
    ///other week. For more information about weekly triggers, see IWeeklyTrigger.
    TASK_TRIGGER_WEEKLY               = 0x00000003,
    ///Triggers the task on a monthly schedule. For example, the task starts on specific days of specific months. For
    ///more information about monthly triggers, see IMonthlyTrigger.
    TASK_TRIGGER_MONTHLY              = 0x00000004,
    ///Triggers the task on a monthly day-of-week schedule. For example, the task starts on a specific days of the week,
    ///weeks of the month, and months of the year. For more information about monthly day-of-week triggers, see
    ///IMonthlyDOWTrigger.
    TASK_TRIGGER_MONTHLYDOW           = 0x00000005,
    ///Triggers the task when the computer goes into an idle state. For more information about idle triggers, see
    ///IIdleTrigger.
    TASK_TRIGGER_IDLE                 = 0x00000006,
    ///Triggers the task when the task is registered. For more information about registration triggers, see
    ///IRegistrationTrigger.
    TASK_TRIGGER_REGISTRATION         = 0x00000007,
    ///Triggers the task when the computer boots. For more information about boot triggers, see IBootTrigger.
    TASK_TRIGGER_BOOT                 = 0x00000008,
    ///Triggers the task when a specific user logs on. For more information about logon triggers, see ILogonTrigger.
    TASK_TRIGGER_LOGON                = 0x00000009,
    ///Triggers the task when a specific user session state changes. For more information about session state change
    ///triggers, see ISessionStateChangeTrigger.
    TASK_TRIGGER_SESSION_STATE_CHANGE = 0x0000000b,
    TASK_TRIGGER_CUSTOM_TRIGGER_01    = 0x0000000c,
}

///Defines what kind of Terminal Server session state change you can use to trigger a task to start. These changes are
///used to specify the type of state change in the ISessionStateChangeTrigger interface.
alias TASK_SESSION_STATE_CHANGE_TYPE = int;
enum : int
{
    ///Terminal Server console connection state change. For example, when you connect to a user session on the local
    ///computer by switching users on the computer.
    TASK_CONSOLE_CONNECT    = 0x00000001,
    ///Terminal Server console disconnection state change. For example, when you disconnect to a user session on the
    ///local computer by switching users on the computer.
    TASK_CONSOLE_DISCONNECT = 0x00000002,
    ///Terminal Server remote connection state change. For example, when a user connects to a user session by using the
    ///Remote Desktop Connection program from a remote computer.
    TASK_REMOTE_CONNECT     = 0x00000003,
    ///Terminal Server remote disconnection state change. For example, when a user disconnects from a user session while
    ///using the Remote Desktop Connection program from a remote computer.
    TASK_REMOTE_DISCONNECT  = 0x00000004,
    ///Terminal Server session locked state change. For example, this state change causes the task to run when the
    ///computer is locked.
    TASK_SESSION_LOCK       = 0x00000007,
    ///Terminal Server session unlocked state change. For example, this state change causes the task to run when the
    ///computer is unlocked.
    TASK_SESSION_UNLOCK     = 0x00000008,
}

///Defines the type of actions that a task can perform.
alias TASK_ACTION_TYPE = int;
enum : int
{
    ///This action performs a command-line operation. For example, the action can run a script, launch an executable,
    ///or, if the name of a document is provided, find its associated application and launch the application with the
    ///document.
    TASK_ACTION_EXEC         = 0x00000000,
    ///This action fires a handler. This action can only be used if the task Compatibility property is set to
    ///TASK_COMPATIBILITY_V2.
    TASK_ACTION_COM_HANDLER  = 0x00000005,
    ///This action sends email message. This action can only be used if the task Compatibility property is set to
    ///TASK_COMPATIBILITY_V2.
    TASK_ACTION_SEND_EMAIL   = 0x00000006,
    ///This action shows a message box. This action can only be used if the task Compatibility property is set to
    ///TASK_COMPATIBILITY_V2.
    TASK_ACTION_SHOW_MESSAGE = 0x00000007,
}

///Defines how the Task Scheduler handles existing instances of the task when it starts a new instance of the task.
alias TASK_INSTANCES_POLICY = int;
enum : int
{
    ///Starts new instance while an existing instance is running.
    TASK_INSTANCES_PARALLEL      = 0x00000000,
    ///Starts a new instance of the task after all other instances of the task are complete.
    TASK_INSTANCES_QUEUE         = 0x00000001,
    ///Does not start a new instance if an existing instance of the task is running.
    TASK_INSTANCES_IGNORE_NEW    = 0x00000002,
    ///Stops an existing instance of the task before it starts a new instance.
    TASK_INSTANCES_STOP_EXISTING = 0x00000003,
}

///Defines what versions of Task Scheduler or the AT command that the task is compatible with.
alias TASK_COMPATIBILITY = int;
enum : int
{
    ///The task is compatible with the AT command.
    TASK_COMPATIBILITY_AT   = 0x00000000,
    ///The task is compatible with Task Scheduler 1.0.
    TASK_COMPATIBILITY_V1   = 0x00000001,
    ///The task is compatible with Task Scheduler 2.0.
    TASK_COMPATIBILITY_V2   = 0x00000002,
    TASK_COMPATIBILITY_V2_1 = 0x00000003,
    TASK_COMPATIBILITY_V2_2 = 0x00000004,
    TASK_COMPATIBILITY_V2_3 = 0x00000005,
    TASK_COMPATIBILITY_V2_4 = 0x00000006,
}

// Structs


///Defines the interval, in days, at which a task is run.
struct DAILY
{
    ///Specifies the number of days between task runs.
    ushort DaysInterval;
}

///Defines the interval, in weeks, between invocations of a task.
struct WEEKLY
{
    ///Number of weeks between invocations of a task.
    ushort WeeksInterval;
    ///Value that describes the days of the week the task runs. This value is a bitfield and is a combination of the
    ///following flags. See Remarks for an example of specifying multiple flags. <table> <tr> <th>Flag</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="TASK_SUNDAY"></a><a id="task_sunday"></a><dl>
    ///<dt><b>TASK_SUNDAY</b></dt> </dl> </td> <td width="60%"> The task will run on Sunday. </td> </tr> <tr> <td
    ///width="40%"><a id="TASK_MONDAY"></a><a id="task_monday"></a><dl> <dt><b>TASK_MONDAY</b></dt> </dl> </td> <td
    ///width="60%"> The task will run on Monday. </td> </tr> <tr> <td width="40%"><a id="TASK_TUESDAY"></a><a
    ///id="task_tuesday"></a><dl> <dt><b>TASK_TUESDAY</b></dt> </dl> </td> <td width="60%"> The task will run on
    ///Tuesday. </td> </tr> <tr> <td width="40%"><a id="TASK_WEDNESDAY"></a><a id="task_wednesday"></a><dl>
    ///<dt><b>TASK_WEDNESDAY</b></dt> </dl> </td> <td width="60%"> The task will run on Wednesday. </td> </tr> <tr> <td
    ///width="40%"><a id="TASK_THURSDAY"></a><a id="task_thursday"></a><dl> <dt><b>TASK_THURSDAY</b></dt> </dl> </td>
    ///<td width="60%"> The task will run on Thursday. </td> </tr> <tr> <td width="40%"><a id="TASK_FRIDAY"></a><a
    ///id="task_friday"></a><dl> <dt><b>TASK_FRIDAY</b></dt> </dl> </td> <td width="60%"> The task will run on Friday.
    ///</td> </tr> <tr> <td width="40%"><a id="TASK_SATURDAY"></a><a id="task_saturday"></a><dl>
    ///<dt><b>TASK_SATURDAY</b></dt> </dl> </td> <td width="60%"> The task will run on Saturday. </td> </tr> </table>
    ushort rgfDaysOfTheWeek;
}

///Defines the day of the month the task will run.
struct MONTHLYDATE
{
    ///Specifies the day of the month a task runs. This value is a bitfield that specifies the day(s) the task will run.
    ///Bit 0 corresponds to the first of the month, bit 1 to the second, and so forth.
    uint   rgfDays;
    ///Specifies the month(s) when the task runs. This value is a combination of the following flags. See Remarks for an
    ///example of setting multiple flags. <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="TASK_JANUARY"></a><a id="task_january"></a><dl> <dt><b>TASK_JANUARY</b></dt> </dl> </td> <td width="60%"> The
    ///task will run in January. </td> </tr> <tr> <td width="40%"><a id="TASK_FEBRUARY"></a><a
    ///id="task_february"></a><dl> <dt><b>TASK_FEBRUARY</b></dt> </dl> </td> <td width="60%"> The task will run in
    ///February. </td> </tr> <tr> <td width="40%"><a id="TASK_MARCH"></a><a id="task_march"></a><dl>
    ///<dt><b>TASK_MARCH</b></dt> </dl> </td> <td width="60%"> The task will run in March. </td> </tr> <tr> <td
    ///width="40%"><a id="TASK_APRIL"></a><a id="task_april"></a><dl> <dt><b>TASK_APRIL</b></dt> </dl> </td> <td
    ///width="60%"> The task will run in April. </td> </tr> <tr> <td width="40%"><a id="TASK_MAY"></a><a
    ///id="task_may"></a><dl> <dt><b>TASK_MAY</b></dt> </dl> </td> <td width="60%"> The task will run in May. </td>
    ///</tr> <tr> <td width="40%"><a id="TASK_JUNE"></a><a id="task_june"></a><dl> <dt><b>TASK_JUNE</b></dt> </dl> </td>
    ///<td width="60%"> The task will run in June. </td> </tr> <tr> <td width="40%"><a id="TASK_JULY"></a><a
    ///id="task_july"></a><dl> <dt><b>TASK_JULY</b></dt> </dl> </td> <td width="60%"> The task will run in July. </td>
    ///</tr> <tr> <td width="40%"><a id="TASK_AUGUST"></a><a id="task_august"></a><dl> <dt><b>TASK_AUGUST</b></dt> </dl>
    ///</td> <td width="60%"> The task will run in August. </td> </tr> <tr> <td width="40%"><a
    ///id="TASK_SEPTEMBER"></a><a id="task_september"></a><dl> <dt><b>TASK_SEPTEMBER</b></dt> </dl> </td> <td
    ///width="60%"> The task will run in September. </td> </tr> <tr> <td width="40%"><a id="TASK_OCTOBER"></a><a
    ///id="task_october"></a><dl> <dt><b>TASK_OCTOBER</b></dt> </dl> </td> <td width="60%"> The task will run in
    ///October. </td> </tr> <tr> <td width="40%"><a id="TASK_NOVEMBER"></a><a id="task_november"></a><dl>
    ///<dt><b>TASK_NOVEMBER</b></dt> </dl> </td> <td width="60%"> The task will run in November. </td> </tr> <tr> <td
    ///width="40%"><a id="TASK_DECEMBER"></a><a id="task_december"></a><dl> <dt><b>TASK_DECEMBER</b></dt> </dl> </td>
    ///<td width="60%"> The task will run in December. </td> </tr> </table>
    ushort rgfMonths;
}

///Defines the date(s) that the task runs by month, week, and day of the week.
struct MONTHLYDOW
{
    ///Specifies the week of the month when the task runs. This value is exclusive and is one of the following flags.
    ///<table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TASK_FIRST_WEEK"></a><a
    ///id="task_first_week"></a><dl> <dt><b>TASK_FIRST_WEEK</b></dt> </dl> </td> <td width="60%"> The task will run
    ///between the first and seventh day of the month. </td> </tr> <tr> <td width="40%"><a id="TASK_SECOND_WEEK"></a><a
    ///id="task_second_week"></a><dl> <dt><b>TASK_SECOND_WEEK</b></dt> </dl> </td> <td width="60%"> The task will run
    ///between the eighth and 14<sup>th</sup> day of the month. </td> </tr> <tr> <td width="40%"><a
    ///id="TASK_THIRD_WEEK"></a><a id="task_third_week"></a><dl> <dt><b>TASK_THIRD_WEEK</b></dt> </dl> </td> <td
    ///width="60%"> The task will run between the 15<sup>th</sup> and 21<sup>st</sup> day of the month. </td> </tr> <tr>
    ///<td width="40%"><a id="TASK_FOURTH_WEEK"></a><a id="task_fourth_week"></a><dl> <dt><b>TASK_FOURTH_WEEK</b></dt>
    ///</dl> </td> <td width="60%"> The task will run between the 22<sup>nd</sup> and 28<sup>th</sup> of the month.
    ///</td> </tr> <tr> <td width="40%"><a id="TASK_LAST_WEEK"></a><a id="task_last_week"></a><dl>
    ///<dt><b>TASK_LAST_WEEK</b></dt> </dl> </td> <td width="60%"> The task will run between the last seven days of the
    ///month. </td> </tr> </table>
    ushort wWhichWeek;
    ///Specifies the day(s) of the week (specified in <b>wWhichWeek</b>) when the task runs. This value is a combination
    ///of the following flags. <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="TASK_SUNDAY"></a><a id="task_sunday"></a><dl> <dt><b>TASK_SUNDAY</b></dt> </dl> </td> <td width="60%"> The
    ///task will run on Sunday. </td> </tr> <tr> <td width="40%"><a id="TASK_MONDAY"></a><a id="task_monday"></a><dl>
    ///<dt><b>TASK_MONDAY</b></dt> </dl> </td> <td width="60%"> The task will run on Monday. </td> </tr> <tr> <td
    ///width="40%"><a id="TASK_TUESDAY"></a><a id="task_tuesday"></a><dl> <dt><b>TASK_TUESDAY</b></dt> </dl> </td> <td
    ///width="60%"> The task will run on Tuesday. </td> </tr> <tr> <td width="40%"><a id="TASK_WEDNESDAY"></a><a
    ///id="task_wednesday"></a><dl> <dt><b>TASK_WEDNESDAY</b></dt> </dl> </td> <td width="60%"> The task will run on
    ///Wednesday. </td> </tr> <tr> <td width="40%"><a id="TASK_THURSDAY"></a><a id="task_thursday"></a><dl>
    ///<dt><b>TASK_THURSDAY</b></dt> </dl> </td> <td width="60%"> The task will run on Thursday. </td> </tr> <tr> <td
    ///width="40%"><a id="TASK_FRIDAY"></a><a id="task_friday"></a><dl> <dt><b>TASK_FRIDAY</b></dt> </dl> </td> <td
    ///width="60%"> The task will run on Friday. </td> </tr> <tr> <td width="40%"><a id="TASK_SATURDAY"></a><a
    ///id="task_saturday"></a><dl> <dt><b>TASK_SATURDAY</b></dt> </dl> </td> <td width="60%"> The task will run on
    ///Saturday. </td> </tr> </table>
    ushort rgfDaysOfTheWeek;
    ///Value that describes the month(s) when the task runs. This value is a combination of the following flags. <table>
    ///<tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TASK_JANUARY"></a><a
    ///id="task_january"></a><dl> <dt><b>TASK_JANUARY</b></dt> </dl> </td> <td width="60%"> The task will run in
    ///January. </td> </tr> <tr> <td width="40%"><a id="TASK_FEBRUARY"></a><a id="task_february"></a><dl>
    ///<dt><b>TASK_FEBRUARY</b></dt> </dl> </td> <td width="60%"> The task will run in February. </td> </tr> <tr> <td
    ///width="40%"><a id="TASK_MARCH"></a><a id="task_march"></a><dl> <dt><b>TASK_MARCH</b></dt> </dl> </td> <td
    ///width="60%"> The task will run in March. </td> </tr> <tr> <td width="40%"><a id="TASK_APRIL"></a><a
    ///id="task_april"></a><dl> <dt><b>TASK_APRIL</b></dt> </dl> </td> <td width="60%"> The task will run in April.
    ///</td> </tr> <tr> <td width="40%"><a id="TASK_MAY"></a><a id="task_may"></a><dl> <dt><b>TASK_MAY</b></dt> </dl>
    ///</td> <td width="60%"> The task will run in May. </td> </tr> <tr> <td width="40%"><a id="TASK_JUNE"></a><a
    ///id="task_june"></a><dl> <dt><b>TASK_JUNE</b></dt> </dl> </td> <td width="60%"> The task will run in June. </td>
    ///</tr> <tr> <td width="40%"><a id="TASK_JULY"></a><a id="task_july"></a><dl> <dt><b>TASK_JULY</b></dt> </dl> </td>
    ///<td width="60%"> The task will run in July. </td> </tr> <tr> <td width="40%"><a id="TASK_AUGUST"></a><a
    ///id="task_august"></a><dl> <dt><b>TASK_AUGUST</b></dt> </dl> </td> <td width="60%"> The task will run in August.
    ///</td> </tr> <tr> <td width="40%"><a id="TASK_SEPTEMBER"></a><a id="task_september"></a><dl>
    ///<dt><b>TASK_SEPTEMBER</b></dt> </dl> </td> <td width="60%"> The task will run in September. </td> </tr> <tr> <td
    ///width="40%"><a id="TASK_OCTOBER"></a><a id="task_october"></a><dl> <dt><b>TASK_OCTOBER</b></dt> </dl> </td> <td
    ///width="60%"> The task will run in October. </td> </tr> <tr> <td width="40%"><a id="TASK_NOVEMBER"></a><a
    ///id="task_november"></a><dl> <dt><b>TASK_NOVEMBER</b></dt> </dl> </td> <td width="60%"> The task will run in
    ///November. </td> </tr> <tr> <td width="40%"><a id="TASK_DECEMBER"></a><a id="task_december"></a><dl>
    ///<dt><b>TASK_DECEMBER</b></dt> </dl> </td> <td width="60%"> The task will run in December. </td> </tr> </table>
    ushort rgfMonths;
}

///Defines the invocation schedule of the trigger within the <b>Type</b> member of a TASK_TRIGGER structure.
union TRIGGER_TYPE_UNION
{
    ///A DAILY structure that specifies the number of days between invocations of a task.
    DAILY       Daily;
    ///A WEEKLY structure that specifies the number of weeks between invocations of a task, and day(s) of the week the
    ///task will run.
    WEEKLY      Weekly;
    ///A MONTHLYDATE structure that specifies the month(s) and day(s) of the month a task will run.
    MONTHLYDATE MonthlyDate;
    ///A MONTHLYDOW structure that specifies the day(s) of the year a task runs by month(s), week of month, and day(s)
    ///of week.
    MONTHLYDOW  MonthlyDOW;
}

///Defines the times to run a scheduled work item.
struct TASK_TRIGGER
{
    ///Size of this structure, in bytes.
    ushort             cbTriggerSize;
    ///For internal use only; this value must be zero.
    ushort             Reserved1;
    ///Year that the task trigger activates. This value must be four digits (1997, not 97). The beginning year must be
    ///specified when setting a task.
    ushort             wBeginYear;
    ///Month of the year (specified in the <b>wBeginYear</b> member) that the task trigger activates. The beginning
    ///month must be specified when setting a task.
    ushort             wBeginMonth;
    ///Day of the month (specified in the <b>wBeginMonth</b> member) that the task trigger activates. The beginning day
    ///must be specified when setting a task.
    ushort             wBeginDay;
    ///Year that the task trigger deactivates. This value must be four digits (1997, not 97).
    ushort             wEndYear;
    ///Month of the year (specified in the <b>wEndYear</b> member) that the task trigger deactivates.
    ushort             wEndMonth;
    ///Day of the month (specified in the <b>wEndMonth</b> member) that the task trigger deactivates.
    ushort             wEndDay;
    ///Hour of the day the task runs. This value is on a 24-hour clock; hours go from 00 to 23.
    ushort             wStartHour;
    ///Minute of the hour (specified in the <b>wStartHour</b> member) that the task runs.
    ushort             wStartMinute;
    ///Number of minutes after the task starts that the trigger will remain active. The number of minutes specified here
    ///must be greater than or equal to the <b>MinutesInterval</b> setting. For example, if you start a task at 8:00
    ///A.M. and want to repeatedly start the task until 5:00 P.M., there would be 540 minutes in the duration.
    uint               MinutesDuration;
    ///Number of minutes between consecutive task executions. This number is counted from the start of the previous
    ///scheduled task. The number of minutes specified here must be less than the <b>MinutesDuration</b> setting. For
    ///example, to run a task every hour from 8:00 A.M. to 5:00 P.M., set this field to 60.
    uint               MinutesInterval;
    ///Value that describes the behavior of the trigger. This value is a combination of the following flags.
    uint               rgFlags;
    ///A TASK_TRIGGER_TYPE enumerated value that specifies the type of trigger. This member is used with <b>Type</b>.
    ///The type of trigger specified here determines which fields of the TRIGGER_TYPE_UNION specified in <b>Type</b>
    ///member will be used. Trigger type is based on when the trigger will run the task.
    TASK_TRIGGER_TYPE  TriggerType;
    ///A TRIGGER_TYPE_UNION structure that specifies details about the trigger. Note that the <b>TriggerType</b> member
    ///determines which fields of the TRIGGER_TYPE_UNION union will be used.
    TRIGGER_TYPE_UNION Type;
    ///For internal use only; this value must be zero.
    ushort             Reserved2;
    ///Not currently used.
    ushort             wRandomMinutesInterval;
}

// Interfaces

@GUID("0F87369F-A4E5-4CFC-BD3E-73E6154572DD")
struct TaskScheduler;

@GUID("F2A69DB7-DA2C-4352-9066-86FEE6DACAC9")
struct TaskHandlerPS;

@GUID("9F15266D-D7BA-48F0-93C1-E6895F6FE5AC")
struct TaskHandlerStatusPS;

///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Provides the methods for accessing and setting
///triggers for a task. Triggers specify task start times, repetition criteria, and other parameters that control when a
///task is run. <b>ITaskTrigger</b> is the primary interface of the task_trigger object. To create a trigger object,
///call CreateTrigger or GetTrigger.
@GUID("148BD52B-A2AB-11CE-B11F-00AA00530503")
interface ITaskTrigger : IUnknown
{
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] The <b>SetTrigger</b> method sets the trigger
    ///criteria for a task trigger.
    ///Params:
    ///    pTrigger = A pointer to a TASK_TRIGGER structure that contains the values that define the new task trigger.
    ///Returns:
    ///    The <b>SetTrigger</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetTrigger(const(TASK_TRIGGER)* pTrigger);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] The <b>GetTrigger</b> method retrieves the
    ///current task trigger.
    ///Params:
    ///    pTrigger = A pointer to a TASK_TRIGGER structure that contains the current task trigger. You must set the
    ///               <b>cbTriggerSize</b> member of the <b>TASK_TRIGGER</b> structure to the size of the task trigger structure
    ///               before passing the structure to this method.
    ///Returns:
    ///    The <b>GetTrigger</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The <i>pTrigger</i> parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetTrigger(TASK_TRIGGER* pTrigger);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] The <b>GetTriggerString</b> method retrieves
    ///the current task trigger in the form of a string. This string appears in the Task Scheduler user interface in a
    ///form similar to "At 2PM every day, starting 5/11/97."
    ///Params:
    ///    ppwszTrigger = A pointer to a pointer to a null-terminated string that describes the current task trigger. The method that
    ///                   invokes <b>GetTriggerString</b> is responsible for freeing this string using the <b>CoTaskMemFree</b>
    ///                   function.
    ///Returns:
    ///    The <b>GetTriggerString</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetTriggerString(ushort** ppwszTrigger);
}

///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Provides the methods for managing specific work
///items.
@GUID("A6B952F0-A4B1-11D0-997D-00AA006887EC")
interface IScheduledWorkItem : IUnknown
{
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Creates a trigger for the work item.
    ///Params:
    ///    piNewTrigger = A pointer to the returned trigger index value of the new trigger. The trigger index for the first trigger
    ///                   associated with a work item is "0". See Remarks for other uses of the trigger index.
    ///    ppTrigger = A pointer to a pointer to an ITaskTrigger interface. Currently, the only supported work items are tasks.
    ///Returns:
    ///    The <b>CreateTrigger</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT CreateTrigger(ushort* piNewTrigger, ITaskTrigger* ppTrigger);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Deletes a trigger from a work item.
    ///Params:
    ///    iTrigger = A trigger index value that specifies the trigger to be deleted. For more information, see Remarks.
    ///Returns:
    ///    The <b>DeleteTrigger</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT DeleteTrigger(ushort iTrigger);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Retrieves the number of triggers for the
    ///current work item.
    ///Params:
    ///    pwCount = A pointer to a <b>WORD</b> that will contain the number of triggers associated with the work item.
    ///Returns:
    ///    The <b>GetTriggerCount</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetTriggerCount(ushort* pwCount);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Retrieves a task trigger.
    ///Params:
    ///    iTrigger = The index of the trigger to retrieve.
    ///    ppTrigger = A pointer to a pointer to an ITaskTrigger interface for the retrieved trigger.
    ///Returns:
    ///    The <b>GetTrigger</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetTrigger(ushort iTrigger, ITaskTrigger* ppTrigger);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Retrieves a string that describes the work item
    ///trigger.
    ///Params:
    ///    iTrigger = The index of the trigger to be retrieved. The first trigger is always referenced by 0. For more information,
    ///               see Remarks.
    ///    ppwszTrigger = A pointer to a null-terminated string that contains the retrieved trigger description. Note that this string
    ///                   must be release by a call to <b>CoTaskMemFree</b> after the string is no longer needed.
    ///Returns:
    ///    The <b>GetTriggerString</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetTriggerString(ushort iTrigger, ushort** ppwszTrigger);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Retrieves the work item run times for a
    ///specified time period.
    ///Params:
    ///    pstBegin = A pointer to a <b>SYSTEMTIME</b> structure that contains the starting time of the time period to check. This
    ///               value is inclusive.
    ///    pstEnd = A pointer to a <b>SYSTEMTIME</b> structure that contains the ending time of the time period to check. This
    ///             value is exclusive. If <b>NULL</b> is passed for this value, the end time is infinite.
    ///    pCount = A pointer to a <b>WORD</b> value that specifies the number of run times to retrieve. On input, this parameter
    ///             contains the number of run times being requested. This can be a number of between 1 and TASK_MAX_RUN_TIMES.
    ///             On output, this parameter contains the number of run times retrieved.
    ///    rgstTaskTimes = A pointer to an array of <b>SYSTEMTIME</b> structures. A <b>NULL</b> LPSYSTEMTIME object should be passed
    ///                    into this parameter. On return, this array contains <i>pCount</i> run times. You must free this array by a
    ///                    calling the <b>CoTaskMemFree</b> function.
    ///Returns:
    ///    The <b>GetRunTimes</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    requested number of run times was retrieved. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> The method succeeded, but fewer than the requested number of run times were
    ///    retrieved. The number of run times retrieved is contained in the value pointed to by <i>pCount</i>. If the
    ///    number of run times retrieved is zero, there are also no event-based triggers that can cause the work item to
    ///    be executed during the specified time period. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SCHED_S_TASK_NO_VALID_TRIGGERS</b></dt> </dl> </td> <td width="60%"> The work item is enabled but has
    ///    no valid triggers. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SCHED_S_TASK_DISABLED</b></dt> </dl> </td>
    ///    <td width="60%"> The work item is disabled. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the arguments are invalid. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There is
    ///    insufficient memory to compute the result. </td> </tr> </table>
    ///    
    HRESULT GetRunTimes(const(SYSTEMTIME)* pstBegin, const(SYSTEMTIME)* pstEnd, ushort* pCount, 
                        SYSTEMTIME** rgstTaskTimes);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Retrieves the next time the work item will run.
    ///Params:
    ///    pstNextRun = A pointer to a <b>SYSTEMTIME</b> structure that contains the next time the work item will run.
    ///Returns:
    ///    The <b>GetNextRunTime</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>SCHED_S_TASK_DISABLED</b></dt> </dl> </td> <td width="60%"> The task will not
    ///    run at the scheduled times because it has been disabled. </td> </tr> </table>
    ///    
    HRESULT GetNextRunTime(SYSTEMTIME* pstNextRun);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Sets the minutes that the system must be idle
    ///before the work item can run.
    ///Params:
    ///    wIdleMinutes = A value that specifies how long, in minutes, the system must remain idle before the work item can run.
    ///    wDeadlineMinutes = A value that specifies the maximum number of minutes that the Task Scheduler will wait for the idle-time
    ///                       period returned in <i>pwIdleMinutes</i>.
    ///Returns:
    ///    The <b>SetIdleWait</b> method returns S_OK.
    ///    
    HRESULT SetIdleWait(ushort wIdleMinutes, ushort wDeadlineMinutes);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Retrieves the idle wait time for the work item.
    ///For information about idle conditions, see Task Idle Conditions.
    ///Params:
    ///    pwIdleMinutes = A pointer to a <b>WORD</b> that contains the idle wait time for the current work item, in minutes.
    ///    pwDeadlineMinutes = A pointer to a <b>WORD</b> that specifies the maximum number of minutes that the Task Scheduler will wait for
    ///                        the idle-time period returned in <i>pwIdleMinutes</i>.
    ///Returns:
    ///    The <b>GetIdleWait</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> </table>
    ///    
    HRESULT GetIdleWait(ushort* pwIdleMinutes, ushort* pwDeadlineMinutes);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Sends a request to the Task Scheduler service
    ///to run the work item.
    ///Returns:
    ///    The <b>Run</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. The request was sent. For more information, see Remarks. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The arguments are not valid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough
    ///    memory is available. </td> </tr> </table>
    ///    
    HRESULT Run();
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] This method ends the execution of the work
    ///item.
    ///Returns:
    ///    The <b>Terminate</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT Terminate();
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Displays the Task, Schedule, and settings
    ///property pages for the work item, allowing a user set the properties on those pages.
    ///Params:
    ///    hParent = Reserved for future use. Set this parameter to <b>NULL</b>.
    ///    dwReserved = Reserved for internal use; this parameter must be set to zero.
    ///Returns:
    ///    The <b>EditWorkItem</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>STG_E_NOTFILEBASEDSTORAGE</b></dt>
    ///    </dl> </td> <td width="60%"> The work item object is not persistent. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The arguments are not valid. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available.
    ///    </td> </tr> </table>
    ///    
    HRESULT EditWorkItem(HWND hParent, uint dwReserved);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Retrieves the most recent time the work item
    ///began running.
    ///Params:
    ///    pstLastRun = A pointer to a <b>SYSTEMTIME</b> structure that contains the most recent time the current work item ran.
    ///Returns:
    ///    The <b>GetMostRecentRunTime</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>SCHED_S_TASK_HAS_NOT_RUN</b></dt> </dl> </td> <td width="60%"> The work item has
    ///    never run. </td> </tr> </table>
    ///    
    HRESULT GetMostRecentRunTime(SYSTEMTIME* pstLastRun);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Retrieves the status of the work item.
    ///Params:
    ///    phrStatus = A pointer to an <b>HRESULT</b> value that contains one of the following values on return.
    ///Returns:
    ///    The <b>GetStatus</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. The request was sent. For more information, see Remarks. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The arguments are not valid.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetStatus(int* phrStatus);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Retrieves the last exit code returned by the
    ///executable associated with the work item on its last run. The method also returns the exit code returned to Task
    ///Scheduler when it last attempted to run the work item.
    ///Params:
    ///    pdwExitCode = A pointer to a <b>DWORD</b> value that is set to the last exit code for the work item. This is the exit code
    ///                  that the work item returned when it last stopped running. If the work item has never been started, 0 is
    ///                  returned.
    ///Returns:
    ///    The <b>GetExitCode</b> method returns the error from the last attempt to start the work item. Possible values
    ///    include the following. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The attempt to start the work item was successful.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SCHED_S_TASK_HAS_NOT_RUN</b></dt> </dl> </td> <td width="60%">
    ///    No attempt has ever been made to start this work item. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The arguments are not valid. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetExitCode(uint* pdwExitCode);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Sets the comment for the work item.
    ///Params:
    ///    pwszComment = A null-terminated string that specifies the comment for the current work item.
    ///Returns:
    ///    The <b>SetComment</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetComment(const(wchar)* pwszComment);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Retrieves the comment for the work item.
    ///Params:
    ///    ppwszComment = A pointer to a null-terminated string that contains the retrieved comment for the current work item.
    ///Returns:
    ///    The <b>GetComment</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetComment(ushort** ppwszComment);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Sets the name of the work item's creator.
    ///Params:
    ///    pwszCreator = A null-terminated string that contains the name of the work item's creator.
    ///Returns:
    ///    The <b>SetCreator</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetCreator(const(wchar)* pwszCreator);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Retrieves the name of the creator of the work
    ///item.
    ///Params:
    ///    ppwszCreator = A pointer to a null-terminated string that contains the name of the creator of the current work item. The
    ///                   application that invokes <b>GetCreator</b> is responsible for freeing this string using the
    ///                   <b>CoTaskMemFree</b> function.
    ///Returns:
    ///    The <b>GetCreator</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetCreator(ushort** ppwszCreator);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] This method stores application-defined data
    ///associated with the work item.
    ///Params:
    ///    cbData = The number of bytes in the data buffer. The caller allocates and frees this memory.
    ///    rgbData = The data to copy.
    ///Returns:
    ///    The <b>SetWorkItemData</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetWorkItemData(ushort cbData, ubyte* rgbData);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Retrieves application-defined data associated
    ///with the work item.
    ///Params:
    ///    pcbData = A pointer to the number of bytes copied.
    ///    prgbData = A pointer to a pointer to a BYTE that contains user-defined data for the current work item. The method that
    ///               invokes <b>GetWorkItemData</b> is responsible for freeing this memory by using CoTaskMemFree.
    ///Returns:
    ///    The <b>GetWorkItemData</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetWorkItemData(ushort* pcbData, ubyte** prgbData);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Sets the number of times Task Scheduler will
    ///try to run the work item again if an error occurs. This method is not implemented.
    ///Params:
    ///    wRetryCount = A value that specifies the number of error retries for the current work item.
    ///Returns:
    ///    The <b>SetErrorRetryCount</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> Not implemented. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetErrorRetryCount(ushort wRetryCount);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Retrieves the number of times that the Task
    ///Scheduler will retry an operation when an error occurs. This method is not implemented.
    ///Params:
    ///    pwRetryCount = A pointer to a <b>WORD</b> that contains the number of times to retry.
    ///Returns:
    ///    Not implemented.
    ///    
    HRESULT GetErrorRetryCount(ushort* pwRetryCount);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Sets the time interval, in minutes, between
    ///Task Scheduler's attempts to run a work item after an error occurs. This method is not implemented.
    ///Params:
    ///    wRetryInterval = A value that specifies the interval between error retries for the current work item, in minutes.
    ///Returns:
    ///    The <b>SetErrorRetryInterval</b> method returns one of the following values. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The arguments are not valid. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> Not
    ///    implemented. </td> </tr> </table>
    ///    
    HRESULT SetErrorRetryInterval(ushort wRetryInterval);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Retrieves the time interval, in minutes,
    ///between Task Scheduler's attempts to run a work item if an error occurs. This method is not implemented.
    ///Params:
    ///    pwRetryInterval = A pointer to a <b>WORD</b> value that contains the time interval between retries of the current work item.
    ///Returns:
    ///    The <b>GetErrorRetryInterval</b> method returns one of the following values. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The arguments are not valid. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> Not
    ///    implemented. </td> </tr> </table>
    ///    
    HRESULT GetErrorRetryInterval(ushort* pwRetryInterval);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Sets the flags that modify the behavior of any
    ///type of work item.
    ///Params:
    ///    dwFlags = A value that specifies a combination of one or more of the following flags:
    ///Returns:
    ///    The <b>SetFlags</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetFlags(uint dwFlags);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Retrieves the flags that modify the behavior of
    ///any type of work item.
    ///Params:
    ///    pdwFlags = A pointer to a <b>DWORD</b> that contains the flags for the work item. For a list of these flags, see
    ///               SetFlags.
    ///Returns:
    ///    The <b>GetFlags</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetFlags(uint* pdwFlags);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Sets the account name and password used to run
    ///the work item.
    ///Params:
    ///    pwszAccountName = A string that contains the <b>null</b>-terminated name of the user account in which the work item will run.
    ///                      To specify the local system account, use the empty string, L"". Do not use any other string to specify the
    ///                      local system account. For more information, see Remarks.
    ///    pwszPassword = A string that contains the password for the account specified in <i>pwszAccountName</i>. Set this parameter
    ///                   to <b>NULL</b> if the local system account is specified. If you set the TASK_FLAG_RUN_ONLY_IF_LOGGED_ON flag,
    ///                   you may also set <i>pwszPassword</i> to <b>NULL</b> for local or domain user accounts. Use the
    ///                   IScheduledWorkItem::SetFlags method to set the flag. Task Scheduler stores account information only once for
    ///                   all tasks that use the same account. If the account password is updated for one task, then all tasks using
    ///                   that same account will use the updated password. When you have finished using the password, clear the
    ///                   password information by calling the SecureZeroMemory function. For more information about protecting
    ///                   passwords, see Handling Passwords.
    ///Returns:
    ///    The <b>SetAccountInformation</b> method returns one of the following values. Note that errors from this call
    ///    may also be returned by the subsequent call to IPersistFile::Save. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td>
    ///    <td width="60%"> The caller does not have permission to perform the operation. For more information, see
    ///    Remarks. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The
    ///    arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> Not enough memory is available. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SCHED_E_NO_SECURITY_SERVICES</b></dt> </dl> </td> <td width="60%"> Security services are available
    ///    only on the Windows Server 2003, Windows XP, and Windows 2000. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SCHED_E_UNSUPPORTED_ACCOUNT_OPTION</b></dt> </dl> </td> <td width="60%"> The <i>pwszPassword</i>
    ///    parameter was set to <b>NULL</b>, but the TASK_FLAG_RUN_ONLY_IF_LOGGED_ON flag was not set. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b> SCHED_E_ACCOUNT_INFORMATION_NOT_SET </b></dt> </dl> </td> <td width="60%"> The
    ///    <i>pwszPassword</i> parameter was incorrect. In the Windows Server 2003, Task Scheduler validates the
    ///    password at the time the job is created (during a call to IPersistFile::Save). Be aware that if this error
    ///    occurs, the job file will still be created. </td> </tr> </table>
    ///    
    HRESULT SetAccountInformation(const(wchar)* pwszAccountName, const(wchar)* pwszPassword);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Retrieves the account name for the work item.
    ///Params:
    ///    ppwszAccountName = A pointer to a null-terminated string that contains the account name for the current work item. The empty
    ///                       string, L"", is returned for the local system account. After processing the account name, be sure to call
    ///                       <b>CoTaskMemFree</b> to free the string.
    ///Returns:
    ///    The <b>GetAccountInformation</b> method returns one of the following values. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td
    ///    width="60%"> The operation was successful. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The arguments are not valid. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SCHED_E_ACCOUNT_INFORMATION_NOT_SET</b></dt> </dl> </td> <td
    ///    width="60%"> The account information has not been set for the work item. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>SCHED_E_NO_SECURITY_SERVICES</b></dt> </dl> </td> <td width="60%"> Security services are
    ///    available only on the Windows Server 2003, Windows 2000, and Windows XP operating systems. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetAccountInformation(ushort** ppwszAccountName);
}

///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Provides the methods for running tasks, getting or
///setting task information, and terminating tasks. It is derived from the IScheduledWorkItem interface and inherits all
///the methods of that interface.
@GUID("148BD524-A2AB-11CE-B11F-00AA00530503")
interface ITask : IScheduledWorkItem
{
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] This method assigns a specific application to
    ///the current task.
    ///Params:
    ///    pwszApplicationName = A null-terminated string that contains the name of the application that will be associated with the task. Use
    ///                          an empty string to clear the application name.
    ///Returns:
    ///    The <b>SetApplicationName</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetApplicationName(const(wchar)* pwszApplicationName);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] This method retrieves the name of the
    ///application that the task is associated with.
    ///Params:
    ///    ppwszApplicationName = A pointer to a null-terminated string that contains the name of the application the current task is
    ///                           associated with. After processing this name, call <b>CoTaskMemFree</b> to free resources.
    ///Returns:
    ///    The <b>GetApplicationName</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetApplicationName(ushort** ppwszApplicationName);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] This method sets the command-line parameters
    ///for the task.
    ///Params:
    ///    pwszParameters = A null-terminated string that contains task parameters. These parameters are passed as command-line arguments
    ///                     to the application the task will run. To clear the command-line parameter property, set <i>pwszParameters</i>
    ///                     to L"".
    ///Returns:
    ///    The <b>SetParameters</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetParameters(const(wchar)* pwszParameters);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] This method retrieves the task's command-line
    ///parameters.
    ///Params:
    ///    ppwszParameters = A pointer to a null-terminated string that contains the command-line parameters for the task. The method that
    ///                      invokes <b>GetParameters</b> is responsible for freeing this string using the <b>CoTaskMemFree</b> function.
    ///Returns:
    ///    The <b>GetParameters</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetParameters(ushort** ppwszParameters);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] This method sets the working directory for the
    ///task.
    ///Params:
    ///    pwszWorkingDirectory = A null-terminated string that contains a directory path to the working directory for the task. The
    ///                           application starts with this directory as the current working directory. To clear the directory, set
    ///                           <i>pwszWorkingDirectory</i> to L"". If the working directory is set to L"", when the application is run, the
    ///                           current directory will be the directory in which the task scheduler service executable, Mstask.exe, resides.
    ///Returns:
    ///    The <b>SetWorkingDirectory</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetWorkingDirectory(const(wchar)* pwszWorkingDirectory);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] This method retrieves the task'sworking
    ///directory.
    ///Params:
    ///    ppwszWorkingDirectory = A pointer to a null-terminated string that contains the task's working directory. The application that
    ///                            invokes <b>GetWorkingDirectory</b> is responsible for freeing this string using the <b>CoTaskMemFree</b>
    ///                            function.
    ///Returns:
    ///    The <b>GetWorkingDirectory</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetWorkingDirectory(ushort** ppwszWorkingDirectory);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] This method sets the priority for the task.
    ///Params:
    ///    dwPriority = A <b>DWORD</b> that specifies the priority for the current task. The priority of a task determines the
    ///                 frequency and length of the time slices for a process. This applies only to the Windows Server 2003, Windows
    ///                 XP, and Windows 2000 operating systems. These values are taken from the <b>CreateProcess</b> priority class
    ///                 and can be one of following flags (in descending order of thread scheduling priority): <ul>
    ///                 <li>REALTIME_PRIORITY_CLASS</li> <li>HIGH_PRIORITY_CLASS</li> <li>NORMAL_PRIORITY_CLASS</li>
    ///                 <li>IDLE_PRIORITY_CLASS</li> </ul>
    ///Returns:
    ///    The <b>SetPriority</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> </table>
    ///    
    HRESULT SetPriority(uint dwPriority);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] This method retrieves the priority for the
    ///task.
    ///Params:
    ///    pdwPriority = A pointer to a <b>DWORD</b> that contains the priority for the current task. The priority value determines
    ///                  the frequency and length of the time slices for a process. This applies only to the Windows Server 2003,
    ///                  Windows XP, and Windows 2000 operating systems. It is taken from the CreateProcess priority class and can be
    ///                  one of the following flags (in descending order of thread scheduling priority): <ul>
    ///                  <li>REALTIME_PRIORITY_CLASS</li> <li>HIGH_PRIORITY_CLASS</li> <li>NORMAL_PRIORITY_CLASS</li>
    ///                  <li>IDLE_PRIORITY_CLASS</li> </ul>
    ///Returns:
    ///    The <b>GetPriority</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetPriority(uint* pdwPriority);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] This method sets the flags that modify the
    ///behavior of a scheduled task.
    ///Params:
    ///    dwFlags = Currently, there are no flags defined for scheduled tasks.
    ///Returns:
    ///    The <b>SetTaskFlags</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetTaskFlags(uint dwFlags);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] This method returns the flags that modify the
    ///behavior of a task.
    ///Params:
    ///    pdwFlags = Currently, there are no defined flags for scheduled tasks.
    ///Returns:
    ///    The <b>GetTaskFlags</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table> This method is designed to get the flags that only apply to scheduled tasks. In contrast,
    ///    IScheduledWorkItem::GetFlags is used to get the flags that apply to all types of scheduled work items.
    ///    
    HRESULT GetTaskFlags(uint* pdwFlags);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] This method sets the maximum time the task can
    ///run, in milliseconds, before terminating.
    ///Params:
    ///    dwMaxRunTimeMS = A <b>DWORD</b> value that specifies the maximum run time (in milliseconds), for the task. This parameter may
    ///                     be set to INFINITE to specify an unlimited time.
    ///Returns:
    ///    The <b>SetMaxRunTime</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetMaxRunTime(uint dwMaxRunTimeMS);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] This method retrieves the maximum length of
    ///time, in milliseconds, the task can run before terminating.
    ///Params:
    ///    pdwMaxRunTimeMS = A pointer to a <b>DWORD</b> that contains the maximum run time of the current task. If the maximum run time
    ///                      is reached during the execution of a task, the Task Scheduler first sends a WM_CLOSE message to the
    ///                      associated application. If the application does not exit within three minutes, <b>TerminateProcess</b> is
    ///                      run.
    ///Returns:
    ///    The <b>GetMaxRunTime</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetMaxRunTime(uint* pdwMaxRunTimeMS);
}

///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Provides the methods for enumerating the tasks in
///the Scheduled Tasks folder. <b>IEnumWorkItems</b> is the primary interface of the enumeration object. To create the
///enumeration, call ITaskScheduler::Enum.
@GUID("148BD528-A2AB-11CE-B11F-00AA00530503")
interface IEnumWorkItems : IUnknown
{
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Retrieves the next specified number of tasks in
    ///the enumeration sequence. If there are fewer than the requested number of tasks left in the sequence, all the
    ///remaining elements are retrieved.
    ///Params:
    ///    celt = The number of tasks to retrieve.
    ///    rgpwszNames = A pointer to an array of pointers (<b>LPWSTR</b>) to <b>null</b>-terminated character strings containing the
    ///                  file names of the tasks returned from the enumeration sequence. These file names are taken from the Scheduled
    ///                  Tasks folder and have the ".job" extension. After processing the names returned in <i>rgpwszNames</i>, you
    ///                  must first free each character string in the array and then the array itself using <b>CoTaskMemFree</b>.
    ///    pceltFetched = A pointer to the number of tasks returned in <i>rgpwszNames</i>. If the <i>celt</i> parameter is 1, this
    ///                   parameter may be <b>NULL</b>.
    ///Returns:
    ///    Returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The number of tasks retrieved equals the
    ///    number requested. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%">
    ///    The number returned is less than the number requested. (Thus, there are no more tasks to enumerate.) </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A parameter is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    Not enough memory is available. </td> </tr> </table>
    ///    
    HRESULT Next(uint celt, ushort*** rgpwszNames, uint* pceltFetched);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Skips the next specified number of tasks in the
    ///enumeration sequence.
    ///Params:
    ///    celt = The number of tasks to be skipped.
    ///Returns:
    ///    Returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The number of elements skipped equals
    ///    <i>celt</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The
    ///    number of elements remaining in the sequence is less than the value specified in <i>celt</i>. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The value of <i>celt</i>
    ///    is less than or equal to zero. </td> </tr> </table>
    ///    
    HRESULT Skip(uint celt);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Resets the enumeration sequence to the
    ///beginning.
    ///Returns:
    ///    Returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The enumeration sequence is reset to the
    ///    beginning of the list. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td
    ///    width="60%"> There is not enough available memory. </td> </tr> </table>
    ///    
    HRESULT Reset();
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Creates a new enumeration object that contains
    ///the same enumeration state as the current enumeration. Because the new object points to the same place in the
    ///enumeration sequence, a client can use the <b>Clone</b> method to record a particular point in the enumeration
    ///sequence and return to that point later.
    ///Params:
    ///    ppEnumWorkItems = A pointer to a pointer to a new IEnumWorkItems interface. This pointer will point to the newly created
    ///                      enumeration. If the method fails, this parameter is undefined.
    ///Returns:
    ///    Returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation was successful. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The argument is not
    ///    valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    There is not enough memory available. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt>
    ///    </dl> </td> <td width="60%"> An error occurred. </td> </tr> </table>
    ///    
    HRESULT Clone(IEnumWorkItems* ppEnumWorkItems);
}

///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Provides the methods for scheduling tasks. It is
///the primary interface of the task scheduler object. To create a task scheduler object, call <b>CoCreateInstance</b>.
@GUID("148BD527-A2AB-11CE-B11F-00AA00530503")
interface ITaskScheduler : IUnknown
{
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] The <b>SetTargetComputer</b> method selects the
    ///computer that the ITaskScheduler interface operates on, allowing remote task management and enumeration.
    ///Params:
    ///    pwszComputer = A pointer to a <b>null</b>-terminated wide character string that specifies the target computer name for the
    ///                   current instance of the <b>ITaskScheduler</b> interface. Specify the target computer name in the Universal
    ///                   Naming Convention (UNC) format. To indicate the local computer, set this value to <b>NULL</b> or to the local
    ///                   computer's UNC name. <div class="alert"><b>Note</b> When specifying a remote computer name, use two backslash
    ///                   (\\) characters before the computer name. For example, use "\\ComputerName" instead of "ComputerName".</div>
    ///                   <div> </div>
    ///Returns:
    ///    The <b>SetTargetComputer</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    method was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SCHED_E_SERVICE_NOT_INSTALLED</b></dt>
    ///    </dl> </td> <td width="60%"> The Task Scheduler service is not installed on the target computer. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user does not
    ///    have access to the remote computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> The <i>pwszComputer</i> parameter is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> A memory allocation failure occurred. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetTargetComputer(const(wchar)* pwszComputer);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] The <b>GetTargetComputer</b> method returns the
    ///name of the computer on which ITaskScheduler is currently targeted.
    ///Params:
    ///    ppwszComputer = A pointer to a null-terminated string that contains the name of the target computer for the current task.
    ///                    This string is allocated by the application that invokes <b>GetTargetComputer</b>, and must also be freed
    ///                    using <b>CoTaskMemFree</b>.
    ///Returns:
    ///    The <b>GetTargetComputer</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetTargetComputer(ushort** ppwszComputer);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] The <b>Enum</b> method retrieves a pointer to
    ///an OLE enumerator object that enumerates the tasks in the current task folder.
    ///Params:
    ///    ppEnumWorkItems = A pointer to a pointer to an IEnumWorkItems interface. This interface contains the enumeration context of the
    ///                      current task(s).
    ///Returns:
    ///    The <b>Enum</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT Enum(IEnumWorkItems* ppEnumWorkItems);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] The <b>Activate</b> method returns an active
    ///interface for a specified work item.
    ///Params:
    ///    pwszName = A null-terminated string that specifies the name of the work item to activate.
    ///    riid = An identifier that identifies the interface being requested. The only interface supported at this time,
    ///           ITask, has the identifier IID_ITask.
    ///    ppUnk = A pointer to an interface pointer that receives the address of the requested interface.
    ///Returns:
    ///    When this method succeeds, S_OK is returned. If the method fails, one of the following error codes may be
    ///    returned. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>COR_E_FILENOTFOUND</b></dt> </dl> </td> <td width="60%"> The task does not exist. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pwszName</i> parameter is
    ///    not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    A memory allocation failed. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SCHED_E_UNKNOWN_OBJECT_VERSION</b></dt> </dl> </td> <td width="60%"> The task object version is either
    ///    unsupported or invalid. </td> </tr> </table>
    ///    
    HRESULT Activate(const(wchar)* pwszName, const(GUID)* riid, IUnknown* ppUnk);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] The <b>Delete</b> method deletes a task.
    ///Params:
    ///    pwszName = A null-terminated string that specifies the name of the task to delete.
    ///Returns:
    ///    The <b>Delete</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The arguments are not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available. </td> </tr>
    ///    </table>
    ///    
    HRESULT Delete(const(wchar)* pwszName);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] The <b>NewWorkItem</b> method creates a new
    ///work item, allocating space for the work item and retrieving its address.
    ///Params:
    ///    pwszTaskName = A null-terminated string that specifies the name of the new work item. This name must conform to Windows NT
    ///                   file-naming conventions, but cannot include backslashes because nesting within the task folder object is not
    ///                   allowed.
    ///    rclsid = The class identifier of the work item to be created. The only class supported at this time, the task class,
    ///             has the identifier CLSID_Ctask.
    ///    riid = The reference identifier of the interface being requested. The only interface supported at this time, ITask,
    ///           has the identifier IID_ITask.
    ///    ppUnk = A pointer to an interface pointer that receives the requested interface. See Remarks for information on
    ///            saving the work item to disk.
    ///Returns:
    ///    The <b>NewWorkItem</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_EXISTS</b></dt> </dl>
    ///    </td> <td width="60%"> A work item with the specified name already exists. The actual return value is
    ///    HRESULT_FROM_WIN32 (ERROR_FILE_EXISTS). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
    ///    </dl> </td> <td width="60%"> One or more of the arguments is not valid. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available to complete
    ///    the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> The caller does not have permission to perform the operation. For more information, see
    ///    Scheduled Work Items. </td> </tr> </table>
    ///    
    HRESULT NewWorkItem(const(wchar)* pwszTaskName, const(GUID)* rclsid, const(GUID)* riid, IUnknown* ppUnk);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] The <b>AddWorkItem</b> method adds a task to
    ///the schedule of tasks.
    ///Params:
    ///    pwszTaskName = A null-terminated string that specifies the name of the task to add. The task name must conform to Windows NT
    ///                   file-naming conventions, but cannot include backslashes because nesting within the task folder object is not
    ///                   allowed.
    ///    pWorkItem = A pointer to the task to add to the schedule.
    ///Returns:
    ///    The <b>AddWorkItem</b> method returns one of the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    operation was successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_EXISTS</b></dt> </dl>
    ///    </td> <td width="60%"> A task with the specified name already exists. The actual return value is
    ///    HRESULT_FROM_WIN32(ERROR_FILE_EXISTS). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
    ///    </dl> </td> <td width="60%"> One or more of the arguments is not valid. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available to complete
    ///    the operation. </td> </tr> </table>
    ///    
    HRESULT AddWorkItem(const(wchar)* pwszTaskName, IScheduledWorkItem pWorkItem);
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] The <b>IsOfType</b> method checks the object's
    ///type to verify that it supports a particular interface.
    ///Params:
    ///    pwszName = A null-terminated string that contains the name of the object to check.
    ///    riid = The reference identifier of the interface to be matched.
    ///Returns:
    ///    The <b>IsOfType</b> method returns S_OK if the object named by <i>pwszName</i> supports the interface
    ///    specified in <i>riid</i>. Otherwise, S_FALSE is returned.
    ///    
    HRESULT IsOfType(const(wchar)* pwszName, const(GUID)* riid);
}

///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] Provides the methods to access the property sheet
///settings of a task.
@GUID("4086658A-CBBB-11CF-B604-00C04FD8D565")
interface IProvideTaskPage : IUnknown
{
    ///<p class="CCE_Message">[[This API may be altered or unavailable in subsequent versions of the operating system or
    ///product. Please use the Task Scheduler 2.0 Interfaces instead.] ] This method retrieves one or more property
    ///sheet pages associated with a task object.
    ///Params:
    ///    tpType = One of the following TASKPAGE enumeration values that specify the page to return.
    ///    fPersistChanges = Specifies whether changes to the task object are made persistent automatically. If <b>TRUE</b>, the page
    ///                      updates the persistent task object automatically if there is a change made on release. If <b>FALSE</b>, the
    ///                      caller is responsible for making task object changes persistent by calling <b>IPersistFile::Save</b> on the
    ///                      task object.
    ///    phPage = Handle to the returned property sheet page of the task object. This handle can then be used to display the
    ///             page.
    ///Returns:
    ///    Returns S_OK if the method was successful, or STG_E_NOTFILEBASEDSTORAGE if the task has not been saved to
    ///    disk.
    ///    
    HRESULT GetPage(TASKPAGE tpType, BOOL fPersistChanges, HPROPSHEETPAGE* phPage);
}

///Provides information and control for a collection of folders that contain tasks.
@GUID("79184A66-8664-423F-97F1-637356A5D812")
interface ITaskFolderCollection : IDispatch
{
    ///Gets the number of folders in the collection. This property is read-only.
    HRESULT get_Count(int* pCount);
    ///Gets the specified folder from the collection. This property is read-only.
    HRESULT get_Item(VARIANT index, ITaskFolder* ppFolder);
    ///Gets the collection enumerator for the folder collection. This property is read-only.
    HRESULT get__NewEnum(IUnknown* ppEnum);
}

///Provides access to the Task Scheduler service for managing registered tasks. The ITaskService::Connect method should
///be called before calling any of the other <b>ITaskService</b> methods.
@GUID("2FABA4C7-4DA9-4013-9697-20CC3FD40F85")
interface ITaskService : IDispatch
{
    ///Gets a folder of registered tasks.
    ///Params:
    ///    path = The path to the folder to retrieve. Do not use a backslash following the last folder name in the path. The
    ///           root task folder is specified with a backslash (\\). An example of a task folder path, under the root task
    ///           folder, is \MyTaskFolder. The '.' character cannot be used to specify the current task folder and the '..'
    ///           characters cannot be used to specify the parent task folder in the path.
    ///    ppFolder = An ITaskFolder interface for the requested folder. Pass in a reference to a <b>NULL</b> ITaskFolder interface
    ///               pointer. Referencing a non-<b>NULL</b> pointer can cause a memory leak because the pointer will be
    ///               overwritten.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFolder(BSTR path, ITaskFolder* ppFolder);
    ///Gets a collection of running tasks.<div class="alert"><b>Note</b> <b>ITaskService::GetRunningTasks</b> will only
    ///return a collection of running tasks that are running at or below a user's security context. For example, for
    ///members of the Administrators group, <b>GetRunningTasks</b> will return a collection of all running tasks, but
    ///for members of the Users group, <b>GetRunningTasks</b> will only return a collection of tasks running under the
    ///Users group security context.</div> <div> </div>
    ///Params:
    ///    flags = A value from the TASK_ENUM_FLAGS enumeration. Pass in 0 to return a collection of running tasks that are not
    ///            hidden tasks.
    ///    ppRunningTasks = An IRunningTaskCollection interface that contains the currently running tasks. Pass in a reference to a
    ///                     <b>NULL</b> IRunningTaskCollection interface pointer. Referencing a non-<b>NULL</b> pointer can cause a
    ///                     memory leak because the pointer will be overwritten.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th></th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An invalid argument was specified
    ///    in the method call. Passing a nonzero value to the <i>flags</i> parameter will return <b>E_INVALIDARG</b>.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation
    ///    completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> NULL was passed into the <i>retVal</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_ONLY_IF_CONNECTED)</b></dt> </dl> </td> <td width="60%"> The user has not
    ///    connected to the service. </td> </tr> </table>
    ///    
    HRESULT GetRunningTasks(int flags, IRunningTaskCollection* ppRunningTasks);
    ///Returns an empty task definition object to be filled in with settings and properties and then registered using
    ///the ITaskFolder::RegisterTaskDefinition method.
    ///Params:
    ///    flags = This parameter is reserved for future use and must be set to 0.
    ///    ppDefinition = The task definition that specifies all the information required to create a new task. Pass in a reference to
    ///                   a <b>NULL</b> ITaskDefinition interface pointer. Referencing a non-NULL pointer can cause a memory leak
    ///                   because the pointer will be overwritten. The returned ITaskDefinition pointer must be released after it is
    ///                   used.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code/value</th> <th>Description</th>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> <dt>0x0</dt> </dl> </td> <td width="60%"> The method
    ///    returned successfully without error. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt>
    ///    <dt>0x80004003</dt> </dl> </td> <td width="60%"> <b>NULL</b> was passed in to the <i>ppDefinition</i>
    ///    parameter. Pass in a reference to a <b>NULL</b> ITaskDefinition interface pointer. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> <dt>0x80070057</dt> </dl> </td> <td width="60%"> A nonzero
    ///    value was passed into the <i>flags</i> parameter. </td> </tr> </table>
    ///    
    HRESULT NewTask(uint flags, ITaskDefinition* ppDefinition);
    ///Connects to a remote computer and associates all subsequent calls on this interface with a remote session. If the
    ///<i>serverName</i> parameter is empty, then this method will execute on the local computer. If the <i>user</i> is
    ///not specified, then the current token is used.
    ///Params:
    ///    serverName = The name of the computer that you want to connect to. If the <i>serverName</i> parameter is empty, then this
    ///                 method will execute on the local computer.
    ///    user = The user name that is used during the connection to the computer. If the <i>user</i> is not specified, then
    ///           the current token is used.
    ///    domain = The domain of the user specified in the <i>user</i> parameter.
    ///    password = The password that is used to connect to the computer. If the user name and password are not specified, then
    ///               the current token is used.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code/value</th> <th>Description</th>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The operation
    ///    completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESS_DENIED</b></dt>
    ///    <dt>0x80070005</dt> </dl> </td> <td width="60%"> Access is denied to connect to the Task Scheduler service.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>SCHED_E_SERVICE_NOT_RUNNING</b></dt> <dt>0x80041315</dt> </dl>
    ///    </td> <td width="60%"> The Task Scheduler service is not running. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> <dt>0x8007000e</dt> </dl> </td> <td width="60%"> The application does not have
    ///    enough memory to complete the operation or the <i>user</i>, <i>password</i>, or <i>domain</i> has at least
    ///    one null and one non-null value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_NETPATH</b></dt>
    ///    <dt>53</dt> </dl> </td> <td width="60%"> This error is returned in the following situations: <ul> <li>The
    ///    computer name specified in the <i>serverName</i> parameter does not exist.</li> <li>When you are trying to
    ///    connect to a Windows Server 2003 or Windows XP computer, and the remote computer does not have the File and
    ///    Printer Sharing firewall exception enabled or the Remote Registry service is not running.</li> <li>When you
    ///    are trying to connect to a Windows Vista computer, and the remote computer does not have the Remote Scheduled
    ///    Tasks Management firewall exception enabled and the File and Printer Sharing firewall exception enabled, or
    ///    the Remote Registry service is not running.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> <dt>50</dt> </dl> </td> <td width="60%"> The <i>user</i>,
    ///    <i>password</i>, or <i>domain</i> parameters cannot be specified when connecting to a remote Windows XP or
    ///    Windows Server 2003 computer from a Windows Vista computer. </td> </tr> </table>
    ///    
    HRESULT Connect(VARIANT serverName, VARIANT user, VARIANT domain, VARIANT password);
    ///Gets a Boolean value that indicates if you are connected to the Task Scheduler service. This property is
    ///read-only.
    HRESULT get_Connected(short* pConnected);
    ///Gets the name of the computer that is running the Task Scheduler service that the user is connected to. This
    ///property is read-only.
    HRESULT get_TargetServer(BSTR* pServer);
    ///Gets the name of the user that is connected to the Task Scheduler service. This property is read-only.
    HRESULT get_ConnectedUser(BSTR* pUser);
    ///Gets the name of the domain to which the TargetServer computer is connected. This property is read-only.
    HRESULT get_ConnectedDomain(BSTR* pDomain);
    ///Indicates the highest version of Task Scheduler that a computer supports. This property is read-only.
    HRESULT get_HighestVersion(uint* pVersion);
}

///Defines the methods that are called by the Task Scheduler service to manage a COM handler.
@GUID("839D7762-5121-4009-9234-4F0D19394F04")
interface ITaskHandler : IUnknown
{
    ///Called to start the COM handler. This method must be implemented by the handler.
    ///Params:
    ///    pHandlerServices = An <b>IUnkown</b> interface that is used to communicate back with the Task Scheduler.
    ///    data = The arguments that are required by the handler. These arguments are defined in the Data property of the COM
    ///           handler action.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Start(IUnknown pHandlerServices, BSTR data);
    ///Called to stop the COM handler. This method must be implemented by the handler.
    ///Params:
    ///    pRetCode = The return code that the Task Schedule will raise as an event when the COM handler action is completed.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Stop(int* pRetCode);
    ///Called to pause the COM handler. This method is optional and should only be implemented to give the Task
    ///Scheduler the ability to pause and restart the handler.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Pause();
    ///Called to resume the COM handler. This method is optional and should only be implemented to give the Task
    ///Scheduler the ability to resume the handler.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Resume();
}

///Provides the methods that are used by COM handlers to notify the Task Scheduler about the status of the handler.
@GUID("EAEC7A8F-27A0-4DDC-8675-14726A01A38A")
interface ITaskHandlerStatus : IUnknown
{
    ///Tells the Task Scheduler about the percentage of completion of the COM handler.
    ///Params:
    ///    percentComplete = A value that indicates the percentage of completion for the COM handler.
    ///    statusMessage = The message that is displayed in the Task Scheduler UI.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT UpdateStatus(short percentComplete, BSTR statusMessage);
    ///Tells the Task Scheduler that the COM handler is completed.
    ///Params:
    ///    taskErrCode = The error code that the Task Scheduler will raise as an event.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT TaskCompleted(HRESULT taskErrCode);
}

///Defines task variables that can be passed as parameters to task handlers and external executables that are launched
///by tasks. Task handlers that need to input and output data to job variables should do a query interface on the
///services pointer for <b>ITaskVariables</b>.
@GUID("3E4C9351-D966-4B8B-BB87-CEBA68BB0107")
interface ITaskVariables : IUnknown
{
    ///Gets the input variables for a task. This method is not implemented.
    ///Params:
    ///    pInput = The input variables for a task.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetInput(BSTR* pInput);
    ///Sets the output variables for a task. This method is not implemented.
    ///Params:
    ///    input = The output variables for a task.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetOutput(BSTR input);
    ///Used to share the context between different steps and tasks that are in the same job instance. This method is not
    ///implemented.
    ///Params:
    ///    pContext = The context that is used to share the context between different steps and tasks that are in the same job
    ///               instance.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetContext(BSTR* pContext);
}

///Creates a name-value pair in which the name is associated with the value.
@GUID("39038068-2B46-4AFD-8662-7BB6F868D221")
interface ITaskNamedValuePair : IDispatch
{
    ///Gets or sets the name that is associated with a value in a name-value pair. This property is read/write.
    HRESULT get_Name(BSTR* pName);
    ///Gets or sets the name that is associated with a value in a name-value pair. This property is read/write.
    HRESULT put_Name(BSTR name);
    ///Gets or sets the value that is associated with a name in a name-value pair. This property is read/write.
    HRESULT get_Value(BSTR* pValue);
    ///Gets or sets the value that is associated with a name in a name-value pair. This property is read/write.
    HRESULT put_Value(BSTR value);
}

///Contains a collection of ITaskNamedValuePair interface name-value pairs.
@GUID("B4EF826B-63C3-46E4-A504-EF69E4F7EA4D")
interface ITaskNamedValueCollection : IDispatch
{
    ///Gets the number of name-value pairs in the collection. This property is read-only.
    HRESULT get_Count(int* pCount);
    ///Gets the specified name-value pair from the collection. This property is read-only.
    HRESULT get_Item(int index, ITaskNamedValuePair* ppPair);
    ///Gets the collection enumerator for the name-value pair collection. This property is read-only.
    HRESULT get__NewEnum(IUnknown* ppEnum);
    ///Creates a name-value pair in the collection.
    ///Params:
    ///    name = The name associated with a value in a name-value pair.
    ///    value = The value associated with a name in a name-value pair.
    ///    ppPair = The name-value pair created in the collection. Pass in a reference to a <b>NULL</b> ITaskNamedValuePair
    ///             interface pointer. Referencing a non-<b>NULL</b> pointer can cause a memory leak because the pointer will be
    ///             overwritten.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Create(BSTR name, BSTR value, ITaskNamedValuePair* ppPair);
    ///Removes a selected name-value pair from the collection.
    ///Params:
    ///    index = The index of the name-value pair to be removed.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Remove(int index);
    ///Clears the entire collection of name-value pairs.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Clear();
}

///Provides the methods to get information from and control a running task.
@GUID("653758FB-7B9A-4F1E-A471-BEEB8E9B834E")
interface IRunningTask : IDispatch
{
    ///Gets the name of the task. This property is read-only.
    HRESULT get_Name(BSTR* pName);
    ///Gets the GUID identifier for this instance of the task. This property is read-only.
    HRESULT get_InstanceGuid(BSTR* pGuid);
    ///Gets the path to where the task is stored. This property is read-only.
    HRESULT get_Path(BSTR* pPath);
    ///Gets an identifier for the state of the running task. This property is read-only.
    HRESULT get_State(TASK_STATE* pState);
    ///Gets the name of the current action that the running task is performing. This property is read-only.
    HRESULT get_CurrentAction(BSTR* pName);
    ///Stops this instance of the task.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The task was stopped. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The user does not have
    ///    permission to stop the task, the task is disabled, or the task is not allowed to be run on demand. </td>
    ///    </tr> </table>
    ///    
    HRESULT Stop();
    ///Refreshes all of the local instance variables of the task.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Refresh();
    ///Gets the process ID for the engine (process) which is running the task. This property is read-only.
    HRESULT get_EnginePID(uint* pPID);
}

///Provides a collection that is used to control running tasks.
@GUID("6A67614B-6828-4FEC-AA54-6D52E8F1F2DB")
interface IRunningTaskCollection : IDispatch
{
    ///Gets the number of running tasks in the collection. This property is read-only.
    HRESULT get_Count(int* pCount);
    ///Gets the specified task from the collection. This property is read-only.
    HRESULT get_Item(VARIANT index, IRunningTask* ppRunningTask);
    ///Gets the collection enumerator for the running task collection. This property is read-only.
    HRESULT get__NewEnum(IUnknown* ppEnum);
}

///Provides the methods that are used to run the task immediately, get any running instances of the task, get or set the
///credentials that are used to register the task, and the properties that describe the task.
@GUID("9C86F320-DEE3-4DD1-B972-A303F26B061E")
interface IRegisteredTask : IDispatch
{
    ///Gets the name of the registered task. This property is read-only.
    HRESULT get_Name(BSTR* pName);
    ///Gets the path to where the registered task is stored. This property is read-only.
    HRESULT get_Path(BSTR* pPath);
    ///Gets the operational state of the registered task. This property is read-only.
    HRESULT get_State(TASK_STATE* pState);
    ///Gets or sets a Boolean value that indicates if the registered task is enabled. This property is read/write.
    HRESULT get_Enabled(short* pEnabled);
    ///Gets or sets a Boolean value that indicates if the registered task is enabled. This property is read/write.
    HRESULT put_Enabled(short enabled);
    ///Runs the registered task immediately.
    ///Params:
    ///    params = The parameters used as values in the task actions. To not specify any parameter values for the task actions,
    ///             set this parameter to <b>VT_NULL</b> or <b>VT_EMPTY</b>. Otherwise, a single <b>BSTR</b> value or an array of
    ///             <b>BSTR</b> values can be specified. The <b>BSTR</b> values that you specify are paired with names and stored
    ///             as name-value pairs. If you specify a single <b>BSTR</b> value, then Arg0 will be the name assigned to the
    ///             value. The value can be used in the task action where the $(Arg0) variable is used in the action properties.
    ///             If you pass in values such as "0", "100", and "250" as an array of <b>BSTR</b> values, then "0" will replace
    ///             the $(Arg0) variables, "100" will replace the $(Arg1) variables, and "250" will replace the $(Arg2) variables
    ///             that are used in the action properties. A maximum of 32 <b>BSTR</b> values can be specified. For more
    ///             information and a list of action properties that can use $(Arg0), $(Arg1), ..., $(Arg32) variables in their
    ///             values, see Task Actions.
    ///    ppRunningTask = An IRunningTask interface that defines the new instance of the task. Pass in a reference to a <b>NULL</b>
    ///                    IRunningTask interface pointer. Referencing a non-<b>NULL</b> pointer can cause a memory leak because the
    ///                    pointer will be overwritten.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Run(VARIANT params, IRunningTask* ppRunningTask);
    ///Runs the registered task immediately using specified flags and a session identifier.
    ///Params:
    ///    params = The parameters used as values in the task actions. To not specify any parameter values for the task actions,
    ///             set this parameter to <b>VT_NULL</b> or <b>VT_EMPTY</b>. Otherwise, a single <b>BSTR</b> value, or an array
    ///             of <b>BSTR</b> values, can be specified. The <b>BSTR</b> values that you specify are paired with names and
    ///             stored as name-value pairs. If you specify a single BSTR value, then Arg0 will be the name assigned to the
    ///             value. The value can be used in the task action where the $(Arg0) variable is used in the action properties.
    ///             If you pass in values such as "0", "100", and "250" as an array of <b>BSTR</b> values, then "0" will replace
    ///             the $(Arg0) variables, "100" will replace the $(Arg1) variables, and "250" will replace the $(Arg2) variables
    ///             that are used in the action properties. A maximum of 32 <b>BSTR</b> values can be specified. For more
    ///             information and a list of action properties that can use $(Arg0), $(Arg1), ..., $(Arg32) variables in their
    ///             values, see Task Actions.
    ///    flags = A TASK_RUN_FLAGS constant that defines how the task is run.
    ///    sessionID = The terminal server session in which you want to start the task. If the TASK_RUN_USE_SESSION_ID constant is
    ///                not passed into the <i>flags</i> parameter, then the value specified in this parameter is ignored. If the
    ///                TASK_RUN_USE_SESSION_ID constant is passed into the <i>flags</i> parameter and the sessionID value is less
    ///                than or equal to 0, then an invalid argument error will be returned. If the <b>TASK_RUN_USE_SESSION_ID</b>
    ///                constant is passed into the <i>flags</i> parameter and the sessionID value is a valid session ID greater than
    ///                0 and if no value is specified for the <i>user</i> parameter, then the Task Scheduler service will try to
    ///                start the task interactively as the user who is logged on to the specified session. If the
    ///                <b>TASK_RUN_USE_SESSION_ID</b> constant is passed into the <i>flags</i> parameter and the sessionID value is
    ///                a valid session ID greater than 0 and if a user is specified in the <i>user</i> parameter, then the Task
    ///                Scheduler service will try to start the task interactively as the user who is specified in the <i>user</i>
    ///                parameter.
    ///    user = The user for which the task runs.
    ///    ppRunningTask = An IRunningTask interface that defines the new instance of the task. Pass in a reference to a <b>NULL</b>
    ///                    IRunningTask interface pointer. Referencing a non-<b>NULL</b> pointer can cause a memory leak because the
    ///                    pointer will be overwritten.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RunEx(VARIANT params, int flags, int sessionID, BSTR user, IRunningTask* ppRunningTask);
    ///Returns all instances of the currently running registered task.<div class="alert"><b>Note</b>
    ///<b>IRegisteredTask::GetInstances</b> will only return instances of the currently running registered task that are
    ///running at or below a user's security context. For example, for members of the Administrators group,
    ///<b>GetInstances</b> will return all instances of the currently running registered task, but for members of the
    ///Users group, <b>GetInstances</b> will only return instances of the currently running registered task that are
    ///running under the Users group security context.</div> <div> </div>
    ///Params:
    ///    flags = This parameter is reserved for future use and must be set to 0.
    ///    ppRunningTasks = An IRunningTaskCollection interface that contains all currently running instances of the task under the
    ///                     user's context. Pass in a reference to a <b>NULL</b> IRunningTaskCollection interface pointer. Referencing a
    ///                     non-<b>NULL</b> pointer can cause a memory leak because the pointer will be overwritten.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The operation completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A non-null
    ///    flag was passed into the <i>flags</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> NULL was passed into the <i>ppRunningTasks</i>
    ///    parameter. </td> </tr> </table>
    ///    
    HRESULT GetInstances(int flags, IRunningTaskCollection* ppRunningTasks);
    ///Gets the time the registered task was last run. This property is read-only.
    HRESULT get_LastRunTime(double* pLastRunTime);
    ///Gets the results that were returned the last time the registered task was run. This property is read-only.
    HRESULT get_LastTaskResult(int* pLastTaskResult);
    ///Gets the number of times the registered task has missed a scheduled run. This property is read-only.
    HRESULT get_NumberOfMissedRuns(int* pNumberOfMissedRuns);
    ///Gets the time when the registered task is next scheduled to run. This property is read-only.
    HRESULT get_NextRunTime(double* pNextRunTime);
    ///Gets the definition of the task. This property is read-only.
    HRESULT get_Definition(ITaskDefinition* ppDefinition);
    ///Gets the XML-formatted registration information for the registered task. This property is read-only.
    HRESULT get_Xml(BSTR* pXml);
    ///Gets the security descriptor that is used as credentials for the registered task.
    ///Params:
    ///    securityInformation = The security information from SECURITY_INFORMATION.
    ///    pSddl = The security descriptor that is used as credentials for the registered task.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSecurityDescriptor(int securityInformation, BSTR* pSddl);
    ///Sets the security descriptor that is used as credentials for the registered task.
    ///Params:
    ///    sddl = The security descriptor that is used as credentials for the registered task. <div class="alert"><b>Note</b>
    ///           If the Local System account is denied access to a task, then the Task Scheduler service can produce
    ///           unexpected results.</div> <div> </div>
    ///    flags = Flags that specify how to set the security descriptor. The TASK_DONT_ADD_PRINCIPAL_ACE flag from the
    ///            TASK_CREATION enumeration can be specified.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetSecurityDescriptor(BSTR sddl, int flags);
    ///Stops the registered task immediately.
    ///Params:
    ///    flags = Reserved. Must be zero.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> All instances of the registered task
    ///    that user has permissions to stop were stopped. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The user cannot successfully stop instances of the task.
    ///    </td> </tr> </table>
    ///    
    HRESULT Stop(int flags);
    ///Gets the times that the registered task is scheduled to run during a specified time.
    ///Params:
    ///    pstStart = The starting time for the query.
    ///    pstEnd = The ending time for the query.
    ///    pCount = The requested number of runs on input and the returned number of runs on output.
    ///    pRunTimes = The scheduled times that the task will run. A <b>NULL</b> LPSYSTEMTIME object should be passed into this
    ///                parameter. On return, this array contains <i>pCount</i> run times. You must free this array by a calling the
    ///                <b>CoTaskMemFree</b> function.
    ///Returns:
    ///    If the method succeeds, it returns S_OK. If the method returns S_FALSE, the pRunTimes parameter contains
    ///    pCount items, but there were more runs of the task, that were not returned. Otherwise, it returns an HRESULT
    ///    error code.
    ///    
    HRESULT GetRunTimes(const(SYSTEMTIME)* pstStart, const(SYSTEMTIME)* pstEnd, uint* pCount, 
                        SYSTEMTIME** pRunTimes);
}

///Provides the common properties that are inherited by all trigger objects.
@GUID("09941815-EA89-4B5B-89E0-2A773801FAC3")
interface ITrigger : IDispatch
{
    ///Gets the type of the trigger. The trigger type is defined when the trigger is created and cannot be changed
    ///later. For information on creating a trigger, see ITriggerCollection::Create. This property is read-only.
    HRESULT get_Type(TASK_TRIGGER_TYPE2* pType);
    ///Gets or sets the identifier for the trigger. This property is read/write.
    HRESULT get_Id(BSTR* pId);
    ///Gets or sets the identifier for the trigger. This property is read/write.
    HRESULT put_Id(BSTR id);
    ///Gets or sets a value that indicates how often the task is run and how long the repetition pattern is repeated
    ///after the task is started. This property is read/write.
    HRESULT get_Repetition(IRepetitionPattern* ppRepeat);
    ///Gets or sets a value that indicates how often the task is run and how long the repetition pattern is repeated
    ///after the task is started. This property is read/write.
    HRESULT put_Repetition(IRepetitionPattern pRepeat);
    ///Gets or sets the maximum amount of time that the task launched by this trigger is allowed to run. This property
    ///is read/write.
    HRESULT get_ExecutionTimeLimit(BSTR* pTimeLimit);
    ///Gets or sets the maximum amount of time that the task launched by this trigger is allowed to run. This property
    ///is read/write.
    HRESULT put_ExecutionTimeLimit(BSTR timelimit);
    ///Gets or sets the date and time when the trigger is activated. This property is read/write.
    HRESULT get_StartBoundary(BSTR* pStart);
    ///Gets or sets the date and time when the trigger is activated. This property is read/write.
    HRESULT put_StartBoundary(BSTR start);
    ///Gets or sets the date and time when the trigger is deactivated. The trigger cannot start the task after it is
    ///deactivated. This property is read/write.
    HRESULT get_EndBoundary(BSTR* pEnd);
    ///Gets or sets the date and time when the trigger is deactivated. The trigger cannot start the task after it is
    ///deactivated. This property is read/write.
    HRESULT put_EndBoundary(BSTR end);
    ///Gets or sets a Boolean value that indicates whether the trigger is enabled. This property is read/write.
    HRESULT get_Enabled(short* pEnabled);
    ///Gets or sets a Boolean value that indicates whether the trigger is enabled. This property is read/write.
    HRESULT put_Enabled(short enabled);
}

///Represents a trigger that starts a task when the computer goes into an idle state. For information about idle
///conditions, see Task Idle Conditions.
@GUID("D537D2B0-9FB3-4D34-9739-1FF5CE7B1EF3")
interface IIdleTrigger : ITrigger
{
}

///Represents a trigger that starts a task when a user logs on. When the Task Scheduler service starts, all logged-on
///users are enumerated and any tasks registered with logon triggers that match the logged on user are run.
@GUID("72DADE38-FAE4-4B3E-BAF4-5D009AF02B1C")
interface ILogonTrigger : ITrigger
{
    ///Gets or sets a value that indicates the amount of time between when the user logs on and when the task is
    ///started. This property is read/write.
    HRESULT get_Delay(BSTR* pDelay);
    ///Gets or sets a value that indicates the amount of time between when the user logs on and when the task is
    ///started. This property is read/write.
    HRESULT put_Delay(BSTR delay);
    ///Gets or sets the identifier of the user. This property is read/write.
    HRESULT get_UserId(BSTR* pUser);
    ///Gets or sets the identifier of the user. This property is read/write.
    HRESULT put_UserId(BSTR user);
}

///Triggers tasks for console connect or disconnect, remote connect or disconnect, or workstation lock or unlock
///notifications.
@GUID("754DA71B-4385-4475-9DD9-598294FA3641")
interface ISessionStateChangeTrigger : ITrigger
{
    ///Gets or sets a value that indicates how long of a delay takes place before a task is started after a Terminal
    ///Server session state change is detected. The format for this string is PnYnMnDTnHnMnS, where nY is the number of
    ///years, nM is the number of months, nD is the number of days, 'T' is the date/time separator, nH is the number of
    ///hours, nM is the number of minutes, and nS is the number of seconds (for example, PT5M specifies 5 minutes and
    ///P1M4DT2H5M specifies one month, four days, two hours, and five minutes). This property is read/write.
    HRESULT get_Delay(BSTR* pDelay);
    ///Gets or sets a value that indicates how long of a delay takes place before a task is started after a Terminal
    ///Server session state change is detected. The format for this string is PnYnMnDTnHnMnS, where nY is the number of
    ///years, nM is the number of months, nD is the number of days, 'T' is the date/time separator, nH is the number of
    ///hours, nM is the number of minutes, and nS is the number of seconds (for example, PT5M specifies 5 minutes and
    ///P1M4DT2H5M specifies one month, four days, two hours, and five minutes). This property is read/write.
    HRESULT put_Delay(BSTR delay);
    ///Gets or sets the user for the Terminal Server session. When a session state change is detected for this user, a
    ///task is started. This property is read/write.
    HRESULT get_UserId(BSTR* pUser);
    ///Gets or sets the user for the Terminal Server session. When a session state change is detected for this user, a
    ///task is started. This property is read/write.
    HRESULT put_UserId(BSTR user);
    ///Gets or sets the kind of Terminal Server session change that would trigger a task launch. This property is
    ///read/write.
    HRESULT get_StateChange(TASK_SESSION_STATE_CHANGE_TYPE* pType);
    ///Gets or sets the kind of Terminal Server session change that would trigger a task launch. This property is
    ///read/write.
    HRESULT put_StateChange(TASK_SESSION_STATE_CHANGE_TYPE type);
}

///Represents a trigger that starts a task when a system event occurs.
@GUID("D45B0167-9653-4EEF-B94F-0732CA7AF251")
interface IEventTrigger : ITrigger
{
    ///Gets or sets a query string that identifies the event that fires the trigger. This property is read/write.
    HRESULT get_Subscription(BSTR* pQuery);
    ///Gets or sets a query string that identifies the event that fires the trigger. This property is read/write.
    HRESULT put_Subscription(BSTR query);
    ///Gets or sets a value that indicates the amount of time between when the event occurs and when the task is
    ///started. The format for this string is PnYnMnDTnHnMnS, where nY is the number of years, nM is the number of
    ///months, nD is the number of days, 'T' is the date/time separator, nH is the number of hours, nM is the number of
    ///minutes, and nS is the number of seconds (for example, PT5M specifies 5 minutes and P1M4DT2H5M specifies one
    ///month, four days, two hours, and five minutes). This property is read/write.
    HRESULT get_Delay(BSTR* pDelay);
    ///Gets or sets a value that indicates the amount of time between when the event occurs and when the task is
    ///started. The format for this string is PnYnMnDTnHnMnS, where nY is the number of years, nM is the number of
    ///months, nD is the number of days, 'T' is the date/time separator, nH is the number of hours, nM is the number of
    ///minutes, and nS is the number of seconds (for example, PT5M specifies 5 minutes and P1M4DT2H5M specifies one
    ///month, four days, two hours, and five minutes). This property is read/write.
    HRESULT put_Delay(BSTR delay);
    ///Gets or sets a collection of named XPath queries. Each query in the collection is applied to the last matching
    ///event XML returned from the subscription query specified in the Subscription property. This property is
    ///read/write.
    HRESULT get_ValueQueries(ITaskNamedValueCollection* ppNamedXPaths);
    ///Gets or sets a collection of named XPath queries. Each query in the collection is applied to the last matching
    ///event XML returned from the subscription query specified in the Subscription property. This property is
    ///read/write.
    HRESULT put_ValueQueries(ITaskNamedValueCollection pNamedXPaths);
}

///Represents a trigger that starts a task at a specific date and time.
@GUID("B45747E0-EBA7-4276-9F29-85C5BB300006")
interface ITimeTrigger : ITrigger
{
    ///Gets or sets a delay time that is randomly added to the start time of the trigger. This property is read/write.
    HRESULT get_RandomDelay(BSTR* pRandomDelay);
    ///Gets or sets a delay time that is randomly added to the start time of the trigger. This property is read/write.
    HRESULT put_RandomDelay(BSTR randomDelay);
}

///Represents a trigger that starts a task based on a daily schedule. For example, the task starts at a specific time
///every day, every other day, every third day, and so on.
@GUID("126C5CD8-B288-41D5-8DBF-E491446ADC5C")
interface IDailyTrigger : ITrigger
{
    ///Gets or sets the interval between the days in the schedule. This property is read/write.
    HRESULT get_DaysInterval(short* pDays);
    ///Gets or sets the interval between the days in the schedule. This property is read/write.
    HRESULT put_DaysInterval(short days);
    ///Gets or sets a delay time that is randomly added to the start time of the trigger. This property is read/write.
    HRESULT get_RandomDelay(BSTR* pRandomDelay);
    ///Gets or sets a delay time that is randomly added to the start time of the trigger. This property is read/write.
    HRESULT put_RandomDelay(BSTR randomDelay);
}

///Represents a trigger that starts a task based on a weekly schedule. For example, the task starts at 8:00 A.M. on a
///specific day of the week every week or every other week.
@GUID("5038FC98-82FF-436D-8728-A512A57C9DC1")
interface IWeeklyTrigger : ITrigger
{
    ///Gets or sets the days of the week in which the task runs. This property is read/write.
    HRESULT get_DaysOfWeek(short* pDays);
    ///Gets or sets the days of the week in which the task runs. This property is read/write.
    HRESULT put_DaysOfWeek(short days);
    ///Gets or sets the interval between the weeks in the schedule. This property is read/write.
    HRESULT get_WeeksInterval(short* pWeeks);
    ///Gets or sets the interval between the weeks in the schedule. This property is read/write.
    HRESULT put_WeeksInterval(short weeks);
    ///Gets or sets a delay time that is randomly added to the start time of the trigger. This property is read/write.
    HRESULT get_RandomDelay(BSTR* pRandomDelay);
    ///Gets or sets a delay time that is randomly added to the start time of the trigger. This property is read/write.
    HRESULT put_RandomDelay(BSTR randomDelay);
}

///Represents a trigger that starts a job based on a monthly schedule. For example, the task starts on specific days of
///specific months.
@GUID("97C45EF1-6B02-4A1A-9C0E-1EBFBA1500AC")
interface IMonthlyTrigger : ITrigger
{
    ///Gets or sets the days of the month during which the task runs. This property is read/write.
    HRESULT get_DaysOfMonth(int* pDays);
    ///Gets or sets the days of the month during which the task runs. This property is read/write.
    HRESULT put_DaysOfMonth(int days);
    ///Gets or sets the months of the year during which the task runs. This property is read/write.
    HRESULT get_MonthsOfYear(short* pMonths);
    ///Gets or sets the months of the year during which the task runs. This property is read/write.
    HRESULT put_MonthsOfYear(short months);
    ///Gets or sets a Boolean value that indicates that the task runs on the last day of the month. This property is
    ///read/write.
    HRESULT get_RunOnLastDayOfMonth(short* pLastDay);
    ///Gets or sets a Boolean value that indicates that the task runs on the last day of the month. This property is
    ///read/write.
    HRESULT put_RunOnLastDayOfMonth(short lastDay);
    ///Gets or sets a delay time that is randomly added to the start time of the trigger. This property is read/write.
    HRESULT get_RandomDelay(BSTR* pRandomDelay);
    ///Gets or sets a delay time that is randomly added to the start time of the trigger. This property is read/write.
    HRESULT put_RandomDelay(BSTR randomDelay);
}

///Represents a trigger that starts a task on a monthly day-of-week schedule. For example, the task starts on every
///first Thursday, May through October.
@GUID("77D025A3-90FA-43AA-B52E-CDA5499B946A")
interface IMonthlyDOWTrigger : ITrigger
{
    ///Gets or sets the days of the week during which the task runs. This property is read/write.
    HRESULT get_DaysOfWeek(short* pDays);
    ///Gets or sets the days of the week during which the task runs. This property is read/write.
    HRESULT put_DaysOfWeek(short days);
    ///Gets or sets the weeks of the month during which the task runs. This property is read/write.
    HRESULT get_WeeksOfMonth(short* pWeeks);
    ///Gets or sets the weeks of the month during which the task runs. This property is read/write.
    HRESULT put_WeeksOfMonth(short weeks);
    ///Gets or sets the months of the year during which the task runs. This property is read/write.
    HRESULT get_MonthsOfYear(short* pMonths);
    ///Gets or sets the months of the year during which the task runs. This property is read/write.
    HRESULT put_MonthsOfYear(short months);
    ///Gets or sets a Boolean value that indicates that the task runs on the last week of the month. This property is
    ///read/write.
    HRESULT get_RunOnLastWeekOfMonth(short* pLastWeek);
    ///Gets or sets a Boolean value that indicates that the task runs on the last week of the month. This property is
    ///read/write.
    HRESULT put_RunOnLastWeekOfMonth(short lastWeek);
    ///Gets or sets a delay time that is randomly added to the start time of the trigger. This property is read/write.
    HRESULT get_RandomDelay(BSTR* pRandomDelay);
    ///Gets or sets a delay time that is randomly added to the start time of the trigger. This property is read/write.
    HRESULT put_RandomDelay(BSTR randomDelay);
}

///Represents a trigger that starts a task when the system is started.
@GUID("2A9C35DA-D357-41F4-BBC1-207AC1B1F3CB")
interface IBootTrigger : ITrigger
{
    ///Gets or sets a value that indicates the amount of time between when the system is booted and when the task is
    ///started. This property is read/write.
    HRESULT get_Delay(BSTR* pDelay);
    ///Gets or sets a value that indicates the amount of time between when the system is booted and when the task is
    ///started. This property is read/write.
    HRESULT put_Delay(BSTR delay);
}

///Represents a trigger that starts a task when the task is registered or updated.
@GUID("4C8FEC3A-C218-4E0C-B23D-629024DB91A2")
interface IRegistrationTrigger : ITrigger
{
    ///Gets or sets the amount of time between when the task is registered and when the task is started. The format for
    ///this string is PnYnMnDTnHnMnS, where nY is the number of years, nM is the number of months, nD is the number of
    ///days, 'T' is the date/time separator, nH is the number of hours, nM is the number of minutes, and nS is the
    ///number of seconds (for example, PT5M specifies 5 minutes and P1M4DT2H5M specifies one month, four days, two
    ///hours, and five minutes). This property is read/write.
    HRESULT get_Delay(BSTR* pDelay);
    ///Gets or sets the amount of time between when the task is registered and when the task is started. The format for
    ///this string is PnYnMnDTnHnMnS, where nY is the number of years, nM is the number of months, nD is the number of
    ///days, 'T' is the date/time separator, nH is the number of hours, nM is the number of minutes, and nS is the
    ///number of seconds (for example, PT5M specifies 5 minutes and P1M4DT2H5M specifies one month, four days, two
    ///hours, and five minutes). This property is read/write.
    HRESULT put_Delay(BSTR delay);
}

///Provides the common properties inherited by all action objects. An action object is created by the
///IActionCollection::Create method.
@GUID("BAE54997-48B1-4CBE-9965-D6BE263EBEA4")
interface IAction : IDispatch
{
    ///Gets or sets the identifier of the action. This property is read/write.
    HRESULT get_Id(BSTR* pId);
    ///Gets or sets the identifier of the action. This property is read/write.
    HRESULT put_Id(BSTR Id);
    ///Gets the type of action. This property is read-only.
    HRESULT get_Type(TASK_ACTION_TYPE* pType);
}

///Represents an action that executes a command-line operation.
@GUID("4C3D624D-FD6B-49A3-B9B7-09CB3CD3F047")
interface IExecAction : IAction
{
    ///Gets or sets the path to an executable file. This property is read/write.
    HRESULT get_Path(BSTR* pPath);
    ///Gets or sets the path to an executable file. This property is read/write.
    HRESULT put_Path(BSTR path);
    ///Gets or sets the arguments associated with the command-line operation. This property is read/write.
    HRESULT get_Arguments(BSTR* pArgument);
    ///Gets or sets the arguments associated with the command-line operation. This property is read/write.
    HRESULT put_Arguments(BSTR argument);
    ///Gets or sets the directory that contains either the executable file or the files that are used by the executable
    ///file. This property is read/write.
    HRESULT get_WorkingDirectory(BSTR* pWorkingDirectory);
    ///Gets or sets the directory that contains either the executable file or the files that are used by the executable
    ///file. This property is read/write.
    HRESULT put_WorkingDirectory(BSTR workingDirectory);
}

@GUID("F2A82542-BDA5-4E6B-9143-E2BF4F8987B6")
interface IExecAction2 : IExecAction
{
    HRESULT get_HideAppWindow(short* pHideAppWindow);
    HRESULT put_HideAppWindow(short hideAppWindow);
}

///<p class="CCE_Message">[This interface is no longer supported. You can use IExecAction with the Windows scripting
///MsgBox function to show a message in the user session.] Represents an action that shows a message box when a task is
///activated.
@GUID("505E9E68-AF89-46B8-A30F-56162A83D537")
interface IShowMessageAction : IAction
{
    ///<p class="CCE_Message">[This interface is no longer supported. You can use IExecAction with the Windows scripting
    ///MsgBox function to show a message in the user session.] Gets or sets the title of the message box. This property
    ///is read/write.
    HRESULT get_Title(BSTR* pTitle);
    ///<p class="CCE_Message">[This interface is no longer supported. You can use IExecAction with the Windows scripting
    ///MsgBox function to show a message in the user session.] Gets or sets the title of the message box. This property
    ///is read/write.
    HRESULT put_Title(BSTR title);
    ///<p class="CCE_Message">[This interface is no longer supported. You can use IExecAction with the Windows scripting
    ///MsgBox function to show a message in the user session.] Gets or sets the message text that is displayed in the
    ///body of the message box. This property is read/write.
    HRESULT get_MessageBody(BSTR* pMessageBody);
    ///<p class="CCE_Message">[This interface is no longer supported. You can use IExecAction with the Windows scripting
    ///MsgBox function to show a message in the user session.] Gets or sets the message text that is displayed in the
    ///body of the message box. This property is read/write.
    HRESULT put_MessageBody(BSTR messageBody);
}

///Represents an action that fires a handler.
@GUID("6D2FD252-75C5-4F66-90BA-2A7D8CC3039F")
interface IComHandlerAction : IAction
{
    ///Gets or sets the identifier of the handler class. This property is read/write.
    HRESULT get_ClassId(BSTR* pClsid);
    ///Gets or sets the identifier of the handler class. This property is read/write.
    HRESULT put_ClassId(BSTR clsid);
    ///Gets or sets additional data that is associated with the handler. This property is read/write.
    HRESULT get_Data(BSTR* pData);
    ///Gets or sets additional data that is associated with the handler. This property is read/write.
    HRESULT put_Data(BSTR data);
}

///<p class="CCE_Message">[This interface is no longer supported. Please use IExecAction with the powershell
///Send-MailMessage cmdlet as a workaround.] Represents an action that sends an email message.
@GUID("10F62C64-7E16-4314-A0C2-0C3683F99D40")
interface IEmailAction : IAction
{
    ///<p class="CCE_Message">[This interface is no longer supported. Please use IExecAction with the powershell
    ///Send-MailMessage cmdlet as a workaround.] Gets or sets the name of the SMTP server that you use to send email
    ///from. This property is read/write.
    HRESULT get_Server(BSTR* pServer);
    ///<p class="CCE_Message">[This interface is no longer supported. Please use IExecAction with the powershell <a
    ///href="/powershell/module/microsoft.powershell.utility/send-mailmessage?view=powershell-7 ">Send-MailMessage</a>
    ///cmdlet as a workaround.] Gets or sets the name of the SMTP server that you use to send email from. This property
    ///is read/write.
    HRESULT put_Server(BSTR server);
    ///<p class="CCE_Message">[This interface is no longer supported. Please use IExecAction with the powershell <a
    ///href="/powershell/module/microsoft.powershell.utility/send-mailmessage?view=powershell-7 ">Send-MailMessage</a>
    ///cmdlet as a workaround.] Gets or sets the subject of the email message. This property is read/write.
    HRESULT get_Subject(BSTR* pSubject);
    ///<p class="CCE_Message">[This interface is no longer supported. Please use IExecAction with the powershell
    ///Send-MailMessage cmdlet as a workaround.] Gets or sets the subject of the email message. This property is
    ///read/write.
    HRESULT put_Subject(BSTR subject);
    ///<p class="CCE_Message">[This interface is no longer supported. Please use IExecAction with the powershell <a
    ///href="/powershell/module/microsoft.powershell.utility/send-mailmessage?view=powershell-7 ">Send-MailMessage</a>
    ///cmdlet as a workaround.] Gets or sets the email address or addresses that you want to send the email to. This
    ///property is read/write.
    HRESULT get_To(BSTR* pTo);
    ///<p class="CCE_Message">[This interface is no longer supported. Please use IExecAction with the powershell
    ///Send-MailMessage cmdlet as a workaround.] Gets or sets the email address or addresses that you want to send the
    ///email to. This property is read/write.
    HRESULT put_To(BSTR to);
    ///<p class="CCE_Message">[This interface is no longer supported. Please use IExecAction with the powershell
    ///Send-MailMessage cmdlet as a workaround.] Gets or sets the email address or addresses that you want to Cc in the
    ///email message. This property is read/write.
    HRESULT get_Cc(BSTR* pCc);
    ///<p class="CCE_Message">[This interface is no longer supported. Please use IExecAction with the powershell
    ///Send-MailMessage cmdlet as a workaround.] Gets or sets the email address or addresses that you want to Cc in the
    ///email message. This property is read/write.
    HRESULT put_Cc(BSTR cc);
    ///<p class="CCE_Message">[This interface is no longer supported. Please use IExecAction with the powershell
    ///Send-MailMessage cmdlet as a workaround.] Gets or sets the email address or addresses that you want to Bcc in the
    ///email message. This property is read/write.
    HRESULT get_Bcc(BSTR* pBcc);
    ///<p class="CCE_Message">[This interface is no longer supported. Please use IExecAction with the powershell <a
    ///href="/powershell/module/microsoft.powershell.utility/send-mailmessage?view=powershell-7 ">Send-MailMessage</a>
    ///cmdlet as a workaround.] Gets or sets the email address or addresses that you want to Bcc in the email message.
    ///This property is read/write.
    HRESULT put_Bcc(BSTR bcc);
    ///<p class="CCE_Message">[This interface is no longer supported. Please use IExecAction with the powershell
    ///Send-MailMessage cmdlet as a workaround.] Gets or sets the email address that you want to reply to. This property
    ///is read/write.
    HRESULT get_ReplyTo(BSTR* pReplyTo);
    ///<p class="CCE_Message">[This interface is no longer supported. Please use IExecAction with the powershell <a
    ///href="/powershell/module/microsoft.powershell.utility/send-mailmessage?view=powershell-7 ">Send-MailMessage</a>
    ///cmdlet as a workaround.] Gets or sets the email address that you want to reply to. This property is read/write.
    HRESULT put_ReplyTo(BSTR replyTo);
    ///<p class="CCE_Message">[This interface is no longer supported. Please use IExecAction with the powershell <a
    ///href="/powershell/module/microsoft.powershell.utility/send-mailmessage?view=powershell-7 ">Send-MailMessage</a>
    ///cmdlet as a workaround.] Gets or sets the email address that you want to send the email from. This property is
    ///read/write.
    HRESULT get_From(BSTR* pFrom);
    ///<p class="CCE_Message">[This interface is no longer supported. Please use IExecAction with the powershell <a
    ///href="/powershell/module/microsoft.powershell.utility/send-mailmessage?view=powershell-7 ">Send-MailMessage</a>
    ///cmdlet as a workaround.] ets or sets the email address that you want to send the email from. This property is
    ///read/write.
    HRESULT put_From(BSTR from);
    ///<p class="CCE_Message">[This interface is no longer supported. Please use IExecAction with the powershell
    ///Send-MailMessage cmdlet as a workaround.] Gets or sets the header information in the email message to send. This
    ///property is read/write.
    HRESULT get_HeaderFields(ITaskNamedValueCollection* ppHeaderFields);
    ///<p class="CCE_Message">[This interface is no longer supported. Please use IExecAction with the powershell <a
    ///href="/powershell/module/microsoft.powershell.utility/send-mailmessage?view=powershell-7 ">Send-MailMessage</a>
    ///cmdlet as a workaround.] Gets or sets the header information in the email message to send. This property is
    ///read/write.
    HRESULT put_HeaderFields(ITaskNamedValueCollection pHeaderFields);
    ///<p class="CCE_Message">[This interface is no longer supported. Please use IExecAction with the powershell <a
    ///href="/powershell/module/microsoft.powershell.utility/send-mailmessage?view=powershell-7 ">Send-MailMessage</a>
    ///cmdlet as a workaround.] Gets or sets the body of the email that contains the email message. This property is
    ///read/write.
    HRESULT get_Body(BSTR* pBody);
    ///<p class="CCE_Message">[This interface is no longer supported. Please use IExecAction with the powershell
    ///Send-MailMessage cmdlet as a workaround.] Gets or sets the body of the email that contains the email message.
    ///This property is read/write.
    HRESULT put_Body(BSTR body_);
    ///<p class="CCE_Message">[This interface is no longer supported. Please use IExecAction with the powershell
    ///Send-MailMessage cmdlet as a workaround.] Gets or sets the pointer to an array of attachments that is sent with
    ///the email message. This property is read/write.
    HRESULT get_Attachments(SAFEARRAY** pAttachements);
    ///<p class="CCE_Message">[This interface is no longer supported. Please use IExecAction with the powershell
    ///Send-MailMessage cmdlet as a workaround.] Gets or sets the pointer to an array of attachments that is sent with
    ///the email message. This property is read/write.
    HRESULT put_Attachments(SAFEARRAY* pAttachements);
}

///Provides the methods that are used to add to, remove from, and get the triggers of a task.
@GUID("85DF5081-1B24-4F32-878A-D9D14DF4CB77")
interface ITriggerCollection : IDispatch
{
    ///Gets the number of triggers in the collection. This property is read-only.
    HRESULT get_Count(int* pCount);
    ///Gets the specified trigger from the collection. This property is read-only.
    HRESULT get_Item(int index, ITrigger* ppTrigger);
    ///Gets the collection enumerator for the trigger collection. This property is read-only.
    HRESULT get__NewEnum(IUnknown* ppEnum);
    ///Creates a new trigger for the task.
    ///Params:
    ///    type = This parameter is set to one of the following TASK_TRIGGER_TYPE2 enumeration constants. <table> <tr>
    ///           <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TASK_TRIGGER_EVENT"></a><a
    ///           id="task_trigger_event"></a><dl> <dt><b>TASK_TRIGGER_EVENT</b></dt> <dt>0</dt> </dl> </td> <td width="60%">
    ///           Triggers the task when a specific event occurs. </td> </tr> <tr> <td width="40%"><a
    ///           id="TASK_TRIGGER_TIME"></a><a id="task_trigger_time"></a><dl> <dt><b>TASK_TRIGGER_TIME</b></dt> <dt>1</dt>
    ///           </dl> </td> <td width="60%"> Triggers the task at a specific time of day. </td> </tr> <tr> <td width="40%"><a
    ///           id="TASK_TRIGGER_DAILY"></a><a id="task_trigger_daily"></a><dl> <dt><b>TASK_TRIGGER_DAILY</b></dt> <dt>2</dt>
    ///           </dl> </td> <td width="60%"> Triggers the task on a daily schedule. For example, the task starts at a
    ///           specific time every day, every-other day, every third day, and so on. </td> </tr> <tr> <td width="40%"><a
    ///           id="TASK_TRIGGER_WEEKLY"></a><a id="task_trigger_weekly"></a><dl> <dt><b>TASK_TRIGGER_WEEKLY</b></dt>
    ///           <dt>3</dt> </dl> </td> <td width="60%"> Triggers the task on a weekly schedule. For example, the task starts
    ///           at 8:00 AM on a specific day every week or other week. </td> </tr> <tr> <td width="40%"><a
    ///           id="TASK_TRIGGER_MONTHLY"></a><a id="task_trigger_monthly"></a><dl> <dt><b>TASK_TRIGGER_MONTHLY</b></dt>
    ///           <dt>4</dt> </dl> </td> <td width="60%"> Triggers the task on a monthly schedule. For example, the task starts
    ///           on specific days of specific months. </td> </tr> <tr> <td width="40%"><a id="TASK_TRIGGER_MONTHLYDOW"></a><a
    ///           id="task_trigger_monthlydow"></a><dl> <dt><b>TASK_TRIGGER_MONTHLYDOW</b></dt> <dt>5</dt> </dl> </td> <td
    ///           width="60%"> Triggers the task on a monthly day-of-week schedule. For example, the task starts on a specific
    ///           days of the week, weeks of the month, and months of the year. </td> </tr> <tr> <td width="40%"><a
    ///           id="TASK_TRIGGER_IDLE"></a><a id="task_trigger_idle"></a><dl> <dt><b>TASK_TRIGGER_IDLE</b></dt> <dt>6</dt>
    ///           </dl> </td> <td width="60%"> Triggers the task when the computer goes into an idle state. </td> </tr> <tr>
    ///           <td width="40%"><a id="TASK_TRIGGER_REGISTRATION"></a><a id="task_trigger_registration"></a><dl>
    ///           <dt><b>TASK_TRIGGER_REGISTRATION</b></dt> <dt>7</dt> </dl> </td> <td width="60%"> Triggers the task when the
    ///           task is registered. </td> </tr> <tr> <td width="40%"><a id="TASK_TRIGGER_BOOT"></a><a
    ///           id="task_trigger_boot"></a><dl> <dt><b>TASK_TRIGGER_BOOT</b></dt> <dt>8</dt> </dl> </td> <td width="60%">
    ///           Triggers the task when the computer boots. </td> </tr> <tr> <td width="40%"><a id="TASK_TRIGGER_LOGON"></a><a
    ///           id="task_trigger_logon"></a><dl> <dt><b>TASK_TRIGGER_LOGON</b></dt> <dt>9</dt> </dl> </td> <td width="60%">
    ///           Triggers the task when a specific user logs on. </td> </tr> <tr> <td width="40%"><a
    ///           id="TASK_TRIGGER_SESSION_STATE_CHANGE"></a><a id="task_trigger_session_state_change"></a><dl>
    ///           <dt><b>TASK_TRIGGER_SESSION_STATE_CHANGE</b></dt> <dt>11</dt> </dl> </td> <td width="60%"> Triggers the task
    ///           when a specific session state changes. </td> </tr> </table>
    ///    ppTrigger = An ITrigger interface that represents the new trigger. Pass in a reference to a <b>NULL</b> ITrigger
    ///                interface pointer. Referencing a non-<b>NULL</b> pointer can cause a memory leak because the pointer will be
    ///                overwritten.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Create(TASK_TRIGGER_TYPE2 type, ITrigger* ppTrigger);
    ///Removes the specified trigger from the collection of triggers used by the task.
    ///Params:
    ///    index = The index of the trigger to be removed. Use a LONG value for the index number.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Remove(VARIANT index);
    ///Clears all triggers from the collection.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Clear();
}

///Contains the actions that are performed by the task.
@GUID("02820E19-7B98-4ED2-B2E8-FDCCCEFF619B")
interface IActionCollection : IDispatch
{
    ///Gets the number of actions in the collection. This property is read-only.
    HRESULT get_Count(int* pCount);
    ///Gets a specified action from the collection. This property is read-only.
    HRESULT get_Item(int index, IAction* ppAction);
    ///Gets the collection enumerator for the action collection. This property is read-only.
    HRESULT get__NewEnum(IUnknown* ppEnum);
    ///Gets or sets an XML-formatted version of the collection. This property is read/write.
    HRESULT get_XmlText(BSTR* pText);
    ///Gets or sets an XML-formatted version of the collection. This property is read/write.
    HRESULT put_XmlText(BSTR text);
    ///Creates and adds a new action to the collection.
    ///Params:
    ///    type = This parameter is set to one of the following TASK_ACTION_TYPE enumeration constants. <table> <tr>
    ///           <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TASK_ACTION_EXEC"></a><a
    ///           id="task_action_exec"></a><dl> <dt><b>TASK_ACTION_EXEC</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The
    ///           action performs a command-line operation. For example, the action could run a script, start an executable,
    ///           or, if the name of a document is provided, find its associated application and start the application with the
    ///           document. </td> </tr> <tr> <td width="40%"><a id="TASK_ACTION_COM_HANDLER"></a><a
    ///           id="task_action_com_handler"></a><dl> <dt><b>TASK_ACTION_COM_HANDLER</b></dt> <dt>5</dt> </dl> </td> <td
    ///           width="60%"> The action fires a handler. </td> </tr> <tr> <td width="40%"><a
    ///           id="TASK_ACTION_SEND_EMAIL"></a><a id="task_action_send_email"></a><dl>
    ///           <dt><b>TASK_ACTION_SEND_EMAIL</b></dt> <dt>6</dt> </dl> </td> <td width="60%"> This action sends an email
    ///           message. </td> </tr> <tr> <td width="40%"><a id="TASK_ACTION_SHOW_MESSAGE"></a><a
    ///           id="task_action_show_message"></a><dl> <dt><b>TASK_ACTION_SHOW_MESSAGE</b></dt> <dt>7</dt> </dl> </td> <td
    ///           width="60%"> This action shows a message box. </td> </tr> </table>
    ///    ppAction = An IAction interface that represents the new action. Pass in a reference to a <b>NULL</b> IAction interface
    ///               pointer. Referencing a non-<b>NULL</b> pointer can cause a memory leak because the pointer will be
    ///               overwritten.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Create(TASK_ACTION_TYPE type, IAction* ppAction);
    ///Removes the specified action from the collection.
    ///Params:
    ///    index = The index of the action to be removed. Use a LONG value for the index number.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Remove(VARIANT index);
    ///Clears all the actions from the collection.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Clear();
    ///Gets or sets the identifier of the principal for the task. The principal of the task specifies the security
    ///context under which the actions of the task are performed. This property is read/write.
    HRESULT get_Context(BSTR* pContext);
    ///Gets or sets the identifier of the principal for the task. The principal of the task specifies the security
    ///context under which the actions of the task are performed. This property is read/write.
    HRESULT put_Context(BSTR context);
}

///Provides the security credentials for a principal. These security credentials define the security context for the
///tasks that are associated with the principal.
@GUID("D98D51E5-C9B4-496A-A9C1-18980261CF0F")
interface IPrincipal : IDispatch
{
    ///Gets or sets the identifier of the principal. This property is read/write.
    HRESULT get_Id(BSTR* pId);
    ///Gets or sets the identifier of the principal. This property is read/write.
    HRESULT put_Id(BSTR Id);
    ///Gets or sets the name of the principal. This property is read/write.
    HRESULT get_DisplayName(BSTR* pName);
    ///Gets or sets the name of the principal. This property is read/write.
    HRESULT put_DisplayName(BSTR name);
    ///Gets or sets the user identifier that is required to run the tasks that are associated with the principal. This
    ///property is read/write.
    HRESULT get_UserId(BSTR* pUser);
    ///Gets or sets the user identifier that is required to run the tasks that are associated with the principal. This
    ///property is read/write.
    HRESULT put_UserId(BSTR user);
    ///Gets or sets the security logon method that is required to run the tasks that are associated with the principal.
    ///This property is read/write.
    HRESULT get_LogonType(TASK_LOGON_TYPE* pLogon);
    ///Gets or sets the security logon method that is required to run the tasks that are associated with the principal.
    ///This property is read/write.
    HRESULT put_LogonType(TASK_LOGON_TYPE logon);
    ///Gets or sets the identifier of the user group that is required to run the tasks that are associated with the
    ///principal. This property is read/write.
    HRESULT get_GroupId(BSTR* pGroup);
    ///Gets or sets the identifier of the user group that is required to run the tasks that are associated with the
    ///principal. This property is read/write.
    HRESULT put_GroupId(BSTR group);
    ///Gets or sets the identifier that is used to specify the privilege level that is required to run the tasks that
    ///are associated with the principal. This property is read/write.
    HRESULT get_RunLevel(TASK_RUNLEVEL_TYPE* pRunLevel);
    ///Gets or sets the identifier that is used to specify the privilege level that is required to run the tasks that
    ///are associated with the principal. This property is read/write.
    HRESULT put_RunLevel(TASK_RUNLEVEL_TYPE runLevel);
}

///Provides the extended settings applied to security credentials for a principal. These security credentials define the
///security context for the tasks that are associated with the principal.
@GUID("248919AE-E345-4A6D-8AEB-E0D3165C904E")
interface IPrincipal2 : IDispatch
{
    ///Gets or sets the task process security identifier (SID) type. This property is read/write.
    HRESULT get_ProcessTokenSidType(TASK_PROCESSTOKENSID_TYPE* pProcessTokenSidType);
    ///Gets or sets the task process security identifier (SID) type. This property is read/write.
    HRESULT put_ProcessTokenSidType(TASK_PROCESSTOKENSID_TYPE processTokenSidType);
    ///Gets the number of privileges in the required privileges array. This property is read-only.
    HRESULT get_RequiredPrivilegeCount(int* pCount);
    ///Gets the required privilege of the task by index. This property is read-only.
    HRESULT get_RequiredPrivilege(int index, BSTR* pPrivilege);
    ///Adds the required privilege to the task process token.
    ///Params:
    ///    privilege = Specifies the right of a task to perform various system-related operations, such as shutting down the system,
    ///                loading device drivers, or changing the system time.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddRequiredPrivilege(BSTR privilege);
}

///Provides the administrative information that can be used to describe the task. This information includes details such
///as a description of the task, the author of the task, the date the task is registered, and the security descriptor of
///the task.
@GUID("416D8B73-CB41-4EA1-805C-9BE9A5AC4A74")
interface IRegistrationInfo : IDispatch
{
    ///Gets or sets the description of the task. This property is read/write.
    HRESULT get_Description(BSTR* pDescription);
    ///Gets or sets the description of the task. This property is read/write.
    HRESULT put_Description(BSTR description);
    ///Gets or sets the author of the task. This property is read/write.
    HRESULT get_Author(BSTR* pAuthor);
    ///Gets or sets the author of the task. This property is read/write.
    HRESULT put_Author(BSTR author);
    ///Gets or sets the version number of the task. This property is read/write.
    HRESULT get_Version(BSTR* pVersion);
    ///Gets or sets the version number of the task. This property is read/write.
    HRESULT put_Version(BSTR version_);
    ///Gets or sets the date and time when the task is registered. This property is read/write.
    HRESULT get_Date(BSTR* pDate);
    ///Gets or sets the date and time when the task is registered. This property is read/write.
    HRESULT put_Date(BSTR date);
    ///Gets or sets any additional documentation for the task. This property is read/write.
    HRESULT get_Documentation(BSTR* pDocumentation);
    ///Gets or sets any additional documentation for the task. This property is read/write.
    HRESULT put_Documentation(BSTR documentation);
    ///Gets or sets an XML-formatted version of the registration information for the task. This property is read/write.
    HRESULT get_XmlText(BSTR* pText);
    ///Gets or sets an XML-formatted version of the registration information for the task. This property is read/write.
    HRESULT put_XmlText(BSTR text);
    ///Gets or sets the URI of the task. This property is read/write.
    HRESULT get_URI(BSTR* pUri);
    ///Gets or sets the URI of the task. This property is read/write.
    HRESULT put_URI(BSTR uri);
    ///Gets or sets the security descriptor of the task. If a different security descriptor is supplied during task
    ///registration, it will supersede the security descriptor that is set with this property. This property is
    ///read/write.
    HRESULT get_SecurityDescriptor(VARIANT* pSddl);
    ///Gets or sets the security descriptor of the task. If a different security descriptor is supplied during task
    ///registration, it will supersede the security descriptor that is set with this property. This property is
    ///read/write.
    HRESULT put_SecurityDescriptor(VARIANT sddl);
    ///Gets or sets where the task originated from. For example, a task may originate from a component, service,
    ///application, or user. This property is read/write.
    HRESULT get_Source(BSTR* pSource);
    ///Gets or sets where the task originated from. For example, a task may originate from a component, service,
    ///application, or user. This property is read/write.
    HRESULT put_Source(BSTR source);
}

///Defines all the components of a task, such as the task settings, triggers, actions, and registration information.
@GUID("F5BC8FC5-536D-4F77-B852-FBC1356FDEB6")
interface ITaskDefinition : IDispatch
{
    ///Gets or sets the registration information used to describe a task, such as the description of the task, the
    ///author of the task, and the date the task is registered. This property is read/write.
    HRESULT get_RegistrationInfo(IRegistrationInfo* ppRegistrationInfo);
    ///Gets or sets the registration information used to describe a task, such as the description of the task, the
    ///author of the task, and the date the task is registered. This property is read/write.
    HRESULT put_RegistrationInfo(IRegistrationInfo pRegistrationInfo);
    ///Gets or sets a collection of triggers used to start a task. This property is read/write.
    HRESULT get_Triggers(ITriggerCollection* ppTriggers);
    ///Gets or sets a collection of triggers used to start a task. This property is read/write.
    HRESULT put_Triggers(ITriggerCollection pTriggers);
    ///Gets or sets the settings that define how the Task Scheduler service performs the task. This property is
    ///read/write.
    HRESULT get_Settings(ITaskSettings* ppSettings);
    ///Gets or sets the settings that define how the Task Scheduler service performs the task. This property is
    ///read/write.
    HRESULT put_Settings(ITaskSettings pSettings);
    ///Gets or sets the data that is associated with the task. This data is ignored by the Task Scheduler service, but
    ///is used by third-parties who wish to extend the task format. This property is read/write.
    HRESULT get_Data(BSTR* pData);
    ///Gets or sets the data that is associated with the task. This data is ignored by the Task Scheduler service, but
    ///is used by third-parties who wish to extend the task format. This property is read/write.
    HRESULT put_Data(BSTR data);
    ///Gets or sets the principal for the task that provides the security credentials for the task. This property is
    ///read/write.
    HRESULT get_Principal(IPrincipal* ppPrincipal);
    ///Gets or sets the principal for the task that provides the security credentials for the task. This property is
    ///read/write.
    HRESULT put_Principal(IPrincipal pPrincipal);
    ///Gets or sets a collection of actions performed by the task. This property is read/write.
    HRESULT get_Actions(IActionCollection* ppActions);
    ///Gets or sets a collection of actions performed by the task. This property is read/write.
    HRESULT put_Actions(IActionCollection pActions);
    ///Gets or sets the XML-formatted definition of the task. This property is read/write.
    HRESULT get_XmlText(BSTR* pXml);
    ///Gets or sets the XML-formatted definition of the task. This property is read/write.
    HRESULT put_XmlText(BSTR xml);
}

///Provides the settings that the Task Scheduler service uses to perform the task.
@GUID("8FD4711D-2D02-4C8C-87E3-EFF699DE127E")
interface ITaskSettings : IDispatch
{
    ///Gets or sets a Boolean value that indicates that the task can be started by using either the Run command or the
    ///Context menu. This property is read/write.
    HRESULT get_AllowDemandStart(short* pAllowDemandStart);
    ///Gets or sets a Boolean value that indicates that the task can be started by using either the Run command or the
    ///Context menu. This property is read/write.
    HRESULT put_AllowDemandStart(short allowDemandStart);
    ///Gets or sets a value that specifies how long the Task Scheduler will attempt to restart the task. This property
    ///is read/write.
    HRESULT get_RestartInterval(BSTR* pRestartInterval);
    ///Gets or sets a value that specifies how long the Task Scheduler will attempt to restart the task. This property
    ///is read/write.
    HRESULT put_RestartInterval(BSTR restartInterval);
    ///Gets or sets the number of times that the Task Scheduler will attempt to restart the task. This property is
    ///read/write.
    HRESULT get_RestartCount(int* pRestartCount);
    ///Gets or sets the number of times that the Task Scheduler will attempt to restart the task. This property is
    ///read/write.
    HRESULT put_RestartCount(int restartCount);
    ///Gets or sets the policy that defines how the Task Scheduler deals with multiple instances of the task. This
    ///property is read/write.
    HRESULT get_MultipleInstances(TASK_INSTANCES_POLICY* pPolicy);
    ///Gets or sets the policy that defines how the Task Scheduler deals with multiple instances of the task. This
    ///property is read/write.
    HRESULT put_MultipleInstances(TASK_INSTANCES_POLICY policy);
    ///Gets or sets a Boolean value that indicates that the task will be stopped if the computer is going onto
    ///batteries. This property is read/write.
    HRESULT get_StopIfGoingOnBatteries(short* pStopIfOnBatteries);
    ///Gets or sets a Boolean value that indicates that the task will be stopped if the computer is going onto
    ///batteries. This property is read/write.
    HRESULT put_StopIfGoingOnBatteries(short stopIfOnBatteries);
    ///Gets or sets a Boolean value that indicates that the task will not be started if the computer is running on
    ///batteries. This property is read/write.
    HRESULT get_DisallowStartIfOnBatteries(short* pDisallowStart);
    ///Gets or sets a Boolean value that indicates that the task will not be started if the computer is running on
    ///batteries. This property is read/write.
    HRESULT put_DisallowStartIfOnBatteries(short disallowStart);
    ///Gets or sets a Boolean value that indicates that the task may be terminated by the Task Scheduler service using
    ///TerminateProcess. The service will try to close the running task by sending the WM_CLOSE notification, and if the
    ///task does not respond, the task will be terminated only if this property is set to true. This property is
    ///read/write.
    HRESULT get_AllowHardTerminate(short* pAllowHardTerminate);
    ///Gets or sets a Boolean value that indicates that the task may be terminated by the Task Scheduler service using
    ///TerminateProcess. The service will try to close the running task by sending the WM_CLOSE notification, and if the
    ///task does not respond, the task will be terminated only if this property is set to true. This property is
    ///read/write.
    HRESULT put_AllowHardTerminate(short allowHardTerminate);
    ///Gets or sets a Boolean value that indicates that the Task Scheduler can start the task at any time after its
    ///scheduled time has passed. This property is read/write.
    HRESULT get_StartWhenAvailable(short* pStartWhenAvailable);
    ///Gets or sets a Boolean value that indicates that the Task Scheduler can start the task at any time after its
    ///scheduled time has passed. This property is read/write.
    HRESULT put_StartWhenAvailable(short startWhenAvailable);
    ///Gets or sets an XML-formatted definition of the task settings. This property is read/write.
    HRESULT get_XmlText(BSTR* pText);
    ///Gets or sets an XML-formatted definition of the task settings. This property is read/write.
    HRESULT put_XmlText(BSTR text);
    ///Gets or sets a Boolean value that indicates that the Task Scheduler will run the task only when a network is
    ///available. This property is read/write.
    HRESULT get_RunOnlyIfNetworkAvailable(short* pRunOnlyIfNetworkAvailable);
    ///Gets or sets a Boolean value that indicates that the Task Scheduler will run the task only when a network is
    ///available. This property is read/write.
    HRESULT put_RunOnlyIfNetworkAvailable(short runOnlyIfNetworkAvailable);
    ///Gets or sets the amount of time that is allowed to complete the task. By default, a task will be stopped 72 hours
    ///after it starts to run. You can change this by changing this setting. This property is read/write.
    HRESULT get_ExecutionTimeLimit(BSTR* pExecutionTimeLimit);
    ///Gets or sets the amount of time that is allowed to complete the task. By default, a task will be stopped 72 hours
    ///after it starts to run. You can change this by changing this setting. This property is read/write.
    HRESULT put_ExecutionTimeLimit(BSTR executionTimeLimit);
    ///Gets or sets a Boolean value that indicates that the task is enabled. The task can be performed only when this
    ///setting is True. This property is read-only.
    HRESULT get_Enabled(short* pEnabled);
    HRESULT put_Enabled(short enabled);
    ///Gets or sets the amount of time that the Task Scheduler will wait before deleting the task after it expires. If
    ///no value is specified for this property, then the Task Scheduler service will not delete the task. This property
    ///is read/write.
    HRESULT get_DeleteExpiredTaskAfter(BSTR* pExpirationDelay);
    ///Gets or sets the amount of time that the Task Scheduler will wait before deleting the task after it expires. If
    ///no value is specified for this property, then the Task Scheduler service will not delete the task. This property
    ///is read/write.
    HRESULT put_DeleteExpiredTaskAfter(BSTR expirationDelay);
    ///Gets or sets the priority level of the task. This property is read/write.
    HRESULT get_Priority(int* pPriority);
    ///Gets or sets the priority level of the task. This property is read/write.
    HRESULT put_Priority(int priority);
    ///Gets or sets an integer value that indicates which version of Task Scheduler a task is compatible with. This
    ///property is read/write.
    HRESULT get_Compatibility(TASK_COMPATIBILITY* pCompatLevel);
    ///Gets or sets an integer value that indicates which version of Task Scheduler a task is compatible with. This
    ///property is read/write.
    HRESULT put_Compatibility(TASK_COMPATIBILITY compatLevel);
    ///Gets or sets a Boolean value that indicates that the task will not be visible in the UI. However, administrators
    ///can override this setting through the use of a 'master switch' that makes all tasks visible in the UI. This
    ///property is read/write.
    HRESULT get_Hidden(short* pHidden);
    ///Gets or sets a Boolean value that indicates that the task will not be visible in the UI. However, administrators
    ///can override this setting through the use of a 'master switch' that makes all tasks visible in the UI. This
    ///property is read/write.
    HRESULT put_Hidden(short hidden);
    ///Gets or sets the information that specifies how the Task Scheduler performs tasks when the computer is in an idle
    ///condition. For information about idle conditions, see Task Idle Conditions. This property is read/write.
    HRESULT get_IdleSettings(IIdleSettings* ppIdleSettings);
    ///Gets or sets the information that specifies how the Task Scheduler performs tasks when the computer is in an idle
    ///condition. For information about idle conditions, see Task Idle Conditions. This property is read/write.
    HRESULT put_IdleSettings(IIdleSettings pIdleSettings);
    ///Gets or sets a Boolean value that indicates that the Task Scheduler will run the task only if the computer is in
    ///an idle condition. This property is read/write.
    HRESULT get_RunOnlyIfIdle(short* pRunOnlyIfIdle);
    ///Gets or sets a Boolean value that indicates that the Task Scheduler will run the task only if the computer is in
    ///an idle condition. This property is read/write.
    HRESULT put_RunOnlyIfIdle(short runOnlyIfIdle);
    ///Gets or sets a Boolean value that indicates that the Task Scheduler will wake the computer when it is time to run
    ///the task, and keep the computer awake until the task is completed. This property is read/write.
    HRESULT get_WakeToRun(short* pWake);
    ///Gets or sets a Boolean value that indicates that the Task Scheduler will wake the computer when it is time to run
    ///the task, and keep the computer awake until the task is completed. This property is read/write.
    HRESULT put_WakeToRun(short wake);
    ///Gets or sets the network settings object that contains a network profile identifier and name. If the
    ///RunOnlyIfNetworkAvailable property of ITaskSettings is <b>true</b> and a network propfile is specified in the
    ///<b>NetworkSettings</b> property, then the task will run only if the specified network profile is available. This
    ///property is read/write.
    HRESULT get_NetworkSettings(INetworkSettings* ppNetworkSettings);
    ///Gets or sets the network settings object that contains a network profile identifier and name. If the
    ///RunOnlyIfNetworkAvailable property of ITaskSettings is <b>true</b> and a network propfile is specified in the
    ///<b>NetworkSettings</b> property, then the task will run only if the specified network profile is available. This
    ///property is read/write.
    HRESULT put_NetworkSettings(INetworkSettings pNetworkSettings);
}

///Provides the extended settings that the Task Scheduler uses to run the task.
@GUID("2C05C3F0-6EED-4C05-A15F-ED7D7A98A369")
interface ITaskSettings2 : IDispatch
{
    ///Gets or sets a Boolean value that specifies that the task will not be started if triggered to run in a Remote
    ///Applications Integrated Locally (RAIL) session. This property is read/write.
    HRESULT get_DisallowStartOnRemoteAppSession(short* pDisallowStart);
    ///Gets or sets a Boolean value that specifies that the task will not be started if triggered to run in a Remote
    ///Applications Integrated Locally (RAIL) session. This property is read/write.
    HRESULT put_DisallowStartOnRemoteAppSession(short disallowStart);
    ///Gets or sets a Boolean value that indicates that the Unified Scheduling Engine will be utilized to run this task.
    ///This property is read/write.
    HRESULT get_UseUnifiedSchedulingEngine(short* pUseUnifiedEngine);
    ///Gets or sets a Boolean value that indicates that the Unified Scheduling Engine will be utilized to run this task.
    ///This property is read/write.
    HRESULT put_UseUnifiedSchedulingEngine(short useUnifiedEngine);
}

///Provides the extended settings that the Task Scheduler uses to run the task.
@GUID("0AD9D0D7-0C7F-4EBB-9A5F-D1C648DCA528")
interface ITaskSettings3 : ITaskSettings
{
    HRESULT get_DisallowStartOnRemoteAppSession(short* pDisallowStart);
    HRESULT put_DisallowStartOnRemoteAppSession(short disallowStart);
    HRESULT get_UseUnifiedSchedulingEngine(short* pUseUnifiedEngine);
    HRESULT put_UseUnifiedSchedulingEngine(short useUnifiedEngine);
    ///Gets or sets a pointer to pointer to an IMaintenanceSettingsobject that Task scheduler uses to perform a task
    ///during Automatic maintenance. This property is read/write.
    HRESULT get_MaintenanceSettings(IMaintenanceSettings* ppMaintenanceSettings);
    ///Gets or sets a pointer to pointer to an IMaintenanceSettingsobject that Task scheduler uses to perform a task
    ///during Automatic maintenance. This property is read/write.
    HRESULT put_MaintenanceSettings(IMaintenanceSettings pMaintenanceSettings);
    HRESULT CreateMaintenanceSettings(IMaintenanceSettings* ppMaintenanceSettings);
    ///Gets or sets a boolean value that indicates whether the task is automatically disabled every time Windows starts.
    ///This property is read/write.
    HRESULT get_Volatile(short* pVolatile);
    ///Gets or sets a boolean value that indicates whether the task is automatically disabled every time Windows starts.
    ///This property is read/write.
    HRESULT put_Volatile(short Volatile);
}

///Provides the settings that the Task Scheduler uses to perform task during Automatic maintenance.
@GUID("A6024FA8-9652-4ADB-A6BF-5CFCD877A7BA")
interface IMaintenanceSettings : IDispatch
{
    ///Gets or sets the amount of time the task needs to be once executed during regular Automatic maintenance. This
    ///property is read/write.
    HRESULT put_Period(BSTR value);
    ///Gets or sets the amount of time the task needs to be once executed during regular Automatic maintenance. This
    ///property is read/write.
    HRESULT get_Period(BSTR* target);
    ///Gets or sets the amount of time after which the Task scheduler attempts to run the task during emergency
    ///Automatic maintenance, if the task failed to complete during regular Automatic maintenance. This property is
    ///read/write.
    HRESULT put_Deadline(BSTR value);
    ///Gets or sets the amount of time after which the Task scheduler attempts to run the task during emergency
    ///Automatic maintenance, if the task failed to complete during regular Automatic maintenance. This property is
    ///read/write.
    HRESULT get_Deadline(BSTR* target);
    ///Indicates whether the Task scheduler must start the task during the Automatic maintenance in exclusive mode. The
    ///exclusivity is guaranteed only between other maintenance tasks and doesn't grant any ordering priority of the
    ///task. If exclusivity is not specified, the task is started in parallel with other maintenance tasks. This
    ///property is read/write.
    HRESULT put_Exclusive(short value);
    ///Indicates whether the Task scheduler must start the task during the Automatic maintenance in exclusive mode. The
    ///exclusivity is guaranteed only between other maintenance tasks and doesn't grant any ordering priority of the
    ///task. If exclusivity is not specified, the task is started in parallel with other maintenance tasks. This
    ///property is read/write.
    HRESULT get_Exclusive(short* target);
}

///Contains all the tasks that are registered.
@GUID("86627EB4-42A7-41E4-A4D9-AC33A72F2D52")
interface IRegisteredTaskCollection : IDispatch
{
    ///Gets the number of registered tasks in the collection. This property is read-only.
    HRESULT get_Count(int* pCount);
    ///Gets the specified registered task from the collection. This property is read-only.
    HRESULT get_Item(VARIANT index, IRegisteredTask* ppRegisteredTask);
    ///Gets the collection enumerator for the register task collection. This property is read-only.
    HRESULT get__NewEnum(IUnknown* ppEnum);
}

///Provides the methods that are used to register (create) tasks in the folder, remove tasks from the folder, and create
///or remove subfolders from the folder.
@GUID("8CFAC062-A080-4C15-9A88-AA7C2AF80DFC")
interface ITaskFolder : IDispatch
{
    ///Gets the name that is used to identify the folder that contains a task. This property is read-only.
    HRESULT get_Name(BSTR* pName);
    ///Gets the path to where the folder is stored. This property is read-only.
    HRESULT get_Path(BSTR* pPath);
    ///Gets a folder that contains tasks at a specified location.
    ///Params:
    ///    path = The path (location) to the folder. Do not use a backslash following the last folder name in the path. The
    ///           root task folder is specified with a backslash (\\). An example of a task folder path, under the root task
    ///           folder, is \MyTaskFolder. The '.' character cannot be used to specify the current task folder and the '..'
    ///           characters cannot be used to specify the parent task folder in the path.
    ///    ppFolder = The folder at the specified location. Pass in a reference to a <b>NULL</b> ITaskFolder interface pointer.
    ///               Referencing a non-<b>NULL</b> pointer can cause a memory leak because the pointer will be overwritten.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFolder(BSTR path, ITaskFolder* ppFolder);
    ///Gets all the subfolders in the folder.
    ///Params:
    ///    flags = This parameter is reserved for future use and must be set to 0.
    ///    ppFolders = The collection of subfolders in the folder. Pass in a reference to a <b>NULL</b> ITaskFolderCollection
    ///                interface pointer. Referencing a non-<b>NULL</b> pointer can cause a memory leak because the pointer will be
    ///                overwritten.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetFolders(int flags, ITaskFolderCollection* ppFolders);
    ///Creates a folder for related tasks.
    ///Params:
    ///    subFolderName = The name used to identify the folder. If "FolderName\SubFolder1\SubFolder2" is specified, the entire folder
    ///                    tree will be created if the folders do not exist. This parameter can be a relative path to the current
    ///                    ITaskFolder instance. The root task folder is specified with a backslash (\\). An example of a task folder
    ///                    path, under the root task folder, is \MyTaskFolder. The '.' character cannot be used to specify the current
    ///                    task folder and the '..' characters cannot be used to specify the parent task folder in the path.
    ///    sddl = The security descriptor associated with the folder, in the form of a VT_BSTR in SDDL_REVISION_1 format.
    ///    ppFolder = An ITaskFolder interface that represents the new subfolder. Pass in a reference to a <b>NULL</b> ITaskFolder
    ///               interface pointer. Referencing a non-<b>NULL</b> pointer can cause a memory leak because the pointer will be
    ///               overwritten.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CreateFolder(BSTR subFolderName, VARIANT sddl, ITaskFolder* ppFolder);
    ///Deletes a subfolder from the parent folder.
    ///Params:
    ///    subFolderName = The name of the subfolder to be removed. The root task folder is specified with a backslash (\\). This
    ///                    parameter can be a relative path to the folder you want to delete. An example of a task folder path, under
    ///                    the root task folder, is \MyTaskFolder. The '.' character cannot be used to specify the current task folder
    ///                    and the '..' characters cannot be used to specify the parent task folder in the path.
    ///    flags = Not supported.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DeleteFolder(BSTR subFolderName, int flags);
    ///Gets a task at a specified location in a folder.
    ///Params:
    ///    path = The path (location) to the task in a folder. The root task folder is specified with a backslash (\\). An
    ///           example of a task folder path, under the root task folder, is \MyTaskFolder. The '.' character cannot be used
    ///           to specify the current task folder and the '..' characters cannot be used to specify the parent task folder
    ///           in the path.
    ///    ppTask = The task at the specified location. Pass in a reference to a <b>NULL</b> IRegisteredTask interface pointer.
    ///             Referencing a non-<b>NULL</b> pointer can cause a memory leak because the pointer will be overwritten.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetTask(BSTR path, IRegisteredTask* ppTask);
    ///Gets all the tasks in the folder.
    ///Params:
    ///    flags = Specifies whether to retrieve hidden tasks. Pass in TASK_ENUM_HIDDEN to retrieve all tasks in the folder
    ///            including hidden tasks, and pass in 0 to retrieve all the tasks in the folder excluding the hidden tasks.
    ///    ppTasks = An IRegisteredTaskCollection collection of all the tasks in the folder. Pass in a reference to a <b>NULL</b>
    ///              IRegisteredTaskCollection interface pointer. Referencing a non-<b>NULL</b> pointer can cause a memory leak
    ///              because the pointer will be overwritten.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetTasks(int flags, IRegisteredTaskCollection* ppTasks);
    ///Deletes a task from the folder.
    ///Params:
    ///    name = The name of the task that is specified when the task was registered. The '.' character cannot be used to
    ///           specify the current task folder and the '..' characters cannot be used to specify the parent task folder in
    ///           the path.
    ///    flags = Not supported.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT DeleteTask(BSTR name, int flags);
    ///Registers (creates) a new task in the folder using XML to define the task.
    ///Params:
    ///    path = The task name. If this value is <b>NULL</b>, the task will be registered in the root task folder and the task
    ///           name will be a GUID value that is created by the Task Scheduler service. A task name cannot begin or end with
    ///           a space character. The '.' character cannot be used to specify the current task folder and the '..'
    ///           characters cannot be used to specify the parent task folder in the path.
    ///    xmlText = An XML-formatted definition of the task. The following topics contain tasks defined using XML.<ul> <li> Time
    ///              Trigger Example (XML) </li> <li> Event Trigger Example (XML) </li> <li> Daily Trigger Example (XML) </li>
    ///              <li> Registration Trigger Example (XML) </li> <li> Weekly Trigger Example (XML) </li> <li> Logon Trigger
    ///              Example (XML) </li> <li> Boot Trigger Example (XML) </li> </ul>
    ///    flags = A TASK_CREATION constant. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///            id="TASK_VALIDATE_ONLY"></a><a id="task_validate_only"></a><dl> <dt><b>TASK_VALIDATE_ONLY</b></dt>
    ///            <dt>0x1</dt> </dl> </td> <td width="60%"> The Task Scheduler verifies the syntax of the XML that describes
    ///            the task, but does not register the task. This constant cannot be combined with the <b>TASK_CREATE</b>,
    ///            <b>TASK_UPDATE</b>, or <b>TASK_CREATE_OR_UPDATE</b> values. </td> </tr> <tr> <td width="40%"><a
    ///            id="TASK_CREATE"></a><a id="task_create"></a><dl> <dt><b>TASK_CREATE</b></dt> <dt>0x2</dt> </dl> </td> <td
    ///            width="60%"> Task Scheduler registers the task as a new task. </td> </tr> <tr> <td width="40%"><a
    ///            id="TASK_UPDATE"></a><a id="task_update"></a><dl> <dt><b>TASK_UPDATE</b></dt> <dt>0x4</dt> </dl> </td> <td
    ///            width="60%"> Task Scheduler registers the task as an updated version of an existing task. When a task with a
    ///            registration trigger is updated, the task will execute after the update occurs. </td> </tr> <tr> <td
    ///            width="40%"><a id="TASK_CREATE_OR_UPDATE"></a><a id="task_create_or_update"></a><dl>
    ///            <dt><b>TASK_CREATE_OR_UPDATE</b></dt> <dt>0x6</dt> </dl> </td> <td width="60%"> Task Scheduler either
    ///            registers the task as a new task or as an updated version if the task already exists. Equivalent to
    ///            TASK_CREATE | TASK_UPDATE. </td> </tr> <tr> <td width="40%"><a id="TASK_DISABLE"></a><a
    ///            id="task_disable"></a><dl> <dt><b>TASK_DISABLE</b></dt> <dt>0x8</dt> </dl> </td> <td width="60%"> Task
    ///            Scheduler disables the existing task. </td> </tr> <tr> <td width="40%"><a
    ///            id="TASK_DONT_ADD_PRINCIPAL_ACE"></a><a id="task_dont_add_principal_ace"></a><dl>
    ///            <dt><b>TASK_DONT_ADD_PRINCIPAL_ACE</b></dt> <dt>0x10</dt> </dl> </td> <td width="60%"> Task Scheduler is
    ///            prevented from adding the allow access-control entry (ACE) for the context principal. When the
    ///            <b>ITaskFolder::RegisterTask</b> function is called with this flag to update a task, the Task Scheduler
    ///            service does not add the ACE for the new context principal and does not remove the ACE from the old context
    ///            principal. </td> </tr> <tr> <td width="40%"><a id="TASK_IGNORE_REGISTRATION_TRIGGERS"></a><a
    ///            id="task_ignore_registration_triggers"></a><dl> <dt><b>TASK_IGNORE_REGISTRATION_TRIGGERS</b></dt>
    ///            <dt>0x20</dt> </dl> </td> <td width="60%"> The Task Scheduler creates the task, but ignores the registration
    ///            triggers in the task. By ignoring the registration triggers, the task will not execute when it is registered
    ///            unless a time-based trigger causes it to execute on registration. </td> </tr> </table>
    ///    userId = The user credentials used to register the task. <div class="alert"><b>Note</b> If the task is defined as a
    ///             Task Scheduler 1.0 task, then do not use a group name (rather than a specific user name) in this userId
    ///             parameter. A task is defined as a Task Scheduler 1.0 task when the version attribute of the Task element in
    ///             the task's XML is set to 1.1.</div> <div> </div>
    ///    password = The password for the userId used to register the task. When the TASK_LOGON_SERVICE_ACCOUNT logon type is
    ///               used, the password must be an empty <b>VARIANT</b> value such as <b>VT_NULL</b> or <b>VT_EMPTY</b>.
    ///    logonType = A value that defines what logon technique is used to run the registered task. <table> <tr> <th>Value</th>
    ///                <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TASK_LOGON_NONE"></a><a id="task_logon_none"></a><dl>
    ///                <dt><b>TASK_LOGON_NONE</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The logon method is not specified.
    ///                Used for non-NT credentials. </td> </tr> <tr> <td width="40%"><a id="TASK_LOGON_PASSWORD"></a><a
    ///                id="task_logon_password"></a><dl> <dt><b>TASK_LOGON_PASSWORD</b></dt> <dt>1</dt> </dl> </td> <td width="60%">
    ///                Use a password for logging on the user. The password must be supplied at registration time. </td> </tr> <tr>
    ///                <td width="40%"><a id="TASK_LOGON_S4U"></a><a id="task_logon_s4u"></a><dl> <dt><b>TASK_LOGON_S4U</b></dt>
    ///                <dt>2</dt> </dl> </td> <td width="60%"> Use an existing interactive token to run a task. The user must log on
    ///                using a service for user (S4U) logon. When an S4U logon is used, no password is stored by the system and
    ///                there is no access to either the network or to encrypted files. </td> </tr> <tr> <td width="40%"><a
    ///                id="TASK_LOGON_INTERACTIVE_TOKEN"></a><a id="task_logon_interactive_token"></a><dl>
    ///                <dt><b>TASK_LOGON_INTERACTIVE_TOKEN</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> User must already be
    ///                logged on. The task will be run only in an existing interactive session. </td> </tr> <tr> <td width="40%"><a
    ///                id="TASK_LOGON_GROUP"></a><a id="task_logon_group"></a><dl> <dt><b>TASK_LOGON_GROUP</b></dt> <dt>4</dt> </dl>
    ///                </td> <td width="60%"> Group activation. The <b>groupId</b> field specifies the group. </td> </tr> <tr> <td
    ///                width="40%"><a id="TASK_LOGON_SERVICE_ACCOUNT"></a><a id="task_logon_service_account"></a><dl>
    ///                <dt><b>TASK_LOGON_SERVICE_ACCOUNT</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> Indicates that a Local
    ///                System, Local Service, or Network Service account is used as a security context to run the task. </td> </tr>
    ///                <tr> <td width="40%"><a id="TASK_LOGON_INTERACTIVE_TOKEN_OR_PASSWORD"></a><a
    ///                id="task_logon_interactive_token_or_password"></a><dl>
    ///                <dt><b>TASK_LOGON_INTERACTIVE_TOKEN_OR_PASSWORD</b></dt> <dt>6</dt> </dl> </td> <td width="60%"> First use
    ///                the interactive token. If the user is not logged on (no interactive token is available), then the password is
    ///                used. The password must be specified when a task is registered. This flag is not recommended for new tasks
    ///                because it is less reliable than <b>TASK_LOGON_PASSWORD</b>. </td> </tr> </table>
    ///    sddl = The security descriptor associated with the registered task. You can specify the access control list (ACL) in
    ///           the security descriptor for a task in order to allow or deny certain users and groups access to a task. <div
    ///           class="alert"><b>Note</b> If the Local System account is denied access to a task, then the Task Scheduler
    ///           service can produce unexpected results.</div> <div> </div>
    ///    ppTask = An IRegisteredTask interface that represents the new task. Pass in a reference to a <b>NULL</b>
    ///             IRegisteredTask interface pointer. Referencing a non-<b>NULL</b> pointer can cause a memory leak because the
    ///             pointer will be overwritten.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code/value</th> <th>Description</th>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> <dt>0x0</dt> </dl> </td> <td width="60%"> The operation
    ///    completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESS_DENIED</b></dt>
    ///    <dt>0x80070005</dt> </dl> </td> <td width="60%"> Access is denied to connect to the Task Scheduler service.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> <dt>0x8007000e</dt> </dl> </td> <td
    ///    width="60%"> The application does not have enough memory to complete the operation or the <i>user</i> or
    ///    <i>password</i> has at least one null and one non-null value. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>SCHED_S_BATCH_LOGON_PROBLEM</b></dt> <dt>0x0004131C</dt> </dl> </td> <td width="60%"> The task is
    ///    registered, but may fail to start. Batch logon privilege needs to be enabled for the task principal. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>SCHED_S_SOME_TRIGGERS_FAILED</b></dt> <dt>0x0004131B</dt> </dl> </td>
    ///    <td width="60%"> The task is registered, but not all specified triggers will start the task. </td> </tr>
    ///    </table>
    ///    
    HRESULT RegisterTask(BSTR path, BSTR xmlText, int flags, VARIANT userId, VARIANT password, 
                         TASK_LOGON_TYPE logonType, VARIANT sddl, IRegisteredTask* ppTask);
    ///Registers (creates) a task in a specified location using the ITaskDefinition interface to define a task.
    ///Params:
    ///    path = The name of the task. If this value is <b>NULL</b>, the task will be registered in the root task folder and
    ///           the task name will be a GUID value created by the Task Scheduler service. A task name cannot begin or end
    ///           with a space character. The '.' character cannot be used to specify the current task folder and the '..'
    ///           characters cannot be used to specify the parent task folder in the path.
    ///    pDefinition = The definition of the registered task.
    ///    flags = A TASK_CREATION constant. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///            id="TASK_VALIDATE_ONLY"></a><a id="task_validate_only"></a><dl> <dt><b>TASK_VALIDATE_ONLY</b></dt>
    ///            <dt>0x1</dt> </dl> </td> <td width="60%"> Task Scheduler verifies the syntax of the XML that describes the
    ///            task, but does not register the task. This constant cannot be combined with the <b>TASK_CREATE</b>,
    ///            <b>TASK_UPDATE</b>, or <b>TASK_CREATE_OR_UPDATE</b> values. </td> </tr> <tr> <td width="40%"><a
    ///            id="TASK_CREATE"></a><a id="task_create"></a><dl> <dt><b>TASK_CREATE</b></dt> <dt>0x2</dt> </dl> </td> <td
    ///            width="60%"> Task Scheduler registers the task as a new task. </td> </tr> <tr> <td width="40%"><a
    ///            id="TASK_UPDATE"></a><a id="task_update"></a><dl> <dt><b>TASK_UPDATE</b></dt> <dt>0x4</dt> </dl> </td> <td
    ///            width="60%"> Task Scheduler registers the task as an updated version of an existing task. When a task with a
    ///            registration trigger is updated, the task will execute after the update occurs. </td> </tr> <tr> <td
    ///            width="40%"><a id="TASK_CREATE_OR_UPDATE"></a><a id="task_create_or_update"></a><dl>
    ///            <dt><b>TASK_CREATE_OR_UPDATE</b></dt> <dt>0x6</dt> </dl> </td> <td width="60%"> Task Scheduler either
    ///            registers the task as a new task or as an updated version if the task already exists. Equivalent to
    ///            TASK_CREATE | TASK_UPDATE. </td> </tr> <tr> <td width="40%"><a id="TASK_DISABLE"></a><a
    ///            id="task_disable"></a><dl> <dt><b>TASK_DISABLE</b></dt> <dt>0x8</dt> </dl> </td> <td width="60%"> Task
    ///            Scheduler disables the existing task. </td> </tr> <tr> <td width="40%"><a
    ///            id="TASK_DONT_ADD_PRINCIPAL_ACE"></a><a id="task_dont_add_principal_ace"></a><dl>
    ///            <dt><b>TASK_DONT_ADD_PRINCIPAL_ACE</b></dt> <dt>0x10</dt> </dl> </td> <td width="60%"> Task Scheduler is
    ///            prevented from adding the allow access-control entry (ACE) for the context principal. When the
    ///            <b>ITaskFolder::RegisterTaskDefinition</b> function is called with this flag to update a task, the Task
    ///            Scheduler service does not add the ACE for the new context principal and does not remove the ACE from the old
    ///            context principal. </td> </tr> <tr> <td width="40%"><a id="TASK_IGNORE_REGISTRATION_TRIGGERS"></a><a
    ///            id="task_ignore_registration_triggers"></a><dl> <dt><b>TASK_IGNORE_REGISTRATION_TRIGGERS</b></dt>
    ///            <dt>0x20</dt> </dl> </td> <td width="60%"> The Task Scheduler creates the task, but ignores the registration
    ///            triggers in the task. By ignoring the registration triggers, the task will not execute when it is registered
    ///            unless a time-based trigger causes it to execute on registration. </td> </tr> </table>
    ///    userId = The user credentials used to register the task. If present, these credentials take priority over the
    ///             credentials specified in the task definition object pointed to by the <i>pDefinition</i> parameter. <div
    ///             class="alert"><b>Note</b> If the task is defined as a Task Scheduler 1.0 task, then do not use a group name
    ///             (rather than a specific user name) in this userId parameter. A task is defined as a Task Scheduler 1.0 task
    ///             when the Compatibility property is set to TASK_COMPATIBILITY_V1 in the task's settings.</div> <div> </div>
    ///    password = The password for the userId used to register the task. When the TASK_LOGON_SERVICE_ACCOUNT logon type is
    ///               used, the password must be an empty <b>VARIANT</b> value such as <b>VT_NULL</b> or <b>VT_EMPTY</b>.
    ///    logonType = Defines what logon technique is used to run the registered task. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///                </tr> <tr> <td width="40%"><a id="TASK_LOGON_NONE"></a><a id="task_logon_none"></a><dl>
    ///                <dt><b>TASK_LOGON_NONE</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The logon method is not specified.
    ///                Used for non-NT credentials. </td> </tr> <tr> <td width="40%"><a id="TASK_LOGON_PASSWORD"></a><a
    ///                id="task_logon_password"></a><dl> <dt><b>TASK_LOGON_PASSWORD</b></dt> <dt>1</dt> </dl> </td> <td width="60%">
    ///                Use a password for logging on the user. The password must be supplied at registration time. </td> </tr> <tr>
    ///                <td width="40%"><a id="TASK_LOGON_S4U"></a><a id="task_logon_s4u"></a><dl> <dt><b>TASK_LOGON_S4U</b></dt>
    ///                <dt>2</dt> </dl> </td> <td width="60%"> Use an existing interactive token to run a task. The user must log on
    ///                using a service for user (S4U) logon. When an S4U logon is used, no password is stored by the system and
    ///                there is no access to either the network or to encrypted files. </td> </tr> <tr> <td width="40%"><a
    ///                id="TASK_LOGON_INTERACTIVE_TOKEN"></a><a id="task_logon_interactive_token"></a><dl>
    ///                <dt><b>TASK_LOGON_INTERACTIVE_TOKEN</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> User must already be
    ///                logged on. The task will be run only in an existing interactive session. </td> </tr> <tr> <td width="40%"><a
    ///                id="TASK_LOGON_GROUP"></a><a id="task_logon_group"></a><dl> <dt><b>TASK_LOGON_GROUP</b></dt> <dt>4</dt> </dl>
    ///                </td> <td width="60%"> Group activation. The <b>groupId</b> field specifies the group. </td> </tr> <tr> <td
    ///                width="40%"><a id="TASK_LOGON_SERVICE_ACCOUNT"></a><a id="task_logon_service_account"></a><dl>
    ///                <dt><b>TASK_LOGON_SERVICE_ACCOUNT</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> Indicates that a Local
    ///                System, Local Service, or Network Service account is being used as a security context to run the task. </td>
    ///                </tr> <tr> <td width="40%"><a id="TASK_LOGON_INTERACTIVE_TOKEN_OR_PASSWORD"></a><a
    ///                id="task_logon_interactive_token_or_password"></a><dl>
    ///                <dt><b>TASK_LOGON_INTERACTIVE_TOKEN_OR_PASSWORD</b></dt> <dt>6</dt> </dl> </td> <td width="60%"> First use
    ///                the interactive token. If the user is not logged on (no interactive token is available), then the password is
    ///                used. The password must be specified when a task is registered. This flag is not recommended for new tasks
    ///                because it is less reliable than TASK_LOGON_PASSWORD. </td> </tr> </table>
    ///    sddl = The security descriptor that is associated with the registered task. You can specify the access control list
    ///           (ACL) in the security descriptor for a task in order to allow or deny certain users and groups access to a
    ///           task. <div class="alert"><b>Note</b> If the Local System account is denied access to a task, then the Task
    ///           Scheduler service can produce unexpected results.</div> <div> </div>
    ///    ppTask = An IRegisteredTask interface that represents the new task. Pass in a reference to a <b>NULL</b>
    ///             IRegisteredTask interface pointer. Referencing a non-<b>NULL</b> pointer can cause a memory leak because the
    ///             pointer will be overwritten.
    ///Returns:
    ///    This method can return one of these values. <table> <tr> <th>Return code/value</th> <th>Description</th>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> <dt>0x0</dt> </dl> </td> <td width="60%"> The operation
    ///    completed successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESS_DENIED</b></dt>
    ///    <dt>0x80070005</dt> </dl> </td> <td width="60%"> Access is denied to connect to the Task Scheduler service.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> <dt>0x8007000e</dt> </dl> </td> <td
    ///    width="60%"> The application does not have enough memory to complete the operation or the <i>user</i> or
    ///    <i>password</i> has at least one <b>null</b> and one non-<b>null</b> value. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>SCHED_S_BATCH_LOGON_PROBLEM</b></dt> <dt>0x0004131C</dt> </dl> </td> <td width="60%"> The task is
    ///    registered, but may fail to start. Batch logon privilege needs to be enabled for the task principal. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>SCHED_S_SOME_TRIGGERS_FAILED</b></dt> <dt>0x0004131B</dt> </dl> </td>
    ///    <td width="60%"> The task is registered, but not all specified triggers will start the task. </td> </tr>
    ///    </table>
    ///    
    HRESULT RegisterTaskDefinition(BSTR path, ITaskDefinition pDefinition, int flags, VARIANT userId, 
                                   VARIANT password, TASK_LOGON_TYPE logonType, VARIANT sddl, 
                                   IRegisteredTask* ppTask);
    ///Gets the security descriptor for the folder.
    ///Params:
    ///    securityInformation = The security information from SECURITY_INFORMATION.
    ///    pSddl = The security descriptor for the folder.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSecurityDescriptor(int securityInformation, BSTR* pSddl);
    ///Sets the security descriptor for the folder.
    ///Params:
    ///    sddl = The security descriptor for the folder. <div class="alert"><b>Note</b> If the Local System account is denied
    ///           access to a task folder, then the Task Scheduler service can produce unexpected results.</div> <div> </div>
    ///    flags = A value that specifies how the security descriptor is set.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetSecurityDescriptor(BSTR sddl, int flags);
}

///Specifies how the Task Scheduler performs tasks when the computer is in an idle condition. For information about idle
///conditions, see Task Idle Conditions.
@GUID("84594461-0053-4342-A8FD-088FABF11F32")
interface IIdleSettings : IDispatch
{
    ///Gets or sets a value that indicates the amount of time that the computer must be in an idle state before the task
    ///is run. This property is read/write.
    HRESULT get_IdleDuration(BSTR* pDelay);
    ///Gets or sets a value that indicates the amount of time that the computer must be in an idle state before the task
    ///is run. This property is read/write.
    HRESULT put_IdleDuration(BSTR delay);
    ///Gets or sets a value that indicates the amount of time that the Task Scheduler will wait for an idle condition to
    ///occur. If no value is specified for this property, then the Task Scheduler service will wait indefinitely for an
    ///idle condition to occur. This property is read/write.
    HRESULT get_WaitTimeout(BSTR* pTimeout);
    ///Gets or sets a value that indicates the amount of time that the Task Scheduler will wait for an idle condition to
    ///occur. If no value is specified for this property, then the Task Scheduler service will wait indefinitely for an
    ///idle condition to occur. This property is read/write.
    HRESULT put_WaitTimeout(BSTR timeout);
    ///Gets or sets a Boolean value that indicates that the Task Scheduler will terminate the task if the idle condition
    ///ends before the task is completed. The idle condition ends when the computer is no longer idle. This property is
    ///read/write.
    HRESULT get_StopOnIdleEnd(short* pStop);
    ///Gets or sets a Boolean value that indicates that the Task Scheduler will terminate the task if the idle condition
    ///ends before the task is completed. The idle condition ends when the computer is no longer idle. This property is
    ///read/write.
    HRESULT put_StopOnIdleEnd(short stop);
    ///Gets or sets a Boolean value that indicates whether the task is restarted when the computer cycles into an idle
    ///condition more than once. This property is read/write.
    HRESULT get_RestartOnIdle(short* pRestart);
    ///Gets or sets a Boolean value that indicates whether the task is restarted when the computer cycles into an idle
    ///condition more than once. This property is read/write.
    HRESULT put_RestartOnIdle(short restart);
}

///Provides the settings that the Task Scheduler service uses to obtain a network profile.
@GUID("9F7DEA84-C30B-4245-80B6-00E9F646F1B4")
interface INetworkSettings : IDispatch
{
    ///Gets or sets the name of a network profile. The name is used for display purposes. This property is read/write.
    HRESULT get_Name(BSTR* pName);
    ///Gets or sets the name of a network profile. The name is used for display purposes. This property is read/write.
    HRESULT put_Name(BSTR name);
    ///Gets or sets a GUID value that identifies a network profile. This property is read/write.
    HRESULT get_Id(BSTR* pId);
    ///Gets or sets a GUID value that identifies a network profile. This property is read/write.
    HRESULT put_Id(BSTR id);
}

///Defines how often the task is run and how long the repetition pattern is repeated after the task is started.
@GUID("7FB9ACF1-26BE-400E-85B5-294B9C75DFD6")
interface IRepetitionPattern : IDispatch
{
    ///Gets or sets the amount of time between each restart of the task. This property is read/write.
    HRESULT get_Interval(BSTR* pInterval);
    ///Gets or sets the amount of time between each restart of the task. This property is read/write.
    HRESULT put_Interval(BSTR interval);
    ///Gets or sets how long the pattern is repeated. This property is read/write.
    HRESULT get_Duration(BSTR* pDuration);
    ///Gets or sets how long the pattern is repeated. This property is read/write.
    HRESULT put_Duration(BSTR duration);
    ///Gets or sets a Boolean value that indicates if a running instance of the task is stopped at the end of the
    ///repetition pattern duration. This property is read/write.
    HRESULT get_StopAtDurationEnd(short* pStop);
    ///Gets or sets a Boolean value that indicates if a running instance of the task is stopped at the end of the
    ///repetition pattern duration. This property is read/write.
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
