// Written in the D programming language.

module windows.performancelogandalerts;

public import windows.core;
public import windows.automation : BSTR, IDispatch, SAFEARRAY, VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : PWSTR;

extern(Windows) @nogc nothrow:


// Enums


///Defines the data collector types.
enum DataCollectorType : int
{
    ///Collects performance counter data. The IPerformanceCounterDataCollector interface represents this data collector.
    plaPerformanceCounter = 0x00000000,
    ///Collects events from an event trace session. The ITraceDataCollector interface represents this data collector.
    plaTrace              = 0x00000001,
    ///Collects computer configuration information. The IConfigurationDataCollector interface represents this data
    ///collector.
    plaConfiguration      = 0x00000002,
    ///Monitors performance counters and performs actions if the counter value crosses the specified threshold. The
    ///IAlertDataCollector interface represents this data collector.
    plaAlert              = 0x00000003,
    ///Logs API calls made by the process. The IApiTracingDataCollector interface represents this data collector.
    plaApiTrace           = 0x00000004,
}

///Defines the format of the data in the log file.
enum FileFormat : int
{
    ///Comma-separated log file. The first line in the text file contains column headings followed by comma-separated
    ///data in the remaining lines of the log file.
    plaCommaSeparated = 0x00000000,
    ///Tab-separated log file. The first line in the text file contains column headings followed by tab-separated data
    ///in the remaining lines of the log file.
    plaTabSeparated   = 0x00000001,
    ///The log contains SQL records.
    plaSql            = 0x00000002,
    ///Binary log file.
    plaBinary         = 0x00000003,
}

///Defines how to decorate the file name or subdirectory name.
enum AutoPathFormat : int
{
    ///Do not decorate the name.
    plaNone               = 0x00000000,
    ///Add a pattern to the name. The pattern is specified in the IDataCollector::FileNameFormatPattern or
    ///IDataCollectorSet::SubdirectoryFormatPattern property.
    plaPattern            = 0x00000001,
    ///Prefix the name with the computer name.
    plaComputer           = 0x00000002,
    ///Append the month, day, and hour to the name, in the form MMddHH.
    plaMonthDayHour       = 0x00000100,
    ///Append the serial number specified in the IDataCollectorSet::SerialNumber property to the subdirectory name in
    ///the form NNNNNN.
    plaSerialNumber       = 0x00000200,
    ///Append the year and day of the year to the name, in the form yyyyDDD.
    plaYearDayOfYear      = 0x00000400,
    ///Append the year and month to the name, in the form yyyyMM.
    plaYearMonth          = 0x00000800,
    ///Append the year, month, and day to the name, in the form yyyyMMdd.
    plaYearMonthDay       = 0x00001000,
    ///Append the year, month, day, and hour to the name, in the form yyyyMMddHH.
    plaYearMonthDayHour   = 0x00002000,
    ///Append the month, day, hour, and minute to the name, in the form MMddHHmm.
    plaMonthDayHourMinute = 0x00004000,
}

///Defines the running status of the data collector set.
enum DataCollectorSetStatus : int
{
    ///The data collector set is not running.
    plaStopped   = 0x00000000,
    ///The data collector set is running.
    plaRunning   = 0x00000001,
    ///The data collector set is performing data management. A running data collector set will transition from
    ///<b>plaRunning</b> to <b>plaCompiling</b> if the data manager is enabled.
    plaCompiling = 0x00000002,
    ///The data collector has been set to run, but the service has not started it yet. Only computers that run operating
    ///systems prior to Windows Vista report this status.
    plaPending   = 0x00000003,
    ///Cannot determine the status but no error has occurred. Typically, this status is set for autologgers.
    plaUndefined = 0x00000004,
}

///Defines the clock resolution to use when tracing events.
enum ClockType : int
{
    ///Use the raw (unconverted) time stamp.
    plaTimeStamp   = 0x00000000,
    ///Query performance counter. This counter provides a high-resolution (100 nanoseconds) time stamp but is more
    ///resource-intensive to retrieve than system time.
    plaPerformance = 0x00000001,
    ///System time. The system time provides a low-resolution (10 milliseconds) time stamp but is less
    ///resource-intensive to retrieve than the query performance counter.
    plaSystem      = 0x00000002,
    ///CPU cycle counter. The CPU counter provides the highest resolution time stamp and is the least resource-intensive
    ///to retrieve. However, the CPU counter is unreliable and should not be used in production.
    plaCycle       = 0x00000003,
}

///Defines where the trace events are delivered.
enum StreamMode : int
{
    ///Write the trace events to a log file.
    plaFile      = 0x00000001,
    ///Deliver the trace events to a real time consumer.
    plaRealTime  = 0x00000002,
    ///Write the trace events to a log file and deliver them to a real-time consumer.
    plaBoth      = 0x00000003,
    ///For details, see the EVENT_TRACE_BUFFERING_MODE logging mode in Event Tracing for Windows.
    plaBuffering = 0x00000004,
}

///Defines the action to take when committing changes to the data collector set.
enum CommitMode : int
{
    ///Save the set. The set must not already exist. The set is not saved if it is a trace session.
    plaCreateNew             = 0x00000001,
    ///Update a previously saved set.
    plaModify                = 0x00000002,
    ///Save the set. If the set already exists, update the set. The set is not saved if it is a trace session.
    plaCreateOrModify        = 0x00000003,
    ///Apply the updated property values to the currently running data set.
    plaUpdateRunningInstance = 0x00000010,
    ///Flush the buffers for an Event Tracing for Windows trace session. This action applies only to sets that contain
    ///trace data collectors.
    plaFlushTrace            = 0x00000020,
    ///Perform validation only on the set.
    plaValidateOnly          = 0x00001000,
}

///Defines the type of the value.
enum ValueMapType : int
{
    ///Only one item in the collection can be enabled. The enabled item is the value of the IValueMap::Value property.
    ///If more than one item is enabled, the first enabled item is used as the value.
    plaIndex      = 0x00000001,
    ///One or more items in the collection can be enabled. An item in the collection represents a single bit flag. The
    ///enabled items in the collection are combined with the <b>OR</b> operator to become the value of IValueMap::Value.
    plaFlag       = 0x00000002,
    ///The collection contains a list of Event Tracing for Windows extended flags (see the
    ///ITraceDataProvider::Properties property).
    plaFlagArray  = 0x00000003,
    ///The collection contains a list of HRESULT values returned by the validation process.
    plaValidation = 0x00000004,
}

///Defines the days of the week on which to run the data collector set.
enum WeekDays : int
{
    ///Run only once on the specified start date and time.
    plaRunOnce   = 0x00000000,
    ///Run on Sunday.
    plaSunday    = 0x00000001,
    ///Run on Monday.
    plaMonday    = 0x00000002,
    ///Run on Tuesday.
    plaTuesday   = 0x00000004,
    ///Run on Wednesday
    plaWednesday = 0x00000008,
    ///Run on Thursday.
    plaThursday  = 0x00000010,
    ///Run on Friday.
    plaFriday    = 0x00000020,
    ///Run on Saturday.
    plaSaturday  = 0x00000040,
    ///Run every day of the week.
    plaEveryday  = 0x0000007f,
}

///Defines how folders are deleted when one of the disk resource limits is exceeded.
enum ResourcePolicy : int
{
    ///Delete folders from largest to smallest.
    plaDeleteLargest = 0x00000000,
    ///Delete folders from oldest to newest.
    plaDeleteOldest  = 0x00000001,
}

///Defines the actions that the data manager takes when it runs.
enum DataManagerSteps : int
{
    ///Runs TraceRpt.exe using as input all the binary performance files (.blg) or event trace files (.etl) in the
    ///collection. You can use the IDataManager::ReportSchema property to customize the report. The
    ///IDataManager::RuleTargetFileName property contains the name of the file that TraceRpt creates.
    plaCreateReport    = 0x00000001,
    ///If a report exists, apply the rules specified in the IDataManager::Rules property to the report. The
    ///RuleTargetFileName property contains the name of the file to which the rules are applied.
    plaRunRules        = 0x00000002,
    ///Converts the XML file specified in RuleTargetFileName to HTML format. The HTML format is written to the file
    ///specified in the IDataManager::ReportFileName property.
    plaCreateHtml      = 0x00000004,
    ///Apply the folder actions specified in the IDataManager::FolderActions property to all folders defined in the
    ///collection.
    plaFolderActions   = 0x00000008,
    ///If the IDataManager::MaxFolderCount, IDataManager::MaxSize, or IDataManager::MinFreeDisk property exceeds its
    ///limit, apply the resource policy specified in the IDataManager::ResourcePolicy property.
    plaResourceFreeing = 0x00000010,
}

///Defines the action that the data manager takes when both the age and size limits are met.
enum FolderActionSteps : int
{
    ///Creates a cabinet file. The name of the cabinet file is <i>nameofthesubfolder</i>.cab.
    plaCreateCab    = 0x00000001,
    ///Deletes all files in the folder, except the report and cabinet file.
    plaDeleteData   = 0x00000002,
    ///Sends the cabinet file to the location specified in the IFolderAction::SendCabTo property.
    plaSendCab      = 0x00000004,
    ///Deletes the cabinet file.
    plaDeleteCab    = 0x00000008,
    ///Deletes the report file.
    plaDeleteReport = 0x00000010,
}

// Callbacks

alias PLA_CABEXTRACT_CALLBACK = void function(const(PWSTR) FileName, void* Context);

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

