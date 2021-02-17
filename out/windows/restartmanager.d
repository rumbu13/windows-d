// Written in the D programming language.

module windows.restartmanager;

public import windows.core;
public import windows.systemservices : BOOL;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Enums


///Specifies the type of application that is described by the RM_PROCESS_INFO structure.
alias RM_APP_TYPE = int;
enum : int
{
    ///The application cannot be classified as any other type. An application of this type can only be shut down by a
    ///forced shutdown.
    RmUnknownApp  = 0x00000000,
    ///A Windows application run as a stand-alone process that displays a top-level window.
    RmMainWindow  = 0x00000001,
    ///A Windows application that does not run as a stand-alone process and does not display a top-level window.
    RmOtherWindow = 0x00000002,
    ///The application is a Windows service.
    RmService     = 0x00000003,
    ///The application is Windows Explorer.
    RmExplorer    = 0x00000004,
    ///The application is a stand-alone console application.
    RmConsole     = 0x00000005,
    ///A system restart is required to complete the installation because a process cannot be shut down. The process
    ///cannot be shut down because of the following reasons. The process may be a critical process. The current user may
    ///not have permission to shut down the process. The process may belong to the primary installer that started the
    ///Restart Manager.
    RmCritical    = 0x000003e8,
}

///Configures the shut down of applications.
alias RM_SHUTDOWN_TYPE = int;
enum : int
{
    ///Forces unresponsive applications and services to shut down after the timeout period. An application that does not
    ///respond to a shutdown request by the Restart Manager is forced to shut down after 30 seconds. A service that does
    ///not respond to a shutdown request is forced to shut down after 20 seconds. These default times can be changed by
    ///modifying the registry keys described in the Remarks section.
    RmForceShutdown          = 0x00000001,
    ///Shuts down applications if and only if all the applications have been registered for restart using the
    ///<b>RegisterApplicationRestart</b> function. If any processes or services cannot be restarted, then no processes
    ///or services are shut down.
    RmShutdownOnlyRegistered = 0x00000010,
}

///Describes the current status of an application that is acted upon by the Restart Manager.
alias RM_APP_STATUS = int;
enum : int
{
    ///The application is in a state that is not described by any other enumerated state.
    RmStatusUnknown        = 0x00000000,
    ///The application is currently running.
    RmStatusRunning        = 0x00000001,
    ///The Restart Manager has stopped the application.
    RmStatusStopped        = 0x00000002,
    ///An action outside the Restart Manager has stopped the application.
    RmStatusStoppedOther   = 0x00000004,
    ///The Restart Manager has restarted the application.
    RmStatusRestarted      = 0x00000008,
    ///The Restart Manager encountered an error when stopping the application.
    RmStatusErrorOnStop    = 0x00000010,
    ///The Restart Manager encountered an error when restarting the application.
    RmStatusErrorOnRestart = 0x00000020,
    ///Shutdown is masked by a filter.
    RmStatusShutdownMasked = 0x00000040,
    ///Restart is masked by a filter.
    RmStatusRestartMasked  = 0x00000080,
}

///Describes the reasons a restart of the system is needed.
alias RM_REBOOT_REASON = int;
enum : int
{
    ///A system restart is not required.
    RmRebootReasonNone             = 0x00000000,
    ///The current user does not have sufficient privileges to shut down one or more processes.
    RmRebootReasonPermissionDenied = 0x00000001,
    ///One or more processes are running in another Terminal Services session.
    RmRebootReasonSessionMismatch  = 0x00000002,
    ///A system restart is needed because one or more processes to be shut down are critical processes.
    RmRebootReasonCriticalProcess  = 0x00000004,
    ///A system restart is needed because one or more services to be shut down are critical services.
    RmRebootReasonCriticalService  = 0x00000008,
    ///A system restart is needed because the current process must be shut down.
    RmRebootReasonDetectedSelf     = 0x00000010,
}

