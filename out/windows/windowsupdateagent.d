module windows.windowsupdateagent;

public import windows.automation;
public import windows.com;
public import windows.systemservices;
public import windows.windowsandmessaging;

extern(Windows):

const GUID CLSID_StringCollection = {0x72C97D74, 0x7C3B, 0x40AE, [0xB7, 0x7D, 0xAB, 0xDB, 0x22, 0xEB, 0xA6, 0xFB]};
@GUID(0x72C97D74, 0x7C3B, 0x40AE, [0xB7, 0x7D, 0xAB, 0xDB, 0x22, 0xEB, 0xA6, 0xFB]);
struct StringCollection;

const GUID CLSID_UpdateSearcher = {0xB699E5E8, 0x67FF, 0x4177, [0x88, 0xB0, 0x36, 0x84, 0xA3, 0x38, 0x8B, 0xFB]};
@GUID(0xB699E5E8, 0x67FF, 0x4177, [0x88, 0xB0, 0x36, 0x84, 0xA3, 0x38, 0x8B, 0xFB]);
struct UpdateSearcher;

const GUID CLSID_WebProxy = {0x650503CF, 0x9108, 0x4DDC, [0xA2, 0xCE, 0x6C, 0x23, 0x41, 0xE1, 0xC5, 0x82]};
@GUID(0x650503CF, 0x9108, 0x4DDC, [0xA2, 0xCE, 0x6C, 0x23, 0x41, 0xE1, 0xC5, 0x82]);
struct WebProxy;

const GUID CLSID_SystemInformation = {0xC01B9BA0, 0xBEA7, 0x41BA, [0xB6, 0x04, 0xD0, 0xA3, 0x6F, 0x46, 0x91, 0x33]};
@GUID(0xC01B9BA0, 0xBEA7, 0x41BA, [0xB6, 0x04, 0xD0, 0xA3, 0x6F, 0x46, 0x91, 0x33]);
struct SystemInformation;

const GUID CLSID_WindowsUpdateAgentInfo = {0xC2E88C2F, 0x6F5B, 0x4AAA, [0x89, 0x4B, 0x55, 0xC8, 0x47, 0xAD, 0x3A, 0x2D]};
@GUID(0xC2E88C2F, 0x6F5B, 0x4AAA, [0x89, 0x4B, 0x55, 0xC8, 0x47, 0xAD, 0x3A, 0x2D]);
struct WindowsUpdateAgentInfo;

const GUID CLSID_AutomaticUpdates = {0xBFE18E9C, 0x6D87, 0x4450, [0xB3, 0x7C, 0xE0, 0x2F, 0x0B, 0x37, 0x38, 0x03]};
@GUID(0xBFE18E9C, 0x6D87, 0x4450, [0xB3, 0x7C, 0xE0, 0x2F, 0x0B, 0x37, 0x38, 0x03]);
struct AutomaticUpdates;

const GUID CLSID_UpdateCollection = {0x13639463, 0x00DB, 0x4646, [0x80, 0x3D, 0x52, 0x80, 0x26, 0x14, 0x0D, 0x88]};
@GUID(0x13639463, 0x00DB, 0x4646, [0x80, 0x3D, 0x52, 0x80, 0x26, 0x14, 0x0D, 0x88]);
struct UpdateCollection;

const GUID CLSID_UpdateDownloader = {0x5BAF654A, 0x5A07, 0x4264, [0xA2, 0x55, 0x9F, 0xF5, 0x4C, 0x71, 0x51, 0xE7]};
@GUID(0x5BAF654A, 0x5A07, 0x4264, [0xA2, 0x55, 0x9F, 0xF5, 0x4C, 0x71, 0x51, 0xE7]);
struct UpdateDownloader;

const GUID CLSID_UpdateInstaller = {0xD2E0FE7F, 0xD23E, 0x48E1, [0x93, 0xC0, 0x6F, 0xA8, 0xCC, 0x34, 0x64, 0x74]};
@GUID(0xD2E0FE7F, 0xD23E, 0x48E1, [0x93, 0xC0, 0x6F, 0xA8, 0xCC, 0x34, 0x64, 0x74]);
struct UpdateInstaller;

const GUID CLSID_UpdateSession = {0x4CB43D7F, 0x7EEE, 0x4906, [0x86, 0x98, 0x60, 0xDA, 0x1C, 0x38, 0xF2, 0xFE]};
@GUID(0x4CB43D7F, 0x7EEE, 0x4906, [0x86, 0x98, 0x60, 0xDA, 0x1C, 0x38, 0xF2, 0xFE]);
struct UpdateSession;

const GUID CLSID_UpdateServiceManager = {0xF8D253D9, 0x89A4, 0x4DAA, [0x87, 0xB6, 0x11, 0x68, 0x36, 0x9F, 0x0B, 0x21]};
@GUID(0xF8D253D9, 0x89A4, 0x4DAA, [0x87, 0xB6, 0x11, 0x68, 0x36, 0x9F, 0x0B, 0x21]);
struct UpdateServiceManager;

const GUID CLSID_InstallationAgent = {0x317E92FC, 0x1679, 0x46FD, [0xA0, 0xB5, 0xF0, 0x89, 0x14, 0xDD, 0x86, 0x23]};
@GUID(0x317E92FC, 0x1679, 0x46FD, [0xA0, 0xB5, 0xF0, 0x89, 0x14, 0xDD, 0x86, 0x23]);
struct InstallationAgent;

enum AutomaticUpdatesNotificationLevel
{
    aunlNotConfigured = 0,
    aunlDisabled = 1,
    aunlNotifyBeforeDownload = 2,
    aunlNotifyBeforeInstallation = 3,
    aunlScheduledInstallation = 4,
}

enum AutomaticUpdatesScheduledInstallationDay
{
    ausidEveryDay = 0,
    ausidEverySunday = 1,
    ausidEveryMonday = 2,
    ausidEveryTuesday = 3,
    ausidEveryWednesday = 4,
    ausidEveryThursday = 5,
    ausidEveryFriday = 6,
    ausidEverySaturday = 7,
}

enum DownloadPhase
{
    dphInitializing = 1,
    dphDownloading = 2,
    dphVerifying = 3,
}

enum DownloadPriority
{
    dpLow = 1,
    dpNormal = 2,
    dpHigh = 3,
    dpExtraHigh = 4,
}

enum AutoSelectionMode
{
    asLetWindowsUpdateDecide = 0,
    asAutoSelectIfDownloaded = 1,
    asNeverAutoSelect = 2,
    asAlwaysAutoSelect = 3,
}

