// Written in the D programming language.

module windows.policy;

public import windows.core;
public import windows.automation : SAFEARRAY;
public import windows.com : HRESULT, IUnknown;
public import windows.controls : HPROPSHEETPAGE;
public import windows.security : GENERIC_MAPPING, OBJECT_TYPE_LIST, PRIVILEGE_SET;
public import windows.shell : APPCATEGORYINFOLIST;
public import windows.systemservices : BOOL, HANDLE, PSTR, PWSTR;
public import windows.windowsandmessaging : HWND, LPARAM;
public import windows.windowsprogramming : HKEY, SYSTEMTIME;
public import windows.wmi : IWbemClassObject, IWbemServices;

extern(Windows) @nogc nothrow:


// Enums


alias GPO_LINK = int;
enum : int
{
    GPLinkUnknown            = 0x00000000,
    GPLinkMachine            = 0x00000001,
    GPLinkSite               = 0x00000002,
    GPLinkDomain             = 0x00000003,
    GPLinkOrganizationalUnit = 0x00000004,
}

alias SETTINGSTATUS = int;
enum : int
{
    RSOPUnspecified      = 0x00000000,
    RSOPApplied          = 0x00000001,
    RSOPIgnored          = 0x00000002,
    RSOPFailed           = 0x00000003,
    RSOPSubsettingFailed = 0x00000004,
}

///The <b>INSTALLSPECTYPE</b> enumeration values define the ways a group policy application can be specified to the
///InstallApplication function. The values are used in the <b>Type</b> member of INSTALLDATA.
alias INSTALLSPECTYPE = int;
enum : int
{
    ///This constant equals 1. The application is specified by its display name and group policy GUID.
    APPNAME  = 0x00000001,
    ///The application is specified by its file name extension, for example, .jpg.
    FILEEXT  = 0x00000002,
    PROGID   = 0x00000003,
    COMCLASS = 0x00000004,
}

alias APPSTATE = int;
enum : int
{
    ABSENT    = 0x00000000,
    ASSIGNED  = 0x00000001,
    PUBLISHED = 0x00000002,
}

alias GROUP_POLICY_OBJECT_TYPE = int;
enum : int
{
    GPOTypeLocal      = 0x00000000,
    GPOTypeRemote     = 0x00000001,
    GPOTypeDS         = 0x00000002,
    GPOTypeLocalUser  = 0x00000003,
    GPOTypeLocalGroup = 0x00000004,
}

alias GROUP_POLICY_HINT_TYPE = int;
enum : int
{
    GPHintUnknown            = 0x00000000,
    GPHintMachine            = 0x00000001,
    GPHintSite               = 0x00000002,
    GPHintDomain             = 0x00000003,
    GPHintOrganizationalUnit = 0x00000004,
}

// Callbacks

///The <b>StatusMessageCallback</b> function is an application-defined callback function used to display status messages
///when applying policy. The <b>PFNSTATUSMESSAGECALLBACK</b> type defines a pointer to this callback function.
///<b>StatusMessageCallback</b> is a placeholder for the application-defined function name.
///Params:
///    bVerbose = Specifies whether the message is verbose. If this parameter is <b>TRUE</b>, the message is verbose. If this
///               parameter is <b>FALSE</b>, the message is not verbose.
///    lpMessage = Pointer to a buffer that contains the message string.
///Returns:
///    If the message was displayed successfully, return <b>ERROR_SUCCESS</b>. Otherwise, return a system error code.
///    
alias PFNSTATUSMESSAGECALLBACK = uint function(BOOL bVerbose, PWSTR lpMessage);
///The <b>ProcessGroupPolicy</b> function is an application-defined callback function used when applying policy. The
///<b>PFNPROCESSGROUPPOLICY</b> type defines a pointer to this callback function. <b>ProcessGroupPolicy</b> is a
///placeholder for the application-defined function name. This callback function is not useful for Resultant Set of
///Policy (RSoP) processing; use the ProcessGroupPolicyEx callback function instead.
///Params:
///    dwFlags = This parameter can be one or more of the following flags.
///    hToken = Token for the user or computer, returned from the LogonUser, CreateRestrictedToken, DuplicateToken,
///             OpenProcessToken, or OpenThreadToken function. This token must have <b>TOKEN_IMPERSONATE</b> and
///             <b>TOKEN_QUERY</b> access. For more information, see Access Rights for Access-Token Objects and Client
///             Impersonation.
///    hKeyRoot = Handle to the <b>HKEY_LOCAL_MACHINE</b> or <b>HKEY_CURRENT_USER</b> registry key.
///    pDeletedGPOList = Pointer that receives the list of deleted GPO structures. For more information, see GROUP_POLICY_OBJECT.
///    pChangedGPOList = Pointer that receives the list of changed GPO structures. For more information, see GROUP_POLICY_OBJECT.
///    pHandle = Asynchronous completion handle. If the callback function does not support asynchronous processing, this handle is
///              zero.
///    pbAbort = Specifies whether to continue processing GPOs. If this parameter is <b>TRUE</b>, GPO processing will cease. If
///              this parameter is <b>FALSE</b>, GPO processing will continue.
///    pStatusCallback = Pointer to a StatusMessageCallback callback function that displays status messages. This parameter can be
///                      <b>NULL</b> in certain cases. For example, if the system is applying policy in the background, the status user
///                      interface is not present and the application cannot send status messages to be displayed. For more information,
///                      see the following Remarks section.
///Returns:
///    If policy was applied successfully, return <b>ERROR_SUCCESS</b>. If there are no changes to the GPO list, and the
///    extension is to be called again, return <b>ERROR_OVERRIDE_NOCHANGES</b>. Returning
///    <b>ERROR_OVERRIDE_NOCHANGES</b> ensures that the extension is called again, even if the <b>NoGPOListChanges</b>
///    registry value is set. (For more information about this registry value, see Remarks.) Otherwise, return a system
///    error code.
///    
alias PFNPROCESSGROUPPOLICY = uint function(uint dwFlags, HANDLE hToken, HKEY hKeyRoot, 
                                            GROUP_POLICY_OBJECTA* pDeletedGPOList, 
                                            GROUP_POLICY_OBJECTA* pChangedGPOList, size_t pHandle, BOOL* pbAbort, 
                                            PFNSTATUSMESSAGECALLBACK pStatusCallback);
///The <b>ProcessGroupPolicyEx</b> function is an application-defined callback function used when applying policy. This
///extended function also supports the logging of Resultant Set of Policy (RSoP) data. The
///<b>PFNPROCESSGROUPPOLICYEX</b> type defines a pointer to this callback function. <b>ProcessGroupPolicyEx</b> is a
///placeholder for the application-defined function name.
///Params:
///    dwFlags = This parameter can be one or more of the following flags.
///    hToken = Token for the user or computer, returned from the LogonUser, CreateRestrictedToken, DuplicateToken,
///             OpenProcessToken, or OpenThreadToken function. This token must have <b>TOKEN_IMPERSONATE</b> and
///             <b>TOKEN_QUERY</b> access. For more information, see Access Rights for Access-Token Objects and Client
///             Impersonation.
///    hKeyRoot = Handle to the <b>HKEY_LOCAL_MACHINE</b> or <b>HKEY_CURRENT_USER</b> registry key.
///    pDeletedGPOList = Pointer that receives the list of deleted GPO structures. For more information, see GROUP_POLICY_OBJECT.
///    pChangedGPOList = Pointer that receives the list of changed GPO structures. For more information, see GROUP_POLICY_OBJECT.
///    pHandle = Asynchronous completion handle. If the callback function does not support asynchronous processing, this handle is
///              zero.
///    pbAbort = Specifies whether to continue processing GPOs. If this parameter is <b>TRUE</b>, GPO processing will cease. If
///              this parameter is <b>FALSE</b>, GPO processing will continue.
///    pStatusCallback = Pointer to a StatusMessageCallback callback function that displays status messages. This parameter can be
///                      <b>NULL</b> in certain cases. For example, if the system is applying policy in the background, the status user
///                      interface is not present and the application cannot send status messages to be displayed. For more information,
///                      see the following Remarks section.
///    pWbemServices = Specifies a WMI services pointer to the RSoP namespace to which the policy data should be written. This parameter
///                    is <b>NULL</b> when RSoP logging is disabled, indicating that the extension should not log RSoP data.
///    pRsopStatus = Pointer to an <b>HRESULT</b> return code that indicates whether RSoP logging was successful.
///Returns:
///    If policy was applied successfully, return <b>ERROR_SUCCESS</b>. If there are no changes to the GPO list, and the
///    extension is to be called again, return <b>ERROR_OVERRIDE_NOCHANGES</b>. Returning
///    <b>ERROR_OVERRIDE_NOCHANGES</b> ensures that the extension is called again, even if the <b>NoGPOListChanges</b>
///    registry value is set. (For more information about this registry value, see Remarks.) Return
///    <b>ERROR_SYNC_FOREGROUND_REFRESH_REQUIRED</b> if the function was called for an asynchronous foreground refresh
///    of policy but policy could not be applied during the asynchronous refresh. Returning
///    <b>ERROR_SYNC_FOREGROUND_REFRESH_REQUIRED</b> indicates that the function must be called again for a synchronous
///    foreground refresh of policy. Otherwise, return a system error code.
///    
alias PFNPROCESSGROUPPOLICYEX = uint function(uint dwFlags, HANDLE hToken, HKEY hKeyRoot, 
                                              GROUP_POLICY_OBJECTA* pDeletedGPOList, 
                                              GROUP_POLICY_OBJECTA* pChangedGPOList, size_t pHandle, BOOL* pbAbort, 
                                              PFNSTATUSMESSAGECALLBACK pStatusCallback, IWbemServices pWbemServices, 
                                              HRESULT* pRsopStatus);