///Describes the restart or shutdown actions for an application or service.
alias RM_FILTER_TRIGGER = int;
enum : int
{
    ///An invalid filter trigger.
    RmFilterTriggerInvalid = 0x00000000,
    ///Modifies the shutdown or restart actions for an application identified by its executable filename.
    RmFilterTriggerFile    = 0x00000001,
    ///Modifies the shutdown or restart actions for an application identified by a RM_UNIQUE_PROCESS structure.
    RmFilterTriggerProcess = 0x00000002,
    ///Modifies the shutdown or restart actions for a service identified by a service short name.
    RmFilterTriggerService = 0x00000003,
}

///Specifies the type of modification that is applied to restart or shutdown actions.
alias RM_FILTER_ACTION = int;
enum : int
{
    ///An invalid filter action.
    RmInvalidFilterAction = 0x00000000,
    ///Prevents the restart of the specified application or service.
    RmNoRestart           = 0x00000001,
    ///Prevents the shut down and restart of the specified application or service.
    RmNoShutdown          = 0x00000002,
}

// Callbacks

///The <b>RM_WRITE_STATUS_CALLBACK</b> function can be implemented by the user interface that controls the Restart
///Manager. The installer that started the Restart Manager session can pass a pointer to this function to the Restart
///Manager functions to receive a percentage of completeness. The percentage of completeness is strictly increasing and
///describes the current operation being performed and the name of the application being affected.
///Params:
///    nPercentComplete = An integer value between 0 and 100 that indicates the percentage of the total number of applications that have
///                       either been shut down or restarted.
alias RM_WRITE_STATUS_CALLBACK = void function(uint nPercentComplete);

// Structs


///Uniquely identifies a process by its PID and the time the process began. An array of <b>RM_UNIQUE_PROCESS</b>
///structures can be passed to the RmRegisterResources function.
struct RM_UNIQUE_PROCESS
{
    ///The product identifier (PID).
    uint     dwProcessId;
    ///The creation time of the process. The time is provided as a <b>FILETIME</b> structure that is returned by the
    ///<i>lpCreationTime</i> parameter of the GetProcessTimes function.
    FILETIME ProcessStartTime;
}

///Describes an application that is to be registered with the Restart Manager.
struct RM_PROCESS_INFO
{
    ///Contains an RM_UNIQUE_PROCESS structure that uniquely identifies the application by its PID and the time the
    ///process began.
    RM_UNIQUE_PROCESS Process;
    ///If the process is a service, this parameter returns the long name for the service. If the process is not a
    ///service, this parameter returns the user-friendly name for the application. If the process is a critical process,
    ///and the installer is run with elevated privileges, this parameter returns the name of the executable file of the
    ///critical process. If the process is a critical process, and the installer is run as a service, this parameter
    ///returns the long name of the critical process.
    ushort[256]       strAppName;
    ///If the process is a service, this is the short name for the service. This member is not used if the process is
    ///not a service.
    ushort[64]        strServiceShortName;
    ///Contains an RM_APP_TYPE enumeration value that specifies the type of application as <b>RmUnknownApp</b>,
    ///<b>RmMainWindow</b>, <b>RmOtherWindow</b>, <b>RmService</b>, <b>RmExplorer</b> or <b>RmCritical</b>.
    RM_APP_TYPE       ApplicationType;
    ///Contains a bit mask that describes the current status of the application. See the RM_APP_STATUS enumeration.
    uint              AppStatus;
    ///Contains the Terminal Services session ID of the process. If the terminal session of the process cannot be
    ///determined, the value of this member is set to <b>RM_INVALID_SESSION</b> (-1). This member is not used if the
    ///process is a service or a system critical process.
    uint              TSSessionId;
    ///<b>TRUE</b> if the application can be restarted by the Restart Manager; otherwise, <b>FALSE</b>. This member is
    ///always <b>TRUE</b> if the process is a service. This member is always <b>FALSE</b> if the process is a critical
    ///system process.
    BOOL              bRestartable;
}

