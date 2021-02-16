module windows.windowsprogramming;

public import windows.core;
public import windows.automation : BSTR, IDispatch, SAFEARRAY, VARIANT;
public import windows.com : HRESULT, IBindCtx, IMalloc, IUnknown, OLECMDEXECOPT, OLECMDF, OLECMDID, QUERYCONTEXT;
public import windows.coreaudio : DDVIDEOPORTCONNECT;
public import windows.dbg : CONTEXT, DEBUG_EVENT, EXCEPTION_RECORD, LDT_ENTRY;
public import windows.direct2d : PALETTEENTRY;
public import windows.directdraw : DDBLTFX, DDCOLORCONTROL, DDGAMMARAMP, DDOVERLAYFX, DDPIXELFORMAT, DDSCAPS, DDSCAPS2,
                                   DDSCAPSEX, DDSURFACEDESC, DDSURFACEDESC2;
public import windows.directshow : DDCOLORKEY, READYSTATE;
public import windows.displaydevices : DDCORECAPS, DDHAL_DESTROYDDLOCALDATA, DDHAL_WAITFORVERTICALBLANKDATA,
                                       DDKERNELCAPS, DDVIDEOPORTBANDWIDTH, DDVIDEOPORTCAPS, DDVIDEOPORTDESC,
                                       DDVIDEOPORTINFO, HEAPALIGNMENT, RECT, RECTL, VMEMHEAP;
public import windows.gdi : HDC, HPALETTE, RGNDATA;
public import windows.kernel : LIST_ENTRY;
public import windows.rpc : MIDL_STUB_MESSAGE;
public import windows.security : GENERIC_MAPPING, PRIVILEGE_SET, UNICODE_STRING;
public import windows.systemservices : BOOL, CUSTOM_SYSTEM_EVENT_TRIGGER_CONFIG, DEVPROPCOMPKEY, DEVPROPERTY,
                                       DEVPROPKEY, DEVPROPSTORE, FLOATING_SAVE_AREA, HANDLE, HINSTANCE, JOB_SET_ARRAY,
                                       LARGE_INTEGER, LPTHREAD_START_ROUTINE, LRESULT, LSTATUS, NTSTATUS, PEB,
                                       PROCESS_DYNAMIC_EH_CONTINUATION_TARGET, SECURITY_ATTRIBUTES, STARTUPINFOA,
                                       SYSTEM_CPU_SET_INFORMATION, WAITORTIMERCALLBACK, uCLSSPEC;
public import windows.windowsandmessaging : HWND, LPARAM, WPARAM;

extern(Windows):


// Enums


enum : uint
{
    DEBUG_PROCESS                    = 0x00000001,
    DEBUG_ONLY_THIS_PROCESS          = 0x00000002,
    CREATE_SUSPENDED                 = 0x00000004,
    DETACHED_PROCESS                 = 0x00000008,
    CREATE_NEW_CONSOLE               = 0x00000010,
    NORMAL_PRIORITY_CLASS            = 0x00000020,
    IDLE_PRIORITY_CLASS              = 0x00000040,
    HIGH_PRIORITY_CLASS              = 0x00000080,
    REALTIME_PRIORITY_CLASS          = 0x00000100,
    CREATE_NEW_PROCESS_GROUP         = 0x00000200,
    CREATE_UNICODE_ENVIRONMENT       = 0x00000400,
    CREATE_SEPARATE_WOW_VDM          = 0x00000800,
    CREATE_SHARED_WOW_VDM            = 0x00001000,
    CREATE_FORCEDOS                  = 0x00002000,
    BELOW_NORMAL_PRIORITY_CLASS      = 0x00004000,
    ABOVE_NORMAL_PRIORITY_CLASS      = 0x00008000,
    INHERIT_PARENT_AFFINITY          = 0x00010000,
    INHERIT_CALLER_PRIORITY          = 0x00020000,
    CREATE_PROTECTED_PROCESS         = 0x00040000,
    EXTENDED_STARTUPINFO_PRESENT     = 0x00080000,
    PROCESS_MODE_BACKGROUND_BEGIN    = 0x00100000,
    PROCESS_MODE_BACKGROUND_END      = 0x00200000,
    CREATE_SECURE_PROCESS            = 0x00400000,
    CREATE_BREAKAWAY_FROM_JOB        = 0x01000000,
    CREATE_PRESERVE_CODE_AUTHZ_LEVEL = 0x02000000,
    CREATE_DEFAULT_ERROR_MODE        = 0x04000000,
    CREATE_NO_WINDOW                 = 0x08000000,
    PROFILE_USER                     = 0x10000000,
    PROFILE_KERNEL                   = 0x20000000,
    PROFILE_SERVER                   = 0x40000000,
    CREATE_IGNORE_SYSTEM_DEFAULT     = 0x80000000,
}
alias PROCESS_CREATION_FLAGS = uint;

enum : int
{
    HANDLE_FLAG_INHERIT            = 0x00000001,
    HANDLE_FLAG_PROTECT_FROM_CLOSE = 0x00000002,
}
alias HANDLE_FLAG_OPTIONS = int;

enum : int
{
    DUPLICATE_CLOSE_SOURCE = 0x00000001,
    DUPLICATE_SAME_ACCESS  = 0x00000002,
}
alias DUPLICATE_HANDLE_OPTIONS = int;

enum : uint
{
    STD_INPUT_HANDLE  = 0xfffffff6,
    STD_OUTPUT_HANDLE = 0xfffffff5,
    STD_ERROR_HANDLE  = 0xfffffff4,
}
alias STD_HANDLE_TYPE = uint;

enum : uint
{
    VER_MINORVERSION     = 0x00000001,
    VER_MAJORVERSION     = 0x00000002,
    VER_BUILDNUMBER      = 0x00000004,
    VER_PLATFORMID       = 0x00000008,
    VER_SERVICEPACKMINOR = 0x00000010,
    VER_SERVICEPACKMAJOR = 0x00000020,
    VER_SUITENAME        = 0x00000040,
    VER_PRODUCT_TYPE     = 0x00000080,
}
alias VER_FLAGS = uint;

enum ProcessAccessRights : uint
{
    Terminate               = 0x00000001,
    CreateThread            = 0x00000002,
    SetSessionid            = 0x00000004,
    VmOperation             = 0x00000008,
    VmRead                  = 0x00000010,
    VmWrite                 = 0x00000020,
    DupHandle               = 0x00000040,
    CreateProcess           = 0x00000080,
    SetQuota                = 0x00000100,
    SetInformation          = 0x00000200,
    QueryInformation        = 0x00000400,
    SuspendResume           = 0x00000800,
    QueryLimitedInformation = 0x00001000,
    SetLimitedInformation   = 0x00002000,
    AllAccess               = 0x001fffff,
    Delete                  = 0x00010000,
    ReadControl             = 0x00020000,
    WriteDac                = 0x00040000,
    WriteOwner              = 0x00080000,
    Synchronize             = 0x00100000,
    StandardRightsRequired  = 0x000f0000,
}

enum : int
{
    FirmwareTypeUnknown = 0x00000000,
    FirmwareTypeBios    = 0x00000001,
    FirmwareTypeUefi    = 0x00000002,
    FirmwareTypeMax     = 0x00000003,
}
alias FIRMWARE_TYPE = int;

enum UpdateImpactLevel : int
{
    UpdateImpactLevel_None   = 0x00000000,
    UpdateImpactLevel_Low    = 0x00000001,
    UpdateImpactLevel_Medium = 0x00000002,
    UpdateImpactLevel_High   = 0x00000003,
}

enum UpdateAssessmentStatus : int
{
    UpdateAssessmentStatus_Latest                   = 0x00000000,
    UpdateAssessmentStatus_NotLatestSoftRestriction = 0x00000001,
    UpdateAssessmentStatus_NotLatestHardRestriction = 0x00000002,
    UpdateAssessmentStatus_NotLatestEndOfSupport    = 0x00000003,
    UpdateAssessmentStatus_NotLatestServicingTrain  = 0x00000004,
    UpdateAssessmentStatus_NotLatestDeferredFeature = 0x00000005,
    UpdateAssessmentStatus_NotLatestDeferredQuality = 0x00000006,
    UpdateAssessmentStatus_NotLatestPausedFeature   = 0x00000007,
    UpdateAssessmentStatus_NotLatestPausedQuality   = 0x00000008,
    UpdateAssessmentStatus_NotLatestManaged         = 0x00000009,
    UpdateAssessmentStatus_NotLatestUnknown         = 0x0000000a,
    UpdateAssessmentStatus_NotLatestTargetedVersion = 0x0000000b,
}

enum : int
{
    NameUnknown          = 0x00000000,
    NameFullyQualifiedDN = 0x00000001,
    NameSamCompatible    = 0x00000002,
    NameDisplay          = 0x00000003,
    NameUniqueId         = 0x00000006,
    NameCanonical        = 0x00000007,
    NameUserPrincipal    = 0x00000008,
    NameCanonicalEx      = 0x00000009,
    NameServicePrincipal = 0x0000000a,
    NameDnsDomain        = 0x0000000c,
    NameGivenName        = 0x0000000d,
    NameSurname          = 0x0000000e,
}
alias EXTENDED_NAME_FORMAT = int;

enum : int
{
    ThreadMemoryPriority      = 0x00000000,
    ThreadAbsoluteCpuPriority = 0x00000001,
    ThreadDynamicCodePolicy   = 0x00000002,
    ThreadPowerThrottling     = 0x00000003,
    ThreadInformationClassMax = 0x00000004,
}
alias THREAD_INFORMATION_CLASS = int;

enum : int
{
    ComputerNameNetBIOS                   = 0x00000000,
    ComputerNameDnsHostname               = 0x00000001,
    ComputerNameDnsDomain                 = 0x00000002,
    ComputerNameDnsFullyQualified         = 0x00000003,
    ComputerNamePhysicalNetBIOS           = 0x00000004,
    ComputerNamePhysicalDnsHostname       = 0x00000005,
    ComputerNamePhysicalDnsDomain         = 0x00000006,
    ComputerNamePhysicalDnsFullyQualified = 0x00000007,
    ComputerNameMax                       = 0x00000008,
}
alias COMPUTER_NAME_FORMAT = int;

enum : int
{
    DEPPolicyAlwaysOff  = 0x00000000,
    DEPPolicyAlwaysOn   = 0x00000001,
    DEPPolicyOptIn      = 0x00000002,
    DEPPolicyOptOut     = 0x00000003,
    DEPTotalPolicyCount = 0x00000004,
}
alias DEP_SYSTEM_POLICY_TYPE = int;

enum : int
{
    ProcThreadAttributeParentProcess                = 0x00000000,
    ProcThreadAttributeHandleList                   = 0x00000002,
    ProcThreadAttributeGroupAffinity                = 0x00000003,
    ProcThreadAttributePreferredNode                = 0x00000004,
    ProcThreadAttributeIdealProcessor               = 0x00000005,
    ProcThreadAttributeUmsThread                    = 0x00000006,
    ProcThreadAttributeMitigationPolicy             = 0x00000007,
    ProcThreadAttributeSecurityCapabilities         = 0x00000009,
    ProcThreadAttributeProtectionLevel              = 0x0000000b,
    ProcThreadAttributeJobList                      = 0x0000000d,
    ProcThreadAttributeChildProcessPolicy           = 0x0000000e,
    ProcThreadAttributeAllApplicationPackagesPolicy = 0x0000000f,
    ProcThreadAttributeWin32kFilter                 = 0x00000010,
    ProcThreadAttributeSafeOpenPromptOriginClaim    = 0x00000011,
    ProcThreadAttributeDesktopAppPolicy             = 0x00000012,
    ProcThreadAttributePseudoConsole                = 0x00000016,
}
alias PROC_THREAD_ATTRIBUTE_NUM = int;

enum DOMNodeType : int
{
    NODE_INVALID                = 0x00000000,
    NODE_ELEMENT                = 0x00000001,
    NODE_ATTRIBUTE              = 0x00000002,
    NODE_TEXT                   = 0x00000003,
    NODE_CDATA_SECTION          = 0x00000004,
    NODE_ENTITY_REFERENCE       = 0x00000005,
    NODE_ENTITY                 = 0x00000006,
    NODE_PROCESSING_INSTRUCTION = 0x00000007,
    NODE_COMMENT                = 0x00000008,
    NODE_DOCUMENT               = 0x00000009,
    NODE_DOCUMENT_TYPE          = 0x0000000a,
    NODE_DOCUMENT_FRAGMENT      = 0x0000000b,
    NODE_NOTATION               = 0x0000000c,
}

enum : int
{
    XMLELEMTYPE_ELEMENT  = 0x00000000,
    XMLELEMTYPE_TEXT     = 0x00000001,
    XMLELEMTYPE_COMMENT  = 0x00000002,
    XMLELEMTYPE_DOCUMENT = 0x00000003,
    XMLELEMTYPE_DTD      = 0x00000004,
    XMLELEMTYPE_PI       = 0x00000005,
    XMLELEMTYPE_OTHER    = 0x00000006,
}
alias XMLEMEM_TYPE = int;

enum : int
{
    FileDirectoryInformation = 0x00000001,
}
alias FILE_INFORMATION_CLASS = int;

enum : int
{
    ProcessBasicInformation   = 0x00000000,
    ProcessDebugPort          = 0x00000007,
    ProcessWow64Information   = 0x0000001a,
    ProcessImageFileName      = 0x0000001b,
    ProcessBreakOnTermination = 0x0000001d,
}
alias PROCESSINFOCLASS = int;

enum : int
{
    ThreadIsIoPending = 0x00000010,
}
alias THREADINFOCLASS = int;

enum : int
{
    SystemBasicInformation                = 0x00000000,
    SystemPerformanceInformation          = 0x00000002,
    SystemTimeOfDayInformation            = 0x00000003,
    SystemProcessInformation              = 0x00000005,
    SystemProcessorPerformanceInformation = 0x00000008,
    SystemInterruptInformation            = 0x00000017,
    SystemExceptionInformation            = 0x00000021,
    SystemRegistryQuotaInformation        = 0x00000025,
    SystemLookasideInformation            = 0x0000002d,
    SystemCodeIntegrityInformation        = 0x00000067,
    SystemPolicyInformation               = 0x00000086,
}
alias SYSTEM_INFORMATION_CLASS = int;

enum : int
{
    ObjectBasicInformation = 0x00000000,
    ObjectTypeInformation  = 0x00000002,
}
alias OBJECT_INFORMATION_CLASS = int;

enum : int
{
    KeyWriteTimeInformation         = 0x00000000,
    KeyWow64FlagsInformation        = 0x00000001,
    KeyControlFlagsInformation      = 0x00000002,
    KeySetVirtualizationInformation = 0x00000003,
    KeySetDebugInformation          = 0x00000004,
    KeySetHandleTagsInformation     = 0x00000005,
    MaxKeySetInfoClass              = 0x00000006,
}
alias KEY_SET_INFORMATION_CLASS = int;

enum : int
{
    WinStationInformation = 0x00000008,
}
alias WINSTATIONINFOCLASS = int;

enum : int
{
    AllocationStateUnknown = 0x00000000,
    AllocationStateBusy    = 0x00000001,
    AllocationStateFree    = 0x00000002,
}
alias eUserAllocationState = int;

enum : int
{
    HeapFullPageHeap = 0x40000000,
    HeapMetadata     = 0x80000000,
    HeapStateMask    = 0xffff0000,
}
alias eHeapAllocationState = int;

enum : int
{
    HeapEnumerationEverything = 0x00000000,
    HeapEnumerationStop       = 0xffffffff,
}
alias eHeapEnumerationLevel = int;

enum : int
{
    OperationDbUnused = 0x00000000,
    OperationDbOPEN   = 0x00000001,
    OperationDbCLOSE  = 0x00000002,
    OperationDbBADREF = 0x00000003,
}
alias eHANDLE_TRACE_OPERATIONS = int;

enum : int
{
    AvrfResourceHeapAllocation = 0x00000000,
    AvrfResourceHandleTrace    = 0x00000001,
    AvrfResourceMax            = 0x00000002,
}
alias eAvrfResourceTypes = int;

enum CameraUIControlMode : int
{
    Browse  = 0x00000000,
    Linear  = 0x00000001,
}

enum CameraUIControlLinearSelectionMode : int
{
    Single   = 0x00000000,
    Multiple = 0x00000001,
}

enum CameraUIControlCaptureMode : int
{
    PhotoOrVideo = 0x00000000,
    Photo        = 0x00000001,
    Video        = 0x00000002,
}

enum CameraUIControlPhotoFormat : int
{
    Jpeg    = 0x00000000,
    Png     = 0x00000001,
    JpegXR  = 0x00000002,
}

enum CameraUIControlVideoFormat : int
{
    Mp4     = 0x00000000,
    Wmv     = 0x00000001,
}

enum CameraUIControlViewType : int
{
    SingleItem = 0x00000000,
    ItemList   = 0x00000001,
}

enum : int
{
    FCIERR_NONE             = 0x00000000,
    FCIERR_OPEN_SRC         = 0x00000001,
    FCIERR_READ_SRC         = 0x00000002,
    FCIERR_ALLOC_FAIL       = 0x00000003,
    FCIERR_TEMP_FILE        = 0x00000004,
    FCIERR_BAD_COMPR_TYPE   = 0x00000005,
    FCIERR_CAB_FILE         = 0x00000006,
    FCIERR_USER_ABORT       = 0x00000007,
    FCIERR_MCI_FAIL         = 0x00000008,
    FCIERR_CAB_FORMAT_LIMIT = 0x00000009,
}
alias FCIERROR = int;

enum : int
{
    FDIERROR_NONE                    = 0x00000000,
    FDIERROR_CABINET_NOT_FOUND       = 0x00000001,
    FDIERROR_NOT_A_CABINET           = 0x00000002,
    FDIERROR_UNKNOWN_CABINET_VERSION = 0x00000003,
    FDIERROR_CORRUPT_CABINET         = 0x00000004,
    FDIERROR_ALLOC_FAIL              = 0x00000005,
    FDIERROR_BAD_COMPR_TYPE          = 0x00000006,
    FDIERROR_MDI_FAIL                = 0x00000007,
    FDIERROR_TARGET_FILE             = 0x00000008,
    FDIERROR_RESERVE_MISMATCH        = 0x00000009,
    FDIERROR_WRONG_CABINET           = 0x0000000a,
    FDIERROR_USER_ABORT              = 0x0000000b,
    FDIERROR_EOF                     = 0x0000000c,
}
alias FDIERROR = int;

enum : int
{
    fdidtNEW_CABINET = 0x00000000,
    fdidtNEW_FOLDER  = 0x00000001,
    fdidtDECRYPT     = 0x00000002,
}
alias FDIDECRYPTTYPE = int;

enum : int
{
    fdintCABINET_INFO    = 0x00000000,
    fdintPARTIAL_FILE    = 0x00000001,
    fdintCOPY_FILE       = 0x00000002,
    fdintCLOSE_FILE_INFO = 0x00000003,
    fdintNEXT_CABINET    = 0x00000004,
    fdintENUMERATE       = 0x00000005,
}
alias FDINOTIFICATIONTYPE = int;

enum : int
{
    FEATURE_CHANGE_TIME_READ          = 0x00000000,
    FEATURE_CHANGE_TIME_MODULE_RELOAD = 0x00000001,
    FEATURE_CHANGE_TIME_SESSION       = 0x00000002,
    FEATURE_CHANGE_TIME_REBOOT        = 0x00000003,
}
alias FEATURE_CHANGE_TIME = int;

enum : int
{
    FEATURE_ENABLED_STATE_DEFAULT  = 0x00000000,
    FEATURE_ENABLED_STATE_DISABLED = 0x00000001,
    FEATURE_ENABLED_STATE_ENABLED  = 0x00000002,
}
alias FEATURE_ENABLED_STATE = int;

enum : int
{
    FH_TARGET_NAME       = 0x00000000,
    FH_TARGET_URL        = 0x00000001,
    FH_TARGET_DRIVE_TYPE = 0x00000002,
    MAX_TARGET_PROPERTY  = 0x00000003,
}
alias FH_TARGET_PROPERTY_TYPE = int;

enum : int
{
    FH_DRIVE_UNKNOWN   = 0x00000000,
    FH_DRIVE_REMOVABLE = 0x00000002,
    FH_DRIVE_FIXED     = 0x00000003,
    FH_DRIVE_REMOTE    = 0x00000004,
}
alias FH_TARGET_DRIVE_TYPES = int;

enum : int
{
    FH_FOLDER                   = 0x00000000,
    FH_LIBRARY                  = 0x00000001,
    MAX_PROTECTED_ITEM_CATEGORY = 0x00000002,
}
alias FH_PROTECTED_ITEM_CATEGORY = int;

enum : int
{
    FH_FREQUENCY      = 0x00000000,
    FH_RETENTION_TYPE = 0x00000001,
    FH_RETENTION_AGE  = 0x00000002,
    MAX_LOCAL_POLICY  = 0x00000003,
}
alias FH_LOCAL_POLICY_TYPE = int;

enum : int
{
    FH_RETENTION_DISABLED  = 0x00000000,
    FH_RETENTION_UNLIMITED = 0x00000001,
    FH_RETENTION_AGE_BASED = 0x00000002,
    MAX_RETENTION_TYPE     = 0x00000003,
}
alias FH_RETENTION_TYPES = int;

enum : int
{
    FH_STATUS_DISABLED       = 0x00000000,
    FH_STATUS_DISABLED_BY_GP = 0x00000001,
    FH_STATUS_ENABLED        = 0x00000002,
    FH_STATUS_REHYDRATING    = 0x00000003,
    MAX_BACKUP_STATUS        = 0x00000004,
}
alias FH_BACKUP_STATUS = int;

enum : int
{
    FH_ACCESS_DENIED          = 0x00000000,
    FH_INVALID_DRIVE_TYPE     = 0x00000001,
    FH_READ_ONLY_PERMISSION   = 0x00000002,
    FH_CURRENT_DEFAULT        = 0x00000003,
    FH_NAMESPACE_EXISTS       = 0x00000004,
    FH_TARGET_PART_OF_LIBRARY = 0x00000005,
    FH_VALID_TARGET           = 0x00000006,
    MAX_VALIDATION_RESULT     = 0x00000007,
}
alias FH_DEVICE_VALIDATION_RESULT = int;

enum FhBackupStopReason : int
{
    BackupInvalidStopReason        = 0x00000000,
    BackupLimitUserBusyMachineOnAC = 0x00000001,
    BackupLimitUserIdleMachineOnDC = 0x00000002,
    BackupLimitUserBusyMachineOnDC = 0x00000003,
    BackupCancelled                = 0x00000004,
}

enum CommandStateChangeConstants : int
{
    CSC_UPDATECOMMANDS  = 0xffffffff,
    CSC_NAVIGATEFORWARD = 0x00000001,
    CSC_NAVIGATEBACK    = 0x00000002,
}

enum SecureLockIconConstants : int
{
    secureLockIconUnsecure          = 0x00000000,
    secureLockIconMixed             = 0x00000001,
    secureLockIconSecureUnknownBits = 0x00000002,
    secureLockIconSecure40Bit       = 0x00000003,
    secureLockIconSecure56Bit       = 0x00000004,
    secureLockIconSecureFortezza    = 0x00000005,
    secureLockIconSecure128Bit      = 0x00000006,
}

enum NewProcessCauseConstants : int
{
    ProtectedModeRedirect = 0x00000001,
}

enum BrowserNavConstants : int
{
    navOpenInNewWindow       = 0x00000001,
    navNoHistory             = 0x00000002,
    navNoReadFromCache       = 0x00000004,
    navNoWriteToCache        = 0x00000008,
    navAllowAutosearch       = 0x00000010,
    navBrowserBar            = 0x00000020,
    navHyperlink             = 0x00000040,
    navEnforceRestricted     = 0x00000080,
    navNewWindowsManaged     = 0x00000100,
    navUntrustedForDownload  = 0x00000200,
    navTrustedForActiveX     = 0x00000400,
    navOpenInNewTab          = 0x00000800,
    navOpenInBackgroundTab   = 0x00001000,
    navKeepWordWheelText     = 0x00002000,
    navVirtualTab            = 0x00004000,
    navBlockRedirectsXDomain = 0x00008000,
    navOpenNewForegroundTab  = 0x00010000,
    navTravelLogScreenshot   = 0x00020000,
    navDeferUnload           = 0x00040000,
    navSpeculative           = 0x00080000,
    navSuggestNewWindow      = 0x00100000,
    navSuggestNewTab         = 0x00200000,
    navReserved1             = 0x00400000,
    navHomepageNavigate      = 0x00800000,
    navRefresh               = 0x01000000,
    navHostNavigation        = 0x02000000,
    navReserved2             = 0x04000000,
    navReserved3             = 0x08000000,
    navReserved4             = 0x10000000,
    navReserved5             = 0x20000000,
    navReserved6             = 0x40000000,
    navReserved7             = 0x80000000,
}

enum RefreshConstants : int
{
    REFRESH_NORMAL     = 0x00000000,
    REFRESH_IFEXPIRED  = 0x00000001,
    REFRESH_COMPLETELY = 0x00000003,
}

enum : int
{
    WSC_SECURITY_PRODUCT_SUBSTATUS_NOT_SET            = 0x00000000,
    WSC_SECURITY_PRODUCT_SUBSTATUS_NO_ACTION          = 0x00000001,
    WSC_SECURITY_PRODUCT_SUBSTATUS_ACTION_RECOMMENDED = 0x00000002,
    WSC_SECURITY_PRODUCT_SUBSTATUS_ACTION_NEEDED      = 0x00000003,
}
alias WSC_SECURITY_PRODUCT_SUBSTATUS = int;

enum : int
{
    WSC_SECURITY_PRODUCT_STATE_ON      = 0x00000000,
    WSC_SECURITY_PRODUCT_STATE_OFF     = 0x00000001,
    WSC_SECURITY_PRODUCT_STATE_SNOOZED = 0x00000002,
    WSC_SECURITY_PRODUCT_STATE_EXPIRED = 0x00000003,
}
alias WSC_SECURITY_PRODUCT_STATE = int;

enum : int
{
    SECURITY_PRODUCT_TYPE_ANTIVIRUS   = 0x00000000,
    SECURITY_PRODUCT_TYPE_FIREWALL    = 0x00000001,
    SECURITY_PRODUCT_TYPE_ANTISPYWARE = 0x00000002,
}
alias SECURITY_PRODUCT_TYPE = int;

enum : int
{
    WSC_SECURITY_PRODUCT_OUT_OF_DATE = 0x00000000,
    WSC_SECURITY_PRODUCT_UP_TO_DATE  = 0x00000001,
}
alias WSC_SECURITY_SIGNATURE_STATUS = int;

enum : int
{
    WSC_SECURITY_PROVIDER_FIREWALL             = 0x00000001,
    WSC_SECURITY_PROVIDER_AUTOUPDATE_SETTINGS  = 0x00000002,
    WSC_SECURITY_PROVIDER_ANTIVIRUS            = 0x00000004,
    WSC_SECURITY_PROVIDER_ANTISPYWARE          = 0x00000008,
    WSC_SECURITY_PROVIDER_INTERNET_SETTINGS    = 0x00000010,
    WSC_SECURITY_PROVIDER_USER_ACCOUNT_CONTROL = 0x00000020,
    WSC_SECURITY_PROVIDER_SERVICE              = 0x00000040,
    WSC_SECURITY_PROVIDER_NONE                 = 0x00000000,
    WSC_SECURITY_PROVIDER_ALL                  = 0x0000007f,
}
alias WSC_SECURITY_PROVIDER = int;

enum : int
{
    WSC_SECURITY_PROVIDER_HEALTH_GOOD         = 0x00000000,
    WSC_SECURITY_PROVIDER_HEALTH_NOTMONITORED = 0x00000001,
    WSC_SECURITY_PROVIDER_HEALTH_POOR         = 0x00000002,
    WSC_SECURITY_PROVIDER_HEALTH_SNOOZE       = 0x00000003,
}
alias WSC_SECURITY_PROVIDER_HEALTH = int;

enum : int
{
    EndpointIoControlType   = 0x00000000,
    SetSockOptIoControlType = 0x00000001,
    GetSockOptIoControlType = 0x00000002,
    SocketIoControlType     = 0x00000003,
}
alias TDI_TL_IO_CONTROL_TYPE = int;

enum : int
{
    WLDP_HOST_RUNDLL32 = 0x00000000,
    WLDP_HOST_SVCHOST  = 0x00000001,
    WLDP_HOST_MAX      = 0x00000002,
}
alias WLDP_HOST = int;

enum : int
{
    WLDP_HOST_ID_UNKNOWN    = 0x00000000,
    WLDP_HOST_ID_GLOBAL     = 0x00000001,
    WLDP_HOST_ID_VBA        = 0x00000002,
    WLDP_HOST_ID_WSH        = 0x00000003,
    WLDP_HOST_ID_POWERSHELL = 0x00000004,
    WLDP_HOST_ID_IE         = 0x00000005,
    WLDP_HOST_ID_MSI        = 0x00000006,
    WLDP_HOST_ID_ALL        = 0x00000007,
    WLDP_HOST_ID_MAX        = 0x00000008,
}
alias WLDP_HOST_ID = int;

enum : int
{
    DECISION_LOCATION_REFRESH_GLOBAL_DATA         = 0x00000000,
    DECISION_LOCATION_PARAMETER_VALIDATION        = 0x00000001,
    DECISION_LOCATION_AUDIT                       = 0x00000002,
    DECISION_LOCATION_FAILED_CONVERT_GUID         = 0x00000003,
    DECISION_LOCATION_ENTERPRISE_DEFINED_CLASS_ID = 0x00000004,
    DECISION_LOCATION_GLOBAL_BUILT_IN_LIST        = 0x00000005,
    DECISION_LOCATION_PROVIDER_BUILT_IN_LIST      = 0x00000006,
    DECISION_LOCATION_ENFORCE_STATE_LIST          = 0x00000007,
    DECISION_LOCATION_NOT_FOUND                   = 0x00000008,
    DECISION_LOCATION_UNKNOWN                     = 0x00000009,
}
alias DECISION_LOCATION = int;

enum : int
{
    KEY_UNKNOWN  = 0x00000000,
    KEY_OVERRIDE = 0x00000001,
    KEY_ALL_KEYS = 0x00000002,
}
alias WLDP_KEY = int;

enum : int
{
    VALUENAME_UNKNOWN                     = 0x00000000,
    VALUENAME_ENTERPRISE_DEFINED_CLASS_ID = 0x00000001,
    VALUENAME_BUILT_IN_LIST               = 0x00000002,
}
alias VALUENAME = int;

enum : int
{
    WLDP_WINDOWS_LOCKDOWN_MODE_UNLOCKED = 0x00000000,
    WLDP_WINDOWS_LOCKDOWN_MODE_TRIAL    = 0x00000001,
    WLDP_WINDOWS_LOCKDOWN_MODE_LOCKED   = 0x00000002,
    WLDP_WINDOWS_LOCKDOWN_MODE_MAX      = 0x00000003,
}
alias WLDP_WINDOWS_LOCKDOWN_MODE = int;

enum : int
{
    WLDP_WINDOWS_LOCKDOWN_RESTRICTION_NONE               = 0x00000000,
    WLDP_WINDOWS_LOCKDOWN_RESTRICTION_NOUNLOCK           = 0x00000001,
    WLDP_WINDOWS_LOCKDOWN_RESTRICTION_NOUNLOCK_PERMANENT = 0x00000002,
    WLDP_WINDOWS_LOCKDOWN_RESTRICTION_MAX                = 0x00000003,
}
alias WLDP_WINDOWS_LOCKDOWN_RESTRICTION = int;

enum XmlNodeType : int
{
    XmlNodeType_None                  = 0x00000000,
    XmlNodeType_Element               = 0x00000001,
    XmlNodeType_Attribute             = 0x00000002,
    XmlNodeType_Text                  = 0x00000003,
    XmlNodeType_CDATA                 = 0x00000004,
    XmlNodeType_ProcessingInstruction = 0x00000007,
    XmlNodeType_Comment               = 0x00000008,
    XmlNodeType_DocumentType          = 0x0000000a,
    XmlNodeType_Whitespace            = 0x0000000d,
    XmlNodeType_EndElement            = 0x0000000f,
    XmlNodeType_XmlDeclaration        = 0x00000011,
    _XmlNodeType_Last                 = 0x00000011,
}

enum XmlConformanceLevel : int
{
    XmlConformanceLevel_Auto     = 0x00000000,
    XmlConformanceLevel_Fragment = 0x00000001,
    XmlConformanceLevel_Document = 0x00000002,
    _XmlConformanceLevel_Last    = 0x00000002,
}

enum DtdProcessing : int
{
    DtdProcessing_Prohibit = 0x00000000,
    DtdProcessing_Parse    = 0x00000001,
    _DtdProcessing_Last    = 0x00000001,
}

enum XmlReadState : int
{
    XmlReadState_Initial     = 0x00000000,
    XmlReadState_Interactive = 0x00000001,
    XmlReadState_Error       = 0x00000002,
    XmlReadState_EndOfFile   = 0x00000003,
    XmlReadState_Closed      = 0x00000004,
}

enum XmlReaderProperty : int
{
    XmlReaderProperty_MultiLanguage      = 0x00000000,
    XmlReaderProperty_ConformanceLevel   = 0x00000001,
    XmlReaderProperty_RandomAccess       = 0x00000002,
    XmlReaderProperty_XmlResolver        = 0x00000003,
    XmlReaderProperty_DtdProcessing      = 0x00000004,
    XmlReaderProperty_ReadState          = 0x00000005,
    XmlReaderProperty_MaxElementDepth    = 0x00000006,
    XmlReaderProperty_MaxEntityExpansion = 0x00000007,
    _XmlReaderProperty_Last              = 0x00000007,
}

