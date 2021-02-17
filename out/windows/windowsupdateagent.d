// Written in the D programming language.

module windows.windowsupdateagent;

public import windows.core;
public import windows.automation : BSTR, IDispatch, VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : DECIMAL;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Enums


///Defines the possible ways in which elevated users are notified about Automatic Updates events.
enum AutomaticUpdatesNotificationLevel : int
{
    ///Automatic Updates is not configured by the user or by a Group Policy administrator. Users are periodically
    ///prompted to configure Automatic Updates.
    aunlNotConfigured            = 0x00000000,
    ///Automatic Updates is disabled. Users are not notified of important updates for the computer.
    aunlDisabled                 = 0x00000001,
    ///Automatic Updates prompts users to approve updates before it downloads or installs the updates.
    aunlNotifyBeforeDownload     = 0x00000002,
    ///Automatic Updates automatically downloads updates, but prompts users to approve the updates before installation.
    aunlNotifyBeforeInstallation = 0x00000003,
    aunlScheduledInstallation    = 0x00000004,
}

///Defines the days of the week when Automatic Updates installs or uninstalls updates.
enum AutomaticUpdatesScheduledInstallationDay : int
{
    ///Every day.
    ausidEveryDay       = 0x00000000,
    ///Every Sunday.
    ausidEverySunday    = 0x00000001,
    ///Every Monday.
    ausidEveryMonday    = 0x00000002,
    ///Every Tuesday.
    ausidEveryTuesday   = 0x00000003,
    ///Every Wednesday.
    ausidEveryWednesday = 0x00000004,
    ///Every Thursday.
    ausidEveryThursday  = 0x00000005,
    ///Every Friday.
    ausidEveryFriday    = 0x00000006,
    ///Every Saturday.
    ausidEverySaturday  = 0x00000007,
}

///Defines the progress of the download of the current update that is returned by the CurrentUpdateDownloadPhase
///property of the IDownloadProgress interface.
enum DownloadPhase : int
{
    ///Initializing the download of the current update.
    dphInitializing = 0x00000001,
    ///Downloading the current update.
    dphDownloading  = 0x00000002,
    dphVerifying    = 0x00000003,
}

///Defines the possible priorities for a download operation.
enum DownloadPriority : int
{
    ///Updates are downloaded as low priority.
    dpLow       = 0x00000001,
    ///Updates are downloaded as normal priority.
    dpNormal    = 0x00000002,
    ///Updates are downloaded as high priority.
    dpHigh      = 0x00000003,
    dpExtraHigh = 0x00000004,
}

///Defines the types of logic that is used to determine whether a particular update will be automatically selected when
///the user views available updates in the Windows Update user interface.
enum AutoSelectionMode : int
{
    ///Use the standard logic. The update will be automatically selected if it is important, or if it is recommended and
    ///Windows Update has been configured to treat recommended updates as important. Otherwise, the update will not be
    ///automatically selected.
    asLetWindowsUpdateDecide = 0x00000000,
    ///The update will be automatically selected only if it has been completely downloaded.
    asAutoSelectIfDownloaded = 0x00000001,
    ///The update will never be automatically selected.
    asNeverAutoSelect        = 0x00000002,
    ///The update will always be automatically selected.
    asAlwaysAutoSelect       = 0x00000003,
}

///Defines the types of logic that is used to determine whether Automatic Updates will automatically download an update
///once it is determined to be applicable for the computer.
enum AutoDownloadMode : int
{
    ///Use the standard logic. The update will be automatically downloaded if it is important, or if it is recommended
    ///and Windows Update has been configured to treat recommended updates as important. Otherwise, the update will not
    ///be automatically downloaded.
    adLetWindowsUpdateDecide = 0x00000000,
    ///The update will not be automatically downloaded; it will be downloaded only when the user attempts to install the
    ///update, or when a Windows Update Agent (WUA) API caller requests that the update be downloaded by using the
    ///IUpdateDownloader::Download or IUpdateDownloader::BeginDownload methods.
    adNeverAutoDownload      = 0x00000001,
    ///The update will always be automatically downloaded.
    adAlwaysAutoDownload     = 0x00000002,
}

///Defines the possible levels of impact that can be caused by installing or uninstalling an update.
enum InstallationImpact : int
{
    ///Installing or uninstalling an update results in a level of impact on the target computer that is typical of most
    ///updates. Therefore, the update does not qualify for any of the special impact ratings that are defined in this
    ///topic.
    iiNormal                    = 0x00000000,
    ///Installing or uninstalling an update results in an insignificant impact on the target computer. The update must
    ///meet strict requirements to qualify for this rating. The requirements include, but are not limited to, the
    ///following requirements: <ul> <li>It must not perform or require a system restart.</li> <li>It must not display a
    ///user interface.</li> <li>The installation or uninstallation must succeed even if it affects an application or
    ///service that is currently being used.</li> </ul> Updates that qualify for this rating may be eligible for special
    ///handling in Windows Update Agent (WUA). For example, they may be eligible for accelerated distribution.
    iiMinor                     = 0x00000001,
    iiRequiresExclusiveHandling = 0x00000002,
}

///The <b>InstallationRebootBehavior</b> enumeration defines the possible restart behaviors for an update. The
///<b>InstallationRebootBehavior</b> enumeration applies to the installation and uninstallation of updates.
enum InstallationRebootBehavior : int
{
    ///The update never requires a system restart during or after an installation or an uninstallation.
    irbNeverReboots         = 0x00000000,
    ///The update always requires a system restart after a successful installation or uninstallation.
    irbAlwaysRequiresReboot = 0x00000001,
    irbCanRequestReboot     = 0x00000002,
}

///Defines the possible results of a download, install, uninstall, or verification operation on an update.
enum OperationResultCode : int
{
    ///The operation is not started.
    orcNotStarted          = 0x00000000,
    ///The operation is in progress.
    orcInProgress          = 0x00000001,
    ///The operation was completed successfully.
    orcSucceeded           = 0x00000002,
    ///The operation is complete, but one or more errors occurred during the operation. The results might be incomplete.
    orcSucceededWithErrors = 0x00000003,
    ///The operation failed to complete.
    orcFailed              = 0x00000004,
    orcAborted             = 0x00000005,
}

///Defines the update services that Windows Update can operate against.
enum ServerSelection : int
{
    ///Used only by IUpdateSearcher. Indicates that the search call should search the default server. The default server
    ///used by the Windows Update Agent (WUA) is the same as <b>ssMangagedServer</b> if the computer is set up to have a
    ///managed server. If the computer is not been set up to have a managed server, WUA uses the first update service
    ///for which the IsRegisteredWithAU property of IUpdateService is VARIANT_TRUE and the IsManaged property of
    ///<b>IUpdateService</b> is VARIANT_FALSE
    ssDefault       = 0x00000000,
    ///Indicates the managed server, in an environment that uses Windows Server Update Services or a similar corporate
    ///update server to manage the computer.
    ssManagedServer = 0x00000001,
    ///Indicates the Windows Update service.
    ssWindowsUpdate = 0x00000002,
    ssOthers        = 0x00000003,
}

///Defines the types of update, such as a driver or software update.
enum UpdateType : int
{
    ///Indicates that the update is a software update.
    utSoftware = 0x00000001,
    ///Indicates that the update is a driver update.
    utDriver   = 0x00000002,
}

///Defines operations that can be attempted on an update.
enum UpdateOperation : int
{
    ///Under the security context of the caller, install the update on the target computer.
    uoInstallation   = 0x00000001,
    uoUninstallation = 0x00000002,
}

///Defines the action for which an update is explicitly deployed.
enum DeploymentAction : int
{
    ///No explicit deployment action is specified on the update. The update inherits the value from its bundled updates.
    daNone                 = 0x00000000,
    ///The update should be installed on the computer and/or for the specified user.
    daInstallation         = 0x00000001,
    ///The update should be uninstalled from the computer and/or for the specified user.
    daUninstallation       = 0x00000002,
    daDetection            = 0x00000003,
    daOptionalInstallation = 0x00000004,
}

///Defines the context in which an IUpdateException object can be provided.
enum UpdateExceptionContext : int
{
    ///The IUpdateException is not tied to any context.
    uecGeneral          = 0x00000001,
    ///The IUpdateException is related to one or more Windows drivers.
    uecWindowsDriver    = 0x00000002,
    ///The IUpdateException is related to Windows Installer.
    uecWindowsInstaller = 0x00000003,
    uecSearchIncomplete = 0x00000004,
}

///Defines the type of user.
enum AutomaticUpdatesUserType : int
{
    ///The context of the current user.
    auutCurrentUser        = 0x00000001,
    ///Any administrator on the local computer.
    auutLocalAdministrator = 0x00000002,
}

///Defines the possible ways to set the NotificationLevel property of the IAutomaticUpdatesSettings interface or the
///IncludeRecommendedUpdates property of the IAutomaticUpdatesSettings2 interface.
enum AutomaticUpdatesPermissionType : int
{
    ///The ability to set the IAutomaticUpdatesSettings::NotificationLevel property.
    auptSetNotificationLevel         = 0x00000001,
    ///The ability to set the IAutomaticUpdatesSettings::NotificationLevel property to aunlDisabled.
    auptDisableAutomaticUpdates      = 0x00000002,
    ///The ability to set the IAutomaticUpdatesSettings2::IncludedRecommendedUpdates property.
    auptSetIncludeRecommendedUpdates = 0x00000003,
    ///The ability to set the IAutomaticUpdatesSettings3::FeaturedUpdatesEnabled property.
    auptSetFeaturedUpdatesEnabled    = 0x00000004,
    ///The ability to set the IAutomaticUpdatesSettings3::NonAdministratorsElevated property.
    auptSetNonAdministratorsElevated = 0x00000005,
}

///Defines the possible states for an update service.
enum UpdateServiceRegistrationState : int
{
    ///The service is not registered.
    usrsNotRegistered       = 0x00000001,
    ///The service is pending registration. Registration will be attempted the next time the update agent contacts an
    ///update service.
    usrsRegistrationPending = 0x00000002,
    usrsRegistered          = 0x00000003,
}

///Defines the variety of updates that should be returned by the search: per-machine updates, per-user updates, or both.
enum SearchScope : int
{
    ///Search by using the default scope (the scope that Automatic Updates would use when searching for updates). This
    ///is currently equivalent to search ScopeMachineOnly.
    searchScopeDefault               = 0x00000000,
    ///Search only for per-machine updates; exclude all per-user updates.
    searchScopeMachineOnly           = 0x00000001,
    ///Search only for per-user updates applicable to the calling user – the user who owns the process which is making
    ///the Windows Update Agent (WUA) API call.
    searchScopeCurrentUserOnly       = 0x00000002,
    ///[Not currently supported.] Search for per-machine updates and for per-user updates applicable to the current
    ///user.
    searchScopeMachineAndCurrentUser = 0x00000003,
    ///[Not currently supported.] Search for per-machine updates and for per-user updates applicable to any known user
    ///accounts on the computer.
    searchScopeMachineAndAllUsers    = 0x00000004,
    ///[Not currently supported.] Search only for per-user updates applicable to any known user accounts on the
    ///computer.
    searchScopeAllUsers              = 0x00000005,
}

///Defines the functionality that the Windows Update Agent (WUA) object can access from Windows Update.
enum UpdateLockdownOption : int
{
    ///If access is from Windows Update, restrict access to the WUA interfaces that implement the IUpdateLockdown
    ///interface.
    uloForWebsiteAccess = 0x00000001,
}

///Defines the possible ways in which the IUpdateServiceManager2 interface can process service registration requests.
enum AddServiceFlag : int
{
    ///Allows the update agent to process the service registration at a later time, when it next performs an online scan
    ///for updates.
    asfAllowPendingRegistration = 0x00000001,
    ///Allows the update agent to process the service registration immediately if network connectivity is available.
    asfAllowOnlineRegistration  = 0x00000002,
    ///Registers the service with Automatic Updates when the service is added.
    asfRegisterServiceWithAU    = 0x00000004,
}

///Defines the options that affect how the service registration for a scan package service is removed.
enum UpdateServiceOption : int
{
    ///Indicates that you must call the IUpdateServiceManager::RemoveService method to remove the service registration.
    ///Failure to call the RemoveService method before releasing the IUpdateService interface causes a resource leak.
    usoNonVolatileService = 0x00000001,
}

// Interfaces

@GUID("72C97D74-7C3B-40AE-B77D-ABDB22EBA6FB")
struct StringCollection;

@GUID("B699E5E8-67FF-4177-88B0-3684A3388BFB")
struct UpdateSearcher;

@GUID("650503CF-9108-4DDC-A2CE-6C2341E1C582")
struct WebProxy;

@GUID("C01B9BA0-BEA7-41BA-B604-D0A36F469133")
struct SystemInformation;

@GUID("C2E88C2F-6F5B-4AAA-894B-55C847AD3A2D")
struct WindowsUpdateAgentInfo;

@GUID("BFE18E9C-6D87-4450-B37C-E02F0B373803")
struct AutomaticUpdates;

@GUID("13639463-00DB-4646-803D-528026140D88")
struct UpdateCollection;

@GUID("5BAF654A-5A07-4264-A255-9FF54C7151E7")
struct UpdateDownloader;

@GUID("D2E0FE7F-D23E-48E1-93C0-6FA8CC346474")
struct UpdateInstaller;

@GUID("4CB43D7F-7EEE-4906-8698-60DA1C38F2FE")
struct UpdateSession;

@GUID("F8D253D9-89A4-4DAA-87B6-1168369F0B21")
struct UpdateServiceManager;

@GUID("317E92FC-1679-46FD-A0B5-F08914DD8623")
struct InstallationAgent;

///Restricts access to methods and properties of objects that implements the method of this interface.
@GUID("A976C28D-75A1-42AA-94AE-8AF8B872089A")
interface IUpdateLockdown : IUnknown
{
    ///Restricts access to the methods and properties of the object that implements this method.
    ///Params:
    ///    flags = The option to restrict access to various Windows Update Agent (WUA) objects from the Windows Update website.
    ///            Setting this parameter to <b>uloForWebsiteAccess</b> or to 1 (one) restricts access to the WUA interfaces
    ///            that implement the IUpdateLockdown interface. For a list of the methods and properties that the WUA
    ///            interfaces restrict when this value is specified, see the "Remarks" section.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT LockDown(int flags);
}

///Represents an ordered list of strings.
@GUID("EFF90582-2DDC-480F-A06D-60F3FBC362C3")
interface IStringCollection : IDispatch
{
    ///Gets or sets a string in the collection. This property is read/write.
    HRESULT get_Item(int index, BSTR* retval);
    ///Gets or sets a string in the collection. This property is read/write.
    HRESULT put_Item(int index, BSTR value);
    ///Gets an IEnumVARIANT interface that can be used to enumerate the collection. This property is read-only.
    HRESULT get__NewEnum(IUnknown* retval);
    ///Gets the number of elements in the collection. This property is read-only.
    HRESULT get_Count(int* retval);
    ///Gets a Boolean value that indicates whether the collection is read-only. This property is read-only.
    HRESULT get_ReadOnly(short* retval);
    ///Adds an item to the collection.
    ///Params:
    ///    value = A string to be added to the collection.
    ///    retval = The index of the added interface in the collection.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter value is invalid or
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_NOT_SUPPORTED</b></dt> </dl> </td> <td
    ///    width="60%"> The collection is read-only. </td> </tr> </table>
    ///    
    HRESULT Add(BSTR value, int* retval);
    ///Removes all the elements from the collection.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WU_E_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The collection is
    ///    read-only. </td> </tr> </table>
    ///    
    HRESULT Clear();
    ///Creates a deep read/write copy of the collection.
    ///Params:
    ///    retval = A deep read/write copy of the collection.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter value is invalid or
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT Copy(IStringCollection* retval);
    ///Inserts an item into the collection at the specified position.
    ///Params:
    ///    index = The position at which a new string is inserted.
    ///    value = The string to be inserted.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WU_E_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The collection is
    ///    read-only. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_INVALIDINDEX</b></dt> </dl> </td> <td
    ///    width="60%"> An index is invalid. </td> </tr> </table>
    ///    
    HRESULT Insert(int index, BSTR value);
    ///Removes the item at the specified index from the collection.
    ///Params:
    ///    index = The index of the string to be removed.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WU_E_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The collection is
    ///    read-only. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_INVALIDINDEX</b></dt> </dl> </td> <td
    ///    width="60%"> An index is invalid. </td> </tr> </table>
    ///    
    HRESULT RemoveAt(int index);
}