///Contains information about modifications to restart or shutdown actions. Add, remove, and list modifications to
///specified applications and services that have been registered with the Restart Manager session by using the
///RmAddFilter, RmRemoveFilter, and the RmGetFilterList functions.
struct RM_FILTER_INFO
{
    ///This member contains a RM_FILTER_ACTION enumeration value. Use the value <b>RmNoRestart</b> to prevent the
    ///restart of the application or service. Use the value <b>RmNoShutdown</b> to prevent the shutdown and restart of
    ///the application or service.
    RM_FILTER_ACTION  FilterAction;
    ///This member contains a RM_FILTER_TRIGGER enumeration value. Use the value <b>RmFilterTriggerFile</b> to modify
    ///the restart or shutdown actions of an application referenced by the executable's full path filename. Use the
    ///value <b>RmFilterTriggerProcess</b> to modify the restart or shutdown actions of an application referenced by a
    ///RM_UNIQUE_PROCESS structure. Use the value <b>RmFilterTriggerService</b> to modify the restart or shutdown
    ///actions of a service referenced by the short service name.
    RM_FILTER_TRIGGER FilterTrigger;
    ///The offset in bytes to the next structure.
    uint              cbNextOffset;
    union
    {
        const(wchar)*     strFilename;
        RM_UNIQUE_PROCESS Process;
        const(wchar)*     strServiceShortName;
    }
}

// Functions

///Starts a new Restart Manager session. A maximum of 64 Restart Manager sessions per user session can be open on the
///system at the same time. When this function starts a session, it returns a session handle and session key that can be
///used in subsequent calls to the Restart Manager API.
///Params:
///    pSessionHandle = A pointer to the handle of a Restart Manager session. The session handle can be passed in subsequent calls to the
///                     Restart Manager API.
///    dwSessionFlags = Reserved. This parameter should be 0.
///    strSessionKey = A <b>null</b>-terminated string that contains the session key to the new session. The string must be allocated
///                    before calling the <b>RmStartSession</b> function.
///Returns:
///    This is the most recent error received. The function can return one of the system error codes that are defined in
///    Winerror.h. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The function completed successfully. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SEM_TIMEOUT</b></dt> <dt>121</dt> </dl> </td> <td width="60%"> A
///    Restart Manager function could not obtain a Registry write mutex in the allotted time. A system restart is
///    recommended because further use of the Restart Manager is likely to fail. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BAD_ARGUMENTS</b></dt> <dt>160</dt> </dl> </td> <td width="60%"> One or more arguments are not
///    correct. This error value is returned by the Restart Manager function if a <b>NULL</b> pointer or 0 is passed in
///    a parameter that requires a non-<b>null</b> and non-zero value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MAX_SESSIONS_REACHED</b></dt> <dt>353</dt> </dl> </td> <td width="60%"> The maximum number of
///    sessions has been reached. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_WRITE_FAULT</b></dt> <dt>29</dt>
///    </dl> </td> <td width="60%"> The system cannot write to the specified device. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_OUTOFMEMORY</b></dt> <dt>14</dt> </dl> </td> <td width="60%"> A Restart Manager operation could
///    not complete because not enough memory was available. </td> </tr> </table>
///    
@DllImport("rstrtmgr")
uint RmStartSession(uint* pSessionHandle, uint dwSessionFlags, char* strSessionKey);

///Joins a secondary installer to an existing Restart Manager session. This function must be called with a session key
///that can only be obtained from the primary installer that started the session. A valid session key is required to use
///any of the Restart Manager functions. After a secondary installer joins a session, it can call the
///RmRegisterResources function to register resources.
///Params:
///    pSessionHandle = A pointer to the handle of an existing Restart Manager Session.
///    strSessionKey = A <b>null</b>-terminated string that contains the session key of an existing session.
///Returns:
///    This is the most recent error received. The function can return one of the system error codes that are defined in
///    Winerror.h. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The function completed successfully. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SESSION_CREDENTIAL_CONFLICT</b></dt> <dt>1219</dt> </dl> </td> <td
///    width="60%"> The session key cannot be validated. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SEM_TIMEOUT</b></dt> <dt>121</dt> </dl> </td> <td width="60%"> A Restart Manager function could not
///    obtain a Registry write mutex in the allotted time. A system restart is recommended because further use of the
///    Restart Manager is likely to fail. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_ARGUMENTS</b></dt>
///    <dt>22</dt> </dl> </td> <td width="60%"> One or more arguments are not correct. This error value is returned by
///    the Restart Manager function if a <b>NULL</b> pointer or 0 is passed in a parameter that requires a
///    non-<b>null</b> and non-zero value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_WRITE_FAULT</b></dt>
///    <dt>29</dt> </dl> </td> <td width="60%"> An operation was unable to read or write to the registry. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_MAX_SESSIONS_REACHED</b></dt> <dt>353</dt> </dl> </td> <td width="60%">
///    The maximum number of sessions has been reached. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_OUTOFMEMORY</b></dt> <dt>14</dt> </dl> </td> <td width="60%"> A Restart Manager operation could not
///    complete because not enough memory was available. </td> </tr> </table>
///    
@DllImport("RstrtMgr")
uint RmJoinSession(uint* pSessionHandle, char* strSessionKey);