///The <b>GenerateGroupPolicy</b> callback function is an application-defined callback function that each policy
///extension must export when generating RSoP data in the planning mode. The Group Policy Data Access Service (GPDAS)
///calls the function after the service simulates the loading of client-side extensions so that extensions can generate
///policy data. The <b>PFNGENERATEGROUPPOLICY</b> type defines a pointer to this callback function.
///<b>GenerateGroupPolicy</b> is a placeholder for the application-defined function name.
///Params:
///    dwFlags = A parameter that represents one or more of the following flags.
///    pbAbort = A value that specifies whether to continue processing GPOs. If this parameter is <b>TRUE</b>, GPO processing
///              stops and the extension must deallocate its resources and return promptly. If this parameter is <b>FALSE</b>, GPO
///              processing continues.
///    pwszSite = A pointer to the site name of the target computer. This parameter can be <b>NULL</b>.
///    pComputerTarget = A pointer to an RSOP_TARGET structure that contains information about a computer. This parameter can be
///                      <b>NULL</b>, but if it is <b>NULL</b>, the <i>pUserTarget</i> parameter is required.
///    pUserTarget = A pointer to an RSOP_TARGET structure that contains information about a user. This parameter can be <b>NULL</b>,
///                  but if it is <b>NULL</b>, the <i>pComputerTarget</i> parameter is required.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. Otherwise, the function returns one of the
///    system error codes. For a complete list of error codes, see System Error Codes or the header file WinError.h.
///    
alias PFNGENERATEGROUPPOLICY = uint function(uint dwFlags, BOOL* pbAbort, PWSTR pwszSite, 
                                             RSOP_TARGET* pComputerTarget, RSOP_TARGET* pUserTarget);

// Structs


@RAIIFree!LeaveCriticalPolicySection
struct CriticalPolicySectionHandle
{
    ptrdiff_t Value;
}

///The <b>GROUP_POLICY_OBJECT</b> structure provides information about a GPO in a GPO list.
struct GROUP_POLICY_OBJECTA
{
    ///Specifies link options. This member can be one of the following values.
    uint     dwOptions;
    ///Specifies the version number of the GPO.
    uint     dwVersion;
    ///Pointer to a string that specifies the path to the directory service portion of the GPO.
    PSTR     lpDSPath;
    ///Pointer to a string that specifies the path to the file system portion of the GPO.
    PSTR     lpFileSysPath;
    ///Pointer to the display name of the GPO.
    PSTR     lpDisplayName;
    ///Pointer to a string that specifies a unique name that identifies the GPO.
    byte[50] szGPOName;
    ///Specifies the link information for the GPO. This member may be one of the following values.
    GPO_LINK GPOLink;
    ///User-supplied data.
    LPARAM   lParam;
    ///Pointer to the next GPO in the list.
    GROUP_POLICY_OBJECTA* pNext;
    ///Pointer to the previous GPO in the list.
    GROUP_POLICY_OBJECTA* pPrev;
    ///Extensions that have stored data in this GPO. The format is a string of <b>GUID</b>s grouped in brackets. For
    ///more information, see the following Remarks section.
    PSTR     lpExtensions;
    ///User-supplied data.
    LPARAM   lParam2;
    ///Path to the Active Directory site, domain, or organization unit to which this GPO is linked. If the GPO is linked
    ///to the local GPO, this member is "Local".
    PSTR     lpLink;
}

///The <b>GROUP_POLICY_OBJECT</b> structure provides information about a GPO in a GPO list.
struct GROUP_POLICY_OBJECTW
{
    ///Specifies link options. This member can be one of the following values.
    uint       dwOptions;
    ///Specifies the version number of the GPO.
    uint       dwVersion;
    ///Pointer to a string that specifies the path to the directory service portion of the GPO.
    PWSTR      lpDSPath;
    ///Pointer to a string that specifies the path to the file system portion of the GPO.
    PWSTR      lpFileSysPath;
    ///Pointer to the display name of the GPO.
    PWSTR      lpDisplayName;
    ///Pointer to a string that specifies a unique name that identifies the GPO.
    ushort[50] szGPOName;
    ///Specifies the link information for the GPO. This member may be one of the following values.
    GPO_LINK   GPOLink;
    ///User-supplied data.
    LPARAM     lParam;
    ///Pointer to the next GPO in the list.
    GROUP_POLICY_OBJECTW* pNext;
    ///Pointer to the previous GPO in the list.
    GROUP_POLICY_OBJECTW* pPrev;
    ///Extensions that have stored data in this GPO. The format is a string of <b>GUID</b>s grouped in brackets. For
    ///more information, see the following Remarks section.
    PWSTR      lpExtensions;
    ///User-supplied data.
    LPARAM     lParam2;
    ///Path to the Active Directory site, domain, or organization unit to which this GPO is linked. If the GPO is linked
    ///to the local GPO, this member is "Local".
    PWSTR      lpLink;
}

///The <b>RSOP_TARGET</b> structure contains computer and user information required by the GenerateGroupPolicy function.
struct RSOP_TARGET
{
    ///Pointer to the account name of the computer or the user.
    PWSTR         pwszAccountName;
    ///Pointer to the new domain or organizational unit that is the location for the account identified by the
    ///<b>pwszAccountName</b> member. This member can be <b>NULL</b>.
    PWSTR         pwszNewSOM;
    ///Pointer to a <b>SAFEARRAY</b> that contains a proposed list of new security groups. This member can be
    ///<b>NULL</b>. For more information about security groups, see Filtering the Scope of a GPO and How Security Groups
    ///are Used in Access Control.
    SAFEARRAY*    psaSecurityGroups;
    ///Pointer to an <b>RSOPTOKEN</b> to use with the RSoPAccessCheckByType and the RSoPFileAccessCheck functions.
    void*         pRsopToken;
    ///Pointer to a GROUP_POLICY_OBJECT structure containing a linked list of GPOs.
    GROUP_POLICY_OBJECTA* pGPOList;
    ///Specifies the WMI services pointer to the namespace to which the planning mode policy data should be written.
    IWbemServices pWbemServices;
}

///The <b>POLICYSETTINGSTATUSINFO</b> structure provides information about a policy-setting event.
struct POLICYSETTINGSTATUSINFO
{
    ///This member is optional. If it is <b>NULL</b>, the system generates a value.
    PWSTR         szKey;
    ///Pointer to a string specifying the name of the source (application, service, driver, subsystem) that generated
    ///the log entry.
    PWSTR         szEventSource;
    ///Pointer to a string specifying the name of the event log.
    PWSTR         szEventLogName;
    ///Specifies the event log message ID.
    uint          dwEventID;
    ///A system error code that indicates an error that occurred during the application of the policy setting.
    uint          dwErrorCode;
    ///Specifies the status of the policy setting. This member can be one of the following values.
    SETTINGSTATUS status;
    ///Specifies a SYSTEMTIME structure that indicates the time at which the source generated the event.
    SYSTEMTIME    timeLogged;
}

