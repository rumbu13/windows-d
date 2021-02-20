// Written in the D programming language.

module windows.services;

public import windows.core;
public import windows.security : SC_HANDLE__;
public import windows.systemservices : BOOL, PSTR, PWSTR;

extern(Windows) @nogc nothrow:


// Functions

///Changes the configuration parameters of a service. To change the optional configuration parameters, use the
///ChangeServiceConfig2 function.
///Params:
///    hService = A handle to the service. This handle is returned by the OpenService or CreateService function and must have the
///               <b>SERVICE_CHANGE_CONFIG</b> access right. For more information, see Service Security and Access Rights.
///    dwServiceType = The type of service. Specify <b>SERVICE_NO_CHANGE</b> if you are not changing the existing service type;
///                    otherwise, specify one of the following service types. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///                    <td width="40%"><a id="SERVICE_FILE_SYSTEM_DRIVER"></a><a id="service_file_system_driver"></a><dl>
///                    <dt><b>SERVICE_FILE_SYSTEM_DRIVER</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> File system driver
///                    service. </td> </tr> <tr> <td width="40%"><a id="SERVICE_KERNEL_DRIVER"></a><a
///                    id="service_kernel_driver"></a><dl> <dt><b>SERVICE_KERNEL_DRIVER</b></dt> <dt>0x00000001</dt> </dl> </td> <td
///                    width="60%"> Driver service. </td> </tr> <tr> <td width="40%"><a id="SERVICE_WIN32_OWN_PROCESS"></a><a
///                    id="service_win32_own_process"></a><dl> <dt><b>SERVICE_WIN32_OWN_PROCESS</b></dt> <dt>0x00000010</dt> </dl> </td>
///                    <td width="60%"> Service that runs in its own process. </td> </tr> <tr> <td width="40%"><a
///                    id="SERVICE_WIN32_SHARE_PROCESS"></a><a id="service_win32_share_process"></a><dl>
///                    <dt><b>SERVICE_WIN32_SHARE_PROCESS</b></dt> <dt>0x00000020</dt> </dl> </td> <td width="60%"> Service that shares
///                    a process with other services. </td> </tr> </table> If you specify either <b>SERVICE_WIN32_OWN_PROCESS</b> or
///                    <b>SERVICE_WIN32_SHARE_PROCESS</b>, and the service is running in the context of the LocalSystem account, you can
///                    also specify the following type. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                    id="SERVICE_INTERACTIVE_PROCESS"></a><a id="service_interactive_process"></a><dl>
///                    <dt><b>SERVICE_INTERACTIVE_PROCESS</b></dt> <dt>0x00000100</dt> </dl> </td> <td width="60%"> The service can
///                    interact with the desktop. For more information, see Interactive Services. </td> </tr> </table>
///    dwStartType = The service start options. Specify <b>SERVICE_NO_CHANGE</b> if you are not changing the existing start type;
///                  otherwise, specify one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                  width="40%"><a id="SERVICE_AUTO_START"></a><a id="service_auto_start"></a><dl> <dt><b>SERVICE_AUTO_START</b></dt>
///                  <dt>0x00000002</dt> </dl> </td> <td width="60%"> A service started automatically by the service control manager
///                  during system startup. </td> </tr> <tr> <td width="40%"><a id="SERVICE_BOOT_START"></a><a
///                  id="service_boot_start"></a><dl> <dt><b>SERVICE_BOOT_START</b></dt> <dt>0x00000000</dt> </dl> </td> <td
///                  width="60%"> A device driver started by the system loader. This value is valid only for driver services. </td>
///                  </tr> <tr> <td width="40%"><a id="SERVICE_DEMAND_START"></a><a id="service_demand_start"></a><dl>
///                  <dt><b>SERVICE_DEMAND_START</b></dt> <dt>0x00000003</dt> </dl> </td> <td width="60%"> A service started by the
///                  service control manager when a process calls the StartService function. </td> </tr> <tr> <td width="40%"><a
///                  id="SERVICE_DISABLED"></a><a id="service_disabled"></a><dl> <dt><b>SERVICE_DISABLED</b></dt> <dt>0x00000004</dt>
///                  </dl> </td> <td width="60%"> A service that cannot be started. Attempts to start the service result in the error
///                  code <b>ERROR_SERVICE_DISABLED</b>. </td> </tr> <tr> <td width="40%"><a id="SERVICE_SYSTEM_START"></a><a
///                  id="service_system_start"></a><dl> <dt><b>SERVICE_SYSTEM_START</b></dt> <dt>0x00000001</dt> </dl> </td> <td
///                  width="60%"> A device driver started by the <b>IoInitSystem</b> function. This value is valid only for driver
///                  services. </td> </tr> </table>
///    dwErrorControl = The severity of the error, and action taken, if this service fails to start. Specify <b>SERVICE_NO_CHANGE</b> if
///                     you are not changing the existing error control; otherwise, specify one of the following values. <table> <tr>
///                     <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SERVICE_ERROR_CRITICAL"></a><a
///                     id="service_error_critical"></a><dl> <dt><b>SERVICE_ERROR_CRITICAL</b></dt> <dt>0x00000003</dt> </dl> </td> <td
///                     width="60%"> The startup program logs the error in the event log, if possible. If the last-known-good
///                     configuration is being started, the startup operation fails. Otherwise, the system is restarted with the
///                     last-known good configuration. </td> </tr> <tr> <td width="40%"><a id="SERVICE_ERROR_IGNORE"></a><a
///                     id="service_error_ignore"></a><dl> <dt><b>SERVICE_ERROR_IGNORE</b></dt> <dt>0x00000000</dt> </dl> </td> <td
///                     width="60%"> The startup program ignores the error and continues the startup operation. </td> </tr> <tr> <td
///                     width="40%"><a id="SERVICE_ERROR_NORMAL"></a><a id="service_error_normal"></a><dl>
///                     <dt><b>SERVICE_ERROR_NORMAL</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> The startup program logs
///                     the error in the event log but continues the startup operation. </td> </tr> <tr> <td width="40%"><a
///                     id="SERVICE_ERROR_SEVERE"></a><a id="service_error_severe"></a><dl> <dt><b>SERVICE_ERROR_SEVERE</b></dt>
///                     <dt>0x00000002</dt> </dl> </td> <td width="60%"> The startup program logs the error in the event log. If the
///                     last-known-good configuration is being started, the startup operation continues. Otherwise, the system is
///                     restarted with the last-known-good configuration. </td> </tr> </table>
///    lpBinaryPathName = The fully qualified path to the service binary file. Specify NULL if you are not changing the existing path. If
///                       the path contains a space, it must be quoted so that it is correctly interpreted. For example, "d:\\my
///                       share\\myservice.exe" should be specified as "\"d:\\my share\\myservice.exe\"". The path can also include
///                       arguments for an auto-start service. For example, "d:\\myshare\\myservice.exe arg1 arg2". These arguments are
///                       passed to the service entry point (typically the <b>main</b> function). If you specify a path on another
///                       computer, the share must be accessible by the computer account of the local computer because this is the security
///                       context used in the remote call. However, this requirement allows any potential vulnerabilities in the remote
///                       computer to affect the local computer. Therefore, it is best to use a local file.
///    lpLoadOrderGroup = The name of the load ordering group of which this service is a member. Specify NULL if you are not changing the
///                       existing group. Specify an empty string if the service does not belong to a group. The startup program uses load
///                       ordering groups to load groups of services in a specified order with respect to the other groups. The list of
///                       load ordering groups is contained in the <b>ServiceGroupOrder</b> value of the following registry key:
///                       <b>HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control</b>
///    lpdwTagId = A pointer to a variable that receives a tag value that is unique in the group specified in the
///                <i>lpLoadOrderGroup</i> parameter. Specify NULL if you are not changing the existing tag. You can use a tag for
///                ordering service startup within a load ordering group by specifying a tag order vector in the
///                <b>GroupOrderList</b> value of the following registry key:
///                <b>HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control</b> Tags are only evaluated for driver services that have
///                <b>SERVICE_BOOT_START</b> or <b>SERVICE_SYSTEM_START</b> start types.
///    lpDependencies = A pointer to a double null-terminated array of null-separated names of services or load ordering groups that the
///                     system must start before this service can be started. (Dependency on a group means that this service can run if
///                     at least one member of the group is running after an attempt to start all members of the group.) Specify NULL if
///                     you are not changing the existing dependencies. Specify an empty string if the service has no dependencies. You
///                     must prefix group names with SC_GROUP_IDENTIFIER so that they can be distinguished from a service name, because
///                     services and service groups share the same name space.
///    lpServiceStartName = The name of the account under which the service should run. Specify <b>NULL</b> if you are not changing the
///                         existing account name. If the service type is <b>SERVICE_WIN32_OWN_PROCESS</b>, use an account name in the form
///                         <i>DomainName</i>&
///    lpPassword = The password to the account name specified by the <i>lpServiceStartName</i> parameter. Specify <b>NULL</b> if you
///                 are not changing the existing password. Specify an empty string if the account has no password or if the service
///                 runs in the LocalService, NetworkService, or LocalSystem account. For more information, see Service Record List.
///                 If the account name specified by the <i>lpServiceStartName</i> parameter is the name of a managed service account
///                 or virtual account name, the <i>lpPassword</i> parameter must be <b>NULL</b>. Passwords are ignored for driver
///                 services.
///    lpDisplayName = The display name to be used by applications to identify the service for its users. Specify <b>NULL</b> if you are
///                    not changing the existing display name; otherwise, this string has a maximum length of 256 characters. The name
///                    is case-preserved in the service control manager. Display name comparisons are always case-insensitive. This
///                    parameter can specify a localized string using the following format: @[<i>path</i>\]<i>dllname</i>,-<i>strID</i>
///                    The string with identifier <i>strID</i> is loaded from <i>dllname</i>; the <i>path</i> is optional. For more
///                    information, see RegLoadMUIString. <b>Windows Server 2003 and Windows XP: </b>Localized strings are not supported
///                    until Windows Vista.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError. The following error codes may be set by the service control
///    manager. Other error codes may be set by the registry functions that are called by the service control manager.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The handle does not have the
///    <b>SERVICE_CHANGE_CONFIG</b> access right. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CIRCULAR_DEPENDENCY</b></dt> </dl> </td> <td width="60%"> A circular service dependency was
///    specified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DUPLICATE_SERVICE_NAME</b></dt> </dl> </td> <td
///    width="60%"> The display name already exists in the service controller manager database, either as a service name
///    or as another display name. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl>
///    </td> <td width="60%"> The specified handle is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter that was specified is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_SERVICE_ACCOUNT</b></dt> </dl> </td> <td width="60%">
///    The account name does not exist, or a service is specified to share the same binary file as an already installed
///    service but with an account name that is not the same as the installed service. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_SERVICE_MARKED_FOR_DELETE</b></dt> </dl> </td> <td width="60%"> The service has been marked for
///    deletion. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
BOOL ChangeServiceConfigA(SC_HANDLE__* hService, uint dwServiceType, uint dwStartType, uint dwErrorControl, 
                          const(PSTR) lpBinaryPathName, const(PSTR) lpLoadOrderGroup, uint* lpdwTagId, 
                          const(PSTR) lpDependencies, const(PSTR) lpServiceStartName, const(PSTR) lpPassword, 
                          const(PSTR) lpDisplayName);