enum AutoDownloadMode
{
    adLetWindowsUpdateDecide = 0,
    adNeverAutoDownload = 1,
    adAlwaysAutoDownload = 2,
}

enum InstallationImpact
{
    iiNormal = 0,
    iiMinor = 1,
    iiRequiresExclusiveHandling = 2,
}

enum InstallationRebootBehavior
{
    irbNeverReboots = 0,
    irbAlwaysRequiresReboot = 1,
    irbCanRequestReboot = 2,
}

enum OperationResultCode
{
    orcNotStarted = 0,
    orcInProgress = 1,
    orcSucceeded = 2,
    orcSucceededWithErrors = 3,
    orcFailed = 4,
    orcAborted = 5,
}

enum ServerSelection
{
    ssDefault = 0,
    ssManagedServer = 1,
    ssWindowsUpdate = 2,
    ssOthers = 3,
}

enum UpdateType
{
    utSoftware = 1,
    utDriver = 2,
}

enum UpdateOperation
{
    uoInstallation = 1,
    uoUninstallation = 2,
}

enum DeploymentAction
{
    daNone = 0,
    daInstallation = 1,
    daUninstallation = 2,
    daDetection = 3,
    daOptionalInstallation = 4,
}

enum UpdateExceptionContext
{
    uecGeneral = 1,
    uecWindowsDriver = 2,
    uecWindowsInstaller = 3,
    uecSearchIncomplete = 4,
}

enum AutomaticUpdatesUserType
{
    auutCurrentUser = 1,
    auutLocalAdministrator = 2,
}

enum AutomaticUpdatesPermissionType
{
    auptSetNotificationLevel = 1,
    auptDisableAutomaticUpdates = 2,
    auptSetIncludeRecommendedUpdates = 3,
    auptSetFeaturedUpdatesEnabled = 4,
    auptSetNonAdministratorsElevated = 5,
}

enum UpdateServiceRegistrationState
{
    usrsNotRegistered = 1,
    usrsRegistrationPending = 2,
    usrsRegistered = 3,
}

enum SearchScope
{
    searchScopeDefault = 0,
    searchScopeMachineOnly = 1,
    searchScopeCurrentUserOnly = 2,
    searchScopeMachineAndCurrentUser = 3,
    searchScopeMachineAndAllUsers = 4,
    searchScopeAllUsers = 5,
}

const GUID IID_IUpdateLockdown = {0xA976C28D, 0x75A1, 0x42AA, [0x94, 0xAE, 0x8A, 0xF8, 0xB8, 0x72, 0x08, 0x9A]};
@GUID(0xA976C28D, 0x75A1, 0x42AA, [0x94, 0xAE, 0x8A, 0xF8, 0xB8, 0x72, 0x08, 0x9A]);
interface IUpdateLockdown : IUnknown
{
    HRESULT LockDown(int flags);
}

const GUID IID_IStringCollection = {0xEFF90582, 0x2DDC, 0x480F, [0xA0, 0x6D, 0x60, 0xF3, 0xFB, 0xC3, 0x62, 0xC3]};
@GUID(0xEFF90582, 0x2DDC, 0x480F, [0xA0, 0x6D, 0x60, 0xF3, 0xFB, 0xC3, 0x62, 0xC3]);
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

const GUID IID_IWebProxy = {0x174C81FE, 0xAECD, 0x4DAE, [0xB8, 0xA0, 0x2C, 0x63, 0x18, 0xDD, 0x86, 0xA8]};
@GUID(0x174C81FE, 0xAECD, 0x4DAE, [0xB8, 0xA0, 0x2C, 0x63, 0x18, 0xDD, 0x86, 0xA8]);
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

const GUID IID_ISystemInformation = {0xADE87BF7, 0x7B56, 0x4275, [0x8F, 0xAB, 0xB9, 0xB0, 0xE5, 0x91, 0x84, 0x4B]};
@GUID(0xADE87BF7, 0x7B56, 0x4275, [0x8F, 0xAB, 0xB9, 0xB0, 0xE5, 0x91, 0x84, 0x4B]);
interface ISystemInformation : IDispatch
{
    HRESULT get_OemHardwareSupportLink(BSTR* retval);
    HRESULT get_RebootRequired(short* retval);
}

const GUID IID_IWindowsUpdateAgentInfo = {0x85713FA1, 0x7796, 0x4FA2, [0xBE, 0x3B, 0xE2, 0xD6, 0x12, 0x4D, 0xD3, 0x73]};
@GUID(0x85713FA1, 0x7796, 0x4FA2, [0xBE, 0x3B, 0xE2, 0xD6, 0x12, 0x4D, 0xD3, 0x73]);
interface IWindowsUpdateAgentInfo : IDispatch
{
    HRESULT GetInfo(VARIANT varInfoIdentifier, VARIANT* retval);
}

const GUID IID_IAutomaticUpdatesResults = {0xE7A4D634, 0x7942, 0x4DD9, [0xA1, 0x11, 0x82, 0x22, 0x8B, 0xA3, 0x39, 0x01]};
@GUID(0xE7A4D634, 0x7942, 0x4DD9, [0xA1, 0x11, 0x82, 0x22, 0x8B, 0xA3, 0x39, 0x01]);
interface IAutomaticUpdatesResults : IDispatch
{
    HRESULT get_LastSearchSuccessDate(VARIANT* retval);
    HRESULT get_LastInstallationSuccessDate(VARIANT* retval);
}

const GUID IID_IAutomaticUpdatesSettings = {0x2EE48F22, 0xAF3C, 0x405F, [0x89, 0x70, 0xF7, 0x1B, 0xE1, 0x2E, 0xE9, 0xA2]};
@GUID(0x2EE48F22, 0xAF3C, 0x405F, [0x89, 0x70, 0xF7, 0x1B, 0xE1, 0x2E, 0xE9, 0xA2]);
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

const GUID IID_IAutomaticUpdatesSettings2 = {0x6ABC136A, 0xC3CA, 0x4384, [0x81, 0x71, 0xCB, 0x2B, 0x1E, 0x59, 0xB8, 0xDC]};
@GUID(0x6ABC136A, 0xC3CA, 0x4384, [0x81, 0x71, 0xCB, 0x2B, 0x1E, 0x59, 0xB8, 0xDC]);
interface IAutomaticUpdatesSettings2 : IAutomaticUpdatesSettings
{
    HRESULT get_IncludeRecommendedUpdates(short* retval);
    HRESULT put_IncludeRecommendedUpdates(short value);
    HRESULT CheckPermission(AutomaticUpdatesUserType userType, AutomaticUpdatesPermissionType permissionType, short* userHasPermission);
}

