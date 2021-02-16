module windows.windowsupdateagent;

public import windows.core;
public import windows.automation : BSTR, IDispatch, VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : DECIMAL;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Enums


enum AutomaticUpdatesNotificationLevel : int
{
    aunlNotConfigured            = 0x00000000,
    aunlDisabled                 = 0x00000001,
    aunlNotifyBeforeDownload     = 0x00000002,
    aunlNotifyBeforeInstallation = 0x00000003,
    aunlScheduledInstallation    = 0x00000004,
}

enum AutomaticUpdatesScheduledInstallationDay : int
{
    ausidEveryDay       = 0x00000000,
    ausidEverySunday    = 0x00000001,
    ausidEveryMonday    = 0x00000002,
    ausidEveryTuesday   = 0x00000003,
    ausidEveryWednesday = 0x00000004,
    ausidEveryThursday  = 0x00000005,
    ausidEveryFriday    = 0x00000006,
    ausidEverySaturday  = 0x00000007,
}

enum DownloadPhase : int
{
    dphInitializing = 0x00000001,
    dphDownloading  = 0x00000002,
    dphVerifying    = 0x00000003,
}

enum DownloadPriority : int
{
    dpLow       = 0x00000001,
    dpNormal    = 0x00000002,
    dpHigh      = 0x00000003,
    dpExtraHigh = 0x00000004,
}

enum AutoSelectionMode : int
{
    asLetWindowsUpdateDecide = 0x00000000,
    asAutoSelectIfDownloaded = 0x00000001,
    asNeverAutoSelect        = 0x00000002,
    asAlwaysAutoSelect       = 0x00000003,
}

enum AutoDownloadMode : int
{
    adLetWindowsUpdateDecide = 0x00000000,
    adNeverAutoDownload      = 0x00000001,
    adAlwaysAutoDownload     = 0x00000002,
}

enum InstallationImpact : int
{
    iiNormal                    = 0x00000000,
    iiMinor                     = 0x00000001,
    iiRequiresExclusiveHandling = 0x00000002,
}

enum InstallationRebootBehavior : int
{
    irbNeverReboots         = 0x00000000,
    irbAlwaysRequiresReboot = 0x00000001,
    irbCanRequestReboot     = 0x00000002,
}

enum OperationResultCode : int
{
    orcNotStarted          = 0x00000000,
    orcInProgress          = 0x00000001,
    orcSucceeded           = 0x00000002,
    orcSucceededWithErrors = 0x00000003,
    orcFailed              = 0x00000004,
    orcAborted             = 0x00000005,
}

enum ServerSelection : int
{
    ssDefault       = 0x00000000,
    ssManagedServer = 0x00000001,
    ssWindowsUpdate = 0x00000002,
    ssOthers        = 0x00000003,
}

enum UpdateType : int
{
    utSoftware = 0x00000001,
    utDriver   = 0x00000002,
}

enum UpdateOperation : int
{
    uoInstallation   = 0x00000001,
    uoUninstallation = 0x00000002,
}

enum DeploymentAction : int
{
    daNone                 = 0x00000000,
    daInstallation         = 0x00000001,
    daUninstallation       = 0x00000002,
    daDetection            = 0x00000003,
    daOptionalInstallation = 0x00000004,
}

enum UpdateExceptionContext : int
{
    uecGeneral          = 0x00000001,
    uecWindowsDriver    = 0x00000002,
    uecWindowsInstaller = 0x00000003,
    uecSearchIncomplete = 0x00000004,
}

enum AutomaticUpdatesUserType : int
{
    auutCurrentUser        = 0x00000001,
    auutLocalAdministrator = 0x00000002,
}

enum AutomaticUpdatesPermissionType : int
{
    auptSetNotificationLevel         = 0x00000001,
    auptDisableAutomaticUpdates      = 0x00000002,
    auptSetIncludeRecommendedUpdates = 0x00000003,
    auptSetFeaturedUpdatesEnabled    = 0x00000004,
    auptSetNonAdministratorsElevated = 0x00000005,
}

enum UpdateServiceRegistrationState : int
{
    usrsNotRegistered       = 0x00000001,
    usrsRegistrationPending = 0x00000002,
    usrsRegistered          = 0x00000003,
}

enum SearchScope : int
{
    searchScopeDefault               = 0x00000000,
    searchScopeMachineOnly           = 0x00000001,
    searchScopeCurrentUserOnly       = 0x00000002,
    searchScopeMachineAndCurrentUser = 0x00000003,
    searchScopeMachineAndAllUsers    = 0x00000004,
    searchScopeAllUsers              = 0x00000005,
}

enum UpdateLockdownOption : int
{
    uloForWebsiteAccess = 0x00000001,
}