enum XmlError : int
{
    MX_E_MX                     = 0xc00cee00,
    MX_E_INPUTEND               = 0xc00cee01,
    MX_E_ENCODING               = 0xc00cee02,
    MX_E_ENCODINGSWITCH         = 0xc00cee03,
    MX_E_ENCODINGSIGNATURE      = 0xc00cee04,
    WC_E_WC                     = 0xc00cee20,
    WC_E_WHITESPACE             = 0xc00cee21,
    WC_E_SEMICOLON              = 0xc00cee22,
    WC_E_GREATERTHAN            = 0xc00cee23,
    WC_E_QUOTE                  = 0xc00cee24,
    WC_E_EQUAL                  = 0xc00cee25,
    WC_E_LESSTHAN               = 0xc00cee26,
    WC_E_HEXDIGIT               = 0xc00cee27,
    WC_E_DIGIT                  = 0xc00cee28,
    WC_E_LEFTBRACKET            = 0xc00cee29,
    WC_E_LEFTPAREN              = 0xc00cee2a,
    WC_E_XMLCHARACTER           = 0xc00cee2b,
    WC_E_NAMECHARACTER          = 0xc00cee2c,
    WC_E_SYNTAX                 = 0xc00cee2d,
    WC_E_CDSECT                 = 0xc00cee2e,
    WC_E_COMMENT                = 0xc00cee2f,
    WC_E_CONDSECT               = 0xc00cee30,
    WC_E_DECLATTLIST            = 0xc00cee31,
    WC_E_DECLDOCTYPE            = 0xc00cee32,
    WC_E_DECLELEMENT            = 0xc00cee33,
    WC_E_DECLENTITY             = 0xc00cee34,
    WC_E_DECLNOTATION           = 0xc00cee35,
    WC_E_NDATA                  = 0xc00cee36,
    WC_E_PUBLIC                 = 0xc00cee37,
    WC_E_SYSTEM                 = 0xc00cee38,
    WC_E_NAME                   = 0xc00cee39,
    WC_E_ROOTELEMENT            = 0xc00cee3a,
    WC_E_ELEMENTMATCH           = 0xc00cee3b,
    WC_E_UNIQUEATTRIBUTE        = 0xc00cee3c,
    WC_E_TEXTXMLDECL            = 0xc00cee3d,
    WC_E_LEADINGXML             = 0xc00cee3e,
    WC_E_TEXTDECL               = 0xc00cee3f,
    WC_E_XMLDECL                = 0xc00cee40,
    WC_E_ENCNAME                = 0xc00cee41,
    WC_E_PUBLICID               = 0xc00cee42,
    WC_E_PESINTERNALSUBSET      = 0xc00cee43,
    WC_E_PESBETWEENDECLS        = 0xc00cee44,
    WC_E_NORECURSION            = 0xc00cee45,
    WC_E_ENTITYCONTENT          = 0xc00cee46,
    WC_E_UNDECLAREDENTITY       = 0xc00cee47,
    WC_E_PARSEDENTITY           = 0xc00cee48,
    WC_E_NOEXTERNALENTITYREF    = 0xc00cee49,
    WC_E_PI                     = 0xc00cee4a,
    WC_E_SYSTEMID               = 0xc00cee4b,
    WC_E_QUESTIONMARK           = 0xc00cee4c,
    WC_E_CDSECTEND              = 0xc00cee4d,
    WC_E_MOREDATA               = 0xc00cee4e,
    WC_E_DTDPROHIBITED          = 0xc00cee4f,
    WC_E_INVALIDXMLSPACE        = 0xc00cee50,
    NC_E_NC                     = 0xc00cee60,
    NC_E_QNAMECHARACTER         = 0xc00cee61,
    NC_E_QNAMECOLON             = 0xc00cee62,
    NC_E_NAMECOLON              = 0xc00cee63,
    NC_E_DECLAREDPREFIX         = 0xc00cee64,
    NC_E_UNDECLAREDPREFIX       = 0xc00cee65,
    NC_E_EMPTYURI               = 0xc00cee66,
    NC_E_XMLPREFIXRESERVED      = 0xc00cee67,
    NC_E_XMLNSPREFIXRESERVED    = 0xc00cee68,
    NC_E_XMLURIRESERVED         = 0xc00cee69,
    NC_E_XMLNSURIRESERVED       = 0xc00cee6a,
    SC_E_SC                     = 0xc00cee80,
    SC_E_MAXELEMENTDEPTH        = 0xc00cee81,
    SC_E_MAXENTITYEXPANSION     = 0xc00cee82,
    WR_E_WR                     = 0xc00cef00,
    WR_E_NONWHITESPACE          = 0xc00cef01,
    WR_E_NSPREFIXDECLARED       = 0xc00cef02,
    WR_E_NSPREFIXWITHEMPTYNSURI = 0xc00cef03,
    WR_E_DUPLICATEATTRIBUTE     = 0xc00cef04,
    WR_E_XMLNSPREFIXDECLARATION = 0xc00cef05,
    WR_E_XMLPREFIXDECLARATION   = 0xc00cef06,
    WR_E_XMLURIDECLARATION      = 0xc00cef07,
    WR_E_XMLNSURIDECLARATION    = 0xc00cef08,
    WR_E_NAMESPACEUNDECLARED    = 0xc00cef09,
    WR_E_INVALIDXMLSPACE        = 0xc00cef0a,
    WR_E_INVALIDACTION          = 0xc00cef0b,
    WR_E_INVALIDSURROGATEPAIR   = 0xc00cef0c,
    XML_E_INVALID_DECIMAL       = 0xc00ce01d,
    XML_E_INVALID_HEXIDECIMAL   = 0xc00ce01e,
    XML_E_INVALID_UNICODE       = 0xc00ce01f,
    XML_E_INVALIDENCODING       = 0xc00ce06e,
}

enum XmlStandalone : int
{
    XmlStandalone_Omit  = 0x00000000,
    XmlStandalone_Yes   = 0x00000001,
    XmlStandalone_No    = 0x00000002,
    _XmlStandalone_Last = 0x00000002,
}

enum XmlWriterProperty : int
{
    XmlWriterProperty_MultiLanguage       = 0x00000000,
    XmlWriterProperty_Indent              = 0x00000001,
    XmlWriterProperty_ByteOrderMark       = 0x00000002,
    XmlWriterProperty_OmitXmlDeclaration  = 0x00000003,
    XmlWriterProperty_ConformanceLevel    = 0x00000004,
    XmlWriterProperty_CompactEmptyElement = 0x00000005,
    _XmlWriterProperty_Last               = 0x00000005,
}

enum : int
{
    DEVPROP_OPERATOR_MODIFIER_NOT                         = 0x00010000,
    DEVPROP_OPERATOR_MODIFIER_IGNORE_CASE                 = 0x00020000,
    DEVPROP_OPERATOR_NONE                                 = 0x00000000,
    DEVPROP_OPERATOR_EXISTS                               = 0x00000001,
    DEVPROP_OPERATOR_NOT_EXISTS                           = 0x00010001,
    DEVPROP_OPERATOR_EQUALS                               = 0x00000002,
    DEVPROP_OPERATOR_NOT_EQUALS                           = 0x00010002,
    DEVPROP_OPERATOR_GREATER_THAN                         = 0x00000003,
    DEVPROP_OPERATOR_LESS_THAN                            = 0x00000004,
    DEVPROP_OPERATOR_GREATER_THAN_EQUALS                  = 0x00000005,
    DEVPROP_OPERATOR_LESS_THAN_EQUALS                     = 0x00000006,
    DEVPROP_OPERATOR_EQUALS_IGNORE_CASE                   = 0x00020002,
    DEVPROP_OPERATOR_NOT_EQUALS_IGNORE_CASE               = 0x00030002,
    DEVPROP_OPERATOR_BITWISE_AND                          = 0x00000007,
    DEVPROP_OPERATOR_BITWISE_OR                           = 0x00000008,
    DEVPROP_OPERATOR_BEGINS_WITH                          = 0x00000009,
    DEVPROP_OPERATOR_ENDS_WITH                            = 0x0000000a,
    DEVPROP_OPERATOR_CONTAINS                             = 0x0000000b,
    DEVPROP_OPERATOR_BEGINS_WITH_IGNORE_CASE              = 0x00020009,
    DEVPROP_OPERATOR_ENDS_WITH_IGNORE_CASE                = 0x0002000a,
    DEVPROP_OPERATOR_CONTAINS_IGNORE_CASE                 = 0x0002000b,
    DEVPROP_OPERATOR_LIST_CONTAINS                        = 0x00001000,
    DEVPROP_OPERATOR_LIST_ELEMENT_BEGINS_WITH             = 0x00002000,
    DEVPROP_OPERATOR_LIST_ELEMENT_ENDS_WITH               = 0x00003000,
    DEVPROP_OPERATOR_LIST_ELEMENT_CONTAINS                = 0x00004000,
    DEVPROP_OPERATOR_LIST_CONTAINS_IGNORE_CASE            = 0x00021000,
    DEVPROP_OPERATOR_LIST_ELEMENT_BEGINS_WITH_IGNORE_CASE = 0x00022000,
    DEVPROP_OPERATOR_LIST_ELEMENT_ENDS_WITH_IGNORE_CASE   = 0x00023000,
    DEVPROP_OPERATOR_LIST_ELEMENT_CONTAINS_IGNORE_CASE    = 0x00024000,
    DEVPROP_OPERATOR_AND_OPEN                             = 0x00100000,
    DEVPROP_OPERATOR_AND_CLOSE                            = 0x00200000,
    DEVPROP_OPERATOR_OR_OPEN                              = 0x00300000,
    DEVPROP_OPERATOR_OR_CLOSE                             = 0x00400000,
    DEVPROP_OPERATOR_NOT_OPEN                             = 0x00500000,
    DEVPROP_OPERATOR_NOT_CLOSE                            = 0x00600000,
    DEVPROP_OPERATOR_ARRAY_CONTAINS                       = 0x10000000,
    DEVPROP_OPERATOR_MASK_EVAL                            = 0x00000fff,
    DEVPROP_OPERATOR_MASK_LIST                            = 0x0000f000,
    DEVPROP_OPERATOR_MASK_MODIFIER                        = 0x000f0000,
    DEVPROP_OPERATOR_MASK_NOT_LOGICAL                     = 0xf00fffff,
    DEVPROP_OPERATOR_MASK_LOGICAL                         = 0x0ff00000,
    DEVPROP_OPERATOR_MASK_ARRAY                           = 0xf0000000,
}
alias DEVPROP_OPERATOR = int;

enum : int
{
    DevObjectTypeUnknown                = 0x00000000,
    DevObjectTypeDeviceInterface        = 0x00000001,
    DevObjectTypeDeviceContainer        = 0x00000002,
    DevObjectTypeDevice                 = 0x00000003,
    DevObjectTypeDeviceInterfaceClass   = 0x00000004,
    DevObjectTypeAEP                    = 0x00000005,
    DevObjectTypeAEPContainer           = 0x00000006,
    DevObjectTypeDeviceInstallerClass   = 0x00000007,
    DevObjectTypeDeviceInterfaceDisplay = 0x00000008,
    DevObjectTypeDeviceContainerDisplay = 0x00000009,
    DevObjectTypeAEPService             = 0x0000000a,
    DevObjectTypeDevicePanel            = 0x0000000b,
}
alias DEV_OBJECT_TYPE = int;

enum : int
{
    DevQueryFlagNone          = 0x00000000,
    DevQueryFlagUpdateResults = 0x00000001,
    DevQueryFlagAllProperties = 0x00000002,
    DevQueryFlagLocalize      = 0x00000004,
    DevQueryFlagAsyncClose    = 0x00000008,
}
alias DEV_QUERY_FLAGS = int;

enum : int
{
    DevQueryStateInitialized   = 0x00000000,
    DevQueryStateEnumCompleted = 0x00000001,
    DevQueryStateAborted       = 0x00000002,
    DevQueryStateClosed        = 0x00000003,
}
alias DEV_QUERY_STATE = int;

enum : int
{
    DevQueryResultStateChange = 0x00000000,
    DevQueryResultAdd         = 0x00000001,
    DevQueryResultUpdate      = 0x00000002,
    DevQueryResultRemove      = 0x00000003,
}
alias DEV_QUERY_RESULT_ACTION = int;

enum : int
{
    GF_FRAGMENTS  = 0x00000002,
    GF_STRONGHOST = 0x00000008,
    GF_FRAGCACHE  = 0x00000009,
}
alias _GlobalFilter = int;

enum : int
{
    PF_ACTION_FORWARD = 0x00000000,
    PF_ACTION_DROP    = 0x00000001,
}
alias _PfForwardAction = int;

enum : int
{
    PF_IPV4 = 0x00000000,
    PF_IPV6 = 0x00000001,
}
alias _PfAddresType = int;

enum : int
{
    PFFT_FILTER = 0x00000001,
    PFFT_FRAG   = 0x00000002,
    PFFT_SPOOF  = 0x00000003,
}
alias _PfFrameType = int;

// Callbacks

alias LPFIBER_START_ROUTINE = void function();
alias PFIBER_CALLOUT_ROUTINE = void* function(void* lpParameter);
alias PUMS_SCHEDULER_ENTRY_POINT = void function();
alias PGET_SYSTEM_WOW64_DIRECTORY_A = uint function(const(char)* lpBuffer, uint uSize);
alias PGET_SYSTEM_WOW64_DIRECTORY_W = uint function(const(wchar)* lpBuffer, uint uSize);
alias PQUERYACTCTXW_FUNC = BOOL function(uint dwFlags, HANDLE hActCtx, void* pvSubInstance, uint ulInfoClass, 
                                         char* pvBuffer, size_t cbBuffer, size_t* pcbWrittenOrRequired);
alias APPLICATION_RECOVERY_CALLBACK = uint function(void* pvParameter);
alias QUERYHANDLER = uint function(void* keycontext, val_context* val_list, uint num_vals, void* outputbuffer, 
                                   uint* total_outlen, uint input_blen);
alias PQUERYHANDLER = uint function();
alias PPS_POST_PROCESS_INIT_ROUTINE = void function();
alias PIO_APC_ROUTINE = void function(void* ApcContext, IO_STATUS_BLOCK* IoStatusBlock, uint Reserved);
alias PWINSTATIONQUERYINFORMATIONW = ubyte function(HANDLE param0, uint param1, WINSTATIONINFOCLASS param2, 
                                                    void* param3, uint param4, uint* param5);
alias AVRF_RESOURCE_ENUMERATE_CALLBACK = uint function(void* ResourceDescription, void* EnumerationContext, 
                                                       uint* EnumerationLevel);
alias AVRF_HEAPALLOCATION_ENUMERATE_CALLBACK = uint function(AVRF_HEAP_ALLOCATION* HeapAllocation, 
                                                             void* EnumerationContext, uint* EnumerationLevel);
alias AVRF_HANDLEOPERATION_ENUMERATE_CALLBACK = uint function(AVRF_HANDLE_OPERATION* HandleOperation, 
                                                              void* EnumerationContext, uint* EnumerationLevel);
alias PFNFCIALLOC = void* function(uint cb);
alias PFNFCIFREE = void function(void* memory);
alias PFNFCIOPEN = ptrdiff_t function(const(char)* pszFile, int oflag, int pmode, int* err, void* pv);
alias PFNFCIREAD = uint function(ptrdiff_t hf, void* memory, uint cb, int* err, void* pv);
alias PFNFCIWRITE = uint function(ptrdiff_t hf, void* memory, uint cb, int* err, void* pv);
alias PFNFCICLOSE = int function(ptrdiff_t hf, int* err, void* pv);
alias PFNFCISEEK = int function(ptrdiff_t hf, int dist, int seektype, int* err, void* pv);
alias PFNFCIDELETE = int function(const(char)* pszFile, int* err, void* pv);
alias PFNFCIGETNEXTCABINET = BOOL function(CCAB* pccab, uint cbPrevCab, void* pv);
alias PFNFCIFILEPLACED = int function(CCAB* pccab, const(char)* pszFile, int cbFile, BOOL fContinuation, void* pv);
alias PFNFCIGETOPENINFO = ptrdiff_t function(const(char)* pszName, ushort* pdate, ushort* ptime, ushort* pattribs, 
                                             int* err, void* pv);
alias PFNFCISTATUS = int function(uint typeStatus, uint cb1, uint cb2, void* pv);
alias PFNFCIGETTEMPFILE = BOOL function(char* pszTempName, int cbTempName, void* pv);
alias PFNALLOC = void* function(uint cb);
alias PFNFREE = void function(void* pv);
alias PFNOPEN = ptrdiff_t function(const(char)* pszFile, int oflag, int pmode);
alias PFNREAD = uint function(ptrdiff_t hf, char* pv, uint cb);
alias PFNWRITE = uint function(ptrdiff_t hf, char* pv, uint cb);
alias PFNCLOSE = int function(ptrdiff_t hf);
alias PFNSEEK = int function(ptrdiff_t hf, int dist, int seektype);
alias PFNFDIDECRYPT = int function(FDIDECRYPT* pfdid);
alias PFNFDINOTIFY = ptrdiff_t function(FDINOTIFICATIONTYPE fdint, FDINOTIFICATION* pfdin);
alias DEBUGEVENTPROC = uint function(DEBUG_EVENT* param0, void* param1);
alias PROCESSENUMPROC = BOOL function(uint dwProcessId, uint dwAttributes, LPARAM lpUserDefined);
alias TASKENUMPROC = BOOL function(uint dwThreadId, ushort hMod16, ushort hTask16, LPARAM lpUserDefined);
alias TASKENUMPROCEX = BOOL function(uint dwThreadId, ushort hMod16, ushort hTask16, byte* pszModName, 
                                     byte* pszFileName, LPARAM lpUserDefined);
alias VDMPROCESSEXCEPTIONPROC = BOOL function(DEBUG_EVENT* param0);
alias VDMGETTHREADSELECTORENTRYPROC = BOOL function(HANDLE param0, HANDLE param1, uint param2, LDT_ENTRY* param3);
alias VDMGETPOINTERPROC = uint function(HANDLE param0, HANDLE param1, ushort param2, uint param3, BOOL param4);
alias VDMGETCONTEXTPROC = BOOL function(HANDLE param0, HANDLE param1, CONTEXT* param2);
alias VDMSETCONTEXTPROC = BOOL function(HANDLE param0, HANDLE param1, CONTEXT* param2);
alias VDMKILLWOWPROC = BOOL function();
alias VDMDETECTWOWPROC = BOOL function();
alias VDMBREAKTHREADPROC = BOOL function(HANDLE param0);
alias VDMGETSELECTORMODULEPROC = BOOL function(HANDLE param0, HANDLE param1, ushort param2, uint* param3, 
                                               const(char)* param4, uint param5, const(char)* param6, uint param7);
alias VDMGETMODULESELECTORPROC = BOOL function(HANDLE param0, HANDLE param1, uint param2, const(char)* param3, 
                                               ushort* param4);
alias VDMMODULEFIRSTPROC = BOOL function(HANDLE param0, HANDLE param1, MODULEENTRY* param2, DEBUGEVENTPROC param3, 
                                         void* param4);
alias VDMMODULENEXTPROC = BOOL function(HANDLE param0, HANDLE param1, MODULEENTRY* param2, DEBUGEVENTPROC param3, 
                                        void* param4);
alias VDMGLOBALFIRSTPROC = BOOL function(HANDLE param0, HANDLE param1, GLOBALENTRY* param2, ushort param3, 
                                         DEBUGEVENTPROC param4, void* param5);
alias VDMGLOBALNEXTPROC = BOOL function(HANDLE param0, HANDLE param1, GLOBALENTRY* param2, ushort param3, 
                                        DEBUGEVENTPROC param4, void* param5);
alias VDMENUMPROCESSWOWPROC = int function(PROCESSENUMPROC param0, LPARAM param1);
alias VDMENUMTASKWOWPROC = int function(uint param0, TASKENUMPROC param1, LPARAM param2);
alias VDMENUMTASKWOWEXPROC = int function(uint param0, TASKENUMPROCEX param1, LPARAM param2);
alias VDMTERMINATETASKINWOWPROC = BOOL function(uint param0, ushort param1);
alias VDMSTARTTASKINWOWPROC = BOOL function(uint param0, const(char)* param1, ushort param2);
alias VDMGETDBGFLAGSPROC = uint function(HANDLE param0);
alias VDMSETDBGFLAGSPROC = BOOL function(HANDLE param0, uint param1);
alias VDMISMODULELOADEDPROC = BOOL function(const(char)* param0);
alias VDMGETSEGMENTINFOPROC = BOOL function(ushort param0, uint param1, BOOL param2, VDM_SEGINFO param3);
alias VDMGETSYMBOLPROC = BOOL function(const(char)* param0, ushort param1, uint param2, BOOL param3, BOOL param4, 
                                       const(char)* param5, uint* param6);
alias VDMGETADDREXPRESSIONPROC = BOOL function(const(char)* param0, const(char)* param1, ushort* param2, 
                                               uint* param3, ushort* param4);
alias FEATURE_STATE_CHANGE_CALLBACK = void function(void* context);
alias PFEATURE_STATE_CHANGE_CALLBACK = void function();
alias ENUM_CALLBACK = void function(DCISURFACEINFO* lpSurfaceInfo, void* lpContext);
alias WINWATCHNOTIFYPROC = void function(HWINWATCH__* hww, HWND hwnd, uint code, LPARAM lParam);
alias LPDD32BITDRIVERINIT = uint function(uint dwContext);
alias LPDDHEL_INIT = BOOL function(DDRAWI_DIRECTDRAW_GBL* param0, BOOL param1);
alias LPDDHAL_SETCOLORKEY = uint function(DDHAL_DRVSETCOLORKEYDATA* param0);
alias LPDDHAL_CANCREATESURFACE = uint function(DDHAL_CANCREATESURFACEDATA* param0);
alias LPDDHAL_WAITFORVERTICALBLANK = uint function(DDHAL_WAITFORVERTICALBLANKDATA* param0);
alias LPDDHAL_CREATESURFACE = uint function(DDHAL_CREATESURFACEDATA* param0);
alias LPDDHAL_DESTROYDRIVER = uint function(DDHAL_DESTROYDRIVERDATA* param0);
alias LPDDHAL_SETMODE = uint function(DDHAL_SETMODEDATA* param0);
alias LPDDHAL_CREATEPALETTE = uint function(DDHAL_CREATEPALETTEDATA* param0);
alias LPDDHAL_GETSCANLINE = uint function(DDHAL_GETSCANLINEDATA* param0);
alias LPDDHAL_SETEXCLUSIVEMODE = uint function(DDHAL_SETEXCLUSIVEMODEDATA* param0);
alias LPDDHAL_FLIPTOGDISURFACE = uint function(DDHAL_FLIPTOGDISURFACEDATA* param0);
alias LPDDHAL_GETDRIVERINFO = uint function(DDHAL_GETDRIVERINFODATA* param0);
alias LPDDHALPALCB_DESTROYPALETTE = uint function(DDHAL_DESTROYPALETTEDATA* param0);
alias LPDDHALPALCB_SETENTRIES = uint function(DDHAL_SETENTRIESDATA* param0);
alias LPDDHALSURFCB_LOCK = uint function(DDHAL_LOCKDATA* param0);
alias LPDDHALSURFCB_UNLOCK = uint function(DDHAL_UNLOCKDATA* param0);
alias LPDDHALSURFCB_BLT = uint function(DDHAL_BLTDATA* param0);
alias LPDDHALSURFCB_UPDATEOVERLAY = uint function(DDHAL_UPDATEOVERLAYDATA* param0);
alias LPDDHALSURFCB_SETOVERLAYPOSITION = uint function(DDHAL_SETOVERLAYPOSITIONDATA* param0);
alias LPDDHALSURFCB_SETPALETTE = uint function(DDHAL_SETPALETTEDATA* param0);
alias LPDDHALSURFCB_FLIP = uint function(DDHAL_FLIPDATA* param0);
alias LPDDHALSURFCB_DESTROYSURFACE = uint function(DDHAL_DESTROYSURFACEDATA* param0);
alias LPDDHALSURFCB_SETCLIPLIST = uint function(DDHAL_SETCLIPLISTDATA* param0);
alias LPDDHALSURFCB_ADDATTACHEDSURFACE = uint function(DDHAL_ADDATTACHEDSURFACEDATA* param0);
alias LPDDHALSURFCB_SETCOLORKEY = uint function(DDHAL_SETCOLORKEYDATA* param0);
alias LPDDHALSURFCB_GETBLTSTATUS = uint function(DDHAL_GETBLTSTATUSDATA* param0);
alias LPDDHALSURFCB_GETFLIPSTATUS = uint function(DDHAL_GETFLIPSTATUSDATA* param0);
alias LPDDHAL_GETAVAILDRIVERMEMORY = uint function(DDHAL_GETAVAILDRIVERMEMORYDATA* param0);
alias LPDDHAL_UPDATENONLOCALHEAP = uint function(DDHAL_UPDATENONLOCALHEAPDATA* param0);
alias LPDDHAL_GETHEAPALIGNMENT = uint function(DDHAL_GETHEAPALIGNMENTDATA* param0);
alias LPDDHAL_CREATESURFACEEX = uint function(DDHAL_CREATESURFACEEXDATA* param0);
alias LPDDHAL_GETDRIVERSTATE = uint function(DDHAL_GETDRIVERSTATEDATA* param0);
alias LPDDHAL_DESTROYDDLOCAL = uint function(DDHAL_DESTROYDDLOCALDATA* param0);
alias LPDDHALEXEBUFCB_CANCREATEEXEBUF = uint function(DDHAL_CANCREATESURFACEDATA* param0);
alias LPDDHALEXEBUFCB_CREATEEXEBUF = uint function(DDHAL_CREATESURFACEDATA* param0);
alias LPDDHALEXEBUFCB_DESTROYEXEBUF = uint function(DDHAL_DESTROYSURFACEDATA* param0);
alias LPDDHALEXEBUFCB_LOCKEXEBUF = uint function(DDHAL_LOCKDATA* param0);
alias LPDDHALEXEBUFCB_UNLOCKEXEBUF = uint function(DDHAL_UNLOCKDATA* param0);
alias LPDDHALVPORTCB_CANCREATEVIDEOPORT = uint function(DDHAL_CANCREATEVPORTDATA* param0);
alias LPDDHALVPORTCB_CREATEVIDEOPORT = uint function(DDHAL_CREATEVPORTDATA* param0);
alias LPDDHALVPORTCB_FLIP = uint function(DDHAL_FLIPVPORTDATA* param0);
alias LPDDHALVPORTCB_GETBANDWIDTH = uint function(DDHAL_GETVPORTBANDWIDTHDATA* param0);
alias LPDDHALVPORTCB_GETINPUTFORMATS = uint function(DDHAL_GETVPORTINPUTFORMATDATA* param0);
alias LPDDHALVPORTCB_GETOUTPUTFORMATS = uint function(DDHAL_GETVPORTOUTPUTFORMATDATA* param0);
alias LPDDHALVPORTCB_GETFIELD = uint function(DDHAL_GETVPORTFIELDDATA* param0);
alias LPDDHALVPORTCB_GETLINE = uint function(DDHAL_GETVPORTLINEDATA* param0);
alias LPDDHALVPORTCB_GETVPORTCONNECT = uint function(DDHAL_GETVPORTCONNECTDATA* param0);
alias LPDDHALVPORTCB_DESTROYVPORT = uint function(DDHAL_DESTROYVPORTDATA* param0);
alias LPDDHALVPORTCB_GETFLIPSTATUS = uint function(DDHAL_GETVPORTFLIPSTATUSDATA* param0);
alias LPDDHALVPORTCB_UPDATE = uint function(DDHAL_UPDATEVPORTDATA* param0);
alias LPDDHALVPORTCB_WAITFORSYNC = uint function(DDHAL_WAITFORVPORTSYNCDATA* param0);
alias LPDDHALVPORTCB_GETSIGNALSTATUS = uint function(DDHAL_GETVPORTSIGNALDATA* param0);
alias LPDDHALVPORTCB_COLORCONTROL = uint function(DDHAL_VPORTCOLORDATA* param0);
alias LPDDHALCOLORCB_COLORCONTROL = uint function(DDHAL_COLORCONTROLDATA* param0);
alias LPDDHALKERNELCB_SYNCSURFACE = uint function(DDHAL_SYNCSURFACEDATA* param0);
alias LPDDHALKERNELCB_SYNCVIDEOPORT = uint function(DDHAL_SYNCVIDEOPORTDATA* param0);
alias LPDDGAMMACALIBRATORPROC = HRESULT function(DDGAMMARAMP* param0, ubyte* param1);
alias LPDDHALMOCOMPCB_GETGUIDS = uint function(DDHAL_GETMOCOMPGUIDSDATA* param0);
alias LPDDHALMOCOMPCB_GETFORMATS = uint function(DDHAL_GETMOCOMPFORMATSDATA* param0);
alias LPDDHALMOCOMPCB_CREATE = uint function(DDHAL_CREATEMOCOMPDATA* param0);
alias LPDDHALMOCOMPCB_GETCOMPBUFFINFO = uint function(DDHAL_GETMOCOMPCOMPBUFFDATA* param0);
alias LPDDHALMOCOMPCB_GETINTERNALINFO = uint function(DDHAL_GETINTERNALMOCOMPDATA* param0);
alias LPDDHALMOCOMPCB_BEGINFRAME = uint function(DDHAL_BEGINMOCOMPFRAMEDATA* param0);
alias LPDDHALMOCOMPCB_ENDFRAME = uint function(DDHAL_ENDMOCOMPFRAMEDATA* param0);
alias LPDDHALMOCOMPCB_RENDER = uint function(DDHAL_RENDERMOCOMPDATA* param0);
alias LPDDHALMOCOMPCB_QUERYSTATUS = uint function(DDHAL_QUERYMOCOMPSTATUSDATA* param0);
alias LPDDHALMOCOMPCB_DESTROY = uint function(DDHAL_DESTROYMOCOMPDATA* param0);
alias LPDDHAL_SETINFO = BOOL function(DDHALINFO* lpDDHalInfo, BOOL reset);
alias LPDDHAL_VIDMEMALLOC = size_t function(DDRAWI_DIRECTDRAW_GBL* lpDD, int heap, uint dwWidth, uint dwHeight);
alias LPDDHAL_VIDMEMFREE = void function(DDRAWI_DIRECTDRAW_GBL* lpDD, int heap, size_t fpMem);
alias PFNCHECKCONNECTIONWIZARD = uint function(uint param0, uint* param1);
alias PFNSETSHELLNEXT = uint function(const(char)* param0);
alias REGINSTALLA = HRESULT function(ptrdiff_t hm, const(char)* pszSection, STRTABLEA* pstTable);
alias PFN_IO_COMPLETION = void function(FIO_CONTEXT* pContext, FH_OVERLAPPED* lpo, uint cb, 
                                        uint dwCompletionStatus);
alias FCACHE_CREATE_CALLBACK = HANDLE function(const(char)* lpstrName, void* lpvData, uint* cbFileSize, 
                                               uint* cbFileSizeHigh);
alias FCACHE_RICHCREATE_CALLBACK = HANDLE function(const(char)* lpstrName, void* lpvData, uint* cbFileSize, 
                                                   uint* cbFileSizeHigh, int* pfDidWeScanIt, int* pfIsStuffed, 
                                                   int* pfStoredWithDots, int* pfStoredWithTerminatingDot);
alias CACHE_KEY_COMPARE = int function(uint cbKey1, ubyte* lpbKey1, uint cbKey2, ubyte* lpbKey2);
alias CACHE_KEY_HASH = uint function(ubyte* lpbKey, uint cbKey);
alias CACHE_READ_CALLBACK = BOOL function(uint cb, ubyte* lpb, void* lpvContext);
alias CACHE_DESTROY_CALLBACK = void function(uint cb, ubyte* lpb);
alias CACHE_ACCESS_CHECK = BOOL function(void* pSecurityDescriptor, HANDLE hClientToken, uint dwDesiredAccess, 
                                         GENERIC_MAPPING* GenericMapping, PRIVILEGE_SET* PrivilegeSet, 
                                         uint* PrivilegeSetLength, uint* GrantedAccess, int* AccessStatus);
alias PWLDP_SETDYNAMICCODETRUST_API = HRESULT function(HANDLE hFileHandle);
alias PWLDP_ISDYNAMICCODEPOLICYENABLED_API = HRESULT function(int* pbEnabled);
alias PWLDP_QUERYDYNAMICODETRUST_API = HRESULT function(HANDLE fileHandle, char* baseImage, uint imageSize);
alias PWLDP_QUERYWINDOWSLOCKDOWNMODE_API = HRESULT function(WLDP_WINDOWS_LOCKDOWN_MODE* lockdownMode);
alias PWLDP_QUERYWINDOWSLOCKDOWNRESTRICTION_API = HRESULT function(WLDP_WINDOWS_LOCKDOWN_RESTRICTION* LockdownRestriction);
alias PWLDP_SETWINDOWSLOCKDOWNRESTRICTION_API = HRESULT function(WLDP_WINDOWS_LOCKDOWN_RESTRICTION LockdownRestriction);
alias PWLDP_WLDPISAPPAPPROVEDBYPOLICY_API = HRESULT function(const(wchar)* PackageFamilyName, ulong PackageVersion);
alias PDEV_QUERY_RESULT_CALLBACK = void function(HDEVQUERY__* hDevQuery, void* pContext, 
                                                 const(DEV_QUERY_RESULT_ACTION_DATA)* pActionData);

// Structs


struct NETLOGON_INFO_1
{
    uint netlog1_flags;
    uint netlog1_pdc_connection_status;
}

struct NETLOGON_INFO_2
{
    uint          netlog2_flags;
    uint          netlog2_pdc_connection_status;
    const(wchar)* netlog2_trusted_dc_name;
    uint          netlog2_tc_connection_status;
}

struct NETLOGON_INFO_3
{
    uint netlog3_flags;
    uint netlog3_logon_attempts;
    uint netlog3_reserved1;
    uint netlog3_reserved2;
    uint netlog3_reserved3;
    uint netlog3_reserved4;
    uint netlog3_reserved5;
}

struct NETLOGON_INFO_4
{
    const(wchar)* netlog4_trusted_dc_name;
    const(wchar)* netlog4_trusted_domain_name;
}

alias EventLogHandle = ptrdiff_t;

alias EventSourceHandle = ptrdiff_t;

alias HeapHandle = ptrdiff_t;

alias HKEY = ptrdiff_t;

struct OSVERSIONINFOA
{
    uint      dwOSVersionInfoSize;
    uint      dwMajorVersion;
    uint      dwMinorVersion;
    uint      dwBuildNumber;
    uint      dwPlatformId;
    byte[128] szCSDVersion;
}

struct OSVERSIONINFOW
{
    uint        dwOSVersionInfoSize;
    uint        dwMajorVersion;
    uint        dwMinorVersion;
    uint        dwBuildNumber;
    uint        dwPlatformId;
    ushort[128] szCSDVersion;
}

struct OSVERSIONINFOEXA
{
    uint      dwOSVersionInfoSize;
    uint      dwMajorVersion;
    uint      dwMinorVersion;
    uint      dwBuildNumber;
    uint      dwPlatformId;
    byte[128] szCSDVersion;
    ushort    wServicePackMajor;
    ushort    wServicePackMinor;
    ushort    wSuiteMask;
    ubyte     wProductType;
    ubyte     wReserved;
}

struct OSVERSIONINFOEXW
{
    uint        dwOSVersionInfoSize;
    uint        dwMajorVersion;
    uint        dwMinorVersion;
    uint        dwBuildNumber;
    uint        dwPlatformId;
    ushort[128] szCSDVersion;
    ushort      wServicePackMajor;
    ushort      wServicePackMinor;
    ushort      wSuiteMask;
    ubyte       wProductType;
    ubyte       wReserved;
}

struct FILETIME
{
    uint dwLowDateTime;
    uint dwHighDateTime;
}

struct STRING
{
    ushort       Length;
    ushort       MaximumLength;
    const(char)* Buffer;
}

struct SYSTEMTIME
{
    ushort wYear;
    ushort wMonth;
    ushort wDayOfWeek;
    ushort wDay;
    ushort wHour;
    ushort wMinute;
    ushort wSecond;
    ushort wMilliseconds;
}

struct UpdateAssessment
{
    UpdateAssessmentStatus status;
    UpdateImpactLevel impact;
    uint              daysOutOfDate;
}

struct OSUpdateAssessment
{
    BOOL             isEndOfSupport;
    UpdateAssessment assessmentForCurrent;
    UpdateAssessment assessmentForUpToDate;
    UpdateAssessmentStatus securityStatus;
    FILETIME         assessmentTime;
    FILETIME         releaseInfoTime;
    const(wchar)*    currentOSBuild;
    FILETIME         currentOSReleaseTime;
    const(wchar)*    upToDateOSBuild;
    FILETIME         upToDateOSReleaseTime;
}