///Changes the configuration parameters of a service. To change the optional configuration parameters, use the
///ChangeServiceConfig2 function.
///Params:
///    hService = A handle to the service. This handle is returned by the OpenService or CreateService function and must have the
///               <b>SERVICE_CHANGE_CONFIG</b> access right. For more information, see Service Security and Access Rights.
///    dwServiceType = The type of service. Specify <b>SERVICE_NO_CHANGE</b> if you are not changing the existing service type;
///                    otherwise, specify one of the following service types. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///                    <td width="40%"><a id="SERVICE_FILE_SYSTEM_DRIVER"></a><a id="service_file_system_driver"></a><dl>
///                    <dt><b>SERVICE_FILE_SYSTEM_DRIVER</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> File system driver
///                    service. </td> </tr> <tr> <td width="40%"><a id="SERVICE_KERNEL_DRIVER"></a><a
///                    id="service_kernel_driver"></a><dl> <dt><b>SERVICE_KERNEL_DRIVER</b></dt> <dt>0x00000001</dt> </dl> </td> <td
///                    width="60%"> Driver service. </td> </tr> <tr> <td width="40%"><a id="SERVICE_WIN32_OWN_PROCESS"></a><a
///                    id="service_win32_own_process"></a><dl> <dt><b>SERVICE_WIN32_OWN_PROCESS</b></dt> <dt>0x00000010</dt> </dl> </td>
///                    <td width="60%"> Service that runs in its own process. </td> </tr> <tr> <td width="40%"><a
///                    id="SERVICE_WIN32_SHARE_PROCESS"></a><a id="service_win32_share_process"></a><dl>
///                    <dt><b>SERVICE_WIN32_SHARE_PROCESS</b></dt> <dt>0x00000020</dt> </dl> </td> <td width="60%"> Service that shares
///                    a process with other services. </td> </tr> </table> If you specify either <b>SERVICE_WIN32_OWN_PROCESS</b> or
///                    <b>SERVICE_WIN32_SHARE_PROCESS</b>, and the service is running in the context of the LocalSystem account, you can
///                    also specify the following type. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                    id="SERVICE_INTERACTIVE_PROCESS"></a><a id="service_interactive_process"></a><dl>
///                    <dt><b>SERVICE_INTERACTIVE_PROCESS</b></dt> <dt>0x00000100</dt> </dl> </td> <td width="60%"> The service can
///                    interact with the desktop. For more information, see Interactive Services. </td> </tr> </table>
///    dwStartType = The service start options. Specify <b>SERVICE_NO_CHANGE</b> if you are not changing the existing start type;
///                  otherwise, specify one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                  width="40%"><a id="SERVICE_AUTO_START"></a><a id="service_auto_start"></a><dl> <dt><b>SERVICE_AUTO_START</b></dt>
///                  <dt>0x00000002</dt> </dl> </td> <td width="60%"> A service started automatically by the service control manager
///                  during system startup. </td> </tr> <tr> <td width="40%"><a id="SERVICE_BOOT_START"></a><a
///                  id="service_boot_start"></a><dl> <dt><b>SERVICE_BOOT_START</b></dt> <dt>0x00000000</dt> </dl> </td> <td
///                  width="60%"> A device driver started by the system loader. This value is valid only for driver services. </td>
///                  </tr> <tr> <td width="40%"><a id="SERVICE_DEMAND_START"></a><a id="service_demand_start"></a><dl>
///                  <dt><b>SERVICE_DEMAND_START</b></dt> <dt>0x00000003</dt> </dl> </td> <td width="60%"> A service started by the
///                  service control manager when a process calls the StartService function. </td> </tr> <tr> <td width="40%"><a
///                  id="SERVICE_DISABLED"></a><a id="service_disabled"></a><dl> <dt><b>SERVICE_DISABLED</b></dt> <dt>0x00000004</dt>
///                  </dl> </td> <td width="60%"> A service that cannot be started. Attempts to start the service result in the error
///                  code <b>ERROR_SERVICE_DISABLED</b>. </td> </tr> <tr> <td width="40%"><a id="SERVICE_SYSTEM_START"></a><a
///                  id="service_system_start"></a><dl> <dt><b>SERVICE_SYSTEM_START</b></dt> <dt>0x00000001</dt> </dl> </td> <td
///                  width="60%"> A device driver started by the <b>IoInitSystem</b> function. This value is valid only for driver
///                  services. </td> </tr> </table>
///    dwErrorControl = The severity of the error, and action taken, if this service fails to start. Specify <b>SERVICE_NO_CHANGE</b> if
///                     you are not changing the existing error control; otherwise, specify one of the following values. <table> <tr>
///                     <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SERVICE_ERROR_CRITICAL"></a><a
///                     id="service_error_critical"></a><dl> <dt><b>SERVICE_ERROR_CRITICAL</b></dt> <dt>0x00000003</dt> </dl> </td> <td
///                     width="60%"> The startup program logs the error in the event log, if possible. If the last-known-good
///                     configuration is being started, the startup operation fails. Otherwise, the system is restarted with the
///                     last-known good configuration. </td> </tr> <tr> <td width="40%"><a id="SERVICE_ERROR_IGNORE"></a><a
///                     id="service_error_ignore"></a><dl> <dt><b>SERVICE_ERROR_IGNORE</b></dt> <dt>0x00000000</dt> </dl> </td> <td
///                     width="60%"> The startup program ignores the error and continues the startup operation. </td> </tr> <tr> <td
///                     width="40%"><a id="SERVICE_ERROR_NORMAL"></a><a id="service_error_normal"></a><dl>
///                     <dt><b>SERVICE_ERROR_NORMAL</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> The startup program logs
///                     the error in the event log but continues the startup operation. </td> </tr> <tr> <td width="40%"><a
///                     id="SERVICE_ERROR_SEVERE"></a><a id="service_error_severe"></a><dl> <dt><b>SERVICE_ERROR_SEVERE</b></dt>
///                     <dt>0x00000002</dt> </dl> </td> <td width="60%"> The startup program logs the error in the event log. If the
///                     last-known-good configuration is being started, the startup operation continues. Otherwise, the system is
///                     restarted with the last-known-good configuration. </td> </tr> </table>
///    lpBinaryPathName = The fully qualified path to the service binary file. Specify NULL if you are not changing the existing path. If
///                       the path contains a space, it must be quoted so that it is correctly interpreted. For example, "d:\\my
///                       share\\myservice.exe" should be specified as "\"d:\\my share\\myservice.exe\"". The path can also include
///                       arguments for an auto-start service. For example, "d:\\myshare\\myservice.exe arg1 arg2". These arguments are
///                       passed to the service entry point (typically the <b>main</b> function). If you specify a path on another
///                       computer, the share must be accessible by the computer account of the local computer because this is the security
///                       context used in the remote call. However, this requirement allows any potential vulnerabilities in the remote
///                       computer to affect the local computer. Therefore, it is best to use a local file.
///    lpLoadOrderGroup = The name of the load ordering group of which this service is a member. Specify NULL if you are not changing the
///                       existing group. Specify an empty string if the service does not belong to a group. The startup program uses load
///                       ordering groups to load groups of services in a specified order with respect to the other groups. The list of
///                       load ordering groups is contained in the <b>ServiceGroupOrder</b> value of the following registry key:
///                       <b>HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control</b>
///    lpdwTagId = A pointer to a variable that receives a tag value that is unique in the group specified in the
///                <i>lpLoadOrderGroup</i> parameter. Specify NULL if you are not changing the existing tag. You can use a tag for
///                ordering service startup within a load ordering group by specifying a tag order vector in the
///                <b>GroupOrderList</b> value of the following registry key:
///                <b>HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control</b> Tags are only evaluated for driver services that have
///                <b>SERVICE_BOOT_START</b> or <b>SERVICE_SYSTEM_START</b> start types.
///    lpDependencies = A pointer to a double null-terminated array of null-separated names of services or load ordering groups that the
///                     system must start before this service can be started. (Dependency on a group means that this service can run if
///                     at least one member of the group is running after an attempt to start all members of the group.) Specify NULL if
///                     you are not changing the existing dependencies. Specify an empty string if the service has no dependencies. You
///                     must prefix group names with SC_GROUP_IDENTIFIER so that they can be distinguished from a service name, because
///                     services and service groups share the same name space.
///    lpServiceStartName = The name of the account under which the service should run. Specify <b>NULL</b> if you are not changing the
///                         existing account name. If the service type is <b>SERVICE_WIN32_OWN_PROCESS</b>, use an account name in the form
///                         <i>DomainName</i>&
///    lpPassword = The password to the account name specified by the <i>lpServiceStartName</i> parameter. Specify <b>NULL</b> if you
///                 are not changing the existing password. Specify an empty string if the account has no password or if the service
///                 runs in the LocalService, NetworkService, or LocalSystem account. For more information, see Service Record List.
///                 If the account name specified by the <i>lpServiceStartName</i> parameter is the name of a managed service account
///                 or virtual account name, the <i>lpPassword</i> parameter must be <b>NULL</b>. Passwords are ignored for driver
///                 services.
///    lpDisplayName = The display name to be used by applications to identify the service for its users. Specify <b>NULL</b> if you are
///                    not changing the existing display name; otherwise, this string has a maximum length of 256 characters. The name
///                    is case-preserved in the service control manager. Display name comparisons are always case-insensitive. This
///                    parameter can specify a localized string using the following format: @[<i>path</i>\]<i>dllname</i>,-<i>strID</i>
///                    The string with identifier <i>strID</i> is loaded from <i>dllname</i>; the <i>path</i> is optional. For more
///                    information, see RegLoadMUIString. <b>Windows Server 2003 and Windows XP: </b>Localized strings are not supported
///                    until Windows Vista.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError. The following error codes may be set by the service control
///    manager. Other error codes may be set by the registry functions that are called by the service control manager.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The handle does not have the
///    <b>SERVICE_CHANGE_CONFIG</b> access right. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CIRCULAR_DEPENDENCY</b></dt> </dl> </td> <td width="60%"> A circular service dependency was
///    specified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DUPLICATE_SERVICE_NAME</b></dt> </dl> </td> <td
///    width="60%"> The display name already exists in the service controller manager database, either as a service name
///    or as another display name. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl>
///    </td> <td width="60%"> The specified handle is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter that was specified is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_SERVICE_ACCOUNT</b></dt> </dl> </td> <td width="60%">
///    The account name does not exist, or a service is specified to share the same binary file as an already installed
///    service but with an account name that is not the same as the installed service. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_SERVICE_MARKED_FOR_DELETE</b></dt> </dl> </td> <td width="60%"> The service has been marked for
///    deletion. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
BOOL ChangeServiceConfigW(SC_HANDLE__* hService, uint dwServiceType, uint dwStartType, uint dwErrorControl, 
                          const(PWSTR) lpBinaryPathName, const(PWSTR) lpLoadOrderGroup, uint* lpdwTagId, 
                          const(PWSTR) lpDependencies, const(PWSTR) lpServiceStartName, const(PWSTR) lpPassword, 
                          const(PWSTR) lpDisplayName);