///Manages the configuration information that is common to all data collector objects in the set; adds and removes data
///collectors from the set; and starts data collection. This is the primary PLA interface that you use. To get this
///interface, call the CoCreateInstance function, passing <code>__uuidof(DataCollectorSet)</code> as the class
///identifier and <code>__uuidof(IDataCollectorSet)</code> as the interface identifier.
@GUID("03837520-098B-11D8-9414-505054503030")
interface IDataCollectorSet : IDispatch
{
    ///Retrieves the list of data collectors in this set. This property is read-only.
    HRESULT get_DataCollectors(IDataCollectorCollection* collectors);
    ///Retrieves and sets the duration that the data collector set runs. This property is read/write.
    HRESULT get_Duration(uint* seconds);
    ///Retrieves and sets the duration that the data collector set runs. This property is read/write.
    HRESULT put_Duration(uint seconds);
    ///Retrieves or sets the description of the data collector set. The description will be added to all output files as
    ///metadata and inserted into Performance Data Helper logs as a comment. This property is read/write.
    HRESULT get_Description(BSTR* description);
    ///Retrieves or sets the description of the data collector set. The description will be added to all output files as
    ///metadata and inserted into Performance Data Helper logs as a comment. This property is read/write.
    HRESULT put_Description(BSTR description);
    ///Retrieves the description of the data collector set in its original form. This property is read-only.
    HRESULT get_DescriptionUnresolved(BSTR* Descr);
    ///Retrieves or sets the display name of the data collector set. This property is read/write.
    HRESULT get_DisplayName(BSTR* DisplayName);
    ///Retrieves or sets the display name of the data collector set. This property is read/write.
    HRESULT put_DisplayName(BSTR DisplayName);
    ///Retrieves the display name of the data collector set in its original form. This property is read-only.
    HRESULT get_DisplayNameUnresolved(BSTR* name);
    ///Retrieves or sets keywords that describe the data collector set. The list of keywords is added to the output
    ///files as metadata. This property is read/write.
    HRESULT get_Keywords(SAFEARRAY** keywords);
    ///Retrieves or sets keywords that describe the data collector set. The list of keywords is added to the output
    ///files as metadata. This property is read/write.
    HRESULT put_Keywords(SAFEARRAY* keywords);
    ///Retrieves or sets the fully decorated folder name that PLA used the last time logs were written. This property is
    ///read/write.
    HRESULT get_LatestOutputLocation(BSTR* path);
    ///Retrieves or sets the fully decorated folder name that PLA used the last time logs were written. This property is
    ///read/write.
    HRESULT put_LatestOutputLocation(BSTR path);
    ///Retrieves the unique name used to identify the data collector set. This property is read-only.
    HRESULT get_Name(BSTR* name);
    ///Retrieves the decorated folder name if PLA were to create it now. This property is read-only.
    HRESULT get_OutputLocation(BSTR* path);
    ///Retrieves or sets the base path where the subdirectories are created. <div class="alert"><b>Warning</b> If you
    ///change the <b>RootPath</b> property, you should change it to a directory that only contains performance logs.
    ///Setting this to another directory, such as the drive root or system root, may cause files to be inadvertently
    ///deleted when the logs are cleaned up by the system.</div><div> </div>This property is read/write.
    HRESULT get_RootPath(BSTR* folder);
    ///Retrieves or sets the base path where the subdirectories are created. <div class="alert"><b>Warning</b> If you
    ///change the <b>RootPath</b> property, you should change it to a directory that only contains performance logs.
    ///Setting this to another directory, such as the drive root or system root, may cause files to be inadvertently
    ///deleted when the logs are cleaned up by the system.</div><div> </div>This property is read/write.
    HRESULT put_RootPath(BSTR folder);
    ///Retrieves or sets a value that indicates whether PLA creates new logs if the maximum size or segment duration is
    ///reached before the data collector set is stopped. This property is read/write.
    HRESULT get_Segment(short* segment);
    ///Retrieves or sets a value that indicates whether PLA creates new logs if the maximum size or segment duration is
    ///reached before the data collector set is stopped. This property is read/write.
    HRESULT put_Segment(short segment);
    ///Retrieves or sets the duration that the data collector set can run before it begins writing to new log files.
    ///This property is read/write.
    HRESULT get_SegmentMaxDuration(uint* seconds);
    ///Retrieves or sets the duration that the data collector set can run before it begins writing to new log files.
    ///This property is read/write.
    HRESULT put_SegmentMaxDuration(uint seconds);
    ///Retrieves or sets the maximum size of any log file in the data collector set. This property is read/write.
    HRESULT get_SegmentMaxSize(uint* size);
    ///Retrieves or sets the maximum size of any log file in the data collector set. This property is read/write.
    HRESULT put_SegmentMaxSize(uint size);
    ///Retrieves or sets the number of times that this data collector set has been started, including segments. This
    ///property is read/write.
    HRESULT get_SerialNumber(uint* index);
    ///Retrieves or sets the number of times that this data collector set has been started, including segments. This
    ///property is read/write.
    HRESULT put_SerialNumber(uint index);
    ///Retrieves the name of the server where the data collector set is run. This property is read-only.
    HRESULT get_Server(BSTR* server);
    ///Retrieves the status of the data collector set. This property is read-only.
    HRESULT get_Status(DataCollectorSetStatus* status);
    ///Retrieves or sets a base subdirectory of the root path where the next instance of the data collector set will
    ///write its logs. This property is read/write.
    HRESULT get_Subdirectory(BSTR* folder);
    ///Retrieves or sets a base subdirectory of the root path where the next instance of the data collector set will
    ///write its logs. This property is read/write.
    HRESULT put_Subdirectory(BSTR folder);
    ///Retrieves or sets flags that describe how to decorate the subdirectory name. This property is read/write.
    HRESULT get_SubdirectoryFormat(AutoPathFormat* format);
    ///Retrieves or sets flags that describe how to decorate the subdirectory name. This property is read/write.
    HRESULT put_SubdirectoryFormat(AutoPathFormat format);
    ///Retrieves or sets a format pattern to use when decorating the folder name. This property is read/write.
    HRESULT get_SubdirectoryFormatPattern(BSTR* pattern);
    ///Retrieves or sets a format pattern to use when decorating the folder name. This property is read/write.
    HRESULT put_SubdirectoryFormatPattern(BSTR pattern);
    ///Retrieves or sets the name of a Task Scheduler job to start each time the data collector set stops, including
    ///between segments. This property is read/write.
    HRESULT get_Task(BSTR* task);
    ///Retrieves or sets the name of a Task Scheduler job to start each time the data collector set stops, including
    ///between segments. This property is read/write.
    HRESULT put_Task(BSTR task);
    ///Retrieves or sets a value that determines whether the task runs as the data collector set user or as the user
    ///specified in the task. This property is read/write.
    HRESULT get_TaskRunAsSelf(short* RunAsSelf);
    ///Retrieves or sets a value that determines whether the task runs as the data collector set user or as the user
    ///specified in the task. This property is read/write.
    HRESULT put_TaskRunAsSelf(short RunAsSelf);
    ///Retrieves or sets the command-line arguments to pass to the Task Scheduler job specified in the
    ///IDataCollectorSet::Task property. This property is read/write.
    HRESULT get_TaskArguments(BSTR* task);
    ///Retrieves or sets the command-line arguments to pass to the Task Scheduler job specified in the
    ///IDataCollectorSet::Task property. This property is read/write.
    HRESULT put_TaskArguments(BSTR task);
    ///Retrieves or sets the command-line arguments that are substituted for the {usertext} substitution variable in the
    ///IDataCollectorSet::TaskArguments property. This property is read/write.
    HRESULT get_TaskUserTextArguments(BSTR* UserText);
    ///Retrieves or sets the command-line arguments that are substituted for the {usertext} substitution variable in the
    ///IDataCollectorSet::TaskArguments property. This property is read/write.
    HRESULT put_TaskUserTextArguments(BSTR UserText);
    ///Retrieves the list of schedules that determine when the data collector set runs. This property is read-only.
    HRESULT get_Schedules(IScheduleCollection* ppSchedules);
    ///Retrieves or sets a value that indicates whether the schedules are enabled. This property is read/write.
    HRESULT get_SchedulesEnabled(short* enabled);
    ///Retrieves or sets a value that indicates whether the schedules are enabled. This property is read/write.
    HRESULT put_SchedulesEnabled(short enabled);
    ///Retrieves the user account under which the data collector set will run. This property is read-only.
    HRESULT get_UserAccount(BSTR* user);
    ///Retrieves an XML string that describes the values of the data collector set properties, including those of the
    ///data collectors contained in the set. This property is read-only.
    HRESULT get_Xml(BSTR* xml);
    ///Retrieves or sets access control information that determines who can access this data collector set. This
    ///property is read/write.
    HRESULT get_Security(BSTR* pbstrSecurity);
    ///Retrieves or sets access control information that determines who can access this data collector set. This
    ///property is read/write.
    HRESULT put_Security(BSTR bstrSecurity);
    ///Retrieves or sets a value that determines whether the data collector set stops when all the data collectors in
    ///the set are in a completed state. This property is read/write.
    HRESULT get_StopOnCompletion(short* Stop);
    ///Retrieves or sets a value that determines whether the data collector set stops when all the data collectors in
    ///the set are in a completed state. This property is read/write.
    HRESULT put_StopOnCompletion(short Stop);
    ///Retrieves the data manager associated with this data collector set. This property is read-only.
    HRESULT get_DataManager(IDataManager* DataManager);
    ///Specifies the user account under which the data collector set runs.
    ///Params:
    ///    user = A user account under which the data collector set runs. Specify the user name in the form <i>domain</i>&
    ///    password = The password of the user account.
    ///Returns:
    ///    The property returns S_OK if successful.
    ///    
    HRESULT SetCredentials(BSTR user, BSTR password);
    ///Retrieves the specified data collector set.
    ///Params:
    ///    name = The name of the data collector set to retrieve. The name is case-insensitive and is of the form
    ///           <b>[</b><i>Namespace</i><b>\]</b><i>Name</i>. For details on the optional namespace, see Remarks.
    ///    server = The computer on which the set exists. You can specify a computer name, a fully qualified domain name, or an
    ///             IP address (IPv4 or IPv6 format). If <b>NULL</b>, the set is retrieved from the local computer.
    ///Returns:
    ///    Returns S_OK if successful. The following table shows possible error values. <table> <tr> <th>Return
    ///    code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PLA_E_DCS_NOT_FOUND</b></dt>
    ///    <dt>0x80300002</dt> </dl> </td> <td width="60%"> The specified data collector set was not found. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> <dt>0x80300002</dt> </dl> </td> <td width="60%"> You
    ///    must retrieve a data collector set into an empty instance or into an instance that uses the same namespace.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(RPC_S_SERVER_UNAVAILABLE)</b></dt> </dl>
    ///    </td> <td width="60%"> The RPC server is not available. The method is unable to query the data collector set
    ///    remotely. To query the data collector set from a remote computer running Windows Vista, enable Performance
    ///    Logs and Alerts in <b>Windows Firewall Settings</b> on the remote computer. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_BAD_NETPATH)</b></dt> </dl> </td> <td width="60%"> Unable to find the
    ///    remote computer. </td> </tr> </table>
    ///    
    HRESULT Query(BSTR name, BSTR server);
    ///Saves, updates, or validates the data collector set. You can also use this method to flush a trace session.
    ///Params:
    ///    name = A unique name used to save the data collector set. The name is of the form
    ///           <b>[</b><i>Namespace</i><b>\]</b><i>Name</i>. For details, see Remarks.
    ///    server = The computer on which you want to save the set. You can specify a computer name, a fully qualified domain
    ///             name, or an IP address (IPv4 or IPv6 format). If <b>NULL</b>, the set is saved to the local computer.
    ///    mode = Indicates whether you want to save, update, flush, or validate the data collector set. For possible values,
    ///           see the CommitMode enumeration.
    ///    validation = An IValueMap interface that you use to retrieve the validation error of each property whose value is not
    ///                 valid or is ignored. The IValueMap::Count property is zero if there were no errors or warnings.
    ///Returns:
    ///    Returns S_OK if the method call was successful. You must check the value map for errors (see Remarks). If the
    ///    method returns S_OK and there are no validation errors, then the set was successfully committed. The
    ///    following table shows possible error values when calling this method. <table> <tr> <th>Return code/value</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> The user must be running as an administrator. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> The specified namespace is not supported (for
    ///    example, if you specified the System namespace when committing the data collector set on a computer running
    ///    an operating system prior to Windows Vista). </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(RPC_S_SERVER_UNAVAILABLE)</b></dt> </dl> </td> <td width="60%"> The RPC server is
    ///    not available. The method is unable to save the data collector set remotely. To commit remotely to a computer
    ///    running Windows Vista, enable Performance Logs and Alerts in <b>Windows Firewall Settings</b> on the remote
    ///    computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>PLA_E_DCS_ALREADY_EXISTS</b></dt> <dt>0x803000B7</dt>
    ///    </dl> </td> <td width="60%"> You are trying to commit a new set, but a set with the specified name already
    ///    exists. </td> </tr> </table>
    ///    
    HRESULT Commit(BSTR name, BSTR server, CommitMode mode, IValueMap* validation);
    ///Deletes the persisted copy of the data collector set if the set is not running.
    ///Returns:
    ///    Returns S_OK if successful. The following table shows a possible error value. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(RPC_S_SERVER_UNAVAILABLE)</b></dt> </dl> </td> <td width="60%"> The RPC server is
    ///    not available. The method is unable to delete the data collector set remotely. To delete the data collector
    ///    set on a remote computer running Windows Vista, enable Performance Logs and Alerts in <b>Windows Firewall
    ///    Settings</b> on the remote computer. </td> </tr> </table>
    ///    
    HRESULT Delete();
    ///Manually starts the data collector set.
    ///Params:
    ///    Synchronous = Data collection runs in a separate process. This value determines when the method returns. Set to
    ///                  VARIANT_TRUE to have the method return after the data collection process starts or fails to start. The return
    ///                  value indicates whether the set successfully started or failed to start. Set to VARIANT_FALSE to return after
    ///                  the set is queued to run. The return value indicates whether the set was successfully queued. For more
    ///                  information, see Remarks.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. The following table shows possible error values. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The set must be persisted (see the Commit method) prior to starting collection. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_PATH_NOT_FOUND)</b></dt> </dl> </td> <td width="60%">
    ///    The system cannot find the path specified. This error occurs when the RootPath property specifies a directory
    ///    that does not exist. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_ALREADY_EXISTS)</b></dt> </dl> </td> <td width="60%"> The subdirectory or log
    ///    file already exists. Try using a format to uniquely identify the file. </td> </tr> </table>
    ///    
    HRESULT Start(short Synchronous);
    ///Manually stops the data collector set.
    ///Params:
    ///    Synchronous = Data collection runs in a separate process. This value determines when the method returns. Set to
    ///                  VARIANT_TRUE to have the method return after the data collector set is stopped or fails to stop. The return
    ///                  value indicates whether the set successfully stopped or failed to stop. Set to VARIANT_FALSE to return after
    ///                  the method sends a request to the set to stop. The return value indicates whether the request was
    ///                  successfully sent to the set. An event is written to the event log if the set fails to stop.
    ///Returns:
    ///    Returns S_OK if successful. The following table shows a possible error value. <table> <tr> <th>Return
    ///    code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>PLA_E_DCS_NOT_RUNNING</b></dt>
    ///    <dt>0x80300104</dt> </dl> </td> <td width="60%"> The data collector set is not running. </td> </tr> </table>
    ///    
    HRESULT Stop(short Synchronous);
    ///Sets the property values of those properties included in the XML.
    ///Params:
    ///    xml = XML that contains the properties to set. For details on specifying the XML string, see the Remarks section of
    ///          IDataCollectorSet.
    ///    validation = An IValueMap interface that you use to retrieve the validation error of each property whose value is not
    ///                 valid. The IValueMap::Count property is zero if there were no errors.
    ///Returns:
    ///    Returns S_OK if the method call was successful. You must check the value map for errors. If the method
    ///    returns S_OK and there are no validation errors, then the set was successfully initialized.
    ///    
    HRESULT SetXml(BSTR xml, IValueMap* validation);
    ///Sets a user-defined value.
    ///Params:
    ///    key = The name of the value.
    ///    value = The value associated with the key.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT SetValue(BSTR key, BSTR value);
    ///Retrieves a user-defined value.
    ///Params:
    ///    key = The key of the value to retrieve.
    ///    value = A value associated with the key.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT GetValue(BSTR key, BSTR* value);
}

