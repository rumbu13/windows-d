// Written in the D programming language.

module windows.win32.system.hypervisor;

public import windows.core;
public import windows.win32.foundation : BOOL, HANDLE, HRESULT, LUID, PSTR, PWSTR;
public import windows.win32.networking.winsock : ADDRESS_FAMILY;
public import windows.win32.system.hostcomputesystem : HCS_SYSTEM;
public import windows.win32.system.power : DEVICE_POWER_STATE;

extern(Windows) @nogc nothrow:


// Enums


alias WHV_CAPABILITY_CODE = int;
enum : int
{
    WHvCapabilityCodeHypervisorPresent               = 0x00000000,
    WHvCapabilityCodeFeatures                        = 0x00000001,
    WHvCapabilityCodeExtendedVmExits                 = 0x00000002,
    WHvCapabilityCodeExceptionExitBitmap             = 0x00000003,
    WHvCapabilityCodeX64MsrExitBitmap                = 0x00000004,
    WHvCapabilityCodeGpaRangePopulateFlags           = 0x00000005,
    WHvCapabilityCodeSchedulerFeatures               = 0x00000006,
    WHvCapabilityCodeProcessorVendor                 = 0x00001000,
    WHvCapabilityCodeProcessorFeatures               = 0x00001001,
    WHvCapabilityCodeProcessorClFlushSize            = 0x00001002,
    WHvCapabilityCodeProcessorXsaveFeatures          = 0x00001003,
    WHvCapabilityCodeProcessorClockFrequency         = 0x00001004,
    WHvCapabilityCodeInterruptClockFrequency         = 0x00001005,
    WHvCapabilityCodeProcessorFeaturesBanks          = 0x00001006,
    WHvCapabilityCodeProcessorFrequencyCap           = 0x00001007,
    WHvCapabilityCodeSyntheticProcessorFeaturesBanks = 0x00001008,
    WHvCapabilityCodeProcessorPerfmonFeatures        = 0x00001009,
}

alias WHV_PROCESSOR_VENDOR = int;
enum : int
{
    WHvProcessorVendorAmd   = 0x00000000,
    WHvProcessorVendorIntel = 0x00000001,
    WHvProcessorVendorHygon = 0x00000002,
}

alias WHV_PARTITION_PROPERTY_CODE = int;
enum : int
{
    WHvPartitionPropertyCodeExtendedVmExits                 = 0x00000001,
    WHvPartitionPropertyCodeExceptionExitBitmap             = 0x00000002,
    WHvPartitionPropertyCodeSeparateSecurityDomain          = 0x00000003,
    WHvPartitionPropertyCodeNestedVirtualization            = 0x00000004,
    WHvPartitionPropertyCodeX64MsrExitBitmap                = 0x00000005,
    WHvPartitionPropertyCodePrimaryNumaNode                 = 0x00000006,
    WHvPartitionPropertyCodeCpuReserve                      = 0x00000007,
    WHvPartitionPropertyCodeCpuCap                          = 0x00000008,
    WHvPartitionPropertyCodeCpuWeight                       = 0x00000009,
    WHvPartitionPropertyCodeCpuGroupId                      = 0x0000000a,
    WHvPartitionPropertyCodeProcessorFrequencyCap           = 0x0000000b,
    WHvPartitionPropertyCodeAllowDeviceAssignment           = 0x0000000c,
    WHvPartitionPropertyCodeDisableSmt                      = 0x0000000d,
    WHvPartitionPropertyCodeProcessorFeatures               = 0x00001001,
    WHvPartitionPropertyCodeProcessorClFlushSize            = 0x00001002,
    WHvPartitionPropertyCodeCpuidExitList                   = 0x00001003,
    WHvPartitionPropertyCodeCpuidResultList                 = 0x00001004,
    WHvPartitionPropertyCodeLocalApicEmulationMode          = 0x00001005,
    WHvPartitionPropertyCodeProcessorXsaveFeatures          = 0x00001006,
    WHvPartitionPropertyCodeProcessorClockFrequency         = 0x00001007,
    WHvPartitionPropertyCodeInterruptClockFrequency         = 0x00001008,
    WHvPartitionPropertyCodeApicRemoteReadSupport           = 0x00001009,
    WHvPartitionPropertyCodeProcessorFeaturesBanks          = 0x0000100a,
    WHvPartitionPropertyCodeReferenceTime                   = 0x0000100b,
    WHvPartitionPropertyCodeSyntheticProcessorFeaturesBanks = 0x0000100c,
    WHvPartitionPropertyCodeCpuidResultList2                = 0x0000100d,
    WHvPartitionPropertyCodeProcessorPerfmonFeatures        = 0x0000100e,
    WHvPartitionPropertyCodeMsrActionList                   = 0x0000100f,
    WHvPartitionPropertyCodeUnimplementedMsrAction          = 0x00001010,
    WHvPartitionPropertyCodeProcessorCount                  = 0x00001fff,
}

alias WHV_MEMORY_ACCESS_TYPE = int;
enum : int
{
    WHvMemoryAccessRead    = 0x00000000,
    WHvMemoryAccessWrite   = 0x00000001,
    WHvMemoryAccessExecute = 0x00000002,
}

alias WHV_X64_CPUID_RESULT2_FLAGS = int;
enum : int
{
    WHvX64CpuidResult2FlagSubleafSpecific = 0x00000001,
    WHvX64CpuidResult2FlagVpSpecific      = 0x00000002,
}

alias WHV_MSR_ACTION = int;
enum : int
{
    WHvMsrActionArchitectureDefault = 0x00000000,
    WHvMsrActionIgnoreWriteReadZero = 0x00000001,
    WHvMsrActionExit                = 0x00000002,
}

alias WHV_EXCEPTION_TYPE = int;
enum : int
{
    WHvX64ExceptionTypeDivideErrorFault             = 0x00000000,
    WHvX64ExceptionTypeDebugTrapOrFault             = 0x00000001,
    WHvX64ExceptionTypeBreakpointTrap               = 0x00000003,
    WHvX64ExceptionTypeOverflowTrap                 = 0x00000004,
    WHvX64ExceptionTypeBoundRangeFault              = 0x00000005,
    WHvX64ExceptionTypeInvalidOpcodeFault           = 0x00000006,
    WHvX64ExceptionTypeDeviceNotAvailableFault      = 0x00000007,
    WHvX64ExceptionTypeDoubleFaultAbort             = 0x00000008,
    WHvX64ExceptionTypeInvalidTaskStateSegmentFault = 0x0000000a,
    WHvX64ExceptionTypeSegmentNotPresentFault       = 0x0000000b,
    WHvX64ExceptionTypeStackFault                   = 0x0000000c,
    WHvX64ExceptionTypeGeneralProtectionFault       = 0x0000000d,
    WHvX64ExceptionTypePageFault                    = 0x0000000e,
    WHvX64ExceptionTypeFloatingPointErrorFault      = 0x00000010,
    WHvX64ExceptionTypeAlignmentCheckFault          = 0x00000011,
    WHvX64ExceptionTypeMachineCheckAbort            = 0x00000012,
    WHvX64ExceptionTypeSimdFloatingPointFault       = 0x00000013,
}

alias WHV_X64_LOCAL_APIC_EMULATION_MODE = int;
enum : int
{
    WHvX64LocalApicEmulationModeNone   = 0x00000000,
    WHvX64LocalApicEmulationModeXApic  = 0x00000001,
    WHvX64LocalApicEmulationModeX2Apic = 0x00000002,
}

alias WHV_MAP_GPA_RANGE_FLAGS = int;
enum : int
{
    WHvMapGpaRangeFlagNone            = 0x00000000,
    WHvMapGpaRangeFlagRead            = 0x00000001,
    WHvMapGpaRangeFlagWrite           = 0x00000002,
    WHvMapGpaRangeFlagExecute         = 0x00000004,
    WHvMapGpaRangeFlagTrackDirtyPages = 0x00000008,
}

alias WHV_TRANSLATE_GVA_FLAGS = int;
enum : int
{
    WHvTranslateGvaFlagNone             = 0x00000000,
    WHvTranslateGvaFlagValidateRead     = 0x00000001,
    WHvTranslateGvaFlagValidateWrite    = 0x00000002,
    WHvTranslateGvaFlagValidateExecute  = 0x00000004,
    WHvTranslateGvaFlagPrivilegeExempt  = 0x00000008,
    WHvTranslateGvaFlagSetPageTableBits = 0x00000010,
    WHvTranslateGvaFlagEnforceSmap      = 0x00000100,
    WHvTranslateGvaFlagOverrideSmap     = 0x00000200,
}

alias WHV_TRANSLATE_GVA_RESULT_CODE = int;
enum : int
{
    WHvTranslateGvaResultSuccess                 = 0x00000000,
    WHvTranslateGvaResultPageNotPresent          = 0x00000001,
    WHvTranslateGvaResultPrivilegeViolation      = 0x00000002,
    WHvTranslateGvaResultInvalidPageTableFlags   = 0x00000003,
    WHvTranslateGvaResultGpaUnmapped             = 0x00000004,
    WHvTranslateGvaResultGpaNoReadAccess         = 0x00000005,
    WHvTranslateGvaResultGpaNoWriteAccess        = 0x00000006,
    WHvTranslateGvaResultGpaIllegalOverlayAccess = 0x00000007,
    WHvTranslateGvaResultIntercept               = 0x00000008,
}

alias WHV_CACHE_TYPE = int;
enum : int
{
    WHvCacheTypeUncached       = 0x00000000,
    WHvCacheTypeWriteCombining = 0x00000001,
    WHvCacheTypeWriteThrough   = 0x00000004,
    WHvCacheTypeWriteBack      = 0x00000006,
}