///Ends the Restart Manager session. This function should be called by the primary installer that has previously started
///the session by calling the RmStartSession function. The <b>RmEndSession</b> function can be called by a secondary
///installer that is joined to the session once no more resources need to be registered by the secondary installer.
///Params:
///    dwSessionHandle = A handle to an existing Restart Manager session.
///Returns:
///    This is the most recent error received. The function can return one of the system error codes that are defined in
///    Winerror.h. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The function completed successfully. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SEM_TIMEOUT</b></dt> <dt>121</dt> </dl> </td> <td width="60%"> A
///    Restart Manager function could not obtain a Registry write mutex in the allotted time. A system restart is
///    recommended because further use of the Restart Manager is likely to fail. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_WRITE_FAULT</b></dt> <dt>29</dt> </dl> </td> <td width="60%"> An operation was unable to read or
///    write to the registry. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_OUTOFMEMORY</b></dt> <dt>14</dt> </dl>
///    </td> <td width="60%"> A Restart Manager operation could not complete because not enough memory was available.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> <dt>6</dt> </dl> </td> <td
///    width="60%"> An invalid handle was passed to the function. No Restart Manager session exists for the handle
///    supplied. </td> </tr> </table>
///    
@DllImport("rstrtmgr")
uint RmEndSession(uint dwSessionHandle);

///Registers resources to a Restart Manager session. The Restart Manager uses the list of resources registered with the
///session to determine which applications and services must be shut down and restarted. Resources can be identified by
///filenames, service short names, or RM_UNIQUE_PROCESS structures that describe running applications. The
///<b>RmRegisterResources</b> function can be used by a primary or secondary installer.
///Params:
///    dwSessionHandle = A handle to an existing Restart Manager session.
///    nFiles = The number of files being registered.
///    rgsFileNames = An array of <b>null</b>-terminated strings of full filename paths. This parameter can be <b>NULL</b> if
///                   <i>nFiles</i> is 0.
///    nApplications = The number of processes being registered.
///    rgApplications = An array of RM_UNIQUE_PROCESS structures. This parameter can be <b>NULL</b> if <i>nApplications</i> is 0.
///    nServices = The number of services to be registered.
///    rgsServiceNames = An array of <b>null</b>-terminated strings of service short names. This parameter can be <b>NULL</b> if
///                      <i>nServices</i> is 0.
///Returns:
///    This is the most recent error received. The function can return one of the system error codes that are defined in
///    Winerror.h. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The resources specified have been
///    registered. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SEM_TIMEOUT</b></dt> <dt>121</dt> </dl> </td> <td
///    width="60%"> A Restart Manager function could not obtain a Registry write mutex in the allotted time. A system
///    restart is recommended because further use of the Restart Manager is likely to fail. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_BAD_ARGUMENTS</b></dt> <dt>160</dt> </dl> </td> <td width="60%"> One or more
///    arguments are not correct. This error value is returned by Restart Manager function if a <b>NULL</b> pointer or 0
///    is passed in a parameter that requires a non-<b>null</b> and non-zero value. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_WRITE_FAULT</b></dt> <dt>29</dt> </dl> </td> <td width="60%"> An operation was unable to read
///    or write to the registry. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_OUTOFMEMORY</b></dt> <dt>14</dt>
///    </dl> </td> <td width="60%"> A Restart Manager operation could not complete because not enough memory was
///    available. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> <dt>6</dt> </dl> </td> <td
///    width="60%"> No Restart Manager session exists for the handle supplied. </td> </tr> </table>
///    
@DllImport("rstrtmgr")
uint RmRegisterResources(uint dwSessionHandle, uint nFiles, char* rgsFileNames, uint nApplications, 
                         char* rgApplications, uint nServices, char* rgsServiceNames);