struct _PROC_THREAD_ATTRIBUTE_LIST
{
}

struct SYSTEM_INFO
{
    union
    {
        uint dwOemId;
        struct
        {
            ushort wProcessorArchitecture;
            ushort wReserved;
        }
    }
    uint   dwPageSize;
    void*  lpMinimumApplicationAddress;
    void*  lpMaximumApplicationAddress;
    size_t dwActiveProcessorMask;
    uint   dwNumberOfProcessors;
    uint   dwProcessorType;
    uint   dwAllocationGranularity;
    ushort wProcessorLevel;
    ushort wProcessorRevision;
}

struct JIT_DEBUG_INFO
{
    uint  dwSize;
    uint  dwProcessorArchitecture;
    uint  dwThreadID;
    uint  dwReserved0;
    ulong lpExceptionAddress;
    ulong lpExceptionRecord;
    ulong lpContextRecord;
}

struct HW_PROFILE_INFOA
{
    uint     dwDockInfo;
    byte[39] szHwProfileGuid;
    byte[80] szHwProfileName;
}

struct HW_PROFILE_INFOW
{
    uint       dwDockInfo;
    ushort[39] szHwProfileGuid;
    ushort[80] szHwProfileName;
}

struct TIME_ZONE_INFORMATION
{
    int        Bias;
    ushort[32] StandardName;
    SYSTEMTIME StandardDate;
    int        StandardBias;
    ushort[32] DaylightName;
    SYSTEMTIME DaylightDate;
    int        DaylightBias;
}

struct DYNAMIC_TIME_ZONE_INFORMATION
{
    int         Bias;
    ushort[32]  StandardName;
    SYSTEMTIME  StandardDate;
    int         StandardBias;
    ushort[32]  DaylightName;
    SYSTEMTIME  DaylightDate;
    int         DaylightBias;
    ushort[128] TimeZoneKeyName;
    ubyte       DynamicDaylightTimeDisabled;
}

struct ACTCTX_SECTION_KEYED_DATA_2600
{
    uint   cbSize;
    uint   ulDataFormatVersion;
    void*  lpData;
    uint   ulLength;
    void*  lpSectionGlobalData;
    uint   ulSectionGlobalDataLength;
    void*  lpSectionBase;
    uint   ulSectionTotalLength;
    HANDLE hActCtx;
    uint   ulAssemblyRosterIndex;
}

struct ACTCTX_SECTION_KEYED_DATA_ASSEMBLY_METADATA
{
    void* lpInformation;
    void* lpSectionBase;
    uint  ulSectionLength;
    void* lpSectionGlobalDataBase;
    uint  ulSectionGlobalDataLength;
}

struct ACTIVATION_CONTEXT_BASIC_INFORMATION
{
    HANDLE hActCtx;
    uint   dwFlags;
}

struct FILE_CASE_SENSITIVE_INFO
{
    uint Flags;
}

struct FILE_DISPOSITION_INFO_EX
{
    uint Flags;
}

struct val_context
{
    int   valuelen;
    void* value_context;
    void* val_buff_ptr;
}

struct pvalueA
{
    const(char)* pv_valuename;
    int          pv_valuelen;
    void*        pv_value_context;
    uint         pv_type;
}

struct pvalueW
{
    const(wchar)* pv_valuename;
    int           pv_valuelen;
    void*         pv_value_context;
    uint          pv_type;
}

struct provider_info
{
    PQUERYHANDLER pi_R0_1val;
    PQUERYHANDLER pi_R0_allvals;
    PQUERYHANDLER pi_R3_1val;
    PQUERYHANDLER pi_R3_allvals;
    uint          pi_flags;
    void*         pi_key_context;
}

struct VALENTA
{
    const(char)* ve_valuename;
    uint         ve_valuelen;
    size_t       ve_valueptr;
    uint         ve_type;
}

struct VALENTW
{
    const(wchar)* ve_valuename;
    uint          ve_valuelen;
    size_t        ve_valueptr;
    uint          ve_type;
}

struct XML_ERROR
{
    uint _nLine;
    BSTR _pchBuf;
    uint _cchBuf;
    uint _ich;
    BSTR _pszFound;
    BSTR _pszExpected;
    uint _reserved1;
    uint _reserved2;
}

struct CLIENT_ID
{
    HANDLE UniqueProcess;
    HANDLE UniqueThread;
}

struct LDR_DATA_TABLE_ENTRY
{
    void[2]*       Reserved1;
    LIST_ENTRY     InMemoryOrderLinks;
    void[2]*       Reserved2;
    void*          DllBase;
    void[2]*       Reserved3;
    UNICODE_STRING FullDllName;
    ubyte[8]       Reserved4;
    void[3]*       Reserved5;
    union
    {
        uint  CheckSum;
        void* Reserved6;
    }
    uint           TimeDateStamp;
}

struct OBJECT_ATTRIBUTES
{
    uint            Length;
    HANDLE          RootDirectory;
    UNICODE_STRING* ObjectName;
    uint            Attributes;
    void*           SecurityDescriptor;
    void*           SecurityQualityOfService;
}

struct IO_STATUS_BLOCK
{
    union
    {
        NTSTATUS Status;
        void*    Pointer;
    }
    size_t Information;
}

struct PROCESS_BASIC_INFORMATION
{
    void*    Reserved1;
    PEB*     PebBaseAddress;
    void[2]* Reserved2;
    size_t   UniqueProcessId;
    void*    Reserved3;
}

struct SYSTEM_PROCESSOR_PERFORMANCE_INFORMATION
{
    LARGE_INTEGER    IdleTime;
    LARGE_INTEGER    KernelTime;
    LARGE_INTEGER    UserTime;
    LARGE_INTEGER[2] Reserved1;
    uint             Reserved2;
}

struct SYSTEM_PROCESS_INFORMATION
{
    uint             NextEntryOffset;
    uint             NumberOfThreads;
    ubyte[48]        Reserved1;
    UNICODE_STRING   ImageName;
    int              BasePriority;
    HANDLE           UniqueProcessId;
    void*            Reserved2;
    uint             HandleCount;
    uint             SessionId;
    void*            Reserved3;
    size_t           PeakVirtualSize;
    size_t           VirtualSize;
    uint             Reserved4;
    size_t           PeakWorkingSetSize;
    size_t           WorkingSetSize;
    void*            Reserved5;
    size_t           QuotaPagedPoolUsage;
    void*            Reserved6;
    size_t           QuotaNonPagedPoolUsage;
    size_t           PagefileUsage;
    size_t           PeakPagefileUsage;
    size_t           PrivatePageCount;
    LARGE_INTEGER[6] Reserved7;
}

struct SYSTEM_THREAD_INFORMATION
{
    LARGE_INTEGER[3] Reserved1;
    uint             Reserved2;
    void*            StartAddress;
    CLIENT_ID        ClientId;
    int              Priority;
    int              BasePriority;
    uint             Reserved3;
    uint             ThreadState;
    uint             WaitReason;
}

struct SYSTEM_REGISTRY_QUOTA_INFORMATION
{
    uint  RegistryQuotaAllowed;
    uint  RegistryQuotaUsed;
    void* Reserved1;
}

struct SYSTEM_BASIC_INFORMATION
{
    ubyte[24] Reserved1;
    void[4]*  Reserved2;
    byte      NumberOfProcessors;
}

struct SYSTEM_TIMEOFDAY_INFORMATION
{
    ubyte[48] Reserved1;
}

struct SYSTEM_PERFORMANCE_INFORMATION
{
    ubyte[312] Reserved1;
}

struct SYSTEM_EXCEPTION_INFORMATION
{
    ubyte[16] Reserved1;
}

struct SYSTEM_LOOKASIDE_INFORMATION
{
    ubyte[32] Reserved1;
}

struct SYSTEM_INTERRUPT_INFORMATION
{
    ubyte[24] Reserved1;
}

struct SYSTEM_POLICY_INFORMATION
{
    void[2]* Reserved1;
    uint[3]  Reserved2;
}

struct SYSTEM_CODEINTEGRITY_INFORMATION
{
    uint Length;
    uint CodeIntegrityOptions;
}

struct PUBLIC_OBJECT_BASIC_INFORMATION
{
    uint     Attributes;
    uint     GrantedAccess;
    uint     HandleCount;
    uint     PointerCount;
    uint[10] Reserved;
}

struct __PUBLIC_OBJECT_TYPE_INFORMATION
{
    UNICODE_STRING TypeName;
    uint[22]       Reserved;
}

struct KEY_VALUE_ENTRY
{
    UNICODE_STRING* ValueName;
    uint            DataLength;
    uint            DataOffset;
    uint            Type;
}

struct WINSTATIONINFORMATIONW
{
    ubyte[70]   Reserved2;
    uint        LogonId;
    ubyte[1140] Reserved3;
}

struct AVRF_BACKTRACE_INFORMATION
{
    uint      Depth;
    uint      Index;
    ulong[32] ReturnAddresses;
}

struct AVRF_HEAP_ALLOCATION
{
    ulong HeapHandle;
    ulong UserAllocation;
    ulong UserAllocationSize;
    ulong Allocation;
    ulong AllocationSize;
    uint  UserAllocationState;
    uint  HeapState;
    ulong HeapContext;
    AVRF_BACKTRACE_INFORMATION* BackTraceInformation;
}

struct AVRF_HANDLE_OPERATION
{
    ulong Handle;
    uint  ProcessId;
    uint  ThreadId;
    uint  OperationType;
    uint  Spare0;
    AVRF_BACKTRACE_INFORMATION BackTraceInformation;
}

struct ERF
{
    int  erfOper;
    int  erfType;
    BOOL fError;
}

struct CCAB
{
    uint      cb;
    uint      cbFolderThresh;
    uint      cbReserveCFHeader;
    uint      cbReserveCFFolder;
    uint      cbReserveCFData;
    int       iCab;
    int       iDisk;
    int       fFailOnIncompressible;
    ushort    setID;
    byte[256] szDisk;
    byte[256] szCab;
    byte[256] szCabPath;
}

struct FDICABINETINFO
{
    int    cbCabinet;
    ushort cFolders;
    ushort cFiles;
    ushort setID;
    ushort iCabinet;
    BOOL   fReserve;
    BOOL   hasprev;
    BOOL   hasnext;
}

struct FDIDECRYPT
{
    FDIDECRYPTTYPE fdidt;
    void*          pvUser;
    union
    {
        struct cabinet
        {
            void*  pHeaderReserve;
            ushort cbHeaderReserve;
            ushort setID;
            int    iCabinet;
        }
        struct folder
        {
            void*  pFolderReserve;
            ushort cbFolderReserve;
            ushort iFolder;
        }
        struct decrypt
        {
            void*  pDataReserve;
            ushort cbDataReserve;
            void*  pbData;
            ushort cbData;
            BOOL   fSplit;
            ushort cbPartial;
        }
    }
}

struct FDINOTIFICATION
{
    int       cb;
    byte*     psz1;
    byte*     psz2;
    byte*     psz3;
    void*     pv;
    ptrdiff_t hf;
    ushort    date;
    ushort    time;
    ushort    attribs;
    ushort    setID;
    ushort    iCabinet;
    ushort    iFolder;
    FDIERROR  fdie;
}

struct FDISPILLFILE
{
align (1):
    byte[2] ach;
    int     cbFile;
}

struct VDMCONTEXT_WITHOUT_XSAVE
{
    uint               ContextFlags;
    uint               Dr0;
    uint               Dr1;
    uint               Dr2;
    uint               Dr3;
    uint               Dr6;
    uint               Dr7;
    FLOATING_SAVE_AREA FloatSave;
    uint               SegGs;
    uint               SegFs;
    uint               SegEs;
    uint               SegDs;
    uint               Edi;
    uint               Esi;
    uint               Ebx;
    uint               Edx;
    uint               Ecx;
    uint               Eax;
    uint               Ebp;
    uint               Eip;
    uint               SegCs;
    uint               EFlags;
    uint               Esp;
    uint               SegSs;
}

struct SEGMENT_NOTE
{
    ushort    Selector1;
    ushort    Selector2;
    ushort    Segment;
    byte[10]  Module;
    byte[256] FileName;
    ushort    Type;
    uint      Length;
}

struct IMAGE_NOTE
{
    byte[10]  Module;
    byte[256] FileName;
    ushort    hModule;
    ushort    hTask;
}

struct MODULEENTRY
{
    uint      dwSize;
    byte[10]  szModule;
    HANDLE    hModule;
    ushort    wcUsage;
    byte[256] szExePath;
    ushort    wNext;
}

struct TEMP_BP_NOTE
{
    ushort Seg;
    uint   Offset;
    BOOL   bPM;
}

struct VDM_SEGINFO
{
    ushort    Selector;
    ushort    SegNumber;
    uint      Length;
    ushort    Type;
    byte[9]   ModuleName;
    byte[255] FileName;
}

struct GLOBALENTRY
{
    uint   dwSize;
    uint   dwAddress;
    uint   dwBlockSize;
    HANDLE hBlock;
    ushort wcLock;
    ushort wcPageLock;
    ushort wFlags;
    BOOL   wHeapPresent;
    HANDLE hOwner;
    ushort wType;
    ushort wData;
    uint   dwNext;
    uint   dwNextAlt;
}

struct FEATURE_ERROR
{
    HRESULT      hr;
    ushort       lineNumber;
    const(char)* file;
    const(char)* process;
    const(char)* module_;
    uint         callerReturnAddressOffset;
    const(char)* callerModule;
    const(char)* message;
    ushort       originLineNumber;
    const(char)* originFile;
    const(char)* originModule;
    uint         originCallerReturnAddressOffset;
    const(char)* originCallerModule;
    const(char)* originName;
}

struct FEATURE_STATE_CHANGE_SUBSCRIPTION__
{
    int unused;
}

struct FH_SERVICE_PIPE_HANDLE__
{
    int unused;
}

struct DCICMD
{
    uint dwCommand;
    uint dwParam1;
    uint dwParam2;
    uint dwVersion;
    uint dwReserved;
}

struct DCICREATEINPUT
{
    DCICMD  cmd;
    uint    dwCompression;
    uint[3] dwMask;
    uint    dwWidth;
    uint    dwHeight;
    uint    dwDCICaps;
    uint    dwBitCount;
    void*   lpSurface;
}

struct DCISURFACEINFO
{
    uint      dwSize;
    uint      dwDCICaps;
    uint      dwCompression;
    uint[3]   dwMask;
    uint      dwWidth;
    uint      dwHeight;
    int       lStride;
    uint      dwBitCount;
    size_t    dwOffSurface;
    ushort    wSelSurface;
    ushort    wReserved;
    uint      dwReserved1;
    uint      dwReserved2;
    uint      dwReserved3;
    ptrdiff_t BeginAccess;
    ptrdiff_t EndAccess;
    ptrdiff_t DestroySurface;
}

struct DCIENUMINPUT
{
    DCICMD    cmd;
    RECT      rSrc;
    RECT      rDst;
    ptrdiff_t EnumCallback;
    void*     lpContext;
}

struct DCIOFFSCREEN
{
    DCISURFACEINFO dciInfo;
    ptrdiff_t      Draw;
    ptrdiff_t      SetClipList;
    ptrdiff_t      SetDestination;
}

struct DCIOVERLAY
{
    DCISURFACEINFO dciInfo;
    uint           dwChromakeyValue;
    uint           dwChromakeyMask;
}

struct HWINWATCH__
{
    int unused;
}

struct VMEML
{
    VMEML* next;
    size_t ptr;
    uint   size;
    BOOL   bDiscardable;
}

struct VMEMR
{
    VMEMR* next;
    VMEMR* prev;
    VMEMR* pUp;
    VMEMR* pDown;
    VMEMR* pLeft;
    VMEMR* pRight;
    size_t ptr;
    uint   size;
    uint   x;
    uint   y;
    uint   cx;
    uint   cy;
    uint   flags;
    size_t pBits;
    BOOL   bDiscardable;
}

struct PROCESS_LIST
{
    PROCESS_LIST* lpLink;
    uint          dwProcessId;
    uint          dwRefCnt;
    uint          dwAlphaDepth;
    uint          dwZDepth;
}

struct DDMONITORINFO
{
    ushort Manufacturer;
    ushort Product;
    uint   SerialNumber;
    GUID   DeviceIdentifier;
    int    Mode640x480;
    int    Mode800x600;
    int    Mode1024x768;
    int    Mode1280x1024;
    int    Mode1600x1200;
    int    ModeReserved1;
    int    ModeReserved2;
    int    ModeReserved3;
}

struct IDirectDrawClipperVtbl
{
}

struct IDirectDrawPaletteVtbl
{
}

struct IDirectDrawSurfaceVtbl
{
}

struct IDirectDrawSurface2Vtbl
{
}

struct IDirectDrawSurface3Vtbl
{
}

struct IDirectDrawSurface4Vtbl
{
}

struct IDirectDrawSurface7Vtbl
{
}

struct IDirectDrawColorControlVtbl
{
}

struct IDirectDrawVtbl
{
}

struct IDirectDraw2Vtbl
{
}

struct IDirectDraw4Vtbl
{
}

struct IDirectDraw7Vtbl
{
}

struct IDirectDrawKernelVtbl
{
}

struct IDirectDrawSurfaceKernelVtbl
{
}

struct IDirectDrawGammaControlVtbl
{
}

struct DD32BITDRIVERDATA
{
    byte[260] szName;
    byte[64]  szEntryPoint;
    uint      dwContext;
}

struct DDVERSIONDATA
{
    uint   dwHALVersion;
    size_t dwReserved1;
    size_t dwReserved2;
}

struct VIDMEM
{
    uint    dwFlags;
    size_t  fpStart;
    union
    {
        size_t fpEnd;
        uint   dwWidth;
    }
    DDSCAPS ddsCaps;
    DDSCAPS ddsCapsAlt;
    union
    {
        VMEMHEAP* lpHeap;
        uint      dwHeight;
    }
}

struct VIDMEMINFO
{
    size_t        fpPrimary;
    uint          dwFlags;
    uint          dwDisplayWidth;
    uint          dwDisplayHeight;
    int           lDisplayPitch;
    DDPIXELFORMAT ddpfDisplay;
    uint          dwOffscreenAlign;
    uint          dwOverlayAlign;
    uint          dwTextureAlign;
    uint          dwZBufferAlign;
    uint          dwAlphaAlign;
    uint          dwNumHeaps;
    VIDMEM*       pvmList;
}

struct HEAPALIAS
{
    size_t fpVidMem;
    void*  lpAlias;
    uint   dwAliasSize;
}

struct HEAPALIASINFO
{
    uint       dwRefCnt;
    uint       dwFlags;
    uint       dwNumHeaps;
    HEAPALIAS* lpAliases;
}

struct IUNKNOWN_LIST
{
    IUNKNOWN_LIST* lpLink;
    GUID*          lpGuid;
    IUnknown       lpIUnknown;
}

struct DDHAL_DDCALLBACKS
{
    uint                dwSize;
    uint                dwFlags;
    LPDDHAL_DESTROYDRIVER DestroyDriver;
    LPDDHAL_CREATESURFACE CreateSurface;
    LPDDHAL_SETCOLORKEY SetColorKey;
    LPDDHAL_SETMODE     SetMode;
    LPDDHAL_WAITFORVERTICALBLANK WaitForVerticalBlank;
    LPDDHAL_CANCREATESURFACE CanCreateSurface;
    LPDDHAL_CREATEPALETTE CreatePalette;
    LPDDHAL_GETSCANLINE GetScanLine;
    LPDDHAL_SETEXCLUSIVEMODE SetExclusiveMode;
    LPDDHAL_FLIPTOGDISURFACE FlipToGDISurface;
}

struct DDHAL_DDPALETTECALLBACKS
{
    uint dwSize;
    uint dwFlags;
    LPDDHALPALCB_DESTROYPALETTE DestroyPalette;
    LPDDHALPALCB_SETENTRIES SetEntries;
}

struct DDHAL_DDSURFACECALLBACKS
{
    uint                 dwSize;
    uint                 dwFlags;
    LPDDHALSURFCB_DESTROYSURFACE DestroySurface;
    LPDDHALSURFCB_FLIP   Flip;
    LPDDHALSURFCB_SETCLIPLIST SetClipList;
    LPDDHALSURFCB_LOCK   Lock;
    LPDDHALSURFCB_UNLOCK Unlock;
    LPDDHALSURFCB_BLT    Blt;
    LPDDHALSURFCB_SETCOLORKEY SetColorKey;
    LPDDHALSURFCB_ADDATTACHEDSURFACE AddAttachedSurface;
    LPDDHALSURFCB_GETBLTSTATUS GetBltStatus;
    LPDDHALSURFCB_GETFLIPSTATUS GetFlipStatus;
    LPDDHALSURFCB_UPDATEOVERLAY UpdateOverlay;
    LPDDHALSURFCB_SETOVERLAYPOSITION SetOverlayPosition;
    void*                reserved4;
    LPDDHALSURFCB_SETPALETTE SetPalette;
}

struct DDHAL_DDMISCELLANEOUSCALLBACKS
{
    uint dwSize;
    uint dwFlags;
    LPDDHAL_GETAVAILDRIVERMEMORY GetAvailDriverMemory;
    LPDDHAL_UPDATENONLOCALHEAP UpdateNonLocalHeap;
    LPDDHAL_GETHEAPALIGNMENT GetHeapAlignment;
    LPDDHALSURFCB_GETBLTSTATUS GetSysmemBltStatus;
}

struct DDHAL_DDMISCELLANEOUS2CALLBACKS
{
    uint  dwSize;
    uint  dwFlags;
    void* Reserved;
    LPDDHAL_CREATESURFACEEX CreateSurfaceEx;
    LPDDHAL_GETDRIVERSTATE GetDriverState;
    LPDDHAL_DESTROYDDLOCAL DestroyDDLocal;
}

struct DDHAL_DDEXEBUFCALLBACKS
{
    uint dwSize;
    uint dwFlags;
    LPDDHALEXEBUFCB_CANCREATEEXEBUF CanCreateExecuteBuffer;
    LPDDHALEXEBUFCB_CREATEEXEBUF CreateExecuteBuffer;
    LPDDHALEXEBUFCB_DESTROYEXEBUF DestroyExecuteBuffer;
    LPDDHALEXEBUFCB_LOCKEXEBUF LockExecuteBuffer;
    LPDDHALEXEBUFCB_UNLOCKEXEBUF UnlockExecuteBuffer;
}

struct DDHAL_DDVIDEOPORTCALLBACKS
{
    uint                dwSize;
    uint                dwFlags;
    LPDDHALVPORTCB_CANCREATEVIDEOPORT CanCreateVideoPort;
    LPDDHALVPORTCB_CREATEVIDEOPORT CreateVideoPort;
    LPDDHALVPORTCB_FLIP FlipVideoPort;
    LPDDHALVPORTCB_GETBANDWIDTH GetVideoPortBandwidth;
    LPDDHALVPORTCB_GETINPUTFORMATS GetVideoPortInputFormats;
    LPDDHALVPORTCB_GETOUTPUTFORMATS GetVideoPortOutputFormats;
    void*               lpReserved1;
    LPDDHALVPORTCB_GETFIELD GetVideoPortField;
    LPDDHALVPORTCB_GETLINE GetVideoPortLine;
    LPDDHALVPORTCB_GETVPORTCONNECT GetVideoPortConnectInfo;
    LPDDHALVPORTCB_DESTROYVPORT DestroyVideoPort;
    LPDDHALVPORTCB_GETFLIPSTATUS GetVideoPortFlipStatus;
    LPDDHALVPORTCB_UPDATE UpdateVideoPort;
    LPDDHALVPORTCB_WAITFORSYNC WaitForVideoPortSync;
    LPDDHALVPORTCB_GETSIGNALSTATUS GetVideoSignalStatus;
    LPDDHALVPORTCB_COLORCONTROL ColorControl;
}

struct DDHAL_DDCOLORCONTROLCALLBACKS
{
    uint dwSize;
    uint dwFlags;
    LPDDHALCOLORCB_COLORCONTROL ColorControl;
}

struct DDHAL_DDKERNELCALLBACKS
{
    uint dwSize;
    uint dwFlags;
    LPDDHALKERNELCB_SYNCSURFACE SyncSurfaceData;
    LPDDHALKERNELCB_SYNCVIDEOPORT SyncVideoPortData;
}

struct DDHAL_DDMOTIONCOMPCALLBACKS
{
    uint dwSize;
    uint dwFlags;
    LPDDHALMOCOMPCB_GETGUIDS GetMoCompGuids;
    LPDDHALMOCOMPCB_GETFORMATS GetMoCompFormats;
    LPDDHALMOCOMPCB_CREATE CreateMoComp;
    LPDDHALMOCOMPCB_GETCOMPBUFFINFO GetMoCompBuffInfo;
    LPDDHALMOCOMPCB_GETINTERNALINFO GetInternalMoCompInfo;
    LPDDHALMOCOMPCB_BEGINFRAME BeginMoCompFrame;
    LPDDHALMOCOMPCB_ENDFRAME EndMoCompFrame;
    LPDDHALMOCOMPCB_RENDER RenderMoComp;
    LPDDHALMOCOMPCB_QUERYSTATUS QueryMoCompStatus;
    LPDDHALMOCOMPCB_DESTROY DestroyMoComp;
}

struct DDNONLOCALVIDMEMCAPS
{
    uint    dwSize;
    uint    dwNLVBCaps;
    uint    dwNLVBCaps2;
    uint    dwNLVBCKeyCaps;
    uint    dwNLVBFXCaps;
    uint[8] dwNLVBRops;
}

struct DDMORESURFACECAPS
{
    uint      dwSize;
    DDSCAPSEX ddsCapsMore;
    struct ddsExtendedHeapRestrictions
    {
        DDSCAPSEX ddsCapsEx;
        DDSCAPSEX ddsCapsExAlt;
    }
}

struct DDSTEREOMODE
{
    uint dwSize;
    uint dwHeight;
    uint dwWidth;
    uint dwBpp;
    uint dwRefreshRate;
    BOOL bSupported;
}

struct DDRAWI_DDRAWPALETTE_INT
{
    void* lpVtbl;
    DDRAWI_DDRAWPALETTE_LCL* lpLcl;
    DDRAWI_DDRAWPALETTE_INT* lpLink;
    uint  dwIntRefCnt;
}

struct DDRAWI_DDRAWPALETTE_GBL
{
    uint          dwRefCnt;
    uint          dwFlags;
    DDRAWI_DIRECTDRAW_LCL* lpDD_lcl;
    uint          dwProcessId;
    PALETTEENTRY* lpColorTable;
    union
    {
        size_t   dwReserved1;
        HPALETTE hHELGDIPalette;
    }
    uint          dwDriverReserved;
    uint          dwContentsStamp;
    uint          dwSaveStamp;
    uint          dwHandle;
}

struct DDRAWI_DDRAWPALETTE_LCL
{
    uint     lpPalMore;
    DDRAWI_DDRAWPALETTE_GBL* lpGbl;
    size_t   dwUnused0;
    uint     dwLocalRefCnt;
    IUnknown pUnkOuter;
    DDRAWI_DIRECTDRAW_LCL* lpDD_lcl;
    size_t   dwReserved1;
    size_t   dwDDRAWReserved1;
    size_t   dwDDRAWReserved2;
    size_t   dwDDRAWReserved3;
}

struct DDRAWI_DDRAWCLIPPER_INT
{
    void* lpVtbl;
    DDRAWI_DDRAWCLIPPER_LCL* lpLcl;
    DDRAWI_DDRAWCLIPPER_INT* lpLink;
    uint  dwIntRefCnt;
}

struct DDRAWI_DDRAWCLIPPER_GBL
{
    uint     dwRefCnt;
    uint     dwFlags;
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    uint     dwProcessId;
    size_t   dwReserved1;
    size_t   hWnd;
    RGNDATA* lpStaticClipList;
}

struct DDRAWI_DDRAWCLIPPER_LCL
{
    uint     lpClipMore;
    DDRAWI_DDRAWCLIPPER_GBL* lpGbl;
    DDRAWI_DIRECTDRAW_LCL* lpDD_lcl;
    uint     dwLocalRefCnt;
    IUnknown pUnkOuter;
    DDRAWI_DIRECTDRAW_INT* lpDD_int;
    size_t   dwReserved1;
    IUnknown pAddrefedThisOwner;
}

struct ATTACHLIST
{
    uint        dwFlags;
    ATTACHLIST* lpLink;
    DDRAWI_DDRAWSURFACE_LCL* lpAttached;
    DDRAWI_DDRAWSURFACE_INT* lpIAttached;
}

struct DBLNODE
{
    DBLNODE* next;
    DBLNODE* prev;
    DDRAWI_DDRAWSURFACE_LCL* object;
    DDRAWI_DDRAWSURFACE_INT* object_int;
}

struct ACCESSRECTLIST
{
    ACCESSRECTLIST* lpLink;
    RECT            rDest;
    DDRAWI_DIRECTDRAW_LCL* lpOwner;
    void*           lpSurfaceData;
    uint            dwFlags;
    HEAPALIASINFO*  lpHeapAliasInfo;
}

struct DDRAWI_DDRAWSURFACE_INT
{
    void* lpVtbl;
    DDRAWI_DDRAWSURFACE_LCL* lpLcl;
    DDRAWI_DDRAWSURFACE_INT* lpLink;
    uint  dwIntRefCnt;
}

struct DDRAWI_DDRAWSURFACE_GBL
{
    uint          dwRefCnt;
    uint          dwGlobalFlags;
    union
    {
        ACCESSRECTLIST* lpRectList;
        uint            dwBlockSizeY;
        int             lSlicePitch;
    }
    union
    {
        VMEMHEAP* lpVidMemHeap;
        uint      dwBlockSizeX;
    }
    union
    {
        DDRAWI_DIRECTDRAW_GBL* lpDD;
        void* lpDDHandle;
    }
    size_t        fpVidMem;
    union
    {
        int  lPitch;
        uint dwLinearSize;
    }
    ushort        wHeight;
    ushort        wWidth;
    uint          dwUsageCount;
    size_t        dwReserved1;
    DDPIXELFORMAT ddpfSurface;
}

struct DDRAWI_DDRAWSURFACE_GBL_MORE
{
    uint            dwSize;
    union
    {
        uint   dwPhysicalPageTable;
        size_t fpPhysicalVidMem;
    }
    uint*           pPageTable;
    uint            cPages;
    size_t          dwSavedDCContext;
    size_t          fpAliasedVidMem;
    size_t          dwDriverReserved;
    size_t          dwHELReserved;
    uint            cPageUnlocks;
    size_t          hKernelSurface;
    uint            dwKernelRefCnt;
    DDCOLORCONTROL* lpColorInfo;
    size_t          fpNTAlias;
    uint            dwContentsStamp;
    void*           lpvUnswappedDriverReserved;
    void*           lpDDRAWReserved2;
    uint            dwDDRAWReserved1;
    uint            dwDDRAWReserved2;
    size_t          fpAliasOfVidMem;
}

struct DDRAWI_DDRAWSURFACE_MORE
{
    uint            dwSize;
    IUNKNOWN_LIST*  lpIUnknowns;
    DDRAWI_DIRECTDRAW_LCL* lpDD_lcl;
    uint            dwPageLockCount;
    uint            dwBytesAllocated;
    DDRAWI_DIRECTDRAW_INT* lpDD_int;
    uint            dwMipMapCount;
    DDRAWI_DDRAWCLIPPER_INT* lpDDIClipper;
    HEAPALIASINFO*  lpHeapAliasInfo;
    uint            dwOverlayFlags;
    void*           rgjunc;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    DDOVERLAYFX*    lpddOverlayFX;
    DDSCAPSEX       ddsCapsEx;
    uint            dwTextureStage;
    void*           lpDDRAWReserved;
    void*           lpDDRAWReserved2;
    void*           lpDDrawReserved3;
    uint            dwDDrawReserved4;
    void*           lpDDrawReserved5;
    uint*           lpGammaRamp;
    uint*           lpOriginalGammaRamp;
    void*           lpDDrawReserved6;
    uint            dwSurfaceHandle;
    uint[2]         qwDDrawReserved8;
    void*           lpDDrawReserved9;
    uint            cSurfaces;
    DDSURFACEDESC2* pCreatedDDSurfaceDesc2;
    DDRAWI_DDRAWSURFACE_LCL** slist;
    uint            dwFVF;
    void*           lpVB;
}

struct DDRAWI_DDRAWSURFACE_LCL
{
    DDRAWI_DDRAWSURFACE_MORE* lpSurfMore;
    DDRAWI_DDRAWSURFACE_GBL* lpGbl;
    size_t      hDDSurface;
    ATTACHLIST* lpAttachList;
    ATTACHLIST* lpAttachListFrom;
    uint        dwLocalRefCnt;
    uint        dwProcessId;
    uint        dwFlags;
    DDSCAPS     ddsCaps;
    union
    {
        DDRAWI_DDRAWPALETTE_INT* lpDDPalette;
        DDRAWI_DDRAWPALETTE_INT* lp16DDPalette;
    }
    union
    {
        DDRAWI_DDRAWCLIPPER_LCL* lpDDClipper;
        DDRAWI_DDRAWCLIPPER_INT* lp16DDClipper;
    }
    uint        dwModeCreatedIn;
    uint        dwBackBufferCount;
    DDCOLORKEY  ddckCKDestBlt;
    DDCOLORKEY  ddckCKSrcBlt;
    size_t      hDC;
    size_t      dwReserved1;
    DDCOLORKEY  ddckCKSrcOverlay;
    DDCOLORKEY  ddckCKDestOverlay;
    DDRAWI_DDRAWSURFACE_INT* lpSurfaceOverlaying;
    DBLNODE     dbnOverlayNode;
    RECT        rcOverlaySrc;
    RECT        rcOverlayDest;
    uint        dwClrXparent;
    uint        dwAlpha;
    int         lOverlayX;
    int         lOverlayY;
}

struct DDHALMODEINFO
{
    uint   dwWidth;
    uint   dwHeight;
    int    lPitch;
    uint   dwBPP;
    ushort wFlags;
    ushort wRefreshRate;
    uint   dwRBitMask;
    uint   dwGBitMask;
    uint   dwBBitMask;
    uint   dwAlphaBitMask;
}

struct DDRAWI_DIRECTDRAW_INT
{
    void* lpVtbl;
    DDRAWI_DIRECTDRAW_LCL* lpLcl;
    DDRAWI_DIRECTDRAW_INT* lpLink;
    uint  dwIntRefCnt;
}