///Creates a service object and adds it to the specified service control manager database.
///Params:
///    hSCManager = A handle to the service control manager database. This handle is returned by the OpenSCManager function and must
///                 have the <b>SC_MANAGER_CREATE_SERVICE</b> access right. For more information, see Service Security and Access
///                 Rights.
///    lpServiceName = The name of the service to install. The maximum string length is 256 characters. The service control manager
///                    database preserves the case of the characters, but service name comparisons are always case insensitive.
///                    Forward-slash (/) and backslash (\\) are not valid service name characters.
///    lpDisplayName = The display name to be used by user interface programs to identify the service. This string has a maximum length
///                    of 256 characters. The name is case-preserved in the service control manager. Display name comparisons are always
///                    case-insensitive.
///    dwDesiredAccess = The access to the service. Before granting the requested access, the system checks the access token of the
///                      calling process. For a list of values, see Service Security and Access Rights.
///    dwServiceType = The service type. This parameter can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
///                    </tr> <tr> <td width="40%"><a id="SERVICE_ADAPTER"></a><a id="service_adapter"></a><dl>
///                    <dt><b>SERVICE_ADAPTER</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%"> Reserved. </td> </tr> <tr> <td
///                    width="40%"><a id="SERVICE_FILE_SYSTEM_DRIVER"></a><a id="service_file_system_driver"></a><dl>
///                    <dt><b>SERVICE_FILE_SYSTEM_DRIVER</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> File system driver
///                    service. </td> </tr> <tr> <td width="40%"><a id="SERVICE_KERNEL_DRIVER"></a><a
///                    id="service_kernel_driver"></a><dl> <dt><b>SERVICE_KERNEL_DRIVER</b></dt> <dt>0x00000001</dt> </dl> </td> <td
///                    width="60%"> Driver service. </td> </tr> <tr> <td width="40%"><a id="SERVICE_RECOGNIZER_DRIVER"></a><a
///                    id="service_recognizer_driver"></a><dl> <dt><b>SERVICE_RECOGNIZER_DRIVER</b></dt> <dt>0x00000008</dt> </dl> </td>
///                    <td width="60%"> Reserved. </td> </tr> <tr> <td width="40%"><a id="SERVICE_WIN32_OWN_PROCESS"></a><a
///                    id="service_win32_own_process"></a><dl> <dt><b>SERVICE_WIN32_OWN_PROCESS</b></dt> <dt>0x00000010</dt> </dl> </td>
///                    <td width="60%"> Service that runs in its own process. </td> </tr> <tr> <td width="40%"><a
///                    id="SERVICE_WIN32_SHARE_PROCESS"></a><a id="service_win32_share_process"></a><dl>
///                    <dt><b>SERVICE_WIN32_SHARE_PROCESS</b></dt> <dt>0x00000020</dt> </dl> </td> <td width="60%"> Service that shares
///                    a process with one or more other services. For more information, see Service Programs. </td> </tr> <tr> <td
///                    width="40%"><a id="SERVICE_USER_OWN_PROCESS"></a><a id="service_user_own_process"></a><dl>
///                    <dt><b>SERVICE_USER_OWN_PROCESS</b></dt> <dt>0x00000050</dt> </dl> </td> <td width="60%"> The service runs in its
///                    own process under the logged-on user account. </td> </tr> <tr> <td width="40%"><a
///                    id="SERVICE_USER_SHARE_PROCESS"></a><a id="service_user_share_process"></a><dl>
///                    <dt><b>SERVICE_USER_SHARE_PROCESS</b></dt> <dt>0x00000060</dt> </dl> </td> <td width="60%"> The service shares a
///                    process with one or more other services that run under the logged-on user account. </td> </tr> </table> If you
///                    specify either <b>SERVICE_WIN32_OWN_PROCESS</b> or <b>SERVICE_WIN32_SHARE_PROCESS</b>, and the service is running
///                    in the context of the LocalSystem account, you can also specify the following value. <table> <tr> <th>Value</th>
///                    <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SERVICE_INTERACTIVE_PROCESS"></a><a
///                    id="service_interactive_process"></a><dl> <dt><b>SERVICE_INTERACTIVE_PROCESS</b></dt> <dt>0x00000100</dt> </dl>
///                    </td> <td width="60%"> The service can interact with the desktop. For more information, see Interactive Services.
///                    </td> </tr> </table>
///    dwStartType = The service start options. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///                  <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SERVICE_AUTO_START"></a><a id="service_auto_start"></a><dl>
///                  <dt><b>SERVICE_AUTO_START</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> A service started
///                  automatically by the service control manager during system startup. For more information, see Automatically
///                  Starting Services. </td> </tr> <tr> <td width="40%"><a id="SERVICE_BOOT_START"></a><a
///                  id="service_boot_start"></a><dl> <dt><b>SERVICE_BOOT_START</b></dt> <dt>0x00000000</dt> </dl> </td> <td
///                  width="60%"> A device driver started by the system loader. This value is valid only for driver services. </td>
///                  </tr> <tr> <td width="40%"><a id="SERVICE_DEMAND_START"></a><a id="service_demand_start"></a><dl>
///                  <dt><b>SERVICE_DEMAND_START</b></dt> <dt>0x00000003</dt> </dl> </td> <td width="60%"> A service started by the
///                  service control manager when a process calls the StartService function. For more information, see Starting
///                  Services on Demand. </td> </tr> <tr> <td width="40%"><a id="SERVICE_DISABLED"></a><a
///                  id="service_disabled"></a><dl> <dt><b>SERVICE_DISABLED</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%">
///                  A service that cannot be started. Attempts to start the service result in the error code
///                  <b>ERROR_SERVICE_DISABLED</b>. </td> </tr> <tr> <td width="40%"><a id="SERVICE_SYSTEM_START"></a><a
///                  id="service_system_start"></a><dl> <dt><b>SERVICE_SYSTEM_START</b></dt> <dt>0x00000001</dt> </dl> </td> <td
///                  width="60%"> A device driver started by the <b>IoInitSystem</b> function. This value is valid only for driver
///                  services. </td> </tr> </table>
///    dwErrorControl = The severity of the error, and action taken, if this service fails to start. This parameter can be one of the
///                     following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                     id="SERVICE_ERROR_CRITICAL"></a><a id="service_error_critical"></a><dl> <dt><b>SERVICE_ERROR_CRITICAL</b></dt>
///                     <dt>0x00000003</dt> </dl> </td> <td width="60%"> The startup program logs the error in the event log, if
///                     possible. If the last-known-good configuration is being started, the startup operation fails. Otherwise, the
///                     system is restarted with the last-known good configuration. </td> </tr> <tr> <td width="40%"><a
///                     id="SERVICE_ERROR_IGNORE"></a><a id="service_error_ignore"></a><dl> <dt><b>SERVICE_ERROR_IGNORE</b></dt>
///                     <dt>0x00000000</dt> </dl> </td> <td width="60%"> The startup program ignores the error and continues the startup
///                     operation. </td> </tr> <tr> <td width="40%"><a id="SERVICE_ERROR_NORMAL"></a><a
///                     id="service_error_normal"></a><dl> <dt><b>SERVICE_ERROR_NORMAL</b></dt> <dt>0x00000001</dt> </dl> </td> <td
///                     width="60%"> The startup program logs the error in the event log but continues the startup operation. </td> </tr>
///                     <tr> <td width="40%"><a id="SERVICE_ERROR_SEVERE"></a><a id="service_error_severe"></a><dl>
///                     <dt><b>SERVICE_ERROR_SEVERE</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> The startup program logs
///                     the error in the event log. If the last-known-good configuration is being started, the startup operation
///                     continues. Otherwise, the system is restarted with the last-known-good configuration. </td> </tr> </table>
///    lpBinaryPathName = The fully qualified path to the service binary file. If the path contains a space, it must be quoted so that it
///                       is correctly interpreted. For example, "d:\\my share\\myservice.exe" should be specified as "\"d:\\my
///                       share\\myservice.exe\"". The path can also include arguments for an auto-start service. For example,
///                       "d:\\myshare\\myservice.exe arg1 arg2". These arguments are passed to the service entry point (typically the
///                       <b>main</b> function). If you specify a path on another computer, the share must be accessible by the computer
///                       account of the local computer because this is the security context used in the remote call. However, this
///                       requirement allows any potential vulnerabilities in the remote computer to affect the local computer. Therefore,
///                       it is best to use a local file.
///    lpLoadOrderGroup = The names of the load ordering group of which this service is a member. Specify NULL or an empty string if the
///                       service does not belong to a group. The startup program uses load ordering groups to load groups of services in a
///                       specified order with respect to the other groups. The list of load ordering groups is contained in the following
///                       registry value: <b>HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\ServiceGroupOrder</b>
///    lpdwTagId = A pointer to a variable that receives a tag value that is unique in the group specified in the
///                <i>lpLoadOrderGroup</i> parameter. Specify NULL if you are not changing the existing tag. You can use a tag for
///                ordering service startup within a load ordering group by specifying a tag order vector in the following registry
///                value:<b>HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\GroupOrderList</b> Tags are only evaluated for
///                driver services that have <b>SERVICE_BOOT_START</b> or <b>SERVICE_SYSTEM_START</b> start types.
///    lpDependencies = A pointer to a double null-terminated array of null-separated names of services or load ordering groups that the
///                     system must start before this service. Specify NULL or an empty string if the service has no dependencies.
///                     Dependency on a group means that this service can run if at least one member of the group is running after an
///                     attempt to start all members of the group. You must prefix group names with <b>SC_GROUP_IDENTIFIER</b> so that
///                     they can be distinguished from a service name, because services and service groups share the same name space.
///    lpServiceStartName = The name of the account under which the service should run. If the service type is SERVICE_WIN32_OWN_PROCESS, use
///                         an account name in the form <i>DomainName</i>&
///    lpPassword = The password to the account name specified by the <i>lpServiceStartName</i> parameter. Specify an empty string if
///                 the account has no password or if the service runs in the LocalService, NetworkService, or LocalSystem account.
///                 For more information, see Service Record List. If the account name specified by the <i>lpServiceStartName</i>
///                 parameter is the name of a managed service account or virtual account name, the <i>lpPassword</i> parameter must
///                 be NULL. Passwords are ignored for driver services.
///Returns:
///    If the function succeeds, the return value is a handle to the service. If the function fails, the return value is
///    NULL. To get extended error information, call GetLastError. The following error codes can be set by the service
///    control manager. Other error codes can be set by the registry functions that are called by the service control
///    manager. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The handle to the SCM database does not have the
///    <b>SC_MANAGER_CREATE_SERVICE</b> access right. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CIRCULAR_DEPENDENCY</b></dt> </dl> </td> <td width="60%"> A circular service dependency was
///    specified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DUPLICATE_SERVICE_NAME</b></dt> </dl> </td> <td
///    width="60%"> The display name already exists in the service control manager database either as a service name or
///    as another display name. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td>
///    <td width="60%"> The handle to the specified service control manager database is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_NAME</b></dt> </dl> </td> <td width="60%"> The specified service name is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> A parameter that was specified is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_SERVICE_ACCOUNT</b></dt> </dl> </td> <td width="60%"> The user account name specified in the
///    <i>lpServiceStartName</i> parameter does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SERVICE_EXISTS</b></dt> </dl> </td> <td width="60%"> The specified service already exists in this
///    database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SERVICE_MARKED_FOR_DELETE</b></dt> </dl> </td> <td
///    width="60%"> The specified service already exists in this database and has been marked for deletion. </td> </tr>
///    </table>
///    
@DllImport("ADVAPI32")
SC_HANDLE__* CreateServiceA(SC_HANDLE__* hSCManager, const(PSTR) lpServiceName, const(PSTR) lpDisplayName, 
                            uint dwDesiredAccess, uint dwServiceType, uint dwStartType, uint dwErrorControl, 
                            const(PSTR) lpBinaryPathName, const(PSTR) lpLoadOrderGroup, uint* lpdwTagId, 
                            const(PSTR) lpDependencies, const(PSTR) lpServiceStartName, const(PSTR) lpPassword);

