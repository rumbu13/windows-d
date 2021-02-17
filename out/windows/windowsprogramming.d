// Written in the D programming language.

module windows.windowsprogramming;

public import windows.core;
public import windows.automation : BSTR, IDispatch, SAFEARRAY, VARIANT;
public import windows.com : HRESULT, IBindCtx, IMalloc, IUnknown, OLECMDEXECOPT,
                            OLECMDF, OLECMDID, QUERYCONTEXT;
public import windows.coreaudio : DDVIDEOPORTCONNECT;
public import windows.dbg : CONTEXT, DEBUG_EVENT, EXCEPTION_RECORD, LDT_ENTRY;
public import windows.direct2d : PALETTEENTRY;
public import windows.directdraw : DDBLTFX, DDCOLORCONTROL, DDGAMMARAMP, DDOVERLAYFX,
                                   DDPIXELFORMAT, DDSCAPS, DDSCAPS2, DDSCAPSEX,
                                   DDSURFACEDESC, DDSURFACEDESC2;
public import windows.directshow : DDCOLORKEY, READYSTATE;
public import windows.displaydevices : DDCORECAPS, DDHAL_DESTROYDDLOCALDATA,
                                       DDHAL_WAITFORVERTICALBLANKDATA, DDKERNELCAPS,
                                       DDVIDEOPORTBANDWIDTH, DDVIDEOPORTCAPS,
                                       DDVIDEOPORTDESC, DDVIDEOPORTINFO,
                                       HEAPALIGNMENT, RECT, RECTL, VMEMHEAP;
public import windows.gdi : HDC, HPALETTE, RGNDATA;
public import windows.kernel : LIST_ENTRY;
public import windows.rpc : MIDL_STUB_MESSAGE;
public import windows.security : GENERIC_MAPPING, PRIVILEGE_SET, UNICODE_STRING;
public import windows.systemservices : BOOL, CUSTOM_SYSTEM_EVENT_TRIGGER_CONFIG,
                                       DEVPROPCOMPKEY, DEVPROPERTY, DEVPROPKEY,
                                       DEVPROPSTORE, FLOATING_SAVE_AREA, HANDLE,
                                       HINSTANCE, JOB_SET_ARRAY, LARGE_INTEGER,
                                       LPTHREAD_START_ROUTINE, LRESULT, LSTATUS,
                                       NTSTATUS, PEB, PROCESS_DYNAMIC_EH_CONTINUATION_TARGET,
                                       SECURITY_ATTRIBUTES, STARTUPINFOA,
                                       SYSTEM_CPU_SET_INFORMATION, WAITORTIMERCALLBACK,
                                       uCLSSPEC;
public import windows.windowsandmessaging : HWND, LPARAM, WPARAM;

extern(Windows):


// Enums


alias PROCESS_CREATION_FLAGS = uint;
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

alias HANDLE_FLAG_OPTIONS = int;
enum : int
{
    HANDLE_FLAG_INHERIT            = 0x00000001,
    HANDLE_FLAG_PROTECT_FROM_CLOSE = 0x00000002,
}

alias DUPLICATE_HANDLE_OPTIONS = int;
enum : int
{
    DUPLICATE_CLOSE_SOURCE = 0x00000001,
    DUPLICATE_SAME_ACCESS  = 0x00000002,
}

alias STD_HANDLE_TYPE = uint;
enum : uint
{
    STD_INPUT_HANDLE  = 0xfffffff6,
    STD_OUTPUT_HANDLE = 0xfffffff5,
    STD_ERROR_HANDLE  = 0xfffffff4,
}

alias VER_FLAGS = uint;
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

///Specifies a firmware type.
alias FIRMWARE_TYPE = int;
enum : int
{
    ///The firmware type is unknown.
    FirmwareTypeUnknown = 0x00000000,
    ///The computer booted in legacy BIOS mode.
    FirmwareTypeBios    = 0x00000001,
    ///The computer booted in UEFI mode.
    FirmwareTypeUefi    = 0x00000002,
    ///Not implemented.
    FirmwareTypeMax     = 0x00000003,
}

///Indicates a high, medium, or low impact of a device running an out-of-date OS. This enumeration is generally used by
///UpdateAssessment structures, which is in turn nested inside the returned OSUpdateAssessment from
///GetOSUpdateAssessment.
enum UpdateImpactLevel : int
{
    ///There is no foreseeable impact to your device. This can be because the device is up-to-date, or is not up-to-date
    ///because the device is honoring its Windows Update for Business deferral periods, or is out-of-date but has not
    ///yet reached the <b>daysOutOfDate</b> threshold to reach a higher impact level.
    UpdateImpactLevel_None   = 0x00000000,
    ///The device is not running the latest OS, but has a recent update.
    UpdateImpactLevel_Low    = 0x00000001,
    ///The device is running the latest OS, but has a moderately recent update.
    UpdateImpactLevel_Medium = 0x00000002,
    ///The device has been out-of-date for a long time. This device may have security vulnerabilities and may be missing
    ///important fixes that make Windows run better. When a device is running a version of Windows that is no longer
    ///supported, <b>UpdateImpactLevel_High</b> is always returned.
    UpdateImpactLevel_High   = 0x00000003,
}

///Describes how up-to-date the OS on a device is. <b>UpdateAssessmentStatus</b> is used by the UpdateAssessment and
///OSUpdateAssessment structures, in the <b>assessmentForCurrent</b>, <b>assessmentForUpToDate</b>, and
///<b>securityStatus</b> members. Exactly one constant is returned.
enum UpdateAssessmentStatus : int
{
    ///This result within <b>assessmentForCurrent</b> implies that the device is on the latest feature update and
    ///quality update available for that device. Within <b>assessmentForUpToDate</b>, this result implies that the
    ///device is on the latest quality update for the release of Windows it is running.
    UpdateAssessmentStatus_Latest                   = 0x00000000,
    ///The latest feature update has not been installed due to a soft restriction. When a soft restriction has been
    ///placed on an update, the update will not be automatically installed; a user must self-initiate the download
    ///within the Update UX. This status only applies to <b>assessmentForCurrent</b>.
    UpdateAssessmentStatus_NotLatestSoftRestriction = 0x00000001,
    ///The latest feature update has not been installed due to a hard restriction. When a hard restriction has been
    ///placed on an update, the update is not applicable to the device. This status only applies to
    ///<b>assessmentForCurrent</b>.
    UpdateAssessmentStatus_NotLatestHardRestriction = 0x00000002,
    ///The device is not on the latest update because the device's feature update is no longer supported by Microsoft.
    ///When Microsoft stops supporting a feature release, this status will be returned for both
    ///<b>assessmentForCurrent</b> and <b>assessmentForUpToDate</b>. <div class="alert"><b>Note</b> When
    ///<b>UpdateAssessmentStatus_NotLatestEndOfSupport</b> is returned, the assessment's <b>UpdateImpactLevel</b> is
    ///always <b>UpdateImpactLevel_High</b>.</div> <div> </div>
    UpdateAssessmentStatus_NotLatestEndOfSupport    = 0x00000003,
    ///The device is not on the latest feature update because the device's servicing train limits the device from
    ///updating to the latest feature update. For example: if a device is on Current Branch for Business (CBB) and a new
    ///feature update has been released for Current Branch (CB), this will be returned. This status only applies to
    ///<b>assessmentForCurrent</b>.
    UpdateAssessmentStatus_NotLatestServicingTrain  = 0x00000004,
    ///The latest feature update has not been installed due to the device's Windows Update for Business Feature Update
    ///Deferral policy. Determining <b>daysOutOfDate</b> takes into account deferral policies; <b>daysOutOfDate</b> will
    ///not begin incrementing until the deferral period has expired. This status only applies to
    ///<b>assessmentForCurrent</b>.
    UpdateAssessmentStatus_NotLatestDeferredFeature = 0x00000005,
    ///The device is not on the latest quality update due to the device's Windows Update for Business Quality Update
    ///Deferral policy. Determining <b>daysOutOfDate</b> takes into account deferral policies; <b>daysOutOfDate</b> will
    ///not begin incrementing until the deferral period has expired.
    UpdateAssessmentStatus_NotLatestDeferredQuality = 0x00000006,
    ///The device is not on the latest feature update due to the device having paused Feature Updates. Whether a device
    ///is paused is not factored into the calculation of <b>daysOutOfDate</b>. This status only applies to
    ///<b>assessmentForCurrent</b>.
    UpdateAssessmentStatus_NotLatestPausedFeature   = 0x00000007,
    ///The device is not on the latest quality update due to the device having paused Quality Updates. Whether a device
    ///is paused is not factored into the calculation of <b>daysOutOfDate</b>. <b>daysOutOfDate</b> does not factor
    ///whether a device is paused into its calculation.
    UpdateAssessmentStatus_NotLatestPausedQuality   = 0x00000008,
    ///The device is not on the latest update because the approval of updates is not done through Windows Update.
    UpdateAssessmentStatus_NotLatestManaged         = 0x00000009,
    ///The device is not on the latest update due to a reason that cannot be determined by the assessment.
    UpdateAssessmentStatus_NotLatestUnknown         = 0x0000000a,
    ///The device is not on the latest feature update due to the device's Windows Update for Business Target Version
    ///policy. This policy is keeping the device on the targeted feature release version.
    UpdateAssessmentStatus_NotLatestTargetedVersion = 0x0000000b,
}

///Specifies a format for a directory service object name.
alias EXTENDED_NAME_FORMAT = int;
enum : int
{
    ///An unknown name type.
    NameUnknown          = 0x00000000,
    ///The fully qualified distinguished name (for example, CN=Jeff Smith,OU=Users,DC=Engineering,DC=Microsoft,DC=Com).
    NameFullyQualifiedDN = 0x00000001,
    ///A legacy account name (for example, Engineering\JSmith). The domain-only version includes trailing backslashes
    ///(\\).
    NameSamCompatible    = 0x00000002,
    ///A "friendly" display name (for example, Jeff Smith). The display name is not necessarily the defining relative
    ///distinguished name (RDN).
    NameDisplay          = 0x00000003,
    ///A GUID string that the IIDFromString function returns (for example, {4fa050f0-f561-11cf-bdd9-00aa003a77b6}).
    NameUniqueId         = 0x00000006,
    ///The complete canonical name (for example, engineering.microsoft.com/software/someone). The domain-only version
    ///includes a trailing forward slash (/).
    NameCanonical        = 0x00000007,
    ///The user principal name (for example, someone@example.com).
    NameUserPrincipal    = 0x00000008,
    ///The same as NameCanonical except that the rightmost forward slash (/) is replaced with a new line character (\n),
    ///even in a domain-only case (for example, engineering.microsoft.com/software\nJSmith).
    NameCanonicalEx      = 0x00000009,
    ///The generalized service principal name (for example, www/www.microsoft.com@microsoft.com).
    NameServicePrincipal = 0x0000000a,
    ///The DNS domain name followed by a backward-slash and the SAM user name.
    NameDnsDomain        = 0x0000000c,
    NameGivenName        = 0x0000000d,
    NameSurname          = 0x0000000e,
}

alias THREAD_INFORMATION_CLASS = int;
enum : int
{
    ThreadMemoryPriority      = 0x00000000,
    ThreadAbsoluteCpuPriority = 0x00000001,
    ThreadDynamicCodePolicy   = 0x00000002,
    ThreadPowerThrottling     = 0x00000003,
    ThreadInformationClassMax = 0x00000004,
}

///Specifies a type of computer name.
alias COMPUTER_NAME_FORMAT = int;
enum : int
{
    ///The NetBIOS name of the local computer or the cluster associated with the local computer. This name is limited to
    ///MAX_COMPUTERNAME_LENGTH + 1 characters and may be a truncated version of the DNS host name. For example, if the
    ///DNS host name is "corporate-mail-server", the NetBIOS name would be "corporate-mail-".
    ComputerNameNetBIOS                   = 0x00000000,
    ///The DNS name of the local computer or the cluster associated with the local computer.
    ComputerNameDnsHostname               = 0x00000001,
    ///The name of the DNS domain assigned to the local computer or the cluster associated with the local computer.
    ComputerNameDnsDomain                 = 0x00000002,
    ///The fully qualified DNS name that uniquely identifies the local computer or the cluster associated with the local
    ///computer. This name is a combination of the DNS host name and the DNS domain name, using the form
    ///<i>HostName</i>.<i>DomainName</i>. For example, if the DNS host name is "corporate-mail-server" and the DNS
    ///domain name is "microsoft.com", the fully qualified DNS name is "corporate-mail-server.microsoft.com".
    ComputerNameDnsFullyQualified         = 0x00000003,
    ///The NetBIOS name of the local computer. On a cluster, this is the NetBIOS name of the local node on the cluster.
    ComputerNamePhysicalNetBIOS           = 0x00000004,
    ///The DNS host name of the local computer. On a cluster, this is the DNS host name of the local node on the
    ///cluster.
    ComputerNamePhysicalDnsHostname       = 0x00000005,
    ///The name of the DNS domain assigned to the local computer. On a cluster, this is the DNS domain of the local node
    ///on the cluster.
    ComputerNamePhysicalDnsDomain         = 0x00000006,
    ///The fully qualified DNS name that uniquely identifies the computer. On a cluster, this is the fully qualified DNS
    ///name of the local node on the cluster. The fully qualified DNS name is a combination of the DNS host name and the
    ///DNS domain name, using the form <i>HostName</i>.<i>DomainName</i>.
    ComputerNamePhysicalDnsFullyQualified = 0x00000007,
    ///Not used.
    ComputerNameMax                       = 0x00000008,
}

alias DEP_SYSTEM_POLICY_TYPE = int;
enum : int
{
    DEPPolicyAlwaysOff  = 0x00000000,
    DEPPolicyAlwaysOn   = 0x00000001,
    DEPPolicyOptIn      = 0x00000002,
    DEPPolicyOptOut     = 0x00000003,
    DEPTotalPolicyCount = 0x00000004,
}

alias PROC_THREAD_ATTRIBUTE_NUM = int;
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

alias XMLEMEM_TYPE = int;
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

alias FILE_INFORMATION_CLASS = int;
enum : int
{
    FileDirectoryInformation = 0x00000001,
}

alias PROCESSINFOCLASS = int;
enum : int
{
    ProcessBasicInformation   = 0x00000000,
    ProcessDebugPort          = 0x00000007,
    ProcessWow64Information   = 0x0000001a,
    ProcessImageFileName      = 0x0000001b,
    ProcessBreakOnTermination = 0x0000001d,
}

alias THREADINFOCLASS = int;
enum : int
{
    ThreadIsIoPending = 0x00000010,
}

alias SYSTEM_INFORMATION_CLASS = int;
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

alias OBJECT_INFORMATION_CLASS = int;
enum : int
{
    ObjectBasicInformation = 0x00000000,
    ObjectTypeInformation  = 0x00000002,
}

alias KEY_SET_INFORMATION_CLASS = int;
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

alias WINSTATIONINFOCLASS = int;
enum : int
{
    WinStationInformation = 0x00000008,
}

///Specifies the application's current heap allocation state.
alias eUserAllocationState = int;
enum : int
{
    ///The allocation state cannot be determined.
    AllocationStateUnknown = 0x00000000,
    ///The allocation state is currently in use.
    AllocationStateBusy    = 0x00000001,
    ///Memory has been freed from the stack but has not been returned to the heap yet.
    AllocationStateFree    = 0x00000002,
}

///Specifies the current heap allocation state.
alias eHeapAllocationState = int;
enum : int
{
    ///Specifies the full-page heap arrangement is being used.
    HeapFullPageHeap = 0x40000000,
    ///Specifies the highest bit. When set, it has not been allocated by the user.
    HeapMetadata     = 0x80000000,
    ///Specifies a value to be used as a mask with the bitwise AND operator to indicate whether the allocation is by the
    ///user.
    HeapStateMask    = 0xffff0000,
}

///Determines whether the enumeration operation should continue or stop.
alias eHeapEnumerationLevel = int;
enum : int
{
    ///A constant that specifies the enumeration should continue.
    HeapEnumerationEverything = 0x00000000,
    ///A constant that specifies to the VerifierEnumerateResource function when the enumeration operation should stop.
    ///Codes from 0x1 to 0xFFFFFFE are reserved.
    HeapEnumerationStop       = 0xffffffff,
}

///Identifies the type of handle operation that has occurred.
alias eHANDLE_TRACE_OPERATIONS = int;
enum : int
{
    ///Not used at this time.
    OperationDbUnused = 0x00000000,
    ///Specifies an open (create) handle operation.
    OperationDbOPEN   = 0x00000001,
    ///Specifies a close handle operation.
    OperationDbCLOSE  = 0x00000002,
    ///Specifies an invalid handle operation.
    OperationDbBADREF = 0x00000003,
}

///Specifies the types of resources that can be enumerated using the VerifierEnumerateResource function.
alias eAvrfResourceTypes = int;
enum : int
{
    ///Indicates heap-allocation information is being obtained.
    AvrfResourceHeapAllocation = 0x00000000,
    ///Indicates handle trace information is being obtained.
    AvrfResourceHandleTrace    = 0x00000001,
    ///Indicates the upper boundary of the current implementation's resource type.
    AvrfResourceMax            = 0x00000002,
}

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

alias FCIERROR = int;
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

alias FDIERROR = int;
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

alias FDIDECRYPTTYPE = int;
enum : int
{
    fdidtNEW_CABINET = 0x00000000,
    fdidtNEW_FOLDER  = 0x00000001,
    fdidtDECRYPT     = 0x00000002,
}

alias FDINOTIFICATIONTYPE = int;
enum : int
{
    fdintCABINET_INFO    = 0x00000000,
    fdintPARTIAL_FILE    = 0x00000001,
    fdintCOPY_FILE       = 0x00000002,
    fdintCLOSE_FILE_INFO = 0x00000003,
    fdintNEXT_CABINET    = 0x00000004,
    fdintENUMERATE       = 0x00000005,
}

///This enumeration is intended for infrastructure use only. Do not use this enumeration.
alias FEATURE_CHANGE_TIME = int;
enum : int
{
    ///TBD
    FEATURE_CHANGE_TIME_READ          = 0x00000000,
    ///TBD
    FEATURE_CHANGE_TIME_MODULE_RELOAD = 0x00000001,
    ///TBD
    FEATURE_CHANGE_TIME_SESSION       = 0x00000002,
    FEATURE_CHANGE_TIME_REBOOT        = 0x00000003,
}

///This enumeration is intended for infrastructure use only. Do not use this enumeration.
alias FEATURE_ENABLED_STATE = int;
enum : int
{
    ///TBD
    FEATURE_ENABLED_STATE_DEFAULT  = 0x00000000,
    ///TBD
    FEATURE_ENABLED_STATE_DISABLED = 0x00000001,
    FEATURE_ENABLED_STATE_ENABLED  = 0x00000002,
}

///Specifies the type of a property of a backup target.
alias FH_TARGET_PROPERTY_TYPE = int;
enum : int
{
    ///The property is a string that contains the backup target’s friendly name. The friendly name is set during
    ///target provisioning by calling the IFhConfigMgr::ProvisionAndSetNewTarget method.
    FH_TARGET_NAME       = 0x00000000,
    ///The property is a string that contains a path to the backup target.
    FH_TARGET_URL        = 0x00000001,
    ///The property is a numeric property that specifies the target type of the backup target. See the
    ///FH_TARGET_DRIVE_TYPES enumeration for the list of possible backup target types.
    FH_TARGET_DRIVE_TYPE = 0x00000002,
    ///The maximum enumeration value for this enumeration. This value and all values greater than it are reserved for
    ///system use.
    MAX_TARGET_PROPERTY  = 0x00000003,
}

///Specifies the type of a File History backup target.
alias FH_TARGET_DRIVE_TYPES = int;
enum : int
{
    ///The type of the backup target is unknown.
    FH_DRIVE_UNKNOWN   = 0x00000000,
    ///The backup target is a locally attached removable storage device, such as a USB thumb drive.
    FH_DRIVE_REMOVABLE = 0x00000002,
    ///The backup target is a locally attached nonremovable storage device, such as an internal hard drive.
    FH_DRIVE_FIXED     = 0x00000003,
    ///The backup target is a storage device that is accessible over network, such as a computer that is running Windows
    ///Home Server.
    FH_DRIVE_REMOTE    = 0x00000004,
}

///Specifies the type of an inclusion or exclusion list.
alias FH_PROTECTED_ITEM_CATEGORY = int;
enum : int
{
    ///The inclusion or exclusion list is a list of folders.
    FH_FOLDER                   = 0x00000000,
    ///The inclusion or exclusion list is a list of libraries.
    FH_LIBRARY                  = 0x00000001,
    ///The maximum enumeration value for this enumeration. This value and all values greater than it are reserved for
    ///system use.
    MAX_PROTECTED_ITEM_CATEGORY = 0x00000002,
}

///Specifies the type of a local policy for the File History feature. Each local policy has a numeric parameter
///associated with it.
alias FH_LOCAL_POLICY_TYPE = int;
enum : int
{
    ///This local policy specifies how frequently backups are to be performed for the current user. The numeric
    ///parameter contains the time, in seconds, from the end of one backup until the start of the next one. The default
    ///value of the numeric parameter for this policy is 3600 seconds (1 hour).
    FH_FREQUENCY      = 0x00000000,
    ///This local policy specifies when previous versions of files and folders can be deleted from a backup target. See
    ///the FH_RETENTION_TYPES enumeration for the list of possible values. The default value of the numeric parameter
    ///for this policy is <b>FH_RETENTION_DISABLED</b>.
    FH_RETENTION_TYPE = 0x00000001,
    ///This local policy specifies the minimum age of previous versions that can be deleted from a backup target when
    ///the <b>FH_RETENTION_AGE_BASED</b> retention type is specified. For more information, see the FH_RETENTION_TYPES
    ///enumeration. The numeric parameter contains the minimum age, in days. The default value of the numeric parameter
    ///for this policy is 365 days (1 year).
    FH_RETENTION_AGE  = 0x00000002,
    ///The maximum enumeration value for this enumeration. This value and all values greater than it are reserved for
    ///system use.
    MAX_LOCAL_POLICY  = 0x00000003,
}

///Specifies under what conditions previous versions of files and folders can be deleted from a backup target.
alias FH_RETENTION_TYPES = int;
enum : int
{
    ///Previous versions are never deleted from the backup target.
    FH_RETENTION_DISABLED  = 0x00000000,
    ///The operating system can delete any previous version on an as-needed basis, unless it is the most recent version
    ///of a file that currently exists and is within the protection scope.
    FH_RETENTION_UNLIMITED = 0x00000001,
    ///The operating system can delete any previous version older than the specified minimum age on as-needed basis,
    ///unless it is the most recent version of a file that currently exists and is within the protection scope. The
    ///minimum age is specified by the <b>FH_RETENTION_AGE</b> local policy.
    FH_RETENTION_AGE_BASED = 0x00000002,
    ///The maximum enumeration value for this enumeration. This value and all values greater than it are reserved for
    ///system use.
    MAX_RETENTION_TYPE     = 0x00000003,
}

///Specifies whether File History backups are enabled.
alias FH_BACKUP_STATUS = int;
enum : int
{
    ///File History backups are not enabled by the user.
    FH_STATUS_DISABLED       = 0x00000000,
    ///File History backups are disabled by Group Policy.
    FH_STATUS_DISABLED_BY_GP = 0x00000001,
    ///File History backups are enabled.
    FH_STATUS_ENABLED        = 0x00000002,
    FH_STATUS_REHYDRATING    = 0x00000003,
    ///The maximum enumeration value for this enumeration. This value and all values greater than it are reserved for
    ///system use.
    MAX_BACKUP_STATUS        = 0x00000004,
}

///Indicates whether the storage device or network share can be used as a File History backup target.
alias FH_DEVICE_VALIDATION_RESULT = int;
enum : int
{
    ///The storage device or network share cannot be used as a backup target, because it is not accessible.
    FH_ACCESS_DENIED          = 0x00000000,
    ///The storage device or network share cannot be used as a backup target, because the drive type is not supported.
    ///For example, a CD or DVD cannot be used as a File History backup target.
    FH_INVALID_DRIVE_TYPE     = 0x00000001,
    ///The storage device or network share cannot be used as a backup target, because it is read-only.
    FH_READ_ONLY_PERMISSION   = 0x00000002,
    ///The storage device or network share is already being used as a backup target.
    FH_CURRENT_DEFAULT        = 0x00000003,
    ///The storage device or network share was previously used to back up files from a computer or user that has the
    ///same name as the current computer or user. It can be used as a backup target, but if it is used, the operating
    ///system will delete the previous backup.
    FH_NAMESPACE_EXISTS       = 0x00000004,
    ///The storage device or network share cannot be used as a backup target, because it is in the File History
    ///protection scope.
    FH_TARGET_PART_OF_LIBRARY = 0x00000005,
    ///The storage device or network share can be used as a backup target.
    FH_VALID_TARGET           = 0x00000006,
    ///The maximum enumeration value for this enumeration. This value and all values greater than it are reserved for
    ///system use.
    MAX_VALIDATION_RESULT     = 0x00000007,
}

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

alias WSC_SECURITY_PRODUCT_SUBSTATUS = int;
enum : int
{
    WSC_SECURITY_PRODUCT_SUBSTATUS_NOT_SET            = 0x00000000,
    WSC_SECURITY_PRODUCT_SUBSTATUS_NO_ACTION          = 0x00000001,
    WSC_SECURITY_PRODUCT_SUBSTATUS_ACTION_RECOMMENDED = 0x00000002,
    WSC_SECURITY_PRODUCT_SUBSTATUS_ACTION_NEEDED      = 0x00000003,
}

///Defines the current state of the security product that is made available to Windows Security Center.
alias WSC_SECURITY_PRODUCT_STATE = int;
enum : int
{
    ///The security product software is turned on and protecting the user.
    WSC_SECURITY_PRODUCT_STATE_ON      = 0x00000000,
    ///The security product software is turned off and protection is disabled.
    WSC_SECURITY_PRODUCT_STATE_OFF     = 0x00000001,
    ///The security product software is in the snoozed state, temporarily off, and not actively protecting the computer.
    WSC_SECURITY_PRODUCT_STATE_SNOOZED = 0x00000002,
    WSC_SECURITY_PRODUCT_STATE_EXPIRED = 0x00000003,
}

alias SECURITY_PRODUCT_TYPE = int;
enum : int
{
    SECURITY_PRODUCT_TYPE_ANTIVIRUS   = 0x00000000,
    SECURITY_PRODUCT_TYPE_FIREWALL    = 0x00000001,
    SECURITY_PRODUCT_TYPE_ANTISPYWARE = 0x00000002,
}

///Reports the current version status of the security product to Windows Security Center.
alias WSC_SECURITY_SIGNATURE_STATUS = int;
enum : int
{
    ///The security software reports that it is not the most recent version.
    WSC_SECURITY_PRODUCT_OUT_OF_DATE = 0x00000000,
    WSC_SECURITY_PRODUCT_UP_TO_DATE  = 0x00000001,
}

///Defines all the services that are monitored by Windows Security Center (WSC).
alias WSC_SECURITY_PROVIDER = int;
enum : int
{
    ///The aggregation of all firewalls for this computer.
    WSC_SECURITY_PROVIDER_FIREWALL             = 0x00000001,
    ///The automatic update settings for this computer.
    WSC_SECURITY_PROVIDER_AUTOUPDATE_SETTINGS  = 0x00000002,
    ///The aggregation of all antivirus products for this computer.
    WSC_SECURITY_PROVIDER_ANTIVIRUS            = 0x00000004,
    ///The aggregation of all anti-spyware products for this computer.
    WSC_SECURITY_PROVIDER_ANTISPYWARE          = 0x00000008,
    ///The settings that restrict the access of web sites in each of the Internet zones for this computer.
    WSC_SECURITY_PROVIDER_INTERNET_SETTINGS    = 0x00000010,
    ///The User Account Control (UAC) settings for this computer.
    WSC_SECURITY_PROVIDER_USER_ACCOUNT_CONTROL = 0x00000020,
    ///The running state of the WSC service on this computer.
    WSC_SECURITY_PROVIDER_SERVICE              = 0x00000040,
    ///None of the items that WSC monitors.
    WSC_SECURITY_PROVIDER_NONE                 = 0x00000000,
    ///All of the items that the WSC monitors.
    WSC_SECURITY_PROVIDER_ALL                  = 0x0000007f,
}

///Defines the possible states for any service monitored by Windows Security Center (WSC).
alias WSC_SECURITY_PROVIDER_HEALTH = int;
enum : int
{
    ///The status of the security provider category is good and does not need user attention.
    WSC_SECURITY_PROVIDER_HEALTH_GOOD         = 0x00000000,
    ///The status of the security provider category is not monitored by WSC.
    WSC_SECURITY_PROVIDER_HEALTH_NOTMONITORED = 0x00000001,
    ///The status of the security provider category is poor and the computer may be at risk.
    WSC_SECURITY_PROVIDER_HEALTH_POOR         = 0x00000002,
    ///The security provider category is in snooze state. Snooze indicates that WSC is not actively protecting the
    ///computer.
    WSC_SECURITY_PROVIDER_HEALTH_SNOOZE       = 0x00000003,
}

alias TDI_TL_IO_CONTROL_TYPE = int;
enum : int
{
    EndpointIoControlType   = 0x00000000,
    SetSockOptIoControlType = 0x00000001,
    GetSockOptIoControlType = 0x00000002,
    SocketIoControlType     = 0x00000003,
}

alias WLDP_HOST = int;
enum : int
{
    WLDP_HOST_RUNDLL32 = 0x00000000,
    WLDP_HOST_SVCHOST  = 0x00000001,
    WLDP_HOST_MAX      = 0x00000002,
}

alias WLDP_HOST_ID = int;
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

alias DECISION_LOCATION = int;
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

alias WLDP_KEY = int;
enum : int
{
    KEY_UNKNOWN  = 0x00000000,
    KEY_OVERRIDE = 0x00000001,
    KEY_ALL_KEYS = 0x00000002,
}

alias VALUENAME = int;
enum : int
{
    VALUENAME_UNKNOWN                     = 0x00000000,
    VALUENAME_ENTERPRISE_DEFINED_CLASS_ID = 0x00000001,
    VALUENAME_BUILT_IN_LIST               = 0x00000002,
}

alias WLDP_WINDOWS_LOCKDOWN_MODE = int;
enum : int
{
    WLDP_WINDOWS_LOCKDOWN_MODE_UNLOCKED = 0x00000000,
    WLDP_WINDOWS_LOCKDOWN_MODE_TRIAL    = 0x00000001,
    WLDP_WINDOWS_LOCKDOWN_MODE_LOCKED   = 0x00000002,
    WLDP_WINDOWS_LOCKDOWN_MODE_MAX      = 0x00000003,
}

alias WLDP_WINDOWS_LOCKDOWN_RESTRICTION = int;
enum : int
{
    WLDP_WINDOWS_LOCKDOWN_RESTRICTION_NONE               = 0x00000000,
    WLDP_WINDOWS_LOCKDOWN_RESTRICTION_NOUNLOCK           = 0x00000001,
    WLDP_WINDOWS_LOCKDOWN_RESTRICTION_NOUNLOCK_PERMANENT = 0x00000002,
    WLDP_WINDOWS_LOCKDOWN_RESTRICTION_MAX                = 0x00000003,
}

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

alias DEVPROP_OPERATOR = int;
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

alias DEV_OBJECT_TYPE = int;
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

alias DEV_QUERY_FLAGS = int;
enum : int
{
    DevQueryFlagNone          = 0x00000000,
    DevQueryFlagUpdateResults = 0x00000001,
    DevQueryFlagAllProperties = 0x00000002,
    DevQueryFlagLocalize      = 0x00000004,
    DevQueryFlagAsyncClose    = 0x00000008,
}

alias DEV_QUERY_STATE = int;
enum : int
{
    DevQueryStateInitialized   = 0x00000000,
    DevQueryStateEnumCompleted = 0x00000001,
    DevQueryStateAborted       = 0x00000002,
    DevQueryStateClosed        = 0x00000003,
}

alias DEV_QUERY_RESULT_ACTION = int;
enum : int
{
    DevQueryResultStateChange = 0x00000000,
    DevQueryResultAdd         = 0x00000001,
    DevQueryResultUpdate      = 0x00000002,
    DevQueryResultRemove      = 0x00000003,
}

alias _GlobalFilter = int;
enum : int
{
    GF_FRAGMENTS  = 0x00000002,
    GF_STRONGHOST = 0x00000008,
    GF_FRAGCACHE  = 0x00000009,
}

alias _PfForwardAction = int;
enum : int
{
    PF_ACTION_FORWARD = 0x00000000,
    PF_ACTION_DROP    = 0x00000001,
}

alias _PfAddresType = int;
enum : int
{
    PF_IPV4 = 0x00000000,
    PF_IPV6 = 0x00000001,
}

alias _PfFrameType = int;
enum : int
{
    PFFT_FILTER = 0x00000001,
    PFFT_FRAG   = 0x00000002,
    PFFT_SPOOF  = 0x00000003,
}

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
///Provides access to one of the specialized callback functions for enumeration of either heap allocation or handle
///trace information.
///Params:
///    ResourceDescription = A pointer to either an AVRF_HANDLE_OPERATION structure or an AVRF_HEAP_ALLOCATION structure. Be sure to cast this
///                          parameter to the correct structure type.
///    EnumerationContext = A pointer to be passed to the resource-specific callback function.
///    EnumerationLevel = Specifies whether the enumeration operation should continue. This must be one of the values in the
///                       eHeapEnumerationLevel enum.
///Returns:
///    This function returns error codes or other values defined by the application.
///    
alias AVRF_RESOURCE_ENUMERATE_CALLBACK = uint function(void* ResourceDescription, void* EnumerationContext, 
                                                       uint* EnumerationLevel);
///Receives information related to heap allocations.
///Params:
///    HeapAllocation = A pointer to an AVRF_HEAP_ALLOCATION structure containing information about the heap to be enumerated.
///    EnumerationContext = A pointer to user-defined information in the context of the enumeration that is passed in when the
///                         VerifierEnumerateResource function is invoked.
///    EnumerationLevel = A pointer to a value that informs the VerifierEnumerateResource function to either continue or stop the
///                       enumeration operation. These values are defined in the eHeapEnumerationLevel enum.
///Returns:
///    This function returns error codes or other values defined by the application.
///    
alias AVRF_HEAPALLOCATION_ENUMERATE_CALLBACK = uint function(AVRF_HEAP_ALLOCATION* HeapAllocation, 
                                                             void* EnumerationContext, uint* EnumerationLevel);
///Receives information related to the enumeration of handle traces.
///Params:
///    HandleOperation = A pointer to an AVRF_HANDLE_OPERATION structure containing information related to the enumeration of handle
///                      traces.
///    EnumerationContext = A pointer to a user-defined information related to the context of the enumeration that is passed in when the
///                         VerifierEnumerateResource function is invoked.
///    EnumerationLevel = A pointer to a value that informs the VerifierEnumerateResource function to either continue or stop the
///                       enumeration operation. These values are defined in the eHeapEnumerationLevel enum.
///Returns:
///    This function returns error codes or other values defined by the application.
///    
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
///<p class="CCE_Message">[This function is not supported and may be altered or unavailable in the future.] Implement
///this function to receive information for each virtual DOS machine (VDM) that VDMEnumProcessWOW enumerates. The
///<b>PROCESSENUMPROC</b> type defines a pointer to this callback function. <b>ProcessVDMs</b> is a placeholder for the
///application-defined function name.
///Params:
///    dwProcessId = The process ID of the NTVDM.exe process. Use this ID when calling other VDM debug functions.
///    dwAttributes = The process attributes.
///    lpUserDefined = The user-defined data that was passed to the VDMEnumProcessWOW function.
alias PROCESSENUMPROC = BOOL function(uint dwProcessId, uint dwAttributes, LPARAM lpUserDefined);
alias TASKENUMPROC = BOOL function(uint dwThreadId, ushort hMod16, ushort hTask16, LPARAM lpUserDefined);
///<p class="CCE_Message">[This function is not supported and may be altered or unavailable in the future.] Implement
///this function to receive information for each task that VDMEnumTaskWOWEx enumerates. The <b>TASKENUMPROCEX</b> type
///defines a pointer to this callback function. <b>ProcessTasks</b> is a placeholder for the application-defined
///function name.
///Params:
///    dwThreadId = The thread ID.
///    hMod16 = The module handle.
///    hTask16 = The task handle.
///    pszModName = The module name.
///    pszFileName = The file name.
///    lpUserDefined = The user-defined data that was passed to the VDMEnumTaskWOWEx function.
///Returns:
///    Return <b>TRUE</b> to stop the enumeration and <b>FALSE</b> to continue.
///    
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
///A callback function that is used to create items in the cache. It is called by the CacheCreateFile function.
///Params:
///    lpstrName = The name of the file.
///    lpvData = User-provided data to CacheCreateFile.
///    cbFileSize = The size of the file.
///    cbFileSizeHigh = The location to return the high <b>DWORD</b> of the file size.
///Returns:
///    Returns a handle to the file created in the cache.
///    
alias FCACHE_CREATE_CALLBACK = HANDLE function(const(char)* lpstrName, void* lpvData, uint* cbFileSize, 
                                               uint* cbFileSizeHigh);
///A callback function that is used to create items in the cache. It is called by CacheRichCreateFile.
///Params:
///    lpstrName = The name of the file.
///    lpvData = User-provided data to CacheRichCreateFile.
///    cbFileSize = The size of the low <b>DWORD</b>.
///    cbFileSizeHigh = The size of the high <b>DWORD</b>.
///    pfDidWeScanIt = Set to <b>TRUE</b> if the file has been scanned; otherwise, it is set to <b>FALSE</b>.
///    pfIsStuffed = Set to <b>TRUE</b> if the file is dot stuffed; otherwise, it is set to <b>FALSE</b>.
///    pfStoredWithDots = If set to <b>TRUE</b>, this parameter indicates that any dots that appear at the beginning of a line are stored
///                       with an extra dot as required in NNTP, SMTP, and POP3 protocols. If this is <b>FALSE</b>, the message is stored
///                       without dot stuffing.
///    pfStoredWithTerminatingDot = If set to <b>TRUE</b>, the file has been stored with a terminating dot; otherwise, it is <b>FALSE</b>.
///Returns:
///    Returns a handle to the file that was created in the cache.
///    
alias FCACHE_RICHCREATE_CALLBACK = HANDLE function(const(char)* lpstrName, void* lpvData, uint* cbFileSize, 
                                                   uint* cbFileSizeHigh, int* pfDidWeScanIt, int* pfIsStuffed, 
                                                   int* pfStoredWithDots, int* pfStoredWithTerminatingDot);
alias CACHE_KEY_COMPARE = int function(uint cbKey1, ubyte* lpbKey1, uint cbKey2, ubyte* lpbKey2);
alias CACHE_KEY_HASH = uint function(ubyte* lpbKey, uint cbKey);
///A callback that is provided to the cache to help examine items within the cache.
///Params:
///    cb = The size, in bytes, of the data indicated in the <i>lpb</i> parameter.
///    lpb = A pointer to the data portion of the key.
///    lpvContext = The context that is specified by the user.
alias CACHE_READ_CALLBACK = BOOL function(uint cb, ubyte* lpb, void* lpvContext);
///A function that is called whenever an entry in the name cache is destroyed. It provides the client with an
///opportunity to track any relationships between the key and data components.
///Params:
///    cb = The size of the data or key pointed to by the <i>lpb</i> parameter, in bytes.
///    lpb = A pointer to the data or key.
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


///The <b>NETLOGON_INFO_1</b> structure defines a level-1 control query response from a domain controller.
struct NETLOGON_INFO_1
{
    ///An integer value that contains one or more of the following control query responses from the DC. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="NETLOGON_REPLICATION_NEEDED"></a><a
    ///id="netlogon_replication_needed"></a><dl> <dt><b>NETLOGON_REPLICATION_NEEDED</b></dt> <dt>0x00000001</dt> </dl>
    ///</td> <td width="60%"> Not supported. </td> </tr> <tr> <td width="40%"><a
    ///id="NETLOGON_REPLICATION_IN_PROGRESS"></a><a id="netlogon_replication_in_progress"></a><dl>
    ///<dt><b>NETLOGON_REPLICATION_IN_PROGRESS</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> Not supported.
    ///</td> </tr> <tr> <td width="40%"><a id="NETLOGON_FULL_SYNC_REPLICATION"></a><a
    ///id="netlogon_full_sync_replication"></a><dl> <dt><b>NETLOGON_FULL_SYNC_REPLICATION</b></dt> <dt>0x00000004</dt>
    ///</dl> </td> <td width="60%"> Not supported. </td> </tr> <tr> <td width="40%"><a id="NETLOGON_REDO_NEEDED"></a><a
    ///id="netlogon_redo_needed"></a><dl> <dt><b>NETLOGON_REDO_NEEDED</b></dt> <dt>0x00000008</dt> </dl> </td> <td
    ///width="60%"> Not supported. </td> </tr> <tr> <td width="40%"><a id="NETLOGON_HAS_IP"></a><a
    ///id="netlogon_has_ip"></a><dl> <dt><b>NETLOGON_HAS_IP</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%">
    ///Trusted domain DC has an IP address. </td> </tr> <tr> <td width="40%"><a id="NETLOGON_HAS_TIMESERV"></a><a
    ///id="netlogon_has_timeserv"></a><dl> <dt><b>NETLOGON_HAS_TIMESERV</b></dt> <dt>0x00000020</dt> </dl> </td> <td
    ///width="60%"> Trusted domain DC runs the Windows Time Service. </td> </tr> <tr> <td width="40%"><a
    ///id="NETLOGON_DNS_UPDATE_FAILURE"></a><a id="netlogon_dns_update_failure"></a><dl>
    ///<dt><b>NETLOGON_DNS_UPDATE_FAILURE</b></dt> <dt>0x00000040</dt> </dl> </td> <td width="60%"> Last update to the
    ///DNS records on the DC failed. </td> </tr> </table>
    uint netlog1_flags;
    ///An enumerated integer value that contains a status code defined in Lmerr.h, with a value greater than 2100. This
    ///value applies only to backup domain controllers, and shows the status of the secure channel connection to the PDC
    ///in their domain.
    uint netlog1_pdc_connection_status;
}

///The <b>NETLOGON_INFO_2</b> structure defines a level-2 control query response from a domain controller.
struct NETLOGON_INFO_2
{
    ///An integer value that contains one or more of the following control query responses from the DC. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="NETLOGON_REPLICATION_NEEDED"></a><a
    ///id="netlogon_replication_needed"></a><dl> <dt><b>NETLOGON_REPLICATION_NEEDED</b></dt> <dt>0x00000001</dt> </dl>
    ///</td> <td width="60%"> Not supported. </td> </tr> <tr> <td width="40%"><a
    ///id="NETLOGON_REPLICATION_IN_PROGRESS"></a><a id="netlogon_replication_in_progress"></a><dl>
    ///<dt><b>NETLOGON_REPLICATION_IN_PROGRESS</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> Not supported.
    ///</td> </tr> <tr> <td width="40%"><a id="NETLOGON_FULL_SYNC_REPLICATION"></a><a
    ///id="netlogon_full_sync_replication"></a><dl> <dt><b>NETLOGON_FULL_SYNC_REPLICATION</b></dt> <dt>0x00000004</dt>
    ///</dl> </td> <td width="60%"> Not supported. </td> </tr> <tr> <td width="40%"><a id="NETLOGON_REDO_NEEDED"></a><a
    ///id="netlogon_redo_needed"></a><dl> <dt><b>NETLOGON_REDO_NEEDED</b></dt> <dt>0x00000008</dt> </dl> </td> <td
    ///width="60%"> Not supported. </td> </tr> <tr> <td width="40%"><a id="NETLOGON_HAS_IP"></a><a
    ///id="netlogon_has_ip"></a><dl> <dt><b>NETLOGON_HAS_IP</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%">
    ///Trusted domain DC has an IP address. </td> </tr> <tr> <td width="40%"><a id="NETLOGON_HAS_TIMESERV"></a><a
    ///id="netlogon_has_timeserv"></a><dl> <dt><b>NETLOGON_HAS_TIMESERV</b></dt> <dt>0x00000020</dt> </dl> </td> <td
    ///width="60%"> Trusted domain DC runs the Windows Time Service. </td> </tr> <tr> <td width="40%"><a
    ///id="NETLOGON_DNS_UPDATE_FAILURE"></a><a id="netlogon_dns_update_failure"></a><dl>
    ///<dt><b>NETLOGON_DNS_UPDATE_FAILURE</b></dt> <dt>0x00000040</dt> </dl> </td> <td width="60%"> Last update to the
    ///DNS records on the DC failed. </td> </tr> <tr> <td width="40%"><a id="NETLOGON_VERIFY_STATUS_RETURNED"></a><a
    ///id="netlogon_verify_status_returned"></a><dl> <dt><b>NETLOGON_VERIFY_STATUS_RETURNED</b></dt> <dt>0x00000080</dt>
    ///</dl> </td> <td width="60%"> Trust verification status was returned in the <b>netlog2_pdc_connection_status</b>
    ///member. </td> </tr> </table>
    uint          netlog2_flags;
    ///An enumerated integer value that contains a status code defined in Lmerr.h, with a value greater than 2100. If
    ///<b>NETLOGON_VERIFY_STATUS_RETURNED</b> is set in <b>netlog2_flags</b>, this value represents the trust
    ///verification status of all domain members collectively.
    uint          netlog2_pdc_connection_status;
    const(wchar)* netlog2_trusted_dc_name;
    ///An enumerated integer value that contains a status code defined in Lmerr.h, with a value greater than 2100. This
    ///code shows the status of the secure channel to the specified trusted DC.
    uint          netlog2_tc_connection_status;
}

///The <b>NETLOGON_INFO_3</b> structure defines a level-3 control query response from a domain controller.
struct NETLOGON_INFO_3
{
    ///An integer value that contains one or more of the following control query responses from the DC. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="NETLOGON_REPLICATION_NEEDED"></a><a
    ///id="netlogon_replication_needed"></a><dl> <dt><b>NETLOGON_REPLICATION_NEEDED</b></dt> <dt>0x00000001</dt> </dl>
    ///</td> <td width="60%"> Not supported. </td> </tr> <tr> <td width="40%"><a
    ///id="NETLOGON_REPLICATION_IN_PROGRESS"></a><a id="netlogon_replication_in_progress"></a><dl>
    ///<dt><b>NETLOGON_REPLICATION_IN_PROGRESS</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> Not supported.
    ///</td> </tr> <tr> <td width="40%"><a id="NETLOGON_FULL_SYNC_REPLICATION"></a><a
    ///id="netlogon_full_sync_replication"></a><dl> <dt><b>NETLOGON_FULL_SYNC_REPLICATION</b></dt> <dt>0x00000004</dt>
    ///</dl> </td> <td width="60%"> Not supported. </td> </tr> <tr> <td width="40%"><a id="NETLOGON_REDO_NEEDED"></a><a
    ///id="netlogon_redo_needed"></a><dl> <dt><b>NETLOGON_REDO_NEEDED</b></dt> <dt>0x00000008</dt> </dl> </td> <td
    ///width="60%"> Not supported. </td> </tr> <tr> <td width="40%"><a id="NETLOGON_HAS_IP"></a><a
    ///id="netlogon_has_ip"></a><dl> <dt><b>NETLOGON_HAS_IP</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%">
    ///Trusted domain DC has an IP address. </td> </tr> <tr> <td width="40%"><a id="NETLOGON_HAS_TIMESERV"></a><a
    ///id="netlogon_has_timeserv"></a><dl> <dt><b>NETLOGON_HAS_TIMESERV</b></dt> <dt>0x00000020</dt> </dl> </td> <td
    ///width="60%"> Trusted domain DC runs the Windows Time Service. </td> </tr> <tr> <td width="40%"><a
    ///id="NETLOGON_DNS_UPDATE_FAILURE"></a><a id="netlogon_dns_update_failure"></a><dl>
    ///<dt><b>NETLOGON_DNS_UPDATE_FAILURE</b></dt> <dt>0x00000040</dt> </dl> </td> <td width="60%"> Last update to the
    ///DNS records on the DC failed. </td> </tr> </table>
    uint netlog3_flags;
    ///The number of logon attempts made for the domain.
    uint netlog3_logon_attempts;
    ///Reserved value.
    uint netlog3_reserved1;
    ///Reserved value.
    uint netlog3_reserved2;
    ///Reserved value.
    uint netlog3_reserved3;
    ///Reserved value.
    uint netlog3_reserved4;
    ///Reserved value.
    uint netlog3_reserved5;
}

///The <b>NETLOGON_INFO_4</b> structure defines a level-4 control query response from a domain controller.
struct NETLOGON_INFO_4
{
    const(wchar)* netlog4_trusted_dc_name;
    const(wchar)* netlog4_trusted_domain_name;
}

alias EventLogHandle = ptrdiff_t;

alias EventSourceHandle = ptrdiff_t;

alias HeapHandle = ptrdiff_t;

alias HKEY = ptrdiff_t;

///Contains operating system version information. The information includes major and minor version numbers, a build
///number, a platform identifier, and descriptive text about the operating system. This structure is used with the
///GetVersionEx function. To obtain additional version information, use the OSVERSIONINFOEX structure with GetVersionEx
///instead.
struct OSVERSIONINFOA
{
    ///The size of this data structure, in bytes. Set this member to <code>sizeof(OSVERSIONINFO)</code>.
    uint      dwOSVersionInfoSize;
    ///The major version number of the operating system. For more information, see Remarks.
    uint      dwMajorVersion;
    ///The minor version number of the operating system. For more information, see Remarks.
    uint      dwMinorVersion;
    ///The build number of the operating system.
    uint      dwBuildNumber;
    ///The operating system platform. This member can be the following value. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="VER_PLATFORM_WIN32_NT"></a><a
    ///id="ver_platform_win32_nt"></a><dl> <dt><b>VER_PLATFORM_WIN32_NT</b></dt> <dt>2</dt> </dl> </td> <td width="60%">
    ///The operating system is Windows 7, Windows Server 2008, Windows Vista, Windows Server 2003, Windows XP, or
    ///Windows 2000. </td> </tr> </table>
    uint      dwPlatformId;
    ///A null-terminated string, such as "Service Pack 3", that indicates the latest Service Pack installed on the
    ///system. If no Service Pack has been installed, the string is empty.
    byte[128] szCSDVersion;
}

///Contains operating system version information. The information includes major and minor version numbers, a build
///number, a platform identifier, and descriptive text about the operating system. This structure is used with the
///GetVersionEx function. To obtain additional version information, use the OSVERSIONINFOEX structure with GetVersionEx
///instead.
struct OSVERSIONINFOW
{
    ///The size of this data structure, in bytes. Set this member to <code>sizeof(OSVERSIONINFO)</code>.
    uint        dwOSVersionInfoSize;
    ///The major version number of the operating system. For more information, see Remarks.
    uint        dwMajorVersion;
    ///The minor version number of the operating system. For more information, see Remarks.
    uint        dwMinorVersion;
    ///The build number of the operating system.
    uint        dwBuildNumber;
    ///The operating system platform. This member can be the following value. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="VER_PLATFORM_WIN32_NT"></a><a
    ///id="ver_platform_win32_nt"></a><dl> <dt><b>VER_PLATFORM_WIN32_NT</b></dt> <dt>2</dt> </dl> </td> <td width="60%">
    ///The operating system is Windows 7, Windows Server 2008, Windows Vista, Windows Server 2003, Windows XP, or
    ///Windows 2000. </td> </tr> </table>
    uint        dwPlatformId;
    ///A null-terminated string, such as "Service Pack 3", that indicates the latest Service Pack installed on the
    ///system. If no Service Pack has been installed, the string is empty.
    ushort[128] szCSDVersion;
}

///Contains operating system version information. The information includes major and minor version numbers, a build
///number, a platform identifier, and information about product suites and the latest Service Pack installed on the
///system. This structure is used with the GetVersionEx and VerifyVersionInfo functions.
struct OSVERSIONINFOEXA
{
    ///The size of this data structure, in bytes. Set this member to <code>sizeof(OSVERSIONINFOEX)</code>.
    uint      dwOSVersionInfoSize;
    ///The major version number of the operating system. For more information, see Remarks.
    uint      dwMajorVersion;
    ///The minor version number of the operating system. For more information, see Remarks.
    uint      dwMinorVersion;
    ///The build number of the operating system.
    uint      dwBuildNumber;
    ///The operating system platform. This member can be <b>VER_PLATFORM_WIN32_NT</b> (2).
    uint      dwPlatformId;
    ///A null-terminated string, such as "Service Pack 3", that indicates the latest Service Pack installed on the
    ///system. If no Service Pack has been installed, the string is empty.
    byte[128] szCSDVersion;
    ///The major version number of the latest Service Pack installed on the system. For example, for Service Pack 3, the
    ///major version number is 3. If no Service Pack has been installed, the value is zero.
    ushort    wServicePackMajor;
    ///The minor version number of the latest Service Pack installed on the system. For example, for Service Pack 3, the
    ///minor version number is 0.
    ushort    wServicePackMinor;
    ///A bit mask that identifies the product suites available on the system. This member can be a combination of the
    ///following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="VER_SUITE_BACKOFFICE"></a><a id="ver_suite_backoffice"></a><dl> <dt><b>VER_SUITE_BACKOFFICE</b></dt>
    ///<dt>0x00000004</dt> </dl> </td> <td width="60%"> Microsoft BackOffice components are installed. </td> </tr> <tr>
    ///<td width="40%"><a id="VER_SUITE_BLADE"></a><a id="ver_suite_blade"></a><dl> <dt><b>VER_SUITE_BLADE</b></dt>
    ///<dt>0x00000400</dt> </dl> </td> <td width="60%"> Windows Server 2003, Web Edition is installed. </td> </tr> <tr>
    ///<td width="40%"><a id="VER_SUITE_COMPUTE_SERVER"></a><a id="ver_suite_compute_server"></a><dl>
    ///<dt><b>VER_SUITE_COMPUTE_SERVER</b></dt> <dt>0x00004000</dt> </dl> </td> <td width="60%"> Windows Server 2003,
    ///Compute Cluster Edition is installed. </td> </tr> <tr> <td width="40%"><a id="VER_SUITE_DATACENTER"></a><a
    ///id="ver_suite_datacenter"></a><dl> <dt><b>VER_SUITE_DATACENTER</b></dt> <dt>0x00000080</dt> </dl> </td> <td
    ///width="60%"> Windows Server 2008 Datacenter, Windows Server 2003, Datacenter Edition, or Windows 2000 Datacenter
    ///Server is installed. </td> </tr> <tr> <td width="40%"><a id="VER_SUITE_ENTERPRISE"></a><a
    ///id="ver_suite_enterprise"></a><dl> <dt><b>VER_SUITE_ENTERPRISE</b></dt> <dt>0x00000002</dt> </dl> </td> <td
    ///width="60%"> Windows Server 2008 Enterprise, Windows Server 2003, Enterprise Edition, or Windows 2000 Advanced
    ///Server is installed. Refer to the Remarks section for more information about this bit flag. </td> </tr> <tr> <td
    ///width="40%"><a id="VER_SUITE_EMBEDDEDNT"></a><a id="ver_suite_embeddednt"></a><dl>
    ///<dt><b>VER_SUITE_EMBEDDEDNT</b></dt> <dt>0x00000040</dt> </dl> </td> <td width="60%"> Windows XP Embedded is
    ///installed. </td> </tr> <tr> <td width="40%"><a id="VER_SUITE_PERSONAL"></a><a id="ver_suite_personal"></a><dl>
    ///<dt><b>VER_SUITE_PERSONAL</b></dt> <dt>0x00000200</dt> </dl> </td> <td width="60%"> Windows Vista Home Premium,
    ///Windows Vista Home Basic, or Windows XP Home Edition is installed. </td> </tr> <tr> <td width="40%"><a
    ///id="VER_SUITE_SINGLEUSERTS"></a><a id="ver_suite_singleuserts"></a><dl> <dt><b>VER_SUITE_SINGLEUSERTS</b></dt>
    ///<dt>0x00000100</dt> </dl> </td> <td width="60%"> Remote Desktop is supported, but only one interactive session is
    ///supported. This value is set unless the system is running in application server mode. </td> </tr> <tr> <td
    ///width="40%"><a id="VER_SUITE_SMALLBUSINESS"></a><a id="ver_suite_smallbusiness"></a><dl>
    ///<dt><b>VER_SUITE_SMALLBUSINESS</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> Microsoft Small Business
    ///Server was once installed on the system, but may have been upgraded to another version of Windows. Refer to the
    ///Remarks section for more information about this bit flag. </td> </tr> <tr> <td width="40%"><a
    ///id="VER_SUITE_SMALLBUSINESS_RESTRICTED"></a><a id="ver_suite_smallbusiness_restricted"></a><dl>
    ///<dt><b>VER_SUITE_SMALLBUSINESS_RESTRICTED</b></dt> <dt>0x00000020</dt> </dl> </td> <td width="60%"> Microsoft
    ///Small Business Server is installed with the restrictive client license in force. Refer to the Remarks section for
    ///more information about this bit flag. </td> </tr> <tr> <td width="40%"><a id="VER_SUITE_STORAGE_SERVER"></a><a
    ///id="ver_suite_storage_server"></a><dl> <dt><b>VER_SUITE_STORAGE_SERVER</b></dt> <dt>0x00002000</dt> </dl> </td>
    ///<td width="60%"> Windows Storage Server 2003 R2 or Windows Storage Server 2003is installed. </td> </tr> <tr> <td
    ///width="40%"><a id="VER_SUITE_TERMINAL"></a><a id="ver_suite_terminal"></a><dl> <dt><b>VER_SUITE_TERMINAL</b></dt>
    ///<dt>0x00000010</dt> </dl> </td> <td width="60%"> Terminal Services is installed. This value is always set. If
    ///<b>VER_SUITE_TERMINAL</b> is set but <b>VER_SUITE_SINGLEUSERTS</b> is not set, the system is running in
    ///application server mode. </td> </tr> <tr> <td width="40%"><a id="VER_SUITE_WH_SERVER"></a><a
    ///id="ver_suite_wh_server"></a><dl> <dt><b>VER_SUITE_WH_SERVER</b></dt> <dt>0x00008000</dt> </dl> </td> <td
    ///width="60%"> Windows Home Server is installed. </td> </tr> <tr> <td width="40%"><a
    ///id="VER_SUITE_MULTIUSERTS"></a><a id="ver_suite_multiuserts"></a><dl> <dt><b>VER_SUITE_MULTIUSERTS</b></dt>
    ///<dt>0x00020000</dt> </dl> </td> <td width="60%"> AppServer mode is enabled. </td> </tr> </table>
    ushort    wSuiteMask;
    ///Any additional information about the system. This member can be one of the following values. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="VER_NT_DOMAIN_CONTROLLER"></a><a
    ///id="ver_nt_domain_controller"></a><dl> <dt><b>VER_NT_DOMAIN_CONTROLLER</b></dt> <dt>0x0000002</dt> </dl> </td>
    ///<td width="60%"> The system is a domain controller and the operating system is Windows Server 2012 , Windows
    ///Server 2008 R2, Windows Server 2008, Windows Server 2003, or Windows 2000 Server. </td> </tr> <tr> <td
    ///width="40%"><a id="VER_NT_SERVER"></a><a id="ver_nt_server"></a><dl> <dt><b>VER_NT_SERVER</b></dt>
    ///<dt>0x0000003</dt> </dl> </td> <td width="60%"> The operating system is Windows Server 2012, Windows Server 2008
    ///R2, Windows Server 2008, Windows Server 2003, or Windows 2000 Server. Note that a server that is also a domain
    ///controller is reported as <b>VER_NT_DOMAIN_CONTROLLER</b>, not <b>VER_NT_SERVER</b>. </td> </tr> <tr> <td
    ///width="40%"><a id="VER_NT_WORKSTATION"></a><a id="ver_nt_workstation"></a><dl> <dt><b>VER_NT_WORKSTATION</b></dt>
    ///<dt>0x0000001</dt> </dl> </td> <td width="60%"> The operating system is Windows 8, Windows 7, Windows Vista,
    ///Windows XP Professional, Windows XP Home Edition, or Windows 2000 Professional. </td> </tr> </table>
    ubyte     wProductType;
    ///Reserved for future use.
    ubyte     wReserved;
}

///Contains operating system version information. The information includes major and minor version numbers, a build
///number, a platform identifier, and information about product suites and the latest Service Pack installed on the
///system. This structure is used with the GetVersionEx and VerifyVersionInfo functions.
struct OSVERSIONINFOEXW
{
    ///The size of this data structure, in bytes. Set this member to <code>sizeof(OSVERSIONINFOEX)</code>.
    uint        dwOSVersionInfoSize;
    ///The major version number of the operating system. For more information, see Remarks.
    uint        dwMajorVersion;
    ///The minor version number of the operating system. For more information, see Remarks.
    uint        dwMinorVersion;
    ///The build number of the operating system.
    uint        dwBuildNumber;
    ///The operating system platform. This member can be <b>VER_PLATFORM_WIN32_NT</b> (2).
    uint        dwPlatformId;
    ///A null-terminated string, such as "Service Pack 3", that indicates the latest Service Pack installed on the
    ///system. If no Service Pack has been installed, the string is empty.
    ushort[128] szCSDVersion;
    ///The major version number of the latest Service Pack installed on the system. For example, for Service Pack 3, the
    ///major version number is 3. If no Service Pack has been installed, the value is zero.
    ushort      wServicePackMajor;
    ///The minor version number of the latest Service Pack installed on the system. For example, for Service Pack 3, the
    ///minor version number is 0.
    ushort      wServicePackMinor;
    ///A bit mask that identifies the product suites available on the system. This member can be a combination of the
    ///following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="VER_SUITE_BACKOFFICE"></a><a id="ver_suite_backoffice"></a><dl> <dt><b>VER_SUITE_BACKOFFICE</b></dt>
    ///<dt>0x00000004</dt> </dl> </td> <td width="60%"> Microsoft BackOffice components are installed. </td> </tr> <tr>
    ///<td width="40%"><a id="VER_SUITE_BLADE"></a><a id="ver_suite_blade"></a><dl> <dt><b>VER_SUITE_BLADE</b></dt>
    ///<dt>0x00000400</dt> </dl> </td> <td width="60%"> Windows Server 2003, Web Edition is installed. </td> </tr> <tr>
    ///<td width="40%"><a id="VER_SUITE_COMPUTE_SERVER"></a><a id="ver_suite_compute_server"></a><dl>
    ///<dt><b>VER_SUITE_COMPUTE_SERVER</b></dt> <dt>0x00004000</dt> </dl> </td> <td width="60%"> Windows Server 2003,
    ///Compute Cluster Edition is installed. </td> </tr> <tr> <td width="40%"><a id="VER_SUITE_DATACENTER"></a><a
    ///id="ver_suite_datacenter"></a><dl> <dt><b>VER_SUITE_DATACENTER</b></dt> <dt>0x00000080</dt> </dl> </td> <td
    ///width="60%"> Windows Server 2008 Datacenter, Windows Server 2003, Datacenter Edition, or Windows 2000 Datacenter
    ///Server is installed. </td> </tr> <tr> <td width="40%"><a id="VER_SUITE_ENTERPRISE"></a><a
    ///id="ver_suite_enterprise"></a><dl> <dt><b>VER_SUITE_ENTERPRISE</b></dt> <dt>0x00000002</dt> </dl> </td> <td
    ///width="60%"> Windows Server 2008 Enterprise, Windows Server 2003, Enterprise Edition, or Windows 2000 Advanced
    ///Server is installed. Refer to the Remarks section for more information about this bit flag. </td> </tr> <tr> <td
    ///width="40%"><a id="VER_SUITE_EMBEDDEDNT"></a><a id="ver_suite_embeddednt"></a><dl>
    ///<dt><b>VER_SUITE_EMBEDDEDNT</b></dt> <dt>0x00000040</dt> </dl> </td> <td width="60%"> Windows XP Embedded is
    ///installed. </td> </tr> <tr> <td width="40%"><a id="VER_SUITE_PERSONAL"></a><a id="ver_suite_personal"></a><dl>
    ///<dt><b>VER_SUITE_PERSONAL</b></dt> <dt>0x00000200</dt> </dl> </td> <td width="60%"> Windows Vista Home Premium,
    ///Windows Vista Home Basic, or Windows XP Home Edition is installed. </td> </tr> <tr> <td width="40%"><a
    ///id="VER_SUITE_SINGLEUSERTS"></a><a id="ver_suite_singleuserts"></a><dl> <dt><b>VER_SUITE_SINGLEUSERTS</b></dt>
    ///<dt>0x00000100</dt> </dl> </td> <td width="60%"> Remote Desktop is supported, but only one interactive session is
    ///supported. This value is set unless the system is running in application server mode. </td> </tr> <tr> <td
    ///width="40%"><a id="VER_SUITE_SMALLBUSINESS"></a><a id="ver_suite_smallbusiness"></a><dl>
    ///<dt><b>VER_SUITE_SMALLBUSINESS</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> Microsoft Small Business
    ///Server was once installed on the system, but may have been upgraded to another version of Windows. Refer to the
    ///Remarks section for more information about this bit flag. </td> </tr> <tr> <td width="40%"><a
    ///id="VER_SUITE_SMALLBUSINESS_RESTRICTED"></a><a id="ver_suite_smallbusiness_restricted"></a><dl>
    ///<dt><b>VER_SUITE_SMALLBUSINESS_RESTRICTED</b></dt> <dt>0x00000020</dt> </dl> </td> <td width="60%"> Microsoft
    ///Small Business Server is installed with the restrictive client license in force. Refer to the Remarks section for
    ///more information about this bit flag. </td> </tr> <tr> <td width="40%"><a id="VER_SUITE_STORAGE_SERVER"></a><a
    ///id="ver_suite_storage_server"></a><dl> <dt><b>VER_SUITE_STORAGE_SERVER</b></dt> <dt>0x00002000</dt> </dl> </td>
    ///<td width="60%"> Windows Storage Server 2003 R2 or Windows Storage Server 2003is installed. </td> </tr> <tr> <td
    ///width="40%"><a id="VER_SUITE_TERMINAL"></a><a id="ver_suite_terminal"></a><dl> <dt><b>VER_SUITE_TERMINAL</b></dt>
    ///<dt>0x00000010</dt> </dl> </td> <td width="60%"> Terminal Services is installed. This value is always set. If
    ///<b>VER_SUITE_TERMINAL</b> is set but <b>VER_SUITE_SINGLEUSERTS</b> is not set, the system is running in
    ///application server mode. </td> </tr> <tr> <td width="40%"><a id="VER_SUITE_WH_SERVER"></a><a
    ///id="ver_suite_wh_server"></a><dl> <dt><b>VER_SUITE_WH_SERVER</b></dt> <dt>0x00008000</dt> </dl> </td> <td
    ///width="60%"> Windows Home Server is installed. </td> </tr> <tr> <td width="40%"><a
    ///id="VER_SUITE_MULTIUSERTS"></a><a id="ver_suite_multiuserts"></a><dl> <dt><b>VER_SUITE_MULTIUSERTS</b></dt>
    ///<dt>0x00020000</dt> </dl> </td> <td width="60%"> AppServer mode is enabled. </td> </tr> </table>
    ushort      wSuiteMask;
    ///Any additional information about the system. This member can be one of the following values. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="VER_NT_DOMAIN_CONTROLLER"></a><a
    ///id="ver_nt_domain_controller"></a><dl> <dt><b>VER_NT_DOMAIN_CONTROLLER</b></dt> <dt>0x0000002</dt> </dl> </td>
    ///<td width="60%"> The system is a domain controller and the operating system is Windows Server 2012 , Windows
    ///Server 2008 R2, Windows Server 2008, Windows Server 2003, or Windows 2000 Server. </td> </tr> <tr> <td
    ///width="40%"><a id="VER_NT_SERVER"></a><a id="ver_nt_server"></a><dl> <dt><b>VER_NT_SERVER</b></dt>
    ///<dt>0x0000003</dt> </dl> </td> <td width="60%"> The operating system is Windows Server 2012, Windows Server 2008
    ///R2, Windows Server 2008, Windows Server 2003, or Windows 2000 Server. Note that a server that is also a domain
    ///controller is reported as <b>VER_NT_DOMAIN_CONTROLLER</b>, not <b>VER_NT_SERVER</b>. </td> </tr> <tr> <td
    ///width="40%"><a id="VER_NT_WORKSTATION"></a><a id="ver_nt_workstation"></a><dl> <dt><b>VER_NT_WORKSTATION</b></dt>
    ///<dt>0x0000001</dt> </dl> </td> <td width="60%"> The operating system is Windows 8, Windows 7, Windows Vista,
    ///Windows XP Professional, Windows XP Home Edition, or Windows 2000 Professional. </td> </tr> </table>
    ubyte       wProductType;
    ///Reserved for future use.
    ubyte       wReserved;
}

///Contains a 64-bit value representing the number of 100-nanosecond intervals since January 1, 1601 (UTC).
struct FILETIME
{
    ///The low-order part of the file time.
    uint dwLowDateTime;
    ///The high-order part of the file time.
    uint dwHighDateTime;
}

///Used with the RtlUnicodeStringToOemString function.
struct STRING
{
    ///The length of the buffer.
    ushort       Length;
    ///The maximum length of the buffer.
    ushort       MaximumLength;
    ///The address of the buffer.
    const(char)* Buffer;
}

///Specifies a date and time, using individual members for the month, day, year, weekday, hour, minute, second, and
///millisecond. The time is either in coordinated universal time (UTC) or local time, depending on the function that is
///being called.
struct SYSTEMTIME
{
    ///The year. The valid values for this member are 1601 through 30827.
    ushort wYear;
    ///The month. This member can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%"> January </td> </tr> <tr> <td width="40%"> <dl>
    ///<dt>2</dt> </dl> </td> <td width="60%"> February </td> </tr> <tr> <td width="40%"> <dl> <dt>3</dt> </dl> </td>
    ///<td width="60%"> March </td> </tr> <tr> <td width="40%"> <dl> <dt>4</dt> </dl> </td> <td width="60%"> April </td>
    ///</tr> <tr> <td width="40%"> <dl> <dt>5</dt> </dl> </td> <td width="60%"> May </td> </tr> <tr> <td width="40%">
    ///<dl> <dt>6</dt> </dl> </td> <td width="60%"> June </td> </tr> <tr> <td width="40%"> <dl> <dt>7</dt> </dl> </td>
    ///<td width="60%"> July </td> </tr> <tr> <td width="40%"> <dl> <dt>8</dt> </dl> </td> <td width="60%"> August </td>
    ///</tr> <tr> <td width="40%"> <dl> <dt>9</dt> </dl> </td> <td width="60%"> September </td> </tr> <tr> <td
    ///width="40%"> <dl> <dt>10</dt> </dl> </td> <td width="60%"> October </td> </tr> <tr> <td width="40%"> <dl>
    ///<dt>11</dt> </dl> </td> <td width="60%"> November </td> </tr> <tr> <td width="40%"> <dl> <dt>12</dt> </dl> </td>
    ///<td width="60%"> December </td> </tr> </table>
    ushort wMonth;
    ///The day of the week. This member can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"> <dl> <dt>0</dt> </dl> </td> <td width="60%"> Sunday </td> </tr> <tr> <td width="40%">
    ///<dl> <dt>1</dt> </dl> </td> <td width="60%"> Monday </td> </tr> <tr> <td width="40%"> <dl> <dt>2</dt> </dl> </td>
    ///<td width="60%"> Tuesday </td> </tr> <tr> <td width="40%"> <dl> <dt>3</dt> </dl> </td> <td width="60%"> Wednesday
    ///</td> </tr> <tr> <td width="40%"> <dl> <dt>4</dt> </dl> </td> <td width="60%"> Thursday </td> </tr> <tr> <td
    ///width="40%"> <dl> <dt>5</dt> </dl> </td> <td width="60%"> Friday </td> </tr> <tr> <td width="40%"> <dl>
    ///<dt>6</dt> </dl> </td> <td width="60%"> Saturday </td> </tr> </table>
    ushort wDayOfWeek;
    ///The day of the month. The valid values for this member are 1 through 31.
    ushort wDay;
    ///The hour. The valid values for this member are 0 through 23.
    ushort wHour;
    ///The minute. The valid values for this member are 0 through 59.
    ushort wMinute;
    ///The second. The valid values for this member are 0 through 59.
    ushort wSecond;
    ///The millisecond. The valid values for this member are 0 through 999.
    ushort wMilliseconds;
}

///UpdateAssessment contains information that assesses how up-to-date an installed OS is.
struct UpdateAssessment
{
    ///An UpdateAssessmentStatus enumeration detailing how up-to-date the device is, and for what reason.
    UpdateAssessmentStatus status;
    ///An UpdateImpactLevel enumeration detailing whether there is any impact on the device if it has an out-of-date OS.
    UpdateImpactLevel impact;
    ///Describes how much time has elapsed since the device has not installed an applicable update. <b>daysOutOfDate</b>
    ///is calculated by the current time minus the time since the next applicable update has been released, minus any
    ///deferral period. Thus, if an applicable update exists but hasn’t been applied due to deferral, this is
    ///accounted for in the calculation. <b>daysOutOfDate</b> is used to calculate the update impact level.
    uint              daysOutOfDate;
}

///The <b>OSUpdateAssessment</b> structure defines how up-to-date the OS on a targeted device is. This structure is used
///primarily as a return value by GetOSUpdateAssessment, in order to retrieve an OS assessment in a single structure.
struct OSUpdateAssessment
{
    ///<b>true</b> if the OS on the device is no longer supported by Microsoft and will no longer receive servicing
    ///updates; otherwise, <b>false</b>.
    BOOL             isEndOfSupport;
    ///An UpdateAssessment structure containing an assessment against the latest update Microsoft has released.
    UpdateAssessment assessmentForCurrent;
    ///An UpdateAssessment structure containing an assessment against the latest applicable quality update for the
    ///device.
    UpdateAssessment assessmentForUpToDate;
    ///An UpdateAssessmentStatus enumeration that details whether the device is on the latest applicable security
    ///update.
    UpdateAssessmentStatus securityStatus;
    ///Timestamp when the assessment was done.
    FILETIME         assessmentTime;
    ///Timestamp when the release information was updated.
    FILETIME         releaseInfoTime;
    ///The latest OS build that Microsoft has released. This value is used to determine whether a device is current.
    const(wchar)*    currentOSBuild;
    ///The published timestamp of the release date for current OS build.
    FILETIME         currentOSReleaseTime;
    ///The latest applicable OS build in the device's servicing train. This value is used to determine whether a device
    ///is up-to-date.
    const(wchar)*    upToDateOSBuild;
    FILETIME         upToDateOSReleaseTime;
}

struct _PROC_THREAD_ATTRIBUTE_LIST
{
}

///Contains information about the current computer system. This includes the architecture and type of the processor, the
///number of processors in the system, the page size, and other such information.
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
    ///The page size and the granularity of page protection and commitment. This is the page size used by the
    ///VirtualAlloc function.
    uint   dwPageSize;
    ///A pointer to the lowest memory address accessible to applications and dynamic-link libraries (DLLs).
    void*  lpMinimumApplicationAddress;
    ///A pointer to the highest memory address accessible to applications and DLLs.
    void*  lpMaximumApplicationAddress;
    ///A mask representing the set of processors configured into the system. Bit 0 is processor 0; bit 31 is processor
    ///31.
    size_t dwActiveProcessorMask;
    ///The number of logical processors in the current group. To retrieve this value, use the
    ///GetLogicalProcessorInformation function. <div class="alert"><b>Note</b> For information about the physical
    ///processors shared by logical processors, call GetLogicalProcessorInformationEx with the <i>RelationshipType</i>
    ///parameter set to RelationProcessorPackage (3).</div> <div> </div>
    uint   dwNumberOfProcessors;
    ///An obsolete member that is retained for compatibility. Use the <b>wProcessorArchitecture</b>,
    ///<b>wProcessorLevel</b>, and <b>wProcessorRevision</b> members to determine the type of processor.
    uint   dwProcessorType;
    ///The granularity for the starting address at which virtual memory can be allocated. For more information, see
    ///VirtualAlloc.
    uint   dwAllocationGranularity;
    ///The architecture-dependent processor level. It should be used only for display purposes. To determine the feature
    ///set of a processor, use the IsProcessorFeaturePresent function. If <b>wProcessorArchitecture</b> is
    ///PROCESSOR_ARCHITECTURE_INTEL, <b>wProcessorLevel</b> is defined by the CPU vendor. If
    ///<b>wProcessorArchitecture</b> is PROCESSOR_ARCHITECTURE_IA64, <b>wProcessorLevel</b> is set to 1.
    ushort wProcessorLevel;
    ///The architecture-dependent processor revision. The following table shows how the revision value is assembled for
    ///each type of processor architecture. <table> <tr> <th>Processor</th> <th>Value</th> </tr> <tr> <td>Intel Pentium,
    ///Cyrix, or NextGen 586</td> <td>The high byte is the model and the low byte is the stepping. For example, if the
    ///value is <i>xxyy</i>, the model number and stepping can be displayed as follows: Model <i>xx</i>, Stepping
    ///<i>yy</i> </td> </tr> <tr> <td>Intel 80386 or 80486</td> <td>A value of the form <i>xxyz</i>. If <i>xx</i> is
    ///equal to 0xFF, <i>y</i> - 0xA is the model number, and <i>z</i> is the stepping identifier. If <i>xx</i> is not
    ///equal to 0xFF, <i>xx</i> + 'A' is the stepping letter and <i>yz</i> is the minor stepping. </td> </tr> <tr>
    ///<td>ARM</td> <td>Reserved.</td> </tr> </table>
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

///Contains information about a hardware profile. The GetCurrentHwProfile function uses this structure to retrieve the
///current hardware profile for the local computer.
struct HW_PROFILE_INFOA
{
    ///The reported docking state of the computer. This member can be a combination of the following bit values. <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DOCKINFO_DOCKED"></a><a
    ///id="dockinfo_docked"></a><dl> <dt><b>DOCKINFO_DOCKED</b></dt> <dt>0x2</dt> </dl> </td> <td width="60%"> The
    ///computer is docked. </td> </tr> <tr> <td width="40%"><a id="DOCKINFO_UNDOCKED"></a><a
    ///id="dockinfo_undocked"></a><dl> <dt><b>DOCKINFO_UNDOCKED</b></dt> <dt>0x1</dt> </dl> </td> <td width="60%"> The
    ///computer is undocked. This flag is always set for desktop systems that cannot be undocked. </td> </tr> <tr> <td
    ///width="40%"><a id="DOCKINFO_USER_SUPPLIED"></a><a id="dockinfo_user_supplied"></a><dl>
    ///<dt><b>DOCKINFO_USER_SUPPLIED</b></dt> <dt>0x4</dt> </dl> </td> <td width="60%"> If this flag is set,
    ///GetCurrentHwProfile retrieved the current docking state from information provided by the user in the <b>Hardware
    ///Profiles</b> page of the <b>System</b> control panel application. If there is no such value or the value is set
    ///to 0, this flag is set. </td> </tr> <tr> <td width="40%"><a id="DOCKINFO_USER_DOCKED"></a><a
    ///id="dockinfo_user_docked"></a><dl> <dt><b>DOCKINFO_USER_DOCKED</b></dt> <dt>0x5</dt> </dl> </td> <td width="60%">
    ///The computer is docked, according to information provided by the user. This value is a combination of the
    ///DOCKINFO_USER_SUPPLIED and DOCKINFO_DOCKED flags. </td> </tr> <tr> <td width="40%"><a
    ///id="DOCKINFO_USER_UNDOCKED"></a><a id="dockinfo_user_undocked"></a><dl> <dt><b>DOCKINFO_USER_UNDOCKED</b></dt>
    ///<dt>0x6</dt> </dl> </td> <td width="60%"> The computer is undocked, according to information provided by the
    ///user. This value is a combination of the DOCKINFO_USER_SUPPLIED and DOCKINFO_UNDOCKED flags. </td> </tr> </table>
    uint     dwDockInfo;
    ///The globally unique identifier (GUID) string for the current hardware profile. The string returned by
    ///GetCurrentHwProfile encloses the GUID in curly braces, {}; for example: {12340001-4980-1920-6788-123456789012}
    ///You can use this string as a registry subkey under your application's configuration settings key in
    ///<b>HKEY_CURRENT_USER</b>. This enables you to store settings for each hardware profile.
    byte[39] szHwProfileGuid;
    ///The display name for the current hardware profile.
    byte[80] szHwProfileName;
}

///Contains information about a hardware profile. The GetCurrentHwProfile function uses this structure to retrieve the
///current hardware profile for the local computer.
struct HW_PROFILE_INFOW
{
    ///The reported docking state of the computer. This member can be a combination of the following bit values. <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DOCKINFO_DOCKED"></a><a
    ///id="dockinfo_docked"></a><dl> <dt><b>DOCKINFO_DOCKED</b></dt> <dt>0x2</dt> </dl> </td> <td width="60%"> The
    ///computer is docked. </td> </tr> <tr> <td width="40%"><a id="DOCKINFO_UNDOCKED"></a><a
    ///id="dockinfo_undocked"></a><dl> <dt><b>DOCKINFO_UNDOCKED</b></dt> <dt>0x1</dt> </dl> </td> <td width="60%"> The
    ///computer is undocked. This flag is always set for desktop systems that cannot be undocked. </td> </tr> <tr> <td
    ///width="40%"><a id="DOCKINFO_USER_SUPPLIED"></a><a id="dockinfo_user_supplied"></a><dl>
    ///<dt><b>DOCKINFO_USER_SUPPLIED</b></dt> <dt>0x4</dt> </dl> </td> <td width="60%"> If this flag is set,
    ///GetCurrentHwProfile retrieved the current docking state from information provided by the user in the <b>Hardware
    ///Profiles</b> page of the <b>System</b> control panel application. If there is no such value or the value is set
    ///to 0, this flag is set. </td> </tr> <tr> <td width="40%"><a id="DOCKINFO_USER_DOCKED"></a><a
    ///id="dockinfo_user_docked"></a><dl> <dt><b>DOCKINFO_USER_DOCKED</b></dt> <dt>0x5</dt> </dl> </td> <td width="60%">
    ///The computer is docked, according to information provided by the user. This value is a combination of the
    ///DOCKINFO_USER_SUPPLIED and DOCKINFO_DOCKED flags. </td> </tr> <tr> <td width="40%"><a
    ///id="DOCKINFO_USER_UNDOCKED"></a><a id="dockinfo_user_undocked"></a><dl> <dt><b>DOCKINFO_USER_UNDOCKED</b></dt>
    ///<dt>0x6</dt> </dl> </td> <td width="60%"> The computer is undocked, according to information provided by the
    ///user. This value is a combination of the DOCKINFO_USER_SUPPLIED and DOCKINFO_UNDOCKED flags. </td> </tr> </table>
    uint       dwDockInfo;
    ///The globally unique identifier (GUID) string for the current hardware profile. The string returned by
    ///GetCurrentHwProfile encloses the GUID in curly braces, {}; for example: {12340001-4980-1920-6788-123456789012}
    ///You can use this string as a registry subkey under your application's configuration settings key in
    ///<b>HKEY_CURRENT_USER</b>. This enables you to store settings for each hardware profile.
    ushort[39] szHwProfileGuid;
    ///The display name for the current hardware profile.
    ushort[80] szHwProfileName;
}

///Specifies settings for a time zone.
struct TIME_ZONE_INFORMATION
{
    ///The current bias for local time translation on this computer, in minutes. The bias is the difference, in minutes,
    ///between Coordinated Universal Time (UTC) and local time. All translations between UTC and local time are based on
    ///the following formula: UTC = local time + bias This member is required.
    int        Bias;
    ///A description for standard time. For example, "EST" could indicate Eastern Standard Time. The string will be
    ///returned unchanged by the GetTimeZoneInformation function. This string can be empty.
    ushort[32] StandardName;
    ///A SYSTEMTIME structure that contains a date and local time when the transition from daylight saving time to
    ///standard time occurs on this operating system. If the time zone does not support daylight saving time or if the
    ///caller needs to disable daylight saving time, the <b>wMonth</b> member in the <b>SYSTEMTIME</b> structure must be
    ///zero. If this date is specified, the <b>DaylightDate</b> member of this structure must also be specified.
    ///Otherwise, the system assumes the time zone data is invalid and no changes will be applied. To select the correct
    ///day in the month, set the <b>wYear</b> member to zero, the <b>wHour</b> and <b>wMinute</b> members to the
    ///transition time, the <b>wDayOfWeek</b> member to the appropriate weekday, and the <b>wDay</b> member to indicate
    ///the occurrence of the day of the week within the month (1 to 5, where 5 indicates the final occurrence during the
    ///month if that day of the week does not occur 5 times). Using this notation, specify 02:00 on the first Sunday in
    ///April as follows: <b>wHour</b> = 2, <b>wMonth</b> = 4, <b>wDayOfWeek</b> = 0, <b>wDay</b> = 1. Specify 02:00 on
    ///the last Thursday in October as follows: <b>wHour</b> = 2, <b>wMonth</b> = 10, <b>wDayOfWeek</b> = 4, <b>wDay</b>
    ///= 5. If the <b>wYear</b> member is not zero, the transition date is absolute; it will only occur one time.
    ///Otherwise, it is a relative date that occurs yearly.
    SYSTEMTIME StandardDate;
    ///The bias value to be used during local time translations that occur during standard time. This member is ignored
    ///if a value for the <b>StandardDate</b> member is not supplied. This value is added to the value of the
    ///<b>Bias</b> member to form the bias used during standard time. In most time zones, the value of this member is
    ///zero.
    int        StandardBias;
    ///A description for daylight saving time. For example, "PDT" could indicate Pacific Daylight Time. The string will
    ///be returned unchanged by the GetTimeZoneInformation function. This string can be empty.
    ushort[32] DaylightName;
    ///A SYSTEMTIME structure that contains a date and local time when the transition from standard time to daylight
    ///saving time occurs on this operating system. If the time zone does not support daylight saving time or if the
    ///caller needs to disable daylight saving time, the <b>wMonth</b> member in the <b>SYSTEMTIME</b> structure must be
    ///zero. If this date is specified, the <b>StandardDate</b> member in this structure must also be specified.
    ///Otherwise, the system assumes the time zone data is invalid and no changes will be applied. To select the correct
    ///day in the month, set the <b>wYear</b> member to zero, the <b>wHour</b> and <b>wMinute</b> members to the
    ///transition time, the <b>wDayOfWeek</b> member to the appropriate weekday, and the <b>wDay</b> member to indicate
    ///the occurrence of the day of the week within the month (1 to 5, where 5 indicates the final occurrence during the
    ///month if that day of the week does not occur 5 times). If the <b>wYear</b> member is not zero, the transition
    ///date is absolute; it will only occur one time. Otherwise, it is a relative date that occurs yearly.
    SYSTEMTIME DaylightDate;
    ///The bias value to be used during local time translations that occur during daylight saving time. This member is
    ///ignored if a value for the <b>DaylightDate</b> member is not supplied. This value is added to the value of the
    ///<b>Bias</b> member to form the bias used during daylight saving time. In most time zones, the value of this
    ///member is –60.
    int        DaylightBias;
}

///Specifies settings for a time zone and dynamic daylight saving time.
struct DYNAMIC_TIME_ZONE_INFORMATION
{
    ///The current bias for local time translation on this computer, in minutes. The bias is the difference, in minutes,
    ///between Coordinated Universal Time (UTC) and local time. All translations between UTC and local time are based on
    ///the following formula: UTC = local time + bias This member is required.
    int         Bias;
    ///A description for standard time. For example, "EST" could indicate Eastern Standard Time. The string will be
    ///returned unchanged by the GetDynamicTimeZoneInformation function. This string can be empty.
    ushort[32]  StandardName;
    ///A SYSTEMTIME structure that contains a date and local time when the transition from daylight saving time to
    ///standard time occurs on this operating system. If the time zone does not support daylight saving time or if the
    ///caller needs to disable daylight saving time, the <b>wMonth</b> member in the <b>SYSTEMTIME</b> structure must be
    ///zero. If this date is specified, the <b>DaylightDate</b> member of this structure must also be specified.
    ///Otherwise, the system assumes the time zone data is invalid and no changes will be applied. To select the correct
    ///day in the month, set the <b>wYear</b> member to zero, the <b>wHour</b> and <b>wMinute</b> members to the
    ///transition time, the <b>wDayOfWeek</b> member to the appropriate weekday, and the <b>wDay</b> member to indicate
    ///the occurrence of the day of the week within the month (1 to 5, where 5 indicates the final occurrence during the
    ///month if that day of the week does not occur 5 times). Using this notation, specify 02:00 on the first Sunday in
    ///April as follows: <b>wHour</b> = 2, <b>wMonth</b> = 4, <b>wDayOfWeek</b> = 0, <b>wDay</b> = 1. Specify 02:00 on
    ///the last Thursday in October as follows: <b>wHour</b> = 2, <b>wMonth</b> = 10, <b>wDayOfWeek</b> = 4, <b>wDay</b>
    ///= 5. If the <b>wYear</b> member is not zero, the transition date is absolute; it will only occur one time.
    ///Otherwise, it is a relative date that occurs yearly.
    SYSTEMTIME  StandardDate;
    ///The bias value to be used during local time translations that occur during standard time. This member is ignored
    ///if a value for the <b>StandardDate</b> member is not supplied. This value is added to the value of the
    ///<b>Bias</b> member to form the bias used during standard time. In most time zones, the value of this member is
    ///zero.
    int         StandardBias;
    ///A description for daylight saving time (DST). For example, "PDT" could indicate Pacific Daylight Time. The string
    ///will be returned unchanged by the GetDynamicTimeZoneInformation function. This string can be empty.
    ushort[32]  DaylightName;
    ///A SYSTEMTIME structure that contains a date and local time when the transition from standard time to daylight
    ///saving time occurs on this operating system. If the time zone does not support daylight saving time or if the
    ///caller needs to disable daylight saving time, the <b>wMonth</b> member in the <b>SYSTEMTIME</b> structure must be
    ///zero. If this date is specified, the <b>StandardDate</b> member in this structure must also be specified.
    ///Otherwise, the system assumes the time zone data is invalid and no changes will be applied. To select the correct
    ///day in the month, set the <b>wYear</b> member to zero, the <b>wHour</b> and <b>wMinute</b> members to the
    ///transition time, the <b>wDayOfWeek</b> member to the appropriate weekday, and the <b>wDay</b> member to indicate
    ///the occurrence of the day of the week within the month (1 to 5, where 5 indicates the final occurrence during the
    ///month if that day of the week does not occur 5 times). If the <b>wYear</b> member is not zero, the transition
    ///date is absolute; it will only occur one time. Otherwise, it is a relative date that occurs yearly.
    SYSTEMTIME  DaylightDate;
    ///The bias value to be used during local time translations that occur during daylight saving time. This member is
    ///ignored if a value for the <b>DaylightDate</b> member is not supplied. This value is added to the value of the
    ///<b>Bias</b> member to form the bias used during daylight saving time. In most time zones, the value of this
    ///member is –60.
    int         DaylightBias;
    ///The name of the time zone registry key on the local computer. For more information, see Remarks.
    ushort[128] TimeZoneKeyName;
    ///Indicates whether dynamic daylight saving time is disabled. Setting this member to <b>TRUE</b> disables dynamic
    ///daylight saving time, causing the system to use a fixed set of transition dates. To restore dynamic daylight
    ///saving time, call the SetDynamicTimeZoneInformation function with <b>DynamicDaylightTimeDisabled</b> set to
    ///<b>FALSE</b>. The system will read the transition dates for the current year at the next time update, the next
    ///system reboot, or the end of the calendar year (whichever comes first.) When calling the
    ///GetDynamicTimeZoneInformation function, this member is <b>TRUE</b> if the time zone was set using the
    ///SetTimeZoneInformation function instead of SetDynamicTimeZoneInformation or if the user has disabled this feature
    ///using the Date and Time application in Control Panel. To disable daylight saving time, set this member to
    ///<b>TRUE</b>, clear the <b>StandardDate</b> and <b>DaylightDate</b> members, and call
    ///SetDynamicTimeZoneInformation. To restore daylight saving time, call <b>SetDynamicTimeZoneInformation</b> with
    ///<b>DynamicDaylightTimeDisabled</b> set to <b>FALSE</b>.
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

///Contains information about a registry value. The RegQueryMultipleValues function uses this structure.
struct VALENTA
{
    ///The name of the value to be retrieved. Be sure to set this member before calling RegQueryMultipleValues.
    const(char)* ve_valuename;
    ///The size of the data pointed to by <b>ve_valueptr</b>, in bytes.
    uint         ve_valuelen;
    ///A pointer to the data for the value entry. This is a pointer to the value's data returned in the
    ///<b>lpValueBuf</b> buffer filled in by RegQueryMultipleValues.
    size_t       ve_valueptr;
    ///The type of data pointed to by <b>ve_valueptr</b>. For a list of the possible types, see Registry Value Types.
    uint         ve_type;
}

///Contains information about a registry value. The RegQueryMultipleValues function uses this structure.
struct VALENTW
{
    ///The name of the value to be retrieved. Be sure to set this member before calling RegQueryMultipleValues.
    const(wchar)* ve_valuename;
    ///The size of the data pointed to by <b>ve_valueptr</b>, in bytes.
    uint          ve_valuelen;
    ///A pointer to the data for the value entry. This is a pointer to the value's data returned in the
    ///<b>lpValueBuf</b> buffer filled in by RegQueryMultipleValues.
    size_t        ve_valueptr;
    ///The type of data pointed to by <b>ve_valueptr</b>. For a list of the possible types, see Registry Value Types.
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

///The <b>OBJECT_ATTRIBUTES</b> structure specifies attributes that can be applied to objects or object handles by
///routines that create objects and/or return handles to objects.
struct OBJECT_ATTRIBUTES
{
    ///The number of bytes of data contained in this structure. The
    ///[InitializeObjectAttributes](./nf-ntdef-initializeobjectattributes.md) macro sets this member to
    ///<b>sizeof</b>(<b>OBJECT_ATTRIBUTES</b>).
    uint            Length;
    ///Optional handle to the root object directory for the path name specified by the <b>ObjectName</b> member. If
    ///<b>RootDirectory</b> is <b>NULL</b>, <b>ObjectName</b> must point to a fully qualified object name that includes
    ///the full path to the target object. If <b>RootDirectory</b> is non-<b>NULL</b>, <b>ObjectName</b> specifies an
    ///object name relative to the <b>RootDirectory</b> directory. The <b>RootDirectory</b> handle can refer to a file
    ///system directory or an object directory in the object manager namespace.
    HANDLE          RootDirectory;
    ///Pointer to a [Unicode string](./ns-ntdef-_unicode_string.md) that contains the name of the object for which a
    ///handle is to be opened. This must either be a fully qualified object name, or a relative path name to the
    ///directory specified by the <b>RootDirectory</b> member.
    UNICODE_STRING* ObjectName;
    ///Bitmask of flags that specify object handle attributes. This member can contain one or more of the flags in the
    ///following table. <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td> OBJ_INHERIT </td> <td> This handle
    ///can be inherited by child processes of the current process. </td> </tr> <tr> <td> OBJ_PERMANENT </td> <td> This
    ///flag only applies to objects that are named within the object manager. By default, such objects are deleted when
    ///all open handles to them are closed. If this flag is specified, the object is not deleted when all open handles
    ///are closed. Drivers can use the ZwMakeTemporaryObject routine to make a permanent object non-permanent. </td>
    ///</tr> <tr> <td> OBJ_EXCLUSIVE </td> <td> If this flag is set and the <b>OBJECT_ATTRIBUTES</b> structure is passed
    ///to a routine that creates an object, the object can be accessed exclusively. That is, once a process opens such a
    ///handle to the object, no other processes can open handles to this object. If this flag is set and the
    ///<b>OBJECT_ATTRIBUTES</b> structure is passed to a routine that creates an object handle, the caller is requesting
    ///exclusive access to the object for the process context that the handle was created in. This request can be
    ///granted only if the OBJ_EXCLUSIVE flag was set when the object was created. </td> </tr> <tr> <td>
    ///OBJ_CASE_INSENSITIVE </td> <td> If this flag is specified, a case-insensitive comparison is used when matching
    ///the name pointed to by the <b>ObjectName</b> member against the names of existing objects. Otherwise, object
    ///names are compared using the default system settings. </td> </tr> <tr> <td> OBJ_OPENIF </td> <td> If this flag is
    ///specified, by using the object handle, to a routine that creates objects and if that object already exists, the
    ///routine should open that object. Otherwise, the routine creating the object returns an NTSTATUS code of
    ///STATUS_OBJECT_NAME_COLLISION. </td> </tr> <tr> <td> OBJ_OPENLINK </td> <td> If an object handle, with this flag
    ///set, is passed to a routine that opens objects and if the object is a symbolic link object, the routine should
    ///open the symbolic link object itself, rather than the object that the symbolic link refers to (which is the
    ///default behavior). </td> </tr> <tr> <td> OBJ_KERNEL_HANDLE </td> <td> The handle is created in system process
    ///context and can only be accessed from kernel mode. </td> </tr> <tr> <td> OBJ_FORCE_ACCESS_CHECK </td> <td> The
    ///routine that opens the handle should enforce all access checks for the object, even if the handle is being opened
    ///in kernel mode. </td> </tr> <tr> <td> OBJ_DONT_REPARSE </td> <td> If this flag is set, no reparse points will be
    ///followed when parsing the name of the associated object. If any reparses are encountered the attempt will fail
    ///and return an <b>STATUS_REPARSE_POINT_ENCOUNTERED</b> result. This can be used to determine if there are any
    ///reparse points in the object's path, in security scenarios. </td> </tr> <tr> <td>
    ///OBJ_IGNORE_IMPERSONATED_DEVICEMAP </td> <td> A device map is a mapping between DOS device names and devices in
    ///the system, and is used when resolving DOS names. Separate device maps exists for each user in the system, and
    ///users can manage their own device maps. Typically during impersonation, the impersonated user's device map would
    ///be used. However, when this flag is set, the process user's device map is used instead. </td> </tr> <tr> <td>
    ///OBJ_VALID_ATTRIBUTES </td> <td> Reserved. </td> </tr> </table>
    uint            Attributes;
    ///Specifies a security descriptor (SECURITY_DESCRIPTOR) for the object when the object is created. If this member
    ///is <b>NULL</b>, the object will receive default security settings.
    void*           SecurityDescriptor;
    ///Optional quality of service to be applied to the object when it is created. Used to indicate the security
    ///impersonation level and context tracking mode (dynamic or static). Currently, the
    ///[InitializeObjectAttributes](./nf-ntdef-initializeobjectattributes.md) macro sets this member to <b>NULL</b>.
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

///Contains information about backtraces performed.
struct AVRF_BACKTRACE_INFORMATION
{
    ///The number of traces that have been collected.
    uint      Depth;
    ///A unique identifier associated with the entire set of returned addresses.
    uint      Index;
    ///An array of addresses returned traces. The number cannot exceed AVRF_MAX_TRACES, which is defined as 32.
    ulong[32] ReturnAddresses;
}

///Stores metadata information about heap allocation.
struct AVRF_HEAP_ALLOCATION
{
    ///The handle to the heap being enumerated.
    ulong HeapHandle;
    ///The address of the heap allocation as seen by the application.
    ulong UserAllocation;
    ///The size, in bytes, of the application's allocation on the heap.
    ulong UserAllocationSize;
    ///The address of the heap allocation as seen by the operating system.
    ulong Allocation;
    ///The size, in bytes, of the heap allocation as seen by the operating system.
    ulong AllocationSize;
    ///One of the values in the eUserAllocationState enumerated type.
    uint  UserAllocationState;
    ///The state of the heap allocation. The user can extract one of the values in the eHeapAllocationState enum after
    ///AND-ing the <b>HeapStateMask</b> value.
    uint  HeapState;
    ///The context of the heap currently allocated.
    ulong HeapContext;
    ///A pointer to an AVRF_BACKTRACE_INFORMATION structure containing information about the last operation that
    ///occurred on the allocation. When available, it can be the stack backtrace of the place where the address
    ///specified in the <b>UserAllocation</b> member of the structure was allocated (if <b>UserAllocationState</b> is
    ///<b>AllocationstateBusy</b>) or where the address specified in the <b>UserAllocation</b> member was freed (if
    ///<b>UserAllocationState</b> is <b>AllocationStateFree</b>).
    AVRF_BACKTRACE_INFORMATION* BackTraceInformation;
}

///Contains information required to collect handle trace information.
struct AVRF_HANDLE_OPERATION
{
    ///The handle to the heap in which handle traces are being enumerated.
    ulong Handle;
    ///A unique identifier associated with the process in which the application is running.
    uint  ProcessId;
    ///A unique identifier of the thread (returned by the GetCurrentThreadId function) that has performed an operation
    ///on the given handle.
    uint  ThreadId;
    ///One of the constants in the eHANDLE_TRACE_OPERATIONS enum that indicate whether the handle operation is an
    ///open(create), close, or invalid.
    uint  OperationType;
    ///The alignment of the structure on a natural boundary even if the user has changed the size of the original
    ///structure.
    uint  Spare0;
    ///Identifies the AVRF_BACKTRACE_INFORMATION structure containing information required for completing the
    ///enumeration of handles.
    AVRF_BACKTRACE_INFORMATION BackTraceInformation;
}

///<p class="CCE_Message">[This structure contains information required by the <b>Extract</b> function, which is not
///supported. This documentation is provided for informational purposes only.] The <b>ERF</b> structure contains error
///information from FCI/FDI. The caller should not modify this structure.
struct ERF
{
    ///An FCI/FDI error code. The following values are returned for FCI: <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="FCIERR_NONE"></a><a id="fcierr_none"></a><dl> <dt><b>FCIERR_NONE</b></dt>
    ///<dt>0x00</dt> </dl> </td> <td width="60%"> No Error. </td> </tr> <tr> <td width="40%"><a
    ///id="FCIERR_OPEN_SRC"></a><a id="fcierr_open_src"></a><dl> <dt><b>FCIERR_OPEN_SRC</b></dt> <dt>0x01</dt> </dl>
    ///</td> <td width="60%"> Failure opening the file to be stored in the cabinet. </td> </tr> <tr> <td width="40%"><a
    ///id="FCIERR_READ_SRC"></a><a id="fcierr_read_src"></a><dl> <dt><b>FCIERR_READ_SRC</b></dt> <dt>0x02</dt> </dl>
    ///</td> <td width="60%"> Failure reading the file to be stored in the cabinet. </td> </tr> <tr> <td width="40%"><a
    ///id="FCIERR_ALLOC_FAIL"></a><a id="fcierr_alloc_fail"></a><dl> <dt><b>FCIERR_ALLOC_FAIL</b></dt> <dt>0x03</dt>
    ///</dl> </td> <td width="60%"> Out of memory in FCI. </td> </tr> <tr> <td width="40%"><a
    ///id="FCIERR_TEMP_FILE"></a><a id="fcierr_temp_file"></a><dl> <dt><b>FCIERR_TEMP_FILE</b></dt> <dt>0x04</dt> </dl>
    ///</td> <td width="60%"> Could not create a temporary file. </td> </tr> <tr> <td width="40%"><a
    ///id="FCIERR_BAD_COMPR_TYPE"></a><a id="fcierr_bad_compr_type"></a><dl> <dt><b>FCIERR_BAD_COMPR_TYPE</b></dt>
    ///<dt>0x05</dt> </dl> </td> <td width="60%"> Unknown compression type. </td> </tr> <tr> <td width="40%"><a
    ///id="FCIERR_CAB_FILE"></a><a id="fcierr_cab_file"></a><dl> <dt><b>FCIERR_CAB_FILE</b></dt> <dt>0x06</dt> </dl>
    ///</td> <td width="60%"> Could not create the cabinet file. </td> </tr> <tr> <td width="40%"><a
    ///id="FCIERR_USER_ABORT"></a><a id="fcierr_user_abort"></a><dl> <dt><b>FCIERR_USER_ABORT</b></dt> <dt>0x07</dt>
    ///</dl> </td> <td width="60%"> FCI aborted. </td> </tr> <tr> <td width="40%"><a id="FCIERR_MCI_FAIL"></a><a
    ///id="fcierr_mci_fail"></a><dl> <dt><b>FCIERR_MCI_FAIL</b></dt> <dt>0x08</dt> </dl> </td> <td width="60%"> Failure
    ///compressing data. </td> </tr> <tr> <td width="40%"><a id="FCIERR_CAB_FORMAT_LIMIT"></a><a
    ///id="fcierr_cab_format_limit"></a><dl> <dt><b>FCIERR_CAB_FORMAT_LIMIT</b></dt> <dt>0x09</dt> </dl> </td> <td
    ///width="60%"> Data-size or file-count exceeded CAB format limits. </td> </tr> </table> The following values are
    ///returned for FDI: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="FDIERROR_NONE"></a><a id="fdierror_none"></a><dl> <dt><b>FDIERROR_NONE</b></dt> <dt>0x00</dt> </dl> </td> <td
    ///width="60%"> No error. </td> </tr> <tr> <td width="40%"><a id="FDIERROR_CABINET_NOT_FOUND"></a><a
    ///id="fdierror_cabinet_not_found"></a><dl> <dt><b>FDIERROR_CABINET_NOT_FOUND</b></dt> <dt>0x01</dt> </dl> </td> <td
    ///width="60%"> The cabinet file was not found. </td> </tr> <tr> <td width="40%"><a
    ///id="FDIERROR_NOT_A_CABINET"></a><a id="fdierror_not_a_cabinet"></a><dl> <dt><b>FDIERROR_NOT_A_CABINET</b></dt>
    ///<dt>0x02</dt> </dl> </td> <td width="60%"> The cabinet file does not have the correct format. </td> </tr> <tr>
    ///<td width="40%"><a id="FDIERROR_UNKNOWN_CABINET_VERSION"></a><a id="fdierror_unknown_cabinet_version"></a><dl>
    ///<dt><b>FDIERROR_UNKNOWN_CABINET_VERSION</b></dt> <dt>0x03</dt> </dl> </td> <td width="60%"> The cabinet file has
    ///an unknown version number. </td> </tr> <tr> <td width="40%"><a id="FDIERROR_CORRUPT_CABINET"></a><a
    ///id="fdierror_corrupt_cabinet"></a><dl> <dt><b>FDIERROR_CORRUPT_CABINET</b></dt> <dt>0x04</dt> </dl> </td> <td
    ///width="60%"> The cabinet file is corrupt. </td> </tr> <tr> <td width="40%"><a id="FDIERROR_ALLOC_FAIL"></a><a
    ///id="fdierror_alloc_fail"></a><dl> <dt><b>FDIERROR_ALLOC_FAIL</b></dt> <dt>0x05</dt> </dl> </td> <td width="60%">
    ///Insufficient memory. </td> </tr> <tr> <td width="40%"><a id="FDIERROR_BAD_COMPR_TYPE"></a><a
    ///id="fdierror_bad_compr_type"></a><dl> <dt><b>FDIERROR_BAD_COMPR_TYPE</b></dt> <dt>0x06</dt> </dl> </td> <td
    ///width="60%"> Unknown compression type used in the cabinet folder. </td> </tr> <tr> <td width="40%"><a
    ///id="FDIERROR_MDI_FAIL"></a><a id="fdierror_mdi_fail"></a><dl> <dt><b>FDIERROR_MDI_FAIL</b></dt> <dt>0x07</dt>
    ///</dl> </td> <td width="60%"> Failure decompressing data from the cabinet file. </td> </tr> <tr> <td
    ///width="40%"><a id="FDIERROR_TARGET_FILE"></a><a id="fdierror_target_file"></a><dl>
    ///<dt><b>FDIERROR_TARGET_FILE</b></dt> <dt>0x08</dt> </dl> </td> <td width="60%"> Failure writing to the target
    ///file. </td> </tr> <tr> <td width="40%"><a id="FDIERROR_RESERVE_MISMATCH"></a><a
    ///id="fdierror_reserve_mismatch"></a><dl> <dt><b>FDIERROR_RESERVE_MISMATCH</b></dt> <dt>0x09</dt> </dl> </td> <td
    ///width="60%"> The cabinets within a set do not have the same RESERVE sizes. </td> </tr> <tr> <td width="40%"><a
    ///id="FDIERROR_WRONG_CABINET"></a><a id="fdierror_wrong_cabinet"></a><dl> <dt><b>FDIERROR_WRONG_CABINET</b></dt>
    ///<dt>0x0A</dt> </dl> </td> <td width="60%"> The cabinet returned by fdintNEXT_CABINET is incorrect. </td> </tr>
    ///<tr> <td width="40%"><a id="FDIERROR_USER_ABORT"></a><a id="fdierror_user_abort"></a><dl>
    ///<dt><b>FDIERROR_USER_ABORT</b></dt> <dt>0x0B</dt> </dl> </td> <td width="60%"> FDI aborted. </td> </tr> </table>
    int  erfOper;
    ///An optional error value filled in by FCI/FDI. For FCI, this is usually the C runtime errno value.
    int  erfType;
    ///A flag that indicates an error. If <b>TRUE</b>, an error is present.
    BOOL fError;
}

///The <b>CCAB</b> structure contains cabinet information.
struct CCAB
{
    ///The maximum size, in bytes, of a cabinet created by FCI.
    uint      cb;
    ///The maximum size, in bytes, that a folder will contain before a new folder is created.
    uint      cbFolderThresh;
    uint      cbReserveCFHeader;
    ///The size, in bytes, of the CFFolder reserve area. Possible value range is 0-255.
    uint      cbReserveCFFolder;
    ///The size, in bytes, of the CFData reserve area. Possible value range is 0-255.
    uint      cbReserveCFData;
    ///The number of created cabinets.
    int       iCab;
    ///The maximum size, in bytes, of a cabinet created by FCI.
    int       iDisk;
    ///TBD
    int       fFailOnIncompressible;
    ///A value that represents the association between a collection of linked cabinet files.
    ushort    setID;
    ///The name of the disk on which the cabinet is placed.
    byte[256] szDisk;
    ///The name of the cabinet.
    byte[256] szCab;
    ///The full path that indicates where to create the cabinet.
    byte[256] szCabPath;
}

///The <b>FDICABINETINFO</b> structure contains details about a particular cabinet file.
struct FDICABINETINFO
{
    ///The total length of the cabinet file.
    int    cbCabinet;
    ///The count of the folders in the cabinet.
    ushort cFolders;
    ///The count of the files in the cabinet.
    ushort cFiles;
    ///The identifier of the cabinet set.
    ushort setID;
    ///The cabinet number in set. This index is zero based.
    ushort iCabinet;
    ///If this value is set to <b>TRUE</b>, a reserved area is present in the cabinet.
    BOOL   fReserve;
    ///If this value is set to <b>TRUE</b>, the cabinet is linked to a previous cabinet. This is accomplished by having
    ///a file continued from the previous cabinet into the current one.
    BOOL   hasprev;
    ///If this value is set to <b>TRUE</b>, the current cabinet is linked to the next cabinet by having a file continued
    ///from the current cabinet into the next one.
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

///The <b>FDINOTIFICATION</b> structure to provide information to FNFDINOTIFY.
struct FDINOTIFICATION
{
    ///The size, in bytes, of a cabinet element.
    int       cb;
    ///A null-terminated string.
    byte*     psz1;
    ///A null-terminated string.
    byte*     psz2;
    ///A null-terminated string.
    byte*     psz3;
    ///Pointer to an application-defined value.
    void*     pv;
    ///Application-defined value used to identify the opened file.
    ptrdiff_t hf;
    ///The MS-DOS date. <table> <tr> <th>Bits</th> <th>Description</th> </tr> <tr> <td>0-4</td> <td>Day of the month
    ///(1-31)</td> </tr> <tr> <td>5-8</td> <td>Month (1 = January, 2 = February, etc.)</td> </tr> <tr> <td>9-15</td>
    ///<td>Year offset from 1980 (add 1980</td> </tr> </table>
    ushort    date;
    ///The MS-DOS time. <table> <tr> <th>Bits</th> <th>Description</th> </tr> <tr> <td>0-4</td> <td>Second divided by
    ///2</td> </tr> <tr> <td>5-10</td> <td>Minute (0-59)</td> </tr> <tr> <td>11-15</td> <td>Hour (0-23 on a 24-hour
    ///clock)</td> </tr> </table>
    ushort    time;
    ///The file attributes. For possible values and their descriptions, see File Attributes.
    ushort    attribs;
    ///The identifier for a cabinet set.
    ushort    setID;
    ///The number of the cabinets within a set.
    ushort    iCabinet;
    ///The number of folders within a cabinet.
    ushort    iFolder;
    ///An FDI error code. Possible values include: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="FDIERROR_NONE"></a><a id="fdierror_none"></a><dl> <dt><b>FDIERROR_NONE</b></dt> <dt>0x00</dt>
    ///</dl> </td> <td width="60%"> No error. </td> </tr> <tr> <td width="40%"><a id="FDIERROR_CABINET_NOT_FOUND"></a><a
    ///id="fdierror_cabinet_not_found"></a><dl> <dt><b>FDIERROR_CABINET_NOT_FOUND</b></dt> <dt>0x01</dt> </dl> </td> <td
    ///width="60%"> The cabinet file was not found. </td> </tr> <tr> <td width="40%"><a
    ///id="FDIERROR_NOT_A_CABINET"></a><a id="fdierror_not_a_cabinet"></a><dl> <dt><b>FDIERROR_NOT_A_CABINET</b></dt>
    ///<dt>0x02</dt> </dl> </td> <td width="60%"> The cabinet file does not have the correct format. </td> </tr> <tr>
    ///<td width="40%"><a id="FDIERROR_UNKNOWN_CABINET_VERSION"></a><a id="fdierror_unknown_cabinet_version"></a><dl>
    ///<dt><b>FDIERROR_UNKNOWN_CABINET_VERSION</b></dt> <dt>0x03</dt> </dl> </td> <td width="60%"> The cabinet file has
    ///an unknown version number. </td> </tr> <tr> <td width="40%"><a id="FDIERROR_CORRUPT_CABINET"></a><a
    ///id="fdierror_corrupt_cabinet"></a><dl> <dt><b>FDIERROR_CORRUPT_CABINET</b></dt> <dt>0x04</dt> </dl> </td> <td
    ///width="60%"> The cabinet file is corrupt. </td> </tr> <tr> <td width="40%"><a id="FDIERROR_ALLOC_FAIL"></a><a
    ///id="fdierror_alloc_fail"></a><dl> <dt><b>FDIERROR_ALLOC_FAIL</b></dt> <dt>0x05</dt> </dl> </td> <td width="60%">
    ///Insufficient memory. </td> </tr> <tr> <td width="40%"><a id="FDIERROR_BAD_COMPR_TYPE"></a><a
    ///id="fdierror_bad_compr_type"></a><dl> <dt><b>FDIERROR_BAD_COMPR_TYPE</b></dt> <dt>0x06</dt> </dl> </td> <td
    ///width="60%"> Unknown compression type used in the cabinet folder. </td> </tr> <tr> <td width="40%"><a
    ///id="FDIERROR_MDI_FAIL"></a><a id="fdierror_mdi_fail"></a><dl> <dt><b>FDIERROR_MDI_FAIL</b></dt> <dt>0x07</dt>
    ///</dl> </td> <td width="60%"> Failure decompressing data from the cabinet file. </td> </tr> <tr> <td
    ///width="40%"><a id="FDIERROR_TARGET_FILE"></a><a id="fdierror_target_file"></a><dl>
    ///<dt><b>FDIERROR_TARGET_FILE</b></dt> <dt>0x08</dt> </dl> </td> <td width="60%"> Failure writing to the target
    ///file. </td> </tr> <tr> <td width="40%"><a id="FDIERROR_RESERVE_MISMATCH"></a><a
    ///id="fdierror_reserve_mismatch"></a><dl> <dt><b>FDIERROR_RESERVE_MISMATCH</b></dt> <dt>0x09</dt> </dl> </td> <td
    ///width="60%"> The cabinets within a set do not have the same RESERVE sizes. </td> </tr> <tr> <td width="40%"><a
    ///id="FDIERROR_WRONG_CABINET"></a><a id="fdierror_wrong_cabinet"></a><dl> <dt><b>FDIERROR_WRONG_CABINET</b></dt>
    ///<dt>0x0A</dt> </dl> </td> <td width="60%"> The cabinet returned by fdintNEXT_CABINET is incorrect. </td> </tr>
    ///<tr> <td width="40%"><a id="FDIERROR_USER_ABORT"></a><a id="fdierror_user_abort"></a><dl>
    ///<dt><b>FDIERROR_USER_ABORT</b></dt> <dt>0x0B</dt> </dl> </td> <td width="60%"> FDI aborted. </td> </tr> </table>
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

///This structure is intended for infrastructure use only. Do not use this structure.
struct FEATURE_ERROR
{
    ///Infrastructure use only.
    HRESULT      hr;
    ///Infrastructure use only.
    ushort       lineNumber;
    ///Infrastructure use only.
    const(char)* file;
    ///Infrastructure use only.
    const(char)* process;
    ///Infrastructure use only.
    const(char)* module_;
    ///Infrastructure use only.
    uint         callerReturnAddressOffset;
    ///Infrastructure use only.
    const(char)* callerModule;
    ///Infrastructure use only.
    const(char)* message;
    ///Infrastructure use only.
    ushort       originLineNumber;
    ///Infrastructure use only.
    const(char)* originFile;
    ///Infrastructure use only.
    const(char)* originModule;
    ///Infrastructure use only.
    uint         originCallerReturnAddressOffset;
    ///Infrastructure use only.
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

///Represents a registry string replacement.
struct STRENTRYA
{
    ///The name of the string to substitute.
    const(char)* pszName;
    ///The replacement string.
    const(char)* pszValue;
}

///Represents a registry string replacement.
struct STRENTRYW
{
    ///The name of the string to substitute.
    const(wchar)* pszName;
    ///The replacement string.
    const(wchar)* pszValue;
}

///Represents a table of registry string replacements.
struct STRTABLEA
{
    ///The number of entries in the table.
    uint       cEntries;
    ///And array of entries.
    STRENTRYA* pse;
}

///Represents a table of registry string replacements.
struct STRTABLEW
{
    ///The number of entries in the table.
    uint       cEntries;
    ///And array of entries.
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

///Used by SendIMEMessageEx to specify the subfunction to be executed in the Input Method Editor (IME) message and its
///parameters. This structure is also used to receive return values from those subfunctions.
struct IMESTRUCT
{
    ///A subfunction. One of the following values.
    uint   fnc;
    ///Usage depends on the subfunction specified in <b>fnc</b>.
    WPARAM wParam;
    ///Usage depends on the subfunction specified in <b>fnc</b>.
    uint   wCount;
    ///Usage depends on the subfunction specified in <b>fnc</b>.
    uint   dchSource;
    ///Usage depends on the subfunction specified in <b>fnc</b>.
    uint   dchDest;
    ///Usage depends on the subfunction specified in <b>fnc</b>.
    LPARAM lParam1;
    ///Usage depends on the subfunction specified in <b>fnc</b>.
    LPARAM lParam2;
    ///Usage depends on the subfunction specified in <b>fnc</b>.
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

///Contains trust information.
struct JAVA_TRUST
{
    ///The size of this structure, in bytes.
    uint          cbSize;
    ///Reserved.
    uint          flag;
    ///Indicates whether all ActiveX permissions were requested.
    BOOL          fAllActiveXPermissions;
    ///Indicates whether all Java permissions were requested.
    BOOL          fAllPermissions;
    ///The encoding type. This member can be <b>X509_ASN_ENCODING</b> or <b>PKCS_7_ASN_ENCODING</b>.
    uint          dwEncodingType;
    ///The encoded permission blob.
    ubyte*        pbJavaPermissions;
    ///The size of the <b>pbJavaPermissions</b> buffer, in bytes.
    uint          cbJavaPermissions;
    ///The encoded signer.
    ubyte*        pbSigner;
    ///The size of the <b>pbSigner</b> buffer, in bytes.
    uint          cbSigner;
    ///The zone index.
    const(wchar)* pwszZone;
    ///Reserved.
    GUID          guidZone;
    ///The authenticode policy return code.
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

///Represents a name cache. This structure does not contain any fields that are useful to a client, but it must be
///passed back into all of the name cache APIs.
struct NAME_CACHE_CONTEXT
{
    uint m_dwSignature;
}

///<p class="CCE_Message">[This structure may be altered or unavailable in future versions of Windows.] Contains a part
///of the TDIObjectID structure to represent information about TDI drivers retrieved using the
///IOCTL_TCP_QUERY_INFORMATION_EX control code.
struct TDIEntityID
{
    ///The type of entity being addressed. This member can be one of the following values. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="GENERIC_ENTITY"></a><a id="generic_entity"></a><dl>
    ///<dt><b>GENERIC_ENTITY</b></dt> </dl> </td> <td width="60%"> Used when requesting a list of all entities. </td>
    ///</tr> <tr> <td width="40%"><a id="AT_ENTITY"></a><a id="at_entity"></a><dl> <dt><b>AT_ENTITY</b></dt> </dl> </td>
    ///<td width="60%"> Identifies an address-translation (AT) entity. </td> </tr> <tr> <td width="40%"><a
    ///id="CL_NL_ENTITY"></a><a id="cl_nl_entity"></a><dl> <dt><b>CL_NL_ENTITY</b></dt> </dl> </td> <td width="60%">
    ///Identifies a connectionless (CL) network-layer (NL) entity. </td> </tr> <tr> <td width="40%"><a
    ///id="CO_NL_ENTITY"></a><a id="co_nl_entity"></a><dl> <dt><b>CO_NL_ENTITY</b></dt> </dl> </td> <td width="60%">
    ///Identifies a connected, directed-packet (CO) network-layer (NL) entity. </td> </tr> <tr> <td width="40%"><a
    ///id="CL_TL_ENTITY"></a><a id="cl_tl_entity"></a><dl> <dt><b>CL_TL_ENTITY</b></dt> </dl> </td> <td width="60%">
    ///Identifies a connectionless (CL) transport-layer (TL) entity. </td> </tr> <tr> <td width="40%"><a
    ///id="CO_TL_ENTITY"></a><a id="co_tl_entity"></a><dl> <dt><b>CO_TL_ENTITY</b></dt> </dl> </td> <td width="60%">
    ///Identifies a connected, directed-packet (CO) transport-layer (TL) entity. </td> </tr> <tr> <td width="40%"><a
    ///id="ER_ENTITY"></a><a id="er_entity"></a><dl> <dt><b>ER_ENTITY</b></dt> </dl> </td> <td width="60%"> Identifies
    ///an Echo-Request/Echo-Reply (ER) entity. </td> </tr> <tr> <td width="40%"><a id="IF_ENTITY"></a><a
    ///id="if_entity"></a><dl> <dt><b>IF_ENTITY</b></dt> </dl> </td> <td width="60%"> Identifies an interface entity.
    ///</td> </tr> </table>
    uint tei_entity;
    ///An opaque value that can uniquely identify an entity, if a specific one is being addressed.
    uint tei_instance;
}

///<p class="CCE_Message">[This structure may be altered or unavailable in future versions of Windows.] Contains a part
///of the TCP_REQUEST_QUERY_INFORMATION_EX structure that is used with the IOCTL_TCP_QUERY_INFORMATION_EX control code
///to specify the kind of information being requested from the TCP driver.
struct TDIObjectID
{
    ///This is a TDIEntityID structure.
    TDIEntityID toi_entity;
    ///The kind of information being requested. The value can be one of the following. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="INFO_CLASS_GENERIC"></a><a id="info_class_generic"></a><dl>
    ///<dt><b>INFO_CLASS_GENERIC</b></dt> </dl> </td> <td width="60%"> Used when requesting an enumeration of all TDI
    ///entities on the current machine, or when determining the type of one of those TDI entities. </td> </tr> <tr> <td
    ///width="40%"><a id="INFO_CLASS_PROTOCOL"></a><a id="info_class_protocol"></a><dl>
    ///<dt><b>INFO_CLASS_PROTOCOL</b></dt> </dl> </td> <td width="60%"> Used when requesting information about a
    ///specific interface or IP entity. </td> </tr> </table>
    uint        toi_class;
    ///The type of object being queried. The value can be one of the following. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="INFO_TYPE_PROVIDER"></a><a id="info_type_provider"></a><dl>
    ///<dt><b>INFO_TYPE_PROVIDER</b></dt> </dl> </td> <td width="60%"> A service provider. All queries described in the
    ///IOCTL_TCP_QUERY_INFORMATION_EX topic use this type value. </td> </tr> <tr> <td width="40%"><a
    ///id="INFO_TYPE_ADDRESS_OBJECT"></a><a id="info_type_address_object"></a><dl>
    ///<dt><b>INFO_TYPE_ADDRESS_OBJECT</b></dt> </dl> </td> <td width="60%"> An address object. </td> </tr> <tr> <td
    ///width="40%"><a id="INFO_TYPE_CONNECTION"></a><a id="info_type_connection"></a><dl>
    ///<dt><b>INFO_TYPE_CONNECTION</b></dt> </dl> </td> <td width="60%"> A connection object. </td> </tr> </table>
    uint        toi_type;
    ///If <b>toi_class</b> is <b>INFO_CLASS_GENERIC</b>, <b>toi_id</b> can be one of the following. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="ENTITY_LIST_ID"></a><a
    ///id="entity_list_id"></a><dl> <dt><b>ENTITY_LIST_ID</b></dt> </dl> </td> <td width="60%"> The query returns a list
    ///of all TDI entities on the local machine. </td> </tr> <tr> <td width="40%"><a id="ENTITY_TYPE_ID"></a><a
    ///id="entity_type_id"></a><dl> <dt><b>ENTITY_TYPE_ID</b></dt> </dl> </td> <td width="60%"> The query returns a type
    ///value for a specified TDI entity. </td> </tr> </table> If <b>toi_class</b> is <b>INFO_CLASS_PROTOCOL</b>,
    ///<b>toi_id</b> can be one of the following. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="IF_MIB_STATS_ID"></a><a id="if_mib_stats_id"></a><dl> <dt><b>IF_MIB_STATS_ID</b></dt> </dl>
    ///</td> <td width="60%"> When the entity being queried is an interface supporting MIB-II, causes the query to
    ///return an IFEntry structure that contains information about the interface. </td> </tr> <tr> <td width="40%"><a
    ///id="IP_MIB_STATS_ID"></a><a id="ip_mib_stats_id"></a><dl> <dt><b>IP_MIB_STATS_ID</b></dt> </dl> </td> <td
    ///width="60%"> When the entity being queried is a network-layer IP entity, causes the query to return an IPSNMPInfo
    ///structure that contains information about the entity. </td> </tr> <tr> <td width="40%"><a
    ///id="IP_MIB_ADDRTABLE_ENTRY_ID"></a><a id="ip_mib_addrtable_entry_id"></a><dl>
    ///<dt><b>IP_MIB_ADDRTABLE_ENTRY_ID</b></dt> </dl> </td> <td width="60%"> When the entity being queried is a
    ///network-layer IP entity on which one or more IP addresses are active, causes the query to return an array of
    ///IPAddrEntry structures that contain information about those addresses. </td> </tr> <tr> <td width="40%"><a
    ///id="IP_INTFC_INFO_ID"></a><a id="ip_intfc_info_id"></a><dl> <dt><b>IP_INTFC_INFO_ID</b></dt> </dl> </td> <td
    ///width="60%"> Causes an IPInterfaceInfo structure to be returned with information about a specific IP address
    ///specified in the <b>Context</b> member of the TCP_REQUEST_QUERY_INFORMATION_EX structure. </td> </tr> </table>
    uint        toi_id;
}

///<p class="CCE_Message">[This structure may be altered or unavailable in future versions of Windows.] Contains the
///input for the IOCTL_TCP_QUERY_INFORMATION_EX control code.
struct tcp_request_query_information_ex_xp
{
    ///The TDIObjectID structure that defines the type of information being requested from the TCP driver by
    ///IOCTL_TCP_QUERY_INFORMATION_EX.
    TDIObjectID ID;
    ///The IPv4 or IPv6 address to be used when IPInterfaceInfo data is requested for a particular IP address.
    size_t[4]   Context;
}

///<p class="CCE_Message">[This structure may be altered or unavailable in future versions of Windows.] Contains the
///input for the IOCTL_TCP_QUERY_INFORMATION_EX control code.
struct tcp_request_query_information_ex_w2k
{
    ///The TDIObjectID structure that defines the type of information being requested from the TCP driver by
    ///IOCTL_TCP_QUERY_INFORMATION_EX.
    TDIObjectID ID;
    ///The IPv4 or IPv6 address to be used when IPInterfaceInfo data is requested for a particular IP address.
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

///The <b>I_NetLogonControl2</b> function controls various aspects of the Netlogon service.
///Params:
///    ServerName = The name of the remote server.
///    FunctionCode = The operation to be performed. This value can be one of the following. <table> <tr> <th>Value</th>
///                   <th>Meaning</th> </tr> <tr> <td width="40%"><a id="NETLOGON_CONTROL_QUERY"></a><a
///                   id="netlogon_control_query"></a><dl> <dt><b>NETLOGON_CONTROL_QUERY</b></dt> <dt>1</dt> </dl> </td> <td
///                   width="60%"> No operation. Returns only the requested information. </td> </tr> <tr> <td width="40%"><a
///                   id="NETLOGON_CONTROL_REPLICATE"></a><a id="netlogon_control_replicate"></a><dl>
///                   <dt><b>NETLOGON_CONTROL_REPLICATE</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Forces the security account
///                   manager (SAM) database on a backup domain controller (BDC) to be brought in sync with the copy on the primary
///                   domain controller (PDC). This operation does not imply a full synchronize. The Netlogon service replicates any
///                   outstanding differences if possible. </td> </tr> <tr> <td width="40%"><a id="NETLOGON_CONTROL_SYNCHRONIZE"></a><a
///                   id="netlogon_control_synchronize"></a><dl> <dt><b>NETLOGON_CONTROL_SYNCHRONIZE</b></dt> <dt>3</dt> </dl> </td>
///                   <td width="60%"> Forces a BDC to get a new copy of the SAM database from the PDC. This operation performs a full
///                   synchronize. </td> </tr> <tr> <td width="40%"><a id="NETLOGON_CONTROL_PDC_REPLICATE"></a><a
///                   id="netlogon_control_pdc_replicate"></a><dl> <dt><b>NETLOGON_CONTROL_PDC_REPLICATE</b></dt> <dt>4</dt> </dl>
///                   </td> <td width="60%"> Forces a PDC to ask for each BDC to replicate now. </td> </tr> <tr> <td width="40%"><a
///                   id="NETLOGON_CONTROL_REDISCOVER"></a><a id="netlogon_control_rediscover"></a><dl>
///                   <dt><b>NETLOGON_CONTROL_REDISCOVER</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> Forces a domain controller
///                   (DC) to rediscover the specified trusted domain DC. </td> </tr> <tr> <td width="40%"><a
///                   id="NETLOGON_CONTROL_TC_QUERY"></a><a id="netlogon_control_tc_query"></a><dl>
///                   <dt><b>NETLOGON_CONTROL_TC_QUERY</b></dt> <dt>6</dt> </dl> </td> <td width="60%"> Queries the secure channel,
///                   requesting a status update about its last usage. </td> </tr> <tr> <td width="40%"><a
///                   id="NETLOGON_CONTROL_TC_VERIFY"></a><a id="netlogon_control_tc_verify"></a><dl>
///                   <dt><b>NETLOGON_CONTROL_TC_VERIFY</b></dt> <dt>10</dt> </dl> </td> <td width="60%"> Verifies the current status
///                   of the specified trusted domain secure channel. If the status indicates success, the domain controller is pinged.
///                   If the status or the ping indicates failure, a new trusted domain controller is rediscovered. </td> </tr> <tr>
///                   <td width="40%"><a id="NETLOGON_CONTROL_CHANGE_PASSWORD"></a><a id="netlogon_control_change_password"></a><dl>
///                   <dt><b>NETLOGON_CONTROL_CHANGE_PASSWORD</b></dt> <dt>9</dt> </dl> </td> <td width="60%"> Forces a password change
///                   on a secure channel to a trusted domain. </td> </tr> <tr> <td width="40%"><a
///                   id="NETLOGON_CONTROL_FORCE_DNS_REG"></a><a id="netlogon_control_force_dns_reg"></a><dl>
///                   <dt><b>NETLOGON_CONTROL_FORCE_DNS_REG</b></dt> <dt>11</dt> </dl> </td> <td width="60%"> Forces the domain
///                   controller to re-register all of its DNS records. The <i>QueryLevel</i> parameter must be set to 1. </td> </tr>
///                   <tr> <td width="40%"><a id="NETLOGON_CONTROL_QUERY_DNS_REG"></a><a id="netlogon_control_query_dns_reg"></a><dl>
///                   <dt><b>NETLOGON_CONTROL_QUERY_DNS_REG</b></dt> <dt>12</dt> </dl> </td> <td width="60%"> Issues a query requesting
///                   the status of DNS updates performed by the Netlogon service. If any DNS registration or deregistration errors
///                   occurred on the last update, the result is negative. The <i>QueryLevel</i> parameter must be set to 1. </td>
///                   </tr> </table>
///    QueryLevel = Indicates what information should be returned from the Netlogon service. This value can be any of the following
///                 structures.
///    Data = Carries input data that depends on the value specified in the <i>FunctionCode</i> parameter. The
///           NETLOGON_CONTROL_REDISCOVER and NETLOGON_CONTROL_TC_QUERY function codes specify the trusted domain name (the
///           data type is <b>LPWSTR *</b>).
///    Buffer = Returns a pointer to a buffer that contains the requested information in the structure passed in the
///             <i>QueryLevel</i> parameter. The buffer must be freed using NetApiBufferFree.
///Returns:
///    The method returns 0x00000000 (<b>NERR_Success</b>) on success; otherwise, it returns a nonzero error code
///    defined in Lmerr.h or Winerror.h. NET_API_STATUS error codes begin with the value 0x00000834. For more
///    information about network management error codes, see Network_Management_Error_Codes. The following table
///    describes possible return values. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b><b>NERR_Success</b></b></dt> <dt>0x00000000</dt> </dl> </td> <td width="60%"> The method
///    call completed without errors. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt>
///    <dt>0x00000005</dt> </dl> </td> <td width="60%"> Access validation on the caller returns false. Access is denied.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> <dt>0x00000008</dt> </dl> </td>
///    <td width="60%"> Not enough storage is available to process this command. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> <dt>0x00000032</dt> </dl> </td> <td width="60%"> A function code is not valid
///    on the specified server. For example, NETLOGON_CONTROL_REPLICATE might have been passed to a primary domain
///    controller (PDC). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt>
///    <dt>0x00000057</dt> </dl> </td> <td width="60%"> A parameter is incorrect. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_LEVEL</b></dt> <dt>0x0000007C</dt> </dl> </td> <td width="60%"> The query call level is not
///    correct. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SERVICE_NOT_ACTIVE</b></dt>
///    <dt>0x000004261210121</dt> </dl> </td> <td width="60%"> The service has not been started. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b> ERROR_INVALID_COMPUTERNAME</b></dt> <dt> 0x000004BA</dt> </dl> </td> <td width="60%">
///    The format of the specified computer name is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_LOGON_SERVERS</b></dt> <dt>0x0000051F</dt> </dl> </td> <td width="60%"> There are currently no
///    logon servers available to service the logon request. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DOMAIN_ROLE</b></dt> <dt>0x0000054A</dt> </dl> </td> <td width="60%"> Password change for an
///    interdomain trust account was attempted on a backup domain controller (BDC). This operation is only allowed for
///    the PDC of the domain. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_SUCH_DOMAIN</b></dt>
///    <dt>0x0000054B</dt> </dl> </td> <td width="60%"> The specified domain either does not exist or could not be
///    contacted. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>NERR_UserNotFound</b></dt> <dt>0x000008AD</dt> </dl>
///    </td> <td width="60%"> The user name could not be found. </td> </tr> </table>
///    
@DllImport("NETAPI32")
uint I_NetLogonControl2(const(wchar)* ServerName, uint FunctionCode, uint QueryLevel, char* Data, ubyte** Buffer);

///Raises an exception.
///Params:
///    ExceptionRecord = Address of an EXCEPTION_RECORD structure that describes the exception, and the parameters of the exception, that
///                      is raised. Raising a software exception captures the machine state of the current thread in a context record. The
///                      <b>ExceptionAddress</b> member of the exception record is set to the caller's return address.
///Returns:
///    This function does not return a value.
///    
@DllImport("KERNEL32")
void RtlRaiseException(EXCEPTION_RECORD* ExceptionRecord);

///Installs performance counter strings, as defined in an input .ini file, into the system registry. <div
///class="alert"><b>Note</b> Microsoft recommends that developers use LoadPerfCounterTextStrings instead of
///<b>InstallPerfDll</b>. <b>LoadPerfCounterTextStrings</b> calls <b>InstallPerfDll</b> internally. </div><div> </div>
///Params:
///    szComputerName = The name of the system. This should be <b>NULL</b> because this function cannot be used to install remotely.
///    lpIniFile = The name of the initialization file that contains definitions to add to the registry.
///    dwFlags = This parameter can be <b>LOADPERF_FLAGS_DISPLAY_USER_MSGS</b> (<code>(ULONG_PTR) 8</code>).
///Returns:
///    If the function is successful, it returns <b>TRUE</b> and posts additional information in an application event
///    log. Otherwise, it returns an error code that represents the condition that caused the failure.
///    
@DllImport("loadperf")
uint InstallPerfDllW(const(wchar)* szComputerName, const(wchar)* lpIniFile, size_t dwFlags);

///Installs performance counter strings, as defined in an input .ini file, into the system registry. <div
///class="alert"><b>Note</b> Microsoft recommends that developers use LoadPerfCounterTextStrings instead of
///<b>InstallPerfDll</b>. <b>LoadPerfCounterTextStrings</b> calls <b>InstallPerfDll</b> internally. </div><div> </div>
///Params:
///    szComputerName = The name of the system. This should be <b>NULL</b> because this function cannot be used to install remotely.
///    lpIniFile = The name of the initialization file that contains definitions to add to the registry.
///    dwFlags = This parameter can be <b>LOADPERF_FLAGS_DISPLAY_USER_MSGS</b> (<code>(ULONG_PTR) 8</code>).
///Returns:
///    If the function is successful, it returns <b>TRUE</b> and posts additional information in an application event
///    log. Otherwise, it returns an error code that represents the condition that caused the failure.
///    
@DllImport("loadperf")
uint InstallPerfDllA(const(char)* szComputerName, const(char)* lpIniFile, size_t dwFlags);

///Disables the window ghosting feature for the calling GUI process. Window ghosting is a Windows Manager feature that
///lets the user minimize, move, or close the main window of an application that is not responding.
@DllImport("USER32")
void DisableProcessWindowsGhosting();

///Compares two file times.
///Params:
///    lpFileTime1 = A pointer to a FILETIME structure that specifies the first file time.
///    lpFileTime2 = A pointer to a FILETIME structure that specifies the second file time.
///Returns:
///    The return value is one of the following values. <table> <tr> <th>Return value</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt>-1</dt> </dl> </td> <td width="60%"> First file time is earlier than second file
///    time. </td> </tr> <tr> <td width="40%"> <dl> <dt>0</dt> </dl> </td> <td width="60%"> First file time is equal to
///    second file time. </td> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%"> First file time
///    is later than second file time. </td> </tr> </table>
///    
@DllImport("KERNEL32")
int CompareFileTime(const(FILETIME)* lpFileTime1, const(FILETIME)* lpFileTime2);

///Converts a file time to a local file time.
///Params:
///    lpFileTime = A pointer to a FILETIME structure containing the UTC-based file time to be converted into a local file time.
///    lpLocalFileTime = A pointer to a FILETIME structure to receive the converted local file time. This parameter cannot be the same as
///                      the <i>lpFileTime</i> parameter.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL FileTimeToLocalFileTime(const(FILETIME)* lpFileTime, FILETIME* lpLocalFileTime);

///Retrieves the date and time that a file or directory was created, last accessed, and last modified.
///Params:
///    hFile = A handle to the file or directory for which dates and times are to be retrieved. The handle must have been
///            created using the CreateFile function with the <b>GENERIC_READ</b> access right. For more information, see File
///            Security and Access Rights.
///    lpCreationTime = A pointer to a FILETIME structure to receive the date and time the file or directory was created. This parameter
///                     can be <b>NULL</b> if the application does not require this information.
///    lpLastAccessTime = A pointer to a FILETIME structure to receive the date and time the file or directory was last accessed. The last
///                       access time includes the last time the file or directory was written to, read from, or, in the case of executable
///                       files, run. This parameter can be <b>NULL</b> if the application does not require this information.
///    lpLastWriteTime = A pointer to a FILETIME structure to receive the date and time the file or directory was last written to,
///                      truncated, or overwritten (for example, with WriteFile or SetEndOfFile). This date and time is not updated when
///                      file attributes or security descriptors are changed. This parameter can be <b>NULL</b> if the application does
///                      not require this information.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL GetFileTime(HANDLE hFile, FILETIME* lpCreationTime, FILETIME* lpLastAccessTime, FILETIME* lpLastWriteTime);

///Converts a local file time to a file time based on the Coordinated Universal Time (UTC).
///Params:
///    lpLocalFileTime = A pointer to a FILETIME structure that specifies the local file time to be converted into a UTC-based file time.
///    lpFileTime = A pointer to a FILETIME structure to receive the converted UTC-based file time. This parameter cannot be the same
///                 as the <i>lpLocalFileTime</i> parameter.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, use the GetLastError function.
///    
@DllImport("KERNEL32")
BOOL LocalFileTimeToFileTime(const(FILETIME)* lpLocalFileTime, FILETIME* lpFileTime);

///Sets the date and time that the specified file or directory was created, last accessed, or last modified.
///Params:
///    hFile = A handle to the file or directory. The handle must have been created using the CreateFile function with the
///            <b>FILE_WRITE_ATTRIBUTES</b> access right. For more information, see File Security and Access Rights.
///    lpCreationTime = A pointer to a FILETIME structure that contains the new creation date and time for the file or directory. If the
///                     application does not need to change this information, set this parameter either to <b>NULL</b> or to a pointer to
///                     a <b>FILETIME</b> structure that has both the <b>dwLowDateTime</b> and <b>dwHighDateTime</b> members set to 0.
///    lpLastAccessTime = A pointer to a FILETIME structure that contains the new last access date and time for the file or directory. The
///                       last access time includes the last time the file or directory was written to, read from, or (in the case of
///                       executable files) run. If the application does not need to change this information, set this parameter either to
///                       <b>NULL</b> or to a pointer to a <b>FILETIME</b> structure that has both the <b>dwLowDateTime</b> and
///                       <b>dwHighDateTime</b> members set to 0. To prevent file operations using the given handle from modifying the last
///                       access time, call <b>SetFileTime</b> immediately after opening the file handle and pass a FILETIME structure that
///                       has both the <b>dwLowDateTime</b> and <b>dwHighDateTime</b> members set to 0xFFFFFFFF.
///    lpLastWriteTime = A pointer to a FILETIME structure that contains the new last modified date and time for the file or directory. If
///                      the application does not need to change this information, set this parameter either to <b>NULL</b> or to a
///                      pointer to a <b>FILETIME</b> structure that has both the <b>dwLowDateTime</b> and <b>dwHighDateTime</b> members
///                      set to 0. To prevent file operations using the given handle from modifying the last access time, call
///                      <b>SetFileTime</b> immediately after opening the file handle and pass a FILETIME structure that has both the
///                      <b>dwLowDateTime</b> and <b>dwHighDateTime</b> members set to 0xFFFFFFFF.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL SetFileTime(HANDLE hFile, const(FILETIME)* lpCreationTime, const(FILETIME)* lpLastAccessTime, 
                 const(FILETIME)* lpLastWriteTime);

///Retrieves the path of the system directory used by WOW64. This directory is not present on 32-bit Windows.
///Params:
///    lpBuffer = A pointer to the buffer to receive the path. This path does not end with a backslash.
///    uSize = The maximum size of the buffer, in <b>TCHARs</b>.
///Returns:
///    If the function succeeds, the return value is the length, in <b>TCHARs</b>, of the string copied to the buffer,
///    not including the terminating null character. If the length is greater than the size of the buffer, the return
///    value is the size of the buffer required to hold the path. If the function fails, the return value is zero. To
///    get extended error information, call GetLastError. On 32-bit Windows, the function always fails, and the extended
///    error is set to ERROR_CALL_NOT_IMPLEMENTED.
///    
@DllImport("KERNEL32")
uint GetSystemWow64DirectoryA(const(char)* lpBuffer, uint uSize);

///Retrieves the path of the system directory used by WOW64. This directory is not present on 32-bit Windows.
///Params:
///    lpBuffer = A pointer to the buffer to receive the path. This path does not end with a backslash.
///    uSize = The maximum size of the buffer, in <b>TCHARs</b>.
///Returns:
///    If the function succeeds, the return value is the length, in <b>TCHARs</b>, of the string copied to the buffer,
///    not including the terminating null character. If the length is greater than the size of the buffer, the return
///    value is the size of the buffer required to hold the path. If the function fails, the return value is zero. To
///    get extended error information, call GetLastError. On 32-bit Windows, the function always fails, and the extended
///    error is set to ERROR_CALL_NOT_IMPLEMENTED.
///    
@DllImport("KERNEL32")
uint GetSystemWow64DirectoryW(const(wchar)* lpBuffer, uint uSize);

///Retrieves the path of the system directory used by WOW64, using the specified image file machine type. This directory
///is not present on 32-bit Windows.
///Params:
///    lpBuffer = A pointer to the buffer to receive the path. This path does not end with a backslash.
///    uSize = The maximum size of the buffer, in <b>TCHARs</b>.
///    ImageFileMachineType = An IMAGE_FILE_MACHINE_* value that specifies the machine to test.
///Returns:
///    If the function succeeds, the return value is the length, in <b>TCHARs</b>, of the string copied to the buffer,
///    not including the terminating null character. If the length is greater than the size of the buffer, the return
///    value is the size of the buffer required to hold the path. If the function fails, the return value is zero. To
///    get extended error information, call GetLastError.
///    
@DllImport("api-ms-win-core-wow64-l1-1-1")
uint GetSystemWow64Directory2A(const(char)* lpBuffer, uint uSize, ushort ImageFileMachineType);

///Retrieves the path of the system directory used by WOW64, using the specified image file machine type. This directory
///is not present on 32-bit Windows.
///Params:
///    lpBuffer = A pointer to the buffer to receive the path. This path does not end with a backslash.
///    uSize = The maximum size of the buffer, in <b>TCHARs</b>.
///    ImageFileMachineType = An IMAGE_FILE_MACHINE_* value that specifies the machine to test.
///Returns:
///    If the function succeeds, the return value is the length, in <b>TCHARs</b>, of the string copied to the buffer,
///    not including the terminating null character. If the length is greater than the size of the buffer, the return
///    value is the size of the buffer required to hold the path. If the function fails, the return value is zero. To
///    get extended error information, call GetLastError.
///    
@DllImport("api-ms-win-core-wow64-l1-1-1")
uint GetSystemWow64Directory2W(const(wchar)* lpBuffer, uint uSize, ushort ImageFileMachineType);

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Determines which architectures are supported (under WOW64) on the given machine architecture.
///Params:
///    WowGuestMachine = An IMAGE_FILE_MACHINE_* value that specifies the machine to test.
///    MachineIsSupported = On success, returns a pointer to a boolean: <b>true</b> if the machine supports WOW64, or <b>false</b> if it does
///                         not.
///Returns:
///    On success, returns <b>S_OK</b>; otherwise, returns an error. To get extended error information, call
///    GetLastError.
///    
@DllImport("KERNEL32")
HRESULT IsWow64GuestMachineSupported(ushort WowGuestMachine, int* MachineIsSupported);

///The <b>NdrSimpleStructMarshall</b> function marshals the simple structure into a network buffer.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. The
///               <b>MIDL_STUB_MESSAGE</b> structure is for internal use only, and must not be modified.
///    pMemory = Pointer to the simple structure to be marshaled.
///    pFormat = Pointer to the format string description.
///Returns:
///    Returns null upon success. Raises one of the following exceptions upon failure. <table> <tr> <th>Error</th>
///    <th>Description</th> </tr> <tr> <td>STATUS_ACCESS_VIOLATION</td> <td>An access violation occurred.</td> </tr>
///    <tr> <td>RPC_S_INTERNAL_ERROR</td> <td>An error occurred in RPC.</td> </tr> </table>
///    
@DllImport("RPCRT4")
ubyte* NdrSimpleStructMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

///The <b>NdrComplexStructMarshall</b> function marshals the complex structure into a network buffer.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. The
///               <b>MIDL_STUB_MESSAGE</b> structure is for internal use only, and must not be modified.
///    pMemory = Pointer to the complex structure to be marshaled.
///    pFormat = Pointer to the format string description.
///Returns:
///    Returns null upon success. Raises one of the following exceptions upon failure. <table> <tr> <th>Error</th>
///    <th>Description</th> </tr> <tr> <td>STATUS_ACCESS_VIOLATION</td> <td>An access violation occurred.</td> </tr>
///    <tr> <td>RPC_S_INTERNAL_ERROR</td> <td>An error occurred in RPC.</td> </tr> </table>
///    
@DllImport("RPCRT4")
ubyte* NdrComplexStructMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

///The <b>NdrConformantArrayMarshall</b> function marshals the conformant array into a network buffer.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. The
///               <b>MIDL_STUB_MESSAGE</b> structure is for internal use only, and must not be modified.
///    pMemory = Pointer to the conformant array to be marshaled.
///    pFormat = Pointer to the format string description.
///Returns:
///    Returns null upon success. Raises one of the following exceptions upon failure. <table> <tr> <th>Error</th>
///    <th>Description</th> </tr> <tr> <td>STATUS_ACCESS_VIOLATION</td> <td>An access violation occurred.</td> </tr>
///    <tr> <td>RPC_S_INTERNAL_ERROR</td> <td>An error occurred in RPC.</td> </tr> </table>
///    
@DllImport("RPCRT4")
ubyte* NdrConformantArrayMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

///The <b>NdrComplexArrayMarshall</b> function marshals the complex array into a network buffer.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. The
///               <b>MIDL_STUB_MESSAGE</b> structure is for internal use only, and must not be modified.
///    pMemory = Pointer to the complex array to be marshaled.
///    pFormat = Pointer to the format string description.
///Returns:
///    Returns null upon success. Raises one of the following exceptions upon failure. <table> <tr> <th>Error</th>
///    <th>Description</th> </tr> <tr> <td>STATUS_ACCESS_VIOLATION</td> <td>An access violation occurred.</td> </tr>
///    <tr> <td>RPC_S_INTERNAL_ERROR</td> <td>An error occurred in RPC.</td> </tr> </table>
///    
@DllImport("RPCRT4")
ubyte* NdrComplexArrayMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

///The <b>NdrSimpleStructUnmarshall</b> function unmarshals the simple structure from the network buffer to memory.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. The
///               <b>MIDL_STUB_MESSAGE</b> structure is for internal use only, and must not be modified.
///    ppMemory = Address to a pointer to the unmarshalled simple structure. If set to null, or if the <i>fMustAlloc</i> parameter
///               is set to <b>TRUE</b>, the stub will allocate the memory.
///    pFormat = Pointer to the format string description.
///    fMustAlloc = Flag that specifies whether the stub must allocate the memory into which the simple structure is to be marshaled.
///                 Specify <b>TRUE</b> if RPC must allocate <i>ppMemory</i>.
///Returns:
///    Returns null upon success. Raises one of the following exceptions upon failure. <table> <tr> <th>Error</th>
///    <th>Description</th> </tr> <tr> <td>RPC_BAD_STUB_DATA or RPC_X_INVALID_BOUND</td> <td>The network is
///    incorrect.</td> </tr> <tr> <td>RPC_S_OUT_OF_MEMORY</td> <td>Out of memory.</td> </tr> <tr>
///    <td>STATUS_ACCESS_VIOLATION</td> <td>An access violation occurred.</td> </tr> <tr> <td>RPC_S_INTERNAL_ERROR</td>
///    <td>An error occurred in RPC.</td> </tr> </table>
///    
@DllImport("RPCRT4")
ubyte* NdrSimpleStructUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

///The <b>NdrComplexStructUnmarshall</b> function unmarshals the complex structure from the network buffer to memory.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. The
///               <b>MIDL_STUB_MESSAGE</b> structure is for internal use only, and must not be modified.
///    ppMemory = Address to a pointer to the unmarshalled complex structure. If set to null, or if the <i>fMustAlloc</i> parameter
///               is set to <b>TRUE</b>, the stub will allocate the memory.
///    pFormat = Pointer to the format string description.
///    fMustAlloc = Flag that specifies whether the stub must allocate the memory into which the complex structure is to be
///                 marshaled. Specify <b>TRUE</b> if RPC must allocate <i>ppMemory</i>.
///Returns:
///    Returns null upon success. Raises one of the following exceptions upon failure. <table> <tr> <th>Error</th>
///    <th>Description</th> </tr> <tr> <td>RPC_BAD_STUB_DATA or RPC_X_INVALID_BOUND</td> <td>The network is
///    incorrect.</td> </tr> <tr> <td>RPC_S_OUT_OF_MEMORY</td> <td>Out of memory.</td> </tr> <tr>
///    <td>STATUS_ACCESS_VIOLATION</td> <td>An access violation occurred.</td> </tr> <tr> <td>RPC_S_INTERNAL_ERROR</td>
///    <td>An error occurred in RPC.</td> </tr> </table>
///    
@DllImport("RPCRT4")
ubyte* NdrComplexStructUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

///The <b>NdrComplexArrayUnmarshall</b> function unmarshals the complex array from the network buffer to memory.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. The
///               <b>MIDL_STUB_MESSAGE</b> structure is for internal use only, and must not be modified.
///    ppMemory = Address to a pointer to the unmarshalled complex array. If set to null, or if the <i>fMustAlloc</i> parameter is
///               set to <b>TRUE</b>, the stub will allocate the memory.
///    pFormat = Pointer to the format string description.
///    fMustAlloc = Flag that specifies whether the stub must allocate the memory into which the complex array is to be marshaled.
///                 Specify <b>TRUE</b> if RPC must allocate <i>ppMemory</i>.
///Returns:
///    Returns null upon success. Raises one of the following exceptions upon failure. <table> <tr> <th>Error</th>
///    <th>Description</th> </tr> <tr> <td>RPC_BAD_STUB_DATA or RPC_X_INVALID_BOUND</td> <td>The network is
///    incorrect.</td> </tr> <tr> <td>RPC_S_OUT_OF_MEMORY</td> <td>Out of memory.</td> </tr> <tr>
///    <td>STATUS_ACCESS_VIOLATION</td> <td>An access violation occurred.</td> </tr> <tr> <td>RPC_S_INTERNAL_ERROR</td>
///    <td>An error occurred in RPC.</td> </tr> </table>
///    
@DllImport("RPCRT4")
ubyte* NdrComplexArrayUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

///The <b>NdrUserMarshalUnmarshall</b> function calls a user-defined unmarshal routine to unmarshal data with the
///attribute.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. The
///               <b>MIDL_STUB_MESSAGE</b> structure is for internal use only, and must not be modified.
///    ppMemory = Pointer to user data object to be unmarshalled.
///    pFormat = Format string description of the pointer.
///    fMustAlloc = Flag that specifies whether the stub must allocate the memory into which the user data object is to be
///                 unmarshalled. Specify <b>TRUE</b> if RPC must allocate <i>ppMemory</i>.
///Returns:
///    Returns <b>NULL</b> upon success. Returns one of the following exception codes upon error. <table> <tr>
///    <th>Error</th> <th>Description</th> </tr> <tr> <td>STATUS_ACCESS_VIOLATION</td> <td>An access violation
///    occurred.</td> </tr> <tr> <td>RPC_S_INTERNAL_ERROR</td> <td>An error occurred in RPC.</td> </tr> </table>
///    
@DllImport("RPCRT4")
ubyte* NdrUserMarshalUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

///The <b>NdrSimpleStructBufferSize</b> function calculates the required buffer size, in bytes, to marshal the simple
///structure.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. The
///               <b>BufferLength</b> member contains the size of the buffer. The <b>MIDL_STUB_MESSAGE</b> structure is for
///               internal use only, and must not be modified.
///    pMemory = Pointer to the simple structure to be calculated.
///    pFormat = Pointer to the format string description.
@DllImport("RPCRT4")
void NdrSimpleStructBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

///The <b>NdrComplexStructBufferSize</b> function calculates the required buffer size, in bytes, to marshal the complex
///structure.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. The
///               <b>BufferLength</b> member contains the size of the buffer. The <b>MIDL_STUB_MESSAGE</b> structure is for
///               internal use only, and must not be modified.
///    pMemory = Pointer to the complex structure to be calculated.
///    pFormat = Pointer to the format string description.
@DllImport("RPCRT4")
void NdrComplexStructBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

///The <b>NdrConformantArrayBufferSize</b> function calculates the required buffer size, in bytes, to marshal the
///conformant array.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. The
///               <b>BufferLength</b> member contains the size of the buffer. The <b>MIDL_STUB_MESSAGE</b> structure is for
///               internal use only, and must not be modified.
///    pMemory = Pointer to the conformant array to be calculated.
///    pFormat = Pointer to the format string description.
@DllImport("RPCRT4")
void NdrConformantArrayBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

///The <b>NdrComplexArrayBufferSize</b> function calculates the required buffer size, in bytes, to marshal the complex
///array.
///Params:
///    pStubMsg = Pointer to a MIDL_STUB_MESSAGE structure that maintains the current status of the RPC stub. The
///               <b>BufferLength</b> member contains the size of the buffer. The <b>MIDL_STUB_MESSAGE</b> structure is for
///               internal use only, and must not be modified.
///    pMemory = Pointer to the complex array to be calculated.
///    pFormat = Pointer to the format string description.
@DllImport("RPCRT4")
void NdrComplexArrayBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

///Retrieves the name of the user or other security principal associated with the calling thread. You can specify the
///format of the returned name. If the thread is impersonating a client, <b>GetUserNameEx</b> returns the name of the
///client.
///Params:
///    NameFormat = The format of the name. This parameter is a value from the EXTENDED_NAME_FORMAT enumeration type. It cannot be
///                 <b>NameUnknown</b>. If the user account is not in a domain, only <b>NameSamCompatible</b> is supported.
///    lpNameBuffer = A pointer to a buffer that receives the name in the specified format. The buffer must include space for the
///                   terminating null character.
///    nSize = On input, this variable specifies the size of the <i>lpNameBuffer</i> buffer, in <b>TCHARs</b>. If the function
///            is successful, the variable receives the number of <b>TCHARs</b> copied to the buffer, not including the
///            terminating null character. If <i>lpNameBuffer</i> is too small, the function fails and GetLastError returns
///            ERROR_MORE_DATA. This parameter receives the required buffer size, in Unicode characters (whether or not Unicode
///            is being used), including the terminating null character.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError. Possible values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl>
///    </td> <td width="60%"> The <i>lpNameBuffer</i> buffer is too small. The <i>lpnSize</i> parameter contains the
///    number of bytes required to receive the name. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_SUCH_DOMAIN</b></dt> </dl> </td> <td width="60%"> The domain controller is not available to
///    perform the lookup </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NONE_MAPPED</b></dt> </dl> </td> <td
///    width="60%"> The user name is not available in the specified format. </td> </tr> </table>
///    
@DllImport("SspiCli")
ubyte GetUserNameExA(EXTENDED_NAME_FORMAT NameFormat, const(char)* lpNameBuffer, uint* nSize);

///Retrieves the name of the user or other security principal associated with the calling thread. You can specify the
///format of the returned name. If the thread is impersonating a client, <b>GetUserNameEx</b> returns the name of the
///client.
///Params:
///    NameFormat = The format of the name. This parameter is a value from the EXTENDED_NAME_FORMAT enumeration type. It cannot be
///                 <b>NameUnknown</b>. If the user account is not in a domain, only <b>NameSamCompatible</b> is supported.
///    lpNameBuffer = A pointer to a buffer that receives the name in the specified format. The buffer must include space for the
///                   terminating null character.
///    nSize = On input, this variable specifies the size of the <i>lpNameBuffer</i> buffer, in <b>TCHARs</b>. If the function
///            is successful, the variable receives the number of <b>TCHARs</b> copied to the buffer, not including the
///            terminating null character. If <i>lpNameBuffer</i> is too small, the function fails and GetLastError returns
///            ERROR_MORE_DATA. This parameter receives the required buffer size, in Unicode characters (whether or not Unicode
///            is being used), including the terminating null character.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError. Possible values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl>
///    </td> <td width="60%"> The <i>lpNameBuffer</i> buffer is too small. The <i>lpnSize</i> parameter contains the
///    number of bytes required to receive the name. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_SUCH_DOMAIN</b></dt> </dl> </td> <td width="60%"> The domain controller is not available to
///    perform the lookup </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NONE_MAPPED</b></dt> </dl> </td> <td
///    width="60%"> The user name is not available in the specified format. </td> </tr> </table>
///    
@DllImport("SspiCli")
ubyte GetUserNameExW(EXTENDED_NAME_FORMAT NameFormat, const(wchar)* lpNameBuffer, uint* nSize);

///Retrieves the local computer's name in a specified format.
///Params:
///    NameFormat = The format for the name. This parameter is a value from the EXTENDED_NAME_FORMAT enumeration type. It cannot be
///                 NameUnknown.
///    lpNameBuffer = A pointer to a buffer that receives the name in the specified format. If this parameter is <b>NULL</b>, either
///                   the function succeeds and the <i>lpnSize</i> parameter receives the required size, or the function fails with
///                   ERROR_INSUFFICIENT_BUFFER and <i>lpnSize</i> receives the required size. The behavior depends on the value of
///                   <i>NameFormat</i> and the version of the operating system.
///    nSize = On input, specifies the size of the <i>lpNameBuffer</i> buffer, in <b>TCHARs</b>. On success, receives the size
///            of the name copied to the buffer. If the <i>lpNameBuffer</i> buffer is too small to hold the name, the function
///            fails and <i>lpnSize</i> receives the required buffer size.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("SECUR32")
ubyte GetComputerObjectNameA(EXTENDED_NAME_FORMAT NameFormat, const(char)* lpNameBuffer, uint* nSize);

///Retrieves the local computer's name in a specified format.
///Params:
///    NameFormat = The format for the name. This parameter is a value from the EXTENDED_NAME_FORMAT enumeration type. It cannot be
///                 NameUnknown.
///    lpNameBuffer = A pointer to a buffer that receives the name in the specified format. If this parameter is <b>NULL</b>, either
///                   the function succeeds and the <i>lpnSize</i> parameter receives the required size, or the function fails with
///                   ERROR_INSUFFICIENT_BUFFER and <i>lpnSize</i> receives the required size. The behavior depends on the value of
///                   <i>NameFormat</i> and the version of the operating system.
///    nSize = On input, specifies the size of the <i>lpNameBuffer</i> buffer, in <b>TCHARs</b>. On success, receives the size
///            of the name copied to the buffer. If the <i>lpNameBuffer</i> buffer is too small to hold the name, the function
///            fails and <i>lpnSize</i> receives the required buffer size.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("SECUR32")
ubyte GetComputerObjectNameW(EXTENDED_NAME_FORMAT NameFormat, const(wchar)* lpNameBuffer, uint* nSize);

///Converts a directory service object name from one format to another.
///Params:
///    lpAccountName = The name to be translated.
///    AccountNameFormat = The format of the name to be translated. This parameter is a value from the EXTENDED_NAME_FORMAT enumeration
///                        type.
///    DesiredNameFormat = The format of the converted name. This parameter is a value from the EXTENDED_NAME_FORMAT enumeration type. It
///                        cannot be NameUnknown.
///    lpTranslatedName = A pointer to a buffer that receives the converted name.
///    nSize = On input, the variable indicates the size of the <i>lpTranslatedName</i> buffer, in <b>TCHARs</b>. On output, the
///            variable returns the size of the returned string, in <b>TCHARs</b>, including the terminating <b>null</b>
///            character. If <i>lpTranslated</i> is <b>NULL</b> and <i>nSize</i> is 0, the function succeeds and <i>nSize</i>
///            receives the required buffer size. If the <i>lpTranslatedName</i> buffer is too small to hold the converted name,
///            the function fails and <i>nSize</i> receives the required buffer size.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("SECUR32")
ubyte TranslateNameA(const(char)* lpAccountName, EXTENDED_NAME_FORMAT AccountNameFormat, 
                     EXTENDED_NAME_FORMAT DesiredNameFormat, const(char)* lpTranslatedName, uint* nSize);

///Converts a directory service object name from one format to another.
///Params:
///    lpAccountName = The name to be translated.
///    AccountNameFormat = The format of the name to be translated. This parameter is a value from the EXTENDED_NAME_FORMAT enumeration
///                        type.
///    DesiredNameFormat = The format of the converted name. This parameter is a value from the EXTENDED_NAME_FORMAT enumeration type. It
///                        cannot be NameUnknown.
///    lpTranslatedName = A pointer to a buffer that receives the converted name.
///    nSize = On input, the variable indicates the size of the <i>lpTranslatedName</i> buffer, in <b>TCHARs</b>. On output, the
///            variable returns the size of the returned string, in <b>TCHARs</b>, including the terminating <b>null</b>
///            character. If <i>lpTranslated</i> is <b>NULL</b> and <i>nSize</i> is 0, the function succeeds and <i>nSize</i>
///            receives the required buffer size. If the <i>lpTranslatedName</i> buffer is too small to hold the converted name,
///            the function fails and <i>nSize</i> receives the required buffer size.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("SECUR32")
ubyte TranslateNameW(const(wchar)* lpAccountName, EXTENDED_NAME_FORMAT AccountNameFormat, 
                     EXTENDED_NAME_FORMAT DesiredNameFormat, const(wchar)* lpTranslatedName, uint* nSize);

///The **IsApiSetImplemented** function tests if a specified *API set* is present on the computer.
///Params:
///    Contract = Specifies the name of the API set to query. For more info, see the Remarks section.
///Returns:
///    **IsApiSetImplemented** returns **TRUE** if the specified API set is present. In this case, APIs in the target
///    API set have valid implementations on the current platform. Otherwise, this function returns **FALSE**.
///    
@DllImport("api-ms-win-core-apiquery-l2-1-0")
BOOL IsApiSetImplemented(const(char)* Contract);

///Sets the environment strings of the calling process (both the system and the user environment variables) for the
///current process.
///Params:
///    NewEnvironment = The environment variable string using the following format: <i>Var1</i> <i>Value1</i> <i>Var2</i> <i>Value2</i>
///                     <i>Var3</i> <i>Value3</i> <i>VarN</i> <i>ValueN</i>
///Returns:
///    Returns S_OK on success.
///    
@DllImport("KERNEL32")
BOOL SetEnvironmentStringsW(const(wchar)* NewEnvironment);

@DllImport("KERNEL32")
HANDLE GetStdHandle(STD_HANDLE_TYPE nStdHandle);

@DllImport("KERNEL32")
BOOL SetStdHandle(STD_HANDLE_TYPE nStdHandle, HANDLE hHandle);

///Sets the handle for the input, output, or error streams.
///Params:
///    nStdHandle = A DWORD indicating the stream for which the handle is being set.
///    hHandle = The handle.
///    phPrevValue = Optional. Receives the previous handle.
///Returns:
///    Returns S_OK on success.
///    
@DllImport("KERNEL32")
BOOL SetStdHandleEx(STD_HANDLE_TYPE nStdHandle, HANDLE hHandle, ptrdiff_t* phPrevValue);

///Expands environment-variable strings and replaces them with the values defined for the current user. To specify the
///environment block for a particular user or the system, use the ExpandEnvironmentStringsForUser function.
///Params:
///    lpSrc = A buffer that contains one or more environment-variable strings in the form: %<i>variableName</i>%. For each such
///            reference, the %<i>variableName</i>% portion is replaced with the current value of that environment variable.
///            Case is ignored when looking up the environment-variable name. If the name is not found, the
///            %<i>variableName</i>% portion is left unexpanded. Note that this function does not support all the features that
///            Cmd.exe supports. For example, it does not support %<i>variableName</i>:<i>str1</i>=<i>str2</i>% or
///            %<i>variableName</i>:~<i>offset</i>,<i>length</i>%.
///    lpDst = A pointer to a buffer that receives the result of expanding the environment variable strings in the <i>lpSrc</i>
///            buffer. Note that this buffer cannot be the same as the <i>lpSrc</i> buffer.
///    nSize = The maximum number of characters that can be stored in the buffer pointed to by the <i>lpDst</i> parameter. When
///            using ANSI strings, the buffer size should be the string length, plus terminating null character, plus one. When
///            using Unicode strings, the buffer size should be the string length plus the terminating null character.
///Returns:
///    If the function succeeds, the return value is the number of <b>TCHARs</b> stored in the destination buffer,
///    including the terminating null character. If the destination buffer is too small to hold the expanded string, the
///    return value is the required buffer size, in characters. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
uint ExpandEnvironmentStringsA(const(char)* lpSrc, const(char)* lpDst, uint nSize);

///Expands environment-variable strings and replaces them with the values defined for the current user. To specify the
///environment block for a particular user or the system, use the ExpandEnvironmentStringsForUser function.
///Params:
///    lpSrc = A buffer that contains one or more environment-variable strings in the form: %<i>variableName</i>%. For each such
///            reference, the %<i>variableName</i>% portion is replaced with the current value of that environment variable.
///            Case is ignored when looking up the environment-variable name. If the name is not found, the
///            %<i>variableName</i>% portion is left unexpanded. Note that this function does not support all the features that
///            Cmd.exe supports. For example, it does not support %<i>variableName</i>:<i>str1</i>=<i>str2</i>% or
///            %<i>variableName</i>:~<i>offset</i>,<i>length</i>%.
///    lpDst = A pointer to a buffer that receives the result of expanding the environment variable strings in the <i>lpSrc</i>
///            buffer. Note that this buffer cannot be the same as the <i>lpSrc</i> buffer.
///    nSize = The maximum number of characters that can be stored in the buffer pointed to by the <i>lpDst</i> parameter. When
///            using ANSI strings, the buffer size should be the string length, plus terminating null character, plus one. When
///            using Unicode strings, the buffer size should be the string length plus the terminating null character.
///Returns:
///    If the function succeeds, the return value is the number of <b>TCHARs</b> stored in the destination buffer,
///    including the terminating null character. If the destination buffer is too small to hold the expanded string, the
///    return value is the required buffer size, in characters. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
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

///Closes an open object handle.
///Params:
///    hObject = A valid handle to an open object.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError. If the application is running under a debugger, the function will
///    throw an exception if it receives either a handle value that is not valid or a pseudo-handle value. This can
///    happen if you close a handle twice, or if you call <b>CloseHandle</b> on a handle returned by the FindFirstFile
///    function instead of calling the FindClose function.
///    
@DllImport("KERNEL32")
BOOL CloseHandle(HANDLE hObject);

///Duplicates an object handle.
///Params:
///    hSourceProcessHandle = A handle to the process with the handle to be duplicated. The handle must have the PROCESS_DUP_HANDLE access
///                           right. For more information, see Process Security and Access Rights.
///    hSourceHandle = The handle to be duplicated. This is an open object handle that is valid in the context of the source process.
///                    For a list of objects whose handles can be duplicated, see the following Remarks section.
///    hTargetProcessHandle = A handle to the process that is to receive the duplicated handle. The handle must have the PROCESS_DUP_HANDLE
///                           access right. This parameter is optional and can be specified as NULL if the **DUPLICATE_CLOSE_SOURCE** flag is
///                           set in _Options_.
///    lpTargetHandle = A pointer to a variable that receives the duplicate handle. This handle value is valid in the context of the
///                     target process. If <i>hSourceHandle</i> is a pseudo handle returned by GetCurrentProcess or GetCurrentThread,
///                     <b>DuplicateHandle</b> converts it to a real handle to a process or thread, respectively. If
///                     <i>lpTargetHandle</i> is <b>NULL</b>, the function duplicates the handle, but does not return the duplicate
///                     handle value to the caller. This behavior exists only for backward compatibility with previous versions of this
///                     function. You should not use this feature, as you will lose system resources until the target process terminates.
///                     This parameter is ignored if _hTargetProcessHandle_ is **NULL**.
///    dwDesiredAccess = The access requested for the new handle. For the flags that can be specified for each object type, see the
///                      following Remarks section. This parameter is ignored if the <i>dwOptions</i> parameter specifies the
///                      DUPLICATE_SAME_ACCESS flag. Otherwise, the flags that can be specified depend on the type of object whose handle
///                      is to be duplicated. This parameter is ignored if _hTargetProcessHandle_ is **NULL**.
///    bInheritHandle = A variable that indicates whether the handle is inheritable. If <b>TRUE</b>, the duplicate handle can be
///                     inherited by new processes created by the target process. If <b>FALSE</b>, the new handle cannot be inherited.
///                     This parameter is ignored if _hTargetProcessHandle_ is **NULL**.
///    dwOptions = Optional actions. This parameter can be zero, or any combination of the following values. <table> <tr>
///                <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DUPLICATE_CLOSE_SOURCE"></a><a
///                id="duplicate_close_source"></a><dl> <dt><b>DUPLICATE_CLOSE_SOURCE</b></dt> <dt>0x00000001</dt> </dl> </td> <td
///                width="60%"> Closes the source handle. This occurs regardless of any error status returned. </td> </tr> <tr> <td
///                width="40%"><a id="DUPLICATE_SAME_ACCESS"></a><a id="duplicate_same_access"></a><dl>
///                <dt><b>DUPLICATE_SAME_ACCESS</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> Ignores the
///                <i>dwDesiredAccess</i> parameter. The duplicate handle has the same access as the source handle. </td> </tr>
///                </table>
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL DuplicateHandle(HANDLE hSourceProcessHandle, HANDLE hSourceHandle, HANDLE hTargetProcessHandle, 
                     ptrdiff_t* lpTargetHandle, uint dwDesiredAccess, BOOL bInheritHandle, 
                     DUPLICATE_HANDLE_OPTIONS dwOptions);

///Compares two object handles to determine if they refer to the same underlying kernel object.
///Params:
///    hFirstObjectHandle = The first object handle to compare.
///    hSecondObjectHandle = The second object handle to compare.
///Returns:
///    A Boolean value that indicates if the two handles refer to the same underlying kernel object. TRUE if the same,
///    otherwise FALSE.
///    
@DllImport("api-ms-win-core-handle-l1-1-0")
BOOL CompareObjectHandles(HANDLE hFirstObjectHandle, HANDLE hSecondObjectHandle);

///Retrieves certain properties of an object handle.
///Params:
///    hObject = A handle to an object whose information is to be retrieved. You can specify a handle to one of the following
///              types of objects: access token, console input buffer, console screen buffer, event, file, file mapping, job,
///              mailslot, mutex, pipe, printer, process, registry key, semaphore, serial communication device, socket, thread, or
///              waitable timer.
///    lpdwFlags = A pointer to a variable that receives a set of bit flags that specify properties of the object handle or 0. The
///                following values are defined. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                id="HANDLE_FLAG_INHERIT"></a><a id="handle_flag_inherit"></a><dl> <dt><b>HANDLE_FLAG_INHERIT</b></dt>
///                <dt>0x00000001</dt> </dl> </td> <td width="60%"> If this flag is set, a child process created with the
///                <i>bInheritHandles</i> parameter of CreateProcess set to <b>TRUE</b> will inherit the object handle. </td> </tr>
///                <tr> <td width="40%"><a id="HANDLE_FLAG_PROTECT_FROM_CLOSE"></a><a id="handle_flag_protect_from_close"></a><dl>
///                <dt><b>HANDLE_FLAG_PROTECT_FROM_CLOSE</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> If this flag is
///                set, calling the CloseHandle function will not close the object handle. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL GetHandleInformation(HANDLE hObject, uint* lpdwFlags);

///Sets certain properties of an object handle.
///Params:
///    hObject = A handle to an object whose information is to be set. You can specify a handle to one of the following types of
///              objects: access token, console input buffer, console screen buffer, event, file, file mapping, job, mailslot,
///              mutex, pipe, printer, process, registry key, semaphore, serial communication device, socket, thread, or waitable
///              timer.
///    dwMask = A mask that specifies the bit flags to be changed. Use the same constants shown in the description of
///             <i>dwFlags</i>.
///    dwFlags = Set of bit flags that specifies properties of the object handle. This parameter can be 0 or one or more of the
///              following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///              id="HANDLE_FLAG_INHERIT"></a><a id="handle_flag_inherit"></a><dl> <dt><b>HANDLE_FLAG_INHERIT</b></dt>
///              <dt>0x00000001</dt> </dl> </td> <td width="60%"> If this flag is set, a child process created with the
///              <i>bInheritHandles</i> parameter of CreateProcess set to <b>TRUE</b> will inherit the object handle. </td> </tr>
///              <tr> <td width="40%"><a id="HANDLE_FLAG_PROTECT_FROM_CLOSE"></a><a id="handle_flag_protect_from_close"></a><dl>
///              <dt><b>HANDLE_FLAG_PROTECT_FROM_CLOSE</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> If this flag is
///              set, calling the CloseHandle function will not close the object handle. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL SetHandleInformation(HANDLE hObject, uint dwMask, HANDLE_FLAG_OPTIONS dwFlags);

///Retrieves the current value of the performance counter, which is a high resolution (&lt;1us) time stamp that can be
///used for time-interval measurements.
///Params:
///    lpPerformanceCount = A pointer to a variable that receives the current performance-counter value, in counts.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError. On systems that run Windows XP or later, the function will always
///    succeed and will thus never return zero.
///    
@DllImport("KERNEL32")
BOOL QueryPerformanceCounter(LARGE_INTEGER* lpPerformanceCount);

///Retrieves the frequency of the performance counter. The frequency of the performance counter is fixed at system boot
///and is consistent across all processors. Therefore, the frequency need only be queried upon application
///initialization, and the result can be cached.
///Params:
///    lpFrequency = A pointer to a variable that receives the current performance-counter frequency, in counts per second. If the
///                  installed hardware doesn't support a high-resolution performance counter, this parameter can be zero (this will
///                  not occur on systems that run Windows XP or later).
///Returns:
///    If the installed hardware supports a high-resolution performance counter, the return value is nonzero. If the
///    function fails, the return value is zero. To get extended error information, call GetLastError. On systems that
///    run Windows XP or later, the function will always succeed and will thus never return zero.
///    
@DllImport("KERNEL32")
BOOL QueryPerformanceFrequency(LARGE_INTEGER* lpFrequency);

///Sets dynamic exception handling continuation targets for the specified process.
///Params:
///    Process = A handle to the process. This handle must have the <b>PROCESS_SET_INFORMATION</b> access right. For more
///              information, see Process Security and Access Rights.
///    NumberOfTargets = Supplies the number of dynamic exception handling continuation targets to set.
///    Targets = A pointer to an array of dynamic exception handling continuation targets. For more information on this structure,
///              see PROCESS_DYNAMIC_EH_CONTINUATION_TARGET.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError. Note that even if the function fails, a portion of the supplied
///    continuation targets may have been successfully processed. The caller needs to check the flags in each individual
///    continuation target specified via <i>Targets</i> to determine if it was successfully processed.
///    
@DllImport("KERNEL32")
BOOL SetProcessDynamicEHContinuationTargets(HANDLE Process, ushort NumberOfTargets, char* Targets);

///Determines whether the specified processor feature is supported by the current computer.
///Params:
///    ProcessorFeature = The processor feature to be tested. This parameter can be one of the following values. <table> <tr>
///                       <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PF_ARM_64BIT_LOADSTORE_ATOMIC"></a><a
///                       id="pf_arm_64bit_loadstore_atomic"></a><dl> <dt><b>PF_ARM_64BIT_LOADSTORE_ATOMIC</b></dt> <dt>25</dt> </dl> </td>
///                       <td width="60%"> The 64-bit load/store atomic instructions are available. </td> </tr> <tr> <td width="40%"><a
///                       id="PF_ARM_DIVIDE_INSTRUCTION_AVAILABLE"></a><a id="pf_arm_divide_instruction_available"></a><dl>
///                       <dt><b>PF_ARM_DIVIDE_INSTRUCTION_AVAILABLE</b></dt> <dt>24</dt> </dl> </td> <td width="60%"> The divide
///                       instructions are available. </td> </tr> <tr> <td width="40%"><a id="PF_ARM_EXTERNAL_CACHE_AVAILABLE"></a><a
///                       id="pf_arm_external_cache_available"></a><dl> <dt><b>PF_ARM_EXTERNAL_CACHE_AVAILABLE</b></dt> <dt>26</dt> </dl>
///                       </td> <td width="60%"> The external cache is available. </td> </tr> <tr> <td width="40%"><a
///                       id="PF_ARM_FMAC_INSTRUCTIONS_AVAILABLE"></a><a id="pf_arm_fmac_instructions_available"></a><dl>
///                       <dt><b>PF_ARM_FMAC_INSTRUCTIONS_AVAILABLE</b></dt> <dt>27</dt> </dl> </td> <td width="60%"> The floating-point
///                       multiply-accumulate instruction is available. </td> </tr> <tr> <td width="40%"><a
///                       id="PF_ARM_VFP_32_REGISTERS_AVAILABLE"></a><a id="pf_arm_vfp_32_registers_available"></a><dl>
///                       <dt><b>PF_ARM_VFP_32_REGISTERS_AVAILABLE</b></dt> <dt>18</dt> </dl> </td> <td width="60%"> The VFP/Neon: 32 x
///                       64bit register bank is present. This flag has the same meaning as <b>PF_ARM_VFP_EXTENDED_REGISTERS</b>. </td>
///                       </tr> <tr> <td width="40%"><a id="PF_3DNOW_INSTRUCTIONS_AVAILABLE"></a><a
///                       id="pf_3dnow_instructions_available"></a><dl> <dt><b>PF_3DNOW_INSTRUCTIONS_AVAILABLE</b></dt> <dt>7</dt> </dl>
///                       </td> <td width="60%"> The 3D-Now instruction set is available. </td> </tr> <tr> <td width="40%"><a
///                       id="PF_CHANNELS_ENABLED"></a><a id="pf_channels_enabled"></a><dl> <dt><b>PF_CHANNELS_ENABLED</b></dt> <dt>16</dt>
///                       </dl> </td> <td width="60%"> The processor channels are enabled. </td> </tr> <tr> <td width="40%"><a
///                       id="PF_COMPARE_EXCHANGE_DOUBLE"></a><a id="pf_compare_exchange_double"></a><dl>
///                       <dt><b>PF_COMPARE_EXCHANGE_DOUBLE</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The atomic compare and
///                       exchange operation (cmpxchg) is available. </td> </tr> <tr> <td width="40%"><a id="PF_COMPARE_EXCHANGE128"></a><a
///                       id="pf_compare_exchange128"></a><dl> <dt><b>PF_COMPARE_EXCHANGE128</b></dt> <dt>14</dt> </dl> </td> <td
///                       width="60%"> The atomic compare and exchange 128-bit operation (cmpxchg16b) is available. <b>Windows Server 2003
///                       and Windows XP/2000: </b>This feature is not supported. </td> </tr> <tr> <td width="40%"><a
///                       id="PF_COMPARE64_EXCHANGE128"></a><a id="pf_compare64_exchange128"></a><dl>
///                       <dt><b>PF_COMPARE64_EXCHANGE128</b></dt> <dt>15</dt> </dl> </td> <td width="60%"> The atomic compare 64 and
///                       exchange 128-bit operation (cmp8xchg16) is available. <b>Windows Server 2003 and Windows XP/2000: </b>This
///                       feature is not supported. </td> </tr> <tr> <td width="40%"><a id="PF_FASTFAIL_AVAILABLE"></a><a
///                       id="pf_fastfail_available"></a><dl> <dt><b>PF_FASTFAIL_AVAILABLE</b></dt> <dt>23</dt> </dl> </td> <td
///                       width="60%"> _fastfail() is available. </td> </tr> <tr> <td width="40%"><a id="PF_FLOATING_POINT_EMULATED"></a><a
///                       id="pf_floating_point_emulated"></a><dl> <dt><b>PF_FLOATING_POINT_EMULATED</b></dt> <dt>1</dt> </dl> </td> <td
///                       width="60%"> Floating-point operations are emulated using a software emulator. This function returns a nonzero
///                       value if floating-point operations are emulated; otherwise, it returns zero. </td> </tr> <tr> <td width="40%"><a
///                       id="PF_FLOATING_POINT_PRECISION_ERRATA"></a><a id="pf_floating_point_precision_errata"></a><dl>
///                       <dt><b>PF_FLOATING_POINT_PRECISION_ERRATA</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> On a Pentium, a
///                       floating-point precision error can occur in rare circumstances. </td> </tr> <tr> <td width="40%"><a
///                       id="PF_MMX_INSTRUCTIONS_AVAILABLE"></a><a id="pf_mmx_instructions_available"></a><dl>
///                       <dt><b>PF_MMX_INSTRUCTIONS_AVAILABLE</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> The MMX instruction set is
///                       available. </td> </tr> <tr> <td width="40%"><a id="PF_NX_ENABLED"></a><a id="pf_nx_enabled"></a><dl>
///                       <dt><b>PF_NX_ENABLED</b></dt> <dt>12</dt> </dl> </td> <td width="60%"> Data execution prevention is enabled.
///                       <b>Windows XP/2000: </b>This feature is not supported until Windows XP with SP2 and Windows Server 2003 with SP1.
///                       </td> </tr> <tr> <td width="40%"><a id="PF_PAE_ENABLED"></a><a id="pf_pae_enabled"></a><dl>
///                       <dt><b>PF_PAE_ENABLED</b></dt> <dt>9</dt> </dl> </td> <td width="60%"> The processor is PAE-enabled. For more
///                       information, see Physical Address Extension. All x64 processors always return a nonzero value for this feature.
///                       </td> </tr> <tr> <td width="40%"><a id="PF_RDTSC_INSTRUCTION_AVAILABLE"></a><a
///                       id="pf_rdtsc_instruction_available"></a><dl> <dt><b>PF_RDTSC_INSTRUCTION_AVAILABLE</b></dt> <dt>8</dt> </dl>
///                       </td> <td width="60%"> The RDTSC instruction is available. </td> </tr> <tr> <td width="40%"><a
///                       id="PF_RDWRFSGSBASE_AVAILABLE"></a><a id="pf_rdwrfsgsbase_available"></a><dl>
///                       <dt><b>PF_RDWRFSGSBASE_AVAILABLE</b></dt> <dt>22</dt> </dl> </td> <td width="60%"> RDFSBASE, RDGSBASE, WRFSBASE,
///                       and WRGSBASE instructions are available. </td> </tr> <tr> <td width="40%"><a
///                       id="PF_SECOND_LEVEL_ADDRESS_TRANSLATION"></a><a id="pf_second_level_address_translation"></a><dl>
///                       <dt><b>PF_SECOND_LEVEL_ADDRESS_TRANSLATION</b></dt> <dt>20</dt> </dl> </td> <td width="60%"> Second Level Address
///                       Translation is supported by the hardware. </td> </tr> <tr> <td width="40%"><a
///                       id="PF_SSE3_INSTRUCTIONS_AVAILABLE"></a><a id="pf_sse3_instructions_available"></a><dl>
///                       <dt><b>PF_SSE3_INSTRUCTIONS_AVAILABLE</b></dt> <dt>13</dt> </dl> </td> <td width="60%"> The SSE3 instruction set
///                       is available. <b>Windows Server 2003 and Windows XP/2000: </b>This feature is not supported. </td> </tr> <tr> <td
///                       width="40%"><a id="PF_VIRT_FIRMWARE_ENABLED"></a><a id="pf_virt_firmware_enabled"></a><dl>
///                       <dt><b>PF_VIRT_FIRMWARE_ENABLED</b></dt> <dt>21</dt> </dl> </td> <td width="60%"> Virtualization is enabled in
///                       the firmware and made available by the operating system. </td> </tr> <tr> <td width="40%"><a
///                       id="PF_XMMI_INSTRUCTIONS_AVAILABLE"></a><a id="pf_xmmi_instructions_available"></a><dl>
///                       <dt><b>PF_XMMI_INSTRUCTIONS_AVAILABLE</b></dt> <dt>6</dt> </dl> </td> <td width="60%"> The SSE instruction set is
///                       available. </td> </tr> <tr> <td width="40%"><a id="PF_XMMI64_INSTRUCTIONS_AVAILABLE"></a><a
///                       id="pf_xmmi64_instructions_available"></a><dl> <dt><b>PF_XMMI64_INSTRUCTIONS_AVAILABLE</b></dt> <dt>10</dt> </dl>
///                       </td> <td width="60%"> The SSE2 instruction set is available. <b>Windows 2000: </b>This feature is not supported.
///                       </td> </tr> <tr> <td width="40%"><a id="PF_XSAVE_ENABLED"></a><a id="pf_xsave_enabled"></a><dl>
///                       <dt><b>PF_XSAVE_ENABLED</b></dt> <dt>17</dt> </dl> </td> <td width="60%"> The processor implements the XSAVE and
///                       XRSTOR instructions. <b>Windows Server 2008, Windows Vista, Windows Server 2003 and Windows XP/2000: </b>This
///                       feature is not supported until Windows 7 and Windows Server 2008 R2. </td> </tr> <tr> <td width="40%"><a
///                       id="PF_ARM_V8_INSTRUCTIONS_AVAILABLE"></a><a id="pf_arm_v8_instructions_available"></a><dl>
///                       <dt><b>PF_ARM_V8_INSTRUCTIONS_AVAILABLE</b></dt> <dt>29</dt> </dl> </td> <td width="60%"> This ARM processor
///                       implements the the ARM v8 instructions set. </td> </tr> <tr> <td width="40%"><a
///                       id="PF_ARM_V8_CRYPTO_INSTRUCTIONS_AVAILABLE"></a><a id="pf_arm_v8_crypto_instructions_available"></a><dl>
///                       <dt><b>PF_ARM_V8_CRYPTO_INSTRUCTIONS_AVAILABLE</b></dt> <dt>30</dt> </dl> </td> <td width="60%"> This ARM
///                       processor implements the ARM v8 extra cryptographic instructions (i.e. AES, SHA1 and SHA2). </td> </tr> <tr> <td
///                       width="40%"><a id="PF_ARM_V8_CRC32_INSTRUCTIONS_AVAILABLE"></a><a
///                       id="pf_arm_v8_crc32_instructions_available"></a><dl> <dt><b>PF_ARM_V8_CRC32_INSTRUCTIONS_AVAILABLE</b></dt>
///                       <dt>31</dt> </dl> </td> <td width="60%"> This ARM processor implements the ARM v8 extra CRC32 instructions. </td>
///                       </tr> <tr> <td width="40%"><a id="PF_ARM_V81_ATOMIC_INSTRUCTIONS_AVAILABLE"></a><a
///                       id="pf_arm_v81_atomic_instructions_available"></a><dl> <dt><b>PF_ARM_V81_ATOMIC_INSTRUCTIONS_AVAILABLE</b></dt>
///                       <dt>34</dt> </dl> </td> <td width="60%"> This ARM processor implements the ARM v8.1 atomic instructions (e.g.
///                       CAS, SWP). </td> </tr> </table>
///Returns:
///    If the feature is supported, the return value is a nonzero value. If the feature is not supported, the return
///    value is zero. If the HAL does not support detection of the feature, whether or not the hardware supports the
///    feature, the return value is also zero.
///    
@DllImport("KERNEL32")
BOOL IsProcessorFeaturePresent(uint ProcessorFeature);

///Retrieves system timing information. On a multiprocessor system, the values returned are the sum of the designated
///times across all processors.
///Params:
///    lpIdleTime = A pointer to a FILETIME structure that receives the amount of time that the system has been idle.
///    lpKernelTime = A pointer to a FILETIME structure that receives the amount of time that the system has spent executing in Kernel
///                   mode (including all threads in all processes, on all processors). This time value also includes the amount of
///                   time the system has been idle.
///    lpUserTime = A pointer to a FILETIME structure that receives the amount of time that the system has spent executing in User
///                 mode (including all threads in all processes, on all processors).
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
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

///Retrieves information about the current system. To retrieve accurate information for an application running on WOW64,
///call the GetNativeSystemInfo function.
///Params:
///    lpSystemInfo = A pointer to a SYSTEM_INFO structure that receives the information.
@DllImport("KERNEL32")
void GetSystemInfo(SYSTEM_INFO* lpSystemInfo);

///Retrieves the current system date and time in Coordinated Universal Time (UTC) format. To retrieve the current system
///date and time in local time, use the GetLocalTime function.
///Params:
///    lpSystemTime = A pointer to a SYSTEMTIME structure to receive the current system date and time. The <i>lpSystemTime</i>
///                   parameter must not be <b>NULL</b>. Using <b>NULL</b> will result in an access violation.
@DllImport("KERNEL32")
void GetSystemTime(SYSTEMTIME* lpSystemTime);

///Retrieves the current system date and time. The information is in Coordinated Universal Time (UTC) format.
///Params:
///    lpSystemTimeAsFileTime = A pointer to a FILETIME structure to receive the current system date and time in UTC format.
@DllImport("KERNEL32")
void GetSystemTimeAsFileTime(FILETIME* lpSystemTimeAsFileTime);

///Retrieves the current local date and time. To retrieve the current date and time in Coordinated Universal Time (UTC)
///format, use the GetSystemTime function.
///Params:
///    lpSystemTime = A pointer to a SYSTEMTIME structure to receive the current local date and time.
@DllImport("KERNEL32")
void GetLocalTime(SYSTEMTIME* lpSystemTime);

///Queries whether user-mode Hardware-enforced Stack Protection is available for the specified environment.
///Params:
///    UserCetEnvironment = The environment to query. This parameter can be one of the following values. <table> <tr> <th>Value</th>
///                         <th>Meaning</th> </tr> <tr> <td width="40%"><a id="USER_CET_ENVIRONMENT_WIN32_PROCESS"></a><a
///                         id="user_cet_environment_win32_process"></a><dl> <dt><b>USER_CET_ENVIRONMENT_WIN32_PROCESS</b></dt>
///                         <dt>0x00000000UL</dt> </dl> </td> <td width="60%"> The Win32 environment. </td> </tr> <tr> <td width="40%"><a
///                         id="USER_CET_ENVIRONMENT_SGX2_ENCLAVE"></a><a id="user_cet_environment_sgx2_enclave"></a><dl>
///                         <dt><b>USER_CET_ENVIRONMENT_SGX2_ENCLAVE</b></dt> <dt>0x00000002UL</dt> </dl> </td> <td width="60%"> The Intel
///                         Software Guard Extensions 2 (SGX2) enclave environment. </td> </tr> <tr> <td width="40%"><a
///                         id="USER_CET_ENVIRONMENT_VBS_ENCLAVE"></a><a id="user_cet_environment_vbs_enclave"></a><dl>
///                         <dt><b>USER_CET_ENVIRONMENT_VBS_ENCLAVE</b></dt> <dt>0x00000010UL</dt> </dl> </td> <td width="60%"> The
///                         virtualization-based security (VBS) enclave environment. </td> </tr> <tr> <td width="40%"><a
///                         id="USER_CET_ENVIRONMENT_VBS_BASIC_ENCLAVE"></a><a id="user_cet_environment_vbs_basic_enclave"></a><dl>
///                         <dt><b>USER_CET_ENVIRONMENT_VBS_BASIC_ENCLAVE</b></dt> <dt>0x00000011UL</dt> </dl> </td> <td width="60%"> The
///                         virtualization-based security (VBS) basic enclave environment. </td> </tr> </table>
///Returns:
///    TRUE if user-mode Hardware-enforced Stack Protection is available for the specified environment, FALSE otherwise.
///    
@DllImport("KERNEL32")
BOOL IsUserCetAvailableInEnvironment(uint UserCetEnvironment);

@DllImport("KERNEL32")
BOOL GetSystemLeapSecondInformation(int* Enabled, uint* Flags);

///<p class="CCE_Message"><b>GetVersion</b> may be altered or unavailable for releases after Windows 8.1. Instead, use
///the Version Helper functions. For Windows 10 apps, please see [Targeting your applications for
///Windows](/windows/win32/sysinfo/targeting-your-application-at-windows-8-1). With the release of Windows 8.1, the
///behavior of the <b>GetVersion</b> API has changed in the value it will return for the operating system version. The
///value returned by the <b>GetVersion</b> function now depends on how the application is manifested. Applications not
///manifested for Windows 8.1 or Windows 10 will return the Windows 8 OS version value (6.2). Once an application is
///manifested for a given operating system version, <b>GetVersion</b> will always return the version that the
///application is manifested for in future releases. To manifest your applications for Windows 8.1 or Windows 10, refer
///to Targeting your application for Windows.
///Returns:
///    If the function succeeds, the return value includes the major and minor version numbers of the operating system
///    in the low-order word, and information about the operating system platform in the high-order word. For all
///    platforms, the low-order word contains the version number of the operating system. The low-order byte of this
///    word specifies the major version number, in hexadecimal notation. The high-order byte specifies the minor version
///    (revision) number, in hexadecimal notation. The high-order bit is zero, the next 7 bits represent the build
///    number, and the low-order byte is 5.
///    
@DllImport("KERNEL32")
uint GetVersion();

///Sets the current local time and date.
///Params:
///    lpSystemTime = A pointer to a SYSTEMTIME structure that contains the new local date and time. The <b>wDayOfWeek</b> member of
///                   the SYSTEMTIME structure is ignored.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL SetLocalTime(const(SYSTEMTIME)* lpSystemTime);

///Retrieves the number of milliseconds that have elapsed since the system was started, up to 49.7 days.
///Returns:
///    The return value is the number of milliseconds that have elapsed since the system was started.
///    
@DllImport("KERNEL32")
uint GetTickCount();

///Retrieves the number of milliseconds that have elapsed since the system was started.
///Returns:
///    The number of milliseconds.
///    
@DllImport("KERNEL32")
ulong GetTickCount64();

///Determines whether the system is applying periodic time adjustments to its time-of-day clock, and obtains the value
///and period of any such adjustments.
///Params:
///    lpTimeAdjustment = A pointer to a variable that the function sets to the number of <i>lpTimeIncrement</i>100-nanosecond units added
///                       to the time-of-day clock for every period of time which actually passes as counted by the system. This value only
///                       has meaning if <i>lpTimeAdjustmentDisabled</i> is <b>FALSE</b>.
///    lpTimeIncrement = A pointer to a variable that the function sets to the interval in 100-nanosecond units at which the system will
///                      add <i>lpTimeAdjustment</i> to the time-of-day clock. This value only has meaning if
///                      <i>lpTimeAdjustmentDisabled</i> is <b>FALSE</b>.
///    lpTimeAdjustmentDisabled = A pointer to a variable that the function sets to indicate whether periodic time adjustment is in effect. A value
///                               of <b>TRUE</b> indicates that periodic time adjustment is disabled, and the system time-of-day clock advances at
///                               the normal rate. In this mode, the system may adjust the time of day using its own internal time synchronization
///                               mechanisms. These internal time synchronization mechanisms may cause the time-of-day clock to change during the
///                               normal course of the system operation, which can include noticeable jumps in time as deemed necessary by the
///                               system. A value of <b>FALSE</b> indicates that periodic time adjustment is being used to adjust the time-of-day
///                               clock. For each <i>lpTimeIncrement</i> period of time that actually passes, <i>lpTimeAdjustment</i> will be added
///                               to the time of day. If the <i>lpTimeAdjustment</i> value is smaller than <i>lpTimeIncrement</i>, the system
///                               time-of-day clock will advance at a rate slower than normal. If the <i>lpTimeAdjustment</i> value is larger than
///                               <i>lpTimeIncrement</i>, the time-of-day clock will advance at a rate faster than normal. If
///                               <i>lpTimeAdjustment</i> equals <i>lpTimeIncrement</i>, the time-of-day clock will advance at its normal speed.
///                               The <i>lpTimeAdjustment</i> value can be set by calling SetSystemTimeAdjustment. The <i>lpTimeIncrement</i> value
///                               is fixed by the system upon start, and does not change during system operation. In this mode, the system will not
///                               interfere with the time adjustment scheme, and will not attempt to synchronize time of day on its own via other
///                               techniques.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL GetSystemTimeAdjustment(uint* lpTimeAdjustment, uint* lpTimeIncrement, int* lpTimeAdjustmentDisabled);

///Determines whether the system is applying periodic, programmed time adjustments to its time-of-day clock, and obtains
///the value and period of any such adjustments.
///Params:
///    lpTimeAdjustment = Returns the adjusted clock update frequency.
///    lpTimeIncrement = Returns the clock update frequency.
///    lpTimeAdjustmentDisabled = Returns an indicator which specifies whether the time adjustment is enabled. A value of <b>TRUE</b> indicates
///                               that periodic adjustment is disabled. In this case, the system may attempt to keep the time-of-day clock in sync
///                               using its own internal mechanisms. This may cause time-of-day to periodically jump to the "correct time." A value
///                               of <b>FALSE</b> indicates that periodic, programmed time adjustment is being used to serialize time-of-day, and
///                               the system will not interfere or attempt to synchronize time-of-day on its own.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("api-ms-win-core-sysinfo-l1-2-4")
BOOL GetSystemTimeAdjustmentPrecise(ulong* lpTimeAdjustment, ulong* lpTimeIncrement, int* lpTimeAdjustmentDisabled);

///Retrieves the path of the system directory. The system directory contains system files such as dynamic-link libraries
///and drivers. This function is provided primarily for compatibility. Applications should store code in the Program
///Files folder and persistent data in the Application Data folder in the user's profile. For more information, see
///ShGetFolderPath.
///Params:
///    lpBuffer = A pointer to the buffer to receive the path. This path does not end with a backslash unless the system directory
///               is the root directory. For example, if the system directory is named Windows\System32 on drive C, the path of the
///               system directory retrieved by this function is C:\Windows\System32.
///    uSize = The maximum size of the buffer, in <b>TCHARs</b>.
///Returns:
///    If the function succeeds, the return value is the length, in <b>TCHARs</b>, of the string copied to the buffer,
///    not including the terminating null character. If the length is greater than the size of the buffer, the return
///    value is the size of the buffer required to hold the path, including the terminating null character. If the
///    function fails, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
uint GetSystemDirectoryA(const(char)* lpBuffer, uint uSize);

///Retrieves the path of the system directory. The system directory contains system files such as dynamic-link libraries
///and drivers. This function is provided primarily for compatibility. Applications should store code in the Program
///Files folder and persistent data in the Application Data folder in the user's profile. For more information, see
///ShGetFolderPath.
///Params:
///    lpBuffer = A pointer to the buffer to receive the path. This path does not end with a backslash unless the system directory
///               is the root directory. For example, if the system directory is named Windows\System32 on drive C, the path of the
///               system directory retrieved by this function is C:\Windows\System32.
///    uSize = The maximum size of the buffer, in <b>TCHARs</b>.
///Returns:
///    If the function succeeds, the return value is the length, in <b>TCHARs</b>, of the string copied to the buffer,
///    not including the terminating null character. If the length is greater than the size of the buffer, the return
///    value is the size of the buffer required to hold the path, including the terminating null character. If the
///    function fails, the return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
uint GetSystemDirectoryW(const(wchar)* lpBuffer, uint uSize);

///Retrieves the path of the Windows directory. This function is provided primarily for compatibility with legacy
///applications. New applications should store code in the Program Files folder and persistent data in the Application
///Data folder in the user's profile. For more information, see ShGetFolderPath.
///Params:
///    lpBuffer = A pointer to a buffer that receives the path. This path does not end with a backslash unless the Windows
///               directory is the root directory. For example, if the Windows directory is named Windows on drive C, the path of
///               the Windows directory retrieved by this function is C:\Windows. If the system was installed in the root directory
///               of drive C, the path retrieved is C:\.
///    uSize = The maximum size of the buffer specified by the <i>lpBuffer</i> parameter, in <b>TCHARs</b>. This value should be
///            set to <b>MAX_PATH</b>.
///Returns:
///    If the function succeeds, the return value is the length of the string copied to the buffer, in <b>TCHARs</b>,
///    not including the terminating null character. If the length is greater than the size of the buffer, the return
///    value is the size of the buffer required to hold the path. If the function fails, the return value is zero. To
///    get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
uint GetWindowsDirectoryA(const(char)* lpBuffer, uint uSize);

///Retrieves the path of the Windows directory. This function is provided primarily for compatibility with legacy
///applications. New applications should store code in the Program Files folder and persistent data in the Application
///Data folder in the user's profile. For more information, see ShGetFolderPath.
///Params:
///    lpBuffer = A pointer to a buffer that receives the path. This path does not end with a backslash unless the Windows
///               directory is the root directory. For example, if the Windows directory is named Windows on drive C, the path of
///               the Windows directory retrieved by this function is C:\Windows. If the system was installed in the root directory
///               of drive C, the path retrieved is C:\.
///    uSize = The maximum size of the buffer specified by the <i>lpBuffer</i> parameter, in <b>TCHARs</b>. This value should be
///            set to <b>MAX_PATH</b>.
///Returns:
///    If the function succeeds, the return value is the length of the string copied to the buffer, in <b>TCHARs</b>,
///    not including the terminating null character. If the length is greater than the size of the buffer, the return
///    value is the size of the buffer required to hold the path. If the function fails, the return value is zero. To
///    get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
uint GetWindowsDirectoryW(const(wchar)* lpBuffer, uint uSize);

///Retrieves the path of the shared Windows directory on a multi-user system. This function is provided primarily for
///compatibility. Applications should store code in the Program Files folder and persistent data in the Application Data
///folder in the user's profile. For more information, see ShGetFolderPath.
///Params:
///    lpBuffer = A pointer to the buffer to receive the path. This path does not end with a backslash unless the Windows directory
///               is the root directory. For example, if the Windows directory is named Windows on drive C, the path of the Windows
///               directory retrieved by this function is C:\Windows. If the system was installed in the root directory of drive C,
///               the path retrieved is C:\.
///    uSize = The maximum size of the buffer specified by the <i>lpBuffer</i> parameter, in <b>TCHARs</b>.
///Returns:
///    If the function succeeds, the return value is the length of the string copied to the buffer, in <b>TCHARs</b>,
///    not including the terminating null character. If the length is greater than the size of the buffer, the return
///    value is the size of the buffer required to hold the path. If the function fails, the return value is zero. To
///    get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
uint GetSystemWindowsDirectoryA(const(char)* lpBuffer, uint uSize);

///Retrieves the path of the shared Windows directory on a multi-user system. This function is provided primarily for
///compatibility. Applications should store code in the Program Files folder and persistent data in the Application Data
///folder in the user's profile. For more information, see ShGetFolderPath.
///Params:
///    lpBuffer = A pointer to the buffer to receive the path. This path does not end with a backslash unless the Windows directory
///               is the root directory. For example, if the Windows directory is named Windows on drive C, the path of the Windows
///               directory retrieved by this function is C:\Windows. If the system was installed in the root directory of drive C,
///               the path retrieved is C:\.
///    uSize = The maximum size of the buffer specified by the <i>lpBuffer</i> parameter, in <b>TCHARs</b>.
///Returns:
///    If the function succeeds, the return value is the length of the string copied to the buffer, in <b>TCHARs</b>,
///    not including the terminating null character. If the length is greater than the size of the buffer, the return
///    value is the size of the buffer required to hold the path. If the function fails, the return value is zero. To
///    get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
uint GetSystemWindowsDirectoryW(const(wchar)* lpBuffer, uint uSize);

///Retrieves a NetBIOS or DNS name associated with the local computer. The names are established at system startup, when
///the system reads them from the registry.
///Params:
///    NameType = The type of name to be retrieved. This parameter is a value from the COMPUTER_NAME_FORMAT enumeration type. The
///               following table provides additional information. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///               width="40%"><a id="ComputerNameDnsDomain"></a><a id="computernamednsdomain"></a><a
///               id="COMPUTERNAMEDNSDOMAIN"></a><dl> <dt><b>ComputerNameDnsDomain</b></dt> </dl> </td> <td width="60%"> The name
///               of the DNS domain assigned to the local computer. If the local computer is a node in a cluster, <i>lpBuffer</i>
///               receives the DNS domain name of the cluster virtual server. </td> </tr> <tr> <td width="40%"><a
///               id="ComputerNameDnsFullyQualified"></a><a id="computernamednsfullyqualified"></a><a
///               id="COMPUTERNAMEDNSFULLYQUALIFIED"></a><dl> <dt><b>ComputerNameDnsFullyQualified</b></dt> </dl> </td> <td
///               width="60%"> The fully qualified DNS name that uniquely identifies the local computer. This name is a combination
///               of the DNS host name and the DNS domain name, using the form <i>HostName</i>.<i>DomainName</i>. If the local
///               computer is a node in a cluster, <i>lpBuffer</i> receives the fully qualified DNS name of the cluster virtual
///               server. </td> </tr> <tr> <td width="40%"><a id="ComputerNameDnsHostname"></a><a
///               id="computernamednshostname"></a><a id="COMPUTERNAMEDNSHOSTNAME"></a><dl> <dt><b>ComputerNameDnsHostname</b></dt>
///               </dl> </td> <td width="60%"> The DNS host name of the local computer. If the local computer is a node in a
///               cluster, <i>lpBuffer</i> receives the DNS host name of the cluster virtual server. </td> </tr> <tr> <td
///               width="40%"><a id="ComputerNameNetBIOS"></a><a id="computernamenetbios"></a><a id="COMPUTERNAMENETBIOS"></a><dl>
///               <dt><b>ComputerNameNetBIOS</b></dt> </dl> </td> <td width="60%"> The NetBIOS name of the local computer. If the
///               local computer is a node in a cluster, <i>lpBuffer</i> receives the NetBIOS name of the cluster virtual server.
///               </td> </tr> <tr> <td width="40%"><a id="ComputerNamePhysicalDnsDomain"></a><a
///               id="computernamephysicaldnsdomain"></a><a id="COMPUTERNAMEPHYSICALDNSDOMAIN"></a><dl>
///               <dt><b>ComputerNamePhysicalDnsDomain</b></dt> </dl> </td> <td width="60%"> The name of the DNS domain assigned to
///               the local computer. If the local computer is a node in a cluster, <i>lpBuffer</i> receives the DNS domain name of
///               the local computer, not the name of the cluster virtual server. </td> </tr> <tr> <td width="40%"><a
///               id="ComputerNamePhysicalDnsFullyQualified"></a><a id="computernamephysicaldnsfullyqualified"></a><a
///               id="COMPUTERNAMEPHYSICALDNSFULLYQUALIFIED"></a><dl> <dt><b>ComputerNamePhysicalDnsFullyQualified</b></dt> </dl>
///               </td> <td width="60%"> The fully qualified DNS name that uniquely identifies the computer. If the local computer
///               is a node in a cluster, <i>lpBuffer</i> receives the fully qualified DNS name of the local computer, not the name
///               of the cluster virtual server. The fully qualified DNS name is a combination of the DNS host name and the DNS
///               domain name, using the form <i>HostName</i>.<i>DomainName</i>. </td> </tr> <tr> <td width="40%"><a
///               id="ComputerNamePhysicalDnsHostname"></a><a id="computernamephysicaldnshostname"></a><a
///               id="COMPUTERNAMEPHYSICALDNSHOSTNAME"></a><dl> <dt><b>ComputerNamePhysicalDnsHostname</b></dt> </dl> </td> <td
///               width="60%"> The DNS host name of the local computer. If the local computer is a node in a cluster,
///               <i>lpBuffer</i> receives the DNS host name of the local computer, not the name of the cluster virtual server.
///               </td> </tr> <tr> <td width="40%"><a id="ComputerNamePhysicalNetBIOS"></a><a
///               id="computernamephysicalnetbios"></a><a id="COMPUTERNAMEPHYSICALNETBIOS"></a><dl>
///               <dt><b>ComputerNamePhysicalNetBIOS</b></dt> </dl> </td> <td width="60%"> The NetBIOS name of the local computer.
///               If the local computer is a node in a cluster, <i>lpBuffer</i> receives the NetBIOS name of the local computer,
///               not the name of the cluster virtual server. </td> </tr> </table>
///    lpBuffer = A pointer to a buffer that receives the computer name or the cluster virtual server name. The length of the name
///               may be greater than MAX_COMPUTERNAME_LENGTH characters because DNS allows longer names. To ensure that this
///               buffer is large enough, set this parameter to <b>NULL</b> and use the required buffer size returned in the
///               <i>lpnSize</i> parameter.
///    nSize = On input, specifies the size of the buffer, in <b>TCHARs</b>. On output, receives the number of <b>TCHARs</b>
///            copied to the destination buffer, not including the terminating <b>null</b> character. If the buffer is too
///            small, the function fails and GetLastError returns ERROR_MORE_DATA. This parameter receives the size of the
///            buffer required, including the terminating <b>null</b> character. If <i>lpBuffer</i> is <b>NULL</b>, this
///            parameter must be zero.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError. Possible values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl>
///    </td> <td width="60%"> The <i>lpBuffer</i> buffer is too small. The <i>lpnSize</i> parameter contains the number
///    of bytes required to receive the name. </td> </tr> </table>
///    
@DllImport("KERNEL32")
BOOL GetComputerNameExA(COMPUTER_NAME_FORMAT NameType, const(char)* lpBuffer, uint* nSize);

///Retrieves a NetBIOS or DNS name associated with the local computer. The names are established at system startup, when
///the system reads them from the registry.
///Params:
///    NameType = The type of name to be retrieved. This parameter is a value from the COMPUTER_NAME_FORMAT enumeration type. The
///               following table provides additional information. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///               width="40%"><a id="ComputerNameDnsDomain"></a><a id="computernamednsdomain"></a><a
///               id="COMPUTERNAMEDNSDOMAIN"></a><dl> <dt><b>ComputerNameDnsDomain</b></dt> </dl> </td> <td width="60%"> The name
///               of the DNS domain assigned to the local computer. If the local computer is a node in a cluster, <i>lpBuffer</i>
///               receives the DNS domain name of the cluster virtual server. </td> </tr> <tr> <td width="40%"><a
///               id="ComputerNameDnsFullyQualified"></a><a id="computernamednsfullyqualified"></a><a
///               id="COMPUTERNAMEDNSFULLYQUALIFIED"></a><dl> <dt><b>ComputerNameDnsFullyQualified</b></dt> </dl> </td> <td
///               width="60%"> The fully qualified DNS name that uniquely identifies the local computer. This name is a combination
///               of the DNS host name and the DNS domain name, using the form <i>HostName</i>.<i>DomainName</i>. If the local
///               computer is a node in a cluster, <i>lpBuffer</i> receives the fully qualified DNS name of the cluster virtual
///               server. </td> </tr> <tr> <td width="40%"><a id="ComputerNameDnsHostname"></a><a
///               id="computernamednshostname"></a><a id="COMPUTERNAMEDNSHOSTNAME"></a><dl> <dt><b>ComputerNameDnsHostname</b></dt>
///               </dl> </td> <td width="60%"> The DNS host name of the local computer. If the local computer is a node in a
///               cluster, <i>lpBuffer</i> receives the DNS host name of the cluster virtual server. </td> </tr> <tr> <td
///               width="40%"><a id="ComputerNameNetBIOS"></a><a id="computernamenetbios"></a><a id="COMPUTERNAMENETBIOS"></a><dl>
///               <dt><b>ComputerNameNetBIOS</b></dt> </dl> </td> <td width="60%"> The NetBIOS name of the local computer. If the
///               local computer is a node in a cluster, <i>lpBuffer</i> receives the NetBIOS name of the cluster virtual server.
///               </td> </tr> <tr> <td width="40%"><a id="ComputerNamePhysicalDnsDomain"></a><a
///               id="computernamephysicaldnsdomain"></a><a id="COMPUTERNAMEPHYSICALDNSDOMAIN"></a><dl>
///               <dt><b>ComputerNamePhysicalDnsDomain</b></dt> </dl> </td> <td width="60%"> The name of the DNS domain assigned to
///               the local computer. If the local computer is a node in a cluster, <i>lpBuffer</i> receives the DNS domain name of
///               the local computer, not the name of the cluster virtual server. </td> </tr> <tr> <td width="40%"><a
///               id="ComputerNamePhysicalDnsFullyQualified"></a><a id="computernamephysicaldnsfullyqualified"></a><a
///               id="COMPUTERNAMEPHYSICALDNSFULLYQUALIFIED"></a><dl> <dt><b>ComputerNamePhysicalDnsFullyQualified</b></dt> </dl>
///               </td> <td width="60%"> The fully qualified DNS name that uniquely identifies the computer. If the local computer
///               is a node in a cluster, <i>lpBuffer</i> receives the fully qualified DNS name of the local computer, not the name
///               of the cluster virtual server. The fully qualified DNS name is a combination of the DNS host name and the DNS
///               domain name, using the form <i>HostName</i>.<i>DomainName</i>. </td> </tr> <tr> <td width="40%"><a
///               id="ComputerNamePhysicalDnsHostname"></a><a id="computernamephysicaldnshostname"></a><a
///               id="COMPUTERNAMEPHYSICALDNSHOSTNAME"></a><dl> <dt><b>ComputerNamePhysicalDnsHostname</b></dt> </dl> </td> <td
///               width="60%"> The DNS host name of the local computer. If the local computer is a node in a cluster,
///               <i>lpBuffer</i> receives the DNS host name of the local computer, not the name of the cluster virtual server.
///               </td> </tr> <tr> <td width="40%"><a id="ComputerNamePhysicalNetBIOS"></a><a
///               id="computernamephysicalnetbios"></a><a id="COMPUTERNAMEPHYSICALNETBIOS"></a><dl>
///               <dt><b>ComputerNamePhysicalNetBIOS</b></dt> </dl> </td> <td width="60%"> The NetBIOS name of the local computer.
///               If the local computer is a node in a cluster, <i>lpBuffer</i> receives the NetBIOS name of the local computer,
///               not the name of the cluster virtual server. </td> </tr> </table>
///    lpBuffer = A pointer to a buffer that receives the computer name or the cluster virtual server name. The length of the name
///               may be greater than MAX_COMPUTERNAME_LENGTH characters because DNS allows longer names. To ensure that this
///               buffer is large enough, set this parameter to <b>NULL</b> and use the required buffer size returned in the
///               <i>lpnSize</i> parameter.
///    nSize = On input, specifies the size of the buffer, in <b>TCHARs</b>. On output, receives the number of <b>TCHARs</b>
///            copied to the destination buffer, not including the terminating <b>null</b> character. If the buffer is too
///            small, the function fails and GetLastError returns ERROR_MORE_DATA. This parameter receives the size of the
///            buffer required, including the terminating <b>null</b> character. If <i>lpBuffer</i> is <b>NULL</b>, this
///            parameter must be zero.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError. Possible values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl>
///    </td> <td width="60%"> The <i>lpBuffer</i> buffer is too small. The <i>lpnSize</i> parameter contains the number
///    of bytes required to receive the name. </td> </tr> </table>
///    
@DllImport("KERNEL32")
BOOL GetComputerNameExW(COMPUTER_NAME_FORMAT NameType, const(wchar)* lpBuffer, uint* nSize);

///Sets a new NetBIOS or DNS name for the local computer. Name changes made by <b>SetComputerNameEx</b> do not take
///effect until the user restarts the computer.
///Params:
///    NameType = The type of name to be set. This parameter can be one of the following values from the COMPUTER_NAME_FORMAT
///               enumeration type. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///               id="ComputerNamePhysicalDnsDomain"></a><a id="computernamephysicaldnsdomain"></a><a
///               id="COMPUTERNAMEPHYSICALDNSDOMAIN"></a><dl> <dt><b>ComputerNamePhysicalDnsDomain</b></dt> </dl> </td> <td
///               width="60%"> Sets the primary DNS suffix of the computer. </td> </tr> <tr> <td width="40%"><a
///               id="ComputerNamePhysicalDnsHostname"></a><a id="computernamephysicaldnshostname"></a><a
///               id="COMPUTERNAMEPHYSICALDNSHOSTNAME"></a><dl> <dt><b>ComputerNamePhysicalDnsHostname</b></dt> </dl> </td> <td
///               width="60%"> Sets the NetBIOS and the Computer Name (the first label of the full DNS name) to the name specified
///               in <i>lpBuffer</i>. If the name exceeds MAX_COMPUTERNAME_LENGTH characters, the NetBIOS name is truncated to
///               MAX_COMPUTERNAME_LENGTH characters, not including the terminating null character. </td> </tr> <tr> <td
///               width="40%"><a id="ComputerNamePhysicalNetBIOS"></a><a id="computernamephysicalnetbios"></a><a
///               id="COMPUTERNAMEPHYSICALNETBIOS"></a><dl> <dt><b>ComputerNamePhysicalNetBIOS</b></dt> </dl> </td> <td
///               width="60%"> Sets the NetBIOS name to the name specified in <i>lpBuffer</i>. The name cannot exceed
///               MAX_COMPUTERNAME_LENGTH characters, not including the terminating null character. Warning: Using this option to
///               set the NetBIOS name breaks the convention of interdependent NetBIOS and DNS names. Applications that use the
///               DnsHostnameToComputerName function to derive the NetBIOS name from the first label of the DNS name will fail if
///               this convention is broken. </td> </tr> </table>
///    lpBuffer = The new name. The name cannot include control characters, leading or trailing spaces, or any of the following
///               characters: " / \ [ ] : | &lt; &gt; + = ; , ?
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL SetComputerNameExW(COMPUTER_NAME_FORMAT NameType, const(wchar)* lpBuffer);

///Sets the current system time and date. The system time is expressed in Coordinated Universal Time (UTC).
///Params:
///    lpSystemTime = A pointer to a SYSTEMTIME structure that contains the new system date and time. The <b>wDayOfWeek</b> member of
///                   the SYSTEMTIME structure is ignored.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL SetSystemTime(const(SYSTEMTIME)* lpSystemTime);

///<b>GetVersionExA</b> may be altered or unavailable for releases after Windows 8.1. Instead, use the Version Helper
///functions. For Windows 10 apps, please see [Targeting your applications for
///Windows](/windows/win32/sysinfo/targeting-your-application-at-windows-8-1). With the release of Windows 8.1, the
///behavior of the <b>GetVersionEx</b> API has changed in the value it will return for the operating system version. The
///value returned by the <b>GetVersionEx</b> function now depends on how the application is manifested. Applications not
///manifested for Windows 8.1 or Windows 10 will return the Windows 8 OS version value (6.2). Once an application is
///manifested for a given operating system version, <b>GetVersionEx</b> will always return the version that the
///application is manifested for in future releases. To manifest your applications for Windows 8.1 or Windows 10, refer
///to Targeting your application for Windows.
///Params:
///    lpVersionInformation = An OSVERSIONINFO or OSVERSIONINFOEX structure that receives the operating system information. Before calling the
///                           <b>GetVersionEx</b> function, set the <b>dwOSVersionInfoSize</b> member of the structure as appropriate to
///                           indicate which data structure is being passed to this function.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError. The function fails if you specify an invalid value for the
///    <b>dwOSVersionInfoSize</b> member of the OSVERSIONINFO or OSVERSIONINFOEX structure.
///    
@DllImport("KERNEL32")
BOOL GetVersionExA(OSVERSIONINFOA* lpVersionInformation);

///<p class="CCE_Message">[<b>GetVersionEx</b> may be altered or unavailable for releases after Windows 8.1. Instead,
///use the Version Helper functions] With the release of Windows 8.1, the behavior of the <b>GetVersionEx</b> API has
///changed in the value it will return for the operating system version. The value returned by the <b>GetVersionEx</b>
///function now depends on how the application is manifested. Applications not manifested for Windows 8.1 or Windows 10
///will return the Windows 8 OS version value (6.2). Once an application is manifested for a given operating system
///version, <b>GetVersionEx</b> will always return the version that the application is manifested for in future
///releases. To manifest your applications for Windows 8.1 or Windows 10, refer to Targeting your application for
///Windows.
///Params:
///    lpVersionInformation = An OSVERSIONINFO or OSVERSIONINFOEX structure that receives the operating system information. Before calling the
///                           <b>GetVersionEx</b> function, set the <b>dwOSVersionInfoSize</b> member of the structure as appropriate to
///                           indicate which data structure is being passed to this function.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError. The function fails if you specify an invalid value for the
///    <b>dwOSVersionInfoSize</b> member of the OSVERSIONINFO or OSVERSIONINFOEX structure.
///    
@DllImport("KERNEL32")
BOOL GetVersionExW(OSVERSIONINFOW* lpVersionInformation);

///Retrieves information about the current system to an application running under WOW64. If the function is called from
///a 64-bit application, or on a 64-bit system that does not have an Intel64 or x64 processor (such as ARM64), it is
///equivalent to the GetSystemInfo function.
///Params:
///    lpSystemInfo = A pointer to a SYSTEM_INFO structure that receives the information.
@DllImport("KERNEL32")
void GetNativeSystemInfo(SYSTEM_INFO* lpSystemInfo);

///The <b>GetSystemTimePreciseAsFileTime</b> function retrieves the current system date and time with the highest
///possible level of precision (&lt;1us). The retrieved information is in Coordinated Universal Time (UTC) format.
///Params:
///    lpSystemTimeAsFileTime = Type: <b>LPFILETIME</b> A pointer to a FILETIME structure that contains the current system date and time in UTC
///                             format.
@DllImport("KERNEL32")
void GetSystemTimePreciseAsFileTime(FILETIME* lpSystemTimeAsFileTime);

///Retrieves the product type for the operating system on the local computer, and maps the type to the product types
///supported by the specified operating system. To retrieve product type information on versions of Windows prior to the
///minimum supported operating systems specified in the Requirements section, use the GetVersionEx function. You can
///also use the <b>OperatingSystemSKU</b> property of the Win32_OperatingSystem WMI class.
///Params:
///    dwOSMajorVersion = The major version number of the operating system. The minimum value is 6. The combination of the
///                       <i>dwOSMajorVersion</i>, <i>dwOSMinorVersion</i>, <i>dwSpMajorVersion</i>, and <i>dwSpMinorVersion</i> parameters
///                       describes the maximum target operating system version for the application. For example, Windows Vista and Windows
///                       Server 2008 are version 6.0.0.0 and Windows 7 and Windows Server 2008 R2 are version 6.1.0.0. All Windows 10
///                       based releases will be listed as version 6.3.
///    dwOSMinorVersion = The minor version number of the operating system. The minimum value is 0.
///    dwSpMajorVersion = The major version number of the operating system service pack. The minimum value is 0.
///    dwSpMinorVersion = The minor version number of the operating system service pack. The minimum value is 0.
///    pdwReturnedProductType = The product type. This parameter cannot be <b>NULL</b>. If the specified operating system is less than the
///                             current operating system, this information is mapped to the types supported by the specified operating system. If
///                             the specified operating system is greater than the highest supported operating system, this information is mapped
///                             to the types supported by the current operating system. This parameter can be one of the following values (some
///                             products below may be out of support). <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_BUSINESS"></a><a id="product_business"></a><dl> <dt><b>PRODUCT_BUSINESS</b></dt> <dt>0x00000006</dt>
///                             </dl> </td> <td width="60%"> Business </td> </tr> <tr> <td width="40%"><a id="PRODUCT_BUSINESS_N"></a><a
///                             id="product_business_n"></a><dl> <dt><b>PRODUCT_BUSINESS_N</b></dt> <dt>0x00000010</dt> </dl> </td> <td
///                             width="60%"> Business N </td> </tr> <tr> <td width="40%"><a id="PRODUCT_CLUSTER_SERVER"></a><a
///                             id="product_cluster_server"></a><dl> <dt><b>PRODUCT_CLUSTER_SERVER</b></dt> <dt>0x00000012</dt> </dl> </td> <td
///                             width="60%"> HPC Edition </td> </tr> <tr> <td width="40%"><a id="PRODUCT_CLUSTER_SERVER_V"></a><a
///                             id="product_cluster_server_v"></a><dl> <dt><b>PRODUCT_CLUSTER_SERVER_V</b></dt> <dt>0x00000040</dt> </dl> </td>
///                             <td width="60%"> Server Hyper Core V </td> </tr> <tr> <td width="40%"><a id="PRODUCT_CORE"></a><a
///                             id="product_core"></a><dl> <dt><b>PRODUCT_CORE</b></dt> <dt>0x00000065</dt> </dl> </td> <td width="60%"> Windows
///                             10 Home </td> </tr> <tr> <td width="40%"><a id="PRODUCT_CORE_COUNTRYSPECIFIC"></a><a
///                             id="product_core_countryspecific"></a><dl> <dt><b>PRODUCT_CORE_COUNTRYSPECIFIC</b></dt> <dt>0x00000063</dt> </dl>
///                             </td> <td width="60%"> Windows 10 Home China </td> </tr> <tr> <td width="40%"><a id="PRODUCT_CORE_N"></a><a
///                             id="product_core_n"></a><dl> <dt><b>PRODUCT_CORE_N</b></dt> <dt>0x00000062</dt> </dl> </td> <td width="60%">
///                             Windows 10 Home N </td> </tr> <tr> <td width="40%"><a id="PRODUCT_CORE_SINGLELANGUAGE"></a><a
///                             id="product_core_singlelanguage"></a><dl> <dt><b>PRODUCT_CORE_SINGLELANGUAGE</b></dt> <dt>0x00000064</dt> </dl>
///                             </td> <td width="60%"> Windows 10 Home Single Language </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_DATACENTER_EVALUATION_SERVER"></a><a id="product_datacenter_evaluation_server"></a><dl>
///                             <dt><b>PRODUCT_DATACENTER_EVALUATION_SERVER</b></dt> <dt>0x00000050</dt> </dl> </td> <td width="60%"> Server
///                             Datacenter (evaluation installation) </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_DATACENTER_A_SERVER_CORE"></a><a id="product_datacenter_a_server_core"></a><dl>
///                             <dt><b>PRODUCT_DATACENTER_A_SERVER_CORE</b></dt> <dt>0x00000091</dt> </dl> </td> <td width="60%"> Server
///                             Datacenter, Semi-Annual Channel (core installation) </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_STANDARD_A_SERVER_CORE"></a><a id="product_standard_a_server_core"></a><dl>
///                             <dt><b>PRODUCT_STANDARD_A_SERVER_CORE</b></dt> <dt>0x00000092</dt> </dl> </td> <td width="60%"> Server Standard,
///                             Semi-Annual Channel (core installation) </td> </tr> <tr> <td width="40%"><a id="PRODUCT_DATACENTER_SERVER"></a><a
///                             id="product_datacenter_server"></a><dl> <dt><b>PRODUCT_DATACENTER_SERVER</b></dt> <dt>0x00000008</dt> </dl> </td>
///                             <td width="60%"> Server Datacenter (full installation. For Server Core installations of Windows Server 2012 and
///                             later, use the method, Determining whether Server Core is running.) </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_DATACENTER_SERVER_CORE"></a><a id="product_datacenter_server_core"></a><dl>
///                             <dt><b>PRODUCT_DATACENTER_SERVER_CORE</b></dt> <dt>0x0000000C</dt> </dl> </td> <td width="60%"> Server Datacenter
///                             (core installation, Windows Server 2008 R2 and earlier) </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_DATACENTER_SERVER_CORE_V"></a><a id="product_datacenter_server_core_v"></a><dl>
///                             <dt><b>PRODUCT_DATACENTER_SERVER_CORE_V</b></dt> <dt>0x00000027</dt> </dl> </td> <td width="60%"> Server
///                             Datacenter without Hyper-V (core installation) </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_DATACENTER_SERVER_V"></a><a id="product_datacenter_server_v"></a><dl>
///                             <dt><b>PRODUCT_DATACENTER_SERVER_V</b></dt> <dt>0x00000025</dt> </dl> </td> <td width="60%"> Server Datacenter
///                             without Hyper-V (full installation) </td> </tr> <tr> <td width="40%"><a id="PRODUCT_EDUCATION"></a><a
///                             id="product_education"></a><dl> <dt><b>PRODUCT_EDUCATION</b></dt> <dt>0x00000079</dt> </dl> </td> <td
///                             width="60%"> Windows 10 Education </td> </tr> <tr> <td width="40%"><a id="PRODUCT_EDUCATION_N"></a><a
///                             id="product_education_n"></a><dl> <dt><b>PRODUCT_EDUCATION_N</b></dt> <dt>0x0000007A</dt> </dl> </td> <td
///                             width="60%"> Windows 10 Education N </td> </tr> <tr> <td width="40%"><a id="PRODUCT_ENTERPRISE"></a><a
///                             id="product_enterprise"></a><dl> <dt><b>PRODUCT_ENTERPRISE</b></dt> <dt>0x00000004</dt> </dl> </td> <td
///                             width="60%"> Windows 10 Enterprise </td> </tr> <tr> <td width="40%"><a id="PRODUCT_ENTERPRISE_E"></a><a
///                             id="product_enterprise_e"></a><dl> <dt><b>PRODUCT_ENTERPRISE_E</b></dt> <dt>0x00000046</dt> </dl> </td> <td
///                             width="60%"> Windows 10 Enterprise E </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_ENTERPRISE_EVALUATION"></a><a id="product_enterprise_evaluation"></a><dl>
///                             <dt><b>PRODUCT_ENTERPRISE_EVALUATION</b></dt> <dt>0x00000048</dt> </dl> </td> <td width="60%"> Windows 10
///                             Enterprise Evaluation </td> </tr> <tr> <td width="40%"><a id="PRODUCT_ENTERPRISE_N"></a><a
///                             id="product_enterprise_n"></a><dl> <dt><b>PRODUCT_ENTERPRISE_N</b></dt> <dt>0x0000001B</dt> </dl> </td> <td
///                             width="60%"> Windows 10 Enterprise N </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_ENTERPRISE_N_EVALUATION"></a><a id="product_enterprise_n_evaluation"></a><dl>
///                             <dt><b>PRODUCT_ENTERPRISE_N_EVALUATION</b></dt> <dt>0x00000054</dt> </dl> </td> <td width="60%"> Windows 10
///                             Enterprise N Evaluation </td> </tr> <tr> <td width="40%"><a id="PRODUCT_ENTERPRISE_S"></a><a
///                             id="product_enterprise_s"></a><dl> <dt><b>PRODUCT_ENTERPRISE_S</b></dt> <dt>0x0000007D</dt> </dl> </td> <td
///                             width="60%"> Windows 10 Enterprise 2015 LTSB </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_ENTERPRISE_S_EVALUATION"></a><a id="product_enterprise_s_evaluation"></a><dl>
///                             <dt><b>PRODUCT_ENTERPRISE_S_EVALUATION</b></dt> <dt>0x00000081</dt> </dl> </td> <td width="60%"> Windows 10
///                             Enterprise 2015 LTSB Evaluation </td> </tr> <tr> <td width="40%"><a id="PRODUCT_ENTERPRISE_S_N"></a><a
///                             id="product_enterprise_s_n"></a><dl> <dt><b>PRODUCT_ENTERPRISE_S_N</b></dt> <dt>0x0000007E</dt> </dl> </td> <td
///                             width="60%"> Windows 10 Enterprise 2015 LTSB N </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_ENTERPRISE_S_N_EVALUATION"></a><a id="product_enterprise_s_n_evaluation"></a><dl>
///                             <dt><b>PRODUCT_ENTERPRISE_S_N_EVALUATION</b></dt> <dt>0x00000082</dt> </dl> </td> <td width="60%"> Windows 10
///                             Enterprise 2015 LTSB N Evaluation </td> </tr> <tr> <td width="40%"><a id="PRODUCT_ENTERPRISE_SERVER"></a><a
///                             id="product_enterprise_server"></a><dl> <dt><b>PRODUCT_ENTERPRISE_SERVER</b></dt> <dt>0x0000000A</dt> </dl> </td>
///                             <td width="60%"> Server Enterprise (full installation) </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_ENTERPRISE_SERVER_CORE"></a><a id="product_enterprise_server_core"></a><dl>
///                             <dt><b>PRODUCT_ENTERPRISE_SERVER_CORE</b></dt> <dt>0x0000000E</dt> </dl> </td> <td width="60%"> Server Enterprise
///                             (core installation) </td> </tr> <tr> <td width="40%"><a id="PRODUCT_ENTERPRISE_SERVER_CORE_V"></a><a
///                             id="product_enterprise_server_core_v"></a><dl> <dt><b>PRODUCT_ENTERPRISE_SERVER_CORE_V</b></dt>
///                             <dt>0x00000029</dt> </dl> </td> <td width="60%"> Server Enterprise without Hyper-V (core installation) </td>
///                             </tr> <tr> <td width="40%"><a id="PRODUCT_ENTERPRISE_SERVER_IA64"></a><a
///                             id="product_enterprise_server_ia64"></a><dl> <dt><b>PRODUCT_ENTERPRISE_SERVER_IA64</b></dt> <dt>0x0000000F</dt>
///                             </dl> </td> <td width="60%"> Server Enterprise for Itanium-based Systems </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_ENTERPRISE_SERVER_V"></a><a id="product_enterprise_server_v"></a><dl>
///                             <dt><b>PRODUCT_ENTERPRISE_SERVER_V</b></dt> <dt>0x00000026</dt> </dl> </td> <td width="60%"> Server Enterprise
///                             without Hyper-V (full installation) </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_ESSENTIALBUSINESS_SERVER_ADDL"></a><a id="product_essentialbusiness_server_addl"></a><dl>
///                             <dt><b>PRODUCT_ESSENTIALBUSINESS_SERVER_ADDL</b></dt> <dt>0x0000003C</dt> </dl> </td> <td width="60%"> Windows
///                             Essential Server Solution Additional </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_ESSENTIALBUSINESS_SERVER_ADDLSVC"></a><a id="product_essentialbusiness_server_addlsvc"></a><dl>
///                             <dt><b>PRODUCT_ESSENTIALBUSINESS_SERVER_ADDLSVC</b></dt> <dt>0x0000003E</dt> </dl> </td> <td width="60%"> Windows
///                             Essential Server Solution Additional SVC </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_ESSENTIALBUSINESS_SERVER_MGMT"></a><a id="product_essentialbusiness_server_mgmt"></a><dl>
///                             <dt><b>PRODUCT_ESSENTIALBUSINESS_SERVER_MGMT</b></dt> <dt>0x0000003B</dt> </dl> </td> <td width="60%"> Windows
///                             Essential Server Solution Management </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_ESSENTIALBUSINESS_SERVER_MGMTSVC"></a><a id="product_essentialbusiness_server_mgmtsvc"></a><dl>
///                             <dt><b>PRODUCT_ESSENTIALBUSINESS_SERVER_MGMTSVC</b></dt> <dt>0x0000003D</dt> </dl> </td> <td width="60%"> Windows
///                             Essential Server Solution Management SVC </td> </tr> <tr> <td width="40%"><a id="PRODUCT_HOME_BASIC"></a><a
///                             id="product_home_basic"></a><dl> <dt><b>PRODUCT_HOME_BASIC</b></dt> <dt>0x00000002</dt> </dl> </td> <td
///                             width="60%"> Home Basic </td> </tr> <tr> <td width="40%"><a id="PRODUCT_HOME_BASIC_E"></a><a
///                             id="product_home_basic_e"></a><dl> <dt><b>PRODUCT_HOME_BASIC_E</b></dt> <dt>0x00000043</dt> </dl> </td> <td
///                             width="60%"> Not supported </td> </tr> <tr> <td width="40%"><a id="PRODUCT_HOME_BASIC_N"></a><a
///                             id="product_home_basic_n"></a><dl> <dt><b>PRODUCT_HOME_BASIC_N</b></dt> <dt>0x00000005</dt> </dl> </td> <td
///                             width="60%"> Home Basic N </td> </tr> <tr> <td width="40%"><a id="PRODUCT_HOME_PREMIUM"></a><a
///                             id="product_home_premium"></a><dl> <dt><b>PRODUCT_HOME_PREMIUM</b></dt> <dt>0x00000003</dt> </dl> </td> <td
///                             width="60%"> Home Premium </td> </tr> <tr> <td width="40%"><a id="PRODUCT_HOME_PREMIUM_E"></a><a
///                             id="product_home_premium_e"></a><dl> <dt><b>PRODUCT_HOME_PREMIUM_E</b></dt> <dt>0x00000044</dt> </dl> </td> <td
///                             width="60%"> Not supported </td> </tr> <tr> <td width="40%"><a id="PRODUCT_HOME_PREMIUM_N"></a><a
///                             id="product_home_premium_n"></a><dl> <dt><b>PRODUCT_HOME_PREMIUM_N</b></dt> <dt>0x0000001A</dt> </dl> </td> <td
///                             width="60%"> Home Premium N </td> </tr> <tr> <td width="40%"><a id="PRODUCT_HOME_PREMIUM_SERVER"></a><a
///                             id="product_home_premium_server"></a><dl> <dt><b>PRODUCT_HOME_PREMIUM_SERVER</b></dt> <dt>0x00000022</dt> </dl>
///                             </td> <td width="60%"> Windows Home Server 2011 </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_HOME_SERVER"></a><a id="product_home_server"></a><dl> <dt><b>PRODUCT_HOME_SERVER</b></dt>
///                             <dt>0x00000013</dt> </dl> </td> <td width="60%"> Windows Storage Server 2008 R2 Essentials </td> </tr> <tr> <td
///                             width="40%"><a id="PRODUCT_HYPERV"></a><a id="product_hyperv"></a><dl> <dt><b>PRODUCT_HYPERV</b></dt>
///                             <dt>0x0000002A</dt> </dl> </td> <td width="60%"> Microsoft Hyper-V Server </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_IOTUAP"></a><a id="product_iotuap"></a><dl> <dt><b>PRODUCT_IOTUAP</b></dt> <dt>0x0000007B</dt> </dl>
///                             </td> <td width="60%"> Windows 10 IoT Core </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_IOTUAPCOMMERCIAL"></a><a id="product_iotuapcommercial"></a><dl>
///                             <dt><b>PRODUCT_IOTUAPCOMMERCIAL</b></dt> <dt>0x00000083</dt> </dl> </td> <td width="60%"> Windows 10 IoT Core
///                             Commercial </td> </tr> <tr> <td width="40%"><a id="PRODUCT_MEDIUMBUSINESS_SERVER_MANAGEMENT"></a><a
///                             id="product_mediumbusiness_server_management"></a><dl> <dt><b>PRODUCT_MEDIUMBUSINESS_SERVER_MANAGEMENT</b></dt>
///                             <dt>0x0000001E</dt> </dl> </td> <td width="60%"> Windows Essential Business Server Management Server </td> </tr>
///                             <tr> <td width="40%"><a id="PRODUCT_MEDIUMBUSINESS_SERVER_MESSAGING"></a><a
///                             id="product_mediumbusiness_server_messaging"></a><dl> <dt><b>PRODUCT_MEDIUMBUSINESS_SERVER_MESSAGING</b></dt>
///                             <dt>0x00000020</dt> </dl> </td> <td width="60%"> Windows Essential Business Server Messaging Server </td> </tr>
///                             <tr> <td width="40%"><a id="PRODUCT_MEDIUMBUSINESS_SERVER_SECURITY"></a><a
///                             id="product_mediumbusiness_server_security"></a><dl> <dt><b>PRODUCT_MEDIUMBUSINESS_SERVER_SECURITY</b></dt>
///                             <dt>0x0000001F</dt> </dl> </td> <td width="60%"> Windows Essential Business Server Security Server </td> </tr>
///                             <tr> <td width="40%"><a id="PRODUCT_MOBILE_CORE"></a><a id="product_mobile_core"></a><dl>
///                             <dt><b>PRODUCT_MOBILE_CORE</b></dt> <dt>0x00000068</dt> </dl> </td> <td width="60%"> Windows 10 Mobile </td>
///                             </tr> <tr> <td width="40%"><a id="PRODUCT_MOBILE_ENTERPRISE"></a><a id="product_mobile_enterprise"></a><dl>
///                             <dt><b>PRODUCT_MOBILE_ENTERPRISE</b></dt> <dt>0x00000085</dt> </dl> </td> <td width="60%"> Windows 10 Mobile
///                             Enterprise </td> </tr> <tr> <td width="40%"><a id="PRODUCT_MULTIPOINT_PREMIUM_SERVER"></a><a
///                             id="product_multipoint_premium_server"></a><dl> <dt><b>PRODUCT_MULTIPOINT_PREMIUM_SERVER</b></dt>
///                             <dt>0x0000004D</dt> </dl> </td> <td width="60%"> Windows MultiPoint Server Premium (full installation) </td>
///                             </tr> <tr> <td width="40%"><a id="PRODUCT_MULTIPOINT_STANDARD_SERVER"></a><a
///                             id="product_multipoint_standard_server"></a><dl> <dt><b>PRODUCT_MULTIPOINT_STANDARD_SERVER</b></dt>
///                             <dt>0x0000004C</dt> </dl> </td> <td width="60%"> Windows MultiPoint Server Standard (full installation) </td>
///                             </tr> <tr> <td width="40%"><a id="PRODUCT_PRO_WORKSTATION"></a><a id="product_pro_workstation"></a><dl>
///                             <dt><b>PRODUCT_PRO_WORKSTATION</b></dt> <dt>0x000000A1</dt> </dl> </td> <td width="60%"> Windows 10 Pro for
///                             Workstations </td> </tr> <tr> <td width="40%"><a id="PRODUCT_PRO_WORKSTATION_N"></a><a
///                             id="product_pro_workstation_n"></a><dl> <dt><b>PRODUCT_PRO_WORKSTATION_N</b></dt> <dt>0x000000A2</dt> </dl> </td>
///                             <td width="60%"> Windows 10 Pro for Workstations N </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_PROFESSIONAL"></a><a id="product_professional"></a><dl> <dt><b>PRODUCT_PROFESSIONAL</b></dt>
///                             <dt>0x00000030</dt> </dl> </td> <td width="60%"> Windows 10 Pro </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_PROFESSIONAL_E"></a><a id="product_professional_e"></a><dl> <dt><b>PRODUCT_PROFESSIONAL_E</b></dt>
///                             <dt>0x00000045</dt> </dl> </td> <td width="60%"> Not supported </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_PROFESSIONAL_N"></a><a id="product_professional_n"></a><dl> <dt><b>PRODUCT_PROFESSIONAL_N</b></dt>
///                             <dt>0x00000031</dt> </dl> </td> <td width="60%"> Windows 10 Pro N </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_PROFESSIONAL_WMC"></a><a id="product_professional_wmc"></a><dl>
///                             <dt><b>PRODUCT_PROFESSIONAL_WMC</b></dt> <dt>0x00000067</dt> </dl> </td> <td width="60%"> Professional with Media
///                             Center </td> </tr> <tr> <td width="40%"><a id="PRODUCT_SB_SOLUTION_SERVER"></a><a
///                             id="product_sb_solution_server"></a><dl> <dt><b>PRODUCT_SB_SOLUTION_SERVER</b></dt> <dt>0x00000032</dt> </dl>
///                             </td> <td width="60%"> Windows Small Business Server 2011 Essentials </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_SB_SOLUTION_SERVER_EM"></a><a id="product_sb_solution_server_em"></a><dl>
///                             <dt><b>PRODUCT_SB_SOLUTION_SERVER_EM</b></dt> <dt>0x00000036</dt> </dl> </td> <td width="60%"> Server For SB
///                             Solutions EM </td> </tr> <tr> <td width="40%"><a id="PRODUCT_SERVER_FOR_SB_SOLUTIONS"></a><a
///                             id="product_server_for_sb_solutions"></a><dl> <dt><b>PRODUCT_SERVER_FOR_SB_SOLUTIONS</b></dt> <dt>0x00000033</dt>
///                             </dl> </td> <td width="60%"> Server For SB Solutions </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_SERVER_FOR_SB_SOLUTIONS_EM"></a><a id="product_server_for_sb_solutions_em"></a><dl>
///                             <dt><b>PRODUCT_SERVER_FOR_SB_SOLUTIONS_EM</b></dt> <dt>0x00000037</dt> </dl> </td> <td width="60%"> Server For SB
///                             Solutions EM </td> </tr> <tr> <td width="40%"><a id="PRODUCT_SERVER_FOR_SMALLBUSINESS"></a><a
///                             id="product_server_for_smallbusiness"></a><dl> <dt><b>PRODUCT_SERVER_FOR_SMALLBUSINESS</b></dt>
///                             <dt>0x00000018</dt> </dl> </td> <td width="60%"> Windows Server 2008 for Windows Essential Server Solutions </td>
///                             </tr> <tr> <td width="40%"><a id="PRODUCT_SERVER_FOR_SMALLBUSINESS_V"></a><a
///                             id="product_server_for_smallbusiness_v"></a><dl> <dt><b>PRODUCT_SERVER_FOR_SMALLBUSINESS_V</b></dt>
///                             <dt>0x00000023</dt> </dl> </td> <td width="60%"> Windows Server 2008 without Hyper-V for Windows Essential Server
///                             Solutions </td> </tr> <tr> <td width="40%"><a id="PRODUCT_SERVER_FOUNDATION"></a><a
///                             id="product_server_foundation"></a><dl> <dt><b>PRODUCT_SERVER_FOUNDATION</b></dt> <dt>0x00000021</dt> </dl> </td>
///                             <td width="60%"> Server Foundation </td> </tr> <tr> <td width="40%"><a id="PRODUCT_SMALLBUSINESS_SERVER"></a><a
///                             id="product_smallbusiness_server"></a><dl> <dt><b>PRODUCT_SMALLBUSINESS_SERVER</b></dt> <dt>0x00000009</dt> </dl>
///                             </td> <td width="60%"> Windows Small Business Server </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_SMALLBUSINESS_SERVER_PREMIUM"></a><a id="product_smallbusiness_server_premium"></a><dl>
///                             <dt><b>PRODUCT_SMALLBUSINESS_SERVER_PREMIUM</b></dt> <dt>0x00000019</dt> </dl> </td> <td width="60%"> Small
///                             Business Server Premium </td> </tr> <tr> <td width="40%"><a id="PRODUCT_SMALLBUSINESS_SERVER_PREMIUM_CORE"></a><a
///                             id="product_smallbusiness_server_premium_core"></a><dl> <dt><b>PRODUCT_SMALLBUSINESS_SERVER_PREMIUM_CORE</b></dt>
///                             <dt>0x0000003F</dt> </dl> </td> <td width="60%"> Small Business Server Premium (core installation) </td> </tr>
///                             <tr> <td width="40%"><a id="PRODUCT_SOLUTION_EMBEDDEDSERVER"></a><a id="product_solution_embeddedserver"></a><dl>
///                             <dt><b>PRODUCT_SOLUTION_EMBEDDEDSERVER</b></dt> <dt>0x00000038</dt> </dl> </td> <td width="60%"> Windows
///                             MultiPoint Server </td> </tr> <tr> <td width="40%"><a id="PRODUCT_STANDARD_EVALUATION_SERVER"></a><a
///                             id="product_standard_evaluation_server"></a><dl> <dt><b>PRODUCT_STANDARD_EVALUATION_SERVER</b></dt>
///                             <dt>0x0000004F</dt> </dl> </td> <td width="60%"> Server Standard (evaluation installation) </td> </tr> <tr> <td
///                             width="40%"><a id="PRODUCT_STANDARD_SERVER"></a><a id="product_standard_server"></a><dl>
///                             <dt><b>PRODUCT_STANDARD_SERVER</b></dt> <dt>0x00000007</dt> </dl> </td> <td width="60%"> Server Standard (full
///                             installation. For Server Core installations of Windows Server 2012 and later, use the method, Determining whether
///                             Server Core is running.) </td> </tr> <tr> <td width="40%"><a id="PRODUCT_STANDARD_SERVER_CORE_"></a><a
///                             id="product_standard_server_core_"></a><dl> <dt><b>PRODUCT_STANDARD_SERVER_CORE </b></dt> <dt>0x0000000D</dt>
///                             </dl> </td> <td width="60%"> Server Standard (core installation, Windows Server 2008 R2 and earlier) </td> </tr>
///                             <tr> <td width="40%"><a id="PRODUCT_STANDARD_SERVER_CORE_V"></a><a id="product_standard_server_core_v"></a><dl>
///                             <dt><b>PRODUCT_STANDARD_SERVER_CORE_V</b></dt> <dt>0x00000028</dt> </dl> </td> <td width="60%"> Server Standard
///                             without Hyper-V (core installation) </td> </tr> <tr> <td width="40%"><a id="PRODUCT_STANDARD_SERVER_V"></a><a
///                             id="product_standard_server_v"></a><dl> <dt><b>PRODUCT_STANDARD_SERVER_V</b></dt> <dt>0x00000024</dt> </dl> </td>
///                             <td width="60%"> Server Standard without Hyper-V </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_STANDARD_SERVER_SOLUTIONS"></a><a id="product_standard_server_solutions"></a><dl>
///                             <dt><b>PRODUCT_STANDARD_SERVER_SOLUTIONS</b></dt> <dt>0x00000034</dt> </dl> </td> <td width="60%"> Server
///                             Solutions Premium </td> </tr> <tr> <td width="40%"><a id="PRODUCT_STANDARD_SERVER_SOLUTIONS_CORE"></a><a
///                             id="product_standard_server_solutions_core"></a><dl> <dt><b>PRODUCT_STANDARD_SERVER_SOLUTIONS_CORE</b></dt>
///                             <dt>0x00000035</dt> </dl> </td> <td width="60%"> Server Solutions Premium (core installation) </td> </tr> <tr>
///                             <td width="40%"><a id="PRODUCT_STARTER"></a><a id="product_starter"></a><dl> <dt><b>PRODUCT_STARTER</b></dt>
///                             <dt>0x0000000B</dt> </dl> </td> <td width="60%"> Starter </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_STARTER_E"></a><a id="product_starter_e"></a><dl> <dt><b>PRODUCT_STARTER_E</b></dt>
///                             <dt>0x00000042</dt> </dl> </td> <td width="60%"> Not supported </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_STARTER_N"></a><a id="product_starter_n"></a><dl> <dt><b>PRODUCT_STARTER_N</b></dt>
///                             <dt>0x0000002F</dt> </dl> </td> <td width="60%"> Starter N </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_STORAGE_ENTERPRISE_SERVER"></a><a id="product_storage_enterprise_server"></a><dl>
///                             <dt><b>PRODUCT_STORAGE_ENTERPRISE_SERVER</b></dt> <dt>0x00000017</dt> </dl> </td> <td width="60%"> Storage Server
///                             Enterprise </td> </tr> <tr> <td width="40%"><a id="PRODUCT_STORAGE_ENTERPRISE_SERVER_CORE"></a><a
///                             id="product_storage_enterprise_server_core"></a><dl> <dt><b>PRODUCT_STORAGE_ENTERPRISE_SERVER_CORE</b></dt>
///                             <dt>0x0000002E</dt> </dl> </td> <td width="60%"> Storage Server Enterprise (core installation) </td> </tr> <tr>
///                             <td width="40%"><a id="PRODUCT_STORAGE_EXPRESS_SERVER"></a><a id="product_storage_express_server"></a><dl>
///                             <dt><b>PRODUCT_STORAGE_EXPRESS_SERVER</b></dt> <dt>0x00000014</dt> </dl> </td> <td width="60%"> Storage Server
///                             Express </td> </tr> <tr> <td width="40%"><a id="PRODUCT_STORAGE_EXPRESS_SERVER_CORE"></a><a
///                             id="product_storage_express_server_core"></a><dl> <dt><b>PRODUCT_STORAGE_EXPRESS_SERVER_CORE</b></dt>
///                             <dt>0x0000002B</dt> </dl> </td> <td width="60%"> Storage Server Express (core installation) </td> </tr> <tr> <td
///                             width="40%"><a id="PRODUCT_STORAGE_STANDARD_EVALUATION_SERVER"></a><a
///                             id="product_storage_standard_evaluation_server"></a><dl>
///                             <dt><b>PRODUCT_STORAGE_STANDARD_EVALUATION_SERVER</b></dt> <dt>0x00000060</dt> </dl> </td> <td width="60%">
///                             Storage Server Standard (evaluation installation) </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_STORAGE_STANDARD_SERVER"></a><a id="product_storage_standard_server"></a><dl>
///                             <dt><b>PRODUCT_STORAGE_STANDARD_SERVER</b></dt> <dt>0x00000015</dt> </dl> </td> <td width="60%"> Storage Server
///                             Standard </td> </tr> <tr> <td width="40%"><a id="PRODUCT_STORAGE_STANDARD_SERVER_CORE"></a><a
///                             id="product_storage_standard_server_core"></a><dl> <dt><b>PRODUCT_STORAGE_STANDARD_SERVER_CORE</b></dt>
///                             <dt>0x0000002C</dt> </dl> </td> <td width="60%"> Storage Server Standard (core installation) </td> </tr> <tr> <td
///                             width="40%"><a id="PRODUCT_STORAGE_WORKGROUP_EVALUATION_SERVER"></a><a
///                             id="product_storage_workgroup_evaluation_server"></a><dl>
///                             <dt><b>PRODUCT_STORAGE_WORKGROUP_EVALUATION_SERVER</b></dt> <dt>0x0000005F</dt> </dl> </td> <td width="60%">
///                             Storage Server Workgroup (evaluation installation) </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_STORAGE_WORKGROUP_SERVER"></a><a id="product_storage_workgroup_server"></a><dl>
///                             <dt><b>PRODUCT_STORAGE_WORKGROUP_SERVER</b></dt> <dt>0x00000016</dt> </dl> </td> <td width="60%"> Storage Server
///                             Workgroup </td> </tr> <tr> <td width="40%"><a id="PRODUCT_STORAGE_WORKGROUP_SERVER_CORE"></a><a
///                             id="product_storage_workgroup_server_core"></a><dl> <dt><b>PRODUCT_STORAGE_WORKGROUP_SERVER_CORE</b></dt>
///                             <dt>0x0000002D</dt> </dl> </td> <td width="60%"> Storage Server Workgroup (core installation) </td> </tr> <tr>
///                             <td width="40%"><a id="PRODUCT_ULTIMATE"></a><a id="product_ultimate"></a><dl> <dt><b>PRODUCT_ULTIMATE</b></dt>
///                             <dt>0x00000001</dt> </dl> </td> <td width="60%"> Ultimate </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_ULTIMATE_E"></a><a id="product_ultimate_e"></a><dl> <dt><b>PRODUCT_ULTIMATE_E</b></dt>
///                             <dt>0x00000047</dt> </dl> </td> <td width="60%"> Not supported </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_ULTIMATE_N"></a><a id="product_ultimate_n"></a><dl> <dt><b>PRODUCT_ULTIMATE_N</b></dt>
///                             <dt>0x0000001C</dt> </dl> </td> <td width="60%"> Ultimate N </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_UNDEFINED"></a><a id="product_undefined"></a><dl> <dt><b>PRODUCT_UNDEFINED</b></dt>
///                             <dt>0x00000000</dt> </dl> </td> <td width="60%"> An unknown product </td> </tr> <tr> <td width="40%"><a
///                             id="PRODUCT_WEB_SERVER"></a><a id="product_web_server"></a><dl> <dt><b>PRODUCT_WEB_SERVER</b></dt>
///                             <dt>0x00000011</dt> </dl> </td> <td width="60%"> Web Server (full installation) </td> </tr> <tr> <td
///                             width="40%"><a id="PRODUCT_WEB_SERVER_CORE"></a><a id="product_web_server_core"></a><dl>
///                             <dt><b>PRODUCT_WEB_SERVER_CORE</b></dt> <dt>0x0000001D</dt> </dl> </td> <td width="60%"> Web Server (core
///                             installation) </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    This function fails if one of the input parameters is invalid.
///    
@DllImport("KERNEL32")
BOOL GetProductInfo(uint dwOSMajorVersion, uint dwOSMinorVersion, uint dwSpMajorVersion, uint dwSpMinorVersion, 
                    uint* pdwReturnedProductType);

///Sets the bits of a 64-bit value to indicate the comparison operator to use for a specified operating system version
///attribute. This function is used to build the <i>dwlConditionMask</i> parameter of the VerifyVersionInfo function.
///Params:
///    ConditionMask = A value to be passed as the <i>dwlConditionMask</i> parameter of the VerifyVersionInfo function. The function
///                    stores the comparison information in the bits of this variable. Before the first call to <b>VerSetCondition</b>,
///                    initialize this variable to zero. For subsequent calls, pass in the variable used in the previous call.
///    TypeMask = A mask that indicates the member of the OSVERSIONINFOEX structure whose comparison operator is being set. This
///               value corresponds to one of the bits specified in the <i>dwTypeMask</i> parameter for the VerifyVersionInfo
///               function. This parameter can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///               <tr> <td width="40%"><a id="VER_BUILDNUMBER"></a><a id="ver_buildnumber"></a><dl> <dt><b>VER_BUILDNUMBER</b></dt>
///               <dt>0x0000004</dt> </dl> </td> <td width="60%"> dwBuildNumber </td> </tr> <tr> <td width="40%"><a
///               id="VER_MAJORVERSION"></a><a id="ver_majorversion"></a><dl> <dt><b>VER_MAJORVERSION</b></dt> <dt>0x0000002</dt>
///               </dl> </td> <td width="60%"> dwMajorVersion </td> </tr> <tr> <td width="40%"><a id="VER_MINORVERSION"></a><a
///               id="ver_minorversion"></a><dl> <dt><b>VER_MINORVERSION</b></dt> <dt>0x0000001</dt> </dl> </td> <td width="60%">
///               dwMinorVersion </td> </tr> <tr> <td width="40%"><a id="VER_PLATFORMID"></a><a id="ver_platformid"></a><dl>
///               <dt><b>VER_PLATFORMID</b></dt> <dt>0x0000008</dt> </dl> </td> <td width="60%"> dwPlatformId </td> </tr> <tr> <td
///               width="40%"><a id="VER_PRODUCT_TYPE"></a><a id="ver_product_type"></a><dl> <dt><b>VER_PRODUCT_TYPE</b></dt>
///               <dt>0x0000080</dt> </dl> </td> <td width="60%"> wProductType </td> </tr> <tr> <td width="40%"><a
///               id="VER_SERVICEPACKMAJOR"></a><a id="ver_servicepackmajor"></a><dl> <dt><b>VER_SERVICEPACKMAJOR</b></dt>
///               <dt>0x0000020</dt> </dl> </td> <td width="60%"> wServicePackMajor </td> </tr> <tr> <td width="40%"><a
///               id="VER_SERVICEPACKMINOR"></a><a id="ver_servicepackminor"></a><dl> <dt><b>VER_SERVICEPACKMINOR</b></dt>
///               <dt>0x0000010</dt> </dl> </td> <td width="60%"> wServicePackMinor </td> </tr> <tr> <td width="40%"><a
///               id="VER_SUITENAME"></a><a id="ver_suitename"></a><dl> <dt><b>VER_SUITENAME</b></dt> <dt>0x0000040</dt> </dl>
///               </td> <td width="60%"> wSuiteMask </td> </tr> </table>
///    Condition = The operator to be used for the comparison. The VerifyVersionInfo function uses this operator to compare a
///                specified attribute value to the corresponding value for the currently running system. For all values of
///                <i>dwTypeBitMask</i> other than VER_SUITENAME, this parameter can be one of the following values. <table> <tr>
///                <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="VER_EQUAL"></a><a id="ver_equal"></a><dl>
///                <dt><b>VER_EQUAL</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The current value must be equal to the
///                specified value. </td> </tr> <tr> <td width="40%"><a id="VER_GREATER"></a><a id="ver_greater"></a><dl>
///                <dt><b>VER_GREATER</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The current value must be greater than the
///                specified value. </td> </tr> <tr> <td width="40%"><a id="VER_GREATER_EQUAL"></a><a
///                id="ver_greater_equal"></a><dl> <dt><b>VER_GREATER_EQUAL</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> The
///                current value must be greater than or equal to the specified value. </td> </tr> <tr> <td width="40%"><a
///                id="VER_LESS"></a><a id="ver_less"></a><dl> <dt><b>VER_LESS</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> The
///                current value must be less than the specified value. </td> </tr> <tr> <td width="40%"><a
///                id="VER_LESS_EQUAL"></a><a id="ver_less_equal"></a><dl> <dt><b>VER_LESS_EQUAL</b></dt> <dt>5</dt> </dl> </td> <td
///                width="60%"> The current value must be less than or equal to the specified value. </td> </tr> </table> If
///                <i>dwTypeBitMask</i> is VER_SUITENAME, this parameter can be one of the following values. <table> <tr>
///                <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="VER_AND"></a><a id="ver_and"></a><dl>
///                <dt><b>VER_AND</b></dt> <dt>6</dt> </dl> </td> <td width="60%"> All product suites specified in the
///                <b>wSuiteMask</b> member must be present in the current system. </td> </tr> <tr> <td width="40%"><a
///                id="VER_OR"></a><a id="ver_or"></a><dl> <dt><b>VER_OR</b></dt> <dt>7</dt> </dl> </td> <td width="60%"> At least
///                one of the specified product suites must be present in the current system. </td> </tr> </table>
///Returns:
///    The function returns the condition mask value.
///    
@DllImport("KERNEL32")
ulong VerSetConditionMask(ulong ConditionMask, uint TypeMask, ubyte Condition);

@DllImport("api-ms-win-core-sysinfo-l1-2-0")
BOOL GetOsSafeBootMode(uint* Flags);

///Enumerates all system firmware tables of the specified type.
///Params:
///    FirmwareTableProviderSignature = The identifier of the firmware table provider to which the query is to be directed. This parameter can be one of
///                                     the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>'ACPI'</td> <td>The ACPI
///                                     firmware table provider.</td> </tr> <tr> <td>'FIRM'</td> <td>The raw firmware table provider. Not supported for
///                                     UEFI systems; use 'RSMB' instead.</td> </tr> <tr> <td>'RSMB'</td> <td>The raw SMBIOS firmware table
///                                     provider.</td> </tr> </table>
///    pFirmwareTableEnumBuffer = A pointer to a buffer that receives the list of firmware tables. If this parameter is <b>NULL</b>, the return
///                               value is the required buffer size. For more information on the contents of this buffer, see the Remarks section.
///    BufferSize = The size of the <i>pFirmwareTableBuffer</i> buffer, in bytes.
///Returns:
///    If the function succeeds, the return value is the number of bytes written to the buffer. This value will always
///    be less than or equal to <i>BufferSize</i>. If the function fails because the buffer is not large enough, the
///    return value is the required buffer size, in bytes. This value is always greater than <i>BufferSize</i>. If the
///    function fails for any other reason, the return value is zero. To get extended error information, call
///    GetLastError.
///    
@DllImport("KERNEL32")
uint EnumSystemFirmwareTables(uint FirmwareTableProviderSignature, char* pFirmwareTableEnumBuffer, uint BufferSize);

///Retrieves the specified firmware table from the firmware table provider.
///Params:
///    FirmwareTableProviderSignature = The identifier of the firmware table provider to which the query is to be directed. This parameter can be one of
///                                     the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>'ACPI'</td> <td>The ACPI
///                                     firmware table provider.</td> </tr> <tr> <td>'FIRM'</td> <td>The raw firmware table provider.</td> </tr> <tr>
///                                     <td>'RSMB'</td> <td>The raw SMBIOS firmware table provider.</td> </tr> </table>
///    FirmwareTableID = The identifier of the firmware table. This identifier is little endian, you must reverse the characters in the
///                      string. For example, FACP is an ACPI provider, as described in the Signature field of the DESCRIPTION_HEADER
///                      structure in the ACPI specification (see http://www.acpi.info). Therefore, use 'PCAF' to specify the FACP table,
///                      as shown in the following example: <code>retVal = GetSystemFirmwareTable('ACPI', 'PCAF', pBuffer,
///                      BUFSIZE);</code> For more information, see the Remarks section of the EnumSystemFirmwareTables function.
///    pFirmwareTableBuffer = A pointer to a buffer that receives the requested firmware table. If this parameter is <b>NULL</b>, the return
///                           value is the required buffer size. For more information on the contents of this buffer, see the Remarks section.
///    BufferSize = The size of the <i>pFirmwareTableBuffer</i> buffer, in bytes.
///Returns:
///    If the function succeeds, the return value is the number of bytes written to the buffer. This value will always
///    be less than or equal to <i>BufferSize</i>. If the function fails because the buffer is not large enough, the
///    return value is the required buffer size, in bytes. This value is always greater than <i>BufferSize</i>. If the
///    function fails for any other reason, the return value is zero. To get extended error information, call
///    GetLastError.
///    
@DllImport("KERNEL32")
uint GetSystemFirmwareTable(uint FirmwareTableProviderSignature, uint FirmwareTableID, char* pFirmwareTableBuffer, 
                            uint BufferSize);

@DllImport("KERNEL32")
BOOL DnsHostnameToComputerNameExW(const(wchar)* Hostname, const(wchar)* ComputerName, uint* nSize);

@DllImport("KERNEL32")
BOOL SetComputerNameEx2W(COMPUTER_NAME_FORMAT NameType, uint Flags, const(wchar)* lpBuffer);

///Enables or disables periodic time adjustments to the system's time-of-day clock. When enabled, such time adjustments
///can be used to synchronize the time of day with some other source of time information.
///Params:
///    dwTimeAdjustment = This value represents the number of 100-nanosecond units added to the system time-of-day for each
///                       <i>lpTimeIncrement</i> period of time that actually passes. Call GetSystemTimeAdjustment to obtain the
///                       <i>lpTimeIncrement</i> value. See remarks. <div class="alert"><b>Note</b> <p class="note">Currently, Windows
///                       Vista and Windows 7 machines will lose any time adjustments set less than 16. </div> <div> </div>
///    bTimeAdjustmentDisabled = The time adjustment mode that the system is to use. Periodic system time adjustments can be disabled or enabled.
///                              A value of <b>TRUE</b> specifies that periodic time adjustment is to be disabled. When disabled, the value of
///                              <i>dwTimeAdjustment</i> is ignored, and the system may adjust the time of day using its own internal time
///                              synchronization mechanisms. These internal time synchronization mechanisms may cause the time-of-day clock to
///                              change during the normal course of the system operation, which can include noticeable jumps in time as deemed
///                              necessary by the system. A value of <b>FALSE</b> specifies that periodic time adjustment is to be enabled, and
///                              will be used to adjust the time-of-day clock. The system will not interfere with the time adjustment scheme, and
///                              will not attempt to synchronize time of day on its own.
///Returns:
///    If the function succeeds, the return value is non-zero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError. One way the function can fail is if the caller does not possess
///    the SE_SYSTEMTIME_NAME privilege.
///    
@DllImport("KERNEL32")
BOOL SetSystemTimeAdjustment(uint dwTimeAdjustment, BOOL bTimeAdjustmentDisabled);

///Enables or disables periodic time adjustments to the system's time-of-day clock. When enabled, such time adjustments
///can be used to synchronize the time of day with some other source of time information.
///Params:
///    dwTimeAdjustment = Supplies the adjusted clock update frequency.
///    bTimeAdjustmentDisabled = Supplies a flag which specifies the time adjustment mode that the system is to use. A value of <b>TRUE</b>
///                              indicates that the system should synchronize time-of-day using its own internal mechanisms. In this case, the
///                              value of <i>dwTimeAdjustment</i> is ignored. A value of <b>FALSE</b> indicates that the application is in
///                              control, and that the specified value of <i>dwTimeAdjustment</i> is to be added to the time-of-day clock at each
///                              clock update interrupt.
///Returns:
///    If the function succeeds, the return value is non-zero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError. One way the function can fail is if the caller does not possess
///    the SE_SYSTEMTIME_NAME privilege.
///    
@DllImport("api-ms-win-core-sysinfo-l1-2-4")
BOOL SetSystemTimeAdjustmentPrecise(ulong dwTimeAdjustment, BOOL bTimeAdjustmentDisabled);

@DllImport("api-ms-win-core-sysinfo-l1-2-3")
BOOL GetOsManufacturingMode(int* pbEnabled);

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] Retrieves the best estimate of the diagonal size of the built-in screen, in inches.
///Params:
///    sizeInInches = The best estimate of the diagonal size of the built-in screen, in inches.
///Returns:
///    The result code indicating if the function succeeded or failed.
///    
@DllImport("api-ms-win-core-sysinfo-l1-2-3")
HRESULT GetIntegratedDisplaySize(double* sizeInInches);

///Sets a new NetBIOS name for the local computer. The name is stored in the registry and the name change takes effect
///the next time the user restarts the computer. If the local computer is a node in a cluster, <b>SetComputerName</b>
///sets NetBIOS name of the local computer, not that of the cluster virtual server. To set the DNS host name or the DNS
///domain name, call the SetComputerNameEx function.
///Params:
///    lpComputerName = The computer name that will take effect the next time the computer is started. The name must not be longer than
///                     MAX_COMPUTERNAME_LENGTH characters. The standard character set includes letters, numbers, and the following
///                     symbols: ! @
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL SetComputerNameA(const(char)* lpComputerName);

///Sets a new NetBIOS name for the local computer. The name is stored in the registry and the name change takes effect
///the next time the user restarts the computer. If the local computer is a node in a cluster, <b>SetComputerName</b>
///sets NetBIOS name of the local computer, not that of the cluster virtual server. To set the DNS host name or the DNS
///domain name, call the SetComputerNameEx function.
///Params:
///    lpComputerName = The computer name that will take effect the next time the computer is started. The name must not be longer than
///                     MAX_COMPUTERNAME_LENGTH characters. The standard character set includes letters, numbers, and the following
///                     symbols: ! @
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL SetComputerNameW(const(wchar)* lpComputerName);

///Sets a new NetBIOS or DNS name for the local computer. Name changes made by <b>SetComputerNameEx</b> do not take
///effect until the user restarts the computer.
///Params:
///    NameType = The type of name to be set. This parameter can be one of the following values from the COMPUTER_NAME_FORMAT
///               enumeration type. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///               id="ComputerNamePhysicalDnsDomain"></a><a id="computernamephysicaldnsdomain"></a><a
///               id="COMPUTERNAMEPHYSICALDNSDOMAIN"></a><dl> <dt><b>ComputerNamePhysicalDnsDomain</b></dt> </dl> </td> <td
///               width="60%"> Sets the primary DNS suffix of the computer. </td> </tr> <tr> <td width="40%"><a
///               id="ComputerNamePhysicalDnsHostname"></a><a id="computernamephysicaldnshostname"></a><a
///               id="COMPUTERNAMEPHYSICALDNSHOSTNAME"></a><dl> <dt><b>ComputerNamePhysicalDnsHostname</b></dt> </dl> </td> <td
///               width="60%"> Sets the NetBIOS and the Computer Name (the first label of the full DNS name) to the name specified
///               in <i>lpBuffer</i>. If the name exceeds MAX_COMPUTERNAME_LENGTH characters, the NetBIOS name is truncated to
///               MAX_COMPUTERNAME_LENGTH characters, not including the terminating null character. </td> </tr> <tr> <td
///               width="40%"><a id="ComputerNamePhysicalNetBIOS"></a><a id="computernamephysicalnetbios"></a><a
///               id="COMPUTERNAMEPHYSICALNETBIOS"></a><dl> <dt><b>ComputerNamePhysicalNetBIOS</b></dt> </dl> </td> <td
///               width="60%"> Sets the NetBIOS name to the name specified in <i>lpBuffer</i>. The name cannot exceed
///               MAX_COMPUTERNAME_LENGTH characters, not including the terminating null character. Warning: Using this option to
///               set the NetBIOS name breaks the convention of interdependent NetBIOS and DNS names. Applications that use the
///               DnsHostnameToComputerName function to derive the NetBIOS name from the first label of the DNS name will fail if
///               this convention is broken. </td> </tr> </table>
///    lpBuffer = The new name. The name cannot include control characters, leading or trailing spaces, or any of the following
///               characters: " / \ [ ] : | &lt; &gt; + = ; , ?
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL SetComputerNameExA(COMPUTER_NAME_FORMAT NameType, const(char)* lpBuffer);

///Gets the current interrupt-time count, in a more precise form than QueryInterruptTime does.
///Params:
///    lpInterruptTimePrecise = A pointer to a ULONGLONG in which to receive the interrupt-time count in system time units of 100 nanoseconds.
///                             Divide by ten million, or 1e7, to get seconds (there are 1e9 nanoseconds in a second, so there are 1e7
///                             100-nanoseconds in a second).
@DllImport("api-ms-win-core-realtime-l1-1-1")
void QueryInterruptTimePrecise(ulong* lpInterruptTimePrecise);

///Gets the current unbiased interrupt-time count, in a more precise form than QueryUnbiasedInterruptTime does. The
///unbiased interrupt-time count does not include time the system spends in sleep or hibernation.
///Params:
///    lpUnbiasedInterruptTimePrecise = A pointer to a ULONGLONG in which to receive the unbiased interrupt-time count in system time units of 100
///                                     nanoseconds. Divide by ten million, or 1e7, to get seconds (there are 1e9 nanoseconds in a second, so there are
///                                     1e7 100-nanoseconds in a second).
@DllImport("api-ms-win-core-realtime-l1-1-1")
void QueryUnbiasedInterruptTimePrecise(ulong* lpUnbiasedInterruptTimePrecise);

///Gets the current interrupt-time count. For a more precise count, use QueryInterruptTimePrecise.
///Params:
///    lpInterruptTime = A pointer to a ULONGLONG in which to receive the interrupt-time count in system time units of 100 nanoseconds.
///                      Divide by ten million, or 1e7, to get seconds (there are 1e9 nanoseconds in a second, so there are 1e7
///                      100-nanoseconds in a second).
@DllImport("api-ms-win-core-realtime-l1-1-1")
void QueryInterruptTime(ulong* lpInterruptTime);

///Gets the current unbiased interrupt-time count, in units of 100 nanoseconds. The unbiased interrupt-time count does
///not include time the system spends in sleep or hibernation.
///Params:
///    UnbiasedTime = TBD
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails because it is called with a null
///    parameter, the return value is zero.
///    
@DllImport("KERNEL32")
BOOL QueryUnbiasedInterruptTime(ulong* UnbiasedTime);

///Queries the auxiliary counter frequency.
///Params:
///    lpAuxiliaryCounterFrequency = Long pointer to an output buffer that contains the specified auxiliary counter frequency. If the auxiliary
///                                  counter is not supported, the value in the output buffer will be undefined.
///Returns:
///    Returns <b>S_OK</b> if the auxiliary counter is supported and <b>E_NOTIMPL</b> if the auxiliary counter is not
///    supported.
///    
@DllImport("api-ms-win-core-realtime-l1-1-2")
HRESULT QueryAuxiliaryCounterFrequency(ulong* lpAuxiliaryCounterFrequency);

///Converts the specified auxiliary counter value to the corresponding performance counter value; optionally provides
///the estimated conversion error in nanoseconds due to latencies and maximum possible drift.
///Params:
///    ullAuxiliaryCounterValue = The auxiliary counter value to convert.
///    lpPerformanceCounterValue = On success, contains the converted performance counter value. Will be undefined if the function fails.
///    lpConversionError = On success, contains the estimated conversion error, in nanoseconds. Will be undefined if the function fails.
@DllImport("api-ms-win-core-realtime-l1-1-2")
HRESULT ConvertAuxiliaryCounterToPerformanceCounter(ulong ullAuxiliaryCounterValue, 
                                                    ulong* lpPerformanceCounterValue, ulong* lpConversionError);

///Converts the specified performance counter value to the corresponding auxiliary counter value; optionally provides
///the estimated conversion error in nanoseconds due to latencies and maximum possible drift.
///Params:
///    ullPerformanceCounterValue = The performance counter value to convert.
///    lpAuxiliaryCounterValue = On success, contains the converted auxiliary counter value. Will be undefined if the function fails.
///    lpConversionError = On success, contains the estimated conversion error, in nanoseconds. Will be undefined if the function fails.
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

///Changes the number of file handles available to a process. For DOS-based Win32, the default maximum number of file
///handles available to a process is 20. For Windows Win32 systems, this API has no effect.
///Params:
///    uNumber = The requested number of available file handles.
///Returns:
///    The number of available file handles.
///    
@DllImport("KERNEL32")
uint SetHandleCount(uint uNumber);

@DllImport("KERNEL32")
BOOL RequestDeviceWakeup(HANDLE hDevice);

@DllImport("KERNEL32")
BOOL CancelDeviceWakeupRequest(HANDLE hDevice);

@DllImport("KERNEL32")
BOOL SetMessageWaitingIndicator(HANDLE hMsgIndicator, uint ulMsgCount);

///Multiplies two 32-bit values and then divides the 64-bit result by a third 32-bit value. The final result is rounded
///to the nearest integer.
///Params:
///    nNumber = The multiplicand.
///    nNumerator = The multiplier.
///    nDenominator = The number by which the result of the multiplication operation is to be divided.
///Returns:
///    If the function succeeds, the return value is the result of the multiplication and division, rounded to the
///    nearest integer. If the result is a positive half integer (ends in .5), it is rounded up. If the result is a
///    negative half integer, it is rounded down. If either an overflow occurred or <i>nDenominator</i> was 0, the
///    return value is -1.
///    
@DllImport("KERNEL32")
int MulDiv(int nNumber, int nNumerator, int nDenominator);

///Retrieves the current size of the registry and the maximum size that the registry is allowed to attain on the system.
///Params:
///    pdwQuotaAllowed = A pointer to a variable that receives the maximum size that the registry is allowed to attain on this system, in
///                      bytes.
///    pdwQuotaUsed = A pointer to a variable that receives the current size of the registry, in bytes.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL GetSystemRegistryQuota(uint* pdwQuotaAllowed, uint* pdwQuotaUsed);

///Converts a file time to MS-DOS date and time values.
///Params:
///    lpFileTime = A pointer to a FILETIME structure containing the file time to convert to MS-DOS date and time format.
///    lpFatDate = A pointer to a variable to receive the MS-DOS date. The date is a packed value with the following format. <table>
///                <tr> <th>Bits</th> <th>Description</th> </tr> <tr> <td>0–4</td> <td>Day of the month (1–31)</td> </tr> <tr>
///                <td>5–8</td> <td>Month (1 = January, 2 = February, etc.)</td> </tr> <tr> <td>9-15</td> <td>Year offset from
///                1980 (add 1980 to get actual year)</td> </tr> </table>
///    lpFatTime = A pointer to a variable to receive the MS-DOS time. The time is a packed value with the following format. <table>
///                <tr> <th>Bits</th> <th>Description</th> </tr> <tr> <td>0–4</td> <td>Second divided by 2</td> </tr> <tr>
///                <td>5–10</td> <td>Minute (0–59)</td> </tr> <tr> <td>11–15</td> <td>Hour (0–23 on a 24-hour clock)</td>
///                </tr> </table>
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL FileTimeToDosDateTime(const(FILETIME)* lpFileTime, ushort* lpFatDate, ushort* lpFatTime);

///Converts MS-DOS date and time values to a file time.
///Params:
///    wFatDate = The MS-DOS date. The date is a packed value with the following format. <table> <tr> <th>Bits</th>
///               <th>Description</th> </tr> <tr> <td>0-4</td> <td>Day of the month (1–31)</td> </tr> <tr> <td>5-8</td> <td>Month
///               (1 = January, 2 = February, and so on)</td> </tr> <tr> <td>9-15</td> <td>Year offset from 1980 (add 1980 to get
///               actual year)</td> </tr> </table>
///    wFatTime = The MS-DOS time. The time is a packed value with the following format. <table> <tr> <th>Bits</th>
///               <th>Description</th> </tr> <tr> <td>0-4</td> <td>Second divided by 2</td> </tr> <tr> <td>5-10</td> <td>Minute
///               (0–59)</td> </tr> <tr> <td>11-15</td> <td>Hour (0–23 on a 24-hour clock)</td> </tr> </table>
///    lpFileTime = A pointer to a FILETIME structure that receives the converted file time.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL DosDateTimeToFileTime(ushort wFatDate, ushort wFatTime, FILETIME* lpFileTime);

///The _lopen function opens an existing file and sets the file pointer to the beginning of the file. This function is
///provided for compatibility with 16-bit versions of Windows. Win32-based applications should use the CreateFile
///function.
///Params:
///    lpPathName = Pointer to a null-terminated string that names the file to open. The string must consist of characters from the
///                 Windows ANSI character set.
///    iReadWrite = Specifies the modes in which to open the file. This parameter consists of one access mode and an optional share
///                 mode. The access mode must be one of the following values: OF_READ, OF_READWRITE, OF_WRITE The share mode can be
///                 one of the following values: OF_SHARE_COMPAT, OF_SHARE_DENY_NONE, OF_SHARE_DENY_READ, OF_SHARE_DENY_WRITE,
///                 OF_SHARE_EXCLUSIVE
@DllImport("KERNEL32")
int _lopen(const(char)* lpPathName, int iReadWrite);

///<p class="CCE_Message">[This function is provided for compatibility with 16-bit versions of Windows. New applications
///should use the <b>CreateFile</b> function.] Creates or opens the specified file. This documentation is included only
///for troubleshooting existing code.
///Params:
///    lpPathName = The name of the file. The string must consist of characters from the Windows ANSI character set.
///    iAttribute = The attributes of the file. This parameter must be set to one of the following values. <table> <tr>
///                 <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0</dt> </dl> </td> <td width="60%"> Normal.
///                 Can be read from or written to without restriction. </td> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td>
///                 <td width="60%"> Read-only. Cannot be opened for write. </td> </tr> <tr> <td width="40%"> <dl> <dt>2</dt> </dl>
///                 </td> <td width="60%"> Hidden. Not found by directory search. </td> </tr> <tr> <td width="40%"> <dl> <dt>4</dt>
///                 </dl> </td> <td width="60%"> System. Not found by directory search. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is a file handle. Otherwise, the return value is HFILE_ERROR. To get
///    extended error information, use the GetLastError function.
///    
@DllImport("KERNEL32")
int _lcreat(const(char)* lpPathName, int iAttribute);

///The _lread function reads data from the specified file. This function is provided for compatibility with 16-bit
///versions of Windows. Win32-based applications should use the ReadFile function.
///Params:
///    hFile = Identifies the specified file.
///    lpBuffer = Pointer to a buffer that contains the data read from the file.
///    uBytes = Specifies the number of bytes to be read from the file.
@DllImport("KERNEL32")
uint _lread(int hFile, char* lpBuffer, uint uBytes);

///<p class="CCE_Message">[This function is provided for compatibility with 16-bit versions of Windows. New applications
///should use the <b>WriteFile</b> function.] Writes data to the specified file.
///Params:
///    hFile = A handle to the file that receives the data. This handle is created by _lcreat.
///    lpBuffer = The buffer that contains the data to be added.
///    uBytes = The number of bytes to write to the file.
///Returns:
///    If the function succeeds, the return value is the number of bytes written to the file. Otherwise, the return
///    value is HFILE_ERROR. To get extended error information, use the GetLastError function.
///    
@DllImport("KERNEL32")
uint _lwrite(int hFile, const(char)* lpBuffer, uint uBytes);

@DllImport("KERNEL32")
int _hread(int hFile, char* lpBuffer, int lBytes);

@DllImport("KERNEL32")
int _hwrite(int hFile, const(char)* lpBuffer, int lBytes);

///The _lclose function closes the specified file so that it is no longer available for reading or writing. This
///function is provided for compatibility with 16-bit versions of Windows. Win32-based applications should use the
///CloseHandle function.
///Params:
///    hFile = Identifies the file to be closed. This handle is returned by the function that created or last opened the file.
@DllImport("KERNEL32")
int _lclose(int hFile);

///<p class="CCE_Message">[This function is provided for compatibility with 16-bit versions of Windows. New applications
///should use the <b>SetFilePointer</b> function.] Repositions the file pointer for the specified file.
///Params:
///    hFile = A handle to an open file. This handle is created by _lcreat.
///    lOffset = The number of bytes that the file pointer is to be moved.
///    iOrigin = The starting point and the direction that the pointer will be moved. This parameter must be set to one of the
///              following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0</dt> </dl>
///              </td> <td width="60%"> Moves the pointer from the beginning of the file. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>1</dt> </dl> </td> <td width="60%"> Moves the file from its current location. </td> </tr> <tr> <td
///              width="40%"> <dl> <dt>2</dt> </dl> </td> <td width="60%"> Moves the pointer from the end of the file. </td> </tr>
///              </table>
///Returns:
///    If the function succeeds, the return value specifies the new offset. Otherwise, the return value is HFILE_ERROR.
///    To get extended error information, use the GetLastError function.
///    
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

///Retrieves the value of the specified firmware environment variable.
///Params:
///    lpName = The name of the firmware environment variable. The pointer must not be <b>NULL</b>.
///    lpGuid = The GUID that represents the namespace of the firmware environment variable. The GUID must be a string in the
///             format "{<i>xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx</i>}" where 'x' represents a hexadecimal value.
///    pBuffer = A pointer to a buffer that receives the value of the specified firmware environment variable.
///    nSize = The size of the <i>pBuffer</i> buffer, in bytes.
///Returns:
///    If the function succeeds, the return value is the number of bytes stored in the <i>pBuffer</i> buffer. If the
///    function fails, the return value is zero. To get extended error information, call GetLastError. Possible error
///    codes include ERROR_INVALID_FUNCTION.
///    
@DllImport("KERNEL32")
uint GetFirmwareEnvironmentVariableA(const(char)* lpName, const(char)* lpGuid, char* pBuffer, uint nSize);

///Retrieves the value of the specified firmware environment variable.
///Params:
///    lpName = The name of the firmware environment variable. The pointer must not be <b>NULL</b>.
///    lpGuid = The GUID that represents the namespace of the firmware environment variable. The GUID must be a string in the
///             format "{<i>xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx</i>}" where 'x' represents a hexadecimal value.
///    pBuffer = A pointer to a buffer that receives the value of the specified firmware environment variable.
///    nSize = The size of the <i>pBuffer</i> buffer, in bytes.
///Returns:
///    If the function succeeds, the return value is the number of bytes stored in the <i>pBuffer</i> buffer. If the
///    function fails, the return value is zero. To get extended error information, call GetLastError. Possible error
///    codes include ERROR_INVALID_FUNCTION.
///    
@DllImport("KERNEL32")
uint GetFirmwareEnvironmentVariableW(const(wchar)* lpName, const(wchar)* lpGuid, char* pBuffer, uint nSize);

///Retrieves the value of the specified firmware environment variable and its attributes.
///Params:
///    lpName = The name of the firmware environment variable. The pointer must not be <b>NULL</b>.
///    lpGuid = The GUID that represents the namespace of the firmware environment variable. The GUID must be a string in the
///             format "{<i>xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx</i>}" where 'x' represents a hexadecimal value. The pointer must
///             not be <b>NULL</b>.
///    pBuffer = A pointer to a buffer that receives the value of the specified firmware environment variable.
///    nSize = The size of the <i>pValue</i> buffer, in bytes.
///    pdwAttribubutes = Bitmask identifying UEFI variable attributes associated with the variable. See SetFirmwareEnvironmentVariableEx
///                      for the bitmask definition.
///Returns:
///    If the function succeeds, the return value is the number of bytes stored in the <i>pValue</i> buffer. If the
///    function fails, the return value is zero. To get extended error information, call GetLastError. Possible error
///    codes include ERROR_INVALID_FUNCTION.
///    
@DllImport("KERNEL32")
uint GetFirmwareEnvironmentVariableExA(const(char)* lpName, const(char)* lpGuid, char* pBuffer, uint nSize, 
                                       uint* pdwAttribubutes);

///Retrieves the value of the specified firmware environment variable and its attributes.
///Params:
///    lpName = The name of the firmware environment variable. The pointer must not be <b>NULL</b>.
///    lpGuid = The GUID that represents the namespace of the firmware environment variable. The GUID must be a string in the
///             format "{<i>xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx</i>}" where 'x' represents a hexadecimal value. The pointer must
///             not be <b>NULL</b>.
///    pBuffer = A pointer to a buffer that receives the value of the specified firmware environment variable.
///    nSize = The size of the <i>pValue</i> buffer, in bytes.
///    pdwAttribubutes = Bitmask identifying UEFI variable attributes associated with the variable. See SetFirmwareEnvironmentVariableEx
///                      for the bitmask definition.
///Returns:
///    If the function succeeds, the return value is the number of bytes stored in the <i>pValue</i> buffer. If the
///    function fails, the return value is zero. To get extended error information, call GetLastError. Possible error
///    codes include ERROR_INVALID_FUNCTION.
///    
@DllImport("KERNEL32")
uint GetFirmwareEnvironmentVariableExW(const(wchar)* lpName, const(wchar)* lpGuid, char* pBuffer, uint nSize, 
                                       uint* pdwAttribubutes);

///Sets the value of the specified firmware environment variable.
///Params:
///    lpName = The name of the firmware environment variable. The pointer must not be <b>NULL</b>.
///    lpGuid = The GUID that represents the namespace of the firmware environment variable. The GUID must be a string in the
///             format "{<i>xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx</i>}". If the system does not support GUID-based namespaces,
///             this parameter is ignored.
///    pValue = A pointer to the new value for the firmware environment variable.
///    nSize = The size of the <i>pBuffer</i> buffer, in bytes. If this parameter is zero, the firmware environment variable is
///            deleted.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError. Possible error codes include ERROR_INVALID_FUNCTION.
///    
@DllImport("KERNEL32")
BOOL SetFirmwareEnvironmentVariableA(const(char)* lpName, const(char)* lpGuid, char* pValue, uint nSize);

///Sets the value of the specified firmware environment variable.
///Params:
///    lpName = The name of the firmware environment variable. The pointer must not be <b>NULL</b>.
///    lpGuid = The GUID that represents the namespace of the firmware environment variable. The GUID must be a string in the
///             format "{<i>xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx</i>}". If the system does not support GUID-based namespaces,
///             this parameter is ignored.
///    pValue = A pointer to the new value for the firmware environment variable.
///    nSize = The size of the <i>pBuffer</i> buffer, in bytes. If this parameter is zero, the firmware environment variable is
///            deleted.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError. Possible error codes include ERROR_INVALID_FUNCTION.
///    
@DllImport("KERNEL32")
BOOL SetFirmwareEnvironmentVariableW(const(wchar)* lpName, const(wchar)* lpGuid, char* pValue, uint nSize);

///Sets the value of the specified firmware environment variable as the attributes that indicate how this variable is
///stored and maintained.
///Params:
///    lpName = The name of the firmware environment variable. The pointer must not be <b>NULL</b>.
///    lpGuid = The GUID that represents the namespace of the firmware environment variable. The GUID must be a string in the
///             format "{<i>xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx</i>}". If the system does not support GUID-based namespaces,
///             this parameter is ignored. The pointer must not be <b>NULL</b>.
///    pValue = A pointer to the new value for the firmware environment variable.
///    nSize = The size of the <i>pValue</i> buffer, in bytes. Unless the VARIABLE_ATTRIBUTE_APPEND_WRITE,
///            VARIABLE_ATTRIBUTE_AUTHENTICATED_WRITE_ACCESS, or VARIABLE_ATTRIBUTE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS
///            variable attribute is set via <i>dwAttributes</i>, setting this value to zero will result in the deletion of this
///            variable.
///    dwAttributes = Bitmask to set UEFI variable attributes associated with the variable. See also UEFI Spec 2.3.1, Section 7.2.
///                   <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                   id="VARIABLE_ATTRIBUTE_NON_VOLATILE"></a><a id="variable_attribute_non_volatile"></a><dl>
///                   <dt><b>VARIABLE_ATTRIBUTE_NON_VOLATILE</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> The firmware
///                   environment variable is stored in non-volatile memory (e.g. NVRAM). </td> </tr> <tr> <td width="40%"><a
///                   id="VARIABLE_ATTRIBUTE_BOOTSERVICE_ACCESS"></a><a id="variable_attribute_bootservice_access"></a><dl>
///                   <dt><b>VARIABLE_ATTRIBUTE_BOOTSERVICE_ACCESS</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> The
///                   firmware environment variable can be accessed during boot service. </td> </tr> <tr> <td width="40%"><a
///                   id="VARIABLE_ATTRIBUTE_RUNTIME_ACCESS"></a><a id="variable_attribute_runtime_access"></a><dl>
///                   <dt><b>VARIABLE_ATTRIBUTE_RUNTIME_ACCESS</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%"> The firmware
///                   environment variable can be accessed at runtime. <div class="alert"><b>Note</b> Variables with this attribute
///                   set, must also have <b>VARIABLE_ATTRIBUTE_BOOTSERVICE_ACCESS</b> set.</div> <div> </div> </td> </tr> <tr> <td
///                   width="40%"><a id="VARIABLE_ATTRIBUTE_HARDWARE_ERROR_RECORD"></a><a
///                   id="variable_attribute_hardware_error_record"></a><dl> <dt><b>VARIABLE_ATTRIBUTE_HARDWARE_ERROR_RECORD</b></dt>
///                   <dt>0x00000008</dt> </dl> </td> <td width="60%"> Indicates hardware related errors encountered at runtime. </td>
///                   </tr> <tr> <td width="40%"><a id="VARIABLE_ATTRIBUTE_AUTHENTICATED_WRITE_ACCESS"></a><a
///                   id="variable_attribute_authenticated_write_access"></a><dl>
///                   <dt><b>VARIABLE_ATTRIBUTE_AUTHENTICATED_WRITE_ACCESS</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%">
///                   Indicates an authentication requirement that must be met before writing to this firmware environment variable.
///                   For more information see, UEFI spec 2.3.1. </td> </tr> <tr> <td width="40%"><a
///                   id="VARIABLE_ATTRIBUTE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS"></a><a
///                   id="variable_attribute_time_based_authenticated_write_access"></a><dl>
///                   <dt><b>VARIABLE_ATTRIBUTE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS</b></dt> <dt>0x00000020</dt> </dl> </td> <td
///                   width="60%"> Indicates authentication and time stamp requirements that must be met before writing to this
///                   firmware environment variable. When this attribute is set, the buffer, represented by <i>pValue</i>, will begin
///                   with an instance of a complete (and serialized) EFI_VARIABLE_AUTHENTICATION_2 descriptor. For more information
///                   see, UEFI spec 2.3.1. </td> </tr> <tr> <td width="40%"><a id="VARIABLE_ATTRIBUTE_APPEND_WRITE"></a><a
///                   id="variable_attribute_append_write"></a><dl> <dt><b>VARIABLE_ATTRIBUTE_APPEND_WRITE</b></dt> <dt>0x00000040</dt>
///                   </dl> </td> <td width="60%"> Append an existing environment variable with the value of <i>pValue</i>. If the
///                   firmware does not support the operation, then <b>SetFirmwareEnvironmentVariableEx</b> will return
///                   ERROR_INVALID_FUNCTION. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError. Possible error codes include ERROR_INVALID_FUNCTION.
///    
@DllImport("KERNEL32")
BOOL SetFirmwareEnvironmentVariableExA(const(char)* lpName, const(char)* lpGuid, char* pValue, uint nSize, 
                                       uint dwAttributes);

///Sets the value of the specified firmware environment variable and the attributes that indicate how this variable is
///stored and maintained.
///Params:
///    lpName = The name of the firmware environment variable. The pointer must not be <b>NULL</b>.
///    lpGuid = The GUID that represents the namespace of the firmware environment variable. The GUID must be a string in the
///             format "{<i>xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx</i>}". If the system does not support GUID-based namespaces,
///             this parameter is ignored. The pointer must not be <b>NULL</b>.
///    pValue = A pointer to the new value for the firmware environment variable.
///    nSize = The size of the <i>pValue</i> buffer, in bytes. Unless the VARIABLE_ATTRIBUTE_APPEND_WRITE,
///            VARIABLE_ATTRIBUTE_AUTHENTICATED_WRITE_ACCESS, or VARIABLE_ATTRIBUTE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS
///            variable attribute is set via <i>dwAttributes</i>, setting this value to zero will result in the deletion of this
///            variable.
///    dwAttributes = Bitmask to set UEFI variable attributes associated with the variable. See also UEFI Spec 2.3.1, Section 7.2.
///                   <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                   id="VARIABLE_ATTRIBUTE_NON_VOLATILE"></a><a id="variable_attribute_non_volatile"></a><dl>
///                   <dt><b>VARIABLE_ATTRIBUTE_NON_VOLATILE</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> The firmware
///                   environment variable is stored in non-volatile memory (e.g. NVRAM). </td> </tr> <tr> <td width="40%"><a
///                   id="VARIABLE_ATTRIBUTE_BOOTSERVICE_ACCESS"></a><a id="variable_attribute_bootservice_access"></a><dl>
///                   <dt><b>VARIABLE_ATTRIBUTE_BOOTSERVICE_ACCESS</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> The
///                   firmware environment variable can be accessed during boot service. </td> </tr> <tr> <td width="40%"><a
///                   id="VARIABLE_ATTRIBUTE_RUNTIME_ACCESS"></a><a id="variable_attribute_runtime_access"></a><dl>
///                   <dt><b>VARIABLE_ATTRIBUTE_RUNTIME_ACCESS</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%"> The firmware
///                   environment variable can be accessed at runtime. <div class="alert"><b>Note</b> Variables with this attribute
///                   set, must also have <b>VARIABLE_ATTRIBUTE_BOOTSERVICE_ACCESS</b> set.</div> <div> </div> </td> </tr> <tr> <td
///                   width="40%"><a id="VARIABLE_ATTRIBUTE_HARDWARE_ERROR_RECORD"></a><a
///                   id="variable_attribute_hardware_error_record"></a><dl> <dt><b>VARIABLE_ATTRIBUTE_HARDWARE_ERROR_RECORD</b></dt>
///                   <dt>0x00000008</dt> </dl> </td> <td width="60%"> Indicates hardware related errors encountered at runtime. </td>
///                   </tr> <tr> <td width="40%"><a id="VARIABLE_ATTRIBUTE_AUTHENTICATED_WRITE_ACCESS"></a><a
///                   id="variable_attribute_authenticated_write_access"></a><dl>
///                   <dt><b>VARIABLE_ATTRIBUTE_AUTHENTICATED_WRITE_ACCESS</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%">
///                   Indicates an authentication requirement that must be met before writing to this firmware environment variable.
///                   For more information see, UEFI spec 2.3.1. </td> </tr> <tr> <td width="40%"><a
///                   id="VARIABLE_ATTRIBUTE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS"></a><a
///                   id="variable_attribute_time_based_authenticated_write_access"></a><dl>
///                   <dt><b>VARIABLE_ATTRIBUTE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS</b></dt> <dt>0x00000020</dt> </dl> </td> <td
///                   width="60%"> Indicates authentication and time stamp requirements that must be met before writing to this
///                   firmware environment variable. When this attribute is set, the buffer, represented by <i>pValue</i>, will begin
///                   with an instance of a complete (and serialized) EFI_VARIABLE_AUTHENTICATION_2 descriptor. For more information
///                   see, UEFI spec 2.3.1. </td> </tr> <tr> <td width="40%"><a id="VARIABLE_ATTRIBUTE_APPEND_WRITE"></a><a
///                   id="variable_attribute_append_write"></a><dl> <dt><b>VARIABLE_ATTRIBUTE_APPEND_WRITE</b></dt> <dt>0x00000040</dt>
///                   </dl> </td> <td width="60%"> Append an existing environment variable with the value of <i>pValue</i>. If the
///                   firmware does not support the operation, then <b>SetFirmwareEnvironmentVariableEx</b> will return
///                   ERROR_INVALID_FUNCTION. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError. Possible error codes include ERROR_INVALID_FUNCTION.
///    
@DllImport("KERNEL32")
BOOL SetFirmwareEnvironmentVariableExW(const(wchar)* lpName, const(wchar)* lpGuid, char* pValue, uint nSize, 
                                       uint dwAttributes);

///Retrieves the firmware type of the local computer.
///Params:
///    FirmwareType = A pointer to a FIRMWARE_TYPE enumeration.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call the GetLastError function.
///    
@DllImport("KERNEL32")
BOOL GetFirmwareType(FIRMWARE_TYPE* FirmwareType);

///Indicates if the OS was booted from a VHD container.
///Params:
///    NativeVhdBoot = Pointer to a variable that receives a boolean indicating if the OS was booted from a VHD.
///Returns:
///    TRUE if the OS was a native VHD boot; otherwise, FALSE. Call GetLastError to get extended error information.
///    
@DllImport("KERNEL32")
BOOL IsNativeVhdBoot(int* NativeVhdBoot);

///Retrieves an integer from a key in the specified section of the Win.ini file. <div class="alert"><b>Note</b> This
///function is provided only for compatibility with 16-bit Windows-based applications. Applications should store
///initialization information in the registry.</div><div> </div>
///Params:
///    lpAppName = The name of the section containing the key name.
///    lpKeyName = The name of the key whose value is to be retrieved. This value is in the form of a string; the
///                <b>GetProfileInt</b> function converts the string into an integer and returns the integer.
///    nDefault = The default value to return if the key name cannot be found in the initialization file.
///Returns:
///    The return value is the integer equivalent of the string following the key name in Win.ini. If the function
///    cannot find the key, the return value is the default value. If the value of the key is less than zero, the return
///    value is zero.
///    
@DllImport("KERNEL32")
uint GetProfileIntA(const(char)* lpAppName, const(char)* lpKeyName, int nDefault);

///Retrieves an integer from a key in the specified section of the Win.ini file. <div class="alert"><b>Note</b> This
///function is provided only for compatibility with 16-bit Windows-based applications. Applications should store
///initialization information in the registry.</div><div> </div>
///Params:
///    lpAppName = The name of the section containing the key name.
///    lpKeyName = The name of the key whose value is to be retrieved. This value is in the form of a string; the
///                <b>GetProfileInt</b> function converts the string into an integer and returns the integer.
///    nDefault = The default value to return if the key name cannot be found in the initialization file.
///Returns:
///    The return value is the integer equivalent of the string following the key name in Win.ini. If the function
///    cannot find the key, the return value is the default value. If the value of the key is less than zero, the return
///    value is zero.
///    
@DllImport("KERNEL32")
uint GetProfileIntW(const(wchar)* lpAppName, const(wchar)* lpKeyName, int nDefault);

///Retrieves the string associated with a key in the specified section of the Win.ini file. <div
///class="alert"><b>Note</b> This function is provided only for compatibility with 16-bit Windows-based applications,
///therefore this function should not be called from server code. Applications should store initialization information
///in the registry.</div><div> </div>
///Params:
///    lpAppName = The name of the section containing the key. If this parameter is <b>NULL</b>, the function copies all section
///                names in the file to the supplied buffer.
///    lpKeyName = The name of the key whose associated string is to be retrieved. If this parameter is <b>NULL</b>, the function
///                copies all keys in the given section to the supplied buffer. Each string is followed by a <b>null</b> character,
///                and the final string is followed by a second <b>null</b> character.
///    lpDefault = A default string. If the <i>lpKeyName</i> key cannot be found in the initialization file, <b>GetProfileString</b>
///                copies the default string to the <i>lpReturnedString</i> buffer. If this parameter is <b>NULL</b>, the default is
///                an empty string, "". Avoid specifying a default string with trailing blank characters. The function inserts a
///                <b>null</b> character in the <i>lpReturnedString</i> buffer to strip any trailing blanks.
///    lpReturnedString = A pointer to a buffer that receives the character string.
///    nSize = The size of the buffer pointed to by the <i>lpReturnedString</i> parameter, in characters.
///Returns:
///    The return value is the number of characters copied to the buffer, not including the <b>null</b>-terminating
///    character. If neither <i>lpAppName</i> nor <i>lpKeyName</i> is <b>NULL</b> and the supplied destination buffer is
///    too small to hold the requested string, the string is truncated and followed by a <b>null</b> character, and the
///    return value is equal to <i>nSize</i> minus one. If either <i>lpAppName</i> or <i>lpKeyName</i> is <b>NULL</b>
///    and the supplied destination buffer is too small to hold all the strings, the last string is truncated and
///    followed by two <b>null</b> characters. In this case, the return value is equal to <i>nSize</i> minus two.
///    
@DllImport("KERNEL32")
uint GetProfileStringA(const(char)* lpAppName, const(char)* lpKeyName, const(char)* lpDefault, 
                       const(char)* lpReturnedString, uint nSize);

///Retrieves the string associated with a key in the specified section of the Win.ini file. <div
///class="alert"><b>Note</b> This function is provided only for compatibility with 16-bit Windows-based applications,
///therefore this function should not be called from server code. Applications should store initialization information
///in the registry.</div><div> </div>
///Params:
///    lpAppName = The name of the section containing the key. If this parameter is <b>NULL</b>, the function copies all section
///                names in the file to the supplied buffer.
///    lpKeyName = The name of the key whose associated string is to be retrieved. If this parameter is <b>NULL</b>, the function
///                copies all keys in the given section to the supplied buffer. Each string is followed by a <b>null</b> character,
///                and the final string is followed by a second <b>null</b> character.
///    lpDefault = A default string. If the <i>lpKeyName</i> key cannot be found in the initialization file, <b>GetProfileString</b>
///                copies the default string to the <i>lpReturnedString</i> buffer. If this parameter is <b>NULL</b>, the default is
///                an empty string, "". Avoid specifying a default string with trailing blank characters. The function inserts a
///                <b>null</b> character in the <i>lpReturnedString</i> buffer to strip any trailing blanks.
///    lpReturnedString = A pointer to a buffer that receives the character string.
///    nSize = The size of the buffer pointed to by the <i>lpReturnedString</i> parameter, in characters.
///Returns:
///    The return value is the number of characters copied to the buffer, not including the <b>null</b>-terminating
///    character. If neither <i>lpAppName</i> nor <i>lpKeyName</i> is <b>NULL</b> and the supplied destination buffer is
///    too small to hold the requested string, the string is truncated and followed by a <b>null</b> character, and the
///    return value is equal to <i>nSize</i> minus one. If either <i>lpAppName</i> or <i>lpKeyName</i> is <b>NULL</b>
///    and the supplied destination buffer is too small to hold all the strings, the last string is truncated and
///    followed by two <b>null</b> characters. In this case, the return value is equal to <i>nSize</i> minus two.
///    
@DllImport("KERNEL32")
uint GetProfileStringW(const(wchar)* lpAppName, const(wchar)* lpKeyName, const(wchar)* lpDefault, 
                       const(wchar)* lpReturnedString, uint nSize);

///Copies a string into the specified section of the Win.ini file. If Win.ini uses Unicode characters, the function
///writes Unicode characters to the file. Otherwise, the function writes ANSI characters. <div class="alert"><b>Note</b>
///This function is provided only for compatibility with 16-bit versions of Windows. Applications should store
///initialization information in the registry.</div><div> </div>
///Params:
///    lpAppName = The section to which the string is to be copied. If the section does not exist, it is created. The name of the
///                section is not case-sensitive; the string can be any combination of uppercase and lowercase letters.
///    lpKeyName = The key to be associated with the string. If the key does not exist in the specified section, it is created. If
///                this parameter is <b>NULL</b>, the entire section, including all entries in the section, is deleted.
///    lpString = A <b>null</b>-terminated string to be written to the file. If this parameter is <b>NULL</b>, the key pointed to
///               by the <i>lpKeyName</i> parameter is deleted.
///Returns:
///    If the function successfully copies the string to the Win.ini file, the return value is nonzero. If the function
///    fails, or if it flushes the cached version of Win.ini, the return value is zero. To get extended error
///    information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL WriteProfileStringA(const(char)* lpAppName, const(char)* lpKeyName, const(char)* lpString);

///Copies a string into the specified section of the Win.ini file. If Win.ini uses Unicode characters, the function
///writes Unicode characters to the file. Otherwise, the function writes ANSI characters. <div class="alert"><b>Note</b>
///This function is provided only for compatibility with 16-bit versions of Windows. Applications should store
///initialization information in the registry.</div><div> </div>
///Params:
///    lpAppName = The section to which the string is to be copied. If the section does not exist, it is created. The name of the
///                section is not case-sensitive; the string can be any combination of uppercase and lowercase letters.
///    lpKeyName = The key to be associated with the string. If the key does not exist in the specified section, it is created. If
///                this parameter is <b>NULL</b>, the entire section, including all entries in the section, is deleted.
///    lpString = A <b>null</b>-terminated string to be written to the file. If this parameter is <b>NULL</b>, the key pointed to
///               by the <i>lpKeyName</i> parameter is deleted.
///Returns:
///    If the function successfully copies the string to the Win.ini file, the return value is nonzero. If the function
///    fails, or if it flushes the cached version of Win.ini, the return value is zero. To get extended error
///    information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL WriteProfileStringW(const(wchar)* lpAppName, const(wchar)* lpKeyName, const(wchar)* lpString);

///Retrieves all the keys and values for the specified section of the Win.ini file. <div class="alert"><b>Note</b> This
///function is provided only for compatibility with 16-bit Windows-based applications. Applications should store
///initialization information in the registry.</div><div> </div>
///Params:
///    lpAppName = The name of the section in the Win.ini file.
///    lpReturnedString = A pointer to a buffer that receives the keys and values associated with the named section. The buffer is filled
///                       with one or more null-terminated strings; the last string is followed by a second null character.
///    nSize = The size of the buffer pointed to by the <i>lpReturnedString</i> parameter, in characters. The maximum profile
///            section size is 32,767 characters.
///Returns:
///    The return value specifies the number of characters copied to the specified buffer, not including the terminating
///    null character. If the buffer is not large enough to contain all the keys and values associated with the named
///    section, the return value is equal to the size specified by <i>nSize</i> minus two.
///    
@DllImport("KERNEL32")
uint GetProfileSectionA(const(char)* lpAppName, const(char)* lpReturnedString, uint nSize);

///Retrieves all the keys and values for the specified section of the Win.ini file. <div class="alert"><b>Note</b> This
///function is provided only for compatibility with 16-bit Windows-based applications. Applications should store
///initialization information in the registry.</div><div> </div>
///Params:
///    lpAppName = The name of the section in the Win.ini file.
///    lpReturnedString = A pointer to a buffer that receives the keys and values associated with the named section. The buffer is filled
///                       with one or more null-terminated strings; the last string is followed by a second null character.
///    nSize = The size of the buffer pointed to by the <i>lpReturnedString</i> parameter, in characters. The maximum profile
///            section size is 32,767 characters.
///Returns:
///    The return value specifies the number of characters copied to the specified buffer, not including the terminating
///    null character. If the buffer is not large enough to contain all the keys and values associated with the named
///    section, the return value is equal to the size specified by <i>nSize</i> minus two.
///    
@DllImport("KERNEL32")
uint GetProfileSectionW(const(wchar)* lpAppName, const(wchar)* lpReturnedString, uint nSize);

///Replaces the contents of the specified section in the Win.ini file with specified keys and values. If Win.ini uses
///Unicode characters, the function writes Unicode characters to the file. Otherwise, the function writes ANSI
///characters. <div class="alert"><b>Note</b> This function is provided only for compatibility with 16-bit versions of
///Windows. Applications should store initialization information in the registry.</div><div> </div>
///Params:
///    lpAppName = The name of the section. This section name is typically the name of the calling application.
///    lpString = The new key names and associated values that are to be written to the named section. This string is limited to
///               65,535 bytes. If the file exists and was created using Unicode characters, the function writes Unicode characters
///               to the file. Otherwise, the function creates a file using ANSI characters.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL WriteProfileSectionA(const(char)* lpAppName, const(char)* lpString);

///Replaces the contents of the specified section in the Win.ini file with specified keys and values. If Win.ini uses
///Unicode characters, the function writes Unicode characters to the file. Otherwise, the function writes ANSI
///characters. <div class="alert"><b>Note</b> This function is provided only for compatibility with 16-bit versions of
///Windows. Applications should store initialization information in the registry.</div><div> </div>
///Params:
///    lpAppName = The name of the section. This section name is typically the name of the calling application.
///    lpString = The new key names and associated values that are to be written to the named section. This string is limited to
///               65,535 bytes. If the file exists and was created using Unicode characters, the function writes Unicode characters
///               to the file. Otherwise, the function creates a file using ANSI characters.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL WriteProfileSectionW(const(wchar)* lpAppName, const(wchar)* lpString);

///Retrieves an integer associated with a key in the specified section of an initialization file. <div
///class="alert"><b>Note</b> This function is provided only for compatibility with 16-bit Windows-based applications.
///Applications should store initialization information in the registry.</div><div> </div>
///Params:
///    lpAppName = The name of the section in the initialization file.
///    lpKeyName = The name of the key whose value is to be retrieved. This value is in the form of a string; the
///                <b>GetPrivateProfileInt</b> function converts the string into an integer and returns the integer.
///    nDefault = The default value to return if the key name cannot be found in the initialization file.
///    lpFileName = The name of the initialization file. If this parameter does not contain a full path to the file, the system
///                 searches for the file in the Windows directory.
///Returns:
///    The return value is the integer equivalent of the string following the specified key name in the specified
///    initialization file. If the key is not found, the return value is the specified default value.
///    
@DllImport("KERNEL32")
uint GetPrivateProfileIntA(const(char)* lpAppName, const(char)* lpKeyName, int nDefault, const(char)* lpFileName);

///Retrieves an integer associated with a key in the specified section of an initialization file. <div
///class="alert"><b>Note</b> This function is provided only for compatibility with 16-bit Windows-based applications.
///Applications should store initialization information in the registry.</div><div> </div>
///Params:
///    lpAppName = The name of the section in the initialization file.
///    lpKeyName = The name of the key whose value is to be retrieved. This value is in the form of a string; the
///                <b>GetPrivateProfileInt</b> function converts the string into an integer and returns the integer.
///    nDefault = The default value to return if the key name cannot be found in the initialization file.
///    lpFileName = The name of the initialization file. If this parameter does not contain a full path to the file, the system
///                 searches for the file in the Windows directory.
///Returns:
///    The return value is the integer equivalent of the string following the specified key name in the specified
///    initialization file. If the key is not found, the return value is the specified default value.
///    
@DllImport("KERNEL32")
uint GetPrivateProfileIntW(const(wchar)* lpAppName, const(wchar)* lpKeyName, int nDefault, 
                           const(wchar)* lpFileName);

///Retrieves a string from the specified section in an initialization file. <div class="alert"><b>Note</b> This function
///is provided only for compatibility with 16-bit Windows-based applications. Applications should store initialization
///information in the registry.</div><div> </div>
///Params:
///    lpAppName = The name of the section containing the key name. If this parameter is <b>NULL</b>, the
///                <b>GetPrivateProfileString</b> function copies all section names in the file to the supplied buffer.
///    lpKeyName = The name of the key whose associated string is to be retrieved. If this parameter is <b>NULL</b>, all key names
///                in the section specified by the <i>lpAppName</i> parameter are copied to the buffer specified by the
///                <i>lpReturnedString</i> parameter.
///    lpDefault = A default string. If the <i>lpKeyName</i> key cannot be found in the initialization file,
///                <b>GetPrivateProfileString</b> copies the default string to the <i>lpReturnedString</i> buffer. If this parameter
///                is <b>NULL</b>, the default is an empty string, "". Avoid specifying a default string with trailing blank
///                characters. The function inserts a <b>null</b> character in the <i>lpReturnedString</i> buffer to strip any
///                trailing blanks.
///    lpReturnedString = A pointer to the buffer that receives the retrieved string.
///    nSize = The size of the buffer pointed to by the <i>lpReturnedString</i> parameter, in characters.
///    lpFileName = The name of the initialization file. If this parameter does not contain a full path to the file, the system
///                 searches for the file in the Windows directory.
///Returns:
///    The return value is the number of characters copied to the buffer, not including the terminating <b>null</b>
///    character. If neither <i>lpAppName</i> nor <i>lpKeyName</i> is <b>NULL</b> and the supplied destination buffer is
///    too small to hold the requested string, the string is truncated and followed by a <b>null</b> character, and the
///    return value is equal to <i>nSize</i> minus one. If either <i>lpAppName</i> or <i>lpKeyName</i> is <b>NULL</b>
///    and the supplied destination buffer is too small to hold all the strings, the last string is truncated and
///    followed by two <b>null</b> characters. In this case, the return value is equal to <i>nSize</i> minus two. In the
///    event the initialization file specified by <i>lpFileName</i> is not found, or contains invalid values, this
///    function will set <b>errorno</b> with a value of '0x2' (File Not Found). To retrieve extended error information,
///    call GetLastError.
///    
@DllImport("KERNEL32")
uint GetPrivateProfileStringA(const(char)* lpAppName, const(char)* lpKeyName, const(char)* lpDefault, 
                              const(char)* lpReturnedString, uint nSize, const(char)* lpFileName);

///Retrieves a string from the specified section in an initialization file. <div class="alert"><b>Note</b> This function
///is provided only for compatibility with 16-bit Windows-based applications. Applications should store initialization
///information in the registry.</div><div> </div>
///Params:
///    lpAppName = The name of the section containing the key name. If this parameter is <b>NULL</b>, the
///                <b>GetPrivateProfileString</b> function copies all section names in the file to the supplied buffer.
///    lpKeyName = The name of the key whose associated string is to be retrieved. If this parameter is <b>NULL</b>, all key names
///                in the section specified by the <i>lpAppName</i> parameter are copied to the buffer specified by the
///                <i>lpReturnedString</i> parameter.
///    lpDefault = A default string. If the <i>lpKeyName</i> key cannot be found in the initialization file,
///                <b>GetPrivateProfileString</b> copies the default string to the <i>lpReturnedString</i> buffer. If this parameter
///                is <b>NULL</b>, the default is an empty string, "". Avoid specifying a default string with trailing blank
///                characters. The function inserts a <b>null</b> character in the <i>lpReturnedString</i> buffer to strip any
///                trailing blanks.
///    lpReturnedString = A pointer to the buffer that receives the retrieved string.
///    nSize = The size of the buffer pointed to by the <i>lpReturnedString</i> parameter, in characters.
///    lpFileName = The name of the initialization file. If this parameter does not contain a full path to the file, the system
///                 searches for the file in the Windows directory.
///Returns:
///    The return value is the number of characters copied to the buffer, not including the terminating <b>null</b>
///    character. If neither <i>lpAppName</i> nor <i>lpKeyName</i> is <b>NULL</b> and the supplied destination buffer is
///    too small to hold the requested string, the string is truncated and followed by a <b>null</b> character, and the
///    return value is equal to <i>nSize</i> minus one. If either <i>lpAppName</i> or <i>lpKeyName</i> is <b>NULL</b>
///    and the supplied destination buffer is too small to hold all the strings, the last string is truncated and
///    followed by two <b>null</b> characters. In this case, the return value is equal to <i>nSize</i> minus two. In the
///    event the initialization file specified by <i>lpFileName</i> is not found, or contains invalid values, this
///    function will set <b>errorno</b> with a value of '0x2' (File Not Found). To retrieve extended error information,
///    call GetLastError.
///    
@DllImport("KERNEL32")
uint GetPrivateProfileStringW(const(wchar)* lpAppName, const(wchar)* lpKeyName, const(wchar)* lpDefault, 
                              const(wchar)* lpReturnedString, uint nSize, const(wchar)* lpFileName);

///Copies a string into the specified section of an initialization file. <div class="alert"><b>Note</b> This function is
///provided only for compatibility with 16-bit versions of Windows. Applications should store initialization information
///in the registry.</div><div> </div>
///Params:
///    lpAppName = The name of the section to which the string will be copied. If the section does not exist, it is created. The
///                name of the section is case-independent; the string can be any combination of uppercase and lowercase letters.
///    lpKeyName = The name of the key to be associated with a string. If the key does not exist in the specified section, it is
///                created. If this parameter is <b>NULL</b>, the entire section, including all entries within the section, is
///                deleted.
///    lpString = A <b>null</b>-terminated string to be written to the file. If this parameter is <b>NULL</b>, the key pointed to
///               by the <i>lpKeyName</i> parameter is deleted.
///    lpFileName = The name of the initialization file. If the file was created using Unicode characters, the function writes
///                 Unicode characters to the file. Otherwise, the function writes ANSI characters.
///Returns:
///    If the function successfully copies the string to the initialization file, the return value is nonzero. If the
///    function fails, or if it flushes the cached version of the most recently accessed initialization file, the return
///    value is zero. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL WritePrivateProfileStringA(const(char)* lpAppName, const(char)* lpKeyName, const(char)* lpString, 
                                const(char)* lpFileName);

///Copies a string into the specified section of an initialization file. <div class="alert"><b>Note</b> This function is
///provided only for compatibility with 16-bit versions of Windows. Applications should store initialization information
///in the registry.</div><div> </div>
///Params:
///    lpAppName = The name of the section to which the string will be copied. If the section does not exist, it is created. The
///                name of the section is case-independent; the string can be any combination of uppercase and lowercase letters.
///    lpKeyName = The name of the key to be associated with a string. If the key does not exist in the specified section, it is
///                created. If this parameter is <b>NULL</b>, the entire section, including all entries within the section, is
///                deleted.
///    lpString = A <b>null</b>-terminated string to be written to the file. If this parameter is <b>NULL</b>, the key pointed to
///               by the <i>lpKeyName</i> parameter is deleted.
///    lpFileName = The name of the initialization file. If the file was created using Unicode characters, the function writes
///                 Unicode characters to the file. Otherwise, the function writes ANSI characters.
///Returns:
///    If the function successfully copies the string to the initialization file, the return value is nonzero. If the
///    function fails, or if it flushes the cached version of the most recently accessed initialization file, the return
///    value is zero. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL WritePrivateProfileStringW(const(wchar)* lpAppName, const(wchar)* lpKeyName, const(wchar)* lpString, 
                                const(wchar)* lpFileName);

///Retrieves all the keys and values for the specified section of an initialization file. <div class="alert"><b>Note</b>
///This function is provided only for compatibility with 16-bit applications written for Windows. Applications should
///store initialization information in the registry.</div><div> </div>
///Params:
///    lpAppName = The name of the section in the initialization file.
///    lpReturnedString = A pointer to a buffer that receives the key name and value pairs associated with the named section. The buffer is
///                       filled with one or more null-terminated strings; the last string is followed by a second null character.
///    nSize = The size of the buffer pointed to by the <i>lpReturnedString</i> parameter, in characters. The maximum profile
///            section size is 32,767 characters.
///    lpFileName = The name of the initialization file. If this parameter does not contain a full path to the file, the system
///                 searches for the file in the Windows directory.
///Returns:
///    The return value specifies the number of characters copied to the buffer, not including the terminating null
///    character. If the buffer is not large enough to contain all the key name and value pairs associated with the
///    named section, the return value is equal to <i>nSize</i> minus two.
///    
@DllImport("KERNEL32")
uint GetPrivateProfileSectionA(const(char)* lpAppName, const(char)* lpReturnedString, uint nSize, 
                               const(char)* lpFileName);

///Retrieves all the keys and values for the specified section of an initialization file. <div class="alert"><b>Note</b>
///This function is provided only for compatibility with 16-bit applications written for Windows. Applications should
///store initialization information in the registry.</div><div> </div>
///Params:
///    lpAppName = The name of the section in the initialization file.
///    lpReturnedString = A pointer to a buffer that receives the key name and value pairs associated with the named section. The buffer is
///                       filled with one or more null-terminated strings; the last string is followed by a second null character.
///    nSize = The size of the buffer pointed to by the <i>lpReturnedString</i> parameter, in characters. The maximum profile
///            section size is 32,767 characters.
///    lpFileName = The name of the initialization file. If this parameter does not contain a full path to the file, the system
///                 searches for the file in the Windows directory.
///Returns:
///    The return value specifies the number of characters copied to the buffer, not including the terminating null
///    character. If the buffer is not large enough to contain all the key name and value pairs associated with the
///    named section, the return value is equal to <i>nSize</i> minus two.
///    
@DllImport("KERNEL32")
uint GetPrivateProfileSectionW(const(wchar)* lpAppName, const(wchar)* lpReturnedString, uint nSize, 
                               const(wchar)* lpFileName);

///Replaces the keys and values for the specified section in an initialization file. <div class="alert"><b>Note</b> This
///function is provided only for compatibility with 16-bit versions of Windows. Applications should store initialization
///information in the registry.</div><div> </div>
///Params:
///    lpAppName = The name of the section in which data is written. This section name is typically the name of the calling
///                application.
///    lpString = The new key names and associated values that are to be written to the named section. This string is limited to
///               65,535 bytes.
///    lpFileName = The name of the initialization file. If this parameter does not contain a full path for the file, the function
///                 searches the Windows directory for the file. If the file does not exist and <i>lpFileName</i> does not contain a
///                 full path, the function creates the file in the Windows directory. If the file exists and was created using
///                 Unicode characters, the function writes Unicode characters to the file. Otherwise, the function creates a file
///                 using ANSI characters.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL WritePrivateProfileSectionA(const(char)* lpAppName, const(char)* lpString, const(char)* lpFileName);

///Replaces the keys and values for the specified section in an initialization file. <div class="alert"><b>Note</b> This
///function is provided only for compatibility with 16-bit versions of Windows. Applications should store initialization
///information in the registry.</div><div> </div>
///Params:
///    lpAppName = The name of the section in which data is written. This section name is typically the name of the calling
///                application.
///    lpString = The new key names and associated values that are to be written to the named section. This string is limited to
///               65,535 bytes.
///    lpFileName = The name of the initialization file. If this parameter does not contain a full path for the file, the function
///                 searches the Windows directory for the file. If the file does not exist and <i>lpFileName</i> does not contain a
///                 full path, the function creates the file in the Windows directory. If the file exists and was created using
///                 Unicode characters, the function writes Unicode characters to the file. Otherwise, the function creates a file
///                 using ANSI characters.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL WritePrivateProfileSectionW(const(wchar)* lpAppName, const(wchar)* lpString, const(wchar)* lpFileName);

///Retrieves the names of all sections in an initialization file. <div class="alert"><b>Note</b> This function is
///provided only for compatibility with 16-bit Windows-based applications. Applications should store initialization
///information in the registry.</div><div> </div>
///Params:
///    lpszReturnBuffer = A pointer to a buffer that receives the section names associated with the named file. The buffer is filled with
///                       one or more <b>null</b>-terminated strings; the last string is followed by a second <b>null</b> character.
///    nSize = The size of the buffer pointed to by the <i>lpszReturnBuffer</i> parameter, in characters.
///    lpFileName = The name of the initialization file. If this parameter is <b>NULL</b>, the function searches the Win.ini file. If
///                 this parameter does not contain a full path to the file, the system searches for the file in the Windows
///                 directory.
///Returns:
///    The return value specifies the number of characters copied to the specified buffer, not including the terminating
///    <b>null</b> character. If the buffer is not large enough to contain all the section names associated with the
///    specified initialization file, the return value is equal to the size specified by <i>nSize</i> minus two.
///    
@DllImport("KERNEL32")
uint GetPrivateProfileSectionNamesA(const(char)* lpszReturnBuffer, uint nSize, const(char)* lpFileName);

///Retrieves the names of all sections in an initialization file. <div class="alert"><b>Note</b> This function is
///provided only for compatibility with 16-bit Windows-based applications. Applications should store initialization
///information in the registry.</div><div> </div>
///Params:
///    lpszReturnBuffer = A pointer to a buffer that receives the section names associated with the named file. The buffer is filled with
///                       one or more <b>null</b>-terminated strings; the last string is followed by a second <b>null</b> character.
///    nSize = The size of the buffer pointed to by the <i>lpszReturnBuffer</i> parameter, in characters.
///    lpFileName = The name of the initialization file. If this parameter is <b>NULL</b>, the function searches the Win.ini file. If
///                 this parameter does not contain a full path to the file, the system searches for the file in the Windows
///                 directory.
///Returns:
///    The return value specifies the number of characters copied to the specified buffer, not including the terminating
///    <b>null</b> character. If the buffer is not large enough to contain all the section names associated with the
///    specified initialization file, the return value is equal to the size specified by <i>nSize</i> minus two.
///    
@DllImport("KERNEL32")
uint GetPrivateProfileSectionNamesW(const(wchar)* lpszReturnBuffer, uint nSize, const(wchar)* lpFileName);

///Retrieves the data associated with a key in the specified section of an initialization file. As it retrieves the
///data, the function calculates a checksum and compares it with the checksum calculated by the
///WritePrivateProfileStruct function when the data was added to the file. <div class="alert"><b>Note</b> This function
///is provided only for compatibility with 16-bit Windows-based applications. Applications should store initialization
///information in the registry.</div><div> </div>
///Params:
///    lpszSection = The name of the section in the initialization file.
///    lpszKey = The name of the key whose data is to be retrieved.
///    lpStruct = A pointer to the buffer that receives the data associated with the file, section, and key names.
///    uSizeStruct = The size of the buffer pointed to by the <i>lpStruct</i> parameter, in bytes.
///    szFile = The name of the initialization file. If this parameter does not contain a full path to the file, the system
///             searches for the file in the Windows directory.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("KERNEL32")
BOOL GetPrivateProfileStructA(const(char)* lpszSection, const(char)* lpszKey, char* lpStruct, uint uSizeStruct, 
                              const(char)* szFile);

///Retrieves the data associated with a key in the specified section of an initialization file. As it retrieves the
///data, the function calculates a checksum and compares it with the checksum calculated by the
///WritePrivateProfileStruct function when the data was added to the file. <div class="alert"><b>Note</b> This function
///is provided only for compatibility with 16-bit Windows-based applications. Applications should store initialization
///information in the registry.</div><div> </div>
///Params:
///    lpszSection = The name of the section in the initialization file.
///    lpszKey = The name of the key whose data is to be retrieved.
///    lpStruct = A pointer to the buffer that receives the data associated with the file, section, and key names.
///    uSizeStruct = The size of the buffer pointed to by the <i>lpStruct</i> parameter, in bytes.
///    szFile = The name of the initialization file. If this parameter does not contain a full path to the file, the system
///             searches for the file in the Windows directory.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero.
///    
@DllImport("KERNEL32")
BOOL GetPrivateProfileStructW(const(wchar)* lpszSection, const(wchar)* lpszKey, char* lpStruct, uint uSizeStruct, 
                              const(wchar)* szFile);

///Copies data into a key in the specified section of an initialization file. As it copies the data, the function
///calculates a checksum and appends it to the end of the data. The GetPrivateProfileStruct function uses the checksum
///to ensure the integrity of the data. <div class="alert"><b>Note</b> This function is provided only for compatibility
///with 16-bit versions of Windows. Applications should store initialization information in the registry.</div><div>
///</div>
///Params:
///    lpszSection = The name of the section to which the string will be copied. If the section does not exist, it is created. The
///                  name of the section is case independent, the string can be any combination of uppercase and lowercase letters.
///    lpszKey = The name of the key to be associated with a string. If the key does not exist in the specified section, it is
///              created. If this parameter is <b>NULL</b>, the entire section, including all keys and entries within the section,
///              is deleted.
///    lpStruct = The data to be copied. If this parameter is <b>NULL</b>, the key is deleted.
///    uSizeStruct = The size of the buffer pointed to by the <i>lpStruct</i> parameter, in bytes.
///    szFile = The name of the initialization file. If this parameter is <b>NULL</b>, the information is copied into the Win.ini
///             file. If the file was created using Unicode characters, the function writes Unicode characters to the file.
///             Otherwise, the function writes ANSI characters.
///Returns:
///    If the function successfully copies the string to the initialization file, the return value is nonzero. If the
///    function fails, or if it flushes the cached version of the most recently accessed initialization file, the return
///    value is zero. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL WritePrivateProfileStructA(const(char)* lpszSection, const(char)* lpszKey, char* lpStruct, uint uSizeStruct, 
                                const(char)* szFile);

///Copies data into a key in the specified section of an initialization file. As it copies the data, the function
///calculates a checksum and appends it to the end of the data. The GetPrivateProfileStruct function uses the checksum
///to ensure the integrity of the data. <div class="alert"><b>Note</b> This function is provided only for compatibility
///with 16-bit versions of Windows. Applications should store initialization information in the registry.</div><div>
///</div>
///Params:
///    lpszSection = The name of the section to which the string will be copied. If the section does not exist, it is created. The
///                  name of the section is case independent, the string can be any combination of uppercase and lowercase letters.
///    lpszKey = The name of the key to be associated with a string. If the key does not exist in the specified section, it is
///              created. If this parameter is <b>NULL</b>, the entire section, including all keys and entries within the section,
///              is deleted.
///    lpStruct = The data to be copied. If this parameter is <b>NULL</b>, the key is deleted.
///    uSizeStruct = The size of the buffer pointed to by the <i>lpStruct</i> parameter, in bytes.
///    szFile = The name of the initialization file. If this parameter is <b>NULL</b>, the information is copied into the Win.ini
///             file. If the file was created using Unicode characters, the function writes Unicode characters to the file.
///             Otherwise, the function writes ANSI characters.
///Returns:
///    If the function successfully copies the string to the initialization file, the return value is nonzero. If the
///    function fails, or if it flushes the cached version of the most recently accessed initialization file, the return
///    value is zero. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL WritePrivateProfileStructW(const(wchar)* lpszSection, const(wchar)* lpszKey, char* lpStruct, uint uSizeStruct, 
                                const(wchar)* szFile);

@DllImport("KERNEL32")
BOOL IsBadHugeReadPtr(const(void)* lp, size_t ucb);

@DllImport("KERNEL32")
BOOL IsBadHugeWritePtr(void* lp, size_t ucb);

///Retrieves the NetBIOS name of the local computer. This name is established at system startup, when the system reads
///it from the registry. <b>GetComputerName</b> retrieves only the NetBIOS name of the local computer. To retrieve the
///DNS host name, DNS domain name, or the fully qualified DNS name, call the GetComputerNameEx function. Additional
///information is provided by the IADsADSystemInfo interface. The behavior of this function can be affected if the local
///computer is a node in a cluster. For more information, see ResUtilGetEnvironmentWithNetName and UseNetworkName.
///Params:
///    lpBuffer = A pointer to a buffer that receives the computer name or the cluster virtual server name. The buffer size should
///               be large enough to contain MAX_COMPUTERNAME_LENGTH + 1 characters.
///    nSize = On input, specifies the size of the buffer, in <b>TCHARs</b>. On output, the number of <b>TCHARs</b> copied to
///            the destination buffer, not including the terminating null character. If the buffer is too small, the function
///            fails and GetLastError returns ERROR_BUFFER_OVERFLOW. The <i>lpnSize</i> parameter specifies the size of the
///            buffer required, including the terminating null character.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL GetComputerNameA(const(char)* lpBuffer, uint* nSize);

///Retrieves the NetBIOS name of the local computer. This name is established at system startup, when the system reads
///it from the registry. <b>GetComputerName</b> retrieves only the NetBIOS name of the local computer. To retrieve the
///DNS host name, DNS domain name, or the fully qualified DNS name, call the GetComputerNameEx function. Additional
///information is provided by the IADsADSystemInfo interface. The behavior of this function can be affected if the local
///computer is a node in a cluster. For more information, see ResUtilGetEnvironmentWithNetName and UseNetworkName.
///Params:
///    lpBuffer = A pointer to a buffer that receives the computer name or the cluster virtual server name. The buffer size should
///               be large enough to contain MAX_COMPUTERNAME_LENGTH + 1 characters.
///    nSize = On input, specifies the size of the buffer, in <b>TCHARs</b>. On output, the number of <b>TCHARs</b> copied to
///            the destination buffer, not including the terminating null character. If the buffer is too small, the function
///            fails and GetLastError returns ERROR_BUFFER_OVERFLOW. The <i>lpnSize</i> parameter specifies the size of the
///            buffer required, including the terminating null character.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL GetComputerNameW(const(wchar)* lpBuffer, uint* nSize);

///Converts a DNS-style host name to a NetBIOS-style computer name.
///Params:
///    Hostname = The DNS name. If the DNS name is not a valid, translatable name, the function fails. For more information, see
///               Computer Names.
///    ComputerName = A pointer to a buffer that receives the computer name. The buffer size should be large enough to contain
///                   MAX_COMPUTERNAME_LENGTH + 1 characters.
///    nSize = On input, specifies the size of the buffer, in <b>TCHARs</b>. On output, receives the number of <b>TCHARs</b>
///            copied to the destination buffer, not including the terminating null character. If the buffer is too small, the
///            function fails, GetLastError returns ERROR_MORE_DATA, and <i>nSize</i> receives the required buffer size, not
///            including the terminating null character.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError. Possible values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl>
///    </td> <td width="60%"> The <i>ComputerName</i> buffer is too small. The <i>nSize</i> parameter contains the
///    number of bytes required to receive the name. </td> </tr> </table>
///    
@DllImport("KERNEL32")
BOOL DnsHostnameToComputerNameA(const(char)* Hostname, const(char)* ComputerName, uint* nSize);

///Converts a DNS-style host name to a NetBIOS-style computer name.
///Params:
///    Hostname = The DNS name. If the DNS name is not a valid, translatable name, the function fails. For more information, see
///               Computer Names.
///    ComputerName = A pointer to a buffer that receives the computer name. The buffer size should be large enough to contain
///                   MAX_COMPUTERNAME_LENGTH + 1 characters.
///    nSize = On input, specifies the size of the buffer, in <b>TCHARs</b>. On output, receives the number of <b>TCHARs</b>
///            copied to the destination buffer, not including the terminating null character. If the buffer is too small, the
///            function fails, GetLastError returns ERROR_MORE_DATA, and <i>nSize</i> receives the required buffer size, not
///            including the terminating null character.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError. Possible values include the following. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl>
///    </td> <td width="60%"> The <i>ComputerName</i> buffer is too small. The <i>nSize</i> parameter contains the
///    number of bytes required to receive the name. </td> </tr> </table>
///    
@DllImport("KERNEL32")
BOOL DnsHostnameToComputerNameW(const(wchar)* Hostname, const(wchar)* ComputerName, uint* nSize);

///Retrieves the name of the user associated with the current thread. Use the GetUserNameEx function to retrieve the
///user name in a specified format. Additional information is provided by the IADsADSystemInfo interface.
///Params:
///    lpBuffer = A pointer to the buffer to receive the user's logon name. If this buffer is not large enough to contain the
///               entire user name, the function fails. A buffer size of (UNLEN + 1) characters will hold the maximum length user
///               name including the terminating null character. UNLEN is defined in Lmcons.h.
///    pcbBuffer = On input, this variable specifies the size of the <i>lpBuffer</i> buffer, in <b>TCHARs</b>. On output, the
///                variable receives the number of <b>TCHARs</b> copied to the buffer, including the terminating null character. If
///                <i>lpBuffer</i> is too small, the function fails and GetLastError returns ERROR_INSUFFICIENT_BUFFER. This
///                parameter receives the required buffer size, including the terminating null character.
///Returns:
///    If the function succeeds, the return value is a nonzero value, and the variable pointed to by <i>lpnSize</i>
///    contains the number of <b>TCHARs</b> copied to the buffer specified by <i>lpBuffer</i>, including the terminating
///    null character. If the function fails, the return value is zero. To get extended error information, call
///    GetLastError.
///    
@DllImport("ADVAPI32")
BOOL GetUserNameA(const(char)* lpBuffer, uint* pcbBuffer);

///Retrieves the name of the user associated with the current thread. Use the GetUserNameEx function to retrieve the
///user name in a specified format. Additional information is provided by the IADsADSystemInfo interface.
///Params:
///    lpBuffer = A pointer to the buffer to receive the user's logon name. If this buffer is not large enough to contain the
///               entire user name, the function fails. A buffer size of (UNLEN + 1) characters will hold the maximum length user
///               name including the terminating null character. UNLEN is defined in Lmcons.h.
///    pcbBuffer = On input, this variable specifies the size of the <i>lpBuffer</i> buffer, in <b>TCHARs</b>. On output, the
///                variable receives the number of <b>TCHARs</b> copied to the buffer, including the terminating null character. If
///                <i>lpBuffer</i> is too small, the function fails and GetLastError returns ERROR_INSUFFICIENT_BUFFER. This
///                parameter receives the required buffer size, including the terminating null character.
///Returns:
///    If the function succeeds, the return value is a nonzero value, and the variable pointed to by <i>lpnSize</i>
///    contains the number of <b>TCHARs</b> copied to the buffer specified by <i>lpBuffer</i>, including the terminating
///    null character. If the function fails, the return value is zero. To get extended error information, call
///    GetLastError.
///    
@DllImport("ADVAPI32")
BOOL GetUserNameW(const(wchar)* lpBuffer, uint* pcbBuffer);

@DllImport("ADVAPI32")
BOOL IsTokenUntrusted(HANDLE TokenHandle);

@DllImport("KERNEL32")
HANDLE SetTimerQueueTimer(HANDLE TimerQueue, WAITORTIMERCALLBACK Callback, void* Parameter, uint DueTime, 
                          uint Period, BOOL PreferIo);

@DllImport("KERNEL32")
BOOL CancelTimerQueueTimer(HANDLE TimerQueue, HANDLE Timer);

///Retrieves information about the current hardware profile for the local computer.
///Params:
///    lpHwProfileInfo = A pointer to an HW_PROFILE_INFO structure that receives information about the current hardware profile.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("ADVAPI32")
BOOL GetCurrentHwProfileA(HW_PROFILE_INFOA* lpHwProfileInfo);

///Retrieves information about the current hardware profile for the local computer.
///Params:
///    lpHwProfileInfo = A pointer to an HW_PROFILE_INFO structure that receives information about the current hardware profile.
///Returns:
///    If the function succeeds, the return value is a nonzero value. If the function fails, the return value is zero.
///    To get extended error information, call GetLastError.
///    
@DllImport("ADVAPI32")
BOOL GetCurrentHwProfileW(HW_PROFILE_INFOW* lpHwProfileInfo);

///Compares a set of operating system version requirements to the corresponding values for the currently running version
///of the system.This function is subject to manifest-based behavior. For more information, see the Remarks section.
///**Note:** This function has been deprecated for Windows 10. See [targeting your applications for
///Windows](/windows/win32/sysinfo/targeting-your-application-at-windows-8-1) for more information.
///Params:
///    lpVersionInformation = A pointer to an OSVERSIONINFOEX structure containing the operating system version requirements to compare. The
///                           <i>dwTypeMask</i> parameter indicates the members of this structure that contain information to compare. You must
///                           set the <b>dwOSVersionInfoSize</b> member of this structure to <code>sizeof(OSVERSIONINFOEX)</code>. You must
///                           also specify valid data for the members indicated by <i>dwTypeMask</i>. The function ignores structure members
///                           for which the corresponding <i>dwTypeMask</i> bit is not set.
///    dwTypeMask = A mask that indicates the members of the OSVERSIONINFOEX structure to be tested. This parameter can be one or
///                 more of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                 id="VER_BUILDNUMBER"></a><a id="ver_buildnumber"></a><dl> <dt><b>VER_BUILDNUMBER</b></dt> <dt>0x0000004</dt>
///                 </dl> </td> <td width="60%"> <b>dwBuildNumber</b> </td> </tr> <tr> <td width="40%"><a
///                 id="VER_MAJORVERSION"></a><a id="ver_majorversion"></a><dl> <dt><b>VER_MAJORVERSION</b></dt> <dt>0x0000002</dt>
///                 </dl> </td> <td width="60%"> <b>dwMajorVersion</b> If you are testing the major version, you must also test the
///                 minor version and the service pack major and minor versions. </td> </tr> <tr> <td width="40%"><a
///                 id="VER_MINORVERSION"></a><a id="ver_minorversion"></a><dl> <dt><b>VER_MINORVERSION</b></dt> <dt>0x0000001</dt>
///                 </dl> </td> <td width="60%"> <b>dwMinorVersion</b> </td> </tr> <tr> <td width="40%"><a id="VER_PLATFORMID"></a><a
///                 id="ver_platformid"></a><dl> <dt><b>VER_PLATFORMID</b></dt> <dt>0x0000008</dt> </dl> </td> <td width="60%">
///                 <b>dwPlatformId</b> </td> </tr> <tr> <td width="40%"><a id="VER_SERVICEPACKMAJOR"></a><a
///                 id="ver_servicepackmajor"></a><dl> <dt><b>VER_SERVICEPACKMAJOR</b></dt> <dt>0x0000020</dt> </dl> </td> <td
///                 width="60%"> <b>wServicePackMajor</b> </td> </tr> <tr> <td width="40%"><a id="VER_SERVICEPACKMINOR"></a><a
///                 id="ver_servicepackminor"></a><dl> <dt><b>VER_SERVICEPACKMINOR</b></dt> <dt>0x0000010</dt> </dl> </td> <td
///                 width="60%"> <b>wServicePackMinor</b> </td> </tr> <tr> <td width="40%"><a id="VER_SUITENAME"></a><a
///                 id="ver_suitename"></a><dl> <dt><b>VER_SUITENAME</b></dt> <dt>0x0000040</dt> </dl> </td> <td width="60%">
///                 <b>wSuiteMask</b> </td> </tr> <tr> <td width="40%"><a id="VER_PRODUCT_TYPE"></a><a id="ver_product_type"></a><dl>
///                 <dt><b>VER_PRODUCT_TYPE</b></dt> <dt>0x0000080</dt> </dl> </td> <td width="60%"> <b>wProductType</b> </td> </tr>
///                 </table>
///    dwlConditionMask = The type of comparison to be used for each <b>lpVersionInfo</b> member being compared. To build this value, call
///                       the VerSetConditionMask function or the VER_SET_CONDITION macro once for each OSVERSIONINFOEX member being
///                       compared.
///Returns:
///    If the currently running operating system satisfies the specified requirements, the return value is a nonzero
///    value. If the current system does not satisfy the requirements, the return value is zero and GetLastError returns
///    ERROR_OLD_WIN_VERSION. If the function fails, the return value is zero and GetLastError returns an error code
///    other than ERROR_OLD_WIN_VERSION.
///    
@DllImport("KERNEL32")
BOOL VerifyVersionInfoA(OSVERSIONINFOEXA* lpVersionInformation, uint dwTypeMask, ulong dwlConditionMask);

///Compares a set of operating system version requirements to the corresponding values for the currently running version
///of the system.This function is subject to manifest-based behavior. For more information, see the Remarks section.
///**Note:** This function has been deprecated for Windows 10. See [targeting your applications for
///Windows](/windows/win32/sysinfo/targeting-your-application-at-windows-8-1) for more information.
///Params:
///    lpVersionInformation = A pointer to an OSVERSIONINFOEX structure containing the operating system version requirements to compare. The
///                           <i>dwTypeMask</i> parameter indicates the members of this structure that contain information to compare. You must
///                           set the <b>dwOSVersionInfoSize</b> member of this structure to <code>sizeof(OSVERSIONINFOEX)</code>. You must
///                           also specify valid data for the members indicated by <i>dwTypeMask</i>. The function ignores structure members
///                           for which the corresponding <i>dwTypeMask</i> bit is not set.
///    dwTypeMask = A mask that indicates the members of the OSVERSIONINFOEX structure to be tested. This parameter can be one or
///                 more of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                 id="VER_BUILDNUMBER"></a><a id="ver_buildnumber"></a><dl> <dt><b>VER_BUILDNUMBER</b></dt> <dt>0x0000004</dt>
///                 </dl> </td> <td width="60%"> <b>dwBuildNumber</b> </td> </tr> <tr> <td width="40%"><a
///                 id="VER_MAJORVERSION"></a><a id="ver_majorversion"></a><dl> <dt><b>VER_MAJORVERSION</b></dt> <dt>0x0000002</dt>
///                 </dl> </td> <td width="60%"> <b>dwMajorVersion</b> If you are testing the major version, you must also test the
///                 minor version and the service pack major and minor versions. </td> </tr> <tr> <td width="40%"><a
///                 id="VER_MINORVERSION"></a><a id="ver_minorversion"></a><dl> <dt><b>VER_MINORVERSION</b></dt> <dt>0x0000001</dt>
///                 </dl> </td> <td width="60%"> <b>dwMinorVersion</b> </td> </tr> <tr> <td width="40%"><a id="VER_PLATFORMID"></a><a
///                 id="ver_platformid"></a><dl> <dt><b>VER_PLATFORMID</b></dt> <dt>0x0000008</dt> </dl> </td> <td width="60%">
///                 <b>dwPlatformId</b> </td> </tr> <tr> <td width="40%"><a id="VER_SERVICEPACKMAJOR"></a><a
///                 id="ver_servicepackmajor"></a><dl> <dt><b>VER_SERVICEPACKMAJOR</b></dt> <dt>0x0000020</dt> </dl> </td> <td
///                 width="60%"> <b>wServicePackMajor</b> </td> </tr> <tr> <td width="40%"><a id="VER_SERVICEPACKMINOR"></a><a
///                 id="ver_servicepackminor"></a><dl> <dt><b>VER_SERVICEPACKMINOR</b></dt> <dt>0x0000010</dt> </dl> </td> <td
///                 width="60%"> <b>wServicePackMinor</b> </td> </tr> <tr> <td width="40%"><a id="VER_SUITENAME"></a><a
///                 id="ver_suitename"></a><dl> <dt><b>VER_SUITENAME</b></dt> <dt>0x0000040</dt> </dl> </td> <td width="60%">
///                 <b>wSuiteMask</b> </td> </tr> <tr> <td width="40%"><a id="VER_PRODUCT_TYPE"></a><a id="ver_product_type"></a><dl>
///                 <dt><b>VER_PRODUCT_TYPE</b></dt> <dt>0x0000080</dt> </dl> </td> <td width="60%"> <b>wProductType</b> </td> </tr>
///                 </table>
///    dwlConditionMask = The type of comparison to be used for each <b>lpVersionInfo</b> member being compared. To build this value, call
///                       the VerSetConditionMask function or the VER_SET_CONDITION macro once for each OSVERSIONINFOEX member being
///                       compared.
///Returns:
///    If the currently running operating system satisfies the specified requirements, the return value is a nonzero
///    value. If the current system does not satisfy the requirements, the return value is zero and GetLastError returns
///    ERROR_OLD_WIN_VERSION. If the function fails, the return value is zero and GetLastError returns an error code
///    other than ERROR_OLD_WIN_VERSION.
///    
@DllImport("KERNEL32")
BOOL VerifyVersionInfoW(OSVERSIONINFOEXW* lpVersionInformation, uint dwTypeMask, ulong dwlConditionMask);

///Converts a time in Coordinated Universal Time (UTC) to a specified time zone's corresponding local time.
///Params:
///    lpTimeZoneInformation = A pointer to a TIME_ZONE_INFORMATION structure that specifies the time zone of interest. If <i>lpTimeZone</i> is
///                            <b>NULL</b>, the function uses the currently active time zone.
///    lpUniversalTime = A pointer to a SYSTEMTIME structure that specifies the UTC time to be converted. The function converts this
///                      universal time to the specified time zone's corresponding local time.
///    lpLocalTime = A pointer to a SYSTEMTIME structure that receives the local time.
///Returns:
///    If the function succeeds, the return value is nonzero, and the function sets the members of the SYSTEMTIME
///    structure pointed to by <i>lpLocalTime</i> to the appropriate local time values. If the function fails, the
///    return value is zero. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL SystemTimeToTzSpecificLocalTime(const(TIME_ZONE_INFORMATION)* lpTimeZoneInformation, 
                                     const(SYSTEMTIME)* lpUniversalTime, SYSTEMTIME* lpLocalTime);

///Converts a local time to a time in Coordinated Universal Time (UTC).
///Params:
///    lpTimeZoneInformation = A pointer to a TIME_ZONE_INFORMATION structure that specifies the time zone for the time specified in
///                            <i>lpLocalTime</i>. If <i>lpTimeZoneInformation</i> is <b>NULL</b>, the function uses the currently active time
///                            zone.
///    lpLocalTime = A pointer to a SYSTEMTIME structure that specifies the local time to be converted. The function converts this
///                  time to the corresponding UTC time.
///    lpUniversalTime = A pointer to a SYSTEMTIME structure that receives the UTC time.
///Returns:
///    If the function succeeds, the return value is nonzero, and the function sets the members of the SYSTEMTIME
///    structure pointed to by <i>lpUniversalTime</i> to the appropriate values. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL TzSpecificLocalTimeToSystemTime(const(TIME_ZONE_INFORMATION)* lpTimeZoneInformation, 
                                     const(SYSTEMTIME)* lpLocalTime, SYSTEMTIME* lpUniversalTime);

///Converts a file time to system time format. System time is based on Coordinated Universal Time (UTC).
///Params:
///    lpFileTime = A pointer to a FILETIME structure containing the file time to be converted to system (UTC) date and time format.
///                 This value must be less than 0x8000000000000000. Otherwise, the function fails.
///    lpSystemTime = A pointer to a SYSTEMTIME structure to receive the converted file time.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL FileTimeToSystemTime(const(FILETIME)* lpFileTime, SYSTEMTIME* lpSystemTime);

///Converts a system time to file time format. System time is based on Coordinated Universal Time (UTC).
///Params:
///    lpSystemTime = A pointer to a SYSTEMTIME structure that contains the system time to be converted from UTC to file time format.
///                   The <b>wDayOfWeek</b> member of the SYSTEMTIME structure is ignored.
///    lpFileTime = A pointer to a FILETIME structure to receive the converted system time.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError. > [!NOTE] > A False return value can indicate that the passed
///    SYSTEMTIME structure represents an invalid date. Certain situations, such as the additional day added in a leap
///    year, can result in application logic unexpectedly creating an invalid date. For more information on avoiding
///    these issues, see [leap year
///    readiness](https://techcommunity.microsoft.com/t5/azure-developer-community-blog/it-s-2020-is-your-code-ready-for-leap-day/ba-p/1157279).
///    
@DllImport("KERNEL32")
BOOL SystemTimeToFileTime(const(SYSTEMTIME)* lpSystemTime, FILETIME* lpFileTime);

///Retrieves the current time zone settings. These settings control the translations between Coordinated Universal Time
///(UTC) and local time. To support boundaries for daylight saving time that change from year to year, use the
///GetDynamicTimeZoneInformation or GetTimeZoneInformationForYear function.
///Params:
///    lpTimeZoneInformation = A pointer to a TIME_ZONE_INFORMATION structure to receive the current settings.
///Returns:
///    If the function succeeds, it returns one of the following values. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>TIME_ZONE_ID_UNKNOWN</b></dt> <dt>0</dt> </dl> </td>
///    <td width="60%"> Daylight saving time is not used in the current time zone, because there are no transition dates
///    or automatic adjustment for daylight saving time is disabled. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TIME_ZONE_ID_STANDARD</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The system is operating in the
///    range covered by the <b>StandardDate</b> member of the TIME_ZONE_INFORMATION structure. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>TIME_ZONE_ID_DAYLIGHT</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The system is
///    operating in the range covered by the <b>DaylightDate</b> member of the TIME_ZONE_INFORMATION structure. </td>
///    </tr> </table> If the function fails for other reasons, such as an out of memory error, it returns
///    TIME_ZONE_ID_INVALID. To get extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
uint GetTimeZoneInformation(TIME_ZONE_INFORMATION* lpTimeZoneInformation);

///Sets the current time zone settings. These settings control translations from Coordinated Universal Time (UTC) to
///local time. To support boundaries for daylight saving time that change from year to year, use the
///SetDynamicTimeZoneInformation function.
///Params:
///    lpTimeZoneInformation = A pointer to a TIME_ZONE_INFORMATION structure that contains the new settings.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL SetTimeZoneInformation(const(TIME_ZONE_INFORMATION)* lpTimeZoneInformation);

///Sets the current time zone and dynamic daylight saving time settings. These settings control translations from
///Coordinated Universal Time (UTC) to local time.
///Params:
///    lpTimeZoneInformation = A pointer to a DYNAMIC_TIME_ZONE_INFORMATION structure.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL SetDynamicTimeZoneInformation(const(DYNAMIC_TIME_ZONE_INFORMATION)* lpTimeZoneInformation);

///Retrieves the current time zone and dynamic daylight saving time settings. These settings control the translations
///between Coordinated Universal Time (UTC) and local time.
///Params:
///    pTimeZoneInformation = A pointer to a DYNAMIC_TIME_ZONE_INFORMATION structure.
///Returns:
///    If the function succeeds, it returns one of the following values. <table> <tr> <th>Return code/value</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>TIME_ZONE_ID_UNKNOWN</b></dt> <dt>0</dt> </dl> </td>
///    <td width="60%"> Daylight saving time is not used in the current time zone, because there are no transition
///    dates. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>TIME_ZONE_ID_STANDARD</b></dt> <dt>1</dt> </dl> </td> <td
///    width="60%"> The system is operating in the range covered by the <b>StandardDate</b> member of the
///    DYNAMIC_TIME_ZONE_INFORMATION structure. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>TIME_ZONE_ID_DAYLIGHT</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The system is operating in the
///    range covered by the <b>DaylightDate</b> member of the DYNAMIC_TIME_ZONE_INFORMATION structure. </td> </tr>
///    </table> If the function fails, it returns TIME_ZONE_ID_INVALID. To get extended error information, call
///    GetLastError.
///    
@DllImport("KERNEL32")
uint GetDynamicTimeZoneInformation(DYNAMIC_TIME_ZONE_INFORMATION* pTimeZoneInformation);

///Retrieves the time zone settings for the specified year and time zone. These settings control the translations
///between Coordinated Universal Time (UTC) and local time.
///Params:
///    wYear = The year for which the time zone settings are to be retrieved. The <i>wYear</i> parameter must be a local time
///            value.
///    pdtzi = A pointer to a DYNAMIC_TIME_ZONE_INFORMATION structure that specifies the time zone. To populate this parameter,
///            call EnumDynamicTimeZoneInformation with the index of the time zone you want. If this parameter is <b>NULL</b>,
///            the current time zone is used.
///    ptzi = A pointer to a TIME_ZONE_INFORMATION structure that receives the time zone settings.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("KERNEL32")
BOOL GetTimeZoneInformationForYear(ushort wYear, DYNAMIC_TIME_ZONE_INFORMATION* pdtzi, TIME_ZONE_INFORMATION* ptzi);

///Enumerates DYNAMIC_TIME_ZONE_INFORMATION entries stored in the registry. This information is used to support time
///zones that experience annual boundary changes due to daylight saving time adjustments. Use the information returned
///by this function when calling GetDynamicTimeZoneInformationEffectiveYears to retrieve the specific range of years to
///pass to GetTimeZoneInformationForYear.
///Params:
///    dwIndex = Index value that represents the location of a DYNAMIC_TIME_ZONE_INFORMATION entry.
///    lpTimeZoneInformation = Specifies settings for a time zone and dynamic daylight saving time.
///Returns:
///    This function returns DWORD. Possible return values include: | Value | Description |
///    |-------------------------|---------------------------------------------------| | ERROR_SUCCESS | The operation
///    succeeded. | | ERROR_NO_MORE_ITEMS | No more data is available for the given index. | | ERROR_INVALID_PARAMETER |
///    A parameter is invalid. | | Any other value | The operation failed. |
///    
@DllImport("ADVAPI32")
uint EnumDynamicTimeZoneInformation(const(uint) dwIndex, DYNAMIC_TIME_ZONE_INFORMATION* lpTimeZoneInformation);

///Gets a range, expressed in years, for which a DYNAMIC_TIME_ZONE_INFORMATION has valid entries. Use the returned value
///to identify the specific years to request when calling GetTimeZoneInformationForYear to retrieve time zone
///information for a time zone that experiences annual boundary changes due to daylight saving time adjustments.
///Params:
///    lpTimeZoneInformation = Specifies settings for a time zone and dynamic daylight saving time.
///    FirstYear = The year that marks the beginning of the range to pass to GetTimeZoneInformationForYear.
///    LastYear = The year that marks the end of the range to pass to GetTimeZoneInformationForYear.
///Returns:
///    <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> </dl> </td> <td width="60%"> The operation succeeded. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b> ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The system cannot find the
///    effective years. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One of the parameter values is not valid. </td> </tr> <tr> <td width="40%"> <dl> <dt>Any other
///    value</dt> </dl> </td> <td width="60%"> The operation failed. </td> </tr> </table>
///    
@DllImport("ADVAPI32")
uint GetDynamicTimeZoneInformationEffectiveYears(const(DYNAMIC_TIME_ZONE_INFORMATION)* lpTimeZoneInformation, 
                                                 uint* FirstYear, uint* LastYear);

///Converts a time in Coordinated Universal Time (UTC) with dynamic daylight saving time settings to a specified time
///zone's corresponding local time.
///Params:
///    lpTimeZoneInformation = A pointer to a DYNAMIC_TIME_ZONE_INFORMATION structure that specifies the time zone and dynamic daylight saving
///                            time.
///    lpUniversalTime = A pointer to a SYSTEMTIME structure that specifies the UTC time to be converted. The function converts this
///                      universal time to the specified time zone's corresponding local time.
///    lpLocalTime = A pointer to a SYSTEMTIME structure that receives the local time.
@DllImport("KERNEL32")
BOOL SystemTimeToTzSpecificLocalTimeEx(const(DYNAMIC_TIME_ZONE_INFORMATION)* lpTimeZoneInformation, 
                                       const(SYSTEMTIME)* lpUniversalTime, SYSTEMTIME* lpLocalTime);

///Converts a local time to a time with dynamic daylight saving time settings to Coordinated Universal Time (UTC).
///Params:
///    lpTimeZoneInformation = A pointer to a DYNAMIC_TIME_ZONE_INFORMATION structure that specifies the time zone and dynamic daylight saving
///                            time.
///    lpLocalTime = A pointer to a SYSTEMTIME structure that specifies the local time to be converted. The function converts this
///                  time to the corresponding UTC time.
///    lpUniversalTime = A pointer to a SYSTEMTIME structure that receives the UTC time.
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

///Initializes a CONTEXT structure inside a buffer with the necessary size and alignment, with the option to specify an
///XSTATE compaction mask.
///Params:
///    Buffer = A pointer to a buffer within which to initialize a CONTEXT structure. This parameter can be <b>NULL</b> to
///             determine the buffer size required to hold a context record with the specified <i>ContextFlags</i>.
///    ContextFlags = A value indicating which portions of the <i>Context</i> structure should be initialized. This parameter
///                   influences the size of the initialized <i>Context</i> structure. <div class="alert"><b>Note</b>
///                   <b>CONTEXT_XSTATE</b> is not part of <b>CONTEXT_FULL</b> or <b>CONTEXT_ALL</b>. It must be specified separately
///                   if an XState context is desired.</div> <div> </div>
///    Context = A pointer to a variable which receives the address of the initialized CONTEXT structure within the <i>Buffer</i>.
///              <div class="alert"><b>Note</b> Due to alignment requirements of CONTEXT structures, the value returned in
///              <i>Context</i> may not be at the beginning of the supplied buffer.</div> <div> </div>
///    ContextLength = On input, specifies the length of the buffer pointed to by <i>Buffer</i>, in bytes. If the buffer is not large
///                    enough to contain the specified portions of the CONTEXT, the function fails, GetLastError returns
///                    <b>ERROR_INSUFFICIENT_BUFFER</b>, and <i>ContextLength</i> is set to the required size of the buffer. If the
///                    function fails with an error other than <b>ERROR_INSUFFICIENT_BUFFER</b>, the contents of <i>ContextLength</i>
///                    are undefined.
///    XStateCompactionMask = Supplies the XState compaction mask to use when allocating the <i>Context</i> structure. This parameter is only
///                           used when <b>CONTEXT_XSTATE</b> is supplied to <i>ContextFlags</i> and the system has XState enabled in
///                           compaction mode.
///Returns:
///    This function returns <b>TRUE</b> if successful, otherwise <b>FALSE</b>. To get extended error information, call
///    GetLastError.
///    
@DllImport("KERNEL32")
BOOL InitializeContext2(char* Buffer, uint ContextFlags, CONTEXT** Context, uint* ContextLength, 
                        ulong XStateCompactionMask);

@DllImport("api-ms-win-core-backgroundtask-l1-1-0")
uint RaiseCustomSystemEventTrigger(CUSTOM_SYSTEM_EVENT_TRIGGER_CONFIG* CustomSystemEventTriggerConfig);

///Closes a handle to the specified registry key.
///Params:
///    hKey = A handle to the open key to be closed. The handle must have been opened by the RegCreateKeyEx,
///           RegCreateKeyTransacted, RegOpenKeyEx, RegOpenKeyTransacted, or RegConnectRegistry function.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegCloseKey(HKEY hKey);

///Maps a predefined registry key to the specified registry key.
///Params:
///    hKey = A handle to one of the following predefined keys: <b>HKEY_CLASSES_ROOT</b> <b>HKEY_CURRENT_CONFIG</b>
///           <b>HKEY_CURRENT_USER</b> <b>HKEY_LOCAL_MACHINE</b> <b>HKEY_PERFORMANCE_DATA</b> <b>HKEY_USERS</b>
///    hNewHKey = A handle to an open registry key. This handle is returned by the RegCreateKeyEx or RegOpenKeyEx function. It
///               cannot be one of the predefined keys. The function maps <i>hKey</i> to refer to the <i>hNewHKey</i> key. This
///               affects only the calling process. If <i>hNewHKey</i> is <b>NULL</b>, the function restores the default mapping of
///               the predefined key.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegOverridePredefKey(HKEY hKey, HKEY hNewHKey);

///Retrieves a handle to the <b>HKEY_CLASSES_ROOT</b> key for a specified user. The user is identified by an access
///token. The returned key has a view of the registry that merges the contents of the
///<b>HKEY_LOCAL_MACHINE</b>\Software\Classes key with the contents of the Software\Classes keys in the user's registry
///hive. For more information, see HKEY_CLASSES_ROOT Key.
///Params:
///    hToken = A handle to a primary or impersonation access token that identifies the user of interest. This can be a token
///             handle returned by a call to LogonUser, CreateRestrictedToken, DuplicateToken, DuplicateTokenEx,
///             OpenProcessToken, or OpenThreadToken functions. The handle must have TOKEN_QUERY access. For more information,
///             see Access Rights for Access-Token Objects.
///    dwOptions = This parameter is reserved and must be zero.
///    samDesired = A mask that specifies the desired access rights to the key. The function fails if the security descriptor of the
///                 key does not permit the requested access for the calling process. For more information, see Registry Key Security
///                 and Access Rights.
///    phkResult = A pointer to a variable that receives a handle to the opened key. When you no longer need the returned handle,
///                call the RegCloseKey function to close it.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegOpenUserClassesRoot(HANDLE hToken, uint dwOptions, uint samDesired, HKEY* phkResult);

///Retrieves a handle to the <b>HKEY_CURRENT_USER</b> key for the user the current thread is impersonating.
///Params:
///    samDesired = A mask that specifies the desired access rights to the key. The function fails if the security descriptor of the
///                 key does not permit the requested access for the calling process. For more information, see Registry Key Security
///                 and Access Rights.
///    phkResult = A pointer to a variable that receives a handle to the opened key. When you no longer need the returned handle,
///                call the RegCloseKey function to close it.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegOpenCurrentUser(uint samDesired, HKEY* phkResult);

///Disables handle caching of the predefined registry handle for <b>HKEY_CURRENT_USER</b> for the current process. This
///function does not work on a remote computer. To disables handle caching of all predefined registry handles, use the
///RegDisablePredefinedCacheEx function.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a system
///    error code.
///    
@DllImport("ADVAPI32")
LSTATUS RegDisablePredefinedCache();

///Disables handle caching for all predefined registry handles for the current process.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a system
///    error code.
///    
@DllImport("ADVAPI32")
LSTATUS RegDisablePredefinedCacheEx();

///Establishes a connection to a predefined registry key on another computer.
///Params:
///    lpMachineName = The name of the remote computer. The string has the following form: &
///    hKey = A predefined registry handle. This parameter can be one of the following predefined keys on the remote computer.
///           <b>HKEY_LOCAL_MACHINE</b> <b>HKEY_PERFORMANCE_DATA</b> <b>HKEY_USERS</b>
///    phkResult = A pointer to a variable that receives a key handle identifying the predefined handle on the remote computer.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegConnectRegistryA(const(char)* lpMachineName, HKEY hKey, HKEY* phkResult);

///Establishes a connection to a predefined registry key on another computer.
///Params:
///    lpMachineName = The name of the remote computer. The string has the following form: &
///    hKey = A predefined registry handle. This parameter can be one of the following predefined keys on the remote computer.
///           <b>HKEY_LOCAL_MACHINE</b> <b>HKEY_PERFORMANCE_DATA</b> <b>HKEY_USERS</b>
///    phkResult = A pointer to a variable that receives a key handle identifying the predefined handle on the remote computer.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegConnectRegistryW(const(wchar)* lpMachineName, HKEY hKey, HKEY* phkResult);

@DllImport("ADVAPI32")
LSTATUS RegConnectRegistryExA(const(char)* lpMachineName, HKEY hKey, uint Flags, HKEY* phkResult);

@DllImport("ADVAPI32")
LSTATUS RegConnectRegistryExW(const(wchar)* lpMachineName, HKEY hKey, uint Flags, HKEY* phkResult);

///Creates the specified registry key. If the key already exists in the registry, the function opens it. <div
///class="alert"><b>Note</b> This function is provided only for compatibility with 16-bit versions of Windows.
///Applications should use the RegCreateKeyEx function. However, applications that back up or restore system state
///including system files and registry hives should use the Volume Shadow Copy Service instead of the registry
///functions.</div><div> </div>
///Params:
///    hKey = A handle to an open registry key. The calling process must have KEY_CREATE_SUB_KEY access to the key. For more
///           information, see Registry Key Security and Access Rights. Access for key creation is checked against the security
///           descriptor of the registry key, not the access mask specified when the handle was obtained. Therefore, even if
///           <i>hKey</i> was opened with a <i>samDesired</i> of KEY_READ, it can be used in operations that create keys if
///           allowed by its security descriptor. This handle is returned by the RegCreateKeyEx or RegOpenKeyEx function, or it
///           can be one of the following predefined keys:<dl> <dd><b>HKEY_CLASSES_ROOT</b></dd>
///           <dd><b>HKEY_CURRENT_CONFIG</b></dd> <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd>
///           <dd><b>HKEY_USERS</b></dd> </dl>
///    lpSubKey = The name of a key that this function opens or creates. This key must be a subkey of the key identified by the
///               <i>hKey</i> parameter. For more information on key names, see Structure of the Registry. If <i>hKey</i> is one of
///               the predefined keys, <i>lpSubKey</i> may be <b>NULL</b>. In that case, <i>phkResult</i> receives the same
///               <i>hKey</i> handle passed in to the function.
///    phkResult = A pointer to a variable that receives a handle to the opened or created key. If the key is not one of the
///                predefined registry keys, call the RegCloseKey function after you have finished using the handle.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegCreateKeyA(HKEY hKey, const(char)* lpSubKey, HKEY* phkResult);

///Creates the specified registry key. If the key already exists in the registry, the function opens it. <div
///class="alert"><b>Note</b> This function is provided only for compatibility with 16-bit versions of Windows.
///Applications should use the RegCreateKeyEx function. However, applications that back up or restore system state
///including system files and registry hives should use the Volume Shadow Copy Service instead of the registry
///functions.</div><div> </div>
///Params:
///    hKey = A handle to an open registry key. The calling process must have KEY_CREATE_SUB_KEY access to the key. For more
///           information, see Registry Key Security and Access Rights. Access for key creation is checked against the security
///           descriptor of the registry key, not the access mask specified when the handle was obtained. Therefore, even if
///           <i>hKey</i> was opened with a <i>samDesired</i> of KEY_READ, it can be used in operations that create keys if
///           allowed by its security descriptor. This handle is returned by the RegCreateKeyEx or RegOpenKeyEx function, or it
///           can be one of the following predefined keys:<dl> <dd><b>HKEY_CLASSES_ROOT</b></dd>
///           <dd><b>HKEY_CURRENT_CONFIG</b></dd> <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd>
///           <dd><b>HKEY_USERS</b></dd> </dl>
///    lpSubKey = The name of a key that this function opens or creates. This key must be a subkey of the key identified by the
///               <i>hKey</i> parameter. For more information on key names, see Structure of the Registry. If <i>hKey</i> is one of
///               the predefined keys, <i>lpSubKey</i> may be <b>NULL</b>. In that case, <i>phkResult</i> receives the same
///               <i>hKey</i> handle passed in to the function.
///    phkResult = A pointer to a variable that receives a handle to the opened or created key. If the key is not one of the
///                predefined registry keys, call the RegCloseKey function after you have finished using the handle.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegCreateKeyW(HKEY hKey, const(wchar)* lpSubKey, HKEY* phkResult);

///Creates the specified registry key. If the key already exists, the function opens it. Note that key names are not
///case sensitive. To perform transacted registry operations on a key, call the RegCreateKeyTransacted function.
///Applications that back up or restore system state including system files and registry hives should use the Volume
///Shadow Copy Service instead of the registry functions.
///Params:
///    hKey = A handle to an open registry key. The calling process must have KEY_CREATE_SUB_KEY access to the key. For more
///           information, see Registry Key Security and Access Rights. Access for key creation is checked against the security
///           descriptor of the registry key, not the access mask specified when the handle was obtained. Therefore, even if
///           <i>hKey</i> was opened with a <i>samDesired</i> of KEY_READ, it can be used in operations that modify the
///           registry if allowed by its security descriptor. This handle is returned by the <b>RegCreateKeyEx</b> or
///           RegOpenKeyEx function, or it can be one of the following predefined keys: <dl> <dd><b>HKEY_CLASSES_ROOT</b></dd>
///           <dd><b>HKEY_CURRENT_CONFIG</b></dd> <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd>
///           <dd><b>HKEY_USERS</b></dd> </dl>
///    lpSubKey = The name of a subkey that this function opens or creates. The subkey specified must be a subkey of the key
///               identified by the <i>hKey</i> parameter; it can be up to 32 levels deep in the registry tree. For more
///               information on key names, see Structure of the Registry. If <i>lpSubKey</i> is a pointer to an empty string,
///               <i>phkResult</i> receives a new handle to the key specified by <i>hKey</i>. This parameter cannot be <b>NULL</b>.
///    Reserved = This parameter is reserved and must be zero.
///    lpClass = The user-defined class type of this key. This parameter may be ignored. This parameter can be <b>NULL</b>.
///    dwOptions = This parameter can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                width="40%"><a id="REG_OPTION_BACKUP_RESTORE"></a><a id="reg_option_backup_restore"></a><dl>
///                <dt><b>REG_OPTION_BACKUP_RESTORE</b></dt> <dt>0x00000004L</dt> </dl> </td> <td width="60%"> If this flag is set,
///                the function ignores the <i>samDesired</i> parameter and attempts to open the key with the access required to
///                backup or restore the key. If the calling thread has the SE_BACKUP_NAME privilege enabled, the key is opened with
///                the ACCESS_SYSTEM_SECURITY and KEY_READ access rights. If the calling thread has the SE_RESTORE_NAME privilege
///                enabled, beginning with Windows Vista, the key is opened with the ACCESS_SYSTEM_SECURITY, DELETE and KEY_WRITE
///                access rights. If both privileges are enabled, the key has the combined access rights for both privileges. For
///                more information, see Running with Special Privileges. </td> </tr> <tr> <td width="40%"><a
///                id="REG_OPTION_CREATE_LINK"></a><a id="reg_option_create_link"></a><dl> <dt><b>REG_OPTION_CREATE_LINK</b></dt>
///                <dt>0x00000002L</dt> </dl> </td> <td width="60%"> <div class="alert"><b>Note</b> Registry symbolic links should
///                only be used for for application compatibility when <u>absolutely</u> necessary. </div> <div> </div> This key is
///                a symbolic link. The target path is assigned to the L"SymbolicLinkValue" value of the key. The target path must
///                be an absolute registry path. </td> </tr> <tr> <td width="40%"><a id="REG_OPTION_NON_VOLATILE"></a><a
///                id="reg_option_non_volatile"></a><dl> <dt><b>REG_OPTION_NON_VOLATILE</b></dt> <dt>0x00000000L</dt> </dl> </td>
///                <td width="60%"> This key is not volatile; this is the default. The information is stored in a file and is
///                preserved when the system is restarted. The RegSaveKey function saves keys that are not volatile. </td> </tr>
///                <tr> <td width="40%"><a id="REG_OPTION_VOLATILE"></a><a id="reg_option_volatile"></a><dl>
///                <dt><b>REG_OPTION_VOLATILE</b></dt> <dt>0x00000001L</dt> </dl> </td> <td width="60%"> All keys created by the
///                function are volatile. The information is stored in memory and is not preserved when the corresponding registry
///                hive is unloaded. For <b>HKEY_LOCAL_MACHINE</b>, this occurs only when the system initiates a full shutdown. For
///                registry keys loaded by the RegLoadKey function, this occurs when the corresponding RegUnLoadKey is performed.
///                The RegSaveKey function does not save volatile keys. This flag is ignored for keys that already exist. <div
///                class="alert"><b>Note</b> On a user selected shutdown, a fast startup shutdown is the default behavior for the
///                system.</div> <div> </div> </td> </tr> </table>
///    samDesired = A mask that specifies the access rights for the key to be created. For more information, see Registry Key
///                 Security and Access Rights.
///    lpSecurityAttributes = A pointer to a SECURITY_ATTRIBUTES structure that determines whether the returned handle can be inherited by
///                           child processes. If <i>lpSecurityAttributes</i> is <b>NULL</b>, the handle cannot be inherited. The
///                           <b>lpSecurityDescriptor</b> member of the structure specifies a security descriptor for the new key. If
///                           <i>lpSecurityAttributes</i> is <b>NULL</b>, the key gets a default security descriptor. The ACLs in a default
///                           security descriptor for a key are inherited from its direct parent key.
///    phkResult = A pointer to a variable that receives a handle to the opened or created key. If the key is not one of the
///                predefined registry keys, call the RegCloseKey function after you have finished using the handle.
///    lpdwDisposition = A pointer to a variable that receives one of the following disposition values. <table> <tr> <th>Value</th>
///                      <th>Meaning</th> </tr> <tr> <td width="40%"><a id="REG_CREATED_NEW_KEY"></a><a id="reg_created_new_key"></a><dl>
///                      <dt><b>REG_CREATED_NEW_KEY</b></dt> <dt>0x00000001L</dt> </dl> </td> <td width="60%"> The key did not exist and
///                      was created. </td> </tr> <tr> <td width="40%"><a id="REG_OPENED_EXISTING_KEY"></a><a
///                      id="reg_opened_existing_key"></a><dl> <dt><b>REG_OPENED_EXISTING_KEY</b></dt> <dt>0x00000002L</dt> </dl> </td>
///                      <td width="60%"> The key existed and was simply opened without being changed. </td> </tr> </table> If
///                      <i>lpdwDisposition</i> is <b>NULL</b>, no disposition information is returned.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegCreateKeyExA(HKEY hKey, const(char)* lpSubKey, uint Reserved, const(char)* lpClass, uint dwOptions, 
                        uint samDesired, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes, HKEY* phkResult, 
                        uint* lpdwDisposition);

///Creates the specified registry key. If the key already exists, the function opens it. Note that key names are not
///case sensitive. To perform transacted registry operations on a key, call the RegCreateKeyTransacted function.
///Applications that back up or restore system state including system files and registry hives should use the Volume
///Shadow Copy Service instead of the registry functions.
///Params:
///    hKey = A handle to an open registry key. The calling process must have KEY_CREATE_SUB_KEY access to the key. For more
///           information, see Registry Key Security and Access Rights. Access for key creation is checked against the security
///           descriptor of the registry key, not the access mask specified when the handle was obtained. Therefore, even if
///           <i>hKey</i> was opened with a <i>samDesired</i> of KEY_READ, it can be used in operations that modify the
///           registry if allowed by its security descriptor. This handle is returned by the <b>RegCreateKeyEx</b> or
///           RegOpenKeyEx function, or it can be one of the following predefined keys: <dl> <dd><b>HKEY_CLASSES_ROOT</b></dd>
///           <dd><b>HKEY_CURRENT_CONFIG</b></dd> <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd>
///           <dd><b>HKEY_USERS</b></dd> </dl>
///    lpSubKey = The name of a subkey that this function opens or creates. The subkey specified must be a subkey of the key
///               identified by the <i>hKey</i> parameter; it can be up to 32 levels deep in the registry tree. For more
///               information on key names, see Structure of the Registry. If <i>lpSubKey</i> is a pointer to an empty string,
///               <i>phkResult</i> receives a new handle to the key specified by <i>hKey</i>. This parameter cannot be <b>NULL</b>.
///    Reserved = This parameter is reserved and must be zero.
///    lpClass = The user-defined class type of this key. This parameter may be ignored. This parameter can be <b>NULL</b>.
///    dwOptions = This parameter can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                width="40%"><a id="REG_OPTION_BACKUP_RESTORE"></a><a id="reg_option_backup_restore"></a><dl>
///                <dt><b>REG_OPTION_BACKUP_RESTORE</b></dt> <dt>0x00000004L</dt> </dl> </td> <td width="60%"> If this flag is set,
///                the function ignores the <i>samDesired</i> parameter and attempts to open the key with the access required to
///                backup or restore the key. If the calling thread has the SE_BACKUP_NAME privilege enabled, the key is opened with
///                the ACCESS_SYSTEM_SECURITY and KEY_READ access rights. If the calling thread has the SE_RESTORE_NAME privilege
///                enabled, beginning with Windows Vista, the key is opened with the ACCESS_SYSTEM_SECURITY, DELETE and KEY_WRITE
///                access rights. If both privileges are enabled, the key has the combined access rights for both privileges. For
///                more information, see Running with Special Privileges. </td> </tr> <tr> <td width="40%"><a
///                id="REG_OPTION_CREATE_LINK"></a><a id="reg_option_create_link"></a><dl> <dt><b>REG_OPTION_CREATE_LINK</b></dt>
///                <dt>0x00000002L</dt> </dl> </td> <td width="60%"> <div class="alert"><b>Note</b> Registry symbolic links should
///                only be used for for application compatibility when <u>absolutely</u> necessary. </div> <div> </div> This key is
///                a symbolic link. The target path is assigned to the L"SymbolicLinkValue" value of the key. The target path must
///                be an absolute registry path. </td> </tr> <tr> <td width="40%"><a id="REG_OPTION_NON_VOLATILE"></a><a
///                id="reg_option_non_volatile"></a><dl> <dt><b>REG_OPTION_NON_VOLATILE</b></dt> <dt>0x00000000L</dt> </dl> </td>
///                <td width="60%"> This key is not volatile; this is the default. The information is stored in a file and is
///                preserved when the system is restarted. The RegSaveKey function saves keys that are not volatile. </td> </tr>
///                <tr> <td width="40%"><a id="REG_OPTION_VOLATILE"></a><a id="reg_option_volatile"></a><dl>
///                <dt><b>REG_OPTION_VOLATILE</b></dt> <dt>0x00000001L</dt> </dl> </td> <td width="60%"> All keys created by the
///                function are volatile. The information is stored in memory and is not preserved when the corresponding registry
///                hive is unloaded. For <b>HKEY_LOCAL_MACHINE</b>, this occurs only when the system initiates a full shutdown. For
///                registry keys loaded by the RegLoadKey function, this occurs when the corresponding RegUnLoadKey is performed.
///                The RegSaveKey function does not save volatile keys. This flag is ignored for keys that already exist. <div
///                class="alert"><b>Note</b> On a user selected shutdown, a fast startup shutdown is the default behavior for the
///                system.</div> <div> </div> </td> </tr> </table>
///    samDesired = A mask that specifies the access rights for the key to be created. For more information, see Registry Key
///                 Security and Access Rights.
///    lpSecurityAttributes = A pointer to a SECURITY_ATTRIBUTES structure that determines whether the returned handle can be inherited by
///                           child processes. If <i>lpSecurityAttributes</i> is <b>NULL</b>, the handle cannot be inherited. The
///                           <b>lpSecurityDescriptor</b> member of the structure specifies a security descriptor for the new key. If
///                           <i>lpSecurityAttributes</i> is <b>NULL</b>, the key gets a default security descriptor. The ACLs in a default
///                           security descriptor for a key are inherited from its direct parent key.
///    phkResult = A pointer to a variable that receives a handle to the opened or created key. If the key is not one of the
///                predefined registry keys, call the RegCloseKey function after you have finished using the handle.
///    lpdwDisposition = A pointer to a variable that receives one of the following disposition values. <table> <tr> <th>Value</th>
///                      <th>Meaning</th> </tr> <tr> <td width="40%"><a id="REG_CREATED_NEW_KEY"></a><a id="reg_created_new_key"></a><dl>
///                      <dt><b>REG_CREATED_NEW_KEY</b></dt> <dt>0x00000001L</dt> </dl> </td> <td width="60%"> The key did not exist and
///                      was created. </td> </tr> <tr> <td width="40%"><a id="REG_OPENED_EXISTING_KEY"></a><a
///                      id="reg_opened_existing_key"></a><dl> <dt><b>REG_OPENED_EXISTING_KEY</b></dt> <dt>0x00000002L</dt> </dl> </td>
///                      <td width="60%"> The key existed and was simply opened without being changed. </td> </tr> </table> If
///                      <i>lpdwDisposition</i> is <b>NULL</b>, no disposition information is returned.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegCreateKeyExW(HKEY hKey, const(wchar)* lpSubKey, uint Reserved, const(wchar)* lpClass, uint dwOptions, 
                        uint samDesired, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes, HKEY* phkResult, 
                        uint* lpdwDisposition);

///Creates the specified registry key and associates it with a transaction. If the key already exists, the function
///opens it. Note that key names are not case sensitive. Applications that back up or restore system state including
///system files and registry hives should use the Volume Shadow Copy Service instead of the registry functions.
///Params:
///    hKey = A handle to an open registry key. The calling process must have KEY_CREATE_SUB_KEY access to the key. For more
///           information, see Registry Key Security and Access Rights. Access for key creation is checked against the security
///           descriptor of the registry key, not the access mask specified when the handle was obtained. Therefore, even if
///           <i>hKey</i> was opened with a <i>samDesired</i> of KEY_READ, it can be used in operations that create keys if
///           allowed by its security descriptor. This handle is returned by the <b>RegCreateKeyTransacted</b> or
///           RegOpenKeyTransacted function, or it can be one of the following predefined keys: <dl>
///           <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd> <dd><b>HKEY_CURRENT_USER</b></dd>
///           <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_USERS</b></dd> </dl>
///    lpSubKey = The name of a subkey that this function opens or creates. The subkey specified must be a subkey of the key
///               identified by the <i>hKey</i> parameter; it can be up to 32 levels deep in the registry tree. For more
///               information on key names, see Structure of the Registry. If <i>lpSubKey</i> is a pointer to an empty string,
///               <i>phkResult</i> receives a new handle to the key specified by <i>hKey</i>. This parameter cannot be <b>NULL</b>.
///    Reserved = This parameter is reserved and must be zero.
///    lpClass = The user-defined class of this key. This parameter may be ignored. This parameter can be <b>NULL</b>.
///    dwOptions = This parameter can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                width="40%"><a id="REG_OPTION_BACKUP_RESTORE"></a><a id="reg_option_backup_restore"></a><dl>
///                <dt><b>REG_OPTION_BACKUP_RESTORE</b></dt> <dt>0x00000004L</dt> </dl> </td> <td width="60%"> If this flag is set,
///                the function ignores the <i>samDesired</i> parameter and attempts to open the key with the access required to
///                backup or restore the key. If the calling thread has the SE_BACKUP_NAME privilege enabled, the key is opened with
///                the ACCESS_SYSTEM_SECURITY and KEY_READ access rights. If the calling thread has the SE_RESTORE_NAME privilege
///                enabled, the key is opened with the ACCESS_SYSTEM_SECURITY and KEY_WRITE access rights. If both privileges are
///                enabled, the key has the combined access rights for both privileges. For more information, see Running with
///                Special Privileges. </td> </tr> <tr> <td width="40%"><a id="REG_OPTION_NON_VOLATILE"></a><a
///                id="reg_option_non_volatile"></a><dl> <dt><b>REG_OPTION_NON_VOLATILE</b></dt> <dt>0x00000000L</dt> </dl> </td>
///                <td width="60%"> This key is not volatile; this is the default. The information is stored in a file and is
///                preserved when the system is restarted. The RegSaveKey function saves keys that are not volatile. </td> </tr>
///                <tr> <td width="40%"><a id="REG_OPTION_VOLATILE"></a><a id="reg_option_volatile"></a><dl>
///                <dt><b>REG_OPTION_VOLATILE</b></dt> <dt>0x00000001L</dt> </dl> </td> <td width="60%"> All keys created by the
///                function are volatile. The information is stored in memory and is not preserved when the corresponding registry
///                hive is unloaded. For <b>HKEY_LOCAL_MACHINE</b>, this occurs when the system is shut down. For registry keys
///                loaded by the RegLoadKey function, this occurs when the corresponding RegUnLoadKey is performed. The RegSaveKey
///                function does not save volatile keys. This flag is ignored for keys that already exist. </td> </tr> </table>
///    samDesired = A mask that specifies the access rights for the key to be created. For more information, see Registry Key
///                 Security and Access Rights.
///    lpSecurityAttributes = A pointer to a SECURITY_ATTRIBUTES structure that determines whether the returned handle can be inherited by
///                           child processes. If <i>lpSecurityAttributes</i> is <b>NULL</b>, the handle cannot be inherited. The
///                           <b>lpSecurityDescriptor</b> member of the structure specifies a security descriptor for the new key. If
///                           <i>lpSecurityAttributes</i> is <b>NULL</b>, the key gets a default security descriptor. The ACLs in a default
///                           security descriptor for a key are inherited from its direct parent key.
///    phkResult = A pointer to a variable that receives a handle to the opened or created key. If the key is not one of the
///                predefined registry keys, call the RegCloseKey function after you have finished using the handle.
///    lpdwDisposition = A pointer to a variable that receives one of the following disposition values. <table> <tr> <th>Value</th>
///                      <th>Meaning</th> </tr> <tr> <td width="40%"><a id="REG_CREATED_NEW_KEY"></a><a id="reg_created_new_key"></a><dl>
///                      <dt><b>REG_CREATED_NEW_KEY</b></dt> <dt>0x00000001L</dt> </dl> </td> <td width="60%"> The key did not exist and
///                      was created. </td> </tr> <tr> <td width="40%"><a id="REG_OPENED_EXISTING_KEY"></a><a
///                      id="reg_opened_existing_key"></a><dl> <dt><b>REG_OPENED_EXISTING_KEY</b></dt> <dt>0x00000002L</dt> </dl> </td>
///                      <td width="60%"> The key existed and was simply opened without being changed. </td> </tr> </table> If
///                      <i>lpdwDisposition</i> is <b>NULL</b>, no disposition information is returned.
///    hTransaction = A handle to an active transaction. This handle is returned by the CreateTransaction function.
///    pExtendedParemeter = This parameter is reserved and must be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegCreateKeyTransactedA(HKEY hKey, const(char)* lpSubKey, uint Reserved, const(char)* lpClass, 
                                uint dwOptions, uint samDesired, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes, 
                                HKEY* phkResult, uint* lpdwDisposition, HANDLE hTransaction, 
                                void* pExtendedParemeter);

///Creates the specified registry key and associates it with a transaction. If the key already exists, the function
///opens it. Note that key names are not case sensitive. Applications that back up or restore system state including
///system files and registry hives should use the Volume Shadow Copy Service instead of the registry functions.
///Params:
///    hKey = A handle to an open registry key. The calling process must have KEY_CREATE_SUB_KEY access to the key. For more
///           information, see Registry Key Security and Access Rights. Access for key creation is checked against the security
///           descriptor of the registry key, not the access mask specified when the handle was obtained. Therefore, even if
///           <i>hKey</i> was opened with a <i>samDesired</i> of KEY_READ, it can be used in operations that create keys if
///           allowed by its security descriptor. This handle is returned by the <b>RegCreateKeyTransacted</b> or
///           RegOpenKeyTransacted function, or it can be one of the following predefined keys: <dl>
///           <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd> <dd><b>HKEY_CURRENT_USER</b></dd>
///           <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_USERS</b></dd> </dl>
///    lpSubKey = The name of a subkey that this function opens or creates. The subkey specified must be a subkey of the key
///               identified by the <i>hKey</i> parameter; it can be up to 32 levels deep in the registry tree. For more
///               information on key names, see Structure of the Registry. If <i>lpSubKey</i> is a pointer to an empty string,
///               <i>phkResult</i> receives a new handle to the key specified by <i>hKey</i>. This parameter cannot be <b>NULL</b>.
///    Reserved = This parameter is reserved and must be zero.
///    lpClass = The user-defined class of this key. This parameter may be ignored. This parameter can be <b>NULL</b>.
///    dwOptions = This parameter can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                width="40%"><a id="REG_OPTION_BACKUP_RESTORE"></a><a id="reg_option_backup_restore"></a><dl>
///                <dt><b>REG_OPTION_BACKUP_RESTORE</b></dt> <dt>0x00000004L</dt> </dl> </td> <td width="60%"> If this flag is set,
///                the function ignores the <i>samDesired</i> parameter and attempts to open the key with the access required to
///                backup or restore the key. If the calling thread has the SE_BACKUP_NAME privilege enabled, the key is opened with
///                the ACCESS_SYSTEM_SECURITY and KEY_READ access rights. If the calling thread has the SE_RESTORE_NAME privilege
///                enabled, the key is opened with the ACCESS_SYSTEM_SECURITY and KEY_WRITE access rights. If both privileges are
///                enabled, the key has the combined access rights for both privileges. For more information, see Running with
///                Special Privileges. </td> </tr> <tr> <td width="40%"><a id="REG_OPTION_NON_VOLATILE"></a><a
///                id="reg_option_non_volatile"></a><dl> <dt><b>REG_OPTION_NON_VOLATILE</b></dt> <dt>0x00000000L</dt> </dl> </td>
///                <td width="60%"> This key is not volatile; this is the default. The information is stored in a file and is
///                preserved when the system is restarted. The RegSaveKey function saves keys that are not volatile. </td> </tr>
///                <tr> <td width="40%"><a id="REG_OPTION_VOLATILE"></a><a id="reg_option_volatile"></a><dl>
///                <dt><b>REG_OPTION_VOLATILE</b></dt> <dt>0x00000001L</dt> </dl> </td> <td width="60%"> All keys created by the
///                function are volatile. The information is stored in memory and is not preserved when the corresponding registry
///                hive is unloaded. For <b>HKEY_LOCAL_MACHINE</b>, this occurs when the system is shut down. For registry keys
///                loaded by the RegLoadKey function, this occurs when the corresponding RegUnLoadKey is performed. The RegSaveKey
///                function does not save volatile keys. This flag is ignored for keys that already exist. </td> </tr> </table>
///    samDesired = A mask that specifies the access rights for the key to be created. For more information, see Registry Key
///                 Security and Access Rights.
///    lpSecurityAttributes = A pointer to a SECURITY_ATTRIBUTES structure that determines whether the returned handle can be inherited by
///                           child processes. If <i>lpSecurityAttributes</i> is <b>NULL</b>, the handle cannot be inherited. The
///                           <b>lpSecurityDescriptor</b> member of the structure specifies a security descriptor for the new key. If
///                           <i>lpSecurityAttributes</i> is <b>NULL</b>, the key gets a default security descriptor. The ACLs in a default
///                           security descriptor for a key are inherited from its direct parent key.
///    phkResult = A pointer to a variable that receives a handle to the opened or created key. If the key is not one of the
///                predefined registry keys, call the RegCloseKey function after you have finished using the handle.
///    lpdwDisposition = A pointer to a variable that receives one of the following disposition values. <table> <tr> <th>Value</th>
///                      <th>Meaning</th> </tr> <tr> <td width="40%"><a id="REG_CREATED_NEW_KEY"></a><a id="reg_created_new_key"></a><dl>
///                      <dt><b>REG_CREATED_NEW_KEY</b></dt> <dt>0x00000001L</dt> </dl> </td> <td width="60%"> The key did not exist and
///                      was created. </td> </tr> <tr> <td width="40%"><a id="REG_OPENED_EXISTING_KEY"></a><a
///                      id="reg_opened_existing_key"></a><dl> <dt><b>REG_OPENED_EXISTING_KEY</b></dt> <dt>0x00000002L</dt> </dl> </td>
///                      <td width="60%"> The key existed and was simply opened without being changed. </td> </tr> </table> If
///                      <i>lpdwDisposition</i> is <b>NULL</b>, no disposition information is returned.
///    hTransaction = A handle to an active transaction. This handle is returned by the CreateTransaction function.
///    pExtendedParemeter = This parameter is reserved and must be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegCreateKeyTransactedW(HKEY hKey, const(wchar)* lpSubKey, uint Reserved, const(wchar)* lpClass, 
                                uint dwOptions, uint samDesired, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes, 
                                HKEY* phkResult, uint* lpdwDisposition, HANDLE hTransaction, 
                                void* pExtendedParemeter);

///Deletes a subkey and its values. Note that key names are not case sensitive. <b>64-bit Windows: </b>On WOW64, 32-bit
///applications view a registry tree that is separate from the registry tree that 64-bit applications view. To enable an
///application to delete an entry in the alternate registry view, use the RegDeleteKeyEx function.
///Params:
///    hKey = A handle to an open registry key. The access rights of this key do not affect the delete operation. For more
///           information about access rights, see Registry Key Security and Access Rights. This handle is returned by the
///           RegCreateKeyEx or RegOpenKeyEx function, or it can be one of the following Predefined Keys:<dl>
///           <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd> <dd><b>HKEY_CURRENT_USER</b></dd>
///           <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_USERS</b></dd> </dl>
///    lpSubKey = The name of the key to be deleted. It must be a subkey of the key that <i>hKey</i> identifies, but it cannot have
///               subkeys. This parameter cannot be <b>NULL</b>. The function opens the subkey with the DELETE access right. Key
///               names are not case sensitive. For more information, see Registry Element Size Limits.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. To get a generic description of the error, you can use the FormatMessage
///    function with the FORMAT_MESSAGE_FROM_SYSTEM flag.
///    
@DllImport("ADVAPI32")
LSTATUS RegDeleteKeyA(HKEY hKey, const(char)* lpSubKey);

///Deletes a subkey and its values. Note that key names are not case sensitive. <b>64-bit Windows: </b>On WOW64, 32-bit
///applications view a registry tree that is separate from the registry tree that 64-bit applications view. To enable an
///application to delete an entry in the alternate registry view, use the RegDeleteKeyEx function.
///Params:
///    hKey = A handle to an open registry key. The access rights of this key do not affect the delete operation. For more
///           information about access rights, see Registry Key Security and Access Rights. This handle is returned by the
///           RegCreateKeyEx or RegOpenKeyEx function, or it can be one of the following Predefined Keys:<dl>
///           <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd> <dd><b>HKEY_CURRENT_USER</b></dd>
///           <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_USERS</b></dd> </dl>
///    lpSubKey = The name of the key to be deleted. It must be a subkey of the key that <i>hKey</i> identifies, but it cannot have
///               subkeys. This parameter cannot be <b>NULL</b>. The function opens the subkey with the DELETE access right. Key
///               names are not case sensitive. For more information, see Registry Element Size Limits.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. To get a generic description of the error, you can use the FormatMessage
///    function with the FORMAT_MESSAGE_FROM_SYSTEM flag.
///    
@DllImport("ADVAPI32")
LSTATUS RegDeleteKeyW(HKEY hKey, const(wchar)* lpSubKey);

///Deletes a subkey and its values from the specified platform-specific view of the registry. Note that key names are
///not case sensitive. To delete a subkey as a transacted operation, call the RegDeleteKeyTransacted function.
///Params:
///    hKey = A handle to an open registry key. The access rights of this key do not affect the delete operation. For more
///           information about access rights, see Registry Key Security and Access Rights. This handle is returned by the
///           RegCreateKeyEx or RegOpenKeyEx function, or it can be one of the following predefined keys:<dl>
///           <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd> <dd><b>HKEY_CURRENT_USER</b></dd>
///           <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_USERS</b></dd> </dl>
///    lpSubKey = The name of the key to be deleted. This key must be a subkey of the key specified by the value of the <i>hKey</i>
///               parameter. The function opens the subkey with the DELETE access right. Key names are not case sensitive. The
///               value of this parameter cannot be <b>NULL</b>.
///    samDesired = An access mask the specifies the platform-specific view of the registry. <table> <tr> <th>Value</th>
///                 <th>Meaning</th> </tr> <tr> <td width="40%"><a id="KEY_WOW64_32KEY"></a><a id="key_wow64_32key"></a><dl>
///                 <dt><b>KEY_WOW64_32KEY</b></dt> <dt>0x0200</dt> </dl> </td> <td width="60%"> Delete the key from the 32-bit
///                 registry view. </td> </tr> <tr> <td width="40%"><a id="KEY_WOW64_64KEY"></a><a id="key_wow64_64key"></a><dl>
///                 <dt><b>KEY_WOW64_64KEY</b></dt> <dt>0x0100</dt> </dl> </td> <td width="60%"> Delete the key from the 64-bit
///                 registry view. </td> </tr> </table>
///    Reserved = This parameter is reserved and must be zero.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegDeleteKeyExA(HKEY hKey, const(char)* lpSubKey, uint samDesired, uint Reserved);

///Deletes a subkey and its values from the specified platform-specific view of the registry. Note that key names are
///not case sensitive. To delete a subkey as a transacted operation, call the RegDeleteKeyTransacted function.
///Params:
///    hKey = A handle to an open registry key. The access rights of this key do not affect the delete operation. For more
///           information about access rights, see Registry Key Security and Access Rights. This handle is returned by the
///           RegCreateKeyEx or RegOpenKeyEx function, or it can be one of the following predefined keys:<dl>
///           <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd> <dd><b>HKEY_CURRENT_USER</b></dd>
///           <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_USERS</b></dd> </dl>
///    lpSubKey = The name of the key to be deleted. This key must be a subkey of the key specified by the value of the <i>hKey</i>
///               parameter. The function opens the subkey with the DELETE access right. Key names are not case sensitive. The
///               value of this parameter cannot be <b>NULL</b>.
///    samDesired = An access mask the specifies the platform-specific view of the registry. <table> <tr> <th>Value</th>
///                 <th>Meaning</th> </tr> <tr> <td width="40%"><a id="KEY_WOW64_32KEY"></a><a id="key_wow64_32key"></a><dl>
///                 <dt><b>KEY_WOW64_32KEY</b></dt> <dt>0x0200</dt> </dl> </td> <td width="60%"> Delete the key from the 32-bit
///                 registry view. </td> </tr> <tr> <td width="40%"><a id="KEY_WOW64_64KEY"></a><a id="key_wow64_64key"></a><dl>
///                 <dt><b>KEY_WOW64_64KEY</b></dt> <dt>0x0100</dt> </dl> </td> <td width="60%"> Delete the key from the 64-bit
///                 registry view. </td> </tr> </table>
///    Reserved = This parameter is reserved and must be zero.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegDeleteKeyExW(HKEY hKey, const(wchar)* lpSubKey, uint samDesired, uint Reserved);

///Deletes a subkey and its values from the specified platform-specific view of the registry as a transacted operation.
///Note that key names are not case sensitive.
///Params:
///    hKey = A handle to an open registry key. The access rights of this key do not affect the delete operation. For more
///           information about access rights, see Registry Key Security and Access Rights. This handle is returned by the
///           RegCreateKeyEx, RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function. It can also be one of the
///           following predefined keys:<dl> <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd>
///           <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_USERS</b></dd> </dl>
///    lpSubKey = The name of the key to be deleted. This key must be a subkey of the key specified by the value of the <i>hKey</i>
///               parameter. The function opens the subkey with the DELETE access right. Key names are not case sensitive. The
///               value of this parameter cannot be <b>NULL</b>.
///    samDesired = An access mask the specifies the platform-specific view of the registry. <table> <tr> <th>Value</th>
///                 <th>Meaning</th> </tr> <tr> <td width="40%"><a id="KEY_WOW64_32KEY"></a><a id="key_wow64_32key"></a><dl>
///                 <dt><b>KEY_WOW64_32KEY</b></dt> <dt>0x0200</dt> </dl> </td> <td width="60%"> Delete the key from the 32-bit
///                 registry view. </td> </tr> <tr> <td width="40%"><a id="KEY_WOW64_64KEY"></a><a id="key_wow64_64key"></a><dl>
///                 <dt><b>KEY_WOW64_64KEY</b></dt> <dt>0x0100</dt> </dl> </td> <td width="60%"> Delete the key from the 64-bit
///                 registry view. </td> </tr> </table>
///    Reserved = This parameter is reserved and must be zero.
///    hTransaction = A handle to an active transaction. This handle is returned by the CreateTransaction function.
///    pExtendedParameter = This parameter is reserved and must be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegDeleteKeyTransactedA(HKEY hKey, const(char)* lpSubKey, uint samDesired, uint Reserved, 
                                HANDLE hTransaction, void* pExtendedParameter);

///Deletes a subkey and its values from the specified platform-specific view of the registry as a transacted operation.
///Note that key names are not case sensitive.
///Params:
///    hKey = A handle to an open registry key. The access rights of this key do not affect the delete operation. For more
///           information about access rights, see Registry Key Security and Access Rights. This handle is returned by the
///           RegCreateKeyEx, RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function. It can also be one of the
///           following predefined keys:<dl> <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd>
///           <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_USERS</b></dd> </dl>
///    lpSubKey = The name of the key to be deleted. This key must be a subkey of the key specified by the value of the <i>hKey</i>
///               parameter. The function opens the subkey with the DELETE access right. Key names are not case sensitive. The
///               value of this parameter cannot be <b>NULL</b>.
///    samDesired = An access mask the specifies the platform-specific view of the registry. <table> <tr> <th>Value</th>
///                 <th>Meaning</th> </tr> <tr> <td width="40%"><a id="KEY_WOW64_32KEY"></a><a id="key_wow64_32key"></a><dl>
///                 <dt><b>KEY_WOW64_32KEY</b></dt> <dt>0x0200</dt> </dl> </td> <td width="60%"> Delete the key from the 32-bit
///                 registry view. </td> </tr> <tr> <td width="40%"><a id="KEY_WOW64_64KEY"></a><a id="key_wow64_64key"></a><dl>
///                 <dt><b>KEY_WOW64_64KEY</b></dt> <dt>0x0100</dt> </dl> </td> <td width="60%"> Delete the key from the 64-bit
///                 registry view. </td> </tr> </table>
///    Reserved = This parameter is reserved and must be zero.
///    hTransaction = A handle to an active transaction. This handle is returned by the CreateTransaction function.
///    pExtendedParameter = This parameter is reserved and must be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegDeleteKeyTransactedW(HKEY hKey, const(wchar)* lpSubKey, uint samDesired, uint Reserved, 
                                HANDLE hTransaction, void* pExtendedParameter);

///Disables registry reflection for the specified key. Disabling reflection for a key does not affect reflection of any
///subkeys.
///Params:
///    hBase = A handle to an open registry key. This handle is returned by the RegCreateKeyEx, RegCreateKeyTransacted,
///            RegOpenKeyEx, or RegOpenKeyTransacted function; it cannot specify a key on a remote computer. If the key is not
///            on the reflection list, the function succeeds but has no effect. For more information, see Registry Redirectorand
///            Registry Reflection.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
int RegDisableReflectionKey(HKEY hBase);

///Restores registry reflection for the specified disabled key. Restoring reflection for a key does not affect
///reflection of any subkeys.
///Params:
///    hBase = A handle to the registry key that was previously disabled using the RegDisableReflectionKey function. This handle
///            is returned by the RegCreateKeyEx, RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function; it
///            cannot specify a key on a remote computer. If the key is not on the reflection list, this function succeeds but
///            has no effect. For more information, see Registry Redirectorand Registry Reflection.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
int RegEnableReflectionKey(HKEY hBase);

///Determines whether reflection has been disabled or enabled for the specified key.
///Params:
///    hBase = A handle to the registry key. This handle is returned by the RegCreateKeyEx, RegCreateKeyTransacted,
///            RegOpenKeyEx, or RegOpenKeyTransacted function; it cannot specify a key on a remote computer.
///    bIsReflectionDisabled = A value that indicates whether reflection has been disabled through RegDisableReflectionKey or enabled through
///                            RegEnableReflectionKey.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
int RegQueryReflectionKey(HKEY hBase, int* bIsReflectionDisabled);

///Removes a named value from the specified registry key. Note that value names are not case sensitive.
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the KEY_SET_VALUE access right. For more
///           information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx,
///           RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function. It can also be one of the following
///           predefined keys: <pre xml:space="preserve"><b></b> <b>HKEY_CLASSES_ROOT</b> <b>HKEY_CURRENT_CONFIG</b>
///           <b>HKEY_CURRENT_USER</b> <b>HKEY_LOCAL_MACHINE</b> <b>HKEY_USERS</b></pre>
///    lpValueName = The registry value to be removed. If this parameter is <b>NULL</b> or an empty string, the value set by the
///                  RegSetValueEx function is removed. For more information, see Registry Element Size Limits.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegDeleteValueA(HKEY hKey, const(char)* lpValueName);

///Removes a named value from the specified registry key. Note that value names are not case sensitive.
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the KEY_SET_VALUE access right. For more
///           information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx,
///           RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function. It can also be one of the following
///           predefined keys: <pre xml:space="preserve"><b></b> <b>HKEY_CLASSES_ROOT</b> <b>HKEY_CURRENT_CONFIG</b>
///           <b>HKEY_CURRENT_USER</b> <b>HKEY_LOCAL_MACHINE</b> <b>HKEY_USERS</b></pre>
///    lpValueName = The registry value to be removed. If this parameter is <b>NULL</b> or an empty string, the value set by the
///                  RegSetValue function is removed. For more information, see Registry Element Size Limits.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegDeleteValueW(HKEY hKey, const(wchar)* lpValueName);

///Enumerates the subkeys of the specified open registry key. The function retrieves the name of one subkey each time it
///is called. <div class="alert"><b>Note</b> This function is provided only for compatibility with 16-bit versions of
///Windows. Applications should use the RegEnumKeyEx function.</div><div> </div>
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the KEY_ENUMERATE_SUB_KEYS access right. For
///           more information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx,
///           RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function. It can also be one of the following
///           predefined keys:<dl> <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd>
///           <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_USERS</b></dd> </dl>
///    dwIndex = The index of the subkey of <i>hKey</i> to be retrieved. This value should be zero for the first call to the
///              <b>RegEnumKey</b> function and then incremented for subsequent calls. Because subkeys are not ordered, any new
///              subkey will have an arbitrary index. This means that the function may return subkeys in any order.
///    lpName = A pointer to a buffer that receives the name of the subkey, including the terminating null character. This
///             function copies only the name of the subkey, not the full key hierarchy, to the buffer. For more information, see
///             Registry Element Size Limits.
///    cchName = The size of the buffer pointed to by the <i>lpName</i> parameter, in <b>TCHARs</b>. To determine the required
///              buffer size, use the RegQueryInfoKey function to determine the size of the largest subkey for the key identified
///              by the <i>hKey</i> parameter.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a system
///    error code. If there are no more subkeys available, the function returns ERROR_NO_MORE_ITEMS. If the
///    <i>lpName</i> buffer is too small to receive the name of the key, the function returns ERROR_MORE_DATA.
///    
@DllImport("ADVAPI32")
LSTATUS RegEnumKeyA(HKEY hKey, uint dwIndex, const(char)* lpName, uint cchName);

///Enumerates the subkeys of the specified open registry key. The function retrieves the name of one subkey each time it
///is called. <div class="alert"><b>Note</b> This function is provided only for compatibility with 16-bit versions of
///Windows. Applications should use the RegEnumKeyEx function.</div><div> </div>
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the KEY_ENUMERATE_SUB_KEYS access right. For
///           more information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx,
///           RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function. It can also be one of the following
///           predefined keys:<dl> <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd>
///           <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_USERS</b></dd> </dl>
///    dwIndex = The index of the subkey of <i>hKey</i> to be retrieved. This value should be zero for the first call to the
///              <b>RegEnumKey</b> function and then incremented for subsequent calls. Because subkeys are not ordered, any new
///              subkey will have an arbitrary index. This means that the function may return subkeys in any order.
///    lpName = A pointer to a buffer that receives the name of the subkey, including the terminating null character. This
///             function copies only the name of the subkey, not the full key hierarchy, to the buffer. For more information, see
///             Registry Element Size Limits.
///    cchName = The size of the buffer pointed to by the <i>lpName</i> parameter, in <b>TCHARs</b>. To determine the required
///              buffer size, use the RegQueryInfoKey function to determine the size of the largest subkey for the key identified
///              by the <i>hKey</i> parameter.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a system
///    error code. If there are no more subkeys available, the function returns ERROR_NO_MORE_ITEMS. If the
///    <i>lpName</i> buffer is too small to receive the name of the key, the function returns ERROR_MORE_DATA.
///    
@DllImport("ADVAPI32")
LSTATUS RegEnumKeyW(HKEY hKey, uint dwIndex, const(wchar)* lpName, uint cchName);

///Enumerates the subkeys of the specified open registry key. The function retrieves information about one subkey each
///time it is called.
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the KEY_ENUMERATE_SUB_KEYS access right. For
///           more information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx,
///           RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function. It can also be one of the following
///           predefined keys:<dl> <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd>
///           <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_PERFORMANCE_DATA</b></dd>
///           <dd><b>HKEY_USERS</b></dd> </dl>
///    dwIndex = The index of the subkey to retrieve. This parameter should be zero for the first call to the <b>RegEnumKeyEx</b>
///              function and then incremented for subsequent calls. Because subkeys are not ordered, any new subkey will have an
///              arbitrary index. This means that the function may return subkeys in any order.
///    lpName = A pointer to a buffer that receives the name of the subkey, including the terminating <b>null</b> character. The
///             function copies only the name of the subkey, not the full key hierarchy, to the buffer. If the function fails, no
///             information is copied to this buffer. For more information, see Registry Element Size Limits.
///    lpcchName = A pointer to a variable that specifies the size of the buffer specified by the <i>lpName</i> parameter, in
///                characters. This size should include the terminating <b>null</b> character. If the function succeeds, the
///                variable pointed to by <i>lpcName</i> contains the number of characters stored in the buffer, not including the
///                terminating <b>null</b> character. To determine the required buffer size, use the RegQueryInfoKey function to
///                determine the size of the largest subkey for the key identified by the <i>hKey</i> parameter.
///    lpReserved = This parameter is reserved and must be <b>NULL</b>.
///    lpClass = A pointer to a buffer that receives the user-defined class of the enumerated subkey. This parameter can be
///              <b>NULL</b>.
///    lpcchClass = A pointer to a variable that specifies the size of the buffer specified by the <i>lpClass</i> parameter, in
///                 characters. The size should include the terminating <b>null</b> character. If the function succeeds,
///                 <i>lpcClass</i> contains the number of characters stored in the buffer, not including the terminating <b>null</b>
///                 character. This parameter can be <b>NULL</b> only if <i>lpClass</i> is <b>NULL</b>.
///    lpftLastWriteTime = A pointer to FILETIME structure that receives the time at which the enumerated subkey was last written. This
///                        parameter can be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a system
///    error code. If there are no more subkeys available, the function returns ERROR_NO_MORE_ITEMS. If the
///    <i>lpName</i> buffer is too small to receive the name of the key, the function returns ERROR_MORE_DATA.
///    
@DllImport("ADVAPI32")
LSTATUS RegEnumKeyExA(HKEY hKey, uint dwIndex, const(char)* lpName, uint* lpcchName, uint* lpReserved, 
                      const(char)* lpClass, uint* lpcchClass, FILETIME* lpftLastWriteTime);

///Enumerates the subkeys of the specified open registry key. The function retrieves information about one subkey each
///time it is called.
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the KEY_ENUMERATE_SUB_KEYS access right. For
///           more information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx,
///           RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function. It can also be one of the following
///           predefined keys:<dl> <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd>
///           <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_PERFORMANCE_DATA</b></dd>
///           <dd><b>HKEY_USERS</b></dd> </dl>
///    dwIndex = The index of the subkey to retrieve. This parameter should be zero for the first call to the <b>RegEnumKeyEx</b>
///              function and then incremented for subsequent calls. Because subkeys are not ordered, any new subkey will have an
///              arbitrary index. This means that the function may return subkeys in any order.
///    lpName = A pointer to a buffer that receives the name of the subkey, including the terminating <b>null</b> character. The
///             function copies only the name of the subkey, not the full key hierarchy, to the buffer. If the function fails, no
///             information is copied to this buffer. For more information, see Registry Element Size Limits.
///    lpcchName = A pointer to a variable that specifies the size of the buffer specified by the <i>lpName</i> parameter, in
///                characters. This size should include the terminating <b>null</b> character. If the function succeeds, the
///                variable pointed to by <i>lpcName</i> contains the number of characters stored in the buffer, not including the
///                terminating <b>null</b> character. To determine the required buffer size, use the RegQueryInfoKey function to
///                determine the size of the largest subkey for the key identified by the <i>hKey</i> parameter.
///    lpReserved = This parameter is reserved and must be <b>NULL</b>.
///    lpClass = A pointer to a buffer that receives the user-defined class of the enumerated subkey. This parameter can be
///              <b>NULL</b>.
///    lpcchClass = A pointer to a variable that specifies the size of the buffer specified by the <i>lpClass</i> parameter, in
///                 characters. The size should include the terminating <b>null</b> character. If the function succeeds,
///                 <i>lpcClass</i> contains the number of characters stored in the buffer, not including the terminating <b>null</b>
///                 character. This parameter can be <b>NULL</b> only if <i>lpClass</i> is <b>NULL</b>.
///    lpftLastWriteTime = A pointer to FILETIME structure that receives the time at which the enumerated subkey was last written. This
///                        parameter can be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a system
///    error code. If there are no more subkeys available, the function returns ERROR_NO_MORE_ITEMS. If the
///    <i>lpName</i> buffer is too small to receive the name of the key, the function returns ERROR_MORE_DATA.
///    
@DllImport("ADVAPI32")
LSTATUS RegEnumKeyExW(HKEY hKey, uint dwIndex, const(wchar)* lpName, uint* lpcchName, uint* lpReserved, 
                      const(wchar)* lpClass, uint* lpcchClass, FILETIME* lpftLastWriteTime);

///Enumerates the values for the specified open registry key. The function copies one indexed value name and data block
///for the key each time it is called.
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the KEY_QUERY_VALUE access right. For more
///           information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx,
///           RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function. It can also be one of the following
///           predefined keys:<dl> <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd>
///           <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_PERFORMANCE_DATA</b></dd>
///           <dd><b>HKEY_USERS</b></dd> </dl>
///    dwIndex = The index of the value to be retrieved. This parameter should be zero for the first call to the
///              <b>RegEnumValue</b> function and then be incremented for subsequent calls. Because values are not ordered, any
///              new value will have an arbitrary index. This means that the function may return values in any order.
///    lpValueName = A pointer to a buffer that receives the name of the value as a <b>null</b>-terminated string. This buffer must be
///                  large enough to include the terminating <b>null</b> character. For more information, see Registry Element Size
///                  Limits.
///    lpcchValueName = A pointer to a variable that specifies the size of the buffer pointed to by the <i>lpValueName</i> parameter, in
///                     characters. When the function returns, the variable receives the number of characters stored in the buffer, not
///                     including the terminating <b>null</b> character. If the buffer specified by <i>lpValueName</i> is not large
///                     enough to hold the data, the function returns ERROR_MORE_DATA and the buffer size in the variable pointed to by
///                     <i>lpValueName</i> is not changed. In this case, the contents of <i>lpcchValueName</i> are undefined. Registry
///                     value names are limited to 32,767 bytes. The ANSI version of this function treats this parameter as a
///                     <b>SHORT</b> value. Therefore, if you specify a value greater than 32,767 bytes, there is an overflow and the
///                     function may return ERROR_MORE_DATA.
///    lpReserved = This parameter is reserved and must be <b>NULL</b>.
///    lpType = A pointer to a variable that receives a code indicating the type of data stored in the specified value. For a
///             list of the possible type codes, see Registry Value Types. The <i>lpType</i> parameter can be <b>NULL</b> if the
///             type code is not required.
///    lpData = A pointer to a buffer that receives the data for the value entry. This parameter can be <b>NULL</b> if the data
///             is not required. If <i>lpData</i> is <b>NULL</b> and <i>lpcbData</i> is non-<b>NULL</b>, the function stores the
///             size of the data, in bytes, in the variable pointed to by <i>lpcbData</i>. This enables an application to
///             determine the best way to allocate a buffer for the data.
///    lpcbData = A pointer to a variable that specifies the size of the buffer pointed to by the <i>lpData</i> parameter, in
///               bytes. When the function returns, the variable receives the number of bytes stored in the buffer. This parameter
///               can be <b>NULL</b> only if <i>lpData</i> is <b>NULL</b>. If the data has the REG_SZ, REG_MULTI_SZ or
///               REG_EXPAND_SZ type, this size includes any terminating <b>null</b> character or characters. For more information,
///               see Remarks. If the buffer specified by <i>lpData</i> is not large enough to hold the data, the function returns
///               ERROR_MORE_DATA and stores the required buffer size in the variable pointed to by <i>lpcbData</i>. In this case,
///               the contents of <i>lpData</i> are undefined.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a system
///    error code. If there are no more values available, the function returns ERROR_NO_MORE_ITEMS. If the buffer
///    specified by <i>lpValueName</i> or <i>lpData</i> is too small to receive the value, the function returns
///    ERROR_MORE_DATA.
///    
@DllImport("ADVAPI32")
LSTATUS RegEnumValueA(HKEY hKey, uint dwIndex, const(char)* lpValueName, uint* lpcchValueName, uint* lpReserved, 
                      uint* lpType, char* lpData, uint* lpcbData);

///Enumerates the values for the specified open registry key. The function copies one indexed value name and data block
///for the key each time it is called.
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the KEY_QUERY_VALUE access right. For more
///           information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx,
///           RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function. It can also be one of the following
///           predefined keys:<dl> <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd>
///           <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_PERFORMANCE_DATA</b></dd>
///           <dd><b>HKEY_USERS</b></dd> </dl>
///    dwIndex = The index of the value to be retrieved. This parameter should be zero for the first call to the
///              <b>RegEnumValue</b> function and then be incremented for subsequent calls. Because values are not ordered, any
///              new value will have an arbitrary index. This means that the function may return values in any order.
///    lpValueName = A pointer to a buffer that receives the name of the value as a <b>null</b>-terminated string. This buffer must be
///                  large enough to include the terminating <b>null</b> character. For more information, see Registry Element Size
///                  Limits.
///    lpcchValueName = A pointer to a variable that specifies the size of the buffer pointed to by the <i>lpValueName</i> parameter, in
///                     characters. When the function returns, the variable receives the number of characters stored in the buffer, not
///                     including the terminating <b>null</b> character. Registry value names are limited to 32,767 bytes. The ANSI
///                     version of this function treats this parameter as a <b>SHORT</b> value. Therefore, if you specify a value greater
///                     than 32,767 bytes, there is an overflow and the function may return ERROR_MORE_DATA.
///    lpReserved = This parameter is reserved and must be <b>NULL</b>.
///    lpType = A pointer to a variable that receives a code indicating the type of data stored in the specified value. For a
///             list of the possible type codes, see Registry Value Types. The <i>lpType</i> parameter can be <b>NULL</b> if the
///             type code is not required.
///    lpData = A pointer to a buffer that receives the data for the value entry. This parameter can be <b>NULL</b> if the data
///             is not required. If <i>lpData</i> is <b>NULL</b> and <i>lpcbData</i> is non-<b>NULL</b>, the function stores the
///             size of the data, in bytes, in the variable pointed to by <i>lpcbData</i>. This enables an application to
///             determine the best way to allocate a buffer for the data.
///    lpcbData = A pointer to a variable that specifies the size of the buffer pointed to by the <i>lpData</i> parameter, in
///               bytes. When the function returns, the variable receives the number of bytes stored in the buffer. This parameter
///               can be <b>NULL</b> only if <i>lpData</i> is <b>NULL</b>. If the data has the REG_SZ, REG_MULTI_SZ or
///               REG_EXPAND_SZ type, this size includes any terminating <b>null</b> character or characters. For more information,
///               see Remarks. If the buffer specified by <i>lpData</i> is not large enough to hold the data, the function returns
///               ERROR_MORE_DATA and stores the required buffer size in the variable pointed to by <i>lpcbData</i>. In this case,
///               the contents of <i>lpData</i> are undefined.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a system
///    error code. If there are no more values available, the function returns ERROR_NO_MORE_ITEMS. If the <i>lpData</i>
///    buffer is too small to receive the value, the function returns ERROR_MORE_DATA.
///    
@DllImport("ADVAPI32")
LSTATUS RegEnumValueW(HKEY hKey, uint dwIndex, const(wchar)* lpValueName, uint* lpcchValueName, uint* lpReserved, 
                      uint* lpType, char* lpData, uint* lpcbData);

///Writes all the attributes of the specified open registry key into the registry.
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the KEY_QUERY_VALUE access right. For more
///           information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx,
///           RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function. It can also be one of the following
///           predefined keys:<dl> <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd>
///           <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_PERFORMANCE_DATA</b></dd>
///           <dd><b>HKEY_USERS</b></dd> </dl>
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegFlushKey(HKEY hKey);

///Creates a subkey under <b>HKEY_USERS</b> or <b>HKEY_LOCAL_MACHINE</b> and loads the data from the specified registry
///hive into that subkey. Applications that back up or restore system state including system files and registry hives
///should use the Volume Shadow Copy Service instead of the registry functions.
///Params:
///    hKey = A handle to the key where the subkey will be created. This can be a handle returned by a call to
///           RegConnectRegistry, or one of the following predefined handles: <b>HKEY_LOCAL_MACHINE</b> <b>HKEY_USERS</b> This
///           function always loads information at the top of the registry hierarchy. The <b>HKEY_CLASSES_ROOT</b> and
///           <b>HKEY_CURRENT_USER</b> handle values cannot be specified for this parameter, because they represent subsets of
///           the <b>HKEY_LOCAL_MACHINE</b> and <b>HKEY_USERS</b> handle values, respectively.
///    lpSubKey = The name of the key to be created under <i>hKey</i>. This subkey is where the registration information from the
///               file will be loaded. Key names are not case sensitive. For more information, see Registry Element Size Limits.
///    lpFile = The name of the file containing the registry data. This file must be a local file that was created with the
///             RegSaveKey function. If this file does not exist, a file is created with the specified name.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegLoadKeyA(HKEY hKey, const(char)* lpSubKey, const(char)* lpFile);

///Creates a subkey under <b>HKEY_USERS</b> or <b>HKEY_LOCAL_MACHINE</b> and loads the data from the specified registry
///hive into that subkey. Applications that back up or restore system state including system files and registry hives
///should use the Volume Shadow Copy Service instead of the registry functions.
///Params:
///    hKey = A handle to the key where the subkey will be created. This can be a handle returned by a call to
///           RegConnectRegistry, or one of the following predefined handles: <b>HKEY_LOCAL_MACHINE</b> <b>HKEY_USERS</b> This
///           function always loads information at the top of the registry hierarchy. The <b>HKEY_CLASSES_ROOT</b> and
///           <b>HKEY_CURRENT_USER</b> handle values cannot be specified for this parameter, because they represent subsets of
///           the <b>HKEY_LOCAL_MACHINE</b> and <b>HKEY_USERS</b> handle values, respectively.
///    lpSubKey = The name of the key to be created under <i>hKey</i>. This subkey is where the registration information from the
///               file will be loaded. Key names are not case sensitive. For more information, see Registry Element Size Limits.
///    lpFile = The name of the file containing the registry data. This file must be a local file that was created with the
///             RegSaveKey function. If this file does not exist, a file is created with the specified name.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegLoadKeyW(HKEY hKey, const(wchar)* lpSubKey, const(wchar)* lpFile);

///Notifies the caller about changes to the attributes or contents of a specified registry key.
///Params:
///    hKey = A handle to an open registry key. This handle is returned by the RegCreateKeyEx or RegOpenKeyEx function. It can
///           also be one of the following predefined keys: <b>HKEY_CLASSES_ROOT</b> <b>HKEY_CURRENT_CONFIG</b>
///           <b>HKEY_CURRENT_USER</b> <b>HKEY_LOCAL_MACHINE</b> <b>HKEY_USERS</b> This parameter must be a local handle. If
///           <b>RegNotifyChangeKeyValue</b> is called with a remote handle, it returns ERROR_INVALID_HANDLE. The key must have
///           been opened with the KEY_NOTIFY access right. For more information, see Registry Key Security and Access Rights.
///    bWatchSubtree = If this parameter is TRUE, the function reports changes in the specified key and its subkeys. If the parameter is
///                    <b>FALSE</b>, the function reports changes only in the specified key.
///    dwNotifyFilter = A value that indicates the changes that should be reported. This parameter can be one or more of the following
///                     values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                     id="REG_NOTIFY_CHANGE_NAME"></a><a id="reg_notify_change_name"></a><dl> <dt><b>REG_NOTIFY_CHANGE_NAME</b></dt>
///                     <dt>0x00000001L</dt> </dl> </td> <td width="60%"> Notify the caller if a subkey is added or deleted. </td> </tr>
///                     <tr> <td width="40%"><a id="REG_NOTIFY_CHANGE_ATTRIBUTES"></a><a id="reg_notify_change_attributes"></a><dl>
///                     <dt><b>REG_NOTIFY_CHANGE_ATTRIBUTES</b></dt> <dt>0x00000002L</dt> </dl> </td> <td width="60%"> Notify the caller
///                     of changes to the attributes of the key, such as the security descriptor information. </td> </tr> <tr> <td
///                     width="40%"><a id="REG_NOTIFY_CHANGE_LAST_SET"></a><a id="reg_notify_change_last_set"></a><dl>
///                     <dt><b>REG_NOTIFY_CHANGE_LAST_SET</b></dt> <dt>0x00000004L</dt> </dl> </td> <td width="60%"> Notify the caller of
///                     changes to a value of the key. This can include adding or deleting a value, or changing an existing value. </td>
///                     </tr> <tr> <td width="40%"><a id="REG_NOTIFY_CHANGE_SECURITY"></a><a id="reg_notify_change_security"></a><dl>
///                     <dt><b>REG_NOTIFY_CHANGE_SECURITY</b></dt> <dt>0x00000008L</dt> </dl> </td> <td width="60%"> Notify the caller of
///                     changes to the security descriptor of the key. </td> </tr> <tr> <td width="40%"><a
///                     id="REG_NOTIFY_THREAD_AGNOSTIC"></a><a id="reg_notify_thread_agnostic"></a><dl>
///                     <dt><b>REG_NOTIFY_THREAD_AGNOSTIC</b></dt> <dt>0x10000000L</dt> </dl> </td> <td width="60%"> Indicates that the
///                     lifetime of the registration must not be tied to the lifetime of the thread issuing the
///                     <b>RegNotifyChangeKeyValue</b> call. <div class="alert"><b>Note</b> This flag value is only supported in Windows
///                     8 and later.</div> <div> </div> </td> </tr> </table>
///    hEvent = A handle to an event. If the <i>fAsynchronous</i> parameter is <b>TRUE</b>, the function returns immediately and
///             changes are reported by signaling this event. If <i>fAsynchronous</i> is <b>FALSE</b>, <i>hEvent</i> is ignored.
///    fAsynchronous = If this parameter is <b>TRUE</b>, the function returns immediately and reports changes by signaling the specified
///                    event. If this parameter is <b>FALSE</b>, the function does not return until a change has occurred. If
///                    <i>hEvent</i> does not specify a valid event, the <i>fAsynchronous</i> parameter cannot be <b>TRUE</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegNotifyChangeKeyValue(HKEY hKey, BOOL bWatchSubtree, uint dwNotifyFilter, HANDLE hEvent, 
                                BOOL fAsynchronous);

///Opens the specified registry key. <div class="alert"><b>Note</b> This function is provided only for compatibility
///with 16-bit versions of Windows. Applications should use the RegOpenKeyEx function.</div><div> </div>
///Params:
///    hKey = A handle to an open registry key. This handle is returned by the RegCreateKeyEx or RegOpenKeyEx function, or it
///           can be one of the following predefined keys: <b>HKEY_CLASSES_ROOT</b> <b>HKEY_CURRENT_CONFIG</b>
///           <b>HKEY_CURRENT_USER</b> <b>HKEY_LOCAL_MACHINE</b> <b>HKEY_USERS</b>
///    lpSubKey = The name of the registry key to be opened. This key must be a subkey of the key identified by the <i>hKey</i>
///               parameter. Key names are not case sensitive. If this parameter is <b>NULL</b> or a pointer to an empty string,
///               the function returns the same handle that was passed in. For more information, see Registry Element Size Limits.
///    phkResult = A pointer to a variable that receives a handle to the opened key. If the key is not one of the predefined
///                registry keys, call the RegCloseKey function after you have finished using the handle.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegOpenKeyA(HKEY hKey, const(char)* lpSubKey, HKEY* phkResult);

///Opens the specified registry key. <div class="alert"><b>Note</b> This function is provided only for compatibility
///with 16-bit versions of Windows. Applications should use the RegOpenKeyEx function.</div><div> </div>
///Params:
///    hKey = A handle to an open registry key. This handle is returned by the RegCreateKeyEx or RegOpenKeyEx function, or it
///           can be one of the following predefined keys: <b>HKEY_CLASSES_ROOT</b> <b>HKEY_CURRENT_CONFIG</b>
///           <b>HKEY_CURRENT_USER</b> <b>HKEY_LOCAL_MACHINE</b> <b>HKEY_USERS</b>
///    lpSubKey = The name of the registry key to be opened. This key must be a subkey of the key identified by the <i>hKey</i>
///               parameter. Key names are not case sensitive. If this parameter is <b>NULL</b> or a pointer to an empty string,
///               the function returns the same handle that was passed in. For more information, see Registry Element Size Limits.
///    phkResult = A pointer to a variable that receives a handle to the opened key. If the key is not one of the predefined
///                registry keys, call the RegCloseKey function after you have finished using the handle.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegOpenKeyW(HKEY hKey, const(wchar)* lpSubKey, HKEY* phkResult);

///Opens the specified registry key. Note that key names are not case sensitive. To perform transacted registry
///operations on a key, call the RegOpenKeyTransacted function.
///Params:
///    hKey = A handle to an open registry key. This handle is returned by the RegCreateKeyEx or <b>RegOpenKeyEx</b> function,
///           or it can be one of the following predefined keys: <b>HKEY_CLASSES_ROOT</b> <b>HKEY_CURRENT_CONFIG</b>
///           <b>HKEY_CURRENT_USER</b> <b>HKEY_LOCAL_MACHINE</b> <b>HKEY_USERS</b>
///    lpSubKey = The name of the registry subkey to be opened. Key names are not case sensitive. If the <i>lpSubKey</i> parameter
///               is <b>NULL</b> or a pointer to an empty string, and if <i>hKey</i> is a predefined key, then the system refreshes
///               the predefined key, and <i>phkResult</i> receives the same <i>hKey</i> handle passed into the function.
///               Otherwise, <i>phkResult</i> receives a new handle to the opened key. For more information, see Registry Element
///               Size Limits.
///    ulOptions = Specifies the option to apply when opening the key. Set this parameter to zero or the following: <table> <tr>
///                <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="REG_OPTION_OPEN_LINK"></a><a
///                id="reg_option_open_link"></a><dl> <dt><b>REG_OPTION_OPEN_LINK</b></dt> </dl> </td> <td width="60%"> The key is a
///                symbolic link. Registry symbolic links should only be used when absolutely necessary. </td> </tr> </table>
///    samDesired = A mask that specifies the desired access rights to the key to be opened. The function fails if the security
///                 descriptor of the key does not permit the requested access for the calling process. For more information, see
///                 Registry Key Security and Access Rights.
///    phkResult = A pointer to a variable that receives a handle to the opened key. If the key is not one of the predefined
///                registry keys, call the RegCloseKey function after you have finished using the handle.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error. > [!NOTE] > On legacy versions of Windows, this API is also exposed by
///    kernel32.dll.
///    
@DllImport("ADVAPI32")
LSTATUS RegOpenKeyExA(HKEY hKey, const(char)* lpSubKey, uint ulOptions, uint samDesired, HKEY* phkResult);

///Opens the specified registry key. Note that key names are not case sensitive. To perform transacted registry
///operations on a key, call the RegOpenKeyTransacted function.
///Params:
///    hKey = A handle to an open registry key. This handle is returned by the RegCreateKeyEx or <b>RegOpenKeyEx</b> function,
///           or it can be one of the following predefined keys: <b>HKEY_CLASSES_ROOT</b> <b>HKEY_CURRENT_CONFIG</b>
///           <b>HKEY_CURRENT_USER</b> <b>HKEY_LOCAL_MACHINE</b> <b>HKEY_USERS</b>
///    lpSubKey = The name of the registry subkey to be opened. Key names are not case sensitive. If the <i>lpSubKey</i> parameter
///               is <b>NULL</b> or a pointer to an empty string, and if <i>hKey</i> is a predefined key, then the system refreshes
///               the predefined key, and <i>phkResult</i> receives the same <i>hKey</i> handle passed into the function.
///               Otherwise, <i>phkResult</i> receives a new handle to the opened key. For more information, see Registry Element
///               Size Limits.
///    ulOptions = Specifies the option to apply when opening the key. Set this parameter to zero or the following: <table> <tr>
///                <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="REG_OPTION_OPEN_LINK"></a><a
///                id="reg_option_open_link"></a><dl> <dt><b>REG_OPTION_OPEN_LINK</b></dt> </dl> </td> <td width="60%"> The key is a
///                symbolic link. Registry symbolic links should only be used when absolutely necessary. </td> </tr> </table>
///    samDesired = A mask that specifies the desired access rights to the key to be opened. The function fails if the security
///                 descriptor of the key does not permit the requested access for the calling process. For more information, see
///                 Registry Key Security and Access Rights.
///    phkResult = A pointer to a variable that receives a handle to the opened key. If the key is not one of the predefined
///                registry keys, call the RegCloseKey function after you have finished using the handle.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegOpenKeyExW(HKEY hKey, const(wchar)* lpSubKey, uint ulOptions, uint samDesired, HKEY* phkResult);

///Opens the specified registry key and associates it with a transaction. Note that key names are not case sensitive.
///Params:
///    hKey = A handle to an open registry key. This handle is returned by the RegCreateKeyEx, RegCreateKeyTransacted,
///           RegOpenKeyEx, or <b>RegOpenKeyTransacted</b> function. It can also be one of the following predefined keys:
///           <b>HKEY_CLASSES_ROOT</b> <b>HKEY_CURRENT_USER</b> <b>HKEY_LOCAL_MACHINE</b> <b>HKEY_USERS</b>
///    lpSubKey = The name of the registry subkey to be opened. Key names are not case sensitive. If the <i>lpSubKey</i> parameter
///               is <b>NULL</b> or a pointer to an empty string, and if <i>hKey</i> is a predefined key, then the system refreshes
///               the predefined key, and <i>phkResult</i> receives the same <i>hKey</i> handle passed into the function.
///               Otherwise, <i>phkResult</i> receives a new handle to the opened key. For more information, see Registry Element
///               Size Limits.
///    ulOptions = This parameter is reserved and must be zero.
///    samDesired = A mask that specifies the desired access rights to the key. The function fails if the security descriptor of the
///                 key does not permit the requested access for the calling process. For more information, see Registry Key Security
///                 and Access Rights.
///    phkResult = A pointer to a variable that receives a handle to the opened key. If the key is not one of the predefined
///                registry keys, call the RegCloseKey function after you have finished using the handle.
///    hTransaction = A handle to an active transaction. This handle is returned by the CreateTransaction function.
///    pExtendedParemeter = This parameter is reserved and must be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegOpenKeyTransactedA(HKEY hKey, const(char)* lpSubKey, uint ulOptions, uint samDesired, HKEY* phkResult, 
                              HANDLE hTransaction, void* pExtendedParemeter);

///Opens the specified registry key and associates it with a transaction. Note that key names are not case sensitive.
///Params:
///    hKey = A handle to an open registry key. This handle is returned by the RegCreateKeyEx, RegCreateKeyTransacted,
///           RegOpenKeyEx, or <b>RegOpenKeyTransacted</b> function. It can also be one of the following predefined keys:
///           <b>HKEY_CLASSES_ROOT</b> <b>HKEY_CURRENT_USER</b> <b>HKEY_LOCAL_MACHINE</b> <b>HKEY_USERS</b>
///    lpSubKey = The name of the registry subkey to be opened. Key names are not case sensitive. If the <i>lpSubKey</i> parameter
///               is <b>NULL</b> or a pointer to an empty string, and if <i>hKey</i> is a predefined key, then the system refreshes
///               the predefined key, and <i>phkResult</i> receives the same <i>hKey</i> handle passed into the function.
///               Otherwise, <i>phkResult</i> receives a new handle to the opened key. For more information, see Registry Element
///               Size Limits.
///    ulOptions = This parameter is reserved and must be zero.
///    samDesired = A mask that specifies the desired access rights to the key. The function fails if the security descriptor of the
///                 key does not permit the requested access for the calling process. For more information, see Registry Key Security
///                 and Access Rights.
///    phkResult = A pointer to a variable that receives a handle to the opened key. If the key is not one of the predefined
///                registry keys, call the RegCloseKey function after you have finished using the handle.
///    hTransaction = A handle to an active transaction. This handle is returned by the CreateTransaction function.
///    pExtendedParemeter = This parameter is reserved and must be <b>NULL</b>.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegOpenKeyTransactedW(HKEY hKey, const(wchar)* lpSubKey, uint ulOptions, uint samDesired, HKEY* phkResult, 
                              HANDLE hTransaction, void* pExtendedParemeter);

///Retrieves information about the specified registry key.
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the KEY_QUERY_VALUE access right. For more
///           information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx,
///           RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function. It can also be one of the following
///           predefined keys:<pre xml:space="preserve"><b></b> <b>HKEY_CLASSES_ROOT</b> <b>HKEY_CURRENT_CONFIG</b>
///           <b>HKEY_CURRENT_USER</b> <b>HKEY_LOCAL_MACHINE</b> <b>HKEY_PERFORMANCE_DATA</b> <b>HKEY_USERS</b></pre>
///    lpClass = A pointer to a buffer that receives the user-defined class of the key. This parameter can be <b>NULL</b>.
///    lpcchClass = A pointer to a variable that specifies the size of the buffer pointed to by the <i>lpClass</i> parameter, in
///                 characters. The size should include the terminating <b>null</b> character. When the function returns, this
///                 variable contains the size of the class string that is stored in the buffer. The count returned does not include
///                 the terminating <b>null</b> character. If the buffer is not big enough, the function returns ERROR_MORE_DATA, and
///                 the variable contains the size of the string, in characters, without counting the terminating <b>null</b>
///                 character. If <i>lpClass</i> is <b>NULL</b>, <i>lpcClass</i> can be <b>NULL</b>. If the <i>lpClass</i> parameter
///                 is a valid address, but the <i>lpcClass</i> parameter is not, for example, it is <b>NULL</b>, then the function
///                 returns ERROR_INVALID_PARAMETER.
///    lpReserved = This parameter is reserved and must be <b>NULL</b>.
///    lpcSubKeys = A pointer to a variable that receives the number of subkeys that are contained by the specified key. This
///                 parameter can be <b>NULL</b>.
///    lpcbMaxSubKeyLen = A pointer to a variable that receives the size of the key's subkey with the longest name, in Unicode characters,
///                       not including the terminating <b>null</b> character. This parameter can be <b>NULL</b>.
///    lpcbMaxClassLen = A pointer to a variable that receives the size of the longest string that specifies a subkey class, in Unicode
///                      characters. The count returned does not include the terminating <b>null</b> character. This parameter can be
///                      <b>NULL</b>.
///    lpcValues = A pointer to a variable that receives the number of values that are associated with the key. This parameter can
///                be <b>NULL</b>.
///    lpcbMaxValueNameLen = A pointer to a variable that receives the size of the key's longest value name, in Unicode characters. The size
///                          does not include the terminating <b>null</b> character. This parameter can be <b>NULL</b>.
///    lpcbMaxValueLen = A pointer to a variable that receives the size of the longest data component among the key's values, in bytes.
///                      This parameter can be <b>NULL</b>.
///    lpcbSecurityDescriptor = A pointer to a variable that receives the size of the key's security descriptor, in bytes. This parameter can be
///                             <b>NULL</b>.
///    lpftLastWriteTime = A pointer to a FILETIME structure that receives the last write time. This parameter can be <b>NULL</b>. The
///                        function sets the members of the FILETIME structure to indicate the last time that the key or any of its value
///                        entries is modified.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a system
///    error code. If the <i>lpClass</i> buffer is too small to receive the name of the class, the function returns
///    ERROR_MORE_DATA.
///    
@DllImport("ADVAPI32")
LSTATUS RegQueryInfoKeyA(HKEY hKey, const(char)* lpClass, uint* lpcchClass, uint* lpReserved, uint* lpcSubKeys, 
                         uint* lpcbMaxSubKeyLen, uint* lpcbMaxClassLen, uint* lpcValues, uint* lpcbMaxValueNameLen, 
                         uint* lpcbMaxValueLen, uint* lpcbSecurityDescriptor, FILETIME* lpftLastWriteTime);

///Retrieves information about the specified registry key.
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the KEY_QUERY_VALUE access right. For more
///           information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx,
///           RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function. It can also be one of the following
///           predefined keys:<pre xml:space="preserve"><b></b> <b>HKEY_CLASSES_ROOT</b> <b>HKEY_CURRENT_CONFIG</b>
///           <b>HKEY_CURRENT_USER</b> <b>HKEY_LOCAL_MACHINE</b> <b>HKEY_PERFORMANCE_DATA</b> <b>HKEY_USERS</b></pre>
///    lpClass = A pointer to a buffer that receives the user-defined class of the key. This parameter can be <b>NULL</b>.
///    lpcchClass = A pointer to a variable that specifies the size of the buffer pointed to by the <i>lpClass</i> parameter, in
///                 characters. The size should include the terminating <b>null</b> character. When the function returns, this
///                 variable contains the size of the class string that is stored in the buffer. The count returned does not include
///                 the terminating <b>null</b> character. If the buffer is not big enough, the function returns ERROR_MORE_DATA, and
///                 the variable contains the size of the string, in characters, without counting the terminating <b>null</b>
///                 character. If <i>lpClass</i> is <b>NULL</b>, <i>lpcClass</i> can be <b>NULL</b>. If the <i>lpClass</i> parameter
///                 is a valid address, but the <i>lpcClass</i> parameter is not, for example, it is <b>NULL</b>, then the function
///                 returns ERROR_INVALID_PARAMETER.
///    lpReserved = This parameter is reserved and must be <b>NULL</b>.
///    lpcSubKeys = A pointer to a variable that receives the number of subkeys that are contained by the specified key. This
///                 parameter can be <b>NULL</b>.
///    lpcbMaxSubKeyLen = A pointer to a variable that receives the size of the key's subkey with the longest name, in Unicode characters,
///                       not including the terminating <b>null</b> character. This parameter can be <b>NULL</b>.
///    lpcbMaxClassLen = A pointer to a variable that receives the size of the longest string that specifies a subkey class, in Unicode
///                      characters. The count returned does not include the terminating <b>null</b> character. This parameter can be
///                      <b>NULL</b>.
///    lpcValues = A pointer to a variable that receives the number of values that are associated with the key. This parameter can
///                be <b>NULL</b>.
///    lpcbMaxValueNameLen = A pointer to a variable that receives the size of the key's longest value name, in Unicode characters. The size
///                          does not include the terminating <b>null</b> character. This parameter can be <b>NULL</b>.
///    lpcbMaxValueLen = A pointer to a variable that receives the size of the longest data component among the key's values, in bytes.
///                      This parameter can be <b>NULL</b>.
///    lpcbSecurityDescriptor = A pointer to a variable that receives the size of the key's security descriptor, in bytes. This parameter can be
///                             <b>NULL</b>.
///    lpftLastWriteTime = A pointer to a FILETIME structure that receives the last write time. This parameter can be <b>NULL</b>. The
///                        function sets the members of the FILETIME structure to indicate the last time that the key or any of its value
///                        entries is modified.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a system
///    error code. If the <i>lpClass</i> buffer is too small to receive the name of the class, the function returns
///    ERROR_MORE_DATA.
///    
@DllImport("ADVAPI32")
LSTATUS RegQueryInfoKeyW(HKEY hKey, const(wchar)* lpClass, uint* lpcchClass, uint* lpReserved, uint* lpcSubKeys, 
                         uint* lpcbMaxSubKeyLen, uint* lpcbMaxClassLen, uint* lpcValues, uint* lpcbMaxValueNameLen, 
                         uint* lpcbMaxValueLen, uint* lpcbSecurityDescriptor, FILETIME* lpftLastWriteTime);

///Retrieves the data associated with the default or unnamed value of a specified registry key. The data must be a
///<b>null</b>-terminated string. <div class="alert"><b>Note</b> This function is provided only for compatibility with
///16-bit versions of Windows. Applications should use the RegQueryValueEx function.</div><div> </div>
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the KEY_QUERY_VALUE access right. For more
///           information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx,
///           RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function. It can also be one of the following
///           predefined keys:<dl> <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd>
///           <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_USERS</b></dd> </dl>
///    lpSubKey = The name of the subkey of the <i>hKey</i> parameter for which the default value is retrieved. Key names are not
///               case sensitive. If this parameter is <b>NULL</b> or points to an empty string, the function retrieves the default
///               value for the key identified by <i>hKey</i>. For more information, see Registry Element Size Limits.
///    lpData = A pointer to a buffer that receives the default value of the specified key. If <i>lpValue</i> is <b>NULL</b>, and
///             <i>lpcbValue</i> is non-<b>NULL</b>, the function returns ERROR_SUCCESS, and stores the size of the data, in
///             bytes, in the variable pointed to by <i>lpcbValue</i>. This enables an application to determine the best way to
///             allocate a buffer for the value's data.
///    lpcbData = A pointer to a variable that specifies the size of the buffer pointed to by the <i>lpValue</i> parameter, in
///               bytes. When the function returns, this variable contains the size of the data copied to <i>lpValue</i>, including
///               any terminating <b>null</b> characters. If the data has the REG_SZ, REG_MULTI_SZ or REG_EXPAND_SZ type, this size
///               includes any terminating <b>null</b> character or characters. For more information, see Remarks. If the buffer
///               specified <i>lpValue</i> is not large enough to hold the data, the function returns ERROR_MORE_DATA and stores
///               the required buffer size in the variable pointed to by <i>lpcbValue</i>. In this case, the contents of the
///               <i>lpValue</i> buffer are undefined.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a system
///    error code. If the <i>lpValue</i> buffer is too small to receive the value, the function returns ERROR_MORE_DATA.
///    
@DllImport("ADVAPI32")
LSTATUS RegQueryValueA(HKEY hKey, const(char)* lpSubKey, const(char)* lpData, int* lpcbData);

///Retrieves the data associated with the default or unnamed value of a specified registry key. The data must be a
///<b>null</b>-terminated string. <div class="alert"><b>Note</b> This function is provided only for compatibility with
///16-bit versions of Windows. Applications should use the RegQueryValueEx function.</div><div> </div>
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the KEY_QUERY_VALUE access right. For more
///           information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx,
///           RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function. It can also be one of the following
///           predefined keys:<dl> <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd>
///           <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_USERS</b></dd> </dl>
///    lpSubKey = The name of the subkey of the <i>hKey</i> parameter for which the default value is retrieved. Key names are not
///               case sensitive. If this parameter is <b>NULL</b> or points to an empty string, the function retrieves the default
///               value for the key identified by <i>hKey</i>. For more information, see Registry Element Size Limits.
///    lpData = A pointer to a buffer that receives the default value of the specified key. If <i>lpValue</i> is <b>NULL</b>, and
///             <i>lpcbValue</i> is non-<b>NULL</b>, the function returns ERROR_SUCCESS, and stores the size of the data, in
///             bytes, in the variable pointed to by <i>lpcbValue</i>. This enables an application to determine the best way to
///             allocate a buffer for the value's data.
///    lpcbData = A pointer to a variable that specifies the size of the buffer pointed to by the <i>lpValue</i> parameter, in
///               bytes. When the function returns, this variable contains the size of the data copied to <i>lpValue</i>, including
///               any terminating <b>null</b> characters. If the data has the REG_SZ, REG_MULTI_SZ or REG_EXPAND_SZ type, this size
///               includes any terminating <b>null</b> character or characters. For more information, see Remarks. If the buffer
///               specified <i>lpValue</i> is not large enough to hold the data, the function returns ERROR_MORE_DATA and stores
///               the required buffer size in the variable pointed to by <i>lpcbValue</i>. In this case, the contents of the
///               <i>lpValue</i> buffer are undefined.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a system
///    error code. If the <i>lpValue</i> buffer is too small to receive the value, the function returns ERROR_MORE_DATA.
///    
@DllImport("ADVAPI32")
LSTATUS RegQueryValueW(HKEY hKey, const(wchar)* lpSubKey, const(wchar)* lpData, int* lpcbData);

///Retrieves the type and data for a list of value names associated with an open registry key.
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the KEY_QUERY_VALUE access right. For more
///           information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx,
///           RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function. It can also be one of the following
///           predefined keys:<dl> <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd>
///           <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_PERFORMANCE_DATA</b></dd>
///           <dd><b>HKEY_USERS</b></dd> </dl>
///    val_list = A pointer to an array of VALENT structures that describe one or more value entries. On input, the
///               <b>ve_valuename</b> member of each structure must contain a pointer to the name of a value to retrieve. The
///               function fails if any of the specified values do not exist in the specified key. If the function succeeds, each
///               element of the array contains the information for the specified value.
///    num_vals = The number of elements in the <i>val_list</i> array.
///    lpValueBuf = A pointer to a buffer. If the function succeeds, the buffer receives the data for each value. If
///                 <i>lpValueBuf</i> is <b>NULL</b>, the value pointed to by the <i>ldwTotsize</i> parameter must be zero, in which
///                 case the function returns ERROR_MORE_DATA and <i>ldwTotsize</i> receives the required size of the buffer, in
///                 bytes.
///    ldwTotsize = A pointer to a variable that specifies the size of the buffer pointed to by the <i>lpValueBuf</i> parameter, in
///                 bytes. If the function succeeds, <i>ldwTotsize</i> receives the number of bytes copied to the buffer. If the
///                 function fails because the buffer is too small, <i>ldwTotsize</i> receives the required size, in bytes.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_CANTREAD</b></dt> </dl> </td> <td width="60%"> RegQueryMultipleValues cannot instantiate or
///    access the provider of the dynamic key. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt>
///    </dl> </td> <td width="60%"> The buffer pointed to by <i>lpValueBuf</i> was too small. In this case,
///    <i>ldwTotsize</i> receives the required buffer size. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_TRANSFER_TOO_LONG</b></dt> </dl> </td> <td width="60%"> The total size of the requested data (size
///    of the <i>val_list</i> array + <i>ldwTotSize</i>) is more than the system limit of one megabyte. </td> </tr>
///    </table>
///    
@DllImport("ADVAPI32")
LSTATUS RegQueryMultipleValuesA(HKEY hKey, char* val_list, uint num_vals, const(char)* lpValueBuf, 
                                uint* ldwTotsize);

///Retrieves the type and data for a list of value names associated with an open registry key.
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the KEY_QUERY_VALUE access right. For more
///           information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx,
///           RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function. It can also be one of the following
///           predefined keys:<dl> <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd>
///           <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_PERFORMANCE_DATA</b></dd>
///           <dd><b>HKEY_USERS</b></dd> </dl>
///    val_list = A pointer to an array of [VALENT](./ns-winreg-valenta.md) structures that describe one or more value entries. On
///               input, the <b>ve_valuename</b> member of each structure must contain a pointer to the name of a value to
///               retrieve. The function fails if any of the specified values do not exist in the specified key. If the function
///               succeeds, each element of the array contains the information for the specified value.
///    num_vals = The number of elements in the <i>val_list</i> array.
///    lpValueBuf = A pointer to a buffer. If the function succeeds, the buffer receives the data for each value. If
///                 <i>lpValueBuf</i> is <b>NULL</b>, the value pointed to by the <i>ldwTotsize</i> parameter must be zero, in which
///                 case the function returns ERROR_MORE_DATA and <i>ldwTotsize</i> receives the required size of the buffer, in
///                 bytes.
///    ldwTotsize = A pointer to a variable that specifies the size of the buffer pointed to by the <i>lpValueBuf</i> parameter, in
///                 bytes. If the function succeeds, <i>ldwTotsize</i> receives the number of bytes copied to the buffer. If the
///                 function fails because the buffer is too small, <i>ldwTotsize</i> receives the required size, in bytes.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_CANTREAD</b></dt> </dl> </td> <td width="60%"> RegQueryMultipleValues cannot instantiate or
///    access the provider of the dynamic key. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt>
///    </dl> </td> <td width="60%"> The buffer pointed to by <i>lpValueBuf</i> was too small. In this case,
///    <i>ldwTotsize</i> receives the required buffer size. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_TRANSFER_TOO_LONG</b></dt> </dl> </td> <td width="60%"> The total size of the requested data (size
///    of the <i>val_list</i> array + <i>ldwTotSize</i>) is more than the system limit of one megabyte. </td> </tr>
///    </table>
///    
@DllImport("ADVAPI32")
LSTATUS RegQueryMultipleValuesW(HKEY hKey, char* val_list, uint num_vals, const(wchar)* lpValueBuf, 
                                uint* ldwTotsize);

///Retrieves the type and data for the specified value name associated with an open registry key. To ensure that any
///string values (REG_SZ, REG_MULTI_SZ, and REG_EXPAND_SZ) returned are <b>null</b>-terminated, use the RegGetValue
///function.
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the KEY_QUERY_VALUE access right. For more
///           information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx,
///           RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function. It can also be one of the following
///           predefined keys:<dl> <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd>
///           <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_PERFORMANCE_DATA</b></dd>
///           <dd><b>HKEY_PERFORMANCE_NLSTEXT</b></dd> <dd><b>HKEY_PERFORMANCE_TEXT</b></dd> <dd><b>HKEY_USERS</b></dd> </dl>
///    lpValueName = The name of the registry value. If <i>lpValueName</i> is <b>NULL</b> or an empty string, "", the function
///                  retrieves the type and data for the key's unnamed or default value, if any. If <i>lpValueName</i> specifies a
///                  value that is not in the registry, the function returns ERROR_FILE_NOT_FOUND. Keys do not automatically have an
///                  unnamed or default value. Unnamed values can be of any type. For more information, see Registry Element Size
///                  Limits.
///    lpReserved = This parameter is reserved and must be <b>NULL</b>.
///    lpType = A pointer to a variable that receives a code indicating the type of data stored in the specified value. For a
///             list of the possible type codes, see Registry Value Types. The <i>lpType</i> parameter can be <b>NULL</b> if the
///             type code is not required.
///    lpData = A pointer to a buffer that receives the value's data. This parameter can be <b>NULL</b> if the data is not
///             required.
///    lpcbData = A pointer to a variable that specifies the size of the buffer pointed to by the <i>lpData</i> parameter, in
///               bytes. When the function returns, this variable contains the size of the data copied to <i>lpData</i>. The
///               <i>lpcbData</i> parameter can be <b>NULL</b> only if <i>lpData</i> is <b>NULL</b>. If the data has the REG_SZ,
///               REG_MULTI_SZ or REG_EXPAND_SZ type, this size includes any terminating <b>null</b> character or characters unless
///               the data was stored without them. For more information, see Remarks. If the buffer specified by <i>lpData</i>
///               parameter is not large enough to hold the data, the function returns ERROR_MORE_DATA and stores the required
///               buffer size in the variable pointed to by <i>lpcbData</i>. In this case, the contents of the <i>lpData</i> buffer
///               are undefined. If <i>lpData</i> is <b>NULL</b>, and <i>lpcbData</i> is non-<b>NULL</b>, the function returns
///               ERROR_SUCCESS and stores the size of the data, in bytes, in the variable pointed to by <i>lpcbData</i>. This
///               enables an application to determine the best way to allocate a buffer for the value's data. If <i>hKey</i>
///               specifies <b>HKEY_PERFORMANCE_DATA</b> and the <i>lpData</i> buffer is not large enough to contain all of the
///               returned data, <b>RegQueryValueEx</b> returns ERROR_MORE_DATA and the value returned through the <i>lpcbData</i>
///               parameter is undefined. This is because the size of the performance data can change from one call to the next. In
///               this case, you must increase the buffer size and call <b>RegQueryValueEx</b> again passing the updated buffer
///               size in the <i>lpcbData</i> parameter. Repeat this until the function succeeds. You need to maintain a separate
///               variable to keep track of the buffer size, because the value returned by <i>lpcbData</i> is unpredictable. If the
///               <i>lpValueName</i> registry value does not exist, <b>RegQueryValueEx</b> returns ERROR_FILE_NOT_FOUND and the
///               value returned through the <i>lpcbData</i> parameter is undefined.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a system
///    error code. If the <i>lpData</i> buffer is too small to receive the data, the function returns ERROR_MORE_DATA.
///    If the <i>lpValueName</i> registry value does not exist, the function returns ERROR_FILE_NOT_FOUND.
///    
@DllImport("ADVAPI32")
LSTATUS RegQueryValueExA(HKEY hKey, const(char)* lpValueName, uint* lpReserved, uint* lpType, char* lpData, 
                         uint* lpcbData);

///Retrieves the type and data for the specified value name associated with an open registry key. To ensure that any
///string values (REG_SZ, REG_MULTI_SZ, and REG_EXPAND_SZ) returned are <b>null</b>-terminated, use the RegGetValue
///function.
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the KEY_QUERY_VALUE access right. For more
///           information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx,
///           RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function. It can also be one of the following
///           predefined keys:<dl> <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd>
///           <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_PERFORMANCE_DATA</b></dd>
///           <dd><b>HKEY_PERFORMANCE_NLSTEXT</b></dd> <dd><b>HKEY_PERFORMANCE_TEXT</b></dd> <dd><b>HKEY_USERS</b></dd> </dl>
///    lpValueName = The name of the registry value. If <i>lpValueName</i> is <b>NULL</b> or an empty string, "", the function
///                  retrieves the type and data for the key's unnamed or default value, if any. If <i>lpValueName</i> specifies a
///                  value that is not in the registry, the function returns ERROR_FILE_NOT_FOUND. Keys do not automatically have an
///                  unnamed or default value. Unnamed values can be of any type. For more information, see Registry Element Size
///                  Limits.
///    lpReserved = This parameter is reserved and must be <b>NULL</b>.
///    lpType = A pointer to a variable that receives a code indicating the type of data stored in the specified value. For a
///             list of the possible type codes, see Registry Value Types. The <i>lpType</i> parameter can be <b>NULL</b> if the
///             type code is not required.
///    lpData = A pointer to a buffer that receives the value's data. This parameter can be <b>NULL</b> if the data is not
///             required.
///    lpcbData = A pointer to a variable that specifies the size of the buffer pointed to by the <i>lpData</i> parameter, in
///               bytes. When the function returns, this variable contains the size of the data copied to <i>lpData</i>. The
///               <i>lpcbData</i> parameter can be <b>NULL</b> only if <i>lpData</i> is <b>NULL</b>. If the data has the REG_SZ,
///               REG_MULTI_SZ or REG_EXPAND_SZ type, this size includes any terminating <b>null</b> character or characters unless
///               the data was stored without them. For more information, see Remarks. If the buffer specified by <i>lpData</i>
///               parameter is not large enough to hold the data, the function returns ERROR_MORE_DATA and stores the required
///               buffer size in the variable pointed to by <i>lpcbData</i>. In this case, the contents of the <i>lpData</i> buffer
///               are undefined. If <i>lpData</i> is <b>NULL</b>, and <i>lpcbData</i> is non-<b>NULL</b>, the function returns
///               ERROR_SUCCESS and stores the size of the data, in bytes, in the variable pointed to by <i>lpcbData</i>. This
///               enables an application to determine the best way to allocate a buffer for the value's data. If <i>hKey</i>
///               specifies <b>HKEY_PERFORMANCE_DATA</b> and the <i>lpData</i> buffer is not large enough to contain all of the
///               returned data, <b>RegQueryValueEx</b> returns ERROR_MORE_DATA and the value returned through the <i>lpcbData</i>
///               parameter is undefined. This is because the size of the performance data can change from one call to the next. In
///               this case, you must increase the buffer size and call <b>RegQueryValueEx</b> again passing the updated buffer
///               size in the <i>lpcbData</i> parameter. Repeat this until the function succeeds. You need to maintain a separate
///               variable to keep track of the buffer size, because the value returned by <i>lpcbData</i> is unpredictable. If the
///               <i>lpValueName</i> registry value does not exist, <b>RegQueryValueEx</b> returns ERROR_FILE_NOT_FOUND and the
///               value returned through the <i>lpcbData</i> parameter is undefined.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a system
///    error code. If the <i>lpData</i> buffer is too small to receive the data, the function returns ERROR_MORE_DATA.
///    If the <i>lpValueName</i> registry value does not exist, the function returns ERROR_FILE_NOT_FOUND.
///    
@DllImport("ADVAPI32")
LSTATUS RegQueryValueExW(HKEY hKey, const(wchar)* lpValueName, uint* lpReserved, uint* lpType, char* lpData, 
                         uint* lpcbData);

///Replaces the file backing a registry key and all its subkeys with another file, so that when the system is next
///started, the key and subkeys will have the values stored in the new file. Applications that back up or restore system
///state including system files and registry hives should use the Volume Shadow Copy Service instead of the registry
///functions.
///Params:
///    hKey = A handle to an open registry key. This handle is returned by the RegCreateKeyEx or RegOpenKeyEx function, or it
///           can be one of the following predefined keys: <b>HKEY_CLASSES_ROOT</b> <b>HKEY_CURRENT_CONFIG</b>
///           <b>HKEY_CURRENT_USER</b> <b>HKEY_LOCAL_MACHINE</b> <b>HKEY_USERS</b>
///    lpSubKey = The name of the registry key whose subkeys and values are to be replaced. If the key exists, it must be a subkey
///               of the key identified by the <i>hKey</i> parameter. If the subkey does not exist, it is created. This parameter
///               can be <b>NULL</b>. If the specified subkey is not the root of a hive, <b>RegReplaceKey</b> traverses up the hive
///               tree structure until it encounters a hive root, then it replaces the contents of that hive with the contents of
///               the data file specified by <i>lpNewFile</i>. For more information, see Registry Element Size Limits.
///    lpNewFile = The name of the file with the registry information. This file is typically created by using the RegSaveKey
///                function.
///    lpOldFile = The name of the file that receives a backup copy of the registry information being replaced.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegReplaceKeyA(HKEY hKey, const(char)* lpSubKey, const(char)* lpNewFile, const(char)* lpOldFile);

///Replaces the file backing a registry key and all its subkeys with another file, so that when the system is next
///started, the key and subkeys will have the values stored in the new file. Applications that back up or restore system
///state including system files and registry hives should use the Volume Shadow Copy Service instead of the registry
///functions.
///Params:
///    hKey = A handle to an open registry key. This handle is returned by the RegCreateKeyEx or RegOpenKeyEx function, or it
///           can be one of the following predefined keys: <b>HKEY_CLASSES_ROOT</b> <b>HKEY_CURRENT_CONFIG</b>
///           <b>HKEY_CURRENT_USER</b> <b>HKEY_LOCAL_MACHINE</b> <b>HKEY_USERS</b>
///    lpSubKey = The name of the registry key whose subkeys and values are to be replaced. If the key exists, it must be a subkey
///               of the key identified by the <i>hKey</i> parameter. If the subkey does not exist, it is created. This parameter
///               can be <b>NULL</b>. If the specified subkey is not the root of a hive, <b>RegReplaceKey</b> traverses up the hive
///               tree structure until it encounters a hive root, then it replaces the contents of that hive with the contents of
///               the data file specified by <i>lpNewFile</i>. For more information, see Registry Element Size Limits.
///    lpNewFile = The name of the file with the registry information. This file is typically created by using the RegSaveKey
///                function.
///    lpOldFile = The name of the file that receives a backup copy of the registry information being replaced.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegReplaceKeyW(HKEY hKey, const(wchar)* lpSubKey, const(wchar)* lpNewFile, const(wchar)* lpOldFile);

///Reads the registry information in a specified file and copies it over the specified key. This registry information
///may be in the form of a key and multiple levels of subkeys. Applications that back up or restore system state
///including system files and registry hives should use the Volume Shadow Copy Service instead of the registry
///functions.
///Params:
///    hKey = A handle to an open registry key. This handle is returned by the RegCreateKeyEx or RegOpenKeyEx function. It can
///           also be one of the following predefined keys: <b>HKEY_CLASSES_ROOT</b> <b>HKEY_CURRENT_CONFIG</b>
///           <b>HKEY_CURRENT_USER</b> <b>HKEY_LOCAL_MACHINE</b> <b>HKEY_USERS</b> Any information contained in this key and
///           its descendent keys is overwritten by the information in the file pointed to by the <i>lpFile</i> parameter.
///    lpFile = The name of the file with the registry information. This file is typically created by using the RegSaveKey
///             function.
///    dwFlags = The flags that indicate how the key or keys are to be restored. This parameter can be one of the following
///              values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="REG_FORCE_RESTORE"></a><a
///              id="reg_force_restore"></a><dl> <dt><b>REG_FORCE_RESTORE</b></dt> <dt>0x00000008L</dt> </dl> </td> <td
///              width="60%"> If specified, the restore operation is executed even if open handles exist at or beneath the
///              location in the registry hierarchy to which the <i>hKey</i> parameter points. </td> </tr> <tr> <td width="40%"><a
///              id="REG_WHOLE_HIVE_VOLATILE"></a><a id="reg_whole_hive_volatile"></a><dl> <dt><b>REG_WHOLE_HIVE_VOLATILE</b></dt>
///              <dt>0x00000001L</dt> </dl> </td> <td width="60%"> If specified, a new, volatile (memory only) set of registry
///              information, or hive, is created. If REG_WHOLE_HIVE_VOLATILE is specified, the key identified by the <i>hKey</i>
///              parameter must be either the <b>HKEY_USERS</b> or <b>HKEY_LOCAL_MACHINE</b> value. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegRestoreKeyA(HKEY hKey, const(char)* lpFile, uint dwFlags);

///Reads the registry information in a specified file and copies it over the specified key. This registry information
///may be in the form of a key and multiple levels of subkeys. Applications that back up or restore system state
///including system files and registry hives should use the Volume Shadow Copy Service instead of the registry
///functions.
///Params:
///    hKey = A handle to an open registry key. This handle is returned by the RegCreateKeyEx or RegOpenKeyEx function. It can
///           also be one of the following predefined keys: <b>HKEY_CLASSES_ROOT</b> <b>HKEY_CURRENT_CONFIG</b>
///           <b>HKEY_CURRENT_USER</b> <b>HKEY_LOCAL_MACHINE</b> <b>HKEY_USERS</b> Any information contained in this key and
///           its descendent keys is overwritten by the information in the file pointed to by the <i>lpFile</i> parameter.
///    lpFile = The name of the file with the registry information. This file is typically created by using the RegSaveKey
///             function.
///    dwFlags = The flags that indicate how the key or keys are to be restored. This parameter can be one of the following
///              values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="REG_FORCE_RESTORE"></a><a
///              id="reg_force_restore"></a><dl> <dt><b>REG_FORCE_RESTORE</b></dt> <dt>0x00000008L</dt> </dl> </td> <td
///              width="60%"> If specified, the restore operation is executed even if open handles exist at or beneath the
///              location in the registry hierarchy to which the <i>hKey</i> parameter points. </td> </tr> <tr> <td width="40%"><a
///              id="REG_WHOLE_HIVE_VOLATILE"></a><a id="reg_whole_hive_volatile"></a><dl> <dt><b>REG_WHOLE_HIVE_VOLATILE</b></dt>
///              <dt>0x00000001L</dt> </dl> </td> <td width="60%"> If specified, a new, volatile (memory only) set of registry
///              information, or hive, is created. If REG_WHOLE_HIVE_VOLATILE is specified, the key identified by the <i>hKey</i>
///              parameter must be either the <b>HKEY_USERS</b> or <b>HKEY_LOCAL_MACHINE</b> value. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegRestoreKeyW(HKEY hKey, const(wchar)* lpFile, uint dwFlags);

@DllImport("ADVAPI32")
LSTATUS RegRenameKey(HKEY hKey, const(wchar)* lpSubKeyName, const(wchar)* lpNewKeyName);

///Saves the specified key and all of its subkeys and values to a new file, in the standard format. To specify the
///format for the saved key or hive, use the RegSaveKeyEx function. Applications that back up or restore system state
///including system files and registry hives should use the Volume Shadow Copy Service instead of the registry
///functions.
///Params:
///    hKey = A handle to an open registry key. This handle is returned by the RegCreateKeyEx or RegOpenKeyEx function, or it
///           can be one of the following predefined keys: <dl> <dd><b>HKEY_CLASSES_ROOT</b></dd>
///           <dd><b>HKEY_CURRENT_USER</b></dd> </dl>
///    lpFile = The name of the file in which the specified key and subkeys are to be saved. If the file already exists, the
///             function fails. If the string does not include a path, the file is created in the current directory of the
///             calling process for a local key, or in the %systemroot%\system32 directory for a remote key. The new file has the
///             archive attribute.
///    lpSecurityAttributes = A pointer to a SECURITY_ATTRIBUTES structure that specifies a security descriptor for the new file. If
///                           <i>lpSecurityAttributes</i> is <b>NULL</b>, the file gets a default security descriptor. The ACLs in a default
///                           security descriptor for a file are inherited from its parent directory.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error. If the file already exists, the function fails with the
///    ERROR_ALREADY_EXISTS error.
///    
@DllImport("ADVAPI32")
LSTATUS RegSaveKeyA(HKEY hKey, const(char)* lpFile, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes);

///Saves the specified key and all of its subkeys and values to a new file, in the standard format. To specify the
///format for the saved key or hive, use the RegSaveKeyEx function. Applications that back up or restore system state
///including system files and registry hives should use the Volume Shadow Copy Service instead of the registry
///functions.
///Params:
///    hKey = A handle to an open registry key. This handle is returned by the RegCreateKeyEx or RegOpenKeyEx function, or it
///           can be one of the following predefined keys: <dl> <dd><b>HKEY_CLASSES_ROOT</b></dd>
///           <dd><b>HKEY_CURRENT_USER</b></dd> </dl>
///    lpFile = The name of the file in which the specified key and subkeys are to be saved. If the file already exists, the
///             function fails. If the string does not include a path, the file is created in the current directory of the
///             calling process for a local key, or in the %systemroot%\system32 directory for a remote key. The new file has the
///             archive attribute.
///    lpSecurityAttributes = A pointer to a SECURITY_ATTRIBUTES structure that specifies a security descriptor for the new file. If
///                           <i>lpSecurityAttributes</i> is <b>NULL</b>, the file gets a default security descriptor. The ACLs in a default
///                           security descriptor for a file are inherited from its parent directory.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error. If the file already exists, the function fails with the
///    ERROR_ALREADY_EXISTS error.
///    
@DllImport("ADVAPI32")
LSTATUS RegSaveKeyW(HKEY hKey, const(wchar)* lpFile, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes);

///Sets the data for the default or unnamed value of a specified registry key. The data must be a text string. <div
///class="alert"><b>Note</b> This function is provided only for compatibility with 16-bit versions of Windows.
///Applications should use the RegSetValueEx function.</div><div> </div>
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the KEY_SET_VALUE access right. For more
///           information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx,
///           RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function. It can also be one of the following
///           predefined keys:<dl> <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd>
///           <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_USERS</b></dd> </dl>
///    lpSubKey = The name of a subkey of the <i>hKey</i> parameter. The function sets the default value of the specified subkey.
///               If <i>lpSubKey</i> does not exist, the function creates it. Key names are not case sensitive. If this parameter
///               is <b>NULL</b> or points to an empty string, the function sets the default value of the key identified by
///               <i>hKey</i>. For more information, see Registry Element Size Limits.
///    dwType = The type of information to be stored. This parameter must be the REG_SZ type. To store other data types, use the
///             RegSetValueEx function.
///    lpData = The data to be stored. This parameter cannot be <b>NULL</b>.
///    cbData = This parameter is ignored. The function calculates this value based on the size of the data in the <i>lpData</i>
///             parameter.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegSetValueA(HKEY hKey, const(char)* lpSubKey, uint dwType, const(char)* lpData, uint cbData);

///Sets the data for the default or unnamed value of a specified registry key. The data must be a text string. <div
///class="alert"><b>Note</b> This function is provided only for compatibility with 16-bit versions of Windows.
///Applications should use the RegSetValueEx function.</div><div> </div>
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the KEY_SET_VALUE access right. For more
///           information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx,
///           RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function. It can also be one of the following
///           predefined keys:<dl> <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd>
///           <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_USERS</b></dd> </dl>
///    lpSubKey = The name of a subkey of the <i>hKey</i> parameter. The function sets the default value of the specified subkey.
///               If <i>lpSubKey</i> does not exist, the function creates it. Key names are not case sensitive. If this parameter
///               is <b>NULL</b> or points to an empty string, the function sets the default value of the key identified by
///               <i>hKey</i>. For more information, see Registry Element Size Limits.
///    dwType = The type of information to be stored. This parameter must be the REG_SZ type. To store other data types, use the
///             RegSetValueEx function.
///    lpData = The data to be stored. This parameter cannot be <b>NULL</b>.
///    cbData = This parameter is ignored. The function calculates this value based on the size of the data in the <i>lpData</i>
///             parameter.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegSetValueW(HKEY hKey, const(wchar)* lpSubKey, uint dwType, const(wchar)* lpData, uint cbData);

///Sets the data and type of a specified value under a registry key.
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the KEY_SET_VALUE access right. For more
///           information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx,
///           RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function. It can also be one of the following
///           predefined keys:<dl> <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd>
///           <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_USERS</b></dd> </dl>The Unicode
///           version of this function supports the following additional predefined keys:<ul>
///           <li><b>HKEY_PERFORMANCE_TEXT</b></li> <li><b>HKEY_PERFORMANCE_NLSTEXT</b></li> </ul>
///    lpValueName = The name of the value to be set. If a value with this name is not already present in the key, the function adds
///                  it to the key. If <i>lpValueName</i> is <b>NULL</b> or an empty string, "", the function sets the type and data
///                  for the key's unnamed or default value. For more information, see Registry Element Size Limits. Registry keys do
///                  not have default values, but they can have one unnamed value, which can be of any type.
///    Reserved = This parameter is reserved and must be zero.
///    dwType = The type of data pointed to by the <i>lpData</i> parameter. For a list of the possible types, see Registry Value
///             Types.
///    lpData = The data to be stored. For string-based types, such as REG_SZ, the string must be <b>null</b>-terminated. With
///             the REG_MULTI_SZ data type, the string must be terminated with two <b>null</b> characters. <div
///             class="alert"><b>Note</b> lpData indicating a <b>null</b> value is valid, however, if this is the case,
///             <i>cbData</i> must be set to '0'.</div> <div> </div>
///    cbData = The size of the information pointed to by the <i>lpData</i> parameter, in bytes. If the data is of type REG_SZ,
///             REG_EXPAND_SZ, or REG_MULTI_SZ, <i>cbData</i> must include the size of the terminating <b>null</b> character or
///             characters.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegSetValueExA(HKEY hKey, const(char)* lpValueName, uint Reserved, uint dwType, char* lpData, uint cbData);

///Sets the data and type of a specified value under a registry key.
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the KEY_SET_VALUE access right. For more
///           information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx,
///           RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function. It can also be one of the following
///           predefined keys:<dl> <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd>
///           <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_USERS</b></dd> </dl>The Unicode
///           version of this function supports the following additional predefined keys:<ul>
///           <li><b>HKEY_PERFORMANCE_TEXT</b></li> <li><b>HKEY_PERFORMANCE_NLSTEXT</b></li> </ul>
///    lpValueName = The name of the value to be set. If a value with this name is not already present in the key, the function adds
///                  it to the key. If <i>lpValueName</i> is <b>NULL</b> or an empty string, "", the function sets the type and data
///                  for the key's unnamed or default value. For more information, see Registry Element Size Limits. Registry keys do
///                  not have default values, but they can have one unnamed value, which can be of any type.
///    Reserved = This parameter is reserved and must be zero.
///    dwType = The type of data pointed to by the <i>lpData</i> parameter. For a list of the possible types, see Registry Value
///             Types.
///    lpData = The data to be stored. For string-based types, such as REG_SZ, the string must be <b>null</b>-terminated. With
///             the REG_MULTI_SZ data type, the string must be terminated with two <b>null</b> characters. <div
///             class="alert"><b>Note</b> lpData indicating a <b>null</b> value is valid, however, if this is the case,
///             <i>cbData</i> must be set to '0'.</div> <div> </div>
///    cbData = The size of the information pointed to by the <i>lpData</i> parameter, in bytes. If the data is of type REG_SZ,
///             REG_EXPAND_SZ, or REG_MULTI_SZ, <i>cbData</i> must include the size of the terminating <b>null</b> character or
///             characters.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegSetValueExW(HKEY hKey, const(wchar)* lpValueName, uint Reserved, uint dwType, char* lpData, uint cbData);

///Unloads the specified registry key and its subkeys from the registry. Applications that back up or restore system
///state including system files and registry hives should use the Volume Shadow Copy Service instead of the registry
///functions.
///Params:
///    hKey = A handle to the registry key to be unloaded. This parameter can be a handle returned by a call to
///           RegConnectRegistry function or one of the following predefined handles: <b>HKEY_LOCAL_MACHINE</b>
///           <b>HKEY_USERS</b>
///    lpSubKey = The name of the subkey to be unloaded. The key referred to by the <i>lpSubKey</i> parameter must have been
///               created by using the RegLoadKey function. Key names are not case sensitive. For more information, see Registry
///               Element Size Limits.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegUnLoadKeyA(HKEY hKey, const(char)* lpSubKey);

///Unloads the specified registry key and its subkeys from the registry. Applications that back up or restore system
///state including system files and registry hives should use the Volume Shadow Copy Service instead of the registry
///functions.
///Params:
///    hKey = A handle to the registry key to be unloaded. This parameter can be a handle returned by a call to
///           RegConnectRegistry function or one of the following predefined handles: * HKEY_LOCAL_MACHINE * HKEY_USERS
///    lpSubKey = The name of the subkey to be unloaded. The key referred to by the <i>lpSubKey</i> parameter must have been
///               created by using the RegLoadKey function. Key names are not case sensitive. For more information, see Registry
///               Element Size Limits.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegUnLoadKeyW(HKEY hKey, const(wchar)* lpSubKey);

///Removes the specified value from the specified registry key and subkey.
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the KEY_SET_VALUE access right. For more
///           information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx or
///           RegOpenKeyEx function, or it can be one of the following predefined keys: <pre xml:space="preserve"><b></b>
///           <b>HKEY_CLASSES_ROOT</b> <b>HKEY_CURRENT_CONFIG</b> <b>HKEY_CURRENT_USER</b> <b>HKEY_LOCAL_MACHINE</b>
///           <b>HKEY_USERS</b></pre>
///    lpSubKey = The name of the registry key. This key must be a subkey of the key identified by the <i>hKey</i> parameter.
///    lpValueName = The registry value to be removed from the key.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegDeleteKeyValueA(HKEY hKey, const(char)* lpSubKey, const(char)* lpValueName);

///Removes the specified value from the specified registry key and subkey.
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the KEY_SET_VALUE access right. For more
///           information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx or
///           RegOpenKeyEx function, or it can be one of the following predefined keys: <pre xml:space="preserve"><b></b>
///           <b>HKEY_CLASSES_ROOT</b> <b>HKEY_CURRENT_CONFIG</b> <b>HKEY_CURRENT_USER</b> <b>HKEY_LOCAL_MACHINE</b>
///           <b>HKEY_USERS</b></pre>
///    lpSubKey = The name of the registry key. This key must be a subkey of the key identified by the <i>hKey</i> parameter.
///    lpValueName = The registry value to be removed from the key.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegDeleteKeyValueW(HKEY hKey, const(wchar)* lpSubKey, const(wchar)* lpValueName);

///Sets the data for the specified value in the specified registry key and subkey.
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the KEY_SET_VALUE access right. For more
///           information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx,
///           RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function. It can also be one of the following
///           predefined keys: <pre xml:space="preserve"><b></b> <b>HKEY_CLASSES_ROOT</b> <b>HKEY_CURRENT_CONFIG</b>
///           <b>HKEY_CURRENT_USER</b> <b>HKEY_LOCAL_MACHINE</b> <b>HKEY_USERS</b></pre>
///    lpSubKey = The name of a key and a subkey to the key identified by <i>hKey</i>. If this parameter is <b>NULL</b>, then this
///               value is created in the key using the <i>hKey</i> value and the key gets a default security descriptor.
///    lpValueName = The name of the registry value whose data is to be updated.
///    dwType = The type of data pointed to by the <i>lpData</i> parameter. For a list of the possible types, see Registry Value
///             Types.
///    lpData = The data to be stored with the specified value name. For string-based types, such as REG_SZ, the string must be
///             null-terminated. With the REG_MULTI_SZ data type, the string must be terminated with two null characters.
///    cbData = The size of the information pointed to by the <i>lpData</i> parameter, in bytes. If the data is of type REG_SZ,
///             REG_EXPAND_SZ, or REG_MULTI_SZ, <i>cbData</i> must include the size of the terminating null character or
///             characters.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegSetKeyValueA(HKEY hKey, const(char)* lpSubKey, const(char)* lpValueName, uint dwType, char* lpData, 
                        uint cbData);

///Sets the data for the specified value in the specified registry key and subkey.
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the KEY_SET_VALUE access right. For more
///           information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx,
///           RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function. It can also be one of the following
///           predefined keys: <pre xml:space="preserve"><b></b> <b>HKEY_CLASSES_ROOT</b> <b>HKEY_CURRENT_CONFIG</b>
///           <b>HKEY_CURRENT_USER</b> <b>HKEY_LOCAL_MACHINE</b> <b>HKEY_USERS</b></pre>
///    lpSubKey = The name of a key and a subkey to the key identified by <i>hKey</i>. If this parameter is <b>NULL</b>, then this
///               value is created in the key using the <i>hKey</i> value and the key gets a default security descriptor.
///    lpValueName = The name of the registry value whose data is to be updated.
///    dwType = The type of data pointed to by the <i>lpData</i> parameter. For a list of the possible types, see Registry Value
///             Types.
///    lpData = The data to be stored with the specified value name. For string-based types, such as REG_SZ, the string must be
///             null-terminated. With the REG_MULTI_SZ data type, the string must be terminated with two null characters.
///    cbData = The size of the information pointed to by the <i>lpData</i> parameter, in bytes. If the data is of type REG_SZ,
///             REG_EXPAND_SZ, or REG_MULTI_SZ, <i>cbData</i> must include the size of the terminating null character or
///             characters.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegSetKeyValueW(HKEY hKey, const(wchar)* lpSubKey, const(wchar)* lpValueName, uint dwType, char* lpData, 
                        uint cbData);

///Deletes the subkeys and values of the specified key recursively.
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the following access rights: DELETE,
///           KEY_ENUMERATE_SUB_KEYS, and KEY_QUERY_VALUE. For more information, see Registry Key Security and Access Rights.
///           This handle is returned by the RegCreateKeyEx or RegOpenKeyEx function, or it can be one of the following
///           Predefined Keys:<dl> <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd>
///           <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_USERS</b></dd> </dl>
///    lpSubKey = The name of the key. This key must be a subkey of the key identified by the <i>hKey</i> parameter. If this
///               parameter is <b>NULL</b>, the subkeys and values of <i>hKey</i> are deleted.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegDeleteTreeA(HKEY hKey, const(char)* lpSubKey);

///Deletes the subkeys and values of the specified key recursively.
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the following access rights: DELETE,
///           KEY_ENUMERATE_SUB_KEYS, and KEY_QUERY_VALUE. For more information, see Registry Key Security and Access Rights.
///           This handle is returned by the RegCreateKeyEx or RegOpenKeyEx function, or it can be one of the following
///           Predefined Keys:<dl> <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd>
///           <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_USERS</b></dd> </dl>
///    lpSubKey = The name of the key. This key must be a subkey of the key identified by the <i>hKey</i> parameter. If this
///               parameter is <b>NULL</b>, the subkeys and values of <i>hKey</i> are deleted.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegDeleteTreeW(HKEY hKey, const(wchar)* lpSubKey);

///Copies the specified registry key, along with its values and subkeys, to the specified destination key.
///Params:
///    hKeySrc = A handle to an open registry key. The key must have been opened with the KEY_READ access right. For more
///              information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx or
///              RegOpenKeyEx function, or it can be one of the predefined keys.
///    lpSubKey = The name of the key. This key must be a subkey of the key identified by the <i>hKeySrc</i> parameter. This
///               parameter can also be <b>NULL</b>.
///    hKeyDest = A handle to the destination key. The calling process must have KEY_CREATE_SUB_KEY access to the key. This handle
///               is returned by the RegCreateKeyEx or RegOpenKeyEx function, or it can be one of the predefined keys.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegCopyTreeA(HKEY hKeySrc, const(char)* lpSubKey, HKEY hKeyDest);

///Retrieves the type and data for the specified registry value.
///Params:
///    hkey = A handle to an open registry key. The key must have been opened with the KEY_QUERY_VALUE access right. For more
///           information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx,
///           RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function. It can also be one of the following
///           predefined keys:<dl> <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd>
///           <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_PERFORMANCE_DATA</b></dd>
///           <dd><b>HKEY_PERFORMANCE_NLSTEXT</b></dd> <dd><b>HKEY_PERFORMANCE_TEXT</b></dd> <dd><b>HKEY_USERS</b></dd> </dl>
///    lpSubKey = The path of a registry key relative to the key specified by the *hkey* parameter. The registry value will be
///               retrieved from this subkey. The path is not case sensitive. If this parameter is **NULL** or an empty string, "",
///               the value will be read from the key specified by *hkey* itself.
///    lpValue = The name of the registry value. If this parameter is **NULL** or an empty string, "", the function retrieves the
///              type and data for the key's unnamed or default value, if any. Keys do not automatically have an unnamed or
///              default value, and unnamed values can be of any type. For more information, see [Registry Element Size
///              Limits](/windows/win32/sysinfo/registry-element-size-limits).
///    dwFlags = The flags that restrict the data type of value to be queried. If the data type of the value does not meet this
///              criteria, the function fails. This parameter can be one or more of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RRF_RT_ANY"></a><a id="rrf_rt_any"></a><dl>
///              <dt><b>RRF_RT_ANY</b></dt> <dt>0x0000ffff</dt> </dl> </td> <td width="60%"> No type restriction. </td> </tr> <tr>
///              <td width="40%"><a id="RRF_RT_DWORD"></a><a id="rrf_rt_dword"></a><dl> <dt><b>RRF_RT_DWORD</b></dt>
///              <dt>0x00000018</dt> </dl> </td> <td width="60%"> Restrict type to 32-bit RRF_RT_REG_BINARY | RRF_RT_REG_DWORD.
///              </td> </tr> <tr> <td width="40%"><a id="RRF_RT_QWORD"></a><a id="rrf_rt_qword"></a><dl>
///              <dt><b>RRF_RT_QWORD</b></dt> <dt>0x00000048</dt> </dl> </td> <td width="60%"> Restrict type to 64-bit
///              RRF_RT_REG_BINARY | RRF_RT_REG_QWORD. </td> </tr> <tr> <td width="40%"><a id="RRF_RT_REG_BINARY"></a><a
///              id="rrf_rt_reg_binary"></a><dl> <dt><b>RRF_RT_REG_BINARY</b></dt> <dt>0x00000008</dt> </dl> </td> <td
///              width="60%"> Restrict type to REG_BINARY. </td> </tr> <tr> <td width="40%"><a id="RRF_RT_REG_DWORD"></a><a
///              id="rrf_rt_reg_dword"></a><dl> <dt><b>RRF_RT_REG_DWORD</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%">
///              Restrict type to REG_DWORD. </td> </tr> <tr> <td width="40%"><a id="RRF_RT_REG_EXPAND_SZ"></a><a
///              id="rrf_rt_reg_expand_sz"></a><dl> <dt><b>RRF_RT_REG_EXPAND_SZ</b></dt> <dt>0x00000004</dt> </dl> </td> <td
///              width="60%"> Restrict type to REG_EXPAND_SZ. </td> </tr> <tr> <td width="40%"><a id="RRF_RT_REG_MULTI_SZ"></a><a
///              id="rrf_rt_reg_multi_sz"></a><dl> <dt><b>RRF_RT_REG_MULTI_SZ</b></dt> <dt>0x00000020</dt> </dl> </td> <td
///              width="60%"> Restrict type to REG_MULTI_SZ. </td> </tr> <tr> <td width="40%"><a id="RRF_RT_REG_NONE"></a><a
///              id="rrf_rt_reg_none"></a><dl> <dt><b>RRF_RT_REG_NONE</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%">
///              Restrict type to REG_NONE. </td> </tr> <tr> <td width="40%"><a id="RRF_RT_REG_QWORD"></a><a
///              id="rrf_rt_reg_qword"></a><dl> <dt><b>RRF_RT_REG_QWORD</b></dt> <dt>0x00000040</dt> </dl> </td> <td width="60%">
///              Restrict type to REG_QWORD. </td> </tr> <tr> <td width="40%"><a id="RRF_RT_REG_SZ"></a><a
///              id="rrf_rt_reg_sz"></a><dl> <dt><b>RRF_RT_REG_SZ</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%">
///              Restrict type to REG_SZ. </td> </tr> </table> This parameter can also include one or more of the following
///              values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RRF_NOEXPAND"></a><a
///              id="rrf_noexpand"></a><dl> <dt><b>RRF_NOEXPAND</b></dt> <dt>0x10000000</dt> </dl> </td> <td width="60%"> Do not
///              automatically expand environment strings if the value is of type REG_EXPAND_SZ. </td> </tr> <tr> <td
///              width="40%"><a id="RRF_ZEROONFAILURE"></a><a id="rrf_zeroonfailure"></a><dl> <dt><b>RRF_ZEROONFAILURE</b></dt>
///              <dt>0x20000000</dt> </dl> </td> <td width="60%"> If <i>pvData</i> is not <b>NULL</b>, set the contents of the
///              buffer to zeroes on failure. </td> </tr> <tr> <td width="40%"><a id="RRF_SUBKEY_WOW6464KEY"></a><a
///              id="rrf_subkey_wow6464key"></a><dl> <dt><b>RRF_SUBKEY_WOW6464KEY</b></dt> <dt>0x00010000</dt> </dl> </td> <td
///              width="60%"> If <i>lpSubKey</i> is not <b>NULL</b>, open the subkey that <i>lpSubKey</i> specifies with the
///              KEY_WOW64_64KEY access rights. For information about these access rights, see Registry Key Security and Access
///              Rights. You cannot specify <b>RRF_SUBKEY_WOW6464KEY</b> in combination with <b>RRF_SUBKEY_WOW6432KEY</b>. </td>
///              </tr> <tr> <td width="40%"><a id="RRF_SUBKEY_WOW6432KEY"></a><a id="rrf_subkey_wow6432key"></a><dl>
///              <dt><b>RRF_SUBKEY_WOW6432KEY</b></dt> <dt>0x00020000</dt> </dl> </td> <td width="60%"> If <i>lpSubKey</i> is not
///              <b>NULL</b>, open the subkey that <i>lpSubKey</i> specifies with the KEY_WOW64_32KEY access rights. For
///              information about these access rights, see Registry Key Security and Access Rights. You cannot specify
///              <b>RRF_SUBKEY_WOW6432KEY</b> in combination with <b>RRF_SUBKEY_WOW6464KEY</b>. </td> </tr> </table>
///    pdwType = A pointer to a variable that receives a code indicating the type of data stored in the specified value. For a
///              list of the possible type codes, see Registry Value Types. This parameter can be <b>NULL</b> if the type is not
///              required.
///    pvData = A pointer to a buffer that receives the value's data. This parameter can be <b>NULL</b> if the data is not
///             required. If the data is a string, the function checks for a terminating <b>null</b> character. If one is not
///             found, the string is stored with a <b>null</b> terminator if the buffer is large enough to accommodate the extra
///             character. Otherwise, the function fails and returns ERROR_MORE_DATA.
///    pcbData = A pointer to a variable that specifies the size of the buffer pointed to by the <i>pvData</i> parameter, in
///              bytes. When the function returns, this variable contains the size of the data copied to <i>pvData</i>. The
///              <i>pcbData</i> parameter can be <b>NULL</b> only if <i>pvData</i> is <b>NULL</b>. If the data has the REG_SZ,
///              REG_MULTI_SZ or REG_EXPAND_SZ type, this size includes any terminating <b>null</b> character or characters. For
///              more information, see Remarks. If the buffer specified by <i>pvData</i> parameter is not large enough to hold the
///              data, the function returns ERROR_MORE_DATA and stores the required buffer size in the variable pointed to by
///              <i>pcbData</i>. In this case, the contents of the <i>pvData</i> buffer are zeroes if dwFlags specifies
///              RRF_ZEROONFAILURE and undefined otherwise. If <i>pvData</i> is <b>NULL</b>, and <i>pcbData</i> is
///              non-<b>NULL</b>, the function returns ERROR_SUCCESS and stores the size of the data, in bytes, in the variable
///              pointed to by <i>pcbData</i>. This enables an application to determine the best way to allocate a buffer for the
///              value's data. If <i>hKey</i> specifies <b>HKEY_PERFORMANCE_DATA</b> and the <i>pvData</i> buffer is not large
///              enough to contain all of the returned data, the function returns ERROR_MORE_DATA and the value returned through
///              the <i>pcbData</i> parameter is undefined. This is because the size of the performance data can change from one
///              call to the next. In this case, you must increase the buffer size and call <b>RegGetValue</b> again passing the
///              updated buffer size in the <i>pcbData</i> parameter. Repeat this until the function succeeds. You need to
///              maintain a separate variable to keep track of the buffer size, because the value returned by <i>pcbData</i> is
///              unpredictable.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a system
///    error code. If the <i>pvData</i> buffer is too small to receive the value, the function returns ERROR_MORE_DATA.
///    If <i>dwFlags</i> specifies a combination of both <b>RRF_SUBKEY_WOW6464KEY</b> and <b>RRF_SUBKEY_WOW6432KEY</b>,
///    the function returns ERROR_INVALID_PARAMETER.
///    
@DllImport("ADVAPI32")
LSTATUS RegGetValueA(HKEY hkey, const(char)* lpSubKey, const(char)* lpValue, uint dwFlags, uint* pdwType, 
                     char* pvData, uint* pcbData);

///Retrieves the type and data for the specified registry value.
///Params:
///    hkey = A handle to an open registry key. The key must have been opened with the KEY_QUERY_VALUE access right. For more
///           information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx,
///           RegCreateKeyTransacted, RegOpenKeyEx, or RegOpenKeyTransacted function. It can also be one of the following
///           predefined keys:<dl> <dd><b>HKEY_CLASSES_ROOT</b></dd> <dd><b>HKEY_CURRENT_CONFIG</b></dd>
///           <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd> <dd><b>HKEY_PERFORMANCE_DATA</b></dd>
///           <dd><b>HKEY_PERFORMANCE_NLSTEXT</b></dd> <dd><b>HKEY_PERFORMANCE_TEXT</b></dd> <dd><b>HKEY_USERS</b></dd> </dl>
///    lpSubKey = The path of a registry key relative to the key specified by the *hkey* parameter. The registry value will be
///               retrieved from this subkey. The path is not case sensitive. If this parameter is **NULL** or an empty string, "",
///               the value will be read from the key specified by *hkey* itself.
///    lpValue = The name of the registry value. If this parameter is **NULL** or an empty string, "", the function retrieves the
///              type and data for the key's unnamed or default value, if any. Keys do not automatically have an unnamed or
///              default value, and unnamed values can be of any type. For more information, see [Registry Element Size
///              Limits](/windows/win32/sysinfo/registry-element-size-limits).
///    dwFlags = The flags that restrict the data type of value to be queried. If the data type of the value does not meet this
///              criteria, the function fails. This parameter can be one or more of the following values. <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RRF_RT_ANY"></a><a id="rrf_rt_any"></a><dl>
///              <dt><b>RRF_RT_ANY</b></dt> <dt>0x0000ffff</dt> </dl> </td> <td width="60%"> No type restriction. </td> </tr> <tr>
///              <td width="40%"><a id="RRF_RT_DWORD"></a><a id="rrf_rt_dword"></a><dl> <dt><b>RRF_RT_DWORD</b></dt>
///              <dt>0x00000018</dt> </dl> </td> <td width="60%"> Restrict type to 32-bit RRF_RT_REG_BINARY | RRF_RT_REG_DWORD.
///              </td> </tr> <tr> <td width="40%"><a id="RRF_RT_QWORD"></a><a id="rrf_rt_qword"></a><dl>
///              <dt><b>RRF_RT_QWORD</b></dt> <dt>0x00000048</dt> </dl> </td> <td width="60%"> Restrict type to 64-bit
///              RRF_RT_REG_BINARY | RRF_RT_REG_DWORD. </td> </tr> <tr> <td width="40%"><a id="RRF_RT_REG_BINARY"></a><a
///              id="rrf_rt_reg_binary"></a><dl> <dt><b>RRF_RT_REG_BINARY</b></dt> <dt>0x00000008</dt> </dl> </td> <td
///              width="60%"> Restrict type to REG_BINARY. </td> </tr> <tr> <td width="40%"><a id="RRF_RT_REG_DWORD"></a><a
///              id="rrf_rt_reg_dword"></a><dl> <dt><b>RRF_RT_REG_DWORD</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%">
///              Restrict type to REG_DWORD. </td> </tr> <tr> <td width="40%"><a id="RRF_RT_REG_EXPAND_SZ"></a><a
///              id="rrf_rt_reg_expand_sz"></a><dl> <dt><b>RRF_RT_REG_EXPAND_SZ</b></dt> <dt>0x00000004</dt> </dl> </td> <td
///              width="60%"> Restrict type to REG_EXPAND_SZ. </td> </tr> <tr> <td width="40%"><a id="RRF_RT_REG_MULTI_SZ"></a><a
///              id="rrf_rt_reg_multi_sz"></a><dl> <dt><b>RRF_RT_REG_MULTI_SZ</b></dt> <dt>0x00000020</dt> </dl> </td> <td
///              width="60%"> Restrict type to REG_MULTI_SZ. </td> </tr> <tr> <td width="40%"><a id="RRF_RT_REG_NONE"></a><a
///              id="rrf_rt_reg_none"></a><dl> <dt><b>RRF_RT_REG_NONE</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%">
///              Restrict type to REG_NONE. </td> </tr> <tr> <td width="40%"><a id="RRF_RT_REG_QWORD"></a><a
///              id="rrf_rt_reg_qword"></a><dl> <dt><b>RRF_RT_REG_QWORD</b></dt> <dt>0x00000040</dt> </dl> </td> <td width="60%">
///              Restrict type to REG_QWORD. </td> </tr> <tr> <td width="40%"><a id="RRF_RT_REG_SZ"></a><a
///              id="rrf_rt_reg_sz"></a><dl> <dt><b>RRF_RT_REG_SZ</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%">
///              Restrict type to REG_SZ. </td> </tr> </table> This parameter can also include one or more of the following
///              values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RRF_NOEXPAND"></a><a
///              id="rrf_noexpand"></a><dl> <dt><b>RRF_NOEXPAND</b></dt> <dt>0x10000000</dt> </dl> </td> <td width="60%"> Do not
///              automatically expand environment strings if the value is of type REG_EXPAND_SZ. </td> </tr> <tr> <td
///              width="40%"><a id="RRF_ZEROONFAILURE"></a><a id="rrf_zeroonfailure"></a><dl> <dt><b>RRF_ZEROONFAILURE</b></dt>
///              <dt>0x20000000</dt> </dl> </td> <td width="60%"> If <i>pvData</i> is not <b>NULL</b>, set the contents of the
///              buffer to zeroes on failure. </td> </tr> <tr> <td width="40%"><a id="RRF_SUBKEY_WOW6464KEY"></a><a
///              id="rrf_subkey_wow6464key"></a><dl> <dt><b>RRF_SUBKEY_WOW6464KEY</b></dt> <dt>0x00010000</dt> </dl> </td> <td
///              width="60%"> If <i>lpSubKey</i> is not <b>NULL</b>, open the subkey that <i>lpSubKey</i> specifies with the
///              KEY_WOW64_64KEY access rights. For information about these access rights, see Registry Key Security and Access
///              Rights. You cannot specify <b>RRF_SUBKEY_WOW6464KEY</b> in combination with <b>RRF_SUBKEY_WOW6432KEY</b>. </td>
///              </tr> <tr> <td width="40%"><a id="RRF_SUBKEY_WOW6432KEY"></a><a id="rrf_subkey_wow6432key"></a><dl>
///              <dt><b>RRF_SUBKEY_WOW6432KEY</b></dt> <dt>0x00020000</dt> </dl> </td> <td width="60%"> If <i>lpSubKey</i> is not
///              <b>NULL</b>, open the subkey that <i>lpSubKey</i> specifies with the KEY_WOW64_32KEY access rights. For
///              information about these access rights, see Registry Key Security and Access Rights. You cannot specify
///              <b>RRF_SUBKEY_WOW6432KEY</b> in combination with <b>RRF_SUBKEY_WOW6464KEY</b>. </td> </tr> </table>
///    pdwType = A pointer to a variable that receives a code indicating the type of data stored in the specified value. For a
///              list of the possible type codes, see Registry Value Types. This parameter can be <b>NULL</b> if the type is not
///              required.
///    pvData = A pointer to a buffer that receives the value's data. This parameter can be <b>NULL</b> if the data is not
///             required. If the data is a string, the function checks for a terminating <b>null</b> character. If one is not
///             found, the string is stored with a <b>null</b> terminator if the buffer is large enough to accommodate the extra
///             character. Otherwise, the function fails and returns ERROR_MORE_DATA.
///    pcbData = A pointer to a variable that specifies the size of the buffer pointed to by the <i>pvData</i> parameter, in
///              bytes. When the function returns, this variable contains the size of the data copied to <i>pvData</i>. The
///              <i>pcbData</i> parameter can be <b>NULL</b> only if <i>pvData</i> is <b>NULL</b>. If the data has the REG_SZ,
///              REG_MULTI_SZ or REG_EXPAND_SZ type, this size includes any terminating <b>null</b> character or characters. For
///              more information, see Remarks. If the buffer specified by <i>pvData</i> parameter is not large enough to hold the
///              data, the function returns ERROR_MORE_DATA and stores the required buffer size in the variable pointed to by
///              <i>pcbData</i>. In this case, the contents of the <i>pvData</i> buffer are zeroes if dwFlags specifies
///              RRF_ZEROONFAILURE and undefined otherwise. If <i>pvData</i> is <b>NULL</b>, and <i>pcbData</i> is
///              non-<b>NULL</b>, the function returns ERROR_SUCCESS and stores the size of the data, in bytes, in the variable
///              pointed to by <i>pcbData</i>. This enables an application to determine the best way to allocate a buffer for the
///              value's data. If <i>hKey</i> specifies <b>HKEY_PERFORMANCE_DATA</b> and the <i>pvData</i> buffer is not large
///              enough to contain all of the returned data, the function returns ERROR_MORE_DATA and the value returned through
///              the <i>pcbData</i> parameter is undefined. This is because the size of the performance data can change from one
///              call to the next. In this case, you must increase the buffer size and call <b>RegGetValue</b> again passing the
///              updated buffer size in the <i>pcbData</i> parameter. Repeat this until the function succeeds. You need to
///              maintain a separate variable to keep track of the buffer size, because the value returned by <i>pcbData</i> is
///              unpredictable.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a system
///    error code. If the <i>pvData</i> buffer is too small to receive the value, the function returns ERROR_MORE_DATA.
///    If <i>dwFlags</i> specifies a combination of both <b>RRF_SUBKEY_WOW6464KEY</b> and <b>RRF_SUBKEY_WOW6432KEY</b>,
///    the function returns ERROR_INVALID_PARAMETER.
///    
@DllImport("ADVAPI32")
LSTATUS RegGetValueW(HKEY hkey, const(wchar)* lpSubKey, const(wchar)* lpValue, uint dwFlags, uint* pdwType, 
                     char* pvData, uint* pcbData);

///Copies the specified registry key, along with its values and subkeys, to the specified destination key.
///Params:
///    hKeySrc = A handle to an open registry key. The key must have been opened with the KEY_READ access right. For more
///              information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx or
///              RegOpenKeyEx function, or it can be one of the predefined keys.
///    lpSubKey = The name of the key. This key must be a subkey of the key identified by the <i>hKeySrc</i> parameter. This
///               parameter can also be <b>NULL</b>.
///    hKeyDest = A handle to the destination key. The calling process must have KEY_CREATE_SUB_KEY access to the key. This handle
///               is returned by the RegCreateKeyEx or RegOpenKeyEx function, or it can be one of the predefined keys.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegCopyTreeW(HKEY hKeySrc, const(wchar)* lpSubKey, HKEY hKeyDest);

///Loads the specified string from the specified key and subkey.
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the KEY_QUERY_VALUE access right. For more
///           information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx or
///           RegOpenKeyEx function. It can also be one of the following predefined keys:<dl> <dd><b>HKEY_CLASSES_ROOT</b></dd>
///           <dd><b>HKEY_CURRENT_CONFIG</b></dd> <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd>
///           <dd><b>HKEY_USERS</b></dd> </dl>
///    pszValue = The name of the registry value.
///    pszOutBuf = A pointer to a buffer that receives the string. Strings of the following form receive special handling:
///                @[<i>path</i>]&
///    cbOutBuf = The size of the <i>pszOutBuf</i> buffer, in bytes.
///    pcbData = A pointer to a variable that receives the size of the data copied to the <i>pszOutBuf</i> buffer, in bytes. If
///              the buffer is not large enough to hold the data, the function returns ERROR_MORE_DATA and stores the required
///              buffer size in the variable pointed to by <i>pcbData</i>. In this case, the contents of the buffer are undefined.
///    Flags = This parameter can be 0 or the following value. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///            width="40%"><a id="REG_MUI_STRING_TRUNCATE"></a><a id="reg_mui_string_truncate"></a><dl>
///            <dt><b>REG_MUI_STRING_TRUNCATE</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> The string is truncated
///            to fit the available size of the <i>pszOutBuf</i> buffer. If this flag is specified, <i>pcbData</i> must be
///            <b>NULL</b>. </td> </tr> </table>
///    pszDirectory = The directory path.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a system
///    error code. If the <i>pcbData</i> buffer is too small to receive the string, the function returns
///    ERROR_MORE_DATA. The ANSI version of this function returns ERROR_CALL_NOT_IMPLEMENTED.
///    
@DllImport("ADVAPI32")
LSTATUS RegLoadMUIStringA(HKEY hKey, const(char)* pszValue, const(char)* pszOutBuf, uint cbOutBuf, uint* pcbData, 
                          uint Flags, const(char)* pszDirectory);

///Loads the specified string from the specified key and subkey.
///Params:
///    hKey = A handle to an open registry key. The key must have been opened with the KEY_QUERY_VALUE access right. For more
///           information, see Registry Key Security and Access Rights. This handle is returned by the RegCreateKeyEx or
///           RegOpenKeyEx function. It can also be one of the following predefined keys:<dl> <dd><b>HKEY_CLASSES_ROOT</b></dd>
///           <dd><b>HKEY_CURRENT_CONFIG</b></dd> <dd><b>HKEY_CURRENT_USER</b></dd> <dd><b>HKEY_LOCAL_MACHINE</b></dd>
///           <dd><b>HKEY_USERS</b></dd> </dl>
///    pszValue = The name of the registry value.
///    pszOutBuf = A pointer to a buffer that receives the string. Strings of the following form receive special handling:
///                @[<i>path</i>]&
///    cbOutBuf = The size of the <i>pszOutBuf</i> buffer, in bytes.
///    pcbData = A pointer to a variable that receives the size of the data copied to the <i>pszOutBuf</i> buffer, in bytes. If
///              the buffer is not large enough to hold the data, the function returns ERROR_MORE_DATA and stores the required
///              buffer size in the variable pointed to by <i>pcbData</i>. In this case, the contents of the buffer are undefined.
///    Flags = This parameter can be 0 or the following value. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///            width="40%"><a id="REG_MUI_STRING_TRUNCATE"></a><a id="reg_mui_string_truncate"></a><dl>
///            <dt><b>REG_MUI_STRING_TRUNCATE</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> The string is truncated
///            to fit the available size of the <i>pszOutBuf</i> buffer. If this flag is specified, <i>pcbData</i> must be
///            <b>NULL</b>. </td> </tr> </table>
///    pszDirectory = The directory path.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a system
///    error code. If the <i>pcbData</i> buffer is too small to receive the string, the function returns
///    ERROR_MORE_DATA. The ANSI version of this function returns ERROR_CALL_NOT_IMPLEMENTED.
///    
@DllImport("ADVAPI32")
LSTATUS RegLoadMUIStringW(HKEY hKey, const(wchar)* pszValue, const(wchar)* pszOutBuf, uint cbOutBuf, uint* pcbData, 
                          uint Flags, const(wchar)* pszDirectory);

///Loads the specified registry hive as an application hive.
///Params:
///    lpFile = The name of the hive file. This hive must have been created with the RegSaveKey or RegSaveKeyEx function. If the
///             file does not exist, an empty hive file is created with the specified name.
///    phkResult = Pointer to the handle for the root key of the loaded hive. The only way to access keys in the hive is through
///                this handle. The registry will prevent an application from accessing keys in this hive using an absolute path to
///                the key. As a result, it is not possible to navigate to this hive through the registry's namespace.
///    samDesired = A mask that specifies the access rights requested for the returned root key. For more information, see Registry
///                 Key Security and Access Rights.
///    dwOptions = If this parameter is REG_PROCESS_APPKEY, the hive cannot be loaded again while it is loaded by the caller. This
///                prevents access to this registry hive by another caller.
///    Reserved = This parameter is reserved.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegLoadAppKeyA(const(char)* lpFile, HKEY* phkResult, uint samDesired, uint dwOptions, uint Reserved);

///Loads the specified registry hive as an application hive.
///Params:
///    lpFile = The name of the hive file. This hive must have been created with the RegSaveKey or RegSaveKeyEx function. If the
///             file does not exist, an empty hive file is created with the specified name.
///    phkResult = Pointer to the handle for the root key of the loaded hive. The only way to access keys in the hive is through
///                this handle. The registry will prevent an application from accessing keys in this hive using an absolute path to
///                the key. As a result, it is not possible to navigate to this hive through the registry's namespace.
///    samDesired = A mask that specifies the access rights requested for the returned root key. For more information, see Registry
///                 Key Security and Access Rights.
///    dwOptions = If this parameter is REG_PROCESS_APPKEY, the hive cannot be loaded again while it is loaded by the caller. This
///                prevents access to this registry hive by another caller.
///    Reserved = This parameter is reserved.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error.
///    
@DllImport("ADVAPI32")
LSTATUS RegLoadAppKeyW(const(wchar)* lpFile, HKEY* phkResult, uint samDesired, uint dwOptions, uint Reserved);

@DllImport("ADVAPI32")
uint CheckForHiberboot(ubyte* pHiberboot, ubyte bClearFlag);

///Saves the specified key and all of its subkeys and values to a registry file, in the specified format. Applications
///that back up or restore system state including system files and registry hives should use the Volume Shadow Copy
///Service instead of the registry functions.
///Params:
///    hKey = A handle to an open registry key. This function does not support the <b>HKEY_CLASSES_ROOT</b> predefined key.
///    lpFile = The name of the file in which the specified key and subkeys are to be saved. If the file already exists, the
///             function fails. The new file has the archive attribute. If the string does not include a path, the file is
///             created in the current directory of the calling process for a local key, or in the %systemroot%\system32
///             directory for a remote key.
///    lpSecurityAttributes = A pointer to a SECURITY_ATTRIBUTES structure that specifies a security descriptor for the new file. If
///                           <i>lpSecurityAttributes</i> is <b>NULL</b>, the file gets a default security descriptor. The ACLs in a default
///                           security descriptor for a file are inherited from its parent directory.
///    Flags = The format of the saved key or hive. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="REG_STANDARD_FORMAT"></a><a
///            id="reg_standard_format"></a><dl> <dt><b>REG_STANDARD_FORMAT</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The
///            key or hive is saved in standard format. The standard format is the only format supported by Windows 2000. </td>
///            </tr> <tr> <td width="40%"><a id="REG_LATEST_FORMAT"></a><a id="reg_latest_format"></a><dl>
///            <dt><b>REG_LATEST_FORMAT</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The key or hive is saved in the latest
///            format. The latest format is supported starting with Windows XP. After the key or hive is saved in this format,
///            it cannot be loaded on an earlier system. </td> </tr> <tr> <td width="40%"><a id="REG_NO_COMPRESSION"></a><a
///            id="reg_no_compression"></a><dl> <dt><b>REG_NO_COMPRESSION</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> The
///            hive is saved with no compression, for faster save operations. The <i>hKey</i> parameter must specify the root of
///            a hive under <b>HKEY_LOCAL_MACHINE </b> or <b>HKEY_USERS</b>. For example, <b>HKLM\SOFTWARE</b> is the root of a
///            hive. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error. If more than one of the possible values listed above for the
///    <i>Flags</i> parameter is specified in one call to this function—for example, if two or more values are
///    OR'ed— or if REG_NO_COMPRESSION is specified and <i>hKey</i> specifies a key that is not the root of a hive,
///    this function returns ERROR_INVALID_PARAMETER.
///    
@DllImport("ADVAPI32")
LSTATUS RegSaveKeyExA(HKEY hKey, const(char)* lpFile, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes, uint Flags);

///Saves the specified key and all of its subkeys and values to a registry file, in the specified format. Applications
///that back up or restore system state including system files and registry hives should use the Volume Shadow Copy
///Service instead of the registry functions.
///Params:
///    hKey = A handle to an open registry key. This function does not support the <b>HKEY_CLASSES_ROOT</b> predefined key.
///    lpFile = The name of the file in which the specified key and subkeys are to be saved. If the file already exists, the
///             function fails. The new file has the archive attribute. If the string does not include a path, the file is
///             created in the current directory of the calling process for a local key, or in the %systemroot%\system32
///             directory for a remote key.
///    lpSecurityAttributes = A pointer to a SECURITY_ATTRIBUTES structure that specifies a security descriptor for the new file. If
///                           <i>lpSecurityAttributes</i> is <b>NULL</b>, the file gets a default security descriptor. The ACLs in a default
///                           security descriptor for a file are inherited from its parent directory.
///    Flags = The format of the saved key or hive. This parameter can be one of the following values. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="REG_STANDARD_FORMAT"></a><a
///            id="reg_standard_format"></a><dl> <dt><b>REG_STANDARD_FORMAT</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The
///            key or hive is saved in standard format. The standard format is the only format supported by Windows 2000. </td>
///            </tr> <tr> <td width="40%"><a id="REG_LATEST_FORMAT"></a><a id="reg_latest_format"></a><dl>
///            <dt><b>REG_LATEST_FORMAT</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The key or hive is saved in the latest
///            format. The latest format is supported starting with Windows XP. After the key or hive is saved in this format,
///            it cannot be loaded on an earlier system. </td> </tr> <tr> <td width="40%"><a id="REG_NO_COMPRESSION"></a><a
///            id="reg_no_compression"></a><dl> <dt><b>REG_NO_COMPRESSION</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> The
///            hive is saved with no compression, for faster save operations. The <i>hKey</i> parameter must specify the root of
///            a hive under <b>HKEY_LOCAL_MACHINE </b> or <b>HKEY_USERS</b>. For example, <b>HKLM\SOFTWARE</b> is the root of a
///            hive. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is a nonzero
///    error code defined in Winerror.h. You can use the FormatMessage function with the FORMAT_MESSAGE_FROM_SYSTEM flag
///    to get a generic description of the error. If more than one of the possible values listed above for the
///    <i>Flags</i> parameter is specified in one call to this function—for example, if two or more values are
///    OR'ed— or if REG_NO_COMPRESSION is specified and <i>hKey</i> specifies a key that is not the root of a hive,
///    this function returns ERROR_INVALID_PARAMETER.
///    
@DllImport("ADVAPI32")
LSTATUS RegSaveKeyExW(HKEY hKey, const(wchar)* lpFile, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes, 
                      uint Flags);

///Deprecated. Closes the specified handle. <b>NtClose</b> is superseded by CloseHandle.
///Params:
///    Handle = The handle being closed.
///Returns:
///    The various NTSTATUS values are defined in NTSTATUS.H, which is distributed with the Windows DDK. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>STATUS_SUCCESS</b></dt> </dl>
///    </td> <td width="60%"> The handle was closed. </td> </tr> </table>
///    
@DllImport("ntdll")
NTSTATUS NtClose(HANDLE Handle);

///Creates a new file or directory, or opens an existing file, device, directory, or volume.<div
///class="alert"><b>Note</b> Before using this function, please read Calling Internal APIs.</div> <div> </div> This
///function is the user-mode equivalent to the <b>ZwCreateFile</b> function documented in the Windows Driver Kit (WDK).
///Params:
///    FileHandle = A pointer to a variable that receives the file handle if the call is successful.
///    DesiredAccess = The <b>ACCESS_MASK</b> value that expresses the type of access that the caller requires to the file or directory.
///                    The set of system-defined <i>DesiredAccess</i> flags determines the following specific access rights for file
///                    objects. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DELETE"></a><a
///                    id="delete"></a><dl> <dt><b>DELETE</b></dt> </dl> </td> <td width="60%"> The file can be deleted. </td> </tr>
///                    <tr> <td width="40%"><a id="FILE_READ_DATA"></a><a id="file_read_data"></a><dl> <dt><b>FILE_READ_DATA</b></dt>
///                    </dl> </td> <td width="60%"> Data can be read from the file. </td> </tr> <tr> <td width="40%"><a
///                    id="FILE_READ_ATTRIBUTES"></a><a id="file_read_attributes"></a><dl> <dt><b>FILE_READ_ATTRIBUTES</b></dt> </dl>
///                    </td> <td width="60%"> <i>FileAttributes</i> flags, described later, can be read. </td> </tr> <tr> <td
///                    width="40%"><a id="FILE_READ_EA"></a><a id="file_read_ea"></a><dl> <dt><b>FILE_READ_EA</b></dt> </dl> </td> <td
///                    width="60%"> Extended attributes associated with the file can be read. This flag is irrelevant to device and
///                    intermediate drivers. </td> </tr> <tr> <td width="40%"><a id="READ_CONTROL"></a><a id="read_control"></a><dl>
///                    <dt><b>READ_CONTROL</b></dt> </dl> </td> <td width="60%"> The access control list (ACL) and ownership information
///                    associated with the file can be read. </td> </tr> <tr> <td width="40%"><a id="FILE_WRITE_DATA"></a><a
///                    id="file_write_data"></a><dl> <dt><b>FILE_WRITE_DATA</b></dt> </dl> </td> <td width="60%"> Data can be written to
///                    the file. </td> </tr> <tr> <td width="40%"><a id="FILE_WRITE_ATTRIBUTES"></a><a
///                    id="file_write_attributes"></a><dl> <dt><b>FILE_WRITE_ATTRIBUTES</b></dt> </dl> </td> <td width="60%">
///                    <i>FileAttributes</i> flags can be written. </td> </tr> <tr> <td width="40%"><a id="FILE_WRITE_EA"></a><a
///                    id="file_write_ea"></a><dl> <dt><b>FILE_WRITE_EA</b></dt> </dl> </td> <td width="60%"> Extended attributes (EAs)
///                    associated with the file can be written. This flag is irrelevant to device and intermediate drivers. </td> </tr>
///                    <tr> <td width="40%"><a id="FILE_APPEND_DATA"></a><a id="file_append_data"></a><dl>
///                    <dt><b>FILE_APPEND_DATA</b></dt> </dl> </td> <td width="60%"> Data can be appended to the file. </td> </tr> <tr>
///                    <td width="40%"><a id="WRITE_DAC"></a><a id="write_dac"></a><dl> <dt><b>WRITE_DAC</b></dt> </dl> </td> <td
///                    width="60%"> The discretionary access control list (DACL) associated with the file can be written. </td> </tr>
///                    <tr> <td width="40%"><a id="WRITE_OWNER"></a><a id="write_owner"></a><dl> <dt><b>WRITE_OWNER</b></dt> </dl> </td>
///                    <td width="60%"> Ownership information associated with the file can be written. </td> </tr> <tr> <td
///                    width="40%"><a id="SYNCHRONIZE"></a><a id="synchronize"></a><dl> <dt><b>SYNCHRONIZE</b></dt> </dl> </td> <td
///                    width="60%"> The returned <i>FileHandle</i> can be waited on to synchronize with the completion of an I/O
///                    operation. If <i>FileHandle</i> was not opened for synchronous I/O, this value is ignored. </td> </tr> <tr> <td
///                    width="40%"><a id="FILE_EXECUTE"></a><a id="file_execute"></a><dl> <dt><b>FILE_EXECUTE</b></dt> </dl> </td> <td
///                    width="60%"> Data can be read into memory from the file using system paging I/O. This flag is irrelevant for
///                    device and intermediate drivers. </td> </tr> </table> Do not specify <b>FILE_READ_DATA</b>,
///                    <b>FILE_WRITE_DATA</b>, <b>FILE_APPEND_DATA</b>, or <b>FILE_EXECUTE</b> when you create or open a directory.
///                    Callers of <b>NtCreateFile</b> can specify one or a combination of the following, possibly using a bitwise-OR
///                    with additional compatible flags from the preceding <i>DesiredAccess</i> flags list, for any file object that
///                    does not represent a directory file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                    id="FILE_GENERIC_READ"></a><a id="file_generic_read"></a><dl> <dt><b>FILE_GENERIC_READ</b></dt> </dl> </td> <td
///                    width="60%"> <code>STANDARD_RIGHTS_READ | FILE_READ_DATA | FILE_READ_ATTRIBUTES | FILE_READ_EA |
///                    SYNCHRONIZE</code> </td> </tr> <tr> <td width="40%"><a id="FILE_GENERIC_WRITE"></a><a
///                    id="file_generic_write"></a><dl> <dt><b>FILE_GENERIC_WRITE</b></dt> </dl> </td> <td width="60%">
///                    <code>STANDARD_RIGHTS_WRITE | FILE_WRITE_DATA | FILE_WRITE_ATTRIBUTES | FILE_WRITE_EA | FILE_APPEND_DATA |
///                    SYNCHRONIZE</code> </td> </tr> <tr> <td width="40%"><a id="FILE_GENERIC_EXECUTE"></a><a
///                    id="file_generic_execute"></a><dl> <dt><b>FILE_GENERIC_EXECUTE</b></dt> </dl> </td> <td width="60%">
///                    <code>STANDARD_RIGHTS_EXECUTE | FILE_READ_ATTRIBUTES | FILE_EXECUTE | SYNCHRONIZE</code> </td> </tr> </table> The
///                    <b>FILE_GENERIC_EXECUTE</b> value is irrelevant for device and intermediate drivers. The
///                    <b>STANDARD_RIGHTS_</b><i>XXX</i> are predefined system values used to enforce security on system objects. To
///                    open or create a directory file, as also indicated with the <i>CreateOptions</i> parameter, callers of
///                    <b>NtCreateFile</b> can specify one or a combination of the following, possibly using a bitwise-OR with one or
///                    more compatible flags from the preceding <i>DesiredAccess</i> flags list. <table> <tr> <th>Value</th>
///                    <th>Meaning</th> </tr> <tr> <td width="40%"><a id="FILE_LIST_DIRECTORY"></a><a id="file_list_directory"></a><dl>
///                    <dt><b>FILE_LIST_DIRECTORY</b></dt> </dl> </td> <td width="60%"> Files in the directory can be listed. </td>
///                    </tr> <tr> <td width="40%"><a id="FILE_TRAVERSE"></a><a id="file_traverse"></a><dl> <dt><b>FILE_TRAVERSE</b></dt>
///                    </dl> </td> <td width="60%"> The directory can be traversed: that is, it can be part of the pathname of a file.
///                    </td> </tr> </table>
///    ObjectAttributes = A pointer to a structure already initialized with <b>InitializeObjectAttributes</b>. Members of this structure
///                       for a file object include the following. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                       width="40%"><a id="ULONG_Length"></a><a id="ulong_length"></a><a id="ULONG_LENGTH"></a><dl> <dt><b>ULONG
///                       Length</b></dt> </dl> </td> <td width="60%"> Specifies the number of bytes of <i>ObjectAttributes</i> data
///                       supplied. This value must be at least sizeof(OBJECT_ATTRIBUTES). </td> </tr> <tr> <td width="40%"><a
///                       id="HANDLE_RootDirectory"></a><a id="handle_rootdirectory"></a><a id="HANDLE_ROOTDIRECTORY"></a><dl>
///                       <dt><b>HANDLE RootDirectory</b></dt> </dl> </td> <td width="60%"> Optionally specifies a handle to a directory
///                       obtained by a preceding call to <b>NtCreateFile</b>. If this value is <b>NULL</b>, the <b>ObjectName</b> member
///                       must be a fully qualified file specification that includes the full path to the target file. If this value is
///                       non-<b>NULL</b>, the <b>ObjectName</b> member specifies a file name relative to this directory. </td> </tr> <tr>
///                       <td width="40%"><a id="PUNICODE_STRING_ObjectName"></a><a id="punicode_string_objectname"></a><a
///                       id="PUNICODE_STRING_OBJECTNAME"></a><dl> <dt><b>PUNICODE_STRING ObjectName</b></dt> </dl> </td> <td width="60%">
///                       Points to a buffered Unicode string that names the file to be created or opened. This value must be a fully
///                       qualified file specification or the name of a device object, unless it is the name of a file relative to the
///                       directory specified by <b>RootDirectory</b>. For example, \Device\Floppy1\myfile.dat or \??\B:\myfile.dat could
///                       be the fully qualified file specification, provided that the floppy driver and overlying file system are already
///                       loaded. For more information, see File Names, Paths, and Namespaces. </td> </tr> <tr> <td width="40%"><a
///                       id="ULONG_Attributes"></a><a id="ulong_attributes"></a><a id="ULONG_ATTRIBUTES"></a><dl> <dt><b>ULONG
///                       Attributes</b></dt> </dl> </td> <td width="60%"> Is a set of flags that controls the file object attributes. This
///                       value can be zero or <b>OBJ_CASE_INSENSITIVE</b>, which indicates that name-lookup code should ignore the case of
///                       the <b>ObjectName</b> member rather than performing an exact-match search. The value <b>OBJ_INHERIT</b> is
///                       irrelevant to device and intermediate drivers. </td> </tr> <tr> <td width="40%"><a
///                       id="PSECURITY_DESCRIPTOR_SecurityDescriptor"></a><a id="psecurity_descriptor_securitydescriptor"></a><a
///                       id="PSECURITY_DESCRIPTOR_SECURITYDESCRIPTOR"></a><dl> <dt><b>PSECURITY_DESCRIPTOR SecurityDescriptor</b></dt>
///                       </dl> </td> <td width="60%"> Optionally specifies a security descriptor to be applied to a file. ACLs specified
///                       by such a security descriptor are applied to the file only when it is created. If the value is <b>NULL</b> when a
///                       file is created, the ACL placed on the file is file-system-dependent; most file systems propagate some part of
///                       such an ACL from the parent directory file combined with the caller's default ACL. Device and intermediate
///                       drivers can set this member to <b>NULL</b>. </td> </tr> <tr> <td width="40%"><a
///                       id="PSECURITY_QUALITY_OF_SERVICE_SecurityQualityOfService"></a><a
///                       id="psecurity_quality_of_service_securityqualityofservice"></a><a
///                       id="PSECURITY_QUALITY_OF_SERVICE_SECURITYQUALITYOFSERVICE"></a><dl> <dt><b>PSECURITY_QUALITY_OF_SERVICE
///                       SecurityQualityOfService</b></dt> </dl> </td> <td width="60%"> Specifies the access rights a server should be
///                       given to the client's security context. This value is non-<b>NULL</b> only when a connection to a protected
///                       server is established, allowing the caller to control which parts of the caller's security context are made
///                       available to the server and whether the server is allowed to impersonate the caller. </td> </tr> </table>
///    IoStatusBlock = A pointer to a variable that receives the final completion status and information about the requested operation.
///                    On return from <b>NtCreateFile</b>, the <b>Information</b> member contains one of the following values: <ul>
///                    <li><b>FILE_CREATED</b></li> <li><b>FILE_OPENED</b></li> <li><b>FILE_OVERWRITTEN</b></li>
///                    <li><b>FILE_SUPERSEDED</b></li> <li><b>FILE_EXISTS</b></li> <li><b>FILE_DOES_NOT_EXIST</b></li> </ul>
///    AllocationSize = The initial allocation size in bytes for the file. A nonzero value has no effect unless the file is being
///                     created, overwritten, or superseded.
///    FileAttributes = The file attributes. Explicitly specified attributes are applied only when the file is created, superseded, or,
///                     in some cases, overwritten. By default, this value is a <b>FILE_ATTRIBUTE_NORMAL</b>, which can be overridden by
///                     an ORed combination of one or more <b>FILE_ATTRIBUTE_</b><i>xxxx</i> flags, which are defined in Wdm.h and
///                     NtDdk.h. For a list of flags that can be used with <b>NtCreateFile</b>, see <b>CreateFile</b>.
///    ShareAccess = The type of share access that the caller would like to use in the file, as zero, or as one or a combination of
///                  the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                  id="FILE_SHARE_READ"></a><a id="file_share_read"></a><dl> <dt><b>FILE_SHARE_READ</b></dt> </dl> </td> <td
///                  width="60%"> The file can be opened for read access by other threads' calls to <b>NtCreateFile</b>. </td> </tr>
///                  <tr> <td width="40%"><a id="FILE_SHARE_WRITE"></a><a id="file_share_write"></a><dl>
///                  <dt><b>FILE_SHARE_WRITE</b></dt> </dl> </td> <td width="60%"> The file can be opened for write access by other
///                  threads' calls to <b>NtCreateFile</b>. </td> </tr> <tr> <td width="40%"><a id="FILE_SHARE_DELETE"></a><a
///                  id="file_share_delete"></a><dl> <dt><b>FILE_SHARE_DELETE</b></dt> </dl> </td> <td width="60%"> The file can be
///                  opened for delete access by other threads' calls to <b>NtCreateFile</b>. </td> </tr> </table> For more
///                  information, see the Windows SDK.
///    CreateDisposition = Specifies what to do, depending on whether the file already exists, as one of the following values. <table> <tr>
///                        <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="FILE_SUPERSEDE"></a><a
///                        id="file_supersede"></a><dl> <dt><b>FILE_SUPERSEDE</b></dt> </dl> </td> <td width="60%"> If the file already
///                        exists, replace it with the given file. If it does not, create the given file. </td> </tr> <tr> <td
///                        width="40%"><a id="FILE_CREATE"></a><a id="file_create"></a><dl> <dt><b>FILE_CREATE</b></dt> </dl> </td> <td
///                        width="60%"> If the file already exists, fail the request and do not create or open the given file. If it does
///                        not, create the given file. </td> </tr> <tr> <td width="40%"><a id="FILE_OPEN"></a><a id="file_open"></a><dl>
///                        <dt><b>FILE_OPEN</b></dt> </dl> </td> <td width="60%"> If the file already exists, open it instead of creating a
///                        new file. If it does not, fail the request and do not create a new file. </td> </tr> <tr> <td width="40%"><a
///                        id="FILE_OPEN_IF"></a><a id="file_open_if"></a><dl> <dt><b>FILE_OPEN_IF</b></dt> </dl> </td> <td width="60%"> If
///                        the file already exists, open it. If it does not, create the given file. </td> </tr> <tr> <td width="40%"><a
///                        id="FILE_OVERWRITE"></a><a id="file_overwrite"></a><dl> <dt><b>FILE_OVERWRITE</b></dt> </dl> </td> <td
///                        width="60%"> If the file already exists, open it and overwrite it. If it does not, fail the request. </td> </tr>
///                        <tr> <td width="40%"><a id="FILE_OVERWRITE_IF"></a><a id="file_overwrite_if"></a><dl>
///                        <dt><b>FILE_OVERWRITE_IF</b></dt> </dl> </td> <td width="60%"> If the file already exists, open it and overwrite
///                        it. If it does not, create the given file. </td> </tr> </table>
///    CreateOptions = The options to be applied when creating or opening the file, as a compatible combination of the following flags.
///                    <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="FILE_DIRECTORY_FILE"></a><a
///                    id="file_directory_file"></a><dl> <dt><b>FILE_DIRECTORY_FILE</b></dt> </dl> </td> <td width="60%"> The file being
///                    created or opened is a directory file. With this flag, the <i>CreateDisposition</i> parameter must be set to
///                    <b>FILE_CREATE</b>, <b>FILE_OPEN</b>, or <b>FILE_OPEN_IF</b>. With this flag, other compatible
///                    <i>CreateOptions</i> flags include only the following: <b>FILE_SYNCHRONOUS_IO_ALERT</b>, <b>FILE_SYNCHRONOUS_IO
///                    _NONALERT</b>, <b>FILE_WRITE_THROUGH</b>, <b>FILE_OPEN_FOR_BACKUP_INTENT</b>, and <b>FILE_OPEN_BY_FILE_ID</b>.
///                    </td> </tr> <tr> <td width="40%"><a id="FILE_NON_DIRECTORY_FILE"></a><a id="file_non_directory_file"></a><dl>
///                    <dt><b>FILE_NON_DIRECTORY_FILE</b></dt> </dl> </td> <td width="60%"> The file being opened must not be a
///                    directory file or this call fails. The file object being opened can represent a data file, a logical, virtual, or
///                    physical device, or a volume. </td> </tr> <tr> <td width="40%"><a id="FILE_WRITE_THROUGH"></a><a
///                    id="file_write_through"></a><dl> <dt><b>FILE_WRITE_THROUGH</b></dt> </dl> </td> <td width="60%"> Applications
///                    that write data to the file must actually transfer the data into the file before any requested write operation is
///                    considered complete. This flag is automatically set if the <i>CreateOptions</i> flag <b>FILE_NO_INTERMEDIATE
///                    _BUFFERING</b> is set. </td> </tr> <tr> <td width="40%"><a id="FILE_SEQUENTIAL_ONLY"></a><a
///                    id="file_sequential_only"></a><dl> <dt><b>FILE_SEQUENTIAL_ONLY</b></dt> </dl> </td> <td width="60%"> All accesses
///                    to the file are sequential. </td> </tr> <tr> <td width="40%"><a id="FILE_RANDOM_ACCESS"></a><a
///                    id="file_random_access"></a><dl> <dt><b>FILE_RANDOM_ACCESS</b></dt> </dl> </td> <td width="60%"> Accesses to the
///                    file can be random, so no sequential read-ahead operations should be performed on the file by FSDs or the system.
///                    </td> </tr> <tr> <td width="40%"><a id="FILE_NO_INTERMEDIATE_BUFFERING"></a><a
///                    id="file_no_intermediate_buffering"></a><dl> <dt><b>FILE_NO_INTERMEDIATE_BUFFERING</b></dt> </dl> </td> <td
///                    width="60%"> The file cannot be cached or buffered in a driver's internal buffers. This flag is incompatible with
///                    the <i>DesiredAccess</i> <b>FILE_APPEND_DATA</b> flag. </td> </tr> <tr> <td width="40%"><a
///                    id="FILE_SYNCHRONOUS_IO_ALERT"></a><a id="file_synchronous_io_alert"></a><dl>
///                    <dt><b>FILE_SYNCHRONOUS_IO_ALERT</b></dt> </dl> </td> <td width="60%"> All operations on the file are performed
///                    synchronously. Any wait on behalf of the caller is subject to premature termination from alerts. This flag also
///                    causes the I/O system to maintain the file position context. If this flag is set, the <i>DesiredAccess</i>
///                    <b>SYNCHRONIZE</b> flag also must be set. </td> </tr> <tr> <td width="40%"><a
///                    id="FILE_SYNCHRONOUS_IO_NONALERT"></a><a id="file_synchronous_io_nonalert"></a><dl>
///                    <dt><b>FILE_SYNCHRONOUS_IO_NONALERT</b></dt> </dl> </td> <td width="60%"> All operations on the file are
///                    performed synchronously. Waits in the system to synchronize I/O queuing and completion are not subject to alerts.
///                    This flag also causes the I/O system to maintain the file position context. If this flag is set, the
///                    <i>DesiredAccess</i> <b>SYNCHRONIZE</b> flag also must be set. </td> </tr> <tr> <td width="40%"><a
///                    id="FILE_CREATE_TREE_CONNECTION"></a><a id="file_create_tree_connection"></a><dl>
///                    <dt><b>FILE_CREATE_TREE_CONNECTION</b></dt> </dl> </td> <td width="60%"> Create a tree connection for this file
///                    in order to open it over the network. This flag is not used by device and intermediate drivers. </td> </tr> <tr>
///                    <td width="40%"><a id="FILE_NO_EA_KNOWLEDGE"></a><a id="file_no_ea_knowledge"></a><dl>
///                    <dt><b>FILE_NO_EA_KNOWLEDGE</b></dt> </dl> </td> <td width="60%"> If the extended attributes on an existing file
///                    being opened indicate that the caller must understand EAs to properly interpret the file, fail this request
///                    because the caller does not understand how to deal with EAs. This flag is irrelevant for device and intermediate
///                    drivers. </td> </tr> <tr> <td width="40%"><a id="FILE_OPEN_REPARSE_POINT"></a><a
///                    id="file_open_reparse_point"></a><dl> <dt><b>FILE_OPEN_REPARSE_POINT</b></dt> </dl> </td> <td width="60%"> Open a
///                    file with a reparse point and bypass normal reparse point processing for the file. For more information, see the
///                    Remarks section. </td> </tr> <tr> <td width="40%"><a id="FILE_DELETE_ON_CLOSE"></a><a
///                    id="file_delete_on_close"></a><dl> <dt><b>FILE_DELETE_ON_CLOSE</b></dt> </dl> </td> <td width="60%"> Delete the
///                    file when the last handle to it is passed to <b>NtClose</b>. If this flag is set, the DELETE flag must be set in
///                    the <i>DesiredAccess</i> parameter. </td> </tr> <tr> <td width="40%"><a id="FILE_OPEN_BY_FILE_ID"></a><a
///                    id="file_open_by_file_id"></a><dl> <dt><b>FILE_OPEN_BY_FILE_ID</b></dt> </dl> </td> <td width="60%"> The file
///                    name that is specified by the <i>ObjectAttributes</i> parameter includes the 8-byte file reference number for the
///                    file. This number is assigned by and specific to the particular file system. If the file is a reparse point, the
///                    file name will also include the name of a device. Note that the FAT file system does not support this flag. This
///                    flag is not used by device and intermediate drivers. </td> </tr> <tr> <td width="40%"><a
///                    id="FILE_OPEN_FOR_BACKUP_INTENT"></a><a id="file_open_for_backup_intent"></a><dl>
///                    <dt><b>FILE_OPEN_FOR_BACKUP_INTENT</b></dt> </dl> </td> <td width="60%"> The file is being opened for backup
///                    intent. Therefore, the system should check for certain access rights and grant the caller the appropriate access
///                    to the file before checking the <i>DesiredAccess</i> parameter against the file's security descriptor. This flag
///                    not used by device and intermediate drivers. </td> </tr> <tr> <td width="40%"><a
///                    id="FILE_RESERVE_OPFILTER_"></a><a id="file_reserve_opfilter_"></a><dl> <dt><b>FILE_RESERVE_OPFILTER </b></dt>
///                    </dl> </td> <td width="60%"> This flag allows an application to request a filter opportunistic lock (oplock) to
///                    prevent other applications from getting share violations. If there are already open handles, the create request
///                    will fail with <b>STATUS_OPLOCK_NOT_GRANTED</b>. For more information, see the Remarks section. </td> </tr> <tr>
///                    <td width="40%"><a id="FILE_OPEN_REQUIRING_OPLOCK"></a><a id="file_open_requiring_oplock"></a><dl>
///                    <dt><b>FILE_OPEN_REQUIRING_OPLOCK</b></dt> </dl> </td> <td width="60%"> The file is being opened and an
///                    opportunistic lock (oplock) on the file is being requested as a single atomic operation. The file system checks
///                    for oplocks before it performs the create operation and will fail the create with a return code of
///                    <b>STATUS_CANNOT_BREAK_OPLOCK</b> if the result would be to break an existing oplock. For more information, see
///                    the Remarks section.<b>Windows Server 2008, Windows Vista, Windows Server 2003 and Windows XP: </b>This flag is
///                    not supported. This flag is supported on the following file systems: NTFS, FAT, and exFAT. </td> </tr> <tr> <td
///                    width="40%"><a id="FILE_COMPLETE_IF_OPLOCKED"></a><a id="file_complete_if_oplocked"></a><dl>
///                    <dt><b>FILE_COMPLETE_IF_OPLOCKED</b></dt> </dl> </td> <td width="60%"> Complete this operation immediately with
///                    an alternate success code of <b>STATUS_OPLOCK_BREAK_IN_PROGRESS</b> if the target file is oplocked, rather than
///                    blocking the caller's thread. If the file is oplocked, another caller already has access to the file. This flag
///                    is not used by device and intermediate drivers. </td> </tr> </table>
///    EaBuffer = Pointer to an EA buffer used to pass extended attributes. <div class="alert"><b>Note</b> Some file systems may
///               not support EA buffers.</div> <div> </div>
///    EaLength = Length of the EA buffer.
///Returns:
///    <b>NtCreateFile</b> returns either <b>STATUS_SUCCESS</b> or an appropriate error status. If it returns an error
///    status, the caller can find more information about the cause of the failure by checking the <i>IoStatusBlock</i>.
///    To simplify this check, an application can use the <b>NT_SUCCESS</b>, <b>NT_ERROR</b>, and <b>NT_WARNING</b>
///    macros.
///    
@DllImport("ntdll")
NTSTATUS NtCreateFile(ptrdiff_t* FileHandle, uint DesiredAccess, OBJECT_ATTRIBUTES* ObjectAttributes, 
                      IO_STATUS_BLOCK* IoStatusBlock, LARGE_INTEGER* AllocationSize, uint FileAttributes, 
                      uint ShareAccess, uint CreateDisposition, uint CreateOptions, void* EaBuffer, uint EaLength);

///Opens an existing file, device, directory, or volume, and returns a handle for the file object. This function is
///equivalent to the <b>ZwOpenFile</b> function documented in the Windows Driver Kit (WDK).
///Params:
///    FileHandle = A pointer to a handle for the opened file. The driver must close the handle with <b>ZwClose</b> once the handle
///                 is no longer in use.
///    DesiredAccess = The <b>ACCESS_MASK</b> value that expresses the types of file access desired by the caller. For information about
///                    the types of access that can be specified, see <b>ZwCreateFile</b> in the WDK.
///    ObjectAttributes = A pointer to a structure that a caller initializes with <b>InitializeObjectAttributes</b>. If the caller is not
///                       running in the system process context, it must set the <b>OBJ_KERNEL_HANDLE</b> attribute for
///                       <i>ObjectAttributes</i>. For more information about specifying object attributes, see <b>ZwCreateFile</b> in the
///                       WDK.
///    IoStatusBlock = A pointer to a structure that contains information about the requested operation and the final completion status.
///    ShareAccess = The type of share access for the file. For more information, see <b>ZwCreateFile</b> in the WDK.
///    OpenOptions = The options to be applied when opening the file. For more information, see <b>ZwCreateFile</b> in the WDK.
///Returns:
///    <b>NtOpenFile</b> either returns <b>STATUS_SUCCESS</b> or an appropriate error status. If it returns an error
///    status, the caller can find additional information about the cause of the failure by checking the
///    <i>IoStatusBlock</i>.
///    
@DllImport("ntdll")
NTSTATUS NtOpenFile(ptrdiff_t* FileHandle, uint DesiredAccess, OBJECT_ATTRIBUTES* ObjectAttributes, 
                    IO_STATUS_BLOCK* IoStatusBlock, uint ShareAccess, uint OpenOptions);

///<p class="CCE_Message">[This function may be changed or removed from Windows without further notice. ] Changes the
///name of the specified registry key.
///Params:
///    KeyHandle = A handle to the key to be renamed. The handle must be opened with the KEY_WRITE access right.
///    NewName = A pointer to a UNICODE string that is the new name for the key.
///Returns:
///    Returns an <b>NTSTATUS</b> or error code. An error code of <b>STATUS_ACCESS_DENIED</b> indicates that the caller
///    does not have the necessary access rights to the specified registry key or subkeys. The forms and significance of
///    <b>NTSTATUS</b> error codes are listed in the Ntstatus.h header file available in the WDK, and are described in
///    the WDK documentation.
///    
@DllImport("ntdll")
NTSTATUS NtRenameKey(HANDLE KeyHandle, UNICODE_STRING* NewName);

///<p class="CCE_Message">[This function may be changed or removed from Windows without further notice. ] Requests
///notification when a registry key or any of its subkeys changes.
///Params:
///    MasterKeyHandle = A handle to an open key. The handle must be opened with the <b>KEY_NOTIFY</b> access right.
///    Count = The number of subkeys under the key specified by the <i>MasterKeyHandle</i> parameter. This parameter must be 1.
///    SubordinateObjects = Pointer to an array of OBJECT_ATTRIBUTES structures, one for each subkey. This array can contain one
///                         <b>OBJECT_ATTRIBUTES</b> structure.
///    Event = A handle to an event created by the caller. If <i>Event</i> is not <b>NULL</b>, the caller waits until the
///            operation succeeds, at which time the event is signaled.
///    ApcRoutine = A pointer to an asynchronous procedure call (APC) function supplied by the caller. If <i>ApcRoutine</i> is not
///                 <b>NULL</b>, the specified APC function executes after the operation completes.
///    ApcContext = A pointer to a context supplied by the caller for its APC function. This value is passed to the APC function when
///                 it is executed. The <i>Asynchronous</i> parameter must be <b>TRUE</b>. If <i>ApcContext</i> is specified, the
///                 <i>Event</i> parameter must be <b>NULL</b>.
///    IoStatusBlock = A pointer to an IO_STATUS_BLOCK structure that contains the final status and information about the operation. For
///                    successful calls that return data, the number of bytes written to the <i>Buffer</i> parameter is supplied in the
///                    <b>Information</b> member of the <b>IO_STATUS_BLOCK</b> structure.
///    CompletionFilter = A bitmap of operations that trigger notification. This parameter can be one or more of the following flags.
///                       <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="REG_NOTIFY_CHANGE_NAME_"></a><a
///                       id="reg_notify_change_name_"></a><dl> <dt><b>REG_NOTIFY_CHANGE_NAME </b></dt> </dl> </td> <td width="60%"> Notify
///                       the caller if a subkey is added or deleted. </td> </tr> <tr> <td width="40%"><a
///                       id="REG_NOTIFY_CHANGE_ATTRIBUTES_"></a><a id="reg_notify_change_attributes_"></a><dl>
///                       <dt><b>REG_NOTIFY_CHANGE_ATTRIBUTES </b></dt> </dl> </td> <td width="60%"> Notify the caller of changes to the
///                       attributes of the key, such as the security descriptor information. </td> </tr> <tr> <td width="40%"><a
///                       id="REG_NOTIFY_CHANGE_LAST_SET_"></a><a id="reg_notify_change_last_set_"></a><dl>
///                       <dt><b>REG_NOTIFY_CHANGE_LAST_SET </b></dt> </dl> </td> <td width="60%"> Notify the caller of changes to a value
///                       of the key. This can include adding or deleting a value, or changing an existing value. </td> </tr> <tr> <td
///                       width="40%"><a id="REG_NOTIFY_CHANGE_SECURITY_"></a><a id="reg_notify_change_security_"></a><dl>
///                       <dt><b>REG_NOTIFY_CHANGE_SECURITY </b></dt> </dl> </td> <td width="60%"> Notify the caller of changes to the
///                       security descriptor of the key. </td> </tr> </table>
///    WatchTree = If this parameter is <b>TRUE</b>, the caller is notified about changes to all subkeys of the specified key. If
///                this parameter is <b>FALSE</b>, the caller is notified only about changes to the specified key.
///    Buffer = Reserved for system use. This parameter must be <b>NULL</b>.
///    BufferSize = Reserved for system use. This parameter must be zero.
///    Asynchronous = If this parameter is <b>TRUE</b>, the function returns immediately. If this parameter is <b>FALSE</b>, the
///                   function does not return until the specified event occurs.
///Returns:
///    Returns an <b>NTSTATUS</b> or error code. If the <i>Asynchronous</i> parameter is <b>TRUE</b> and the specified
///    event has not yet occurred, the function returns <b>STATUS_PENDING</b>. The forms and significance of
///    <b>NTSTATUS</b> error codes are listed in the Ntstatus.h header file available in the WDK, and are described in
///    the WDK documentation.
///    
@DllImport("ntdll")
NTSTATUS NtNotifyChangeMultipleKeys(HANDLE MasterKeyHandle, uint Count, char* SubordinateObjects, HANDLE Event, 
                                    PIO_APC_ROUTINE ApcRoutine, void* ApcContext, IO_STATUS_BLOCK* IoStatusBlock, 
                                    uint CompletionFilter, ubyte WatchTree, char* Buffer, uint BufferSize, 
                                    ubyte Asynchronous);

///<p class="CCE_Message">[This function may be changed or removed from Windows without further notice.] Retrieves
///values for the specified multiple-value key.
///Params:
///    KeyHandle = A handle to the key for which to retrieve values. The handle must be opened with the <b>KEY_QUERY_VALUE</b>
///                access right.
///    ValueEntries = A pointer to an array of [**KEY_VALUE_ENTRY**] structures containing the names of values to retrieve.
///    EntryCount = The number of elements in the <i>ValueEntries</i> array.
///    ValueBuffer = A pointer to a buffer to receive the values.
///    BufferLength = A pointer to a variable that contains the size of the buffer at <i>ValueBuffer</i>, in bytes. When the function
///                   returns, the <i>BufferLength</i> parameter contains the number of bytes written to the buffer at
///                   <i>ValueBuffer</i>.
///    RequiredBufferLength = A pointer to a variable to receive the number of bytes required for all of the values to be returned by the
///                           function. This parameter can be <b>NULL</b>.
///Returns:
///    Returns an <b>NTSTATUS</b> or error code. If the buffer is too small to hold the information to be retrieved, the
///    function returns <b>STATUS_BUFFER_OVERFLOW</b> and, if the <i>RequiredBufferLength</i> parameter is specified,
///    sets it to the buffer size required. The forms and significance of <b>NTSTATUS</b> error codes are listed in the
///    Ntstatus.h header file available in the WDK, and are described in the WDK documentation.
///    
@DllImport("ntdll")
NTSTATUS NtQueryMultipleValueKey(HANDLE KeyHandle, char* ValueEntries, uint EntryCount, char* ValueBuffer, 
                                 uint* BufferLength, uint* RequiredBufferLength);

///<p class="CCE_Message">[This function may be changed or removed from Windows without further notice.] Sets
///information for the specified registry key.
///Params:
///    KeyHandle = A handle to the registry key. The handle must be opened with the <b>KEY_WRITE</b> access right.
///    KeySetInformationClass = A KEY_SET_INFORMATION_CLASS value that specifies the kind of information to be set.
///    KeySetInformation = A pointer to the buffer that contains the information to be set. The format of this buffer is determined by the
///                        <i>KeySetInformationClass</i> parameter.
///    KeySetInformationLength = The length of the buffer specified by the <i>KeySetInformation</i> parameter, in bytes.
///Returns:
///    Returns an <b>NTSTATUS</b> or error code. An error code of <b>STATUS_INFO_LENGTH_MISMATCH</b> indicates that the
///    <i>KeySetInformationLength</i> parameter is the wrong length for the information class specified by the
///    <i>KeySetInformationClass</i> parameter. The forms and significance of <b>NTSTATUS</b> error codes are listed in
///    the Ntstatus.h header file available in the WDK, and are described in the WDK documentation.
///    
@DllImport("ntdll")
NTSTATUS NtSetInformationKey(HANDLE KeyHandle, KEY_SET_INFORMATION_CLASS KeySetInformationClass, 
                             char* KeySetInformation, uint KeySetInformationLength);

///Deprecated. Builds descriptors for the supplied buffer(s) and passes the untyped data to the device driver associated
///with the file handle. <b>NtDeviceIoControlFile</b> is superseded by DeviceIoControl.
///Params:
///    FileHandle = Open file handle to the file or device to which the control information should be given.
///    Event = A handle to an event to be set to the <code>signaled</code> state when the operation completes. This parameter
///            can be <b>NULL</b>.
///    ApcRoutine = Procedure to be invoked once the operation completes. This parameter can be <b>NULL</b>. For more information on
///                 Asynchronous Procedure Calls (APCs), see Asynchronous Procedure Calls.
///    ApcContext = A pointer to pass to <i>ApcRoutine</i> when the operation completes. This parameter is required if an
///                 <i>ApcRoutine</i> is specified.
///    IoStatusBlock = Variable to receive the final completion status and information about the operation. Service calls that return
///                    information return the length of the data that is written to the output buffer in the Information field of this
///                    variable.
///    IoControlCode = Code that indicates which device I/O control function is to be executed.
///    InputBuffer = A pointer to a buffer that contains the information to be given to the target device. This parameter can be
///                  <b>NULL</b>. This information is device-dependent.
///    InputBufferLength = Length of the <i>InputBuffer</i> in bytes. If the buffer is not supplied, then this value is ignored.
///    OutputBuffer = A pointer to a buffer that is to receive the device-dependent return information from the target device. This
///                   parameter can be <b>NULL</b>.
///    OutputBufferLength = Length of the <i>OutputBuffer</i> in bytes. If the buffer is not supplied, then this value is ignored.
///Returns:
///    The various NTSTATUS values are defined in NTSTATUS.H, which is distributed with the Windows DDK. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>STATUS_SUCCESS</b></dt> </dl>
///    </td> <td width="60%"> The control operation was properly queued to the I/O system. Once the operation completes,
///    the status can be determined by examining the Status field of the I/O status block. </td> </tr> </table>
///    
@DllImport("ntdll")
NTSTATUS NtDeviceIoControlFile(HANDLE FileHandle, HANDLE Event, PIO_APC_ROUTINE ApcRoutine, void* ApcContext, 
                               IO_STATUS_BLOCK* IoStatusBlock, uint IoControlCode, void* InputBuffer, 
                               uint InputBufferLength, void* OutputBuffer, uint OutputBufferLength);

///Deprecated. Waits until the specified object attains a state of <code>signaled</code>. <b>NtWaitForSingleObject</b>
///is superseded by WaitForSingleObject.
///Params:
///    Handle = The handle to the wait object.
///    Alertable = Specifies whether an alert can be delivered when the object is waiting.
///    Timeout = A pointer to an absolute or relative time over which the wait is to occur. Can be null. If a timeout is
///              specified, and the object has not attained a state of <code>signaled</code> when the timeout expires, then the
///              wait is automatically satisfied. If an explicit timeout value of zero is specified, then no wait occurs if the
///              wait cannot be satisfied immediately.
///Returns:
///    The wait completion status. The various NTSTATUS values are defined in NTSTATUS.H, which is distributed with the
///    Windows DDK. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>STATUS_SUCCESS</b></dt> </dl> </td> <td width="60%"> The specified object satisfied the wait. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>STATUS_TIMEOUT</b></dt> </dl> </td> <td width="60%"> A timeout occurred. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>STATUS_ALERTED</b></dt> </dl> </td> <td width="60%"> The wait was aborted
///    to deliver an alert to the current thread. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>STATUS_USER_APC</b></dt>
///    </dl> </td> <td width="60%"> The wait was aborted to deliver a user Asynchronous Procedure Call (APC) to the
///    current thread. </td> </tr> </table>
///    
@DllImport("ntdll")
NTSTATUS NtWaitForSingleObject(HANDLE Handle, ubyte Alertable, LARGE_INTEGER* Timeout);

///<p class="CCE_Message">[<b>RtlIsNameLegalDOS8Dot3</b> is available for use in Windows XP. It may be altered or
///unavailable in subsequent versions. Applications that target a minimum of Windows Server 2003 and Windows XP with
///Service Pack 1 (SP1) and later should use the <b>CheckNameLegalDOS8Dot3</b> function.] Determines whether or not a
///specified name can be used to create a file on the FAT file system.
///Params:
///    Name = The file name, in 8.3 format.
///    OemName = A pointer to a buffer that receives the OEM string that corresponds to <i>Name</i>. This parameter can be
///              <b>NULL</b>.
///    NameContainsSpaces = If the function returns <b>TRUE</b>, this parameter indicates whether or not the name contains spaces. If the
///                         function returns <b>FALSE</b>, this parameter is undefined.
///Returns:
///    If the specified name forms a valid 8.3 FAT file system name in the current OEM code page, the function returns
///    <b>TRUE</b>. Otherwise, the function returns <b>FALSE</b>.
///    
@DllImport("ntdll")
ubyte RtlIsNameLegalDOS8Dot3(UNICODE_STRING* Name, STRING* OemName, ubyte* NameContainsSpaces);

///<p class="CCE_Message">[This function may be changed or removed from Windows without further notice.] Retrieves
///various kinds of object information.
///Params:
///    Handle = The handle of the object for which information is being queried.
///    ObjectInformationClass = One of the following values, as enumerated in <b>OBJECT_INFORMATION_CLASS</b>, indicating the kind of object
///                             information to be retrieved. <table> <tr> <th>Term</th> <th>Description</th> </tr> <tr> <td width="40%"> <a
///                             id="ObjectBasicInformation"></a><a id="objectbasicinformation"></a><a
///                             id="OBJECTBASICINFORMATION"></a>ObjectBasicInformation </td> <td width="60%"> Returns a
///                             <b>PUBLIC_OBJECT_BASIC_INFORMATION</b> structure as shown in the following Remarks section. </td> </tr> <tr> <td
///                             width="40%"> <a id="ObjectTypeInformation"></a><a id="objecttypeinformation"></a><a
///                             id="OBJECTTYPEINFORMATION"></a>ObjectTypeInformation </td> <td width="60%"> Returns a
///                             <b>PUBLIC_OBJECT_TYPE_INFORMATION</b> structure as shown in the following Remarks section. </td> </tr> </table>
///    ObjectInformation = An optional pointer to a buffer where the requested information is to be returned. The size and structure of this
///                        information varies depending on the value of the <i>ObjectInformationClass</i> parameter.
///    ObjectInformationLength = The size of the buffer pointed to by the <i>ObjectInformation</i> parameter, in bytes.
///    ReturnLength = An optional pointer to a location where the function writes the actual size of the information requested. If that
///                   size is less than or equal to the <i>ObjectInformationLength</i> parameter, the function copies the information
///                   into the <i>ObjectInformation</i> buffer; otherwise, it returns an NTSTATUS error code and returns in
///                   <i>ReturnLength</i> the size of the buffer required to receive the requested information.
///Returns:
///    Returns an NTSTATUS or error code. The forms and significance of NTSTATUS error codes are listed in the
///    Ntstatus.h header file available in the WDK, and are described in the WDK documentation.
///    
@DllImport("ntdll")
NTSTATUS NtQueryObject(HANDLE Handle, OBJECT_INFORMATION_CLASS ObjectInformationClass, char* ObjectInformation, 
                       uint ObjectInformationLength, uint* ReturnLength);

///<p class="CCE_Message">[<b>NtQuerySystemInformation</b> may be altered or unavailable in future versions of Windows.
///Applications should use the alternate functions listed in this topic.] Retrieves the specified system information.
///Params:
///    SystemInformationClass = One of the values enumerated in SYSTEM_INFORMATION_CLASS, which indicate the kind of system information to be
///                             retrieved. These include the following values.
///    SystemInformation = A pointer to a buffer that receives the requested information. The size and structure of this information varies
///                        depending on the value of the <i>SystemInformationClass</i> parameter:
///    SystemInformationLength = The size of the buffer pointed to by the <i>SystemInformation</i>parameter, in bytes.
///    ReturnLength = An optional pointer to a location where the function writes the actual size of the information requested. If that
///                   size is less than or equal to the <i>SystemInformationLength</i> parameter, the function copies the information
///                   into the <i>SystemInformation</i> buffer; otherwise, it returns an NTSTATUS error code and returns in
///                   <i>ReturnLength</i> the size of buffer required to receive the requested information.
///Returns:
///    Returns an NTSTATUS success or error code. The forms and significance of NTSTATUS error codes are listed in the
///    Ntstatus.h header file available in the DDK, and are described in the DDK documentation.
///    
@DllImport("ntdll")
NTSTATUS NtQuerySystemInformation(SYSTEM_INFORMATION_CLASS SystemInformationClass, void* SystemInformation, 
                                  uint SystemInformationLength, uint* ReturnLength);

///<p class="CCE_Message">[<b>NtQuerySystemTime</b> may be altered or unavailable in future versions of Windows.
///Applications should use the GetSystemTimeAsFileTime function.] Retrieves the current system time.
///Params:
///    SystemTime = A pointer to a LARGE_INTEGER structure that receives the system time. This is a 64-bit value representing the
///                 number of 100-nanosecond intervals since January 1, 1601 (UTC).
///Returns:
///    If the function succeeds, it returns STATUS_SUCCESS. If it fails, it will return the appropriate status code,
///    which will typically be STATUS_ACCESS_VIOLATION.
///    
@DllImport("ntdll")
NTSTATUS NtQuerySystemTime(LARGE_INTEGER* SystemTime);

///<p class="CCE_Message">[<b>RtlLocalTimeToSystemTime</b> is available for use in Windows 2000 and Windows XP. It may
///be unavailable or modifed in subsequent releases. Applications should use the LocalFileTimeToFileTime function.]
///Converts the specified local time to system time.
///Params:
///    LocalTime = A pointer to a LARGE_INTEGER structure that specifies the local time.
///    SystemTime = A pointer to a LARGE_INTEGER structure that receives the returned system time.
///Returns:
///    If the function succeeds, it returns STATUS_SUCCESS. If it fails, it will return the appropriate status code.
///    
@DllImport("ntdll")
NTSTATUS RtlLocalTimeToSystemTime(LARGE_INTEGER* LocalTime, LARGE_INTEGER* SystemTime);

///<p class="CCE_Message">[<b>RtlTimeToSecondsSince1970</b> is available for use in Windows 2000 and Windows XP. It may
///be unavailable or modified in subsequent releases.] Converts the specified 64-bit system time to the number of
///seconds since the beginning of January 1, 1970.
///Params:
///    Time = A pointer to a LARGE_INTEGER structure that specifies the system time. The valid years for this value are 1970 to
///           2105 inclusive.
///    ElapsedSeconds = A pointer to a variable that receives the number of seconds.
///Returns:
///    If the function succeeds, it returns <b>TRUE</b>. If it fails, it returns <b>FALSE</b>. Typically, this function
///    will fail if the specified value of the <i>Time</i> parameter is not within the valid timeframe specified in the
///    parameter description.
///    
@DllImport("ntdll")
ubyte RtlTimeToSecondsSince1970(LARGE_INTEGER* Time, uint* ElapsedSeconds);

///Frees the string buffer allocated by RtlUnicodeStringToAnsiString.
///Params:
///    AnsiString = A pointer to an ANSI string whose buffer was previously allocated by RtlUnicodeStringToAnsiString.
@DllImport("ntdll")
void RtlFreeAnsiString(STRING* AnsiString);

///Frees the string buffer allocated by RtlAnsiStringToUnicodeString or by <b>RtlUpcaseUnicodeString</b>.
///Params:
///    UnicodeString = A pointer to the Unicode string whose buffer was previously allocated by RtlAnsiStringToUnicodeString.
@DllImport("ntdll")
void RtlFreeUnicodeString(UNICODE_STRING* UnicodeString);

///Frees the string buffer allocated by RtlUnicodeStringToOemString.
///Params:
///    OemString = Address of the OEM string whose buffer was previously allocated by RtlUnicodeStringToOemString.
@DllImport("ntdll")
void RtlFreeOemString(STRING* OemString);

///Initializes a counted string.
///Params:
///    DestinationString = The counted string to be initialized. The <i>DestinationString</i> is initialized to point to the
///                        <i>SourceString</i>. The <b>Length</b> and <b>MaximumLength</b> fields of the <i>DestinationString</i> are
///                        initialized to the length of the <i>SourceString</i>.
///    SourceString = A pointer to a null-terminated string. If the <i>SourceString</i> is not specified, the <b>Length</b> and
///                   <b>MaximumLength</b> fields of the <i>DestinationString</i> are initialized to zero.
@DllImport("ntdll")
void RtlInitString(STRING* DestinationString, byte* SourceString);

@DllImport("ntdll")
NTSTATUS RtlInitStringEx(STRING* DestinationString, byte* SourceString);

@DllImport("ntdll")
void RtlInitAnsiString(STRING* DestinationString, byte* SourceString);

@DllImport("ntdll")
NTSTATUS RtlInitAnsiStringEx(STRING* DestinationString, byte* SourceString);

///Initializes a counted Unicode string.
///Params:
///    DestinationString = The buffer for a counted Unicode string to be initialized. The length is initialized to zero if the
///                        <i>SourceString</i> is not specified.
@DllImport("ntdll")
void RtlInitUnicodeString(UNICODE_STRING* DestinationString, const(wchar)* SourceString);

///Converts the specified ANSI source string into a Unicode string.
///Params:
///    DestinationString = A pointer to a UNICODE_STRING structure to hold the converted Unicode string. If <i>AllocateDestinationString</i>
///                        is <b>TRUE</b>, the routine allocates a new buffer to hold the string data, and updates the <b>Buffer</b> member
///                        of <i>DestinationString</i> to point to the new buffer. Otherwise, the routine uses the currently specified
///                        buffer to hold the string.
///    SourceString = A pointer to the <b>ANSI_STRING</b> structure that contains the ANSI string to be converted to Unicode.
///    AllocateDestinationString = Controls allocation of buffer space for the destination string.
///Returns:
///    The various NTSTATUS values are defined in NTSTATUS.H, which is distributed with the Windows DDK. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>STATUS_SUCCESS</b></dt> </dl>
///    </td> <td width="60%"> The ANSI string was converted to Unicode. On failure, the routine does not allocate any
///    memory. </td> </tr> </table>
///    
@DllImport("ntdll")
NTSTATUS RtlAnsiStringToUnicodeString(UNICODE_STRING* DestinationString, STRING* SourceString, 
                                      ubyte AllocateDestinationString);

///Converts the specified Unicode source string into an ANSI string.
///Params:
///    DestinationString = A pointer to an <b>ANSI_STRING</b> structure to hold the converted ANSI string. If
///                        <i>AllocateDestinationString</i> is <b>TRUE</b>, the routine allocates a new buffer to hold the string data and
///                        updates the <b>Buffer</b> member of <i>DestinationString</i> to point to the new buffer. Otherwise, the routine
///                        uses the currently specified buffer to hold the string.
///    SourceString = The UNICODE_STRING structure that contains the source string to be converted to ANSI.
///    AllocateDestinationString = Controls allocation of the buffer space for the <i>DestinationString</i>.
///Returns:
///    The various NTSTATUS values are defined in NTSTATUS.H, which is distributed with the DDK. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>STATUS_SUCCESS</b></dt> </dl> </td> <td
///    width="60%"> The Unicode string was converted to ANSI. Otherwise, no storage was allocated and no conversion was
///    done. </td> </tr> </table>
///    
@DllImport("ntdll")
NTSTATUS RtlUnicodeStringToAnsiString(STRING* DestinationString, UNICODE_STRING* SourceString, 
                                      ubyte AllocateDestinationString);

///Converts the specified Unicode source string into an OEM string. The translation is done with respect to the OEM code
///page (OCP).
///Params:
///    DestinationString = A pointer to an OEM_STRING structure that is contains the OEM equivalent to the Unicode source string. The
///                        <b>MaximumLength</b> field is set if <i>AllocateDestinationString</i> is <b>TRUE</b>.
///    SourceString = A pointer to an UNICODE_STRING structure that is to be converted to OEM.
///    AllocateDestinationString = Controls allocation of the buffer space for the destination string.
///Returns:
///    The various NTSTATUS values are defined in NTSTATUS.H, which is distributed with the Windows DDK. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>STATUS_SUCCESS</b></dt> </dl>
///    </td> <td width="60%"> The Unicode string was converted to OEM. Otherwise, no storage was allocated, and no
///    conversion was done. </td> </tr> </table>
///    
@DllImport("ntdll")
NTSTATUS RtlUnicodeStringToOemString(STRING* DestinationString, UNICODE_STRING* SourceString, 
                                     ubyte AllocateDestinationString);

///Determines how many bytes are needed to represent a Unicode string as an ANSI string.
///Params:
///    BytesInMultiByteString = Returns the number of bytes for the ANSI equivalent of the Unicode string pointed to by <i>UnicodeString</i>.
///                             This number does not include the terminating <b>NULL</b> character.
///    UnicodeString = The Unicode source string for which the ANSI length is calculated.
///    BytesInUnicodeString = The number of bytes in the string pointed to by <i>UnicodeString</i>.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>STATUS_SUCCESS</b></dt> </dl> </td> <td width="60%"> The count was successful. The various NTSTATUS values
///    are defined in NTSTATUS.H, which is distributed with the Windows DDK. </td> </tr> </table>
///    
@DllImport("ntdll")
NTSTATUS RtlUnicodeToMultiByteSize(uint* BytesInMultiByteString, const(wchar)* UnicodeString, 
                                   uint BytesInUnicodeString);

///Converts a character string to an integer.
///Params:
///    String = A pointer to the string to convert. The format of the string is as follows: [whitespace] [{+ | -}] [0 [{x | o |
///             b}]] [digits]
///    Base = <b>ULONG</b> that contains the number base to use for the conversion, such as base 10. Only base 2, 8, 10, and 16
///           are supported.
///    Value = A pointer to a <b>ULONG</b> that receives the integer that resulted from the conversion.
///Returns:
///    If the function succeeds, the function returns <b>STATUS_SUCCESS</b>.
///    
@DllImport("ntdll")
NTSTATUS RtlCharToInteger(byte* String, uint Base, uint* Value);

///Generates a uniform random number using D.H. Lehmer's 1948 algorithm.
///Params:
///    Seed = The seed value.
///Returns:
///    The function returns a random number uniformly distributed over [0..MAXLONG].
///    
@DllImport("ntdll")
uint RtlUniform(uint* Seed);

///The <b>FCICreate</b> function creates an FCI context.
///Params:
///    perf = Pointer to an ERF structure that receives the error information.
///    pfnfcifp = Pointer to an application-defined callback function to notify when a file is placed in the cabinet. The function
///               should be declared using the FNFCIFILEPLACED macro.
///    pfna = Pointer to an application-defined callback function to allocate memory. The function should be declared using the
///           FNFCIALLOC macro.
///    pfnf = Pointer to an application-defined callback function to free previously allocated memory. The function should be
///           delcared using the FNFCIFREE macro.
///    pfnopen = Pointer to an application-defined callback function to open a file. The function should be declared using the
///              FNFCIOPEN macro.
///    pfnread = Pointer to an application-defined callback function to read data from a file. The function should be declared
///              using the FNFCIREAD macro.
///    pfnwrite = Pointer to an application-defined callback function to write data to a file. The function should be declared
///               using the FNFCIWRITE macro.
///    pfnclose = Pointer to an application-defined callback function to close a file. The function should be declared using the
///               FNFCICLOSE macro.
///    pfnseek = Pointer to an application-defined callback function to move a file pointer to the specific location. The function
///              should be declared using the FNFCISEEK macro.
///    pfndelete = Pointer to an application-defined callback function to delete a file. The function should be declared using the
///                FNFCIDELETE macro.
///    pfnfcigtf = Pointer to an application-defined callback function to retrieve a temporary file name. The function should be
///                declared using the FNFCIGETTEMPFILE macro.
///    pccab = Pointer to a CCAB structure that contains the parameters for creating a cabinet.
///    pv = Pointer to an application-defined value that is passed to callback functions.
///Returns:
///    If the function succeeds, it returns a non-<b>NULL</b> HFCI context pointer; otherwise, <b>NULL</b>. Extended
///    error information is provided in the ERF structure.
///    
@DllImport("Cabinet")
void* FCICreate(ERF* perf, PFNFCIFILEPLACED pfnfcifp, PFNFCIALLOC pfna, PFNFCIFREE pfnf, PFNFCIOPEN pfnopen, 
                PFNFCIREAD pfnread, PFNFCIWRITE pfnwrite, PFNFCICLOSE pfnclose, PFNFCISEEK pfnseek, 
                PFNFCIDELETE pfndelete, PFNFCIGETTEMPFILE pfnfcigtf, CCAB* pccab, void* pv);

///The <b>FCIAddFile</b> adds a file to the cabinet under construction.
///Params:
///    hfci = A valid FCI context handle returned by the FCICreate function.
///    pszSourceFile = The name of the file to add; this value should include path information.
///    pszFileName = The name under which to store the file in the cabinet.
///    fExecute = If set <b>TRUE</b>, the file will be executed when extracted.
///    pfnfcignc = Pointer to an application-defined callback function to obtain specifications on the next cabinet to create. The
///                function should be declared using the FNFCIGETNEXTCABINET macro.
///    pfnfcis = Pointer to an application-defined callback function to update the progress information available to the user. The
///              function should be declared using the FNFCISTATUS macro.
///    pfnfcigoi = Pointer to an application-defined callback function to open a file and retrieve the file date, time, and
///                attributes. The function should be declared using the FNFCIGETOPENINFO macro.
///    typeCompress = The compression type to use. <div class="alert"><b>Note</b> To indicate LZX compression, use the
///                   TCOMPfromLZXWindow macro.</div> <div> </div> <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                   width="40%"><a id="tcompTYPE_NONE"></a><a id="tcomptype_none"></a><a id="TCOMPTYPE_NONE"></a><dl>
///                   <dt><b>tcompTYPE_NONE</b></dt> <dt>0x0000</dt> </dl> </td> <td width="60%"> No compression. </td> </tr> <tr> <td
///                   width="40%"><a id="tcompTYPE_MSZIP"></a><a id="tcomptype_mszip"></a><a id="TCOMPTYPE_MSZIP"></a><dl>
///                   <dt><b>tcompTYPE_MSZIP</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> Microsoft ZIP compression. </td>
///                   </tr> </table>
///Returns:
///    If the function succeeds, it returns <b>TRUE</b>; otherwise, <b>FALSE</b>. Extended error information is provided
///    in the ERF structure used to create the FCI context.
///    
@DllImport("Cabinet")
BOOL FCIAddFile(void* hfci, const(char)* pszSourceFile, const(char)* pszFileName, BOOL fExecute, 
                PFNFCIGETNEXTCABINET pfnfcignc, PFNFCISTATUS pfnfcis, PFNFCIGETOPENINFO pfnfcigoi, 
                ushort typeCompress);

///The <b>FCIFlushCabinet</b> function completes the current cabinet.
///Params:
///    hfci = A valid FCI context handle returned by theFCICreate function.
///    fGetNextCab = Specifies whether the function pointed to by the supplied <i>GetNextCab</i> parameter will be called.
///    pfnfcignc = Pointer to an application-defined callback function to obtain specifications on the next cabinet to create. The
///                function should be declared using the FNFCIGETNEXTCABINET macro.
///    pfnfcis = Pointer to an application-defined callback function to update the user. The function should be declared using the
///              FNFCISTATUS macro.
///Returns:
///    If the function succeeds, it returns <b>TRUE</b>; otherwise, <b>FALSE</b>. Extended error information is provided
///    in the ERF structure used to create the FCI context.
///    
@DllImport("Cabinet")
BOOL FCIFlushCabinet(void* hfci, BOOL fGetNextCab, PFNFCIGETNEXTCABINET pfnfcignc, PFNFCISTATUS pfnfcis);

///The <b>FCIFlushFolder</b> function forces the current folder under construction to be completed immediately.
///Params:
///    hfci = A valid FCI context handle returned by the FCICreate function.
///    pfnfcignc = Pointer to an application-defined callback function to obtain specifications on the next cabinet to create. The
///                function should be declared using the FNFCIGETNEXTCABINET macro.
///    pfnfcis = Pointer to an application-defined callback function to update the user. The function should be declared using the
///              FNFCISTATUS macro.
///Returns:
///    If the function succeeds, it returns <b>TRUE</b>; otherwise, FASLE. Extended error information is provided in the
///    ERF structure used to create the FCI context.
///    
@DllImport("Cabinet")
BOOL FCIFlushFolder(void* hfci, PFNFCIGETNEXTCABINET pfnfcignc, PFNFCISTATUS pfnfcis);

///The <b>FCIDestroy</b> function deletes an open FCI context, freeing any memory and temporary files associated with
///the context.
///Params:
///    hfci = A valid FCI context handle returned by the FCICreate function.
///Returns:
///    If the function succeeds, it returns <b>TRUE</b>; otherwise, <b>FALSE</b>. Extended error information is provided
///    in the ERF structure used to create the FCI context.
///    
@DllImport("Cabinet")
BOOL FCIDestroy(void* hfci);

///The <b>FDICreate</b> function creates an FDI context.
///Params:
///    pfnalloc = Pointer to an application-defined callback function to allocate memory. The function should be declared using the
///               FNALLOC macro.
///    pfnfree = Pointer to an application-defined callback function to free previously allocated memory. The function should be
///              declared using the FNFREE macro.
///    pfnopen = Pointer to an application-defined callback function to open a file. The function should be declared using the
///              FNOPEN macro.
///    pfnread = Pointer to an application-defined callback function to read data from a file. The function should be declared
///              using the FNREAD macro.
///    pfnwrite = Pointer to an application-defined callback function to write data to a file. The function should be declared
///               using the FNWRITE macro.
///    pfnclose = Pointer to an application-defined callback function to close a file. The function should be declared using the
///               FNCLOSE macro.
///    pfnseek = Pointer to an application-defined callback function to move a file pointer to the specified location. The
///              function should be declared using the FNSEEK macro.
///    cpuType = In the 16-bit version of FDI, specifies the CPU type and can be any of the following values. <div
///              class="alert"><b>Note</b> Expressing the <b>cpuUNKNOWN</b> value is recommended.</div> <div> </div> <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="cpuUNKNOWN"></a><a id="cpuunknown"></a><a
///              id="CPUUNKNOWN"></a><dl> <dt><b>cpuUNKNOWN</b></dt> <dt>-1</dt> </dl> </td> <td width="60%"> FDI should determine
///              the CPU type. </td> </tr> <tr> <td width="40%"><a id="cpu80286"></a><a id="CPU80286"></a><dl>
///              <dt><b>cpu80286</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> Only 80286 instructions can be used. </td> </tr>
///              <tr> <td width="40%"><a id="cpu80386"></a><a id="CPU80386"></a><dl> <dt><b>cpu80386</b></dt> <dt>1</dt> </dl>
///              </td> <td width="60%"> 80386 instructions can be used. </td> </tr> </table>
///    perf = Pointer to an ERF structure that receives the error information.
///Returns:
///    If the function succeeds, it returns a non-<b>NULL</b> HFDI context pointer; otherwise, it returns <b>NULL</b>.
///    Extended error information is provided in the ERF structure.
///    
@DllImport("Cabinet")
void* FDICreate(PFNALLOC pfnalloc, PFNFREE pfnfree, PFNOPEN pfnopen, PFNREAD pfnread, PFNWRITE pfnwrite, 
                PFNCLOSE pfnclose, PFNSEEK pfnseek, int cpuType, ERF* perf);

///The <b>FDIIsCabinet</b> function determines whether a file is a cabinet and, if it is, returns information about it.
///Params:
///    hfdi = A valid FDI context handle returned by FDICreate.
///    hf = An application-defined value to keep track of the opened file. This value must be of the same type as values used
///         by the File I/O functions passed to FDICreate.
///    pfdici = Pointer to an FDICABINETINFO structure that receives the cabinet details, in the event the file is actually a
///             cabinet.
///Returns:
///    If the file is a cabinet, the function returns <b>TRUE</b> ; otherwise, <b>FALSE</b>. Extended error information
///    is provided in the ERF structure used to create the FDI context.
///    
@DllImport("Cabinet")
BOOL FDIIsCabinet(void* hfdi, ptrdiff_t hf, FDICABINETINFO* pfdici);

///The <b>FDICopy</b> function extracts files from cabinets.
///Params:
///    hfdi = A valid FDI context handle returned by the FDICreate function.
///    pszCabinet = The name of the cabinet file, excluding any path information, from which to extract files. If a file is split
///                 over multiple cabinets, <b>FDICopy</b> allows for subsequent cabinets to be opened.
///    pszCabPath = The pathname of the cabinet file, but not including the name of the file itself. For example, "C:\MyCabs\". The
///                 contents of <i>pszCabinet</i> are appended to <i>pszCabPath</i> to create the full pathname of the cabinet.
///    flags = No flags are currently defined and this parameter should be set to zero.
///    pfnfdin = Pointer to an application-defined callback notification function to update the application on the status of the
///              decoder. The function should be declared using the FNFDINOTIFY macro.
///    pfnfdid = Not currently used by FDI. This parameter should be set to <b>NULL</b>.
///    pvUser = Pointer to an application-specified value to pass to the notification function.
///Returns:
///    If the function succeeds, it returns <b>TRUE</b>; otherwise, <b>FALSE</b>. Extended error information is provided
///    in the ERF structure used to create the FDI context.
///    
@DllImport("Cabinet")
BOOL FDICopy(void* hfdi, const(char)* pszCabinet, const(char)* pszCabPath, int flags, PFNFDINOTIFY pfnfdin, 
             PFNFDIDECRYPT pfnfdid, void* pvUser);

///The <b>FDIDestroy</b> function deletes an open FDI context.
///Params:
///    hfdi = A valid FDI context handle returned by the FDICreate function.
///Returns:
///    If the function succeeds, it returns <b>TRUE</b>; otherwise, <b>FALSE</b>. Extended error information is provided
///    in the ERF structure used to create the FDI context.
///    
@DllImport("Cabinet")
BOOL FDIDestroy(void* hfdi);

///The <b>FDITruncateCabinet</b> function truncates a cabinet file starting at the specified folder number.
///Params:
///    hfdi = A valid FDI context handle returned by the FDICreate function.
///    pszCabinetName = The full cabinet filename.
///    iFolderToDelete = The index of the first folder to delete.
///Returns:
///    If the function succeeds, it returns <b>TRUE</b>; otherwise, <b>FALSE</b>. Extended error information is provided
///    in the ERF structure used to create the FDI context.
///    
@DllImport("Cabinet")
BOOL FDITruncateCabinet(void* hfdi, const(char)* pszCabinetName, ushort iFolderToDelete);

///This function is intended for infrastructure use only. Do not use this function.
///Params:
///    featureId = Infrastructure use only.
///    changeTime = Infrastructure use only.
@DllImport("api-ms-win-core-featurestaging-l1-1-0")
FEATURE_ENABLED_STATE GetFeatureEnabledState(uint featureId, FEATURE_CHANGE_TIME changeTime);

///This function is intended for infrastructure use only. Do not use this function.
///Params:
///    featureId = Infrastructure use only.
///    kind = Infrastructure use only.
///    addend = Infrastructure use only.
@DllImport("api-ms-win-core-featurestaging-l1-1-0")
void RecordFeatureUsage(uint featureId, uint kind, uint addend, const(char)* originName);

///This function is intended for infrastructure use only. Do not use this function.
///Params:
///    featureId = Infrastructure use only.
@DllImport("api-ms-win-core-featurestaging-l1-1-0")
void RecordFeatureError(uint featureId, const(FEATURE_ERROR)* error);

///This function is intended for infrastructure use only. Do not use this function.
///Params:
///    subscription = Infrastructure use only.
///    callback = Infrastructure use only.
@DllImport("api-ms-win-core-featurestaging-l1-1-0")
void SubscribeFeatureStateChangeNotification(FEATURE_STATE_CHANGE_SUBSCRIPTION__** subscription, 
                                             PFEATURE_STATE_CHANGE_CALLBACK callback, void* context);

///This function is intended for infrastructure use only. Do not use this function.
@DllImport("api-ms-win-core-featurestaging-l1-1-0")
void UnsubscribeFeatureStateChangeNotification(FEATURE_STATE_CHANGE_SUBSCRIPTION__* subscription);

///This function is intended for infrastructure use only. Do not use this function.
///Params:
///    featureId = Infrastructure use only.
///    changeTime = Infrastructure use only.
///    payloadId = Infrastructure use only.
///    hasNotification = Infrastructure use only.
@DllImport("api-ms-win-core-featurestaging-l1-1-1")
uint GetFeatureVariant(uint featureId, FEATURE_CHANGE_TIME changeTime, uint* payloadId, int* hasNotification);

///Opens a communication channel to the File History Service. > [!NOTE] > **FhServiceOpenPipe** is deprecated and may be
///altered or unavailable in future releases.
///Params:
///    StartServiceIfStopped = If the File History Service is not started yet and this parameter is <b>TRUE</b>, this function starts the File
///                            History Service before opening a communication channel to it. If the File History Service is not started yet and
///                            this parameter is <b>FALSE</b>, this function fails and returns an unsuccessful <b>HRESULT</b> value.
///    Pipe = On successful return, this parameter contains a non-NULL handle representing a newly opened communication channel
///           to the File History Service.
///Returns:
///    <b>S_OK</b> on success, or an unsuccessful <b>HRESULT</b> value on failure. Possible unsuccessful <b>HRESULT</b>
///    values include values defined in the FhErrors.h header file.
///    
@DllImport("fhsvcctl")
HRESULT FhServiceOpenPipe(BOOL StartServiceIfStopped, FH_SERVICE_PIPE_HANDLE__** Pipe);

///Closes a communication channel to the File History Service opened with FhServiceOpenPipe. > [!NOTE] >
///**FhServiceClosePipe** is deprecated and may be altered or unavailable in future releases.
///Params:
///    Pipe = The communication channel handle returned by an earlier FhServiceOpenPipe call.
///Returns:
///    <b>S_OK</b> on success, or an unsuccessful <b>HRESULT</b> value on failure. Possible unsuccessful <b>HRESULT</b>
///    values include values defined in the FhErrors.h header file.
///    
@DllImport("fhsvcctl")
HRESULT FhServiceClosePipe(FH_SERVICE_PIPE_HANDLE__* Pipe);

///This function starts an immediate backup for the current user. > [!NOTE] > **FhServiceStartBackup** is deprecated and
///may be altered or unavailable in future releases.
///Params:
///    Pipe = The communication channel handle returned by an earlier FhServiceOpenPipe call.
///    LowPriorityIo = If <b>TRUE</b>, the File History Service is instructed to use low priority I/O for the immediate backup scheduled
///                    by this function. Low-priority I/O reduces impact on foreground user activities. It is recommended to set this
///                    parameter to <b>TRUE.</b> If <b>FALSE</b>, the File History Service is instructed to use normal priority I/O for
///                    the immediate backup scheduled by this function. This results in faster backups but negatively affects the
///                    responsiveness and performance of user applications.
///Returns:
///    <b>S_OK</b> on success, or an unsuccessful <b>HRESULT</b> on failure. Possible unsuccessful <b>HRESULT</b> values
///    include values defined in the FhErrors.h header file.
///    
@DllImport("fhsvcctl")
HRESULT FhServiceStartBackup(FH_SERVICE_PIPE_HANDLE__* Pipe, BOOL LowPriorityIo);

///This function stops an ongoing backup cycle for the current user. > [!NOTE] > **FhServiceStopBackup** is deprecated
///and may be altered or unavailable in future releases.
///Params:
///    Pipe = The communication channel handle returned by an earlier FhServiceOpenPipe call.
///    StopTracking = If <b>TRUE</b>, this function both stops the ongoing backup cycle (if any) and prevents periodic backup cycles
///                   for the current user in the future. If <b>FALSE</b>, this function only stops the ongoing backup cycle.
///Returns:
///    <b>S_OK</b> on success, or an unsuccessful <b>HRESULT</b> value on failure. Possible unsuccessful <b>HRESULT</b>
///    values include values defined in the FhErrors.h header file.
///    
@DllImport("fhsvcctl")
HRESULT FhServiceStopBackup(FH_SERVICE_PIPE_HANDLE__* Pipe, BOOL StopTracking);

///This function causes the File History Service to reload the current user’s File History configuration files. >
///[!NOTE] > **FhServiceReloadConfiguration** is deprecated and may be altered or unavailable in future releases.
///Params:
///    Pipe = The communication channel handle returned by an earlier FhServiceOpenPipe call.
///Returns:
///    <b>S_OK</b> on success, or an unsuccessful <b>HRESULT</b> value on failure. Possible unsuccessful <b>HRESULT</b>
///    values include values defined in the FhErrors.h header file.
///    
@DllImport("fhsvcctl")
HRESULT FhServiceReloadConfiguration(FH_SERVICE_PIPE_HANDLE__* Pipe);

///This function temporarily blocks backups for the current user. > [!NOTE] > **FhServiceBlockBackup** is deprecated and
///may be altered or unavailable in future releases.
///Params:
///    Pipe = The communication channel handle returned by an earlier FhServiceOpenPipe call.
///Returns:
///    <b>S_OK</b> on success, or an unsuccessful <b>HRESULT</b> value on failure. Possible unsuccessful <b>HRESULT</b>
///    values include values defined in the FhErrors.h header file.
///    
@DllImport("fhsvcctl")
HRESULT FhServiceBlockBackup(FH_SERVICE_PIPE_HANDLE__* Pipe);

///This function unblocks backups blocked via FhServiceBlockBackup. > [!NOTE] > **FhServiceUnblockBackup** is deprecated
///and may be altered or unavailable in future releases.
///Params:
///    Pipe = The communication channel handle returned by an earlier FhServiceOpenPipe call.
///Returns:
///    <b>S_OK</b> on success, or an unsuccessful <b>HRESULT</b> value on failure. Possible unsuccessful <b>HRESULT</b>
///    values include values defined in the FhErrors.h header file.
///    
@DllImport("fhsvcctl")
HRESULT FhServiceUnblockBackup(FH_SERVICE_PIPE_HANDLE__* Pipe);

///<p class="CCE_Message">[This function is subject to change with each operating system revision. Instead, use the
///Microsoft DirectDraw and Microsoft Direct3DAPIs; these APIs insulate applications from such operating system changes,
///and hide many other difficulties involved in interacting directly with display drivers.] Obtains a device context
///handle of display.
///Returns:
///    Device context handle of display.
///    
@DllImport("DCIMAN32")
HDC DCIOpenProvider();

///<p class="CCE_Message">[This function is subject to change with each operating system revision. Instead, use the
///Microsoft DirectDraw and Microsoft Direct3DAPIs; these APIs insulate applications from such operating system changes,
///and hide many other difficulties involved in interacting directly with display drivers.] Closes a device context of a
///display.
///Params:
///    hdc = The device context handle to be closed. The handle was created with DCIOpenProvider.
///Returns:
///    If the function succeeds, the return value is nonzero. Otherwise, it returns zero.
///    
@DllImport("DCIMAN32")
void DCICloseProvider(HDC hdc);

///<p class="CCE_Message">[This function is subject to change with each operating system revision. Instead, use the
///Microsoft DirectDraw and Microsoft Direct3DAPIs; these APIs insulate applications from such operating system changes,
///and hide many other difficulties involved in interacting directly with display drivers.] Creates a primary surface
///and obtains surface information.
///Params:
///    hdc = The device context handle of the device for the primary surface to be created.
///    lplpSurface = A pointer to a <b>DCISURFACEINFO</b> structure.
///Returns:
///    If the function succeeds, DCI_OK is returned. Otherwise, it returns one of the DCI errors.
///    
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

///<p class="CCE_Message">[This function is subject to change with each operating system revision. Instead, use the
///Microsoft DirectDraw and Microsoft Direct3DAPIs; these APIs insulate applications from such operating system changes,
///and hide many other difficulties involved in interacting directly with display drivers.] Releases access to display
///frame buffer.
///Params:
///    pdci = A pointer to a <b>DCISURFACEINFO</b> structure.
@DllImport("DCIMAN32")
void DCIEndAccess(DCISURFACEINFO* pdci);

///<p class="CCE_Message">[This function is subject to change with each operating system revision. Instead, use the
///Microsoft DirectDraw and Microsoft Direct3DAPIs; these APIs insulate applications from such operating system changes,
///and hide many other difficulties involved in interacting directly with display drivers.] Obtains an access pointer to
///display frame buffer based on the given rectangle.
///Params:
///    pdci = A pointer to a <b>DCISURFACEINFO</b> structure.
///    x = The x-coordinate of the upper-left corner of the rectangle.
///    y = The y-coordinate of the upper-left corner of the rectangle.
///    dx = The width of the rectangle.
///    dy = The height of the rectangle.
///Returns:
///    If the function succeeds, the return value is DCI_OK or DCI_STATUS_POINTERCHANGED. DCI_STATUS_POINTERCHANGED
///    indicates that the virtual address of the frame buffer could have been changed since the last call. So the
///    application should not assume the consistency of the virtual address of the display frame buffer. If the function
///    fails, the return value is one of the DCI errors.
///    
@DllImport("DCIMAN32")
int DCIBeginAccess(DCISURFACEINFO* pdci, int x, int y, int dx, int dy);

///<p class="CCE_Message">[This function is subject to change with each operating system revision. Instead, use the
///Microsoft DirectDraw and Microsoft Direct3DAPIs; these APIs insulate applications from such operating system changes,
///and hide many other difficulties involved in interacting directly with display drivers.] Destroys a primary surface
///on the display device.
///Params:
///    pdci = A pointer to a <b>DCISURFACEINFO</b> structure.
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

///Updates the string registry values in the provided table.
///Params:
///    hmod = The module containing the values to be updated.
///    pszSection = The sections containing the values to be updated.
///    pstTable = The table of values to be updated.
///Returns:
///    Returns S_OK on success. Returns E_FAIL on failure.
///    
@DllImport("ADVPACK")
HRESULT RegInstallA(ptrdiff_t hmod, const(char)* pszSection, const(STRTABLEA)* pstTable);

///Updates the string registry values in the provided table.
///Params:
///    hmod = The module containing the values to be updated.
///    pszSection = The sections containing the values to be updated.
///    pstTable = The table of values to be updated.
///Returns:
///    Returns S_OK on success. Returns E_FAIL on failure.
///    
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

///<p class="CCE_Message">[This function is obsolete and should not be used.] Specifies an action or processing for the
///Input Method Editor (IME) through a specified subfunction.
///Params:
///    HWND = The window handle of the application that initiates the transaction. Generally, it is the window that has focus.
///    LPARAM = A <b>DWORD</b> value in which the low-order word specifies a handle to the global memory that contains an
///             IMESTRUCT structure. The global memory is allocated by specifying the <b>GMEM_MOVEABLE</b> and <b>GMEM_SHARE</b>
///             flags in the GlobalAlloc function. The high-order word is reserved; it is not used.
///Returns:
///    The result of processing of the subfunction. If the result is not success, one of the following error codes is
///    stored into the <b>wParam</b> of the IMESTRUCT structure. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>IME_RS_DISKERROR</b></dt> </dl> </td> <td width="60%"> Disk error. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>IME_RS_ERROR</b></dt> </dl> </td> <td width="60%"> General error. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>IME_RS_ILLEGAL</b></dt> </dl> </td> <td width="60%"> Contains an illegal
///    character. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IME_RS_INVALID</b></dt> </dl> </td> <td width="60%">
///    Invalid subfunction. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IME_RS_NEST</b></dt> </dl> </td> <td
///    width="60%"> Subfunction is nested and, therefore, cannot be used. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>IME_RS_NOIME</b></dt> </dl> </td> <td width="60%"> The IME has not been selected (has not been installed).
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IME_RS_NOROOM</b></dt> </dl> </td> <td width="60%"> Short of area.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IME_RS_NOTFOUND</b></dt> </dl> </td> <td width="60%"> No candidate
///    found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IME_RS_SYSTEMMODAL</b></dt> </dl> </td> <td width="60%">
///    Windows is in system mode, data cannot be passed to the IME. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>IME_RS_TOOLONG</b></dt> </dl> </td> <td width="60%"> Characters too long. </td> </tr> </table>
///    
@DllImport("USER32")
LRESULT SendIMEMessageExA(HWND param0, LPARAM param1);

///<p class="CCE_Message">[This function is obsolete and should not be used.] Specifies an action or processing for the
///Input Method Editor (IME) through a specified subfunction.
///Params:
///    HWND = The window handle of the application that initiates the transaction. Generally, it is the window that has focus.
///    LPARAM = A <b>DWORD</b> value in which the low-order word specifies a handle to the global memory that contains an
///             IMESTRUCT structure. The global memory is allocated by specifying the <b>GMEM_MOVEABLE</b> and <b>GMEM_SHARE</b>
///             flags in the GlobalAlloc function. The high-order word is reserved; it is not used.
///Returns:
///    The result of processing of the subfunction. If the result is not success, one of the following error codes is
///    stored into the <b>wParam</b> of the IMESTRUCT structure. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>IME_RS_DISKERROR</b></dt> </dl> </td> <td width="60%"> Disk error. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>IME_RS_ERROR</b></dt> </dl> </td> <td width="60%"> General error. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>IME_RS_ILLEGAL</b></dt> </dl> </td> <td width="60%"> Contains an illegal
///    character. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IME_RS_INVALID</b></dt> </dl> </td> <td width="60%">
///    Invalid subfunction. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IME_RS_NEST</b></dt> </dl> </td> <td
///    width="60%"> Subfunction is nested and, therefore, cannot be used. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>IME_RS_NOIME</b></dt> </dl> </td> <td width="60%"> The IME has not been selected (has not been installed).
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IME_RS_NOROOM</b></dt> </dl> </td> <td width="60%"> Short of area.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IME_RS_NOTFOUND</b></dt> </dl> </td> <td width="60%"> No candidate
///    found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IME_RS_SYSTEMMODAL</b></dt> </dl> </td> <td width="60%">
///    Windows is in system mode, data cannot be passed to the IME. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>IME_RS_TOOLONG</b></dt> </dl> </td> <td width="60%"> Characters too long. </td> </tr> </table>
///    
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

///Temporarily enables or disables an Input Method Editor (IME) and, at the same time, turns on or off the display of
///all windows owned by the IME. <div class="alert"><b>Note</b> This function is obsolete and should not be
///used.</div><div> </div>
///Params:
///    HWND = Must be <b>NULL</b>. Specifying a particular IME for each application is not supported.
///    BOOL = <b>TRUE</b> to enable the IME; <b>FALSE</b> to disable.
///Returns:
///    The previous state of the IME. <b>TRUE</b> if it was enabled before this call, otherwise, <b>FALSE</b>.
///    
@DllImport("USER32")
BOOL WINNLSEnableIME(HWND param0, BOOL param1);

@DllImport("USER32")
BOOL WINNLSGetEnableStatus(HWND param0);

@DllImport("api-ms-win-security-isolatedcontainer-l1-1-1")
HRESULT IsProcessInWDAGContainer(void* Reserved, int* isProcessInWDAGContainer);

@DllImport("api-ms-win-security-isolatedcontainer-l1-1-0")
HRESULT IsProcessInIsolatedContainer(int* isProcessInIsolatedContainer);

///Registers a callback function to be run when Windows Security Center (WSC) detects a change that could affect the
///health of one of the security providers.
///Params:
///    Reserved = Reserved. Must be <b>NULL</b>.
///    phCallbackRegistration = A pointer to a handle to the callback registration. When you are finished using the callback function, unregister
///                             it by calling the WscUnRegisterChanges function.
///    lpCallbackAddress = A pointer to the application-defined function to be called when a change to the WSC service occurs. This function
///                        is also called when the WSC service is started or stopped.
///    pContext = A pointer to a variable to be passed as the <i>lpParameter</i> parameter to the function pointed to by the
///               <i>lpCallbackAddress</i> parameter.
///Returns:
///    Returns S_OK if the function succeeds, otherwise returns an error code.
///    
@DllImport("WSCAPI")
HRESULT WscRegisterForChanges(void* Reserved, ptrdiff_t* phCallbackRegistration, 
                              LPTHREAD_START_ROUTINE lpCallbackAddress, void* pContext);

///Cancels a callback registration that was made by a call to the WscRegisterForChanges function.
///Params:
///    hRegistrationHandle = The handle to the registration context returned as the <i>phCallbackRegistration</i> of the WscRegisterForChanges
///                          function.
///Returns:
///    Returns <b>S_OK</b> if the function succeeds, otherwise returns an error code.
///    
@DllImport("WSCAPI")
HRESULT WscUnRegisterChanges(HANDLE hRegistrationHandle);

@DllImport("WSCAPI")
HRESULT WscRegisterForUserNotifications();

///Gets the aggregate health state of the security provider categories represented by the specified
///WSC_SECURITY_PROVIDER enumeration values.
///Params:
///    Providers = One or more of the values in the WSC_SECURITY_PROVIDER enumeration. To specify more than one value, combine the
///                individual values by performing a bitwise OR operation.
///    pHealth = A pointer to a variable that takes the value of one of the members of the WSC_SECURITY_PROVIDER_HEALTH
///              enumeration. If more than one provider is specified in the <i>Providers</i> parameter, the value of this
///              parameter is the health of the least healthy of the specified provider categories.
///Returns:
///    Returns <b>S_OK</b> if the function succeeds, otherwise returns an error code. If the WSC service is not running,
///    the return value is always <b>S_FALSE</b> and the <i>pHealth</i> out parameter is always set to
///    <b>WSC_SECURITY_PROVIDER_HEALTH_POOR</b>.
///    
@DllImport("WSCAPI")
HRESULT WscGetSecurityProviderHealth(uint Providers, WSC_SECURITY_PROVIDER_HEALTH* pHealth);

@DllImport("WSCAPI")
HRESULT WscQueryAntiMalwareUri();

@DllImport("WSCAPI")
HRESULT WscGetAntiMalwareUri(ushort** ppszUri);

///<p class="CCE_Message">[This function is available for use in the Windows Server 2003 and Windows XP operating
///systems. It may be altered or unavailable in the future.] Enables applications to detect bad extension objects and
///either block them from running or fix them.
///Params:
///    ObjectCLSID = The GUID of a register class.
///    bShimIfNecessary = This parameter is <b>TRUE</b> if a shim is needed; <b>FALSE</b> otherwise.
///    pullFlags = This parameter is filled with a 64-bit flag mask that can be used to turn on application modification flags in
///                Explorer/IE. These are located in the application compatibility database.
///Returns:
///    <b>FALSE</b> if the object should be blocked from instantiating; <b>TRUE</b> otherwise.
///    
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

///Checks whether the user has opted in for SQM data collection as part of the Customer Experience Improvement Program
///(CEIP).
///Returns:
///    True if SQM data collection is opted in and the machine can send data. Otherwise, false.
///    
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

///<p class="CCE_Message">[This function is not supported and may be altered or unavailable in the future.] Installs the
///requested COM server application.
///Params:
///    pbc = Reserved for future use; this value must be <b>NULL</b>.
///    dwFlags = Reserved for future use; this value must be 0.
///    pClassSpec = A pointer to a <b>uCLSSPEC</b> union. The <b>tyspec</b> member must be set to TYSPEC_CLSID and the <b>clsid</b>
///                 member must be set to the CLSID to be installed. For more information, see TYSPEC.
///    pQuery = A pointer to a QUERYCONTEXT structure. The <b>dwContext</b> field must be set to the desired CLSCTX value. For
///             more information, see <b>QUERYCONTEXT</b>.
///    pszCodeBase = Reserved for future use; this value must be <b>NULL</b>.
///Returns:
///    This function supports the standard return value E_INVALIDARG, as well as the following. <table> <tr>
///    <th>Term</th> <th>Description</th> </tr> <tr> <td width="40%"> <a id="S_OK"></a><a id="s_ok"></a>S_OK </td> <td
///    width="60%"> Indicates success. </td> </tr> <tr> <td width="40%"> <a id="CS_E_PACKAGE_NOTFOUND"></a><a
///    id="cs_e_package_notfound"></a>CS_E_PACKAGE_NOTFOUND </td> <td width="60%"> The <b>tyspec</b> field of
///    <i>pClassSpec</i> was not set to TYSPEC_CLSID. </td> </tr> </table>
///    
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

///The <b>IXMLElementCollection</b> interface supports collection of XML elements for indexed access.
@GUID("65725580-9B5D-11D0-9BFE-00C04FC99C8E")
interface IXMLElementCollection : IDispatch
{
    HRESULT put_length(int v);
    ///Retrieves the number of elements in the collection.
    ///Params:
    ///    p = The number of elements in the collection.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_length(int* p);
    HRESULT get__newEnum(IUnknown* ppUnk);
    ///Retrieves the child elements from a collection using their index, name, or both.
    ///Params:
    ///    var1 = A valid index numeric value (within the length of IXMLElementCollection) or the name of an element in the XML
    ///           hierarchy.
    ///    var2 = A valid index numeric value (within the length of IXMLElementCollection) or the name of an element in the XML
    ///           hierarchy.
    ///    ppDisp = TBD
    ///Returns:
    ///    Returns an <b>IDispatch</b> pointer to an addressable memory location where the collection is retrievable.
    ///    
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

///Callback interface for receiving events from the camera user interface control.
@GUID("1BFA0C2C-FBCD-4776-BDA4-88BF974E74F4")
interface ICameraUIControlEventCallback : IUnknown
{
    ///Occurs when startup for the camera UI control has completed.
    void OnStartupComplete();
    ///Occurs when the camera UI control has completed being suspended.
    void OnSuspendComplete();
    ///Occurs when an item is captured.
    ///Params:
    ///    pszPath = The path to the captured item.
    void OnItemCaptured(const(wchar)* pszPath);
    ///Occurs when an item is deleted.
    ///Params:
    ///    pszPath = The path to the deleted item.
    void OnItemDeleted(const(wchar)* pszPath);
    ///Occurs when the camera UI control is closed.
    void OnClosed();
}

///Enables a user interface control for a camera device..
@GUID("B8733ADF-3D68-4B8F-BB08-E28A0BED0376")
interface ICameraUIControl : IUnknown
{
    ///Displays the user interface control for the camera.
    ///Params:
    ///    pWindow = Pointer to the user interface window.
    ///    mode = Specifies whether the user interface will be presented in a browseable or linear manner.
    ///    selectionMode = Specifies the selection mode.
    ///    captureMode = Specifies whether the user interface that will be shown allows the user to capture a photo, capture a video,
    ///                  or either.
    ///    photoFormat = Provides the format for capturing photos. The available formats include JPEG, PNG, and JPEG XR.
    ///    videoFormat = Provides the format for capturing videos. The available formats include MP4 and WMV.
    ///    bHasCloseButton = TRUE if the user interface has a close button, otherwise, FALSE.
    ///    pEventCallback = Pointer to an event callback for the dialog. The callback is invoked if an item is captured or deleted, and
    ///                     when the dialog starts, or is closed or suspended.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Show(IUnknown pWindow, CameraUIControlMode mode, CameraUIControlLinearSelectionMode selectionMode, 
                 CameraUIControlCaptureMode captureMode, CameraUIControlPhotoFormat photoFormat, 
                 CameraUIControlVideoFormat videoFormat, BOOL bHasCloseButton, 
                 ICameraUIControlEventCallback pEventCallback);
    ///Closes the user interface control.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Close();
    ///Simulates suspend of the user interface control.
    ///Params:
    ///    pbDeferralRequired = TRUE if the suspend operation requires deferral; otherwise, FALSE.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Suspend(int* pbDeferralRequired);
    ///Simulates resume of the user interface control.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Resume();
    ///Gets the type of the current view.
    ///Params:
    ///    pViewType = A value that indicates whether the UI presents single items or lists of items.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetCurrentViewType(CameraUIControlViewType* pViewType);
    ///Gets the active captured item.
    ///Params:
    ///    pbstrActiveItemPath = Path to the currently active captured item.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetActiveItem(BSTR* pbstrActiveItemPath);
    ///Gets the selected items.
    ///Params:
    ///    ppSelectedItemPaths = An array of paths to captured items selected in the user interface.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSelectedItems(SAFEARRAY** ppSelectedItemPaths);
    ///Removes the captured item.
    ///Params:
    ///    pszPath = The path to the item to delete.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RemoveCapturedItem(const(wchar)* pszPath);
}

///Allows the Windows Store to install a Windows product that the user purchased, to perform either an upgrade to the
///edition of Windows that the user currently has installed, or to replace a non-genuine copy of Windows with a genuine
///copy of Windows.
@GUID("D3E9E342-5DEB-43B6-849E-6913B85D503A")
interface IEditionUpgradeHelper : IUnknown
{
    ///Checks if the user has sufficient permissions to upgrade the operating system, and prompts the user to run as an
    ///administrator if needed.
    ///Params:
    ///    isAllowed = TRUE if the user has sufficient permissions to upgrade the operating system; otherwise FALSE.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CanUpgrade(int* isAllowed);
    ///Upgrades the installed edition of the operating system to the edition that the user purchased in the Windows
    ///Store, or gets a genuine copy of the operating system.
    ///Params:
    ///    contentId = The content identifier of the edition of the operating system that the user purchased and which the method
    ///                should install. If this edition is a higher edition that the currently installed edition of Windows, this
    ///                method performs an upgrade to that edition, If this edition is the same edition as the currently installed
    ///                edition, this method installs a genuine copy of that edition.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT UpdateOperatingSystem(const(wchar)* contentId);
    ///Displays the user interface through which the user can provide a product key to upgrade or get a genuine copy of
    ///the operating system.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ShowProductKeyUI();
    ///Retrieves the content identifier that corresponds to the current installation of the operating system. The
    ///content identifier is used to look up the operating system product in the store catalog.
    ///Params:
    ///    contentId = The content identifier that corresponds to the current installation of the operating system.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetOsProductContentId(ushort** contentId);
    ///Retrieves whether the currently installed operating system is activated.
    ///Params:
    ///    isGenuine = TRUE is the currently installed operating system is activated; otherwise, FALSE.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
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

///The <b>IFhTarget</b> interface allows client applications to read numeric and string properties of a File History
///backup target. > [!NOTE] > **IFhTarget** is deprecated and may be altered or unavailable in future releases.
@GUID("D87965FD-2BAD-4657-BD3B-9567EB300CED")
interface IFhTarget : IUnknown
{
    ///Retrieves a string property of the File History backup target that is represented by an IFhTarget interface. >
    ///[!NOTE] > **IFhTarget** is deprecated and may be altered or unavailable in future releases.
    ///Params:
    ///    PropertyType = Specifies the string property. See the FH_TARGET_PROPERTY_TYPE enumeration for the list of possible string
    ///                   property types.
    ///    PropertyValue = This parameter must be <b>NULL</b> on input. On output, it receives a pointer to a string that contains the
    ///                    string property. This string is allocated by calling SysAllocString. You must call SysFreeString to free the
    ///                    string when it is no longer needed.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code such as
    ///    one of the values defined in the FhErrors.h header file.
    ///    
    HRESULT GetStringProperty(FH_TARGET_PROPERTY_TYPE PropertyType, BSTR* PropertyValue);
    ///Retrieves a numeric property of the File History backup target that is represented by an IFhTarget interface. >
    ///[!NOTE] > **IFhTarget** is deprecated and may be altered or unavailable in future releases.
    ///Params:
    ///    PropertyType = Specifies the numeric property. See the FH_TARGET_PROPERTY_TYPE enumeration for a list of possible numeric
    ///                   properties.
    ///    PropertyValue = Receives the value of the numeric property.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code such as
    ///    one of the values defined in the FhErrors.h header file.
    ///    
    HRESULT GetNumericalProperty(FH_TARGET_PROPERTY_TYPE PropertyType, ulong* PropertyValue);
}

///The <b>IFhScopeIterator</b> interface allows client applications to enumerate individual items in an inclusion or
///exclusion list. To retrieve inclusion and exclusion lists, call the IFhConfigMgr::GetIncludeExcludeRules method. >
///[!NOTE] > **IFhScopeIterator** is deprecated and may be altered or unavailable in future releases.
@GUID("3197ABCE-532A-44C6-8615-F3666566A720")
interface IFhScopeIterator : IUnknown
{
    ///Moves to the next item in the inclusion or exclusion list. > [!NOTE] > **IFhScopeIterator** is deprecated and may
    ///be altered or unavailable in future releases.
    ///Returns:
    ///    <b>S_OK</b> on success, or an unsuccessful <b>HRESULT</b> on failure. Possible unsuccessful <b>HRESULT</b>
    ///    values include values defined in the FhErrors.h header file.
    ///    
    HRESULT MoveToNextItem();
    ///Retrieves the current item in an inclusion or exclusion list. > [!NOTE] > **IFhScopeIterator** is deprecated and
    ///may be altered or unavailable in future releases.
    ///Params:
    ///    Item = This parameter must be <b>NULL</b> on input. On output, it receives a pointer to a string that contains the
    ///           current element of the list. This element is a library name or a folder name, depending on the parameters
    ///           that were passed to the IFhConfigMgr::GetIncludeExcludeRules method. The string is allocated by calling
    ///           SysAllocString. You must call SysFreeString to free the string when it is no longer needed.
    ///Returns:
    ///    <b>S_OK</b> on success, or an unsuccessful <b>HRESULT</b> on failure. Possible unsuccessful <b>HRESULT</b>
    ///    values include values defined in the FhErrors.h header file.
    ///    
    HRESULT GetItem(BSTR* Item);
}

///The <b>IFhConfigMgr</b> interface allows client applications to read and modify the File History configuration for
///the user account under which the methods of this interface are called. > [!NOTE] > **IFhConfigMgr** is deprecated and
///may be altered or unavailable in future releases.
@GUID("6A5FEA5B-BF8F-4EE5-B8C3-44D8A0D7331C")
interface IFhConfigMgr : IUnknown
{
    ///Loads the File History configuration information for the current user into an FhConfigMgr object. > [!NOTE] >
    ///**IFhConfigMgr** is deprecated and may be altered or unavailable in future releases.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code such as
    ///    one of the values defined in the FhErrors.h header file.
    ///    
    HRESULT LoadConfiguration();
    ///Creates File History configuration files with default settings for the current user and loads them into an
    ///FhConfigMgr object. > [!NOTE] > **IFhConfigMgr** is deprecated and may be altered or unavailable in future
    ///releases.
    ///Params:
    ///    OverwriteIfExists = If File History configuration files already exist for the current user and this parameter is set to
    ///                        <b>TRUE</b>, those files are overwritten and all previous settings and policies are reset to default values.
    ///                        If File History configuration files already exist for the current user and this parameter is set to
    ///                        <b>FALSE</b>, those files are not overwritten and an unsuccessful <b>HRESULT</b> value is returned.
    ///Returns:
    ///    <b>S_OK</b> on success, or an unsuccessful <b>HRESULT</b> value on failure. Possible unsuccessful
    ///    <b>HRESULT</b> values include values defined in the FhErrors.h header file.
    ///    
    HRESULT CreateDefaultConfiguration(BOOL OverwriteIfExists);
    ///Saves to disk all the changes that were made in an FhConfigMgr object since the last time that the
    ///LoadConfiguration, CreateDefaultConfiguration or <b>SaveConfiguration</b> method was called for the File History
    ///configuration files of the current user. > [!NOTE] > **IFhConfigMgr** is deprecated and may be altered or
    ///unavailable in future releases.
    ///Returns:
    ///    <b>S_OK</b> on success, or an unsuccessful <b>HRESULT</b> value on failure. Possible unsuccessful
    ///    <b>HRESULT</b> values include values defined in the FhErrors.h header file.
    ///    
    HRESULT SaveConfiguration();
    ///Adds an exclusion rule to the exclusion list or removes a rule from the list. > [!NOTE] > **IFhConfigMgr** is
    ///deprecated and may be altered or unavailable in future releases.
    ///Params:
    ///    Add = If this parameter is <b>TRUE</b>, a new exclusion rule is added. If it is set to <b>FALSE</b>, an existing
    ///          exclusion rule is removed.
    ///    Category = Specifies the type of the exclusion rule. See the FH_PROTECTED_ITEM_CATEGORY enumeration for possible values.
    ///    Item = The folder path or library name or GUID of the item that the exclusion rule applies to.
    ///Returns:
    ///    <b>S_OK</b> on success, or an unsuccessful <b>HRESULT</b> value on failure. Possible unsuccessful
    ///    <b>HRESULT</b> values include values defined in the FhErrors.h header file.
    ///    
    HRESULT AddRemoveExcludeRule(BOOL Add, FH_PROTECTED_ITEM_CATEGORY Category, BSTR Item);
    ///Retrieves the inclusion and exclusion rules that are currently stored in an FhConfigMgr object. > [!NOTE] >
    ///**IFhConfigMgr** is deprecated and may be altered or unavailable in future releases.
    ///Params:
    ///    Include = If set to <b>TRUE</b>, inclusion rules are returned. If set to <b>FALSE</b>, exclusion rules are returned.
    ///    Category = An FH_PROTECTED_ITEM_CATEGORY enumeration value that specifies the type of the inclusion or exclusion rules.
    ///    Iterator = Receives an IFhScopeIterator interface pointer that can be used to enumerate the rules in the requested
    ///               category.
    ///Returns:
    ///    <b>S_OK</b> on success, or an unsuccessful <b>HRESULT</b> on failure. Possible unsuccessful <b>HRESULT</b>
    ///    values include values defined in the FhErrors.h header file.
    ///    
    HRESULT GetIncludeExcludeRules(BOOL Include, FH_PROTECTED_ITEM_CATEGORY Category, IFhScopeIterator* Iterator);
    ///Retrieves the numeric parameter for a local policy for the File History feature. > [!NOTE] > **IFhConfigMgr** is
    ///deprecated and may be altered or unavailable in future releases.
    ///Params:
    ///    LocalPolicyType = Specifies the local policy.
    ///    PolicyValue = Receives the value of the numeric parameter for the specified local policy.
    ///Returns:
    ///    <b>S_OK</b> on success, or an unsuccessful <b>HRESULT</b> value on failure. Possible unsuccessful
    ///    <b>HRESULT</b> values include values defined in the FhErrors.h header file.
    ///    
    HRESULT GetLocalPolicy(FH_LOCAL_POLICY_TYPE LocalPolicyType, ulong* PolicyValue);
    ///Changes the numeric parameter value of a local policy in an FhConfigMgr object. > [!NOTE] > **IFhConfigMgr** is
    ///deprecated and may be altered or unavailable in future releases.
    ///Params:
    ///    LocalPolicyType = Specifies the local policy.
    ///    PolicyValue = Specifies the new value of the numeric parameter for the specified local policy.
    ///Returns:
    ///    <b>S_OK</b> on success, or an unsuccessful <b>HRESULT</b> value on failure. Possible unsuccessful
    ///    <b>HRESULT</b> values include values defined in the FhErrors.h header file.
    ///    
    HRESULT SetLocalPolicy(FH_LOCAL_POLICY_TYPE LocalPolicyType, ulong PolicyValue);
    ///Retrieves the backup status value for an FhConfigMgr object. > [!NOTE] > **IFhConfigMgr** is deprecated and may
    ///be altered or unavailable in future releases.
    ///Params:
    ///    BackupStatus = Receives the backup status value. See the FH_BACKUP_STATUS enumeration for the list of possible backup status
    ///                   values.
    ///Returns:
    ///    <b>S_OK</b> on success, or an unsuccessful <b>HRESULT</b> value on failure. Possible unsuccessful
    ///    <b>HRESULT</b> values include values defined in the FhErrors.h header file.
    ///    
    HRESULT GetBackupStatus(FH_BACKUP_STATUS* BackupStatus);
    ///Changes the backup status value for an FhConfigMgr object. > [!NOTE] > **IFhConfigMgr** is deprecated and may be
    ///altered or unavailable in future releases.
    ///Params:
    ///    BackupStatus = The backup status value. See the FH_BACKUP_STATUS enumeration for a list of possible backup status values.
    ///Returns:
    ///    <b>S_OK</b> on success, or an unsuccessful <b>HRESULT</b> value on failure. Possible unsuccessful
    ///    <b>HRESULT</b> values include values defined in the FhErrors.h header file.
    ///    
    HRESULT SetBackupStatus(FH_BACKUP_STATUS BackupStatus);
    ///Returns a pointer to an IFhTarget interface that can be used to query information about the currently assigned
    ///backup target. > [!NOTE] > **IFhConfigMgr** is deprecated and may be altered or unavailable in future releases.
    ///Params:
    ///    DefaultTarget = Receives a pointer to the IFhTarget interface of an object that represents the currently assigned default
    ///                    target, or <b>NULL</b> if there is no default target.
    ///Returns:
    ///    <b>S_OK</b> on success, or an unsuccessful <b>HRESULT</b> value on failure. Possible unsuccessful
    ///    <b>HRESULT</b> values include values defined in the FhErrors.h header file.
    ///    
    HRESULT GetDefaultTarget(IFhTarget* DefaultTarget);
    ///Checks whether a certain storage device or network share can be used as a File History backup target. > [!NOTE] >
    ///**IFhConfigMgr** is deprecated and may be altered or unavailable in future releases.
    ///Params:
    ///    TargetUrl = The storage device or network share to be validated.
    ///    ValidationResult = Receives the result of the device validation. See the FH_DEVICE_VALIDATION_RESULT enumeration for the list of
    ///                       possible device validation result values.
    ///Returns:
    ///    <b>S_OK</b> on success, or an unsuccessful <b>HRESULT</b> value on failure. Possible unsuccessful
    ///    <b>HRESULT</b> values include values defined in the FhErrors.h header file.
    ///    
    HRESULT ValidateTarget(BSTR TargetUrl, FH_DEVICE_VALIDATION_RESULT* ValidationResult);
    ///Provisions a certain storage device or network share as a File History backup target and assigns it as the
    ///default backup target for the current user. > [!NOTE] > **IFhConfigMgr** is deprecated and may be altered or
    ///unavailable in future releases.
    ///Params:
    ///    TargetUrl = Specifies the storage device or network share to be provisioned and assigned as the default.
    ///    TargetName = Specifies a user-friendly name for the specified backup target.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code such as
    ///    one of the values defined in the FhErrors.h header file.
    ///    
    HRESULT ProvisionAndSetNewTarget(BSTR TargetUrl, BSTR TargetName);
    ///Causes the currently assigned backup target to be recommended or not recommended to other members of the home
    ///group that the computer belongs to. > [!NOTE] > **IFhConfigMgr** is deprecated and may be altered or unavailable
    ///in future releases.
    ///Params:
    ///    Recommend = If set to <b>TRUE</b>, the currently assigned backup target is recommended to other members of the home
    ///                group. If set to <b>FALSE</b> and the currently assigned backup target is currently recommended to other
    ///                members of the home group, this recommendation is withdrawn.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code such as
    ///    one of the values defined in the FhErrors.h header file.
    ///    
    HRESULT ChangeDefaultTargetRecommendation(BOOL Recommend);
    ///Retrieves the current File History protection state. > [!NOTE] > **IFhConfigMgr** is deprecated and may be
    ///altered or unavailable in future releases.
    ///Params:
    ///    ProtectionState = On return, this parameter receives the current File History protection state. The following protection states
    ///                      are defined in the FhStatus.h header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///                      width="40%"><a id="FH_STATE_NOT_TRACKED"></a><a id="fh_state_not_tracked"></a><dl>
    ///                      <dt><b>FH_STATE_NOT_TRACKED</b></dt> <dt>0x00</dt> </dl> </td> <td width="60%"> The File History protection
    ///                      state is unknown, because the File History service is not started or the current user is not tracked in it.
    ///                      This value cannot be ORed with <b>FH_STATE_RUNNING</b> (0x100). </td> </tr> <tr> <td width="40%"><a
    ///                      id="FH_STATE_OFF"></a><a id="fh_state_off"></a><dl> <dt><b>FH_STATE_OFF</b></dt> <dt>0x01</dt> </dl> </td>
    ///                      <td width="60%"> File History protection is not enabled for the current user. No files will be backed up.
    ///                      This value cannot be ORed with <b>FH_STATE_RUNNING</b> (0x100). </td> </tr> <tr> <td width="40%"><a
    ///                      id="FH_STATE_DISABLED_BY_GP"></a><a id="fh_state_disabled_by_gp"></a><dl>
    ///                      <dt><b>FH_STATE_DISABLED_BY_GP</b></dt> <dt>0x02</dt> </dl> </td> <td width="60%"> File History protection is
    ///                      disabled by Group Policy. No files will be backed up. This value cannot be ORed with <b>FH_STATE_RUNNING</b>
    ///                      (0x100). </td> </tr> <tr> <td width="40%"><a id="FH_STATE_FATAL_CONFIG_ERROR"></a><a
    ///                      id="fh_state_fatal_config_error"></a><dl> <dt><b>FH_STATE_FATAL_CONFIG_ERROR</b></dt> <dt>0x03</dt> </dl>
    ///                      </td> <td width="60%"> There is a fatal error in one of the files that store internal File History
    ///                      information for the current user. No files will be backed up. This value cannot be ORed with
    ///                      <b>FH_STATE_RUNNING</b> (0x100). </td> </tr> <tr> <td width="40%"><a
    ///                      id="FH_STATE_TARGET_ACCESS_DENIED"></a><a id="fh_state_target_access_denied"></a><dl>
    ///                      <dt><b>FH_STATE_TARGET_ACCESS_DENIED</b></dt> <dt>0x0E</dt> </dl> </td> <td width="60%"> The current user
    ///                      does not have write permission for the currently assigned target. Backup copies of file versions will not be
    ///                      created. This value can be ORed with <b>FH_STATE_RUNNING</b> (0x100) to indicate that a backup cycle is being
    ///                      performed for the current user right now. </td> </tr> <tr> <td width="40%"><a
    ///                      id="FH_STATE_TARGET_VOLUME_DIRTY"></a><a id="fh_state_target_volume_dirty"></a><dl>
    ///                      <dt><b>FH_STATE_TARGET_VOLUME_DIRTY</b></dt> <dt>0x0F</dt> </dl> </td> <td width="60%"> The currently
    ///                      assigned target has been marked as dirty. Backup copies of file versions will not be created until after the
    ///                      Chkdsk utility is run. This value can be ORed with <b>FH_STATE_RUNNING</b> (0x100) to indicate that a backup
    ///                      cycle is being performed for the current user right now. </td> </tr> <tr> <td width="40%"><a
    ///                      id="FH_STATE_TARGET_FULL_RETENTION_MAX"></a><a id="fh_state_target_full_retention_max"></a><dl>
    ///                      <dt><b>FH_STATE_TARGET_FULL_RETENTION_MAX</b></dt> <dt>0x10</dt> </dl> </td> <td width="60%"> The currently
    ///                      assigned target does not have sufficient space for storing backup copies of files from the File History
    ///                      protection scope, and retention is already set to the most aggressive policy. File History will provide a
    ///                      degraded level of protection. This value can be ORed with <b>FH_STATE_RUNNING</b> (0x100) to indicate that a
    ///                      backup cycle is being performed for the current user right now. </td> </tr> <tr> <td width="40%"><a
    ///                      id="FH_STATE_TARGET_FULL"></a><a id="fh_state_target_full"></a><dl> <dt><b>FH_STATE_TARGET_FULL</b></dt>
    ///                      <dt>0x11</dt> </dl> </td> <td width="60%"> The currently assigned target does not have sufficient space for
    ///                      storing backup copies of files from the File History protection scope. File History will provide a degraded
    ///                      level of protection. This value can be ORed with <b>FH_STATE_RUNNING</b> (0x100) to indicate that a backup
    ///                      cycle is being performed for the current user right now. </td> </tr> <tr> <td width="40%"><a
    ///                      id="FH_STATE_STAGING_FULL"></a><a id="fh_state_staging_full"></a><dl> <dt><b>FH_STATE_STAGING_FULL</b></dt>
    ///                      <dt>0x12</dt> </dl> </td> <td width="60%"> The File History cache on one of the local disks does not have
    ///                      sufficient space for storing backup copies of files from the File History protection scope temporarily. File
    ///                      History will provide a degraded level of protection. This value can be ORed with <b>FH_STATE_RUNNING</b>
    ///                      (0x100) to indicate that a backup cycle is being performed for the current user right now. </td> </tr> <tr>
    ///                      <td width="40%"><a id="FH_STATE_TARGET_LOW_SPACE_RETENTION_MAX"></a><a
    ///                      id="fh_state_target_low_space_retention_max"></a><dl> <dt><b>FH_STATE_TARGET_LOW_SPACE_RETENTION_MAX</b></dt>
    ///                      <dt>0x13</dt> </dl> </td> <td width="60%"> The currently assigned target is running low on free space, and
    ///                      retention is already set to the most aggressive policy. The level of File History protection is likely to
    ///                      degrade soon. This value can be ORed with <b>FH_STATE_RUNNING</b> (0x100) to indicate that a backup cycle is
    ///                      being performed for the current user right now. </td> </tr> <tr> <td width="40%"><a
    ///                      id="FH_STATE_TARGET_LOW_SPACE"></a><a id="fh_state_target_low_space"></a><dl>
    ///                      <dt><b>FH_STATE_TARGET_LOW_SPACE</b></dt> <dt>0x14</dt> </dl> </td> <td width="60%"> The currently assigned
    ///                      target is running low on free space. The level of File History protection is likely to degrade soon. This
    ///                      value can be ORed with <b>FH_STATE_RUNNING</b> (0x100) to indicate that a backup cycle is being performed for
    ///                      the current user right now. </td> </tr> <tr> <td width="40%"><a id="FH_STATE_TARGET_ABSENT"></a><a
    ///                      id="fh_state_target_absent"></a><dl> <dt><b>FH_STATE_TARGET_ABSENT</b></dt> <dt>0x15</dt> </dl> </td> <td
    ///                      width="60%"> The currently assigned target has not been available for backups for a substantial period of
    ///                      time, causing File History level of protection to start degrading. This value can be ORed with
    ///                      <b>FH_STATE_RUNNING</b> (0x100) to indicate that a backup cycle is being performed for the current user right
    ///                      now. </td> </tr> <tr> <td width="40%"><a id="FH_STATE_TOO_MUCH_BEHIND"></a><a
    ///                      id="fh_state_too_much_behind"></a><dl> <dt><b>FH_STATE_TOO_MUCH_BEHIND</b></dt> <dt>0x16</dt> </dl> </td> <td
    ///                      width="60%"> Too many changes have been made in the protected files or the protection scope. File History
    ///                      level of protection is likely to degrade, unless the user explicitly initiates an immediate backup instead of
    ///                      relying on regular backup cycles to be performed in the background. This value can be ORed with
    ///                      <b>FH_STATE_RUNNING</b> (0x100) to indicate that a backup cycle is being performed for the current user right
    ///                      now. </td> </tr> <tr> <td width="40%"><a id="FH_STATE_NO_ERROR"></a><a id="fh_state_no_error"></a><dl>
    ///                      <dt><b>FH_STATE_NO_ERROR</b></dt> <dt>0xFF</dt> </dl> </td> <td width="60%"> File History backups are
    ///                      performed regularly, no error conditions are detected, an optimal level of File History protection is
    ///                      provided. This value can be ORed with <b>FH_STATE_RUNNING</b> (0x100) to indicate that a backup cycle is
    ///                      being performed for the current user right now. </td> </tr> </table>
    ///    ProtectedUntilTime = Receives a pointer to a string allocated with SysAllocString containing the date and time until which all
    ///                         files within the File History protection scope are protected. The date and time are formatted per the system
    ///                         locale. If the date and time are unknown, an empty string is returned. A file is considered protected until a
    ///                         certain point in time if one of the following conditions is true:<ul> <li>There is a version of that file
    ///                         that was captured at or after that point in time and was fully copied to the currently assigned backup target
    ///                         before now.</li> <li>The file was created or included in the File History protection scope at or after that
    ///                         point in time.</li> </ul>
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code such as
    ///    one of the values defined in the FhErrors.h header file.
    ///    
    HRESULT QueryProtectionStatus(uint* ProtectionState, BSTR* ProtectedUntilTime);
}

///This interface allows client applications to reassociate a File History configuration from a File History target with
///the current user. Reassociation serves two purposes:<ul> <li>It allows the user to access the data that was backed up
///to the target in the past, possibly from a different computer or under a different account.</li> <li>It allows the
///user to continue to back up data to the target, possibly on a new computer or under a new account name.</li> </ul> >
///[!NOTE] > **IFhReassociation** is deprecated and may be altered or unavailable in future releases.
@GUID("6544A28A-F68D-47AC-91EF-16B2B36AA3EE")
interface IFhReassociation : IUnknown
{
    ///This method checks whether a certain storage device or network share can be used as a File History default target
    ///and, thus, whether reassociation is possible at all or not. > [!NOTE] > **IFhReassociation** is deprecated and
    ///may be altered or unavailable in future releases.
    ///Params:
    ///    TargetUrl = Specifies the storage device or network share to be validated.
    ///    ValidationResult = On return, contains a value specifying the result of the device validation. See the
    ///                       FH_DEVICE_VALIDATION_RESULT enumeration for a detailed description of supported device validation results.
    ///Returns:
    ///    <b>S_OK</b> on success, or an unsuccessful <b>HRESULT</b> value on failure. Possible unsuccessful
    ///    <b>HRESULT</b> values include values defined in the FhErrors.h header file.
    ///    
    HRESULT ValidateTarget(BSTR TargetUrl, FH_DEVICE_VALIDATION_RESULT* ValidationResult);
    ///Scans the namespace on a specified storage device or network share for File History configurations that can be
    ///reassociated with and continued to be used on the current computer. > [!NOTE] > **IFhReassociation** is
    ///deprecated and may be altered or unavailable in future releases.
    ///Params:
    ///    TargetUrl = Specifies the storage device or network share to be scanned.
    ///Returns:
    ///    <b>S_OK</b> on success, or an unsuccessful <b>HRESULT</b> on failure. Possible unsuccessful <b>HRESULT</b>
    ///    values include values defined in the FhErrors.h header file. If no File History configurations were found on
    ///    the specified storage device or network share, the <code>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</code> error
    ///    code is returned.
    ///    
    HRESULT ScanTargetForConfigurations(BSTR TargetUrl);
    ///This method enumerates File History configurations that were discovered on a storage device or network share by
    ///the IFhReassociation::ScanTargetForConfigurations method and returns additional information about each of the
    ///discovered configurations. > [!NOTE] > **IFhReassociation** is deprecated and may be altered or unavailable in
    ///future releases.
    ///Params:
    ///    Index = Zero-based index of a discovered configuration.
    ///    UserName = On return, contains a pointer to a string allocated with SysAllocString containing the name of the user
    ///               account under which the configuration was last backed up to.
    ///    PcName = On return, contains a pointer to a string allocated with SysAllocString containing the name of the computer
    ///             from which the configuration was last backed up.
    ///    BackupTime = On return, contains the date and time when the configuration was last backed up.
    ///Returns:
    ///    <b>S_OK</b> on success, or an unsuccessful <b>HRESULT</b> on failure. Possible unsuccessful <b>HRESULT</b>
    ///    values include values defined in the FhErrors.h header file. If there is no File History configuration with
    ///    the specified index, the <code>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</code> error code is returned.
    ///    
    HRESULT GetConfigurationDetails(uint Index, BSTR* UserName, BSTR* PcName, FILETIME* BackupTime);
    ///Selects one of the File History configurations discovered on a storage device or network share by the
    ///IFhReassociation::ScanTargetForConfigurations method for subsequent reassociation. Actual reassociation is
    ///performed by the IFhReassociation::PerformReassociation method. > [!NOTE] > **IFhReassociation** is deprecated
    ///and may be altered or unavailable in future releases.
    ///Params:
    ///    Index = Zero-based index of a discovered configuration.
    ///Returns:
    ///    <b>S_OK</b> on success, or an unsuccessful <b>HRESULT</b> value on failure. Possible unsuccessful
    ///    <b>HRESULT</b> values include values defined in the FhErrors.h header file. If there is no File History
    ///    configuration with the specified index, the <code>HRESULT_FROM_WIN32(ERROR_NOT_FOUND)</code> error code is
    ///    returned.
    ///    
    HRESULT SelectConfiguration(uint Index);
    ///This method re-establishes relationship between the current user and the configuration selected previously via
    ///the IFhReassociation::SelectConfiguration method and prepares the target device for accepting backup data from
    ///the current computer. > [!NOTE] > **IFhReassociation** is deprecated and may be altered or unavailable in future
    ///releases.
    ///Params:
    ///    OverwriteIfExists = This parameter specifies how to handle the current File History configuration, if it already exists. If this
    ///                        parameter is set to <b>FALSE</b> and File History is already configured for the current user, this method
    ///                        fails with the <b>FHCFG_E_CONFIG_ALREADY_EXISTS</b> error code and backups continue to be performed to the
    ///                        already configured target device. If this parameter is set to <b>TRUE</b> and File History is already
    ///                        configured for the current user, the current configuration is replaced with the selected one and future
    ///                        backups after performed to the target device containing the selected configuration.
    ///Returns:
    ///    <b>S_OK</b> on success, or an unsuccessful <b>HRESULT</b> value on failure. Possible unsuccessful
    ///    <b>HRESULT</b> values include values defined in the FhErrors.h header file.
    ///    
    HRESULT PerformReassociation(BOOL OverwriteIfExists);
}

///Gets the OS update assessment by comparing the latest build from Microsoft against the build running on the current
///device.
@GUID("2347BBEF-1A3B-45A4-902D-3E09C269B45E")
interface IWaaSAssessor : IUnknown
{
    ///Gets the OS update assessment by comparing the latest release OS version from Microsoft to the OS build running
    ///on the device.
    ///Params:
    ///    result = On success, contains a pointer to the OS update assessment.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful. Otherwise, returns a COM or Windows error code.
    ///    
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
    ///Gets the handle of the Windows Internet Explorer main window. This property is read-only.
    HRESULT get_HWND(ptrdiff_t* pHWND);
    HRESULT get_FullName(BSTR* FullName);
    HRESULT get_Path(BSTR* Path);
    HRESULT get_Visible(short* pBool);
    HRESULT put_Visible(short Value);
    HRESULT get_StatusBar(short* pBool);
    HRESULT put_StatusBar(short Value);
    HRESULT get_StatusText(BSTR* StatusText);
    HRESULT put_StatusText(BSTR StatusText);
    ///Sets or gets whether toolbars for the object are visible. This property is read/write.
    HRESULT get_ToolBar(int* Value);
    ///Sets or gets whether toolbars for the object are visible. This property is read/write.
    HRESULT put_ToolBar(int Value);
    HRESULT get_MenuBar(short* Value);
    HRESULT put_MenuBar(short Value);
    HRESULT get_FullScreen(short* pbFullScreen);
    HRESULT put_FullScreen(short bFullScreen);
}

///Exposes methods that are implemented by the WebBrowser control (Microsoft ActiveX control) or implemented by an
///instance of the InternetExplorer application (OLE Automation). For the Microsoft .NET Framework version of this
///control, see WebBrowser Control (Windows Forms). <div class="alert"><b>Important</b> <p class="note">The
///documentation in this section is a partial listing of IWebBrowswer2 interface members. The complete IWebBrowser2
///interface is documented in the MSHTML Reference content. </div><div> </div>
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
    ///Sets or gets whether the object is in theater mode. This property is read/write.
    HRESULT get_TheaterMode(short* pbRegister);
    ///Sets or gets whether the object is in theater mode. This property is read/write.
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

///Enables apps to determine whether they are running in a Windows Defender Application Guard container (VM container
///environment).
@GUID("F686878F-7B42-4CC4-96FB-F4F3B6E3D24D")
interface IIsolatedAppLauncher : IUnknown
{
    HRESULT Launch(const(wchar)* appUserModelId, const(wchar)* arguments, 
                   const(IsolatedAppLauncherTelemetryParameters)* telemetryParameters);
}

///Provides methods for getting product information for an individual provider to interact with Windows Security Center.
@GUID("8C38232E-3A45-4A27-92B0-1A16A975F669")
interface IWscProduct : IDispatch
{
    ///Returns the current product information for the security product.
    ///Params:
    ///    pVal = A pointer to the name of the security product. This is displayed in the Windows Security Center user
    ///           interface.
    ///Returns:
    ///    If the method succeeds, returns S_OK. If the method fails, returns a Win32 error code.
    ///    
    HRESULT get_ProductName(BSTR* pVal);
    ///Returns the current state of the signature data for the security product.
    ///Params:
    ///    pVal = A pointer to the state value of the signature of the security product.
    ///Returns:
    ///    If the method succeeds, returns S_OK. If the method fails, returns a Win32 error code.
    ///    
    HRESULT get_ProductState(WSC_SECURITY_PRODUCT_STATE* pVal);
    ///Returns the current status of the signature data for the security product.
    ///Params:
    ///    pVal = A pointer to the status value of the signature of the security product. If the security product is a Firewall
    ///           product, the return value is always <b>WSC_SECURITY_PRODUCT_UP_TO_DATE</b> because firewalls do not contain
    ///           signature data.
    ///Returns:
    ///    If the method succeeds, returns S_OK. If the method fails, returns a Win32 error code.
    ///    
    HRESULT get_SignatureStatus(WSC_SECURITY_SIGNATURE_STATUS* pVal);
    ///Returns the current remediation path for the security product.
    ///Params:
    ///    pVal = A pointer to the remediation path for the security product. This is displayed in the Windows Security Center
    ///           user interface.
    ///Returns:
    ///    If the method succeeds, returns S_OK. If the method fails, returns a Win32 error code.
    ///    
    HRESULT get_RemediationPath(BSTR* pVal);
    ///Returns the current time stamp for the security product.
    ///Params:
    ///    pVal = A pointer to the time stamp of the security product. This is displayed in the Windows Security Center user
    ///           interface.
    ///Returns:
    ///    If the method succeeds, returns S_OK. If the method fails, returns a Win32 error code.
    ///    
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

///Provides methods to collect product information for the selected type of providers installed on the computer.
@GUID("722A338C-6E8E-4E72-AC27-1417FB0C81C2")
interface IWSCProductList : IDispatch
{
    ///Gathers information on all of the providers of the specified type on the computer.
    ///Params:
    ///    provider = A value from the WSC_SECURITY_PROVIDER enumeration with the name of the provider as one of the following
    ///               values. Note that the possible values can't be combined in a logical OR as they can when used with the
    ///               WscGetSecurityProviderHealth function. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///               width="40%"><a id="WSC_SECURITY_PROVIDER_ANTIVIRUS"></a><a id="wsc_security_provider_antivirus"></a><dl>
    ///               <dt><b>WSC_SECURITY_PROVIDER_ANTIVIRUS</b></dt> </dl> </td> <td width="60%"> Antivirus products. </td> </tr>
    ///               <tr> <td width="40%"><a id="WSC_SECURITY_PROVIDER_ANTISPYWARE"></a><a
    ///               id="wsc_security_provider_antispyware"></a><dl> <dt><b>WSC_SECURITY_PROVIDER_ANTISPYWARE</b></dt> </dl> </td>
    ///               <td width="60%"> Anti-spyware products. </td> </tr> <tr> <td width="40%"><a
    ///               id="WSC_SECURITY_PROVIDER_FIREWALL"></a><a id="wsc_security_provider_firewall"></a><dl>
    ///               <dt><b>WSC_SECURITY_PROVIDER_FIREWALL</b></dt> </dl> </td> <td width="60%"> Firewall products. </td> </tr>
    ///               </table>
    ///Returns:
    ///    If the method succeeds, returns S_OK. If the method fails, returns a Win32 error code.
    ///    
    HRESULT Initialize(uint provider);
    ///Gathers the total number of all security product providers of the specified type on the computer.
    ///Params:
    ///    pVal = A pointer to the number of providers in the list of security products on the computer.
    ///Returns:
    ///    If the method succeeds, returns S_OK. If the method fails, returns a Win32 error code.
    ///    
    HRESULT get_Count(int* pVal);
    ///Returns one of the types of providers on the computer.
    ///Params:
    ///    index = The list of the providers.
    ///    pVal = A pointer to the IWscProduct product information.
    ///Returns:
    ///    If the method succeeds, returns S_OK. If the method fails, returns a Win32 error code.
    ///    
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
