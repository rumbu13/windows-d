// Written in the D programming language.

module windows.win32.system.power;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, DEVPROPKEY, HANDLE, HRESULT,
                                         LPARAM, NTSTATUS, PWSTR, WIN32_ERROR;
public import windows.win32.system.registry : HKEY, REG_SAM_FLAGS;
public import windows.win32.system.threading : REASON_CONTEXT;
public import windows.win32.ui.windowsandmessaging : REGISTER_NOTIFICATION_FLAGS;

extern(Windows) @nogc nothrow:


// Enums


alias POWER_COOLING_MODE = ushort;
enum : ushort
{
    PO_TZ_ACTIVE       = cast(ushort) 0x0000,
    PO_TZ_PASSIVE      = cast(ushort) 0x0001,
    PO_TZ_INVALID_MODE = cast(ushort) 0x0002,
}

alias POWER_PLATFORM_ROLE_VERSION = uint;
enum : uint
{
    POWER_PLATFORM_ROLE_V1 = 0x00000001U,
    POWER_PLATFORM_ROLE_V2 = 0x00000002U,
}

alias EXECUTION_STATE = uint;
enum : uint
{
    ES_AWAYMODE_REQUIRED = 0x00000040U,
    ES_CONTINUOUS        = 0x80000000U,
    ES_DISPLAY_REQUIRED  = 0x00000002U,
    ES_SYSTEM_REQUIRED   = 0x00000001U,
    ES_USER_PRESENT      = 0x00000004U,
}

alias POWER_ACTION_POLICY_EVENT_CODE = uint;
enum : uint
{
    POWER_FORCE_TRIGGER_RESET     = 0x80000000U,
    POWER_LEVEL_USER_NOTIFY_EXEC  = 0x00000004U,
    POWER_LEVEL_USER_NOTIFY_SOUND = 0x00000002U,
    POWER_LEVEL_USER_NOTIFY_TEXT  = 0x00000001U,
    POWER_USER_NOTIFY_BUTTON      = 0x00000008U,
    POWER_USER_NOTIFY_SHUTDOWN    = 0x00000010U,
}