///Creates a service object and adds it to the specified service control manager database.
///Params:
///    hSCManager = A handle to the service control manager database. This handle is returned by the OpenSCManager function and must
///                 have the <b>SC_MANAGER_CREATE_SERVICE</b> access right. For more information, see Service Security and Access
///                 Rights.
///    lpServiceName = The name of the service to install. The maximum string length is 256 characters. The service control manager
///                    database preserves the case of the characters, but service name comparisons are always case insensitive.
///                    Forward-slash (/) and backslash (\\) are not valid service name characters.
///    lpDisplayName = The display name to be used by user interface programs to identify the service. This string has a maximum length
///                    of 256 characters. The name is case-preserved in the service control manager. Display name comparisons are always
///                    case-insensitive.
///    dwDesiredAccess = The access to the service. Before granting the requested access, the system checks the access token of the
///                      calling process. For a list of values, see Service Security and Access Rights.
///    dwServiceType = The service type. This parameter can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
///                    </tr> <tr> <td width="40%"><a id="SERVICE_ADAPTER"></a><a id="service_adapter"></a><dl>
///                    <dt><b>SERVICE_ADAPTER</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%"> Reserved. </td> </tr> <tr> <td
///                    width="40%"><a id="SERVICE_FILE_SYSTEM_DRIVER"></a><a id="service_file_system_driver"></a><dl>
///                    <dt><b>SERVICE_FILE_SYSTEM_DRIVER</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> File system driver
///                    service. </td> </tr> <tr> <td width="40%"><a id="SERVICE_KERNEL_DRIVER"></a><a
///                    id="service_kernel_driver"></a><dl> <dt><b>SERVICE_KERNEL_DRIVER</b></dt> <dt>0x00000001</dt> </dl> </td> <td
///                    width="60%"> Driver service. </td> </tr> <tr> <td width="40%"><a id="SERVICE_RECOGNIZER_DRIVER"></a><a
///                    id="service_recognizer_driver"></a><dl> <dt><b>SERVICE_RECOGNIZER_DRIVER</b></dt> <dt>0x00000008</dt> </dl> </td>
///                    <td width="60%"> Reserved. </td> </tr> <tr> <td width="40%"><a id="SERVICE_WIN32_OWN_PROCESS"></a><a
///                    id="service_win32_own_process"></a><dl> <dt><b>SERVICE_WIN32_OWN_PROCESS</b></dt> <dt>0x00000010</dt> </dl> </td>
///                    <td width="60%"> Service that runs in its own process. </td> </tr> <tr> <td width="40%"><a
///                    id="SERVICE_WIN32_SHARE_PROCESS"></a><a id="service_win32_share_process"></a><dl>
///                    <dt><b>SERVICE_WIN32_SHARE_PROCESS</b></dt> <dt>0x00000020</dt> </dl> </td> <td width="60%"> Service that shares
///                    a process with one or more other services. For more information, see Service Programs. </td> </tr> <tr> <td
///                    width="40%"><a id="SERVICE_USER_OWN_PROCESS"></a><a id="service_user_own_process"></a><dl>
///                    <dt><b>SERVICE_USER_OWN_PROCESS</b></dt> <dt>0x00000050</dt> </dl> </td> <td width="60%"> The service runs in its
///                    own process under the logged-on user account. </td> </tr> <tr> <td width="40%"><a
///                    id="SERVICE_USER_SHARE_PROCESS"></a><a id="service_user_share_process"></a><dl>
///                    <dt><b>SERVICE_USER_SHARE_PROCESS</b></dt> <dt>0x00000060</dt> </dl> </td> <td width="60%"> The service shares a
///                    process with one or more other services that run under the logged-on user account. </td> </tr> </table> If you
///                    specify either <b>SERVICE_WIN32_OWN_PROCESS</b> or <b>SERVICE_WIN32_SHARE_PROCESS</b>, and the service is running
///                    in the context of the LocalSystem account, you can also specify the following value. <table> <tr> <th>Value</th>
///                    <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SERVICE_INTERACTIVE_PROCESS"></a><a
///                    id="service_interactive_process"></a><dl> <dt><b>SERVICE_INTERACTIVE_PROCESS</b></dt> <dt>0x00000100</dt> </dl>
///                    </td> <td width="60%"> The service can interact with the desktop. For more information, see Interactive Services.
///                    </td> </tr> </table>
///    dwStartType = The service start options. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///                  <th>Meaning</th> </tr> <tr> <td width="40%"><a id="SERVICE_AUTO_START"></a><a id="service_auto_start"></a><dl>
///                  <dt><b>SERVICE_AUTO_START</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> A service started
///                  automatically by the service control manager during system startup. For more information, see Automatically
///                  Starting Services. </td> </tr> <tr> <td width="40%"><a id="SERVICE_BOOT_START"></a><a
///                  id="service_boot_start"></a><dl> <dt><b>SERVICE_BOOT_START</b></dt> <dt>0x00000000</dt> </dl> </td> <td
///                  width="60%"> A device driver started by the system loader. This value is valid only for driver services. </td>
///                  </tr> <tr> <td width="40%"><a id="SERVICE_DEMAND_START"></a><a id="service_demand_start"></a><dl>
///                  <dt><b>SERVICE_DEMAND_START</b></dt> <dt>0x00000003</dt> </dl> </td> <td width="60%"> A service started by the
///                  service control manager when a process calls the StartService function. For more information, see Starting
///                  Services on Demand. </td> </tr> <tr> <td width="40%"><a id="SERVICE_DISABLED"></a><a
///                  id="service_disabled"></a><dl> <dt><b>SERVICE_DISABLED</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%">
///                  A service that cannot be started. Attempts to start the service result in the error code
///                  <b>ERROR_SERVICE_DISABLED</b>. </td> </tr> <tr> <td width="40%"><a id="SERVICE_SYSTEM_START"></a><a
///                  id="service_system_start"></a><dl> <dt><b>SERVICE_SYSTEM_START</b></dt> <dt>0x00000001</dt> </dl> </td> <td
///                  width="60%"> A device driver started by the <b>IoInitSystem</b> function. This value is valid only for driver
///                  services. </td> </tr> </table>
///    dwErrorControl = The severity of the error, and action taken, if this service fails to start. This parameter can be one of the
///                     following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                     id="SERVICE_ERROR_CRITICAL"></a><a id="service_error_critical"></a><dl> <dt><b>SERVICE_ERROR_CRITICAL</b></dt>
///                     <dt>0x00000003</dt> </dl> </td> <td width="60%"> The startup program logs the error in the event log, if
///                     possible. If the last-known-good configuration is being started, the startup operation fails. Otherwise, the
///                     system is restarted with the last-known good configuration. </td> </tr> <tr> <td width="40%"><a
///                     id="SERVICE_ERROR_IGNORE"></a><a id="service_error_ignore"></a><dl> <dt><b>SERVICE_ERROR_IGNORE</b></dt>
///                     <dt>0x00000000</dt> </dl> </td> <td width="60%"> The startup program ignores the error and continues the startup
///                     operation. </td> </tr> <tr> <td width="40%"><a id="SERVICE_ERROR_NORMAL"></a><a
///                     id="service_error_normal"></a><dl> <dt><b>SERVICE_ERROR_NORMAL</b></dt> <dt>0x00000001</dt> </dl> </td> <td
///                     width="60%"> The startup program logs the error in the event log but continues the startup operation. </td> </tr>
///                     <tr> <td width="40%"><a id="SERVICE_ERROR_SEVERE"></a><a id="service_error_severe"></a><dl>
///                     <dt><b>SERVICE_ERROR_SEVERE</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> The startup program logs
///                     the error in the event log. If the last-known-good configuration is being started, the startup operation
///                     continues. Otherwise, the system is restarted with the last-known-good configuration. </td> </tr> </table>
///    lpBinaryPathName = The fully qualified path to the service binary file. If the path contains a space, it must be quoted so that it
///                       is correctly interpreted. For example, "d:\\my share\\myservice.exe" should be specified as "\"d:\\my
///                       share\\myservice.exe\"". The path can also include arguments for an auto-start service. For example,
///                       "d:\\myshare\\myservice.exe arg1 arg2". These arguments are passed to the service entry point (typically the
///                       <b>main</b> function). If you specify a path on another computer, the share must be accessible by the computer
///                       account of the local computer because this is the security context used in the remote call. However, this
///                       requirement allows any potential vulnerabilities in the remote computer to affect the local computer. Therefore,
///                       it is best to use a local file.
///    lpLoadOrderGroup = The names of the load ordering group of which this service is a member. Specify NULL or an empty string if the
///                       service does not belong to a group. The startup program uses load ordering groups to load groups of services in a
///                       specified order with respect to the other groups. The list of load ordering groups is contained in the following
///                       registry value: <b>HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\ServiceGroupOrder</b>
///    lpdwTagId = A pointer to a variable that receives a tag value that is unique in the group specified in the
///                <i>lpLoadOrderGroup</i> parameter. Specify NULL if you are not changing the existing tag. You can use a tag for
///                ordering service startup within a load ordering group by specifying a tag order vector in the following registry
///                value:<b>HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\GroupOrderList</b> Tags are only evaluated for
///                driver services that have <b>SERVICE_BOOT_START</b> or <b>SERVICE_SYSTEM_START</b> start types.
///    lpDependencies = A pointer to a double null-terminated array of null-separated names of services or load ordering groups that the
///                     system must start before this service. Specify NULL or an empty string if the service has no dependencies.
///                     Dependency on a group means that this service can run if at least one member of the group is running after an
///                     attempt to start all members of the group. You must prefix group names with <b>SC_GROUP_IDENTIFIER</b> so that
///                     they can be distinguished from a service name, because services and service groups share the same name space.
///    lpServiceStartName = The name of the account under which the service should run. If the service type is SERVICE_WIN32_OWN_PROCESS, use
///                         an account name in the form <i>DomainName</i>&
///    lpPassword = The password to the account name specified by the <i>lpServiceStartName</i> parameter. Specify an empty string if
///                 the account has no password or if the service runs in the LocalService, NetworkService, or LocalSystem account.
///                 For more information, see Service Record List. If the account name specified by the <i>lpServiceStartName</i>
///                 parameter is the name of a managed service account or virtual account name, the <i>lpPassword</i> parameter must
///                 be NULL. Passwords are ignored for driver services.
///Returns:
///    If the function succeeds, the return value is a handle to the service. If the function fails, the return value is
///    NULL. To get extended error information, call GetLastError. The following error codes can be set by the service
///    control manager. Other error codes can be set by the registry functions that are called by the service control
///    manager. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The handle to the SCM database does not have the
///    <b>SC_MANAGER_CREATE_SERVICE</b> access right. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CIRCULAR_DEPENDENCY</b></dt> </dl> </td> <td width="60%"> A circular service dependency was
///    specified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DUPLICATE_SERVICE_NAME</b></dt> </dl> </td> <td
///    width="60%"> The display name already exists in the service control manager database either as a service name or
///    as another display name. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td>
///    <td width="60%"> The handle to the specified service control manager database is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_NAME</b></dt> </dl> </td> <td width="60%"> The specified service name is
///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> A parameter that was specified is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_SERVICE_ACCOUNT</b></dt> </dl> </td> <td width="60%"> The user account name specified in the
///    <i>lpServiceStartName</i> parameter does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SERVICE_EXISTS</b></dt> </dl> </td> <td width="60%"> The specified service already exists in this
///    database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SERVICE_MARKED_FOR_DELETE</b></dt> </dl> </td> <td
///    width="60%"> The specified service already exists in this database and has been marked for deletion. </td> </tr>
///    </table>
///    
@DllImport("ADVAPI32")
SC_HANDLE__* CreateServiceW(SC_HANDLE__* hSCManager, const(PWSTR) lpServiceName, const(PWSTR) lpDisplayName, 
                            uint dwDesiredAccess, uint dwServiceType, uint dwStartType, uint dwErrorControl, 
                            const(PWSTR) lpBinaryPathName, const(PWSTR) lpLoadOrderGroup, uint* lpdwTagId, 
                            const(PWSTR) lpDependencies, const(PWSTR) lpServiceStartName, const(PWSTR) lpPassword);