///Gets a list of all applications and services that are currently using resources that have been registered with the
///Restart Manager session.
///Params:
///    dwSessionHandle = A handle to an existing Restart Manager session.
///    pnProcInfoNeeded = A pointer to an array size necessary to receive RM_PROCESS_INFO structures required to return information for all
///                       affected applications and services.
///    pnProcInfo = A pointer to the total number of RM_PROCESS_INFO structures in an array and number of structures filled.
///    rgAffectedApps = An array of RM_PROCESS_INFO structures that list the applications and services using resources that have been
///                     registered with the session.
///    lpdwRebootReasons = Pointer to location that receives a value of the RM_REBOOT_REASON enumeration that describes the reason a system
///                        restart is needed.
///Returns:
///    This is the most recent error received. The function can return one of the system error codes that are defined in
///    Winerror.h. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The function completed successfully. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> <dt>234</dt> </dl> </td> <td width="60%"> This
///    error value is returned by the RmGetList function if the <i>rgAffectedApps</i> buffer is too small to hold all
///    application information in the list. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANCELLED</b></dt>
///    <dt>1223</dt> </dl> </td> <td width="60%"> The current operation is canceled by user. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_SEM_TIMEOUT</b></dt> <dt>121</dt> </dl> </td> <td width="60%"> A Restart Manager
///    function could not obtain a Registry write mutex in the allotted time. A system restart is recommended because
///    further use of the Restart Manager is likely to fail. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BAD_ARGUMENTS</b></dt> <dt>160</dt> </dl> </td> <td width="60%"> One or more arguments are not
///    correct. This error value is returned by the Restart Manager function if a <b>NULL</b> pointer or 0 is passed in
///    a parameter that requires a non-<b>null</b> and non-zero value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_WRITE_FAULT</b></dt> <dt>29</dt> </dl> </td> <td width="60%"> An operation was unable to read or
///    write to the registry. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_OUTOFMEMORY</b></dt> <dt>14</dt> </dl>
///    </td> <td width="60%"> A Restart Manager operation could not complete because not enough memory was available.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> <dt>6</dt> </dl> </td> <td
///    width="60%"> No Restart Manager session exists for the handle supplied. </td> </tr> </table>
///    
@DllImport("rstrtmgr")
uint RmGetList(uint dwSessionHandle, uint* pnProcInfoNeeded, uint* pnProcInfo, char* rgAffectedApps, 
               uint* lpdwRebootReasons);