alias WHV_REGISTER_NAME = int;
enum : int
{
    WHvX64RegisterRax                         = 0x00000000,
    WHvX64RegisterRcx                         = 0x00000001,
    WHvX64RegisterRdx                         = 0x00000002,
    WHvX64RegisterRbx                         = 0x00000003,
    WHvX64RegisterRsp                         = 0x00000004,
    WHvX64RegisterRbp                         = 0x00000005,
    WHvX64RegisterRsi                         = 0x00000006,
    WHvX64RegisterRdi                         = 0x00000007,
    WHvX64RegisterR8                          = 0x00000008,
    WHvX64RegisterR9                          = 0x00000009,
    WHvX64RegisterR10                         = 0x0000000a,
    WHvX64RegisterR11                         = 0x0000000b,
    WHvX64RegisterR12                         = 0x0000000c,
    WHvX64RegisterR13                         = 0x0000000d,
    WHvX64RegisterR14                         = 0x0000000e,
    WHvX64RegisterR15                         = 0x0000000f,
    WHvX64RegisterRip                         = 0x00000010,
    WHvX64RegisterRflags                      = 0x00000011,
    WHvX64RegisterEs                          = 0x00000012,
    WHvX64RegisterCs                          = 0x00000013,
    WHvX64RegisterSs                          = 0x00000014,
    WHvX64RegisterDs                          = 0x00000015,
    WHvX64RegisterFs                          = 0x00000016,
    WHvX64RegisterGs                          = 0x00000017,
    WHvX64RegisterLdtr                        = 0x00000018,
    WHvX64RegisterTr                          = 0x00000019,
    WHvX64RegisterIdtr                        = 0x0000001a,
    WHvX64RegisterGdtr                        = 0x0000001b,
    WHvX64RegisterCr0                         = 0x0000001c,
    WHvX64RegisterCr2                         = 0x0000001d,
    WHvX64RegisterCr3                         = 0x0000001e,
    WHvX64RegisterCr4                         = 0x0000001f,
    WHvX64RegisterCr8                         = 0x00000020,
    WHvX64RegisterDr0                         = 0x00000021,
    WHvX64RegisterDr1                         = 0x00000022,
    WHvX64RegisterDr2                         = 0x00000023,
    WHvX64RegisterDr3                         = 0x00000024,
    WHvX64RegisterDr6                         = 0x00000025,
    WHvX64RegisterDr7                         = 0x00000026,
    WHvX64RegisterXCr0                        = 0x00000027,
    WHvX64RegisterVirtualCr0                  = 0x00000028,
    WHvX64RegisterVirtualCr3                  = 0x00000029,
    WHvX64RegisterVirtualCr4                  = 0x0000002a,
    WHvX64RegisterVirtualCr8                  = 0x0000002b,
    WHvX64RegisterXmm0                        = 0x00001000,
    WHvX64RegisterXmm1                        = 0x00001001,
    WHvX64RegisterXmm2                        = 0x00001002,
    WHvX64RegisterXmm3                        = 0x00001003,
    WHvX64RegisterXmm4                        = 0x00001004,
    WHvX64RegisterXmm5                        = 0x00001005,
    WHvX64RegisterXmm6                        = 0x00001006,
    WHvX64RegisterXmm7                        = 0x00001007,
    WHvX64RegisterXmm8                        = 0x00001008,
    WHvX64RegisterXmm9                        = 0x00001009,
    WHvX64RegisterXmm10                       = 0x0000100a,
    WHvX64RegisterXmm11                       = 0x0000100b,
    WHvX64RegisterXmm12                       = 0x0000100c,
    WHvX64RegisterXmm13                       = 0x0000100d,
    WHvX64RegisterXmm14                       = 0x0000100e,
    WHvX64RegisterXmm15                       = 0x0000100f,
    WHvX64RegisterFpMmx0                      = 0x00001010,
    WHvX64RegisterFpMmx1                      = 0x00001011,
    WHvX64RegisterFpMmx2                      = 0x00001012,
    WHvX64RegisterFpMmx3                      = 0x00001013,
    WHvX64RegisterFpMmx4                      = 0x00001014,
    WHvX64RegisterFpMmx5                      = 0x00001015,
    WHvX64RegisterFpMmx6                      = 0x00001016,
    WHvX64RegisterFpMmx7                      = 0x00001017,
    WHvX64RegisterFpControlStatus             = 0x00001018,
    WHvX64RegisterXmmControlStatus            = 0x00001019,
    WHvX64RegisterTsc                         = 0x00002000,
    WHvX64RegisterEfer                        = 0x00002001,
    WHvX64RegisterKernelGsBase                = 0x00002002,
    WHvX64RegisterApicBase                    = 0x00002003,
    WHvX64RegisterPat                         = 0x00002004,
    WHvX64RegisterSysenterCs                  = 0x00002005,
    WHvX64RegisterSysenterEip                 = 0x00002006,
    WHvX64RegisterSysenterEsp                 = 0x00002007,
    WHvX64RegisterStar                        = 0x00002008,
    WHvX64RegisterLstar                       = 0x00002009,
    WHvX64RegisterCstar                       = 0x0000200a,
    WHvX64RegisterSfmask                      = 0x0000200b,
    WHvX64RegisterInitialApicId               = 0x0000200c,
    WHvX64RegisterMsrMtrrCap                  = 0x0000200d,
    WHvX64RegisterMsrMtrrDefType              = 0x0000200e,
    WHvX64RegisterMsrMtrrPhysBase0            = 0x00002010,
    WHvX64RegisterMsrMtrrPhysBase1            = 0x00002011,
    WHvX64RegisterMsrMtrrPhysBase2            = 0x00002012,
    WHvX64RegisterMsrMtrrPhysBase3            = 0x00002013,
    WHvX64RegisterMsrMtrrPhysBase4            = 0x00002014,
    WHvX64RegisterMsrMtrrPhysBase5            = 0x00002015,
    WHvX64RegisterMsrMtrrPhysBase6            = 0x00002016,
    WHvX64RegisterMsrMtrrPhysBase7            = 0x00002017,
    WHvX64RegisterMsrMtrrPhysBase8            = 0x00002018,
    WHvX64RegisterMsrMtrrPhysBase9            = 0x00002019,
    WHvX64RegisterMsrMtrrPhysBaseA            = 0x0000201a,
    WHvX64RegisterMsrMtrrPhysBaseB            = 0x0000201b,
    WHvX64RegisterMsrMtrrPhysBaseC            = 0x0000201c,
    WHvX64RegisterMsrMtrrPhysBaseD            = 0x0000201d,
    WHvX64RegisterMsrMtrrPhysBaseE            = 0x0000201e,
    WHvX64RegisterMsrMtrrPhysBaseF            = 0x0000201f,
    WHvX64RegisterMsrMtrrPhysMask0            = 0x00002040,
    WHvX64RegisterMsrMtrrPhysMask1            = 0x00002041,
    WHvX64RegisterMsrMtrrPhysMask2            = 0x00002042,
    WHvX64RegisterMsrMtrrPhysMask3            = 0x00002043,
    WHvX64RegisterMsrMtrrPhysMask4            = 0x00002044,
    WHvX64RegisterMsrMtrrPhysMask5            = 0x00002045,
    WHvX64RegisterMsrMtrrPhysMask6            = 0x00002046,
    WHvX64RegisterMsrMtrrPhysMask7            = 0x00002047,
    WHvX64RegisterMsrMtrrPhysMask8            = 0x00002048,
    WHvX64RegisterMsrMtrrPhysMask9            = 0x00002049,
    WHvX64RegisterMsrMtrrPhysMaskA            = 0x0000204a,
    WHvX64RegisterMsrMtrrPhysMaskB            = 0x0000204b,
    WHvX64RegisterMsrMtrrPhysMaskC            = 0x0000204c,
    WHvX64RegisterMsrMtrrPhysMaskD            = 0x0000204d,
    WHvX64RegisterMsrMtrrPhysMaskE            = 0x0000204e,
    WHvX64RegisterMsrMtrrPhysMaskF            = 0x0000204f,
    WHvX64RegisterMsrMtrrFix64k00000          = 0x00002070,
    WHvX64RegisterMsrMtrrFix16k80000          = 0x00002071,
    WHvX64RegisterMsrMtrrFix16kA0000          = 0x00002072,
    WHvX64RegisterMsrMtrrFix4kC0000           = 0x00002073,
    WHvX64RegisterMsrMtrrFix4kC8000           = 0x00002074,
    WHvX64RegisterMsrMtrrFix4kD0000           = 0x00002075,
    WHvX64RegisterMsrMtrrFix4kD8000           = 0x00002076,
    WHvX64RegisterMsrMtrrFix4kE0000           = 0x00002077,
    WHvX64RegisterMsrMtrrFix4kE8000           = 0x00002078,
    WHvX64RegisterMsrMtrrFix4kF0000           = 0x00002079,
    WHvX64RegisterMsrMtrrFix4kF8000           = 0x0000207a,
    WHvX64RegisterTscAux                      = 0x0000207b,
    WHvX64RegisterBndcfgs                     = 0x0000207c,
    WHvX64RegisterMCount                      = 0x0000207e,
    WHvX64RegisterACount                      = 0x0000207f,
    WHvX64RegisterSpecCtrl                    = 0x00002084,
    WHvX64RegisterPredCmd                     = 0x00002085,
    WHvX64RegisterTscVirtualOffset            = 0x00002087,
    WHvX64RegisterTsxCtrl                     = 0x00002088,
    WHvX64RegisterXss                         = 0x0000208b,
    WHvX64RegisterUCet                        = 0x0000208c,
    WHvX64RegisterSCet                        = 0x0000208d,
    WHvX64RegisterSsp                         = 0x0000208e,
    WHvX64RegisterPl0Ssp                      = 0x0000208f,
    WHvX64RegisterPl1Ssp                      = 0x00002090,
    WHvX64RegisterPl2Ssp                      = 0x00002091,
    WHvX64RegisterPl3Ssp                      = 0x00002092,
    WHvX64RegisterInterruptSspTableAddr       = 0x00002093,
    WHvX64RegisterTscDeadline                 = 0x00002095,
    WHvX64RegisterTscAdjust                   = 0x00002096,
    WHvX64RegisterUmwaitControl               = 0x00002098,
    WHvX64RegisterXfd                         = 0x00002099,
    WHvX64RegisterXfdErr                      = 0x0000209a,
    WHvX64RegisterApicId                      = 0x00003002,
    WHvX64RegisterApicVersion                 = 0x00003003,
    WHvX64RegisterApicTpr                     = 0x00003008,
    WHvX64RegisterApicPpr                     = 0x0000300a,
    WHvX64RegisterApicEoi                     = 0x0000300b,
    WHvX64RegisterApicLdr                     = 0x0000300d,
    WHvX64RegisterApicSpurious                = 0x0000300f,
    WHvX64RegisterApicIsr0                    = 0x00003010,
    WHvX64RegisterApicIsr1                    = 0x00003011,
    WHvX64RegisterApicIsr2                    = 0x00003012,
    WHvX64RegisterApicIsr3                    = 0x00003013,
    WHvX64RegisterApicIsr4                    = 0x00003014,
    WHvX64RegisterApicIsr5                    = 0x00003015,
    WHvX64RegisterApicIsr6                    = 0x00003016,
    WHvX64RegisterApicIsr7                    = 0x00003017,
    WHvX64RegisterApicTmr0                    = 0x00003018,
    WHvX64RegisterApicTmr1                    = 0x00003019,
    WHvX64RegisterApicTmr2                    = 0x0000301a,
    WHvX64RegisterApicTmr3                    = 0x0000301b,
    WHvX64RegisterApicTmr4                    = 0x0000301c,
    WHvX64RegisterApicTmr5                    = 0x0000301d,
    WHvX64RegisterApicTmr6                    = 0x0000301e,
    WHvX64RegisterApicTmr7                    = 0x0000301f,
    WHvX64RegisterApicIrr0                    = 0x00003020,
    WHvX64RegisterApicIrr1                    = 0x00003021,
    WHvX64RegisterApicIrr2                    = 0x00003022,
    WHvX64RegisterApicIrr3                    = 0x00003023,
    WHvX64RegisterApicIrr4                    = 0x00003024,
    WHvX64RegisterApicIrr5                    = 0x00003025,
    WHvX64RegisterApicIrr6                    = 0x00003026,
    WHvX64RegisterApicIrr7                    = 0x00003027,
    WHvX64RegisterApicEse                     = 0x00003028,
    WHvX64RegisterApicIcr                     = 0x00003030,
    WHvX64RegisterApicLvtTimer                = 0x00003032,
    WHvX64RegisterApicLvtThermal              = 0x00003033,
    WHvX64RegisterApicLvtPerfmon              = 0x00003034,
    WHvX64RegisterApicLvtLint0                = 0x00003035,
    WHvX64RegisterApicLvtLint1                = 0x00003036,
    WHvX64RegisterApicLvtError                = 0x00003037,
    WHvX64RegisterApicInitCount               = 0x00003038,
    WHvX64RegisterApicCurrentCount            = 0x00003039,
    WHvX64RegisterApicDivide                  = 0x0000303e,
    WHvX64RegisterApicSelfIpi                 = 0x0000303f,
    WHvRegisterSint0                          = 0x00004000,
    WHvRegisterSint1                          = 0x00004001,
    WHvRegisterSint2                          = 0x00004002,
    WHvRegisterSint3                          = 0x00004003,
    WHvRegisterSint4                          = 0x00004004,
    WHvRegisterSint5                          = 0x00004005,
    WHvRegisterSint6                          = 0x00004006,
    WHvRegisterSint7                          = 0x00004007,
    WHvRegisterSint8                          = 0x00004008,
    WHvRegisterSint9                          = 0x00004009,
    WHvRegisterSint10                         = 0x0000400a,
    WHvRegisterSint11                         = 0x0000400b,
    WHvRegisterSint12                         = 0x0000400c,
    WHvRegisterSint13                         = 0x0000400d,
    WHvRegisterSint14                         = 0x0000400e,
    WHvRegisterSint15                         = 0x0000400f,
    WHvRegisterScontrol                       = 0x00004010,
    WHvRegisterSversion                       = 0x00004011,
    WHvRegisterSiefp                          = 0x00004012,
    WHvRegisterSimp                           = 0x00004013,
    WHvRegisterEom                            = 0x00004014,
    WHvRegisterVpRuntime                      = 0x00005000,
    WHvX64RegisterHypercall                   = 0x00005001,
    WHvRegisterGuestOsId                      = 0x00005002,
    WHvRegisterVpAssistPage                   = 0x00005013,
    WHvRegisterReferenceTsc                   = 0x00005017,
    WHvRegisterReferenceTscSequence           = 0x0000501a,
    WHvRegisterPendingInterruption            = 0x80000000,
    WHvRegisterInterruptState                 = 0x80000001,
    WHvRegisterPendingEvent                   = 0x80000002,
    WHvX64RegisterDeliverabilityNotifications = 0x80000004,
    WHvRegisterInternalActivityState          = 0x80000005,
    WHvX64RegisterPendingDebugException       = 0x80000006,
}

alias WHV_X64_PENDING_EVENT_TYPE = int;
enum : int
{
    WHvX64PendingEventException = 0x00000000,
    WHvX64PendingEventExtInt    = 0x00000005,
}

alias WHV_RUN_VP_EXIT_REASON = int;
enum : int
{
    WHvRunVpExitReasonNone                   = 0x00000000,
    WHvRunVpExitReasonMemoryAccess           = 0x00000001,
    WHvRunVpExitReasonX64IoPortAccess        = 0x00000002,
    WHvRunVpExitReasonUnrecoverableException = 0x00000004,
    WHvRunVpExitReasonInvalidVpRegisterValue = 0x00000005,
    WHvRunVpExitReasonUnsupportedFeature     = 0x00000006,
    WHvRunVpExitReasonX64InterruptWindow     = 0x00000007,
    WHvRunVpExitReasonX64Halt                = 0x00000008,
    WHvRunVpExitReasonX64ApicEoi             = 0x00000009,
    WHvRunVpExitReasonSynicSintDeliverable   = 0x0000000a,
    WHvRunVpExitReasonX64MsrAccess           = 0x00001000,
    WHvRunVpExitReasonX64Cpuid               = 0x00001001,
    WHvRunVpExitReasonException              = 0x00001002,
    WHvRunVpExitReasonX64Rdtsc               = 0x00001003,
    WHvRunVpExitReasonX64ApicSmiTrap         = 0x00001004,
    WHvRunVpExitReasonHypercall              = 0x00001005,
    WHvRunVpExitReasonX64ApicInitSipiTrap    = 0x00001006,
    WHvRunVpExitReasonX64ApicWriteTrap       = 0x00001007,
    WHvRunVpExitReasonCanceled               = 0x00002001,
}

alias WHV_X64_UNSUPPORTED_FEATURE_CODE = int;
enum : int
{
    WHvUnsupportedFeatureIntercept     = 0x00000001,
    WHvUnsupportedFeatureTaskSwitchTss = 0x00000002,
}

alias WHV_RUN_VP_CANCEL_REASON = int;
enum : int
{
    WHvRunVpCancelReasonUser = 0x00000000,
}

alias WHV_X64_PENDING_INTERRUPTION_TYPE = int;
enum : int
{
    WHvX64PendingInterrupt = 0x00000000,
    WHvX64PendingNmi       = 0x00000002,
    WHvX64PendingException = 0x00000003,
}

alias WHV_X64_APIC_WRITE_TYPE = int;
enum : int
{
    WHvX64ApicWriteTypeLdr   = 0x000000d0,
    WHvX64ApicWriteTypeDfr   = 0x000000e0,
    WHvX64ApicWriteTypeSvr   = 0x000000f0,
    WHvX64ApicWriteTypeLint0 = 0x00000350,
    WHvX64ApicWriteTypeLint1 = 0x00000360,
}

alias WHV_INTERRUPT_TYPE = int;
enum : int
{
    WHvX64InterruptTypeFixed          = 0x00000000,
    WHvX64InterruptTypeLowestPriority = 0x00000001,
    WHvX64InterruptTypeNmi            = 0x00000004,
    WHvX64InterruptTypeInit           = 0x00000005,
    WHvX64InterruptTypeSipi           = 0x00000006,
    WHvX64InterruptTypeLocalInt1      = 0x00000009,
}

alias WHV_INTERRUPT_DESTINATION_MODE = int;
enum : int
{
    WHvX64InterruptDestinationModePhysical = 0x00000000,
    WHvX64InterruptDestinationModeLogical  = 0x00000001,
}

alias WHV_INTERRUPT_TRIGGER_MODE = int;
enum : int
{
    WHvX64InterruptTriggerModeEdge  = 0x00000000,
    WHvX64InterruptTriggerModeLevel = 0x00000001,
}

alias WHV_PARTITION_COUNTER_SET = int;
enum : int
{
    WHvPartitionCounterSetMemory = 0x00000000,
}

alias WHV_PROCESSOR_COUNTER_SET = int;
enum : int
{
    WHvProcessorCounterSetRuntime           = 0x00000000,
    WHvProcessorCounterSetIntercepts        = 0x00000001,
    WHvProcessorCounterSetEvents            = 0x00000002,
    WHvProcessorCounterSetApic              = 0x00000003,
    WHvProcessorCounterSetSyntheticFeatures = 0x00000004,
}

alias WHV_ADVISE_GPA_RANGE_CODE = int;
enum : int
{
    WHvAdviseGpaRangeCodePopulate = 0x00000000,
    WHvAdviseGpaRangeCodePin      = 0x00000001,
    WHvAdviseGpaRangeCodeUnpin    = 0x00000002,
}