///Contains the HTTP proxy settings. <div class="alert"><b>Important</b> This interface is not supported on Windows 10
///and Windows Server 2016. See the remarks for more details.</div><div> </div>
@GUID("174C81FE-AECD-4DAE-B8A0-2C6318DD86A8")
interface IWebProxy : IDispatch
{
    ///Gets and sets the address and the decimal port number of the proxy server. This property is read/write.
    HRESULT get_Address(BSTR* retval);
    ///Gets and sets the address and the decimal port number of the proxy server. This property is read/write.
    HRESULT put_Address(BSTR value);
    ///Gets and sets a collection of addresses that do not use the proxy server. This property is read/write.
    HRESULT get_BypassList(IStringCollection* retval);
    ///Gets and sets a collection of addresses that do not use the proxy server. This property is read/write.
    HRESULT put_BypassList(IStringCollection value);
    ///Gets and sets a Boolean value that indicates whether local addresses bypass the proxy server. This property is
    ///read/write.
    HRESULT get_BypassProxyOnLocal(short* retval);
    ///Gets and sets a Boolean value that indicates whether local addresses bypass the proxy server. This property is
    ///read/write.
    HRESULT put_BypassProxyOnLocal(short value);
    ///Gets a Boolean value that indicates whether the WebProxy object is read-only. This property is read-only.
    HRESULT get_ReadOnly(short* retval);
    ///Gets and sets the user name to submit to the proxy server for authentication. This property is read/write.
    HRESULT get_UserName(BSTR* retval);
    ///Gets and sets the user name to submit to the proxy server for authentication. This property is read/write.
    HRESULT put_UserName(BSTR value);
    ///Sets the password to submit to the proxy server for authentication.
    ///Params:
    ///    value = The password to submit to the proxy server for authentication.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT SetPassword(BSTR value);
    ///Prompts the user for the password to use for proxy authentication.
    ///Params:
    ///    parentWindow = The parent window of the dialog box in which the user enters the credentials.
    ///    title = The title to use for the dialog box in which the user enters the credentials.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT PromptForCredentials(IUnknown parentWindow, BSTR title);
    ///Prompts the user for a password to use for proxy authentication using the <b>hWnd</b> property of the parent
    ///window.
    ///Params:
    ///    parentWindow = The parent window of the dialog box in which the user enters the credentials.
    ///    title = The title to use for the dialog box in which the user enters the credentials.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT PromptForCredentialsFromHwnd(HWND parentWindow, BSTR title);
    ///Gets and sets a Boolean value that indicates whether IWebProxy automatically detects proxy settings. This
    ///property is read/write.
    HRESULT get_AutoDetect(short* retval);
    ///Gets and sets a Boolean value that indicates whether IWebProxy automatically detects proxy settings. This
    ///property is read/write.
    HRESULT put_AutoDetect(short value);
}

///Contains information about the specified computer. This information is relevant to the Windows Update Agent (WUA).
@GUID("ADE87BF7-7B56-4275-8FAB-B9B0E591844B")
interface ISystemInformation : IDispatch
{
    ///Gets a hyperlink to technical support information for OEM hardware. This property is read-only.
    HRESULT get_OemHardwareSupportLink(BSTR* retval);
    ///Gets a Boolean value that indicates whether a system restart is required to complete the installation or
    ///uninstallation of one or more updates. This property is read-only.
    HRESULT get_RebootRequired(short* retval);
}

///Retrieves information about the version of Windows Update Agent (WUA).
@GUID("85713FA1-7796-4FA2-BE3B-E2D6124DD373")
interface IWindowsUpdateAgentInfo : IDispatch
{
    ///Retrieves version information about Windows Update Agent (WUA).
    ///Params:
    ///    varInfoIdentifier = A literal string value that specifies the type of information that the <i>retval</i> parameter returns. The
    ///                        following table lists the current possible string values. <table> <tr> <td><b>ApiMajorVersion</b></td>
    ///                        <td>Retrieves the current major version of WUA.</td> </tr> <tr> <td><b>ApiMinorVersion</b></td> <td>Retrieves
    ///                        the current minor version of WUA.</td> </tr> <tr> <td><b>ProductVersionString</b></td> <td>Retrieves the file
    ///                        version of the Wuapi.dll file in string format.</td> </tr> </table>
    ///    retval = <ul> <li>Returns the major version of the WUA API as a <b>LONG</b> value within the <b>VARIANT</b> variable
    ///             if the value of the <i>varInfoIdentifier</i> parameter is <b>ApiMajorVersion</b>.</li> <li>Returns the minor
    ///             version of the WUA API as a <b>LONG</b> value within the <b>VARIANT</b> variable if the value of
    ///             <i>varInfoIdentifier</i> is <b>ApiMinorVersion</b>.</li> <li>Returns the file version of the Wuapi.dll file
    ///             as a <b>BSTR</b> value within the <b>VARIANT</b> variable if the value of <i>varInfoIdentifier</i> is
    ///             <b>ProductVersionString</b>.</li> </ul> <div class="alert"><b>Note</b> The format of a returned string is as
    ///             follows:
    ///             "<i>&lt;Windows-major-version&gt;</i>.<i>&lt;Windows-minor-version&gt;</i>.<i>&lt;build&gt;</i>.<i>&lt;update&gt;</i>".</div>
    ///             <div> </div>
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT GetInfo(VARIANT varInfoIdentifier, VARIANT* retval);
}

///Contains the read-only properties that describe Automatic Updates.
@GUID("E7A4D634-7942-4DD9-A111-82228BA33901")
interface IAutomaticUpdatesResults : IDispatch
{
    ///Gets the last time and Coordinated Universal Time (UTC) date when AutomaticUpdates successfully searched for
    ///updates. This property is read-only.
    HRESULT get_LastSearchSuccessDate(VARIANT* retval);
    ///Gets the last time and Coordinated Universal Time (UTC) date when Automatic Updates successfully installed any
    ///updates, even if some failures occurred. This property is read-only.
    HRESULT get_LastInstallationSuccessDate(VARIANT* retval);
}

///Contains the settings that are available in Automatic Updates.
@GUID("2EE48F22-AF3C-405F-8970-F71BE12EE9A2")
interface IAutomaticUpdatesSettings : IDispatch
{
    ///<p class="CCE_Message">[<b>Set</b> is no longer supported. Starting with Windows 10 calls to <b>Set</b> always
    ///return <b>S_OK</b>, but do nothing.] Gets and sets how users are notified about Automatic Update events. This
    ///property is read/write.
    HRESULT get_NotificationLevel(AutomaticUpdatesNotificationLevel* retval);
    ///<p class="CCE_Message">[<b>Set</b> is no longer supported. Starting with Windows 10 calls to <b>Set</b> always
    ///return <b>S_OK</b>, but do nothing.] Gets and sets how users are notified about Automatic Update events. This
    ///property is read/write.
    HRESULT put_NotificationLevel(AutomaticUpdatesNotificationLevel value);
    ///<p class="CCE_Message">[<b>IAutomaticUpdatesSettings::ReadOnly</b> is no longer supported. Starting with Windows
    ///10 calls to <b>ReadOnly</b> always return <b>VARIANT_FALSE</b>. However, <b>IAutomaticUpdatesSettings::Save</b>
    ///is a no-op, so no changes can be made.] Gets a Boolean value that indicates whether the Automatic Update settings
    ///are read-only. This property is read-only.
    HRESULT get_ReadOnly(short* retval);
    ///Gets a Boolean value that indicates whether Group Policy requires the Automatic Updates service. This property is
    ///read-only.
    HRESULT get_Required(short* retval);
    ///<p class="CCE_Message">[<b>IAutomaticUpdatesSettings::ScheduledInstallationDay</b> is no longer supported as of
    ///Windows 10.] Gets and sets the days of the week on which Automatic Updates installs or uninstalls updates. This
    ///property is read/write.
    HRESULT get_ScheduledInstallationDay(AutomaticUpdatesScheduledInstallationDay* retval);
    ///<p class="CCE_Message">[<b>IAutomaticUpdatesSettings::ScheduledInstallationDay</b> is no longer supported as of
    ///Windows 10.] Gets and sets the days of the week on which Automatic Updates installs or uninstalls updates. This
    ///property is read/write.
    HRESULT put_ScheduledInstallationDay(AutomaticUpdatesScheduledInstallationDay value);
    ///<p class="CCE_Message">[<b>IAutomaticUpdatesSettings::ScheduledInstallationTime</b> is no longer supported as of
    ///Windows 10.] Gets and sets the time at which Automatic Updates installs or uninstalls updates. This property is
    ///read/write.
    HRESULT get_ScheduledInstallationTime(int* retval);
    ///<p class="CCE_Message">[<b>IAutomaticUpdatesSettings::ScheduledInstallationTime</b> is no longer supported as of
    ///Windows 10.] Gets and sets the time at which Automatic Updates installs or uninstalls updates. This property is
    ///read/write.
    HRESULT put_ScheduledInstallationTime(int value);
    ///Retrieves the latest Automatic Updates settings.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT Refresh();
    ///<p class="CCE_Message">[<b>AutomaticUpdatesSettings::Save</b> is no longer supported. Starting with Windows 10
    ///calls to <b>Save</b> always return <b>S_OK</b>, but do nothing.] Applies the current Automatic Updates settings.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT Save();
}

///Contains the settings that are available in Automatic Updates.
@GUID("6ABC136A-C3CA-4384-8171-CB2B1E59B8DC")
interface IAutomaticUpdatesSettings2 : IAutomaticUpdatesSettings
{
    ///<p class="CCE_Message">[<b>Set</b> is no longer supported. Also, starting with Windows 10 calls to <b>Get</b>
    ///always return <b>VARIANT_TRUE</b> (include recommended updates). ] Gets and sets a Boolean value that indicates
    ///whether to include optional or recommended updates when a search for updates and installation of updates is
    ///performed. This property is read/write.
    HRESULT get_IncludeRecommendedUpdates(short* retval);
    ///<p class="CCE_Message">[<b>Set</b> is no longer supported. Also, starting with Windows 10 calls to <b>Get</b>
    ///always return <b>VARIANT_TRUE</b> (include recommended updates). ] Gets and sets a Boolean value that indicates
    ///whether to include optional or recommended updates when a search for updates and installation of updates is
    ///performed. This property is read/write.
    HRESULT put_IncludeRecommendedUpdates(short value);
    ///<p class="CCE_Message">[<b>IAutomaticUpdatesSettings2::CheckPermission</b> is no longer supported. Starting with
    ///Windows 10 calls to <b>CheckPermission</b> always return <b>S_OK</b>, and a return value of <b>VARIANT_TRUE</b>
    ///(users have permissions). However, <b>IAutomaticUpdatesSettings::Save</b> is a no-op, so no changes can be made.]
    ///Determines whether a specific user or type of user has permission to perform a selected action.
    ///Params:
    ///    userType = An enumeration that indicates the type of user to verify permissions.
    ///    permissionType = An enumeration that indicates the user's permission level.
    ///    userHasPermission = True if the user has the specified permission type; otherwise, false.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT CheckPermission(AutomaticUpdatesUserType userType, AutomaticUpdatesPermissionType permissionType, 
                            short* userHasPermission);
}

///Contains the settings that are available in Automatic Updates.
@GUID("B587F5C3-F57E-485F-BBF5-0D181C5CD0DC")
interface IAutomaticUpdatesSettings3 : IAutomaticUpdatesSettings2
{
    ///<p class="CCE_Message">[<b>Set</b> is no longer supported. Also, starting with Windows 10 calls to <b>Get</b>
    ///always return <b>VARIANT_TRUE</b>.] Gets and sets a Boolean value that indicates whether non-administrators can
    ///perform some update-related actions without administrator approval. This property is read/write.
    HRESULT get_NonAdministratorsElevated(short* retval);
    ///<p class="CCE_Message">[<b>Set</b> is no longer supported. Also, starting with Windows 10 calls to <b>Get</b>
    ///always return <b>VARIANT_TRUE</b>.] Gets and sets a Boolean value that indicates whether non-administrators can
    ///perform some update-related actions without administrator approval. This property is read/write.
    HRESULT put_NonAdministratorsElevated(short value);
    ///Not supported. This property is read/write.
    HRESULT get_FeaturedUpdatesEnabled(short* retval);
    ///Not supported. This property is read/write.
    HRESULT put_FeaturedUpdatesEnabled(short value);
}

///Contains the functionality of Automatic Updates.
@GUID("673425BF-C082-4C7C-BDFD-569464B8E0CE")
interface IAutomaticUpdates : IDispatch
{
    ///Begins the Automatic Updates detection task if Automatic Updates is enabled. If any updates are detected, the
    ///installation behavior is determined by the NotificationLevel property of the IAutomaticUpdatesSettings interface.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WU_E_AU_NOSERVICE</b></dt> </dl> </td> <td width="60%"> Automatic Updates is not
    ///    enabled. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_AU_PAUSED</b></dt> </dl> </td> <td width="60%">
    ///    Automatic Updates is paused. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_LEGACYSERVER</b></dt> </dl>
    ///    </td> <td width="60%"> You cannot search for updates if the following conditions are true: <ul> <li>The
    ///    ServerSelection property of the IUpdateSearcher interface is set to ssManagedServer or ssDefault.</li>
    ///    <li>The managed server on a computer is a Microsoft Software Update Services (SUS) version 1.0 server.</li>
    ///    </ul> </td> </tr> </table>
    ///    
    HRESULT DetectNow();
    ///<p class="CCE_Message">[<b>IAutomaticUpdates::Pause</b> is no longer supported. Starting with Windows 10 calls to
    ///<b>Pause</b> always return <b>S_OK</b>, but do nothing.] Pauses automatic updates.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> This method cannot be called
    ///    from a remote computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_INVALID_OPERATION</b></dt> </dl>
    ///    </td> <td width="60%"> The computer could not access the update site. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WU_E_AU_NOSERVICE</b></dt> </dl> </td> <td width="60%"> Automatic Updates is not enabled. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>WU_E_AU_PAUSED</b></dt> </dl> </td> <td width="60%"> Automatic Updates is
    ///    paused. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_LEGACYSERVER</b></dt> </dl> </td> <td width="60%">
    ///    You cannot search for updates if the following conditions are true: <ul> <li>The ServerSelection property of
    ///    the IUpdateSearcher interface is set to ssManagedServer or ssDefault.</li> <li>The managed server on a
    ///    computer is a Microsoft Software Update Services (SUS) 1.0 server.</li> </ul> </td> </tr> </table>
    ///    
    HRESULT Pause();
    ///<p class="CCE_Message">[<b>IAutomaticUpdates::Resume</b> is no longer supported. Starting with Windows 10 calls
    ///to <b>Resume</b> always return <b>S_OK</b>, but do nothing.] Restarts automatic updating if automatic updating is
    ///paused.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> This method cannot be called
    ///    from a remote computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_INVALID_OPERATION</b></dt> </dl>
    ///    </td> <td width="60%"> The computer could not access the update site. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WU_E_AU_NOSERVICE</b></dt> </dl> </td> <td width="60%"> Automatic Updates is not enabled. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>WU_E_AU_PAUSED</b></dt> </dl> </td> <td width="60%"> Automatic Updates is
    ///    paused. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_LEGACYSERVER</b></dt> </dl> </td> <td width="60%">
    ///    You cannot search for updates if the following conditions are true: <ul> <li>The ServerSelection property of
    ///    the IUpdateSearcher interface is set to ssManagedServer or ssDefault.</li> <li>The managed server on a
    ///    computer is a Microsoft Software Update Services (SUS) 1.0 server.</li> </ul> </td> </tr> </table>
    ///    
    HRESULT Resume();
    ///<p class="CCE_Message">[<b>IAutomaticUpdates::ShowSettingsDialog</b> is no longer supported. Starting with
    ///Windows 10 calls to <b>ShowSettingsDialog</b> always return <b>S_OK</b>, but do nothing.] Displays a dialog box
    ///that contains settings for Automatic Updates.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> This method cannot be called
    ///    from a remote computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_AU_NOSERVICE</b></dt> </dl> </td>
    ///    <td width="60%"> Automatic Updates is not enabled. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WU_E_AU_PAUSED</b></dt> </dl> </td> <td width="60%"> Automatic Updates is paused. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WU_E_LEGACYSERVER</b></dt> </dl> </td> <td width="60%"> You cannot search for
    ///    updates if the following conditions are true: <ul> <li>The ServerSelection property of the IUpdateSearcher
    ///    interface is set to ssManagedServer or ssDefault.</li> <li>The managed server on a computer is a Microsoft
    ///    Software Update Services (SUS) 1.0 server.</li> </ul> </td> </tr> </table>
    ///    
    HRESULT ShowSettingsDialog();
    ///Gets the configuration settings for Automatic Updates. This property is read-only.
    HRESULT get_Settings(IAutomaticUpdatesSettings* retval);
    ///Gets a Boolean value that indicates whether all the components that Automatic Updates requires are available.
    ///This property is read-only.
    HRESULT get_ServiceEnabled(short* retval);
    ///Enables all the components that Automatic Updates requires.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> This method cannot be called
    ///    from a remote computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_AU_NOSERVICE</b></dt> </dl> </td>
    ///    <td width="60%"> Automatic Updates is not enabled. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WU_E_AU_PAUSED</b></dt> </dl> </td> <td width="60%"> Automatic Updates is paused. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WU_E_LEGACYSERVER</b></dt> </dl> </td> <td width="60%"> You cannot search for
    ///    updates if the following conditions are true: <ul> <li>The ServerSelection property of the IUpdateSearcher
    ///    interface is set to ssManagedServer or ssDefault.</li> <li>The managed server on a computer is a Microsoft
    ///    Software Update Services (SUS) 1.0 server.</li> </ul> </td> </tr> </table>
    ///    
    HRESULT EnableService();
}

