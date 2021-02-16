module windows.systemservices;

public import windows.core;
public import windows.automation : BSTR, VARIANT;
public import windows.com : BYTE_BLOB, DWORD_BLOB, FLAGGED_BYTE_BLOB, HRESULT, IUnknown;
public import windows.coreaudio : DDVIDEOPORTCONNECT;
public import windows.dbg : IMAGE_DATA_DIRECTORY, IMAGE_FILE_HEADER, WOW64_LDT_ENTRY;
public import windows.direct3d9 : D3DMATRIX;
public import windows.directdraw : DDPIXELFORMAT, DDSCAPS, DDSURFACEDESC;
public import windows.directshow : DDCOLORKEY;
public import windows.displaydevices : BLENDOBJ, BRUSHOBJ, CLIPOBJ, DDVIDEOPORTCAPS, DD_BLTDATA, DD_CALLBACKS,
                                       DD_DIRECTDRAW_GLOBAL, DD_DIRECTDRAW_LOCAL, DD_HALINFO, DD_PALETTECALLBACKS,
                                       DD_SURFACECALLBACKS, DD_SURFACE_LOCAL, DEVINFO, DEVMODEW, DRIVEROBJ,
                                       DRVENABLEDATA, FONTOBJ, GDIINFO, GLYPHDATA, IFIMETRICS, LINEATTRS, PALOBJ,
                                       PATHOBJ, PDD_GETDRIVERINFO, PERBANDINFO, POINT, POINTL, RECT, RECTL, SIZE,
                                       STROBJ, SURFOBJ, VIDEOMEMORY, VIDEOMEMORYINFO, WNDOBJ, XLATEOBJ;
public import windows.dxgi : DXGI_RGBA;
public import windows.filesystem : FILE_ID_128, LPOVERLAPPED_COMPLETION_ROUTINE, PARTITION_INFORMATION_GPT,
                                   PARTITION_STYLE, RETRIEVAL_POINTERS_BUFFER, SET_PARTITION_INFORMATION,
                                   STORAGE_PROPERTY_ID, STORAGE_PROTOCOL_TYPE, USN_RECORD_COMMON_HEADER,
                                   USN_RECORD_V2, USN_RECORD_V3, USN_RECORD_V4;
public import windows.gdi : COLORADJUSTMENT, DESIGNVECTOR, HBITMAP, HDC, LOGPALETTE, TRIVERTEX, TTPOLYGONHEADER;
public import windows.kernel : EXCEPTION_ROUTINE, LIST_ENTRY, LUID, SINGLE_LIST_ENTRY;
public import windows.menusandresources : ENUMRESNAMEPROCW;
public import windows.opengl : PIXELFORMATDESCRIPTOR;
public import windows.rpc : RPC_BINDING_VECTOR, RPC_MESSAGE;
public import windows.security : ACE_HEADER, GENERIC_MAPPING, OBJECT_TYPE_LIST, PRIVILEGE_SET,
                                 PROCESS_INFORMATION_CLASS, SECURITY_IMPERSONATION_LEVEL, SID, SID_AND_ATTRIBUTES,
                                 TOKEN_GROUPS, TOKEN_PRIVILEGES, TOKEN_USER, UNICODE_STRING;
public import windows.virtualstorage : VIRTUAL_STORAGE_TYPE;
public import windows.windowsandmessaging : HWND, LPARAM;
public import windows.windowscolorsystem : LOGCOLORSPACEW;
public import windows.windowsprogramming : DEP_SYSTEM_POLICY_TYPE, EventLogHandle, EventSourceHandle, FILETIME, HKEY,
                                           HeapHandle, IXMLDOMDocument, LPFIBER_START_ROUTINE, OSVERSIONINFOEXW,
                                           PPS_POST_PROCESS_INIT_ROUTINE, PROCESSINFOCLASS, PROCESS_CREATION_FLAGS,
                                           PUMS_SCHEDULER_ENTRY_POINT, SYSTEMTIME, THREADINFOCLASS,
                                           THREAD_INFORMATION_CLASS;
public import windows.xps : DEVMODEA;

extern(Windows):


// Enums


enum : int
{
    AccessReasonNone                     = 0x00000000,
    AccessReasonAllowedAce               = 0x00010000,
    AccessReasonDeniedAce                = 0x00020000,
    AccessReasonAllowedParentAce         = 0x00030000,
    AccessReasonDeniedParentAce          = 0x00040000,
    AccessReasonNotGrantedByCape         = 0x00050000,
    AccessReasonNotGrantedByParentCape   = 0x00060000,
    AccessReasonNotGrantedToAppContainer = 0x00070000,
    AccessReasonMissingPrivilege         = 0x00100000,
    AccessReasonFromPrivilege            = 0x00200000,
    AccessReasonIntegrityLevel           = 0x00300000,
    AccessReasonOwnership                = 0x00400000,
    AccessReasonNullDacl                 = 0x00500000,
    AccessReasonEmptyDacl                = 0x00600000,
    AccessReasonNoSD                     = 0x00700000,
    AccessReasonNoGrant                  = 0x00800000,
    AccessReasonTrustLabel               = 0x00900000,
    AccessReasonFilterAce                = 0x00a00000,
}
alias ACCESS_REASON_TYPE = int;

enum : int
{
    SeImageSignatureNone             = 0x00000000,
    SeImageSignatureEmbedded         = 0x00000001,
    SeImageSignatureCache            = 0x00000002,
    SeImageSignatureCatalogCached    = 0x00000003,
    SeImageSignatureCatalogNotCached = 0x00000004,
    SeImageSignatureCatalogHint      = 0x00000005,
    SeImageSignaturePackageCatalog   = 0x00000006,
}
alias SE_IMAGE_SIGNATURE_TYPE = int;

enum : int
{
    SeLearningModeInvalidType = 0x00000000,
    SeLearningModeSettings    = 0x00000001,
    SeLearningModeMax         = 0x00000002,
}
alias SE_LEARNING_MODE_DATA_TYPE = int;

enum : int
{
    ProcessDEPPolicy                   = 0x00000000,
    ProcessASLRPolicy                  = 0x00000001,
    ProcessDynamicCodePolicy           = 0x00000002,
    ProcessStrictHandleCheckPolicy     = 0x00000003,
    ProcessSystemCallDisablePolicy     = 0x00000004,
    ProcessMitigationOptionsMask       = 0x00000005,
    ProcessExtensionPointDisablePolicy = 0x00000006,
    ProcessControlFlowGuardPolicy      = 0x00000007,
    ProcessSignaturePolicy             = 0x00000008,
    ProcessFontDisablePolicy           = 0x00000009,
    ProcessImageLoadPolicy             = 0x0000000a,
    ProcessSystemCallFilterPolicy      = 0x0000000b,
    ProcessPayloadRestrictionPolicy    = 0x0000000c,
    ProcessChildProcessPolicy          = 0x0000000d,
    ProcessSideChannelIsolationPolicy  = 0x0000000e,
    ProcessUserShadowStackPolicy       = 0x0000000f,
    MaxProcessMitigationPolicy         = 0x00000010,
}
alias PROCESS_MITIGATION_POLICY = int;

enum : int
{
    ToleranceLow    = 0x00000001,
    ToleranceMedium = 0x00000002,
    ToleranceHigh   = 0x00000003,
}
alias JOBOBJECT_RATE_CONTROL_TOLERANCE = int;

enum : int
{
    ToleranceIntervalShort  = 0x00000001,
    ToleranceIntervalMedium = 0x00000002,
    ToleranceIntervalLong   = 0x00000003,
}
alias JOBOBJECT_RATE_CONTROL_TOLERANCE_INTERVAL = int;

enum : int
{
    JOB_OBJECT_NET_RATE_CONTROL_ENABLE        = 0x00000001,
    JOB_OBJECT_NET_RATE_CONTROL_MAX_BANDWIDTH = 0x00000002,
    JOB_OBJECT_NET_RATE_CONTROL_DSCP_TAG      = 0x00000004,
    JOB_OBJECT_NET_RATE_CONTROL_VALID_FLAGS   = 0x00000007,
}
alias JOB_OBJECT_NET_RATE_CONTROL_FLAGS = int;

enum : int
{
    JOB_OBJECT_IO_RATE_CONTROL_ENABLE                        = 0x00000001,
    JOB_OBJECT_IO_RATE_CONTROL_STANDALONE_VOLUME             = 0x00000002,
    JOB_OBJECT_IO_RATE_CONTROL_FORCE_UNIT_ACCESS_ALL         = 0x00000004,
    JOB_OBJECT_IO_RATE_CONTROL_FORCE_UNIT_ACCESS_ON_SOFT_CAP = 0x00000008,
    JOB_OBJECT_IO_RATE_CONTROL_VALID_FLAGS                   = 0x0000000f,
}
alias JOB_OBJECT_IO_RATE_CONTROL_FLAGS = int;

enum : int
{
    JOBOBJECT_IO_ATTRIBUTION_CONTROL_ENABLE      = 0x00000001,
    JOBOBJECT_IO_ATTRIBUTION_CONTROL_DISABLE     = 0x00000002,
    JOBOBJECT_IO_ATTRIBUTION_CONTROL_VALID_FLAGS = 0x00000003,
}
alias JOBOBJECT_IO_ATTRIBUTION_CONTROL_FLAGS = int;

enum : int
{
    JobObjectBasicAccountingInformation         = 0x00000001,
    JobObjectBasicLimitInformation              = 0x00000002,
    JobObjectBasicProcessIdList                 = 0x00000003,
    JobObjectBasicUIRestrictions                = 0x00000004,
    JobObjectSecurityLimitInformation           = 0x00000005,
    JobObjectEndOfJobTimeInformation            = 0x00000006,
    JobObjectAssociateCompletionPortInformation = 0x00000007,
    JobObjectBasicAndIoAccountingInformation    = 0x00000008,
    JobObjectExtendedLimitInformation           = 0x00000009,
    JobObjectJobSetInformation                  = 0x0000000a,
    JobObjectGroupInformation                   = 0x0000000b,
    JobObjectNotificationLimitInformation       = 0x0000000c,
    JobObjectLimitViolationInformation          = 0x0000000d,
    JobObjectGroupInformationEx                 = 0x0000000e,
    JobObjectCpuRateControlInformation          = 0x0000000f,
    JobObjectCompletionFilter                   = 0x00000010,
    JobObjectCompletionCounter                  = 0x00000011,
    JobObjectReserved1Information               = 0x00000012,
    JobObjectReserved2Information               = 0x00000013,
    JobObjectReserved3Information               = 0x00000014,
    JobObjectReserved4Information               = 0x00000015,
    JobObjectReserved5Information               = 0x00000016,
    JobObjectReserved6Information               = 0x00000017,
    JobObjectReserved7Information               = 0x00000018,
    JobObjectReserved8Information               = 0x00000019,
    JobObjectReserved9Information               = 0x0000001a,
    JobObjectReserved10Information              = 0x0000001b,
    JobObjectReserved11Information              = 0x0000001c,
    JobObjectReserved12Information              = 0x0000001d,
    JobObjectReserved13Information              = 0x0000001e,
    JobObjectReserved14Information              = 0x0000001f,
    JobObjectNetRateControlInformation          = 0x00000020,
    JobObjectNotificationLimitInformation2      = 0x00000021,
    JobObjectLimitViolationInformation2         = 0x00000022,
    JobObjectCreateSilo                         = 0x00000023,
    JobObjectSiloBasicInformation               = 0x00000024,
    JobObjectReserved15Information              = 0x00000025,
    JobObjectReserved16Information              = 0x00000026,
    JobObjectReserved17Information              = 0x00000027,
    JobObjectReserved18Information              = 0x00000028,
    JobObjectReserved19Information              = 0x00000029,
    JobObjectReserved20Information              = 0x0000002a,
    JobObjectReserved21Information              = 0x0000002b,
    JobObjectReserved22Information              = 0x0000002c,
    JobObjectReserved23Information              = 0x0000002d,
    JobObjectReserved24Information              = 0x0000002e,
    JobObjectReserved25Information              = 0x0000002f,
    MaxJobObjectInfoClass                       = 0x00000030,
}
alias JOBOBJECTINFOCLASS = int;

enum : int
{
    SERVERSILO_INITING       = 0x00000000,
    SERVERSILO_STARTED       = 0x00000001,
    SERVERSILO_SHUTTING_DOWN = 0x00000002,
    SERVERSILO_TERMINATING   = 0x00000003,
    SERVERSILO_TERMINATED    = 0x00000004,
}
alias SERVERSILO_STATE = int;

enum : int
{
    RelationProcessorCore    = 0x00000000,
    RelationNumaNode         = 0x00000001,
    RelationCache            = 0x00000002,
    RelationProcessorPackage = 0x00000003,
    RelationGroup            = 0x00000004,
    RelationAll              = 0x0000ffff,
}
alias LOGICAL_PROCESSOR_RELATIONSHIP = int;

enum : int
{
    CacheUnified     = 0x00000000,
    CacheInstruction = 0x00000001,
    CacheData        = 0x00000002,
    CacheTrace       = 0x00000003,
}
alias PROCESSOR_CACHE_TYPE = int;

enum : int
{
    CpuSetInformation = 0x00000000,
}
alias CPU_SET_INFORMATION_TYPE = int;

enum : int
{
    MemExtendedParameterInvalidType         = 0x00000000,
    MemExtendedParameterAddressRequirements = 0x00000001,
    MemExtendedParameterNumaNode            = 0x00000002,
    MemExtendedParameterPartitionHandle     = 0x00000003,
    MemExtendedParameterUserPhysicalHandle  = 0x00000004,
    MemExtendedParameterAttributeFlags      = 0x00000005,
    MemExtendedParameterMax                 = 0x00000006,
}
alias MEM_EXTENDED_PARAMETER_TYPE = int;

enum : int
{
    MemSectionExtendedParameterInvalidType       = 0x00000000,
    MemSectionExtendedParameterUserPhysicalFlags = 0x00000001,
    MemSectionExtendedParameterNumaNode          = 0x00000002,
    MemSectionExtendedParameterMax               = 0x00000003,
}
alias MEM_SECTION_EXTENDED_PARAMETER_TYPE = int;

enum SharedVirtualDiskSupportType : int
{
    SharedVirtualDisksUnsupported          = 0x00000000,
    SharedVirtualDisksSupported            = 0x00000001,
    SharedVirtualDiskSnapshotsSupported    = 0x00000003,
    SharedVirtualDiskCDPSnapshotsSupported = 0x00000007,
}

enum SharedVirtualDiskHandleState : int
{
    SharedVirtualDiskHandleStateNone         = 0x00000000,
    SharedVirtualDiskHandleStateFileShared   = 0x00000001,
    SharedVirtualDiskHandleStateHandleShared = 0x00000003,
}

enum : int
{
    PowerSystemUnspecified = 0x00000000,
    PowerSystemWorking     = 0x00000001,
    PowerSystemSleeping1   = 0x00000002,
    PowerSystemSleeping2   = 0x00000003,
    PowerSystemSleeping3   = 0x00000004,
    PowerSystemHibernate   = 0x00000005,
    PowerSystemShutdown    = 0x00000006,
    PowerSystemMaximum     = 0x00000007,
}
alias SYSTEM_POWER_STATE = int;

enum : int
{
    PowerActionNone          = 0x00000000,
    PowerActionReserved      = 0x00000001,
    PowerActionSleep         = 0x00000002,
    PowerActionHibernate     = 0x00000003,
    PowerActionShutdown      = 0x00000004,
    PowerActionShutdownReset = 0x00000005,
    PowerActionShutdownOff   = 0x00000006,
    PowerActionWarmEject     = 0x00000007,
    PowerActionDisplayOff    = 0x00000008,
}
alias POWER_ACTION = int;

enum : int
{
    PowerDeviceUnspecified = 0x00000000,
    PowerDeviceD0          = 0x00000001,
    PowerDeviceD1          = 0x00000002,
    PowerDeviceD2          = 0x00000003,
    PowerDeviceD3          = 0x00000004,
    PowerDeviceMaximum     = 0x00000005,
}
alias DEVICE_POWER_STATE = int;

enum : int
{
    PowerMonitorOff = 0x00000000,
    PowerMonitorOn  = 0x00000001,
    PowerMonitorDim = 0x00000002,
}
alias MONITOR_DISPLAY_STATE = int;

enum : int
{
    PowerUserPresent    = 0x00000000,
    PowerUserNotPresent = 0x00000001,
    PowerUserInactive   = 0x00000002,
    PowerUserMaximum    = 0x00000003,
    PowerUserInvalid    = 0x00000003,
}
alias USER_ACTIVITY_PRESENCE = int;

enum : int
{
    LT_DONT_CARE      = 0x00000000,
    LT_LOWEST_LATENCY = 0x00000001,
}
alias LATENCY_TIME = int;

enum : int
{
    PowerRequestDisplayRequired   = 0x00000000,
    PowerRequestSystemRequired    = 0x00000001,
    PowerRequestAwayModeRequired  = 0x00000002,
    PowerRequestExecutionRequired = 0x00000003,
}
alias POWER_REQUEST_TYPE = int;

enum : int
{
    SystemPowerPolicyAc                = 0x00000000,
    SystemPowerPolicyDc                = 0x00000001,
    VerifySystemPolicyAc               = 0x00000002,
    VerifySystemPolicyDc               = 0x00000003,
    SystemPowerCapabilities            = 0x00000004,
    SystemBatteryState                 = 0x00000005,
    SystemPowerStateHandler            = 0x00000006,
    ProcessorStateHandler              = 0x00000007,
    SystemPowerPolicyCurrent           = 0x00000008,
    AdministratorPowerPolicy           = 0x00000009,
    SystemReserveHiberFile             = 0x0000000a,
    ProcessorInformation               = 0x0000000b,
    SystemPowerInformation             = 0x0000000c,
    ProcessorStateHandler2             = 0x0000000d,
    LastWakeTime                       = 0x0000000e,
    LastSleepTime                      = 0x0000000f,
    SystemExecutionState               = 0x00000010,
    SystemPowerStateNotifyHandler      = 0x00000011,
    ProcessorPowerPolicyAc             = 0x00000012,
    ProcessorPowerPolicyDc             = 0x00000013,
    VerifyProcessorPowerPolicyAc       = 0x00000014,
    VerifyProcessorPowerPolicyDc       = 0x00000015,
    ProcessorPowerPolicyCurrent        = 0x00000016,
    SystemPowerStateLogging            = 0x00000017,
    SystemPowerLoggingEntry            = 0x00000018,
    SetPowerSettingValue               = 0x00000019,
    NotifyUserPowerSetting             = 0x0000001a,
    PowerInformationLevelUnused0       = 0x0000001b,
    SystemMonitorHiberBootPowerOff     = 0x0000001c,
    SystemVideoState                   = 0x0000001d,
    TraceApplicationPowerMessage       = 0x0000001e,
    TraceApplicationPowerMessageEnd    = 0x0000001f,
    ProcessorPerfStates                = 0x00000020,
    ProcessorIdleStates                = 0x00000021,
    ProcessorCap                       = 0x00000022,
    SystemWakeSource                   = 0x00000023,
    SystemHiberFileInformation         = 0x00000024,
    TraceServicePowerMessage           = 0x00000025,
    ProcessorLoad                      = 0x00000026,
    PowerShutdownNotification          = 0x00000027,
    MonitorCapabilities                = 0x00000028,
    SessionPowerInit                   = 0x00000029,
    SessionDisplayState                = 0x0000002a,
    PowerRequestCreate                 = 0x0000002b,
    PowerRequestAction                 = 0x0000002c,
    GetPowerRequestList                = 0x0000002d,
    ProcessorInformationEx             = 0x0000002e,
    NotifyUserModeLegacyPowerEvent     = 0x0000002f,
    GroupPark                          = 0x00000030,
    ProcessorIdleDomains               = 0x00000031,
    WakeTimerList                      = 0x00000032,
    SystemHiberFileSize                = 0x00000033,
    ProcessorIdleStatesHv              = 0x00000034,
    ProcessorPerfStatesHv              = 0x00000035,
    ProcessorPerfCapHv                 = 0x00000036,
    ProcessorSetIdle                   = 0x00000037,
    LogicalProcessorIdling             = 0x00000038,
    UserPresence                       = 0x00000039,
    PowerSettingNotificationName       = 0x0000003a,
    GetPowerSettingValue               = 0x0000003b,
    IdleResiliency                     = 0x0000003c,
    SessionRITState                    = 0x0000003d,
    SessionConnectNotification         = 0x0000003e,
    SessionPowerCleanup                = 0x0000003f,
    SessionLockState                   = 0x00000040,
    SystemHiberbootState               = 0x00000041,
    PlatformInformation                = 0x00000042,
    PdcInvocation                      = 0x00000043,
    MonitorInvocation                  = 0x00000044,
    FirmwareTableInformationRegistered = 0x00000045,
    SetShutdownSelectedTime            = 0x00000046,
    SuspendResumeInvocation            = 0x00000047,
    PlmPowerRequestCreate              = 0x00000048,
    ScreenOff                          = 0x00000049,
    CsDeviceNotification               = 0x0000004a,
    PlatformRole                       = 0x0000004b,
    LastResumePerformance              = 0x0000004c,
    DisplayBurst                       = 0x0000004d,
    ExitLatencySamplingPercentage      = 0x0000004e,
    RegisterSpmPowerSettings           = 0x0000004f,
    PlatformIdleStates                 = 0x00000050,
    ProcessorIdleVeto                  = 0x00000051,
    PlatformIdleVeto                   = 0x00000052,
    SystemBatteryStatePrecise          = 0x00000053,
    ThermalEvent                       = 0x00000054,
    PowerRequestActionInternal         = 0x00000055,
    BatteryDeviceState                 = 0x00000056,
    PowerInformationInternal           = 0x00000057,
    ThermalStandby                     = 0x00000058,
    SystemHiberFileType                = 0x00000059,
    PhysicalPowerButtonPress           = 0x0000005a,
    QueryPotentialDripsConstraint      = 0x0000005b,
    EnergyTrackerCreate                = 0x0000005c,
    EnergyTrackerQuery                 = 0x0000005d,
    UpdateBlackBoxRecorder             = 0x0000005e,
    SessionAllowExternalDmaDevices     = 0x0000005f,
    PowerInformationLevelMaximum       = 0x00000060,
}
alias POWER_INFORMATION_LEVEL = int;

enum : int
{
    UserNotPresent = 0x00000000,
    UserPresent    = 0x00000001,
    UserUnknown    = 0x000000ff,
}
alias POWER_USER_PRESENCE_TYPE = int;

enum : int
{
    MonitorRequestReasonUnknown                        = 0x00000000,
    MonitorRequestReasonPowerButton                    = 0x00000001,
    MonitorRequestReasonRemoteConnection               = 0x00000002,
    MonitorRequestReasonScMonitorpower                 = 0x00000003,
    MonitorRequestReasonUserInput                      = 0x00000004,
    MonitorRequestReasonAcDcDisplayBurst               = 0x00000005,
    MonitorRequestReasonUserDisplayBurst               = 0x00000006,
    MonitorRequestReasonPoSetSystemState               = 0x00000007,
    MonitorRequestReasonSetThreadExecutionState        = 0x00000008,
    MonitorRequestReasonFullWake                       = 0x00000009,
    MonitorRequestReasonSessionUnlock                  = 0x0000000a,
    MonitorRequestReasonScreenOffRequest               = 0x0000000b,
    MonitorRequestReasonIdleTimeout                    = 0x0000000c,
    MonitorRequestReasonPolicyChange                   = 0x0000000d,
    MonitorRequestReasonSleepButton                    = 0x0000000e,
    MonitorRequestReasonLid                            = 0x0000000f,
    MonitorRequestReasonBatteryCountChange             = 0x00000010,
    MonitorRequestReasonGracePeriod                    = 0x00000011,
    MonitorRequestReasonPnP                            = 0x00000012,
    MonitorRequestReasonDP                             = 0x00000013,
    MonitorRequestReasonSxTransition                   = 0x00000014,
    MonitorRequestReasonSystemIdle                     = 0x00000015,
    MonitorRequestReasonNearProximity                  = 0x00000016,
    MonitorRequestReasonThermalStandby                 = 0x00000017,
    MonitorRequestReasonResumePdc                      = 0x00000018,
    MonitorRequestReasonResumeS4                       = 0x00000019,
    MonitorRequestReasonTerminal                       = 0x0000001a,
    MonitorRequestReasonPdcSignal                      = 0x0000001b,
    MonitorRequestReasonAcDcDisplayBurstSuppressed     = 0x0000001c,
    MonitorRequestReasonSystemStateEntered             = 0x0000001d,
    MonitorRequestReasonWinrt                          = 0x0000001e,
    MonitorRequestReasonUserInputKeyboard              = 0x0000001f,
    MonitorRequestReasonUserInputMouse                 = 0x00000020,
    MonitorRequestReasonUserInputTouch                 = 0x00000021,
    MonitorRequestReasonUserInputPen                   = 0x00000022,
    MonitorRequestReasonUserInputAccelerometer         = 0x00000023,
    MonitorRequestReasonUserInputHid                   = 0x00000024,
    MonitorRequestReasonUserInputPoUserPresent         = 0x00000025,
    MonitorRequestReasonUserInputSessionSwitch         = 0x00000026,
    MonitorRequestReasonUserInputInitialization        = 0x00000027,
    MonitorRequestReasonPdcSignalWindowsMobilePwrNotif = 0x00000028,
    MonitorRequestReasonPdcSignalWindowsMobileShell    = 0x00000029,
    MonitorRequestReasonPdcSignalHeyCortana            = 0x0000002a,
    MonitorRequestReasonPdcSignalHolographicShell      = 0x0000002b,
    MonitorRequestReasonPdcSignalFingerprint           = 0x0000002c,
    MonitorRequestReasonDirectedDrips                  = 0x0000002d,
    MonitorRequestReasonDim                            = 0x0000002e,
    MonitorRequestReasonBuiltinPanel                   = 0x0000002f,
    MonitorRequestReasonDisplayRequiredUnDim           = 0x00000030,
    MonitorRequestReasonBatteryCountChangeSuppressed   = 0x00000031,
    MonitorRequestReasonResumeModernStandby            = 0x00000032,
    MonitorRequestReasonMax                            = 0x00000033,
}
alias POWER_MONITOR_REQUEST_REASON = int;

enum : int
{
    MonitorRequestTypeOff          = 0x00000000,
    MonitorRequestTypeOnAndPresent = 0x00000001,
    MonitorRequestTypeToggleOn     = 0x00000002,
}
alias POWER_MONITOR_REQUEST_TYPE = int;

enum : int
{
    PoAc               = 0x00000000,
    PoDc               = 0x00000001,
    PoHot              = 0x00000002,
    PoConditionMaximum = 0x00000003,
}
alias SYSTEM_POWER_CONDITION = int;

enum : int
{
    PlatformRoleUnspecified       = 0x00000000,
    PlatformRoleDesktop           = 0x00000001,
    PlatformRoleMobile            = 0x00000002,
    PlatformRoleWorkstation       = 0x00000003,
    PlatformRoleEnterpriseServer  = 0x00000004,
    PlatformRoleSOHOServer        = 0x00000005,
    PlatformRoleAppliancePC       = 0x00000006,
    PlatformRolePerformanceServer = 0x00000007,
    PlatformRoleSlate             = 0x00000008,
    PlatformRoleMaximum           = 0x00000009,
}
alias POWER_PLATFORM_ROLE = int;

enum : int
{
    HiberFileBucket1GB       = 0x00000000,
    HiberFileBucket2GB       = 0x00000001,
    HiberFileBucket4GB       = 0x00000002,
    HiberFileBucket8GB       = 0x00000003,
    HiberFileBucket16GB      = 0x00000004,
    HiberFileBucket32GB      = 0x00000005,
    HiberFileBucketUnlimited = 0x00000006,
    HiberFileBucketMax       = 0x00000007,
}
alias HIBERFILE_BUCKET_SIZE = int;

enum : int
{
    IMAGE_AUX_SYMBOL_TYPE_TOKEN_DEF = 0x00000001,
}
alias IMAGE_AUX_SYMBOL_TYPE = int;

enum : int
{
    PdataRefToFullXdata       = 0x00000000,
    PdataPackedUnwindFunction = 0x00000001,
    PdataPackedUnwindFragment = 0x00000002,
}
alias ARM64_FNPDATA_FLAGS = int;

enum : int
{
    PdataCrUnchained        = 0x00000000,
    PdataCrUnchainedSavedLr = 0x00000001,
    PdataCrChained          = 0x00000003,
}
alias ARM64_FNPDATA_CR = int;

enum : int
{
    IMPORT_OBJECT_CODE  = 0x00000000,
    IMPORT_OBJECT_DATA  = 0x00000001,
    IMPORT_OBJECT_CONST = 0x00000002,
}
alias IMPORT_OBJECT_TYPE = int;

enum : int
{
    IMPORT_OBJECT_ORDINAL         = 0x00000000,
    IMPORT_OBJECT_NAME            = 0x00000001,
    IMPORT_OBJECT_NAME_NO_PREFIX  = 0x00000002,
    IMPORT_OBJECT_NAME_UNDECORATE = 0x00000003,
    IMPORT_OBJECT_NAME_EXPORTAS   = 0x00000004,
}
alias IMPORT_OBJECT_NAME_TYPE = int;

enum ReplacesCorHdrNumericDefines : int
{
    COMIMAGE_FLAGS_ILONLY                      = 0x00000001,
    COMIMAGE_FLAGS_32BITREQUIRED               = 0x00000002,
    COMIMAGE_FLAGS_IL_LIBRARY                  = 0x00000004,
    COMIMAGE_FLAGS_STRONGNAMESIGNED            = 0x00000008,
    COMIMAGE_FLAGS_NATIVE_ENTRYPOINT           = 0x00000010,
    COMIMAGE_FLAGS_TRACKDEBUGDATA              = 0x00010000,
    COMIMAGE_FLAGS_32BITPREFERRED              = 0x00020000,
    COR_VERSION_MAJOR_V2                       = 0x00000002,
    COR_VERSION_MAJOR                          = 0x00000002,
    COR_VERSION_MINOR                          = 0x00000005,
    COR_DELETED_NAME_LENGTH                    = 0x00000008,
    COR_VTABLEGAP_NAME_LENGTH                  = 0x00000008,
    NATIVE_TYPE_MAX_CB                         = 0x00000001,
    COR_ILMETHOD_SECT_SMALL_MAX_DATASIZE       = 0x000000ff,
    IMAGE_COR_MIH_METHODRVA                    = 0x00000001,
    IMAGE_COR_MIH_EHRVA                        = 0x00000002,
    IMAGE_COR_MIH_BASICBLOCK                   = 0x00000008,
    COR_VTABLE_32BIT                           = 0x00000001,
    COR_VTABLE_64BIT                           = 0x00000002,
    COR_VTABLE_FROM_UNMANAGED                  = 0x00000004,
    COR_VTABLE_FROM_UNMANAGED_RETAIN_APPDOMAIN = 0x00000008,
    COR_VTABLE_CALL_MOST_DERIVED               = 0x00000010,
    IMAGE_COR_EATJ_THUNK_SIZE                  = 0x00000020,
    MAX_CLASS_NAME                             = 0x00000400,
    MAX_PACKAGE_NAME                           = 0x00000400,
}

enum : int
{
    UmsThreadInvalidInfoClass = 0x00000000,
    UmsThreadUserContext      = 0x00000001,
    UmsThreadPriority         = 0x00000002,
    UmsThreadAffinity         = 0x00000003,
    UmsThreadTeb              = 0x00000004,
    UmsThreadIsSuspended      = 0x00000005,
    UmsThreadIsTerminated     = 0x00000006,
    UmsThreadMaxInfoClass     = 0x00000007,
}
alias RTL_UMS_THREAD_INFO_CLASS = int;

enum : int
{
    UmsSchedulerStartup       = 0x00000000,
    UmsSchedulerThreadBlocked = 0x00000001,
    UmsSchedulerThreadYield   = 0x00000002,
}
alias RTL_UMS_SCHEDULER_REASON = int;

enum : int
{
    OS_DEPLOYMENT_STANDARD = 0x00000001,
    OS_DEPLOYMENT_COMPACT  = 0x00000002,
}
alias OS_DEPLOYEMENT_STATE_VALUES = int;

enum : int
{
    ImagePolicyEntryTypeNone          = 0x00000000,
    ImagePolicyEntryTypeBool          = 0x00000001,
    ImagePolicyEntryTypeInt8          = 0x00000002,
    ImagePolicyEntryTypeUInt8         = 0x00000003,
    ImagePolicyEntryTypeInt16         = 0x00000004,
    ImagePolicyEntryTypeUInt16        = 0x00000005,
    ImagePolicyEntryTypeInt32         = 0x00000006,
    ImagePolicyEntryTypeUInt32        = 0x00000007,
    ImagePolicyEntryTypeInt64         = 0x00000008,
    ImagePolicyEntryTypeUInt64        = 0x00000009,
    ImagePolicyEntryTypeAnsiString    = 0x0000000a,
    ImagePolicyEntryTypeUnicodeString = 0x0000000b,
    ImagePolicyEntryTypeOverride      = 0x0000000c,
    ImagePolicyEntryTypeMaximum       = 0x0000000d,
}
alias IMAGE_POLICY_ENTRY_TYPE = int;

enum : int
{
    ImagePolicyIdNone             = 0x00000000,
    ImagePolicyIdEtw              = 0x00000001,
    ImagePolicyIdDebug            = 0x00000002,
    ImagePolicyIdCrashDump        = 0x00000003,
    ImagePolicyIdCrashDumpKey     = 0x00000004,
    ImagePolicyIdCrashDumpKeyGuid = 0x00000005,
    ImagePolicyIdParentSd         = 0x00000006,
    ImagePolicyIdParentSdRev      = 0x00000007,
    ImagePolicyIdSvn              = 0x00000008,
    ImagePolicyIdDeviceId         = 0x00000009,
    ImagePolicyIdCapability       = 0x0000000a,
    ImagePolicyIdScenarioId       = 0x0000000b,
    ImagePolicyIdMaximum          = 0x0000000c,
}
alias IMAGE_POLICY_ID = int;

enum : int
{
    HeapCompatibilityInformation      = 0x00000000,
    HeapEnableTerminationOnCorruption = 0x00000001,
    HeapOptimizeResources             = 0x00000003,
}
alias HEAP_INFORMATION_CLASS = int;

enum : int
{
    ActivationContextBasicInformation                      = 0x00000001,
    ActivationContextDetailedInformation                   = 0x00000002,
    AssemblyDetailedInformationInActivationContext         = 0x00000003,
    FileInformationInAssemblyOfAssemblyInActivationContext = 0x00000004,
    RunlevelInformationInActivationContext                 = 0x00000005,
    CompatibilityInformationInActivationContext            = 0x00000006,
    ActivationContextManifestResourceName                  = 0x00000007,
    MaxActivationContextInfoClass                          = 0x00000008,
    AssemblyDetailedInformationInActivationContxt          = 0x00000003,
    FileInformationInAssemblyOfAssemblyInActivationContxt  = 0x00000004,
}
alias ACTIVATION_CONTEXT_INFO_CLASS = int;

enum : int
{
    DriverType               = 0x00000001,
    FileSystemType           = 0x00000002,
    Win32ServiceOwnProcess   = 0x00000010,
    Win32ServiceShareProcess = 0x00000020,
    AdapterType              = 0x00000004,
    RecognizerType           = 0x00000008,
}
alias CM_SERVICE_NODE_TYPE = int;

enum : int
{
    BootLoad    = 0x00000000,
    SystemLoad  = 0x00000001,
    AutoLoad    = 0x00000002,
    DemandLoad  = 0x00000003,
    DisableLoad = 0x00000004,
}
alias CM_SERVICE_LOAD_TYPE = int;

enum : int
{
    IgnoreError   = 0x00000000,
    NormalError   = 0x00000001,
    SevereError   = 0x00000002,
    CriticalError = 0x00000003,
}
alias CM_ERROR_CONTROL_TYPE = int;

enum : int
{
    TapeDriveProblemNone         = 0x00000000,
    TapeDriveReadWriteWarning    = 0x00000001,
    TapeDriveReadWriteError      = 0x00000002,
    TapeDriveReadWarning         = 0x00000003,
    TapeDriveWriteWarning        = 0x00000004,
    TapeDriveReadError           = 0x00000005,
    TapeDriveWriteError          = 0x00000006,
    TapeDriveHardwareError       = 0x00000007,
    TapeDriveUnsupportedMedia    = 0x00000008,
    TapeDriveScsiConnectionError = 0x00000009,
    TapeDriveTimetoClean         = 0x0000000a,
    TapeDriveCleanDriveNow       = 0x0000000b,
    TapeDriveMediaLifeExpired    = 0x0000000c,
    TapeDriveSnappedTape         = 0x0000000d,
}
alias TAPE_DRIVE_PROBLEM_TYPE = int;

enum : int
{
    TransactionStateNormal          = 0x00000001,
    TransactionStateIndoubt         = 0x00000002,
    TransactionStateCommittedNotify = 0x00000003,
}
alias TRANSACTION_STATE = int;

enum : int
{
    TransactionBasicInformation              = 0x00000000,
    TransactionPropertiesInformation         = 0x00000001,
    TransactionEnlistmentInformation         = 0x00000002,
    TransactionSuperiorEnlistmentInformation = 0x00000003,
    TransactionBindInformation               = 0x00000004,
    TransactionDTCPrivateInformation         = 0x00000005,
}
alias TRANSACTION_INFORMATION_CLASS = int;

enum : int
{
    TransactionManagerBasicInformation             = 0x00000000,
    TransactionManagerLogInformation               = 0x00000001,
    TransactionManagerLogPathInformation           = 0x00000002,
    TransactionManagerRecoveryInformation          = 0x00000004,
    TransactionManagerOnlineProbeInformation       = 0x00000003,
    TransactionManagerOldestTransactionInformation = 0x00000005,
}
alias TRANSACTIONMANAGER_INFORMATION_CLASS = int;

enum : int
{
    ResourceManagerBasicInformation      = 0x00000000,
    ResourceManagerCompletionInformation = 0x00000001,
}
alias RESOURCEMANAGER_INFORMATION_CLASS = int;

enum : int
{
    EnlistmentBasicInformation    = 0x00000000,
    EnlistmentRecoveryInformation = 0x00000001,
    EnlistmentCrmInformation      = 0x00000002,
}
alias ENLISTMENT_INFORMATION_CLASS = int;

enum : int
{
    KTMOBJECT_TRANSACTION         = 0x00000000,
    KTMOBJECT_TRANSACTION_MANAGER = 0x00000001,
    KTMOBJECT_RESOURCE_MANAGER    = 0x00000002,
    KTMOBJECT_ENLISTMENT          = 0x00000003,
    KTMOBJECT_INVALID             = 0x00000004,
}
alias KTMOBJECT_TYPE = int;

enum : int
{
    TP_CALLBACK_PRIORITY_HIGH    = 0x00000000,
    TP_CALLBACK_PRIORITY_NORMAL  = 0x00000001,
    TP_CALLBACK_PRIORITY_LOW     = 0x00000002,
    TP_CALLBACK_PRIORITY_INVALID = 0x00000003,
    TP_CALLBACK_PRIORITY_COUNT   = 0x00000003,
}
alias TP_CALLBACK_PRIORITY = int;

enum : int
{
    LowMemoryResourceNotification  = 0x00000000,
    HighMemoryResourceNotification = 0x00000001,
}
alias MEMORY_RESOURCE_NOTIFICATION_TYPE = int;

enum : int
{
    VmOfferPriorityVeryLow     = 0x00000001,
    VmOfferPriorityLow         = 0x00000002,
    VmOfferPriorityBelowNormal = 0x00000003,
    VmOfferPriorityNormal      = 0x00000004,
}
alias OFFER_PRIORITY = int;

enum : int
{
    MemoryRegionInfo = 0x00000000,
}
alias WIN32_MEMORY_INFORMATION_CLASS = int;

enum : int
{
    DDS_4mm            = 0x00000020,
    MiniQic            = 0x00000021,
    Travan             = 0x00000022,
    QIC                = 0x00000023,
    MP_8mm             = 0x00000024,
    AME_8mm            = 0x00000025,
    AIT1_8mm           = 0x00000026,
    DLT                = 0x00000027,
    NCTP               = 0x00000028,
    IBM_3480           = 0x00000029,
    IBM_3490E          = 0x0000002a,
    IBM_Magstar_3590   = 0x0000002b,
    IBM_Magstar_MP     = 0x0000002c,
    STK_DATA_D3        = 0x0000002d,
    SONY_DTF           = 0x0000002e,
    DV_6mm             = 0x0000002f,
    DMI                = 0x00000030,
    SONY_D2            = 0x00000031,
    CLEANER_CARTRIDGE  = 0x00000032,
    CD_ROM             = 0x00000033,
    CD_R               = 0x00000034,
    CD_RW              = 0x00000035,
    DVD_ROM            = 0x00000036,
    DVD_R              = 0x00000037,
    DVD_RW             = 0x00000038,
    MO_3_RW            = 0x00000039,
    MO_5_WO            = 0x0000003a,
    MO_5_RW            = 0x0000003b,
    MO_5_LIMDOW        = 0x0000003c,
    PC_5_WO            = 0x0000003d,
    PC_5_RW            = 0x0000003e,
    PD_5_RW            = 0x0000003f,
    ABL_5_WO           = 0x00000040,
    PINNACLE_APEX_5_RW = 0x00000041,
    SONY_12_WO         = 0x00000042,
    PHILIPS_12_WO      = 0x00000043,
    HITACHI_12_WO      = 0x00000044,
    CYGNET_12_WO       = 0x00000045,
    KODAK_14_WO        = 0x00000046,
    MO_NFR_525         = 0x00000047,
    NIKON_12_RW        = 0x00000048,
    IOMEGA_ZIP         = 0x00000049,
    IOMEGA_JAZ         = 0x0000004a,
    SYQUEST_EZ135      = 0x0000004b,
    SYQUEST_EZFLYER    = 0x0000004c,
    SYQUEST_SYJET      = 0x0000004d,
    AVATAR_F2          = 0x0000004e,
    MP2_8mm            = 0x0000004f,
    DST_S              = 0x00000050,
    DST_M              = 0x00000051,
    DST_L              = 0x00000052,
    VXATape_1          = 0x00000053,
    VXATape_2          = 0x00000054,
    STK_9840           = 0x00000055,
    LTO_Ultrium        = 0x00000056,
    LTO_Accelis        = 0x00000057,
    DVD_RAM            = 0x00000058,
    AIT_8mm            = 0x00000059,
    ADR_1              = 0x0000005a,
    ADR_2              = 0x0000005b,
    STK_9940           = 0x0000005c,
    SAIT               = 0x0000005d,
    VXATape            = 0x0000005e,
}
alias STORAGE_MEDIA_TYPE = int;

enum : int
{
    BusTypeUnknown           = 0x00000000,
    BusTypeScsi              = 0x00000001,
    BusTypeAtapi             = 0x00000002,
    BusTypeAta               = 0x00000003,
    BusType1394              = 0x00000004,
    BusTypeSsa               = 0x00000005,
    BusTypeFibre             = 0x00000006,
    BusTypeUsb               = 0x00000007,
    BusTypeRAID              = 0x00000008,
    BusTypeiScsi             = 0x00000009,
    BusTypeSas               = 0x0000000a,
    BusTypeSata              = 0x0000000b,
    BusTypeSd                = 0x0000000c,
    BusTypeMmc               = 0x0000000d,
    BusTypeVirtual           = 0x0000000e,
    BusTypeFileBackedVirtual = 0x0000000f,
    BusTypeSpaces            = 0x00000010,
    BusTypeNvme              = 0x00000011,
    BusTypeSCM               = 0x00000012,
    BusTypeUfs               = 0x00000013,
    BusTypeMax               = 0x00000014,
    BusTypeMaxReserved       = 0x0000007f,
}
alias STORAGE_BUS_TYPE = int;

enum : int
{
    PropertyStandardSet   = 0x00000000,
    PropertyExistsSet     = 0x00000001,
    PropertySetMaxDefined = 0x00000002,
}
alias STORAGE_SET_TYPE = int;

enum : int
{
    StorageIdCodeSetReserved = 0x00000000,
    StorageIdCodeSetBinary   = 0x00000001,
    StorageIdCodeSetAscii    = 0x00000002,
    StorageIdCodeSetUtf8     = 0x00000003,
}
alias STORAGE_IDENTIFIER_CODE_SET = int;

enum : int
{
    StorageIdTypeVendorSpecific           = 0x00000000,
    StorageIdTypeVendorId                 = 0x00000001,
    StorageIdTypeEUI64                    = 0x00000002,
    StorageIdTypeFCPHName                 = 0x00000003,
    StorageIdTypePortRelative             = 0x00000004,
    StorageIdTypeTargetPortGroup          = 0x00000005,
    StorageIdTypeLogicalUnitGroup         = 0x00000006,
    StorageIdTypeMD5LogicalUnitIdentifier = 0x00000007,
    StorageIdTypeScsiNameString           = 0x00000008,
}
alias STORAGE_IDENTIFIER_TYPE = int;

enum : int
{
    StorageIdNAAFormatIEEEExtended            = 0x00000002,
    StorageIdNAAFormatIEEERegistered          = 0x00000003,
    StorageIdNAAFormatIEEEERegisteredExtended = 0x00000005,
}
alias STORAGE_ID_NAA_FORMAT = int;

enum : int
{
    StorageIdAssocDevice = 0x00000000,
    StorageIdAssocPort   = 0x00000001,
    StorageIdAssocTarget = 0x00000002,
}
alias STORAGE_ASSOCIATION_TYPE = int;

enum : int
{
    StorageRpmbFrameTypeUnknown  = 0x00000000,
    StorageRpmbFrameTypeStandard = 0x00000001,
    StorageRpmbFrameTypeMax      = 0x00000002,
}
alias STORAGE_RPMB_FRAME_TYPE = int;

enum : int
{
    StorageCryptoAlgorithmUnknown         = 0x00000000,
    StorageCryptoAlgorithmXTSAES          = 0x00000001,
    StorageCryptoAlgorithmBitlockerAESCBC = 0x00000002,
    StorageCryptoAlgorithmAESECB          = 0x00000003,
    StorageCryptoAlgorithmESSIVAESCBC     = 0x00000004,
    StorageCryptoAlgorithmMax             = 0x00000005,
}
alias STORAGE_CRYPTO_ALGORITHM_ID = int;

enum : int
{
    StorageCryptoKeySizeUnknown = 0x00000000,
    StorageCryptoKeySize128Bits = 0x00000001,
    StorageCryptoKeySize192Bits = 0x00000002,
    StorageCryptoKeySize256Bits = 0x00000003,
    StorageCryptoKeySize512Bits = 0x00000004,
}
alias STORAGE_CRYPTO_KEY_SIZE = int;

enum : int
{
    StorageTierMediaTypeUnspecified = 0x00000000,
    StorageTierMediaTypeDisk        = 0x00000001,
    StorageTierMediaTypeSsd         = 0x00000002,
    StorageTierMediaTypeScm         = 0x00000004,
    StorageTierMediaTypeMax         = 0x00000005,
}
alias STORAGE_TIER_MEDIA_TYPE = int;

enum : int
{
    StorageTierClassUnspecified = 0x00000000,
    StorageTierClassCapacity    = 0x00000001,
    StorageTierClassPerformance = 0x00000002,
    StorageTierClassMax         = 0x00000003,
}
alias STORAGE_TIER_CLASS = int;

enum : int
{
    UfsDataTypeUnknown         = 0x00000000,
    UfsDataTypeQueryDescriptor = 0x00000001,
    UfsDataTypeMax             = 0x00000002,
}
alias STORAGE_PROTOCOL_UFS_DATA_TYPE = int;

enum : int
{
    DiskHealthUnknown   = 0x00000000,
    DiskHealthUnhealthy = 0x00000001,
    DiskHealthWarning   = 0x00000002,
    DiskHealthHealthy   = 0x00000003,
    DiskHealthMax       = 0x00000004,
}
alias STORAGE_DISK_HEALTH_STATUS = int;

enum : int
{
    DiskOpStatusNone              = 0x00000000,
    DiskOpStatusUnknown           = 0x00000001,
    DiskOpStatusOk                = 0x00000002,
    DiskOpStatusPredictingFailure = 0x00000003,
    DiskOpStatusInService         = 0x00000004,
    DiskOpStatusHardwareError     = 0x00000005,
    DiskOpStatusNotUsable         = 0x00000006,
    DiskOpStatusTransientError    = 0x00000007,
    DiskOpStatusMissing           = 0x00000008,
}
alias STORAGE_DISK_OPERATIONAL_STATUS = int;

enum : int
{
    DiskOpReasonUnknown                      = 0x00000000,
    DiskOpReasonScsiSenseCode                = 0x00000001,
    DiskOpReasonMedia                        = 0x00000002,
    DiskOpReasonIo                           = 0x00000003,
    DiskOpReasonThresholdExceeded            = 0x00000004,
    DiskOpReasonLostData                     = 0x00000005,
    DiskOpReasonEnergySource                 = 0x00000006,
    DiskOpReasonConfiguration                = 0x00000007,
    DiskOpReasonDeviceController             = 0x00000008,
    DiskOpReasonMediaController              = 0x00000009,
    DiskOpReasonComponent                    = 0x0000000a,
    DiskOpReasonNVDIMM_N                     = 0x0000000b,
    DiskOpReasonBackgroundOperation          = 0x0000000c,
    DiskOpReasonInvalidFirmware              = 0x0000000d,
    DiskOpReasonHealthCheck                  = 0x0000000e,
    DiskOpReasonLostDataPersistence          = 0x0000000f,
    DiskOpReasonDisabledByPlatform           = 0x00000010,
    DiskOpReasonLostWritePersistence         = 0x00000011,
    DiskOpReasonDataPersistenceLossImminent  = 0x00000012,
    DiskOpReasonWritePersistenceLossImminent = 0x00000013,
    DiskOpReasonMax                          = 0x00000014,
}
alias STORAGE_OPERATIONAL_STATUS_REASON = int;

enum : int
{
    ZonedDeviceTypeUnknown       = 0x00000000,
    ZonedDeviceTypeHostManaged   = 0x00000001,
    ZonedDeviceTypeHostAware     = 0x00000002,
    ZonedDeviceTypeDeviceManaged = 0x00000003,
}
alias STORAGE_ZONED_DEVICE_TYPES = int;

enum : int
{
    ZoneTypeUnknown                  = 0x00000000,
    ZoneTypeConventional             = 0x00000001,
    ZoneTypeSequentialWriteRequired  = 0x00000002,
    ZoneTypeSequentialWritePreferred = 0x00000003,
    ZoneTypeMax                      = 0x00000004,
}
alias STORAGE_ZONE_TYPES = int;

enum : int
{
    ZonesAttributeTypeAndLengthMayDifferent       = 0x00000000,
    ZonesAttributeTypeSameLengthSame              = 0x00000001,
    ZonesAttributeTypeSameLastZoneLengthDifferent = 0x00000002,
    ZonesAttributeTypeMayDifferentLengthSame      = 0x00000003,
}
alias STORAGE_ZONES_ATTRIBUTES = int;

enum : int
{
    ZoneConditionConventional     = 0x00000000,
    ZoneConditionEmpty            = 0x00000001,
    ZoneConditionImplicitlyOpened = 0x00000002,
    ZoneConditionExplicitlyOpened = 0x00000003,
    ZoneConditionClosed           = 0x00000004,
    ZoneConditionReadOnly         = 0x0000000d,
    ZoneConditionFull             = 0x0000000e,
    ZoneConditionOffline          = 0x0000000f,
}
alias STORAGE_ZONE_CONDITION = int;

enum : int
{
    StorageDiagnosticLevelDefault = 0x00000000,
    StorageDiagnosticLevelMax     = 0x00000001,
}
alias STORAGE_DIAGNOSTIC_LEVEL = int;

enum : int
{
    StorageDiagnosticTargetTypeUndefined   = 0x00000000,
    StorageDiagnosticTargetTypePort        = 0x00000001,
    StorageDiagnosticTargetTypeMiniport    = 0x00000002,
    StorageDiagnosticTargetTypeHbaFirmware = 0x00000003,
    StorageDiagnosticTargetTypeMax         = 0x00000004,
}
alias STORAGE_DIAGNOSTIC_TARGET_TYPE = int;

enum : int
{
    DeviceInternalStatusDataRequestTypeUndefined = 0x00000000,
    DeviceCurrentInternalStatusDataHeader        = 0x00000001,
    DeviceCurrentInternalStatusData              = 0x00000002,
}
alias DEVICE_INTERNAL_STATUS_DATA_REQUEST_TYPE = int;

enum : int
{
    DeviceStatusDataSetUndefined = 0x00000000,
    DeviceStatusDataSet1         = 0x00000001,
    DeviceStatusDataSet2         = 0x00000002,
    DeviceStatusDataSet3         = 0x00000003,
    DeviceStatusDataSet4         = 0x00000004,
    DeviceStatusDataSetMax       = 0x00000005,
}
alias DEVICE_INTERNAL_STATUS_DATA_SET = int;

enum : int
{
    TCCollectionBugCheck             = 0x00000001,
    TCCollectionApplicationRequested = 0x00000002,
    TCCollectionDeviceRequested      = 0x00000003,
}
alias _DEVICEDUMP_COLLECTION_TYPE = int;

enum : int
{
    StoragePowerupUnknown         = 0x00000000,
    StoragePowerupIO              = 0x00000001,
    StoragePowerupDeviceAttention = 0x00000002,
}
alias STORAGE_POWERUP_REASON_TYPE = int;

enum : int
{
    StorRpmbProgramAuthKey                 = 0x00000001,
    StorRpmbQueryWriteCounter              = 0x00000002,
    StorRpmbAuthenticatedWrite             = 0x00000003,
    StorRpmbAuthenticatedRead              = 0x00000004,
    StorRpmbReadResultRequest              = 0x00000005,
    StorRpmbAuthenticatedDeviceConfigWrite = 0x00000006,
    StorRpmbAuthenticatedDeviceConfigRead  = 0x00000007,
}
alias STORAGE_RPMB_COMMAND_TYPE = int;

enum : int
{
    StorageCounterTypeUnknown                 = 0x00000000,
    StorageCounterTypeTemperatureCelsius      = 0x00000001,
    StorageCounterTypeTemperatureCelsiusMax   = 0x00000002,
    StorageCounterTypeReadErrorsTotal         = 0x00000003,
    StorageCounterTypeReadErrorsCorrected     = 0x00000004,
    StorageCounterTypeReadErrorsUncorrected   = 0x00000005,
    StorageCounterTypeWriteErrorsTotal        = 0x00000006,
    StorageCounterTypeWriteErrorsCorrected    = 0x00000007,
    StorageCounterTypeWriteErrorsUncorrected  = 0x00000008,
    StorageCounterTypeManufactureDate         = 0x00000009,
    StorageCounterTypeStartStopCycleCount     = 0x0000000a,
    StorageCounterTypeStartStopCycleCountMax  = 0x0000000b,
    StorageCounterTypeLoadUnloadCycleCount    = 0x0000000c,
    StorageCounterTypeLoadUnloadCycleCountMax = 0x0000000d,
    StorageCounterTypeWearPercentage          = 0x0000000e,
    StorageCounterTypeWearPercentageWarning   = 0x0000000f,
    StorageCounterTypeWearPercentageMax       = 0x00000010,
    StorageCounterTypePowerOnHours            = 0x00000011,
    StorageCounterTypeReadLatency100NSMax     = 0x00000012,
    StorageCounterTypeWriteLatency100NSMax    = 0x00000013,
    StorageCounterTypeFlushLatency100NSMax    = 0x00000014,
    StorageCounterTypeMax                     = 0x00000015,
}
alias STORAGE_COUNTER_TYPE = int;

enum : int
{
    StorAttributeMgmt_ClearAttribute = 0x00000000,
    StorAttributeMgmt_SetAttribute   = 0x00000001,
    StorAttributeMgmt_ResetAttribute = 0x00000002,
}
alias STORAGE_ATTRIBUTE_MGMT_ACTION = int;

enum : int
{
    ScmRegionFlagNone  = 0x00000000,
    ScmRegionFlagLabel = 0x00000001,
}
alias SCM_REGION_FLAG = int;

enum : int
{
    ScmPhysicalDeviceQuery_Descriptor  = 0x00000000,
    ScmPhysicalDeviceQuery_IsSupported = 0x00000001,
    ScmPhysicalDeviceQuery_Max         = 0x00000002,
}
alias SCM_PD_QUERY_TYPE = int;

enum : int
{
    ScmPhysicalDeviceProperty_DeviceInfo         = 0x00000000,
    ScmPhysicalDeviceProperty_ManagementStatus   = 0x00000001,
    ScmPhysicalDeviceProperty_FirmwareInfo       = 0x00000002,
    ScmPhysicalDeviceProperty_LocationString     = 0x00000003,
    ScmPhysicalDeviceProperty_DeviceSpecificInfo = 0x00000004,
    ScmPhysicalDeviceProperty_DeviceHandle       = 0x00000005,
    ScmPhysicalDeviceProperty_Max                = 0x00000006,
}
alias SCM_PD_PROPERTY_ID = int;

enum : int
{
    ScmPhysicalDeviceHealth_Unknown   = 0x00000000,
    ScmPhysicalDeviceHealth_Unhealthy = 0x00000001,
    ScmPhysicalDeviceHealth_Warning   = 0x00000002,
    ScmPhysicalDeviceHealth_Healthy   = 0x00000003,
    ScmPhysicalDeviceHealth_Max       = 0x00000004,
}
alias SCM_PD_HEALTH_STATUS = int;

enum : int
{
    ScmPhysicalDeviceOpStatus_Unknown           = 0x00000000,
    ScmPhysicalDeviceOpStatus_Ok                = 0x00000001,
    ScmPhysicalDeviceOpStatus_PredictingFailure = 0x00000002,
    ScmPhysicalDeviceOpStatus_InService         = 0x00000003,
    ScmPhysicalDeviceOpStatus_HardwareError     = 0x00000004,
    ScmPhysicalDeviceOpStatus_NotUsable         = 0x00000005,
    ScmPhysicalDeviceOpStatus_TransientError    = 0x00000006,
    ScmPhysicalDeviceOpStatus_Missing           = 0x00000007,
    ScmPhysicalDeviceOpStatus_Max               = 0x00000008,
}
alias SCM_PD_OPERATIONAL_STATUS = int;

enum : int
{
    ScmPhysicalDeviceOpReason_Unknown                      = 0x00000000,
    ScmPhysicalDeviceOpReason_Media                        = 0x00000001,
    ScmPhysicalDeviceOpReason_ThresholdExceeded            = 0x00000002,
    ScmPhysicalDeviceOpReason_LostData                     = 0x00000003,
    ScmPhysicalDeviceOpReason_EnergySource                 = 0x00000004,
    ScmPhysicalDeviceOpReason_Configuration                = 0x00000005,
    ScmPhysicalDeviceOpReason_DeviceController             = 0x00000006,
    ScmPhysicalDeviceOpReason_MediaController              = 0x00000007,
    ScmPhysicalDeviceOpReason_Component                    = 0x00000008,
    ScmPhysicalDeviceOpReason_BackgroundOperation          = 0x00000009,
    ScmPhysicalDeviceOpReason_InvalidFirmware              = 0x0000000a,
    ScmPhysicalDeviceOpReason_HealthCheck                  = 0x0000000b,
    ScmPhysicalDeviceOpReason_LostDataPersistence          = 0x0000000c,
    ScmPhysicalDeviceOpReason_DisabledByPlatform           = 0x0000000d,
    ScmPhysicalDeviceOpReason_PermanentError               = 0x0000000e,
    ScmPhysicalDeviceOpReason_LostWritePersistence         = 0x0000000f,
    ScmPhysicalDeviceOpReason_FatalError                   = 0x00000010,
    ScmPhysicalDeviceOpReason_DataPersistenceLossImminent  = 0x00000011,
    ScmPhysicalDeviceOpReason_WritePersistenceLossImminent = 0x00000012,
    ScmPhysicalDeviceOpReason_MediaRemainingSpareBlock     = 0x00000013,
    ScmPhysicalDeviceOpReason_PerformanceDegradation       = 0x00000014,
    ScmPhysicalDeviceOpReason_ExcessiveTemperature         = 0x00000015,
    ScmPhysicalDeviceOpReason_Max                          = 0x00000016,
}
alias SCM_PD_OPERATIONAL_STATUS_REASON = int;

enum : int
{
    ScmPhysicalDeviceReinit_Success        = 0x00000000,
    ScmPhysicalDeviceReinit_RebootNeeded   = 0x00000001,
    ScmPhysicalDeviceReinit_ColdBootNeeded = 0x00000002,
    ScmPhysicalDeviceReinit_Max            = 0x00000003,
}
alias SCM_PD_MEDIA_REINITIALIZATION_STATUS = int;

enum : int
{
    DetectNone    = 0x00000000,
    DetectInt13   = 0x00000001,
    DetectExInt13 = 0x00000002,
}
alias DETECTION_TYPE = int;

enum : int
{
    EqualPriority      = 0x00000000,
    KeepPrefetchedData = 0x00000001,
    KeepReadData       = 0x00000002,
}
alias DISK_CACHE_RETENTION_PRIORITY = int;

enum : int
{
    RequestSize     = 0x00000000,
    RequestLocation = 0x00000001,
}
alias BIN_TYPES = int;

enum : int
{
    AllElements       = 0x00000000,
    ChangerTransport  = 0x00000001,
    ChangerSlot       = 0x00000002,
    ChangerIEPort     = 0x00000003,
    ChangerDrive      = 0x00000004,
    ChangerDoor       = 0x00000005,
    ChangerKeypad     = 0x00000006,
    ChangerMaxElement = 0x00000007,
}
alias ELEMENT_TYPE = int;

enum : int
{
    DeviceProblemNone                 = 0x00000000,
    DeviceProblemHardware             = 0x00000001,
    DeviceProblemCHMError             = 0x00000002,
    DeviceProblemDoorOpen             = 0x00000003,
    DeviceProblemCalibrationError     = 0x00000004,
    DeviceProblemTargetFailure        = 0x00000005,
    DeviceProblemCHMMoveError         = 0x00000006,
    DeviceProblemCHMZeroError         = 0x00000007,
    DeviceProblemCartridgeInsertError = 0x00000008,
    DeviceProblemPositionError        = 0x00000009,
    DeviceProblemSensorError          = 0x0000000a,
    DeviceProblemCartridgeEjectError  = 0x0000000b,
    DeviceProblemGripperError         = 0x0000000c,
    DeviceProblemDriveError           = 0x0000000d,
}
alias CHANGER_DEVICE_PROBLEM_TYPE = int;

enum : int
{
    ShrinkPrepare = 0x00000001,
    ShrinkCommit  = 0x00000002,
    ShrinkAbort   = 0x00000003,
}
alias SHRINK_VOLUME_REQUEST_TYPES = int;

enum : int
{
    CsvFsDiskConnectivityNone          = 0x00000000,
    CsvFsDiskConnectivityMdsNodeOnly   = 0x00000001,
    CsvFsDiskConnectivitySubsetOfNodes = 0x00000002,
    CsvFsDiskConnectivityAllNodes      = 0x00000003,
}
alias CSVFS_DISK_CONNECTIVITY = int;

enum : int
{
    StorageReserveIdNone          = 0x00000000,
    StorageReserveIdHard          = 0x00000001,
    StorageReserveIdSoft          = 0x00000002,
    StorageReserveIdUpdateScratch = 0x00000003,
    StorageReserveIdMax           = 0x00000004,
}
alias STORAGE_RESERVE_ID = int;

enum : int
{
    QUERY_FILE_LAYOUT_FILTER_TYPE_NONE               = 0x00000000,
    QUERY_FILE_LAYOUT_FILTER_TYPE_CLUSTERS           = 0x00000001,
    QUERY_FILE_LAYOUT_FILTER_TYPE_FILEID             = 0x00000002,
    QUERY_FILE_LAYOUT_FILTER_TYPE_STORAGE_RESERVE_ID = 0x00000003,
    QUERY_FILE_LAYOUT_NUM_FILTER_TYPES               = 0x00000004,
}
alias QUERY_FILE_LAYOUT_FILTER_TYPE = int;

enum : int
{
    FileStorageTierClassUnspecified = 0x00000000,
    FileStorageTierClassCapacity    = 0x00000001,
    FileStorageTierClassPerformance = 0x00000002,
    FileStorageTierClassMax         = 0x00000003,
}
alias FILE_STORAGE_TIER_CLASS = int;

enum : int
{
    SmrGcStateInactive        = 0x00000000,
    SmrGcStatePaused          = 0x00000001,
    SmrGcStateActive          = 0x00000002,
    SmrGcStateActiveFullSpeed = 0x00000003,
}
alias REFS_SMR_VOLUME_GC_STATE = int;

enum : int
{
    SmrGcActionStart          = 0x00000001,
    SmrGcActionStartFullSpeed = 0x00000002,
    SmrGcActionPause          = 0x00000003,
    SmrGcActionStop           = 0x00000004,
}
alias REFS_SMR_VOLUME_GC_ACTION = int;

enum : int
{
    SmrGcMethodCompaction  = 0x00000001,
    SmrGcMethodCompression = 0x00000002,
    SmrGcMethodRotation    = 0x00000003,
}
alias REFS_SMR_VOLUME_GC_METHOD = int;

enum : int
{
    VirtualStorageBehaviorUndefined         = 0x00000000,
    VirtualStorageBehaviorCacheWriteThrough = 0x00000001,
    VirtualStorageBehaviorCacheWriteBack    = 0x00000002,
}
alias VIRTUAL_STORAGE_BEHAVIOR_CODE = int;

enum : int
{
    BIDI_NULL   = 0x00000000,
    BIDI_INT    = 0x00000001,
    BIDI_FLOAT  = 0x00000002,
    BIDI_BOOL   = 0x00000003,
    BIDI_STRING = 0x00000004,
    BIDI_TEXT   = 0x00000005,
    BIDI_ENUM   = 0x00000006,
    BIDI_BLOB   = 0x00000007,
}
alias BIDI_TYPE = int;

enum : int
{
    PRINTER_OPTION_NO_CACHE       = 0x00000001,
    PRINTER_OPTION_CACHE          = 0x00000002,
    PRINTER_OPTION_CLIENT_CHANGE  = 0x00000004,
    PRINTER_OPTION_NO_CLIENT_DATA = 0x00000008,
}
alias PRINTER_OPTION_FLAGS = int;

enum EPrintPropertyType : int
{
    kPropertyTypeString              = 0x00000001,
    kPropertyTypeInt32               = 0x00000002,
    kPropertyTypeInt64               = 0x00000003,
    kPropertyTypeByte                = 0x00000004,
    kPropertyTypeTime                = 0x00000005,
    kPropertyTypeDevMode             = 0x00000006,
    kPropertyTypeSD                  = 0x00000007,
    kPropertyTypeNotificationReply   = 0x00000008,
    kPropertyTypeNotificationOptions = 0x00000009,
    kPropertyTypeBuffer              = 0x0000000a,
}

enum EPrintXPSJobProgress : int
{
    kAddingDocumentSequence = 0x00000000,
    kDocumentSequenceAdded  = 0x00000001,
    kAddingFixedDocument    = 0x00000002,
    kFixedDocumentAdded     = 0x00000003,
    kAddingFixedPage        = 0x00000004,
    kFixedPageAdded         = 0x00000005,
    kResourceAdded          = 0x00000006,
    kFontAdded              = 0x00000007,
    kImageAdded             = 0x00000008,
    kXpsDocumentCommitted   = 0x00000009,
}

enum EPrintXPSJobOperation : int
{
    kJobProduction  = 0x00000001,
    kJobConsumption = 0x00000002,
}

enum : int
{
    PRINT_EXECUTION_CONTEXT_APPLICATION            = 0x00000000,
    PRINT_EXECUTION_CONTEXT_SPOOLER_SERVICE        = 0x00000001,
    PRINT_EXECUTION_CONTEXT_SPOOLER_ISOLATION_HOST = 0x00000002,
    PRINT_EXECUTION_CONTEXT_FILTER_PIPELINE        = 0x00000003,
    PRINT_EXECUTION_CONTEXT_WOW64                  = 0x00000004,
}
alias PRINT_EXECUTION_CONTEXT = int;

enum : int
{
    DQTAT_COM_NONE = 0x00000000,
    DQTAT_COM_ASTA = 0x00000001,
    DQTAT_COM_STA  = 0x00000002,
}
alias DISPATCHERQUEUE_THREAD_APARTMENTTYPE = int;

enum : int
{
    DQTYPE_THREAD_DEDICATED = 0x00000001,
    DQTYPE_THREAD_CURRENT   = 0x00000002,
}
alias DISPATCHERQUEUE_THREAD_TYPE = int;

enum : int
{
    VDSStorageIdCodeSetReserved = 0x00000000,
    VDSStorageIdCodeSetBinary   = 0x00000001,
    VDSStorageIdCodeSetAscii    = 0x00000002,
    VDSStorageIdCodeSetUtf8     = 0x00000003,
}
alias VDS_STORAGE_IDENTIFIER_CODE_SET = int;

enum : int
{
    VDSStorageIdTypeVendorSpecific           = 0x00000000,
    VDSStorageIdTypeVendorId                 = 0x00000001,
    VDSStorageIdTypeEUI64                    = 0x00000002,
    VDSStorageIdTypeFCPHName                 = 0x00000003,
    VDSStorageIdTypePortRelative             = 0x00000004,
    VDSStorageIdTypeTargetPortGroup          = 0x00000005,
    VDSStorageIdTypeLogicalUnitGroup         = 0x00000006,
    VDSStorageIdTypeMD5LogicalUnitIdentifier = 0x00000007,
    VDSStorageIdTypeScsiNameString           = 0x00000008,
}
alias VDS_STORAGE_IDENTIFIER_TYPE = int;

enum : int
{
    VDSBusTypeUnknown           = 0x00000000,
    VDSBusTypeScsi              = 0x00000001,
    VDSBusTypeAtapi             = 0x00000002,
    VDSBusTypeAta               = 0x00000003,
    VDSBusType1394              = 0x00000004,
    VDSBusTypeSsa               = 0x00000005,
    VDSBusTypeFibre             = 0x00000006,
    VDSBusTypeUsb               = 0x00000007,
    VDSBusTypeRAID              = 0x00000008,
    VDSBusTypeiScsi             = 0x00000009,
    VDSBusTypeSas               = 0x0000000a,
    VDSBusTypeSata              = 0x0000000b,
    VDSBusTypeSd                = 0x0000000c,
    VDSBusTypeMmc               = 0x0000000d,
    VDSBusTypeMax               = 0x0000000e,
    VDSBusTypeVirtual           = 0x0000000e,
    VDSBusTypeFileBackedVirtual = 0x0000000f,
    VDSBusTypeSpaces            = 0x00000010,
    VDSBusTypeNVMe              = 0x00000011,
    VDSBusTypeScm               = 0x00000012,
    VDSBusTypeUfs               = 0x00000013,
    VDSBusTypeMaxReserved       = 0x0000007f,
}
alias VDS_STORAGE_BUS_TYPE = int;

enum : int
{
    VDS_IA_UNKNOWN = 0x00000000,
    VDS_IA_FCFS    = 0x00000001,
    VDS_IA_FCPH    = 0x00000002,
    VDS_IA_FCPH3   = 0x00000003,
    VDS_IA_MAC     = 0x00000004,
    VDS_IA_SCSI    = 0x00000005,
}
alias VDS_INTERCONNECT_ADDRESS_TYPE = int;

enum : int
{
    VDS_OT_UNKNOWN      = 0x00000000,
    VDS_OT_PROVIDER     = 0x00000001,
    VDS_OT_PACK         = 0x0000000a,
    VDS_OT_VOLUME       = 0x0000000b,
    VDS_OT_VOLUME_PLEX  = 0x0000000c,
    VDS_OT_DISK         = 0x0000000d,
    VDS_OT_SUB_SYSTEM   = 0x0000001e,
    VDS_OT_CONTROLLER   = 0x0000001f,
    VDS_OT_DRIVE        = 0x00000020,
    VDS_OT_LUN          = 0x00000021,
    VDS_OT_LUN_PLEX     = 0x00000022,
    VDS_OT_PORT         = 0x00000023,
    VDS_OT_PORTAL       = 0x00000024,
    VDS_OT_TARGET       = 0x00000025,
    VDS_OT_PORTAL_GROUP = 0x00000026,
    VDS_OT_STORAGE_POOL = 0x00000027,
    VDS_OT_HBAPORT      = 0x0000005a,
    VDS_OT_INIT_ADAPTER = 0x0000005b,
    VDS_OT_INIT_PORTAL  = 0x0000005c,
    VDS_OT_ASYNC        = 0x00000064,
    VDS_OT_ENUM         = 0x00000065,
    VDS_OT_VDISK        = 0x000000c8,
    VDS_OT_OPEN_VDISK   = 0x000000c9,
}
alias VDS_OBJECT_TYPE = int;

enum : int
{
    VDS_PT_UNKNOWN     = 0x00000000,
    VDS_PT_SOFTWARE    = 0x00000001,
    VDS_PT_HARDWARE    = 0x00000002,
    VDS_PT_VIRTUALDISK = 0x00000003,
    VDS_PT_MAX         = 0x00000004,
}
alias VDS_PROVIDER_TYPE = int;

enum : int
{
    VDS_PF_DYNAMIC                         = 0x00000001,
    VDS_PF_INTERNAL_HARDWARE_PROVIDER      = 0x00000002,
    VDS_PF_ONE_DISK_ONLY_PER_PACK          = 0x00000004,
    VDS_PF_ONE_PACK_ONLINE_ONLY            = 0x00000008,
    VDS_PF_VOLUME_SPACE_MUST_BE_CONTIGUOUS = 0x00000010,
    VDS_PF_SUPPORT_DYNAMIC                 = 0x80000000,
    VDS_PF_SUPPORT_FAULT_TOLERANT          = 0x40000000,
    VDS_PF_SUPPORT_DYNAMIC_1394            = 0x20000000,
    VDS_PF_SUPPORT_MIRROR                  = 0x00000020,
    VDS_PF_SUPPORT_RAID5                   = 0x00000040,
}
alias VDS_PROVIDER_FLAG = int;

enum : int
{
    VDS_RA_UNKNOWN = 0x00000000,
    VDS_RA_REFRESH = 0x00000001,
    VDS_RA_RESTART = 0x00000002,
}
alias VDS_RECOVER_ACTION = int;

enum : int
{
    VDS_NTT_UNKNOWN      = 0x00000000,
    VDS_NTT_PACK         = 0x0000000a,
    VDS_NTT_VOLUME       = 0x0000000b,
    VDS_NTT_DISK         = 0x0000000d,
    VDS_NTT_PARTITION    = 0x0000003c,
    VDS_NTT_DRIVE_LETTER = 0x0000003d,
    VDS_NTT_FILE_SYSTEM  = 0x0000003e,
    VDS_NTT_MOUNT_POINT  = 0x0000003f,
    VDS_NTT_SUB_SYSTEM   = 0x0000001e,
    VDS_NTT_CONTROLLER   = 0x0000001f,
    VDS_NTT_DRIVE        = 0x00000020,
    VDS_NTT_LUN          = 0x00000021,
    VDS_NTT_PORT         = 0x00000023,
    VDS_NTT_PORTAL       = 0x00000024,
    VDS_NTT_TARGET       = 0x00000025,
    VDS_NTT_PORTAL_GROUP = 0x00000026,
    VDS_NTT_SERVICE      = 0x000000c8,
}
alias VDS_NOTIFICATION_TARGET_TYPE = int;

enum : int
{
    VDS_ASYNCOUT_UNKNOWN           = 0x00000000,
    VDS_ASYNCOUT_CREATEVOLUME      = 0x00000001,
    VDS_ASYNCOUT_EXTENDVOLUME      = 0x00000002,
    VDS_ASYNCOUT_SHRINKVOLUME      = 0x00000003,
    VDS_ASYNCOUT_ADDVOLUMEPLEX     = 0x00000004,
    VDS_ASYNCOUT_BREAKVOLUMEPLEX   = 0x00000005,
    VDS_ASYNCOUT_REMOVEVOLUMEPLEX  = 0x00000006,
    VDS_ASYNCOUT_REPAIRVOLUMEPLEX  = 0x00000007,
    VDS_ASYNCOUT_RECOVERPACK       = 0x00000008,
    VDS_ASYNCOUT_REPLACEDISK       = 0x00000009,
    VDS_ASYNCOUT_CREATEPARTITION   = 0x0000000a,
    VDS_ASYNCOUT_CLEAN             = 0x0000000b,
    VDS_ASYNCOUT_CREATELUN         = 0x00000032,
    VDS_ASYNCOUT_ADDLUNPLEX        = 0x00000034,
    VDS_ASYNCOUT_REMOVELUNPLEX     = 0x00000035,
    VDS_ASYNCOUT_EXTENDLUN         = 0x00000036,
    VDS_ASYNCOUT_SHRINKLUN         = 0x00000037,
    VDS_ASYNCOUT_RECOVERLUN        = 0x00000038,
    VDS_ASYNCOUT_LOGINTOTARGET     = 0x0000003c,
    VDS_ASYNCOUT_LOGOUTFROMTARGET  = 0x0000003d,
    VDS_ASYNCOUT_CREATETARGET      = 0x0000003e,
    VDS_ASYNCOUT_CREATEPORTALGROUP = 0x0000003f,
    VDS_ASYNCOUT_DELETETARGET      = 0x00000040,
    VDS_ASYNCOUT_ADDPORTAL         = 0x00000041,
    VDS_ASYNCOUT_REMOVEPORTAL      = 0x00000042,
    VDS_ASYNCOUT_DELETEPORTALGROUP = 0x00000043,
    VDS_ASYNCOUT_FORMAT            = 0x00000065,
    VDS_ASYNCOUT_CREATE_VDISK      = 0x000000c8,
    VDS_ASYNCOUT_ATTACH_VDISK      = 0x000000c9,
    VDS_ASYNCOUT_COMPACT_VDISK     = 0x000000ca,
    VDS_ASYNCOUT_MERGE_VDISK       = 0x000000cb,
    VDS_ASYNCOUT_EXPAND_VDISK      = 0x000000cc,
}
alias VDS_ASYNC_OUTPUT_TYPE = int;

enum : int
{
    VDS_IPT_TEXT  = 0x00000000,
    VDS_IPT_IPV4  = 0x00000001,
    VDS_IPT_IPV6  = 0x00000002,
    VDS_IPT_EMPTY = 0x00000003,
}
alias VDS_IPADDRESS_TYPE = int;

enum : int
{
    VDS_H_UNKNOWN                   = 0x00000000,
    VDS_H_HEALTHY                   = 0x00000001,
    VDS_H_REBUILDING                = 0x00000002,
    VDS_H_STALE                     = 0x00000003,
    VDS_H_FAILING                   = 0x00000004,
    VDS_H_FAILING_REDUNDANCY        = 0x00000005,
    VDS_H_FAILED_REDUNDANCY         = 0x00000006,
    VDS_H_FAILED_REDUNDANCY_FAILING = 0x00000007,
    VDS_H_FAILED                    = 0x00000008,
    VDS_H_REPLACED                  = 0x00000009,
    VDS_H_PENDING_FAILURE           = 0x0000000a,
    VDS_H_DEGRADED                  = 0x0000000b,
}
alias VDS_HEALTH = int;

enum : int
{
    VDS_TS_UNKNOWN     = 0x00000000,
    VDS_TS_STABLE      = 0x00000001,
    VDS_TS_EXTENDING   = 0x00000002,
    VDS_TS_SHRINKING   = 0x00000003,
    VDS_TS_RECONFIGING = 0x00000004,
    VDS_TS_RESTRIPING  = 0x00000005,
}
alias VDS_TRANSITION_STATE = int;

enum : int
{
    VDS_FST_UNKNOWN = 0x00000000,
    VDS_FST_RAW     = 0x00000001,
    VDS_FST_FAT     = 0x00000002,
    VDS_FST_FAT32   = 0x00000003,
    VDS_FST_NTFS    = 0x00000004,
    VDS_FST_CDFS    = 0x00000005,
    VDS_FST_UDF     = 0x00000006,
    VDS_FST_EXFAT   = 0x00000007,
    VDS_FST_CSVFS   = 0x00000008,
    VDS_FST_REFS    = 0x00000009,
}
alias VDS_FILE_SYSTEM_TYPE = int;

enum : int
{
    VDS_HPT_UNKNOWN    = 0x00000001,
    VDS_HPT_OTHER      = 0x00000002,
    VDS_HPT_NOTPRESENT = 0x00000003,
    VDS_HPT_NPORT      = 0x00000005,
    VDS_HPT_NLPORT     = 0x00000006,
    VDS_HPT_FLPORT     = 0x00000007,
    VDS_HPT_FPORT      = 0x00000008,
    VDS_HPT_EPORT      = 0x00000009,
    VDS_HPT_GPORT      = 0x0000000a,
    VDS_HPT_LPORT      = 0x00000014,
    VDS_HPT_PTP        = 0x00000015,
}
alias VDS_HBAPORT_TYPE = int;

enum : int
{
    VDS_HPS_UNKNOWN     = 0x00000001,
    VDS_HPS_ONLINE      = 0x00000002,
    VDS_HPS_OFFLINE     = 0x00000003,
    VDS_HPS_BYPASSED    = 0x00000004,
    VDS_HPS_DIAGNOSTICS = 0x00000005,
    VDS_HPS_LINKDOWN    = 0x00000006,
    VDS_HPS_ERROR       = 0x00000007,
    VDS_HPS_LOOPBACK    = 0x00000008,
}
alias VDS_HBAPORT_STATUS = int;

enum : int
{
    VDS_HSF_UNKNOWN        = 0x00000000,
    VDS_HSF_1GBIT          = 0x00000001,
    VDS_HSF_2GBIT          = 0x00000002,
    VDS_HSF_10GBIT         = 0x00000004,
    VDS_HSF_4GBIT          = 0x00000008,
    VDS_HSF_NOT_NEGOTIATED = 0x00008000,
}
alias VDS_HBAPORT_SPEED_FLAG = int;

enum : int
{
    VDS_MPS_UNKNOWN = 0x00000000,
    VDS_MPS_ONLINE  = 0x00000001,
    VDS_MPS_FAILED  = 0x00000005,
    VDS_MPS_STANDBY = 0x00000007,
}
alias VDS_PATH_STATUS = int;

enum : int
{
    VDS_LBP_UNKNOWN                 = 0x00000000,
    VDS_LBP_FAILOVER                = 0x00000001,
    VDS_LBP_ROUND_ROBIN             = 0x00000002,
    VDS_LBP_ROUND_ROBIN_WITH_SUBSET = 0x00000003,
    VDS_LBP_DYN_LEAST_QUEUE_DEPTH   = 0x00000004,
    VDS_LBP_WEIGHTED_PATHS          = 0x00000005,
    VDS_LBP_LEAST_BLOCKS            = 0x00000006,
    VDS_LBP_VENDOR_SPECIFIC         = 0x00000007,
}
alias VDS_LOADBALANCE_POLICY_ENUM = int;

enum : int
{
    VDS_LBF_FAILOVER                = 0x00000001,
    VDS_LBF_ROUND_ROBIN             = 0x00000002,
    VDS_LBF_ROUND_ROBIN_WITH_SUBSET = 0x00000004,
    VDS_LBF_DYN_LEAST_QUEUE_DEPTH   = 0x00000008,
    VDS_LBF_WEIGHTED_PATHS          = 0x00000010,
    VDS_LBF_LEAST_BLOCKS            = 0x00000020,
    VDS_LBF_VENDOR_SPECIFIC         = 0x00000040,
}
alias VDS_PROVIDER_LBSUPPORT_FLAG = int;

enum : int
{
    VDS_VSF_1_0 = 0x00000001,
    VDS_VSF_1_1 = 0x00000002,
    VDS_VSF_2_0 = 0x00000004,
    VDS_VSF_2_1 = 0x00000008,
    VDS_VSF_3_0 = 0x00000010,
}
alias VDS_VERSION_SUPPORT_FLAG = int;

enum : int
{
    VDS_HWT_UNKNOWN       = 0x00000000,
    VDS_HWT_PCI_RAID      = 0x00000001,
    VDS_HWT_FIBRE_CHANNEL = 0x00000002,
    VDS_HWT_ISCSI         = 0x00000003,
    VDS_HWT_SAS           = 0x00000004,
    VDS_HWT_HYBRID        = 0x00000005,
}
alias VDS_HWPROVIDER_TYPE = int;

enum : int
{
    VDS_ILT_MANUAL     = 0x00000000,
    VDS_ILT_PERSISTENT = 0x00000001,
    VDS_ILT_BOOT       = 0x00000002,
}
alias VDS_ISCSI_LOGIN_TYPE = int;

enum : int
{
    VDS_IAT_NONE        = 0x00000000,
    VDS_IAT_CHAP        = 0x00000001,
    VDS_IAT_MUTUAL_CHAP = 0x00000002,
}
alias VDS_ISCSI_AUTH_TYPE = int;

enum : int
{
    VDS_IIF_VALID                    = 0x00000001,
    VDS_IIF_IKE                      = 0x00000002,
    VDS_IIF_MAIN_MODE                = 0x00000004,
    VDS_IIF_AGGRESSIVE_MODE          = 0x00000008,
    VDS_IIF_PFS_ENABLE               = 0x00000010,
    VDS_IIF_TRANSPORT_MODE_PREFERRED = 0x00000020,
    VDS_IIF_TUNNEL_MODE_PREFERRED    = 0x00000040,
}
alias VDS_ISCSI_IPSEC_FLAG = int;

enum : int
{
    VDS_ILF_REQUIRE_IPSEC     = 0x00000001,
    VDS_ILF_MULTIPATH_ENABLED = 0x00000002,
}
alias VDS_ISCSI_LOGIN_FLAG = int;

enum : int
{
    VDS_SSS_UNKNOWN           = 0x00000000,
    VDS_SSS_ONLINE            = 0x00000001,
    VDS_SSS_NOT_READY         = 0x00000002,
    VDS_SSS_OFFLINE           = 0x00000004,
    VDS_SSS_FAILED            = 0x00000005,
    VDS_SSS_PARTIALLY_MANAGED = 0x00000009,
}
alias VDS_SUB_SYSTEM_STATUS = int;

enum : int
{
    VDS_SF_LUN_MASKING_CAPABLE              = 0x00000001,
    VDS_SF_LUN_PLEXING_CAPABLE              = 0x00000002,
    VDS_SF_LUN_REMAPPING_CAPABLE            = 0x00000004,
    VDS_SF_DRIVE_EXTENT_CAPABLE             = 0x00000008,
    VDS_SF_HARDWARE_CHECKSUM_CAPABLE        = 0x00000010,
    VDS_SF_RADIUS_CAPABLE                   = 0x00000020,
    VDS_SF_READ_BACK_VERIFY_CAPABLE         = 0x00000040,
    VDS_SF_WRITE_THROUGH_CACHING_CAPABLE    = 0x00000080,
    VDS_SF_SUPPORTS_FAULT_TOLERANT_LUNS     = 0x00000200,
    VDS_SF_SUPPORTS_NON_FAULT_TOLERANT_LUNS = 0x00000400,
    VDS_SF_SUPPORTS_SIMPLE_LUNS             = 0x00000800,
    VDS_SF_SUPPORTS_SPAN_LUNS               = 0x00001000,
    VDS_SF_SUPPORTS_STRIPE_LUNS             = 0x00002000,
    VDS_SF_SUPPORTS_MIRROR_LUNS             = 0x00004000,
    VDS_SF_SUPPORTS_PARITY_LUNS             = 0x00008000,
    VDS_SF_SUPPORTS_AUTH_CHAP               = 0x00010000,
    VDS_SF_SUPPORTS_AUTH_MUTUAL_CHAP        = 0x00020000,
    VDS_SF_SUPPORTS_SIMPLE_TARGET_CONFIG    = 0x00040000,
    VDS_SF_SUPPORTS_LUN_NUMBER              = 0x00080000,
    VDS_SF_SUPPORTS_MIRRORED_CACHE          = 0x00100000,
    VDS_SF_READ_CACHING_CAPABLE             = 0x00200000,
    VDS_SF_WRITE_CACHING_CAPABLE            = 0x00400000,
    VDS_SF_MEDIA_SCAN_CAPABLE               = 0x00800000,
    VDS_SF_CONSISTENCY_CHECK_CAPABLE        = 0x01000000,
}
alias VDS_SUB_SYSTEM_FLAG = int;

enum : int
{
    VDS_SF_SUPPORTS_RAID2_LUNS  = 0x00000001,
    VDS_SF_SUPPORTS_RAID3_LUNS  = 0x00000002,
    VDS_SF_SUPPORTS_RAID4_LUNS  = 0x00000004,
    VDS_SF_SUPPORTS_RAID5_LUNS  = 0x00000008,
    VDS_SF_SUPPORTS_RAID6_LUNS  = 0x00000010,
    VDS_SF_SUPPORTS_RAID01_LUNS = 0x00000020,
    VDS_SF_SUPPORTS_RAID03_LUNS = 0x00000040,
    VDS_SF_SUPPORTS_RAID05_LUNS = 0x00000080,
    VDS_SF_SUPPORTS_RAID10_LUNS = 0x00000100,
    VDS_SF_SUPPORTS_RAID15_LUNS = 0x00000200,
    VDS_SF_SUPPORTS_RAID30_LUNS = 0x00000400,
    VDS_SF_SUPPORTS_RAID50_LUNS = 0x00000800,
    VDS_SF_SUPPORTS_RAID51_LUNS = 0x00001000,
    VDS_SF_SUPPORTS_RAID53_LUNS = 0x00002000,
    VDS_SF_SUPPORTS_RAID60_LUNS = 0x00004000,
    VDS_SF_SUPPORTS_RAID61_LUNS = 0x00008000,
}
alias VDS_SUB_SYSTEM_SUPPORTED_RAID_TYPE_FLAG = int;

enum : int
{
    VDS_ITF_PCI_RAID      = 0x00000001,
    VDS_ITF_FIBRE_CHANNEL = 0x00000002,
    VDS_ITF_ISCSI         = 0x00000004,
    VDS_ITF_SAS           = 0x00000008,
}
alias VDS_INTERCONNECT_FLAG = int;

enum : int
{
    VDS_CS_UNKNOWN   = 0x00000000,
    VDS_CS_ONLINE    = 0x00000001,
    VDS_CS_NOT_READY = 0x00000002,
    VDS_CS_OFFLINE   = 0x00000004,
    VDS_CS_FAILED    = 0x00000005,
    VDS_CS_REMOVED   = 0x00000008,
}
alias VDS_CONTROLLER_STATUS = int;

enum : int
{
    VDS_PRS_UNKNOWN   = 0x00000000,
    VDS_PRS_ONLINE    = 0x00000001,
    VDS_PRS_NOT_READY = 0x00000002,
    VDS_PRS_OFFLINE   = 0x00000004,
    VDS_PRS_FAILED    = 0x00000005,
    VDS_PRS_REMOVED   = 0x00000008,
}
alias VDS_PORT_STATUS = int;

enum : int
{
    VDS_DRS_UNKNOWN   = 0x00000000,
    VDS_DRS_ONLINE    = 0x00000001,
    VDS_DRS_NOT_READY = 0x00000002,
    VDS_DRS_OFFLINE   = 0x00000004,
    VDS_DRS_FAILED    = 0x00000005,
    VDS_DRS_REMOVED   = 0x00000008,
}
alias VDS_DRIVE_STATUS = int;

enum : int
{
    VDS_DRF_HOTSPARE         = 0x00000001,
    VDS_DRF_ASSIGNED         = 0x00000002,
    VDS_DRF_UNASSIGNED       = 0x00000004,
    VDS_DRF_HOTSPARE_IN_USE  = 0x00000008,
    VDS_DRF_HOTSPARE_STANDBY = 0x00000010,
}
alias VDS_DRIVE_FLAG = int;

enum : int
{
    VDS_LT_UNKNOWN            = 0x00000000,
    VDS_LT_DEFAULT            = 0x00000001,
    VDS_LT_FAULT_TOLERANT     = 0x00000002,
    VDS_LT_NON_FAULT_TOLERANT = 0x00000003,
    VDS_LT_SIMPLE             = 0x0000000a,
    VDS_LT_SPAN               = 0x0000000b,
    VDS_LT_STRIPE             = 0x0000000c,
    VDS_LT_MIRROR             = 0x0000000d,
    VDS_LT_PARITY             = 0x0000000e,
    VDS_LT_RAID2              = 0x0000000f,
    VDS_LT_RAID3              = 0x00000010,
    VDS_LT_RAID4              = 0x00000011,
    VDS_LT_RAID5              = 0x00000012,
    VDS_LT_RAID6              = 0x00000013,
    VDS_LT_RAID01             = 0x00000014,
    VDS_LT_RAID03             = 0x00000015,
    VDS_LT_RAID05             = 0x00000016,
    VDS_LT_RAID10             = 0x00000017,
    VDS_LT_RAID15             = 0x00000018,
    VDS_LT_RAID30             = 0x00000019,
    VDS_LT_RAID50             = 0x0000001a,
    VDS_LT_RAID51             = 0x0000001b,
    VDS_LT_RAID53             = 0x0000001c,
    VDS_LT_RAID60             = 0x0000001d,
    VDS_LT_RAID61             = 0x0000001e,
}
alias VDS_LUN_TYPE = int;

enum : int
{
    VDS_LS_UNKNOWN   = 0x00000000,
    VDS_LS_ONLINE    = 0x00000001,
    VDS_LS_NOT_READY = 0x00000002,
    VDS_LS_OFFLINE   = 0x00000004,
    VDS_LS_FAILED    = 0x00000005,
}
alias VDS_LUN_STATUS = int;

enum : int
{
    VDS_LF_LBN_REMAP_ENABLED             = 0x00000001,
    VDS_LF_READ_BACK_VERIFY_ENABLED      = 0x00000002,
    VDS_LF_WRITE_THROUGH_CACHING_ENABLED = 0x00000004,
    VDS_LF_HARDWARE_CHECKSUM_ENABLED     = 0x00000008,
    VDS_LF_READ_CACHE_ENABLED            = 0x00000010,
    VDS_LF_WRITE_CACHE_ENABLED           = 0x00000020,
    VDS_LF_MEDIA_SCAN_ENABLED            = 0x00000040,
    VDS_LF_CONSISTENCY_CHECK_ENABLED     = 0x00000080,
    VDS_LF_SNAPSHOT                      = 0x00000100,
}
alias VDS_LUN_FLAG = int;

enum : int
{
    VDS_LPT_UNKNOWN = 0x00000000,
    VDS_LPT_SIMPLE  = 0x0000000a,
    VDS_LPT_SPAN    = 0x0000000b,
    VDS_LPT_STRIPE  = 0x0000000c,
    VDS_LPT_PARITY  = 0x0000000e,
    VDS_LPT_RAID2   = 0x0000000f,
    VDS_LPT_RAID3   = 0x00000010,
    VDS_LPT_RAID4   = 0x00000011,
    VDS_LPT_RAID5   = 0x00000012,
    VDS_LPT_RAID6   = 0x00000013,
    VDS_LPT_RAID03  = 0x00000015,
    VDS_LPT_RAID05  = 0x00000016,
    VDS_LPT_RAID10  = 0x00000017,
    VDS_LPT_RAID15  = 0x00000018,
    VDS_LPT_RAID30  = 0x00000019,
    VDS_LPT_RAID50  = 0x0000001a,
    VDS_LPT_RAID53  = 0x0000001c,
    VDS_LPT_RAID60  = 0x0000001d,
}
alias VDS_LUN_PLEX_TYPE = int;

enum : int
{
    VDS_LPS_UNKNOWN   = 0x00000000,
    VDS_LPS_ONLINE    = 0x00000001,
    VDS_LPS_NOT_READY = 0x00000002,
    VDS_LPS_OFFLINE   = 0x00000004,
    VDS_LPS_FAILED    = 0x00000005,
}
alias VDS_LUN_PLEX_STATUS = int;

enum : int
{
    VDS_LPF_LBN_REMAP_ENABLED = 0x00000001,
}
alias VDS_LUN_PLEX_FLAG = int;

enum : int
{
    VDS_IPS_UNKNOWN   = 0x00000000,
    VDS_IPS_ONLINE    = 0x00000001,
    VDS_IPS_NOT_READY = 0x00000002,
    VDS_IPS_OFFLINE   = 0x00000004,
    VDS_IPS_FAILED    = 0x00000005,
}
alias VDS_ISCSI_PORTAL_STATUS = int;

enum : int
{
    VDS_SPS_UNKNOWN   = 0x00000000,
    VDS_SPS_ONLINE    = 0x00000001,
    VDS_SPS_NOT_READY = 0x00000002,
    VDS_SPS_OFFLINE   = 0x00000004,
}
alias VDS_STORAGE_POOL_STATUS = int;

enum : int
{
    VDS_SPT_UNKNOWN    = 0x00000000,
    VDS_SPT_PRIMORDIAL = 0x00000001,
    VDS_SPT_CONCRETE   = 0x00000002,
}
alias VDS_STORAGE_POOL_TYPE = int;

enum : int
{
    BlinkLight = 0x00000001,
    BeepAlarm  = 0x00000002,
    SpinDown   = 0x00000003,
    SpinUp     = 0x00000004,
    Ping       = 0x00000005,
}
alias VDS_MAINTENANCE_OPERATION = int;

enum : int
{
    VDS_RT_UNKNOWN = 0x00000000,
    VDS_RT_RAID0   = 0x0000000a,
    VDS_RT_RAID1   = 0x0000000b,
    VDS_RT_RAID2   = 0x0000000c,
    VDS_RT_RAID3   = 0x0000000d,
    VDS_RT_RAID4   = 0x0000000e,
    VDS_RT_RAID5   = 0x0000000f,
    VDS_RT_RAID6   = 0x00000010,
    VDS_RT_RAID01  = 0x00000011,
    VDS_RT_RAID03  = 0x00000012,
    VDS_RT_RAID05  = 0x00000013,
    VDS_RT_RAID10  = 0x00000014,
    VDS_RT_RAID15  = 0x00000015,
    VDS_RT_RAID30  = 0x00000016,
    VDS_RT_RAID50  = 0x00000017,
    VDS_RT_RAID51  = 0x00000018,
    VDS_RT_RAID53  = 0x00000019,
    VDS_RT_RAID60  = 0x0000001a,
    VDS_RT_RAID61  = 0x0000001b,
}
alias VDS_RAID_TYPE = int;

enum : int
{
    VSS_OBJECT_UNKNOWN      = 0x00000000,
    VSS_OBJECT_NONE         = 0x00000001,
    VSS_OBJECT_SNAPSHOT_SET = 0x00000002,
    VSS_OBJECT_SNAPSHOT     = 0x00000003,
    VSS_OBJECT_PROVIDER     = 0x00000004,
    VSS_OBJECT_TYPE_COUNT   = 0x00000005,
}
alias VSS_OBJECT_TYPE = int;

enum : int
{
    VSS_SS_UNKNOWN                    = 0x00000000,
    VSS_SS_PREPARING                  = 0x00000001,
    VSS_SS_PROCESSING_PREPARE         = 0x00000002,
    VSS_SS_PREPARED                   = 0x00000003,
    VSS_SS_PROCESSING_PRECOMMIT       = 0x00000004,
    VSS_SS_PRECOMMITTED               = 0x00000005,
    VSS_SS_PROCESSING_COMMIT          = 0x00000006,
    VSS_SS_COMMITTED                  = 0x00000007,
    VSS_SS_PROCESSING_POSTCOMMIT      = 0x00000008,
    VSS_SS_PROCESSING_PREFINALCOMMIT  = 0x00000009,
    VSS_SS_PREFINALCOMMITTED          = 0x0000000a,
    VSS_SS_PROCESSING_POSTFINALCOMMIT = 0x0000000b,
    VSS_SS_CREATED                    = 0x0000000c,
    VSS_SS_ABORTED                    = 0x0000000d,
    VSS_SS_DELETED                    = 0x0000000e,
    VSS_SS_POSTCOMMITTED              = 0x0000000f,
    VSS_SS_COUNT                      = 0x00000010,
}
alias VSS_SNAPSHOT_STATE = int;

enum : int
{
    VSS_VOLSNAP_ATTR_PERSISTENT           = 0x00000001,
    VSS_VOLSNAP_ATTR_NO_AUTORECOVERY      = 0x00000002,
    VSS_VOLSNAP_ATTR_CLIENT_ACCESSIBLE    = 0x00000004,
    VSS_VOLSNAP_ATTR_NO_AUTO_RELEASE      = 0x00000008,
    VSS_VOLSNAP_ATTR_NO_WRITERS           = 0x00000010,
    VSS_VOLSNAP_ATTR_TRANSPORTABLE        = 0x00000020,
    VSS_VOLSNAP_ATTR_NOT_SURFACED         = 0x00000040,
    VSS_VOLSNAP_ATTR_NOT_TRANSACTED       = 0x00000080,
    VSS_VOLSNAP_ATTR_HARDWARE_ASSISTED    = 0x00010000,
    VSS_VOLSNAP_ATTR_DIFFERENTIAL         = 0x00020000,
    VSS_VOLSNAP_ATTR_PLEX                 = 0x00040000,
    VSS_VOLSNAP_ATTR_IMPORTED             = 0x00080000,
    VSS_VOLSNAP_ATTR_EXPOSED_LOCALLY      = 0x00100000,
    VSS_VOLSNAP_ATTR_EXPOSED_REMOTELY     = 0x00200000,
    VSS_VOLSNAP_ATTR_AUTORECOVER          = 0x00400000,
    VSS_VOLSNAP_ATTR_ROLLBACK_RECOVERY    = 0x00800000,
    VSS_VOLSNAP_ATTR_DELAYED_POSTSNAPSHOT = 0x01000000,
    VSS_VOLSNAP_ATTR_TXF_RECOVERY         = 0x02000000,
    VSS_VOLSNAP_ATTR_FILE_SHARE           = 0x04000000,
}
alias VSS_VOLUME_SNAPSHOT_ATTRIBUTES = int;

enum : int
{
    VSS_CTX_BACKUP                    = 0x00000000,
    VSS_CTX_FILE_SHARE_BACKUP         = 0x00000010,
    VSS_CTX_NAS_ROLLBACK              = 0x00000019,
    VSS_CTX_APP_ROLLBACK              = 0x00000009,
    VSS_CTX_CLIENT_ACCESSIBLE         = 0x0000001d,
    VSS_CTX_CLIENT_ACCESSIBLE_WRITERS = 0x0000000d,
    VSS_CTX_ALL                       = 0xffffffff,
}
alias VSS_SNAPSHOT_CONTEXT = int;

enum : int
{
    VSS_PRV_CAPABILITY_LEGACY           = 0x00000001,
    VSS_PRV_CAPABILITY_COMPLIANT        = 0x00000002,
    VSS_PRV_CAPABILITY_LUN_REPOINT      = 0x00000004,
    VSS_PRV_CAPABILITY_LUN_RESYNC       = 0x00000008,
    VSS_PRV_CAPABILITY_OFFLINE_CREATION = 0x00000010,
    VSS_PRV_CAPABILITY_MULTIPLE_IMPORT  = 0x00000020,
    VSS_PRV_CAPABILITY_RECYCLING        = 0x00000040,
    VSS_PRV_CAPABILITY_PLEX             = 0x00000080,
    VSS_PRV_CAPABILITY_DIFFERENTIAL     = 0x00000100,
    VSS_PRV_CAPABILITY_CLUSTERED        = 0x00000200,
}
alias VSS_PROVIDER_CAPABILITIES = int;

enum : int
{
    VSS_BREAKEX_FLAG_MASK_LUNS                    = 0x00000001,
    VSS_BREAKEX_FLAG_MAKE_READ_WRITE              = 0x00000002,
    VSS_BREAKEX_FLAG_REVERT_IDENTITY_ALL          = 0x00000004,
    VSS_BREAKEX_FLAG_REVERT_IDENTITY_NONE         = 0x00000008,
    VSS_ONLUNSTATECHANGE_NOTIFY_READ_WRITE        = 0x00000100,
    VSS_ONLUNSTATECHANGE_NOTIFY_LUN_PRE_RECOVERY  = 0x00000200,
    VSS_ONLUNSTATECHANGE_NOTIFY_LUN_POST_RECOVERY = 0x00000400,
    VSS_ONLUNSTATECHANGE_DO_MASK_LUNS             = 0x00000800,
}
alias VSS_HARDWARE_OPTIONS = int;

enum : int
{
    VSS_RECOVERY_REVERT_IDENTITY_ALL = 0x00000100,
    VSS_RECOVERY_NO_VOLUME_CHECK     = 0x00000200,
}
alias VSS_RECOVERY_OPTIONS = int;

enum : int
{
    VSS_WS_UNKNOWN                     = 0x00000000,
    VSS_WS_STABLE                      = 0x00000001,
    VSS_WS_WAITING_FOR_FREEZE          = 0x00000002,
    VSS_WS_WAITING_FOR_THAW            = 0x00000003,
    VSS_WS_WAITING_FOR_POST_SNAPSHOT   = 0x00000004,
    VSS_WS_WAITING_FOR_BACKUP_COMPLETE = 0x00000005,
    VSS_WS_FAILED_AT_IDENTIFY          = 0x00000006,
    VSS_WS_FAILED_AT_PREPARE_BACKUP    = 0x00000007,
    VSS_WS_FAILED_AT_PREPARE_SNAPSHOT  = 0x00000008,
    VSS_WS_FAILED_AT_FREEZE            = 0x00000009,
    VSS_WS_FAILED_AT_THAW              = 0x0000000a,
    VSS_WS_FAILED_AT_POST_SNAPSHOT     = 0x0000000b,
    VSS_WS_FAILED_AT_BACKUP_COMPLETE   = 0x0000000c,
    VSS_WS_FAILED_AT_PRE_RESTORE       = 0x0000000d,
    VSS_WS_FAILED_AT_POST_RESTORE      = 0x0000000e,
    VSS_WS_FAILED_AT_BACKUPSHUTDOWN    = 0x0000000f,
    VSS_WS_COUNT                       = 0x00000010,
}
alias VSS_WRITER_STATE = int;

enum : int
{
    VSS_BT_UNDEFINED    = 0x00000000,
    VSS_BT_FULL         = 0x00000001,
    VSS_BT_INCREMENTAL  = 0x00000002,
    VSS_BT_DIFFERENTIAL = 0x00000003,
    VSS_BT_LOG          = 0x00000004,
    VSS_BT_COPY         = 0x00000005,
    VSS_BT_OTHER        = 0x00000006,
}
alias VSS_BACKUP_TYPE = int;

enum : int
{
    VSS_RTYPE_UNDEFINED = 0x00000000,
    VSS_RTYPE_BY_COPY   = 0x00000001,
    VSS_RTYPE_IMPORT    = 0x00000002,
    VSS_RTYPE_OTHER     = 0x00000003,
}
alias VSS_RESTORE_TYPE = int;

enum : int
{
    VSS_RF_UNDEFINED = 0x00000000,
    VSS_RF_NONE      = 0x00000001,
    VSS_RF_ALL       = 0x00000002,
    VSS_RF_PARTIAL   = 0x00000003,
}
alias VSS_ROLLFORWARD_TYPE = int;

enum : int
{
    VSS_PROV_UNKNOWN   = 0x00000000,
    VSS_PROV_SYSTEM    = 0x00000001,
    VSS_PROV_SOFTWARE  = 0x00000002,
    VSS_PROV_HARDWARE  = 0x00000003,
    VSS_PROV_FILESHARE = 0x00000004,
}
alias VSS_PROVIDER_TYPE = int;

enum : int
{
    VSS_APP_UNKNOWN   = 0x00000000,
    VSS_APP_SYSTEM    = 0x00000001,
    VSS_APP_BACK_END  = 0x00000002,
    VSS_APP_FRONT_END = 0x00000003,
    VSS_APP_SYSTEM_RM = 0x00000004,
    VSS_APP_AUTO      = 0xffffffff,
}
alias VSS_APPLICATION_LEVEL = int;

enum : int
{
    VSS_SC_DISABLE_DEFRAG       = 0x00000001,
    VSS_SC_DISABLE_CONTENTINDEX = 0x00000002,
}
alias VSS_SNAPSHOT_COMPATIBILITY = int;

enum : int
{
    VSS_SPROPID_UNKNOWN             = 0x00000000,
    VSS_SPROPID_SNAPSHOT_ID         = 0x00000001,
    VSS_SPROPID_SNAPSHOT_SET_ID     = 0x00000002,
    VSS_SPROPID_SNAPSHOTS_COUNT     = 0x00000003,
    VSS_SPROPID_SNAPSHOT_DEVICE     = 0x00000004,
    VSS_SPROPID_ORIGINAL_VOLUME     = 0x00000005,
    VSS_SPROPID_ORIGINATING_MACHINE = 0x00000006,
    VSS_SPROPID_SERVICE_MACHINE     = 0x00000007,
    VSS_SPROPID_EXPOSED_NAME        = 0x00000008,
    VSS_SPROPID_EXPOSED_PATH        = 0x00000009,
    VSS_SPROPID_PROVIDER_ID         = 0x0000000a,
    VSS_SPROPID_SNAPSHOT_ATTRIBUTES = 0x0000000b,
    VSS_SPROPID_CREATION_TIMESTAMP  = 0x0000000c,
    VSS_SPROPID_STATUS              = 0x0000000d,
}
alias VSS_SNAPSHOT_PROPERTY_ID = int;

enum : int
{
    VSS_FSBT_FULL_BACKUP_REQUIRED           = 0x00000001,
    VSS_FSBT_DIFFERENTIAL_BACKUP_REQUIRED   = 0x00000002,
    VSS_FSBT_INCREMENTAL_BACKUP_REQUIRED    = 0x00000004,
    VSS_FSBT_LOG_BACKUP_REQUIRED            = 0x00000008,
    VSS_FSBT_FULL_SNAPSHOT_REQUIRED         = 0x00000100,
    VSS_FSBT_DIFFERENTIAL_SNAPSHOT_REQUIRED = 0x00000200,
    VSS_FSBT_INCREMENTAL_SNAPSHOT_REQUIRED  = 0x00000400,
    VSS_FSBT_LOG_SNAPSHOT_REQUIRED          = 0x00000800,
    VSS_FSBT_CREATED_DURING_BACKUP          = 0x00010000,
    VSS_FSBT_ALL_BACKUP_REQUIRED            = 0x0000000f,
    VSS_FSBT_ALL_SNAPSHOT_REQUIRED          = 0x00000f00,
}
alias VSS_FILE_SPEC_BACKUP_TYPE = int;

enum : int
{
    VSS_BS_UNDEFINED                          = 0x00000000,
    VSS_BS_DIFFERENTIAL                       = 0x00000001,
    VSS_BS_INCREMENTAL                        = 0x00000002,
    VSS_BS_EXCLUSIVE_INCREMENTAL_DIFFERENTIAL = 0x00000004,
    VSS_BS_LOG                                = 0x00000008,
    VSS_BS_COPY                               = 0x00000010,
    VSS_BS_TIMESTAMPED                        = 0x00000020,
    VSS_BS_LAST_MODIFY                        = 0x00000040,
    VSS_BS_LSN                                = 0x00000080,
    VSS_BS_WRITER_SUPPORTS_NEW_TARGET         = 0x00000100,
    VSS_BS_WRITER_SUPPORTS_RESTORE_WITH_MOVE  = 0x00000200,
    VSS_BS_INDEPENDENT_SYSTEM_STATE           = 0x00000400,
    VSS_BS_ROLLFORWARD_RESTORE                = 0x00001000,
    VSS_BS_RESTORE_RENAME                     = 0x00002000,
    VSS_BS_AUTHORITATIVE_RESTORE              = 0x00004000,
    VSS_BS_WRITER_SUPPORTS_PARALLEL_RESTORES  = 0x00008000,
}
alias VSS_BACKUP_SCHEMA = int;

enum : int
{
    VSS_UT_UNDEFINED           = 0x00000000,
    VSS_UT_BOOTABLESYSTEMSTATE = 0x00000001,
    VSS_UT_SYSTEMSERVICE       = 0x00000002,
    VSS_UT_USERDATA            = 0x00000003,
    VSS_UT_OTHER               = 0x00000004,
}
alias VSS_USAGE_TYPE = int;

enum : int
{
    VSS_ST_UNDEFINED       = 0x00000000,
    VSS_ST_TRANSACTEDDB    = 0x00000001,
    VSS_ST_NONTRANSACTEDDB = 0x00000002,
    VSS_ST_OTHER           = 0x00000003,
}
alias VSS_SOURCE_TYPE = int;

enum : int
{
    VSS_RME_UNDEFINED                           = 0x00000000,
    VSS_RME_RESTORE_IF_NOT_THERE                = 0x00000001,
    VSS_RME_RESTORE_IF_CAN_REPLACE              = 0x00000002,
    VSS_RME_STOP_RESTORE_START                  = 0x00000003,
    VSS_RME_RESTORE_TO_ALTERNATE_LOCATION       = 0x00000004,
    VSS_RME_RESTORE_AT_REBOOT                   = 0x00000005,
    VSS_RME_RESTORE_AT_REBOOT_IF_CANNOT_REPLACE = 0x00000006,
    VSS_RME_CUSTOM                              = 0x00000007,
    VSS_RME_RESTORE_STOP_START                  = 0x00000008,
}
alias VSS_RESTOREMETHOD_ENUM = int;

enum : int
{
    VSS_WRE_UNDEFINED        = 0x00000000,
    VSS_WRE_NEVER            = 0x00000001,
    VSS_WRE_IF_REPLACE_FAILS = 0x00000002,
    VSS_WRE_ALWAYS           = 0x00000003,
}
alias VSS_WRITERRESTORE_ENUM = int;

enum : int
{
    VSS_CT_UNDEFINED = 0x00000000,
    VSS_CT_DATABASE  = 0x00000001,
    VSS_CT_FILEGROUP = 0x00000002,
}
alias VSS_COMPONENT_TYPE = int;

enum : int
{
    VSS_AWS_UNDEFINED                = 0x00000000,
    VSS_AWS_NO_ALTERNATE_WRITER      = 0x00000001,
    VSS_AWS_ALTERNATE_WRITER_EXISTS  = 0x00000002,
    VSS_AWS_THIS_IS_ALTERNATE_WRITER = 0x00000003,
}
alias VSS_ALTERNATE_WRITER_STATE = int;

enum : int
{
    VSS_SM_POST_SNAPSHOT_FLAG  = 0x00000001,
    VSS_SM_BACKUP_EVENTS_FLAG  = 0x00000002,
    VSS_SM_RESTORE_EVENTS_FLAG = 0x00000004,
    VSS_SM_IO_THROTTLING_FLAG  = 0x00000008,
    VSS_SM_ALL_FLAGS           = 0xffffffff,
}
alias VSS_SUBSCRIBE_MASK = int;

enum : int
{
    VSS_RT_UNDEFINED         = 0x00000000,
    VSS_RT_ORIGINAL          = 0x00000001,
    VSS_RT_ALTERNATE         = 0x00000002,
    VSS_RT_DIRECTED          = 0x00000003,
    VSS_RT_ORIGINAL_LOCATION = 0x00000004,
}
alias VSS_RESTORE_TARGET = int;

enum : int
{
    VSS_RS_UNDEFINED = 0x00000000,
    VSS_RS_NONE      = 0x00000001,
    VSS_RS_ALL       = 0x00000002,
    VSS_RS_FAILED    = 0x00000003,
}
alias VSS_FILE_RESTORE_STATUS = int;

enum : int
{
    VSS_CF_BACKUP_RECOVERY       = 0x00000001,
    VSS_CF_APP_ROLLBACK_RECOVERY = 0x00000002,
    VSS_CF_NOT_SYSTEM_STATE      = 0x00000004,
}
alias VSS_COMPONENT_FLAGS = int;

enum : int
{
    VSS_MGMT_OBJECT_UNKNOWN     = 0x00000000,
    VSS_MGMT_OBJECT_VOLUME      = 0x00000001,
    VSS_MGMT_OBJECT_DIFF_VOLUME = 0x00000002,
    VSS_MGMT_OBJECT_DIFF_AREA   = 0x00000003,
}
alias VSS_MGMT_OBJECT_TYPE = int;

enum : int
{
    VSS_PROTECTION_LEVEL_ORIGINAL_VOLUME = 0x00000000,
    VSS_PROTECTION_LEVEL_SNAPSHOT        = 0x00000001,
}
alias VSS_PROTECTION_LEVEL = int;

enum : int
{
    VSS_PROTECTION_FAULT_NONE                         = 0x00000000,
    VSS_PROTECTION_FAULT_DIFF_AREA_MISSING            = 0x00000001,
    VSS_PROTECTION_FAULT_IO_FAILURE_DURING_ONLINE     = 0x00000002,
    VSS_PROTECTION_FAULT_META_DATA_CORRUPTION         = 0x00000003,
    VSS_PROTECTION_FAULT_MEMORY_ALLOCATION_FAILURE    = 0x00000004,
    VSS_PROTECTION_FAULT_MAPPED_MEMORY_FAILURE        = 0x00000005,
    VSS_PROTECTION_FAULT_COW_READ_FAILURE             = 0x00000006,
    VSS_PROTECTION_FAULT_COW_WRITE_FAILURE            = 0x00000007,
    VSS_PROTECTION_FAULT_DIFF_AREA_FULL               = 0x00000008,
    VSS_PROTECTION_FAULT_GROW_TOO_SLOW                = 0x00000009,
    VSS_PROTECTION_FAULT_GROW_FAILED                  = 0x0000000a,
    VSS_PROTECTION_FAULT_DESTROY_ALL_SNAPSHOTS        = 0x0000000b,
    VSS_PROTECTION_FAULT_FILE_SYSTEM_FAILURE          = 0x0000000c,
    VSS_PROTECTION_FAULT_IO_FAILURE                   = 0x0000000d,
    VSS_PROTECTION_FAULT_DIFF_AREA_REMOVED            = 0x0000000e,
    VSS_PROTECTION_FAULT_EXTERNAL_WRITER_TO_DIFF_AREA = 0x0000000f,
    VSS_PROTECTION_FAULT_MOUNT_DURING_CLUSTER_OFFLINE = 0x00000010,
}
alias VSS_PROTECTION_FAULT = int;

enum : int
{
    D3DLIGHT_POINT         = 0x00000001,
    D3DLIGHT_SPOT          = 0x00000002,
    D3DLIGHT_DIRECTIONAL   = 0x00000003,
    D3DLIGHT_PARALLELPOINT = 0x00000004,
    D3DLIGHT_FORCE_DWORD   = 0x7fffffff,
}
alias D3DLIGHTTYPE = int;

enum : int
{
    D3DOP_POINT           = 0x00000001,
    D3DOP_LINE            = 0x00000002,
    D3DOP_TRIANGLE        = 0x00000003,
    D3DOP_MATRIXLOAD      = 0x00000004,
    D3DOP_MATRIXMULTIPLY  = 0x00000005,
    D3DOP_STATETRANSFORM  = 0x00000006,
    D3DOP_STATELIGHT      = 0x00000007,
    D3DOP_STATERENDER     = 0x00000008,
    D3DOP_PROCESSVERTICES = 0x00000009,
    D3DOP_TEXTURELOAD     = 0x0000000a,
    D3DOP_EXIT            = 0x0000000b,
    D3DOP_BRANCHFORWARD   = 0x0000000c,
    D3DOP_SPAN            = 0x0000000d,
    D3DOP_SETSTATUS       = 0x0000000e,
    D3DOP_FORCE_DWORD     = 0x7fffffff,
}
alias D3DOPCODE = int;

enum : int
{
    D3DSHADE_FLAT        = 0x00000001,
    D3DSHADE_GOURAUD     = 0x00000002,
    D3DSHADE_PHONG       = 0x00000003,
    D3DSHADE_FORCE_DWORD = 0x7fffffff,
}
alias D3DSHADEMODE = int;

enum : int
{
    D3DFILL_POINT       = 0x00000001,
    D3DFILL_WIREFRAME   = 0x00000002,
    D3DFILL_SOLID       = 0x00000003,
    D3DFILL_FORCE_DWORD = 0x7fffffff,
}
alias D3DFILLMODE = int;

enum : int
{
    D3DFILTER_NEAREST          = 0x00000001,
    D3DFILTER_LINEAR           = 0x00000002,
    D3DFILTER_MIPNEAREST       = 0x00000003,
    D3DFILTER_MIPLINEAR        = 0x00000004,
    D3DFILTER_LINEARMIPNEAREST = 0x00000005,
    D3DFILTER_LINEARMIPLINEAR  = 0x00000006,
    D3DFILTER_FORCE_DWORD      = 0x7fffffff,
}
alias D3DTEXTUREFILTER = int;

enum : uint
{
    D3DBLEND_ZERO            = 0x00000001,
    D3DBLEND_ONE             = 0x00000002,
    D3DBLEND_SRCCOLOR        = 0x00000003,
    D3DBLEND_INVSRCCOLOR     = 0x00000004,
    D3DBLEND_SRCALPHA        = 0x00000005,
    D3DBLEND_INVSRCALPHA     = 0x00000006,
    D3DBLEND_DESTALPHA       = 0x00000007,
    D3DBLEND_INVDESTALPHA    = 0x00000008,
    D3DBLEND_DESTCOLOR       = 0x00000009,
    D3DBLEND_INVDESTCOLOR    = 0x0000000a,
    D3DBLEND_SRCALPHASAT     = 0x0000000b,
    D3DBLEND_BOTHSRCALPHA    = 0x0000000c,
    D3DBLEND_BOTHINVSRCALPHA = 0x0000000d,
    D3DBLEND_FORCE_DWORD     = 0x7fffffff,
}
alias D3DBLEND = uint;

enum : int
{
    D3DTBLEND_DECAL         = 0x00000001,
    D3DTBLEND_MODULATE      = 0x00000002,
    D3DTBLEND_DECALALPHA    = 0x00000003,
    D3DTBLEND_MODULATEALPHA = 0x00000004,
    D3DTBLEND_DECALMASK     = 0x00000005,
    D3DTBLEND_MODULATEMASK  = 0x00000006,
    D3DTBLEND_COPY          = 0x00000007,
    D3DTBLEND_ADD           = 0x00000008,
    D3DTBLEND_FORCE_DWORD   = 0x7fffffff,
}
alias D3DTEXTUREBLEND = int;

enum : int
{
    D3DTADDRESS_WRAP        = 0x00000001,
    D3DTADDRESS_MIRROR      = 0x00000002,
    D3DTADDRESS_CLAMP       = 0x00000003,
    D3DTADDRESS_BORDER      = 0x00000004,
    D3DTADDRESS_FORCE_DWORD = 0x7fffffff,
}
alias D3DTEXTUREADDRESS = int;

enum : uint
{
    D3DCULL_NONE        = 0x00000001,
    D3DCULL_CW          = 0x00000002,
    D3DCULL_CCW         = 0x00000003,
    D3DCULL_FORCE_DWORD = 0x7fffffff,
}
alias D3DCULL = uint;

enum : int
{
    D3DCMP_NEVER        = 0x00000001,
    D3DCMP_LESS         = 0x00000002,
    D3DCMP_EQUAL        = 0x00000003,
    D3DCMP_LESSEQUAL    = 0x00000004,
    D3DCMP_GREATER      = 0x00000005,
    D3DCMP_NOTEQUAL     = 0x00000006,
    D3DCMP_GREATEREQUAL = 0x00000007,
    D3DCMP_ALWAYS       = 0x00000008,
    D3DCMP_FORCE_DWORD  = 0x7fffffff,
}
alias D3DCMPFUNC = int;

enum : uint
{
    D3DSTENCILOP_KEEP        = 0x00000001,
    D3DSTENCILOP_ZERO        = 0x00000002,
    D3DSTENCILOP_REPLACE     = 0x00000003,
    D3DSTENCILOP_INCRSAT     = 0x00000004,
    D3DSTENCILOP_DECRSAT     = 0x00000005,
    D3DSTENCILOP_INVERT      = 0x00000006,
    D3DSTENCILOP_INCR        = 0x00000007,
    D3DSTENCILOP_DECR        = 0x00000008,
    D3DSTENCILOP_FORCE_DWORD = 0x7fffffff,
}
alias D3DSTENCILOP = uint;

enum : int
{
    D3DFOG_NONE        = 0x00000000,
    D3DFOG_EXP         = 0x00000001,
    D3DFOG_EXP2        = 0x00000002,
    D3DFOG_LINEAR      = 0x00000003,
    D3DFOG_FORCE_DWORD = 0x7fffffff,
}
alias D3DFOGMODE = int;

enum : int
{
    D3DZB_FALSE       = 0x00000000,
    D3DZB_TRUE        = 0x00000001,
    D3DZB_USEW        = 0x00000002,
    D3DZB_FORCE_DWORD = 0x7fffffff,
}
alias D3DZBUFFERTYPE = int;

enum : int
{
    D3DANTIALIAS_NONE            = 0x00000000,
    D3DANTIALIAS_SORTDEPENDENT   = 0x00000001,
    D3DANTIALIAS_SORTINDEPENDENT = 0x00000002,
    D3DANTIALIAS_FORCE_DWORD     = 0x7fffffff,
}
alias D3DANTIALIASMODE = int;

enum : int
{
    D3DVT_VERTEX      = 0x00000001,
    D3DVT_LVERTEX     = 0x00000002,
    D3DVT_TLVERTEX    = 0x00000003,
    D3DVT_FORCE_DWORD = 0x7fffffff,
}
alias D3DVERTEXTYPE = int;

enum : int
{
    D3DPT_POINTLIST     = 0x00000001,
    D3DPT_LINELIST      = 0x00000002,
    D3DPT_LINESTRIP     = 0x00000003,
    D3DPT_TRIANGLELIST  = 0x00000004,
    D3DPT_TRIANGLESTRIP = 0x00000005,
    D3DPT_TRIANGLEFAN   = 0x00000006,
    D3DPT_FORCE_DWORD   = 0x7fffffff,
}
alias D3DPRIMITIVETYPE = int;

enum : int
{
    D3DTRANSFORMSTATE_WORLD       = 0x00000001,
    D3DTRANSFORMSTATE_VIEW        = 0x00000002,
    D3DTRANSFORMSTATE_PROJECTION  = 0x00000003,
    D3DTRANSFORMSTATE_WORLD1      = 0x00000004,
    D3DTRANSFORMSTATE_WORLD2      = 0x00000005,
    D3DTRANSFORMSTATE_WORLD3      = 0x00000006,
    D3DTRANSFORMSTATE_TEXTURE0    = 0x00000010,
    D3DTRANSFORMSTATE_TEXTURE1    = 0x00000011,
    D3DTRANSFORMSTATE_TEXTURE2    = 0x00000012,
    D3DTRANSFORMSTATE_TEXTURE3    = 0x00000013,
    D3DTRANSFORMSTATE_TEXTURE4    = 0x00000014,
    D3DTRANSFORMSTATE_TEXTURE5    = 0x00000015,
    D3DTRANSFORMSTATE_TEXTURE6    = 0x00000016,
    D3DTRANSFORMSTATE_TEXTURE7    = 0x00000017,
    D3DTRANSFORMSTATE_FORCE_DWORD = 0x7fffffff,
}
alias D3DTRANSFORMSTATETYPE = int;

enum : int
{
    D3DLIGHTSTATE_MATERIAL    = 0x00000001,
    D3DLIGHTSTATE_AMBIENT     = 0x00000002,
    D3DLIGHTSTATE_COLORMODEL  = 0x00000003,
    D3DLIGHTSTATE_FOGMODE     = 0x00000004,
    D3DLIGHTSTATE_FOGSTART    = 0x00000005,
    D3DLIGHTSTATE_FOGEND      = 0x00000006,
    D3DLIGHTSTATE_FOGDENSITY  = 0x00000007,
    D3DLIGHTSTATE_COLORVERTEX = 0x00000008,
    D3DLIGHTSTATE_FORCE_DWORD = 0x7fffffff,
}
alias D3DLIGHTSTATETYPE = int;

enum : int
{
    D3DRENDERSTATE_ANTIALIAS                  = 0x00000002,
    D3DRENDERSTATE_TEXTUREPERSPECTIVE         = 0x00000004,
    D3DRENDERSTATE_ZENABLE                    = 0x00000007,
    D3DRENDERSTATE_FILLMODE                   = 0x00000008,
    D3DRENDERSTATE_SHADEMODE                  = 0x00000009,
    D3DRENDERSTATE_LINEPATTERN                = 0x0000000a,
    D3DRENDERSTATE_ZWRITEENABLE               = 0x0000000e,
    D3DRENDERSTATE_ALPHATESTENABLE            = 0x0000000f,
    D3DRENDERSTATE_LASTPIXEL                  = 0x00000010,
    D3DRENDERSTATE_SRCBLEND                   = 0x00000013,
    D3DRENDERSTATE_DESTBLEND                  = 0x00000014,
    D3DRENDERSTATE_CULLMODE                   = 0x00000016,
    D3DRENDERSTATE_ZFUNC                      = 0x00000017,
    D3DRENDERSTATE_ALPHAREF                   = 0x00000018,
    D3DRENDERSTATE_ALPHAFUNC                  = 0x00000019,
    D3DRENDERSTATE_DITHERENABLE               = 0x0000001a,
    D3DRENDERSTATE_ALPHABLENDENABLE           = 0x0000001b,
    D3DRENDERSTATE_FOGENABLE                  = 0x0000001c,
    D3DRENDERSTATE_SPECULARENABLE             = 0x0000001d,
    D3DRENDERSTATE_ZVISIBLE                   = 0x0000001e,
    D3DRENDERSTATE_STIPPLEDALPHA              = 0x00000021,
    D3DRENDERSTATE_FOGCOLOR                   = 0x00000022,
    D3DRENDERSTATE_FOGTABLEMODE               = 0x00000023,
    D3DRENDERSTATE_FOGSTART                   = 0x00000024,
    D3DRENDERSTATE_FOGEND                     = 0x00000025,
    D3DRENDERSTATE_FOGDENSITY                 = 0x00000026,
    D3DRENDERSTATE_EDGEANTIALIAS              = 0x00000028,
    D3DRENDERSTATE_COLORKEYENABLE             = 0x00000029,
    D3DRENDERSTATE_ZBIAS                      = 0x0000002f,
    D3DRENDERSTATE_RANGEFOGENABLE             = 0x00000030,
    D3DRENDERSTATE_STENCILENABLE              = 0x00000034,
    D3DRENDERSTATE_STENCILFAIL                = 0x00000035,
    D3DRENDERSTATE_STENCILZFAIL               = 0x00000036,
    D3DRENDERSTATE_STENCILPASS                = 0x00000037,
    D3DRENDERSTATE_STENCILFUNC                = 0x00000038,
    D3DRENDERSTATE_STENCILREF                 = 0x00000039,
    D3DRENDERSTATE_STENCILMASK                = 0x0000003a,
    D3DRENDERSTATE_STENCILWRITEMASK           = 0x0000003b,
    D3DRENDERSTATE_TEXTUREFACTOR              = 0x0000003c,
    D3DRENDERSTATE_WRAP0                      = 0x00000080,
    D3DRENDERSTATE_WRAP1                      = 0x00000081,
    D3DRENDERSTATE_WRAP2                      = 0x00000082,
    D3DRENDERSTATE_WRAP3                      = 0x00000083,
    D3DRENDERSTATE_WRAP4                      = 0x00000084,
    D3DRENDERSTATE_WRAP5                      = 0x00000085,
    D3DRENDERSTATE_WRAP6                      = 0x00000086,
    D3DRENDERSTATE_WRAP7                      = 0x00000087,
    D3DRENDERSTATE_CLIPPING                   = 0x00000088,
    D3DRENDERSTATE_LIGHTING                   = 0x00000089,
    D3DRENDERSTATE_EXTENTS                    = 0x0000008a,
    D3DRENDERSTATE_AMBIENT                    = 0x0000008b,
    D3DRENDERSTATE_FOGVERTEXMODE              = 0x0000008c,
    D3DRENDERSTATE_COLORVERTEX                = 0x0000008d,
    D3DRENDERSTATE_LOCALVIEWER                = 0x0000008e,
    D3DRENDERSTATE_NORMALIZENORMALS           = 0x0000008f,
    D3DRENDERSTATE_COLORKEYBLENDENABLE        = 0x00000090,
    D3DRENDERSTATE_DIFFUSEMATERIALSOURCE      = 0x00000091,
    D3DRENDERSTATE_SPECULARMATERIALSOURCE     = 0x00000092,
    D3DRENDERSTATE_AMBIENTMATERIALSOURCE      = 0x00000093,
    D3DRENDERSTATE_EMISSIVEMATERIALSOURCE     = 0x00000094,
    D3DRENDERSTATE_VERTEXBLEND                = 0x00000097,
    D3DRENDERSTATE_CLIPPLANEENABLE            = 0x00000098,
    D3DRENDERSTATE_TEXTUREHANDLE              = 0x00000001,
    D3DRENDERSTATE_TEXTUREADDRESS             = 0x00000003,
    D3DRENDERSTATE_WRAPU                      = 0x00000005,
    D3DRENDERSTATE_WRAPV                      = 0x00000006,
    D3DRENDERSTATE_MONOENABLE                 = 0x0000000b,
    D3DRENDERSTATE_ROP2                       = 0x0000000c,
    D3DRENDERSTATE_PLANEMASK                  = 0x0000000d,
    D3DRENDERSTATE_TEXTUREMAG                 = 0x00000011,
    D3DRENDERSTATE_TEXTUREMIN                 = 0x00000012,
    D3DRENDERSTATE_TEXTUREMAPBLEND            = 0x00000015,
    D3DRENDERSTATE_SUBPIXEL                   = 0x0000001f,
    D3DRENDERSTATE_SUBPIXELX                  = 0x00000020,
    D3DRENDERSTATE_STIPPLEENABLE              = 0x00000027,
    D3DRENDERSTATE_BORDERCOLOR                = 0x0000002b,
    D3DRENDERSTATE_TEXTUREADDRESSU            = 0x0000002c,
    D3DRENDERSTATE_TEXTUREADDRESSV            = 0x0000002d,
    D3DRENDERSTATE_MIPMAPLODBIAS              = 0x0000002e,
    D3DRENDERSTATE_ANISOTROPY                 = 0x00000031,
    D3DRENDERSTATE_FLUSHBATCH                 = 0x00000032,
    D3DRENDERSTATE_TRANSLUCENTSORTINDEPENDENT = 0x00000033,
    D3DRENDERSTATE_STIPPLEPATTERN00           = 0x00000040,
    D3DRENDERSTATE_STIPPLEPATTERN01           = 0x00000041,
    D3DRENDERSTATE_STIPPLEPATTERN02           = 0x00000042,
    D3DRENDERSTATE_STIPPLEPATTERN03           = 0x00000043,
    D3DRENDERSTATE_STIPPLEPATTERN04           = 0x00000044,
    D3DRENDERSTATE_STIPPLEPATTERN05           = 0x00000045,
    D3DRENDERSTATE_STIPPLEPATTERN06           = 0x00000046,
    D3DRENDERSTATE_STIPPLEPATTERN07           = 0x00000047,
    D3DRENDERSTATE_STIPPLEPATTERN08           = 0x00000048,
    D3DRENDERSTATE_STIPPLEPATTERN09           = 0x00000049,
    D3DRENDERSTATE_STIPPLEPATTERN10           = 0x0000004a,
    D3DRENDERSTATE_STIPPLEPATTERN11           = 0x0000004b,
    D3DRENDERSTATE_STIPPLEPATTERN12           = 0x0000004c,
    D3DRENDERSTATE_STIPPLEPATTERN13           = 0x0000004d,
    D3DRENDERSTATE_STIPPLEPATTERN14           = 0x0000004e,
    D3DRENDERSTATE_STIPPLEPATTERN15           = 0x0000004f,
    D3DRENDERSTATE_STIPPLEPATTERN16           = 0x00000050,
    D3DRENDERSTATE_STIPPLEPATTERN17           = 0x00000051,
    D3DRENDERSTATE_STIPPLEPATTERN18           = 0x00000052,
    D3DRENDERSTATE_STIPPLEPATTERN19           = 0x00000053,
    D3DRENDERSTATE_STIPPLEPATTERN20           = 0x00000054,
    D3DRENDERSTATE_STIPPLEPATTERN21           = 0x00000055,
    D3DRENDERSTATE_STIPPLEPATTERN22           = 0x00000056,
    D3DRENDERSTATE_STIPPLEPATTERN23           = 0x00000057,
    D3DRENDERSTATE_STIPPLEPATTERN24           = 0x00000058,
    D3DRENDERSTATE_STIPPLEPATTERN25           = 0x00000059,
    D3DRENDERSTATE_STIPPLEPATTERN26           = 0x0000005a,
    D3DRENDERSTATE_STIPPLEPATTERN27           = 0x0000005b,
    D3DRENDERSTATE_STIPPLEPATTERN28           = 0x0000005c,
    D3DRENDERSTATE_STIPPLEPATTERN29           = 0x0000005d,
    D3DRENDERSTATE_STIPPLEPATTERN30           = 0x0000005e,
    D3DRENDERSTATE_STIPPLEPATTERN31           = 0x0000005f,
    D3DRENDERSTATE_FOGTABLESTART              = 0x00000024,
    D3DRENDERSTATE_FOGTABLEEND                = 0x00000025,
    D3DRENDERSTATE_FOGTABLEDENSITY            = 0x00000026,
    D3DRENDERSTATE_FORCE_DWORD                = 0x7fffffff,
}
alias D3DRENDERSTATETYPE = int;

enum : int
{
    D3DMCS_MATERIAL    = 0x00000000,
    D3DMCS_COLOR1      = 0x00000001,
    D3DMCS_COLOR2      = 0x00000002,
    D3DMCS_FORCE_DWORD = 0x7fffffff,
}
alias D3DMATERIALCOLORSOURCE = int;

enum : int
{
    D3DTSS_COLOROP               = 0x00000001,
    D3DTSS_COLORARG1             = 0x00000002,
    D3DTSS_COLORARG2             = 0x00000003,
    D3DTSS_ALPHAOP               = 0x00000004,
    D3DTSS_ALPHAARG1             = 0x00000005,
    D3DTSS_ALPHAARG2             = 0x00000006,
    D3DTSS_BUMPENVMAT00          = 0x00000007,
    D3DTSS_BUMPENVMAT01          = 0x00000008,
    D3DTSS_BUMPENVMAT10          = 0x00000009,
    D3DTSS_BUMPENVMAT11          = 0x0000000a,
    D3DTSS_TEXCOORDINDEX         = 0x0000000b,
    D3DTSS_ADDRESS               = 0x0000000c,
    D3DTSS_ADDRESSU              = 0x0000000d,
    D3DTSS_ADDRESSV              = 0x0000000e,
    D3DTSS_BORDERCOLOR           = 0x0000000f,
    D3DTSS_MAGFILTER             = 0x00000010,
    D3DTSS_MINFILTER             = 0x00000011,
    D3DTSS_MIPFILTER             = 0x00000012,
    D3DTSS_MIPMAPLODBIAS         = 0x00000013,
    D3DTSS_MAXMIPLEVEL           = 0x00000014,
    D3DTSS_MAXANISOTROPY         = 0x00000015,
    D3DTSS_BUMPENVLSCALE         = 0x00000016,
    D3DTSS_BUMPENVLOFFSET        = 0x00000017,
    D3DTSS_TEXTURETRANSFORMFLAGS = 0x00000018,
    D3DTSS_FORCE_DWORD           = 0x7fffffff,
}
alias D3DTEXTURESTAGESTATETYPE = int;

enum : int
{
    D3DTOP_DISABLE                   = 0x00000001,
    D3DTOP_SELECTARG1                = 0x00000002,
    D3DTOP_SELECTARG2                = 0x00000003,
    D3DTOP_MODULATE                  = 0x00000004,
    D3DTOP_MODULATE2X                = 0x00000005,
    D3DTOP_MODULATE4X                = 0x00000006,
    D3DTOP_ADD                       = 0x00000007,
    D3DTOP_ADDSIGNED                 = 0x00000008,
    D3DTOP_ADDSIGNED2X               = 0x00000009,
    D3DTOP_SUBTRACT                  = 0x0000000a,
    D3DTOP_ADDSMOOTH                 = 0x0000000b,
    D3DTOP_BLENDDIFFUSEALPHA         = 0x0000000c,
    D3DTOP_BLENDTEXTUREALPHA         = 0x0000000d,
    D3DTOP_BLENDFACTORALPHA          = 0x0000000e,
    D3DTOP_BLENDTEXTUREALPHAPM       = 0x0000000f,
    D3DTOP_BLENDCURRENTALPHA         = 0x00000010,
    D3DTOP_PREMODULATE               = 0x00000011,
    D3DTOP_MODULATEALPHA_ADDCOLOR    = 0x00000012,
    D3DTOP_MODULATECOLOR_ADDALPHA    = 0x00000013,
    D3DTOP_MODULATEINVALPHA_ADDCOLOR = 0x00000014,
    D3DTOP_MODULATEINVCOLOR_ADDALPHA = 0x00000015,
    D3DTOP_BUMPENVMAP                = 0x00000016,
    D3DTOP_BUMPENVMAPLUMINANCE       = 0x00000017,
    D3DTOP_DOTPRODUCT3               = 0x00000018,
    D3DTOP_FORCE_DWORD               = 0x7fffffff,
}
alias D3DTEXTUREOP = int;

enum : int
{
    D3DTFG_POINT         = 0x00000001,
    D3DTFG_LINEAR        = 0x00000002,
    D3DTFG_FLATCUBIC     = 0x00000003,
    D3DTFG_GAUSSIANCUBIC = 0x00000004,
    D3DTFG_ANISOTROPIC   = 0x00000005,
    D3DTFG_FORCE_DWORD   = 0x7fffffff,
}
alias D3DTEXTUREMAGFILTER = int;

enum : int
{
    D3DTFN_POINT       = 0x00000001,
    D3DTFN_LINEAR      = 0x00000002,
    D3DTFN_ANISOTROPIC = 0x00000003,
    D3DTFN_FORCE_DWORD = 0x7fffffff,
}
alias D3DTEXTUREMINFILTER = int;

enum : int
{
    D3DTFP_NONE        = 0x00000001,
    D3DTFP_POINT       = 0x00000002,
    D3DTFP_LINEAR      = 0x00000003,
    D3DTFP_FORCE_DWORD = 0x7fffffff,
}
alias D3DTEXTUREMIPFILTER = int;

enum : int
{
    D3DSBT_ALL         = 0x00000001,
    D3DSBT_PIXELSTATE  = 0x00000002,
    D3DSBT_VERTEXSTATE = 0x00000003,
    D3DSBT_FORCE_DWORD = 0xffffffff,
}
alias D3DSTATEBLOCKTYPE = int;

enum : int
{
    D3DVBLEND_DISABLE  = 0x00000000,
    D3DVBLEND_1WEIGHT  = 0x00000001,
    D3DVBLEND_2WEIGHTS = 0x00000002,
    D3DVBLEND_3WEIGHTS = 0x00000003,
}
alias D3DVERTEXBLENDFLAGS = int;

enum : int
{
    D3DTTFF_DISABLE     = 0x00000000,
    D3DTTFF_COUNT1      = 0x00000001,
    D3DTTFF_COUNT2      = 0x00000002,
    D3DTTFF_COUNT3      = 0x00000003,
    D3DTTFF_COUNT4      = 0x00000004,
    D3DTTFF_PROJECTED   = 0x00000100,
    D3DTTFF_FORCE_DWORD = 0x7fffffff,
}
alias D3DTEXTURETRANSFORMFLAGS = int;

enum : int
{
    D3DNTDP2OP_POINTS               = 0x00000001,
    D3DNTDP2OP_INDEXEDLINELIST      = 0x00000002,
    D3DNTDP2OP_INDEXEDTRIANGLELIST  = 0x00000003,
    D3DNTDP2OP_RENDERSTATE          = 0x00000008,
    D3DNTDP2OP_LINELIST             = 0x0000000f,
    D3DNTDP2OP_LINESTRIP            = 0x00000010,
    D3DNTDP2OP_INDEXEDLINESTRIP     = 0x00000011,
    D3DNTDP2OP_TRIANGLELIST         = 0x00000012,
    D3DNTDP2OP_TRIANGLESTRIP        = 0x00000013,
    D3DNTDP2OP_INDEXEDTRIANGLESTRIP = 0x00000014,
    D3DNTDP2OP_TRIANGLEFAN          = 0x00000015,
    D3DNTDP2OP_INDEXEDTRIANGLEFAN   = 0x00000016,
    D3DNTDP2OP_TRIANGLEFAN_IMM      = 0x00000017,
    D3DNTDP2OP_LINELIST_IMM         = 0x00000018,
    D3DNTDP2OP_TEXTURESTAGESTATE    = 0x00000019,
    D3DNTDP2OP_INDEXEDTRIANGLELIST2 = 0x0000001a,
    D3DNTDP2OP_INDEXEDLINELIST2     = 0x0000001b,
    D3DNTDP2OP_VIEWPORTINFO         = 0x0000001c,
    D3DNTDP2OP_WINFO                = 0x0000001d,
    D3DNTDP2OP_SETPALETTE           = 0x0000001e,
    D3DNTDP2OP_UPDATEPALETTE        = 0x0000001f,
    D3DNTDP2OP_ZRANGE               = 0x00000020,
    D3DNTDP2OP_SETMATERIAL          = 0x00000021,
    D3DNTDP2OP_SETLIGHT             = 0x00000022,
    D3DNTDP2OP_CREATELIGHT          = 0x00000023,
    D3DNTDP2OP_SETTRANSFORM         = 0x00000024,
    D3DNTDP2OP_TEXBLT               = 0x00000026,
    D3DNTDP2OP_STATESET             = 0x00000027,
    D3DNTDP2OP_SETPRIORITY          = 0x00000028,
    D3DNTDP2OP_SETRENDERTARGET      = 0x00000029,
    D3DNTDP2OP_CLEAR                = 0x0000002a,
    D3DNTDP2OP_SETTEXLOD            = 0x0000002b,
    D3DNTDP2OP_SETCLIPPLANE         = 0x0000002c,
}
alias D3DNTHAL_DP2OPERATION = int;

enum : int
{
    EngProcessorFeature             = 0x00000001,
    EngNumberOfProcessors           = 0x00000002,
    EngOptimumAvailableUserMemory   = 0x00000003,
    EngOptimumAvailableSystemMemory = 0x00000004,
}
alias ENG_SYSTEM_ATTRIBUTE = int;

enum : int
{
    QDA_RESERVED           = 0x00000000,
    QDA_ACCELERATION_LEVEL = 0x00000001,
}
alias ENG_DEVICE_ATTRIBUTE = int;

enum : int
{
    DEVPROP_STORE_SYSTEM = 0x00000000,
    DEVPROP_STORE_USER   = 0x00000001,
}
alias DEVPROPSTORE = int;

enum : int
{
    PWM_ACTIVE_HIGH = 0x00000000,
    PWM_ACTIVE_LOW  = 0x00000001,
}
alias PWM_POLARITY = int;

enum : int
{
    ENCLAVE_IDENTITY_POLICY_SEAL_INVALID           = 0x00000000,
    ENCLAVE_IDENTITY_POLICY_SEAL_EXACT_CODE        = 0x00000001,
    ENCLAVE_IDENTITY_POLICY_SEAL_SAME_PRIMARY_CODE = 0x00000002,
    ENCLAVE_IDENTITY_POLICY_SEAL_SAME_IMAGE        = 0x00000003,
    ENCLAVE_IDENTITY_POLICY_SEAL_SAME_FAMILY       = 0x00000004,
    ENCLAVE_IDENTITY_POLICY_SEAL_SAME_AUTHOR       = 0x00000005,
}
alias ENCLAVE_SEALING_IDENTITY_POLICY = int;

enum : int
{
    EffectivePowerModeBatterySaver    = 0x00000000,
    EffectivePowerModeBetterBattery   = 0x00000001,
    EffectivePowerModeBalanced        = 0x00000002,
    EffectivePowerModeHighPerformance = 0x00000003,
    EffectivePowerModeMaxPerformance  = 0x00000004,
    EffectivePowerModeGameMode        = 0x00000005,
    EffectivePowerModeMixedReality    = 0x00000006,
}
alias EFFECTIVE_POWER_MODE = int;

enum : int
{
    ACCESS_AC_POWER_SETTING_INDEX               = 0x00000000,
    ACCESS_DC_POWER_SETTING_INDEX               = 0x00000001,
    ACCESS_FRIENDLY_NAME                        = 0x00000002,
    ACCESS_DESCRIPTION                          = 0x00000003,
    ACCESS_POSSIBLE_POWER_SETTING               = 0x00000004,
    ACCESS_POSSIBLE_POWER_SETTING_FRIENDLY_NAME = 0x00000005,
    ACCESS_POSSIBLE_POWER_SETTING_DESCRIPTION   = 0x00000006,
    ACCESS_DEFAULT_AC_POWER_SETTING             = 0x00000007,
    ACCESS_DEFAULT_DC_POWER_SETTING             = 0x00000008,
    ACCESS_POSSIBLE_VALUE_MIN                   = 0x00000009,
    ACCESS_POSSIBLE_VALUE_MAX                   = 0x0000000a,
    ACCESS_POSSIBLE_VALUE_INCREMENT             = 0x0000000b,
    ACCESS_POSSIBLE_VALUE_UNITS                 = 0x0000000c,
    ACCESS_ICON_RESOURCE                        = 0x0000000d,
    ACCESS_DEFAULT_SECURITY_DESCRIPTOR          = 0x0000000e,
    ACCESS_ATTRIBUTES                           = 0x0000000f,
    ACCESS_SCHEME                               = 0x00000010,
    ACCESS_SUBGROUP                             = 0x00000011,
    ACCESS_INDIVIDUAL_SETTING                   = 0x00000012,
    ACCESS_ACTIVE_SCHEME                        = 0x00000013,
    ACCESS_CREATE_SCHEME                        = 0x00000014,
    ACCESS_AC_POWER_SETTING_MAX                 = 0x00000015,
    ACCESS_DC_POWER_SETTING_MAX                 = 0x00000016,
    ACCESS_AC_POWER_SETTING_MIN                 = 0x00000017,
    ACCESS_DC_POWER_SETTING_MIN                 = 0x00000018,
    ACCESS_PROFILE                              = 0x00000019,
    ACCESS_OVERLAY_SCHEME                       = 0x0000001a,
    ACCESS_ACTIVE_OVERLAY_SCHEME                = 0x0000001b,
}
alias POWER_DATA_ACCESSOR = int;

enum : int
{
    BatteryInformation            = 0x00000000,
    BatteryGranularityInformation = 0x00000001,
    BatteryTemperature            = 0x00000002,
    BatteryEstimatedTime          = 0x00000003,
    BatteryDeviceName             = 0x00000004,
    BatteryManufactureDate        = 0x00000005,
    BatteryManufactureName        = 0x00000006,
    BatteryUniqueID               = 0x00000007,
    BatterySerialNumber           = 0x00000008,
}
alias BATTERY_QUERY_INFORMATION_LEVEL = int;

enum : int
{
    BatteryChargingSourceType_AC       = 0x00000001,
    BatteryChargingSourceType_USB      = 0x00000002,
    BatteryChargingSourceType_Wireless = 0x00000003,
    BatteryChargingSourceType_Max      = 0x00000004,
}
alias BATTERY_CHARGING_SOURCE_TYPE = int;

enum : int
{
    UsbChargerPort_Legacy = 0x00000000,
    UsbChargerPort_TypeC  = 0x00000001,
    UsbChargerPort_Max    = 0x00000002,
}
alias USB_CHARGER_PORT = int;

enum : int
{
    BatteryCriticalBias   = 0x00000000,
    BatteryCharge         = 0x00000001,
    BatteryDischarge      = 0x00000002,
    BatteryChargingSource = 0x00000003,
    BatteryChargerId      = 0x00000004,
    BatteryChargerStatus  = 0x00000005,
}
alias BATTERY_SET_INFORMATION_LEVEL = int;

enum : int
{
    VideoPowerNotifyCallout             = 0x00000001,
    VideoEnumChildPdoNotifyCallout      = 0x00000003,
    VideoFindAdapterCallout             = 0x00000004,
    VideoPnpNotifyCallout               = 0x00000007,
    VideoDxgkDisplaySwitchCallout       = 0x00000008,
    VideoDxgkFindAdapterTdrCallout      = 0x0000000a,
    VideoDxgkHardwareProtectionTeardown = 0x0000000b,
    VideoRepaintDesktop                 = 0x0000000c,
    VideoUpdateCursor                   = 0x0000000d,
    VideoDisableMultiPlaneOverlay       = 0x0000000e,
    VideoDesktopDuplicationChange       = 0x0000000f,
    VideoBlackScreenDiagnostics         = 0x00000010,
}
alias VIDEO_WIN32K_CALLBACKS_PARAMS_TYPE = int;

enum BlackScreenDiagnosticsCalloutParam : int
{
    BlackScreenDiagnosticsData = 0x00000001,
    BlackScreenDisplayRecovery = 0x00000002,
}

enum : int
{
    VideoNotBanked    = 0x00000000,
    VideoBanked1RW    = 0x00000001,
    VideoBanked1R1W   = 0x00000002,
    VideoBanked2RW    = 0x00000003,
    NumVideoBankTypes = 0x00000004,
}
alias VIDEO_BANK_TYPE = int;

enum : int
{
    VideoPowerUnspecified = 0x00000000,
    VideoPowerOn          = 0x00000001,
    VideoPowerStandBy     = 0x00000002,
    VideoPowerSuspend     = 0x00000003,
    VideoPowerOff         = 0x00000004,
    VideoPowerHibernate   = 0x00000005,
    VideoPowerShutdown    = 0x00000006,
    VideoPowerMaximum     = 0x00000007,
}
alias VIDEO_POWER_STATE = int;

enum : int
{
    BRIGHTNESS_INTERFACE_VERSION_1 = 0x00000001,
    BRIGHTNESS_INTERFACE_VERSION_2 = 0x00000002,
    BRIGHTNESS_INTERFACE_VERSION_3 = 0x00000003,
}
alias BRIGHTNESS_INTERFACE_VERSION = int;

enum : int
{
    BacklightOptimizationDisable = 0x00000000,
    BacklightOptimizationDesktop = 0x00000001,
    BacklightOptimizationDynamic = 0x00000002,
    BacklightOptimizationDimmed  = 0x00000003,
    BacklightOptimizationEDR     = 0x00000004,
}
alias BACKLIGHT_OPTIMIZATION_LEVEL = int;

enum : int
{
    COLORSPACE_TRANSFORM_DATA_TYPE_FIXED_POINT = 0x00000000,
    COLORSPACE_TRANSFORM_DATA_TYPE_FLOAT       = 0x00000001,
}
alias COLORSPACE_TRANSFORM_DATA_TYPE = int;

enum : int
{
    COLORSPACE_TRANSFORM_VERSION_DEFAULT       = 0x00000000,
    COLORSPACE_TRANSFORM_VERSION_1             = 0x00000001,
    COLORSPACE_TRANSFORM_VERSION_NOT_SUPPORTED = 0x00000000,
}
alias COLORSPACE_TRANSFORM_TARGET_CAPS_VERSION = int;

enum : int
{
    COLORSPACE_TRANSFORM_TYPE_UNINITIALIZED = 0x00000000,
    COLORSPACE_TRANSFORM_TYPE_DEFAULT       = 0x00000001,
    COLORSPACE_TRANSFORM_TYPE_RGB256x3x16   = 0x00000002,
    COLORSPACE_TRANSFORM_TYPE_DXGI_1        = 0x00000003,
    COLORSPACE_TRANSFORM_TYPE_MATRIX_3x4    = 0x00000004,
    COLORSPACE_TRANSFORM_TYPE_MATRIX_V2     = 0x00000005,
}
alias COLORSPACE_TRANSFORM_TYPE = int;

enum : int
{
    OUTPUT_WIRE_COLOR_SPACE_G22_P709              = 0x00000000,
    OUTPUT_WIRE_COLOR_SPACE_RESERVED              = 0x00000004,
    OUTPUT_WIRE_COLOR_SPACE_G2084_P2020           = 0x0000000c,
    OUTPUT_WIRE_COLOR_SPACE_G22_P709_WCG          = 0x0000001e,
    OUTPUT_WIRE_COLOR_SPACE_G22_P2020             = 0x0000001f,
    OUTPUT_WIRE_COLOR_SPACE_G2084_P2020_HDR10PLUS = 0x00000020,
    OUTPUT_WIRE_COLOR_SPACE_G2084_P2020_DVLL      = 0x00000021,
}
alias OUTPUT_WIRE_COLOR_SPACE_TYPE = int;

enum : int
{
    OUTPUT_COLOR_ENCODING_RGB          = 0x00000000,
    OUTPUT_COLOR_ENCODING_YCBCR444     = 0x00000001,
    OUTPUT_COLOR_ENCODING_YCBCR422     = 0x00000002,
    OUTPUT_COLOR_ENCODING_YCBCR420     = 0x00000003,
    OUTPUT_COLOR_ENCODING_INTENSITY    = 0x00000004,
    OUTPUT_COLOR_ENCODING_FORCE_UINT32 = 0xffffffff,
}
alias OUTPUT_COLOR_ENCODING = int;

enum : int
{
    ColorSpaceTransformStageControl_No_Change = 0x00000000,
    ColorSpaceTransformStageControl_Enable    = 0x00000001,
    ColorSpaceTransformStageControl_Bypass    = 0x00000002,
}
alias COLORSPACE_TRANSFORM_STAGE_CONTROL = int;

enum : int
{
    DCT_DEFAULT                = 0x00000000,
    DCT_FORCE_LOW_POWER        = 0x00000001,
    DCT_FORCE_HIGH_PERFORMANCE = 0x00000002,
}
alias DSI_CONTROL_TRANSMISSION_MODE = int;

enum : int
{
    AR_ENABLED       = 0x00000000,
    AR_DISABLED      = 0x00000001,
    AR_SUPPRESSED    = 0x00000002,
    AR_REMOTESESSION = 0x00000004,
    AR_MULTIMON      = 0x00000008,
    AR_NOSENSOR      = 0x00000010,
    AR_NOT_SUPPORTED = 0x00000020,
    AR_DOCKED        = 0x00000040,
    AR_LAPTOP        = 0x00000080,
}
alias AR_STATE = int;

enum : int
{
    ORIENTATION_PREFERENCE_NONE              = 0x00000000,
    ORIENTATION_PREFERENCE_LANDSCAPE         = 0x00000001,
    ORIENTATION_PREFERENCE_PORTRAIT          = 0x00000002,
    ORIENTATION_PREFERENCE_LANDSCAPE_FLIPPED = 0x00000004,
    ORIENTATION_PREFERENCE_PORTRAIT_FLIPPED  = 0x00000008,
}
alias ORIENTATION_PREFERENCE = int;

enum : int
{
    PMETypeFailFastOnCommitFailure = 0x00000000,
    PMETypeMax                     = 0x00000001,
}
alias PROCESS_MEMORY_EXHAUSTION_TYPE = int;

// Constants


enum int TRUE = 0x00000001;
enum ushort RT_CURSOR = 0x0001;

enum : ushort
{
    RT_ICON   = 0x0003,
    RT_MENU   = 0x0004,
    RT_DIALOG = 0x0005,
}

enum : ushort
{
    RT_FONTDIR     = 0x0007,
    RT_FONT        = 0x0008,
    RT_ACCELERATOR = 0x0009,
}

enum ushort RT_MESSAGETABLE = 0x000b;

enum : ushort
{
    RT_GROUP_CURSOR = 0x000c,
    RT_GROUP_ICON   = 0x000e,
}

enum ushort RT_DLGINCLUDE = 0x0011;

enum : ushort
{
    RT_VXD       = 0x0014,
    RT_ANICURSOR = 0x0015,
    RT_ANIICON   = 0x0016,
}

enum ushort RT_MANIFEST = 0x0018;

enum : ushort
{
    ISOLATIONAWARE_MANIFEST_RESOURCE_ID                = 0x0002,
    ISOLATIONAWARE_NOSTATICIMPORT_MANIFEST_RESOURCE_ID = 0x0003,
}

enum ushort ISOLATIONPOLICY_BROWSER_MANIFEST_RESOURCE_ID = 0x0005;
enum ushort MAXIMUM_RESERVED_MANIFEST_RESOURCE_ID = 0x0010;

enum : int
{
    SB_HORZ      = 0x00000000,
    SB_VERT      = 0x00000001,
    SB_CTL       = 0x00000002,
    SB_BOTH      = 0x00000003,
    SB_LINEUP    = 0x00000000,
    SB_LINELEFT  = 0x00000000,
    SB_LINEDOWN  = 0x00000001,
    SB_LINERIGHT = 0x00000001,
}

enum : int
{
    SB_PAGELEFT  = 0x00000002,
    SB_PAGEDOWN  = 0x00000003,
    SB_PAGERIGHT = 0x00000003,
}

enum int SB_THUMBTRACK = 0x00000005;

enum : int
{
    SB_LEFT   = 0x00000006,
    SB_BOTTOM = 0x00000007,
}

enum int SB_ENDSCROLL = 0x00000008;
enum int SW_SHOWNORMAL = 0x00000001;

enum : int
{
    SW_SHOWMINIMIZED = 0x00000002,
    SW_SHOWMAXIMIZED = 0x00000003,
}

enum : int
{
    SW_SHOWNOACTIVATE = 0x00000004,
    SW_SHOW           = 0x00000005,
    SW_MINIMIZE       = 0x00000006,
}

enum int SW_SHOWNA = 0x00000008;
enum int SW_SHOWDEFAULT = 0x0000000a;
enum int SW_MAX = 0x0000000b;
enum int SHOW_OPENWINDOW = 0x00000001;
enum int SHOW_FULLSCREEN = 0x00000003;
enum int SW_PARENTCLOSING = 0x00000001;
enum int SW_PARENTOPENING = 0x00000003;

enum : int
{
    AW_HOR_POSITIVE = 0x00000001,
    AW_HOR_NEGATIVE = 0x00000002,
}

enum int AW_VER_NEGATIVE = 0x00000008;

enum : int
{
    AW_HIDE     = 0x00010000,
    AW_ACTIVATE = 0x00020000,
}

enum int AW_BLEND = 0x00080000;
enum int KF_DLGMODE = 0x00000800;
enum int KF_ALTDOWN = 0x00002000;
enum int KF_UP = 0x00008000;
enum int VK_RBUTTON = 0x00000002;
enum int VK_MBUTTON = 0x00000004;
enum int VK_XBUTTON2 = 0x00000006;

enum : int
{
    VK_TAB   = 0x00000009,
    VK_CLEAR = 0x0000000c,
}

enum int VK_SHIFT = 0x00000010;

enum : int
{
    VK_MENU  = 0x00000012,
    VK_PAUSE = 0x00000013,
}

enum : int
{
    VK_KANA    = 0x00000015,
    VK_HANGEUL = 0x00000015,
    VK_HANGUL  = 0x00000015,
}

enum int VK_FINAL = 0x00000018;
enum int VK_KANJI = 0x00000019;
enum int VK_CONVERT = 0x0000001c;
enum int VK_ACCEPT = 0x0000001e;
enum int VK_SPACE = 0x00000020;

enum : int
{
    VK_NEXT  = 0x00000022,
    VK_END   = 0x00000023,
    VK_HOME  = 0x00000024,
    VK_LEFT  = 0x00000025,
    VK_UP    = 0x00000026,
    VK_RIGHT = 0x00000027,
}

enum int VK_SELECT = 0x00000029;
enum int VK_EXECUTE = 0x0000002b;
enum int VK_INSERT = 0x0000002d;

enum : int
{
    VK_HELP  = 0x0000002f,
    VK_LWIN  = 0x0000005b,
    VK_RWIN  = 0x0000005c,
    VK_APPS  = 0x0000005d,
    VK_SLEEP = 0x0000005f,
}

enum : int
{
    VK_NUMPAD1 = 0x00000061,
    VK_NUMPAD2 = 0x00000062,
    VK_NUMPAD3 = 0x00000063,
    VK_NUMPAD4 = 0x00000064,
    VK_NUMPAD5 = 0x00000065,
    VK_NUMPAD6 = 0x00000066,
    VK_NUMPAD7 = 0x00000067,
    VK_NUMPAD8 = 0x00000068,
    VK_NUMPAD9 = 0x00000069,
}

enum : int
{
    VK_ADD       = 0x0000006b,
    VK_SEPARATOR = 0x0000006c,
}

enum int VK_DECIMAL = 0x0000006e;

enum : int
{
    VK_F1                = 0x00000070,
    VK_F2                = 0x00000071,
    VK_F3                = 0x00000072,
    VK_F4                = 0x00000073,
    VK_F5                = 0x00000074,
    VK_F6                = 0x00000075,
    VK_F7                = 0x00000076,
    VK_F8                = 0x00000077,
    VK_F9                = 0x00000078,
    VK_F10               = 0x00000079,
    VK_F11               = 0x0000007a,
    VK_F12               = 0x0000007b,
    VK_F13               = 0x0000007c,
    VK_F14               = 0x0000007d,
    VK_F15               = 0x0000007e,
    VK_F16               = 0x0000007f,
    VK_F17               = 0x00000080,
    VK_F18               = 0x00000081,
    VK_F19               = 0x00000082,
    VK_F20               = 0x00000083,
    VK_F21               = 0x00000084,
    VK_F22               = 0x00000085,
    VK_F23               = 0x00000086,
    VK_F24               = 0x00000087,
    VK_NAVIGATION_VIEW   = 0x00000088,
    VK_NAVIGATION_MENU   = 0x00000089,
    VK_NAVIGATION_UP     = 0x0000008a,
    VK_NAVIGATION_DOWN   = 0x0000008b,
    VK_NAVIGATION_LEFT   = 0x0000008c,
    VK_NAVIGATION_RIGHT  = 0x0000008d,
    VK_NAVIGATION_ACCEPT = 0x0000008e,
    VK_NAVIGATION_CANCEL = 0x0000008f,
}

enum int VK_SCROLL = 0x00000091;

enum : int
{
    VK_OEM_FJ_JISHO   = 0x00000092,
    VK_OEM_FJ_MASSHOU = 0x00000093,
    VK_OEM_FJ_TOUROKU = 0x00000094,
    VK_OEM_FJ_LOYA    = 0x00000095,
    VK_OEM_FJ_ROYA    = 0x00000096,
}

enum int VK_RSHIFT = 0x000000a1;
enum int VK_RCONTROL = 0x000000a3;
enum int VK_RMENU = 0x000000a5;

enum : int
{
    VK_BROWSER_FORWARD   = 0x000000a7,
    VK_BROWSER_REFRESH   = 0x000000a8,
    VK_BROWSER_STOP      = 0x000000a9,
    VK_BROWSER_SEARCH    = 0x000000aa,
    VK_BROWSER_FAVORITES = 0x000000ab,
    VK_BROWSER_HOME      = 0x000000ac,
}

enum : int
{
    VK_VOLUME_DOWN = 0x000000ae,
    VK_VOLUME_UP   = 0x000000af,
}

enum : int
{
    VK_MEDIA_PREV_TRACK = 0x000000b1,
    VK_MEDIA_STOP       = 0x000000b2,
    VK_MEDIA_PLAY_PAUSE = 0x000000b3,
}

enum : int
{
    VK_LAUNCH_MEDIA_SELECT = 0x000000b5,
    VK_LAUNCH_APP1         = 0x000000b6,
    VK_LAUNCH_APP2         = 0x000000b7,
}

enum : int
{
    VK_OEM_PLUS   = 0x000000bb,
    VK_OEM_COMMA  = 0x000000bc,
    VK_OEM_MINUS  = 0x000000bd,
    VK_OEM_PERIOD = 0x000000be,
    VK_OEM_2      = 0x000000bf,
    VK_OEM_3      = 0x000000c0,
}

enum : int
{
    VK_GAMEPAD_B                      = 0x000000c4,
    VK_GAMEPAD_X                      = 0x000000c5,
    VK_GAMEPAD_Y                      = 0x000000c6,
    VK_GAMEPAD_RIGHT_SHOULDER         = 0x000000c7,
    VK_GAMEPAD_LEFT_SHOULDER          = 0x000000c8,
    VK_GAMEPAD_LEFT_TRIGGER           = 0x000000c9,
    VK_GAMEPAD_RIGHT_TRIGGER          = 0x000000ca,
    VK_GAMEPAD_DPAD_UP                = 0x000000cb,
    VK_GAMEPAD_DPAD_DOWN              = 0x000000cc,
    VK_GAMEPAD_DPAD_LEFT              = 0x000000cd,
    VK_GAMEPAD_DPAD_RIGHT             = 0x000000ce,
    VK_GAMEPAD_MENU                   = 0x000000cf,
    VK_GAMEPAD_VIEW                   = 0x000000d0,
    VK_GAMEPAD_LEFT_THUMBSTICK_BUTTON = 0x000000d1,
}

enum : int
{
    VK_GAMEPAD_LEFT_THUMBSTICK_UP    = 0x000000d3,
    VK_GAMEPAD_LEFT_THUMBSTICK_DOWN  = 0x000000d4,
    VK_GAMEPAD_LEFT_THUMBSTICK_RIGHT = 0x000000d5,
    VK_GAMEPAD_LEFT_THUMBSTICK_LEFT  = 0x000000d6,
}

enum : int
{
    VK_GAMEPAD_RIGHT_THUMBSTICK_DOWN  = 0x000000d8,
    VK_GAMEPAD_RIGHT_THUMBSTICK_RIGHT = 0x000000d9,
    VK_GAMEPAD_RIGHT_THUMBSTICK_LEFT  = 0x000000da,
}

enum : int
{
    VK_OEM_5   = 0x000000dc,
    VK_OEM_6   = 0x000000dd,
    VK_OEM_7   = 0x000000de,
    VK_OEM_8   = 0x000000df,
    VK_OEM_AX  = 0x000000e1,
    VK_OEM_102 = 0x000000e2,
}

enum int VK_ICO_00 = 0x000000e4;
enum int VK_ICO_CLEAR = 0x000000e6;

enum : int
{
    VK_OEM_RESET   = 0x000000e9,
    VK_OEM_JUMP    = 0x000000ea,
    VK_OEM_PA1     = 0x000000eb,
    VK_OEM_PA2     = 0x000000ec,
    VK_OEM_PA3     = 0x000000ed,
    VK_OEM_WSCTRL  = 0x000000ee,
    VK_OEM_CUSEL   = 0x000000ef,
    VK_OEM_ATTN    = 0x000000f0,
    VK_OEM_FINISH  = 0x000000f1,
    VK_OEM_COPY    = 0x000000f2,
    VK_OEM_AUTO    = 0x000000f3,
    VK_OEM_ENLW    = 0x000000f4,
    VK_OEM_BACKTAB = 0x000000f5,
}

enum int VK_CRSEL = 0x000000f7;
enum int VK_EREOF = 0x000000f9;

enum : int
{
    VK_ZOOM   = 0x000000fb,
    VK_NONAME = 0x000000fc,
}

enum int VK_OEM_CLEAR = 0x000000fe;
enum int WH_MSGFILTER = 0xffffffff;
enum int WH_JOURNALPLAYBACK = 0x00000001;
enum int WH_GETMESSAGE = 0x00000003;

enum : int
{
    WH_CBT          = 0x00000005,
    WH_SYSMSGFILTER = 0x00000006,
}

enum int WH_HARDWARE = 0x00000008;
enum int WH_SHELL = 0x0000000a;
enum int WH_CALLWNDPROCRET = 0x0000000c;
enum int WH_MOUSE_LL = 0x0000000e;
enum int WH_MINHOOK = 0xffffffff;
enum int HC_ACTION = 0x00000000;

enum : int
{
    HC_SKIP     = 0x00000002,
    HC_NOREMOVE = 0x00000003,
    HC_NOREM    = 0x00000003,
}

enum int HC_SYSMODALOFF = 0x00000005;

enum : int
{
    HCBT_MINMAX    = 0x00000001,
    HCBT_QS        = 0x00000002,
    HCBT_CREATEWND = 0x00000003,
}

enum int HCBT_ACTIVATE = 0x00000005;
enum int HCBT_KEYSKIPPED = 0x00000007;
enum int HCBT_SETFOCUS = 0x00000009;
enum int WTS_CONSOLE_DISCONNECT = 0x00000002;
enum int WTS_REMOTE_DISCONNECT = 0x00000004;

enum : int
{
    WTS_SESSION_LOGOFF         = 0x00000006,
    WTS_SESSION_LOCK           = 0x00000007,
    WTS_SESSION_UNLOCK         = 0x00000008,
    WTS_SESSION_REMOTE_CONTROL = 0x00000009,
    WTS_SESSION_CREATE         = 0x0000000a,
    WTS_SESSION_TERMINATE      = 0x0000000b,
}

enum : int
{
    MSGF_MESSAGEBOX = 0x00000001,
    MSGF_MENU       = 0x00000002,
    MSGF_SCROLLBAR  = 0x00000005,
}

enum : int
{
    MSGF_MAX  = 0x00000008,
    MSGF_USER = 0x00001000,
}

enum int HSHELL_WINDOWDESTROYED = 0x00000002;
enum int HSHELL_WINDOWACTIVATED = 0x00000004;

enum : int
{
    HSHELL_REDRAW             = 0x00000006,
    HSHELL_TASKMAN            = 0x00000007,
    HSHELL_LANGUAGE           = 0x00000008,
    HSHELL_SYSMENU            = 0x00000009,
    HSHELL_ENDTASK            = 0x0000000a,
    HSHELL_ACCESSIBILITYSTATE = 0x0000000b,
}

enum : int
{
    HSHELL_WINDOWREPLACED  = 0x0000000d,
    HSHELL_WINDOWREPLACING = 0x0000000e,
}

enum : int
{
    HSHELL_HIGHBIT          = 0x00008000,
    HSHELL_FLASH            = 0x00008006,
    HSHELL_RUDEAPPACTIVATED = 0x00008004,
}

enum : int
{
    APPCOMMAND_BROWSER_FORWARD        = 0x00000002,
    APPCOMMAND_BROWSER_REFRESH        = 0x00000003,
    APPCOMMAND_BROWSER_STOP           = 0x00000004,
    APPCOMMAND_BROWSER_SEARCH         = 0x00000005,
    APPCOMMAND_BROWSER_FAVORITES      = 0x00000006,
    APPCOMMAND_BROWSER_HOME           = 0x00000007,
    APPCOMMAND_VOLUME_MUTE            = 0x00000008,
    APPCOMMAND_VOLUME_DOWN            = 0x00000009,
    APPCOMMAND_VOLUME_UP              = 0x0000000a,
    APPCOMMAND_MEDIA_NEXTTRACK        = 0x0000000b,
    APPCOMMAND_MEDIA_PREVIOUSTRACK    = 0x0000000c,
    APPCOMMAND_MEDIA_STOP             = 0x0000000d,
    APPCOMMAND_MEDIA_PLAY_PAUSE       = 0x0000000e,
    APPCOMMAND_LAUNCH_MAIL            = 0x0000000f,
    APPCOMMAND_LAUNCH_MEDIA_SELECT    = 0x00000010,
    APPCOMMAND_LAUNCH_APP1            = 0x00000011,
    APPCOMMAND_LAUNCH_APP2            = 0x00000012,
    APPCOMMAND_BASS_DOWN              = 0x00000013,
    APPCOMMAND_BASS_BOOST             = 0x00000014,
    APPCOMMAND_BASS_UP                = 0x00000015,
    APPCOMMAND_TREBLE_DOWN            = 0x00000016,
    APPCOMMAND_TREBLE_UP              = 0x00000017,
    APPCOMMAND_MICROPHONE_VOLUME_MUTE = 0x00000018,
    APPCOMMAND_MICROPHONE_VOLUME_DOWN = 0x00000019,
    APPCOMMAND_MICROPHONE_VOLUME_UP   = 0x0000001a,
}

enum : int
{
    APPCOMMAND_FIND                              = 0x0000001c,
    APPCOMMAND_NEW                               = 0x0000001d,
    APPCOMMAND_OPEN                              = 0x0000001e,
    APPCOMMAND_CLOSE                             = 0x0000001f,
    APPCOMMAND_SAVE                              = 0x00000020,
    APPCOMMAND_PRINT                             = 0x00000021,
    APPCOMMAND_UNDO                              = 0x00000022,
    APPCOMMAND_REDO                              = 0x00000023,
    APPCOMMAND_COPY                              = 0x00000024,
    APPCOMMAND_CUT                               = 0x00000025,
    APPCOMMAND_PASTE                             = 0x00000026,
    APPCOMMAND_REPLY_TO_MAIL                     = 0x00000027,
    APPCOMMAND_FORWARD_MAIL                      = 0x00000028,
    APPCOMMAND_SEND_MAIL                         = 0x00000029,
    APPCOMMAND_SPELL_CHECK                       = 0x0000002a,
    APPCOMMAND_DICTATE_OR_COMMAND_CONTROL_TOGGLE = 0x0000002b,
}

enum : int
{
    APPCOMMAND_CORRECTION_LIST    = 0x0000002d,
    APPCOMMAND_MEDIA_PLAY         = 0x0000002e,
    APPCOMMAND_MEDIA_PAUSE        = 0x0000002f,
    APPCOMMAND_MEDIA_RECORD       = 0x00000030,
    APPCOMMAND_MEDIA_FAST_FORWARD = 0x00000031,
    APPCOMMAND_MEDIA_REWIND       = 0x00000032,
    APPCOMMAND_MEDIA_CHANNEL_UP   = 0x00000033,
    APPCOMMAND_MEDIA_CHANNEL_DOWN = 0x00000034,
}

enum int APPCOMMAND_DWM_FLIP3D = 0x00000036;

enum : int
{
    FAPPCOMMAND_KEY  = 0x00000000,
    FAPPCOMMAND_OEM  = 0x00001000,
    FAPPCOMMAND_MASK = 0x0000f000,
}

enum : int
{
    LLKHF_INJECTED          = 0x00000010,
    LLKHF_ALTDOWN           = 0x00000020,
    LLKHF_UP                = 0x00000080,
    LLKHF_LOWER_IL_INJECTED = 0x00000002,
}

enum int LLMHF_LOWER_IL_INJECTED = 0x00000002;
enum int HKL_NEXT = 0x00000001;
enum int KLF_SUBSTITUTE_OK = 0x00000002;
enum int KLF_REPLACELANG = 0x00000010;
enum int KLF_SETFORPROCESS = 0x00000100;
enum int KLF_RESET = 0x40000000;

enum : int
{
    INPUTLANGCHANGE_FORWARD  = 0x00000002,
    INPUTLANGCHANGE_BACKWARD = 0x00000004,
}

enum int GMMP_USE_DISPLAY_POINTS = 0x00000001;

enum : int
{
    DESKTOP_READOBJECTS     = 0x00000001,
    DESKTOP_CREATEWINDOW    = 0x00000002,
    DESKTOP_CREATEMENU      = 0x00000004,
    DESKTOP_HOOKCONTROL     = 0x00000008,
    DESKTOP_JOURNALRECORD   = 0x00000010,
    DESKTOP_JOURNALPLAYBACK = 0x00000020,
}

enum int DESKTOP_WRITEOBJECTS = 0x00000080;
enum int DF_ALLOWOTHERACCOUNTHOOK = 0x00000001;
enum int WINSTA_READATTRIBUTES = 0x00000002;
enum int WINSTA_CREATEDESKTOP = 0x00000008;
enum int WINSTA_ACCESSGLOBALATOMS = 0x00000020;

enum : int
{
    WINSTA_ENUMERATE  = 0x00000100,
    WINSTA_READSCREEN = 0x00000200,
    WINSTA_ALL_ACCESS = 0x0000037f,
}

enum int WSF_VISIBLE = 0x00000001;

enum : int
{
    UOI_NAME     = 0x00000002,
    UOI_TYPE     = 0x00000003,
    UOI_USER_SID = 0x00000004,
}

enum : int
{
    UOI_IO                              = 0x00000006,
    UOI_TIMERPROC_EXCEPTION_SUPPRESSION = 0x00000007,
}

enum int GWL_HINSTANCE = 0xfffffffa;

enum : int
{
    GWL_STYLE   = 0xfffffff0,
    GWL_EXSTYLE = 0xffffffec,
}

enum : int
{
    GWL_ID          = 0xfffffff4,
    GWLP_WNDPROC    = 0xfffffffc,
    GWLP_HINSTANCE  = 0xfffffffa,
    GWLP_HWNDPARENT = 0xfffffff8,
}

enum int GWLP_ID = 0xfffffff4;
enum int GCL_HBRBACKGROUND = 0xfffffff6;

enum : int
{
    GCL_HICON   = 0xfffffff2,
    GCL_HMODULE = 0xfffffff0,
}

enum int GCL_CBCLSEXTRA = 0xffffffec;
enum int GCL_STYLE = 0xffffffe6;
enum int GCL_HICONSM = 0xffffffde;
enum int GCLP_HBRBACKGROUND = 0xfffffff6;

enum : int
{
    GCLP_HICON   = 0xfffffff2,
    GCLP_HMODULE = 0xfffffff0,
    GCLP_WNDPROC = 0xffffffe8,
    GCLP_HICONSM = 0xffffffde,
}

enum int WM_CREATE = 0x00000001;

enum : int
{
    WM_MOVE     = 0x00000003,
    WM_SIZE     = 0x00000005,
    WM_ACTIVATE = 0x00000006,
}

enum int WA_ACTIVE = 0x00000001;
enum int WM_SETFOCUS = 0x00000007;
enum int WM_ENABLE = 0x0000000a;
enum int WM_SETTEXT = 0x0000000c;
enum int WM_GETTEXTLENGTH = 0x0000000e;
enum int WM_CLOSE = 0x00000010;
enum int WM_QUERYOPEN = 0x00000013;

enum : int
{
    WM_QUIT       = 0x00000012,
    WM_ERASEBKGND = 0x00000014,
}

enum int WM_SHOWWINDOW = 0x00000018;
enum int WM_SETTINGCHANGE = 0x0000001a;
enum int WM_ACTIVATEAPP = 0x0000001c;
enum int WM_TIMECHANGE = 0x0000001e;
enum int WM_SETCURSOR = 0x00000020;
enum int WM_CHILDACTIVATE = 0x00000022;
enum int WM_GETMINMAXINFO = 0x00000024;
enum int WM_ICONERASEBKGND = 0x00000027;
enum int WM_SPOOLERSTATUS = 0x0000002a;
enum int WM_MEASUREITEM = 0x0000002c;
enum int WM_VKEYTOITEM = 0x0000002e;
enum int WM_SETFONT = 0x00000030;
enum int WM_SETHOTKEY = 0x00000032;
enum int WM_QUERYDRAGICON = 0x00000037;
enum int WM_GETOBJECT = 0x0000003d;
enum int WM_COMMNOTIFY = 0x00000044;
enum int WM_WINDOWPOSCHANGED = 0x00000047;

enum : int
{
    PWR_OK             = 0x00000001,
    PWR_FAIL           = 0xffffffff,
    PWR_SUSPENDREQUEST = 0x00000001,
    PWR_SUSPENDRESUME  = 0x00000002,
}

enum int WM_COPYDATA = 0x0000004a;
enum int WM_NOTIFY = 0x0000004e;
enum int WM_INPUTLANGCHANGE = 0x00000051;

enum : int
{
    WM_HELP        = 0x00000053,
    WM_USERCHANGED = 0x00000054,
}

enum : int
{
    NFR_ANSI    = 0x00000001,
    NFR_UNICODE = 0x00000002,
}

enum int NF_REQUERY = 0x00000004;

enum : int
{
    WM_STYLECHANGING = 0x0000007c,
    WM_STYLECHANGED  = 0x0000007d,
}

enum int WM_GETICON = 0x0000007f;

enum : int
{
    WM_NCCREATE   = 0x00000081,
    WM_NCDESTROY  = 0x00000082,
    WM_NCCALCSIZE = 0x00000083,
}

enum : int
{
    WM_NCPAINT    = 0x00000085,
    WM_NCACTIVATE = 0x00000086,
}

enum int WM_SYNCPAINT = 0x00000088;

enum : int
{
    WM_NCLBUTTONDOWN   = 0x000000a1,
    WM_NCLBUTTONUP     = 0x000000a2,
    WM_NCLBUTTONDBLCLK = 0x000000a3,
}

enum : int
{
    WM_NCRBUTTONUP     = 0x000000a5,
    WM_NCRBUTTONDBLCLK = 0x000000a6,
}

enum : int
{
    WM_NCMBUTTONUP     = 0x000000a8,
    WM_NCMBUTTONDBLCLK = 0x000000a9,
}

enum : int
{
    WM_NCXBUTTONUP     = 0x000000ac,
    WM_NCXBUTTONDBLCLK = 0x000000ad,
}

enum int WM_INPUT = 0x000000ff;

enum : int
{
    WM_KEYDOWN = 0x00000100,
    WM_KEYUP   = 0x00000101,
}

enum int WM_DEADCHAR = 0x00000103;

enum : int
{
    WM_SYSKEYUP    = 0x00000105,
    WM_SYSCHAR     = 0x00000106,
    WM_SYSDEADCHAR = 0x00000107,
}

enum int WM_KEYLAST = 0x00000109;
enum int WM_IME_STARTCOMPOSITION = 0x0000010d;
enum int WM_IME_COMPOSITION = 0x0000010f;
enum int WM_INITDIALOG = 0x00000110;
enum int WM_SYSCOMMAND = 0x00000112;
enum int WM_HSCROLL = 0x00000114;

enum : int
{
    WM_INITMENU      = 0x00000116,
    WM_INITMENUPOPUP = 0x00000117,
}

enum int WM_GESTURENOTIFY = 0x0000011a;
enum int WM_MENUCHAR = 0x00000120;

enum : int
{
    WM_MENURBUTTONUP = 0x00000122,
    WM_MENUDRAG      = 0x00000123,
    WM_MENUGETOBJECT = 0x00000124,
}

enum int WM_MENUCOMMAND = 0x00000126;
enum int WM_UPDATEUISTATE = 0x00000128;

enum : int
{
    UIS_SET        = 0x00000001,
    UIS_CLEAR      = 0x00000002,
    UIS_INITIALIZE = 0x00000003,
}

enum int UISF_HIDEACCEL = 0x00000002;

enum : int
{
    WM_CTLCOLORMSGBOX    = 0x00000132,
    WM_CTLCOLOREDIT      = 0x00000133,
    WM_CTLCOLORLISTBOX   = 0x00000134,
    WM_CTLCOLORBTN       = 0x00000135,
    WM_CTLCOLORDLG       = 0x00000136,
    WM_CTLCOLORSCROLLBAR = 0x00000137,
    WM_CTLCOLORSTATIC    = 0x00000138,
}

enum : int
{
    WM_MOUSEFIRST = 0x00000200,
    WM_MOUSEMOVE  = 0x00000200,
}

enum : int
{
    WM_LBUTTONUP     = 0x00000202,
    WM_LBUTTONDBLCLK = 0x00000203,
}

enum : int
{
    WM_RBUTTONUP     = 0x00000205,
    WM_RBUTTONDBLCLK = 0x00000206,
}

enum : int
{
    WM_MBUTTONUP     = 0x00000208,
    WM_MBUTTONDBLCLK = 0x00000209,
}

enum : int
{
    WM_XBUTTONDOWN   = 0x0000020b,
    WM_XBUTTONUP     = 0x0000020c,
    WM_XBUTTONDBLCLK = 0x0000020d,
}

enum int WM_MOUSELAST = 0x0000020e;
enum uint WHEEL_PAGESCROLL = 0xffffffff;
enum int XBUTTON2 = 0x00000002;
enum int WM_ENTERMENULOOP = 0x00000211;
enum int WM_NEXTMENU = 0x00000213;
enum int WM_CAPTURECHANGED = 0x00000215;
enum int WM_POWERBROADCAST = 0x00000218;

enum : int
{
    PBT_APMQUERYSTANDBY       = 0x00000001,
    PBT_APMQUERYSUSPENDFAILED = 0x00000002,
    PBT_APMQUERYSTANDBYFAILED = 0x00000003,
}

enum : int
{
    PBT_APMSTANDBY        = 0x00000005,
    PBT_APMRESUMECRITICAL = 0x00000006,
    PBT_APMRESUMESUSPEND  = 0x00000007,
    PBT_APMRESUMESTANDBY  = 0x00000008,
}

enum : int
{
    PBT_APMBATTERYLOW        = 0x00000009,
    PBT_APMPOWERSTATUSCHANGE = 0x0000000a,
}

enum int PBT_APMRESUMEAUTOMATIC = 0x00000012;
enum int WM_DEVICECHANGE = 0x00000219;

enum : int
{
    WM_MDIDESTROY     = 0x00000221,
    WM_MDIACTIVATE    = 0x00000222,
    WM_MDIRESTORE     = 0x00000223,
    WM_MDINEXT        = 0x00000224,
    WM_MDIMAXIMIZE    = 0x00000225,
    WM_MDITILE        = 0x00000226,
    WM_MDICASCADE     = 0x00000227,
    WM_MDIICONARRANGE = 0x00000228,
}

enum int WM_MDISETMENU = 0x00000230;
enum int WM_EXITSIZEMOVE = 0x00000232;
enum int WM_MDIREFRESHMENU = 0x00000234;

enum : int
{
    WM_POINTERDEVICEINRANGE    = 0x00000239,
    WM_POINTERDEVICEOUTOFRANGE = 0x0000023a,
}

enum : int
{
    WM_NCPOINTERUPDATE = 0x00000241,
    WM_NCPOINTERDOWN   = 0x00000242,
    WM_NCPOINTERUP     = 0x00000243,
}

enum : int
{
    WM_POINTERDOWN           = 0x00000246,
    WM_POINTERUP             = 0x00000247,
    WM_POINTERENTER          = 0x00000249,
    WM_POINTERLEAVE          = 0x0000024a,
    WM_POINTERACTIVATE       = 0x0000024b,
    WM_POINTERCAPTURECHANGED = 0x0000024c,
}

enum : int
{
    WM_POINTERWHEEL  = 0x0000024e,
    WM_POINTERHWHEEL = 0x0000024f,
}

enum : int
{
    WM_POINTERROUTEDTO       = 0x00000251,
    WM_POINTERROUTEDAWAY     = 0x00000252,
    WM_POINTERROUTEDRELEASED = 0x00000253,
}

enum : int
{
    WM_IME_NOTIFY          = 0x00000282,
    WM_IME_CONTROL         = 0x00000283,
    WM_IME_COMPOSITIONFULL = 0x00000284,
}

enum : int
{
    WM_IME_CHAR    = 0x00000286,
    WM_IME_REQUEST = 0x00000288,
    WM_IME_KEYDOWN = 0x00000290,
    WM_IME_KEYUP   = 0x00000291,
}

enum int WM_MOUSELEAVE = 0x000002a3;
enum int WM_NCMOUSELEAVE = 0x000002a2;

enum : int
{
    WM_TABLET_FIRST = 0x000002c0,
    WM_TABLET_LAST  = 0x000002df,
}

enum : int
{
    WM_DPICHANGED_BEFOREPARENT = 0x000002e2,
    WM_DPICHANGED_AFTERPARENT  = 0x000002e3,
}

enum : int
{
    WM_CUT   = 0x00000300,
    WM_COPY  = 0x00000301,
    WM_PASTE = 0x00000302,
}

enum : int
{
    WM_UNDO             = 0x00000304,
    WM_RENDERFORMAT     = 0x00000305,
    WM_RENDERALLFORMATS = 0x00000306,
}

enum int WM_DRAWCLIPBOARD = 0x00000308;
enum int WM_VSCROLLCLIPBOARD = 0x0000030a;
enum int WM_ASKCBFORMATNAME = 0x0000030c;
enum int WM_HSCROLLCLIPBOARD = 0x0000030e;

enum : int
{
    WM_PALETTEISCHANGING = 0x00000310,
    WM_PALETTECHANGED    = 0x00000311,
}

enum : int
{
    WM_PRINT       = 0x00000317,
    WM_PRINTCLIENT = 0x00000318,
}

enum int WM_THEMECHANGED = 0x0000031a;
enum int WM_DWMCOMPOSITIONCHANGED = 0x0000031e;
enum int WM_DWMCOLORIZATIONCOLORCHANGED = 0x00000320;

enum : int
{
    WM_DWMSENDICONICTHUMBNAIL         = 0x00000323,
    WM_DWMSENDICONICLIVEPREVIEWBITMAP = 0x00000326,
}

enum : int
{
    WM_HANDHELDFIRST = 0x00000358,
    WM_HANDHELDLAST  = 0x0000035f,
}

enum int WM_AFXLAST = 0x0000037f;
enum int WM_PENWINLAST = 0x0000038f;
enum int WM_USER = 0x00000400;

enum : int
{
    WMSZ_RIGHT    = 0x00000002,
    WMSZ_TOP      = 0x00000003,
    WMSZ_TOPLEFT  = 0x00000004,
    WMSZ_TOPRIGHT = 0x00000005,
}

enum : int
{
    WMSZ_BOTTOMLEFT  = 0x00000007,
    WMSZ_BOTTOMRIGHT = 0x00000008,
}

enum int HTTRANSPARENT = 0xffffffff;
enum int HTCLIENT = 0x00000001;
enum int HTSYSMENU = 0x00000003;
enum int HTSIZE = 0x00000004;
enum int HTHSCROLL = 0x00000006;
enum int HTMINBUTTON = 0x00000008;
enum int HTLEFT = 0x0000000a;

enum : int
{
    HTTOP      = 0x0000000c,
    HTTOPLEFT  = 0x0000000d,
    HTTOPRIGHT = 0x0000000e,
}

enum : int
{
    HTBOTTOMLEFT  = 0x00000010,
    HTBOTTOMRIGHT = 0x00000011,
}

enum int HTREDUCE = 0x00000008;

enum : int
{
    HTSIZEFIRST = 0x0000000a,
    HTSIZELAST  = 0x00000011,
}

enum int HTCLOSE = 0x00000014;

enum : int
{
    SMTO_NORMAL      = 0x00000000,
    SMTO_BLOCK       = 0x00000001,
    SMTO_ABORTIFHUNG = 0x00000002,
}

enum int SMTO_ERRORONEXIT = 0x00000020;
enum int MA_ACTIVATEANDEAT = 0x00000002;
enum int MA_NOACTIVATEANDEAT = 0x00000004;

enum : int
{
    ICON_BIG    = 0x00000001,
    ICON_SMALL2 = 0x00000002,
}

enum : int
{
    SIZE_MINIMIZED = 0x00000001,
    SIZE_MAXIMIZED = 0x00000002,
    SIZE_MAXSHOW   = 0x00000003,
    SIZE_MAXHIDE   = 0x00000004,
}

enum int SIZEICONIC = 0x00000001;

enum : int
{
    SIZEZOOMSHOW = 0x00000003,
    SIZEZOOMHIDE = 0x00000004,
}

enum : int
{
    WVR_ALIGNLEFT   = 0x00000020,
    WVR_ALIGNBOTTOM = 0x00000040,
    WVR_ALIGNRIGHT  = 0x00000080,
}

enum int WVR_VREDRAW = 0x00000200;
enum int WVR_VALIDRECTS = 0x00000400;
enum int MK_RBUTTON = 0x00000002;
enum int MK_CONTROL = 0x00000008;

enum : int
{
    MK_XBUTTON1 = 0x00000020,
    MK_XBUTTON2 = 0x00000040,
}

enum : uint
{
    TME_LEAVE     = 0x00000002,
    TME_NONCLIENT = 0x00000010,
}

enum uint TME_CANCEL = 0x80000000;
enum uint WS_OVERLAPPED = 0x00000000;
enum uint WS_CHILD = 0x40000000;
enum uint WS_VISIBLE = 0x10000000;

enum : uint
{
    WS_CLIPSIBLINGS = 0x04000000,
    WS_CLIPCHILDREN = 0x02000000,
}

enum uint WS_CAPTION = 0x00c00000;
enum uint WS_DLGFRAME = 0x00400000;
enum uint WS_HSCROLL = 0x00100000;
enum uint WS_THICKFRAME = 0x00040000;
enum uint WS_TABSTOP = 0x00010000;
enum uint WS_MAXIMIZEBOX = 0x00010000;
enum uint WS_ICONIC = 0x20000000;
enum uint WS_TILEDWINDOW = 0x00cf0000;
enum uint WS_POPUPWINDOW = 0x80880000;
enum int WS_EX_DLGMODALFRAME = 0x00000001;

enum : int
{
    WS_EX_TOPMOST     = 0x00000008,
    WS_EX_ACCEPTFILES = 0x00000010,
}

enum : int
{
    WS_EX_MDICHILD   = 0x00000040,
    WS_EX_TOOLWINDOW = 0x00000080,
}

enum : int
{
    WS_EX_CLIENTEDGE  = 0x00000200,
    WS_EX_CONTEXTHELP = 0x00000400,
}

enum : int
{
    WS_EX_LEFT       = 0x00000000,
    WS_EX_RTLREADING = 0x00002000,
}

enum int WS_EX_LEFTSCROLLBAR = 0x00004000;
enum int WS_EX_CONTROLPARENT = 0x00010000;
enum int WS_EX_APPWINDOW = 0x00040000;
enum int WS_EX_PALETTEWINDOW = 0x00000188;
enum int WS_EX_NOREDIRECTIONBITMAP = 0x00200000;
enum int WS_EX_COMPOSITED = 0x02000000;
enum int CS_VREDRAW = 0x00000001;
enum int CS_DBLCLKS = 0x00000008;
enum int CS_CLASSDC = 0x00000040;
enum int CS_NOCLOSE = 0x00000200;

enum : int
{
    CS_BYTEALIGNCLIENT = 0x00001000,
    CS_BYTEALIGNWINDOW = 0x00002000,
}

enum : int
{
    CS_IME        = 0x00010000,
    CS_DROPSHADOW = 0x00020000,
}

enum int PRF_NONCLIENT = 0x00000002;
enum int PRF_ERASEBKGND = 0x00000008;
enum int PRF_OWNED = 0x00000020;
enum int BDR_SUNKENOUTER = 0x00000002;
enum int BDR_SUNKENINNER = 0x00000008;

enum : int
{
    BDR_INNER  = 0x0000000c,
    BDR_RAISED = 0x00000005,
}

enum : int
{
    EDGE_RAISED = 0x00000005,
    EDGE_SUNKEN = 0x0000000a,
    EDGE_ETCHED = 0x00000006,
    EDGE_BUMP   = 0x00000009,
}

enum : int
{
    BF_TOP   = 0x00000002,
    BF_RIGHT = 0x00000004,
}

enum : int
{
    BF_TOPLEFT  = 0x00000003,
    BF_TOPRIGHT = 0x00000006,
}

enum int BF_BOTTOMRIGHT = 0x0000000c;

enum : int
{
    BF_DIAGONAL                = 0x00000010,
    BF_DIAGONAL_ENDTOPRIGHT    = 0x00000016,
    BF_DIAGONAL_ENDTOPLEFT     = 0x00000013,
    BF_DIAGONAL_ENDBOTTOMLEFT  = 0x00000019,
    BF_DIAGONAL_ENDBOTTOMRIGHT = 0x0000001c,
}

enum : int
{
    BF_SOFT   = 0x00001000,
    BF_ADJUST = 0x00002000,
}

enum int BF_MONO = 0x00008000;

enum : int
{
    DFC_MENU   = 0x00000002,
    DFC_SCROLL = 0x00000003,
}

enum int DFC_POPUPMENU = 0x00000005;

enum : int
{
    DFCS_CAPTIONMIN     = 0x00000001,
    DFCS_CAPTIONMAX     = 0x00000002,
    DFCS_CAPTIONRESTORE = 0x00000003,
    DFCS_CAPTIONHELP    = 0x00000004,
}

enum : int
{
    DFCS_MENUCHECK      = 0x00000001,
    DFCS_MENUBULLET     = 0x00000002,
    DFCS_MENUARROWRIGHT = 0x00000004,
}

enum : int
{
    DFCS_SCROLLDOWN          = 0x00000001,
    DFCS_SCROLLLEFT          = 0x00000002,
    DFCS_SCROLLRIGHT         = 0x00000003,
    DFCS_SCROLLCOMBOBOX      = 0x00000005,
    DFCS_SCROLLSIZEGRIP      = 0x00000008,
    DFCS_SCROLLSIZEGRIPRIGHT = 0x00000010,
}

enum : int
{
    DFCS_BUTTONRADIOIMAGE = 0x00000001,
    DFCS_BUTTONRADIOMASK  = 0x00000002,
    DFCS_BUTTONRADIO      = 0x00000004,
    DFCS_BUTTON3STATE     = 0x00000008,
    DFCS_BUTTONPUSH       = 0x00000010,
}

enum : int
{
    DFCS_PUSHED      = 0x00000200,
    DFCS_CHECKED     = 0x00000400,
    DFCS_TRANSPARENT = 0x00000800,
}

enum int DFCS_ADJUSTRECT = 0x00002000;
enum int DFCS_MONO = 0x00008000;
enum int DC_SMALLCAP = 0x00000002;

enum : int
{
    DC_TEXT     = 0x00000008,
    DC_INBUTTON = 0x00000010,
}

enum int DC_BUTTONS = 0x00001000;
enum int IDANI_CAPTION = 0x00000003;
enum int CF_BITMAP = 0x00000002;

enum : int
{
    CF_SYLK    = 0x00000004,
    CF_DIF     = 0x00000005,
    CF_TIFF    = 0x00000006,
    CF_OEMTEXT = 0x00000007,
}

enum int CF_PALETTE = 0x00000009;

enum : int
{
    CF_RIFF        = 0x0000000b,
    CF_WAVE        = 0x0000000c,
    CF_UNICODETEXT = 0x0000000d,
}

enum int CF_HDROP = 0x0000000f;
enum int CF_DIBV5 = 0x00000011;
enum int CF_OWNERDISPLAY = 0x00000080;

enum : int
{
    CF_DSPBITMAP       = 0x00000082,
    CF_DSPMETAFILEPICT = 0x00000083,
}

enum : int
{
    CF_PRIVATEFIRST = 0x00000200,
    CF_PRIVATELAST  = 0x000002ff,
}

enum int CF_GDIOBJLAST = 0x000003ff;
enum int FNOINVERT = 0x00000002;
enum int FCONTROL = 0x00000008;
enum int WPF_SETMINPOSITION = 0x00000001;
enum int WPF_ASYNCWINDOWPLACEMENT = 0x00000004;
enum int ODT_LISTBOX = 0x00000002;
enum int ODT_BUTTON = 0x00000004;
enum int ODA_DRAWENTIRE = 0x00000001;
enum int ODA_FOCUS = 0x00000004;
enum int ODS_GRAYED = 0x00000002;
enum int ODS_CHECKED = 0x00000008;
enum int ODS_DEFAULT = 0x00000020;
enum int ODS_HOTLIGHT = 0x00000040;

enum : int
{
    ODS_NOACCEL     = 0x00000100,
    ODS_NOFOCUSRECT = 0x00000200,
}

enum int PM_REMOVE = 0x00000001;

enum : int
{
    PM_QS_INPUT       = 0x1c070000,
    PM_QS_POSTMESSAGE = 0x00980000,
    PM_QS_PAINT       = 0x00200000,
    PM_QS_SENDMESSAGE = 0x00400000,
}

enum int MOD_CONTROL = 0x00000002;

enum : int
{
    MOD_WIN      = 0x00000008,
    MOD_NOREPEAT = 0x00004000,
}

enum int IDHOT_SNAPDESKTOP = 0xfffffffe;

enum : uint
{
    ENDSESSION_CRITICAL = 0x40000000,
    ENDSESSION_LOGOFF   = 0x80000000,
}

enum int EWX_SHUTDOWN = 0x00000001;

enum : int
{
    EWX_FORCE    = 0x00000004,
    EWX_POWEROFF = 0x00000008,
}

enum int EWX_QUICKRESOLVE = 0x00000020;
enum int EWX_HYBRID_SHUTDOWN = 0x00400000;
enum int EWX_ARSO = 0x04000000;

enum : int
{
    BSM_VXDS      = 0x00000001,
    BSM_NETDRIVER = 0x00000002,
}

enum int BSM_APPLICATIONS = 0x00000008;

enum : int
{
    BSF_QUERY             = 0x00000001,
    BSF_IGNORECURRENTTASK = 0x00000002,
}

enum int BSF_NOHANG = 0x00000008;
enum int BSF_FORCEIFHUNG = 0x00000020;
enum int BSF_ALLOWSFW = 0x00000080;
enum int BSF_RETURNHDESK = 0x00000200;
enum int BROADCAST_QUERY_DENY = 0x424d5144;

enum : int
{
    DEVICE_NOTIFY_SERVICE_HANDLE        = 0x00000001,
    DEVICE_NOTIFY_ALL_INTERFACE_CLASSES = 0x00000004,
}

enum HWND HWND_MESSAGE = 0xfffffffd;

enum : int
{
    ISMEX_SEND     = 0x00000001,
    ISMEX_NOTIFY   = 0x00000002,
    ISMEX_CALLBACK = 0x00000004,
    ISMEX_REPLIED  = 0x00000008,
}

enum HWND HWND_DESKTOP = 0x00000000;
enum int PW_RENDERFULLCONTENT = 0x00000002;
enum int LWA_ALPHA = 0x00000002;

enum : int
{
    ULW_ALPHA  = 0x00000002,
    ULW_OPAQUE = 0x00000004,
}

enum : int
{
    FLASHW_STOP      = 0x00000000,
    FLASHW_CAPTION   = 0x00000001,
    FLASHW_TRAY      = 0x00000002,
    FLASHW_ALL       = 0x00000003,
    FLASHW_TIMER     = 0x00000004,
    FLASHW_TIMERNOFG = 0x0000000c,
}

enum int WDA_MONITOR = 0x00000001;

enum : int
{
    SWP_NOSIZE     = 0x00000001,
    SWP_NOMOVE     = 0x00000002,
    SWP_NOZORDER   = 0x00000004,
    SWP_NOREDRAW   = 0x00000008,
    SWP_NOACTIVATE = 0x00000010,
}

enum int SWP_SHOWWINDOW = 0x00000040;

enum : int
{
    SWP_NOCOPYBITS    = 0x00000100,
    SWP_NOOWNERZORDER = 0x00000200,
}

enum int SWP_DRAWFRAME = 0x00000020;
enum int SWP_DEFERERASE = 0x00002000;

enum : HWND
{
    HWND_TOP       = 0x00000000,
    HWND_BOTTOM    = 0x00000001,
    HWND_TOPMOST   = 0xffffffff,
    HWND_NOTOPMOST = 0xfffffffe,
}

enum : int
{
    KEYEVENTF_EXTENDEDKEY = 0x00000001,
    KEYEVENTF_KEYUP       = 0x00000002,
    KEYEVENTF_UNICODE     = 0x00000004,
    KEYEVENTF_SCANCODE    = 0x00000008,
}

enum : int
{
    MOUSEEVENTF_LEFTDOWN        = 0x00000002,
    MOUSEEVENTF_LEFTUP          = 0x00000004,
    MOUSEEVENTF_RIGHTDOWN       = 0x00000008,
    MOUSEEVENTF_RIGHTUP         = 0x00000010,
    MOUSEEVENTF_MIDDLEDOWN      = 0x00000020,
    MOUSEEVENTF_MIDDLEUP        = 0x00000040,
    MOUSEEVENTF_XDOWN           = 0x00000080,
    MOUSEEVENTF_XUP             = 0x00000100,
    MOUSEEVENTF_WHEEL           = 0x00000800,
    MOUSEEVENTF_HWHEEL          = 0x00001000,
    MOUSEEVENTF_MOVE_NOCOALESCE = 0x00002000,
    MOUSEEVENTF_VIRTUALDESK     = 0x00004000,
    MOUSEEVENTF_ABSOLUTE        = 0x00008000,
}

enum : int
{
    INPUT_KEYBOARD = 0x00000001,
    INPUT_HARDWARE = 0x00000002,
}

enum : int
{
    TOUCHEVENTF_DOWN       = 0x00000002,
    TOUCHEVENTF_UP         = 0x00000004,
    TOUCHEVENTF_INRANGE    = 0x00000008,
    TOUCHEVENTF_PRIMARY    = 0x00000010,
    TOUCHEVENTF_NOCOALESCE = 0x00000020,
    TOUCHEVENTF_PEN        = 0x00000040,
    TOUCHEVENTF_PALM       = 0x00000080,
}

enum : int
{
    TOUCHINPUTMASKF_EXTRAINFO   = 0x00000002,
    TOUCHINPUTMASKF_CONTACTAREA = 0x00000004,
}

enum int TWF_WANTPALM = 0x00000002;

enum : int
{
    POINTER_FLAG_NEW            = 0x00000001,
    POINTER_FLAG_INRANGE        = 0x00000002,
    POINTER_FLAG_INCONTACT      = 0x00000004,
    POINTER_FLAG_FIRSTBUTTON    = 0x00000010,
    POINTER_FLAG_SECONDBUTTON   = 0x00000020,
    POINTER_FLAG_THIRDBUTTON    = 0x00000040,
    POINTER_FLAG_FOURTHBUTTON   = 0x00000080,
    POINTER_FLAG_FIFTHBUTTON    = 0x00000100,
    POINTER_FLAG_PRIMARY        = 0x00002000,
    POINTER_FLAG_CONFIDENCE     = 0x00004000,
    POINTER_FLAG_CANCELED       = 0x00008000,
    POINTER_FLAG_DOWN           = 0x00010000,
    POINTER_FLAG_UPDATE         = 0x00020000,
    POINTER_FLAG_UP             = 0x00040000,
    POINTER_FLAG_WHEEL          = 0x00080000,
    POINTER_FLAG_HWHEEL         = 0x00100000,
    POINTER_FLAG_CAPTURECHANGED = 0x00200000,
    POINTER_FLAG_HASTRANSFORM   = 0x00400000,
}

enum int POINTER_MOD_CTRL = 0x00000008;

enum : int
{
    TOUCH_MASK_NONE        = 0x00000000,
    TOUCH_MASK_CONTACTAREA = 0x00000001,
    TOUCH_MASK_ORIENTATION = 0x00000002,
    TOUCH_MASK_PRESSURE    = 0x00000004,
}

enum : int
{
    PEN_FLAG_BARREL   = 0x00000001,
    PEN_FLAG_INVERTED = 0x00000002,
    PEN_FLAG_ERASER   = 0x00000004,
}

enum : int
{
    PEN_MASK_PRESSURE = 0x00000001,
    PEN_MASK_ROTATION = 0x00000002,
    PEN_MASK_TILT_X   = 0x00000004,
    PEN_MASK_TILT_Y   = 0x00000008,
}

enum : int
{
    POINTER_MESSAGE_FLAG_INRANGE      = 0x00000002,
    POINTER_MESSAGE_FLAG_INCONTACT    = 0x00000004,
    POINTER_MESSAGE_FLAG_FIRSTBUTTON  = 0x00000010,
    POINTER_MESSAGE_FLAG_SECONDBUTTON = 0x00000020,
    POINTER_MESSAGE_FLAG_THIRDBUTTON  = 0x00000040,
    POINTER_MESSAGE_FLAG_FOURTHBUTTON = 0x00000080,
    POINTER_MESSAGE_FLAG_FIFTHBUTTON  = 0x00000100,
    POINTER_MESSAGE_FLAG_PRIMARY      = 0x00002000,
    POINTER_MESSAGE_FLAG_CONFIDENCE   = 0x00004000,
    POINTER_MESSAGE_FLAG_CANCELED     = 0x00008000,
}

enum int PA_NOACTIVATE = 0x00000003;

enum : int
{
    TOUCH_FEEDBACK_DEFAULT  = 0x00000001,
    TOUCH_FEEDBACK_INDIRECT = 0x00000002,
    TOUCH_FEEDBACK_NONE     = 0x00000003,
}

enum : int
{
    TOUCH_HIT_TESTING_CLIENT             = 0x00000001,
    TOUCH_HIT_TESTING_NONE               = 0x00000002,
    TOUCH_HIT_TESTING_PROXIMITY_CLOSEST  = 0x00000000,
    TOUCH_HIT_TESTING_PROXIMITY_FARTHEST = 0x00000fff,
}

enum : int
{
    MAPVK_VK_TO_VSC    = 0x00000000,
    MAPVK_VSC_TO_VK    = 0x00000001,
    MAPVK_VK_TO_CHAR   = 0x00000002,
    MAPVK_VSC_TO_VK_EX = 0x00000003,
}

enum : int
{
    MWMO_WAITALL   = 0x00000001,
    MWMO_ALERTABLE = 0x00000002,
}

enum : int
{
    QS_KEY         = 0x00000001,
    QS_MOUSEMOVE   = 0x00000002,
    QS_MOUSEBUTTON = 0x00000004,
}

enum int QS_TIMER = 0x00000010;
enum int QS_SENDMESSAGE = 0x00000040;
enum int QS_ALLPOSTMESSAGE = 0x00000100;
enum int QS_TOUCH = 0x00000800;
enum int QS_MOUSE = 0x00000006;

enum : int
{
    QS_ALLEVENTS = 0x00001cbf,
    QS_ALLINPUT  = 0x00001cff,
}

enum int USER_TIMER_MINIMUM = 0x0000000a;
enum uint TIMERV_NO_COALESCING = 0xffffffff;
enum uint TIMERV_COALESCING_MAX = 0x7ffffff5;
enum int SM_CYSCREEN = 0x00000001;

enum : int
{
    SM_CYHSCROLL = 0x00000003,
    SM_CYCAPTION = 0x00000004,
}

enum int SM_CYBORDER = 0x00000006;
enum int SM_CYDLGFRAME = 0x00000008;

enum : int
{
    SM_CXHTHUMB = 0x0000000a,
    SM_CXICON   = 0x0000000b,
    SM_CYICON   = 0x0000000c,
    SM_CXCURSOR = 0x0000000d,
}

enum : int
{
    SM_CYMENU       = 0x0000000f,
    SM_CXFULLSCREEN = 0x00000010,
}

enum int SM_CYKANJIWINDOW = 0x00000012;
enum int SM_CYVSCROLL = 0x00000014;
enum int SM_DEBUG = 0x00000016;

enum : int
{
    SM_RESERVED1 = 0x00000018,
    SM_RESERVED2 = 0x00000019,
    SM_RESERVED3 = 0x0000001a,
    SM_RESERVED4 = 0x0000001b,
}

enum : int
{
    SM_CYMIN   = 0x0000001d,
    SM_CXSIZE  = 0x0000001e,
    SM_CYSIZE  = 0x0000001f,
    SM_CXFRAME = 0x00000020,
}

enum int SM_CXMINTRACK = 0x00000022;
enum int SM_CXDOUBLECLK = 0x00000024;
enum int SM_CXICONSPACING = 0x00000026;
enum int SM_MENUDROPALIGNMENT = 0x00000028;
enum int SM_DBCSENABLED = 0x0000002a;
enum int SM_CXFIXEDFRAME = 0x00000007;
enum int SM_CXSIZEFRAME = 0x00000020;
enum int SM_SECURE = 0x0000002c;

enum : int
{
    SM_CYEDGE       = 0x0000002e,
    SM_CXMINSPACING = 0x0000002f,
}

enum int SM_CXSMICON = 0x00000031;
enum int SM_CYSMCAPTION = 0x00000033;
enum int SM_CYSMSIZE = 0x00000035;
enum int SM_CYMENUSIZE = 0x00000037;
enum int SM_CXMINIMIZED = 0x00000039;
enum int SM_CXMAXTRACK = 0x0000003b;
enum int SM_CXMAXIMIZED = 0x0000003d;
enum int SM_NETWORK = 0x0000003f;

enum : int
{
    SM_CXDRAG = 0x00000044,
    SM_CYDRAG = 0x00000045,
}

enum int SM_CXMENUCHECK = 0x00000047;
enum int SM_SLOWMACHINE = 0x00000049;
enum int SM_MOUSEWHEELPRESENT = 0x0000004b;
enum int SM_YVIRTUALSCREEN = 0x0000004d;
enum int SM_CYVIRTUALSCREEN = 0x0000004f;
enum int SM_SAMEDISPLAYFORMAT = 0x00000051;
enum int SM_CXFOCUSBORDER = 0x00000053;
enum int SM_TABLETPC = 0x00000056;
enum int SM_STARTER = 0x00000058;
enum int SM_MOUSEHORIZONTALWHEELPRESENT = 0x0000005b;
enum int SM_DIGITIZER = 0x0000005e;
enum int SM_CMETRICS = 0x00000061;
enum int SM_SHUTTINGDOWN = 0x00002000;
enum int SM_CARETBLINKINGENABLED = 0x00002002;
enum int SM_SYSTEMDOCKED = 0x00002004;
enum int MNC_IGNORE = 0x00000000;
enum int MNC_EXECUTE = 0x00000002;
enum uint MNS_NOCHECK = 0x80000000;
enum uint MNS_DRAGDROP = 0x20000000;
enum uint MNS_NOTIFYBYPOS = 0x08000000;
enum uint MIM_MAXHEIGHT = 0x00000001;
enum uint MIM_HELPID = 0x00000004;

enum : uint
{
    MIM_STYLE           = 0x00000010,
    MIM_APPLYTOSUBMENUS = 0x80000000,
}

enum int MND_ENDMENU = 0x00000001;
enum int MNGOF_BOTTOMGAP = 0x00000002;
enum int MNGO_NOERROR = 0x00000001;

enum : int
{
    MIIM_ID         = 0x00000002,
    MIIM_SUBMENU    = 0x00000004,
    MIIM_CHECKMARKS = 0x00000008,
}

enum : int
{
    MIIM_DATA   = 0x00000020,
    MIIM_STRING = 0x00000040,
    MIIM_BITMAP = 0x00000080,
    MIIM_FTYPE  = 0x00000100,
}

enum : HBITMAP
{
    HBMMENU_SYSTEM          = 0x00000001,
    HBMMENU_MBAR_RESTORE    = 0x00000002,
    HBMMENU_MBAR_MINIMIZE   = 0x00000003,
    HBMMENU_MBAR_CLOSE      = 0x00000005,
    HBMMENU_MBAR_CLOSE_D    = 0x00000006,
    HBMMENU_MBAR_MINIMIZE_D = 0x00000007,
}

enum : HBITMAP
{
    HBMMENU_POPUP_RESTORE  = 0x00000009,
    HBMMENU_POPUP_MAXIMIZE = 0x0000000a,
    HBMMENU_POPUP_MINIMIZE = 0x0000000b,
}

enum int TPM_RIGHTBUTTON = 0x00000002;
enum int TPM_CENTERALIGN = 0x00000004;
enum int TPM_TOPALIGN = 0x00000000;
enum int TPM_BOTTOMALIGN = 0x00000020;
enum int TPM_VERTICAL = 0x00000040;

enum : int
{
    TPM_RETURNCMD = 0x00000100,
    TPM_RECURSE   = 0x00000001,
}

enum int TPM_HORNEGANIMATION = 0x00000800;
enum int TPM_VERNEGANIMATION = 0x00002000;
enum int TPM_LAYOUTRTL = 0x00008000;
enum int DOF_EXECUTABLE = 0x00008001;
enum int DOF_DIRECTORY = 0x00008003;
enum int DOF_PROGMAN = 0x00000001;
enum int DO_DROPFILE = 0x454c4946;

enum : int
{
    DT_TOP    = 0x00000000,
    DT_LEFT   = 0x00000000,
    DT_CENTER = 0x00000001,
}

enum int DT_VCENTER = 0x00000004;
enum int DT_WORDBREAK = 0x00000010;
enum int DT_EXPANDTABS = 0x00000040;
enum int DT_NOCLIP = 0x00000100;
enum int DT_CALCRECT = 0x00000400;
enum int DT_INTERNAL = 0x00001000;
enum int DT_PATH_ELLIPSIS = 0x00004000;
enum int DT_MODIFYSTRING = 0x00010000;
enum int DT_WORD_ELLIPSIS = 0x00040000;
enum int DT_HIDEPREFIX = 0x00100000;
enum int DST_COMPLEX = 0x00000000;
enum int DST_PREFIXTEXT = 0x00000002;
enum int DST_BITMAP = 0x00000004;

enum : int
{
    DSS_UNION    = 0x00000010,
    DSS_DISABLED = 0x00000020,
}

enum int DSS_HIDEPREFIX = 0x00000200;
enum int DSS_RIGHT = 0x00008000;

enum : int
{
    LSFW_LOCK   = 0x00000001,
    LSFW_UNLOCK = 0x00000002,
}

enum : int
{
    DCX_CACHE        = 0x00000002,
    DCX_NORESETATTRS = 0x00000004,
}

enum int DCX_CLIPSIBLINGS = 0x00000010;
enum int DCX_EXCLUDERGN = 0x00000040;
enum int DCX_EXCLUDEUPDATE = 0x00000100;
enum int DCX_LOCKWINDOWUPDATE = 0x00000400;

enum : int
{
    RDW_INVALIDATE    = 0x00000001,
    RDW_INTERNALPAINT = 0x00000002,
}

enum int RDW_VALIDATE = 0x00000008;

enum : int
{
    RDW_NOERASE    = 0x00000020,
    RDW_NOCHILDREN = 0x00000040,
}

enum int RDW_UPDATENOW = 0x00000100;

enum : int
{
    RDW_FRAME   = 0x00000400,
    RDW_NOFRAME = 0x00000800,
}

enum int SW_INVALIDATE = 0x00000002;
enum int SW_SMOOTHSCROLL = 0x00000010;

enum : int
{
    ESB_DISABLE_BOTH  = 0x00000003,
    ESB_DISABLE_LEFT  = 0x00000001,
    ESB_DISABLE_RIGHT = 0x00000002,
    ESB_DISABLE_UP    = 0x00000001,
    ESB_DISABLE_DOWN  = 0x00000002,
    ESB_DISABLE_LTUP  = 0x00000001,
    ESB_DISABLE_RTDN  = 0x00000002,
}

enum int HELPINFO_MENUITEM = 0x00000002;
enum int MB_OKCANCEL = 0x00000001;

enum : int
{
    MB_YESNOCANCEL = 0x00000003,
    MB_YESNO       = 0x00000004,
}

enum int MB_CANCELTRYCONTINUE = 0x00000006;

enum : int
{
    MB_ICONQUESTION    = 0x00000020,
    MB_ICONEXCLAMATION = 0x00000030,
}

enum int MB_USERICON = 0x00000080;

enum : int
{
    MB_ICONERROR       = 0x00000010,
    MB_ICONINFORMATION = 0x00000040,
}

enum : int
{
    MB_DEFBUTTON1 = 0x00000000,
    MB_DEFBUTTON2 = 0x00000100,
    MB_DEFBUTTON3 = 0x00000200,
    MB_DEFBUTTON4 = 0x00000300,
}

enum int MB_SYSTEMMODAL = 0x00001000;

enum : int
{
    MB_HELP    = 0x00004000,
    MB_NOFOCUS = 0x00008000,
}

enum int MB_DEFAULT_DESKTOP_ONLY = 0x00020000;

enum : int
{
    MB_RIGHT      = 0x00080000,
    MB_RTLREADING = 0x00100000,
}

enum int MB_SERVICE_NOTIFICATION_NT3X = 0x00040000;
enum int MB_ICONMASK = 0x000000f0;
enum int MB_MODEMASK = 0x00003000;

enum : int
{
    CWP_ALL             = 0x00000000,
    CWP_SKIPINVISIBLE   = 0x00000001,
    CWP_SKIPDISABLED    = 0x00000002,
    CWP_SKIPTRANSPARENT = 0x00000004,
}

enum : int
{
    CTLCOLOR_EDIT      = 0x00000001,
    CTLCOLOR_LISTBOX   = 0x00000002,
    CTLCOLOR_BTN       = 0x00000003,
    CTLCOLOR_DLG       = 0x00000004,
    CTLCOLOR_SCROLLBAR = 0x00000005,
    CTLCOLOR_STATIC    = 0x00000006,
    CTLCOLOR_MAX       = 0x00000007,
}

enum int COLOR_BACKGROUND = 0x00000001;
enum int COLOR_INACTIVECAPTION = 0x00000003;

enum : int
{
    COLOR_WINDOW      = 0x00000005,
    COLOR_WINDOWFRAME = 0x00000006,
}

enum int COLOR_WINDOWTEXT = 0x00000008;
enum int COLOR_ACTIVEBORDER = 0x0000000a;
enum int COLOR_APPWORKSPACE = 0x0000000c;
enum int COLOR_HIGHLIGHTTEXT = 0x0000000e;
enum int COLOR_BTNSHADOW = 0x00000010;

enum : int
{
    COLOR_BTNTEXT             = 0x00000012,
    COLOR_INACTIVECAPTIONTEXT = 0x00000013,
}

enum : int
{
    COLOR_3DDKSHADOW              = 0x00000015,
    COLOR_3DLIGHT                 = 0x00000016,
    COLOR_INFOTEXT                = 0x00000017,
    COLOR_INFOBK                  = 0x00000018,
    COLOR_HOTLIGHT                = 0x0000001a,
    COLOR_GRADIENTACTIVECAPTION   = 0x0000001b,
    COLOR_GRADIENTINACTIVECAPTION = 0x0000001c,
}

enum : int
{
    COLOR_MENUBAR     = 0x0000001e,
    COLOR_DESKTOP     = 0x00000001,
    COLOR_3DFACE      = 0x0000000f,
    COLOR_3DSHADOW    = 0x00000010,
    COLOR_3DHIGHLIGHT = 0x00000014,
    COLOR_3DHILIGHT   = 0x00000014,
}

enum : int
{
    GW_HWNDFIRST = 0x00000000,
    GW_HWNDLAST  = 0x00000001,
    GW_HWNDNEXT  = 0x00000002,
    GW_HWNDPREV  = 0x00000003,
}

enum int GW_CHILD = 0x00000005;
enum int GW_MAX = 0x00000006;
enum int MF_CHANGE = 0x00000080;
enum int MF_DELETE = 0x00000200;

enum : int
{
    MF_BYCOMMAND  = 0x00000000,
    MF_BYPOSITION = 0x00000400,
}

enum int MF_ENABLED = 0x00000000;
enum int MF_DISABLED = 0x00000002;
enum int MF_CHECKED = 0x00000008;
enum int MF_STRING = 0x00000000;
enum int MF_OWNERDRAW = 0x00000100;

enum : int
{
    MF_MENUBARBREAK = 0x00000020,
    MF_MENUBREAK    = 0x00000040,
}

enum int MF_HILITE = 0x00000080;
enum int MF_SYSMENU = 0x00002000;
enum int MF_RIGHTJUSTIFY = 0x00004000;
enum int MF_END = 0x00000080;
enum int MFT_BITMAP = 0x00000004;
enum int MFT_MENUBREAK = 0x00000040;
enum int MFT_RADIOCHECK = 0x00000200;

enum : int
{
    MFT_RIGHTORDER   = 0x00002000,
    MFT_RIGHTJUSTIFY = 0x00004000,
}

enum int MFS_DISABLED = 0x00000003;
enum int MFS_HILITE = 0x00000080;

enum : int
{
    MFS_UNCHECKED = 0x00000000,
    MFS_UNHILITE  = 0x00000000,
}

enum : int
{
    SC_SIZE     = 0x0000f000,
    SC_MOVE     = 0x0000f010,
    SC_MINIMIZE = 0x0000f020,
}

enum int SC_NEXTWINDOW = 0x0000f040;
enum int SC_CLOSE = 0x0000f060;
enum int SC_HSCROLL = 0x0000f080;
enum int SC_KEYMENU = 0x0000f100;
enum int SC_RESTORE = 0x0000f120;
enum int SC_SCREENSAVE = 0x0000f140;
enum int SC_DEFAULT = 0x0000f160;
enum int SC_CONTEXTHELP = 0x0000f180;
enum int SCF_ISSECURE = 0x00000001;
enum int SC_ZOOM = 0x0000f030;

enum : ushort
{
    IDC_IBEAM   = 0x7f01,
    IDC_WAIT    = 0x7f02,
    IDC_CROSS   = 0x7f03,
    IDC_UPARROW = 0x7f04,
}

enum : ushort
{
    deprecated("use IDC_ARROW") 
    IDC_ICON     = 0x7f81,
    IDC_SIZENWSE = 0x7f82,
    IDC_SIZENESW = 0x7f83,
    IDC_SIZEWE   = 0x7f84,
    IDC_SIZENS   = 0x7f85,
    IDC_SIZEALL  = 0x7f86,
}

enum ushort IDC_HAND = 0x7f89;

enum : int
{
    IDC_HELP   = 0x00007f8b,
    IDC_PIN    = 0x00007f9f,
    IDC_PERSON = 0x00007fa0,
}

enum : int
{
    IMAGE_ICON        = 0x00000001,
    IMAGE_CURSOR      = 0x00000002,
    IMAGE_ENHMETAFILE = 0x00000003,
}

enum int LR_MONOCHROME = 0x00000001;

enum : int
{
    LR_COPYRETURNORG = 0x00000004,
    LR_COPYDELETEORG = 0x00000008,
}

enum int LR_LOADTRANSPARENT = 0x00000020;
enum int LR_VGACOLOR = 0x00000080;
enum int LR_CREATEDIBSECTION = 0x00002000;
enum int LR_SHARED = 0x00008000;
enum int DI_IMAGE = 0x00000002;
enum int DI_COMPAT = 0x00000004;
enum int DI_NOMIRROR = 0x00000010;
enum int RES_CURSOR = 0x00000002;
enum int OBM_UPARROW = 0x00007ff1;
enum int OBM_RGARROW = 0x00007fef;
enum int OBM_REDUCE = 0x00007fed;

enum : int
{
    OBM_RESTORE = 0x00007feb,
    OBM_REDUCED = 0x00007fea,
}

enum int OBM_RESTORED = 0x00007fe8;
enum int OBM_DNARROWD = 0x00007fe6;
enum int OBM_LFARROWD = 0x00007fe4;

enum : int
{
    OBM_COMBO    = 0x00007fe2,
    OBM_UPARROWI = 0x00007fe1,
}

enum int OBM_RGARROWI = 0x00007fdf;
enum int OBM_OLD_CLOSE = 0x00007fff;

enum : int
{
    OBM_OLD_UPARROW = 0x00007ffd,
    OBM_OLD_DNARROW = 0x00007ffc,
    OBM_OLD_RGARROW = 0x00007ffb,
    OBM_OLD_LFARROW = 0x00007ffa,
}

enum : int
{
    OBM_CHECK      = 0x00007ff8,
    OBM_CHECKBOXES = 0x00007ff7,
}

enum : int
{
    OBM_OLD_REDUCE  = 0x00007ff5,
    OBM_OLD_ZOOM    = 0x00007ff4,
    OBM_OLD_RESTORE = 0x00007ff3,
}

enum : int
{
    OCR_IBEAM    = 0x00007f01,
    OCR_WAIT     = 0x00007f02,
    OCR_CROSS    = 0x00007f03,
    OCR_UP       = 0x00007f04,
    deprecated("use OCR_SIZEALL") 
    OCR_SIZE     = 0x00007f80,
    deprecated("use OCR_NORMAL") 
    OCR_ICON     = 0x00007f81,
    OCR_SIZENWSE = 0x00007f82,
    OCR_SIZENESW = 0x00007f83,
    OCR_SIZEWE   = 0x00007f84,
    OCR_SIZENS   = 0x00007f85,
    OCR_SIZEALL  = 0x00007f86,
}

enum : int
{
    OCR_NO          = 0x00007f88,
    OCR_HAND        = 0x00007f89,
    OCR_APPSTARTING = 0x00007f8a,
}

enum : int
{
    OIC_HAND    = 0x00007f01,
    OIC_QUES    = 0x00007f02,
    OIC_BANG    = 0x00007f03,
    OIC_NOTE    = 0x00007f04,
    OIC_WINLOGO = 0x00007f05,
    OIC_WARNING = 0x00007f03,
}

enum int OIC_INFORMATION = 0x00007f04;
enum int ORD_LANGDRIVER = 0x00000001;

enum : ushort
{
    IDI_HAND     = 0x7f01,
    IDI_QUESTION = 0x7f02,
}

enum ushort IDI_ASTERISK = 0x7f04;
enum ushort IDI_SHIELD = 0x7f06;

enum : ushort
{
    IDI_ERROR       = 0x7f01,
    IDI_INFORMATION = 0x7f04,
}

enum int IDCANCEL = 0x00000002;
enum int IDRETRY = 0x00000004;
enum int IDYES = 0x00000006;
enum int IDCLOSE = 0x00000008;
enum int IDTRYAGAIN = 0x0000000a;
enum int IDTIMEOUT = 0x00007d00;
enum int ES_CENTER = 0x00000001;
enum int ES_MULTILINE = 0x00000004;
enum int ES_LOWERCASE = 0x00000010;

enum : int
{
    ES_AUTOVSCROLL = 0x00000040,
    ES_AUTOHSCROLL = 0x00000080,
}

enum int ES_OEMCONVERT = 0x00000400;
enum int ES_WANTRETURN = 0x00001000;
enum int EN_SETFOCUS = 0x00000100;
enum int EN_CHANGE = 0x00000300;
enum int EN_ERRSPACE = 0x00000500;
enum int EN_HSCROLL = 0x00000601;

enum : int
{
    EN_ALIGN_LTR_EC = 0x00000700,
    EN_ALIGN_RTL_EC = 0x00000701,
}

enum int EN_AFTER_PASTE = 0x00000801;
enum int EC_RIGHTMARGIN = 0x00000002;
enum int EMSIS_COMPOSITIONSTRING = 0x00000001;
enum int EIMES_CANCELCOMPSTRINFOCUS = 0x00000002;
enum int EM_GETSEL = 0x000000b0;
enum int EM_GETRECT = 0x000000b2;
enum int EM_SETRECTNP = 0x000000b4;
enum int EM_LINESCROLL = 0x000000b6;
enum int EM_GETMODIFY = 0x000000b8;
enum int EM_GETLINECOUNT = 0x000000ba;
enum int EM_SETHANDLE = 0x000000bc;
enum int EM_GETTHUMB = 0x000000be;
enum int EM_REPLACESEL = 0x000000c2;
enum int EM_LIMITTEXT = 0x000000c5;

enum : int
{
    EM_UNDO     = 0x000000c7,
    EM_FMTLINES = 0x000000c8,
}

enum : int
{
    EM_SETTABSTOPS     = 0x000000cb,
    EM_SETPASSWORDCHAR = 0x000000cc,
}

enum int EM_GETFIRSTVISIBLELINE = 0x000000ce;
enum int EM_SETWORDBREAKPROC = 0x000000d0;
enum int EM_GETPASSWORDCHAR = 0x000000d2;
enum int EM_GETMARGINS = 0x000000d4;
enum int EM_GETLIMITTEXT = 0x000000d5;
enum int EM_CHARFROMPOS = 0x000000d7;
enum int EM_GETIMESTATUS = 0x000000d9;

enum : int
{
    WB_LEFT  = 0x00000000,
    WB_RIGHT = 0x00000001,
}

enum int BS_PUSHBUTTON = 0x00000000;
enum int BS_CHECKBOX = 0x00000002;
enum int BS_RADIOBUTTON = 0x00000004;
enum int BS_AUTO3STATE = 0x00000006;
enum int BS_USERBUTTON = 0x00000008;
enum int BS_PUSHBOX = 0x0000000a;
enum int BS_TYPEMASK = 0x0000000f;

enum : int
{
    BS_TEXT   = 0x00000000,
    BS_ICON   = 0x00000040,
    BS_BITMAP = 0x00000080,
}

enum int BS_RIGHT = 0x00000200;

enum : int
{
    BS_TOP    = 0x00000400,
    BS_BOTTOM = 0x00000800,
}

enum int BS_PUSHLIKE = 0x00001000;
enum int BS_NOTIFY = 0x00004000;
enum int BS_RIGHTBUTTON = 0x00000020;
enum int BN_PAINT = 0x00000001;
enum int BN_UNHILITE = 0x00000003;
enum int BN_DOUBLECLICKED = 0x00000005;
enum int BN_UNPUSHED = 0x00000003;
enum int BN_SETFOCUS = 0x00000006;
enum int BM_GETCHECK = 0x000000f0;
enum int BM_GETSTATE = 0x000000f2;
enum int BM_SETSTYLE = 0x000000f4;
enum int BM_GETIMAGE = 0x000000f6;
enum int BM_SETDONTCLICK = 0x000000f8;
enum int BST_CHECKED = 0x00000001;
enum int BST_PUSHED = 0x00000004;

enum : int
{
    SS_LEFT   = 0x00000000,
    SS_CENTER = 0x00000001,
}

enum : int
{
    SS_ICON      = 0x00000003,
    SS_BLACKRECT = 0x00000004,
}

enum int SS_WHITERECT = 0x00000006;
enum int SS_GRAYFRAME = 0x00000008;
enum int SS_USERITEM = 0x0000000a;
enum int SS_LEFTNOWORDWRAP = 0x0000000c;
enum int SS_BITMAP = 0x0000000e;

enum : int
{
    SS_ETCHEDHORZ  = 0x00000010,
    SS_ETCHEDVERT  = 0x00000011,
    SS_ETCHEDFRAME = 0x00000012,
}

enum int SS_REALSIZECONTROL = 0x00000040;
enum int SS_NOTIFY = 0x00000100;
enum int SS_RIGHTJUST = 0x00000400;
enum int SS_SUNKEN = 0x00001000;
enum int SS_ENDELLIPSIS = 0x00004000;
enum int SS_WORDELLIPSIS = 0x0000c000;
enum int STM_SETICON = 0x00000170;
enum int STM_SETIMAGE = 0x00000172;
enum int STN_CLICKED = 0x00000000;
enum int STN_ENABLE = 0x00000002;
enum int STM_MSGMAX = 0x00000174;
enum int DWL_MSGRESULT = 0x00000000;
enum int DWL_USER = 0x00000008;

enum : int
{
    DDL_READWRITE = 0x00000000,
    DDL_READONLY  = 0x00000001,
}

enum int DDL_SYSTEM = 0x00000004;
enum int DDL_ARCHIVE = 0x00000020;
enum int DDL_DRIVES = 0x00004000;
enum int DS_ABSALIGN = 0x00000001;
enum int DS_LOCALEDIT = 0x00000020;
enum int DS_MODALFRAME = 0x00000080;
enum int DS_SETFOREGROUND = 0x00000200;
enum int DS_FIXEDSYS = 0x00000008;
enum int DS_CONTROL = 0x00000400;
enum int DS_CENTERMOUSE = 0x00001000;
enum int DS_SHELLFONT = 0x00000048;
enum int DM_GETDEFID = 0x00000400;
enum int DM_REPOSITION = 0x00000402;

enum : int
{
    DLGC_WANTARROWS  = 0x00000001,
    DLGC_WANTTAB     = 0x00000002,
    DLGC_WANTALLKEYS = 0x00000004,
    DLGC_WANTMESSAGE = 0x00000004,
}

enum int DLGC_DEFPUSHBUTTON = 0x00000010;
enum int DLGC_RADIOBUTTON = 0x00000040;

enum : int
{
    DLGC_STATIC = 0x00000100,
    DLGC_BUTTON = 0x00002000,
}

enum : int
{
    LB_OKAY     = 0x00000000,
    LB_ERR      = 0xffffffff,
    LB_ERRSPACE = 0xfffffffe,
}

enum int LBN_SELCHANGE = 0x00000001;

enum : int
{
    LBN_SELCANCEL = 0x00000003,
    LBN_SETFOCUS  = 0x00000004,
}

enum int LB_ADDSTRING = 0x00000180;
enum int LB_DELETESTRING = 0x00000182;
enum int LB_RESETCONTENT = 0x00000184;
enum int LB_SETCURSEL = 0x00000186;

enum : int
{
    LB_GETCURSEL  = 0x00000188,
    LB_GETTEXT    = 0x00000189,
    LB_GETTEXTLEN = 0x0000018a,
    LB_GETCOUNT   = 0x0000018b,
}

enum : int
{
    LB_DIR         = 0x0000018d,
    LB_GETTOPINDEX = 0x0000018e,
}

enum : int
{
    LB_GETSELCOUNT = 0x00000190,
    LB_GETSELITEMS = 0x00000191,
}

enum int LB_GETHORIZONTALEXTENT = 0x00000193;
enum int LB_SETCOLUMNWIDTH = 0x00000195;
enum int LB_SETTOPINDEX = 0x00000197;
enum int LB_GETITEMDATA = 0x00000199;
enum int LB_SELITEMRANGE = 0x0000019b;
enum int LB_GETANCHORINDEX = 0x0000019d;
enum int LB_GETCARETINDEX = 0x0000019f;
enum int LB_GETITEMHEIGHT = 0x000001a1;
enum int LB_SETLOCALE = 0x000001a5;
enum int LB_SETCOUNT = 0x000001a7;
enum int LB_ITEMFROMPOINT = 0x000001a9;
enum int LB_GETLISTBOXINFO = 0x000001b2;
enum uint LBS_NOTIFY = 0x00000001;
enum uint LBS_NOREDRAW = 0x00000004;

enum : uint
{
    LBS_OWNERDRAWFIXED    = 0x00000010,
    LBS_OWNERDRAWVARIABLE = 0x00000020,
}

enum uint LBS_USETABSTOPS = 0x00000080;
enum uint LBS_MULTICOLUMN = 0x00000200;
enum uint LBS_EXTENDEDSEL = 0x00000800;

enum : uint
{
    LBS_NODATA   = 0x00002000,
    LBS_NOSEL    = 0x00004000,
    LBS_COMBOBOX = 0x00008000,
}

enum : int
{
    CB_OKAY     = 0x00000000,
    CB_ERR      = 0xffffffff,
    CB_ERRSPACE = 0xfffffffe,
}

enum int CBN_SELCHANGE = 0x00000001;
enum int CBN_SETFOCUS = 0x00000003;

enum : int
{
    CBN_EDITCHANGE = 0x00000005,
    CBN_EDITUPDATE = 0x00000006,
}

enum int CBN_CLOSEUP = 0x00000008;
enum int CBN_SELENDCANCEL = 0x0000000a;

enum : int
{
    CBS_DROPDOWN     = 0x00000002,
    CBS_DROPDOWNLIST = 0x00000003,
}

enum int CBS_OWNERDRAWVARIABLE = 0x00000020;
enum int CBS_OEMCONVERT = 0x00000080;
enum int CBS_HASSTRINGS = 0x00000200;
enum int CBS_DISABLENOSCROLL = 0x00000800;
enum int CBS_LOWERCASE = 0x00004000;
enum int CB_LIMITTEXT = 0x00000141;
enum int CB_ADDSTRING = 0x00000143;

enum : int
{
    CB_DIR          = 0x00000145,
    CB_GETCOUNT     = 0x00000146,
    CB_GETCURSEL    = 0x00000147,
    CB_GETLBTEXT    = 0x00000148,
    CB_GETLBTEXTLEN = 0x00000149,
}

enum int CB_RESETCONTENT = 0x0000014b;
enum int CB_SELECTSTRING = 0x0000014d;
enum int CB_SHOWDROPDOWN = 0x0000014f;
enum int CB_SETITEMDATA = 0x00000151;
enum int CB_SETITEMHEIGHT = 0x00000153;
enum int CB_SETEXTENDEDUI = 0x00000155;
enum int CB_GETDROPPEDSTATE = 0x00000157;
enum int CB_SETLOCALE = 0x00000159;
enum int CB_GETTOPINDEX = 0x0000015b;
enum int CB_GETHORIZONTALEXTENT = 0x0000015d;
enum int CB_GETDROPPEDWIDTH = 0x0000015f;
enum int CB_INITSTORAGE = 0x00000161;
enum int CB_GETCOMBOBOXINFO = 0x00000164;

enum : int
{
    SBS_HORZ     = 0x00000000,
    SBS_VERT     = 0x00000001,
    SBS_TOPALIGN = 0x00000002,
}

enum int SBS_BOTTOMALIGN = 0x00000004;

enum : int
{
    SBS_SIZEBOXTOPLEFTALIGN     = 0x00000002,
    SBS_SIZEBOXBOTTOMRIGHTALIGN = 0x00000004,
    SBS_SIZEBOX                 = 0x00000008,
    SBS_SIZEGRIP                = 0x00000010,
}

enum int SBM_GETPOS = 0x000000e1;
enum int SBM_SETRANGEREDRAW = 0x000000e6;
enum int SBM_ENABLE_ARROWS = 0x000000e4;

enum : int
{
    SBM_GETSCROLLINFO    = 0x000000ea,
    SBM_GETSCROLLBARINFO = 0x000000eb,
}

enum : int
{
    SIF_PAGE            = 0x00000002,
    SIF_POS             = 0x00000004,
    SIF_DISABLENOSCROLL = 0x00000008,
}

enum int SIF_ALL = 0x00000017;

enum : int
{
    MDITILE_VERTICAL     = 0x00000000,
    MDITILE_HORIZONTAL   = 0x00000001,
    MDITILE_SKIPDISABLED = 0x00000002,
}

enum : int
{
    HELP_CONTEXT  = 0x00000001,
    HELP_QUIT     = 0x00000002,
    HELP_INDEX    = 0x00000003,
    HELP_CONTENTS = 0x00000003,
}

enum : int
{
    HELP_SETINDEX    = 0x00000005,
    HELP_SETCONTENTS = 0x00000005,
}

enum int HELP_FORCEFILE = 0x00000009;

enum : int
{
    HELP_COMMAND    = 0x00000102,
    HELP_PARTIALKEY = 0x00000105,
}

enum int HELP_SETWINPOS = 0x00000203;

enum : int
{
    HELP_FINDER       = 0x0000000b,
    HELP_WM_HELP      = 0x0000000c,
    HELP_SETPOPUP_POS = 0x0000000d,
}

enum : int
{
    HELP_TCARD_DATA         = 0x00000010,
    HELP_TCARD_OTHER_CALLER = 0x00000011,
}

enum int IDH_MISSING_CONTEXT = 0x00006f19;

enum : int
{
    IDH_OK     = 0x00006f1b,
    IDH_CANCEL = 0x00006f1c,
}

enum int GR_GDIOBJECTS = 0x00000000;
enum int GR_GDIOBJECTS_PEAK = 0x00000002;
enum int GR_GLOBAL = 0xfffffffe;
enum int SPI_SETBEEP = 0x00000002;
enum int SPI_SETMOUSE = 0x00000004;
enum int SPI_SETBORDER = 0x00000006;
enum int SPI_SETKEYBOARDSPEED = 0x0000000b;
enum int SPI_ICONHORIZONTALSPACING = 0x0000000d;
enum int SPI_SETSCREENSAVETIMEOUT = 0x0000000f;
enum int SPI_SETSCREENSAVEACTIVE = 0x00000011;
enum int SPI_SETGRIDGRANULARITY = 0x00000013;
enum int SPI_SETDESKPATTERN = 0x00000015;
enum int SPI_SETKEYBOARDDELAY = 0x00000017;
enum int SPI_GETICONTITLEWRAP = 0x00000019;
enum int SPI_GETMENUDROPALIGNMENT = 0x0000001b;

enum : int
{
    SPI_SETDOUBLECLKWIDTH  = 0x0000001d,
    SPI_SETDOUBLECLKHEIGHT = 0x0000001e,
}

enum int SPI_SETDOUBLECLICKTIME = 0x00000020;
enum int SPI_SETICONTITLELOGFONT = 0x00000022;
enum int SPI_SETFASTTASKSWITCH = 0x00000024;
enum int SPI_GETDRAGFULLWINDOWS = 0x00000026;
enum int SPI_SETNONCLIENTMETRICS = 0x0000002a;
enum int SPI_SETMINIMIZEDMETRICS = 0x0000002c;
enum int SPI_SETICONMETRICS = 0x0000002e;
enum int SPI_GETWORKAREA = 0x00000030;
enum int SPI_GETHIGHCONTRAST = 0x00000042;
enum int SPI_GETKEYBOARDPREF = 0x00000044;
enum int SPI_GETSCREENREADER = 0x00000046;
enum int SPI_GETANIMATION = 0x00000048;
enum int SPI_GETFONTSMOOTHING = 0x0000004a;

enum : int
{
    SPI_SETDRAGWIDTH  = 0x0000004c,
    SPI_SETDRAGHEIGHT = 0x0000004d,
    SPI_SETHANDHELD   = 0x0000004e,
}

enum int SPI_GETPOWEROFFTIMEOUT = 0x00000050;
enum int SPI_SETPOWEROFFTIMEOUT = 0x00000052;
enum int SPI_GETPOWEROFFACTIVE = 0x00000054;
enum int SPI_SETPOWEROFFACTIVE = 0x00000056;
enum int SPI_SETICONS = 0x00000058;
enum int SPI_SETDEFAULTINPUTLANG = 0x0000005a;
enum int SPI_GETWINDOWSEXTENSION = 0x0000005c;
enum int SPI_GETMOUSETRAILS = 0x0000005e;
enum int SPI_SCREENSAVERRUNNING = 0x00000061;
enum int SPI_SETFILTERKEYS = 0x00000033;
enum int SPI_SETTOGGLEKEYS = 0x00000035;
enum int SPI_SETMOUSEKEYS = 0x00000037;
enum int SPI_SETSHOWSOUNDS = 0x00000039;
enum int SPI_SETSTICKYKEYS = 0x0000003b;
enum int SPI_SETACCESSTIMEOUT = 0x0000003d;
enum int SPI_SETSERIALKEYS = 0x0000003f;
enum int SPI_SETSOUNDSENTRY = 0x00000041;
enum int SPI_SETSNAPTODEFBUTTON = 0x00000060;
enum int SPI_SETMOUSEHOVERWIDTH = 0x00000063;
enum int SPI_SETMOUSEHOVERHEIGHT = 0x00000065;
enum int SPI_SETMOUSEHOVERTIME = 0x00000067;
enum int SPI_SETWHEELSCROLLLINES = 0x00000069;
enum int SPI_SETMENUSHOWDELAY = 0x0000006b;
enum int SPI_SETWHEELSCROLLCHARS = 0x0000006d;
enum int SPI_SETSHOWIMEUI = 0x0000006f;
enum int SPI_SETMOUSESPEED = 0x00000071;
enum int SPI_GETDESKWALLPAPER = 0x00000073;
enum int SPI_SETAUDIODESCRIPTION = 0x00000075;
enum int SPI_SETSCREENSAVESECURE = 0x00000077;
enum int SPI_SETHUNGAPPTIMEOUT = 0x00000079;
enum int SPI_SETWAITTOKILLTIMEOUT = 0x0000007b;
enum int SPI_SETWAITTOKILLSERVICETIMEOUT = 0x0000007d;
enum int SPI_SETMOUSEDOCKTHRESHOLD = 0x0000007f;
enum int SPI_SETPENDOCKTHRESHOLD = 0x00000081;
enum int SPI_SETWINARRANGING = 0x00000083;
enum int SPI_SETMOUSEDRAGOUTTHRESHOLD = 0x00000085;
enum int SPI_SETPENDRAGOUTTHRESHOLD = 0x00000087;
enum int SPI_SETMOUSESIDEMOVETHRESHOLD = 0x00000089;
enum int SPI_SETPENSIDEMOVETHRESHOLD = 0x0000008b;
enum int SPI_SETDRAGFROMMAXIMIZE = 0x0000008d;
enum int SPI_SETSNAPSIZING = 0x0000008f;
enum int SPI_SETDOCKMOVING = 0x00000091;

enum : int
{
    TOUCHPREDICTIONPARAMETERS_DEFAULT_LATENCY          = 0x00000008,
    TOUCHPREDICTIONPARAMETERS_DEFAULT_SAMPLETIME       = 0x00000008,
    TOUCHPREDICTIONPARAMETERS_DEFAULT_USE_HW_TIMESTAMP = 0x00000001,
}

enum : float
{
    TOUCHPREDICTIONPARAMETERS_DEFAULT_RLS_LAMBDA_MIN           = 0x1.ccccccp-1,
    TOUCHPREDICTIONPARAMETERS_DEFAULT_RLS_LAMBDA_MAX           = 0x1.ff7ceep-1,
    TOUCHPREDICTIONPARAMETERS_DEFAULT_RLS_LAMBDA_LEARNING_RATE = 0x1.0624dep-10,
    TOUCHPREDICTIONPARAMETERS_DEFAULT_RLS_EXPO_SMOOTH_ALPHA    = 0x1.fae148p-1,
}

enum int SPI_SETTOUCHPREDICTIONPARAMETERS = 0x0000009d;
enum int MIN_LOGICALDPIOVERRIDE = 0xfffffffe;
enum int SPI_SETLOGICALDPIOVERRIDE = 0x0000009f;
enum int SPI_SETMENURECT = 0x000000a3;
enum int SPI_SETACTIVEWINDOWTRACKING = 0x00001001;
enum int SPI_SETMENUANIMATION = 0x00001003;
enum int SPI_SETCOMBOBOXANIMATION = 0x00001005;
enum int SPI_SETLISTBOXSMOOTHSCROLLING = 0x00001007;
enum int SPI_SETGRADIENTCAPTIONS = 0x00001009;
enum int SPI_SETKEYBOARDCUES = 0x0000100b;
enum int SPI_SETMENUUNDERLINES = 0x0000100b;
enum int SPI_SETACTIVEWNDTRKZORDER = 0x0000100d;
enum int SPI_SETHOTTRACKING = 0x0000100f;
enum int SPI_SETMENUFADE = 0x00001013;
enum int SPI_SETSELECTIONFADE = 0x00001015;
enum int SPI_SETTOOLTIPANIMATION = 0x00001017;
enum int SPI_SETTOOLTIPFADE = 0x00001019;
enum int SPI_SETCURSORSHADOW = 0x0000101b;
enum int SPI_SETMOUSESONAR = 0x0000101d;
enum int SPI_SETMOUSECLICKLOCK = 0x0000101f;
enum int SPI_SETMOUSEVANISH = 0x00001021;
enum int SPI_SETFLATMENU = 0x00001023;
enum int SPI_SETDROPSHADOW = 0x00001025;
enum int SPI_SETBLOCKSENDINPUTRESETS = 0x00001027;
enum int SPI_SETUIEFFECTS = 0x0000103f;
enum int SPI_SETDISABLEOVERLAPPEDCONTENT = 0x00001041;
enum int SPI_SETCLIENTAREAANIMATION = 0x00001043;
enum int SPI_SETCLEARTYPE = 0x00001049;
enum int SPI_SETSPEECHRECOGNITION = 0x0000104b;
enum int SPI_SETCARETBROWSING = 0x0000104d;
enum int SPI_SETTHREADLOCALINPUTSETTINGS = 0x0000104f;
enum int SPI_SETSYSTEMLANGUAGEBAR = 0x00001051;
enum int SPI_SETFOREGROUNDLOCKTIMEOUT = 0x00002001;
enum int SPI_SETACTIVEWNDTRKTIMEOUT = 0x00002003;
enum int SPI_SETFOREGROUNDFLASHCOUNT = 0x00002005;
enum int SPI_SETCARETWIDTH = 0x00002007;
enum int SPI_SETMOUSECLICKLOCKTIME = 0x00002009;
enum int SPI_SETFONTSMOOTHINGTYPE = 0x0000200b;
enum int FE_FONTSMOOTHINGCLEARTYPE = 0x00000002;
enum int SPI_SETFONTSMOOTHINGCONTRAST = 0x0000200d;
enum int SPI_SETFOCUSBORDERWIDTH = 0x0000200f;
enum int SPI_SETFOCUSBORDERHEIGHT = 0x00002011;
enum int SPI_SETFONTSMOOTHINGORIENTATION = 0x00002013;
enum int FE_FONTSMOOTHINGORIENTATIONRGB = 0x00000001;
enum int SPI_SETMINIMUMHITRADIUS = 0x00002015;
enum int SPI_SETMESSAGEDURATION = 0x00002017;
enum int SPI_SETCONTACTVISUALIZATION = 0x00002019;

enum : int
{
    CONTACTVISUALIZATION_ON               = 0x00000001,
    CONTACTVISUALIZATION_PRESENTATIONMODE = 0x00000002,
}

enum int SPI_SETGESTUREVISUALIZATION = 0x0000201b;

enum : int
{
    GESTUREVISUALIZATION_ON           = 0x0000001f,
    GESTUREVISUALIZATION_TAP          = 0x00000001,
    GESTUREVISUALIZATION_DOUBLETAP    = 0x00000002,
    GESTUREVISUALIZATION_PRESSANDTAP  = 0x00000004,
    GESTUREVISUALIZATION_PRESSANDHOLD = 0x00000008,
    GESTUREVISUALIZATION_RIGHTTAP     = 0x00000010,
}

enum int SPI_SETMOUSEWHEELROUTING = 0x0000201d;

enum : int
{
    MOUSEWHEEL_ROUTING_HYBRID    = 0x00000001,
    MOUSEWHEEL_ROUTING_MOUSE_POS = 0x00000002,
}

enum int SPI_SETPENVISUALIZATION = 0x0000201f;

enum : int
{
    PENVISUALIZATION_OFF       = 0x00000000,
    PENVISUALIZATION_TAP       = 0x00000001,
    PENVISUALIZATION_DOUBLETAP = 0x00000002,
    PENVISUALIZATION_CURSOR    = 0x00000020,
}

enum int SPI_SETPENARBITRATIONTYPE = 0x00002021;

enum : int
{
    PENARBITRATIONTYPE_WIN8 = 0x00000001,
    PENARBITRATIONTYPE_FIS  = 0x00000002,
    PENARBITRATIONTYPE_SPT  = 0x00000003,
    PENARBITRATIONTYPE_MAX  = 0x00000004,
}

enum int SPI_SETCARETTIMEOUT = 0x00002023;
enum int SPI_SETHANDEDNESS = 0x00002025;

enum : int
{
    SPIF_SENDWININICHANGE = 0x00000002,
    SPIF_SENDCHANGE       = 0x00000002,
}

enum : int
{
    ARW_BOTTOMLEFT  = 0x00000000,
    ARW_BOTTOMRIGHT = 0x00000001,
}

enum int ARW_TOPRIGHT = 0x00000003;

enum : int
{
    ARW_STARTRIGHT = 0x00000001,
    ARW_STARTTOP   = 0x00000002,
}

enum : int
{
    ARW_RIGHT = 0x00000000,
    ARW_UP    = 0x00000004,
    ARW_DOWN  = 0x00000004,
    ARW_HIDE  = 0x00000008,
}

enum int SERKF_AVAILABLE = 0x00000002;
enum int HCF_HIGHCONTRASTON = 0x00000001;
enum int HCF_HOTKEYACTIVE = 0x00000004;
enum int HCF_HOTKEYSOUND = 0x00000010;
enum int HCF_HOTKEYAVAILABLE = 0x00000040;
enum int HCF_DEFAULTDESKTOP = 0x00000200;
enum int CDS_UPDATEREGISTRY = 0x00000001;
enum int CDS_FULLSCREEN = 0x00000004;
enum int CDS_SET_PRIMARY = 0x00000010;
enum int CDS_ENABLE_UNSAFE_MODES = 0x00000100;

enum : int
{
    CDS_RESET    = 0x40000000,
    CDS_RESET_EX = 0x20000000,
}

enum : int
{
    DISP_CHANGE_SUCCESSFUL  = 0x00000000,
    DISP_CHANGE_RESTART     = 0x00000001,
    DISP_CHANGE_FAILED      = 0xffffffff,
    DISP_CHANGE_BADMODE     = 0xfffffffe,
    DISP_CHANGE_NOTUPDATED  = 0xfffffffd,
    DISP_CHANGE_BADFLAGS    = 0xfffffffc,
    DISP_CHANGE_BADPARAM    = 0xfffffffb,
    DISP_CHANGE_BADDUALVIEW = 0xfffffffa,
}

enum uint ENUM_REGISTRY_SETTINGS = 0xfffffffe;
enum int EDS_ROTATEDMODE = 0x00000004;
enum int FKF_FILTERKEYSON = 0x00000001;
enum int FKF_HOTKEYACTIVE = 0x00000004;
enum int FKF_HOTKEYSOUND = 0x00000010;
enum int FKF_CLICKON = 0x00000040;
enum uint SKF_AVAILABLE = 0x00000002;
enum uint SKF_CONFIRMHOTKEY = 0x00000008;
enum uint SKF_INDICATOR = 0x00000020;

enum : uint
{
    SKF_TRISTATE   = 0x00000080,
    SKF_TWOKEYSOFF = 0x00000100,
}

enum uint SKF_LCTLLATCHED = 0x04000000;
enum uint SKF_RALTLATCHED = 0x20000000;
enum uint SKF_RSHIFTLATCHED = 0x02000000;
enum uint SKF_RWINLATCHED = 0x80000000;
enum uint SKF_LCTLLOCKED = 0x00040000;
enum uint SKF_RALTLOCKED = 0x00200000;
enum uint SKF_RSHIFTLOCKED = 0x00020000;
enum uint SKF_RWINLOCKED = 0x00800000;
enum uint MKF_AVAILABLE = 0x00000002;
enum uint MKF_CONFIRMHOTKEY = 0x00000008;
enum uint MKF_INDICATOR = 0x00000020;
enum uint MKF_REPLACENUMBERS = 0x00000080;
enum uint MKF_RIGHTBUTTONSEL = 0x20000000;
enum uint MKF_RIGHTBUTTONDOWN = 0x02000000;
enum int ATF_TIMEOUTON = 0x00000001;

enum : int
{
    SSGF_NONE    = 0x00000000,
    SSGF_DISPLAY = 0x00000003,
}

enum : int
{
    SSTF_CHARS   = 0x00000001,
    SSTF_BORDER  = 0x00000002,
    SSTF_DISPLAY = 0x00000003,
}

enum : int
{
    SSWF_TITLE   = 0x00000001,
    SSWF_WINDOW  = 0x00000002,
    SSWF_DISPLAY = 0x00000003,
    SSWF_CUSTOM  = 0x00000004,
}

enum int SSF_AVAILABLE = 0x00000002;
enum int TKF_TOGGLEKEYSON = 0x00000001;
enum int TKF_HOTKEYACTIVE = 0x00000004;
enum int TKF_HOTKEYSOUND = 0x00000010;

enum : int
{
    SLE_ERROR      = 0x00000001,
    SLE_MINORERROR = 0x00000002,
}

enum : int
{
    MONITOR_DEFAULTTONULL    = 0x00000000,
    MONITOR_DEFAULTTOPRIMARY = 0x00000001,
    MONITOR_DEFAULTTONEAREST = 0x00000002,
}

enum int CCHDEVICENAME = 0x00000020;

enum : int
{
    WINEVENT_SKIPOWNTHREAD  = 0x00000001,
    WINEVENT_SKIPOWNPROCESS = 0x00000002,
}

enum int CHILDID_SELF = 0x00000000;
enum int INDEXID_CONTAINER = 0x00000000;

enum : int
{
    OBJID_SYSMENU           = 0xffffffff,
    OBJID_TITLEBAR          = 0xfffffffe,
    OBJID_MENU              = 0xfffffffd,
    OBJID_CLIENT            = 0xfffffffc,
    OBJID_VSCROLL           = 0xfffffffb,
    OBJID_HSCROLL           = 0xfffffffa,
    OBJID_SIZEGRIP          = 0xfffffff9,
    OBJID_CARET             = 0xfffffff8,
    OBJID_CURSOR            = 0xfffffff7,
    OBJID_ALERT             = 0xfffffff6,
    OBJID_SOUND             = 0xfffffff5,
    OBJID_QUERYCLASSNAMEIDX = 0xfffffff4,
}

enum : int
{
    EVENT_MIN                           = 0x00000001,
    EVENT_MAX                           = 0x7fffffff,
    EVENT_SYSTEM_SOUND                  = 0x00000001,
    EVENT_SYSTEM_ALERT                  = 0x00000002,
    EVENT_SYSTEM_FOREGROUND             = 0x00000003,
    EVENT_SYSTEM_MENUSTART              = 0x00000004,
    EVENT_SYSTEM_MENUEND                = 0x00000005,
    EVENT_SYSTEM_MENUPOPUPSTART         = 0x00000006,
    EVENT_SYSTEM_MENUPOPUPEND           = 0x00000007,
    EVENT_SYSTEM_CAPTURESTART           = 0x00000008,
    EVENT_SYSTEM_CAPTUREEND             = 0x00000009,
    EVENT_SYSTEM_MOVESIZESTART          = 0x0000000a,
    EVENT_SYSTEM_MOVESIZEEND            = 0x0000000b,
    EVENT_SYSTEM_CONTEXTHELPSTART       = 0x0000000c,
    EVENT_SYSTEM_CONTEXTHELPEND         = 0x0000000d,
    EVENT_SYSTEM_DRAGDROPSTART          = 0x0000000e,
    EVENT_SYSTEM_DRAGDROPEND            = 0x0000000f,
    EVENT_SYSTEM_DIALOGSTART            = 0x00000010,
    EVENT_SYSTEM_DIALOGEND              = 0x00000011,
    EVENT_SYSTEM_SCROLLINGSTART         = 0x00000012,
    EVENT_SYSTEM_SCROLLINGEND           = 0x00000013,
    EVENT_SYSTEM_SWITCHSTART            = 0x00000014,
    EVENT_SYSTEM_SWITCHEND              = 0x00000015,
    EVENT_SYSTEM_MINIMIZESTART          = 0x00000016,
    EVENT_SYSTEM_MINIMIZEEND            = 0x00000017,
    EVENT_SYSTEM_DESKTOPSWITCH          = 0x00000020,
    EVENT_SYSTEM_SWITCHER_APPGRABBED    = 0x00000024,
    EVENT_SYSTEM_SWITCHER_APPOVERTARGET = 0x00000025,
    EVENT_SYSTEM_SWITCHER_APPDROPPED    = 0x00000026,
    EVENT_SYSTEM_SWITCHER_CANCELLED     = 0x00000027,
    EVENT_SYSTEM_IME_KEY_NOTIFICATION   = 0x00000029,
}

enum : int
{
    EVENT_OEM_DEFINED_START = 0x00000101,
    EVENT_OEM_DEFINED_END   = 0x000001ff,
}

enum : int
{
    EVENT_UIA_EVENTID_END  = 0x00004eff,
    EVENT_UIA_PROPID_START = 0x00007500,
    EVENT_UIA_PROPID_END   = 0x000075ff,
}

enum : int
{
    EVENT_CONSOLE_UPDATE_REGION     = 0x00004002,
    EVENT_CONSOLE_UPDATE_SIMPLE     = 0x00004003,
    EVENT_CONSOLE_UPDATE_SCROLL     = 0x00004004,
    EVENT_CONSOLE_LAYOUT            = 0x00004005,
    EVENT_CONSOLE_START_APPLICATION = 0x00004006,
    EVENT_CONSOLE_END_APPLICATION   = 0x00004007,
}

enum : int
{
    CONSOLE_CARET_SELECTION = 0x00000001,
    CONSOLE_CARET_VISIBLE   = 0x00000002,
}

enum : int
{
    EVENT_OBJECT_CREATE               = 0x00008000,
    EVENT_OBJECT_DESTROY              = 0x00008001,
    EVENT_OBJECT_SHOW                 = 0x00008002,
    EVENT_OBJECT_HIDE                 = 0x00008003,
    EVENT_OBJECT_REORDER              = 0x00008004,
    EVENT_OBJECT_FOCUS                = 0x00008005,
    EVENT_OBJECT_SELECTION            = 0x00008006,
    EVENT_OBJECT_SELECTIONADD         = 0x00008007,
    EVENT_OBJECT_SELECTIONREMOVE      = 0x00008008,
    EVENT_OBJECT_SELECTIONWITHIN      = 0x00008009,
    EVENT_OBJECT_STATECHANGE          = 0x0000800a,
    EVENT_OBJECT_LOCATIONCHANGE       = 0x0000800b,
    EVENT_OBJECT_NAMECHANGE           = 0x0000800c,
    EVENT_OBJECT_DESCRIPTIONCHANGE    = 0x0000800d,
    EVENT_OBJECT_VALUECHANGE          = 0x0000800e,
    EVENT_OBJECT_PARENTCHANGE         = 0x0000800f,
    EVENT_OBJECT_HELPCHANGE           = 0x00008010,
    EVENT_OBJECT_DEFACTIONCHANGE      = 0x00008011,
    EVENT_OBJECT_ACCELERATORCHANGE    = 0x00008012,
    EVENT_OBJECT_INVOKED              = 0x00008013,
    EVENT_OBJECT_TEXTSELECTIONCHANGED = 0x00008014,
}

enum int EVENT_SYSTEM_ARRANGMENTPREVIEW = 0x00008016;

enum : int
{
    EVENT_OBJECT_UNCLOAKED                = 0x00008018,
    EVENT_OBJECT_LIVEREGIONCHANGED        = 0x00008019,
    EVENT_OBJECT_HOSTEDOBJECTSINVALIDATED = 0x00008020,
}

enum : int
{
    EVENT_OBJECT_DRAGCANCEL                       = 0x00008022,
    EVENT_OBJECT_DRAGCOMPLETE                     = 0x00008023,
    EVENT_OBJECT_DRAGENTER                        = 0x00008024,
    EVENT_OBJECT_DRAGLEAVE                        = 0x00008025,
    EVENT_OBJECT_DRAGDROPPED                      = 0x00008026,
    EVENT_OBJECT_IME_SHOW                         = 0x00008027,
    EVENT_OBJECT_IME_HIDE                         = 0x00008028,
    EVENT_OBJECT_IME_CHANGE                       = 0x00008029,
    EVENT_OBJECT_TEXTEDIT_CONVERSIONTARGETCHANGED = 0x00008030,
}

enum : int
{
    EVENT_AIA_START = 0x0000a000,
    EVENT_AIA_END   = 0x0000afff,
}

enum : int
{
    SOUND_SYSTEM_SHUTDOWN    = 0x00000002,
    SOUND_SYSTEM_BEEP        = 0x00000003,
    SOUND_SYSTEM_ERROR       = 0x00000004,
    SOUND_SYSTEM_QUESTION    = 0x00000005,
    SOUND_SYSTEM_WARNING     = 0x00000006,
    SOUND_SYSTEM_INFORMATION = 0x00000007,
    SOUND_SYSTEM_MAXIMIZE    = 0x00000008,
    SOUND_SYSTEM_MINIMIZE    = 0x00000009,
    SOUND_SYSTEM_RESTOREUP   = 0x0000000a,
    SOUND_SYSTEM_RESTOREDOWN = 0x0000000b,
    SOUND_SYSTEM_APPSTART    = 0x0000000c,
    SOUND_SYSTEM_FAULT       = 0x0000000d,
    SOUND_SYSTEM_APPEND      = 0x0000000e,
    SOUND_SYSTEM_MENUCOMMAND = 0x0000000f,
    SOUND_SYSTEM_MENUPOPUP   = 0x00000010,
}

enum : int
{
    ALERT_SYSTEM_INFORMATIONAL = 0x00000001,
    ALERT_SYSTEM_WARNING       = 0x00000002,
    ALERT_SYSTEM_ERROR         = 0x00000003,
    ALERT_SYSTEM_QUERY         = 0x00000004,
    ALERT_SYSTEM_CRITICAL      = 0x00000005,
}

enum int GUI_CARETBLINKING = 0x00000001;
enum int GUI_INMENUMODE = 0x00000004;
enum int GUI_POPUPMENUMODE = 0x00000010;
enum int USER_DEFAULT_SCREEN_DPI = 0x00000060;

enum : int
{
    STATE_SYSTEM_SELECTED        = 0x00000002,
    STATE_SYSTEM_FOCUSED         = 0x00000004,
    STATE_SYSTEM_PRESSED         = 0x00000008,
    STATE_SYSTEM_CHECKED         = 0x00000010,
    STATE_SYSTEM_MIXED           = 0x00000020,
    STATE_SYSTEM_INDETERMINATE   = 0x00000020,
    STATE_SYSTEM_READONLY        = 0x00000040,
    STATE_SYSTEM_HOTTRACKED      = 0x00000080,
    STATE_SYSTEM_DEFAULT         = 0x00000100,
    STATE_SYSTEM_EXPANDED        = 0x00000200,
    STATE_SYSTEM_COLLAPSED       = 0x00000400,
    STATE_SYSTEM_BUSY            = 0x00000800,
    STATE_SYSTEM_FLOATING        = 0x00001000,
    STATE_SYSTEM_MARQUEED        = 0x00002000,
    STATE_SYSTEM_ANIMATED        = 0x00004000,
    STATE_SYSTEM_INVISIBLE       = 0x00008000,
    STATE_SYSTEM_OFFSCREEN       = 0x00010000,
    STATE_SYSTEM_SIZEABLE        = 0x00020000,
    STATE_SYSTEM_MOVEABLE        = 0x00040000,
    STATE_SYSTEM_SELFVOICING     = 0x00080000,
    STATE_SYSTEM_FOCUSABLE       = 0x00100000,
    STATE_SYSTEM_SELECTABLE      = 0x00200000,
    STATE_SYSTEM_LINKED          = 0x00400000,
    STATE_SYSTEM_TRAVERSED       = 0x00800000,
    STATE_SYSTEM_MULTISELECTABLE = 0x01000000,
    STATE_SYSTEM_EXTSELECTABLE   = 0x02000000,
    STATE_SYSTEM_ALERT_LOW       = 0x04000000,
    STATE_SYSTEM_ALERT_MEDIUM    = 0x08000000,
    STATE_SYSTEM_ALERT_HIGH      = 0x10000000,
    STATE_SYSTEM_PROTECTED       = 0x20000000,
    STATE_SYSTEM_VALID           = 0x3fffffff,
}

enum int CCHILDREN_SCROLLBAR = 0x00000005;
enum int CURSOR_SUPPRESSED = 0x00000002;
enum int GA_PARENT = 0x00000001;
enum int GA_ROOTOWNER = 0x00000003;
enum int RIM_INPUTSINK = 0x00000001;

enum : int
{
    RIM_TYPEKEYBOARD = 0x00000001,
    RIM_TYPEHID      = 0x00000002,
    RIM_TYPEMAX      = 0x00000002,
}

enum int RI_MOUSE_LEFT_BUTTON_UP = 0x00000002;
enum int RI_MOUSE_RIGHT_BUTTON_UP = 0x00000008;
enum int RI_MOUSE_MIDDLE_BUTTON_UP = 0x00000020;

enum : int
{
    RI_MOUSE_BUTTON_1_UP   = 0x00000002,
    RI_MOUSE_BUTTON_2_DOWN = 0x00000004,
    RI_MOUSE_BUTTON_2_UP   = 0x00000008,
    RI_MOUSE_BUTTON_3_DOWN = 0x00000010,
    RI_MOUSE_BUTTON_3_UP   = 0x00000020,
    RI_MOUSE_BUTTON_4_DOWN = 0x00000040,
    RI_MOUSE_BUTTON_4_UP   = 0x00000080,
    RI_MOUSE_BUTTON_5_DOWN = 0x00000100,
    RI_MOUSE_BUTTON_5_UP   = 0x00000200,
    RI_MOUSE_WHEEL         = 0x00000400,
    RI_MOUSE_HWHEEL        = 0x00000800,
}

enum int MOUSE_MOVE_ABSOLUTE = 0x00000001;
enum int MOUSE_ATTRIBUTES_CHANGED = 0x00000004;
enum int KEYBOARD_OVERRUN_MAKE_CODE = 0x000000ff;

enum : int
{
    RI_KEY_BREAK           = 0x00000001,
    RI_KEY_E0              = 0x00000002,
    RI_KEY_E1              = 0x00000004,
    RI_KEY_TERMSRV_SET_LED = 0x00000008,
    RI_KEY_TERMSRV_SHADOW  = 0x00000010,
}

enum int RID_HEADER = 0x10000005;

enum : int
{
    RIDI_DEVICENAME = 0x20000007,
    RIDI_DEVICEINFO = 0x2000000b,
}

enum : int
{
    RIDEV_EXCLUDE   = 0x00000010,
    RIDEV_PAGEONLY  = 0x00000020,
    RIDEV_NOLEGACY  = 0x00000030,
    RIDEV_INPUTSINK = 0x00000100,
}

enum int RIDEV_NOHOTKEYS = 0x00000200;
enum int RIDEV_EXINPUTSINK = 0x00001000;
enum int RIDEV_EXMODEMASK = 0x000000f0;
enum int GIDC_REMOVAL = 0x00000002;
enum int PDC_ARRIVAL = 0x00000001;

enum : int
{
    PDC_ORIENTATION_0   = 0x00000004,
    PDC_ORIENTATION_90  = 0x00000008,
    PDC_ORIENTATION_180 = 0x00000010,
    PDC_ORIENTATION_270 = 0x00000020,
}

enum int PDC_MODE_CENTERED = 0x00000080;
enum int PDC_RESOLUTION = 0x00000200;
enum int PDC_MODE_ASPECTRATIOPRESERVED = 0x00000800;

enum : int
{
    MSGFLT_REMOVE                       = 0x00000002,
    MSGFLTINFO_NONE                     = 0x00000000,
    MSGFLTINFO_ALREADYALLOWED_FORWND    = 0x00000001,
    MSGFLTINFO_ALREADYDISALLOWED_FORWND = 0x00000002,
}

enum : int
{
    MSGFLT_RESET    = 0x00000000,
    MSGFLT_ALLOW    = 0x00000001,
    MSGFLT_DISALLOW = 0x00000002,
}

enum int GF_INERTIA = 0x00000002;

enum : int
{
    GID_BEGIN  = 0x00000001,
    GID_END    = 0x00000002,
    GID_ZOOM   = 0x00000003,
    GID_PAN    = 0x00000004,
    GID_ROTATE = 0x00000005,
}

enum int GID_PRESSANDTAP = 0x00000007;
enum int GC_ALLGESTURES = 0x00000001;

enum : int
{
    GC_PAN                                 = 0x00000001,
    GC_PAN_WITH_SINGLE_FINGER_VERTICALLY   = 0x00000002,
    GC_PAN_WITH_SINGLE_FINGER_HORIZONTALLY = 0x00000004,
}

enum int GC_PAN_WITH_INERTIA = 0x00000010;
enum int GC_TWOFINGERTAP = 0x00000001;
enum int GC_ROLLOVER = 0x00000001;
enum int NID_INTEGRATED_TOUCH = 0x00000001;
enum int NID_INTEGRATED_PEN = 0x00000004;
enum int NID_MULTI_INPUT = 0x00000040;
enum int MAX_STR_BLOCKREASON = 0x00000100;
enum uint INFINITE = 0xffffffff;

enum : int
{
    FACILITY_RPC                = 0x00000001,
    FACILITY_DISPATCH           = 0x00000002,
    FACILITY_STORAGE            = 0x00000003,
    FACILITY_ITF                = 0x00000004,
    FACILITY_WIN32              = 0x00000007,
    FACILITY_WINDOWS            = 0x00000008,
    FACILITY_SSPI               = 0x00000009,
    FACILITY_SECURITY           = 0x00000009,
    FACILITY_CONTROL            = 0x0000000a,
    FACILITY_CERT               = 0x0000000b,
    FACILITY_INTERNET           = 0x0000000c,
    FACILITY_MEDIASERVER        = 0x0000000d,
    FACILITY_MSMQ               = 0x0000000e,
    FACILITY_SETUPAPI           = 0x0000000f,
    FACILITY_SCARD              = 0x00000010,
    FACILITY_COMPLUS            = 0x00000011,
    FACILITY_AAF                = 0x00000012,
    FACILITY_URT                = 0x00000013,
    FACILITY_ACS                = 0x00000014,
    FACILITY_DPLAY              = 0x00000015,
    FACILITY_UMI                = 0x00000016,
    FACILITY_SXS                = 0x00000017,
    FACILITY_WINDOWS_CE         = 0x00000018,
    FACILITY_HTTP               = 0x00000019,
    FACILITY_USERMODE_COMMONLOG = 0x0000001a,
}

enum int FACILITY_USERMODE_FILTER_MANAGER = 0x0000001f;

enum : int
{
    FACILITY_CONFIGURATION    = 0x00000021,
    FACILITY_WIA              = 0x00000021,
    FACILITY_STATE_MANAGEMENT = 0x00000022,
}

enum : int
{
    FACILITY_WINDOWSUPDATE    = 0x00000024,
    FACILITY_DIRECTORYSERVICE = 0x00000025,
}

enum : int
{
    FACILITY_SHELL               = 0x00000027,
    FACILITY_NAP                 = 0x00000027,
    FACILITY_TPM_SERVICES        = 0x00000028,
    FACILITY_TPM_SOFTWARE        = 0x00000029,
    FACILITY_UI                  = 0x0000002a,
    FACILITY_XAML                = 0x0000002b,
    FACILITY_ACTION_QUEUE        = 0x0000002c,
    FACILITY_PLA                 = 0x00000030,
    FACILITY_WINDOWS_SETUP       = 0x00000030,
    FACILITY_FVE                 = 0x00000031,
    FACILITY_FWP                 = 0x00000032,
    FACILITY_WINRM               = 0x00000033,
    FACILITY_NDIS                = 0x00000034,
    FACILITY_USERMODE_HYPERVISOR = 0x00000035,
}

enum : int
{
    FACILITY_USERMODE_VIRTUALIZATION = 0x00000037,
    FACILITY_USERMODE_VOLMGR         = 0x00000038,
}

enum : int
{
    FACILITY_USERMODE_VHD     = 0x0000003a,
    FACILITY_USERMODE_HNS     = 0x0000003b,
    FACILITY_SDIAG            = 0x0000003c,
    FACILITY_WEBSERVICES      = 0x0000003d,
    FACILITY_WINPE            = 0x0000003d,
    FACILITY_WPN              = 0x0000003e,
    FACILITY_WINDOWS_STORE    = 0x0000003f,
    FACILITY_INPUT            = 0x00000040,
    FACILITY_QUIC             = 0x00000041,
    FACILITY_EAP              = 0x00000042,
    FACILITY_WINDOWS_DEFENDER = 0x00000050,
}

enum : int
{
    FACILITY_XPS             = 0x00000052,
    FACILITY_MBN             = 0x00000054,
    FACILITY_POWERSHELL      = 0x00000054,
    FACILITY_RAS             = 0x00000053,
    FACILITY_P2P_INT         = 0x00000062,
    FACILITY_P2P             = 0x00000063,
    FACILITY_DAF             = 0x00000064,
    FACILITY_BLUETOOTH_ATT   = 0x00000065,
    FACILITY_AUDIO           = 0x00000066,
    FACILITY_STATEREPOSITORY = 0x00000067,
}

enum : int
{
    FACILITY_SCRIPT           = 0x00000070,
    FACILITY_PARSE            = 0x00000071,
    FACILITY_BLB              = 0x00000078,
    FACILITY_BLB_CLI          = 0x00000079,
    FACILITY_WSBAPP           = 0x0000007a,
    FACILITY_BLBUI            = 0x00000080,
    FACILITY_USN              = 0x00000081,
    FACILITY_USERMODE_VOLSNAP = 0x00000082,
}

enum : int
{
    FACILITY_WSB_ONLINE          = 0x00000085,
    FACILITY_ONLINE_ID           = 0x00000086,
    FACILITY_DEVICE_UPDATE_AGENT = 0x00000087,
}

enum : int
{
    FACILITY_DLS                   = 0x00000099,
    FACILITY_DELIVERY_OPTIMIZATION = 0x000000d0,
}

enum : int
{
    FACILITY_USER_MODE_SECURITY_CORE = 0x000000e8,
    FACILITY_USERMODE_LICENSING      = 0x000000ea,
}

enum : int
{
    FACILITY_DEBUGGERS                                = 0x000000b0,
    FACILITY_SPP                                      = 0x00000100,
    FACILITY_RESTORE                                  = 0x00000100,
    FACILITY_DMSERVER                                 = 0x00000100,
    FACILITY_DEPLOYMENT_SERVICES_SERVER               = 0x00000101,
    FACILITY_DEPLOYMENT_SERVICES_IMAGING              = 0x00000102,
    FACILITY_DEPLOYMENT_SERVICES_MANAGEMENT           = 0x00000103,
    FACILITY_DEPLOYMENT_SERVICES_UTIL                 = 0x00000104,
    FACILITY_DEPLOYMENT_SERVICES_BINLSVC              = 0x00000105,
    FACILITY_DEPLOYMENT_SERVICES_PXE                  = 0x00000107,
    FACILITY_DEPLOYMENT_SERVICES_TFTP                 = 0x00000108,
    FACILITY_DEPLOYMENT_SERVICES_TRANSPORT_MANAGEMENT = 0x00000110,
    FACILITY_DEPLOYMENT_SERVICES_DRIVER_PROVISIONING  = 0x00000116,
    FACILITY_DEPLOYMENT_SERVICES_MULTICAST_SERVER     = 0x00000121,
    FACILITY_DEPLOYMENT_SERVICES_MULTICAST_CLIENT     = 0x00000122,
    FACILITY_DEPLOYMENT_SERVICES_CONTENT_PROVIDER     = 0x00000125,
}

enum int FACILITY_AUDIOSTREAMING = 0x00000446;

enum : int
{
    FACILITY_ACCELERATOR      = 0x00000600,
    FACILITY_WMAAECMA         = 0x000007cc,
    FACILITY_DIRECTMUSIC      = 0x00000878,
    FACILITY_DIRECT3D10       = 0x00000879,
    FACILITY_DXGI             = 0x0000087a,
    FACILITY_DXGI_DDI         = 0x0000087b,
    FACILITY_DIRECT3D11       = 0x0000087c,
    FACILITY_DIRECT3D11_DEBUG = 0x0000087d,
    FACILITY_DIRECT3D12       = 0x0000087e,
    FACILITY_DIRECT3D12_DEBUG = 0x0000087f,
}

enum : int
{
    FACILITY_LEAP                = 0x00000888,
    FACILITY_AUDCLNT             = 0x00000889,
    FACILITY_WINCODEC_DWRITE_DWM = 0x00000898,
    FACILITY_WINML               = 0x00000890,
    FACILITY_DIRECT2D            = 0x00000899,
    FACILITY_DEFRAG              = 0x00000900,
    FACILITY_USERMODE_SDBUS      = 0x00000901,
}

enum : int
{
    FACILITY_PIDGENX    = 0x00000a01,
    FACILITY_EAS        = 0x00000055,
    FACILITY_WEB        = 0x00000375,
    FACILITY_WEB_SOCKET = 0x00000376,
    FACILITY_MOBILE     = 0x00000701,
    FACILITY_SQLITE     = 0x000007af,
    FACILITY_UTC        = 0x000007c5,
    FACILITY_WEP        = 0x00000801,
    FACILITY_SYNCENGINE = 0x00000802,
    FACILITY_XBOX       = 0x00000923,
    FACILITY_GAME       = 0x00000924,
    FACILITY_PIX        = 0x00000abc,
}

enum int NO_ERROR = 0x00000000;
enum int ERROR_INVALID_FUNCTION = 0x00000001;
enum int ERROR_PATH_NOT_FOUND = 0x00000003;
enum int ERROR_ACCESS_DENIED = 0x00000005;
enum int ERROR_ARENA_TRASHED = 0x00000007;
enum int ERROR_INVALID_BLOCK = 0x00000009;
enum int ERROR_BAD_FORMAT = 0x0000000b;
enum int ERROR_INVALID_DATA = 0x0000000d;
enum int ERROR_INVALID_DRIVE = 0x0000000f;
enum int ERROR_NOT_SAME_DEVICE = 0x00000011;
enum int ERROR_WRITE_PROTECT = 0x00000013;
enum int ERROR_NOT_READY = 0x00000015;

enum : int
{
    ERROR_CRC        = 0x00000017,
    ERROR_BAD_LENGTH = 0x00000018,
}

enum int ERROR_NOT_DOS_DISK = 0x0000001a;
enum int ERROR_OUT_OF_PAPER = 0x0000001c;
enum int ERROR_READ_FAULT = 0x0000001e;
enum int ERROR_SHARING_VIOLATION = 0x00000020;
enum int ERROR_WRONG_DISK = 0x00000022;

enum : int
{
    ERROR_HANDLE_EOF       = 0x00000026,
    ERROR_HANDLE_DISK_FULL = 0x00000027,
}

enum int ERROR_REM_NOT_LIST = 0x00000033;
enum int ERROR_BAD_NETPATH = 0x00000035;
enum int ERROR_DEV_NOT_EXIST = 0x00000037;
enum int ERROR_ADAP_HDW_ERR = 0x00000039;
enum int ERROR_UNEXP_NET_ERR = 0x0000003b;
enum int ERROR_PRINTQ_FULL = 0x0000003d;
enum int ERROR_PRINT_CANCELLED = 0x0000003f;
enum int ERROR_NETWORK_ACCESS_DENIED = 0x00000041;
enum int ERROR_BAD_NET_NAME = 0x00000043;
enum int ERROR_TOO_MANY_SESS = 0x00000045;

enum : int
{
    ERROR_REQ_NOT_ACCEP = 0x00000047,
    ERROR_REDIR_PAUSED  = 0x00000048,
}

enum int ERROR_CANNOT_MAKE = 0x00000052;
enum int ERROR_OUT_OF_STRUCTURES = 0x00000054;

enum : int
{
    ERROR_INVALID_PASSWORD  = 0x00000056,
    ERROR_INVALID_PARAMETER = 0x00000057,
}

enum int ERROR_NO_PROC_SLOTS = 0x00000059;
enum int ERROR_EXCL_SEM_ALREADY_OWNED = 0x00000065;
enum int ERROR_TOO_MANY_SEM_REQUESTS = 0x00000067;

enum : int
{
    ERROR_SEM_OWNER_DIED = 0x00000069,
    ERROR_SEM_USER_LIMIT = 0x0000006a,
}

enum int ERROR_DRIVE_LOCKED = 0x0000006c;
enum int ERROR_OPEN_FAILED = 0x0000006e;
enum int ERROR_DISK_FULL = 0x00000070;

enum : int
{
    ERROR_INVALID_TARGET_HANDLE = 0x00000072,
    ERROR_INVALID_CATEGORY      = 0x00000075,
    ERROR_INVALID_VERIFY_SWITCH = 0x00000076,
}

enum int ERROR_CALL_NOT_IMPLEMENTED = 0x00000078;
enum int ERROR_INSUFFICIENT_BUFFER = 0x0000007a;
enum int ERROR_INVALID_LEVEL = 0x0000007c;
enum int ERROR_MOD_NOT_FOUND = 0x0000007e;
enum int ERROR_WAIT_NO_CHILDREN = 0x00000080;
enum int ERROR_DIRECT_ACCESS_HANDLE = 0x00000082;
enum int ERROR_SEEK_ON_DEVICE = 0x00000084;

enum : int
{
    ERROR_IS_JOINED  = 0x00000086,
    ERROR_IS_SUBSTED = 0x00000087,
}

enum int ERROR_NOT_SUBSTED = 0x00000089;
enum int ERROR_SUBST_TO_SUBST = 0x0000008b;
enum int ERROR_SUBST_TO_JOIN = 0x0000008d;
enum int ERROR_SAME_DRIVE = 0x0000008f;
enum int ERROR_DIR_NOT_EMPTY = 0x00000091;
enum int ERROR_IS_JOIN_PATH = 0x00000093;
enum int ERROR_IS_SUBST_TARGET = 0x00000095;
enum int ERROR_INVALID_EVENT_COUNT = 0x00000097;
enum int ERROR_INVALID_LIST_FORMAT = 0x00000099;
enum int ERROR_TOO_MANY_TCBS = 0x0000009b;
enum int ERROR_DISCARDED = 0x0000009d;

enum : int
{
    ERROR_BAD_THREADID_ADDR = 0x0000009f,
    ERROR_BAD_ARGUMENTS     = 0x000000a0,
    ERROR_BAD_PATHNAME      = 0x000000a1,
}

enum int ERROR_MAX_THRDS_REACHED = 0x000000a4;

enum : int
{
    ERROR_BUSY                       = 0x000000aa,
    ERROR_DEVICE_SUPPORT_IN_PROGRESS = 0x000000ab,
}

enum int ERROR_ATOMIC_LOCKS_NOT_SUPPORTED = 0x000000ae;
enum int ERROR_INVALID_ORDINAL = 0x000000b6;
enum int ERROR_INVALID_FLAG_NUMBER = 0x000000ba;

enum : int
{
    ERROR_INVALID_STARTING_CODESEG = 0x000000bc,
    ERROR_INVALID_STACKSEG         = 0x000000bd,
    ERROR_INVALID_MODULETYPE       = 0x000000be,
    ERROR_INVALID_EXE_SIGNATURE    = 0x000000bf,
}

enum int ERROR_BAD_EXE_FORMAT = 0x000000c1;
enum int ERROR_INVALID_MINALLOCSIZE = 0x000000c3;
enum int ERROR_IOPL_NOT_ENABLED = 0x000000c5;
enum int ERROR_AUTODATASEG_EXCEEDS_64k = 0x000000c7;
enum int ERROR_RELOC_CHAIN_XEEDS_SEGLIM = 0x000000c9;
enum int ERROR_ENVVAR_NOT_FOUND = 0x000000cb;
enum int ERROR_FILENAME_EXCED_RANGE = 0x000000ce;
enum int ERROR_META_EXPANSION_TOO_LONG = 0x000000d0;
enum int ERROR_THREAD_1_INACTIVE = 0x000000d2;
enum int ERROR_TOO_MANY_MODULES = 0x000000d6;
enum int ERROR_EXE_MACHINE_TYPE_MISMATCH = 0x000000d8;
enum int ERROR_EXE_CANNOT_MODIFY_STRONG_SIGNED_BINARY = 0x000000da;
enum int ERROR_CHECKOUT_REQUIRED = 0x000000dd;
enum int ERROR_FILE_TOO_LARGE = 0x000000df;

enum : int
{
    ERROR_VIRUS_INFECTED = 0x000000e1,
    ERROR_VIRUS_DELETED  = 0x000000e2,
}

enum : int
{
    ERROR_BAD_PIPE  = 0x000000e6,
    ERROR_PIPE_BUSY = 0x000000e7,
}

enum int ERROR_PIPE_NOT_CONNECTED = 0x000000e9;
enum int ERROR_NO_WORK_DONE = 0x000000eb;
enum int ERROR_INVALID_EA_NAME = 0x000000fe;
enum int WAIT_TIMEOUT = 0x00000102;
enum int ERROR_CANNOT_COPY = 0x0000010a;

enum : int
{
    ERROR_EAS_DIDNT_FIT   = 0x00000113,
    ERROR_EA_FILE_CORRUPT = 0x00000114,
    ERROR_EA_TABLE_FULL   = 0x00000115,
}

enum int ERROR_EAS_NOT_SUPPORTED = 0x0000011a;
enum int ERROR_TOO_MANY_POSTS = 0x0000012a;
enum int ERROR_OPLOCK_NOT_GRANTED = 0x0000012c;
enum int ERROR_DISK_TOO_FRAGMENTED = 0x0000012e;
enum int ERROR_INCOMPATIBLE_WITH_GLOBAL_SHORT_NAME_REGISTRY_SETTING = 0x00000130;
enum int ERROR_SECURITY_STREAM_IS_INCONSISTENT = 0x00000132;
enum int ERROR_IMAGE_SUBSYSTEM_NOT_PRESENT = 0x00000134;
enum int ERROR_INVALID_EXCEPTION_HANDLER = 0x00000136;
enum int ERROR_NO_RANGES_PROCESSED = 0x00000138;
enum int ERROR_DISK_RESOURCES_EXHAUSTED = 0x0000013a;
enum int ERROR_DEVICE_FEATURE_NOT_SUPPORTED = 0x0000013c;
enum int ERROR_SCOPE_NOT_FOUND = 0x0000013e;
enum int ERROR_INVALID_CAP = 0x00000140;
enum int ERROR_DEVICE_NO_RESOURCES = 0x00000142;
enum int ERROR_INTERMIXED_KERNEL_EA_OPERATION = 0x00000144;
enum int ERROR_OFFSET_ALIGNMENT_VIOLATION = 0x00000147;
enum int ERROR_OPERATION_IN_PROGRESS = 0x00000149;
enum int ERROR_TOO_MANY_DESCRIPTORS = 0x0000014b;
enum int ERROR_NOT_REDUNDANT_STORAGE = 0x0000014d;
enum int ERROR_COMPRESSED_FILE_NOT_SUPPORTED = 0x0000014f;
enum int ERROR_NOT_READ_FROM_COPY = 0x00000151;
enum int ERROR_FT_DI_SCAN_REQUIRED = 0x00000153;
enum int ERROR_INVALID_PEP_INFO_VERSION = 0x00000155;
enum int ERROR_EXTERNAL_BACKING_PROVIDER_UNKNOWN = 0x00000157;
enum int ERROR_STORAGE_TOPOLOGY_ID_MISMATCH = 0x00000159;
enum int ERROR_BLOCK_TOO_MANY_REFERENCES = 0x0000015b;
enum int ERROR_ENCLAVE_FAILURE = 0x0000015d;

enum : int
{
    ERROR_FAIL_SHUTDOWN = 0x0000015f,
    ERROR_FAIL_RESTART  = 0x00000160,
}

enum int ERROR_NETWORK_ACCESS_DENIED_EDP = 0x00000162;
enum int ERROR_EDP_POLICY_DENIES_OPERATION = 0x00000164;
enum int ERROR_CLOUD_FILE_SYNC_ROOT_METADATA_CORRUPT = 0x00000166;
enum int ERROR_NOT_SUPPORTED_ON_DAX = 0x00000168;

enum : int
{
    ERROR_CLOUD_FILE_PROVIDER_NOT_RUNNING            = 0x0000016a,
    ERROR_CLOUD_FILE_METADATA_CORRUPT                = 0x0000016b,
    ERROR_CLOUD_FILE_METADATA_TOO_LARGE              = 0x0000016c,
    ERROR_CLOUD_FILE_PROPERTY_BLOB_TOO_LARGE         = 0x0000016d,
    ERROR_CLOUD_FILE_PROPERTY_BLOB_CHECKSUM_MISMATCH = 0x0000016e,
}

enum int ERROR_STORAGE_LOST_DATA_PERSISTENCE = 0x00000170;

enum : int
{
    ERROR_FILE_SYSTEM_VIRTUALIZATION_METADATA_CORRUPT = 0x00000172,
    ERROR_FILE_SYSTEM_VIRTUALIZATION_BUSY             = 0x00000173,
    ERROR_FILE_SYSTEM_VIRTUALIZATION_PROVIDER_UNKNOWN = 0x00000174,
}

enum : int
{
    ERROR_CLOUD_FILE_TOO_MANY_PROPERTY_BLOBS        = 0x00000176,
    ERROR_CLOUD_FILE_PROPERTY_VERSION_NOT_SUPPORTED = 0x00000177,
}

enum : int
{
    ERROR_CLOUD_FILE_NOT_IN_SYNC             = 0x00000179,
    ERROR_CLOUD_FILE_ALREADY_CONNECTED       = 0x0000017a,
    ERROR_CLOUD_FILE_NOT_SUPPORTED           = 0x0000017b,
    ERROR_CLOUD_FILE_INVALID_REQUEST         = 0x0000017c,
    ERROR_CLOUD_FILE_READ_ONLY_VOLUME        = 0x0000017d,
    ERROR_CLOUD_FILE_CONNECTED_PROVIDER_ONLY = 0x0000017e,
    ERROR_CLOUD_FILE_VALIDATION_FAILED       = 0x0000017f,
}

enum int ERROR_FILE_SYSTEM_VIRTUALIZATION_INVALID_OPERATION = 0x00000181;

enum : int
{
    ERROR_CLOUD_FILE_INSUFFICIENT_RESOURCES = 0x00000183,
    ERROR_CLOUD_FILE_NETWORK_UNAVAILABLE    = 0x00000184,
    ERROR_CLOUD_FILE_UNSUCCESSFUL           = 0x00000185,
    ERROR_CLOUD_FILE_NOT_UNDER_SYNC_ROOT    = 0x00000186,
    ERROR_CLOUD_FILE_IN_USE                 = 0x00000187,
    ERROR_CLOUD_FILE_PINNED                 = 0x00000188,
    ERROR_CLOUD_FILE_REQUEST_ABORTED        = 0x00000189,
    ERROR_CLOUD_FILE_PROPERTY_CORRUPT       = 0x0000018a,
    ERROR_CLOUD_FILE_ACCESS_DENIED          = 0x0000018b,
    ERROR_CLOUD_FILE_INCOMPATIBLE_HARDLINKS = 0x0000018c,
    ERROR_CLOUD_FILE_PROPERTY_LOCK_CONFLICT = 0x0000018d,
    ERROR_CLOUD_FILE_REQUEST_CANCELED       = 0x0000018e,
}

enum : int
{
    ERROR_THREAD_MODE_ALREADY_BACKGROUND = 0x00000190,
    ERROR_THREAD_MODE_NOT_BACKGROUND     = 0x00000191,
}

enum int ERROR_PROCESS_MODE_NOT_BACKGROUND = 0x00000193;
enum int ERROR_NOT_A_CLOUD_SYNC_ROOT = 0x00000195;
enum int ERROR_VOLUME_NOT_CLUSTER_ALIGNED = 0x00000197;
enum int ERROR_APPX_FILE_NOT_ENCRYPTED = 0x00000199;

enum : int
{
    ERROR_RWRAW_ENCRYPTED_INVALID_EDATAINFO_FILEOFFSET = 0x0000019b,
    ERROR_RWRAW_ENCRYPTED_INVALID_EDATAINFO_FILERANGE  = 0x0000019c,
    ERROR_RWRAW_ENCRYPTED_INVALID_EDATAINFO_PARAMETER  = 0x0000019d,
}

enum int ERROR_FT_READ_FAILURE = 0x0000019f;

enum : int
{
    ERROR_STORAGE_RESERVE_DOES_NOT_EXIST = 0x000001a1,
    ERROR_STORAGE_RESERVE_ALREADY_EXISTS = 0x000001a2,
    ERROR_STORAGE_RESERVE_NOT_EMPTY      = 0x000001a3,
}

enum int ERROR_NOT_DAX_MAPPABLE = 0x000001a5;
enum int ERROR_DPL_NOT_SUPPORTED_FOR_USER = 0x000001a7;
enum int ERROR_FILE_NOT_SUPPORTED = 0x000001a9;
enum int ERROR_NO_TASK_QUEUE = 0x000001ab;
enum int ERROR_NOT_SUPPORTED_WITH_BTT = 0x000001ad;
enum int ERROR_ENCRYPTING_METADATA_DISALLOWED = 0x000001af;
enum int ERROR_NO_SUCH_DEVICE = 0x000001b1;

enum : int
{
    ERROR_FILE_SNAP_IN_PROGRESS                = 0x000001b3,
    ERROR_FILE_SNAP_USER_SECTION_NOT_SUPPORTED = 0x000001b4,
}

enum : int
{
    ERROR_FILE_SNAP_IO_NOT_COORDINATED = 0x000001b6,
    ERROR_FILE_SNAP_UNEXPECTED_ERROR   = 0x000001b7,
    ERROR_FILE_SNAP_INVALID_PARAMETER  = 0x000001b8,
}

enum int ERROR_CASE_SENSITIVE_PATH = 0x000001ba;

enum : int
{
    ERROR_CAPAUTHZ_NOT_DEVUNLOCKED          = 0x000001c2,
    ERROR_CAPAUTHZ_CHANGE_TYPE              = 0x000001c3,
    ERROR_CAPAUTHZ_NOT_PROVISIONED          = 0x000001c4,
    ERROR_CAPAUTHZ_NOT_AUTHORIZED           = 0x000001c5,
    ERROR_CAPAUTHZ_NO_POLICY                = 0x000001c6,
    ERROR_CAPAUTHZ_DB_CORRUPTED             = 0x000001c7,
    ERROR_CAPAUTHZ_SCCD_INVALID_CATALOG     = 0x000001c8,
    ERROR_CAPAUTHZ_SCCD_NO_AUTH_ENTITY      = 0x000001c9,
    ERROR_CAPAUTHZ_SCCD_PARSE_ERROR         = 0x000001ca,
    ERROR_CAPAUTHZ_SCCD_DEV_MODE_REQUIRED   = 0x000001cb,
    ERROR_CAPAUTHZ_SCCD_NO_CAPABILITY_MATCH = 0x000001cc,
}

enum : int
{
    ERROR_PNP_QUERY_REMOVE_RELATED_DEVICE_TIMEOUT   = 0x000001e1,
    ERROR_PNP_QUERY_REMOVE_UNRELATED_DEVICE_TIMEOUT = 0x000001e2,
}

enum int ERROR_INVALID_ADDRESS = 0x000001e7;
enum int ERROR_PARTITION_TERMINATING = 0x000004a0;
enum int ERROR_ARITHMETIC_OVERFLOW = 0x00000216;
enum int ERROR_PIPE_LISTENING = 0x00000218;
enum int ERROR_ABIOS_ERROR = 0x0000021a;
enum int ERROR_WX86_ERROR = 0x0000021c;

enum : int
{
    ERROR_UNWIND    = 0x0000021e,
    ERROR_BAD_STACK = 0x0000021f,
}

enum int ERROR_INVALID_PORT_ATTRIBUTES = 0x00000221;
enum int ERROR_INVALID_QUOTA_LOWER = 0x00000223;
enum int ERROR_INSTRUCTION_MISALIGNMENT = 0x00000225;
enum int ERROR_PROFILING_NOT_STOPPED = 0x00000227;
enum int ERROR_PROFILING_AT_LIMIT = 0x00000229;
enum int ERROR_CANT_TERMINATE_SELF = 0x0000022b;

enum : int
{
    ERROR_UNEXPECTED_MM_MAP_ERROR  = 0x0000022d,
    ERROR_UNEXPECTED_MM_EXTEND_ERR = 0x0000022e,
}

enum int ERROR_NO_GUID_TRANSLATION = 0x00000230;

enum : int
{
    ERROR_INVALID_LDT_OFFSET     = 0x00000233,
    ERROR_INVALID_LDT_DESCRIPTOR = 0x00000234,
}

enum int ERROR_THREAD_NOT_IN_PROCESS = 0x00000236;
enum int ERROR_LOGON_SERVER_CONFLICT = 0x00000238;
enum int ERROR_NET_OPEN_FAILED = 0x0000023a;
enum int ERROR_CONTROL_C_EXIT = 0x0000023c;
enum int ERROR_UNHANDLED_EXCEPTION = 0x0000023e;
enum int ERROR_PAGEFILE_CREATE_FAILED = 0x00000240;
enum int ERROR_NO_PAGEFILE = 0x00000242;
enum int ERROR_NO_EVENT_PAIR = 0x00000244;
enum int ERROR_ILLEGAL_CHARACTER = 0x00000246;
enum int ERROR_FLOPPY_VOLUME = 0x00000248;
enum int ERROR_BACKUP_CONTROLLER = 0x0000024a;
enum int ERROR_FS_DRIVER_REQUIRED = 0x0000024c;
enum int ERROR_DEBUG_ATTACH_FAILED = 0x0000024e;
enum int ERROR_DATA_NOT_ACCEPTED = 0x00000250;
enum int ERROR_DRIVER_CANCEL_TIMEOUT = 0x00000252;
enum int ERROR_LOST_WRITEBEHIND_DATA = 0x00000254;
enum int ERROR_NOT_TINY_STREAM = 0x00000256;
enum int ERROR_CONVERT_TO_LARGE = 0x00000258;
enum int ERROR_ALLOCATE_BUCKET = 0x0000025a;
enum int ERROR_INVALID_VARIANT = 0x0000025c;
enum int ERROR_AUDIT_FAILED = 0x0000025e;
enum int ERROR_INSUFFICIENT_LOGON_INFO = 0x00000260;
enum int ERROR_BAD_SERVICE_ENTRYPOINT = 0x00000262;
enum int ERROR_IP_ADDRESS_CONFLICT2 = 0x00000264;
enum int ERROR_NO_CALLBACK_ACTIVE = 0x00000266;

enum : int
{
    ERROR_PWD_TOO_RECENT       = 0x00000268,
    ERROR_PWD_HISTORY_CONFLICT = 0x00000269,
}

enum : int
{
    ERROR_INVALID_HW_PROFILE           = 0x0000026b,
    ERROR_INVALID_PLUGPLAY_DEVICE_PATH = 0x0000026c,
}

enum int ERROR_EVALUATION_EXPIRATION = 0x0000026e;
enum int ERROR_DLL_INIT_FAILED_LOGOFF = 0x00000270;
enum int ERROR_NO_MORE_MATCHES = 0x00000272;
enum int ERROR_SERVER_SID_MISMATCH = 0x00000274;

enum : int
{
    ERROR_FLOAT_MULTIPLE_FAULTS = 0x00000276,
    ERROR_FLOAT_MULTIPLE_TRAPS  = 0x00000277,
}

enum int ERROR_DRIVER_FAILED_SLEEP = 0x00000279;
enum int ERROR_COMMITMENT_MINIMUM = 0x0000027b;
enum int ERROR_SYSTEM_IMAGE_BAD_SIGNATURE = 0x0000027d;
enum int ERROR_INSUFFICIENT_POWER = 0x0000027f;
enum int ERROR_SYSTEM_SHUTDOWN = 0x00000281;
enum int ERROR_DS_VERSION_CHECK_FAILURE = 0x00000283;
enum int ERROR_NOT_SAFE_MODE_DRIVER = 0x00000286;
enum int ERROR_DEVICE_ENUMERATION_ERROR = 0x00000288;
enum int ERROR_INVALID_DEVICE_OBJECT_PARAMETER = 0x0000028a;
enum int ERROR_DRIVER_DATABASE_ERROR = 0x0000028c;
enum int ERROR_DRIVER_FAILED_PRIOR_UNLOAD = 0x0000028e;
enum int ERROR_HIBERNATION_FAILURE = 0x00000290;
enum int ERROR_FILE_SYSTEM_LIMITATION = 0x00000299;
enum int ERROR_ACPI_ERROR = 0x0000029d;

enum : int
{
    ERROR_PNP_BAD_MPS_TABLE      = 0x0000029f,
    ERROR_PNP_TRANSLATION_FAILED = 0x000002a0,
}

enum int ERROR_PNP_INVALID_ID = 0x000002a2;
enum int ERROR_HANDLES_CLOSED = 0x000002a4;
enum int ERROR_RXACT_COMMIT_NECESSARY = 0x000002a6;
enum int ERROR_GUID_SUBSTITUTION_MADE = 0x000002a8;

enum : int
{
    ERROR_LONGJUMP              = 0x000002aa,
    ERROR_PLUGPLAY_QUERY_VETOED = 0x000002ab,
}

enum int ERROR_REGISTRY_HIVE_RECOVERED = 0x000002ad;
enum int ERROR_DLL_MIGHT_BE_INCOMPATIBLE = 0x000002af;

enum : int
{
    ERROR_DBG_REPLY_LATER              = 0x000002b1,
    ERROR_DBG_UNABLE_TO_PROVIDE_HANDLE = 0x000002b2,
}

enum int ERROR_DBG_TERMINATE_PROCESS = 0x000002b4;
enum int ERROR_DBG_PRINTEXCEPTION_C = 0x000002b6;

enum : int
{
    ERROR_DBG_CONTROL_BREAK     = 0x000002b8,
    ERROR_DBG_COMMAND_EXCEPTION = 0x000002b9,
}

enum int ERROR_THREAD_WAS_SUSPENDED = 0x000002bb;
enum int ERROR_RXACT_STATE_CREATED = 0x000002bd;
enum int ERROR_BAD_CURRENT_DIRECTORY = 0x000002bf;
enum int ERROR_FT_WRITE_RECOVERY = 0x000002c1;

enum : int
{
    ERROR_RECEIVE_PARTIAL           = 0x000002c3,
    ERROR_RECEIVE_EXPEDITED         = 0x000002c4,
    ERROR_RECEIVE_PARTIAL_EXPEDITED = 0x000002c5,
}

enum int ERROR_EVENT_PENDING = 0x000002c7;
enum int ERROR_FATAL_APP_EXIT = 0x000002c9;
enum int ERROR_WAS_UNLOCKED = 0x000002cb;
enum int ERROR_WAS_LOCKED = 0x000002cd;
enum int ERROR_ALREADY_WIN32 = 0x000002cf;
enum int ERROR_NO_YIELD_PERFORMED = 0x000002d1;
enum int ERROR_ARBITRATION_UNHANDLED = 0x000002d3;
enum int ERROR_MP_PROCESSOR_MISMATCH = 0x000002d5;
enum int ERROR_RESUME_HIBERNATION = 0x000002d7;
enum int ERROR_DRIVERS_LEAKING_LOCKED_PAGES = 0x000002d9;

enum : int
{
    ERROR_WAIT_1            = 0x000002db,
    ERROR_WAIT_2            = 0x000002dc,
    ERROR_WAIT_3            = 0x000002dd,
    ERROR_WAIT_63           = 0x000002de,
    ERROR_ABANDONED_WAIT_0  = 0x000002df,
    ERROR_ABANDONED_WAIT_63 = 0x000002e0,
}

enum int ERROR_KERNEL_APC = 0x000002e2;
enum int ERROR_ELEVATION_REQUIRED = 0x000002e4;
enum int ERROR_OPLOCK_BREAK_IN_PROGRESS = 0x000002e6;
enum int ERROR_RXACT_COMMITTED = 0x000002e8;
enum int ERROR_PRIMARY_TRANSPORT_CONNECT_FAILED = 0x000002ea;

enum : int
{
    ERROR_PAGE_FAULT_DEMAND_ZERO   = 0x000002ec,
    ERROR_PAGE_FAULT_COPY_ON_WRITE = 0x000002ed,
    ERROR_PAGE_FAULT_GUARD_PAGE    = 0x000002ee,
    ERROR_PAGE_FAULT_PAGING_FILE   = 0x000002ef,
}

enum int ERROR_CRASH_DUMP = 0x000002f1;
enum int ERROR_REPARSE_OBJECT = 0x000002f3;
enum int ERROR_TRANSLATION_COMPLETE = 0x000002f5;

enum : int
{
    ERROR_PROCESS_NOT_IN_JOB = 0x000002f7,
    ERROR_PROCESS_IN_JOB     = 0x000002f8,
}

enum int ERROR_FSFILTER_OP_COMPLETED_SUCCESSFULLY = 0x000002fa;
enum int ERROR_INTERRUPT_STILL_CONNECTED = 0x000002fc;
enum int ERROR_DBG_EXCEPTION_HANDLED = 0x000002fe;
enum int ERROR_CALLBACK_POP_STACK = 0x00000300;

enum : int
{
    ERROR_CANTFETCHBACKWARDS  = 0x00000302,
    ERROR_CANTSCROLLBACKWARDS = 0x00000303,
}

enum int ERROR_BAD_ACCESSOR_FLAGS = 0x00000305;
enum int ERROR_NOT_CAPABLE = 0x00000307;
enum int ERROR_VERSION_PARSE_ERROR = 0x00000309;
enum int ERROR_MEMORY_HARDWARE = 0x0000030b;
enum int ERROR_INSUFFICIENT_RESOURCE_FOR_SPECIFIED_SHARED_SECTION_SIZE = 0x0000030d;
enum int ERROR_SYSTEM_POWERSTATE_COMPLEX_TRANSITION = 0x0000030f;

enum : int
{
    ERROR_ACCESS_AUDIT_BY_POLICY                = 0x00000311,
    ERROR_ACCESS_DISABLED_NO_SAFER_UI_BY_POLICY = 0x00000312,
}

enum : int
{
    ERROR_LOST_WRITEBEHIND_DATA_NETWORK_DISCONNECTED = 0x00000314,
    ERROR_LOST_WRITEBEHIND_DATA_NETWORK_SERVER_ERROR = 0x00000315,
    ERROR_LOST_WRITEBEHIND_DATA_LOCAL_DISK_ERROR     = 0x00000316,
}

enum : int
{
    ERROR_DISK_REPAIR_REDIRECTED   = 0x00000318,
    ERROR_DISK_REPAIR_UNSUCCESSFUL = 0x00000319,
}

enum : int
{
    ERROR_CORRUPT_LOG_CORRUPTED    = 0x0000031b,
    ERROR_CORRUPT_LOG_UNAVAILABLE  = 0x0000031c,
    ERROR_CORRUPT_LOG_DELETED_FULL = 0x0000031d,
    ERROR_CORRUPT_LOG_CLEARED      = 0x0000031e,
}

enum int ERROR_OPLOCK_SWITCHED_TO_NEW_HANDLE = 0x00000320;
enum int ERROR_CANNOT_BREAK_OPLOCK = 0x00000322;
enum int ERROR_NO_ACE_CONDITION = 0x00000324;
enum int ERROR_FILE_HANDLE_REVOKED = 0x00000326;
enum int ERROR_ENCRYPTED_IO_NOT_POSSIBLE = 0x00000328;
enum int ERROR_QUOTA_ACTIVITY = 0x0000032a;
enum int ERROR_CALLBACK_INVOKE_INLINE = 0x0000032c;

enum : int
{
    ERROR_ENCLAVE_NOT_TERMINATED = 0x0000032e,
    ERROR_ENCLAVE_VIOLATION      = 0x0000032f,
}

enum int ERROR_OPERATION_ABORTED = 0x000003e3;
enum int ERROR_IO_PENDING = 0x000003e5;

enum : int
{
    ERROR_SWAPERROR      = 0x000003e7,
    ERROR_STACK_OVERFLOW = 0x000003e9,
}

enum int ERROR_CAN_NOT_COMPLETE = 0x000003eb;
enum int ERROR_UNRECOGNIZED_VOLUME = 0x000003ed;
enum int ERROR_FULLSCREEN_MODE = 0x000003ef;

enum : int
{
    ERROR_BADDB     = 0x000003f1,
    ERROR_BADKEY    = 0x000003f2,
    ERROR_CANTOPEN  = 0x000003f3,
    ERROR_CANTREAD  = 0x000003f4,
    ERROR_CANTWRITE = 0x000003f5,
}

enum : int
{
    ERROR_REGISTRY_CORRUPT   = 0x000003f7,
    ERROR_REGISTRY_IO_FAILED = 0x000003f8,
}

enum int ERROR_KEY_DELETED = 0x000003fa;
enum int ERROR_KEY_HAS_CHILDREN = 0x000003fc;
enum int ERROR_NOTIFY_ENUM_DIR = 0x000003fe;
enum int ERROR_INVALID_SERVICE_CONTROL = 0x0000041c;

enum : int
{
    ERROR_SERVICE_NO_THREAD       = 0x0000041e,
    ERROR_SERVICE_DATABASE_LOCKED = 0x0000041f,
    ERROR_SERVICE_ALREADY_RUNNING = 0x00000420,
}

enum int ERROR_SERVICE_DISABLED = 0x00000422;

enum : int
{
    ERROR_SERVICE_DOES_NOT_EXIST     = 0x00000424,
    ERROR_SERVICE_CANNOT_ACCEPT_CTRL = 0x00000425,
    ERROR_SERVICE_NOT_ACTIVE         = 0x00000426,
}

enum int ERROR_EXCEPTION_IN_SERVICE = 0x00000428;
enum int ERROR_SERVICE_SPECIFIC_ERROR = 0x0000042a;

enum : int
{
    ERROR_SERVICE_DEPENDENCY_FAIL = 0x0000042c,
    ERROR_SERVICE_LOGON_FAILED    = 0x0000042d,
    ERROR_SERVICE_START_HANG      = 0x0000042e,
}

enum : int
{
    ERROR_SERVICE_MARKED_FOR_DELETE = 0x00000430,
    ERROR_SERVICE_EXISTS            = 0x00000431,
}

enum int ERROR_SERVICE_DEPENDENCY_DELETED = 0x00000433;
enum int ERROR_SERVICE_NEVER_STARTED = 0x00000435;
enum int ERROR_DIFFERENT_SERVICE_ACCOUNT = 0x00000437;
enum int ERROR_CANNOT_DETECT_PROCESS_ABORT = 0x00000439;
enum int ERROR_SERVICE_NOT_IN_EXE = 0x0000043b;
enum int ERROR_END_OF_MEDIA = 0x0000044c;
enum int ERROR_BEGINNING_OF_MEDIA = 0x0000044e;
enum int ERROR_NO_DATA_DETECTED = 0x00000450;
enum int ERROR_INVALID_BLOCK_LENGTH = 0x00000452;

enum : int
{
    ERROR_UNABLE_TO_LOCK_MEDIA   = 0x00000454,
    ERROR_UNABLE_TO_UNLOAD_MEDIA = 0x00000455,
}

enum int ERROR_BUS_RESET = 0x00000457;
enum int ERROR_NO_UNICODE_TRANSLATION = 0x00000459;
enum int ERROR_SHUTDOWN_IN_PROGRESS = 0x0000045b;
enum int ERROR_IO_DEVICE = 0x0000045d;

enum : int
{
    ERROR_IRQ_BUSY    = 0x0000045f,
    ERROR_MORE_WRITES = 0x00000460,
}

enum : int
{
    ERROR_FLOPPY_ID_MARK_NOT_FOUND = 0x00000462,
    ERROR_FLOPPY_WRONG_CYLINDER    = 0x00000463,
    ERROR_FLOPPY_UNKNOWN_ERROR     = 0x00000464,
    ERROR_FLOPPY_BAD_REGISTERS     = 0x00000465,
}

enum : int
{
    ERROR_DISK_OPERATION_FAILED = 0x00000467,
    ERROR_DISK_RESET_FAILED     = 0x00000468,
}

enum int ERROR_NOT_ENOUGH_SERVER_MEMORY = 0x0000046a;
enum int ERROR_MAPPED_ALIGNMENT = 0x0000046c;
enum int ERROR_SET_POWER_STATE_FAILED = 0x00000475;
enum int ERROR_OLD_WIN_VERSION = 0x0000047e;
enum int ERROR_SINGLE_INSTANCE_APP = 0x00000480;
enum int ERROR_INVALID_DLL = 0x00000482;

enum : int
{
    ERROR_DDE_FAIL      = 0x00000484,
    ERROR_DLL_NOT_FOUND = 0x00000485,
}

enum int ERROR_MESSAGE_SYNC_ONLY = 0x00000487;
enum int ERROR_DESTINATION_ELEMENT_FULL = 0x00000489;
enum int ERROR_MAGAZINE_NOT_PRESENT = 0x0000048b;

enum : int
{
    ERROR_DEVICE_REQUIRES_CLEANING = 0x0000048d,
    ERROR_DEVICE_DOOR_OPEN         = 0x0000048e,
    ERROR_DEVICE_NOT_CONNECTED     = 0x0000048f,
}

enum : int
{
    ERROR_NO_MATCH      = 0x00000491,
    ERROR_SET_NOT_FOUND = 0x00000492,
}

enum int ERROR_NO_TRACKING_SERVICE = 0x00000494;

enum : int
{
    ERROR_UNABLE_TO_REMOVE_REPLACED    = 0x00000497,
    ERROR_UNABLE_TO_MOVE_REPLACEMENT   = 0x00000498,
    ERROR_UNABLE_TO_MOVE_REPLACEMENT_2 = 0x00000499,
}

enum int ERROR_JOURNAL_NOT_ACTIVE = 0x0000049b;
enum int ERROR_JOURNAL_ENTRY_DELETED = 0x0000049d;
enum int ERROR_SHUTDOWN_USERS_LOGGED_ON = 0x000004a7;
enum int ERROR_CONNECTION_UNAVAIL = 0x000004b1;
enum int ERROR_NO_NET_OR_BAD_PATH = 0x000004b3;
enum int ERROR_CANNOT_OPEN_PROFILE = 0x000004b5;
enum int ERROR_NOT_CONTAINER = 0x000004b7;

enum : int
{
    ERROR_INVALID_GROUPNAME    = 0x000004b9,
    ERROR_INVALID_COMPUTERNAME = 0x000004ba,
    ERROR_INVALID_EVENTNAME    = 0x000004bb,
    ERROR_INVALID_DOMAINNAME   = 0x000004bc,
    ERROR_INVALID_SERVICENAME  = 0x000004bd,
    ERROR_INVALID_NETNAME      = 0x000004be,
    ERROR_INVALID_SHARENAME    = 0x000004bf,
    ERROR_INVALID_PASSWORDNAME = 0x000004c0,
    ERROR_INVALID_MESSAGENAME  = 0x000004c1,
    ERROR_INVALID_MESSAGEDEST  = 0x000004c2,
}

enum int ERROR_REMOTE_SESSION_LIMIT_EXCEEDED = 0x000004c4;
enum int ERROR_NO_NETWORK = 0x000004c6;
enum int ERROR_USER_MAPPED_FILE = 0x000004c8;
enum int ERROR_GRACEFUL_DISCONNECT = 0x000004ca;
enum int ERROR_ADDRESS_NOT_ASSOCIATED = 0x000004cc;
enum int ERROR_CONNECTION_ACTIVE = 0x000004ce;
enum int ERROR_HOST_UNREACHABLE = 0x000004d0;
enum int ERROR_PORT_UNREACHABLE = 0x000004d2;
enum int ERROR_CONNECTION_ABORTED = 0x000004d4;
enum int ERROR_CONNECTION_COUNT_LIMIT = 0x000004d6;
enum int ERROR_LOGIN_WKSTA_RESTRICTION = 0x000004d8;
enum int ERROR_ALREADY_REGISTERED = 0x000004da;

enum : int
{
    ERROR_NOT_AUTHENTICATED = 0x000004dc,
    ERROR_NOT_LOGGED_ON     = 0x000004dd,
}

enum int ERROR_ALREADY_INITIALIZED = 0x000004df;
enum int ERROR_NO_SUCH_SITE = 0x000004e1;
enum int ERROR_ONLY_IF_CONNECTED = 0x000004e3;
enum int ERROR_BAD_USER_PROFILE = 0x000004e5;
enum int ERROR_SERVER_SHUTDOWN_IN_PROGRESS = 0x000004e7;

enum : int
{
    ERROR_NON_ACCOUNT_SID = 0x000004e9,
    ERROR_NON_DOMAIN_SID  = 0x000004ea,
}

enum int ERROR_ACCESS_DISABLED_BY_POLICY = 0x000004ec;
enum int ERROR_CSCSHARE_OFFLINE = 0x000004ee;
enum int ERROR_SMARTCARD_SUBSYSTEM_FAILURE = 0x000004f0;
enum int ERROR_MACHINE_LOCKED = 0x000004f7;
enum int ERROR_CALLBACK_SUPPLIED_INVALID_DATA = 0x000004f9;
enum int ERROR_DRIVER_BLOCKED = 0x000004fb;

enum : int
{
    ERROR_ACCESS_DISABLED_WEBBLADE        = 0x000004fd,
    ERROR_ACCESS_DISABLED_WEBBLADE_TAMPER = 0x000004fe,
}

enum : int
{
    ERROR_ALREADY_FIBER  = 0x00000500,
    ERROR_ALREADY_THREAD = 0x00000501,
}

enum int ERROR_PARAMETER_QUOTA_EXCEEDED = 0x00000503;
enum int ERROR_DELAY_LOAD_FAILED = 0x00000505;
enum int ERROR_UNIDENTIFIED_ERROR = 0x00000507;
enum int ERROR_BEYOND_VDL = 0x00000509;
enum int ERROR_DRIVER_PROCESS_TERMINATED = 0x0000050b;
enum int ERROR_PROCESS_IS_PROTECTED = 0x0000050d;
enum int ERROR_DISK_QUOTA_EXCEEDED = 0x0000050f;
enum int ERROR_INCOMPATIBLE_SERVICE_PRIVILEGE = 0x00000511;
enum int ERROR_INVALID_LABEL = 0x00000513;
enum int ERROR_SOME_NOT_MAPPED = 0x00000515;
enum int ERROR_LOCAL_USER_SESSION_KEY = 0x00000517;
enum int ERROR_UNKNOWN_REVISION = 0x00000519;

enum : int
{
    ERROR_INVALID_OWNER         = 0x0000051b,
    ERROR_INVALID_PRIMARY_GROUP = 0x0000051c,
}

enum int ERROR_CANT_DISABLE_MANDATORY = 0x0000051e;

enum : int
{
    ERROR_NO_SUCH_LOGON_SESSION = 0x00000520,
    ERROR_NO_SUCH_PRIVILEGE     = 0x00000521,
}

enum int ERROR_INVALID_ACCOUNT_NAME = 0x00000523;
enum int ERROR_NO_SUCH_USER = 0x00000525;
enum int ERROR_NO_SUCH_GROUP = 0x00000527;
enum int ERROR_MEMBER_NOT_IN_GROUP = 0x00000529;
enum int ERROR_WRONG_PASSWORD = 0x0000052b;
enum int ERROR_PASSWORD_RESTRICTION = 0x0000052d;
enum int ERROR_ACCOUNT_RESTRICTION = 0x0000052f;
enum int ERROR_INVALID_WORKSTATION = 0x00000531;
enum int ERROR_ACCOUNT_DISABLED = 0x00000533;
enum int ERROR_TOO_MANY_LUIDS_REQUESTED = 0x00000535;

enum : int
{
    ERROR_INVALID_SUB_AUTHORITY  = 0x00000537,
    ERROR_INVALID_ACL            = 0x00000538,
    ERROR_INVALID_SID            = 0x00000539,
    ERROR_INVALID_SECURITY_DESCR = 0x0000053a,
}

enum : int
{
    ERROR_SERVER_DISABLED     = 0x0000053d,
    ERROR_SERVER_NOT_DISABLED = 0x0000053e,
}

enum int ERROR_ALLOTTED_SPACE_EXCEEDED = 0x00000540;
enum int ERROR_BAD_IMPERSONATION_LEVEL = 0x00000542;
enum int ERROR_BAD_VALIDATION_CLASS = 0x00000544;
enum int ERROR_NO_SECURITY_ON_OBJECT = 0x00000546;

enum : int
{
    ERROR_INVALID_SERVER_STATE = 0x00000548,
    ERROR_INVALID_DOMAIN_STATE = 0x00000549,
    ERROR_INVALID_DOMAIN_ROLE  = 0x0000054a,
}

enum : int
{
    ERROR_DOMAIN_EXISTS         = 0x0000054c,
    ERROR_DOMAIN_LIMIT_EXCEEDED = 0x0000054d,
}

enum int ERROR_INTERNAL_ERROR = 0x0000054f;
enum int ERROR_BAD_DESCRIPTOR_FORMAT = 0x00000551;
enum int ERROR_LOGON_SESSION_EXISTS = 0x00000553;
enum int ERROR_BAD_LOGON_SESSION_STATE = 0x00000555;
enum int ERROR_INVALID_LOGON_TYPE = 0x00000557;

enum : int
{
    ERROR_RXACT_INVALID_STATE  = 0x00000559,
    ERROR_RXACT_COMMIT_FAILURE = 0x0000055a,
}

enum : int
{
    ERROR_SPECIAL_GROUP = 0x0000055c,
    ERROR_SPECIAL_USER  = 0x0000055d,
}

enum int ERROR_TOKEN_ALREADY_IN_USE = 0x0000055f;

enum : int
{
    ERROR_MEMBER_NOT_IN_ALIAS = 0x00000561,
    ERROR_MEMBER_IN_ALIAS     = 0x00000562,
}

enum int ERROR_LOGON_NOT_GRANTED = 0x00000564;
enum int ERROR_SECRET_TOO_LONG = 0x00000566;
enum int ERROR_TOO_MANY_CONTEXT_IDS = 0x00000568;
enum int ERROR_NT_CROSS_ENCRYPTION_REQUIRED = 0x0000056a;
enum int ERROR_INVALID_MEMBER = 0x0000056c;
enum int ERROR_LM_CROSS_ENCRYPTION_REQUIRED = 0x0000056e;
enum int ERROR_FILE_CORRUPT = 0x00000570;
enum int ERROR_NO_USER_SESSION_KEY = 0x00000572;
enum int ERROR_WRONG_TARGET_NAME = 0x00000574;
enum int ERROR_TIME_SKEW = 0x00000576;

enum : int
{
    ERROR_INVALID_WINDOW_HANDLE = 0x00000578,
    ERROR_INVALID_MENU_HANDLE   = 0x00000579,
    ERROR_INVALID_CURSOR_HANDLE = 0x0000057a,
    ERROR_INVALID_ACCEL_HANDLE  = 0x0000057b,
    ERROR_INVALID_HOOK_HANDLE   = 0x0000057c,
    ERROR_INVALID_DWP_HANDLE    = 0x0000057d,
}

enum int ERROR_CANNOT_FIND_WND_CLASS = 0x0000057f;
enum int ERROR_HOTKEY_ALREADY_REGISTERED = 0x00000581;

enum : int
{
    ERROR_CLASS_DOES_NOT_EXIST = 0x00000583,
    ERROR_CLASS_HAS_WINDOWS    = 0x00000584,
}

enum int ERROR_INVALID_ICON_HANDLE = 0x00000586;
enum int ERROR_LISTBOX_ID_NOT_FOUND = 0x00000588;
enum int ERROR_CLIPBOARD_NOT_OPEN = 0x0000058a;
enum int ERROR_WINDOW_NOT_DIALOG = 0x0000058c;
enum int ERROR_INVALID_COMBOBOX_MESSAGE = 0x0000058e;
enum int ERROR_INVALID_EDIT_HEIGHT = 0x00000590;

enum : int
{
    ERROR_INVALID_HOOK_FILTER = 0x00000592,
    ERROR_INVALID_FILTER_PROC = 0x00000593,
}

enum int ERROR_GLOBAL_ONLY_HOOK = 0x00000595;
enum int ERROR_HOOK_NOT_INSTALLED = 0x00000597;
enum int ERROR_SETCOUNT_ON_BAD_LB = 0x00000599;
enum int ERROR_DESTROY_OBJECT_OF_OTHER_THREAD = 0x0000059b;
enum int ERROR_NO_SYSTEM_MENU = 0x0000059d;
enum int ERROR_INVALID_SPI_VALUE = 0x0000059f;
enum int ERROR_HWNDS_HAVE_DIFF_PARENT = 0x000005a1;

enum : int
{
    ERROR_INVALID_GW_COMMAND = 0x000005a3,
    ERROR_INVALID_THREAD_ID  = 0x000005a4,
}

enum int ERROR_POPUP_ALREADY_ACTIVE = 0x000005a6;

enum : int
{
    ERROR_INVALID_SCROLLBAR_RANGE = 0x000005a8,
    ERROR_INVALID_SHOWWIN_COMMAND = 0x000005a9,
}

enum int ERROR_NONPAGED_SYSTEM_RESOURCES = 0x000005ab;
enum int ERROR_WORKING_SET_QUOTA = 0x000005ad;
enum int ERROR_COMMITMENT_LIMIT = 0x000005af;
enum int ERROR_INVALID_KEYBOARD_HANDLE = 0x000005b1;
enum int ERROR_REQUIRES_INTERACTIVE_WINDOWSTATION = 0x000005b3;
enum int ERROR_INVALID_MONITOR_HANDLE = 0x000005b5;

enum : int
{
    ERROR_SYMLINK_CLASS_DISABLED = 0x000005b7,
    ERROR_SYMLINK_NOT_SUPPORTED  = 0x000005b8,
}

enum int ERROR_XMLDSIG_ERROR = 0x000005ba;
enum int ERROR_WRONG_COMPARTMENT = 0x000005bc;
enum int ERROR_NO_NVRAM_RESOURCES = 0x000005be;

enum : int
{
    ERROR_EVENTLOG_FILE_CORRUPT = 0x000005dc,
    ERROR_EVENTLOG_CANT_START   = 0x000005dd,
}

enum int ERROR_EVENTLOG_FILE_CHANGED = 0x000005df;
enum int ERROR_JOB_NO_CONTAINER = 0x000005e1;
enum int ERROR_INVALID_TASK_INDEX = 0x0000060f;

enum : int
{
    ERROR_INSTALL_SERVICE_FAILURE = 0x00000641,
    ERROR_INSTALL_USEREXIT        = 0x00000642,
    ERROR_INSTALL_FAILURE         = 0x00000643,
    ERROR_INSTALL_SUSPEND         = 0x00000644,
}

enum : int
{
    ERROR_UNKNOWN_FEATURE   = 0x00000646,
    ERROR_UNKNOWN_COMPONENT = 0x00000647,
    ERROR_UNKNOWN_PROPERTY  = 0x00000648,
}

enum int ERROR_BAD_CONFIGURATION = 0x0000064a;

enum : int
{
    ERROR_INSTALL_SOURCE_ABSENT   = 0x0000064c,
    ERROR_INSTALL_PACKAGE_VERSION = 0x0000064d,
}

enum int ERROR_BAD_QUERY_SYNTAX = 0x0000064f;
enum int ERROR_DEVICE_REMOVED = 0x00000651;

enum : int
{
    ERROR_INSTALL_PACKAGE_OPEN_FAILED  = 0x00000653,
    ERROR_INSTALL_PACKAGE_INVALID      = 0x00000654,
    ERROR_INSTALL_UI_FAILURE           = 0x00000655,
    ERROR_INSTALL_LOG_FAILURE          = 0x00000656,
    ERROR_INSTALL_LANGUAGE_UNSUPPORTED = 0x00000657,
    ERROR_INSTALL_TRANSFORM_FAILURE    = 0x00000658,
    ERROR_INSTALL_PACKAGE_REJECTED     = 0x00000659,
}

enum int ERROR_FUNCTION_FAILED = 0x0000065b;
enum int ERROR_DATATYPE_MISMATCH = 0x0000065d;
enum int ERROR_CREATE_FAILED = 0x0000065f;

enum : int
{
    ERROR_INSTALL_PLATFORM_UNSUPPORTED = 0x00000661,
    ERROR_INSTALL_NOTUSED              = 0x00000662,
}

enum : int
{
    ERROR_PATCH_PACKAGE_INVALID     = 0x00000664,
    ERROR_PATCH_PACKAGE_UNSUPPORTED = 0x00000665,
}

enum int ERROR_INVALID_COMMAND_LINE = 0x00000667;
enum int ERROR_SUCCESS_REBOOT_INITIATED = 0x00000669;
enum int ERROR_PATCH_PACKAGE_REJECTED = 0x0000066b;
enum int ERROR_INSTALL_REMOTE_PROHIBITED = 0x0000066d;
enum int ERROR_UNKNOWN_PATCH = 0x0000066f;
enum int ERROR_PATCH_REMOVAL_DISALLOWED = 0x00000671;
enum int ERROR_PATCH_MANAGED_ADVERTISED_PRODUCT = 0x00000673;
enum int ERROR_FAIL_FAST_EXCEPTION = 0x00000675;
enum int ERROR_DYNAMIC_CODE_BLOCKED = 0x00000677;
enum int ERROR_STRICT_CFG_VIOLATION = 0x00000679;
enum int ERROR_CROSS_PARTITION_VIOLATION = 0x0000067d;
enum int RPC_S_INVALID_STRING_BINDING = 0x000006a4;
enum int RPC_S_INVALID_BINDING = 0x000006a6;

enum : int
{
    RPC_S_INVALID_RPC_PROTSEQ     = 0x000006a8,
    RPC_S_INVALID_STRING_UUID     = 0x000006a9,
    RPC_S_INVALID_ENDPOINT_FORMAT = 0x000006aa,
    RPC_S_INVALID_NET_ADDR        = 0x000006ab,
}

enum int RPC_S_INVALID_TIMEOUT = 0x000006ad;
enum int RPC_S_ALREADY_REGISTERED = 0x000006af;
enum int RPC_S_ALREADY_LISTENING = 0x000006b1;
enum int RPC_S_NOT_LISTENING = 0x000006b3;
enum int RPC_S_UNKNOWN_IF = 0x000006b5;
enum int RPC_S_NO_PROTSEQS = 0x000006b7;
enum int RPC_S_OUT_OF_RESOURCES = 0x000006b9;
enum int RPC_S_SERVER_TOO_BUSY = 0x000006bb;
enum int RPC_S_NO_CALL_ACTIVE = 0x000006bd;
enum int RPC_S_CALL_FAILED_DNE = 0x000006bf;
enum int RPC_S_PROXY_ACCESS_DENIED = 0x000006c1;
enum int RPC_S_UNSUPPORTED_TYPE = 0x000006c4;
enum int RPC_S_INVALID_BOUND = 0x000006c6;
enum int RPC_S_INVALID_NAME_SYNTAX = 0x000006c8;
enum int RPC_S_UUID_NO_ADDRESS = 0x000006cb;
enum int RPC_S_UNKNOWN_AUTHN_TYPE = 0x000006cd;
enum int RPC_S_STRING_TOO_LONG = 0x000006cf;
enum int RPC_S_PROCNUM_OUT_OF_RANGE = 0x000006d1;

enum : int
{
    RPC_S_UNKNOWN_AUTHN_SERVICE = 0x000006d3,
    RPC_S_UNKNOWN_AUTHN_LEVEL   = 0x000006d4,
}

enum int RPC_S_UNKNOWN_AUTHZ_SERVICE = 0x000006d6;
enum int EPT_S_CANT_PERFORM_OP = 0x000006d8;
enum int RPC_S_NOTHING_TO_EXPORT = 0x000006da;
enum int RPC_S_INVALID_VERS_OPTION = 0x000006dc;
enum int RPC_S_NOT_ALL_OBJS_UNEXPORTED = 0x000006de;

enum : int
{
    RPC_S_ENTRY_ALREADY_EXISTS = 0x000006e0,
    RPC_S_ENTRY_NOT_FOUND      = 0x000006e1,
}

enum int RPC_S_INVALID_NAF_ID = 0x000006e3;
enum int RPC_S_NO_CONTEXT_AVAILABLE = 0x000006e5;
enum int RPC_S_ZERO_DIVIDE = 0x000006e7;

enum : int
{
    RPC_S_FP_DIV_ZERO  = 0x000006e9,
    RPC_S_FP_UNDERFLOW = 0x000006ea,
    RPC_S_FP_OVERFLOW  = 0x000006eb,
}

enum : int
{
    RPC_X_SS_CHAR_TRANS_OPEN_FAIL  = 0x000006ed,
    RPC_X_SS_CHAR_TRANS_SHORT_FILE = 0x000006ee,
}

enum int RPC_X_SS_CONTEXT_DAMAGED = 0x000006f1;
enum int RPC_X_SS_CANNOT_GET_CALL_HANDLE = 0x000006f3;
enum int RPC_X_ENUM_VALUE_OUT_OF_RANGE = 0x000006f5;
enum int RPC_X_BAD_STUB_DATA = 0x000006f7;
enum int ERROR_UNRECOGNIZED_MEDIA = 0x000006f9;
enum int ERROR_NO_TRUST_SAM_ACCOUNT = 0x000006fb;
enum int ERROR_TRUSTED_RELATIONSHIP_FAILURE = 0x000006fd;
enum int RPC_S_CALL_IN_PROGRESS = 0x000006ff;
enum int ERROR_ACCOUNT_EXPIRED = 0x00000701;
enum int ERROR_PRINTER_DRIVER_ALREADY_INSTALLED = 0x00000703;

enum : int
{
    ERROR_UNKNOWN_PRINTER_DRIVER = 0x00000705,
    ERROR_UNKNOWN_PRINTPROCESSOR = 0x00000706,
}

enum : int
{
    ERROR_INVALID_PRIORITY     = 0x00000708,
    ERROR_INVALID_PRINTER_NAME = 0x00000709,
}

enum : int
{
    ERROR_INVALID_PRINTER_COMMAND = 0x0000070b,
    ERROR_INVALID_DATATYPE        = 0x0000070c,
    ERROR_INVALID_ENVIRONMENT     = 0x0000070d,
}

enum int ERROR_NOLOGON_INTERDOMAIN_TRUST_ACCOUNT = 0x0000070f;
enum int ERROR_NOLOGON_SERVER_TRUST_ACCOUNT = 0x00000711;
enum int ERROR_SERVER_HAS_OPEN_HANDLES = 0x00000713;

enum : int
{
    ERROR_RESOURCE_TYPE_NOT_FOUND = 0x00000715,
    ERROR_RESOURCE_NAME_NOT_FOUND = 0x00000716,
    ERROR_RESOURCE_LANG_NOT_FOUND = 0x00000717,
}

enum int RPC_S_NO_INTERFACES = 0x00000719;
enum int RPC_S_BINDING_INCOMPLETE = 0x0000071b;
enum int RPC_S_UNSUPPORTED_AUTHN_LEVEL = 0x0000071d;
enum int RPC_S_NOT_RPC_ERROR = 0x0000071f;
enum int RPC_S_SEC_PKG_ERROR = 0x00000721;
enum int RPC_X_INVALID_ES_ACTION = 0x00000723;
enum int RPC_X_WRONG_STUB_VERSION = 0x00000725;

enum : int
{
    RPC_X_WRONG_PIPE_ORDER   = 0x00000727,
    RPC_X_WRONG_PIPE_VERSION = 0x00000728,
}

enum int RPC_S_DO_NOT_DISTURB = 0x0000072a;
enum int RPC_S_SYSTEM_HANDLE_TYPE_MISMATCH = 0x0000072c;
enum int EPT_S_CANT_CREATE = 0x0000076b;

enum : int
{
    ERROR_INVALID_TIME      = 0x0000076d,
    ERROR_INVALID_FORM_NAME = 0x0000076e,
    ERROR_INVALID_FORM_SIZE = 0x0000076f,
}

enum int ERROR_PRINTER_DELETED = 0x00000771;
enum int ERROR_PASSWORD_MUST_CHANGE = 0x00000773;
enum int ERROR_ACCOUNT_LOCKED_OUT = 0x00000775;

enum : int
{
    OR_INVALID_OID = 0x00000777,
    OR_INVALID_SET = 0x00000778,
}

enum : int
{
    RPC_S_INVALID_ASYNC_HANDLE = 0x0000077a,
    RPC_S_INVALID_ASYNC_CALL   = 0x0000077b,
}

enum : int
{
    RPC_X_PIPE_DISCIPLINE_ERROR = 0x0000077d,
    RPC_X_PIPE_EMPTY            = 0x0000077e,
}

enum : int
{
    ERROR_CANT_ACCESS_FILE      = 0x00000780,
    ERROR_CANT_RESOLVE_FILENAME = 0x00000781,
}

enum int RPC_S_NOT_ALL_OBJS_EXPORTED = 0x00000783;
enum int RPC_S_PROFILE_NOT_ADDED = 0x00000785;
enum int RPC_S_PRF_ELT_NOT_REMOVED = 0x00000787;
enum int RPC_S_GRP_ELT_NOT_REMOVED = 0x00000789;
enum int ERROR_CONTEXT_EXPIRED = 0x0000078b;
enum int ERROR_ALL_USER_TRUST_QUOTA_EXCEEDED = 0x0000078d;
enum int ERROR_AUTHENTICATION_FIREWALL_FAILED = 0x0000078f;
enum int ERROR_NTLM_BLOCKED = 0x00000791;
enum int ERROR_LOST_MODE_LOGON_RESTRICTION = 0x00000793;
enum int ERROR_BAD_DRIVER = 0x000007d1;
enum int ERROR_METAFILE_NOT_SUPPORTED = 0x000007d3;
enum int ERROR_CLIPPING_NOT_SUPPORTED = 0x000007d5;
enum int ERROR_INVALID_PROFILE = 0x000007db;
enum int ERROR_TAG_NOT_PRESENT = 0x000007dd;

enum : int
{
    ERROR_PROFILE_NOT_ASSOCIATED_WITH_DEVICE = 0x000007df,
    ERROR_PROFILE_NOT_FOUND                  = 0x000007e0,
}

enum int ERROR_ICM_NOT_ENABLED = 0x000007e2;
enum int ERROR_INVALID_TRANSFORM = 0x000007e4;
enum int ERROR_INVALID_COLORINDEX = 0x000007e6;

enum : int
{
    ERROR_CONNECTED_OTHER_PASSWORD         = 0x0000083c,
    ERROR_CONNECTED_OTHER_PASSWORD_DEFAULT = 0x0000083d,
}

enum int ERROR_NOT_CONNECTED = 0x000008ca;
enum int ERROR_ACTIVE_CONNECTIONS = 0x00000962;
enum int ERROR_UNKNOWN_PRINT_MONITOR = 0x00000bb8;
enum int ERROR_SPOOL_FILE_NOT_FOUND = 0x00000bba;
enum int ERROR_SPL_NO_ADDJOB = 0x00000bbc;
enum int ERROR_PRINT_MONITOR_ALREADY_INSTALLED = 0x00000bbe;

enum : int
{
    ERROR_PRINT_MONITOR_IN_USE    = 0x00000bc0,
    ERROR_PRINTER_HAS_JOBS_QUEUED = 0x00000bc1,
}

enum int ERROR_SUCCESS_RESTART_REQUIRED = 0x00000bc3;

enum : int
{
    ERROR_PRINTER_DRIVER_WARNED         = 0x00000bc5,
    ERROR_PRINTER_DRIVER_BLOCKED        = 0x00000bc6,
    ERROR_PRINTER_DRIVER_PACKAGE_IN_USE = 0x00000bc7,
}

enum : int
{
    ERROR_FAIL_REBOOT_REQUIRED  = 0x00000bc9,
    ERROR_FAIL_REBOOT_INITIATED = 0x00000bca,
}

enum int ERROR_PRINT_JOB_RESTART_REQUIRED = 0x00000bcc;
enum int ERROR_PRINTER_NOT_SHAREABLE = 0x00000bce;
enum int ERROR_APPEXEC_CONDITION_NOT_SATISFIED = 0x00000bf4;
enum int ERROR_APPEXEC_INVALID_HOST_GENERATION = 0x00000bf6;

enum : int
{
    ERROR_APPEXEC_INVALID_HOST_STATE = 0x00000bf8,
    ERROR_APPEXEC_NO_DONOR           = 0x00000bf9,
    ERROR_APPEXEC_HOST_ID_MISMATCH   = 0x00000bfa,
    ERROR_APPEXEC_UNKNOWN_USER       = 0x00000bfb,
}

enum int ERROR_WINS_INTERNAL = 0x00000fa0;
enum int ERROR_STATIC_INIT = 0x00000fa2;
enum int ERROR_FULL_BACKUP = 0x00000fa4;
enum int ERROR_RPL_NOT_ALLOWED = 0x00000fa6;
enum int PEERDIST_ERROR_CANNOT_PARSE_CONTENTINFO = 0x00000fd3;

enum : int
{
    PEERDIST_ERROR_NO_MORE               = 0x00000fd5,
    PEERDIST_ERROR_NOT_INITIALIZED       = 0x00000fd6,
    PEERDIST_ERROR_ALREADY_INITIALIZED   = 0x00000fd7,
    PEERDIST_ERROR_SHUTDOWN_IN_PROGRESS  = 0x00000fd8,
    PEERDIST_ERROR_INVALIDATED           = 0x00000fd9,
    PEERDIST_ERROR_ALREADY_EXISTS        = 0x00000fda,
    PEERDIST_ERROR_OPERATION_NOTFOUND    = 0x00000fdb,
    PEERDIST_ERROR_ALREADY_COMPLETED     = 0x00000fdc,
    PEERDIST_ERROR_OUT_OF_BOUNDS         = 0x00000fdd,
    PEERDIST_ERROR_VERSION_UNSUPPORTED   = 0x00000fde,
    PEERDIST_ERROR_INVALID_CONFIGURATION = 0x00000fdf,
    PEERDIST_ERROR_NOT_LICENSED          = 0x00000fe0,
    PEERDIST_ERROR_SERVICE_UNAVAILABLE   = 0x00000fe1,
    PEERDIST_ERROR_TRUST_FAILURE         = 0x00000fe2,
}

enum : int
{
    ERROR_WMI_GUID_NOT_FOUND     = 0x00001068,
    ERROR_WMI_INSTANCE_NOT_FOUND = 0x00001069,
}

enum : int
{
    ERROR_WMI_TRY_AGAIN               = 0x0000106b,
    ERROR_WMI_DP_NOT_FOUND            = 0x0000106c,
    ERROR_WMI_UNRESOLVED_INSTANCE_REF = 0x0000106d,
}

enum int ERROR_WMI_GUID_DISCONNECTED = 0x0000106f;

enum : int
{
    ERROR_WMI_DP_FAILED       = 0x00001071,
    ERROR_WMI_INVALID_MOF     = 0x00001072,
    ERROR_WMI_INVALID_REGINFO = 0x00001073,
}

enum : int
{
    ERROR_WMI_READ_ONLY   = 0x00001075,
    ERROR_WMI_SET_FAILURE = 0x00001076,
}

enum int ERROR_APPCONTAINER_REQUIRED = 0x0000109b;

enum : int
{
    ERROR_INVALID_PACKAGE_SID_LENGTH = 0x0000109d,
    ERROR_INVALID_MEDIA              = 0x000010cc,
    ERROR_INVALID_LIBRARY            = 0x000010cd,
    ERROR_INVALID_MEDIA_POOL         = 0x000010ce,
}

enum int ERROR_MEDIA_OFFLINE = 0x000010d0;

enum : int
{
    ERROR_EMPTY     = 0x000010d2,
    ERROR_NOT_EMPTY = 0x000010d3,
}

enum int ERROR_RESOURCE_DISABLED = 0x000010d5;
enum int ERROR_UNABLE_TO_CLEAN = 0x000010d7;

enum : int
{
    ERROR_DATABASE_FAILURE = 0x000010d9,
    ERROR_DATABASE_FULL    = 0x000010da,
}

enum int ERROR_RESOURCE_NOT_PRESENT = 0x000010dc;
enum int ERROR_MEDIA_NOT_AVAILABLE = 0x000010de;
enum int ERROR_REQUEST_REFUSED = 0x000010e0;
enum int ERROR_LIBRARY_FULL = 0x000010e2;

enum : int
{
    ERROR_UNABLE_TO_LOAD_MEDIUM         = 0x000010e4,
    ERROR_UNABLE_TO_INVENTORY_DRIVE     = 0x000010e5,
    ERROR_UNABLE_TO_INVENTORY_SLOT      = 0x000010e6,
    ERROR_UNABLE_TO_INVENTORY_TRANSPORT = 0x000010e7,
}

enum int ERROR_CONTROLLING_IEPORT = 0x000010e9;

enum : int
{
    ERROR_CLEANER_SLOT_SET        = 0x000010eb,
    ERROR_CLEANER_SLOT_NOT_SET    = 0x000010ec,
    ERROR_CLEANER_CARTRIDGE_SPENT = 0x000010ed,
}

enum int ERROR_CANT_DELETE_LAST_ITEM = 0x000010ef;
enum int ERROR_VOLUME_CONTAINS_SYS_FILES = 0x000010f1;
enum int ERROR_NO_SUPPORTING_DRIVES = 0x000010f3;
enum int ERROR_IEPORT_FULL = 0x000010f5;

enum : int
{
    ERROR_REMOTE_STORAGE_NOT_ACTIVE  = 0x000010ff,
    ERROR_REMOTE_STORAGE_MEDIA_ERROR = 0x00001100,
}

enum int ERROR_REPARSE_ATTRIBUTE_CONFLICT = 0x00001127;

enum : int
{
    ERROR_REPARSE_TAG_INVALID       = 0x00001129,
    ERROR_REPARSE_TAG_MISMATCH      = 0x0000112a,
    ERROR_REPARSE_POINT_ENCOUNTERED = 0x0000112b,
}

enum : int
{
    ERROR_APP_DATA_EXPIRED         = 0x00001131,
    ERROR_APP_DATA_CORRUPT         = 0x00001132,
    ERROR_APP_DATA_LIMIT_EXCEEDED  = 0x00001133,
    ERROR_APP_DATA_REBOOT_REQUIRED = 0x00001134,
}

enum : int
{
    ERROR_SECUREBOOT_POLICY_VIOLATION                   = 0x00001145,
    ERROR_SECUREBOOT_INVALID_POLICY                     = 0x00001146,
    ERROR_SECUREBOOT_POLICY_PUBLISHER_NOT_FOUND         = 0x00001147,
    ERROR_SECUREBOOT_POLICY_NOT_SIGNED                  = 0x00001148,
    ERROR_SECUREBOOT_NOT_ENABLED                        = 0x00001149,
    ERROR_SECUREBOOT_FILE_REPLACED                      = 0x0000114a,
    ERROR_SECUREBOOT_POLICY_NOT_AUTHORIZED              = 0x0000114b,
    ERROR_SECUREBOOT_POLICY_UNKNOWN                     = 0x0000114c,
    ERROR_SECUREBOOT_POLICY_MISSING_ANTIROLLBACKVERSION = 0x0000114d,
}

enum : int
{
    ERROR_SECUREBOOT_POLICY_ROLLBACK_DETECTED     = 0x0000114f,
    ERROR_SECUREBOOT_POLICY_UPGRADE_MISMATCH      = 0x00001150,
    ERROR_SECUREBOOT_REQUIRED_POLICY_FILE_MISSING = 0x00001151,
}

enum int ERROR_SECUREBOOT_NOT_SUPPLEMENTAL_POLICY = 0x00001153;
enum int ERROR_OFFLOAD_WRITE_FLT_NOT_SUPPORTED = 0x00001159;
enum int ERROR_OFFLOAD_WRITE_FILE_NOT_SUPPORTED = 0x0000115b;
enum int ERROR_SMR_GARBAGE_COLLECTION_REQUIRED = 0x0000115d;
enum int ERROR_WOF_WIM_RESOURCE_TABLE_CORRUPT = 0x0000115f;
enum int ERROR_VOLUME_NOT_SIS_ENABLED = 0x00001194;

enum : int
{
    ERROR_SYSTEM_INTEGRITY_POLICY_VIOLATION                   = 0x000011c7,
    ERROR_SYSTEM_INTEGRITY_INVALID_POLICY                     = 0x000011c8,
    ERROR_SYSTEM_INTEGRITY_POLICY_NOT_SIGNED                  = 0x000011c9,
    ERROR_SYSTEM_INTEGRITY_TOO_MANY_POLICIES                  = 0x000011ca,
    ERROR_SYSTEM_INTEGRITY_SUPPLEMENTAL_POLICY_NOT_AUTHORIZED = 0x000011cb,
}

enum int ERROR_VSM_DMA_PROTECTION_NOT_IN_USE = 0x000011d1;

enum : int
{
    ERROR_PLATFORM_MANIFEST_INVALID                = 0x000011db,
    ERROR_PLATFORM_MANIFEST_FILE_NOT_AUTHORIZED    = 0x000011dc,
    ERROR_PLATFORM_MANIFEST_CATALOG_NOT_AUTHORIZED = 0x000011dd,
    ERROR_PLATFORM_MANIFEST_BINARY_ID_NOT_FOUND    = 0x000011de,
    ERROR_PLATFORM_MANIFEST_NOT_ACTIVE             = 0x000011df,
    ERROR_PLATFORM_MANIFEST_NOT_SIGNED             = 0x000011e0,
}

enum : int
{
    ERROR_DEPENDENCY_NOT_FOUND      = 0x0000138a,
    ERROR_DEPENDENCY_ALREADY_EXISTS = 0x0000138b,
}

enum int ERROR_HOST_NODE_NOT_AVAILABLE = 0x0000138d;
enum int ERROR_RESOURCE_NOT_FOUND = 0x0000138f;
enum int ERROR_CANT_EVICT_ACTIVE_NODE = 0x00001391;
enum int ERROR_OBJECT_IN_LIST = 0x00001393;

enum : int
{
    ERROR_GROUP_NOT_FOUND  = 0x00001395,
    ERROR_GROUP_NOT_ONLINE = 0x00001396,
}

enum int ERROR_HOST_NODE_NOT_GROUP_OWNER = 0x00001398;
enum int ERROR_RESMON_ONLINE_FAILED = 0x0000139a;
enum int ERROR_QUORUM_RESOURCE = 0x0000139c;
enum int ERROR_CLUSTER_SHUTTING_DOWN = 0x0000139e;
enum int ERROR_RESOURCE_PROPERTIES_STORED = 0x000013a0;
enum int ERROR_CORE_RESOURCE = 0x000013a2;
enum int ERROR_QUORUMLOG_OPEN_FAILED = 0x000013a4;

enum : int
{
    ERROR_CLUSTERLOG_RECORD_EXCEEDS_MAXSIZE = 0x000013a6,
    ERROR_CLUSTERLOG_EXCEEDS_MAXSIZE        = 0x000013a7,
    ERROR_CLUSTERLOG_CHKPOINT_NOT_FOUND     = 0x000013a8,
    ERROR_CLUSTERLOG_NOT_ENOUGH_SPACE       = 0x000013a9,
}

enum int ERROR_NETWORK_NOT_AVAILABLE = 0x000013ab;
enum int ERROR_ALL_NODES_NOT_AVAILABLE = 0x000013ad;

enum : int
{
    ERROR_CLUSTER_INVALID_NODE           = 0x000013af,
    ERROR_CLUSTER_NODE_EXISTS            = 0x000013b0,
    ERROR_CLUSTER_JOIN_IN_PROGRESS       = 0x000013b1,
    ERROR_CLUSTER_NODE_NOT_FOUND         = 0x000013b2,
    ERROR_CLUSTER_LOCAL_NODE_NOT_FOUND   = 0x000013b3,
    ERROR_CLUSTER_NETWORK_EXISTS         = 0x000013b4,
    ERROR_CLUSTER_NETWORK_NOT_FOUND      = 0x000013b5,
    ERROR_CLUSTER_NETINTERFACE_EXISTS    = 0x000013b6,
    ERROR_CLUSTER_NETINTERFACE_NOT_FOUND = 0x000013b7,
}

enum int ERROR_CLUSTER_INVALID_NETWORK_PROVIDER = 0x000013b9;

enum : int
{
    ERROR_CLUSTER_NODE_UNREACHABLE        = 0x000013bb,
    ERROR_CLUSTER_NODE_NOT_MEMBER         = 0x000013bc,
    ERROR_CLUSTER_JOIN_NOT_IN_PROGRESS    = 0x000013bd,
    ERROR_CLUSTER_INVALID_NETWORK         = 0x000013be,
    ERROR_CLUSTER_NODE_UP                 = 0x000013c0,
    ERROR_CLUSTER_IPADDR_IN_USE           = 0x000013c1,
    ERROR_CLUSTER_NODE_NOT_PAUSED         = 0x000013c2,
    ERROR_CLUSTER_NO_SECURITY_CONTEXT     = 0x000013c3,
    ERROR_CLUSTER_NETWORK_NOT_INTERNAL    = 0x000013c4,
    ERROR_CLUSTER_NODE_ALREADY_UP         = 0x000013c5,
    ERROR_CLUSTER_NODE_ALREADY_DOWN       = 0x000013c6,
    ERROR_CLUSTER_NETWORK_ALREADY_ONLINE  = 0x000013c7,
    ERROR_CLUSTER_NETWORK_ALREADY_OFFLINE = 0x000013c8,
    ERROR_CLUSTER_NODE_ALREADY_MEMBER     = 0x000013c9,
    ERROR_CLUSTER_LAST_INTERNAL_NETWORK   = 0x000013ca,
}

enum int ERROR_INVALID_OPERATION_ON_QUORUM = 0x000013cc;
enum int ERROR_CLUSTER_NODE_PAUSED = 0x000013ce;

enum : int
{
    ERROR_CLUSTER_NODE_NOT_READY        = 0x000013d0,
    ERROR_CLUSTER_NODE_SHUTTING_DOWN    = 0x000013d1,
    ERROR_CLUSTER_JOIN_ABORTED          = 0x000013d2,
    ERROR_CLUSTER_INCOMPATIBLE_VERSIONS = 0x000013d3,
}

enum int ERROR_CLUSTER_SYSTEM_CONFIG_CHANGED = 0x000013d5;

enum : int
{
    ERROR_CLUSTER_RESTYPE_NOT_SUPPORTED      = 0x000013d7,
    ERROR_CLUSTER_RESNAME_NOT_FOUND          = 0x000013d8,
    ERROR_CLUSTER_NO_RPC_PACKAGES_REGISTERED = 0x000013d9,
}

enum int ERROR_CLUSTER_DATABASE_SEQMISMATCH = 0x000013db;
enum int ERROR_CLUSTER_GUM_NOT_LOCKER = 0x000013dd;
enum int ERROR_DATABASE_BACKUP_CORRUPT = 0x000013df;
enum int ERROR_RESOURCE_PROPERTY_UNCHANGEABLE = 0x000013e1;
enum int ERROR_CLUSTER_MEMBERSHIP_INVALID_STATE = 0x00001702;

enum : int
{
    ERROR_CLUSTER_MEMBERSHIP_HALT          = 0x00001704,
    ERROR_CLUSTER_INSTANCE_ID_MISMATCH     = 0x00001705,
    ERROR_CLUSTER_NETWORK_NOT_FOUND_FOR_IP = 0x00001706,
}

enum int ERROR_CLUSTER_EVICT_WITHOUT_CLEANUP = 0x00001708;
enum int ERROR_NODE_CANNOT_BE_CLUSTERED = 0x0000170a;
enum int ERROR_CLUSTER_CANT_CREATE_DUP_CLUSTER_NAME = 0x0000170c;

enum : int
{
    ERROR_CLUSCFG_ROLLBACK_FAILED                   = 0x0000170e,
    ERROR_CLUSCFG_SYSTEM_DISK_DRIVE_LETTER_CONFLICT = 0x0000170f,
}

enum int ERROR_CLUSTER_MISMATCHED_COMPUTER_ACCT_NAME = 0x00001711;

enum : int
{
    ERROR_CLUSTER_POISONED           = 0x00001713,
    ERROR_CLUSTER_GROUP_MOVING       = 0x00001714,
    ERROR_CLUSTER_RESOURCE_TYPE_BUSY = 0x00001715,
}

enum int ERROR_INVALID_CLUSTER_IPV6_ADDRESS = 0x00001717;

enum : int
{
    ERROR_CLUSTER_PARAMETER_OUT_OF_BOUNDS   = 0x00001719,
    ERROR_CLUSTER_PARTIAL_SEND              = 0x0000171a,
    ERROR_CLUSTER_REGISTRY_INVALID_FUNCTION = 0x0000171b,
}

enum int ERROR_CLUSTER_INVALID_STRING_FORMAT = 0x0000171d;
enum int ERROR_CLUSTER_DATABASE_TRANSACTION_NOT_IN_PROGRESS = 0x0000171f;

enum : int
{
    ERROR_CLUSTER_PARTIAL_READ          = 0x00001721,
    ERROR_CLUSTER_PARTIAL_WRITE         = 0x00001722,
    ERROR_CLUSTER_CANT_DESERIALIZE_DATA = 0x00001723,
}

enum : int
{
    ERROR_CLUSTER_NO_QUORUM                   = 0x00001725,
    ERROR_CLUSTER_INVALID_IPV6_NETWORK        = 0x00001726,
    ERROR_CLUSTER_INVALID_IPV6_TUNNEL_NETWORK = 0x00001727,
}

enum int ERROR_DEPENDENCY_TREE_TOO_COMPLEX = 0x00001729;
enum int ERROR_CLUSTER_RHS_FAILED_INITIALIZATION = 0x0000172b;
enum int ERROR_CLUSTER_RESOURCES_MUST_BE_ONLINE_ON_THE_SAME_NODE = 0x0000172d;

enum : int
{
    ERROR_CLUSTER_TOO_MANY_NODES      = 0x0000172f,
    ERROR_CLUSTER_OBJECT_ALREADY_USED = 0x00001730,
}

enum int ERROR_FILE_SHARE_RESOURCE_CONFLICT = 0x00001732;

enum : int
{
    ERROR_CLUSTER_SINGLETON_RESOURCE       = 0x00001734,
    ERROR_CLUSTER_GROUP_SINGLETON_RESOURCE = 0x00001735,
}

enum int ERROR_CLUSTER_RESOURCE_CONFIGURATION_ERROR = 0x00001737;

enum : int
{
    ERROR_CLUSTER_NOT_SHARED_VOLUME           = 0x00001739,
    ERROR_CLUSTER_INVALID_SECURITY_DESCRIPTOR = 0x0000173a,
}

enum int ERROR_CLUSTER_USE_SHARED_VOLUMES_API = 0x0000173c;
enum int ERROR_NON_CSV_PATH = 0x0000173e;

enum : int
{
    ERROR_CLUSTER_WATCHDOG_TERMINATING                    = 0x00001740,
    ERROR_CLUSTER_RESOURCE_VETOED_MOVE_INCOMPATIBLE_NODES = 0x00001741,
}

enum int ERROR_CLUSTER_RESOURCE_VETOED_CALL = 0x00001743;

enum : int
{
    ERROR_CLUSTER_RESOURCE_VETOED_MOVE_NOT_ENOUGH_RESOURCES_ON_DESTINATION = 0x00001745,
    ERROR_CLUSTER_RESOURCE_VETOED_MOVE_NOT_ENOUGH_RESOURCES_ON_SOURCE      = 0x00001746,
}

enum int ERROR_CLUSTER_RESOURCE_LOCKED_STATUS = 0x00001748;
enum int ERROR_CLUSTER_NODE_DRAIN_IN_PROGRESS = 0x0000174a;
enum int ERROR_DISK_NOT_CSV_CAPABLE = 0x0000174c;

enum : int
{
    ERROR_CLUSTER_SHARED_VOLUME_REDIRECTED     = 0x0000174e,
    ERROR_CLUSTER_SHARED_VOLUME_NOT_REDIRECTED = 0x0000174f,
}

enum int ERROR_CLUSTER_RESOURCE_CONTAINS_UNSUPPORTED_DIFF_AREA_FOR_SHARED_VOLUMES = 0x00001751;

enum : int
{
    ERROR_CLUSTER_AFFINITY_CONFLICT                   = 0x00001753,
    ERROR_CLUSTER_RESOURCE_IS_REPLICA_VIRTUAL_MACHINE = 0x00001754,
}

enum : int
{
    ERROR_CLUSTER_UPGRADE_FIX_QUORUM_NOT_SUPPORTED = 0x00001756,
    ERROR_CLUSTER_UPGRADE_RESTART_REQUIRED         = 0x00001757,
    ERROR_CLUSTER_UPGRADE_IN_PROGRESS              = 0x00001758,
    ERROR_CLUSTER_UPGRADE_INCOMPLETE               = 0x00001759,
    ERROR_CLUSTER_NODE_IN_GRACE_PERIOD             = 0x0000175a,
    ERROR_CLUSTER_CSV_IO_PAUSE_TIMEOUT             = 0x0000175b,
}

enum : int
{
    ERROR_CLUSTER_RESOURCE_NOT_MONITORED                = 0x0000175d,
    ERROR_CLUSTER_RESOURCE_DOES_NOT_SUPPORT_UNMONITORED = 0x0000175e,
    ERROR_CLUSTER_RESOURCE_IS_REPLICATED                = 0x0000175f,
}

enum : int
{
    ERROR_CLUSTER_NODE_QUARANTINED                 = 0x00001761,
    ERROR_CLUSTER_DATABASE_UPDATE_CONDITION_FAILED = 0x00001762,
}

enum int ERROR_CLUSTER_TOKEN_DELEGATION_NOT_SUPPORTED = 0x00001764;
enum int ERROR_CLUSTER_CSV_SUPPORTED_ONLY_ON_COORDINATOR = 0x00001766;

enum : int
{
    ERROR_GROUPSET_NOT_FOUND    = 0x00001768,
    ERROR_GROUPSET_CANT_PROVIDE = 0x00001769,
}

enum : int
{
    ERROR_CLUSTER_FAULT_DOMAIN_INVALID_HIERARCHY     = 0x0000176b,
    ERROR_CLUSTER_FAULT_DOMAIN_FAILED_S2D_VALIDATION = 0x0000176c,
    ERROR_CLUSTER_FAULT_DOMAIN_S2D_CONNECTIVITY_LOSS = 0x0000176d,
}

enum int ERROR_CLUSTERSET_MANAGEMENT_CLUSTER_UNREACHABLE = 0x0000176f;
enum int ERROR_DECRYPTION_FAILED = 0x00001771;
enum int ERROR_NO_RECOVERY_POLICY = 0x00001773;
enum int ERROR_WRONG_EFS = 0x00001775;
enum int ERROR_FILE_NOT_ENCRYPTED = 0x00001777;
enum int ERROR_FILE_READ_ONLY = 0x00001779;
enum int ERROR_EFS_SERVER_NOT_TRUSTED = 0x0000177b;
enum int ERROR_EFS_ALG_BLOB_TOO_BIG = 0x0000177d;

enum : int
{
    ERROR_EFS_DISABLED            = 0x0000177f,
    ERROR_EFS_VERSION_NOT_SUPPORT = 0x00001780,
}

enum : int
{
    ERROR_CS_ENCRYPTION_UNSUPPORTED_SERVER      = 0x00001782,
    ERROR_CS_ENCRYPTION_EXISTING_ENCRYPTED_FILE = 0x00001783,
    ERROR_CS_ENCRYPTION_NEW_ENCRYPTED_FILE      = 0x00001784,
    ERROR_CS_ENCRYPTION_FILE_NOT_CSE            = 0x00001785,
}

enum int ERROR_WIP_ENCRYPTION_FAILED = 0x00001787;
enum int SCHED_E_SERVICE_NOT_LOCALSYSTEM = 0x00001838;

enum : int
{
    ERROR_LOG_SECTOR_INVALID        = 0x000019c8,
    ERROR_LOG_SECTOR_PARITY_INVALID = 0x000019c9,
    ERROR_LOG_SECTOR_REMAPPED       = 0x000019ca,
}

enum : int
{
    ERROR_LOG_INVALID_RANGE    = 0x000019cc,
    ERROR_LOG_BLOCKS_EXHAUSTED = 0x000019cd,
}

enum int ERROR_LOG_RESTART_INVALID = 0x000019cf;

enum : int
{
    ERROR_LOG_BLOCK_INVALID     = 0x000019d1,
    ERROR_LOG_READ_MODE_INVALID = 0x000019d2,
}

enum : int
{
    ERROR_LOG_METADATA_CORRUPT      = 0x000019d4,
    ERROR_LOG_METADATA_INVALID      = 0x000019d5,
    ERROR_LOG_METADATA_INCONSISTENT = 0x000019d6,
}

enum : int
{
    ERROR_LOG_CANT_DELETE              = 0x000019d8,
    ERROR_LOG_CONTAINER_LIMIT_EXCEEDED = 0x000019d9,
}

enum : int
{
    ERROR_LOG_POLICY_ALREADY_INSTALLED = 0x000019db,
    ERROR_LOG_POLICY_NOT_INSTALLED     = 0x000019dc,
    ERROR_LOG_POLICY_INVALID           = 0x000019dd,
    ERROR_LOG_POLICY_CONFLICT          = 0x000019de,
    ERROR_LOG_PINNED_ARCHIVE_TAIL      = 0x000019df,
}

enum int ERROR_LOG_RECORDS_RESERVED_INVALID = 0x000019e1;

enum : int
{
    ERROR_LOG_TAIL_INVALID     = 0x000019e3,
    ERROR_LOG_FULL             = 0x000019e4,
    ERROR_COULD_NOT_RESIZE_LOG = 0x000019e5,
}

enum : int
{
    ERROR_LOG_DEDICATED               = 0x000019e7,
    ERROR_LOG_ARCHIVE_NOT_IN_PROGRESS = 0x000019e8,
    ERROR_LOG_ARCHIVE_IN_PROGRESS     = 0x000019e9,
}

enum int ERROR_LOG_NOT_ENOUGH_CONTAINERS = 0x000019eb;
enum int ERROR_LOG_CLIENT_NOT_REGISTERED = 0x000019ed;

enum : int
{
    ERROR_LOG_CONTAINER_READ_FAILED   = 0x000019ef,
    ERROR_LOG_CONTAINER_WRITE_FAILED  = 0x000019f0,
    ERROR_LOG_CONTAINER_OPEN_FAILED   = 0x000019f1,
    ERROR_LOG_CONTAINER_STATE_INVALID = 0x000019f2,
}

enum : int
{
    ERROR_LOG_PINNED                = 0x000019f4,
    ERROR_LOG_METADATA_FLUSH_FAILED = 0x000019f5,
}

enum int ERROR_LOG_APPENDED_FLUSH_FAILED = 0x000019f7;
enum int ERROR_INVALID_TRANSACTION = 0x00001a2c;

enum : int
{
    ERROR_TRANSACTION_REQUEST_NOT_VALID = 0x00001a2e,
    ERROR_TRANSACTION_NOT_REQUESTED     = 0x00001a2f,
    ERROR_TRANSACTION_ALREADY_ABORTED   = 0x00001a30,
    ERROR_TRANSACTION_ALREADY_COMMITTED = 0x00001a31,
}

enum int ERROR_RESOURCEMANAGER_READ_ONLY = 0x00001a33;
enum int ERROR_TRANSACTION_SUPERIOR_EXISTS = 0x00001a35;
enum int ERROR_TRANSACTION_PROPAGATION_FAILED = 0x00001a37;
enum int ERROR_TRANSACTION_INVALID_MARSHALL_BUFFER = 0x00001a39;
enum int ERROR_TRANSACTION_NOT_FOUND = 0x00001a3b;
enum int ERROR_ENLISTMENT_NOT_FOUND = 0x00001a3d;

enum : int
{
    ERROR_TRANSACTIONMANAGER_NOT_ONLINE              = 0x00001a3f,
    ERROR_TRANSACTIONMANAGER_RECOVERY_NAME_COLLISION = 0x00001a40,
}

enum : int
{
    ERROR_TRANSACTION_OBJECT_EXPIRED        = 0x00001a42,
    ERROR_TRANSACTION_RESPONSE_NOT_ENLISTED = 0x00001a43,
    ERROR_TRANSACTION_RECORD_TOO_LONG       = 0x00001a44,
}

enum : int
{
    ERROR_TRANSACTION_INTEGRITY_VIOLATED       = 0x00001a46,
    ERROR_TRANSACTIONMANAGER_IDENTITY_MISMATCH = 0x00001a47,
}

enum : int
{
    ERROR_TRANSACTION_MUST_WRITETHROUGH = 0x00001a49,
    ERROR_TRANSACTION_NO_SUPERIOR       = 0x00001a4a,
}

enum int ERROR_TRANSACTIONAL_CONFLICT = 0x00001a90;
enum int ERROR_RM_METADATA_CORRUPT = 0x00001a92;
enum int ERROR_TRANSACTIONS_UNSUPPORTED_REMOTE = 0x00001a95;
enum int ERROR_OBJECT_NO_LONGER_EXISTS = 0x00001a97;
enum int ERROR_STREAM_MINIVERSION_NOT_VALID = 0x00001a99;
enum int ERROR_CANT_OPEN_MINIVERSION_WITH_MODIFY_INTENT = 0x00001a9b;
enum int ERROR_REMOTE_FILE_VERSION_MISMATCH = 0x00001a9e;
enum int ERROR_NO_TXF_METADATA = 0x00001aa0;
enum int ERROR_CANT_RECOVER_WITH_HANDLE_OPEN = 0x00001aa2;
enum int ERROR_ENLISTMENT_NOT_SUPERIOR = 0x00001aa4;
enum int ERROR_RM_ALREADY_STARTED = 0x00001aa6;
enum int ERROR_CANT_BREAK_TRANSACTIONAL_DEPENDENCY = 0x00001aa8;
enum int ERROR_TXF_DIR_NOT_EMPTY = 0x00001aaa;
enum int ERROR_TM_VOLATILE = 0x00001aac;
enum int ERROR_TXF_ATTRIBUTE_CORRUPT = 0x00001aae;
enum int ERROR_TRANSACTIONAL_OPEN_NOT_ALLOWED = 0x00001ab0;
enum int ERROR_TRANSACTED_MAPPING_UNSUPPORTED_REMOTE = 0x00001ab2;

enum : int
{
    ERROR_TRANSACTION_SCOPE_CALLBACKS_NOT_SET = 0x00001ab4,
    ERROR_TRANSACTION_REQUIRED_PROMOTION      = 0x00001ab5,
}

enum : int
{
    ERROR_TRANSACTIONS_NOT_FROZEN        = 0x00001ab7,
    ERROR_TRANSACTION_FREEZE_IN_PROGRESS = 0x00001ab8,
}

enum int ERROR_NO_SAVEPOINT_WITH_OPEN_FILES = 0x00001aba;
enum int ERROR_SPARSE_NOT_ALLOWED_IN_TRANSACTION = 0x00001abc;
enum int ERROR_FLOATED_SECTION = 0x00001abe;
enum int ERROR_CANNOT_ABORT_TRANSACTIONS = 0x00001ac0;
enum int ERROR_COMPRESSION_NOT_ALLOWED_IN_TRANSACTION = 0x00001ac2;
enum int ERROR_NO_LINK_TRACKING_IN_TRANSACTION = 0x00001ac4;
enum int ERROR_EXPIRED_HANDLE = 0x00001ac6;
enum int ERROR_CTX_WINSTATION_NAME_INVALID = 0x00001b59;

enum : int
{
    ERROR_CTX_PD_NOT_FOUND               = 0x00001b5b,
    ERROR_CTX_WD_NOT_FOUND               = 0x00001b5c,
    ERROR_CTX_CANNOT_MAKE_EVENTLOG_ENTRY = 0x00001b5d,
}

enum : int
{
    ERROR_CTX_CLOSE_PENDING       = 0x00001b5f,
    ERROR_CTX_NO_OUTBUF           = 0x00001b60,
    ERROR_CTX_MODEM_INF_NOT_FOUND = 0x00001b61,
}

enum : int
{
    ERROR_CTX_MODEM_RESPONSE_ERROR       = 0x00001b63,
    ERROR_CTX_MODEM_RESPONSE_TIMEOUT     = 0x00001b64,
    ERROR_CTX_MODEM_RESPONSE_NO_CARRIER  = 0x00001b65,
    ERROR_CTX_MODEM_RESPONSE_NO_DIALTONE = 0x00001b66,
    ERROR_CTX_MODEM_RESPONSE_BUSY        = 0x00001b67,
    ERROR_CTX_MODEM_RESPONSE_VOICE       = 0x00001b68,
}

enum : int
{
    ERROR_CTX_WINSTATION_NOT_FOUND      = 0x00001b6e,
    ERROR_CTX_WINSTATION_ALREADY_EXISTS = 0x00001b6f,
    ERROR_CTX_WINSTATION_BUSY           = 0x00001b70,
}

enum int ERROR_CTX_GRAPHICS_INVALID = 0x00001b7b;

enum : int
{
    ERROR_CTX_NOT_CONSOLE          = 0x00001b7e,
    ERROR_CTX_CLIENT_QUERY_TIMEOUT = 0x00001b80,
}

enum int ERROR_CTX_CONSOLE_CONNECT = 0x00001b82;
enum int ERROR_CTX_WINSTATION_ACCESS_DENIED = 0x00001b85;

enum : int
{
    ERROR_CTX_SHADOW_INVALID  = 0x00001b8a,
    ERROR_CTX_SHADOW_DISABLED = 0x00001b8b,
}

enum int ERROR_CTX_CLIENT_LICENSE_NOT_SET = 0x00001b8d;

enum : int
{
    ERROR_CTX_LICENSE_CLIENT_INVALID = 0x00001b8f,
    ERROR_CTX_LICENSE_EXPIRED        = 0x00001b90,
}

enum int ERROR_CTX_SHADOW_ENDED_BY_MODE_CHANGE = 0x00001b92;
enum int ERROR_CTX_WINSTATIONS_DISABLED = 0x00001b94;

enum : int
{
    ERROR_CTX_SESSION_IN_USE  = 0x00001b96,
    ERROR_CTX_NO_FORCE_LOGOFF = 0x00001b97,
}

enum int ERROR_RDP_PROTOCOL_ERROR = 0x00001b99;

enum : int
{
    ERROR_CTX_CDM_DISCONNECT       = 0x00001b9b,
    ERROR_CTX_SECURITY_LAYER_ERROR = 0x00001b9c,
}

enum int ERROR_TS_VIDEO_SUBSYSTEM_ERROR = 0x00001b9e;

enum : int
{
    FRS_ERR_STARTING_SERVICE = 0x00001f42,
    FRS_ERR_STOPPING_SERVICE = 0x00001f43,
}

enum : int
{
    FRS_ERR_INTERNAL     = 0x00001f45,
    FRS_ERR_SERVICE_COMM = 0x00001f46,
}

enum int FRS_ERR_AUTHENTICATION = 0x00001f48;
enum int FRS_ERR_PARENT_AUTHENTICATION = 0x00001f4a;
enum int FRS_ERR_PARENT_TO_CHILD_COMM = 0x00001f4c;

enum : int
{
    FRS_ERR_SYSVOL_POPULATE_TIMEOUT = 0x00001f4e,
    FRS_ERR_SYSVOL_IS_BUSY          = 0x00001f4f,
    FRS_ERR_SYSVOL_DEMOTE           = 0x00001f50,
}

enum : int
{
    ERROR_DS_NOT_INSTALLED                = 0x00002008,
    ERROR_DS_MEMBERSHIP_EVALUATED_LOCALLY = 0x00002009,
}

enum int ERROR_DS_INVALID_ATTRIBUTE_SYNTAX = 0x0000200b;
enum int ERROR_DS_ATTRIBUTE_OR_VALUE_EXISTS = 0x0000200d;

enum : int
{
    ERROR_DS_UNAVAILABLE          = 0x0000200f,
    ERROR_DS_NO_RIDS_ALLOCATED    = 0x00002010,
    ERROR_DS_NO_MORE_RIDS         = 0x00002011,
    ERROR_DS_INCORRECT_ROLE_OWNER = 0x00002012,
}

enum int ERROR_DS_OBJ_CLASS_VIOLATION = 0x00002014;

enum : int
{
    ERROR_DS_CANT_ON_RDN        = 0x00002016,
    ERROR_DS_CANT_MOD_OBJ_CLASS = 0x00002017,
}

enum int ERROR_DS_GC_NOT_AVAILABLE = 0x00002019;

enum : int
{
    ERROR_POLICY_OBJECT_NOT_FOUND = 0x0000201b,
    ERROR_POLICY_ONLY_IN_DS       = 0x0000201c,
}

enum int ERROR_NO_PROMOTION_ACTIVE = 0x0000201e;
enum int ERROR_DS_PROTOCOL_ERROR = 0x00002021;
enum int ERROR_DS_SIZELIMIT_EXCEEDED = 0x00002023;

enum : int
{
    ERROR_DS_COMPARE_FALSE             = 0x00002025,
    ERROR_DS_COMPARE_TRUE              = 0x00002026,
    ERROR_DS_AUTH_METHOD_NOT_SUPPORTED = 0x00002027,
}

enum int ERROR_DS_INAPPROPRIATE_AUTH = 0x00002029;

enum : int
{
    ERROR_DS_REFERRAL                   = 0x0000202b,
    ERROR_DS_UNAVAILABLE_CRIT_EXTENSION = 0x0000202c,
}

enum int ERROR_DS_INAPPROPRIATE_MATCHING = 0x0000202e;
enum int ERROR_DS_NO_SUCH_OBJECT = 0x00002030;
enum int ERROR_DS_INVALID_DN_SYNTAX = 0x00002032;
enum int ERROR_DS_ALIAS_DEREF_PROBLEM = 0x00002034;

enum : int
{
    ERROR_DS_LOOP_DETECT      = 0x00002036,
    ERROR_DS_NAMING_VIOLATION = 0x00002037,
}

enum int ERROR_DS_AFFECTS_MULTIPLE_DSAS = 0x00002039;

enum : int
{
    ERROR_DS_LOCAL_ERROR    = 0x0000203b,
    ERROR_DS_ENCODING_ERROR = 0x0000203c,
}

enum int ERROR_DS_FILTER_UNKNOWN = 0x0000203e;

enum : int
{
    ERROR_DS_NOT_SUPPORTED       = 0x00002040,
    ERROR_DS_NO_RESULTS_RETURNED = 0x00002041,
}

enum : int
{
    ERROR_DS_CLIENT_LOOP             = 0x00002043,
    ERROR_DS_REFERRAL_LIMIT_EXCEEDED = 0x00002044,
}

enum int ERROR_DS_OFFSET_RANGE_ERROR = 0x00002046;
enum int ERROR_DS_ROOT_MUST_BE_NC = 0x0000206d;
enum int ERROR_DS_ATT_NOT_DEF_IN_SCHEMA = 0x0000206f;
enum int ERROR_DS_OBJ_STRING_NAME_EXISTS = 0x00002071;
enum int ERROR_DS_RDN_DOESNT_MATCH_SCHEMA = 0x00002073;
enum int ERROR_DS_USER_BUFFER_TO_SMALL = 0x00002075;
enum int ERROR_DS_ILLEGAL_MOD_OPERATION = 0x00002077;
enum int ERROR_DS_BAD_INSTANCE_TYPE = 0x00002079;
enum int ERROR_DS_OBJECT_CLASS_REQUIRED = 0x0000207b;

enum : int
{
    ERROR_DS_ATT_NOT_DEF_FOR_CLASS = 0x0000207d,
    ERROR_DS_ATT_ALREADY_EXISTS    = 0x0000207e,
}

enum int ERROR_DS_SINGLE_VALUE_CONSTRAINT = 0x00002081;
enum int ERROR_DS_ATT_VAL_ALREADY_EXISTS = 0x00002083;
enum int ERROR_DS_CANT_REM_MISSING_ATT_VAL = 0x00002085;

enum : int
{
    ERROR_DS_NO_CHAINING      = 0x00002087,
    ERROR_DS_NO_CHAINED_EVAL  = 0x00002088,
    ERROR_DS_NO_PARENT_OBJECT = 0x00002089,
}

enum int ERROR_DS_CANT_MIX_MASTER_AND_REPS = 0x0000208b;

enum : int
{
    ERROR_DS_OBJ_NOT_FOUND       = 0x0000208d,
    ERROR_DS_ALIASED_OBJ_MISSING = 0x0000208e,
}

enum int ERROR_DS_ALIAS_POINTS_TO_ALIAS = 0x00002090;

enum : int
{
    ERROR_DS_OUT_OF_SCOPE         = 0x00002092,
    ERROR_DS_OBJECT_BEING_REMOVED = 0x00002093,
}

enum : int
{
    ERROR_DS_GENERIC_ERROR          = 0x00002095,
    ERROR_DS_DSA_MUST_BE_INT_MASTER = 0x00002096,
}

enum int ERROR_DS_INSUFF_ACCESS_RIGHTS = 0x00002098;
enum int ERROR_DS_ATTRIBUTE_OWNED_BY_SAM = 0x0000209a;

enum : int
{
    ERROR_DS_NAME_TOO_LONG       = 0x0000209c,
    ERROR_DS_NAME_VALUE_TOO_LONG = 0x0000209d,
    ERROR_DS_NAME_UNPARSEABLE    = 0x0000209e,
    ERROR_DS_NAME_TYPE_UNKNOWN   = 0x0000209f,
}

enum : int
{
    ERROR_DS_SEC_DESC_TOO_SHORT = 0x000020a1,
    ERROR_DS_SEC_DESC_INVALID   = 0x000020a2,
}

enum int ERROR_DS_SUBREF_MUST_HAVE_PARENT = 0x000020a4;
enum int ERROR_DS_CANT_ADD_SYSTEM_ONLY = 0x000020a6;

enum : int
{
    ERROR_DS_INVALID_DMD     = 0x000020a8,
    ERROR_DS_OBJ_GUID_EXISTS = 0x000020a9,
}

enum int ERROR_DS_NO_CROSSREF_FOR_NC = 0x000020ab;
enum int ERROR_DS_UNKNOWN_OPERATION = 0x000020ad;
enum int ERROR_DS_COULDNT_CONTACT_FSMO = 0x000020af;
enum int ERROR_DS_CANT_MOD_SYSTEM_ONLY = 0x000020b1;

enum : int
{
    ERROR_DS_OBJ_CLASS_NOT_DEFINED  = 0x000020b3,
    ERROR_DS_OBJ_CLASS_NOT_SUBCLASS = 0x000020b4,
}

enum int ERROR_DS_CROSS_REF_EXISTS = 0x000020b6;
enum int ERROR_DS_SUBTREE_NOTIFY_NOT_NC_HEAD = 0x000020b8;

enum : int
{
    ERROR_DS_DUP_RDN               = 0x000020ba,
    ERROR_DS_DUP_OID               = 0x000020bb,
    ERROR_DS_DUP_MAPI_ID           = 0x000020bc,
    ERROR_DS_DUP_SCHEMA_ID_GUID    = 0x000020bd,
    ERROR_DS_DUP_LDAP_DISPLAY_NAME = 0x000020be,
}

enum int ERROR_DS_SYNTAX_MISMATCH = 0x000020c0;
enum int ERROR_DS_EXISTS_IN_MAY_HAVE = 0x000020c2;
enum int ERROR_DS_NONEXISTENT_MUST_HAVE = 0x000020c4;
enum int ERROR_DS_NONEXISTENT_POSS_SUP = 0x000020c6;
enum int ERROR_DS_BAD_RDN_ATT_ID_SYNTAX = 0x000020c8;

enum : int
{
    ERROR_DS_EXISTS_IN_SUB_CLS  = 0x000020ca,
    ERROR_DS_EXISTS_IN_POSS_SUP = 0x000020cb,
}

enum int ERROR_DS_TREE_DELETE_NOT_FINISHED = 0x000020cd;
enum int ERROR_DS_ATT_SCHEMA_REQ_ID = 0x000020cf;

enum : int
{
    ERROR_DS_CANT_CACHE_ATT          = 0x000020d1,
    ERROR_DS_CANT_CACHE_CLASS        = 0x000020d2,
    ERROR_DS_CANT_REMOVE_ATT_CACHE   = 0x000020d3,
    ERROR_DS_CANT_REMOVE_CLASS_CACHE = 0x000020d4,
    ERROR_DS_CANT_RETRIEVE_DN        = 0x000020d5,
}

enum int ERROR_DS_CANT_RETRIEVE_INSTANCE = 0x000020d7;
enum int ERROR_DS_DATABASE_ERROR = 0x000020d9;
enum int ERROR_DS_MISSING_EXPECTED_ATT = 0x000020db;
enum int ERROR_DS_SECURITY_CHECKING_ERROR = 0x000020dd;
enum int ERROR_DS_SCHEMA_ALLOC_FAILED = 0x000020df;
enum int ERROR_DS_GCVERIFY_ERROR = 0x000020e1;

enum : int
{
    ERROR_DS_CANT_FIND_DSA_OBJ     = 0x000020e3,
    ERROR_DS_CANT_FIND_EXPECTED_NC = 0x000020e4,
    ERROR_DS_CANT_FIND_NC_IN_CACHE = 0x000020e5,
    ERROR_DS_CANT_RETRIEVE_CHILD   = 0x000020e6,
}

enum int ERROR_DS_CANT_REPLACE_HIDDEN_REC = 0x000020e8;
enum int ERROR_DS_BUILD_HIERARCHY_TABLE_FAILED = 0x000020ea;
enum int ERROR_DS_COUNTING_AB_INDICES_FAILED = 0x000020ec;
enum int ERROR_DS_INTERNAL_FAILURE = 0x000020ee;
enum int ERROR_DS_ROOT_REQUIRES_CLASS_TOP = 0x000020f0;
enum int ERROR_DS_MISSING_FSMO_SETTINGS = 0x000020f2;

enum : int
{
    ERROR_DS_DRA_GENERIC                  = 0x000020f4,
    ERROR_DS_DRA_INVALID_PARAMETER        = 0x000020f5,
    ERROR_DS_DRA_BUSY                     = 0x000020f6,
    ERROR_DS_DRA_BAD_DN                   = 0x000020f7,
    ERROR_DS_DRA_BAD_NC                   = 0x000020f8,
    ERROR_DS_DRA_DN_EXISTS                = 0x000020f9,
    ERROR_DS_DRA_INTERNAL_ERROR           = 0x000020fa,
    ERROR_DS_DRA_INCONSISTENT_DIT         = 0x000020fb,
    ERROR_DS_DRA_CONNECTION_FAILED        = 0x000020fc,
    ERROR_DS_DRA_BAD_INSTANCE_TYPE        = 0x000020fd,
    ERROR_DS_DRA_OUT_OF_MEM               = 0x000020fe,
    ERROR_DS_DRA_MAIL_PROBLEM             = 0x000020ff,
    ERROR_DS_DRA_REF_ALREADY_EXISTS       = 0x00002100,
    ERROR_DS_DRA_REF_NOT_FOUND            = 0x00002101,
    ERROR_DS_DRA_OBJ_IS_REP_SOURCE        = 0x00002102,
    ERROR_DS_DRA_DB_ERROR                 = 0x00002103,
    ERROR_DS_DRA_NO_REPLICA               = 0x00002104,
    ERROR_DS_DRA_ACCESS_DENIED            = 0x00002105,
    ERROR_DS_DRA_NOT_SUPPORTED            = 0x00002106,
    ERROR_DS_DRA_RPC_CANCELLED            = 0x00002107,
    ERROR_DS_DRA_SOURCE_DISABLED          = 0x00002108,
    ERROR_DS_DRA_SINK_DISABLED            = 0x00002109,
    ERROR_DS_DRA_NAME_COLLISION           = 0x0000210a,
    ERROR_DS_DRA_SOURCE_REINSTALLED       = 0x0000210b,
    ERROR_DS_DRA_MISSING_PARENT           = 0x0000210c,
    ERROR_DS_DRA_PREEMPTED                = 0x0000210d,
    ERROR_DS_DRA_ABANDON_SYNC             = 0x0000210e,
    ERROR_DS_DRA_SHUTDOWN                 = 0x0000210f,
    ERROR_DS_DRA_INCOMPATIBLE_PARTIAL_SET = 0x00002110,
}

enum int ERROR_DS_DRA_EXTN_CONNECTION_FAILED = 0x00002112;

enum : int
{
    ERROR_DS_DUP_LINK_ID                       = 0x00002114,
    ERROR_DS_NAME_ERROR_RESOLVING              = 0x00002115,
    ERROR_DS_NAME_ERROR_NOT_FOUND              = 0x00002116,
    ERROR_DS_NAME_ERROR_NOT_UNIQUE             = 0x00002117,
    ERROR_DS_NAME_ERROR_NO_MAPPING             = 0x00002118,
    ERROR_DS_NAME_ERROR_DOMAIN_ONLY            = 0x00002119,
    ERROR_DS_NAME_ERROR_NO_SYNTACTICAL_MAPPING = 0x0000211a,
}

enum int ERROR_DS_WRONG_OM_OBJ_CLASS = 0x0000211c;

enum : int
{
    ERROR_DS_DS_REQUIRED               = 0x0000211e,
    ERROR_DS_INVALID_LDAP_DISPLAY_NAME = 0x0000211f,
}

enum int ERROR_DS_CANT_RETRIEVE_ATTS = 0x00002121;
enum int ERROR_DS_EPOCH_MISMATCH = 0x00002123;
enum int ERROR_DS_SRC_AND_DST_NC_IDENTICAL = 0x00002125;
enum int ERROR_DS_NOT_AUTHORITIVE_FOR_DST_NC = 0x00002127;
enum int ERROR_DS_CANT_MOVE_DELETED_OBJECT = 0x00002129;
enum int ERROR_DS_CROSS_DOMAIN_CLEANUP_REQD = 0x0000212b;
enum int ERROR_DS_CANT_WITH_ACCT_GROUP_MEMBERSHPS = 0x0000212d;
enum int ERROR_DS_CR_IMPOSSIBLE_TO_VALIDATE = 0x0000212f;
enum int ERROR_DS_MISSING_INFRASTRUCTURE_CONTAINER = 0x00002131;
enum int ERROR_DS_CANT_MOVE_RESOURCE_GROUP = 0x00002133;
enum int ERROR_DS_NO_TREE_DELETE_ABOVE_NC = 0x00002135;
enum int ERROR_DS_COULDNT_IDENTIFY_OBJECTS_FOR_TREE_DELETE = 0x00002137;
enum int ERROR_DS_SENSITIVE_GROUP_VIOLATION = 0x00002139;
enum int ERROR_DS_ILLEGAL_BASE_SCHEMA_MOD = 0x0000213b;
enum int ERROR_DS_SCHEMA_UPDATE_DISALLOWED = 0x0000213d;

enum : int
{
    ERROR_DS_INSTALL_NO_SRC_SCH_VERSION        = 0x0000213f,
    ERROR_DS_INSTALL_NO_SCH_VERSION_IN_INIFILE = 0x00002140,
}

enum int ERROR_DS_NO_NEST_GLOBALGROUP_IN_MIXEDDOMAIN = 0x00002142;

enum : int
{
    ERROR_DS_GLOBAL_CANT_HAVE_LOCAL_MEMBER     = 0x00002144,
    ERROR_DS_GLOBAL_CANT_HAVE_UNIVERSAL_MEMBER = 0x00002145,
}

enum int ERROR_DS_GLOBAL_CANT_HAVE_CROSSDOMAIN_MEMBER = 0x00002147;
enum int ERROR_DS_HAVE_PRIMARY_MEMBERS = 0x00002149;
enum int ERROR_DS_NAMING_MASTER_GC = 0x0000214b;
enum int ERROR_DS_COULDNT_UPDATE_SPNS = 0x0000214d;
enum int ERROR_DS_KEY_NOT_UNIQUE = 0x0000214f;

enum : int
{
    ERROR_DS_SAM_NEED_BOOTKEY_PASSWORD = 0x00002151,
    ERROR_DS_SAM_NEED_BOOTKEY_FLOPPY   = 0x00002152,
}

enum : int
{
    ERROR_DS_INIT_FAILURE                 = 0x00002154,
    ERROR_DS_NO_PKT_PRIVACY_ON_CONNECTION = 0x00002155,
}

enum : int
{
    ERROR_DS_DESTINATION_DOMAIN_NOT_IN_FOREST = 0x00002157,
    ERROR_DS_DESTINATION_AUDITING_NOT_ENABLED = 0x00002158,
}

enum int ERROR_DS_SRC_OBJ_NOT_GROUP_OR_USER = 0x0000215a;
enum int ERROR_DS_SRC_AND_DST_OBJECT_CLASS_MISMATCH = 0x0000215c;

enum : int
{
    ERROR_DS_DRA_SCHEMA_INFO_SHIP        = 0x0000215e,
    ERROR_DS_DRA_SCHEMA_CONFLICT         = 0x0000215f,
    ERROR_DS_DRA_EARLIER_SCHEMA_CONFLICT = 0x00002160,
}

enum int ERROR_DS_NC_STILL_HAS_DSAS = 0x00002162;
enum int ERROR_DS_LOCAL_MEMBER_OF_LOCAL_ONLY = 0x00002164;
enum int ERROR_DS_CANT_ADD_TO_GC = 0x00002166;
enum int ERROR_DS_SOURCE_AUDITING_NOT_ENABLED = 0x00002168;
enum int ERROR_DS_INVALID_NAME_FOR_SPN = 0x0000216a;
enum int ERROR_DS_UNICODEPWD_NOT_IN_QUOTES = 0x0000216c;
enum int ERROR_DS_MUST_BE_RUN_ON_DST_DC = 0x0000216e;
enum int ERROR_DS_CANT_TREE_DELETE_CRITICAL_OBJ = 0x00002170;
enum int ERROR_DS_SAM_INIT_FAILURE_CONSOLE = 0x00002172;
enum int ERROR_DS_DOMAIN_VERSION_TOO_HIGH = 0x00002174;
enum int ERROR_DS_DOMAIN_VERSION_TOO_LOW = 0x00002176;
enum int ERROR_DS_LOW_DSA_VERSION = 0x00002178;
enum int ERROR_DS_NOT_SUPPORTED_SORT_ORDER = 0x0000217a;
enum int ERROR_DS_MACHINE_ACCOUNT_CREATED_PRENT4 = 0x0000217c;
enum int ERROR_DS_INCOMPATIBLE_CONTROLS_USED = 0x0000217e;
enum int ERROR_DS_RESERVED_LINK_ID = 0x00002180;
enum int ERROR_DS_AG_CANT_HAVE_UNIVERSAL_MEMBER = 0x00002182;
enum int ERROR_DS_NO_OBJECT_MOVE_IN_SCHEMA_NC = 0x00002184;
enum int ERROR_DS_MODIFYDN_WRONG_GRANDPARENT = 0x00002186;
enum int ERROR_NOT_SUPPORTED_ON_STANDARD_SERVER = 0x00002188;
enum int ERROR_DS_CR_IMPOSSIBLE_TO_VALIDATE_V2 = 0x0000218a;

enum : int
{
    ERROR_DS_NOT_CLOSEST                        = 0x0000218c,
    ERROR_DS_CANT_DERIVE_SPN_WITHOUT_SERVER_REF = 0x0000218d,
}

enum : int
{
    ERROR_DS_NTDSCRIPT_SYNTAX_ERROR  = 0x0000218f,
    ERROR_DS_NTDSCRIPT_PROCESS_ERROR = 0x00002190,
}

enum int ERROR_DS_DRS_EXTENSIONS_CHANGED = 0x00002192;

enum : int
{
    ERROR_DS_NO_MSDS_INTID  = 0x00002194,
    ERROR_DS_DUP_MSDS_INTID = 0x00002195,
}

enum int ERROR_DS_AUTHORIZATION_FAILED = 0x00002197;
enum int ERROR_DS_REMOTE_CROSSREF_OP_FAILED = 0x00002199;
enum int ERROR_DS_CANT_DERIVE_SPN_FOR_DELETED_DOMAIN = 0x0000219b;
enum int ERROR_DS_DUPLICATE_ID_FOUND = 0x0000219d;
enum int ERROR_DS_GROUP_CONVERSION_ERROR = 0x0000219f;
enum int ERROR_DS_CANT_MOVE_APP_QUERY_GROUP = 0x000021a1;
enum int ERROR_DS_WKO_CONTAINER_CANNOT_BE_SPECIAL = 0x000021a3;
enum int ERROR_DS_EXISTING_AD_CHILD_NC = 0x000021a5;
enum int ERROR_DS_DISALLOWED_IN_SYSTEM_CONTAINER = 0x000021a7;
enum int ERROR_DS_DRA_OUT_SCHEDULE_WINDOW = 0x000021a9;
enum int ERROR_NO_SITE_SETTINGS_OBJECT = 0x000021ab;
enum int ERROR_NO_WRITABLE_DC_FOUND = 0x000021ad;

enum : int
{
    ERROR_DS_NO_NTDSA_OBJECT = 0x000021af,
    ERROR_DS_NON_ASQ_SEARCH  = 0x000021b0,
}

enum : int
{
    ERROR_DS_INVALID_SEARCH_FLAG_SUBTREE = 0x000021b2,
    ERROR_DS_INVALID_SEARCH_FLAG_TUPLE   = 0x000021b3,
}

enum : int
{
    ERROR_DS_DRA_CORRUPT_UTD_VECTOR = 0x000021b5,
    ERROR_DS_DRA_SECRETS_DENIED     = 0x000021b6,
}

enum int ERROR_DS_MAPI_ID_NOT_AVAILABLE = 0x000021b8;
enum int ERROR_DS_DOMAIN_NAME_EXISTS_IN_FOREST = 0x000021ba;
enum int ERROR_INVALID_USER_PRINCIPAL_NAME = 0x000021bc;

enum : int
{
    ERROR_DS_OID_NOT_FOUND       = 0x000021be,
    ERROR_DS_DRA_RECYCLED_TARGET = 0x000021bf,
}

enum : int
{
    ERROR_DS_HIGH_ADLDS_FFL   = 0x000021c1,
    ERROR_DS_HIGH_DSA_VERSION = 0x000021c2,
}

enum int ERROR_DOMAIN_SID_SAME_AS_LOCAL_WORKSTATION = 0x000021c4;
enum int ERROR_INCORRECT_ACCOUNT_TYPE = 0x000021c6;
enum int ERROR_DS_UPN_VALUE_NOT_UNIQUE_IN_FOREST = 0x000021c8;
enum int ERROR_DS_VALUE_KEY_NOT_UNIQUE = 0x000021ca;

enum : int
{
    DNS_ERROR_MASK                  = 0x00002328,
    DNS_ERROR_RCODE_FORMAT_ERROR    = 0x00002329,
    DNS_ERROR_RCODE_SERVER_FAILURE  = 0x0000232a,
    DNS_ERROR_RCODE_NAME_ERROR      = 0x0000232b,
    DNS_ERROR_RCODE_NOT_IMPLEMENTED = 0x0000232c,
    DNS_ERROR_RCODE_REFUSED         = 0x0000232d,
    DNS_ERROR_RCODE_YXDOMAIN        = 0x0000232e,
    DNS_ERROR_RCODE_YXRRSET         = 0x0000232f,
    DNS_ERROR_RCODE_NXRRSET         = 0x00002330,
    DNS_ERROR_RCODE_NOTAUTH         = 0x00002331,
    DNS_ERROR_RCODE_NOTZONE         = 0x00002332,
    DNS_ERROR_RCODE_BADSIG          = 0x00002338,
    DNS_ERROR_RCODE_BADKEY          = 0x00002339,
    DNS_ERROR_RCODE_BADTIME         = 0x0000233a,
    DNS_ERROR_DNSSEC_BASE           = 0x0000238c,
    DNS_ERROR_KEYMASTER_REQUIRED    = 0x0000238d,
}

enum int DNS_ERROR_NSEC3_INCOMPATIBLE_WITH_RSA_SHA1 = 0x0000238f;
enum int DNS_ERROR_UNSUPPORTED_ALGORITHM = 0x00002391;
enum int DNS_ERROR_SIGNING_KEY_NOT_ACCESSIBLE = 0x00002393;

enum : int
{
    DNS_ERROR_UNEXPECTED_DATA_PROTECTION_ERROR = 0x00002395,
    DNS_ERROR_UNEXPECTED_CNG_ERROR             = 0x00002396,
}

enum int DNS_ERROR_KSP_NOT_ACCESSIBLE = 0x00002398;

enum : int
{
    DNS_ERROR_INVALID_ROLLOVER_PERIOD         = 0x0000239a,
    DNS_ERROR_INVALID_INITIAL_ROLLOVER_OFFSET = 0x0000239b,
}

enum int DNS_ERROR_STANDBY_KEY_NOT_PRESENT = 0x0000239d;
enum int DNS_ERROR_NOT_ALLOWED_ON_ACTIVE_SKD = 0x0000239f;
enum int DNS_ERROR_NOT_ALLOWED_ON_UNSIGNED_ZONE = 0x000023a1;

enum : int
{
    DNS_ERROR_INVALID_SIGNATURE_VALIDITY_PERIOD = 0x000023a3,
    DNS_ERROR_INVALID_NSEC3_ITERATION_COUNT     = 0x000023a4,
}

enum : int
{
    DNS_ERROR_INVALID_XML            = 0x000023a6,
    DNS_ERROR_NO_VALID_TRUST_ANCHORS = 0x000023a7,
}

enum : int
{
    DNS_ERROR_NSEC3_NAME_COLLISION                  = 0x000023a9,
    DNS_ERROR_NSEC_INCOMPATIBLE_WITH_NSEC3_RSA_SHA1 = 0x000023aa,
}

enum int DNS_INFO_NO_RECORDS = 0x0000251d;

enum : int
{
    DNS_ERROR_NO_PACKET       = 0x0000251f,
    DNS_ERROR_RCODE           = 0x00002520,
    DNS_ERROR_UNSECURE_PACKET = 0x00002521,
}

enum int DNS_ERROR_GENERAL_API_BASE = 0x0000254e;

enum : int
{
    DNS_ERROR_INVALID_IP_ADDRESS = 0x00002550,
    DNS_ERROR_INVALID_PROPERTY   = 0x00002551,
}

enum : int
{
    DNS_ERROR_NOT_UNIQUE   = 0x00002553,
    DNS_ERROR_NON_RFC_NAME = 0x00002554,
}

enum : int
{
    DNS_STATUS_DOTTED_NAME      = 0x00002556,
    DNS_STATUS_SINGLE_PART_NAME = 0x00002557,
}

enum : int
{
    DNS_ERROR_NUMERIC_NAME                 = 0x00002559,
    DNS_ERROR_NOT_ALLOWED_ON_ROOT_SERVER   = 0x0000255a,
    DNS_ERROR_NOT_ALLOWED_UNDER_DELEGATION = 0x0000255b,
}

enum int DNS_ERROR_INCONSISTENT_ROOT_HINTS = 0x0000255d;
enum int DNS_ERROR_DWORD_VALUE_TOO_LARGE = 0x0000255f;

enum : int
{
    DNS_ERROR_NOT_ALLOWED_ON_RODC     = 0x00002561,
    DNS_ERROR_NOT_ALLOWED_UNDER_DNAME = 0x00002562,
}

enum int DNS_ERROR_INVALID_POLICY_TABLE = 0x00002564;

enum : int
{
    DNS_ERROR_ZONE_BASE           = 0x00002580,
    DNS_ERROR_ZONE_DOES_NOT_EXIST = 0x00002581,
}

enum int DNS_ERROR_INVALID_ZONE_OPERATION = 0x00002583;

enum : int
{
    DNS_ERROR_ZONE_HAS_NO_SOA_RECORD = 0x00002585,
    DNS_ERROR_ZONE_HAS_NO_NS_RECORDS = 0x00002586,
    DNS_ERROR_ZONE_LOCKED            = 0x00002587,
    DNS_ERROR_ZONE_CREATION_FAILED   = 0x00002588,
    DNS_ERROR_ZONE_ALREADY_EXISTS    = 0x00002589,
}

enum int DNS_ERROR_INVALID_ZONE_TYPE = 0x0000258b;
enum int DNS_ERROR_ZONE_NOT_SECONDARY = 0x0000258d;
enum int DNS_ERROR_WINS_INIT_FAILED = 0x0000258f;
enum int DNS_ERROR_NBSTAT_INIT_FAILED = 0x00002591;
enum int DNS_ERROR_FORWARDER_ALREADY_EXISTS = 0x00002593;

enum : int
{
    DNS_ERROR_ZONE_IS_SHUTDOWN        = 0x00002595,
    DNS_ERROR_ZONE_LOCKED_FOR_SIGNING = 0x00002596,
}

enum int DNS_ERROR_PRIMARY_REQUIRES_DATAFILE = 0x000025b3;
enum int DNS_ERROR_DATAFILE_OPEN_FAILURE = 0x000025b5;

enum : int
{
    DNS_ERROR_DATAFILE_PARSING      = 0x000025b7,
    DNS_ERROR_DATABASE_BASE         = 0x000025e4,
    DNS_ERROR_RECORD_DOES_NOT_EXIST = 0x000025e5,
    DNS_ERROR_RECORD_FORMAT         = 0x000025e6,
    DNS_ERROR_NODE_CREATION_FAILED  = 0x000025e7,
}

enum int DNS_ERROR_RECORD_TIMED_OUT = 0x000025e9;

enum : int
{
    DNS_ERROR_CNAME_LOOP      = 0x000025eb,
    DNS_ERROR_NODE_IS_CNAME   = 0x000025ec,
    DNS_ERROR_CNAME_COLLISION = 0x000025ed,
}

enum int DNS_ERROR_RECORD_ALREADY_EXISTS = 0x000025ef;
enum int DNS_ERROR_NO_CREATE_CACHE_DATA = 0x000025f1;

enum : int
{
    DNS_WARNING_PTR_CREATE_FAILED = 0x000025f3,
    DNS_WARNING_DOMAIN_UNDELETED  = 0x000025f4,
}

enum int DNS_ERROR_DS_ZONE_ALREADY_EXISTS = 0x000025f6;

enum : int
{
    DNS_ERROR_NODE_IS_DNAME   = 0x000025f8,
    DNS_ERROR_DNAME_COLLISION = 0x000025f9,
}

enum int DNS_ERROR_OPERATION_BASE = 0x00002616;
enum int DNS_ERROR_AXFR = 0x00002618;
enum int DNS_ERROR_SECURE_BASE = 0x00002648;

enum : int
{
    DNS_ERROR_SETUP_BASE                     = 0x0000267a,
    DNS_ERROR_NO_TCPIP                       = 0x0000267b,
    DNS_ERROR_NO_DNS_SERVERS                 = 0x0000267c,
    DNS_ERROR_DP_BASE                        = 0x000026ac,
    DNS_ERROR_DP_DOES_NOT_EXIST              = 0x000026ad,
    DNS_ERROR_DP_ALREADY_EXISTS              = 0x000026ae,
    DNS_ERROR_DP_NOT_ENLISTED                = 0x000026af,
    DNS_ERROR_DP_ALREADY_ENLISTED            = 0x000026b0,
    DNS_ERROR_DP_NOT_AVAILABLE               = 0x000026b1,
    DNS_ERROR_DP_FSMO_ERROR                  = 0x000026b2,
    DNS_ERROR_RRL_NOT_ENABLED                = 0x000026b7,
    DNS_ERROR_RRL_INVALID_WINDOW_SIZE        = 0x000026b8,
    DNS_ERROR_RRL_INVALID_IPV4_PREFIX        = 0x000026b9,
    DNS_ERROR_RRL_INVALID_IPV6_PREFIX        = 0x000026ba,
    DNS_ERROR_RRL_INVALID_TC_RATE            = 0x000026bb,
    DNS_ERROR_RRL_INVALID_LEAK_RATE          = 0x000026bc,
    DNS_ERROR_RRL_LEAK_RATE_LESSTHAN_TC_RATE = 0x000026bd,
}

enum : int
{
    DNS_ERROR_VIRTUALIZATION_INSTANCE_DOES_NOT_EXIST = 0x000026c2,
    DNS_ERROR_VIRTUALIZATION_TREE_LOCKED             = 0x000026c3,
}

enum int DNS_ERROR_DEFAULT_VIRTUALIZATION_INSTANCE = 0x000026c5;
enum int DNS_ERROR_ZONESCOPE_DOES_NOT_EXIST = 0x000026e0;
enum int DNS_ERROR_INVALID_ZONESCOPE_NAME = 0x000026e2;
enum int DNS_ERROR_LOAD_ZONESCOPE_FAILED = 0x000026e4;
enum int DNS_ERROR_INVALID_SCOPE_NAME = 0x000026e6;

enum : int
{
    DNS_ERROR_DEFAULT_SCOPE           = 0x000026e8,
    DNS_ERROR_INVALID_SCOPE_OPERATION = 0x000026e9,
}

enum int DNS_ERROR_SCOPE_ALREADY_EXISTS = 0x000026eb;

enum : int
{
    DNS_ERROR_POLICY_DOES_NOT_EXIST   = 0x000026f4,
    DNS_ERROR_POLICY_INVALID_CRITERIA = 0x000026f5,
    DNS_ERROR_POLICY_INVALID_SETTINGS = 0x000026f6,
}

enum : int
{
    DNS_ERROR_CLIENT_SUBNET_DOES_NOT_EXIST = 0x000026f8,
    DNS_ERROR_CLIENT_SUBNET_ALREADY_EXISTS = 0x000026f9,
}

enum int DNS_ERROR_SUBNET_ALREADY_EXISTS = 0x000026fb;

enum : int
{
    DNS_ERROR_POLICY_INVALID_WEIGHT   = 0x000026fd,
    DNS_ERROR_POLICY_INVALID_NAME     = 0x000026fe,
    DNS_ERROR_POLICY_MISSING_CRITERIA = 0x000026ff,
}

enum : int
{
    DNS_ERROR_POLICY_PROCESSING_ORDER_INVALID = 0x00002701,
    DNS_ERROR_POLICY_SCOPE_MISSING            = 0x00002702,
    DNS_ERROR_POLICY_SCOPE_NOT_ALLOWED        = 0x00002703,
}

enum int DNS_ERROR_ZONESCOPE_IS_REFERENCED = 0x00002705;

enum : int
{
    DNS_ERROR_POLICY_INVALID_CRITERIA_TRANSPORT_PROTOCOL = 0x00002707,
    DNS_ERROR_POLICY_INVALID_CRITERIA_NETWORK_PROTOCOL   = 0x00002708,
    DNS_ERROR_POLICY_INVALID_CRITERIA_INTERFACE          = 0x00002709,
    DNS_ERROR_POLICY_INVALID_CRITERIA_FQDN               = 0x0000270a,
    DNS_ERROR_POLICY_INVALID_CRITERIA_QUERY_TYPE         = 0x0000270b,
    DNS_ERROR_POLICY_INVALID_CRITERIA_TIME_OF_DAY        = 0x0000270c,
}

enum : int
{
    WSAEINTR       = 0x00002714,
    WSAEBADF       = 0x00002719,
    WSAEACCES      = 0x0000271d,
    WSAEFAULT      = 0x0000271e,
    WSAEINVAL      = 0x00002726,
    WSAEMFILE      = 0x00002728,
    WSAEWOULDBLOCK = 0x00002733,
}

enum int WSAEALREADY = 0x00002735;
enum int WSAEDESTADDRREQ = 0x00002737;
enum int WSAEPROTOTYPE = 0x00002739;
enum int WSAEPROTONOSUPPORT = 0x0000273b;
enum int WSAEOPNOTSUPP = 0x0000273d;
enum int WSAEAFNOSUPPORT = 0x0000273f;
enum int WSAEADDRNOTAVAIL = 0x00002741;

enum : int
{
    WSAENETUNREACH = 0x00002743,
    WSAENETRESET   = 0x00002744,
}

enum int WSAECONNRESET = 0x00002746;
enum int WSAEISCONN = 0x00002748;
enum int WSAESHUTDOWN = 0x0000274a;
enum int WSAETIMEDOUT = 0x0000274c;

enum : int
{
    WSAELOOP        = 0x0000274e,
    WSAENAMETOOLONG = 0x0000274f,
}

enum int WSAEHOSTUNREACH = 0x00002751;
enum int WSAEPROCLIM = 0x00002753;

enum : int
{
    WSAEDQUOT  = 0x00002755,
    WSAESTALE  = 0x00002756,
    WSAEREMOTE = 0x00002757,
}

enum int WSAVERNOTSUPPORTED = 0x0000276c;
enum int WSAEDISCON = 0x00002775;
enum int WSAECANCELLED = 0x00002777;
enum int WSAEINVALIDPROVIDER = 0x00002779;
enum int WSASYSCALLFAILURE = 0x0000277b;
enum int WSATYPE_NOT_FOUND = 0x0000277d;
enum int WSA_E_CANCELLED = 0x0000277f;
enum int WSAHOST_NOT_FOUND = 0x00002af9;

enum : int
{
    WSANO_RECOVERY = 0x00002afb,
    WSANO_DATA     = 0x00002afc,
}

enum : int
{
    WSA_QOS_SENDERS      = 0x00002afe,
    WSA_QOS_NO_SENDERS   = 0x00002aff,
    WSA_QOS_NO_RECEIVERS = 0x00002b00,
}

enum int WSA_QOS_ADMISSION_FAILURE = 0x00002b02;

enum : int
{
    WSA_QOS_BAD_STYLE          = 0x00002b04,
    WSA_QOS_BAD_OBJECT         = 0x00002b05,
    WSA_QOS_TRAFFIC_CTRL_ERROR = 0x00002b06,
}

enum : int
{
    WSA_QOS_ESERVICETYPE  = 0x00002b08,
    WSA_QOS_EFLOWSPEC     = 0x00002b09,
    WSA_QOS_EPROVSPECBUF  = 0x00002b0a,
    WSA_QOS_EFILTERSTYLE  = 0x00002b0b,
    WSA_QOS_EFILTERTYPE   = 0x00002b0c,
    WSA_QOS_EFILTERCOUNT  = 0x00002b0d,
    WSA_QOS_EOBJLENGTH    = 0x00002b0e,
    WSA_QOS_EFLOWCOUNT    = 0x00002b0f,
    WSA_QOS_EUNKOWNPSOBJ  = 0x00002b10,
    WSA_QOS_EPOLICYOBJ    = 0x00002b11,
    WSA_QOS_EFLOWDESC     = 0x00002b12,
    WSA_QOS_EPSFLOWSPEC   = 0x00002b13,
    WSA_QOS_EPSFILTERSPEC = 0x00002b14,
    WSA_QOS_ESDMODEOBJ    = 0x00002b15,
    WSA_QOS_ESHAPERATEOBJ = 0x00002b16,
}

enum int WSA_SECURE_HOST_NOT_FOUND = 0x00002b18;

enum : int
{
    ERROR_IPSEC_QM_POLICY_EXISTS    = 0x000032c8,
    ERROR_IPSEC_QM_POLICY_NOT_FOUND = 0x000032c9,
    ERROR_IPSEC_QM_POLICY_IN_USE    = 0x000032ca,
    ERROR_IPSEC_MM_POLICY_EXISTS    = 0x000032cb,
    ERROR_IPSEC_MM_POLICY_NOT_FOUND = 0x000032cc,
    ERROR_IPSEC_MM_POLICY_IN_USE    = 0x000032cd,
    ERROR_IPSEC_MM_FILTER_EXISTS    = 0x000032ce,
    ERROR_IPSEC_MM_FILTER_NOT_FOUND = 0x000032cf,
}

enum int ERROR_IPSEC_TRANSPORT_FILTER_NOT_FOUND = 0x000032d1;

enum : int
{
    ERROR_IPSEC_MM_AUTH_NOT_FOUND           = 0x000032d3,
    ERROR_IPSEC_MM_AUTH_IN_USE              = 0x000032d4,
    ERROR_IPSEC_DEFAULT_MM_POLICY_NOT_FOUND = 0x000032d5,
    ERROR_IPSEC_DEFAULT_MM_AUTH_NOT_FOUND   = 0x000032d6,
    ERROR_IPSEC_DEFAULT_QM_POLICY_NOT_FOUND = 0x000032d7,
}

enum int ERROR_IPSEC_TUNNEL_FILTER_NOT_FOUND = 0x000032d9;
enum int ERROR_IPSEC_TRANSPORT_FILTER_PENDING_DELETION = 0x000032db;
enum int ERROR_IPSEC_MM_POLICY_PENDING_DELETION = 0x000032dd;
enum int ERROR_IPSEC_QM_POLICY_PENDING_DELETION = 0x000032df;
enum int WARNING_IPSEC_QM_POLICY_PRUNED = 0x000032e1;

enum : int
{
    ERROR_IPSEC_IKE_AUTH_FAIL                = 0x000035e9,
    ERROR_IPSEC_IKE_ATTRIB_FAIL              = 0x000035ea,
    ERROR_IPSEC_IKE_NEGOTIATION_PENDING      = 0x000035eb,
    ERROR_IPSEC_IKE_GENERAL_PROCESSING_ERROR = 0x000035ec,
}

enum : int
{
    ERROR_IPSEC_IKE_NO_CERT                         = 0x000035ee,
    ERROR_IPSEC_IKE_SA_DELETED                      = 0x000035ef,
    ERROR_IPSEC_IKE_SA_REAPED                       = 0x000035f0,
    ERROR_IPSEC_IKE_MM_ACQUIRE_DROP                 = 0x000035f1,
    ERROR_IPSEC_IKE_QM_ACQUIRE_DROP                 = 0x000035f2,
    ERROR_IPSEC_IKE_QUEUE_DROP_MM                   = 0x000035f3,
    ERROR_IPSEC_IKE_QUEUE_DROP_NO_MM                = 0x000035f4,
    ERROR_IPSEC_IKE_DROP_NO_RESPONSE                = 0x000035f5,
    ERROR_IPSEC_IKE_MM_DELAY_DROP                   = 0x000035f6,
    ERROR_IPSEC_IKE_QM_DELAY_DROP                   = 0x000035f7,
    ERROR_IPSEC_IKE_ERROR                           = 0x000035f8,
    ERROR_IPSEC_IKE_CRL_FAILED                      = 0x000035f9,
    ERROR_IPSEC_IKE_INVALID_KEY_USAGE               = 0x000035fa,
    ERROR_IPSEC_IKE_INVALID_CERT_TYPE               = 0x000035fb,
    ERROR_IPSEC_IKE_NO_PRIVATE_KEY                  = 0x000035fc,
    ERROR_IPSEC_IKE_SIMULTANEOUS_REKEY              = 0x000035fd,
    ERROR_IPSEC_IKE_DH_FAIL                         = 0x000035fe,
    ERROR_IPSEC_IKE_CRITICAL_PAYLOAD_NOT_RECOGNIZED = 0x000035ff,
}

enum : int
{
    ERROR_IPSEC_IKE_NO_POLICY                         = 0x00003601,
    ERROR_IPSEC_IKE_INVALID_SIGNATURE                 = 0x00003602,
    ERROR_IPSEC_IKE_KERBEROS_ERROR                    = 0x00003603,
    ERROR_IPSEC_IKE_NO_PUBLIC_KEY                     = 0x00003604,
    ERROR_IPSEC_IKE_PROCESS_ERR                       = 0x00003605,
    ERROR_IPSEC_IKE_PROCESS_ERR_SA                    = 0x00003606,
    ERROR_IPSEC_IKE_PROCESS_ERR_PROP                  = 0x00003607,
    ERROR_IPSEC_IKE_PROCESS_ERR_TRANS                 = 0x00003608,
    ERROR_IPSEC_IKE_PROCESS_ERR_KE                    = 0x00003609,
    ERROR_IPSEC_IKE_PROCESS_ERR_ID                    = 0x0000360a,
    ERROR_IPSEC_IKE_PROCESS_ERR_CERT                  = 0x0000360b,
    ERROR_IPSEC_IKE_PROCESS_ERR_CERT_REQ              = 0x0000360c,
    ERROR_IPSEC_IKE_PROCESS_ERR_HASH                  = 0x0000360d,
    ERROR_IPSEC_IKE_PROCESS_ERR_SIG                   = 0x0000360e,
    ERROR_IPSEC_IKE_PROCESS_ERR_NONCE                 = 0x0000360f,
    ERROR_IPSEC_IKE_PROCESS_ERR_NOTIFY                = 0x00003610,
    ERROR_IPSEC_IKE_PROCESS_ERR_DELETE                = 0x00003611,
    ERROR_IPSEC_IKE_PROCESS_ERR_VENDOR                = 0x00003612,
    ERROR_IPSEC_IKE_INVALID_PAYLOAD                   = 0x00003613,
    ERROR_IPSEC_IKE_LOAD_SOFT_SA                      = 0x00003614,
    ERROR_IPSEC_IKE_SOFT_SA_TORN_DOWN                 = 0x00003615,
    ERROR_IPSEC_IKE_INVALID_COOKIE                    = 0x00003616,
    ERROR_IPSEC_IKE_NO_PEER_CERT                      = 0x00003617,
    ERROR_IPSEC_IKE_PEER_CRL_FAILED                   = 0x00003618,
    ERROR_IPSEC_IKE_POLICY_CHANGE                     = 0x00003619,
    ERROR_IPSEC_IKE_NO_MM_POLICY                      = 0x0000361a,
    ERROR_IPSEC_IKE_NOTCBPRIV                         = 0x0000361b,
    ERROR_IPSEC_IKE_SECLOADFAIL                       = 0x0000361c,
    ERROR_IPSEC_IKE_FAILSSPINIT                       = 0x0000361d,
    ERROR_IPSEC_IKE_FAILQUERYSSP                      = 0x0000361e,
    ERROR_IPSEC_IKE_SRVACQFAIL                        = 0x0000361f,
    ERROR_IPSEC_IKE_SRVQUERYCRED                      = 0x00003620,
    ERROR_IPSEC_IKE_GETSPIFAIL                        = 0x00003621,
    ERROR_IPSEC_IKE_INVALID_FILTER                    = 0x00003622,
    ERROR_IPSEC_IKE_OUT_OF_MEMORY                     = 0x00003623,
    ERROR_IPSEC_IKE_ADD_UPDATE_KEY_FAILED             = 0x00003624,
    ERROR_IPSEC_IKE_INVALID_POLICY                    = 0x00003625,
    ERROR_IPSEC_IKE_UNKNOWN_DOI                       = 0x00003626,
    ERROR_IPSEC_IKE_INVALID_SITUATION                 = 0x00003627,
    ERROR_IPSEC_IKE_DH_FAILURE                        = 0x00003628,
    ERROR_IPSEC_IKE_INVALID_GROUP                     = 0x00003629,
    ERROR_IPSEC_IKE_ENCRYPT                           = 0x0000362a,
    ERROR_IPSEC_IKE_DECRYPT                           = 0x0000362b,
    ERROR_IPSEC_IKE_POLICY_MATCH                      = 0x0000362c,
    ERROR_IPSEC_IKE_UNSUPPORTED_ID                    = 0x0000362d,
    ERROR_IPSEC_IKE_INVALID_HASH                      = 0x0000362e,
    ERROR_IPSEC_IKE_INVALID_HASH_ALG                  = 0x0000362f,
    ERROR_IPSEC_IKE_INVALID_HASH_SIZE                 = 0x00003630,
    ERROR_IPSEC_IKE_INVALID_ENCRYPT_ALG               = 0x00003631,
    ERROR_IPSEC_IKE_INVALID_AUTH_ALG                  = 0x00003632,
    ERROR_IPSEC_IKE_INVALID_SIG                       = 0x00003633,
    ERROR_IPSEC_IKE_LOAD_FAILED                       = 0x00003634,
    ERROR_IPSEC_IKE_RPC_DELETE                        = 0x00003635,
    ERROR_IPSEC_IKE_BENIGN_REINIT                     = 0x00003636,
    ERROR_IPSEC_IKE_INVALID_RESPONDER_LIFETIME_NOTIFY = 0x00003637,
    ERROR_IPSEC_IKE_INVALID_MAJOR_VERSION             = 0x00003638,
    ERROR_IPSEC_IKE_INVALID_CERT_KEYLEN               = 0x00003639,
    ERROR_IPSEC_IKE_MM_LIMIT                          = 0x0000363a,
    ERROR_IPSEC_IKE_NEGOTIATION_DISABLED              = 0x0000363b,
    ERROR_IPSEC_IKE_QM_LIMIT                          = 0x0000363c,
    ERROR_IPSEC_IKE_MM_EXPIRED                        = 0x0000363d,
    ERROR_IPSEC_IKE_PEER_MM_ASSUMED_INVALID           = 0x0000363e,
    ERROR_IPSEC_IKE_CERT_CHAIN_POLICY_MISMATCH        = 0x0000363f,
}

enum : int
{
    ERROR_IPSEC_IKE_INVALID_AUTH_PAYLOAD        = 0x00003641,
    ERROR_IPSEC_IKE_DOS_COOKIE_SENT             = 0x00003642,
    ERROR_IPSEC_IKE_SHUTTING_DOWN               = 0x00003643,
    ERROR_IPSEC_IKE_CGA_AUTH_FAILED             = 0x00003644,
    ERROR_IPSEC_IKE_PROCESS_ERR_NATOA           = 0x00003645,
    ERROR_IPSEC_IKE_INVALID_MM_FOR_QM           = 0x00003646,
    ERROR_IPSEC_IKE_QM_EXPIRED                  = 0x00003647,
    ERROR_IPSEC_IKE_TOO_MANY_FILTERS            = 0x00003648,
    ERROR_IPSEC_IKE_NEG_STATUS_END              = 0x00003649,
    ERROR_IPSEC_IKE_KILL_DUMMY_NAP_TUNNEL       = 0x0000364a,
    ERROR_IPSEC_IKE_INNER_IP_ASSIGNMENT_FAILURE = 0x0000364b,
}

enum int ERROR_IPSEC_KEY_MODULE_IMPERSONATION_NEGOTIATION_PENDING = 0x0000364d;

enum : int
{
    ERROR_IPSEC_IKE_RATELIMIT_DROP             = 0x0000364f,
    ERROR_IPSEC_IKE_PEER_DOESNT_SUPPORT_MOBIKE = 0x00003650,
}

enum int ERROR_IPSEC_IKE_STRONG_CRED_AUTHORIZATION_FAILURE = 0x00003652;
enum int ERROR_IPSEC_IKE_STRONG_CRED_AUTHORIZATION_AND_CERTMAP_FAILURE = 0x00003654;

enum : int
{
    ERROR_IPSEC_BAD_SPI             = 0x00003656,
    ERROR_IPSEC_SA_LIFETIME_EXPIRED = 0x00003657,
}

enum int ERROR_IPSEC_REPLAY_CHECK_FAILED = 0x00003659;
enum int ERROR_IPSEC_INTEGRITY_CHECK_FAILED = 0x0000365b;
enum int ERROR_IPSEC_AUTH_FIREWALL_DROP = 0x0000365d;

enum : int
{
    ERROR_IPSEC_DOSP_BLOCK                       = 0x00003665,
    ERROR_IPSEC_DOSP_RECEIVED_MULTICAST          = 0x00003666,
    ERROR_IPSEC_DOSP_INVALID_PACKET              = 0x00003667,
    ERROR_IPSEC_DOSP_STATE_LOOKUP_FAILED         = 0x00003668,
    ERROR_IPSEC_DOSP_MAX_ENTRIES                 = 0x00003669,
    ERROR_IPSEC_DOSP_KEYMOD_NOT_ALLOWED          = 0x0000366a,
    ERROR_IPSEC_DOSP_NOT_INSTALLED               = 0x0000366b,
    ERROR_IPSEC_DOSP_MAX_PER_IP_RATELIMIT_QUEUES = 0x0000366c,
}

enum int ERROR_SXS_CANT_GEN_ACTCTX = 0x000036b1;
enum int ERROR_SXS_ASSEMBLY_NOT_FOUND = 0x000036b3;
enum int ERROR_SXS_MANIFEST_PARSE_ERROR = 0x000036b5;

enum : int
{
    ERROR_SXS_KEY_NOT_FOUND    = 0x000036b7,
    ERROR_SXS_VERSION_CONFLICT = 0x000036b8,
}

enum int ERROR_SXS_THREAD_QUERIES_DISABLED = 0x000036ba;

enum : int
{
    ERROR_SXS_UNKNOWN_ENCODING_GROUP = 0x000036bc,
    ERROR_SXS_UNKNOWN_ENCODING       = 0x000036bd,
}

enum int ERROR_SXS_ROOT_MANIFEST_DEPENDENCY_NOT_INSTALLED = 0x000036bf;
enum int ERROR_SXS_INVALID_ASSEMBLY_IDENTITY_ATTRIBUTE = 0x000036c1;
enum int ERROR_SXS_MANIFEST_INVALID_REQUIRED_DEFAULT_NAMESPACE = 0x000036c3;

enum : int
{
    ERROR_SXS_DUPLICATE_DLL_NAME         = 0x000036c5,
    ERROR_SXS_DUPLICATE_WINDOWCLASS_NAME = 0x000036c6,
    ERROR_SXS_DUPLICATE_CLSID            = 0x000036c7,
    ERROR_SXS_DUPLICATE_IID              = 0x000036c8,
    ERROR_SXS_DUPLICATE_TLBID            = 0x000036c9,
    ERROR_SXS_DUPLICATE_PROGID           = 0x000036ca,
    ERROR_SXS_DUPLICATE_ASSEMBLY_NAME    = 0x000036cb,
}

enum int ERROR_SXS_POLICY_PARSE_ERROR = 0x000036cd;

enum : int
{
    ERROR_SXS_XML_E_COMMENTSYNTAX            = 0x000036cf,
    ERROR_SXS_XML_E_BADSTARTNAMECHAR         = 0x000036d0,
    ERROR_SXS_XML_E_BADNAMECHAR              = 0x000036d1,
    ERROR_SXS_XML_E_BADCHARINSTRING          = 0x000036d2,
    ERROR_SXS_XML_E_XMLDECLSYNTAX            = 0x000036d3,
    ERROR_SXS_XML_E_BADCHARDATA              = 0x000036d4,
    ERROR_SXS_XML_E_MISSINGWHITESPACE        = 0x000036d5,
    ERROR_SXS_XML_E_EXPECTINGTAGEND          = 0x000036d6,
    ERROR_SXS_XML_E_MISSINGSEMICOLON         = 0x000036d7,
    ERROR_SXS_XML_E_UNBALANCEDPAREN          = 0x000036d8,
    ERROR_SXS_XML_E_INTERNALERROR            = 0x000036d9,
    ERROR_SXS_XML_E_UNEXPECTED_WHITESPACE    = 0x000036da,
    ERROR_SXS_XML_E_INCOMPLETE_ENCODING      = 0x000036db,
    ERROR_SXS_XML_E_MISSING_PAREN            = 0x000036dc,
    ERROR_SXS_XML_E_EXPECTINGCLOSEQUOTE      = 0x000036dd,
    ERROR_SXS_XML_E_MULTIPLE_COLONS          = 0x000036de,
    ERROR_SXS_XML_E_INVALID_DECIMAL          = 0x000036df,
    ERROR_SXS_XML_E_INVALID_HEXIDECIMAL      = 0x000036e0,
    ERROR_SXS_XML_E_INVALID_UNICODE          = 0x000036e1,
    ERROR_SXS_XML_E_WHITESPACEORQUESTIONMARK = 0x000036e2,
}

enum : int
{
    ERROR_SXS_XML_E_UNCLOSEDTAG           = 0x000036e4,
    ERROR_SXS_XML_E_DUPLICATEATTRIBUTE    = 0x000036e5,
    ERROR_SXS_XML_E_MULTIPLEROOTS         = 0x000036e6,
    ERROR_SXS_XML_E_INVALIDATROOTLEVEL    = 0x000036e7,
    ERROR_SXS_XML_E_BADXMLDECL            = 0x000036e8,
    ERROR_SXS_XML_E_MISSINGROOT           = 0x000036e9,
    ERROR_SXS_XML_E_UNEXPECTEDEOF         = 0x000036ea,
    ERROR_SXS_XML_E_BADPEREFINSUBSET      = 0x000036eb,
    ERROR_SXS_XML_E_UNCLOSEDSTARTTAG      = 0x000036ec,
    ERROR_SXS_XML_E_UNCLOSEDENDTAG        = 0x000036ed,
    ERROR_SXS_XML_E_UNCLOSEDSTRING        = 0x000036ee,
    ERROR_SXS_XML_E_UNCLOSEDCOMMENT       = 0x000036ef,
    ERROR_SXS_XML_E_UNCLOSEDDECL          = 0x000036f0,
    ERROR_SXS_XML_E_UNCLOSEDCDATA         = 0x000036f1,
    ERROR_SXS_XML_E_RESERVEDNAMESPACE     = 0x000036f2,
    ERROR_SXS_XML_E_INVALIDENCODING       = 0x000036f3,
    ERROR_SXS_XML_E_INVALIDSWITCH         = 0x000036f4,
    ERROR_SXS_XML_E_BADXMLCASE            = 0x000036f5,
    ERROR_SXS_XML_E_INVALID_STANDALONE    = 0x000036f6,
    ERROR_SXS_XML_E_UNEXPECTED_STANDALONE = 0x000036f7,
    ERROR_SXS_XML_E_INVALID_VERSION       = 0x000036f8,
    ERROR_SXS_XML_E_MISSINGEQUALS         = 0x000036f9,
}

enum : int
{
    ERROR_SXS_PROTECTION_PUBLIC_KEY_TOO_SHORT = 0x000036fb,
    ERROR_SXS_PROTECTION_CATALOG_NOT_VALID    = 0x000036fc,
}

enum int ERROR_SXS_PROTECTION_CATALOG_FILE_MISSING = 0x000036fe;
enum int ERROR_SXS_INVALID_ASSEMBLY_IDENTITY_ATTRIBUTE_NAME = 0x00003700;

enum : int
{
    ERROR_SXS_CORRUPT_ACTIVATION_STACK = 0x00003702,
    ERROR_SXS_CORRUPTION               = 0x00003703,
    ERROR_SXS_EARLY_DEACTIVATION       = 0x00003704,
}

enum int ERROR_SXS_MULTIPLE_DEACTIVATION = 0x00003706;
enum int ERROR_SXS_RELEASE_ACTIVATION_CONTEXT = 0x00003708;

enum : int
{
    ERROR_SXS_INVALID_IDENTITY_ATTRIBUTE_VALUE = 0x0000370a,
    ERROR_SXS_INVALID_IDENTITY_ATTRIBUTE_NAME  = 0x0000370b,
}

enum int ERROR_SXS_IDENTITY_PARSE_ERROR = 0x0000370d;
enum int ERROR_SXS_INCORRECT_PUBLIC_KEY_TOKEN = 0x0000370f;
enum int ERROR_SXS_ASSEMBLY_NOT_LOCKED = 0x00003711;
enum int ERROR_ADVANCED_INSTALLER_FAILED = 0x00003713;
enum int ERROR_SXS_MANIFEST_IDENTITY_SAME_BUT_CONTENTS_DIFFERENT = 0x00003715;
enum int ERROR_SXS_ASSEMBLY_IS_NOT_A_DEPLOYMENT = 0x00003717;
enum int ERROR_SXS_MANIFEST_TOO_BIG = 0x00003719;
enum int ERROR_SXS_TRANSACTION_CLOSURE_INCOMPLETE = 0x0000371b;
enum int ERROR_GENERIC_COMMAND_FAILED = 0x0000371d;
enum int ERROR_SXS_DUPLICATE_ACTIVATABLE_CLASS = 0x0000371f;

enum : int
{
    ERROR_EVT_INVALID_QUERY                = 0x00003a99,
    ERROR_EVT_PUBLISHER_METADATA_NOT_FOUND = 0x00003a9a,
}

enum : int
{
    ERROR_EVT_INVALID_PUBLISHER_NAME = 0x00003a9c,
    ERROR_EVT_INVALID_EVENT_DATA     = 0x00003a9d,
}

enum int ERROR_EVT_MALFORMED_XML_TEXT = 0x00003aa0;
enum int ERROR_EVT_CONFIGURATION_ERROR = 0x00003aa2;
enum int ERROR_EVT_QUERY_RESULT_INVALID_POSITION = 0x00003aa4;

enum : int
{
    ERROR_EVT_FILTER_ALREADYSCOPED   = 0x00003aa6,
    ERROR_EVT_FILTER_NOTELTSET       = 0x00003aa7,
    ERROR_EVT_FILTER_INVARG          = 0x00003aa8,
    ERROR_EVT_FILTER_INVTEST         = 0x00003aa9,
    ERROR_EVT_FILTER_INVTYPE         = 0x00003aaa,
    ERROR_EVT_FILTER_PARSEERR        = 0x00003aab,
    ERROR_EVT_FILTER_UNSUPPORTEDOP   = 0x00003aac,
    ERROR_EVT_FILTER_UNEXPECTEDTOKEN = 0x00003aad,
}

enum : int
{
    ERROR_EVT_INVALID_CHANNEL_PROPERTY_VALUE   = 0x00003aaf,
    ERROR_EVT_INVALID_PUBLISHER_PROPERTY_VALUE = 0x00003ab0,
}

enum int ERROR_EVT_FILTER_TOO_COMPLEX = 0x00003ab2;
enum int ERROR_EVT_MESSAGE_ID_NOT_FOUND = 0x00003ab4;
enum int ERROR_EVT_UNRESOLVED_PARAMETER_INSERT = 0x00003ab6;
enum int ERROR_EVT_EVENT_DEFINITION_NOT_FOUND = 0x00003ab8;

enum : int
{
    ERROR_EVT_VERSION_TOO_OLD = 0x00003aba,
    ERROR_EVT_VERSION_TOO_NEW = 0x00003abb,
}

enum int ERROR_EVT_PUBLISHER_DISABLED = 0x00003abd;
enum int ERROR_EC_SUBSCRIPTION_CANNOT_ACTIVATE = 0x00003ae8;
enum int ERROR_EC_CIRCULAR_FORWARDING = 0x00003aea;
enum int ERROR_EC_CRED_NOT_FOUND = 0x00003aec;

enum : int
{
    ERROR_MUI_FILE_NOT_FOUND                = 0x00003afc,
    ERROR_MUI_INVALID_FILE                  = 0x00003afd,
    ERROR_MUI_INVALID_RC_CONFIG             = 0x00003afe,
    ERROR_MUI_INVALID_LOCALE_NAME           = 0x00003aff,
    ERROR_MUI_INVALID_ULTIMATEFALLBACK_NAME = 0x00003b00,
}

enum int ERROR_RESOURCE_ENUM_USER_STOP = 0x00003b02;
enum int ERROR_MUI_INTLSETTINGS_INVALID_LOCALE_NAME = 0x00003b04;

enum : int
{
    ERROR_MRM_INVALID_PRICONFIG = 0x00003b07,
    ERROR_MRM_INVALID_FILE_TYPE = 0x00003b08,
}

enum int ERROR_MRM_INVALID_QUALIFIER_VALUE = 0x00003b0a;
enum int ERROR_MRM_NO_MATCH_OR_DEFAULT_CANDIDATE = 0x00003b0c;

enum : int
{
    ERROR_MRM_DUPLICATE_MAP_NAME = 0x00003b0e,
    ERROR_MRM_DUPLICATE_ENTRY    = 0x00003b0f,
}

enum int ERROR_MRM_FILEPATH_TOO_LONG = 0x00003b11;
enum int ERROR_MRM_INVALID_PRI_FILE = 0x00003b16;

enum : int
{
    ERROR_MRM_MAP_NOT_FOUND            = 0x00003b1f,
    ERROR_MRM_UNSUPPORTED_PROFILE_TYPE = 0x00003b20,
}

enum int ERROR_MRM_INDETERMINATE_QUALIFIER_VALUE = 0x00003b22;
enum int ERROR_MRM_TOO_MANY_RESOURCES = 0x00003b24;
enum int ERROR_MRM_UNSUPPORTED_FILE_TYPE_FOR_LOAD_UNLOAD_PRI_FILE = 0x00003b26;
enum int ERROR_DIFFERENT_PROFILE_RESOURCE_MANAGER_EXIST = 0x00003b28;
enum int ERROR_MRM_DIRECT_REF_TO_NON_DEFAULT_RESOURCE = 0x00003b2a;

enum : int
{
    ERROR_PRI_MERGE_VERSION_MISMATCH                      = 0x00003b2c,
    ERROR_PRI_MERGE_MISSING_SCHEMA                        = 0x00003b2d,
    ERROR_PRI_MERGE_LOAD_FILE_FAILED                      = 0x00003b2e,
    ERROR_PRI_MERGE_ADD_FILE_FAILED                       = 0x00003b2f,
    ERROR_PRI_MERGE_WRITE_FILE_FAILED                     = 0x00003b30,
    ERROR_PRI_MERGE_MULTIPLE_PACKAGE_FAMILIES_NOT_ALLOWED = 0x00003b31,
    ERROR_PRI_MERGE_MULTIPLE_MAIN_PACKAGES_NOT_ALLOWED    = 0x00003b32,
}

enum : int
{
    ERROR_PRI_MERGE_MAIN_PACKAGE_REQUIRED     = 0x00003b34,
    ERROR_PRI_MERGE_RESOURCE_PACKAGE_REQUIRED = 0x00003b35,
}

enum int ERROR_MRM_PACKAGE_NOT_FOUND = 0x00003b37;

enum : int
{
    ERROR_MCA_INVALID_CAPABILITIES_STRING = 0x00003b60,
    ERROR_MCA_INVALID_VCP_VERSION         = 0x00003b61,
}

enum int ERROR_MCA_MCCS_VERSION_MISMATCH = 0x00003b63;

enum : int
{
    ERROR_MCA_INTERNAL_ERROR                   = 0x00003b65,
    ERROR_MCA_INVALID_TECHNOLOGY_TYPE_RETURNED = 0x00003b66,
}

enum int ERROR_AMBIGUOUS_SYSTEM_DEVICE = 0x00003b92;

enum : int
{
    ERROR_HASH_NOT_SUPPORTED = 0x00003bc4,
    ERROR_HASH_NOT_PRESENT   = 0x00003bc5,
}

enum int ERROR_GPIO_CLIENT_INFORMATION_INVALID = 0x00003bda;
enum int ERROR_GPIO_INVALID_REGISTRATION_PACKET = 0x00003bdc;
enum int ERROR_GPIO_INCOMPATIBLE_CONNECT_MODE = 0x00003bde;
enum int ERROR_CANNOT_SWITCH_RUNLEVEL = 0x00003c28;

enum : int
{
    ERROR_RUNLEVEL_SWITCH_TIMEOUT       = 0x00003c2a,
    ERROR_RUNLEVEL_SWITCH_AGENT_TIMEOUT = 0x00003c2b,
    ERROR_RUNLEVEL_SWITCH_IN_PROGRESS   = 0x00003c2c,
}

enum int ERROR_COM_TASK_STOP_PENDING = 0x00003c8d;

enum : int
{
    ERROR_INSTALL_PACKAGE_NOT_FOUND         = 0x00003cf1,
    ERROR_INSTALL_INVALID_PACKAGE           = 0x00003cf2,
    ERROR_INSTALL_RESOLVE_DEPENDENCY_FAILED = 0x00003cf3,
}

enum : int
{
    ERROR_INSTALL_NETWORK_FAILURE        = 0x00003cf5,
    ERROR_INSTALL_REGISTRATION_FAILURE   = 0x00003cf6,
    ERROR_INSTALL_DEREGISTRATION_FAILURE = 0x00003cf7,
}

enum int ERROR_INSTALL_FAILED = 0x00003cf9;
enum int ERROR_PACKAGE_ALREADY_EXISTS = 0x00003cfb;
enum int ERROR_INSTALL_PREREQUISITE_FAILED = 0x00003cfd;
enum int ERROR_INSTALL_POLICY_FAILURE = 0x00003cff;
enum int ERROR_DEPLOYMENT_BLOCKED_BY_POLICY = 0x00003d01;
enum int ERROR_RECOVERY_FILE_CORRUPT = 0x00003d03;
enum int ERROR_DELETING_EXISTING_APPLICATIONDATA_STORE_FAILED = 0x00003d05;
enum int ERROR_SYSTEM_NEEDS_REMEDIATION = 0x00003d07;
enum int ERROR_RESILIENCY_FILE_CORRUPT = 0x00003d09;
enum int ERROR_PACKAGE_MOVE_FAILED = 0x00003d0b;

enum : int
{
    ERROR_INSTALL_VOLUME_OFFLINE = 0x00003d0d,
    ERROR_INSTALL_VOLUME_CORRUPT = 0x00003d0e,
}

enum int ERROR_INSTALL_WRONG_PROCESSOR_ARCHITECTURE = 0x00003d10;
enum int ERROR_INSTALL_OPTIONAL_PACKAGE_REQUIRES_MAIN_PACKAGE = 0x00003d12;
enum int ERROR_PACKAGE_MOVE_BLOCKED_BY_STREAMING = 0x00003d14;
enum int ERROR_PACKAGE_STAGING_ONHOLD = 0x00003d16;
enum int ERROR_INSTALL_OPTIONAL_PACKAGE_REQUIRES_MAIN_PACKAGE_FULLTRUST_CAPABILITY = 0x00003d18;
enum int ERROR_PROVISION_OPTIONAL_PACKAGE_REQUIRES_MAIN_PACKAGE_PROVISIONED = 0x00003d1a;
enum int ERROR_PACKAGES_REPUTATION_CHECK_TIMEDOUT = 0x00003d1c;
enum int ERROR_APPINSTALLER_ACTIVATION_BLOCKED = 0x00003d1e;
enum int ERROR_APPX_RAW_DATA_WRITE_FAILED = 0x00003d20;

enum : int
{
    ERROR_DEPLOYMENT_BLOCKED_BY_VOLUME_POLICY_MACHINE             = 0x00003d22,
    ERROR_DEPLOYMENT_BLOCKED_BY_PROFILE_POLICY                    = 0x00003d23,
    ERROR_DEPLOYMENT_FAILED_CONFLICTING_MUTABLE_PACKAGE_DIRECTORY = 0x00003d24,
}

enum int ERROR_DIFFERENT_VERSION_OF_PACKAGED_SERVICE_INSTALLED = 0x00003d26;
enum int ERROR_PACKAGED_SERVICE_REQUIRES_ADMIN_PRIVILEGES = 0x00003d28;
enum int ERROR_PACKAGE_LACKS_CAPABILITY_TO_DEPLOY_ON_HOST = 0x00003d2a;
enum int ERROR_UNSIGNED_PACKAGE_INVALID_PUBLISHER_NAMESPACE = 0x00003d2c;
enum int ERROR_PACKAGE_EXTERNAL_LOCATION_NOT_ALLOWED = 0x00003d2e;

enum : int
{
    APPMODEL_ERROR_NO_PACKAGE               = 0x00003d54,
    APPMODEL_ERROR_PACKAGE_RUNTIME_CORRUPT  = 0x00003d55,
    APPMODEL_ERROR_PACKAGE_IDENTITY_CORRUPT = 0x00003d56,
}

enum : int
{
    APPMODEL_ERROR_DYNAMIC_PROPERTY_READ_FAILED = 0x00003d58,
    APPMODEL_ERROR_DYNAMIC_PROPERTY_INVALID     = 0x00003d59,
}

enum int APPMODEL_ERROR_NO_MUTABLE_DIRECTORY = 0x00003d5b;
enum int ERROR_STATE_GET_VERSION_FAILED = 0x00003db9;
enum int ERROR_STATE_STRUCTURED_RESET_FAILED = 0x00003dbb;
enum int ERROR_STATE_CREATE_CONTAINER_FAILED = 0x00003dbd;
enum int ERROR_STATE_READ_SETTING_FAILED = 0x00003dbf;
enum int ERROR_STATE_DELETE_SETTING_FAILED = 0x00003dc1;
enum int ERROR_STATE_READ_COMPOSITE_SETTING_FAILED = 0x00003dc3;

enum : int
{
    ERROR_STATE_ENUMERATE_CONTAINER_FAILED = 0x00003dc5,
    ERROR_STATE_ENUMERATE_SETTINGS_FAILED  = 0x00003dc6,
}

enum : int
{
    ERROR_STATE_SETTING_VALUE_SIZE_LIMIT_EXCEEDED = 0x00003dc8,
    ERROR_STATE_SETTING_NAME_SIZE_LIMIT_EXCEEDED  = 0x00003dc9,
}

enum int ERROR_API_UNAVAILABLE = 0x00003de1;

enum : int
{
    STORE_ERROR_UNLICENSED_USER         = 0x00003df6,
    STORE_ERROR_PENDING_COM_TRANSACTION = 0x00003df7,
}

enum : int
{
    SEVERITY_SUCCESS = 0x00000000,
    SEVERITY_ERROR   = 0x00000001,
}

enum int NOERROR = 0x00000000;
enum int E_NOTIMPL = 0x80004001;
enum int E_INVALIDARG = 0x80070057;
enum int E_POINTER = 0x80004003;
enum int E_ABORT = 0x80004004;
enum int E_ACCESSDENIED = 0x80070005;
enum int E_BOUNDS = 0x8000000b;

enum : int
{
    E_ILLEGAL_STATE_CHANGE = 0x8000000d,
    E_ILLEGAL_METHOD_CALL  = 0x8000000e,
}

enum : int
{
    RO_E_METADATA_NAME_IS_NAMESPACE   = 0x80000010,
    RO_E_METADATA_INVALID_TYPE_FORMAT = 0x80000011,
}

enum : int
{
    RO_E_CLOSED          = 0x80000013,
    RO_E_EXCLUSIVE_WRITE = 0x80000014,
}

enum int RO_E_ERROR_STRING_NOT_FOUND = 0x80000016;
enum int E_ILLEGAL_DELEGATE_ASSIGNMENT = 0x80000018;

enum : int
{
    E_APPLICATION_EXITING      = 0x8000001a,
    E_APPLICATION_VIEW_EXITING = 0x8000001b,
}

enum int RO_E_UNSUPPORTED_FROM_MTA = 0x8000001d;
enum int RO_E_BLOCKED_CROSS_ASTA_CALL = 0x8000001f;
enum int RO_E_CANNOT_ACTIVATE_UNIVERSAL_APPLICATION_SERVER = 0x80000021;
enum int CO_E_INIT_SHARED_ALLOCATOR = 0x80004007;

enum : int
{
    CO_E_INIT_CLASS_CACHE             = 0x80004009,
    CO_E_INIT_RPC_CHANNEL             = 0x8000400a,
    CO_E_INIT_TLS_SET_CHANNEL_CONTROL = 0x8000400b,
    CO_E_INIT_TLS_CHANNEL_CONTROL     = 0x8000400c,
}

enum : int
{
    CO_E_INIT_SCM_MUTEX_EXISTS        = 0x8000400e,
    CO_E_INIT_SCM_FILE_MAPPING_EXISTS = 0x8000400f,
    CO_E_INIT_SCM_MAP_VIEW_OF_FILE    = 0x80004010,
    CO_E_INIT_SCM_EXEC_FAILURE        = 0x80004011,
}

enum int CO_E_CANT_REMOTE = 0x80004013;
enum int CO_E_WRONG_SERVER_IDENTITY = 0x80004015;
enum int CO_E_RUNAS_SYNTAX = 0x80004017;
enum int CO_E_RUNAS_CREATEPROCESS_FAILURE = 0x80004019;
enum int CO_E_LAUNCH_PERMSSION_DENIED = 0x8000401b;
enum int CO_E_REMOTE_COMMUNICATION_FAILURE = 0x8000401d;
enum int CO_E_CLSREG_INCONSISTENT = 0x8000401f;
enum int CO_E_NOT_SUPPORTED = 0x80004021;
enum int CO_E_MSI_ERROR = 0x80004023;

enum : int
{
    CO_E_SERVER_PAUSED     = 0x80004025,
    CO_E_SERVER_NOT_PAUSED = 0x80004026,
}

enum int CO_E_CLRNOTAVAILABLE = 0x80004028;
enum int CO_E_SERVER_INIT_TIMEOUT = 0x8000402a;
enum int CO_E_TRACKER_CONFIG = 0x80004030;
enum int CO_E_SXS_CONFIG = 0x80004032;
enum int CO_E_UNREVOKED_REGISTRATION_ON_APARTMENT_SHUTDOWN = 0x80004034;

enum : int
{
    S_OK    = 0x00000000,
    S_FALSE = 0x00000001,
}

enum int OLE_E_LAST = 0x800400ff;
enum int OLE_S_LAST = 0x000400ff;

enum : int
{
    OLE_E_ADVF        = 0x80040001,
    OLE_E_ENUM_NOMORE = 0x80040002,
}

enum : int
{
    OLE_E_NOCONNECTION      = 0x80040004,
    OLE_E_NOTRUNNING        = 0x80040005,
    OLE_E_NOCACHE           = 0x80040006,
    OLE_E_BLANK             = 0x80040007,
    OLE_E_CLASSDIFF         = 0x80040008,
    OLE_E_CANT_GETMONIKER   = 0x80040009,
    OLE_E_CANT_BINDTOSOURCE = 0x8004000a,
}

enum int OLE_E_PROMPTSAVECANCELLED = 0x8004000c;
enum int OLE_E_WRONGCOMPOBJ = 0x8004000e;
enum int OLE_E_NOT_INPLACEACTIVE = 0x80040010;
enum int OLE_E_NOSTORAGE = 0x80040012;
enum int DV_E_DVTARGETDEVICE = 0x80040065;
enum int DV_E_STATDATA = 0x80040067;

enum : int
{
    DV_E_TYMED      = 0x80040069,
    DV_E_CLIPFORMAT = 0x8004006a,
}

enum int DV_E_DVTARGETDEVICE_SIZE = 0x8004006c;

enum : int
{
    DRAGDROP_E_FIRST             = 0x80040100,
    DRAGDROP_E_LAST              = 0x8004010f,
    DRAGDROP_S_FIRST             = 0x00040100,
    DRAGDROP_S_LAST              = 0x0004010f,
    DRAGDROP_E_NOTREGISTERED     = 0x80040100,
    DRAGDROP_E_ALREADYREGISTERED = 0x80040101,
}

enum int DRAGDROP_E_CONCURRENT_DRAG_ATTEMPTED = 0x80040103;

enum : int
{
    CLASSFACTORY_E_LAST  = 0x8004011f,
    CLASSFACTORY_S_FIRST = 0x00040110,
    CLASSFACTORY_S_LAST  = 0x0004011f,
}

enum int CLASS_E_CLASSNOTAVAILABLE = 0x80040111;

enum : int
{
    MARSHAL_E_FIRST = 0x80040120,
    MARSHAL_E_LAST  = 0x8004012f,
    MARSHAL_S_FIRST = 0x00040120,
    MARSHAL_S_LAST  = 0x0004012f,
}

enum : int
{
    DATA_E_LAST  = 0x8004013f,
    DATA_S_FIRST = 0x00040130,
    DATA_S_LAST  = 0x0004013f,
}

enum : int
{
    VIEW_E_LAST  = 0x8004014f,
    VIEW_S_FIRST = 0x00040140,
    VIEW_S_LAST  = 0x0004014f,
    VIEW_E_DRAW  = 0x80040140,
}

enum : int
{
    REGDB_E_LAST         = 0x8004015f,
    REGDB_S_FIRST        = 0x00040150,
    REGDB_S_LAST         = 0x0004015f,
    REGDB_E_READREGDB    = 0x80040150,
    REGDB_E_WRITEREGDB   = 0x80040151,
    REGDB_E_KEYMISSING   = 0x80040152,
    REGDB_E_INVALIDVALUE = 0x80040153,
}

enum : int
{
    REGDB_E_IIDNOTREG         = 0x80040155,
    REGDB_E_BADTHREADINGMODEL = 0x80040156,
}

enum : int
{
    CAT_E_FIRST        = 0x80040160,
    CAT_E_LAST         = 0x80040161,
    CAT_E_CATIDNOEXIST = 0x80040160,
}

enum : int
{
    CS_E_FIRST            = 0x80040164,
    CS_E_LAST             = 0x8004016f,
    CS_E_PACKAGE_NOTFOUND = 0x80040164,
}

enum int CS_E_CLASS_NOTFOUND = 0x80040166;
enum int CS_E_NO_CLASSSTORE = 0x80040168;
enum int CS_E_OBJECT_ALREADY_EXISTS = 0x8004016a;
enum int CS_E_NETWORK_ERROR = 0x8004016c;
enum int CS_E_SCHEMA_MISMATCH = 0x8004016e;

enum : int
{
    CACHE_E_FIRST           = 0x80040170,
    CACHE_E_LAST            = 0x8004017f,
    CACHE_S_FIRST           = 0x00040170,
    CACHE_S_LAST            = 0x0004017f,
    CACHE_E_NOCACHE_UPDATED = 0x80040170,
}

enum : int
{
    OLEOBJ_E_LAST        = 0x8004018f,
    OLEOBJ_S_FIRST       = 0x00040180,
    OLEOBJ_S_LAST        = 0x0004018f,
    OLEOBJ_E_NOVERBS     = 0x80040180,
    OLEOBJ_E_INVALIDVERB = 0x80040181,
}

enum : int
{
    CLIENTSITE_E_LAST  = 0x8004019f,
    CLIENTSITE_S_FIRST = 0x00040190,
    CLIENTSITE_S_LAST  = 0x0004019f,
}

enum : int
{
    INPLACE_E_NOTOOLSPACE = 0x800401a1,
    INPLACE_E_FIRST       = 0x800401a0,
    INPLACE_E_LAST        = 0x800401af,
    INPLACE_S_FIRST       = 0x000401a0,
    INPLACE_S_LAST        = 0x000401af,
}

enum : int
{
    ENUM_E_LAST  = 0x800401bf,
    ENUM_S_FIRST = 0x000401b0,
    ENUM_S_LAST  = 0x000401bf,
}

enum : int
{
    CONVERT10_E_LAST                    = 0x800401cf,
    CONVERT10_S_FIRST                   = 0x000401c0,
    CONVERT10_S_LAST                    = 0x000401cf,
    CONVERT10_E_OLESTREAM_GET           = 0x800401c0,
    CONVERT10_E_OLESTREAM_PUT           = 0x800401c1,
    CONVERT10_E_OLESTREAM_FMT           = 0x800401c2,
    CONVERT10_E_OLESTREAM_BITMAP_TO_DIB = 0x800401c3,
}

enum : int
{
    CONVERT10_E_STG_NO_STD_STREAM = 0x800401c5,
    CONVERT10_E_STG_DIB_TO_BITMAP = 0x800401c6,
}

enum : int
{
    CLIPBRD_E_LAST       = 0x800401df,
    CLIPBRD_S_FIRST      = 0x000401d0,
    CLIPBRD_S_LAST       = 0x000401df,
    CLIPBRD_E_CANT_OPEN  = 0x800401d0,
    CLIPBRD_E_CANT_EMPTY = 0x800401d1,
    CLIPBRD_E_CANT_SET   = 0x800401d2,
    CLIPBRD_E_BAD_DATA   = 0x800401d3,
    CLIPBRD_E_CANT_CLOSE = 0x800401d4,
}

enum int MK_E_LAST = 0x800401ef;
enum int MK_S_LAST = 0x000401ef;
enum int MK_E_EXCEEDEDDEADLINE = 0x800401e1;
enum int MK_E_UNAVAILABLE = 0x800401e3;
enum int MK_E_NOOBJECT = 0x800401e5;
enum int MK_E_INTERMEDIATEINTERFACENOTSUPPORTED = 0x800401e7;
enum int MK_E_NOTBOUND = 0x800401e9;
enum int MK_E_MUSTBOTHERUSER = 0x800401eb;

enum : int
{
    MK_E_NOSTORAGE = 0x800401ed,
    MK_E_NOPREFIX  = 0x800401ee,
}

enum : int
{
    CO_E_FIRST = 0x800401f0,
    CO_E_LAST  = 0x800401ff,
}

enum int CO_S_LAST = 0x000401ff;
enum int CO_E_ALREADYINITIALIZED = 0x800401f1;
enum int CO_E_CLASSSTRING = 0x800401f3;

enum : int
{
    CO_E_APPNOTFOUND  = 0x800401f5,
    CO_E_APPSINGLEUSE = 0x800401f6,
}

enum int CO_E_DLLNOTFOUND = 0x800401f8;
enum int CO_E_WRONGOSFORAPP = 0x800401fa;

enum : int
{
    CO_E_OBJISREG        = 0x800401fc,
    CO_E_OBJNOTCONNECTED = 0x800401fd,
}

enum int CO_E_RELEASED = 0x800401ff;

enum : int
{
    EVENT_E_LAST                    = 0x8004021f,
    EVENT_S_FIRST                   = 0x00040200,
    EVENT_S_LAST                    = 0x0004021f,
    EVENT_S_SOME_SUBSCRIBERS_FAILED = 0x00040200,
}

enum int EVENT_S_NOSUBSCRIBERS = 0x00040202;

enum : int
{
    EVENT_E_QUERYFIELD           = 0x80040204,
    EVENT_E_INTERNALEXCEPTION    = 0x80040205,
    EVENT_E_INTERNALERROR        = 0x80040206,
    EVENT_E_INVALID_PER_USER_SID = 0x80040207,
}

enum int EVENT_E_TOO_MANY_METHODS = 0x80040209;
enum int EVENT_E_NOT_ALL_REMOVED = 0x8004020b;

enum : int
{
    EVENT_E_CANT_MODIFY_OR_DELETE_UNCONFIGURED_OBJECT = 0x8004020d,
    EVENT_E_CANT_MODIFY_OR_DELETE_CONFIGURED_OBJECT   = 0x8004020e,
}

enum int EVENT_E_PER_USER_SID_NOT_LOGGED_ON = 0x80040210;
enum int TPC_E_NO_DEFAULT_TABLET = 0x80040212;

enum : int
{
    TPC_E_INVALID_INPUT_RECT = 0x80040219,
    TPC_E_INVALID_STROKE     = 0x80040222,
}

enum int TPC_E_NOT_RELEVANT = 0x80040232;
enum int TPC_E_RECOGNIZER_NOT_REGISTERED = 0x80040235;
enum int TPC_E_OUT_OF_ORDER_CALL = 0x80040237;

enum : int
{
    TPC_E_INVALID_CONFIGURATION        = 0x80040239,
    TPC_E_INVALID_DATA_FROM_RECOGNIZER = 0x8004023a,
}

enum int TPC_S_INTERRUPTED = 0x00040253;

enum : uint
{
    XACT_E_FIRST = 0x8004d000,
    XACT_E_LAST  = 0x8004d02b,
}

enum : int
{
    XACT_S_LAST                    = 0x0004d010,
    XACT_E_ALREADYOTHERSINGLEPHASE = 0x8004d000,
}

enum : int
{
    XACT_E_COMMITFAILED    = 0x8004d002,
    XACT_E_COMMITPREVENTED = 0x8004d003,
}

enum : int
{
    XACT_E_HEURISTICCOMMIT = 0x8004d005,
    XACT_E_HEURISTICDAMAGE = 0x8004d006,
    XACT_E_HEURISTICDANGER = 0x8004d007,
}

enum : int
{
    XACT_E_NOASYNC       = 0x8004d009,
    XACT_E_NOENLIST      = 0x8004d00a,
    XACT_E_NOISORETAIN   = 0x8004d00b,
    XACT_E_NORESOURCE    = 0x8004d00c,
    XACT_E_NOTCURRENT    = 0x8004d00d,
    XACT_E_NOTRANSACTION = 0x8004d00e,
    XACT_E_NOTSUPPORTED  = 0x8004d00f,
}

enum : int
{
    XACT_E_WRONGSTATE  = 0x8004d011,
    XACT_E_WRONGUOW    = 0x8004d012,
    XACT_E_XTIONEXISTS = 0x8004d013,
}

enum : int
{
    XACT_E_INVALIDCOOKIE     = 0x8004d015,
    XACT_E_INDOUBT           = 0x8004d016,
    XACT_E_NOTIMEOUT         = 0x8004d017,
    XACT_E_ALREADYINPROGRESS = 0x8004d018,
}

enum : int
{
    XACT_E_LOGFULL        = 0x8004d01a,
    XACT_E_TMNOTAVAILABLE = 0x8004d01b,
}

enum int XACT_E_CONNECTION_DENIED = 0x8004d01d;

enum : int
{
    XACT_E_TIP_CONNECT_FAILED = 0x8004d01f,
    XACT_E_TIP_PROTOCOL_ERROR = 0x8004d020,
    XACT_E_TIP_PULL_FAILED    = 0x8004d021,
}

enum int XACT_E_TIP_DISABLED = 0x8004d023;
enum int XACT_E_PARTNER_NETWORK_TX_DISABLED = 0x8004d025;

enum : int
{
    XACT_E_UNABLE_TO_READ_DTC_CONFIG = 0x8004d027,
    XACT_E_UNABLE_TO_LOAD_DTC_PROXY  = 0x8004d028,
}

enum int XACT_E_PUSH_COMM_FAILURE = 0x8004d02a;
enum int XACT_E_LU_TX_DISABLED = 0x8004d02c;
enum int XACT_E_CLERKEXISTS = 0x8004d081;
enum int XACT_E_TRANSACTIONCLOSED = 0x8004d083;
enum int XACT_E_REPLAYREQUEST = 0x8004d085;

enum : int
{
    XACT_S_DEFECT       = 0x0004d001,
    XACT_S_READONLY     = 0x0004d002,
    XACT_S_SOMENORETAIN = 0x0004d003,
}

enum : int
{
    XACT_S_MADECHANGESCONTENT = 0x0004d005,
    XACT_S_MADECHANGESINFORM  = 0x0004d006,
}

enum : int
{
    XACT_S_ABORTING    = 0x0004d008,
    XACT_S_SINGLEPHASE = 0x0004d009,
}

enum int XACT_S_LASTRESOURCEMANAGER = 0x0004d010;

enum : int
{
    CONTEXT_E_LAST           = 0x8004e02f,
    CONTEXT_S_FIRST          = 0x0004e000,
    CONTEXT_S_LAST           = 0x0004e02f,
    CONTEXT_E_ABORTED        = 0x8004e002,
    CONTEXT_E_ABORTING       = 0x8004e003,
    CONTEXT_E_NOCONTEXT      = 0x8004e004,
    CONTEXT_E_WOULD_DEADLOCK = 0x8004e005,
    CONTEXT_E_SYNCH_TIMEOUT  = 0x8004e006,
    CONTEXT_E_OLDREF         = 0x8004e007,
    CONTEXT_E_ROLENOTFOUND   = 0x8004e00c,
    CONTEXT_E_TMNOTAVAILABLE = 0x8004e00f,
}

enum : int
{
    CO_E_ACTIVATIONFAILED_EVENTLOGGED  = 0x8004e022,
    CO_E_ACTIVATIONFAILED_CATALOGERROR = 0x8004e023,
    CO_E_ACTIVATIONFAILED_TIMEOUT      = 0x8004e024,
}

enum : int
{
    CONTEXT_E_NOJIT         = 0x8004e026,
    CONTEXT_E_NOTRANSACTION = 0x8004e027,
}

enum int CO_E_NOIISINTRINSICS = 0x8004e029;

enum : int
{
    CO_E_DBERROR        = 0x8004e02b,
    CO_E_NOTPOOLED      = 0x8004e02c,
    CO_E_NOTCONSTRUCTED = 0x8004e02d,
}

enum int CO_E_ISOLEVELMISMATCH = 0x8004e02f;
enum int CO_E_EXIT_TRANSACTION_SCOPE_NOT_CALLED = 0x8004e031;

enum : int
{
    OLE_S_STATIC         = 0x00040001,
    OLE_S_MAC_CLIPFORMAT = 0x00040002,
}

enum : int
{
    DRAGDROP_S_CANCEL            = 0x00040101,
    DRAGDROP_S_USEDEFAULTCURSORS = 0x00040102,
}

enum int VIEW_S_ALREADY_FROZEN = 0x00040140;

enum : int
{
    CACHE_S_SAMECACHE             = 0x00040171,
    CACHE_S_SOMECACHES_NOTUPDATED = 0x00040172,
}

enum int OLEOBJ_S_CANNOT_DOVERB_NOW = 0x00040181;
enum int INPLACE_S_TRUNCATED = 0x000401a0;
enum int MK_S_REDUCED_TO_SELF = 0x000401e2;

enum : int
{
    MK_S_HIM                      = 0x000401e5,
    MK_S_US                       = 0x000401e6,
    MK_S_MONIKERALREADYREGISTERED = 0x000401e7,
}

enum : int
{
    SCHED_S_TASK_RUNNING           = 0x00041301,
    SCHED_S_TASK_DISABLED          = 0x00041302,
    SCHED_S_TASK_HAS_NOT_RUN       = 0x00041303,
    SCHED_S_TASK_NO_MORE_RUNS      = 0x00041304,
    SCHED_S_TASK_NOT_SCHEDULED     = 0x00041305,
    SCHED_S_TASK_TERMINATED        = 0x00041306,
    SCHED_S_TASK_NO_VALID_TRIGGERS = 0x00041307,
}

enum int SCHED_E_TRIGGER_NOT_FOUND = 0x80041309;
enum int SCHED_E_TASK_NOT_RUNNING = 0x8004130b;
enum int SCHED_E_CANNOT_OPEN_TASK = 0x8004130d;

enum : int
{
    SCHED_E_ACCOUNT_INFORMATION_NOT_SET = 0x8004130f,
    SCHED_E_ACCOUNT_NAME_NOT_FOUND      = 0x80041310,
    SCHED_E_ACCOUNT_DBASE_CORRUPT       = 0x80041311,
}

enum int SCHED_E_UNKNOWN_OBJECT_VERSION = 0x80041313;
enum int SCHED_E_SERVICE_NOT_RUNNING = 0x80041315;

enum : int
{
    SCHED_E_NAMESPACE    = 0x80041317,
    SCHED_E_INVALIDVALUE = 0x80041318,
}

enum int SCHED_E_MALFORMEDXML = 0x8004131a;
enum int SCHED_S_BATCH_LOGON_PROBLEM = 0x0004131c;
enum int SCHED_E_PAST_END_BOUNDARY = 0x8004131e;
enum int SCHED_E_USER_NOT_LOGGED_ON = 0x80041320;

enum : int
{
    SCHED_E_SERVICE_NOT_AVAILABLE = 0x80041322,
    SCHED_E_SERVICE_TOO_BUSY      = 0x80041323,
}

enum int SCHED_S_TASK_QUEUED = 0x00041325;
enum int SCHED_E_TASK_NOT_V1_COMPAT = 0x80041327;
enum int SCHED_E_TASK_NOT_UBPM_COMPAT = 0x80041329;
enum int CO_E_CLASS_CREATE_FAILED = 0x80080001;
enum int CO_E_SCM_RPC_FAILURE = 0x80080003;
enum int CO_E_SERVER_EXEC_FAILURE = 0x80080005;
enum int MK_E_NO_NORMALIZED = 0x80080007;

enum : int
{
    MEM_E_INVALID_ROOT = 0x80080009,
    MEM_E_INVALID_LINK = 0x80080010,
    MEM_E_INVALID_SIZE = 0x80080011,
}

enum int CO_S_MACHINENAMENOTFOUND = 0x00080013;
enum int CO_E_RUNAS_VALUE_MUST_BE_AAA = 0x80080016;
enum int APPX_E_PACKAGING_INTERNAL = 0x80080200;
enum int APPX_E_RELATIONSHIPS_NOT_ALLOWED = 0x80080202;

enum : int
{
    APPX_E_INVALID_MANIFEST = 0x80080204,
    APPX_E_INVALID_BLOCKMAP = 0x80080205,
}

enum int APPX_E_BLOCK_HASH_INVALID = 0x80080207;

enum : int
{
    APPX_E_INVALID_SIP_CLIENT_DATA = 0x80080209,
    APPX_E_INVALID_KEY_INFO        = 0x8008020a,
    APPX_E_INVALID_CONTENTGROUPMAP = 0x8008020b,
    APPX_E_INVALID_APPINSTALLER    = 0x8008020c,
}

enum int APPX_E_DELTA_PACKAGE_MISSING_FILE = 0x8008020e;
enum int APPX_E_DELTA_APPENDED_PACKAGE_NOT_ALLOWED = 0x80080210;
enum int APPX_E_INVALID_PACKAGESIGNCONFIG = 0x80080212;
enum int APPX_E_FILE_COMPRESSION_MISMATCH = 0x80080214;
enum int APPX_E_INVALID_ENCRYPTION_EXCLUSION_FILE_LIST = 0x80080216;
enum int DISP_E_UNKNOWNINTERFACE = 0x80020001;
enum int DISP_E_PARAMNOTFOUND = 0x80020004;
enum int DISP_E_UNKNOWNNAME = 0x80020006;

enum : int
{
    DISP_E_BADVARTYPE  = 0x80020008,
    DISP_E_EXCEPTION   = 0x80020009,
    DISP_E_OVERFLOW    = 0x8002000a,
    DISP_E_BADINDEX    = 0x8002000b,
    DISP_E_UNKNOWNLCID = 0x8002000c,
}

enum int DISP_E_BADPARAMCOUNT = 0x8002000e;

enum : int
{
    DISP_E_BADCALLEE      = 0x80020010,
    DISP_E_NOTACOLLECTION = 0x80020011,
}

enum int DISP_E_BUFFERTOOSMALL = 0x80020013;
enum int TYPE_E_FIELDNOTFOUND = 0x80028017;
enum int TYPE_E_UNSUPFORMAT = 0x80028019;
enum int TYPE_E_LIBNOTREGISTERED = 0x8002801d;
enum int TYPE_E_QUALIFIEDNAMEDISALLOWED = 0x80028028;
enum int TYPE_E_WRONGTYPEKIND = 0x8002802a;
enum int TYPE_E_AMBIGUOUSNAME = 0x8002802c;
enum int TYPE_E_UNKNOWNLCID = 0x8002802e;
enum int TYPE_E_BADMODULEKIND = 0x800288bd;
enum int TYPE_E_DUPLICATEID = 0x800288c6;
enum int TYPE_E_TYPEMISMATCH = 0x80028ca0;

enum : int
{
    TYPE_E_IOERROR           = 0x80028ca2,
    TYPE_E_CANTCREATETMPFILE = 0x80028ca3,
    TYPE_E_CANTLOADLIBRARY   = 0x80029c4a,
}

enum int TYPE_E_CIRCULARTYPE = 0x80029c84;
enum int STG_E_FILENOTFOUND = 0x80030002;
enum int STG_E_TOOMANYOPENFILES = 0x80030004;

enum : int
{
    STG_E_INVALIDHANDLE      = 0x80030006,
    STG_E_INSUFFICIENTMEMORY = 0x80030008,
}

enum int STG_E_NOMOREFILES = 0x80030012;
enum int STG_E_SEEKERROR = 0x80030019;
enum int STG_E_READFAULT = 0x8003001e;
enum int STG_E_LOCKVIOLATION = 0x80030021;
enum int STG_E_INVALIDPARAMETER = 0x80030057;
enum int STG_E_PROPSETMISMATCHED = 0x800300f0;

enum : int
{
    STG_E_INVALIDHEADER = 0x800300fb,
    STG_E_INVALIDNAME   = 0x800300fc,
}

enum int STG_E_UNIMPLEMENTEDFUNCTION = 0x800300fe;

enum : int
{
    STG_E_INUSE      = 0x80030100,
    STG_E_NOTCURRENT = 0x80030101,
}

enum : int
{
    STG_E_CANTSAVE      = 0x80030103,
    STG_E_OLDFORMAT     = 0x80030104,
    STG_E_OLDDLL        = 0x80030105,
    STG_E_SHAREREQUIRED = 0x80030106,
}

enum int STG_E_EXTANTMARSHALLINGS = 0x80030108;
enum int STG_E_BADBASEADDRESS = 0x80030110;
enum int STG_E_NOTSIMPLEFORMAT = 0x80030112;
enum int STG_E_TERMINATED = 0x80030202;

enum : int
{
    STG_S_BLOCK         = 0x00030201,
    STG_S_RETRYNOW      = 0x00030202,
    STG_S_MONITORING    = 0x00030203,
    STG_S_MULTIPLEOPENS = 0x00030204,
}

enum int STG_S_CANNOTCONSOLIDATE = 0x00030206;

enum : int
{
    STG_E_FIRMWARE_SLOT_INVALID  = 0x80030208,
    STG_E_FIRMWARE_IMAGE_INVALID = 0x80030209,
}

enum int STG_E_STATUS_COPY_PROTECTION_FAILURE = 0x80030305;

enum : int
{
    STG_E_CSS_KEY_NOT_PRESENT     = 0x80030307,
    STG_E_CSS_KEY_NOT_ESTABLISHED = 0x80030308,
}

enum int STG_E_CSS_REGION_MISMATCH = 0x8003030a;

enum : int
{
    RPC_E_CALL_REJECTED       = 0x80010001,
    RPC_E_CALL_CANCELED       = 0x80010002,
    RPC_E_CANTPOST_INSENDCALL = 0x80010003,
}

enum int RPC_E_CANTCALLOUT_INEXTERNALCALL = 0x80010005;
enum int RPC_E_SERVER_DIED = 0x80010007;
enum int RPC_E_INVALID_DATAPACKET = 0x80010009;

enum : int
{
    RPC_E_CLIENT_CANTMARSHAL_DATA   = 0x8001000b,
    RPC_E_CLIENT_CANTUNMARSHAL_DATA = 0x8001000c,
}

enum int RPC_E_SERVER_CANTUNMARSHAL_DATA = 0x8001000e;
enum int RPC_E_INVALID_PARAMETER = 0x80010010;
enum int RPC_E_SERVER_DIED_DNE = 0x80010012;
enum int RPC_E_OUT_OF_RESOURCES = 0x80010101;
enum int RPC_E_NOT_REGISTERED = 0x80010103;
enum int RPC_E_SERVERFAULT = 0x80010105;
enum int RPC_E_INVALIDMETHOD = 0x80010107;

enum : int
{
    RPC_E_RETRY                 = 0x80010109,
    RPC_E_SERVERCALL_RETRYLATER = 0x8001010a,
    RPC_E_SERVERCALL_REJECTED   = 0x8001010b,
}

enum int RPC_E_CANTCALLOUT_ININPUTSYNCCALL = 0x8001010d;
enum int RPC_E_THREAD_NOT_INIT = 0x8001010f;

enum : int
{
    RPC_E_INVALID_HEADER    = 0x80010111,
    RPC_E_INVALID_EXTENSION = 0x80010112,
    RPC_E_INVALID_IPID      = 0x80010113,
    RPC_E_INVALID_OBJECT    = 0x80010114,
}

enum int RPC_S_WAITONTIMER = 0x80010116;
enum int RPC_E_UNSECURE_CALL = 0x80010118;
enum int RPC_E_NO_GOOD_SECURITY_PACKAGES = 0x8001011a;
enum int RPC_E_REMOTE_DISABLED = 0x8001011c;
enum int RPC_E_NO_CONTEXT = 0x8001011e;

enum : int
{
    RPC_E_NO_SYNC          = 0x80010120,
    RPC_E_FULLSIC_REQUIRED = 0x80010121,
}

enum : int
{
    CO_E_FAILEDTOIMPERSONATE     = 0x80010123,
    CO_E_FAILEDTOGETSECCTX       = 0x80010124,
    CO_E_FAILEDTOOPENTHREADTOKEN = 0x80010125,
    CO_E_FAILEDTOGETTOKENINFO    = 0x80010126,
}

enum : int
{
    CO_E_FAILEDTOQUERYCLIENTBLANKET = 0x80010128,
    CO_E_FAILEDTOSETDACL            = 0x80010129,
}

enum int CO_E_NETACCESSAPIFAILED = 0x8001012b;
enum int CO_E_INVALIDSID = 0x8001012d;
enum int CO_E_NOMATCHINGSIDFOUND = 0x8001012f;
enum int CO_E_NOMATCHINGNAMEFOUND = 0x80010131;
enum int CO_E_SETSERLHNDLFAILED = 0x80010133;
enum int CO_E_PATHTOOLONG = 0x80010135;

enum : int
{
    CO_E_FAILEDTOCREATEFILE  = 0x80010137,
    CO_E_FAILEDTOCLOSEHANDLE = 0x80010138,
}

enum int CO_E_ACESINWRONGORDER = 0x8001013a;
enum int CO_E_FAILEDTOOPENPROCESSTOKEN = 0x8001013c;
enum int CO_E_ACNOTINITIALIZED = 0x8001013f;
enum int RPC_E_UNEXPECTED = 0x8001ffff;
enum int ERROR_ALL_SIDS_FILTERED = 0xc0090002;

enum : int
{
    NTE_BAD_UID        = 0x80090001,
    NTE_BAD_HASH       = 0x80090002,
    NTE_BAD_KEY        = 0x80090003,
    NTE_BAD_LEN        = 0x80090004,
    NTE_BAD_DATA       = 0x80090005,
    NTE_BAD_SIGNATURE  = 0x80090006,
    NTE_BAD_VER        = 0x80090007,
    NTE_BAD_ALGID      = 0x80090008,
    NTE_BAD_FLAGS      = 0x80090009,
    NTE_BAD_TYPE       = 0x8009000a,
    NTE_BAD_KEY_STATE  = 0x8009000b,
    NTE_BAD_HASH_STATE = 0x8009000c,
}

enum int NTE_NO_MEMORY = 0x8009000e;

enum : int
{
    NTE_PERM      = 0x80090010,
    NTE_NOT_FOUND = 0x80090011,
}

enum : int
{
    NTE_BAD_PROVIDER   = 0x80090013,
    NTE_BAD_PROV_TYPE  = 0x80090014,
    NTE_BAD_PUBLIC_KEY = 0x80090015,
    NTE_BAD_KEYSET     = 0x80090016,
}

enum int NTE_PROV_TYPE_ENTRY_BAD = 0x80090018;
enum int NTE_KEYSET_ENTRY_BAD = 0x8009001a;
enum int NTE_SIGNATURE_FILE_BAD = 0x8009001c;
enum int NTE_PROV_DLL_NOT_FOUND = 0x8009001e;

enum : int
{
    NTE_FAIL           = 0x80090020,
    NTE_SYS_ERR        = 0x80090021,
    NTE_SILENT_CONTEXT = 0x80090022,
}

enum int NTE_TEMPORARY_PROFILE = 0x80090024;

enum : int
{
    NTE_INVALID_HANDLE    = 0x80090026,
    NTE_INVALID_PARAMETER = 0x80090027,
}

enum int NTE_NOT_SUPPORTED = 0x80090029;
enum int NTE_BUFFERS_OVERLAP = 0x8009002b;
enum int NTE_INTERNAL_ERROR = 0x8009002d;
enum int NTE_HMAC_NOT_SUPPORTED = 0x8009002f;
enum int NTE_AUTHENTICATION_IGNORED = 0x80090031;
enum int NTE_INCORRECT_PASSWORD = 0x80090033;
enum int NTE_DEVICE_NOT_FOUND = 0x80090035;
enum int NTE_PASSWORD_CHANGE_REQUIRED = 0x80090037;
enum int SEC_E_INSUFFICIENT_MEMORY = 0x80090300;
enum int SEC_E_UNSUPPORTED_FUNCTION = 0x80090302;
enum int SEC_E_INTERNAL_ERROR = 0x80090304;
enum int SEC_E_NOT_OWNER = 0x80090306;
enum int SEC_E_INVALID_TOKEN = 0x80090308;
enum int SEC_E_QOP_NOT_SUPPORTED = 0x8009030a;
enum int SEC_E_LOGON_DENIED = 0x8009030c;
enum int SEC_E_NO_CREDENTIALS = 0x8009030e;
enum int SEC_E_OUT_OF_SEQUENCE = 0x80090310;
enum int SEC_I_CONTINUE_NEEDED = 0x00090312;
enum int SEC_I_COMPLETE_AND_CONTINUE = 0x00090314;
enum int SEC_I_GENERIC_EXTENSION_RECEIVED = 0x00090316;
enum int SEC_E_CONTEXT_EXPIRED = 0x80090317;

enum : int
{
    SEC_E_INCOMPLETE_MESSAGE     = 0x80090318,
    SEC_E_INCOMPLETE_CREDENTIALS = 0x80090320,
}

enum int SEC_I_INCOMPLETE_CREDENTIALS = 0x00090320;
enum int SEC_E_WRONG_PRINCIPAL = 0x80090322;
enum int SEC_E_TIME_SKEW = 0x80090324;
enum int SEC_E_ILLEGAL_MESSAGE = 0x80090326;
enum int SEC_E_CERT_EXPIRED = 0x80090328;
enum int SEC_E_DECRYPT_FAILURE = 0x80090330;
enum int SEC_E_SECURITY_QOS_FAILED = 0x80090332;

enum : int
{
    SEC_E_NO_TGT_REPLY    = 0x80090334,
    SEC_E_NO_IP_ADDRESSES = 0x80090335,
}

enum int SEC_E_CRYPTO_SYSTEM_INVALID = 0x80090337;
enum int SEC_E_MUST_BE_KDC = 0x80090339;
enum int SEC_E_TOO_MANY_PRINCIPALS = 0x8009033b;
enum int SEC_E_PKINIT_NAME_MISMATCH = 0x8009033d;
enum int SEC_E_SHUTDOWN_IN_PROGRESS = 0x8009033f;

enum : int
{
    SEC_E_KDC_UNABLE_TO_REFER = 0x80090341,
    SEC_E_KDC_UNKNOWN_ETYPE   = 0x80090342,
}

enum int SEC_E_DELEGATION_REQUIRED = 0x80090345;
enum int SEC_E_MULTIPLE_ACCOUNTS = 0x80090347;
enum int SEC_E_CERT_WRONG_USAGE = 0x80090349;
enum int SEC_E_SMARTCARD_CERT_REVOKED = 0x80090351;
enum int SEC_E_REVOCATION_OFFLINE_C = 0x80090353;
enum int SEC_E_SMARTCARD_CERT_EXPIRED = 0x80090355;
enum int SEC_E_CROSSREALM_DELEGATION_FAILURE = 0x80090357;
enum int SEC_E_ISSUING_CA_UNTRUSTED_KDC = 0x80090359;
enum int SEC_E_KDC_CERT_REVOKED = 0x8009035b;
enum int SEC_E_INVALID_PARAMETER = 0x8009035d;
enum int SEC_E_POLICY_NLTM_ONLY = 0x8009035f;
enum int SEC_E_NO_CONTEXT = 0x80090361;
enum int SEC_E_MUTUAL_AUTH_FAILED = 0x80090363;
enum int SEC_E_ONLY_HTTPS_ALLOWED = 0x80090365;
enum int SEC_E_APPLICATION_PROTOCOL_MISMATCH = 0x80090367;
enum int SEC_E_INVALID_UPN_NAME = 0x80090369;
enum int SEC_E_INSUFFICIENT_BUFFERS = 0x8009036b;
enum int CRYPT_E_UNKNOWN_ALGO = 0x80091002;
enum int CRYPT_E_INVALID_MSG_TYPE = 0x80091004;
enum int CRYPT_E_AUTH_ATTR_MISSING = 0x80091006;
enum int CRYPT_E_INVALID_INDEX = 0x80091008;
enum int CRYPT_E_NOT_DECRYPTED = 0x8009100a;
enum int CRYPT_E_CONTROL_TYPE = 0x8009100c;
enum int CRYPT_E_SIGNER_NOT_FOUND = 0x8009100e;

enum : int
{
    CRYPT_E_STREAM_MSG_NOT_READY     = 0x80091010,
    CRYPT_E_STREAM_INSUFFICIENT_DATA = 0x80091011,
}

enum : int
{
    CRYPT_E_BAD_LEN      = 0x80092001,
    CRYPT_E_BAD_ENCODE   = 0x80092002,
    CRYPT_E_FILE_ERROR   = 0x80092003,
    CRYPT_E_NOT_FOUND    = 0x80092004,
    CRYPT_E_EXISTS       = 0x80092005,
    CRYPT_E_NO_PROVIDER  = 0x80092006,
    CRYPT_E_SELF_SIGNED  = 0x80092007,
    CRYPT_E_DELETED_PREV = 0x80092008,
}

enum int CRYPT_E_UNEXPECTED_MSG_TYPE = 0x8009200a;
enum int CRYPT_E_NO_DECRYPT_CERT = 0x8009200c;

enum : int
{
    CRYPT_E_NO_SIGNER     = 0x8009200e,
    CRYPT_E_PENDING_CLOSE = 0x8009200f,
}

enum : int
{
    CRYPT_E_NO_REVOCATION_DLL   = 0x80092011,
    CRYPT_E_NO_REVOCATION_CHECK = 0x80092012,
}

enum int CRYPT_E_NOT_IN_REVOCATION_DATABASE = 0x80092014;

enum : int
{
    CRYPT_E_INVALID_PRINTABLE_STRING = 0x80092021,
    CRYPT_E_INVALID_IA5_STRING       = 0x80092022,
    CRYPT_E_INVALID_X500_STRING      = 0x80092023,
}

enum : int
{
    CRYPT_E_FILERESIZED       = 0x80092025,
    CRYPT_E_SECURITY_SETTINGS = 0x80092026,
}

enum int CRYPT_E_NO_VERIFY_USAGE_CHECK = 0x80092028;

enum : int
{
    CRYPT_E_NOT_IN_CTL        = 0x8009202a,
    CRYPT_E_NO_TRUSTED_SIGNER = 0x8009202b,
}

enum int CRYPT_E_OBJECT_LOCATOR_OBJECT_NOT_FOUND = 0x8009202d;
enum int OSS_MORE_BUF = 0x80093001;
enum int OSS_PDU_RANGE = 0x80093003;
enum int OSS_DATA_ERROR = 0x80093005;
enum int OSS_BAD_VERSION = 0x80093007;
enum int OSS_PDU_MISMATCH = 0x80093009;

enum : int
{
    OSS_BAD_PTR  = 0x8009300b,
    OSS_BAD_TIME = 0x8009300c,
}

enum int OSS_MEM_ERROR = 0x8009300e;
enum int OSS_TOO_LONG = 0x80093010;
enum int OSS_FATAL_ERROR = 0x80093012;

enum : int
{
    OSS_NULL_TBL = 0x80093014,
    OSS_NULL_FCN = 0x80093015,
}

enum int OSS_UNAVAIL_ENCRULES = 0x80093017;
enum int OSS_UNIMPLEMENTED = 0x80093019;
enum int OSS_CANT_OPEN_TRACE_FILE = 0x8009301b;
enum int OSS_TABLE_MISMATCH = 0x8009301d;
enum int OSS_REAL_DLL_NOT_LINKED = 0x8009301f;
enum int OSS_OUT_OF_RANGE = 0x80093021;
enum int OSS_CONSTRAINT_DLL_NOT_LINKED = 0x80093023;
enum int OSS_COMPARATOR_CODE_NOT_LINKED = 0x80093025;
enum int OSS_PDV_DLL_NOT_LINKED = 0x80093027;
enum int OSS_API_DLL_NOT_LINKED = 0x80093029;
enum int OSS_PER_DLL_NOT_LINKED = 0x8009302b;
enum int OSS_MUTEX_NOT_CREATED = 0x8009302d;

enum : int
{
    CRYPT_E_ASN1_ERROR      = 0x80093100,
    CRYPT_E_ASN1_INTERNAL   = 0x80093101,
    CRYPT_E_ASN1_EOD        = 0x80093102,
    CRYPT_E_ASN1_CORRUPT    = 0x80093103,
    CRYPT_E_ASN1_LARGE      = 0x80093104,
    CRYPT_E_ASN1_CONSTRAINT = 0x80093105,
    CRYPT_E_ASN1_MEMORY     = 0x80093106,
    CRYPT_E_ASN1_OVERFLOW   = 0x80093107,
    CRYPT_E_ASN1_BADPDU     = 0x80093108,
    CRYPT_E_ASN1_BADARGS    = 0x80093109,
    CRYPT_E_ASN1_BADREAL    = 0x8009310a,
    CRYPT_E_ASN1_BADTAG     = 0x8009310b,
    CRYPT_E_ASN1_CHOICE     = 0x8009310c,
    CRYPT_E_ASN1_RULE       = 0x8009310d,
    CRYPT_E_ASN1_UTF8       = 0x8009310e,
    CRYPT_E_ASN1_PDU_TYPE   = 0x80093133,
    CRYPT_E_ASN1_NYI        = 0x80093134,
    CRYPT_E_ASN1_EXTENDED   = 0x80093201,
    CRYPT_E_ASN1_NOEOD      = 0x80093202,
}

enum : int
{
    CERTSRV_E_NO_REQUEST        = 0x80094002,
    CERTSRV_E_BAD_REQUESTSTATUS = 0x80094003,
}

enum int CERTSRV_E_INVALID_CA_CERTIFICATE = 0x80094005;
enum int CERTSRV_E_ENCODING_LENGTH = 0x80094007;
enum int CERTSRV_E_RESTRICTEDOFFICER = 0x80094009;

enum : int
{
    CERTSRV_E_NO_VALID_KRA             = 0x8009400b,
    CERTSRV_E_BAD_REQUEST_KEY_ARCHIVAL = 0x8009400c,
}

enum int CERTSRV_E_BAD_RENEWAL_CERT_ATTRIBUTE = 0x8009400e;
enum int CERTSRV_E_ALIGNMENT_FAULT = 0x80094010;
enum int CERTSRV_E_TEMPLATE_DENIED = 0x80094012;
enum int CERTSRV_E_ADMIN_DENIED_REQUEST = 0x80094014;
enum int CERTSRV_E_WEAK_SIGNATURE_OR_KEY = 0x80094016;
enum int CERTSRV_E_ENCRYPTION_CERT_REQUIRED = 0x80094018;

enum : int
{
    CERTSRV_E_NO_CERT_TYPE      = 0x80094801,
    CERTSRV_E_TEMPLATE_CONFLICT = 0x80094802,
}

enum int CERTSRV_E_ARCHIVED_KEY_REQUIRED = 0x80094804;

enum : int
{
    CERTSRV_E_BAD_RENEWAL_SUBJECT  = 0x80094806,
    CERTSRV_E_BAD_TEMPLATE_VERSION = 0x80094807,
}

enum : int
{
    CERTSRV_E_SIGNATURE_POLICY_REQUIRED = 0x80094809,
    CERTSRV_E_SIGNATURE_COUNT           = 0x8009480a,
    CERTSRV_E_SIGNATURE_REJECTED        = 0x8009480b,
}

enum : int
{
    CERTSRV_E_SUBJECT_UPN_REQUIRED            = 0x8009480d,
    CERTSRV_E_SUBJECT_DIRECTORY_GUID_REQUIRED = 0x8009480e,
    CERTSRV_E_SUBJECT_DNS_REQUIRED            = 0x8009480f,
}

enum : int
{
    CERTSRV_E_KEY_LENGTH             = 0x80094811,
    CERTSRV_E_SUBJECT_EMAIL_REQUIRED = 0x80094812,
}

enum int CERTSRV_E_CERT_TYPE_OVERLAP = 0x80094814;
enum int CERTSRV_E_RENEWAL_BAD_PUBLIC_KEY = 0x80094816;

enum : int
{
    CERTSRV_E_INVALID_IDBINDING   = 0x80094818,
    CERTSRV_E_INVALID_ATTESTATION = 0x80094819,
}

enum int CERTSRV_E_CORRUPT_KEY_ATTESTATION = 0x8009481b;

enum : int
{
    CERTSRV_E_INVALID_RESPONSE  = 0x8009481d,
    CERTSRV_E_INVALID_REQUESTID = 0x8009481e,
}

enum int CERTSRV_E_PENDING_CLIENT_RESPONSE = 0x80094820;
enum int XENROLL_E_CANNOT_ADD_ROOT_CERT = 0x80095001;

enum : int
{
    XENROLL_E_RESPONSE_UNEXPECTED_KA_HASH = 0x80095003,
    XENROLL_E_RESPONSE_KA_HASH_MISMATCH   = 0x80095004,
}

enum int TRUST_E_SYSTEM_ERROR = 0x80096001;

enum : int
{
    TRUST_E_COUNTER_SIGNER = 0x80096003,
    TRUST_E_CERT_SIGNATURE = 0x80096004,
}

enum : int
{
    TRUST_E_BAD_DIGEST          = 0x80096010,
    TRUST_E_MALFORMED_SIGNATURE = 0x80096011,
}

enum int TRUST_E_FINANCIAL_CRITERIA = 0x8009601e;

enum : int
{
    MSSIPOTF_E_CANTGETOBJECT             = 0x80097002,
    MSSIPOTF_E_NOHEADTABLE               = 0x80097003,
    MSSIPOTF_E_BAD_MAGICNUMBER           = 0x80097004,
    MSSIPOTF_E_BAD_OFFSET_TABLE          = 0x80097005,
    MSSIPOTF_E_TABLE_TAGORDER            = 0x80097006,
    MSSIPOTF_E_TABLE_LONGWORD            = 0x80097007,
    MSSIPOTF_E_BAD_FIRST_TABLE_PLACEMENT = 0x80097008,
}

enum : int
{
    MSSIPOTF_E_TABLE_PADBYTES     = 0x8009700a,
    MSSIPOTF_E_FILETOOSMALL       = 0x8009700b,
    MSSIPOTF_E_TABLE_CHECKSUM     = 0x8009700c,
    MSSIPOTF_E_FILE_CHECKSUM      = 0x8009700d,
    MSSIPOTF_E_FAILED_POLICY      = 0x80097010,
    MSSIPOTF_E_FAILED_HINTS_CHECK = 0x80097011,
}

enum : int
{
    MSSIPOTF_E_FILE           = 0x80097013,
    MSSIPOTF_E_CRYPT          = 0x80097014,
    MSSIPOTF_E_BADVERSION     = 0x80097015,
    MSSIPOTF_E_DSIG_STRUCTURE = 0x80097016,
    MSSIPOTF_E_PCONST_CHECK   = 0x80097017,
    MSSIPOTF_E_STRUCTURE      = 0x80097018,
}

enum int NTE_OP_OK = 0x00000000;
enum int TRUST_E_ACTION_UNKNOWN = 0x800b0002;
enum int TRUST_E_SUBJECT_NOT_TRUSTED = 0x800b0004;

enum : int
{
    DIGSIG_E_DECODE        = 0x800b0006,
    DIGSIG_E_EXTENSIBILITY = 0x800b0007,
    DIGSIG_E_CRYPTO        = 0x800b0008,
}

enum : int
{
    PERSIST_E_SIZEINDEFINITE = 0x800b000a,
    PERSIST_E_NOTSELFSIZING  = 0x800b000b,
}

enum : int
{
    CERT_E_EXPIRED               = 0x800b0101,
    CERT_E_VALIDITYPERIODNESTING = 0x800b0102,
}

enum int CERT_E_PATHLENCONST = 0x800b0104;

enum : int
{
    CERT_E_PURPOSE        = 0x800b0106,
    CERT_E_ISSUERCHAINING = 0x800b0107,
}

enum int CERT_E_UNTRUSTEDROOT = 0x800b0109;
enum int TRUST_E_FAIL = 0x800b010b;
enum int CERT_E_UNTRUSTEDTESTROOT = 0x800b010d;
enum int CERT_E_CN_NO_MATCH = 0x800b010f;
enum int TRUST_E_EXPLICIT_DISTRUST = 0x800b0111;

enum : int
{
    CERT_E_INVALID_POLICY = 0x800b0113,
    CERT_E_INVALID_NAME   = 0x800b0114,
}

enum int SPAPI_E_BAD_SECTION_NAME_LINE = 0x800f0001;
enum int SPAPI_E_GENERAL_SYNTAX = 0x800f0003;
enum int SPAPI_E_SECTION_NOT_FOUND = 0x800f0101;

enum : int
{
    SPAPI_E_NO_BACKUP           = 0x800f0103,
    SPAPI_E_NO_ASSOCIATED_CLASS = 0x800f0200,
}

enum int SPAPI_E_DUPLICATE_FOUND = 0x800f0202;
enum int SPAPI_E_KEY_DOES_NOT_EXIST = 0x800f0204;
enum int SPAPI_E_INVALID_CLASS = 0x800f0206;
enum int SPAPI_E_DEVINFO_NOT_REGISTERED = 0x800f0208;

enum : int
{
    SPAPI_E_NO_INF          = 0x800f020a,
    SPAPI_E_NO_SUCH_DEVINST = 0x800f020b,
}

enum int SPAPI_E_INVALID_CLASS_INSTALLER = 0x800f020d;
enum int SPAPI_E_DI_NOFILECOPY = 0x800f020f;
enum int SPAPI_E_NO_DEVICE_SELECTED = 0x800f0211;
enum int SPAPI_E_DEVINFO_DATA_LOCKED = 0x800f0213;
enum int SPAPI_E_NO_CLASSINSTALL_PARAMS = 0x800f0215;
enum int SPAPI_E_BAD_SERVICE_INSTALLSECT = 0x800f0217;
enum int SPAPI_E_NO_ASSOCIATED_SERVICE = 0x800f0219;

enum : int
{
    SPAPI_E_DEVICE_INTERFACE_ACTIVE  = 0x800f021b,
    SPAPI_E_DEVICE_INTERFACE_REMOVED = 0x800f021c,
}

enum int SPAPI_E_NO_SUCH_INTERFACE_CLASS = 0x800f021e;
enum int SPAPI_E_INVALID_MACHINENAME = 0x800f0220;
enum int SPAPI_E_MACHINE_UNAVAILABLE = 0x800f0222;
enum int SPAPI_E_INVALID_PROPPAGE_PROVIDER = 0x800f0224;
enum int SPAPI_E_DI_POSTPROCESSING_REQUIRED = 0x800f0226;

enum : int
{
    SPAPI_E_NO_COMPAT_DRIVERS = 0x800f0228,
    SPAPI_E_NO_DEVICE_ICON    = 0x800f0229,
}

enum int SPAPI_E_DI_DONT_INSTALL = 0x800f022b;

enum : int
{
    SPAPI_E_NON_WINDOWS_NT_DRIVER = 0x800f022d,
    SPAPI_E_NON_WINDOWS_DRIVER    = 0x800f022e,
}

enum int SPAPI_E_DEVINSTALL_QUEUE_NONNATIVE = 0x800f0230;
enum int SPAPI_E_CANT_REMOVE_DEVINST = 0x800f0232;
enum int SPAPI_E_DRIVER_NONNATIVE = 0x800f0234;
enum int SPAPI_E_SET_SYSTEM_RESTORE_POINT = 0x800f0236;
enum int SPAPI_E_SCE_DISABLED = 0x800f0238;
enum int SPAPI_E_PNP_REGISTRY_ERROR = 0x800f023a;
enum int SPAPI_E_NOT_AN_INSTALLED_OEM_INF = 0x800f023c;
enum int SPAPI_E_DI_FUNCTION_OBSOLETE = 0x800f023e;

enum : int
{
    SPAPI_E_AUTHENTICODE_DISALLOWED            = 0x800f0240,
    SPAPI_E_AUTHENTICODE_TRUSTED_PUBLISHER     = 0x800f0241,
    SPAPI_E_AUTHENTICODE_TRUST_NOT_ESTABLISHED = 0x800f0242,
    SPAPI_E_AUTHENTICODE_PUBLISHER_NOT_TRUSTED = 0x800f0243,
}

enum int SPAPI_E_ONLY_VALIDATE_VIA_AUTHENTICODE = 0x800f0245;
enum int SPAPI_E_DRIVER_STORE_ADD_FAILED = 0x800f0247;
enum int SPAPI_E_DRIVER_INSTALL_BLOCKED = 0x800f0249;
enum int SPAPI_E_FILE_HASH_NOT_IN_CATALOG = 0x800f024b;
enum int SPAPI_E_UNRECOVERABLE_STACK_OVERFLOW = 0x800f0300;
enum int SCARD_F_INTERNAL_ERROR = 0x80100001;

enum : int
{
    SCARD_E_INVALID_HANDLE    = 0x80100003,
    SCARD_E_INVALID_PARAMETER = 0x80100004,
    SCARD_E_INVALID_TARGET    = 0x80100005,
}

enum int SCARD_F_WAITED_TOO_LONG = 0x80100007;
enum int SCARD_E_UNKNOWN_READER = 0x80100009;
enum int SCARD_E_SHARING_VIOLATION = 0x8010000b;
enum int SCARD_E_UNKNOWN_CARD = 0x8010000d;
enum int SCARD_E_PROTO_MISMATCH = 0x8010000f;
enum int SCARD_E_INVALID_VALUE = 0x80100011;

enum : int
{
    SCARD_F_COMM_ERROR    = 0x80100013,
    SCARD_F_UNKNOWN_ERROR = 0x80100014,
}

enum int SCARD_E_NOT_TRANSACTED = 0x80100016;
enum int SCARD_P_SHUTDOWN = 0x80100018;
enum int SCARD_E_READER_UNSUPPORTED = 0x8010001a;
enum int SCARD_E_CARD_UNSUPPORTED = 0x8010001c;
enum int SCARD_E_SERVICE_STOPPED = 0x8010001e;

enum : int
{
    SCARD_E_ICC_INSTALLATION = 0x80100020,
    SCARD_E_ICC_CREATEORDER  = 0x80100021,
}

enum int SCARD_E_DIR_NOT_FOUND = 0x80100023;

enum : int
{
    SCARD_E_NO_DIR         = 0x80100025,
    SCARD_E_NO_FILE        = 0x80100026,
    SCARD_E_NO_ACCESS      = 0x80100027,
    SCARD_E_WRITE_TOO_MANY = 0x80100028,
}

enum : int
{
    SCARD_E_INVALID_CHV     = 0x8010002a,
    SCARD_E_UNKNOWN_RES_MNG = 0x8010002b,
}

enum int SCARD_E_CERTIFICATE_UNAVAILABLE = 0x8010002d;
enum int SCARD_E_COMM_DATA_LOST = 0x8010002f;
enum int SCARD_E_SERVER_TOO_BUSY = 0x80100031;
enum int SCARD_E_NO_PIN_CACHE = 0x80100033;

enum : int
{
    SCARD_W_UNSUPPORTED_CARD  = 0x80100065,
    SCARD_W_UNRESPONSIVE_CARD = 0x80100066,
}

enum : int
{
    SCARD_W_RESET_CARD   = 0x80100068,
    SCARD_W_REMOVED_CARD = 0x80100069,
}

enum : int
{
    SCARD_W_WRONG_CHV         = 0x8010006b,
    SCARD_W_CHV_BLOCKED       = 0x8010006c,
    SCARD_W_EOF               = 0x8010006d,
    SCARD_W_CANCELLED_BY_USER = 0x8010006e,
}

enum : int
{
    SCARD_W_CACHE_ITEM_NOT_FOUND = 0x80100070,
    SCARD_W_CACHE_ITEM_STALE     = 0x80100071,
    SCARD_W_CACHE_ITEM_TOO_BIG   = 0x80100072,
}

enum : int
{
    COMADMIN_E_OBJECTINVALID      = 0x80110402,
    COMADMIN_E_KEYMISSING         = 0x80110403,
    COMADMIN_E_ALREADYINSTALLED   = 0x80110404,
    COMADMIN_E_APP_FILE_WRITEFAIL = 0x80110407,
    COMADMIN_E_APP_FILE_READFAIL  = 0x80110408,
    COMADMIN_E_APP_FILE_VERSION   = 0x80110409,
    COMADMIN_E_BADPATH            = 0x8011040a,
    COMADMIN_E_APPLICATIONEXISTS  = 0x8011040b,
}

enum : int
{
    COMADMIN_E_CANTCOPYFILE      = 0x8011040d,
    COMADMIN_E_NOUSER            = 0x8011040f,
    COMADMIN_E_INVALIDUSERIDS    = 0x80110410,
    COMADMIN_E_NOREGISTRYCLSID   = 0x80110411,
    COMADMIN_E_BADREGISTRYPROGID = 0x80110412,
}

enum int COMADMIN_E_USERPASSWDNOTVALID = 0x80110414;

enum : int
{
    COMADMIN_E_REMOTEINTERFACE   = 0x80110419,
    COMADMIN_E_DLLREGISTERSERVER = 0x8011041a,
}

enum : int
{
    COMADMIN_E_DLLLOADFAILED           = 0x8011041d,
    COMADMIN_E_BADREGISTRYLIBID        = 0x8011041e,
    COMADMIN_E_APPDIRNOTFOUND          = 0x8011041f,
    COMADMIN_E_REGISTRARFAILED         = 0x80110423,
    COMADMIN_E_COMPFILE_DOESNOTEXIST   = 0x80110424,
    COMADMIN_E_COMPFILE_LOADDLLFAIL    = 0x80110425,
    COMADMIN_E_COMPFILE_GETCLASSOBJ    = 0x80110426,
    COMADMIN_E_COMPFILE_CLASSNOTAVAIL  = 0x80110427,
    COMADMIN_E_COMPFILE_BADTLB         = 0x80110428,
    COMADMIN_E_COMPFILE_NOTINSTALLABLE = 0x80110429,
}

enum : int
{
    COMADMIN_E_NOTDELETEABLE      = 0x8011042b,
    COMADMIN_E_SESSION            = 0x8011042c,
    COMADMIN_E_COMP_MOVE_LOCKED   = 0x8011042d,
    COMADMIN_E_COMP_MOVE_BAD_DEST = 0x8011042e,
}

enum : int
{
    COMADMIN_E_SYSTEMAPP            = 0x80110433,
    COMADMIN_E_COMPFILE_NOREGISTRAR = 0x80110434,
    COMADMIN_E_COREQCOMPINSTALLED   = 0x80110435,
}

enum int COMADMIN_E_PROPERTYSAVEFAILED = 0x80110437;

enum : int
{
    COMADMIN_E_COMPONENTEXISTS   = 0x80110439,
    COMADMIN_E_REGFILE_CORRUPT   = 0x8011043b,
    COMADMIN_E_PROPERTY_OVERFLOW = 0x8011043c,
}

enum int COMADMIN_E_OBJECTNOTPOOLABLE = 0x8011043f;
enum int COMADMIN_E_ROLE_DOES_NOT_EXIST = 0x80110447;
enum int COMADMIN_E_REQUIRES_DIFFERENT_PLATFORM = 0x80110449;

enum : int
{
    COMADMIN_E_CAN_NOT_START_APP           = 0x8011044b,
    COMADMIN_E_CAN_NOT_EXPORT_SYS_APP      = 0x8011044c,
    COMADMIN_E_CANT_SUBSCRIBE_TO_COMPONENT = 0x8011044d,
}

enum int COMADMIN_E_LIB_APP_PROXY_INCOMPATIBLE = 0x8011044f;
enum int COMADMIN_E_START_APP_DISABLED = 0x80110451;

enum : int
{
    COMADMIN_E_CAT_INVALID_PARTITION_NAME = 0x80110458,
    COMADMIN_E_CAT_PARTITION_IN_USE       = 0x80110459,
}

enum int COMADMIN_E_CAT_IMPORTED_COMPONENTS_NOT_ALLOWED = 0x8011045b;
enum int COMADMIN_E_AMBIGUOUS_PARTITION_NAME = 0x8011045d;

enum : int
{
    COMADMIN_E_REGDB_NOTOPEN        = 0x80110473,
    COMADMIN_E_REGDB_SYSTEMERR      = 0x80110474,
    COMADMIN_E_REGDB_ALREADYRUNNING = 0x80110475,
}

enum int COMADMIN_E_MIG_SCHEMANOTFOUND = 0x80110481;

enum : int
{
    COMADMIN_E_CAT_UNACCEPTABLEBITNESS        = 0x80110483,
    COMADMIN_E_CAT_WRONGAPPBITNESS            = 0x80110484,
    COMADMIN_E_CAT_PAUSE_RESUME_NOT_SUPPORTED = 0x80110485,
}

enum int COMQC_E_APPLICATION_NOT_QUEUED = 0x80110600;
enum int COMQC_E_QUEUING_SERVICE_NOT_AVAILABLE = 0x80110602;

enum : int
{
    COMQC_E_BAD_MESSAGE        = 0x80110604,
    COMQC_E_UNAUTHENTICATED    = 0x80110605,
    COMQC_E_UNTRUSTED_ENQUEUER = 0x80110606,
}

enum : int
{
    COMADMIN_E_OBJECT_PARENT_MISSING = 0x80110808,
    COMADMIN_E_OBJECT_DOES_NOT_EXIST = 0x80110809,
}

enum int COMADMIN_E_INVALID_PARTITION = 0x8011080b;

enum : int
{
    COMADMIN_E_USER_IN_SET            = 0x8011080e,
    COMADMIN_E_CANTRECYCLELIBRARYAPPS = 0x8011080f,
    COMADMIN_E_CANTRECYCLESERVICEAPPS = 0x80110811,
}

enum int COMADMIN_E_PAUSEDPROCESSMAYNOTBERECYCLED = 0x80110813;
enum int COMADMIN_E_PROGIDINUSEBYCLSID = 0x80110815;
enum int COMADMIN_E_RECYCLEDPROCESSMAYNOTBEPAUSED = 0x80110817;
enum int COMADMIN_E_PARTITION_MSI_ONLY = 0x80110819;
enum int COMADMIN_E_LEGACYCOMPS_NOT_ALLOWED_IN_NONBASE_PARTITIONS = 0x8011081b;

enum : int
{
    COMADMIN_E_COMP_MOVE_DEST    = 0x8011081d,
    COMADMIN_E_COMP_MOVE_PRIVATE = 0x8011081e,
}

enum int COMADMIN_E_CANNOT_ALIAS_EVENTCLASS = 0x80110820;

enum : int
{
    COMADMIN_E_SAFERINVALID          = 0x80110822,
    COMADMIN_E_REGISTRY_ACCESSDENIED = 0x80110823,
}

enum : int
{
    WER_S_REPORT_DEBUG    = 0x001b0000,
    WER_S_REPORT_UPLOADED = 0x001b0001,
    WER_S_REPORT_QUEUED   = 0x001b0002,
}

enum int WER_S_SUSPENDED_UPLOAD = 0x001b0004;
enum int WER_S_DISABLED_ARCHIVE = 0x001b0006;

enum : int
{
    WER_S_IGNORE_ASSERT_INSTANCE = 0x001b0008,
    WER_S_IGNORE_ALL_ASSERTS     = 0x001b0009,
}

enum int WER_S_THROTTLED = 0x001b000b;
enum int WER_E_CRASH_FAILURE = 0x801b8000;
enum int WER_E_NETWORK_FAILURE = 0x801b8002;
enum int WER_E_ALREADY_REPORTING = 0x801b8004;
enum int WER_E_INSUFFICIENT_CONSENT = 0x801b8006;

enum : int
{
    ERROR_FLT_IO_COMPLETE        = 0x001f0001,
    ERROR_FLT_NO_HANDLER_DEFINED = 0x801f0001,
}

enum int ERROR_FLT_INVALID_ASYNCHRONOUS_REQUEST = 0x801f0003;
enum int ERROR_FLT_INVALID_NAME_REQUEST = 0x801f0005;
enum int ERROR_FLT_NOT_INITIALIZED = 0x801f0007;
enum int ERROR_FLT_POST_OPERATION_CLEANUP = 0x801f0009;
enum int ERROR_FLT_DELETING_OBJECT = 0x801f000b;
enum int ERROR_FLT_DUPLICATE_ENTRY = 0x801f000d;

enum : int
{
    ERROR_FLT_DO_NOT_ATTACH               = 0x801f000f,
    ERROR_FLT_DO_NOT_DETACH               = 0x801f0010,
    ERROR_FLT_INSTANCE_ALTITUDE_COLLISION = 0x801f0011,
    ERROR_FLT_INSTANCE_NAME_COLLISION     = 0x801f0012,
}

enum int ERROR_FLT_VOLUME_NOT_FOUND = 0x801f0014;
enum int ERROR_FLT_CONTEXT_ALLOCATION_NOT_FOUND = 0x801f0016;

enum : int
{
    ERROR_FLT_NAME_CACHE_MISS  = 0x801f0018,
    ERROR_FLT_NO_DEVICE_OBJECT = 0x801f0019,
}

enum int ERROR_FLT_ALREADY_ENLISTED = 0x801f001b;
enum int ERROR_FLT_NO_WAITER_FOR_REPLY = 0x801f0020;
enum int ERROR_HUNG_DISPLAY_DRIVER_THREAD = 0x80260001;
enum int DWM_E_REMOTING_NOT_SUPPORTED = 0x80263002;
enum int DWM_E_NOT_QUEUING_PRESENTS = 0x80263004;
enum int DWM_S_GDI_REDIRECTION_SURFACE = 0x00263005;
enum int DWM_S_GDI_REDIRECTION_SURFACE_BLT_VIA_GDI = 0x00263008;
enum int ERROR_MONITOR_UNKNOWN_DESCRIPTOR_FORMAT = 0x00261002;
enum int ERROR_MONITOR_INVALID_STANDARD_TIMING_BLOCK = 0xc0261004;

enum : int
{
    ERROR_MONITOR_INVALID_SERIAL_NUMBER_MONDSC_BLOCK = 0xc0261006,
    ERROR_MONITOR_INVALID_USER_FRIENDLY_MONDSC_BLOCK = 0xc0261007,
}

enum : int
{
    ERROR_MONITOR_INVALID_DETAILED_TIMING_BLOCK = 0xc0261009,
    ERROR_MONITOR_INVALID_MANUFACTURE_DATE      = 0xc026100a,
}

enum : int
{
    ERROR_GRAPHICS_INSUFFICIENT_DMA_BUFFER = 0xc0262001,
    ERROR_GRAPHICS_INVALID_DISPLAY_ADAPTER = 0xc0262002,
}

enum : int
{
    ERROR_GRAPHICS_INVALID_DRIVER_MODEL         = 0xc0262004,
    ERROR_GRAPHICS_PRESENT_MODE_CHANGED         = 0xc0262005,
    ERROR_GRAPHICS_PRESENT_OCCLUDED             = 0xc0262006,
    ERROR_GRAPHICS_PRESENT_DENIED               = 0xc0262007,
    ERROR_GRAPHICS_CANNOTCOLORCONVERT           = 0xc0262008,
    ERROR_GRAPHICS_DRIVER_MISMATCH              = 0xc0262009,
    ERROR_GRAPHICS_PARTIAL_DATA_POPULATED       = 0x4026200a,
    ERROR_GRAPHICS_PRESENT_REDIRECTION_DISABLED = 0xc026200b,
    ERROR_GRAPHICS_PRESENT_UNOCCLUDED           = 0xc026200c,
    ERROR_GRAPHICS_WINDOWDC_NOT_AVAILABLE       = 0xc026200d,
    ERROR_GRAPHICS_WINDOWLESS_PRESENT_DISABLED  = 0xc026200e,
}

enum int ERROR_GRAPHICS_PRESENT_BUFFER_NOT_BOUND = 0xc0262010;

enum : int
{
    ERROR_GRAPHICS_INDIRECT_DISPLAY_ABANDON_SWAPCHAIN = 0xc0262012,
    ERROR_GRAPHICS_INDIRECT_DISPLAY_DEVICE_STOPPED    = 0xc0262013,
}

enum int ERROR_GRAPHICS_VAIL_FAILED_TO_SEND_DESTROY_SUPERWETINK_MESSAGE = 0xc0262015;

enum : int
{
    ERROR_GRAPHICS_CANT_LOCK_MEMORY                 = 0xc0262101,
    ERROR_GRAPHICS_ALLOCATION_BUSY                  = 0xc0262102,
    ERROR_GRAPHICS_TOO_MANY_REFERENCES              = 0xc0262103,
    ERROR_GRAPHICS_TRY_AGAIN_LATER                  = 0xc0262104,
    ERROR_GRAPHICS_TRY_AGAIN_NOW                    = 0xc0262105,
    ERROR_GRAPHICS_ALLOCATION_INVALID               = 0xc0262106,
    ERROR_GRAPHICS_UNSWIZZLING_APERTURE_UNAVAILABLE = 0xc0262107,
    ERROR_GRAPHICS_UNSWIZZLING_APERTURE_UNSUPPORTED = 0xc0262108,
}

enum int ERROR_GRAPHICS_INVALID_ALLOCATION_USAGE = 0xc0262110;

enum : int
{
    ERROR_GRAPHICS_ALLOCATION_CLOSED           = 0xc0262112,
    ERROR_GRAPHICS_INVALID_ALLOCATION_INSTANCE = 0xc0262113,
    ERROR_GRAPHICS_INVALID_ALLOCATION_HANDLE   = 0xc0262114,
}

enum int ERROR_GRAPHICS_ALLOCATION_CONTENT_LOST = 0xc0262116;
enum int ERROR_GRAPHICS_SKIP_ALLOCATION_PREPARATION = 0x40262201;

enum : int
{
    ERROR_GRAPHICS_VIDPN_TOPOLOGY_NOT_SUPPORTED           = 0xc0262301,
    ERROR_GRAPHICS_VIDPN_TOPOLOGY_CURRENTLY_NOT_SUPPORTED = 0xc0262302,
}

enum : int
{
    ERROR_GRAPHICS_INVALID_VIDEO_PRESENT_SOURCE = 0xc0262304,
    ERROR_GRAPHICS_INVALID_VIDEO_PRESENT_TARGET = 0xc0262305,
}

enum : int
{
    ERROR_GRAPHICS_MODE_NOT_PINNED                   = 0x00262307,
    ERROR_GRAPHICS_INVALID_VIDPN_SOURCEMODESET       = 0xc0262308,
    ERROR_GRAPHICS_INVALID_VIDPN_TARGETMODESET       = 0xc0262309,
    ERROR_GRAPHICS_INVALID_FREQUENCY                 = 0xc026230a,
    ERROR_GRAPHICS_INVALID_ACTIVE_REGION             = 0xc026230b,
    ERROR_GRAPHICS_INVALID_TOTAL_REGION              = 0xc026230c,
    ERROR_GRAPHICS_INVALID_VIDEO_PRESENT_SOURCE_MODE = 0xc0262310,
    ERROR_GRAPHICS_INVALID_VIDEO_PRESENT_TARGET_MODE = 0xc0262311,
}

enum int ERROR_GRAPHICS_PATH_ALREADY_IN_TOPOLOGY = 0xc0262313;

enum : int
{
    ERROR_GRAPHICS_INVALID_VIDEOPRESENTSOURCESET = 0xc0262315,
    ERROR_GRAPHICS_INVALID_VIDEOPRESENTTARGETSET = 0xc0262316,
}

enum : int
{
    ERROR_GRAPHICS_TARGET_ALREADY_IN_SET      = 0xc0262318,
    ERROR_GRAPHICS_INVALID_VIDPN_PRESENT_PATH = 0xc0262319,
}

enum : int
{
    ERROR_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGESET = 0xc026231b,
    ERROR_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGE    = 0xc026231c,
}

enum : int
{
    ERROR_GRAPHICS_NO_PREFERRED_MODE             = 0x0026231e,
    ERROR_GRAPHICS_FREQUENCYRANGE_ALREADY_IN_SET = 0xc026231f,
}

enum : int
{
    ERROR_GRAPHICS_INVALID_MONITOR_SOURCEMODESET = 0xc0262321,
    ERROR_GRAPHICS_INVALID_MONITOR_SOURCE_MODE   = 0xc0262322,
}

enum : int
{
    ERROR_GRAPHICS_MODE_ID_MUST_BE_UNIQUE                          = 0xc0262324,
    ERROR_GRAPHICS_EMPTY_ADAPTER_MONITOR_MODE_SUPPORT_INTERSECTION = 0xc0262325,
}

enum : int
{
    ERROR_GRAPHICS_PATH_NOT_IN_TOPOLOGY                  = 0xc0262327,
    ERROR_GRAPHICS_ADAPTER_MUST_HAVE_AT_LEAST_ONE_SOURCE = 0xc0262328,
    ERROR_GRAPHICS_ADAPTER_MUST_HAVE_AT_LEAST_ONE_TARGET = 0xc0262329,
}

enum int ERROR_GRAPHICS_INVALID_MONITORDESCRIPTOR = 0xc026232b;

enum : int
{
    ERROR_GRAPHICS_MONITORDESCRIPTOR_ALREADY_IN_SET    = 0xc026232d,
    ERROR_GRAPHICS_MONITORDESCRIPTOR_ID_MUST_BE_UNIQUE = 0xc026232e,
}

enum : int
{
    ERROR_GRAPHICS_RESOURCES_NOT_RELATED    = 0xc0262330,
    ERROR_GRAPHICS_SOURCE_ID_MUST_BE_UNIQUE = 0xc0262331,
}

enum int ERROR_GRAPHICS_NO_AVAILABLE_VIDPN_TARGET = 0xc0262333;

enum : int
{
    ERROR_GRAPHICS_NO_VIDPNMGR                  = 0xc0262335,
    ERROR_GRAPHICS_NO_ACTIVE_VIDPN              = 0xc0262336,
    ERROR_GRAPHICS_STALE_VIDPN_TOPOLOGY         = 0xc0262337,
    ERROR_GRAPHICS_MONITOR_NOT_CONNECTED        = 0xc0262338,
    ERROR_GRAPHICS_SOURCE_NOT_IN_TOPOLOGY       = 0xc0262339,
    ERROR_GRAPHICS_INVALID_PRIMARYSURFACE_SIZE  = 0xc026233a,
    ERROR_GRAPHICS_INVALID_VISIBLEREGION_SIZE   = 0xc026233b,
    ERROR_GRAPHICS_INVALID_STRIDE               = 0xc026233c,
    ERROR_GRAPHICS_INVALID_PIXELFORMAT          = 0xc026233d,
    ERROR_GRAPHICS_INVALID_COLORBASIS           = 0xc026233e,
    ERROR_GRAPHICS_INVALID_PIXELVALUEACCESSMODE = 0xc026233f,
}

enum int ERROR_GRAPHICS_NO_DISPLAY_MODE_MANAGEMENT_SUPPORT = 0xc0262341;
enum int ERROR_GRAPHICS_CANT_ACCESS_ACTIVE_VIDPN = 0xc0262343;
enum int ERROR_GRAPHICS_INVALID_PATH_CONTENT_GEOMETRY_TRANSFORMATION = 0xc0262345;

enum : int
{
    ERROR_GRAPHICS_INVALID_GAMMA_RAMP       = 0xc0262347,
    ERROR_GRAPHICS_GAMMA_RAMP_NOT_SUPPORTED = 0xc0262348,
}

enum : int
{
    ERROR_GRAPHICS_MODE_NOT_IN_MODESET         = 0xc026234a,
    ERROR_GRAPHICS_DATASET_IS_EMPTY            = 0x0026234b,
    ERROR_GRAPHICS_NO_MORE_ELEMENTS_IN_DATASET = 0x0026234c,
}

enum : int
{
    ERROR_GRAPHICS_INVALID_PATH_CONTENT_TYPE   = 0xc026234e,
    ERROR_GRAPHICS_INVALID_COPYPROTECTION_TYPE = 0xc026234f,
}

enum int ERROR_GRAPHICS_PATH_CONTENT_GEOMETRY_TRANSFORMATION_NOT_PINNED = 0x00262351;
enum int ERROR_GRAPHICS_TOPOLOGY_CHANGES_NOT_ALLOWED = 0xc0262353;

enum : int
{
    ERROR_GRAPHICS_INCOMPATIBLE_PRIVATE_FORMAT               = 0xc0262355,
    ERROR_GRAPHICS_INVALID_MODE_PRUNING_ALGORITHM            = 0xc0262356,
    ERROR_GRAPHICS_INVALID_MONITOR_CAPABILITY_ORIGIN         = 0xc0262357,
    ERROR_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGE_CONSTRAINT = 0xc0262358,
}

enum int ERROR_GRAPHICS_CANCEL_VIDPN_TOPOLOGY_AUGMENTATION = 0xc026235a;

enum : int
{
    ERROR_GRAPHICS_CLIENTVIDPN_NOT_SET               = 0xc026235c,
    ERROR_GRAPHICS_SPECIFIED_CHILD_ALREADY_CONNECTED = 0xc0262400,
}

enum : int
{
    ERROR_GRAPHICS_UNKNOWN_CHILD_STATUS    = 0x4026242f,
    ERROR_GRAPHICS_NOT_A_LINKED_ADAPTER    = 0xc0262430,
    ERROR_GRAPHICS_LEADLINK_NOT_ENUMERATED = 0xc0262431,
}

enum int ERROR_GRAPHICS_ADAPTER_CHAIN_NOT_READY = 0xc0262433;
enum int ERROR_GRAPHICS_CHAINLINKS_NOT_POWERED_ON = 0xc0262435;
enum int ERROR_GRAPHICS_LEADLINK_START_DEFERRED = 0x40262437;

enum : int
{
    ERROR_GRAPHICS_POLLING_TOO_FREQUENTLY      = 0x40262439,
    ERROR_GRAPHICS_START_DEFERRED              = 0x4026243a,
    ERROR_GRAPHICS_ADAPTER_ACCESS_NOT_EXCLUDED = 0xc026243b,
}

enum : int
{
    ERROR_GRAPHICS_OPM_NOT_SUPPORTED                = 0xc0262500,
    ERROR_GRAPHICS_COPP_NOT_SUPPORTED               = 0xc0262501,
    ERROR_GRAPHICS_UAB_NOT_SUPPORTED                = 0xc0262502,
    ERROR_GRAPHICS_OPM_INVALID_ENCRYPTED_PARAMETERS = 0xc0262503,
    ERROR_GRAPHICS_OPM_NO_VIDEO_OUTPUTS_EXIST       = 0xc0262505,
    ERROR_GRAPHICS_OPM_INTERNAL_ERROR               = 0xc026250b,
    ERROR_GRAPHICS_OPM_INVALID_HANDLE               = 0xc026250c,
    ERROR_GRAPHICS_PVP_INVALID_CERTIFICATE_LENGTH   = 0xc026250e,
}

enum int ERROR_GRAPHICS_OPM_THEATER_MODE_ENABLED = 0xc0262510;

enum : int
{
    ERROR_GRAPHICS_OPM_INVALID_SRM                   = 0xc0262512,
    ERROR_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_HDCP  = 0xc0262513,
    ERROR_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_ACP   = 0xc0262514,
    ERROR_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_CGMSA = 0xc0262515,
}

enum : int
{
    ERROR_GRAPHICS_OPM_RESOLUTION_TOO_HIGH              = 0xc0262517,
    ERROR_GRAPHICS_OPM_ALL_HDCP_HARDWARE_ALREADY_IN_USE = 0xc0262518,
}

enum int ERROR_GRAPHICS_OPM_SESSION_TYPE_CHANGE_IN_PROGRESS = 0xc026251b;

enum : int
{
    ERROR_GRAPHICS_OPM_INVALID_INFORMATION_REQUEST              = 0xc026251d,
    ERROR_GRAPHICS_OPM_DRIVER_INTERNAL_ERROR                    = 0xc026251e,
    ERROR_GRAPHICS_OPM_VIDEO_OUTPUT_DOES_NOT_HAVE_OPM_SEMANTICS = 0xc026251f,
}

enum int ERROR_GRAPHICS_OPM_INVALID_CONFIGURATION_REQUEST = 0xc0262521;

enum : int
{
    ERROR_GRAPHICS_I2C_DEVICE_DOES_NOT_EXIST   = 0xc0262581,
    ERROR_GRAPHICS_I2C_ERROR_TRANSMITTING_DATA = 0xc0262582,
    ERROR_GRAPHICS_I2C_ERROR_RECEIVING_DATA    = 0xc0262583,
}

enum : int
{
    ERROR_GRAPHICS_DDCCI_INVALID_DATA                                = 0xc0262585,
    ERROR_GRAPHICS_DDCCI_MONITOR_RETURNED_INVALID_TIMING_STATUS_BYTE = 0xc0262586,
}

enum : int
{
    ERROR_GRAPHICS_MCA_INTERNAL_ERROR             = 0xc0262588,
    ERROR_GRAPHICS_DDCCI_INVALID_MESSAGE_COMMAND  = 0xc0262589,
    ERROR_GRAPHICS_DDCCI_INVALID_MESSAGE_LENGTH   = 0xc026258a,
    ERROR_GRAPHICS_DDCCI_INVALID_MESSAGE_CHECKSUM = 0xc026258b,
}

enum int ERROR_GRAPHICS_MONITOR_NO_LONGER_EXISTS = 0xc026258d;

enum : int
{
    ERROR_GRAPHICS_MCA_INVALID_VCP_VERSION                 = 0xc02625d9,
    ERROR_GRAPHICS_MCA_MONITOR_VIOLATES_MCCS_SPECIFICATION = 0xc02625da,
}

enum : int
{
    ERROR_GRAPHICS_MCA_UNSUPPORTED_MCCS_VERSION         = 0xc02625dc,
    ERROR_GRAPHICS_MCA_INVALID_TECHNOLOGY_TYPE_RETURNED = 0xc02625de,
}

enum int ERROR_GRAPHICS_ONLY_CONSOLE_SESSION_SUPPORTED = 0xc02625e0;
enum int ERROR_GRAPHICS_DISPLAY_DEVICE_NOT_ATTACHED_TO_DESKTOP = 0xc02625e2;

enum : int
{
    ERROR_GRAPHICS_INVALID_POINTER                          = 0xc02625e4,
    ERROR_GRAPHICS_NO_MONITORS_CORRESPOND_TO_DISPLAY_DEVICE = 0xc02625e5,
}

enum : int
{
    ERROR_GRAPHICS_INTERNAL_ERROR                  = 0xc02625e7,
    ERROR_GRAPHICS_SESSION_TYPE_CHANGE_IN_PROGRESS = 0xc02605e8,
}

enum int NAP_E_MISSING_SOH = 0x80270002;
enum int NAP_E_NO_CACHED_SOH = 0x80270004;

enum : int
{
    NAP_E_NOT_REGISTERED  = 0x80270006,
    NAP_E_NOT_INITIALIZED = 0x80270007,
}

enum int NAP_E_NOT_PENDING = 0x80270009;
enum int NAP_E_MAXSIZE_TOO_SMALL = 0x8027000b;
enum int NAP_S_CERT_ALREADY_PRESENT = 0x0027000d;
enum int NAP_E_NETSH_GROUPPOLICY_ERROR = 0x8027000f;

enum : int
{
    NAP_E_SHV_CONFIG_EXISTED   = 0x80270011,
    NAP_E_SHV_CONFIG_NOT_FOUND = 0x80270012,
}

enum int TPM_E_ERROR_MASK = 0x80280000;

enum : int
{
    TPM_E_BADINDEX      = 0x80280002,
    TPM_E_BAD_PARAMETER = 0x80280003,
}

enum int TPM_E_CLEAR_DISABLED = 0x80280005;

enum : int
{
    TPM_E_DISABLED     = 0x80280007,
    TPM_E_DISABLED_CMD = 0x80280008,
}

enum int TPM_E_BAD_ORDINAL = 0x8028000a;
enum int TPM_E_INVALID_KEYHANDLE = 0x8028000c;
enum int TPM_E_INAPPROPRIATE_ENC = 0x8028000e;
enum int TPM_E_INVALID_PCR_INFO = 0x80280010;

enum : int
{
    TPM_E_NOSRK          = 0x80280012,
    TPM_E_NOTSEALED_BLOB = 0x80280013,
}

enum int TPM_E_RESOURCES = 0x80280015;

enum : int
{
    TPM_E_SIZE        = 0x80280017,
    TPM_E_WRONGPCRVAL = 0x80280018,
}

enum : int
{
    TPM_E_SHA_THREAD = 0x8028001a,
    TPM_E_SHA_ERROR  = 0x8028001b,
}

enum int TPM_E_AUTH2FAIL = 0x8028001d;

enum : int
{
    TPM_E_IOERROR       = 0x8028001f,
    TPM_E_ENCRYPT_ERROR = 0x80280020,
}

enum int TPM_E_INVALID_AUTHHANDLE = 0x80280022;
enum int TPM_E_INVALID_KEYUSAGE = 0x80280024;
enum int TPM_E_INVALID_POSTINIT = 0x80280026;

enum : int
{
    TPM_E_BAD_KEY_PROPERTY = 0x80280028,
    TPM_E_BAD_MIGRATION    = 0x80280029,
    TPM_E_BAD_SCHEME       = 0x8028002a,
    TPM_E_BAD_DATASIZE     = 0x8028002b,
    TPM_E_BAD_MODE         = 0x8028002c,
    TPM_E_BAD_PRESENCE     = 0x8028002d,
    TPM_E_BAD_VERSION      = 0x8028002e,
}

enum : int
{
    TPM_E_AUDITFAIL_UNSUCCESSFUL = 0x80280030,
    TPM_E_AUDITFAIL_SUCCESSFUL   = 0x80280031,
}

enum : int
{
    TPM_E_NOTLOCAL         = 0x80280033,
    TPM_E_BAD_TYPE         = 0x80280034,
    TPM_E_INVALID_RESOURCE = 0x80280035,
}

enum int TPM_E_INVALID_FAMILY = 0x80280037;
enum int TPM_E_REQUIRES_SIGN = 0x80280039;
enum int TPM_E_AUTH_CONFLICT = 0x8028003b;
enum int TPM_E_BAD_LOCALITY = 0x8028003d;
enum int TPM_E_PER_NOWRITE = 0x8028003f;
enum int TPM_E_WRITE_LOCKED = 0x80280041;
enum int TPM_E_INVALID_STRUCTURE = 0x80280043;
enum int TPM_E_BAD_COUNTER = 0x80280045;
enum int TPM_E_CONTEXT_GAP = 0x80280047;
enum int TPM_E_NOOPERATOR = 0x80280049;

enum : int
{
    TPM_E_DELEGATE_LOCK   = 0x8028004b,
    TPM_E_DELEGATE_FAMILY = 0x8028004c,
    TPM_E_DELEGATE_ADMIN  = 0x8028004d,
}

enum int TPM_E_OWNER_CONTROL = 0x8028004f;

enum : int
{
    TPM_E_DAA_INPUT_DATA0     = 0x80280051,
    TPM_E_DAA_INPUT_DATA1     = 0x80280052,
    TPM_E_DAA_ISSUER_SETTINGS = 0x80280053,
}

enum : int
{
    TPM_E_DAA_STAGE           = 0x80280055,
    TPM_E_DAA_ISSUER_VALIDITY = 0x80280056,
}

enum : int
{
    TPM_E_BAD_HANDLE   = 0x80280058,
    TPM_E_BAD_DELEGATE = 0x80280059,
    TPM_E_BADCONTEXT   = 0x8028005a,
}

enum int TPM_E_MA_TICKET_SIGNATURE = 0x8028005c;

enum : int
{
    TPM_E_MA_SOURCE    = 0x8028005e,
    TPM_E_MA_AUTHORITY = 0x8028005f,
}

enum int TPM_E_BAD_SIGNATURE = 0x80280062;

enum : int
{
    TPM_20_E_ASYMMETRIC        = 0x80280081,
    TPM_20_E_ATTRIBUTES        = 0x80280082,
    TPM_20_E_HASH              = 0x80280083,
    TPM_20_E_VALUE             = 0x80280084,
    TPM_20_E_HIERARCHY         = 0x80280085,
    TPM_20_E_KEY_SIZE          = 0x80280087,
    TPM_20_E_MGF               = 0x80280088,
    TPM_20_E_MODE              = 0x80280089,
    TPM_20_E_TYPE              = 0x8028008a,
    TPM_20_E_HANDLE            = 0x8028008b,
    TPM_20_E_KDF               = 0x8028008c,
    TPM_20_E_RANGE             = 0x8028008d,
    TPM_20_E_AUTH_FAIL         = 0x8028008e,
    TPM_20_E_NONCE             = 0x8028008f,
    TPM_20_E_PP                = 0x80280090,
    TPM_20_E_SCHEME            = 0x80280092,
    TPM_20_E_SIZE              = 0x80280095,
    TPM_20_E_SYMMETRIC         = 0x80280096,
    TPM_20_E_TAG               = 0x80280097,
    TPM_20_E_SELECTOR          = 0x80280098,
    TPM_20_E_INSUFFICIENT      = 0x8028009a,
    TPM_20_E_SIGNATURE         = 0x8028009b,
    TPM_20_E_KEY               = 0x8028009c,
    TPM_20_E_POLICY_FAIL       = 0x8028009d,
    TPM_20_E_INTEGRITY         = 0x8028009f,
    TPM_20_E_TICKET            = 0x802800a0,
    TPM_20_E_RESERVED_BITS     = 0x802800a1,
    TPM_20_E_BAD_AUTH          = 0x802800a2,
    TPM_20_E_EXPIRED           = 0x802800a3,
    TPM_20_E_POLICY_CC         = 0x802800a4,
    TPM_20_E_BINDING           = 0x802800a5,
    TPM_20_E_CURVE             = 0x802800a6,
    TPM_20_E_ECC_POINT         = 0x802800a7,
    TPM_20_E_INITIALIZE        = 0x80280100,
    TPM_20_E_FAILURE           = 0x80280101,
    TPM_20_E_SEQUENCE          = 0x80280103,
    TPM_20_E_PRIVATE           = 0x8028010b,
    TPM_20_E_HMAC              = 0x80280119,
    TPM_20_E_DISABLED          = 0x80280120,
    TPM_20_E_EXCLUSIVE         = 0x80280121,
    TPM_20_E_ECC_CURVE         = 0x80280123,
    TPM_20_E_AUTH_TYPE         = 0x80280124,
    TPM_20_E_AUTH_MISSING      = 0x80280125,
    TPM_20_E_POLICY            = 0x80280126,
    TPM_20_E_PCR               = 0x80280127,
    TPM_20_E_PCR_CHANGED       = 0x80280128,
    TPM_20_E_UPGRADE           = 0x8028012d,
    TPM_20_E_TOO_MANY_CONTEXTS = 0x8028012e,
}

enum : int
{
    TPM_20_E_REBOOT           = 0x80280130,
    TPM_20_E_UNBALANCED       = 0x80280131,
    TPM_20_E_COMMAND_SIZE     = 0x80280142,
    TPM_20_E_COMMAND_CODE     = 0x80280143,
    TPM_20_E_AUTHSIZE         = 0x80280144,
    TPM_20_E_AUTH_CONTEXT     = 0x80280145,
    TPM_20_E_NV_RANGE         = 0x80280146,
    TPM_20_E_NV_SIZE          = 0x80280147,
    TPM_20_E_NV_LOCKED        = 0x80280148,
    TPM_20_E_NV_AUTHORIZATION = 0x80280149,
    TPM_20_E_NV_UNINITIALIZED = 0x8028014a,
    TPM_20_E_NV_SPACE         = 0x8028014b,
    TPM_20_E_NV_DEFINED       = 0x8028014c,
    TPM_20_E_BAD_CONTEXT      = 0x80280150,
    TPM_20_E_CPHASH           = 0x80280151,
    TPM_20_E_PARENT           = 0x80280152,
    TPM_20_E_NEEDS_TEST       = 0x80280153,
    TPM_20_E_NO_RESULT        = 0x80280154,
    TPM_20_E_SENSITIVE        = 0x80280155,
}

enum int TPM_E_INVALID_HANDLE = 0x80280401;

enum : int
{
    TPM_E_EMBEDDED_COMMAND_BLOCKED     = 0x80280403,
    TPM_E_EMBEDDED_COMMAND_UNSUPPORTED = 0x80280404,
}

enum int TPM_E_NEEDS_SELFTEST = 0x80280801;
enum int TPM_E_DEFEND_LOCK_RUNNING = 0x80280803;

enum : int
{
    TPM_20_E_OBJECT_MEMORY  = 0x80280902,
    TPM_20_E_SESSION_MEMORY = 0x80280903,
}

enum int TPM_20_E_SESSION_HANDLES = 0x80280905;

enum : int
{
    TPM_20_E_LOCALITY       = 0x80280907,
    TPM_20_E_YIELDED        = 0x80280908,
    TPM_20_E_CANCELED       = 0x80280909,
    TPM_20_E_TESTING        = 0x8028090a,
    TPM_20_E_NV_RATE        = 0x80280920,
    TPM_20_E_LOCKOUT        = 0x80280921,
    TPM_20_E_RETRY          = 0x80280922,
    TPM_20_E_NV_UNAVAILABLE = 0x80280923,
}

enum int TBS_E_BAD_PARAMETER = 0x80284002;
enum int TBS_E_INVALID_CONTEXT = 0x80284004;

enum : int
{
    TBS_E_IOERROR               = 0x80284006,
    TBS_E_INVALID_CONTEXT_PARAM = 0x80284007,
}

enum : int
{
    TBS_E_TOO_MANY_TBS_CONTEXTS = 0x80284009,
    TBS_E_TOO_MANY_RESOURCES    = 0x8028400a,
}

enum int TBS_E_PPI_NOT_SUPPORTED = 0x8028400c;
enum int TBS_E_BUFFER_TOO_LARGE = 0x8028400e;
enum int TBS_E_SERVICE_DISABLED = 0x80284010;
enum int TBS_E_ACCESS_DENIED = 0x80284012;
enum int TBS_E_PPI_FUNCTION_UNSUPPORTED = 0x80284014;
enum int TBS_E_PROVISIONING_INCOMPLETE = 0x80284016;
enum int TPMAPI_E_NOT_ENOUGH_DATA = 0x80290101;

enum : int
{
    TPMAPI_E_INVALID_OUTPUT_POINTER = 0x80290103,
    TPMAPI_E_INVALID_PARAMETER      = 0x80290104,
}

enum int TPMAPI_E_BUFFER_TOO_SMALL = 0x80290106;

enum : int
{
    TPMAPI_E_ACCESS_DENIED        = 0x80290108,
    TPMAPI_E_AUTHORIZATION_FAILED = 0x80290109,
}

enum int TPMAPI_E_TBS_COMMUNICATION_ERROR = 0x8029010b;
enum int TPMAPI_E_MESSAGE_TOO_LARGE = 0x8029010d;
enum int TPMAPI_E_INVALID_KEY_SIZE = 0x8029010f;

enum : int
{
    TPMAPI_E_INVALID_KEY_PARAMS                   = 0x80290111,
    TPMAPI_E_INVALID_MIGRATION_AUTHORIZATION_BLOB = 0x80290112,
}

enum : int
{
    TPMAPI_E_INVALID_DELEGATE_BLOB  = 0x80290114,
    TPMAPI_E_INVALID_CONTEXT_PARAMS = 0x80290115,
    TPMAPI_E_INVALID_KEY_BLOB       = 0x80290116,
    TPMAPI_E_INVALID_PCR_DATA       = 0x80290117,
    TPMAPI_E_INVALID_OWNER_AUTH     = 0x80290118,
}

enum : int
{
    TPMAPI_E_EMPTY_TCG_LOG         = 0x8029011a,
    TPMAPI_E_INVALID_TCG_LOG_ENTRY = 0x8029011b,
}

enum int TPMAPI_E_TCG_INVALID_DIGEST_ENTRY = 0x8029011d;

enum : int
{
    TPMAPI_E_NV_BITS_NOT_DEFINED = 0x8029011f,
    TPMAPI_E_NV_BITS_NOT_READY   = 0x80290120,
}

enum int TPMAPI_E_NO_AUTHORIZATION_CHAIN_FOUND = 0x80290122;
enum int TPMAPI_E_OWNER_AUTH_NOT_NULL = 0x80290124;
enum int TPMAPI_E_AUTHORIZATION_REVOKED = 0x80290126;
enum int TPMAPI_E_AUTHORIZING_KEY_NOT_SUPPORTED = 0x80290128;

enum : int
{
    TPMAPI_E_MALFORMED_AUTHORIZATION_POLICY = 0x8029012a,
    TPMAPI_E_MALFORMED_AUTHORIZATION_OTHER  = 0x8029012b,
}

enum : int
{
    TPMAPI_E_INVALID_TPM_VERSION          = 0x8029012d,
    TPMAPI_E_INVALID_POLICYAUTH_BLOB_TYPE = 0x8029012e,
}

enum int TBSIMP_E_CLEANUP_FAILED = 0x80290201;
enum int TBSIMP_E_INVALID_CONTEXT_PARAM = 0x80290203;

enum : int
{
    TBSIMP_E_HASH_BAD_KEY      = 0x80290205,
    TBSIMP_E_DUPLICATE_VHANDLE = 0x80290206,
}

enum int TBSIMP_E_INVALID_PARAMETER = 0x80290208;
enum int TBSIMP_E_SCHEDULER_NOT_RUNNING = 0x8029020a;

enum : int
{
    TBSIMP_E_OUT_OF_MEMORY      = 0x8029020c,
    TBSIMP_E_LIST_NO_MORE_ITEMS = 0x8029020d,
    TBSIMP_E_LIST_NOT_FOUND     = 0x8029020e,
}

enum int TBSIMP_E_NOT_ENOUGH_TPM_CONTEXTS = 0x80290210;
enum int TBSIMP_E_UNKNOWN_ORDINAL = 0x80290212;
enum int TBSIMP_E_INVALID_RESOURCE = 0x80290214;
enum int TBSIMP_E_HASH_TABLE_FULL = 0x80290216;
enum int TBSIMP_E_TOO_MANY_RESOURCES = 0x80290218;
enum int TBSIMP_E_TPM_INCOMPATIBLE = 0x8029021a;

enum : int
{
    TPM_E_PPI_ACPI_FAILURE    = 0x80290300,
    TPM_E_PPI_USER_ABORT      = 0x80290301,
    TPM_E_PPI_BIOS_FAILURE    = 0x80290302,
    TPM_E_PPI_NOT_SUPPORTED   = 0x80290303,
    TPM_E_PPI_BLOCKED_IN_BIOS = 0x80290304,
}

enum int TPM_E_PCP_DEVICE_NOT_READY = 0x80290401;
enum int TPM_E_PCP_INVALID_PARAMETER = 0x80290403;

enum : int
{
    TPM_E_PCP_NOT_SUPPORTED    = 0x80290405,
    TPM_E_PCP_BUFFER_TOO_SMALL = 0x80290406,
}

enum : int
{
    TPM_E_PCP_AUTHENTICATION_FAILED  = 0x80290408,
    TPM_E_PCP_AUTHENTICATION_IGNORED = 0x80290409,
}

enum int TPM_E_PCP_PROFILE_NOT_FOUND = 0x8029040b;
enum int TPM_E_PCP_WRONG_PARENT = 0x8029040e;
enum int TPM_E_NO_KEY_CERTIFICATION = 0x80290410;
enum int TPM_E_ATTESTATION_CHALLENGE_NOT_SET = 0x80290412;
enum int TPM_E_KEY_ALREADY_FINALIZED = 0x80290414;
enum int TPM_E_KEY_USAGE_POLICY_INVALID = 0x80290416;
enum int TPM_E_KEY_NOT_AUTHENTICATED = 0x80290418;
enum int TPM_E_KEY_NOT_SIGNING_KEY = 0x8029041a;
enum int TPM_E_CLAIM_TYPE_NOT_SUPPORTED = 0x8029041c;
enum int TPM_E_BUFFER_LENGTH_MISMATCH = 0x8029041e;

enum : int
{
    TPM_E_PCP_TICKET_MISSING           = 0x80290420,
    TPM_E_PCP_RAW_POLICY_NOT_SUPPORTED = 0x80290421,
}

enum int TPM_E_PCP_UNSUPPORTED_PSS_SALT = 0x40290423;

enum : int
{
    TPM_E_PCP_PLATFORM_CLAIM_OUTDATED = 0x40290425,
    TPM_E_PCP_PLATFORM_CLAIM_REBOOT   = 0x40290426,
}

enum int TPM_E_PROVISIONING_INCOMPLETE = 0x80290600;
enum int TPM_E_TOO_MUCH_DATA = 0x80290602;
enum int PLA_E_DCS_IN_USE = 0x803000aa;
enum int PLA_E_NO_MIN_DISK = 0x80300070;
enum int PLA_S_PROPERTY_IGNORED = 0x00300100;
enum int PLA_E_DCS_SINGLETON_REQUIRED = 0x80300102;
enum int PLA_E_DCS_NOT_RUNNING = 0x80300104;
enum int PLA_E_NETWORK_EXE_NOT_VALID = 0x80300106;
enum int PLA_E_EXE_PATH_NOT_VALID = 0x80300108;
enum int PLA_E_DCS_START_WAIT_TIMEOUT = 0x8030010a;
enum int PLA_E_REPORT_WAIT_TIMEOUT = 0x8030010c;
enum int PLA_E_EXE_FULL_PATH_REQUIRED = 0x8030010e;
enum int PLA_E_PLA_CHANNEL_NOT_ENABLED = 0x80300110;
enum int PLA_E_RULES_MANAGER_FAILED = 0x80300112;
enum int FVE_E_LOCKED_VOLUME = 0x80310000;

enum : int
{
    FVE_E_NO_TPM_BIOS          = 0x80310002,
    FVE_E_NO_MBR_METRIC        = 0x80310003,
    FVE_E_NO_BOOTSECTOR_METRIC = 0x80310004,
    FVE_E_NO_BOOTMGR_METRIC    = 0x80310005,
}

enum int FVE_E_SECURE_KEY_REQUIRED = 0x80310007;
enum int FVE_E_ACTION_NOT_ALLOWED = 0x80310009;

enum : int
{
    FVE_E_AD_INVALID_DATATYPE = 0x8031000b,
    FVE_E_AD_INVALID_DATASIZE = 0x8031000c,
}

enum : int
{
    FVE_E_AD_ATTR_NOT_SET   = 0x8031000e,
    FVE_E_AD_GUID_NOT_FOUND = 0x8031000f,
}

enum int FVE_E_TOO_SMALL = 0x80310011;
enum int FVE_E_FAILED_WRONG_FS = 0x80310013;
enum int FVE_E_NOT_SUPPORTED = 0x80310015;
enum int FVE_E_VOLUME_NOT_BOUND = 0x80310017;
enum int FVE_E_NOT_DATA_VOLUME = 0x80310019;

enum : int
{
    FVE_E_CONV_READ  = 0x8031001b,
    FVE_E_CONV_WRITE = 0x8031001c,
}

enum int FVE_E_CLUSTERING_NOT_SUPPORTED = 0x8031001e;
enum int FVE_E_OS_NOT_PROTECTED = 0x80310020;
enum int FVE_E_RECOVERY_KEY_REQUIRED = 0x80310022;
enum int FVE_E_OVERLAPPED_UPDATE = 0x80310024;

enum : int
{
    FVE_E_FAILED_SECTOR_SIZE    = 0x80310026,
    FVE_E_FAILED_AUTHENTICATION = 0x80310027,
}

enum int FVE_E_AUTOUNLOCK_ENABLED = 0x80310029;
enum int FVE_E_WRONG_SYSTEM_FS = 0x8031002b;

enum : int
{
    FVE_E_CANNOT_SET_FVEK_ENCRYPTED = 0x8031002d,
    FVE_E_CANNOT_ENCRYPT_NO_KEY     = 0x8031002e,
}

enum int FVE_E_PROTECTOR_EXISTS = 0x80310031;
enum int FVE_E_PROTECTOR_NOT_FOUND = 0x80310033;
enum int FVE_E_INVALID_PASSWORD_FORMAT = 0x80310035;

enum : int
{
    FVE_E_FIPS_PREVENTS_RECOVERY_PASSWORD   = 0x80310037,
    FVE_E_FIPS_PREVENTS_EXTERNAL_KEY_EXPORT = 0x80310038,
}

enum int FVE_E_INVALID_PROTECTOR_TYPE = 0x8031003a;

enum : int
{
    FVE_E_KEYFILE_NOT_FOUND = 0x8031003c,
    FVE_E_KEYFILE_INVALID   = 0x8031003d,
    FVE_E_KEYFILE_NO_VMK    = 0x8031003e,
}

enum int FVE_E_NOT_ALLOWED_IN_SAFE_MODE = 0x80310040;
enum int FVE_E_TPM_NO_VMK = 0x80310042;

enum : int
{
    FVE_E_AUTH_INVALID_APPLICATION = 0x80310044,
    FVE_E_AUTH_INVALID_CONFIG      = 0x80310045,
}

enum int FVE_E_FS_NOT_EXTENDED = 0x80310047;

enum : int
{
    FVE_E_NO_LICENSE   = 0x80310049,
    FVE_E_NOT_ON_STACK = 0x8031004a,
}

enum int FVE_E_TOKEN_NOT_IMPERSONATED = 0x8031004c;
enum int FVE_E_REBOOT_REQUIRED = 0x8031004e;

enum : int
{
    FVE_E_RAW_ACCESS  = 0x80310050,
    FVE_E_RAW_BLOCKED = 0x80310051,
}

enum int FVE_E_NOT_ALLOWED_IN_VERSION = 0x80310053;
enum int FVE_E_MOR_FAILED = 0x80310055;
enum int FVE_E_TRANSIENT_STATE = 0x80310057;
enum int FVE_E_VOLUME_HANDLE_OPEN = 0x80310059;
enum int FVE_E_INVALID_STARTUP_OPTIONS = 0x8031005b;

enum : int
{
    FVE_E_POLICY_RECOVERY_PASSWORD_REQUIRED = 0x8031005d,
    FVE_E_POLICY_RECOVERY_KEY_NOT_ALLOWED   = 0x8031005e,
    FVE_E_POLICY_RECOVERY_KEY_REQUIRED      = 0x8031005f,
}

enum : int
{
    FVE_E_POLICY_STARTUP_PIN_REQUIRED        = 0x80310061,
    FVE_E_POLICY_STARTUP_KEY_NOT_ALLOWED     = 0x80310062,
    FVE_E_POLICY_STARTUP_KEY_REQUIRED        = 0x80310063,
    FVE_E_POLICY_STARTUP_PIN_KEY_NOT_ALLOWED = 0x80310064,
    FVE_E_POLICY_STARTUP_PIN_KEY_REQUIRED    = 0x80310065,
    FVE_E_POLICY_STARTUP_TPM_NOT_ALLOWED     = 0x80310066,
    FVE_E_POLICY_STARTUP_TPM_REQUIRED        = 0x80310067,
}

enum int FVE_E_KEY_PROTECTOR_NOT_SUPPORTED = 0x80310069;
enum int FVE_E_POLICY_PASSPHRASE_REQUIRED = 0x8031006b;
enum int FVE_E_OS_VOLUME_PASSPHRASE_NOT_ALLOWED = 0x8031006d;
enum int FVE_E_VOLUME_TOO_SMALL = 0x8031006f;
enum int FVE_E_DV_NOT_ALLOWED_BY_GP = 0x80310071;

enum : int
{
    FVE_E_POLICY_USER_CERTIFICATE_REQUIRED                 = 0x80310073,
    FVE_E_POLICY_USER_CERT_MUST_BE_HW                      = 0x80310074,
    FVE_E_POLICY_USER_CONFIGURE_FDV_AUTOUNLOCK_NOT_ALLOWED = 0x80310075,
    FVE_E_POLICY_USER_CONFIGURE_RDV_AUTOUNLOCK_NOT_ALLOWED = 0x80310076,
    FVE_E_POLICY_USER_CONFIGURE_RDV_NOT_ALLOWED            = 0x80310077,
    FVE_E_POLICY_USER_ENABLE_RDV_NOT_ALLOWED               = 0x80310078,
    FVE_E_POLICY_USER_DISABLE_RDV_NOT_ALLOWED              = 0x80310079,
}

enum int FVE_E_POLICY_PASSPHRASE_TOO_SIMPLE = 0x80310081;

enum : int
{
    FVE_E_POLICY_CONFLICT_FDV_RK_OFF_AUK_ON = 0x80310083,
    FVE_E_POLICY_CONFLICT_RDV_RK_OFF_AUK_ON = 0x80310084,
}

enum int FVE_E_POLICY_PROHIBITS_SELFSIGNED = 0x80310086;
enum int FVE_E_CONV_RECOVERY_FAILED = 0x80310088;

enum : int
{
    FVE_E_POLICY_CONFLICT_OSV_RP_OFF_ADB_ON = 0x80310090,
    FVE_E_POLICY_CONFLICT_FDV_RP_OFF_ADB_ON = 0x80310091,
    FVE_E_POLICY_CONFLICT_RDV_RP_OFF_ADB_ON = 0x80310092,
}

enum int FVE_E_PRIVATEKEY_AUTH_FAILED = 0x80310094;
enum int FVE_E_OPERATION_NOT_SUPPORTED_ON_VISTA_VOLUME = 0x80310096;
enum int FVE_E_FIPS_HASH_KDF_NOT_ALLOWED = 0x80310098;

enum : int
{
    FVE_E_INVALID_PIN_CHARS  = 0x8031009a,
    FVE_E_INVALID_DATUM_TYPE = 0x8031009b,
}

enum int FVE_E_MULTIPLE_NKP_CERTS = 0x8031009d;
enum int FVE_E_INVALID_NKP_CERT = 0x8031009f;
enum int FVE_E_PROTECTOR_CHANGE_PIN_MISMATCH = 0x803100a1;
enum int FVE_E_PROTECTOR_CHANGE_MAX_PIN_CHANGE_ATTEMPTS_REACHED = 0x803100a3;
enum int FVE_E_FULL_ENCRYPTION_NOT_ALLOWED_ON_TP_STORAGE = 0x803100a5;
enum int FVE_E_KEY_LENGTH_NOT_SUPPORTED_BY_EDRIVE = 0x803100a7;
enum int FVE_E_PROTECTOR_CHANGE_PASSPHRASE_MISMATCH = 0x803100a9;
enum int FVE_E_NO_PASSPHRASE_WITH_TPM = 0x803100ab;

enum : int
{
    FVE_E_NOT_ALLOWED_ON_CSV_STACK = 0x803100ad,
    FVE_E_NOT_ALLOWED_ON_CLUSTER   = 0x803100ae,
}

enum : int
{
    FVE_E_EDRIVE_BAND_IN_USE         = 0x803100b0,
    FVE_E_EDRIVE_DISALLOWED_BY_GP    = 0x803100b1,
    FVE_E_EDRIVE_INCOMPATIBLE_VOLUME = 0x803100b2,
}

enum int FVE_E_EDRIVE_DV_NOT_SUPPORTED = 0x803100b4;
enum int FVE_E_NO_PREBOOT_KEYBOARD_OR_WINRE_DETECTED = 0x803100b6;
enum int FVE_E_POLICY_REQUIRES_RECOVERY_PASSWORD_ON_TOUCH_DEVICE = 0x803100b8;

enum : int
{
    FVE_E_SECUREBOOT_DISABLED              = 0x803100ba,
    FVE_E_SECUREBOOT_CONFIGURATION_INVALID = 0x803100bb,
}

enum int FVE_E_SHADOW_COPY_PRESENT = 0x803100bd;
enum int FVE_E_EDRIVE_INCOMPATIBLE_FIRMWARE = 0x803100bf;
enum int FVE_E_PASSPHRASE_PROTECTOR_CHANGE_BY_STD_USER_DISALLOWED = 0x803100c1;
enum int FVE_E_LIVEID_ACCOUNT_BLOCKED = 0x803100c3;
enum int FVE_E_DE_FIXED_DATA_NOT_SUPPORTED = 0x803100c5;
enum int FVE_E_DE_WINRE_NOT_CONFIGURED = 0x803100c7;
enum int FVE_E_DE_OS_VOLUME_NOT_PROTECTED = 0x803100c9;
enum int FVE_E_DE_PROTECTION_NOT_YET_ENABLED = 0x803100cb;
enum int FVE_E_DEVICE_LOCKOUT_COUNTER_UNAVAILABLE = 0x803100cd;
enum int FVE_E_BUFFER_TOO_LARGE = 0x803100cf;
enum int FVE_E_DE_PREVENTED_FOR_OS = 0x803100d1;
enum int FVE_E_DE_VOLUME_NOT_SUPPORTED = 0x803100d3;
enum int FVE_E_ADBACKUP_NOT_ENABLED = 0x803100d5;
enum int FVE_E_NOT_DE_VOLUME = 0x803100d7;
enum int FVE_E_OSV_KSR_NOT_ALLOWED = 0x803100d9;

enum : int
{
    FVE_E_AD_BACKUP_REQUIRED_POLICY_NOT_SET_FIXED_DRIVE     = 0x803100db,
    FVE_E_AD_BACKUP_REQUIRED_POLICY_NOT_SET_REMOVABLE_DRIVE = 0x803100dc,
}

enum int FVE_E_EXECUTE_REQUEST_SENT_TOO_SOON = 0x803100de;
enum int FVE_E_DEVICE_NOT_JOINED = 0x803100e0;
enum int FWP_E_CALLOUT_NOT_FOUND = 0x80320001;
enum int FWP_E_FILTER_NOT_FOUND = 0x80320003;

enum : int
{
    FWP_E_PROVIDER_NOT_FOUND         = 0x80320005,
    FWP_E_PROVIDER_CONTEXT_NOT_FOUND = 0x80320006,
}

enum int FWP_E_NOT_FOUND = 0x80320008;

enum : int
{
    FWP_E_IN_USE                      = 0x8032000a,
    FWP_E_DYNAMIC_SESSION_IN_PROGRESS = 0x8032000b,
}

enum int FWP_E_NO_TXN_IN_PROGRESS = 0x8032000d;
enum int FWP_E_TXN_ABORTED = 0x8032000f;
enum int FWP_E_INCOMPATIBLE_TXN = 0x80320011;
enum int FWP_E_NET_EVENTS_DISABLED = 0x80320013;
enum int FWP_E_KM_CLIENTS_ONLY = 0x80320015;
enum int FWP_E_BUILTIN_OBJECT = 0x80320017;
enum int FWP_E_NOTIFICATION_DROPPED = 0x80320019;
enum int FWP_E_INCOMPATIBLE_SA_STATE = 0x8032001b;

enum : int
{
    FWP_E_INVALID_ENUMERATOR = 0x8032001d,
    FWP_E_INVALID_FLAGS      = 0x8032001e,
    FWP_E_INVALID_NET_MASK   = 0x8032001f,
    FWP_E_INVALID_RANGE      = 0x80320020,
    FWP_E_INVALID_INTERVAL   = 0x80320021,
}

enum int FWP_E_NULL_DISPLAY_NAME = 0x80320023;
enum int FWP_E_INVALID_WEIGHT = 0x80320025;
enum int FWP_E_TYPE_MISMATCH = 0x80320027;

enum : int
{
    FWP_E_RESERVED            = 0x80320029,
    FWP_E_DUPLICATE_CONDITION = 0x8032002a,
    FWP_E_DUPLICATE_KEYMOD    = 0x8032002b,
}

enum int FWP_E_ACTION_INCOMPATIBLE_WITH_SUBLAYER = 0x8032002d;
enum int FWP_E_CONTEXT_INCOMPATIBLE_WITH_CALLOUT = 0x8032002f;
enum int FWP_E_INCOMPATIBLE_DH_GROUP = 0x80320031;
enum int FWP_E_NEVER_MATCH = 0x80320033;
enum int FWP_E_INVALID_PARAMETER = 0x80320035;
enum int FWP_E_CALLOUT_NOTIFICATION_FAILED = 0x80320037;
enum int FWP_E_INVALID_CIPHER_TRANSFORM = 0x80320039;
enum int FWP_E_INVALID_TRANSFORM_COMBINATION = 0x8032003b;
enum int FWP_E_INVALID_TUNNEL_ENDPOINT = 0x8032003d;

enum : int
{
    FWP_E_KEY_DICTATOR_ALREADY_REGISTERED       = 0x8032003f,
    FWP_E_KEY_DICTATION_INVALID_KEYING_MATERIAL = 0x80320040,
}

enum int FWP_E_INVALID_DNS_NAME = 0x80320042;
enum int FWP_E_IKEEXT_NOT_RUNNING = 0x80320044;

enum : int
{
    WS_S_ASYNC = 0x003d0000,
    WS_S_END   = 0x003d0001,
}

enum int WS_E_OBJECT_FAULTED = 0x803d0001;
enum int WS_E_INVALID_OPERATION = 0x803d0003;
enum int WS_E_ENDPOINT_ACCESS_DENIED = 0x803d0005;
enum int WS_E_OPERATION_ABANDONED = 0x803d0007;
enum int WS_E_NO_TRANSLATION_AVAILABLE = 0x803d0009;

enum : int
{
    WS_E_ADDRESS_IN_USE        = 0x803d000b,
    WS_E_ADDRESS_NOT_AVAILABLE = 0x803d000c,
}

enum : int
{
    WS_E_ENDPOINT_NOT_AVAILABLE        = 0x803d000e,
    WS_E_ENDPOINT_FAILURE              = 0x803d000f,
    WS_E_ENDPOINT_UNREACHABLE          = 0x803d0010,
    WS_E_ENDPOINT_ACTION_NOT_SUPPORTED = 0x803d0011,
    WS_E_ENDPOINT_TOO_BUSY             = 0x803d0012,
    WS_E_ENDPOINT_FAULT_RECEIVED       = 0x803d0013,
    WS_E_ENDPOINT_DISCONNECTED         = 0x803d0014,
}

enum int WS_E_PROXY_ACCESS_DENIED = 0x803d0016;

enum : int
{
    WS_E_PROXY_REQUIRES_BASIC_AUTH     = 0x803d0018,
    WS_E_PROXY_REQUIRES_DIGEST_AUTH    = 0x803d0019,
    WS_E_PROXY_REQUIRES_NTLM_AUTH      = 0x803d001a,
    WS_E_PROXY_REQUIRES_NEGOTIATE_AUTH = 0x803d001b,
}

enum : int
{
    WS_E_SERVER_REQUIRES_DIGEST_AUTH    = 0x803d001d,
    WS_E_SERVER_REQUIRES_NTLM_AUTH      = 0x803d001e,
    WS_E_SERVER_REQUIRES_NEGOTIATE_AUTH = 0x803d001f,
}

enum : int
{
    WS_E_OTHER                   = 0x803d0021,
    WS_E_SECURITY_TOKEN_EXPIRED  = 0x803d0022,
    WS_E_SECURITY_SYSTEM_FAILURE = 0x803d0023,
}

enum : uint
{
    ERROR_NDIS_BAD_VERSION         = 0x80340004,
    ERROR_NDIS_BAD_CHARACTERISTICS = 0x80340005,
}

enum : uint
{
    ERROR_NDIS_OPEN_FAILED         = 0x80340007,
    ERROR_NDIS_DEVICE_FAILED       = 0x80340008,
    ERROR_NDIS_MULTICAST_FULL      = 0x80340009,
    ERROR_NDIS_MULTICAST_EXISTS    = 0x8034000a,
    ERROR_NDIS_MULTICAST_NOT_FOUND = 0x8034000b,
}

enum uint ERROR_NDIS_RESET_IN_PROGRESS = 0x8034000d;

enum : uint
{
    ERROR_NDIS_INVALID_PACKET    = 0x8034000f,
    ERROR_NDIS_ADAPTER_NOT_READY = 0x80340011,
}

enum : uint
{
    ERROR_NDIS_INVALID_DATA      = 0x80340015,
    ERROR_NDIS_BUFFER_TOO_SHORT  = 0x80340016,
    ERROR_NDIS_INVALID_OID       = 0x80340017,
    ERROR_NDIS_ADAPTER_REMOVED   = 0x80340018,
    ERROR_NDIS_UNSUPPORTED_MEDIA = 0x80340019,
}

enum : uint
{
    ERROR_NDIS_FILE_NOT_FOUND     = 0x8034001b,
    ERROR_NDIS_ERROR_READING_FILE = 0x8034001c,
}

enum uint ERROR_NDIS_RESOURCE_CONFLICT = 0x8034001e;

enum : uint
{
    ERROR_NDIS_INVALID_ADDRESS        = 0x80340022,
    ERROR_NDIS_INVALID_DEVICE_REQUEST = 0x80340010,
}

enum uint ERROR_NDIS_INTERFACE_NOT_FOUND = 0x8034002b;

enum : uint
{
    ERROR_NDIS_INVALID_PORT       = 0x8034002d,
    ERROR_NDIS_INVALID_PORT_STATE = 0x8034002e,
}

enum : uint
{
    ERROR_NDIS_REINIT_REQUIRED           = 0x80340030,
    ERROR_NDIS_NO_QUEUES                 = 0x80340031,
    ERROR_NDIS_DOT11_AUTO_CONFIG_ENABLED = 0x80342000,
    ERROR_NDIS_DOT11_MEDIA_IN_USE        = 0x80342001,
    ERROR_NDIS_DOT11_POWER_STATE_INVALID = 0x80342002,
}

enum uint ERROR_NDIS_PM_PROTOCOL_OFFLOAD_LIST_FULL = 0x80342004;

enum : uint
{
    ERROR_NDIS_DOT11_AP_BAND_CURRENTLY_NOT_AVAILABLE = 0x80342006,
    ERROR_NDIS_DOT11_AP_CHANNEL_NOT_ALLOWED          = 0x80342007,
    ERROR_NDIS_DOT11_AP_BAND_NOT_ALLOWED             = 0x80342008,
}

enum : uint
{
    ERROR_NDIS_OFFLOAD_POLICY              = 0xc034100f,
    ERROR_NDIS_OFFLOAD_CONNECTION_REJECTED = 0xc0341012,
    ERROR_NDIS_OFFLOAD_PATH_REJECTED       = 0xc0341013,
}

enum : uint
{
    ERROR_HV_INVALID_HYPERCALL_INPUT = 0xc0350003,
    ERROR_HV_INVALID_ALIGNMENT       = 0xc0350004,
    ERROR_HV_INVALID_PARAMETER       = 0xc0350005,
}

enum uint ERROR_HV_INVALID_PARTITION_STATE = 0xc0350007;
enum uint ERROR_HV_UNKNOWN_PROPERTY = 0xc0350009;
enum uint ERROR_HV_INSUFFICIENT_MEMORY = 0xc035000b;

enum : uint
{
    ERROR_HV_INVALID_PARTITION_ID  = 0xc035000d,
    ERROR_HV_INVALID_VP_INDEX      = 0xc035000e,
    ERROR_HV_INVALID_PORT_ID       = 0xc0350011,
    ERROR_HV_INVALID_CONNECTION_ID = 0xc0350012,
}

enum uint ERROR_HV_NOT_ACKNOWLEDGED = 0xc0350014;

enum : uint
{
    ERROR_HV_ACKNOWLEDGED               = 0xc0350016,
    ERROR_HV_INVALID_SAVE_RESTORE_STATE = 0xc0350017,
    ERROR_HV_INVALID_SYNIC_STATE        = 0xc0350018,
}

enum uint ERROR_HV_INVALID_PROXIMITY_DOMAIN_INFO = 0xc035001a;

enum : uint
{
    ERROR_HV_INACTIVE            = 0xc035001c,
    ERROR_HV_NO_RESOURCES        = 0xc035001d,
    ERROR_HV_FEATURE_UNAVAILABLE = 0xc035001e,
}

enum uint ERROR_HV_INSUFFICIENT_DEVICE_DOMAINS = 0xc0350038;
enum uint ERROR_HV_CPUID_XSAVE_FEATURE_VALIDATION = 0xc035003d;

enum : uint
{
    ERROR_HV_SMX_ENABLED            = 0xc035003f,
    ERROR_HV_INVALID_LP_INDEX       = 0xc0350041,
    ERROR_HV_INVALID_REGISTER_VALUE = 0xc0350050,
    ERROR_HV_INVALID_VTL_STATE      = 0xc0350051,
}

enum : uint
{
    ERROR_HV_INVALID_DEVICE_ID    = 0xc0350057,
    ERROR_HV_INVALID_DEVICE_STATE = 0xc0350058,
}

enum uint ERROR_HV_PAGE_REQUEST_INVALID = 0xc0350060;
enum uint ERROR_HV_INVALID_CPU_GROUP_STATE = 0xc0350070;
enum uint ERROR_HV_NOT_ALLOWED_WITH_NESTED_VIRT_ACTIVE = 0xc0350072;
enum uint ERROR_HV_EVENT_BUFFER_ALREADY_FREED = 0xc0350074;
enum uint ERROR_HV_NOT_PRESENT = 0xc0351000;
enum uint ERROR_VID_TOO_MANY_HANDLERS = 0xc0370002;
enum uint ERROR_VID_HANDLER_NOT_PRESENT = 0xc0370004;
enum uint ERROR_VID_PARTITION_NAME_TOO_LONG = 0xc0370006;

enum : uint
{
    ERROR_VID_PARTITION_ALREADY_EXISTS = 0xc0370008,
    ERROR_VID_PARTITION_DOES_NOT_EXIST = 0xc0370009,
    ERROR_VID_PARTITION_NAME_NOT_FOUND = 0xc037000a,
}

enum uint ERROR_VID_EXCEEDED_MBP_ENTRY_MAP_LIMIT = 0xc037000c;
enum uint ERROR_VID_CHILD_GPA_PAGE_SET_CORRUPTED = 0xc037000e;
enum uint ERROR_VID_INVALID_NUMA_NODE_INDEX = 0xc0370010;
enum uint ERROR_VID_INVALID_MEMORY_BLOCK_HANDLE = 0xc0370012;

enum : uint
{
    ERROR_VID_INVALID_MESSAGE_QUEUE_HANDLE = 0xc0370014,
    ERROR_VID_INVALID_GPA_RANGE_HANDLE     = 0xc0370015,
}

enum uint ERROR_VID_MEMORY_BLOCK_LOCK_COUNT_EXCEEDED = 0xc0370017;

enum : uint
{
    ERROR_VID_MBPS_ARE_LOCKED      = 0xc0370019,
    ERROR_VID_MESSAGE_QUEUE_CLOSED = 0xc037001a,
}

enum : uint
{
    ERROR_VID_STOP_PENDING            = 0xc037001c,
    ERROR_VID_INVALID_PROCESSOR_STATE = 0xc037001d,
}

enum uint ERROR_VID_KM_INTERFACE_ALREADY_INITIALIZED = 0xc037001f;
enum uint ERROR_VID_MMIO_RANGE_DESTROYED = 0xc0370021;

enum : uint
{
    ERROR_VID_RESERVE_PAGE_SET_IS_BEING_USED = 0xc0370023,
    ERROR_VID_RESERVE_PAGE_SET_TOO_SMALL     = 0xc0370024,
}

enum uint ERROR_VID_MBP_COUNT_EXCEEDED_LIMIT = 0xc0370026;

enum : uint
{
    ERROR_VID_SAVED_STATE_UNRECOGNIZED_ITEM = 0xc0370028,
    ERROR_VID_SAVED_STATE_INCOMPATIBLE      = 0xc0370029,
}

enum : uint
{
    ERROR_VMCOMPUTE_TERMINATED_DURING_START      = 0xc0370100,
    ERROR_VMCOMPUTE_IMAGE_MISMATCH               = 0xc0370101,
    ERROR_VMCOMPUTE_HYPERV_NOT_INSTALLED         = 0xc0370102,
    ERROR_VMCOMPUTE_OPERATION_PENDING            = 0xc0370103,
    ERROR_VMCOMPUTE_TOO_MANY_NOTIFICATIONS       = 0xc0370104,
    ERROR_VMCOMPUTE_INVALID_STATE                = 0xc0370105,
    ERROR_VMCOMPUTE_UNEXPECTED_EXIT              = 0xc0370106,
    ERROR_VMCOMPUTE_TERMINATED                   = 0xc0370107,
    ERROR_VMCOMPUTE_CONNECT_FAILED               = 0xc0370108,
    ERROR_VMCOMPUTE_TIMEOUT                      = 0xc0370109,
    ERROR_VMCOMPUTE_CONNECTION_CLOSED            = 0xc037010a,
    ERROR_VMCOMPUTE_UNKNOWN_MESSAGE              = 0xc037010b,
    ERROR_VMCOMPUTE_UNSUPPORTED_PROTOCOL_VERSION = 0xc037010c,
}

enum : uint
{
    ERROR_VMCOMPUTE_SYSTEM_NOT_FOUND         = 0xc037010e,
    ERROR_VMCOMPUTE_SYSTEM_ALREADY_EXISTS    = 0xc037010f,
    ERROR_VMCOMPUTE_SYSTEM_ALREADY_STOPPED   = 0xc0370110,
    ERROR_VMCOMPUTE_PROTOCOL_ERROR           = 0xc0370111,
    ERROR_VMCOMPUTE_INVALID_LAYER            = 0xc0370112,
    ERROR_VMCOMPUTE_WINDOWS_INSIDER_REQUIRED = 0xc0370113,
}

enum int HCS_E_IMAGE_MISMATCH = 0x80370101;
enum int HCS_E_INVALID_STATE = 0x80370105;
enum int HCS_E_TERMINATED = 0x80370107;

enum : int
{
    HCS_E_CONNECTION_TIMEOUT = 0x80370109,
    HCS_E_CONNECTION_CLOSED  = 0x8037010a,
}

enum int HCS_E_UNSUPPORTED_PROTOCOL_VERSION = 0x8037010c;

enum : int
{
    HCS_E_SYSTEM_NOT_FOUND       = 0x8037010e,
    HCS_E_SYSTEM_ALREADY_EXISTS  = 0x8037010f,
    HCS_E_SYSTEM_ALREADY_STOPPED = 0x80370110,
}

enum int HCS_E_INVALID_LAYER = 0x80370112;
enum int HCS_E_SERVICE_NOT_AVAILABLE = 0x80370114;

enum : int
{
    HCS_E_OPERATION_ALREADY_STARTED             = 0x80370116,
    HCS_E_OPERATION_PENDING                     = 0x80370117,
    HCS_E_OPERATION_TIMEOUT                     = 0x80370118,
    HCS_E_OPERATION_SYSTEM_CALLBACK_ALREADY_SET = 0x80370119,
}

enum int HCS_E_ACCESS_DENIED = 0x8037011b;
enum int HCS_E_PROCESS_INFO_NOT_AVAILABLE = 0x8037011d;
enum int HCS_E_PROCESS_ALREADY_STOPPED = 0x8037011f;
enum uint ERROR_VID_REMOTE_NODE_PARENT_GPA_PAGES_USED = 0x80370001;
enum int WHV_E_INSUFFICIENT_BUFFER = 0x80370301;
enum int WHV_E_UNSUPPORTED_HYPERVISOR_CONFIG = 0x80370303;
enum int WHV_E_GPA_RANGE_NOT_FOUND = 0x80370305;
enum int WHV_E_VP_DOES_NOT_EXIST = 0x80370307;
enum int WHV_E_INVALID_VP_REGISTER_NAME = 0x80370309;

enum : uint
{
    ERROR_VSMB_SAVED_STATE_FILE_NOT_FOUND = 0xc0370400,
    ERROR_VSMB_SAVED_STATE_CORRUPT        = 0xc0370401,
}

enum : int
{
    VM_SAVED_STATE_DUMP_E_GUEST_MEMORY_NOT_FOUND              = 0xc0370501,
    VM_SAVED_STATE_DUMP_E_NO_VP_FOUND_IN_PARTITION_STATE      = 0xc0370502,
    VM_SAVED_STATE_DUMP_E_NESTED_VIRTUALIZATION_NOT_SUPPORTED = 0xc0370503,
}

enum : int
{
    VM_SAVED_STATE_DUMP_E_PXE_NOT_PRESENT   = 0xc0370505,
    VM_SAVED_STATE_DUMP_E_PDPTE_NOT_PRESENT = 0xc0370506,
    VM_SAVED_STATE_DUMP_E_PDE_NOT_PRESENT   = 0xc0370507,
    VM_SAVED_STATE_DUMP_E_PTE_NOT_PRESENT   = 0xc0370508,
}

enum uint ERROR_VOLMGR_INCOMPLETE_DISK_MIGRATION = 0x80380002;

enum : uint
{
    ERROR_VOLMGR_DISK_CONFIGURATION_CORRUPTED   = 0xc0380002,
    ERROR_VOLMGR_DISK_CONFIGURATION_NOT_IN_SYNC = 0xc0380003,
}

enum : uint
{
    ERROR_VOLMGR_DISK_CONTAINS_NON_SIMPLE_VOLUME                = 0xc0380005,
    ERROR_VOLMGR_DISK_DUPLICATE                                 = 0xc0380006,
    ERROR_VOLMGR_DISK_DYNAMIC                                   = 0xc0380007,
    ERROR_VOLMGR_DISK_ID_INVALID                                = 0xc0380008,
    ERROR_VOLMGR_DISK_INVALID                                   = 0xc0380009,
    ERROR_VOLMGR_DISK_LAST_VOTER                                = 0xc038000a,
    ERROR_VOLMGR_DISK_LAYOUT_INVALID                            = 0xc038000b,
    ERROR_VOLMGR_DISK_LAYOUT_NON_BASIC_BETWEEN_BASIC_PARTITIONS = 0xc038000c,
    ERROR_VOLMGR_DISK_LAYOUT_NOT_CYLINDER_ALIGNED               = 0xc038000d,
    ERROR_VOLMGR_DISK_LAYOUT_PARTITIONS_TOO_SMALL               = 0xc038000e,
    ERROR_VOLMGR_DISK_LAYOUT_PRIMARY_BETWEEN_LOGICAL_PARTITIONS = 0xc038000f,
    ERROR_VOLMGR_DISK_LAYOUT_TOO_MANY_PARTITIONS                = 0xc0380010,
    ERROR_VOLMGR_DISK_MISSING                                   = 0xc0380011,
    ERROR_VOLMGR_DISK_NOT_EMPTY                                 = 0xc0380012,
    ERROR_VOLMGR_DISK_NOT_ENOUGH_SPACE                          = 0xc0380013,
    ERROR_VOLMGR_DISK_REVECTORING_FAILED                        = 0xc0380014,
    ERROR_VOLMGR_DISK_SECTOR_SIZE_INVALID                       = 0xc0380015,
    ERROR_VOLMGR_DISK_SET_NOT_CONTAINED                         = 0xc0380016,
    ERROR_VOLMGR_DISK_USED_BY_MULTIPLE_MEMBERS                  = 0xc0380017,
    ERROR_VOLMGR_DISK_USED_BY_MULTIPLE_PLEXES                   = 0xc0380018,
}

enum : uint
{
    ERROR_VOLMGR_EXTENT_ALREADY_USED                = 0xc038001a,
    ERROR_VOLMGR_EXTENT_NOT_CONTIGUOUS              = 0xc038001b,
    ERROR_VOLMGR_EXTENT_NOT_IN_PUBLIC_REGION        = 0xc038001c,
    ERROR_VOLMGR_EXTENT_NOT_SECTOR_ALIGNED          = 0xc038001d,
    ERROR_VOLMGR_EXTENT_OVERLAPS_EBR_PARTITION      = 0xc038001e,
    ERROR_VOLMGR_EXTENT_VOLUME_LENGTHS_DO_NOT_MATCH = 0xc038001f,
}

enum uint ERROR_VOLMGR_INTERLEAVE_LENGTH_INVALID = 0xc0380021;

enum : uint
{
    ERROR_VOLMGR_MEMBER_IN_SYNC            = 0xc0380023,
    ERROR_VOLMGR_MEMBER_INDEX_DUPLICATE    = 0xc0380024,
    ERROR_VOLMGR_MEMBER_INDEX_INVALID      = 0xc0380025,
    ERROR_VOLMGR_MEMBER_MISSING            = 0xc0380026,
    ERROR_VOLMGR_MEMBER_NOT_DETACHED       = 0xc0380027,
    ERROR_VOLMGR_MEMBER_REGENERATING       = 0xc0380028,
    ERROR_VOLMGR_ALL_DISKS_FAILED          = 0xc0380029,
    ERROR_VOLMGR_NO_REGISTERED_USERS       = 0xc038002a,
    ERROR_VOLMGR_NO_SUCH_USER              = 0xc038002b,
    ERROR_VOLMGR_NOTIFICATION_RESET        = 0xc038002c,
    ERROR_VOLMGR_NUMBER_OF_MEMBERS_INVALID = 0xc038002d,
    ERROR_VOLMGR_NUMBER_OF_PLEXES_INVALID  = 0xc038002e,
}

enum : uint
{
    ERROR_VOLMGR_PACK_ID_INVALID         = 0xc0380030,
    ERROR_VOLMGR_PACK_INVALID            = 0xc0380031,
    ERROR_VOLMGR_PACK_NAME_INVALID       = 0xc0380032,
    ERROR_VOLMGR_PACK_OFFLINE            = 0xc0380033,
    ERROR_VOLMGR_PACK_HAS_QUORUM         = 0xc0380034,
    ERROR_VOLMGR_PACK_WITHOUT_QUORUM     = 0xc0380035,
    ERROR_VOLMGR_PARTITION_STYLE_INVALID = 0xc0380036,
    ERROR_VOLMGR_PARTITION_UPDATE_FAILED = 0xc0380037,
}

enum : uint
{
    ERROR_VOLMGR_PLEX_INDEX_DUPLICATE   = 0xc0380039,
    ERROR_VOLMGR_PLEX_INDEX_INVALID     = 0xc038003a,
    ERROR_VOLMGR_PLEX_LAST_ACTIVE       = 0xc038003b,
    ERROR_VOLMGR_PLEX_MISSING           = 0xc038003c,
    ERROR_VOLMGR_PLEX_REGENERATING      = 0xc038003d,
    ERROR_VOLMGR_PLEX_TYPE_INVALID      = 0xc038003e,
    ERROR_VOLMGR_PLEX_NOT_RAID5         = 0xc038003f,
    ERROR_VOLMGR_PLEX_NOT_SIMPLE        = 0xc0380040,
    ERROR_VOLMGR_STRUCTURE_SIZE_INVALID = 0xc0380041,
}

enum uint ERROR_VOLMGR_TRANSACTION_IN_PROGRESS = 0xc0380043;

enum : uint
{
    ERROR_VOLMGR_VOLUME_CONTAINS_MISSING_DISK           = 0xc0380045,
    ERROR_VOLMGR_VOLUME_ID_INVALID                      = 0xc0380046,
    ERROR_VOLMGR_VOLUME_LENGTH_INVALID                  = 0xc0380047,
    ERROR_VOLMGR_VOLUME_LENGTH_NOT_SECTOR_SIZE_MULTIPLE = 0xc0380048,
}

enum : uint
{
    ERROR_VOLMGR_VOLUME_NOT_RETAINED       = 0xc038004a,
    ERROR_VOLMGR_VOLUME_OFFLINE            = 0xc038004b,
    ERROR_VOLMGR_VOLUME_RETAINED           = 0xc038004c,
    ERROR_VOLMGR_NUMBER_OF_EXTENTS_INVALID = 0xc038004d,
}

enum : uint
{
    ERROR_VOLMGR_BAD_BOOT_DISK          = 0xc038004f,
    ERROR_VOLMGR_PACK_CONFIG_OFFLINE    = 0xc0380050,
    ERROR_VOLMGR_PACK_CONFIG_ONLINE     = 0xc0380051,
    ERROR_VOLMGR_NOT_PRIMARY_PACK       = 0xc0380052,
    ERROR_VOLMGR_PACK_LOG_UPDATE_FAILED = 0xc0380053,
}

enum uint ERROR_VOLMGR_NUMBER_OF_DISKS_IN_MEMBER_INVALID = 0xc0380055;
enum uint ERROR_VOLMGR_PLEX_NOT_SIMPLE_SPANNED = 0xc0380057;
enum uint ERROR_VOLMGR_PRIMARY_PACK_PRESENT = 0xc0380059;
enum uint ERROR_VOLMGR_MIRROR_NOT_SUPPORTED = 0xc038005b;
enum uint ERROR_BCD_NOT_ALL_ENTRIES_IMPORTED = 0x80390001;
enum uint ERROR_BCD_NOT_ALL_ENTRIES_SYNCHRONIZED = 0x80390003;

enum : uint
{
    ERROR_VHD_DRIVE_FOOTER_CHECKSUM_MISMATCH = 0xc03a0002,
    ERROR_VHD_DRIVE_FOOTER_CORRUPT           = 0xc03a0003,
}

enum uint ERROR_VHD_FORMAT_UNSUPPORTED_VERSION = 0xc03a0005;

enum : uint
{
    ERROR_VHD_SPARSE_HEADER_UNSUPPORTED_VERSION = 0xc03a0007,
    ERROR_VHD_SPARSE_HEADER_CORRUPT             = 0xc03a0008,
}

enum uint ERROR_VHD_BLOCK_ALLOCATION_TABLE_CORRUPT = 0xc03a000a;
enum uint ERROR_VHD_BITMAP_MISMATCH = 0xc03a000c;

enum : uint
{
    ERROR_VHD_CHILD_PARENT_ID_MISMATCH        = 0xc03a000e,
    ERROR_VHD_CHILD_PARENT_TIMESTAMP_MISMATCH = 0xc03a000f,
}

enum uint ERROR_VHD_METADATA_WRITE_FAILURE = 0xc03a0011;
enum uint ERROR_VHD_INVALID_FILE_SIZE = 0xc03a0013;
enum uint ERROR_VIRTDISK_NOT_VIRTUAL_DISK = 0xc03a0015;
enum uint ERROR_VHD_CHILD_PARENT_SIZE_MISMATCH = 0xc03a0017;
enum uint ERROR_VHD_DIFFERENCING_CHAIN_ERROR_IN_PARENT = 0xc03a0019;

enum : uint
{
    ERROR_VHD_INVALID_TYPE  = 0xc03a001b,
    ERROR_VHD_INVALID_STATE = 0xc03a001c,
}

enum : uint
{
    ERROR_VIRTDISK_DISK_ALREADY_OWNED       = 0xc03a001e,
    ERROR_VIRTDISK_DISK_ONLINE_AND_WRITABLE = 0xc03a001f,
}

enum uint ERROR_CTLOG_LOGFILE_SIZE_EXCEEDED_MAXSIZE = 0xc03a0021;

enum : uint
{
    ERROR_CTLOG_INVALID_TRACKING_STATE     = 0xc03a0023,
    ERROR_CTLOG_INCONSISTENT_TRACKING_FILE = 0xc03a0024,
}

enum uint ERROR_VHD_COULD_NOT_COMPUTE_MINIMUM_VIRTUAL_SIZE = 0xc03a0026;

enum : uint
{
    ERROR_VHD_METADATA_FULL              = 0xc03a0028,
    ERROR_VHD_INVALID_CHANGE_TRACKING_ID = 0xc03a0029,
}

enum uint ERROR_VHD_MISSING_CHANGE_TRACKING_INFORMATION = 0xc03a0030;
enum int HCN_E_NETWORK_NOT_FOUND = 0x803b0001;
enum int HCN_E_LAYER_NOT_FOUND = 0x803b0003;
enum int HCN_E_SUBNET_NOT_FOUND = 0x803b0005;
enum int HCN_E_PORT_NOT_FOUND = 0x803b0007;
enum int HCN_E_VFP_PORTSETTING_NOT_FOUND = 0x803b0009;

enum : int
{
    HCN_E_INVALID_NETWORK_TYPE              = 0x803b000b,
    HCN_E_INVALID_ENDPOINT                  = 0x803b000c,
    HCN_E_INVALID_POLICY                    = 0x803b000d,
    HCN_E_INVALID_POLICY_TYPE               = 0x803b000e,
    HCN_E_INVALID_REMOTE_ENDPOINT_OPERATION = 0x803b000f,
}

enum int HCN_E_LAYER_ALREADY_EXISTS = 0x803b0011;
enum int HCN_E_PORT_ALREADY_EXISTS = 0x803b0013;
enum int HCN_E_REQUEST_UNSUPPORTED = 0x803b0015;
enum int HCN_E_DEGRADED_OPERATION = 0x803b0017;
enum int HCN_E_GUID_CONVERSION_FAILURE = 0x803b0019;

enum : int
{
    HCN_E_INVALID_JSON           = 0x803b001b,
    HCN_E_INVALID_JSON_REFERENCE = 0x803b001c,
}

enum int HCN_E_INVALID_IP = 0x803b001e;
enum int HCN_E_MANAGER_STOPPED = 0x803b0020;
enum int GCN_E_NO_REQUEST_HANDLERS = 0x803b0022;
enum int GCN_E_RUNTIMEKEYS_FAILED = 0x803b0024;
enum int GCN_E_NETADAPTER_NOT_FOUND = 0x803b0026;
enum int GCN_E_NETINTERFACE_NOT_FOUND = 0x803b0028;
enum int HCN_E_ICS_DISABLED = 0x803b002a;
enum int HCN_E_ENTITY_HAS_REFERENCES = 0x803b002c;
enum int HCN_E_NAMESPACE_ATTACH_FAILED = 0x803b002e;
enum int HCN_E_INVALID_PREFIX = 0x803b0030;

enum : int
{
    HCN_E_INVALID_SUBNET    = 0x803b0032,
    HCN_E_INVALID_IP_SUBNET = 0x803b0033,
}

enum int HCN_E_ENDPOINT_NOT_LOCAL = 0x803b0035;

enum : uint
{
    SDIAG_E_CANCELLED   = 0x803c0100,
    SDIAG_E_SCRIPT      = 0x803c0101,
    SDIAG_E_POWERSHELL  = 0x803c0102,
    SDIAG_E_MANAGEDHOST = 0x803c0103,
    SDIAG_E_NOVERIFIER  = 0x803c0104,
}

enum : uint
{
    SDIAG_E_DISABLED  = 0x803c0106,
    SDIAG_E_TRUST     = 0x803c0107,
    SDIAG_E_CANNOTRUN = 0x803c0108,
    SDIAG_E_VERSION   = 0x803c0109,
    SDIAG_E_RESOURCE  = 0x803c010a,
    SDIAG_E_ROOTCAUSE = 0x803c010b,
}

enum int WPN_E_CHANNEL_REQUEST_NOT_COMPLETE = 0x803e0101;
enum int WPN_E_OUTSTANDING_CHANNEL_REQUEST = 0x803e0103;
enum int WPN_E_PLATFORM_UNAVAILABLE = 0x803e0105;

enum : int
{
    WPN_E_NOTIFICATION_HIDDEN     = 0x803e0107,
    WPN_E_NOTIFICATION_NOT_POSTED = 0x803e0108,
}

enum : int
{
    WPN_E_CLOUD_INCAPABLE           = 0x803e0110,
    WPN_E_CLOUD_AUTH_UNAVAILABLE    = 0x803e011a,
    WPN_E_CLOUD_SERVICE_UNAVAILABLE = 0x803e011b,
}

enum : int
{
    WPN_E_NOTIFICATION_DISABLED  = 0x803e0111,
    WPN_E_NOTIFICATION_INCAPABLE = 0x803e0112,
}

enum : int
{
    WPN_E_NOTIFICATION_TYPE_DISABLED = 0x803e0114,
    WPN_E_NOTIFICATION_SIZE          = 0x803e0115,
}

enum int WPN_E_ACCESS_DENIED = 0x803e0117;
enum int WPN_E_PUSH_NOTIFICATION_INCAPABLE = 0x803e0119;
enum int WPN_E_TAG_ALPHANUMERIC = 0x803e012a;
enum int WPN_E_OUT_OF_SESSION = 0x803e0200;
enum int WPN_E_IMAGE_NOT_FOUND_IN_CACHE = 0x803e0202;
enum int WPN_E_INVALID_CLOUD_IMAGE = 0x803e0204;
enum int WPN_E_CALLBACK_ALREADY_REGISTERED = 0x803e0206;
enum int WPN_E_STORAGE_LOCKED = 0x803e0208;
enum int WPN_E_GROUP_ALPHANUMERIC = 0x803e020a;
enum int E_MBN_CONTEXT_NOT_ACTIVATED = 0x80548201;
enum int E_MBN_DATA_CLASS_NOT_AVAILABLE = 0x80548203;
enum int E_MBN_MAX_ACTIVATED_CONTEXTS = 0x80548205;
enum int E_MBN_PROVIDER_NOT_VISIBLE = 0x80548207;
enum int E_MBN_SERVICE_NOT_ACTIVATED = 0x80548209;
enum int E_MBN_VOICE_CALL_IN_PROGRESS = 0x8054820b;
enum int E_MBN_NOT_REGISTERED = 0x8054820d;

enum : int
{
    E_MBN_PIN_NOT_SUPPORTED = 0x8054820f,
    E_MBN_PIN_REQUIRED      = 0x80548210,
    E_MBN_PIN_DISABLED      = 0x80548211,
}

enum int E_MBN_INVALID_PROFILE = 0x80548218;
enum int E_MBN_SMS_ENCODING_NOT_SUPPORTED = 0x80548220;
enum int E_MBN_SMS_INVALID_MEMORY_INDEX = 0x80548222;

enum : int
{
    E_MBN_SMS_MEMORY_FAILURE  = 0x80548224,
    E_MBN_SMS_NETWORK_TIMEOUT = 0x80548225,
}

enum int E_MBN_SMS_FORMAT_NOT_SUPPORTED = 0x80548227;
enum int E_MBN_SMS_MEMORY_FULL = 0x80548229;
enum int PEER_E_NOT_INITIALIZED = 0x80630002;
enum int PEER_E_NOT_LICENSED = 0x80630004;
enum int PEER_E_DBNAME_CHANGED = 0x80630011;

enum : int
{
    PEER_E_GRAPH_NOT_READY     = 0x80630013,
    PEER_E_GRAPH_SHUTTING_DOWN = 0x80630014,
    PEER_E_GRAPH_IN_USE        = 0x80630015,
}

enum int PEER_E_TOO_MANY_ATTRIBUTES = 0x80630017;
enum int PEER_E_CONNECT_SELF = 0x80630106;
enum int PEER_E_NODE_NOT_FOUND = 0x80630108;

enum : int
{
    PEER_E_CONNECTION_NOT_AUTHENTICATED = 0x8063010a,
    PEER_E_CONNECTION_REFUSED           = 0x8063010b,
}

enum int PEER_E_TOO_MANY_IDENTITIES = 0x80630202;
enum int PEER_E_GROUPS_EXIST = 0x80630204;
enum int PEER_E_DATABASE_ACCESSDENIED = 0x80630302;
enum int PEER_E_MAX_RECORD_SIZE_EXCEEDED = 0x80630304;
enum int PEER_E_DATABASE_NOT_PRESENT = 0x80630306;
enum int PEER_E_EVENT_HANDLE_NOT_FOUND = 0x80630501;
enum int PEER_E_INVALID_ATTRIBUTES = 0x80630602;
enum int PEER_E_CHAIN_TOO_LONG = 0x80630703;
enum int PEER_E_CIRCULAR_CHAIN_DETECTED = 0x80630706;

enum : int
{
    PEER_E_NO_CLOUD             = 0x80631001,
    PEER_E_CLOUD_NAME_AMBIGUOUS = 0x80631005,
}

enum int PEER_E_NOT_AUTHORIZED = 0x80632020;
enum int PEER_E_DEFERRED_VALIDATION = 0x80632030;

enum : int
{
    PEER_E_INVALID_PEER_NAME           = 0x80632050,
    PEER_E_INVALID_CLASSIFIER          = 0x80632060,
    PEER_E_INVALID_FRIENDLY_NAME       = 0x80632070,
    PEER_E_INVALID_ROLE_PROPERTY       = 0x80632071,
    PEER_E_INVALID_CLASSIFIER_PROPERTY = 0x80632072,
    PEER_E_INVALID_RECORD_EXPIRATION   = 0x80632080,
    PEER_E_INVALID_CREDENTIAL_INFO     = 0x80632081,
    PEER_E_INVALID_CREDENTIAL          = 0x80632082,
    PEER_E_INVALID_RECORD_SIZE         = 0x80632083,
}

enum : int
{
    PEER_E_GROUP_NOT_READY = 0x80632091,
    PEER_E_GROUP_IN_USE    = 0x80632092,
}

enum : int
{
    PEER_E_NO_MEMBERS_FOUND      = 0x80632094,
    PEER_E_NO_MEMBER_CONNECTIONS = 0x80632095,
}

enum int PEER_E_IDENTITY_DELETED = 0x806320a0;
enum int PEER_E_CONTACT_NOT_FOUND = 0x80636001;
enum int PEER_S_NO_EVENT_DATA = 0x00630002;
enum int PEER_S_SUBSCRIPTION_EXISTS = 0x00636000;
enum int PEER_S_ALREADY_A_MEMBER = 0x00630006;
enum int PEER_E_INVALID_PEER_HOST_NAME = 0x80634002;
enum int PEER_E_PNRP_DUPLICATE_PEER_NAME = 0x80634005;
enum int PEER_E_INVITE_RESPONSE_NOT_AVAILABLE = 0x80637001;
enum int PEER_E_PRIVACY_DECLINED = 0x80637004;
enum int PEER_E_INVALID_ADDRESS = 0x80637007;

enum : int
{
    PEER_E_FW_BLOCKED_BY_POLICY     = 0x80637009,
    PEER_E_FW_BLOCKED_BY_SHIELDS_UP = 0x8063700a,
}

enum int UI_E_CREATE_FAILED = 0x802a0001;
enum int UI_E_ILLEGAL_REENTRANCY = 0x802a0003;

enum : int
{
    UI_E_VALUE_NOT_SET        = 0x802a0005,
    UI_E_VALUE_NOT_DETERMINED = 0x802a0006,
}

enum int UI_E_BOOLEAN_EXPECTED = 0x802a0008;
enum int UI_E_AMBIGUOUS_MATCH = 0x802a000a;
enum int UI_E_WRONG_THREAD = 0x802a000c;
enum int UI_E_STORYBOARD_NOT_PLAYING = 0x802a0102;
enum int UI_E_END_KEYFRAME_NOT_DETERMINED = 0x802a0104;

enum : int
{
    UI_E_TRANSITION_ALREADY_USED      = 0x802a0106,
    UI_E_TRANSITION_NOT_IN_STORYBOARD = 0x802a0107,
    UI_E_TRANSITION_ECLIPSED          = 0x802a0108,
}

enum int UI_E_TIMER_CLIENT_ALREADY_CONNECTED = 0x802a010a;
enum int UI_E_PRIMITIVE_OUT_OF_BOUNDS = 0x802a010c;

enum : int
{
    E_BLUETOOTH_ATT_INVALID_HANDLE              = 0x80650001,
    E_BLUETOOTH_ATT_READ_NOT_PERMITTED          = 0x80650002,
    E_BLUETOOTH_ATT_WRITE_NOT_PERMITTED         = 0x80650003,
    E_BLUETOOTH_ATT_INVALID_PDU                 = 0x80650004,
    E_BLUETOOTH_ATT_INSUFFICIENT_AUTHENTICATION = 0x80650005,
}

enum : int
{
    E_BLUETOOTH_ATT_INVALID_OFFSET             = 0x80650007,
    E_BLUETOOTH_ATT_INSUFFICIENT_AUTHORIZATION = 0x80650008,
}

enum : int
{
    E_BLUETOOTH_ATT_ATTRIBUTE_NOT_FOUND              = 0x8065000a,
    E_BLUETOOTH_ATT_ATTRIBUTE_NOT_LONG               = 0x8065000b,
    E_BLUETOOTH_ATT_INSUFFICIENT_ENCRYPTION_KEY_SIZE = 0x8065000c,
}

enum : int
{
    E_BLUETOOTH_ATT_UNLIKELY                = 0x8065000e,
    E_BLUETOOTH_ATT_INSUFFICIENT_ENCRYPTION = 0x8065000f,
    E_BLUETOOTH_ATT_UNSUPPORTED_GROUP_TYPE  = 0x80650010,
    E_BLUETOOTH_ATT_INSUFFICIENT_RESOURCES  = 0x80650011,
    E_BLUETOOTH_ATT_UNKNOWN_ERROR           = 0x80651000,
}

enum int E_HDAUDIO_EMPTY_CONNECTION_LIST = 0x80660002;
enum int E_HDAUDIO_NO_LOGICAL_DEVICES_CREATED = 0x80660004;
enum int STATEREPOSITORY_E_CONCURRENCY_LOCKING_FAILURE = 0x80670001;

enum : int
{
    STATEREPOSITORY_E_CONFIGURATION_INVALID          = 0x80670003,
    STATEREPOSITORY_E_UNKNOWN_SCHEMA_VERSION         = 0x80670004,
    STATEREPOSITORY_ERROR_DICTIONARY_CORRUPTED       = 0x80670005,
    STATEREPOSITORY_E_BLOCKED                        = 0x80670006,
    STATEREPOSITORY_E_BUSY_RETRY                     = 0x80670007,
    STATEREPOSITORY_E_BUSY_RECOVERY_RETRY            = 0x80670008,
    STATEREPOSITORY_E_LOCKED_RETRY                   = 0x80670009,
    STATEREPOSITORY_E_LOCKED_SHAREDCACHE_RETRY       = 0x8067000a,
    STATEREPOSITORY_E_TRANSACTION_REQUIRED           = 0x8067000b,
    STATEREPOSITORY_E_BUSY_TIMEOUT_EXCEEDED          = 0x8067000c,
    STATEREPOSITORY_E_BUSY_RECOVERY_TIMEOUT_EXCEEDED = 0x8067000d,
}

enum int STATEREPOSITORY_E_LOCKED_SHAREDCACHE_TIMEOUT_EXCEEDED = 0x8067000f;
enum int STATEREPOSTORY_E_NESTED_TRANSACTION_NOT_SUPPORTED = 0x80670011;

enum : int
{
    STATEREPOSITORY_TRANSACTION_CALLER_ID_CHANGED = 0x00670013,
    STATEREPOSITORY_TRANSACTION_IN_PROGRESS       = 0x00670014,
}

enum int ERROR_SPACES_FAULT_DOMAIN_TYPE_INVALID = 0x80e70001;
enum int ERROR_SPACES_RESILIENCY_TYPE_INVALID = 0x80e70003;
enum int ERROR_SPACES_DRIVE_REDUNDANCY_INVALID = 0x80e70006;
enum int ERROR_SPACES_PARITY_LAYOUT_INVALID = 0x80e70008;
enum int ERROR_SPACES_NUMBER_OF_COLUMNS_INVALID = 0x80e7000a;

enum : int
{
    ERROR_SPACES_EXTENDED_ERROR            = 0x80e7000c,
    ERROR_SPACES_PROVISIONING_TYPE_INVALID = 0x80e7000d,
}

enum int ERROR_SPACES_ENCLOSURE_AWARE_INVALID = 0x80e7000f;
enum int ERROR_SPACES_NUMBER_OF_GROUPS_INVALID = 0x80e70011;

enum : int
{
    ERROR_SPACES_ENTRY_INCOMPLETE = 0x80e70013,
    ERROR_SPACES_ENTRY_INVALID    = 0x80e70014,
}

enum int ERROR_VOLSNAP_ACTIVATION_TIMEOUT = 0x80820002;
enum int ERROR_TIERING_VOLUME_DISMOUNT_IN_PROGRESS = 0x80830002;

enum : int
{
    ERROR_TIERING_INVALID_FILE_ID    = 0x80830004,
    ERROR_TIERING_WRONG_CLUSTER_NODE = 0x80830005,
    ERROR_TIERING_ALREADY_PROCESSING = 0x80830006,
    ERROR_TIERING_CANNOT_PIN_OBJECT  = 0x80830007,
    ERROR_TIERING_FILE_IS_NOT_PINNED = 0x80830008,
}

enum int ERROR_ATTRIBUTE_NOT_PRESENT = 0x8083000a;
enum int ERROR_NO_APPLICABLE_APP_LICENSES_FOUND = 0xc0ea0001;
enum int ERROR_CLIP_DEVICE_LICENSE_MISSING = 0xc0ea0003;
enum int ERROR_CLIP_KEYHOLDER_LICENSE_MISSING_OR_INVALID = 0xc0ea0005;

enum : int
{
    ERROR_CLIP_LICENSE_SIGNED_BY_UNKNOWN_SOURCE     = 0xc0ea0007,
    ERROR_CLIP_LICENSE_NOT_SIGNED                   = 0xc0ea0008,
    ERROR_CLIP_LICENSE_HARDWARE_ID_OUT_OF_TOLERANCE = 0xc0ea0009,
    ERROR_CLIP_LICENSE_DEVICE_ID_MISMATCH           = 0xc0ea000a,
}

enum : int
{
    DXGI_STATUS_CLIPPED                      = 0x087a0002,
    DXGI_STATUS_NO_REDIRECTION               = 0x087a0004,
    DXGI_STATUS_NO_DESKTOP_ACCESS            = 0x087a0005,
    DXGI_STATUS_GRAPHICS_VIDPN_SOURCE_IN_USE = 0x087a0006,
}

enum int DXGI_STATUS_MODE_CHANGE_IN_PROGRESS = 0x087a0008;

enum : int
{
    DXGI_ERROR_NOT_FOUND         = 0x887a0002,
    DXGI_ERROR_MORE_DATA         = 0x887a0003,
    DXGI_ERROR_UNSUPPORTED       = 0x887a0004,
    DXGI_ERROR_DEVICE_REMOVED    = 0x887a0005,
    DXGI_ERROR_DEVICE_HUNG       = 0x887a0006,
    DXGI_ERROR_DEVICE_RESET      = 0x887a0007,
    DXGI_ERROR_WAS_STILL_DRAWING = 0x887a000a,
}

enum int DXGI_ERROR_GRAPHICS_VIDPN_SOURCE_IN_USE = 0x887a000c;

enum : int
{
    DXGI_ERROR_NONEXCLUSIVE            = 0x887a0021,
    DXGI_ERROR_NOT_CURRENTLY_AVAILABLE = 0x887a0022,
}

enum int DXGI_ERROR_REMOTE_OUTOFMEMORY = 0x887a0024;

enum : int
{
    DXGI_ERROR_WAIT_TIMEOUT         = 0x887a0027,
    DXGI_ERROR_SESSION_DISCONNECTED = 0x887a0028,
}

enum int DXGI_ERROR_CANNOT_PROTECT_CONTENT = 0x887a002a;
enum int DXGI_ERROR_NAME_ALREADY_EXISTS = 0x887a002c;

enum : int
{
    DXGI_ERROR_NOT_CURRENT               = 0x887a002e,
    DXGI_ERROR_HW_PROTECTION_OUTOFMEMORY = 0x887a0030,
}

enum int DXGI_ERROR_NON_COMPOSITED_UI = 0x887a0032;

enum : int
{
    DXGI_STATUS_UNOCCLUDED            = 0x087a0009,
    DXGI_STATUS_DDA_WAS_STILL_DRAWING = 0x087a000a,
}

enum int DXGI_STATUS_PRESENT_REQUIRED = 0x087a002f;

enum : int
{
    DXGI_ERROR_CACHE_FULL           = 0x887a0034,
    DXGI_ERROR_CACHE_HASH_COLLISION = 0x887a0035,
}

enum : int
{
    DXGI_DDI_ERR_WASSTILLDRAWING = 0x887b0001,
    DXGI_DDI_ERR_UNSUPPORTED     = 0x887b0002,
    DXGI_DDI_ERR_NONEXCLUSIVE    = 0x887b0003,
}

enum int D3D10_ERROR_FILE_NOT_FOUND = 0x88790002;

enum : int
{
    D3D11_ERROR_FILE_NOT_FOUND               = 0x887c0002,
    D3D11_ERROR_TOO_MANY_UNIQUE_VIEW_OBJECTS = 0x887c0003,
}

enum : int
{
    D3D12_ERROR_ADAPTER_NOT_FOUND       = 0x887e0001,
    D3D12_ERROR_DRIVER_VERSION_MISMATCH = 0x887e0002,
}

enum int D2DERR_NOT_INITIALIZED = 0x88990002;

enum : int
{
    D2DERR_SCANNER_FAILED       = 0x88990004,
    D2DERR_SCREEN_ACCESS_DENIED = 0x88990005,
}

enum int D2DERR_ZERO_VECTOR = 0x88990007;
enum int D2DERR_DISPLAY_FORMAT_NOT_SUPPORTED = 0x88990009;
enum int D2DERR_NO_HARDWARE_DEVICE = 0x8899000b;
enum int D2DERR_TOO_MANY_SHADER_ELEMENTS = 0x8899000d;
enum int D2DERR_MAX_TEXTURE_SIZE_EXCEEDED = 0x8899000f;

enum : int
{
    D2DERR_BAD_NUMBER    = 0x88990011,
    D2DERR_WRONG_FACTORY = 0x88990012,
}

enum int D2DERR_POP_CALL_DID_NOT_MATCH_PUSH = 0x88990014;
enum int D2DERR_PUSH_POP_UNBALANCED = 0x88990016;
enum int D2DERR_INCOMPATIBLE_BRUSH_TYPES = 0x88990018;
enum int D2DERR_TARGET_NOT_GDI_COMPATIBLE = 0x8899001a;
enum int D2DERR_TEXT_RENDERER_NOT_RELEASED = 0x8899001c;

enum : int
{
    D2DERR_INVALID_GRAPH_CONFIGURATION          = 0x8899001e,
    D2DERR_INVALID_INTERNAL_GRAPH_CONFIGURATION = 0x8899001f,
}

enum int D2DERR_BITMAP_CANNOT_DRAW = 0x88990021;
enum int D2DERR_ORIGINAL_TARGET_NOT_BOUND = 0x88990023;
enum int D2DERR_BITMAP_BOUND_AS_TARGET = 0x88990025;
enum int D2DERR_INTERMEDIATE_TOO_LARGE = 0x88990027;
enum int D2DERR_INVALID_PROPERTY = 0x88990029;

enum : int
{
    D2DERR_PRINT_JOB_CLOSED           = 0x8899002b,
    D2DERR_PRINT_FORMAT_NOT_SUPPORTED = 0x8899002c,
}

enum int D2DERR_INVALID_GLYPH_IMAGE = 0x8899002e;

enum : int
{
    DWRITE_E_UNEXPECTED             = 0x88985001,
    DWRITE_E_NOFONT                 = 0x88985002,
    DWRITE_E_FILENOTFOUND           = 0x88985003,
    DWRITE_E_FILEACCESS             = 0x88985004,
    DWRITE_E_FONTCOLLECTIONOBSOLETE = 0x88985005,
}

enum : int
{
    DWRITE_E_CACHEFORMAT          = 0x88985007,
    DWRITE_E_CACHEVERSION         = 0x88985008,
    DWRITE_E_UNSUPPORTEDOPERATION = 0x88985009,
}

enum int DWRITE_E_FLOWDIRECTIONCONFLICTS = 0x8898500b;

enum : int
{
    DWRITE_E_REMOTEFONT        = 0x8898500d,
    DWRITE_E_DOWNLOADCANCELLED = 0x8898500e,
    DWRITE_E_DOWNLOADFAILED    = 0x8898500f,
}

enum : int
{
    WINCODEC_ERR_WRONGSTATE            = 0x88982f04,
    WINCODEC_ERR_VALUEOUTOFRANGE       = 0x88982f05,
    WINCODEC_ERR_UNKNOWNIMAGEFORMAT    = 0x88982f07,
    WINCODEC_ERR_UNSUPPORTEDVERSION    = 0x88982f0b,
    WINCODEC_ERR_NOTINITIALIZED        = 0x88982f0c,
    WINCODEC_ERR_ALREADYLOCKED         = 0x88982f0d,
    WINCODEC_ERR_PROPERTYNOTFOUND      = 0x88982f40,
    WINCODEC_ERR_PROPERTYNOTSUPPORTED  = 0x88982f41,
    WINCODEC_ERR_PROPERTYSIZE          = 0x88982f42,
    WINCODEC_ERR_CODECPRESENT          = 0x88982f43,
    WINCODEC_ERR_CODECNOTHUMBNAIL      = 0x88982f44,
    WINCODEC_ERR_PALETTEUNAVAILABLE    = 0x88982f45,
    WINCODEC_ERR_CODECTOOMANYSCANLINES = 0x88982f46,
}

enum int WINCODEC_ERR_SOURCERECTDOESNOTMATCHDIMENSIONS = 0x88982f49;

enum : int
{
    WINCODEC_ERR_IMAGESIZEOUTOFRANGE    = 0x88982f51,
    WINCODEC_ERR_TOOMUCHMETADATA        = 0x88982f52,
    WINCODEC_ERR_BADIMAGE               = 0x88982f60,
    WINCODEC_ERR_BADHEADER              = 0x88982f61,
    WINCODEC_ERR_FRAMEMISSING           = 0x88982f62,
    WINCODEC_ERR_BADMETADATAHEADER      = 0x88982f63,
    WINCODEC_ERR_BADSTREAMDATA          = 0x88982f70,
    WINCODEC_ERR_STREAMWRITE            = 0x88982f71,
    WINCODEC_ERR_STREAMREAD             = 0x88982f72,
    WINCODEC_ERR_STREAMNOTAVAILABLE     = 0x88982f73,
    WINCODEC_ERR_UNSUPPORTEDPIXELFORMAT = 0x88982f80,
    WINCODEC_ERR_UNSUPPORTEDOPERATION   = 0x88982f81,
}

enum int WINCODEC_ERR_COMPONENTINITIALIZEFAILURE = 0x88982f8b;
enum int WINCODEC_ERR_DUPLICATEMETADATAPRESENT = 0x88982f8d;

enum : int
{
    WINCODEC_ERR_UNEXPECTEDSIZE         = 0x88982f8f,
    WINCODEC_ERR_INVALIDQUERYREQUEST    = 0x88982f90,
    WINCODEC_ERR_UNEXPECTEDMETADATATYPE = 0x88982f91,
}

enum int WINCODEC_ERR_INVALIDQUERYCHARACTER = 0x88982f93;

enum : int
{
    WINCODEC_ERR_INVALIDPROGRESSIVELEVEL = 0x88982f95,
    WINCODEC_ERR_INVALIDJPEGSCANINDEX    = 0x88982f96,
}

enum int MILERR_INSUFFICIENTBUFFER = 0x88980002;

enum : int
{
    MILERR_SCANNER_FAILED     = 0x88980004,
    MILERR_SCREENACCESSDENIED = 0x88980005,
}

enum int MILERR_NONINVERTIBLEMATRIX = 0x88980007;

enum : int
{
    MILERR_TERMINATED    = 0x88980009,
    MILERR_BADNUMBER     = 0x8898000a,
    MILERR_INTERNALERROR = 0x88980080,
}

enum int MILERR_INVALIDCALL = 0x88980085;

enum : int
{
    MILERR_NOTLOCKED              = 0x88980087,
    MILERR_DEVICECANNOTRENDERTEXT = 0x88980088,
}

enum int MILERR_MALFORMEDGLYPHCACHE = 0x8898008a;
enum int MILERR_MALFORMED_GUIDELINE_DATA = 0x8898008c;
enum int MILERR_NEED_RECREATE_AND_PRESENT = 0x8898008e;
enum int MILERR_MISMATCHED_SIZE = 0x88980090;
enum int MILERR_REMOTING_NOT_SUPPORTED = 0x88980092;
enum int MILERR_NOT_QUEUING_PRESENTS = 0x88980094;
enum int MILERR_TOOMANYSHADERELEMNTS = 0x88980096;
enum int MILERR_MROW_UPDATE_FAILED = 0x88980098;
enum int MILERR_MAX_TEXTURE_SIZE_EXCEEDED = 0x8898009a;
enum int MILERR_DXGI_ENUMERATION_OUT_OF_SYNC = 0x8898009d;
enum int MILERR_COLORSPACE_NOT_SUPPORTED = 0x8898009f;
enum int MILERR_DISPLAYID_ACCESS_DENIED = 0x889800a1;
enum int UCEERR_UNKNOWNPACKET = 0x88980401;
enum int UCEERR_MALFORMEDPACKET = 0x88980403;
enum int UCEERR_HANDLELOOKUPFAILED = 0x88980405;
enum int UCEERR_CTXSTACKFRSTTARGETNULL = 0x88980407;

enum : int
{
    UCEERR_BLOCKSFULL    = 0x88980409,
    UCEERR_MEMORYFAILURE = 0x8898040a,
}

enum int UCEERR_ILLEGALRECORDTYPE = 0x8898040c;
enum int UCEERR_UNCHANGABLE_UPDATE_ATTEMPTED = 0x8898040e;
enum int UCEERR_REMOTINGNOTSUPPORTED = 0x88980410;
enum int UCEERR_MISSINGBEGINCOMMAND = 0x88980412;
enum int UCEERR_CHANNELSYNCABANDONED = 0x88980414;
enum int UCEERR_TRANSPORTUNAVAILABLE = 0x88980416;
enum int UCEERR_COMMANDTRANSPORTDENIED = 0x88980418;
enum int UCEERR_GRAPHICSSTREAMALREADYOPEN = 0x88980420;
enum int UCEERR_TRANSPORTOVERLOADED = 0x88980422;

enum : int
{
    MILAVERR_NOCLOCK          = 0x88980500,
    MILAVERR_NOMEDIATYPE      = 0x88980501,
    MILAVERR_NOVIDEOMIXER     = 0x88980502,
    MILAVERR_NOVIDEOPRESENTER = 0x88980503,
    MILAVERR_NOREADYFRAMES    = 0x88980504,
    MILAVERR_MODULENOTLOADED  = 0x88980505,
}

enum : int
{
    MILAVERR_INVALIDWMPVERSION          = 0x88980507,
    MILAVERR_INSUFFICIENTVIDEORESOURCES = 0x88980508,
}

enum int MILAVERR_REQUESTEDTEXTURETOOBIG = 0x8898050a;
enum int MILAVERR_UNEXPECTEDWMPFAILURE = 0x8898050c;
enum int MILAVERR_UNKNOWNHARDWAREERROR = 0x8898050e;

enum : int
{
    MILEFFECTSERR_EFFECTNOTPARTOFGROUP  = 0x8898060f,
    MILEFFECTSERR_NOINPUTSOURCEATTACHED = 0x88980610,
}

enum int MILEFFECTSERR_CONNECTORNOTASSOCIATEDWITHEFFECT = 0x88980612;

enum : int
{
    MILEFFECTSERR_CYCLEDETECTED             = 0x88980614,
    MILEFFECTSERR_EFFECTINMORETHANONEGRAPH  = 0x88980615,
    MILEFFECTSERR_EFFECTALREADYINAGRAPH     = 0x88980616,
    MILEFFECTSERR_EFFECTHASNOCHILDREN       = 0x88980617,
    MILEFFECTSERR_ALREADYATTACHEDTOLISTENER = 0x88980618,
}

enum : int
{
    MILEFFECTSERR_EMPTYBOUNDS        = 0x8898061a,
    MILEFFECTSERR_OUTPUTSIZETOOLARGE = 0x8898061b,
}

enum int DWMERR_THEME_FAILED = 0x88980701;

enum : int
{
    DCOMPOSITION_ERROR_WINDOW_ALREADY_COMPOSED    = 0x88980800,
    DCOMPOSITION_ERROR_SURFACE_BEING_RENDERED     = 0x88980801,
    DCOMPOSITION_ERROR_SURFACE_NOT_BEING_RENDERED = 0x88980802,
}

enum int ONL_E_ACCESS_DENIED_BY_TOU = 0x80860002;
enum int ONL_E_PASSWORD_UPDATE_REQUIRED = 0x80860004;
enum int ONL_E_FORCESIGNIN = 0x80860006;
enum int ONL_E_PARENTAL_CONSENT_REQUIRED = 0x80860008;

enum : int
{
    ONL_E_ACCOUNT_SUSPENDED_COMPROIMISE = 0x8086000a,
    ONL_E_ACCOUNT_SUSPENDED_ABUSE       = 0x8086000b,
}

enum int ONL_CONNECTION_COUNT_LIMIT = 0x8086000d;
enum int ONL_E_USER_AUTHENTICATION_REQUIRED = 0x8086000f;
enum int FA_E_MAX_PERSISTED_ITEMS_REACHED = 0x80270220;
enum int E_MONITOR_RESOLUTION_TOO_LOW = 0x80270250;
enum int E_UAC_DISABLED = 0x80270252;
enum int E_APPLICATION_NOT_REGISTERED = 0x80270254;
enum int E_MULTIPLE_PACKAGES_FOR_FAMILY = 0x80270256;
enum int S_STORE_LAUNCHED_FOR_REMEDIATION = 0x00270258;

enum : int
{
    E_APPLICATION_ACTIVATION_TIMED_OUT    = 0x8027025a,
    E_APPLICATION_ACTIVATION_EXEC_FAILURE = 0x8027025b,
}

enum int E_APPLICATION_TRIAL_LICENSE_EXPIRED = 0x8027025d;

enum : int
{
    E_SKYDRIVE_ROOT_TARGET_OVERLAP      = 0x80270261,
    E_SKYDRIVE_ROOT_TARGET_CANNOT_INDEX = 0x80270262,
}

enum int E_SKYDRIVE_UPDATE_AVAILABILITY_FAIL = 0x80270264;

enum : int
{
    E_SYNCENGINE_FILE_SIZE_OVER_LIMIT              = 0x8802b001,
    E_SYNCENGINE_FILE_SIZE_EXCEEDS_REMAINING_QUOTA = 0x8802b002,
}

enum int E_SYNCENGINE_FOLDER_ITEM_COUNT_LIMIT_EXCEEDED = 0x8802b004;
enum int E_SYNCENGINE_SYNC_PAUSED_BY_SERVICE = 0x8802b006;
enum int E_SYNCENGINE_SERVICE_AUTHENTICATION_FAILED = 0x8802c003;
enum int E_SYNCENGINE_SERVICE_RETURNED_UNEXPECTED_SIZE = 0x8802c005;
enum int E_SYNCENGINE_REQUEST_BLOCKED_DUE_TO_CLIENT_ERROR = 0x8802c007;

enum : int
{
    E_SYNCENGINE_UNSUPPORTED_FOLDER_NAME    = 0x8802d002,
    E_SYNCENGINE_UNSUPPORTED_MARKET         = 0x8802d003,
    E_SYNCENGINE_PATH_LENGTH_LIMIT_EXCEEDED = 0x8802d004,
}

enum int E_SYNCENGINE_CLIENT_UPDATE_NEEDED = 0x8802d006;
enum int E_SYNCENGINE_STORAGE_SERVICE_PROVISIONING_FAILED = 0x8802d008;
enum int E_SYNCENGINE_STORAGE_SERVICE_BLOCKED = 0x8802d00a;

enum : int
{
    EAS_E_POLICY_NOT_MANAGED_BY_OS      = 0x80550001,
    EAS_E_POLICY_COMPLIANT_WITH_ACTIONS = 0x80550002,
}

enum int EAS_E_CURRENT_USER_HAS_BLANK_PASSWORD = 0x80550004;
enum int EAS_E_USER_CANNOT_CHANGE_PASSWORD = 0x80550006;
enum int EAS_E_ADMINS_CANNOT_CHANGE_PASSWORD = 0x80550008;
enum int EAS_E_PASSWORD_POLICY_NOT_ENFORCEABLE_FOR_CONNECTED_ADMINS = 0x8055000a;
enum int EAS_E_PASSWORD_POLICY_NOT_ENFORCEABLE_FOR_CURRENT_CONNECTED_USER = 0x8055000c;
enum int WEB_E_UNSUPPORTED_FORMAT = 0x83750001;

enum : int
{
    WEB_E_MISSING_REQUIRED_ELEMENT   = 0x83750003,
    WEB_E_MISSING_REQUIRED_ATTRIBUTE = 0x83750004,
}

enum int WEB_E_RESOURCE_TOO_LARGE = 0x83750006;
enum int WEB_E_INVALID_JSON_NUMBER = 0x83750008;

enum : int
{
    HTTP_E_STATUS_UNEXPECTED              = 0x80190001,
    HTTP_E_STATUS_UNEXPECTED_REDIRECTION  = 0x80190003,
    HTTP_E_STATUS_UNEXPECTED_CLIENT_ERROR = 0x80190004,
    HTTP_E_STATUS_UNEXPECTED_SERVER_ERROR = 0x80190005,
}

enum : int
{
    HTTP_E_STATUS_MOVED                 = 0x8019012d,
    HTTP_E_STATUS_REDIRECT              = 0x8019012e,
    HTTP_E_STATUS_REDIRECT_METHOD       = 0x8019012f,
    HTTP_E_STATUS_NOT_MODIFIED          = 0x80190130,
    HTTP_E_STATUS_USE_PROXY             = 0x80190131,
    HTTP_E_STATUS_REDIRECT_KEEP_VERB    = 0x80190133,
    HTTP_E_STATUS_BAD_REQUEST           = 0x80190190,
    HTTP_E_STATUS_DENIED                = 0x80190191,
    HTTP_E_STATUS_PAYMENT_REQ           = 0x80190192,
    HTTP_E_STATUS_FORBIDDEN             = 0x80190193,
    HTTP_E_STATUS_NOT_FOUND             = 0x80190194,
    HTTP_E_STATUS_BAD_METHOD            = 0x80190195,
    HTTP_E_STATUS_NONE_ACCEPTABLE       = 0x80190196,
    HTTP_E_STATUS_PROXY_AUTH_REQ        = 0x80190197,
    HTTP_E_STATUS_REQUEST_TIMEOUT       = 0x80190198,
    HTTP_E_STATUS_CONFLICT              = 0x80190199,
    HTTP_E_STATUS_GONE                  = 0x8019019a,
    HTTP_E_STATUS_LENGTH_REQUIRED       = 0x8019019b,
    HTTP_E_STATUS_PRECOND_FAILED        = 0x8019019c,
    HTTP_E_STATUS_REQUEST_TOO_LARGE     = 0x8019019d,
    HTTP_E_STATUS_URI_TOO_LONG          = 0x8019019e,
    HTTP_E_STATUS_UNSUPPORTED_MEDIA     = 0x8019019f,
    HTTP_E_STATUS_RANGE_NOT_SATISFIABLE = 0x801901a0,
}

enum : int
{
    HTTP_E_STATUS_SERVER_ERROR    = 0x801901f4,
    HTTP_E_STATUS_NOT_SUPPORTED   = 0x801901f5,
    HTTP_E_STATUS_BAD_GATEWAY     = 0x801901f6,
    HTTP_E_STATUS_SERVICE_UNAVAIL = 0x801901f7,
    HTTP_E_STATUS_GATEWAY_TIMEOUT = 0x801901f8,
    HTTP_E_STATUS_VERSION_NOT_SUP = 0x801901f9,
}

enum int E_INVALID_PROTOCOL_FORMAT = 0x83760002;
enum int E_SUBPROTOCOL_NOT_SUPPORTED = 0x83760004;
enum int INPUT_E_OUT_OF_ORDER = 0x80400000;

enum : int
{
    INPUT_E_MULTIMODAL      = 0x80400002,
    INPUT_E_PACKET          = 0x80400003,
    INPUT_E_FRAME           = 0x80400004,
    INPUT_E_HISTORY         = 0x80400005,
    INPUT_E_DEVICE_INFO     = 0x80400006,
    INPUT_E_TRANSFORM       = 0x80400007,
    INPUT_E_DEVICE_PROPERTY = 0x80400008,
}

enum : int
{
    INET_E_NO_SESSION     = 0x800c0003,
    INET_E_CANNOT_CONNECT = 0x800c0004,
}

enum int INET_E_OBJECT_NOT_FOUND = 0x800c0006;
enum int INET_E_DOWNLOAD_FAILURE = 0x800c0008;
enum int INET_E_NO_VALID_MEDIA = 0x800c000a;
enum int INET_E_INVALID_REQUEST = 0x800c000c;
enum int INET_E_SECURITY_PROBLEM = 0x800c000e;
enum int INET_E_CANNOT_INSTANTIATE_OBJECT = 0x800c0010;

enum : int
{
    INET_E_REDIRECT_FAILED = 0x800c0014,
    INET_E_REDIRECT_TO_DIR = 0x800c0015,
}

enum int ERROR_DBG_ATTACH_PROCESS_FAILURE_LOCKDOWN = 0x80b00002;
enum int ERROR_DBG_START_SERVER_FAILURE_LOCKDOWN = 0x80b00004;
enum int JSCRIPT_E_CANTEXECUTE = 0x89020001;
enum int WEP_E_FIXED_DATA_NOT_SUPPORTED = 0x88010002;
enum int WEP_E_LOCK_NOT_CONFIGURED = 0x88010004;
enum int WEP_E_NO_LICENSE = 0x88010006;
enum int WEP_E_UNEXPECTED_FAIL = 0x88010008;

enum : int
{
    ERROR_SVHDX_ERROR_STORED        = 0xc05c0000,
    ERROR_SVHDX_ERROR_NOT_AVAILABLE = 0xc05cff00,
}

enum : int
{
    ERROR_SVHDX_UNIT_ATTENTION_CAPACITY_DATA_CHANGED        = 0xc05cff02,
    ERROR_SVHDX_UNIT_ATTENTION_RESERVATIONS_PREEMPTED       = 0xc05cff03,
    ERROR_SVHDX_UNIT_ATTENTION_RESERVATIONS_RELEASED        = 0xc05cff04,
    ERROR_SVHDX_UNIT_ATTENTION_REGISTRATIONS_PREEMPTED      = 0xc05cff05,
    ERROR_SVHDX_UNIT_ATTENTION_OPERATING_DEFINITION_CHANGED = 0xc05cff06,
}

enum : int
{
    ERROR_SVHDX_WRONG_FILE_TYPE  = 0xc05cff08,
    ERROR_SVHDX_VERSION_MISMATCH = 0xc05cff09,
}

enum int ERROR_SVHDX_NO_INITIATOR = 0xc05cff0b;
enum int ERROR_SMB_NO_PREAUTH_INTEGRITY_HASH_OVERLAP = 0xc05d0000;

enum : int
{
    WININET_E_OUT_OF_HANDLES      = 0x80072ee1,
    WININET_E_TIMEOUT             = 0x80072ee2,
    WININET_E_EXTENDED_ERROR      = 0x80072ee3,
    WININET_E_INTERNAL_ERROR      = 0x80072ee4,
    WININET_E_INVALID_URL         = 0x80072ee5,
    WININET_E_UNRECOGNIZED_SCHEME = 0x80072ee6,
}

enum int WININET_E_PROTOCOL_NOT_FOUND = 0x80072ee8;
enum int WININET_E_BAD_OPTION_LENGTH = 0x80072eea;

enum : int
{
    WININET_E_SHUTDOWN            = 0x80072eec,
    WININET_E_INCORRECT_USER_NAME = 0x80072eed,
    WININET_E_INCORRECT_PASSWORD  = 0x80072eee,
}

enum int WININET_E_INVALID_OPERATION = 0x80072ef0;

enum : int
{
    WININET_E_INCORRECT_HANDLE_TYPE  = 0x80072ef2,
    WININET_E_INCORRECT_HANDLE_STATE = 0x80072ef3,
}

enum int WININET_E_REGISTRY_VALUE_NOT_FOUND = 0x80072ef5;

enum : int
{
    WININET_E_NO_DIRECT_ACCESS = 0x80072ef7,
    WININET_E_NO_CONTEXT       = 0x80072ef8,
    WININET_E_NO_CALLBACK      = 0x80072ef9,
    WININET_E_REQUEST_PENDING  = 0x80072efa,
}

enum : int
{
    WININET_E_ITEM_NOT_FOUND     = 0x80072efc,
    WININET_E_CANNOT_CONNECT     = 0x80072efd,
    WININET_E_CONNECTION_ABORTED = 0x80072efe,
    WININET_E_CONNECTION_RESET   = 0x80072eff,
}

enum int WININET_E_INVALID_PROXY_REQUEST = 0x80072f01;

enum : int
{
    WININET_E_HANDLE_EXISTS         = 0x80072f04,
    WININET_E_SEC_CERT_DATE_INVALID = 0x80072f05,
    WININET_E_SEC_CERT_CN_INVALID   = 0x80072f06,
}

enum int WININET_E_HTTPS_TO_HTTP_ON_REDIR = 0x80072f08;
enum int WININET_E_CHG_POST_IS_NON_SECURE = 0x80072f0a;
enum int WININET_E_CLIENT_AUTH_CERT_NEEDED = 0x80072f0c;
enum int WININET_E_CLIENT_AUTH_NOT_SETUP = 0x80072f0e;
enum int WININET_E_REDIRECT_SCHEME_CHANGE = 0x80072f10;

enum : int
{
    WININET_E_RETRY_DIALOG      = 0x80072f12,
    WININET_E_NO_NEW_CONTAINERS = 0x80072f13,
}

enum : int
{
    WININET_E_SEC_CERT_ERRORS     = 0x80072f17,
    WININET_E_SEC_CERT_REV_FAILED = 0x80072f19,
}

enum int WININET_E_DOWNLEVEL_SERVER = 0x80072f77;

enum : int
{
    WININET_E_INVALID_HEADER        = 0x80072f79,
    WININET_E_INVALID_QUERY_REQUEST = 0x80072f7a,
}

enum int WININET_E_REDIRECT_FAILED = 0x80072f7c;
enum int WININET_E_UNABLE_TO_CACHE_FILE = 0x80072f7e;

enum : int
{
    WININET_E_DISCONNECTED       = 0x80072f83,
    WININET_E_SERVER_UNREACHABLE = 0x80072f84,
}

enum int WININET_E_BAD_AUTO_PROXY_SCRIPT = 0x80072f86;

enum : int
{
    WININET_E_SEC_INVALID_CERT = 0x80072f89,
    WININET_E_SEC_CERT_REVOKED = 0x80072f8a,
}

enum int WININET_E_NOT_INITIALIZED = 0x80072f8c;
enum int WININET_E_DECODING_FAILED = 0x80072f8f;

enum : int
{
    WININET_E_COOKIE_NEEDS_CONFIRMATION = 0x80072f81,
    WININET_E_COOKIE_DECLINED           = 0x80072f82,
}

enum : int
{
    SQLITE_E_ERROR                   = 0x87af0001,
    SQLITE_E_INTERNAL                = 0x87af0002,
    SQLITE_E_PERM                    = 0x87af0003,
    SQLITE_E_ABORT                   = 0x87af0004,
    SQLITE_E_BUSY                    = 0x87af0005,
    SQLITE_E_LOCKED                  = 0x87af0006,
    SQLITE_E_NOMEM                   = 0x87af0007,
    SQLITE_E_READONLY                = 0x87af0008,
    SQLITE_E_INTERRUPT               = 0x87af0009,
    SQLITE_E_IOERR                   = 0x87af000a,
    SQLITE_E_CORRUPT                 = 0x87af000b,
    SQLITE_E_NOTFOUND                = 0x87af000c,
    SQLITE_E_FULL                    = 0x87af000d,
    SQLITE_E_CANTOPEN                = 0x87af000e,
    SQLITE_E_PROTOCOL                = 0x87af000f,
    SQLITE_E_EMPTY                   = 0x87af0010,
    SQLITE_E_SCHEMA                  = 0x87af0011,
    SQLITE_E_TOOBIG                  = 0x87af0012,
    SQLITE_E_CONSTRAINT              = 0x87af0013,
    SQLITE_E_MISMATCH                = 0x87af0014,
    SQLITE_E_MISUSE                  = 0x87af0015,
    SQLITE_E_NOLFS                   = 0x87af0016,
    SQLITE_E_AUTH                    = 0x87af0017,
    SQLITE_E_FORMAT                  = 0x87af0018,
    SQLITE_E_RANGE                   = 0x87af0019,
    SQLITE_E_NOTADB                  = 0x87af001a,
    SQLITE_E_NOTICE                  = 0x87af001b,
    SQLITE_E_WARNING                 = 0x87af001c,
    SQLITE_E_ROW                     = 0x87af0064,
    SQLITE_E_DONE                    = 0x87af0065,
    SQLITE_E_IOERR_READ              = 0x87af010a,
    SQLITE_E_IOERR_SHORT_READ        = 0x87af020a,
    SQLITE_E_IOERR_WRITE             = 0x87af030a,
    SQLITE_E_IOERR_FSYNC             = 0x87af040a,
    SQLITE_E_IOERR_DIR_FSYNC         = 0x87af050a,
    SQLITE_E_IOERR_TRUNCATE          = 0x87af060a,
    SQLITE_E_IOERR_FSTAT             = 0x87af070a,
    SQLITE_E_IOERR_UNLOCK            = 0x87af080a,
    SQLITE_E_IOERR_RDLOCK            = 0x87af090a,
    SQLITE_E_IOERR_DELETE            = 0x87af0a0a,
    SQLITE_E_IOERR_BLOCKED           = 0x87af0b0a,
    SQLITE_E_IOERR_NOMEM             = 0x87af0c0a,
    SQLITE_E_IOERR_ACCESS            = 0x87af0d0a,
    SQLITE_E_IOERR_CHECKRESERVEDLOCK = 0x87af0e0a,
    SQLITE_E_IOERR_LOCK              = 0x87af0f0a,
    SQLITE_E_IOERR_CLOSE             = 0x87af100a,
    SQLITE_E_IOERR_DIR_CLOSE         = 0x87af110a,
    SQLITE_E_IOERR_SHMOPEN           = 0x87af120a,
    SQLITE_E_IOERR_SHMSIZE           = 0x87af130a,
    SQLITE_E_IOERR_SHMLOCK           = 0x87af140a,
    SQLITE_E_IOERR_SHMMAP            = 0x87af150a,
    SQLITE_E_IOERR_SEEK              = 0x87af160a,
    SQLITE_E_IOERR_DELETE_NOENT      = 0x87af170a,
    SQLITE_E_IOERR_MMAP              = 0x87af180a,
    SQLITE_E_IOERR_GETTEMPPATH       = 0x87af190a,
    SQLITE_E_IOERR_CONVPATH          = 0x87af1a0a,
    SQLITE_E_IOERR_VNODE             = 0x87af1a02,
    SQLITE_E_IOERR_AUTH              = 0x87af1a03,
    SQLITE_E_LOCKED_SHAREDCACHE      = 0x87af0106,
}

enum : int
{
    SQLITE_E_BUSY_SNAPSHOT      = 0x87af0205,
    SQLITE_E_CANTOPEN_NOTEMPDIR = 0x87af010e,
    SQLITE_E_CANTOPEN_ISDIR     = 0x87af020e,
    SQLITE_E_CANTOPEN_FULLPATH  = 0x87af030e,
    SQLITE_E_CANTOPEN_CONVPATH  = 0x87af040e,
}

enum : int
{
    SQLITE_E_READONLY_RECOVERY = 0x87af0108,
    SQLITE_E_READONLY_CANTLOCK = 0x87af0208,
    SQLITE_E_READONLY_ROLLBACK = 0x87af0308,
    SQLITE_E_READONLY_DBMOVED  = 0x87af0408,
}

enum : int
{
    SQLITE_E_CONSTRAINT_CHECK      = 0x87af0113,
    SQLITE_E_CONSTRAINT_COMMITHOOK = 0x87af0213,
    SQLITE_E_CONSTRAINT_FOREIGNKEY = 0x87af0313,
    SQLITE_E_CONSTRAINT_FUNCTION   = 0x87af0413,
    SQLITE_E_CONSTRAINT_NOTNULL    = 0x87af0513,
    SQLITE_E_CONSTRAINT_PRIMARYKEY = 0x87af0613,
    SQLITE_E_CONSTRAINT_TRIGGER    = 0x87af0713,
    SQLITE_E_CONSTRAINT_UNIQUE     = 0x87af0813,
    SQLITE_E_CONSTRAINT_VTAB       = 0x87af0913,
    SQLITE_E_CONSTRAINT_ROWID      = 0x87af0a13,
}

enum int SQLITE_E_NOTICE_RECOVER_ROLLBACK = 0x87af021b;
enum int UTC_E_TOGGLE_TRACE_STARTED = 0x87c51001;
enum int UTC_E_AOT_NOT_RUNNING = 0x87c51003;
enum int UTC_E_SCENARIODEF_NOT_FOUND = 0x87c51005;

enum : int
{
    UTC_E_FORWARDER_ALREADY_ENABLED  = 0x87c51007,
    UTC_E_FORWARDER_ALREADY_DISABLED = 0x87c51008,
}

enum int UTC_E_DIAGRULES_SCHEMAVERSION_MISMATCH = 0x87c5100a;
enum int UTC_E_INVALID_CUSTOM_FILTER = 0x87c5100c;
enum int UTC_E_REESCALATED_TOO_QUICKLY = 0x87c5100e;
enum int UTC_E_PERFTRACK_ALREADY_TRACING = 0x87c51010;
enum int UTC_E_FORWARDER_PRODUCER_MISMATCH = 0x87c51012;
enum int UTC_E_SQM_INIT_FAILED = 0x87c51014;
enum int UTC_E_TRACERS_DONT_EXIST = 0x87c51016;
enum int UTC_E_SCENARIODEF_SCHEMAVERSION_MISMATCH = 0x87c51018;
enum int UTC_E_EXE_TERMINATED = 0x87c5101a;
enum int UTC_E_SETUP_NOT_AUTHORIZED = 0x87c5101c;
enum int UTC_E_COMMAND_LINE_NOT_AUTHORIZED = 0x87c5101e;
enum int UTC_E_ESCALATION_TIMED_OUT = 0x87c51020;

enum : int
{
    UTC_E_TRIGGER_MISMATCH  = 0x87c51022,
    UTC_E_TRIGGER_NOT_FOUND = 0x87c51023,
}

enum int UTC_E_DELAY_TERMINATED = 0x87c51025;
enum int UTC_E_TRACE_BUFFER_LIMIT_EXCEEDED = 0x87c51027;

enum : int
{
    UTC_E_RPC_TIMEOUT     = 0x87c51029,
    UTC_E_RPC_WAIT_FAILED = 0x87c5102a,
}

enum int UTC_E_TRACE_MIN_DURATION_REQUIREMENT_NOT_MET = 0x87c5102c;
enum int UTC_E_GETFILE_FILE_PATH_NOT_APPROVED = 0x87c5102e;

enum : int
{
    UTC_E_TIME_TRIGGER_ON_START_INVALID                = 0x87c51030,
    UTC_E_TIME_TRIGGER_ONLY_VALID_ON_SINGLE_TRANSITION = 0x87c51031,
}

enum int UTC_E_MULTIPLE_TIME_TRIGGER_ON_SINGLE_STATE = 0x87c51033;
enum int UTC_E_FAILED_TO_RESOLVE_CONTAINER_ID = 0x87c51036;
enum int UTC_E_THROTTLED = 0x87c51038;
enum int UTC_E_SCRIPT_MISSING = 0x87c5103a;
enum int UTC_E_API_NOT_SUPPORTED = 0x87c5103c;
enum int UTC_E_TRY_GET_SCENARIO_TIMEOUT_EXCEEDED = 0x87c5103e;
enum int UTC_E_FAILED_TO_START_NDISCAP = 0x87c51040;
enum int UTC_E_MISSING_AGGREGATE_EVENT_TAG = 0x87c51042;
enum int UTC_E_ACTION_NOT_SUPPORTED_IN_DESTINATION = 0x87c51044;

enum : int
{
    UTC_E_FILTER_INVALID_TYPE            = 0x87c51046,
    UTC_E_FILTER_VARIABLE_NOT_FOUND      = 0x87c51047,
    UTC_E_FILTER_FUNCTION_RESTRICTED     = 0x87c51048,
    UTC_E_FILTER_VERSION_MISMATCH        = 0x87c51049,
    UTC_E_FILTER_INVALID_FUNCTION        = 0x87c51050,
    UTC_E_FILTER_INVALID_FUNCTION_PARAMS = 0x87c51051,
    UTC_E_FILTER_INVALID_COMMAND         = 0x87c51052,
    UTC_E_FILTER_ILLEGAL_EVAL            = 0x87c51053,
}

enum int UTC_E_AGENT_DIAGNOSTICS_TOO_LARGE = 0x87c51055;
enum int UTC_E_SCENARIO_HAS_NO_ACTIONS = 0x87c51057;
enum int UTC_E_INSUFFICIENT_SPACE_TO_START_TRACE = 0x87c51059;
enum int UTC_E_GETFILEINFOACTION_FILE_NOT_APPROVED = 0x87c5105b;

enum : int
{
    WINML_ERR_INVALID_DEVICE  = 0x88900001,
    WINML_ERR_INVALID_BINDING = 0x88900002,
}

enum int WINML_ERR_SIZE_MISMATCH = 0x88900004;
enum int ERROR_QUIC_VER_NEG_FAILURE = 0x80410001;

enum : int
{
    DNS_ERROR_RCODE_NO_ERROR = 0x00000000,
    DNS_ERROR_RCODE_LAST     = 0x0000233a,
}

enum : int
{
    DNS_ERROR_NO_MEMORY    = 0x0000000e,
    DNS_ERROR_INVALID_NAME = 0x0000007b,
    DNS_ERROR_INVALID_DATA = 0x0000000d,
}

enum int SEC_E_NOT_SUPPORTED = 0x80090302;

enum : int
{
    PWM_IOCTL_ID_CONTROLLER_GET_INFO           = 0x00000000,
    PWM_IOCTL_ID_CONTROLLER_GET_ACTUAL_PERIOD  = 0x00000001,
    PWM_IOCTL_ID_CONTROLLER_SET_DESIRED_PERIOD = 0x00000002,
}

enum int PWM_IOCTL_ID_PIN_SET_ACTIVE_DUTY_CYCLE_PERCENTAGE = 0x00000065;

enum : int
{
    PWM_IOCTL_ID_PIN_SET_POLARITY = 0x00000067,
    PWM_IOCTL_ID_PIN_START        = 0x00000068,
    PWM_IOCTL_ID_PIN_STOP         = 0x00000069,
    PWM_IOCTL_ID_PIN_IS_STARTED   = 0x0000006a,
}

// Callbacks

alias ENCLAVE_TARGET_FUNCTION = void* function(void* param0);
alias PENCLAVE_TARGET_FUNCTION = void* function();
alias LPENCLAVE_TARGET_FUNCTION = void* function();
alias PIMAGE_TLS_CALLBACK = void function(void* DllHandle, uint Reason, void* Reserved);
alias RTL_UMS_SCHEDULER_ENTRY_POINT = void function(RTL_UMS_SCHEDULER_REASON Reason, size_t ActivationPayload, 
                                                    void* SchedulerParam);
alias PRTL_UMS_SCHEDULER_ENTRY_POINT = void function();
alias PAPCFUNC = void function(size_t Parameter);
alias WAITORTIMERCALLBACKFUNC = void function(void* param0, ubyte param1);
alias WORKERCALLBACKFUNC = void function(void* param0);
alias APC_CALLBACK_FUNCTION = void function(uint param0, void* param1, void* param2);
alias WAITORTIMERCALLBACK = void function();
alias PFLS_CALLBACK_FUNCTION = void function(void* lpFlsData);
alias PSECURE_MEMORY_CACHE_CALLBACK = ubyte function(char* Addr, size_t Range);
alias PTP_SIMPLE_CALLBACK = void function(TP_CALLBACK_INSTANCE* Instance, void* Context);
alias PTP_CLEANUP_GROUP_CANCEL_CALLBACK = void function(void* ObjectContext, void* CleanupContext);
alias PTP_WORK_CALLBACK = void function(TP_CALLBACK_INSTANCE* Instance, void* Context, TP_WORK* Work);
alias PTP_TIMER_CALLBACK = void function(TP_CALLBACK_INSTANCE* Instance, void* Context, TP_TIMER* Timer);
alias PTP_WAIT_CALLBACK = void function(TP_CALLBACK_INSTANCE* Instance, void* Context, TP_WAIT* Wait, 
                                        uint WaitResult);
alias FARPROC = int function();
alias NEARPROC = int function();
alias PROC = int function();
alias PINIT_ONCE_FN = BOOL function(RTL_RUN_ONCE* InitOnce, void* Parameter, void** Context);
alias PTIMERAPCROUTINE = void function(void* lpArgToCompletionRoutine, uint dwTimerLowValue, uint dwTimerHighValue);
alias PTP_WIN32_IO_CALLBACK = void function(TP_CALLBACK_INSTANCE* Instance, void* Context, void* Overlapped, 
                                            uint IoResult, size_t NumberOfBytesTransferred, TP_IO* Io);
alias PTHREAD_START_ROUTINE = uint function(void* lpThreadParameter);
alias LPTHREAD_START_ROUTINE = uint function();
alias PENCLAVE_ROUTINE = void* function(void* lpThreadParameter);
alias LPENCLAVE_ROUTINE = void* function();
alias BAD_MEMORY_CALLBACK_ROUTINE = void function();
alias PBAD_MEMORY_CALLBACK_ROUTINE = void function();
alias ENUMRESLANGPROCA = BOOL function(ptrdiff_t hModule, const(char)* lpType, const(char)* lpName, 
                                       ushort wLanguage, ptrdiff_t lParam);
alias ENUMRESLANGPROCW = BOOL function(ptrdiff_t hModule, const(wchar)* lpType, const(wchar)* lpName, 
                                       ushort wLanguage, ptrdiff_t lParam);
alias PGET_MODULE_HANDLE_EXA = BOOL function(uint dwFlags, const(char)* lpModuleName, ptrdiff_t* phModule);
alias PGET_MODULE_HANDLE_EXW = BOOL function(uint dwFlags, const(wchar)* lpModuleName, ptrdiff_t* phModule);
alias PHANDLER_ROUTINE = BOOL function(uint CtrlType);
alias TIMECALLBACK = void function(uint uTimerID, uint uMsg, size_t dwUser, size_t dw1, size_t dw2);
alias LPTIMECALLBACK = void function();
alias PM_OPEN_PROC = uint function(const(wchar)* param0);
alias PM_QUERY_PROC = uint function(uint* param0, void** param1, uint* param2, uint* param3);
alias PIO_IRP_EXT_PROCESS_TRACKED_OFFSET_CALLBACK = void function(IO_IRP_EXT_TRACK_OFFSET_HEADER* SourceContext, 
                                                                  IO_IRP_EXT_TRACK_OFFSET_HEADER* TargetContext, 
                                                                  long RelativeOffset);
alias LPDDENUMVIDEOCALLBACK = HRESULT function(DDVIDEOPORTCAPS* param0, void* param1);
alias PDD_SETCOLORKEY = uint function(DD_DRVSETCOLORKEYDATA* param0);
alias PDD_DESTROYDRIVER = uint function(_DD_DESTROYDRIVERDATA* param0);
alias PDD_SETMODE = uint function(_DD_SETMODEDATA* param0);
alias PDD_ALPHABLT = uint function(DD_BLTDATA* param0);
alias PDD_SURFCB_SETCLIPLIST = uint function(DD_SETCLIPLISTDATA* param0);
alias PDD_VPORTCB_GETAUTOFLIPSURF = uint function(_DD_GETVPORTAUTOFLIPSURFACEDATA* param0);
alias LPD3DVALIDATECALLBACK = HRESULT function(void* lpUserArg, uint dwOffset);
alias LPD3DENUMTEXTUREFORMATSCALLBACK = HRESULT function(DDSURFACEDESC* lpDdsd, void* lpContext);
alias LPD3DENUMPIXELFORMATSCALLBACK = HRESULT function(DDPIXELFORMAT* lpDDPixFmt, void* lpContext);
alias LPD3DENUMDEVICESCALLBACK = HRESULT function(GUID* lpGuid, const(char)* lpDeviceDescription, 
                                                  const(char)* lpDeviceName, _D3DDeviceDesc* param3, 
                                                  _D3DDeviceDesc* param4, void* param5);
alias LPD3DENUMDEVICESCALLBACK7 = HRESULT function(const(char)* lpDeviceDescription, const(char)* lpDeviceName, 
                                                   _D3DDeviceDesc7* param2, void* param3);
alias LPD3DNTHAL_CONTEXTCREATECB = uint function(D3DNTHAL_CONTEXTCREATEDATA* param0);
alias LPD3DNTHAL_CONTEXTDESTROYCB = uint function(D3DNTHAL_CONTEXTDESTROYDATA* param0);
alias LPD3DNTHAL_CONTEXTDESTROYALLCB = uint function(D3DNTHAL_CONTEXTDESTROYALLDATA* param0);
alias LPD3DNTHAL_SCENECAPTURECB = uint function(D3DNTHAL_SCENECAPTUREDATA* param0);
alias LPD3DNTHAL_TEXTURECREATECB = uint function(D3DNTHAL_TEXTURECREATEDATA* param0);
alias LPD3DNTHAL_TEXTUREDESTROYCB = uint function(D3DNTHAL_TEXTUREDESTROYDATA* param0);
alias LPD3DNTHAL_TEXTURESWAPCB = uint function(D3DNTHAL_TEXTURESWAPDATA* param0);
alias LPD3DNTHAL_TEXTUREGETSURFCB = uint function(D3DNTHAL_TEXTUREGETSURFDATA* param0);
alias LPD3DNTHAL_SETRENDERTARGETCB = uint function(D3DNTHAL_SETRENDERTARGETDATA* param0);
alias LPD3DNTHAL_CLEAR2CB = uint function(D3DNTHAL_CLEAR2DATA* param0);
alias LPD3DNTHAL_VALIDATETEXTURESTAGESTATECB = uint function(D3DNTHAL_VALIDATETEXTURESTAGESTATEDATA* param0);
alias LPD3DNTHAL_DRAWPRIMITIVES2CB = uint function(D3DNTHAL_DRAWPRIMITIVES2DATA* param0);
alias PFND3DNTPARSEUNKNOWNCOMMAND = HRESULT function(void* lpvCommands, void** lplpvReturnedCommand);
alias PFN = ptrdiff_t function();
alias FREEOBJPROC = BOOL function(DRIVEROBJ* pDriverObj);
alias WNDOBJCHANGEPROC = void function(WNDOBJ* pwo, uint fl);
alias SORTCOMP = int function(const(void)* pv1, const(void)* pv2);
alias PFN_DrvEnableDriver = BOOL function(uint param0, uint param1, DRVENABLEDATA* param2);
alias PFN_DrvEnablePDEV = DHPDEV__* function(DEVMODEW* param0, const(wchar)* param1, uint param2, HSURF__** param3, 
                                             uint param4, GDIINFO* param5, uint param6, DEVINFO* param7, 
                                             HDEV__* param8, const(wchar)* param9, HANDLE param10);
alias PFN_DrvCompletePDEV = void function(DHPDEV__* param0, HDEV__* param1);
alias PFN_DrvResetDevice = uint function(DHPDEV__* param0, void* param1);
alias PFN_DrvDisablePDEV = void function(DHPDEV__* param0);
alias PFN_DrvSynchronize = void function(DHPDEV__* param0, RECTL* param1);
alias PFN_DrvEnableSurface = HSURF__* function(DHPDEV__* param0);
alias PFN_DrvDisableDriver = void function();
alias PFN_DrvDisableSurface = void function(DHPDEV__* param0);
alias PFN_DrvAssertMode = BOOL function(DHPDEV__* param0, BOOL param1);
alias PFN_DrvTextOut = BOOL function(SURFOBJ* param0, STROBJ* param1, FONTOBJ* param2, CLIPOBJ* param3, 
                                     RECTL* param4, RECTL* param5, BRUSHOBJ* param6, BRUSHOBJ* param7, 
                                     POINTL* param8, uint param9);
alias PFN_DrvStretchBlt = BOOL function(SURFOBJ* param0, SURFOBJ* param1, SURFOBJ* param2, CLIPOBJ* param3, 
                                        XLATEOBJ* param4, COLORADJUSTMENT* param5, POINTL* param6, RECTL* param7, 
                                        RECTL* param8, POINTL* param9, uint param10);
alias PFN_DrvStretchBltROP = BOOL function(SURFOBJ* param0, SURFOBJ* param1, SURFOBJ* param2, CLIPOBJ* param3, 
                                           XLATEOBJ* param4, COLORADJUSTMENT* param5, POINTL* param6, RECTL* param7, 
                                           RECTL* param8, POINTL* param9, uint param10, BRUSHOBJ* param11, 
                                           uint param12);
alias PFN_DrvTransparentBlt = BOOL function(SURFOBJ* param0, SURFOBJ* param1, CLIPOBJ* param2, XLATEOBJ* param3, 
                                            RECTL* param4, RECTL* param5, uint param6, uint param7);
alias PFN_DrvPlgBlt = BOOL function(SURFOBJ* param0, SURFOBJ* param1, SURFOBJ* param2, CLIPOBJ* param3, 
                                    XLATEOBJ* param4, COLORADJUSTMENT* param5, POINTL* param6, POINTFIX* param7, 
                                    RECTL* param8, POINTL* param9, uint param10);
alias PFN_DrvBitBlt = BOOL function(SURFOBJ* param0, SURFOBJ* param1, SURFOBJ* param2, CLIPOBJ* param3, 
                                    XLATEOBJ* param4, RECTL* param5, POINTL* param6, POINTL* param7, 
                                    BRUSHOBJ* param8, POINTL* param9, uint param10);
alias PFN_DrvRealizeBrush = BOOL function(BRUSHOBJ* param0, SURFOBJ* param1, SURFOBJ* param2, SURFOBJ* param3, 
                                          XLATEOBJ* param4, uint param5);
alias PFN_DrvCopyBits = BOOL function(SURFOBJ* param0, SURFOBJ* param1, CLIPOBJ* param2, XLATEOBJ* param3, 
                                      RECTL* param4, POINTL* param5);
alias PFN_DrvDitherColor = uint function(DHPDEV__* param0, uint param1, uint param2, uint* param3);
alias PFN_DrvCreateDeviceBitmap = HBITMAP function(DHPDEV__* param0, SIZE param1, uint param2);
alias PFN_DrvDeleteDeviceBitmap = void function(DHSURF__* param0);
alias PFN_DrvSetPalette = BOOL function(DHPDEV__* param0, PALOBJ* param1, uint param2, uint param3, uint param4);
alias PFN_DrvEscape = uint function(SURFOBJ* param0, uint param1, uint param2, void* param3, uint param4, 
                                    void* param5);
alias PFN_DrvDrawEscape = uint function(SURFOBJ* param0, uint param1, CLIPOBJ* param2, RECTL* param3, uint param4, 
                                        void* param5);
alias PFN_DrvQueryFont = IFIMETRICS* function(DHPDEV__* param0, size_t param1, uint param2, size_t* param3);
alias PFN_DrvQueryFontTree = void* function(DHPDEV__* param0, size_t param1, uint param2, uint param3, 
                                            size_t* param4);
alias PFN_DrvQueryFontData = int function(DHPDEV__* param0, FONTOBJ* param1, uint param2, uint param3, 
                                          GLYPHDATA* param4, void* param5, uint param6);
alias PFN_DrvFree = void function(void* param0, size_t param1);
alias PFN_DrvDestroyFont = void function(FONTOBJ* param0);
alias PFN_DrvQueryFontCaps = int function(uint param0, uint* param1);
alias PFN_DrvLoadFontFile = size_t function(uint param0, size_t* param1, void** param2, uint* param3, 
                                            DESIGNVECTOR* param4, uint param5, uint param6);
alias PFN_DrvUnloadFontFile = BOOL function(size_t param0);
alias PFN_DrvSetPointerShape = uint function(SURFOBJ* param0, SURFOBJ* param1, SURFOBJ* param2, XLATEOBJ* param3, 
                                             int param4, int param5, int param6, int param7, RECTL* param8, 
                                             uint param9);
alias PFN_DrvMovePointer = void function(SURFOBJ* pso, int x, int y, RECTL* prcl);
alias PFN_DrvSendPage = BOOL function(SURFOBJ* param0);
alias PFN_DrvStartPage = BOOL function(SURFOBJ* pso);
alias PFN_DrvStartDoc = BOOL function(SURFOBJ* pso, const(wchar)* pwszDocName, uint dwJobId);
alias PFN_DrvEndDoc = BOOL function(SURFOBJ* pso, uint fl);
alias PFN_DrvQuerySpoolType = BOOL function(DHPDEV__* dhpdev, const(wchar)* pwchType);
alias PFN_DrvLineTo = BOOL function(SURFOBJ* param0, CLIPOBJ* param1, BRUSHOBJ* param2, int param3, int param4, 
                                    int param5, int param6, RECTL* param7, uint param8);
alias PFN_DrvStrokePath = BOOL function(SURFOBJ* param0, PATHOBJ* param1, CLIPOBJ* param2, XFORMOBJ* param3, 
                                        BRUSHOBJ* param4, POINTL* param5, LINEATTRS* param6, uint param7);
alias PFN_DrvFillPath = BOOL function(SURFOBJ* param0, PATHOBJ* param1, CLIPOBJ* param2, BRUSHOBJ* param3, 
                                      POINTL* param4, uint param5, uint param6);
alias PFN_DrvStrokeAndFillPath = BOOL function(SURFOBJ* param0, PATHOBJ* param1, CLIPOBJ* param2, XFORMOBJ* param3, 
                                               BRUSHOBJ* param4, LINEATTRS* param5, BRUSHOBJ* param6, POINTL* param7, 
                                               uint param8, uint param9);
alias PFN_DrvPaint = BOOL function(SURFOBJ* param0, CLIPOBJ* param1, BRUSHOBJ* param2, POINTL* param3, uint param4);
alias PFN_DrvGetGlyphMode = uint function(DHPDEV__* dhpdev, FONTOBJ* pfo);
alias PFN_DrvResetPDEV = BOOL function(DHPDEV__* dhpdevOld, DHPDEV__* dhpdevNew);
alias PFN_DrvSaveScreenBits = size_t function(SURFOBJ* param0, uint param1, size_t param2, RECTL* param3);
alias PFN_DrvGetModes = uint function(HANDLE param0, uint param1, DEVMODEW* param2);
alias PFN_DrvQueryTrueTypeTable = int function(size_t param0, uint param1, uint param2, int param3, uint param4, 
                                               ubyte* param5, ubyte** param6, uint* param7);
alias PFN_DrvQueryTrueTypeSection = int function(uint param0, uint param1, uint param2, HANDLE* param3, 
                                                 int* param4);
alias PFN_DrvQueryTrueTypeOutline = int function(DHPDEV__* param0, FONTOBJ* param1, uint param2, BOOL param3, 
                                                 GLYPHDATA* param4, uint param5, TTPOLYGONHEADER* param6);
alias PFN_DrvGetTrueTypeFile = void* function(size_t param0, uint* param1);
alias PFN_DrvQueryFontFile = int function(size_t param0, uint param1, uint param2, uint* param3);
alias PFN_DrvQueryAdvanceWidths = BOOL function(DHPDEV__* param0, FONTOBJ* param1, uint param2, uint* param3, 
                                                void* param4, uint param5);
alias PFN_DrvFontManagement = uint function(SURFOBJ* param0, FONTOBJ* param1, uint param2, uint param3, 
                                            void* param4, uint param5, void* param6);
alias PFN_DrvSetPixelFormat = BOOL function(SURFOBJ* param0, int param1, HWND param2);
alias PFN_DrvDescribePixelFormat = int function(DHPDEV__* param0, int param1, uint param2, 
                                                PIXELFORMATDESCRIPTOR* param3);
alias PFN_DrvSwapBuffers = BOOL function(SURFOBJ* param0, WNDOBJ* param1);
alias PFN_DrvStartBanding = BOOL function(SURFOBJ* param0, POINTL* ppointl);
alias PFN_DrvNextBand = BOOL function(SURFOBJ* param0, POINTL* ppointl);
alias PFN_DrvQueryPerBandInfo = BOOL function(SURFOBJ* param0, PERBANDINFO* param1);
alias PFN_DrvEnableDirectDraw = BOOL function(DHPDEV__* param0, DD_CALLBACKS* param1, DD_SURFACECALLBACKS* param2, 
                                              DD_PALETTECALLBACKS* param3);
alias PFN_DrvDisableDirectDraw = void function(DHPDEV__* param0);
alias PFN_DrvGetDirectDrawInfo = BOOL function(DHPDEV__* param0, DD_HALINFO* param1, uint* param2, 
                                               VIDEOMEMORY* param3, uint* param4, uint* param5);
alias PFN_DrvIcmCreateColorTransform = HANDLE function(DHPDEV__* param0, LOGCOLORSPACEW* param1, void* param2, 
                                                       uint param3, void* param4, uint param5, void* param6, 
                                                       uint param7, uint param8);
alias PFN_DrvIcmDeleteColorTransform = BOOL function(DHPDEV__* param0, HANDLE param1);
alias PFN_DrvIcmCheckBitmapBits = BOOL function(DHPDEV__* param0, HANDLE param1, SURFOBJ* param2, ubyte* param3);
alias PFN_DrvIcmSetDeviceGammaRamp = BOOL function(DHPDEV__* param0, uint param1, void* param2);
alias PFN_DrvAlphaBlend = BOOL function(SURFOBJ* param0, SURFOBJ* param1, CLIPOBJ* param2, XLATEOBJ* param3, 
                                        RECTL* param4, RECTL* param5, BLENDOBJ* param6);
alias PFN_DrvGradientFill = BOOL function(SURFOBJ* param0, CLIPOBJ* param1, XLATEOBJ* param2, TRIVERTEX* param3, 
                                          uint param4, void* param5, uint param6, RECTL* param7, POINTL* param8, 
                                          uint param9);
alias PFN_DrvQueryDeviceSupport = BOOL function(SURFOBJ* param0, XLATEOBJ* param1, XFORMOBJ* param2, uint param3, 
                                                uint param4, void* param5, uint param6, void* param7);
alias PFN_DrvDeriveSurface = HBITMAP function(DD_DIRECTDRAW_GLOBAL* param0, DD_SURFACE_LOCAL* param1);
alias PFN_DrvSynchronizeSurface = void function(SURFOBJ* param0, RECTL* param1, uint param2);
alias PFN_DrvNotify = void function(SURFOBJ* param0, uint param1, void* param2);
alias PFN_DrvRenderHint = int function(DHPDEV__* dhpdev, uint NotifyCode, size_t Length, char* Data);
alias PFN_EngCreateRectRgn = HANDLE function(int left, int top, int right, int bottom);
alias PFN_EngDeleteRgn = void function(HANDLE hrgn);
alias PFN_EngCombineRgn = int function(HANDLE hrgnTrg, HANDLE hrgnSrc1, HANDLE hrgnSrc2, int imode);
alias PFN_EngCopyRgn = int function(HANDLE hrgnDst, HANDLE hrgnSrc);
alias PFN_EngIntersectRgn = int function(HANDLE hrgnResult, HANDLE hRgnA, HANDLE hRgnB);
alias PFN_EngSubtractRgn = int function(HANDLE hrgnResult, HANDLE hRgnA, HANDLE hRgnB);
alias PFN_EngUnionRgn = int function(HANDLE hrgnResult, HANDLE hRgnA, HANDLE hRgnB);
alias PFN_EngXorRgn = int function(HANDLE hrgnResult, HANDLE hRgnA, HANDLE hRgnB);
alias PFN_DrvCreateDeviceBitmapEx = HBITMAP function(DHPDEV__* param0, SIZE param1, uint param2, uint param3, 
                                                     DHSURF__* param4, uint param5, uint param6, HANDLE* param7);
alias PFN_DrvDeleteDeviceBitmapEx = void function(DHSURF__* param0);
alias PFN_DrvAssociateSharedSurface = BOOL function(SURFOBJ* param0, HANDLE param1, HANDLE param2, SIZE param3);
alias PFN_DrvSynchronizeRedirectionBitmaps = NTSTATUS function(DHPDEV__* param0, ulong* param1);
alias PFN_DrvAccumulateD3DDirtyRect = BOOL function(SURFOBJ* param0, CDDDXGK_REDIRBITMAPPRESENTINFO* param1);
alias PFN_DrvStartDxInterop = BOOL function(SURFOBJ* param0, BOOL param1, void* KernelModeDeviceHandle);
alias PFN_DrvEndDxInterop = BOOL function(SURFOBJ* param0, BOOL param1, int* param2, void* KernelModeDeviceHandle);
alias PFN_DrvLockDisplayArea = void function(DHPDEV__* param0, RECTL* param1);
alias PFN_DrvUnlockDisplayArea = void function(DHPDEV__* param0, RECTL* param1);
alias PFN_DrvSurfaceComplete = BOOL function(DHPDEV__* param0, HANDLE param1);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_RETURN_FROM_ENCLAVE = void function(size_t ReturnValue);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_RETURN_FROM_EXCEPTION = int function(void* ExceptionRecord);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_TERMINATE_THREAD = int function(VBS_BASIC_ENCLAVE_THREAD_DESCRIPTOR32* ThreadDescriptor);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_INTERRUPT_THREAD = int function(VBS_BASIC_ENCLAVE_THREAD_DESCRIPTOR32* ThreadDescriptor);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_COMMIT_PAGES = int function(void* EnclaveAddress, size_t NumberOfBytes, 
                                                               void* SourceAddress, uint PageProtection);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_DECOMMIT_PAGES = int function(void* EnclaveAddress, size_t NumberOfBytes);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_PROTECT_PAGES = int function(void* EnclaveAddress, size_t NumberOfytes, 
                                                                uint PageProtection);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_CREATE_THREAD = int function(VBS_BASIC_ENCLAVE_THREAD_DESCRIPTOR32* ThreadDescriptor);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_GET_ENCLAVE_INFORMATION = int function(ENCLAVE_INFORMATION* EnclaveInfo);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_GENERATE_KEY = int function(ENCLAVE_VBS_BASIC_KEY_REQUEST* KeyRequest, 
                                                               uint RequestedKeySize, char* ReturnedKey);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_GENERATE_REPORT = int function(const(ubyte)* EnclaveData, char* Report, 
                                                                  uint BufferSize, uint* OutputSize);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_VERIFY_REPORT = int function(char* Report, uint ReportSize);
alias VBS_BASIC_ENCLAVE_BASIC_CALL_GENERATE_RANDOM_DATA = int function(char* Buffer, uint NumberOfBytes, 
                                                                       ulong* Generation);
alias EFFECTIVE_POWER_MODE_CALLBACK = void function(EFFECTIVE_POWER_MODE Mode, void* Context);
alias PWRSCHEMESENUMPROC_V1 = ubyte function(uint Index, uint NameSize, char* Name, uint DescriptionSize, 
                                             char* Description, POWER_POLICY* Policy, LPARAM Context);
alias PWRSCHEMESENUMPROC_V2 = ubyte function(uint Index, uint NameSize, const(wchar)* Name, uint DescriptionSize, 
                                             const(wchar)* Description, POWER_POLICY* Policy, LPARAM Context);
alias PWRSCHEMESENUMPROC = ubyte function();
alias DEVICE_NOTIFY_CALLBACK_ROUTINE = uint function(void* Context, uint Type, void* Setting);
alias PDEVICE_NOTIFY_CALLBACK_ROUTINE = uint function();
alias PVIDEO_WIN32K_CALLOUT = void function(void* Params);
alias PFIBER_START_ROUTINE = void function(void* lpFiberParameter);

// Structs


alias BOOL = int;

alias BoundaryDescriptorHandle = ptrdiff_t;

alias HANDLE = ptrdiff_t;

alias HINSTANCE = ptrdiff_t;

alias LRESULT = int;

alias LSTATUS = int;

alias NamespaceHandle = ptrdiff_t;

alias NTSTATUS = int;

alias PTP_POOL = ptrdiff_t;

alias TimerQueueHandle = ptrdiff_t;

struct FLOAT128
{
    long LowPart;
    long HighPart;
}

union LARGE_INTEGER
{
    struct
    {
        uint LowPart;
        int  HighPart;
    }
    struct u
    {
        uint LowPart;
        int  HighPart;
    }
    long QuadPart;
}

union ULARGE_INTEGER
{
    struct
    {
        uint LowPart;
        uint HighPart;
    }
    struct u
    {
        uint LowPart;
        uint HighPart;
    }
    ulong QuadPart;
}

struct M128A
{
    ulong Low;
    long  High;
}

struct XSAVE_FORMAT
{
    ushort     ControlWord;
    ushort     StatusWord;
    ubyte      TagWord;
    ubyte      Reserved1;
    ushort     ErrorOpcode;
    uint       ErrorOffset;
    ushort     ErrorSelector;
    ushort     Reserved2;
    uint       DataOffset;
    ushort     DataSelector;
    ushort     Reserved3;
    uint       MxCsr;
    uint       MxCsr_Mask;
    M128A[8]   FloatRegisters;
    M128A[8]   XmmRegisters;
    ubyte[224] Reserved4;
}

struct XSAVE_CET_U_FORMAT
{
    ulong Ia32CetUMsr;
    ulong Ia32Pl3SspMsr;
}

struct XSAVE_AREA_HEADER
{
    ulong    Mask;
    ulong    CompactionMask;
    ulong[6] Reserved2;
}

struct XSAVE_AREA
{
    XSAVE_FORMAT      LegacyState;
    XSAVE_AREA_HEADER Header;
}

struct XSTATE_CONTEXT
{
    ulong       Mask;
    uint        Length;
    uint        Reserved1;
    XSAVE_AREA* Area;
    uint        Reserved2;
    void*       Buffer;
    uint        Reserved3;
}

struct SCOPE_TABLE_AMD64
{
    uint Count;
    struct
    {
        uint BeginAddress;
        uint EndAddress;
        uint HandlerAddress;
        uint JumpTarget;
    }
}

struct SCOPE_TABLE_ARM
{
    uint Count;
    struct
    {
        uint BeginAddress;
        uint EndAddress;
        uint HandlerAddress;
        uint JumpTarget;
    }
}

struct SCOPE_TABLE_ARM64
{
    uint Count;
    struct
    {
        uint BeginAddress;
        uint EndAddress;
        uint HandlerAddress;
        uint JumpTarget;
    }
}

struct KNONVOLATILE_CONTEXT_POINTERS_ARM64
{
    ulong* X19;
    ulong* X20;
    ulong* X21;
    ulong* X22;
    ulong* X23;
    ulong* X24;
    ulong* X25;
    ulong* X26;
    ulong* X27;
    ulong* X28;
    ulong* Fp;
    ulong* Lr;
    ulong* D8;
    ulong* D9;
    ulong* D10;
    ulong* D11;
    ulong* D12;
    ulong* D13;
    ulong* D14;
    ulong* D15;
}

struct FLOATING_SAVE_AREA
{
    uint      ControlWord;
    uint      StatusWord;
    uint      TagWord;
    uint      ErrorOffset;
    uint      ErrorSelector;
    uint      DataOffset;
    uint      DataSelector;
    ubyte[80] RegisterArea;
    uint      Spare0;
}

struct KNONVOLATILE_CONTEXT_POINTERS
{
    uint Dummy;
}

struct WOW64_DESCRIPTOR_TABLE_ENTRY
{
    uint            Selector;
    WOW64_LDT_ENTRY Descriptor;
}

struct EXCEPTION_RECORD32
{
    uint     ExceptionCode;
    uint     ExceptionFlags;
    uint     ExceptionRecord;
    uint     ExceptionAddress;
    uint     NumberParameters;
    uint[15] ExceptionInformation;
}

union SE_SID
{
    SID       Sid;
    ubyte[68] Buffer;
}

struct SYSTEM_PROCESS_TRUST_LABEL_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       SidStart;
}

struct SYSTEM_ACCESS_FILTER_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       SidStart;
}

struct SECURITY_DESCRIPTOR_RELATIVE
{
    ubyte  Revision;
    ubyte  Sbz1;
    ushort Control;
    uint   Owner;
    uint   Group;
    uint   Sacl;
    uint   Dacl;
}

struct SECURITY_OBJECT_AI_PARAMS
{
    uint Size;
    uint ConstraintMask;
}

struct ACCESS_REASONS
{
    uint[32] Data;
}

struct SE_SECURITY_DESCRIPTOR
{
    uint  Size;
    uint  Flags;
    void* SecurityDescriptor;
}

struct SE_ACCESS_REQUEST
{
    uint              Size;
    SE_SECURITY_DESCRIPTOR* SeSecurityDescriptor;
    uint              DesiredAccess;
    uint              PreviouslyGrantedAccess;
    void*             PrincipalSelfSid;
    GENERIC_MAPPING*  GenericMapping;
    uint              ObjectTypeListCount;
    OBJECT_TYPE_LIST* ObjectTypeList;
}

struct SE_ACCESS_REPLY
{
    uint            Size;
    uint            ResultListCount;
    uint*           GrantedAccess;
    uint*           AccessStatus;
    ACCESS_REASONS* AccessReason;
    PRIVILEGE_SET** Privileges;
}

struct SE_TOKEN_USER
{
    union
    {
        TOKEN_USER         TokenUser;
        SID_AND_ATTRIBUTES User;
    }
    union
    {
        SID       Sid;
        ubyte[68] Buffer;
    }
}

struct TOKEN_SID_INFORMATION
{
    void* Sid;
}

struct TOKEN_BNO_ISOLATION_INFORMATION
{
    const(wchar)* IsolationPrefix;
    ubyte         IsolationEnabled;
}

struct SE_IMPERSONATION_STATE
{
    void* Token;
    ubyte CopyOnOpen;
    ubyte EffectiveOnly;
    SECURITY_IMPERSONATION_LEVEL Level;
}

struct JOB_SET_ARRAY
{
    HANDLE JobHandle;
    uint   MemberLevel;
    uint   Flags;
}

struct EXCEPTION_REGISTRATION_RECORD
{
    EXCEPTION_REGISTRATION_RECORD* Next;
    EXCEPTION_ROUTINE Handler;
}

struct NT_TIB
{
    EXCEPTION_REGISTRATION_RECORD* ExceptionList;
    void*   StackBase;
    void*   StackLimit;
    void*   SubSystemTib;
    union
    {
        void* FiberData;
        uint  Version;
    }
    void*   ArbitraryUserPointer;
    NT_TIB* Self;
}

struct NT_TIB32
{
    uint ExceptionList;
    uint StackBase;
    uint StackLimit;
    uint SubSystemTib;
    union
    {
        uint FiberData;
        uint Version;
    }
    uint ArbitraryUserPointer;
    uint Self;
}

struct NT_TIB64
{
    ulong ExceptionList;
    ulong StackBase;
    ulong StackLimit;
    ulong SubSystemTib;
    union
    {
        ulong FiberData;
        uint  Version;
    }
    ulong ArbitraryUserPointer;
    ulong Self;
}

struct UMS_CREATE_THREAD_ATTRIBUTES
{
    uint  UmsVersion;
    void* UmsContext;
    void* UmsCompletionList;
}

struct WOW64_ARCHITECTURE_INFORMATION
{
    uint _bitfield112;
}

struct PROCESS_DYNAMIC_EH_CONTINUATION_TARGET
{
    size_t TargetAddress;
    size_t Flags;
}

struct PROCESS_DYNAMIC_EH_CONTINUATION_TARGETS_INFORMATION
{
    ushort NumberOfTargets;
    ushort Reserved;
    uint   Reserved2;
    PROCESS_DYNAMIC_EH_CONTINUATION_TARGET* Targets;
}

union RATE_QUOTA_LIMIT
{
    uint RateData;
    struct
    {
        uint _bitfield113;
    }
}

struct QUOTA_LIMITS_EX
{
    size_t           PagedPoolLimit;
    size_t           NonPagedPoolLimit;
    size_t           MinimumWorkingSetSize;
    size_t           MaximumWorkingSetSize;
    size_t           PagefileLimit;
    LARGE_INTEGER    TimeLimit;
    size_t           WorkingSetLimit;
    size_t           Reserved2;
    size_t           Reserved3;
    size_t           Reserved4;
    uint             Flags;
    RATE_QUOTA_LIMIT CpuRateLimit;
}

struct IO_COUNTERS
{
    ulong ReadOperationCount;
    ulong WriteOperationCount;
    ulong OtherOperationCount;
    ulong ReadTransferCount;
    ulong WriteTransferCount;
    ulong OtherTransferCount;
}

struct PROCESS_MITIGATION_ASLR_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            uint _bitfield114;
        }
    }
}

struct PROCESS_MITIGATION_DEP_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            uint _bitfield115;
        }
    }
    ubyte Permanent;
}

struct PROCESS_MITIGATION_STRICT_HANDLE_CHECK_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            uint _bitfield116;
        }
    }
}

struct PROCESS_MITIGATION_SYSTEM_CALL_DISABLE_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            uint _bitfield117;
        }
    }
}

struct PROCESS_MITIGATION_EXTENSION_POINT_DISABLE_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            uint _bitfield118;
        }
    }
}

struct PROCESS_MITIGATION_DYNAMIC_CODE_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            uint _bitfield119;
        }
    }
}

struct PROCESS_MITIGATION_CONTROL_FLOW_GUARD_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            uint _bitfield120;
        }
    }
}

struct PROCESS_MITIGATION_BINARY_SIGNATURE_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            uint _bitfield121;
        }
    }
}

struct PROCESS_MITIGATION_FONT_DISABLE_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            uint _bitfield122;
        }
    }
}

struct PROCESS_MITIGATION_IMAGE_LOAD_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            uint _bitfield123;
        }
    }
}

struct PROCESS_MITIGATION_SYSTEM_CALL_FILTER_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            uint _bitfield124;
        }
    }
}

struct PROCESS_MITIGATION_PAYLOAD_RESTRICTION_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            uint _bitfield125;
        }
    }
}

struct PROCESS_MITIGATION_CHILD_PROCESS_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            uint _bitfield126;
        }
    }
}

struct PROCESS_MITIGATION_SIDE_CHANNEL_ISOLATION_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            uint _bitfield127;
        }
    }
}

struct PROCESS_MITIGATION_USER_SHADOW_STACK_POLICY
{
    union
    {
        uint Flags;
        struct
        {
            uint _bitfield128;
        }
    }
}

struct JOBOBJECT_BASIC_ACCOUNTING_INFORMATION
{
    LARGE_INTEGER TotalUserTime;
    LARGE_INTEGER TotalKernelTime;
    LARGE_INTEGER ThisPeriodTotalUserTime;
    LARGE_INTEGER ThisPeriodTotalKernelTime;
    uint          TotalPageFaultCount;
    uint          TotalProcesses;
    uint          ActiveProcesses;
    uint          TotalTerminatedProcesses;
}

struct JOBOBJECT_BASIC_LIMIT_INFORMATION
{
    LARGE_INTEGER PerProcessUserTimeLimit;
    LARGE_INTEGER PerJobUserTimeLimit;
    uint          LimitFlags;
    size_t        MinimumWorkingSetSize;
    size_t        MaximumWorkingSetSize;
    uint          ActiveProcessLimit;
    size_t        Affinity;
    uint          PriorityClass;
    uint          SchedulingClass;
}

struct JOBOBJECT_EXTENDED_LIMIT_INFORMATION
{
    JOBOBJECT_BASIC_LIMIT_INFORMATION BasicLimitInformation;
    IO_COUNTERS IoInfo;
    size_t      ProcessMemoryLimit;
    size_t      JobMemoryLimit;
    size_t      PeakProcessMemoryUsed;
    size_t      PeakJobMemoryUsed;
}

struct JOBOBJECT_BASIC_PROCESS_ID_LIST
{
    uint      NumberOfAssignedProcesses;
    uint      NumberOfProcessIdsInList;
    size_t[1] ProcessIdList;
}

struct JOBOBJECT_BASIC_UI_RESTRICTIONS
{
    uint UIRestrictionsClass;
}

struct JOBOBJECT_SECURITY_LIMIT_INFORMATION
{
    uint              SecurityLimitFlags;
    HANDLE            JobToken;
    TOKEN_GROUPS*     SidsToDisable;
    TOKEN_PRIVILEGES* PrivilegesToDelete;
    TOKEN_GROUPS*     RestrictedSids;
}

struct JOBOBJECT_END_OF_JOB_TIME_INFORMATION
{
    uint EndOfJobTimeAction;
}

struct JOBOBJECT_ASSOCIATE_COMPLETION_PORT
{
    void*  CompletionKey;
    HANDLE CompletionPort;
}

struct JOBOBJECT_BASIC_AND_IO_ACCOUNTING_INFORMATION
{
    JOBOBJECT_BASIC_ACCOUNTING_INFORMATION BasicInfo;
    IO_COUNTERS IoInfo;
}

struct JOBOBJECT_JOBSET_INFORMATION
{
    uint MemberLevel;
}

struct JOBOBJECT_NOTIFICATION_LIMIT_INFORMATION
{
    ulong         IoReadBytesLimit;
    ulong         IoWriteBytesLimit;
    LARGE_INTEGER PerJobUserTimeLimit;
    ulong         JobMemoryLimit;
    JOBOBJECT_RATE_CONTROL_TOLERANCE RateControlTolerance;
    JOBOBJECT_RATE_CONTROL_TOLERANCE_INTERVAL RateControlToleranceInterval;
    uint          LimitFlags;
}

struct JOBOBJECT_NOTIFICATION_LIMIT_INFORMATION_2
{
    ulong         IoReadBytesLimit;
    ulong         IoWriteBytesLimit;
    LARGE_INTEGER PerJobUserTimeLimit;
    union
    {
        ulong JobHighMemoryLimit;
        ulong JobMemoryLimit;
    }
    union
    {
        JOBOBJECT_RATE_CONTROL_TOLERANCE RateControlTolerance;
        JOBOBJECT_RATE_CONTROL_TOLERANCE CpuRateControlTolerance;
    }
    union
    {
        JOBOBJECT_RATE_CONTROL_TOLERANCE_INTERVAL RateControlToleranceInterval;
        JOBOBJECT_RATE_CONTROL_TOLERANCE_INTERVAL CpuRateControlToleranceInterval;
    }
    uint          LimitFlags;
    JOBOBJECT_RATE_CONTROL_TOLERANCE IoRateControlTolerance;
    ulong         JobLowMemoryLimit;
    JOBOBJECT_RATE_CONTROL_TOLERANCE_INTERVAL IoRateControlToleranceInterval;
    JOBOBJECT_RATE_CONTROL_TOLERANCE NetRateControlTolerance;
    JOBOBJECT_RATE_CONTROL_TOLERANCE_INTERVAL NetRateControlToleranceInterval;
}

struct JOBOBJECT_LIMIT_VIOLATION_INFORMATION
{
    uint          LimitFlags;
    uint          ViolationLimitFlags;
    ulong         IoReadBytes;
    ulong         IoReadBytesLimit;
    ulong         IoWriteBytes;
    ulong         IoWriteBytesLimit;
    LARGE_INTEGER PerJobUserTime;
    LARGE_INTEGER PerJobUserTimeLimit;
    ulong         JobMemory;
    ulong         JobMemoryLimit;
    JOBOBJECT_RATE_CONTROL_TOLERANCE RateControlTolerance;
    JOBOBJECT_RATE_CONTROL_TOLERANCE RateControlToleranceLimit;
}

struct JOBOBJECT_LIMIT_VIOLATION_INFORMATION_2
{
    uint          LimitFlags;
    uint          ViolationLimitFlags;
    ulong         IoReadBytes;
    ulong         IoReadBytesLimit;
    ulong         IoWriteBytes;
    ulong         IoWriteBytesLimit;
    LARGE_INTEGER PerJobUserTime;
    LARGE_INTEGER PerJobUserTimeLimit;
    ulong         JobMemory;
    union
    {
        ulong JobHighMemoryLimit;
        ulong JobMemoryLimit;
    }
    union
    {
        JOBOBJECT_RATE_CONTROL_TOLERANCE RateControlTolerance;
        JOBOBJECT_RATE_CONTROL_TOLERANCE CpuRateControlTolerance;
    }
    union
    {
        JOBOBJECT_RATE_CONTROL_TOLERANCE RateControlToleranceLimit;
        JOBOBJECT_RATE_CONTROL_TOLERANCE CpuRateControlToleranceLimit;
    }
    ulong         JobLowMemoryLimit;
    JOBOBJECT_RATE_CONTROL_TOLERANCE IoRateControlTolerance;
    JOBOBJECT_RATE_CONTROL_TOLERANCE IoRateControlToleranceLimit;
    JOBOBJECT_RATE_CONTROL_TOLERANCE NetRateControlTolerance;
    JOBOBJECT_RATE_CONTROL_TOLERANCE NetRateControlToleranceLimit;
}

struct JOBOBJECT_CPU_RATE_CONTROL_INFORMATION
{
    uint ControlFlags;
    union
    {
        uint CpuRate;
        uint Weight;
        struct
        {
            ushort MinRate;
            ushort MaxRate;
        }
    }
}

struct JOBOBJECT_NET_RATE_CONTROL_INFORMATION
{
    ulong MaxBandwidth;
    JOB_OBJECT_NET_RATE_CONTROL_FLAGS ControlFlags;
    ubyte DscpTag;
}

struct JOBOBJECT_IO_RATE_CONTROL_INFORMATION_NATIVE
{
    long          MaxIops;
    long          MaxBandwidth;
    long          ReservationIops;
    const(wchar)* VolumeName;
    uint          BaseIoSize;
    JOB_OBJECT_IO_RATE_CONTROL_FLAGS ControlFlags;
    ushort        VolumeNameLength;
}

struct JOBOBJECT_IO_RATE_CONTROL_INFORMATION_NATIVE_V2
{
    long          MaxIops;
    long          MaxBandwidth;
    long          ReservationIops;
    const(wchar)* VolumeName;
    uint          BaseIoSize;
    JOB_OBJECT_IO_RATE_CONTROL_FLAGS ControlFlags;
    ushort        VolumeNameLength;
    long          CriticalReservationIops;
    long          ReservationBandwidth;
    long          CriticalReservationBandwidth;
    long          MaxTimePercent;
    long          ReservationTimePercent;
    long          CriticalReservationTimePercent;
}

struct JOBOBJECT_IO_RATE_CONTROL_INFORMATION_NATIVE_V3
{
    long          MaxIops;
    long          MaxBandwidth;
    long          ReservationIops;
    const(wchar)* VolumeName;
    uint          BaseIoSize;
    JOB_OBJECT_IO_RATE_CONTROL_FLAGS ControlFlags;
    ushort        VolumeNameLength;
    long          CriticalReservationIops;
    long          ReservationBandwidth;
    long          CriticalReservationBandwidth;
    long          MaxTimePercent;
    long          ReservationTimePercent;
    long          CriticalReservationTimePercent;
    long          SoftMaxIops;
    long          SoftMaxBandwidth;
    long          SoftMaxTimePercent;
    long          LimitExcessNotifyIops;
    long          LimitExcessNotifyBandwidth;
    long          LimitExcessNotifyTimePercent;
}

struct JOBOBJECT_IO_ATTRIBUTION_STATS
{
    size_t IoCount;
    ulong  TotalNonOverlappedQueueTime;
    ulong  TotalNonOverlappedServiceTime;
    ulong  TotalSize;
}

struct JOBOBJECT_IO_ATTRIBUTION_INFORMATION
{
    uint ControlFlags;
    JOBOBJECT_IO_ATTRIBUTION_STATS ReadStats;
    JOBOBJECT_IO_ATTRIBUTION_STATS WriteStats;
}

struct SILOOBJECT_BASIC_INFORMATION
{
    uint     SiloId;
    uint     SiloParentId;
    uint     NumberOfProcesses;
    ubyte    IsInServerSilo;
    ubyte[3] Reserved;
}

struct SERVERSILO_BASIC_INFORMATION
{
    uint             ServiceSessionId;
    SERVERSILO_STATE State;
    uint             ExitStatus;
    ubyte            IsDownlevelContainer;
    void*            ApiSetSchema;
    void*            HostApiSetSchema;
}

struct CACHE_DESCRIPTOR
{
    ubyte                Level;
    ubyte                Associativity;
    ushort               LineSize;
    uint                 Size;
    PROCESSOR_CACHE_TYPE Type;
}

struct SYSTEM_LOGICAL_PROCESSOR_INFORMATION
{
    size_t ProcessorMask;
    LOGICAL_PROCESSOR_RELATIONSHIP Relationship;
    union
    {
        struct ProcessorCore
        {
            ubyte Flags;
        }
        struct NumaNode
        {
            uint NodeNumber;
        }
        CACHE_DESCRIPTOR Cache;
        ulong[2]         Reserved;
    }
}

struct PROCESSOR_RELATIONSHIP
{
    ubyte             Flags;
    ubyte             EfficiencyClass;
    ubyte[20]         Reserved;
    ushort            GroupCount;
    GROUP_AFFINITY[1] GroupMask;
}

struct NUMA_NODE_RELATIONSHIP
{
    uint           NodeNumber;
    ubyte[20]      Reserved;
    GROUP_AFFINITY GroupMask;
}

struct CACHE_RELATIONSHIP
{
    ubyte                Level;
    ubyte                Associativity;
    ushort               LineSize;
    uint                 CacheSize;
    PROCESSOR_CACHE_TYPE Type;
    ubyte[20]            Reserved;
    GROUP_AFFINITY       GroupMask;
}

struct PROCESSOR_GROUP_INFO
{
    ubyte     MaximumProcessorCount;
    ubyte     ActiveProcessorCount;
    ubyte[38] Reserved;
    size_t    ActiveProcessorMask;
}

struct GROUP_RELATIONSHIP
{
    ushort    MaximumGroupCount;
    ushort    ActiveGroupCount;
    ubyte[20] Reserved;
    PROCESSOR_GROUP_INFO[1] GroupInfo;
}

struct SYSTEM_LOGICAL_PROCESSOR_INFORMATION_EX
{
    LOGICAL_PROCESSOR_RELATIONSHIP Relationship;
    uint Size;
    union
    {
        PROCESSOR_RELATIONSHIP Processor;
        NUMA_NODE_RELATIONSHIP NumaNode;
        CACHE_RELATIONSHIP Cache;
        GROUP_RELATIONSHIP Group;
    }
}

struct SYSTEM_CPU_SET_INFORMATION
{
    uint Size;
    CPU_SET_INFORMATION_TYPE Type;
    union
    {
        struct CpuSet
        {
            uint   Id;
            ushort Group;
            ubyte  LogicalProcessorIndex;
            ubyte  CoreIndex;
            ubyte  LastLevelCacheIndex;
            ubyte  NumaNodeIndex;
            ubyte  EfficiencyClass;
            union
            {
                ubyte AllFlags;
                struct
                {
                    ubyte _bitfield129;
                }
            }
            union
            {
                uint  Reserved;
                ubyte SchedulingClass;
            }
            ulong  AllocationTag;
        }
    }
}

struct SYSTEM_PROCESSOR_CYCLE_TIME_INFORMATION
{
    ulong CycleTime;
}

struct XSTATE_FEATURE
{
    uint Offset;
    uint Size;
}

struct XSTATE_CONFIGURATION
{
    ulong              EnabledFeatures;
    ulong              EnabledVolatileFeatures;
    uint               Size;
    union
    {
        uint ControlFlags;
        struct
        {
            uint _bitfield130;
        }
    }
    XSTATE_FEATURE[64] Features;
    ulong              EnabledSupervisorFeatures;
    ulong              AlignedFeatures;
    uint               AllFeatureSize;
    uint[64]           AllFeatures;
    ulong              EnabledUserVisibleSupervisorFeatures;
}

struct MEMORY_BASIC_INFORMATION
{
    void*  BaseAddress;
    void*  AllocationBase;
    uint   AllocationProtect;
    size_t RegionSize;
    uint   State;
    uint   Protect;
    uint   Type;
}

struct MEMORY_BASIC_INFORMATION32
{
    uint BaseAddress;
    uint AllocationBase;
    uint AllocationProtect;
    uint RegionSize;
    uint State;
    uint Protect;
    uint Type;
}

struct MEMORY_BASIC_INFORMATION64
{
    ulong BaseAddress;
    ulong AllocationBase;
    uint  AllocationProtect;
    uint  __alignment1;
    ulong RegionSize;
    uint  State;
    uint  Protect;
    uint  Type;
    uint  __alignment2;
}

struct CFG_CALL_TARGET_INFO
{
    size_t Offset;
    size_t Flags;
}

struct MEM_ADDRESS_REQUIREMENTS
{
    void*  LowestStartingAddress;
    void*  HighestEndingAddress;
    size_t Alignment;
}

struct MEM_EXTENDED_PARAMETER
{
    struct
    {
        ulong _bitfield131;
    }
    union
    {
        ulong  ULong64;
        void*  Pointer;
        size_t Size;
        HANDLE Handle;
        uint   ULong;
    }
}

struct ENCLAVE_CREATE_INFO_SGX
{
    ubyte[4096] Secs;
}

struct ENCLAVE_INIT_INFO_SGX
{
    ubyte[1808] SigStruct;
    ubyte[240]  Reserved1;
    ubyte[304]  EInitToken;
    ubyte[1744] Reserved2;
}

struct ENCLAVE_CREATE_INFO_VBS
{
    uint      Flags;
    ubyte[32] OwnerID;
}

struct ENCLAVE_CREATE_INFO_VBS_BASIC
{
    uint      Flags;
    ubyte[32] OwnerID;
}

struct ENCLAVE_LOAD_DATA_VBS_BASIC
{
    uint PageType;
}

struct ENCLAVE_INIT_INFO_VBS_BASIC
{
    ubyte[16] FamilyId;
    ubyte[16] ImageId;
    ulong     EnclaveSize;
    uint      EnclaveSvn;
    uint      Reserved;
    union
    {
        HANDLE SignatureInfoHandle;
        ulong  Unused;
    }
}

struct ENCLAVE_INIT_INFO_VBS
{
    uint Length;
    uint ThreadCount;
}

union FILE_SEGMENT_ELEMENT
{
    void* Buffer;
    ulong Alignment;
}

struct SCRUB_DATA_INPUT
{
    uint       Size;
    uint       Flags;
    uint       MaximumIos;
    uint[4]    ObjectId;
    uint[25]   Reserved;
    ubyte[816] ResumeContext;
}

struct SCRUB_PARITY_EXTENT
{
    long  Offset;
    ulong Length;
}

struct SCRUB_PARITY_EXTENT_DATA
{
    ushort Size;
    ushort Flags;
    ushort NumberOfParityExtents;
    ushort MaximumNumberOfParityExtents;
    SCRUB_PARITY_EXTENT[1] ParityExtents;
}

struct SCRUB_DATA_OUTPUT
{
    uint       Size;
    uint       Flags;
    uint       Status;
    ulong      ErrorFileOffset;
    ulong      ErrorLength;
    ulong      NumberOfBytesRepaired;
    ulong      NumberOfBytesFailed;
    ulong      InternalFileReference;
    ushort     ResumeContextLength;
    ushort     ParityExtentDataOffset;
    uint[9]    Reserved;
    ulong      NumberOfMetadataBytesProcessed;
    ulong      NumberOfDataBytesProcessed;
    ulong      TotalNumberOfMetadataBytesInUse;
    ulong      TotalNumberOfDataBytesInUse;
    ubyte[816] ResumeContext;
}

struct SHARED_VIRTUAL_DISK_SUPPORT
{
    SharedVirtualDiskSupportType SharedVirtualDiskSupport;
    SharedVirtualDiskHandleState HandleState;
}

struct REARRANGE_FILE_DATA
{
    ulong  SourceStartingOffset;
    ulong  TargetOffset;
    HANDLE SourceFileHandle;
    uint   Length;
    uint   Flags;
}

struct SHUFFLE_FILE_DATA
{
    long StartingOffset;
    long Length;
    uint Flags;
}

struct NETWORK_APP_INSTANCE_EA
{
    GUID AppInstanceID;
    uint CsvFlags;
}

struct CM_Power_Data_s
{
    uint               PD_Size;
    DEVICE_POWER_STATE PD_MostRecentPowerState;
    uint               PD_Capabilities;
    uint               PD_D1Latency;
    uint               PD_D2Latency;
    uint               PD_D3Latency;
    DEVICE_POWER_STATE[7] PD_PowerStateMapping;
    SYSTEM_POWER_STATE PD_DeepestSystemWake;
}

struct POWER_USER_PRESENCE
{
    POWER_USER_PRESENCE_TYPE UserPresence;
}

struct POWER_SESSION_CONNECT
{
    ubyte Connected;
    ubyte Console;
}

struct POWER_SESSION_TIMEOUTS
{
    uint InputTimeout;
    uint DisplayTimeout;
}

struct POWER_SESSION_RIT_STATE
{
    ubyte Active;
    uint  LastInputTime;
}

struct POWER_SESSION_WINLOGON
{
    uint  SessionId;
    ubyte Console;
    ubyte Locked;
}

struct POWER_SESSION_ALLOW_EXTERNAL_DMA_DEVICES
{
    ubyte IsAllowed;
}

struct POWER_IDLE_RESILIENCY
{
    uint CoalescingTimeout;
    uint IdleResiliencyPeriod;
}

struct POWER_MONITOR_INVOCATION
{
    ubyte Console;
    POWER_MONITOR_REQUEST_REASON RequestReason;
}

struct RESUME_PERFORMANCE
{
    uint  PostTimeMs;
    ulong TotalResumeTimeMs;
    ulong ResumeCompleteTimestamp;
}

struct SET_POWER_SETTING_VALUE
{
    uint     Version;
    GUID     Guid;
    SYSTEM_POWER_CONDITION PowerCondition;
    uint     DataLength;
    ubyte[1] Data;
}

struct NOTIFY_USER_POWER_SETTING
{
    GUID Guid;
}

struct APPLICATIONLAUNCH_SETTING_VALUE
{
    LARGE_INTEGER ActivationTime;
    uint          Flags;
    uint          ButtonInstanceID;
}

struct POWER_PLATFORM_INFORMATION
{
    ubyte AoAc;
}

struct BATTERY_REPORTING_SCALE
{
    uint Granularity;
    uint Capacity;
}

struct PPM_WMI_LEGACY_PERFSTATE
{
    uint Frequency;
    uint Flags;
    uint PercentFrequency;
}

struct PPM_WMI_IDLE_STATE
{
    uint  Latency;
    uint  Power;
    uint  TimeCheck;
    ubyte PromotePercent;
    ubyte DemotePercent;
    ubyte StateType;
    ubyte Reserved;
    uint  StateFlags;
    uint  Context;
    uint  IdleHandler;
    uint  Reserved1;
}

struct PPM_WMI_IDLE_STATES
{
    uint  Type;
    uint  Count;
    uint  TargetState;
    uint  OldState;
    ulong TargetProcessors;
    PPM_WMI_IDLE_STATE[1] State;
}

struct PPM_WMI_IDLE_STATES_EX
{
    uint  Type;
    uint  Count;
    uint  TargetState;
    uint  OldState;
    void* TargetProcessors;
    PPM_WMI_IDLE_STATE[1] State;
}

struct PPM_WMI_PERF_STATE
{
    uint  Frequency;
    uint  Power;
    ubyte PercentFrequency;
    ubyte IncreaseLevel;
    ubyte DecreaseLevel;
    ubyte Type;
    uint  IncreaseTime;
    uint  DecreaseTime;
    ulong Control;
    ulong Status;
    uint  HitCount;
    uint  Reserved1;
    ulong Reserved2;
    ulong Reserved3;
}

struct PPM_WMI_PERF_STATES
{
    uint  Count;
    uint  MaxFrequency;
    uint  CurrentState;
    uint  MaxPerfState;
    uint  MinPerfState;
    uint  LowestPerfState;
    uint  ThermalConstraint;
    ubyte BusyAdjThreshold;
    ubyte PolicyType;
    ubyte Type;
    ubyte Reserved;
    uint  TimerInterval;
    ulong TargetProcessors;
    uint  PStateHandler;
    uint  PStateContext;
    uint  TStateHandler;
    uint  TStateContext;
    uint  FeedbackHandler;
    uint  Reserved1;
    ulong Reserved2;
    PPM_WMI_PERF_STATE[1] State;
}

struct PPM_WMI_PERF_STATES_EX
{
    uint  Count;
    uint  MaxFrequency;
    uint  CurrentState;
    uint  MaxPerfState;
    uint  MinPerfState;
    uint  LowestPerfState;
    uint  ThermalConstraint;
    ubyte BusyAdjThreshold;
    ubyte PolicyType;
    ubyte Type;
    ubyte Reserved;
    uint  TimerInterval;
    void* TargetProcessors;
    uint  PStateHandler;
    uint  PStateContext;
    uint  TStateHandler;
    uint  TStateContext;
    uint  FeedbackHandler;
    uint  Reserved1;
    ulong Reserved2;
    PPM_WMI_PERF_STATE[1] State;
}

struct PPM_IDLE_STATE_ACCOUNTING
{
    uint    IdleTransitions;
    uint    FailedTransitions;
    uint    InvalidBucketIndex;
    ulong   TotalTime;
    uint[6] IdleTimeBuckets;
}

struct PPM_IDLE_ACCOUNTING
{
    uint  StateCount;
    uint  TotalTransitions;
    uint  ResetCount;
    ulong StartTime;
    PPM_IDLE_STATE_ACCOUNTING[1] State;
}

struct PPM_IDLE_STATE_BUCKET_EX
{
    ulong TotalTimeUs;
    uint  MinTimeUs;
    uint  MaxTimeUs;
    uint  Count;
}

struct PPM_IDLE_STATE_ACCOUNTING_EX
{
    ulong TotalTime;
    uint  IdleTransitions;
    uint  FailedTransitions;
    uint  InvalidBucketIndex;
    uint  MinTimeUs;
    uint  MaxTimeUs;
    uint  CancelledTransitions;
    PPM_IDLE_STATE_BUCKET_EX[16] IdleTimeBuckets;
}

struct PPM_IDLE_ACCOUNTING_EX
{
    uint  StateCount;
    uint  TotalTransitions;
    uint  ResetCount;
    uint  AbortCount;
    ulong StartTime;
    PPM_IDLE_STATE_ACCOUNTING_EX[1] State;
}

struct PPM_PERFSTATE_EVENT
{
    uint State;
    uint Status;
    uint Latency;
    uint Speed;
    uint Processor;
}

struct PPM_PERFSTATE_DOMAIN_EVENT
{
    uint  State;
    uint  Latency;
    uint  Speed;
    ulong Processors;
}

struct PPM_IDLESTATE_EVENT
{
    uint  NewState;
    uint  OldState;
    ulong Processors;
}

struct PPM_THERMALCHANGE_EVENT
{
    uint  ThermalConstraint;
    ulong Processors;
}

struct PPM_THERMAL_POLICY_EVENT
{
    ubyte Mode;
    ulong Processors;
}

struct POWER_ACTION_POLICY
{
    POWER_ACTION Action;
    uint         Flags;
    uint         EventCode;
}

struct SYSTEM_POWER_LEVEL
{
    ubyte               Enable;
    ubyte[3]            Spare;
    uint                BatteryLevel;
    POWER_ACTION_POLICY PowerPolicy;
    SYSTEM_POWER_STATE  MinSystemState;
}

struct SYSTEM_POWER_POLICY
{
    uint                Revision;
    POWER_ACTION_POLICY PowerButton;
    POWER_ACTION_POLICY SleepButton;
    POWER_ACTION_POLICY LidClose;
    SYSTEM_POWER_STATE  LidOpenWake;
    uint                Reserved;
    POWER_ACTION_POLICY Idle;
    uint                IdleTimeout;
    ubyte               IdleSensitivity;
    ubyte               DynamicThrottle;
    ubyte[2]            Spare2;
    SYSTEM_POWER_STATE  MinSleep;
    SYSTEM_POWER_STATE  MaxSleep;
    SYSTEM_POWER_STATE  ReducedLatencySleep;
    uint                WinLogonFlags;
    uint                Spare3;
    uint                DozeS4Timeout;
    uint                BroadcastCapacityResolution;
    SYSTEM_POWER_LEVEL[4] DischargePolicy;
    uint                VideoTimeout;
    ubyte               VideoDimDisplay;
    uint[3]             VideoReserved;
    uint                SpindownTimeout;
    ubyte               OptimizeForPower;
    ubyte               FanThrottleTolerance;
    ubyte               ForcedThrottle;
    ubyte               MinThrottle;
    POWER_ACTION_POLICY OverThrottled;
}

struct PROCESSOR_IDLESTATE_INFO
{
    uint     TimeCheck;
    ubyte    DemotePercent;
    ubyte    PromotePercent;
    ubyte[2] Spare;
}

struct PROCESSOR_IDLESTATE_POLICY
{
    ushort Revision;
    union Flags
    {
        ushort AsWORD;
        struct
        {
            ushort _bitfield132;
        }
    }
    uint   PolicyCount;
    PROCESSOR_IDLESTATE_INFO[3] Policy;
}

struct PROCESSOR_POWER_POLICY_INFO
{
    uint     TimeCheck;
    uint     DemoteLimit;
    uint     PromoteLimit;
    ubyte    DemotePercent;
    ubyte    PromotePercent;
    ubyte[2] Spare;
    uint     _bitfield133;
}

struct PROCESSOR_POWER_POLICY
{
    uint     Revision;
    ubyte    DynamicThrottle;
    ubyte[3] Spare;
    uint     _bitfield134;
    uint     PolicyCount;
    PROCESSOR_POWER_POLICY_INFO[3] Policy;
}

struct PROCESSOR_PERFSTATE_POLICY
{
    uint  Revision;
    ubyte MaxThrottle;
    ubyte MinThrottle;
    ubyte BusyAdjThreshold;
    union
    {
        ubyte Spare;
        union Flags
        {
            ubyte AsBYTE;
            struct
            {
                ubyte _bitfield135;
            }
        }
    }
    uint  TimeCheck;
    uint  IncreaseTime;
    uint  DecreaseTime;
    uint  IncreasePercent;
    uint  DecreasePercent;
}

struct ADMINISTRATOR_POWER_POLICY
{
    SYSTEM_POWER_STATE MinSleep;
    SYSTEM_POWER_STATE MaxSleep;
    uint               MinVideoTimeout;
    uint               MaxVideoTimeout;
    uint               MinSpindownTimeout;
    uint               MaxSpindownTimeout;
}

struct HIBERFILE_BUCKET
{
    ulong   MaxPhysicalMemory;
    uint[3] PhysicalMemoryPercent;
}

struct SYSTEM_POWER_CAPABILITIES
{
    ubyte              PowerButtonPresent;
    ubyte              SleepButtonPresent;
    ubyte              LidPresent;
    ubyte              SystemS1;
    ubyte              SystemS2;
    ubyte              SystemS3;
    ubyte              SystemS4;
    ubyte              SystemS5;
    ubyte              HiberFilePresent;
    ubyte              FullWake;
    ubyte              VideoDimPresent;
    ubyte              ApmPresent;
    ubyte              UpsPresent;
    ubyte              ThermalControl;
    ubyte              ProcessorThrottle;
    ubyte              ProcessorMinThrottle;
    ubyte              ProcessorMaxThrottle;
    ubyte              FastSystemS4;
    ubyte              Hiberboot;
    ubyte              WakeAlarmPresent;
    ubyte              AoAc;
    ubyte              DiskSpinDown;
    ubyte              HiberFileType;
    ubyte              AoAcConnectivitySupported;
    ubyte[6]           spare3;
    ubyte              SystemBatteriesPresent;
    ubyte              BatteriesAreShortTerm;
    BATTERY_REPORTING_SCALE[3] BatteryScale;
    SYSTEM_POWER_STATE AcOnLineWake;
    SYSTEM_POWER_STATE SoftLidWake;
    SYSTEM_POWER_STATE RtcWake;
    SYSTEM_POWER_STATE MinDeviceWakeState;
    SYSTEM_POWER_STATE DefaultLowLatencyWake;
}

struct SYSTEM_BATTERY_STATE
{
    ubyte    AcOnLine;
    ubyte    BatteryPresent;
    ubyte    Charging;
    ubyte    Discharging;
    ubyte[3] Spare1;
    ubyte    Tag;
    uint     MaxCapacity;
    uint     RemainingCapacity;
    uint     Rate;
    uint     EstimatedTime;
    uint     DefaultAlert1;
    uint     DefaultAlert2;
}

struct IMAGE_DOS_HEADER
{
align (2):
    ushort     e_magic;
    ushort     e_cblp;
    ushort     e_cp;
    ushort     e_crlc;
    ushort     e_cparhdr;
    ushort     e_minalloc;
    ushort     e_maxalloc;
    ushort     e_ss;
    ushort     e_sp;
    ushort     e_csum;
    ushort     e_ip;
    ushort     e_cs;
    ushort     e_lfarlc;
    ushort     e_ovno;
    ushort[4]  e_res;
    ushort     e_oemid;
    ushort     e_oeminfo;
    ushort[10] e_res2;
    int        e_lfanew;
}

struct IMAGE_OS2_HEADER
{
align (2):
    ushort ne_magic;
    byte   ne_ver;
    byte   ne_rev;
    ushort ne_enttab;
    ushort ne_cbenttab;
    int    ne_crc;
    ushort ne_flags;
    ushort ne_autodata;
    ushort ne_heap;
    ushort ne_stack;
    int    ne_csip;
    int    ne_sssp;
    ushort ne_cseg;
    ushort ne_cmod;
    ushort ne_cbnrestab;
    ushort ne_segtab;
    ushort ne_rsrctab;
    ushort ne_restab;
    ushort ne_modtab;
    ushort ne_imptab;
    int    ne_nrestab;
    ushort ne_cmovent;
    ushort ne_align;
    ushort ne_cres;
    ubyte  ne_exetyp;
    ubyte  ne_flagsothers;
    ushort ne_pretthunks;
    ushort ne_psegrefbytes;
    ushort ne_swaparea;
    ushort ne_expver;
}

struct IMAGE_VXD_HEADER
{
align (2):
    ushort    e32_magic;
    ubyte     e32_border;
    ubyte     e32_worder;
    uint      e32_level;
    ushort    e32_cpu;
    ushort    e32_os;
    uint      e32_ver;
    uint      e32_mflags;
    uint      e32_mpages;
    uint      e32_startobj;
    uint      e32_eip;
    uint      e32_stackobj;
    uint      e32_esp;
    uint      e32_pagesize;
    uint      e32_lastpagesize;
    uint      e32_fixupsize;
    uint      e32_fixupsum;
    uint      e32_ldrsize;
    uint      e32_ldrsum;
    uint      e32_objtab;
    uint      e32_objcnt;
    uint      e32_objmap;
    uint      e32_itermap;
    uint      e32_rsrctab;
    uint      e32_rsrccnt;
    uint      e32_restab;
    uint      e32_enttab;
    uint      e32_dirtab;
    uint      e32_dircnt;
    uint      e32_fpagetab;
    uint      e32_frectab;
    uint      e32_impmod;
    uint      e32_impmodcnt;
    uint      e32_impproc;
    uint      e32_pagesum;
    uint      e32_datapage;
    uint      e32_preload;
    uint      e32_nrestab;
    uint      e32_cbnrestab;
    uint      e32_nressum;
    uint      e32_autodata;
    uint      e32_debuginfo;
    uint      e32_debuglen;
    uint      e32_instpreload;
    uint      e32_instdemand;
    uint      e32_heapsize;
    ubyte[12] e32_res3;
    uint      e32_winresoff;
    uint      e32_winreslen;
    ushort    e32_devid;
    ushort    e32_ddkver;
}

struct IMAGE_OPTIONAL_HEADER
{
    ushort Magic;
    ubyte  MajorLinkerVersion;
    ubyte  MinorLinkerVersion;
    uint   SizeOfCode;
    uint   SizeOfInitializedData;
    uint   SizeOfUninitializedData;
    uint   AddressOfEntryPoint;
    uint   BaseOfCode;
    uint   BaseOfData;
    uint   ImageBase;
    uint   SectionAlignment;
    uint   FileAlignment;
    ushort MajorOperatingSystemVersion;
    ushort MinorOperatingSystemVersion;
    ushort MajorImageVersion;
    ushort MinorImageVersion;
    ushort MajorSubsystemVersion;
    ushort MinorSubsystemVersion;
    uint   Win32VersionValue;
    uint   SizeOfImage;
    uint   SizeOfHeaders;
    uint   CheckSum;
    ushort Subsystem;
    ushort DllCharacteristics;
    uint   SizeOfStackReserve;
    uint   SizeOfStackCommit;
    uint   SizeOfHeapReserve;
    uint   SizeOfHeapCommit;
    uint   LoaderFlags;
    uint   NumberOfRvaAndSizes;
    IMAGE_DATA_DIRECTORY[16] DataDirectory;
}

struct IMAGE_ROM_OPTIONAL_HEADER
{
    ushort  Magic;
    ubyte   MajorLinkerVersion;
    ubyte   MinorLinkerVersion;
    uint    SizeOfCode;
    uint    SizeOfInitializedData;
    uint    SizeOfUninitializedData;
    uint    AddressOfEntryPoint;
    uint    BaseOfCode;
    uint    BaseOfData;
    uint    BaseOfBss;
    uint    GprMask;
    uint[4] CprMask;
    uint    GpValue;
}

struct IMAGE_NT_HEADERS
{
    uint              Signature;
    IMAGE_FILE_HEADER FileHeader;
    IMAGE_OPTIONAL_HEADER OptionalHeader;
}

struct IMAGE_ROM_HEADERS
{
    IMAGE_FILE_HEADER FileHeader;
    IMAGE_ROM_OPTIONAL_HEADER OptionalHeader;
}

struct ANON_OBJECT_HEADER
{
    ushort Sig1;
    ushort Sig2;
    ushort Version;
    ushort Machine;
    uint   TimeDateStamp;
    GUID   ClassID;
    uint   SizeOfData;
}

struct ANON_OBJECT_HEADER_V2
{
    ushort Sig1;
    ushort Sig2;
    ushort Version;
    ushort Machine;
    uint   TimeDateStamp;
    GUID   ClassID;
    uint   SizeOfData;
    uint   Flags;
    uint   MetaDataSize;
    uint   MetaDataOffset;
}

struct ANON_OBJECT_HEADER_BIGOBJ
{
    ushort Sig1;
    ushort Sig2;
    ushort Version;
    ushort Machine;
    uint   TimeDateStamp;
    GUID   ClassID;
    uint   SizeOfData;
    uint   Flags;
    uint   MetaDataSize;
    uint   MetaDataOffset;
    uint   NumberOfSections;
    uint   PointerToSymbolTable;
    uint   NumberOfSymbols;
}

struct IMAGE_SYMBOL
{
align (2):
    union N
    {
    align (2):
        ubyte[8] ShortName;
        struct Name
        {
        align (2):
            uint Short;
            uint Long;
        }
        uint[2]  LongName;
    }
    uint   Value;
    short  SectionNumber;
    ushort Type;
    ubyte  StorageClass;
    ubyte  NumberOfAuxSymbols;
}

struct IMAGE_SYMBOL_EX
{
align (2):
    union N
    {
    align (2):
        ubyte[8] ShortName;
        struct Name
        {
        align (2):
            uint Short;
            uint Long;
        }
        uint[2]  LongName;
    }
    uint   Value;
    int    SectionNumber;
    ushort Type;
    ubyte  StorageClass;
    ubyte  NumberOfAuxSymbols;
}

struct IMAGE_AUX_SYMBOL_TOKEN_DEF
{
align (2):
    ubyte     bAuxType;
    ubyte     bReserved;
    uint      SymbolTableIndex;
    ubyte[12] rgbReserved;
}

union IMAGE_AUX_SYMBOL
{
    struct Sym
    {
    align (2):
        uint   TagIndex;
        union Misc
        {
        align (2):
            struct LnSz
            {
                ushort Linenumber;
                ushort Size;
            }
            uint TotalSize;
        }
        union FcnAry
        {
            struct Function
            {
            align (2):
                uint PointerToLinenumber;
                uint PointerToNextFunction;
            }
            struct Array
            {
                ushort[4] Dimension;
            }
        }
        ushort TvIndex;
    }
    struct File
    {
        ubyte[18] Name;
    }
    struct Section
    {
    align (2):
        uint   Length;
        ushort NumberOfRelocations;
        ushort NumberOfLinenumbers;
        uint   CheckSum;
        short  Number;
        ubyte  Selection;
        ubyte  bReserved;
        short  HighNumber;
    }
    IMAGE_AUX_SYMBOL_TOKEN_DEF TokenDef;
    struct CRC
    {
    align (2):
        uint      crc;
        ubyte[14] rgbReserved;
    }
}

union IMAGE_AUX_SYMBOL_EX
{
    struct Sym
    {
    align (2):
        uint      WeakDefaultSymIndex;
        uint      WeakSearchType;
        ubyte[12] rgbReserved;
    }
    struct File
    {
        ubyte[20] Name;
    }
    struct Section
    {
    align (2):
        uint     Length;
        ushort   NumberOfRelocations;
        ushort   NumberOfLinenumbers;
        uint     CheckSum;
        short    Number;
        ubyte    Selection;
        ubyte    bReserved;
        short    HighNumber;
        ubyte[2] rgbReserved;
    }
    struct
    {
        IMAGE_AUX_SYMBOL_TOKEN_DEF TokenDef;
        ubyte[2] rgbReserved;
    }
    struct CRC
    {
    align (2):
        uint      crc;
        ubyte[16] rgbReserved;
    }
}

struct IMAGE_RELOCATION
{
align (2):
    union
    {
    align (2):
        uint VirtualAddress;
        uint RelocCount;
    }
    uint   SymbolTableIndex;
    ushort Type;
}

struct IMAGE_LINENUMBER
{
    union Type
    {
    align (2):
        uint SymbolTableIndex;
        uint VirtualAddress;
    }
    ushort Linenumber;
}

struct IMAGE_BASE_RELOCATION
{
    uint VirtualAddress;
    uint SizeOfBlock;
}

struct IMAGE_ARCHIVE_MEMBER_HEADER
{
    ubyte[16] Name;
    ubyte[12] Date;
    ubyte[6]  UserID;
    ubyte[6]  GroupID;
    ubyte[8]  Mode;
    ubyte[10] Size;
    ubyte[2]  EndHeader;
}

struct IMAGE_EXPORT_DIRECTORY
{
    uint   Characteristics;
    uint   TimeDateStamp;
    ushort MajorVersion;
    ushort MinorVersion;
    uint   Name;
    uint   Base;
    uint   NumberOfFunctions;
    uint   NumberOfNames;
    uint   AddressOfFunctions;
    uint   AddressOfNames;
    uint   AddressOfNameOrdinals;
}

struct IMAGE_IMPORT_BY_NAME
{
    ushort  Hint;
    byte[1] Name;
}

struct IMAGE_THUNK_DATA64
{
    union u1
    {
        ulong ForwarderString;
        ulong Function;
        ulong Ordinal;
        ulong AddressOfData;
    }
}

struct IMAGE_THUNK_DATA32
{
    union u1
    {
        uint ForwarderString;
        uint Function;
        uint Ordinal;
        uint AddressOfData;
    }
}

struct IMAGE_TLS_DIRECTORY64
{
align (4):
    ulong StartAddressOfRawData;
    ulong EndAddressOfRawData;
    ulong AddressOfIndex;
    ulong AddressOfCallBacks;
    uint  SizeOfZeroFill;
    union
    {
        uint Characteristics;
        struct
        {
            uint _bitfield136;
        }
    }
}

struct IMAGE_TLS_DIRECTORY32
{
    uint StartAddressOfRawData;
    uint EndAddressOfRawData;
    uint AddressOfIndex;
    uint AddressOfCallBacks;
    uint SizeOfZeroFill;
    union
    {
        uint Characteristics;
        struct
        {
            uint _bitfield137;
        }
    }
}

struct IMAGE_IMPORT_DESCRIPTOR
{
    union
    {
        uint Characteristics;
        uint OriginalFirstThunk;
    }
    uint TimeDateStamp;
    uint ForwarderChain;
    uint Name;
    uint FirstThunk;
}

struct IMAGE_BOUND_IMPORT_DESCRIPTOR
{
    uint   TimeDateStamp;
    ushort OffsetModuleName;
    ushort NumberOfModuleForwarderRefs;
}

struct IMAGE_BOUND_FORWARDER_REF
{
    uint   TimeDateStamp;
    ushort OffsetModuleName;
    ushort Reserved;
}

struct IMAGE_DELAYLOAD_DESCRIPTOR
{
    union Attributes
    {
        uint AllAttributes;
        struct
        {
            uint _bitfield138;
        }
    }
    uint DllNameRVA;
    uint ModuleHandleRVA;
    uint ImportAddressTableRVA;
    uint ImportNameTableRVA;
    uint BoundImportAddressTableRVA;
    uint UnloadInformationTableRVA;
    uint TimeDateStamp;
}

struct IMAGE_RESOURCE_DIRECTORY
{
    uint   Characteristics;
    uint   TimeDateStamp;
    ushort MajorVersion;
    ushort MinorVersion;
    ushort NumberOfNamedEntries;
    ushort NumberOfIdEntries;
}

struct IMAGE_RESOURCE_DIRECTORY_ENTRY
{
    union
    {
        struct
        {
            uint _bitfield139;
        }
        uint   Name;
        ushort Id;
    }
    union
    {
        uint OffsetToData;
        struct
        {
            uint _bitfield140;
        }
    }
}

struct IMAGE_RESOURCE_DIRECTORY_STRING
{
    ushort  Length;
    byte[1] NameString;
}

struct IMAGE_RESOURCE_DIR_STRING_U
{
    ushort    Length;
    ushort[1] NameString;
}

struct IMAGE_RESOURCE_DATA_ENTRY
{
    uint OffsetToData;
    uint Size;
    uint CodePage;
    uint Reserved;
}

struct IMAGE_LOAD_CONFIG_CODE_INTEGRITY
{
    ushort Flags;
    ushort Catalog;
    uint   CatalogOffset;
    uint   Reserved;
}

struct IMAGE_DYNAMIC_RELOCATION_TABLE
{
    uint Version;
    uint Size;
}

struct IMAGE_DYNAMIC_RELOCATION32
{
align (1):
    uint Symbol;
    uint BaseRelocSize;
}

struct IMAGE_DYNAMIC_RELOCATION64
{
align (1):
    ulong Symbol;
    uint  BaseRelocSize;
}

struct IMAGE_DYNAMIC_RELOCATION32_V2
{
align (1):
    uint HeaderSize;
    uint FixupInfoSize;
    uint Symbol;
    uint SymbolGroup;
    uint Flags;
}

struct IMAGE_DYNAMIC_RELOCATION64_V2
{
align (1):
    uint  HeaderSize;
    uint  FixupInfoSize;
    ulong Symbol;
    uint  SymbolGroup;
    uint  Flags;
}

struct IMAGE_PROLOGUE_DYNAMIC_RELOCATION_HEADER
{
    ubyte PrologueByteCount;
}

struct IMAGE_EPILOGUE_DYNAMIC_RELOCATION_HEADER
{
align (1):
    uint   EpilogueCount;
    ubyte  EpilogueByteCount;
    ubyte  BranchDescriptorElementSize;
    ushort BranchDescriptorCount;
}

struct IMAGE_IMPORT_CONTROL_TRANSFER_DYNAMIC_RELOCATION
{
align (1):
    uint _bitfield141;
}

struct IMAGE_INDIR_CONTROL_TRANSFER_DYNAMIC_RELOCATION
{
align (1):
    ushort _bitfield142;
}

struct IMAGE_SWITCHTABLE_BRANCH_DYNAMIC_RELOCATION
{
align (1):
    ushort _bitfield143;
}

struct IMAGE_HOT_PATCH_INFO
{
    uint Version;
    uint Size;
    uint SequenceNumber;
    uint BaseImageList;
    uint BaseImageCount;
    uint BufferOffset;
    uint ExtraPatchSize;
}

struct IMAGE_HOT_PATCH_BASE
{
    uint SequenceNumber;
    uint Flags;
    uint OriginalTimeDateStamp;
    uint OriginalCheckSum;
    uint CodeIntegrityInfo;
    uint CodeIntegritySize;
    uint PatchTable;
    uint BufferOffset;
}

struct IMAGE_HOT_PATCH_HASHES
{
    ubyte[32] SHA256;
    ubyte[20] SHA1;
}

struct IMAGE_CE_RUNTIME_FUNCTION_ENTRY
{
    uint FuncStart;
    uint _bitfield144;
}

struct IMAGE_ARM_RUNTIME_FUNCTION_ENTRY
{
    uint BeginAddress;
    union
    {
        uint UnwindData;
        struct
        {
            uint _bitfield145;
        }
    }
}

struct IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY
{
    uint BeginAddress;
    union
    {
        uint UnwindData;
        struct
        {
            uint _bitfield146;
        }
    }
}

union IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY_XDATA
{
    uint HeaderData;
    struct
    {
        uint _bitfield147;
    }
}

struct IMAGE_ALPHA64_RUNTIME_FUNCTION_ENTRY
{
align (4):
    ulong BeginAddress;
    ulong EndAddress;
    ulong ExceptionHandler;
    ulong HandlerData;
    ulong PrologEndAddress;
}

struct IMAGE_ALPHA_RUNTIME_FUNCTION_ENTRY
{
    uint BeginAddress;
    uint EndAddress;
    uint ExceptionHandler;
    uint HandlerData;
    uint PrologEndAddress;
}

struct IMAGE_RUNTIME_FUNCTION_ENTRY
{
    uint BeginAddress;
    uint EndAddress;
    union
    {
        uint UnwindInfoAddress;
        uint UnwindData;
    }
}

struct IMAGE_ENCLAVE_CONFIG32
{
    uint      Size;
    uint      MinimumRequiredConfigSize;
    uint      PolicyFlags;
    uint      NumberOfImports;
    uint      ImportList;
    uint      ImportEntrySize;
    ubyte[16] FamilyID;
    ubyte[16] ImageID;
    uint      ImageVersion;
    uint      SecurityVersion;
    uint      EnclaveSize;
    uint      NumberOfThreads;
    uint      EnclaveFlags;
}

struct IMAGE_ENCLAVE_CONFIG64
{
align (4):
    uint      Size;
    uint      MinimumRequiredConfigSize;
    uint      PolicyFlags;
    uint      NumberOfImports;
    uint      ImportList;
    uint      ImportEntrySize;
    ubyte[16] FamilyID;
    ubyte[16] ImageID;
    uint      ImageVersion;
    uint      SecurityVersion;
    ulong     EnclaveSize;
    uint      NumberOfThreads;
    uint      EnclaveFlags;
}

struct IMAGE_ENCLAVE_IMPORT
{
    uint      MatchType;
    uint      MinimumSecurityVersion;
    ubyte[32] UniqueOrAuthorID;
    ubyte[16] FamilyID;
    ubyte[16] ImageID;
    uint      ImportName;
    uint      Reserved;
}

struct IMAGE_DEBUG_MISC
{
    uint     DataType;
    uint     Length;
    ubyte    Unicode;
    ubyte[3] Reserved;
    ubyte[1] Data;
}

struct IMAGE_SEPARATE_DEBUG_HEADER
{
    ushort  Signature;
    ushort  Flags;
    ushort  Machine;
    ushort  Characteristics;
    uint    TimeDateStamp;
    uint    CheckSum;
    uint    ImageBase;
    uint    SizeOfImage;
    uint    NumberOfSections;
    uint    ExportedNamesSize;
    uint    DebugDirectorySize;
    uint    SectionAlignment;
    uint[2] Reserved;
}

struct NON_PAGED_DEBUG_INFO
{
align (4):
    ushort Signature;
    ushort Flags;
    uint   Size;
    ushort Machine;
    ushort Characteristics;
    uint   TimeDateStamp;
    uint   CheckSum;
    uint   SizeOfImage;
    ulong  ImageBase;
}

struct IMAGE_ARCHITECTURE_HEADER
{
    uint _bitfield148;
    uint FirstEntryRVA;
}

struct IMAGE_ARCHITECTURE_ENTRY
{
    uint FixupInstRVA;
    uint NewInst;
}

struct IMPORT_OBJECT_HEADER
{
    ushort Sig1;
    ushort Sig2;
    ushort Version;
    ushort Machine;
    uint   TimeDateStamp;
    uint   SizeOfData;
    union
    {
        ushort Ordinal;
        ushort Hint;
    }
    ushort _bitfield149;
}

struct IMAGE_COR20_HEADER
{
    uint                 cb;
    ushort               MajorRuntimeVersion;
    ushort               MinorRuntimeVersion;
    IMAGE_DATA_DIRECTORY MetaData;
    uint                 Flags;
    union
    {
        uint EntryPointToken;
        uint EntryPointRVA;
    }
    IMAGE_DATA_DIRECTORY Resources;
    IMAGE_DATA_DIRECTORY StrongNameSignature;
    IMAGE_DATA_DIRECTORY CodeManagerTable;
    IMAGE_DATA_DIRECTORY VTableFixups;
    IMAGE_DATA_DIRECTORY ExportAddressTableJumps;
    IMAGE_DATA_DIRECTORY ManagedNativeHeader;
}

union SLIST_HEADER
{
    ulong Alignment;
    struct
    {
        SINGLE_LIST_ENTRY Next;
        ushort            Depth;
        ushort            CpuId;
    }
}

union RTL_RUN_ONCE
{
    void* Ptr;
}

struct RTL_BARRIER
{
    uint      Reserved1;
    uint      Reserved2;
    size_t[2] Reserved3;
    uint      Reserved4;
    uint      Reserved5;
}

struct NV_MEMORY_RANGE
{
    void*  BaseAddress;
    size_t Length;
}

struct CORRELATION_VECTOR
{
    byte      Version;
    byte[129] Vector;
}

struct CUSTOM_SYSTEM_EVENT_TRIGGER_CONFIG
{
    uint          Size;
    const(wchar)* TriggerId;
}

struct IMAGE_POLICY_ENTRY
{
    IMAGE_POLICY_ENTRY_TYPE Type;
    IMAGE_POLICY_ID PolicyId;
    union u
    {
        const(void)*  None;
        ubyte         BoolValue;
        byte          Int8Value;
        ubyte         UInt8Value;
        short         Int16Value;
        ushort        UInt16Value;
        int           Int32Value;
        uint          UInt32Value;
        long          Int64Value;
        ulong         UInt64Value;
        const(char)*  AnsiStringValue;
        const(wchar)* UnicodeStringValue;
    }
}

struct IMAGE_POLICY_METADATA
{
    ubyte              Version;
    ubyte[7]           Reserved0;
    ulong              ApplicationId;
    IMAGE_POLICY_ENTRY Policies;
}

struct RTL_CRITICAL_SECTION_DEBUG
{
    ushort     Type;
    ushort     CreatorBackTraceIndex;
    RTL_CRITICAL_SECTION* CriticalSection;
    LIST_ENTRY ProcessLocksList;
    uint       EntryCount;
    uint       ContentionCount;
    uint       Flags;
    ushort     CreatorBackTraceIndexHigh;
    ushort     SpareWORD;
}

struct RTL_CRITICAL_SECTION
{
    RTL_CRITICAL_SECTION_DEBUG* DebugInfo;
    int    LockCount;
    int    RecursionCount;
    HANDLE OwningThread;
    HANDLE LockSemaphore;
    size_t SpinCount;
}

struct RTL_SRWLOCK
{
    void* Ptr;
}

struct RTL_CONDITION_VARIABLE
{
    void* Ptr;
}

struct HEAP_OPTIMIZE_RESOURCES_INFORMATION
{
    uint Version;
    uint Flags;
}

struct SUPPORTED_OS_INFO
{
    ushort MajorVersion;
    ushort MinorVersion;
}

struct MAXVERSIONTESTED_INFO
{
    ulong MaxVersionTested;
}

struct EVENTLOGRECORD
{
    uint   Length;
    uint   Reserved;
    uint   RecordNumber;
    uint   TimeGenerated;
    uint   TimeWritten;
    uint   EventID;
    ushort EventType;
    ushort NumStrings;
    ushort EventCategory;
    ushort ReservedFlags;
    uint   ClosingRecordNumber;
    uint   StringOffset;
    uint   UserSidLength;
    uint   UserSidOffset;
    uint   DataLength;
    uint   DataOffset;
}

struct EVENTSFORLOGFILE
{
    uint           ulSize;
    ushort[256]    szLogicalLogFile;
    uint           ulNumRecords;
    EVENTLOGRECORD pEventLogRecords;
}

struct PACKEDEVENTINFO
{
    uint ulSize;
    uint ulNumEventsForLogFile;
    uint ulOffsets;
}

struct TAPE_ERASE
{
    uint  Type;
    ubyte Immediate;
}

struct TAPE_PREPARE
{
    uint  Operation;
    ubyte Immediate;
}

struct TAPE_WRITE_MARKS
{
    uint  Type;
    uint  Count;
    ubyte Immediate;
}

struct TAPE_GET_POSITION
{
    uint          Type;
    uint          Partition;
    LARGE_INTEGER Offset;
}

struct TAPE_SET_POSITION
{
    uint          Method;
    uint          Partition;
    LARGE_INTEGER Offset;
    ubyte         Immediate;
}

struct TAPE_GET_DRIVE_PARAMETERS
{
    ubyte ECC;
    ubyte Compression;
    ubyte DataPadding;
    ubyte ReportSetmarks;
    uint  DefaultBlockSize;
    uint  MaximumBlockSize;
    uint  MinimumBlockSize;
    uint  MaximumPartitionCount;
    uint  FeaturesLow;
    uint  FeaturesHigh;
    uint  EOTWarningZoneSize;
}

struct TAPE_SET_DRIVE_PARAMETERS
{
    ubyte ECC;
    ubyte Compression;
    ubyte DataPadding;
    ubyte ReportSetmarks;
    uint  EOTWarningZoneSize;
}

struct TAPE_GET_MEDIA_PARAMETERS
{
    LARGE_INTEGER Capacity;
    LARGE_INTEGER Remaining;
    uint          BlockSize;
    uint          PartitionCount;
    ubyte         WriteProtected;
}

struct TAPE_SET_MEDIA_PARAMETERS
{
    uint BlockSize;
}

struct TAPE_CREATE_PARTITION
{
    uint Method;
    uint Count;
    uint Size;
}

struct TAPE_WMI_OPERATIONS
{
    uint  Method;
    uint  DataBufferSize;
    void* DataBuffer;
}

struct TRANSACTION_BASIC_INFORMATION
{
    GUID TransactionId;
    uint State;
    uint Outcome;
}

struct TRANSACTIONMANAGER_BASIC_INFORMATION
{
    GUID          TmIdentity;
    LARGE_INTEGER VirtualClock;
}

struct TRANSACTIONMANAGER_LOG_INFORMATION
{
    GUID LogIdentity;
}

struct TRANSACTIONMANAGER_LOGPATH_INFORMATION
{
    uint      LogPathLength;
    ushort[1] LogPath;
}

struct TRANSACTIONMANAGER_RECOVERY_INFORMATION
{
    ulong LastRecoveredLsn;
}

struct TRANSACTIONMANAGER_OLDEST_INFORMATION
{
    GUID OldestTransactionGuid;
}

struct TRANSACTION_PROPERTIES_INFORMATION
{
    uint          IsolationLevel;
    uint          IsolationFlags;
    LARGE_INTEGER Timeout;
    uint          Outcome;
    uint          DescriptionLength;
    ushort[1]     Description;
}

struct TRANSACTION_BIND_INFORMATION
{
    HANDLE TmHandle;
}

struct TRANSACTION_ENLISTMENT_PAIR
{
    GUID EnlistmentId;
    GUID ResourceManagerId;
}

struct TRANSACTION_ENLISTMENTS_INFORMATION
{
    uint NumberOfEnlistments;
    TRANSACTION_ENLISTMENT_PAIR[1] EnlistmentPair;
}

struct TRANSACTION_SUPERIOR_ENLISTMENT_INFORMATION
{
    TRANSACTION_ENLISTMENT_PAIR SuperiorEnlistmentPair;
}

struct RESOURCEMANAGER_BASIC_INFORMATION
{
    GUID      ResourceManagerId;
    uint      DescriptionLength;
    ushort[1] Description;
}

struct RESOURCEMANAGER_COMPLETION_INFORMATION
{
    HANDLE IoCompletionPortHandle;
    size_t CompletionKey;
}

struct ENLISTMENT_BASIC_INFORMATION
{
    GUID EnlistmentId;
    GUID TransactionId;
    GUID ResourceManagerId;
}

struct ENLISTMENT_CRM_INFORMATION
{
    GUID CrmTransactionManagerId;
    GUID CrmResourceManagerId;
    GUID CrmEnlistmentId;
}

struct TRANSACTION_LIST_ENTRY
{
    GUID UOW;
}

struct TRANSACTION_LIST_INFORMATION
{
    uint NumberOfTransactions;
    TRANSACTION_LIST_ENTRY[1] TransactionInformation;
}

struct KTMOBJECT_CURSOR
{
    GUID    LastQuery;
    uint    ObjectIdCount;
    GUID[1] ObjectIds;
}

struct TP_CALLBACK_INSTANCE
{
}

struct TP_POOL
{
}

struct TP_POOL_STACK_INFORMATION
{
    size_t StackReserve;
    size_t StackCommit;
}

struct TP_CLEANUP_GROUP
{
}

struct TP_CALLBACK_ENVIRON_V3
{
    uint                 Version;
    PTP_POOL             Pool;
    ptrdiff_t            CleanupGroup;
    PTP_CLEANUP_GROUP_CANCEL_CALLBACK CleanupGroupCancelCallback;
    void*                RaceDll;
    ptrdiff_t            ActivationContext;
    PTP_SIMPLE_CALLBACK  FinalizationCallback;
    union u
    {
        uint Flags;
        struct s
        {
            uint _bitfield150;
        }
    }
    TP_CALLBACK_PRIORITY CallbackPriority;
    uint                 Size;
}

struct TP_WORK
{
}

struct TP_TIMER
{
}

struct TP_WAIT
{
}

struct TP_IO
{
}

struct TEB
{
}

struct HKEY__
{
    int unused;
}

struct HMETAFILE__
{
    int unused;
}

struct HINSTANCE__
{
    int unused;
}

struct HRGN__
{
    int unused;
}

struct HRSRC__
{
    int unused;
}

struct HSPRITE__
{
    int unused;
}

struct HLSURF__
{
    int unused;
}

struct HSTR__
{
    int unused;
}

struct HTASK__
{
    int unused;
}

struct HWINSTA__
{
    int unused;
}

struct HKL__
{
    int unused;
}

struct HWND__
{
    int unused;
}

struct HHOOK__
{
    int unused;
}

struct HACCEL__
{
    int unused;
}

struct HBITMAP__
{
    int unused;
}

struct HBRUSH__
{
    int unused;
}

struct HCOLORSPACE__
{
    int unused;
}

struct HDC__
{
    int unused;
}

struct HGLRC__
{
    int unused;
}

struct HDESK__
{
    int unused;
}

struct HENHMETAFILE__
{
    int unused;
}

struct HFONT__
{
    int unused;
}

struct HICON__
{
    int unused;
}

struct HMENU__
{
    int unused;
}

struct HPALETTE__
{
    int unused;
}

struct HPEN__
{
    int unused;
}

struct HWINEVENTHOOK__
{
    int unused;
}

struct HMONITOR__
{
    int unused;
}

struct HUMPD__
{
    int unused;
}

struct APP_LOCAL_DEVICE_ID
{
    ubyte[32] value;
}

struct DPI_AWARENESS_CONTEXT__
{
    int unused;
}

struct JOBOBJECT_IO_RATE_CONTROL_INFORMATION
{
    long          MaxIops;
    long          MaxBandwidth;
    long          ReservationIops;
    const(wchar)* VolumeName;
    uint          BaseIoSize;
    uint          ControlFlags;
}

struct PROCESSOR_NUMBER
{
    ushort Group;
    ubyte  Number;
    ubyte  Reserved;
}

struct GROUP_AFFINITY
{
    size_t    Mask;
    ushort    Group;
    ushort[3] Reserved;
}

struct SECURITY_ATTRIBUTES
{
    uint  nLength;
    void* lpSecurityDescriptor;
    BOOL  bInheritHandle;
}

struct OVERLAPPED
{
    size_t Internal;
    size_t InternalHigh;
    union
    {
        struct
        {
            uint Offset;
            uint OffsetHigh;
        }
        void* Pointer;
    }
    HANDLE hEvent;
}

struct PROCESS_HEAP_ENTRY
{
    void*  lpData;
    uint   cbData;
    ubyte  cbOverhead;
    ubyte  iRegionIndex;
    ushort wFlags;
    union
    {
        struct Block
        {
            HANDLE  hMem;
            uint[3] dwReserved;
        }
        struct Region
        {
            uint  dwCommittedSize;
            uint  dwUnCommittedSize;
            void* lpFirstBlock;
            void* lpLastBlock;
        }
    }
}

struct REASON_CONTEXT
{
    uint Version;
    uint Flags;
    union Reason
    {
        struct Detailed
        {
            ptrdiff_t LocalizedReasonModule;
            uint      LocalizedReasonId;
            uint      ReasonStringCount;
            ushort**  ReasonStrings;
        }
        const(wchar)* SimpleReasonString;
    }
}

struct HEAP_SUMMARY
{
    uint   cb;
    size_t cbAllocated;
    size_t cbCommitted;
    size_t cbReserved;
    size_t cbMaxReserve;
}

struct WIN32_MEMORY_RANGE_ENTRY
{
    void*  VirtualAddress;
    size_t NumberOfBytes;
}

struct WIN32_MEMORY_REGION_INFORMATION
{
    void*  AllocationBase;
    uint   AllocationProtect;
    union
    {
        uint Flags;
        struct
        {
            uint _bitfield151;
        }
    }
    size_t RegionSize;
    size_t CommitSize;
}

struct ENUMUILANG
{
    uint    NumOfEnumUILang;
    uint    SizeOfEnumUIBuffer;
    ushort* pEnumUIBuffer;
}

struct REDIRECTION_FUNCTION_DESCRIPTOR
{
    const(char)* DllName;
    const(char)* FunctionName;
    void*        RedirectionTarget;
}

struct REDIRECTION_DESCRIPTOR
{
    uint Version;
    uint FunctionCount;
    REDIRECTION_FUNCTION_DESCRIPTOR* Redirections;
}

struct COORD
{
    short X;
    short Y;
}

struct SMALL_RECT
{
    short Left;
    short Top;
    short Right;
    short Bottom;
}

struct KEY_EVENT_RECORD
{
    BOOL   bKeyDown;
    ushort wRepeatCount;
    ushort wVirtualKeyCode;
    ushort wVirtualScanCode;
    union uChar
    {
        ushort UnicodeChar;
        byte   AsciiChar;
    }
    uint   dwControlKeyState;
}

struct MOUSE_EVENT_RECORD
{
    COORD dwMousePosition;
    uint  dwButtonState;
    uint  dwControlKeyState;
    uint  dwEventFlags;
}

struct WINDOW_BUFFER_SIZE_RECORD
{
    COORD dwSize;
}

struct MENU_EVENT_RECORD
{
    uint dwCommandId;
}

struct FOCUS_EVENT_RECORD
{
    BOOL bSetFocus;
}

struct INPUT_RECORD
{
    ushort EventType;
    union Event
    {
        KEY_EVENT_RECORD   KeyEvent;
        MOUSE_EVENT_RECORD MouseEvent;
        WINDOW_BUFFER_SIZE_RECORD WindowBufferSizeEvent;
        MENU_EVENT_RECORD  MenuEvent;
        FOCUS_EVENT_RECORD FocusEvent;
    }
}

struct CHAR_INFO
{
    union Char
    {
        ushort UnicodeChar;
        byte   AsciiChar;
    }
    ushort Attributes;
}

struct CONSOLE_FONT_INFO
{
    uint  nFont;
    COORD dwFontSize;
}

struct CONSOLE_READCONSOLE_CONTROL
{
    uint nLength;
    uint nInitialChars;
    uint dwCtrlWakeupMask;
    uint dwControlKeyState;
}

struct CONSOLE_CURSOR_INFO
{
    uint dwSize;
    BOOL bVisible;
}

struct CONSOLE_SCREEN_BUFFER_INFO
{
    COORD      dwSize;
    COORD      dwCursorPosition;
    ushort     wAttributes;
    SMALL_RECT srWindow;
    COORD      dwMaximumWindowSize;
}

struct CONSOLE_SCREEN_BUFFER_INFOEX
{
    uint       cbSize;
    COORD      dwSize;
    COORD      dwCursorPosition;
    ushort     wAttributes;
    SMALL_RECT srWindow;
    COORD      dwMaximumWindowSize;
    ushort     wPopupAttributes;
    BOOL       bFullscreenSupported;
    uint[16]   ColorTable;
}

struct CONSOLE_FONT_INFOEX
{
    uint       cbSize;
    uint       nFont;
    COORD      dwFontSize;
    uint       FontFamily;
    uint       FontWeight;
    ushort[32] FaceName;
}

struct CONSOLE_SELECTION_INFO
{
    uint       dwFlags;
    COORD      dwSelectionAnchor;
    SMALL_RECT srSelection;
}

struct CONSOLE_HISTORY_INFO
{
    uint cbSize;
    uint HistoryBufferSize;
    uint NumberOfHistoryBuffers;
    uint dwFlags;
}

struct RPC_IMPORT_CONTEXT_P
{
    void*               LookupContext;
    void*               ProposedHandle;
    RPC_BINDING_VECTOR* Bindings;
}

struct RemHGLOBAL
{
    int      fNullHGlobal;
    uint     cbData;
    ubyte[1] data;
}

struct RemHMETAFILEPICT
{
    int      mm;
    int      xExt;
    int      yExt;
    uint     cbData;
    ubyte[1] data;
}

struct RemHENHMETAFILE
{
    uint     cbData;
    ubyte[1] data;
}

struct RemHBITMAP
{
    uint     cbData;
    ubyte[1] data;
}

struct RemHPALETTE
{
    uint     cbData;
    ubyte[1] data;
}

struct RemBRUSH
{
    uint     cbData;
    ubyte[1] data;
}

struct userCLIPFORMAT
{
    int fContext;
    union u
    {
        uint    dwValue;
        ushort* pwszName;
    }
}

struct GDI_NONREMOTE
{
    int fContext;
    union u
    {
        int         hInproc;
        DWORD_BLOB* hRemote;
    }
}

struct userHGLOBAL
{
    int fContext;
    union u
    {
        int                hInproc;
        FLAGGED_BYTE_BLOB* hRemote;
        long               hInproc64;
    }
}

struct userHMETAFILE
{
    int fContext;
    union u
    {
        int        hInproc;
        BYTE_BLOB* hRemote;
        long       hInproc64;
    }
}

struct remoteMETAFILEPICT
{
    int            mm;
    int            xExt;
    int            yExt;
    userHMETAFILE* hMF;
}

struct userHMETAFILEPICT
{
    int fContext;
    union u
    {
        int                 hInproc;
        remoteMETAFILEPICT* hRemote;
        long                hInproc64;
    }
}

struct userHENHMETAFILE
{
    int fContext;
    union u
    {
        int        hInproc;
        BYTE_BLOB* hRemote;
        long       hInproc64;
    }
}

struct userBITMAP
{
    int      bmType;
    int      bmWidth;
    int      bmHeight;
    int      bmWidthBytes;
    ushort   bmPlanes;
    ushort   bmBitsPixel;
    uint     cbSize;
    ubyte[1] pBuffer;
}

struct userHBITMAP
{
    int fContext;
    union u
    {
        int         hInproc;
        userBITMAP* hRemote;
        long        hInproc64;
    }
}

struct userHPALETTE
{
    int fContext;
    union u
    {
        int         hInproc;
        LOGPALETTE* hRemote;
        long        hInproc64;
    }
}

struct RemotableHandle
{
    int fContext;
    union u
    {
        int hInproc;
        int hRemote;
    }
}

union CY
{
    struct
    {
        uint Lo;
        int  Hi;
    }
    long int64;
}

struct DECIMAL
{
    ushort wReserved;
    union
    {
        struct
        {
            ubyte scale;
            ubyte sign;
        }
        ushort signscale;
    }
    uint   Hi32;
    union
    {
        struct
        {
            uint Lo32;
            uint Mid32;
        }
        ulong Lo64;
    }
}

struct BSTRBLOB
{
    uint   cbSize;
    ubyte* pData;
}

struct CLIPDATA
{
    uint   cbSize;
    int    ulClipFmt;
    ubyte* pClipData;
}

struct uCLSSPEC
{
    uint tyspec;
    union tagged_union
    {
        GUID    clsid;
        ushort* pFileExt;
        ushort* pMimeType;
        ushort* pProgId;
        ushort* pFileName;
        struct ByName
        {
            ushort* pPackageName;
            GUID    PolicyId;
        }
        struct ByObjectId
        {
            GUID ObjectId;
            GUID PolicyId;
        }
    }
}

struct STORAGE_HOTPLUG_INFO
{
    uint  Size;
    ubyte MediaRemovable;
    ubyte MediaHotplug;
    ubyte DeviceHotplug;
    ubyte WriteCacheEnableOverride;
}

struct STORAGE_DEVICE_NUMBER
{
    uint DeviceType;
    uint DeviceNumber;
    uint PartitionNumber;
}

struct STORAGE_DEVICE_NUMBERS
{
    uint Version;
    uint Size;
    uint NumberOfDevices;
    STORAGE_DEVICE_NUMBER[1] Devices;
}

struct STORAGE_DEVICE_NUMBER_EX
{
    uint Version;
    uint Size;
    uint Flags;
    uint DeviceType;
    uint DeviceNumber;
    GUID DeviceGuid;
    uint PartitionNumber;
}

struct STORAGE_BUS_RESET_REQUEST
{
    ubyte PathId;
}

struct STORAGE_BREAK_RESERVATION_REQUEST
{
    uint  Length;
    ubyte _unused;
    ubyte PathId;
    ubyte TargetId;
    ubyte Lun;
}

struct PREVENT_MEDIA_REMOVAL
{
    ubyte PreventMediaRemoval;
}

struct CLASS_MEDIA_CHANGE_CONTEXT
{
    uint MediaChangeCount;
    uint NewState;
}

struct TAPE_STATISTICS
{
    uint          Version;
    uint          Flags;
    LARGE_INTEGER RecoveredWrites;
    LARGE_INTEGER UnrecoveredWrites;
    LARGE_INTEGER RecoveredReads;
    LARGE_INTEGER UnrecoveredReads;
    ubyte         CompressionRatioReads;
    ubyte         CompressionRatioWrites;
}

struct TAPE_GET_STATISTICS
{
    uint Operation;
}

struct DEVICE_MEDIA_INFO
{
    union DeviceSpecific
    {
        struct DiskInfo
        {
            LARGE_INTEGER      Cylinders;
            STORAGE_MEDIA_TYPE MediaType;
            uint               TracksPerCylinder;
            uint               SectorsPerTrack;
            uint               BytesPerSector;
            uint               NumberMediaSides;
            uint               MediaCharacteristics;
        }
        struct RemovableDiskInfo
        {
            LARGE_INTEGER      Cylinders;
            STORAGE_MEDIA_TYPE MediaType;
            uint               TracksPerCylinder;
            uint               SectorsPerTrack;
            uint               BytesPerSector;
            uint               NumberMediaSides;
            uint               MediaCharacteristics;
        }
        struct TapeInfo
        {
            STORAGE_MEDIA_TYPE MediaType;
            uint               MediaCharacteristics;
            uint               CurrentBlockSize;
            STORAGE_BUS_TYPE   BusType;
            union BusSpecificData
            {
                struct ScsiInformation
                {
                    ubyte MediumType;
                    ubyte DensityCode;
                }
            }
        }
    }
}

struct GET_MEDIA_TYPES
{
    uint                 DeviceType;
    uint                 MediaInfoCount;
    DEVICE_MEDIA_INFO[1] MediaInfo;
}

struct STORAGE_PREDICT_FAILURE
{
    uint       PredictFailure;
    ubyte[512] VendorSpecific;
}

struct STORAGE_FAILURE_PREDICTION_CONFIG
{
    uint   Version;
    uint   Size;
    ubyte  Set;
    ubyte  Enabled;
    ushort Reserved;
}

struct STORAGE_PROPERTY_SET
{
    STORAGE_PROPERTY_ID PropertyId;
    STORAGE_SET_TYPE    SetType;
    ubyte[1]            AdditionalParameters;
}

struct STORAGE_IDENTIFIER
{
    STORAGE_IDENTIFIER_CODE_SET CodeSet;
    STORAGE_IDENTIFIER_TYPE Type;
    ushort   IdentifierSize;
    ushort   NextOffset;
    STORAGE_ASSOCIATION_TYPE Association;
    ubyte[1] Identifier;
}

struct STORAGE_LB_PROVISIONING_MAP_RESOURCES
{
    uint     Size;
    uint     Version;
    ubyte    _bitfield1;
    ubyte[3] Reserved1;
    ubyte    _bitfield2;
    ubyte[3] Reserved3;
    ulong    AvailableMappingResources;
    ulong    UsedMappingResources;
}

struct STORAGE_RPMB_DESCRIPTOR
{
    uint Version;
    uint Size;
    uint SizeInBytes;
    uint MaxReliableWriteSizeInBytes;
    STORAGE_RPMB_FRAME_TYPE FrameFormat;
}

struct STORAGE_CRYPTO_CAPABILITY
{
    uint Version;
    uint Size;
    uint CryptoCapabilityIndex;
    STORAGE_CRYPTO_ALGORITHM_ID AlgorithmId;
    STORAGE_CRYPTO_KEY_SIZE KeySize;
    uint DataUnitSizeBitmask;
}

struct STORAGE_CRYPTO_DESCRIPTOR
{
    uint Version;
    uint Size;
    uint NumKeysSupported;
    uint NumCryptoCapabilities;
    STORAGE_CRYPTO_CAPABILITY[1] CryptoCapabilities;
}

struct STORAGE_TIER
{
    GUID               Id;
    ushort[256]        Name;
    ushort[256]        Description;
    ulong              Flags;
    ulong              ProvisionedCapacity;
    STORAGE_TIER_MEDIA_TYPE MediaType;
    STORAGE_TIER_CLASS Class;
}

struct STORAGE_DEVICE_TIERING_DESCRIPTOR
{
    uint            Version;
    uint            Size;
    uint            Flags;
    uint            TotalNumberOfTiers;
    uint            NumberOfTiersReturned;
    STORAGE_TIER[1] Tiers;
}

struct STORAGE_DEVICE_FAULT_DOMAIN_DESCRIPTOR
{
    uint    Version;
    uint    Size;
    uint    NumberOfFaultDomains;
    GUID[1] FaultDomainIds;
}

struct STORAGE_PROTOCOL_SPECIFIC_DATA_EXT
{
    STORAGE_PROTOCOL_TYPE ProtocolType;
    uint    DataType;
    uint    ProtocolDataValue;
    uint    ProtocolDataSubValue;
    uint    ProtocolDataOffset;
    uint    ProtocolDataLength;
    uint    FixedProtocolReturnData;
    uint    ProtocolDataSubValue2;
    uint    ProtocolDataSubValue3;
    uint    ProtocolDataSubValue4;
    uint    ProtocolDataSubValue5;
    uint[5] Reserved;
}

struct STORAGE_PROTOCOL_DATA_DESCRIPTOR_EXT
{
    uint Version;
    uint Size;
    STORAGE_PROTOCOL_SPECIFIC_DATA_EXT ProtocolSpecificData;
}

struct STORAGE_OPERATIONAL_REASON
{
    uint Version;
    uint Size;
    STORAGE_OPERATIONAL_STATUS_REASON Reason;
    union RawBytes
    {
        struct ScsiSenseKey
        {
            ubyte SenseKey;
            ubyte ASC;
            ubyte ASCQ;
            ubyte Reserved;
        }
        struct NVDIMM_N
        {
            ubyte    CriticalHealth;
            ubyte[2] ModuleHealth;
            ubyte    ErrorThresholdStatus;
        }
        uint AsUlong;
    }
}

struct STORAGE_DEVICE_MANAGEMENT_STATUS
{
    uint Version;
    uint Size;
    STORAGE_DISK_HEALTH_STATUS Health;
    uint NumberOfOperationalStatus;
    uint NumberOfAdditionalReasons;
    STORAGE_DISK_OPERATIONAL_STATUS[16] OperationalStatus;
    STORAGE_OPERATIONAL_REASON[1] AdditionalReasons;
}

struct STORAGE_ZONE_GROUP
{
    uint               ZoneCount;
    STORAGE_ZONE_TYPES ZoneType;
    ulong              ZoneSize;
}

struct STORAGE_ZONED_DEVICE_DESCRIPTOR
{
    uint Version;
    uint Size;
    STORAGE_ZONED_DEVICE_TYPES DeviceType;
    uint ZoneCount;
    union ZoneAttributes
    {
        struct SequentialRequiredZone
        {
            uint     MaxOpenZoneCount;
            ubyte    UnrestrictedRead;
            ubyte[3] Reserved;
        }
        struct SequentialPreferredZone
        {
            uint OptimalOpenZoneCount;
            uint Reserved;
        }
    }
    uint ZoneGroupCount;
    STORAGE_ZONE_GROUP[1] ZoneGroup;
}

struct DEVICE_LOCATION
{
    uint Socket;
    uint Slot;
    uint Adapter;
    uint Port;
    union
    {
        struct
        {
            uint Channel;
            uint Device;
        }
        struct
        {
            uint Target;
            uint Lun;
        }
    }
}

struct STORAGE_DEVICE_LOCATION_DESCRIPTOR
{
    uint            Version;
    uint            Size;
    DEVICE_LOCATION Location;
    uint            StringOffset;
}

struct STORAGE_DEVICE_NUMA_PROPERTY
{
    uint Version;
    uint Size;
    uint NumaNode;
}

struct STORAGE_DEVICE_UNSAFE_SHUTDOWN_COUNT
{
    uint Version;
    uint Size;
    uint UnsafeShutdownCount;
}

struct STORAGE_HW_ENDURANCE_INFO
{
    uint      ValidFields;
    uint      GroupId;
    struct Flags
    {
        uint _bitfield152;
    }
    uint      LifePercentage;
    ubyte[16] BytesReadCount;
    ubyte[16] ByteWriteCount;
}

struct STORAGE_HW_ENDURANCE_DATA_DESCRIPTOR
{
    uint Version;
    uint Size;
    STORAGE_HW_ENDURANCE_INFO EnduranceInfo;
}

struct DEVICE_DATA_SET_RANGE
{
    long  StartingOffset;
    ulong LengthInBytes;
}

struct DEVICE_MANAGE_DATA_SET_ATTRIBUTES
{
    uint Size;
    uint Action;
    uint Flags;
    uint ParameterBlockOffset;
    uint ParameterBlockLength;
    uint DataSetRangesOffset;
    uint DataSetRangesLength;
}

struct DEVICE_MANAGE_DATA_SET_ATTRIBUTES_OUTPUT
{
    uint Size;
    uint Action;
    uint Flags;
    uint OperationStatus;
    uint ExtendedError;
    uint TargetDetailedError;
    uint ReservedStatus;
    uint OutputBlockOffset;
    uint OutputBlockLength;
}

struct DEVICE_DSM_DEFINITION
{
    uint  Action;
    ubyte SingleRange;
    uint  ParameterBlockAlignment;
    uint  ParameterBlockLength;
    ubyte HasOutput;
    uint  OutputBlockAlignment;
    uint  OutputBlockLength;
}

struct DEVICE_DSM_NOTIFICATION_PARAMETERS
{
    uint    Size;
    uint    Flags;
    uint    NumFileTypeIDs;
    GUID[1] FileTypeID;
}

struct STORAGE_OFFLOAD_TOKEN
{
    ubyte[4] TokenType;
    ubyte[2] Reserved;
    ubyte[2] TokenIdLength;
    union
    {
        struct StorageOffloadZeroDataToken
        {
            ubyte[504] Reserved2;
        }
        ubyte[504] Token;
    }
}

struct DEVICE_DSM_OFFLOAD_READ_PARAMETERS
{
    uint    Flags;
    uint    TimeToLive;
    uint[2] Reserved;
}

struct STORAGE_OFFLOAD_READ_OUTPUT
{
    uint  OffloadReadFlags;
    uint  Reserved;
    ulong LengthProtected;
    uint  TokenLength;
    STORAGE_OFFLOAD_TOKEN Token;
}

struct DEVICE_DSM_OFFLOAD_WRITE_PARAMETERS
{
    uint  Flags;
    uint  Reserved;
    ulong TokenOffset;
    STORAGE_OFFLOAD_TOKEN Token;
}

struct STORAGE_OFFLOAD_WRITE_OUTPUT
{
    uint  OffloadWriteFlags;
    uint  Reserved;
    ulong LengthCopied;
}

struct DEVICE_DATA_SET_LBP_STATE_PARAMETERS
{
    uint Version;
    uint Size;
    uint Flags;
    uint OutputVersion;
}

struct DEVICE_DATA_SET_LB_PROVISIONING_STATE
{
    uint    Size;
    uint    Version;
    ulong   SlabSizeInBytes;
    uint    SlabOffsetDeltaInBytes;
    uint    SlabAllocationBitMapBitCount;
    uint    SlabAllocationBitMapLength;
    uint[1] SlabAllocationBitMap;
}

struct DEVICE_DATA_SET_LB_PROVISIONING_STATE_V2
{
    uint    Size;
    uint    Version;
    ulong   SlabSizeInBytes;
    ulong   SlabOffsetDeltaInBytes;
    uint    SlabAllocationBitMapBitCount;
    uint    SlabAllocationBitMapLength;
    uint[1] SlabAllocationBitMap;
}

struct DEVICE_DATA_SET_REPAIR_PARAMETERS
{
    uint    NumberOfRepairCopies;
    uint    SourceCopy;
    uint[1] RepairCopies;
}

struct DEVICE_DATA_SET_REPAIR_OUTPUT
{
    DEVICE_DATA_SET_RANGE ParityExtent;
}

struct DEVICE_DATA_SET_SCRUB_OUTPUT
{
    ulong BytesProcessed;
    ulong BytesRepaired;
    ulong BytesFailed;
}

struct DEVICE_DATA_SET_SCRUB_EX_OUTPUT
{
    ulong BytesProcessed;
    ulong BytesRepaired;
    ulong BytesFailed;
    DEVICE_DATA_SET_RANGE ParityExtent;
}

struct DEVICE_DSM_TIERING_QUERY_INPUT
{
    uint    Version;
    uint    Size;
    uint    Flags;
    uint    NumberOfTierIds;
    GUID[1] TierIds;
}

struct STORAGE_TIER_REGION
{
    GUID  TierId;
    ulong Offset;
    ulong Length;
}

struct DEVICE_DSM_TIERING_QUERY_OUTPUT
{
    uint  Version;
    uint  Size;
    uint  Flags;
    uint  Reserved;
    ulong Alignment;
    uint  TotalNumberOfRegions;
    uint  NumberOfRegionsReturned;
    STORAGE_TIER_REGION[1] Regions;
}

struct DEVICE_DSM_NVCACHE_CHANGE_PRIORITY_PARAMETERS
{
    uint     Size;
    ubyte    TargetPriority;
    ubyte[3] Reserved;
}

struct DEVICE_DATA_SET_TOPOLOGY_ID_QUERY_OUTPUT
{
    ulong     TopologyRangeBytes;
    ubyte[16] TopologyId;
}

struct DEVICE_STORAGE_ADDRESS_RANGE
{
    long  StartAddress;
    ulong LengthInBytes;
}

struct DEVICE_DSM_PHYSICAL_ADDRESSES_OUTPUT
{
    uint Version;
    uint Flags;
    uint TotalNumberOfRanges;
    uint NumberOfRangesReturned;
    DEVICE_STORAGE_ADDRESS_RANGE[1] Ranges;
}

struct DEVICE_DSM_REPORT_ZONES_PARAMETERS
{
    uint     Size;
    ubyte    ReportOption;
    ubyte    Partial;
    ubyte[2] Reserved;
}

struct STORAGE_ZONE_DESCRIPTOR
{
    uint               Size;
    STORAGE_ZONE_TYPES ZoneType;
    STORAGE_ZONE_CONDITION ZoneCondition;
    ubyte              ResetWritePointerRecommend;
    ubyte[3]           Reserved0;
    ulong              ZoneSize;
    ulong              WritePointerOffset;
}

struct DEVICE_DSM_REPORT_ZONES_DATA
{
    uint Size;
    uint ZoneCount;
    STORAGE_ZONES_ATTRIBUTES Attributes;
    uint Reserved0;
    STORAGE_ZONE_DESCRIPTOR[1] ZoneDescriptors;
}

struct DEVICE_STORAGE_RANGE_ATTRIBUTES
{
    ulong LengthInBytes;
    union
    {
        uint AllFlags;
        struct
        {
            uint _bitfield153;
        }
    }
    uint  Reserved;
}

struct DEVICE_DSM_RANGE_ERROR_INFO
{
    uint Version;
    uint Flags;
    uint TotalNumberOfRanges;
    uint NumberOfRangesReturned;
    DEVICE_STORAGE_RANGE_ATTRIBUTES[1] Ranges;
}

struct DEVICE_DSM_LOST_QUERY_PARAMETERS
{
    uint  Version;
    ulong Granularity;
}

struct DEVICE_DSM_LOST_QUERY_OUTPUT
{
    uint    Version;
    uint    Size;
    ulong   Alignment;
    uint    NumberOfBits;
    uint[1] BitMap;
}

struct DEVICE_DSM_FREE_SPACE_OUTPUT
{
    uint  Version;
    ulong FreeSpace;
}

struct DEVICE_DSM_CONVERSION_OUTPUT
{
    uint Version;
    GUID Source;
}

struct STORAGE_GET_BC_PROPERTIES_OUTPUT
{
    uint  MaximumRequestsPerPeriod;
    uint  MinimumPeriod;
    ulong MaximumRequestSize;
    uint  EstimatedTimePerRequest;
    uint  NumOutStandingRequests;
    ulong RequestSize;
}

struct STORAGE_ALLOCATE_BC_STREAM_INPUT
{
    uint     Version;
    uint     RequestsPerPeriod;
    uint     Period;
    ubyte    RetryFailures;
    ubyte    Discardable;
    ubyte[2] Reserved1;
    uint     AccessType;
    uint     AccessMode;
}

struct STORAGE_ALLOCATE_BC_STREAM_OUTPUT
{
    ulong RequestSize;
    uint  NumOutStandingRequests;
}

struct STORAGE_PRIORITY_HINT_SUPPORT
{
    uint SupportFlags;
}

struct STORAGE_DIAGNOSTIC_REQUEST
{
    uint Version;
    uint Size;
    uint Reserved;
    STORAGE_DIAGNOSTIC_TARGET_TYPE TargetType;
    STORAGE_DIAGNOSTIC_LEVEL Level;
}

struct STORAGE_DIAGNOSTIC_DATA
{
    uint     Version;
    uint     Size;
    GUID     ProviderId;
    uint     BufferSize;
    uint     Reserved;
    ubyte[1] DiagnosticDataBuffer;
}

struct PHYSICAL_ELEMENT_STATUS_REQUEST
{
    uint     Version;
    uint     Size;
    uint     StartingElement;
    ubyte    Filter;
    ubyte    ReportType;
    ubyte[2] Reserved;
}

struct PHYSICAL_ELEMENT_STATUS_DESCRIPTOR
{
    uint     Version;
    uint     Size;
    uint     ElementIdentifier;
    ubyte    PhysicalElementType;
    ubyte    PhysicalElementHealth;
    ubyte[2] Reserved1;
    ulong    AssociatedCapacity;
    uint[4]  Reserved2;
}

struct PHYSICAL_ELEMENT_STATUS
{
    uint Version;
    uint Size;
    uint DescriptorCount;
    uint ReturnedDescriptorCount;
    uint ElementIdentifierBeingDepoped;
    uint Reserved;
    PHYSICAL_ELEMENT_STATUS_DESCRIPTOR[1] Descriptors;
}

struct REMOVE_ELEMENT_AND_TRUNCATE_REQUEST
{
    uint  Version;
    uint  Size;
    ulong RequestCapacity;
    uint  ElementIdentifier;
    uint  Reserved;
}

struct GET_DEVICE_INTERNAL_STATUS_DATA_REQUEST
{
    uint Version;
    uint Size;
    DEVICE_INTERNAL_STATUS_DATA_REQUEST_TYPE RequestDataType;
    DEVICE_INTERNAL_STATUS_DATA_SET RequestDataSet;
}

struct DEVICE_INTERNAL_STATUS_DATA
{
    uint       Version;
    uint       Size;
    ulong      T10VendorId;
    uint       DataSet1Length;
    uint       DataSet2Length;
    uint       DataSet3Length;
    uint       DataSet4Length;
    ubyte      StatusDataVersion;
    ubyte[3]   Reserved;
    ubyte[128] ReasonIdentifier;
    uint       StatusDataLength;
    ubyte[1]   StatusData;
}

struct STORAGE_MEDIA_SERIAL_NUMBER_DATA
{
    ushort   Reserved;
    ushort   SerialNumberLength;
    ubyte[1] SerialNumber;
}

struct STORAGE_READ_CAPACITY
{
    uint          Version;
    uint          Size;
    uint          BlockLength;
    LARGE_INTEGER NumberOfBlocks;
    LARGE_INTEGER DiskLength;
}

struct PERSISTENT_RESERVE_COMMAND
{
    uint Version;
    uint Size;
    union
    {
        struct PR_IN
        {
            ubyte  _bitfield154;
            ushort AllocationLength;
        }
        struct PR_OUT
        {
            ubyte    _bitfield1;
            ubyte    _bitfield2;
            ubyte[1] ParameterList;
        }
    }
}

struct DEVICEDUMP_SUBSECTION_POINTER
{
align (1):
    uint dwSize;
    uint dwFlags;
    uint dwOffset;
}

struct DEVICEDUMP_STRUCTURE_VERSION
{
align (1):
    uint dwSignature;
    uint dwVersion;
    uint dwSize;
}

struct DEVICEDUMP_SECTION_HEADER
{
align (1):
    GUID       guidDeviceDataId;
    ubyte[16]  sOrganizationID;
    uint       dwFirmwareRevision;
    ubyte[32]  sModelNumber;
    ubyte[32]  szDeviceManufacturingID;
    uint       dwFlags;
    uint       bRestrictedPrivateDataVersion;
    uint       dwFirmwareIssueId;
    ubyte[132] szIssueDescriptionString;
}

struct GP_LOG_PAGE_DESCRIPTOR
{
align (1):
    ushort LogAddress;
    ushort LogSectors;
}

struct DEVICEDUMP_PUBLIC_SUBSECTION
{
align (1):
    uint     dwFlags;
    GP_LOG_PAGE_DESCRIPTOR[16] GPLogTable;
    byte[16] szDescription;
    ubyte[1] bData;
}

struct DEVICEDUMP_RESTRICTED_SUBSECTION
{
    ubyte[1] bData;
}

struct DEVICEDUMP_PRIVATE_SUBSECTION
{
align (1):
    uint     dwFlags;
    GP_LOG_PAGE_DESCRIPTOR GPLogId;
    ubyte[1] bData;
}

struct DEVICEDUMP_STORAGEDEVICE_DATA
{
align (1):
    DEVICEDUMP_STRUCTURE_VERSION Descriptor;
    DEVICEDUMP_SECTION_HEADER SectionHeader;
    uint dwBufferSize;
    uint dwReasonForCollection;
    DEVICEDUMP_SUBSECTION_POINTER PublicData;
    DEVICEDUMP_SUBSECTION_POINTER RestrictedData;
    DEVICEDUMP_SUBSECTION_POINTER PrivateData;
}

struct DEVICEDUMP_STORAGESTACK_PUBLIC_STATE_RECORD
{
align (1):
    ubyte[16] Cdb;
    ubyte[16] Command;
    ulong     StartTime;
    ulong     EndTime;
    uint      OperationStatus;
    uint      OperationError;
    union StackSpecific
    {
        struct ExternalStack
        {
        align (1):
            uint dwReserved;
        }
        struct AtaPort
        {
        align (1):
            uint dwAtaPortSpecific;
        }
        struct StorPort
        {
        align (1):
            uint SrbTag;
        }
    }
}

struct DEVICEDUMP_STORAGESTACK_PUBLIC_DUMP
{
align (1):
    DEVICEDUMP_STRUCTURE_VERSION Descriptor;
    uint      dwReasonForCollection;
    ubyte[16] cDriverName;
    uint      uiNumRecords;
    DEVICEDUMP_STORAGESTACK_PUBLIC_STATE_RECORD[1] RecordArray;
}

struct STORAGE_IDLE_POWER
{
    uint Version;
    uint Size;
    uint _bitfield155;
    uint D3IdleTimeout;
}

struct STORAGE_IDLE_POWERUP_REASON
{
    uint Version;
    uint Size;
    STORAGE_POWERUP_REASON_TYPE PowerupReason;
}

struct STORAGE_RPMB_DATA_FRAME
{
    ubyte[196] Stuff;
    ubyte[32]  KeyOrMAC;
    ubyte[256] Data;
    ubyte[16]  Nonce;
    ubyte[4]   WriteCounter;
    ubyte[2]   Address;
    ubyte[2]   BlockCount;
    ubyte[2]   OperationResult;
    ubyte[2]   RequestOrResponseType;
}

struct STORAGE_EVENT_NOTIFICATION
{
    uint  Version;
    uint  Size;
    ulong Events;
}

struct STORAGE_COUNTER
{
    STORAGE_COUNTER_TYPE Type;
    union Value
    {
        struct ManufactureDate
        {
            uint Week;
            uint Year;
        }
        ulong AsUlonglong;
    }
}

struct STORAGE_COUNTERS
{
    uint               Version;
    uint               Size;
    uint               NumberOfCounters;
    STORAGE_COUNTER[1] Counters;
}

struct STORAGE_HW_FIRMWARE_INFO_QUERY
{
    uint Version;
    uint Size;
    uint Flags;
    uint Reserved;
}

struct STORAGE_HW_FIRMWARE_SLOT_INFO
{
    uint      Version;
    uint      Size;
    ubyte     SlotNumber;
    ubyte     _bitfield156;
    ubyte[6]  Reserved1;
    ubyte[16] Revision;
}

struct STORAGE_HW_FIRMWARE_INFO
{
    uint     Version;
    uint     Size;
    ubyte    _bitfield157;
    ubyte    SlotCount;
    ubyte    ActiveSlot;
    ubyte    PendingActivateSlot;
    ubyte    FirmwareShared;
    ubyte[3] Reserved;
    uint     ImagePayloadAlignment;
    uint     ImagePayloadMaxSize;
    STORAGE_HW_FIRMWARE_SLOT_INFO[1] Slot;
}

struct STORAGE_HW_FIRMWARE_DOWNLOAD_V2
{
    uint     Version;
    uint     Size;
    uint     Flags;
    ubyte    Slot;
    ubyte[3] Reserved;
    ulong    Offset;
    ulong    BufferSize;
    uint     ImageSize;
    uint     Reserved2;
    ubyte[1] ImageBuffer;
}

struct STORAGE_ATTRIBUTE_MGMT
{
    uint Version;
    uint Size;
    STORAGE_ATTRIBUTE_MGMT_ACTION Action;
    uint Attribute;
}

struct SCM_PD_HEALTH_NOTIFICATION_DATA
{
    GUID DeviceGuid;
}

struct SCM_LOGICAL_DEVICE_INSTANCE
{
    uint        Version;
    uint        Size;
    GUID        DeviceGuid;
    ushort[256] SymbolicLink;
}

struct SCM_LOGICAL_DEVICES
{
    uint Version;
    uint Size;
    uint DeviceCount;
    SCM_LOGICAL_DEVICE_INSTANCE[1] Devices;
}

struct SCM_PHYSICAL_DEVICE_INSTANCE
{
    uint        Version;
    uint        Size;
    uint        NfitHandle;
    ushort[256] SymbolicLink;
}

struct SCM_PHYSICAL_DEVICES
{
    uint Version;
    uint Size;
    uint DeviceCount;
    SCM_PHYSICAL_DEVICE_INSTANCE[1] Devices;
}

struct SCM_REGION
{
    uint  Version;
    uint  Size;
    uint  Flags;
    uint  NfitHandle;
    GUID  LogicalDeviceGuid;
    GUID  AddressRangeType;
    uint  AssociatedId;
    ulong Length;
    ulong StartingDPA;
    ulong BaseSPA;
    ulong SPAOffset;
    ulong RegionOffset;
}

struct SCM_REGIONS
{
    uint          Version;
    uint          Size;
    uint          RegionCount;
    SCM_REGION[1] Regions;
}

struct SCM_INTERLEAVED_PD_INFO
{
    uint DeviceHandle;
    GUID DeviceGuid;
}

struct SCM_LD_INTERLEAVE_SET_INFO
{
    uint Version;
    uint Size;
    uint InterleaveSetSize;
    SCM_INTERLEAVED_PD_INFO[1] InterleaveSet;
}

struct SCM_PD_PROPERTY_QUERY
{
    uint               Version;
    uint               Size;
    SCM_PD_PROPERTY_ID PropertyId;
    SCM_PD_QUERY_TYPE  QueryType;
    ubyte[1]           AdditionalParameters;
}

struct SCM_PD_DESCRIPTOR_HEADER
{
    uint Version;
    uint Size;
}

struct SCM_PD_DEVICE_HANDLE
{
    uint Version;
    uint Size;
    GUID DeviceGuid;
    uint DeviceHandle;
}

struct SCM_PD_DEVICE_INFO
{
    uint      Version;
    uint      Size;
    GUID      DeviceGuid;
    uint      UnsafeShutdownCount;
    ulong     PersistentMemorySizeInBytes;
    ulong     VolatileMemorySizeInBytes;
    ulong     TotalMemorySizeInBytes;
    uint      SlotNumber;
    uint      DeviceHandle;
    ushort    PhysicalId;
    ubyte     NumberOfFormatInterfaceCodes;
    ushort[8] FormatInterfaceCodes;
    uint      VendorId;
    uint      ProductId;
    uint      SubsystemDeviceId;
    uint      SubsystemVendorId;
    ubyte     ManufacturingLocation;
    ubyte     ManufacturingWeek;
    ubyte     ManufacturingYear;
    uint      SerialNumber4Byte;
    uint      SerialNumberLengthInChars;
    byte[1]   SerialNumber;
}

struct SCM_PD_DEVICE_SPECIFIC_PROPERTY
{
    ushort[128] Name;
    long        Value;
}

struct SCM_PD_DEVICE_SPECIFIC_INFO
{
    uint Version;
    uint Size;
    uint NumberOfProperties;
    SCM_PD_DEVICE_SPECIFIC_PROPERTY[1] DeviceSpecificProperties;
}

struct SCM_PD_FIRMWARE_SLOT_INFO
{
    uint      Version;
    uint      Size;
    ubyte     SlotNumber;
    ubyte     _bitfield158;
    ubyte[6]  Reserved1;
    ubyte[32] Revision;
}

struct SCM_PD_FIRMWARE_INFO
{
    uint  Version;
    uint  Size;
    ubyte ActiveSlot;
    ubyte NextActiveSlot;
    ubyte SlotCount;
    SCM_PD_FIRMWARE_SLOT_INFO[1] Slots;
}

struct SCM_PD_MANAGEMENT_STATUS
{
    uint                 Version;
    uint                 Size;
    SCM_PD_HEALTH_STATUS Health;
    uint                 NumberOfOperationalStatus;
    uint                 NumberOfAdditionalReasons;
    SCM_PD_OPERATIONAL_STATUS[16] OperationalStatus;
    SCM_PD_OPERATIONAL_STATUS_REASON[1] AdditionalReasons;
}

struct SCM_PD_LOCATION_STRING
{
    uint      Version;
    uint      Size;
    ushort[1] Location;
}

struct SCM_PD_FIRMWARE_DOWNLOAD
{
    uint     Version;
    uint     Size;
    uint     Flags;
    ubyte    Slot;
    ubyte[3] Reserved;
    ulong    Offset;
    uint     FirmwareImageSizeInBytes;
    ubyte[1] FirmwareImage;
}

struct SCM_PD_FIRMWARE_ACTIVATE
{
    uint  Version;
    uint  Size;
    uint  Flags;
    ubyte Slot;
}

struct SCM_PD_PASSTHROUGH_INPUT
{
    uint     Version;
    uint     Size;
    GUID     ProtocolGuid;
    uint     DataSize;
    ubyte[1] Data;
}

struct SCM_PD_PASSTHROUGH_OUTPUT
{
    uint     Version;
    uint     Size;
    GUID     ProtocolGuid;
    uint     DataSize;
    ubyte[1] Data;
}

struct SCM_PD_PASSTHROUGH_INVDIMM_INPUT
{
    uint     Opcode;
    uint     OpcodeParametersLength;
    ubyte[1] OpcodeParameters;
}

struct SCM_PD_PASSTHROUGH_INVDIMM_OUTPUT
{
    ushort   GeneralStatus;
    ushort   ExtendedStatus;
    uint     OutputDataLength;
    ubyte[1] OutputData;
}

struct SCM_PD_REINITIALIZE_MEDIA_INPUT
{
    uint Version;
    uint Size;
    struct Options
    {
        uint _bitfield159;
    }
}

struct SCM_PD_REINITIALIZE_MEDIA_OUTPUT
{
    uint Version;
    uint Size;
    SCM_PD_MEDIA_REINITIALIZATION_STATUS Status;
}

struct SET_PARTITION_INFORMATION_EX
{
    PARTITION_STYLE PartitionStyle;
    union
    {
        SET_PARTITION_INFORMATION Mbr;
        PARTITION_INFORMATION_GPT Gpt;
    }
}

struct DISK_CONTROLLER_NUMBER
{
    uint ControllerNumber;
    uint DiskNumber;
}

struct HISTOGRAM_BUCKET
{
    uint Reads;
    uint Writes;
}

struct DISK_HISTOGRAM
{
    LARGE_INTEGER     DiskSize;
    LARGE_INTEGER     Start;
    LARGE_INTEGER     End;
    LARGE_INTEGER     Average;
    LARGE_INTEGER     AverageRead;
    LARGE_INTEGER     AverageWrite;
    uint              Granularity;
    uint              Size;
    uint              ReadCount;
    uint              WriteCount;
    HISTOGRAM_BUCKET* Histogram;
}

struct DISK_RECORD
{
    LARGE_INTEGER ByteOffset;
    LARGE_INTEGER StartTime;
    LARGE_INTEGER EndTime;
    void*         VirtualAddress;
    uint          NumberOfBytes;
    ubyte         DeviceNumber;
    ubyte         ReadRequest;
}

struct DISK_LOGGING
{
    ubyte Function;
    void* BufferAddress;
    uint  BufferSize;
}

struct BIN_RANGE
{
    LARGE_INTEGER StartValue;
    LARGE_INTEGER Length;
}

struct PERF_BIN
{
    uint         NumberOfBins;
    uint         TypeOfBin;
    BIN_RANGE[1] BinsRanges;
}

struct BIN_COUNT
{
    BIN_RANGE BinRange;
    uint      BinCount;
}

struct BIN_RESULTS
{
    uint         NumberOfBins;
    BIN_COUNT[1] BinCounts;
}

struct GETVERSIONINPARAMS
{
align (1):
    ubyte   bVersion;
    ubyte   bRevision;
    ubyte   bReserved;
    ubyte   bIDEDeviceMap;
    uint    fCapabilities;
    uint[4] dwReserved;
}

struct IDEREGS
{
    ubyte bFeaturesReg;
    ubyte bSectorCountReg;
    ubyte bSectorNumberReg;
    ubyte bCylLowReg;
    ubyte bCylHighReg;
    ubyte bDriveHeadReg;
    ubyte bCommandReg;
    ubyte bReserved;
}

struct SENDCMDINPARAMS
{
align (1):
    uint     cBufferSize;
    IDEREGS  irDriveRegs;
    ubyte    bDriveNumber;
    ubyte[3] bReserved;
    uint[4]  dwReserved;
    ubyte[1] bBuffer;
}

struct DRIVERSTATUS
{
align (1):
    ubyte    bDriverError;
    ubyte    bIDEError;
    ubyte[2] bReserved;
    uint[2]  dwReserved;
}

struct SENDCMDOUTPARAMS
{
align (1):
    uint         cBufferSize;
    DRIVERSTATUS DriverStatus;
    ubyte[1]     bBuffer;
}

struct CHANGER_ELEMENT
{
    ELEMENT_TYPE ElementType;
    uint         ElementAddress;
}

struct CHANGER_ELEMENT_LIST
{
    CHANGER_ELEMENT Element;
    uint            NumberOfElements;
}

struct GET_CHANGER_PARAMETERS
{
    uint     Size;
    ushort   NumberTransportElements;
    ushort   NumberStorageElements;
    ushort   NumberCleanerSlots;
    ushort   NumberIEElements;
    ushort   NumberDataTransferElements;
    ushort   NumberOfDoors;
    ushort   FirstSlotNumber;
    ushort   FirstDriveNumber;
    ushort   FirstTransportNumber;
    ushort   FirstIEPortNumber;
    ushort   FirstCleanerSlotAddress;
    ushort   MagazineSize;
    uint     DriveCleanTimeout;
    uint     Features0;
    uint     Features1;
    ubyte    MoveFromTransport;
    ubyte    MoveFromSlot;
    ubyte    MoveFromIePort;
    ubyte    MoveFromDrive;
    ubyte    ExchangeFromTransport;
    ubyte    ExchangeFromSlot;
    ubyte    ExchangeFromIePort;
    ubyte    ExchangeFromDrive;
    ubyte    LockUnlockCapabilities;
    ubyte    PositionCapabilities;
    ubyte[2] Reserved1;
    uint[2]  Reserved2;
}

struct CHANGER_PRODUCT_DATA
{
    ubyte[8]  VendorId;
    ubyte[16] ProductId;
    ubyte[4]  Revision;
    ubyte[32] SerialNumber;
    ubyte     DeviceType;
}

struct CHANGER_SET_ACCESS
{
    CHANGER_ELEMENT Element;
    uint            Control;
}

struct CHANGER_READ_ELEMENT_STATUS
{
    CHANGER_ELEMENT_LIST ElementList;
    ubyte                VolumeTagInfo;
}

struct CHANGER_ELEMENT_STATUS
{
    CHANGER_ELEMENT Element;
    CHANGER_ELEMENT SrcElementAddress;
    uint            Flags;
    uint            ExceptionCode;
    ubyte           TargetId;
    ubyte           Lun;
    ushort          Reserved;
    ubyte[36]       PrimaryVolumeID;
    ubyte[36]       AlternateVolumeID;
}

struct CHANGER_ELEMENT_STATUS_EX
{
    CHANGER_ELEMENT Element;
    CHANGER_ELEMENT SrcElementAddress;
    uint            Flags;
    uint            ExceptionCode;
    ubyte           TargetId;
    ubyte           Lun;
    ushort          Reserved;
    ubyte[36]       PrimaryVolumeID;
    ubyte[36]       AlternateVolumeID;
    ubyte[8]        VendorIdentification;
    ubyte[16]       ProductIdentification;
    ubyte[32]       SerialNumber;
}

struct CHANGER_INITIALIZE_ELEMENT_STATUS
{
    CHANGER_ELEMENT_LIST ElementList;
    ubyte                BarCodeScan;
}

struct CHANGER_SET_POSITION
{
    CHANGER_ELEMENT Transport;
    CHANGER_ELEMENT Destination;
    ubyte           Flip;
}

struct CHANGER_EXCHANGE_MEDIUM
{
    CHANGER_ELEMENT Transport;
    CHANGER_ELEMENT Source;
    CHANGER_ELEMENT Destination1;
    CHANGER_ELEMENT Destination2;
    ubyte           Flip1;
    ubyte           Flip2;
}

struct CHANGER_MOVE_MEDIUM
{
    CHANGER_ELEMENT Transport;
    CHANGER_ELEMENT Source;
    CHANGER_ELEMENT Destination;
    ubyte           Flip;
}

struct CHANGER_SEND_VOLUME_TAG_INFORMATION
{
    CHANGER_ELEMENT StartingElement;
    uint            ActionCode;
    ubyte[40]       VolumeIDTemplate;
}

struct READ_ELEMENT_ADDRESS_INFO
{
    uint NumberOfElements;
    CHANGER_ELEMENT_STATUS[1] ElementStatus;
}

struct PATHNAME_BUFFER
{
    uint      PathNameLength;
    ushort[1] Name;
}

struct FSCTL_QUERY_FAT_BPB_BUFFER
{
    ubyte[36] First0x24BytesOfBootSector;
}

struct REFS_VOLUME_DATA_BUFFER
{
    uint             ByteCount;
    uint             MajorVersion;
    uint             MinorVersion;
    uint             BytesPerPhysicalSector;
    LARGE_INTEGER    VolumeSerialNumber;
    LARGE_INTEGER    NumberSectors;
    LARGE_INTEGER    TotalClusters;
    LARGE_INTEGER    FreeClusters;
    LARGE_INTEGER    TotalReserved;
    uint             BytesPerSector;
    uint             BytesPerCluster;
    LARGE_INTEGER    MaximumSizeOfResidentFile;
    ushort           FastTierDataFillRatio;
    ushort           SlowTierDataFillRatio;
    uint             DestagesFastTierToSlowTierRate;
    LARGE_INTEGER[9] Reserved;
}

struct STARTING_LCN_INPUT_BUFFER_EX
{
    LARGE_INTEGER StartingLcn;
    uint          Flags;
}

struct RETRIEVAL_POINTERS_AND_REFCOUNT_BUFFER
{
    uint          ExtentCount;
    LARGE_INTEGER StartingVcn;
    struct
    {
        LARGE_INTEGER NextVcn;
        LARGE_INTEGER Lcn;
        uint          ReferenceCount;
    }
}

struct RETRIEVAL_POINTER_COUNT
{
    uint ExtentCount;
}

struct MOVE_FILE_RECORD_DATA
{
    HANDLE        FileHandle;
    LARGE_INTEGER SourceFileRecord;
    LARGE_INTEGER TargetFileRecord;
}

union USN_RECORD_UNION
{
    USN_RECORD_COMMON_HEADER Header;
    USN_RECORD_V2 V2;
    USN_RECORD_V3 V3;
    USN_RECORD_V4 V4;
}

struct BULK_SECURITY_TEST_DATA
{
    uint    DesiredAccess;
    uint[1] SecurityIds;
}

struct FILE_PREFETCH
{
    uint     Type;
    uint     Count;
    ulong[1] Prefetch;
}

struct FILE_PREFETCH_EX
{
    uint     Type;
    uint     Count;
    void*    Context;
    ulong[1] Prefetch;
}

struct FILE_ZERO_DATA_INFORMATION_EX
{
    LARGE_INTEGER FileOffset;
    LARGE_INTEGER BeyondFinalZero;
    uint          Flags;
}

struct ENCRYPTION_BUFFER
{
    uint     EncryptionOperation;
    ubyte[1] Private;
}

struct DECRYPTION_STATUS_BUFFER
{
    ubyte NoEncryptedStreams;
}

struct REQUEST_RAW_ENCRYPTED_DATA
{
    long FileOffset;
    uint Length;
}

struct ENCRYPTED_DATA_INFO
{
    ulong   StartingFileOffset;
    uint    OutputBufferOffset;
    uint    BytesWithinFileSize;
    uint    BytesWithinValidDataLength;
    ushort  CompressionFormat;
    ubyte   DataUnitShift;
    ubyte   ChunkShift;
    ubyte   ClusterShift;
    ubyte   EncryptionFormat;
    ushort  NumberOfDataBlocks;
    uint[1] DataBlockSize;
}

struct EXTENDED_ENCRYPTED_DATA_INFO
{
    uint ExtendedCode;
    uint Length;
    uint Flags;
    uint Reserved;
}

struct SI_COPYFILE
{
    uint      SourceFileNameLength;
    uint      DestinationFileNameLength;
    uint      Flags;
    ushort[1] FileNameBuffer;
}

struct FILE_INITIATE_REPAIR_OUTPUT_BUFFER
{
    ulong Hint1;
    ulong Hint2;
    ulong Clsn;
    uint  Status;
}

struct TXFS_ROLLFORWARD_REDO_INFORMATION
{
    LARGE_INTEGER LastVirtualClock;
    ulong         LastRedoLsn;
    ulong         HighestRecoveryLsn;
    uint          Flags;
}

struct TXFS_START_RM_INFORMATION
{
    uint      Flags;
    ulong     LogContainerSize;
    uint      LogContainerCountMin;
    uint      LogContainerCountMax;
    uint      LogGrowthIncrement;
    uint      LogAutoShrinkPercentage;
    uint      TmLogPathOffset;
    ushort    TmLogPathLength;
    ushort    LoggingMode;
    ushort    LogPathLength;
    ushort    Reserved;
    ushort[1] LogPath;
}

struct FILE_FS_PERSISTENT_VOLUME_INFORMATION
{
    uint VolumeFlags;
    uint FlagMask;
    uint Version;
    uint Reserved;
}

struct STORAGE_QUERY_DEPENDENT_VOLUME_REQUEST
{
    uint RequestLevel;
    uint RequestFlags;
}

struct STORAGE_QUERY_DEPENDENT_VOLUME_LEV1_ENTRY
{
    uint                 EntryLength;
    uint                 DependencyTypeFlags;
    uint                 ProviderSpecificFlags;
    VIRTUAL_STORAGE_TYPE VirtualStorageType;
}

struct STORAGE_QUERY_DEPENDENT_VOLUME_LEV2_ENTRY
{
    uint                 EntryLength;
    uint                 DependencyTypeFlags;
    uint                 ProviderSpecificFlags;
    VIRTUAL_STORAGE_TYPE VirtualStorageType;
    uint                 AncestorLevel;
    uint                 HostVolumeNameOffset;
    uint                 HostVolumeNameSize;
    uint                 DependentVolumeNameOffset;
    uint                 DependentVolumeNameSize;
    uint                 RelativePathOffset;
    uint                 RelativePathSize;
    uint                 DependentDeviceNameOffset;
    uint                 DependentDeviceNameSize;
}

struct STORAGE_QUERY_DEPENDENT_VOLUME_RESPONSE
{
    uint ResponseLevel;
    uint NumberEntries;
    union
    {
        STORAGE_QUERY_DEPENDENT_VOLUME_LEV1_ENTRY Lev1Depends;
        STORAGE_QUERY_DEPENDENT_VOLUME_LEV2_ENTRY Lev2Depends;
    }
}

struct SD_CHANGE_MACHINE_SID_INPUT
{
    ushort CurrentMachineSIDOffset;
    ushort CurrentMachineSIDLength;
    ushort NewMachineSIDOffset;
    ushort NewMachineSIDLength;
}

struct SD_CHANGE_MACHINE_SID_OUTPUT
{
    ulong NumSDChangedSuccess;
    ulong NumSDChangedFail;
    ulong NumSDUnused;
    ulong NumSDTotal;
    ulong NumMftSDChangedSuccess;
    ulong NumMftSDChangedFail;
    ulong NumMftSDTotal;
}

struct SD_QUERY_STATS_INPUT
{
    uint Reserved;
}

struct SD_QUERY_STATS_OUTPUT
{
    ulong SdsStreamSize;
    ulong SdsAllocationSize;
    ulong SiiStreamSize;
    ulong SiiAllocationSize;
    ulong SdhStreamSize;
    ulong SdhAllocationSize;
    ulong NumSDTotal;
    ulong NumSDUnused;
}

struct SD_ENUM_SDS_INPUT
{
    ulong StartingOffset;
    ulong MaxSDEntriesToReturn;
}

struct SD_ENUM_SDS_ENTRY
{
    uint     Hash;
    uint     SecurityId;
    ulong    Offset;
    uint     Length;
    ubyte[1] Descriptor;
}

struct SD_ENUM_SDS_OUTPUT
{
    ulong                NextOffset;
    ulong                NumSDEntriesReturned;
    ulong                NumSDBytesReturned;
    SD_ENUM_SDS_ENTRY[1] SDEntry;
}

struct SD_GLOBAL_CHANGE_INPUT
{
    uint Flags;
    uint ChangeType;
    union
    {
        SD_CHANGE_MACHINE_SID_INPUT SdChange;
        SD_QUERY_STATS_INPUT SdQueryStats;
        SD_ENUM_SDS_INPUT    SdEnumSds;
    }
}

struct SD_GLOBAL_CHANGE_OUTPUT
{
    uint Flags;
    uint ChangeType;
    union
    {
        SD_CHANGE_MACHINE_SID_OUTPUT SdChange;
        SD_QUERY_STATS_OUTPUT SdQueryStats;
        SD_ENUM_SDS_OUTPUT SdEnumSds;
    }
}

struct FILE_TYPE_NOTIFICATION_INPUT
{
    uint    Flags;
    uint    NumFileTypeIDs;
    GUID[1] FileTypeID;
}

struct CSV_MGMT_LOCK
{
    uint Flags;
}

struct CSV_QUERY_FILE_REVISION_FILE_ID_128
{
    FILE_ID_128 FileId;
    long[3]     FileRevision;
}

struct CSV_QUERY_VOLUME_REDIRECT_STATE
{
    uint  MdsNodeId;
    uint  DsNodeId;
    ubyte IsDiskConnected;
    ubyte ClusterEnableDirectIo;
    CSVFS_DISK_CONNECTIVITY DiskConnectivity;
}

struct CSV_QUERY_MDS_PATH_V2
{
    long Version;
    uint RequiredSize;
    uint MdsNodeId;
    uint DsNodeId;
    uint Flags;
    CSVFS_DISK_CONNECTIVITY DiskConnectivity;
    GUID VolumeId;
    uint IpAddressOffset;
    uint IpAddressLength;
    uint PathOffset;
    uint PathLength;
}

struct CLUSTER_RANGE
{
    LARGE_INTEGER StartingCluster;
    LARGE_INTEGER ClusterCount;
}

struct FILE_REFERENCE_RANGE
{
    ulong StartingFileReferenceNumber;
    ulong EndingFileReferenceNumber;
}

struct QUERY_FILE_LAYOUT_INPUT
{
    union
    {
        uint FilterEntryCount;
        uint NumberOfPairs;
    }
    uint Flags;
    QUERY_FILE_LAYOUT_FILTER_TYPE FilterType;
    uint Reserved;
    union Filter
    {
        CLUSTER_RANGE[1] ClusterRanges;
        FILE_REFERENCE_RANGE[1] FileReferenceRanges;
        STORAGE_RESERVE_ID[1] StorageReserveIds;
    }
}

struct QUERY_FILE_LAYOUT_OUTPUT
{
    uint FileEntryCount;
    uint FirstFileOffset;
    uint Flags;
    uint Reserved;
}

struct FILE_LAYOUT_ENTRY
{
    uint  Version;
    uint  NextFileOffset;
    uint  Flags;
    uint  FileAttributes;
    ulong FileReferenceNumber;
    uint  FirstNameOffset;
    uint  FirstStreamOffset;
    uint  ExtraInfoOffset;
    uint  ExtraInfoLength;
}

struct FILE_LAYOUT_NAME_ENTRY
{
    uint      NextNameOffset;
    uint      Flags;
    ulong     ParentFileReferenceNumber;
    uint      FileNameLength;
    uint      Reserved;
    ushort[1] FileName;
}

struct FILE_LAYOUT_INFO_ENTRY
{
    struct BasicInformation
    {
        LARGE_INTEGER CreationTime;
        LARGE_INTEGER LastAccessTime;
        LARGE_INTEGER LastWriteTime;
        LARGE_INTEGER ChangeTime;
        uint          FileAttributes;
    }
    uint               OwnerId;
    uint               SecurityId;
    long               Usn;
    STORAGE_RESERVE_ID StorageReserveId;
}

struct STREAM_LAYOUT_ENTRY
{
    uint          Version;
    uint          NextStreamOffset;
    uint          Flags;
    uint          ExtentInformationOffset;
    LARGE_INTEGER AllocationSize;
    LARGE_INTEGER EndOfFile;
    uint          StreamInformationOffset;
    uint          AttributeTypeCode;
    uint          AttributeFlags;
    uint          StreamIdentifierLength;
    ushort[1]     StreamIdentifier;
}

struct STREAM_EXTENT_ENTRY
{
    uint Flags;
    union ExtentInformation
    {
        RETRIEVAL_POINTERS_BUFFER RetrievalPointers;
    }
}

struct FSCTL_SET_INTEGRITY_INFORMATION_BUFFER_EX
{
    ubyte    EnableIntegrity;
    ubyte    KeepIntegrityStateUnchanged;
    ushort   Reserved;
    uint     Flags;
    ubyte    Version;
    ubyte[7] Reserved2;
}

struct FSCTL_OFFLOAD_READ_INPUT
{
    uint  Size;
    uint  Flags;
    uint  TokenTimeToLive;
    uint  Reserved;
    ulong FileOffset;
    ulong CopyLength;
}

struct FSCTL_OFFLOAD_READ_OUTPUT
{
    uint       Size;
    uint       Flags;
    ulong      TransferLength;
    ubyte[512] Token;
}

struct FSCTL_OFFLOAD_WRITE_INPUT
{
    uint       Size;
    uint       Flags;
    ulong      FileOffset;
    ulong      CopyLength;
    ulong      TransferOffset;
    ubyte[512] Token;
}

struct FSCTL_OFFLOAD_WRITE_OUTPUT
{
    uint  Size;
    uint  Flags;
    ulong LengthWritten;
}

struct SET_PURGE_FAILURE_MODE_INPUT
{
    uint Flags;
}

struct FILE_REGION_INFO
{
    long FileOffset;
    long Length;
    uint Usage;
    uint Reserved;
}

struct FILE_REGION_OUTPUT
{
    uint                Flags;
    uint                TotalRegionEntryCount;
    uint                RegionEntryCount;
    uint                Reserved;
    FILE_REGION_INFO[1] Region;
}

struct FILE_REGION_INPUT
{
    long FileOffset;
    long Length;
    uint DesiredUsage;
}

struct WRITE_USN_REASON_INPUT
{
    uint Flags;
    uint UsnReasonToWrite;
}

struct STREAM_INFORMATION_ENTRY
{
    uint Version;
    uint Flags;
    union StreamInformation
    {
        struct DesiredStorageClass
        {
            FILE_STORAGE_TIER_CLASS Class;
            uint Flags;
        }
        struct DataStream
        {
            ushort Length;
            ushort Flags;
            uint   Reserved;
            ulong  Vdl;
        }
        struct Reparse
        {
            ushort Length;
            ushort Flags;
            uint   ReparseDataSize;
            uint   ReparseDataOffset;
        }
        struct Ea
        {
            ushort Length;
            ushort Flags;
            uint   EaSize;
            uint   EaInformationOffset;
        }
    }
}

struct FILE_DESIRED_STORAGE_CLASS_INFORMATION
{
    FILE_STORAGE_TIER_CLASS Class;
    uint Flags;
}

struct DUPLICATE_EXTENTS_DATA_EX
{
    size_t        Size;
    HANDLE        FileHandle;
    LARGE_INTEGER SourceFileOffset;
    LARGE_INTEGER TargetFileOffset;
    LARGE_INTEGER ByteCount;
    uint          Flags;
}

struct REFS_SMR_VOLUME_INFO_OUTPUT
{
    uint          Version;
    uint          Flags;
    LARGE_INTEGER SizeOfRandomlyWritableTier;
    LARGE_INTEGER FreeSpaceInRandomlyWritableTier;
    LARGE_INTEGER SizeofSMRTier;
    LARGE_INTEGER FreeSpaceInSMRTier;
    LARGE_INTEGER UsableFreeSpaceInSMRTier;
    REFS_SMR_VOLUME_GC_STATE VolumeGcState;
    uint          VolumeGcLastStatus;
    ulong[7]      Unused;
}

struct REFS_SMR_VOLUME_GC_PARAMETERS
{
    uint     Version;
    uint     Flags;
    REFS_SMR_VOLUME_GC_ACTION Action;
    REFS_SMR_VOLUME_GC_METHOD Method;
    uint     IoGranularity;
    uint     CompressionFormat;
    ulong[8] Unused;
}

struct STREAMS_QUERY_PARAMETERS_OUTPUT_BUFFER
{
    uint OptimalWriteSize;
    uint StreamGranularitySize;
    uint StreamIdMin;
    uint StreamIdMax;
}

struct STREAMS_ASSOCIATE_ID_INPUT_BUFFER
{
    uint Flags;
    uint StreamId;
}

struct STREAMS_QUERY_ID_OUTPUT_BUFFER
{
    uint StreamId;
}

struct QUERY_BAD_RANGES_INPUT_RANGE
{
    ulong StartOffset;
    ulong LengthInBytes;
}

struct QUERY_BAD_RANGES_INPUT
{
    uint Flags;
    uint NumRanges;
    QUERY_BAD_RANGES_INPUT_RANGE[1] Ranges;
}

struct QUERY_BAD_RANGES_OUTPUT_RANGE
{
    uint  Flags;
    uint  Reserved;
    ulong StartOffset;
    ulong LengthInBytes;
}

struct QUERY_BAD_RANGES_OUTPUT
{
    uint  Flags;
    uint  NumBadRanges;
    ulong NextOffsetToLookUp;
    QUERY_BAD_RANGES_OUTPUT_RANGE[1] BadRanges;
}

struct SET_DAX_ALLOC_ALIGNMENT_HINT_INPUT
{
    uint  Flags;
    uint  AlignmentShift;
    ulong FileOffsetToAlign;
    uint  FallbackAlignmentShift;
}

struct VIRTUAL_STORAGE_SET_BEHAVIOR_INPUT
{
    uint Size;
    VIRTUAL_STORAGE_BEHAVIOR_CODE BehaviorCode;
}

struct ENCRYPTION_KEY_CTRL_INPUT
{
    uint   HeaderSize;
    uint   StructureSize;
    ushort KeyOffset;
    ushort KeySize;
    uint   DplLock;
    ulong  DplUserId;
    ulong  DplCredentialId;
}

struct WOF_EXTERNAL_INFO
{
    uint Version;
    uint Provider;
}

struct WOF_EXTERNAL_FILE_ID
{
    FILE_ID_128 FileId;
}

struct WOF_VERSION_INFO
{
    uint WofVersion;
}

struct WIM_PROVIDER_EXTERNAL_INFO
{
    uint          Version;
    uint          Flags;
    LARGE_INTEGER DataSourceId;
    ubyte[20]     ResourceHash;
}

struct WIM_PROVIDER_ADD_OVERLAY_INPUT
{
    uint WimType;
    uint WimIndex;
    uint WimFileNameOffset;
    uint WimFileNameLength;
}

struct WIM_PROVIDER_UPDATE_OVERLAY_INPUT
{
    LARGE_INTEGER DataSourceId;
    uint          WimFileNameOffset;
    uint          WimFileNameLength;
}

struct WIM_PROVIDER_REMOVE_OVERLAY_INPUT
{
    LARGE_INTEGER DataSourceId;
}

struct WIM_PROVIDER_SUSPEND_OVERLAY_INPUT
{
    LARGE_INTEGER DataSourceId;
}

struct WIM_PROVIDER_OVERLAY_ENTRY
{
    uint          NextEntryOffset;
    LARGE_INTEGER DataSourceId;
    GUID          WimGuid;
    uint          WimFileNameOffset;
    uint          WimType;
    uint          WimIndex;
    uint          Flags;
}

struct FILE_PROVIDER_EXTERNAL_INFO_V0
{
    uint Version;
    uint Algorithm;
}

struct FILE_PROVIDER_EXTERNAL_INFO_V1
{
    uint Version;
    uint Algorithm;
    uint Flags;
}

struct CONTAINER_VOLUME_STATE
{
    uint Flags;
}

struct CONTAINER_ROOT_INFO_INPUT
{
    uint Flags;
}

struct CONTAINER_ROOT_INFO_OUTPUT
{
    ushort   ContainerRootIdLength;
    ubyte[1] ContainerRootId;
}

struct VIRTUALIZATION_INSTANCE_INFO_INPUT
{
    uint NumberOfWorkerThreads;
    uint Flags;
}

struct VIRTUALIZATION_INSTANCE_INFO_INPUT_EX
{
    ushort HeaderSize;
    uint   Flags;
    uint   NotificationInfoSize;
    ushort NotificationInfoOffset;
    ushort ProviderMajorVersion;
}

struct VIRTUALIZATION_INSTANCE_INFO_OUTPUT
{
    GUID VirtualizationInstanceID;
}

struct GET_FILTER_FILE_IDENTIFIER_INPUT
{
    ushort    AltitudeLength;
    ushort[1] Altitude;
}

struct GET_FILTER_FILE_IDENTIFIER_OUTPUT
{
    ushort   FilterFileIdentifierLength;
    ubyte[1] FilterFileIdentifier;
}

struct IO_IRP_EXT_TRACK_OFFSET_HEADER
{
    ushort Validation;
    ushort Flags;
    PIO_IRP_EXT_PROCESS_TRACKED_OFFSET_CALLBACK TrackedOffsetCallback;
}

struct SCARD_IO_REQUEST
{
    uint dwProtocol;
    uint cbPciLength;
}

struct SCARD_T0_COMMAND
{
    ubyte bCla;
    ubyte bIns;
    ubyte bP1;
    ubyte bP2;
    ubyte bP3;
}

struct SCARD_T0_REQUEST
{
    SCARD_IO_REQUEST ioRequest;
    ubyte            bSw1;
    ubyte            bSw2;
    union
    {
        SCARD_T0_COMMAND CmdBytes;
        ubyte[5]         rgbHeader;
    }
}

struct SCARD_T1_REQUEST
{
    SCARD_IO_REQUEST ioRequest;
}

struct PRINTER_INFO_1A
{
    uint         Flags;
    const(char)* pDescription;
    const(char)* pName;
    const(char)* pComment;
}

struct PRINTER_INFO_1W
{
    uint          Flags;
    const(wchar)* pDescription;
    const(wchar)* pName;
    const(wchar)* pComment;
}

struct PRINTER_INFO_2A
{
    const(char)* pServerName;
    const(char)* pPrinterName;
    const(char)* pShareName;
    const(char)* pPortName;
    const(char)* pDriverName;
    const(char)* pComment;
    const(char)* pLocation;
    DEVMODEA*    pDevMode;
    const(char)* pSepFile;
    const(char)* pPrintProcessor;
    const(char)* pDatatype;
    const(char)* pParameters;
    void*        pSecurityDescriptor;
    uint         Attributes;
    uint         Priority;
    uint         DefaultPriority;
    uint         StartTime;
    uint         UntilTime;
    uint         Status;
    uint         cJobs;
    uint         AveragePPM;
}

struct PRINTER_INFO_2W
{
    const(wchar)* pServerName;
    const(wchar)* pPrinterName;
    const(wchar)* pShareName;
    const(wchar)* pPortName;
    const(wchar)* pDriverName;
    const(wchar)* pComment;
    const(wchar)* pLocation;
    DEVMODEW*     pDevMode;
    const(wchar)* pSepFile;
    const(wchar)* pPrintProcessor;
    const(wchar)* pDatatype;
    const(wchar)* pParameters;
    void*         pSecurityDescriptor;
    uint          Attributes;
    uint          Priority;
    uint          DefaultPriority;
    uint          StartTime;
    uint          UntilTime;
    uint          Status;
    uint          cJobs;
    uint          AveragePPM;
}

struct PRINTER_INFO_3
{
    void* pSecurityDescriptor;
}

struct PRINTER_INFO_4A
{
    const(char)* pPrinterName;
    const(char)* pServerName;
    uint         Attributes;
}

struct PRINTER_INFO_4W
{
    const(wchar)* pPrinterName;
    const(wchar)* pServerName;
    uint          Attributes;
}

struct PRINTER_INFO_5A
{
    const(char)* pPrinterName;
    const(char)* pPortName;
    uint         Attributes;
    uint         DeviceNotSelectedTimeout;
    uint         TransmissionRetryTimeout;
}

struct PRINTER_INFO_5W
{
    const(wchar)* pPrinterName;
    const(wchar)* pPortName;
    uint          Attributes;
    uint          DeviceNotSelectedTimeout;
    uint          TransmissionRetryTimeout;
}

struct PRINTER_INFO_6
{
    uint dwStatus;
}

struct PRINTER_INFO_7A
{
    const(char)* pszObjectGUID;
    uint         dwAction;
}

struct PRINTER_INFO_7W
{
    const(wchar)* pszObjectGUID;
    uint          dwAction;
}

struct PRINTER_INFO_8A
{
    DEVMODEA* pDevMode;
}

struct PRINTER_INFO_8W
{
    DEVMODEW* pDevMode;
}

struct PRINTER_INFO_9A
{
    DEVMODEA* pDevMode;
}

struct PRINTER_INFO_9W
{
    DEVMODEW* pDevMode;
}

struct JOB_INFO_1A
{
    uint         JobId;
    const(char)* pPrinterName;
    const(char)* pMachineName;
    const(char)* pUserName;
    const(char)* pDocument;
    const(char)* pDatatype;
    const(char)* pStatus;
    uint         Status;
    uint         Priority;
    uint         Position;
    uint         TotalPages;
    uint         PagesPrinted;
    SYSTEMTIME   Submitted;
}

struct JOB_INFO_1W
{
    uint          JobId;
    const(wchar)* pPrinterName;
    const(wchar)* pMachineName;
    const(wchar)* pUserName;
    const(wchar)* pDocument;
    const(wchar)* pDatatype;
    const(wchar)* pStatus;
    uint          Status;
    uint          Priority;
    uint          Position;
    uint          TotalPages;
    uint          PagesPrinted;
    SYSTEMTIME    Submitted;
}

struct JOB_INFO_2A
{
    uint         JobId;
    const(char)* pPrinterName;
    const(char)* pMachineName;
    const(char)* pUserName;
    const(char)* pDocument;
    const(char)* pNotifyName;
    const(char)* pDatatype;
    const(char)* pPrintProcessor;
    const(char)* pParameters;
    const(char)* pDriverName;
    DEVMODEA*    pDevMode;
    const(char)* pStatus;
    void*        pSecurityDescriptor;
    uint         Status;
    uint         Priority;
    uint         Position;
    uint         StartTime;
    uint         UntilTime;
    uint         TotalPages;
    uint         Size;
    SYSTEMTIME   Submitted;
    uint         Time;
    uint         PagesPrinted;
}

struct JOB_INFO_2W
{
    uint          JobId;
    const(wchar)* pPrinterName;
    const(wchar)* pMachineName;
    const(wchar)* pUserName;
    const(wchar)* pDocument;
    const(wchar)* pNotifyName;
    const(wchar)* pDatatype;
    const(wchar)* pPrintProcessor;
    const(wchar)* pParameters;
    const(wchar)* pDriverName;
    DEVMODEW*     pDevMode;
    const(wchar)* pStatus;
    void*         pSecurityDescriptor;
    uint          Status;
    uint          Priority;
    uint          Position;
    uint          StartTime;
    uint          UntilTime;
    uint          TotalPages;
    uint          Size;
    SYSTEMTIME    Submitted;
    uint          Time;
    uint          PagesPrinted;
}

struct JOB_INFO_3
{
    uint JobId;
    uint NextJobId;
    uint Reserved;
}

struct JOB_INFO_4A
{
    uint         JobId;
    const(char)* pPrinterName;
    const(char)* pMachineName;
    const(char)* pUserName;
    const(char)* pDocument;
    const(char)* pNotifyName;
    const(char)* pDatatype;
    const(char)* pPrintProcessor;
    const(char)* pParameters;
    const(char)* pDriverName;
    DEVMODEA*    pDevMode;
    const(char)* pStatus;
    void*        pSecurityDescriptor;
    uint         Status;
    uint         Priority;
    uint         Position;
    uint         StartTime;
    uint         UntilTime;
    uint         TotalPages;
    uint         Size;
    SYSTEMTIME   Submitted;
    uint         Time;
    uint         PagesPrinted;
    int          SizeHigh;
}

struct JOB_INFO_4W
{
    uint          JobId;
    const(wchar)* pPrinterName;
    const(wchar)* pMachineName;
    const(wchar)* pUserName;
    const(wchar)* pDocument;
    const(wchar)* pNotifyName;
    const(wchar)* pDatatype;
    const(wchar)* pPrintProcessor;
    const(wchar)* pParameters;
    const(wchar)* pDriverName;
    DEVMODEW*     pDevMode;
    const(wchar)* pStatus;
    void*         pSecurityDescriptor;
    uint          Status;
    uint          Priority;
    uint          Position;
    uint          StartTime;
    uint          UntilTime;
    uint          TotalPages;
    uint          Size;
    SYSTEMTIME    Submitted;
    uint          Time;
    uint          PagesPrinted;
    int           SizeHigh;
}

struct ADDJOB_INFO_1A
{
    const(char)* Path;
    uint         JobId;
}

struct ADDJOB_INFO_1W
{
    const(wchar)* Path;
    uint          JobId;
}

struct DRIVER_INFO_1A
{
    const(char)* pName;
}

struct DRIVER_INFO_1W
{
    const(wchar)* pName;
}

struct DRIVER_INFO_2A
{
    uint         cVersion;
    const(char)* pName;
    const(char)* pEnvironment;
    const(char)* pDriverPath;
    const(char)* pDataFile;
    const(char)* pConfigFile;
}

struct DRIVER_INFO_2W
{
    uint          cVersion;
    const(wchar)* pName;
    const(wchar)* pEnvironment;
    const(wchar)* pDriverPath;
    const(wchar)* pDataFile;
    const(wchar)* pConfigFile;
}

struct DRIVER_INFO_3A
{
    uint         cVersion;
    const(char)* pName;
    const(char)* pEnvironment;
    const(char)* pDriverPath;
    const(char)* pDataFile;
    const(char)* pConfigFile;
    const(char)* pHelpFile;
    const(char)* pDependentFiles;
    const(char)* pMonitorName;
    const(char)* pDefaultDataType;
}

struct DRIVER_INFO_3W
{
    uint          cVersion;
    const(wchar)* pName;
    const(wchar)* pEnvironment;
    const(wchar)* pDriverPath;
    const(wchar)* pDataFile;
    const(wchar)* pConfigFile;
    const(wchar)* pHelpFile;
    const(wchar)* pDependentFiles;
    const(wchar)* pMonitorName;
    const(wchar)* pDefaultDataType;
}

struct DRIVER_INFO_4A
{
    uint         cVersion;
    const(char)* pName;
    const(char)* pEnvironment;
    const(char)* pDriverPath;
    const(char)* pDataFile;
    const(char)* pConfigFile;
    const(char)* pHelpFile;
    const(char)* pDependentFiles;
    const(char)* pMonitorName;
    const(char)* pDefaultDataType;
    const(char)* pszzPreviousNames;
}

struct DRIVER_INFO_4W
{
    uint          cVersion;
    const(wchar)* pName;
    const(wchar)* pEnvironment;
    const(wchar)* pDriverPath;
    const(wchar)* pDataFile;
    const(wchar)* pConfigFile;
    const(wchar)* pHelpFile;
    const(wchar)* pDependentFiles;
    const(wchar)* pMonitorName;
    const(wchar)* pDefaultDataType;
    const(wchar)* pszzPreviousNames;
}

struct DRIVER_INFO_5A
{
    uint         cVersion;
    const(char)* pName;
    const(char)* pEnvironment;
    const(char)* pDriverPath;
    const(char)* pDataFile;
    const(char)* pConfigFile;
    uint         dwDriverAttributes;
    uint         dwConfigVersion;
    uint         dwDriverVersion;
}

struct DRIVER_INFO_5W
{
    uint          cVersion;
    const(wchar)* pName;
    const(wchar)* pEnvironment;
    const(wchar)* pDriverPath;
    const(wchar)* pDataFile;
    const(wchar)* pConfigFile;
    uint          dwDriverAttributes;
    uint          dwConfigVersion;
    uint          dwDriverVersion;
}

struct DRIVER_INFO_6A
{
    uint         cVersion;
    const(char)* pName;
    const(char)* pEnvironment;
    const(char)* pDriverPath;
    const(char)* pDataFile;
    const(char)* pConfigFile;
    const(char)* pHelpFile;
    const(char)* pDependentFiles;
    const(char)* pMonitorName;
    const(char)* pDefaultDataType;
    const(char)* pszzPreviousNames;
    FILETIME     ftDriverDate;
    ulong        dwlDriverVersion;
    const(char)* pszMfgName;
    const(char)* pszOEMUrl;
    const(char)* pszHardwareID;
    const(char)* pszProvider;
}

struct DRIVER_INFO_6W
{
    uint          cVersion;
    const(wchar)* pName;
    const(wchar)* pEnvironment;
    const(wchar)* pDriverPath;
    const(wchar)* pDataFile;
    const(wchar)* pConfigFile;
    const(wchar)* pHelpFile;
    const(wchar)* pDependentFiles;
    const(wchar)* pMonitorName;
    const(wchar)* pDefaultDataType;
    const(wchar)* pszzPreviousNames;
    FILETIME      ftDriverDate;
    ulong         dwlDriverVersion;
    const(wchar)* pszMfgName;
    const(wchar)* pszOEMUrl;
    const(wchar)* pszHardwareID;
    const(wchar)* pszProvider;
}

struct DRIVER_INFO_8A
{
    uint         cVersion;
    const(char)* pName;
    const(char)* pEnvironment;
    const(char)* pDriverPath;
    const(char)* pDataFile;
    const(char)* pConfigFile;
    const(char)* pHelpFile;
    const(char)* pDependentFiles;
    const(char)* pMonitorName;
    const(char)* pDefaultDataType;
    const(char)* pszzPreviousNames;
    FILETIME     ftDriverDate;
    ulong        dwlDriverVersion;
    const(char)* pszMfgName;
    const(char)* pszOEMUrl;
    const(char)* pszHardwareID;
    const(char)* pszProvider;
    const(char)* pszPrintProcessor;
    const(char)* pszVendorSetup;
    const(char)* pszzColorProfiles;
    const(char)* pszInfPath;
    uint         dwPrinterDriverAttributes;
    const(char)* pszzCoreDriverDependencies;
    FILETIME     ftMinInboxDriverVerDate;
    ulong        dwlMinInboxDriverVerVersion;
}

struct DRIVER_INFO_8W
{
    uint          cVersion;
    const(wchar)* pName;
    const(wchar)* pEnvironment;
    const(wchar)* pDriverPath;
    const(wchar)* pDataFile;
    const(wchar)* pConfigFile;
    const(wchar)* pHelpFile;
    const(wchar)* pDependentFiles;
    const(wchar)* pMonitorName;
    const(wchar)* pDefaultDataType;
    const(wchar)* pszzPreviousNames;
    FILETIME      ftDriverDate;
    ulong         dwlDriverVersion;
    const(wchar)* pszMfgName;
    const(wchar)* pszOEMUrl;
    const(wchar)* pszHardwareID;
    const(wchar)* pszProvider;
    const(wchar)* pszPrintProcessor;
    const(wchar)* pszVendorSetup;
    const(wchar)* pszzColorProfiles;
    const(wchar)* pszInfPath;
    uint          dwPrinterDriverAttributes;
    const(wchar)* pszzCoreDriverDependencies;
    FILETIME      ftMinInboxDriverVerDate;
    ulong         dwlMinInboxDriverVerVersion;
}

struct DOC_INFO_1A
{
    const(char)* pDocName;
    const(char)* pOutputFile;
    const(char)* pDatatype;
}

struct DOC_INFO_1W
{
    const(wchar)* pDocName;
    const(wchar)* pOutputFile;
    const(wchar)* pDatatype;
}

struct FORM_INFO_1A
{
    uint         Flags;
    const(char)* pName;
    SIZE         Size;
    RECTL        ImageableArea;
}

struct FORM_INFO_1W
{
    uint          Flags;
    const(wchar)* pName;
    SIZE          Size;
    RECTL         ImageableArea;
}

struct FORM_INFO_2A
{
    uint         Flags;
    const(char)* pName;
    SIZE         Size;
    RECTL        ImageableArea;
    const(char)* pKeyword;
    uint         StringType;
    const(char)* pMuiDll;
    uint         dwResourceId;
    const(char)* pDisplayName;
    ushort       wLangId;
}

struct FORM_INFO_2W
{
    uint          Flags;
    const(wchar)* pName;
    SIZE          Size;
    RECTL         ImageableArea;
    const(char)*  pKeyword;
    uint          StringType;
    const(wchar)* pMuiDll;
    uint          dwResourceId;
    const(wchar)* pDisplayName;
    ushort        wLangId;
}

struct DOC_INFO_2A
{
    const(char)* pDocName;
    const(char)* pOutputFile;
    const(char)* pDatatype;
    uint         dwMode;
    uint         JobId;
}

struct DOC_INFO_2W
{
    const(wchar)* pDocName;
    const(wchar)* pOutputFile;
    const(wchar)* pDatatype;
    uint          dwMode;
    uint          JobId;
}

struct DOC_INFO_3A
{
    const(char)* pDocName;
    const(char)* pOutputFile;
    const(char)* pDatatype;
    uint         dwFlags;
}

struct DOC_INFO_3W
{
    const(wchar)* pDocName;
    const(wchar)* pOutputFile;
    const(wchar)* pDatatype;
    uint          dwFlags;
}

struct PRINTPROCESSOR_INFO_1A
{
    const(char)* pName;
}

struct PRINTPROCESSOR_INFO_1W
{
    const(wchar)* pName;
}

struct PRINTPROCESSOR_CAPS_1
{
    uint dwLevel;
    uint dwNupOptions;
    uint dwPageOrderFlags;
    uint dwNumberOfCopies;
}

struct PRINTPROCESSOR_CAPS_2
{
    uint dwLevel;
    uint dwNupOptions;
    uint dwPageOrderFlags;
    uint dwNumberOfCopies;
    uint dwDuplexHandlingCaps;
    uint dwNupDirectionCaps;
    uint dwNupBorderCaps;
    uint dwBookletHandlingCaps;
    uint dwScalingCaps;
}

struct PORT_INFO_1A
{
    const(char)* pName;
}

struct PORT_INFO_1W
{
    const(wchar)* pName;
}

struct PORT_INFO_2A
{
    const(char)* pPortName;
    const(char)* pMonitorName;
    const(char)* pDescription;
    uint         fPortType;
    uint         Reserved;
}

struct PORT_INFO_2W
{
    const(wchar)* pPortName;
    const(wchar)* pMonitorName;
    const(wchar)* pDescription;
    uint          fPortType;
    uint          Reserved;
}

struct PORT_INFO_3A
{
    uint         dwStatus;
    const(char)* pszStatus;
    uint         dwSeverity;
}

struct PORT_INFO_3W
{
    uint          dwStatus;
    const(wchar)* pszStatus;
    uint          dwSeverity;
}

struct MONITOR_INFO_1A
{
    const(char)* pName;
}

struct MONITOR_INFO_1W
{
    const(wchar)* pName;
}

struct MONITOR_INFO_2A
{
    const(char)* pName;
    const(char)* pEnvironment;
    const(char)* pDLLName;
}

struct MONITOR_INFO_2W
{
    const(wchar)* pName;
    const(wchar)* pEnvironment;
    const(wchar)* pDLLName;
}

struct DATATYPES_INFO_1A
{
    const(char)* pName;
}

struct DATATYPES_INFO_1W
{
    const(wchar)* pName;
}

struct PRINTER_DEFAULTSA
{
    const(char)* pDatatype;
    DEVMODEA*    pDevMode;
    uint         DesiredAccess;
}

struct PRINTER_DEFAULTSW
{
    const(wchar)* pDatatype;
    DEVMODEW*     pDevMode;
    uint          DesiredAccess;
}

struct PRINTER_ENUM_VALUESA
{
    const(char)* pValueName;
    uint         cbValueName;
    uint         dwType;
    ubyte*       pData;
    uint         cbData;
}

struct PRINTER_ENUM_VALUESW
{
    const(wchar)* pValueName;
    uint          cbValueName;
    uint          dwType;
    ubyte*        pData;
    uint          cbData;
}

struct PRINTER_NOTIFY_OPTIONS_TYPE
{
    ushort  Type;
    ushort  Reserved0;
    uint    Reserved1;
    uint    Reserved2;
    uint    Count;
    ushort* pFields;
}

struct PRINTER_NOTIFY_OPTIONS
{
    uint Version;
    uint Flags;
    uint Count;
    PRINTER_NOTIFY_OPTIONS_TYPE* pTypes;
}

struct PRINTER_NOTIFY_INFO_DATA
{
    ushort Type;
    ushort Field;
    uint   Reserved;
    uint   Id;
    union NotifyData
    {
        uint[2] adwData;
        struct Data
        {
            uint  cbBuf;
            void* pBuf;
        }
    }
}

struct PRINTER_NOTIFY_INFO
{
    uint Version;
    uint Flags;
    uint Count;
    PRINTER_NOTIFY_INFO_DATA[1] aData;
}

struct BINARY_CONTAINER
{
    uint   cbBuf;
    ubyte* pData;
}

struct BIDI_DATA
{
    uint dwBidiType;
    union u
    {
        BOOL             bData;
        int              iData;
        const(wchar)*    sData;
        float            fData;
        BINARY_CONTAINER biData;
    }
}

struct BIDI_REQUEST_DATA
{
    uint          dwReqNumber;
    const(wchar)* pSchema;
    BIDI_DATA     data;
}

struct BIDI_REQUEST_CONTAINER
{
    uint                 Version;
    uint                 Flags;
    uint                 Count;
    BIDI_REQUEST_DATA[1] aData;
}

struct BIDI_RESPONSE_DATA
{
    uint          dwResult;
    uint          dwReqNumber;
    const(wchar)* pSchema;
    BIDI_DATA     data;
}

struct BIDI_RESPONSE_CONTAINER
{
    uint Version;
    uint Flags;
    uint Count;
    BIDI_RESPONSE_DATA[1] aData;
}

struct PROVIDOR_INFO_1A
{
    const(char)* pName;
    const(char)* pEnvironment;
    const(char)* pDLLName;
}

struct PROVIDOR_INFO_1W
{
    const(wchar)* pName;
    const(wchar)* pEnvironment;
    const(wchar)* pDLLName;
}

struct PROVIDOR_INFO_2A
{
    const(char)* pOrder;
}

struct PROVIDOR_INFO_2W
{
    const(wchar)* pOrder;
}

struct PRINTER_OPTIONSA
{
    uint cbSize;
    uint dwFlags;
}

struct PRINTER_OPTIONSW
{
    uint cbSize;
    uint dwFlags;
}

struct PRINTER_CONNECTION_INFO_1A
{
    uint         dwFlags;
    const(char)* pszDriverName;
}

struct PRINTER_CONNECTION_INFO_1W
{
    uint          dwFlags;
    const(wchar)* pszDriverName;
}

struct CORE_PRINTER_DRIVERA
{
    GUID      CoreDriverGUID;
    FILETIME  ftDriverDate;
    ulong     dwlDriverVersion;
    byte[260] szPackageID;
}

struct CORE_PRINTER_DRIVERW
{
    GUID        CoreDriverGUID;
    FILETIME    ftDriverDate;
    ulong       dwlDriverVersion;
    ushort[260] szPackageID;
}

struct PrintPropertyValue
{
    EPrintPropertyType ePropertyType;
    union value
    {
        ubyte         propertyByte;
        const(wchar)* propertyString;
        int           propertyInt32;
        long          propertyInt64;
        struct propertyBlob
        {
            uint  cbBuf;
            void* pBuf;
        }
    }
}

struct PrintNamedProperty
{
    ushort*            propertyName;
    PrintPropertyValue propertyValue;
}

struct PrintPropertiesCollection
{
    uint                numberOfProperties;
    PrintNamedProperty* propertiesCollection;
}

struct PRINT_EXECUTION_DATA
{
    PRINT_EXECUTION_CONTEXT context;
    uint clientAppPID;
}

struct MODEMDEVCAPS
{
    uint     dwActualSize;
    uint     dwRequiredSize;
    uint     dwDevSpecificOffset;
    uint     dwDevSpecificSize;
    uint     dwModemProviderVersion;
    uint     dwModemManufacturerOffset;
    uint     dwModemManufacturerSize;
    uint     dwModemModelOffset;
    uint     dwModemModelSize;
    uint     dwModemVersionOffset;
    uint     dwModemVersionSize;
    uint     dwDialOptions;
    uint     dwCallSetupFailTimer;
    uint     dwInactivityTimeout;
    uint     dwSpeakerVolume;
    uint     dwSpeakerMode;
    uint     dwModemOptions;
    uint     dwMaxDTERate;
    uint     dwMaxDCERate;
    ubyte[1] abVariablePortion;
}

struct MODEMSETTINGS
{
    uint     dwActualSize;
    uint     dwRequiredSize;
    uint     dwDevSpecificOffset;
    uint     dwDevSpecificSize;
    uint     dwCallSetupFailTimer;
    uint     dwInactivityTimeout;
    uint     dwSpeakerVolume;
    uint     dwSpeakerMode;
    uint     dwPreferredModemOptions;
    uint     dwNegotiatedModemOptions;
    uint     dwNegotiatedDCERate;
    ubyte[1] abVariablePortion;
}

struct DispatcherQueueOptions
{
    uint dwSize;
    DISPATCHERQUEUE_THREAD_TYPE threadType;
    DISPATCHERQUEUE_THREAD_APARTMENTTYPE apartmentType;
}

struct VDS_STORAGE_IDENTIFIER
{
    VDS_STORAGE_IDENTIFIER_CODE_SET m_CodeSet;
    VDS_STORAGE_IDENTIFIER_TYPE m_Type;
    uint   m_cbIdentifier;
    ubyte* m_rgbIdentifier;
}

struct VDS_STORAGE_DEVICE_ID_DESCRIPTOR
{
    uint m_version;
    uint m_cIdentifiers;
    VDS_STORAGE_IDENTIFIER* m_rgIdentifiers;
}

struct VDS_INTERCONNECT
{
    VDS_INTERCONNECT_ADDRESS_TYPE m_addressType;
    uint   m_cbPort;
    ubyte* m_pbPort;
    uint   m_cbAddress;
    ubyte* m_pbAddress;
}

struct VDS_LUN_INFORMATION
{
    uint                 m_version;
    ubyte                m_DeviceType;
    ubyte                m_DeviceTypeModifier;
    BOOL                 m_bCommandQueueing;
    VDS_STORAGE_BUS_TYPE m_BusType;
    byte*                m_szVendorId;
    byte*                m_szProductId;
    byte*                m_szProductRevision;
    byte*                m_szSerialNumber;
    GUID                 m_diskSignature;
    VDS_STORAGE_DEVICE_ID_DESCRIPTOR m_deviceIdDescriptor;
    uint                 m_cInterconnects;
    VDS_INTERCONNECT*    m_rgInterconnects;
}

struct VDS_PACK_NOTIFICATION
{
    uint ulEvent;
    GUID packId;
}

struct VDS_DISK_NOTIFICATION
{
    uint ulEvent;
    GUID diskId;
}

struct VDS_VOLUME_NOTIFICATION
{
    uint ulEvent;
    GUID volumeId;
    GUID plexId;
    uint ulPercentCompleted;
}

struct VDS_PARTITION_NOTIFICATION
{
    uint  ulEvent;
    GUID  diskId;
    ulong ullOffset;
}

struct VDS_SERVICE_NOTIFICATION
{
    uint               ulEvent;
    VDS_RECOVER_ACTION action;
}

struct VDS_DRIVE_LETTER_NOTIFICATION
{
    uint   ulEvent;
    ushort wcLetter;
    GUID   volumeId;
}

struct VDS_FILE_SYSTEM_NOTIFICATION
{
    uint ulEvent;
    GUID volumeId;
    uint dwPercentCompleted;
}

struct VDS_MOUNT_POINT_NOTIFICATION
{
    uint ulEvent;
    GUID volumeId;
}

struct VDS_SUB_SYSTEM_NOTIFICATION
{
    uint ulEvent;
    GUID subSystemId;
}

struct VDS_CONTROLLER_NOTIFICATION
{
    uint ulEvent;
    GUID controllerId;
}

struct VDS_DRIVE_NOTIFICATION
{
    uint ulEvent;
    GUID driveId;
}

struct VDS_LUN_NOTIFICATION
{
    uint ulEvent;
    GUID LunId;
}

struct VDS_PORT_NOTIFICATION
{
    uint ulEvent;
    GUID portId;
}

struct VDS_PORTAL_NOTIFICATION
{
    uint ulEvent;
    GUID portalId;
}

struct VDS_TARGET_NOTIFICATION
{
    uint ulEvent;
    GUID targetId;
}

struct VDS_PORTAL_GROUP_NOTIFICATION
{
    uint ulEvent;
    GUID portalGroupId;
}

struct VDS_NOTIFICATION
{
    VDS_NOTIFICATION_TARGET_TYPE objectType;
    union
    {
        VDS_PACK_NOTIFICATION Pack;
        VDS_DISK_NOTIFICATION Disk;
        VDS_VOLUME_NOTIFICATION Volume;
        VDS_PARTITION_NOTIFICATION Partition;
        VDS_DRIVE_LETTER_NOTIFICATION Letter;
        VDS_FILE_SYSTEM_NOTIFICATION FileSystem;
        VDS_MOUNT_POINT_NOTIFICATION MountPoint;
        VDS_SUB_SYSTEM_NOTIFICATION SubSystem;
        VDS_CONTROLLER_NOTIFICATION Controller;
        VDS_DRIVE_NOTIFICATION Drive;
        VDS_LUN_NOTIFICATION Lun;
        VDS_PORT_NOTIFICATION Port;
        VDS_PORTAL_NOTIFICATION Portal;
        VDS_TARGET_NOTIFICATION Target;
        VDS_PORTAL_GROUP_NOTIFICATION PortalGroup;
        VDS_SERVICE_NOTIFICATION Service;
    }
}

struct VDS_ASYNC_OUTPUT
{
    VDS_ASYNC_OUTPUT_TYPE type;
    union
    {
        struct cp
        {
            ulong ullOffset;
            GUID  volumeId;
        }
        struct cv
        {
            IUnknown pVolumeUnk;
        }
        struct bvp
        {
            IUnknown pVolumeUnk;
        }
        struct sv
        {
            ulong ullReclaimedBytes;
        }
        struct cl
        {
            IUnknown pLunUnk;
        }
        struct ct
        {
            IUnknown pTargetUnk;
        }
        struct cpg
        {
            IUnknown pPortalGroupUnk;
        }
        struct cvd
        {
            IUnknown pVDiskUnk;
        }
    }
}

struct VDS_PATH_ID
{
    ulong ullSourceId;
    ulong ullPathId;
}

struct VDS_WWN
{
    ubyte[8] rguchWwn;
}

struct VDS_IPADDRESS
{
    VDS_IPADDRESS_TYPE type;
    uint               ipv4Address;
    ubyte[16]          ipv6Address;
    uint               ulIpv6FlowInfo;
    uint               ulIpv6ScopeId;
    ushort[257]        wszTextAddress;
    uint               ulPort;
}

struct VDS_ISCSI_IPSEC_KEY
{
    ubyte* pKey;
    uint   ulKeySize;
}

struct VDS_ISCSI_SHARED_SECRET
{
    ubyte* pSharedSecret;
    uint   ulSharedSecretSize;
}

struct VDS_HBAPORT_PROP
{
    GUID               id;
    VDS_WWN            wwnNode;
    VDS_WWN            wwnPort;
    VDS_HBAPORT_TYPE   type;
    VDS_HBAPORT_STATUS status;
    uint               ulPortSpeed;
    uint               ulSupportedPortSpeed;
}

struct VDS_ISCSI_INITIATOR_ADAPTER_PROP
{
    GUID          id;
    const(wchar)* pwszName;
}

struct VDS_ISCSI_INITIATOR_PORTAL_PROP
{
    GUID          id;
    VDS_IPADDRESS address;
    uint          ulPortIndex;
}

struct VDS_PROVIDER_PROP
{
    GUID              id;
    const(wchar)*     pwszName;
    GUID              guidVersionId;
    const(wchar)*     pwszVersion;
    VDS_PROVIDER_TYPE type;
    uint              ulFlags;
    uint              ulStripeSizeFlags;
    short             sRebuildPriority;
}

struct VDS_PATH_INFO
{
    VDS_PATH_ID         pathId;
    VDS_HWPROVIDER_TYPE type;
    VDS_PATH_STATUS     status;
    union
    {
        GUID controllerPortId;
        GUID targetPortalId;
    }
    union
    {
        GUID hbaPortId;
        GUID initiatorAdapterId;
    }
    union
    {
        VDS_HBAPORT_PROP* pHbaPortProp;
        VDS_IPADDRESS*    pInitiatorPortalIpAddr;
    }
}

struct VDS_PATH_POLICY
{
    VDS_PATH_ID pathId;
    BOOL        bPrimaryPath;
    uint        ulWeight;
}

struct VDS_HINTS
{
    ulong ullHintMask;
    ulong ullExpectedMaximumSize;
    uint  ulOptimalReadSize;
    uint  ulOptimalReadAlignment;
    uint  ulOptimalWriteSize;
    uint  ulOptimalWriteAlignment;
    uint  ulMaximumDriveCount;
    uint  ulStripeSize;
    BOOL  bFastCrashRecoveryRequired;
    BOOL  bMostlyReads;
    BOOL  bOptimizeForSequentialReads;
    BOOL  bOptimizeForSequentialWrites;
    BOOL  bRemapEnabled;
    BOOL  bReadBackVerifyEnabled;
    BOOL  bWriteThroughCachingEnabled;
    BOOL  bHardwareChecksumEnabled;
    BOOL  bIsYankable;
    short sRebuildPriority;
}

struct VDS_HINTS2
{
    ulong                ullHintMask;
    ulong                ullExpectedMaximumSize;
    uint                 ulOptimalReadSize;
    uint                 ulOptimalReadAlignment;
    uint                 ulOptimalWriteSize;
    uint                 ulOptimalWriteAlignment;
    uint                 ulMaximumDriveCount;
    uint                 ulStripeSize;
    uint                 ulReserved1;
    uint                 ulReserved2;
    uint                 ulReserved3;
    BOOL                 bFastCrashRecoveryRequired;
    BOOL                 bMostlyReads;
    BOOL                 bOptimizeForSequentialReads;
    BOOL                 bOptimizeForSequentialWrites;
    BOOL                 bRemapEnabled;
    BOOL                 bReadBackVerifyEnabled;
    BOOL                 bWriteThroughCachingEnabled;
    BOOL                 bHardwareChecksumEnabled;
    BOOL                 bIsYankable;
    BOOL                 bAllocateHotSpare;
    BOOL                 bUseMirroredCache;
    BOOL                 bReadCachingEnabled;
    BOOL                 bWriteCachingEnabled;
    BOOL                 bMediaScanEnabled;
    BOOL                 bConsistencyCheckEnabled;
    VDS_STORAGE_BUS_TYPE BusType;
    BOOL                 bReserved1;
    BOOL                 bReserved2;
    BOOL                 bReserved3;
    short                sRebuildPriority;
}

struct VDS_SUB_SYSTEM_PROP
{
    GUID          id;
    const(wchar)* pwszFriendlyName;
    const(wchar)* pwszIdentification;
    uint          ulFlags;
    uint          ulStripeSizeFlags;
    VDS_SUB_SYSTEM_STATUS status;
    VDS_HEALTH    health;
    short         sNumberOfInternalBuses;
    short         sMaxNumberOfSlotsEachBus;
    short         sMaxNumberOfControllers;
    short         sRebuildPriority;
}

struct VDS_SUB_SYSTEM_PROP2
{
    GUID          id;
    const(wchar)* pwszFriendlyName;
    const(wchar)* pwszIdentification;
    uint          ulFlags;
    uint          ulStripeSizeFlags;
    uint          ulSupportedRaidTypeFlags;
    VDS_SUB_SYSTEM_STATUS status;
    VDS_HEALTH    health;
    short         sNumberOfInternalBuses;
    short         sMaxNumberOfSlotsEachBus;
    short         sMaxNumberOfControllers;
    short         sRebuildPriority;
    uint          ulNumberOfEnclosures;
}

struct VDS_CONTROLLER_PROP
{
    GUID          id;
    const(wchar)* pwszFriendlyName;
    const(wchar)* pwszIdentification;
    VDS_CONTROLLER_STATUS status;
    VDS_HEALTH    health;
    short         sNumberOfPorts;
}

struct VDS_DRIVE_PROP
{
    GUID             id;
    ulong            ullSize;
    const(wchar)*    pwszFriendlyName;
    const(wchar)*    pwszIdentification;
    uint             ulFlags;
    VDS_DRIVE_STATUS status;
    VDS_HEALTH       health;
    short            sInternalBusNumber;
    short            sSlotNumber;
}

struct VDS_DRIVE_PROP2
{
    GUID                 id;
    ulong                ullSize;
    const(wchar)*        pwszFriendlyName;
    const(wchar)*        pwszIdentification;
    uint                 ulFlags;
    VDS_DRIVE_STATUS     status;
    VDS_HEALTH           health;
    short                sInternalBusNumber;
    short                sSlotNumber;
    uint                 ulEnclosureNumber;
    VDS_STORAGE_BUS_TYPE busType;
    uint                 ulSpindleSpeed;
}

struct VDS_DRIVE_EXTENT
{
    GUID  id;
    GUID  LunId;
    ulong ullSize;
    BOOL  bUsed;
}

struct VDS_LUN_PROP
{
    GUID                 id;
    ulong                ullSize;
    const(wchar)*        pwszFriendlyName;
    const(wchar)*        pwszIdentification;
    const(wchar)*        pwszUnmaskingList;
    uint                 ulFlags;
    VDS_LUN_TYPE         type;
    VDS_LUN_STATUS       status;
    VDS_HEALTH           health;
    VDS_TRANSITION_STATE TransitionState;
    short                sRebuildPriority;
}

struct VDS_LUN_PLEX_PROP
{
    GUID                 id;
    ulong                ullSize;
    VDS_LUN_PLEX_TYPE    type;
    VDS_LUN_PLEX_STATUS  status;
    VDS_HEALTH           health;
    VDS_TRANSITION_STATE TransitionState;
    uint                 ulFlags;
    uint                 ulStripeSize;
    short                sRebuildPriority;
}

struct VDS_PORT_PROP
{
    GUID            id;
    const(wchar)*   pwszFriendlyName;
    const(wchar)*   pwszIdentification;
    VDS_PORT_STATUS status;
}

struct VDS_ISCSI_PORTAL_PROP
{
    GUID          id;
    VDS_IPADDRESS address;
    VDS_ISCSI_PORTAL_STATUS status;
}

struct VDS_ISCSI_TARGET_PROP
{
    GUID          id;
    const(wchar)* pwszIscsiName;
    const(wchar)* pwszFriendlyName;
    BOOL          bChapEnabled;
}

struct VDS_ISCSI_PORTALGROUP_PROP
{
    GUID   id;
    ushort tag;
}

struct VDS_POOL_CUSTOM_ATTRIBUTES
{
    const(wchar)* pwszName;
    const(wchar)* pwszValue;
}

struct VDS_POOL_ATTRIBUTES
{
    ulong                ullAttributeMask;
    VDS_RAID_TYPE        raidType;
    VDS_STORAGE_BUS_TYPE busType;
    const(wchar)*        pwszIntendedUsage;
    BOOL                 bSpinDown;
    BOOL                 bIsThinProvisioned;
    ulong                ullProvisionedSpace;
    BOOL                 bNoSinglePointOfFailure;
    uint                 ulDataRedundancyMax;
    uint                 ulDataRedundancyMin;
    uint                 ulDataRedundancyDefault;
    uint                 ulPackageRedundancyMax;
    uint                 ulPackageRedundancyMin;
    uint                 ulPackageRedundancyDefault;
    uint                 ulStripeSize;
    uint                 ulStripeSizeMax;
    uint                 ulStripeSizeMin;
    uint                 ulDefaultStripeSize;
    uint                 ulNumberOfColumns;
    uint                 ulNumberOfColumnsMax;
    uint                 ulNumberOfColumnsMin;
    uint                 ulDefaultNumberofColumns;
    uint                 ulDataAvailabilityHint;
    uint                 ulAccessRandomnessHint;
    uint                 ulAccessDirectionHint;
    uint                 ulAccessSizeHint;
    uint                 ulAccessLatencyHint;
    uint                 ulAccessBandwidthWeightHint;
    uint                 ulStorageCostHint;
    uint                 ulStorageEfficiencyHint;
    uint                 ulNumOfCustomAttributes;
    VDS_POOL_CUSTOM_ATTRIBUTES* pPoolCustomAttributes;
    BOOL                 bReserved1;
    BOOL                 bReserved2;
    uint                 ulReserved1;
    uint                 ulReserved2;
    ulong                ullReserved1;
    ulong                ullReserved2;
}

struct VDS_STORAGE_POOL_PROP
{
    GUID          id;
    VDS_STORAGE_POOL_STATUS status;
    VDS_HEALTH    health;
    VDS_STORAGE_POOL_TYPE type;
    const(wchar)* pwszName;
    const(wchar)* pwszDescription;
    ulong         ullTotalConsumedSpace;
    ulong         ullTotalManagedSpace;
    ulong         ullRemainingFreeSpace;
}

struct VDS_STORAGE_POOL_DRIVE_EXTENT
{
    GUID  id;
    ulong ullSize;
    BOOL  bUsed;
}

struct VSS_SNAPSHOT_PROP
{
    GUID               m_SnapshotId;
    GUID               m_SnapshotSetId;
    int                m_lSnapshotsCount;
    ushort*            m_pwszSnapshotDeviceObject;
    ushort*            m_pwszOriginalVolumeName;
    ushort*            m_pwszOriginatingMachine;
    ushort*            m_pwszServiceMachine;
    ushort*            m_pwszExposedName;
    ushort*            m_pwszExposedPath;
    GUID               m_ProviderId;
    int                m_lSnapshotAttributes;
    long               m_tsCreationTimestamp;
    VSS_SNAPSHOT_STATE m_eStatus;
}

struct VSS_PROVIDER_PROP
{
    GUID              m_ProviderId;
    ushort*           m_pwszProviderName;
    VSS_PROVIDER_TYPE m_eProviderType;
    ushort*           m_pwszProviderVersion;
    GUID              m_ProviderVersionId;
    GUID              m_ClassId;
}

union __MIDL___MIDL_itf_vss_0000_0000_0001
{
    VSS_SNAPSHOT_PROP Snap;
    VSS_PROVIDER_PROP Prov;
}

struct VSS_OBJECT_PROP
{
    VSS_OBJECT_TYPE Type;
    __MIDL___MIDL_itf_vss_0000_0000_0001 Obj;
}

struct IVssExamineWriterMetadata
{
}

struct VSS_VOLUME_PROP
{
    ushort* m_pwszVolumeName;
    ushort* m_pwszVolumeDisplayName;
}

struct VSS_DIFF_VOLUME_PROP
{
    ushort* m_pwszVolumeName;
    ushort* m_pwszVolumeDisplayName;
    long    m_llVolumeFreeSpace;
    long    m_llVolumeTotalSpace;
}

struct VSS_DIFF_AREA_PROP
{
    ushort* m_pwszVolumeName;
    ushort* m_pwszDiffAreaVolumeName;
    long    m_llMaximumDiffSpace;
    long    m_llAllocatedDiffSpace;
    long    m_llUsedDiffSpace;
}

union __MIDL___MIDL_itf_vsmgmt_0000_0000_0001
{
    VSS_VOLUME_PROP      Vol;
    VSS_DIFF_VOLUME_PROP DiffVol;
    VSS_DIFF_AREA_PROP   DiffArea;
}

struct VSS_MGMT_OBJECT_PROP
{
    VSS_MGMT_OBJECT_TYPE Type;
    __MIDL___MIDL_itf_vsmgmt_0000_0000_0001 Obj;
}

struct VSS_VOLUME_PROTECTION_INFO
{
    VSS_PROTECTION_LEVEL m_protectionLevel;
    BOOL                 m_volumeIsOfflineForProtection;
    VSS_PROTECTION_FAULT m_protectionFault;
    int                  m_failureStatus;
    BOOL                 m_volumeHasUnusedDiffArea;
    uint                 m_reserved;
}

struct IDDVideoPortContainer
{
}

struct IDirectDrawVideoPort
{
}

struct IDirectDrawVideoPortNotify
{
}

struct IDDVideoPortContainerVtbl
{
}

struct IDirectDrawVideoPortVtbl
{
}

struct IDirectDrawVideoPortNotifyVtbl
{
}

struct DDVIDEOPORTSTATUS
{
    uint               dwSize;
    BOOL               bInUse;
    uint               dwFlags;
    uint               dwReserved1;
    DDVIDEOPORTCONNECT VideoPortType;
    size_t             dwReserved2;
    size_t             dwReserved3;
}

struct DDVIDEOPORTNOTIFY
{
    LARGE_INTEGER ApproximateTimeStamp;
    int           lField;
    uint          dwSurfaceIndex;
    int           lDone;
}

struct _DD_DESTROYDRIVERDATA
{
}

struct _DD_SETMODEDATA
{
}

struct _DD_GETVPORTAUTOFLIPSURFACEDATA
{
}

struct DD_MORECAPS
{
    uint dwSize;
    uint dwAlphaCaps;
    uint dwSVBAlphaCaps;
    uint dwVSBAlphaCaps;
    uint dwSSBAlphaCaps;
    uint dwFilterCaps;
    uint dwSVBFilterCaps;
    uint dwVSBFilterCaps;
    uint dwSSBFilterCaps;
}

struct DDNTCORECAPS
{
    uint    dwSize;
    uint    dwCaps;
    uint    dwCaps2;
    uint    dwCKeyCaps;
    uint    dwFXCaps;
    uint    dwFXAlphaCaps;
    uint    dwPalCaps;
    uint    dwSVCaps;
    uint    dwAlphaBltConstBitDepths;
    uint    dwAlphaBltPixelBitDepths;
    uint    dwAlphaBltSurfaceBitDepths;
    uint    dwAlphaOverlayConstBitDepths;
    uint    dwAlphaOverlayPixelBitDepths;
    uint    dwAlphaOverlaySurfaceBitDepths;
    uint    dwZBufferBitDepths;
    uint    dwVidMemTotal;
    uint    dwVidMemFree;
    uint    dwMaxVisibleOverlays;
    uint    dwCurrVisibleOverlays;
    uint    dwNumFourCCCodes;
    uint    dwAlignBoundarySrc;
    uint    dwAlignSizeSrc;
    uint    dwAlignBoundaryDest;
    uint    dwAlignSizeDest;
    uint    dwAlignStrideAlign;
    uint[8] dwRops;
    DDSCAPS ddsCaps;
    uint    dwMinOverlayStretch;
    uint    dwMaxOverlayStretch;
    uint    dwMinLiveVideoStretch;
    uint    dwMaxLiveVideoStretch;
    uint    dwMinHwCodecStretch;
    uint    dwMaxHwCodecStretch;
    uint    dwReserved1;
    uint    dwReserved2;
    uint    dwReserved3;
    uint    dwSVBCaps;
    uint    dwSVBCKeyCaps;
    uint    dwSVBFXCaps;
    uint[8] dwSVBRops;
    uint    dwVSBCaps;
    uint    dwVSBCKeyCaps;
    uint    dwVSBFXCaps;
    uint[8] dwVSBRops;
    uint    dwSSBCaps;
    uint    dwSSBCKeyCaps;
    uint    dwSSBFXCaps;
    uint[8] dwSSBRops;
    uint    dwMaxVideoPorts;
    uint    dwCurrVideoPorts;
    uint    dwSVBCaps2;
}

struct DD_HALINFO_V4
{
    uint              dwSize;
    VIDEOMEMORYINFO   vmiData;
    DDNTCORECAPS      ddCaps;
    PDD_GETDRIVERINFO GetDriverInfo;
    uint              dwFlags;
}

struct DD_SETCLIPLISTDATA
{
    DD_DIRECTDRAW_GLOBAL* lpDD;
    DD_SURFACE_LOCAL* lpDDSurface;
    HRESULT           ddRVal;
    void*             SetClipList;
}

struct DD_DRVSETCOLORKEYDATA
{
    DD_SURFACE_LOCAL* lpDDSurface;
    uint              dwFlags;
    DDCOLORKEY        ckNew;
    HRESULT           ddRVal;
    void*             SetColorKey;
}

struct DD_DESTROYDDLOCALDATA
{
    uint                 dwFlags;
    DD_DIRECTDRAW_LOCAL* pDDLcl;
    HRESULT              ddRVal;
}

struct D3DRECT
{
    union
    {
        int x1;
        int lX1;
    }
    union
    {
        int y1;
        int lY1;
    }
    union
    {
        int x2;
        int lX2;
    }
    union
    {
        int y2;
        int lY2;
    }
}

struct D3DVECTOR
{
    union
    {
        float x;
        float dvX;
    }
    union
    {
        float y;
        float dvY;
    }
    union
    {
        float z;
        float dvZ;
    }
}

struct D3DHVERTEX
{
    uint dwFlags;
    union
    {
        float hx;
        float dvHX;
    }
    union
    {
        float hy;
        float dvHY;
    }
    union
    {
        float hz;
        float dvHZ;
    }
}

struct D3DTLVERTEX
{
    union
    {
        float sx;
        float dvSX;
    }
    union
    {
        float sy;
        float dvSY;
    }
    union
    {
        float sz;
        float dvSZ;
    }
    union
    {
        float rhw;
        float dvRHW;
    }
    union
    {
        uint color;
        uint dcColor;
    }
    union
    {
        uint specular;
        uint dcSpecular;
    }
    union
    {
        float tu;
        float dvTU;
    }
    union
    {
        float tv;
        float dvTV;
    }
}

struct D3DLVERTEX
{
    union
    {
        float x;
        float dvX;
    }
    union
    {
        float y;
        float dvY;
    }
    union
    {
        float z;
        float dvZ;
    }
    uint dwReserved;
    union
    {
        uint color;
        uint dcColor;
    }
    union
    {
        uint specular;
        uint dcSpecular;
    }
    union
    {
        float tu;
        float dvTU;
    }
    union
    {
        float tv;
        float dvTV;
    }
}

struct D3DVERTEX
{
    union
    {
        float x;
        float dvX;
    }
    union
    {
        float y;
        float dvY;
    }
    union
    {
        float z;
        float dvZ;
    }
    union
    {
        float nx;
        float dvNX;
    }
    union
    {
        float ny;
        float dvNY;
    }
    union
    {
        float nz;
        float dvNZ;
    }
    union
    {
        float tu;
        float dvTU;
    }
    union
    {
        float tv;
        float dvTV;
    }
}

struct D3DVIEWPORT
{
    uint  dwSize;
    uint  dwX;
    uint  dwY;
    uint  dwWidth;
    uint  dwHeight;
    float dvScaleX;
    float dvScaleY;
    float dvMaxX;
    float dvMaxY;
    float dvMinZ;
    float dvMaxZ;
}

struct D3DVIEWPORT2
{
    uint  dwSize;
    uint  dwX;
    uint  dwY;
    uint  dwWidth;
    uint  dwHeight;
    float dvClipX;
    float dvClipY;
    float dvClipWidth;
    float dvClipHeight;
    float dvMinZ;
    float dvMaxZ;
}

struct D3DVIEWPORT7
{
    uint  dwX;
    uint  dwY;
    uint  dwWidth;
    uint  dwHeight;
    float dvMinZ;
    float dvMaxZ;
}

struct D3DTRANSFORMDATA
{
    uint        dwSize;
    void*       lpIn;
    uint        dwInSize;
    void*       lpOut;
    uint        dwOutSize;
    D3DHVERTEX* lpHOut;
    uint        dwClip;
    uint        dwClipIntersection;
    uint        dwClipUnion;
    D3DRECT     drExtent;
}

struct D3DLIGHTINGELEMENT
{
    D3DVECTOR dvPosition;
    D3DVECTOR dvNormal;
}

struct D3DMATERIAL
{
    uint dwSize;
    union
    {
        DXGI_RGBA diffuse;
        DXGI_RGBA dcvDiffuse;
    }
    union
    {
        DXGI_RGBA ambient;
        DXGI_RGBA dcvAmbient;
    }
    union
    {
        DXGI_RGBA specular;
        DXGI_RGBA dcvSpecular;
    }
    union
    {
        DXGI_RGBA emissive;
        DXGI_RGBA dcvEmissive;
    }
    union
    {
        float power;
        float dvPower;
    }
    uint hTexture;
    uint dwRampSize;
}

struct D3DMATERIAL7
{
    union
    {
        DXGI_RGBA diffuse;
        DXGI_RGBA dcvDiffuse;
    }
    union
    {
        DXGI_RGBA ambient;
        DXGI_RGBA dcvAmbient;
    }
    union
    {
        DXGI_RGBA specular;
        DXGI_RGBA dcvSpecular;
    }
    union
    {
        DXGI_RGBA emissive;
        DXGI_RGBA dcvEmissive;
    }
    union
    {
        float power;
        float dvPower;
    }
}

struct D3DLIGHT
{
    uint         dwSize;
    D3DLIGHTTYPE dltType;
    DXGI_RGBA    dcvColor;
    D3DVECTOR    dvPosition;
    D3DVECTOR    dvDirection;
    float        dvRange;
    float        dvFalloff;
    float        dvAttenuation0;
    float        dvAttenuation1;
    float        dvAttenuation2;
    float        dvTheta;
    float        dvPhi;
}

struct D3DLIGHT7
{
    D3DLIGHTTYPE dltType;
    DXGI_RGBA    dcvDiffuse;
    DXGI_RGBA    dcvSpecular;
    DXGI_RGBA    dcvAmbient;
    D3DVECTOR    dvPosition;
    D3DVECTOR    dvDirection;
    float        dvRange;
    float        dvFalloff;
    float        dvAttenuation0;
    float        dvAttenuation1;
    float        dvAttenuation2;
    float        dvTheta;
    float        dvPhi;
}

struct D3DLIGHT2
{
    uint         dwSize;
    D3DLIGHTTYPE dltType;
    DXGI_RGBA    dcvColor;
    D3DVECTOR    dvPosition;
    D3DVECTOR    dvDirection;
    float        dvRange;
    float        dvFalloff;
    float        dvAttenuation0;
    float        dvAttenuation1;
    float        dvAttenuation2;
    float        dvTheta;
    float        dvPhi;
    uint         dwFlags;
}

struct D3DLIGHTDATA
{
    uint                dwSize;
    D3DLIGHTINGELEMENT* lpIn;
    uint                dwInSize;
    D3DTLVERTEX*        lpOut;
    uint                dwOutSize;
}

struct D3DINSTRUCTION
{
    ubyte  bOpcode;
    ubyte  bSize;
    ushort wCount;
}

struct D3DTEXTURELOAD
{
    uint hDestTexture;
    uint hSrcTexture;
}

struct D3DPICKRECORD
{
    ubyte bOpcode;
    ubyte bPad;
    uint  dwOffset;
    float dvZ;
}

struct D3DLINEPATTERN
{
    ushort wRepeatFactor;
    ushort wLinePattern;
}

struct D3DSTATE
{
    union
    {
        D3DTRANSFORMSTATETYPE dtstTransformStateType;
        D3DLIGHTSTATETYPE  dlstLightStateType;
        D3DRENDERSTATETYPE drstRenderStateType;
    }
    union
    {
        uint[1]  dwArg;
        float[1] dvArg;
    }
}

struct D3DMATRIXLOAD
{
    uint hDestMatrix;
    uint hSrcMatrix;
}

struct D3DMATRIXMULTIPLY
{
    uint hDestMatrix;
    uint hSrcMatrix1;
    uint hSrcMatrix2;
}

struct D3DPROCESSVERTICES
{
    uint   dwFlags;
    ushort wStart;
    ushort wDest;
    uint   dwCount;
    uint   dwReserved;
}

struct D3DTRIANGLE
{
    union
    {
        ushort v1;
        ushort wV1;
    }
    union
    {
        ushort v2;
        ushort wV2;
    }
    union
    {
        ushort v3;
        ushort wV3;
    }
    ushort wFlags;
}

struct D3DLINE
{
    union
    {
        ushort v1;
        ushort wV1;
    }
    union
    {
        ushort v2;
        ushort wV2;
    }
}

struct D3DSPAN
{
    ushort wCount;
    ushort wFirst;
}

struct D3DPOINT
{
    ushort wCount;
    ushort wFirst;
}

struct D3DBRANCH
{
    uint dwMask;
    uint dwValue;
    BOOL bNegate;
    uint dwOffset;
}

struct D3DSTATUS
{
    uint    dwFlags;
    uint    dwStatus;
    D3DRECT drExtent;
}

struct D3DCLIPSTATUS
{
    uint  dwFlags;
    uint  dwStatus;
    float minx;
    float maxx;
    float miny;
    float maxy;
    float minz;
    float maxz;
}

struct D3DSTATS
{
    uint dwSize;
    uint dwTrianglesDrawn;
    uint dwLinesDrawn;
    uint dwPointsDrawn;
    uint dwSpansDrawn;
    uint dwVerticesProcessed;
}

struct D3DEXECUTEDATA
{
    uint      dwSize;
    uint      dwVertexOffset;
    uint      dwVertexCount;
    uint      dwInstructionOffset;
    uint      dwInstructionLength;
    uint      dwHVertexOffset;
    D3DSTATUS dsStatus;
}

struct D3DVERTEXBUFFERDESC
{
    uint dwSize;
    uint dwCaps;
    uint dwFVF;
    uint dwNumVertices;
}

struct D3DDP_PTRSTRIDE
{
    void* lpvData;
    uint  dwStride;
}

struct D3DDRAWPRIMITIVESTRIDEDDATA
{
    D3DDP_PTRSTRIDE    position;
    D3DDP_PTRSTRIDE    normal;
    D3DDP_PTRSTRIDE    diffuse;
    D3DDP_PTRSTRIDE    specular;
    D3DDP_PTRSTRIDE[8] textureCoords;
}

struct D3DTRANSFORMCAPS
{
    uint dwSize;
    uint dwCaps;
}

struct D3DLIGHTINGCAPS
{
    uint dwSize;
    uint dwCaps;
    uint dwLightingModel;
    uint dwNumLights;
}

struct _D3DPrimCaps
{
    uint dwSize;
    uint dwMiscCaps;
    uint dwRasterCaps;
    uint dwZCmpCaps;
    uint dwSrcBlendCaps;
    uint dwDestBlendCaps;
    uint dwAlphaCmpCaps;
    uint dwShadeCaps;
    uint dwTextureCaps;
    uint dwTextureFilterCaps;
    uint dwTextureBlendCaps;
    uint dwTextureAddressCaps;
    uint dwStippleWidth;
    uint dwStippleHeight;
}

struct _D3DDeviceDesc
{
    uint             dwSize;
    uint             dwFlags;
    uint             dcmColorModel;
    uint             dwDevCaps;
    D3DTRANSFORMCAPS dtcTransformCaps;
    BOOL             bClipping;
    D3DLIGHTINGCAPS  dlcLightingCaps;
    _D3DPrimCaps     dpcLineCaps;
    _D3DPrimCaps     dpcTriCaps;
    uint             dwDeviceRenderBitDepth;
    uint             dwDeviceZBufferBitDepth;
    uint             dwMaxBufferSize;
    uint             dwMaxVertexCount;
    uint             dwMinTextureWidth;
    uint             dwMinTextureHeight;
    uint             dwMaxTextureWidth;
    uint             dwMaxTextureHeight;
    uint             dwMinStippleWidth;
    uint             dwMaxStippleWidth;
    uint             dwMinStippleHeight;
    uint             dwMaxStippleHeight;
    uint             dwMaxTextureRepeat;
    uint             dwMaxTextureAspectRatio;
    uint             dwMaxAnisotropy;
    float            dvGuardBandLeft;
    float            dvGuardBandTop;
    float            dvGuardBandRight;
    float            dvGuardBandBottom;
    float            dvExtentsAdjust;
    uint             dwStencilCaps;
    uint             dwFVFCaps;
    uint             dwTextureOpCaps;
    ushort           wMaxTextureBlendStages;
    ushort           wMaxSimultaneousTextures;
}

struct _D3DDeviceDesc7
{
    uint         dwDevCaps;
    _D3DPrimCaps dpcLineCaps;
    _D3DPrimCaps dpcTriCaps;
    uint         dwDeviceRenderBitDepth;
    uint         dwDeviceZBufferBitDepth;
    uint         dwMinTextureWidth;
    uint         dwMinTextureHeight;
    uint         dwMaxTextureWidth;
    uint         dwMaxTextureHeight;
    uint         dwMaxTextureRepeat;
    uint         dwMaxTextureAspectRatio;
    uint         dwMaxAnisotropy;
    float        dvGuardBandLeft;
    float        dvGuardBandTop;
    float        dvGuardBandRight;
    float        dvGuardBandBottom;
    float        dvExtentsAdjust;
    uint         dwStencilCaps;
    uint         dwFVFCaps;
    uint         dwTextureOpCaps;
    ushort       wMaxTextureBlendStages;
    ushort       wMaxSimultaneousTextures;
    uint         dwMaxActiveLights;
    float        dvMaxVertexW;
    GUID         deviceGUID;
    ushort       wMaxUserClipPlanes;
    ushort       wMaxVertexBlendMatrices;
    uint         dwVertexProcessingCaps;
    uint         dwReserved1;
    uint         dwReserved2;
    uint         dwReserved3;
    uint         dwReserved4;
}

struct D3DFINDDEVICESEARCH
{
    uint         dwSize;
    uint         dwFlags;
    BOOL         bHardware;
    uint         dcmColorModel;
    GUID         guid;
    uint         dwCaps;
    _D3DPrimCaps dpcPrimCaps;
}

struct D3DFINDDEVICERESULT
{
    uint           dwSize;
    GUID           guid;
    _D3DDeviceDesc ddHwDesc;
    _D3DDeviceDesc ddSwDesc;
}

struct _D3DExecuteBufferDesc
{
    uint  dwSize;
    uint  dwFlags;
    uint  dwCaps;
    uint  dwBufferSize;
    void* lpData;
}

struct D3DDEVINFO_TEXTUREMANAGER
{
    BOOL bThrashing;
    uint dwApproxBytesDownloaded;
    uint dwNumEvicts;
    uint dwNumVidCreates;
    uint dwNumTexturesUsed;
    uint dwNumUsedTexInVid;
    uint dwWorkingSet;
    uint dwWorkingSetBytes;
    uint dwTotalManaged;
    uint dwTotalBytes;
    uint dwLastPri;
}

struct D3DDEVINFO_TEXTURING
{
    uint dwNumLoads;
    uint dwApproxBytesLoaded;
    uint dwNumPreLoads;
    uint dwNumSet;
    uint dwNumCreates;
    uint dwNumDestroys;
    uint dwNumSetPriorities;
    uint dwNumSetLODs;
    uint dwNumLocks;
    uint dwNumGetDCs;
}

struct _D3DNTHALDeviceDesc_V1
{
    uint             dwSize;
    uint             dwFlags;
    uint             dcmColorModel;
    uint             dwDevCaps;
    D3DTRANSFORMCAPS dtcTransformCaps;
    BOOL             bClipping;
    D3DLIGHTINGCAPS  dlcLightingCaps;
    _D3DPrimCaps     dpcLineCaps;
    _D3DPrimCaps     dpcTriCaps;
    uint             dwDeviceRenderBitDepth;
    uint             dwDeviceZBufferBitDepth;
    uint             dwMaxBufferSize;
    uint             dwMaxVertexCount;
}

struct _D3DNTHALDeviceDesc_V2
{
    uint             dwSize;
    uint             dwFlags;
    uint             dcmColorModel;
    uint             dwDevCaps;
    D3DTRANSFORMCAPS dtcTransformCaps;
    BOOL             bClipping;
    D3DLIGHTINGCAPS  dlcLightingCaps;
    _D3DPrimCaps     dpcLineCaps;
    _D3DPrimCaps     dpcTriCaps;
    uint             dwDeviceRenderBitDepth;
    uint             dwDeviceZBufferBitDepth;
    uint             dwMaxBufferSize;
    uint             dwMaxVertexCount;
    uint             dwMinTextureWidth;
    uint             dwMinTextureHeight;
    uint             dwMaxTextureWidth;
    uint             dwMaxTextureHeight;
    uint             dwMinStippleWidth;
    uint             dwMaxStippleWidth;
    uint             dwMinStippleHeight;
    uint             dwMaxStippleHeight;
}

struct _D3DNTDeviceDesc_V3
{
    uint             dwSize;
    uint             dwFlags;
    uint             dcmColorModel;
    uint             dwDevCaps;
    D3DTRANSFORMCAPS dtcTransformCaps;
    BOOL             bClipping;
    D3DLIGHTINGCAPS  dlcLightingCaps;
    _D3DPrimCaps     dpcLineCaps;
    _D3DPrimCaps     dpcTriCaps;
    uint             dwDeviceRenderBitDepth;
    uint             dwDeviceZBufferBitDepth;
    uint             dwMaxBufferSize;
    uint             dwMaxVertexCount;
    uint             dwMinTextureWidth;
    uint             dwMinTextureHeight;
    uint             dwMaxTextureWidth;
    uint             dwMaxTextureHeight;
    uint             dwMinStippleWidth;
    uint             dwMaxStippleWidth;
    uint             dwMinStippleHeight;
    uint             dwMaxStippleHeight;
    uint             dwMaxTextureRepeat;
    uint             dwMaxTextureAspectRatio;
    uint             dwMaxAnisotropy;
    float            dvGuardBandLeft;
    float            dvGuardBandTop;
    float            dvGuardBandRight;
    float            dvGuardBandBottom;
    float            dvExtentsAdjust;
    uint             dwStencilCaps;
    uint             dwFVFCaps;
    uint             dwTextureOpCaps;
    ushort           wMaxTextureBlendStages;
    ushort           wMaxSimultaneousTextures;
}

struct D3DNTHAL_GLOBALDRIVERDATA
{
    uint           dwSize;
    _D3DNTHALDeviceDesc_V1 hwCaps;
    uint           dwNumVertices;
    uint           dwNumClipVertices;
    uint           dwNumTextureFormats;
    DDSURFACEDESC* lpTextureFormats;
}

struct D3DNTHAL_D3DDX6EXTENDEDCAPS
{
    uint   dwSize;
    uint   dwMinTextureWidth;
    uint   dwMaxTextureWidth;
    uint   dwMinTextureHeight;
    uint   dwMaxTextureHeight;
    uint   dwMinStippleWidth;
    uint   dwMaxStippleWidth;
    uint   dwMinStippleHeight;
    uint   dwMaxStippleHeight;
    uint   dwMaxTextureRepeat;
    uint   dwMaxTextureAspectRatio;
    uint   dwMaxAnisotropy;
    float  dvGuardBandLeft;
    float  dvGuardBandTop;
    float  dvGuardBandRight;
    float  dvGuardBandBottom;
    float  dvExtentsAdjust;
    uint   dwStencilCaps;
    uint   dwFVFCaps;
    uint   dwTextureOpCaps;
    ushort wMaxTextureBlendStages;
    ushort wMaxSimultaneousTextures;
}

struct D3DNTHAL_D3DEXTENDEDCAPS
{
    uint   dwSize;
    uint   dwMinTextureWidth;
    uint   dwMaxTextureWidth;
    uint   dwMinTextureHeight;
    uint   dwMaxTextureHeight;
    uint   dwMinStippleWidth;
    uint   dwMaxStippleWidth;
    uint   dwMinStippleHeight;
    uint   dwMaxStippleHeight;
    uint   dwMaxTextureRepeat;
    uint   dwMaxTextureAspectRatio;
    uint   dwMaxAnisotropy;
    float  dvGuardBandLeft;
    float  dvGuardBandTop;
    float  dvGuardBandRight;
    float  dvGuardBandBottom;
    float  dvExtentsAdjust;
    uint   dwStencilCaps;
    uint   dwFVFCaps;
    uint   dwTextureOpCaps;
    ushort wMaxTextureBlendStages;
    ushort wMaxSimultaneousTextures;
    uint   dwMaxActiveLights;
    float  dvMaxVertexW;
    ushort wMaxUserClipPlanes;
    ushort wMaxVertexBlendMatrices;
    uint   dwVertexProcessingCaps;
    uint   dwReserved1;
    uint   dwReserved2;
    uint   dwReserved3;
    uint   dwReserved4;
}

struct D3DNTHAL_CONTEXTCREATEDATA
{
    union
    {
        DD_DIRECTDRAW_GLOBAL* lpDDGbl;
        DD_DIRECTDRAW_LOCAL* lpDDLcl;
    }
    union
    {
        DD_SURFACE_LOCAL* lpDDS;
        DD_SURFACE_LOCAL* lpDDSLcl;
    }
    union
    {
        DD_SURFACE_LOCAL* lpDDSZ;
        DD_SURFACE_LOCAL* lpDDSZLcl;
    }
    uint    dwPID;
    size_t  dwhContext;
    HRESULT ddrval;
}

struct D3DNTHAL_CONTEXTDESTROYDATA
{
    size_t  dwhContext;
    HRESULT ddrval;
}

struct D3DNTHAL_CONTEXTDESTROYALLDATA
{
    uint    dwPID;
    HRESULT ddrval;
}

struct D3DNTHAL_SCENECAPTUREDATA
{
    size_t  dwhContext;
    uint    dwFlag;
    HRESULT ddrval;
}

struct D3DNTHAL_TEXTURECREATEDATA
{
    size_t  dwhContext;
    HANDLE  hDDS;
    size_t  dwHandle;
    HRESULT ddrval;
}

struct D3DNTHAL_TEXTUREDESTROYDATA
{
    size_t  dwhContext;
    size_t  dwHandle;
    HRESULT ddrval;
}

struct D3DNTHAL_TEXTURESWAPDATA
{
    size_t  dwhContext;
    size_t  dwHandle1;
    size_t  dwHandle2;
    HRESULT ddrval;
}

struct D3DNTHAL_TEXTUREGETSURFDATA
{
    size_t  dwhContext;
    HANDLE  hDDS;
    size_t  dwHandle;
    HRESULT ddrval;
}

struct D3DNTHAL_CALLBACKS
{
    uint   dwSize;
    LPD3DNTHAL_CONTEXTCREATECB ContextCreate;
    LPD3DNTHAL_CONTEXTDESTROYCB ContextDestroy;
    LPD3DNTHAL_CONTEXTDESTROYALLCB ContextDestroyAll;
    LPD3DNTHAL_SCENECAPTURECB SceneCapture;
    void*  dwReserved10;
    void*  dwReserved11;
    void*  dwReserved22;
    void*  dwReserved23;
    size_t dwReserved;
    LPD3DNTHAL_TEXTURECREATECB TextureCreate;
    LPD3DNTHAL_TEXTUREDESTROYCB TextureDestroy;
    LPD3DNTHAL_TEXTURESWAPCB TextureSwap;
    LPD3DNTHAL_TEXTUREGETSURFCB TextureGetSurf;
    void*  dwReserved12;
    void*  dwReserved13;
    void*  dwReserved14;
    void*  dwReserved15;
    void*  dwReserved16;
    void*  dwReserved17;
    void*  dwReserved18;
    void*  dwReserved19;
    void*  dwReserved20;
    void*  dwReserved21;
    void*  dwReserved24;
    size_t dwReserved0;
    size_t dwReserved1;
    size_t dwReserved2;
    size_t dwReserved3;
    size_t dwReserved4;
    size_t dwReserved5;
    size_t dwReserved6;
    size_t dwReserved7;
    size_t dwReserved8;
    size_t dwReserved9;
}

struct D3DNTHAL_SETRENDERTARGETDATA
{
    size_t            dwhContext;
    DD_SURFACE_LOCAL* lpDDS;
    DD_SURFACE_LOCAL* lpDDSZ;
    HRESULT           ddrval;
}

struct D3DNTHAL_CALLBACKS2
{
    uint  dwSize;
    uint  dwFlags;
    LPD3DNTHAL_SETRENDERTARGETCB SetRenderTarget;
    void* dwReserved1;
    void* dwReserved2;
    void* dwReserved3;
    void* dwReserved4;
}

struct D3DNTHAL_CLEAR2DATA
{
    size_t   dwhContext;
    uint     dwFlags;
    uint     dwFillColor;
    float    dvFillDepth;
    uint     dwFillStencil;
    D3DRECT* lpRects;
    uint     dwNumRects;
    HRESULT  ddrval;
}

struct D3DNTHAL_VALIDATETEXTURESTAGESTATEDATA
{
    size_t  dwhContext;
    uint    dwFlags;
    size_t  dwReserved;
    uint    dwNumPasses;
    HRESULT ddrval;
}

struct D3DNTHAL_DP2COMMAND
{
    ubyte bCommand;
    ubyte bReserved;
    union
    {
        ushort wPrimitiveCount;
        ushort wStateCount;
    }
}

struct D3DNTHAL_DP2POINTS
{
    ushort wCount;
    ushort wVStart;
}

struct D3DNTHAL_DP2STARTVERTEX
{
    ushort wVStart;
}

struct D3DNTHAL_DP2LINELIST
{
    ushort wVStart;
}

struct D3DNTHAL_DP2INDEXEDLINELIST
{
    ushort wV1;
    ushort wV2;
}

struct D3DNTHAL_DP2LINESTRIP
{
    ushort wVStart;
}

struct D3DNTHAL_DP2INDEXEDLINESTRIP
{
    ushort[2] wV;
}

struct D3DNTHAL_DP2TRIANGLELIST
{
    ushort wVStart;
}

struct D3DNTHAL_DP2INDEXEDTRIANGLELIST
{
    ushort wV1;
    ushort wV2;
    ushort wV3;
    ushort wFlags;
}

struct D3DNTHAL_DP2INDEXEDTRIANGLELIST2
{
    ushort wV1;
    ushort wV2;
    ushort wV3;
}

struct D3DNTHAL_DP2TRIANGLESTRIP
{
    ushort wVStart;
}

struct D3DNTHAL_DP2INDEXEDTRIANGLESTRIP
{
    ushort[3] wV;
}

struct D3DNTHAL_DP2TRIANGLEFAN
{
    ushort wVStart;
}

struct D3DNTHAL_DP2INDEXEDTRIANGLEFAN
{
    ushort[3] wV;
}

struct D3DNTHAL_DP2TRIANGLEFAN_IMM
{
    uint dwEdgeFlags;
}

struct D3DNTHAL_DP2RENDERSTATE
{
    D3DRENDERSTATETYPE RenderState;
    union
    {
        float fState;
        uint  dwState;
    }
}

struct D3DNTHAL_DP2TEXTURESTAGESTATE
{
    ushort wStage;
    ushort TSState;
    uint   dwValue;
}

struct D3DNTHAL_DP2VIEWPORTINFO
{
    uint dwX;
    uint dwY;
    uint dwWidth;
    uint dwHeight;
}

struct D3DNTHAL_DP2WINFO
{
    float dvWNear;
    float dvWFar;
}

struct D3DNTHAL_DP2SETPALETTE
{
    uint dwPaletteHandle;
    uint dwPaletteFlags;
    uint dwSurfaceHandle;
}

struct D3DNTHAL_DP2UPDATEPALETTE
{
    uint   dwPaletteHandle;
    ushort wStartIndex;
    ushort wNumEntries;
}

struct D3DNTHAL_DP2SETRENDERTARGET
{
    uint hRenderTarget;
    uint hZBuffer;
}

struct D3DNTHAL_DP2STATESET
{
    uint              dwOperation;
    uint              dwParam;
    D3DSTATEBLOCKTYPE sbType;
}

struct D3DNTHAL_DP2ZRANGE
{
    float dvMinZ;
    float dvMaxZ;
}

struct D3DNTHAL_DP2SETLIGHT
{
    uint dwIndex;
    union
    {
        uint lightData;
        uint dwDataType;
    }
}

struct D3DNTHAL_DP2SETCLIPPLANE
{
    uint     dwIndex;
    float[4] plane;
}

struct D3DNTHAL_DP2CREATELIGHT
{
    uint dwIndex;
}

struct D3DNTHAL_DP2SETTRANSFORM
{
    D3DTRANSFORMSTATETYPE xfrmType;
    D3DMATRIX matrix;
}

struct D3DNTHAL_DP2EXT
{
    uint dwExtToken;
    uint dwSize;
}

struct D3DNTHAL_DP2TEXBLT
{
    uint  dwDDDestSurface;
    uint  dwDDSrcSurface;
    POINT pDest;
    RECTL rSrc;
    uint  dwFlags;
}

struct D3DNTHAL_DP2SETPRIORITY
{
    uint dwDDDestSurface;
    uint dwPriority;
}

struct D3DNTHAL_DP2CLEAR
{
    uint    dwFlags;
    uint    dwFillColor;
    float   dvFillDepth;
    uint    dwFillStencil;
    RECT[1] Rects;
}

struct D3DNTHAL_DP2SETTEXLOD
{
    uint dwDDSurface;
    uint dwLOD;
}

struct D3DNTHAL_DRAWPRIMITIVES2DATA
{
    size_t            dwhContext;
    uint              dwFlags;
    uint              dwVertexType;
    DD_SURFACE_LOCAL* lpDDCommands;
    uint              dwCommandOffset;
    uint              dwCommandLength;
    union
    {
        DD_SURFACE_LOCAL* lpDDVertex;
        void*             lpVertices;
    }
    uint              dwVertexOffset;
    uint              dwVertexLength;
    uint              dwReqVertexBufSize;
    uint              dwReqCommandBufSize;
    uint*             lpdwRStates;
    union
    {
        uint    dwVertexSize;
        HRESULT ddrval;
    }
    uint              dwErrorOffset;
}

struct D3DNTHAL_CALLBACKS3
{
    uint                dwSize;
    uint                dwFlags;
    LPD3DNTHAL_CLEAR2CB Clear2;
    void*               lpvReserved;
    LPD3DNTHAL_VALIDATETEXTURESTAGESTATECB ValidateTextureStageState;
    LPD3DNTHAL_DRAWPRIMITIVES2CB DrawPrimitives2;
}

struct POINTE
{
    uint x;
    uint y;
}

union FLOAT_LONG
{
    uint e;
    int  l;
}

struct POINTFIX
{
    int x;
    int y;
}

struct RECTFX
{
    int xLeft;
    int yTop;
    int xRight;
    int yBottom;
}

struct HBM__
{
    int unused;
}

struct HDEV__
{
    int unused;
}

struct HSURF__
{
    int unused;
}

struct DHSURF__
{
    int unused;
}

struct DHPDEV__
{
    int unused;
}

struct HDRVOBJ__
{
    int unused;
}

struct LIGATURE
{
    uint          culSize;
    const(wchar)* pwsz;
    uint          chglyph;
    uint[1]       ahglyph;
}

struct FD_LIGATURE
{
    uint        culThis;
    uint        ulType;
    uint        cLigatures;
    LIGATURE[1] alig;
}

struct POINTQF
{
    LARGE_INTEGER x;
    LARGE_INTEGER y;
}

struct CDDDXGK_REDIRBITMAPPRESENTINFO
{
    uint          NumDirtyRects;
    RECT*         DirtyRect;
    uint          NumContexts;
    ptrdiff_t[65] hContext;
    ubyte         bDoNotSynchronizeWithDxContent;
}

struct XFORMOBJ
{
    uint ulReserved;
}

struct HSEMAPHORE__
{
    int unused;
}

struct HFASTMUTEX__
{
    int unused;
}

struct EMFINFO
{
    uint   nSize;
    HDC    hdc;
    ubyte* pvEMF;
    ubyte* pvCurrentRecord;
}

struct DRH_APIBITMAPDATA
{
    SURFOBJ* pso;
    BOOL     b;
}

struct DEVICE_EVENT_MOUNT
{
    uint Version;
    uint Flags;
    uint FileSystemNameLength;
    uint FileSystemNameOffset;
}

struct DEVICE_EVENT_BECOMING_READY
{
    uint Version;
    uint Reason;
    uint Estimated100msToReady;
}

struct DEVICE_EVENT_EXTERNAL_REQUEST
{
    uint          Version;
    uint          DeviceClass;
    ushort        ButtonStatus;
    ushort        Request;
    LARGE_INTEGER SystemTime;
}

struct DEVICE_EVENT_GENERIC_DATA
{
    uint EventNumber;
}

struct DEVICE_EVENT_RBC_DATA
{
    uint  EventNumber;
    ubyte SenseQualifier;
    ubyte SenseCode;
    ubyte SenseKey;
    ubyte Reserved;
    uint  Information;
}

struct GUID_IO_DISK_CLONE_ARRIVAL_INFORMATION
{
    uint DiskNumber;
}

struct DISK_HEALTH_NOTIFICATION_DATA
{
    GUID DeviceGuid;
}

struct DEVPROPKEY
{
    GUID fmtid;
    uint pid;
}

struct DEVPROPCOMPKEY
{
    DEVPROPKEY    Key;
    DEVPROPSTORE  Store;
    const(wchar)* LocaleName;
}

struct DEVPROPERTY
{
    DEVPROPCOMPKEY CompKey;
    uint           Type;
    uint           BufferSize;
    void*          Buffer;
}

struct REDBOOK_DIGITAL_AUDIO_EXTRACTION_INFO
{
    uint Version;
    uint Accurate;
    uint Supported;
    uint AccurateMask0;
}

struct DEV_BROADCAST_HDR
{
    uint dbch_size;
    uint dbch_devicetype;
    uint dbch_reserved;
}

struct VolLockBroadcast
{
    DEV_BROADCAST_HDR vlb_dbh;
    uint              vlb_owner;
    ubyte             vlb_perms;
    ubyte             vlb_lockType;
    ubyte             vlb_drive;
    ubyte             vlb_flags;
}

struct _DEV_BROADCAST_HEADER
{
    uint dbcd_size;
    uint dbcd_devicetype;
    uint dbcd_reserved;
}

struct DEV_BROADCAST_OEM
{
    uint dbco_size;
    uint dbco_devicetype;
    uint dbco_reserved;
    uint dbco_identifier;
    uint dbco_suppfunc;
}

struct DEV_BROADCAST_DEVNODE
{
    uint dbcd_size;
    uint dbcd_devicetype;
    uint dbcd_reserved;
    uint dbcd_devnode;
}

struct DEV_BROADCAST_VOLUME
{
    uint   dbcv_size;
    uint   dbcv_devicetype;
    uint   dbcv_reserved;
    uint   dbcv_unitmask;
    ushort dbcv_flags;
}

struct DEV_BROADCAST_PORT_A
{
    uint    dbcp_size;
    uint    dbcp_devicetype;
    uint    dbcp_reserved;
    byte[1] dbcp_name;
}

struct DEV_BROADCAST_PORT_W
{
    uint      dbcp_size;
    uint      dbcp_devicetype;
    uint      dbcp_reserved;
    ushort[1] dbcp_name;
}

struct DEV_BROADCAST_NET
{
    uint dbcn_size;
    uint dbcn_devicetype;
    uint dbcn_reserved;
    uint dbcn_resource;
    uint dbcn_flags;
}

struct DEV_BROADCAST_DEVICEINTERFACE_A
{
    uint    dbcc_size;
    uint    dbcc_devicetype;
    uint    dbcc_reserved;
    GUID    dbcc_classguid;
    byte[1] dbcc_name;
}

struct DEV_BROADCAST_DEVICEINTERFACE_W
{
    uint      dbcc_size;
    uint      dbcc_devicetype;
    uint      dbcc_reserved;
    GUID      dbcc_classguid;
    ushort[1] dbcc_name;
}

struct DEV_BROADCAST_HANDLE
{
    uint     dbch_size;
    uint     dbch_devicetype;
    uint     dbch_reserved;
    HANDLE   dbch_handle;
    void*    dbch_hdevnotify;
    GUID     dbch_eventguid;
    int      dbch_nameoffset;
    ubyte[1] dbch_data;
}

struct DEV_BROADCAST_HANDLE32
{
    uint     dbch_size;
    uint     dbch_devicetype;
    uint     dbch_reserved;
    uint     dbch_handle;
    uint     dbch_hdevnotify;
    GUID     dbch_eventguid;
    int      dbch_nameoffset;
    ubyte[1] dbch_data;
}

struct DEV_BROADCAST_HANDLE64
{
    uint     dbch_size;
    uint     dbch_devicetype;
    uint     dbch_reserved;
    ulong    dbch_handle;
    ulong    dbch_hdevnotify;
    GUID     dbch_eventguid;
    int      dbch_nameoffset;
    ubyte[1] dbch_data;
}

struct _DEV_BROADCAST_USERDEFINED
{
    DEV_BROADCAST_HDR dbud_dbh;
    byte[1]           dbud_szName;
}

struct PWM_CONTROLLER_INFO
{
    size_t Size;
    uint   PinCount;
    ulong  MinimumPeriod;
    ulong  MaximumPeriod;
}

struct PWM_CONTROLLER_GET_ACTUAL_PERIOD_OUTPUT
{
    ulong ActualPeriod;
}

struct PWM_CONTROLLER_SET_DESIRED_PERIOD_INPUT
{
    ulong DesiredPeriod;
}

struct PWM_CONTROLLER_SET_DESIRED_PERIOD_OUTPUT
{
    ulong ActualPeriod;
}

struct PWM_PIN_GET_ACTIVE_DUTY_CYCLE_PERCENTAGE_OUTPUT
{
    ulong Percentage;
}

struct PWM_PIN_SET_ACTIVE_DUTY_CYCLE_PERCENTAGE_INPUT
{
    ulong Percentage;
}

struct PWM_PIN_GET_POLARITY_OUTPUT
{
    PWM_POLARITY Polarity;
}

struct PWM_PIN_SET_POLARITY_INPUT
{
    PWM_POLARITY Polarity;
}

struct PWM_PIN_IS_STARTED_OUTPUT
{
    ubyte IsStarted;
}

struct AtlThunkData_t
{
}

struct ENCLAVE_IDENTITY
{
align (1):
    ubyte[32] OwnerId;
    ubyte[32] UniqueId;
    ubyte[32] AuthorId;
    ubyte[16] FamilyId;
    ubyte[16] ImageId;
    uint      EnclaveSvn;
    uint      SecureKernelSvn;
    uint      PlatformSvn;
    uint      Flags;
    uint      SigningLevel;
    uint      EnclaveType;
}

struct VBS_ENCLAVE_REPORT_PKG_HEADER
{
align (1):
    uint PackageSize;
    uint Version;
    uint SignatureScheme;
    uint SignedStatementSize;
    uint SignatureSize;
    uint Reserved;
}

struct VBS_ENCLAVE_REPORT
{
align (1):
    uint             ReportSize;
    uint             ReportVersion;
    ubyte[64]        EnclaveData;
    ENCLAVE_IDENTITY EnclaveIdentity;
}

struct VBS_ENCLAVE_REPORT_VARDATA_HEADER
{
align (1):
    uint DataType;
    uint Size;
}

struct VBS_ENCLAVE_REPORT_MODULE
{
align (1):
    VBS_ENCLAVE_REPORT_VARDATA_HEADER Header;
    ubyte[32] UniqueId;
    ubyte[32] AuthorId;
    ubyte[16] FamilyId;
    ubyte[16] ImageId;
    uint      Svn;
    ushort[1] ModuleName;
}

struct ENCLAVE_INFORMATION
{
    uint             EnclaveType;
    uint             Reserved;
    void*            BaseAddress;
    size_t           Size;
    ENCLAVE_IDENTITY Identity;
}

struct VBS_BASIC_ENCLAVE_THREAD_DESCRIPTOR32
{
    uint[4] ThreadContext;
    uint    EntryPoint;
    uint    StackPointer;
    uint    ExceptionEntryPoint;
    uint    ExceptionStack;
    uint    ExceptionActive;
}

struct VBS_BASIC_ENCLAVE_THREAD_DESCRIPTOR64
{
    ulong[4] ThreadContext;
    ulong    EntryPoint;
    ulong    StackPointer;
    ulong    ExceptionEntryPoint;
    ulong    ExceptionStack;
    uint     ExceptionActive;
}

struct VBS_BASIC_ENCLAVE_EXCEPTION_AMD64
{
    uint      ExceptionCode;
    uint      NumberParameters;
    size_t[3] ExceptionInformation;
    size_t    ExceptionRAX;
    size_t    ExceptionRCX;
    size_t    ExceptionRIP;
    size_t    ExceptionRFLAGS;
    size_t    ExceptionRSP;
}

struct ENCLAVE_VBS_BASIC_KEY_REQUEST
{
    uint RequestSize;
    uint Flags;
    uint EnclaveSVN;
    uint SystemKeyID;
    uint CurrentSystemKeyID;
}

struct VBS_BASIC_ENCLAVE_SYSCALL_PAGE
{
    VBS_BASIC_ENCLAVE_BASIC_CALL_RETURN_FROM_ENCLAVE* ReturnFromEnclave;
    VBS_BASIC_ENCLAVE_BASIC_CALL_RETURN_FROM_EXCEPTION* ReturnFromException;
    VBS_BASIC_ENCLAVE_BASIC_CALL_TERMINATE_THREAD* TerminateThread;
    VBS_BASIC_ENCLAVE_BASIC_CALL_INTERRUPT_THREAD* InterruptThread;
    VBS_BASIC_ENCLAVE_BASIC_CALL_COMMIT_PAGES* CommitPages;
    VBS_BASIC_ENCLAVE_BASIC_CALL_DECOMMIT_PAGES* DecommitPages;
    VBS_BASIC_ENCLAVE_BASIC_CALL_PROTECT_PAGES* ProtectPages;
    VBS_BASIC_ENCLAVE_BASIC_CALL_CREATE_THREAD* CreateThread;
    VBS_BASIC_ENCLAVE_BASIC_CALL_GET_ENCLAVE_INFORMATION* GetEnclaveInformation;
    VBS_BASIC_ENCLAVE_BASIC_CALL_GENERATE_KEY* GenerateKey;
    VBS_BASIC_ENCLAVE_BASIC_CALL_GENERATE_REPORT* GenerateReport;
    VBS_BASIC_ENCLAVE_BASIC_CALL_VERIFY_REPORT* VerifyReport;
    VBS_BASIC_ENCLAVE_BASIC_CALL_GENERATE_RANDOM_DATA* GenerateRandomData;
}

struct GLOBAL_MACHINE_POWER_POLICY
{
    uint               Revision;
    SYSTEM_POWER_STATE LidOpenWakeAc;
    SYSTEM_POWER_STATE LidOpenWakeDc;
    uint               BroadcastCapacityResolution;
}

struct GLOBAL_USER_POWER_POLICY
{
    uint                Revision;
    POWER_ACTION_POLICY PowerButtonAc;
    POWER_ACTION_POLICY PowerButtonDc;
    POWER_ACTION_POLICY SleepButtonAc;
    POWER_ACTION_POLICY SleepButtonDc;
    POWER_ACTION_POLICY LidCloseAc;
    POWER_ACTION_POLICY LidCloseDc;
    SYSTEM_POWER_LEVEL[4] DischargePolicy;
    uint                GlobalFlags;
}

struct GLOBAL_POWER_POLICY
{
    GLOBAL_USER_POWER_POLICY user;
    GLOBAL_MACHINE_POWER_POLICY mach;
}

struct MACHINE_POWER_POLICY
{
    uint                Revision;
    SYSTEM_POWER_STATE  MinSleepAc;
    SYSTEM_POWER_STATE  MinSleepDc;
    SYSTEM_POWER_STATE  ReducedLatencySleepAc;
    SYSTEM_POWER_STATE  ReducedLatencySleepDc;
    uint                DozeTimeoutAc;
    uint                DozeTimeoutDc;
    uint                DozeS4TimeoutAc;
    uint                DozeS4TimeoutDc;
    ubyte               MinThrottleAc;
    ubyte               MinThrottleDc;
    ubyte[2]            pad1;
    POWER_ACTION_POLICY OverThrottledAc;
    POWER_ACTION_POLICY OverThrottledDc;
}

struct MACHINE_PROCESSOR_POWER_POLICY
{
    uint Revision;
    PROCESSOR_POWER_POLICY ProcessorPolicyAc;
    PROCESSOR_POWER_POLICY ProcessorPolicyDc;
}

struct USER_POWER_POLICY
{
    uint                Revision;
    POWER_ACTION_POLICY IdleAc;
    POWER_ACTION_POLICY IdleDc;
    uint                IdleTimeoutAc;
    uint                IdleTimeoutDc;
    ubyte               IdleSensitivityAc;
    ubyte               IdleSensitivityDc;
    ubyte               ThrottlePolicyAc;
    ubyte               ThrottlePolicyDc;
    SYSTEM_POWER_STATE  MaxSleepAc;
    SYSTEM_POWER_STATE  MaxSleepDc;
    uint[2]             Reserved;
    uint                VideoTimeoutAc;
    uint                VideoTimeoutDc;
    uint                SpindownTimeoutAc;
    uint                SpindownTimeoutDc;
    ubyte               OptimizeForPowerAc;
    ubyte               OptimizeForPowerDc;
    ubyte               FanThrottleToleranceAc;
    ubyte               FanThrottleToleranceDc;
    ubyte               ForcedThrottleAc;
    ubyte               ForcedThrottleDc;
}

struct POWER_POLICY
{
    USER_POWER_POLICY    user;
    MACHINE_POWER_POLICY mach;
}

struct DEVICE_NOTIFY_SUBSCRIBE_PARAMETERS
{
    PDEVICE_NOTIFY_CALLBACK_ROUTINE Callback;
    void* Context;
}

struct THERMAL_EVENT
{
    uint          Version;
    uint          Size;
    uint          Type;
    uint          Temperature;
    uint          TripPointTemperature;
    const(wchar)* Initiator;
}

struct BATTERY_QUERY_INFORMATION
{
    uint BatteryTag;
    BATTERY_QUERY_INFORMATION_LEVEL InformationLevel;
    uint AtRate;
}

struct BATTERY_INFORMATION
{
    uint     Capabilities;
    ubyte    Technology;
    ubyte[3] Reserved;
    ubyte[4] Chemistry;
    uint     DesignedCapacity;
    uint     FullChargedCapacity;
    uint     DefaultAlert1;
    uint     DefaultAlert2;
    uint     CriticalBias;
    uint     CycleCount;
}

struct BATTERY_CHARGING_SOURCE
{
    BATTERY_CHARGING_SOURCE_TYPE Type;
    uint MaxCurrent;
}

struct BATTERY_CHARGING_SOURCE_INFORMATION
{
    BATTERY_CHARGING_SOURCE_TYPE Type;
    ubyte SourceOnline;
}

struct BATTERY_SET_INFORMATION
{
    uint     BatteryTag;
    BATTERY_SET_INFORMATION_LEVEL InformationLevel;
    ubyte[1] Buffer;
}

struct BATTERY_CHARGER_STATUS
{
    BATTERY_CHARGING_SOURCE_TYPE Type;
    uint[1] VaData;
}

struct BATTERY_USB_CHARGER_STATUS
{
    BATTERY_CHARGING_SOURCE_TYPE Type;
    uint             Reserved;
    uint             Flags;
    uint             MaxCurrent;
    uint             Voltage;
    USB_CHARGER_PORT PortType;
    ulong            PortId;
    void*            PowerSourceInformation;
    GUID             OemCharger;
}

struct BATTERY_WAIT_STATUS
{
    uint BatteryTag;
    uint Timeout;
    uint PowerState;
    uint LowCapacity;
    uint HighCapacity;
}

struct BATTERY_STATUS
{
    uint PowerState;
    uint Capacity;
    uint Voltage;
    int  Rate;
}

struct BATTERY_MANUFACTURE_DATE
{
    ubyte  Day;
    ubyte  Month;
    ushort Year;
}

struct THERMAL_INFORMATION
{
    uint     ThermalStamp;
    uint     ThermalConstant1;
    uint     ThermalConstant2;
    size_t   Processors;
    uint     SamplingPeriod;
    uint     CurrentTemperature;
    uint     PassiveTripPoint;
    uint     CriticalTripPoint;
    ubyte    ActiveTripPointCount;
    uint[10] ActiveTripPoint;
}

struct THERMAL_WAIT_READ
{
    uint Timeout;
    uint LowTemperature;
    uint HighTemperature;
}

struct THERMAL_POLICY
{
    uint  Version;
    ubyte WaitForUpdate;
    ubyte Hibernate;
    ubyte Critical;
    ubyte ThermalStandby;
    uint  ActivationReasons;
    uint  PassiveLimit;
    uint  ActiveLevel;
    ubyte OverThrottled;
}

struct PROCESSOR_OBJECT_INFO
{
    uint  PhysicalID;
    uint  PBlkAddress;
    ubyte PBlkLength;
}

struct PROCESSOR_OBJECT_INFO_EX
{
    uint  PhysicalID;
    uint  PBlkAddress;
    ubyte PBlkLength;
    uint  InitialApicId;
}

struct WAKE_ALARM_INFORMATION
{
    uint TimerIdentifier;
    uint Timeout;
}

struct ACPI_REAL_TIME
{
    ushort   Year;
    ubyte    Month;
    ubyte    Day;
    ubyte    Hour;
    ubyte    Minute;
    ubyte    Second;
    ubyte    Valid;
    ushort   Milliseconds;
    short    TimeZone;
    ubyte    DayLight;
    ubyte[3] Reserved1;
}

struct INDIRECT_DISPLAY_INFO
{
    LUID DisplayAdapterLuid;
    uint Flags;
    uint NumMonitors;
    uint DisplayAdapterTargetBase;
}

struct VIDEO_VDM
{
    HANDLE ProcessHandle;
}

struct VIDEO_REGISTER_VDM
{
    uint MinimumStateSize;
}

struct VIDEO_MONITOR_DESCRIPTOR
{
    uint     DescriptorSize;
    ubyte[1] Descriptor;
}

struct DXGK_WIN32K_PARAM_DATA
{
    void* PathsArray;
    void* ModesArray;
    uint  NumPathArrayElements;
    uint  NumModeArrayElements;
    uint  SDCFlags;
}

struct VIDEO_WIN32K_CALLBACKS_PARAMS
{
    VIDEO_WIN32K_CALLBACKS_PARAMS_TYPE CalloutType;
    void*  PhysDisp;
    size_t Param;
    int    Status;
    ubyte  LockUserSession;
    ubyte  IsPostDevice;
    ubyte  SurpriseRemoval;
    ubyte  WaitForQueueReady;
}

struct VIDEO_WIN32K_CALLBACKS
{
    void*  PhysDisp;
    PVIDEO_WIN32K_CALLOUT Callout;
    uint   bACPI;
    HANDLE pPhysDeviceObject;
    uint   DualviewFlags;
}

struct VIDEO_DEVICE_SESSION_STATUS
{
    uint bEnable;
    uint bSuccess;
}

struct VIDEO_HARDWARE_STATE_HEADER
{
    uint      Length;
    ubyte[48] PortValue;
    uint      AttribIndexDataState;
    uint      BasicSequencerOffset;
    uint      BasicCrtContOffset;
    uint      BasicGraphContOffset;
    uint      BasicAttribContOffset;
    uint      BasicDacOffset;
    uint      BasicLatchesOffset;
    uint      ExtendedSequencerOffset;
    uint      ExtendedCrtContOffset;
    uint      ExtendedGraphContOffset;
    uint      ExtendedAttribContOffset;
    uint      ExtendedDacOffset;
    uint      ExtendedValidatorStateOffset;
    uint      ExtendedMiscDataOffset;
    uint      PlaneLength;
    uint      Plane1Offset;
    uint      Plane2Offset;
    uint      Plane3Offset;
    uint      Plane4Offset;
    uint      VGAStateFlags;
    uint      DIBOffset;
    uint      DIBBitsPerPixel;
    uint      DIBXResolution;
    uint      DIBYResolution;
    uint      DIBXlatOffset;
    uint      DIBXlatLength;
    uint      VesaInfoOffset;
    void*     FrameBufferData;
}

struct VIDEO_HARDWARE_STATE
{
    VIDEO_HARDWARE_STATE_HEADER* StateHeader;
    uint StateLength;
}

struct VIDEO_NUM_MODES
{
    uint NumModes;
    uint ModeInformationLength;
}

struct VIDEO_MODE
{
    uint RequestedMode;
}

struct VIDEO_MODE_INFORMATION
{
    uint Length;
    uint ModeIndex;
    uint VisScreenWidth;
    uint VisScreenHeight;
    uint ScreenStride;
    uint NumberOfPlanes;
    uint BitsPerPlane;
    uint Frequency;
    uint XMillimeter;
    uint YMillimeter;
    uint NumberRedBits;
    uint NumberGreenBits;
    uint NumberBlueBits;
    uint RedMask;
    uint GreenMask;
    uint BlueMask;
    uint AttributeFlags;
    uint VideoMemoryBitmapWidth;
    uint VideoMemoryBitmapHeight;
    uint DriverSpecificAttributeFlags;
}

struct VIDEO_LOAD_FONT_INFORMATION
{
    ushort   WidthInPixels;
    ushort   HeightInPixels;
    uint     FontSize;
    ubyte[1] Font;
}

struct VIDEO_PALETTE_DATA
{
    ushort    NumEntries;
    ushort    FirstEntry;
    ushort[1] Colors;
}

struct VIDEO_CLUTDATA
{
    ubyte Red;
    ubyte Green;
    ubyte Blue;
    ubyte Unused;
}

struct VIDEO_CLUT
{
    ushort NumEntries;
    ushort FirstEntry;
    union
    {
        VIDEO_CLUTDATA RgbArray;
        uint           RgbLong;
    }
}

struct VIDEO_CURSOR_POSITION
{
    short Column;
    short Row;
}

struct VIDEO_CURSOR_ATTRIBUTES
{
    ushort Width;
    ushort Height;
    short  Column;
    short  Row;
    ubyte  Rate;
    ubyte  Enable;
}

struct VIDEO_POINTER_POSITION
{
    short Column;
    short Row;
}

struct VIDEO_POINTER_ATTRIBUTES
{
    uint     Flags;
    uint     Width;
    uint     Height;
    uint     WidthInBytes;
    uint     Enable;
    short    Column;
    short    Row;
    ubyte[1] Pixels;
}

struct VIDEO_POINTER_CAPABILITIES
{
    uint Flags;
    uint MaxWidth;
    uint MaxHeight;
    uint HWPtrBitmapStart;
    uint HWPtrBitmapEnd;
}

struct VIDEO_BANK_SELECT
{
    uint Length;
    uint Size;
    uint BankingFlags;
    uint BankingType;
    uint PlanarHCBankingType;
    uint BitmapWidthInBytes;
    uint BitmapSize;
    uint Granularity;
    uint PlanarHCGranularity;
    uint CodeOffset;
    uint PlanarHCBankCodeOffset;
    uint PlanarHCEnableCodeOffset;
    uint PlanarHCDisableCodeOffset;
}

struct VIDEO_MEMORY
{
    void* RequestedVirtualAddress;
}

struct VIDEO_SHARE_MEMORY
{
    HANDLE ProcessHandle;
    uint   ViewOffset;
    uint   ViewSize;
    void*  RequestedVirtualAddress;
}

struct VIDEO_SHARE_MEMORY_INFORMATION
{
    uint  SharedViewOffset;
    uint  SharedViewSize;
    void* VirtualAddress;
}

struct VIDEO_MEMORY_INFORMATION
{
    void* VideoRamBase;
    uint  VideoRamLength;
    void* FrameBufferBase;
    uint  FrameBufferLength;
}

struct VIDEO_PUBLIC_ACCESS_RANGES
{
    uint  InIoSpace;
    uint  MappedInIoSpace;
    void* VirtualAddress;
}

struct VIDEO_COLOR_CAPABILITIES
{
    uint Length;
    uint AttributeFlags;
    int  RedPhosphoreDecay;
    int  GreenPhosphoreDecay;
    int  BluePhosphoreDecay;
    int  WhiteChromaticity_x;
    int  WhiteChromaticity_y;
    int  WhiteChromaticity_Y;
    int  RedChromaticity_x;
    int  RedChromaticity_y;
    int  GreenChromaticity_x;
    int  GreenChromaticity_y;
    int  BlueChromaticity_x;
    int  BlueChromaticity_y;
    int  WhiteGamma;
    int  RedGamma;
    int  GreenGamma;
    int  BlueGamma;
}

struct VIDEO_POWER_MANAGEMENT
{
    uint Length;
    uint DPMSVersion;
    uint PowerState;
}

struct VIDEO_COLOR_LUT_DATA
{
    uint     Length;
    uint     LutDataFormat;
    ubyte[1] LutData;
}

struct VIDEO_LUT_RGB256WORDS
{
    ushort[256] Red;
    ushort[256] Green;
    ushort[256] Blue;
}

struct BANK_POSITION
{
    uint ReadBankPosition;
    uint WriteBankPosition;
}

struct DISPLAY_BRIGHTNESS
{
    ubyte ucDisplayPolicy;
    ubyte ucACBrightness;
    ubyte ucDCBrightness;
}

struct VIDEO_BRIGHTNESS_POLICY
{
    ubyte DefaultToBiosPolicy;
    ubyte LevelCount;
    struct
    {
        ubyte BatteryLevel;
        ubyte Brightness;
    }
}

struct FSCNTL_SCREEN_INFO
{
    COORD Position;
    COORD ScreenSize;
    uint  nNumberOfChars;
}

struct FONT_IMAGE_INFO
{
    COORD  FontSize;
    ubyte* ImageBits;
}

struct CHAR_IMAGE_INFO
{
    CHAR_INFO       CharInfo;
    FONT_IMAGE_INFO FontImageInfo;
}

struct VGA_CHAR
{
    byte Char;
    byte Attributes;
}

struct FSVIDEO_COPY_FRAME_BUFFER
{
    FSCNTL_SCREEN_INFO SrcScreen;
    FSCNTL_SCREEN_INFO DestScreen;
}

struct FSVIDEO_WRITE_TO_FRAME_BUFFER
{
    CHAR_IMAGE_INFO*   SrcBuffer;
    FSCNTL_SCREEN_INFO DestScreen;
}

struct FSVIDEO_REVERSE_MOUSE_POINTER
{
    FSCNTL_SCREEN_INFO Screen;
    uint               dwType;
}

struct FSVIDEO_MODE_INFORMATION
{
    VIDEO_MODE_INFORMATION VideoMode;
    VIDEO_MEMORY_INFORMATION VideoMemory;
}

struct FSVIDEO_SCREEN_INFORMATION
{
    COORD ScreenSize;
    COORD FontSize;
}

struct FSVIDEO_CURSOR_POSITION
{
    VIDEO_CURSOR_POSITION Coord;
    uint dwType;
}

struct ENG_EVENT
{
    void* pKEvent;
    uint  fFlags;
}

struct VIDEO_PERFORMANCE_COUNTER
{
    ulong[10] NbOfAllocationEvicted;
    ulong[10] NbOfAllocationMarked;
    ulong[10] NbOfAllocationRestored;
    ulong[10] KBytesEvicted;
    ulong[10] KBytesMarked;
    ulong[10] KBytesRestored;
    ulong     NbProcessCommited;
    ulong     NbAllocationCommited;
    ulong     NbAllocationMarked;
    ulong     KBytesAllocated;
    ulong     KBytesAvailable;
    ulong     KBytesCurMarked;
    ulong     Reference;
    ulong     Unreference;
    ulong     TrueReference;
    ulong     NbOfPageIn;
    ulong     KBytesPageIn;
    ulong     NbOfPageOut;
    ulong     KBytesPageOut;
    ulong     NbOfRotateOut;
    ulong     KBytesRotateOut;
}

struct VIDEO_QUERY_PERFORMANCE_COUNTER
{
    uint BufferSize;
    VIDEO_PERFORMANCE_COUNTER* Buffer;
}

struct PANEL_QUERY_BRIGHTNESS_CAPS
{
    BRIGHTNESS_INTERFACE_VERSION Version;
    union
    {
        struct
        {
            uint _bitfield160;
        }
        uint Value;
    }
}

struct BRIGHTNESS_LEVEL
{
    ubyte      Count;
    ubyte[103] Level;
}

struct BRIGHTNESS_NIT_RANGE
{
    uint MinLevelInMillinit;
    uint MaxLevelInMillinit;
    uint StepSizeInMillinit;
}

struct BRIGHTNESS_NIT_RANGES
{
    uint NormalRangeCount;
    uint RangeCount;
    uint PreferredMaximumBrightness;
    BRIGHTNESS_NIT_RANGE[16] SupportedRanges;
}

struct PANEL_QUERY_BRIGHTNESS_RANGES
{
    BRIGHTNESS_INTERFACE_VERSION Version;
    union
    {
        BRIGHTNESS_LEVEL BrightnessLevel;
        BRIGHTNESS_NIT_RANGES NitRanges;
    }
}

struct PANEL_GET_BRIGHTNESS
{
    BRIGHTNESS_INTERFACE_VERSION Version;
    union
    {
        ubyte Level;
        struct
        {
            uint CurrentInMillinits;
            uint TargetInMillinits;
        }
    }
}

struct CHROMATICITY_COORDINATE
{
    float x;
    float y;
}

struct PANEL_BRIGHTNESS_SENSOR_DATA
{
    union
    {
        struct
        {
            uint _bitfield161;
        }
        uint Value;
    }
    float AlsReading;
    CHROMATICITY_COORDINATE ChromaticityCoordinate;
    float ColorTemperature;
}

struct PANEL_SET_BRIGHTNESS
{
    BRIGHTNESS_INTERFACE_VERSION Version;
    union
    {
        ubyte Level;
        struct
        {
            uint Millinits;
            uint TransitionTimeInMs;
            PANEL_BRIGHTNESS_SENSOR_DATA SensorData;
        }
    }
}

struct PANEL_SET_BRIGHTNESS_STATE
{
    union
    {
        struct
        {
            uint _bitfield162;
        }
        uint Value;
    }
}

struct PANEL_SET_BACKLIGHT_OPTIMIZATION
{
    BACKLIGHT_OPTIMIZATION_LEVEL Level;
}

struct BACKLIGHT_REDUCTION_GAMMA_RAMP
{
    ushort[256] R;
    ushort[256] G;
    ushort[256] B;
}

struct PANEL_GET_BACKLIGHT_REDUCTION
{
    ushort BacklightUsersetting;
    ushort BacklightEffective;
    BACKLIGHT_REDUCTION_GAMMA_RAMP GammaRamp;
}

struct COLORSPACE_TRANSFORM_DATA_CAP
{
    COLORSPACE_TRANSFORM_DATA_TYPE DataType;
    union
    {
        struct
        {
            uint _bitfield163;
        }
        struct
        {
            uint _bitfield164;
        }
        uint Value;
    }
    float NumericRangeMin;
    float NumericRangeMax;
}

struct COLORSPACE_TRANSFORM_1DLUT_CAP
{
    uint NumberOfLUTEntries;
    COLORSPACE_TRANSFORM_DATA_CAP DataCap;
}

struct COLORSPACE_TRANSFORM_MATRIX_CAP
{
    union
    {
        struct
        {
            uint _bitfield165;
        }
        uint Value;
    }
    COLORSPACE_TRANSFORM_DATA_CAP DataCap;
}

struct COLORSPACE_TRANSFORM_TARGET_CAPS
{
    COLORSPACE_TRANSFORM_TARGET_CAPS_VERSION Version;
    COLORSPACE_TRANSFORM_1DLUT_CAP LookupTable1DDegammaCap;
    COLORSPACE_TRANSFORM_MATRIX_CAP ColorMatrix3x3Cap;
    COLORSPACE_TRANSFORM_1DLUT_CAP LookupTable1DRegammaCap;
}

struct GAMMA_RAMP_RGB256x3x16
{
    ushort[256] Red;
    ushort[256] Green;
    ushort[256] Blue;
}

struct GAMMA_RAMP_RGB
{
    float Red;
    float Green;
    float Blue;
}

struct GAMMA_RAMP_DXGI_1
{
    GAMMA_RAMP_RGB       Scale;
    GAMMA_RAMP_RGB       Offset;
    GAMMA_RAMP_RGB[1025] GammaCurve;
}

struct COLORSPACE_TRANSFORM_3x4
{
    float[12]            ColorMatrix3x4;
    float                ScalarMultiplier;
    GAMMA_RAMP_RGB[4096] LookupTable1D;
}

struct OUTPUT_WIRE_FORMAT
{
    OUTPUT_COLOR_ENCODING ColorEncoding;
    uint BitsPerPixel;
}

struct COLORSPACE_TRANSFORM_MATRIX_V2
{
    COLORSPACE_TRANSFORM_STAGE_CONTROL StageControlLookupTable1DDegamma;
    GAMMA_RAMP_RGB[4096] LookupTable1DDegamma;
    COLORSPACE_TRANSFORM_STAGE_CONTROL StageControlColorMatrix3x3;
    float[9]             ColorMatrix3x3;
    COLORSPACE_TRANSFORM_STAGE_CONTROL StageControlLookupTable1DRegamma;
    GAMMA_RAMP_RGB[4096] LookupTable1DRegamma;
}

struct COLORSPACE_TRANSFORM
{
    COLORSPACE_TRANSFORM_TYPE Type;
    union Data
    {
        GAMMA_RAMP_RGB256x3x16 Rgb256x3x16;
        GAMMA_RAMP_DXGI_1 Dxgi1;
        COLORSPACE_TRANSFORM_3x4 T3x4;
        COLORSPACE_TRANSFORM_MATRIX_V2 MatrixV2;
    }
}

struct COLORSPACE_TRANSFORM_SET_INPUT
{
    OUTPUT_WIRE_COLOR_SPACE_TYPE OutputWireColorSpaceExpected;
    OUTPUT_WIRE_FORMAT   OutputWireFormatExpected;
    COLORSPACE_TRANSFORM ColorSpaceTransform;
}

struct SET_ACTIVE_COLOR_PROFILE_NAME
{
    ushort[1] ColorProfileName;
}

struct MIPI_DSI_CAPS
{
    ubyte  DSITypeMajor;
    ubyte  DSITypeMinor;
    ubyte  SpecVersionMajor;
    ubyte  SpecVersionMinor;
    ubyte  SpecVersionPatch;
    ushort TargetMaximumReturnPacketSize;
    ubyte  ResultCodeFlags;
    ubyte  ResultCodeStatus;
    ubyte  Revision;
    ubyte  Level;
    ubyte  DeviceClassHi;
    ubyte  DeviceClassLo;
    ubyte  ManufacturerHi;
    ubyte  ManufacturerLo;
    ubyte  ProductHi;
    ubyte  ProductLo;
    ubyte  LengthHi;
    ubyte  LengthLo;
}

struct MIPI_DSI_PACKET
{
    union
    {
        ubyte DataId;
        struct
        {
            ubyte _bitfield166;
        }
    }
    union
    {
        struct
        {
            ubyte Data0;
            ubyte Data1;
        }
        ushort LongWriteWordCount;
    }
    ubyte    EccFiller;
    ubyte[8] Payload;
}

struct MIPI_DSI_TRANSMISSION
{
    uint               TotalBufferSize;
    ubyte              PacketCount;
    ubyte              FailedPacket;
    struct
    {
        ushort _bitfield167;
    }
    ushort             ReadWordCount;
    ushort             FinalCommandExtraPayload;
    ushort             MipiErrors;
    ushort             HostErrors;
    MIPI_DSI_PACKET[1] Packets;
}

struct MIPI_DSI_RESET
{
    uint Flags;
    union
    {
        struct
        {
            uint _bitfield168;
        }
        uint Results;
    }
}

struct POWERBROADCAST_SETTING
{
    GUID     PowerSetting;
    uint     DataLength;
    ubyte[1] Data;
}

struct PROCESS_INFORMATION
{
    HANDLE hProcess;
    HANDLE hThread;
    uint   dwProcessId;
    uint   dwThreadId;
}

struct STARTUPINFOA
{
    uint         cb;
    const(char)* lpReserved;
    const(char)* lpDesktop;
    const(char)* lpTitle;
    uint         dwX;
    uint         dwY;
    uint         dwXSize;
    uint         dwYSize;
    uint         dwXCountChars;
    uint         dwYCountChars;
    uint         dwFillAttribute;
    uint         dwFlags;
    ushort       wShowWindow;
    ushort       cbReserved2;
    ubyte*       lpReserved2;
    HANDLE       hStdInput;
    HANDLE       hStdOutput;
    HANDLE       hStdError;
}

struct STARTUPINFOW
{
    uint          cb;
    const(wchar)* lpReserved;
    const(wchar)* lpDesktop;
    const(wchar)* lpTitle;
    uint          dwX;
    uint          dwY;
    uint          dwXSize;
    uint          dwYSize;
    uint          dwXCountChars;
    uint          dwYCountChars;
    uint          dwFillAttribute;
    uint          dwFlags;
    ushort        wShowWindow;
    ushort        cbReserved2;
    ubyte*        lpReserved2;
    HANDLE        hStdInput;
    HANDLE        hStdOutput;
    HANDLE        hStdError;
}

struct MEMORY_PRIORITY_INFORMATION
{
    uint MemoryPriority;
}

struct THREAD_POWER_THROTTLING_STATE
{
    uint Version;
    uint ControlMask;
    uint StateMask;
}

struct APP_MEMORY_INFORMATION
{
    ulong AvailableCommit;
    ulong PrivateCommitUsage;
    ulong PeakPrivateCommitUsage;
    ulong TotalCommitUsage;
}

struct PROCESS_MEMORY_EXHAUSTION_INFO
{
    ushort Version;
    ushort Reserved;
    PROCESS_MEMORY_EXHAUSTION_TYPE Type;
    size_t Value;
}

struct PROCESS_POWER_THROTTLING_STATE
{
    uint Version;
    uint ControlMask;
    uint StateMask;
}

struct PROCESS_PROTECTION_LEVEL_INFORMATION
{
    uint ProtectionLevel;
}

struct PROCESS_LEAP_SECOND_INFO
{
    uint Flags;
    uint Reserved;
}

struct MEMORYSTATUSEX
{
    uint  dwLength;
    uint  dwMemoryLoad;
    ulong ullTotalPhys;
    ulong ullAvailPhys;
    ulong ullTotalPageFile;
    ulong ullAvailPageFile;
    ulong ullTotalVirtual;
    ulong ullAvailVirtual;
    ulong ullAvailExtendedVirtual;
}

struct COMMPROP
{
    ushort    wPacketLength;
    ushort    wPacketVersion;
    uint      dwServiceMask;
    uint      dwReserved1;
    uint      dwMaxTxQueue;
    uint      dwMaxRxQueue;
    uint      dwMaxBaud;
    uint      dwProvSubType;
    uint      dwProvCapabilities;
    uint      dwSettableParams;
    uint      dwSettableBaud;
    ushort    wSettableData;
    ushort    wSettableStopParity;
    uint      dwCurrentTxQueue;
    uint      dwCurrentRxQueue;
    uint      dwProvSpec1;
    uint      dwProvSpec2;
    ushort[1] wcProvChar;
}

struct COMSTAT
{
    uint _bitfield169;
    uint cbInQue;
    uint cbOutQue;
}

struct DCB
{
    uint   DCBlength;
    uint   BaudRate;
    uint   _bitfield170;
    ushort wReserved;
    ushort XonLim;
    ushort XoffLim;
    ubyte  ByteSize;
    ubyte  Parity;
    ubyte  StopBits;
    byte   XonChar;
    byte   XoffChar;
    byte   ErrorChar;
    byte   EofChar;
    byte   EvtChar;
    ushort wReserved1;
}

struct COMMTIMEOUTS
{
    uint ReadIntervalTimeout;
    uint ReadTotalTimeoutMultiplier;
    uint ReadTotalTimeoutConstant;
    uint WriteTotalTimeoutMultiplier;
    uint WriteTotalTimeoutConstant;
}

struct COMMCONFIG
{
    uint      dwSize;
    ushort    wVersion;
    ushort    wReserved;
    DCB       dcb;
    uint      dwProviderSubType;
    uint      dwProviderOffset;
    uint      dwProviderSize;
    ushort[1] wcProviderData;
}

struct MEMORYSTATUS
{
    uint   dwLength;
    uint   dwMemoryLoad;
    size_t dwTotalPhys;
    size_t dwAvailPhys;
    size_t dwTotalPageFile;
    size_t dwAvailPageFile;
    size_t dwTotalVirtual;
    size_t dwAvailVirtual;
}

struct UMS_SCHEDULER_STARTUP_INFO
{
    uint  UmsVersion;
    void* CompletionList;
    PUMS_SCHEDULER_ENTRY_POINT SchedulerProc;
    void* SchedulerParam;
}

struct UMS_SYSTEM_THREAD_INFORMATION
{
    uint UmsVersion;
    union
    {
        struct
        {
            uint _bitfield171;
        }
        uint ThreadUmsFlags;
    }
}

struct WIN32_STREAM_ID
{
    uint          dwStreamId;
    uint          dwStreamAttributes;
    LARGE_INTEGER Size;
    uint          dwStreamNameSize;
    ushort[1]     cStreamName;
}

struct STARTUPINFOEXA
{
    STARTUPINFOA StartupInfo;
    ptrdiff_t    lpAttributeList;
}

struct STARTUPINFOEXW
{
    STARTUPINFOW StartupInfo;
    ptrdiff_t    lpAttributeList;
}

struct EVENTLOG_FULL_INFORMATION
{
    uint dwFull;
}

struct SYSTEM_POWER_STATUS
{
    ubyte ACLineStatus;
    ubyte BatteryFlag;
    ubyte BatteryLifePercent;
    ubyte SystemStatusFlag;
    uint  BatteryLifeTime;
    uint  BatteryFullLifeTime;
}

struct PEB_LDR_DATA
{
    ubyte[8]   Reserved1;
    void[3]*   Reserved2;
    LIST_ENTRY InMemoryOrderModuleList;
}

struct RTL_USER_PROCESS_PARAMETERS
{
    ubyte[16]      Reserved1;
    void[10]*      Reserved2;
    UNICODE_STRING ImagePathName;
    UNICODE_STRING CommandLine;
}

struct PEB
{
    ubyte[2]      Reserved1;
    ubyte         BeingDebugged;
    ubyte[1]      Reserved2;
    void[2]*      Reserved3;
    PEB_LDR_DATA* Ldr;
    RTL_USER_PROCESS_PARAMETERS* ProcessParameters;
    void[3]*      Reserved4;
    void*         AtlThunkSListPtr;
    void*         Reserved5;
    uint          Reserved6;
    void*         Reserved7;
    uint          Reserved8;
    uint          AtlThunkSListPtr32;
    void[45]*     Reserved9;
    ubyte[96]     Reserved10;
    PPS_POST_PROCESS_INIT_ROUTINE PostProcessInitRoutine;
    ubyte[128]    Reserved11;
    void[1]*      Reserved12;
    uint          SessionId;
}

// Functions

@DllImport("api-ms-win-core-rtlsupport-l1-1-0")
size_t RtlCompareMemory(const(void)* Source1, const(void)* Source2, size_t Length);

@DllImport("ntdll")
void RtlInitializeSListHead(SLIST_HEADER* ListHead);

@DllImport("ntdll")
SINGLE_LIST_ENTRY* RtlFirstEntrySList(const(SLIST_HEADER)* ListHead);

@DllImport("ntdll")
SINGLE_LIST_ENTRY* RtlInterlockedPopEntrySList(SLIST_HEADER* ListHead);

@DllImport("ntdll")
SINGLE_LIST_ENTRY* RtlInterlockedPushEntrySList(SLIST_HEADER* ListHead, SINGLE_LIST_ENTRY* ListEntry);

@DllImport("ntdll")
SINGLE_LIST_ENTRY* RtlInterlockedPushListSListEx(SLIST_HEADER* ListHead, SINGLE_LIST_ENTRY* List, 
                                                 SINGLE_LIST_ENTRY* ListEnd, uint Count);

@DllImport("ntdll")
SINGLE_LIST_ENTRY* RtlInterlockedFlushSList(SLIST_HEADER* ListHead);

@DllImport("ntdll")
ushort RtlQueryDepthSList(SLIST_HEADER* ListHead);

@DllImport("ntdll")
size_t RtlGetReturnAddressHijackTarget();

@DllImport("ntdll")
ubyte RtlGetProductInfo(uint OSMajorVersion, uint OSMinorVersion, uint SpMajorVersion, uint SpMinorVersion, 
                        uint* ReturnedProductType);

@DllImport("ntdll")
uint RtlCrc32(char* Buffer, size_t Size, uint InitialCrc);

@DllImport("ntdll")
ulong RtlCrc64(char* Buffer, size_t Size, ulong InitialCrc);

@DllImport("ntdll")
OS_DEPLOYEMENT_STATE_VALUES RtlOsDeploymentState(uint Flags);

@DllImport("ntdll")
uint RtlInitializeCorrelationVector(CORRELATION_VECTOR* CorrelationVector, int Version, const(GUID)* Guid);

@DllImport("ntdll")
uint RtlIncrementCorrelationVector(CORRELATION_VECTOR* CorrelationVector);

@DllImport("ntdll")
uint RtlExtendCorrelationVector(CORRELATION_VECTOR* CorrelationVector);

@DllImport("ntdll")
uint RtlValidateCorrelationVector(CORRELATION_VECTOR* Vector);

@DllImport("ntdll")
uint RtlRaiseCustomSystemEventTrigger(CUSTOM_SYSTEM_EVENT_TRIGGER_CONFIG* TriggerConfig);

@DllImport("ntdll")
ubyte RtlIsZeroMemory(void* Buffer, size_t Length);

@DllImport("ntdll")
ubyte RtlNormalizeSecurityDescriptor(void** SecurityDescriptor, uint SecurityDescriptorLength, 
                                     void** NewSecurityDescriptor, uint* NewSecurityDescriptorLength, 
                                     ubyte CheckOnly);

@DllImport("ntdll")
void RtlGetDeviceFamilyInfoEnum(ulong* pullUAPInfo, uint* pulDeviceFamily, uint* pulDeviceForm);

@DllImport("ntdll")
uint RtlConvertDeviceFamilyInfoToString(uint* pulDeviceFamilyBufferSize, uint* pulDeviceFormBufferSize, 
                                        const(wchar)* DeviceFamily, const(wchar)* DeviceForm);

@DllImport("ntdll")
uint RtlSwitchedVVI(OSVERSIONINFOEXW* VersionInfo, uint TypeMask, ulong ConditionMask);

@DllImport("KERNEL32")
uint FlsAlloc(PFLS_CALLBACK_FUNCTION lpCallback);

@DllImport("KERNEL32")
void* FlsGetValue(uint dwFlsIndex);

@DllImport("KERNEL32")
BOOL FlsSetValue(uint dwFlsIndex, void* lpFlsData);

@DllImport("KERNEL32")
BOOL FlsFree(uint dwFlsIndex);

@DllImport("KERNEL32")
BOOL IsThreadAFiber();

@DllImport("KERNEL32")
void InitializeSRWLock(RTL_SRWLOCK* SRWLock);

@DllImport("KERNEL32")
void ReleaseSRWLockExclusive(RTL_SRWLOCK* SRWLock);

@DllImport("KERNEL32")
void ReleaseSRWLockShared(RTL_SRWLOCK* SRWLock);

@DllImport("KERNEL32")
void AcquireSRWLockExclusive(RTL_SRWLOCK* SRWLock);

@DllImport("KERNEL32")
void AcquireSRWLockShared(RTL_SRWLOCK* SRWLock);

@DllImport("KERNEL32")
ubyte TryAcquireSRWLockExclusive(RTL_SRWLOCK* SRWLock);

@DllImport("KERNEL32")
ubyte TryAcquireSRWLockShared(RTL_SRWLOCK* SRWLock);

@DllImport("KERNEL32")
void InitializeCriticalSection(RTL_CRITICAL_SECTION* lpCriticalSection);

@DllImport("KERNEL32")
void LeaveCriticalSection(RTL_CRITICAL_SECTION* lpCriticalSection);

@DllImport("KERNEL32")
BOOL InitializeCriticalSectionAndSpinCount(RTL_CRITICAL_SECTION* lpCriticalSection, uint dwSpinCount);

@DllImport("KERNEL32")
BOOL InitializeCriticalSectionEx(RTL_CRITICAL_SECTION* lpCriticalSection, uint dwSpinCount, uint Flags);

@DllImport("KERNEL32")
uint SetCriticalSectionSpinCount(RTL_CRITICAL_SECTION* lpCriticalSection, uint dwSpinCount);

@DllImport("KERNEL32")
BOOL TryEnterCriticalSection(RTL_CRITICAL_SECTION* lpCriticalSection);

@DllImport("KERNEL32")
void DeleteCriticalSection(RTL_CRITICAL_SECTION* lpCriticalSection);

@DllImport("KERNEL32")
void InitOnceInitialize(RTL_RUN_ONCE* InitOnce);

@DllImport("KERNEL32")
BOOL InitOnceExecuteOnce(RTL_RUN_ONCE* InitOnce, PINIT_ONCE_FN InitFn, void* Parameter, void** Context);

@DllImport("KERNEL32")
BOOL InitOnceBeginInitialize(RTL_RUN_ONCE* lpInitOnce, uint dwFlags, int* fPending, void** lpContext);

@DllImport("KERNEL32")
BOOL InitOnceComplete(RTL_RUN_ONCE* lpInitOnce, uint dwFlags, void* lpContext);

@DllImport("KERNEL32")
void InitializeConditionVariable(RTL_CONDITION_VARIABLE* ConditionVariable);

@DllImport("KERNEL32")
void WakeConditionVariable(RTL_CONDITION_VARIABLE* ConditionVariable);

@DllImport("KERNEL32")
void WakeAllConditionVariable(RTL_CONDITION_VARIABLE* ConditionVariable);

@DllImport("KERNEL32")
BOOL SleepConditionVariableCS(RTL_CONDITION_VARIABLE* ConditionVariable, RTL_CRITICAL_SECTION* CriticalSection, 
                              uint dwMilliseconds);

@DllImport("KERNEL32")
BOOL SleepConditionVariableSRW(RTL_CONDITION_VARIABLE* ConditionVariable, RTL_SRWLOCK* SRWLock, 
                               uint dwMilliseconds, uint Flags);

@DllImport("KERNEL32")
BOOL SetEvent(HANDLE hEvent);

@DllImport("KERNEL32")
BOOL ResetEvent(HANDLE hEvent);

@DllImport("KERNEL32")
BOOL ReleaseSemaphore(HANDLE hSemaphore, int lReleaseCount, int* lpPreviousCount);

@DllImport("KERNEL32")
BOOL ReleaseMutex(HANDLE hMutex);

@DllImport("KERNEL32")
uint WaitForSingleObject(HANDLE hHandle, uint dwMilliseconds);

@DllImport("KERNEL32")
uint SleepEx(uint dwMilliseconds, BOOL bAlertable);

@DllImport("KERNEL32")
uint WaitForSingleObjectEx(HANDLE hHandle, uint dwMilliseconds, BOOL bAlertable);

@DllImport("KERNEL32")
uint WaitForMultipleObjectsEx(uint nCount, char* lpHandles, BOOL bWaitAll, uint dwMilliseconds, BOOL bAlertable);

@DllImport("KERNEL32")
HANDLE CreateMutexA(SECURITY_ATTRIBUTES* lpMutexAttributes, BOOL bInitialOwner, const(char)* lpName);

@DllImport("KERNEL32")
HANDLE CreateMutexW(SECURITY_ATTRIBUTES* lpMutexAttributes, BOOL bInitialOwner, const(wchar)* lpName);

@DllImport("KERNEL32")
HANDLE OpenMutexW(uint dwDesiredAccess, BOOL bInheritHandle, const(wchar)* lpName);

@DllImport("KERNEL32")
HANDLE CreateEventA(SECURITY_ATTRIBUTES* lpEventAttributes, BOOL bManualReset, BOOL bInitialState, 
                    const(char)* lpName);

@DllImport("KERNEL32")
HANDLE CreateEventW(SECURITY_ATTRIBUTES* lpEventAttributes, BOOL bManualReset, BOOL bInitialState, 
                    const(wchar)* lpName);

@DllImport("KERNEL32")
HANDLE OpenEventA(uint dwDesiredAccess, BOOL bInheritHandle, const(char)* lpName);

@DllImport("KERNEL32")
HANDLE OpenEventW(uint dwDesiredAccess, BOOL bInheritHandle, const(wchar)* lpName);

@DllImport("KERNEL32")
HANDLE OpenSemaphoreW(uint dwDesiredAccess, BOOL bInheritHandle, const(wchar)* lpName);

@DllImport("KERNEL32")
HANDLE OpenWaitableTimerW(uint dwDesiredAccess, BOOL bInheritHandle, const(wchar)* lpTimerName);

@DllImport("KERNEL32")
BOOL SetWaitableTimerEx(HANDLE hTimer, const(LARGE_INTEGER)* lpDueTime, int lPeriod, 
                        PTIMERAPCROUTINE pfnCompletionRoutine, void* lpArgToCompletionRoutine, 
                        REASON_CONTEXT* WakeContext, uint TolerableDelay);

@DllImport("KERNEL32")
BOOL SetWaitableTimer(HANDLE hTimer, const(LARGE_INTEGER)* lpDueTime, int lPeriod, 
                      PTIMERAPCROUTINE pfnCompletionRoutine, void* lpArgToCompletionRoutine, BOOL fResume);

@DllImport("KERNEL32")
BOOL CancelWaitableTimer(HANDLE hTimer);

@DllImport("KERNEL32")
HANDLE CreateMutexExA(SECURITY_ATTRIBUTES* lpMutexAttributes, const(char)* lpName, uint dwFlags, 
                      uint dwDesiredAccess);

@DllImport("KERNEL32")
HANDLE CreateMutexExW(SECURITY_ATTRIBUTES* lpMutexAttributes, const(wchar)* lpName, uint dwFlags, 
                      uint dwDesiredAccess);

@DllImport("KERNEL32")
HANDLE CreateEventExA(SECURITY_ATTRIBUTES* lpEventAttributes, const(char)* lpName, uint dwFlags, 
                      uint dwDesiredAccess);

@DllImport("KERNEL32")
HANDLE CreateEventExW(SECURITY_ATTRIBUTES* lpEventAttributes, const(wchar)* lpName, uint dwFlags, 
                      uint dwDesiredAccess);

@DllImport("KERNEL32")
HANDLE CreateSemaphoreExW(SECURITY_ATTRIBUTES* lpSemaphoreAttributes, int lInitialCount, int lMaximumCount, 
                          const(wchar)* lpName, uint dwFlags, uint dwDesiredAccess);

@DllImport("KERNEL32")
HANDLE CreateWaitableTimerExW(SECURITY_ATTRIBUTES* lpTimerAttributes, const(wchar)* lpTimerName, uint dwFlags, 
                              uint dwDesiredAccess);

@DllImport("KERNEL32")
BOOL EnterSynchronizationBarrier(RTL_BARRIER* lpBarrier, uint dwFlags);

@DllImport("KERNEL32")
BOOL InitializeSynchronizationBarrier(RTL_BARRIER* lpBarrier, int lTotalThreads, int lSpinCount);

@DllImport("KERNEL32")
BOOL DeleteSynchronizationBarrier(RTL_BARRIER* lpBarrier);

@DllImport("KERNEL32")
void Sleep(uint dwMilliseconds);

@DllImport("api-ms-win-core-synch-l1-2-0")
BOOL WaitOnAddress(char* Address, char* CompareAddress, size_t AddressSize, uint dwMilliseconds);

@DllImport("api-ms-win-core-synch-l1-2-0")
void WakeByAddressSingle(void* Address);

@DllImport("api-ms-win-core-synch-l1-2-0")
void WakeByAddressAll(void* Address);

@DllImport("KERNEL32")
uint WaitForMultipleObjects(uint nCount, char* lpHandles, BOOL bWaitAll, uint dwMilliseconds);

@DllImport("KERNEL32")
HANDLE CreateSemaphoreW(SECURITY_ATTRIBUTES* lpSemaphoreAttributes, int lInitialCount, int lMaximumCount, 
                        const(wchar)* lpName);

@DllImport("KERNEL32")
HANDLE CreateWaitableTimerW(SECURITY_ATTRIBUTES* lpTimerAttributes, BOOL bManualReset, const(wchar)* lpTimerName);

@DllImport("KERNEL32")
void InitializeSListHead(SLIST_HEADER* ListHead);

@DllImport("KERNEL32")
SINGLE_LIST_ENTRY* InterlockedPopEntrySList(SLIST_HEADER* ListHead);

@DllImport("KERNEL32")
SINGLE_LIST_ENTRY* InterlockedPushEntrySList(SLIST_HEADER* ListHead, SINGLE_LIST_ENTRY* ListEntry);

@DllImport("KERNEL32")
SINGLE_LIST_ENTRY* InterlockedPushListSListEx(SLIST_HEADER* ListHead, SINGLE_LIST_ENTRY* List, 
                                              SINGLE_LIST_ENTRY* ListEnd, uint Count);

@DllImport("KERNEL32")
SINGLE_LIST_ENTRY* InterlockedFlushSList(SLIST_HEADER* ListHead);

@DllImport("KERNEL32")
ushort QueryDepthSList(SLIST_HEADER* ListHead);

@DllImport("KERNEL32")
BOOL QueueUserWorkItem(LPTHREAD_START_ROUTINE Function, void* Context, uint Flags);

@DllImport("KERNEL32")
BOOL UnregisterWaitEx(HANDLE WaitHandle, HANDLE CompletionEvent);

@DllImport("KERNEL32")
HANDLE CreateTimerQueue();

@DllImport("KERNEL32")
BOOL CreateTimerQueueTimer(ptrdiff_t* phNewTimer, HANDLE TimerQueue, WAITORTIMERCALLBACK Callback, void* Parameter, 
                           uint DueTime, uint Period, uint Flags);

@DllImport("KERNEL32")
BOOL ChangeTimerQueueTimer(HANDLE TimerQueue, HANDLE Timer, uint DueTime, uint Period);

@DllImport("KERNEL32")
BOOL DeleteTimerQueueTimer(HANDLE TimerQueue, HANDLE Timer, HANDLE CompletionEvent);

@DllImport("KERNEL32")
BOOL DeleteTimerQueueEx(HANDLE TimerQueue, HANDLE CompletionEvent);

@DllImport("KERNEL32")
PTP_POOL CreateThreadpool(void* reserved);

@DllImport("KERNEL32")
void SetThreadpoolThreadMaximum(PTP_POOL ptpp, uint cthrdMost);

@DllImport("KERNEL32")
BOOL SetThreadpoolThreadMinimum(PTP_POOL ptpp, uint cthrdMic);

@DllImport("KERNEL32")
BOOL SetThreadpoolStackInformation(PTP_POOL ptpp, TP_POOL_STACK_INFORMATION* ptpsi);

@DllImport("KERNEL32")
BOOL QueryThreadpoolStackInformation(PTP_POOL ptpp, TP_POOL_STACK_INFORMATION* ptpsi);

@DllImport("KERNEL32")
void CloseThreadpool(PTP_POOL ptpp);

@DllImport("KERNEL32")
ptrdiff_t CreateThreadpoolCleanupGroup();

@DllImport("KERNEL32")
void CloseThreadpoolCleanupGroupMembers(ptrdiff_t ptpcg, BOOL fCancelPendingCallbacks, void* pvCleanupContext);

@DllImport("KERNEL32")
void CloseThreadpoolCleanupGroup(ptrdiff_t ptpcg);

@DllImport("KERNEL32")
void SetEventWhenCallbackReturns(TP_CALLBACK_INSTANCE* pci, HANDLE evt);

@DllImport("KERNEL32")
void ReleaseSemaphoreWhenCallbackReturns(TP_CALLBACK_INSTANCE* pci, HANDLE sem, uint crel);

@DllImport("KERNEL32")
void ReleaseMutexWhenCallbackReturns(TP_CALLBACK_INSTANCE* pci, HANDLE mut);

@DllImport("KERNEL32")
void LeaveCriticalSectionWhenCallbackReturns(TP_CALLBACK_INSTANCE* pci, RTL_CRITICAL_SECTION* pcs);

@DllImport("KERNEL32")
void FreeLibraryWhenCallbackReturns(TP_CALLBACK_INSTANCE* pci, ptrdiff_t mod);

@DllImport("KERNEL32")
BOOL CallbackMayRunLong(TP_CALLBACK_INSTANCE* pci);

@DllImport("KERNEL32")
void DisassociateCurrentThreadFromCallback(TP_CALLBACK_INSTANCE* pci);

@DllImport("KERNEL32")
BOOL TrySubmitThreadpoolCallback(PTP_SIMPLE_CALLBACK pfns, void* pv, TP_CALLBACK_ENVIRON_V3* pcbe);

@DllImport("KERNEL32")
TP_WORK* CreateThreadpoolWork(PTP_WORK_CALLBACK pfnwk, void* pv, TP_CALLBACK_ENVIRON_V3* pcbe);

@DllImport("KERNEL32")
void SubmitThreadpoolWork(TP_WORK* pwk);

@DllImport("KERNEL32")
void WaitForThreadpoolWorkCallbacks(TP_WORK* pwk, BOOL fCancelPendingCallbacks);

@DllImport("KERNEL32")
void CloseThreadpoolWork(TP_WORK* pwk);

@DllImport("KERNEL32")
TP_TIMER* CreateThreadpoolTimer(PTP_TIMER_CALLBACK pfnti, void* pv, TP_CALLBACK_ENVIRON_V3* pcbe);

@DllImport("KERNEL32")
void SetThreadpoolTimer(TP_TIMER* pti, FILETIME* pftDueTime, uint msPeriod, uint msWindowLength);

@DllImport("KERNEL32")
BOOL IsThreadpoolTimerSet(TP_TIMER* pti);

@DllImport("KERNEL32")
void WaitForThreadpoolTimerCallbacks(TP_TIMER* pti, BOOL fCancelPendingCallbacks);

@DllImport("KERNEL32")
void CloseThreadpoolTimer(TP_TIMER* pti);

@DllImport("KERNEL32")
TP_WAIT* CreateThreadpoolWait(PTP_WAIT_CALLBACK pfnwa, void* pv, TP_CALLBACK_ENVIRON_V3* pcbe);

@DllImport("KERNEL32")
void SetThreadpoolWait(TP_WAIT* pwa, HANDLE h, FILETIME* pftTimeout);

@DllImport("KERNEL32")
void WaitForThreadpoolWaitCallbacks(TP_WAIT* pwa, BOOL fCancelPendingCallbacks);

@DllImport("KERNEL32")
void CloseThreadpoolWait(TP_WAIT* pwa);

@DllImport("KERNEL32")
TP_IO* CreateThreadpoolIo(HANDLE fl, PTP_WIN32_IO_CALLBACK pfnio, void* pv, TP_CALLBACK_ENVIRON_V3* pcbe);

@DllImport("KERNEL32")
void StartThreadpoolIo(TP_IO* pio);

@DllImport("KERNEL32")
void CancelThreadpoolIo(TP_IO* pio);

@DllImport("KERNEL32")
void WaitForThreadpoolIoCallbacks(TP_IO* pio, BOOL fCancelPendingCallbacks);

@DllImport("KERNEL32")
void CloseThreadpoolIo(TP_IO* pio);

@DllImport("KERNEL32")
BOOL SetThreadpoolTimerEx(TP_TIMER* pti, FILETIME* pftDueTime, uint msPeriod, uint msWindowLength);

@DllImport("KERNEL32")
BOOL SetThreadpoolWaitEx(TP_WAIT* pwa, HANDLE h, FILETIME* pftTimeout, void* Reserved);

@DllImport("KERNEL32")
BOOL IsProcessInJob(HANDLE ProcessHandle, HANDLE JobHandle, int* Result);

@DllImport("KERNEL32")
HANDLE CreateJobObjectW(SECURITY_ATTRIBUTES* lpJobAttributes, const(wchar)* lpName);

@DllImport("KERNEL32")
void FreeMemoryJobObject(void* Buffer);

@DllImport("KERNEL32")
HANDLE OpenJobObjectW(uint dwDesiredAccess, BOOL bInheritHandle, const(wchar)* lpName);

@DllImport("KERNEL32")
BOOL AssignProcessToJobObject(HANDLE hJob, HANDLE hProcess);

@DllImport("KERNEL32")
BOOL TerminateJobObject(HANDLE hJob, uint uExitCode);

@DllImport("KERNEL32")
BOOL SetInformationJobObject(HANDLE hJob, JOBOBJECTINFOCLASS JobObjectInformationClass, 
                             char* lpJobObjectInformation, uint cbJobObjectInformationLength);

@DllImport("KERNEL32")
uint SetIoRateControlInformationJobObject(HANDLE hJob, JOBOBJECT_IO_RATE_CONTROL_INFORMATION* IoRateControlInfo);

@DllImport("KERNEL32")
BOOL QueryInformationJobObject(HANDLE hJob, JOBOBJECTINFOCLASS JobObjectInformationClass, 
                               char* lpJobObjectInformation, uint cbJobObjectInformationLength, uint* lpReturnLength);

@DllImport("KERNEL32")
uint QueryIoRateControlInformationJobObject(HANDLE hJob, const(wchar)* VolumeName, 
                                            JOBOBJECT_IO_RATE_CONTROL_INFORMATION** InfoBlocks, uint* InfoBlockCount);

@DllImport("KERNEL32")
NamespaceHandle CreatePrivateNamespaceW(SECURITY_ATTRIBUTES* lpPrivateNamespaceAttributes, 
                                        void* lpBoundaryDescriptor, const(wchar)* lpAliasPrefix);

@DllImport("KERNEL32")
NamespaceHandle OpenPrivateNamespaceW(void* lpBoundaryDescriptor, const(wchar)* lpAliasPrefix);

@DllImport("KERNEL32")
ubyte ClosePrivateNamespace(NamespaceHandle Handle, uint Flags);

@DllImport("KERNEL32")
BoundaryDescriptorHandle CreateBoundaryDescriptorW(const(wchar)* Name, uint Flags);

@DllImport("KERNEL32")
BOOL AddSIDToBoundaryDescriptor(HANDLE* BoundaryDescriptor, void* RequiredSid);

@DllImport("KERNEL32")
void DeleteBoundaryDescriptor(BoundaryDescriptorHandle BoundaryDescriptor);

@DllImport("KERNEL32")
BOOL GetNumaHighestNodeNumber(uint* HighestNodeNumber);

@DllImport("KERNEL32")
BOOL GetNumaNodeProcessorMaskEx(ushort Node, GROUP_AFFINITY* ProcessorMask);

@DllImport("KERNEL32")
BOOL GetNumaProximityNodeEx(uint ProximityId, ushort* NodeNumber);

@DllImport("KERNEL32")
BOOL GetProcessGroupAffinity(HANDLE hProcess, ushort* GroupCount, char* GroupArray);

@DllImport("KERNEL32")
BOOL GetThreadGroupAffinity(HANDLE hThread, GROUP_AFFINITY* GroupAffinity);

@DllImport("KERNEL32")
BOOL SetThreadGroupAffinity(HANDLE hThread, const(GROUP_AFFINITY)* GroupAffinity, 
                            GROUP_AFFINITY* PreviousGroupAffinity);

@DllImport("KERNEL32")
BOOL CreatePipe(ptrdiff_t* hReadPipe, ptrdiff_t* hWritePipe, SECURITY_ATTRIBUTES* lpPipeAttributes, uint nSize);

@DllImport("KERNEL32")
BOOL ConnectNamedPipe(HANDLE hNamedPipe, OVERLAPPED* lpOverlapped);

@DllImport("KERNEL32")
BOOL DisconnectNamedPipe(HANDLE hNamedPipe);

@DllImport("KERNEL32")
BOOL SetNamedPipeHandleState(HANDLE hNamedPipe, uint* lpMode, uint* lpMaxCollectionCount, 
                             uint* lpCollectDataTimeout);

@DllImport("KERNEL32")
BOOL PeekNamedPipe(HANDLE hNamedPipe, char* lpBuffer, uint nBufferSize, uint* lpBytesRead, uint* lpTotalBytesAvail, 
                   uint* lpBytesLeftThisMessage);

@DllImport("KERNEL32")
BOOL TransactNamedPipe(HANDLE hNamedPipe, char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, 
                       uint nOutBufferSize, uint* lpBytesRead, OVERLAPPED* lpOverlapped);

@DllImport("KERNEL32")
HANDLE CreateNamedPipeW(const(wchar)* lpName, uint dwOpenMode, uint dwPipeMode, uint nMaxInstances, 
                        uint nOutBufferSize, uint nInBufferSize, uint nDefaultTimeOut, 
                        SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("KERNEL32")
BOOL WaitNamedPipeW(const(wchar)* lpNamedPipeName, uint nTimeOut);

@DllImport("KERNEL32")
BOOL GetNamedPipeClientComputerNameW(HANDLE Pipe, const(wchar)* ClientComputerName, uint ClientComputerNameLength);

@DllImport("KERNEL32")
BOOL GetNamedPipeInfo(HANDLE hNamedPipe, uint* lpFlags, uint* lpOutBufferSize, uint* lpInBufferSize, 
                      uint* lpMaxInstances);

@DllImport("KERNEL32")
BOOL GetNamedPipeHandleStateW(HANDLE hNamedPipe, uint* lpState, uint* lpCurInstances, uint* lpMaxCollectionCount, 
                              uint* lpCollectDataTimeout, const(wchar)* lpUserName, uint nMaxUserNameSize);

@DllImport("KERNEL32")
BOOL CallNamedPipeW(const(wchar)* lpNamedPipeName, char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, 
                    uint nOutBufferSize, uint* lpBytesRead, uint nTimeOut);

@DllImport("KERNEL32")
HeapHandle HeapCreate(uint flOptions, size_t dwInitialSize, size_t dwMaximumSize);

@DllImport("KERNEL32")
BOOL HeapDestroy(HeapHandle hHeap);

@DllImport("KERNEL32")
void* HeapAlloc(HeapHandle hHeap, uint dwFlags, size_t dwBytes);

@DllImport("KERNEL32")
void* HeapReAlloc(HeapHandle hHeap, uint dwFlags, void* lpMem, size_t dwBytes);

@DllImport("KERNEL32")
BOOL HeapFree(HANDLE hHeap, uint dwFlags, void* lpMem);

@DllImport("KERNEL32")
size_t HeapSize(HeapHandle hHeap, uint dwFlags, void* lpMem);

@DllImport("KERNEL32")
HANDLE GetProcessHeap();

@DllImport("KERNEL32")
size_t HeapCompact(HeapHandle hHeap, uint dwFlags);

@DllImport("KERNEL32")
BOOL HeapSetInformation(HANDLE HeapHandle, HEAP_INFORMATION_CLASS HeapInformationClass, char* HeapInformation, 
                        size_t HeapInformationLength);

@DllImport("KERNEL32")
BOOL HeapValidate(HANDLE hHeap, uint dwFlags, void* lpMem);

@DllImport("KERNEL32")
BOOL HeapSummary(HANDLE hHeap, uint dwFlags, HEAP_SUMMARY* lpSummary);

@DllImport("KERNEL32")
uint GetProcessHeaps(uint NumberOfHeaps, char* ProcessHeaps);

@DllImport("KERNEL32")
BOOL HeapLock(HeapHandle hHeap);

@DllImport("KERNEL32")
BOOL HeapUnlock(HANDLE hHeap);

@DllImport("KERNEL32")
BOOL HeapWalk(HANDLE hHeap, PROCESS_HEAP_ENTRY* lpEntry);

@DllImport("KERNEL32")
BOOL HeapQueryInformation(HANDLE HeapHandle, HEAP_INFORMATION_CLASS HeapInformationClass, char* HeapInformation, 
                          size_t HeapInformationLength, size_t* ReturnLength);

@DllImport("KERNEL32")
void* VirtualAlloc(void* lpAddress, size_t dwSize, uint flAllocationType, uint flProtect);

@DllImport("KERNEL32")
BOOL VirtualProtect(void* lpAddress, size_t dwSize, uint flNewProtect, uint* lpflOldProtect);

@DllImport("KERNEL32")
BOOL VirtualFree(void* lpAddress, size_t dwSize, uint dwFreeType);

@DllImport("KERNEL32")
size_t VirtualQuery(void* lpAddress, char* lpBuffer, size_t dwLength);

@DllImport("KERNEL32")
void* VirtualAllocEx(HANDLE hProcess, void* lpAddress, size_t dwSize, uint flAllocationType, uint flProtect);

@DllImport("KERNEL32")
BOOL VirtualProtectEx(HANDLE hProcess, void* lpAddress, size_t dwSize, uint flNewProtect, uint* lpflOldProtect);

@DllImport("KERNEL32")
size_t VirtualQueryEx(HANDLE hProcess, void* lpAddress, char* lpBuffer, size_t dwLength);

@DllImport("KERNEL32")
HANDLE CreateFileMappingW(HANDLE hFile, SECURITY_ATTRIBUTES* lpFileMappingAttributes, uint flProtect, 
                          uint dwMaximumSizeHigh, uint dwMaximumSizeLow, const(wchar)* lpName);

@DllImport("KERNEL32")
HANDLE OpenFileMappingW(uint dwDesiredAccess, BOOL bInheritHandle, const(wchar)* lpName);

@DllImport("KERNEL32")
void* MapViewOfFile(HANDLE hFileMappingObject, uint dwDesiredAccess, uint dwFileOffsetHigh, uint dwFileOffsetLow, 
                    size_t dwNumberOfBytesToMap);

@DllImport("KERNEL32")
void* MapViewOfFileEx(HANDLE hFileMappingObject, uint dwDesiredAccess, uint dwFileOffsetHigh, uint dwFileOffsetLow, 
                      size_t dwNumberOfBytesToMap, void* lpBaseAddress);

@DllImport("KERNEL32")
BOOL VirtualFreeEx(HANDLE hProcess, void* lpAddress, size_t dwSize, uint dwFreeType);

@DllImport("KERNEL32")
BOOL FlushViewOfFile(void* lpBaseAddress, size_t dwNumberOfBytesToFlush);

@DllImport("KERNEL32")
BOOL UnmapViewOfFile(void* lpBaseAddress);

@DllImport("KERNEL32")
size_t GetLargePageMinimum();

@DllImport("KERNEL32")
BOOL GetProcessWorkingSetSizeEx(HANDLE hProcess, size_t* lpMinimumWorkingSetSize, size_t* lpMaximumWorkingSetSize, 
                                uint* Flags);

@DllImport("KERNEL32")
BOOL SetProcessWorkingSetSizeEx(HANDLE hProcess, size_t dwMinimumWorkingSetSize, size_t dwMaximumWorkingSetSize, 
                                uint Flags);

@DllImport("KERNEL32")
BOOL VirtualLock(void* lpAddress, size_t dwSize);

@DllImport("KERNEL32")
BOOL VirtualUnlock(void* lpAddress, size_t dwSize);

@DllImport("KERNEL32")
uint GetWriteWatch(uint dwFlags, void* lpBaseAddress, size_t dwRegionSize, char* lpAddresses, size_t* lpdwCount, 
                   uint* lpdwGranularity);

@DllImport("KERNEL32")
uint ResetWriteWatch(void* lpBaseAddress, size_t dwRegionSize);

@DllImport("KERNEL32")
HANDLE CreateMemoryResourceNotification(MEMORY_RESOURCE_NOTIFICATION_TYPE NotificationType);

@DllImport("KERNEL32")
BOOL QueryMemoryResourceNotification(HANDLE ResourceNotificationHandle, int* ResourceState);

@DllImport("KERNEL32")
BOOL GetSystemFileCacheSize(size_t* lpMinimumFileCacheSize, size_t* lpMaximumFileCacheSize, uint* lpFlags);

@DllImport("KERNEL32")
BOOL SetSystemFileCacheSize(size_t MinimumFileCacheSize, size_t MaximumFileCacheSize, uint Flags);

@DllImport("KERNEL32")
HANDLE CreateFileMappingNumaW(HANDLE hFile, SECURITY_ATTRIBUTES* lpFileMappingAttributes, uint flProtect, 
                              uint dwMaximumSizeHigh, uint dwMaximumSizeLow, const(wchar)* lpName, uint nndPreferred);

@DllImport("KERNEL32")
BOOL PrefetchVirtualMemory(HANDLE hProcess, size_t NumberOfEntries, char* VirtualAddresses, uint Flags);

@DllImport("KERNEL32")
HANDLE CreateFileMappingFromApp(HANDLE hFile, SECURITY_ATTRIBUTES* SecurityAttributes, uint PageProtection, 
                                ulong MaximumSize, const(wchar)* Name);

@DllImport("KERNEL32")
void* MapViewOfFileFromApp(HANDLE hFileMappingObject, uint DesiredAccess, ulong FileOffset, 
                           size_t NumberOfBytesToMap);

@DllImport("KERNEL32")
BOOL UnmapViewOfFileEx(void* BaseAddress, uint UnmapFlags);

@DllImport("KERNEL32")
BOOL AllocateUserPhysicalPages(HANDLE hProcess, uint* NumberOfPages, char* PageArray);

@DllImport("KERNEL32")
BOOL FreeUserPhysicalPages(HANDLE hProcess, uint* NumberOfPages, char* PageArray);

@DllImport("KERNEL32")
BOOL MapUserPhysicalPages(void* VirtualAddress, size_t NumberOfPages, char* PageArray);

@DllImport("KERNEL32")
BOOL AllocateUserPhysicalPagesNuma(HANDLE hProcess, uint* NumberOfPages, char* PageArray, uint nndPreferred);

@DllImport("KERNEL32")
void* VirtualAllocExNuma(HANDLE hProcess, void* lpAddress, size_t dwSize, uint flAllocationType, uint flProtect, 
                         uint nndPreferred);

@DllImport("KERNEL32")
BOOL GetMemoryErrorHandlingCapabilities(uint* Capabilities);

@DllImport("KERNEL32")
void* RegisterBadMemoryNotification(PBAD_MEMORY_CALLBACK_ROUTINE Callback);

@DllImport("KERNEL32")
BOOL UnregisterBadMemoryNotification(void* RegistrationHandle);

@DllImport("KERNEL32")
uint OfferVirtualMemory(char* VirtualAddress, size_t Size, OFFER_PRIORITY Priority);

@DllImport("KERNEL32")
uint ReclaimVirtualMemory(char* VirtualAddress, size_t Size);

@DllImport("KERNEL32")
uint DiscardVirtualMemory(char* VirtualAddress, size_t Size);

@DllImport("api-ms-win-core-memory-l1-1-3")
BOOL SetProcessValidCallTargets(HANDLE hProcess, void* VirtualAddress, size_t RegionSize, uint NumberOfOffsets, 
                                char* OffsetInformation);

@DllImport("api-ms-win-core-memory-l1-1-7")
BOOL SetProcessValidCallTargetsForMappedView(HANDLE Process, void* VirtualAddress, size_t RegionSize, 
                                             uint NumberOfOffsets, char* OffsetInformation, HANDLE Section, 
                                             ulong ExpectedFileOffset);

@DllImport("api-ms-win-core-memory-l1-1-3")
void* VirtualAllocFromApp(void* BaseAddress, size_t Size, uint AllocationType, uint Protection);

@DllImport("api-ms-win-core-memory-l1-1-3")
BOOL VirtualProtectFromApp(void* Address, size_t Size, uint NewProtection, uint* OldProtection);

@DllImport("api-ms-win-core-memory-l1-1-3")
HANDLE OpenFileMappingFromApp(uint DesiredAccess, BOOL InheritHandle, const(wchar)* Name);

@DllImport("api-ms-win-core-memory-l1-1-4")
BOOL QueryVirtualMemoryInformation(HANDLE Process, const(void)* VirtualAddress, 
                                   WIN32_MEMORY_INFORMATION_CLASS MemoryInformationClass, char* MemoryInformation, 
                                   size_t MemoryInformationSize, size_t* ReturnSize);

@DllImport("api-ms-win-core-memory-l1-1-5")
void* MapViewOfFileNuma2(HANDLE FileMappingHandle, HANDLE ProcessHandle, ulong Offset, void* BaseAddress, 
                         size_t ViewSize, uint AllocationType, uint PageProtection, uint PreferredNode);

@DllImport("api-ms-win-core-memory-l1-1-5")
BOOL UnmapViewOfFile2(HANDLE Process, void* BaseAddress, uint UnmapFlags);

@DllImport("api-ms-win-core-memory-l1-1-5")
BOOL VirtualUnlockEx(HANDLE Process, void* Address, size_t Size);

@DllImport("api-ms-win-core-memory-l1-1-6")
void* VirtualAlloc2(HANDLE Process, void* BaseAddress, size_t Size, uint AllocationType, uint PageProtection, 
                    char* ExtendedParameters, uint ParameterCount);

@DllImport("api-ms-win-core-memory-l1-1-6")
void* MapViewOfFile3(HANDLE FileMapping, HANDLE Process, void* BaseAddress, ulong Offset, size_t ViewSize, 
                     uint AllocationType, uint PageProtection, char* ExtendedParameters, uint ParameterCount);

@DllImport("api-ms-win-core-memory-l1-1-6")
void* VirtualAlloc2FromApp(HANDLE Process, void* BaseAddress, size_t Size, uint AllocationType, 
                           uint PageProtection, char* ExtendedParameters, uint ParameterCount);

@DllImport("api-ms-win-core-memory-l1-1-6")
void* MapViewOfFile3FromApp(HANDLE FileMapping, HANDLE Process, void* BaseAddress, ulong Offset, size_t ViewSize, 
                            uint AllocationType, uint PageProtection, char* ExtendedParameters, uint ParameterCount);

@DllImport("api-ms-win-core-memory-l1-1-7")
HANDLE CreateFileMapping2(HANDLE File, SECURITY_ATTRIBUTES* SecurityAttributes, uint DesiredAccess, 
                          uint PageProtection, uint AllocationAttributes, ulong MaximumSize, const(wchar)* Name, 
                          char* ExtendedParameters, uint ParameterCount);

@DllImport("KERNEL32")
BOOL IsEnclaveTypeSupported(uint flEnclaveType);

@DllImport("KERNEL32")
void* CreateEnclave(HANDLE hProcess, void* lpAddress, size_t dwSize, size_t dwInitialCommitment, 
                    uint flEnclaveType, char* lpEnclaveInformation, uint dwInfoLength, uint* lpEnclaveError);

@DllImport("KERNEL32")
BOOL LoadEnclaveData(HANDLE hProcess, void* lpAddress, char* lpBuffer, size_t nSize, uint flProtect, 
                     char* lpPageInformation, uint dwInfoLength, size_t* lpNumberOfBytesWritten, 
                     uint* lpEnclaveError);

@DllImport("KERNEL32")
BOOL InitializeEnclave(HANDLE hProcess, void* lpAddress, char* lpEnclaveInformation, uint dwInfoLength, 
                       uint* lpEnclaveError);

@DllImport("api-ms-win-core-enclave-l1-1-1")
BOOL LoadEnclaveImageA(void* lpEnclaveAddress, const(char)* lpImageName);

@DllImport("api-ms-win-core-enclave-l1-1-1")
BOOL LoadEnclaveImageW(void* lpEnclaveAddress, const(wchar)* lpImageName);

@DllImport("api-ms-win-core-enclave-l1-1-1")
BOOL CallEnclave(LPENCLAVE_ROUTINE lpRoutine, void* lpParameter, BOOL fWaitForThread, void** lpReturnValue);

@DllImport("api-ms-win-core-enclave-l1-1-1")
BOOL TerminateEnclave(void* lpAddress, BOOL fWait);

@DllImport("api-ms-win-core-enclave-l1-1-1")
BOOL DeleteEnclave(void* lpAddress);

@DllImport("KERNEL32")
BOOL DisableThreadLibraryCalls(ptrdiff_t hLibModule);

@DllImport("KERNEL32")
ptrdiff_t FindResourceExW(ptrdiff_t hModule, const(wchar)* lpType, const(wchar)* lpName, ushort wLanguage);

@DllImport("KERNEL32")
BOOL FreeLibrary(ptrdiff_t hLibModule);

@DllImport("KERNEL32")
void FreeLibraryAndExitThread(ptrdiff_t hLibModule, uint dwExitCode);

@DllImport("KERNEL32")
uint GetModuleFileNameA(ptrdiff_t hModule, const(char)* lpFilename, uint nSize);

@DllImport("KERNEL32")
uint GetModuleFileNameW(ptrdiff_t hModule, const(wchar)* lpFilename, uint nSize);

@DllImport("KERNEL32")
ptrdiff_t GetModuleHandleA(const(char)* lpModuleName);

@DllImport("KERNEL32")
ptrdiff_t GetModuleHandleW(const(wchar)* lpModuleName);

@DllImport("KERNEL32")
BOOL GetModuleHandleExA(uint dwFlags, const(char)* lpModuleName, ptrdiff_t* phModule);

@DllImport("KERNEL32")
BOOL GetModuleHandleExW(uint dwFlags, const(wchar)* lpModuleName, ptrdiff_t* phModule);

@DllImport("KERNEL32")
FARPROC GetProcAddress(ptrdiff_t hModule, const(char)* lpProcName);

@DllImport("KERNEL32")
ptrdiff_t LoadLibraryExA(const(char)* lpLibFileName, HANDLE hFile, uint dwFlags);

@DllImport("KERNEL32")
ptrdiff_t LoadLibraryExW(const(wchar)* lpLibFileName, HANDLE hFile, uint dwFlags);

@DllImport("KERNEL32")
void* AddDllDirectory(const(wchar)* NewDirectory);

@DllImport("KERNEL32")
BOOL RemoveDllDirectory(void* Cookie);

@DllImport("KERNEL32")
BOOL SetDefaultDllDirectories(uint DirectoryFlags);

@DllImport("KERNEL32")
ptrdiff_t FindResourceW(ptrdiff_t hModule, const(wchar)* lpName, const(wchar)* lpType);

@DllImport("KERNEL32")
ptrdiff_t LoadLibraryA(const(char)* lpLibFileName);

@DllImport("KERNEL32")
ptrdiff_t LoadLibraryW(const(wchar)* lpLibFileName);

@DllImport("KERNEL32")
BOOL EnumResourceNamesW(ptrdiff_t hModule, const(wchar)* lpType, ENUMRESNAMEPROCW lpEnumFunc, ptrdiff_t lParam);

@DllImport("KERNEL32")
BOOL AllocConsole();

@DllImport("KERNEL32")
BOOL FreeConsole();

@DllImport("KERNEL32")
BOOL AttachConsole(uint dwProcessId);

@DllImport("KERNEL32")
uint GetConsoleCP();

@DllImport("KERNEL32")
uint GetConsoleOutputCP();

@DllImport("KERNEL32")
BOOL GetConsoleMode(HANDLE hConsoleHandle, uint* lpMode);

@DllImport("KERNEL32")
BOOL SetConsoleMode(HANDLE hConsoleHandle, uint dwMode);

@DllImport("KERNEL32")
BOOL GetNumberOfConsoleInputEvents(HANDLE hConsoleInput, uint* lpNumberOfEvents);

@DllImport("KERNEL32")
BOOL ReadConsoleInputA(HANDLE hConsoleInput, char* lpBuffer, uint nLength, uint* lpNumberOfEventsRead);

@DllImport("KERNEL32")
BOOL ReadConsoleInputW(HANDLE hConsoleInput, char* lpBuffer, uint nLength, uint* lpNumberOfEventsRead);

@DllImport("KERNEL32")
BOOL PeekConsoleInputA(HANDLE hConsoleInput, char* lpBuffer, uint nLength, uint* lpNumberOfEventsRead);

@DllImport("KERNEL32")
BOOL PeekConsoleInputW(HANDLE hConsoleInput, char* lpBuffer, uint nLength, uint* lpNumberOfEventsRead);

@DllImport("KERNEL32")
BOOL ReadConsoleA(HANDLE hConsoleInput, char* lpBuffer, uint nNumberOfCharsToRead, uint* lpNumberOfCharsRead, 
                  CONSOLE_READCONSOLE_CONTROL* pInputControl);

@DllImport("KERNEL32")
BOOL ReadConsoleW(HANDLE hConsoleInput, char* lpBuffer, uint nNumberOfCharsToRead, uint* lpNumberOfCharsRead, 
                  CONSOLE_READCONSOLE_CONTROL* pInputControl);

@DllImport("KERNEL32")
BOOL WriteConsoleA(HANDLE hConsoleOutput, char* lpBuffer, uint nNumberOfCharsToWrite, uint* lpNumberOfCharsWritten, 
                   void* lpReserved);

@DllImport("KERNEL32")
BOOL WriteConsoleW(HANDLE hConsoleOutput, char* lpBuffer, uint nNumberOfCharsToWrite, uint* lpNumberOfCharsWritten, 
                   void* lpReserved);

@DllImport("KERNEL32")
BOOL SetConsoleCtrlHandler(PHANDLER_ROUTINE HandlerRoutine, BOOL Add);

@DllImport("KERNEL32")
HRESULT CreatePseudoConsole(COORD size, HANDLE hInput, HANDLE hOutput, uint dwFlags, void** phPC);

@DllImport("KERNEL32")
HRESULT ResizePseudoConsole(void* hPC, COORD size);

@DllImport("KERNEL32")
void ClosePseudoConsole(void* hPC);

@DllImport("KERNEL32")
BOOL FillConsoleOutputCharacterA(HANDLE hConsoleOutput, byte cCharacter, uint nLength, COORD dwWriteCoord, 
                                 uint* lpNumberOfCharsWritten);

@DllImport("KERNEL32")
BOOL FillConsoleOutputCharacterW(HANDLE hConsoleOutput, ushort cCharacter, uint nLength, COORD dwWriteCoord, 
                                 uint* lpNumberOfCharsWritten);

@DllImport("KERNEL32")
BOOL FillConsoleOutputAttribute(HANDLE hConsoleOutput, ushort wAttribute, uint nLength, COORD dwWriteCoord, 
                                uint* lpNumberOfAttrsWritten);

@DllImport("KERNEL32")
BOOL GenerateConsoleCtrlEvent(uint dwCtrlEvent, uint dwProcessGroupId);

@DllImport("KERNEL32")
HANDLE CreateConsoleScreenBuffer(uint dwDesiredAccess, uint dwShareMode, 
                                 const(SECURITY_ATTRIBUTES)* lpSecurityAttributes, uint dwFlags, 
                                 void* lpScreenBufferData);

@DllImport("KERNEL32")
BOOL SetConsoleActiveScreenBuffer(HANDLE hConsoleOutput);

@DllImport("KERNEL32")
BOOL FlushConsoleInputBuffer(HANDLE hConsoleInput);

@DllImport("KERNEL32")
BOOL SetConsoleCP(uint wCodePageID);

@DllImport("KERNEL32")
BOOL SetConsoleOutputCP(uint wCodePageID);

@DllImport("KERNEL32")
BOOL GetConsoleCursorInfo(HANDLE hConsoleOutput, CONSOLE_CURSOR_INFO* lpConsoleCursorInfo);

@DllImport("KERNEL32")
BOOL SetConsoleCursorInfo(HANDLE hConsoleOutput, const(CONSOLE_CURSOR_INFO)* lpConsoleCursorInfo);

@DllImport("KERNEL32")
BOOL GetConsoleScreenBufferInfo(HANDLE hConsoleOutput, CONSOLE_SCREEN_BUFFER_INFO* lpConsoleScreenBufferInfo);

@DllImport("KERNEL32")
BOOL GetConsoleScreenBufferInfoEx(HANDLE hConsoleOutput, CONSOLE_SCREEN_BUFFER_INFOEX* lpConsoleScreenBufferInfoEx);

@DllImport("KERNEL32")
BOOL SetConsoleScreenBufferInfoEx(HANDLE hConsoleOutput, CONSOLE_SCREEN_BUFFER_INFOEX* lpConsoleScreenBufferInfoEx);

@DllImport("KERNEL32")
BOOL SetConsoleScreenBufferSize(HANDLE hConsoleOutput, COORD dwSize);

@DllImport("KERNEL32")
BOOL SetConsoleCursorPosition(HANDLE hConsoleOutput, COORD dwCursorPosition);

@DllImport("KERNEL32")
COORD GetLargestConsoleWindowSize(HANDLE hConsoleOutput);

@DllImport("KERNEL32")
BOOL SetConsoleTextAttribute(HANDLE hConsoleOutput, ushort wAttributes);

@DllImport("KERNEL32")
BOOL SetConsoleWindowInfo(HANDLE hConsoleOutput, BOOL bAbsolute, const(SMALL_RECT)* lpConsoleWindow);

@DllImport("KERNEL32")
BOOL WriteConsoleOutputCharacterA(HANDLE hConsoleOutput, const(char)* lpCharacter, uint nLength, 
                                  COORD dwWriteCoord, uint* lpNumberOfCharsWritten);

@DllImport("KERNEL32")
BOOL WriteConsoleOutputCharacterW(HANDLE hConsoleOutput, const(wchar)* lpCharacter, uint nLength, 
                                  COORD dwWriteCoord, uint* lpNumberOfCharsWritten);

@DllImport("KERNEL32")
BOOL WriteConsoleOutputAttribute(HANDLE hConsoleOutput, char* lpAttribute, uint nLength, COORD dwWriteCoord, 
                                 uint* lpNumberOfAttrsWritten);

@DllImport("KERNEL32")
BOOL ReadConsoleOutputCharacterA(HANDLE hConsoleOutput, const(char)* lpCharacter, uint nLength, COORD dwReadCoord, 
                                 uint* lpNumberOfCharsRead);

@DllImport("KERNEL32")
BOOL ReadConsoleOutputCharacterW(HANDLE hConsoleOutput, const(wchar)* lpCharacter, uint nLength, COORD dwReadCoord, 
                                 uint* lpNumberOfCharsRead);

@DllImport("KERNEL32")
BOOL ReadConsoleOutputAttribute(HANDLE hConsoleOutput, char* lpAttribute, uint nLength, COORD dwReadCoord, 
                                uint* lpNumberOfAttrsRead);

@DllImport("KERNEL32")
BOOL WriteConsoleInputA(HANDLE hConsoleInput, char* lpBuffer, uint nLength, uint* lpNumberOfEventsWritten);

@DllImport("KERNEL32")
BOOL WriteConsoleInputW(HANDLE hConsoleInput, char* lpBuffer, uint nLength, uint* lpNumberOfEventsWritten);

@DllImport("KERNEL32")
BOOL ScrollConsoleScreenBufferA(HANDLE hConsoleOutput, const(SMALL_RECT)* lpScrollRectangle, 
                                const(SMALL_RECT)* lpClipRectangle, COORD dwDestinationOrigin, 
                                const(CHAR_INFO)* lpFill);

@DllImport("KERNEL32")
BOOL ScrollConsoleScreenBufferW(HANDLE hConsoleOutput, const(SMALL_RECT)* lpScrollRectangle, 
                                const(SMALL_RECT)* lpClipRectangle, COORD dwDestinationOrigin, 
                                const(CHAR_INFO)* lpFill);

@DllImport("KERNEL32")
BOOL WriteConsoleOutputA(HANDLE hConsoleOutput, char* lpBuffer, COORD dwBufferSize, COORD dwBufferCoord, 
                         SMALL_RECT* lpWriteRegion);

@DllImport("KERNEL32")
BOOL WriteConsoleOutputW(HANDLE hConsoleOutput, char* lpBuffer, COORD dwBufferSize, COORD dwBufferCoord, 
                         SMALL_RECT* lpWriteRegion);

@DllImport("KERNEL32")
BOOL ReadConsoleOutputA(HANDLE hConsoleOutput, char* lpBuffer, COORD dwBufferSize, COORD dwBufferCoord, 
                        SMALL_RECT* lpReadRegion);

@DllImport("KERNEL32")
BOOL ReadConsoleOutputW(HANDLE hConsoleOutput, char* lpBuffer, COORD dwBufferSize, COORD dwBufferCoord, 
                        SMALL_RECT* lpReadRegion);

@DllImport("KERNEL32")
uint GetConsoleTitleA(const(char)* lpConsoleTitle, uint nSize);

@DllImport("KERNEL32")
uint GetConsoleTitleW(const(wchar)* lpConsoleTitle, uint nSize);

@DllImport("KERNEL32")
uint GetConsoleOriginalTitleA(const(char)* lpConsoleTitle, uint nSize);

@DllImport("KERNEL32")
uint GetConsoleOriginalTitleW(const(wchar)* lpConsoleTitle, uint nSize);

@DllImport("KERNEL32")
BOOL SetConsoleTitleA(const(char)* lpConsoleTitle);

@DllImport("KERNEL32")
BOOL SetConsoleTitleW(const(wchar)* lpConsoleTitle);

@DllImport("KERNEL32")
BOOL GetNumberOfConsoleMouseButtons(uint* lpNumberOfMouseButtons);

@DllImport("KERNEL32")
COORD GetConsoleFontSize(HANDLE hConsoleOutput, uint nFont);

@DllImport("KERNEL32")
BOOL GetCurrentConsoleFont(HANDLE hConsoleOutput, BOOL bMaximumWindow, CONSOLE_FONT_INFO* lpConsoleCurrentFont);

@DllImport("KERNEL32")
BOOL GetCurrentConsoleFontEx(HANDLE hConsoleOutput, BOOL bMaximumWindow, 
                             CONSOLE_FONT_INFOEX* lpConsoleCurrentFontEx);

@DllImport("KERNEL32")
BOOL SetCurrentConsoleFontEx(HANDLE hConsoleOutput, BOOL bMaximumWindow, 
                             CONSOLE_FONT_INFOEX* lpConsoleCurrentFontEx);

@DllImport("KERNEL32")
BOOL GetConsoleSelectionInfo(CONSOLE_SELECTION_INFO* lpConsoleSelectionInfo);

@DllImport("KERNEL32")
BOOL GetConsoleHistoryInfo(CONSOLE_HISTORY_INFO* lpConsoleHistoryInfo);

@DllImport("KERNEL32")
BOOL SetConsoleHistoryInfo(CONSOLE_HISTORY_INFO* lpConsoleHistoryInfo);

@DllImport("KERNEL32")
BOOL GetConsoleDisplayMode(uint* lpModeFlags);

@DllImport("KERNEL32")
BOOL SetConsoleDisplayMode(HANDLE hConsoleOutput, uint dwFlags, COORD* lpNewScreenBufferDimensions);

@DllImport("KERNEL32")
HWND GetConsoleWindow();

@DllImport("KERNEL32")
BOOL AddConsoleAliasA(const(char)* Source, const(char)* Target, const(char)* ExeName);

@DllImport("KERNEL32")
BOOL AddConsoleAliasW(const(wchar)* Source, const(wchar)* Target, const(wchar)* ExeName);

@DllImport("KERNEL32")
uint GetConsoleAliasA(const(char)* Source, const(char)* TargetBuffer, uint TargetBufferLength, 
                      const(char)* ExeName);

@DllImport("KERNEL32")
uint GetConsoleAliasW(const(wchar)* Source, const(wchar)* TargetBuffer, uint TargetBufferLength, 
                      const(wchar)* ExeName);

@DllImport("KERNEL32")
uint GetConsoleAliasesLengthA(const(char)* ExeName);

@DllImport("KERNEL32")
uint GetConsoleAliasesLengthW(const(wchar)* ExeName);

@DllImport("KERNEL32")
uint GetConsoleAliasExesLengthA();

@DllImport("KERNEL32")
uint GetConsoleAliasExesLengthW();

@DllImport("KERNEL32")
uint GetConsoleAliasesA(const(char)* AliasBuffer, uint AliasBufferLength, const(char)* ExeName);

@DllImport("KERNEL32")
uint GetConsoleAliasesW(const(wchar)* AliasBuffer, uint AliasBufferLength, const(wchar)* ExeName);

@DllImport("KERNEL32")
uint GetConsoleAliasExesA(const(char)* ExeNameBuffer, uint ExeNameBufferLength);

@DllImport("KERNEL32")
uint GetConsoleAliasExesW(const(wchar)* ExeNameBuffer, uint ExeNameBufferLength);

@DllImport("KERNEL32")
void ExpungeConsoleCommandHistoryA(const(char)* ExeName);

@DllImport("KERNEL32")
void ExpungeConsoleCommandHistoryW(const(wchar)* ExeName);

@DllImport("KERNEL32")
BOOL SetConsoleNumberOfCommandsA(uint Number, const(char)* ExeName);

@DllImport("KERNEL32")
BOOL SetConsoleNumberOfCommandsW(uint Number, const(wchar)* ExeName);

@DllImport("KERNEL32")
uint GetConsoleCommandHistoryLengthA(const(char)* ExeName);

@DllImport("KERNEL32")
uint GetConsoleCommandHistoryLengthW(const(wchar)* ExeName);

@DllImport("KERNEL32")
uint GetConsoleCommandHistoryA(const(char)* Commands, uint CommandBufferLength, const(char)* ExeName);

@DllImport("KERNEL32")
uint GetConsoleCommandHistoryW(const(wchar)* Commands, uint CommandBufferLength, const(wchar)* ExeName);

@DllImport("KERNEL32")
uint GetConsoleProcessList(char* lpdwProcessList, uint dwProcessCount);

@DllImport("WINMM")
uint timeSetEvent(uint uDelay, uint uResolution, LPTIMECALLBACK fptc, size_t dwUser, uint fuEvent);

@DllImport("WINMM")
uint timeKillEvent(uint uTimerID);

@DllImport("RPCNS4")
int I_RpcNsGetBuffer(RPC_MESSAGE* Message);

@DllImport("RPCNS4")
int I_RpcNsSendReceive(RPC_MESSAGE* Message, void** Handle);

@DllImport("RPCNS4")
void I_RpcNsRaiseException(RPC_MESSAGE* Message, int Status);

@DllImport("RPCNS4")
int I_RpcReBindBuffer(RPC_MESSAGE* Message);

@DllImport("WINSPOOL")
BOOL EnumPrintersA(uint Flags, const(char)* Name, uint Level, char* pPrinterEnum, uint cbBuf, uint* pcbNeeded, 
                   uint* pcReturned);

@DllImport("WINSPOOL")
BOOL EnumPrintersW(uint Flags, const(wchar)* Name, uint Level, char* pPrinterEnum, uint cbBuf, uint* pcbNeeded, 
                   uint* pcReturned);

@DllImport("WINSPOOL")
HANDLE GetSpoolFileHandle(HANDLE hPrinter);

@DllImport("WINSPOOL")
HANDLE CommitSpoolData(HANDLE hPrinter, HANDLE hSpoolFile, uint cbCommit);

@DllImport("WINSPOOL")
BOOL CloseSpoolFileHandle(HANDLE hPrinter, HANDLE hSpoolFile);

@DllImport("WINSPOOL")
BOOL OpenPrinterA(const(char)* pPrinterName, ptrdiff_t* phPrinter, PRINTER_DEFAULTSA* pDefault);

@DllImport("WINSPOOL")
BOOL OpenPrinterW(const(wchar)* pPrinterName, ptrdiff_t* phPrinter, PRINTER_DEFAULTSW* pDefault);

@DllImport("WINSPOOL")
BOOL ResetPrinterA(HANDLE hPrinter, PRINTER_DEFAULTSA* pDefault);

@DllImport("SPOOLSS")
BOOL ResetPrinterW(HANDLE hPrinter, PRINTER_DEFAULTSW* pDefault);

@DllImport("WINSPOOL")
BOOL SetJobA(HANDLE hPrinter, uint JobId, uint Level, char* pJob, uint Command);

@DllImport("WINSPOOL")
BOOL SetJobW(HANDLE hPrinter, uint JobId, uint Level, char* pJob, uint Command);

@DllImport("WINSPOOL")
BOOL GetJobA(HANDLE hPrinter, uint JobId, uint Level, char* pJob, uint cbBuf, uint* pcbNeeded);

@DllImport("WINSPOOL")
BOOL GetJobW(HANDLE hPrinter, uint JobId, uint Level, char* pJob, uint cbBuf, uint* pcbNeeded);

@DllImport("WINSPOOL")
BOOL EnumJobsA(HANDLE hPrinter, uint FirstJob, uint NoJobs, uint Level, char* pJob, uint cbBuf, uint* pcbNeeded, 
               uint* pcReturned);

@DllImport("WINSPOOL")
BOOL EnumJobsW(HANDLE hPrinter, uint FirstJob, uint NoJobs, uint Level, char* pJob, uint cbBuf, uint* pcbNeeded, 
               uint* pcReturned);

@DllImport("WINSPOOL")
HANDLE AddPrinterA(const(char)* pName, uint Level, char* pPrinter);

@DllImport("WINSPOOL")
HANDLE AddPrinterW(const(wchar)* pName, uint Level, char* pPrinter);

@DllImport("WINSPOOL")
BOOL DeletePrinter(HANDLE hPrinter);

@DllImport("WINSPOOL")
BOOL SetPrinterA(HANDLE hPrinter, uint Level, char* pPrinter, uint Command);

@DllImport("WINSPOOL")
BOOL SetPrinterW(HANDLE hPrinter, uint Level, char* pPrinter, uint Command);

@DllImport("WINSPOOL")
BOOL GetPrinterA(HANDLE hPrinter, uint Level, char* pPrinter, uint cbBuf, uint* pcbNeeded);

@DllImport("WINSPOOL")
BOOL GetPrinterW(HANDLE hPrinter, uint Level, char* pPrinter, uint cbBuf, uint* pcbNeeded);

@DllImport("WINSPOOL")
BOOL AddPrinterDriverA(const(char)* pName, uint Level, ubyte* pDriverInfo);

@DllImport("SPOOLSS")
BOOL AddPrinterDriverW(const(wchar)* pName, uint Level, ubyte* pDriverInfo);

@DllImport("WINSPOOL")
BOOL AddPrinterDriverExA(const(char)* pName, uint Level, char* lpbDriverInfo, uint dwFileCopyFlags);

@DllImport("SPOOLSS")
BOOL AddPrinterDriverExW(const(wchar)* pName, uint Level, char* lpbDriverInfo, uint dwFileCopyFlags);

@DllImport("WINSPOOL")
BOOL EnumPrinterDriversA(const(char)* pName, const(char)* pEnvironment, uint Level, char* pDriverInfo, uint cbBuf, 
                         uint* pcbNeeded, uint* pcReturned);

@DllImport("WINSPOOL")
BOOL EnumPrinterDriversW(const(wchar)* pName, const(wchar)* pEnvironment, uint Level, char* pDriverInfo, 
                         uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("WINSPOOL")
BOOL GetPrinterDriverA(HANDLE hPrinter, const(char)* pEnvironment, uint Level, char* pDriverInfo, uint cbBuf, 
                       uint* pcbNeeded);

@DllImport("WINSPOOL")
BOOL GetPrinterDriverW(HANDLE hPrinter, const(wchar)* pEnvironment, uint Level, char* pDriverInfo, uint cbBuf, 
                       uint* pcbNeeded);

@DllImport("WINSPOOL")
BOOL GetPrinterDriverDirectoryA(const(char)* pName, const(char)* pEnvironment, uint Level, char* pDriverDirectory, 
                                uint cbBuf, uint* pcbNeeded);

@DllImport("WINSPOOL")
BOOL GetPrinterDriverDirectoryW(const(wchar)* pName, const(wchar)* pEnvironment, uint Level, 
                                char* pDriverDirectory, uint cbBuf, uint* pcbNeeded);

@DllImport("WINSPOOL")
BOOL DeletePrinterDriverA(const(char)* pName, const(char)* pEnvironment, const(char)* pDriverName);

@DllImport("SPOOLSS")
BOOL DeletePrinterDriverW(const(wchar)* pName, const(wchar)* pEnvironment, const(wchar)* pDriverName);

@DllImport("WINSPOOL")
BOOL DeletePrinterDriverExA(const(char)* pName, const(char)* pEnvironment, const(char)* pDriverName, 
                            uint dwDeleteFlag, uint dwVersionFlag);

@DllImport("SPOOLSS")
BOOL DeletePrinterDriverExW(const(wchar)* pName, const(wchar)* pEnvironment, const(wchar)* pDriverName, 
                            uint dwDeleteFlag, uint dwVersionFlag);

@DllImport("WINSPOOL")
BOOL AddPrintProcessorA(const(char)* pName, const(char)* pEnvironment, const(char)* pPathName, 
                        const(char)* pPrintProcessorName);

@DllImport("SPOOLSS")
BOOL AddPrintProcessorW(const(wchar)* pName, const(wchar)* pEnvironment, const(wchar)* pPathName, 
                        const(wchar)* pPrintProcessorName);

@DllImport("WINSPOOL")
BOOL EnumPrintProcessorsA(const(char)* pName, const(char)* pEnvironment, uint Level, char* pPrintProcessorInfo, 
                          uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("SPOOLSS")
BOOL EnumPrintProcessorsW(const(wchar)* pName, const(wchar)* pEnvironment, uint Level, char* pPrintProcessorInfo, 
                          uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("WINSPOOL")
BOOL GetPrintProcessorDirectoryA(const(char)* pName, const(char)* pEnvironment, uint Level, 
                                 char* pPrintProcessorInfo, uint cbBuf, uint* pcbNeeded);

@DllImport("SPOOLSS")
BOOL GetPrintProcessorDirectoryW(const(wchar)* pName, const(wchar)* pEnvironment, uint Level, 
                                 char* pPrintProcessorInfo, uint cbBuf, uint* pcbNeeded);

@DllImport("WINSPOOL")
BOOL EnumPrintProcessorDatatypesA(const(char)* pName, const(char)* pPrintProcessorName, uint Level, 
                                  char* pDatatypes, uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("SPOOLSS")
BOOL EnumPrintProcessorDatatypesW(const(wchar)* pName, const(wchar)* pPrintProcessorName, uint Level, 
                                  char* pDatatypes, uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("WINSPOOL")
BOOL DeletePrintProcessorA(const(char)* pName, const(char)* pEnvironment, const(char)* pPrintProcessorName);

@DllImport("SPOOLSS")
BOOL DeletePrintProcessorW(const(wchar)* pName, const(wchar)* pEnvironment, const(wchar)* pPrintProcessorName);

@DllImport("WINSPOOL")
uint StartDocPrinterA(HANDLE hPrinter, uint Level, char* pDocInfo);

@DllImport("WINSPOOL")
uint StartDocPrinterW(HANDLE hPrinter, uint Level, char* pDocInfo);

@DllImport("SPOOLSS")
BOOL StartPagePrinter(HANDLE hPrinter);

@DllImport("WINSPOOL")
BOOL WritePrinter(HANDLE hPrinter, char* pBuf, uint cbBuf, uint* pcWritten);

@DllImport("SPOOLSS")
BOOL FlushPrinter(HANDLE hPrinter, char* pBuf, uint cbBuf, uint* pcWritten, uint cSleep);

@DllImport("SPOOLSS")
BOOL EndPagePrinter(HANDLE hPrinter);

@DllImport("WINSPOOL")
BOOL AbortPrinter(HANDLE hPrinter);

@DllImport("SPOOLSS")
BOOL ReadPrinter(HANDLE hPrinter, char* pBuf, uint cbBuf, uint* pNoBytesRead);

@DllImport("WINSPOOL")
BOOL EndDocPrinter(HANDLE hPrinter);

@DllImport("WINSPOOL")
BOOL AddJobA(HANDLE hPrinter, uint Level, char* pData, uint cbBuf, uint* pcbNeeded);

@DllImport("SPOOLSS")
BOOL AddJobW(HANDLE hPrinter, uint Level, char* pData, uint cbBuf, uint* pcbNeeded);

@DllImport("SPOOLSS")
BOOL ScheduleJob(HANDLE hPrinter, uint JobId);

@DllImport("WINSPOOL")
BOOL PrinterProperties(HWND hWnd, HANDLE hPrinter);

@DllImport("WINSPOOL")
int DocumentPropertiesA(HWND hWnd, HANDLE hPrinter, const(char)* pDeviceName, DEVMODEA* pDevModeOutput, 
                        DEVMODEA* pDevModeInput, uint fMode);

@DllImport("WINSPOOL")
int DocumentPropertiesW(HWND hWnd, HANDLE hPrinter, const(wchar)* pDeviceName, DEVMODEW* pDevModeOutput, 
                        DEVMODEW* pDevModeInput, uint fMode);

@DllImport("WINSPOOL")
int AdvancedDocumentPropertiesA(HWND hWnd, HANDLE hPrinter, const(char)* pDeviceName, DEVMODEA* pDevModeOutput, 
                                DEVMODEA* pDevModeInput);

@DllImport("WINSPOOL")
int AdvancedDocumentPropertiesW(HWND hWnd, HANDLE hPrinter, const(wchar)* pDeviceName, DEVMODEW* pDevModeOutput, 
                                DEVMODEW* pDevModeInput);

@DllImport("WINSPOOL")
uint GetPrinterDataA(HANDLE hPrinter, const(char)* pValueName, uint* pType, char* pData, uint nSize, 
                     uint* pcbNeeded);

@DllImport("WINSPOOL")
uint GetPrinterDataW(HANDLE hPrinter, const(wchar)* pValueName, uint* pType, char* pData, uint nSize, 
                     uint* pcbNeeded);

@DllImport("WINSPOOL")
uint GetPrinterDataExA(HANDLE hPrinter, const(char)* pKeyName, const(char)* pValueName, uint* pType, char* pData, 
                       uint nSize, uint* pcbNeeded);

@DllImport("WINSPOOL")
uint GetPrinterDataExW(HANDLE hPrinter, const(wchar)* pKeyName, const(wchar)* pValueName, uint* pType, char* pData, 
                       uint nSize, uint* pcbNeeded);

@DllImport("WINSPOOL")
uint EnumPrinterDataA(HANDLE hPrinter, uint dwIndex, const(char)* pValueName, uint cbValueName, uint* pcbValueName, 
                      uint* pType, char* pData, uint cbData, uint* pcbData);

@DllImport("SPOOLSS")
uint EnumPrinterDataW(HANDLE hPrinter, uint dwIndex, const(wchar)* pValueName, uint cbValueName, 
                      uint* pcbValueName, uint* pType, char* pData, uint cbData, uint* pcbData);

@DllImport("WINSPOOL")
uint EnumPrinterDataExA(HANDLE hPrinter, const(char)* pKeyName, char* pEnumValues, uint cbEnumValues, 
                        uint* pcbEnumValues, uint* pnEnumValues);

@DllImport("SPOOLSS")
uint EnumPrinterDataExW(HANDLE hPrinter, const(wchar)* pKeyName, char* pEnumValues, uint cbEnumValues, 
                        uint* pcbEnumValues, uint* pnEnumValues);

@DllImport("WINSPOOL")
uint EnumPrinterKeyA(HANDLE hPrinter, const(char)* pKeyName, const(char)* pSubkey, uint cbSubkey, uint* pcbSubkey);

@DllImport("SPOOLSS")
uint EnumPrinterKeyW(HANDLE hPrinter, const(wchar)* pKeyName, const(wchar)* pSubkey, uint cbSubkey, 
                     uint* pcbSubkey);

@DllImport("WINSPOOL")
uint SetPrinterDataA(HANDLE hPrinter, const(char)* pValueName, uint Type, char* pData, uint cbData);

@DllImport("WINSPOOL")
uint SetPrinterDataW(HANDLE hPrinter, const(wchar)* pValueName, uint Type, char* pData, uint cbData);

@DllImport("WINSPOOL")
uint SetPrinterDataExA(HANDLE hPrinter, const(char)* pKeyName, const(char)* pValueName, uint Type, char* pData, 
                       uint cbData);

@DllImport("WINSPOOL")
uint SetPrinterDataExW(HANDLE hPrinter, const(wchar)* pKeyName, const(wchar)* pValueName, uint Type, char* pData, 
                       uint cbData);

@DllImport("WINSPOOL")
uint DeletePrinterDataA(HANDLE hPrinter, const(char)* pValueName);

@DllImport("WINSPOOL")
uint DeletePrinterDataW(HANDLE hPrinter, const(wchar)* pValueName);

@DllImport("WINSPOOL")
uint DeletePrinterDataExA(HANDLE hPrinter, const(char)* pKeyName, const(char)* pValueName);

@DllImport("WINSPOOL")
uint DeletePrinterDataExW(HANDLE hPrinter, const(wchar)* pKeyName, const(wchar)* pValueName);

@DllImport("WINSPOOL")
uint DeletePrinterKeyA(HANDLE hPrinter, const(char)* pKeyName);

@DllImport("SPOOLSS")
uint DeletePrinterKeyW(HANDLE hPrinter, const(wchar)* pKeyName);

@DllImport("SPOOLSS")
uint WaitForPrinterChange(HANDLE hPrinter, uint Flags);

@DllImport("WINSPOOL")
HANDLE FindFirstPrinterChangeNotification(HANDLE hPrinter, uint fdwFilter, uint fdwOptions, 
                                          void* pPrinterNotifyOptions);

@DllImport("WINSPOOL")
BOOL FindNextPrinterChangeNotification(HANDLE hChange, uint* pdwChange, void* pvReserved, 
                                       void** ppPrinterNotifyInfo);

@DllImport("WINSPOOL")
BOOL FreePrinterNotifyInfo(PRINTER_NOTIFY_INFO* pPrinterNotifyInfo);

@DllImport("SPOOLSS")
BOOL FindClosePrinterChangeNotification(HANDLE hChange);

@DllImport("WINSPOOL")
uint PrinterMessageBoxA(HANDLE hPrinter, uint Error, HWND hWnd, const(char)* pText, const(char)* pCaption, 
                        uint dwType);

@DllImport("SPOOLSS")
uint PrinterMessageBoxW(HANDLE hPrinter, uint Error, HWND hWnd, const(wchar)* pText, const(wchar)* pCaption, 
                        uint dwType);

@DllImport("WINSPOOL")
BOOL ClosePrinter(HANDLE hPrinter);

@DllImport("WINSPOOL")
BOOL AddFormA(HANDLE hPrinter, uint Level, char* pForm);

@DllImport("SPOOLSS")
BOOL AddFormW(HANDLE hPrinter, uint Level, char* pForm);

@DllImport("WINSPOOL")
BOOL DeleteFormA(HANDLE hPrinter, const(char)* pFormName);

@DllImport("SPOOLSS")
BOOL DeleteFormW(HANDLE hPrinter, const(wchar)* pFormName);

@DllImport("WINSPOOL")
BOOL GetFormA(HANDLE hPrinter, const(char)* pFormName, uint Level, char* pForm, uint cbBuf, uint* pcbNeeded);

@DllImport("SPOOLSS")
BOOL GetFormW(HANDLE hPrinter, const(wchar)* pFormName, uint Level, char* pForm, uint cbBuf, uint* pcbNeeded);

@DllImport("WINSPOOL")
BOOL SetFormA(HANDLE hPrinter, const(char)* pFormName, uint Level, char* pForm);

@DllImport("SPOOLSS")
BOOL SetFormW(HANDLE hPrinter, const(wchar)* pFormName, uint Level, char* pForm);

@DllImport("WINSPOOL")
BOOL EnumFormsA(HANDLE hPrinter, uint Level, char* pForm, uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("SPOOLSS")
BOOL EnumFormsW(HANDLE hPrinter, uint Level, char* pForm, uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("WINSPOOL")
BOOL EnumMonitorsA(const(char)* pName, uint Level, char* pMonitor, uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("SPOOLSS")
BOOL EnumMonitorsW(const(wchar)* pName, uint Level, char* pMonitor, uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("WINSPOOL")
BOOL AddMonitorA(const(char)* pName, uint Level, char* pMonitors);

@DllImport("SPOOLSS")
BOOL AddMonitorW(const(wchar)* pName, uint Level, char* pMonitors);

@DllImport("WINSPOOL")
BOOL DeleteMonitorA(const(char)* pName, const(char)* pEnvironment, const(char)* pMonitorName);

@DllImport("SPOOLSS")
BOOL DeleteMonitorW(const(wchar)* pName, const(wchar)* pEnvironment, const(wchar)* pMonitorName);

@DllImport("WINSPOOL")
BOOL EnumPortsA(const(char)* pName, uint Level, char* pPort, uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("WINSPOOL")
BOOL EnumPortsW(const(wchar)* pName, uint Level, char* pPort, uint cbBuf, uint* pcbNeeded, uint* pcReturned);

@DllImport("WINSPOOL")
BOOL AddPortA(const(char)* pName, HWND hWnd, const(char)* pMonitorName);

@DllImport("SPOOLSS")
BOOL AddPortW(const(wchar)* pName, HWND hWnd, const(wchar)* pMonitorName);

@DllImport("WINSPOOL")
BOOL ConfigurePortA(const(char)* pName, HWND hWnd, const(char)* pPortName);

@DllImport("SPOOLSS")
BOOL ConfigurePortW(const(wchar)* pName, HWND hWnd, const(wchar)* pPortName);

@DllImport("WINSPOOL")
BOOL DeletePortA(const(char)* pName, HWND hWnd, const(char)* pPortName);

@DllImport("SPOOLSS")
BOOL DeletePortW(const(wchar)* pName, HWND hWnd, const(wchar)* pPortName);

@DllImport("WINSPOOL")
BOOL XcvDataW(HANDLE hXcv, const(wchar)* pszDataName, char* pInputData, uint cbInputData, char* pOutputData, 
              uint cbOutputData, uint* pcbOutputNeeded, uint* pdwStatus);

@DllImport("WINSPOOL")
BOOL GetDefaultPrinterA(const(char)* pszBuffer, uint* pcchBuffer);

@DllImport("WINSPOOL")
BOOL GetDefaultPrinterW(const(wchar)* pszBuffer, uint* pcchBuffer);

@DllImport("WINSPOOL")
BOOL SetDefaultPrinterA(const(char)* pszPrinter);

@DllImport("WINSPOOL")
BOOL SetDefaultPrinterW(const(wchar)* pszPrinter);

@DllImport("WINSPOOL")
BOOL SetPortA(const(char)* pName, const(char)* pPortName, uint dwLevel, char* pPortInfo);

@DllImport("SPOOLSS")
BOOL SetPortW(const(wchar)* pName, const(wchar)* pPortName, uint dwLevel, char* pPortInfo);

@DllImport("WINSPOOL")
BOOL AddPrinterConnectionA(const(char)* pName);

@DllImport("WINSPOOL")
BOOL AddPrinterConnectionW(const(wchar)* pName);

@DllImport("WINSPOOL")
BOOL DeletePrinterConnectionA(const(char)* pName);

@DllImport("WINSPOOL")
BOOL DeletePrinterConnectionW(const(wchar)* pName);

@DllImport("WINSPOOL")
HANDLE ConnectToPrinterDlg(HWND hwnd, uint Flags);

@DllImport("WINSPOOL")
BOOL AddPrintProvidorA(const(char)* pName, uint Level, char* pProvidorInfo);

@DllImport("SPOOLSS")
BOOL AddPrintProvidorW(const(wchar)* pName, uint Level, char* pProvidorInfo);

@DllImport("WINSPOOL")
BOOL DeletePrintProvidorA(const(char)* pName, const(char)* pEnvironment, const(char)* pPrintProvidorName);

@DllImport("SPOOLSS")
BOOL DeletePrintProvidorW(const(wchar)* pName, const(wchar)* pEnvironment, const(wchar)* pPrintProvidorName);

@DllImport("WINSPOOL")
BOOL IsValidDevmodeA(DEVMODEA* pDevmode, size_t DevmodeSize);

@DllImport("WINSPOOL")
BOOL IsValidDevmodeW(DEVMODEW* pDevmode, size_t DevmodeSize);

@DllImport("WINSPOOL")
BOOL OpenPrinter2A(const(char)* pPrinterName, ptrdiff_t* phPrinter, PRINTER_DEFAULTSA* pDefault, 
                   PRINTER_OPTIONSA* pOptions);

@DllImport("SPOOLSS")
BOOL OpenPrinter2W(const(wchar)* pPrinterName, ptrdiff_t* phPrinter, PRINTER_DEFAULTSW* pDefault, 
                   PRINTER_OPTIONSW* pOptions);

@DllImport("WINSPOOL")
BOOL AddPrinterConnection2A(HWND hWnd, const(char)* pszName, uint dwLevel, void* pConnectionInfo);

@DllImport("WINSPOOL")
BOOL AddPrinterConnection2W(HWND hWnd, const(wchar)* pszName, uint dwLevel, void* pConnectionInfo);

@DllImport("WINSPOOL")
HRESULT InstallPrinterDriverFromPackageA(const(char)* pszServer, const(char)* pszInfPath, 
                                         const(char)* pszDriverName, const(char)* pszEnvironment, uint dwFlags);

@DllImport("WINSPOOL")
HRESULT InstallPrinterDriverFromPackageW(const(wchar)* pszServer, const(wchar)* pszInfPath, 
                                         const(wchar)* pszDriverName, const(wchar)* pszEnvironment, uint dwFlags);

@DllImport("WINSPOOL")
HRESULT UploadPrinterDriverPackageA(const(char)* pszServer, const(char)* pszInfPath, const(char)* pszEnvironment, 
                                    uint dwFlags, HWND hwnd, const(char)* pszDestInfPath, uint* pcchDestInfPath);

@DllImport("WINSPOOL")
HRESULT UploadPrinterDriverPackageW(const(wchar)* pszServer, const(wchar)* pszInfPath, 
                                    const(wchar)* pszEnvironment, uint dwFlags, HWND hwnd, 
                                    const(wchar)* pszDestInfPath, uint* pcchDestInfPath);

@DllImport("WINSPOOL")
HRESULT GetCorePrinterDriversA(const(char)* pszServer, const(char)* pszEnvironment, 
                               const(char)* pszzCoreDriverDependencies, uint cCorePrinterDrivers, 
                               char* pCorePrinterDrivers);

@DllImport("WINSPOOL")
HRESULT GetCorePrinterDriversW(const(wchar)* pszServer, const(wchar)* pszEnvironment, 
                               const(wchar)* pszzCoreDriverDependencies, uint cCorePrinterDrivers, 
                               char* pCorePrinterDrivers);

@DllImport("WINSPOOL")
HRESULT CorePrinterDriverInstalledA(const(char)* pszServer, const(char)* pszEnvironment, GUID CoreDriverGUID, 
                                    FILETIME ftDriverDate, ulong dwlDriverVersion, int* pbDriverInstalled);

@DllImport("WINSPOOL")
HRESULT CorePrinterDriverInstalledW(const(wchar)* pszServer, const(wchar)* pszEnvironment, GUID CoreDriverGUID, 
                                    FILETIME ftDriverDate, ulong dwlDriverVersion, int* pbDriverInstalled);

@DllImport("WINSPOOL")
HRESULT GetPrinterDriverPackagePathA(const(char)* pszServer, const(char)* pszEnvironment, const(char)* pszLanguage, 
                                     const(char)* pszPackageID, const(char)* pszDriverPackageCab, 
                                     uint cchDriverPackageCab, uint* pcchRequiredSize);

@DllImport("WINSPOOL")
HRESULT GetPrinterDriverPackagePathW(const(wchar)* pszServer, const(wchar)* pszEnvironment, 
                                     const(wchar)* pszLanguage, const(wchar)* pszPackageID, 
                                     const(wchar)* pszDriverPackageCab, uint cchDriverPackageCab, 
                                     uint* pcchRequiredSize);

@DllImport("WINSPOOL")
HRESULT DeletePrinterDriverPackageA(const(char)* pszServer, const(char)* pszInfPath, const(char)* pszEnvironment);

@DllImport("WINSPOOL")
HRESULT DeletePrinterDriverPackageW(const(wchar)* pszServer, const(wchar)* pszInfPath, 
                                    const(wchar)* pszEnvironment);

@DllImport("WINSPOOL")
HRESULT ReportJobProcessingProgress(HANDLE printerHandle, uint jobId, EPrintXPSJobOperation jobOperation, 
                                    EPrintXPSJobProgress jobProgress);

@DllImport("WINSPOOL")
BOOL GetPrinterDriver2A(HWND hWnd, HANDLE hPrinter, const(char)* pEnvironment, uint Level, char* pDriverInfo, 
                        uint cbBuf, uint* pcbNeeded);

@DllImport("WINSPOOL")
BOOL GetPrinterDriver2W(HWND hWnd, HANDLE hPrinter, const(wchar)* pEnvironment, uint Level, char* pDriverInfo, 
                        uint cbBuf, uint* pcbNeeded);

@DllImport("WINSPOOL")
BOOL GetPrintExecutionData(PRINT_EXECUTION_DATA* pData);

@DllImport("SPOOLSS")
uint GetJobNamedPropertyValue(HANDLE hPrinter, uint JobId, const(wchar)* pszName, PrintPropertyValue* pValue);

@DllImport("SPOOLSS")
void FreePrintPropertyValue(PrintPropertyValue* pValue);

@DllImport("WINSPOOL")
void FreePrintNamedPropertyArray(uint cProperties, char* ppProperties);

@DllImport("WINSPOOL")
uint SetJobNamedProperty(HANDLE hPrinter, uint JobId, const(PrintNamedProperty)* pProperty);

@DllImport("SPOOLSS")
uint DeleteJobNamedProperty(HANDLE hPrinter, uint JobId, const(wchar)* pszName);

@DllImport("WINSPOOL")
uint EnumJobNamedProperties(HANDLE hPrinter, uint JobId, uint* pcProperties, PrintNamedProperty** ppProperties);

@DllImport("WINSPOOL")
HRESULT GetPrintOutputInfo(HWND hWnd, const(wchar)* pszPrinter, HANDLE* phFile, ushort** ppszOutputFile);

@DllImport("VSSAPI")
HRESULT CreateVssExpressWriterInternal(IVssExpressWriter* ppWriter);

@DllImport("GDI32")
BOOL EngQueryEMFInfo(HDEV__* hdev, EMFINFO* pEMFInfo);

@DllImport("api-ms-win-core-libraryloader-l2-1-0")
BOOL QueryOptionalDelayLoadedAPI(ptrdiff_t hParentModule, const(char)* lpDllName, const(char)* lpProcName, 
                                 uint Reserved);

@DllImport("vertdll")
HRESULT EnclaveGetAttestationReport(const(ubyte)* EnclaveData, char* Report, uint BufferSize, uint* OutputSize);

@DllImport("vertdll")
HRESULT EnclaveVerifyAttestationReport(uint EnclaveType, char* Report, uint ReportSize);

@DllImport("vertdll")
HRESULT EnclaveSealData(char* DataToEncrypt, uint DataToEncryptSize, 
                        ENCLAVE_SEALING_IDENTITY_POLICY IdentityPolicy, uint RuntimePolicy, char* ProtectedBlob, 
                        uint BufferSize, uint* ProtectedBlobSize);

@DllImport("vertdll")
HRESULT EnclaveUnsealData(char* ProtectedBlob, uint ProtectedBlobSize, char* DecryptedData, uint BufferSize, 
                          uint* DecryptedDataSize, ENCLAVE_IDENTITY* SealingIdentity, uint* UnsealingFlags);

@DllImport("vertdll")
HRESULT EnclaveGetEnclaveInformation(uint InformationSize, char* EnclaveInformation);

@DllImport("POWRPROF")
NTSTATUS CallNtPowerInformation(POWER_INFORMATION_LEVEL InformationLevel, char* InputBuffer, 
                                uint InputBufferLength, char* OutputBuffer, uint OutputBufferLength);

@DllImport("api-ms-win-power-base-l1-1-0")
ubyte GetPwrCapabilities(SYSTEM_POWER_CAPABILITIES* lpspc);

@DllImport("api-ms-win-power-base-l1-1-0")
POWER_PLATFORM_ROLE PowerDeterminePlatformRoleEx(uint Version);

@DllImport("api-ms-win-power-base-l1-1-0")
uint PowerRegisterSuspendResumeNotification(uint Flags, HANDLE Recipient, void** RegistrationHandle);

@DllImport("api-ms-win-power-base-l1-1-0")
uint PowerUnregisterSuspendResumeNotification(void* RegistrationHandle);

@DllImport("api-ms-win-power-setting-l1-1-0")
uint PowerReadACValue(HKEY RootPowerKey, const(GUID)* SchemeGuid, const(GUID)* SubGroupOfPowerSettingsGuid, 
                      const(GUID)* PowerSettingGuid, uint* Type, char* Buffer, uint* BufferSize);

@DllImport("api-ms-win-power-setting-l1-1-0")
uint PowerReadDCValue(HKEY RootPowerKey, const(GUID)* SchemeGuid, const(GUID)* SubGroupOfPowerSettingsGuid, 
                      const(GUID)* PowerSettingGuid, uint* Type, char* Buffer, uint* BufferSize);

@DllImport("api-ms-win-power-setting-l1-1-0")
uint PowerGetActiveScheme(HKEY UserRootPowerKey, GUID** ActivePolicyGuid);

@DllImport("api-ms-win-power-setting-l1-1-0")
uint PowerSetActiveScheme(HKEY UserRootPowerKey, const(GUID)* SchemeGuid);

@DllImport("api-ms-win-power-setting-l1-1-0")
uint PowerSettingRegisterNotification(GUID* SettingGuid, uint Flags, HANDLE Recipient, void** RegistrationHandle);

@DllImport("api-ms-win-power-setting-l1-1-0")
uint PowerSettingUnregisterNotification(void* RegistrationHandle);

@DllImport("api-ms-win-power-setting-l1-1-1")
HRESULT PowerRegisterForEffectivePowerModeNotifications(uint Version, EFFECTIVE_POWER_MODE_CALLBACK* Callback, 
                                                        void* Context, void** RegistrationHandle);

@DllImport("api-ms-win-power-setting-l1-1-1")
HRESULT PowerUnregisterFromEffectivePowerModeNotifications(void* RegistrationHandle);

@DllImport("POWRPROF")
ubyte GetPwrDiskSpindownRange(uint* puiMax, uint* puiMin);

@DllImport("POWRPROF")
ubyte EnumPwrSchemes(PWRSCHEMESENUMPROC lpfn, LPARAM lParam);

@DllImport("POWRPROF")
ubyte ReadGlobalPwrPolicy(GLOBAL_POWER_POLICY* pGlobalPowerPolicy);

@DllImport("POWRPROF")
ubyte ReadPwrScheme(uint uiID, POWER_POLICY* pPowerPolicy);

@DllImport("POWRPROF")
ubyte WritePwrScheme(uint* puiID, const(wchar)* lpszSchemeName, const(wchar)* lpszDescription, 
                     POWER_POLICY* lpScheme);

@DllImport("POWRPROF")
ubyte WriteGlobalPwrPolicy(GLOBAL_POWER_POLICY* pGlobalPowerPolicy);

@DllImport("POWRPROF")
ubyte DeletePwrScheme(uint uiID);

@DllImport("POWRPROF")
ubyte GetActivePwrScheme(uint* puiID);

@DllImport("POWRPROF")
ubyte SetActivePwrScheme(uint uiID, GLOBAL_POWER_POLICY* pGlobalPowerPolicy, POWER_POLICY* pPowerPolicy);

@DllImport("POWRPROF")
ubyte IsPwrSuspendAllowed();

@DllImport("POWRPROF")
ubyte IsPwrHibernateAllowed();

@DllImport("POWRPROF")
ubyte IsPwrShutdownAllowed();

@DllImport("POWRPROF")
ubyte IsAdminOverrideActive(ADMINISTRATOR_POWER_POLICY* papp);

@DllImport("POWRPROF")
ubyte SetSuspendState(ubyte bHibernate, ubyte bForce, ubyte bWakeupEventsDisabled);

@DllImport("POWRPROF")
ubyte GetCurrentPowerPolicies(GLOBAL_POWER_POLICY* pGlobalPowerPolicy, POWER_POLICY* pPowerPolicy);

@DllImport("POWRPROF")
ubyte CanUserWritePwrScheme();

@DllImport("POWRPROF")
ubyte ReadProcessorPwrScheme(uint uiID, MACHINE_PROCESSOR_POWER_POLICY* pMachineProcessorPowerPolicy);

@DllImport("POWRPROF")
ubyte WriteProcessorPwrScheme(uint uiID, MACHINE_PROCESSOR_POWER_POLICY* pMachineProcessorPowerPolicy);

@DllImport("POWRPROF")
ubyte ValidatePowerPolicies(GLOBAL_POWER_POLICY* pGlobalPowerPolicy, POWER_POLICY* pPowerPolicy);

@DllImport("POWRPROF")
ubyte PowerIsSettingRangeDefined(const(GUID)* SubKeyGuid, const(GUID)* SettingGuid);

@DllImport("POWRPROF")
uint PowerSettingAccessCheckEx(POWER_DATA_ACCESSOR AccessFlags, const(GUID)* PowerGuid, uint AccessType);

@DllImport("POWRPROF")
uint PowerSettingAccessCheck(POWER_DATA_ACCESSOR AccessFlags, const(GUID)* PowerGuid);

@DllImport("POWRPROF")
uint PowerReadFriendlyName(HKEY RootPowerKey, const(GUID)* SchemeGuid, const(GUID)* SubGroupOfPowerSettingsGuid, 
                           const(GUID)* PowerSettingGuid, char* Buffer, uint* BufferSize);

@DllImport("POWRPROF")
uint PowerReadDescription(HKEY RootPowerKey, const(GUID)* SchemeGuid, const(GUID)* SubGroupOfPowerSettingsGuid, 
                          const(GUID)* PowerSettingGuid, char* Buffer, uint* BufferSize);

@DllImport("POWRPROF")
uint PowerReadPossibleValue(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                            const(GUID)* PowerSettingGuid, uint* Type, uint PossibleSettingIndex, char* Buffer, 
                            uint* BufferSize);

@DllImport("POWRPROF")
uint PowerReadPossibleFriendlyName(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                   const(GUID)* PowerSettingGuid, uint PossibleSettingIndex, char* Buffer, 
                                   uint* BufferSize);

@DllImport("POWRPROF")
uint PowerReadPossibleDescription(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                  const(GUID)* PowerSettingGuid, uint PossibleSettingIndex, char* Buffer, 
                                  uint* BufferSize);

@DllImport("POWRPROF")
uint PowerReadValueMin(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                       uint* ValueMinimum);

@DllImport("POWRPROF")
uint PowerReadValueMax(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                       uint* ValueMaximum);

@DllImport("POWRPROF")
uint PowerReadValueIncrement(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                             const(GUID)* PowerSettingGuid, uint* ValueIncrement);

@DllImport("POWRPROF")
uint PowerReadValueUnitsSpecifier(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                  const(GUID)* PowerSettingGuid, char* Buffer, uint* BufferSize);

@DllImport("POWRPROF")
uint PowerReadIconResourceSpecifier(HKEY RootPowerKey, const(GUID)* SchemeGuid, 
                                    const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                                    char* Buffer, uint* BufferSize);

@DllImport("POWRPROF")
uint PowerReadSettingAttributes(const(GUID)* SubGroupGuid, const(GUID)* PowerSettingGuid);

@DllImport("POWRPROF")
uint PowerWriteFriendlyName(HKEY RootPowerKey, const(GUID)* SchemeGuid, const(GUID)* SubGroupOfPowerSettingsGuid, 
                            const(GUID)* PowerSettingGuid, char* Buffer, uint BufferSize);

@DllImport("POWRPROF")
uint PowerWriteDescription(HKEY RootPowerKey, const(GUID)* SchemeGuid, const(GUID)* SubGroupOfPowerSettingsGuid, 
                           const(GUID)* PowerSettingGuid, char* Buffer, uint BufferSize);

@DllImport("POWRPROF")
uint PowerWritePossibleValue(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                             const(GUID)* PowerSettingGuid, uint Type, uint PossibleSettingIndex, char* Buffer, 
                             uint BufferSize);

@DllImport("POWRPROF")
uint PowerWritePossibleFriendlyName(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                    const(GUID)* PowerSettingGuid, uint PossibleSettingIndex, char* Buffer, 
                                    uint BufferSize);

@DllImport("POWRPROF")
uint PowerWritePossibleDescription(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                   const(GUID)* PowerSettingGuid, uint PossibleSettingIndex, char* Buffer, 
                                   uint BufferSize);

@DllImport("POWRPROF")
uint PowerWriteValueMin(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                        uint ValueMinimum);

@DllImport("POWRPROF")
uint PowerWriteValueMax(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                        uint ValueMaximum);

@DllImport("POWRPROF")
uint PowerWriteValueIncrement(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                              const(GUID)* PowerSettingGuid, uint ValueIncrement);

@DllImport("POWRPROF")
uint PowerWriteValueUnitsSpecifier(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                   const(GUID)* PowerSettingGuid, char* Buffer, uint BufferSize);

@DllImport("POWRPROF")
uint PowerWriteIconResourceSpecifier(HKEY RootPowerKey, const(GUID)* SchemeGuid, 
                                     const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                                     char* Buffer, uint BufferSize);

@DllImport("POWRPROF")
uint PowerWriteSettingAttributes(const(GUID)* SubGroupGuid, const(GUID)* PowerSettingGuid, uint Attributes);

@DllImport("POWRPROF")
uint PowerDuplicateScheme(HKEY RootPowerKey, const(GUID)* SourceSchemeGuid, GUID** DestinationSchemeGuid);

@DllImport("POWRPROF")
uint PowerImportPowerScheme(HKEY RootPowerKey, const(wchar)* ImportFileNamePath, GUID** DestinationSchemeGuid);

@DllImport("POWRPROF")
uint PowerDeleteScheme(HKEY RootPowerKey, const(GUID)* SchemeGuid);

@DllImport("POWRPROF")
uint PowerRemovePowerSetting(const(GUID)* PowerSettingSubKeyGuid, const(GUID)* PowerSettingGuid);

@DllImport("POWRPROF")
uint PowerCreateSetting(HKEY RootSystemPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                        const(GUID)* PowerSettingGuid);

@DllImport("POWRPROF")
uint PowerCreatePossibleSetting(HKEY RootSystemPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                const(GUID)* PowerSettingGuid, uint PossibleSettingIndex);

@DllImport("POWRPROF")
uint PowerEnumerate(HKEY RootPowerKey, const(GUID)* SchemeGuid, const(GUID)* SubGroupOfPowerSettingsGuid, 
                    POWER_DATA_ACCESSOR AccessFlags, uint Index, char* Buffer, uint* BufferSize);

@DllImport("POWRPROF")
uint PowerOpenUserPowerKey(HKEY* phUserPowerKey, uint Access, BOOL OpenExisting);

@DllImport("POWRPROF")
uint PowerOpenSystemPowerKey(HKEY* phSystemPowerKey, uint Access, BOOL OpenExisting);

@DllImport("POWRPROF")
uint PowerCanRestoreIndividualDefaultPowerScheme(const(GUID)* SchemeGuid);

@DllImport("POWRPROF")
uint PowerRestoreIndividualDefaultPowerScheme(const(GUID)* SchemeGuid);

@DllImport("POWRPROF")
uint PowerRestoreDefaultPowerSchemes();

@DllImport("POWRPROF")
uint PowerReplaceDefaultPowerSchemes();

@DllImport("POWRPROF")
POWER_PLATFORM_ROLE PowerDeterminePlatformRole();

@DllImport("POWRPROF")
ubyte DevicePowerEnumDevices(uint QueryIndex, uint QueryInterpretationFlags, uint QueryFlags, char* pReturnBuffer, 
                             uint* pBufferSize);

@DllImport("POWRPROF")
uint DevicePowerSetDeviceState(const(wchar)* DeviceDescription, uint SetFlags, void* SetData);

@DllImport("POWRPROF")
ubyte DevicePowerOpen(uint DebugMask);

@DllImport("POWRPROF")
ubyte DevicePowerClose();

@DllImport("POWRPROF")
uint PowerReportThermalEvent(THERMAL_EVENT* Event);

@DllImport("USER32")
BOOL ExitWindowsEx(uint uFlags, uint dwReason);

@DllImport("USER32")
BOOL IsWow64Message();

@DllImport("USER32")
void* RegisterDeviceNotificationA(HANDLE hRecipient, void* NotificationFilter, uint Flags);

@DllImport("USER32")
void* RegisterDeviceNotificationW(HANDLE hRecipient, void* NotificationFilter, uint Flags);

@DllImport("USER32")
BOOL UnregisterDeviceNotification(void* Handle);

@DllImport("USER32")
void* RegisterPowerSettingNotification(HANDLE hRecipient, GUID* PowerSettingGuid, uint Flags);

@DllImport("USER32")
BOOL UnregisterPowerSettingNotification(void* Handle);

@DllImport("USER32")
void* RegisterSuspendResumeNotification(HANDLE hRecipient, uint Flags);

@DllImport("USER32")
BOOL UnregisterSuspendResumeNotification(void* Handle);

@DllImport("USER32")
BOOL AttachThreadInput(uint idAttach, uint idAttachTo, BOOL fAttach);

@DllImport("USER32")
uint WaitForInputIdle(HANDLE hProcess, uint dwMilliseconds);

@DllImport("USER32")
uint MsgWaitForMultipleObjects(uint nCount, char* pHandles, BOOL fWaitAll, uint dwMilliseconds, uint dwWakeMask);

@DllImport("USER32")
uint MsgWaitForMultipleObjectsEx(uint nCount, char* pHandles, uint dwMilliseconds, uint dwWakeMask, uint dwFlags);

@DllImport("USER32")
uint GetGuiResources(HANDLE hProcess, uint uiFlags);

@DllImport("USER32")
BOOL LockWorkStation();

@DllImport("USER32")
BOOL UserHandleGrantAccess(HANDLE hUserHandle, HANDLE hJob, BOOL bGrant);

@DllImport("USER32")
BOOL ShutdownBlockReasonCreate(HWND hWnd, const(wchar)* pwszReason);

@DllImport("USER32")
BOOL ShutdownBlockReasonQuery(HWND hWnd, const(wchar)* pwszBuff, uint* pcchBuff);

@DllImport("USER32")
BOOL ShutdownBlockReasonDestroy(HWND hWnd);

@DllImport("USER32")
BOOL GetAutoRotationState(AR_STATE* pState);

@DllImport("USER32")
BOOL GetDisplayAutoRotationPreferences(ORIENTATION_PREFERENCE* pOrientation);

@DllImport("USER32")
BOOL SetDisplayAutoRotationPreferences(ORIENTATION_PREFERENCE orientation);

@DllImport("USER32")
BOOL IsImmersiveProcess(HANDLE hProcess);

@DllImport("USER32")
BOOL SetProcessRestrictionExemption(BOOL fEnableExemption);

@DllImport("KERNEL32")
BOOL DeviceIoControl(HANDLE hDevice, uint dwIoControlCode, char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, 
                     uint nOutBufferSize, uint* lpBytesReturned, OVERLAPPED* lpOverlapped);

@DllImport("KERNEL32")
BOOL GetOverlappedResult(HANDLE hFile, OVERLAPPED* lpOverlapped, uint* lpNumberOfBytesTransferred, BOOL bWait);

@DllImport("KERNEL32")
BOOL GetOverlappedResultEx(HANDLE hFile, OVERLAPPED* lpOverlapped, uint* lpNumberOfBytesTransferred, 
                           uint dwMilliseconds, BOOL bAlertable);

@DllImport("KERNEL32")
BOOL IsWow64Process(HANDLE hProcess, int* Wow64Process);

@DllImport("KERNEL32")
BOOL IsWow64Process2(HANDLE hProcess, ushort* pProcessMachine, ushort* pNativeMachine);

@DllImport("KERNEL32")
byte* GetCommandLineA();

@DllImport("KERNEL32")
ushort* GetCommandLineW();

@DllImport("KERNEL32")
byte* GetEnvironmentStrings();

@DllImport("KERNEL32")
ushort* GetEnvironmentStringsW();

@DllImport("KERNEL32")
BOOL FreeEnvironmentStringsA(const(char)* penv);

@DllImport("KERNEL32")
BOOL FreeEnvironmentStringsW(const(wchar)* penv);

@DllImport("KERNEL32")
uint GetEnvironmentVariableA(const(char)* lpName, const(char)* lpBuffer, uint nSize);

@DllImport("KERNEL32")
uint GetEnvironmentVariableW(const(wchar)* lpName, const(wchar)* lpBuffer, uint nSize);

@DllImport("KERNEL32")
BOOL SetEnvironmentVariableA(const(char)* lpName, const(char)* lpValue);

@DllImport("KERNEL32")
BOOL SetEnvironmentVariableW(const(wchar)* lpName, const(wchar)* lpValue);

@DllImport("KERNEL32")
BOOL NeedCurrentDirectoryForExePathA(const(char)* ExeName);

@DllImport("KERNEL32")
BOOL NeedCurrentDirectoryForExePathW(const(wchar)* ExeName);

@DllImport("KERNEL32")
uint QueueUserAPC(PAPCFUNC pfnAPC, HANDLE hThread, size_t dwData);

@DllImport("KERNEL32")
BOOL GetProcessTimes(HANDLE hProcess, FILETIME* lpCreationTime, FILETIME* lpExitTime, FILETIME* lpKernelTime, 
                     FILETIME* lpUserTime);

@DllImport("KERNEL32")
HANDLE GetCurrentProcess();

@DllImport("KERNEL32")
uint GetCurrentProcessId();

@DllImport("KERNEL32")
void ExitProcess(uint uExitCode);

@DllImport("KERNEL32")
BOOL TerminateProcess(HANDLE hProcess, uint uExitCode);

@DllImport("KERNEL32")
BOOL GetExitCodeProcess(HANDLE hProcess, uint* lpExitCode);

@DllImport("KERNEL32")
BOOL SwitchToThread();

@DllImport("KERNEL32")
HANDLE CreateThread(SECURITY_ATTRIBUTES* lpThreadAttributes, size_t dwStackSize, 
                    LPTHREAD_START_ROUTINE lpStartAddress, void* lpParameter, uint dwCreationFlags, uint* lpThreadId);

@DllImport("KERNEL32")
HANDLE CreateRemoteThread(HANDLE hProcess, SECURITY_ATTRIBUTES* lpThreadAttributes, size_t dwStackSize, 
                          LPTHREAD_START_ROUTINE lpStartAddress, void* lpParameter, uint dwCreationFlags, 
                          uint* lpThreadId);

@DllImport("KERNEL32")
HANDLE GetCurrentThread();

@DllImport("KERNEL32")
uint GetCurrentThreadId();

@DllImport("KERNEL32")
HANDLE OpenThread(uint dwDesiredAccess, BOOL bInheritHandle, uint dwThreadId);

@DllImport("KERNEL32")
BOOL SetThreadPriority(HANDLE hThread, int nPriority);

@DllImport("KERNEL32")
BOOL SetThreadPriorityBoost(HANDLE hThread, BOOL bDisablePriorityBoost);

@DllImport("KERNEL32")
BOOL GetThreadPriorityBoost(HANDLE hThread, int* pDisablePriorityBoost);

@DllImport("KERNEL32")
int GetThreadPriority(HANDLE hThread);

@DllImport("KERNEL32")
void ExitThread(uint dwExitCode);

@DllImport("KERNEL32")
BOOL TerminateThread(HANDLE hThread, uint dwExitCode);

@DllImport("KERNEL32")
BOOL GetExitCodeThread(HANDLE hThread, uint* lpExitCode);

@DllImport("KERNEL32")
uint SuspendThread(HANDLE hThread);

@DllImport("KERNEL32")
uint ResumeThread(HANDLE hThread);

@DllImport("KERNEL32")
uint TlsAlloc();

@DllImport("KERNEL32")
void* TlsGetValue(uint dwTlsIndex);

@DllImport("KERNEL32")
BOOL TlsSetValue(uint dwTlsIndex, void* lpTlsValue);

@DllImport("KERNEL32")
BOOL TlsFree(uint dwTlsIndex);

@DllImport("KERNEL32")
BOOL CreateProcessA(const(char)* lpApplicationName, const(char)* lpCommandLine, 
                    SECURITY_ATTRIBUTES* lpProcessAttributes, SECURITY_ATTRIBUTES* lpThreadAttributes, 
                    BOOL bInheritHandles, PROCESS_CREATION_FLAGS dwCreationFlags, void* lpEnvironment, 
                    const(char)* lpCurrentDirectory, STARTUPINFOA* lpStartupInfo, 
                    PROCESS_INFORMATION* lpProcessInformation);

@DllImport("KERNEL32")
BOOL CreateProcessW(const(wchar)* lpApplicationName, const(wchar)* lpCommandLine, 
                    SECURITY_ATTRIBUTES* lpProcessAttributes, SECURITY_ATTRIBUTES* lpThreadAttributes, 
                    BOOL bInheritHandles, PROCESS_CREATION_FLAGS dwCreationFlags, void* lpEnvironment, 
                    const(wchar)* lpCurrentDirectory, STARTUPINFOW* lpStartupInfo, 
                    PROCESS_INFORMATION* lpProcessInformation);

@DllImport("KERNEL32")
BOOL SetProcessShutdownParameters(uint dwLevel, uint dwFlags);

@DllImport("KERNEL32")
uint GetProcessVersion(uint ProcessId);

@DllImport("KERNEL32")
void GetStartupInfoW(STARTUPINFOW* lpStartupInfo);

@DllImport("ADVAPI32")
BOOL CreateProcessAsUserW(HANDLE hToken, const(wchar)* lpApplicationName, const(wchar)* lpCommandLine, 
                          SECURITY_ATTRIBUTES* lpProcessAttributes, SECURITY_ATTRIBUTES* lpThreadAttributes, 
                          BOOL bInheritHandles, uint dwCreationFlags, void* lpEnvironment, 
                          const(wchar)* lpCurrentDirectory, STARTUPINFOW* lpStartupInfo, 
                          PROCESS_INFORMATION* lpProcessInformation);

@DllImport("KERNEL32")
BOOL SetPriorityClass(HANDLE hProcess, uint dwPriorityClass);

@DllImport("KERNEL32")
uint GetPriorityClass(HANDLE hProcess);

@DllImport("KERNEL32")
BOOL SetThreadStackGuarantee(uint* StackSizeInBytes);

@DllImport("KERNEL32")
uint GetProcessId(HANDLE Process);

@DllImport("KERNEL32")
uint GetThreadId(HANDLE Thread);

@DllImport("KERNEL32")
void FlushProcessWriteBuffers();

@DllImport("KERNEL32")
uint GetProcessIdOfThread(HANDLE Thread);

@DllImport("KERNEL32")
BOOL InitializeProcThreadAttributeList(char* lpAttributeList, uint dwAttributeCount, uint dwFlags, size_t* lpSize);

@DllImport("KERNEL32")
void DeleteProcThreadAttributeList(ptrdiff_t lpAttributeList);

@DllImport("KERNEL32")
BOOL UpdateProcThreadAttribute(ptrdiff_t lpAttributeList, uint dwFlags, size_t Attribute, char* lpValue, 
                               size_t cbSize, char* lpPreviousValue, size_t* lpReturnSize);

@DllImport("KERNEL32")
BOOL SetProcessAffinityUpdateMode(HANDLE hProcess, uint dwFlags);

@DllImport("KERNEL32")
BOOL QueryProcessAffinityUpdateMode(HANDLE hProcess, uint* lpdwFlags);

@DllImport("KERNEL32")
HANDLE CreateRemoteThreadEx(HANDLE hProcess, SECURITY_ATTRIBUTES* lpThreadAttributes, size_t dwStackSize, 
                            LPTHREAD_START_ROUTINE lpStartAddress, void* lpParameter, uint dwCreationFlags, 
                            ptrdiff_t lpAttributeList, uint* lpThreadId);

@DllImport("KERNEL32")
void GetCurrentThreadStackLimits(uint* LowLimit, uint* HighLimit);

@DllImport("KERNEL32")
BOOL GetProcessMitigationPolicy(HANDLE hProcess, PROCESS_MITIGATION_POLICY MitigationPolicy, char* lpBuffer, 
                                size_t dwLength);

@DllImport("KERNEL32")
BOOL SetProcessMitigationPolicy(PROCESS_MITIGATION_POLICY MitigationPolicy, char* lpBuffer, size_t dwLength);

@DllImport("KERNEL32")
BOOL GetThreadTimes(HANDLE hThread, FILETIME* lpCreationTime, FILETIME* lpExitTime, FILETIME* lpKernelTime, 
                    FILETIME* lpUserTime);

@DllImport("KERNEL32")
HANDLE OpenProcess(uint dwDesiredAccess, BOOL bInheritHandle, uint dwProcessId);

@DllImport("KERNEL32")
BOOL GetProcessHandleCount(HANDLE hProcess, uint* pdwHandleCount);

@DllImport("KERNEL32")
uint GetCurrentProcessorNumber();

@DllImport("KERNEL32")
BOOL SetThreadIdealProcessorEx(HANDLE hThread, PROCESSOR_NUMBER* lpIdealProcessor, 
                               PROCESSOR_NUMBER* lpPreviousIdealProcessor);

@DllImport("KERNEL32")
BOOL GetThreadIdealProcessorEx(HANDLE hThread, PROCESSOR_NUMBER* lpIdealProcessor);

@DllImport("KERNEL32")
void GetCurrentProcessorNumberEx(PROCESSOR_NUMBER* ProcNumber);

@DllImport("KERNEL32")
BOOL GetProcessPriorityBoost(HANDLE hProcess, int* pDisablePriorityBoost);

@DllImport("KERNEL32")
BOOL SetProcessPriorityBoost(HANDLE hProcess, BOOL bDisablePriorityBoost);

@DllImport("KERNEL32")
BOOL GetThreadIOPendingFlag(HANDLE hThread, int* lpIOIsPending);

@DllImport("KERNEL32")
BOOL GetThreadInformation(HANDLE hThread, THREAD_INFORMATION_CLASS ThreadInformationClass, char* ThreadInformation, 
                          uint ThreadInformationSize);

@DllImport("KERNEL32")
BOOL SetThreadInformation(HANDLE hThread, THREAD_INFORMATION_CLASS ThreadInformationClass, char* ThreadInformation, 
                          uint ThreadInformationSize);

@DllImport("KERNEL32")
BOOL IsProcessCritical(HANDLE hProcess, int* Critical);

@DllImport("KERNEL32")
BOOL SetProtectedPolicy(GUID* PolicyGuid, size_t PolicyValue, uint* OldPolicyValue);

@DllImport("KERNEL32")
BOOL QueryProtectedPolicy(GUID* PolicyGuid, uint* PolicyValue);

@DllImport("KERNEL32")
uint SetThreadIdealProcessor(HANDLE hThread, uint dwIdealProcessor);

@DllImport("KERNEL32")
BOOL SetProcessInformation(HANDLE hProcess, PROCESS_INFORMATION_CLASS ProcessInformationClass, 
                           char* ProcessInformation, uint ProcessInformationSize);

@DllImport("KERNEL32")
BOOL GetProcessInformation(HANDLE hProcess, PROCESS_INFORMATION_CLASS ProcessInformationClass, 
                           char* ProcessInformation, uint ProcessInformationSize);

@DllImport("ADVAPI32")
BOOL CreateProcessAsUserA(HANDLE hToken, const(char)* lpApplicationName, const(char)* lpCommandLine, 
                          SECURITY_ATTRIBUTES* lpProcessAttributes, SECURITY_ATTRIBUTES* lpThreadAttributes, 
                          BOOL bInheritHandles, uint dwCreationFlags, void* lpEnvironment, 
                          const(char)* lpCurrentDirectory, STARTUPINFOA* lpStartupInfo, 
                          PROCESS_INFORMATION* lpProcessInformation);

@DllImport("KERNEL32")
BOOL GetProcessShutdownParameters(uint* lpdwLevel, uint* lpdwFlags);

@DllImport("KERNEL32")
HRESULT SetThreadDescription(HANDLE hThread, const(wchar)* lpThreadDescription);

@DllImport("KERNEL32")
HRESULT GetThreadDescription(HANDLE hThread, ushort** ppszThreadDescription);

@DllImport("KERNEL32")
BOOL GlobalMemoryStatusEx(MEMORYSTATUSEX* lpBuffer);

@DllImport("KERNEL32")
BOOL GetLogicalProcessorInformation(char* Buffer, uint* ReturnedLength);

@DllImport("KERNEL32")
BOOL GetLogicalProcessorInformationEx(LOGICAL_PROCESSOR_RELATIONSHIP RelationshipType, char* Buffer, 
                                      uint* ReturnedLength);

@DllImport("KERNEL32")
BOOL GetPhysicallyInstalledSystemMemory(ulong* TotalMemoryInKilobytes);

@DllImport("KERNEL32")
BOOL GetProcessorSystemCycleTime(ushort Group, char* Buffer, uint* ReturnedLength);

@DllImport("KERNEL32")
BOOL QueryThreadCycleTime(HANDLE ThreadHandle, ulong* CycleTime);

@DllImport("KERNEL32")
BOOL QueryProcessCycleTime(HANDLE ProcessHandle, ulong* CycleTime);

@DllImport("KERNEL32")
BOOL QueryIdleProcessorCycleTime(uint* BufferLength, char* ProcessorIdleCycleTime);

@DllImport("KERNEL32")
BOOL QueryIdleProcessorCycleTimeEx(ushort Group, uint* BufferLength, char* ProcessorIdleCycleTime);

@DllImport("KERNEL32")
ptrdiff_t GlobalAlloc(uint uFlags, size_t dwBytes);

@DllImport("KERNEL32")
ptrdiff_t GlobalReAlloc(ptrdiff_t hMem, size_t dwBytes, uint uFlags);

@DllImport("KERNEL32")
size_t GlobalSize(ptrdiff_t hMem);

@DllImport("KERNEL32")
BOOL GlobalUnlock(ptrdiff_t hMem);

@DllImport("KERNEL32")
void* GlobalLock(ptrdiff_t hMem);

@DllImport("KERNEL32")
uint GlobalFlags(ptrdiff_t hMem);

@DllImport("KERNEL32")
ptrdiff_t GlobalHandle(void* pMem);

@DllImport("KERNEL32")
ptrdiff_t GlobalFree(ptrdiff_t hMem);

@DllImport("KERNEL32")
void GlobalMemoryStatus(MEMORYSTATUS* lpBuffer);

@DllImport("KERNEL32")
ptrdiff_t LocalAlloc(uint uFlags, size_t uBytes);

@DllImport("KERNEL32")
ptrdiff_t LocalReAlloc(ptrdiff_t hMem, size_t uBytes, uint uFlags);

@DllImport("KERNEL32")
void* LocalLock(ptrdiff_t hMem);

@DllImport("KERNEL32")
ptrdiff_t LocalHandle(void* pMem);

@DllImport("KERNEL32")
BOOL LocalUnlock(ptrdiff_t hMem);

@DllImport("KERNEL32")
size_t LocalSize(ptrdiff_t hMem);

@DllImport("KERNEL32")
uint LocalFlags(ptrdiff_t hMem);

@DllImport("KERNEL32")
ptrdiff_t LocalFree(ptrdiff_t hMem);

@DllImport("KERNEL32")
BOOL GetProcessAffinityMask(HANDLE hProcess, size_t* lpProcessAffinityMask, size_t* lpSystemAffinityMask);

@DllImport("KERNEL32")
BOOL SetProcessAffinityMask(HANDLE hProcess, size_t dwProcessAffinityMask);

@DllImport("KERNEL32")
BOOL GetProcessIoCounters(HANDLE hProcess, IO_COUNTERS* lpIoCounters);

@DllImport("KERNEL32")
BOOL GetProcessWorkingSetSize(HANDLE hProcess, size_t* lpMinimumWorkingSetSize, size_t* lpMaximumWorkingSetSize);

@DllImport("KERNEL32")
BOOL SetProcessWorkingSetSize(HANDLE hProcess, size_t dwMinimumWorkingSetSize, size_t dwMaximumWorkingSetSize);

@DllImport("KERNEL32")
void SwitchToFiber(void* lpFiber);

@DllImport("KERNEL32")
void DeleteFiber(void* lpFiber);

@DllImport("KERNEL32")
BOOL ConvertFiberToThread();

@DllImport("KERNEL32")
void* CreateFiberEx(size_t dwStackCommitSize, size_t dwStackReserveSize, uint dwFlags, 
                    LPFIBER_START_ROUTINE lpStartAddress, void* lpParameter);

@DllImport("KERNEL32")
void* ConvertThreadToFiberEx(void* lpParameter, uint dwFlags);

@DllImport("KERNEL32")
void* CreateFiber(size_t dwStackSize, LPFIBER_START_ROUTINE lpStartAddress, void* lpParameter);

@DllImport("KERNEL32")
void* ConvertThreadToFiber(void* lpParameter);

@DllImport("KERNEL32")
BOOL CreateUmsCompletionList(void** UmsCompletionList);

@DllImport("KERNEL32")
BOOL DequeueUmsCompletionListItems(void* UmsCompletionList, uint WaitTimeOut, void** UmsThreadList);

@DllImport("KERNEL32")
BOOL GetUmsCompletionListEvent(void* UmsCompletionList, ptrdiff_t* UmsCompletionEvent);

@DllImport("KERNEL32")
BOOL ExecuteUmsThread(void* UmsThread);

@DllImport("KERNEL32")
BOOL UmsThreadYield(void* SchedulerParam);

@DllImport("KERNEL32")
BOOL DeleteUmsCompletionList(void* UmsCompletionList);

@DllImport("KERNEL32")
void* GetCurrentUmsThread();

@DllImport("KERNEL32")
void* GetNextUmsListItem(void* UmsContext);

@DllImport("KERNEL32")
BOOL QueryUmsThreadInformation(void* UmsThread, RTL_UMS_THREAD_INFO_CLASS UmsThreadInfoClass, 
                               char* UmsThreadInformation, uint UmsThreadInformationLength, uint* ReturnLength);

@DllImport("KERNEL32")
BOOL SetUmsThreadInformation(void* UmsThread, RTL_UMS_THREAD_INFO_CLASS UmsThreadInfoClass, 
                             void* UmsThreadInformation, uint UmsThreadInformationLength);

@DllImport("KERNEL32")
BOOL DeleteUmsThreadContext(void* UmsThread);

@DllImport("KERNEL32")
BOOL CreateUmsThreadContext(void** lpUmsThread);

@DllImport("KERNEL32")
BOOL EnterUmsSchedulingMode(UMS_SCHEDULER_STARTUP_INFO* SchedulerStartupInfo);

@DllImport("KERNEL32")
BOOL GetUmsSystemThreadInformation(HANDLE ThreadHandle, UMS_SYSTEM_THREAD_INFORMATION* SystemThreadInfo);

@DllImport("KERNEL32")
size_t SetThreadAffinityMask(HANDLE hThread, size_t dwThreadAffinityMask);

@DllImport("KERNEL32")
BOOL SetProcessDEPPolicy(uint dwFlags);

@DllImport("KERNEL32")
BOOL GetProcessDEPPolicy(HANDLE hProcess, uint* lpFlags, int* lpPermanent);

@DllImport("KERNEL32")
BOOL RequestWakeupLatency(LATENCY_TIME latency);

@DllImport("KERNEL32")
BOOL IsSystemResumeAutomatic();

@DllImport("KERNEL32")
uint SetThreadExecutionState(uint esFlags);

@DllImport("KERNEL32")
HANDLE PowerCreateRequest(REASON_CONTEXT* Context);

@DllImport("KERNEL32")
BOOL PowerSetRequest(HANDLE PowerRequest, POWER_REQUEST_TYPE RequestType);

@DllImport("KERNEL32")
BOOL PowerClearRequest(HANDLE PowerRequest, POWER_REQUEST_TYPE RequestType);

@DllImport("KERNEL32")
BOOL PulseEvent(HANDLE hEvent);

@DllImport("KERNEL32")
BOOL GetDevicePowerState(HANDLE hDevice, int* pfOn);

@DllImport("KERNEL32")
uint LoadModule(const(char)* lpModuleName, void* lpParameterBlock);

@DllImport("KERNEL32")
uint WinExec(const(char)* lpCmdLine, uint uCmdShow);

@DllImport("KERNEL32")
BOOL ClearCommBreak(HANDLE hFile);

@DllImport("KERNEL32")
BOOL ClearCommError(HANDLE hFile, uint* lpErrors, COMSTAT* lpStat);

@DllImport("KERNEL32")
BOOL SetupComm(HANDLE hFile, uint dwInQueue, uint dwOutQueue);

@DllImport("KERNEL32")
BOOL EscapeCommFunction(HANDLE hFile, uint dwFunc);

@DllImport("KERNEL32")
BOOL GetCommConfig(HANDLE hCommDev, char* lpCC, uint* lpdwSize);

@DllImport("KERNEL32")
BOOL GetCommMask(HANDLE hFile, uint* lpEvtMask);

@DllImport("KERNEL32")
BOOL GetCommProperties(HANDLE hFile, COMMPROP* lpCommProp);

@DllImport("KERNEL32")
BOOL GetCommModemStatus(HANDLE hFile, uint* lpModemStat);

@DllImport("KERNEL32")
BOOL GetCommState(HANDLE hFile, DCB* lpDCB);

@DllImport("KERNEL32")
BOOL GetCommTimeouts(HANDLE hFile, COMMTIMEOUTS* lpCommTimeouts);

@DllImport("KERNEL32")
BOOL PurgeComm(HANDLE hFile, uint dwFlags);

@DllImport("KERNEL32")
BOOL SetCommBreak(HANDLE hFile);

@DllImport("KERNEL32")
BOOL SetCommConfig(HANDLE hCommDev, char* lpCC, uint dwSize);

@DllImport("KERNEL32")
BOOL SetCommMask(HANDLE hFile, uint dwEvtMask);

@DllImport("KERNEL32")
BOOL SetCommState(HANDLE hFile, DCB* lpDCB);

@DllImport("KERNEL32")
BOOL SetCommTimeouts(HANDLE hFile, COMMTIMEOUTS* lpCommTimeouts);

@DllImport("KERNEL32")
BOOL TransmitCommChar(HANDLE hFile, byte cChar);

@DllImport("KERNEL32")
BOOL WaitCommEvent(HANDLE hFile, uint* lpEvtMask, OVERLAPPED* lpOverlapped);

@DllImport("api-ms-win-core-comm-l1-1-1")
HANDLE OpenCommPort(uint uPortNumber, uint dwDesiredAccess, uint dwFlagsAndAttributes);

@DllImport("api-ms-win-core-comm-l1-1-2")
uint GetCommPorts(char* lpPortNumbers, uint uPortNumbersCount, uint* puPortNumbersFound);

@DllImport("KERNEL32")
uint SetTapePosition(HANDLE hDevice, uint dwPositionMethod, uint dwPartition, uint dwOffsetLow, uint dwOffsetHigh, 
                     BOOL bImmediate);

@DllImport("KERNEL32")
uint GetTapePosition(HANDLE hDevice, uint dwPositionType, uint* lpdwPartition, uint* lpdwOffsetLow, 
                     uint* lpdwOffsetHigh);

@DllImport("KERNEL32")
uint PrepareTape(HANDLE hDevice, uint dwOperation, BOOL bImmediate);

@DllImport("KERNEL32")
uint EraseTape(HANDLE hDevice, uint dwEraseType, BOOL bImmediate);

@DllImport("KERNEL32")
uint CreateTapePartition(HANDLE hDevice, uint dwPartitionMethod, uint dwCount, uint dwSize);

@DllImport("KERNEL32")
uint WriteTapemark(HANDLE hDevice, uint dwTapemarkType, uint dwTapemarkCount, BOOL bImmediate);

@DllImport("KERNEL32")
uint GetTapeStatus(HANDLE hDevice);

@DllImport("KERNEL32")
uint GetTapeParameters(HANDLE hDevice, uint dwOperation, uint* lpdwSize, char* lpTapeInformation);

@DllImport("KERNEL32")
uint SetTapeParameters(HANDLE hDevice, uint dwOperation, void* lpTapeInformation);

@DllImport("KERNEL32")
DEP_SYSTEM_POLICY_TYPE GetSystemDEPPolicy();

@DllImport("KERNEL32")
HANDLE CreateMailslotA(const(char)* lpName, uint nMaxMessageSize, uint lReadTimeout, 
                       SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("KERNEL32")
HANDLE CreateMailslotW(const(wchar)* lpName, uint nMaxMessageSize, uint lReadTimeout, 
                       SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("KERNEL32")
BOOL GetMailslotInfo(HANDLE hMailslot, uint* lpMaxMessageSize, uint* lpNextSize, uint* lpMessageCount, 
                     uint* lpReadTimeout);

@DllImport("KERNEL32")
BOOL SetMailslotInfo(HANDLE hMailslot, uint lReadTimeout);

@DllImport("KERNEL32")
uint SignalObjectAndWait(HANDLE hObjectToSignal, HANDLE hObjectToWaitOn, uint dwMilliseconds, BOOL bAlertable);

@DllImport("KERNEL32")
BOOL BackupRead(HANDLE hFile, char* lpBuffer, uint nNumberOfBytesToRead, uint* lpNumberOfBytesRead, BOOL bAbort, 
                BOOL bProcessSecurity, void** lpContext);

@DllImport("KERNEL32")
BOOL BackupSeek(HANDLE hFile, uint dwLowBytesToSeek, uint dwHighBytesToSeek, uint* lpdwLowByteSeeked, 
                uint* lpdwHighByteSeeked, void** lpContext);

@DllImport("KERNEL32")
BOOL BackupWrite(HANDLE hFile, char* lpBuffer, uint nNumberOfBytesToWrite, uint* lpNumberOfBytesWritten, 
                 BOOL bAbort, BOOL bProcessSecurity, void** lpContext);

@DllImport("KERNEL32")
HANDLE CreateSemaphoreA(SECURITY_ATTRIBUTES* lpSemaphoreAttributes, int lInitialCount, int lMaximumCount, 
                        const(char)* lpName);

@DllImport("KERNEL32")
HANDLE CreateSemaphoreExA(SECURITY_ATTRIBUTES* lpSemaphoreAttributes, int lInitialCount, int lMaximumCount, 
                          const(char)* lpName, uint dwFlags, uint dwDesiredAccess);

@DllImport("KERNEL32")
HANDLE CreateFileMappingA(HANDLE hFile, SECURITY_ATTRIBUTES* lpFileMappingAttributes, uint flProtect, 
                          uint dwMaximumSizeHigh, uint dwMaximumSizeLow, const(char)* lpName);

@DllImport("KERNEL32")
HANDLE CreateFileMappingNumaA(HANDLE hFile, SECURITY_ATTRIBUTES* lpFileMappingAttributes, uint flProtect, 
                              uint dwMaximumSizeHigh, uint dwMaximumSizeLow, const(char)* lpName, uint nndPreferred);

@DllImport("KERNEL32")
HANDLE OpenFileMappingA(uint dwDesiredAccess, BOOL bInheritHandle, const(char)* lpName);

@DllImport("KERNEL32")
ptrdiff_t LoadPackagedLibrary(const(wchar)* lpwLibFileName, uint Reserved);

@DllImport("KERNEL32")
BOOL QueryFullProcessImageNameA(HANDLE hProcess, uint dwFlags, const(char)* lpExeName, uint* lpdwSize);

@DllImport("KERNEL32")
BOOL QueryFullProcessImageNameW(HANDLE hProcess, uint dwFlags, const(wchar)* lpExeName, uint* lpdwSize);

@DllImport("KERNEL32")
BOOL SetDllDirectoryA(const(char)* lpPathName);

@DllImport("KERNEL32")
BOOL SetDllDirectoryW(const(wchar)* lpPathName);

@DllImport("KERNEL32")
uint GetDllDirectoryA(uint nBufferLength, const(char)* lpBuffer);

@DllImport("KERNEL32")
uint GetDllDirectoryW(uint nBufferLength, const(wchar)* lpBuffer);

@DllImport("KERNEL32")
BOOL GetNamedPipeHandleStateA(HANDLE hNamedPipe, uint* lpState, uint* lpCurInstances, uint* lpMaxCollectionCount, 
                              uint* lpCollectDataTimeout, const(char)* lpUserName, uint nMaxUserNameSize);

@DllImport("KERNEL32")
BOOL CallNamedPipeA(const(char)* lpNamedPipeName, char* lpInBuffer, uint nInBufferSize, char* lpOutBuffer, 
                    uint nOutBufferSize, uint* lpBytesRead, uint nTimeOut);

@DllImport("KERNEL32")
BOOL GetNamedPipeClientComputerNameA(HANDLE Pipe, const(char)* ClientComputerName, uint ClientComputerNameLength);

@DllImport("KERNEL32")
BOOL GetNamedPipeClientProcessId(HANDLE Pipe, uint* ClientProcessId);

@DllImport("KERNEL32")
BOOL GetNamedPipeClientSessionId(HANDLE Pipe, uint* ClientSessionId);

@DllImport("KERNEL32")
BOOL GetNamedPipeServerProcessId(HANDLE Pipe, uint* ServerProcessId);

@DllImport("KERNEL32")
BOOL GetNamedPipeServerSessionId(HANDLE Pipe, uint* ServerSessionId);

@DllImport("ADVAPI32")
BOOL ClearEventLogA(HANDLE hEventLog, const(char)* lpBackupFileName);

@DllImport("ADVAPI32")
BOOL ClearEventLogW(HANDLE hEventLog, const(wchar)* lpBackupFileName);

@DllImport("ADVAPI32")
BOOL BackupEventLogA(HANDLE hEventLog, const(char)* lpBackupFileName);

@DllImport("ADVAPI32")
BOOL BackupEventLogW(HANDLE hEventLog, const(wchar)* lpBackupFileName);

@DllImport("ADVAPI32")
BOOL CloseEventLog(HANDLE hEventLog);

@DllImport("ADVAPI32")
BOOL DeregisterEventSource(HANDLE hEventLog);

@DllImport("ADVAPI32")
BOOL NotifyChangeEventLog(HANDLE hEventLog, HANDLE hEvent);

@DllImport("ADVAPI32")
BOOL GetNumberOfEventLogRecords(HANDLE hEventLog, uint* NumberOfRecords);

@DllImport("ADVAPI32")
BOOL GetOldestEventLogRecord(HANDLE hEventLog, uint* OldestRecord);

@DllImport("ADVAPI32")
EventLogHandle OpenEventLogA(const(char)* lpUNCServerName, const(char)* lpSourceName);

@DllImport("ADVAPI32")
EventLogHandle OpenEventLogW(const(wchar)* lpUNCServerName, const(wchar)* lpSourceName);

@DllImport("ADVAPI32")
EventSourceHandle RegisterEventSourceA(const(char)* lpUNCServerName, const(char)* lpSourceName);

@DllImport("ADVAPI32")
HANDLE RegisterEventSourceW(const(wchar)* lpUNCServerName, const(wchar)* lpSourceName);

@DllImport("ADVAPI32")
EventLogHandle OpenBackupEventLogA(const(char)* lpUNCServerName, const(char)* lpFileName);

@DllImport("ADVAPI32")
EventLogHandle OpenBackupEventLogW(const(wchar)* lpUNCServerName, const(wchar)* lpFileName);

@DllImport("ADVAPI32")
BOOL ReadEventLogA(HANDLE hEventLog, uint dwReadFlags, uint dwRecordOffset, char* lpBuffer, 
                   uint nNumberOfBytesToRead, uint* pnBytesRead, uint* pnMinNumberOfBytesNeeded);

@DllImport("ADVAPI32")
BOOL ReadEventLogW(HANDLE hEventLog, uint dwReadFlags, uint dwRecordOffset, char* lpBuffer, 
                   uint nNumberOfBytesToRead, uint* pnBytesRead, uint* pnMinNumberOfBytesNeeded);

@DllImport("ADVAPI32")
BOOL ReportEventA(HANDLE hEventLog, ushort wType, ushort wCategory, uint dwEventID, void* lpUserSid, 
                  ushort wNumStrings, uint dwDataSize, char* lpStrings, char* lpRawData);

@DllImport("ADVAPI32")
BOOL ReportEventW(HANDLE hEventLog, ushort wType, ushort wCategory, uint dwEventID, void* lpUserSid, 
                  ushort wNumStrings, uint dwDataSize, char* lpStrings, char* lpRawData);

@DllImport("ADVAPI32")
BOOL GetEventLogInformation(HANDLE hEventLog, uint dwInfoLevel, char* lpBuffer, uint cbBufSize, 
                            uint* pcbBytesNeeded);

@DllImport("KERNEL32")
void* MapViewOfFileExNuma(HANDLE hFileMappingObject, uint dwDesiredAccess, uint dwFileOffsetHigh, 
                          uint dwFileOffsetLow, size_t dwNumberOfBytesToMap, void* lpBaseAddress, uint nndPreferred);

@DllImport("KERNEL32")
BOOL IsBadReadPtr(const(void)* lp, size_t ucb);

@DllImport("KERNEL32")
BOOL IsBadWritePtr(void* lp, size_t ucb);

@DllImport("KERNEL32")
BOOL IsBadCodePtr(FARPROC lpfn);

@DllImport("KERNEL32")
BOOL IsBadStringPtrA(const(char)* lpsz, size_t ucchMax);

@DllImport("KERNEL32")
BOOL IsBadStringPtrW(const(wchar)* lpsz, size_t ucchMax);

@DllImport("KERNEL32")
BOOL BuildCommDCBA(const(char)* lpDef, DCB* lpDCB);

@DllImport("KERNEL32")
BOOL BuildCommDCBW(const(wchar)* lpDef, DCB* lpDCB);

@DllImport("KERNEL32")
BOOL BuildCommDCBAndTimeoutsA(const(char)* lpDef, DCB* lpDCB, COMMTIMEOUTS* lpCommTimeouts);

@DllImport("KERNEL32")
BOOL BuildCommDCBAndTimeoutsW(const(wchar)* lpDef, DCB* lpDCB, COMMTIMEOUTS* lpCommTimeouts);

@DllImport("KERNEL32")
BOOL CommConfigDialogA(const(char)* lpszName, HWND hWnd, COMMCONFIG* lpCC);

@DllImport("KERNEL32")
BOOL CommConfigDialogW(const(wchar)* lpszName, HWND hWnd, COMMCONFIG* lpCC);

@DllImport("KERNEL32")
BOOL GetDefaultCommConfigA(const(char)* lpszName, char* lpCC, uint* lpdwSize);

@DllImport("KERNEL32")
BOOL GetDefaultCommConfigW(const(wchar)* lpszName, char* lpCC, uint* lpdwSize);

@DllImport("KERNEL32")
BOOL SetDefaultCommConfigA(const(char)* lpszName, char* lpCC, uint dwSize);

@DllImport("KERNEL32")
BOOL SetDefaultCommConfigW(const(wchar)* lpszName, char* lpCC, uint dwSize);

@DllImport("ADVAPI32")
BOOL CreateProcessWithLogonW(const(wchar)* lpUsername, const(wchar)* lpDomain, const(wchar)* lpPassword, 
                             uint dwLogonFlags, const(wchar)* lpApplicationName, const(wchar)* lpCommandLine, 
                             uint dwCreationFlags, void* lpEnvironment, const(wchar)* lpCurrentDirectory, 
                             STARTUPINFOW* lpStartupInfo, PROCESS_INFORMATION* lpProcessInformation);

@DllImport("ADVAPI32")
BOOL CreateProcessWithTokenW(HANDLE hToken, uint dwLogonFlags, const(wchar)* lpApplicationName, 
                             const(wchar)* lpCommandLine, uint dwCreationFlags, void* lpEnvironment, 
                             const(wchar)* lpCurrentDirectory, STARTUPINFOW* lpStartupInfo, 
                             PROCESS_INFORMATION* lpProcessInformation);

@DllImport("KERNEL32")
BOOL RegisterWaitForSingleObject(ptrdiff_t* phNewWaitObject, HANDLE hObject, WAITORTIMERCALLBACK Callback, 
                                 void* Context, uint dwMilliseconds, uint dwFlags);

@DllImport("KERNEL32")
BOOL UnregisterWait(HANDLE WaitHandle);

@DllImport("KERNEL32")
BOOL BindIoCompletionCallback(HANDLE FileHandle, LPOVERLAPPED_COMPLETION_ROUTINE Function, uint Flags);

@DllImport("KERNEL32")
BOOL DeleteTimerQueue(HANDLE TimerQueue);

@DllImport("KERNEL32")
BoundaryDescriptorHandle CreateBoundaryDescriptorA(const(char)* Name, uint Flags);

@DllImport("KERNEL32")
BOOL AddIntegrityLabelToBoundaryDescriptor(HANDLE* BoundaryDescriptor, void* IntegrityLabel);

@DllImport("KERNEL32")
BOOL SetSystemPowerState(BOOL fSuspend, BOOL fForce);

@DllImport("KERNEL32")
BOOL GetSystemPowerStatus(SYSTEM_POWER_STATUS* lpSystemPowerStatus);

@DllImport("KERNEL32")
BOOL MapUserPhysicalPagesScatter(char* VirtualAddresses, size_t NumberOfPages, char* PageArray);

@DllImport("KERNEL32")
HANDLE CreateJobObjectA(SECURITY_ATTRIBUTES* lpJobAttributes, const(char)* lpName);

@DllImport("KERNEL32")
HANDLE OpenJobObjectA(uint dwDesiredAccess, BOOL bInheritHandle, const(char)* lpName);

@DllImport("KERNEL32")
ushort GetActiveProcessorGroupCount();

@DllImport("KERNEL32")
ushort GetMaximumProcessorGroupCount();

@DllImport("KERNEL32")
uint GetActiveProcessorCount(ushort GroupNumber);

@DllImport("KERNEL32")
uint GetMaximumProcessorCount(ushort GroupNumber);

@DllImport("KERNEL32")
BOOL GetNumaProcessorNode(ubyte Processor, ubyte* NodeNumber);

@DllImport("KERNEL32")
BOOL GetNumaNodeNumberFromHandle(HANDLE hFile, ushort* NodeNumber);

@DllImport("KERNEL32")
BOOL GetNumaProcessorNodeEx(PROCESSOR_NUMBER* Processor, ushort* NodeNumber);

@DllImport("KERNEL32")
BOOL GetNumaNodeProcessorMask(ubyte Node, ulong* ProcessorMask);

@DllImport("KERNEL32")
BOOL GetNumaAvailableMemoryNode(ubyte Node, ulong* AvailableBytes);

@DllImport("KERNEL32")
BOOL GetNumaAvailableMemoryNodeEx(ushort Node, ulong* AvailableBytes);

@DllImport("KERNEL32")
BOOL GetNumaProximityNode(uint ProximityId, ubyte* NodeNumber);

@DllImport("KERNEL32")
BOOL AddSecureMemoryCacheCallback(PSECURE_MEMORY_CACHE_CALLBACK pfnCallBack);

@DllImport("KERNEL32")
BOOL RemoveSecureMemoryCacheCallback(PSECURE_MEMORY_CACHE_CALLBACK pfnCallBack);

@DllImport("ADVAPI32")
BOOL InitiateSystemShutdownA(const(char)* lpMachineName, const(char)* lpMessage, uint dwTimeout, 
                             BOOL bForceAppsClosed, BOOL bRebootAfterShutdown);

@DllImport("ADVAPI32")
BOOL InitiateSystemShutdownW(const(wchar)* lpMachineName, const(wchar)* lpMessage, uint dwTimeout, 
                             BOOL bForceAppsClosed, BOOL bRebootAfterShutdown);

@DllImport("ADVAPI32")
BOOL AbortSystemShutdownA(const(char)* lpMachineName);

@DllImport("ADVAPI32")
BOOL AbortSystemShutdownW(const(wchar)* lpMachineName);

@DllImport("ADVAPI32")
BOOL InitiateSystemShutdownExA(const(char)* lpMachineName, const(char)* lpMessage, uint dwTimeout, 
                               BOOL bForceAppsClosed, BOOL bRebootAfterShutdown, uint dwReason);

@DllImport("ADVAPI32")
BOOL InitiateSystemShutdownExW(const(wchar)* lpMachineName, const(wchar)* lpMessage, uint dwTimeout, 
                               BOOL bForceAppsClosed, BOOL bRebootAfterShutdown, uint dwReason);

@DllImport("ADVAPI32")
uint InitiateShutdownA(const(char)* lpMachineName, const(char)* lpMessage, uint dwGracePeriod, 
                       uint dwShutdownFlags, uint dwReason);

@DllImport("ADVAPI32")
uint InitiateShutdownW(const(wchar)* lpMachineName, const(wchar)* lpMessage, uint dwGracePeriod, 
                       uint dwShutdownFlags, uint dwReason);

@DllImport("ntdll")
NTSTATUS NtQueryInformationProcess(HANDLE ProcessHandle, PROCESSINFOCLASS ProcessInformationClass, 
                                   void* ProcessInformation, uint ProcessInformationLength, uint* ReturnLength);

@DllImport("ntdll")
NTSTATUS NtQueryInformationThread(HANDLE ThreadHandle, THREADINFOCLASS ThreadInformationClass, 
                                  void* ThreadInformation, uint ThreadInformationLength, uint* ReturnLength);


// Interfaces

@GUID("0B5A2C52-3EB9-470A-96E2-6C6D4570E40F")
struct VssSnapshotMgmt;

@GUID("E579AB5F-1CC4-44B4-BED9-DE0991FF0623")
struct VSSCoordinator;

@GUID("6D5140C1-7436-11CE-8034-00AA006009FA")
interface IServiceProvider : IUnknown
{
    HRESULT QueryService(const(GUID)* guidService, const(GUID)* riid, void** ppvObject);
}

@GUID("118610B7-8D94-4030-B5B8-500889788E4E")
interface IEnumVdsObject : IUnknown
{
    HRESULT Next(uint celt, char* ppObjectArray, uint* pcFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumVdsObject* ppEnum);
}

@GUID("D5D23B6D-5A55-4492-9889-397A3C2D2DBC")
interface IVdsAsync : IUnknown
{
    HRESULT Cancel();
    HRESULT Wait(int* pHrResult, VDS_ASYNC_OUTPUT* pAsyncOut);
    HRESULT QueryStatus(int* pHrResult, uint* pulPercentCompleted);
}

@GUID("8326CD1D-CF59-4936-B786-5EFC08798E25")
interface IVdsAdviseSink : IUnknown
{
    HRESULT OnNotify(int lNumberOfNotifications, char* pNotificationArray);
}

@GUID("10C5E575-7984-4E81-A56B-431F5F92AE42")
interface IVdsProvider : IUnknown
{
    HRESULT GetProperties(VDS_PROVIDER_PROP* pProviderProp);
}

@GUID("1732BE13-E8F9-4A03-BFBC-5F616AA66CE1")
interface IVdsProviderSupport : IUnknown
{
    HRESULT GetVersionSupport(uint* ulVersionSupport);
}

@GUID("11F3CD41-B7E8-48FF-9472-9DFF018AA292")
interface IVdsProviderPrivate : IUnknown
{
    HRESULT GetObjectA(GUID ObjectId, VDS_OBJECT_TYPE type, IUnknown* ppObjectUnk);
    HRESULT OnLoad(const(wchar)* pwszMachineName, IUnknown pCallbackObject);
    HRESULT OnUnload(BOOL bForceUnload);
}

@GUID("D99BDAAE-B13A-4178-9FDB-E27F16B4603E")
interface IVdsHwProvider : IUnknown
{
    HRESULT QuerySubSystems(IEnumVdsObject* ppEnum);
    HRESULT Reenumerate();
    HRESULT Refresh();
}

@GUID("3E0F5166-542D-4FC6-947A-012174240B7E")
interface IVdsHwProviderType : IUnknown
{
    HRESULT GetProviderType(VDS_HWPROVIDER_TYPE* pType);
}

@GUID("8190236F-C4D0-4E81-8011-D69512FCC984")
interface IVdsHwProviderType2 : IUnknown
{
    HRESULT GetProviderType2(VDS_HWPROVIDER_TYPE* pType);
}

@GUID("D5B5937A-F188-4C79-B86C-11C920AD11B8")
interface IVdsHwProviderStoragePools : IUnknown
{
    HRESULT QueryStoragePools(uint ulFlags, ulong ullRemainingFreeSpace, VDS_POOL_ATTRIBUTES* pPoolAttributes, 
                              IEnumVdsObject* ppEnum);
    HRESULT CreateLunInStoragePool(VDS_LUN_TYPE type, ulong ullSizeInBytes, GUID StoragePoolId, 
                                   const(wchar)* pwszUnmaskingList, VDS_HINTS2* pHints2, IVdsAsync* ppAsync);
    HRESULT QueryMaxLunCreateSizeInStoragePool(VDS_LUN_TYPE type, GUID StoragePoolId, VDS_HINTS2* pHints2, 
                                               ulong* pullMaxLunSize);
}

@GUID("6FCEE2D3-6D90-4F91-80E2-A5C7CAACA9D8")
interface IVdsSubSystem : IUnknown
{
    HRESULT GetProperties(VDS_SUB_SYSTEM_PROP* pSubSystemProp);
    HRESULT GetProvider(IVdsProvider* ppProvider);
    HRESULT QueryControllers(IEnumVdsObject* ppEnum);
    HRESULT QueryLuns(IEnumVdsObject* ppEnum);
    HRESULT QueryDrives(IEnumVdsObject* ppEnum);
    HRESULT GetDrive(short sBusNumber, short sSlotNumber, IVdsDrive* ppDrive);
    HRESULT Reenumerate();
    HRESULT SetControllerStatus(char* pOnlineControllerIdArray, int lNumberOfOnlineControllers, 
                                char* pOfflineControllerIdArray, int lNumberOfOfflineControllers);
    HRESULT CreateLun(VDS_LUN_TYPE type, ulong ullSizeInBytes, char* pDriveIdArray, int lNumberOfDrives, 
                      const(wchar)* pwszUnmaskingList, VDS_HINTS* pHints, IVdsAsync* ppAsync);
    HRESULT ReplaceDrive(GUID DriveToBeReplaced, GUID ReplacementDrive);
    HRESULT SetStatus(VDS_SUB_SYSTEM_STATUS status);
    HRESULT QueryMaxLunCreateSize(VDS_LUN_TYPE type, char* pDriveIdArray, int lNumberOfDrives, VDS_HINTS* pHints, 
                                  ulong* pullMaxLunSize);
}

@GUID("BE666735-7800-4A77-9D9C-40F85B87E292")
interface IVdsSubSystem2 : IUnknown
{
    HRESULT GetProperties2(VDS_SUB_SYSTEM_PROP2* pSubSystemProp2);
    HRESULT GetDrive2(short sBusNumber, short sSlotNumber, uint ulEnclosureNumber, IVdsDrive* ppDrive);
    HRESULT CreateLun2(VDS_LUN_TYPE type, ulong ullSizeInBytes, char* pDriveIdArray, int lNumberOfDrives, 
                       const(wchar)* pwszUnmaskingList, VDS_HINTS2* pHints2, IVdsAsync* ppAsync);
    HRESULT QueryMaxLunCreateSize2(VDS_LUN_TYPE type, char* pDriveIdArray, int lNumberOfDrives, 
                                   VDS_HINTS2* pHints2, ulong* pullMaxLunSize);
}

@GUID("0D70FAA3-9CD4-4900-AA20-6981B6AAFC75")
interface IVdsSubSystemNaming : IUnknown
{
    HRESULT SetFriendlyName(const(wchar)* pwszFriendlyName);
}

@GUID("0027346F-40D0-4B45-8CEC-5906DC0380C8")
interface IVdsSubSystemIscsi : IUnknown
{
    HRESULT QueryTargets(IEnumVdsObject* ppEnum);
    HRESULT QueryPortals(IEnumVdsObject* ppEnum);
    HRESULT CreateTarget(const(wchar)* pwszIscsiName, const(wchar)* pwszFriendlyName, IVdsAsync* ppAsync);
    HRESULT SetIpsecGroupPresharedKey(VDS_ISCSI_IPSEC_KEY* pIpsecKey);
}

@GUID("9E6FA560-C141-477B-83BA-0B6C38F7FEBF")
interface IVdsSubSystemInterconnect : IUnknown
{
    HRESULT GetSupportedInterconnects(uint* pulSupportedInterconnectsFlag);
}

@GUID("18691D0D-4E7F-43E8-92E4-CF44BEEED11C")
interface IVdsControllerPort : IUnknown
{
    HRESULT GetProperties(VDS_PORT_PROP* pPortProp);
    HRESULT GetController(IVdsController* ppController);
    HRESULT QueryAssociatedLuns(IEnumVdsObject* ppEnum);
    HRESULT Reset();
    HRESULT SetStatus(VDS_PORT_STATUS status);
}

@GUID("CB53D96E-DFFB-474A-A078-790D1E2BC082")
interface IVdsController : IUnknown
{
    HRESULT GetProperties(VDS_CONTROLLER_PROP* pControllerProp);
    HRESULT GetSubSystem(IVdsSubSystem* ppSubSystem);
    HRESULT GetPortProperties(short sPortNumber, VDS_PORT_PROP* pPortProp);
    HRESULT FlushCache();
    HRESULT InvalidateCache();
    HRESULT Reset();
    HRESULT QueryAssociatedLuns(IEnumVdsObject* ppEnum);
    HRESULT SetStatus(VDS_CONTROLLER_STATUS status);
}

@GUID("CA5D735F-6BAE-42C0-B30E-F2666045CE71")
interface IVdsControllerControllerPort : IUnknown
{
    HRESULT QueryControllerPorts(IEnumVdsObject* ppEnum);
}

@GUID("FF24EFA4-AADE-4B6B-898B-EAA6A20887C7")
interface IVdsDrive : IUnknown
{
    HRESULT GetProperties(VDS_DRIVE_PROP* pDriveProp);
    HRESULT GetSubSystem(IVdsSubSystem* ppSubSystem);
    HRESULT QueryExtents(char* ppExtentArray, int* plNumberOfExtents);
    HRESULT SetFlags(uint ulFlags);
    HRESULT ClearFlags(uint ulFlags);
    HRESULT SetStatus(VDS_DRIVE_STATUS status);
}

@GUID("60B5A730-ADDF-4436-8CA7-5769E2D1FFA4")
interface IVdsDrive2 : IUnknown
{
    HRESULT GetProperties2(VDS_DRIVE_PROP2* pDriveProp2);
}

@GUID("3540A9C7-E60F-4111-A840-8BBA6C2C83D8")
interface IVdsLun : IUnknown
{
    HRESULT GetProperties(VDS_LUN_PROP* pLunProp);
    HRESULT GetSubSystem(IVdsSubSystem* ppSubSystem);
    HRESULT GetIdentificationData(VDS_LUN_INFORMATION* pLunInfo);
    HRESULT QueryActiveControllers(IEnumVdsObject* ppEnum);
    HRESULT Extend(ulong ullNumberOfBytesToAdd, char* pDriveIdArray, int lNumberOfDrives, IVdsAsync* ppAsync);
    HRESULT Shrink(ulong ullNumberOfBytesToRemove, IVdsAsync* ppAsync);
    HRESULT QueryPlexes(IEnumVdsObject* ppEnum);
    HRESULT AddPlex(GUID lunId, IVdsAsync* ppAsync);
    HRESULT RemovePlex(GUID plexId, IVdsAsync* ppAsync);
    HRESULT Recover(IVdsAsync* ppAsync);
    HRESULT SetMask(const(wchar)* pwszUnmaskingList);
    HRESULT Delete();
    HRESULT AssociateControllers(char* pActiveControllerIdArray, int lNumberOfActiveControllers, 
                                 char* pInactiveControllerIdArray, int lNumberOfInactiveControllers);
    HRESULT QueryHints(VDS_HINTS* pHints);
    HRESULT ApplyHints(VDS_HINTS* pHints);
    HRESULT SetStatus(VDS_LUN_STATUS status);
    HRESULT QueryMaxLunExtendSize(char* pDriveIdArray, int lNumberOfDrives, ulong* pullMaxBytesToBeAdded);
}

@GUID("E5B3A735-9EFB-499A-8071-4394D9EE6FCB")
interface IVdsLun2 : IUnknown
{
    HRESULT QueryHints2(VDS_HINTS2* pHints2);
    HRESULT ApplyHints2(VDS_HINTS2* pHints2);
}

@GUID("907504CB-6B4E-4D88-A34D-17BA661FBB06")
interface IVdsLunNaming : IUnknown
{
    HRESULT SetFriendlyName(const(wchar)* pwszFriendlyName);
}

@GUID("D3F95E46-54B3-41F9-B678-0F1871443A08")
interface IVdsLunNumber : IUnknown
{
    HRESULT GetLunNumber(uint* pulLunNumber);
}

@GUID("451FE266-DA6D-406A-BB60-82E534F85AEB")
interface IVdsLunControllerPorts : IUnknown
{
    HRESULT AssociateControllerPorts(char* pActiveControllerPortIdArray, int lNumberOfActiveControllerPorts, 
                                     char* pInactiveControllerPortIdArray, int lNumberOfInactiveControllerPorts);
    HRESULT QueryActiveControllerPorts(IEnumVdsObject* ppEnum);
}

@GUID("7C5FBAE3-333A-48A1-A982-33C15788CDE3")
interface IVdsLunMpio : IUnknown
{
    HRESULT GetPathInfo(char* ppPaths, int* plNumberOfPaths);
    HRESULT GetLoadBalancePolicy(VDS_LOADBALANCE_POLICY_ENUM* pPolicy, char* ppPaths, int* plNumberOfPaths);
    HRESULT SetLoadBalancePolicy(VDS_LOADBALANCE_POLICY_ENUM policy, char* pPaths, int lNumberOfPaths);
    HRESULT GetSupportedLbPolicies(uint* pulLbFlags);
}

@GUID("0D7C1E64-B59B-45AE-B86A-2C2CC6A42067")
interface IVdsLunIscsi : IUnknown
{
    HRESULT AssociateTargets(char* pTargetIdArray, int lNumberOfTargets);
    HRESULT QueryAssociatedTargets(IEnumVdsObject* ppEnum);
}

@GUID("0EE1A790-5D2E-4ABB-8C99-C481E8BE2138")
interface IVdsLunPlex : IUnknown
{
    HRESULT GetProperties(VDS_LUN_PLEX_PROP* pPlexProp);
    HRESULT GetLun(IVdsLun* ppLun);
    HRESULT QueryExtents(char* ppExtentArray, int* plNumberOfExtents);
    HRESULT QueryHints(VDS_HINTS* pHints);
    HRESULT ApplyHints(VDS_HINTS* pHints);
}

@GUID("7FA1499D-EC85-4A8A-A47B-FF69201FCD34")
interface IVdsIscsiPortal : IUnknown
{
    HRESULT GetProperties(VDS_ISCSI_PORTAL_PROP* pPortalProp);
    HRESULT GetSubSystem(IVdsSubSystem* ppSubSystem);
    HRESULT QueryAssociatedPortalGroups(IEnumVdsObject* ppEnum);
    HRESULT SetStatus(VDS_ISCSI_PORTAL_STATUS status);
    HRESULT SetIpsecTunnelAddress(VDS_IPADDRESS* pTunnelAddress, VDS_IPADDRESS* pDestinationAddress);
    HRESULT GetIpsecSecurity(VDS_IPADDRESS* pInitiatorPortalAddress, ulong* pullSecurityFlags);
    HRESULT SetIpsecSecurity(VDS_IPADDRESS* pInitiatorPortalAddress, ulong ullSecurityFlags, 
                             VDS_ISCSI_IPSEC_KEY* pIpsecKey);
}

@GUID("AA8F5055-83E5-4BCC-AA73-19851A36A849")
interface IVdsIscsiTarget : IUnknown
{
    HRESULT GetProperties(VDS_ISCSI_TARGET_PROP* pTargetProp);
    HRESULT GetSubSystem(IVdsSubSystem* ppSubSystem);
    HRESULT QueryPortalGroups(IEnumVdsObject* ppEnum);
    HRESULT QueryAssociatedLuns(IEnumVdsObject* ppEnum);
    HRESULT CreatePortalGroup(IVdsAsync* ppAsync);
    HRESULT Delete(IVdsAsync* ppAsync);
    HRESULT SetFriendlyName(const(wchar)* pwszFriendlyName);
    HRESULT SetSharedSecret(VDS_ISCSI_SHARED_SECRET* pTargetSharedSecret, const(wchar)* pwszInitiatorName);
    HRESULT RememberInitiatorSharedSecret(const(wchar)* pwszInitiatorName, 
                                          VDS_ISCSI_SHARED_SECRET* pInitiatorSharedSecret);
    HRESULT GetConnectedInitiators(char* pppwszInitiatorList, int* plNumberOfInitiators);
}

@GUID("FEF5F89D-A3DD-4B36-BF28-E7DDE045C593")
interface IVdsIscsiPortalGroup : IUnknown
{
    HRESULT GetProperties(VDS_ISCSI_PORTALGROUP_PROP* pPortalGroupProp);
    HRESULT GetTarget(IVdsIscsiTarget* ppTarget);
    HRESULT QueryAssociatedPortals(IEnumVdsObject* ppEnum);
    HRESULT AddPortal(GUID portalId, IVdsAsync* ppAsync);
    HRESULT RemovePortal(GUID portalId, IVdsAsync* ppAsync);
    HRESULT Delete(IVdsAsync* ppAsync);
}

@GUID("932CA8CF-0EB3-4BA8-9620-22665D7F8450")
interface IVdsStoragePool : IUnknown
{
    HRESULT GetProvider(IVdsProvider* ppProvider);
    HRESULT GetProperties(VDS_STORAGE_POOL_PROP* pStoragePoolProp);
    HRESULT GetAttributes(VDS_POOL_ATTRIBUTES* pStoragePoolAttributes);
    HRESULT QueryDriveExtents(char* ppExtentArray, int* plNumberOfExtents);
    HRESULT QueryAllocatedLuns(IEnumVdsObject* ppEnum);
    HRESULT QueryAllocatedStoragePools(IEnumVdsObject* ppEnum);
}

@GUID("DAEBEEF3-8523-47ED-A2B9-05CECCE2A1AE")
interface IVdsMaintenance : IUnknown
{
    HRESULT StartMaintenance(VDS_MAINTENANCE_OPERATION operation);
    HRESULT StopMaintenance(VDS_MAINTENANCE_OPERATION operation);
    HRESULT PulseMaintenance(VDS_MAINTENANCE_OPERATION operation, uint ulCount);
}

@GUID("98F17BF3-9F33-4F12-8714-8B4075092C2E")
interface IVdsHwProviderPrivate : IUnknown
{
    HRESULT QueryIfCreatedLun(const(wchar)* pwszDevicePath, VDS_LUN_INFORMATION* pVdsLunInformation, GUID* pLunId);
}

@GUID("310A7715-AC2B-4C6F-9827-3D742F351676")
interface IVdsHwProviderPrivateMpio : IUnknown
{
    HRESULT SetAllPathStatusesFromHbaPort(VDS_HBAPORT_PROP hbaPortProp, VDS_PATH_STATUS status);
}

@GUID("D188E97D-85AA-4D33-ABC6-26299A10FFC1")
interface IVdsAdmin : IUnknown
{
    HRESULT RegisterProvider(GUID providerId, GUID providerClsid, const(wchar)* pwszName, VDS_PROVIDER_TYPE type, 
                             const(wchar)* pwszMachineName, const(wchar)* pwszVersion, GUID guidVersionId);
    HRESULT UnregisterProvider(GUID providerId);
}

@GUID("AE1C7110-2F60-11D3-8A39-00C04F72D8E3")
interface IVssEnumObject : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IVssEnumObject* ppenum);
}

@GUID("507C37B4-CF5B-4E95-B0AF-14EB9767467E")
interface IVssAsync : IUnknown
{
    HRESULT Cancel();
    HRESULT Wait(uint dwMilliseconds);
    HRESULT QueryStatus(int* pHrResult, int* pReserved);
}

interface IVssWMFiledesc : IUnknown
{
    HRESULT GetPath(BSTR* pbstrPath);
    HRESULT GetFilespec(BSTR* pbstrFilespec);
    HRESULT GetRecursive(bool* pbRecursive);
    HRESULT GetAlternateLocation(BSTR* pbstrAlternateLocation);
    HRESULT GetBackupTypeMask(uint* pdwTypeMask);
}

interface IVssWMDependency : IUnknown
{
    HRESULT GetWriterId(GUID* pWriterId);
    HRESULT GetLogicalPath(BSTR* pbstrLogicalPath);
    HRESULT GetComponentName(BSTR* pbstrComponentName);
}

@GUID("D2C72C96-C121-4518-B627-E5A93D010EAD")
interface IVssComponent : IUnknown
{
    HRESULT GetLogicalPath(BSTR* pbstrPath);
    HRESULT GetComponentType(VSS_COMPONENT_TYPE* pct);
    HRESULT GetComponentName(BSTR* pbstrName);
    HRESULT GetBackupSucceeded(bool* pbSucceeded);
    HRESULT GetAlternateLocationMappingCount(uint* pcMappings);
    HRESULT GetAlternateLocationMapping(uint iMapping, IVssWMFiledesc* ppFiledesc);
    HRESULT SetBackupMetadata(const(wchar)* wszData);
    HRESULT GetBackupMetadata(BSTR* pbstrData);
    HRESULT AddPartialFile(const(wchar)* wszPath, const(wchar)* wszFilename, const(wchar)* wszRanges, 
                           const(wchar)* wszMetadata);
    HRESULT GetPartialFileCount(uint* pcPartialFiles);
    HRESULT GetPartialFile(uint iPartialFile, BSTR* pbstrPath, BSTR* pbstrFilename, BSTR* pbstrRange, 
                           BSTR* pbstrMetadata);
    HRESULT IsSelectedForRestore(bool* pbSelectedForRestore);
    HRESULT GetAdditionalRestores(bool* pbAdditionalRestores);
    HRESULT GetNewTargetCount(uint* pcNewTarget);
    HRESULT GetNewTarget(uint iNewTarget, IVssWMFiledesc* ppFiledesc);
    HRESULT AddDirectedTarget(const(wchar)* wszSourcePath, const(wchar)* wszSourceFilename, 
                              const(wchar)* wszSourceRangeList, const(wchar)* wszDestinationPath, 
                              const(wchar)* wszDestinationFilename, const(wchar)* wszDestinationRangeList);
    HRESULT GetDirectedTargetCount(uint* pcDirectedTarget);
    HRESULT GetDirectedTarget(uint iDirectedTarget, BSTR* pbstrSourcePath, BSTR* pbstrSourceFileName, 
                              BSTR* pbstrSourceRangeList, BSTR* pbstrDestinationPath, BSTR* pbstrDestinationFilename, 
                              BSTR* pbstrDestinationRangeList);
    HRESULT SetRestoreMetadata(const(wchar)* wszRestoreMetadata);
    HRESULT GetRestoreMetadata(BSTR* pbstrRestoreMetadata);
    HRESULT SetRestoreTarget(VSS_RESTORE_TARGET target);
    HRESULT GetRestoreTarget(VSS_RESTORE_TARGET* pTarget);
    HRESULT SetPreRestoreFailureMsg(const(wchar)* wszPreRestoreFailureMsg);
    HRESULT GetPreRestoreFailureMsg(BSTR* pbstrPreRestoreFailureMsg);
    HRESULT SetPostRestoreFailureMsg(const(wchar)* wszPostRestoreFailureMsg);
    HRESULT GetPostRestoreFailureMsg(BSTR* pbstrPostRestoreFailureMsg);
    HRESULT SetBackupStamp(const(wchar)* wszBackupStamp);
    HRESULT GetBackupStamp(BSTR* pbstrBackupStamp);
    HRESULT GetPreviousBackupStamp(BSTR* pbstrBackupStamp);
    HRESULT GetBackupOptions(BSTR* pbstrBackupOptions);
    HRESULT GetRestoreOptions(BSTR* pbstrRestoreOptions);
    HRESULT GetRestoreSubcomponentCount(uint* pcRestoreSubcomponent);
    HRESULT GetRestoreSubcomponent(uint iComponent, BSTR* pbstrLogicalPath, BSTR* pbstrComponentName, 
                                   bool* pbRepair);
    HRESULT GetFileRestoreStatus(VSS_FILE_RESTORE_STATUS* pStatus);
    HRESULT AddDifferencedFilesByLastModifyTime(const(wchar)* wszPath, const(wchar)* wszFilespec, BOOL bRecursive, 
                                                FILETIME ftLastModifyTime);
    HRESULT AddDifferencedFilesByLastModifyLSN(const(wchar)* wszPath, const(wchar)* wszFilespec, BOOL bRecursive, 
                                               BSTR bstrLsnString);
    HRESULT GetDifferencedFilesCount(uint* pcDifferencedFiles);
    HRESULT GetDifferencedFile(uint iDifferencedFile, BSTR* pbstrPath, BSTR* pbstrFilespec, int* pbRecursive, 
                               BSTR* pbstrLsnString, FILETIME* pftLastModifyTime);
}

interface IVssWriterComponents
{
    HRESULT GetComponentCount(uint* pcComponents);
    HRESULT GetWriterInfo(GUID* pidInstance, GUID* pidWriter);
    HRESULT GetComponent(uint iComponent, IVssComponent* ppComponent);
}

@GUID("156C8B5E-F131-4BD7-9C97-D1923BE7E1FA")
interface IVssComponentEx : IVssComponent
{
    HRESULT SetPrepareForBackupFailureMsg(const(wchar)* wszFailureMsg);
    HRESULT SetPostSnapshotFailureMsg(const(wchar)* wszFailureMsg);
    HRESULT GetPrepareForBackupFailureMsg(BSTR* pbstrFailureMsg);
    HRESULT GetPostSnapshotFailureMsg(BSTR* pbstrFailureMsg);
    HRESULT GetAuthoritativeRestore(bool* pbAuth);
    HRESULT GetRollForward(VSS_ROLLFORWARD_TYPE* pRollType, BSTR* pbstrPoint);
    HRESULT GetRestoreName(BSTR* pbstrName);
}

@GUID("3B5BE0F2-07A9-4E4B-BDD3-CFDC8E2C0D2D")
interface IVssComponentEx2 : IVssComponentEx
{
    HRESULT SetFailure(HRESULT hr, HRESULT hrApplication, const(wchar)* wszApplicationMessage, uint dwReserved);
    HRESULT GetFailure(int* phr, int* phrApplication, BSTR* pbstrApplicationMessage, uint* pdwReserved);
}

interface IVssCreateWriterMetadata
{
    HRESULT AddIncludeFiles(const(wchar)* wszPath, const(wchar)* wszFilespec, ubyte bRecursive, 
                            const(wchar)* wszAlternateLocation);
    HRESULT AddExcludeFiles(const(wchar)* wszPath, const(wchar)* wszFilespec, ubyte bRecursive);
    HRESULT AddComponent(VSS_COMPONENT_TYPE ct, const(wchar)* wszLogicalPath, const(wchar)* wszComponentName, 
                         const(wchar)* wszCaption, const(ubyte)* pbIcon, uint cbIcon, ubyte bRestoreMetadata, 
                         ubyte bNotifyOnBackupComplete, ubyte bSelectable, ubyte bSelectableForRestore, 
                         uint dwComponentFlags);
    HRESULT AddDatabaseFiles(const(wchar)* wszLogicalPath, const(wchar)* wszDatabaseName, const(wchar)* wszPath, 
                             const(wchar)* wszFilespec, uint dwBackupTypeMask);
    HRESULT AddDatabaseLogFiles(const(wchar)* wszLogicalPath, const(wchar)* wszDatabaseName, const(wchar)* wszPath, 
                                const(wchar)* wszFilespec, uint dwBackupTypeMask);
    HRESULT AddFilesToFileGroup(const(wchar)* wszLogicalPath, const(wchar)* wszGroupName, const(wchar)* wszPath, 
                                const(wchar)* wszFilespec, ubyte bRecursive, const(wchar)* wszAlternateLocation, 
                                uint dwBackupTypeMask);
    HRESULT SetRestoreMethod(VSS_RESTOREMETHOD_ENUM method, const(wchar)* wszService, 
                             const(wchar)* wszUserProcedure, VSS_WRITERRESTORE_ENUM writerRestore, 
                             ubyte bRebootRequired);
    HRESULT AddAlternateLocationMapping(const(wchar)* wszSourcePath, const(wchar)* wszSourceFilespec, 
                                        ubyte bRecursive, const(wchar)* wszDestination);
    HRESULT AddComponentDependency(const(wchar)* wszForLogicalPath, const(wchar)* wszForComponentName, 
                                   GUID onWriterId, const(wchar)* wszOnLogicalPath, const(wchar)* wszOnComponentName);
    HRESULT SetBackupSchema(uint dwSchemaMask);
    HRESULT GetDocument(IXMLDOMDocument* pDoc);
    HRESULT SaveAsXML(BSTR* pbstrXML);
}

@GUID("9F21981D-D469-4349-B807-39E64E4674E1")
interface IVssCreateWriterMetadataEx : IUnknown
{
    HRESULT AddDatabaseFiles(const(wchar)* wszLogicalPath, const(wchar)* wszDatabaseName, const(wchar)* wszPath, 
                             const(wchar)* wszFilespec, uint dwBackupTypeMask);
    HRESULT AddDatabaseLogFiles(const(wchar)* wszLogicalPath, const(wchar)* wszDatabaseName, const(wchar)* wszPath, 
                                const(wchar)* wszFilespec, uint dwBackupTypeMask);
    HRESULT AddFilesToFileGroup(const(wchar)* wszLogicalPath, const(wchar)* wszGroupName, const(wchar)* wszPath, 
                                const(wchar)* wszFilespec, ubyte bRecursive, const(wchar)* wszAlternateLocation, 
                                uint dwBackupTypeMask);
    HRESULT SetRestoreMethod(VSS_RESTOREMETHOD_ENUM method, const(wchar)* wszService, 
                             const(wchar)* wszUserProcedure, VSS_WRITERRESTORE_ENUM writerRestore, 
                             ubyte bRebootRequired);
    HRESULT AddAlternateLocationMapping(const(wchar)* wszSourcePath, const(wchar)* wszSourceFilespec, 
                                        ubyte bRecursive, const(wchar)* wszDestination);
    HRESULT AddComponentDependency(const(wchar)* wszForLogicalPath, const(wchar)* wszForComponentName, 
                                   GUID onWriterId, const(wchar)* wszOnLogicalPath, const(wchar)* wszOnComponentName);
    HRESULT SetBackupSchema(uint dwSchemaMask);
    HRESULT GetDocument(IXMLDOMDocument* pDoc);
    HRESULT SaveAsXML(BSTR* pbstrXML);
    HRESULT QueryInterface(const(GUID)* riid, void** ppvObject);
    uint    AddRef();
    uint    Release();
    HRESULT AddExcludeFilesFromSnapshot(const(wchar)* wszPath, const(wchar)* wszFilespec, ubyte bRecursive);
}

interface IVssWriterImpl : IUnknown
{
    HRESULT  Initialize(GUID writerId, const(wchar)* wszWriterName, const(wchar)* wszWriterInstanceName, 
                        uint dwMajorVersion, uint dwMinorVersion, VSS_USAGE_TYPE ut, VSS_SOURCE_TYPE st, 
                        VSS_APPLICATION_LEVEL nLevel, uint dwTimeout, VSS_ALTERNATE_WRITER_STATE aws, 
                        ubyte bIOThrottlingOnly);
    HRESULT  Subscribe(uint dwSubscribeTimeout, uint dwEventFlags);
    HRESULT  Unsubscribe();
    void     Uninitialize();
    ushort** GetCurrentVolumeArray();
    uint     GetCurrentVolumeCount();
    HRESULT  GetSnapshotDeviceName(const(wchar)* wszOriginalVolume, ushort** ppwszSnapshotDevice);
    GUID     GetCurrentSnapshotSetId();
    int      GetContext();
    VSS_APPLICATION_LEVEL GetCurrentLevel();
    bool     IsPathAffected(const(wchar)* wszPath);
    bool     IsBootableSystemStateBackedUp();
    bool     AreComponentsSelected();
    VSS_BACKUP_TYPE GetBackupType();
    VSS_RESTORE_TYPE GetRestoreType();
    HRESULT  SetWriterFailure(HRESULT hr);
    bool     IsPartialFileSupportEnabled();
    HRESULT  InstallAlternateWriter(GUID idWriter, GUID clsid);
    IVssExamineWriterMetadata* GetIdentityInformation();
    HRESULT  SetWriterFailureEx(HRESULT hr, HRESULT hrApplication, const(wchar)* wszApplicationMessage);
    HRESULT  GetSessionId(GUID* idSession);
    bool     IsWriterShuttingDown();
}

@GUID("9C772E77-B26E-427F-92DD-C996F41EA5E3")
interface IVssCreateExpressWriterMetadata : IUnknown
{
    HRESULT AddExcludeFiles(const(wchar)* wszPath, const(wchar)* wszFilespec, ubyte bRecursive);
    HRESULT AddComponent(VSS_COMPONENT_TYPE ct, const(wchar)* wszLogicalPath, const(wchar)* wszComponentName, 
                         const(wchar)* wszCaption, const(ubyte)* pbIcon, uint cbIcon, ubyte bRestoreMetadata, 
                         ubyte bNotifyOnBackupComplete, ubyte bSelectable, ubyte bSelectableForRestore, 
                         uint dwComponentFlags);
    HRESULT AddFilesToFileGroup(const(wchar)* wszLogicalPath, const(wchar)* wszGroupName, const(wchar)* wszPath, 
                                const(wchar)* wszFilespec, ubyte bRecursive, const(wchar)* wszAlternateLocation, 
                                uint dwBackupTypeMask);
    HRESULT SetRestoreMethod(VSS_RESTOREMETHOD_ENUM method, const(wchar)* wszService, 
                             const(wchar)* wszUserProcedure, VSS_WRITERRESTORE_ENUM writerRestore, 
                             ubyte bRebootRequired);
    HRESULT AddComponentDependency(const(wchar)* wszForLogicalPath, const(wchar)* wszForComponentName, 
                                   GUID onWriterId, const(wchar)* wszOnLogicalPath, const(wchar)* wszOnComponentName);
    HRESULT SetBackupSchema(uint dwSchemaMask);
    HRESULT SaveAsXML(BSTR* pbstrXML);
}

@GUID("E33AFFDC-59C7-47B1-97D5-4266598F6235")
interface IVssExpressWriter : IUnknown
{
    HRESULT CreateMetadata(GUID writerId, const(wchar)* writerName, VSS_USAGE_TYPE usageType, uint versionMajor, 
                           uint versionMinor, uint reserved, IVssCreateExpressWriterMetadata* ppMetadata);
    HRESULT LoadMetadata(const(wchar)* metadata, uint reserved);
    HRESULT Register();
    HRESULT Unregister(GUID writerId);
}

@GUID("FA7DF749-66E7-4986-A27F-E2F04AE53772")
interface IVssSnapshotMgmt : IUnknown
{
    HRESULT GetProviderMgmtInterface(GUID ProviderId, const(GUID)* InterfaceId, IUnknown* ppItf);
    HRESULT QueryVolumesSupportedForSnapshots(GUID ProviderId, int lContext, IVssEnumMgmtObject* ppEnum);
    HRESULT QuerySnapshotsByVolume(ushort* pwszVolumeName, GUID ProviderId, IVssEnumObject* ppEnum);
}

@GUID("0F61EC39-FE82-45F2-A3F0-768B5D427102")
interface IVssSnapshotMgmt2 : IUnknown
{
    HRESULT GetMinDiffAreaSize(long* pllMinDiffAreaSize);
}

@GUID("214A0F28-B737-4026-B847-4F9E37D79529")
interface IVssDifferentialSoftwareSnapshotMgmt : IUnknown
{
    HRESULT AddDiffArea(ushort* pwszVolumeName, ushort* pwszDiffAreaVolumeName, long llMaximumDiffSpace);
    HRESULT ChangeDiffAreaMaximumSize(ushort* pwszVolumeName, ushort* pwszDiffAreaVolumeName, 
                                      long llMaximumDiffSpace);
    HRESULT QueryVolumesSupportedForDiffAreas(ushort* pwszOriginalVolumeName, IVssEnumMgmtObject* ppEnum);
    HRESULT QueryDiffAreasForVolume(ushort* pwszVolumeName, IVssEnumMgmtObject* ppEnum);
    HRESULT QueryDiffAreasOnVolume(ushort* pwszVolumeName, IVssEnumMgmtObject* ppEnum);
    HRESULT QueryDiffAreasForSnapshot(GUID SnapshotId, IVssEnumMgmtObject* ppEnum);
}

@GUID("949D7353-675F-4275-8969-F044C6277815")
interface IVssDifferentialSoftwareSnapshotMgmt2 : IVssDifferentialSoftwareSnapshotMgmt
{
    HRESULT ChangeDiffAreaMaximumSizeEx(ushort* pwszVolumeName, ushort* pwszDiffAreaVolumeName, 
                                        long llMaximumDiffSpace, BOOL bVolatile);
    HRESULT MigrateDiffAreas(ushort* pwszVolumeName, ushort* pwszDiffAreaVolumeName, 
                             ushort* pwszNewDiffAreaVolumeName);
    HRESULT QueryMigrationStatus(ushort* pwszVolumeName, ushort* pwszDiffAreaVolumeName, IVssAsync* ppAsync);
    HRESULT SetSnapshotPriority(GUID idSnapshot, ubyte priority);
}

@GUID("383F7E71-A4C5-401F-B27F-F826289F8458")
interface IVssDifferentialSoftwareSnapshotMgmt3 : IVssDifferentialSoftwareSnapshotMgmt2
{
    HRESULT SetVolumeProtectLevel(ushort* pwszVolumeName, VSS_PROTECTION_LEVEL protectionLevel);
    HRESULT GetVolumeProtectLevel(ushort* pwszVolumeName, VSS_VOLUME_PROTECTION_INFO* protectionLevel);
    HRESULT ClearVolumeProtectFault(ushort* pwszVolumeName);
    HRESULT DeleteUnusedDiffAreas(ushort* pwszDiffAreaVolumeName);
    HRESULT QuerySnapshotDeltaBitmap(GUID idSnapshotOlder, GUID idSnapshotYounger, uint* pcBlockSizePerBit, 
                                     uint* pcBitmapLength, char* ppbBitmap);
}

@GUID("01954E6B-9254-4E6E-808C-C9E05D007696")
interface IVssEnumMgmtObject : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IVssEnumMgmtObject* ppenum);
}

@GUID("77ED5996-2F63-11D3-8A39-00C04F72D8E3")
interface IVssAdmin : IUnknown
{
    HRESULT RegisterProvider(GUID pProviderId, GUID ClassId, ushort* pwszProviderName, 
                             VSS_PROVIDER_TYPE eProviderType, ushort* pwszProviderVersion, GUID ProviderVersionId);
    HRESULT UnregisterProvider(GUID ProviderId);
    HRESULT QueryProviders(IVssEnumObject* ppEnum);
    HRESULT AbortAllSnapshotsInProgress();
}

@GUID("7858A9F8-B1FA-41A6-964F-B9B36B8CD8D8")
interface IVssAdminEx : IVssAdmin
{
    HRESULT GetProviderCapability(GUID pProviderId, ulong* pllOriginalCapabilityMask);
    HRESULT GetProviderContext(GUID ProviderId, int* plContext);
    HRESULT SetProviderContext(GUID ProviderId, int lContext);
}

@GUID("609E123E-2C5A-44D3-8F01-0B1D9A47D1FF")
interface IVssSoftwareSnapshotProvider : IUnknown
{
    HRESULT SetContext(int lContext);
    HRESULT GetSnapshotProperties(GUID SnapshotId, VSS_SNAPSHOT_PROP* pProp);
    HRESULT Query(GUID QueriedObjectId, VSS_OBJECT_TYPE eQueriedObjectType, VSS_OBJECT_TYPE eReturnedObjectsType, 
                  IVssEnumObject* ppEnum);
    HRESULT DeleteSnapshots(GUID SourceObjectId, VSS_OBJECT_TYPE eSourceObjectType, BOOL bForceDelete, 
                            int* plDeletedSnapshots, GUID* pNondeletedSnapshotID);
    HRESULT BeginPrepareSnapshot(GUID SnapshotSetId, GUID SnapshotId, ushort* pwszVolumeName, int lNewContext);
    HRESULT IsVolumeSupported(ushort* pwszVolumeName, int* pbSupportedByThisProvider);
    HRESULT IsVolumeSnapshotted(ushort* pwszVolumeName, int* pbSnapshotsPresent, int* plSnapshotCompatibility);
    HRESULT SetSnapshotProperty(GUID SnapshotId, VSS_SNAPSHOT_PROPERTY_ID eSnapshotPropertyId, VARIANT vProperty);
    HRESULT RevertToSnapshot(GUID SnapshotId);
    HRESULT QueryRevertStatus(ushort* pwszVolume, IVssAsync* ppAsync);
}

@GUID("5F894E5B-1E39-4778-8E23-9ABAD9F0E08C")
interface IVssProviderCreateSnapshotSet : IUnknown
{
    HRESULT EndPrepareSnapshots(GUID SnapshotSetId);
    HRESULT PreCommitSnapshots(GUID SnapshotSetId);
    HRESULT CommitSnapshots(GUID SnapshotSetId);
    HRESULT PostCommitSnapshots(GUID SnapshotSetId, int lSnapshotsCount);
    HRESULT PreFinalCommitSnapshots(GUID SnapshotSetId);
    HRESULT PostFinalCommitSnapshots(GUID SnapshotSetId);
    HRESULT AbortSnapshots(GUID SnapshotSetId);
}

@GUID("E561901F-03A5-4AFE-86D0-72BAEECE7004")
interface IVssProviderNotifications : IUnknown
{
    HRESULT OnLoad(IUnknown pCallback);
    HRESULT OnUnload(BOOL bForceUnload);
}

@GUID("9593A157-44E9-4344-BBEB-44FBF9B06B10")
interface IVssHardwareSnapshotProvider : IUnknown
{
    HRESULT AreLunsSupported(int lLunCount, int lContext, char* rgwszDevices, char* pLunInformation, 
                             int* pbIsSupported);
    HRESULT FillInLunInfo(ushort* wszDeviceName, VDS_LUN_INFORMATION* pLunInfo, int* pbIsSupported);
    HRESULT BeginPrepareSnapshot(GUID SnapshotSetId, GUID SnapshotId, int lContext, int lLunCount, 
                                 char* rgDeviceNames, char* rgLunInformation);
    HRESULT GetTargetLuns(int lLunCount, char* rgDeviceNames, char* rgSourceLuns, char* rgDestinationLuns);
    HRESULT LocateLuns(int lLunCount, char* rgSourceLuns);
    HRESULT OnLunEmpty(ushort* wszDeviceName, VDS_LUN_INFORMATION* pInformation);
}

@GUID("7F5BA925-CDB1-4D11-A71F-339EB7E709FD")
interface IVssHardwareSnapshotProviderEx : IVssHardwareSnapshotProvider
{
    HRESULT GetProviderCapabilities(ulong* pllOriginalCapabilityMask);
    HRESULT OnLunStateChange(char* pSnapshotLuns, char* pOriginalLuns, uint dwCount, uint dwFlags);
    HRESULT ResyncLuns(char* pSourceLuns, char* pTargetLuns, uint dwCount, IVssAsync* ppAsync);
    HRESULT OnReuseLuns(char* pSnapshotLuns, char* pOriginalLuns, uint dwCount);
}

@GUID("C8636060-7C2E-11DF-8C4A-0800200C9A66")
interface IVssFileShareSnapshotProvider : IUnknown
{
    HRESULT SetContext(int lContext);
    HRESULT GetSnapshotProperties(GUID SnapshotId, VSS_SNAPSHOT_PROP* pProp);
    HRESULT Query(GUID QueriedObjectId, VSS_OBJECT_TYPE eQueriedObjectType, VSS_OBJECT_TYPE eReturnedObjectsType, 
                  IVssEnumObject* ppEnum);
    HRESULT DeleteSnapshots(GUID SourceObjectId, VSS_OBJECT_TYPE eSourceObjectType, BOOL bForceDelete, 
                            int* plDeletedSnapshots, GUID* pNondeletedSnapshotID);
    HRESULT BeginPrepareSnapshot(GUID SnapshotSetId, GUID SnapshotId, ushort* pwszSharePath, int lNewContext, 
                                 GUID ProviderId);
    HRESULT IsPathSupported(ushort* pwszSharePath, int* pbSupportedByThisProvider);
    HRESULT IsPathSnapshotted(ushort* pwszSharePath, int* pbSnapshotsPresent, int* plSnapshotCompatibility);
    HRESULT SetSnapshotProperty(GUID SnapshotId, VSS_SNAPSHOT_PROPERTY_ID eSnapshotPropertyId, VARIANT vProperty);
}


// GUIDs

const GUID CLSID_VSSCoordinator  = GUIDOF!VSSCoordinator;
const GUID CLSID_VssSnapshotMgmt = GUIDOF!VssSnapshotMgmt;

const GUID IID_IEnumVdsObject                        = GUIDOF!IEnumVdsObject;
const GUID IID_IServiceProvider                      = GUIDOF!IServiceProvider;
const GUID IID_IVdsAdmin                             = GUIDOF!IVdsAdmin;
const GUID IID_IVdsAdviseSink                        = GUIDOF!IVdsAdviseSink;
const GUID IID_IVdsAsync                             = GUIDOF!IVdsAsync;
const GUID IID_IVdsController                        = GUIDOF!IVdsController;
const GUID IID_IVdsControllerControllerPort          = GUIDOF!IVdsControllerControllerPort;
const GUID IID_IVdsControllerPort                    = GUIDOF!IVdsControllerPort;
const GUID IID_IVdsDrive                             = GUIDOF!IVdsDrive;
const GUID IID_IVdsDrive2                            = GUIDOF!IVdsDrive2;
const GUID IID_IVdsHwProvider                        = GUIDOF!IVdsHwProvider;
const GUID IID_IVdsHwProviderPrivate                 = GUIDOF!IVdsHwProviderPrivate;
const GUID IID_IVdsHwProviderPrivateMpio             = GUIDOF!IVdsHwProviderPrivateMpio;
const GUID IID_IVdsHwProviderStoragePools            = GUIDOF!IVdsHwProviderStoragePools;
const GUID IID_IVdsHwProviderType                    = GUIDOF!IVdsHwProviderType;
const GUID IID_IVdsHwProviderType2                   = GUIDOF!IVdsHwProviderType2;
const GUID IID_IVdsIscsiPortal                       = GUIDOF!IVdsIscsiPortal;
const GUID IID_IVdsIscsiPortalGroup                  = GUIDOF!IVdsIscsiPortalGroup;
const GUID IID_IVdsIscsiTarget                       = GUIDOF!IVdsIscsiTarget;
const GUID IID_IVdsLun                               = GUIDOF!IVdsLun;
const GUID IID_IVdsLun2                              = GUIDOF!IVdsLun2;
const GUID IID_IVdsLunControllerPorts                = GUIDOF!IVdsLunControllerPorts;
const GUID IID_IVdsLunIscsi                          = GUIDOF!IVdsLunIscsi;
const GUID IID_IVdsLunMpio                           = GUIDOF!IVdsLunMpio;
const GUID IID_IVdsLunNaming                         = GUIDOF!IVdsLunNaming;
const GUID IID_IVdsLunNumber                         = GUIDOF!IVdsLunNumber;
const GUID IID_IVdsLunPlex                           = GUIDOF!IVdsLunPlex;
const GUID IID_IVdsMaintenance                       = GUIDOF!IVdsMaintenance;
const GUID IID_IVdsProvider                          = GUIDOF!IVdsProvider;
const GUID IID_IVdsProviderPrivate                   = GUIDOF!IVdsProviderPrivate;
const GUID IID_IVdsProviderSupport                   = GUIDOF!IVdsProviderSupport;
const GUID IID_IVdsStoragePool                       = GUIDOF!IVdsStoragePool;
const GUID IID_IVdsSubSystem                         = GUIDOF!IVdsSubSystem;
const GUID IID_IVdsSubSystem2                        = GUIDOF!IVdsSubSystem2;
const GUID IID_IVdsSubSystemInterconnect             = GUIDOF!IVdsSubSystemInterconnect;
const GUID IID_IVdsSubSystemIscsi                    = GUIDOF!IVdsSubSystemIscsi;
const GUID IID_IVdsSubSystemNaming                   = GUIDOF!IVdsSubSystemNaming;
const GUID IID_IVssAdmin                             = GUIDOF!IVssAdmin;
const GUID IID_IVssAdminEx                           = GUIDOF!IVssAdminEx;
const GUID IID_IVssAsync                             = GUIDOF!IVssAsync;
const GUID IID_IVssComponent                         = GUIDOF!IVssComponent;
const GUID IID_IVssComponentEx                       = GUIDOF!IVssComponentEx;
const GUID IID_IVssComponentEx2                      = GUIDOF!IVssComponentEx2;
const GUID IID_IVssCreateExpressWriterMetadata       = GUIDOF!IVssCreateExpressWriterMetadata;
const GUID IID_IVssCreateWriterMetadataEx            = GUIDOF!IVssCreateWriterMetadataEx;
const GUID IID_IVssDifferentialSoftwareSnapshotMgmt  = GUIDOF!IVssDifferentialSoftwareSnapshotMgmt;
const GUID IID_IVssDifferentialSoftwareSnapshotMgmt2 = GUIDOF!IVssDifferentialSoftwareSnapshotMgmt2;
const GUID IID_IVssDifferentialSoftwareSnapshotMgmt3 = GUIDOF!IVssDifferentialSoftwareSnapshotMgmt3;
const GUID IID_IVssEnumMgmtObject                    = GUIDOF!IVssEnumMgmtObject;
const GUID IID_IVssEnumObject                        = GUIDOF!IVssEnumObject;
const GUID IID_IVssExpressWriter                     = GUIDOF!IVssExpressWriter;
const GUID IID_IVssFileShareSnapshotProvider         = GUIDOF!IVssFileShareSnapshotProvider;
const GUID IID_IVssHardwareSnapshotProvider          = GUIDOF!IVssHardwareSnapshotProvider;
const GUID IID_IVssHardwareSnapshotProviderEx        = GUIDOF!IVssHardwareSnapshotProviderEx;
const GUID IID_IVssProviderCreateSnapshotSet         = GUIDOF!IVssProviderCreateSnapshotSet;
const GUID IID_IVssProviderNotifications             = GUIDOF!IVssProviderNotifications;
const GUID IID_IVssSnapshotMgmt                      = GUIDOF!IVssSnapshotMgmt;
const GUID IID_IVssSnapshotMgmt2                     = GUIDOF!IVssSnapshotMgmt2;
const GUID IID_IVssSoftwareSnapshotProvider          = GUIDOF!IVssSoftwareSnapshotProvider;
