// Written in the D programming language.

module windows.win32.system.diagnostics.debug_;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, BSTR, CHAR, HANDLE, HMODULE,
                                         HRESULT, HWND, NTSTATUS, PSTR, PWSTR,
                                         SYSTEMTIME;
public import windows.win32.security.wintrust : WIN_CERTIFICATE;
public import windows.win32.storage.filesystem : VS_FIXEDFILEINFO;
public import windows.win32.system.com : IUnknown;
public import windows.win32.system.com.structuredstorage : ILockBytes;
public import windows.win32.system.kernel : EXCEPTION_ROUTINE, FLOATING_SAVE_AREA, LIST_ENTRY;
public import windows.win32.system.memory : VIRTUAL_ALLOCATION_TYPE;
public import windows.win32.system.ole : CADWORD, CALPOLESTR;
public import windows.win32.system.systeminformation : IMAGE_FILE_MACHINE, PROCESSOR_ARCHITECTURE;
public import windows.win32.system.threading : LPTHREAD_START_ROUTINE;
public import windows.win32.system.time : TIME_ZONE_INFORMATION;
public import windows.win32.system.variant : VARIANT;
public import windows.win32.ui.windowsandmessaging : MESSAGEBOX_STYLE;

extern(Windows) @nogc nothrow:


// Enums


alias SYM_LOAD_FLAGS = uint;
enum : uint
{
    SLMFLAG_NONE       = 0x00000000U,
    SLMFLAG_VIRTUAL    = 0x00000001U,
    SLMFLAG_ALT_INDEX  = 0x00000002U,
    SLMFLAG_NO_SYMBOLS = 0x00000004U,
}

alias IMAGE_SECTION_CHARACTERISTICS = uint;
enum : uint
{
    IMAGE_SCN_TYPE_NO_PAD            = 0x00000008U,
    IMAGE_SCN_CNT_CODE               = 0x00000020U,
    IMAGE_SCN_CNT_INITIALIZED_DATA   = 0x00000040U,
    IMAGE_SCN_CNT_UNINITIALIZED_DATA = 0x00000080U,
    IMAGE_SCN_LNK_OTHER              = 0x00000100U,
    IMAGE_SCN_LNK_INFO               = 0x00000200U,
    IMAGE_SCN_LNK_REMOVE             = 0x00000800U,
    IMAGE_SCN_LNK_COMDAT             = 0x00001000U,
    IMAGE_SCN_NO_DEFER_SPEC_EXC      = 0x00004000U,
    IMAGE_SCN_GPREL                  = 0x00008000U,
    IMAGE_SCN_MEM_FARDATA            = 0x00008000U,
    IMAGE_SCN_MEM_PURGEABLE          = 0x00020000U,
    IMAGE_SCN_MEM_16BIT              = 0x00020000U,
    IMAGE_SCN_MEM_LOCKED             = 0x00040000U,
    IMAGE_SCN_MEM_PRELOAD            = 0x00080000U,
    IMAGE_SCN_ALIGN_1BYTES           = 0x00100000U,
    IMAGE_SCN_ALIGN_2BYTES           = 0x00200000U,
    IMAGE_SCN_ALIGN_4BYTES           = 0x00300000U,
    IMAGE_SCN_ALIGN_8BYTES           = 0x00400000U,
    IMAGE_SCN_ALIGN_16BYTES          = 0x00500000U,
    IMAGE_SCN_ALIGN_32BYTES          = 0x00600000U,
    IMAGE_SCN_ALIGN_64BYTES          = 0x00700000U,
    IMAGE_SCN_ALIGN_128BYTES         = 0x00800000U,
    IMAGE_SCN_ALIGN_256BYTES         = 0x00900000U,
    IMAGE_SCN_ALIGN_512BYTES         = 0x00a00000U,
    IMAGE_SCN_ALIGN_1024BYTES        = 0x00b00000U,
    IMAGE_SCN_ALIGN_2048BYTES        = 0x00c00000U,
    IMAGE_SCN_ALIGN_4096BYTES        = 0x00d00000U,
    IMAGE_SCN_ALIGN_8192BYTES        = 0x00e00000U,
    IMAGE_SCN_ALIGN_MASK             = 0x00f00000U,
    IMAGE_SCN_LNK_NRELOC_OVFL        = 0x01000000U,
    IMAGE_SCN_MEM_DISCARDABLE        = 0x02000000U,
    IMAGE_SCN_MEM_NOT_CACHED         = 0x04000000U,
    IMAGE_SCN_MEM_NOT_PAGED          = 0x08000000U,
    IMAGE_SCN_MEM_SHARED             = 0x10000000U,
    IMAGE_SCN_MEM_EXECUTE            = 0x20000000U,
    IMAGE_SCN_MEM_READ               = 0x40000000U,
    IMAGE_SCN_MEM_WRITE              = 0x80000000U,
    IMAGE_SCN_SCALE_INDEX            = 0x00000001U,
}

alias IMAGE_SUBSYSTEM = ushort;
enum : ushort
{
    IMAGE_SUBSYSTEM_UNKNOWN                  = cast(ushort) 0x0000,
    IMAGE_SUBSYSTEM_NATIVE                   = cast(ushort) 0x0001,
    IMAGE_SUBSYSTEM_WINDOWS_GUI              = cast(ushort) 0x0002,
    IMAGE_SUBSYSTEM_WINDOWS_CUI              = cast(ushort) 0x0003,
    IMAGE_SUBSYSTEM_OS2_CUI                  = cast(ushort) 0x0005,
    IMAGE_SUBSYSTEM_POSIX_CUI                = cast(ushort) 0x0007,
    IMAGE_SUBSYSTEM_NATIVE_WINDOWS           = cast(ushort) 0x0008,
    IMAGE_SUBSYSTEM_WINDOWS_CE_GUI           = cast(ushort) 0x0009,
    IMAGE_SUBSYSTEM_EFI_APPLICATION          = cast(ushort) 0x000a,
    IMAGE_SUBSYSTEM_EFI_BOOT_SERVICE_DRIVER  = cast(ushort) 0x000b,
    IMAGE_SUBSYSTEM_EFI_RUNTIME_DRIVER       = cast(ushort) 0x000c,
    IMAGE_SUBSYSTEM_EFI_ROM                  = cast(ushort) 0x000d,
    IMAGE_SUBSYSTEM_XBOX                     = cast(ushort) 0x000e,
    IMAGE_SUBSYSTEM_WINDOWS_BOOT_APPLICATION = cast(ushort) 0x0010,
    IMAGE_SUBSYSTEM_XBOX_CODE_CATALOG        = cast(ushort) 0x0011,
}

alias IMAGE_DLL_CHARACTERISTICS = ushort;
enum : ushort
{
    IMAGE_DLLCHARACTERISTICS_HIGH_ENTROPY_VA                               = cast(ushort) 0x0020,
    IMAGE_DLLCHARACTERISTICS_DYNAMIC_BASE                                  = cast(ushort) 0x0040,
    IMAGE_DLLCHARACTERISTICS_FORCE_INTEGRITY                               = cast(ushort) 0x0080,
    IMAGE_DLLCHARACTERISTICS_NX_COMPAT                                     = cast(ushort) 0x0100,
    IMAGE_DLLCHARACTERISTICS_NO_ISOLATION                                  = cast(ushort) 0x0200,
    IMAGE_DLLCHARACTERISTICS_NO_SEH                                        = cast(ushort) 0x0400,
    IMAGE_DLLCHARACTERISTICS_NO_BIND                                       = cast(ushort) 0x0800,
    IMAGE_DLLCHARACTERISTICS_APPCONTAINER                                  = cast(ushort) 0x1000,
    IMAGE_DLLCHARACTERISTICS_WDM_DRIVER                                    = cast(ushort) 0x2000,
    IMAGE_DLLCHARACTERISTICS_GUARD_CF                                      = cast(ushort) 0x4000,
    IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE                         = cast(ushort) 0x8000,
    IMAGE_DLLCHARACTERISTICS_EX_CET_COMPAT                                 = cast(ushort) 0x0001,
    IMAGE_DLLCHARACTERISTICS_EX_CET_COMPAT_STRICT_MODE                     = cast(ushort) 0x0002,
    IMAGE_DLLCHARACTERISTICS_EX_CET_SET_CONTEXT_IP_VALIDATION_RELAXED_MODE = cast(ushort) 0x0004,
    IMAGE_DLLCHARACTERISTICS_EX_CET_DYNAMIC_APIS_ALLOW_IN_PROC             = cast(ushort) 0x0008,
    IMAGE_DLLCHARACTERISTICS_EX_CET_RESERVED_1                             = cast(ushort) 0x0010,
    IMAGE_DLLCHARACTERISTICS_EX_CET_RESERVED_2                             = cast(ushort) 0x0020,
    IMAGE_DLLCHARACTERISTICS_EX_FORWARD_CFI_COMPAT                         = cast(ushort) 0x0040,
    IMAGE_DLLCHARACTERISTICS_EX_HOTPATCH_COMPATIBLE                        = cast(ushort) 0x0080,
}

alias IMAGE_OPTIONAL_HEADER_MAGIC = ushort;
enum : ushort
{
    IMAGE_NT_OPTIONAL_HDR_MAGIC   = cast(ushort) 0x020b,
    IMAGE_NT_OPTIONAL_HDR32_MAGIC = cast(ushort) 0x010b,
    IMAGE_NT_OPTIONAL_HDR64_MAGIC = cast(ushort) 0x020b,
    IMAGE_ROM_OPTIONAL_HDR_MAGIC  = cast(ushort) 0x0107,
}

alias BUGCHECK_ERROR = uint;
enum : uint
{
    HARDWARE_PROFILE_UNDOCKED_STRING                         = 0x40010001U,
    HARDWARE_PROFILE_DOCKED_STRING                           = 0x40010002U,
    HARDWARE_PROFILE_UNKNOWN_STRING                          = 0x40010003U,
    WINDOWS_NT_BANNER                                        = 0x4000007eU,
    WINDOWS_NT_CSD_STRING                                    = 0x40000087U,
    WINDOWS_NT_INFO_STRING                                   = 0x40000088U,
    WINDOWS_NT_MP_STRING                                     = 0x40000089U,
    THREAD_TERMINATE_HELD_MUTEX                              = 0x4000008aU,
    WINDOWS_NT_INFO_STRING_PLURAL                            = 0x4000009dU,
    WINDOWS_NT_RC_STRING                                     = 0x4000009eU,
    APC_INDEX_MISMATCH                                       = 0x00000001U,
    DEVICE_QUEUE_NOT_BUSY                                    = 0x00000002U,
    INVALID_AFFINITY_SET                                     = 0x00000003U,
    INVALID_DATA_ACCESS_TRAP                                 = 0x00000004U,
    INVALID_PROCESS_ATTACH_ATTEMPT                           = 0x00000005U,
    INVALID_PROCESS_DETACH_ATTEMPT                           = 0x00000006U,
    INVALID_SOFTWARE_INTERRUPT                               = 0x00000007U,
    IRQL_NOT_DISPATCH_LEVEL                                  = 0x00000008U,
    IRQL_NOT_GREATER_OR_EQUAL                                = 0x00000009U,
    IRQL_NOT_LESS_OR_EQUAL                                   = 0x0000000aU,
    NO_EXCEPTION_HANDLING_SUPPORT                            = 0x0000000bU,
    MAXIMUM_WAIT_OBJECTS_EXCEEDED                            = 0x0000000cU,
    MUTEX_LEVEL_NUMBER_VIOLATION                             = 0x0000000dU,
    NO_USER_MODE_CONTEXT                                     = 0x0000000eU,
    SPIN_LOCK_ALREADY_OWNED                                  = 0x0000000fU,
    SPIN_LOCK_NOT_OWNED                                      = 0x00000010U,
    THREAD_NOT_MUTEX_OWNER                                   = 0x00000011U,
    TRAP_CAUSE_UNKNOWN                                       = 0x00000012U,
    EMPTY_THREAD_REAPER_LIST                                 = 0x00000013U,
    CREATE_DELETE_LOCK_NOT_LOCKED                            = 0x00000014U,
    LAST_CHANCE_CALLED_FROM_KMODE                            = 0x00000015U,
    CID_HANDLE_CREATION                                      = 0x00000016U,
    CID_HANDLE_DELETION                                      = 0x00000017U,
    REFERENCE_BY_POINTER                                     = 0x00000018U,
    BAD_POOL_HEADER                                          = 0x00000019U,
    MEMORY_MANAGEMENT                                        = 0x0000001aU,
    PFN_SHARE_COUNT                                          = 0x0000001bU,
    PFN_REFERENCE_COUNT                                      = 0x0000001cU,
    NO_SPIN_LOCK_AVAILABLE                                   = 0x0000001dU,
    KMODE_EXCEPTION_NOT_HANDLED                              = 0x0000001eU,
    SHARED_RESOURCE_CONV_ERROR                               = 0x0000001fU,
    KERNEL_APC_PENDING_DURING_EXIT                           = 0x00000020U,
    QUOTA_UNDERFLOW                                          = 0x00000021U,
    FILE_SYSTEM                                              = 0x00000022U,
    FAT_FILE_SYSTEM                                          = 0x00000023U,
    NTFS_FILE_SYSTEM                                         = 0x00000024U,
    NPFS_FILE_SYSTEM                                         = 0x00000025U,
    CDFS_FILE_SYSTEM                                         = 0x00000026U,
    RDR_FILE_SYSTEM                                          = 0x00000027U,
    CORRUPT_ACCESS_TOKEN                                     = 0x00000028U,
    SECURITY_SYSTEM                                          = 0x00000029U,
    INCONSISTENT_IRP                                         = 0x0000002aU,
    PANIC_STACK_SWITCH                                       = 0x0000002bU,
    PORT_DRIVER_INTERNAL                                     = 0x0000002cU,
    SCSI_DISK_DRIVER_INTERNAL                                = 0x0000002dU,
    DATA_BUS_ERROR                                           = 0x0000002eU,
    INSTRUCTION_BUS_ERROR                                    = 0x0000002fU,
    SET_OF_INVALID_CONTEXT                                   = 0x00000030U,
    PHASE0_INITIALIZATION_FAILED                             = 0x00000031U,
    PHASE1_INITIALIZATION_FAILED                             = 0x00000032U,
    UNEXPECTED_INITIALIZATION_CALL                           = 0x00000033U,
    CACHE_MANAGER                                            = 0x00000034U,
    NO_MORE_IRP_STACK_LOCATIONS                              = 0x00000035U,
    DEVICE_REFERENCE_COUNT_NOT_ZERO                          = 0x00000036U,
    FLOPPY_INTERNAL_ERROR                                    = 0x00000037U,
    SERIAL_DRIVER_INTERNAL                                   = 0x00000038U,
    SYSTEM_EXIT_OWNED_MUTEX                                  = 0x00000039U,
    SYSTEM_UNWIND_PREVIOUS_USER                              = 0x0000003aU,
    SYSTEM_SERVICE_EXCEPTION                                 = 0x0000003bU,
    INTERRUPT_UNWIND_ATTEMPTED                               = 0x0000003cU,
    INTERRUPT_EXCEPTION_NOT_HANDLED                          = 0x0000003dU,
    MULTIPROCESSOR_CONFIGURATION_NOT_SUPPORTED               = 0x0000003eU,
    NO_MORE_SYSTEM_PTES                                      = 0x0000003fU,
    TARGET_MDL_TOO_SMALL                                     = 0x00000040U,
    MUST_SUCCEED_POOL_EMPTY                                  = 0x00000041U,
    ATDISK_DRIVER_INTERNAL                                   = 0x00000042U,
    NO_SUCH_PARTITION                                        = 0x00000043U,
    MULTIPLE_IRP_COMPLETE_REQUESTS                           = 0x00000044U,
    INSUFFICIENT_SYSTEM_MAP_REGS                             = 0x00000045U,
    DEREF_UNKNOWN_LOGON_SESSION                              = 0x00000046U,
    REF_UNKNOWN_LOGON_SESSION                                = 0x00000047U,
    CANCEL_STATE_IN_COMPLETED_IRP                            = 0x00000048U,
    PAGE_FAULT_WITH_INTERRUPTS_OFF                           = 0x00000049U,
    IRQL_GT_ZERO_AT_SYSTEM_SERVICE                           = 0x0000004aU,
    STREAMS_INTERNAL_ERROR                                   = 0x0000004bU,
    FATAL_UNHANDLED_HARD_ERROR                               = 0x0000004cU,
    NO_PAGES_AVAILABLE                                       = 0x0000004dU,
    PFN_LIST_CORRUPT                                         = 0x0000004eU,
    NDIS_INTERNAL_ERROR                                      = 0x0000004fU,
    PAGE_FAULT_IN_NONPAGED_AREA                              = 0x00000050U,
    PAGE_FAULT_IN_NONPAGED_AREA_M                            = 0x10000050U,
    REGISTRY_ERROR                                           = 0x00000051U,
    MAILSLOT_FILE_SYSTEM                                     = 0x00000052U,
    NO_BOOT_DEVICE                                           = 0x00000053U,
    LM_SERVER_INTERNAL_ERROR                                 = 0x00000054U,
    DATA_COHERENCY_EXCEPTION                                 = 0x00000055U,
    INSTRUCTION_COHERENCY_EXCEPTION                          = 0x00000056U,
    XNS_INTERNAL_ERROR                                       = 0x00000057U,
    VOLMGRX_INTERNAL_ERROR                                   = 0x00000058U,
    PINBALL_FILE_SYSTEM                                      = 0x00000059U,
    CRITICAL_SERVICE_FAILED                                  = 0x0000005aU,
    SET_ENV_VAR_FAILED                                       = 0x0000005bU,
    HAL_INITIALIZATION_FAILED                                = 0x0000005cU,
    UNSUPPORTED_PROCESSOR                                    = 0x0000005dU,
    OBJECT_INITIALIZATION_FAILED                             = 0x0000005eU,
    SECURITY_INITIALIZATION_FAILED                           = 0x0000005fU,
    PROCESS_INITIALIZATION_FAILED                            = 0x00000060U,
    HAL1_INITIALIZATION_FAILED                               = 0x00000061U,
    OBJECT1_INITIALIZATION_FAILED                            = 0x00000062U,
    SECURITY1_INITIALIZATION_FAILED                          = 0x00000063U,
    SYMBOLIC_INITIALIZATION_FAILED                           = 0x00000064U,
    MEMORY1_INITIALIZATION_FAILED                            = 0x00000065U,
    CACHE_INITIALIZATION_FAILED                              = 0x00000066U,
    CONFIG_INITIALIZATION_FAILED                             = 0x00000067U,
    FILE_INITIALIZATION_FAILED                               = 0x00000068U,
    IO1_INITIALIZATION_FAILED                                = 0x00000069U,
    LPC_INITIALIZATION_FAILED                                = 0x0000006aU,
    PROCESS1_INITIALIZATION_FAILED                           = 0x0000006bU,
    REFMON_INITIALIZATION_FAILED                             = 0x0000006cU,
    SESSION1_INITIALIZATION_FAILED                           = 0x0000006dU,
    BOOTPROC_INITIALIZATION_FAILED                           = 0x0000006eU,
    VSL_INITIALIZATION_FAILED                                = 0x0000006fU,
    SOFT_RESTART_FATAL_ERROR                                 = 0x00000070U,
    ASSIGN_DRIVE_LETTERS_FAILED                              = 0x00000072U,
    CONFIG_LIST_FAILED                                       = 0x00000073U,
    BAD_SYSTEM_CONFIG_INFO                                   = 0x00000074U,
    CANNOT_WRITE_CONFIGURATION                               = 0x00000075U,
    PROCESS_HAS_LOCKED_PAGES                                 = 0x00000076U,
    KERNEL_STACK_INPAGE_ERROR                                = 0x00000077U,
    PHASE0_EXCEPTION                                         = 0x00000078U,
    MISMATCHED_HAL                                           = 0x00000079U,
    KERNEL_DATA_INPAGE_ERROR                                 = 0x0000007aU,
    INACCESSIBLE_BOOT_DEVICE                                 = 0x0000007bU,
    BUGCODE_NDIS_DRIVER                                      = 0x0000007cU,
    INSTALL_MORE_MEMORY                                      = 0x0000007dU,
    SYSTEM_THREAD_EXCEPTION_NOT_HANDLED                      = 0x0000007eU,
    SYSTEM_THREAD_EXCEPTION_NOT_HANDLED_M                    = 0x1000007eU,
    UNEXPECTED_KERNEL_MODE_TRAP                              = 0x0000007fU,
    UNEXPECTED_KERNEL_MODE_TRAP_M                            = 0x1000007fU,
    NMI_HARDWARE_FAILURE                                     = 0x00000080U,
    SPIN_LOCK_INIT_FAILURE                                   = 0x00000081U,
    DFS_FILE_SYSTEM                                          = 0x00000082U,
    OFS_FILE_SYSTEM                                          = 0x00000083U,
    RECOM_DRIVER                                             = 0x00000084U,
    SETUP_FAILURE                                            = 0x00000085U,
    AUDIT_FAILURE                                            = 0x00000086U,
    MBR_CHECKSUM_MISMATCH                                    = 0x0000008bU,
    KERNEL_MODE_EXCEPTION_NOT_HANDLED                        = 0x0000008eU,
    KERNEL_MODE_EXCEPTION_NOT_HANDLED_M                      = 0x1000008eU,
    PP0_INITIALIZATION_FAILED                                = 0x0000008fU,
    PP1_INITIALIZATION_FAILED                                = 0x00000090U,
    WIN32K_INIT_OR_RIT_FAILURE                               = 0x00000091U,
    UP_DRIVER_ON_MP_SYSTEM                                   = 0x00000092U,
    INVALID_KERNEL_HANDLE                                    = 0x00000093U,
    KERNEL_STACK_LOCKED_AT_EXIT                              = 0x00000094U,
    PNP_INTERNAL_ERROR                                       = 0x00000095U,
    INVALID_WORK_QUEUE_ITEM                                  = 0x00000096U,
    BOUND_IMAGE_UNSUPPORTED                                  = 0x00000097U,
    END_OF_NT_EVALUATION_PERIOD                              = 0x00000098U,
    INVALID_REGION_OR_SEGMENT                                = 0x00000099U,
    SYSTEM_LICENSE_VIOLATION                                 = 0x0000009aU,
    UDFS_FILE_SYSTEM                                         = 0x0000009bU,
    MACHINE_CHECK_EXCEPTION                                  = 0x0000009cU,
    USER_MODE_HEALTH_MONITOR                                 = 0x0000009eU,
    DRIVER_POWER_STATE_FAILURE                               = 0x0000009fU,
    INTERNAL_POWER_ERROR                                     = 0x000000a0U,
    PCI_BUS_DRIVER_INTERNAL                                  = 0x000000a1U,
    MEMORY_IMAGE_CORRUPT                                     = 0x000000a2U,
    ACPI_DRIVER_INTERNAL                                     = 0x000000a3U,
    CNSS_FILE_SYSTEM_FILTER                                  = 0x000000a4U,
    ACPI_BIOS_ERROR                                          = 0x000000a5U,
    FP_EMULATION_ERROR                                       = 0x000000a6U,
    BAD_EXHANDLE                                             = 0x000000a7U,
    BOOTING_IN_SAFEMODE_MINIMAL                              = 0x000000a8U,
    BOOTING_IN_SAFEMODE_NETWORK                              = 0x000000a9U,
    BOOTING_IN_SAFEMODE_DSREPAIR                             = 0x000000aaU,
    SESSION_HAS_VALID_POOL_ON_EXIT                           = 0x000000abU,
    HAL_MEMORY_ALLOCATION                                    = 0x000000acU,
    VIDEO_DRIVER_DEBUG_REPORT_REQUEST                        = 0x400000adU,
    BGI_DETECTED_VIOLATION                                   = 0x000000b1U,
    VIDEO_DRIVER_INIT_FAILURE                                = 0x000000b4U,
    BOOTLOG_LOADED                                           = 0x000000b5U,
    BOOTLOG_NOT_LOADED                                       = 0x000000b6U,
    BOOTLOG_ENABLED                                          = 0x000000b7U,
    ATTEMPTED_SWITCH_FROM_DPC                                = 0x000000b8U,
    CHIPSET_DETECTED_ERROR                                   = 0x000000b9U,
    SESSION_HAS_VALID_VIEWS_ON_EXIT                          = 0x000000baU,
    NETWORK_BOOT_INITIALIZATION_FAILED                       = 0x000000bbU,
    NETWORK_BOOT_DUPLICATE_ADDRESS                           = 0x000000bcU,
    INVALID_HIBERNATED_STATE                                 = 0x000000bdU,
    ATTEMPTED_WRITE_TO_READONLY_MEMORY                       = 0x000000beU,
    MUTEX_ALREADY_OWNED                                      = 0x000000bfU,
    PCI_CONFIG_SPACE_ACCESS_FAILURE                          = 0x000000c0U,
    SPECIAL_POOL_DETECTED_MEMORY_CORRUPTION                  = 0x000000c1U,
    BAD_POOL_CALLER                                          = 0x000000c2U,
    SYSTEM_IMAGE_BAD_SIGNATURE                               = 0x000000c3U,
    DRIVER_VERIFIER_DETECTED_VIOLATION                       = 0x000000c4U,
    DRIVER_CORRUPTED_EXPOOL                                  = 0x000000c5U,
    DRIVER_CAUGHT_MODIFYING_FREED_POOL                       = 0x000000c6U,
    TIMER_OR_DPC_INVALID                                     = 0x000000c7U,
    IRQL_UNEXPECTED_VALUE                                    = 0x000000c8U,
    DRIVER_VERIFIER_IOMANAGER_VIOLATION                      = 0x000000c9U,
    PNP_DETECTED_FATAL_ERROR                                 = 0x000000caU,
    DRIVER_LEFT_LOCKED_PAGES_IN_PROCESS                      = 0x000000cbU,
    PAGE_FAULT_IN_FREED_SPECIAL_POOL                         = 0x000000ccU,
    PAGE_FAULT_BEYOND_END_OF_ALLOCATION                      = 0x000000cdU,
    DRIVER_UNLOADED_WITHOUT_CANCELLING_PENDING_OPERATIONS    = 0x000000ceU,
    TERMINAL_SERVER_DRIVER_MADE_INCORRECT_MEMORY_REFERENCE   = 0x000000cfU,
    DRIVER_CORRUPTED_MMPOOL                                  = 0x000000d0U,
    DRIVER_IRQL_NOT_LESS_OR_EQUAL                            = 0x000000d1U,
    BUGCODE_ID_DRIVER                                        = 0x000000d2U,
    DRIVER_PORTION_MUST_BE_NONPAGED                          = 0x000000d3U,
    SYSTEM_SCAN_AT_RAISED_IRQL_CAUGHT_IMPROPER_DRIVER_UNLOAD = 0x000000d4U,
    DRIVER_PAGE_FAULT_IN_FREED_SPECIAL_POOL                  = 0x000000d5U,
    DRIVER_PAGE_FAULT_BEYOND_END_OF_ALLOCATION               = 0x000000d6U,
    DRIVER_PAGE_FAULT_BEYOND_END_OF_ALLOCATION_M             = 0x100000d6U,
    DRIVER_UNMAPPING_INVALID_VIEW                            = 0x000000d7U,
    DRIVER_USED_EXCESSIVE_PTES                               = 0x000000d8U,
    LOCKED_PAGES_TRACKER_CORRUPTION                          = 0x000000d9U,
    SYSTEM_PTE_MISUSE                                        = 0x000000daU,
    DRIVER_CORRUPTED_SYSPTES                                 = 0x000000dbU,
    DRIVER_INVALID_STACK_ACCESS                              = 0x000000dcU,
    POOL_CORRUPTION_IN_FILE_AREA                             = 0x000000deU,
    IMPERSONATING_WORKER_THREAD                              = 0x000000dfU,
    ACPI_BIOS_FATAL_ERROR                                    = 0x000000e0U,
    WORKER_THREAD_RETURNED_AT_BAD_IRQL                       = 0x000000e1U,
    MANUALLY_INITIATED_CRASH                                 = 0x000000e2U,
    RESOURCE_NOT_OWNED                                       = 0x000000e3U,
    WORKER_INVALID                                           = 0x000000e4U,
    POWER_FAILURE_SIMULATE                                   = 0x000000e5U,
    DRIVER_VERIFIER_DMA_VIOLATION                            = 0x000000e6U,
    INVALID_FLOATING_POINT_STATE                             = 0x000000e7U,
    INVALID_CANCEL_OF_FILE_OPEN                              = 0x000000e8U,
    ACTIVE_EX_WORKER_THREAD_TERMINATION                      = 0x000000e9U,
    SAVER_UNSPECIFIED                                        = 0x0000f000U,
    SAVER_BLANKSCREEN                                        = 0x0000f002U,
    SAVER_INPUT                                              = 0x0000f003U,
    SAVER_WATCHDOG                                           = 0x0000f004U,
    SAVER_STARTNOTVISIBLE                                    = 0x0000f005U,
    SAVER_NAVIGATIONMODEL                                    = 0x0000f006U,
    SAVER_OUTOFMEMORY                                        = 0x0000f007U,
    SAVER_GRAPHICS                                           = 0x0000f008U,
    SAVER_NAVSERVERTIMEOUT                                   = 0x0000f009U,
    SAVER_CHROMEPROCESSCRASH                                 = 0x0000f00aU,
    SAVER_NOTIFICATIONDISMISSAL                              = 0x0000f00bU,
    SAVER_SPEECHDISMISSAL                                    = 0x0000f00cU,
    SAVER_CALLDISMISSAL                                      = 0x0000f00dU,
    SAVER_APPBARDISMISSAL                                    = 0x0000f00eU,
    SAVER_RILADAPTATIONCRASH                                 = 0x0000f00fU,
    SAVER_APPLISTUNREACHABLE                                 = 0x0000f010U,
    SAVER_REPORTNOTIFICATIONFAILURE                          = 0x0000f011U,
    SAVER_UNEXPECTEDSHUTDOWN                                 = 0x0000f012U,
    SAVER_RPCFAILURE                                         = 0x0000f013U,
    SAVER_AUXILIARYFULLDUMP                                  = 0x0000f014U,
    SAVER_ACCOUNTPROVSVCINITFAILURE                          = 0x0000f015U,
    SAVER_MTBFCOMMANDTIMEOUT                                 = 0x00000315U,
    SAVER_MTBFCOMMANDHANG                                    = 0x0000f101U,
    SAVER_MTBFPASSBUGCHECK                                   = 0x0000f102U,
    SAVER_MTBFIOERROR                                        = 0x0000f103U,
    SAVER_RENDERTHREADHANG                                   = 0x0000f200U,
    SAVER_RENDERMOBILEUIOOM                                  = 0x0000f201U,
    SAVER_DEVICEUPDATEUNSPECIFIED                            = 0x0000f300U,
    SAVER_AUDIODRIVERHANG                                    = 0x0000f400U,
    SAVER_BATTERYPULLOUT                                     = 0x0000f500U,
    SAVER_MEDIACORETESTHANG                                  = 0x0000f600U,
    SAVER_RESOURCEMANAGEMENT                                 = 0x0000f700U,
    SAVER_CAPTURESERVICE                                     = 0x0000f800U,
    SAVER_WAITFORSHELLREADY                                  = 0x0000f900U,
    SAVER_NONRESPONSIVEPROCESS                               = 0x00000194U,
    SAVER_SICKAPPLICATION                                    = 0x00008866U,
    THREAD_STUCK_IN_DEVICE_DRIVER                            = 0x000000eaU,
    THREAD_STUCK_IN_DEVICE_DRIVER_M                          = 0x100000eaU,
    DIRTY_MAPPED_PAGES_CONGESTION                            = 0x000000ebU,
    SESSION_HAS_VALID_SPECIAL_POOL_ON_EXIT                   = 0x000000ecU,
    UNMOUNTABLE_BOOT_VOLUME                                  = 0x000000edU,
    CRITICAL_PROCESS_DIED                                    = 0x000000efU,
    STORAGE_MINIPORT_ERROR                                   = 0x000000f0U,
    SCSI_VERIFIER_DETECTED_VIOLATION                         = 0x000000f1U,
    HARDWARE_INTERRUPT_STORM                                 = 0x000000f2U,
    DISORDERLY_SHUTDOWN                                      = 0x000000f3U,
    CRITICAL_OBJECT_TERMINATION                              = 0x000000f4U,
    FLTMGR_FILE_SYSTEM                                       = 0x000000f5U,
    PCI_VERIFIER_DETECTED_VIOLATION                          = 0x000000f6U,
    DRIVER_OVERRAN_STACK_BUFFER                              = 0x000000f7U,
    RAMDISK_BOOT_INITIALIZATION_FAILED                       = 0x000000f8U,
    DRIVER_RETURNED_STATUS_REPARSE_FOR_VOLUME_OPEN           = 0x000000f9U,
    HTTP_DRIVER_CORRUPTED                                    = 0x000000faU,
    RECURSIVE_MACHINE_CHECK                                  = 0x000000fbU,
    ATTEMPTED_EXECUTE_OF_NOEXECUTE_MEMORY                    = 0x000000fcU,
    DIRTY_NOWRITE_PAGES_CONGESTION                           = 0x000000fdU,
    BUGCODE_USB_DRIVER                                       = 0x000000feU,
    BC_BLUETOOTH_VERIFIER_FAULT                              = 0x00000bfeU,
    BC_BTHMINI_VERIFIER_FAULT                                = 0x00000bffU,
    RESERVE_QUEUE_OVERFLOW                                   = 0x000000ffU,
    LOADER_BLOCK_MISMATCH                                    = 0x00000100U,
    CLOCK_WATCHDOG_TIMEOUT                                   = 0x00000101U,
    DPC_WATCHDOG_TIMEOUT                                     = 0x00000102U,
    MUP_FILE_SYSTEM                                          = 0x00000103U,
    AGP_INVALID_ACCESS                                       = 0x00000104U,
    AGP_GART_CORRUPTION                                      = 0x00000105U,
    AGP_ILLEGALLY_REPROGRAMMED                               = 0x00000106U,
    KERNEL_EXPAND_STACK_ACTIVE                               = 0x00000107U,
    THIRD_PARTY_FILE_SYSTEM_FAILURE                          = 0x00000108U,
    CRITICAL_STRUCTURE_CORRUPTION                            = 0x00000109U,
    APP_TAGGING_INITIALIZATION_FAILED                        = 0x0000010aU,
    DFSC_FILE_SYSTEM                                         = 0x0000010bU,
    FSRTL_EXTRA_CREATE_PARAMETER_VIOLATION                   = 0x0000010cU,
    WDF_VIOLATION                                            = 0x0000010dU,
    VIDEO_MEMORY_MANAGEMENT_INTERNAL                         = 0x0000010eU,
    DRIVER_INVALID_CRUNTIME_PARAMETER                        = 0x00000110U,
    RECURSIVE_NMI                                            = 0x00000111U,
    MSRPC_STATE_VIOLATION                                    = 0x00000112U,
    VIDEO_DXGKRNL_FATAL_ERROR                                = 0x00000113U,
    VIDEO_SHADOW_DRIVER_FATAL_ERROR                          = 0x00000114U,
    AGP_INTERNAL                                             = 0x00000115U,
    VIDEO_TDR_FAILURE                                        = 0x00000116U,
    VIDEO_TDR_TIMEOUT_DETECTED                               = 0x00000117U,
    NTHV_GUEST_ERROR                                         = 0x00000118U,
    VIDEO_SCHEDULER_INTERNAL_ERROR                           = 0x00000119U,
    EM_INITIALIZATION_ERROR                                  = 0x0000011aU,
    DRIVER_RETURNED_HOLDING_CANCEL_LOCK                      = 0x0000011bU,
    ATTEMPTED_WRITE_TO_CM_PROTECTED_STORAGE                  = 0x0000011cU,
    EVENT_TRACING_FATAL_ERROR                                = 0x0000011dU,
    TOO_MANY_RECURSIVE_FAULTS                                = 0x0000011eU,
    INVALID_DRIVER_HANDLE                                    = 0x0000011fU,
    BITLOCKER_FATAL_ERROR                                    = 0x00000120U,
    DRIVER_VIOLATION                                         = 0x00000121U,
    WHEA_INTERNAL_ERROR                                      = 0x00000122U,
    CRYPTO_SELF_TEST_FAILURE                                 = 0x00000123U,
    WHEA_UNCORRECTABLE_ERROR                                 = 0x00000124U,
    NMR_INVALID_STATE                                        = 0x00000125U,
    NETIO_INVALID_POOL_CALLER                                = 0x00000126U,
    PAGE_NOT_ZERO                                            = 0x00000127U,
    WORKER_THREAD_RETURNED_WITH_BAD_IO_PRIORITY              = 0x00000128U,
    WORKER_THREAD_RETURNED_WITH_BAD_PAGING_IO_PRIORITY       = 0x00000129U,
    MUI_NO_VALID_SYSTEM_LANGUAGE                             = 0x0000012aU,
    FAULTY_HARDWARE_CORRUPTED_PAGE                           = 0x0000012bU,
    EXFAT_FILE_SYSTEM                                        = 0x0000012cU,
    VOLSNAP_OVERLAPPED_TABLE_ACCESS                          = 0x0000012dU,
    INVALID_MDL_RANGE                                        = 0x0000012eU,
    VHD_BOOT_INITIALIZATION_FAILED                           = 0x0000012fU,
    DYNAMIC_ADD_PROCESSOR_MISMATCH                           = 0x00000130U,
    INVALID_EXTENDED_PROCESSOR_STATE                         = 0x00000131U,
    RESOURCE_OWNER_POINTER_INVALID                           = 0x00000132U,
    DPC_WATCHDOG_VIOLATION                                   = 0x00000133U,
    DRIVE_EXTENDER                                           = 0x00000134U,
    REGISTRY_FILTER_DRIVER_EXCEPTION                         = 0x00000135U,
    VHD_BOOT_HOST_VOLUME_NOT_ENOUGH_SPACE                    = 0x00000136U,
    WIN32K_HANDLE_MANAGER                                    = 0x00000137U,
    GPIO_CONTROLLER_DRIVER_ERROR                             = 0x00000138U,
    KERNEL_SECURITY_CHECK_FAILURE                            = 0x00000139U,
    KERNEL_MODE_HEAP_CORRUPTION                              = 0x0000013aU,
    PASSIVE_INTERRUPT_ERROR                                  = 0x0000013bU,
    INVALID_IO_BOOST_STATE                                   = 0x0000013cU,
    CRITICAL_INITIALIZATION_FAILURE                          = 0x0000013dU,
    ERRATA_WORKAROUND_UNSUCCESSFUL                           = 0x0000013eU,
    REGISTRY_CALLBACK_DRIVER_EXCEPTION                       = 0x0000013fU,
    STORAGE_DEVICE_ABNORMALITY_DETECTED                      = 0x00000140U,
    VIDEO_ENGINE_TIMEOUT_DETECTED                            = 0x00000141U,
    VIDEO_TDR_APPLICATION_BLOCKED                            = 0x00000142U,
    PROCESSOR_DRIVER_INTERNAL                                = 0x00000143U,
    BUGCODE_USB3_DRIVER                                      = 0x00000144U,
    SECURE_BOOT_VIOLATION                                    = 0x00000145U,
    NDIS_NET_BUFFER_LIST_INFO_ILLEGALLY_TRANSFERRED          = 0x00000146U,
    ABNORMAL_RESET_DETECTED                                  = 0x00000147U,
    IO_OBJECT_INVALID                                        = 0x00000148U,
    REFS_FILE_SYSTEM                                         = 0x00000149U,
    KERNEL_WMI_INTERNAL                                      = 0x0000014aU,
    SOC_SUBSYSTEM_FAILURE                                    = 0x0000014bU,
    FATAL_ABNORMAL_RESET_ERROR                               = 0x0000014cU,
    EXCEPTION_SCOPE_INVALID                                  = 0x0000014dU,
    SOC_CRITICAL_DEVICE_REMOVED                              = 0x0000014eU,
    PDC_WATCHDOG_TIMEOUT                                     = 0x0000014fU,
    TCPIP_AOAC_NIC_ACTIVE_REFERENCE_LEAK                     = 0x00000150U,
    UNSUPPORTED_INSTRUCTION_MODE                             = 0x00000151U,
    INVALID_PUSH_LOCK_FLAGS                                  = 0x00000152U,
    KERNEL_LOCK_ENTRY_LEAKED_ON_THREAD_TERMINATION           = 0x00000153U,
    UNEXPECTED_STORE_EXCEPTION                               = 0x00000154U,
    OS_DATA_TAMPERING                                        = 0x00000155U,
    WINSOCK_DETECTED_HUNG_CLOSESOCKET_LIVEDUMP               = 0x00000156U,
    KERNEL_THREAD_PRIORITY_FLOOR_VIOLATION                   = 0x00000157U,
    ILLEGAL_IOMMU_PAGE_FAULT                                 = 0x00000158U,
    HAL_ILLEGAL_IOMMU_PAGE_FAULT                             = 0x00000159U,
    SDBUS_INTERNAL_ERROR                                     = 0x0000015aU,
    WORKER_THREAD_RETURNED_WITH_SYSTEM_PAGE_PRIORITY_ACTIVE  = 0x0000015bU,
    PDC_WATCHDOG_TIMEOUT_LIVEDUMP                            = 0x0000015cU,
    SOC_SUBSYSTEM_FAILURE_LIVEDUMP                           = 0x0000015dU,
    BUGCODE_NDIS_DRIVER_LIVE_DUMP                            = 0x0000015eU,
    CONNECTED_STANDBY_WATCHDOG_TIMEOUT_LIVEDUMP              = 0x0000015fU,
    WIN32K_ATOMIC_CHECK_FAILURE                              = 0x00000160U,
    LIVE_SYSTEM_DUMP                                         = 0x00000161U,
    KERNEL_AUTO_BOOST_INVALID_LOCK_RELEASE                   = 0x00000162U,
    WORKER_THREAD_TEST_CONDITION                             = 0x00000163U,
    WIN32K_CRITICAL_FAILURE                                  = 0x00000164U,
    CLUSTER_CSV_STATUS_IO_TIMEOUT_LIVEDUMP                   = 0x00000165U,
    CLUSTER_RESOURCE_CALL_TIMEOUT_LIVEDUMP                   = 0x00000166U,
    CLUSTER_CSV_SNAPSHOT_DEVICE_INFO_TIMEOUT_LIVEDUMP        = 0x00000167U,
    CLUSTER_CSV_STATE_TRANSITION_TIMEOUT_LIVEDUMP            = 0x00000168U,
    CLUSTER_CSV_VOLUME_ARRIVAL_LIVEDUMP                      = 0x00000169U,
    CLUSTER_CSV_VOLUME_REMOVAL_LIVEDUMP                      = 0x0000016aU,
    CLUSTER_CSV_CLUSTER_WATCHDOG_LIVEDUMP                    = 0x0000016bU,
    INVALID_RUNDOWN_PROTECTION_FLAGS                         = 0x0000016cU,
    INVALID_SLOT_ALLOCATOR_FLAGS                             = 0x0000016dU,
    ERESOURCE_INVALID_RELEASE                                = 0x0000016eU,
    CLUSTER_CSV_STATE_TRANSITION_INTERVAL_TIMEOUT_LIVEDUMP   = 0x0000016fU,
    CLUSTER_CSV_CLUSSVC_DISCONNECT_WATCHDOG                  = 0x00000170U,
    CRYPTO_LIBRARY_INTERNAL_ERROR                            = 0x00000171U,
    SECURE_KERNEL_HIBERNATE_ERROR                            = 0x00000172U,
    COREMSGCALL_INTERNAL_ERROR                               = 0x00000173U,
    COREMSG_INTERNAL_ERROR                                   = 0x00000174U,
    PREVIOUS_FATAL_ABNORMAL_RESET_ERROR                      = 0x00000175U,
    STORAGE_STACK_FATAL_ERROR                                = 0x00000176U,
    ELAM_DRIVER_DETECTED_FATAL_ERROR                         = 0x00000178U,
    CLUSTER_CLUSPORT_STATUS_IO_TIMEOUT_LIVEDUMP              = 0x00000179U,
    PROFILER_CONFIGURATION_ILLEGAL                           = 0x0000017bU,
    PDC_LOCK_WATCHDOG_LIVEDUMP                               = 0x0000017cU,
    PDC_UNEXPECTED_REVOCATION_LIVEDUMP                       = 0x0000017dU,
    MICROCODE_REVISION_MISMATCH                              = 0x0000017eU,
    HYPERGUARD_INITIALIZATION_FAILURE                        = 0x0000017fU,
    WVR_LIVEDUMP_REPLICATION_IOCONTEXT_TIMEOUT               = 0x00000180U,
    WVR_LIVEDUMP_STATE_TRANSITION_TIMEOUT                    = 0x00000181U,
    WVR_LIVEDUMP_RECOVERY_IOCONTEXT_TIMEOUT                  = 0x00000182U,
    WVR_LIVEDUMP_APP_IO_TIMEOUT                              = 0x00000183U,
    WVR_LIVEDUMP_MANUALLY_INITIATED                          = 0x00000184U,
    WVR_LIVEDUMP_STATE_FAILURE                               = 0x00000185U,
    WVR_LIVEDUMP_CRITICAL_ERROR                              = 0x00000186U,
    VIDEO_DWMINIT_TIMEOUT_FALLBACK_BDD                       = 0x00000187U,
    CLUSTER_CSVFS_LIVEDUMP                                   = 0x00000188U,
    BAD_OBJECT_HEADER                                        = 0x00000189U,
    SILO_CORRUPT                                             = 0x0000018aU,
    SECURE_KERNEL_ERROR                                      = 0x0000018bU,
    HYPERGUARD_VIOLATION                                     = 0x0000018cU,
    SECURE_FAULT_UNHANDLED                                   = 0x0000018dU,
    KERNEL_PARTITION_REFERENCE_VIOLATION                     = 0x0000018eU,
    SYNTHETIC_EXCEPTION_UNHANDLED                            = 0x0000018fU,
    WIN32K_CRITICAL_FAILURE_LIVEDUMP                         = 0x00000190U,
    PF_DETECTED_CORRUPTION                                   = 0x00000191U,
    KERNEL_AUTO_BOOST_LOCK_ACQUISITION_WITH_RAISED_IRQL      = 0x00000192U,
    VIDEO_DXGKRNL_LIVEDUMP                                   = 0x00000193U,
    KERNEL_STORAGE_SLOT_IN_USE                               = 0x00000199U,
    SMB_SERVER_LIVEDUMP                                      = 0x00000195U,
    LOADER_ROLLBACK_DETECTED                                 = 0x00000196U,
    WIN32K_SECURITY_FAILURE                                  = 0x00000197U,
    UFX_LIVEDUMP                                             = 0x00000198U,
    WORKER_THREAD_RETURNED_WHILE_ATTACHED_TO_SILO            = 0x0000019aU,
    TTM_FATAL_ERROR                                          = 0x0000019bU,
    WIN32K_POWER_WATCHDOG_TIMEOUT                            = 0x0000019cU,
    CLUSTER_SVHDX_LIVEDUMP                                   = 0x0000019dU,
    BUGCODE_NETADAPTER_DRIVER                                = 0x0000019eU,
    PDC_PRIVILEGE_CHECK_LIVEDUMP                             = 0x0000019fU,
    TTM_WATCHDOG_TIMEOUT                                     = 0x000001a0U,
    WIN32K_CALLOUT_WATCHDOG_LIVEDUMP                         = 0x000001a1U,
    WIN32K_CALLOUT_WATCHDOG_BUGCHECK                         = 0x000001a2U,
    CALL_HAS_NOT_RETURNED_WATCHDOG_TIMEOUT_LIVEDUMP          = 0x000001a3U,
    DRIPS_SW_HW_DIVERGENCE_LIVEDUMP                          = 0x000001a4U,
    USB_DRIPS_BLOCKER_SURPRISE_REMOVAL_LIVEDUMP              = 0x000001a5U,
    BLUETOOTH_ERROR_RECOVERY_LIVEDUMP                        = 0x000001a6U,
    SMB_REDIRECTOR_LIVEDUMP                                  = 0x000001a7U,
    VIDEO_DXGKRNL_BLACK_SCREEN_LIVEDUMP                      = 0x000001a8U,
    DIRECTED_FX_TRANSITION_LIVEDUMP                          = 0x000001a9U,
    EXCEPTION_ON_INVALID_STACK                               = 0x000001aaU,
    UNWIND_ON_INVALID_STACK                                  = 0x000001abU,
    VIDEO_MINIPORT_FAILED_LIVEDUMP                           = 0x000001b0U,
    VIDEO_MINIPORT_BLACK_SCREEN_LIVEDUMP                     = 0x000001b8U,
    DRIVER_VERIFIER_DETECTED_VIOLATION_LIVEDUMP              = 0x000001c4U,
    IO_THREADPOOL_DEADLOCK_LIVEDUMP                          = 0x000001c5U,
    FAST_ERESOURCE_PRECONDITION_VIOLATION                    = 0x000001c6U,
    STORE_DATA_STRUCTURE_CORRUPTION                          = 0x000001c7U,
    MANUALLY_INITIATED_POWER_BUTTON_HOLD                     = 0x000001c8U,
    USER_MODE_HEALTH_MONITOR_LIVEDUMP                        = 0x000001c9U,
    SYNTHETIC_WATCHDOG_TIMEOUT                               = 0x000001caU,
    INVALID_SILO_DETACH                                      = 0x000001cbU,
    EXRESOURCE_TIMEOUT_LIVEDUMP                              = 0x000001ccU,
    INVALID_CALLBACK_STACK_ADDRESS                           = 0x000001cdU,
    INVALID_KERNEL_STACK_ADDRESS                             = 0x000001ceU,
    HARDWARE_WATCHDOG_TIMEOUT                                = 0x000001cfU,
    ACPI_FIRMWARE_WATCHDOG_TIMEOUT                           = 0x000001d0U,
    TELEMETRY_ASSERTS_LIVEDUMP                               = 0x000001d1U,
    WORKER_THREAD_INVALID_STATE                              = 0x000001d2U,
    WFP_INVALID_OPERATION                                    = 0x000001d3U,
    UCMUCSI_LIVEDUMP                                         = 0x000001d4U,
    DRIVER_PNP_WATCHDOG                                      = 0x000001d5U,
    WORKER_THREAD_RETURNED_WITH_NON_DEFAULT_WORKLOAD_CLASS   = 0x000001d6U,
    EFS_FATAL_ERROR                                          = 0x000001d7U,
    UCMUCSI_FAILURE                                          = 0x000001d8U,
    HAL_IOMMU_INTERNAL_ERROR                                 = 0x000001d9U,
    HAL_BLOCKED_PROCESSOR_INTERNAL_ERROR                     = 0x000001daU,
    IPI_WATCHDOG_TIMEOUT                                     = 0x000001dbU,
    DMA_COMMON_BUFFER_VECTOR_ERROR                           = 0x000001dcU,
    BUGCODE_MBBADAPTER_DRIVER                                = 0x000001ddU,
    BUGCODE_WIFIADAPTER_DRIVER                               = 0x000001deU,
    PROCESSOR_START_TIMEOUT                                  = 0x000001dfU,
    INVALID_ALTERNATE_SYSTEM_CALL_HANDLER_REGISTRATION       = 0x000001e0U,
    DEVICE_DIAGNOSTIC_LOG_LIVEDUMP                           = 0x000001e1U,
    AZURE_DEVICE_FW_DUMP                                     = 0x000001e2U,
    BREAKAWAY_CABLE_TRANSITION                               = 0x000001e3U,
    VIDEO_DXGKRNL_SYSMM_FATAL_ERROR                          = 0x000001e4U,
    DRIVER_VERIFIER_TRACKING_LIVE_DUMP                       = 0x000001e5U,
    CRASHDUMP_WATCHDOG_TIMEOUT                               = 0x000001e6U,
    REGISTRY_LIVE_DUMP                                       = 0x000001e7U,
    INVALID_THREAD_AFFINITY_STATE                            = 0x000001e8U,
    ILLEGAL_ATS_INITIALIZATION                               = 0x000001e9U,
    SECURE_PCI_CONFIG_SPACE_ACCESS_VIOLATION                 = 0x000001eaU,
    DAM_WATCHDOG_TIMEOUT                                     = 0x000001ebU,
    HANDLE_LIVE_DUMP                                         = 0x000001ecU,
    HANDLE_ERROR_ON_CRITICAL_THREAD                          = 0x000001edU,
    MPSDRV_QUERY_USER                                        = 0x400001eeU,
    VMBUS_LIVEDUMP                                           = 0x400001efU,
    USB4_HARDWARE_VIOLATION                                  = 0x000001f0U,
    KASAN_ENLIGHTENMENT_VIOLATION                            = 0x000001f1U,
    KASAN_ILLEGAL_ACCESS                                     = 0x000001f2U,
    IORING                                                   = 0x000001f3U,
    MDL_CACHE                                                = 0x000001f4U,
    APPLICATION_HANG_KERNEL_LIVEDUMP                         = 0x000001f5U,
    MISALIGNED_POINTER_PARAMETER                             = 0x000001f6U,
    MSSECCORE_ASSERTION_FAILURE                              = 0x000001f7U,
    INVALID_MINIMAL_PROCESS_STATE                            = 0x000001f8U,
    PREVIOUS_MODE_MISMATCH                                   = 0x000001f9U,
    SMB_SRV_REQUEST_VALIDATION_FAILURE                       = 0x000001faU,
    IOMMU_INTERRUPT_REMAPPING_FAULT                          = 0x000001fbU,
    WIN32K_CALLOUT_UNREGISTER_FAILED                         = 0x000001fcU,
    HAL_SPE_INTERNAL_ERROR                                   = 0x000001fdU,
    SMB_CLIENT_REQUEST_VALIDATION_FAILURE                    = 0x000001feU,
    CPU_SCHEDULER_INTERNAL_ERROR                             = 0x00000200U,
    PROCESS_TERMINATE_LIKELY_DEADLOCK                        = 0x00000201U,
    UNEXPECTED_CODEPATH                                      = 0x00000202U,
    INVALID_EXTENSION_STATE                                  = 0x00000203U,
    STORAGE_DRIVER_LIVEDUMP                                  = 0x00000207U,
    XBOX_VMCTRL_CS_TIMEOUT                                   = 0x00000356U,
    XBOX_CORRUPTED_IMAGE                                     = 0x00000357U,
    XBOX_INVERTED_FUNCTION_TABLE_OVERFLOW                    = 0x00000358U,
    XBOX_CORRUPTED_IMAGE_BASE                                = 0x00000359U,
    XBOX_XDS_WATCHDOG_TIMEOUT                                = 0x0000035aU,
    XBOX_SHUTDOWN_WATCHDOG_TIMEOUT                           = 0x0000035bU,
    XBOX_CANNOT_MANAGE_PARTITION_MEMORY                      = 0x0000035dU,
    XBOX_360_SYSTEM_CRASH                                    = 0x00000360U,
    XBOX_360_SYSTEM_CRASH_RESERVED                           = 0x00000420U,
    XBOX_SECURITY_FAILUE                                     = 0x00000421U,
    KERNEL_CFG_INIT_FAILURE                                  = 0x00000422U,
    MANUALLY_INITIATED_POWER_BUTTON_HOLD_LIVE_DUMP           = 0x000011c8U,
    HYPERVISOR_ERROR                                         = 0x00020001U,
    XBOX_MANUALLY_INITIATED_CRASH                            = 0x00030006U,
    MANUALLY_INITIATED_BLACKSCREEN_HOTKEY_LIVE_DUMP          = 0x000021c8U,
    WINLOGON_FATAL_ERROR                                     = 0xc000021aU,
    MANUALLY_INITIATED_CRASH1                                = 0xdeaddeadU,
    BUGCHECK_CONTEXT_MODIFIER                                = 0x80000000U,
}

alias FACILITY_CODE = uint;
enum : uint
{
    FACILITY_NULL                                     = 0x00000000U,
    FACILITY_RPC                                      = 0x00000001U,
    FACILITY_DISPATCH                                 = 0x00000002U,
    FACILITY_STORAGE                                  = 0x00000003U,
    FACILITY_ITF                                      = 0x00000004U,
    FACILITY_WIN32                                    = 0x00000007U,
    FACILITY_WINDOWS                                  = 0x00000008U,
    FACILITY_SSPI                                     = 0x00000009U,
    FACILITY_SECURITY                                 = 0x00000009U,
    FACILITY_CONTROL                                  = 0x0000000aU,
    FACILITY_CERT                                     = 0x0000000bU,
    FACILITY_INTERNET                                 = 0x0000000cU,
    FACILITY_MEDIASERVER                              = 0x0000000dU,
    FACILITY_MSMQ                                     = 0x0000000eU,
    FACILITY_SETUPAPI                                 = 0x0000000fU,
    FACILITY_SCARD                                    = 0x00000010U,
    FACILITY_COMPLUS                                  = 0x00000011U,
    FACILITY_AAF                                      = 0x00000012U,
    FACILITY_URT                                      = 0x00000013U,
    FACILITY_ACS                                      = 0x00000014U,
    FACILITY_DPLAY                                    = 0x00000015U,
    FACILITY_UMI                                      = 0x00000016U,
    FACILITY_SXS                                      = 0x00000017U,
    FACILITY_WINDOWS_CE                               = 0x00000018U,
    FACILITY_HTTP                                     = 0x00000019U,
    FACILITY_USERMODE_COMMONLOG                       = 0x0000001aU,
    FACILITY_WER                                      = 0x0000001bU,
    FACILITY_USERMODE_FILTER_MANAGER                  = 0x0000001fU,
    FACILITY_BACKGROUNDCOPY                           = 0x00000020U,
    FACILITY_CONFIGURATION                            = 0x00000021U,
    FACILITY_WIA                                      = 0x00000021U,
    FACILITY_STATE_MANAGEMENT                         = 0x00000022U,
    FACILITY_METADIRECTORY                            = 0x00000023U,
    FACILITY_WINDOWSUPDATE                            = 0x00000024U,
    FACILITY_DIRECTORYSERVICE                         = 0x00000025U,
    FACILITY_GRAPHICS                                 = 0x00000026U,
    FACILITY_SHELL                                    = 0x00000027U,
    FACILITY_NAP                                      = 0x00000027U,
    FACILITY_TPM_SERVICES                             = 0x00000028U,
    FACILITY_TPM_SOFTWARE                             = 0x00000029U,
    FACILITY_UI                                       = 0x0000002aU,
    FACILITY_XAML                                     = 0x0000002bU,
    FACILITY_ACTION_QUEUE                             = 0x0000002cU,
    FACILITY_PLA                                      = 0x00000030U,
    FACILITY_WINDOWS_SETUP                            = 0x00000030U,
    FACILITY_FVE                                      = 0x00000031U,
    FACILITY_FWP                                      = 0x00000032U,
    FACILITY_WINRM                                    = 0x00000033U,
    FACILITY_NDIS                                     = 0x00000034U,
    FACILITY_USERMODE_HYPERVISOR                      = 0x00000035U,
    FACILITY_CMI                                      = 0x00000036U,
    FACILITY_USERMODE_VIRTUALIZATION                  = 0x00000037U,
    FACILITY_USERMODE_VOLMGR                          = 0x00000038U,
    FACILITY_BCD                                      = 0x00000039U,
    FACILITY_USERMODE_VHD                             = 0x0000003aU,
    FACILITY_USERMODE_HNS                             = 0x0000003bU,
    FACILITY_SDIAG                                    = 0x0000003cU,
    FACILITY_WEBSERVICES                              = 0x0000003dU,
    FACILITY_WINPE                                    = 0x0000003dU,
    FACILITY_WPN                                      = 0x0000003eU,
    FACILITY_WINDOWS_STORE                            = 0x0000003fU,
    FACILITY_INPUT                                    = 0x00000040U,
    FACILITY_QUIC                                     = 0x00000041U,
    FACILITY_EAP                                      = 0x00000042U,
    FACILITY_IORING                                   = 0x00000046U,
    FACILITY_WINDOWS_DEFENDER                         = 0x00000050U,
    FACILITY_OPC                                      = 0x00000051U,
    FACILITY_XPS                                      = 0x00000052U,
    FACILITY_MBN                                      = 0x00000054U,
    FACILITY_POWERSHELL                               = 0x00000054U,
    FACILITY_RAS                                      = 0x00000053U,
    FACILITY_P2P_INT                                  = 0x00000062U,
    FACILITY_P2P                                      = 0x00000063U,
    FACILITY_DAF                                      = 0x00000064U,
    FACILITY_BLUETOOTH_ATT                            = 0x00000065U,
    FACILITY_AUDIO                                    = 0x00000066U,
    FACILITY_STATEREPOSITORY                          = 0x00000067U,
    FACILITY_VISUALCPP                                = 0x0000006dU,
    FACILITY_SCRIPT                                   = 0x00000070U,
    FACILITY_PARSE                                    = 0x00000071U,
    FACILITY_BLB                                      = 0x00000078U,
    FACILITY_BLB_CLI                                  = 0x00000079U,
    FACILITY_WSBAPP                                   = 0x0000007aU,
    FACILITY_BLBUI                                    = 0x00000080U,
    FACILITY_USN                                      = 0x00000081U,
    FACILITY_USERMODE_VOLSNAP                         = 0x00000082U,
    FACILITY_TIERING                                  = 0x00000083U,
    FACILITY_WSB_ONLINE                               = 0x00000085U,
    FACILITY_ONLINE_ID                                = 0x00000086U,
    FACILITY_DEVICE_UPDATE_AGENT                      = 0x00000087U,
    FACILITY_DRVSERVICING                             = 0x00000088U,
    FACILITY_DLS                                      = 0x00000099U,
    FACILITY_DELIVERY_OPTIMIZATION                    = 0x000000d0U,
    FACILITY_USERMODE_SPACES                          = 0x000000e7U,
    FACILITY_USER_MODE_SECURITY_CORE                  = 0x000000e8U,
    FACILITY_USERMODE_LICENSING                       = 0x000000eaU,
    FACILITY_SOS                                      = 0x000000a0U,
    FACILITY_OCP_UPDATE_AGENT                         = 0x000000adU,
    FACILITY_DEBUGGERS                                = 0x000000b0U,
    FACILITY_SPP                                      = 0x00000100U,
    FACILITY_RESTORE                                  = 0x00000100U,
    FACILITY_DMSERVER                                 = 0x00000100U,
    FACILITY_DEPLOYMENT_SERVICES_SERVER               = 0x00000101U,
    FACILITY_DEPLOYMENT_SERVICES_IMAGING              = 0x00000102U,
    FACILITY_DEPLOYMENT_SERVICES_MANAGEMENT           = 0x00000103U,
    FACILITY_DEPLOYMENT_SERVICES_UTIL                 = 0x00000104U,
    FACILITY_DEPLOYMENT_SERVICES_BINLSVC              = 0x00000105U,
    FACILITY_DEPLOYMENT_SERVICES_PXE                  = 0x00000107U,
    FACILITY_DEPLOYMENT_SERVICES_TFTP                 = 0x00000108U,
    FACILITY_DEPLOYMENT_SERVICES_TRANSPORT_MANAGEMENT = 0x00000110U,
    FACILITY_DEPLOYMENT_SERVICES_DRIVER_PROVISIONING  = 0x00000116U,
    FACILITY_DEPLOYMENT_SERVICES_MULTICAST_SERVER     = 0x00000121U,
    FACILITY_DEPLOYMENT_SERVICES_MULTICAST_CLIENT     = 0x00000122U,
    FACILITY_DEPLOYMENT_SERVICES_CONTENT_PROVIDER     = 0x00000125U,
    FACILITY_HSP_SERVICES                             = 0x00000128U,
    FACILITY_HSP_SOFTWARE                             = 0x00000129U,
    FACILITY_LINGUISTIC_SERVICES                      = 0x00000131U,
    FACILITY_AUDIOSTREAMING                           = 0x00000446U,
    FACILITY_TTD                                      = 0x000005d2U,
    FACILITY_ACCELERATOR                              = 0x00000600U,
    FACILITY_WMAAECMA                                 = 0x000007ccU,
    FACILITY_DIRECTMUSIC                              = 0x00000878U,
    FACILITY_DIRECT3D10                               = 0x00000879U,
    FACILITY_DXGI                                     = 0x0000087aU,
    FACILITY_DXGI_DDI                                 = 0x0000087bU,
    FACILITY_DIRECT3D11                               = 0x0000087cU,
    FACILITY_DIRECT3D11_DEBUG                         = 0x0000087dU,
    FACILITY_DIRECT3D12                               = 0x0000087eU,
    FACILITY_DIRECT3D12_DEBUG                         = 0x0000087fU,
    FACILITY_DXCORE                                   = 0x00000880U,
    FACILITY_PRESENTATION                             = 0x00000881U,
    FACILITY_LEAP                                     = 0x00000888U,
    FACILITY_AUDCLNT                                  = 0x00000889U,
    FACILITY_WINCODEC_DWRITE_DWM                      = 0x00000898U,
    FACILITY_WINML                                    = 0x00000890U,
    FACILITY_DIRECT2D                                 = 0x00000899U,
    FACILITY_DEFRAG                                   = 0x00000900U,
    FACILITY_USERMODE_SDBUS                           = 0x00000901U,
    FACILITY_JSCRIPT                                  = 0x00000902U,
    FACILITY_PIDGENX                                  = 0x00000a01U,
    FACILITY_EAS                                      = 0x00000055U,
    FACILITY_WEB                                      = 0x00000375U,
    FACILITY_WEB_SOCKET                               = 0x00000376U,
    FACILITY_MOBILE                                   = 0x00000701U,
    FACILITY_SQLITE                                   = 0x000007afU,
    FACILITY_SERVICE_FABRIC                           = 0x000007b0U,
    FACILITY_UTC                                      = 0x000007c5U,
    FACILITY_WEP                                      = 0x00000801U,
    FACILITY_SYNCENGINE                               = 0x00000802U,
    FACILITY_XBOX                                     = 0x00000923U,
    FACILITY_GAME                                     = 0x00000924U,
    FACILITY_USERMODE_UNIONFS                         = 0x00000925U,
    FACILITY_USERMODE_PRM                             = 0x00000926U,
    FACILITY_USERMODE_WIN_ACCEL                       = 0x00000927U,
    FACILITY_PPF                                      = 0x00000928U,
    FACILITY_PIX                                      = 0x00000abcU,
    FACILITY_NT_BIT                                   = 0x10000000U,
}

alias THREAD_ERROR_MODE = uint;
enum : uint
{
    SEM_ALL_ERRORS             = 0x00000000U,
    SEM_FAILCRITICALERRORS     = 0x00000001U,
    SEM_NOGPFAULTERRORBOX      = 0x00000002U,
    SEM_NOOPENFILEERRORBOX     = 0x00008000U,
    SEM_NOALIGNMENTFAULTEXCEPT = 0x00000004U,
}

alias FORMAT_MESSAGE_OPTIONS = uint;
enum : uint
{
    FORMAT_MESSAGE_ALLOCATE_BUFFER = 0x00000100U,
    FORMAT_MESSAGE_ARGUMENT_ARRAY  = 0x00002000U,
    FORMAT_MESSAGE_FROM_HMODULE    = 0x00000800U,
    FORMAT_MESSAGE_FROM_STRING     = 0x00000400U,
    FORMAT_MESSAGE_FROM_SYSTEM     = 0x00001000U,
    FORMAT_MESSAGE_IGNORE_INSERTS  = 0x00000200U,
}

alias RTL_VIRTUAL_UNWIND_HANDLER_TYPE = uint;
enum : uint
{
    UNW_FLAG_NHANDLER  = 0x00000000U,
    UNW_FLAG_EHANDLER  = 0x00000001U,
    UNW_FLAG_UHANDLER  = 0x00000002U,
    UNW_FLAG_CHAININFO = 0x00000004U,
}

alias OPEN_THREAD_WAIT_CHAIN_SESSION_FLAGS = uint;
enum : uint
{
    WCT_ASYNC_OPEN_FLAG = 0x00000001U,
}

alias SYM_SRV_STORE_FILE_FLAGS = uint;
enum : uint
{
    SYMSTOREOPT_COMPRESS       = 0x00000001U,
    SYMSTOREOPT_OVERWRITE      = 0x00000002U,
    SYMSTOREOPT_PASS_IF_EXISTS = 0x00000040U,
    SYMSTOREOPT_POINTER        = 0x00000008U,
    SYMSTOREOPT_RETURNINDEX    = 0x00000004U,
}

alias IMAGE_DIRECTORY_ENTRY = ushort;
enum : ushort
{
    IMAGE_DIRECTORY_ENTRY_ARCHITECTURE   = cast(ushort) 0x0007,
    IMAGE_DIRECTORY_ENTRY_BASERELOC      = cast(ushort) 0x0005,
    IMAGE_DIRECTORY_ENTRY_BOUND_IMPORT   = cast(ushort) 0x000b,
    IMAGE_DIRECTORY_ENTRY_COM_DESCRIPTOR = cast(ushort) 0x000e,
    IMAGE_DIRECTORY_ENTRY_DEBUG          = cast(ushort) 0x0006,
    IMAGE_DIRECTORY_ENTRY_DELAY_IMPORT   = cast(ushort) 0x000d,
    IMAGE_DIRECTORY_ENTRY_EXCEPTION      = cast(ushort) 0x0003,
    IMAGE_DIRECTORY_ENTRY_EXPORT         = cast(ushort) 0x0000,
    IMAGE_DIRECTORY_ENTRY_GLOBALPTR      = cast(ushort) 0x0008,
    IMAGE_DIRECTORY_ENTRY_IAT            = cast(ushort) 0x000c,
    IMAGE_DIRECTORY_ENTRY_IMPORT         = cast(ushort) 0x0001,
    IMAGE_DIRECTORY_ENTRY_LOAD_CONFIG    = cast(ushort) 0x000a,
    IMAGE_DIRECTORY_ENTRY_RESOURCE       = cast(ushort) 0x0002,
    IMAGE_DIRECTORY_ENTRY_SECURITY       = cast(ushort) 0x0004,
    IMAGE_DIRECTORY_ENTRY_TLS            = cast(ushort) 0x0009,
}

alias WAIT_CHAIN_THREAD_OPTIONS = uint;
enum : uint
{
    WCT_OUT_OF_PROC_COM_FLAG = 0x00000002U,
    WCT_OUT_OF_PROC_CS_FLAG  = 0x00000004U,
    WCT_OUT_OF_PROC_FLAG     = 0x00000001U,
}

alias SYM_FIND_ID_OPTION = uint;
enum : uint
{
    SSRVOPT_DWORD    = 0x00000002U,
    SSRVOPT_DWORDPTR = 0x00000004U,
    SSRVOPT_GUIDPTR  = 0x00000008U,
}

alias IMAGE_FILE_CHARACTERISTICS = ushort;
enum : ushort
{
    IMAGE_FILE_RELOCS_STRIPPED         = cast(ushort) 0x0001,
    IMAGE_FILE_EXECUTABLE_IMAGE        = cast(ushort) 0x0002,
    IMAGE_FILE_LINE_NUMS_STRIPPED      = cast(ushort) 0x0004,
    IMAGE_FILE_LOCAL_SYMS_STRIPPED     = cast(ushort) 0x0008,
    IMAGE_FILE_AGGRESIVE_WS_TRIM       = cast(ushort) 0x0010,
    IMAGE_FILE_LARGE_ADDRESS_AWARE     = cast(ushort) 0x0020,
    IMAGE_FILE_BYTES_REVERSED_LO       = cast(ushort) 0x0080,
    IMAGE_FILE_32BIT_MACHINE           = cast(ushort) 0x0100,
    IMAGE_FILE_DEBUG_STRIPPED          = cast(ushort) 0x0200,
    IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP = cast(ushort) 0x0400,
    IMAGE_FILE_NET_RUN_FROM_SWAP       = cast(ushort) 0x0800,
    IMAGE_FILE_SYSTEM                  = cast(ushort) 0x1000,
    IMAGE_FILE_DLL                     = cast(ushort) 0x2000,
    IMAGE_FILE_UP_SYSTEM_ONLY          = cast(ushort) 0x4000,
    IMAGE_FILE_BYTES_REVERSED_HI       = cast(ushort) 0x8000,
}

alias IMAGE_FILE_CHARACTERISTICS2 = uint;
enum : uint
{
    IMAGE_FILE_RELOCS_STRIPPED2         = 0x00000001U,
    IMAGE_FILE_EXECUTABLE_IMAGE2        = 0x00000002U,
    IMAGE_FILE_LINE_NUMS_STRIPPED2      = 0x00000004U,
    IMAGE_FILE_LOCAL_SYMS_STRIPPED2     = 0x00000008U,
    IMAGE_FILE_AGGRESIVE_WS_TRIM2       = 0x00000010U,
    IMAGE_FILE_LARGE_ADDRESS_AWARE2     = 0x00000020U,
    IMAGE_FILE_BYTES_REVERSED_LO2       = 0x00000080U,
    IMAGE_FILE_32BIT_MACHINE2           = 0x00000100U,
    IMAGE_FILE_DEBUG_STRIPPED2          = 0x00000200U,
    IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP2 = 0x00000400U,
    IMAGE_FILE_NET_RUN_FROM_SWAP2       = 0x00000800U,
    IMAGE_FILE_SYSTEM_2                 = 0x00001000U,
    IMAGE_FILE_DLL_2                    = 0x00002000U,
    IMAGE_FILE_UP_SYSTEM_ONLY_2         = 0x00004000U,
    IMAGE_FILE_BYTES_REVERSED_HI_2      = 0x00008000U,
}

alias SYMBOL_INFO_FLAGS = uint;
enum : uint
{
    SYMFLAG_CLR_TOKEN    = 0x00040000U,
    SYMFLAG_CONSTANT     = 0x00000100U,
    SYMFLAG_EXPORT       = 0x00000200U,
    SYMFLAG_FORWARDER    = 0x00000400U,
    SYMFLAG_FRAMEREL     = 0x00000020U,
    SYMFLAG_FUNCTION     = 0x00000800U,
    SYMFLAG_ILREL        = 0x00010000U,
    SYMFLAG_LOCAL        = 0x00000080U,
    SYMFLAG_METADATA     = 0x00020000U,
    SYMFLAG_PARAMETER    = 0x00000040U,
    SYMFLAG_REGISTER     = 0x00000008U,
    SYMFLAG_REGREL       = 0x00000010U,
    SYMFLAG_SLOT         = 0x00008000U,
    SYMFLAG_THUNK        = 0x00002000U,
    SYMFLAG_TLSREL       = 0x00004000U,
    SYMFLAG_VALUEPRESENT = 0x00000001U,
    SYMFLAG_VIRTUAL      = 0x00001000U,
}

alias IMAGEHLP_CBA_EVENT_SEVERITY = uint;
enum : uint
{
    sevInfo    = 0x00000000U,
    sevProblem = 0x00000001U,
    sevAttn    = 0x00000002U,
    sevFatal   = 0x00000003U,
}

alias IMAGEHLP_GET_TYPE_INFO_FLAGS = uint;
enum : uint
{
    IMAGEHLP_GET_TYPE_INFO_CHILDREN = 0x00000002U,
    IMAGEHLP_GET_TYPE_INFO_UNCACHED = 0x00000001U,
}

alias RIP_INFO_TYPE = uint;
enum : uint
{
    SLE_ERROR      = 0x00000001U,
    SLE_MINORERROR = 0x00000002U,
    SLE_WARNING    = 0x00000003U,
}

alias VER_PLATFORM = uint;
enum : uint
{
    VER_PLATFORM_WIN32s        = 0x00000000U,
    VER_PLATFORM_WIN32_WINDOWS = 0x00000001U,
    VER_PLATFORM_WIN32_NT      = 0x00000002U,
}

alias IMAGE_DEBUG_TYPE = uint;
enum : uint
{
    IMAGE_DEBUG_TYPE_UNKNOWN   = 0x00000000U,
    IMAGE_DEBUG_TYPE_COFF      = 0x00000001U,
    IMAGE_DEBUG_TYPE_CODEVIEW  = 0x00000002U,
    IMAGE_DEBUG_TYPE_FPO       = 0x00000003U,
    IMAGE_DEBUG_TYPE_MISC      = 0x00000004U,
    IMAGE_DEBUG_TYPE_EXCEPTION = 0x00000005U,
    IMAGE_DEBUG_TYPE_FIXUP     = 0x00000006U,
    IMAGE_DEBUG_TYPE_BORLAND   = 0x00000009U,
}

alias MINIDUMP_THREAD_INFO_DUMP_FLAGS = uint;
enum : uint
{
    MINIDUMP_THREAD_INFO_ERROR_THREAD    = 0x00000001U,
    MINIDUMP_THREAD_INFO_EXITED_THREAD   = 0x00000004U,
    MINIDUMP_THREAD_INFO_INVALID_CONTEXT = 0x00000010U,
    MINIDUMP_THREAD_INFO_INVALID_INFO    = 0x00000008U,
    MINIDUMP_THREAD_INFO_INVALID_TEB     = 0x00000020U,
    MINIDUMP_THREAD_INFO_WRITING_THREAD  = 0x00000002U,
}

alias DEBUG_EVENT_CODE = uint;
enum : uint
{
    CREATE_PROCESS_DEBUG_EVENT = 0x00000003U,
    CREATE_THREAD_DEBUG_EVENT  = 0x00000002U,
    EXCEPTION_DEBUG_EVENT      = 0x00000001U,
    EXIT_PROCESS_DEBUG_EVENT   = 0x00000005U,
    EXIT_THREAD_DEBUG_EVENT    = 0x00000004U,
    LOAD_DLL_DEBUG_EVENT       = 0x00000006U,
    OUTPUT_DEBUG_STRING_EVENT  = 0x00000008U,
    RIP_EVENT                  = 0x00000009U,
    UNLOAD_DLL_DEBUG_EVENT     = 0x00000007U,
}

alias MINIDUMP_MISC_INFO_FLAGS = uint;
enum : uint
{
    MINIDUMP_MISC1_PROCESS_ID    = 0x00000001U,
    MINIDUMP_MISC1_PROCESS_TIMES = 0x00000002U,
}

alias MODLOAD_DATA_TYPE = uint;
enum : uint
{
    DBHHEADER_DEBUGDIRS = 0x00000001U,
    DBHHEADER_CVMISC    = 0x00000002U,
}

alias CONTEXT_FLAGS = uint;
enum : uint
{
    CONTEXT_AMD64                     = 0x00100000U,
    CONTEXT_CONTROL_AMD64             = 0x00100001U,
    CONTEXT_INTEGER_AMD64             = 0x00100002U,
    CONTEXT_SEGMENTS_AMD64            = 0x00100004U,
    CONTEXT_FLOATING_POINT_AMD64      = 0x00100008U,
    CONTEXT_DEBUG_REGISTERS_AMD64     = 0x00100010U,
    CONTEXT_FULL_AMD64                = 0x0010000bU,
    CONTEXT_ALL_AMD64                 = 0x0010001fU,
    CONTEXT_XSTATE_AMD64              = 0x00100040U,
    CONTEXT_KERNEL_CET_AMD64          = 0x00100080U,
    CONTEXT_KERNEL_DEBUGGER_AMD64     = 0x04000000U,
    CONTEXT_EXCEPTION_ACTIVE_AMD64    = 0x08000000U,
    CONTEXT_SERVICE_ACTIVE_AMD64      = 0x10000000U,
    CONTEXT_EXCEPTION_REQUEST_AMD64   = 0x40000000U,
    CONTEXT_EXCEPTION_REPORTING_AMD64 = 0x80000000U,
    CONTEXT_UNWOUND_TO_CALL_AMD64     = 0x20000000U,
    CONTEXT_X86                       = 0x00010000U,
    CONTEXT_CONTROL_X86               = 0x00010001U,
    CONTEXT_INTEGER_X86               = 0x00010002U,
    CONTEXT_SEGMENTS_X86              = 0x00010004U,
    CONTEXT_FLOATING_POINT_X86        = 0x00010008U,
    CONTEXT_DEBUG_REGISTERS_X86       = 0x00010010U,
    CONTEXT_EXTENDED_REGISTERS_X86    = 0x00010020U,
    CONTEXT_FULL_X86                  = 0x00010007U,
    CONTEXT_ALL_X86                   = 0x0001003fU,
    CONTEXT_XSTATE_X86                = 0x00010040U,
    CONTEXT_EXCEPTION_ACTIVE_X86      = 0x08000000U,
    CONTEXT_SERVICE_ACTIVE_X86        = 0x10000000U,
    CONTEXT_EXCEPTION_REQUEST_X86     = 0x40000000U,
    CONTEXT_EXCEPTION_REPORTING_X86   = 0x80000000U,
    CONTEXT_ARM64                     = 0x00400000U,
    CONTEXT_CONTROL_ARM64             = 0x00400001U,
    CONTEXT_INTEGER_ARM64             = 0x00400002U,
    CONTEXT_FLOATING_POINT_ARM64      = 0x00400004U,
    CONTEXT_DEBUG_REGISTERS_ARM64     = 0x00400008U,
    CONTEXT_X18_ARM64                 = 0x00400010U,
    CONTEXT_FULL_ARM64                = 0x00400007U,
    CONTEXT_ALL_ARM64                 = 0x0040001fU,
    CONTEXT_EXCEPTION_ACTIVE_ARM64    = 0x08000000U,
    CONTEXT_SERVICE_ACTIVE_ARM64      = 0x10000000U,
    CONTEXT_EXCEPTION_REQUEST_ARM64   = 0x40000000U,
    CONTEXT_EXCEPTION_REPORTING_ARM64 = 0x80000000U,
    CONTEXT_UNWOUND_TO_CALL_ARM64     = 0x20000000U,
    CONTEXT_RET_TO_GUEST_ARM64        = 0x40000000U,
    CONTEXT_ARM                       = 0x00200000U,
    CONTEXT_CONTROL_ARM               = 0x00200001U,
    CONTEXT_INTEGER_ARM               = 0x00200002U,
    CONTEXT_FLOATING_POINT_ARM        = 0x00200004U,
    CONTEXT_DEBUG_REGISTERS_ARM       = 0x00200008U,
    CONTEXT_FULL_ARM                  = 0x00200007U,
    CONTEXT_ALL_ARM                   = 0x0020000fU,
    CONTEXT_EXCEPTION_ACTIVE_ARM      = 0x08000000U,
    CONTEXT_SERVICE_ACTIVE_ARM        = 0x10000000U,
    CONTEXT_EXCEPTION_REQUEST_ARM     = 0x40000000U,
    CONTEXT_EXCEPTION_REPORTING_ARM   = 0x80000000U,
    CONTEXT_UNWOUND_TO_CALL_ARM       = 0x20000000U,
}

alias WOW64_CONTEXT_FLAGS = uint;
enum : uint
{
    WOW64_CONTEXT_X86                 = 0x00010000U,
    WOW64_CONTEXT_CONTROL             = 0x00010001U,
    WOW64_CONTEXT_INTEGER             = 0x00010002U,
    WOW64_CONTEXT_SEGMENTS            = 0x00010004U,
    WOW64_CONTEXT_FLOATING_POINT      = 0x00010008U,
    WOW64_CONTEXT_DEBUG_REGISTERS     = 0x00010010U,
    WOW64_CONTEXT_EXTENDED_REGISTERS  = 0x00010020U,
    WOW64_CONTEXT_FULL                = 0x00010007U,
    WOW64_CONTEXT_ALL                 = 0x0001003fU,
    WOW64_CONTEXT_XSTATE              = 0x00010040U,
    WOW64_CONTEXT_EXCEPTION_ACTIVE    = 0x08000000U,
    WOW64_CONTEXT_SERVICE_ACTIVE      = 0x10000000U,
    WOW64_CONTEXT_EXCEPTION_REQUEST   = 0x40000000U,
    WOW64_CONTEXT_EXCEPTION_REPORTING = 0x80000000U,
}

alias WCT_OBJECT_TYPE = int;
enum : int
{
    WctCriticalSectionType = 0x00000001,
    WctSendMessageType     = 0x00000002,
    WctMutexType           = 0x00000003,
    WctAlpcType            = 0x00000004,
    WctComType             = 0x00000005,
    WctThreadWaitType      = 0x00000006,
    WctProcessWaitType     = 0x00000007,
    WctThreadType          = 0x00000008,
    WctComActivationType   = 0x00000009,
    WctUnknownType         = 0x0000000a,
    WctSocketIoType        = 0x0000000b,
    WctSmbIoType           = 0x0000000c,
    WctMaxType             = 0x0000000d,
}

alias WCT_OBJECT_STATUS = int;
enum : int
{
    WctStatusNoAccess     = 0x00000001,
    WctStatusRunning      = 0x00000002,
    WctStatusBlocked      = 0x00000003,
    WctStatusPidOnly      = 0x00000004,
    WctStatusPidOnlyRpcss = 0x00000005,
    WctStatusOwned        = 0x00000006,
    WctStatusNotOwned     = 0x00000007,
    WctStatusAbandoned    = 0x00000008,
    WctStatusUnknown      = 0x00000009,
    WctStatusError        = 0x0000000a,
    WctStatusMax          = 0x0000000b,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ne-minidumpapiset-minidump_stream_type
alias MINIDUMP_STREAM_TYPE = int;
enum : int
{
    UnusedStream                = 0x00000000,
    ReservedStream0             = 0x00000001,
    ReservedStream1             = 0x00000002,
    ThreadListStream            = 0x00000003,
    ModuleListStream            = 0x00000004,
    MemoryListStream            = 0x00000005,
    ExceptionStream             = 0x00000006,
    SystemInfoStream            = 0x00000007,
    ThreadExListStream          = 0x00000008,
    Memory64ListStream          = 0x00000009,
    CommentStreamA              = 0x0000000a,
    CommentStreamW              = 0x0000000b,
    HandleDataStream            = 0x0000000c,
    FunctionTableStream         = 0x0000000d,
    UnloadedModuleListStream    = 0x0000000e,
    MiscInfoStream              = 0x0000000f,
    MemoryInfoListStream        = 0x00000010,
    ThreadInfoListStream        = 0x00000011,
    HandleOperationListStream   = 0x00000012,
    TokenStream                 = 0x00000013,
    JavaScriptDataStream        = 0x00000014,
    SystemMemoryInfoStream      = 0x00000015,
    ProcessVmCountersStream     = 0x00000016,
    IptTraceStream              = 0x00000017,
    ThreadNamesStream           = 0x00000018,
    ceStreamNull                = 0x00008000,
    ceStreamSystemInfo          = 0x00008001,
    ceStreamException           = 0x00008002,
    ceStreamModuleList          = 0x00008003,
    ceStreamProcessList         = 0x00008004,
    ceStreamThreadList          = 0x00008005,
    ceStreamThreadContextList   = 0x00008006,
    ceStreamThreadCallStackList = 0x00008007,
    ceStreamMemoryVirtualList   = 0x00008008,
    ceStreamMemoryPhysicalList  = 0x00008009,
    ceStreamBucketParameters    = 0x0000800a,
    ceStreamProcessModuleMap    = 0x0000800b,
    ceStreamDiagnosisList       = 0x0000800c,
    LastReservedStream          = 0x0000ffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ne-minidumpapiset-minidump_handle_object_information_type
alias MINIDUMP_HANDLE_OBJECT_INFORMATION_TYPE = int;
enum : int
{
    MiniHandleObjectInformationNone    = 0x00000000,
    MiniThreadInformation1             = 0x00000001,
    MiniMutantInformation1             = 0x00000002,
    MiniMutantInformation2             = 0x00000003,
    MiniProcessInformation1            = 0x00000004,
    MiniProcessInformation2            = 0x00000005,
    MiniEventInformation1              = 0x00000006,
    MiniSectionInformation1            = 0x00000007,
    MiniSemaphoreInformation1          = 0x00000008,
    MiniHandleObjectInformationTypeMax = 0x00000009,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ne-minidumpapiset-minidump_callback_type
alias MINIDUMP_CALLBACK_TYPE = int;
enum : int
{
    ModuleCallback               = 0x00000000,
    ThreadCallback               = 0x00000001,
    ThreadExCallback             = 0x00000002,
    IncludeThreadCallback        = 0x00000003,
    IncludeModuleCallback        = 0x00000004,
    MemoryCallback               = 0x00000005,
    CancelCallback               = 0x00000006,
    WriteKernelMinidumpCallback  = 0x00000007,
    KernelMinidumpStatusCallback = 0x00000008,
    RemoveMemoryCallback         = 0x00000009,
    IncludeVmRegionCallback      = 0x0000000a,
    IoStartCallback              = 0x0000000b,
    IoWriteAllCallback           = 0x0000000c,
    IoFinishCallback             = 0x0000000d,
    ReadMemoryFailureCallback    = 0x0000000e,
    SecondaryFlagsCallback       = 0x0000000f,
    IsProcessSnapshotCallback    = 0x00000010,
    VmStartCallback              = 0x00000011,
    VmQueryCallback              = 0x00000012,
    VmPreReadCallback            = 0x00000013,
    VmPostReadCallback           = 0x00000014,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ne-minidumpapiset-thread_write_flags
alias THREAD_WRITE_FLAGS = int;
enum : int
{
    ThreadWriteThread            = 0x00000001,
    ThreadWriteStack             = 0x00000002,
    ThreadWriteContext           = 0x00000004,
    ThreadWriteBackingStore      = 0x00000008,
    ThreadWriteInstructionWindow = 0x00000010,
    ThreadWriteThreadData        = 0x00000020,
    ThreadWriteThreadInfo        = 0x00000040,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ne-minidumpapiset-module_write_flags
alias MODULE_WRITE_FLAGS = int;
enum : int
{
    ModuleWriteModule        = 0x00000001,
    ModuleWriteDataSeg       = 0x00000002,
    ModuleWriteMiscRecord    = 0x00000004,
    ModuleWriteCvRecord      = 0x00000008,
    ModuleReferencedByMemory = 0x00000010,
    ModuleWriteTlsData       = 0x00000020,
    ModuleWriteCodeSegs      = 0x00000040,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ne-minidumpapiset-minidump_type
alias MINIDUMP_TYPE = int;
enum : int
{
    MiniDumpNormal                         = 0x00000000,
    MiniDumpWithDataSegs                   = 0x00000001,
    MiniDumpWithFullMemory                 = 0x00000002,
    MiniDumpWithHandleData                 = 0x00000004,
    MiniDumpFilterMemory                   = 0x00000008,
    MiniDumpScanMemory                     = 0x00000010,
    MiniDumpWithUnloadedModules            = 0x00000020,
    MiniDumpWithIndirectlyReferencedMemory = 0x00000040,
    MiniDumpFilterModulePaths              = 0x00000080,
    MiniDumpWithProcessThreadData          = 0x00000100,
    MiniDumpWithPrivateReadWriteMemory     = 0x00000200,
    MiniDumpWithoutOptionalData            = 0x00000400,
    MiniDumpWithFullMemoryInfo             = 0x00000800,
    MiniDumpWithThreadInfo                 = 0x00001000,
    MiniDumpWithCodeSegs                   = 0x00002000,
    MiniDumpWithoutAuxiliaryState          = 0x00004000,
    MiniDumpWithFullAuxiliaryState         = 0x00008000,
    MiniDumpWithPrivateWriteCopyMemory     = 0x00010000,
    MiniDumpIgnoreInaccessibleMemory       = 0x00020000,
    MiniDumpWithTokenInformation           = 0x00040000,
    MiniDumpWithModuleHeaders              = 0x00080000,
    MiniDumpFilterTriage                   = 0x00100000,
    MiniDumpWithAvxXStateContext           = 0x00200000,
    MiniDumpWithIptTrace                   = 0x00400000,
    MiniDumpScanInaccessiblePartialPages   = 0x00800000,
    MiniDumpFilterWriteCombinedMemory      = 0x01000000,
    MiniDumpValidTypeFlags                 = 0x01ffffff,
    MiniDumpNoIgnoreInaccessibleMemory     = 0x02000000,
    MiniDumpValidTypeFlagsEx               = 0x03ffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ne-minidumpapiset-minidump_secondary_flags
alias MINIDUMP_SECONDARY_FLAGS = int;
enum : int
{
    MiniSecondaryWithoutPowerInfo = 0x00000001,
    MiniSecondaryValidFlags       = 0x00000001,
}

alias IMAGEHLP_STATUS_REASON = int;
enum : int
{
    BindOutOfMemory           = 0x00000000,
    BindRvaToVaFailed         = 0x00000001,
    BindNoRoomInImage         = 0x00000002,
    BindImportModuleFailed    = 0x00000003,
    BindImportProcedureFailed = 0x00000004,
    BindImportModule          = 0x00000005,
    BindImportProcedure       = 0x00000006,
    BindForwarder             = 0x00000007,
    BindForwarderNOT          = 0x00000008,
    BindImageModified         = 0x00000009,
    BindExpandFileHeaders     = 0x0000000a,
    BindImageComplete         = 0x0000000b,
    BindMismatchedSymbols     = 0x0000000c,
    BindSymbolsNotUpdated     = 0x0000000d,
    BindImportProcedure32     = 0x0000000e,
    BindImportProcedure64     = 0x0000000f,
    BindForwarder32           = 0x00000010,
    BindForwarder64           = 0x00000011,
    BindForwarderNOT32        = 0x00000012,
    BindForwarderNOT64        = 0x00000013,
}

alias ADDRESS_MODE = int;
enum : int
{
    AddrMode1616 = 0x00000000,
    AddrMode1632 = 0x00000001,
    AddrModeReal = 0x00000002,
    AddrModeFlat = 0x00000003,
}

alias SYM_TYPE = int;
enum : int
{
    SymNone     = 0x00000000,
    SymCoff     = 0x00000001,
    SymCv       = 0x00000002,
    SymPdb      = 0x00000003,
    SymExport   = 0x00000004,
    SymDeferred = 0x00000005,
    SymSym      = 0x00000006,
    SymDia      = 0x00000007,
    SymVirtual  = 0x00000008,
    NumSymTypes = 0x00000009,
}

alias IMAGEHLP_HD_TYPE = int;
enum : int
{
    hdBase  = 0x00000000,
    hdSym   = 0x00000001,
    hdSrc   = 0x00000002,
    hdMax   = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ne-dbghelp-imagehlp_extended_options
alias IMAGEHLP_EXTENDED_OPTIONS = int;
enum : int
{
    SYMOPT_EX_DISABLEACCESSTIMEUPDATE = 0x00000000,
    SYMOPT_EX_LASTVALIDDEBUGDIRECTORY = 0x00000001,
    SYMOPT_EX_NOIMPLICITPATTERNSEARCH = 0x00000002,
    SYMOPT_EX_NEVERLOADSYMBOLS        = 0x00000003,
    SYMOPT_EX_MAX                     = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ne-dbghelp-imagehlp_symbol_type_info
alias IMAGEHLP_SYMBOL_TYPE_INFO = int;
enum : int
{
    TI_GET_SYMTAG                             = 0x00000000,
    TI_GET_SYMNAME                            = 0x00000001,
    TI_GET_LENGTH                             = 0x00000002,
    TI_GET_TYPE                               = 0x00000003,
    TI_GET_TYPEID                             = 0x00000004,
    TI_GET_BASETYPE                           = 0x00000005,
    TI_GET_ARRAYINDEXTYPEID                   = 0x00000006,
    TI_FINDCHILDREN                           = 0x00000007,
    TI_GET_DATAKIND                           = 0x00000008,
    TI_GET_ADDRESSOFFSET                      = 0x00000009,
    TI_GET_OFFSET                             = 0x0000000a,
    TI_GET_VALUE                              = 0x0000000b,
    TI_GET_COUNT                              = 0x0000000c,
    TI_GET_CHILDRENCOUNT                      = 0x0000000d,
    TI_GET_BITPOSITION                        = 0x0000000e,
    TI_GET_VIRTUALBASECLASS                   = 0x0000000f,
    TI_GET_VIRTUALTABLESHAPEID                = 0x00000010,
    TI_GET_VIRTUALBASEPOINTEROFFSET           = 0x00000011,
    TI_GET_CLASSPARENTID                      = 0x00000012,
    TI_GET_NESTED                             = 0x00000013,
    TI_GET_SYMINDEX                           = 0x00000014,
    TI_GET_LEXICALPARENT                      = 0x00000015,
    TI_GET_ADDRESS                            = 0x00000016,
    TI_GET_THISADJUST                         = 0x00000017,
    TI_GET_UDTKIND                            = 0x00000018,
    TI_IS_EQUIV_TO                            = 0x00000019,
    TI_GET_CALLING_CONVENTION                 = 0x0000001a,
    TI_IS_CLOSE_EQUIV_TO                      = 0x0000001b,
    TI_GTIEX_REQS_VALID                       = 0x0000001c,
    TI_GET_VIRTUALBASEOFFSET                  = 0x0000001d,
    TI_GET_VIRTUALBASEDISPINDEX               = 0x0000001e,
    TI_GET_IS_REFERENCE                       = 0x0000001f,
    TI_GET_INDIRECTVIRTUALBASECLASS           = 0x00000020,
    TI_GET_VIRTUALBASETABLETYPE               = 0x00000021,
    TI_GET_OBJECTPOINTERTYPE                  = 0x00000022,
    TI_GET_DISCRIMINATEDUNION_TAG_TYPEID      = 0x00000023,
    TI_GET_DISCRIMINATEDUNION_TAG_OFFSET      = 0x00000024,
    TI_GET_DISCRIMINATEDUNION_TAG_RANGESCOUNT = 0x00000025,
    TI_GET_DISCRIMINATEDUNION_TAG_RANGES      = 0x00000026,
    IMAGEHLP_SYMBOL_TYPE_INFO_MAX             = 0x00000027,
}

alias IMAGEHLP_SF_TYPE = int;
enum : int
{
    sfImage = 0x00000000,
    sfDbg   = 0x00000001,
    sfPdb   = 0x00000002,
    sfMpd   = 0x00000003,
    sfMax   = 0x00000004,
}

alias DUMP_TYPE = int;
enum : int
{
    DUMP_TYPE_INVALID       = 0xffffffff,
    DUMP_TYPE_UNKNOWN       = 0x00000000,
    DUMP_TYPE_FULL          = 0x00000001,
    DUMP_TYPE_SUMMARY       = 0x00000002,
    DUMP_TYPE_HEADER        = 0x00000003,
    DUMP_TYPE_TRIAGE        = 0x00000004,
    DUMP_TYPE_BITMAP_FULL   = 0x00000005,
    DUMP_TYPE_BITMAP_KERNEL = 0x00000006,
    DUMP_TYPE_AUTOMATIC     = 0x00000007,
}

alias WHEA_ERROR_SOURCE_TYPE = int;
enum : int
{
    WheaErrSrcTypeMCE          = 0x00000000,
    WheaErrSrcTypeCMC          = 0x00000001,
    WheaErrSrcTypeCPE          = 0x00000002,
    WheaErrSrcTypeNMI          = 0x00000003,
    WheaErrSrcTypePCIe         = 0x00000004,
    WheaErrSrcTypeGeneric      = 0x00000005,
    WheaErrSrcTypeINIT         = 0x00000006,
    WheaErrSrcTypeBOOT         = 0x00000007,
    WheaErrSrcTypeSCIGeneric   = 0x00000008,
    WheaErrSrcTypeIPFMCA       = 0x00000009,
    WheaErrSrcTypeIPFCMC       = 0x0000000a,
    WheaErrSrcTypeIPFCPE       = 0x0000000b,
    WheaErrSrcTypeGenericV2    = 0x0000000c,
    WheaErrSrcTypeSCIGenericV2 = 0x0000000d,
    WheaErrSrcTypeBMC          = 0x0000000e,
    WheaErrSrcTypePMEM         = 0x0000000f,
    WheaErrSrcTypeDeviceDriver = 0x00000010,
    WheaErrSrcTypeSea          = 0x00000011,
    WheaErrSrcTypeSei          = 0x00000012,
    WheaErrSrcTypeMax          = 0x00000013,
}

alias WHEA_ERROR_SOURCE_STATE = int;
enum : int
{
    WheaErrSrcStateStopped       = 0x00000001,
    WheaErrSrcStateStarted       = 0x00000002,
    WheaErrSrcStateRemoved       = 0x00000003,
    WheaErrSrcStateRemovePending = 0x00000004,
}

alias IPMI_OS_SEL_RECORD_TYPE = int;
enum : int
{
    IpmiOsSelRecordTypeWhea             = 0x00000000,
    IpmiOsSelRecordTypeOther            = 0x00000001,
    IpmiOsSelRecordTypeWheaErrorXpfMca  = 0x00000002,
    IpmiOsSelRecordTypeWheaErrorPci     = 0x00000003,
    IpmiOsSelRecordTypeWheaErrorNmi     = 0x00000004,
    IpmiOsSelRecordTypeWheaErrorOther   = 0x00000005,
    IpmiOsSelRecordTypeRaw              = 0x00000006,
    IpmiOsSelRecordTypeDriver           = 0x00000007,
    IpmiOsSelRecordTypeBugcheckRecovery = 0x00000008,
    IpmiOsSelRecordTypeBugcheckData     = 0x00000009,
    IpmiOsSelRecordTypeMax              = 0x0000000a,
}

alias PAGE_OFFLINE_ERROR_TYPES = int;
enum : int
{
    BitErrorDdr4 = 0x00000000,
    RowErrorDdr4 = 0x00000001,
    BitErrorDdr5 = 0x00000002,
    RowErrorDdr5 = 0x00000003,
}

alias DBGPROP_ATTRIB_FLAGS = int;
enum : int
{
    DBGPROP_ATTRIB_NO_ATTRIB              = 0x00000000,
    DBGPROP_ATTRIB_VALUE_IS_INVALID       = 0x00000008,
    DBGPROP_ATTRIB_VALUE_IS_EXPANDABLE    = 0x00000010,
    DBGPROP_ATTRIB_VALUE_IS_FAKE          = 0x00000020,
    DBGPROP_ATTRIB_VALUE_IS_METHOD        = 0x00000100,
    DBGPROP_ATTRIB_VALUE_IS_EVENT         = 0x00000200,
    DBGPROP_ATTRIB_VALUE_IS_RAW_STRING    = 0x00000400,
    DBGPROP_ATTRIB_VALUE_READONLY         = 0x00000800,
    DBGPROP_ATTRIB_ACCESS_PUBLIC          = 0x00001000,
    DBGPROP_ATTRIB_ACCESS_PRIVATE         = 0x00002000,
    DBGPROP_ATTRIB_ACCESS_PROTECTED       = 0x00004000,
    DBGPROP_ATTRIB_ACCESS_FINAL           = 0x00008000,
    DBGPROP_ATTRIB_STORAGE_GLOBAL         = 0x00010000,
    DBGPROP_ATTRIB_STORAGE_STATIC         = 0x00020000,
    DBGPROP_ATTRIB_STORAGE_FIELD          = 0x00040000,
    DBGPROP_ATTRIB_STORAGE_VIRTUAL        = 0x00080000,
    DBGPROP_ATTRIB_TYPE_IS_CONSTANT       = 0x00100000,
    DBGPROP_ATTRIB_TYPE_IS_SYNCHRONIZED   = 0x00200000,
    DBGPROP_ATTRIB_TYPE_IS_VOLATILE       = 0x00400000,
    DBGPROP_ATTRIB_HAS_EXTENDED_ATTRIBS   = 0x00800000,
    DBGPROP_ATTRIB_FRAME_INTRYBLOCK       = 0x01000000,
    DBGPROP_ATTRIB_FRAME_INCATCHBLOCK     = 0x02000000,
    DBGPROP_ATTRIB_FRAME_INFINALLYBLOCK   = 0x04000000,
    DBGPROP_ATTRIB_VALUE_IS_RETURN_VALUE  = 0x08000000,
    DBGPROP_ATTRIB_VALUE_PENDING_MUTATION = 0x10000000,
}

alias DBGPROP_INFO = int;
enum : int
{
    DBGPROP_INFO_NAME         = 0x00000001,
    DBGPROP_INFO_TYPE         = 0x00000002,
    DBGPROP_INFO_VALUE        = 0x00000004,
    DBGPROP_INFO_FULLNAME     = 0x00000020,
    DBGPROP_INFO_ATTRIBUTES   = 0x00000008,
    DBGPROP_INFO_DEBUGPROP    = 0x00000010,
    DBGPROP_INFO_BEAUTIFY     = 0x02000000,
    DBGPROP_INFO_CALLTOSTRING = 0x04000000,
    DBGPROP_INFO_AUTOEXPAND   = 0x08000000,
}

alias OBJECT_ATTRIB_FLAGS = int;
enum : int
{
    OBJECT_ATTRIB_NO_ATTRIB            = 0x00000000,
    OBJECT_ATTRIB_NO_NAME              = 0x00000001,
    OBJECT_ATTRIB_NO_TYPE              = 0x00000002,
    OBJECT_ATTRIB_NO_VALUE             = 0x00000004,
    OBJECT_ATTRIB_VALUE_IS_INVALID     = 0x00000008,
    OBJECT_ATTRIB_VALUE_IS_OBJECT      = 0x00000010,
    OBJECT_ATTRIB_VALUE_IS_ENUM        = 0x00000020,
    OBJECT_ATTRIB_VALUE_IS_CUSTOM      = 0x00000040,
    OBJECT_ATTRIB_OBJECT_IS_EXPANDABLE = 0x00000070,
    OBJECT_ATTRIB_VALUE_HAS_CODE       = 0x00000080,
    OBJECT_ATTRIB_TYPE_IS_OBJECT       = 0x00000100,
    OBJECT_ATTRIB_TYPE_HAS_CODE        = 0x00000200,
    OBJECT_ATTRIB_TYPE_IS_EXPANDABLE   = 0x00000100,
    OBJECT_ATTRIB_SLOT_IS_CATEGORY     = 0x00000400,
    OBJECT_ATTRIB_VALUE_READONLY       = 0x00000800,
    OBJECT_ATTRIB_ACCESS_PUBLIC        = 0x00001000,
    OBJECT_ATTRIB_ACCESS_PRIVATE       = 0x00002000,
    OBJECT_ATTRIB_ACCESS_PROTECTED     = 0x00004000,
    OBJECT_ATTRIB_ACCESS_FINAL         = 0x00008000,
    OBJECT_ATTRIB_STORAGE_GLOBAL       = 0x00010000,
    OBJECT_ATTRIB_STORAGE_STATIC       = 0x00020000,
    OBJECT_ATTRIB_STORAGE_FIELD        = 0x00040000,
    OBJECT_ATTRIB_STORAGE_VIRTUAL      = 0x00080000,
    OBJECT_ATTRIB_TYPE_IS_CONSTANT     = 0x00100000,
    OBJECT_ATTRIB_TYPE_IS_SYNCHRONIZED = 0x00200000,
    OBJECT_ATTRIB_TYPE_IS_VOLATILE     = 0x00400000,
    OBJECT_ATTRIB_HAS_EXTENDED_ATTRIBS = 0x00800000,
    OBJECT_ATTRIB_IS_CLASS             = 0x01000000,
    OBJECT_ATTRIB_IS_FUNCTION          = 0x02000000,
    OBJECT_ATTRIB_IS_VARIABLE          = 0x04000000,
    OBJECT_ATTRIB_IS_PROPERTY          = 0x08000000,
    OBJECT_ATTRIB_IS_MACRO             = 0x10000000,
    OBJECT_ATTRIB_IS_TYPE              = 0x20000000,
    OBJECT_ATTRIB_IS_INHERITED         = 0x40000000,
    OBJECT_ATTRIB_IS_INTERFACE         = 0x80000000,
}

alias PROP_INFO_FLAGS = int;
enum : int
{
    PROP_INFO_NAME       = 0x00000001,
    PROP_INFO_TYPE       = 0x00000002,
    PROP_INFO_VALUE      = 0x00000004,
    PROP_INFO_FULLNAME   = 0x00000020,
    PROP_INFO_ATTRIBUTES = 0x00000008,
    PROP_INFO_DEBUGPROP  = 0x00000010,
    PROP_INFO_AUTOEXPAND = 0x08000000,
}

alias EX_PROP_INFO_FLAGS = int;
enum : int
{
    EX_PROP_INFO_ID           = 0x00000100,
    EX_PROP_INFO_NTYPE        = 0x00000200,
    EX_PROP_INFO_NVALUE       = 0x00000400,
    EX_PROP_INFO_LOCKBYTES    = 0x00000800,
    EX_PROP_INFO_DEBUGEXTPROP = 0x00001000,
}

// Constants


enum int EXCEPTION_EXECUTE_HANDLER = 0x00000001;

enum : int
{
    EXCEPTION_CONTINUE_SEARCH    = 0x00000000,
    EXCEPTION_CONTINUE_EXECUTION = 0xffffffff,
}

enum uint WOW64_SIZE_OF_80387_REGISTERS = 0x00000050U;
enum uint WOW64_MAXIMUM_SUPPORTED_EXTENSION = 0x00000200U;

enum : const(wchar)*
{
    // Native encoding: ansi
    RESTORE_LAST_ERROR_NAME_A = "RestoreLastError",
    RESTORE_LAST_ERROR_NAME_W = "RestoreLastError",
    RESTORE_LAST_ERROR_NAME   = "RestoreLastError",
}

enum uint MAX_SYM_NAME = 0x000007d0U;
enum uint BIND_NO_BOUND_IMPORTS = 0x00000001U;
enum uint BIND_NO_UPDATE = 0x00000002U;
enum uint BIND_ALL_IMAGES = 0x00000004U;
enum uint BIND_CACHE_IMPORT_DLLS = 0x00000008U;
enum uint BIND_REPORT_64BIT_VA = 0x00000010U;

enum : uint
{
    CHECKSUM_SUCCESS         = 0x00000000U,
    CHECKSUM_OPEN_FAILURE    = 0x00000001U,
    CHECKSUM_MAP_FAILURE     = 0x00000002U,
    CHECKSUM_MAPVIEW_FAILURE = 0x00000003U,
}

enum uint CHECKSUM_UNICODE_FAILURE = 0x00000004U;
enum uint SPLITSYM_REMOVE_PRIVATE = 0x00000001U;

enum : uint
{
    SPLITSYM_EXTRACT_ALL       = 0x00000002U,
    SPLITSYM_SYMBOLPATH_IS_SRC = 0x00000004U,
}

enum : uint
{
    CERT_PE_IMAGE_DIGEST_DEBUG_INFO      = 0x00000001U,
    CERT_PE_IMAGE_DIGEST_RESOURCES       = 0x00000002U,
    CERT_PE_IMAGE_DIGEST_ALL_IMPORT_INFO = 0x00000004U,
    CERT_PE_IMAGE_DIGEST_NON_PE_INFO     = 0x00000008U,
}

enum uint CERT_SECTION_TYPE_ANY = 0x000000ffU;
enum uint ERROR_IMAGE_NOT_STRIPPED = 0x00008800U;

enum : uint
{
    ERROR_NO_DBG_POINTER = 0x00008801U,
    ERROR_NO_PDB_POINTER = 0x00008802U,
}

enum : uint
{
    UNDNAME_COMPLETE               = 0x00000000U,
    UNDNAME_NO_LEADING_UNDERSCORES = 0x00000001U,
}

enum : uint
{
    UNDNAME_NO_MS_KEYWORDS         = 0x00000002U,
    UNDNAME_NO_FUNCTION_RETURNS    = 0x00000004U,
    UNDNAME_NO_ALLOCATION_MODEL    = 0x00000008U,
    UNDNAME_NO_ALLOCATION_LANGUAGE = 0x00000010U,
}

enum : uint
{
    UNDNAME_NO_MS_THISTYPE       = 0x00000020U,
    UNDNAME_NO_CV_THISTYPE       = 0x00000040U,
    UNDNAME_NO_THISTYPE          = 0x00000060U,
    UNDNAME_NO_ACCESS_SPECIFIERS = 0x00000080U,
}

enum : uint
{
    UNDNAME_NO_THROW_SIGNATURES = 0x00000100U,
    UNDNAME_NO_MEMBER_TYPE      = 0x00000200U,
    UNDNAME_NO_RETURN_UDT_MODEL = 0x00000400U,
}

enum uint UNDNAME_32_BIT_DECODE = 0x00000800U;

enum : uint
{
    UNDNAME_NAME_ONLY       = 0x00001000U,
    UNDNAME_NO_ARGUMENTS    = 0x00002000U,
    UNDNAME_NO_SPECIAL_SYMS = 0x00004000U,
}

enum uint DBHHEADER_PDBGUID = 0x00000003U;

enum : uint
{
    INLINE_FRAME_CONTEXT_INIT   = 0x00000000U,
    INLINE_FRAME_CONTEXT_IGNORE = 0xffffffffU,
}

enum uint TARGET_ATTRIBUTE_PACMASK = 0x00000001U;

enum : uint
{
    SYM_STKWALK_DEFAULT         = 0x00000000U,
    SYM_STKWALK_FORCE_FRAMEPTR  = 0x00000001U,
    SYM_STKWALK_ZEROEXTEND_PTRS = 0x00000002U,
}

enum uint API_VERSION_NUMBER = 0x0000000cU;

enum : uint
{
    SYMFLAG_NULL           = 0x00080000U,
    SYMFLAG_FUNC_NO_RETURN = 0x00100000U,
}

enum uint SYMFLAG_SYNTHETIC_ZEROBASE = 0x00200000U;

enum : uint
{
    SYMFLAG_PUBLIC_CODE       = 0x00400000U,
    SYMFLAG_REGREL_ALIASINDIR = 0x00800000U,
}

enum uint SYMFLAG_FIXUP_ARM64X = 0x01000000U;

enum : uint
{
    SYMFLAG_GLOBAL  = 0x02000000U,
    SYMFLAG_COMPLEX = 0x04000000U,
    SYMFLAG_RESET   = 0x80000000U,
}

enum : uint
{
    IMAGEHLP_MODULE_REGION_DLLBASE    = 0x00000001U,
    IMAGEHLP_MODULE_REGION_DLLRANGE   = 0x00000002U,
    IMAGEHLP_MODULE_REGION_ADDITIONAL = 0x00000004U,
    IMAGEHLP_MODULE_REGION_JIT        = 0x00000008U,
    IMAGEHLP_MODULE_REGION_ALL        = 0x000000ffU,
}

enum : uint
{
    CBA_DEFERRED_SYMBOL_LOAD_START    = 0x00000001U,
    CBA_DEFERRED_SYMBOL_LOAD_COMPLETE = 0x00000002U,
    CBA_DEFERRED_SYMBOL_LOAD_FAILURE  = 0x00000003U,
}

enum uint CBA_SYMBOLS_UNLOADED = 0x00000004U;
enum uint CBA_DUPLICATE_SYMBOL = 0x00000005U;
enum uint CBA_READ_MEMORY = 0x00000006U;
enum uint CBA_DEFERRED_SYMBOL_LOAD_CANCEL = 0x00000007U;
enum uint CBA_SET_OPTIONS = 0x00000008U;

enum : uint
{
    CBA_EVENT                        = 0x00000010U,
    CBA_DEFERRED_SYMBOL_LOAD_PARTIAL = 0x00000020U,
}

enum uint CBA_DEBUG_INFO = 0x10000000U;

enum : uint
{
    CBA_SRCSRV_INFO  = 0x20000000U,
    CBA_SRCSRV_EVENT = 0x40000000U,
}

enum uint CBA_UPDATE_STATUS_BAR = 0x50000000U;
enum uint CBA_ENGINE_PRESENT = 0x60000000U;
enum uint CBA_CHECK_ENGOPT_DISALLOW_NETWORK_PATHS = 0x70000000U;
enum uint CBA_CHECK_ARM_MACHINE_THUMB_TYPE_OVERRIDE = 0x80000000U;
enum uint CBA_XML_LOG = 0x90000000U;
enum uint CBA_MAP_JIT_SYMBOL = 0xa0000000U;

enum : uint
{
    EVENT_SRCSPEW_START = 0x00000064U,
    EVENT_SRCSPEW       = 0x00000064U,
    EVENT_SRCSPEW_END   = 0x000000c7U,
}

enum : uint
{
    DSLFLAG_MISMATCHED_PDB = 0x00000001U,
    DSLFLAG_MISMATCHED_DBG = 0x00000002U,
}

enum : uint
{
    FLAG_ENGINE_PRESENT                = 0x00000004U,
    FLAG_ENGOPT_DISALLOW_NETWORK_PATHS = 0x00000008U,
}

enum uint FLAG_OVERRIDE_ARM_MACHINE_TYPE = 0x00000010U;
enum uint SYMOPT_CASE_INSENSITIVE = 0x00000001U;

enum : uint
{
    SYMOPT_UNDNAME        = 0x00000002U,
    SYMOPT_DEFERRED_LOADS = 0x00000004U,
}

enum : uint
{
    SYMOPT_NO_CPP            = 0x00000008U,
    SYMOPT_LOAD_LINES        = 0x00000010U,
    SYMOPT_OMAP_FIND_NEAREST = 0x00000020U,
}

enum uint SYMOPT_LOAD_ANYTHING = 0x00000040U;
enum uint SYMOPT_IGNORE_CVREC = 0x00000080U;
enum uint SYMOPT_NO_UNQUALIFIED_LOADS = 0x00000100U;
enum uint SYMOPT_FAIL_CRITICAL_ERRORS = 0x00000200U;
enum uint SYMOPT_EXACT_SYMBOLS = 0x00000400U;
enum uint SYMOPT_ALLOW_ABSOLUTE_SYMBOLS = 0x00000800U;
enum uint SYMOPT_IGNORE_NT_SYMPATH = 0x00001000U;
enum uint SYMOPT_INCLUDE_32BIT_MODULES = 0x00002000U;
enum uint SYMOPT_PUBLICS_ONLY = 0x00004000U;

enum : uint
{
    SYMOPT_NO_PUBLICS   = 0x00008000U,
    SYMOPT_AUTO_PUBLICS = 0x00010000U,
}

enum uint SYMOPT_NO_IMAGE_SEARCH = 0x00020000U;

enum : uint
{
    SYMOPT_SECURE          = 0x00040000U,
    SYMOPT_NO_PROMPTS      = 0x00080000U,
    SYMOPT_OVERWRITE       = 0x00100000U,
    SYMOPT_IGNORE_IMAGEDIR = 0x00200000U,
}

enum uint SYMOPT_FLAT_DIRECTORY = 0x00400000U;
enum uint SYMOPT_FAVOR_COMPRESSED = 0x00800000U;
enum uint SYMOPT_ALLOW_ZERO_ADDRESS = 0x01000000U;
enum uint SYMOPT_DISABLE_SYMSRV_AUTODETECT = 0x02000000U;
enum uint SYMOPT_READONLY_CACHE = 0x04000000U;
enum uint SYMOPT_SYMPATH_LAST = 0x08000000U;

enum : uint
{
    SYMOPT_DISABLE_FAST_SYMBOLS       = 0x10000000U,
    SYMOPT_DISABLE_SYMSRV_TIMEOUT     = 0x20000000U,
    SYMOPT_DISABLE_SRVSTAR_ON_STARTUP = 0x40000000U,
}

enum uint SYMOPT_DEBUG = 0x80000000U;

enum : uint
{
    SYM_INLINE_COMP_ERROR     = 0x00000000U,
    SYM_INLINE_COMP_IDENTICAL = 0x00000001U,
    SYM_INLINE_COMP_STEPIN    = 0x00000002U,
    SYM_INLINE_COMP_STEPOUT   = 0x00000003U,
    SYM_INLINE_COMP_STEPOVER  = 0x00000004U,
    SYM_INLINE_COMP_DIFFERENT = 0x00000005U,
}

enum : uint
{
    ESLFLAG_FULLPATH    = 0x00000001U,
    ESLFLAG_NEAREST     = 0x00000002U,
    ESLFLAG_PREV        = 0x00000004U,
    ESLFLAG_NEXT        = 0x00000008U,
    ESLFLAG_INLINE_SITE = 0x00000010U,
}

enum : uint
{
    SYMENUM_OPTIONS_DEFAULT = 0x00000001U,
    SYMENUM_OPTIONS_INLINE  = 0x00000002U,
}

enum : uint
{
    SYMSEARCH_MASKOBJS    = 0x00000001U,
    SYMSEARCH_RECURSE     = 0x00000002U,
    SYMSEARCH_GLOBALSONLY = 0x00000004U,
    SYMSEARCH_ALLITEMS    = 0x00000008U,
}

enum uint EXT_OUTPUT_VER = 0x00000001U;
enum uint SYMSRV_VERSION = 0x00000002U;

enum : uint
{
    SSRVOPT_CALLBACK         = 0x00000001U,
    SSRVOPT_OLDGUIDPTR       = 0x00000010U,
    SSRVOPT_UNATTENDED       = 0x00000020U,
    SSRVOPT_NOCOPY           = 0x00000040U,
    SSRVOPT_GETPATH          = 0x00000040U,
    SSRVOPT_PARENTWIN        = 0x00000080U,
    SSRVOPT_PARAMTYPE        = 0x00000100U,
    SSRVOPT_SECURE           = 0x00000200U,
    SSRVOPT_TRACE            = 0x00000400U,
    SSRVOPT_SETCONTEXT       = 0x00000800U,
    SSRVOPT_PROXY            = 0x00001000U,
    SSRVOPT_DOWNSTREAM_STORE = 0x00002000U,
}

enum : uint
{
    SSRVOPT_OVERWRITE          = 0x00004000U,
    SSRVOPT_RESETTOU           = 0x00008000U,
    SSRVOPT_CALLBACKW          = 0x00010000U,
    SSRVOPT_FLAT_DEFAULT_STORE = 0x00020000U,
}

enum : uint
{
    SSRVOPT_PROXYW           = 0x00040000U,
    SSRVOPT_MESSAGE          = 0x00080000U,
    SSRVOPT_SERVICE          = 0x00100000U,
    SSRVOPT_FAVOR_COMPRESSED = 0x00200000U,
}

enum : uint
{
    SSRVOPT_STRING          = 0x00400000U,
    SSRVOPT_WINHTTP         = 0x00800000U,
    SSRVOPT_WININET         = 0x01000000U,
    SSRVOPT_DONT_UNCOMPRESS = 0x02000000U,
}

enum : uint
{
    SSRVOPT_DISABLE_PING_HOST = 0x04000000U,
    SSRVOPT_DISABLE_TIMEOUT   = 0x08000000U,
}

enum uint SSRVOPT_ENABLE_COMM_MSG = 0x10000000U;

enum : uint
{
    SSRVOPT_URI_FILTER     = 0x20000000U,
    SSRVOPT_URI_TIERS      = 0x40000000U,
    SSRVOPT_RETRY_APP_HANG = 0x80000000U,
}

enum uint SSRVOPT_MAX = 0x80000000U;
enum uint NUM_SSRVOPTS = 0x00000020U;

enum : uint
{
    SSRVURI_HTTP_NORMAL     = 0x00000001U,
    SSRVURI_HTTP_COMPRESSED = 0x00000002U,
    SSRVURI_HTTP_FILEPTR    = 0x00000004U,
}

enum : uint
{
    SSRVURI_UNC_NORMAL     = 0x00000010U,
    SSRVURI_UNC_COMPRESSED = 0x00000020U,
    SSRVURI_UNC_FILEPTR    = 0x00000040U,
    SSRVURI_HTTP_MASK      = 0x0000000fU,
    SSRVURI_UNC_MASK       = 0x000000f0U,
    SSRVURI_ALL            = 0x000000ffU,
    SSRVURI_NORMAL         = 0x00000001U,
    SSRVURI_COMPRESSED     = 0x00000002U,
    SSRVURI_FILEPTR        = 0x00000004U,
}

enum : uint
{
    SSRVACTION_TRACE          = 0x00000001U,
    SSRVACTION_QUERYCANCEL    = 0x00000002U,
    SSRVACTION_EVENT          = 0x00000003U,
    SSRVACTION_EVENTW         = 0x00000004U,
    SSRVACTION_SIZE           = 0x00000005U,
    SSRVACTION_HTTPSTATUS     = 0x00000006U,
    SSRVACTION_XMLOUTPUT      = 0x00000007U,
    SSRVACTION_CHECKSUMSTATUS = 0x00000008U,
}

enum : uint
{
    SYMSTOREOPT_ALT_INDEX = 0x00000010U,
    SYMSTOREOPT_UNICODE   = 0x00000020U,
}

enum : uint
{
    SYMF_OMAP_GENERATED = 0x00000001U,
    SYMF_OMAP_MODIFIED  = 0x00000002U,
}

enum : uint
{
    SYMF_REGISTER = 0x00000008U,
    SYMF_REGREL   = 0x00000010U,
    SYMF_FRAMEREL = 0x00000020U,
}

enum uint SYMF_PARAMETER = 0x00000040U;

enum : uint
{
    SYMF_LOCAL    = 0x00000080U,
    SYMF_CONSTANT = 0x00000100U,
}

enum : uint
{
    SYMF_EXPORT    = 0x00000200U,
    SYMF_FORWARDER = 0x00000400U,
    SYMF_FUNCTION  = 0x00000800U,
}

enum : uint
{
    SYMF_VIRTUAL = 0x00001000U,
    SYMF_THUNK   = 0x00002000U,
    SYMF_TLSREL  = 0x00004000U,
}

enum : uint
{
    IMAGEHLP_SYMBOL_INFO_VALUEPRESENT  = 0x00000001U,
    IMAGEHLP_SYMBOL_INFO_REGISTER      = 0x00000008U,
    IMAGEHLP_SYMBOL_INFO_REGRELATIVE   = 0x00000010U,
    IMAGEHLP_SYMBOL_INFO_FRAMERELATIVE = 0x00000020U,
    IMAGEHLP_SYMBOL_INFO_PARAMETER     = 0x00000040U,
    IMAGEHLP_SYMBOL_INFO_LOCAL         = 0x00000080U,
    IMAGEHLP_SYMBOL_INFO_CONSTANT      = 0x00000100U,
    IMAGEHLP_SYMBOL_FUNCTION           = 0x00000800U,
    IMAGEHLP_SYMBOL_VIRTUAL            = 0x00001000U,
    IMAGEHLP_SYMBOL_THUNK              = 0x00002000U,
    IMAGEHLP_SYMBOL_INFO_TLSRELATIVE   = 0x00004000U,
}

enum : uint
{
    IMAGEHLP_RMAP_MAPPED_FLAT           = 0x00000001U,
    IMAGEHLP_RMAP_BIG_ENDIAN            = 0x00000002U,
    IMAGEHLP_RMAP_IGNORE_MISCOMPARE     = 0x00000004U,
    IMAGEHLP_RMAP_FIXUP_ARM64X          = 0x10000000U,
    IMAGEHLP_RMAP_LOAD_RW_DATA_SECTIONS = 0x20000000U,
}

enum uint IMAGEHLP_RMAP_OMIT_SHARED_RW_DATA_SECTIONS = 0x40000000U;
enum uint IMAGEHLP_RMAP_FIXUP_IMAGEBASE = 0x80000000U;
enum uint DMP_PHYSICAL_MEMORY_BLOCK_SIZE_32 = 0x000002bcU;
enum uint DMP_CONTEXT_RECORD_SIZE_32 = 0x000004b0U;

enum : uint
{
    DMP_RESERVED_0_SIZE_32 = 0x000006e0U,
    DMP_RESERVED_2_SIZE_32 = 0x00000010U,
    DMP_RESERVED_3_SIZE_32 = 0x00000038U,
}

enum uint DMP_PHYSICAL_MEMORY_BLOCK_SIZE_64 = 0x000002bcU;
enum uint DMP_CONTEXT_RECORD_SIZE_64 = 0x00000bb8U;
enum uint DMP_RESERVED_0_SIZE_64 = 0x00000fa8U;
enum uint DMP_HEADER_COMMENT_SIZE = 0x00000080U;

enum : uint
{
    DUMP_SUMMARY_VALID_KERNEL_VA       = 0x00000001U,
    DUMP_SUMMARY_VALID_CURRENT_USER_VA = 0x00000002U,
}

enum : uint
{
    MINIDUMP_VERSION                    = 0x0000a793U,
    MINIDUMP_MISC1_PROCESSOR_POWER_INFO = 0x00000004U,
}

enum : uint
{
    MINIDUMP_MISC3_PROCESS_INTEGRITY     = 0x00000010U,
    MINIDUMP_MISC3_PROCESS_EXECUTE_FLAGS = 0x00000020U,
    MINIDUMP_MISC3_TIMEZONE              = 0x00000040U,
    MINIDUMP_MISC3_PROTECTED_PROCESS     = 0x00000080U,
    MINIDUMP_MISC4_BUILDSTRING           = 0x00000100U,
    MINIDUMP_MISC5_PROCESS_COOKIE        = 0x00000200U,
}

enum uint MINIDUMP_SYSMEMINFO1_FILECACHE_TRANSITIONREPURPOSECOUNT_FLAGS = 0x00000001U;

enum : uint
{
    MINIDUMP_SYSMEMINFO1_BASICPERF                                     = 0x00000002U,
    MINIDUMP_SYSMEMINFO1_PERF_CCTOTALDIRTYPAGES_CCDIRTYPAGETHRESHOLD   = 0x00000004U,
    MINIDUMP_SYSMEMINFO1_PERF_RESIDENTAVAILABLEPAGES_SHAREDCOMMITPAGES = 0x00000008U,
}

enum uint MINIDUMP_SYSMEMINFO1_PERF_MDLPAGESALLOCATED_PFNDATABASECOMMITTEDPAGES = 0x00000010U;
enum uint MINIDUMP_SYSMEMINFO1_PERF_SYSTEMPAGETABLECOMMITTEDPAGES_CONTIGUOUSPAGESALLOCATED = 0x00000020U;

enum : uint
{
    MINIDUMP_PROCESS_VM_COUNTERS             = 0x00000001U,
    MINIDUMP_PROCESS_VM_COUNTERS_VIRTUALSIZE = 0x00000002U,
    MINIDUMP_PROCESS_VM_COUNTERS_EX          = 0x00000004U,
    MINIDUMP_PROCESS_VM_COUNTERS_EX2         = 0x00000008U,
    MINIDUMP_PROCESS_VM_COUNTERS_JOB         = 0x00000010U,
}

enum : uint
{
    INTERFACESAFE_FOR_UNTRUSTED_CALLER = 0x00000001U,
    INTERFACESAFE_FOR_UNTRUSTED_DATA   = 0x00000002U,
}

enum : uint
{
    INTERFACE_USES_DISPEX           = 0x00000004U,
    INTERFACE_USES_SECURITY_MANAGER = 0x00000008U,
}

enum uint WCT_MAX_NODE_COUNT = 0x00000010U;
enum uint WCT_OBJNAME_LENGTH = 0x00000080U;
enum uint WCT_NETWORK_IO_FLAG = 0x00000008U;

enum : uint
{
    WHEA_ERROR_SOURCE_DESCRIPTOR_VERSION_10 = 0x0000000aU,
    WHEA_ERROR_SOURCE_DESCRIPTOR_VERSION_11 = 0x0000000bU,
}

enum uint WHEA_MAX_MC_BANKS = 0x00000020U;

enum : uint
{
    WHEA_ERROR_SOURCE_FLAG_FIRMWAREFIRST = 0x00000001U,
    WHEA_ERROR_SOURCE_FLAG_GLOBAL        = 0x00000002U,
    WHEA_ERROR_SOURCE_FLAG_GHES_ASSIST   = 0x00000004U,
    WHEA_ERROR_SOURCE_FLAG_DEFAULTSOURCE = 0x80000000U,
}

enum uint WHEA_ERR_SRC_OVERRIDE_FLAG = 0x40000000U;

enum : uint
{
    WHEA_ERROR_SOURCE_INVALID_RELATED_SOURCE      = 0x0000ffffU,
    WHEA_ERROR_SOURCE_DESCRIPTOR_TYPE_XPFMCE      = 0x00000000U,
    WHEA_ERROR_SOURCE_DESCRIPTOR_TYPE_XPFCMC      = 0x00000001U,
    WHEA_ERROR_SOURCE_DESCRIPTOR_TYPE_XPFNMI      = 0x00000002U,
    WHEA_ERROR_SOURCE_DESCRIPTOR_TYPE_IPFMCA      = 0x00000003U,
    WHEA_ERROR_SOURCE_DESCRIPTOR_TYPE_IPFCMC      = 0x00000004U,
    WHEA_ERROR_SOURCE_DESCRIPTOR_TYPE_IPFCPE      = 0x00000005U,
    WHEA_ERROR_SOURCE_DESCRIPTOR_TYPE_AERROOTPORT = 0x00000006U,
    WHEA_ERROR_SOURCE_DESCRIPTOR_TYPE_AERENDPOINT = 0x00000007U,
    WHEA_ERROR_SOURCE_DESCRIPTOR_TYPE_AERBRIDGE   = 0x00000008U,
    WHEA_ERROR_SOURCE_DESCRIPTOR_TYPE_GENERIC     = 0x00000009U,
    WHEA_ERROR_SOURCE_DESCRIPTOR_TYPE_GENERIC_V2  = 0x0000000aU,
}

enum : uint
{
    WHEA_XPF_MC_BANK_STATUSFORMAT_IA32MCA    = 0x00000000U,
    WHEA_XPF_MC_BANK_STATUSFORMAT_Intel64MCA = 0x00000001U,
    WHEA_XPF_MC_BANK_STATUSFORMAT_AMD64MCA   = 0x00000002U,
}

enum : uint
{
    WHEA_NOTIFICATION_TYPE_POLLED                 = 0x00000000U,
    WHEA_NOTIFICATION_TYPE_EXTERNALINTERRUPT      = 0x00000001U,
    WHEA_NOTIFICATION_TYPE_LOCALINTERRUPT         = 0x00000002U,
    WHEA_NOTIFICATION_TYPE_SCI                    = 0x00000003U,
    WHEA_NOTIFICATION_TYPE_NMI                    = 0x00000004U,
    WHEA_NOTIFICATION_TYPE_CMCI                   = 0x00000005U,
    WHEA_NOTIFICATION_TYPE_MCE                    = 0x00000006U,
    WHEA_NOTIFICATION_TYPE_GPIO_SIGNAL            = 0x00000007U,
    WHEA_NOTIFICATION_TYPE_ARMV8_SEA              = 0x00000008U,
    WHEA_NOTIFICATION_TYPE_ARMV8_SEI              = 0x00000009U,
    WHEA_NOTIFICATION_TYPE_EXTERNALINTERRUPT_GSIV = 0x0000000aU,
    WHEA_NOTIFICATION_TYPE_SDEI                   = 0x0000000bU,
}

enum : uint
{
    WHEA_DEVICE_DRIVER_CONFIG_V1      = 0x00000001U,
    WHEA_DEVICE_DRIVER_CONFIG_V2      = 0x00000002U,
    WHEA_DEVICE_DRIVER_CONFIG_MIN     = 0x00000001U,
    WHEA_DEVICE_DRIVER_CONFIG_MAX     = 0x00000002U,
    WHEA_DEVICE_DRIVER_BUFFER_SET_V1  = 0x00000001U,
    WHEA_DEVICE_DRIVER_BUFFER_SET_MIN = 0x00000001U,
    WHEA_DEVICE_DRIVER_BUFFER_SET_MAX = 0x00000001U,
}

enum uint WHEA_DISABLE_OFFLINE = 0x00000000U;

enum : uint
{
    WHEA_MEM_PERSISTOFFLINE = 0x00000001U,
    WHEA_MEM_PFA_DISABLE    = 0x00000002U,
    WHEA_MEM_PFA_PAGECOUNT  = 0x00000003U,
    WHEA_MEM_PFA_THRESHOLD  = 0x00000004U,
    WHEA_MEM_PFA_TIMEOUT    = 0x00000005U,
}

enum uint WHEA_DISABLE_DUMMY_WRITE = 0x00000006U;

enum : uint
{
    WHEA_RESTORE_CMCI_ENABLED   = 0x00000007U,
    WHEA_RESTORE_CMCI_ATTEMPTS  = 0x00000008U,
    WHEA_RESTORE_CMCI_ERR_LIMIT = 0x00000009U,
}

enum : uint
{
    WHEA_CMCI_THRESHOLD_COUNT      = 0x0000000aU,
    WHEA_CMCI_THRESHOLD_TIME       = 0x0000000bU,
    WHEA_CMCI_THRESHOLD_POLL_COUNT = 0x0000000cU,
}

enum uint WHEA_PENDING_PAGE_LIST_SZ = 0x0000000dU;

enum : uint
{
    WHEA_BAD_PAGE_LIST_MAX_SIZE = 0x0000000eU,
    WHEA_BAD_PAGE_LIST_LOCATION = 0x0000000fU,
}

enum uint WHEA_NOTIFY_ALL_OFFLINES = 0x00000010U;

enum : uint
{
    WHEA_ROW_FAIL_CHECK_EXTENT    = 0x00000011U,
    WHEA_ROW_FAIL_CHECK_ENABLE    = 0x00000012U,
    WHEA_ROW_FAIL_CHECK_THRESHOLD = 0x00000013U,
}

enum uint WHEA_DISABLE_PRM_ADDRESS_TRANSLATION = 0x00000014U;
enum uint WHEA_ENABLE_BATCHED_ROW_OFFLINE = 0x00000015U;

enum : uint
{
    IPMI_OS_SEL_RECORD_VERSION_1 = 0x00000001U,
    IPMI_OS_SEL_RECORD_VERSION   = 0x00000001U,
}

enum uint IPMI_IOCTL_INDEX = 0x00000400U;
enum uint IOCTL_IPMI_INTERNAL_RECORD_SEL_EVENT = 0x00221000U;
enum uint IPMI_OS_SEL_RECORD_MASK = 0x0000ffffU;
enum int sevMax = 0x00000004;

// Callbacks


version(AArch64)
{
    alias PGET_RUNTIME_FUNCTION_CALLBACK = IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY* function(ulong ControlPc, void* Context);
}

version(X86_64)
{
    alias PGET_RUNTIME_FUNCTION_CALLBACK = IMAGE_RUNTIME_FUNCTION_ENTRY* function(ulong ControlPc, void* Context);
}
alias PVECTORED_EXCEPTION_HANDLER = int function(EXCEPTION_POINTERS* ExceptionInfo);
alias LPTOP_LEVEL_EXCEPTION_FILTER = int function(EXCEPTION_POINTERS* ExceptionInfo);
alias PWAITCHAINCALLBACK = void function(void* WctHandle, size_t Context, uint CallbackStatus, uint* NodeCount, 
                                         WAITCHAIN_NODE_INFO* NodeInfoArray, BOOL* IsCycle);
alias PCOGETCALLSTATE = HRESULT function(int param0, uint* param1);
alias PCOGETACTIVATIONSTATE = HRESULT function(GUID param0, uint param1, uint* param2);
alias MINIDUMP_CALLBACK_ROUTINE = BOOL function(void* CallbackParam, MINIDUMP_CALLBACK_INPUT* CallbackInput, 
                                                MINIDUMP_CALLBACK_OUTPUT* CallbackOutput);
alias PIMAGEHLP_STATUS_ROUTINE = BOOL function(IMAGEHLP_STATUS_REASON Reason, const(PSTR) ImageName, 
                                               const(PSTR) DllName, size_t Va, size_t Parameter);
alias PIMAGEHLP_STATUS_ROUTINE32 = BOOL function(IMAGEHLP_STATUS_REASON Reason, const(PSTR) ImageName, 
                                                 const(PSTR) DllName, uint Va, size_t Parameter);
alias PIMAGEHLP_STATUS_ROUTINE64 = BOOL function(IMAGEHLP_STATUS_REASON Reason, const(PSTR) ImageName, 
                                                 const(PSTR) DllName, ulong Va, size_t Parameter);
alias DIGEST_FUNCTION = BOOL function(void* refdata, ubyte* pData, uint dwLength);
alias PFIND_DEBUG_FILE_CALLBACK = BOOL function(HANDLE FileHandle, const(PSTR) FileName, void* CallerData);
alias PFIND_DEBUG_FILE_CALLBACKW = BOOL function(HANDLE FileHandle, const(PWSTR) FileName, void* CallerData);
alias PFINDFILEINPATHCALLBACK = BOOL function(const(PSTR) filename, void* context);
alias PFINDFILEINPATHCALLBACKW = BOOL function(const(PWSTR) filename, void* context);
alias PFIND_EXE_FILE_CALLBACK = BOOL function(HANDLE FileHandle, const(PSTR) FileName, void* CallerData);
alias PFIND_EXE_FILE_CALLBACKW = BOOL function(HANDLE FileHandle, const(PWSTR) FileName, void* CallerData);
alias PENUMDIRTREE_CALLBACK = BOOL function(const(PSTR) FilePath, void* CallerData);
alias PENUMDIRTREE_CALLBACKW = BOOL function(const(PWSTR) FilePath, void* CallerData);
alias PREAD_PROCESS_MEMORY_ROUTINE64 = BOOL function(HANDLE hProcess, ulong qwBaseAddress, 
                                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                                                     uint nSize, uint* lpNumberOfBytesRead);
alias PFUNCTION_TABLE_ACCESS_ROUTINE64 = void* function(HANDLE ahProcess, ulong AddrBase);
alias PGET_MODULE_BASE_ROUTINE64 = ulong function(HANDLE hProcess, ulong Address);
alias PTRANSLATE_ADDRESS_ROUTINE64 = ulong function(HANDLE hProcess, HANDLE hThread, ADDRESS64* lpaddr);
alias PGET_TARGET_ATTRIBUTE_VALUE64 = BOOL function(HANDLE hProcess, uint Attribute, ulong AttributeData, 
                                                    ulong* AttributeValue);

version(X86)
{
    alias PREAD_PROCESS_MEMORY_ROUTINE = BOOL function(HANDLE hProcess, uint lpBaseAddress, 
                                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                                                   uint nSize, uint* lpNumberOfBytesRead);
}

version(X86)
{
    alias PFUNCTION_TABLE_ACCESS_ROUTINE = void* function(HANDLE hProcess, uint AddrBase);
}

version(X86)
{
    alias PGET_MODULE_BASE_ROUTINE = uint function(HANDLE hProcess, uint Address);
}

version(X86)
{
    alias PTRANSLATE_ADDRESS_ROUTINE = uint function(HANDLE hProcess, HANDLE hThread, ADDRESS* lpaddr);
}
alias PSYM_ENUMMODULES_CALLBACK64 = BOOL function(const(PSTR) ModuleName, ulong BaseOfDll, void* UserContext);
alias PSYM_ENUMMODULES_CALLBACKW64 = BOOL function(const(PWSTR) ModuleName, ulong BaseOfDll, void* UserContext);
alias PENUMLOADED_MODULES_CALLBACK64 = BOOL function(const(PSTR) ModuleName, ulong ModuleBase, uint ModuleSize, 
                                                     void* UserContext);
alias PENUMLOADED_MODULES_CALLBACKW64 = BOOL function(const(PWSTR) ModuleName, ulong ModuleBase, uint ModuleSize, 
                                                      void* UserContext);
alias PSYM_ENUMSYMBOLS_CALLBACK64 = BOOL function(const(PSTR) SymbolName, ulong SymbolAddress, uint SymbolSize, 
                                                  void* UserContext);
alias PSYM_ENUMSYMBOLS_CALLBACK64W = BOOL function(const(PWSTR) SymbolName, ulong SymbolAddress, uint SymbolSize, 
                                                   void* UserContext);
alias PSYMBOL_REGISTERED_CALLBACK64 = BOOL function(HANDLE hProcess, uint ActionCode, ulong CallbackData, 
                                                    ulong UserContext);
alias PSYMBOL_FUNCENTRY_CALLBACK = void* function(HANDLE hProcess, uint AddrBase, void* UserContext);
alias PSYMBOL_FUNCENTRY_CALLBACK64 = void* function(HANDLE hProcess, ulong AddrBase, ulong UserContext);

version(X86)
{
    alias PSYM_ENUMMODULES_CALLBACK = BOOL function(const(PSTR) ModuleName, uint BaseOfDll, void* UserContext);
}

version(X86)
{
    alias PSYM_ENUMSYMBOLS_CALLBACK = BOOL function(const(PSTR) SymbolName, uint SymbolAddress, uint SymbolSize, 
                                                void* UserContext);
}

version(X86)
{
    alias PSYM_ENUMSYMBOLS_CALLBACKW = BOOL function(const(PWSTR) SymbolName, uint SymbolAddress, uint SymbolSize, 
                                                 void* UserContext);
}

version(X86)
{
    alias PENUMLOADED_MODULES_CALLBACK = BOOL function(const(PSTR) ModuleName, uint ModuleBase, uint ModuleSize, 
                                                   void* UserContext);
}

version(X86)
{
    alias PSYMBOL_REGISTERED_CALLBACK = BOOL function(HANDLE hProcess, uint ActionCode, void* CallbackData, 
                                                  void* UserContext);
}
alias PSYM_ENUMSOURCEFILES_CALLBACK = BOOL function(SOURCEFILE* pSourceFile, void* UserContext);
alias PSYM_ENUMSOURCEFILES_CALLBACKW = BOOL function(SOURCEFILEW* pSourceFile, void* UserContext);
alias PSYM_ENUMLINES_CALLBACK = BOOL function(SRCCODEINFO* LineInfo, void* UserContext);
alias PSYM_ENUMLINES_CALLBACKW = BOOL function(SRCCODEINFOW* LineInfo, void* UserContext);
alias PENUMSOURCEFILETOKENSCALLBACK = BOOL function(void* token, size_t size);
alias PSYM_ENUMPROCESSES_CALLBACK = BOOL function(HANDLE hProcess, void* UserContext);
alias PSYM_ENUMERATESYMBOLS_CALLBACK = BOOL function(SYMBOL_INFO* pSymInfo, uint SymbolSize, void* UserContext);
alias PSYM_ENUMERATESYMBOLS_CALLBACKW = BOOL function(SYMBOL_INFOW* pSymInfo, uint SymbolSize, void* UserContext);
alias SYMADDSOURCESTREAM = BOOL function(HANDLE param0, ulong param1, const(PSTR) param2, ubyte* param3, 
                                         size_t param4);
alias SYMADDSOURCESTREAMA = BOOL function(HANDLE param0, ulong param1, const(PSTR) param2, ubyte* param3, 
                                          size_t param4);
alias PDBGHELP_CREATE_USER_DUMP_CALLBACK = BOOL function(uint DataType, void** Data, uint* DataLength, 
                                                         void* UserData);
alias PSYMBOLSERVERPROC = BOOL function(const(PSTR) param0, const(PSTR) param1, void* param2, uint param3, 
                                        uint param4, PSTR param5);
alias PSYMBOLSERVERPROCA = BOOL function(const(PSTR) param0, const(PSTR) param1, void* param2, uint param3, 
                                         uint param4, PSTR param5);
alias PSYMBOLSERVERPROCW = BOOL function(const(PWSTR) param0, const(PWSTR) param1, void* param2, uint param3, 
                                         uint param4, PWSTR param5);
alias PSYMBOLSERVERBYINDEXPROC = BOOL function(const(PSTR) param0, const(PSTR) param1, const(PSTR) param2, 
                                               PSTR param3);
alias PSYMBOLSERVERBYINDEXPROCA = BOOL function(const(PSTR) param0, const(PSTR) param1, const(PSTR) param2, 
                                                PSTR param3);
alias PSYMBOLSERVERBYINDEXPROCW = BOOL function(const(PWSTR) param0, const(PWSTR) param1, const(PWSTR) param2, 
                                                PWSTR param3);
alias PSYMBOLSERVEROPENPROC = BOOL function();
alias PSYMBOLSERVERCLOSEPROC = BOOL function();
alias PSYMBOLSERVERSETOPTIONSPROC = BOOL function(size_t param0, ulong param1);
alias PSYMBOLSERVERSETOPTIONSWPROC = BOOL function(size_t param0, ulong param1);
alias PSYMBOLSERVERCALLBACKPROC = BOOL function(size_t action, ulong data, ulong context);
alias PSYMBOLSERVERGETOPTIONSPROC = size_t function();
alias PSYMBOLSERVERPINGPROC = BOOL function(const(PSTR) param0);
alias PSYMBOLSERVERPINGPROCA = BOOL function(const(PSTR) param0);
alias PSYMBOLSERVERPINGPROCW = BOOL function(const(PWSTR) param0);
alias PSYMBOLSERVERGETVERSION = BOOL function(API_VERSION* param0);
alias PSYMBOLSERVERDELTANAME = BOOL function(const(PSTR) param0, void* param1, uint param2, uint param3, 
                                             void* param4, uint param5, uint param6, PSTR param7, size_t param8);
alias PSYMBOLSERVERDELTANAMEW = BOOL function(const(PWSTR) param0, void* param1, uint param2, uint param3, 
                                              void* param4, uint param5, uint param6, PWSTR param7, size_t param8);
alias PSYMBOLSERVERGETSUPPLEMENT = BOOL function(const(PSTR) param0, const(PSTR) param1, const(PSTR) param2, 
                                                 PSTR param3, size_t param4);
alias PSYMBOLSERVERGETSUPPLEMENTW = BOOL function(const(PWSTR) param0, const(PWSTR) param1, const(PWSTR) param2, 
                                                  PWSTR param3, size_t param4);
alias PSYMBOLSERVERSTORESUPPLEMENT = BOOL function(const(PSTR) param0, const(PSTR) param1, const(PSTR) param2, 
                                                   PSTR param3, size_t param4, uint param5);
alias PSYMBOLSERVERSTORESUPPLEMENTW = BOOL function(const(PWSTR) param0, const(PWSTR) param1, const(PWSTR) param2, 
                                                    PWSTR param3, size_t param4, uint param5);
alias PSYMBOLSERVERGETINDEXSTRING = BOOL function(void* param0, uint param1, uint param2, PSTR param3, 
                                                  size_t param4);
alias PSYMBOLSERVERGETINDEXSTRINGW = BOOL function(void* param0, uint param1, uint param2, PWSTR param3, 
                                                   size_t param4);
alias PSYMBOLSERVERSTOREFILE = BOOL function(const(PSTR) param0, const(PSTR) param1, void* param2, uint param3, 
                                             uint param4, PSTR param5, size_t param6, uint param7);
alias PSYMBOLSERVERSTOREFILEW = BOOL function(const(PWSTR) param0, const(PWSTR) param1, void* param2, uint param3, 
                                              uint param4, PWSTR param5, size_t param6, uint param7);
alias PSYMBOLSERVERISSTORE = BOOL function(const(PSTR) param0);
alias PSYMBOLSERVERISSTOREW = BOOL function(const(PWSTR) param0);
alias PSYMBOLSERVERVERSION = uint function();
alias PSYMBOLSERVERMESSAGEPROC = BOOL function(size_t action, ulong data, ulong context);
alias PSYMBOLSERVERWEXPROC = BOOL function(const(PWSTR) param0, const(PWSTR) param1, void* param2, uint param3, 
                                           uint param4, PWSTR param5, SYMSRV_EXTENDED_OUTPUT_DATA* param6);
alias PSYMBOLSERVERPINGPROCWEX = BOOL function(const(PWSTR) param0);
alias PSYMBOLSERVERGETOPTIONDATAPROC = BOOL function(size_t param0, ulong* param1);
alias PSYMBOLSERVERSETHTTPAUTHHEADER = BOOL function(const(PWSTR) pszAuthHeader);
alias LPCALL_BACK_USER_INTERRUPT_ROUTINE = uint function();
alias WHEA_ERROR_SOURCE_INITIALIZE_DEVICE_DRIVER = NTSTATUS function(void* Context, uint ErrorSourceId);
alias WHEA_ERROR_SOURCE_UNINITIALIZE_DEVICE_DRIVER = void function(void* Context);
alias WHEA_ERROR_SOURCE_CORRECT_DEVICE_DRIVER = NTSTATUS function(void* ErrorSourceDesc, 
                                                                  uint* MaximumSectionLength);

// Structs


version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-context
    struct CONTEXT
    {
        CONTEXT_FLAGS        ContextFlags;
        uint                 Cpsr;
        union
        {
            struct
            {
                ulong X0;
                ulong X1;
                ulong X2;
                ulong X3;
                ulong X4;
                ulong X5;
                ulong X6;
                ulong X7;
                ulong X8;
                ulong X9;
                ulong X10;
                ulong X11;
                ulong X12;
                ulong X13;
                ulong X14;
                ulong X15;
                ulong X16;
                ulong X17;
                ulong X18;
                ulong X19;
                ulong X20;
                ulong X21;
                ulong X22;
                ulong X23;
                ulong X24;
                ulong X25;
                ulong X26;
                ulong X27;
                ulong X28;
                ulong Fp;
                ulong Lr;
            }
            ulong[31] X;
        }
        ulong                Sp;
        ulong                Pc;
        ARM64_NT_NEON128[32] V;
        uint                 Fpcr;
        uint                 Fpsr;
        uint[8]              Bcr;
        ulong[8]             Bvr;
        uint[2]              Wcr;
        ulong[2]             Wvr;
    }
}

version(AArch64)
{
    struct DISPATCHER_CONTEXT
    {
        size_t            ControlPc;
        size_t            ImageBase;
        IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY* FunctionEntry;
        size_t            EstablisherFrame;
        size_t            TargetPc;
        CONTEXT*          ContextRecord;
        EXCEPTION_ROUTINE LanguageHandler;
        void*             HandlerData;
        UNWIND_HISTORY_TABLE* HistoryTable;
        uint              ScopeIndex;
        BOOLEAN           ControlPcIsUnwound;
        ubyte*            NonVolatileRegisters;
    }
}

version(AArch64)
{
    struct KNONVOLATILE_CONTEXT_POINTERS
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
}

version(AArch64)
{
    struct UNWIND_HISTORY_TABLE_ENTRY
    {
        size_t ImageBase;
        IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY* FunctionEntry;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_thread_callback
    struct MINIDUMP_THREAD_CALLBACK
    {
    align (4):
        uint    ThreadId;
        HANDLE  ThreadHandle;
        uint    Pad;
        CONTEXT Context;
        uint    SizeOfContext;
        ulong   StackBase;
        ulong   StackEnd;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_thread_ex_callback
    struct MINIDUMP_THREAD_EX_CALLBACK
    {
    align (4):
        uint    ThreadId;
        HANDLE  ThreadHandle;
        uint    Pad;
        CONTEXT Context;
        uint    SizeOfContext;
        ulong   StackBase;
        ulong   StackEnd;
        ulong   BackingStoreBase;
        ulong   BackingStoreEnd;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minwinbase/ns-minwinbase-exception_debug_info
struct EXCEPTION_DEBUG_INFO
{
    EXCEPTION_RECORD ExceptionRecord;
    uint             dwFirstChance;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minwinbase/ns-minwinbase-create_thread_debug_info
struct CREATE_THREAD_DEBUG_INFO
{
    HANDLE hThread;
    void*  lpThreadLocalBase;
    LPTHREAD_START_ROUTINE lpStartAddress;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minwinbase/ns-minwinbase-create_process_debug_info
struct CREATE_PROCESS_DEBUG_INFO
{
    HANDLE hFile;
    HANDLE hProcess;
    HANDLE hThread;
    void*  lpBaseOfImage;
    uint   dwDebugInfoFileOffset;
    uint   nDebugInfoSize;
    void*  lpThreadLocalBase;
    LPTHREAD_START_ROUTINE lpStartAddress;
    void*  lpImageName;
    ushort fUnicode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minwinbase/ns-minwinbase-exit_thread_debug_info
struct EXIT_THREAD_DEBUG_INFO
{
    uint dwExitCode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minwinbase/ns-minwinbase-exit_process_debug_info
struct EXIT_PROCESS_DEBUG_INFO
{
    uint dwExitCode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minwinbase/ns-minwinbase-load_dll_debug_info
struct LOAD_DLL_DEBUG_INFO
{
    HANDLE hFile;
    void*  lpBaseOfDll;
    uint   dwDebugInfoFileOffset;
    uint   nDebugInfoSize;
    void*  lpImageName;
    ushort fUnicode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minwinbase/ns-minwinbase-unload_dll_debug_info
struct UNLOAD_DLL_DEBUG_INFO
{
    void* lpBaseOfDll;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minwinbase/ns-minwinbase-output_debug_string_info
struct OUTPUT_DEBUG_STRING_INFO
{
    PSTR   lpDebugStringData;
    ushort fUnicode;
    ushort nDebugStringLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minwinbase/ns-minwinbase-rip_info
struct RIP_INFO
{
    uint          dwError;
    RIP_INFO_TYPE dwType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minwinbase/ns-minwinbase-debug_event
struct DEBUG_EVENT
{
    DEBUG_EVENT_CODE dwDebugEventCode;
    uint             dwProcessId;
    uint             dwThreadId;
    union u
    {
        EXCEPTION_DEBUG_INFO Exception;
        CREATE_THREAD_DEBUG_INFO CreateThread;
        CREATE_PROCESS_DEBUG_INFO CreateProcessInfo;
        EXIT_THREAD_DEBUG_INFO ExitThread;
        EXIT_PROCESS_DEBUG_INFO ExitProcess;
        LOAD_DLL_DEBUG_INFO  LoadDll;
        UNLOAD_DLL_DEBUG_INFO UnloadDll;
        OUTPUT_DEBUG_STRING_INFO DebugString;
        RIP_INFO             RipInfo;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/processthreadsapi/ns-processthreadsapi-apc_callback_data
struct APC_CALLBACK_DATA
{
    size_t   Parameter;
    CONTEXT* ContextRecord;
    size_t   Reserved0;
    size_t   Reserved1;
}

version(X86_64)
{
    struct XSAVE_FORMAT
    {
        ushort    ControlWord;
        ushort    StatusWord;
        ubyte     TagWord;
        ubyte     Reserved1;
        ushort    ErrorOpcode;
        uint      ErrorOffset;
        ushort    ErrorSelector;
        ushort    Reserved2;
        uint      DataOffset;
        ushort    DataSelector;
        ushort    Reserved3;
        uint      MxCsr;
        uint      MxCsr_Mask;
        M128A[8]  FloatRegisters;
        M128A[16] XmmRegisters;
        ubyte[96] Reserved4;
    }
}

version(AArch64)
{
    struct XSAVE_FORMAT
    {
        ushort    ControlWord;
        ushort    StatusWord;
        ubyte     TagWord;
        ubyte     Reserved1;
        ushort    ErrorOpcode;
        uint      ErrorOffset;
        ushort    ErrorSelector;
        ushort    Reserved2;
        uint      DataOffset;
        ushort    DataSelector;
        ushort    Reserved3;
        uint      MxCsr;
        uint      MxCsr_Mask;
        M128A[8]  FloatRegisters;
        M128A[16] XmmRegisters;
        ubyte[96] Reserved4;
    }
}

version(X86_64)
{
    struct XSTATE_CONTEXT
    {
        ulong       Mask;
        uint        Length;
        ubyte       Flags;
        ubyte[3]    Reserved0;
        XSAVE_AREA* Area;
        void*       Buffer;
    }
}

version(AArch64)
{
    struct XSTATE_CONTEXT
    {
        ulong       Mask;
        uint        Length;
        ubyte       Flags;
        ubyte[3]    Reserved0;
        XSAVE_AREA* Area;
        void*       Buffer;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-context
    struct CONTEXT
    {
        ulong         P1Home;
        ulong         P2Home;
        ulong         P3Home;
        ulong         P4Home;
        ulong         P5Home;
        ulong         P6Home;
        CONTEXT_FLAGS ContextFlags;
        uint          MxCsr;
        ushort        SegCs;
        ushort        SegDs;
        ushort        SegEs;
        ushort        SegFs;
        ushort        SegGs;
        ushort        SegSs;
        uint          EFlags;
        ulong         Dr0;
        ulong         Dr1;
        ulong         Dr2;
        ulong         Dr3;
        ulong         Dr6;
        ulong         Dr7;
        ulong         Rax;
        ulong         Rcx;
        ulong         Rdx;
        ulong         Rbx;
        ulong         Rsp;
        ulong         Rbp;
        ulong         Rsi;
        ulong         Rdi;
        ulong         R8;
        ulong         R9;
        ulong         R10;
        ulong         R11;
        ulong         R12;
        ulong         R13;
        ulong         R14;
        ulong         R15;
        ulong         Rip;
        union
        {
            XSAVE_FORMAT FltSave;
            struct
            {
                M128A[2] Header;
                M128A[8] Legacy;
                M128A    Xmm0;
                M128A    Xmm1;
                M128A    Xmm2;
                M128A    Xmm3;
                M128A    Xmm4;
                M128A    Xmm5;
                M128A    Xmm6;
                M128A    Xmm7;
                M128A    Xmm8;
                M128A    Xmm9;
                M128A    Xmm10;
                M128A    Xmm11;
                M128A    Xmm12;
                M128A    Xmm13;
                M128A    Xmm14;
                M128A    Xmm15;
            }
        }
        M128A[26]     VectorRegister;
        ulong         VectorControl;
        ulong         DebugControl;
        ulong         LastBranchToRip;
        ulong         LastBranchFromRip;
        ulong         LastExceptionToRip;
        ulong         LastExceptionFromRip;
    }
}

version(X86_64)
{
    struct DISPATCHER_CONTEXT
    {
        ulong             ControlPc;
        ulong             ImageBase;
        IMAGE_RUNTIME_FUNCTION_ENTRY* FunctionEntry;
        ulong             EstablisherFrame;
        ulong             TargetIp;
        CONTEXT*          ContextRecord;
        EXCEPTION_ROUTINE LanguageHandler;
        void*             HandlerData;
        UNWIND_HISTORY_TABLE* HistoryTable;
        uint              ScopeIndex;
        uint              Fill0;
    }
}

version(X86_64)
{
    struct KNONVOLATILE_CONTEXT_POINTERS
    {
        union
        {
            M128A[16]* FloatingContext;
            struct
            {
                M128A* Xmm0;
                M128A* Xmm1;
                M128A* Xmm2;
                M128A* Xmm3;
                M128A* Xmm4;
                M128A* Xmm5;
                M128A* Xmm6;
                M128A* Xmm7;
                M128A* Xmm8;
                M128A* Xmm9;
                M128A* Xmm10;
                M128A* Xmm11;
                M128A* Xmm12;
                M128A* Xmm13;
                M128A* Xmm14;
                M128A* Xmm15;
            }
        }
        union
        {
            ulong[16]* IntegerContext;
            struct
            {
                ulong* Rax;
                ulong* Rcx;
                ulong* Rdx;
                ulong* Rbx;
                ulong* Rsp;
                ulong* Rbp;
                ulong* Rsi;
                ulong* Rdi;
                ulong* R8;
                ulong* R9;
                ulong* R10;
                ulong* R11;
                ulong* R12;
                ulong* R13;
                ulong* R14;
                ulong* R15;
            }
        }
    }
}

version(X86_64)
{
    struct UNWIND_HISTORY_TABLE_ENTRY
    {
        size_t ImageBase;
        IMAGE_RUNTIME_FUNCTION_ENTRY* FunctionEntry;
    }
}

version(X86_64)
{
    struct UNWIND_HISTORY_TABLE
    {
        uint   Count;
        ubyte  LocalHint;
        ubyte  GlobalHint;
        ubyte  Search;
        ubyte  Once;
        size_t LowAddress;
        size_t HighAddress;
        UNWIND_HISTORY_TABLE_ENTRY[12] Entry;
    }
}

version(AArch64)
{
    struct UNWIND_HISTORY_TABLE
    {
        uint   Count;
        ubyte  LocalHint;
        ubyte  GlobalHint;
        ubyte  Search;
        ubyte  Once;
        size_t LowAddress;
        size_t HighAddress;
        UNWIND_HISTORY_TABLE_ENTRY[12] Entry;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_exception_information
    struct MINIDUMP_EXCEPTION_INFORMATION
    {
    align (4):
        uint                ThreadId;
        EXCEPTION_POINTERS* ExceptionPointers;
        BOOL                ClientPointers;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_exception_information
    struct MINIDUMP_EXCEPTION_INFORMATION
    {
    align (4):
        uint                ThreadId;
        EXCEPTION_POINTERS* ExceptionPointers;
        BOOL                ClientPointers;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_user_stream
    struct MINIDUMP_USER_STREAM
    {
    align (4):
        uint  Type;
        uint  BufferSize;
        void* Buffer;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_user_stream
    struct MINIDUMP_USER_STREAM
    {
    align (4):
        uint  Type;
        uint  BufferSize;
        void* Buffer;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_user_stream_information
    struct MINIDUMP_USER_STREAM_INFORMATION
    {
    align (4):
        uint UserStreamCount;
        MINIDUMP_USER_STREAM* UserStreamArray;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_user_stream_information
    struct MINIDUMP_USER_STREAM_INFORMATION
    {
    align (4):
        uint UserStreamCount;
        MINIDUMP_USER_STREAM* UserStreamArray;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_callback_information
    struct MINIDUMP_CALLBACK_INFORMATION
    {
    align (4):
        MINIDUMP_CALLBACK_ROUTINE CallbackRoutine;
        void* CallbackParam;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_callback_information
    struct MINIDUMP_CALLBACK_INFORMATION
    {
    align (4):
        MINIDUMP_CALLBACK_ROUTINE CallbackRoutine;
        void* CallbackParam;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-loaded_image
    struct LOADED_IMAGE
    {
        PSTR                ModuleName;
        HANDLE              hFile;
        ubyte*              MappedAddress;
        IMAGE_NT_HEADERS64* FileHeader;
        IMAGE_SECTION_HEADER* LastRvaSection;
        uint                NumberOfSections;
        IMAGE_SECTION_HEADER* Sections;
        IMAGE_FILE_CHARACTERISTICS2 Characteristics;
        BOOLEAN             fSystemImage;
        BOOLEAN             fDOSImage;
        BOOLEAN             fReadOnly;
        ubyte               Version;
        LIST_ENTRY          Links;
        uint                SizeOfImage;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-loaded_image
    struct LOADED_IMAGE
    {
        PSTR                ModuleName;
        HANDLE              hFile;
        ubyte*              MappedAddress;
        IMAGE_NT_HEADERS64* FileHeader;
        IMAGE_SECTION_HEADER* LastRvaSection;
        uint                NumberOfSections;
        IMAGE_SECTION_HEADER* Sections;
        IMAGE_FILE_CHARACTERISTICS2 Characteristics;
        BOOLEAN             fSystemImage;
        BOOLEAN             fDOSImage;
        BOOLEAN             fReadOnly;
        ubyte               Version;
        LIST_ENTRY          Links;
        uint                SizeOfImage;
    }
}

struct M128A
{
    ulong Low;
    long  High;
}

version(X86)
{
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

version(X86)
{
    struct XSTATE_CONTEXT
    {
        ulong       Mask;
        uint        Length;
        ubyte       Flags;
        ubyte[3]    Reserved0;
        XSAVE_AREA* Area;
        uint        Reserved2;
        void*       Buffer;
        uint        Reserved3;
    }
}

union ARM64_NT_NEON128
{
    struct
    {
        ulong Low;
        long  High;
    }
    double[2] D;
    float[4]  S;
    ushort[8] H;
    ubyte[16] B;
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-arm64_nt_context
    struct ARM64_NT_CONTEXT
    {
        uint                 ContextFlags;
        uint                 Cpsr;
        union
        {
            struct
            {
                ulong X0;
                ulong X1;
                ulong X2;
                ulong X3;
                ulong X4;
                ulong X5;
                ulong X6;
                ulong X7;
                ulong X8;
                ulong X9;
                ulong X10;
                ulong X11;
                ulong X12;
                ulong X13;
                ulong X14;
                ulong X15;
                ulong X16;
                ulong X17;
                ulong X18;
                ulong X19;
                ulong X20;
                ulong X21;
                ulong X22;
                ulong X23;
                ulong X24;
                ulong X25;
                ulong X26;
                ulong X27;
                ulong X28;
                ulong Fp;
                ulong Lr;
            }
            ulong[31] X;
        }
        ulong                Sp;
        ulong                Pc;
        ARM64_NT_NEON128[32] V;
        uint                 Fpcr;
        uint                 Fpsr;
        uint[8]              Bcr;
        ulong[8]             Bvr;
        uint[2]              Wcr;
        ulong[2]             Wvr;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-arm64_nt_context
    struct ARM64_NT_CONTEXT
    {
        uint                 ContextFlags;
        uint                 Cpsr;
        union
        {
            struct
            {
                ulong X0;
                ulong X1;
                ulong X2;
                ulong X3;
                ulong X4;
                ulong X5;
                ulong X6;
                ulong X7;
                ulong X8;
                ulong X9;
                ulong X10;
                ulong X11;
                ulong X12;
                ulong X13;
                ulong X14;
                ulong X15;
                ulong X16;
                ulong X17;
                ulong X18;
                ulong X19;
                ulong X20;
                ulong X21;
                ulong X22;
                ulong X23;
                ulong X24;
                ulong X25;
                ulong X26;
                ulong X27;
                ulong X28;
                ulong Fp;
                ulong Lr;
            }
            ulong[31] X;
        }
        ulong                Sp;
        ulong                Pc;
        ARM64_NT_NEON128[32] V;
        uint                 Fpcr;
        uint                 Fpsr;
        uint[8]              Bcr;
        ulong[8]             Bvr;
        uint[2]              Wcr;
        ulong[2]             Wvr;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-context
    struct CONTEXT
    {
        CONTEXT_FLAGS      ContextFlags;
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
        ubyte[512]         ExtendedRegisters;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-ldt_entry
struct LDT_ENTRY
{
    ushort LimitLow;
    ushort BaseLow;
    union HighWord
    {
        struct Bytes
        {
            ubyte BaseMid;
            ubyte Flags1;
            ubyte Flags2;
            ubyte BaseHi;
        }
        struct Bits
        {
            // Native bit field: BaseMid: [0-7], Type: [8-12], Dpl: [13-14], Pres: [15], LimitHi: [16-19], Sys: [20], Reserved_0: [21], Default_Big: [22], Granularity: [23], BaseHi: [24-31]
            uint _bitfield0;
        }
    }
}

version(X86)
{
    struct KNONVOLATILE_CONTEXT_POINTERS
    {
        uint Dummy;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-wow64_floating_save_area
struct WOW64_FLOATING_SAVE_AREA
{
    uint      ControlWord;
    uint      StatusWord;
    uint      TagWord;
    uint      ErrorOffset;
    uint      ErrorSelector;
    uint      DataOffset;
    uint      DataSelector;
    ubyte[80] RegisterArea;
    uint      Cr0NpxState;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-wow64_context
struct WOW64_CONTEXT
{
    WOW64_CONTEXT_FLAGS ContextFlags;
    uint                Dr0;
    uint                Dr1;
    uint                Dr2;
    uint                Dr3;
    uint                Dr6;
    uint                Dr7;
    WOW64_FLOATING_SAVE_AREA FloatSave;
    uint                SegGs;
    uint                SegFs;
    uint                SegEs;
    uint                SegDs;
    uint                Edi;
    uint                Esi;
    uint                Ebx;
    uint                Edx;
    uint                Ecx;
    uint                Eax;
    uint                Ebp;
    uint                Eip;
    uint                SegCs;
    uint                EFlags;
    uint                Esp;
    uint                SegSs;
    ubyte[512]          ExtendedRegisters;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-wow64_ldt_entry
struct WOW64_LDT_ENTRY
{
    ushort LimitLow;
    ushort BaseLow;
    union HighWord
    {
        struct Bytes
        {
            ubyte BaseMid;
            ubyte Flags1;
            ubyte Flags2;
            ubyte BaseHi;
        }
        struct Bits
        {
            // Native bit field: BaseMid: [0-7], Type: [8-12], Dpl: [13-14], Pres: [15], LimitHi: [16-19], Sys: [20], Reserved_0: [21], Default_Big: [22], Granularity: [23], BaseHi: [24-31]
            uint _bitfield0;
        }
    }
}

struct WOW64_DESCRIPTOR_TABLE_ENTRY
{
    uint            Selector;
    WOW64_LDT_ENTRY Descriptor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-exception_record
struct EXCEPTION_RECORD
{
    NTSTATUS          ExceptionCode;
    uint              ExceptionFlags;
    EXCEPTION_RECORD* ExceptionRecord;
    void*             ExceptionAddress;
    uint              NumberParameters;
    size_t[15]        ExceptionInformation;
}

struct EXCEPTION_RECORD32
{
    NTSTATUS ExceptionCode;
    uint     ExceptionFlags;
    uint     ExceptionRecord;
    uint     ExceptionAddress;
    uint     NumberParameters;
    uint[15] ExceptionInformation;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-exception_record64
struct EXCEPTION_RECORD64
{
    NTSTATUS  ExceptionCode;
    uint      ExceptionFlags;
    ulong     ExceptionRecord;
    ulong     ExceptionAddress;
    uint      NumberParameters;
    uint      __unusedAlignment;
    ulong[15] ExceptionInformation;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-exception_pointers
struct EXCEPTION_POINTERS
{
    EXCEPTION_RECORD* ExceptionRecord;
    CONTEXT*          ContextRecord;
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
            // Native bit field: OptimizedSave: [0], CompactionEnabled: [1], ExtendedFeatureDisable: [2]
            uint _bitfield0;
        }
    }
    XSTATE_FEATURE[64] Features;
    ulong              EnabledSupervisorFeatures;
    ulong              AlignedFeatures;
    uint               AllFeatureSize;
    uint[64]           AllFeatures;
    ulong              EnabledUserVisibleSupervisorFeatures;
    ulong              ExtendedFeatureDisableFeatures;
    uint               AllNonLargeFeatureSize;
    ushort             MaxSveVectorLength;
    ushort             Spare1;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-image_file_header
struct IMAGE_FILE_HEADER
{
    IMAGE_FILE_MACHINE Machine;
    ushort             NumberOfSections;
    uint               TimeDateStamp;
    uint               PointerToSymbolTable;
    uint               NumberOfSymbols;
    ushort             SizeOfOptionalHeader;
    IMAGE_FILE_CHARACTERISTICS Characteristics;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-image_data_directory
struct IMAGE_DATA_DIRECTORY
{
    uint VirtualAddress;
    uint Size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-image_optional_header32
struct IMAGE_OPTIONAL_HEADER32
{
    IMAGE_OPTIONAL_HEADER_MAGIC Magic;
    ubyte           MajorLinkerVersion;
    ubyte           MinorLinkerVersion;
    uint            SizeOfCode;
    uint            SizeOfInitializedData;
    uint            SizeOfUninitializedData;
    uint            AddressOfEntryPoint;
    uint            BaseOfCode;
    uint            BaseOfData;
    uint            ImageBase;
    uint            SectionAlignment;
    uint            FileAlignment;
    ushort          MajorOperatingSystemVersion;
    ushort          MinorOperatingSystemVersion;
    ushort          MajorImageVersion;
    ushort          MinorImageVersion;
    ushort          MajorSubsystemVersion;
    ushort          MinorSubsystemVersion;
    uint            Win32VersionValue;
    uint            SizeOfImage;
    uint            SizeOfHeaders;
    uint            CheckSum;
    IMAGE_SUBSYSTEM Subsystem;
    IMAGE_DLL_CHARACTERISTICS DllCharacteristics;
    uint            SizeOfStackReserve;
    uint            SizeOfStackCommit;
    uint            SizeOfHeapReserve;
    uint            SizeOfHeapCommit;
    uint            LoaderFlags;
    uint            NumberOfRvaAndSizes;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-image_optional_header64
struct IMAGE_OPTIONAL_HEADER64
{
align (4):
    IMAGE_OPTIONAL_HEADER_MAGIC Magic;
    ubyte           MajorLinkerVersion;
    ubyte           MinorLinkerVersion;
    uint            SizeOfCode;
    uint            SizeOfInitializedData;
    uint            SizeOfUninitializedData;
    uint            AddressOfEntryPoint;
    uint            BaseOfCode;
    ulong           ImageBase;
    uint            SectionAlignment;
    uint            FileAlignment;
    ushort          MajorOperatingSystemVersion;
    ushort          MinorOperatingSystemVersion;
    ushort          MajorImageVersion;
    ushort          MinorImageVersion;
    ushort          MajorSubsystemVersion;
    ushort          MinorSubsystemVersion;
    uint            Win32VersionValue;
    uint            SizeOfImage;
    uint            SizeOfHeaders;
    uint            CheckSum;
    IMAGE_SUBSYSTEM Subsystem;
    IMAGE_DLL_CHARACTERISTICS DllCharacteristics;
    ulong           SizeOfStackReserve;
    ulong           SizeOfStackCommit;
    ulong           SizeOfHeapReserve;
    ulong           SizeOfHeapCommit;
    uint            LoaderFlags;
    uint            NumberOfRvaAndSizes;
    IMAGE_DATA_DIRECTORY[16] DataDirectory;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-image_nt_headers64
struct IMAGE_NT_HEADERS64
{
    uint              Signature;
    IMAGE_FILE_HEADER FileHeader;
    IMAGE_OPTIONAL_HEADER64 OptionalHeader;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-image_nt_headers32
struct IMAGE_NT_HEADERS32
{
    uint              Signature;
    IMAGE_FILE_HEADER FileHeader;
    IMAGE_OPTIONAL_HEADER32 OptionalHeader;
}

struct IMAGE_ROM_HEADERS
{
    IMAGE_FILE_HEADER FileHeader;
    IMAGE_ROM_OPTIONAL_HEADER OptionalHeader;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-image_section_header
struct IMAGE_SECTION_HEADER
{
    ubyte[8] Name;
    union Misc
    {
        uint PhysicalAddress;
        uint VirtualSize;
    }
    uint     VirtualAddress;
    uint     SizeOfRawData;
    uint     PointerToRawData;
    uint     PointerToRelocations;
    uint     PointerToLinenumbers;
    ushort   NumberOfRelocations;
    ushort   NumberOfLinenumbers;
    IMAGE_SECTION_CHARACTERISTICS Characteristics;
}

struct IMAGE_LOAD_CONFIG_CODE_INTEGRITY
{
    ushort Flags;
    ushort Catalog;
    uint   CatalogOffset;
    uint   Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-image_load_config_directory32
struct IMAGE_LOAD_CONFIG_DIRECTORY32
{
    uint   Size;
    uint   TimeDateStamp;
    ushort MajorVersion;
    ushort MinorVersion;
    uint   GlobalFlagsClear;
    uint   GlobalFlagsSet;
    uint   CriticalSectionDefaultTimeout;
    uint   DeCommitFreeBlockThreshold;
    uint   DeCommitTotalFreeThreshold;
    uint   LockPrefixTable;
    uint   MaximumAllocationSize;
    uint   VirtualMemoryThreshold;
    uint   ProcessHeapFlags;
    uint   ProcessAffinityMask;
    ushort CSDVersion;
    ushort DependentLoadFlags;
    uint   EditList;
    uint   SecurityCookie;
    uint   SEHandlerTable;
    uint   SEHandlerCount;
    uint   GuardCFCheckFunctionPointer;
    uint   GuardCFDispatchFunctionPointer;
    uint   GuardCFFunctionTable;
    uint   GuardCFFunctionCount;
    uint   GuardFlags;
    IMAGE_LOAD_CONFIG_CODE_INTEGRITY CodeIntegrity;
    uint   GuardAddressTakenIatEntryTable;
    uint   GuardAddressTakenIatEntryCount;
    uint   GuardLongJumpTargetTable;
    uint   GuardLongJumpTargetCount;
    uint   DynamicValueRelocTable;
    uint   CHPEMetadataPointer;
    uint   GuardRFFailureRoutine;
    uint   GuardRFFailureRoutineFunctionPointer;
    uint   DynamicValueRelocTableOffset;
    ushort DynamicValueRelocTableSection;
    ushort Reserved2;
    uint   GuardRFVerifyStackPointerFunctionPointer;
    uint   HotPatchTableOffset;
    uint   Reserved3;
    uint   EnclaveConfigurationPointer;
    uint   VolatileMetadataPointer;
    uint   GuardEHContinuationTable;
    uint   GuardEHContinuationCount;
    uint   GuardXFGCheckFunctionPointer;
    uint   GuardXFGDispatchFunctionPointer;
    uint   GuardXFGTableDispatchFunctionPointer;
    uint   CastGuardOsDeterminedFailureMode;
    uint   GuardMemcpyFunctionPointer;
    uint   UmaFunctionPointers;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-image_load_config_directory64
struct IMAGE_LOAD_CONFIG_DIRECTORY64
{
align (4):
    uint   Size;
    uint   TimeDateStamp;
    ushort MajorVersion;
    ushort MinorVersion;
    uint   GlobalFlagsClear;
    uint   GlobalFlagsSet;
    uint   CriticalSectionDefaultTimeout;
    ulong  DeCommitFreeBlockThreshold;
    ulong  DeCommitTotalFreeThreshold;
    ulong  LockPrefixTable;
    ulong  MaximumAllocationSize;
    ulong  VirtualMemoryThreshold;
    ulong  ProcessAffinityMask;
    uint   ProcessHeapFlags;
    ushort CSDVersion;
    ushort DependentLoadFlags;
    ulong  EditList;
    ulong  SecurityCookie;
    ulong  SEHandlerTable;
    ulong  SEHandlerCount;
    ulong  GuardCFCheckFunctionPointer;
    ulong  GuardCFDispatchFunctionPointer;
    ulong  GuardCFFunctionTable;
    ulong  GuardCFFunctionCount;
    uint   GuardFlags;
    IMAGE_LOAD_CONFIG_CODE_INTEGRITY CodeIntegrity;
    ulong  GuardAddressTakenIatEntryTable;
    ulong  GuardAddressTakenIatEntryCount;
    ulong  GuardLongJumpTargetTable;
    ulong  GuardLongJumpTargetCount;
    ulong  DynamicValueRelocTable;
    ulong  CHPEMetadataPointer;
    ulong  GuardRFFailureRoutine;
    ulong  GuardRFFailureRoutineFunctionPointer;
    uint   DynamicValueRelocTableOffset;
    ushort DynamicValueRelocTableSection;
    ushort Reserved2;
    ulong  GuardRFVerifyStackPointerFunctionPointer;
    uint   HotPatchTableOffset;
    uint   Reserved3;
    ulong  EnclaveConfigurationPointer;
    ulong  VolatileMetadataPointer;
    ulong  GuardEHContinuationTable;
    ulong  GuardEHContinuationCount;
    ulong  GuardXFGCheckFunctionPointer;
    ulong  GuardXFGDispatchFunctionPointer;
    ulong  GuardXFGTableDispatchFunctionPointer;
    ulong  CastGuardOsDeterminedFailureMode;
    ulong  GuardMemcpyFunctionPointer;
    ulong  UmaFunctionPointers;
}

struct IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY
{
    uint BeginAddress;
    union
    {
        uint UnwindData;
        struct
        {
            // Native bit field: Flag: [0-1], FunctionLength: [2-12], RegF: [13-15], RegI: [16-19], H: [20], CR: [21-22], FrameSize: [23-31]
            uint _bitfield0;
        }
    }
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-image_debug_directory
struct IMAGE_DEBUG_DIRECTORY
{
    uint             Characteristics;
    uint             TimeDateStamp;
    ushort           MajorVersion;
    ushort           MinorVersion;
    IMAGE_DEBUG_TYPE Type;
    uint             SizeOfData;
    uint             AddressOfRawData;
    uint             PointerToRawData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-image_coff_symbols_header
struct IMAGE_COFF_SYMBOLS_HEADER
{
    uint NumberOfSymbols;
    uint LvaToFirstSymbol;
    uint NumberOfLinenumbers;
    uint LvaToFirstLinenumber;
    uint RvaToFirstByteOfCode;
    uint RvaToLastByteOfCode;
    uint RvaToFirstByteOfData;
    uint RvaToLastByteOfData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-fpo_data
struct FPO_DATA
{
    uint   ulOffStart;
    uint   cbProcSize;
    uint   cdwLocals;
    ushort cdwParams;
    // Native bit field: cbProlog: [0-7], cbRegs: [8-10], fHasSEH: [11], fUseBP: [12], reserved: [13], cbFrame: [14-15]
    ushort _bitfield0;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-image_function_entry
struct IMAGE_FUNCTION_ENTRY
{
    uint StartingAddress;
    uint EndingAddress;
    uint EndOfPrologue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-image_function_entry64
struct IMAGE_FUNCTION_ENTRY64
{
align (4):
    ulong StartingAddress;
    ulong EndingAddress;
    union
    {
    align (4):
        ulong EndOfPrologue;
        ulong UnwindInfoAddress;
    }
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wct/ns-wct-waitchain_node_info
struct WAITCHAIN_NODE_INFO
{
    WCT_OBJECT_TYPE   ObjectType;
    WCT_OBJECT_STATUS ObjectStatus;
    union
    {
        struct LockObject
        {
            wchar[128] ObjectName;
            long       Timeout;
            BOOL       Alertable;
        }
        struct ThreadObject
        {
            uint ProcessId;
            uint ThreadId;
            uint WaitTime;
            uint ContextSwitches;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_location_descriptor
struct MINIDUMP_LOCATION_DESCRIPTOR
{
align (4):
    uint DataSize;
    uint Rva;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_location_descriptor64
struct MINIDUMP_LOCATION_DESCRIPTOR64
{
align (4):
    ulong DataSize;
    ulong Rva;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_memory_descriptor
struct MINIDUMP_MEMORY_DESCRIPTOR
{
align (4):
    ulong StartOfMemoryRange;
    MINIDUMP_LOCATION_DESCRIPTOR Memory;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_memory_descriptor64
struct MINIDUMP_MEMORY_DESCRIPTOR64
{
align (4):
    ulong StartOfMemoryRange;
    ulong DataSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_header
struct MINIDUMP_HEADER
{
align (4):
    uint  Signature;
    uint  Version;
    uint  NumberOfStreams;
    uint  StreamDirectoryRva;
    uint  CheckSum;
    union
    {
        uint Reserved;
        uint TimeDateStamp;
    }
    ulong Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_directory
struct MINIDUMP_DIRECTORY
{
align (4):
    uint StreamType;
    MINIDUMP_LOCATION_DESCRIPTOR Location;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_string
struct MINIDUMP_STRING
{
align (4):
    uint     Length;
    wchar[1] Buffer; // Flexible array
}

union CPU_INFORMATION
{
    struct X86CpuInfo
    {
        uint[3] VendorId;
        uint    VersionInformation;
        uint    FeatureInformation;
        uint    AMDExtendedCpuFeatures;
    }
    struct OtherCpuInfo
    {
    align (4):
        ulong[2] ProcessorFeatures;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_system_info
struct MINIDUMP_SYSTEM_INFO
{
align (4):
    PROCESSOR_ARCHITECTURE ProcessorArchitecture;
    ushort          ProcessorLevel;
    ushort          ProcessorRevision;
    union
    {
        ushort Reserved0;
        struct
        {
            ubyte NumberOfProcessors;
            ubyte ProductType;
        }
    }
    uint            MajorVersion;
    uint            MinorVersion;
    uint            BuildNumber;
    VER_PLATFORM    PlatformId;
    uint            CSDVersionRva;
    union
    {
        uint Reserved1;
        struct
        {
            ushort SuiteMask;
            ushort Reserved2;
        }
    }
    CPU_INFORMATION Cpu;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_thread
struct MINIDUMP_THREAD
{
align (4):
    uint  ThreadId;
    uint  SuspendCount;
    uint  PriorityClass;
    uint  Priority;
    ulong Teb;
    MINIDUMP_MEMORY_DESCRIPTOR Stack;
    MINIDUMP_LOCATION_DESCRIPTOR ThreadContext;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_thread_list
struct MINIDUMP_THREAD_LIST
{
align (4):
    uint               NumberOfThreads;
    MINIDUMP_THREAD[1] Threads; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_thread_ex
struct MINIDUMP_THREAD_EX
{
align (4):
    uint  ThreadId;
    uint  SuspendCount;
    uint  PriorityClass;
    uint  Priority;
    ulong Teb;
    MINIDUMP_MEMORY_DESCRIPTOR Stack;
    MINIDUMP_LOCATION_DESCRIPTOR ThreadContext;
    MINIDUMP_MEMORY_DESCRIPTOR BackingStore;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_thread_ex_list
struct MINIDUMP_THREAD_EX_LIST
{
align (4):
    uint NumberOfThreads;
    MINIDUMP_THREAD_EX[1] Threads; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_exception
struct MINIDUMP_EXCEPTION
{
align (4):
    uint      ExceptionCode;
    uint      ExceptionFlags;
    ulong     ExceptionRecord;
    ulong     ExceptionAddress;
    uint      NumberParameters;
    uint      __unusedAlignment;
    ulong[15] ExceptionInformation;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_exception_stream
struct MINIDUMP_EXCEPTION_STREAM
{
align (4):
    uint               ThreadId;
    uint               __alignment;
    MINIDUMP_EXCEPTION ExceptionRecord;
    MINIDUMP_LOCATION_DESCRIPTOR ThreadContext;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_module
struct MINIDUMP_MODULE
{
align (4):
    ulong            BaseOfImage;
    uint             SizeOfImage;
    uint             CheckSum;
    uint             TimeDateStamp;
    uint             ModuleNameRva;
    VS_FIXEDFILEINFO VersionInfo;
    MINIDUMP_LOCATION_DESCRIPTOR CvRecord;
    MINIDUMP_LOCATION_DESCRIPTOR MiscRecord;
    ulong            Reserved0;
    ulong            Reserved1;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_module_list
struct MINIDUMP_MODULE_LIST
{
align (4):
    uint               NumberOfModules;
    MINIDUMP_MODULE[1] Modules; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_memory_list
struct MINIDUMP_MEMORY_LIST
{
align (4):
    uint NumberOfMemoryRanges;
    MINIDUMP_MEMORY_DESCRIPTOR[1] MemoryRanges; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_memory64_list
struct MINIDUMP_MEMORY64_LIST
{
align (4):
    ulong NumberOfMemoryRanges;
    ulong BaseRva;
    MINIDUMP_MEMORY_DESCRIPTOR64[1] MemoryRanges; // Flexible array
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_exception_information
    struct MINIDUMP_EXCEPTION_INFORMATION
    {
        uint                ThreadId;
        EXCEPTION_POINTERS* ExceptionPointers;
        BOOL                ClientPointers;
    }
}

struct MINIDUMP_EXCEPTION_INFORMATION64
{
align (4):
    uint  ThreadId;
    ulong ExceptionRecord;
    ulong ContextRecord;
    BOOL  ClientPointers;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_handle_object_information
struct MINIDUMP_HANDLE_OBJECT_INFORMATION
{
align (4):
    uint NextInfoRva;
    uint InfoType;
    uint SizeOfInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_handle_descriptor
struct MINIDUMP_HANDLE_DESCRIPTOR
{
align (4):
    ulong Handle;
    uint  TypeNameRva;
    uint  ObjectNameRva;
    uint  Attributes;
    uint  GrantedAccess;
    uint  HandleCount;
    uint  PointerCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_handle_descriptor_2
struct MINIDUMP_HANDLE_DESCRIPTOR_2
{
align (4):
    ulong Handle;
    uint  TypeNameRva;
    uint  ObjectNameRva;
    uint  Attributes;
    uint  GrantedAccess;
    uint  HandleCount;
    uint  PointerCount;
    uint  ObjectInfoRva;
    uint  Reserved0;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_handle_data_stream
struct MINIDUMP_HANDLE_DATA_STREAM
{
align (4):
    uint SizeOfHeader;
    uint SizeOfDescriptor;
    uint NumberOfDescriptors;
    uint Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_handle_operation_list
struct MINIDUMP_HANDLE_OPERATION_LIST
{
align (4):
    uint SizeOfHeader;
    uint SizeOfEntry;
    uint NumberOfEntries;
    uint Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_function_table_descriptor
struct MINIDUMP_FUNCTION_TABLE_DESCRIPTOR
{
align (4):
    ulong MinimumAddress;
    ulong MaximumAddress;
    ulong BaseAddress;
    uint  EntryCount;
    uint  SizeOfAlignPad;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_function_table_stream
struct MINIDUMP_FUNCTION_TABLE_STREAM
{
align (4):
    uint SizeOfHeader;
    uint SizeOfDescriptor;
    uint SizeOfNativeDescriptor;
    uint SizeOfFunctionEntry;
    uint NumberOfDescriptors;
    uint SizeOfAlignPad;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_unloaded_module
struct MINIDUMP_UNLOADED_MODULE
{
align (4):
    ulong BaseOfImage;
    uint  SizeOfImage;
    uint  CheckSum;
    uint  TimeDateStamp;
    uint  ModuleNameRva;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_unloaded_module_list
struct MINIDUMP_UNLOADED_MODULE_LIST
{
align (4):
    uint SizeOfHeader;
    uint SizeOfEntry;
    uint NumberOfEntries;
}

struct XSTATE_CONFIG_FEATURE_MSC_INFO
{
align (4):
    uint               SizeOfInfo;
    uint               ContextSize;
    ulong              EnabledFeatures;
    XSTATE_FEATURE[64] Features;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_misc_info
struct MINIDUMP_MISC_INFO
{
align (4):
    uint SizeOfInfo;
    MINIDUMP_MISC_INFO_FLAGS Flags1;
    uint ProcessId;
    uint ProcessCreateTime;
    uint ProcessUserTime;
    uint ProcessKernelTime;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_misc_info_2
struct MINIDUMP_MISC_INFO_2
{
align (4):
    uint SizeOfInfo;
    uint Flags1;
    uint ProcessId;
    uint ProcessCreateTime;
    uint ProcessUserTime;
    uint ProcessKernelTime;
    uint ProcessorMaxMhz;
    uint ProcessorCurrentMhz;
    uint ProcessorMhzLimit;
    uint ProcessorMaxIdleState;
    uint ProcessorCurrentIdleState;
}

struct MINIDUMP_MISC_INFO_3
{
align (4):
    uint SizeOfInfo;
    uint Flags1;
    uint ProcessId;
    uint ProcessCreateTime;
    uint ProcessUserTime;
    uint ProcessKernelTime;
    uint ProcessorMaxMhz;
    uint ProcessorCurrentMhz;
    uint ProcessorMhzLimit;
    uint ProcessorMaxIdleState;
    uint ProcessorCurrentIdleState;
    uint ProcessIntegrityLevel;
    uint ProcessExecuteFlags;
    uint ProtectedProcess;
    uint TimeZoneId;
    TIME_ZONE_INFORMATION TimeZone;
}

struct MINIDUMP_MISC_INFO_4
{
align (4):
    uint       SizeOfInfo;
    uint       Flags1;
    uint       ProcessId;
    uint       ProcessCreateTime;
    uint       ProcessUserTime;
    uint       ProcessKernelTime;
    uint       ProcessorMaxMhz;
    uint       ProcessorCurrentMhz;
    uint       ProcessorMhzLimit;
    uint       ProcessorMaxIdleState;
    uint       ProcessorCurrentIdleState;
    uint       ProcessIntegrityLevel;
    uint       ProcessExecuteFlags;
    uint       ProtectedProcess;
    uint       TimeZoneId;
    TIME_ZONE_INFORMATION TimeZone;
    wchar[260] BuildString;
    wchar[40]  DbgBldStr;
}

struct MINIDUMP_MISC_INFO_5
{
align (4):
    uint       SizeOfInfo;
    uint       Flags1;
    uint       ProcessId;
    uint       ProcessCreateTime;
    uint       ProcessUserTime;
    uint       ProcessKernelTime;
    uint       ProcessorMaxMhz;
    uint       ProcessorCurrentMhz;
    uint       ProcessorMhzLimit;
    uint       ProcessorMaxIdleState;
    uint       ProcessorCurrentIdleState;
    uint       ProcessIntegrityLevel;
    uint       ProcessExecuteFlags;
    uint       ProtectedProcess;
    uint       TimeZoneId;
    TIME_ZONE_INFORMATION TimeZone;
    wchar[260] BuildString;
    wchar[40]  DbgBldStr;
    XSTATE_CONFIG_FEATURE_MSC_INFO XStateData;
    uint       ProcessCookie;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_memory_info
struct MINIDUMP_MEMORY_INFO
{
align (4):
    ulong BaseAddress;
    ulong AllocationBase;
    uint  AllocationProtect;
    uint  __alignment1;
    ulong RegionSize;
    VIRTUAL_ALLOCATION_TYPE State;
    uint  Protect;
    uint  Type;
    uint  __alignment2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_memory_info_list
struct MINIDUMP_MEMORY_INFO_LIST
{
align (4):
    uint  SizeOfHeader;
    uint  SizeOfEntry;
    ulong NumberOfEntries;
}

struct MINIDUMP_THREAD_NAME
{
align (4):
    uint  ThreadId;
    ulong RvaOfThreadName;
}

struct MINIDUMP_THREAD_NAME_LIST
{
align (4):
    uint NumberOfThreadNames;
    MINIDUMP_THREAD_NAME[1] ThreadNames; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_thread_info
struct MINIDUMP_THREAD_INFO
{
align (4):
    uint  ThreadId;
    MINIDUMP_THREAD_INFO_DUMP_FLAGS DumpFlags;
    uint  DumpError;
    uint  ExitStatus;
    ulong CreateTime;
    ulong ExitTime;
    ulong KernelTime;
    ulong UserTime;
    ulong StartAddress;
    ulong Affinity;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_thread_info_list
struct MINIDUMP_THREAD_INFO_LIST
{
align (4):
    uint SizeOfHeader;
    uint SizeOfEntry;
    uint NumberOfEntries;
}

struct MINIDUMP_TOKEN_INFO_HEADER
{
align (4):
    uint  TokenSize;
    uint  TokenId;
    ulong TokenHandle;
}

struct MINIDUMP_TOKEN_INFO_LIST
{
align (4):
    uint TokenListSize;
    uint TokenListEntries;
    uint ListHeaderSize;
    uint ElementHeaderSize;
}

struct MINIDUMP_SYSTEM_BASIC_INFORMATION
{
align (4):
    uint  TimerResolution;
    uint  PageSize;
    uint  NumberOfPhysicalPages;
    uint  LowestPhysicalPageNumber;
    uint  HighestPhysicalPageNumber;
    uint  AllocationGranularity;
    ulong MinimumUserModeAddress;
    ulong MaximumUserModeAddress;
    ulong ActiveProcessorsAffinityMask;
    uint  NumberOfProcessors;
}

struct MINIDUMP_SYSTEM_FILECACHE_INFORMATION
{
align (4):
    ulong CurrentSize;
    ulong PeakSize;
    uint  PageFaultCount;
    ulong MinimumWorkingSet;
    ulong MaximumWorkingSet;
    ulong CurrentSizeIncludingTransitionInPages;
    ulong PeakSizeIncludingTransitionInPages;
    uint  TransitionRePurposeCount;
    uint  Flags;
}

struct MINIDUMP_SYSTEM_BASIC_PERFORMANCE_INFORMATION
{
align (4):
    ulong AvailablePages;
    ulong CommittedPages;
    ulong CommitLimit;
    ulong PeakCommitment;
}

struct MINIDUMP_SYSTEM_PERFORMANCE_INFORMATION
{
align (4):
    ulong IdleProcessTime;
    ulong IoReadTransferCount;
    ulong IoWriteTransferCount;
    ulong IoOtherTransferCount;
    uint  IoReadOperationCount;
    uint  IoWriteOperationCount;
    uint  IoOtherOperationCount;
    uint  AvailablePages;
    uint  CommittedPages;
    uint  CommitLimit;
    uint  PeakCommitment;
    uint  PageFaultCount;
    uint  CopyOnWriteCount;
    uint  TransitionCount;
    uint  CacheTransitionCount;
    uint  DemandZeroCount;
    uint  PageReadCount;
    uint  PageReadIoCount;
    uint  CacheReadCount;
    uint  CacheIoCount;
    uint  DirtyPagesWriteCount;
    uint  DirtyWriteIoCount;
    uint  MappedPagesWriteCount;
    uint  MappedWriteIoCount;
    uint  PagedPoolPages;
    uint  NonPagedPoolPages;
    uint  PagedPoolAllocs;
    uint  PagedPoolFrees;
    uint  NonPagedPoolAllocs;
    uint  NonPagedPoolFrees;
    uint  FreeSystemPtes;
    uint  ResidentSystemCodePage;
    uint  TotalSystemDriverPages;
    uint  TotalSystemCodePages;
    uint  NonPagedPoolLookasideHits;
    uint  PagedPoolLookasideHits;
    uint  AvailablePagedPoolPages;
    uint  ResidentSystemCachePage;
    uint  ResidentPagedPoolPage;
    uint  ResidentSystemDriverPage;
    uint  CcFastReadNoWait;
    uint  CcFastReadWait;
    uint  CcFastReadResourceMiss;
    uint  CcFastReadNotPossible;
    uint  CcFastMdlReadNoWait;
    uint  CcFastMdlReadWait;
    uint  CcFastMdlReadResourceMiss;
    uint  CcFastMdlReadNotPossible;
    uint  CcMapDataNoWait;
    uint  CcMapDataWait;
    uint  CcMapDataNoWaitMiss;
    uint  CcMapDataWaitMiss;
    uint  CcPinMappedDataCount;
    uint  CcPinReadNoWait;
    uint  CcPinReadWait;
    uint  CcPinReadNoWaitMiss;
    uint  CcPinReadWaitMiss;
    uint  CcCopyReadNoWait;
    uint  CcCopyReadWait;
    uint  CcCopyReadNoWaitMiss;
    uint  CcCopyReadWaitMiss;
    uint  CcMdlReadNoWait;
    uint  CcMdlReadWait;
    uint  CcMdlReadNoWaitMiss;
    uint  CcMdlReadWaitMiss;
    uint  CcReadAheadIos;
    uint  CcLazyWriteIos;
    uint  CcLazyWritePages;
    uint  CcDataFlushes;
    uint  CcDataPages;
    uint  ContextSwitches;
    uint  FirstLevelTbFills;
    uint  SecondLevelTbFills;
    uint  SystemCalls;
    ulong CcTotalDirtyPages;
    ulong CcDirtyPageThreshold;
    long  ResidentAvailablePages;
    ulong SharedCommittedPages;
}

struct MINIDUMP_SYSTEM_PERFORMANCE_INFORMATION_2
{
align (4):
    ulong IdleProcessTime;
    ulong IoReadTransferCount;
    ulong IoWriteTransferCount;
    ulong IoOtherTransferCount;
    uint  IoReadOperationCount;
    uint  IoWriteOperationCount;
    uint  IoOtherOperationCount;
    uint  AvailablePages;
    uint  CommittedPages;
    uint  CommitLimit;
    uint  PeakCommitment;
    uint  PageFaultCount;
    uint  CopyOnWriteCount;
    uint  TransitionCount;
    uint  CacheTransitionCount;
    uint  DemandZeroCount;
    uint  PageReadCount;
    uint  PageReadIoCount;
    uint  CacheReadCount;
    uint  CacheIoCount;
    uint  DirtyPagesWriteCount;
    uint  DirtyWriteIoCount;
    uint  MappedPagesWriteCount;
    uint  MappedWriteIoCount;
    uint  PagedPoolPages;
    uint  NonPagedPoolPages;
    uint  PagedPoolAllocs;
    uint  PagedPoolFrees;
    uint  NonPagedPoolAllocs;
    uint  NonPagedPoolFrees;
    uint  FreeSystemPtes;
    uint  ResidentSystemCodePage;
    uint  TotalSystemDriverPages;
    uint  TotalSystemCodePages;
    uint  NonPagedPoolLookasideHits;
    uint  PagedPoolLookasideHits;
    uint  AvailablePagedPoolPages;
    uint  ResidentSystemCachePage;
    uint  ResidentPagedPoolPage;
    uint  ResidentSystemDriverPage;
    uint  CcFastReadNoWait;
    uint  CcFastReadWait;
    uint  CcFastReadResourceMiss;
    uint  CcFastReadNotPossible;
    uint  CcFastMdlReadNoWait;
    uint  CcFastMdlReadWait;
    uint  CcFastMdlReadResourceMiss;
    uint  CcFastMdlReadNotPossible;
    uint  CcMapDataNoWait;
    uint  CcMapDataWait;
    uint  CcMapDataNoWaitMiss;
    uint  CcMapDataWaitMiss;
    uint  CcPinMappedDataCount;
    uint  CcPinReadNoWait;
    uint  CcPinReadWait;
    uint  CcPinReadNoWaitMiss;
    uint  CcPinReadWaitMiss;
    uint  CcCopyReadNoWait;
    uint  CcCopyReadWait;
    uint  CcCopyReadNoWaitMiss;
    uint  CcCopyReadWaitMiss;
    uint  CcMdlReadNoWait;
    uint  CcMdlReadWait;
    uint  CcMdlReadNoWaitMiss;
    uint  CcMdlReadWaitMiss;
    uint  CcReadAheadIos;
    uint  CcLazyWriteIos;
    uint  CcLazyWritePages;
    uint  CcDataFlushes;
    uint  CcDataPages;
    uint  ContextSwitches;
    uint  FirstLevelTbFills;
    uint  SecondLevelTbFills;
    uint  SystemCalls;
    ulong CcTotalDirtyPages;
    ulong CcDirtyPageThreshold;
    long  ResidentAvailablePages;
    ulong SharedCommittedPages;
    ulong MdlPagesAllocated;
    ulong PfnDatabaseCommittedPages;
    ulong SystemPageTableCommittedPages;
    ulong ContiguousPagesAllocated;
}

struct MINIDUMP_SYSTEM_MEMORY_INFO_1
{
align (4):
    ushort Revision;
    ushort Flags;
    MINIDUMP_SYSTEM_BASIC_INFORMATION BasicInfo;
    MINIDUMP_SYSTEM_FILECACHE_INFORMATION FileCacheInfo;
    MINIDUMP_SYSTEM_BASIC_PERFORMANCE_INFORMATION BasicPerfInfo;
    MINIDUMP_SYSTEM_PERFORMANCE_INFORMATION PerfInfo;
}

struct MINIDUMP_SYSTEM_MEMORY_INFO_2
{
    ushort Revision;
    ushort Flags;
    MINIDUMP_SYSTEM_BASIC_INFORMATION BasicInfo;
    MINIDUMP_SYSTEM_FILECACHE_INFORMATION FileCacheInfo;
    MINIDUMP_SYSTEM_BASIC_PERFORMANCE_INFORMATION BasicPerfInfo;
    MINIDUMP_SYSTEM_PERFORMANCE_INFORMATION_2 PerfInfo;
}

struct MINIDUMP_PROCESS_VM_COUNTERS_1
{
align (4):
    ushort Revision;
    uint   PageFaultCount;
    ulong  PeakWorkingSetSize;
    ulong  WorkingSetSize;
    ulong  QuotaPeakPagedPoolUsage;
    ulong  QuotaPagedPoolUsage;
    ulong  QuotaPeakNonPagedPoolUsage;
    ulong  QuotaNonPagedPoolUsage;
    ulong  PagefileUsage;
    ulong  PeakPagefileUsage;
    ulong  PrivateUsage;
}

struct MINIDUMP_PROCESS_VM_COUNTERS_2
{
align (4):
    ushort Revision;
    ushort Flags;
    uint   PageFaultCount;
    ulong  PeakWorkingSetSize;
    ulong  WorkingSetSize;
    ulong  QuotaPeakPagedPoolUsage;
    ulong  QuotaPagedPoolUsage;
    ulong  QuotaPeakNonPagedPoolUsage;
    ulong  QuotaNonPagedPoolUsage;
    ulong  PagefileUsage;
    ulong  PeakPagefileUsage;
    ulong  PeakVirtualSize;
    ulong  VirtualSize;
    ulong  PrivateUsage;
    ulong  PrivateWorkingSetSize;
    ulong  SharedCommitUsage;
    ulong  JobSharedCommitUsage;
    ulong  JobPrivateCommitUsage;
    ulong  JobPeakPrivateCommitUsage;
    ulong  JobPrivateCommitLimit;
    ulong  JobTotalCommitLimit;
}

struct MINIDUMP_USER_RECORD
{
align (4):
    uint Type;
    MINIDUMP_LOCATION_DESCRIPTOR Memory;
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_user_stream
    struct MINIDUMP_USER_STREAM
    {
        uint  Type;
        uint  BufferSize;
        void* Buffer;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_user_stream_information
    struct MINIDUMP_USER_STREAM_INFORMATION
    {
        uint UserStreamCount;
        MINIDUMP_USER_STREAM* UserStreamArray;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_thread_callback
    struct MINIDUMP_THREAD_CALLBACK
    {
    align (4):
        uint    ThreadId;
        HANDLE  ThreadHandle;
        CONTEXT Context;
        uint    SizeOfContext;
        ulong   StackBase;
        ulong   StackEnd;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_thread_callback
    struct MINIDUMP_THREAD_CALLBACK
    {
    align (4):
        uint    ThreadId;
        HANDLE  ThreadHandle;
        CONTEXT Context;
        uint    SizeOfContext;
        ulong   StackBase;
        ulong   StackEnd;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_thread_ex_callback
    struct MINIDUMP_THREAD_EX_CALLBACK
    {
    align (4):
        uint    ThreadId;
        HANDLE  ThreadHandle;
        CONTEXT Context;
        uint    SizeOfContext;
        ulong   StackBase;
        ulong   StackEnd;
        ulong   BackingStoreBase;
        ulong   BackingStoreEnd;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_thread_ex_callback
    struct MINIDUMP_THREAD_EX_CALLBACK
    {
    align (4):
        uint    ThreadId;
        HANDLE  ThreadHandle;
        CONTEXT Context;
        uint    SizeOfContext;
        ulong   StackBase;
        ulong   StackEnd;
        ulong   BackingStoreBase;
        ulong   BackingStoreEnd;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_include_thread_callback
struct MINIDUMP_INCLUDE_THREAD_CALLBACK
{
align (4):
    uint ThreadId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_module_callback
struct MINIDUMP_MODULE_CALLBACK
{
align (4):
    PWSTR            FullPath;
    ulong            BaseOfImage;
    uint             SizeOfImage;
    uint             CheckSum;
    uint             TimeDateStamp;
    VS_FIXEDFILEINFO VersionInfo;
    void*            CvRecord;
    uint             SizeOfCvRecord;
    void*            MiscRecord;
    uint             SizeOfMiscRecord;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_include_module_callback
struct MINIDUMP_INCLUDE_MODULE_CALLBACK
{
align (4):
    ulong BaseOfImage;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_io_callback
struct MINIDUMP_IO_CALLBACK
{
align (4):
    HANDLE Handle;
    ulong  Offset;
    void*  Buffer;
    uint   BufferBytes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_read_memory_failure_callback
struct MINIDUMP_READ_MEMORY_FAILURE_CALLBACK
{
align (4):
    ulong   Offset;
    uint    Bytes;
    HRESULT FailureStatus;
}

struct MINIDUMP_VM_QUERY_CALLBACK
{
align (4):
    ulong Offset;
}

struct MINIDUMP_VM_PRE_READ_CALLBACK
{
align (4):
    ulong Offset;
    void* Buffer;
    uint  Size;
}

struct MINIDUMP_VM_POST_READ_CALLBACK
{
align (4):
    ulong   Offset;
    void*   Buffer;
    uint    Size;
    uint    Completed;
    HRESULT Status;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_callback_input
struct MINIDUMP_CALLBACK_INPUT
{
align (4):
    uint   ProcessId;
    HANDLE ProcessHandle;
    uint   CallbackType;
    union
    {
        HRESULT              Status;
        MINIDUMP_THREAD_CALLBACK Thread;
        MINIDUMP_THREAD_EX_CALLBACK ThreadEx;
        MINIDUMP_MODULE_CALLBACK Module;
        MINIDUMP_INCLUDE_THREAD_CALLBACK IncludeThread;
        MINIDUMP_INCLUDE_MODULE_CALLBACK IncludeModule;
        MINIDUMP_IO_CALLBACK Io;
        MINIDUMP_READ_MEMORY_FAILURE_CALLBACK ReadMemoryFailure;
        uint                 SecondaryFlags;
        MINIDUMP_VM_QUERY_CALLBACK VmQuery;
        MINIDUMP_VM_PRE_READ_CALLBACK VmPreRead;
        MINIDUMP_VM_POST_READ_CALLBACK VmPostRead;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_callback_output
struct MINIDUMP_CALLBACK_OUTPUT
{
align (4):
    union
    {
        uint    ModuleWriteFlags;
        uint    ThreadWriteFlags;
        uint    SecondaryFlags;
        struct
        {
        align (4):
            ulong MemoryBase;
            uint  MemorySize;
        }
        struct
        {
            BOOL CheckCancel;
            BOOL Cancel;
        }
        HANDLE  Handle;
        struct
        {
            MINIDUMP_MEMORY_INFO VmRegion;
            BOOL                 Continue;
        }
        struct
        {
            HRESULT              VmQueryStatus;
            MINIDUMP_MEMORY_INFO VmQueryResult;
        }
        struct
        {
            HRESULT VmReadStatus;
            uint    VmReadBytesCompleted;
        }
        HRESULT Status;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/ns-minidumpapiset-minidump_callback_information
    struct MINIDUMP_CALLBACK_INFORMATION
    {
        MINIDUMP_CALLBACK_ROUTINE CallbackRoutine;
        void* CallbackParam;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-loaded_image
    struct LOADED_IMAGE
    {
        PSTR                ModuleName;
        HANDLE              hFile;
        ubyte*              MappedAddress;
        IMAGE_NT_HEADERS32* FileHeader;
        IMAGE_SECTION_HEADER* LastRvaSection;
        uint                NumberOfSections;
        IMAGE_SECTION_HEADER* Sections;
        IMAGE_FILE_CHARACTERISTICS2 Characteristics;
        BOOLEAN             fSystemImage;
        BOOLEAN             fDOSImage;
        BOOLEAN             fReadOnly;
        ubyte               Version;
        LIST_ENTRY          Links;
        uint                SizeOfImage;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-image_debug_information
    struct IMAGE_DEBUG_INFORMATION
    {
        LIST_ENTRY List;
        uint       ReservedSize;
        void*      ReservedMappedBase;
        ushort     ReservedMachine;
        ushort     ReservedCharacteristics;
        uint       ReservedCheckSum;
        uint       ImageBase;
        uint       SizeOfImage;
        uint       ReservedNumberOfSections;
        IMAGE_SECTION_HEADER* ReservedSections;
        uint       ReservedExportedNamesSize;
        PSTR       ReservedExportedNames;
        uint       ReservedNumberOfFunctionTableEntries;
        IMAGE_FUNCTION_ENTRY* ReservedFunctionTableEntries;
        uint       ReservedLowestFunctionStartingAddress;
        uint       ReservedHighestFunctionEndingAddress;
        uint       ReservedNumberOfFpoTableEntries;
        FPO_DATA*  ReservedFpoTableEntries;
        uint       SizeOfCoffSymbols;
        IMAGE_COFF_SYMBOLS_HEADER* CoffSymbols;
        uint       ReservedSizeOfCodeViewSymbols;
        void*      ReservedCodeViewSymbols;
        PSTR       ImageFilePath;
        PSTR       ImageFileName;
        PSTR       ReservedDebugFilePath;
        uint       ReservedTimeDateStamp;
        BOOL       ReservedRomImage;
        IMAGE_DEBUG_DIRECTORY* ReservedDebugDirectory;
        uint       ReservedNumberOfDebugDirectories;
        uint       ReservedOriginalFunctionTableBaseAddress;
        uint[2]    Reserved;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-modload_data
struct MODLOAD_DATA
{
    uint              ssize;
    MODLOAD_DATA_TYPE ssig;
    void*             data;
    uint              size;
    uint              flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-modload_cvmisc
struct MODLOAD_CVMISC
{
    uint   oCV;
    size_t cCV;
    uint   oMisc;
    size_t cMisc;
    uint   dtImage;
    uint   cImage;
}

struct MODLOAD_PDBGUID_PDBAGE
{
    GUID PdbGuid;
    uint PdbAge;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-address64
struct ADDRESS64
{
    ulong        Offset;
    ushort       Segment;
    ADDRESS_MODE Mode;
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/NetMon2/address
    struct ADDRESS
    {
        uint         Offset;
        ushort       Segment;
        ADDRESS_MODE Mode;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-kdhelp64
struct KDHELP64
{
    ulong    Thread;
    uint     ThCallbackStack;
    uint     ThCallbackBStore;
    uint     NextCallback;
    uint     FramePointer;
    ulong    KiCallUserMode;
    ulong    KeUserCallbackDispatcher;
    ulong    SystemRangeStart;
    ulong    KiUserExceptionDispatcher;
    ulong    StackBase;
    ulong    StackLimit;
    uint     BuildVersion;
    uint     RetpolineStubFunctionTableSize;
    ulong    RetpolineStubFunctionTable;
    uint     RetpolineStubOffset;
    uint     RetpolineStubSize;
    ulong[2] Reserved0;
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-kdhelp
    struct KDHELP
    {
        uint    Thread;
        uint    ThCallbackStack;
        uint    NextCallback;
        uint    FramePointer;
        uint    KiCallUserMode;
        uint    KeUserCallbackDispatcher;
        uint    SystemRangeStart;
        uint    ThCallbackBStore;
        uint    KiUserExceptionDispatcher;
        uint    StackBase;
        uint    StackLimit;
        uint[5] Reserved;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-stackframe64
struct STACKFRAME64
{
    ADDRESS64 AddrPC;
    ADDRESS64 AddrReturn;
    ADDRESS64 AddrFrame;
    ADDRESS64 AddrStack;
    ADDRESS64 AddrBStore;
    void*     FuncTableEntry;
    ulong[4]  Params;
    BOOL      Far;
    BOOL      Virtual;
    ulong[3]  Reserved;
    KDHELP64  KdHelp;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-stackframe_ex
struct STACKFRAME_EX
{
    ADDRESS64 AddrPC;
    ADDRESS64 AddrReturn;
    ADDRESS64 AddrFrame;
    ADDRESS64 AddrStack;
    ADDRESS64 AddrBStore;
    void*     FuncTableEntry;
    ulong[4]  Params;
    BOOL      Far;
    BOOL      Virtual;
    ulong[3]  Reserved;
    KDHELP64  KdHelp;
    uint      StackFrameSize;
    uint      InlineFrameContext;
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-stackframe
    struct STACKFRAME
    {
        ADDRESS AddrPC;
        ADDRESS AddrReturn;
        ADDRESS AddrFrame;
        ADDRESS AddrStack;
        void*   FuncTableEntry;
        uint[4] Params;
        BOOL    Far;
        BOOL    Virtual;
        uint[3] Reserved;
        KDHELP  KdHelp;
        ADDRESS AddrBStore;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-api_version
struct API_VERSION
{
    ushort MajorVersion;
    ushort MinorVersion;
    ushort Revision;
    ushort Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-imagehlp_symbol64
struct IMAGEHLP_SYMBOL64
{
    uint    SizeOfStruct;
    ulong   Address;
    uint    Size;
    uint    Flags;
    uint    MaxNameLength;
    CHAR[1] Name; // Flexible array
}

struct IMAGEHLP_SYMBOL64_PACKAGE
{
    IMAGEHLP_SYMBOL64 sym;
    CHAR[2001]        name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-imagehlp_symbolw64
struct IMAGEHLP_SYMBOLW64
{
    uint     SizeOfStruct;
    ulong    Address;
    uint     Size;
    uint     Flags;
    uint     MaxNameLength;
    wchar[1] Name; // Flexible array
}

struct IMAGEHLP_SYMBOLW64_PACKAGE
{
    IMAGEHLP_SYMBOLW64 sym;
    wchar[2001]        name;
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-imagehlp_symbol
    struct IMAGEHLP_SYMBOL
    {
        uint    SizeOfStruct;
        uint    Address;
        uint    Size;
        uint    Flags;
        uint    MaxNameLength;
        CHAR[1] Name; // Flexible array
    }
}

version(X86)
{
    struct IMAGEHLP_SYMBOL_PACKAGE
    {
        IMAGEHLP_SYMBOL sym;
        CHAR[2001]      name;
    }
}

version(X86)
{
    struct IMAGEHLP_SYMBOLW
    {
        uint     SizeOfStruct;
        uint     Address;
        uint     Size;
        uint     Flags;
        uint     MaxNameLength;
        wchar[1] Name; // Flexible array
    }
}

version(X86)
{
    struct IMAGEHLP_SYMBOLW_PACKAGE
    {
        IMAGEHLP_SYMBOLW sym;
        wchar[2001]      name;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-imagehlp_module64
struct IMAGEHLP_MODULE64
{
    uint      SizeOfStruct;
    ulong     BaseOfImage;
    uint      ImageSize;
    uint      TimeDateStamp;
    uint      CheckSum;
    uint      NumSyms;
    SYM_TYPE  SymType;
    CHAR[32]  ModuleName;
    CHAR[256] ImageName;
    CHAR[256] LoadedImageName;
    CHAR[256] LoadedPdbName;
    uint      CVSig;
    CHAR[780] CVData;
    uint      PdbSig;
    GUID      PdbSig70;
    uint      PdbAge;
    BOOL      PdbUnmatched;
    BOOL      DbgUnmatched;
    BOOL      LineNumbers;
    BOOL      GlobalSymbols;
    BOOL      TypeInfo;
    BOOL      SourceIndexed;
    BOOL      Publics;
    uint      MachineType;
    uint      Reserved;
}

struct IMAGEHLP_MODULE64_EX
{
    IMAGEHLP_MODULE64 Module;
    uint              RegionFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-imagehlp_modulew64
struct IMAGEHLP_MODULEW64
{
    uint       SizeOfStruct;
    ulong      BaseOfImage;
    uint       ImageSize;
    uint       TimeDateStamp;
    uint       CheckSum;
    uint       NumSyms;
    SYM_TYPE   SymType;
    wchar[32]  ModuleName;
    wchar[256] ImageName;
    wchar[256] LoadedImageName;
    wchar[256] LoadedPdbName;
    uint       CVSig;
    wchar[780] CVData;
    uint       PdbSig;
    GUID       PdbSig70;
    uint       PdbAge;
    BOOL       PdbUnmatched;
    BOOL       DbgUnmatched;
    BOOL       LineNumbers;
    BOOL       GlobalSymbols;
    BOOL       TypeInfo;
    BOOL       SourceIndexed;
    BOOL       Publics;
    uint       MachineType;
    uint       Reserved;
}

struct IMAGEHLP_MODULEW64_EX
{
    IMAGEHLP_MODULEW64 Module;
    uint               RegionFlags;
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-imagehlp_module
    struct IMAGEHLP_MODULE
    {
        uint      SizeOfStruct;
        uint      BaseOfImage;
        uint      ImageSize;
        uint      TimeDateStamp;
        uint      CheckSum;
        uint      NumSyms;
        SYM_TYPE  SymType;
        CHAR[32]  ModuleName;
        CHAR[256] ImageName;
        CHAR[256] LoadedImageName;
    }
}

version(X86)
{
    struct IMAGEHLP_MODULEW
    {
        uint       SizeOfStruct;
        uint       BaseOfImage;
        uint       ImageSize;
        uint       TimeDateStamp;
        uint       CheckSum;
        uint       NumSyms;
        SYM_TYPE   SymType;
        wchar[32]  ModuleName;
        wchar[256] ImageName;
        wchar[256] LoadedImageName;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-imagehlp_line64
struct IMAGEHLP_LINE64
{
    uint  SizeOfStruct;
    void* Key;
    uint  LineNumber;
    PSTR  FileName;
    ulong Address;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-imagehlp_linew64
struct IMAGEHLP_LINEW64
{
    uint  SizeOfStruct;
    void* Key;
    uint  LineNumber;
    PWSTR FileName;
    ulong Address;
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-imagehlp_line
    struct IMAGEHLP_LINE
    {
        uint  SizeOfStruct;
        void* Key;
        uint  LineNumber;
        PSTR  FileName;
        uint  Address;
    }
}

version(X86)
{
    struct IMAGEHLP_LINEW
    {
        uint  SizeOfStruct;
        void* Key;
        uint  LineNumber;
        PSTR  FileName;
        ulong Address;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-sourcefile
struct SOURCEFILE
{
    ulong ModBase;
    PSTR  FileName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-sourcefilew
struct SOURCEFILEW
{
    ulong ModBase;
    PWSTR FileName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-imagehlp_cba_read_memory
struct IMAGEHLP_CBA_READ_MEMORY
{
    ulong addr;
    void* buf;
    uint  bytes;
    uint* bytesread;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-imagehlp_cba_event
struct IMAGEHLP_CBA_EVENT
{
    IMAGEHLP_CBA_EVENT_SEVERITY severity;
    uint  code;
    PSTR  desc;
    void* object;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-imagehlp_cba_eventw
struct IMAGEHLP_CBA_EVENTW
{
    IMAGEHLP_CBA_EVENT_SEVERITY severity;
    uint         code;
    const(PWSTR) desc;
    void*        object;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-imagehlp_deferred_symbol_load64
struct IMAGEHLP_DEFERRED_SYMBOL_LOAD64
{
    uint      SizeOfStruct;
    ulong     BaseOfImage;
    uint      CheckSum;
    uint      TimeDateStamp;
    CHAR[260] FileName;
    BOOLEAN   Reparse;
    HANDLE    hFile;
    uint      Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-imagehlp_deferred_symbol_loadw64
struct IMAGEHLP_DEFERRED_SYMBOL_LOADW64
{
    uint       SizeOfStruct;
    ulong      BaseOfImage;
    uint       CheckSum;
    uint       TimeDateStamp;
    wchar[261] FileName;
    BOOLEAN    Reparse;
    HANDLE     hFile;
    uint       Flags;
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-imagehlp_deferred_symbol_load
    struct IMAGEHLP_DEFERRED_SYMBOL_LOAD
    {
        uint      SizeOfStruct;
        uint      BaseOfImage;
        uint      CheckSum;
        uint      TimeDateStamp;
        CHAR[260] FileName;
        BOOLEAN   Reparse;
        HANDLE    hFile;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-imagehlp_duplicate_symbol64
struct IMAGEHLP_DUPLICATE_SYMBOL64
{
    uint               SizeOfStruct;
    uint               NumberOfDups;
    IMAGEHLP_SYMBOL64* Symbol;
    uint               SelectedSymbol;
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-imagehlp_duplicate_symbol
    struct IMAGEHLP_DUPLICATE_SYMBOL
    {
        uint             SizeOfStruct;
        uint             NumberOfDups;
        IMAGEHLP_SYMBOL* Symbol;
        uint             SelectedSymbol;
    }
}

struct IMAGEHLP_JIT_SYMBOLMAP
{
    uint  SizeOfStruct;
    ulong Address;
    ulong BaseOfImage;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-omap
struct OMAP
{
    uint rva;
    uint rvaTo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-srccodeinfo
struct SRCCODEINFO
{
    uint      SizeOfStruct;
    void*     Key;
    ulong     ModBase;
    CHAR[261] Obj;
    CHAR[261] FileName;
    uint      LineNumber;
    ulong     Address;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-srccodeinfow
struct SRCCODEINFOW
{
    uint       SizeOfStruct;
    void*      Key;
    ulong      ModBase;
    wchar[261] Obj;
    wchar[261] FileName;
    uint       LineNumber;
    ulong      Address;
}

struct IMAGEHLP_SYMBOL_SRC
{
    uint      sizeofstruct;
    uint      type;
    CHAR[260] file;
}

struct MODULE_TYPE_INFO
{
    ushort   dataLength;
    ushort   leaf;
    ubyte[1] data; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-symbol_info
struct SYMBOL_INFO
{
    uint              SizeOfStruct;
    uint              TypeIndex;
    ulong[2]          Reserved;
    uint              Index;
    uint              Size;
    ulong             ModBase;
    SYMBOL_INFO_FLAGS Flags;
    ulong             Value;
    ulong             Address;
    uint              Register;
    uint              Scope;
    uint              Tag;
    uint              NameLen;
    uint              MaxNameLen;
    CHAR[1]           Name; // Flexible array
}

struct SYMBOL_INFO_PACKAGE
{
    SYMBOL_INFO si;
    CHAR[2001]  name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-symbol_infow
struct SYMBOL_INFOW
{
    uint              SizeOfStruct;
    uint              TypeIndex;
    ulong[2]          Reserved;
    uint              Index;
    uint              Size;
    ulong             ModBase;
    SYMBOL_INFO_FLAGS Flags;
    ulong             Value;
    ulong             Address;
    uint              Register;
    uint              Scope;
    uint              Tag;
    uint              NameLen;
    uint              MaxNameLen;
    wchar[1]          Name; // Flexible array
}

struct SYMBOL_INFO_PACKAGEW
{
    SYMBOL_INFOW si;
    wchar[2001]  name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-imagehlp_stack_frame
struct IMAGEHLP_STACK_FRAME
{
    ulong    InstructionOffset;
    ulong    ReturnOffset;
    ulong    FrameOffset;
    ulong    StackOffset;
    ulong    BackingStoreOffset;
    ulong    FuncTableEntry;
    ulong[4] Params;
    ulong[5] Reserved;
    BOOL     Virtual;
    uint     Reserved2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-ti_findchildren_params
struct TI_FINDCHILDREN_PARAMS
{
    uint    Count;
    uint    Start;
    uint[1] ChildId; // Flexible array
}

struct DISCRIMINATEDUNION_TAG_VALUE
{
    ubyte[16] value;
    ubyte     valueSizeBytes;
}

struct TI_GET_DISCRIMINATEDUNION_TAG_RANGES_PARAMS
{
    uint Count;
    uint Start;
    DISCRIMINATEDUNION_TAG_VALUE[1] Range; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-imagehlp_get_type_info_params
struct IMAGEHLP_GET_TYPE_INFO_PARAMS
{
    uint    SizeOfStruct;
    IMAGEHLP_GET_TYPE_INFO_FLAGS Flags;
    uint    NumIds;
    uint*   TypeIds;
    ulong   TagFilter;
    uint    NumReqs;
    IMAGEHLP_SYMBOL_TYPE_INFO* ReqKinds;
    size_t* ReqOffsets;
    uint*   ReqSizes;
    size_t  ReqStride;
    size_t  BufferSize;
    void*   Buffer;
    uint    EntriesMatched;
    uint    EntriesFilled;
    ulong   TagsFound;
    ulong   AllReqsValid;
    uint    NumReqsValid;
    ulong*  ReqsValid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-symsrv_index_info
struct SYMSRV_INDEX_INFO
{
    uint      sizeofstruct;
    CHAR[261] file;
    BOOL      stripped;
    uint      timestamp;
    uint      size;
    CHAR[261] dbgfile;
    CHAR[261] pdbfile;
    GUID      guid;
    uint      sig;
    uint      age;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/ns-dbghelp-symsrv_index_infow
struct SYMSRV_INDEX_INFOW
{
    uint       sizeofstruct;
    wchar[261] file;
    BOOL       stripped;
    uint       timestamp;
    uint       size;
    wchar[261] dbgfile;
    wchar[261] pdbfile;
    GUID       guid;
    uint       sig;
    uint       age;
}

struct SYMSRV_EXTENDED_OUTPUT_DATA
{
    uint       sizeOfStruct;
    uint       version_;
    wchar[261] filePtrMsg;
}

struct DBGHELP_DATA_REPORT_STRUCT
{
    const(PWSTR) pBinPathNonExist;
    const(PWSTR) pSymbolPathNonExist;
}

struct PHYSICAL_MEMORY_RUN32
{
    uint BasePage;
    uint PageCount;
}

struct PHYSICAL_MEMORY_DESCRIPTOR32
{
    uint NumberOfRuns;
    uint NumberOfPages;
    PHYSICAL_MEMORY_RUN32[1] Run; // Flexible array
}

struct PHYSICAL_MEMORY_RUN64
{
    ulong BasePage;
    ulong PageCount;
}

struct PHYSICAL_MEMORY_DESCRIPTOR64
{
    uint  NumberOfRuns;
    ulong NumberOfPages;
    PHYSICAL_MEMORY_RUN64[1] Run; // Flexible array
}

union DUMP_FILE_ATTRIBUTES
{
    struct
    {
        // Native bit field: HiberCrash: [0], DumpDevicePowerOff: [1], InsufficientDumpfileSize: [2], KernelGeneratedTriageDump: [3], LiveDumpGeneratedDump: [4], DumpIsGeneratedOffline: [5], FilterDumpFile: [6], EarlyBootCrash: [7], EncryptedDumpData: [8], DecryptedDump: [9], ReservedFlags: [10-31]
        uint _bitfield0;
    }
    uint Attributes;
}

struct DUMP_HEADER32
{
    uint                 Signature;
    uint                 ValidDump;
    uint                 MajorVersion;
    uint                 MinorVersion;
    uint                 DirectoryTableBase;
    uint                 PfnDataBase;
    uint                 PsLoadedModuleList;
    uint                 PsActiveProcessHead;
    uint                 MachineImageType;
    uint                 NumberProcessors;
    uint                 BugCheckCode;
    uint                 BugCheckParameter1;
    uint                 BugCheckParameter2;
    uint                 BugCheckParameter3;
    uint                 BugCheckParameter4;
    CHAR[32]             VersionUser;
    ubyte                PaeEnabled;
    ubyte                KdSecondaryVersion;
    ubyte[2]             Spare3;
    uint                 KdDebuggerDataBlock;
    union
    {
        PHYSICAL_MEMORY_DESCRIPTOR32 PhysicalMemoryBlock;
        ubyte[700] PhysicalMemoryBlockBuffer;
    }
    ubyte[1200]          ContextRecord;
    EXCEPTION_RECORD32   Exception;
    CHAR[128]            Comment;
    DUMP_FILE_ATTRIBUTES Attributes;
    uint                 BootId;
    ubyte[1760]          _reserved0;
    uint                 DumpType;
    uint                 MiniDumpFields;
    uint                 SecondaryDataState;
    uint                 ProductType;
    uint                 SuiteMask;
    uint                 WriterStatus;
    long                 RequiredDumpSpace;
    ubyte[16]            _reserved2;
    long                 SystemUpTime;
    long                 SystemTime;
    ubyte[56]            _reserved3;
}

struct DUMP_HEADER64
{
    uint                 Signature;
    uint                 ValidDump;
    uint                 MajorVersion;
    uint                 MinorVersion;
    ulong                DirectoryTableBase;
    ulong                PfnDataBase;
    ulong                PsLoadedModuleList;
    ulong                PsActiveProcessHead;
    uint                 MachineImageType;
    uint                 NumberProcessors;
    uint                 BugCheckCode;
    ulong                BugCheckParameter1;
    ulong                BugCheckParameter2;
    ulong                BugCheckParameter3;
    ulong                BugCheckParameter4;
    CHAR[32]             VersionUser;
    ulong                KdDebuggerDataBlock;
    union
    {
        PHYSICAL_MEMORY_DESCRIPTOR64 PhysicalMemoryBlock;
        ubyte[700] PhysicalMemoryBlockBuffer;
    }
    ubyte[3000]          ContextRecord;
    EXCEPTION_RECORD64   Exception;
    uint                 DumpType;
    long                 RequiredDumpSpace;
    long                 SystemTime;
    CHAR[128]            Comment;
    long                 SystemUpTime;
    uint                 MiniDumpFields;
    uint                 SecondaryDataState;
    uint                 ProductType;
    uint                 SuiteMask;
    uint                 WriterStatus;
    ubyte                Unused1;
    ubyte                KdSecondaryVersion;
    ubyte[2]             Unused;
    DUMP_FILE_ATTRIBUTES Attributes;
    uint                 BootId;
    ubyte[4008]          _reserved0;
}

struct WHEA_ERROR_SOURCE_CONFIGURATION_DD
{
align (1):
    WHEA_ERROR_SOURCE_INITIALIZE_DEVICE_DRIVER Initialize;
    WHEA_ERROR_SOURCE_UNINITIALIZE_DEVICE_DRIVER Uninitialize;
    WHEA_ERROR_SOURCE_CORRECT_DEVICE_DRIVER Correct;
}

struct WHEA_ERROR_SOURCE_CONFIGURATION_DEVICE_DRIVER_V1
{
align (1):
    uint     Version;
    GUID     SourceGuid;
    ushort   LogTag;
    ubyte[6] Reserved;
    WHEA_ERROR_SOURCE_INITIALIZE_DEVICE_DRIVER Initialize;
    WHEA_ERROR_SOURCE_UNINITIALIZE_DEVICE_DRIVER Uninitialize;
}

struct WHEA_ERROR_SOURCE_CONFIGURATION_DEVICE_DRIVER
{
align (1):
    uint     Version;
    GUID     SourceGuid;
    ushort   LogTag;
    ubyte[6] Reserved;
    WHEA_ERROR_SOURCE_INITIALIZE_DEVICE_DRIVER Initialize;
    WHEA_ERROR_SOURCE_UNINITIALIZE_DEVICE_DRIVER Uninitialize;
    uint     MaxSectionDataLength;
    uint     MaxSectionsPerReport;
    GUID     CreatorId;
    GUID     PartitionId;
}

struct WHEA_DRIVER_BUFFER_SET
{
align (1):
    uint   Version;
    ubyte* Data;
    uint   DataSize;
    GUID*  SectionTypeGuid;
    ubyte* SectionFriendlyName;
    ubyte* Flags;
}

union WHEA_NOTIFICATION_FLAGS
{
align (1):
    struct
    {
    align (1):
        // Native bit field: PollIntervalRW: [0], SwitchToPollingThresholdRW: [1], SwitchToPollingWindowRW: [2], ErrorThresholdRW: [3], ErrorThresholdWindowRW: [4], Reserved: [5-15]
        ushort _bitfield0;
    }
    ushort AsUSHORT;
}

union XPF_MC_BANK_FLAGS
{
    struct
    {
        // Native bit field: ClearOnInitializationRW: [0], ControlDataRW: [1], Reserved: [2-7]
        ubyte _bitfield0;
    }
    ubyte AsUCHAR;
}

union XPF_MCE_FLAGS
{
align (1):
    struct
    {
    align (1):
        // Native bit field: MCG_CapabilityRW: [0], MCG_GlobalControlRW: [1], Reserved: [2-31]
        uint _bitfield0;
    }
    uint AsULONG;
}

union AER_ROOTPORT_DESCRIPTOR_FLAGS
{
align (1):
    struct
    {
    align (1):
        // Native bit field: UncorrectableErrorMaskRW: [0], UncorrectableErrorSeverityRW: [1], CorrectableErrorMaskRW: [2], AdvancedCapsAndControlRW: [3], RootErrorCommandRW: [4], Reserved: [5-15]
        ushort _bitfield0;
    }
    ushort AsUSHORT;
}

union AER_ENDPOINT_DESCRIPTOR_FLAGS
{
align (1):
    struct
    {
    align (1):
        // Native bit field: UncorrectableErrorMaskRW: [0], UncorrectableErrorSeverityRW: [1], CorrectableErrorMaskRW: [2], AdvancedCapsAndControlRW: [3], Reserved: [4-15]
        ushort _bitfield0;
    }
    ushort AsUSHORT;
}

union AER_BRIDGE_DESCRIPTOR_FLAGS
{
align (1):
    struct
    {
    align (1):
        // Native bit field: UncorrectableErrorMaskRW: [0], UncorrectableErrorSeverityRW: [1], CorrectableErrorMaskRW: [2], AdvancedCapsAndControlRW: [3], SecondaryUncorrectableErrorMaskRW: [4], SecondaryUncorrectableErrorSevRW: [5], SecondaryCapsAndControlRW: [6], Reserved: [7-15]
        ushort _bitfield0;
    }
    ushort AsUSHORT;
}

struct WHEA_NOTIFICATION_DESCRIPTOR
{
    ubyte Type;
    ubyte Length;
    WHEA_NOTIFICATION_FLAGS Flags;
    union u
    {
        struct Polled
        {
        align (1):
            uint PollInterval;
        }
        struct Interrupt
        {
        align (1):
            uint PollInterval;
            uint Vector;
            uint SwitchToPollingThreshold;
            uint SwitchToPollingWindow;
            uint ErrorThreshold;
            uint ErrorThresholdWindow;
        }
        struct LocalInterrupt
        {
        align (1):
            uint PollInterval;
            uint Vector;
            uint SwitchToPollingThreshold;
            uint SwitchToPollingWindow;
            uint ErrorThreshold;
            uint ErrorThresholdWindow;
        }
        struct Sci
        {
        align (1):
            uint PollInterval;
            uint Vector;
            uint SwitchToPollingThreshold;
            uint SwitchToPollingWindow;
            uint ErrorThreshold;
            uint ErrorThresholdWindow;
        }
        struct Nmi
        {
        align (1):
            uint PollInterval;
            uint Vector;
            uint SwitchToPollingThreshold;
            uint SwitchToPollingWindow;
            uint ErrorThreshold;
            uint ErrorThresholdWindow;
        }
        struct Sea
        {
        align (1):
            uint PollInterval;
            uint Vector;
            uint SwitchToPollingThreshold;
            uint SwitchToPollingWindow;
            uint ErrorThreshold;
            uint ErrorThresholdWindow;
        }
        struct Sei
        {
        align (1):
            uint PollInterval;
            uint Vector;
            uint SwitchToPollingThreshold;
            uint SwitchToPollingWindow;
            uint ErrorThreshold;
            uint ErrorThresholdWindow;
        }
        struct Gsiv
        {
        align (1):
            uint PollInterval;
            uint Vector;
            uint SwitchToPollingThreshold;
            uint SwitchToPollingWindow;
            uint ErrorThreshold;
            uint ErrorThresholdWindow;
        }
    }
}

struct WHEA_XPF_MC_BANK_DESCRIPTOR
{
align (1):
    ubyte             BankNumber;
    BOOLEAN           ClearOnInitialization;
    ubyte             StatusDataFormat;
    XPF_MC_BANK_FLAGS Flags;
    uint              ControlMsr;
    uint              StatusMsr;
    uint              AddressMsr;
    uint              MiscMsr;
    ulong             ControlData;
}

struct WHEA_XPF_MCE_DESCRIPTOR
{
align (1):
    ushort        Type;
    ubyte         Enabled;
    ubyte         NumberOfBanks;
    XPF_MCE_FLAGS Flags;
    ulong         MCG_Capability;
    ulong         MCG_GlobalControl;
    WHEA_XPF_MC_BANK_DESCRIPTOR[32] Banks;
}

struct WHEA_XPF_CMC_DESCRIPTOR
{
align (1):
    ushort  Type;
    BOOLEAN Enabled;
    ubyte   NumberOfBanks;
    uint    Reserved;
    WHEA_NOTIFICATION_DESCRIPTOR Notify;
    WHEA_XPF_MC_BANK_DESCRIPTOR[32] Banks;
}

struct WHEA_PCI_SLOT_NUMBER
{
    union u
    {
    align (1):
        struct bits
        {
        align (1):
            // Native bit field: DeviceNumber: [0-4], FunctionNumber: [5-7], Reserved: [8-31]
            uint _bitfield0;
        }
        uint AsULONG;
    }
}

struct WHEA_XPF_NMI_DESCRIPTOR
{
align (1):
    ushort  Type;
    BOOLEAN Enabled;
}

struct WHEA_AER_ROOTPORT_DESCRIPTOR
{
align (1):
    ushort               Type;
    BOOLEAN              Enabled;
    ubyte                Reserved;
    uint                 BusNumber;
    WHEA_PCI_SLOT_NUMBER Slot;
    ushort               DeviceControl;
    AER_ROOTPORT_DESCRIPTOR_FLAGS Flags;
    uint                 UncorrectableErrorMask;
    uint                 UncorrectableErrorSeverity;
    uint                 CorrectableErrorMask;
    uint                 AdvancedCapsAndControl;
    uint                 RootErrorCommand;
}

struct WHEA_AER_ENDPOINT_DESCRIPTOR
{
align (1):
    ushort               Type;
    BOOLEAN              Enabled;
    ubyte                Reserved;
    uint                 BusNumber;
    WHEA_PCI_SLOT_NUMBER Slot;
    ushort               DeviceControl;
    AER_ENDPOINT_DESCRIPTOR_FLAGS Flags;
    uint                 UncorrectableErrorMask;
    uint                 UncorrectableErrorSeverity;
    uint                 CorrectableErrorMask;
    uint                 AdvancedCapsAndControl;
}

struct WHEA_AER_BRIDGE_DESCRIPTOR
{
align (1):
    ushort               Type;
    BOOLEAN              Enabled;
    ubyte                Reserved;
    uint                 BusNumber;
    WHEA_PCI_SLOT_NUMBER Slot;
    ushort               DeviceControl;
    AER_BRIDGE_DESCRIPTOR_FLAGS Flags;
    uint                 UncorrectableErrorMask;
    uint                 UncorrectableErrorSeverity;
    uint                 CorrectableErrorMask;
    uint                 AdvancedCapsAndControl;
    uint                 SecondaryUncorrectableErrorMask;
    uint                 SecondaryUncorrectableErrorSev;
    uint                 SecondaryCapsAndControl;
}

struct WHEA_GENERIC_ERROR_DESCRIPTOR
{
align (1):
    ushort Type;
    ubyte  Reserved;
    ubyte  Enabled;
    uint   ErrStatusBlockLength;
    uint   RelatedErrorSourceId;
    ubyte  ErrStatusAddressSpaceID;
    ubyte  ErrStatusAddressBitWidth;
    ubyte  ErrStatusAddressBitOffset;
    ubyte  ErrStatusAddressAccessSize;
    long   ErrStatusAddress;
    WHEA_NOTIFICATION_DESCRIPTOR Notify;
}

struct WHEA_GENERIC_ERROR_DESCRIPTOR_V2
{
align (1):
    ushort Type;
    ubyte  Reserved;
    ubyte  Enabled;
    uint   ErrStatusBlockLength;
    uint   RelatedErrorSourceId;
    ubyte  ErrStatusAddressSpaceID;
    ubyte  ErrStatusAddressBitWidth;
    ubyte  ErrStatusAddressBitOffset;
    ubyte  ErrStatusAddressAccessSize;
    long   ErrStatusAddress;
    WHEA_NOTIFICATION_DESCRIPTOR Notify;
    ubyte  ReadAckAddressSpaceID;
    ubyte  ReadAckAddressBitWidth;
    ubyte  ReadAckAddressBitOffset;
    ubyte  ReadAckAddressAccessSize;
    long   ReadAckAddress;
    ulong  ReadAckPreserveMask;
    ulong  ReadAckWriteMask;
}

struct WHEA_DEVICE_DRIVER_DESCRIPTOR
{
align (1):
    ushort  Type;
    BOOLEAN Enabled;
    ubyte   Reserved;
    GUID    SourceGuid;
    ushort  LogTag;
    ushort  Reserved2;
    uint    PacketLength;
    uint    PacketCount;
    ubyte*  PacketBuffer;
    WHEA_ERROR_SOURCE_CONFIGURATION_DD Config;
    GUID    CreatorId;
    GUID    PartitionId;
    uint    MaxSectionDataLength;
    uint    MaxSectionsPerRecord;
    ubyte*  PacketStateBuffer;
    int     OpenHandles;
}

struct WHEA_IPF_MCA_DESCRIPTOR
{
align (1):
    ushort Type;
    ubyte  Enabled;
    ubyte  Reserved;
}

struct WHEA_IPF_CMC_DESCRIPTOR
{
align (1):
    ushort Type;
    ubyte  Enabled;
    ubyte  Reserved;
}

struct WHEA_IPF_CPE_DESCRIPTOR
{
align (1):
    ushort Type;
    ubyte  Enabled;
    ubyte  Reserved;
}

struct WHEA_ERROR_SOURCE_DESCRIPTOR
{
align (1):
    uint Length;
    uint Version;
    WHEA_ERROR_SOURCE_TYPE Type;
    WHEA_ERROR_SOURCE_STATE State;
    uint MaxRawDataLength;
    uint NumRecordsToPreallocate;
    uint MaxSectionsPerRecord;
    uint ErrorSourceId;
    uint PlatformErrorSourceId;
    uint Flags;
    union Info
    {
        WHEA_XPF_MCE_DESCRIPTOR XpfMceDescriptor;
        WHEA_XPF_CMC_DESCRIPTOR XpfCmcDescriptor;
        WHEA_XPF_NMI_DESCRIPTOR XpfNmiDescriptor;
        WHEA_IPF_MCA_DESCRIPTOR IpfMcaDescriptor;
        WHEA_IPF_CMC_DESCRIPTOR IpfCmcDescriptor;
        WHEA_IPF_CPE_DESCRIPTOR IpfCpeDescriptor;
        WHEA_AER_ROOTPORT_DESCRIPTOR AerRootportDescriptor;
        WHEA_AER_ENDPOINT_DESCRIPTOR AerEndpointDescriptor;
        WHEA_AER_BRIDGE_DESCRIPTOR AerBridgeDescriptor;
        WHEA_GENERIC_ERROR_DESCRIPTOR GenErrDescriptor;
        WHEA_GENERIC_ERROR_DESCRIPTOR_V2 GenErrDescriptorV2;
        WHEA_DEVICE_DRIVER_DESCRIPTOR DeviceDriverDescriptor;
    }
}

struct IPMI_OS_SEL_RECORD
{
align (1):
    uint     Signature;
    uint     Version;
    uint     Length;
    IPMI_OS_SEL_RECORD_TYPE RecordType;
    uint     DataLength;
    ubyte[1] Data; // Flexible array
}

union DIMM_ADDRESS
{
    struct Ddr4
    {
    align (1):
        // Native bit field: SocketId: [0-3], MemoryControllerId: [4-5], ChannelId: [6-7], DimmSlot: [8-9], DimmRank: [10-11], Device: [12-16], ChipSelect: [17-19], Bank: [20-27], Dq: [28-31], Reserved: [32-63]
        ulong _bitfield0;
        uint  Row;
        uint  Column;
        ulong Info;
    }
    struct Ddr5
    {
    align (1):
        // Native bit field: SocketId: [0-4], MemoryControllerId: [5-8], ChannelId: [9-11], SubChannelId: [12-13], DimmSlot: [14-15], DimmRank: [16-19], Device: [20-25], ChipId: [26-29], Bank: [30-37], Dq: [38-42], Reserved: [43-63]
        ulong _bitfield1;
        uint  Row;
        uint  Column;
        ulong Info;
    }
}

union PAGE_OFFLINE_VALID_BITS
{
    struct
    {
        // Native bit field: PhysicalAddress: [0], MemDefect: [1], Reserved: [2-7]
        ubyte _bitfield0;
    }
    ubyte AsUINT8;
}

struct DIMM_ADDR_VALID_BITS_DDR4
{
align (1):
    // Native bit field: SocketId: [0], MemoryControllerId: [1], ChannelId: [2], DimmSlot: [3], DimmRank: [4], Device: [5], ChipSelect: [6], Bank: [7], Dq: [8], Row: [9], Column: [10], Info: [11], Reserved: [12-31]
    uint _bitfield0;
}

struct DIMM_ADDR_VALID_BITS_DDR5
{
align (1):
    // Native bit field: SocketId: [0], MemoryControllerId: [1], ChannelId: [2], SubChannelId: [3], DimmSlot: [4], DimmRank: [5], Device: [6], ChipId: [7], Bank: [8], Dq: [9], Row: [10], Column: [11], Info: [12], Reserved: [13-31]
    uint _bitfield0;
}

union DIMM_ADDR_VALID_BITS
{
align (1):
    DIMM_ADDR_VALID_BITS_DDR4 VB_DDR4;
    DIMM_ADDR_VALID_BITS_DDR5 VB_DDR5;
    uint AsUINT32;
}

struct DIMM_INFO
{
    DIMM_ADDRESS         DimmAddress;
    DIMM_ADDR_VALID_BITS ValidBits;
}

struct MEMORY_DEFECT
{
align (1):
    uint      Version;
    DIMM_INFO DimmInfo;
    PAGE_OFFLINE_ERROR_TYPES ErrType;
}

struct DebugPropertyInfo
{
    uint           m_dwValidFields;
    BSTR           m_bstrName;
    BSTR           m_bstrType;
    BSTR           m_bstrValue;
    BSTR           m_bstrFullName;
    uint           m_dwAttrib;
    IDebugProperty m_pDebugProp;
}

struct ExtendedDebugPropertyInfo
{
    uint           dwValidFields;
    PWSTR          pszName;
    PWSTR          pszType;
    PWSTR          pszValue;
    PWSTR          pszFullName;
    uint           dwAttrib;
    IDebugProperty pDebugProp;
    uint           nDISPID;
    uint           nType;
    VARIANT        varValue;
    ILockBytes     plbValue;
    IDebugExtendedProperty pDebugExtProp;
}

// Functions

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/nf-winnt-rtladdfunctiontable
@DllImport("KERNEL32.dll")
BOOLEAN RtlAddFunctionTable(IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY* FunctionTable, uint EntryCount, size_t BaseAddress);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/nf-winnt-rtldeletefunctiontable
@DllImport("KERNEL32.dll")
BOOLEAN RtlDeleteFunctionTable(IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY* FunctionTable);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/nf-winnt-rtlinstallfunctiontablecallback
@DllImport("KERNEL32.dll")
BOOLEAN RtlInstallFunctionTableCallback(ulong TableIdentifier, ulong BaseAddress, uint Length, 
                                        PGET_RUNTIME_FUNCTION_CALLBACK Callback, void* Context, 
                                        const(PWSTR) OutOfProcessCallbackDll);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("ntdll.dll")
uint RtlAddGrowableFunctionTable(void** DynamicTable, IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY* FunctionTable, 
                                 uint EntryCount, uint MaximumEntryCount, size_t RangeBase, size_t RangeEnd);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/nf-winnt-rtllookupfunctionentry
@DllImport("KERNEL32.dll")
IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY* RtlLookupFunctionEntry(size_t ControlPc, size_t* ImageBase, 
                                                           UNWIND_HISTORY_TABLE* HistoryTable);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/nf-winnt-rtlvirtualunwind
@DllImport("KERNEL32.dll")
EXCEPTION_ROUTINE RtlVirtualUnwind(RTL_VIRTUAL_UNWIND_HANDLER_TYPE HandlerType, size_t ImageBase, size_t ControlPc, 
                                   IMAGE_ARM64_RUNTIME_FUNCTION_ENTRY* FunctionEntry, CONTEXT* ContextRecord, 
                                   void** HandlerData, size_t* EstablisherFrame, 
                                   KNONVOLATILE_CONTEXT_POINTERS* ContextPointers);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL ReadProcessMemory(HANDLE hProcess, const(void)* lpBaseAddress, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpBuffer, 
                       size_t nSize, size_t* lpNumberOfBytesRead);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL WriteProcessMemory(HANDLE hProcess, void* lpBaseAddress, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(void)* lpBuffer, 
                        size_t nSize, size_t* lpNumberOfBytesWritten);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetThreadContext(HANDLE hThread, CONTEXT* lpContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL SetThreadContext(HANDLE hThread, const(CONTEXT)* lpContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL FlushInstructionCache(HANDLE hProcess, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* lpBaseAddress, 
                           size_t dwSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL Wow64GetThreadContext(HANDLE hThread, WOW64_CONTEXT* lpContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL Wow64SetThreadContext(HANDLE hThread, const(WOW64_CONTEXT)* lpContext);


version(X86_64)
{
    @DllImport("KERNEL32.dll")
void RtlCaptureContext2(CONTEXT* ContextRecord);
}
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/nf-winnt-rtladdfunctiontable
@DllImport("KERNEL32.dll")
BOOLEAN RtlAddFunctionTable(IMAGE_RUNTIME_FUNCTION_ENTRY* FunctionTable, uint EntryCount, ulong BaseAddress);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/nf-winnt-rtldeletefunctiontable
@DllImport("KERNEL32.dll")
BOOLEAN RtlDeleteFunctionTable(IMAGE_RUNTIME_FUNCTION_ENTRY* FunctionTable);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/nf-winnt-rtlinstallfunctiontablecallback
@DllImport("KERNEL32.dll")
BOOLEAN RtlInstallFunctionTableCallback(ulong TableIdentifier, ulong BaseAddress, uint Length, 
                                        PGET_RUNTIME_FUNCTION_CALLBACK Callback, void* Context, 
                                        const(PWSTR) OutOfProcessCallbackDll);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("ntdll.dll")
uint RtlAddGrowableFunctionTable(void** DynamicTable, IMAGE_RUNTIME_FUNCTION_ENTRY* FunctionTable, uint EntryCount, 
                                 uint MaximumEntryCount, size_t RangeBase, size_t RangeEnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("ntdll.dll")
void RtlGrowFunctionTable(void* DynamicTable, uint NewEntryCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("ntdll.dll")
void RtlDeleteGrowableFunctionTable(void* DynamicTable);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/nf-winnt-rtllookupfunctionentry
@DllImport("KERNEL32.dll")
IMAGE_RUNTIME_FUNCTION_ENTRY* RtlLookupFunctionEntry(ulong ControlPc, ulong* ImageBase, 
                                                     UNWIND_HISTORY_TABLE* HistoryTable);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/nf-winnt-rtlunwindex
@DllImport("KERNEL32.dll")
void RtlUnwindEx(void* TargetFrame, void* TargetIp, EXCEPTION_RECORD* ExceptionRecord, void* ReturnValue, 
                 CONTEXT* ContextRecord, UNWIND_HISTORY_TABLE* HistoryTable);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/nf-winnt-rtlvirtualunwind
@DllImport("KERNEL32.dll")
EXCEPTION_ROUTINE RtlVirtualUnwind(RTL_VIRTUAL_UNWIND_HANDLER_TYPE HandlerType, ulong ImageBase, ulong ControlPc, 
                                   IMAGE_RUNTIME_FUNCTION_ENTRY* FunctionEntry, CONTEXT* ContextRecord, 
                                   void** HandlerData, ulong* EstablisherFrame, 
                                   KNONVOLATILE_CONTEXT_POINTERS* ContextPointers);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("imagehlp.dll")
IMAGE_NT_HEADERS64* CheckSumMappedFile(void* BaseAddress, uint FileLength, uint* HeaderSum, uint* CheckSum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("imagehlp.dll")
BOOL GetImageConfigInformation(LOADED_IMAGE* LoadedImage, IMAGE_LOAD_CONFIG_DIRECTORY64* ImageConfigInformation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("imagehlp.dll")
BOOL SetImageConfigInformation(LOADED_IMAGE* LoadedImage, IMAGE_LOAD_CONFIG_DIRECTORY64* ImageConfigInformation);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-imagentheader
@DllImport("dbghelp.dll")
IMAGE_NT_HEADERS64* ImageNtHeader(void* Base);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-imagervatosection
@DllImport("dbghelp.dll")
IMAGE_SECTION_HEADER* ImageRvaToSection(IMAGE_NT_HEADERS64* NtHeaders, void* Base, uint Rva);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-imagervatova
@DllImport("dbghelp.dll")
void* ImageRvaToVa(IMAGE_NT_HEADERS64* NtHeaders, void* Base, uint Rva, IMAGE_SECTION_HEADER** LastRvaSection);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
ushort RtlCaptureStackBackTrace(uint FramesToSkip, uint FramesToCapture, void** BackTrace, uint* BackTraceHash);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
void RtlCaptureContext(CONTEXT* ContextRecord);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
void RtlUnwind(void* TargetFrame, void* TargetIp, EXCEPTION_RECORD* ExceptionRecord, void* ReturnValue);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/nf-winnt-rtlrestorecontext
@DllImport("KERNEL32.dll")
void RtlRestoreContext(CONTEXT* ContextRecord, EXCEPTION_RECORD* ExceptionRecord);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rtlsupportapi/nf-rtlsupportapi-rtlraiseexception
@DllImport("KERNEL32.dll")
void RtlRaiseException(EXCEPTION_RECORD* ExceptionRecord);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/nf-winnt-rtlpctofileheader
@DllImport("KERNEL32.dll")
void* RtlPcToFileHeader(void* PcValue, void** BaseOfImage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL IsDebuggerPresent();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
void DebugBreak();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
void OutputDebugStringA(const(PSTR) lpOutputString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
void OutputDebugStringW(const(PWSTR) lpOutputString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL ContinueDebugEvent(uint dwProcessId, uint dwThreadId, NTSTATUS dwContinueStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL WaitForDebugEvent(DEBUG_EVENT* lpDebugEvent, uint dwMilliseconds);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL DebugActiveProcess(uint dwProcessId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL DebugActiveProcessStop(uint dwProcessId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
BOOL CheckRemoteDebuggerPresent(HANDLE hProcess, BOOL* pbDebuggerPresent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("KERNEL32.dll")
BOOL WaitForDebugEventEx(DEBUG_EVENT* lpDebugEvent, uint dwMilliseconds);

@DllImport("KERNEL32.dll")
void* EncodePointer(void* Ptr);

@DllImport("KERNEL32.dll")
void* DecodePointer(void* Ptr);

@DllImport("KERNEL32.dll")
void* EncodeSystemPointer(void* Ptr);

@DllImport("KERNEL32.dll")
void* DecodeSystemPointer(void* Ptr);

@DllImport("api-ms-win-core-util-l1-1-1.dll")
HRESULT EncodeRemotePointer(HANDLE ProcessHandle, void* Ptr, void** EncodedPtr);

@DllImport("api-ms-win-core-util-l1-1-1.dll")
HRESULT DecodeRemotePointer(HANDLE ProcessHandle, void* Ptr, void** DecodedPtr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL Beep(uint dwFreq, uint dwDuration);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
void RaiseException(uint dwExceptionCode, uint dwExceptionFlags, uint nNumberOfArguments, 
                    const(size_t)* lpArguments);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
int UnhandledExceptionFilter(EXCEPTION_POINTERS* ExceptionInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
LPTOP_LEVEL_EXCEPTION_FILTER SetUnhandledExceptionFilter(LPTOP_LEVEL_EXCEPTION_FILTER lpTopLevelExceptionFilter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
uint GetErrorMode();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
THREAD_ERROR_MODE SetErrorMode(THREAD_ERROR_MODE uMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
void* AddVectoredExceptionHandler(uint First, PVECTORED_EXCEPTION_HANDLER Handler);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint RemoveVectoredExceptionHandler(void* Handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
void* AddVectoredContinueHandler(uint First, PVECTORED_EXCEPTION_HANDLER Handler);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("KERNEL32.dll")
uint RemoveVectoredContinueHandler(void* Handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
void RaiseFailFastException(EXCEPTION_RECORD* pExceptionRecord, CONTEXT* pContextRecord, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
void FatalAppExitA(uint uAction, const(PSTR) lpMessageText);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
void FatalAppExitW(uint uAction, const(PWSTR) lpMessageText);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
uint GetThreadErrorMode();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
BOOL SetThreadErrorMode(THREAD_ERROR_MODE dwNewMode, THREAD_ERROR_MODE* lpOldMode);

@DllImport("api-ms-win-core-errorhandling-l1-1-3.dll")
void TerminateProcessOnMemoryExhaustion(size_t FailedAllocationSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
void* OpenThreadWaitChainSession(OPEN_THREAD_WAIT_CHAIN_SESSION_FLAGS Flags, PWAITCHAINCALLBACK callback);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
void CloseThreadWaitChainSession(void* WctHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOL GetThreadWaitChain(void* WctHandle, size_t Context, WAIT_CHAIN_THREAD_OPTIONS Flags, uint ThreadId, 
                        uint* NodeCount, WAITCHAIN_NODE_INFO* NodeInfoArray, BOOL* IsCycle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
void RegisterWaitChainCOMCallback(PCOGETCALLSTATE CallStateCallback, PCOGETACTIVATIONSTATE ActivationStateCallback);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/nf-minidumpapiset-minidumpwritedump
@DllImport("dbghelp.dll")
BOOL MiniDumpWriteDump(HANDLE hProcess, uint ProcessId, HANDLE hFile, MINIDUMP_TYPE DumpType, 
                       MINIDUMP_EXCEPTION_INFORMATION* ExceptionParam, 
                       MINIDUMP_USER_STREAM_INFORMATION* UserStreamParam, 
                       MINIDUMP_CALLBACK_INFORMATION* CallbackParam);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/minidumpapiset/nf-minidumpapiset-minidumpreaddumpstream
@DllImport("dbghelp.dll")
BOOL MiniDumpReadDumpStream(void* BaseOfDump, uint StreamNumber, MINIDUMP_DIRECTORY** Dir, void** StreamPointer, 
                            uint* StreamSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("imagehlp.dll")
BOOL BindImage(const(PSTR) ImageName, const(PSTR) DllPath, const(PSTR) SymbolPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("imagehlp.dll")
BOOL BindImageEx(uint Flags, const(PSTR) ImageName, const(PSTR) DllPath, const(PSTR) SymbolPath, 
                 PIMAGEHLP_STATUS_ROUTINE StatusRoutine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("imagehlp.dll")
BOOL ReBaseImage(const(PSTR) CurrentImageName, const(PSTR) SymbolPath, BOOL fReBase, BOOL fRebaseSysfileOk, 
                 BOOL fGoingDown, uint CheckImageSize, uint* OldImageSize, size_t* OldImageBase, uint* NewImageSize, 
                 size_t* NewImageBase, uint TimeStamp);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("imagehlp.dll")
BOOL ReBaseImage64(const(PSTR) CurrentImageName, const(PSTR) SymbolPath, BOOL fReBase, BOOL fRebaseSysfileOk, 
                   BOOL fGoingDown, uint CheckImageSize, uint* OldImageSize, ulong* OldImageBase, uint* NewImageSize, 
                   ulong* NewImageBase, uint TimeStamp);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("imagehlp.dll")
IMAGE_NT_HEADERS32* CheckSumMappedFile(void* BaseAddress, uint FileLength, uint* HeaderSum, uint* CheckSum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("imagehlp.dll")
uint MapFileAndCheckSumA(const(PSTR) Filename, uint* HeaderSum, uint* CheckSum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("imagehlp.dll")
uint MapFileAndCheckSumW(const(PWSTR) Filename, uint* HeaderSum, uint* CheckSum);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("imagehlp.dll")
BOOL GetImageConfigInformation(LOADED_IMAGE* LoadedImage, IMAGE_LOAD_CONFIG_DIRECTORY32* ImageConfigInformation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("imagehlp.dll")
uint GetImageUnusedHeaderBytes(LOADED_IMAGE* LoadedImage, uint* SizeUnusedHeaderBytes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("imagehlp.dll")
BOOL SetImageConfigInformation(LOADED_IMAGE* LoadedImage, IMAGE_LOAD_CONFIG_DIRECTORY32* ImageConfigInformation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("imagehlp.dll")
BOOL ImageGetDigestStream(HANDLE FileHandle, uint DigestLevel, DIGEST_FUNCTION DigestFunction, void* DigestHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("imagehlp.dll")
BOOL ImageAddCertificate(HANDLE FileHandle, WIN_CERTIFICATE* Certificate, uint* Index);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("imagehlp.dll")
BOOL ImageRemoveCertificate(HANDLE FileHandle, uint Index);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("imagehlp.dll")
BOOL ImageEnumerateCertificates(HANDLE FileHandle, ushort TypeFilter, uint* CertificateCount, uint* Indices, 
                                uint IndexCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("imagehlp.dll")
BOOL ImageGetCertificateData(HANDLE FileHandle, uint CertificateIndex, WIN_CERTIFICATE* Certificate, 
                             uint* RequiredLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("imagehlp.dll")
BOOL ImageGetCertificateHeader(HANDLE FileHandle, uint CertificateIndex, WIN_CERTIFICATE* Certificateheader);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("imagehlp.dll")
LOADED_IMAGE* ImageLoad(const(PSTR) DllName, const(PSTR) DllPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("imagehlp.dll")
BOOL ImageUnload(LOADED_IMAGE* LoadedImage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("imagehlp.dll")
BOOL MapAndLoad(const(PSTR) ImageName, const(PSTR) DllPath, LOADED_IMAGE* LoadedImage, BOOL DotDll, BOOL ReadOnly);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("imagehlp.dll")
BOOL UnMapAndLoad(LOADED_IMAGE* LoadedImage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("imagehlp.dll")
BOOL TouchFileTimes(HANDLE FileHandle, SYSTEMTIME* pSystemTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("imagehlp.dll")
BOOL UpdateDebugInfoFile(const(PSTR) ImageFileName, const(PSTR) SymbolPath, PSTR DebugFilePath, 
                         IMAGE_NT_HEADERS32* NtHeaders);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("imagehlp.dll")
BOOL UpdateDebugInfoFileEx(const(PSTR) ImageFileName, const(PSTR) SymbolPath, PSTR DebugFilePath, 
                           IMAGE_NT_HEADERS32* NtHeaders, uint OldCheckSum);

@DllImport("dbghelp.dll")
HANDLE SymFindDebugInfoFile(HANDLE hProcess, const(PSTR) FileName, PSTR DebugFilePath, 
                            PFIND_DEBUG_FILE_CALLBACK Callback, void* CallerData);

@DllImport("dbghelp.dll")
HANDLE SymFindDebugInfoFileW(HANDLE hProcess, const(PWSTR) FileName, PWSTR DebugFilePath, 
                             PFIND_DEBUG_FILE_CALLBACKW Callback, void* CallerData);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-finddebuginfofile
@DllImport("dbghelp.dll")
HANDLE FindDebugInfoFile(const(PSTR) FileName, const(PSTR) SymbolPath, PSTR DebugFilePath);

@DllImport("dbghelp.dll")
HANDLE FindDebugInfoFileEx(const(PSTR) FileName, const(PSTR) SymbolPath, PSTR DebugFilePath, 
                           PFIND_DEBUG_FILE_CALLBACK Callback, void* CallerData);

@DllImport("dbghelp.dll")
HANDLE FindDebugInfoFileExW(const(PWSTR) FileName, const(PWSTR) SymbolPath, PWSTR DebugFilePath, 
                            PFIND_DEBUG_FILE_CALLBACKW Callback, void* CallerData);

@DllImport("dbghelp.dll")
BOOL SymFindFileInPath(HANDLE hprocess, const(PSTR) SearchPathA, const(PSTR) FileName, void* id, uint two, 
                       uint three, SYM_FIND_ID_OPTION flags, PSTR FoundFile, PFINDFILEINPATHCALLBACK callback, 
                       void* context);

@DllImport("dbghelp.dll")
BOOL SymFindFileInPathW(HANDLE hprocess, const(PWSTR) SearchPathA, const(PWSTR) FileName, void* id, uint two, 
                        uint three, SYM_FIND_ID_OPTION flags, PWSTR FoundFile, PFINDFILEINPATHCALLBACKW callback, 
                        void* context);

@DllImport("dbghelp.dll")
HANDLE SymFindExecutableImage(HANDLE hProcess, const(PSTR) FileName, PSTR ImageFilePath, 
                              PFIND_EXE_FILE_CALLBACK Callback, void* CallerData);

@DllImport("dbghelp.dll")
HANDLE SymFindExecutableImageW(HANDLE hProcess, const(PWSTR) FileName, PWSTR ImageFilePath, 
                               PFIND_EXE_FILE_CALLBACKW Callback, void* CallerData);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-findexecutableimage
@DllImport("dbghelp.dll")
HANDLE FindExecutableImage(const(PSTR) FileName, const(PSTR) SymbolPath, PSTR ImageFilePath);

@DllImport("dbghelp.dll")
HANDLE FindExecutableImageEx(const(PSTR) FileName, const(PSTR) SymbolPath, PSTR ImageFilePath, 
                             PFIND_EXE_FILE_CALLBACK Callback, void* CallerData);

@DllImport("dbghelp.dll")
HANDLE FindExecutableImageExW(const(PWSTR) FileName, const(PWSTR) SymbolPath, PWSTR ImageFilePath, 
                              PFIND_EXE_FILE_CALLBACKW Callback, void* CallerData);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-imagentheader
@DllImport("dbghelp.dll")
IMAGE_NT_HEADERS32* ImageNtHeader(void* Base);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-imagedirectoryentrytodataex
@DllImport("dbghelp.dll")
void* ImageDirectoryEntryToDataEx(void* Base, BOOLEAN MappedAsImage, IMAGE_DIRECTORY_ENTRY DirectoryEntry, 
                                  uint* Size, IMAGE_SECTION_HEADER** FoundHeader);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-imagedirectoryentrytodata
@DllImport("dbghelp.dll")
void* ImageDirectoryEntryToData(void* Base, BOOLEAN MappedAsImage, IMAGE_DIRECTORY_ENTRY DirectoryEntry, 
                                uint* Size);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-imagervatosection
@DllImport("dbghelp.dll")
IMAGE_SECTION_HEADER* ImageRvaToSection(IMAGE_NT_HEADERS32* NtHeaders, void* Base, uint Rva);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-imagervatova
@DllImport("dbghelp.dll")
void* ImageRvaToVa(IMAGE_NT_HEADERS32* NtHeaders, void* Base, uint Rva, IMAGE_SECTION_HEADER** LastRvaSection);

@DllImport("dbghelp.dll")
BOOL SearchTreeForFile(const(PSTR) RootPath, const(PSTR) InputPathName, PSTR OutputPathBuffer);

@DllImport("dbghelp.dll")
BOOL SearchTreeForFileW(const(PWSTR) RootPath, const(PWSTR) InputPathName, PWSTR OutputPathBuffer);

@DllImport("dbghelp.dll")
BOOL EnumDirTree(HANDLE hProcess, const(PSTR) RootPath, const(PSTR) InputPathName, PSTR OutputPathBuffer, 
                 PENUMDIRTREE_CALLBACK cb, void* data);

@DllImport("dbghelp.dll")
BOOL EnumDirTreeW(HANDLE hProcess, const(PWSTR) RootPath, const(PWSTR) InputPathName, PWSTR OutputPathBuffer, 
                  PENUMDIRTREE_CALLBACKW cb, void* data);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-makesuredirectorypathexists
@DllImport("dbghelp.dll")
BOOL MakeSureDirectoryPathExists(const(PSTR) DirPath);

@DllImport("dbghelp.dll")
uint UnDecorateSymbolName(const(PSTR) name, PSTR outputString, uint maxStringLength, uint flags);

@DllImport("dbghelp.dll")
uint UnDecorateSymbolNameW(const(PWSTR) name, PWSTR outputString, uint maxStringLength, uint flags);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-stackwalk64
@DllImport("dbghelp.dll")
BOOL StackWalk64(uint MachineType, HANDLE hProcess, HANDLE hThread, STACKFRAME64* StackFrame, void* ContextRecord, 
                 PREAD_PROCESS_MEMORY_ROUTINE64 ReadMemoryRoutine, 
                 PFUNCTION_TABLE_ACCESS_ROUTINE64 FunctionTableAccessRoutine, 
                 PGET_MODULE_BASE_ROUTINE64 GetModuleBaseRoutine, PTRANSLATE_ADDRESS_ROUTINE64 TranslateAddress);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-stackwalkex
@DllImport("dbghelp.dll")
BOOL StackWalkEx(uint MachineType, HANDLE hProcess, HANDLE hThread, STACKFRAME_EX* StackFrame, void* ContextRecord, 
                 PREAD_PROCESS_MEMORY_ROUTINE64 ReadMemoryRoutine, 
                 PFUNCTION_TABLE_ACCESS_ROUTINE64 FunctionTableAccessRoutine, 
                 PGET_MODULE_BASE_ROUTINE64 GetModuleBaseRoutine, PTRANSLATE_ADDRESS_ROUTINE64 TranslateAddress, 
                 uint Flags);

@DllImport("dbghelp.dll")
BOOL StackWalk2(uint MachineType, HANDLE hProcess, HANDLE hThread, STACKFRAME_EX* StackFrame, void* ContextRecord, 
                PREAD_PROCESS_MEMORY_ROUTINE64 ReadMemoryRoutine, 
                PFUNCTION_TABLE_ACCESS_ROUTINE64 FunctionTableAccessRoutine, 
                PGET_MODULE_BASE_ROUTINE64 GetModuleBaseRoutine, PTRANSLATE_ADDRESS_ROUTINE64 TranslateAddress, 
                PGET_TARGET_ATTRIBUTE_VALUE64 GetTargetAttributeValue, uint Flags);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-imagehlpapiversion
@DllImport("dbghelp.dll")
API_VERSION* ImagehlpApiVersion();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-imagehlpapiversionex
@DllImport("dbghelp.dll")
API_VERSION* ImagehlpApiVersionEx(API_VERSION* AppVersion);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-gettimestampforloadedlibrary
@DllImport("dbghelp.dll")
uint GetTimestampForLoadedLibrary(HMODULE Module);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symsetparentwindow
@DllImport("dbghelp.dll")
BOOL SymSetParentWindow(HWND hwnd);

@DllImport("dbghelp.dll")
BOOL SymGetParentWindow(HWND* pHwnd);

@DllImport("dbghelp.dll")
PSTR SymSetHomeDirectory(HANDLE hProcess, const(PSTR) dir);

@DllImport("dbghelp.dll")
PWSTR SymSetHomeDirectoryW(HANDLE hProcess, const(PWSTR) dir);

@DllImport("dbghelp.dll")
PSTR SymGetHomeDirectory(/*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(IMAGEHLP_HD_TYPE))], [])*/uint type, 
                         PSTR dir, size_t size);

@DllImport("dbghelp.dll")
PWSTR SymGetHomeDirectoryW(/*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(IMAGEHLP_HD_TYPE))], [])*/uint type, 
                           PWSTR dir, size_t size);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symgetomaps
@DllImport("dbghelp.dll")
BOOL SymGetOmaps(HANDLE hProcess, ulong BaseOfDll, OMAP** OmapTo, ulong* cOmapTo, OMAP** OmapFrom, 
                 ulong* cOmapFrom);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symsetoptions
@DllImport("dbghelp.dll")
uint SymSetOptions(uint SymOptions);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symgetoptions
@DllImport("dbghelp.dll")
uint SymGetOptions();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symcleanup
@DllImport("dbghelp.dll")
BOOL SymCleanup(HANDLE hProcess);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symgetextendedoption
@DllImport("dbghelp.dll")
BOOL SymGetExtendedOption(IMAGEHLP_EXTENDED_OPTIONS option);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symsetextendedoption
@DllImport("dbghelp.dll")
BOOL SymSetExtendedOption(IMAGEHLP_EXTENDED_OPTIONS option, BOOL value);

@DllImport("dbghelp.dll")
BOOL SymMatchString(const(PSTR) string, const(PSTR) expression, BOOL fCase);

@DllImport("dbghelp.dll")
BOOL SymMatchStringA(const(PSTR) string, const(PSTR) expression, BOOL fCase);

@DllImport("dbghelp.dll")
BOOL SymMatchStringW(const(PWSTR) string, const(PWSTR) expression, BOOL fCase);

@DllImport("dbghelp.dll")
BOOL SymEnumSourceFiles(HANDLE hProcess, ulong ModBase, const(PSTR) Mask, PSYM_ENUMSOURCEFILES_CALLBACK cbSrcFiles, 
                        void* UserContext);

@DllImport("dbghelp.dll")
BOOL SymEnumSourceFilesW(HANDLE hProcess, ulong ModBase, const(PWSTR) Mask, 
                         PSYM_ENUMSOURCEFILES_CALLBACKW cbSrcFiles, void* UserContext);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symenumeratemodules64
@DllImport("dbghelp.dll")
BOOL SymEnumerateModules64(HANDLE hProcess, PSYM_ENUMMODULES_CALLBACK64 EnumModulesCallback, void* UserContext);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symenumeratemodulesw64
@DllImport("dbghelp.dll")
BOOL SymEnumerateModulesW64(HANDLE hProcess, PSYM_ENUMMODULES_CALLBACKW64 EnumModulesCallback, void* UserContext);

@DllImport("dbghelp.dll")
BOOL EnumerateLoadedModulesEx(HANDLE hProcess, PENUMLOADED_MODULES_CALLBACK64 EnumLoadedModulesCallback, 
                              void* UserContext);

@DllImport("dbghelp.dll")
BOOL EnumerateLoadedModulesExW(HANDLE hProcess, PENUMLOADED_MODULES_CALLBACKW64 EnumLoadedModulesCallback, 
                               void* UserContext);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-enumerateloadedmodules64
@DllImport("dbghelp.dll")
BOOL EnumerateLoadedModules64(HANDLE hProcess, PENUMLOADED_MODULES_CALLBACK64 EnumLoadedModulesCallback, 
                              void* UserContext);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-enumerateloadedmodulesw64
@DllImport("dbghelp.dll")
BOOL EnumerateLoadedModulesW64(HANDLE hProcess, PENUMLOADED_MODULES_CALLBACKW64 EnumLoadedModulesCallback, 
                               void* UserContext);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symfunctiontableaccess64
@DllImport("dbghelp.dll")
void* SymFunctionTableAccess64(HANDLE hProcess, ulong AddrBase);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symfunctiontableaccess64accessroutines
@DllImport("dbghelp.dll")
void* SymFunctionTableAccess64AccessRoutines(HANDLE hProcess, ulong AddrBase, 
                                             PREAD_PROCESS_MEMORY_ROUTINE64 ReadMemoryRoutine, 
                                             PGET_MODULE_BASE_ROUTINE64 GetModuleBaseRoutine);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symfunctiontableaccess
@DllImport("dbghelp.dll")
void* SymFunctionTableAccess(HANDLE hProcess, uint AddrBase);

@DllImport("dbghelp.dll")
BOOL SymGetUnwindInfo(HANDLE hProcess, ulong Address, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                      uint* Size);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symgetmoduleinfo64
@DllImport("dbghelp.dll")
BOOL SymGetModuleInfo64(HANDLE hProcess, ulong qwAddr, IMAGEHLP_MODULE64* ModuleInfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symgetmoduleinfow64
@DllImport("dbghelp.dll")
BOOL SymGetModuleInfoW64(HANDLE hProcess, ulong qwAddr, IMAGEHLP_MODULEW64* ModuleInfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symgetmodulebase64
@DllImport("dbghelp.dll")
ulong SymGetModuleBase64(HANDLE hProcess, ulong qwAddr);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symgetmodulebase
@DllImport("dbghelp.dll")
uint SymGetModuleBase(HANDLE hProcess, uint dwAddr);

@DllImport("dbghelp.dll")
BOOL SymEnumLines(HANDLE hProcess, ulong Base, const(PSTR) Obj, const(PSTR) File, 
                  PSYM_ENUMLINES_CALLBACK EnumLinesCallback, void* UserContext);

@DllImport("dbghelp.dll")
BOOL SymEnumLinesW(HANDLE hProcess, ulong Base, const(PWSTR) Obj, const(PWSTR) File, 
                   PSYM_ENUMLINES_CALLBACKW EnumLinesCallback, void* UserContext);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symgetlinefromaddr64
@DllImport("dbghelp.dll")
BOOL SymGetLineFromAddr64(HANDLE hProcess, ulong qwAddr, uint* pdwDisplacement, IMAGEHLP_LINE64* Line64);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symgetlinefromaddrw64
@DllImport("dbghelp.dll")
BOOL SymGetLineFromAddrW64(HANDLE hProcess, ulong dwAddr, uint* pdwDisplacement, IMAGEHLP_LINEW64* Line);

@DllImport("dbghelp.dll")
BOOL SymGetLineFromInlineContext(HANDLE hProcess, ulong qwAddr, uint InlineContext, ulong qwModuleBaseAddress, 
                                 uint* pdwDisplacement, IMAGEHLP_LINE64* Line64);

@DllImport("dbghelp.dll")
BOOL SymGetLineFromInlineContextW(HANDLE hProcess, ulong dwAddr, uint InlineContext, ulong qwModuleBaseAddress, 
                                  uint* pdwDisplacement, IMAGEHLP_LINEW64* Line);

@DllImport("dbghelp.dll")
BOOL SymEnumSourceLines(HANDLE hProcess, ulong Base, const(PSTR) Obj, const(PSTR) File, uint Line, uint Flags, 
                        PSYM_ENUMLINES_CALLBACK EnumLinesCallback, void* UserContext);

@DllImport("dbghelp.dll")
BOOL SymEnumSourceLinesW(HANDLE hProcess, ulong Base, const(PWSTR) Obj, const(PWSTR) File, uint Line, uint Flags, 
                         PSYM_ENUMLINES_CALLBACKW EnumLinesCallback, void* UserContext);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symaddrincludeinlinetrace
@DllImport("dbghelp.dll")
uint SymAddrIncludeInlineTrace(HANDLE hProcess, ulong Address);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symcompareinlinetrace
@DllImport("dbghelp.dll")
uint SymCompareInlineTrace(HANDLE hProcess, ulong Address1, uint InlineContext1, ulong RetAddress1, ulong Address2, 
                           ulong RetAddress2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symqueryinlinetrace
@DllImport("dbghelp.dll")
BOOL SymQueryInlineTrace(HANDLE hProcess, ulong StartAddress, uint StartContext, ulong StartRetAddress, 
                         ulong CurAddress, uint* CurContext, uint* CurFrameIndex);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symgetlinefromname64
@DllImport("dbghelp.dll")
BOOL SymGetLineFromName64(HANDLE hProcess, const(PSTR) ModuleName, const(PSTR) FileName, uint dwLineNumber, 
                          int* plDisplacement, IMAGEHLP_LINE64* Line);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symgetlinefromnamew64
@DllImport("dbghelp.dll")
BOOL SymGetLineFromNameW64(HANDLE hProcess, const(PWSTR) ModuleName, const(PWSTR) FileName, uint dwLineNumber, 
                           int* plDisplacement, IMAGEHLP_LINEW64* Line);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symgetlinenext64
@DllImport("dbghelp.dll")
BOOL SymGetLineNext64(HANDLE hProcess, IMAGEHLP_LINE64* Line);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symgetlinenextw64
@DllImport("dbghelp.dll")
BOOL SymGetLineNextW64(HANDLE hProcess, IMAGEHLP_LINEW64* Line);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symgetlineprev64
@DllImport("dbghelp.dll")
BOOL SymGetLinePrev64(HANDLE hProcess, IMAGEHLP_LINE64* Line);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symgetlineprevw64
@DllImport("dbghelp.dll")
BOOL SymGetLinePrevW64(HANDLE hProcess, IMAGEHLP_LINEW64* Line);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symgetfilelineoffsets64
@DllImport("dbghelp.dll")
uint SymGetFileLineOffsets64(HANDLE hProcess, const(PSTR) ModuleName, const(PSTR) FileName, ulong* Buffer, 
                             uint BufferLines);

@DllImport("dbghelp.dll")
BOOL SymMatchFileName(const(PSTR) FileName, const(PSTR) Match, PSTR* FileNameStop, PSTR* MatchStop);

@DllImport("dbghelp.dll")
BOOL SymMatchFileNameW(const(PWSTR) FileName, const(PWSTR) Match, PWSTR* FileNameStop, PWSTR* MatchStop);

@DllImport("dbghelp.dll")
BOOL SymGetSourceFile(HANDLE hProcess, ulong Base, const(PSTR) Params, const(PSTR) FileSpec, PSTR FilePath, 
                      uint Size);

@DllImport("dbghelp.dll")
BOOL SymGetSourceFileW(HANDLE hProcess, ulong Base, const(PWSTR) Params, const(PWSTR) FileSpec, PWSTR FilePath, 
                       uint Size);

@DllImport("dbghelp.dll")
BOOL SymGetSourceFileToken(HANDLE hProcess, ulong Base, const(PSTR) FileSpec, void** Token, uint* Size);

@DllImport("dbghelp.dll")
BOOL SymGetSourceFileTokenByTokenName(HANDLE hProcess, ulong Base, const(PSTR) FileSpec, const(PSTR) TokenName, 
                                      const(PSTR) TokenParameters, void** Token, uint* Size);

@DllImport("dbghelp.dll")
BOOL SymGetSourceFileChecksumW(HANDLE hProcess, ulong Base, const(PWSTR) FileSpec, uint* pCheckSumType, 
                               ubyte* pChecksum, uint checksumSize, uint* pActualBytesWritten);

@DllImport("dbghelp.dll")
BOOL SymGetSourceFileChecksum(HANDLE hProcess, ulong Base, const(PSTR) FileSpec, uint* pCheckSumType, 
                              ubyte* pChecksum, uint checksumSize, uint* pActualBytesWritten);

@DllImport("dbghelp.dll")
BOOL SymGetSourceFileTokenW(HANDLE hProcess, ulong Base, const(PWSTR) FileSpec, void** Token, uint* Size);

@DllImport("dbghelp.dll")
BOOL SymGetSourceFileTokenByTokenNameW(HANDLE hProcess, ulong Base, const(PWSTR) FileSpec, const(PWSTR) TokenName, 
                                       const(PWSTR) TokenParameters, void** Token, uint* Size);

@DllImport("dbghelp.dll")
BOOL SymGetSourceFileFromToken(HANDLE hProcess, void* Token, const(PSTR) Params, PSTR FilePath, uint Size);

@DllImport("dbghelp.dll")
BOOL SymGetSourceFileFromTokenByTokenName(HANDLE hProcess, void* Token, const(PSTR) TokenName, const(PSTR) Params, 
                                          PSTR FilePath, uint Size);

@DllImport("dbghelp.dll")
BOOL SymGetSourceFileFromTokenW(HANDLE hProcess, void* Token, const(PWSTR) Params, PWSTR FilePath, uint Size);

@DllImport("dbghelp.dll")
BOOL SymGetSourceFileFromTokenByTokenNameW(HANDLE hProcess, void* Token, const(PWSTR) TokenName, 
                                           const(PWSTR) Params, PWSTR FilePath, uint Size);

@DllImport("dbghelp.dll")
BOOL SymGetSourceVarFromToken(HANDLE hProcess, void* Token, const(PSTR) Params, const(PSTR) VarName, PSTR Value, 
                              uint Size);

@DllImport("dbghelp.dll")
BOOL SymGetSourceVarFromTokenW(HANDLE hProcess, void* Token, const(PWSTR) Params, const(PWSTR) VarName, 
                               PWSTR Value, uint Size);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symenumsourcefiletokens
@DllImport("dbghelp.dll")
BOOL SymEnumSourceFileTokens(HANDLE hProcess, ulong Base, PENUMSOURCEFILETOKENSCALLBACK Callback);

@DllImport("dbghelp.dll")
BOOL SymInitialize(HANDLE hProcess, const(PSTR) UserSearchPath, BOOL fInvadeProcess);

@DllImport("dbghelp.dll")
BOOL SymInitializeW(HANDLE hProcess, const(PWSTR) UserSearchPath, BOOL fInvadeProcess);

@DllImport("dbghelp.dll")
BOOL SymGetSearchPath(HANDLE hProcess, PSTR SearchPathA, uint SearchPathLength);

@DllImport("dbghelp.dll")
BOOL SymGetSearchPathW(HANDLE hProcess, PWSTR SearchPathA, uint SearchPathLength);

@DllImport("dbghelp.dll")
BOOL SymSetSearchPath(HANDLE hProcess, const(PSTR) SearchPathA);

@DllImport("dbghelp.dll")
BOOL SymSetSearchPathW(HANDLE hProcess, const(PWSTR) SearchPathA);

@DllImport("dbghelp.dll")
ulong SymLoadModuleEx(HANDLE hProcess, HANDLE hFile, const(PSTR) ImageName, const(PSTR) ModuleName, 
                      ulong BaseOfDll, uint DllSize, MODLOAD_DATA* Data, SYM_LOAD_FLAGS Flags);

@DllImport("dbghelp.dll")
ulong SymLoadModuleExW(HANDLE hProcess, HANDLE hFile, const(PWSTR) ImageName, const(PWSTR) ModuleName, 
                       ulong BaseOfDll, uint DllSize, MODLOAD_DATA* Data, SYM_LOAD_FLAGS Flags);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symunloadmodule64
@DllImport("dbghelp.dll")
BOOL SymUnloadModule64(HANDLE hProcess, ulong BaseOfDll);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symunloadmodule
@DllImport("dbghelp.dll")
BOOL SymUnloadModule(HANDLE hProcess, uint BaseOfDll);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symundname64
@DllImport("dbghelp.dll")
BOOL SymUnDName64(IMAGEHLP_SYMBOL64* sym, PSTR UnDecName, uint UnDecNameLength);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symregistercallback64
@DllImport("dbghelp.dll")
BOOL SymRegisterCallback64(HANDLE hProcess, PSYMBOL_REGISTERED_CALLBACK64 CallbackFunction, ulong UserContext);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symregistercallbackw64
@DllImport("dbghelp.dll")
BOOL SymRegisterCallbackW64(HANDLE hProcess, PSYMBOL_REGISTERED_CALLBACK64 CallbackFunction, ulong UserContext);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symregisterfunctionentrycallback64
@DllImport("dbghelp.dll")
BOOL SymRegisterFunctionEntryCallback64(HANDLE hProcess, PSYMBOL_FUNCENTRY_CALLBACK64 CallbackFunction, 
                                        ulong UserContext);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symregisterfunctionentrycallback
@DllImport("dbghelp.dll")
BOOL SymRegisterFunctionEntryCallback(HANDLE hProcess, PSYMBOL_FUNCENTRY_CALLBACK CallbackFunction, 
                                      void* UserContext);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symsetcontext
@DllImport("dbghelp.dll")
BOOL SymSetContext(HANDLE hProcess, IMAGEHLP_STACK_FRAME* StackFrame, void* Context);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symsetscopefromaddr
@DllImport("dbghelp.dll")
BOOL SymSetScopeFromAddr(HANDLE hProcess, ulong Address);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symsetscopefrominlinecontext
@DllImport("dbghelp.dll")
BOOL SymSetScopeFromInlineContext(HANDLE hProcess, ulong Address, uint InlineContext);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symsetscopefromindex
@DllImport("dbghelp.dll")
BOOL SymSetScopeFromIndex(HANDLE hProcess, ulong BaseOfDll, uint Index);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symenumprocesses
@DllImport("dbghelp.dll")
BOOL SymEnumProcesses(PSYM_ENUMPROCESSES_CALLBACK EnumProcessesCallback, void* UserContext);

@DllImport("dbghelp.dll")
BOOL SymFromAddr(HANDLE hProcess, ulong Address, ulong* Displacement, SYMBOL_INFO* Symbol);

@DllImport("dbghelp.dll")
BOOL SymFromAddrW(HANDLE hProcess, ulong Address, ulong* Displacement, SYMBOL_INFOW* Symbol);

@DllImport("dbghelp.dll")
BOOL SymFromInlineContext(HANDLE hProcess, ulong Address, uint InlineContext, ulong* Displacement, 
                          SYMBOL_INFO* Symbol);

@DllImport("dbghelp.dll")
BOOL SymFromInlineContextW(HANDLE hProcess, ulong Address, uint InlineContext, ulong* Displacement, 
                           SYMBOL_INFOW* Symbol);

@DllImport("dbghelp.dll")
BOOL SymFromToken(HANDLE hProcess, ulong Base, uint Token, SYMBOL_INFO* Symbol);

@DllImport("dbghelp.dll")
BOOL SymFromTokenW(HANDLE hProcess, ulong Base, uint Token, SYMBOL_INFOW* Symbol);

@DllImport("dbghelp.dll")
BOOL SymNext(HANDLE hProcess, SYMBOL_INFO* si);

@DllImport("dbghelp.dll")
BOOL SymNextW(HANDLE hProcess, SYMBOL_INFOW* siw);

@DllImport("dbghelp.dll")
BOOL SymPrev(HANDLE hProcess, SYMBOL_INFO* si);

@DllImport("dbghelp.dll")
BOOL SymPrevW(HANDLE hProcess, SYMBOL_INFOW* siw);

@DllImport("dbghelp.dll")
BOOL SymFromName(HANDLE hProcess, const(PSTR) Name, SYMBOL_INFO* Symbol);

@DllImport("dbghelp.dll")
BOOL SymFromNameW(HANDLE hProcess, const(PWSTR) Name, SYMBOL_INFOW* Symbol);

@DllImport("dbghelp.dll")
BOOL SymEnumSymbols(HANDLE hProcess, ulong BaseOfDll, const(PSTR) Mask, 
                    PSYM_ENUMERATESYMBOLS_CALLBACK EnumSymbolsCallback, void* UserContext);

@DllImport("dbghelp.dll")
BOOL SymEnumSymbolsEx(HANDLE hProcess, ulong BaseOfDll, const(PSTR) Mask, 
                      PSYM_ENUMERATESYMBOLS_CALLBACK EnumSymbolsCallback, void* UserContext, uint Options);

@DllImport("dbghelp.dll")
BOOL SymEnumSymbolsW(HANDLE hProcess, ulong BaseOfDll, const(PWSTR) Mask, 
                     PSYM_ENUMERATESYMBOLS_CALLBACKW EnumSymbolsCallback, void* UserContext);

@DllImport("dbghelp.dll")
BOOL SymEnumSymbolsExW(HANDLE hProcess, ulong BaseOfDll, const(PWSTR) Mask, 
                       PSYM_ENUMERATESYMBOLS_CALLBACKW EnumSymbolsCallback, void* UserContext, uint Options);

@DllImport("dbghelp.dll")
BOOL SymEnumSymbolsForAddr(HANDLE hProcess, ulong Address, PSYM_ENUMERATESYMBOLS_CALLBACK EnumSymbolsCallback, 
                           void* UserContext);

@DllImport("dbghelp.dll")
BOOL SymEnumSymbolsForAddrW(HANDLE hProcess, ulong Address, PSYM_ENUMERATESYMBOLS_CALLBACKW EnumSymbolsCallback, 
                            void* UserContext);

@DllImport("dbghelp.dll")
BOOL SymSearch(HANDLE hProcess, ulong BaseOfDll, uint Index, uint SymTag, const(PSTR) Mask, ulong Address, 
               PSYM_ENUMERATESYMBOLS_CALLBACK EnumSymbolsCallback, void* UserContext, uint Options);

@DllImport("dbghelp.dll")
BOOL SymSearchW(HANDLE hProcess, ulong BaseOfDll, uint Index, uint SymTag, const(PWSTR) Mask, ulong Address, 
                PSYM_ENUMERATESYMBOLS_CALLBACKW EnumSymbolsCallback, void* UserContext, uint Options);

@DllImport("dbghelp.dll")
BOOL SymGetScope(HANDLE hProcess, ulong BaseOfDll, uint Index, SYMBOL_INFO* Symbol);

@DllImport("dbghelp.dll")
BOOL SymGetScopeW(HANDLE hProcess, ulong BaseOfDll, uint Index, SYMBOL_INFOW* Symbol);

@DllImport("dbghelp.dll")
BOOL SymFromIndex(HANDLE hProcess, ulong BaseOfDll, uint Index, SYMBOL_INFO* Symbol);

@DllImport("dbghelp.dll")
BOOL SymFromIndexW(HANDLE hProcess, ulong BaseOfDll, uint Index, SYMBOL_INFOW* Symbol);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symgettypeinfo
@DllImport("dbghelp.dll")
BOOL SymGetTypeInfo(HANDLE hProcess, ulong ModBase, uint TypeId, IMAGEHLP_SYMBOL_TYPE_INFO GetType, void* pInfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symgettypeinfoex
@DllImport("dbghelp.dll")
BOOL SymGetTypeInfoEx(HANDLE hProcess, ulong ModBase, IMAGEHLP_GET_TYPE_INFO_PARAMS* Params);

@DllImport("dbghelp.dll")
BOOL SymEnumTypes(HANDLE hProcess, ulong BaseOfDll, PSYM_ENUMERATESYMBOLS_CALLBACK EnumSymbolsCallback, 
                  void* UserContext);

@DllImport("dbghelp.dll")
BOOL SymEnumTypesW(HANDLE hProcess, ulong BaseOfDll, PSYM_ENUMERATESYMBOLS_CALLBACKW EnumSymbolsCallback, 
                   void* UserContext);

@DllImport("dbghelp.dll")
BOOL SymEnumTypesByName(HANDLE hProcess, ulong BaseOfDll, const(PSTR) mask, 
                        PSYM_ENUMERATESYMBOLS_CALLBACK EnumSymbolsCallback, void* UserContext);

@DllImport("dbghelp.dll")
BOOL SymEnumTypesByNameW(HANDLE hProcess, ulong BaseOfDll, const(PWSTR) mask, 
                         PSYM_ENUMERATESYMBOLS_CALLBACKW EnumSymbolsCallback, void* UserContext);

@DllImport("dbghelp.dll")
BOOL SymGetTypeFromName(HANDLE hProcess, ulong BaseOfDll, const(PSTR) Name, SYMBOL_INFO* Symbol);

@DllImport("dbghelp.dll")
BOOL SymGetTypeFromNameW(HANDLE hProcess, ulong BaseOfDll, const(PWSTR) Name, SYMBOL_INFOW* Symbol);

@DllImport("dbghelp.dll")
BOOL SymAddSymbol(HANDLE hProcess, ulong BaseOfDll, const(PSTR) Name, ulong Address, uint Size, uint Flags);

@DllImport("dbghelp.dll")
BOOL SymAddSymbolW(HANDLE hProcess, ulong BaseOfDll, const(PWSTR) Name, ulong Address, uint Size, uint Flags);

@DllImport("dbghelp.dll")
BOOL SymDeleteSymbol(HANDLE hProcess, ulong BaseOfDll, const(PSTR) Name, ulong Address, uint Flags);

@DllImport("dbghelp.dll")
BOOL SymDeleteSymbolW(HANDLE hProcess, ulong BaseOfDll, const(PWSTR) Name, ulong Address, uint Flags);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symrefreshmodulelist
@DllImport("dbghelp.dll")
BOOL SymRefreshModuleList(HANDLE hProcess);

@DllImport("dbghelp.dll")
BOOL SymAddSourceStream(HANDLE hProcess, ulong Base, const(PSTR) StreamFile, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* Buffer, 
                        size_t Size);

@DllImport("dbghelp.dll")
BOOL SymAddSourceStreamA(HANDLE hProcess, ulong Base, const(PSTR) StreamFile, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* Buffer, 
                         size_t Size);

@DllImport("dbghelp.dll")
BOOL SymAddSourceStreamW(HANDLE hProcess, ulong Base, const(PWSTR) FileSpec, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* Buffer, 
                         size_t Size);

@DllImport("dbghelp.dll")
BOOL SymSrvIsStoreW(HANDLE hProcess, const(PWSTR) path);

@DllImport("dbghelp.dll")
BOOL SymSrvIsStore(HANDLE hProcess, const(PSTR) path);

@DllImport("dbghelp.dll")
PSTR SymSrvDeltaName(HANDLE hProcess, const(PSTR) SymPath, const(PSTR) Type, const(PSTR) File1, const(PSTR) File2);

@DllImport("dbghelp.dll")
PWSTR SymSrvDeltaNameW(HANDLE hProcess, const(PWSTR) SymPath, const(PWSTR) Type, const(PWSTR) File1, 
                       const(PWSTR) File2);

@DllImport("dbghelp.dll")
PSTR SymSrvGetSupplement(HANDLE hProcess, const(PSTR) SymPath, const(PSTR) Node, const(PSTR) File);

@DllImport("dbghelp.dll")
PWSTR SymSrvGetSupplementW(HANDLE hProcess, const(PWSTR) SymPath, const(PWSTR) Node, const(PWSTR) File);

@DllImport("dbghelp.dll")
BOOL SymSrvGetFileIndexes(const(PSTR) File, GUID* Id, uint* Val1, uint* Val2, uint Flags);

@DllImport("dbghelp.dll")
BOOL SymSrvGetFileIndexesW(const(PWSTR) File, GUID* Id, uint* Val1, uint* Val2, uint Flags);

@DllImport("dbghelp.dll")
BOOL SymSrvGetFileIndexStringW(HANDLE hProcess, const(PWSTR) SrvPath, const(PWSTR) File, PWSTR Index, size_t Size, 
                               uint Flags);

@DllImport("dbghelp.dll")
BOOL SymSrvGetFileIndexString(HANDLE hProcess, const(PSTR) SrvPath, const(PSTR) File, PSTR Index, size_t Size, 
                              uint Flags);

@DllImport("dbghelp.dll")
BOOL SymSrvGetFileIndexInfo(const(PSTR) File, SYMSRV_INDEX_INFO* Info, uint Flags);

@DllImport("dbghelp.dll")
BOOL SymSrvGetFileIndexInfoW(const(PWSTR) File, SYMSRV_INDEX_INFOW* Info, uint Flags);

@DllImport("dbghelp.dll")
PSTR SymSrvStoreSupplement(HANDLE hProcess, const(PSTR) SrvPath, const(PSTR) Node, const(PSTR) File, uint Flags);

@DllImport("dbghelp.dll")
PWSTR SymSrvStoreSupplementW(HANDLE hProcess, const(PWSTR) SymPath, const(PWSTR) Node, const(PWSTR) File, 
                             uint Flags);

@DllImport("dbghelp.dll")
PSTR SymSrvStoreFile(HANDLE hProcess, const(PSTR) SrvPath, const(PSTR) File, SYM_SRV_STORE_FILE_FLAGS Flags);

@DllImport("dbghelp.dll")
PWSTR SymSrvStoreFileW(HANDLE hProcess, const(PWSTR) SrvPath, const(PWSTR) File, SYM_SRV_STORE_FILE_FLAGS Flags);

@DllImport("dbghelp.dll")
BOOL SymGetSymbolFile(HANDLE hProcess, const(PSTR) SymPath, const(PSTR) ImageFile, 
                      /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(IMAGEHLP_SF_TYPE))], [])*/uint Type, 
                      PSTR SymbolFile, size_t cSymbolFile, PSTR DbgFile, size_t cDbgFile);

@DllImport("dbghelp.dll")
BOOL SymGetSymbolFileW(HANDLE hProcess, const(PWSTR) SymPath, const(PWSTR) ImageFile, 
                       /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(IMAGEHLP_SF_TYPE))], [])*/uint Type, 
                       PWSTR SymbolFile, size_t cSymbolFile, PWSTR DbgFile, size_t cDbgFile);

@DllImport("dbghelp.dll")
BOOL DbgHelpCreateUserDump(const(PSTR) FileName, PDBGHELP_CREATE_USER_DUMP_CALLBACK Callback, void* UserData);

@DllImport("dbghelp.dll")
BOOL DbgHelpCreateUserDumpW(const(PWSTR) FileName, PDBGHELP_CREATE_USER_DUMP_CALLBACK Callback, void* UserData);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symgetsymfromaddr64
@DllImport("dbghelp.dll")
BOOL SymGetSymFromAddr64(HANDLE hProcess, ulong qwAddr, ulong* pdwDisplacement, IMAGEHLP_SYMBOL64* Symbol);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symgetsymfromname64
@DllImport("dbghelp.dll")
BOOL SymGetSymFromName64(HANDLE hProcess, const(PSTR) Name, IMAGEHLP_SYMBOL64* Symbol);

deprecated("marked as obsolete") 
@DllImport("dbghelp.dll")
BOOL FindFileInPath(HANDLE hprocess, const(PSTR) SearchPathA, const(PSTR) FileName, void* id, uint two, uint three, 
                    uint flags, PSTR FilePath);

deprecated("marked as obsolete") 
@DllImport("dbghelp.dll")
BOOL FindFileInSearchPath(HANDLE hprocess, const(PSTR) SearchPathA, const(PSTR) FileName, uint one, uint two, 
                          uint three, PSTR FilePath);

deprecated("marked as obsolete") 
@DllImport("dbghelp.dll")
BOOL SymEnumSym(HANDLE hProcess, ulong BaseOfDll, PSYM_ENUMERATESYMBOLS_CALLBACK EnumSymbolsCallback, 
                void* UserContext);

deprecated("marked as obsolete") 
@DllImport("dbghelp.dll")
BOOL SymEnumerateSymbols64(HANDLE hProcess, ulong BaseOfDll, PSYM_ENUMSYMBOLS_CALLBACK64 EnumSymbolsCallback, 
                           void* UserContext);

deprecated("marked as obsolete") 
@DllImport("dbghelp.dll")
BOOL SymEnumerateSymbolsW64(HANDLE hProcess, ulong BaseOfDll, PSYM_ENUMSYMBOLS_CALLBACK64W EnumSymbolsCallback, 
                            void* UserContext);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symloadmodule64
@DllImport("dbghelp.dll")
ulong SymLoadModule64(HANDLE hProcess, HANDLE hFile, const(PSTR) ImageName, const(PSTR) ModuleName, 
                      ulong BaseOfDll, uint SizeOfDll);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symloadmodule
@DllImport("dbghelp.dll")
uint SymLoadModule(HANDLE hProcess, HANDLE hFile, const(PSTR) ImageName, const(PSTR) ModuleName, uint BaseOfDll, 
                   uint SizeOfDll);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symgetsymnext64
@DllImport("dbghelp.dll")
BOOL SymGetSymNext64(HANDLE hProcess, IMAGEHLP_SYMBOL64* Symbol);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-symgetsymprev64
@DllImport("dbghelp.dll")
BOOL SymGetSymPrev64(HANDLE hProcess, IMAGEHLP_SYMBOL64* Symbol);

@DllImport("dbghelp.dll")
void SetCheckUserInterruptShared(LPCALL_BACK_USER_INTERRUPT_ROUTINE lpStartAddress);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-getsymloaderror
@DllImport("dbghelp.dll")
uint GetSymLoadError();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dbghelp/nf-dbghelp-setsymloaderror
@DllImport("dbghelp.dll")
void SetSymLoadError(uint error);

@DllImport("dbghelp.dll")
BOOL ReportSymbolLoadSummary(HANDLE hProcess, const(PWSTR) pLoadModule, DBGHELP_DATA_REPORT_STRUCT* pSymbolData);

@DllImport("dbghelp.dll")
void RemoveInvalidModuleList(HANDLE hProcess);

@DllImport("dbghelp.dll")
void* RangeMapCreate();

@DllImport("dbghelp.dll")
void RangeMapFree(void* RmapHandle);

@DllImport("dbghelp.dll")
BOOL RangeMapAddPeImageSections(void* RmapHandle, const(PWSTR) ImageName, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* MappedImage, 
                                uint MappingBytes, ulong ImageBase, ulong UserTag, uint MappingFlags);

@DllImport("dbghelp.dll")
BOOL RangeMapRemove(void* RmapHandle, ulong UserTag);

@DllImport("dbghelp.dll")
BOOL RangeMapRead(void* RmapHandle, ulong Offset, 
                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                  uint RequestBytes, uint Flags, uint* DoneBytes);

@DllImport("dbghelp.dll")
BOOL RangeMapWrite(void* RmapHandle, ulong Offset, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                   uint RequestBytes, uint Flags, uint* DoneBytes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("USER32.dll")
BOOL MessageBeep(MESSAGEBOX_STYLE uType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
void FatalExit(int ExitCode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL GetThreadSelectorEntry(HANDLE hThread, uint dwSelector, LDT_ENTRY* lpSelectorEntry);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
BOOL Wow64GetThreadSelectorEntry(HANDLE hThread, uint dwSelector, WOW64_LDT_ENTRY* lpSelectorEntry);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL DebugSetProcessKillOnExit(BOOL KillOnExit);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
BOOL DebugBreakProcess(HANDLE Process);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint FormatMessageA(FORMAT_MESSAGE_OPTIONS dwFlags, const(void)* lpSource, uint dwMessageId, uint dwLanguageId, 
                    PSTR lpBuffer, uint nSize, byte** Arguments);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("KERNEL32.dll")
uint FormatMessageW(FORMAT_MESSAGE_OPTIONS dwFlags, const(void)* lpSource, uint dwMessageId, uint dwLanguageId, 
                    PWSTR lpBuffer, uint nSize, byte** Arguments);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
BOOL CopyContext(CONTEXT* Destination, CONTEXT_FLAGS ContextFlags, CONTEXT* Source);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
BOOL InitializeContext(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                       CONTEXT_FLAGS ContextFlags, CONTEXT** Context, uint* ContextLength);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-initializecontext2
@DllImport("KERNEL32.dll")
BOOL InitializeContext2(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                        CONTEXT_FLAGS ContextFlags, CONTEXT** Context, uint* ContextLength, 
                        ulong XStateCompactionMask);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
ulong GetEnabledXStateFeatures();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
BOOL GetXStateFeaturesMask(CONTEXT* Context, ulong* FeatureMask);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
void* LocateXStateFeature(CONTEXT* Context, uint FeatureId, uint* Length);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("KERNEL32.dll")
BOOL SetXStateFeaturesMask(CONTEXT* Context, ulong FeatureMask);


// Interfaces

@GUID("cb5bdc81-93c1-11cf-8f20-00805f2cd064")
interface IObjectSafety : IUnknown
{
    HRESULT GetInterfaceSafetyOptions(const(GUID)* riid, uint* pdwSupportedOptions, uint* pdwEnabledOptions);
    HRESULT SetInterfaceSafetyOptions(const(GUID)* riid, uint dwOptionSetMask, uint dwEnabledOptions);
}

@GUID("51973c50-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugProperty : IUnknown
{
    HRESULT GetPropertyInfo(uint dwFieldSpec, uint nRadix, DebugPropertyInfo* pPropertyInfo);
    HRESULT GetExtendedInfo(uint cInfos, GUID* rgguidExtendedInfo, VARIANT* rgvar);
    HRESULT SetValueAsString(const(PWSTR) pszValue, uint nRadix);
    HRESULT EnumMembers(uint dwFieldSpec, uint nRadix, const(GUID)* refiid, IEnumDebugPropertyInfo* ppepi);
    HRESULT GetParent(IDebugProperty* ppDebugProp);
}

@GUID("51973c51-cb0c-11d0-b5c9-00a0244a0e7a")
interface IEnumDebugPropertyInfo : IUnknown
{
    HRESULT Next(uint celt, DebugPropertyInfo* pi, uint* pcEltsfetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumDebugPropertyInfo* ppepi);
    HRESULT GetCount(uint* pcelt);
}

@GUID("51973c52-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugExtendedProperty : IDebugProperty
{
    HRESULT GetExtendedPropertyInfo(uint dwFieldSpec, uint nRadix, 
                                    ExtendedDebugPropertyInfo* pExtendedPropertyInfo);
    HRESULT EnumExtendedMembers(uint dwFieldSpec, uint nRadix, IEnumDebugExtendedPropertyInfo* ppeepi);
}

@GUID("51973c53-cb0c-11d0-b5c9-00a0244a0e7a")
interface IEnumDebugExtendedPropertyInfo : IUnknown
{
    HRESULT Next(uint celt, ExtendedDebugPropertyInfo* rgExtendedPropertyInfo, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumDebugExtendedPropertyInfo* pedpe);
    HRESULT GetCount(uint* pcelt);
}

@GUID("51973c54-cb0c-11d0-b5c9-00a0244a0e7a")
interface IPerPropertyBrowsing2 : IUnknown
{
    HRESULT GetDisplayString(int dispid, BSTR* pBstr);
    HRESULT MapPropertyToPage(int dispid, GUID* pClsidPropPage);
    HRESULT GetPredefinedStrings(int dispid, CALPOLESTR* pCaStrings, CADWORD* pCaCookies);
    HRESULT SetPredefinedValue(int dispid, uint dwCookie);
}

@GUID("51973c55-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugPropertyEnumType_All : IUnknown
{
    HRESULT GetName(BSTR* __MIDL__IDebugPropertyEnumType_All0000);
}

@GUID("51973c56-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugPropertyEnumType_Locals : IDebugPropertyEnumType_All
{
}

@GUID("51973c57-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugPropertyEnumType_Arguments : IDebugPropertyEnumType_All
{
}

@GUID("51973c58-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugPropertyEnumType_LocalsPlusArgs : IDebugPropertyEnumType_All
{
}

@GUID("51973c59-cb0c-11d0-b5c9-00a0244a0e7a")
interface IDebugPropertyEnumType_Registers : IDebugPropertyEnumType_All
{
}


// GUIDs


const GUID IID_IDebugExtendedProperty                = GUIDOF!IDebugExtendedProperty;
const GUID IID_IDebugProperty                        = GUIDOF!IDebugProperty;
const GUID IID_IDebugPropertyEnumType_All            = GUIDOF!IDebugPropertyEnumType_All;
const GUID IID_IDebugPropertyEnumType_Arguments      = GUIDOF!IDebugPropertyEnumType_Arguments;
const GUID IID_IDebugPropertyEnumType_Locals         = GUIDOF!IDebugPropertyEnumType_Locals;
const GUID IID_IDebugPropertyEnumType_LocalsPlusArgs = GUIDOF!IDebugPropertyEnumType_LocalsPlusArgs;
const GUID IID_IDebugPropertyEnumType_Registers      = GUIDOF!IDebugPropertyEnumType_Registers;
const GUID IID_IEnumDebugExtendedPropertyInfo        = GUIDOF!IEnumDebugExtendedPropertyInfo;
const GUID IID_IEnumDebugPropertyInfo                = GUIDOF!IEnumDebugPropertyInfo;
const GUID IID_IObjectSafety                         = GUIDOF!IObjectSafety;
const GUID IID_IPerPropertyBrowsing2                 = GUIDOF!IPerPropertyBrowsing2;