///Contains the functionality of Automatic Updates.
@GUID("4A2F5C31-CFD9-410E-B7FB-29A653973A0F")
interface IAutomaticUpdates2 : IAutomaticUpdates
{
    ///Returns a pointer to an IAutomaticUpdatesResults interface.
    ///Params:
    ///    retval = A pointer to an IAutomaticUpdatesResults interface.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT get_Results(IAutomaticUpdatesResults* retval);
}

///Represents the unique identifier of an update.
@GUID("46297823-9940-4C09-AED9-CD3EA6D05968")
interface IUpdateIdentity : IDispatch
{
    ///Gets the revision number of an update. This property is read-only.
    HRESULT get_RevisionNumber(int* retval);
    ///Gets the revision-independent identifier of an update. This property is read-only.
    HRESULT get_UpdateID(BSTR* retval);
}

///Contains information about a localized image that is associated with an update or a category.
@GUID("7C907864-346C-4AEB-8F3F-57DA289F969F")
interface IImageInformation : IDispatch
{
    ///Gets the alternate text for the image. This property is read-only.
    HRESULT get_AltText(BSTR* retval);
    ///Gets the height of the image, in pixels. This property is read-only.
    HRESULT get_Height(int* retval);
    ///Gets the source location of the image. This property is read-only.
    HRESULT get_Source(BSTR* retval);
    ///Gets the width of the image, in pixels. This property is read-only.
    HRESULT get_Width(int* retval);
}

///Represents the category to which an update belongs.
@GUID("81DDC1B8-9D35-47A6-B471-5B80F519223B")
interface ICategory : IDispatch
{
    ///Gets the localized name of the category. This property is read-only.
    HRESULT get_Name(BSTR* retval);
    ///Gets the identifier of the category. This property is read-only.
    HRESULT get_CategoryID(BSTR* retval);
    ///Gets an interface collection that contains the child categories of this category. This property is read-only.
    HRESULT get_Children(ICategoryCollection* retval);
    ///Gets the description of the category. This property is read-only.
    HRESULT get_Description(BSTR* retval);
    ///Gets an interface that contains information about the image that is associated with the category. This property
    ///is read-only.
    HRESULT get_Image(IImageInformation* retval);
    ///Gets the recommended display order of this category among its sibling categories. This property is read-only.
    HRESULT get_Order(int* retval);
    ///Gets an interface that describes the parent category of this category. This property is read-only.
    HRESULT get_Parent(ICategory* retval);
    ///Gets the type of the category. This property is read-only.
    HRESULT get_Type(BSTR* retval);
    ///Gets an interface that contains a collection of updates that immediately belong to the category. This property is
    ///read-only.
    HRESULT get_Updates(IUpdateCollection* retval);
}

///The <b>ICategoryCollection</b> interface represents an ordered read-only list of ICategory interfaces.
@GUID("3A56BFB8-576C-43F7-9335-FE4838FD7E37")
interface ICategoryCollection : IDispatch
{
    ///Gets an ICategory interface from the collection. This property is read-only.
    HRESULT get_Item(int index, ICategory* retval);
    ///Gets an IEnumVARIANT interface that can be used to enumerate the collection. This property is read-only.
    HRESULT get__NewEnum(IUnknown* retval);
    ///Gets the number of elements in the collection. This property is read-only.
    HRESULT get_Count(int* retval);
}

///Represents the installation and uninstallation options of an update.
@GUID("D9A59339-E245-4DBD-9686-4D5763E39624")
interface IInstallationBehavior : IDispatch
{
    ///Gets a Boolean value thast indicates whether the installation or uninstallation of an update can prompt for user
    ///input. This property is read-only.
    HRESULT get_CanRequestUserInput(short* retval);
    ///Gets an InstallationImpact enumeration that indicates how the installation or uninstallation of the update
    ///affects the computer. This property is read-only.
    HRESULT get_Impact(InstallationImpact* retval);
    ///Gets an InstallationRebootBehavior enumeration that specifies the restart behavior that occurs when you install
    ///or uninstall the update. This property is read-only.
    HRESULT get_RebootBehavior(InstallationRebootBehavior* retval);
    ///Gets a Boolean value that indicates whether the installation or uninstallation of an update requires network
    ///connectivity. This property is read-only.
    HRESULT get_RequiresNetworkConnectivity(short* retval);
}

///Represents the download content of an update.
@GUID("54A2CB2D-9A0C-48B6-8A50-9ABB69EE2D02")
interface IUpdateDownloadContent : IDispatch
{
    ///Gets the location of the download content on the server that hosts the update. This property is read-only.
    HRESULT get_DownloadUrl(BSTR* retval);
}

///Represents the download content of an update.
@GUID("C97AD11B-F257-420B-9D9F-377F733F6F68")
interface IUpdateDownloadContent2 : IUpdateDownloadContent
{
    ///Gets a Boolean value that indicates whether an update is a binary update or a full-file update. This property is
    ///read-only.
    HRESULT get_IsDeltaCompressedContent(short* retval);
}

///Represents a collection of download contents for an update.
@GUID("BC5513C8-B3B8-4BF7-A4D4-361C0D8C88BA")
interface IUpdateDownloadContentCollection : IDispatch
{
    ///Gets the download content for an update from an IUpdateDownloadContentCollection interface. This property is
    ///read-only.
    HRESULT get_Item(int index, IUpdateDownloadContent* retval);
    ///Gets an IEnumVARIANT interface that is used to enumerate the collection. This property is read-only.
    HRESULT get__NewEnum(IUnknown* retval);
    ///Gets the number of elements in the collection. This property is read-only.
    HRESULT get_Count(int* retval);
}

///Contains the properties and methods that are available to an update.
@GUID("6A92B07A-D821-4682-B423-5C805022CC4D")
interface IUpdate : IDispatch
{
    ///Gets the localized title of the update. This property is read-only.
    HRESULT get_Title(BSTR* retval);
    ///Gets a Boolean value that indicates whether the update is flagged to be automatically selected by Windows Update.
    ///This property is read-only.
    HRESULT get_AutoSelectOnWebSites(short* retval);
    ///Gets an interface that contains information about the ordered list of the bundled updates for the update. This
    ///property is read-only.
    HRESULT get_BundledUpdates(IUpdateCollection* retval);
    ///Gets a Boolean value that indicates whether the source media of the update is required for installation or
    ///uninstallation. This property is read-only.
    HRESULT get_CanRequireSource(short* retval);
    ///Gets an interface that contains a collection of categories to which the update belongs. This property is
    ///read-only.
    HRESULT get_Categories(ICategoryCollection* retval);
    ///Gets the date by which the update must be installed. This property is read-only.
    HRESULT get_Deadline(VARIANT* retval);
    ///Gets a Boolean value that indicates whether delta-compressed content is available on a server for the update.
    ///This property is read-only.
    HRESULT get_DeltaCompressedContentAvailable(short* retval);
    ///Gets a Boolean value that indicates whether to prefer delta-compressed content during the download and install or
    ///uninstall of the update if delta-compressed content is available. This property is read-only.
    HRESULT get_DeltaCompressedContentPreferred(short* retval);
    ///Gets the localized description of the update. This property is read-only.
    HRESULT get_Description(BSTR* retval);
    ///Gets a Boolean value that indicates whether the Microsoft Software License Terms that are associated with the
    ///update are accepted for the computer. This property is read-only.
    HRESULT get_EulaAccepted(short* retval);
    ///Gets the full localized text of the Microsoft Software License Terms that are associated with the update. This
    ///property is read-only.
    HRESULT get_EulaText(BSTR* retval);
    ///Gets the install handler of the update. This property is read-only.
    HRESULT get_HandlerID(BSTR* retval);
    ///Gets an interface that contains the unique identifier of the update. This property is read-only.
    HRESULT get_Identity(IUpdateIdentity* retval);
    ///Gets an interface that contains information about an image that is associated with the update. This property is
    ///read-only.
    ///Returns:
    ///    Returns S_OK if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT get_Image(IImageInformation* retval);
    ///Gets an interface that contains the installation options of the update. This property is read-only.
    ///Returns:
    ///    Returns S_OK if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT get_InstallationBehavior(IInstallationBehavior* retval);
    ///Gets a Boolean value that indicates whether the update is a beta release. This property is read-only.
    HRESULT get_IsBeta(short* retval);
    ///Gets a Boolean value that indicates whether all the update content is cached on the computer. This property is
    ///read-only.
    HRESULT get_IsDownloaded(short* retval);
    ///Gets a Boolean value that indicates whether an update is hidden by a user. Administrators, users, and power users
    ///can retrieve the value of this property. However, only administrators and members of the Power Users
    ///administrative group can set the value of this property. This property is read/write.
    HRESULT get_IsHidden(short* retval);
    ///Gets a Boolean value that indicates whether an update is hidden by a user. Administrators, users, and power users
    ///can retrieve the value of this property. However, only administrators and members of the Power Users
    ///administrative group can set the value of this property. This property is read/write.
    HRESULT put_IsHidden(short value);
    ///Gets a Boolean value that indicates whether the update is installed on a computer when the search is performed.
    ///This property is read-only.
    HRESULT get_IsInstalled(short* retval);
    ///Gets a Boolean value that indicates whether the installation of the update is mandatory. This property is
    ///read-only.
    HRESULT get_IsMandatory(short* retval);
    ///Gets a Boolean value that indicates whether a user can uninstall the update from a computer. This property is
    ///read-only.
    HRESULT get_IsUninstallable(short* retval);
    ///Gets an interface that contains the languages that are supported by the update. This property is read-only.
    HRESULT get_Languages(IStringCollection* retval);
    ///Gets the last published date of the update, in Coordinated Universal Time (UTC) date and time, on the server that
    ///deploys the update. This property is read-only.
    HRESULT get_LastDeploymentChangeTime(double* retval);
    ///Gets the maximum download size of the update. This property is read-only.
    HRESULT get_MaxDownloadSize(DECIMAL* retval);
    ///Gets the minimum download size of the update. This property is read-only.
    HRESULT get_MinDownloadSize(DECIMAL* retval);
    ///Gets a collection of language-specific strings that specify the hyperlinks to more information about the update.
    ///This property is read-only.
    HRESULT get_MoreInfoUrls(IStringCollection* retval);
    ///Gets the Microsoft Security Response Center severity rating of the update. This property is read-only.
    HRESULT get_MsrcSeverity(BSTR* retval);
    ///Gets the recommended CPU speed used to install the update, in megahertz (MHz). This property is read-only.
    HRESULT get_RecommendedCpuSpeed(int* retval);
    ///Gets the recommended free space that should be available on the hard disk before you install the update. The free
    ///space is specified in megabytes (MB). This property is read-only.
    HRESULT get_RecommendedHardDiskSpace(int* retval);
    ///Gets the recommended physical memory size that should be available in your computer before you install the
    ///update. The physical memory size is specified in megabytes (MB). This property is read-only.
    HRESULT get_RecommendedMemory(int* retval);
    ///Gets the localized release notes for the update. This property is read-only.
    HRESULT get_ReleaseNotes(BSTR* retval);
    ///Gets a collection of string values that contain the security bulletin IDs that are associated with the update.
    ///This property is read-only.
    HRESULT get_SecurityBulletinIDs(IStringCollection* retval);
    ///Gets a collection of update identifiers. This collection of identifiers specifies the updates that are superseded
    ///by the update. This property is read-only.
    HRESULT get_SupersededUpdateIDs(IStringCollection* retval);
    ///Gets a hyperlink to the language-specific support information for the update. This property is read-only.
    HRESULT get_SupportUrl(BSTR* retval);
    ///Gets the type of the update. This property is read-only.
    HRESULT get_Type(UpdateType* retval);
    ///Gets the uninstallation notes for the update. This property is read-only.
    HRESULT get_UninstallationNotes(BSTR* retval);
    ///Gets an interface that contains the uninstallation options for the update. This property is read-only.
    ///Returns:
    ///    Returns S_OK if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT get_UninstallationBehavior(IInstallationBehavior* retval);
    ///Gets an interface that contains the uninstallation steps for the update. This property is read-only.
    HRESULT get_UninstallationSteps(IStringCollection* retval);
    ///Gets a collection of Microsoft Knowledge Base article IDs that are associated with the update. This property is
    ///read-only.
    HRESULT get_KBArticleIDs(IStringCollection* retval);
    ///Accepts the Microsoft Software License Terms that are associated with Windows Update. Administrators and power
    ///users can call this method.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> This method cannot be called
    ///    from a remote computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_INVALID_OPERATION</b></dt> </dl>
    ///    </td> <td width="60%"> The computer could not access the update site. (This method returns
    ///    <b>WU_E_INVALID_OPERATION</b> if the object that is implementing the interface has been locked down.) </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_EULA_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The
    ///    Microsoft Software License Terms for the update could not be located. </td> </tr> </table>
    ///    
    HRESULT AcceptEula();
    ///Gets the action for which the update is deployed. This property is read-only.
    HRESULT get_DeploymentAction(DeploymentAction* retval);
    ///Copies the contents of an update to a specified path.
    ///Params:
    ///    path = The path of the location where the update contents are to be copied.
    ///    toExtractCabFiles = Reserved for future use. You must set <i>toExtractCabFiles</i> to <b>VARIANT_TRUE</b> or
    ///                        <b>VARIANT_FALSE</b>.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> This method cannot be called
    ///    from a remote computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> A parameter value is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WU_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The computer could not access the update
    ///    site. (This method returns <b>WU_E_INVALID_OPERATION</b> if the object that is implementing the interface has
    ///    been locked down.) </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_EULAS_DECLINED</b></dt> </dl> </td> <td
    ///    width="60%"> The Microsoft Software License Terms are not accepted. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WU_E_DM_NOTDOWNLOADED</b></dt> </dl> </td> <td width="60%"> The files are not downloaded. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>WU_E_DM_INCORRECTFILEHASH</b></dt> </dl> </td> <td width="60%"> The file
    ///    hash verification failed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>COR_E_DIRECTORYNOTFOUND</b></dt>
    ///    </dl> </td> <td width="60%"> A file or directory could not be located. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>STG_E_PATHNOTFOUND</b></dt> </dl> </td> <td width="60%"> A file or directory could not be located.
    ///    </td> </tr> </table>
    ///    
    HRESULT CopyFromCache(BSTR path, short toExtractCabFiles);
    ///Gets the suggested download priority of the update. This property is read-only.
    HRESULT get_DownloadPriority(DownloadPriority* retval);
    ///Gets file information about the download contents of the update. This property is read-only.
    HRESULT get_DownloadContents(IUpdateDownloadContentCollection* retval);
}