const GUID IID_IAutomaticUpdatesSettings3 = {0xB587F5C3, 0xF57E, 0x485F, [0xBB, 0xF5, 0x0D, 0x18, 0x1C, 0x5C, 0xD0, 0xDC]};
@GUID(0xB587F5C3, 0xF57E, 0x485F, [0xBB, 0xF5, 0x0D, 0x18, 0x1C, 0x5C, 0xD0, 0xDC]);
interface IAutomaticUpdatesSettings3 : IAutomaticUpdatesSettings2
{
    HRESULT get_NonAdministratorsElevated(short* retval);
    HRESULT put_NonAdministratorsElevated(short value);
    HRESULT get_FeaturedUpdatesEnabled(short* retval);
    HRESULT put_FeaturedUpdatesEnabled(short value);
}

const GUID IID_IAutomaticUpdates = {0x673425BF, 0xC082, 0x4C7C, [0xBD, 0xFD, 0x56, 0x94, 0x64, 0xB8, 0xE0, 0xCE]};
@GUID(0x673425BF, 0xC082, 0x4C7C, [0xBD, 0xFD, 0x56, 0x94, 0x64, 0xB8, 0xE0, 0xCE]);
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

const GUID IID_IAutomaticUpdates2 = {0x4A2F5C31, 0xCFD9, 0x410E, [0xB7, 0xFB, 0x29, 0xA6, 0x53, 0x97, 0x3A, 0x0F]};
@GUID(0x4A2F5C31, 0xCFD9, 0x410E, [0xB7, 0xFB, 0x29, 0xA6, 0x53, 0x97, 0x3A, 0x0F]);
interface IAutomaticUpdates2 : IAutomaticUpdates
{
    HRESULT get_Results(IAutomaticUpdatesResults* retval);
}

const GUID IID_IUpdateIdentity = {0x46297823, 0x9940, 0x4C09, [0xAE, 0xD9, 0xCD, 0x3E, 0xA6, 0xD0, 0x59, 0x68]};
@GUID(0x46297823, 0x9940, 0x4C09, [0xAE, 0xD9, 0xCD, 0x3E, 0xA6, 0xD0, 0x59, 0x68]);
interface IUpdateIdentity : IDispatch
{
    HRESULT get_RevisionNumber(int* retval);
    HRESULT get_UpdateID(BSTR* retval);
}

const GUID IID_IImageInformation = {0x7C907864, 0x346C, 0x4AEB, [0x8F, 0x3F, 0x57, 0xDA, 0x28, 0x9F, 0x96, 0x9F]};
@GUID(0x7C907864, 0x346C, 0x4AEB, [0x8F, 0x3F, 0x57, 0xDA, 0x28, 0x9F, 0x96, 0x9F]);
interface IImageInformation : IDispatch
{
    HRESULT get_AltText(BSTR* retval);
    HRESULT get_Height(int* retval);
    HRESULT get_Source(BSTR* retval);
    HRESULT get_Width(int* retval);
}

const GUID IID_ICategory = {0x81DDC1B8, 0x9D35, 0x47A6, [0xB4, 0x71, 0x5B, 0x80, 0xF5, 0x19, 0x22, 0x3B]};
@GUID(0x81DDC1B8, 0x9D35, 0x47A6, [0xB4, 0x71, 0x5B, 0x80, 0xF5, 0x19, 0x22, 0x3B]);
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

const GUID IID_ICategoryCollection = {0x3A56BFB8, 0x576C, 0x43F7, [0x93, 0x35, 0xFE, 0x48, 0x38, 0xFD, 0x7E, 0x37]};
@GUID(0x3A56BFB8, 0x576C, 0x43F7, [0x93, 0x35, 0xFE, 0x48, 0x38, 0xFD, 0x7E, 0x37]);
interface ICategoryCollection : IDispatch
{
    HRESULT get_Item(int index, ICategory* retval);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Count(int* retval);
}

const GUID IID_IInstallationBehavior = {0xD9A59339, 0xE245, 0x4DBD, [0x96, 0x86, 0x4D, 0x57, 0x63, 0xE3, 0x96, 0x24]};
@GUID(0xD9A59339, 0xE245, 0x4DBD, [0x96, 0x86, 0x4D, 0x57, 0x63, 0xE3, 0x96, 0x24]);
interface IInstallationBehavior : IDispatch
{
    HRESULT get_CanRequestUserInput(short* retval);
    HRESULT get_Impact(InstallationImpact* retval);
    HRESULT get_RebootBehavior(InstallationRebootBehavior* retval);
    HRESULT get_RequiresNetworkConnectivity(short* retval);
}

const GUID IID_IUpdateDownloadContent = {0x54A2CB2D, 0x9A0C, 0x48B6, [0x8A, 0x50, 0x9A, 0xBB, 0x69, 0xEE, 0x2D, 0x02]};
@GUID(0x54A2CB2D, 0x9A0C, 0x48B6, [0x8A, 0x50, 0x9A, 0xBB, 0x69, 0xEE, 0x2D, 0x02]);
interface IUpdateDownloadContent : IDispatch
{
    HRESULT get_DownloadUrl(BSTR* retval);
}

const GUID IID_IUpdateDownloadContent2 = {0xC97AD11B, 0xF257, 0x420B, [0x9D, 0x9F, 0x37, 0x7F, 0x73, 0x3F, 0x6F, 0x68]};
@GUID(0xC97AD11B, 0xF257, 0x420B, [0x9D, 0x9F, 0x37, 0x7F, 0x73, 0x3F, 0x6F, 0x68]);
interface IUpdateDownloadContent2 : IUpdateDownloadContent
{
    HRESULT get_IsDeltaCompressedContent(short* retval);
}

const GUID IID_IUpdateDownloadContentCollection = {0xBC5513C8, 0xB3B8, 0x4BF7, [0xA4, 0xD4, 0x36, 0x1C, 0x0D, 0x8C, 0x88, 0xBA]};
@GUID(0xBC5513C8, 0xB3B8, 0x4BF7, [0xA4, 0xD4, 0x36, 0x1C, 0x0D, 0x8C, 0x88, 0xBA]);
interface IUpdateDownloadContentCollection : IDispatch
{
    HRESULT get_Item(int index, IUpdateDownloadContent* retval);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Count(int* retval);
}