///Manages data generated by the data collectors, including report generation, data retention policy, and data transfer.
///To get this interface, access the IDataCollectorSet::DataManager property.
@GUID("03837541-098B-11D8-9414-505054503030")
interface IDataManager : IDispatch
{
    ///Retrieves or sets a value that indicates whether the data manager is enabled to run. This property is read/write.
    HRESULT get_Enabled(short* pfEnabled);
    ///Retrieves or sets a value that indicates whether the data manager is enabled to run. This property is read/write.
    HRESULT put_Enabled(short fEnabled);
    ///Retrieves or sets a value that indicates whether the data manager should check imposed limits, such as the
    ///minimum available free disk space, before collecting data. This property is read/write.
    HRESULT get_CheckBeforeRunning(short* pfCheck);
    ///Retrieves or sets a value that indicates whether the data manager should check imposed limits, such as the
    ///minimum available free disk space, before collecting data. This property is read/write.
    HRESULT put_CheckBeforeRunning(short fCheck);
    ///Retrieves or sets the minimum free disk space that needs to exist before data collection begins. This property is
    ///read/write.
    HRESULT get_MinFreeDisk(uint* MinFreeDisk);
    ///Retrieves or sets the minimum free disk space that needs to exist before data collection begins. This property is
    ///read/write.
    HRESULT put_MinFreeDisk(uint MinFreeDisk);
    ///Retrieves or sets the maximum disk space to be used by all data collectors in the set. This property is
    ///read/write.
    HRESULT get_MaxSize(uint* pulMaxSize);
    ///Retrieves or sets the maximum disk space to be used by all data collectors in the set. This property is
    ///read/write.
    HRESULT put_MaxSize(uint ulMaxSize);
    ///Retrieves or sets the maximum number of folders to be used by all data collectors in the set. This property is
    ///read/write.
    HRESULT get_MaxFolderCount(uint* pulMaxFolderCount);
    ///Retrieves or sets the maximum number of folders to be used by all data collectors in the set. This property is
    ///read/write.
    HRESULT put_MaxFolderCount(uint ulMaxFolderCount);
    ///Retrieves or sets the action to take when one of the disk resource limits is exceeded. This property is
    ///read/write.
    HRESULT get_ResourcePolicy(ResourcePolicy* pPolicy);
    ///Retrieves or sets the action to take when one of the disk resource limits is exceeded. This property is
    ///read/write.
    HRESULT put_ResourcePolicy(ResourcePolicy Policy);
    ///Retrieves a collection that you use to manage the actions to take on each folder in the data collector set when
    ///the age and size conditions are met. This property is read-only.
    HRESULT get_FolderActions(IFolderActionCollection* Actions);
    ///Retrieves or sets the schema used to customize the report that the TraceRpt.exe application generates. This
    ///property is read/write.
    HRESULT get_ReportSchema(BSTR* ReportSchema);
    ///Retrieves or sets the schema used to customize the report that the TraceRpt.exe application generates. This
    ///property is read/write.
    HRESULT put_ReportSchema(BSTR ReportSchema);
    ///Retrieves or sets the name of the HTML file that results from converting the file in the
    ///IDataManager::RuleTargetFileName property from XML to HTML. This property is read/write.
    HRESULT get_ReportFileName(BSTR* pbstrFilename);
    ///Retrieves or sets the name of the HTML file that results from converting the file in the
    ///IDataManager::RuleTargetFileName property from XML to HTML. This property is read/write.
    HRESULT put_ReportFileName(BSTR pbstrFilename);
    ///Retrieves or sets the name of the report file that the TraceRpt.exe application creates. This property is
    ///read/write.
    HRESULT get_RuleTargetFileName(BSTR* Filename);
    ///Retrieves or sets the name of the report file that the TraceRpt.exe application creates. This property is
    ///read/write.
    HRESULT put_RuleTargetFileName(BSTR Filename);
    ///Retrieves or sets the name for the events file. This property is read/write.
    HRESULT get_EventsFileName(BSTR* pbstrFilename);
    ///Retrieves or sets the name for the events file. This property is read/write.
    HRESULT put_EventsFileName(BSTR pbstrFilename);
    ///Retrieves or sets the rules to apply to the report. This property is read/write.
    HRESULT get_Rules(BSTR* pbstrXml);
    ///Retrieves or sets the rules to apply to the report. This property is read/write.
    HRESULT put_Rules(BSTR bstrXml);
    ///Manually runs the data manager.
    ///Params:
    ///    Steps = Determines whether the folder actions and resource policies are applied and how to generate the report. For
    ///            possible steps, see the DataManagerSteps enumeration.
    ///    bstrFolder = The folder under the IDataCollectorSet::RootPath property that contains the files used to generate the
    ///                 report. If <b>NULL</b>, PLA uses all the files in the collection. This folder is used only if the
    ///                 <i>Steps</i> parameter includes <b>plaCreateReport</b> or <b>plaRunRules</b>.
    ///    Errors = An IValueMap interface that you use to retrieve any errors that occurred. The value map can contain the list
    ///             of directories where errors were encountered, along with the error codes. The IValueMap::Count property is
    ///             zero if there were no errors.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT Run(DataManagerSteps Steps, BSTR bstrFolder, IValueMap* Errors);
    ///Extracts the specified CAB file.
    ///Params:
    ///    CabFilename = The name of the CAB file to extract.
    ///    DestinationPath = The path where you want to place the CAB file.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT Extract(BSTR CabFilename, BSTR DestinationPath);
}