struct DDHAL_CALLBACKS
{
    DDHAL_DDCALLBACKS cbDDCallbacks;
    DDHAL_DDSURFACECALLBACKS cbDDSurfaceCallbacks;
    DDHAL_DDPALETTECALLBACKS cbDDPaletteCallbacks;
    DDHAL_DDCALLBACKS HALDD;
    DDHAL_DDSURFACECALLBACKS HALDDSurface;
    DDHAL_DDPALETTECALLBACKS HALDDPalette;
    DDHAL_DDCALLBACKS HELDD;
    DDHAL_DDSURFACECALLBACKS HELDDSurface;
    DDHAL_DDPALETTECALLBACKS HELDDPalette;
    DDHAL_DDEXEBUFCALLBACKS cbDDExeBufCallbacks;
    DDHAL_DDEXEBUFCALLBACKS HALDDExeBuf;
    DDHAL_DDEXEBUFCALLBACKS HELDDExeBuf;
    DDHAL_DDVIDEOPORTCALLBACKS cbDDVideoPortCallbacks;
    DDHAL_DDVIDEOPORTCALLBACKS HALDDVideoPort;
    DDHAL_DDCOLORCONTROLCALLBACKS cbDDColorControlCallbacks;
    DDHAL_DDCOLORCONTROLCALLBACKS HALDDColorControl;
    DDHAL_DDMISCELLANEOUSCALLBACKS cbDDMiscellaneousCallbacks;
    DDHAL_DDMISCELLANEOUSCALLBACKS HALDDMiscellaneous;
    DDHAL_DDKERNELCALLBACKS cbDDKernelCallbacks;
    DDHAL_DDKERNELCALLBACKS HALDDKernel;
    DDHAL_DDMOTIONCOMPCALLBACKS cbDDMotionCompCallbacks;
    DDHAL_DDMOTIONCOMPCALLBACKS HALDDMotionComp;
}

struct DDRAWI_DIRECTDRAW_GBL
{
    uint             dwRefCnt;
    uint             dwFlags;
    size_t           fpPrimaryOrig;
    DDCORECAPS       ddCaps;
    uint             dwInternal1;
    uint[9]          dwUnused1;
    DDHAL_CALLBACKS* lpDDCBtmp;
    DDRAWI_DDRAWSURFACE_INT* dsList;
    DDRAWI_DDRAWPALETTE_INT* palList;
    DDRAWI_DDRAWCLIPPER_INT* clipperList;
    DDRAWI_DIRECTDRAW_GBL* lp16DD;
    uint             dwMaxOverlays;
    uint             dwCurrOverlays;
    uint             dwMonitorFrequency;
    DDCORECAPS       ddHELCaps;
    uint[50]         dwUnused2;
    DDCOLORKEY       ddckCKDestOverlay;
    DDCOLORKEY       ddckCKSrcOverlay;
    VIDMEMINFO       vmiData;
    void*            lpDriverHandle;
    DDRAWI_DIRECTDRAW_LCL* lpExclusiveOwner;
    uint             dwModeIndex;
    uint             dwModeIndexOrig;
    uint             dwNumFourCC;
    uint*            lpdwFourCC;
    uint             dwNumModes;
    DDHALMODEINFO*   lpModeInfo;
    PROCESS_LIST     plProcessList;
    uint             dwSurfaceLockCount;
    uint             dwAliasedLockCnt;
    size_t           dwReserved3;
    size_t           hDD;
    byte[12]         cObsolete;
    uint             dwReserved1;
    uint             dwReserved2;
    DBLNODE          dbnOverlayRoot;
    ushort*          lpwPDeviceFlags;
    uint             dwPDevice;
    uint             dwWin16LockCnt;
    uint             dwUnused3;
    uint             hInstance;
    uint             dwEvent16;
    uint             dwSaveNumModes;
    size_t           lpD3DGlobalDriverData;
    size_t           lpD3DHALCallbacks;
    DDCORECAPS       ddBothCaps;
    DDVIDEOPORTCAPS* lpDDVideoPortCaps;
    DDRAWI_DDVIDEOPORT_INT* dvpList;
    size_t           lpD3DHALCallbacks2;
    RECT             rectDevice;
    uint             cMonitors;
    void*            gpbmiSrc;
    void*            gpbmiDest;
    HEAPALIASINFO*   phaiHeapAliases;
    size_t           hKernelHandle;
    size_t           pfnNotifyProc;
    DDKERNELCAPS*    lpDDKernelCaps;
    DDNONLOCALVIDMEMCAPS* lpddNLVCaps;
    DDNONLOCALVIDMEMCAPS* lpddNLVHELCaps;
    DDNONLOCALVIDMEMCAPS* lpddNLVBothCaps;
    size_t           lpD3DExtendedCaps;
    uint             dwDOSBoxEvent;
    RECT             rectDesktop;
    byte[32]         cDriverName;
    size_t           lpD3DHALCallbacks3;
    uint             dwNumZPixelFormats;
    DDPIXELFORMAT*   lpZPixelFormats;
    DDRAWI_DDMOTIONCOMP_INT* mcList;
    uint             hDDVxd;
    DDSCAPSEX        ddsCapsMore;
}

struct DDRAWI_DIRECTDRAW_LCL
{
    uint             lpDDMore;
    DDRAWI_DIRECTDRAW_GBL* lpGbl;
    uint             dwUnused0;
    uint             dwLocalFlags;
    uint             dwLocalRefCnt;
    uint             dwProcessId;
    IUnknown         pUnkOuter;
    uint             dwObsolete1;
    size_t           hWnd;
    size_t           hDC;
    uint             dwErrorMode;
    DDRAWI_DDRAWSURFACE_INT* lpPrimary;
    DDRAWI_DDRAWSURFACE_INT* lpCB;
    uint             dwPreferredMode;
    HINSTANCE        hD3DInstance;
    IUnknown         pD3DIUnknown;
    DDHAL_CALLBACKS* lpDDCB;
    size_t           hDDVxd;
    uint             dwAppHackFlags;
    size_t           hFocusWnd;
    uint             dwHotTracking;
    uint             dwIMEState;
    size_t           hWndPopup;
    size_t           hDD;
    size_t           hGammaCalibrator;
    LPDDGAMMACALIBRATORPROC lpGammaCalibrator;
}

struct DDRAWI_DDVIDEOPORT_INT
{
    void* lpVtbl;
    DDRAWI_DDVIDEOPORT_LCL* lpLcl;
    DDRAWI_DDVIDEOPORT_INT* lpLink;
    uint  dwIntRefCnt;
    uint  dwFlags;
}

struct DDRAWI_DDVIDEOPORT_LCL
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDVIDEOPORTDESC  ddvpDesc;
    DDVIDEOPORTINFO  ddvpInfo;
    DDRAWI_DDRAWSURFACE_INT* lpSurface;
    DDRAWI_DDRAWSURFACE_INT* lpVBISurface;
    DDRAWI_DDRAWSURFACE_INT** lpFlipInts;
    uint             dwNumAutoflip;
    uint             dwProcessID;
    uint             dwStateFlags;
    uint             dwFlags;
    uint             dwRefCnt;
    size_t           fpLastFlip;
    size_t           dwReserved1;
    size_t           dwReserved2;
    HANDLE           hDDVideoPort;
    uint             dwNumVBIAutoflip;
    DDVIDEOPORTDESC* lpVBIDesc;
    DDVIDEOPORTDESC* lpVideoDesc;
    DDVIDEOPORTINFO* lpVBIInfo;
    DDVIDEOPORTINFO* lpVideoInfo;
    uint             dwVBIProcessID;
    DDRAWI_DDVIDEOPORT_INT* lpVPNotify;
}

struct DDRAWI_DDMOTIONCOMP_INT
{
    void* lpVtbl;
    DDRAWI_DDMOTIONCOMP_LCL* lpLcl;
    DDRAWI_DDMOTIONCOMP_INT* lpLink;
    uint  dwIntRefCnt;
}

struct DDRAWI_DDMOTIONCOMP_LCL
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    GUID          guid;
    uint          dwUncompWidth;
    uint          dwUncompHeight;
    DDPIXELFORMAT ddUncompPixelFormat;
    uint          dwInternalFlags;
    uint          dwRefCnt;
    uint          dwProcessId;
    HANDLE        hMoComp;
    uint          dwDriverReserved1;
    uint          dwDriverReserved2;
    uint          dwDriverReserved3;
    void*         lpDriverReserved1;
    void*         lpDriverReserved2;
    void*         lpDriverReserved3;
}

struct DDHALINFO
{
    uint               dwSize;
    DDHAL_DDCALLBACKS* lpDDCallbacks;
    DDHAL_DDSURFACECALLBACKS* lpDDSurfaceCallbacks;
    DDHAL_DDPALETTECALLBACKS* lpDDPaletteCallbacks;
    VIDMEMINFO         vmiData;
    DDCORECAPS         ddCaps;
    uint               dwMonitorFrequency;
    LPDDHAL_GETDRIVERINFO GetDriverInfo;
    uint               dwModeIndex;
    uint*              lpdwFourCC;
    uint               dwNumModes;
    DDHALMODEINFO*     lpModeInfo;
    uint               dwFlags;
    void*              lpPDevice;
    uint               hInstance;
    size_t             lpD3DGlobalDriverData;
    size_t             lpD3DHALCallbacks;
    DDHAL_DDEXEBUFCALLBACKS* lpDDExeBufCallbacks;
}

struct DDHALDDRAWFNS
{
    uint                dwSize;
    LPDDHAL_SETINFO     lpSetInfo;
    LPDDHAL_VIDMEMALLOC lpVidMemAlloc;
    LPDDHAL_VIDMEMFREE  lpVidMemFree;
}

struct DDHAL_BLTDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDDestSurface;
    RECTL             rDest;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSrcSurface;
    RECTL             rSrc;
    uint              dwFlags;
    uint              dwROPFlags;
    DDBLTFX           bltFX;
    HRESULT           ddRVal;
    LPDDHALSURFCB_BLT Blt;
    BOOL              IsClipped;
    RECTL             rOrigDest;
    RECTL             rOrigSrc;
    uint              dwRectCnt;
    RECT*             prDestRects;
}

struct DDHAL_LOCKDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSurface;
    uint               bHasRect;
    RECTL              rArea;
    void*              lpSurfData;
    HRESULT            ddRVal;
    LPDDHALSURFCB_LOCK Lock;
    uint               dwFlags;
}

struct DDHAL_UNLOCKDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSurface;
    HRESULT              ddRVal;
    LPDDHALSURFCB_UNLOCK Unlock;
}

struct DDHAL_UPDATEOVERLAYDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDDestSurface;
    RECTL       rDest;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSrcSurface;
    RECTL       rSrc;
    uint        dwFlags;
    DDOVERLAYFX overlayFX;
    HRESULT     ddRVal;
    LPDDHALSURFCB_UPDATEOVERLAY UpdateOverlay;
}

struct DDHAL_SETOVERLAYPOSITIONDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSrcSurface;
    DDRAWI_DDRAWSURFACE_LCL* lpDDDestSurface;
    int     lXPos;
    int     lYPos;
    HRESULT ddRVal;
    LPDDHALSURFCB_SETOVERLAYPOSITION SetOverlayPosition;
}

struct DDHAL_SETPALETTEDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSurface;
    DDRAWI_DDRAWPALETTE_GBL* lpDDPalette;
    HRESULT ddRVal;
    LPDDHALSURFCB_SETPALETTE SetPalette;
    BOOL    Attach;
}

struct DDHAL_FLIPDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpSurfCurr;
    DDRAWI_DDRAWSURFACE_LCL* lpSurfTarg;
    uint               dwFlags;
    HRESULT            ddRVal;
    LPDDHALSURFCB_FLIP Flip;
    DDRAWI_DDRAWSURFACE_LCL* lpSurfCurrLeft;
    DDRAWI_DDRAWSURFACE_LCL* lpSurfTargLeft;
}

struct DDHAL_DESTROYSURFACEDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSurface;
    HRESULT ddRVal;
    LPDDHALSURFCB_DESTROYSURFACE DestroySurface;
}

struct DDHAL_SETCLIPLISTDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSurface;
    HRESULT ddRVal;
    LPDDHALSURFCB_SETCLIPLIST SetClipList;
}

struct DDHAL_ADDATTACHEDSURFACEDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSurface;
    DDRAWI_DDRAWSURFACE_LCL* lpSurfAttached;
    HRESULT ddRVal;
    LPDDHALSURFCB_ADDATTACHEDSURFACE AddAttachedSurface;
}

struct DDHAL_SETCOLORKEYDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSurface;
    uint       dwFlags;
    DDCOLORKEY ckNew;
    HRESULT    ddRVal;
    LPDDHALSURFCB_SETCOLORKEY SetColorKey;
}

struct DDHAL_GETBLTSTATUSDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSurface;
    uint    dwFlags;
    HRESULT ddRVal;
    LPDDHALSURFCB_GETBLTSTATUS GetBltStatus;
}

struct DDHAL_GETFLIPSTATUSDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSurface;
    uint    dwFlags;
    HRESULT ddRVal;
    LPDDHALSURFCB_GETFLIPSTATUS GetFlipStatus;
}

struct DDHAL_DESTROYPALETTEDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWPALETTE_GBL* lpDDPalette;
    HRESULT ddRVal;
    LPDDHALPALCB_DESTROYPALETTE DestroyPalette;
}

struct DDHAL_SETENTRIESDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWPALETTE_GBL* lpDDPalette;
    uint          dwBase;
    uint          dwNumEntries;
    PALETTEENTRY* lpEntries;
    HRESULT       ddRVal;
    LPDDHALPALCB_SETENTRIES SetEntries;
}

struct DDHAL_CREATESURFACEDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDSURFACEDESC* lpDDSurfaceDesc;
    DDRAWI_DDRAWSURFACE_LCL** lplpSList;
    uint           dwSCnt;
    HRESULT        ddRVal;
    LPDDHAL_CREATESURFACE CreateSurface;
}

struct DDHAL_CANCREATESURFACEDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDSURFACEDESC* lpDDSurfaceDesc;
    uint           bIsDifferentPixelFormat;
    HRESULT        ddRVal;
    LPDDHAL_CANCREATESURFACE CanCreateSurface;
}

struct DDHAL_CREATEPALETTEDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWPALETTE_GBL* lpDDPalette;
    PALETTEENTRY* lpColorTable;
    HRESULT       ddRVal;
    LPDDHAL_CREATEPALETTE CreatePalette;
    BOOL          is_excl;
}

struct DDHAL_DESTROYDRIVERDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    HRESULT ddRVal;
    LPDDHAL_DESTROYDRIVER DestroyDriver;
}

struct DDHAL_SETMODEDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    uint            dwModeIndex;
    HRESULT         ddRVal;
    LPDDHAL_SETMODE SetMode;
    BOOL            inexcl;
    BOOL            useRefreshRate;
}

struct DDHAL_DRVSETCOLORKEYDATA
{
    DDRAWI_DDRAWSURFACE_LCL* lpDDSurface;
    uint                dwFlags;
    DDCOLORKEY          ckNew;
    HRESULT             ddRVal;
    LPDDHAL_SETCOLORKEY SetColorKey;
}

struct DDHAL_GETSCANLINEDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    uint                dwScanLine;
    HRESULT             ddRVal;
    LPDDHAL_GETSCANLINE GetScanLine;
}

struct DDHAL_SETEXCLUSIVEMODEDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    uint    dwEnterExcl;
    uint    dwReserved;
    HRESULT ddRVal;
    LPDDHAL_SETEXCLUSIVEMODE SetExclusiveMode;
}

struct DDHAL_FLIPTOGDISURFACEDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    uint    dwToGDI;
    uint    dwReserved;
    HRESULT ddRVal;
    LPDDHAL_FLIPTOGDISURFACE FlipToGDISurface;
}

struct DDHAL_CANCREATEVPORTDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDVIDEOPORTDESC* lpDDVideoPortDesc;
    HRESULT          ddRVal;
    LPDDHALVPORTCB_CANCREATEVIDEOPORT CanCreateVideoPort;
}

struct DDHAL_CREATEVPORTDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDVIDEOPORTDESC* lpDDVideoPortDesc;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    HRESULT          ddRVal;
    LPDDHALVPORTCB_CREATEVIDEOPORT CreateVideoPort;
}

struct DDHAL_FLIPVPORTDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    DDRAWI_DDRAWSURFACE_LCL* lpSurfCurr;
    DDRAWI_DDRAWSURFACE_LCL* lpSurfTarg;
    HRESULT             ddRVal;
    LPDDHALVPORTCB_FLIP FlipVideoPort;
}

struct DDHAL_GETVPORTBANDWIDTHDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    DDPIXELFORMAT* lpddpfFormat;
    uint           dwWidth;
    uint           dwHeight;
    uint           dwFlags;
    DDVIDEOPORTBANDWIDTH* lpBandwidth;
    HRESULT        ddRVal;
    LPDDHALVPORTCB_GETBANDWIDTH GetVideoPortBandwidth;
}

struct DDHAL_GETVPORTINPUTFORMATDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    uint           dwFlags;
    DDPIXELFORMAT* lpddpfFormat;
    uint           dwNumFormats;
    HRESULT        ddRVal;
    LPDDHALVPORTCB_GETINPUTFORMATS GetVideoPortInputFormats;
}

struct DDHAL_GETVPORTOUTPUTFORMATDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    uint           dwFlags;
    DDPIXELFORMAT* lpddpfInputFormat;
    DDPIXELFORMAT* lpddpfOutputFormats;
    uint           dwNumFormats;
    HRESULT        ddRVal;
    LPDDHALVPORTCB_GETOUTPUTFORMATS GetVideoPortOutputFormats;
}

struct DDHAL_GETVPORTFIELDDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    BOOL    bField;
    HRESULT ddRVal;
    LPDDHALVPORTCB_GETFIELD GetVideoPortField;
}

struct DDHAL_GETVPORTLINEDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    uint    dwLine;
    HRESULT ddRVal;
    LPDDHALVPORTCB_GETLINE GetVideoPortLine;
}

struct DDHAL_GETVPORTCONNECTDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    uint                dwPortId;
    DDVIDEOPORTCONNECT* lpConnect;
    uint                dwNumEntries;
    HRESULT             ddRVal;
    LPDDHALVPORTCB_GETVPORTCONNECT GetVideoPortConnectInfo;
}

struct DDHAL_DESTROYVPORTDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    HRESULT ddRVal;
    LPDDHALVPORTCB_DESTROYVPORT DestroyVideoPort;
}

struct DDHAL_GETVPORTFLIPSTATUSDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    size_t  fpSurface;
    HRESULT ddRVal;
    LPDDHALVPORTCB_GETFLIPSTATUS GetVideoPortFlipStatus;
}

struct DDHAL_UPDATEVPORTDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    DDRAWI_DDRAWSURFACE_INT** lplpDDSurface;
    DDRAWI_DDRAWSURFACE_INT** lplpDDVBISurface;
    DDVIDEOPORTINFO* lpVideoInfo;
    uint             dwFlags;
    uint             dwNumAutoflip;
    uint             dwNumVBIAutoflip;
    HRESULT          ddRVal;
    LPDDHALVPORTCB_UPDATE UpdateVideoPort;
}

struct DDHAL_WAITFORVPORTSYNCDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    uint    dwFlags;
    uint    dwLine;
    uint    dwTimeOut;
    HRESULT ddRVal;
    LPDDHALVPORTCB_WAITFORSYNC WaitForVideoPortSync;
}

struct DDHAL_GETVPORTSIGNALDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    uint    dwStatus;
    HRESULT ddRVal;
    LPDDHALVPORTCB_GETSIGNALSTATUS GetVideoSignalStatus;
}

struct DDHAL_VPORTCOLORDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    uint            dwFlags;
    DDCOLORCONTROL* lpColorData;
    HRESULT         ddRVal;
    LPDDHALVPORTCB_COLORCONTROL ColorControl;
}

struct DDHAL_COLORCONTROLDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSurface;
    DDCOLORCONTROL* lpColorData;
    uint            dwFlags;
    HRESULT         ddRVal;
    LPDDHALCOLORCB_COLORCONTROL ColorControl;
}

struct DDHAL_GETDRIVERINFODATA
{
    uint    dwSize;
    uint    dwFlags;
    GUID    guidInfo;
    uint    dwExpectedSize;
    void*   lpvData;
    uint    dwActualSize;
    HRESULT ddRVal;
    size_t  dwContext;
}

struct DDHAL_GETAVAILDRIVERMEMORYDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    DDSCAPS   DDSCaps;
    uint      dwTotal;
    uint      dwFree;
    HRESULT   ddRVal;
    LPDDHAL_GETAVAILDRIVERMEMORY GetAvailDriverMemory;
    DDSCAPSEX ddsCapsEx;
}

struct DDHAL_UPDATENONLOCALHEAPDATA
{
    DDRAWI_DIRECTDRAW_GBL* lpDD;
    uint    dwHeap;
    size_t  fpGARTLin;
    size_t  fpGARTDev;
    size_t  ulPolicyMaxBytes;
    HRESULT ddRVal;
    LPDDHAL_UPDATENONLOCALHEAP UpdateNonLocalHeap;
}

struct DDHAL_GETHEAPALIGNMENTDATA
{
    size_t        dwInstance;
    uint          dwHeap;
    HRESULT       ddRVal;
    LPDDHAL_GETHEAPALIGNMENT GetHeapAlignment;
    HEAPALIGNMENT Alignment;
}

struct DDHAL_CREATESURFACEEXDATA
{
    uint    dwFlags;
    DDRAWI_DIRECTDRAW_LCL* lpDDLcl;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSLcl;
    HRESULT ddRVal;
}

struct DDHAL_GETDRIVERSTATEDATA
{
    uint    dwFlags;
    union
    {
        size_t dwhContext;
    }
    uint*   lpdwStates;
    uint    dwLength;
    HRESULT ddRVal;
}

struct DDHAL_SYNCSURFACEDATA
{
    uint    dwSize;
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDRAWSURFACE_LCL* lpDDSurface;
    uint    dwSurfaceOffset;
    size_t  fpLockPtr;
    int     lPitch;
    uint    dwOverlayOffset;
    uint    dwOverlaySrcWidth;
    uint    dwOverlaySrcHeight;
    uint    dwOverlayDestWidth;
    uint    dwOverlayDestHeight;
    size_t  dwDriverReserved1;
    size_t  dwDriverReserved2;
    size_t  dwDriverReserved3;
    HRESULT ddRVal;
}

struct DDHAL_SYNCVIDEOPORTDATA
{
    uint    dwSize;
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDVIDEOPORT_LCL* lpVideoPort;
    uint    dwOriginOffset;
    uint    dwHeight;
    uint    dwVBIHeight;
    size_t  dwDriverReserved1;
    size_t  dwDriverReserved2;
    size_t  dwDriverReserved3;
    HRESULT ddRVal;
}

struct DDHAL_GETMOCOMPGUIDSDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    uint    dwNumGuids;
    GUID*   lpGuids;
    HRESULT ddRVal;
    LPDDHALMOCOMPCB_GETGUIDS GetMoCompGuids;
}

struct DDHAL_GETMOCOMPFORMATSDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    GUID*          lpGuid;
    uint           dwNumFormats;
    DDPIXELFORMAT* lpFormats;
    HRESULT        ddRVal;
    LPDDHALMOCOMPCB_GETFORMATS GetMoCompFormats;
}

struct DDHAL_CREATEMOCOMPDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDMOTIONCOMP_LCL* lpMoComp;
    GUID*         lpGuid;
    uint          dwUncompWidth;
    uint          dwUncompHeight;
    DDPIXELFORMAT ddUncompPixelFormat;
    void*         lpData;
    uint          dwDataSize;
    HRESULT       ddRVal;
    LPDDHALMOCOMPCB_CREATE CreateMoComp;
}

struct DDMCCOMPBUFFERINFO
{
    uint          dwSize;
    uint          dwNumCompBuffers;
    uint          dwWidthToCreate;
    uint          dwHeightToCreate;
    uint          dwBytesToAllocate;
    DDSCAPS2      ddCompCaps;
    DDPIXELFORMAT ddPixelFormat;
}

struct DDHAL_GETMOCOMPCOMPBUFFDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    GUID*               lpGuid;
    uint                dwWidth;
    uint                dwHeight;
    DDPIXELFORMAT       ddPixelFormat;
    uint                dwNumTypesCompBuffs;
    DDMCCOMPBUFFERINFO* lpCompBuffInfo;
    HRESULT             ddRVal;
    LPDDHALMOCOMPCB_GETCOMPBUFFINFO GetMoCompBuffInfo;
}

struct DDHAL_GETINTERNALMOCOMPDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    GUID*         lpGuid;
    uint          dwWidth;
    uint          dwHeight;
    DDPIXELFORMAT ddPixelFormat;
    uint          dwScratchMemAlloc;
    HRESULT       ddRVal;
    LPDDHALMOCOMPCB_GETINTERNALINFO GetInternalMoCompInfo;
}

struct DDHAL_BEGINMOCOMPFRAMEDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDMOTIONCOMP_LCL* lpMoComp;
    DDRAWI_DDRAWSURFACE_LCL* lpDestSurface;
    uint    dwInputDataSize;
    void*   lpInputData;
    uint    dwOutputDataSize;
    void*   lpOutputData;
    HRESULT ddRVal;
    LPDDHALMOCOMPCB_BEGINFRAME BeginMoCompFrame;
}

struct DDHAL_ENDMOCOMPFRAMEDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDMOTIONCOMP_LCL* lpMoComp;
    void*   lpInputData;
    uint    dwInputDataSize;
    HRESULT ddRVal;
    LPDDHALMOCOMPCB_ENDFRAME EndMoCompFrame;
}

struct DDMCBUFFERINFO
{
    uint  dwSize;
    DDRAWI_DDRAWSURFACE_LCL* lpCompSurface;
    uint  dwDataOffset;
    uint  dwDataSize;
    void* lpPrivate;
}

struct DDHAL_RENDERMOCOMPDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDMOTIONCOMP_LCL* lpMoComp;
    uint            dwNumBuffers;
    DDMCBUFFERINFO* lpBufferInfo;
    uint            dwFunction;
    void*           lpInputData;
    uint            dwInputDataSize;
    void*           lpOutputData;
    uint            dwOutputDataSize;
    HRESULT         ddRVal;
    LPDDHALMOCOMPCB_RENDER RenderMoComp;
}

struct DDHAL_QUERYMOCOMPSTATUSDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDMOTIONCOMP_LCL* lpMoComp;
    DDRAWI_DDRAWSURFACE_LCL* lpSurface;
    uint    dwFlags;
    HRESULT ddRVal;
    LPDDHALMOCOMPCB_QUERYSTATUS QueryMoCompStatus;
}

struct DDHAL_DESTROYMOCOMPDATA
{
    DDRAWI_DIRECTDRAW_LCL* lpDD;
    DDRAWI_DDMOTIONCOMP_LCL* lpMoComp;
    HRESULT ddRVal;
    LPDDHALMOCOMPCB_DESTROY DestroyMoComp;
}

struct _D3DHAL_CALLBACKS
{
}

struct _D3DHAL_GLOBALDRIVERDATA
{
}

struct STRENTRYA
{
    const(char)* pszName;
    const(char)* pszValue;
}

struct STRENTRYW
{
    const(wchar)* pszName;
    const(wchar)* pszValue;
}

struct STRTABLEA
{
    uint       cEntries;
    STRENTRYA* pse;
}

struct STRTABLEW
{
    uint       cEntries;
    STRENTRYW* pse;
}

struct _CabInfoA
{
    const(char)* pszCab;
    const(char)* pszInf;
    const(char)* pszSection;
    byte[260]    szSrcPath;
    uint         dwFlags;
}

struct _CabInfoW
{
    const(wchar)* pszCab;
    const(wchar)* pszInf;
    const(wchar)* pszSection;
    ushort[260]   szSrcPath;
    uint          dwFlags;
}

struct PERUSERSECTIONA
{
    byte[59]   szGUID;
    byte[128]  szDispName;
    byte[10]   szLocale;
    byte[1040] szStub;
    byte[32]   szVersion;
    byte[128]  szCompID;
    uint       dwIsInstalled;
    BOOL       bRollback;
}

struct PERUSERSECTIONW
{
    ushort[59]   szGUID;
    ushort[128]  szDispName;
    ushort[10]   szLocale;
    ushort[1040] szStub;
    ushort[32]   szVersion;
    ushort[128]  szCompID;
    uint         dwIsInstalled;
    BOOL         bRollback;
}

struct IMESTRUCT
{
    uint   fnc;
    WPARAM wParam;
    uint   wCount;
    uint   dchSource;
    uint   dchDest;
    LPARAM lParam1;
    LPARAM lParam2;
    LPARAM lParam3;
}

struct UNDETERMINESTRUCT
{
    uint dwSize;
    uint uDefIMESize;
    uint uDefIMEPos;
    uint uUndetTextLen;
    uint uUndetTextPos;
    uint uUndetAttrPos;
    uint uCursorPos;
    uint uDeltaStart;
    uint uDetermineTextLen;
    uint uDetermineTextPos;
    uint uDetermineDelimPos;
    uint uYomiTextLen;
    uint uYomiTextPos;
    uint uYomiDelimPos;
}

struct STRINGEXSTRUCT
{
    uint dwSize;
    uint uDeterminePos;
    uint uDetermineDelimPos;
    uint uYomiPos;
    uint uYomiDelimPos;
}

struct DATETIME
{
    ushort year;
    ushort month;
    ushort day;
    ushort hour;
    ushort min;
    ushort sec;
}

struct IMEPROA
{
    HWND      hWnd;
    DATETIME  InstDate;
    uint      wVersion;
    ubyte[50] szDescription;
    ubyte[80] szName;
    ubyte[30] szOptions;
}

struct IMEPROW
{
    HWND       hWnd;
    DATETIME   InstDate;
    uint       wVersion;
    ushort[50] szDescription;
    ushort[80] szName;
    ushort[30] szOptions;
}

struct JAVA_TRUST
{
    uint          cbSize;
    uint          flag;
    BOOL          fAllActiveXPermissions;
    BOOL          fAllPermissions;
    uint          dwEncodingType;
    ubyte*        pbJavaPermissions;
    uint          cbJavaPermissions;
    ubyte*        pbSigner;
    uint          cbSigner;
    const(wchar)* pwszZone;
    GUID          guidZone;
    HRESULT       hVerify;
}

struct IsolatedAppLauncherTelemetryParameters
{
    BOOL EnableForLaunch;
    GUID CorrelationGUID;
}

struct FH_OVERLAPPED
{
    size_t            Internal;
    size_t            InternalHigh;
    uint              Offset;
    uint              OffsetHigh;
    HANDLE            hEvent;
    PFN_IO_COMPLETION pfnCompletion;
    size_t            Reserved1;
    size_t            Reserved2;
    size_t            Reserved3;
    size_t            Reserved4;
}

struct FIO_CONTEXT
{
    uint   m_dwTempHack;
    uint   m_dwSignature;
    HANDLE m_hFile;
    uint   m_dwLinesOffset;
    uint   m_dwHeaderLength;
}

struct NAME_CACHE_CONTEXT
{
    uint m_dwSignature;
}

struct TDIEntityID
{
    uint tei_entity;
    uint tei_instance;
}

struct TDIObjectID
{
    TDIEntityID toi_entity;
    uint        toi_class;
    uint        toi_type;
    uint        toi_id;
}

struct tcp_request_query_information_ex_xp
{
    TDIObjectID ID;
    size_t[4]   Context;
}

struct tcp_request_query_information_ex_w2k
{
    TDIObjectID ID;
    ubyte[16]   Context;
}

struct tcp_request_set_information_ex
{
    TDIObjectID ID;
    uint        BufferSize;
    ubyte[1]    Buffer;
}

struct TDI_TL_IO_CONTROL_ENDPOINT
{
    TDI_TL_IO_CONTROL_TYPE Type;
    uint  Level;
    union
    {
        uint IoControlCode;
        uint OptionName;
    }
    void* InputBuffer;
    uint  InputBufferLength;
    void* OutputBuffer;
    uint  OutputBufferLength;
}

struct WLDP_HOST_INFORMATION
{
    uint          dwRevision;
    WLDP_HOST_ID  dwHostId;
    const(wchar)* szSource;
    HANDLE        hSource;
}

struct DEVPROP_FILTER_EXPRESSION
{
    DEVPROP_OPERATOR Operator;
    DEVPROPERTY      Property;
}

struct DEV_OBJECT
{
    DEV_OBJECT_TYPE     ObjectType;
    const(wchar)*       pszObjectId;
    uint                cPropertyCount;
    const(DEVPROPERTY)* pProperties;
}

struct DEV_QUERY_RESULT_ACTION_DATA
{
    DEV_QUERY_RESULT_ACTION Action;
    union Data
    {
        DEV_QUERY_STATE State;
        DEV_OBJECT      DeviceObject;
    }
}

struct DEV_QUERY_PARAMETER
{
    DEVPROPKEY Key;
    uint       Type;
    uint       BufferSize;
    void*      Buffer;
}

struct HDEVQUERY__
{
    int unused;
}

struct PF_FILTER_DESCRIPTOR
{
    uint          dwFilterFlags;
    uint          dwRule;
    _PfAddresType pfatType;
    ubyte*        SrcAddr;
    ubyte*        SrcMask;
    ubyte*        DstAddr;
    ubyte*        DstMask;
    uint          dwProtocol;
    uint          fLateBound;
    ushort        wSrcPort;
    ushort        wDstPort;
    ushort        wSrcPortHighRange;
    ushort        wDstPortHighRange;
}

struct PF_FILTER_STATS
{
    uint                 dwNumPacketsFiltered;
    PF_FILTER_DESCRIPTOR info;
}

struct PF_INTERFACE_STATS
{
    void*              pvDriverContext;
    uint               dwFlags;
    uint               dwInDrops;
    uint               dwOutDrops;
    _PfForwardAction   eaInAction;
    _PfForwardAction   eaOutAction;
    uint               dwNumInFilters;
    uint               dwNumOutFilters;
    uint               dwFrag;
    uint               dwSpoof;
    uint               dwReserved1;
    uint               dwReserved2;
    LARGE_INTEGER      liSYN;
    LARGE_INTEGER      liTotalLogged;
    uint               dwLostLogEntries;
    PF_FILTER_STATS[1] FilterInfo;
}

struct PF_LATEBIND_INFO
{
    ubyte* SrcAddr;
    ubyte* DstAddr;
    ubyte* Mask;
}

struct _pfLogFrame
{
    LARGE_INTEGER Timestamp;
    _PfFrameType  pfeTypeOfFrame;
    uint          dwTotalSizeUsed;
    uint          dwFilterRule;
    ushort        wSizeOfAdditionalData;
    ushort        wSizeOfIpHeader;
    uint          dwInterfaceName;
    uint          dwIPIndex;
    ubyte[1]      bPacketData;
}

// Functions

@DllImport("NETAPI32")
uint I_NetLogonControl2(const(wchar)* ServerName, uint FunctionCode, uint QueryLevel, char* Data, ubyte** Buffer);

@DllImport("KERNEL32")
void RtlRaiseException(EXCEPTION_RECORD* ExceptionRecord);

@DllImport("loadperf")
uint InstallPerfDllW(const(wchar)* szComputerName, const(wchar)* lpIniFile, size_t dwFlags);

@DllImport("loadperf")
uint InstallPerfDllA(const(char)* szComputerName, const(char)* lpIniFile, size_t dwFlags);

@DllImport("USER32")
void DisableProcessWindowsGhosting();

@DllImport("KERNEL32")
int CompareFileTime(const(FILETIME)* lpFileTime1, const(FILETIME)* lpFileTime2);

@DllImport("KERNEL32")
BOOL FileTimeToLocalFileTime(const(FILETIME)* lpFileTime, FILETIME* lpLocalFileTime);

@DllImport("KERNEL32")
BOOL GetFileTime(HANDLE hFile, FILETIME* lpCreationTime, FILETIME* lpLastAccessTime, FILETIME* lpLastWriteTime);

@DllImport("KERNEL32")
BOOL LocalFileTimeToFileTime(const(FILETIME)* lpLocalFileTime, FILETIME* lpFileTime);