///The <b>INSTALLSPEC</b> structure specifies a group policy application by its user-friendly name and group policy GUID
///or by its file name extension. The <b>Spec</b> member of the INSTALLDATA structure provides this information to the
///InstallApplication function.
union INSTALLSPEC
{
struct AppName
    {
        PWSTR Name;
        GUID  GPOId;
    }
    ///The file name extension, such as .jpg, of the application to be installed. <div class="alert"><b>Note</b>
    ///InstallApplication fails if the <b>Type</b> member of INSTALLDATA equals <b>FILEEXT</b> and there is no
    ///application deployed to the user with this file name extension.</div> <div> </div>
    PWSTR FileExt;
    ///This parameter is reserved and should not be used.
    PWSTR ProgId;
struct COMClass
    {
        GUID Clsid;
        uint ClsCtx;
    }
}

///The <b>INSTALLDATA</b> structure specifies a group-policy application to be installed by InstallApplication.
struct INSTALLDATA
{
    ///Defines how <b>Spec</b> specifies the application to InstallApplication. <b>Type</b> can be one of the
    ///INSTALLSPECTYPE enumeration values. Set <b>Type</b> to APPNAME to install an application specified by its
    ///user-friendly name and GPO GUID. Set <b>Type</b> to FILEEXT to install an application specified by its file name
    ///extension.
    INSTALLSPECTYPE Type;
    ///An INSTALLSPEC structure that specifies the application.
    INSTALLSPEC     Spec;
}

///The <b>LOCALMANAGEDAPPLICATION</b> structure describes a managed application installed for a user or a computer.
///Returned by the GetLocalManagedApplications function.
struct LOCALMANAGEDAPPLICATION
{
    ///This is a Unicode string that gives the user friendly name of the application as it appears in the Application
    ///Deployment Editor (ADE).
    PWSTR pszDeploymentName;
    ///This is the user-friendly name of the group policy object (GPO) from which the application originates.
    PWSTR pszPolicyName;
    ///This is a Unicode string that gives the Windows Installer product code GUID for the application.
    PWSTR pszProductId;
    ///Indicates the state of the installed application. This parameter can contain one or more of the following values.
    uint  dwState;
}

///The <b>MANAGEDAPPLICATION</b> structure contains information about an application. The function
///GetManagedApplications returns an array of <b>MANAGEDAPPLICATION</b> structures.
struct MANAGEDAPPLICATION
{
    ///The user-friendly name of the application.
    PWSTR  pszPackageName;
    ///The name of the application's publisher.
    PWSTR  pszPublisher;
    ///The major version number of the application.
    uint   dwVersionHi;
    ///The minor version number of the application.
    uint   dwVersionLo;
    ///The version number of the deployment. The version changes each time an application gets patched.
    uint   dwRevision;
    ///The GUID of the GPO from which this application is deployed.
    GUID   GpoId;
    ///The user-friendly name for the GPO from which this application is deployed.
    PWSTR  pszPolicyName;
    ///If this application is installed by Windows Installer, this member is the ProductId GUID.
    GUID   ProductId;
    ///The numeric language identifier that indicates the language version of the application. For a list of language
    ///numeric identifiers, see the Language Identifier Constants and Strings topic.
    ushort Language;
    ///This member is unused.
    PWSTR  pszOwner;
    ///This member is unused.
    PWSTR  pszCompany;
    ///This member is unused.
    PWSTR  pszComments;
    ///This member is unused.
    PWSTR  pszContact;
    ///This member is unused.
    PWSTR  pszSupportUrl;
    ///Indicates the type of package used to install the application. This member can have one of the following values.
    uint   dwPathType;
    ///This parameter is <b>TRUE</b> if the application is currently installed and is <b>FALSE</b> otherwise.
    BOOL   bInstalled;
}

///The <b>GPOBROWSEINFO</b> structure contains information that the BrowseForGPO function uses to initialize a GPO
///browser dialog box. After the user closes the dialog box, the system returns information about the user's actions in
///this structure.
struct GPOBROWSEINFO
{
    ///Specifies the size of the structure, in bytes.
    uint  dwSize;
    ///Specifies dialog box options. This member can be one or more of the following values.
    uint  dwFlags;
    ///Specifies the handle to the parent window. If this member is <b>NULL</b>, the dialog box has no owner.
    HWND  hwndOwner;
    ///Specifies the title bar text. If this member is <b>NULL</b>, the title bar text is <b>Browse for a Group Policy
    ///Object</b>.
    PWSTR lpTitle;
    ///Specifies the initial domain or organizational unit.
    PWSTR lpInitialOU;
    ///Pointer to a buffer that receives the Active Directory path of the GPO.
    PWSTR lpDSPath;
    ///Specifies the size, in characters, of the <b>lpDSPath</b> buffer.
    uint  dwDSPathSize;
    ///Pointer to a buffer that receives either the computer name or the friendly (display) name of the GPO. If the user
    ///opens or creates a GPO in the <b>Computers</b> tab, this member contains the computer name. If the user opens or
    ///creates a GPO in the Active Directory, this member contains the friendly name. To determine the GPO type, see the
    ///description for the <b>gpoType</b> member. This member can be <b>NULL</b>.
    PWSTR lpName;
    ///Specifies the size, in characters, of the <b>lpName</b> buffer.
    uint  dwNameSize;
    ///Receives the GPO type. This member can be one of the following values.
    GROUP_POLICY_OBJECT_TYPE gpoType;
    ///Receives a hint about the Active Directory container to which the GPO might be linked. This member can be one of
    ///the following values.
    GROUP_POLICY_HINT_TYPE gpoHint;
}

// Functions

///The <b>RefreshPolicy</b> function causes policy to be applied immediately on the client computer. To apply policy and
///specify the type of refresh that should occur, you can call the extended function RefreshPolicyEx.
///Params:
///    bMachine = Specifies whether to refresh the computer policy or user policy. If this value is <b>TRUE</b>, the system
///               refreshes the computer policy. If this value is <b>FALSE</b>, the system refreshes the user policy.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USERENV")
BOOL RefreshPolicy(BOOL bMachine);

///The <b>RefreshPolicyEx</b> function causes policy to be applied immediately on the computer. The extended function
///allows you to specify the type of policy refresh to apply.
///Params:
///    bMachine = Specifies whether to refresh the computer policy or user policy. If this value is <b>TRUE</b>, the system
///               refreshes the computer policy. If this value is <b>FALSE</b>, the system refreshes the user policy.
///    dwOptions = Specifies the type of policy refresh to apply. This parameter can be the following value.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USERENV")
BOOL RefreshPolicyEx(BOOL bMachine, uint dwOptions);

///The <b>EnterCriticalPolicySection</b> function pauses the application of policy to allow applications to safely read
///policy settings. Applications call this function if they read multiple policy entries and must ensure that the
///settings are not changed while they are being read. This mutex protects Group Policy processing for all client-side
///extensions stored in a Group Policy Object (GPO).
///Params:
///    bMachine = A value that specifies whether to stop the application of computer policy or user policy. If this value is
///               <b>TRUE</b>, the system stops applying computer policy. If this value is <b>FALSE</b>, the system stops applying
///               user policy.
///Returns:
///    If the function succeeds, the return value is a handle to a policy section. If the function fails, the return
///    value is <b>NULL</b>. To get extended error information, call the GetLastError function.
///    
@DllImport("USERENV")
HANDLE EnterCriticalPolicySection(BOOL bMachine);

///The <b>LeaveCriticalPolicySection</b> function resumes the background application of policy. This function closes the
///handle to the policy section.
///Params:
///    hSection = Handle to a policy section, which is returned by the EnterCriticalPolicySection function.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USERENV")
BOOL LeaveCriticalPolicySection(HANDLE hSection);

///The <b>RegisterGPNotification</b> function enables an application to receive notification when there is a change in
///policy. When a policy change occurs, the specified event object is set to the signaled state.
///Params:
///    hEvent = Handle to an event object. Use the CreateEvent function to create the event object.
///    bMachine = Specifies the policy change type. If <b>TRUE</b>, computer policy changes are reported. If <b>FALSE</b>, user
///               policy changes are reported.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USERENV")
BOOL RegisterGPNotification(HANDLE hEvent, BOOL bMachine);

///The <b>UnregisterGPNotification</b> function unregisters the specified policy-notification handle from receiving
///policy change notifications.
///Params:
///    hEvent = Policy-notification handle passed to the RegisterGPNotification function.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USERENV")
BOOL UnregisterGPNotification(HANDLE hEvent);