///Specifies the actions that the data manager is to take on each folder under the data collector set's root path if
///both conditions (age and size) are met. To get this interface, call the IFolderActionCollection::CreateFolderAction
///method.
@GUID("03837543-098B-11D8-9414-505054503030")
interface IFolderAction : IDispatch
{
    ///Retrieves or sets the interval to wait between applying the actions. This property is read/write.
    HRESULT get_Age(uint* pulAge);
    ///Retrieves or sets the interval to wait between applying the actions. This property is read/write.
    HRESULT put_Age(uint ulAge);
    ///Retrieves or sets the minimum folder size that, when exceeded, initiates the actions. This property is
    ///read/write.
    HRESULT get_Size(uint* pulAge);
    ///Retrieves or sets the minimum folder size that, when exceeded, initiates the actions. This property is
    ///read/write.
    HRESULT put_Size(uint ulAge);
    ///Retrieves or sets the actions that the data manager is to take if both conditions (age and size) are met. This
    ///property is read/write.
    HRESULT get_Actions(FolderActionSteps* Steps);
    ///Retrieves or sets the actions that the data manager is to take if both conditions (age and size) are met. This
    ///property is read/write.
    HRESULT put_Actions(FolderActionSteps Steps);
    ///Retrieves or sets the destination of the cabinet file if the action is to send a cabinet file. This property is
    ///read/write.
    HRESULT get_SendCabTo(BSTR* pbstrDestination);
    ///Retrieves or sets the destination of the cabinet file if the action is to send a cabinet file. This property is
    ///read/write.
    HRESULT put_SendCabTo(BSTR bstrDestination);
}

///Manages a collection of FolderAction objects. To get this interface, access the IDataManager::FolderActions property.
@GUID("03837544-098B-11D8-9414-505054503030")
interface IFolderActionCollection : IDispatch
{
    ///Retrieves the number of folder actions in the collection. This property is read-only.
    HRESULT get_Count(uint* Count);
    ///Retrieves the requested folder action from the collection. This property is read-only.
    HRESULT get_Item(VARIANT Index, IFolderAction* Action);
    ///Retrieves an interface to the enumeration. This property is read-only.
    HRESULT get__NewEnum(IUnknown* Enum);
    ///Adds a folder action to the collection.
    ///Params:
    ///    Action = An IFolderAction interface of the action to add to the collection.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT Add(IFolderAction Action);
    ///Removes a folder action from the collection based on the specified index.
    ///Params:
    ///    Index = The zero-based index of the folder action to remove from the collection. The variant type can be VT_I4,
    ///            VT_UI4, or VT_DISPATCH.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT Remove(VARIANT Index);
    ///Removes all folder actions from the collection.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT Clear();
    ///Adds one or more folder actions to the collection.
    ///Params:
    ///    Actions = An IFolderActionCollection interface to a collection of one or more folder actions to add to this collection.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT AddRange(IFolderActionCollection Actions);
    ///Creates a folder action object.
    ///Params:
    ///    FolderAction = An IFolderAction interface that you use to describe the action to be taken by the data manager.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT CreateFolderAction(IFolderAction* FolderAction);
}

///Sets and retrieves collector properties using XML, specifies the log file name, and retrieves the location of the log
///file. This interface is an abstract class from which the following data collectors derive:<ul> <li>
///IAlertDataCollector </li> <li> IApiTracingDataCollector </li> <li> IConfigurationDataCollector </li> <li>
///IPerformanceCounterDataCollector </li> <li> ITraceDataCollector </li> </ul>
@GUID("038374FF-098B-11D8-9414-505054503030")
interface IDataCollector : IDispatch
{
    ///Retrieves the data collector set to which this data collector belongs. This property is read-only.
    HRESULT get_DataCollectorSet(IDataCollectorSet* group);
    HRESULT put_DataCollectorSet(IDataCollectorSet group);
    ///Retrieves the type of this data collector, for example, a performance data collector. This property is read-only.
    HRESULT get_DataCollectorType(DataCollectorType* type);
    ///Retrieves or sets the base name of the file that will contain the data collector data. This property is
    ///read/write.
    HRESULT get_FileName(BSTR* name);
    ///Retrieves or sets the base name of the file that will contain the data collector data. This property is
    ///read/write.
    HRESULT put_FileName(BSTR name);
    ///Retrieves or sets flags that describe how to decorate the file name. This property is read/write.
    HRESULT get_FileNameFormat(AutoPathFormat* format);
    ///Retrieves or sets flags that describe how to decorate the file name. This property is read/write.
    HRESULT put_FileNameFormat(AutoPathFormat format);
    ///Retrieves or sets the format pattern to use when decorating the file name. This property is read/write.
    HRESULT get_FileNameFormatPattern(BSTR* pattern);
    ///Retrieves or sets the format pattern to use when decorating the file name. This property is read/write.
    HRESULT put_FileNameFormatPattern(BSTR pattern);
    ///Retrieves or sets the fully decorated file name that PLA used the last time it created the file. This property is
    ///read/write.
    HRESULT get_LatestOutputLocation(BSTR* path);
    ///Retrieves or sets the fully decorated file name that PLA used the last time it created the file. This property is
    ///read/write.
    HRESULT put_LatestOutputLocation(BSTR path);
    ///Retrieves or sets a value that indicates if PLA should append the collected data to the current file. This
    ///property is read/write.
    HRESULT get_LogAppend(short* append);
    ///Retrieves or sets a value that indicates if PLA should append the collected data to the current file. This
    ///property is read/write.
    HRESULT put_LogAppend(short append);
    ///Retrieves or sets a value that indicates if PLA should create a circular file. This property is read/write.
    HRESULT get_LogCircular(short* circular);
    ///Retrieves or sets a value that indicates if PLA should create a circular file. This property is read/write.
    HRESULT put_LogCircular(short circular);
    ///Retrieves or sets a value that indicates if PLA should overwrite the current file. This property is read/write.
    HRESULT get_LogOverwrite(short* overwrite);
    ///Retrieves or sets a value that indicates if PLA should overwrite the current file. This property is read/write.
    HRESULT put_LogOverwrite(short overwrite);
    ///Retrieves or sets the name of the data collector. This property is read/write.
    HRESULT get_Name(BSTR* name);
    ///Retrieves or sets the name of the data collector. This property is read/write.
    HRESULT put_Name(BSTR name);
    ///Retrieves the decorated file name if PLA were to create it now. This property is read-only.
    HRESULT get_OutputLocation(BSTR* path);
    ///Retrieves the index value of the data collector. The index value identifies the data collector within the data
    ///collector set. This property is read-only.
    HRESULT get_Index(int* index);
    HRESULT put_Index(int index);
    ///Retrieves an XML string that describes the values of the data collector properties. This property is read-only.
    HRESULT get_Xml(BSTR* Xml);
    ///Sets the property values of those properties included in the XML.
    ///Params:
    ///    Xml = XML that contains the collector properties to set. For details on specifying the XML string, see the Remarks
    ///          section of IDataCollector.
    ///    Validation = An IValueMap interface that you use to retrieve the validation error of each property whose value is not
    ///                 valid. The IValueMap::Count property is zero if there were no errors.
    ///Returns:
    ///    Returns S_OK if the method call was successful. You must check the value map for errors. If the method
    ///    returns S_OK and there are no validation errors, then the collector was successfully initialized.
    ///    
    HRESULT SetXml(BSTR Xml, IValueMap* Validation);
    HRESULT CreateOutputLocation(short Latest, BSTR* Location);
}