///Contains the properties and the methods that are available only from a Windows driver update.
@GUID("B383CD1A-5CE9-4504-9F63-764B1236F191")
interface IWindowsDriverUpdate : IUpdate
{
    ///Gets the class of the Windows driver update. This property is read-only.
    HRESULT get_DriverClass(BSTR* retval);
    ///Gets the hardware ID or compatible ID that the Windows driver update must match to be installable. This property
    ///is read-only.
    HRESULT get_DriverHardwareID(BSTR* retval);
    ///Gets the language-invariant name of the manufacturer of the Windows driver update. This property is read-only.
    HRESULT get_DriverManufacturer(BSTR* retval);
    ///Gets the language-invariant model name of the device for which the Windows driver update is intended. This
    ///property is read-only.
    HRESULT get_DriverModel(BSTR* retval);
    ///Gets the language-invariant name of the provider of the Windows driver update. This property is read-only.
    HRESULT get_DriverProvider(BSTR* retval);
    ///Gets the driver version date of the Windows driver update. This property is read-only.
    HRESULT get_DriverVerDate(double* retval);
    ///Gets the problem number of the matching device for the Windows driver update. This property is read-only.
    HRESULT get_DeviceProblemNumber(int* retval);
    ///Gets the status of the matching device for the Windows driver update. This property is read-only.
    HRESULT get_DeviceStatus(int* retval);
}

///Contains the properties and methods that are available to an update.
@GUID("144FE9B0-D23D-4A8B-8634-FB4457533B7A")
interface IUpdate2 : IUpdate
{
    ///Gets a Boolean value that indicates whether a system restart is required on a computer to complete the
    ///installation or the uninstallation of an update. This property is read-only.
    HRESULT get_RebootRequired(short* retval);
    ///Gets a Boolean value that indicates whether an update is present on a computer. This property is read-only.
    HRESULT get_IsPresent(short* retval);
    ///Gets a collection of common vulnerabilities and exposures (CVE) IDs that are associated with the update. This
    ///property is read-only.
    HRESULT get_CveIDs(IStringCollection* retval);
    ///Copies files for an update from a specified source location to the internal Windows Update Agent (WUA) download
    ///cache.
    ///Params:
    ///    pFiles = An IStringCollection interface that represents a collection of strings that contain the full paths of the
    ///             files for an update. The strings must give the full paths of the files that are being copied. The strings
    ///             cannot give only the directory that contains the files.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> This method cannot be called
    ///    from a remote computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> A parameter value is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WU_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The computer could not access the update
    ///    site. </td> </tr> </table>
    ///    
    HRESULT CopyToCache(IStringCollection pFiles);
}

///Contains the properties and methods that are available to an update.
@GUID("112EDA6B-95B3-476F-9D90-AEE82C6B8181")
interface IUpdate3 : IUpdate2
{
    ///Gets a Boolean value that indicates whether an update can be discovered only by browsing through the available
    ///updates. This property is read-only.
    HRESULT get_BrowseOnly(short* retval);
}

///Contains the properties and methods that are available to an update.
@GUID("27E94B0D-5139-49A2-9A61-93522DC54652")
interface IUpdate4 : IUpdate3
{
    ///Gets a Boolean value that indicates whether this is a per-user update. This property is read-only.
    HRESULT get_PerUser(short* retval);
}

///Contains the properties and methods that are available to an update.
@GUID("C1C2F21A-D2F4-4902-B5C6-8A081C19A890")
interface IUpdate5 : IUpdate4
{
    ///Gets a value indicating the automatic selection mode of update in the Control Panel of Windows Update. This
    ///property is read-only.
    HRESULT get_AutoSelection(AutoSelectionMode* retval);
    ///Gets a value indicating the automatic download mode of update. This property is read-only.
    HRESULT get_AutoDownload(AutoDownloadMode* retval);
}

///Contains the properties and methods that are available only from a Windows driver update.
@GUID("615C4269-7A48-43BD-96B7-BF6CA27D6C3E")
interface IWindowsDriverUpdate2 : IWindowsDriverUpdate
{
    ///Gets a Boolean value that indicates whether the computer must be restarted after you install or uninstall an
    ///update. This property is read-only.
    HRESULT get_RebootRequired(short* retval);
    ///Gets a Boolean value that indicates whether an update is installed on a computer. This property is read-only.
    HRESULT get_IsPresent(short* retval);
    ///Contains a collection of the Common Vulnerabilities and Exposures (CVE) identifiers that are associated with an
    ///update. This property is read-only.
    HRESULT get_CveIDs(IStringCollection* retval);
    ///Copies the external update binaries to an update.
    ///Params:
    ///    pFiles = An IStringCollection interface that contains the strings to be copied to an update.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> This method cannot be called
    ///    from a remote computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> A parameter value is invalid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WU_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The computer could not access the update
    ///    site. </td> </tr> </table>
    ///    
    HRESULT CopyToCache(IStringCollection pFiles);
}

///Contains the properties and methods that are available only from a Windows driver update.
@GUID("49EBD502-4A96-41BD-9E3E-4C5057F4250C")
interface IWindowsDriverUpdate3 : IWindowsDriverUpdate2
{
    ///Gets a Boolean value that indicates whether an update can be discovered only by browsing through the available
    ///updates. This property is read-only.
    HRESULT get_BrowseOnly(short* retval);
}

///Contains the properties that are available only from a Windows driver update.
@GUID("ED8BFE40-A60B-42EA-9652-817DFCFA23EC")
interface IWindowsDriverUpdateEntry : IDispatch
{
    ///The <b>DriverClass</b> property retrieves the class of the Windows driver update. This property is read-only.
    HRESULT get_DriverClass(BSTR* retval);
    ///Gets the hardware or the compatible identifier that the Windows driver update must match to be installable. This
    ///property is read-only.
    HRESULT get_DriverHardwareID(BSTR* retval);
    ///Gets the language-invariant name of the manufacturer of the Windows driver update. This property is read-only.
    HRESULT get_DriverManufacturer(BSTR* retval);
    ///Gets the language-invariant model name of the device for which the Windows driver update is intended. This
    ///property is read-only.
    HRESULT get_DriverModel(BSTR* retval);
    ///Gets the language-invariant name of the provider of the Windows driver update. This property is read-only.
    HRESULT get_DriverProvider(BSTR* retval);
    ///Gets the driver version date of the Windows driver update. This property is read-only.
    HRESULT get_DriverVerDate(double* retval);
    ///Gets the problem number of the matching device for the Windows driver update. This property is read-only.
    HRESULT get_DeviceProblemNumber(int* retval);
    ///Gets the status of the matching device for the Windows driver update. This property is read-only.
    HRESULT get_DeviceStatus(int* retval);
}

///Contains a collection of driver update entries associated with a driver update. All of the properties have the
///standard collection semantics.
@GUID("0D521700-A372-4BEF-828B-3D00C10ADEBD")
interface IWindowsDriverUpdateEntryCollection : IDispatch
{
    ///Gets an IWindowsDriverUpdateEntry interface in the collection. This property is read-only.
    HRESULT get_Item(int index, IWindowsDriverUpdateEntry* retval);
    ///Gets an IEnumVARIANT interface that is used to enumerate the collection. This property is read-only.
    HRESULT get__NewEnum(IUnknown* retval);
    ///Gets the number of elements contained in the collection This property is read-only.
    HRESULT get_Count(int* retval);
}

///Contains the properties and methods that are available only from a Windows driver update.
@GUID("004C6A2B-0C19-4C69-9F5C-A269B2560DB9")
interface IWindowsDriverUpdate4 : IWindowsDriverUpdate3
{
    ///Gets the driver update entries that are applicable for the update. This property is read-only.
    HRESULT get_WindowsDriverUpdateEntries(IWindowsDriverUpdateEntryCollection* retval);
    ///Gets a Boolean value that indicates whether an update is a per-user update. This property is read-only.
    HRESULT get_PerUser(short* retval);
}

///Contains the properties and methods that are available only from a Windows driver update.
@GUID("70CF5C82-8642-42BB-9DBC-0CFD263C6C4F")
interface IWindowsDriverUpdate5 : IWindowsDriverUpdate4
{
    ///Gets an AutoSelectionMode value indicating the automatic selection mode of an update in the Control Panel of
    ///Windows Update. This property is read-only.
    HRESULT get_AutoSelection(AutoSelectionMode* retval);
    ///Gets an AutoDownloadMode value that indicates the automatic download mode of update. This property is read-only.
    HRESULT get_AutoDownload(AutoDownloadMode* retval);
}

///Represents an ordered list of updates.
@GUID("07F7438C-7709-4CA5-B518-91279288134E")
interface IUpdateCollection : IDispatch
{
    ///Gets or sets an IUpdate interface in a collection. This property is read/write.
    HRESULT get_Item(int index, IUpdate* retval);
    ///Gets or sets an IUpdate interface in a collection. This property is read/write.
    HRESULT put_Item(int index, IUpdate value);
    ///Gets an IEnumVARIANT interface that can be used to enumerate the collection. This property is read-only.
    HRESULT get__NewEnum(IUnknown* retval);
    ///Gets the number of elements in the collection. This property is read-only.
    HRESULT get_Count(int* retval);
    ///Gets a Boolean value that indicates whether the update collection is read-only. This property is read-only.
    HRESULT get_ReadOnly(short* retval);
    ///Adds an item to the collection.
    ///Params:
    ///    value = An IUpdate interface to be added to the collection.
    ///    retval = The index of the added interface in the collection.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter value is invalid or
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_NOT_SUPPORTED</b></dt> </dl> </td> <td
    ///    width="60%"> The collection is read-only. </td> </tr> </table>
    ///    
    HRESULT Add(IUpdate value, int* retval);
    ///Removes all the elements from the collection.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WU_E_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The collection is
    ///    read-only. </td> </tr> </table>
    ///    
    HRESULT Clear();
    ///Creates a shallow read/write copy of the collection.
    ///Params:
    ///    retval = A shallow read/write copy of the collection.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter value is invalid or
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> This method cannot be called from a remote computer. </td> </tr> </table>
    ///    
    HRESULT Copy(IUpdateCollection* retval);
    ///Inserts an item into the collection at the specified position.
    ///Params:
    ///    index = The position at which a new interface will be inserted.
    ///    value = The IUpdate interface that will be inserted.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter value is invalid or
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_NOT_SUPPORTED</b></dt> </dl> </td> <td
    ///    width="60%"> The collection is read-only. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WU_E_INVALIDINDEX</b></dt> </dl> </td> <td width="60%"> An index is invalid. </td> </tr> </table>
    ///    
    HRESULT Insert(int index, IUpdate value);
    ///Removes the item at the specified index from the collection.
    ///Params:
    ///    index = The index of the interface to be removed.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WU_E_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The collection is
    ///    read-only. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_INVALIDINDEX</b></dt> </dl> </td> <td
    ///    width="60%"> An index is invalid. </td> </tr> </table>
    ///    
    HRESULT RemoveAt(int index);
}

///Represents info about the aspects of search results returned in the ISearchResult object that were incomplete. For
///more info, see Remarks.
@GUID("A376DD5E-09D4-427F-AF7C-FED5B6E1C1D6")
interface IUpdateException : IDispatch
{
    ///Gets a message that describes the search results. This property is read-only.
    HRESULT get_Message(BSTR* retval);
    ///Gets the Windows-based <b>HRESULT</b> code for the search results. This property is read-only.
    HRESULT get_HResult(int* retval);
    ///Gets the context of search results. This property is read-only.
    HRESULT get_Context(UpdateExceptionContext* retval);
}

///Encapsulates the exception that is thrown when an invalid license is detected for a product.
@GUID("A37D00F5-7BB0-4953-B414-F9E98326F2E8")
interface IInvalidProductLicenseException : IUpdateException
{
    ///Gets the language-invariant name of the product. This property is read-only.
    HRESULT get_Product(BSTR* retval);
}

///Represents an ordered read-only list of IUpdateException interfaces.
@GUID("503626A3-8E14-4729-9355-0FE664BD2321")
interface IUpdateExceptionCollection : IDispatch
{
    ///Gets an IUpdateException interface in the collection. This property is read-only.
    HRESULT get_Item(int index, IUpdateException* retval);
    ///Gets an IEnumVARIANT interface that can be used to enumerate the collection. This property is read-only.
    HRESULT get__NewEnum(IUnknown* retval);
    ///Gets the number of elements in the collection. This property is read-only.
    HRESULT get_Count(int* retval);
}

///Represents the result of a search.
@GUID("D40CFF62-E08C-4498-941A-01E25F0FD33C")
interface ISearchResult : IDispatch
{
    ///Gets an OperationResultCode enumeration that specifies the result of a search. This property is read-only.
    HRESULT get_ResultCode(OperationResultCode* retval);
    ///Gets an interface collection of the root categories that are currently available on the computer. This property
    ///is read-only.
    HRESULT get_RootCategories(ICategoryCollection* retval);
    ///Gets an interface collection of the updates that result from a search. This property is read-only.
    HRESULT get_Updates(IUpdateCollection* retval);
    ///Gets a collection of the warnings that result from a search. This property is read-only.
    HRESULT get_Warnings(IUpdateExceptionCollection* retval);
}

///Contains properties and methods that are available to a search operation.
@GUID("7366EA16-7A1A-4EA2-B042-973D3E9CD99B")
interface ISearchJob : IDispatch
{
    ///Gets the caller-specific state object that is passed to the IUpdateSearch.BeginSearch method. This property is
    ///read-only.
    HRESULT get_AsyncState(VARIANT* retval);
    ///Gets a Boolean value that indicates whether the call to the IUpdateSearch.BeginSearch method is completely
    ///processed. This property is read-only.
    HRESULT get_IsCompleted(short* retval);
    ///Waits for an asynchronous operation to complete and then releases all the callbacks.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT CleanUp();
    ///Makes a request to cancel the asynchronous search.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT RequestAbort();
}

///Contains information about the completion of an asynchronous search. It also acts as a parameter to the
///SearchCompletedCallback delegate.
@GUID("A700A634-2850-4C47-938A-9E4B6E5AF9A6")
interface ISearchCompletedCallbackArgs : IDispatch
{
}