///The <b>GetGPOList</b> function retrieves the list of GPOs for the specified user or computer. This function can be
///called in two ways: first, you can use the token for the user or computer, or, second, you can use the name of the
///user or computer and the name of the domain controller.
///Params:
///    hToken = A token for the user or computer, returned from the LogonUser, CreateRestrictedToken, DuplicateToken,
///             OpenProcessToken, or OpenThreadToken function. This token must have <b>TOKEN_IMPERSONATE</b> and
///             <b>TOKEN_QUERY</b> access. For more information, see Access Rights for Access-Token Objects and the following
///             Remarks section. If this parameter is <b>NULL</b>, you must supply values for the <i>lpName</i> and
///             <i>lpHostName</i> parameters.
///    lpName = A pointer to the user or computer name, in the fully qualified distinguished name format (for example,
///             "CN=<i>user</i>, OU=<i>users</i>, DC=<i>contoso</i>, DC=<i>com</i>"). If the <i>hToken</i> parameter is not
///             <b>NULL</b>, this parameter must be <b>NULL</b>.
///    lpHostName = A DNS domain name or domain controller name. Domain controller name can be retrieved using the DsGetDcName
///                 function, specifying <b>DS_DIRECTORY_SERVICE_REQUIRED</b> in the <i>flags</i> parameter. If the <i>hToken</i>
///                 parameter is not <b>NULL</b>, this parameter must be <b>NULL</b>.
///    lpComputerName = A pointer to the name of the computer used to determine the site location. The format of the name is "&
///    dwFlags = A value that specifies additional flags that are used to control information retrieval. If you specify
///              <b>GPO_LIST_FLAG_MACHINE</b>, the function retrieves policy information for the computer. If you do not specify
///              <b>GPO_LIST_FLAG_MACHINE</b>, the function retrieves policy information for the user. If you specify
///              <b>GPO_LIST_FLAG_SITEONLY</b> the function returns only site information for the computer or user.
///    pGPOList = A pointer that receives the list of GPO structures. For more information, see GROUP_POLICY_OBJECT.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USERENV")
BOOL GetGPOListA(HANDLE hToken, const(PSTR) lpName, const(PSTR) lpHostName, const(PSTR) lpComputerName, 
                 uint dwFlags, GROUP_POLICY_OBJECTA** pGPOList);

///The <b>GetGPOList</b> function retrieves the list of GPOs for the specified user or computer. This function can be
///called in two ways: first, you can use the token for the user or computer, or, second, you can use the name of the
///user or computer and the name of the domain controller.
///Params:
///    hToken = A token for the user or computer, returned from the LogonUser, CreateRestrictedToken, DuplicateToken,
///             OpenProcessToken, or OpenThreadToken function. This token must have <b>TOKEN_IMPERSONATE</b> and
///             <b>TOKEN_QUERY</b> access. For more information, see Access Rights for Access-Token Objects and the following
///             Remarks section. If this parameter is <b>NULL</b>, you must supply values for the <i>lpName</i> and
///             <i>lpHostName</i> parameters.
///    lpName = A pointer to the user or computer name, in the fully qualified distinguished name format (for example,
///             "CN=<i>user</i>, OU=<i>users</i>, DC=<i>contoso</i>, DC=<i>com</i>"). If the <i>hToken</i> parameter is not
///             <b>NULL</b>, this parameter must be <b>NULL</b>.
///    lpHostName = A DNS domain name or domain controller name. Domain controller name can be retrieved using the DsGetDcName
///                 function, specifying <b>DS_DIRECTORY_SERVICE_REQUIRED</b> in the <i>flags</i> parameter. If the <i>hToken</i>
///                 parameter is not <b>NULL</b>, this parameter must be <b>NULL</b>.
///    lpComputerName = A pointer to the name of the computer used to determine the site location. The format of the name is "&
///    dwFlags = A value that specifies additional flags that are used to control information retrieval. If you specify
///              <b>GPO_LIST_FLAG_MACHINE</b>, the function retrieves policy information for the computer. If you do not specify
///              <b>GPO_LIST_FLAG_MACHINE</b>, the function retrieves policy information for the user. If you specify
///              <b>GPO_LIST_FLAG_SITEONLY</b> the function returns only site information for the computer or user.
///    pGPOList = A pointer that receives the list of GPO structures. For more information, see GROUP_POLICY_OBJECT.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USERENV")
BOOL GetGPOListW(HANDLE hToken, const(PWSTR) lpName, const(PWSTR) lpHostName, const(PWSTR) lpComputerName, 
                 uint dwFlags, GROUP_POLICY_OBJECTW** pGPOList);

///The <b>FreeGPOList</b> function frees the specified list of GPOs.
///Params:
///    pGPOList = A pointer to the list of GPO structures. This list is returned by the GetGPOList or GetAppliedGPOList function.
///               For more information, see GROUP_POLICY_OBJECT.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USERENV")
BOOL FreeGPOListA(GROUP_POLICY_OBJECTA* pGPOList);

///The <b>FreeGPOList</b> function frees the specified list of GPOs.
///Params:
///    pGPOList = A pointer to the list of GPO structures. This list is returned by the GetGPOList or GetAppliedGPOList function.
///               For more information, see GROUP_POLICY_OBJECT.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USERENV")
BOOL FreeGPOListW(GROUP_POLICY_OBJECTW* pGPOList);

///The <b>GetAppliedGPOList</b> function retrieves the list of GPOs applied for the specified user or computer.
///Params:
///    dwFlags = A value that specifies the policy type. This parameter can be the following value.
///    pMachineName = A pointer to the name of the remote computer. The format of the name is "&
///    pSidUser = A value that specifies the SID of the user. If <i>pMachineName</i> is not <b>NULL</b> and <i>dwFlags</i>
///               specifies user policy, then <i>pSidUser</i> cannot be <b>NULL</b>. If <i>pMachineName</i> is <b>NULL</b> and
///               <i>pSidUser</i> is <b>NULL</b>, the user is the currently logged-on user. If <i>pMachineName</i> is <b>NULL</b>
///               and <i>pSidUser</i> is not <b>NULL</b>, the user is represented by <i>pSidUser</i> on the local computer. For
///               more information, see Security Identifiers.
///    pGuidExtension = A value that specifies the <b>GUID</b> of the extension.
///    ppGPOList = A pointer that receives the list of GPO structures. For more information, see GROUP_POLICY_OBJECT.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. Otherwise, the function returns a system
///    error code. For a complete list of error codes, see System Error Codes or the header file WinError.h.
///    
@DllImport("USERENV")
uint GetAppliedGPOListA(uint dwFlags, const(PSTR) pMachineName, void* pSidUser, GUID* pGuidExtension, 
                        GROUP_POLICY_OBJECTA** ppGPOList);

///The <b>GetAppliedGPOList</b> function retrieves the list of GPOs applied for the specified user or computer.
///Params:
///    dwFlags = A value that specifies the policy type. This parameter can be the following value.
///    pMachineName = A pointer to the name of the remote computer. The format of the name is "&
///    pSidUser = A value that specifies the SID of the user. If <i>pMachineName</i> is not <b>NULL</b> and <i>dwFlags</i>
///               specifies user policy, then <i>pSidUser</i> cannot be <b>NULL</b>. If <i>pMachineName</i> is <b>NULL</b> and
///               <i>pSidUser</i> is <b>NULL</b>, the user is the currently logged-on user. If <i>pMachineName</i> is <b>NULL</b>
///               and <i>pSidUser</i> is not <b>NULL</b>, the user is represented by <i>pSidUser</i> on the local computer. For
///               more information, see Security Identifiers.
///    pGuidExtension = A value that specifies the <b>GUID</b> of the extension.
///    ppGPOList = A pointer that receives the list of GPO structures. For more information, see GROUP_POLICY_OBJECT.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. Otherwise, the function returns a system
///    error code. For a complete list of error codes, see System Error Codes or the header file WinError.h.
///    
@DllImport("USERENV")
uint GetAppliedGPOListW(uint dwFlags, const(PWSTR) pMachineName, void* pSidUser, GUID* pGuidExtension, 
                        GROUP_POLICY_OBJECTW** ppGPOList);

///The <b>ProcessGroupPolicyCompleted</b> function notifies the system that the specified extension has finished
///applying policy.
///Params:
///    extensionId = Specifies the unique <b>GUID</b> that identifies the extension.
///    pAsyncHandle = Asynchronous completion handle. This handle is passed to the ProcessGroupPolicy function.
///    dwStatus = Specifies the completion status of asynchronous processing.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. Otherwise, the function returns one of the
///    system error codes. For a complete list of error codes, see System Error Codes or the header file WinError.h.
///    
@DllImport("USERENV")
uint ProcessGroupPolicyCompleted(GUID* extensionId, size_t pAsyncHandle, uint dwStatus);