///Initiates the shutdown of applications. This function can only be called from the installer that started the Restart
///Manager session using the RmStartSession function.
///Params:
///    dwSessionHandle = A handle to an existing Restart Manager session.
///    lActionFlags = One or more RM_SHUTDOWN_TYPE options that configure the shut down of components. The following values can be
///                   combined by an OR operator to specify that unresponsive applications and services are to be forced to shut down
///                   if, and only if, all applications have been registered for restart. <table> <tr> <th>Value</th> <th>Meaning</th>
///                   </tr> <tr> <td width="40%"><a id="RmForceShutdown"></a><a id="rmforceshutdown"></a><a
///                   id="RMFORCESHUTDOWN"></a><dl> <dt><b>RmForceShutdown</b></dt> <dt>0x1</dt> </dl> </td> <td width="60%"> Force
///                   unresponsive applications and services to shut down after the timeout period. An application that does not
///                   respond to a shutdown request is forced to shut down within 30 seconds. A service that does not respond to a
///                   shutdown request is forced to shut down after 20 seconds. </td> </tr> <tr> <td width="40%"><a
///                   id="RmShutdownOnlyRegistered"></a><a id="rmshutdownonlyregistered"></a><a id="RMSHUTDOWNONLYREGISTERED"></a><dl>
///                   <dt><b>RmShutdownOnlyRegistered</b></dt> <dt>0x10</dt> </dl> </td> <td width="60%"> Shut down applications if and
///                   only if all the applications have been registered for restart using the RegisterApplicationRestart function. If
///                   any processes or services cannot be restarted, then no processes or services are shut down. </td> </tr> </table>
///    fnStatus = A pointer to an RM_WRITE_STATUS_CALLBACK function that is used to communicate detailed status while this function
///               is executing. If <b>NULL</b>, no status is provided.
///Returns:
///    This is the most recent error received. The function can return one of the system error codes that are defined in
///    Winerror.h. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> All shutdown, restart, and callback
///    operations were successfully completed. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FAIL_NOACTION_REBOOT</b></dt> <dt>350</dt> </dl> </td> <td width="60%"> No shutdown actions were
///    performed. One or more processes or services require a restart of the system to be shut down. This error code is
///    returned when the Restart Manager detects that a restart of the system is required before shutting down any
///    application. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FAIL_SHUTDOWN</b></dt> <dt>351</dt> </dl> </td>
///    <td width="60%"> Some applications could not be shut down. The <b>AppStatus</b> of the RM_PROCESS_INFO structures
///    returned by the RmGetList function contain updated status information. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANCELLED</b></dt> <dt>1223</dt> </dl> </td> <td width="60%"> This error value is returned by the
///    RmShutdown function when the request to cancel an operation is successful. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SEM_TIMEOUT</b></dt> <dt>121</dt> </dl> </td> <td width="60%"> A Restart Manager function could not
///    obtain a Registry write mutex in the allotted time. A system restart is recommended because further use of the
///    Restart Manager is likely to fail. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_ARGUMENTS</b></dt>
///    <dt>160</dt> </dl> </td> <td width="60%"> One or more arguments are not correct. This error value is returned by
///    the Restart Manager function if a <b>NULL</b> pointer or 0 is passed in a parameter that requires a
///    non-<b>null</b> and non-zero value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_WRITE_FAULT</b></dt>
///    <dt>29</dt> </dl> </td> <td width="60%"> An operation was unable to read or write to the registry. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_OUTOFMEMORY</b></dt> <dt>14</dt> </dl> </td> <td width="60%"> A Restart
///    Manager operation could not be completed because not enough memory is available. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> <dt>6</dt> </dl> </td> <td width="60%"> No Restart Manager
///    session exists for the handle supplied. </td> </tr> </table>
///    
@DllImport("rstrtmgr")
uint RmShutdown(uint dwSessionHandle, uint lActionFlags, RM_WRITE_STATUS_CALLBACK fnStatus);