@DllImport("KERNEL32")
BOOL SetFileTime(HANDLE hFile, const(FILETIME)* lpCreationTime, const(FILETIME)* lpLastAccessTime, 
                 const(FILETIME)* lpLastWriteTime);

@DllImport("KERNEL32")
uint GetSystemWow64DirectoryA(const(char)* lpBuffer, uint uSize);

@DllImport("KERNEL32")
uint GetSystemWow64DirectoryW(const(wchar)* lpBuffer, uint uSize);

@DllImport("api-ms-win-core-wow64-l1-1-1")
uint GetSystemWow64Directory2A(const(char)* lpBuffer, uint uSize, ushort ImageFileMachineType);

@DllImport("api-ms-win-core-wow64-l1-1-1")
uint GetSystemWow64Directory2W(const(wchar)* lpBuffer, uint uSize, ushort ImageFileMachineType);

@DllImport("KERNEL32")
HRESULT IsWow64GuestMachineSupported(ushort WowGuestMachine, int* MachineIsSupported);

@DllImport("RPCRT4")
ubyte* NdrSimpleStructMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
ubyte* NdrComplexStructMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
ubyte* NdrConformantArrayMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
ubyte* NdrComplexArrayMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
ubyte* NdrSimpleStructUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4")
ubyte* NdrComplexStructUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4")
ubyte* NdrComplexArrayUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4")
ubyte* NdrUserMarshalUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4")
void NdrSimpleStructBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrComplexStructBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrConformantArrayBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4")
void NdrComplexArrayBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("SspiCli")
ubyte GetUserNameExA(EXTENDED_NAME_FORMAT NameFormat, const(char)* lpNameBuffer, uint* nSize);

@DllImport("SspiCli")
ubyte GetUserNameExW(EXTENDED_NAME_FORMAT NameFormat, const(wchar)* lpNameBuffer, uint* nSize);

@DllImport("SECUR32")
ubyte GetComputerObjectNameA(EXTENDED_NAME_FORMAT NameFormat, const(char)* lpNameBuffer, uint* nSize);

@DllImport("SECUR32")
ubyte GetComputerObjectNameW(EXTENDED_NAME_FORMAT NameFormat, const(wchar)* lpNameBuffer, uint* nSize);

@DllImport("SECUR32")
ubyte TranslateNameA(const(char)* lpAccountName, EXTENDED_NAME_FORMAT AccountNameFormat, 
                     EXTENDED_NAME_FORMAT DesiredNameFormat, const(char)* lpTranslatedName, uint* nSize);

@DllImport("SECUR32")
ubyte TranslateNameW(const(wchar)* lpAccountName, EXTENDED_NAME_FORMAT AccountNameFormat, 
                     EXTENDED_NAME_FORMAT DesiredNameFormat, const(wchar)* lpTranslatedName, uint* nSize);

@DllImport("api-ms-win-core-apiquery-l2-1-0")
BOOL IsApiSetImplemented(const(char)* Contract);

@DllImport("KERNEL32")
BOOL SetEnvironmentStringsW(const(wchar)* NewEnvironment);

@DllImport("KERNEL32")
HANDLE GetStdHandle(STD_HANDLE_TYPE nStdHandle);

@DllImport("KERNEL32")
BOOL SetStdHandle(STD_HANDLE_TYPE nStdHandle, HANDLE hHandle);

@DllImport("KERNEL32")
BOOL SetStdHandleEx(STD_HANDLE_TYPE nStdHandle, HANDLE hHandle, ptrdiff_t* phPrevValue);

@DllImport("KERNEL32")
uint ExpandEnvironmentStringsA(const(char)* lpSrc, const(char)* lpDst, uint nSize);

@DllImport("KERNEL32")
uint ExpandEnvironmentStringsW(const(wchar)* lpSrc, const(wchar)* lpDst, uint nSize);

@DllImport("KERNEL32")
BOOL SetCurrentDirectoryA(const(char)* lpPathName);

@DllImport("KERNEL32")
BOOL SetCurrentDirectoryW(const(wchar)* lpPathName);

@DllImport("KERNEL32")
uint GetCurrentDirectoryA(uint nBufferLength, const(char)* lpBuffer);

@DllImport("KERNEL32")
uint GetCurrentDirectoryW(uint nBufferLength, const(wchar)* lpBuffer);

@DllImport("KERNEL32")
BOOL CloseHandle(HANDLE hObject);

@DllImport("KERNEL32")
BOOL DuplicateHandle(HANDLE hSourceProcessHandle, HANDLE hSourceHandle, HANDLE hTargetProcessHandle, 
                     ptrdiff_t* lpTargetHandle, uint dwDesiredAccess, BOOL bInheritHandle, 
                     DUPLICATE_HANDLE_OPTIONS dwOptions);

@DllImport("api-ms-win-core-handle-l1-1-0")
BOOL CompareObjectHandles(HANDLE hFirstObjectHandle, HANDLE hSecondObjectHandle);

@DllImport("KERNEL32")
BOOL GetHandleInformation(HANDLE hObject, uint* lpdwFlags);

@DllImport("KERNEL32")
BOOL SetHandleInformation(HANDLE hObject, uint dwMask, HANDLE_FLAG_OPTIONS dwFlags);

@DllImport("KERNEL32")
BOOL QueryPerformanceCounter(LARGE_INTEGER* lpPerformanceCount);

@DllImport("KERNEL32")
BOOL QueryPerformanceFrequency(LARGE_INTEGER* lpFrequency);

@DllImport("KERNEL32")
BOOL SetProcessDynamicEHContinuationTargets(HANDLE Process, ushort NumberOfTargets, char* Targets);

@DllImport("KERNEL32")
BOOL IsProcessorFeaturePresent(uint ProcessorFeature);

@DllImport("KERNEL32")
BOOL GetSystemTimes(FILETIME* lpIdleTime, FILETIME* lpKernelTime, FILETIME* lpUserTime);

@DllImport("KERNEL32")
BOOL GetSystemCpuSetInformation(char* Information, uint BufferLength, uint* ReturnedLength, HANDLE Process, 
                                uint Flags);

@DllImport("KERNEL32")
BOOL GetProcessDefaultCpuSets(HANDLE Process, char* CpuSetIds, uint CpuSetIdCount, uint* RequiredIdCount);

@DllImport("KERNEL32")
BOOL SetProcessDefaultCpuSets(HANDLE Process, char* CpuSetIds, uint CpuSetIdCount);

@DllImport("KERNEL32")
BOOL GetThreadSelectedCpuSets(HANDLE Thread, char* CpuSetIds, uint CpuSetIdCount, uint* RequiredIdCount);

@DllImport("KERNEL32")
BOOL SetThreadSelectedCpuSets(HANDLE Thread, char* CpuSetIds, uint CpuSetIdCount);

@DllImport("KERNEL32")
void GetSystemInfo(SYSTEM_INFO* lpSystemInfo);

@DllImport("KERNEL32")
void GetSystemTime(SYSTEMTIME* lpSystemTime);

@DllImport("KERNEL32")
void GetSystemTimeAsFileTime(FILETIME* lpSystemTimeAsFileTime);

@DllImport("KERNEL32")
void GetLocalTime(SYSTEMTIME* lpSystemTime);

@DllImport("KERNEL32")
BOOL IsUserCetAvailableInEnvironment(uint UserCetEnvironment);

@DllImport("KERNEL32")
BOOL GetSystemLeapSecondInformation(int* Enabled, uint* Flags);

@DllImport("KERNEL32")
uint GetVersion();

@DllImport("KERNEL32")
BOOL SetLocalTime(const(SYSTEMTIME)* lpSystemTime);

@DllImport("KERNEL32")
uint GetTickCount();

@DllImport("KERNEL32")
ulong GetTickCount64();

@DllImport("KERNEL32")
BOOL GetSystemTimeAdjustment(uint* lpTimeAdjustment, uint* lpTimeIncrement, int* lpTimeAdjustmentDisabled);

@DllImport("api-ms-win-core-sysinfo-l1-2-4")
BOOL GetSystemTimeAdjustmentPrecise(ulong* lpTimeAdjustment, ulong* lpTimeIncrement, int* lpTimeAdjustmentDisabled);

@DllImport("KERNEL32")
uint GetSystemDirectoryA(const(char)* lpBuffer, uint uSize);

@DllImport("KERNEL32")
uint GetSystemDirectoryW(const(wchar)* lpBuffer, uint uSize);

@DllImport("KERNEL32")
uint GetWindowsDirectoryA(const(char)* lpBuffer, uint uSize);

@DllImport("KERNEL32")
uint GetWindowsDirectoryW(const(wchar)* lpBuffer, uint uSize);

@DllImport("KERNEL32")
uint GetSystemWindowsDirectoryA(const(char)* lpBuffer, uint uSize);

@DllImport("KERNEL32")
uint GetSystemWindowsDirectoryW(const(wchar)* lpBuffer, uint uSize);

@DllImport("KERNEL32")
BOOL GetComputerNameExA(COMPUTER_NAME_FORMAT NameType, const(char)* lpBuffer, uint* nSize);

@DllImport("KERNEL32")
BOOL GetComputerNameExW(COMPUTER_NAME_FORMAT NameType, const(wchar)* lpBuffer, uint* nSize);

@DllImport("KERNEL32")
BOOL SetComputerNameExW(COMPUTER_NAME_FORMAT NameType, const(wchar)* lpBuffer);

@DllImport("KERNEL32")
BOOL SetSystemTime(const(SYSTEMTIME)* lpSystemTime);

@DllImport("KERNEL32")
BOOL GetVersionExA(OSVERSIONINFOA* lpVersionInformation);

@DllImport("KERNEL32")
BOOL GetVersionExW(OSVERSIONINFOW* lpVersionInformation);

@DllImport("KERNEL32")
void GetNativeSystemInfo(SYSTEM_INFO* lpSystemInfo);

@DllImport("KERNEL32")
void GetSystemTimePreciseAsFileTime(FILETIME* lpSystemTimeAsFileTime);

@DllImport("KERNEL32")
BOOL GetProductInfo(uint dwOSMajorVersion, uint dwOSMinorVersion, uint dwSpMajorVersion, uint dwSpMinorVersion, 
                    uint* pdwReturnedProductType);

@DllImport("KERNEL32")
ulong VerSetConditionMask(ulong ConditionMask, uint TypeMask, ubyte Condition);

@DllImport("api-ms-win-core-sysinfo-l1-2-0")
BOOL GetOsSafeBootMode(uint* Flags);

@DllImport("KERNEL32")
uint EnumSystemFirmwareTables(uint FirmwareTableProviderSignature, char* pFirmwareTableEnumBuffer, uint BufferSize);

@DllImport("KERNEL32")
uint GetSystemFirmwareTable(uint FirmwareTableProviderSignature, uint FirmwareTableID, char* pFirmwareTableBuffer, 
                            uint BufferSize);

@DllImport("KERNEL32")
BOOL DnsHostnameToComputerNameExW(const(wchar)* Hostname, const(wchar)* ComputerName, uint* nSize);

@DllImport("KERNEL32")
BOOL SetComputerNameEx2W(COMPUTER_NAME_FORMAT NameType, uint Flags, const(wchar)* lpBuffer);

@DllImport("KERNEL32")
BOOL SetSystemTimeAdjustment(uint dwTimeAdjustment, BOOL bTimeAdjustmentDisabled);

@DllImport("api-ms-win-core-sysinfo-l1-2-4")
BOOL SetSystemTimeAdjustmentPrecise(ulong dwTimeAdjustment, BOOL bTimeAdjustmentDisabled);

@DllImport("api-ms-win-core-sysinfo-l1-2-3")
BOOL GetOsManufacturingMode(int* pbEnabled);

@DllImport("api-ms-win-core-sysinfo-l1-2-3")
HRESULT GetIntegratedDisplaySize(double* sizeInInches);

@DllImport("KERNEL32")
BOOL SetComputerNameA(const(char)* lpComputerName);

@DllImport("KERNEL32")
BOOL SetComputerNameW(const(wchar)* lpComputerName);

@DllImport("KERNEL32")
BOOL SetComputerNameExA(COMPUTER_NAME_FORMAT NameType, const(char)* lpBuffer);

@DllImport("api-ms-win-core-realtime-l1-1-1")
void QueryInterruptTimePrecise(ulong* lpInterruptTimePrecise);

@DllImport("api-ms-win-core-realtime-l1-1-1")
void QueryUnbiasedInterruptTimePrecise(ulong* lpUnbiasedInterruptTimePrecise);

@DllImport("api-ms-win-core-realtime-l1-1-1")
void QueryInterruptTime(ulong* lpInterruptTime);

@DllImport("KERNEL32")
BOOL QueryUnbiasedInterruptTime(ulong* UnbiasedTime);

@DllImport("api-ms-win-core-realtime-l1-1-2")
HRESULT QueryAuxiliaryCounterFrequency(ulong* lpAuxiliaryCounterFrequency);

@DllImport("api-ms-win-core-realtime-l1-1-2")
HRESULT ConvertAuxiliaryCounterToPerformanceCounter(ulong ullAuxiliaryCounterValue, 
                                                    ulong* lpPerformanceCounterValue, ulong* lpConversionError);

@DllImport("api-ms-win-core-realtime-l1-1-2")
HRESULT ConvertPerformanceCounterToAuxiliaryCounter(ulong ullPerformanceCounterValue, 
                                                    ulong* lpAuxiliaryCounterValue, ulong* lpConversionError);

@DllImport("KERNEL32")
size_t GlobalCompact(uint dwMinFree);

@DllImport("KERNEL32")
void GlobalFix(ptrdiff_t hMem);

@DllImport("KERNEL32")
void GlobalUnfix(ptrdiff_t hMem);

@DllImport("KERNEL32")
void* GlobalWire(ptrdiff_t hMem);

@DllImport("KERNEL32")
BOOL GlobalUnWire(ptrdiff_t hMem);

@DllImport("KERNEL32")
size_t LocalShrink(ptrdiff_t hMem, uint cbNewSize);

@DllImport("KERNEL32")
size_t LocalCompact(uint uMinFree);

@DllImport("KERNEL32")
BOOL SetEnvironmentStringsA(const(char)* NewEnvironment);

@DllImport("KERNEL32")
uint SetHandleCount(uint uNumber);

@DllImport("KERNEL32")
BOOL RequestDeviceWakeup(HANDLE hDevice);

@DllImport("KERNEL32")
BOOL CancelDeviceWakeupRequest(HANDLE hDevice);

@DllImport("KERNEL32")
BOOL SetMessageWaitingIndicator(HANDLE hMsgIndicator, uint ulMsgCount);

@DllImport("KERNEL32")
int MulDiv(int nNumber, int nNumerator, int nDenominator);

@DllImport("KERNEL32")
BOOL GetSystemRegistryQuota(uint* pdwQuotaAllowed, uint* pdwQuotaUsed);

@DllImport("KERNEL32")
BOOL FileTimeToDosDateTime(const(FILETIME)* lpFileTime, ushort* lpFatDate, ushort* lpFatTime);

@DllImport("KERNEL32")
BOOL DosDateTimeToFileTime(ushort wFatDate, ushort wFatTime, FILETIME* lpFileTime);

@DllImport("KERNEL32")
int _lopen(const(char)* lpPathName, int iReadWrite);

@DllImport("KERNEL32")
int _lcreat(const(char)* lpPathName, int iAttribute);

@DllImport("KERNEL32")
uint _lread(int hFile, char* lpBuffer, uint uBytes);

@DllImport("KERNEL32")
uint _lwrite(int hFile, const(char)* lpBuffer, uint uBytes);

@DllImport("KERNEL32")
int _hread(int hFile, char* lpBuffer, int lBytes);

@DllImport("KERNEL32")
int _hwrite(int hFile, const(char)* lpBuffer, int lBytes);

@DllImport("KERNEL32")
int _lclose(int hFile);

@DllImport("KERNEL32")
int _llseek(int hFile, int lOffset, int iOrigin);

@DllImport("KERNEL32")
HANDLE OpenMutexA(uint dwDesiredAccess, BOOL bInheritHandle, const(char)* lpName);

@DllImport("KERNEL32")
HANDLE OpenSemaphoreA(uint dwDesiredAccess, BOOL bInheritHandle, const(char)* lpName);

@DllImport("KERNEL32")
HANDLE CreateWaitableTimerA(SECURITY_ATTRIBUTES* lpTimerAttributes, BOOL bManualReset, const(char)* lpTimerName);

@DllImport("KERNEL32")
HANDLE OpenWaitableTimerA(uint dwDesiredAccess, BOOL bInheritHandle, const(char)* lpTimerName);

@DllImport("KERNEL32")
HANDLE CreateWaitableTimerExA(SECURITY_ATTRIBUTES* lpTimerAttributes, const(char)* lpTimerName, uint dwFlags, 
                              uint dwDesiredAccess);

@DllImport("KERNEL32")
void GetStartupInfoA(STARTUPINFOA* lpStartupInfo);

@DllImport("KERNEL32")
uint GetFirmwareEnvironmentVariableA(const(char)* lpName, const(char)* lpGuid, char* pBuffer, uint nSize);

@DllImport("KERNEL32")
uint GetFirmwareEnvironmentVariableW(const(wchar)* lpName, const(wchar)* lpGuid, char* pBuffer, uint nSize);

@DllImport("KERNEL32")
uint GetFirmwareEnvironmentVariableExA(const(char)* lpName, const(char)* lpGuid, char* pBuffer, uint nSize, 
                                       uint* pdwAttribubutes);

@DllImport("KERNEL32")
uint GetFirmwareEnvironmentVariableExW(const(wchar)* lpName, const(wchar)* lpGuid, char* pBuffer, uint nSize, 
                                       uint* pdwAttribubutes);

@DllImport("KERNEL32")
BOOL SetFirmwareEnvironmentVariableA(const(char)* lpName, const(char)* lpGuid, char* pValue, uint nSize);

@DllImport("KERNEL32")
BOOL SetFirmwareEnvironmentVariableW(const(wchar)* lpName, const(wchar)* lpGuid, char* pValue, uint nSize);

@DllImport("KERNEL32")
BOOL SetFirmwareEnvironmentVariableExA(const(char)* lpName, const(char)* lpGuid, char* pValue, uint nSize, 
                                       uint dwAttributes);

@DllImport("KERNEL32")
BOOL SetFirmwareEnvironmentVariableExW(const(wchar)* lpName, const(wchar)* lpGuid, char* pValue, uint nSize, 
                                       uint dwAttributes);

@DllImport("KERNEL32")
BOOL GetFirmwareType(FIRMWARE_TYPE* FirmwareType);

@DllImport("KERNEL32")
BOOL IsNativeVhdBoot(int* NativeVhdBoot);

@DllImport("KERNEL32")
uint GetProfileIntA(const(char)* lpAppName, const(char)* lpKeyName, int nDefault);

@DllImport("KERNEL32")
uint GetProfileIntW(const(wchar)* lpAppName, const(wchar)* lpKeyName, int nDefault);

@DllImport("KERNEL32")
uint GetProfileStringA(const(char)* lpAppName, const(char)* lpKeyName, const(char)* lpDefault, 
                       const(char)* lpReturnedString, uint nSize);

@DllImport("KERNEL32")
uint GetProfileStringW(const(wchar)* lpAppName, const(wchar)* lpKeyName, const(wchar)* lpDefault, 
                       const(wchar)* lpReturnedString, uint nSize);

@DllImport("KERNEL32")
BOOL WriteProfileStringA(const(char)* lpAppName, const(char)* lpKeyName, const(char)* lpString);

@DllImport("KERNEL32")
BOOL WriteProfileStringW(const(wchar)* lpAppName, const(wchar)* lpKeyName, const(wchar)* lpString);

@DllImport("KERNEL32")
uint GetProfileSectionA(const(char)* lpAppName, const(char)* lpReturnedString, uint nSize);

@DllImport("KERNEL32")
uint GetProfileSectionW(const(wchar)* lpAppName, const(wchar)* lpReturnedString, uint nSize);

@DllImport("KERNEL32")
BOOL WriteProfileSectionA(const(char)* lpAppName, const(char)* lpString);

@DllImport("KERNEL32")
BOOL WriteProfileSectionW(const(wchar)* lpAppName, const(wchar)* lpString);

@DllImport("KERNEL32")
uint GetPrivateProfileIntA(const(char)* lpAppName, const(char)* lpKeyName, int nDefault, const(char)* lpFileName);

@DllImport("KERNEL32")
uint GetPrivateProfileIntW(const(wchar)* lpAppName, const(wchar)* lpKeyName, int nDefault, 
                           const(wchar)* lpFileName);

@DllImport("KERNEL32")
uint GetPrivateProfileStringA(const(char)* lpAppName, const(char)* lpKeyName, const(char)* lpDefault, 
                              const(char)* lpReturnedString, uint nSize, const(char)* lpFileName);

@DllImport("KERNEL32")
uint GetPrivateProfileStringW(const(wchar)* lpAppName, const(wchar)* lpKeyName, const(wchar)* lpDefault, 
                              const(wchar)* lpReturnedString, uint nSize, const(wchar)* lpFileName);

@DllImport("KERNEL32")
BOOL WritePrivateProfileStringA(const(char)* lpAppName, const(char)* lpKeyName, const(char)* lpString, 
                                const(char)* lpFileName);

@DllImport("KERNEL32")
BOOL WritePrivateProfileStringW(const(wchar)* lpAppName, const(wchar)* lpKeyName, const(wchar)* lpString, 
                                const(wchar)* lpFileName);

@DllImport("KERNEL32")
uint GetPrivateProfileSectionA(const(char)* lpAppName, const(char)* lpReturnedString, uint nSize, 
                               const(char)* lpFileName);

@DllImport("KERNEL32")
uint GetPrivateProfileSectionW(const(wchar)* lpAppName, const(wchar)* lpReturnedString, uint nSize, 
                               const(wchar)* lpFileName);

@DllImport("KERNEL32")
BOOL WritePrivateProfileSectionA(const(char)* lpAppName, const(char)* lpString, const(char)* lpFileName);

@DllImport("KERNEL32")
BOOL WritePrivateProfileSectionW(const(wchar)* lpAppName, const(wchar)* lpString, const(wchar)* lpFileName);

@DllImport("KERNEL32")
uint GetPrivateProfileSectionNamesA(const(char)* lpszReturnBuffer, uint nSize, const(char)* lpFileName);

@DllImport("KERNEL32")
uint GetPrivateProfileSectionNamesW(const(wchar)* lpszReturnBuffer, uint nSize, const(wchar)* lpFileName);

@DllImport("KERNEL32")
BOOL GetPrivateProfileStructA(const(char)* lpszSection, const(char)* lpszKey, char* lpStruct, uint uSizeStruct, 
                              const(char)* szFile);

@DllImport("KERNEL32")
BOOL GetPrivateProfileStructW(const(wchar)* lpszSection, const(wchar)* lpszKey, char* lpStruct, uint uSizeStruct, 
                              const(wchar)* szFile);

@DllImport("KERNEL32")
BOOL WritePrivateProfileStructA(const(char)* lpszSection, const(char)* lpszKey, char* lpStruct, uint uSizeStruct, 
                                const(char)* szFile);

@DllImport("KERNEL32")
BOOL WritePrivateProfileStructW(const(wchar)* lpszSection, const(wchar)* lpszKey, char* lpStruct, uint uSizeStruct, 
                                const(wchar)* szFile);

@DllImport("KERNEL32")
BOOL IsBadHugeReadPtr(const(void)* lp, size_t ucb);

@DllImport("KERNEL32")
BOOL IsBadHugeWritePtr(void* lp, size_t ucb);

@DllImport("KERNEL32")
BOOL GetComputerNameA(const(char)* lpBuffer, uint* nSize);

@DllImport("KERNEL32")
BOOL GetComputerNameW(const(wchar)* lpBuffer, uint* nSize);

@DllImport("KERNEL32")
BOOL DnsHostnameToComputerNameA(const(char)* Hostname, const(char)* ComputerName, uint* nSize);

@DllImport("KERNEL32")
BOOL DnsHostnameToComputerNameW(const(wchar)* Hostname, const(wchar)* ComputerName, uint* nSize);

@DllImport("ADVAPI32")
BOOL GetUserNameA(const(char)* lpBuffer, uint* pcbBuffer);

@DllImport("ADVAPI32")
BOOL GetUserNameW(const(wchar)* lpBuffer, uint* pcbBuffer);

@DllImport("ADVAPI32")
BOOL IsTokenUntrusted(HANDLE TokenHandle);

@DllImport("KERNEL32")
HANDLE SetTimerQueueTimer(HANDLE TimerQueue, WAITORTIMERCALLBACK Callback, void* Parameter, uint DueTime, 
                          uint Period, BOOL PreferIo);

@DllImport("KERNEL32")
BOOL CancelTimerQueueTimer(HANDLE TimerQueue, HANDLE Timer);

@DllImport("ADVAPI32")
BOOL GetCurrentHwProfileA(HW_PROFILE_INFOA* lpHwProfileInfo);

@DllImport("ADVAPI32")
BOOL GetCurrentHwProfileW(HW_PROFILE_INFOW* lpHwProfileInfo);

@DllImport("KERNEL32")
BOOL VerifyVersionInfoA(OSVERSIONINFOEXA* lpVersionInformation, uint dwTypeMask, ulong dwlConditionMask);

@DllImport("KERNEL32")
BOOL VerifyVersionInfoW(OSVERSIONINFOEXW* lpVersionInformation, uint dwTypeMask, ulong dwlConditionMask);

@DllImport("KERNEL32")
BOOL SystemTimeToTzSpecificLocalTime(const(TIME_ZONE_INFORMATION)* lpTimeZoneInformation, 
                                     const(SYSTEMTIME)* lpUniversalTime, SYSTEMTIME* lpLocalTime);

@DllImport("KERNEL32")
BOOL TzSpecificLocalTimeToSystemTime(const(TIME_ZONE_INFORMATION)* lpTimeZoneInformation, 
                                     const(SYSTEMTIME)* lpLocalTime, SYSTEMTIME* lpUniversalTime);

@DllImport("KERNEL32")
BOOL FileTimeToSystemTime(const(FILETIME)* lpFileTime, SYSTEMTIME* lpSystemTime);

@DllImport("KERNEL32")
BOOL SystemTimeToFileTime(const(SYSTEMTIME)* lpSystemTime, FILETIME* lpFileTime);

@DllImport("KERNEL32")
uint GetTimeZoneInformation(TIME_ZONE_INFORMATION* lpTimeZoneInformation);

@DllImport("KERNEL32")
BOOL SetTimeZoneInformation(const(TIME_ZONE_INFORMATION)* lpTimeZoneInformation);

@DllImport("KERNEL32")
BOOL SetDynamicTimeZoneInformation(const(DYNAMIC_TIME_ZONE_INFORMATION)* lpTimeZoneInformation);

@DllImport("KERNEL32")
uint GetDynamicTimeZoneInformation(DYNAMIC_TIME_ZONE_INFORMATION* pTimeZoneInformation);

@DllImport("KERNEL32")
BOOL GetTimeZoneInformationForYear(ushort wYear, DYNAMIC_TIME_ZONE_INFORMATION* pdtzi, TIME_ZONE_INFORMATION* ptzi);

@DllImport("ADVAPI32")
uint EnumDynamicTimeZoneInformation(const(uint) dwIndex, DYNAMIC_TIME_ZONE_INFORMATION* lpTimeZoneInformation);

@DllImport("ADVAPI32")
uint GetDynamicTimeZoneInformationEffectiveYears(const(DYNAMIC_TIME_ZONE_INFORMATION)* lpTimeZoneInformation, 
                                                 uint* FirstYear, uint* LastYear);

@DllImport("KERNEL32")
BOOL SystemTimeToTzSpecificLocalTimeEx(const(DYNAMIC_TIME_ZONE_INFORMATION)* lpTimeZoneInformation, 
                                       const(SYSTEMTIME)* lpUniversalTime, SYSTEMTIME* lpLocalTime);

@DllImport("KERNEL32")
BOOL TzSpecificLocalTimeToSystemTimeEx(const(DYNAMIC_TIME_ZONE_INFORMATION)* lpTimeZoneInformation, 
                                       const(SYSTEMTIME)* lpLocalTime, SYSTEMTIME* lpUniversalTime);

@DllImport("KERNEL32")
BOOL LocalFileTimeToLocalSystemTime(const(TIME_ZONE_INFORMATION)* timeZoneInformation, 
                                    const(FILETIME)* localFileTime, SYSTEMTIME* localSystemTime);

@DllImport("KERNEL32")
BOOL LocalSystemTimeToLocalFileTime(const(TIME_ZONE_INFORMATION)* timeZoneInformation, 
                                    const(SYSTEMTIME)* localSystemTime, FILETIME* localFileTime);

@DllImport("KERNEL32")
BOOL CreateJobSet(uint NumJob, char* UserJobSet, uint Flags);

@DllImport("KERNEL32")
BOOL ReplacePartitionUnit(const(wchar)* TargetPartition, const(wchar)* SparePartition, uint Flags);

@DllImport("KERNEL32")
BOOL InitializeContext2(char* Buffer, uint ContextFlags, CONTEXT** Context, uint* ContextLength, 
                        ulong XStateCompactionMask);

@DllImport("api-ms-win-core-backgroundtask-l1-1-0")
uint RaiseCustomSystemEventTrigger(CUSTOM_SYSTEM_EVENT_TRIGGER_CONFIG* CustomSystemEventTriggerConfig);

@DllImport("ADVAPI32")
LSTATUS RegCloseKey(HKEY hKey);

@DllImport("ADVAPI32")
LSTATUS RegOverridePredefKey(HKEY hKey, HKEY hNewHKey);

@DllImport("ADVAPI32")
LSTATUS RegOpenUserClassesRoot(HANDLE hToken, uint dwOptions, uint samDesired, HKEY* phkResult);

@DllImport("ADVAPI32")
LSTATUS RegOpenCurrentUser(uint samDesired, HKEY* phkResult);

@DllImport("ADVAPI32")
LSTATUS RegDisablePredefinedCache();

@DllImport("ADVAPI32")
LSTATUS RegDisablePredefinedCacheEx();

@DllImport("ADVAPI32")
LSTATUS RegConnectRegistryA(const(char)* lpMachineName, HKEY hKey, HKEY* phkResult);

@DllImport("ADVAPI32")
LSTATUS RegConnectRegistryW(const(wchar)* lpMachineName, HKEY hKey, HKEY* phkResult);

@DllImport("ADVAPI32")
LSTATUS RegConnectRegistryExA(const(char)* lpMachineName, HKEY hKey, uint Flags, HKEY* phkResult);

@DllImport("ADVAPI32")
LSTATUS RegConnectRegistryExW(const(wchar)* lpMachineName, HKEY hKey, uint Flags, HKEY* phkResult);

@DllImport("ADVAPI32")
LSTATUS RegCreateKeyA(HKEY hKey, const(char)* lpSubKey, HKEY* phkResult);

@DllImport("ADVAPI32")
LSTATUS RegCreateKeyW(HKEY hKey, const(wchar)* lpSubKey, HKEY* phkResult);

@DllImport("ADVAPI32")
LSTATUS RegCreateKeyExA(HKEY hKey, const(char)* lpSubKey, uint Reserved, const(char)* lpClass, uint dwOptions, 
                        uint samDesired, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes, HKEY* phkResult, 
                        uint* lpdwDisposition);

@DllImport("ADVAPI32")
LSTATUS RegCreateKeyExW(HKEY hKey, const(wchar)* lpSubKey, uint Reserved, const(wchar)* lpClass, uint dwOptions, 
                        uint samDesired, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes, HKEY* phkResult, 
                        uint* lpdwDisposition);

@DllImport("ADVAPI32")
LSTATUS RegCreateKeyTransactedA(HKEY hKey, const(char)* lpSubKey, uint Reserved, const(char)* lpClass, 
                                uint dwOptions, uint samDesired, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes, 
                                HKEY* phkResult, uint* lpdwDisposition, HANDLE hTransaction, 
                                void* pExtendedParemeter);

@DllImport("ADVAPI32")
LSTATUS RegCreateKeyTransactedW(HKEY hKey, const(wchar)* lpSubKey, uint Reserved, const(wchar)* lpClass, 
                                uint dwOptions, uint samDesired, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes, 
                                HKEY* phkResult, uint* lpdwDisposition, HANDLE hTransaction, 
                                void* pExtendedParemeter);

@DllImport("ADVAPI32")
LSTATUS RegDeleteKeyA(HKEY hKey, const(char)* lpSubKey);

@DllImport("ADVAPI32")
LSTATUS RegDeleteKeyW(HKEY hKey, const(wchar)* lpSubKey);

@DllImport("ADVAPI32")
LSTATUS RegDeleteKeyExA(HKEY hKey, const(char)* lpSubKey, uint samDesired, uint Reserved);

@DllImport("ADVAPI32")
LSTATUS RegDeleteKeyExW(HKEY hKey, const(wchar)* lpSubKey, uint samDesired, uint Reserved);

@DllImport("ADVAPI32")
LSTATUS RegDeleteKeyTransactedA(HKEY hKey, const(char)* lpSubKey, uint samDesired, uint Reserved, 
                                HANDLE hTransaction, void* pExtendedParameter);

@DllImport("ADVAPI32")
LSTATUS RegDeleteKeyTransactedW(HKEY hKey, const(wchar)* lpSubKey, uint samDesired, uint Reserved, 
                                HANDLE hTransaction, void* pExtendedParameter);

@DllImport("ADVAPI32")
int RegDisableReflectionKey(HKEY hBase);

@DllImport("ADVAPI32")
int RegEnableReflectionKey(HKEY hBase);

@DllImport("ADVAPI32")
int RegQueryReflectionKey(HKEY hBase, int* bIsReflectionDisabled);

@DllImport("ADVAPI32")
LSTATUS RegDeleteValueA(HKEY hKey, const(char)* lpValueName);

@DllImport("ADVAPI32")
LSTATUS RegDeleteValueW(HKEY hKey, const(wchar)* lpValueName);

@DllImport("ADVAPI32")
LSTATUS RegEnumKeyA(HKEY hKey, uint dwIndex, const(char)* lpName, uint cchName);

@DllImport("ADVAPI32")
LSTATUS RegEnumKeyW(HKEY hKey, uint dwIndex, const(wchar)* lpName, uint cchName);

@DllImport("ADVAPI32")
LSTATUS RegEnumKeyExA(HKEY hKey, uint dwIndex, const(char)* lpName, uint* lpcchName, uint* lpReserved, 
                      const(char)* lpClass, uint* lpcchClass, FILETIME* lpftLastWriteTime);

@DllImport("ADVAPI32")
LSTATUS RegEnumKeyExW(HKEY hKey, uint dwIndex, const(wchar)* lpName, uint* lpcchName, uint* lpReserved, 
                      const(wchar)* lpClass, uint* lpcchClass, FILETIME* lpftLastWriteTime);

@DllImport("ADVAPI32")
LSTATUS RegEnumValueA(HKEY hKey, uint dwIndex, const(char)* lpValueName, uint* lpcchValueName, uint* lpReserved, 
                      uint* lpType, char* lpData, uint* lpcbData);

@DllImport("ADVAPI32")
LSTATUS RegEnumValueW(HKEY hKey, uint dwIndex, const(wchar)* lpValueName, uint* lpcchValueName, uint* lpReserved, 
                      uint* lpType, char* lpData, uint* lpcbData);