const GUID IID_IUpdate = {0x6A92B07A, 0xD821, 0x4682, [0xB4, 0x23, 0x5C, 0x80, 0x50, 0x22, 0xCC, 0x4D]};
@GUID(0x6A92B07A, 0xD821, 0x4682, [0xB4, 0x23, 0x5C, 0x80, 0x50, 0x22, 0xCC, 0x4D]);
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

const GUID IID_IWindowsDriverUpdate = {0xB383CD1A, 0x5CE9, 0x4504, [0x9F, 0x63, 0x76, 0x4B, 0x12, 0x36, 0xF1, 0x91]};
@GUID(0xB383CD1A, 0x5CE9, 0x4504, [0x9F, 0x63, 0x76, 0x4B, 0x12, 0x36, 0xF1, 0x91]);
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

const GUID IID_IUpdate2 = {0x144FE9B0, 0xD23D, 0x4A8B, [0x86, 0x34, 0xFB, 0x44, 0x57, 0x53, 0x3B, 0x7A]};
@GUID(0x144FE9B0, 0xD23D, 0x4A8B, [0x86, 0x34, 0xFB, 0x44, 0x57, 0x53, 0x3B, 0x7A]);
interface IUpdate2 : IUpdate
{
    HRESULT get_RebootRequired(short* retval);
    HRESULT get_IsPresent(short* retval);
    HRESULT get_CveIDs(IStringCollection* retval);
    HRESULT CopyToCache(IStringCollection pFiles);
}

const GUID IID_IUpdate3 = {0x112EDA6B, 0x95B3, 0x476F, [0x9D, 0x90, 0xAE, 0xE8, 0x2C, 0x6B, 0x81, 0x81]};
@GUID(0x112EDA6B, 0x95B3, 0x476F, [0x9D, 0x90, 0xAE, 0xE8, 0x2C, 0x6B, 0x81, 0x81]);
interface IUpdate3 : IUpdate2
{
    HRESULT get_BrowseOnly(short* retval);
}

const GUID IID_IUpdate4 = {0x27E94B0D, 0x5139, 0x49A2, [0x9A, 0x61, 0x93, 0x52, 0x2D, 0xC5, 0x46, 0x52]};
@GUID(0x27E94B0D, 0x5139, 0x49A2, [0x9A, 0x61, 0x93, 0x52, 0x2D, 0xC5, 0x46, 0x52]);
interface IUpdate4 : IUpdate3
{
    HRESULT get_PerUser(short* retval);
}

const GUID IID_IUpdate5 = {0xC1C2F21A, 0xD2F4, 0x4902, [0xB5, 0xC6, 0x8A, 0x08, 0x1C, 0x19, 0xA8, 0x90]};
@GUID(0xC1C2F21A, 0xD2F4, 0x4902, [0xB5, 0xC6, 0x8A, 0x08, 0x1C, 0x19, 0xA8, 0x90]);
interface IUpdate5 : IUpdate4
{
    HRESULT get_AutoSelection(AutoSelectionMode* retval);
    HRESULT get_AutoDownload(AutoDownloadMode* retval);
}

const GUID IID_IWindowsDriverUpdate2 = {0x615C4269, 0x7A48, 0x43BD, [0x96, 0xB7, 0xBF, 0x6C, 0xA2, 0x7D, 0x6C, 0x3E]};
@GUID(0x615C4269, 0x7A48, 0x43BD, [0x96, 0xB7, 0xBF, 0x6C, 0xA2, 0x7D, 0x6C, 0x3E]);
interface IWindowsDriverUpdate2 : IWindowsDriverUpdate
{
    HRESULT get_RebootRequired(short* retval);
    HRESULT get_IsPresent(short* retval);
    HRESULT get_CveIDs(IStringCollection* retval);
    HRESULT CopyToCache(IStringCollection pFiles);
}

const GUID IID_IWindowsDriverUpdate3 = {0x49EBD502, 0x4A96, 0x41BD, [0x9E, 0x3E, 0x4C, 0x50, 0x57, 0xF4, 0x25, 0x0C]};
@GUID(0x49EBD502, 0x4A96, 0x41BD, [0x9E, 0x3E, 0x4C, 0x50, 0x57, 0xF4, 0x25, 0x0C]);
interface IWindowsDriverUpdate3 : IWindowsDriverUpdate2
{
    HRESULT get_BrowseOnly(short* retval);
}

const GUID IID_IWindowsDriverUpdateEntry = {0xED8BFE40, 0xA60B, 0x42EA, [0x96, 0x52, 0x81, 0x7D, 0xFC, 0xFA, 0x23, 0xEC]};
@GUID(0xED8BFE40, 0xA60B, 0x42EA, [0x96, 0x52, 0x81, 0x7D, 0xFC, 0xFA, 0x23, 0xEC]);
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

const GUID IID_IWindowsDriverUpdateEntryCollection = {0x0D521700, 0xA372, 0x4BEF, [0x82, 0x8B, 0x3D, 0x00, 0xC1, 0x0A, 0xDE, 0xBD]};
@GUID(0x0D521700, 0xA372, 0x4BEF, [0x82, 0x8B, 0x3D, 0x00, 0xC1, 0x0A, 0xDE, 0xBD]);
interface IWindowsDriverUpdateEntryCollection : IDispatch
{
    HRESULT get_Item(int index, IWindowsDriverUpdateEntry* retval);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Count(int* retval);
}

const GUID IID_IWindowsDriverUpdate4 = {0x004C6A2B, 0x0C19, 0x4C69, [0x9F, 0x5C, 0xA2, 0x69, 0xB2, 0x56, 0x0D, 0xB9]};
@GUID(0x004C6A2B, 0x0C19, 0x4C69, [0x9F, 0x5C, 0xA2, 0x69, 0xB2, 0x56, 0x0D, 0xB9]);
interface IWindowsDriverUpdate4 : IWindowsDriverUpdate3
{
    HRESULT get_WindowsDriverUpdateEntries(IWindowsDriverUpdateEntryCollection* retval);
    HRESULT get_PerUser(short* retval);
}

const GUID IID_IWindowsDriverUpdate5 = {0x70CF5C82, 0x8642, 0x42BB, [0x9D, 0xBC, 0x0C, 0xFD, 0x26, 0x3C, 0x6C, 0x4F]};
@GUID(0x70CF5C82, 0x8642, 0x42BB, [0x9D, 0xBC, 0x0C, 0xFD, 0x26, 0x3C, 0x6C, 0x4F]);
interface IWindowsDriverUpdate5 : IWindowsDriverUpdate4
{
    HRESULT get_AutoSelection(AutoSelectionMode* retval);
    HRESULT get_AutoDownload(AutoDownloadMode* retval);
}