///Restarts applications and services that have been shut down by the RmShutdown function and that have been registered
///to be restarted using the RegisterApplicationRestart function. This function can only be called by the primary
///installer that called the RmStartSession function to start the Restart Manager session.
///Params:
///    dwSessionHandle = A handle to the existing Restart Manager session.
///    dwRestartFlags = Reserved. This parameter should be 0.
///    fnStatus = A pointer to a status message callback function that is used to communicate status while the <b>RmRestart</b>
///               function is running. If <b>NULL</b>, no status is provided.
///Returns:
///    This is the most recent error received. The function can return one of the system error codes that are defined in
///    Winerror.h. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_REQUEST_OUT_OF_SEQUENCE</b></dt> <dt>776</dt> </dl> </td> <td width="60%"> This error value is
///    returned if the RmRestart function is called with a valid session handle before calling the RmShutdown function.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FAIL_RESTART</b></dt> <dt>352</dt> </dl> </td> <td
///    width="60%"> One or more applications could not be restarted. The RM_PROCESS_INFO structures that are returned by
///    the RmGetList function contain updated status information. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SEM_TIMEOUT</b></dt> <dt>121</dt> </dl> </td> <td width="60%"> A Restart Manager function could not
///    obtain a registry write mutex in the allotted time. A system restart is recommended because further use of the
///    Restart Manager is likely to fail. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_CANCELLED</b></dt>
///    <dt>1223</dt> </dl> </td> <td width="60%"> This error value is returned by the RmRestart function when the
///    request to cancel an operation is successful. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BAD_ARGUMENTS</b></dt> <dt>160</dt> </dl> </td> <td width="60%"> One or more arguments are not
///    correct. This error value is returned by the Restart Manager function if a <b>NULL</b> pointer or 0 is passed in
///    a parameter that requires a non-<b>null</b> and non-zero value. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_WRITE_FAULT</b></dt> <dt>29</dt> </dl> </td> <td width="60%"> An operation was unable to read or
///    write to the registry. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_OUTOFMEMORY</b></dt> <dt>14</dt> </dl>
///    </td> <td width="60%"> A Restart Manager operation could not complete because not enough memory was available.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> <dt>6</dt> </dl> </td> <td
///    width="60%"> No Restart Manager session exists for the handle supplied. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The function succeeds and returns. </td>
///    </tr> </table>
///    
@DllImport("rstrtmgr")
uint RmRestart(uint dwSessionHandle, uint dwRestartFlags, RM_WRITE_STATUS_CALLBACK fnStatus);

///Cancels the current RmShutdown or RmRestart operation. This function must be called from the application that has
///started the session by calling the RmStartSession function.
///Params:
///    dwSessionHandle = A handle to an existing session.
///Returns:
///    This is the most recent error received. The function can return one of the system error codes that are defined in
///    Winerror.h. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> A cancellation of the current operation is
///    requested. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_ARGUMENTS</b></dt> <dt>160</dt> </dl> </td>
///    <td width="60%"> One or more arguments are not correct. This error value is returned by the Restart Manager
///    function if a <b>NULL</b> pointer or 0 is passed in a parameter that requires a non-<b>null</b> and non-zero
///    value. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_OUTOFMEMORY</b></dt> <dt>14</dt> </dl> </td> <td
///    width="60%"> A Restart Manager operation could not complete because not enough memory was available. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> <dt>6</dt> </dl> </td> <td width="60%"> No
///    Restart Manager session exists for the handle supplied. </td> </tr> </table>
///    
@DllImport("RstrtMgr")
uint RmCancelCurrentTask(uint dwSessionHandle);

///Modifies the shutdown or restart actions that are applied to an application or service. The primary installer can
///call the <b>RmAddFilter</b> function multiple times. The most recent call overrides any previous modifications to the
///same file, process, or service.
///Params:
///    dwSessionHandle = A handle to an existing Restart Manager session.
///    strModuleName = A pointer to a <b>null</b>-terminated string value that contains the full path to the application's executable
///                    file. Modifications to shutdown or restart actions are applied for the application that is referenced by the full
///                    path. This parameter must be <b>NULL</b> if the <i>Application</i> or <i>strServiceShortName</i> parameter is
///                    non-<b>NULL</b>.
///    pProcess = A pointer to a RM_UNIQUE_PROCESS structure for the application. Modifications to shutdown or restart actions are
///               applied for the application that is referenced by the <b>RM_UNIQUE_PROCESS</b> structure. This parameter must be
///               <b>NULL</b> if the <i>strFilename</i> or <i>strShortServiceName</i> parameter is non-<b>NULL</b>.
///    strServiceShortName = A pointer to a <b>null</b>-terminated string value that contains the short service name. Modifications to
///                          shutdown or restart actions are applied for the service that is referenced by short service filename. This
///                          parameter must be <b>NULL</b> if the <i>strFilename</i> or <i>Application</i> parameter is non-<b>NULL</b>.
///    FilterAction = An RM_FILTER_ACTION enumeration value that specifies the type of modification to be applied.
///Returns:
///    This is the most recent error received. The function can return one of the system error codes that are defined in
///    Winerror.h. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The function completed successfully. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_ARGUMENTS</b></dt> <dt>160</dt> </dl> </td> <td width="60%">
///    One or more arguments are not correct. This error value is returned by the Restart Manager function if a
///    <b>NULL</b> pointer or 0 is passed in as a parameter that requires a non-<b>null</b> and non-zero value. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SESSION_CREDENTIAL_CONFLICT</b></dt> <dt> 1219</dt> </dl> </td> <td
///    width="60%"> This error is returned when a secondary installer calls this function. This function is only
///    available to primary installers. </td> </tr> </table>
///    
@DllImport("RstrtMgr")
uint RmAddFilter(uint dwSessionHandle, const(wchar)* strModuleName, RM_UNIQUE_PROCESS* pProcess, 
                 const(wchar)* strServiceShortName, RM_FILTER_ACTION FilterAction);