alias WHV_VIRTUAL_PROCESSOR_STATE_TYPE = int;
enum : int
{
    WHvVirtualProcessorStateTypeSynicMessagePage          = 0x00000000,
    WHvVirtualProcessorStateTypeSynicEventFlagPage        = 0x00000001,
    WHvVirtualProcessorStateTypeSynicTimerState           = 0x00000002,
    WHvVirtualProcessorStateTypeInterruptControllerState2 = 0x00001000,
    WHvVirtualProcessorStateTypeXsaveState                = 0x00001001,
}

alias WHV_ALLOCATE_VPCI_RESOURCE_FLAGS = int;
enum : int
{
    WHvAllocateVpciResourceFlagNone           = 0x00000000,
    WHvAllocateVpciResourceFlagAllowDirectP2P = 0x00000001,
}

alias WHV_VPCI_DEVICE_NOTIFICATION_TYPE = int;
enum : int
{
    WHvVpciDeviceNotificationUndefined       = 0x00000000,
    WHvVpciDeviceNotificationMmioRemapping   = 0x00000001,
    WHvVpciDeviceNotificationSurpriseRemoval = 0x00000002,
}

alias WHV_CREATE_VPCI_DEVICE_FLAGS = int;
enum : int
{
    WHvCreateVpciDeviceFlagNone                 = 0x00000000,
    WHvCreateVpciDeviceFlagPhysicallyBacked     = 0x00000001,
    WHvCreateVpciDeviceFlagUseLogicalInterrupts = 0x00000002,
}

alias WHV_VPCI_DEVICE_PROPERTY_CODE = int;
enum : int
{
    WHvVpciDevicePropertyCodeUndefined   = 0x00000000,
    WHvVpciDevicePropertyCodeHardwareIDs = 0x00000001,
    WHvVpciDevicePropertyCodeProbedBARs  = 0x00000002,
}

alias WHV_VPCI_MMIO_RANGE_FLAGS = int;
enum : int
{
    WHvVpciMmioRangeFlagReadAccess  = 0x00000001,
    WHvVpciMmioRangeFlagWriteAccess = 0x00000002,
}

alias WHV_VPCI_DEVICE_REGISTER_SPACE = int;
enum : int
{
    WHvVpciConfigSpace = 0xffffffff,
    WHvVpciBar0        = 0x00000000,
    WHvVpciBar1        = 0x00000001,
    WHvVpciBar2        = 0x00000002,
    WHvVpciBar3        = 0x00000003,
    WHvVpciBar4        = 0x00000004,
    WHvVpciBar5        = 0x00000005,
}

alias WHV_VPCI_INTERRUPT_TARGET_FLAGS = int;
enum : int
{
    WHvVpciInterruptTargetFlagNone      = 0x00000000,
    WHvVpciInterruptTargetFlagMulticast = 0x00000001,
}

alias WHV_TRIGGER_TYPE = int;
enum : int
{
    WHvTriggerTypeInterrupt       = 0x00000000,
    WHvTriggerTypeSynicEvent      = 0x00000001,
    WHvTriggerTypeDeviceInterrupt = 0x00000002,
}

alias WHV_VIRTUAL_PROCESSOR_PROPERTY_CODE = int;
enum : int
{
    WHvVirtualProcessorPropertyCodeNumaNode = 0x00000000,
}

alias WHV_NOTIFICATION_PORT_TYPE = int;
enum : int
{
    WHvNotificationPortTypeEvent    = 0x00000002,
    WHvNotificationPortTypeDoorbell = 0x00000004,
}