///Specifies the performance counters to query and the log file to which the counter data is written. To create this
///data collector, call the IDataCollectorCollection::CreateDataCollector or
///IDataCollectorCollection::CreateDataCollectorFromXml method. For details on the XML that you pass to
///<b>CreateDataCollectorFromXml</b>, see Remarks.
@GUID("03837506-098B-11D8-9414-505054503030")
interface IPerformanceCounterDataCollector : IDataCollector
{
    ///Retrieves or sets the data source name if the log file is an SQL log file. This property is read/write.
    HRESULT get_DataSourceName(BSTR* dsn);
    ///Retrieves or sets the data source name if the log file is an SQL log file. This property is read/write.
    HRESULT put_DataSourceName(BSTR dsn);
    ///Retrieves or sets the performance counters to query. This property is read/write.
    HRESULT get_PerformanceCounters(SAFEARRAY** counters);
    ///Retrieves or sets the performance counters to query. This property is read/write.
    HRESULT put_PerformanceCounters(SAFEARRAY* counters);
    ///Retrieves or sets the format of the log file. This property is read/write.
    HRESULT get_LogFileFormat(FileFormat* format);
    ///Retrieves or sets the format of the log file. This property is read/write.
    HRESULT put_LogFileFormat(FileFormat format);
    ///Retrieves or sets the interval to wait between sampling counter data. This property is read/write.
    HRESULT get_SampleInterval(uint* interval);
    ///Retrieves or sets the interval to wait between sampling counter data. This property is read/write.
    HRESULT put_SampleInterval(uint interval);
    ///Retrieves or sets the maximum number of samples to log. This property is read/write.
    HRESULT get_SegmentMaxRecords(uint* records);
    ///Retrieves or sets the maximum number of samples to log. This property is read/write.
    HRESULT put_SegmentMaxRecords(uint records);
}

///Collects trace events from registered providers. This interface defines the trace session. The session starts when
///the data collector set runs. The collection of trace data providers defines the providers that you want to enable to
///the session when the session runs. To create this data collector, call the
///IDataCollectorCollection::CreateDataCollector or IDataCollectorCollection::CreateDataCollectorFromXml method. For
///details on the XML that you pass to <b>CreateDataCollectorFromXml</b>, see Remarks.
@GUID("0383750B-098B-11D8-9414-505054503030")
interface ITraceDataCollector : IDataCollector
{
    ///Retrieves or sets the suggested buffer size for each buffer in the event tracing session. This property is
    ///read/write.
    HRESULT get_BufferSize(uint* size);
    ///Retrieves or sets the suggested buffer size for each buffer in the event tracing session. This property is
    ///read/write.
    HRESULT put_BufferSize(uint size);
    ///Retrieves the number of buffers that were not written to the log file. This property is read-only.
    HRESULT get_BuffersLost(uint* buffers);
    HRESULT put_BuffersLost(uint buffers);
    ///Retrieves the number of buffers written to the log file. This property is read-only.
    HRESULT get_BuffersWritten(uint* buffers);
    HRESULT put_BuffersWritten(uint buffers);
    ///Retrieves or sets the clock resolution to use when logging the time stamp for each event. This property is
    ///read/write.
    HRESULT get_ClockType(ClockType* clock);
    ///Retrieves or sets the clock resolution to use when logging the time stamp for each event. This property is
    ///read/write.
    HRESULT put_ClockType(ClockType clock);
    ///Retrieves the number of events that were not written to the buffer. This property is read-only.
    HRESULT get_EventsLost(uint* events);
    HRESULT put_EventsLost(uint events);
    ///Retrieves or sets the extended log file modes. This property is read/write.
    HRESULT get_ExtendedModes(uint* mode);
    ///Retrieves or sets the extended log file modes. This property is read/write.
    HRESULT put_ExtendedModes(uint mode);
    ///Retrieves or sets the time to wait before flushing buffers. This property is read/write.
    HRESULT get_FlushTimer(uint* seconds);
    ///Retrieves or sets the time to wait before flushing buffers. This property is read/write.
    HRESULT put_FlushTimer(uint seconds);
    ///Retrieves the number of buffers that are allocated but unused in the event tracing session's buffer pool. This
    ///property is read-only.
    HRESULT get_FreeBuffers(uint* buffers);
    HRESULT put_FreeBuffers(uint buffers);
    ///Retrieves or sets the session GUID. This property is read/write.
    HRESULT get_Guid(GUID* guid);
    ///Retrieves or sets the session GUID. This property is read/write.
    HRESULT put_Guid(GUID guid);
    ///Retrieves a value that indicates whether the trace contains kernel providers. This property is read-only.
    HRESULT get_IsKernelTrace(short* kernel);
    ///Retrieves or sets the maximum number of buffers allocated for the event tracing session's buffer pool. This
    ///property is read/write.
    HRESULT get_MaximumBuffers(uint* buffers);
    ///Retrieves or sets the maximum number of buffers allocated for the event tracing session's buffer pool. This
    ///property is read/write.
    HRESULT put_MaximumBuffers(uint buffers);
    ///Retrieves or sets the minimum number of buffers allocated for the event tracing session's buffer pool. This
    ///property is read/write.
    HRESULT get_MinimumBuffers(uint* buffers);
    ///Retrieves or sets the minimum number of buffers allocated for the event tracing session's buffer pool. This
    ///property is read/write.
    HRESULT put_MinimumBuffers(uint buffers);
    ///Retrieves or sets the suggested number of buffers to use for logging. This property is read/write.
    HRESULT get_NumberOfBuffers(uint* buffers);
    ///Retrieves or sets the suggested number of buffers to use for logging. This property is read/write.
    HRESULT put_NumberOfBuffers(uint buffers);
    ///Retrieves or sets a value that indicates whether PLA should allocate the entire log file size before logging.
    ///This property is read/write.
    HRESULT get_PreallocateFile(short* allocate);
    ///Retrieves or sets a value that indicates whether PLA should allocate the entire log file size before logging.
    ///This property is read/write.
    HRESULT put_PreallocateFile(short allocate);
    ///Retrieves or sets a value that indicates whether the session is a private, in-process session. This property is
    ///read/write.
    HRESULT get_ProcessMode(short* process);
    ///Retrieves or sets a value that indicates whether the session is a private, in-process session. This property is
    ///read/write.
    HRESULT put_ProcessMode(short process);
    ///Retrieves the number of buffers that were not delivered in real time to the consumer. This property is read-only.
    HRESULT get_RealTimeBuffersLost(uint* buffers);
    HRESULT put_RealTimeBuffersLost(uint buffers);
    ///Retrieves the session identifier. This property is read-only.
    HRESULT get_SessionId(ulong* id);
    HRESULT put_SessionId(ulong id);
    ///Retrieves or sets the name of the session. This property is read/write.
    HRESULT get_SessionName(BSTR* name);
    ///Retrieves or sets the name of the session. This property is read/write.
    HRESULT put_SessionName(BSTR name);
    ///Retrieves the current thread of the log session, if the thread is running. This property is read-only.
    HRESULT get_SessionThreadId(uint* tid);
    HRESULT put_SessionThreadId(uint tid);
    ///Retrieves or sets the logging mode of the trace session. This property is read/write.
    HRESULT get_StreamMode(StreamMode* mode);
    ///Retrieves or sets the logging mode of the trace session. This property is read/write.
    HRESULT put_StreamMode(StreamMode mode);
    ///Retrieves the list of providers enabled for this trace session. This property is read-only.
    HRESULT get_TraceDataProviders(ITraceDataProviderCollection* providers);
}