///Removes any modifications to shutdown or restart actions that have been applied using the RmAddFilter function. The
///primary installer can call the <b>RmRemoveFilter</b> function multiple times.
///Params:
///    dwSessionHandle = A handle to an existing Restart Manager session.
///    strModuleName = A pointer to a <b>null</b>-terminated string value that contains the full path for the application's executable
///                    file. The <b>RmRemoveFilter</b> function removes any modifications to the referenced application's shutdown or
///                    restart actions previously applied by the RmAddFilter function. This parameter must be <b>NULL</b> if the
///                    <i>Application</i> or <i>strServiceShortName</i> parameter is non-<b>NULL</b>.
///    pProcess = The RM_UNIQUE_PROCESS structure for the application. The <b>RmRemoveFilter</b> function removes any modifications
///               to the referenced application's shutdown or restart actions previously applied by the RmAddFilter function. This
///               parameter must be <b>NULL</b> if the <i>strFilename</i> or <i>strShortServiceName</i> parameter is
///               non-<b>NULL</b>.
///    strServiceShortName = A pointer to a <b>null</b>-terminated string value that contains the short service name. The
///                          <b>RmRemoveFilter</b> function removes any modifications to the referenced service's shutdown or restart actions
///                          previously applied by the RmAddFilter function. This parameter must be <b>NULL</b> if the <i>strFilename</i> or
///                          <i>Application</i> parameter is non-<b>NULL</b>.
@DllImport("RstrtMgr")
uint RmRemoveFilter(uint dwSessionHandle, const(wchar)* strModuleName, RM_UNIQUE_PROCESS* pProcess, 
                    const(wchar)* strServiceShortName);

///Lists the modifications to shutdown and restart actions that have already been applied by the RmAddFilter function.
///The function returns a pointer to a buffer containing information about the modifications which have been applied.
///Params:
///    dwSessionHandle = A handle to an existing Restart Manager session.
///    pbFilterBuf = A pointer to a buffer that contains modification information.
///    cbFilterBuf = The size of the buffer that contains modification information in bytes.
///    cbFilterBufNeeded = The number of bytes needed in the buffer.
///Returns:
///    This is the most recent error received. The function can return one of the system error codes that are defined in
///    Winerror.h. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The function completed successfully. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_ARGUMENTS</b></dt> <dt>160</dt> </dl> </td> <td width="60%">
///    One or more arguments are not correct. This error value is returned by the Restart Manager function if a
///    <b>NULL</b> pointer or 0 is passed in as a parameter that requires a non-<b>null</b> and non-zero value. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> <dt>234</dt> </dl> </td> <td width="60%"> This
///    error value is returned by the RmGetFilterList function if the <i>pbFilterBuf</i> buffer is too small to hold all
///    the application information in the list or if <i>cbFilterBufNeeded</i> was not specified. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_SESSION_CREDENTIAL_CONFLICT</b></dt> <dt> 1219</dt> </dl> </td> <td width="60%">
///    This error is returned when a secondary installer calls this function. This function is only available to primary
///    installers. </td> </tr> </table>
///    
@DllImport("RstrtMgr")
uint RmGetFilterList(uint dwSessionHandle, char* pbFilterBuf, uint cbFilterBuf, uint* cbFilterBufNeeded);