alias WHV_NOTIFICATION_PORT_PROPERTY_CODE = int;
enum : int
{
    WHvNotificationPortPropertyPreferredTargetVp       = 0x00000001,
    WHvNotificationPortPropertyPreferredTargetDuration = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcs/Reference/hdv/HdvDeviceType
alias HDV_DEVICE_TYPE = int;
enum : int
{
    HdvDeviceTypeUndefined = 0x00000000,
    HdvDeviceTypePCI       = 0x00000001,
}

alias HDV_DEVICE_HOST_FLAGS = int;
enum : int
{
    HdvDeviceHostFlagNone                  = 0x00000000,
    HdvDeviceHostFlagInitializeComSecurity = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcs/Reference/hdv/HdvPciBarSelector
alias HDV_PCI_BAR_SELECTOR = int;
enum : int
{
    HDV_PCI_BAR0 = 0x00000000,
    HDV_PCI_BAR1 = 0x00000001,
    HDV_PCI_BAR2 = 0x00000002,
    HDV_PCI_BAR3 = 0x00000003,
    HDV_PCI_BAR4 = 0x00000004,
    HDV_PCI_BAR5 = 0x00000005,
}

alias HDV_DOORBELL_FLAGS = int;
enum : int
{
    HDV_DOORBELL_FLAG_TRIGGER_SIZE_ANY   = 0x00000000,
    HDV_DOORBELL_FLAG_TRIGGER_SIZE_BYTE  = 0x00000001,
    HDV_DOORBELL_FLAG_TRIGGER_SIZE_WORD  = 0x00000002,
    HDV_DOORBELL_FLAG_TRIGGER_SIZE_DWORD = 0x00000003,
    HDV_DOORBELL_FLAG_TRIGGER_SIZE_QWORD = 0x00000004,
    HDV_DOORBELL_FLAG_TRIGGER_ANY_VALUE  = 0x80000000,
}

alias HDV_MMIO_MAPPING_FLAGS = int;
enum : int
{
    HdvMmioMappingFlagNone       = 0x00000000,
    HdvMmioMappingFlagWriteable  = 0x00000001,
    HdvMmioMappingFlagExecutable = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcs/Reference/hdv/HdvPciInterfaceVersion
alias HDV_PCI_INTERFACE_VERSION = int;
enum : int
{
    HdvPciDeviceInterfaceVersionInvalid = 0x00000000,
    HdvPciDeviceInterfaceVersion1       = 0x00000001,
}

alias PAGING_MODE = int;
enum : int
{
    Paging_Invalid  = 0x00000000,
    Paging_NonPaged = 0x00000001,
    Paging_32Bit    = 0x00000002,
    Paging_Pae      = 0x00000003,
    Paging_Long     = 0x00000004,
    Paging_Armv8    = 0x00000005,
}

alias VIRTUAL_PROCESSOR_ARCH = int;
enum : int
{
    Arch_Unknown = 0x00000000,
    Arch_x86     = 0x00000001,
    Arch_x64     = 0x00000002,
    Arch_Armv8   = 0x00000003,
}

alias VIRTUAL_PROCESSOR_VENDOR = int;
enum : int
{
    ProcessorVendor_Unknown = 0x00000000,
    ProcessorVendor_Amd     = 0x00000001,
    ProcessorVendor_Intel   = 0x00000002,
    ProcessorVendor_Hygon   = 0x00000003,
    ProcessorVendor_Arm     = 0x00000004,
}

alias GUEST_OS_VENDOR = int;
enum : int
{
    GuestOsVendorUndefined = 0x00000000,
    GuestOsVendorMicrosoft = 0x00000001,
    GuestOsVendorHPE       = 0x00000002,
    GuestOsVendorLANCOM    = 0x00000200,
}

alias GUEST_OS_MICROSOFT_IDS = int;
enum : int
{
    GuestOsMicrosoftUndefined = 0x00000000,
    GuestOsMicrosoftMSDOS     = 0x00000001,
    GuestOsMicrosoftWindows3x = 0x00000002,
    GuestOsMicrosoftWindows9x = 0x00000003,
    GuestOsMicrosoftWindowsNT = 0x00000004,
    GuestOsMicrosoftWindowsCE = 0x00000005,
}

alias GUEST_OS_OPENSOURCE_IDS = int;
enum : int
{
    GuestOsOpenSourceUndefined = 0x00000000,
    GuestOsOpenSourceLinux     = 0x00000001,
    GuestOsOpenSourceFreeBSD   = 0x00000002,
    GuestOsOpenSourceXen       = 0x00000003,
    GuestOsOpenSourceIllumos   = 0x00000004,
}

alias REGISTER_ID = int;
enum : int
{
    X64_RegisterRax              = 0x00000000,
    X64_RegisterRcx              = 0x00000001,
    X64_RegisterRdx              = 0x00000002,
    X64_RegisterRbx              = 0x00000003,
    X64_RegisterRsp              = 0x00000004,
    X64_RegisterRbp              = 0x00000005,
    X64_RegisterRsi              = 0x00000006,
    X64_RegisterRdi              = 0x00000007,
    X64_RegisterR8               = 0x00000008,
    X64_RegisterR9               = 0x00000009,
    X64_RegisterR10              = 0x0000000a,
    X64_RegisterR11              = 0x0000000b,
    X64_RegisterR12              = 0x0000000c,
    X64_RegisterR13              = 0x0000000d,
    X64_RegisterR14              = 0x0000000e,
    X64_RegisterR15              = 0x0000000f,
    X64_RegisterRip              = 0x00000010,
    X64_RegisterRFlags           = 0x00000011,
    X64_RegisterXmm0             = 0x00000012,
    X64_RegisterXmm1             = 0x00000013,
    X64_RegisterXmm2             = 0x00000014,
    X64_RegisterXmm3             = 0x00000015,
    X64_RegisterXmm4             = 0x00000016,
    X64_RegisterXmm5             = 0x00000017,
    X64_RegisterXmm6             = 0x00000018,
    X64_RegisterXmm7             = 0x00000019,
    X64_RegisterXmm8             = 0x0000001a,
    X64_RegisterXmm9             = 0x0000001b,
    X64_RegisterXmm10            = 0x0000001c,
    X64_RegisterXmm11            = 0x0000001d,
    X64_RegisterXmm12            = 0x0000001e,
    X64_RegisterXmm13            = 0x0000001f,
    X64_RegisterXmm14            = 0x00000020,
    X64_RegisterXmm15            = 0x00000021,
    X64_RegisterFpMmx0           = 0x00000022,
    X64_RegisterFpMmx1           = 0x00000023,
    X64_RegisterFpMmx2           = 0x00000024,
    X64_RegisterFpMmx3           = 0x00000025,
    X64_RegisterFpMmx4           = 0x00000026,
    X64_RegisterFpMmx5           = 0x00000027,
    X64_RegisterFpMmx6           = 0x00000028,
    X64_RegisterFpMmx7           = 0x00000029,
    X64_RegisterFpControlStatus  = 0x0000002a,
    X64_RegisterXmmControlStatus = 0x0000002b,
    X64_RegisterCr0              = 0x0000002c,
    X64_RegisterCr2              = 0x0000002d,
    X64_RegisterCr3              = 0x0000002e,
    X64_RegisterCr4              = 0x0000002f,
    X64_RegisterCr8              = 0x00000030,
    X64_RegisterEfer             = 0x00000031,
    X64_RegisterDr0              = 0x00000032,
    X64_RegisterDr1              = 0x00000033,
    X64_RegisterDr2              = 0x00000034,
    X64_RegisterDr3              = 0x00000035,
    X64_RegisterDr6              = 0x00000036,
    X64_RegisterDr7              = 0x00000037,
    X64_RegisterEs               = 0x00000038,
    X64_RegisterCs               = 0x00000039,
    X64_RegisterSs               = 0x0000003a,
    X64_RegisterDs               = 0x0000003b,
    X64_RegisterFs               = 0x0000003c,
    X64_RegisterGs               = 0x0000003d,
    X64_RegisterLdtr             = 0x0000003e,
    X64_RegisterTr               = 0x0000003f,
    X64_RegisterIdtr             = 0x00000040,
    X64_RegisterGdtr             = 0x00000041,
    X64_RegisterMax              = 0x00000042,
    ARM64_RegisterX0             = 0x00000043,
    ARM64_RegisterX1             = 0x00000044,
    ARM64_RegisterX2             = 0x00000045,
    ARM64_RegisterX3             = 0x00000046,
    ARM64_RegisterX4             = 0x00000047,
    ARM64_RegisterX5             = 0x00000048,
    ARM64_RegisterX6             = 0x00000049,
    ARM64_RegisterX7             = 0x0000004a,
    ARM64_RegisterX8             = 0x0000004b,
    ARM64_RegisterX9             = 0x0000004c,
    ARM64_RegisterX10            = 0x0000004d,
    ARM64_RegisterX11            = 0x0000004e,
    ARM64_RegisterX12            = 0x0000004f,
    ARM64_RegisterX13            = 0x00000050,
    ARM64_RegisterX14            = 0x00000051,
    ARM64_RegisterX15            = 0x00000052,
    ARM64_RegisterX16            = 0x00000053,
    ARM64_RegisterX17            = 0x00000054,
    ARM64_RegisterX18            = 0x00000055,
    ARM64_RegisterX19            = 0x00000056,
    ARM64_RegisterX20            = 0x00000057,
    ARM64_RegisterX21            = 0x00000058,
    ARM64_RegisterX22            = 0x00000059,
    ARM64_RegisterX23            = 0x0000005a,
    ARM64_RegisterX24            = 0x0000005b,
    ARM64_RegisterX25            = 0x0000005c,
    ARM64_RegisterX26            = 0x0000005d,
    ARM64_RegisterX27            = 0x0000005e,
    ARM64_RegisterX28            = 0x0000005f,
    ARM64_RegisterXFp            = 0x00000060,
    ARM64_RegisterXLr            = 0x00000061,
    ARM64_RegisterPc             = 0x00000062,
    ARM64_RegisterSpEl0          = 0x00000063,
    ARM64_RegisterSpEl1          = 0x00000064,
    ARM64_RegisterCpsr           = 0x00000065,
    ARM64_RegisterQ0             = 0x00000066,
    ARM64_RegisterQ1             = 0x00000067,
    ARM64_RegisterQ2             = 0x00000068,
    ARM64_RegisterQ3             = 0x00000069,
    ARM64_RegisterQ4             = 0x0000006a,
    ARM64_RegisterQ5             = 0x0000006b,
    ARM64_RegisterQ6             = 0x0000006c,
    ARM64_RegisterQ7             = 0x0000006d,
    ARM64_RegisterQ8             = 0x0000006e,
    ARM64_RegisterQ9             = 0x0000006f,
    ARM64_RegisterQ10            = 0x00000070,
    ARM64_RegisterQ11            = 0x00000071,
    ARM64_RegisterQ12            = 0x00000072,
    ARM64_RegisterQ13            = 0x00000073,
    ARM64_RegisterQ14            = 0x00000074,
    ARM64_RegisterQ15            = 0x00000075,
    ARM64_RegisterQ16            = 0x00000076,
    ARM64_RegisterQ17            = 0x00000077,
    ARM64_RegisterQ18            = 0x00000078,
    ARM64_RegisterQ19            = 0x00000079,
    ARM64_RegisterQ20            = 0x0000007a,
    ARM64_RegisterQ21            = 0x0000007b,
    ARM64_RegisterQ22            = 0x0000007c,
    ARM64_RegisterQ23            = 0x0000007d,
    ARM64_RegisterQ24            = 0x0000007e,
    ARM64_RegisterQ25            = 0x0000007f,
    ARM64_RegisterQ26            = 0x00000080,
    ARM64_RegisterQ27            = 0x00000081,
    ARM64_RegisterQ28            = 0x00000082,
    ARM64_RegisterQ29            = 0x00000083,
    ARM64_RegisterQ30            = 0x00000084,
    ARM64_RegisterQ31            = 0x00000085,
    ARM64_RegisterFpStatus       = 0x00000086,
    ARM64_RegisterFpControl      = 0x00000087,
    ARM64_RegisterEsrEl1         = 0x00000088,
    ARM64_RegisterSpsrEl1        = 0x00000089,
    ARM64_RegisterFarEl1         = 0x0000008a,
    ARM64_RegisterParEl1         = 0x0000008b,
    ARM64_RegisterElrEl1         = 0x0000008c,
    ARM64_RegisterTtbr0El1       = 0x0000008d,
    ARM64_RegisterTtbr1El1       = 0x0000008e,
    ARM64_RegisterVbarEl1        = 0x0000008f,
    ARM64_RegisterSctlrEl1       = 0x00000090,
    ARM64_RegisterActlrEl1       = 0x00000091,
    ARM64_RegisterTcrEl1         = 0x00000092,
    ARM64_RegisterMairEl1        = 0x00000093,
    ARM64_RegisterAmairEl1       = 0x00000094,
    ARM64_RegisterTpidrEl0       = 0x00000095,
    ARM64_RegisterTpidrroEl0     = 0x00000096,
    ARM64_RegisterTpidrEl1       = 0x00000097,
    ARM64_RegisterContextIdrEl1  = 0x00000098,
    ARM64_RegisterCpacrEl1       = 0x00000099,
    ARM64_RegisterCsselrEl1      = 0x0000009a,
    ARM64_RegisterCntkctlEl1     = 0x0000009b,
    ARM64_RegisterCntvCvalEl0    = 0x0000009c,
    ARM64_RegisterCntvCtlEl0     = 0x0000009d,
    ARM64_RegisterMax            = 0x0000009e,
}

// Constants


enum : uint
{
    HVSOCKET_CONNECT_TIMEOUT     = 0x00000001U,
    HVSOCKET_CONNECT_TIMEOUT_MAX = 0x000493e0U,
    HVSOCKET_CONNECTED_SUSPEND   = 0x00000004U,
}

enum uint HVSOCKET_HIGH_VTL = 0x00000008U;
enum uint HV_PROTOCOL_RAW = 0x00000001U;
enum uint HVSOCKET_ADDRESS_FLAG_PASSTHRU = 0x00000001U;
enum uint WHV_PROCESSOR_FEATURES_BANKS_COUNT = 0x00000002U;
enum uint WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS_COUNT = 0x00000001U;
enum uint WHV_READ_WRITE_GPA_RANGE_MAX_SIZE = 0x00000010U;
enum uint WHV_HYPERCALL_CONTEXT_MAX_XMM_REGISTERS = 0x00000006U;
enum uint WHV_MAX_DEVICE_ID_SIZE_IN_CHARS = 0x000000c8U;
enum uint WHV_VPCI_TYPE0_BAR_COUNT = 0x00000006U;
enum uint WHV_ANY_VP = 0xffffffffU;
enum uint WHV_SYNIC_MESSAGE_SIZE = 0x00000100U;
enum const(wchar)* VM_GENCOUNTER_SYMBOLIC_LINK_NAME = "\\VmGenerationCounter";
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmgenerationcounter/ni-vmgenerationcounter-ioctl_vmgencounter_read
enum uint IOCTL_VMGENCOUNTER_READ = 0x0032c004U;
enum uint HDV_PCI_BAR_COUNT = 0x00000006U;

enum : GUID
{
    HV_GUID_ZERO           = GUID("00000000-0000-0000-0000-000000000000"),
    HV_GUID_BROADCAST      = GUID("ffffffff-ffff-ffff-ffff-ffffffffffff"),
    HV_GUID_CHILDREN       = GUID("90db8b89-0d35-4f79-8ce9-49ea0ac8b7cd"),
    HV_GUID_LOOPBACK       = GUID("e0e16197-dd56-4a10-9195-5ee7a155a838"),
    HV_GUID_PARENT         = GUID("a42e7cda-d03f-480c-9cc2-a4de20abb878"),
    HV_GUID_SILOHOST       = GUID("36bd0c5c-7276-4223-88ba-7d03b654c568"),
    HV_GUID_VSOCK_TEMPLATE = GUID("00000000-facb-11e6-bd58-64006a7986d3"),
}

enum GUID GUID_DEVINTERFACE_VM_GENCOUNTER = GUID("3ff2c92b-6598-4e60-8e1c-0ccf4927e319");

// Callbacks

alias WHV_EMULATOR_IO_PORT_CALLBACK = HRESULT function(void* Context, WHV_EMULATOR_IO_ACCESS_INFO* IoAccess);
alias WHV_EMULATOR_MEMORY_CALLBACK = HRESULT function(void* Context, WHV_EMULATOR_MEMORY_ACCESS_INFO* MemoryAccess);
alias WHV_EMULATOR_GET_VIRTUAL_PROCESSOR_REGISTERS_CALLBACK = HRESULT function(void* Context, 
                                                                               const(WHV_REGISTER_NAME)* RegisterNames, 
                                                                               uint RegisterCount, 
                                                                               WHV_REGISTER_VALUE* RegisterValues);
alias WHV_EMULATOR_SET_VIRTUAL_PROCESSOR_REGISTERS_CALLBACK = HRESULT function(void* Context, 
                                                                               const(WHV_REGISTER_NAME)* RegisterNames, 
                                                                               uint RegisterCount, 
                                                                               const(WHV_REGISTER_VALUE)* RegisterValues);
alias WHV_EMULATOR_TRANSLATE_GVA_PAGE_CALLBACK = HRESULT function(void* Context, ulong Gva, 
                                                                  WHV_TRANSLATE_GVA_FLAGS TranslateFlags, 
                                                                  WHV_TRANSLATE_GVA_RESULT_CODE* TranslationResult, 
                                                                  ulong* Gpa);
alias HDV_PCI_DEVICE_INITIALIZE = HRESULT function(void* deviceContext);
alias HDV_PCI_DEVICE_TEARDOWN = void function(void* deviceContext);
alias HDV_PCI_DEVICE_SET_CONFIGURATION = HRESULT function(void* deviceContext, uint configurationValueCount, 
                                                          const(PWSTR)* configurationValues);
alias HDV_PCI_DEVICE_GET_DETAILS = HRESULT function(void* deviceContext, HDV_PCI_PNP_ID* pnpId, 
                                                    uint probedBarsCount, uint* probedBars);
alias HDV_PCI_DEVICE_START = HRESULT function(void* deviceContext);
alias HDV_PCI_DEVICE_STOP = void function(void* deviceContext);
alias HDV_PCI_READ_CONFIG_SPACE = HRESULT function(void* deviceContext, uint offset, uint* value);
alias HDV_PCI_WRITE_CONFIG_SPACE = HRESULT function(void* deviceContext, uint offset, uint value);
alias HDV_PCI_READ_INTERCEPTED_MEMORY = HRESULT function(void* deviceContext, HDV_PCI_BAR_SELECTOR barIndex, 
                                                         ulong offset, ulong length, ubyte* value);
alias HDV_PCI_WRITE_INTERCEPTED_MEMORY = HRESULT function(void* deviceContext, HDV_PCI_BAR_SELECTOR barIndex, 
                                                          ulong offset, ulong length, const(ubyte)* value);
alias GUEST_SYMBOLS_PROVIDER_DEBUG_INFO_CALLBACK = void function(const(PSTR) InfoMessage);
alias FOUND_IMAGE_CALLBACK = BOOL function(void* Context, DOS_IMAGE_INFO* ImageInfo);

// Structs


@RAIIFree!WHvDeletePartition
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct WHV_PARTITION_HANDLE
{
    ptrdiff_t Value;
}

union WHV_CAPABILITY_FEATURES
{
    struct
    {
        // Native bit field: PartialUnmap: [0], LocalApicEmulation: [1], Xsave: [2], DirtyPageTracking: [3], SpeculationControl: [4], ApicRemoteRead: [5], IdleSuspend: [6], VirtualPciDeviceSupport: [7], IommuSupport: [8], VpHotAddRemove: [9], Reserved: [10-63]
        ulong _bitfield0;
    }
    ulong AsUINT64;
}

union WHV_EXTENDED_VM_EXITS
{
    struct
    {
        // Native bit field: X64CpuidExit: [0], X64MsrExit: [1], ExceptionExit: [2], X64RdtscExit: [3], X64ApicSmiExitTrap: [4], HypercallExit: [5], X64ApicInitSipiExitTrap: [6], X64ApicWriteLint0ExitTrap: [7], X64ApicWriteLint1ExitTrap: [8], X64ApicWriteSvrExitTrap: [9], UnknownSynicConnection: [10], RetargetUnknownVpciDevice: [11], X64ApicWriteLdrExitTrap: [12], X64ApicWriteDfrExitTrap: [13], GpaAccessFaultExit: [14], Reserved: [15-63]
        ulong _bitfield0;
    }
    ulong AsUINT64;
}

union WHV_PROCESSOR_FEATURES
{
    struct
    {
        // Native bit field: Sse3Support: [0], LahfSahfSupport: [1], Ssse3Support: [2], Sse4_1Support: [3], Sse4_2Support: [4], Sse4aSupport: [5], XopSupport: [6], PopCntSupport: [7], Cmpxchg16bSupport: [8], Altmovcr8Support: [9], LzcntSupport: [10], MisAlignSseSupport: [11], MmxExtSupport: [12], Amd3DNowSupport: [13], ExtendedAmd3DNowSupport: [14], Page1GbSupport: [15], AesSupport: [16], PclmulqdqSupport: [17], PcidSupport: [18], Fma4Support: [19], F16CSupport: [20], RdRandSupport: [21], RdWrFsGsSupport: [22], SmepSupport: [23], EnhancedFastStringSupport: [24], Bmi1Support: [25], Bmi2Support: [26], Reserved1: [27-28], MovbeSupport: [29], Npiep1Support: [30], DepX87FPUSaveSupport: [31], RdSeedSupport: [32], AdxSupport: [33], IntelPrefetchSupport: [34], SmapSupport: [35], HleSupport: [36], RtmSupport: [37], RdtscpSupport: [38], ClflushoptSupport: [39], ClwbSupport: [40], ShaSupport: [41], X87PointersSavedSupport: [42], InvpcidSupport: [43], IbrsSupport: [44], StibpSupport: [45], IbpbSupport: [46], Reserved2: [47], SsbdSupport: [48], FastShortRepMovSupport: [49], Reserved3: [50], RdclNo: [51], IbrsAllSupport: [52], Reserved4: [53], SsbNo: [54], RsbANo: [55], Reserved5: [56], RdPidSupport: [57], UmipSupport: [58], MdsNoSupport: [59], MdClearSupport: [60], TaaNoSupport: [61], TsxCtrlSupport: [62], Reserved6: [63]
        ulong _bitfield0;
    }
    ulong AsUINT64;
}

union WHV_PROCESSOR_FEATURES1
{
    struct
    {
        // Native bit field: ACountMCountSupport: [0], TscInvariantSupport: [1], ClZeroSupport: [2], RdpruSupport: [3], Reserved2: [4-5], NestedVirtSupport: [6], PsfdSupport: [7], CetSsSupport: [8], CetIbtSupport: [9], VmxExceptionInjectSupport: [10], Reserved4: [11], UmwaitTpauseSupport: [12], MovdiriSupport: [13], Movdir64bSupport: [14], CldemoteSupport: [15], SerializeSupport: [16], TscDeadlineTmrSupport: [17], TscAdjustSupport: [18], FZLRepMovsb: [19], FSRepStosb: [20], FSRepCmpsb: [21], TsxLdTrkSupport: [22], Reserved5: [23-63]
        ulong _bitfield0;
    }
    ulong AsUINT64;
}

struct WHV_PROCESSOR_FEATURES_BANKS
{
    uint BanksCount;
    uint Reserved0;
    union
    {
        struct
        {
            WHV_PROCESSOR_FEATURES Bank0;
            WHV_PROCESSOR_FEATURES1 Bank1;
        }
        ulong[2] AsUINT64;
    }
}

union WHV_SYNTHETIC_PROCESSOR_FEATURES
{
    struct
    {
        // Native bit field: HypervisorPresent: [0], Hv1: [1], AccessVpRunTimeReg: [2], AccessPartitionReferenceCounter: [3], AccessSynicRegs: [4], AccessSyntheticTimerRegs: [5], ReservedZ6: [6], AccessHypercallRegs: [7], AccessVpIndex: [8], AccessPartitionReferenceTsc: [9], ReservedZ10: [10], ReservedZ11: [11], ReservedZ12: [12], ReservedZ13: [13], ReservedZ14: [14], ReservedZ15: [15], ReservedZ16: [16], ReservedZ17: [17], FastHypercallOutput: [18], ReservedZ19: [19], ReservedZ20: [20], ReservedZ21: [21], DirectSyntheticTimers: [22], ReservedZ23: [23], ExtendedProcessorMasks: [24], ReservedZ25: [25], SyntheticClusterIpi: [26], NotifyLongSpinWait: [27], QueryNumaDistance: [28], SignalEvents: [29], RetargetDeviceInterrupt: [30], Reserved: [31-63]
        ulong _bitfield0;
    }
    ulong AsUINT64;
}

struct WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS
{
    uint BanksCount;
    uint Reserved0;
    union
    {
        struct
        {
            WHV_SYNTHETIC_PROCESSOR_FEATURES Bank0;
        }
        ulong[1] AsUINT64; // Flexible array
    }
}

union WHV_PROCESSOR_XSAVE_FEATURES
{
    struct
    {
        // Native bit field: XsaveSupport: [0], XsaveoptSupport: [1], AvxSupport: [2], Avx2Support: [3], FmaSupport: [4], MpxSupport: [5], Avx512Support: [6], Avx512DQSupport: [7], Avx512CDSupport: [8], Avx512BWSupport: [9], Avx512VLSupport: [10], XsaveCompSupport: [11], XsaveSupervisorSupport: [12], Xcr1Support: [13], Avx512BitalgSupport: [14], Avx512IfmaSupport: [15], Avx512VBmiSupport: [16], Avx512VBmi2Support: [17], Avx512VnniSupport: [18], GfniSupport: [19], VaesSupport: [20], Avx512VPopcntdqSupport: [21], VpclmulqdqSupport: [22], Avx512Bf16Support: [23], Avx512Vp2IntersectSupport: [24], Avx512Fp16Support: [25], XfdSupport: [26], AmxTileSupport: [27], AmxBf16Support: [28], AmxInt8Support: [29], AvxVnniSupport: [30], Reserved: [31-63]
        ulong _bitfield0;
    }
    ulong AsUINT64;
}

union WHV_PROCESSOR_PERFMON_FEATURES
{
    struct
    {
        // Native bit field: PmuSupport: [0], LbrSupport: [1], Reserved: [2-63]
        ulong _bitfield0;
    }
    ulong AsUINT64;
}

union WHV_X64_MSR_EXIT_BITMAP
{
    ulong AsUINT64;
    struct
    {
        // Native bit field: UnhandledMsrs: [0], TscMsrWrite: [1], TscMsrRead: [2], ApicBaseMsrWrite: [3], MiscEnableMsrRead: [4], McUpdatePatchLevelMsrRead: [5], Reserved: [6-63]
        ulong _bitfield0;
    }
}

struct WHV_MEMORY_RANGE_ENTRY
{
    ulong GuestAddress;
    ulong SizeInBytes;
}

union WHV_ADVISE_GPA_RANGE_POPULATE_FLAGS
{
    uint AsUINT32;
    struct
    {
        // Native bit field: Prefetch: [0], AvoidHardFaults: [1], Reserved: [2-31]
        uint _bitfield0;
    }
}

struct WHV_ADVISE_GPA_RANGE_POPULATE
{
    WHV_ADVISE_GPA_RANGE_POPULATE_FLAGS Flags;
    WHV_MEMORY_ACCESS_TYPE AccessType;
}

struct WHV_CAPABILITY_PROCESSOR_FREQUENCY_CAP
{
    // Native bit field: IsSupported: [0], Reserved: [1-31]
    uint _bitfield0;
    uint HighestFrequencyMhz;
    uint NominalFrequencyMhz;
    uint LowestFrequencyMhz;
    uint FrequencyStepMhz;
}

union WHV_SCHEDULER_FEATURES
{
    struct
    {
        // Native bit field: CpuReserve: [0], CpuCap: [1], CpuWeight: [2], CpuGroupId: [3], DisableSmt: [4], Reserved: [5-63]
        ulong _bitfield0;
    }
    ulong AsUINT64;
}

union WHV_CAPABILITY
{
    BOOL                 HypervisorPresent;
    WHV_CAPABILITY_FEATURES Features;
    WHV_EXTENDED_VM_EXITS ExtendedVmExits;
    WHV_PROCESSOR_VENDOR ProcessorVendor;
    WHV_PROCESSOR_FEATURES ProcessorFeatures;
    WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS SyntheticProcessorFeaturesBanks;
    WHV_PROCESSOR_XSAVE_FEATURES ProcessorXsaveFeatures;
    ubyte                ProcessorClFlushSize;
    ulong                ExceptionExitBitmap;
    WHV_X64_MSR_EXIT_BITMAP X64MsrExitBitmap;
    ulong                ProcessorClockFrequency;
    ulong                InterruptClockFrequency;
    WHV_PROCESSOR_FEATURES_BANKS ProcessorFeaturesBanks;
    WHV_ADVISE_GPA_RANGE_POPULATE_FLAGS GpaRangePopulateFlags;
    WHV_CAPABILITY_PROCESSOR_FREQUENCY_CAP ProcessorFrequencyCap;
    WHV_PROCESSOR_PERFMON_FEATURES ProcessorPerfmonFeatures;
    WHV_SCHEDULER_FEATURES SchedulerFeatures;
}

struct WHV_X64_CPUID_RESULT
{
    uint    Function;
    uint[3] Reserved;
    uint    Eax;
    uint    Ebx;
    uint    Ecx;
    uint    Edx;
}

struct WHV_CPUID_OUTPUT
{
    uint Eax;
    uint Ebx;
    uint Ecx;
    uint Edx;
}

struct WHV_X64_CPUID_RESULT2
{
    uint             Function;
    uint             Index;
    uint             VpIndex;
    WHV_X64_CPUID_RESULT2_FLAGS Flags;
    WHV_CPUID_OUTPUT Output;
    WHV_CPUID_OUTPUT Mask;
}

struct WHV_MSR_ACTION_ENTRY
{
    uint   Index;
    ubyte  ReadAction;
    ubyte  WriteAction;
    ushort Reserved;
}

union WHV_PARTITION_PROPERTY
{
    WHV_EXTENDED_VM_EXITS ExtendedVmExits;
    WHV_PROCESSOR_FEATURES ProcessorFeatures;
    WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS SyntheticProcessorFeaturesBanks;
    WHV_PROCESSOR_XSAVE_FEATURES ProcessorXsaveFeatures;
    ubyte          ProcessorClFlushSize;
    uint           ProcessorCount;
    uint[1]        CpuidExitList;
    WHV_X64_CPUID_RESULT[1] CpuidResultList;
    WHV_X64_CPUID_RESULT2[1] CpuidResultList2;
    WHV_MSR_ACTION_ENTRY[1] MsrActionList;
    WHV_MSR_ACTION UnimplementedMsrAction;
    ulong          ExceptionExitBitmap;
    WHV_X64_LOCAL_APIC_EMULATION_MODE LocalApicEmulationMode;
    BOOL           SeparateSecurityDomain;
    BOOL           NestedVirtualization;
    WHV_X64_MSR_EXIT_BITMAP X64MsrExitBitmap;
    ulong          ProcessorClockFrequency;
    ulong          InterruptClockFrequency;
    BOOL           ApicRemoteRead;
    WHV_PROCESSOR_FEATURES_BANKS ProcessorFeaturesBanks;
    ulong          ReferenceTime;
    ushort         PrimaryNumaNode;
    uint           CpuReserve;
    uint           CpuCap;
    uint           CpuWeight;
    ulong          CpuGroupId;
    uint           ProcessorFrequencyCap;
    BOOL           AllowDeviceAssignment;
    WHV_PROCESSOR_PERFMON_FEATURES ProcessorPerfmonFeatures;
    BOOL           DisableSmt;
}

struct WHV_TRANSLATE_GVA_RESULT
{
    WHV_TRANSLATE_GVA_RESULT_CODE ResultCode;
    uint Reserved;
}

union WHV_ADVISE_GPA_RANGE
{
    WHV_ADVISE_GPA_RANGE_POPULATE Populate;
}

union WHV_ACCESS_GPA_CONTROLS
{
    ulong AsUINT64;
    struct
    {
        WHV_CACHE_TYPE CacheType;
        uint           Reserved;
    }
}

union WHV_UINT128
{
    struct
    {
        ulong Low64;
        ulong High64;
    }
    uint[4] Dword;
}

union WHV_X64_FP_REGISTER
{
    struct
    {
        ulong Mantissa;
        // Native bit field: BiasedExponent: [0-14], Sign: [15], Reserved: [16-63]
        ulong _bitfield0;
    }
    WHV_UINT128 AsUINT128;
}

union WHV_X64_FP_CONTROL_STATUS_REGISTER
{
    struct
    {
        ushort FpControl;
        ushort FpStatus;
        ubyte  FpTag;
        ubyte  Reserved;
        ushort LastFpOp;
        union
        {
            ulong LastFpRip;
            struct
            {
                uint   LastFpEip;
                ushort LastFpCs;
                ushort Reserved2;
            }
        }
    }
    WHV_UINT128 AsUINT128;
}

union WHV_X64_XMM_CONTROL_STATUS_REGISTER
{
    struct
    {
        union
        {
            ulong LastFpRdp;
            struct
            {
                uint   LastFpDp;
                ushort LastFpDs;
                ushort Reserved;
            }
        }
        uint XmmStatusControl;
        uint XmmStatusControlMask;
    }
    WHV_UINT128 AsUINT128;
}

struct WHV_X64_SEGMENT_REGISTER
{
    ulong  Base;
    uint   Limit;
    ushort Selector;
    union
    {
        struct
        {
            // Native bit field: SegmentType: [0-3], NonSystemSegment: [4], DescriptorPrivilegeLevel: [5-6], Present: [7], Reserved: [8-11], Available: [12], Long: [13], Default: [14], Granularity: [15]
            ushort _bitfield0;
        }
        ushort Attributes;
    }
}

struct WHV_X64_TABLE_REGISTER
{
    ushort[3] Pad;
    ushort    Limit;
    ulong     Base;
}

union WHV_X64_INTERRUPT_STATE_REGISTER
{
    struct
    {
        // Native bit field: InterruptShadow: [0], NmiMasked: [1], Reserved: [2-63]
        ulong _bitfield0;
    }
    ulong AsUINT64;
}

union WHV_X64_PENDING_INTERRUPTION_REGISTER
{
    struct
    {
        // Native bit field: InterruptionPending: [0], InterruptionType: [1-3], DeliverErrorCode: [4], InstructionLength: [5-8], NestedEvent: [9], Reserved: [10-15], InterruptionVector: [16-31]
        uint _bitfield0;
        uint ErrorCode;
    }
    ulong AsUINT64;
}

union WHV_X64_DELIVERABILITY_NOTIFICATIONS_REGISTER
{
    struct
    {
        // Native bit field: NmiNotification: [0], InterruptNotification: [1], InterruptPriority: [2-5], Reserved: [6-47], Sint: [48-63]
        ulong _bitfield0;
    }
    ulong AsUINT64;
}

union WHV_X64_PENDING_EXCEPTION_EVENT
{
    struct
    {
        // Native bit field: EventPending: [0], EventType: [1-3], Reserved0: [4-7], DeliverErrorCode: [8], Reserved1: [9-15], Vector: [16-31]
        uint  _bitfield0;
        uint  ErrorCode;
        ulong ExceptionParameter;
    }
    WHV_UINT128 AsUINT128;
}

union WHV_X64_PENDING_EXT_INT_EVENT
{
    struct
    {
        // Native bit field: EventPending: [0], EventType: [1-3], Reserved0: [4-7], Vector: [8-15], Reserved1: [16-63]
        ulong _bitfield0;
        ulong Reserved2;
    }
    WHV_UINT128 AsUINT128;
}

union WHV_INTERNAL_ACTIVITY_REGISTER
{
    struct
    {
        // Native bit field: StartupSuspend: [0], HaltSuspend: [1], IdleSuspend: [2], Reserved: [3-63]
        ulong _bitfield0;
    }
    ulong AsUINT64;
}

union WHV_X64_PENDING_DEBUG_EXCEPTION
{
    ulong AsUINT64;
    struct
    {
        // Native bit field: Breakpoint0: [0], Breakpoint1: [1], Breakpoint2: [2], Breakpoint3: [3], SingleStep: [4], Reserved0: [5-63]
        ulong _bitfield0;
    }
}

struct WHV_SYNIC_SINT_DELIVERABLE_CONTEXT
{
    ushort DeliverableSints;
    ushort Reserved1;
    uint   Reserved2;
}

union WHV_REGISTER_VALUE
{
    WHV_UINT128         Reg128;
    ulong               Reg64;
    uint                Reg32;
    ushort              Reg16;
    ubyte               Reg8;
    WHV_X64_FP_REGISTER Fp;
    WHV_X64_FP_CONTROL_STATUS_REGISTER FpControlStatus;
    WHV_X64_XMM_CONTROL_STATUS_REGISTER XmmControlStatus;
    WHV_X64_SEGMENT_REGISTER Segment;
    WHV_X64_TABLE_REGISTER Table;
    WHV_X64_INTERRUPT_STATE_REGISTER InterruptState;
    WHV_X64_PENDING_INTERRUPTION_REGISTER PendingInterruption;
    WHV_X64_DELIVERABILITY_NOTIFICATIONS_REGISTER DeliverabilityNotifications;
    WHV_X64_PENDING_EXCEPTION_EVENT ExceptionEvent;
    WHV_X64_PENDING_EXT_INT_EVENT ExtIntEvent;
    WHV_INTERNAL_ACTIVITY_REGISTER InternalActivity;
    WHV_X64_PENDING_DEBUG_EXCEPTION PendingDebugException;
}

union WHV_X64_VP_EXECUTION_STATE
{
    struct
    {
        // Native bit field: Cpl: [0-1], Cr0Pe: [2], Cr0Am: [3], EferLma: [4], DebugActive: [5], InterruptionPending: [6], Reserved0: [7-11], InterruptShadow: [12], Reserved1: [13-15]
        ushort _bitfield0;
    }
    ushort AsUINT16;
}

struct WHV_VP_EXIT_CONTEXT
{
    WHV_X64_VP_EXECUTION_STATE ExecutionState;
    // Native bit field: InstructionLength: [0-3], Cr8: [4-7]
    ubyte _bitfield0;
    ubyte Reserved;
    uint  Reserved2;
    WHV_X64_SEGMENT_REGISTER Cs;
    ulong Rip;
    ulong Rflags;
}

union WHV_MEMORY_ACCESS_INFO
{
    struct
    {
        // Native bit field: AccessType: [0-1], GpaUnmapped: [2], GvaValid: [3], Reserved: [4-31]
        uint _bitfield0;
    }
    uint AsUINT32;
}

struct WHV_MEMORY_ACCESS_CONTEXT
{
    ubyte     InstructionByteCount;
    ubyte[3]  Reserved;
    ubyte[16] InstructionBytes;
    WHV_MEMORY_ACCESS_INFO AccessInfo;
    ulong     Gpa;
    ulong     Gva;
}

union WHV_X64_IO_PORT_ACCESS_INFO
{
    struct
    {
        // Native bit field: IsWrite: [0], AccessSize: [1-3], StringOp: [4], RepPrefix: [5], Reserved: [6-31]
        uint _bitfield0;
    }
    uint AsUINT32;
}

struct WHV_X64_IO_PORT_ACCESS_CONTEXT
{
    ubyte     InstructionByteCount;
    ubyte[3]  Reserved;
    ubyte[16] InstructionBytes;
    WHV_X64_IO_PORT_ACCESS_INFO AccessInfo;
    ushort    PortNumber;
    ushort[3] Reserved2;
    ulong     Rax;
    ulong     Rcx;
    ulong     Rsi;
    ulong     Rdi;
    WHV_X64_SEGMENT_REGISTER Ds;
    WHV_X64_SEGMENT_REGISTER Es;
}

union WHV_X64_MSR_ACCESS_INFO
{
    struct
    {
        // Native bit field: IsWrite: [0], Reserved: [1-31]
        uint _bitfield0;
    }
    uint AsUINT32;
}

struct WHV_X64_MSR_ACCESS_CONTEXT
{
    WHV_X64_MSR_ACCESS_INFO AccessInfo;
    uint  MsrNumber;
    ulong Rax;
    ulong Rdx;
}

struct WHV_X64_CPUID_ACCESS_CONTEXT
{
    ulong Rax;
    ulong Rcx;
    ulong Rdx;
    ulong Rbx;
    ulong DefaultResultRax;
    ulong DefaultResultRcx;
    ulong DefaultResultRdx;
    ulong DefaultResultRbx;
}

union WHV_VP_EXCEPTION_INFO
{
    struct
    {
        // Native bit field: ErrorCodeValid: [0], SoftwareException: [1], Reserved: [2-31]
        uint _bitfield0;
    }
    uint AsUINT32;
}

struct WHV_VP_EXCEPTION_CONTEXT
{
    ubyte     InstructionByteCount;
    ubyte[3]  Reserved;
    ubyte[16] InstructionBytes;
    WHV_VP_EXCEPTION_INFO ExceptionInfo;
    ubyte     ExceptionType;
    ubyte[3]  Reserved2;
    uint      ErrorCode;
    ulong     ExceptionParameter;
}

struct WHV_X64_UNSUPPORTED_FEATURE_CONTEXT
{
    WHV_X64_UNSUPPORTED_FEATURE_CODE FeatureCode;
    uint  Reserved;
    ulong FeatureParameter;
}

struct WHV_RUN_VP_CANCELED_CONTEXT
{
    WHV_RUN_VP_CANCEL_REASON CancelReason;
}

struct WHV_X64_INTERRUPTION_DELIVERABLE_CONTEXT
{
    WHV_X64_PENDING_INTERRUPTION_TYPE DeliverableType;
}

struct WHV_X64_APIC_EOI_CONTEXT
{
    uint InterruptVector;
}

union WHV_X64_RDTSC_INFO
{
    struct
    {
        // Native bit field: IsRdtscp: [0], Reserved: [1-63]
        ulong _bitfield0;
    }
    ulong AsUINT64;
}

struct WHV_X64_RDTSC_CONTEXT
{
    ulong              TscAux;
    ulong              VirtualOffset;
    ulong              Tsc;
    ulong              ReferenceTime;
    WHV_X64_RDTSC_INFO RdtscInfo;
}

struct WHV_X64_APIC_SMI_CONTEXT
{
    ulong ApicIcr;
}

struct WHV_HYPERCALL_CONTEXT
{
    ulong          Rax;
    ulong          Rbx;
    ulong          Rcx;
    ulong          Rdx;
    ulong          R8;
    ulong          Rsi;
    ulong          Rdi;
    ulong          Reserved0;
    WHV_UINT128[6] XmmRegisters;
    ulong[2]       Reserved1;
}

struct WHV_X64_APIC_INIT_SIPI_CONTEXT
{
    ulong ApicIcr;
}

struct WHV_X64_APIC_WRITE_CONTEXT
{
    WHV_X64_APIC_WRITE_TYPE Type;
    uint  Reserved;
    ulong WriteValue;
}

struct WHV_RUN_VP_EXIT_CONTEXT
{
    WHV_RUN_VP_EXIT_REASON ExitReason;
    uint                Reserved;
    WHV_VP_EXIT_CONTEXT VpContext;
    union
    {
        WHV_MEMORY_ACCESS_CONTEXT MemoryAccess;
        WHV_X64_IO_PORT_ACCESS_CONTEXT IoPortAccess;
        WHV_X64_MSR_ACCESS_CONTEXT MsrAccess;
        WHV_X64_CPUID_ACCESS_CONTEXT CpuidAccess;
        WHV_VP_EXCEPTION_CONTEXT VpException;
        WHV_X64_INTERRUPTION_DELIVERABLE_CONTEXT InterruptWindow;
        WHV_X64_UNSUPPORTED_FEATURE_CONTEXT UnsupportedFeature;
        WHV_RUN_VP_CANCELED_CONTEXT CancelReason;
        WHV_X64_APIC_EOI_CONTEXT ApicEoi;
        WHV_X64_RDTSC_CONTEXT ReadTsc;
        WHV_X64_APIC_SMI_CONTEXT ApicSmi;
        WHV_HYPERCALL_CONTEXT Hypercall;
        WHV_X64_APIC_INIT_SIPI_CONTEXT ApicInitSipi;
        WHV_X64_APIC_WRITE_CONTEXT ApicWrite;
        WHV_SYNIC_SINT_DELIVERABLE_CONTEXT SynicSintDeliverable;
    }
}

struct WHV_INTERRUPT_CONTROL
{
    // Native bit field: Type: [0-7], DestinationMode: [8-11], TriggerMode: [12-15], Reserved: [16-63]
    ulong _bitfield0;
    uint  Destination;
    uint  Vector;
}

struct WHV_DOORBELL_MATCH_DATA
{
    ulong GuestAddress;
    ulong Value;
    uint  Length;
    // Native bit field: MatchOnValue: [0], MatchOnLength: [1], Reserved: [2-31]
    uint  _bitfield0;
}

struct WHV_PARTITION_MEMORY_COUNTERS
{
    ulong Mapped4KPageCount;
    ulong Mapped2MPageCount;
    ulong Mapped1GPageCount;
}

struct WHV_PROCESSOR_RUNTIME_COUNTERS
{
    ulong TotalRuntime100ns;
    ulong HypervisorRuntime100ns;
}

struct WHV_PROCESSOR_INTERCEPT_COUNTER
{
    ulong Count;
    ulong Time100ns;
}

struct WHV_PROCESSOR_INTERCEPT_COUNTERS
{
    WHV_PROCESSOR_INTERCEPT_COUNTER PageInvalidations;
    WHV_PROCESSOR_INTERCEPT_COUNTER ControlRegisterAccesses;
    WHV_PROCESSOR_INTERCEPT_COUNTER IoInstructions;
    WHV_PROCESSOR_INTERCEPT_COUNTER HaltInstructions;
    WHV_PROCESSOR_INTERCEPT_COUNTER CpuidInstructions;
    WHV_PROCESSOR_INTERCEPT_COUNTER MsrAccesses;
    WHV_PROCESSOR_INTERCEPT_COUNTER OtherIntercepts;
    WHV_PROCESSOR_INTERCEPT_COUNTER PendingInterrupts;
    WHV_PROCESSOR_INTERCEPT_COUNTER EmulatedInstructions;
    WHV_PROCESSOR_INTERCEPT_COUNTER DebugRegisterAccesses;
    WHV_PROCESSOR_INTERCEPT_COUNTER PageFaultIntercepts;
    WHV_PROCESSOR_INTERCEPT_COUNTER NestedPageFaultIntercepts;
    WHV_PROCESSOR_INTERCEPT_COUNTER Hypercalls;
    WHV_PROCESSOR_INTERCEPT_COUNTER RdpmcInstructions;
}

struct WHV_PROCESSOR_EVENT_COUNTERS
{
    ulong PageFaultCount;
    ulong ExceptionCount;
    ulong InterruptCount;
}

struct WHV_PROCESSOR_APIC_COUNTERS
{
    ulong MmioAccessCount;
    ulong EoiAccessCount;
    ulong TprAccessCount;
    ulong SentIpiCount;
    ulong SelfIpiCount;
}

struct WHV_PROCESSOR_SYNTHETIC_FEATURES_COUNTERS
{
    ulong SyntheticInterruptsCount;
    ulong LongSpinWaitHypercallsCount;
    ulong OtherHypercallsCount;
    ulong SyntheticInterruptHypercallsCount;
    ulong VirtualInterruptHypercallsCount;
    ulong VirtualMmuHypercallsCount;
}

struct WHV_SYNIC_EVENT_PARAMETERS
{
    uint   VpIndex;
    ubyte  TargetSint;
    ubyte  Reserved;
    ushort FlagNumber;
}

struct WHV_SRIOV_RESOURCE_DESCRIPTOR
{
    wchar[200] PnpInstanceId;
    LUID       VirtualFunctionId;
    ushort     VirtualFunctionIndex;
    ushort     Reserved;
}

struct WHV_VPCI_DEVICE_NOTIFICATION
{
    WHV_VPCI_DEVICE_NOTIFICATION_TYPE NotificationType;
    uint Reserved1;
    union
    {
        ulong Reserved2;
    }
}

struct WHV_VPCI_HARDWARE_IDS
{
    ushort VendorID;
    ushort DeviceID;
    ubyte  RevisionID;
    ubyte  ProgIf;
    ubyte  SubClass;
    ubyte  BaseClass;
    ushort SubVendorID;
    ushort SubSystemID;
}

struct WHV_VPCI_PROBED_BARS
{
    uint[6] Value;
}

struct WHV_VPCI_MMIO_MAPPING
{
    WHV_VPCI_DEVICE_REGISTER_SPACE Location;
    WHV_VPCI_MMIO_RANGE_FLAGS Flags;
    ulong SizeInBytes;
    ulong OffsetInBytes;
    void* VirtualAddress;
}

struct WHV_VPCI_DEVICE_REGISTER
{
    WHV_VPCI_DEVICE_REGISTER_SPACE Location;
    uint  SizeInBytes;
    ulong OffsetInBytes;
}

struct WHV_VPCI_INTERRUPT_TARGET
{
    uint    Vector;
    WHV_VPCI_INTERRUPT_TARGET_FLAGS Flags;
    uint    ProcessorCount;
    uint[1] Processors; // Flexible array
}

struct WHV_TRIGGER_PARAMETERS
{
    WHV_TRIGGER_TYPE TriggerType;
    uint             Reserved;
    union
    {
        WHV_INTERRUPT_CONTROL Interrupt;
        WHV_SYNIC_EVENT_PARAMETERS SynicEvent;
        struct DeviceInterrupt
        {
            ulong LogicalDeviceId;
            ulong MsiAddress;
            uint  MsiData;
            uint  Reserved;
        }
    }
}

struct WHV_VIRTUAL_PROCESSOR_PROPERTY
{
    WHV_VIRTUAL_PROCESSOR_PROPERTY_CODE PropertyCode;
    uint Reserved;
    union
    {
        ushort NumaNode;
        ulong  Padding;
    }
}

struct WHV_NOTIFICATION_PORT_PARAMETERS
{
    WHV_NOTIFICATION_PORT_TYPE NotificationPortType;
    uint Reserved;
    union
    {
        WHV_DOORBELL_MATCH_DATA Doorbell;
        struct Event
        {
            uint ConnectionId;
        }
    }
}

union WHV_EMULATOR_STATUS
{
    struct
    {
        // Native bit field: EmulationSuccessful: [0], InternalEmulationFailure: [1], IoPortCallbackFailed: [2], MemoryCallbackFailed: [3], TranslateGvaPageCallbackFailed: [4], TranslateGvaPageCallbackGpaIsNotAligned: [5], GetVirtualProcessorRegistersCallbackFailed: [6], SetVirtualProcessorRegistersCallbackFailed: [7], InterruptCausedIntercept: [8], GuestCannotBeFaulted: [9], Reserved: [10-31]
        uint _bitfield0;
    }
    uint AsUINT32;
}

struct WHV_EMULATOR_MEMORY_ACCESS_INFO
{
    ulong    GpaAddress;
    ubyte    Direction;
    ubyte    AccessSize;
    ubyte[8] Data;
}

struct WHV_EMULATOR_IO_ACCESS_INFO
{
    ubyte  Direction;
    ushort Port;
    ushort AccessSize;
    uint   Data;
}

struct WHV_EMULATOR_CALLBACKS
{
    uint Size;
    uint Reserved;
    WHV_EMULATOR_IO_PORT_CALLBACK WHvEmulatorIoPortCallback;
    WHV_EMULATOR_MEMORY_CALLBACK WHvEmulatorMemoryCallback;
    WHV_EMULATOR_GET_VIRTUAL_PROCESSOR_REGISTERS_CALLBACK WHvEmulatorGetVirtualProcessorRegisters;
    WHV_EMULATOR_SET_VIRTUAL_PROCESSOR_REGISTERS_CALLBACK WHvEmulatorSetVirtualProcessorRegisters;
    WHV_EMULATOR_TRANSLATE_GVA_PAGE_CALLBACK WHvEmulatorTranslateGvaPage;
}

struct SOCKADDR_HV
{
    ADDRESS_FAMILY Family;
    ushort         Reserved;
    GUID           VmId;
    GUID           ServiceId;
}

struct HVSOCKET_ADDRESS_INFO
{
    GUID SystemId;
    GUID VirtualMachineId;
    GUID SiloId;
    uint Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/vmgenerationcounter/ns-vmgenerationcounter-vm_gencounter
struct VM_GENCOUNTER
{
    ulong GenerationCount;
    ulong GenerationCountHigh;
}

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcs/Reference/hdv/HdvPciPnpId
struct HDV_PCI_PNP_ID
{
    ushort VendorID;
    ushort DeviceID;
    ubyte  RevisionID;
    ubyte  ProgIf;
    ubyte  SubClass;
    ubyte  BaseClass;
    ushort SubVendorID;
    ushort SubSystemID;
}

struct HDV_PCI_DEVICE_INTERFACE
{
    HDV_PCI_INTERFACE_VERSION Version;
    HDV_PCI_DEVICE_INITIALIZE Initialize;
    HDV_PCI_DEVICE_TEARDOWN Teardown;
    HDV_PCI_DEVICE_SET_CONFIGURATION SetConfiguration;
    HDV_PCI_DEVICE_GET_DETAILS GetDetails;
    HDV_PCI_DEVICE_START Start;
    HDV_PCI_DEVICE_STOP  Stop;
    HDV_PCI_READ_CONFIG_SPACE ReadConfigSpace;
    HDV_PCI_WRITE_CONFIG_SPACE WriteConfigSpace;
    HDV_PCI_READ_INTERCEPTED_MEMORY ReadInterceptedMemory;
    HDV_PCI_WRITE_INTERCEPTED_MEMORY WriteInterceptedMemory;
}

struct GPA_MEMORY_CHUNK
{
    ulong GuestPhysicalStartPageIndex;
    ulong PageCount;
}

union GUEST_OS_INFO
{
    ulong AsUINT64;
    struct ClosedSource
    {
        // Native bit field: BuildNumber: [0-15], ServiceVersion: [16-23], MinorVersion: [24-31], MajorVersion: [32-39], OsId: [40-47], VendorId: [48-63]
        ulong _bitfield0;
    }
    struct OpenSource
    {
        // Native bit field: VendorSpecific1: [0-15], Version: [16-47], VendorSpecific2: [48-55], OsId: [56-62], IsOpenSource: [63]
        ulong _bitfield1;
    }
}

union VIRTUAL_PROCESSOR_REGISTER
{
    ulong  Reg64;
    uint   Reg32;
    ushort Reg16;
    ubyte  Reg8;
    struct Reg128
    {
        ulong Low64;
        ulong High64;
    }
    union X64
    {
        struct Segment
        {
            ulong  Base;
            uint   Limit;
            ushort Selector;
            union
            {
                ushort Attributes;
                struct
                {
                    // Native bit field: SegmentType: [0-3], NonSystemSegment: [4], DescriptorPrivilegeLevel: [5-6], Present: [7], Reserved: [8-11], Available: [12], Long: [13], Default: [14], Granularity: [15]
                    ushort _bitfield0;
                }
            }
        }
        struct Table
        {
            ushort Limit;
            ulong  Base;
        }
        struct FpControlStatus
        {
            ushort FpControl;
            ushort FpStatus;
            ubyte  FpTag;
            ubyte  Reserved;
            ushort LastFpOp;
            union
            {
                ulong LastFpRip;
                struct
                {
                    uint   LastFpEip;
                    ushort LastFpCs;
                }
            }
        }
        struct XmmControlStatus
        {
            union
            {
                ulong LastFpRdp;
                struct
                {
                    uint   LastFpDp;
                    ushort LastFpDs;
                }
            }
            uint XmmStatusControl;
            uint XmmStatusControlMask;
        }
    }
}

struct DOS_IMAGE_INFO
{
    const(PSTR) PdbName;
    ulong       ImageBaseAddress;
    uint        ImageSize;
    uint        Timestamp;
}

struct MODULE_INFO
{
    const(PSTR)    ProcessImageName;
    DOS_IMAGE_INFO Image;
}

// Functions

@DllImport("WinHvPlatform.dll")
HRESULT WHvGetCapability(WHV_CAPABILITY_CODE CapabilityCode, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* CapabilityBuffer, 
                         uint CapabilityBufferSizeInBytes, uint* WrittenSizeInBytes);

@DllImport("WinHvPlatform.dll")
HRESULT WHvCreatePartition(WHV_PARTITION_HANDLE* Partition);

@DllImport("WinHvPlatform.dll")
HRESULT WHvSetupPartition(WHV_PARTITION_HANDLE Partition);

@DllImport("WinHvPlatform.dll")
HRESULT WHvResetPartition(WHV_PARTITION_HANDLE Partition);

@DllImport("WinHvPlatform.dll")
HRESULT WHvDeletePartition(WHV_PARTITION_HANDLE Partition);

@DllImport("WinHvPlatform.dll")
HRESULT WHvGetPartitionProperty(WHV_PARTITION_HANDLE Partition, WHV_PARTITION_PROPERTY_CODE PropertyCode, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* PropertyBuffer, 
                                uint PropertyBufferSizeInBytes, uint* WrittenSizeInBytes);

@DllImport("WinHvPlatform.dll")
HRESULT WHvSetPartitionProperty(WHV_PARTITION_HANDLE Partition, WHV_PARTITION_PROPERTY_CODE PropertyCode, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(void)* PropertyBuffer, 
                                uint PropertyBufferSizeInBytes);

@DllImport("WinHvPlatform.dll")
HRESULT WHvSuspendPartitionTime(WHV_PARTITION_HANDLE Partition);

@DllImport("WinHvPlatform.dll")
HRESULT WHvResumePartitionTime(WHV_PARTITION_HANDLE Partition);

@DllImport("WinHvPlatform.dll")
HRESULT WHvMapGpaRange(WHV_PARTITION_HANDLE Partition, void* SourceAddress, ulong GuestAddress, ulong SizeInBytes, 
                       WHV_MAP_GPA_RANGE_FLAGS Flags);

@DllImport("WinHvPlatform.dll")
HRESULT WHvMapGpaRange2(WHV_PARTITION_HANDLE Partition, HANDLE Process, void* SourceAddress, ulong GuestAddress, 
                        ulong SizeInBytes, WHV_MAP_GPA_RANGE_FLAGS Flags);

@DllImport("WinHvPlatform.dll")
HRESULT WHvUnmapGpaRange(WHV_PARTITION_HANDLE Partition, ulong GuestAddress, ulong SizeInBytes);

@DllImport("WinHvPlatform.dll")
HRESULT WHvTranslateGva(WHV_PARTITION_HANDLE Partition, uint VpIndex, ulong Gva, 
                        WHV_TRANSLATE_GVA_FLAGS TranslateFlags, WHV_TRANSLATE_GVA_RESULT* TranslationResult, 
                        ulong* Gpa);

@DllImport("WinHvPlatform.dll")
HRESULT WHvCreateVirtualProcessor(WHV_PARTITION_HANDLE Partition, uint VpIndex, uint Flags);

@DllImport("WinHvPlatform.dll")
HRESULT WHvCreateVirtualProcessor2(WHV_PARTITION_HANDLE Partition, uint VpIndex, 
                                   const(WHV_VIRTUAL_PROCESSOR_PROPERTY)* Properties, uint PropertyCount);

@DllImport("WinHvPlatform.dll")
HRESULT WHvDeleteVirtualProcessor(WHV_PARTITION_HANDLE Partition, uint VpIndex);

@DllImport("WinHvPlatform.dll")
HRESULT WHvRunVirtualProcessor(WHV_PARTITION_HANDLE Partition, uint VpIndex, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* ExitContext, 
                               uint ExitContextSizeInBytes);

@DllImport("WinHvPlatform.dll")
HRESULT WHvCancelRunVirtualProcessor(WHV_PARTITION_HANDLE Partition, uint VpIndex, uint Flags);

@DllImport("WinHvPlatform.dll")
HRESULT WHvGetVirtualProcessorRegisters(WHV_PARTITION_HANDLE Partition, uint VpIndex, 
                                        const(WHV_REGISTER_NAME)* RegisterNames, uint RegisterCount, 
                                        WHV_REGISTER_VALUE* RegisterValues);

@DllImport("WinHvPlatform.dll")
HRESULT WHvSetVirtualProcessorRegisters(WHV_PARTITION_HANDLE Partition, uint VpIndex, 
                                        const(WHV_REGISTER_NAME)* RegisterNames, uint RegisterCount, 
                                        const(WHV_REGISTER_VALUE)* RegisterValues);

@DllImport("WinHvPlatform.dll")
HRESULT WHvGetVirtualProcessorInterruptControllerState(WHV_PARTITION_HANDLE Partition, uint VpIndex, 
                                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* State, 
                                                       uint StateSize, uint* WrittenSize);

@DllImport("WinHvPlatform.dll")
HRESULT WHvSetVirtualProcessorInterruptControllerState(WHV_PARTITION_HANDLE Partition, uint VpIndex, 
                                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(void)* State, 
                                                       uint StateSize);

@DllImport("WinHvPlatform.dll")
HRESULT WHvRequestInterrupt(WHV_PARTITION_HANDLE Partition, const(WHV_INTERRUPT_CONTROL)* Interrupt, 
                            uint InterruptControlSize);

@DllImport("WinHvPlatform.dll")
HRESULT WHvGetVirtualProcessorXsaveState(WHV_PARTITION_HANDLE Partition, uint VpIndex, 
                                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                                         uint BufferSizeInBytes, uint* BytesWritten);

@DllImport("WinHvPlatform.dll")
HRESULT WHvSetVirtualProcessorXsaveState(WHV_PARTITION_HANDLE Partition, uint VpIndex, 
                                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(void)* Buffer, 
                                         uint BufferSizeInBytes);

@DllImport("WinHvPlatform.dll")
HRESULT WHvQueryGpaRangeDirtyBitmap(WHV_PARTITION_HANDLE Partition, ulong GuestAddress, ulong RangeSizeInBytes, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ulong* Bitmap, 
                                    uint BitmapSizeInBytes);

@DllImport("WinHvPlatform.dll")
HRESULT WHvGetPartitionCounters(WHV_PARTITION_HANDLE Partition, WHV_PARTITION_COUNTER_SET CounterSet, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                                uint BufferSizeInBytes, uint* BytesWritten);

@DllImport("WinHvPlatform.dll")
HRESULT WHvGetVirtualProcessorCounters(WHV_PARTITION_HANDLE Partition, uint VpIndex, 
                                       WHV_PROCESSOR_COUNTER_SET CounterSet, 
                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                       uint BufferSizeInBytes, uint* BytesWritten);

@DllImport("WinHvPlatform.dll")
HRESULT WHvGetVirtualProcessorInterruptControllerState2(WHV_PARTITION_HANDLE Partition, uint VpIndex, 
                                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* State, 
                                                        uint StateSize, uint* WrittenSize);

@DllImport("WinHvPlatform.dll")
HRESULT WHvSetVirtualProcessorInterruptControllerState2(WHV_PARTITION_HANDLE Partition, uint VpIndex, 
                                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(void)* State, 
                                                        uint StateSize);

@DllImport("WinHvPlatform.dll")
HRESULT WHvRegisterPartitionDoorbellEvent(WHV_PARTITION_HANDLE Partition, 
                                          const(WHV_DOORBELL_MATCH_DATA)* MatchData, HANDLE EventHandle);

@DllImport("WinHvPlatform.dll")
HRESULT WHvUnregisterPartitionDoorbellEvent(WHV_PARTITION_HANDLE Partition, 
                                            const(WHV_DOORBELL_MATCH_DATA)* MatchData);

@DllImport("WinHvPlatform.dll")
HRESULT WHvAdviseGpaRange(WHV_PARTITION_HANDLE Partition, const(WHV_MEMORY_RANGE_ENTRY)* GpaRanges, 
                          uint GpaRangesCount, WHV_ADVISE_GPA_RANGE_CODE Advice, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/const(void)* AdviceBuffer, 
                          uint AdviceBufferSizeInBytes);

@DllImport("WinHvPlatform.dll")
HRESULT WHvReadGpaRange(WHV_PARTITION_HANDLE Partition, uint VpIndex, ulong GuestAddress, 
                        WHV_ACCESS_GPA_CONTROLS Controls, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* Data, 
                        uint DataSizeInBytes);

@DllImport("WinHvPlatform.dll")
HRESULT WHvWriteGpaRange(WHV_PARTITION_HANDLE Partition, uint VpIndex, ulong GuestAddress, 
                         WHV_ACCESS_GPA_CONTROLS Controls, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/const(void)* Data, 
                         uint DataSizeInBytes);

@DllImport("WinHvPlatform.dll")
HRESULT WHvSignalVirtualProcessorSynicEvent(WHV_PARTITION_HANDLE Partition, WHV_SYNIC_EVENT_PARAMETERS SynicEvent, 
                                            BOOL* NewlySignaled);

@DllImport("WinHvPlatform.dll")
HRESULT WHvGetVirtualProcessorState(WHV_PARTITION_HANDLE Partition, uint VpIndex, 
                                    WHV_VIRTUAL_PROCESSOR_STATE_TYPE StateType, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                                    uint BufferSizeInBytes, uint* BytesWritten);

@DllImport("WinHvPlatform.dll")
HRESULT WHvSetVirtualProcessorState(WHV_PARTITION_HANDLE Partition, uint VpIndex, 
                                    WHV_VIRTUAL_PROCESSOR_STATE_TYPE StateType, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(void)* Buffer, 
                                    uint BufferSizeInBytes);

@DllImport("WinHvPlatform.dll")
HRESULT WHvAllocateVpciResource(const(GUID)* ProviderId, WHV_ALLOCATE_VPCI_RESOURCE_FLAGS Flags, 
                                const(void)* ResourceDescriptor, uint ResourceDescriptorSizeInBytes, 
                                HANDLE* VpciResource);

@DllImport("WinHvPlatform.dll")
HRESULT WHvCreateVpciDevice(WHV_PARTITION_HANDLE Partition, ulong LogicalDeviceId, HANDLE VpciResource, 
                            WHV_CREATE_VPCI_DEVICE_FLAGS Flags, HANDLE NotificationEventHandle);

@DllImport("WinHvPlatform.dll")
HRESULT WHvDeleteVpciDevice(WHV_PARTITION_HANDLE Partition, ulong LogicalDeviceId);

@DllImport("WinHvPlatform.dll")
HRESULT WHvGetVpciDeviceProperty(WHV_PARTITION_HANDLE Partition, ulong LogicalDeviceId, 
                                 WHV_VPCI_DEVICE_PROPERTY_CODE PropertyCode, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* PropertyBuffer, 
                                 uint PropertyBufferSizeInBytes, uint* WrittenSizeInBytes);

@DllImport("WinHvPlatform.dll")
HRESULT WHvGetVpciDeviceNotification(WHV_PARTITION_HANDLE Partition, ulong LogicalDeviceId, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/WHV_VPCI_DEVICE_NOTIFICATION* Notification, 
                                     uint NotificationSizeInBytes);

@DllImport("WinHvPlatform.dll")
HRESULT WHvMapVpciDeviceMmioRanges(WHV_PARTITION_HANDLE Partition, ulong LogicalDeviceId, uint* MappingCount, 
                                   WHV_VPCI_MMIO_MAPPING** Mappings);

@DllImport("WinHvPlatform.dll")
HRESULT WHvUnmapVpciDeviceMmioRanges(WHV_PARTITION_HANDLE Partition, ulong LogicalDeviceId);

@DllImport("WinHvPlatform.dll")
HRESULT WHvSetVpciDevicePowerState(WHV_PARTITION_HANDLE Partition, ulong LogicalDeviceId, 
                                   DEVICE_POWER_STATE PowerState);

@DllImport("WinHvPlatform.dll")
HRESULT WHvReadVpciDeviceRegister(WHV_PARTITION_HANDLE Partition, ulong LogicalDeviceId, 
                                  const(WHV_VPCI_DEVICE_REGISTER)* Register, void* Data);

@DllImport("WinHvPlatform.dll")
HRESULT WHvWriteVpciDeviceRegister(WHV_PARTITION_HANDLE Partition, ulong LogicalDeviceId, 
                                   const(WHV_VPCI_DEVICE_REGISTER)* Register, const(void)* Data);

@DllImport("WinHvPlatform.dll")
HRESULT WHvMapVpciDeviceInterrupt(WHV_PARTITION_HANDLE Partition, ulong LogicalDeviceId, uint Index, 
                                  uint MessageCount, const(WHV_VPCI_INTERRUPT_TARGET)* Target, ulong* MsiAddress, 
                                  uint* MsiData);

@DllImport("WinHvPlatform.dll")
HRESULT WHvUnmapVpciDeviceInterrupt(WHV_PARTITION_HANDLE Partition, ulong LogicalDeviceId, uint Index);

@DllImport("WinHvPlatform.dll")
HRESULT WHvRetargetVpciDeviceInterrupt(WHV_PARTITION_HANDLE Partition, ulong LogicalDeviceId, ulong MsiAddress, 
                                       uint MsiData, const(WHV_VPCI_INTERRUPT_TARGET)* Target);

@DllImport("WinHvPlatform.dll")
HRESULT WHvRequestVpciDeviceInterrupt(WHV_PARTITION_HANDLE Partition, ulong LogicalDeviceId, ulong MsiAddress, 
                                      uint MsiData);

@DllImport("WinHvPlatform.dll")
HRESULT WHvGetVpciDeviceInterruptTarget(WHV_PARTITION_HANDLE Partition, ulong LogicalDeviceId, uint Index, 
                                        uint MultiMessageNumber, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/WHV_VPCI_INTERRUPT_TARGET* Target, 
                                        uint TargetSizeInBytes, uint* BytesWritten);

@DllImport("WinHvPlatform.dll")
HRESULT WHvCreateTrigger(WHV_PARTITION_HANDLE Partition, const(WHV_TRIGGER_PARAMETERS)* Parameters, 
                         void** TriggerHandle, HANDLE* EventHandle);

@DllImport("WinHvPlatform.dll")
HRESULT WHvUpdateTriggerParameters(WHV_PARTITION_HANDLE Partition, const(WHV_TRIGGER_PARAMETERS)* Parameters, 
                                   void* TriggerHandle);

@DllImport("WinHvPlatform.dll")
HRESULT WHvDeleteTrigger(WHV_PARTITION_HANDLE Partition, void* TriggerHandle);

@DllImport("WinHvPlatform.dll")
HRESULT WHvCreateNotificationPort(WHV_PARTITION_HANDLE Partition, 
                                  const(WHV_NOTIFICATION_PORT_PARAMETERS)* Parameters, HANDLE EventHandle, 
                                  void** PortHandle);

@DllImport("WinHvPlatform.dll")
HRESULT WHvSetNotificationPortProperty(WHV_PARTITION_HANDLE Partition, void* PortHandle, 
                                       WHV_NOTIFICATION_PORT_PROPERTY_CODE PropertyCode, ulong PropertyValue);

@DllImport("WinHvPlatform.dll")
HRESULT WHvDeleteNotificationPort(WHV_PARTITION_HANDLE Partition, void* PortHandle);

@DllImport("WinHvPlatform.dll")
HRESULT WHvPostVirtualProcessorSynicMessage(WHV_PARTITION_HANDLE Partition, uint VpIndex, uint SintIndex, 
                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(void)* Message, 
                                            uint MessageSizeInBytes);

@DllImport("WinHvPlatform.dll")
HRESULT WHvGetVirtualProcessorCpuidOutput(WHV_PARTITION_HANDLE Partition, uint VpIndex, uint Eax, uint Ecx, 
                                          WHV_CPUID_OUTPUT* CpuidOutput);

@DllImport("WinHvPlatform.dll")
HRESULT WHvGetInterruptTargetVpSet(WHV_PARTITION_HANDLE Partition, ulong Destination, 
                                   WHV_INTERRUPT_DESTINATION_MODE DestinationMode, uint* TargetVps, uint VpCount, 
                                   uint* TargetVpCount);

@DllImport("WinHvPlatform.dll")
HRESULT WHvStartPartitionMigration(WHV_PARTITION_HANDLE Partition, HANDLE* MigrationHandle);

@DllImport("WinHvPlatform.dll")
HRESULT WHvCancelPartitionMigration(WHV_PARTITION_HANDLE Partition);

@DllImport("WinHvPlatform.dll")
HRESULT WHvCompletePartitionMigration(WHV_PARTITION_HANDLE Partition);

@DllImport("WinHvPlatform.dll")
HRESULT WHvAcceptPartitionMigration(HANDLE MigrationHandle, WHV_PARTITION_HANDLE* Partition);

@DllImport("WinHvEmulation.dll")
HRESULT WHvEmulatorCreateEmulator(const(WHV_EMULATOR_CALLBACKS)* Callbacks, void** Emulator);

@DllImport("WinHvEmulation.dll")
HRESULT WHvEmulatorDestroyEmulator(void* Emulator);

@DllImport("WinHvEmulation.dll")
HRESULT WHvEmulatorTryIoEmulation(void* Emulator, void* Context, const(WHV_VP_EXIT_CONTEXT)* VpContext, 
                                  const(WHV_X64_IO_PORT_ACCESS_CONTEXT)* IoInstructionContext, 
                                  WHV_EMULATOR_STATUS* EmulatorReturnStatus);

@DllImport("WinHvEmulation.dll")
HRESULT WHvEmulatorTryMmioEmulation(void* Emulator, void* Context, const(WHV_VP_EXIT_CONTEXT)* VpContext, 
                                    const(WHV_MEMORY_ACCESS_CONTEXT)* MmioInstructionContext, 
                                    WHV_EMULATOR_STATUS* EmulatorReturnStatus);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcs/Reference/hdv/HdvInitializeDeviceHost
@DllImport("vmdevicehost.dll")
HRESULT HdvInitializeDeviceHost(HCS_SYSTEM computeSystem, void** deviceHostHandle);

@DllImport("vmdevicehost.dll")
HRESULT HdvInitializeDeviceHostEx(HCS_SYSTEM computeSystem, HDV_DEVICE_HOST_FLAGS flags, void** deviceHostHandle);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcs/Reference/hdv/HdvTeardownDeviceHost
@DllImport("vmdevicehost.dll")
HRESULT HdvTeardownDeviceHost(void* deviceHostHandle);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcs/Reference/hdv/HdvCreateDeviceInstance
@DllImport("vmdevicehost.dll")
HRESULT HdvCreateDeviceInstance(void* deviceHostHandle, HDV_DEVICE_TYPE deviceType, const(GUID)* deviceClassId, 
                                const(GUID)* deviceInstanceId, const(void)* deviceInterface, void* deviceContext, 
                                void** deviceHandle);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcs/Reference/hdv/HdvReadGuestMemory
@DllImport("vmdevicehost.dll")
HRESULT HdvReadGuestMemory(void* requestor, ulong guestPhysicalAddress, uint byteCount, ubyte* buffer);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcs/Reference/hdv/HdvWriteGuestMemory
@DllImport("vmdevicehost.dll")
HRESULT HdvWriteGuestMemory(void* requestor, ulong guestPhysicalAddress, uint byteCount, const(ubyte)* buffer);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcs/Reference/hdv/HdvCreateGuestMemoryAperture
@DllImport("vmdevicehost.dll")
HRESULT HdvCreateGuestMemoryAperture(void* requestor, ulong guestPhysicalAddress, uint byteCount, 
                                     BOOL writeProtected, void** mappedAddress);

@DllImport("vmdevicehost.dll")
HRESULT HdvDestroyGuestMemoryAperture(void* requestor, void* mappedAddress);

// Microsoft documentation: https://learn.microsoft.com/virtualization/api/hcs/Reference/hdv/HdvDeliverGuestInterrupt
@DllImport("vmdevicehost.dll")
HRESULT HdvDeliverGuestInterrupt(void* requestor, ulong msiAddress, uint msiData);

@DllImport("vmdevicehost.dll")
HRESULT HdvRegisterDoorbell(void* requestor, HDV_PCI_BAR_SELECTOR BarIndex, ulong BarOffset, ulong TriggerValue, 
                            ulong Flags, HANDLE DoorbellEvent);

@DllImport("vmdevicehost.dll")
HRESULT HdvUnregisterDoorbell(void* requestor, HDV_PCI_BAR_SELECTOR BarIndex, ulong BarOffset, ulong TriggerValue, 
                              ulong Flags);

@DllImport("vmdevicehost.dll")
HRESULT HdvCreateSectionBackedMmioRange(void* requestor, HDV_PCI_BAR_SELECTOR barIndex, ulong offsetInPages, 
                                        ulong lengthInPages, HDV_MMIO_MAPPING_FLAGS MappingFlags, 
                                        HANDLE sectionHandle, ulong sectionOffsetInPages);

@DllImport("vmdevicehost.dll")
HRESULT HdvDestroySectionBackedMmioRange(void* requestor, HDV_PCI_BAR_SELECTOR barIndex, ulong offsetInPages);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT LocateSavedStateFiles(const(PWSTR) vmName, const(PWSTR) snapshotName, PWSTR* binPath, PWSTR* vsvPath, 
                              PWSTR* vmrsPath);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT LoadSavedStateFile(const(PWSTR) vmrsFile, void** vmSavedStateDumpHandle);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT ApplyPendingSavedStateFileReplayLog(const(PWSTR) vmrsFile);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT LoadSavedStateFiles(const(PWSTR) binFile, const(PWSTR) vsvFile, void** vmSavedStateDumpHandle);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT ReleaseSavedStateFiles(void* vmSavedStateDumpHandle);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT GetGuestEnabledVirtualTrustLevels(void* vmSavedStateDumpHandle, uint* virtualTrustLevels);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT GetGuestOsInfo(void* vmSavedStateDumpHandle, ubyte virtualTrustLevel, GUEST_OS_INFO* guestOsInfo);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT GetVpCount(void* vmSavedStateDumpHandle, uint* vpCount);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT GetArchitecture(void* vmSavedStateDumpHandle, uint vpId, VIRTUAL_PROCESSOR_ARCH* architecture);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT ForceArchitecture(void* vmSavedStateDumpHandle, uint vpId, VIRTUAL_PROCESSOR_ARCH architecture);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT GetActiveVirtualTrustLevel(void* vmSavedStateDumpHandle, uint vpId, ubyte* virtualTrustLevel);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT GetEnabledVirtualTrustLevels(void* vmSavedStateDumpHandle, uint vpId, uint* virtualTrustLevels);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT ForceActiveVirtualTrustLevel(void* vmSavedStateDumpHandle, uint vpId, ubyte virtualTrustLevel);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT IsActiveVirtualTrustLevelEnabled(void* vmSavedStateDumpHandle, uint vpId, 
                                         BOOL* activeVirtualTrustLevelEnabled);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT IsNestedVirtualizationEnabled(void* vmSavedStateDumpHandle, BOOL* enabled);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT GetNestedVirtualizationMode(void* vmSavedStateDumpHandle, uint vpId, BOOL* enabled);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT ForceNestedHostMode(void* vmSavedStateDumpHandle, uint vpId, BOOL hostMode, BOOL* oldMode);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT InKernelSpace(void* vmSavedStateDumpHandle, uint vpId, BOOL* inKernelSpace);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT GetRegisterValue(void* vmSavedStateDumpHandle, uint vpId, uint registerId, 
                         VIRTUAL_PROCESSOR_REGISTER* registerValue);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT GetPagingMode(void* vmSavedStateDumpHandle, uint vpId, PAGING_MODE* pagingMode);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT ForcePagingMode(void* vmSavedStateDumpHandle, uint vpId, PAGING_MODE pagingMode);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT ReadGuestPhysicalAddress(void* vmSavedStateDumpHandle, ulong physicalAddress, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* buffer, 
                                 uint bufferSize, uint* bytesRead);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT GuestVirtualAddressToPhysicalAddress(void* vmSavedStateDumpHandle, uint vpId, const(ulong) virtualAddress, 
                                             ulong* physicalAddress, ulong* unmappedRegionSize);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT GetGuestPhysicalMemoryChunks(void* vmSavedStateDumpHandle, ulong* memoryChunkPageSize, 
                                     GPA_MEMORY_CHUNK* memoryChunks, ulong* memoryChunkCount);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT GuestPhysicalAddressToRawSavedMemoryOffset(void* vmSavedStateDumpHandle, ulong physicalAddress, 
                                                   ulong* rawSavedMemoryOffset);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT ReadGuestRawSavedMemory(void* vmSavedStateDumpHandle, ulong rawSavedMemoryOffset, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* buffer, 
                                uint bufferSize, uint* bytesRead);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT GetGuestRawSavedMemorySize(void* vmSavedStateDumpHandle, ulong* guestRawSavedMemorySize);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT SetMemoryBlockCacheLimit(void* vmSavedStateDumpHandle, ulong memoryBlockCacheLimit);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT GetMemoryBlockCacheLimit(void* vmSavedStateDumpHandle, ulong* memoryBlockCacheLimit);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT ApplyGuestMemoryFix(void* vmSavedStateDumpHandle, uint vpId, ulong virtualAddress, void* fixBuffer, 
                            uint fixBufferSize);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT LoadSavedStateSymbolProvider(void* vmSavedStateDumpHandle, const(PWSTR) userSymbols, BOOL force);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT ReleaseSavedStateSymbolProvider(void* vmSavedStateDumpHandle);

@DllImport("VmSavedStateDumpProvider.dll")
HANDLE GetSavedStateSymbolProviderHandle(void* vmSavedStateDumpHandle);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT SetSavedStateSymbolProviderDebugInfoCallback(void* vmSavedStateDumpHandle, 
                                                     GUEST_SYMBOLS_PROVIDER_DEBUG_INFO_CALLBACK Callback);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT LoadSavedStateModuleSymbols(void* vmSavedStateDumpHandle, const(PSTR) imageName, const(PSTR) moduleName, 
                                    ulong baseAddress, uint sizeOfBase);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT LoadSavedStateModuleSymbolsEx(void* vmSavedStateDumpHandle, const(PSTR) imageName, uint imageTimestamp, 
                                      const(PSTR) moduleName, ulong baseAddress, uint sizeOfBase);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT ResolveSavedStateGlobalVariableAddress(void* vmSavedStateDumpHandle, uint vpId, const(PSTR) globalName, 
                                               ulong* virtualAddress, uint* size);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT ReadSavedStateGlobalVariable(void* vmSavedStateDumpHandle, uint vpId, const(PSTR) globalName, void* buffer, 
                                     uint bufferSize);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT GetSavedStateSymbolTypeSize(void* vmSavedStateDumpHandle, uint vpId, const(PSTR) typeName, uint* size);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT FindSavedStateSymbolFieldInType(void* vmSavedStateDumpHandle, uint vpId, const(PSTR) typeName, 
                                        const(PWSTR) fieldName, uint* offset, BOOL* found);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT GetSavedStateSymbolFieldInfo(void* vmSavedStateDumpHandle, uint vpId, const(PSTR) typeName, 
                                     PWSTR* typeFieldInfoMap);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT ScanMemoryForDosImages(void* vmSavedStateDumpHandle, uint vpId, ulong startAddress, ulong endAddress, 
                               void* callbackContext, FOUND_IMAGE_CALLBACK foundImageCallback, 
                               ulong* standaloneAddress, uint standaloneAddressCount);

@DllImport("VmSavedStateDumpProvider.dll")
HRESULT CallStackUnwind(void* vmSavedStateDumpHandle, uint vpId, MODULE_INFO* imageInfo, uint imageInfoCount, 
                        uint frameCount, PWSTR* callStack);