///Collects computer settings at the time of collection. You can use the configuration information to verify the system
///state or track changes. PLA saves the configuration information to the file specified in the IDataCollector::FileName
///property. The contents of the file is XML that is consistent with the TraceRpt.exe schema. To create this data
///collector, call the IDataCollectorCollection::CreateDataCollector or
///IDataCollectorCollection::CreateDataCollectorFromXml method. For details on the XML that you pass to
///<b>CreateDataCollectorFromXml</b>, see Remarks.
@GUID("03837514-098B-11D8-9414-505054503030")
interface IConfigurationDataCollector : IDataCollector
{
    ///Retrieves or sets the maximum number of files to collect. This property is read/write.
    HRESULT get_FileMaxCount(uint* count);
    ///Retrieves or sets the maximum number of files to collect. This property is read/write.
    HRESULT put_FileMaxCount(uint count);
    ///Retrieves or sets the maximum number of subfolders from which to recursively collect files. This property is
    ///read/write.
    HRESULT get_FileMaxRecursiveDepth(uint* depth);
    ///Retrieves or sets the maximum number of subfolders from which to recursively collect files. This property is
    ///read/write.
    HRESULT put_FileMaxRecursiveDepth(uint depth);
    ///Retrieves or sets the maximum total file size of all files combined that you can collect. This property is
    ///read/write.
    HRESULT get_FileMaxTotalSize(uint* size);
    ///Retrieves or sets the maximum total file size of all files combined that you can collect. This property is
    ///read/write.
    HRESULT put_FileMaxTotalSize(uint size);
    ///Retrieves or sets the files to collect. This property is read/write.
    HRESULT get_Files(SAFEARRAY** Files);
    ///Retrieves or sets the files to collect. This property is read/write.
    HRESULT put_Files(SAFEARRAY* Files);
    ///Retrieves or sets Windows Management Instrumentation (WMI) queries to run. This property is read/write.
    HRESULT get_ManagementQueries(SAFEARRAY** Queries);
    ///Retrieves or sets Windows Management Instrumentation (WMI) queries to run. This property is read/write.
    HRESULT put_ManagementQueries(SAFEARRAY* Queries);
    ///Retrieves or sets a value that indicates whether the installed network adapters are queried for their offloading
    ///capabilities and other configuration information. This property is read/write.
    HRESULT get_QueryNetworkAdapters(short* network);
    ///Retrieves or sets a value that indicates whether the installed network adapters are queried for their offloading
    ///capabilities and other configuration information. This property is read/write.
    HRESULT put_QueryNetworkAdapters(short network);
    ///Retrieves or sets a list of registry keys to collect. This property is read/write.
    HRESULT get_RegistryKeys(SAFEARRAY** query);
    ///Retrieves or sets a list of registry keys to collect. This property is read/write.
    HRESULT put_RegistryKeys(SAFEARRAY* query);
    ///Retrieves or sets the maximum number of subkeys from which to recursively collect registry values. This property
    ///is read/write.
    HRESULT get_RegistryMaxRecursiveDepth(uint* depth);
    ///Retrieves or sets the maximum number of subkeys from which to recursively collect registry values. This property
    ///is read/write.
    HRESULT put_RegistryMaxRecursiveDepth(uint depth);
    ///Retrieves or sets the name of the file that contains the saved system state. This property is read/write.
    HRESULT get_SystemStateFile(BSTR* FileName);
    ///Retrieves or sets the name of the file that contains the saved system state. This property is read/write.
    HRESULT put_SystemStateFile(BSTR FileName);
}

///Monitors performance counters and performs actions each time a counter value crosses the specified threshold. To
///create the alert data collector, call the IDataCollectorCollection::CreateDataCollector or
///IDataCollectorCollection::CreateDataCollectorFromXml method. For details on the XML that you pass to
///<b>CreateDataCollectorFromXml</b>, see Remarks.
@GUID("03837516-098B-11D8-9414-505054503030")
interface IAlertDataCollector : IDataCollector
{
    ///Retrieves or sets a list of performance counters and thresholds to monitor. This property is read/write.
    HRESULT get_AlertThresholds(SAFEARRAY** alerts);
    ///Retrieves or sets a list of performance counters and thresholds to monitor. This property is read/write.
    HRESULT put_AlertThresholds(SAFEARRAY* alerts);
    ///Retrieves or sets a value that indicates if PLA should log an event each time the counter value crosses the
    ///threshold. This property is read/write.
    HRESULT get_EventLog(short* log);
    ///Retrieves or sets a value that indicates if PLA should log an event each time the counter value crosses the
    ///threshold. This property is read/write.
    HRESULT put_EventLog(short log);
    ///Retrieves or sets the time interval to wait between sampling counter data. This property is read/write.
    HRESULT get_SampleInterval(uint* interval);
    ///Retrieves or sets the time interval to wait between sampling counter data. This property is read/write.
    HRESULT put_SampleInterval(uint interval);
    ///Retrieves or sets the name of a Task Scheduler job to start each time the counter value crosses the threshold.
    ///This property is read/write.
    HRESULT get_Task(BSTR* task);
    ///Retrieves or sets the name of a Task Scheduler job to start each time the counter value crosses the threshold.
    ///This property is read/write.
    HRESULT put_Task(BSTR task);
    ///Retrieves or sets a value that determines whether the task runs as the data collector set user or as the user
    ///specified in the task. This property is read/write.
    HRESULT get_TaskRunAsSelf(short* RunAsSelf);
    ///Retrieves or sets a value that determines whether the task runs as the data collector set user or as the user
    ///specified in the task. This property is read/write.
    HRESULT put_TaskRunAsSelf(short RunAsSelf);
    ///Retrieves or sets the command-line arguments to pass to the Task Scheduler job specified in the
    ///IAlertDataCollector::Task property. This property is read/write.
    HRESULT get_TaskArguments(BSTR* task);
    ///Retrieves or sets the command-line arguments to pass to the Task Scheduler job specified in the
    ///IAlertDataCollector::Task property. This property is read/write.
    HRESULT put_TaskArguments(BSTR task);
    ///Retrieves or sets the command-line arguments to pass to the Task Scheduler job specified in the
    ///IAlertDataCollector::Task property. This property is read/write.
    HRESULT get_TaskUserTextArguments(BSTR* task);
    ///Retrieves or sets the command-line arguments to pass to the Task Scheduler job specified in the
    ///IAlertDataCollector::Task property. This property is read/write.
    HRESULT put_TaskUserTextArguments(BSTR task);
    ///Retrieves or sets the name of a data collector set to start each time the counter value crosses the threshold.
    ///This property is read/write.
    HRESULT get_TriggerDataCollectorSet(BSTR* name);
    ///Retrieves or sets the name of a data collector set to start each time the counter value crosses the threshold.
    ///This property is read/write.
    HRESULT put_TriggerDataCollectorSet(BSTR name);
}

///Logs Win32 calls to Kernel32.dll, Advapi32.dll, Gdi32.dll, and User32.dll. Note that for security reasons, not all
///function calls are logged. To create this data collector, call the IDataCollectorCollection::CreateDataCollector or
///IDataCollectorCollection::CreateDataCollectorFromXml method. For details on the XML that you pass to
///<b>CreateDataCollectorFromXml</b>, see Remarks.
@GUID("0383751A-098B-11D8-9414-505054503030")
interface IApiTracingDataCollector : IDataCollector
{
    ///Retrieves or sets a value that indicates whether PLA logs only the function name. This property is read/write.
    HRESULT get_LogApiNamesOnly(short* logapinames);
    ///Retrieves or sets a value that indicates whether PLA logs only the function name. This property is read/write.
    HRESULT put_LogApiNamesOnly(short logapinames);
    ///Retrieves or sets a value that indicates whether API tracing logs calls that are imported directly by the
    ///application. This property is read/write.
    HRESULT get_LogApisRecursively(short* logrecursively);
    ///Retrieves or sets a value that indicates whether API tracing logs calls that are imported directly by the
    ///application. This property is read/write.
    HRESULT put_LogApisRecursively(short logrecursively);
    ///Retrieves or sets the path to the executable file whose API calls you want to trace. This property is read/write.
    HRESULT get_ExePath(BSTR* exepath);
    ///Retrieves or sets the path to the executable file whose API calls you want to trace. This property is read/write.
    HRESULT put_ExePath(BSTR exepath);
    ///Retrieves or sets the name of the log file that contains the API trace data. This property is read/write.
    HRESULT get_LogFilePath(BSTR* logfilepath);
    ///Retrieves or sets the name of the log file that contains the API trace data. This property is read/write.
    HRESULT put_LogFilePath(BSTR logfilepath);
    ///Retrieves or sets the list of modules to include in the trace. This property is read/write.
    HRESULT get_IncludeModules(SAFEARRAY** includemodules);
    ///Retrieves or sets the list of modules to include in the trace. This property is read/write.
    HRESULT put_IncludeModules(SAFEARRAY* includemodules);
    ///Retrieves or sets the list of functions to include in the trace. This property is read/write.
    HRESULT get_IncludeApis(SAFEARRAY** includeapis);
    ///Retrieves or sets the list of functions to include in the trace. This property is read/write.
    HRESULT put_IncludeApis(SAFEARRAY* includeapis);
    ///Retrieves or sets the list of functions to exclude from the trace. This property is read/write.
    HRESULT get_ExcludeApis(SAFEARRAY** excludeapis);
    ///Retrieves or sets the list of functions to exclude from the trace. This property is read/write.
    HRESULT put_ExcludeApis(SAFEARRAY* excludeapis);
}