const GUID IID_IUpdateCollection = {0x07F7438C, 0x7709, 0x4CA5, [0xB5, 0x18, 0x91, 0x27, 0x92, 0x88, 0x13, 0x4E]};
@GUID(0x07F7438C, 0x7709, 0x4CA5, [0xB5, 0x18, 0x91, 0x27, 0x92, 0x88, 0x13, 0x4E]);
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

const GUID IID_IUpdateException = {0xA376DD5E, 0x09D4, 0x427F, [0xAF, 0x7C, 0xFE, 0xD5, 0xB6, 0xE1, 0xC1, 0xD6]};
@GUID(0xA376DD5E, 0x09D4, 0x427F, [0xAF, 0x7C, 0xFE, 0xD5, 0xB6, 0xE1, 0xC1, 0xD6]);
interface IUpdateException : IDispatch
{
    HRESULT get_Message(BSTR* retval);
    HRESULT get_HResult(int* retval);
    HRESULT get_Context(UpdateExceptionContext* retval);
}

const GUID IID_IInvalidProductLicenseException = {0xA37D00F5, 0x7BB0, 0x4953, [0xB4, 0x14, 0xF9, 0xE9, 0x83, 0x26, 0xF2, 0xE8]};
@GUID(0xA37D00F5, 0x7BB0, 0x4953, [0xB4, 0x14, 0xF9, 0xE9, 0x83, 0x26, 0xF2, 0xE8]);
interface IInvalidProductLicenseException : IUpdateException
{
    HRESULT get_Product(BSTR* retval);
}

const GUID IID_IUpdateExceptionCollection = {0x503626A3, 0x8E14, 0x4729, [0x93, 0x55, 0x0F, 0xE6, 0x64, 0xBD, 0x23, 0x21]};
@GUID(0x503626A3, 0x8E14, 0x4729, [0x93, 0x55, 0x0F, 0xE6, 0x64, 0xBD, 0x23, 0x21]);
interface IUpdateExceptionCollection : IDispatch
{
    HRESULT get_Item(int index, IUpdateException* retval);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Count(int* retval);
}

const GUID IID_ISearchResult = {0xD40CFF62, 0xE08C, 0x4498, [0x94, 0x1A, 0x01, 0xE2, 0x5F, 0x0F, 0xD3, 0x3C]};
@GUID(0xD40CFF62, 0xE08C, 0x4498, [0x94, 0x1A, 0x01, 0xE2, 0x5F, 0x0F, 0xD3, 0x3C]);
interface ISearchResult : IDispatch
{
    HRESULT get_ResultCode(OperationResultCode* retval);
    HRESULT get_RootCategories(ICategoryCollection* retval);
    HRESULT get_Updates(IUpdateCollection* retval);
    HRESULT get_Warnings(IUpdateExceptionCollection* retval);
}

const GUID IID_ISearchJob = {0x7366EA16, 0x7A1A, 0x4EA2, [0xB0, 0x42, 0x97, 0x3D, 0x3E, 0x9C, 0xD9, 0x9B]};
@GUID(0x7366EA16, 0x7A1A, 0x4EA2, [0xB0, 0x42, 0x97, 0x3D, 0x3E, 0x9C, 0xD9, 0x9B]);
interface ISearchJob : IDispatch
{
    HRESULT get_AsyncState(VARIANT* retval);
    HRESULT get_IsCompleted(short* retval);
    HRESULT CleanUp();
    HRESULT RequestAbort();
}

const GUID IID_ISearchCompletedCallbackArgs = {0xA700A634, 0x2850, 0x4C47, [0x93, 0x8A, 0x9E, 0x4B, 0x6E, 0x5A, 0xF9, 0xA6]};
@GUID(0xA700A634, 0x2850, 0x4C47, [0x93, 0x8A, 0x9E, 0x4B, 0x6E, 0x5A, 0xF9, 0xA6]);
interface ISearchCompletedCallbackArgs : IDispatch
{
}

const GUID IID_ISearchCompletedCallback = {0x88AEE058, 0xD4B0, 0x4725, [0xA2, 0xF1, 0x81, 0x4A, 0x67, 0xAE, 0x96, 0x4C]};
@GUID(0x88AEE058, 0xD4B0, 0x4725, [0xA2, 0xF1, 0x81, 0x4A, 0x67, 0xAE, 0x96, 0x4C]);
interface ISearchCompletedCallback : IUnknown
{
    HRESULT Invoke(ISearchJob searchJob, ISearchCompletedCallbackArgs callbackArgs);
}

const GUID IID_IUpdateHistoryEntry = {0xBE56A644, 0xAF0E, 0x4E0E, [0xA3, 0x11, 0xC1, 0xD8, 0xE6, 0x95, 0xCB, 0xFF]};
@GUID(0xBE56A644, 0xAF0E, 0x4E0E, [0xA3, 0x11, 0xC1, 0xD8, 0xE6, 0x95, 0xCB, 0xFF]);
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

const GUID IID_IUpdateHistoryEntry2 = {0xC2BFB780, 0x4539, 0x4132, [0xAB, 0x8C, 0x0A, 0x87, 0x72, 0x01, 0x3A, 0xB6]};
@GUID(0xC2BFB780, 0x4539, 0x4132, [0xAB, 0x8C, 0x0A, 0x87, 0x72, 0x01, 0x3A, 0xB6]);
interface IUpdateHistoryEntry2 : IUpdateHistoryEntry
{
    HRESULT get_Categories(ICategoryCollection* retval);
}

const GUID IID_IUpdateHistoryEntryCollection = {0xA7F04F3C, 0xA290, 0x435B, [0xAA, 0xDF, 0xA1, 0x16, 0xC3, 0x35, 0x7A, 0x5C]};
@GUID(0xA7F04F3C, 0xA290, 0x435B, [0xAA, 0xDF, 0xA1, 0x16, 0xC3, 0x35, 0x7A, 0x5C]);
interface IUpdateHistoryEntryCollection : IDispatch
{
    HRESULT get_Item(int index, IUpdateHistoryEntry* retval);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Count(int* retval);
}

const GUID IID_IUpdateSearcher = {0x8F45ABF1, 0xF9AE, 0x4B95, [0xA9, 0x33, 0xF0, 0xF6, 0x6E, 0x50, 0x56, 0xEA]};
@GUID(0x8F45ABF1, 0xF9AE, 0x4B95, [0xA9, 0x33, 0xF0, 0xF6, 0x6E, 0x50, 0x56, 0xEA]);
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