///Contains a method that handles the notification about the completion of an asynchronous search operation. This
///interface is implemented by programmers who call the IUpdateSearcher.BeginSearch method.
@GUID("88AEE058-D4B0-4725-A2F1-814A67AE964C")
interface ISearchCompletedCallback : IUnknown
{
    ///Handles the notification of the completion of an asynchronous search that is initiated by calling the
    ///IUpdateSearcher.BeginSearch method.
    ///Params:
    ///    searchJob = An ISearchJob interface that contains search information.
    ///    callbackArgs = This parameter is reserved for future use and can be ignored. An ISearchCompletedCallbackArgs interface that
    ///                   contains information on the completion of an asynchronous search.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT Invoke(ISearchJob searchJob, ISearchCompletedCallbackArgs callbackArgs);
}

///Represents the recorded history of an update.
@GUID("BE56A644-AF0E-4E0E-A311-C1D8E695CBFF")
interface IUpdateHistoryEntry : IDispatch
{
    ///Gets an UpdateOperation value that specifies the operation on an update. This property is read-only.
    HRESULT get_Operation(UpdateOperation* retval);
    ///Gets an OperationResultCode value that specifies the result of an operation on an update. This property is
    ///read-only.
    HRESULT get_ResultCode(OperationResultCode* retval);
    ///Gets the <b>HRESULT</b> value that is returned from the operation on an update. This property is read-only.
    HRESULT get_HResult(int* retval);
    ///Gets the date and the time an update was applied. This property is read-only.
    HRESULT get_Date(double* retval);
    ///Gets the IUpdateIdentity interface that contains the identity of the update. This property is read-only.
    HRESULT get_UpdateIdentity(IUpdateIdentity* retval);
    ///Gets the title of an update. This property is read-only.
    HRESULT get_Title(BSTR* retval);
    ///Gets the description of an update. This property is read-only.
    HRESULT get_Description(BSTR* retval);
    ///Gets the unmapped result code that is returned from an operation on an update. This property is read-only.
    HRESULT get_UnmappedResultCode(int* retval);
    ///Gets the identifier of the client application that processed an update. This property is read-only.
    HRESULT get_ClientApplicationID(BSTR* retval);
    ///Gets the ServerSelection value that indicates which server provided an update. This property is read-only.
    HRESULT get_ServerSelection(ServerSelection* retval);
    ///Gets the service identifier of an update service that is not a Windows update. This property is meaningful only
    ///if the ServerSelection property returns <b>ssOthers</b>. This property is read-only.
    HRESULT get_ServiceID(BSTR* retval);
    ///Gets the IStringCollection interface that contains the uninstallation steps for an update. This property is
    ///read-only.
    HRESULT get_UninstallationSteps(IStringCollection* retval);
    ///Gets the uninstallation notes of an update. This property is read-only.
    HRESULT get_UninstallationNotes(BSTR* retval);
    ///Gets a hyperlink to the language-specific support information for an update. This property is read-only.
    HRESULT get_SupportUrl(BSTR* retval);
}

///Represents the recorded history of an update.
@GUID("C2BFB780-4539-4132-AB8C-0A8772013AB6")
interface IUpdateHistoryEntry2 : IUpdateHistoryEntry
{
    ///Gets a collection of the update categories to which an update belongs. This property is read-only.
    HRESULT get_Categories(ICategoryCollection* retval);
}

///Represents an ordered read-only list of IUpdateHistoryEntry interfaces.
@GUID("A7F04F3C-A290-435B-AADF-A116C3357A5C")
interface IUpdateHistoryEntryCollection : IDispatch
{
    ///Gets an IUpdateHistoryEntry interface in the collection. This property is read-only.
    HRESULT get_Item(int index, IUpdateHistoryEntry* retval);
    ///Gets an IEnumVARIANT interface that can be used to enumerate the collection. This property is read-only.
    HRESULT get__NewEnum(IUnknown* retval);
    ///Gets the number of elements in the collection. This property is read-only.
    HRESULT get_Count(int* retval);
}

///Searches for updates on a server.
@GUID("8F45ABF1-F9AE-4B95-A933-F0F66E5056EA")
interface IUpdateSearcher : IDispatch
{
    ///Gets and sets a Boolean value that indicates whether future calls to the BeginSearch and Search methods result in
    ///an automatic upgrade to Windows Update Agent (WUA). Currently, this property's valid value corresponds to the
    ///option that does not automatically upgrade WUA. This property is read/write.
    HRESULT get_CanAutomaticallyUpgradeService(short* retval);
    ///Gets and sets a Boolean value that indicates whether future calls to the BeginSearch and Search methods result in
    ///an automatic upgrade to Windows Update Agent (WUA). Currently, this property's valid value corresponds to the
    ///option that does not automatically upgrade WUA. This property is read/write.
    HRESULT put_CanAutomaticallyUpgradeService(short value);
    ///Identifies the current client application. This property is read/write.
    HRESULT get_ClientApplicationID(BSTR* retval);
    ///Identifies the current client application. This property is read/write.
    HRESULT put_ClientApplicationID(BSTR value);
    ///Gets and sets a Boolean value that indicates whether the search results include updates that are superseded by
    ///other updates in the search results. This property is read/write. > [!NOTE] > This property is no longer
    ///supported in Windows 10, version 1709 (build 16299), and later OS releases.
    HRESULT get_IncludePotentiallySupersededUpdates(short* retval);
    ///Gets and sets a Boolean value that indicates whether the search results include updates that are superseded by
    ///other updates in the search results. This property is read/write. > [!NOTE] > This property is no longer
    ///supported in Windows 10, version 1709 (build 16299), and later OS releases.
    HRESULT put_IncludePotentiallySupersededUpdates(short value);
    ///Gets and sets a ServerSelection value that indicates the server to search for updates. This property is
    ///read/write.
    HRESULT get_ServerSelection(ServerSelection* retval);
    ///Gets and sets a ServerSelection value that indicates the server to search for updates. This property is
    ///read/write.
    HRESULT put_ServerSelection(ServerSelection value);
    ///Begins execution of an asynchronous search for updates. The search uses the search options that are currently
    ///configured.
    ///Params:
    ///    criteria = A string that specifies the search criteria.
    ///    onCompleted = An ISearchCompletedCallback interface that is called when an asynchronous search operation is complete.
    ///    state = The caller-specific state that is returned by the AsyncState property of the ISearchJob interface.
    ///    retval = An ISearchJob interface that represents the current operation that might be pending. The caller passes the
    ///             returned value to the EndSearch method to complete a search operation.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter value is invalid or
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> This method cannot be called from a remote computer. </td> </tr> </table>
    ///    
    HRESULT BeginSearch(BSTR criteria, IUnknown onCompleted, VARIANT state, ISearchJob* retval);
    ///Completes an asynchronous search for updates.
    ///Params:
    ///    searchJob = The ISearchJob interface that the BeginSearch method returns.
    ///    retval = An ISearchResult interface that contains the following: <ul> <li>The result of an operation</li> <li>A
    ///             collection of updates that match the search criteria</li> </ul>
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td width="60%"> An asynchronous search for updates
    ///    is successful. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_LEGACYSERVER</b></dt> </dl> </td> <td
    ///    width="60%"> You cannot search for updates if the ServerSelection property of IUpdateSearcher is set to
    ///    ssManagedServer or to ssDefault, and the managed server on a computer is a Microsoft Software Update Services
    ///    (SUS) 1.0 server. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> A parameter value is invalid or <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> This method cannot be called from a remote
    ///    computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_INVALID_OPERATION</b></dt> </dl> </td> <td
    ///    width="60%"> The EndSearch method returns <b>WU_E_INVALID_OPERATION</b> if <b>EndSearch</b> has already been
    ///    called for the search job. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_INVALID_CRITERIA</b></dt> </dl>
    ///    </td> <td width="60%"> An invalid criteria was encountered during a search. </td> </tr> </table>
    ///    
    HRESULT EndSearch(ISearchJob searchJob, ISearchResult* retval);
    ///Converts a string into a string that can be used as a literal value in a search criteria string.
    ///Params:
    ///    unescaped = A string to be escaped.
    ///    retval = The resulting escaped string.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter value is invalid or
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT EscapeString(BSTR unescaped, BSTR* retval);
    ///Synchronously queries the computer for the history of the update events.
    ///Params:
    ///    startIndex = The index of the first event to retrieve.
    ///    count = The number of events to retrieve.
    ///    retval = A pointer to an IUpdateHistoryEntryCollection interface that contains matching event records on the computer
    ///             in descending chronological order.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter value is invalid or
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_INVALIDINDEX</b></dt> </dl> </td> <td
    ///    width="60%"> An index is invalid. </td> </tr> </table>
    ///    
    HRESULT QueryHistory(int startIndex, int count, IUpdateHistoryEntryCollection* retval);
    ///Performs a synchronous search for updates. The search uses the search options that are currently configured.
    ///Params:
    ///    criteria = A string that specifies the search criteria.
    ///    retval = An ISearchResult interface that contains the following: <ul> <li>The result of an operation</li> <li>A
    ///             collection of updates that match the search criteria</li> </ul>
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WU_E_LEGACYSERVER</b></dt> </dl> </td> <td width="60%"> You cannot search for
    ///    updates if the ServerSelection property of the IUpdateSearcher interface is set to ssManagedServer or
    ///    ssDefault, and the managed server on a computer is a Microsoft Software Update Services (SUS) 1.0 server.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter
    ///    value is invalid or <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_INVALID_CRITERIA</b></dt>
    ///    </dl> </td> <td width="60%"> There is an invalid search criteria. </td> </tr> </table>
    ///    
    HRESULT Search(BSTR criteria, ISearchResult* retval);
    ///Gets and sets a Boolean value that indicates whether the UpdateSearcher goes online to search for updates. This
    ///property is read/write.
    HRESULT get_Online(short* retval);
    ///Gets and sets a Boolean value that indicates whether the UpdateSearcher goes online to search for updates. This
    ///property is read/write.
    HRESULT put_Online(short value);
    ///Returns the number of update events on the computer.
    ///Params:
    ///    retval = The number of update events on the computer.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter value is invalid or
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetTotalHistoryCount(int* retval);
    ///Gets and sets a site to search when the site to search is not a Windows Update site. This property is read/write.
    HRESULT get_ServiceID(BSTR* retval);
    ///Gets and sets a site to search when the site to search is not a Windows Update site. This property is read/write.
    HRESULT put_ServiceID(BSTR value);
}

///Searches for updates on a server.
@GUID("4CBDCB2D-1589-4BEB-BD1C-3E582FF0ADD0")
interface IUpdateSearcher2 : IUpdateSearcher
{
    ///Gets and sets a Boolean value that indicates whether to ignore the download priority. The download priority
    ///determines whether one update should replace another update. This property is read/write.
    HRESULT get_IgnoreDownloadPriority(short* retval);
    ///Gets and sets a Boolean value that indicates whether to ignore the download priority. The download priority
    ///determines whether one update should replace another update. This property is read/write.
    HRESULT put_IgnoreDownloadPriority(short value);
}

///Searches for updates on a server.
@GUID("04C6895D-EAF2-4034-97F3-311DE9BE413A")
interface IUpdateSearcher3 : IUpdateSearcher2
{
    HRESULT get_SearchScope(SearchScope* retval);
    HRESULT put_SearchScope(SearchScope value);
}

///Contains the properties that indicate the status of a download operation for an update.
@GUID("BF99AF76-B575-42AD-8AA4-33CBB5477AF1")
interface IUpdateDownloadResult : IDispatch
{
    ///Gets the exception <b>HRESULT</b> value, if any, that is raised during the operation on the update. This property
    ///is read-only.
    HRESULT get_HResult(int* retval);
    ///Gets an OperationResultCode enumeration value that specifies the result of an operation on the update. This
    ///property is read-only.
    HRESULT get_ResultCode(OperationResultCode* retval);
}

///The <b>IDownloadResult</b> interface represents the result of a download operation.
@GUID("DAA4FDD0-4727-4DBE-A1E7-745DCA317144")
interface IDownloadResult : IDispatch
{
    ///Gets the exception code number if an exception code number is raised during the download. This property is
    ///read-only.
    HRESULT get_HResult(int* retval);
    ///Gets an OperationResultCodeenumeration that specifies the result of the download. This property is read-only.
    HRESULT get_ResultCode(OperationResultCode* retval);
    ///Returns an IUpdateDownloadResult interface that contains the download information for a specified update.
    ///Params:
    ///    updateIndex = The index of the update.
    ///    retval = An IUpdateDownloadResult interface that contains the results for the specified update.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT GetUpdateResult(int updateIndex, IUpdateDownloadResult* retval);
}

///Represents the progress of an asynchronous download operation.
@GUID("D31A5BAC-F719-4178-9DBB-5E2CB47FD18A")
interface IDownloadProgress : IDispatch
{
    ///Gets a string that specifies how much data has been transferred for the content file or files of the update that
    ///is being downloaded, in bytes. This property is read-only.
    HRESULT get_CurrentUpdateBytesDownloaded(DECIMAL* retval);
    ///Gets a string that estimates how much data should be transferred for the content file or files of the update that
    ///is being downloaded, in bytes. This property is read-only.
    HRESULT get_CurrentUpdateBytesToDownload(DECIMAL* retval);
    ///Gets a zero-based index value that specifies the update that is currently being downloaded when multiple updates
    ///have been selected. This property is read-only.
    HRESULT get_CurrentUpdateIndex(int* retval);
    ///Gets an estimate of the percentage of all the updates that have been downloaded. This property is read-only.
    HRESULT get_PercentComplete(int* retval);
    ///Gets a string that specifies the total amount of data that has been downloaded, in bytes. This property is
    ///read-only.
    HRESULT get_TotalBytesDownloaded(DECIMAL* retval);
    ///Gets a string that represents the estimate of the total amount of data that will be downloaded, in bytes. This
    ///property is read-only.
    HRESULT get_TotalBytesToDownload(DECIMAL* retval);
    ///Returns the result of the download of a specified update.
    ///Params:
    ///    updateIndex = A zero-based index value that specifies an update.
    ///    retval = An IUpdateDownloadResult interface that contains information about the specified update.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT GetUpdateResult(int updateIndex, IUpdateDownloadResult* retval);
    ///Gets a DownloadPhase enumeration value that specifies the phase of the download that is currently in progress.
    ///This property is read-only.
    HRESULT get_CurrentUpdateDownloadPhase(DownloadPhase* retval);
    ///Gets an estimate of the percentage of the current update that has been downloaded. This property is read-only.
    HRESULT get_CurrentUpdatePercentComplete(int* retval);
}

///Contains properties and methods that are available to a download operation. This interface is returned by the
///IUpdateDownloader.BeginDownload method.
@GUID("C574DE85-7358-43F6-AAE8-8697E62D8BA7")
interface IDownloadJob : IDispatch
{
    ///Gets the caller-specific state object that is passed to the IUpdateDownloader.BeginDownload method. This property
    ///is read-only.
    HRESULT get_AsyncState(VARIANT* retval);
    ///Gets the setting that indicates whether the call to IUpdateDownloader.BeginDownload was processed completely.
    ///This property is read-only.
    HRESULT get_IsCompleted(short* retval);
    ///Gets an interface that contains a read-only collection of the updates that are specified in a download. This
    ///property is read-only.
    HRESULT get_Updates(IUpdateCollection* retval);
    ///Waits for an asynchronous operation to be completed and releases all callbacks.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT CleanUp();
    ///Returns an IDownloadProgress interface that describes the current progress of a download.
    ///Params:
    ///    retval = An IDownloadProgress interface that describes the current progress of a download.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT GetProgress(IDownloadProgress* retval);
    ///Makes a request to end an asynchronous download.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT RequestAbort();
}

///Contains information about the completion of a download. This interface acts as a parameter to the
///IDownloadCompletedCallback delegate. The download and installation of the update is asynchronous.
@GUID("FA565B23-498C-47A0-979D-E7D5B1813360")
interface IDownloadCompletedCallbackArgs : IDispatch
{
}