///Manages a collection of DataCollector objects. To get this interface, access the IDataCollectorSet::DataCollectors
///property.
@GUID("03837502-098B-11D8-9414-505054503030")
interface IDataCollectorCollection : IDispatch
{
    ///Retrieves the number of data collectors in the collection. This property is read-only.
    HRESULT get_Count(int* retVal);
    ///Retrieves the requested data collector from the collection. This property is read-only.
    HRESULT get_Item(VARIANT index, IDataCollector* collector);
    ///Retrieves an interface to the enumeration. This property is read-only.
    HRESULT get__NewEnum(IUnknown* retVal);
    ///Adds a data collector to the collection.
    ///Params:
    ///    collector = An IDataCollector interface of the data collector to add to this collection.
    ///Returns:
    ///    Returns S_OK if successful. The following table shows a possible error value. <table> <tr> <th>Return
    ///    code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>PLA_E_DCS_SINGLETON_REQUIRED</b></dt> <dt>0x80300102</dt> </dl> </td> <td width="60%"> The current
    ///    configuration for the data collector set requires that it contain exactly one data collector. </td> </tr>
    ///    </table>
    ///    
    HRESULT Add(IDataCollector collector);
    ///Removes a data collector from the collection.
    ///Params:
    ///    collector = The zero-based index of the data collector to remove from the collection. The variant type can be VT_I4,
    ///                VT_UI4, or VT_DISPATCH.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT Remove(VARIANT collector);
    ///Removes all data collectors from the collection.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT Clear();
    ///Adds one or more data collectors to the collection.
    ///Params:
    ///    collectors = An IDataCollectorCollection interface to a collection of one or more data collectors to add to this
    ///                 collection.
    ///Returns:
    ///    Returns S_OK if successful. The following table shows a possible error value. <table> <tr> <th>Return
    ///    code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>PLA_E_DCS_SINGLETON_REQUIRED</b></dt> <dt>0x80300102</dt> </dl> </td> <td width="60%"> The current
    ///    configuration for the data collector set requires that it contain exactly one data collector. </td> </tr>
    ///    </table>
    ///    
    HRESULT AddRange(IDataCollectorCollection collectors);
    ///Creates a data collector using the specified XML.
    ///Params:
    ///    bstrXml = A string that contains the XML of the data collector to create. For details on specifying the XML string, see
    ///              the Remarks section of the data collector that you want to create.
    ///    pValidation = An IValueMap interface that you use to retrieve the validation error of each property whose value is not
    ///                  valid. The IValueMap::Count property is zero if there were no errors.
    ///    pCollector = An IDataCollector interface of the newly created data collector. To get the actual data collector interface
    ///                 requested, call the <b>QueryInterface</b> method.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT CreateDataCollectorFromXml(BSTR bstrXml, IValueMap* pValidation, IDataCollector* pCollector);
    ///Creates a data collector of the specified type.
    ///Params:
    ///    Type = The type of data collector to create. For possible data collector types, see the DataCollectorType
    ///           enumeration.
    ///    Collector = An IDataCollector interface of the newly created data collector. To get the actual data collector interface
    ///                requested, call the <b>QueryInterface</b> method.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT CreateDataCollector(DataCollectorType Type, IDataCollector* Collector);
}

///Manages a collection of DataCollectorSet objects. To get this interface, call the <b>CoCreateInstance</b> function,
///passing __uuidof(DataCollectorSetCollection) as the class identifier and __uuidof(<b>IDataCollectorSetCollection</b>)
///as the interface identifier. Then, to populate the collection, call the
///IDataCollectorSetCollection::GetDataCollectorSets method.
@GUID("03837524-098B-11D8-9414-505054503030")
interface IDataCollectorSetCollection : IDispatch
{
    ///Retrieves the number of data collector sets in the collection. This property is read-only.
    HRESULT get_Count(int* retVal);
    ///Retrieves the requested data collector set from the collection. This property is read-only.
    HRESULT get_Item(VARIANT index, IDataCollectorSet* set);
    ///Retrieves an interface to the enumeration. This property is read-only.
    HRESULT get__NewEnum(IUnknown* retVal);
    ///Adds a data collector set to the collection.
    ///Params:
    ///    set = An IDataCollectorSet interface of the data collector set to add to this collection.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT Add(IDataCollectorSet set);
    ///Removes a data collector set from the collection.
    ///Params:
    ///    set = The zero-based index of the data collector set to remove from the collection. The variant type can be VT_I4,
    ///          VT_UI4, or VT_DISPATCH.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT Remove(VARIANT set);
    ///Removes all data collector sets from the collection.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT Clear();
    ///Adds one or more data collector sets to the collection.
    ///Params:
    ///    sets = An IDataCollectorSetCollection interface to a collection of one or more data collector sets to add to this
    ///           collection.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT AddRange(IDataCollectorSetCollection sets);
    ///Populates the data collector set collection.
    ///Params:
    ///    server = The computer whose data collector sets you want to enumerate. You can specify a computer name, a fully
    ///             qualified domain name, or an IP address (IPv4 or IPv6 format). If <b>NULL</b>, PLA enumerates the sets on the
    ///             local computer.
    ///    filter = If empty, PLA enumerates sets from all namespaces; otherwise, specify a specific namespace to enumerate. The
    ///             form is &lt;namespace&gt;\*. For possible namespace values, see IDataCollectorSet::Commit.
    ///Returns:
    ///    Returns S_OK if successful. The following table shows possible error values. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(RPC_S_SERVER_UNAVAILABLE)</b></dt> </dl> </td> <td width="60%"> The RPC server is
    ///    not available. The method is unable to query the data collector set remotely. To query the data collector set
    ///    from a remote computer running Windows Vista, enable Performance Logs and Alerts in <b>Windows Firewall
    ///    Settings</b> on the remote computer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_BAD_NETPATH)</b></dt> </dl> </td> <td width="60%"> Unable to find the remote
    ///    computer. </td> </tr> </table>
    ///    
    HRESULT GetDataCollectorSets(BSTR server, BSTR filter);
}

///Specifies a trace provider to enable in the trace session. To get this interface, call the
///ITraceDataProviderCollection::CreateTraceDataProvider method. You can also use XML to define the provider. For more
///information, see the Remarks section of ITraceDataCollector.
@GUID("03837512-098B-11D8-9414-505054503030")
interface ITraceDataProvider : IDispatch
{
    ///Retrieves or sets the display name of the provider. This property is read/write.
    HRESULT get_DisplayName(BSTR* name);
    ///Retrieves or sets the display name of the provider. This property is read/write.
    HRESULT put_DisplayName(BSTR name);
    ///Retrieves or sets the provider's GUID. This property is read/write.
    HRESULT get_Guid(GUID* guid);
    ///Retrieves or sets the provider's GUID. This property is read/write.
    HRESULT put_Guid(GUID guid);
    ///Retrieves the level of information used to enable the provider. This property is read-only.
    HRESULT get_Level(IValueMap* ppLevel);
    ///Retrieves the list of keywords that determine the category of events that you want the provider to write. This
    ///property is read-only.
    HRESULT get_KeywordsAny(IValueMap* ppKeywords);
    ///Retrieves the list of keywords that restricts the category of events that you want the provider to write. The
    ///restrictions are in addition to those provided by the ITraceDataProvider::KeywordsAny property. This property is
    ///read-only.
    HRESULT get_KeywordsAll(IValueMap* ppKeywords);
    ///Retrieves the list of extended data items that Event Tracing for Windows (ETW) includes with the event. This
    ///property is read-only.
    HRESULT get_Properties(IValueMap* ppProperties);
    ///Retrieves or sets a value that determines whether the filter data is used to enable the provider. This property
    ///is read/write.
    HRESULT get_FilterEnabled(short* FilterEnabled);
    ///Retrieves or sets a value that determines whether the filter data is used to enable the provider. This property
    ///is read/write.
    HRESULT put_FilterEnabled(short FilterEnabled);
    ///Retrieves or sets a provider-defined filter type. This property is read/write.
    HRESULT get_FilterType(uint* pulType);
    ///Retrieves or sets a provider-defined filter type. This property is read/write.
    HRESULT put_FilterType(uint ulType);
    ///Retrieves or sets arbitrary data that is sent to the trace data provider for filtering purposes. This property is
    ///read/write.
    HRESULT get_FilterData(SAFEARRAY** ppData);
    ///Retrieves or sets arbitrary data that is sent to the trace data provider for filtering purposes. This property is
    ///read/write.
    HRESULT put_FilterData(SAFEARRAY* pData);
    ///Retrieves details about a registered provider.
    ///Params:
    ///    bstrName = The name of the registered provider. The name is case-insensitive. You can also specify the string form of
    ///               the provider's GUID.
    ///    bstrServer = The computer on which the provider is registered. You can specify the computer's name, fully qualified domain
    ///                 name, or IP address.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT Query(BSTR bstrName, BSTR bstrServer);
    ///Merges the details about a provider with this instance.
    ///Params:
    ///    pFrom = The interface of the provider to merge with this instance.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT Resolve(IDispatch pFrom);
    ///Sets the security information for the trace data provider.
    ///Params:
    ///    Sddl = A string that describes the security descriptor for the object. For details, see Security Descriptor
    ///           Definition Language.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT SetSecurity(BSTR Sddl);
    ///Retrieves the security information for the trace data provider.
    ///Params:
    ///    SecurityInfo = The object-related security information. For details, see the SECURITY_INFORMATION data type.
    ///    Sddl = A string that describes the security descriptor for the object. For details, see Security Descriptor
    ///           Definition Language.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT GetSecurity(uint SecurityInfo, BSTR* Sddl);
    ///Retrieves a list of processes that have registered as an Event Tracing for Windows (ETW) provider.
    ///Params:
    ///    Processes = An IValueMap interface that contains the list of processes that have registered as an ETW provider. The
    ///                IValueMapItem::Key property contains the name of the binary, and the IValueMapItem::Value property contains
    ///                the process identifier.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT GetRegisteredProcesses(IValueMap* Processes);
}