const GUID IID_IUpdateSearcher2 = {0x4CBDCB2D, 0x1589, 0x4BEB, [0xBD, 0x1C, 0x3E, 0x58, 0x2F, 0xF0, 0xAD, 0xD0]};
@GUID(0x4CBDCB2D, 0x1589, 0x4BEB, [0xBD, 0x1C, 0x3E, 0x58, 0x2F, 0xF0, 0xAD, 0xD0]);
interface IUpdateSearcher2 : IUpdateSearcher
{
    HRESULT get_IgnoreDownloadPriority(short* retval);
    HRESULT put_IgnoreDownloadPriority(short value);
}

const GUID IID_IUpdateSearcher3 = {0x04C6895D, 0xEAF2, 0x4034, [0x97, 0xF3, 0x31, 0x1D, 0xE9, 0xBE, 0x41, 0x3A]};
@GUID(0x04C6895D, 0xEAF2, 0x4034, [0x97, 0xF3, 0x31, 0x1D, 0xE9, 0xBE, 0x41, 0x3A]);
interface IUpdateSearcher3 : IUpdateSearcher2
{
    HRESULT get_SearchScope(SearchScope* retval);
    HRESULT put_SearchScope(SearchScope value);
}

const GUID IID_IUpdateDownloadResult = {0xBF99AF76, 0xB575, 0x42AD, [0x8A, 0xA4, 0x33, 0xCB, 0xB5, 0x47, 0x7A, 0xF1]};
@GUID(0xBF99AF76, 0xB575, 0x42AD, [0x8A, 0xA4, 0x33, 0xCB, 0xB5, 0x47, 0x7A, 0xF1]);
interface IUpdateDownloadResult : IDispatch
{
    HRESULT get_HResult(int* retval);
    HRESULT get_ResultCode(OperationResultCode* retval);
}

const GUID IID_IDownloadResult = {0xDAA4FDD0, 0x4727, 0x4DBE, [0xA1, 0xE7, 0x74, 0x5D, 0xCA, 0x31, 0x71, 0x44]};
@GUID(0xDAA4FDD0, 0x4727, 0x4DBE, [0xA1, 0xE7, 0x74, 0x5D, 0xCA, 0x31, 0x71, 0x44]);
interface IDownloadResult : IDispatch
{
    HRESULT get_HResult(int* retval);
    HRESULT get_ResultCode(OperationResultCode* retval);
    HRESULT GetUpdateResult(int updateIndex, IUpdateDownloadResult* retval);
}

const GUID IID_IDownloadProgress = {0xD31A5BAC, 0xF719, 0x4178, [0x9D, 0xBB, 0x5E, 0x2C, 0xB4, 0x7F, 0xD1, 0x8A]};
@GUID(0xD31A5BAC, 0xF719, 0x4178, [0x9D, 0xBB, 0x5E, 0x2C, 0xB4, 0x7F, 0xD1, 0x8A]);
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

const GUID IID_IDownloadJob = {0xC574DE85, 0x7358, 0x43F6, [0xAA, 0xE8, 0x86, 0x97, 0xE6, 0x2D, 0x8B, 0xA7]};
@GUID(0xC574DE85, 0x7358, 0x43F6, [0xAA, 0xE8, 0x86, 0x97, 0xE6, 0x2D, 0x8B, 0xA7]);
interface IDownloadJob : IDispatch
{
    HRESULT get_AsyncState(VARIANT* retval);
    HRESULT get_IsCompleted(short* retval);
    HRESULT get_Updates(IUpdateCollection* retval);
    HRESULT CleanUp();
    HRESULT GetProgress(IDownloadProgress* retval);
    HRESULT RequestAbort();
}

const GUID IID_IDownloadCompletedCallbackArgs = {0xFA565B23, 0x498C, 0x47A0, [0x97, 0x9D, 0xE7, 0xD5, 0xB1, 0x81, 0x33, 0x60]};
@GUID(0xFA565B23, 0x498C, 0x47A0, [0x97, 0x9D, 0xE7, 0xD5, 0xB1, 0x81, 0x33, 0x60]);
interface IDownloadCompletedCallbackArgs : IDispatch
{
}

const GUID IID_IDownloadCompletedCallback = {0x77254866, 0x9F5B, 0x4C8E, [0xB9, 0xE2, 0xC7, 0x7A, 0x85, 0x30, 0xD6, 0x4B]};
@GUID(0x77254866, 0x9F5B, 0x4C8E, [0xB9, 0xE2, 0xC7, 0x7A, 0x85, 0x30, 0xD6, 0x4B]);
interface IDownloadCompletedCallback : IUnknown
{
    HRESULT Invoke(IDownloadJob downloadJob, IDownloadCompletedCallbackArgs callbackArgs);
}

const GUID IID_IDownloadProgressChangedCallbackArgs = {0x324FF2C6, 0x4981, 0x4B04, [0x94, 0x12, 0x57, 0x48, 0x17, 0x45, 0xAB, 0x24]};
@GUID(0x324FF2C6, 0x4981, 0x4B04, [0x94, 0x12, 0x57, 0x48, 0x17, 0x45, 0xAB, 0x24]);
interface IDownloadProgressChangedCallbackArgs : IDispatch
{
    HRESULT get_Progress(IDownloadProgress* retval);
}

const GUID IID_IDownloadProgressChangedCallback = {0x8C3F1CDD, 0x6173, 0x4591, [0xAE, 0xBD, 0xA5, 0x6A, 0x53, 0xCA, 0x77, 0xC1]};
@GUID(0x8C3F1CDD, 0x6173, 0x4591, [0xAE, 0xBD, 0xA5, 0x6A, 0x53, 0xCA, 0x77, 0xC1]);
interface IDownloadProgressChangedCallback : IUnknown
{
    HRESULT Invoke(IDownloadJob downloadJob, IDownloadProgressChangedCallbackArgs callbackArgs);
}

const GUID IID_IUpdateDownloader = {0x68F1C6F9, 0x7ECC, 0x4666, [0xA4, 0x64, 0x24, 0x7F, 0xE1, 0x24, 0x96, 0xC3]};
@GUID(0x68F1C6F9, 0x7ECC, 0x4666, [0xA4, 0x64, 0x24, 0x7F, 0xE1, 0x24, 0x96, 0xC3]);
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