///Provides the callback that is used when an asynchronous download is completed. This interface is implemented by
///programmers who call the IUpdateDownloader::BeginDownload method.
@GUID("77254866-9F5B-4C8E-B9E2-C77A8530D64B")
interface IDownloadCompletedCallback : IUnknown
{
    ///Notifies the caller that the download is complete.
    ///Params:
    ///    downloadJob = An IDownloadJob interface that contains download information.
    ///    callbackArgs = This parameter is reserved for future use and can be ignored.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT Invoke(IDownloadJob downloadJob, IDownloadCompletedCallbackArgs callbackArgs);
}

///Contains information about the change in the progress of an asynchronous download operation.
@GUID("324FF2C6-4981-4B04-9412-57481745AB24")
interface IDownloadProgressChangedCallbackArgs : IDispatch
{
    ///Gets an interface that contains the progress of the asynchronous download at the time that the callback was made.
    ///This property is read-only.
    HRESULT get_Progress(IDownloadProgress* retval);
}

///Handles the notification that indicates a change in the progress of an asynchronous download operation. This
///interface is implemented by programmers who call the IUpdateDownloader.BeginDownload method.
@GUID("8C3F1CDD-6173-4591-AEBD-A56A53CA77C1")
interface IDownloadProgressChangedCallback : IUnknown
{
    ///Handles the notification of a change in the progress of an asynchronous download that was initiated by calling
    ///the IUpdateDownloader.BeginDownload method.
    ///Params:
    ///    downloadJob = An IDownloadJob interface that contains download information.
    ///    callbackArgs = An IDownloadProgressChangedCallbackArgs interface that contains download progress data.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT Invoke(IDownloadJob downloadJob, IDownloadProgressChangedCallbackArgs callbackArgs);
}

///Downloads updates from the server.
@GUID("68F1C6F9-7ECC-4666-A464-247FE12496C3")
interface IUpdateDownloader : IDispatch
{
    ///Gets and sets the current client application. This property is read/write.
    HRESULT get_ClientApplicationID(BSTR* retval);
    ///Gets and sets the current client application. This property is read/write.
    HRESULT put_ClientApplicationID(BSTR value);
    ///Gets and sets a Boolean value that indicates whether the Windows Update Agent (WUA) forces the download of
    ///updates that are already installed or that cannot be installed. This property is read/write.
    HRESULT get_IsForced(short* retval);
    ///Gets and sets a Boolean value that indicates whether the Windows Update Agent (WUA) forces the download of
    ///updates that are already installed or that cannot be installed. This property is read/write.
    HRESULT put_IsForced(short value);
    ///Gets and sets the priority level of the download. This property is read/write.
    HRESULT get_Priority(DownloadPriority* retval);
    ///Gets and sets the priority level of the download. This property is read/write.
    HRESULT put_Priority(DownloadPriority value);
    ///Gets and sets an interface that contains a read-only collection of the updates that are specified for download.
    ///This property is read/write.
    HRESULT get_Updates(IUpdateCollection* retval);
    ///Gets and sets an interface that contains a read-only collection of the updates that are specified for download.
    ///This property is read/write.
    HRESULT put_Updates(IUpdateCollection value);
    ///Starts an asynchronous download of the content files that are associated with the updates.
    ///Params:
    ///    onProgressChanged = An IDownloadProgressChangedCallback interface that is called periodically for download progress changes
    ///                        before download is complete.
    ///    onCompleted = An IDownloadCompletedCallback interface (C++/COM) that is called when an asynchronous download operation is
    ///                  complete.
    ///    state = The caller-specific state that the AsyncState property of the IDownloadJob interface returns. A caller may
    ///            use this parameter to attach a value to the download job object. This allows the caller to retrieve custom
    ///            information about that download job object at a later time. <div class="alert"><b>Note</b> <p
    ///            class="note">The AsyncState property of the IDownloadJob interface can be retrieved, but it cannot be set.
    ///            This does not prevent the caller from changing the contents of the object already set to the
    ///            <b>AsyncState</b> property of the <b>IDownloadJob</b> interface. In other words, if the <b>AsyncState</b>
    ///            property contains a number, the number cannot be changed. But, if the <b>AsyncState</b> property contains a
    ///            safe array or an object, the contents of the safe array or the object can be changed at will. The value is
    ///            released when the caller releases <b>IDownloadJob</b> by calling IUpdateDownloader::EndDownload. </div> <div>
    ///            </div>
    ///    retval = An IDownloadJob interface that contains the properties and methods that are available to a download operation
    ///             that has started.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WU_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The computer cannot
    ///    access the update site. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_NO_UPDATE</b></dt> </dl> </td> <td
    ///    width="60%"> The Windows Update Agent (WUA) does not have updates in the collection. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WU_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> The Windows Update Agent
    ///    (WUA) is not initialized. </td> </tr> </table>
    ///    
    HRESULT BeginDownload(IUnknown onProgressChanged, IUnknown onCompleted, VARIANT state, IDownloadJob* retval);
    ///Starts a synchronous download of the content files that are associated with the updates.
    ///Params:
    ///    retval = An IDownloadResult interface that contains result codes for the download.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WU_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The computer cannot
    ///    access the update site. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_NO_UPDATE</b></dt> </dl> </td> <td
    ///    width="60%"> Windows Update Agent (WUA) does not have updates in the collection. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WU_E_NOT_INITIALIZED</b></dt> </dl> </td> <td width="60%"> Windows Update Agent is
    ///    not initialized. </td> </tr> </table>
    ///    
    HRESULT Download(IDownloadResult* retval);
    ///Completes an asynchronous download.
    ///Params:
    ///    value = The IDownloadJob interface pointer that BeginDownload returns.
    ///    retval = An IDownloadResult interface that contains result codes for a download.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WU_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The computer cannot
    ///    access the update site. </td> </tr> </table>
    ///    
    HRESULT EndDownload(IDownloadJob value, IDownloadResult* retval);
}

///Contains the properties and the methods that are available to the status of an installation or uninstallation of an
///update.
@GUID("D940F0F8-3CBB-4FD0-993F-471E7F2328AD")
interface IUpdateInstallationResult : IDispatch
{
    ///Gets the <b>HRESULT</b> exception value that is raised during the operation on an update. This property is
    ///read-only.
    HRESULT get_HResult(int* retval);
    ///Gets a Boolean value that indicates whether a system restart is required on a computer to complete the
    ///installation of an update. This property is read-only.
    HRESULT get_RebootRequired(short* retval);
    ///Gets an OperationResultCode value that specifies the result of an operation on an update. This property is
    ///read-only.
    HRESULT get_ResultCode(OperationResultCode* retval);
}

///Represents the result of an installation or uninstallation.
@GUID("A43C56D6-7451-48D4-AF96-B6CD2D0D9B7A")
interface IInstallationResult : IDispatch
{
    ///Gets the <b>HRESULT</b> of the exception, if any, that is raised during the installation. This property is
    ///read-only.
    HRESULT get_HResult(int* retval);
    ///Gets a Boolean value that indicates whether you must restart the computer to complete the installation or
    ///uninstallation of an update. This property is read-only.
    HRESULT get_RebootRequired(short* retval);
    ///Gets an OperationResultCode value that specifies the result of an operation on an update. This property is
    ///read-only.
    HRESULT get_ResultCode(OperationResultCode* retval);
    ///Returns an IUpdateInstallationResult interface that contains the installation results for a specified update.
    ///Params:
    ///    updateIndex = The index of an update.
    ///    retval = An interface that contains results for a specified update.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT GetUpdateResult(int updateIndex, IUpdateInstallationResult* retval);
}

///Represents the progress of an asynchronous installation or uninstallation.
@GUID("345C8244-43A3-4E32-A368-65F073B76F36")
interface IInstallationProgress : IDispatch
{
    ///Gets a zero-based index value. This value specifies the update that is currently being installed or uninstalled
    ///when multiple updates have been selected. This property is read-only.
    HRESULT get_CurrentUpdateIndex(int* retval);
    ///Gets how far the installation or uninstallation process for the current update has progressed, as a percentage.
    ///This property is read-only.
    HRESULT get_CurrentUpdatePercentComplete(int* retval);
    ///Gets how far the overall installation or uninstallation process has progressed, as a percentage. This property is
    ///read-only.
    HRESULT get_PercentComplete(int* retval);
    ///Returns the result of the installation or uninstallation of a specified update.
    ///Params:
    ///    updateIndex = A zero-based index value that specifies an update.
    ///    retval = An IUpdateInstallationResult interface that contains information about a specified update.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT GetUpdateResult(int updateIndex, IUpdateInstallationResult* retval);
}

///The <b>IInstallationJob</b> interface contains properties and methods that are available to an installation or
///uninstallation operation.
@GUID("5C209F0B-BAD5-432A-9556-4699BED2638A")
interface IInstallationJob : IDispatch
{
    ///Gets the caller-specific state object that is passed to the IUpdateInstaller.BeginInstall method or to the
    ///IUpdateInstaller.BeginUninstall method. This property is read-only.
    HRESULT get_AsyncState(VARIANT* retval);
    ///Gets a value that indicates whether a call to the IUpdateInstaller.BeginInstall or
    ///IUpdateInstaller.BeginUninstall method is completely processed. This property is read-only.
    HRESULT get_IsCompleted(short* retval);
    ///Gets an interface that contains a read-only collection of the updates that are specified in the installation or
    ///uninstallation. This property is read-only.
    HRESULT get_Updates(IUpdateCollection* retval);
    ///Waits for an asynchronous operation to be completed and then releases all the callbacks.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT CleanUp();
    ///Returns an IInstallationProgress interface that describes the current progress of an installation or
    ///uninstallation.
    ///Params:
    ///    retval = An IInstallationProgress interface that describes the current progress of an installation or uninstallation.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT GetProgress(IInstallationProgress* retval);
    ///Makes a request to cancel the installation or uninstallation.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT RequestAbort();
}

///Contains information about the completion of an installation and acts as a parameter to the
///IInstallationCompletedCallback delegate. The download and installation of the update is asynchronous.
@GUID("250E2106-8EFB-4705-9653-EF13C581B6A1")
interface IInstallationCompletedCallbackArgs : IDispatch
{
}

///Handles the notification that indicates that an asynchronous installation or uninstallation is complete. This
///interface is implemented by programmers who call the IUpdateInstaller.BeginInstall or IUpdateInstaller.BeginUninstall
///methods.
@GUID("45F4F6F3-D602-4F98-9A8A-3EFA152AD2D3")
interface IInstallationCompletedCallback : IUnknown
{
    ///Handles the notification of the completion of an asynchronous installation or uninstallation that is initiated by
    ///a call to IUpdateInstaller.BeginInstall or IUpdateInstaller.BeginUninstall.
    ///Params:
    ///    installationJob = An IInstallationJob interface that contains the installation information.
    ///    callbackArgs = This parameter is reserved for future use and can be ignored.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT Invoke(IInstallationJob installationJob, IInstallationCompletedCallbackArgs callbackArgs);
}

///Contains information about the change in the progress of an asynchronous installation or uninstallation at the time
///the callback was made.
@GUID("E4F14E1E-689D-4218-A0B9-BC189C484A01")
interface IInstallationProgressChangedCallbackArgs : IDispatch
{
    ///Gets an interface that contains the progress of the asynchronous installation or uninstallation at the time the
    ///callback was made. This property is read-only.
    HRESULT get_Progress(IInstallationProgress* retval);
}

///Defines the Invoke method that handles the notification about the on-going progress of an asynchronous installation
///or uninstallation. This interface is implemented by programmers who call the IUpdateInstaller.BeginInstall method or
///the IUpdateInstaller.BeginUninstall method.
@GUID("E01402D5-F8DA-43BA-A012-38894BD048F1")
interface IInstallationProgressChangedCallback : IUnknown
{
    ///Handles the notification of the change in the progress of an asynchronous installation or uninstallation that was
    ///initiated by a call to the IUpdateInstaller.BeginInstall method or the IUpdateInstaller.BeginUninstall method.
    ///Params:
    ///    installationJob = An IInstallationJob interface that contains the installation information.
    ///    callbackArgs = An IInstallationProgressChangedCallbackArgs interface that contains the installation progress data.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT Invoke(IInstallationJob installationJob, IInstallationProgressChangedCallbackArgs callbackArgs);
}