///Manages a collection of TraceDataProvider objects. To get this interface, access the
///ITraceDataCollector::TraceDataProviders property. You can also call the <b>CoCreateInstance</b> function to create a
///new instance of the <b>TraceDataProviderCollection</b> object. Pass __uuidof(TraceDataProviderCollection) as the
///class identifier and __uuidof(<b>ITraceDataProviderCollection</b>) as the interface identifier. To populate the
///collection with registered providers, call the ITraceDataProviderCollection::GetTraceDataProviders method.
@GUID("03837510-098B-11D8-9414-505054503030")
interface ITraceDataProviderCollection : IDispatch
{
    ///Retrieves the number of trace providers in the collection. This property is read-only.
    HRESULT get_Count(int* retVal);
    ///Retrieves the requested trace provider from the collection. This property is read-only.
    HRESULT get_Item(VARIANT index, ITraceDataProvider* ppProvider);
    ///Retrieves an interface to the enumeration. This property is read-only.
    HRESULT get__NewEnum(IUnknown* retVal);
    ///Adds a trace provider to the collection.
    ///Params:
    ///    pProvider = An ITraceDataProvider interface of the trace provider to add to this collection.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT Add(ITraceDataProvider pProvider);
    ///Removes a trace provider from the collection.
    ///Params:
    ///    vProvider = The zero-based index of the trace provider to remove from the collection. The variant type can be VT_I4,
    ///                VT_UI4, or VT_DISPATCH.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT Remove(VARIANT vProvider);
    ///Removes all trace providers from the collection.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT Clear();
    ///Adds one or more trace providers to the collection.
    ///Params:
    ///    providers = An ITraceDataProviderCollection interface to a collection of one or more trace providers to add to this
    ///                collection.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT AddRange(ITraceDataProviderCollection providers);
    ///Creates a trace data provider object.
    ///Params:
    ///    Provider = An ITraceDataProvider interface that you use to specify a trace provider to enable in the trace session.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT CreateTraceDataProvider(ITraceDataProvider* Provider);
    ///Populates the collection with registered trace providers.
    ///Params:
    ///    server = The computer whose registered trace providers you want to enumerate. You can specify a computer name, a fully
    ///             qualified domain name, or an IP address (IPv4 or IPv6 format). If <b>NULL</b>, PLA enumerates the providers
    ///             on the local computer.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT GetTraceDataProviders(BSTR server);
    ///Populates the collection with the list of providers that have been registered by the specified process.
    ///Params:
    ///    Server = The computer whose registered trace providers you want to enumerate. You can specify a computer name, a fully
    ///             qualified domain name, or an IP address (IPv4 or IPv6 format). If <b>NULL</b>, PLA enumerates the providers
    ///             on the local computer.
    ///    Pid = The process identifier of the process that registered the providers.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT GetTraceDataProvidersByProcess(BSTR Server, uint Pid);
}

///Specifies when the data collector set runs. To get this interface, call the IScheduleCollection::CreateSchedule
///method.
@GUID("0383753A-098B-11D8-9414-505054503030")
interface ISchedule : IDispatch
{
    ///Retrieves or sets the date when the schedule becomes valid. This property is read/write.
    HRESULT get_StartDate(VARIANT* start);
    ///Retrieves or sets the date when the schedule becomes valid. This property is read/write.
    HRESULT put_StartDate(VARIANT start);
    ///Retrieves or sets the last date that the schedule is valid. This property is read/write.
    HRESULT get_EndDate(VARIANT* end);
    ///Retrieves or sets the last date that the schedule is valid. This property is read/write.
    HRESULT put_EndDate(VARIANT end);
    ///Retrieves or sets the time of day when the data collector set runs. This property is read/write.
    HRESULT get_StartTime(VARIANT* start);
    ///Retrieves or sets the time of day when the data collector set runs. This property is read/write.
    HRESULT put_StartTime(VARIANT start);
    ///Retrieves or sets the days on which the data collector set runs. This property is read/write.
    HRESULT get_Days(WeekDays* days);
    ///Retrieves or sets the days on which the data collector set runs. This property is read/write.
    HRESULT put_Days(WeekDays days);
}

///Manages a collection of Schedule objects. To get this interface, access the IDataCollectorSet::Schedules property.
@GUID("0383753D-098B-11D8-9414-505054503030")
interface IScheduleCollection : IDispatch
{
    ///Retrieves the number of schedules in the collection. This property is read-only.
    HRESULT get_Count(int* retVal);
    ///Retrieves the requested schedule from the collection. This property is read-only.
    HRESULT get_Item(VARIANT index, ISchedule* ppSchedule);
    ///Retrieves an interface to the enumeration. This property is read-only.
    HRESULT get__NewEnum(IUnknown* ienum);
    ///Adds a schedule to the collection.
    ///Params:
    ///    pSchedule = An ISchedule interface of the schedule to add to the collection.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT Add(ISchedule pSchedule);
    ///Removes a schedule from the collection.
    ///Params:
    ///    vSchedule = The zero-based index of the schedule to remove from the collection. The variant type can be VT_I4, VT_UI4, or
    ///                VT_DISPATCH.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT Remove(VARIANT vSchedule);
    ///Removes all schedules from the collection.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT Clear();
    ///Adds one or more schedules to the collection.
    ///Params:
    ///    pSchedules = An IScheduleCollection interface to a collection of one or more schedules to add to this collection.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT AddRange(IScheduleCollection pSchedules);
    ///Creates a schedule object.
    ///Params:
    ///    Schedule = An ISchedule interface that you use to specify when the data collector set runs.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT CreateSchedule(ISchedule* Schedule);
}

///Defines a name/value pair. To get this interface, call the IValueMap::Item property. To create this interface, call
///the IValueMap::CreateValueMapItem method.
@GUID("03837533-098B-11D8-9414-505054503030")
interface IValueMapItem : IDispatch
{
    ///Retrieves or sets a description of the item. This property is read/write.
    HRESULT get_Description(BSTR* description);
    ///Retrieves or sets a description of the item. This property is read/write.
    HRESULT put_Description(BSTR description);
    ///Retrieves or sets a value that indicates whether the item is enabled. This property is read/write.
    HRESULT get_Enabled(short* enabled);
    ///Retrieves or sets a value that indicates whether the item is enabled. This property is read/write.
    HRESULT put_Enabled(short enabled);
    ///Retrieves or sets the name of the item. This property is read/write.
    HRESULT get_Key(BSTR* key);
    ///Retrieves or sets the name of the item. This property is read/write.
    HRESULT put_Key(BSTR key);
    ///Retrieves or sets the value of the item. This property is read/write.
    HRESULT get_Value(VARIANT* Value);
    ///Retrieves or sets the value of the item. This property is read/write.
    HRESULT put_Value(VARIANT Value);
    ///Retrieves or sets the type of the item. This property is read/write.
    HRESULT get_ValueMapType(ValueMapType* type);
    ///Retrieves or sets the type of the item. This property is read/write.
    HRESULT put_ValueMapType(ValueMapType type);
}

///Manages a collection of name/value pairs. To get this interface, access one of the following properties or
///methods:<ul> <li> IDataCollector::SetXml </li> <li> IDataCollectorSet::Commit </li> <li> IDataCollectorSet::SetXml
///</li> <li> ITraceDataProvider::KeywordsAll </li> <li> ITraceDataProvider::KeywordsAny </li> <li>
///ITraceDataProvider::Level </li> <li> ITraceDataProvider::Properties </li> </ul>
@GUID("03837534-098B-11D8-9414-505054503030")
interface IValueMap : IDispatch
{
    ///Retrieves the number of items in the collection. This property is read-only.
    HRESULT get_Count(int* retVal);
    ///Retrieves the requested item from the collection. This property is read-only.
    HRESULT get_Item(VARIANT index, IValueMapItem* value);
    ///Retrieves an interface to the enumeration. This property is read-only.
    HRESULT get__NewEnum(IUnknown* retVal);
    ///Retrieves or sets a description of the collection. This property is read/write.
    HRESULT get_Description(BSTR* description);
    ///Retrieves or sets a description of the collection. This property is read/write.
    HRESULT put_Description(BSTR description);
    ///Retrieves or sets the value of the collection. This property is read/write.
    HRESULT get_Value(VARIANT* Value);
    ///Retrieves or sets the value of the collection. This property is read/write.
    HRESULT put_Value(VARIANT Value);
    ///Retrieves or sets the type of items in the collection. This property is read/write.
    HRESULT get_ValueMapType(ValueMapType* type);
    ///Retrieves or sets the type of items in the collection. This property is read/write.
    HRESULT put_ValueMapType(ValueMapType type);
    ///Adds an item to the collection.
    ///Params:
    ///    value = An <b>IDispatch</b> interface of the IValueMapItem interface to add to the collection. The variant type is
    ///            VT_DISPATCH. You can also add a string or integer value. If the value is an integer (the variant type is
    ///            VT_I4, VT_UI4, VT_I8, or VT_UI8), PLA adds an item with the specified value. If the value is a string (the
    ///            variant type is VT_BSTR), PLA tries to convert the string to an integer. If successful, PLA adds an item with
    ///            the specified integer value. If PLA cannot convert the string, PLA searches the collection for a key that
    ///            matches the string. If found, PLA enables the item; otherwise, the add fails.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT Add(VARIANT value);
    ///Removes an item from the collection.
    ///Params:
    ///    value = The zero-based index of the item to remove from the collection. The variant type can be VT_I4, VT_UI4, or
    ///            VT_DISPATCH.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT Remove(VARIANT value);
    ///Removes all items from the collection
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT Clear();
    ///Adds one or more items to the collection.
    ///Params:
    ///    map = An IValueMap interface that contains a collection of items to add to this collection.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
    HRESULT AddRange(IValueMap map);
    ///Creates a value map item.
    ///Params:
    ///    Item = An IValueMapItem interface that you use to define a name/value pair.
    ///Returns:
    ///    Returns S_OK if successful.
    ///    
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