const GUID IID_IUpdateInstallationResult = {0xD940F0F8, 0x3CBB, 0x4FD0, [0x99, 0x3F, 0x47, 0x1E, 0x7F, 0x23, 0x28, 0xAD]};
@GUID(0xD940F0F8, 0x3CBB, 0x4FD0, [0x99, 0x3F, 0x47, 0x1E, 0x7F, 0x23, 0x28, 0xAD]);
interface IUpdateInstallationResult : IDispatch
{
    HRESULT get_HResult(int* retval);
    HRESULT get_RebootRequired(short* retval);
    HRESULT get_ResultCode(OperationResultCode* retval);
}

const GUID IID_IInstallationResult = {0xA43C56D6, 0x7451, 0x48D4, [0xAF, 0x96, 0xB6, 0xCD, 0x2D, 0x0D, 0x9B, 0x7A]};
@GUID(0xA43C56D6, 0x7451, 0x48D4, [0xAF, 0x96, 0xB6, 0xCD, 0x2D, 0x0D, 0x9B, 0x7A]);
interface IInstallationResult : IDispatch
{
    HRESULT get_HResult(int* retval);
    HRESULT get_RebootRequired(short* retval);
    HRESULT get_ResultCode(OperationResultCode* retval);
    HRESULT GetUpdateResult(int updateIndex, IUpdateInstallationResult* retval);
}

const GUID IID_IInstallationProgress = {0x345C8244, 0x43A3, 0x4E32, [0xA3, 0x68, 0x65, 0xF0, 0x73, 0xB7, 0x6F, 0x36]};
@GUID(0x345C8244, 0x43A3, 0x4E32, [0xA3, 0x68, 0x65, 0xF0, 0x73, 0xB7, 0x6F, 0x36]);
interface IInstallationProgress : IDispatch
{
    HRESULT get_CurrentUpdateIndex(int* retval);
    HRESULT get_CurrentUpdatePercentComplete(int* retval);
    HRESULT get_PercentComplete(int* retval);
    HRESULT GetUpdateResult(int updateIndex, IUpdateInstallationResult* retval);
}

const GUID IID_IInstallationJob = {0x5C209F0B, 0xBAD5, 0x432A, [0x95, 0x56, 0x46, 0x99, 0xBE, 0xD2, 0x63, 0x8A]};
@GUID(0x5C209F0B, 0xBAD5, 0x432A, [0x95, 0x56, 0x46, 0x99, 0xBE, 0xD2, 0x63, 0x8A]);
interface IInstallationJob : IDispatch
{
    HRESULT get_AsyncState(VARIANT* retval);
    HRESULT get_IsCompleted(short* retval);
    HRESULT get_Updates(IUpdateCollection* retval);
    HRESULT CleanUp();
    HRESULT GetProgress(IInstallationProgress* retval);
    HRESULT RequestAbort();
}

const GUID IID_IInstallationCompletedCallbackArgs = {0x250E2106, 0x8EFB, 0x4705, [0x96, 0x53, 0xEF, 0x13, 0xC5, 0x81, 0xB6, 0xA1]};
@GUID(0x250E2106, 0x8EFB, 0x4705, [0x96, 0x53, 0xEF, 0x13, 0xC5, 0x81, 0xB6, 0xA1]);
interface IInstallationCompletedCallbackArgs : IDispatch
{
}

const GUID IID_IInstallationCompletedCallback = {0x45F4F6F3, 0xD602, 0x4F98, [0x9A, 0x8A, 0x3E, 0xFA, 0x15, 0x2A, 0xD2, 0xD3]};
@GUID(0x45F4F6F3, 0xD602, 0x4F98, [0x9A, 0x8A, 0x3E, 0xFA, 0x15, 0x2A, 0xD2, 0xD3]);
interface IInstallationCompletedCallback : IUnknown
{
    HRESULT Invoke(IInstallationJob installationJob, IInstallationCompletedCallbackArgs callbackArgs);
}

const GUID IID_IInstallationProgressChangedCallbackArgs = {0xE4F14E1E, 0x689D, 0x4218, [0xA0, 0xB9, 0xBC, 0x18, 0x9C, 0x48, 0x4A, 0x01]};
@GUID(0xE4F14E1E, 0x689D, 0x4218, [0xA0, 0xB9, 0xBC, 0x18, 0x9C, 0x48, 0x4A, 0x01]);
interface IInstallationProgressChangedCallbackArgs : IDispatch
{
    HRESULT get_Progress(IInstallationProgress* retval);
}

const GUID IID_IInstallationProgressChangedCallback = {0xE01402D5, 0xF8DA, 0x43BA, [0xA0, 0x12, 0x38, 0x89, 0x4B, 0xD0, 0x48, 0xF1]};
@GUID(0xE01402D5, 0xF8DA, 0x43BA, [0xA0, 0x12, 0x38, 0x89, 0x4B, 0xD0, 0x48, 0xF1]);
interface IInstallationProgressChangedCallback : IUnknown
{
    HRESULT Invoke(IInstallationJob installationJob, IInstallationProgressChangedCallbackArgs callbackArgs);
}

const GUID IID_IUpdateInstaller = {0x7B929C68, 0xCCDC, 0x4226, [0x96, 0xB1, 0x87, 0x24, 0x60, 0x0B, 0x54, 0xC2]};
@GUID(0x7B929C68, 0xCCDC, 0x4226, [0x96, 0xB1, 0x87, 0x24, 0x60, 0x0B, 0x54, 0xC2]);
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
    HRESULT BeginUninstall(IUnknown onProgressChanged, IUnknown onCompleted, VARIANT state, IInstallationJob* retval);
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

const GUID IID_IUpdateInstaller2 = {0x3442D4FE, 0x224D, 0x4CEE, [0x98, 0xCF, 0x30, 0xE0, 0xC4, 0xD2, 0x29, 0xE6]};
@GUID(0x3442D4FE, 0x224D, 0x4CEE, [0x98, 0xCF, 0x30, 0xE0, 0xC4, 0xD2, 0x29, 0xE6]);
interface IUpdateInstaller2 : IUpdateInstaller
{
    HRESULT get_ForceQuiet(short* retval);
    HRESULT put_ForceQuiet(short value);
}

const GUID IID_IUpdateInstaller3 = {0x16D11C35, 0x099A, 0x48D0, [0x83, 0x38, 0x5F, 0xAE, 0x64, 0x04, 0x7F, 0x8E]};
@GUID(0x16D11C35, 0x099A, 0x48D0, [0x83, 0x38, 0x5F, 0xAE, 0x64, 0x04, 0x7F, 0x8E]);
interface IUpdateInstaller3 : IUpdateInstaller2
{
    HRESULT get_AttemptCloseAppsIfNecessary(short* retval);
    HRESULT put_AttemptCloseAppsIfNecessary(short value);
}