@DllImport("ADVAPI32")
LSTATUS RegFlushKey(HKEY hKey);

@DllImport("ADVAPI32")
LSTATUS RegLoadKeyA(HKEY hKey, const(char)* lpSubKey, const(char)* lpFile);

@DllImport("ADVAPI32")
LSTATUS RegLoadKeyW(HKEY hKey, const(wchar)* lpSubKey, const(wchar)* lpFile);

@DllImport("ADVAPI32")
LSTATUS RegNotifyChangeKeyValue(HKEY hKey, BOOL bWatchSubtree, uint dwNotifyFilter, HANDLE hEvent, 
                                BOOL fAsynchronous);

@DllImport("ADVAPI32")
LSTATUS RegOpenKeyA(HKEY hKey, const(char)* lpSubKey, HKEY* phkResult);

@DllImport("ADVAPI32")
LSTATUS RegOpenKeyW(HKEY hKey, const(wchar)* lpSubKey, HKEY* phkResult);

@DllImport("ADVAPI32")
LSTATUS RegOpenKeyExA(HKEY hKey, const(char)* lpSubKey, uint ulOptions, uint samDesired, HKEY* phkResult);

@DllImport("ADVAPI32")
LSTATUS RegOpenKeyExW(HKEY hKey, const(wchar)* lpSubKey, uint ulOptions, uint samDesired, HKEY* phkResult);

@DllImport("ADVAPI32")
LSTATUS RegOpenKeyTransactedA(HKEY hKey, const(char)* lpSubKey, uint ulOptions, uint samDesired, HKEY* phkResult, 
                              HANDLE hTransaction, void* pExtendedParemeter);

@DllImport("ADVAPI32")
LSTATUS RegOpenKeyTransactedW(HKEY hKey, const(wchar)* lpSubKey, uint ulOptions, uint samDesired, HKEY* phkResult, 
                              HANDLE hTransaction, void* pExtendedParemeter);

@DllImport("ADVAPI32")
LSTATUS RegQueryInfoKeyA(HKEY hKey, const(char)* lpClass, uint* lpcchClass, uint* lpReserved, uint* lpcSubKeys, 
                         uint* lpcbMaxSubKeyLen, uint* lpcbMaxClassLen, uint* lpcValues, uint* lpcbMaxValueNameLen, 
                         uint* lpcbMaxValueLen, uint* lpcbSecurityDescriptor, FILETIME* lpftLastWriteTime);

@DllImport("ADVAPI32")
LSTATUS RegQueryInfoKeyW(HKEY hKey, const(wchar)* lpClass, uint* lpcchClass, uint* lpReserved, uint* lpcSubKeys, 
                         uint* lpcbMaxSubKeyLen, uint* lpcbMaxClassLen, uint* lpcValues, uint* lpcbMaxValueNameLen, 
                         uint* lpcbMaxValueLen, uint* lpcbSecurityDescriptor, FILETIME* lpftLastWriteTime);

@DllImport("ADVAPI32")
LSTATUS RegQueryValueA(HKEY hKey, const(char)* lpSubKey, const(char)* lpData, int* lpcbData);

@DllImport("ADVAPI32")
LSTATUS RegQueryValueW(HKEY hKey, const(wchar)* lpSubKey, const(wchar)* lpData, int* lpcbData);

@DllImport("ADVAPI32")
LSTATUS RegQueryMultipleValuesA(HKEY hKey, char* val_list, uint num_vals, const(char)* lpValueBuf, 
                                uint* ldwTotsize);

@DllImport("ADVAPI32")
LSTATUS RegQueryMultipleValuesW(HKEY hKey, char* val_list, uint num_vals, const(wchar)* lpValueBuf, 
                                uint* ldwTotsize);

@DllImport("ADVAPI32")
LSTATUS RegQueryValueExA(HKEY hKey, const(char)* lpValueName, uint* lpReserved, uint* lpType, char* lpData, 
                         uint* lpcbData);

@DllImport("ADVAPI32")
LSTATUS RegQueryValueExW(HKEY hKey, const(wchar)* lpValueName, uint* lpReserved, uint* lpType, char* lpData, 
                         uint* lpcbData);

@DllImport("ADVAPI32")
LSTATUS RegReplaceKeyA(HKEY hKey, const(char)* lpSubKey, const(char)* lpNewFile, const(char)* lpOldFile);

@DllImport("ADVAPI32")
LSTATUS RegReplaceKeyW(HKEY hKey, const(wchar)* lpSubKey, const(wchar)* lpNewFile, const(wchar)* lpOldFile);

@DllImport("ADVAPI32")
LSTATUS RegRestoreKeyA(HKEY hKey, const(char)* lpFile, uint dwFlags);

@DllImport("ADVAPI32")
LSTATUS RegRestoreKeyW(HKEY hKey, const(wchar)* lpFile, uint dwFlags);

@DllImport("ADVAPI32")
LSTATUS RegRenameKey(HKEY hKey, const(wchar)* lpSubKeyName, const(wchar)* lpNewKeyName);

@DllImport("ADVAPI32")
LSTATUS RegSaveKeyA(HKEY hKey, const(char)* lpFile, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes);

@DllImport("ADVAPI32")
LSTATUS RegSaveKeyW(HKEY hKey, const(wchar)* lpFile, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes);

@DllImport("ADVAPI32")
LSTATUS RegSetValueA(HKEY hKey, const(char)* lpSubKey, uint dwType, const(char)* lpData, uint cbData);

@DllImport("ADVAPI32")
LSTATUS RegSetValueW(HKEY hKey, const(wchar)* lpSubKey, uint dwType, const(wchar)* lpData, uint cbData);

@DllImport("ADVAPI32")
LSTATUS RegSetValueExA(HKEY hKey, const(char)* lpValueName, uint Reserved, uint dwType, char* lpData, uint cbData);

@DllImport("ADVAPI32")
LSTATUS RegSetValueExW(HKEY hKey, const(wchar)* lpValueName, uint Reserved, uint dwType, char* lpData, uint cbData);

@DllImport("ADVAPI32")
LSTATUS RegUnLoadKeyA(HKEY hKey, const(char)* lpSubKey);

@DllImport("ADVAPI32")
LSTATUS RegUnLoadKeyW(HKEY hKey, const(wchar)* lpSubKey);

@DllImport("ADVAPI32")
LSTATUS RegDeleteKeyValueA(HKEY hKey, const(char)* lpSubKey, const(char)* lpValueName);

@DllImport("ADVAPI32")
LSTATUS RegDeleteKeyValueW(HKEY hKey, const(wchar)* lpSubKey, const(wchar)* lpValueName);

@DllImport("ADVAPI32")
LSTATUS RegSetKeyValueA(HKEY hKey, const(char)* lpSubKey, const(char)* lpValueName, uint dwType, char* lpData, 
                        uint cbData);

@DllImport("ADVAPI32")
LSTATUS RegSetKeyValueW(HKEY hKey, const(wchar)* lpSubKey, const(wchar)* lpValueName, uint dwType, char* lpData, 
                        uint cbData);

@DllImport("ADVAPI32")
LSTATUS RegDeleteTreeA(HKEY hKey, const(char)* lpSubKey);

@DllImport("ADVAPI32")
LSTATUS RegDeleteTreeW(HKEY hKey, const(wchar)* lpSubKey);

@DllImport("ADVAPI32")
LSTATUS RegCopyTreeA(HKEY hKeySrc, const(char)* lpSubKey, HKEY hKeyDest);

@DllImport("ADVAPI32")
LSTATUS RegGetValueA(HKEY hkey, const(char)* lpSubKey, const(char)* lpValue, uint dwFlags, uint* pdwType, 
                     char* pvData, uint* pcbData);

@DllImport("ADVAPI32")
LSTATUS RegGetValueW(HKEY hkey, const(wchar)* lpSubKey, const(wchar)* lpValue, uint dwFlags, uint* pdwType, 
                     char* pvData, uint* pcbData);

@DllImport("ADVAPI32")
LSTATUS RegCopyTreeW(HKEY hKeySrc, const(wchar)* lpSubKey, HKEY hKeyDest);

@DllImport("ADVAPI32")
LSTATUS RegLoadMUIStringA(HKEY hKey, const(char)* pszValue, const(char)* pszOutBuf, uint cbOutBuf, uint* pcbData, 
                          uint Flags, const(char)* pszDirectory);

@DllImport("ADVAPI32")
LSTATUS RegLoadMUIStringW(HKEY hKey, const(wchar)* pszValue, const(wchar)* pszOutBuf, uint cbOutBuf, uint* pcbData, 
                          uint Flags, const(wchar)* pszDirectory);

@DllImport("ADVAPI32")
LSTATUS RegLoadAppKeyA(const(char)* lpFile, HKEY* phkResult, uint samDesired, uint dwOptions, uint Reserved);

@DllImport("ADVAPI32")
LSTATUS RegLoadAppKeyW(const(wchar)* lpFile, HKEY* phkResult, uint samDesired, uint dwOptions, uint Reserved);

@DllImport("ADVAPI32")
uint CheckForHiberboot(ubyte* pHiberboot, ubyte bClearFlag);

@DllImport("ADVAPI32")
LSTATUS RegSaveKeyExA(HKEY hKey, const(char)* lpFile, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes, uint Flags);

@DllImport("ADVAPI32")
LSTATUS RegSaveKeyExW(HKEY hKey, const(wchar)* lpFile, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes, 
                      uint Flags);

@DllImport("ntdll")
NTSTATUS NtClose(HANDLE Handle);

@DllImport("ntdll")
NTSTATUS NtCreateFile(ptrdiff_t* FileHandle, uint DesiredAccess, OBJECT_ATTRIBUTES* ObjectAttributes, 
                      IO_STATUS_BLOCK* IoStatusBlock, LARGE_INTEGER* AllocationSize, uint FileAttributes, 
                      uint ShareAccess, uint CreateDisposition, uint CreateOptions, void* EaBuffer, uint EaLength);

@DllImport("ntdll")
NTSTATUS NtOpenFile(ptrdiff_t* FileHandle, uint DesiredAccess, OBJECT_ATTRIBUTES* ObjectAttributes, 
                    IO_STATUS_BLOCK* IoStatusBlock, uint ShareAccess, uint OpenOptions);

@DllImport("ntdll")
NTSTATUS NtRenameKey(HANDLE KeyHandle, UNICODE_STRING* NewName);

@DllImport("ntdll")
NTSTATUS NtNotifyChangeMultipleKeys(HANDLE MasterKeyHandle, uint Count, char* SubordinateObjects, HANDLE Event, 
                                    PIO_APC_ROUTINE ApcRoutine, void* ApcContext, IO_STATUS_BLOCK* IoStatusBlock, 
                                    uint CompletionFilter, ubyte WatchTree, char* Buffer, uint BufferSize, 
                                    ubyte Asynchronous);

@DllImport("ntdll")
NTSTATUS NtQueryMultipleValueKey(HANDLE KeyHandle, char* ValueEntries, uint EntryCount, char* ValueBuffer, 
                                 uint* BufferLength, uint* RequiredBufferLength);

@DllImport("ntdll")
NTSTATUS NtSetInformationKey(HANDLE KeyHandle, KEY_SET_INFORMATION_CLASS KeySetInformationClass, 
                             char* KeySetInformation, uint KeySetInformationLength);

@DllImport("ntdll")
NTSTATUS NtDeviceIoControlFile(HANDLE FileHandle, HANDLE Event, PIO_APC_ROUTINE ApcRoutine, void* ApcContext, 
                               IO_STATUS_BLOCK* IoStatusBlock, uint IoControlCode, void* InputBuffer, 
                               uint InputBufferLength, void* OutputBuffer, uint OutputBufferLength);

@DllImport("ntdll")
NTSTATUS NtWaitForSingleObject(HANDLE Handle, ubyte Alertable, LARGE_INTEGER* Timeout);

@DllImport("ntdll")
ubyte RtlIsNameLegalDOS8Dot3(UNICODE_STRING* Name, STRING* OemName, ubyte* NameContainsSpaces);

@DllImport("ntdll")
NTSTATUS NtQueryObject(HANDLE Handle, OBJECT_INFORMATION_CLASS ObjectInformationClass, char* ObjectInformation, 
                       uint ObjectInformationLength, uint* ReturnLength);

@DllImport("ntdll")
NTSTATUS NtQuerySystemInformation(SYSTEM_INFORMATION_CLASS SystemInformationClass, void* SystemInformation, 
                                  uint SystemInformationLength, uint* ReturnLength);

@DllImport("ntdll")
NTSTATUS NtQuerySystemTime(LARGE_INTEGER* SystemTime);

@DllImport("ntdll")
NTSTATUS RtlLocalTimeToSystemTime(LARGE_INTEGER* LocalTime, LARGE_INTEGER* SystemTime);

@DllImport("ntdll")
ubyte RtlTimeToSecondsSince1970(LARGE_INTEGER* Time, uint* ElapsedSeconds);

@DllImport("ntdll")
void RtlFreeAnsiString(STRING* AnsiString);

@DllImport("ntdll")
void RtlFreeUnicodeString(UNICODE_STRING* UnicodeString);

@DllImport("ntdll")
void RtlFreeOemString(STRING* OemString);

@DllImport("ntdll")
void RtlInitString(STRING* DestinationString, byte* SourceString);

@DllImport("ntdll")
NTSTATUS RtlInitStringEx(STRING* DestinationString, byte* SourceString);

@DllImport("ntdll")
void RtlInitAnsiString(STRING* DestinationString, byte* SourceString);

@DllImport("ntdll")
NTSTATUS RtlInitAnsiStringEx(STRING* DestinationString, byte* SourceString);

@DllImport("ntdll")
void RtlInitUnicodeString(UNICODE_STRING* DestinationString, const(wchar)* SourceString);

@DllImport("ntdll")
NTSTATUS RtlAnsiStringToUnicodeString(UNICODE_STRING* DestinationString, STRING* SourceString, 
                                      ubyte AllocateDestinationString);

@DllImport("ntdll")
NTSTATUS RtlUnicodeStringToAnsiString(STRING* DestinationString, UNICODE_STRING* SourceString, 
                                      ubyte AllocateDestinationString);

@DllImport("ntdll")
NTSTATUS RtlUnicodeStringToOemString(STRING* DestinationString, UNICODE_STRING* SourceString, 
                                     ubyte AllocateDestinationString);

@DllImport("ntdll")
NTSTATUS RtlUnicodeToMultiByteSize(uint* BytesInMultiByteString, const(wchar)* UnicodeString, 
                                   uint BytesInUnicodeString);

@DllImport("ntdll")
NTSTATUS RtlCharToInteger(byte* String, uint Base, uint* Value);

@DllImport("ntdll")
uint RtlUniform(uint* Seed);

@DllImport("Cabinet")
void* FCICreate(ERF* perf, PFNFCIFILEPLACED pfnfcifp, PFNFCIALLOC pfna, PFNFCIFREE pfnf, PFNFCIOPEN pfnopen, 
                PFNFCIREAD pfnread, PFNFCIWRITE pfnwrite, PFNFCICLOSE pfnclose, PFNFCISEEK pfnseek, 
                PFNFCIDELETE pfndelete, PFNFCIGETTEMPFILE pfnfcigtf, CCAB* pccab, void* pv);

@DllImport("Cabinet")
BOOL FCIAddFile(void* hfci, const(char)* pszSourceFile, const(char)* pszFileName, BOOL fExecute, 
                PFNFCIGETNEXTCABINET pfnfcignc, PFNFCISTATUS pfnfcis, PFNFCIGETOPENINFO pfnfcigoi, 
                ushort typeCompress);

@DllImport("Cabinet")
BOOL FCIFlushCabinet(void* hfci, BOOL fGetNextCab, PFNFCIGETNEXTCABINET pfnfcignc, PFNFCISTATUS pfnfcis);

@DllImport("Cabinet")
BOOL FCIFlushFolder(void* hfci, PFNFCIGETNEXTCABINET pfnfcignc, PFNFCISTATUS pfnfcis);

@DllImport("Cabinet")
BOOL FCIDestroy(void* hfci);

@DllImport("Cabinet")
void* FDICreate(PFNALLOC pfnalloc, PFNFREE pfnfree, PFNOPEN pfnopen, PFNREAD pfnread, PFNWRITE pfnwrite, 
                PFNCLOSE pfnclose, PFNSEEK pfnseek, int cpuType, ERF* perf);

@DllImport("Cabinet")
BOOL FDIIsCabinet(void* hfdi, ptrdiff_t hf, FDICABINETINFO* pfdici);

@DllImport("Cabinet")
BOOL FDICopy(void* hfdi, const(char)* pszCabinet, const(char)* pszCabPath, int flags, PFNFDINOTIFY pfnfdin, 
             PFNFDIDECRYPT pfnfdid, void* pvUser);

@DllImport("Cabinet")
BOOL FDIDestroy(void* hfdi);

@DllImport("Cabinet")
BOOL FDITruncateCabinet(void* hfdi, const(char)* pszCabinetName, ushort iFolderToDelete);

@DllImport("api-ms-win-core-featurestaging-l1-1-0")
FEATURE_ENABLED_STATE GetFeatureEnabledState(uint featureId, FEATURE_CHANGE_TIME changeTime);

@DllImport("api-ms-win-core-featurestaging-l1-1-0")
void RecordFeatureUsage(uint featureId, uint kind, uint addend, const(char)* originName);

@DllImport("api-ms-win-core-featurestaging-l1-1-0")
void RecordFeatureError(uint featureId, const(FEATURE_ERROR)* error);

@DllImport("api-ms-win-core-featurestaging-l1-1-0")
void SubscribeFeatureStateChangeNotification(FEATURE_STATE_CHANGE_SUBSCRIPTION__** subscription, 
                                             PFEATURE_STATE_CHANGE_CALLBACK callback, void* context);

@DllImport("api-ms-win-core-featurestaging-l1-1-0")
void UnsubscribeFeatureStateChangeNotification(FEATURE_STATE_CHANGE_SUBSCRIPTION__* subscription);

@DllImport("api-ms-win-core-featurestaging-l1-1-1")
uint GetFeatureVariant(uint featureId, FEATURE_CHANGE_TIME changeTime, uint* payloadId, int* hasNotification);

@DllImport("fhsvcctl")
HRESULT FhServiceOpenPipe(BOOL StartServiceIfStopped, FH_SERVICE_PIPE_HANDLE__** Pipe);

@DllImport("fhsvcctl")
HRESULT FhServiceClosePipe(FH_SERVICE_PIPE_HANDLE__* Pipe);

@DllImport("fhsvcctl")
HRESULT FhServiceStartBackup(FH_SERVICE_PIPE_HANDLE__* Pipe, BOOL LowPriorityIo);

@DllImport("fhsvcctl")
HRESULT FhServiceStopBackup(FH_SERVICE_PIPE_HANDLE__* Pipe, BOOL StopTracking);

@DllImport("fhsvcctl")
HRESULT FhServiceReloadConfiguration(FH_SERVICE_PIPE_HANDLE__* Pipe);

@DllImport("fhsvcctl")
HRESULT FhServiceBlockBackup(FH_SERVICE_PIPE_HANDLE__* Pipe);

@DllImport("fhsvcctl")
HRESULT FhServiceUnblockBackup(FH_SERVICE_PIPE_HANDLE__* Pipe);

@DllImport("DCIMAN32")
HDC DCIOpenProvider();

@DllImport("DCIMAN32")
void DCICloseProvider(HDC hdc);

@DllImport("DCIMAN32")
int DCICreatePrimary(HDC hdc, DCISURFACEINFO** lplpSurface);

@DllImport("DCIMAN32")
int DCICreateOffscreen(HDC hdc, uint dwCompression, uint dwRedMask, uint dwGreenMask, uint dwBlueMask, 
                       uint dwWidth, uint dwHeight, uint dwDCICaps, uint dwBitCount, DCIOFFSCREEN** lplpSurface);

@DllImport("DCIMAN32")
int DCICreateOverlay(HDC hdc, void* lpOffscreenSurf, DCIOVERLAY** lplpSurface);

@DllImport("DCIMAN32")
int DCIEnum(HDC hdc, RECT* lprDst, RECT* lprSrc, void* lpFnCallback, void* lpContext);

@DllImport("DCIMAN32")
int DCISetSrcDestClip(DCIOFFSCREEN* pdci, RECT* srcrc, RECT* destrc, RGNDATA* prd);

@DllImport("DCIMAN32")
HWINWATCH__* WinWatchOpen(HWND hwnd);

@DllImport("DCIMAN32")
void WinWatchClose(HWINWATCH__* hWW);

@DllImport("DCIMAN32")
uint WinWatchGetClipList(HWINWATCH__* hWW, RECT* prc, uint size, RGNDATA* prd);

@DllImport("DCIMAN32")
BOOL WinWatchDidStatusChange(HWINWATCH__* hWW);

@DllImport("DCIMAN32")
uint GetWindowRegionData(HWND hwnd, uint size, RGNDATA* prd);

@DllImport("DCIMAN32")
uint GetDCRegionData(HDC hdc, uint size, RGNDATA* prd);

@DllImport("DCIMAN32")
BOOL WinWatchNotify(HWINWATCH__* hWW, WINWATCHNOTIFYPROC NotifyCallback, LPARAM NotifyParam);

@DllImport("DCIMAN32")
void DCIEndAccess(DCISURFACEINFO* pdci);

@DllImport("DCIMAN32")
int DCIBeginAccess(DCISURFACEINFO* pdci, int x, int y, int dx, int dy);

@DllImport("DCIMAN32")
void DCIDestroy(DCISURFACEINFO* pdci);

@DllImport("DCIMAN32")
int DCIDraw(DCIOFFSCREEN* pdci);

@DllImport("DCIMAN32")
int DCISetClipList(DCIOFFSCREEN* pdci, RGNDATA* prd);

@DllImport("DCIMAN32")
int DCISetDestination(DCIOFFSCREEN* pdci, RECT* dst, RECT* src);

@DllImport("api-ms-win-dx-d3dkmt-l1-1-0")
uint GdiEntry13();

@DllImport("ADVPACK")
HRESULT RunSetupCommandA(HWND hWnd, const(char)* szCmdName, const(char)* szInfSection, const(char)* szDir, 
                         const(char)* lpszTitle, HANDLE* phEXE, uint dwFlags, void* pvReserved);

@DllImport("ADVPACK")
HRESULT RunSetupCommandW(HWND hWnd, const(wchar)* szCmdName, const(wchar)* szInfSection, const(wchar)* szDir, 
                         const(wchar)* lpszTitle, HANDLE* phEXE, uint dwFlags, void* pvReserved);

@DllImport("ADVPACK")
uint NeedRebootInit();

@DllImport("ADVPACK")
BOOL NeedReboot(uint dwRebootCheck);

@DllImport("ADVPACK")
HRESULT RebootCheckOnInstallA(HWND hwnd, const(char)* pszINF, const(char)* pszSec, uint dwReserved);

@DllImport("ADVPACK")
HRESULT RebootCheckOnInstallW(HWND hwnd, const(wchar)* pszINF, const(wchar)* pszSec, uint dwReserved);

@DllImport("ADVPACK")
HRESULT TranslateInfStringA(const(char)* pszInfFilename, const(char)* pszInstallSection, 
                            const(char)* pszTranslateSection, const(char)* pszTranslateKey, const(char)* pszBuffer, 
                            uint cchBuffer, uint* pdwRequiredSize, void* pvReserved);

@DllImport("ADVPACK")
HRESULT TranslateInfStringW(const(wchar)* pszInfFilename, const(wchar)* pszInstallSection, 
                            const(wchar)* pszTranslateSection, const(wchar)* pszTranslateKey, 
                            const(wchar)* pszBuffer, uint cchBuffer, uint* pdwRequiredSize, void* pvReserved);

@DllImport("ADVPACK")
HRESULT RegInstallA(ptrdiff_t hmod, const(char)* pszSection, const(STRTABLEA)* pstTable);

@DllImport("ADVPACK")
HRESULT RegInstallW(ptrdiff_t hmod, const(wchar)* pszSection, const(STRTABLEW)* pstTable);

@DllImport("ADVPACK")
HRESULT LaunchINFSectionExW(HWND hwnd, HINSTANCE hInstance, const(wchar)* pszParms, int nShow);

@DllImport("ADVPACK")
HRESULT ExecuteCabA(HWND hwnd, _CabInfoA* pCab, void* pReserved);

@DllImport("ADVPACK")
HRESULT ExecuteCabW(HWND hwnd, _CabInfoW* pCab, void* pReserved);

@DllImport("ADVPACK")
HRESULT AdvInstallFileA(HWND hwnd, const(char)* lpszSourceDir, const(char)* lpszSourceFile, 
                        const(char)* lpszDestDir, const(char)* lpszDestFile, uint dwFlags, uint dwReserved);

@DllImport("ADVPACK")
HRESULT AdvInstallFileW(HWND hwnd, const(wchar)* lpszSourceDir, const(wchar)* lpszSourceFile, 
                        const(wchar)* lpszDestDir, const(wchar)* lpszDestFile, uint dwFlags, uint dwReserved);

@DllImport("ADVPACK")
HRESULT RegSaveRestoreA(HWND hWnd, const(char)* pszTitleString, HKEY hkBckupKey, const(char)* pcszRootKey, 
                        const(char)* pcszSubKey, const(char)* pcszValueName, uint dwFlags);

@DllImport("ADVPACK")
HRESULT RegSaveRestoreW(HWND hWnd, const(wchar)* pszTitleString, HKEY hkBckupKey, const(wchar)* pcszRootKey, 
                        const(wchar)* pcszSubKey, const(wchar)* pcszValueName, uint dwFlags);

@DllImport("ADVPACK")
HRESULT RegSaveRestoreOnINFA(HWND hWnd, const(char)* pszTitle, const(char)* pszINF, const(char)* pszSection, 
                             HKEY hHKLMBackKey, HKEY hHKCUBackKey, uint dwFlags);

@DllImport("ADVPACK")
HRESULT RegSaveRestoreOnINFW(HWND hWnd, const(wchar)* pszTitle, const(wchar)* pszINF, const(wchar)* pszSection, 
                             HKEY hHKLMBackKey, HKEY hHKCUBackKey, uint dwFlags);

@DllImport("ADVPACK")
HRESULT RegRestoreAllA(HWND hWnd, const(char)* pszTitleString, HKEY hkBckupKey);

@DllImport("ADVPACK")
HRESULT RegRestoreAllW(HWND hWnd, const(wchar)* pszTitleString, HKEY hkBckupKey);

@DllImport("ADVPACK")
HRESULT FileSaveRestoreW(HWND hDlg, const(wchar)* lpFileList, const(wchar)* lpDir, const(wchar)* lpBaseName, 
                         uint dwFlags);

@DllImport("ADVPACK")
HRESULT FileSaveRestoreOnINFA(HWND hWnd, const(char)* pszTitle, const(char)* pszINF, const(char)* pszSection, 
                              const(char)* pszBackupDir, const(char)* pszBaseBackupFile, uint dwFlags);

@DllImport("ADVPACK")
HRESULT FileSaveRestoreOnINFW(HWND hWnd, const(wchar)* pszTitle, const(wchar)* pszINF, const(wchar)* pszSection, 
                              const(wchar)* pszBackupDir, const(wchar)* pszBaseBackupFile, uint dwFlags);

@DllImport("ADVPACK")
HRESULT AddDelBackupEntryA(const(char)* lpcszFileList, const(char)* lpcszBackupDir, const(char)* lpcszBaseName, 
                           uint dwFlags);

@DllImport("ADVPACK")
HRESULT AddDelBackupEntryW(const(wchar)* lpcszFileList, const(wchar)* lpcszBackupDir, const(wchar)* lpcszBaseName, 
                           uint dwFlags);

@DllImport("ADVPACK")
HRESULT FileSaveMarkNotExistA(const(char)* lpFileList, const(char)* lpDir, const(char)* lpBaseName);

@DllImport("ADVPACK")
HRESULT FileSaveMarkNotExistW(const(wchar)* lpFileList, const(wchar)* lpDir, const(wchar)* lpBaseName);

@DllImport("ADVPACK")
HRESULT GetVersionFromFileA(const(char)* lpszFilename, uint* pdwMSVer, uint* pdwLSVer, BOOL bVersion);

@DllImport("ADVPACK")
HRESULT GetVersionFromFileW(const(wchar)* lpszFilename, uint* pdwMSVer, uint* pdwLSVer, BOOL bVersion);

@DllImport("ADVPACK")
HRESULT GetVersionFromFileExA(const(char)* lpszFilename, uint* pdwMSVer, uint* pdwLSVer, BOOL bVersion);

@DllImport("ADVPACK")
HRESULT GetVersionFromFileExW(const(wchar)* lpszFilename, uint* pdwMSVer, uint* pdwLSVer, BOOL bVersion);

@DllImport("ADVPACK")
BOOL IsNTAdmin(uint dwReserved, uint* lpdwReserved);

@DllImport("ADVPACK")
HRESULT DelNodeA(const(char)* pszFileOrDirName, uint dwFlags);

@DllImport("ADVPACK")
HRESULT DelNodeW(const(wchar)* pszFileOrDirName, uint dwFlags);

@DllImport("ADVPACK")
HRESULT DelNodeRunDLL32W(HWND hwnd, HINSTANCE hInstance, const(wchar)* pszParms, int nShow);

@DllImport("ADVPACK")
HRESULT OpenINFEngineA(const(char)* pszInfFilename, const(char)* pszInstallSection, uint dwFlags, void** phInf, 
                       void* pvReserved);

@DllImport("ADVPACK")
HRESULT OpenINFEngineW(const(wchar)* pszInfFilename, const(wchar)* pszInstallSection, uint dwFlags, void** phInf, 
                       void* pvReserved);

@DllImport("ADVPACK")
HRESULT TranslateInfStringExA(void* hInf, const(char)* pszInfFilename, const(char)* pszTranslateSection, 
                              const(char)* pszTranslateKey, const(char)* pszBuffer, uint dwBufferSize, 
                              uint* pdwRequiredSize, void* pvReserved);

@DllImport("ADVPACK")
HRESULT TranslateInfStringExW(void* hInf, const(wchar)* pszInfFilename, const(wchar)* pszTranslateSection, 
                              const(wchar)* pszTranslateKey, const(wchar)* pszBuffer, uint dwBufferSize, 
                              uint* pdwRequiredSize, void* pvReserved);

@DllImport("ADVPACK")
HRESULT CloseINFEngine(void* hInf);

@DllImport("ADVPACK")
HRESULT ExtractFilesA(const(char)* pszCabName, const(char)* pszExpandDir, uint dwFlags, const(char)* pszFileList, 
                      void* lpReserved, uint dwReserved);

@DllImport("ADVPACK")
HRESULT ExtractFilesW(const(wchar)* pszCabName, const(wchar)* pszExpandDir, uint dwFlags, 
                      const(wchar)* pszFileList, void* lpReserved, uint dwReserved);

@DllImport("ADVPACK")
int LaunchINFSectionW(HWND hwndOwner, HINSTANCE hInstance, const(wchar)* pszParams, int nShow);

@DllImport("ADVPACK")
HRESULT UserInstStubWrapperA(HWND hwnd, HINSTANCE hInstance, const(char)* pszParms, int nShow);

@DllImport("ADVPACK")
HRESULT UserInstStubWrapperW(HWND hwnd, HINSTANCE hInstance, const(wchar)* pszParms, int nShow);

@DllImport("ADVPACK")
HRESULT UserUnInstStubWrapperA(HWND hwnd, HINSTANCE hInstance, const(char)* pszParms, int nShow);

@DllImport("ADVPACK")
HRESULT UserUnInstStubWrapperW(HWND hwnd, HINSTANCE hInstance, const(wchar)* pszParms, int nShow);

@DllImport("ADVPACK")
HRESULT SetPerUserSecValuesA(PERUSERSECTIONA* pPerUser);

@DllImport("ADVPACK")
HRESULT SetPerUserSecValuesW(PERUSERSECTIONW* pPerUser);

@DllImport("USER32")
LRESULT SendIMEMessageExA(HWND param0, LPARAM param1);

@DllImport("USER32")
LRESULT SendIMEMessageExW(HWND param0, LPARAM param1);

@DllImport("USER32")
BOOL IMPGetIMEA(HWND param0, IMEPROA* param1);

@DllImport("USER32")
BOOL IMPGetIMEW(HWND param0, IMEPROW* param1);

@DllImport("USER32")
BOOL IMPQueryIMEA(IMEPROA* param0);

@DllImport("USER32")
BOOL IMPQueryIMEW(IMEPROW* param0);

@DllImport("USER32")
BOOL IMPSetIMEA(HWND param0, IMEPROA* param1);

@DllImport("USER32")
BOOL IMPSetIMEW(HWND param0, IMEPROW* param1);

@DllImport("USER32")
uint WINNLSGetIMEHotkey(HWND param0);

@DllImport("USER32")
BOOL WINNLSEnableIME(HWND param0, BOOL param1);

@DllImport("USER32")
BOOL WINNLSGetEnableStatus(HWND param0);

@DllImport("api-ms-win-security-isolatedcontainer-l1-1-1")
HRESULT IsProcessInWDAGContainer(void* Reserved, int* isProcessInWDAGContainer);

@DllImport("api-ms-win-security-isolatedcontainer-l1-1-0")
HRESULT IsProcessInIsolatedContainer(int* isProcessInIsolatedContainer);

@DllImport("WSCAPI")
HRESULT WscRegisterForChanges(void* Reserved, ptrdiff_t* phCallbackRegistration, 
                              LPTHREAD_START_ROUTINE lpCallbackAddress, void* pContext);

@DllImport("WSCAPI")
HRESULT WscUnRegisterChanges(HANDLE hRegistrationHandle);

@DllImport("WSCAPI")
HRESULT WscRegisterForUserNotifications();

@DllImport("WSCAPI")
HRESULT WscGetSecurityProviderHealth(uint Providers, WSC_SECURITY_PROVIDER_HEALTH* pHealth);

@DllImport("WSCAPI")
HRESULT WscQueryAntiMalwareUri();

@DllImport("WSCAPI")
HRESULT WscGetAntiMalwareUri(ushort** ppszUri);

@DllImport("APPHELP")
BOOL ApphelpCheckShellObject(const(GUID)* ObjectCLSID, BOOL bShimIfNecessary, ulong* pullFlags);

@DllImport("Wldp")
HRESULT WldpGetLockdownPolicy(WLDP_HOST_INFORMATION* hostInformation, uint* lockdownState, uint lockdownFlags);

@DllImport("Wldp")
HRESULT WldpIsClassInApprovedList(const(GUID)* classID, WLDP_HOST_INFORMATION* hostInformation, int* isApproved, 
                                  uint optionalFlags);

@DllImport("Wldp")
HRESULT WldpSetDynamicCodeTrust(HANDLE fileHandle);

@DllImport("Wldp")
HRESULT WldpIsDynamicCodePolicyEnabled(int* isEnabled);

@DllImport("Wldp")
HRESULT WldpQueryDynamicCodeTrust(HANDLE fileHandle, char* baseImage, uint imageSize);

@DllImport("KERNEL32")
BOOL CeipIsOptedIn();

@DllImport("XmlLite")
HRESULT CreateXmlReader(const(GUID)* riid, void** ppvObject, IMalloc pMalloc);