///The <b>ProcessGroupPolicyCompletedEx</b> function notifies the system that the specified policy extension has
///finished applying policy. The function also reports the status of Resultant Set of Policy (RSoP) logging.
///Params:
///    extensionId = Specifies the unique <b>GUID</b> that identifies the policy extension.
///    pAsyncHandle = Asynchronous completion handle. This handle is passed to the ProcessGroupPolicyEx callback function.
///    dwStatus = Specifies the completion status of asynchronous processing of policy.
///    RsopStatus = Specifies an <b>HRESULT</b> return code that indicates the status of RSoP logging.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. Otherwise, the function returns one of the
///    system error codes. For a complete list of error codes, see System Error Codes or the header file WinError.h.
///    
@DllImport("USERENV")
uint ProcessGroupPolicyCompletedEx(GUID* extensionId, size_t pAsyncHandle, uint dwStatus, HRESULT RsopStatus);

///The <b>RSoPAccessCheckByType</b> function determines whether a security descriptor grants a specified set of access
///rights to the client identified by an <b>RSOPTOKEN</b>.
///Params:
///    pSecurityDescriptor = Pointer to a SECURITY_DESCRIPTOR against which access on the object is checked.
///    pPrincipalSelfSid = Pointer to a SID. If the security descriptor is associated with an object that represents a principal (for
///                        example, a user object), this parameter should be the SID of the object. When evaluating access, this SID
///                        logically replaces the SID in any ACE containing the well-known <b>PRINCIPAL_SELF</b> SID ("S-1-5-10"). For more
///                        information, see Security Identifiers and Well-Known SIDs. This parameter should be <b>NULL</b> if the protected
///                        object does not represent a principal.
///    pRsopToken = Pointer to a valid <b>RSOPTOKEN</b> representing the client attempting to gain access to the object.
///    dwDesiredAccessMask = Specifies an access mask that indicates the access rights to check. This mask can contain a combination of
///                          generic, standard and specific access rights. For more information, see Access Rights and Access Masks.
///    pObjectTypeList = Pointer to an array of OBJECT_TYPE_LIST structures that identify the hierarchy of object types for which to check
///                      access. Each element in the array specifies a <b>GUID</b> that identifies the object type and a value indicating
///                      the level of the object type in the hierarchy of object types. The array should not have two elements with the
///                      same <b>GUID</b>. The array must have at least one element. The first element in the array must be at level zero
///                      and identify the object itself. The array can have only one level zero element. The second element is a
///                      subobject, such as a property set, at level 1. Following each level 1 entry are subordinate entries for the level
///                      2 through 4 subobjects. Thus, the levels for the elements in the array might be {0, 1, 2, 2, 1, 2, 3}. If the
///                      object type list is out of order, <b>RSoPAccessCheckByType</b> fails and GetLastError returns
///                      <b>ERROR_INVALID_PARAMETER</b>.
///    ObjectTypeListLength = Specifies the number of elements in the <i>pObjectTypeList</i> array.
///    pGenericMapping = Pointer to the GENERIC_MAPPING structure associated with the object for which access is being checked.
///    pPrivilegeSet = This parameter is currently unused.
///    pdwPrivilegeSetLength = This parameter is currently unused.
///    pdwGrantedAccessMask = Pointer to an access mask that receives the granted access rights. If the function succeeds, the
///                           <i>pbAccessStatus</i> parameter is set to <b>TRUE</b>, and the mask is updated to contain the standard and
///                           specific rights granted. If <i>pbAccessStatus</i> is set to <b>FALSE</b>, this parameter is set to zero. If the
///                           function fails, the mask is not modified.
///    pbAccessStatus = Pointer to a variable that receives the results of the access check. If the function succeeds, and the requested
///                     set of access rights are granted, this parameter is set to <b>TRUE</b>. Otherwise, this parameter is set to
///                     <b>FALSE</b>. If the function fails, the status is not modified.
///Returns:
///    If the function succeeds, the return value is <b>S_OK</b>. Otherwise, the function returns one of the COM error
///    codes defined in the Platform SDK header file WinError.h.
///    
@DllImport("USERENV")
HRESULT RsopAccessCheckByType(void* pSecurityDescriptor, void* pPrincipalSelfSid, void* pRsopToken, 
                              uint dwDesiredAccessMask, OBJECT_TYPE_LIST* pObjectTypeList, uint ObjectTypeListLength, 
                              GENERIC_MAPPING* pGenericMapping, PRIVILEGE_SET* pPrivilegeSet, 
                              uint* pdwPrivilegeSetLength, uint* pdwGrantedAccessMask, int* pbAccessStatus);

///The <b>RSoPFileAccessCheck</b> function determines whether a file's security descriptor grants a specified set of
///file access rights to the client identified by an <b>RSOPTOKEN</b>.
///Params:
///    pszFileName = Pointer to the name of the relevant file. The file must already exist.
///    pRsopToken = Pointer to a valid <b>RSOPTOKEN</b> representing the client attempting to gain access to the file.
///    dwDesiredAccessMask = Specifies an access mask that indicates the access rights to check. This mask can contain a combination of
///                          generic, standard, and specific access rights. For more information, see Access Rights and Access Masks.
///    pdwGrantedAccessMask = Pointer to an access mask that receives the granted access rights. If the function succeeds, the
///                           <i>pbAccessStatus</i> parameter is set to <b>TRUE</b>, and the mask is updated to contain the standard and
///                           specific rights granted. If <i>pbAccessStatus</i> is set to <b>FALSE</b>, this parameter is set to zero. If the
///                           function fails, the mask is not modified.
///    pbAccessStatus = Pointer to a variable that receives the results of the access check. If the function succeeds, and the requested
///                     set of access rights are granted, this parameter is set to <b>TRUE</b>. Otherwise, this parameter is set to
///                     <b>FALSE</b>. If the function fails, the status is not modified.
///Returns:
///    If the function succeeds, the return value is <b>S_OK</b>. Otherwise, the function returns one of the COM error
///    codes defined in the Platform SDK header file WinError.h.
///    
@DllImport("USERENV")
HRESULT RsopFileAccessCheck(PWSTR pszFileName, void* pRsopToken, uint dwDesiredAccessMask, 
                            uint* pdwGrantedAccessMask, int* pbAccessStatus);

///The <b>RSoPSetPolicySettingStatus</b> function creates an instance of RSOP_PolicySettingStatus and an instance of
///RSOP_PolicySettingLink. The function links (associates) <b>RSOP_PolicySettingStatus</b> to its RSOP_PolicySetting
///instance.
///Params:
///    dwFlags = This parameter is currently unused.
///    pServices = Specifies a WMI services pointer to the RSoP namespace to which the policy data is to be written. This parameter
///                is required.
///    pSettingInstance = Pointer to an instance of RSOP_PolicySetting containing the policy setting. This parameter is required and can
///                       point to the instance's children.
///    nInfo = Specifies the number of elements in the <i>pStatus</i> array.
///    pStatus = Pointer to an array of POLICYSETTINGSTATUSINFO structures.
///Returns:
///    If the function succeeds, the return value is <b>S_OK</b>. Otherwise, the function returns one of the COM error
///    codes defined in the Platform SDK header file WinError.h.
///    
@DllImport("USERENV")
HRESULT RsopSetPolicySettingStatus(uint dwFlags, IWbemServices pServices, IWbemClassObject pSettingInstance, 
                                   uint nInfo, POLICYSETTINGSTATUSINFO* pStatus);

///The <b>RSoPResetPolicySettingStatus</b> function unlinks the RSOP_PolicySettingStatus instance from its
///RSOP_PolicySetting instance. The function deletes the instances of <b>RSOP_PolicySettingStatus</b> and
///RSOP_PolicySettingLink. Optionally, you can also specify that the function delete the instance of
///<b>RSOP_PolicySetting</b>.
///Params:
///    dwFlags = This parameter is currently unused.
///    pServices = Specifies a WMI services pointer to the RSoP namespace to which the policy data is to be written. This parameter
///                is required.
///    pSettingInstance = Pointer to an instance of RSOP_PolicySetting containing the policy setting. This parameter is required and can
///                       also point to the instance's children.
///Returns:
///    If the function succeeds, the return value is <b>S_OK</b>. Otherwise, the function returns one of the COM error
///    codes defined in the Platform SDK header file WinError.h.
///    
@DllImport("USERENV")
HRESULT RsopResetPolicySettingStatus(uint dwFlags, IWbemServices pServices, IWbemClassObject pSettingInstance);