enum AddServiceFlag : int
{
    asfAllowPendingRegistration = 0x00000001,
    asfAllowOnlineRegistration  = 0x00000002,
    asfRegisterServiceWithAU    = 0x00000004,
}

enum UpdateServiceOption : int
{
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

@GUID("A976C28D-75A1-42AA-94AE-8AF8B872089A")
interface IUpdateLockdown : IUnknown
{
    HRESULT LockDown(int flags);
}

@GUID("EFF90582-2DDC-480F-A06D-60F3FBC362C3")
interface IStringCollection : IDispatch
{
    HRESULT get_Item(int index, BSTR* retval);
    HRESULT put_Item(int index, BSTR value);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Count(int* retval);
    HRESULT get_ReadOnly(short* retval);
    HRESULT Add(BSTR value, int* retval);
    HRESULT Clear();
    HRESULT Copy(IStringCollection* retval);
    HRESULT Insert(int index, BSTR value);
    HRESULT RemoveAt(int index);
}

@GUID("174C81FE-AECD-4DAE-B8A0-2C6318DD86A8")
interface IWebProxy : IDispatch
{
    HRESULT get_Address(BSTR* retval);
    HRESULT put_Address(BSTR value);
    HRESULT get_BypassList(IStringCollection* retval);
    HRESULT put_BypassList(IStringCollection value);
    HRESULT get_BypassProxyOnLocal(short* retval);
    HRESULT put_BypassProxyOnLocal(short value);
    HRESULT get_ReadOnly(short* retval);
    HRESULT get_UserName(BSTR* retval);
    HRESULT put_UserName(BSTR value);
    HRESULT SetPassword(BSTR value);
    HRESULT PromptForCredentials(IUnknown parentWindow, BSTR title);
    HRESULT PromptForCredentialsFromHwnd(HWND parentWindow, BSTR title);
    HRESULT get_AutoDetect(short* retval);
    HRESULT put_AutoDetect(short value);
}

@GUID("ADE87BF7-7B56-4275-8FAB-B9B0E591844B")
interface ISystemInformation : IDispatch
{
    HRESULT get_OemHardwareSupportLink(BSTR* retval);
    HRESULT get_RebootRequired(short* retval);
}

@GUID("85713FA1-7796-4FA2-BE3B-E2D6124DD373")
interface IWindowsUpdateAgentInfo : IDispatch
{
    HRESULT GetInfo(VARIANT varInfoIdentifier, VARIANT* retval);
}

@GUID("E7A4D634-7942-4DD9-A111-82228BA33901")
interface IAutomaticUpdatesResults : IDispatch
{
    HRESULT get_LastSearchSuccessDate(VARIANT* retval);
    HRESULT get_LastInstallationSuccessDate(VARIANT* retval);
}

@GUID("2EE48F22-AF3C-405F-8970-F71BE12EE9A2")
interface IAutomaticUpdatesSettings : IDispatch
{
    HRESULT get_NotificationLevel(AutomaticUpdatesNotificationLevel* retval);
    HRESULT put_NotificationLevel(AutomaticUpdatesNotificationLevel value);
    HRESULT get_ReadOnly(short* retval);
    HRESULT get_Required(short* retval);
    HRESULT get_ScheduledInstallationDay(AutomaticUpdatesScheduledInstallationDay* retval);
    HRESULT put_ScheduledInstallationDay(AutomaticUpdatesScheduledInstallationDay value);
    HRESULT get_ScheduledInstallationTime(int* retval);
    HRESULT put_ScheduledInstallationTime(int value);
    HRESULT Refresh();
    HRESULT Save();
}

@GUID("6ABC136A-C3CA-4384-8171-CB2B1E59B8DC")
interface IAutomaticUpdatesSettings2 : IAutomaticUpdatesSettings
{
    HRESULT get_IncludeRecommendedUpdates(short* retval);
    HRESULT put_IncludeRecommendedUpdates(short value);
    HRESULT CheckPermission(AutomaticUpdatesUserType userType, AutomaticUpdatesPermissionType permissionType, 
                            short* userHasPermission);
}

@GUID("B587F5C3-F57E-485F-BBF5-0D181C5CD0DC")
interface IAutomaticUpdatesSettings3 : IAutomaticUpdatesSettings2
{
    HRESULT get_NonAdministratorsElevated(short* retval);
    HRESULT put_NonAdministratorsElevated(short value);
    HRESULT get_FeaturedUpdatesEnabled(short* retval);
    HRESULT put_FeaturedUpdatesEnabled(short value);
}

@GUID("673425BF-C082-4C7C-BDFD-569464B8E0CE")
interface IAutomaticUpdates : IDispatch
{
    HRESULT DetectNow();
    HRESULT Pause();
    HRESULT Resume();
    HRESULT ShowSettingsDialog();
    HRESULT get_Settings(IAutomaticUpdatesSettings* retval);
    HRESULT get_ServiceEnabled(short* retval);
    HRESULT EnableService();
}

@GUID("4A2F5C31-CFD9-410E-B7FB-29A653973A0F")
interface IAutomaticUpdates2 : IAutomaticUpdates
{
    HRESULT get_Results(IAutomaticUpdatesResults* retval);
}

@GUID("46297823-9940-4C09-AED9-CD3EA6D05968")
interface IUpdateIdentity : IDispatch
{
    HRESULT get_RevisionNumber(int* retval);
    HRESULT get_UpdateID(BSTR* retval);
}

@GUID("7C907864-346C-4AEB-8F3F-57DA289F969F")
interface IImageInformation : IDispatch
{
    HRESULT get_AltText(BSTR* retval);
    HRESULT get_Height(int* retval);
    HRESULT get_Source(BSTR* retval);
    HRESULT get_Width(int* retval);
}

@GUID("81DDC1B8-9D35-47A6-B471-5B80F519223B")
interface ICategory : IDispatch
{
    HRESULT get_Name(BSTR* retval);
    HRESULT get_CategoryID(BSTR* retval);
    HRESULT get_Children(ICategoryCollection* retval);
    HRESULT get_Description(BSTR* retval);
    HRESULT get_Image(IImageInformation* retval);
    HRESULT get_Order(int* retval);
    HRESULT get_Parent(ICategory* retval);
    HRESULT get_Type(BSTR* retval);
    HRESULT get_Updates(IUpdateCollection* retval);
}

@GUID("3A56BFB8-576C-43F7-9335-FE4838FD7E37")
interface ICategoryCollection : IDispatch
{
    HRESULT get_Item(int index, ICategory* retval);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Count(int* retval);
}

@GUID("D9A59339-E245-4DBD-9686-4D5763E39624")
interface IInstallationBehavior : IDispatch
{
    HRESULT get_CanRequestUserInput(short* retval);
    HRESULT get_Impact(InstallationImpact* retval);
    HRESULT get_RebootBehavior(InstallationRebootBehavior* retval);
    HRESULT get_RequiresNetworkConnectivity(short* retval);
}

@GUID("54A2CB2D-9A0C-48B6-8A50-9ABB69EE2D02")
interface IUpdateDownloadContent : IDispatch
{
    HRESULT get_DownloadUrl(BSTR* retval);
}

@GUID("C97AD11B-F257-420B-9D9F-377F733F6F68")
interface IUpdateDownloadContent2 : IUpdateDownloadContent
{
    HRESULT get_IsDeltaCompressedContent(short* retval);
}

@GUID("BC5513C8-B3B8-4BF7-A4D4-361C0D8C88BA")
interface IUpdateDownloadContentCollection : IDispatch
{
    HRESULT get_Item(int index, IUpdateDownloadContent* retval);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Count(int* retval);
}

@GUID("6A92B07A-D821-4682-B423-5C805022CC4D")
interface IUpdate : IDispatch
{
    HRESULT get_Title(BSTR* retval);
    HRESULT get_AutoSelectOnWebSites(short* retval);
    HRESULT get_BundledUpdates(IUpdateCollection* retval);
    HRESULT get_CanRequireSource(short* retval);
    HRESULT get_Categories(ICategoryCollection* retval);
    HRESULT get_Deadline(VARIANT* retval);
    HRESULT get_DeltaCompressedContentAvailable(short* retval);
    HRESULT get_DeltaCompressedContentPreferred(short* retval);
    HRESULT get_Description(BSTR* retval);
    HRESULT get_EulaAccepted(short* retval);
    HRESULT get_EulaText(BSTR* retval);
    HRESULT get_HandlerID(BSTR* retval);
    HRESULT get_Identity(IUpdateIdentity* retval);
    HRESULT get_Image(IImageInformation* retval);
    HRESULT get_InstallationBehavior(IInstallationBehavior* retval);
    HRESULT get_IsBeta(short* retval);
    HRESULT get_IsDownloaded(short* retval);
    HRESULT get_IsHidden(short* retval);
    HRESULT put_IsHidden(short value);
    HRESULT get_IsInstalled(short* retval);
    HRESULT get_IsMandatory(short* retval);
    HRESULT get_IsUninstallable(short* retval);
    HRESULT get_Languages(IStringCollection* retval);
    HRESULT get_LastDeploymentChangeTime(double* retval);
    HRESULT get_MaxDownloadSize(DECIMAL* retval);
    HRESULT get_MinDownloadSize(DECIMAL* retval);
    HRESULT get_MoreInfoUrls(IStringCollection* retval);
    HRESULT get_MsrcSeverity(BSTR* retval);
    HRESULT get_RecommendedCpuSpeed(int* retval);
    HRESULT get_RecommendedHardDiskSpace(int* retval);
    HRESULT get_RecommendedMemory(int* retval);
    HRESULT get_ReleaseNotes(BSTR* retval);
    HRESULT get_SecurityBulletinIDs(IStringCollection* retval);
    HRESULT get_SupersededUpdateIDs(IStringCollection* retval);
    HRESULT get_SupportUrl(BSTR* retval);
    HRESULT get_Type(UpdateType* retval);
    HRESULT get_UninstallationNotes(BSTR* retval);
    HRESULT get_UninstallationBehavior(IInstallationBehavior* retval);
    HRESULT get_UninstallationSteps(IStringCollection* retval);
    HRESULT get_KBArticleIDs(IStringCollection* retval);
    HRESULT AcceptEula();
    HRESULT get_DeploymentAction(DeploymentAction* retval);
    HRESULT CopyFromCache(BSTR path, short toExtractCabFiles);
    HRESULT get_DownloadPriority(DownloadPriority* retval);
    HRESULT get_DownloadContents(IUpdateDownloadContentCollection* retval);
}

@GUID("B383CD1A-5CE9-4504-9F63-764B1236F191")
interface IWindowsDriverUpdate : IUpdate
{
    HRESULT get_DriverClass(BSTR* retval);
    HRESULT get_DriverHardwareID(BSTR* retval);
    HRESULT get_DriverManufacturer(BSTR* retval);
    HRESULT get_DriverModel(BSTR* retval);
    HRESULT get_DriverProvider(BSTR* retval);
    HRESULT get_DriverVerDate(double* retval);
    HRESULT get_DeviceProblemNumber(int* retval);
    HRESULT get_DeviceStatus(int* retval);
}

@GUID("144FE9B0-D23D-4A8B-8634-FB4457533B7A")
interface IUpdate2 : IUpdate
{
    HRESULT get_RebootRequired(short* retval);
    HRESULT get_IsPresent(short* retval);
    HRESULT get_CveIDs(IStringCollection* retval);
    HRESULT CopyToCache(IStringCollection pFiles);
}

@GUID("112EDA6B-95B3-476F-9D90-AEE82C6B8181")
interface IUpdate3 : IUpdate2
{
    HRESULT get_BrowseOnly(short* retval);
}

@GUID("27E94B0D-5139-49A2-9A61-93522DC54652")
interface IUpdate4 : IUpdate3
{
    HRESULT get_PerUser(short* retval);
}

@GUID("C1C2F21A-D2F4-4902-B5C6-8A081C19A890")
interface IUpdate5 : IUpdate4
{
    HRESULT get_AutoSelection(AutoSelectionMode* retval);
    HRESULT get_AutoDownload(AutoDownloadMode* retval);
}

@GUID("615C4269-7A48-43BD-96B7-BF6CA27D6C3E")
interface IWindowsDriverUpdate2 : IWindowsDriverUpdate
{
    HRESULT get_RebootRequired(short* retval);
    HRESULT get_IsPresent(short* retval);
    HRESULT get_CveIDs(IStringCollection* retval);
    HRESULT CopyToCache(IStringCollection pFiles);
}

@GUID("49EBD502-4A96-41BD-9E3E-4C5057F4250C")
interface IWindowsDriverUpdate3 : IWindowsDriverUpdate2
{
    HRESULT get_BrowseOnly(short* retval);
}

@GUID("ED8BFE40-A60B-42EA-9652-817DFCFA23EC")
interface IWindowsDriverUpdateEntry : IDispatch
{
    HRESULT get_DriverClass(BSTR* retval);
    HRESULT get_DriverHardwareID(BSTR* retval);
    HRESULT get_DriverManufacturer(BSTR* retval);
    HRESULT get_DriverModel(BSTR* retval);
    HRESULT get_DriverProvider(BSTR* retval);
    HRESULT get_DriverVerDate(double* retval);
    HRESULT get_DeviceProblemNumber(int* retval);
    HRESULT get_DeviceStatus(int* retval);
}

@GUID("0D521700-A372-4BEF-828B-3D00C10ADEBD")
interface IWindowsDriverUpdateEntryCollection : IDispatch
{
    HRESULT get_Item(int index, IWindowsDriverUpdateEntry* retval);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Count(int* retval);
}

@GUID("004C6A2B-0C19-4C69-9F5C-A269B2560DB9")
interface IWindowsDriverUpdate4 : IWindowsDriverUpdate3
{
    HRESULT get_WindowsDriverUpdateEntries(IWindowsDriverUpdateEntryCollection* retval);
    HRESULT get_PerUser(short* retval);
}

@GUID("70CF5C82-8642-42BB-9DBC-0CFD263C6C4F")
interface IWindowsDriverUpdate5 : IWindowsDriverUpdate4
{
    HRESULT get_AutoSelection(AutoSelectionMode* retval);
    HRESULT get_AutoDownload(AutoDownloadMode* retval);
}

@GUID("07F7438C-7709-4CA5-B518-91279288134E")
interface IUpdateCollection : IDispatch
{
    HRESULT get_Item(int index, IUpdate* retval);
    HRESULT put_Item(int index, IUpdate value);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Count(int* retval);
    HRESULT get_ReadOnly(short* retval);
    HRESULT Add(IUpdate value, int* retval);
    HRESULT Clear();
    HRESULT Copy(IUpdateCollection* retval);
    HRESULT Insert(int index, IUpdate value);
    HRESULT RemoveAt(int index);
}

@GUID("A376DD5E-09D4-427F-AF7C-FED5B6E1C1D6")
interface IUpdateException : IDispatch
{
    HRESULT get_Message(BSTR* retval);
    HRESULT get_HResult(int* retval);
    HRESULT get_Context(UpdateExceptionContext* retval);
}

@GUID("A37D00F5-7BB0-4953-B414-F9E98326F2E8")
interface IInvalidProductLicenseException : IUpdateException
{
    HRESULT get_Product(BSTR* retval);
}

@GUID("503626A3-8E14-4729-9355-0FE664BD2321")
interface IUpdateExceptionCollection : IDispatch
{
    HRESULT get_Item(int index, IUpdateException* retval);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Count(int* retval);
}

@GUID("D40CFF62-E08C-4498-941A-01E25F0FD33C")
interface ISearchResult : IDispatch
{
    HRESULT get_ResultCode(OperationResultCode* retval);
    HRESULT get_RootCategories(ICategoryCollection* retval);
    HRESULT get_Updates(IUpdateCollection* retval);
    HRESULT get_Warnings(IUpdateExceptionCollection* retval);
}

@GUID("7366EA16-7A1A-4EA2-B042-973D3E9CD99B")
interface ISearchJob : IDispatch
{
    HRESULT get_AsyncState(VARIANT* retval);
    HRESULT get_IsCompleted(short* retval);
    HRESULT CleanUp();
    HRESULT RequestAbort();
}

@GUID("A700A634-2850-4C47-938A-9E4B6E5AF9A6")
interface ISearchCompletedCallbackArgs : IDispatch
{
}

@GUID("88AEE058-D4B0-4725-A2F1-814A67AE964C")
interface ISearchCompletedCallback : IUnknown
{
    HRESULT Invoke(ISearchJob searchJob, ISearchCompletedCallbackArgs callbackArgs);
}

@GUID("BE56A644-AF0E-4E0E-A311-C1D8E695CBFF")
interface IUpdateHistoryEntry : IDispatch
{
    HRESULT get_Operation(UpdateOperation* retval);
    HRESULT get_ResultCode(OperationResultCode* retval);
    HRESULT get_HResult(int* retval);
    HRESULT get_Date(double* retval);
    HRESULT get_UpdateIdentity(IUpdateIdentity* retval);
    HRESULT get_Title(BSTR* retval);
    HRESULT get_Description(BSTR* retval);
    HRESULT get_UnmappedResultCode(int* retval);
    HRESULT get_ClientApplicationID(BSTR* retval);
    HRESULT get_ServerSelection(ServerSelection* retval);
    HRESULT get_ServiceID(BSTR* retval);
    HRESULT get_UninstallationSteps(IStringCollection* retval);
    HRESULT get_UninstallationNotes(BSTR* retval);
    HRESULT get_SupportUrl(BSTR* retval);
}

@GUID("C2BFB780-4539-4132-AB8C-0A8772013AB6")
interface IUpdateHistoryEntry2 : IUpdateHistoryEntry
{
    HRESULT get_Categories(ICategoryCollection* retval);
}

@GUID("A7F04F3C-A290-435B-AADF-A116C3357A5C")
interface IUpdateHistoryEntryCollection : IDispatch
{
    HRESULT get_Item(int index, IUpdateHistoryEntry* retval);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Count(int* retval);
}

@GUID("8F45ABF1-F9AE-4B95-A933-F0F66E5056EA")
interface IUpdateSearcher : IDispatch
{
    HRESULT get_CanAutomaticallyUpgradeService(short* retval);
    HRESULT put_CanAutomaticallyUpgradeService(short value);
    HRESULT get_ClientApplicationID(BSTR* retval);
    HRESULT put_ClientApplicationID(BSTR value);
    HRESULT get_IncludePotentiallySupersededUpdates(short* retval);
    HRESULT put_IncludePotentiallySupersededUpdates(short value);
    HRESULT get_ServerSelection(ServerSelection* retval);
    HRESULT put_ServerSelection(ServerSelection value);
    HRESULT BeginSearch(BSTR criteria, IUnknown onCompleted, VARIANT state, ISearchJob* retval);
    HRESULT EndSearch(ISearchJob searchJob, ISearchResult* retval);
    HRESULT EscapeString(BSTR unescaped, BSTR* retval);
    HRESULT QueryHistory(int startIndex, int count, IUpdateHistoryEntryCollection* retval);
    HRESULT Search(BSTR criteria, ISearchResult* retval);
    HRESULT get_Online(short* retval);
    HRESULT put_Online(short value);
    HRESULT GetTotalHistoryCount(int* retval);
    HRESULT get_ServiceID(BSTR* retval);
    HRESULT put_ServiceID(BSTR value);
}

@GUID("4CBDCB2D-1589-4BEB-BD1C-3E582FF0ADD0")
interface IUpdateSearcher2 : IUpdateSearcher
{
    HRESULT get_IgnoreDownloadPriority(short* retval);
    HRESULT put_IgnoreDownloadPriority(short value);
}

@GUID("04C6895D-EAF2-4034-97F3-311DE9BE413A")
interface IUpdateSearcher3 : IUpdateSearcher2
{
    HRESULT get_SearchScope(SearchScope* retval);
    HRESULT put_SearchScope(SearchScope value);
}

@GUID("BF99AF76-B575-42AD-8AA4-33CBB5477AF1")
interface IUpdateDownloadResult : IDispatch
{
    HRESULT get_HResult(int* retval);
    HRESULT get_ResultCode(OperationResultCode* retval);
}

@GUID("DAA4FDD0-4727-4DBE-A1E7-745DCA317144")
interface IDownloadResult : IDispatch
{
    HRESULT get_HResult(int* retval);
    HRESULT get_ResultCode(OperationResultCode* retval);
    HRESULT GetUpdateResult(int updateIndex, IUpdateDownloadResult* retval);
}

@GUID("D31A5BAC-F719-4178-9DBB-5E2CB47FD18A")
interface IDownloadProgress : IDispatch
{
    HRESULT get_CurrentUpdateBytesDownloaded(DECIMAL* retval);
    HRESULT get_CurrentUpdateBytesToDownload(DECIMAL* retval);
    HRESULT get_CurrentUpdateIndex(int* retval);
    HRESULT get_PercentComplete(int* retval);
    HRESULT get_TotalBytesDownloaded(DECIMAL* retval);
    HRESULT get_TotalBytesToDownload(DECIMAL* retval);
    HRESULT GetUpdateResult(int updateIndex, IUpdateDownloadResult* retval);
    HRESULT get_CurrentUpdateDownloadPhase(DownloadPhase* retval);
    HRESULT get_CurrentUpdatePercentComplete(int* retval);
}

@GUID("C574DE85-7358-43F6-AAE8-8697E62D8BA7")
interface IDownloadJob : IDispatch
{
    HRESULT get_AsyncState(VARIANT* retval);
    HRESULT get_IsCompleted(short* retval);
    HRESULT get_Updates(IUpdateCollection* retval);
    HRESULT CleanUp();
    HRESULT GetProgress(IDownloadProgress* retval);
    HRESULT RequestAbort();
}

@GUID("FA565B23-498C-47A0-979D-E7D5B1813360")
interface IDownloadCompletedCallbackArgs : IDispatch
{
}

@GUID("77254866-9F5B-4C8E-B9E2-C77A8530D64B")
interface IDownloadCompletedCallback : IUnknown
{
    HRESULT Invoke(IDownloadJob downloadJob, IDownloadCompletedCallbackArgs callbackArgs);
}

@GUID("324FF2C6-4981-4B04-9412-57481745AB24")
interface IDownloadProgressChangedCallbackArgs : IDispatch
{
    HRESULT get_Progress(IDownloadProgress* retval);
}

@GUID("8C3F1CDD-6173-4591-AEBD-A56A53CA77C1")
interface IDownloadProgressChangedCallback : IUnknown
{
    HRESULT Invoke(IDownloadJob downloadJob, IDownloadProgressChangedCallbackArgs callbackArgs);
}

@GUID("68F1C6F9-7ECC-4666-A464-247FE12496C3")
interface IUpdateDownloader : IDispatch
{
    HRESULT get_ClientApplicationID(BSTR* retval);
    HRESULT put_ClientApplicationID(BSTR value);
    HRESULT get_IsForced(short* retval);
    HRESULT put_IsForced(short value);
    HRESULT get_Priority(DownloadPriority* retval);
    HRESULT put_Priority(DownloadPriority value);
    HRESULT get_Updates(IUpdateCollection* retval);
    HRESULT put_Updates(IUpdateCollection value);
    HRESULT BeginDownload(IUnknown onProgressChanged, IUnknown onCompleted, VARIANT state, IDownloadJob* retval);
    HRESULT Download(IDownloadResult* retval);
    HRESULT EndDownload(IDownloadJob value, IDownloadResult* retval);
}

@GUID("D940F0F8-3CBB-4FD0-993F-471E7F2328AD")
interface IUpdateInstallationResult : IDispatch
{
    HRESULT get_HResult(int* retval);
    HRESULT get_RebootRequired(short* retval);
    HRESULT get_ResultCode(OperationResultCode* retval);
}

@GUID("A43C56D6-7451-48D4-AF96-B6CD2D0D9B7A")
interface IInstallationResult : IDispatch
{
    HRESULT get_HResult(int* retval);
    HRESULT get_RebootRequired(short* retval);
    HRESULT get_ResultCode(OperationResultCode* retval);
    HRESULT GetUpdateResult(int updateIndex, IUpdateInstallationResult* retval);
}

@GUID("345C8244-43A3-4E32-A368-65F073B76F36")
interface IInstallationProgress : IDispatch
{
    HRESULT get_CurrentUpdateIndex(int* retval);
    HRESULT get_CurrentUpdatePercentComplete(int* retval);
    HRESULT get_PercentComplete(int* retval);
    HRESULT GetUpdateResult(int updateIndex, IUpdateInstallationResult* retval);
}

@GUID("5C209F0B-BAD5-432A-9556-4699BED2638A")
interface IInstallationJob : IDispatch
{
    HRESULT get_AsyncState(VARIANT* retval);
    HRESULT get_IsCompleted(short* retval);
    HRESULT get_Updates(IUpdateCollection* retval);
    HRESULT CleanUp();
    HRESULT GetProgress(IInstallationProgress* retval);
    HRESULT RequestAbort();
}

@GUID("250E2106-8EFB-4705-9653-EF13C581B6A1")
interface IInstallationCompletedCallbackArgs : IDispatch
{
}

@GUID("45F4F6F3-D602-4F98-9A8A-3EFA152AD2D3")
interface IInstallationCompletedCallback : IUnknown
{
    HRESULT Invoke(IInstallationJob installationJob, IInstallationCompletedCallbackArgs callbackArgs);
}

@GUID("E4F14E1E-689D-4218-A0B9-BC189C484A01")
interface IInstallationProgressChangedCallbackArgs : IDispatch
{
    HRESULT get_Progress(IInstallationProgress* retval);
}

@GUID("E01402D5-F8DA-43BA-A012-38894BD048F1")
interface IInstallationProgressChangedCallback : IUnknown
{
    HRESULT Invoke(IInstallationJob installationJob, IInstallationProgressChangedCallbackArgs callbackArgs);
}

@GUID("7B929C68-CCDC-4226-96B1-8724600B54C2")
interface IUpdateInstaller : IDispatch
{
    HRESULT get_ClientApplicationID(BSTR* retval);
    HRESULT put_ClientApplicationID(BSTR value);
    HRESULT get_IsForced(short* retval);
    HRESULT put_IsForced(short value);
    HRESULT get_ParentHwnd(HWND* retval);
    HRESULT put_ParentHwnd(HWND value);
    HRESULT put_ParentWindow(IUnknown value);
    HRESULT get_ParentWindow(IUnknown* retval);
    HRESULT get_Updates(IUpdateCollection* retval);
    HRESULT put_Updates(IUpdateCollection value);
    HRESULT BeginInstall(IUnknown onProgressChanged, IUnknown onCompleted, VARIANT state, IInstallationJob* retval);
    HRESULT BeginUninstall(IUnknown onProgressChanged, IUnknown onCompleted, VARIANT state, 
                           IInstallationJob* retval);
    HRESULT EndInstall(IInstallationJob value, IInstallationResult* retval);
    HRESULT EndUninstall(IInstallationJob value, IInstallationResult* retval);
    HRESULT Install(IInstallationResult* retval);
    HRESULT RunWizard(BSTR dialogTitle, IInstallationResult* retval);
    HRESULT get_IsBusy(short* retval);
    HRESULT Uninstall(IInstallationResult* retval);
    HRESULT get_AllowSourcePrompts(short* retval);
    HRESULT put_AllowSourcePrompts(short value);
    HRESULT get_RebootRequiredBeforeInstallation(short* retval);
}

@GUID("3442D4FE-224D-4CEE-98CF-30E0C4D229E6")
interface IUpdateInstaller2 : IUpdateInstaller
{
    HRESULT get_ForceQuiet(short* retval);
    HRESULT put_ForceQuiet(short value);
}

@GUID("16D11C35-099A-48D0-8338-5FAE64047F8E")
interface IUpdateInstaller3 : IUpdateInstaller2
{
    HRESULT get_AttemptCloseAppsIfNecessary(short* retval);
    HRESULT put_AttemptCloseAppsIfNecessary(short value);
}

@GUID("EF8208EA-2304-492D-9109-23813B0958E1")
interface IUpdateInstaller4 : IUpdateInstaller3
{
    HRESULT Commit(uint dwFlags);
}

@GUID("816858A4-260D-4260-933A-2585F1ABC76B")
interface IUpdateSession : IDispatch
{
    HRESULT get_ClientApplicationID(BSTR* retval);
    HRESULT put_ClientApplicationID(BSTR value);
    HRESULT get_ReadOnly(short* retval);
    HRESULT get_WebProxy(IWebProxy* retval);
    HRESULT put_WebProxy(IWebProxy value);
    HRESULT CreateUpdateSearcher(IUpdateSearcher* retval);
    HRESULT CreateUpdateDownloader(IUpdateDownloader* retval);
    HRESULT CreateUpdateInstaller(IUpdateInstaller* retval);
}

@GUID("91CAF7B0-EB23-49ED-9937-C52D817F46F7")
interface IUpdateSession2 : IUpdateSession
{
    HRESULT get_UserLocale(uint* retval);
    HRESULT put_UserLocale(uint lcid);
}

@GUID("918EFD1E-B5D8-4C90-8540-AEB9BDC56F9D")
interface IUpdateSession3 : IUpdateSession2
{
    HRESULT CreateUpdateServiceManager(IUpdateServiceManager2* retval);
    HRESULT QueryHistory(BSTR criteria, int startIndex, int count, IUpdateHistoryEntryCollection* retval);
}

@GUID("76B3B17E-AED6-4DA5-85F0-83587F81ABE3")
interface IUpdateService : IDispatch
{
    HRESULT get_Name(BSTR* retval);
    HRESULT get_ContentValidationCert(VARIANT* retval);
    HRESULT get_ExpirationDate(double* retval);
    HRESULT get_IsManaged(short* retval);
    HRESULT get_IsRegisteredWithAU(short* retval);
    HRESULT get_IssueDate(double* retval);
    HRESULT get_OffersWindowsUpdates(short* retval);
    HRESULT get_RedirectUrls(IStringCollection* retval);
    HRESULT get_ServiceID(BSTR* retval);
    HRESULT get_IsScanPackageService(short* retval);
    HRESULT get_CanRegisterWithAU(short* retval);
    HRESULT get_ServiceUrl(BSTR* retval);
    HRESULT get_SetupPrefix(BSTR* retval);
}

@GUID("1518B460-6518-4172-940F-C75883B24CEB")
interface IUpdateService2 : IUpdateService
{
    HRESULT get_IsDefaultAUService(short* retval);
}

@GUID("9B0353AA-0E52-44FF-B8B0-1F7FA0437F88")
interface IUpdateServiceCollection : IDispatch
{
    HRESULT get_Item(int index, IUpdateService* retval);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Count(int* retval);
}

@GUID("DDE02280-12B3-4E0B-937B-6747F6ACB286")
interface IUpdateServiceRegistration : IDispatch
{
    HRESULT get_RegistrationState(UpdateServiceRegistrationState* retval);
    HRESULT get_ServiceID(BSTR* retval);
    HRESULT get_IsPendingRegistrationWithAU(short* retval);
    HRESULT get_Service(IUpdateService2* retval);
}

@GUID("23857E3C-02BA-44A3-9423-B1C900805F37")
interface IUpdateServiceManager : IDispatch
{
    HRESULT get_Services(IUpdateServiceCollection* retval);
    HRESULT AddService(BSTR serviceID, BSTR authorizationCabPath, IUpdateService* retval);
    HRESULT RegisterServiceWithAU(BSTR serviceID);
    HRESULT RemoveService(BSTR serviceID);
    HRESULT UnregisterServiceWithAU(BSTR serviceID);
    HRESULT AddScanPackageService(BSTR serviceName, BSTR scanFileLocation, int flags, IUpdateService* ppService);
    HRESULT SetOption(BSTR optionName, VARIANT optionValue);
}

@GUID("0BB8531D-7E8D-424F-986C-A0B8F60A3E7B")
interface IUpdateServiceManager2 : IUpdateServiceManager
{
    HRESULT get_ClientApplicationID(BSTR* retval);
    HRESULT put_ClientApplicationID(BSTR value);
    HRESULT QueryServiceRegistration(BSTR serviceID, IUpdateServiceRegistration* retval);
    HRESULT AddService2(BSTR serviceID, int flags, BSTR authorizationCabPath, IUpdateServiceRegistration* retval);
}

@GUID("925CBC18-A2EA-4648-BF1C-EC8BADCFE20A")
interface IInstallationAgent : IDispatch
{
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