@DllImport("XmlLite")
HRESULT CreateXmlReaderInputWithEncodingCodePage(IUnknown pInputStream, IMalloc pMalloc, uint nEncodingCodePage, 
                                                 BOOL fEncodingHint, const(wchar)* pwszBaseUri, IUnknown* ppInput);

@DllImport("XmlLite")
HRESULT CreateXmlReaderInputWithEncodingName(IUnknown pInputStream, IMalloc pMalloc, 
                                             const(wchar)* pwszEncodingName, BOOL fEncodingHint, 
                                             const(wchar)* pwszBaseUri, IUnknown* ppInput);

@DllImport("XmlLite")
HRESULT CreateXmlWriter(const(GUID)* riid, void** ppvObject, IMalloc pMalloc);

@DllImport("XmlLite")
HRESULT CreateXmlWriterOutputWithEncodingCodePage(IUnknown pOutputStream, IMalloc pMalloc, uint nEncodingCodePage, 
                                                  IUnknown* ppOutput);

@DllImport("XmlLite")
HRESULT CreateXmlWriterOutputWithEncodingName(IUnknown pOutputStream, IMalloc pMalloc, 
                                              const(wchar)* pwszEncodingName, IUnknown* ppOutput);

@DllImport("api-ms-win-devices-query-l1-1-0")
HRESULT DevCreateObjectQuery(DEV_OBJECT_TYPE ObjectType, uint QueryFlags, uint cRequestedProperties, 
                             char* pRequestedProperties, uint cFilterExpressionCount, char* pFilter, 
                             PDEV_QUERY_RESULT_CALLBACK pCallback, void* pContext, HDEVQUERY__** phDevQuery);

@DllImport("api-ms-win-devices-query-l1-1-1")
HRESULT DevCreateObjectQueryEx(DEV_OBJECT_TYPE ObjectType, uint QueryFlags, uint cRequestedProperties, 
                               char* pRequestedProperties, uint cFilterExpressionCount, char* pFilter, 
                               uint cExtendedParameterCount, char* pExtendedParameters, 
                               PDEV_QUERY_RESULT_CALLBACK pCallback, void* pContext, HDEVQUERY__** phDevQuery);

@DllImport("api-ms-win-devices-query-l1-1-0")
HRESULT DevCreateObjectQueryFromId(DEV_OBJECT_TYPE ObjectType, const(wchar)* pszObjectId, uint QueryFlags, 
                                   uint cRequestedProperties, char* pRequestedProperties, 
                                   uint cFilterExpressionCount, char* pFilter, PDEV_QUERY_RESULT_CALLBACK pCallback, 
                                   void* pContext, HDEVQUERY__** phDevQuery);

@DllImport("api-ms-win-devices-query-l1-1-1")
HRESULT DevCreateObjectQueryFromIdEx(DEV_OBJECT_TYPE ObjectType, const(wchar)* pszObjectId, uint QueryFlags, 
                                     uint cRequestedProperties, char* pRequestedProperties, 
                                     uint cFilterExpressionCount, char* pFilter, uint cExtendedParameterCount, 
                                     char* pExtendedParameters, PDEV_QUERY_RESULT_CALLBACK pCallback, void* pContext, 
                                     HDEVQUERY__** phDevQuery);

@DllImport("api-ms-win-devices-query-l1-1-0")
HRESULT DevCreateObjectQueryFromIds(DEV_OBJECT_TYPE ObjectType, const(wchar)* pszzObjectIds, uint QueryFlags, 
                                    uint cRequestedProperties, char* pRequestedProperties, 
                                    uint cFilterExpressionCount, char* pFilter, PDEV_QUERY_RESULT_CALLBACK pCallback, 
                                    void* pContext, HDEVQUERY__** phDevQuery);

@DllImport("api-ms-win-devices-query-l1-1-1")
HRESULT DevCreateObjectQueryFromIdsEx(DEV_OBJECT_TYPE ObjectType, const(wchar)* pszzObjectIds, uint QueryFlags, 
                                      uint cRequestedProperties, char* pRequestedProperties, 
                                      uint cFilterExpressionCount, char* pFilter, uint cExtendedParameterCount, 
                                      char* pExtendedParameters, PDEV_QUERY_RESULT_CALLBACK pCallback, 
                                      void* pContext, HDEVQUERY__** phDevQuery);

@DllImport("api-ms-win-devices-query-l1-1-0")
void DevCloseObjectQuery(HDEVQUERY__* hDevQuery);

@DllImport("api-ms-win-devices-query-l1-1-0")
HRESULT DevGetObjects(DEV_OBJECT_TYPE ObjectType, uint QueryFlags, uint cRequestedProperties, 
                      char* pRequestedProperties, uint cFilterExpressionCount, char* pFilter, uint* pcObjectCount, 
                      const(DEV_OBJECT)** ppObjects);

@DllImport("api-ms-win-devices-query-l1-1-1")
HRESULT DevGetObjectsEx(DEV_OBJECT_TYPE ObjectType, uint QueryFlags, uint cRequestedProperties, 
                        char* pRequestedProperties, uint cFilterExpressionCount, char* pFilter, 
                        uint cExtendedParameterCount, char* pExtendedParameters, uint* pcObjectCount, 
                        const(DEV_OBJECT)** ppObjects);

@DllImport("api-ms-win-devices-query-l1-1-0")
void DevFreeObjects(uint cObjectCount, char* pObjects);

@DllImport("api-ms-win-devices-query-l1-1-0")
HRESULT DevGetObjectProperties(DEV_OBJECT_TYPE ObjectType, const(wchar)* pszObjectId, uint QueryFlags, 
                               uint cRequestedProperties, char* pRequestedProperties, uint* pcPropertyCount, 
                               const(DEVPROPERTY)** ppProperties);

@DllImport("api-ms-win-devices-query-l1-1-1")
HRESULT DevGetObjectPropertiesEx(DEV_OBJECT_TYPE ObjectType, const(wchar)* pszObjectId, uint QueryFlags, 
                                 uint cRequestedProperties, char* pRequestedProperties, uint cExtendedParameterCount, 
                                 char* pExtendedParameters, uint* pcPropertyCount, const(DEVPROPERTY)** ppProperties);

@DllImport("api-ms-win-devices-query-l1-1-0")
void DevFreeObjectProperties(uint cPropertyCount, char* pProperties);

@DllImport("api-ms-win-devices-query-l1-1-0")
DEVPROPERTY* DevFindProperty(const(DEVPROPKEY)* pKey, DEVPROPSTORE Store, const(wchar)* pszLocaleName, 
                             uint cProperties, char* pProperties);

@DllImport("IPHLPAPI")
uint PfCreateInterface(uint dwName, _PfForwardAction inAction, _PfForwardAction outAction, BOOL bUseLog, 
                       BOOL bMustBeUnique, void** ppInterface);

@DllImport("IPHLPAPI")
uint PfDeleteInterface(void* pInterface);

@DllImport("IPHLPAPI")
uint PfAddFiltersToInterface(void* ih, uint cInFilters, PF_FILTER_DESCRIPTOR* pfiltIn, uint cOutFilters, 
                             PF_FILTER_DESCRIPTOR* pfiltOut, void** pfHandle);

@DllImport("IPHLPAPI")
uint PfRemoveFiltersFromInterface(void* ih, uint cInFilters, PF_FILTER_DESCRIPTOR* pfiltIn, uint cOutFilters, 
                                  PF_FILTER_DESCRIPTOR* pfiltOut);

@DllImport("IPHLPAPI")
uint PfRemoveFilterHandles(void* pInterface, uint cFilters, void** pvHandles);

@DllImport("IPHLPAPI")
uint PfUnBindInterface(void* pInterface);

@DllImport("IPHLPAPI")
uint PfBindInterfaceToIndex(void* pInterface, uint dwIndex, _PfAddresType pfatLinkType, ubyte* LinkIPAddress);

@DllImport("IPHLPAPI")
uint PfBindInterfaceToIPAddress(void* pInterface, _PfAddresType pfatType, ubyte* IPAddress);

@DllImport("IPHLPAPI")
uint PfRebindFilters(void* pInterface, PF_LATEBIND_INFO* pLateBindInfo);

@DllImport("IPHLPAPI")
uint PfAddGlobalFilterToInterface(void* pInterface, _GlobalFilter gfFilter);

@DllImport("IPHLPAPI")
uint PfRemoveGlobalFilterFromInterface(void* pInterface, _GlobalFilter gfFilter);

@DllImport("IPHLPAPI")
uint PfMakeLog(HANDLE hEvent);

@DllImport("IPHLPAPI")
uint PfSetLogBuffer(ubyte* pbBuffer, uint dwSize, uint dwThreshold, uint dwEntries, uint* pdwLoggedEntries, 
                    uint* pdwLostEntries, uint* pdwSizeUsed);

@DllImport("IPHLPAPI")
uint PfDeleteLog();

@DllImport("IPHLPAPI")
uint PfGetInterfaceStatistics(void* pInterface, PF_INTERFACE_STATS* ppfStats, uint* pdwBufferSize, 
                              BOOL fResetCounters);

@DllImport("IPHLPAPI")
uint PfTestPacket(void* pInInterface, void* pOutInterface, uint cBytes, ubyte* pbPacket, 
                  _PfForwardAction* ppAction);

@DllImport("api-ms-win-core-state-helpers-l1-1-0")
LSTATUS GetRegistryValueWithFallbackW(HKEY hkeyPrimary, const(wchar)* pwszPrimarySubKey, HKEY hkeyFallback, 
                                      const(wchar)* pwszFallbackSubKey, const(wchar)* pwszValue, uint dwFlags, 
                                      uint* pdwType, char* pvData, uint cbDataIn, uint* pcbDataOut);

@DllImport("ole32")
HRESULT CoInstall(IBindCtx pbc, uint dwFlags, uCLSSPEC* pClassSpec, QUERYCONTEXT* pQuery, 
                  const(wchar)* pszCodeBase);


// Interfaces

@GUID("2933BF90-7B36-11D2-B20E-00C04F983E60")
struct DOMDocument;

@GUID("2933BF91-7B36-11D2-B20E-00C04F983E60")
struct DOMFreeThreadedDocument;

@GUID("ED8C108E-4349-11D2-91A4-00C04F7969E8")
struct XMLHTTPRequest;

@GUID("550DDA30-0541-11D2-9CA9-0060B0EC3D39")
struct XMLDSOControl;

@GUID("CFC399AF-D876-11D0-9C10-00C04FC99C8E")
struct XMLDocument;

@GUID("16D5A2BE-B1C5-47B3-8EAE-CCBCF452C7E8")
struct CameraUIControl;

@GUID("01776DF3-B9AF-4E50-9B1C-56E93116D704")
struct EditionUpgradeHelper;

@GUID("C4270827-4F39-45DF-9288-12FF6B85A921")
struct EditionUpgradeBroker;

@GUID("ED43BB3C-09E9-498A-9DF6-2177244C6DB4")
struct FhConfigMgr;

@GUID("4D728E35-16FA-4320-9E8B-BFD7100A8846")
struct FhReassociation;

@GUID("098EF871-FA9F-46AF-8958-C083515D7C9C")
struct WaaSAssessor;

@GUID("EAB22AC3-30C1-11CF-A7EB-0000C05BAE0B")
struct WebBrowser_V1;

@GUID("8856F961-340A-11D0-A96B-00C04FD705A2")
struct WebBrowser;

@GUID("0002DF01-0000-0000-C000-000000000046")
struct InternetExplorer;

@GUID("D5E8041D-920F-45E9-B8FB-B1DEB82C6E5E")
struct InternetExplorerMedium;

@GUID("C08AFD90-F2A1-11D1-8455-00A0C91F3880")
struct ShellBrowserWindow;

@GUID("9BA05972-F6A8-11CF-A442-00A0C90A8F39")
struct ShellWindows;

@GUID("64AB4BB7-111E-11D1-8F79-00C04FC2FBE1")
struct ShellUIHelper;

@GUID("55136805-B2DE-11D1-B9F2-00A0C98BC547")
struct ShellNameSpace;

@GUID("EFD01300-160F-11D2-BB2E-00805FF7EFCA")
struct CScriptErrorList;

@GUID("BC812430-E75E-4FD1-9641-1F9F1E2D9A1F")
struct IsolatedAppLauncher;

@GUID("17072F7B-9ABE-4A74-A261-1EB76B55107A")
struct WSCProductList;

@GUID("2981A36E-F22D-11E5-9CE9-5E5517507C66")
struct WSCDefaultProduct;

@GUID("2933BF8F-7B36-11D2-B20E-00C04F983E60")
interface IXMLDOMImplementation : IDispatch
{
    HRESULT hasFeature(BSTR feature, BSTR version_, short* hasFeature);
}

@GUID("2933BF80-7B36-11D2-B20E-00C04F983E60")
interface IXMLDOMNode : IDispatch
{
    HRESULT get_nodeName(BSTR* name);
    HRESULT get_nodeValue(VARIANT* value);
    HRESULT put_nodeValue(VARIANT value);
    HRESULT get_nodeType(DOMNodeType* type);
    HRESULT get_parentNode(IXMLDOMNode* parent);
    HRESULT get_childNodes(IXMLDOMNodeList* childList);
    HRESULT get_firstChild(IXMLDOMNode* firstChild);
    HRESULT get_lastChild(IXMLDOMNode* lastChild);
    HRESULT get_previousSibling(IXMLDOMNode* previousSibling);
    HRESULT get_nextSibling(IXMLDOMNode* nextSibling);
    HRESULT get_attributes(IXMLDOMNamedNodeMap* attributeMap);
    HRESULT insertBefore(IXMLDOMNode newChild, VARIANT refChild, IXMLDOMNode* outNewChild);
    HRESULT replaceChild(IXMLDOMNode newChild, IXMLDOMNode oldChild, IXMLDOMNode* outOldChild);
    HRESULT removeChild(IXMLDOMNode childNode, IXMLDOMNode* oldChild);
    HRESULT appendChild(IXMLDOMNode newChild, IXMLDOMNode* outNewChild);
    HRESULT hasChildNodes(short* hasChild);
    HRESULT get_ownerDocument(IXMLDOMDocument* XMLDOMDocument);
    HRESULT cloneNode(short deep, IXMLDOMNode* cloneRoot);
    HRESULT get_nodeTypeString(BSTR* nodeType);
    HRESULT get_text(BSTR* text);
    HRESULT put_text(BSTR text);
    HRESULT get_specified(short* isSpecified);
    HRESULT get_definition(IXMLDOMNode* definitionNode);
    HRESULT get_nodeTypedValue(VARIANT* typedValue);
    HRESULT put_nodeTypedValue(VARIANT typedValue);
    HRESULT get_dataType(VARIANT* dataTypeName);
    HRESULT put_dataType(BSTR dataTypeName);
    HRESULT get_xml(BSTR* xmlString);
    HRESULT transformNode(IXMLDOMNode stylesheet, BSTR* xmlString);
    HRESULT selectNodes(BSTR queryString, IXMLDOMNodeList* resultList);
    HRESULT selectSingleNode(BSTR queryString, IXMLDOMNode* resultNode);
    HRESULT get_parsed(short* isParsed);
    HRESULT get_namespaceURI(BSTR* namespaceURI);
    HRESULT get_prefix(BSTR* prefixString);
    HRESULT get_baseName(BSTR* nameString);
    HRESULT transformNodeToObject(IXMLDOMNode stylesheet, VARIANT outputObject);
}

@GUID("3EFAA413-272F-11D2-836F-0000F87A7782")
interface IXMLDOMDocumentFragment : IXMLDOMNode
{
}

@GUID("2933BF81-7B36-11D2-B20E-00C04F983E60")
interface IXMLDOMDocument : IXMLDOMNode
{
    HRESULT get_doctype(IXMLDOMDocumentType* documentType);
    HRESULT get_implementation(IXMLDOMImplementation* impl);
    HRESULT get_documentElement(IXMLDOMElement* DOMElement);
    HRESULT putref_documentElement(IXMLDOMElement DOMElement);
    HRESULT createElement(BSTR tagName, IXMLDOMElement* element);
    HRESULT createDocumentFragment(IXMLDOMDocumentFragment* docFrag);
    HRESULT createTextNode(BSTR data, IXMLDOMText* text);
    HRESULT createComment(BSTR data, IXMLDOMComment* comment);
    HRESULT createCDATASection(BSTR data, IXMLDOMCDATASection* cdata);
    HRESULT createProcessingInstruction(BSTR target, BSTR data, IXMLDOMProcessingInstruction* pi);
    HRESULT createAttribute(BSTR name, IXMLDOMAttribute* attribute);
    HRESULT createEntityReference(BSTR name, IXMLDOMEntityReference* entityRef);
    HRESULT getElementsByTagName(BSTR tagName, IXMLDOMNodeList* resultList);
    HRESULT createNode(VARIANT Type, BSTR name, BSTR namespaceURI, IXMLDOMNode* node);
    HRESULT nodeFromID(BSTR idString, IXMLDOMNode* node);
    HRESULT load(VARIANT xmlSource, short* isSuccessful);
    HRESULT get_readyState(int* value);
    HRESULT get_parseError(IXMLDOMParseError* errorObj);
    HRESULT get_url(BSTR* urlString);
    HRESULT get_async(short* isAsync);
    HRESULT put_async(short isAsync);
    HRESULT abort();
    HRESULT loadXML(BSTR bstrXML, short* isSuccessful);
    HRESULT save(VARIANT destination);
    HRESULT get_validateOnParse(short* isValidating);
    HRESULT put_validateOnParse(short isValidating);
    HRESULT get_resolveExternals(short* isResolving);
    HRESULT put_resolveExternals(short isResolving);
    HRESULT get_preserveWhiteSpace(short* isPreserving);
    HRESULT put_preserveWhiteSpace(short isPreserving);
    HRESULT put_onreadystatechange(VARIANT readystatechangeSink);
    HRESULT put_ondataavailable(VARIANT ondataavailableSink);
    HRESULT put_ontransformnode(VARIANT ontransformnodeSink);
}

@GUID("2933BF82-7B36-11D2-B20E-00C04F983E60")
interface IXMLDOMNodeList : IDispatch
{
    HRESULT get_item(int index, IXMLDOMNode* listItem);
    HRESULT get_length(int* listLength);
    HRESULT nextNode(IXMLDOMNode* nextItem);
    HRESULT reset();
    HRESULT get__newEnum(IUnknown* ppUnk);
}

@GUID("2933BF83-7B36-11D2-B20E-00C04F983E60")
interface IXMLDOMNamedNodeMap : IDispatch
{
    HRESULT getNamedItem(BSTR name, IXMLDOMNode* namedItem);
    HRESULT setNamedItem(IXMLDOMNode newItem, IXMLDOMNode* nameItem);
    HRESULT removeNamedItem(BSTR name, IXMLDOMNode* namedItem);
    HRESULT get_item(int index, IXMLDOMNode* listItem);
    HRESULT get_length(int* listLength);
    HRESULT getQualifiedItem(BSTR baseName, BSTR namespaceURI, IXMLDOMNode* qualifiedItem);
    HRESULT removeQualifiedItem(BSTR baseName, BSTR namespaceURI, IXMLDOMNode* qualifiedItem);
    HRESULT nextNode(IXMLDOMNode* nextItem);
    HRESULT reset();
    HRESULT get__newEnum(IUnknown* ppUnk);
}

@GUID("2933BF84-7B36-11D2-B20E-00C04F983E60")
interface IXMLDOMCharacterData : IXMLDOMNode
{
    HRESULT get_data(BSTR* data);
    HRESULT put_data(BSTR data);
    HRESULT get_length(int* dataLength);
    HRESULT substringData(int offset, int count, BSTR* data);
    HRESULT appendData(BSTR data);
    HRESULT insertData(int offset, BSTR data);
    HRESULT deleteData(int offset, int count);
    HRESULT replaceData(int offset, int count, BSTR data);
}

@GUID("2933BF85-7B36-11D2-B20E-00C04F983E60")
interface IXMLDOMAttribute : IXMLDOMNode
{
    HRESULT get_name(BSTR* attributeName);
    HRESULT get_value(VARIANT* attributeValue);
    HRESULT put_value(VARIANT attributeValue);
}

@GUID("2933BF86-7B36-11D2-B20E-00C04F983E60")
interface IXMLDOMElement : IXMLDOMNode
{
    HRESULT get_tagName(BSTR* tagName);
    HRESULT getAttribute(BSTR name, VARIANT* value);
    HRESULT setAttribute(BSTR name, VARIANT value);
    HRESULT removeAttribute(BSTR name);
    HRESULT getAttributeNode(BSTR name, IXMLDOMAttribute* attributeNode);
    HRESULT setAttributeNode(IXMLDOMAttribute DOMAttribute, IXMLDOMAttribute* attributeNode);
    HRESULT removeAttributeNode(IXMLDOMAttribute DOMAttribute, IXMLDOMAttribute* attributeNode);
    HRESULT getElementsByTagName(BSTR tagName, IXMLDOMNodeList* resultList);
    HRESULT normalize();
}

@GUID("2933BF87-7B36-11D2-B20E-00C04F983E60")
interface IXMLDOMText : IXMLDOMCharacterData
{
    HRESULT splitText(int offset, IXMLDOMText* rightHandTextNode);
}

@GUID("2933BF88-7B36-11D2-B20E-00C04F983E60")
interface IXMLDOMComment : IXMLDOMCharacterData
{
}

@GUID("2933BF89-7B36-11D2-B20E-00C04F983E60")
interface IXMLDOMProcessingInstruction : IXMLDOMNode
{
    HRESULT get_target(BSTR* name);
    HRESULT get_data(BSTR* value);
    HRESULT put_data(BSTR value);
}

@GUID("2933BF8A-7B36-11D2-B20E-00C04F983E60")
interface IXMLDOMCDATASection : IXMLDOMText
{
}

@GUID("2933BF8B-7B36-11D2-B20E-00C04F983E60")
interface IXMLDOMDocumentType : IXMLDOMNode
{
    HRESULT get_name(BSTR* rootName);
    HRESULT get_entities(IXMLDOMNamedNodeMap* entityMap);
    HRESULT get_notations(IXMLDOMNamedNodeMap* notationMap);
}

@GUID("2933BF8C-7B36-11D2-B20E-00C04F983E60")
interface IXMLDOMNotation : IXMLDOMNode
{
    HRESULT get_publicId(VARIANT* publicID);
    HRESULT get_systemId(VARIANT* systemID);
}

@GUID("2933BF8D-7B36-11D2-B20E-00C04F983E60")
interface IXMLDOMEntity : IXMLDOMNode
{
    HRESULT get_publicId(VARIANT* publicID);
    HRESULT get_systemId(VARIANT* systemID);
    HRESULT get_notationName(BSTR* name);
}

@GUID("2933BF8E-7B36-11D2-B20E-00C04F983E60")
interface IXMLDOMEntityReference : IXMLDOMNode
{
}

@GUID("3EFAA426-272F-11D2-836F-0000F87A7782")
interface IXMLDOMParseError : IDispatch
{
    HRESULT get_errorCode(int* errorCode);
    HRESULT get_url(BSTR* urlString);
    HRESULT get_reason(BSTR* reasonString);
    HRESULT get_srcText(BSTR* sourceString);
    HRESULT get_line(int* lineNumber);
    HRESULT get_linepos(int* linePosition);
    HRESULT get_filepos(int* filePosition);
}

@GUID("3EFAA425-272F-11D2-836F-0000F87A7782")
interface IXTLRuntime : IXMLDOMNode
{
    HRESULT uniqueID(IXMLDOMNode pNode, int* pID);
    HRESULT depth(IXMLDOMNode pNode, int* pDepth);
    HRESULT childNumber(IXMLDOMNode pNode, int* pNumber);
    HRESULT ancestorChildNumber(BSTR bstrNodeName, IXMLDOMNode pNode, int* pNumber);
    HRESULT absoluteChildNumber(IXMLDOMNode pNode, int* pNumber);
    HRESULT formatIndex(int lIndex, BSTR bstrFormat, BSTR* pbstrFormattedString);
    HRESULT formatNumber(double dblNumber, BSTR bstrFormat, BSTR* pbstrFormattedString);
    HRESULT formatDate(VARIANT varDate, BSTR bstrFormat, VARIANT varDestLocale, BSTR* pbstrFormattedString);
    HRESULT formatTime(VARIANT varTime, BSTR bstrFormat, VARIANT varDestLocale, BSTR* pbstrFormattedString);
}

@GUID("3EFAA427-272F-11D2-836F-0000F87A7782")
interface XMLDOMDocumentEvents : IDispatch
{
}

@GUID("ED8C108D-4349-11D2-91A4-00C04F7969E8")
interface IXMLHttpRequest : IDispatch
{
    HRESULT open(BSTR bstrMethod, BSTR bstrUrl, VARIANT varAsync, VARIANT bstrUser, VARIANT bstrPassword);
    HRESULT setRequestHeader(BSTR bstrHeader, BSTR bstrValue);
    HRESULT getResponseHeader(BSTR bstrHeader, BSTR* pbstrValue);
    HRESULT getAllResponseHeaders(BSTR* pbstrHeaders);
    HRESULT send(VARIANT varBody);
    HRESULT abort();
    HRESULT get_status(int* plStatus);
    HRESULT get_statusText(BSTR* pbstrStatus);
    HRESULT get_responseXML(IDispatch* ppBody);
    HRESULT get_responseText(BSTR* pbstrBody);
    HRESULT get_responseBody(VARIANT* pvarBody);
    HRESULT get_responseStream(VARIANT* pvarBody);
    HRESULT get_readyState(int* plState);
    HRESULT put_onreadystatechange(IDispatch pReadyStateSink);
}

@GUID("310AFA62-0575-11D2-9CA9-0060B0EC3D39")
interface IXMLDSOControl : IDispatch
{
    HRESULT get_XMLDocument(IXMLDOMDocument* ppDoc);
    HRESULT put_XMLDocument(IXMLDOMDocument ppDoc);
    HRESULT get_JavaDSOCompatible(int* fJavaDSOCompatible);
    HRESULT put_JavaDSOCompatible(BOOL fJavaDSOCompatible);
    HRESULT get_readyState(int* state);
}

@GUID("65725580-9B5D-11D0-9BFE-00C04FC99C8E")
interface IXMLElementCollection : IDispatch
{
    HRESULT put_length(int v);
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* ppUnk);
    HRESULT item(VARIANT var1, VARIANT var2, IDispatch* ppDisp);
}

@GUID("F52E2B61-18A1-11D1-B105-00805F49916B")
interface IXMLDocument : IDispatch
{
    HRESULT get_root(IXMLElement* p);
    HRESULT get_fileSize(BSTR* p);
    HRESULT get_fileModifiedDate(BSTR* p);
    HRESULT get_fileUpdatedDate(BSTR* p);
    HRESULT get_URL(BSTR* p);
    HRESULT put_URL(BSTR p);
    HRESULT get_mimeType(BSTR* p);
    HRESULT get_readyState(int* pl);
    HRESULT get_charset(BSTR* p);
    HRESULT put_charset(BSTR p);
    HRESULT get_version(BSTR* p);
    HRESULT get_doctype(BSTR* p);
    HRESULT get_dtdURL(BSTR* p);
    HRESULT createElement(VARIANT vType, VARIANT var1, IXMLElement* ppElem);
}

@GUID("2B8DE2FE-8D2D-11D1-B2FC-00C04FD915A9")
interface IXMLDocument2 : IDispatch
{
    HRESULT get_root(IXMLElement2* p);
    HRESULT get_fileSize(BSTR* p);
    HRESULT get_fileModifiedDate(BSTR* p);
    HRESULT get_fileUpdatedDate(BSTR* p);
    HRESULT get_URL(BSTR* p);
    HRESULT put_URL(BSTR p);
    HRESULT get_mimeType(BSTR* p);
    HRESULT get_readyState(int* pl);
    HRESULT get_charset(BSTR* p);
    HRESULT put_charset(BSTR p);
    HRESULT get_version(BSTR* p);
    HRESULT get_doctype(BSTR* p);
    HRESULT get_dtdURL(BSTR* p);
    HRESULT createElement(VARIANT vType, VARIANT var1, IXMLElement2* ppElem);
    HRESULT get_async(short* pf);
    HRESULT put_async(short f);
}

@GUID("3F7F31AC-E15F-11D0-9C25-00C04FC99C8E")
interface IXMLElement : IDispatch
{
    HRESULT get_tagName(BSTR* p);
    HRESULT put_tagName(BSTR p);
    HRESULT get_parent(IXMLElement* ppParent);
    HRESULT setAttribute(BSTR strPropertyName, VARIANT PropertyValue);
    HRESULT getAttribute(BSTR strPropertyName, VARIANT* PropertyValue);
    HRESULT removeAttribute(BSTR strPropertyName);
    HRESULT get_children(IXMLElementCollection* pp);
    HRESULT get_type(int* plType);
    HRESULT get_text(BSTR* p);
    HRESULT put_text(BSTR p);
    HRESULT addChild(IXMLElement pChildElem, int lIndex, int lReserved);
    HRESULT removeChild(IXMLElement pChildElem);
}

@GUID("2B8DE2FF-8D2D-11D1-B2FC-00C04FD915A9")
interface IXMLElement2 : IDispatch
{
    HRESULT get_tagName(BSTR* p);
    HRESULT put_tagName(BSTR p);
    HRESULT get_parent(IXMLElement2* ppParent);
    HRESULT setAttribute(BSTR strPropertyName, VARIANT PropertyValue);
    HRESULT getAttribute(BSTR strPropertyName, VARIANT* PropertyValue);
    HRESULT removeAttribute(BSTR strPropertyName);
    HRESULT get_children(IXMLElementCollection* pp);
    HRESULT get_type(int* plType);
    HRESULT get_text(BSTR* p);
    HRESULT put_text(BSTR p);
    HRESULT addChild(IXMLElement2 pChildElem, int lIndex, int lReserved);
    HRESULT removeChild(IXMLElement2 pChildElem);
    HRESULT get_attributes(IXMLElementCollection* pp);
}

@GUID("D4D4A0FC-3B73-11D1-B2B4-00C04FB92596")
interface IXMLAttribute : IDispatch
{
    HRESULT get_name(BSTR* n);
    HRESULT get_value(BSTR* v);
}

@GUID("948C5AD3-C58D-11D0-9C0B-00C04FC99C8E")
interface IXMLError : IUnknown
{
    HRESULT GetErrorInfo(XML_ERROR* pErrorReturn);
}

@GUID("1BFA0C2C-FBCD-4776-BDA4-88BF974E74F4")
interface ICameraUIControlEventCallback : IUnknown
{
    void OnStartupComplete();
    void OnSuspendComplete();
    void OnItemCaptured(const(wchar)* pszPath);
    void OnItemDeleted(const(wchar)* pszPath);
    void OnClosed();
}

@GUID("B8733ADF-3D68-4B8F-BB08-E28A0BED0376")
interface ICameraUIControl : IUnknown
{
    HRESULT Show(IUnknown pWindow, CameraUIControlMode mode, CameraUIControlLinearSelectionMode selectionMode, 
                 CameraUIControlCaptureMode captureMode, CameraUIControlPhotoFormat photoFormat, 
                 CameraUIControlVideoFormat videoFormat, BOOL bHasCloseButton, 
                 ICameraUIControlEventCallback pEventCallback);
    HRESULT Close();
    HRESULT Suspend(int* pbDeferralRequired);
    HRESULT Resume();
    HRESULT GetCurrentViewType(CameraUIControlViewType* pViewType);
    HRESULT GetActiveItem(BSTR* pbstrActiveItemPath);
    HRESULT GetSelectedItems(SAFEARRAY** ppSelectedItemPaths);
    HRESULT RemoveCapturedItem(const(wchar)* pszPath);
}

@GUID("D3E9E342-5DEB-43B6-849E-6913B85D503A")
interface IEditionUpgradeHelper : IUnknown
{
    HRESULT CanUpgrade(int* isAllowed);
    HRESULT UpdateOperatingSystem(const(wchar)* contentId);
    HRESULT ShowProductKeyUI();
    HRESULT GetOsProductContentId(ushort** contentId);
    HRESULT GetGenuineLocalStatus(int* isGenuine);
}

@GUID("F342D19E-CC22-4648-BB5D-03CCF75B47C5")
interface IWindowsLockModeHelper : IUnknown
{
    HRESULT GetSMode(int* isSmode);
}

@GUID("FF19CBCF-9455-4937-B872-6B7929A460AF")
interface IEditionUpgradeBroker : IUnknown
{
    HRESULT InitializeParentWindow(uint parentHandle);
    HRESULT UpdateOperatingSystem(BSTR parameter);
    HRESULT ShowProductKeyUI();
    HRESULT CanUpgrade();
}

@GUID("B524F93F-80D5-4EC7-AE9E-D66E93ADE1FA")
interface IContainerActivationHelper : IUnknown
{
    HRESULT CanActivateClientVM(short* isAllowed);
}

@GUID("C39948F0-6142-44FD-98CA-E1681A8D68B5")
interface IClipServiceNotificationHelper : IUnknown
{
    HRESULT ShowToast(BSTR titleText, BSTR bodyText, BSTR packageName, BSTR appId, BSTR launchCommand);
}

@GUID("D87965FD-2BAD-4657-BD3B-9567EB300CED")
interface IFhTarget : IUnknown
{
    HRESULT GetStringProperty(FH_TARGET_PROPERTY_TYPE PropertyType, BSTR* PropertyValue);
    HRESULT GetNumericalProperty(FH_TARGET_PROPERTY_TYPE PropertyType, ulong* PropertyValue);
}

@GUID("3197ABCE-532A-44C6-8615-F3666566A720")
interface IFhScopeIterator : IUnknown
{
    HRESULT MoveToNextItem();
    HRESULT GetItem(BSTR* Item);
}

@GUID("6A5FEA5B-BF8F-4EE5-B8C3-44D8A0D7331C")
interface IFhConfigMgr : IUnknown
{
    HRESULT LoadConfiguration();
    HRESULT CreateDefaultConfiguration(BOOL OverwriteIfExists);
    HRESULT SaveConfiguration();
    HRESULT AddRemoveExcludeRule(BOOL Add, FH_PROTECTED_ITEM_CATEGORY Category, BSTR Item);
    HRESULT GetIncludeExcludeRules(BOOL Include, FH_PROTECTED_ITEM_CATEGORY Category, IFhScopeIterator* Iterator);
    HRESULT GetLocalPolicy(FH_LOCAL_POLICY_TYPE LocalPolicyType, ulong* PolicyValue);
    HRESULT SetLocalPolicy(FH_LOCAL_POLICY_TYPE LocalPolicyType, ulong PolicyValue);
    HRESULT GetBackupStatus(FH_BACKUP_STATUS* BackupStatus);
    HRESULT SetBackupStatus(FH_BACKUP_STATUS BackupStatus);
    HRESULT GetDefaultTarget(IFhTarget* DefaultTarget);
    HRESULT ValidateTarget(BSTR TargetUrl, FH_DEVICE_VALIDATION_RESULT* ValidationResult);
    HRESULT ProvisionAndSetNewTarget(BSTR TargetUrl, BSTR TargetName);
    HRESULT ChangeDefaultTargetRecommendation(BOOL Recommend);
    HRESULT QueryProtectionStatus(uint* ProtectionState, BSTR* ProtectedUntilTime);
}