alias DEVICE_POWER_CAPABILITIES = uint;
enum : uint
{
    PDCAP_D0_SUPPORTED           = 0x00000001U,
    PDCAP_D1_SUPPORTED           = 0x00000002U,
    PDCAP_D2_SUPPORTED           = 0x00000004U,
    PDCAP_D3_SUPPORTED           = 0x00000008U,
    PDCAP_WAKE_FROM_D0_SUPPORTED = 0x00000010U,
    PDCAP_WAKE_FROM_D1_SUPPORTED = 0x00000020U,
    PDCAP_WAKE_FROM_D2_SUPPORTED = 0x00000040U,
    PDCAP_WAKE_FROM_D3_SUPPORTED = 0x00000080U,
    PDCAP_WARM_EJECT_SUPPORTED   = 0x00000100U,
    PDCAP_S0_SUPPORTED           = 0x00010000U,
    PDCAP_S1_SUPPORTED           = 0x00020000U,
    PDCAP_S2_SUPPORTED           = 0x00040000U,
    PDCAP_S3_SUPPORTED           = 0x00080000U,
    PDCAP_WAKE_FROM_S0_SUPPORTED = 0x00100000U,
    PDCAP_WAKE_FROM_S1_SUPPORTED = 0x00200000U,
    PDCAP_WAKE_FROM_S2_SUPPORTED = 0x00400000U,
    PDCAP_WAKE_FROM_S3_SUPPORTED = 0x00800000U,
    PDCAP_S4_SUPPORTED           = 0x01000000U,
    PDCAP_S5_SUPPORTED           = 0x02000000U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/powersetting/ne-powersetting-effective_power_mode
alias EFFECTIVE_POWER_MODE = int;
enum : int
{
    EffectivePowerModeBatterySaver           = 0x00000000,
    EffectivePowerModeEnergySaverHighSavings = 0x00000000,
    EffectivePowerModeBetterBattery          = 0x00000001,
    EffectivePowerModeEnergySaverStandard    = 0x00000001,
    EffectivePowerModeBalanced               = 0x00000002,
    EffectivePowerModeHighPerformance        = 0x00000003,
    EffectivePowerModeMaxPerformance         = 0x00000004,
    EffectivePowerModeGameMode               = 0x00000005,
    EffectivePowerModeMixedReality           = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/powrprof/ne-powrprof-power_data_accessor
alias POWER_DATA_ACCESSOR = int;
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
    ACCESS_POWER_MODE                           = 0x0000001a,
    ACCESS_ACTIVE_OVERLAY_SCHEME                = 0x0000001b,
}

alias BATTERY_QUERY_INFORMATION_LEVEL = int;
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

alias BATTERY_CHARGING_SOURCE_TYPE = int;
enum : int
{
    BatteryChargingSourceType_AC       = 0x00000001,
    BatteryChargingSourceType_USB      = 0x00000002,
    BatteryChargingSourceType_Wireless = 0x00000003,
    BatteryChargingSourceType_Max      = 0x00000004,
}

alias USB_CHARGER_PORT = int;
enum : int
{
    UsbChargerPort_Legacy = 0x00000000,
    UsbChargerPort_TypeC  = 0x00000001,
    UsbChargerPort_Max    = 0x00000002,
}

alias BATTERY_SET_INFORMATION_LEVEL = int;
enum : int
{
    BatteryCriticalBias   = 0x00000000,
    BatteryCharge         = 0x00000001,
    BatteryDischarge      = 0x00000002,
    BatteryChargingSource = 0x00000003,
    BatteryChargerId      = 0x00000004,
    BatteryChargerStatus  = 0x00000005,
}

alias ACPI_TIME_RESOLUTION = int;
enum : int
{
    AcpiTimeResolutionMilliseconds = 0x00000000,
    AcpiTimeResolutionSeconds      = 0x00000001,
    AcpiTimeResolutionMax          = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/emi/ne-emi-emi_measurement_unit
alias EMI_MEASUREMENT_UNIT = int;
enum : int
{
    EmiMeasurementUnitPicowattHours = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-system_power_state
alias SYSTEM_POWER_STATE = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-power_action
alias POWER_ACTION = int;
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

alias DEVICE_POWER_STATE = int;
enum : int
{
    PowerDeviceUnspecified = 0x00000000,
    PowerDeviceD0          = 0x00000001,
    PowerDeviceD1          = 0x00000002,
    PowerDeviceD2          = 0x00000003,
    PowerDeviceD3          = 0x00000004,
    PowerDeviceMaximum     = 0x00000005,
}

alias USER_ACTIVITY_PRESENCE = int;
enum : int
{
    PowerUserPresent    = 0x00000000,
    PowerUserNotPresent = 0x00000001,
    PowerUserInactive   = 0x00000002,
    PowerUserMaximum    = 0x00000003,
    PowerUserInvalid    = 0x00000003,
}

alias LATENCY_TIME = int;
enum : int
{
    LT_DONT_CARE      = 0x00000000,
    LT_LOWEST_LATENCY = 0x00000001,
}

alias POWER_REQUEST_TYPE = int;
enum : int
{
    PowerRequestDisplayRequired   = 0x00000000,
    PowerRequestSystemRequired    = 0x00000001,
    PowerRequestAwayModeRequired  = 0x00000002,
    PowerRequestExecutionRequired = 0x00000003,
}

alias POWER_INFORMATION_LEVEL = int;
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
    SendSuspendResumeNotification      = 0x00000060,
    BlackBoxRecorderDirectAccessBuffer = 0x00000061,
    SystemPowerSourceState             = 0x00000062,
    PowerInformationLevelMaximum       = 0x00000063,
}

alias POWER_USER_PRESENCE_TYPE = int;
enum : int
{
    UserNotPresent = 0x00000000,
    UserPresent    = 0x00000001,
    UserUnknown    = 0x000000ff,
}

alias POWER_MONITOR_REQUEST_REASON = int;
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
    MonitorRequestReasonUserInputTouchpad              = 0x00000021,
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
    MonitorRequestReasonTerminalInit                   = 0x00000033,
    MonitorRequestReasonPdcSignalSensorsHumanPresence  = 0x00000034,
    MonitorRequestReasonBatteryPreCritical             = 0x00000035,
    MonitorRequestReasonUserInputTouch                 = 0x00000036,
    MonitorRequestReasonAusterityBatteryDrain          = 0x00000037,
    MonitorRequestReasonDozeRestrictedStandby          = 0x00000038,
    MonitorRequestReasonSmartRestrictedStandby         = 0x00000039,
    MonitorRequestReasonMax                            = 0x0000003a,
}

alias POWER_MONITOR_REQUEST_TYPE = int;
enum : int
{
    MonitorRequestTypeOff          = 0x00000000,
    MonitorRequestTypeOnAndPresent = 0x00000001,
    MonitorRequestTypeToggleOn     = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-system_power_condition
alias SYSTEM_POWER_CONDITION = int;
enum : int
{
    PoAc               = 0x00000000,
    PoDc               = 0x00000001,
    PoHot              = 0x00000002,
    PoConditionMaximum = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-power_platform_role
alias POWER_PLATFORM_ROLE = int;
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

alias POWER_SETTING_ALTITUDE = int;
enum : int
{
    ALTITUDE_GROUP_POLICY      = 0x00000000,
    ALTITUDE_USER              = 0x00000001,
    ALTITUDE_RUNTIME_OVERRIDE  = 0x00000002,
    ALTITUDE_PROVISIONING      = 0x00000003,
    ALTITUDE_OEM_CUSTOMIZATION = 0x00000004,
    ALTITUDE_INTERNAL_OVERRIDE = 0x00000005,
    ALTITUDE_OS_DEFAULT        = 0x00000006,
}

// Constants


enum : uint
{
    PPM_FIRMWARE_ACPI1C2      = 0x00000001U,
    PPM_FIRMWARE_ACPI1C3      = 0x00000002U,
    PPM_FIRMWARE_ACPI1TSTATES = 0x00000004U,
    PPM_FIRMWARE_CST          = 0x00000008U,
    PPM_FIRMWARE_CSD          = 0x00000010U,
    PPM_FIRMWARE_PCT          = 0x00000020U,
    PPM_FIRMWARE_PSS          = 0x00000040U,
    PPM_FIRMWARE_XPSS         = 0x00000080U,
    PPM_FIRMWARE_PPC          = 0x00000100U,
    PPM_FIRMWARE_PSD          = 0x00000200U,
    PPM_FIRMWARE_PTC          = 0x00000400U,
    PPM_FIRMWARE_TSS          = 0x00000800U,
    PPM_FIRMWARE_TPC          = 0x00001000U,
    PPM_FIRMWARE_TSD          = 0x00002000U,
    PPM_FIRMWARE_PCCH         = 0x00004000U,
    PPM_FIRMWARE_PCCP         = 0x00008000U,
    PPM_FIRMWARE_OSC          = 0x00010000U,
    PPM_FIRMWARE_PDC          = 0x00020000U,
    PPM_FIRMWARE_CPC          = 0x00040000U,
    PPM_FIRMWARE_LPI          = 0x00080000U,
}

enum : uint
{
    PPM_PERFORMANCE_IMPLEMENTATION_NONE    = 0x00000000U,
    PPM_PERFORMANCE_IMPLEMENTATION_PSTATES = 0x00000001U,
    PPM_PERFORMANCE_IMPLEMENTATION_PCCV1   = 0x00000002U,
    PPM_PERFORMANCE_IMPLEMENTATION_CPPC    = 0x00000003U,
    PPM_PERFORMANCE_IMPLEMENTATION_PEP     = 0x00000004U,
}

enum : uint
{
    PPM_IDLE_IMPLEMENTATION_NONE      = 0x00000000U,
    PPM_IDLE_IMPLEMENTATION_CSTATES   = 0x00000001U,
    PPM_IDLE_IMPLEMENTATION_PEP       = 0x00000002U,
    PPM_IDLE_IMPLEMENTATION_MICROPEP  = 0x00000003U,
    PPM_IDLE_IMPLEMENTATION_LPISTATES = 0x00000004U,
}

enum : GUID
{
    PPM_PERFSTATE_CHANGE_GUID        = GUID("a5b32ddd-7f39-4abc-b892-900e43b59ebb"),
    PPM_PERFSTATE_DOMAIN_CHANGE_GUID = GUID("995e6b7f-d653-497a-b978-36a30c29bf01"),
}

enum GUID PPM_IDLESTATE_CHANGE_GUID = GUID("4838fe4f-f71c-4e51-9ecc-8430a7ac4c6c");
enum GUID PPM_PERFSTATES_DATA_GUID = GUID("5708cc20-7d40-4bf4-b4aa-2b01338d0126");
enum GUID PPM_IDLESTATES_DATA_GUID = GUID("ba138e10-e250-4ad7-8616-cf1a7ad410e7");

enum : GUID
{
    PPM_IDLE_ACCOUNTING_GUID    = GUID("e2a26f78-ae07-4ee0-a30f-ce54f55a94cd"),
    PPM_IDLE_ACCOUNTING_EX_GUID = GUID("d67abd39-81f8-4a5e-8152-72e31ec912ee"),
}

enum GUID PPM_THERMALCONSTRAINT_GUID = GUID("a852c2c8-1a4c-423b-8c2c-f30d82931a88");
enum GUID PPM_PERFMON_PERFSTATE_GUID = GUID("7fd18652-0cfe-40d2-b0a1-0b066a87759e");
enum GUID PPM_THERMAL_POLICY_CHANGE_GUID = GUID("48f377b8-6880-4c7b-8bdc-380176c6654d");
enum DEVPROPKEY PROCESSOR_NUMBER_PKEY = DEVPROPKEY(GUID("5724C81D-D5AF-4C1F-A103-A06E28F204C6"), 1);

enum : GUID
{
    GUID_DEVICE_BATTERY                  = GUID("72631e54-78a4-11d0-bcf7-00aa00b7b32a"),
    GUID_DEVICE_APPLICATIONLAUNCH_BUTTON = GUID("629758ee-986e-4d9e-8e47-de27f8ab054d"),
}

enum : GUID
{
    GUID_DEVICE_SYS_BUTTON        = GUID("4afa3d53-74a7-11d0-be5e-00a0c9062857"),
    GUID_DEVICE_LID               = GUID("4afa3d52-74a7-11d0-be5e-00a0c9062857"),
    GUID_DEVICE_THERMAL_ZONE      = GUID("4afa3d51-74a7-11d0-be5e-00a0c9062857"),
    GUID_DEVICE_FAN               = GUID("05ecd13d-81da-4a2a-8a4c-524f23dd4dc9"),
    GUID_DEVICE_PROCESSOR         = GUID("97fadb10-4e33-40ae-359c-8bef029dbdd0"),
    GUID_DEVICE_MEMORY            = GUID("3fd0f03d-92e0-45fb-b75c-5ed8ffb01021"),
    GUID_DEVICE_ACPI_TIME         = GUID("97f99bf6-4497-4f18-bb22-4b9fb2fbef9c"),
    GUID_DEVICE_MESSAGE_INDICATOR = GUID("cd48a365-fa94-4ce2-a232-a1b764e5d8b4"),
    GUID_DEVICE_POWER_ADAPTER     = GUID("f76c6c62-7dea-43cd-8689-d9a4af3d8557"),
}

enum GUID GUID_CLASS_INPUT = GUID("4d1e55b2-f16f-11cf-88cb-001111000030");

enum : GUID
{
    GUID_DEVINTERFACE_THERMAL_COOLING    = GUID("dbe4373d-3c81-40cb-ace4-e0e5d05f0c9f"),
    GUID_DEVINTERFACE_THERMAL_MANAGER    = GUID("927ec093-69a4-4bc0-bd02-711664714463"),
    GUID_DEVINTERFACE_POWER_LIMIT        = GUID("8f366301-091e-4056-b92f-958b27625fce"),
    GUID_DEVINTERFACE_TEMPERATURE_SENSOR = GUID("2a6c8538-7895-4d56-8567-795d3844858a"),
    GUID_DEVINTERFACE_CUSTOMIZED_IO      = GUID("2ed8544a-8eef-4033-b2a0-04aaa507cecb"),
}

enum uint BATTERY_UNKNOWN_CAPACITY = 0xffffffffU;
enum uint UNKNOWN_CAPACITY = 0xffffffffU;
enum uint BATTERY_SYSTEM_BATTERY = 0x80000000U;
enum uint BATTERY_CAPACITY_RELATIVE = 0x40000000U;
enum uint BATTERY_IS_SHORT_TERM = 0x20000000U;

enum : uint
{
    BATTERY_SEALED                  = 0x10000000U,
    BATTERY_SET_CHARGE_SUPPORTED    = 0x00000001U,
    BATTERY_SET_DISCHARGE_SUPPORTED = 0x00000002U,
}

enum : uint
{
    BATTERY_SET_CHARGINGSOURCE_SUPPORTED = 0x00000004U,
    BATTERY_SET_CHARGER_ID_SUPPORTED     = 0x00000008U,
}

enum : uint
{
    BATTERY_UNKNOWN_TIME    = 0xffffffffU,
    BATTERY_UNKNOWN_CURRENT = 0xffffffffU,
}

enum uint UNKNOWN_CURRENT = 0xffffffffU;

enum : uint
{
    BATTERY_USB_CHARGER_STATUS_FN_DEFAULT_USB = 0x00000001U,
    BATTERY_USB_CHARGER_STATUS_UCM_PD         = 0x00000002U,
}

enum : uint
{
    BATTERY_UNKNOWN_VOLTAGE = 0xffffffffU,
    BATTERY_UNKNOWN_RATE    = 0x80000000U,
}

enum : uint
{
    UNKNOWN_RATE    = 0x80000000U,
    UNKNOWN_VOLTAGE = 0xffffffffU,
}

enum uint BATTERY_POWER_ON_LINE = 0x00000001U;

enum : uint
{
    BATTERY_DISCHARGING = 0x00000002U,
    BATTERY_CHARGING    = 0x00000004U,
    BATTERY_CRITICAL    = 0x00000008U,
}

enum uint MAX_BATTERY_STRING_SIZE = 0x00000080U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Power/ioctl-battery-query-tag
    IOCTL_BATTERY_QUERY_TAG              = 0x00294040U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Power/ioctl-battery-query-information
    IOCTL_BATTERY_QUERY_INFORMATION      = 0x00294044U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Power/ioctl-battery-set-information
    IOCTL_BATTERY_SET_INFORMATION        = 0x00298048U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Power/ioctl-battery-query-status
    IOCTL_BATTERY_QUERY_STATUS           = 0x0029404cU,
    IOCTL_BATTERY_CHARGING_SOURCE_CHANGE = 0x00294050U,
}

enum uint BATTERY_TAG_INVALID = 0x00000000U;

enum : uint
{
    IOCTL_QUERY_CUSTOMIZED_IO_CAPABILITIES     = 0x00294280U,
    IOCTL_QUERY_CUSTOMIZED_INPUT_FROM_PLATFORM = 0x00294284U,
}

enum uint IOCTL_SEND_CUSTOMIZED_OUTPUT_TO_PLATFORM = 0x00298288U;
enum uint MAX_ACTIVE_COOLING_LEVELS = 0x0000000aU;
enum uint ACTIVE_COOLING = 0x00000000U;
enum uint PASSIVE_COOLING = 0x00000001U;

enum : uint
{
    THERMAL_WAIT_READ_TIMEOUT_IMMEDIATE = 0x00000000U,
    THERMAL_WAIT_READ_TIMEOUT_NONE      = 0xffffffffU,
}

enum : uint
{
    TZ_ACTIVATION_REASON_THERMAL = 0x00000001U,
    TZ_ACTIVATION_REASON_CURRENT = 0x00000002U,
}

enum : uint
{
    THERMAL_POLICY_VERSION_1 = 0x00000001U,
    THERMAL_POLICY_VERSION_2 = 0x00000002U,
}

enum : uint
{
    IOCTL_THERMAL_QUERY_INFORMATION  = 0x00294080U,
    IOCTL_THERMAL_SET_COOLING_POLICY = 0x00298084U,
}

enum uint IOCTL_RUN_ACTIVE_COOLING_METHOD = 0x00298088U;

enum : uint
{
    IOCTL_THERMAL_SET_PASSIVE_LIMIT = 0x0029808cU,
    IOCTL_THERMAL_READ_TEMPERATURE  = 0x00294090U,
    IOCTL_THERMAL_READ_POLICY       = 0x00294094U,
}

enum uint IOCTL_QUERY_LID = 0x002940c0U;
enum uint IOCTL_NOTIFY_SWITCH_EVENT = 0x00294100U;

enum : uint
{
    IOCTL_GET_SYS_BUTTON_CAPS  = 0x00294140U,
    IOCTL_GET_SYS_BUTTON_EVENT = 0x00294144U,
}

enum : uint
{
    SYS_BUTTON_POWER          = 0x00000001U,
    SYS_BUTTON_SLEEP          = 0x00000002U,
    SYS_BUTTON_LID            = 0x00000004U,
    SYS_BUTTON_WAKE           = 0x80000000U,
    SYS_BUTTON_LID_STATE_MASK = 0x00030000U,
    SYS_BUTTON_LID_OPEN       = 0x00010000U,
    SYS_BUTTON_LID_CLOSED     = 0x00020000U,
    SYS_BUTTON_LID_INITIAL    = 0x00040000U,
    SYS_BUTTON_LID_CHANGED    = 0x00080000U,
}

enum uint IOCTL_GET_PROCESSOR_OBJ_INFO = 0x00294180U;
enum uint THERMAL_COOLING_INTERFACE_VERSION = 0x00000001U;
enum uint THERMAL_DEVICE_INTERFACE_VERSION = 0x00000001U;
enum uint POWER_LIMIT_INTERFACE_VERSION = 0x00000001U;
enum uint IOCTL_SET_SYS_MESSAGE_INDICATOR = 0x002981c0U;

enum : uint
{
    IOCTL_SET_WAKE_ALARM_VALUE  = 0x00298200U,
    IOCTL_SET_WAKE_ALARM_POLICY = 0x00298204U,
}

enum : uint
{
    IOCTL_GET_WAKE_ALARM_VALUE  = 0x0029c208U,
    IOCTL_GET_WAKE_ALARM_POLICY = 0x0029c20cU,
}

enum uint ACPI_TIME_ADJUST_DAYLIGHT = 0x00000001U;

enum : uint
{
    ACPI_TIME_IN_DAYLIGHT  = 0x00000002U,
    ACPI_TIME_ZONE_UNKNOWN = 0x000007ffU,
}

enum : uint
{
    IOCTL_ACPI_GET_REAL_TIME = 0x00294210U,
    IOCTL_ACPI_SET_REAL_TIME = 0x00298214U,
}

enum uint IOCTL_GET_WAKE_ALARM_SYSTEM_POWERSTATE = 0x00294218U;
enum uint IOCTL_GET_ACPI_TIME_AND_ALARM_CAPABILITIES = 0x0029421cU;
enum GUID BATTERY_STATUS_WMI_GUID = GUID("fc4670d1-ebbf-416e-87ce-374a4ebc111a");
enum GUID BATTERY_RUNTIME_WMI_GUID = GUID("535a3767-1ac2-49bc-a077-3f7a02e40aec");
enum GUID BATTERY_TEMPERATURE_WMI_GUID = GUID("1a52a14d-adce-4a44-9a3e-c8d8f15ff2c2");
enum GUID BATTERY_FULL_CHARGED_CAPACITY_WMI_GUID = GUID("40b40565-96f7-4435-8694-97e0e4395905");
enum GUID BATTERY_CYCLE_COUNT_WMI_GUID = GUID("ef98db24-0014-4c25-a50b-c724ae5cd371");

enum : GUID
{
    BATTERY_STATIC_DATA_WMI_GUID   = GUID("05e1e463-e4e2-4ea9-80cb-9bd4b3ca0655"),
    BATTERY_STATUS_CHANGE_WMI_GUID = GUID("cddfa0c3-7c5b-4e43-a034-059fa5b84364"),
}

enum GUID BATTERY_TAG_CHANGE_WMI_GUID = GUID("5e1f6e19-8786-4d23-94fc-9e746bd5d888");

enum : uint
{
    BATTERY_NOTIFY_VERSION_1 = 0x00000001U,
    BATTERY_NOTIFY_VERSION_2 = 0x00000002U,
}

enum uint CHARGE_REQUIREMENT_MAX_POWER_SOURCE_TYPES = 0x00000002U;

enum : uint
{
    BATTERY_MINIPORT_UPDATE_DATA_VER_1 = 0x00000001U,
    BATTERY_MINIPORT_UPDATE_DATA_VER_2 = 0x00000002U,
}

enum : uint
{
    BATTERY_CLASS_MAJOR_VERSION   = 0x00000001U,
    BATTERY_CLASS_MINOR_VERSION   = 0x00000000U,
    BATTERY_CLASS_MINOR_VERSION_1 = 0x00000001U,
    BATTERY_CLASS_MINOR_VERSION_2 = 0x00000002U,
}

enum : uint
{
    ADAPTER_CLASS_MAJOR_VERSION = 0x00000001U,
    ADAPTER_CLASS_MINOR_VERSION = 0x00000000U,
}

enum GUID GUID_DEVICE_ENERGY_METER = GUID("45bd8344-7ed6-49cf-a440-c276c933b053");

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/emi/ni-emi-ioctl_emi_get_version
    IOCTL_EMI_GET_VERSION       = 0x00224000U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/emi/ni-emi-ioctl_emi_get_metadata_size
    IOCTL_EMI_GET_METADATA_SIZE = 0x00224004U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/emi/ni-emi-ioctl_emi_get_metadata
    IOCTL_EMI_GET_METADATA      = 0x00224008U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/emi/ni-emi-ioctl_emi_get_measurement
    IOCTL_EMI_GET_MEASUREMENT   = 0x0022400cU,
}

enum uint EMI_NAME_MAX = 0x00000010U;

enum : uint
{
    EMI_VERSION_V1 = 0x00000001U,
    EMI_VERSION_V2 = 0x00000002U,
}

enum : uint
{
    EFFECTIVE_POWER_MODE_V1 = 0x00000001U,
    EFFECTIVE_POWER_MODE_V2 = 0x00000002U,
}

enum uint EnableSysTrayBatteryMeter = 0x00000001U;
enum uint EnableMultiBatteryDisplay = 0x00000002U;
enum uint EnablePasswordLogon = 0x00000004U;
enum uint EnableWakeOnRing = 0x00000008U;
enum uint EnableVideoDimDisplay = 0x00000010U;

enum : uint
{
    POWER_ATTRIBUTE_HIDE      = 0x00000001U,
    POWER_ATTRIBUTE_SHOW_AOAC = 0x00000002U,
}

enum : uint
{
    DEVICEPOWER_HARDWAREID              = 0x80000000U,
    DEVICEPOWER_AND_OPERATION           = 0x40000000U,
    DEVICEPOWER_FILTER_DEVICES_PRESENT  = 0x20000000U,
    DEVICEPOWER_FILTER_HARDWARE         = 0x10000000U,
    DEVICEPOWER_FILTER_WAKEENABLED      = 0x08000000U,
    DEVICEPOWER_FILTER_WAKEPROGRAMMABLE = 0x04000000U,
    DEVICEPOWER_FILTER_ON_NAME          = 0x02000000U,
    DEVICEPOWER_SET_WAKEENABLED         = 0x00000001U,
    DEVICEPOWER_CLEAR_WAKEENABLED       = 0x00000002U,
}

enum uint THERMAL_EVENT_VERSION = 0x00000001U;

// Callbacks

//DELEGATE ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
alias EFFECTIVE_POWER_MODE_CALLBACK = void function(EFFECTIVE_POWER_MODE Mode, void* Context);
alias PWRSCHEMESENUMPROC_V1 = BOOLEAN function(uint Index, uint NameSize, 
                                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/byte* Name, 
                                               uint DescriptionSize, 
                                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/byte* Description, 
                                               POWER_POLICY* Policy, LPARAM Context);
alias PWRSCHEMESENUMPROC = BOOLEAN function(uint Index, uint NameSize, 
                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/PWSTR Name, 
                                            uint DescriptionSize, 
                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PWSTR Description, 
                                            POWER_POLICY* Policy, LPARAM Context);
alias PDEVICE_NOTIFY_CALLBACK_ROUTINE = uint function(void* Context, uint Type, void* Setting);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/Power/processor-power-information-str
struct PROCESSOR_POWER_INFORMATION
{
    uint Number;
    uint MaxMhz;
    uint CurrentMhz;
    uint MhzLimit;
    uint MaxIdleState;
    uint CurrentIdleState;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Power/system-power-information-str
struct SYSTEM_POWER_INFORMATION
{
    uint               MaxIdlenessAllowed;
    uint               Idleness;
    uint               TimeRemaining;
    POWER_COOLING_MODE CoolingMode;
}

@RAIIFree!UnregisterPowerSettingNotification
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HPOWERNOTIFY
{
    ptrdiff_t Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/powrprof/ns-powrprof-global_machine_power_policy
struct GLOBAL_MACHINE_POWER_POLICY
{
    uint               Revision;
    SYSTEM_POWER_STATE LidOpenWakeAc;
    SYSTEM_POWER_STATE LidOpenWakeDc;
    uint               BroadcastCapacityResolution;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/powrprof/ns-powrprof-global_user_power_policy
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/powrprof/ns-powrprof-global_power_policy
struct GLOBAL_POWER_POLICY
{
    GLOBAL_USER_POWER_POLICY user;
    GLOBAL_MACHINE_POWER_POLICY mach;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/powrprof/ns-powrprof-machine_power_policy
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/powrprof/ns-powrprof-machine_processor_power_policy
struct MACHINE_PROCESSOR_POWER_POLICY
{
    uint Revision;
    PROCESSOR_POWER_POLICY ProcessorPolicyAc;
    PROCESSOR_POWER_POLICY ProcessorPolicyDc;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/powrprof/ns-powrprof-user_power_policy
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
    BOOLEAN             OptimizeForPowerAc;
    BOOLEAN             OptimizeForPowerDc;
    ubyte               FanThrottleToleranceAc;
    ubyte               FanThrottleToleranceDc;
    ubyte               ForcedThrottleAc;
    ubyte               ForcedThrottleDc;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/powrprof/ns-powrprof-power_policy
struct POWER_POLICY
{
    USER_POWER_POLICY    user;
    MACHINE_POWER_POLICY mach;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/powrprof/ns-powrprof-device_notify_subscribe_parameters
struct DEVICE_NOTIFY_SUBSCRIBE_PARAMETERS
{
    PDEVICE_NOTIFY_CALLBACK_ROUTINE Callback;
    void* Context;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/powrprof/ns-powrprof-thermal_event
struct THERMAL_EVENT
{
    uint  Version;
    uint  Size;
    uint  Type;
    uint  Temperature;
    uint  TripPointTemperature;
    PWSTR Initiator;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Power/battery-query-information-str
struct BATTERY_QUERY_INFORMATION
{
    uint BatteryTag;
    BATTERY_QUERY_INFORMATION_LEVEL InformationLevel;
    uint AtRate;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Power/battery-information-str
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
    BOOLEAN SourceOnline;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Power/battery-set-information-str
struct BATTERY_SET_INFORMATION
{
    uint     BatteryTag;
    BATTERY_SET_INFORMATION_LEVEL InformationLevel;
    ubyte[1] Buffer; // Flexible array
}

struct BATTERY_CHARGER_STATUS
{
    BATTERY_CHARGING_SOURCE_TYPE Type;
    uint[1] VaData; // Flexible array
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Power/battery-wait-status-str
struct BATTERY_WAIT_STATUS
{
    uint BatteryTag;
    uint Timeout;
    uint PowerState;
    uint LowCapacity;
    uint HighCapacity;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Power/battery-status-str
struct BATTERY_STATUS
{
    uint PowerState;
    uint Capacity;
    uint Voltage;
    int  Rate;
}

union POWER_ADAPTER_POWER_STATES
{
    struct States
    {
        // Native bit field: Online: [0], RecState: [1-2], Reserved: [3-31]
        uint _bitfield0;
    }
    uint AsUlong;
}

struct POWER_ADAPTER_STATUS
{
    ubyte    Version;
    ubyte[3] Reserved;
    POWER_ADAPTER_POWER_STATES PowerState;
    uint     PeakPower;
    uint     MaxOutputPower;
    uint     MaxInputPower;
    ulong    RecStartTime;
    ulong    RecEndTime;
}

struct POWER_ADAPTER_SET_STATUS_BUFFER
{
    ubyte    Version;
    BOOLEAN  RecOverride;
    ubyte[2] Reserved;
}

struct POWER_ADAPTER_CHARGE_REQUIREMENT
{
    uint AcAdapterType;
    uint MinimumPower;
    uint NominalPower;
    uint MaximumPower;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Power/battery-manufacture-date-str
struct BATTERY_MANUFACTURE_DATE
{
    ubyte  Day;
    ubyte  Month;
    ushort Year;
}

struct CUSTOMIZED_IO_CAPABILITIES
{
    uint SupportedInputs;
    uint SupportedOutputs;
}

struct CUSTOMIZED_IO_QUERY_INPUT_RETURN
{
    uint FunctionId;
    uint ErrorCode;
    uint Value;
}

struct CUSTOMIZED_IO_SEND_OUTPUT_BUFFER
{
    uint FunctionId;
    uint Value;
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
    uint    Version;
    BOOLEAN WaitForUpdate;
    BOOLEAN Hibernate;
    BOOLEAN Critical;
    BOOLEAN ThermalStandby;
    uint    ActivationReasons;
    uint    PassiveLimit;
    uint    ActiveLevel;
    BOOLEAN OverThrottled;
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

struct ACPI_TIME_AND_ALARM_CAPABILITIES
{
    BOOLEAN              AcWakeSupported;
    BOOLEAN              DcWakeSupported;
    BOOLEAN              S4AcWakeSupported;
    BOOLEAN              S4DcWakeSupported;
    BOOLEAN              S5AcWakeSupported;
    BOOLEAN              S5DcWakeSupported;
    BOOLEAN              S4S5WakeStatusSupported;
    uint                 DeepestWakeSystemState;
    BOOLEAN              RealTimeFeaturesSupported;
    ACPI_TIME_RESOLUTION RealTimeResolution;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/emi/ns-emi-emi_version
struct EMI_VERSION
{
    ushort EmiVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/emi/ns-emi-emi_metadata_size
struct EMI_METADATA_SIZE
{
    uint MetadataSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/emi/ns-emi-emi_channel_measurement_data
struct EMI_CHANNEL_MEASUREMENT_DATA
{
    ulong AbsoluteEnergy;
    ulong AbsoluteTime;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/emi/ns-emi-emi_metadata_v1
struct EMI_METADATA_V1
{
    EMI_MEASUREMENT_UNIT MeasurementUnit;
    wchar[16]            HardwareOEM;
    wchar[16]            HardwareModel;
    ushort               HardwareRevision;
    ushort               MeteredHardwareNameSize;
    wchar[1]             MeteredHardwareName; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/emi/ns-emi-emi_channel_v2
struct EMI_CHANNEL_V2
{
    EMI_MEASUREMENT_UNIT MeasurementUnit;
    ushort               ChannelNameSize;
    wchar[1]             ChannelName; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/emi/ns-emi-emi_metadata_v2
struct EMI_METADATA_V2
{
    wchar[16]         HardwareOEM;
    wchar[16]         HardwareModel;
    ushort            HardwareRevision;
    ushort            ChannelCount;
    EMI_CHANNEL_V2[1] Channels; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/emi/ns-emi-emi_measurement_data_v2
struct EMI_MEASUREMENT_DATA_V2
{
    EMI_CHANNEL_MEASUREMENT_DATA[1] ChannelData; // Flexible array
}

struct CM_POWER_DATA
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
    BOOLEAN Connected;
    BOOLEAN Console;
}

struct POWER_SESSION_TIMEOUTS
{
    uint InputTimeout;
    uint DisplayTimeout;
}

struct POWER_SESSION_RIT_STATE
{
    BOOLEAN Active;
    ulong   LastInputTime;
}

struct POWER_SESSION_WINLOGON
{
    uint    SessionId;
    BOOLEAN Console;
    BOOLEAN Locked;
}

struct POWER_SESSION_ALLOW_EXTERNAL_DMA_DEVICES
{
    BOOLEAN IsAllowed;
}

struct POWER_IDLE_RESILIENCY
{
    uint CoalescingTimeout;
    uint IdleResiliencyPeriod;
}

struct POWER_MONITOR_INVOCATION
{
    BOOLEAN Console;
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
    ubyte[1] Data; // Flexible array
}

struct POWER_PLATFORM_INFORMATION
{
    BOOLEAN AoAc;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-battery_reporting_scale
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
    PPM_WMI_IDLE_STATE[1] State; // Flexible array
}

struct PPM_WMI_IDLE_STATES_EX
{
    uint  Type;
    uint  Count;
    uint  TargetState;
    uint  OldState;
    void* TargetProcessors;
    PPM_WMI_IDLE_STATE[1] State; // Flexible array
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
    PPM_WMI_PERF_STATE[1] State; // Flexible array
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
    PPM_WMI_PERF_STATE[1] State; // Flexible array
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
    PPM_IDLE_STATE_ACCOUNTING[1] State; // Flexible array
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
    PPM_IDLE_STATE_ACCOUNTING_EX[1] State; // Flexible array
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-power_action_policy
struct POWER_ACTION_POLICY
{
    POWER_ACTION Action;
    uint         Flags;
    POWER_ACTION_POLICY_EVENT_CODE EventCode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-system_power_level
struct SYSTEM_POWER_LEVEL
{
    BOOLEAN             Enable;
    ubyte[3]            Spare;
    uint                BatteryLevel;
    POWER_ACTION_POLICY PowerPolicy;
    SYSTEM_POWER_STATE  MinSystemState;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-system_power_policy
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
    BOOLEAN             VideoDimDisplay;
    uint[3]             VideoReserved;
    uint                SpindownTimeout;
    BOOLEAN             OptimizeForPower;
    ubyte               FanThrottleTolerance;
    ubyte               ForcedThrottle;
    ubyte               MinThrottle;
    POWER_ACTION_POLICY OverThrottled;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-processor_power_policy_info
struct PROCESSOR_POWER_POLICY_INFO
{
    uint     TimeCheck;
    uint     DemoteLimit;
    uint     PromoteLimit;
    ubyte    DemotePercent;
    ubyte    PromotePercent;
    ubyte[2] Spare;
    // Native bit field: AllowDemotion: [0], AllowPromotion: [1], Reserved: [2-31]
    uint     _bitfield0;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-processor_power_policy
struct PROCESSOR_POWER_POLICY
{
    uint     Revision;
    ubyte    DynamicThrottle;
    ubyte[3] Spare;
    // Native bit field: DisableCStates: [0], Reserved: [1-31]
    uint     _bitfield0;
    uint     PolicyCount;
    PROCESSOR_POWER_POLICY_INFO[3] Policy;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-administrator_power_policy
struct ADMINISTRATOR_POWER_POLICY
{
    SYSTEM_POWER_STATE MinSleep;
    SYSTEM_POWER_STATE MaxSleep;
    uint               MinVideoTimeout;
    uint               MaxVideoTimeout;
    uint               MinSpindownTimeout;
    uint               MaxSpindownTimeout;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-system_power_capabilities
struct SYSTEM_POWER_CAPABILITIES
{
    BOOLEAN            PowerButtonPresent;
    BOOLEAN            SleepButtonPresent;
    BOOLEAN            LidPresent;
    BOOLEAN            SystemS1;
    BOOLEAN            SystemS2;
    BOOLEAN            SystemS3;
    BOOLEAN            SystemS4;
    BOOLEAN            SystemS5;
    BOOLEAN            HiberFilePresent;
    BOOLEAN            FullWake;
    BOOLEAN            VideoDimPresent;
    BOOLEAN            ApmPresent;
    BOOLEAN            UpsPresent;
    BOOLEAN            ThermalControl;
    BOOLEAN            ProcessorThrottle;
    ubyte              ProcessorMinThrottle;
    ubyte              ProcessorMaxThrottle;
    BOOLEAN            FastSystemS4;
    BOOLEAN            Hiberboot;
    BOOLEAN            WakeAlarmPresent;
    BOOLEAN            AoAc;
    BOOLEAN            DiskSpinDown;
    ubyte              HiberFileType;
    BOOLEAN            AoAcConnectivitySupported;
    ubyte[6]           spare3;
    BOOLEAN            SystemBatteriesPresent;
    BOOLEAN            BatteriesAreShortTerm;
    BATTERY_REPORTING_SCALE[3] BatteryScale;
    SYSTEM_POWER_STATE AcOnLineWake;
    SYSTEM_POWER_STATE SoftLidWake;
    SYSTEM_POWER_STATE RtcWake;
    SYSTEM_POWER_STATE MinDeviceWakeState;
    SYSTEM_POWER_STATE DefaultLowLatencyWake;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-system_battery_state
struct SYSTEM_BATTERY_STATE
{
    BOOLEAN    AcOnLine;
    BOOLEAN    BatteryPresent;
    BOOLEAN    Charging;
    BOOLEAN    Discharging;
    BOOLEAN[3] Spare1;
    ubyte      Tag;
    uint       MaxCapacity;
    uint       RemainingCapacity;
    uint       Rate;
    uint       EstimatedTime;
    uint       DefaultAlert1;
    uint       DefaultAlert2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-powerbroadcast_setting
struct POWERBROADCAST_SETTING
{
    GUID     PowerSetting;
    uint     DataLength;
    ubyte[1] Data; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/ns-winbase-system_power_status
struct SYSTEM_POWER_STATUS
{
    ubyte ACLineStatus;
    ubyte BatteryFlag;
    ubyte BatteryLifePercent;
    ubyte SystemStatusFlag;
    uint  BatteryLifeTime;
    uint  BatteryFullLifeTime;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("POWRPROF.dll")
NTSTATUS CallNtPowerInformation(POWER_INFORMATION_LEVEL InformationLevel, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* InputBuffer, 
                                uint InputBufferLength, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* OutputBuffer, 
                                uint OutputBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("POWRPROF.dll")
BOOLEAN GetPwrCapabilities(SYSTEM_POWER_CAPABILITIES* lpspc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("POWRPROF.dll")
POWER_PLATFORM_ROLE PowerDeterminePlatformRoleEx(POWER_PLATFORM_ROLE_VERSION Version);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerRegisterSuspendResumeNotification(REGISTER_NOTIFICATION_FLAGS Flags, HANDLE Recipient, 
                                                   void** RegistrationHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerUnregisterSuspendResumeNotification(HPOWERNOTIFY RegistrationHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReadACValue(HKEY RootPowerKey, const(GUID)* SchemeGuid, const(GUID)* SubGroupOfPowerSettingsGuid, 
                             const(GUID)* PowerSettingGuid, uint* Type, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* Buffer, 
                             uint* BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReadDCValue(HKEY RootPowerKey, const(GUID)* SchemeGuid, const(GUID)* SubGroupOfPowerSettingsGuid, 
                             const(GUID)* PowerSettingGuid, uint* Type, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* Buffer, 
                             uint* BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerWriteACValueIndex(HKEY RootPowerKey, const(GUID)* SchemeGuid, 
                                   const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                                   uint AcValueIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
uint PowerWriteDCValueIndex(HKEY RootPowerKey, const(GUID)* SchemeGuid, const(GUID)* SubGroupOfPowerSettingsGuid, 
                            const(GUID)* PowerSettingGuid, uint DcValueIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerGetActiveScheme(HKEY UserRootPowerKey, GUID** ActivePolicyGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerSetActiveScheme(HKEY UserRootPowerKey, const(GUID)* SchemeGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerSettingRegisterNotification(const(GUID)* SettingGuid, REGISTER_NOTIFICATION_FLAGS Flags, 
                                             HANDLE Recipient, void** RegistrationHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerSettingUnregisterNotification(HPOWERNOTIFY RegistrationHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
@DllImport("POWRPROF.dll")
HRESULT PowerRegisterForEffectivePowerModeNotifications(uint Version, EFFECTIVE_POWER_MODE_CALLBACK Callback, 
                                                        void* Context, void** RegistrationHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.17763))], [])
@DllImport("POWRPROF.dll")
HRESULT PowerUnregisterFromEffectivePowerModeNotifications(void* RegistrationHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("POWRPROF.dll")
BOOLEAN GetPwrDiskSpindownRange(uint* puiMax, uint* puiMin);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("POWRPROF.dll")
BOOLEAN EnumPwrSchemes(PWRSCHEMESENUMPROC lpfn, LPARAM lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("POWRPROF.dll")
BOOLEAN ReadGlobalPwrPolicy(GLOBAL_POWER_POLICY* pGlobalPowerPolicy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("POWRPROF.dll")
BOOLEAN ReadPwrScheme(uint uiID, POWER_POLICY* pPowerPolicy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("POWRPROF.dll")
BOOLEAN WritePwrScheme(uint* puiID, const(PWSTR) lpszSchemeName, const(PWSTR) lpszDescription, 
                       POWER_POLICY* lpScheme);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("POWRPROF.dll")
BOOLEAN WriteGlobalPwrPolicy(GLOBAL_POWER_POLICY* pGlobalPowerPolicy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("POWRPROF.dll")
BOOLEAN DeletePwrScheme(uint uiID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("POWRPROF.dll")
BOOLEAN GetActivePwrScheme(uint* puiID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("POWRPROF.dll")
BOOLEAN SetActivePwrScheme(uint uiID, GLOBAL_POWER_POLICY* pGlobalPowerPolicy, POWER_POLICY* pPowerPolicy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("POWRPROF.dll")
BOOLEAN IsPwrSuspendAllowed();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("POWRPROF.dll")
BOOLEAN IsPwrHibernateAllowed();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("POWRPROF.dll")
BOOLEAN IsPwrShutdownAllowed();

@DllImport("POWRPROF.dll")
BOOLEAN IsAdminOverrideActive(ADMINISTRATOR_POWER_POLICY* papp);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("POWRPROF.dll")
BOOLEAN SetSuspendState(BOOLEAN bHibernate, BOOLEAN bForce, BOOLEAN bWakeupEventsDisabled);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("POWRPROF.dll")
BOOLEAN GetCurrentPowerPolicies(GLOBAL_POWER_POLICY* pGlobalPowerPolicy, POWER_POLICY* pPowerPolicy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("POWRPROF.dll")
BOOLEAN CanUserWritePwrScheme();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("POWRPROF.dll")
BOOLEAN ReadProcessorPwrScheme(uint uiID, MACHINE_PROCESSOR_POWER_POLICY* pMachineProcessorPowerPolicy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("POWRPROF.dll")
BOOLEAN WriteProcessorPwrScheme(uint uiID, MACHINE_PROCESSOR_POWER_POLICY* pMachineProcessorPowerPolicy);

@DllImport("POWRPROF.dll")
BOOLEAN ValidatePowerPolicies(GLOBAL_POWER_POLICY* pGlobalPowerPolicy, POWER_POLICY* pPowerPolicy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("POWRPROF.dll")
BOOLEAN PowerIsSettingRangeDefined(const(GUID)* SubKeyGuid, const(GUID)* SettingGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerSettingAccessCheckEx(POWER_DATA_ACCESSOR AccessFlags, const(GUID)* PowerGuid, 
                                      REG_SAM_FLAGS AccessType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerSettingAccessCheck(POWER_DATA_ACCESSOR AccessFlags, const(GUID)* PowerGuid);

@DllImport("POWRPROF.dll")
uint PowerGetUserConfiguredACPowerMode(GUID* PowerModeGuid);

@DllImport("POWRPROF.dll")
uint PowerGetUserConfiguredDCPowerMode(GUID* PowerModeGuid);

@DllImport("POWRPROF.dll")
uint PowerSetUserConfiguredACPowerMode(const(GUID)* PowerModeGuid);

@DllImport("POWRPROF.dll")
uint PowerSetUserConfiguredDCPowerMode(const(GUID)* PowerModeGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReadACValueIndex(HKEY RootPowerKey, const(GUID)* SchemeGuid, 
                                  const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                                  uint* AcValueIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
uint PowerReadDCValueIndex(HKEY RootPowerKey, const(GUID)* SchemeGuid, const(GUID)* SubGroupOfPowerSettingsGuid, 
                           const(GUID)* PowerSettingGuid, uint* DcValueIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReadFriendlyName(HKEY RootPowerKey, const(GUID)* SchemeGuid, 
                                  const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* Buffer, 
                                  uint* BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReadDescription(HKEY RootPowerKey, const(GUID)* SchemeGuid, 
                                 const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* Buffer, 
                                 uint* BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReadPossibleValue(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                   const(GUID)* PowerSettingGuid, uint* Type, uint PossibleSettingIndex, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* Buffer, 
                                   uint* BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReadPossibleFriendlyName(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                          const(GUID)* PowerSettingGuid, uint PossibleSettingIndex, 
                                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* Buffer, 
                                          uint* BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReadPossibleDescription(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                         const(GUID)* PowerSettingGuid, uint PossibleSettingIndex, 
                                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* Buffer, 
                                         uint* BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReadValueMin(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                              const(GUID)* PowerSettingGuid, uint* ValueMinimum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReadValueMax(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                              const(GUID)* PowerSettingGuid, uint* ValueMaximum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReadValueIncrement(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                    const(GUID)* PowerSettingGuid, uint* ValueIncrement);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReadValueUnitsSpecifier(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                         const(GUID)* PowerSettingGuid, 
                                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* Buffer, 
                                         uint* BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
uint PowerReadACDefaultIndex(HKEY RootPowerKey, const(GUID)* SchemePersonalityGuid, 
                             const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                             uint* AcDefaultIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
uint PowerReadDCDefaultIndex(HKEY RootPowerKey, const(GUID)* SchemePersonalityGuid, 
                             const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                             uint* DcDefaultIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReadIconResourceSpecifier(HKEY RootPowerKey, const(GUID)* SchemeGuid, 
                                           const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* Buffer, 
                                           uint* BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
uint PowerReadSettingAttributes(const(GUID)* SubGroupGuid, const(GUID)* PowerSettingGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerWriteFriendlyName(HKEY RootPowerKey, const(GUID)* SchemeGuid, 
                                   const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* Buffer, 
                                   uint BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerWriteDescription(HKEY RootPowerKey, const(GUID)* SchemeGuid, 
                                  const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* Buffer, 
                                  uint BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerWritePossibleValue(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                    const(GUID)* PowerSettingGuid, uint Type, uint PossibleSettingIndex, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* Buffer, 
                                    uint BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerWritePossibleFriendlyName(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                           const(GUID)* PowerSettingGuid, uint PossibleSettingIndex, 
                                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* Buffer, 
                                           uint BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerWritePossibleDescription(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                          const(GUID)* PowerSettingGuid, uint PossibleSettingIndex, 
                                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* Buffer, 
                                          uint BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerWriteValueMin(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                               const(GUID)* PowerSettingGuid, uint ValueMinimum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerWriteValueMax(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                               const(GUID)* PowerSettingGuid, uint ValueMaximum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerWriteValueIncrement(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                     const(GUID)* PowerSettingGuid, uint ValueIncrement);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerWriteValueUnitsSpecifier(HKEY RootPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                          const(GUID)* PowerSettingGuid, 
                                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* Buffer, 
                                          uint BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
uint PowerWriteACDefaultIndex(HKEY RootSystemPowerKey, const(GUID)* SchemePersonalityGuid, 
                              const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                              uint DefaultAcIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
uint PowerWriteDCDefaultIndex(HKEY RootSystemPowerKey, const(GUID)* SchemePersonalityGuid, 
                              const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                              uint DefaultDcIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerWriteIconResourceSpecifier(HKEY RootPowerKey, const(GUID)* SchemeGuid, 
                                            const(GUID)* SubGroupOfPowerSettingsGuid, const(GUID)* PowerSettingGuid, 
                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* Buffer, 
                                            uint BufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerWriteSettingAttributes(const(GUID)* SubGroupGuid, const(GUID)* PowerSettingGuid, uint Attributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerDuplicateScheme(HKEY RootPowerKey, const(GUID)* SourceSchemeGuid, GUID** DestinationSchemeGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerImportPowerScheme(HKEY RootPowerKey, const(PWSTR) ImportFileNamePath, 
                                   GUID** DestinationSchemeGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerDeleteScheme(HKEY RootPowerKey, const(GUID)* SchemeGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerRemovePowerSetting(const(GUID)* PowerSettingSubKeyGuid, const(GUID)* PowerSettingGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerCreateSetting(HKEY RootSystemPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                               const(GUID)* PowerSettingGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerCreatePossibleSetting(HKEY RootSystemPowerKey, const(GUID)* SubGroupOfPowerSettingsGuid, 
                                       const(GUID)* PowerSettingGuid, uint PossibleSettingIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerEnumerate(HKEY RootPowerKey, const(GUID)* SchemeGuid, const(GUID)* SubGroupOfPowerSettingsGuid, 
                           POWER_DATA_ACCESSOR AccessFlags, uint Index, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* Buffer, 
                           uint* BufferSize);

@DllImport("POWRPROF.dll")
uint PowerOpenUserPowerKey(HKEY* phUserPowerKey, uint Access, BOOL OpenExisting);

@DllImport("POWRPROF.dll")
uint PowerOpenSystemPowerKey(HKEY* phSystemPowerKey, uint Access, BOOL OpenExisting);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerCanRestoreIndividualDefaultPowerScheme(const(GUID)* SchemeGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerRestoreIndividualDefaultPowerScheme(const(GUID)* SchemeGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerRestoreDefaultPowerSchemes();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
uint PowerReplaceDefaultPowerSchemes();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
POWER_PLATFORM_ROLE PowerDeterminePlatformRole();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
BOOLEAN DevicePowerEnumDevices(uint QueryIndex, uint QueryInterpretationFlags, uint QueryFlags, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pReturnBuffer, 
                               uint* pBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
uint DevicePowerSetDeviceState(const(PWSTR) DeviceDescription, uint SetFlags, void* SetData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
BOOLEAN DevicePowerOpen(uint DebugMask);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("POWRPROF.dll")
BOOLEAN DevicePowerClose();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("POWRPROF.dll")
WIN32_ERROR PowerReportThermalEvent(THERMAL_EVENT* Event);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USER32.dll")
HPOWERNOTIFY RegisterPowerSettingNotification(HANDLE hRecipient, const(GUID)* PowerSettingGuid, 
                                              REGISTER_NOTIFICATION_FLAGS Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USER32.dll")
BOOL UnregisterPowerSettingNotification(HPOWERNOTIFY Handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
HPOWERNOTIFY RegisterSuspendResumeNotification(HANDLE hRecipient, REGISTER_NOTIFICATION_FLAGS Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("USER32.dll")
BOOL UnregisterSuspendResumeNotification(HPOWERNOTIFY Handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL RequestWakeupLatency(LATENCY_TIME latency);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL IsSystemResumeAutomatic();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
EXECUTION_STATE SetThreadExecutionState(EXECUTION_STATE esFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
HANDLE PowerCreateRequest(REASON_CONTEXT* Context);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
BOOL PowerSetRequest(HANDLE PowerRequest, POWER_REQUEST_TYPE RequestType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
BOOL PowerClearRequest(HANDLE PowerRequest, POWER_REQUEST_TYPE RequestType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetDevicePowerState(HANDLE hDevice, BOOL* pfOn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL SetSystemPowerState(BOOL fSuspend, BOOL fForce);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetSystemPowerStatus(SYSTEM_POWER_STATUS* lpSystemPowerStatus);