@DllImport("USERENV")
uint GenerateGPNotification(BOOL bMachine, const(PWSTR) lpwszMgmtProduct, uint dwMgmtProductOptions);

///The <b>InstallApplication</b> function can install applications that have been deployed to target users that belong
///to a domain. The security context of the user that is calling <b>InstallApplication</b> must be that of a domain user
///logged onto a computer in a domain that trusts the target user's domain. Group Policy must be successfully applied
///when the target user logs on.
///Params:
///    pInstallInfo = A pointer to a INSTALLDATA structure that specifies the application to install.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. Otherwise, the function returns one of the
///    system error codes. For a complete list of error codes, see System Error Codes or the header file WinError.h.
///    
@DllImport("ADVAPI32")
uint InstallApplication(INSTALLDATA* pInstallInfo);

///The <b>UninstallApplication</b> function uninstalls a group policy application that handles setup and installation
///using Windows Installer .msi files. The <b>UninstallApplication</b> function should only be called in the context of
///the user for whom the user group policy application has previously attempted an uninstall by calling the
///MsiConfigureProduct function. The InstallApplication function can install group policy applications. <div
///class="alert"><b>Note</b> Failure to call <b>UninstallApplication</b> as part of the protocol for uninstalling a
///group policy-based application can cause the Resultant Set of Policy (RSoP) to indicate inaccurate
///information.</div><div> </div>
///Params:
///    ProductCode = The Windows Installer product code of the product being uninstalled. The product code of the application should
///                  be provided in the form of a Windows Installer GUID as a string with braces.
///    dwStatus = The status of the uninstall attempt. The <i>dwStatus</i> parameter is the Windows success code of the uninstall
///               attempt returned by MsiConfigureProduct. The system can use this to ensure that the Resultant Set of Policy
///               (RSoP) indicates whether the uninstall failed or succeeded.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. Otherwise, the function returns one of the
///    system error codes. For a complete list of error codes, see System Error Codes or the header file WinError.h.
///    
@DllImport("ADVAPI32")
uint UninstallApplication(PWSTR ProductCode, uint dwStatus);

@DllImport("ADVAPI32")
uint CommandLineFromMsiDescriptor(PWSTR Descriptor, PWSTR CommandLine, uint* CommandLineLength);

///The <b>GetManagedApplications</b> function gets a list of applications that are displayed in the <b>Add</b> pane of
///<b>Add/Remove Programs</b> (ARP) for a specified user context.
///Params:
///    pCategory = A pointer to a GUID that specifies the category of applications to be listed. If <i>pCategory</i> is not null,
///                <i>dwQueryFlags</i> must contain <b>MANAGED_APPS_FROMCATEGORY</b>. If <i>pCategory</i> is null,
///                <i>dwQueryFlags</i> cannot contain <b>MANAGED_APPS_FROMCATEGORY</b>.
///    dwQueryFlags = This parameter can contain one or more of the following values.
///    dwInfoLevel = This parameter must be <b>MANAGED_APPS_INFOLEVEL_DEFAULT</b>.
///    pdwApps = The count of applications in the list returned by this function.
///    prgManagedApps = This parameter is a pointer to an array of MANAGEDAPPLICATION structures. This array contains the list of
///                     applications listed in the <b>Add</b> pane of <b>Add/Remove Programs</b> (ARP). You must call <b>LocalFree</b> to
///                     free the array when they array is no longer required.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. Otherwise, the function returns one of the
///    system error codes. For a complete list of error codes, see System Error Codes or the header file WinError.h.
///    
@DllImport("ADVAPI32")
uint GetManagedApplications(GUID* pCategory, uint dwQueryFlags, uint dwInfoLevel, uint* pdwApps, 
                            MANAGEDAPPLICATION** prgManagedApps);

///The <b>GetLocalManagedApplications</b> function can be run on the target computer to get a list of managed
///applications on that computer. The function can also be called in the context of a user to get a list of managed
///applications for that user. This function only returns applications that can be installed by the Windows Installer.
///Params:
///    bUserApps = A value that, if <b>TRUE</b>, the <i>prgLocalApps</i> parameter contains a list of managed applications that
///                applies to the user. If the value of this parameter is <b>FALSE</b>, the <i>prgLocalApps</i> parameter contains a
///                list of managed applications that applies to the local computer.
///    pdwApps = The address of a <b>DWORD</b> that specifies the number of applications in the list returned by
///              <i>prgLocalApps</i>.
///    prgLocalApps = The address of an array that contains the list of managed applications. You must call <b>LocalFree</b> to free
///                   this array when its contents are no longer required. This parameter cannot be null. The list is returned as a
///                   LOCALMANAGEDAPPLICATION structure.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. Otherwise, the function returns one of the
///    system error codes. For a complete list of error codes, see System Error Codes or the header file WinError.h.
///    
@DllImport("ADVAPI32")
uint GetLocalManagedApplications(BOOL bUserApps, uint* pdwApps, LOCALMANAGEDAPPLICATION** prgLocalApps);

@DllImport("ADVAPI32")
void GetLocalManagedApplicationData(PWSTR ProductCode, PWSTR* DisplayName, PWSTR* SupportUrl);

///The <b>GetManagedApplicationCategories</b> function gets a list of application categories for a domain. The list is
///the same for all users in the domain.
///Params:
///    dwReserved = This parameter is reserved. Its value must be 0.
///    pAppCategory = A APPCATEGORYINFOLIST structure that contains a list of application categories. This structure must be freed by
///                   calling LocalFree when the list is no longer required.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. Otherwise, the function returns one of the
///    system error codes. For a complete list of error codes, see System Error Codes or the header file WinError.h.
///    
@DllImport("ADVAPI32")
uint GetManagedApplicationCategories(uint dwReserved, APPCATEGORYINFOLIST* pAppCategory);

///The <b>CreateGPOLink</b> function creates a link between the specified GPO and the specified site, domain, or
///organizational unit.
///Params:
///    lpGPO = A value that specifies the path to the GPO, in ADSI format ("LDAP://cn=<i>user</i>, ou=<i>users</i>,
///            dc=<i>coname</i>, dc=<i>com</i>"). You cannot specify a server name in this parameter.
///    lpContainer = A value that specifies the Active Directory path to the site, domain, or organizational unit.
///    fHighPriority = A value that specifies the link priority. If this parameter is <b>TRUE</b>, the system creates the link as the
///                    highest priority. If this parameter is <b>FALSE</b>, the system creates the link as the lowest priority.
///Returns:
///    If the function succeeds, the return value is <b>S_OK</b>. Otherwise, the function returns one of the COM error
///    codes defined in the header file WinError.h. Be aware that you should test explicitly for the return value
///    <b>S_OK</b>. Do not use the <b>SUCCEEDED</b> or <b>FAILED</b> macro on the returned <b>HRESULT</b> to determine
///    success or failure of the function.
///    
@DllImport("GPEDIT")
HRESULT CreateGPOLink(PWSTR lpGPO, PWSTR lpContainer, BOOL fHighPriority);

///The <b>DeleteGPOLink</b> function deletes the link between the specified GPO and the specified site, domain, or
///organizational unit.
///Params:
///    lpGPO = A value that specifies the path to the GPO, in ADSI format (LDAP://cn=<i>user</i>, ou=<i>users</i>,
///            dc=<i>coname</i>, dc=<i>com</i>). You cannot specify a server name in this parameter.
///    lpContainer = Specifies the Active Directory path to the site, domain, or organizational unit.
///Returns:
///    If the function succeeds, the return value is <b>S_OK</b>. Otherwise, the function returns one of the COM error
///    codes defined in the header file WinError.h.
///    
@DllImport("GPEDIT")
HRESULT DeleteGPOLink(PWSTR lpGPO, PWSTR lpContainer);

///The <b>DeleteAllGPOLinks</b> function deletes all GPO links for the specified site, domain, or organizational unit.
///Params:
///    lpContainer = A value that specifies the path to the site, domain, or organizational unit, in ADSI format
///                  (LDAP://cn=<i>user</i>, ou=<i>users</i>, dc=<i>coname</i>, dc=<i>com</i>). You cannot specify a server name in
///                  this parameter.
///Returns:
///    If the function succeeds, the return value is <b>S_OK</b>. Otherwise, the function returns one of the COM error
///    codes defined in the header file WinError.h.
///    
@DllImport("GPEDIT")
HRESULT DeleteAllGPOLinks(PWSTR lpContainer);