@GUID("6544A28A-F68D-47AC-91EF-16B2B36AA3EE")
interface IFhReassociation : IUnknown
{
    HRESULT ValidateTarget(BSTR TargetUrl, FH_DEVICE_VALIDATION_RESULT* ValidationResult);
    HRESULT ScanTargetForConfigurations(BSTR TargetUrl);
    HRESULT GetConfigurationDetails(uint Index, BSTR* UserName, BSTR* PcName, FILETIME* BackupTime);
    HRESULT SelectConfiguration(uint Index);
    HRESULT PerformReassociation(BOOL OverwriteIfExists);
}

@GUID("2347BBEF-1A3B-45A4-902D-3E09C269B45E")
interface IWaaSAssessor : IUnknown
{
    HRESULT GetOSUpdateAssessment(OSUpdateAssessment* result);
}

@GUID("EAB22AC1-30C1-11CF-A7EB-0000C05BAE0B")
interface IWebBrowser : IDispatch
{
    HRESULT GoBack();
    HRESULT GoForward();
    HRESULT GoHome();
    HRESULT GoSearch();
    HRESULT Navigate(BSTR URL, VARIANT* Flags, VARIANT* TargetFrameName, VARIANT* PostData, VARIANT* Headers);
    HRESULT Refresh();
    HRESULT Refresh2(VARIANT* Level);
    HRESULT Stop();
    HRESULT get_Application(IDispatch* ppDisp);
    HRESULT get_Parent(IDispatch* ppDisp);
    HRESULT get_Container(IDispatch* ppDisp);
    HRESULT get_Document(IDispatch* ppDisp);
    HRESULT get_TopLevelContainer(short* pBool);
    HRESULT get_Type(BSTR* Type);
    HRESULT get_Left(int* pl);
    HRESULT put_Left(int Left);
    HRESULT get_Top(int* pl);
    HRESULT put_Top(int Top);
    HRESULT get_Width(int* pl);
    HRESULT put_Width(int Width);
    HRESULT get_Height(int* pl);
    HRESULT put_Height(int Height);
    HRESULT get_LocationName(BSTR* LocationName);
    HRESULT get_LocationURL(BSTR* LocationURL);
    HRESULT get_Busy(short* pBool);
}

@GUID("EAB22AC2-30C1-11CF-A7EB-0000C05BAE0B")
interface DWebBrowserEvents : IDispatch
{
}

@GUID("0002DF05-0000-0000-C000-000000000046")
interface IWebBrowserApp : IWebBrowser
{
    HRESULT Quit();
    HRESULT ClientToWindow(int* pcx, int* pcy);
    HRESULT PutProperty(BSTR Property, VARIANT vtValue);
    HRESULT GetProperty(BSTR Property, VARIANT* pvtValue);
    HRESULT get_Name(BSTR* Name);
    HRESULT get_HWND(ptrdiff_t* pHWND);
    HRESULT get_FullName(BSTR* FullName);
    HRESULT get_Path(BSTR* Path);
    HRESULT get_Visible(short* pBool);
    HRESULT put_Visible(short Value);
    HRESULT get_StatusBar(short* pBool);
    HRESULT put_StatusBar(short Value);
    HRESULT get_StatusText(BSTR* StatusText);
    HRESULT put_StatusText(BSTR StatusText);
    HRESULT get_ToolBar(int* Value);
    HRESULT put_ToolBar(int Value);
    HRESULT get_MenuBar(short* Value);
    HRESULT put_MenuBar(short Value);
    HRESULT get_FullScreen(short* pbFullScreen);
    HRESULT put_FullScreen(short bFullScreen);
}

@GUID("D30C1661-CDAF-11D0-8A3E-00C04FC9E26E")
interface IWebBrowser2 : IWebBrowserApp
{
    HRESULT Navigate2(VARIANT* URL, VARIANT* Flags, VARIANT* TargetFrameName, VARIANT* PostData, VARIANT* Headers);
    HRESULT QueryStatusWB(OLECMDID cmdID, OLECMDF* pcmdf);
    HRESULT ExecWB(OLECMDID cmdID, OLECMDEXECOPT cmdexecopt, VARIANT* pvaIn, VARIANT* pvaOut);
    HRESULT ShowBrowserBar(VARIANT* pvaClsid, VARIANT* pvarShow, VARIANT* pvarSize);
    HRESULT get_ReadyState(READYSTATE* plReadyState);
    HRESULT get_Offline(short* pbOffline);
    HRESULT put_Offline(short bOffline);
    HRESULT get_Silent(short* pbSilent);
    HRESULT put_Silent(short bSilent);
    HRESULT get_RegisterAsBrowser(short* pbRegister);
    HRESULT put_RegisterAsBrowser(short bRegister);
    HRESULT get_RegisterAsDropTarget(short* pbRegister);
    HRESULT put_RegisterAsDropTarget(short bRegister);
    HRESULT get_TheaterMode(short* pbRegister);
    HRESULT put_TheaterMode(short bRegister);
    HRESULT get_AddressBar(short* Value);
    HRESULT put_AddressBar(short Value);
    HRESULT get_Resizable(short* Value);
    HRESULT put_Resizable(short Value);
}

@GUID("34A715A0-6587-11D0-924A-0020AFC7AC4D")
interface DWebBrowserEvents2 : IDispatch
{
}

@GUID("FE4106E0-399A-11D0-A48C-00A0C90A8F39")
interface DShellWindowsEvents : IDispatch
{
}

@GUID("729FE2F8-1EA8-11D1-8F85-00C04FC2FBE1")
interface IShellUIHelper : IDispatch
{
    HRESULT ResetFirstBootMode();
    HRESULT ResetSafeMode();
    HRESULT RefreshOfflineDesktop();
    HRESULT AddFavorite(BSTR URL, VARIANT* Title);
    HRESULT AddChannel(BSTR URL);
    HRESULT AddDesktopComponent(BSTR URL, BSTR Type, VARIANT* Left, VARIANT* Top, VARIANT* Width, VARIANT* Height);
    HRESULT IsSubscribed(BSTR URL, short* pBool);
    HRESULT NavigateAndFind(BSTR URL, BSTR strQuery, VARIANT* varTargetFrame);
    HRESULT ImportExportFavorites(short fImport, BSTR strImpExpPath);
    HRESULT AutoCompleteSaveForm(VARIANT* Form);
    HRESULT AutoScan(BSTR strSearch, BSTR strFailureUrl, VARIANT* pvarTargetFrame);
    HRESULT AutoCompleteAttach(VARIANT* Reserved);
    HRESULT ShowBrowserUI(BSTR bstrName, VARIANT* pvarIn, VARIANT* pvarOut);
}

@GUID("A7FE6EDA-1932-4281-B881-87B31B8BC52C")
interface IShellUIHelper2 : IShellUIHelper
{
    HRESULT AddSearchProvider(BSTR URL);
    HRESULT RunOnceShown();
    HRESULT SkipRunOnce();
    HRESULT CustomizeSettings(short fSQM, short fPhishing, BSTR bstrLocale);
    HRESULT SqmEnabled(short* pfEnabled);
    HRESULT PhishingEnabled(short* pfEnabled);
    HRESULT BrandImageUri(BSTR* pbstrUri);
    HRESULT SkipTabsWelcome();
    HRESULT DiagnoseConnection();
    HRESULT CustomizeClearType(short fSet);
    HRESULT IsSearchProviderInstalled(BSTR URL, uint* pdwResult);
    HRESULT IsSearchMigrated(short* pfMigrated);
    HRESULT DefaultSearchProvider(BSTR* pbstrName);
    HRESULT RunOnceRequiredSettingsComplete(short fComplete);
    HRESULT RunOnceHasShown(short* pfShown);
    HRESULT SearchGuideUrl(BSTR* pbstrUrl);
}

@GUID("528DF2EC-D419-40BC-9B6D-DCDBF9C1B25D")
interface IShellUIHelper3 : IShellUIHelper2
{
    HRESULT AddService(BSTR URL);
    HRESULT IsServiceInstalled(BSTR URL, BSTR Verb, uint* pdwResult);
    HRESULT InPrivateFilteringEnabled(short* pfEnabled);
    HRESULT AddToFavoritesBar(BSTR URL, BSTR Title, VARIANT* Type);
    HRESULT BuildNewTabPage();
    HRESULT SetRecentlyClosedVisible(short fVisible);
    HRESULT SetActivitiesVisible(short fVisible);
    HRESULT ContentDiscoveryReset();
    HRESULT IsSuggestedSitesEnabled(short* pfEnabled);
    HRESULT EnableSuggestedSites(short fEnable);
    HRESULT NavigateToSuggestedSites(BSTR bstrRelativeUrl);
    HRESULT ShowTabsHelp();
    HRESULT ShowInPrivateHelp();
}

@GUID("B36E6A53-8073-499E-824C-D776330A333E")
interface IShellUIHelper4 : IShellUIHelper3
{
    HRESULT msIsSiteMode(short* pfSiteMode);
    HRESULT msSiteModeShowThumbBar();
    HRESULT msSiteModeAddThumbBarButton(BSTR bstrIconURL, BSTR bstrTooltip, VARIANT* pvarButtonID);
    HRESULT msSiteModeUpdateThumbBarButton(VARIANT ButtonID, short fEnabled, short fVisible);
    HRESULT msSiteModeSetIconOverlay(BSTR IconUrl, VARIANT* pvarDescription);
    HRESULT msSiteModeClearIconOverlay();
    HRESULT msAddSiteMode();
    HRESULT msSiteModeCreateJumpList(BSTR bstrHeader);
    HRESULT msSiteModeAddJumpListItem(BSTR bstrName, BSTR bstrActionUri, BSTR bstrIconUri, VARIANT* pvarWindowType);
    HRESULT msSiteModeClearJumpList();
    HRESULT msSiteModeShowJumpList();
    HRESULT msSiteModeAddButtonStyle(VARIANT uiButtonID, BSTR bstrIconUrl, BSTR bstrTooltip, VARIANT* pvarStyleID);
    HRESULT msSiteModeShowButtonStyle(VARIANT uiButtonID, VARIANT uiStyleID);
    HRESULT msSiteModeActivate();
    HRESULT msIsSiteModeFirstRun(short fPreserveState, VARIANT* puiFirstRun);
    HRESULT msAddTrackingProtectionList(BSTR URL, BSTR bstrFilterName);
    HRESULT msTrackingProtectionEnabled(short* pfEnabled);
    HRESULT msActiveXFilteringEnabled(short* pfEnabled);
}

@GUID("A2A08B09-103D-4D3F-B91C-EA455CA82EFA")
interface IShellUIHelper5 : IShellUIHelper4
{
    HRESULT msProvisionNetworks(BSTR bstrProvisioningXml, VARIANT* puiResult);
    HRESULT msReportSafeUrl();
    HRESULT msSiteModeRefreshBadge();
    HRESULT msSiteModeClearBadge();
    HRESULT msDiagnoseConnectionUILess();
    HRESULT msLaunchNetworkClientHelp();
    HRESULT msChangeDefaultBrowser(short fChange);
}

@GUID("987A573E-46EE-4E89-96AB-DDF7F8FDC98C")
interface IShellUIHelper6 : IShellUIHelper5
{
    HRESULT msStopPeriodicTileUpdate();
    HRESULT msStartPeriodicTileUpdate(VARIANT pollingUris, VARIANT startTime, VARIANT uiUpdateRecurrence);
    HRESULT msStartPeriodicTileUpdateBatch(VARIANT pollingUris, VARIANT startTime, VARIANT uiUpdateRecurrence);
    HRESULT msClearTile();
    HRESULT msEnableTileNotificationQueue(short fChange);
    HRESULT msPinnedSiteState(VARIANT* pvarSiteState);
    HRESULT msEnableTileNotificationQueueForSquare150x150(short fChange);
    HRESULT msEnableTileNotificationQueueForWide310x150(short fChange);
    HRESULT msEnableTileNotificationQueueForSquare310x310(short fChange);
    HRESULT msScheduledTileNotification(BSTR bstrNotificationXml, BSTR bstrNotificationId, 
                                        BSTR bstrNotificationTag, VARIANT startTime, VARIANT expirationTime);
    HRESULT msRemoveScheduledTileNotification(BSTR bstrNotificationId);
    HRESULT msStartPeriodicBadgeUpdate(BSTR pollingUri, VARIANT startTime, VARIANT uiUpdateRecurrence);
    HRESULT msStopPeriodicBadgeUpdate();
    HRESULT msLaunchInternetOptions();
}

@GUID("60E567C8-9573-4AB2-A264-637C6C161CB1")
interface IShellUIHelper7 : IShellUIHelper6
{
    HRESULT SetExperimentalFlag(BSTR bstrFlagString, short vfFlag);
    HRESULT GetExperimentalFlag(BSTR bstrFlagString, short* vfFlag);
    HRESULT SetExperimentalValue(BSTR bstrValueString, uint dwValue);
    HRESULT GetExperimentalValue(BSTR bstrValueString, uint* pdwValue);
    HRESULT ResetAllExperimentalFlagsAndValues();
    HRESULT GetNeedIEAutoLaunchFlag(BSTR bstrUrl, short* flag);
    HRESULT SetNeedIEAutoLaunchFlag(BSTR bstrUrl, short flag);
    HRESULT HasNeedIEAutoLaunchFlag(BSTR bstrUrl, short* exists);
    HRESULT LaunchIE(BSTR bstrUrl, short automated);
}

@GUID("66DEBCF2-05B0-4F07-B49B-B96241A65DB2")
interface IShellUIHelper8 : IShellUIHelper7
{
    HRESULT GetCVListData(BSTR* pbstrResult);
    HRESULT GetCVListLocalData(BSTR* pbstrResult);
    HRESULT GetEMIEListData(BSTR* pbstrResult);
    HRESULT GetEMIEListLocalData(BSTR* pbstrResult);
    HRESULT OpenFavoritesPane();
    HRESULT OpenFavoritesSettings();
    HRESULT LaunchInHVSI(BSTR bstrUrl);
}

@GUID("6CDF73B0-7F2F-451F-BC0F-63E0F3284E54")
interface IShellUIHelper9 : IShellUIHelper8
{
    HRESULT GetOSSku(uint* pdwResult);
}

@GUID("55136806-B2DE-11D1-B9F2-00A0C98BC547")
interface DShellNameSpaceEvents : IDispatch
{
}

@GUID("55136804-B2DE-11D1-B9F2-00A0C98BC547")
interface IShellFavoritesNameSpace : IDispatch
{
    HRESULT MoveSelectionUp();
    HRESULT MoveSelectionDown();
    HRESULT ResetSort();
    HRESULT NewFolder();
    HRESULT Synchronize();
    HRESULT Import();
    HRESULT Export();
    HRESULT InvokeContextMenuCommand(BSTR strCommand);
    HRESULT MoveSelectionTo();
    HRESULT get_SubscriptionsEnabled(short* pBool);
    HRESULT CreateSubscriptionForSelection(short* pBool);
    HRESULT DeleteSubscriptionForSelection(short* pBool);
    HRESULT SetRoot(BSTR bstrFullPath);
}

@GUID("E572D3C9-37BE-4AE2-825D-D521763E3108")
interface IShellNameSpace : IShellFavoritesNameSpace
{
    HRESULT get_EnumOptions(int* pgrfEnumFlags);
    HRESULT put_EnumOptions(int lVal);
    HRESULT get_SelectedItem(IDispatch* pItem);
    HRESULT put_SelectedItem(IDispatch pItem);
    HRESULT get_Root(VARIANT* pvar);
    HRESULT put_Root(VARIANT var);
    HRESULT get_Depth(int* piDepth);
    HRESULT put_Depth(int iDepth);
    HRESULT get_Mode(uint* puMode);
    HRESULT put_Mode(uint uMode);
    HRESULT get_Flags(uint* pdwFlags);
    HRESULT put_Flags(uint dwFlags);
    HRESULT put_TVFlags(uint dwFlags);
    HRESULT get_TVFlags(uint* dwFlags);
    HRESULT get_Columns(BSTR* bstrColumns);
    HRESULT put_Columns(BSTR bstrColumns);
    HRESULT get_CountViewTypes(int* piTypes);
    HRESULT SetViewType(int iType);
    HRESULT SelectedItems(IDispatch* ppid);
    HRESULT Expand(VARIANT var, int iDepth);
    HRESULT UnselectAll();
}

@GUID("F3470F24-15FD-11D2-BB2E-00805FF7EFCA")
interface IScriptErrorList : IDispatch
{
    HRESULT advanceError();
    HRESULT retreatError();
    HRESULT canAdvanceError(int* pfCanAdvance);
    HRESULT canRetreatError(int* pfCanRetreat);
    HRESULT getErrorLine(int* plLine);
    HRESULT getErrorChar(int* plChar);
    HRESULT getErrorCode(int* plCode);
    HRESULT getErrorMsg(BSTR* pstr);
    HRESULT getErrorUrl(BSTR* pstr);
    HRESULT getAlwaysShowLockState(int* pfAlwaysShowLocked);
    HRESULT getDetailsPaneOpen(int* pfDetailsPaneOpen);
    HRESULT setDetailsPaneOpen(BOOL fDetailsPaneOpen);
    HRESULT getPerErrorDisplay(int* pfPerErrorDisplay);
    HRESULT setPerErrorDisplay(BOOL fPerErrorDisplay);
}

@GUID("F686878F-7B42-4CC4-96FB-F4F3B6E3D24D")
interface IIsolatedAppLauncher : IUnknown
{
    HRESULT Launch(const(wchar)* appUserModelId, const(wchar)* arguments, 
                   const(IsolatedAppLauncherTelemetryParameters)* telemetryParameters);
}

@GUID("8C38232E-3A45-4A27-92B0-1A16A975F669")
interface IWscProduct : IDispatch
{
    HRESULT get_ProductName(BSTR* pVal);
    HRESULT get_ProductState(WSC_SECURITY_PRODUCT_STATE* pVal);
    HRESULT get_SignatureStatus(WSC_SECURITY_SIGNATURE_STATUS* pVal);
    HRESULT get_RemediationPath(BSTR* pVal);
    HRESULT get_ProductStateTimestamp(BSTR* pVal);
    HRESULT get_ProductGuid(BSTR* pVal);
    HRESULT get_ProductIsDefault(int* pVal);
}

@GUID("F896CA54-FE09-4403-86D4-23CB488D81D8")
interface IWscProduct2 : IWscProduct
{
    HRESULT get_AntivirusScanSubstatus(WSC_SECURITY_PRODUCT_SUBSTATUS* peStatus);
    HRESULT get_AntivirusSettingsSubstatus(WSC_SECURITY_PRODUCT_SUBSTATUS* peStatus);
    HRESULT get_AntivirusProtectionUpdateSubstatus(WSC_SECURITY_PRODUCT_SUBSTATUS* peStatus);
    HRESULT get_FirewallDomainProfileSubstatus(WSC_SECURITY_PRODUCT_SUBSTATUS* peStatus);
    HRESULT get_FirewallPrivateProfileSubstatus(WSC_SECURITY_PRODUCT_SUBSTATUS* peStatus);
    HRESULT get_FirewallPublicProfileSubstatus(WSC_SECURITY_PRODUCT_SUBSTATUS* peStatus);
}

@GUID("55536524-D1D1-4726-8C7C-04996A1904E7")
interface IWscProduct3 : IWscProduct2
{
    HRESULT get_AntivirusDaysUntilExpired(uint* pdwDays);
}

@GUID("722A338C-6E8E-4E72-AC27-1417FB0C81C2")
interface IWSCProductList : IDispatch
{
    HRESULT Initialize(uint provider);
    HRESULT get_Count(int* pVal);
    HRESULT get_Item(uint index, IWscProduct* pVal);
}

@GUID("0476D69C-F21A-11E5-9CE9-5E5517507C66")
interface IWSCDefaultProduct : IDispatch
{
    HRESULT SetDefaultProduct(SECURITY_PRODUCT_TYPE eType, BSTR pGuid);
}

@GUID("7279FC81-709D-4095-B63D-69FE4B0D9030")
interface IXmlReader : IUnknown
{
    HRESULT SetInput(IUnknown pInput);
    HRESULT GetProperty(uint nProperty, ptrdiff_t* ppValue);
    HRESULT SetProperty(uint nProperty, ptrdiff_t pValue);
    HRESULT Read(XmlNodeType* pNodeType);
    HRESULT GetNodeType(XmlNodeType* pNodeType);
    HRESULT MoveToFirstAttribute();
    HRESULT MoveToNextAttribute();
    HRESULT MoveToAttributeByName(const(wchar)* pwszLocalName, const(wchar)* pwszNamespaceUri);
    HRESULT MoveToElement();
    HRESULT GetQualifiedName(ushort** ppwszQualifiedName, uint* pcwchQualifiedName);
    HRESULT GetNamespaceUri(ushort** ppwszNamespaceUri, uint* pcwchNamespaceUri);
    HRESULT GetLocalName(ushort** ppwszLocalName, uint* pcwchLocalName);
    HRESULT GetPrefix(ushort** ppwszPrefix, uint* pcwchPrefix);
    HRESULT GetValue(ushort** ppwszValue, uint* pcwchValue);
    HRESULT ReadValueChunk(char* pwchBuffer, uint cwchChunkSize, uint* pcwchRead);
    HRESULT GetBaseUri(ushort** ppwszBaseUri, uint* pcwchBaseUri);
    BOOL    IsDefault();
    BOOL    IsEmptyElement();
    HRESULT GetLineNumber(uint* pnLineNumber);
    HRESULT GetLinePosition(uint* pnLinePosition);
    HRESULT GetAttributeCount(uint* pnAttributeCount);
    HRESULT GetDepth(uint* pnDepth);
    BOOL    IsEOF();
}

@GUID("7279FC82-709D-4095-B63D-69FE4B0D9030")
interface IXmlResolver : IUnknown
{
    HRESULT ResolveUri(const(wchar)* pwszBaseUri, const(wchar)* pwszPublicIdentifier, 
                       const(wchar)* pwszSystemIdentifier, IUnknown* ppResolvedInput);
}

@GUID("7279FC88-709D-4095-B63D-69FE4B0D9030")
interface IXmlWriter : IUnknown
{
    HRESULT SetOutput(IUnknown pOutput);
    HRESULT GetProperty(uint nProperty, ptrdiff_t* ppValue);
    HRESULT SetProperty(uint nProperty, ptrdiff_t pValue);
    HRESULT WriteAttributes(IXmlReader pReader, BOOL fWriteDefaultAttributes);
    HRESULT WriteAttributeString(const(wchar)* pwszPrefix, const(wchar)* pwszLocalName, 
                                 const(wchar)* pwszNamespaceUri, const(wchar)* pwszValue);
    HRESULT WriteCData(const(wchar)* pwszText);
    HRESULT WriteCharEntity(ushort wch);
    HRESULT WriteChars(const(wchar)* pwch, uint cwch);
    HRESULT WriteComment(const(wchar)* pwszComment);
    HRESULT WriteDocType(const(wchar)* pwszName, const(wchar)* pwszPublicId, const(wchar)* pwszSystemId, 
                         const(wchar)* pwszSubset);
    HRESULT WriteElementString(const(wchar)* pwszPrefix, const(wchar)* pwszLocalName, 
                               const(wchar)* pwszNamespaceUri, const(wchar)* pwszValue);
    HRESULT WriteEndDocument();
    HRESULT WriteEndElement();
    HRESULT WriteEntityRef(const(wchar)* pwszName);
    HRESULT WriteFullEndElement();
    HRESULT WriteName(const(wchar)* pwszName);
    HRESULT WriteNmToken(const(wchar)* pwszNmToken);
    HRESULT WriteNode(IXmlReader pReader, BOOL fWriteDefaultAttributes);
    HRESULT WriteNodeShallow(IXmlReader pReader, BOOL fWriteDefaultAttributes);
    HRESULT WriteProcessingInstruction(const(wchar)* pwszName, const(wchar)* pwszText);
    HRESULT WriteQualifiedName(const(wchar)* pwszLocalName, const(wchar)* pwszNamespaceUri);
    HRESULT WriteRaw(const(wchar)* pwszData);
    HRESULT WriteRawChars(const(wchar)* pwch, uint cwch);
    HRESULT WriteStartDocument(XmlStandalone standalone);
    HRESULT WriteStartElement(const(wchar)* pwszPrefix, const(wchar)* pwszLocalName, 
                              const(wchar)* pwszNamespaceUri);
    HRESULT WriteString(const(wchar)* pwszText);
    HRESULT WriteSurrogateCharEntity(ushort wchLow, ushort wchHigh);
    HRESULT WriteWhitespace(const(wchar)* pwszWhitespace);
    HRESULT Flush();
}

@GUID("862494C6-1310-4AAD-B3CD-2DBEEBF670D3")
interface IXmlWriterLite : IUnknown
{
    HRESULT SetOutput(IUnknown pOutput);
    HRESULT GetProperty(uint nProperty, ptrdiff_t* ppValue);
    HRESULT SetProperty(uint nProperty, ptrdiff_t pValue);
    HRESULT WriteAttributes(IXmlReader pReader, BOOL fWriteDefaultAttributes);
    HRESULT WriteAttributeString(const(wchar)* pwszQName, uint cwszQName, const(wchar)* pwszValue, uint cwszValue);
    HRESULT WriteCData(const(wchar)* pwszText);
    HRESULT WriteCharEntity(ushort wch);
    HRESULT WriteChars(const(wchar)* pwch, uint cwch);
    HRESULT WriteComment(const(wchar)* pwszComment);
    HRESULT WriteDocType(const(wchar)* pwszName, const(wchar)* pwszPublicId, const(wchar)* pwszSystemId, 
                         const(wchar)* pwszSubset);
    HRESULT WriteElementString(const(wchar)* pwszQName, uint cwszQName, const(wchar)* pwszValue);
    HRESULT WriteEndDocument();
    HRESULT WriteEndElement(const(wchar)* pwszQName, uint cwszQName);
    HRESULT WriteEntityRef(const(wchar)* pwszName);
    HRESULT WriteFullEndElement(const(wchar)* pwszQName, uint cwszQName);
    HRESULT WriteName(const(wchar)* pwszName);
    HRESULT WriteNmToken(const(wchar)* pwszNmToken);
    HRESULT WriteNode(IXmlReader pReader, BOOL fWriteDefaultAttributes);
    HRESULT WriteNodeShallow(IXmlReader pReader, BOOL fWriteDefaultAttributes);
    HRESULT WriteProcessingInstruction(const(wchar)* pwszName, const(wchar)* pwszText);
    HRESULT WriteRaw(const(wchar)* pwszData);
    HRESULT WriteRawChars(const(wchar)* pwch, uint cwch);
    HRESULT WriteStartDocument(XmlStandalone standalone);
    HRESULT WriteStartElement(const(wchar)* pwszQName, uint cwszQName);
    HRESULT WriteString(const(wchar)* pwszText);
    HRESULT WriteSurrogateCharEntity(ushort wchLow, ushort wchHigh);
    HRESULT WriteWhitespace(const(wchar)* pwszWhitespace);
    HRESULT Flush();
}


// GUIDs

const GUID CLSID_CScriptErrorList        = GUIDOF!CScriptErrorList;
const GUID CLSID_CameraUIControl         = GUIDOF!CameraUIControl;
const GUID CLSID_DOMDocument             = GUIDOF!DOMDocument;
const GUID CLSID_DOMFreeThreadedDocument = GUIDOF!DOMFreeThreadedDocument;
const GUID CLSID_EditionUpgradeBroker    = GUIDOF!EditionUpgradeBroker;
const GUID CLSID_EditionUpgradeHelper    = GUIDOF!EditionUpgradeHelper;
const GUID CLSID_FhConfigMgr             = GUIDOF!FhConfigMgr;
const GUID CLSID_FhReassociation         = GUIDOF!FhReassociation;
const GUID CLSID_InternetExplorer        = GUIDOF!InternetExplorer;
const GUID CLSID_InternetExplorerMedium  = GUIDOF!InternetExplorerMedium;
const GUID CLSID_IsolatedAppLauncher     = GUIDOF!IsolatedAppLauncher;
const GUID CLSID_ShellBrowserWindow      = GUIDOF!ShellBrowserWindow;
const GUID CLSID_ShellNameSpace          = GUIDOF!ShellNameSpace;
const GUID CLSID_ShellUIHelper           = GUIDOF!ShellUIHelper;
const GUID CLSID_ShellWindows            = GUIDOF!ShellWindows;
const GUID CLSID_WSCDefaultProduct       = GUIDOF!WSCDefaultProduct;
const GUID CLSID_WSCProductList          = GUIDOF!WSCProductList;
const GUID CLSID_WaaSAssessor            = GUIDOF!WaaSAssessor;
const GUID CLSID_WebBrowser              = GUIDOF!WebBrowser;
const GUID CLSID_WebBrowser_V1           = GUIDOF!WebBrowser_V1;
const GUID CLSID_XMLDSOControl           = GUIDOF!XMLDSOControl;
const GUID CLSID_XMLDocument             = GUIDOF!XMLDocument;
const GUID CLSID_XMLHTTPRequest          = GUIDOF!XMLHTTPRequest;

const GUID IID_DShellNameSpaceEvents          = GUIDOF!DShellNameSpaceEvents;
const GUID IID_DShellWindowsEvents            = GUIDOF!DShellWindowsEvents;
const GUID IID_DWebBrowserEvents              = GUIDOF!DWebBrowserEvents;
const GUID IID_DWebBrowserEvents2             = GUIDOF!DWebBrowserEvents2;
const GUID IID_ICameraUIControl               = GUIDOF!ICameraUIControl;
const GUID IID_ICameraUIControlEventCallback  = GUIDOF!ICameraUIControlEventCallback;
const GUID IID_IClipServiceNotificationHelper = GUIDOF!IClipServiceNotificationHelper;
const GUID IID_IContainerActivationHelper     = GUIDOF!IContainerActivationHelper;
const GUID IID_IEditionUpgradeBroker          = GUIDOF!IEditionUpgradeBroker;
const GUID IID_IEditionUpgradeHelper          = GUIDOF!IEditionUpgradeHelper;
const GUID IID_IFhConfigMgr                   = GUIDOF!IFhConfigMgr;
const GUID IID_IFhReassociation               = GUIDOF!IFhReassociation;
const GUID IID_IFhScopeIterator               = GUIDOF!IFhScopeIterator;
const GUID IID_IFhTarget                      = GUIDOF!IFhTarget;
const GUID IID_IIsolatedAppLauncher           = GUIDOF!IIsolatedAppLauncher;
const GUID IID_IScriptErrorList               = GUIDOF!IScriptErrorList;
const GUID IID_IShellFavoritesNameSpace       = GUIDOF!IShellFavoritesNameSpace;
const GUID IID_IShellNameSpace                = GUIDOF!IShellNameSpace;
const GUID IID_IShellUIHelper                 = GUIDOF!IShellUIHelper;
const GUID IID_IShellUIHelper2                = GUIDOF!IShellUIHelper2;
const GUID IID_IShellUIHelper3                = GUIDOF!IShellUIHelper3;
const GUID IID_IShellUIHelper4                = GUIDOF!IShellUIHelper4;
const GUID IID_IShellUIHelper5                = GUIDOF!IShellUIHelper5;
const GUID IID_IShellUIHelper6                = GUIDOF!IShellUIHelper6;
const GUID IID_IShellUIHelper7                = GUIDOF!IShellUIHelper7;
const GUID IID_IShellUIHelper8                = GUIDOF!IShellUIHelper8;
const GUID IID_IShellUIHelper9                = GUIDOF!IShellUIHelper9;
const GUID IID_IWSCDefaultProduct             = GUIDOF!IWSCDefaultProduct;
const GUID IID_IWSCProductList                = GUIDOF!IWSCProductList;
const GUID IID_IWaaSAssessor                  = GUIDOF!IWaaSAssessor;
const GUID IID_IWebBrowser                    = GUIDOF!IWebBrowser;
const GUID IID_IWebBrowser2                   = GUIDOF!IWebBrowser2;
const GUID IID_IWebBrowserApp                 = GUIDOF!IWebBrowserApp;
const GUID IID_IWindowsLockModeHelper         = GUIDOF!IWindowsLockModeHelper;
const GUID IID_IWscProduct                    = GUIDOF!IWscProduct;
const GUID IID_IWscProduct2                   = GUIDOF!IWscProduct2;
const GUID IID_IWscProduct3                   = GUIDOF!IWscProduct3;
const GUID IID_IXMLAttribute                  = GUIDOF!IXMLAttribute;
const GUID IID_IXMLDOMAttribute               = GUIDOF!IXMLDOMAttribute;
const GUID IID_IXMLDOMCDATASection            = GUIDOF!IXMLDOMCDATASection;
const GUID IID_IXMLDOMCharacterData           = GUIDOF!IXMLDOMCharacterData;
const GUID IID_IXMLDOMComment                 = GUIDOF!IXMLDOMComment;
const GUID IID_IXMLDOMDocument                = GUIDOF!IXMLDOMDocument;
const GUID IID_IXMLDOMDocumentFragment        = GUIDOF!IXMLDOMDocumentFragment;
const GUID IID_IXMLDOMDocumentType            = GUIDOF!IXMLDOMDocumentType;
const GUID IID_IXMLDOMElement                 = GUIDOF!IXMLDOMElement;
const GUID IID_IXMLDOMEntity                  = GUIDOF!IXMLDOMEntity;
const GUID IID_IXMLDOMEntityReference         = GUIDOF!IXMLDOMEntityReference;
const GUID IID_IXMLDOMImplementation          = GUIDOF!IXMLDOMImplementation;
const GUID IID_IXMLDOMNamedNodeMap            = GUIDOF!IXMLDOMNamedNodeMap;
const GUID IID_IXMLDOMNode                    = GUIDOF!IXMLDOMNode;
const GUID IID_IXMLDOMNodeList                = GUIDOF!IXMLDOMNodeList;
const GUID IID_IXMLDOMNotation                = GUIDOF!IXMLDOMNotation;
const GUID IID_IXMLDOMParseError              = GUIDOF!IXMLDOMParseError;
const GUID IID_IXMLDOMProcessingInstruction   = GUIDOF!IXMLDOMProcessingInstruction;
const GUID IID_IXMLDOMText                    = GUIDOF!IXMLDOMText;
const GUID IID_IXMLDSOControl                 = GUIDOF!IXMLDSOControl;
const GUID IID_IXMLDocument                   = GUIDOF!IXMLDocument;
const GUID IID_IXMLDocument2                  = GUIDOF!IXMLDocument2;
const GUID IID_IXMLElement                    = GUIDOF!IXMLElement;
const GUID IID_IXMLElement2                   = GUIDOF!IXMLElement2;
const GUID IID_IXMLElementCollection          = GUIDOF!IXMLElementCollection;
const GUID IID_IXMLError                      = GUIDOF!IXMLError;
const GUID IID_IXMLHttpRequest                = GUIDOF!IXMLHttpRequest;
const GUID IID_IXTLRuntime                    = GUIDOF!IXTLRuntime;
const GUID IID_IXmlReader                     = GUIDOF!IXmlReader;
const GUID IID_IXmlResolver                   = GUIDOF!IXmlResolver;
const GUID IID_IXmlWriter                     = GUIDOF!IXmlWriter;
const GUID IID_IXmlWriterLite                 = GUIDOF!IXmlWriterLite;
const GUID IID_XMLDOMDocumentEvents           = GUIDOF!XMLDOMDocumentEvents;