const GUID IID_IUpdateInstaller4 = {0xEF8208EA, 0x2304, 0x492D, [0x91, 0x09, 0x23, 0x81, 0x3B, 0x09, 0x58, 0xE1]};
@GUID(0xEF8208EA, 0x2304, 0x492D, [0x91, 0x09, 0x23, 0x81, 0x3B, 0x09, 0x58, 0xE1]);
interface IUpdateInstaller4 : IUpdateInstaller3
{
    HRESULT Commit(uint dwFlags);
}

const GUID IID_IUpdateSession = {0x816858A4, 0x260D, 0x4260, [0x93, 0x3A, 0x25, 0x85, 0xF1, 0xAB, 0xC7, 0x6B]};
@GUID(0x816858A4, 0x260D, 0x4260, [0x93, 0x3A, 0x25, 0x85, 0xF1, 0xAB, 0xC7, 0x6B]);
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

const GUID IID_IUpdateSession2 = {0x91CAF7B0, 0xEB23, 0x49ED, [0x99, 0x37, 0xC5, 0x2D, 0x81, 0x7F, 0x46, 0xF7]};
@GUID(0x91CAF7B0, 0xEB23, 0x49ED, [0x99, 0x37, 0xC5, 0x2D, 0x81, 0x7F, 0x46, 0xF7]);
interface IUpdateSession2 : IUpdateSession
{
    HRESULT get_UserLocale(uint* retval);
    HRESULT put_UserLocale(uint lcid);
}

const GUID IID_IUpdateSession3 = {0x918EFD1E, 0xB5D8, 0x4C90, [0x85, 0x40, 0xAE, 0xB9, 0xBD, 0xC5, 0x6F, 0x9D]};
@GUID(0x918EFD1E, 0xB5D8, 0x4C90, [0x85, 0x40, 0xAE, 0xB9, 0xBD, 0xC5, 0x6F, 0x9D]);
interface IUpdateSession3 : IUpdateSession2
{
    HRESULT CreateUpdateServiceManager(IUpdateServiceManager2* retval);
    HRESULT QueryHistory(BSTR criteria, int startIndex, int count, IUpdateHistoryEntryCollection* retval);
}

const GUID IID_IUpdateService = {0x76B3B17E, 0xAED6, 0x4DA5, [0x85, 0xF0, 0x83, 0x58, 0x7F, 0x81, 0xAB, 0xE3]};
@GUID(0x76B3B17E, 0xAED6, 0x4DA5, [0x85, 0xF0, 0x83, 0x58, 0x7F, 0x81, 0xAB, 0xE3]);
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

const GUID IID_IUpdateService2 = {0x1518B460, 0x6518, 0x4172, [0x94, 0x0F, 0xC7, 0x58, 0x83, 0xB2, 0x4C, 0xEB]};
@GUID(0x1518B460, 0x6518, 0x4172, [0x94, 0x0F, 0xC7, 0x58, 0x83, 0xB2, 0x4C, 0xEB]);
interface IUpdateService2 : IUpdateService
{
    HRESULT get_IsDefaultAUService(short* retval);
}

const GUID IID_IUpdateServiceCollection = {0x9B0353AA, 0x0E52, 0x44FF, [0xB8, 0xB0, 0x1F, 0x7F, 0xA0, 0x43, 0x7F, 0x88]};
@GUID(0x9B0353AA, 0x0E52, 0x44FF, [0xB8, 0xB0, 0x1F, 0x7F, 0xA0, 0x43, 0x7F, 0x88]);
interface IUpdateServiceCollection : IDispatch
{
    HRESULT get_Item(int index, IUpdateService* retval);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Count(int* retval);
}

const GUID IID_IUpdateServiceRegistration = {0xDDE02280, 0x12B3, 0x4E0B, [0x93, 0x7B, 0x67, 0x47, 0xF6, 0xAC, 0xB2, 0x86]};
@GUID(0xDDE02280, 0x12B3, 0x4E0B, [0x93, 0x7B, 0x67, 0x47, 0xF6, 0xAC, 0xB2, 0x86]);
interface IUpdateServiceRegistration : IDispatch
{
    HRESULT get_RegistrationState(UpdateServiceRegistrationState* retval);
    HRESULT get_ServiceID(BSTR* retval);
    HRESULT get_IsPendingRegistrationWithAU(short* retval);
    HRESULT get_Service(IUpdateService2* retval);
}

const GUID IID_IUpdateServiceManager = {0x23857E3C, 0x02BA, 0x44A3, [0x94, 0x23, 0xB1, 0xC9, 0x00, 0x80, 0x5F, 0x37]};
@GUID(0x23857E3C, 0x02BA, 0x44A3, [0x94, 0x23, 0xB1, 0xC9, 0x00, 0x80, 0x5F, 0x37]);
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

const GUID IID_IUpdateServiceManager2 = {0x0BB8531D, 0x7E8D, 0x424F, [0x98, 0x6C, 0xA0, 0xB8, 0xF6, 0x0A, 0x3E, 0x7B]};
@GUID(0x0BB8531D, 0x7E8D, 0x424F, [0x98, 0x6C, 0xA0, 0xB8, 0xF6, 0x0A, 0x3E, 0x7B]);
interface IUpdateServiceManager2 : IUpdateServiceManager
{
    HRESULT get_ClientApplicationID(BSTR* retval);
    HRESULT put_ClientApplicationID(BSTR value);
    HRESULT QueryServiceRegistration(BSTR serviceID, IUpdateServiceRegistration* retval);
    HRESULT AddService2(BSTR serviceID, int flags, BSTR authorizationCabPath, IUpdateServiceRegistration* retval);
}

const GUID IID_IInstallationAgent = {0x925CBC18, 0xA2EA, 0x4648, [0xBF, 0x1C, 0xEC, 0x8B, 0xAD, 0xCF, 0xE2, 0x0A]};
@GUID(0x925CBC18, 0xA2EA, 0x4648, [0xBF, 0x1C, 0xEC, 0x8B, 0xAD, 0xCF, 0xE2, 0x0A]);
interface IInstallationAgent : IDispatch
{
    HRESULT RecordInstallationResult(BSTR installationResultCookie, int hresult, IStringCollection extendedReportingData);
}

enum UpdateLockdownOption
{
    uloForWebsiteAccess = 1,
}

enum AddServiceFlag
{
    asfAllowPendingRegistration = 1,
    asfAllowOnlineRegistration = 2,
    asfRegisterServiceWithAU = 4,
}

enum UpdateServiceOption
{
    usoNonVolatileService = 1,
}