///Installs or uninstalls updates from or onto a computer.
@GUID("7B929C68-CCDC-4226-96B1-8724600B54C2")
interface IUpdateInstaller : IDispatch
{
    ///Gets and sets the current client application. This property is read/write.
    HRESULT get_ClientApplicationID(BSTR* retval);
    ///Gets and sets the current client application. This property is read/write.
    HRESULT put_ClientApplicationID(BSTR value);
    ///Gets or sets a Boolean value that indicates whether to forcibly install or uninstall an update. This property is
    ///read/write.
    HRESULT get_IsForced(short* retval);
    ///Gets or sets a Boolean value that indicates whether to forcibly install or uninstall an update. This property is
    ///read/write.
    HRESULT put_IsForced(short value);
    ///Gets and sets a handle to the parent window that can contain a dialog box. This property is read/write.
    HRESULT get_ParentHwnd(HWND* retval);
    ///Gets and sets a handle to the parent window that can contain a dialog box. This property is read/write.
    HRESULT put_ParentHwnd(HWND value);
    ///Gets and sets the interface that represents the parent window that can contain a dialog box. This property is
    ///read/write.
    HRESULT put_ParentWindow(IUnknown value);
    ///Gets and sets the interface that represents the parent window that can contain a dialog box. This property is
    ///read/write.
    HRESULT get_ParentWindow(IUnknown* retval);
    ///Gets and sets an interface that contains a read-only collection of the updates that are specified for
    ///installation or uninstallation. This property is read/write.
    HRESULT get_Updates(IUpdateCollection* retval);
    ///Gets and sets an interface that contains a read-only collection of the updates that are specified for
    ///installation or uninstallation. This property is read/write.
    HRESULT put_Updates(IUpdateCollection value);
    ///Starts an asynchronous installation of the updates.
    ///Params:
    ///    onProgressChanged = An IInstallationProgressChangedCallback interface that is called periodically for installation progress
    ///                        changes before the installation is complete.
    ///    onCompleted = An IInstallationCompletedCallback interface that is called when an installation operation is complete.
    ///    state = The caller-specific state that is returned by the AsyncState property of the IInstallationJob interface.
    ///    retval = An IInstallationJob interface that contains the properties and methods that are available to an asynchronous
    ///             installation operation that was initiated.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values and other COM or Windows error codes. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl>
    ///    </td> <td width="60%"> The asynchronous installation of an update started successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WU_E_INSTALL_NOT_ALLOWED</b></dt> </dl> </td> <td width="60%"> You cannot call this
    ///    method when the installer is installing or removing an update. Only call this method when the IsBusy property
    ///    of the IUpdateInstaller interface returns <b>VARIANT_FALSE</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WU_E_NO_UPDATE</b></dt> </dl> </td> <td width="60%"> Windows Update Agent (WUA) does not have updates
    ///    in the collection. </td> </tr> </table>
    ///    
    HRESULT BeginInstall(IUnknown onProgressChanged, IUnknown onCompleted, VARIANT state, IInstallationJob* retval);
    ///Starts an asynchronous uninstallation of the updates.
    ///Params:
    ///    onProgressChanged = An IInstallationProgressChangedCallback interface that is called periodically for uninstallation progress
    ///                        changes before before the uninstallation is complete.
    ///    onCompleted = An IInstallationCompletedCallback interface that is called when an installation operation is complete.
    ///    state = The caller-specific state that the AsyncState property IInstallationJob interface returns.
    ///    retval = An IInstallationJob interface that contains the properties and methods that are available to an asynchronous
    ///             uninstall operation that was initiated.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values and other COM or Windows error codes. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl>
    ///    </td> <td width="60%"> The asynchronous removal of an update started successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>WU_E_INSTALL_NOT_ALLOWED</b></dt> </dl> </td> <td width="60%"> Do not call this
    ///    method when the installer is installing or removing an update. Call this method only when the IsBusy property
    ///    of the IUpdateInstaller interface returns <b>VARIANT_FALSE</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WU_E_NO_UPDATE</b></dt> </dl> </td> <td width="60%"> Windows Update Agent (WUA) does not have updates
    ///    in the collection. </td> </tr> </table>
    ///    
    HRESULT BeginUninstall(IUnknown onProgressChanged, IUnknown onCompleted, VARIANT state, 
                           IInstallationJob* retval);
    ///Completes an asynchronous installation of the updates.
    ///Params:
    ///    value = The IInstallationJob interface that is returned by the BeginInstall method.
    ///    retval = An IInstallationResult interface that represents the overall result of the installation operation.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT EndInstall(IInstallationJob value, IInstallationResult* retval);
    ///Completes an asynchronous uninstallation of the updates.
    ///Params:
    ///    value = The IInstallationJob interface that the BeginUninstall method returns.
    ///    retval = An IInstallationResult interface that represents the overall result of an uninstallation operation.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT EndUninstall(IInstallationJob value, IInstallationResult* retval);
    ///Starts a synchronous installation of the updates.
    ///Params:
    ///    retval = An IInstallationResult interface that represents the results of an installation operation for each update
    ///             that is specified in a request.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values and other COM or Windows error codes. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl>
    ///    </td> <td width="60%"> The update was installed successfully. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WU_E_INSTALL_NOT_ALLOWED</b></dt> </dl> </td> <td width="60%"> Do not call this method when the
    ///    installer is installing or removing an update. Call this method only when the IsBusy property of the
    ///    IUpdateInstaller interface returns <b>VARIANT_FALSE</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WU_E_NO_UPDATE</b></dt> </dl> </td> <td width="60%"> There are no updates in a collection. </td> </tr>
    ///    </table>
    ///    
    HRESULT Install(IInstallationResult* retval);
    ///Starts a wizard that guides the local user through the steps to install the updates.
    ///Params:
    ///    dialogTitle = An optional string value to be displayed in the title bar of the wizard. If an empty string value is used,
    ///                  the following text is displayed: Download and Install Updates.
    ///    retval = An IInstallationResult interface that represents the results of an installation operation for each update
    ///             that is specified in the request.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values and other COM or Windows error codes. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_NO_UPDATE</b></dt>
    ///    </dl> </td> <td width="60%"> There are no updates in a collection. </td> </tr> </table>
    ///    
    HRESULT RunWizard(BSTR dialogTitle, IInstallationResult* retval);
    ///Gets a Boolean value that indicates whether an installation or uninstallation is in progress on a computer at a
    ///specific time. This property is read-only.
    HRESULT get_IsBusy(short* retval);
    ///Starts a synchronous uninstallation of the updates.
    ///Params:
    ///    retval = An IInstallationResult interface that represents the results of an uninstallation operation for each update
    ///             that is specified in a request.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values and other COM or Windows error codes. <table> <tr>
    ///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl>
    ///    </td> <td width="60%"> An update uninstalled successfully. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WU_E_INSTALL_NOT_ALLOWED</b></dt> </dl> </td> <td width="60%"> Do not call this method when the
    ///    installer is installing or removing an update. Call this method only when the IsBusy property of the
    ///    IUpdateInstaller interface returns <b>VARIANT_FALSE</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WU_E_NO_UPDATE</b></dt> </dl> </td> <td width="60%"> There are no updates in a collection. </td> </tr>
    ///    </table>
    ///    
    HRESULT Uninstall(IInstallationResult* retval);
    ///Gets and sets a Boolean value that indicates whether to show source prompts to the user when installing the
    ///updates. This property is read/write.
    HRESULT get_AllowSourcePrompts(short* retval);
    ///Gets and sets a Boolean value that indicates whether to show source prompts to the user when installing the
    ///updates. This property is read/write.
    HRESULT put_AllowSourcePrompts(short value);
    ///Gets a Boolean value that indicates whether a system restart is required before installing or uninstalling
    ///updates. This property is read-only.
    HRESULT get_RebootRequiredBeforeInstallation(short* retval);
}

///Installs or uninstalls updates on a computer.
@GUID("3442D4FE-224D-4CEE-98CF-30E0C4D229E6")
interface IUpdateInstaller2 : IUpdateInstaller
{
    ///Gets and sets a Boolean value that indicates whether Windows Installer is forced to install the updates without
    ///user interaction. This property is read/write.
    HRESULT get_ForceQuiet(short* retval);
    ///Gets and sets a Boolean value that indicates whether Windows Installer is forced to install the updates without
    ///user interaction. This property is read/write.
    HRESULT put_ForceQuiet(short value);
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] <p class="CCE_Message">[This interface is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions.] Installs or uninstalls updates on a
///computer. This property is only used when installing Microsoft Store app updates. It has no effect when installing
///non-Microsoft Store app updates such as operating system, Defender, or driver updates.
@GUID("16D11C35-099A-48D0-8338-5FAE64047F8E")
interface IUpdateInstaller3 : IUpdateInstaller2
{
    ///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified
    ///before it's commercially released. Microsoft makes no warranties, express or implied, with respect to the
    ///information provided here.] <p class="CCE_Message">[This method is available for use in the operating systems
    ///specified in the Requirements section. It may be altered or unavailable in subsequent versions.] Gets a value
    ///indicating whether the update installer will attempt to close applications, blocking immediate installation of
    ///updates.
    ///Params:
    ///    retval = True if the installer will attempt to close applications.
    ///Returns:
    ///    Returns S_OK on success.
    ///    
    HRESULT get_AttemptCloseAppsIfNecessary(short* retval);
    ///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified
    ///before it's commercially released. Microsoft makes no warranties, express or implied, with respect to the
    ///information provided here.] <p class="CCE_Message">[This method is available for use in the operating systems
    ///specified in the Requirements section. It may be altered or unavailable in subsequent versions.] Sets a value
    ///indicating whether the update installer will attempt to close applications, blocking immediate installation of
    ///updates.
    ///Params:
    ///    value = Set to True if the installer should attempt to close applications.
    ///Returns:
    ///    Returns S_OK on success.
    ///    
    HRESULT put_AttemptCloseAppsIfNecessary(short value);
}

///Provides methods to finalize updates that were previously staged or installed.
@GUID("EF8208EA-2304-492D-9109-23813B0958E1")
interface IUpdateInstaller4 : IUpdateInstaller3
{
    ///Finalizes updates that were previously staged or installed.
    ///Params:
    ///    dwFlags = Reserved for future use.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT Commit(uint dwFlags);
}

///Represents a session in which the caller can perform operations that involve updates. For example, this interface
///represents sessions in which the caller performs a search, download, installation, or uninstallation operation.
@GUID("816858A4-260D-4260-933A-2585F1ABC76B")
interface IUpdateSession : IDispatch
{
    ///Gets and sets the current client application. This property is read/write.
    HRESULT get_ClientApplicationID(BSTR* retval);
    ///Gets and sets the current client application. This property is read/write.
    HRESULT put_ClientApplicationID(BSTR value);
    ///Gets a Boolean value that indicates whether the session object is read-only. This property is read-only.
    HRESULT get_ReadOnly(short* retval);
    ///Gets and sets the proxy settings that are used to access the server. This property is read/write.
    HRESULT get_WebProxy(IWebProxy* retval);
    ///Gets and sets the proxy settings that are used to access the server. This property is read/write.
    HRESULT put_WebProxy(IWebProxy value);
    ///Returns an IUpdateSearcher interface for this session.
    ///Params:
    ///    retval = An IUpdateSearcher interface for this session.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, a COM or Windows error code. This method can also return the
    ///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A parameter value is invalid. </td> </tr>
    ///    </table>
    ///    
    HRESULT CreateUpdateSearcher(IUpdateSearcher* retval);
    ///Returns an IUpdateDownloader interface for this session.
    ///Params:
    ///    retval = An IUpdateDownloader interface for this session.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A parameter value is invalid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> This
    ///    method cannot be called from a remote computer. </td> </tr> </table>
    ///    
    HRESULT CreateUpdateDownloader(IUpdateDownloader* retval);
    ///Returns an IUpdateInstaller interface for this session.
    ///Params:
    ///    retval = An IUpdateInstaller interface for this session.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A parameter value is invalid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> This
    ///    method cannot be called from a remote computer. </td> </tr> </table>
    ///    
    HRESULT CreateUpdateInstaller(IUpdateInstaller* retval);
}

///Represents a session in which the caller can perform operations that involve updates. For example, this interface
///represents sessions in which the caller performs a search, download, installation, or uninstallation operation.
@GUID("91CAF7B0-EB23-49ED-9937-C52D817F46F7")
interface IUpdateSession2 : IUpdateSession
{
    ///Gets and sets the preferred locale for which update information is retrieved.. If you do not specify the locale,
    ///the default is the user locale that GetUserDefaultUILanguage returns. If the information is not available in a
    ///specified locale or in the user locale, Windows Update Agent (WUA) tries to retrieve the information from the
    ///default update locale. This property is read/write.
    HRESULT get_UserLocale(uint* retval);
    ///Gets and sets the preferred locale for which update information is retrieved.. If you do not specify the locale,
    ///the default is the user locale that GetUserDefaultUILanguage returns. If the information is not available in a
    ///specified locale or in the user locale, Windows Update Agent (WUA) tries to retrieve the information from the
    ///default update locale. This property is read/write.
    HRESULT put_UserLocale(uint lcid);
}

///Represents a session in which the caller can perform operations that involve updates. For example, this interface
///represents sessions in which the caller performs a search, download, installation, or uninstallation operation.
@GUID("918EFD1E-B5D8-4C90-8540-AEB9BDC56F9D")
interface IUpdateSession3 : IUpdateSession2
{
    ///Returns a pointer to an IUpdateServiceManager2 interface for the session.
    ///Params:
    ///    retval = A pointer to an IUpdateServiceManager2 interface for the session.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT CreateUpdateServiceManager(IUpdateServiceManager2* retval);
    ///Synchronously queries the computer for the history of update events. This method method returns a pointer to an
    ///IUpdateHistoryEntryCollection interface that contains matching event records on the computer.
    ///Params:
    ///    criteria = A string that specifies the search criteria.
    ///    startIndex = The index of the first event to retrieve.
    ///    count = The number of events to retrieve.
    ///    retval = A pointer to an IUpdateHistoryEntryCollection interface that contains the matching event records on the
    ///             computer in descending chronological order.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A parameter value is invalid or
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_INVALID_CRITERIA</b></dt> </dl> </td> <td
    ///    width="60%"> There is an invalid search criteria. </td> </tr> </table>
    ///    
    HRESULT QueryHistory(BSTR criteria, int startIndex, int count, IUpdateHistoryEntryCollection* retval);
}

///Contains information about a service that is registered with Windows Update Agent (WUA) or with Automatic Updates.
@GUID("76B3B17E-AED6-4DA5-85F0-83587F81ABE3")
interface IUpdateService : IDispatch
{
    ///Gets the name of the service. This property is read-only.
    HRESULT get_Name(BSTR* retval);
    ///Gets an SHA-1 hash of the certificate that is used to sign the contents of the service. This property is
    ///read-only.
    HRESULT get_ContentValidationCert(VARIANT* retval);
    ///Gets the date on which the authorization cabinet file expires. This property is read-only.
    HRESULT get_ExpirationDate(double* retval);
    ///Gets a Boolean value that indicates whether a service is a managed service. This property is read-only.
    HRESULT get_IsManaged(short* retval);
    ///Gets a Boolean value that indicates whether a service is registered with Automatic Updates. This property is
    ///read-only.
    HRESULT get_IsRegisteredWithAU(short* retval);
    ///Gets the date on which the authorization cabinet file was issued. This property is read-only.
    HRESULT get_IssueDate(double* retval);
    ///Gets a Boolean value indicates whether the current service offers updates from Windows Updates. This property is
    ///read-only.
    HRESULT get_OffersWindowsUpdates(short* retval);
    ///The <b>RedirectUrls</b> property contains the URLs for the redirector cabinet file. This property is read-only.
    HRESULT get_RedirectUrls(IStringCollection* retval);
    ///The <b>ServiceID</b> property retrieves or sets the identifier for a service. This property is read-only.
    HRESULT get_ServiceID(BSTR* retval);
    ///Gets a Boolean value that indicates whether a service is based on a scan package. This property is read-only.
    HRESULT get_IsScanPackageService(short* retval);
    ///Gets a Boolean value that indicates whether the service can register with Automatic Updates. This property is
    ///read-only.
    HRESULT get_CanRegisterWithAU(short* retval);
    ///The <b>ServiceUrl</b> property retrieves the URL for the service. This property is read-only.
    HRESULT get_ServiceUrl(BSTR* retval);
    ///The <b>SetupPrefix</b> property identifies the prefix for the setup files. This property is read-only.
    HRESULT get_SetupPrefix(BSTR* retval);
}

///Contains information about a service that is registered with Windows Update Agent (WUA) or with Automatic Updates.
@GUID("1518B460-6518-4172-940F-C75883B24CEB")
interface IUpdateService2 : IUpdateService
{
    ///Gets a Boolean value that indicates whether the service is registered with Automatic Updates and whether the
    ///service is currently used by Automatic Updates as the default service. This property is read-only.
    HRESULT get_IsDefaultAUService(short* retval);
}

///Represents a list of IUpdateService interfaces.
@GUID("9B0353AA-0E52-44FF-B8B0-1F7FA0437F88")
interface IUpdateServiceCollection : IDispatch
{
    ///Gets and sets an IUpdateService interface in a collection. This property is read-only.
    HRESULT get_Item(int index, IUpdateService* retval);
    ///Gets an IEnumVARIANT interface that can be used to enumerate the collection. This property is read-only.
    HRESULT get__NewEnum(IUnknown* retval);
    ///Gets the number of elements in the collection. This property is read-only.
    HRESULT get_Count(int* retval);
}

///Contains information about the registration state of a service.
@GUID("DDE02280-12B3-4E0B-937B-6747F6ACB286")
interface IUpdateServiceRegistration : IDispatch
{
    ///Gets an UpdateServiceRegistrationState value that indicates the current state of the service registration. This
    ///property is read-only.
    HRESULT get_RegistrationState(UpdateServiceRegistrationState* retval);
    HRESULT get_ServiceID(BSTR* retval);
    ///Gets a Boolean value that indicates whether the service will also be registered with Automatic Updates, when
    ///added. The authorization cabinet file (.cab) of the service determines whether the service can be added. This
    ///property is read-only.
    HRESULT get_IsPendingRegistrationWithAU(short* retval);
    ///Gets a pointer to an IUpdateService2 interface. This property is the default property. This property is
    ///read-only.
    HRESULT get_Service(IUpdateService2* retval);
}