///The <b>BrowseForGPO</b> function creates a GPO browser dialog box that allows the user to open or create a GPO.
///Params:
///    lpBrowseInfo = A pointer to a GPOBROWSEINFO structure that contains information used to initialize the dialog box. When the
///                   <b>BrowseForGPO</b> function returns, this structure contains information about the user's actions.
///Returns:
///    If the function succeeds, the return value is <b>S_OK</b>. If the user cancels or closes the dialog box, the
///    return value is <b>HRESULT_FROM_WIN32</b>(<b>ERROR_CANCELLED</b>). Otherwise, the function returns one of the COM
///    error codes defined in the header file WinError.h.
///    
@DllImport("GPEDIT")
HRESULT BrowseForGPO(GPOBROWSEINFO* lpBrowseInfo);

///The <b>ImportRSoPData</b> function imports a data file containing RSoP data to a WMI namespace. The file must be one
///generated by a call to the ExportRSoPData function.
///Params:
///    lpNameSpace = Pointer to a string specifying the namespace to contain the RSoP data. The namespace must exist prior to calling
///                  <b>ImportRSoPData</b>.
///    lpFileName = Pointer to a string specifying the name of the file that contains the RSoP data.
///Returns:
///    If the function succeeds, the return value is <b>S_OK</b>. Otherwise, the function returns one of the COM error
///    codes defined in the Platform SDK header file WinError.h.
///    
@DllImport("GPEDIT")
HRESULT ImportRSoPData(PWSTR lpNameSpace, PWSTR lpFileName);

///The <b>ExportRSoPData</b> function exports a WMI namespace that contains RSoP information to a data file. The
///function writes the information to a data file that can be imported to a WMI namespace with a call to the
///ImportRSoPData function.
///Params:
///    lpNameSpace = A pointer to a string that specifies the namespace which contains the RSoP data.
///    lpFileName = A pointer to a string that specifies the name of the file to receive the RSoP data.
///Returns:
///    If the function succeeds, the return value is <b>S_OK</b>. Otherwise, the function returns one of the COM error
///    codes defined in the header file WinError.h.
///    
@DllImport("GPEDIT")
HRESULT ExportRSoPData(PWSTR lpNameSpace, PWSTR lpFileName);


// Interfaces

///The <b>IGPEInformation</b> interface provides methods for Microsoft Management Console (MMC) extension snap-ins to
///communicate with the Group Policy Object Editor. For more information about MMC, see the Microsoft Management
///Console. Note that this interface does not support multithreaded object concurrency.
interface IGPEInformation : IUnknown
{
    ///The <b>GetName</b> method retrieves the unique name for the GPO. This value is usually a GUID.
    ///Params:
    ///    pszName = Receives the GPO name.
    ///    cchMaxLength = Specifies the size, in characters, of the <i>pszName</i> buffer.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT GetName(PWSTR pszName, int cchMaxLength);
    ///The <b>GetDisplayName</b> method retrieves the display name for the GPO.
    ///Params:
    ///    pszName = Receives the display name for the GPO.
    ///    cchMaxLength = Specifies the size, in characters, of the <i>pszName</i> buffer.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT GetDisplayName(PWSTR pszName, int cchMaxLength);
    ///The <b>GetRegistryKey</b> method retrieves a handle to the root of the registry key for the specified section of
    ///the GPO.
    ///Params:
    ///    dwSection = Specifies the GPO section. This parameter can be one of the following values.
    ///    hKey = Receives the handle to the registry key. This handle is opened with all access rights. For more information,
    ///           see Registry Key Security and Access Rights.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h. If registry information is not loaded, the method
    ///    returns <b>E_FAIL</b>.
    ///    
    HRESULT GetRegistryKey(uint dwSection, HKEY* hKey);
    ///The <b>GetDSPath</b> method retrieves the Active Directory path for the specified section of the GPO.
    ///Params:
    ///    dwSection = Specifies the GPO section. This parameter can be one of the following values.
    ///    pszPath = Receives the Active Directory path to the root of the requested section. For more information, see the
    ///              following Remarks section.
    ///    cchMaxPath = Specifies the size, in characters, of the <i>pszPath</i> parameter.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT GetDSPath(uint dwSection, PWSTR pszPath, int cchMaxPath);
    ///The <b>GetFileSysPath</b> method returns the file system path for the specified section of the GPO. The path is
    ///in UNC format.
    ///Params:
    ///    dwSection = Specifies the GPO section. This parameter can be one of the following values.
    ///    pszPath = Receives the file system path.
    ///    cchMaxPath = Specifies the size, in characters, of the <i>pszPath</i> buffer.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT GetFileSysPath(uint dwSection, PWSTR pszPath, int cchMaxPath);
    ///The <b>GetOptions</b> method retrieves the options the user has selected for the Group Policy Object Editor.
    ///Params:
    ///    dwOptions = Receives a bitmask value representing the options the user has selected. Currently, this parameter returns
    ///                only zero.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT GetOptions(uint* dwOptions);
    ///The <b>GetType</b> method retrieves type information for the GPO being edited.
    ///Params:
    ///    gpoType = Receives the GPO type. The system sets this parameter to one of the following values.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT GetType(GROUP_POLICY_OBJECT_TYPE* gpoType);
    ///The <b>GetHint</b> method retrieves the type of Active Directory object to which this GPO can be linked.
    ///Params:
    ///    gpHint = Receives the directory service type. This parameter can be one of the following values.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT GetHint(GROUP_POLICY_HINT_TYPE* gpHint);
    ///The <b>PolicyChanged</b> method informs the Group Policy Object Editor that policy settings have changed.
    ///Params:
    ///    bMachine = Specifies whether computer or user policy has changed. If this value is <b>TRUE</b>, computer policy has
    ///               changed. If this value is <b>FALSE</b>, user policy has changed.
    ///    bAdd = Specifies whether this is an add or delete operation. If this parameter is <b>FALSE</b>, the last policy
    ///           setting for the specified extension <i>pGuidExtension</i> is removed. In all other cases, this parameter is
    ///           <b>TRUE</b>.
    ///    pGuidExtension = Pointer to the <b>GUID</b> or unique name of the snap-in extension that will process policy. If the GPO is to
    ///                     be processed by the snap-in that processes .pol files, this parameter must specify the
    ///                     <b>REGISTRY_EXTENSION_GUID</b> value.
    ///    pGuidSnapin = Pointer to the GUID or unique name of the snap-in extension making this method call.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT PolicyChanged(BOOL bMachine, BOOL bAdd, GUID* pGuidExtension, GUID* pGuidSnapin);
}