///Adds or removes the registration of the update service with Windows Update Agent or Automatic Updates.
@GUID("23857E3C-02BA-44A3-9423-B1C900805F37")
interface IUpdateServiceManager : IDispatch
{
    ///Gets an IUpdateServiceCollection of the services that are registered with WUA. This property is read-only.
    HRESULT get_Services(IUpdateServiceCollection* retval);
    ///Registers a service with Windows Update Agent (WUA).
    ///Params:
    ///    serviceID = An identifier for a service to be registered.
    ///    authorizationCabPath = The path of the Microsoft signed local cabinet file that has the information that is required for a service
    ///                           registration.
    ///    retval = An IUpdateService interface that represents an added service.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> A parameter value is invalid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> This
    ///    method cannot be called from a remote computer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WU_E_DS_SERVICEEXPIRED</b></dt> </dl> </td> <td width="60%"> The Authorization Cab has expired. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_DS_INVALIDOPERATION</b></dt> </dl> </td> <td width="60%"> The
    ///    state of Automatic Updates could not be changed. </td> </tr> </table>
    ///    
    HRESULT AddService(BSTR serviceID, BSTR authorizationCabPath, IUpdateService* retval);
    ///Registers a service with Automatic Updates.
    ///Params:
    ///    serviceID = An identifier for the service to be registered.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> A parameter value is invalid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> This
    ///    method cannot be called from a remote computer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WU_E_DS_UNKNOWNSERVICE</b></dt> </dl> </td> <td width="60%"> An attempt to register an unknown
    ///    service. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_DS_NEEDWINDOWSSERVICE</b></dt> </dl> </td> <td
    ///    width="60%"> The Windows Update service could not be removed. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WU_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The computer could not access the update
    ///    site, or the state of Automatic Updates could not be changed. </td> </tr> </table>
    ///    
    HRESULT RegisterServiceWithAU(BSTR serviceID);
    ///Removes a service registration from Windows Update Agent (WUA).
    ///Params:
    ///    serviceID = An identifier for the service to be unregistered.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> A parameter value was invalid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> This
    ///    method cannot be called from a remote computer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WU_E_DS_NEEDWINDOWSSERVICE</b></dt> </dl> </td> <td width="60%"> The Windows Update service could not
    ///    be removed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_DS_INVALIDOPERATION</b></dt> </dl> </td> <td
    ///    width="60%"> The state of Automatic Updates could not be changed. This error is returned if you try to delete
    ///    the service. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_DS_UNKNOWNSERVICE</b></dt> </dl> </td> <td
    ///    width="60%"> Attempt to register or remove an unknown service. </td> </tr> </table>
    ///    
    HRESULT RemoveService(BSTR serviceID);
    ///Unregisters a service with Automatic Updates.
    ///Params:
    ///    serviceID = An identifier for the service to be unregistered.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> A parameter value is invalid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> This
    ///    method cannot be called from a remote computer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WU_E_DS_NEEDWINDOWSSERVICE</b></dt> </dl> </td> <td width="60%"> The Windows Update service could not
    ///    be removed. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_DS_INVALIDOPERATION</b></dt> </dl> </td> <td
    ///    width="60%"> The state of Automatic Updates could not be changed. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WU_E_DS_UNKNOWNSERVICE</b></dt> </dl> </td> <td width="60%"> Attempt to register an unknown service.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%">
    ///    The computer could not access the update site. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WU_E_CALL_CANCELLED</b></dt> </dl> </td> <td width="60%"> The user canceled the change. </td> </tr>
    ///    </table>
    ///    
    HRESULT UnregisterServiceWithAU(BSTR serviceID);
    ///Registers a scan package as a service with Windows Update Agent (WUA) and then returns an IUpdateService
    ///interface.
    ///Params:
    ///    serviceName = A descriptive name for the scan package service.
    ///    scanFileLocation = The path of the Microsoft signed scan file that has to be registered as a service.
    ///    flags = Determines how to remove the service registration of the scan package. For possible values, see
    ///            UpdateServiceOption.
    ///    ppService = A pointer to an IUpdateService interface that contains service registration information.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> A parameter value is invalid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> This
    ///    method cannot be called from a remote computer. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WU_E_INVALID_OPERATION</b></dt> </dl> </td> <td width="60%"> The computer could not access the update
    ///    site. </td> </tr> </table>
    ///    
    HRESULT AddScanPackageService(BSTR serviceName, BSTR scanFileLocation, int flags, IUpdateService* ppService);
    ///Set options for the object that specifies the service ID. The <b>SetOption</b> method is also used to determine
    ///whether a warning is displayed when you change the registration of Automatic Updates.
    ///Params:
    ///    optionName = Set this parameter to AllowedServiceID to specify the form of the service ID that is provided to the object.
    ///                 Set to AllowWarningUI to display a warning when changing the Automatic Updates registration.
    ///    optionValue = If the <i>optionName</i> parameter is set to AllowServiceID, the <i>optionValue</i> parameter is set to the
    ///                  service ID that is provided as a <b>VT_BSTR</b> value. If <i>optionName</i> is set to AllowWarningUI,
    ///                  <i>optionValue</i> is a <b>VT_BOOL</b> value that specifies whether to display a warning when changing the
    ///                  registration of Automatic Updates. Set the optionValue parameter to VARIANT_TRUE to display the warning UI.
    ///                  Set it to VARIANT_FALSE to suppress the warning UI.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_INVALID_OPERATION</b></dt> </dl>
    ///    </td> <td width="60%"> The computer is not allowed to access the update site. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> An argument of the method is
    ///    invalid. </td> </tr> </table>
    ///    
    HRESULT SetOption(BSTR optionName, VARIANT optionValue);
}

///Adds or removes the registration of the update service with Windows Update Agent or Automatic Updates.
@GUID("0BB8531D-7E8D-424F-986C-A0B8F60A3E7B")
interface IUpdateServiceManager2 : IUpdateServiceManager
{
    ///Gets and sets the identifier of the current client application. This property is read/write.
    HRESULT get_ClientApplicationID(BSTR* retval);
    ///Gets and sets the identifier of the current client application. This property is read/write.
    HRESULT put_ClientApplicationID(BSTR value);
    ///Returns a pointer to an IUpdateServiceRegistration interface.
    ///Params:
    ///    serviceID = An identifier for the service to be registered.
    ///    retval = A pointer to an IUpdateServiceRegistration interface that represents an added service.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT QueryServiceRegistration(BSTR serviceID, IUpdateServiceRegistration* retval);
    ///Registers a service with Windows Update Agent (WUA) without requiring an authorization cabinet file (.cab). This
    ///method also returns a pointer to an IUpdateServiceRegistration interface.
    ///Params:
    ///    serviceID = An identifier for the service to be registered.
    ///    flags = A combination of AddServiceFlag values that are combined by using a bitwise OR operation. The resulting value
    ///            specifies options for service registration. For more info, see Remarks.
    ///    authorizationCabPath = The path of the Microsoft signed local cabinet file (.cab) that has the information that is required for a
    ///                           service registration. If empty, the update agent searches for the authorization cabinet file (.cab) during
    ///                           service registration when a network connection is available.
    ///    retval = A pointer to an IUpdateServiceRegistration interface that represents an added service.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code. This method can also
    ///    return the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> A parameter value is invalid.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> This
    ///    method cannot be called from a remote computer if the <i>authorizationCabPath</i> parameter is set to a null
    ///    string. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>WU_E_DS_SERVICEEXPIRED</b></dt> </dl> </td> <td
    ///    width="60%"> The authorization cabinet file (.cab) has expired. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>WU_E_DS_INVALIDOPERATION</b></dt> </dl> </td> <td width="60%"> The state of Automatic Updates could
    ///    not be changed. </td> </tr> </table>
    ///    
    HRESULT AddService2(BSTR serviceID, int flags, BSTR authorizationCabPath, IUpdateServiceRegistration* retval);
}

///Records the result for an update.
@GUID("925CBC18-A2EA-4648-BF1C-EC8BADCFE20A")
interface IInstallationAgent : IDispatch
{
    ///Records the result for an update. The result is specified by an IStringCollection object.
    ///Params:
    ///    installationResultCookie = A string value that identifies the result cookie.
    ///    hresult = The identifier of the result.
    ///    extendedReportingData = An IStringCollection interface that represents a collection of strings that contain the result for an update.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
    HRESULT RecordInstallationResult(BSTR installationResultCookie, int hresult, 
                                     IStringCollection extendedReportingData);
}


// GUIDs

const GUID CLSID_AutomaticUpdates       = GUIDOF!AutomaticUpdates;
const GUID CLSID_InstallationAgent      = GUIDOF!InstallationAgent;
const GUID CLSID_StringCollection       = GUIDOF!StringCollection;
const GUID CLSID_SystemInformation      = GUIDOF!SystemInformation;
const GUID CLSID_UpdateCollection       = GUIDOF!UpdateCollection;
const GUID CLSID_UpdateDownloader       = GUIDOF!UpdateDownloader;
const GUID CLSID_UpdateInstaller        = GUIDOF!UpdateInstaller;
const GUID CLSID_UpdateSearcher         = GUIDOF!UpdateSearcher;
const GUID CLSID_UpdateServiceManager   = GUIDOF!UpdateServiceManager;
const GUID CLSID_UpdateSession          = GUIDOF!UpdateSession;
const GUID CLSID_WebProxy               = GUIDOF!WebProxy;
const GUID CLSID_WindowsUpdateAgentInfo = GUIDOF!WindowsUpdateAgentInfo;

const GUID IID_IAutomaticUpdates                        = GUIDOF!IAutomaticUpdates;
const GUID IID_IAutomaticUpdates2                       = GUIDOF!IAutomaticUpdates2;
const GUID IID_IAutomaticUpdatesResults                 = GUIDOF!IAutomaticUpdatesResults;
const GUID IID_IAutomaticUpdatesSettings                = GUIDOF!IAutomaticUpdatesSettings;
const GUID IID_IAutomaticUpdatesSettings2               = GUIDOF!IAutomaticUpdatesSettings2;
const GUID IID_IAutomaticUpdatesSettings3               = GUIDOF!IAutomaticUpdatesSettings3;
const GUID IID_ICategory                                = GUIDOF!ICategory;
const GUID IID_ICategoryCollection                      = GUIDOF!ICategoryCollection;
const GUID IID_IDownloadCompletedCallback               = GUIDOF!IDownloadCompletedCallback;
const GUID IID_IDownloadCompletedCallbackArgs           = GUIDOF!IDownloadCompletedCallbackArgs;
const GUID IID_IDownloadJob                             = GUIDOF!IDownloadJob;
const GUID IID_IDownloadProgress                        = GUIDOF!IDownloadProgress;
const GUID IID_IDownloadProgressChangedCallback         = GUIDOF!IDownloadProgressChangedCallback;
const GUID IID_IDownloadProgressChangedCallbackArgs     = GUIDOF!IDownloadProgressChangedCallbackArgs;
const GUID IID_IDownloadResult                          = GUIDOF!IDownloadResult;
const GUID IID_IImageInformation                        = GUIDOF!IImageInformation;
const GUID IID_IInstallationAgent                       = GUIDOF!IInstallationAgent;
const GUID IID_IInstallationBehavior                    = GUIDOF!IInstallationBehavior;
const GUID IID_IInstallationCompletedCallback           = GUIDOF!IInstallationCompletedCallback;
const GUID IID_IInstallationCompletedCallbackArgs       = GUIDOF!IInstallationCompletedCallbackArgs;
const GUID IID_IInstallationJob                         = GUIDOF!IInstallationJob;
const GUID IID_IInstallationProgress                    = GUIDOF!IInstallationProgress;
const GUID IID_IInstallationProgressChangedCallback     = GUIDOF!IInstallationProgressChangedCallback;
const GUID IID_IInstallationProgressChangedCallbackArgs = GUIDOF!IInstallationProgressChangedCallbackArgs;
const GUID IID_IInstallationResult                      = GUIDOF!IInstallationResult;
const GUID IID_IInvalidProductLicenseException          = GUIDOF!IInvalidProductLicenseException;
const GUID IID_ISearchCompletedCallback                 = GUIDOF!ISearchCompletedCallback;
const GUID IID_ISearchCompletedCallbackArgs             = GUIDOF!ISearchCompletedCallbackArgs;
const GUID IID_ISearchJob                               = GUIDOF!ISearchJob;
const GUID IID_ISearchResult                            = GUIDOF!ISearchResult;
const GUID IID_IStringCollection                        = GUIDOF!IStringCollection;
const GUID IID_ISystemInformation                       = GUIDOF!ISystemInformation;
const GUID IID_IUpdate                                  = GUIDOF!IUpdate;
const GUID IID_IUpdate2                                 = GUIDOF!IUpdate2;
const GUID IID_IUpdate3                                 = GUIDOF!IUpdate3;
const GUID IID_IUpdate4                                 = GUIDOF!IUpdate4;
const GUID IID_IUpdate5                                 = GUIDOF!IUpdate5;
const GUID IID_IUpdateCollection                        = GUIDOF!IUpdateCollection;
const GUID IID_IUpdateDownloadContent                   = GUIDOF!IUpdateDownloadContent;
const GUID IID_IUpdateDownloadContent2                  = GUIDOF!IUpdateDownloadContent2;
const GUID IID_IUpdateDownloadContentCollection         = GUIDOF!IUpdateDownloadContentCollection;
const GUID IID_IUpdateDownloadResult                    = GUIDOF!IUpdateDownloadResult;
const GUID IID_IUpdateDownloader                        = GUIDOF!IUpdateDownloader;
const GUID IID_IUpdateException                         = GUIDOF!IUpdateException;
const GUID IID_IUpdateExceptionCollection               = GUIDOF!IUpdateExceptionCollection;
const GUID IID_IUpdateHistoryEntry                      = GUIDOF!IUpdateHistoryEntry;
const GUID IID_IUpdateHistoryEntry2                     = GUIDOF!IUpdateHistoryEntry2;
const GUID IID_IUpdateHistoryEntryCollection            = GUIDOF!IUpdateHistoryEntryCollection;
const GUID IID_IUpdateIdentity                          = GUIDOF!IUpdateIdentity;
const GUID IID_IUpdateInstallationResult                = GUIDOF!IUpdateInstallationResult;
const GUID IID_IUpdateInstaller                         = GUIDOF!IUpdateInstaller;
const GUID IID_IUpdateInstaller2                        = GUIDOF!IUpdateInstaller2;
const GUID IID_IUpdateInstaller3                        = GUIDOF!IUpdateInstaller3;
const GUID IID_IUpdateInstaller4                        = GUIDOF!IUpdateInstaller4;
const GUID IID_IUpdateLockdown                          = GUIDOF!IUpdateLockdown;
const GUID IID_IUpdateSearcher                          = GUIDOF!IUpdateSearcher;
const GUID IID_IUpdateSearcher2                         = GUIDOF!IUpdateSearcher2;
const GUID IID_IUpdateSearcher3                         = GUIDOF!IUpdateSearcher3;
const GUID IID_IUpdateService                           = GUIDOF!IUpdateService;
const GUID IID_IUpdateService2                          = GUIDOF!IUpdateService2;
const GUID IID_IUpdateServiceCollection                 = GUIDOF!IUpdateServiceCollection;
const GUID IID_IUpdateServiceManager                    = GUIDOF!IUpdateServiceManager;
const GUID IID_IUpdateServiceManager2                   = GUIDOF!IUpdateServiceManager2;
const GUID IID_IUpdateServiceRegistration               = GUIDOF!IUpdateServiceRegistration;
const GUID IID_IUpdateSession                           = GUIDOF!IUpdateSession;
const GUID IID_IUpdateSession2                          = GUIDOF!IUpdateSession2;
const GUID IID_IUpdateSession3                          = GUIDOF!IUpdateSession3;
const GUID IID_IWebProxy                                = GUIDOF!IWebProxy;
const GUID IID_IWindowsDriverUpdate                     = GUIDOF!IWindowsDriverUpdate;
const GUID IID_IWindowsDriverUpdate2                    = GUIDOF!IWindowsDriverUpdate2;
const GUID IID_IWindowsDriverUpdate3                    = GUIDOF!IWindowsDriverUpdate3;
const GUID IID_IWindowsDriverUpdate4                    = GUIDOF!IWindowsDriverUpdate4;
const GUID IID_IWindowsDriverUpdate5                    = GUIDOF!IWindowsDriverUpdate5;
const GUID IID_IWindowsDriverUpdateEntry                = GUIDOF!IWindowsDriverUpdateEntry;
const GUID IID_IWindowsDriverUpdateEntryCollection      = GUIDOF!IWindowsDriverUpdateEntryCollection;
const GUID IID_IWindowsUpdateAgentInfo                  = GUIDOF!IWindowsUpdateAgentInfo;