///The <b>IGroupPolicyObject</b> interface provides methods to create and modify a GPO directly, without using the Group
///Policy Object Editor. Note that this interface does not support multithreaded object concurrency.
interface IGroupPolicyObject : IUnknown
{
    ///The <b>New</b> method creates a new GPO in the Active Directory with the specified display name. The method opens
    ///the GPO using the OpenDSGPO method.
    ///Params:
    ///    pszDomainName = Specifies the Active Directory path of the object to create. If the path specifies a domain controller, the
    ///                    GPO is created on that DC. Otherwise, the system will select a DC on the caller's behalf.
    ///    pszDisplayName = Specifies the display name of the object to create.
    ///    dwFlags = Specifies whether or not the registry information should be loaded for the GPO. This parameter can be one of
    ///              the following values.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT New(PWSTR pszDomainName, PWSTR pszDisplayName, uint dwFlags);
    ///The <b>OpenDSGPO</b> method opens the specified GPO and optionally loads the registry information.
    ///Params:
    ///    pszPath = Specifies the Active Directory path of the object to open. If the path specifies a domain controller, the GPO
    ///              is created on that DC. Otherwise, the system will select a DC on the caller's behalf.
    ///    dwFlags = Specifies whether or not the registry information should be loaded for the GPO. This parameter can be one of
    ///              the following values.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT OpenDSGPO(PWSTR pszPath, uint dwFlags);
    ///The <b>OpenLocalMachineGPO</b> method opens the default GPO for the computer and optionally loads the registry
    ///information.
    ///Params:
    ///    dwFlags = Specifies whether or not the registry information should be loaded for the GPO. This parameter can be one of
    ///              the following values.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT OpenLocalMachineGPO(uint dwFlags);
    ///The <b>OpenRemoteMachineGPO</b> method opens the default GPO for the specified remote computer and optionally
    ///loads the registry information.
    ///Params:
    ///    pszComputerName = Specifies the name of the computer. The format of the name is &
    ///    dwFlags = Specifies whether or not the registry information should be loaded for the GPO. This parameter can be one of
    ///              the following values.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT OpenRemoteMachineGPO(PWSTR pszComputerName, uint dwFlags);
    ///The <b>Save</b> method saves the specified registry policy settings to disk and updates the revision number of
    ///the GPO.
    ///Params:
    ///    bMachine = Specifies the registry policy settings to be saved. If this parameter is <b>TRUE</b>, the computer policy
    ///               settings are saved. Otherwise, the user policy settings are saved.
    ///    bAdd = Specifies whether this is an add or delete operation. If this parameter is <b>FALSE</b>, the last policy
    ///           setting for the specified extension <i>pGuidExtension</i> is removed. In all other cases, this parameter is
    ///           <b>TRUE</b>.
    ///    pGuidExtension = Specifies the GUID or unique name of the snap-in extension that will process policy. If the GPO is to be
    ///                     processed by the snap-in that processes .pol files, you must specify the REGISTRY_EXTENSION_GUID value.
    ///    pGuid = Specifies the GUID that identifies the MMC snap-in used to edit this policy. The snap-in can be a Microsoft
    ///            snap-in or a third-party snap-in.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT Save(BOOL bMachine, BOOL bAdd, GUID* pGuidExtension, GUID* pGuid);
    ///The <b>Delete</b> method deletes the GPO.
    ///Returns:
    ///    If the function succeeds, the return value is <b>S_OK</b>. Otherwise, the function returns one of the COM
    ///    error codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT Delete();
    ///The <b>GetName</b> method retrieves the unique GPO name. For Active Directory policy objects, the method returns
    ///a GUID. For a local GPO, the method returns the string "Local". For remote objects, <b>GetName</b> returns the
    ///computer name.
    ///Params:
    ///    pszName = Pointer to a buffer that receives the GPO name.
    ///    cchMaxLength = Specifies the size, in characters, of the <i>pszName</i> buffer.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT GetName(PWSTR pszName, int cchMaxLength);
    ///The <b>GetDisplayName</b> method retrieves the display name for the GPO.
    ///Params:
    ///    pszName = Pointer to a buffer that receives the display name.
    ///    cchMaxLength = Specifies the size, in characters, of the <i>pszName</i> buffer.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT GetDisplayName(PWSTR pszName, int cchMaxLength);
    ///The <b>SetDisplayName</b> method sets the display name for the GPO.
    ///Params:
    ///    pszName = Specifies the new display name.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT SetDisplayName(PWSTR pszName);
    ///The <b>GetPath</b> method retrieves the path to the GPO.
    ///Params:
    ///    pszPath = Pointer to a buffer that receives the path. If the GPO is an Active Directory object, the path is in ADSI
    ///              name format. If the GPO is a computer object, this parameter receives a file system path.
    ///    cchMaxLength = Specifies the maximum number of characters that can be stored in the <i>pszPath</i> buffer.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT GetPath(PWSTR pszPath, int cchMaxLength);
    ///The <b>GetDSPath</b> method retrieves the Active Directory path to the root of the specified GPO section.
    ///Params:
    ///    dwSection = Specifies the GPO section. This parameter can be one of the following values.
    ///    pszPath = Pointer to a buffer that receives the path, in ADSI format (LDAP://cn=<i>user</i>, ou=<i>users</i>,
    ///              dc=<i>coname</i>, dc=<i>com</i>).
    ///    cchMaxPath = Specifies the maximum number of characters that can be stored in the <i>pszPath</i> buffer.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT GetDSPath(uint dwSection, PWSTR pszPath, int cchMaxPath);
    ///The <b>GetFileSysPath</b> method retrieves the file system path to the root of the specified GPO section. The
    ///path is in UNC format.
    ///Params:
    ///    dwSection = Specifies the GPO section. This parameter can be one of the following values.
    ///    pszPath = Pointer to a buffer that receives the path.
    ///    cchMaxPath = Specifies the maximum number of characters that can be stored in the <i>pszPath</i> buffer.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT GetFileSysPath(uint dwSection, PWSTR pszPath, int cchMaxPath);
    ///The <b>GetRegistryKey</b> method retrieves a handle to the root of the registry key for the specified GPO
    ///section.
    ///Params:
    ///    dwSection = Specifies the GPO section. This parameter can be one of the following values.
    ///    hKey = Receives a handle to the registry key. This handle is opened with all access rights. For more information,
    ///           see Registry Key Security and Access Rights.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h. If the registry information is not loaded, the
    ///    method returns <b>E_FAIL</b>.
    ///    
    HRESULT GetRegistryKey(uint dwSection, HKEY* hKey);
    ///The <b>GetOptions</b> method retrieves the options for the GPO.
    ///Params:
    ///    dwOptions = Receives the options. This parameter can be one or more of the following options.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT GetOptions(uint* dwOptions);
    ///The <b>SetOptions</b> method sets the options for the GPO.
    ///Params:
    ///    dwOptions = Specifies the new option values. This parameter can be one or more of the following options. For more
    ///                information, see the following Remarks section.
    ///    dwMask = Specifies the options to change. This parameter can be one or more of the following options. For more
    ///             information, see the following Remarks section.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT SetOptions(uint dwOptions, uint dwMask);
    ///The <b>GetType</b> method retrieves type information for the GPO being edited.
    ///Params:
    ///    gpoType = Receives the GPO type. The system sets this parameter to one of the following values.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT GetType(GROUP_POLICY_OBJECT_TYPE* gpoType);
    ///The <b>GetMachineName</b> method retrieves the computer name of the remote GPO. This is the name specified by the
    ///OpenRemoteMachineGPO method.
    ///Params:
    ///    pszName = Pointer to a buffer that receives the computer name.
    ///    cchMaxLength = Specifies the size, in characters, of the <i>pszName</i> buffer.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT GetMachineName(PWSTR pszName, int cchMaxLength);
    ///The <b>GetPropertySheetPages</b> method retrieves the property sheet pages associated with the GPO.
    ///Params:
    ///    hPages = Address of the pointer to an array of property sheet pages.
    ///    uPageCount = Receives the number of pages in the property sheet array.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT GetPropertySheetPages(HPROPSHEETPAGE** hPages, uint* uPageCount);
}

///The <b>IRSOPInformation</b> interface provides methods for Microsoft Management Console (MMC) extension snap-ins to
///communicate with the main Resultant Set of Policy (RSoP) snap-in. For more information about MMC, see the Microsoft
///Management Console.
interface IRSOPInformation : IUnknown
{
    ///The <b>GetNameSpace</b> method retrieves the namespace from which the RSoP data is being displayed.
    ///Params:
    ///    dwSection = Specifies the GPO section. This parameter can be one of the following values.
    ///    pszName = Receives the namespace from which the RSoP data is being displayed. The computer and user RSoP data are in
    ///              sub-namespaces under this namespace. Computer RSoP data is under the Computer sub-namespace, and user RSoP
    ///              data is under the User sub-namespace.
    ///    cchMaxLength = Specifies the size, in characters, of the <i>pszName</i> buffer.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT GetNamespace(uint dwSection, PWSTR pszName, int cchMaxLength);
    ///The <b>GetFlags</b> method retrieves information about the RSoP user interface session.
    ///Params:
    ///    pdwFlags = Receives a pointer to a value that contains information about the RSoP session. This parameter can be the
    ///               following value.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT GetFlags(uint* pdwFlags);
    ///The <b>GetEventLogEntryText</b> method returns the text for a specific entry in the event log.
    ///Params:
    ///    pszEventSource = Specifies the name of the source (application, service, driver, subsystem) that generated the log entry.
    ///    pszEventLogName = Specifies the name of the event log.
    ///    pszEventTime = Specifies the time the event was logged, in Windows Management Instrumentation (WMI) format. For more
    ///                   information, see Date and Time Format in the WMI documentation.
    ///    dwEventID = Specifies the event ID.
    ///    ppszText = Receives the pointer to a buffer containing the text of the event log entry. The calling application must
    ///               free the memory allocated for this buffer with a call to the CoTaskMemFree function.
    ///Returns:
    ///    If the method succeeds, the return value is <b>S_OK</b>. Otherwise, the method returns one of the COM error
    ///    codes defined in the Platform SDK header file WinError.h.
    ///    
    HRESULT GetEventLogEntryText(PWSTR pszEventSource, PWSTR pszEventLogName, PWSTR pszEventTime, uint dwEventID, 
                                 PWSTR* ppszText);
}


