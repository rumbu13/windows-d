// Written in the D programming language.

module windows.win32.storage.iscsidisc;

public import windows.core;
public import windows.win32.foundation : BOOLEAN, CHAR, PSTR, PWSTR;
public import windows.win32.system.ioctl : STORAGE_DEVICE_NUMBER;

extern(Windows) @nogc nothrow:


// Enums


alias NV_SEP_WRITE_CACHE_TYPE = int;
enum : int
{
    NVSEPWriteCacheTypeUnknown      = 0x00000000,
    NVSEPWriteCacheTypeNone         = 0x00000001,
    NVSEPWriteCacheTypeWriteBack    = 0x00000002,
    NVSEPWriteCacheTypeWriteThrough = 0x00000003,
}

alias MP_STORAGE_DIAGNOSTIC_LEVEL = int;
enum : int
{
    MpStorageDiagnosticLevelDefault = 0x00000000,
    MpStorageDiagnosticLevelMax     = 0x00000001,
}

alias MP_STORAGE_DIAGNOSTIC_TARGET_TYPE = int;
enum : int
{
    MpStorageDiagnosticTargetTypeUndefined   = 0x00000000,
    MpStorageDiagnosticTargetTypeMiniport    = 0x00000002,
    MpStorageDiagnosticTargetTypeHbaFirmware = 0x00000003,
    MpStorageDiagnosticTargetTypeMax         = 0x00000004,
}

alias NVCACHE_TYPE = int;
enum : int
{
    NvCacheTypeUnknown      = 0x00000000,
    NvCacheTypeNone         = 0x00000001,
    NvCacheTypeWriteBack    = 0x00000002,
    NvCacheTypeWriteThrough = 0x00000003,
}

alias NVCACHE_STATUS = int;
enum : int
{
    NvCacheStatusUnknown   = 0x00000000,
    NvCacheStatusDisabling = 0x00000001,
    NvCacheStatusDisabled  = 0x00000002,
    NvCacheStatusEnabled   = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ne-iscsidsc-iscsi_digest_types
alias ISCSI_DIGEST_TYPES = int;
enum : int
{
    ISCSI_DIGEST_TYPE_NONE   = 0x00000000,
    ISCSI_DIGEST_TYPE_CRC32C = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ne-iscsidsc-iscsi_auth_types
alias ISCSI_AUTH_TYPES = int;
enum : int
{
    ISCSI_NO_AUTH_TYPE          = 0x00000000,
    ISCSI_CHAP_AUTH_TYPE        = 0x00000001,
    ISCSI_MUTUAL_CHAP_AUTH_TYPE = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ne-iscsidsc-ike_authentication_method
alias IKE_AUTHENTICATION_METHOD = int;
enum : int
{
    IKE_AUTHENTICATION_PRESHARED_KEY_METHOD = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ne-iscsidsc-targetprotocoltype
alias TARGETPROTOCOLTYPE = int;
enum : int
{
    ISCSI_TCP_PROTOCOL_TYPE = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ne-iscsidsc-target_information_class
alias TARGET_INFORMATION_CLASS = int;
enum : int
{
    ProtocolType             = 0x00000000,
    TargetAlias              = 0x00000001,
    DiscoveryMechanisms      = 0x00000002,
    PortalGroups             = 0x00000003,
    PersistentTargetMappings = 0x00000004,
    InitiatorName            = 0x00000005,
    TargetFlags              = 0x00000006,
    LoginOptions             = 0x00000007,
}

// Constants


enum uint IOCTL_SCSI_BASE = 0x00000004U;
enum GUID ScsiRawInterfaceGuid = GUID("53f56309-b6bf-11d0-94f2-00a0c91efb8b");
enum GUID WmiScsiAddressGuid = GUID("53f5630f-b6bf-11d0-94f2-00a0c91efb8b");
enum uint FILE_DEVICE_SCSI = 0x0000001bU;
// Native encoding: ansi
enum const(wchar)* DD_SCSI_DEVICE_NAME = "\\Device\\ScsiPort";

enum : uint
{
    IOCTL_SCSI_PASS_THROUGH        = 0x0004d004U,
    IOCTL_SCSI_MINIPORT            = 0x0004d008U,
    IOCTL_SCSI_GET_INQUIRY_DATA    = 0x0004100cU,
    IOCTL_SCSI_GET_CAPABILITIES    = 0x00041010U,
    IOCTL_SCSI_PASS_THROUGH_DIRECT = 0x0004d014U,
}

enum : uint
{
    IOCTL_SCSI_GET_ADDRESS       = 0x00041018U,
    IOCTL_SCSI_RESCAN_BUS        = 0x0004101cU,
    IOCTL_SCSI_GET_DUMP_POINTERS = 0x00041020U,
}

enum uint IOCTL_SCSI_FREE_DUMP_POINTERS = 0x00041024U;
enum uint IOCTL_IDE_PASS_THROUGH = 0x0004d028U;

enum : uint
{
    IOCTL_ATA_PASS_THROUGH        = 0x0004d02cU,
    IOCTL_ATA_PASS_THROUGH_DIRECT = 0x0004d030U,
}

enum uint IOCTL_ATA_MINIPORT = 0x0004d034U;
enum uint IOCTL_MINIPORT_PROCESS_SERVICE_IRP = 0x0004d038U;

enum : uint
{
    IOCTL_MPIO_PASS_THROUGH_PATH        = 0x0004d03cU,
    IOCTL_MPIO_PASS_THROUGH_PATH_DIRECT = 0x0004d040U,
}

enum : uint
{
    IOCTL_SCSI_PASS_THROUGH_EX        = 0x0004d044U,
    IOCTL_SCSI_PASS_THROUGH_DIRECT_EX = 0x0004d048U,
}

enum : uint
{
    IOCTL_MPIO_PASS_THROUGH_PATH_EX        = 0x0004d04cU,
    IOCTL_MPIO_PASS_THROUGH_PATH_DIRECT_EX = 0x0004d050U,
}

enum : uint
{
    ATA_FLAGS_DRDY_REQUIRED = 0x00000001U,
    ATA_FLAGS_DATA_IN       = 0x00000002U,
    ATA_FLAGS_DATA_OUT      = 0x00000004U,
    ATA_FLAGS_48BIT_COMMAND = 0x00000008U,
    ATA_FLAGS_USE_DMA       = 0x00000010U,
    ATA_FLAGS_NO_MULTIPLE   = 0x00000020U,
}

enum : const(wchar)*
{
    // Native encoding: ansi
    IOCTL_MINIPORT_SIGNATURE_SCSIDISK                  = "SCSIDISK",
    // Native encoding: ansi
    IOCTL_MINIPORT_SIGNATURE_HYBRDISK                  = "HYBRDISK",
    // Native encoding: ansi
    IOCTL_MINIPORT_SIGNATURE_DSM_NOTIFICATION          = "MPDSM   ",
    // Native encoding: ansi
    IOCTL_MINIPORT_SIGNATURE_DSM_GENERAL               = "MPDSMGEN",
    // Native encoding: ansi
    IOCTL_MINIPORT_SIGNATURE_FIRMWARE                  = "FIRMWARE",
    // Native encoding: ansi
    IOCTL_MINIPORT_SIGNATURE_QUERY_PROTOCOL            = "PROTOCOL",
    // Native encoding: ansi
    IOCTL_MINIPORT_SIGNATURE_SET_PROTOCOL              = "SETPROTO",
    // Native encoding: ansi
    IOCTL_MINIPORT_SIGNATURE_QUERY_TEMPERATURE         = "TEMPERAT",
    // Native encoding: ansi
    IOCTL_MINIPORT_SIGNATURE_SET_TEMPERATURE_THRESHOLD = "SETTEMPT",
    // Native encoding: ansi
    IOCTL_MINIPORT_SIGNATURE_QUERY_PHYSICAL_TOPOLOGY   = "TOPOLOGY",
    // Native encoding: ansi
    IOCTL_MINIPORT_SIGNATURE_ENDURANCE_INFO            = "ENDURINF",
}

enum : uint
{
    NRB_FUNCTION_NVCACHE_INFO              = 0x000000ecU,
    NRB_FUNCTION_SPINDLE_STATUS            = 0x000000e5U,
    NRB_FUNCTION_NVCACHE_POWER_MODE_SET    = 0x00000000U,
    NRB_FUNCTION_NVCACHE_POWER_MODE_RETURN = 0x00000001U,
}

enum : uint
{
    NRB_FUNCTION_FLUSH_NVCACHE          = 0x00000014U,
    NRB_FUNCTION_QUERY_PINNED_SET       = 0x00000012U,
    NRB_FUNCTION_QUERY_CACHE_MISS       = 0x00000013U,
    NRB_FUNCTION_ADD_LBAS_PINNED_SET    = 0x00000010U,
    NRB_FUNCTION_REMOVE_LBAS_PINNED_SET = 0x00000011U,
}

enum : uint
{
    NRB_FUNCTION_QUERY_ASCENDER_STATUS    = 0x000000d0U,
    NRB_FUNCTION_QUERY_HYBRID_DISK_STATUS = 0x000000d1U,
}

enum : uint
{
    NRB_FUNCTION_PASS_HINT_PAYLOAD             = 0x000000e0U,
    NRB_FUNCTION_NVSEPARATED_INFO              = 0x000000c0U,
    NRB_FUNCTION_NVSEPARATED_FLUSH             = 0x000000c1U,
    NRB_FUNCTION_NVSEPARATED_WB_DISABLE        = 0x000000c2U,
    NRB_FUNCTION_NVSEPARATED_WB_REVERT_DEFAULT = 0x000000c3U,
}

enum uint NRB_SUCCESS = 0x00000000U;
enum uint NRB_ILLEGAL_REQUEST = 0x00000001U;
enum uint NRB_INVALID_PARAMETER = 0x00000002U;

enum : uint
{
    NRB_INPUT_DATA_OVERRUN  = 0x00000003U,
    NRB_INPUT_DATA_UNDERRUN = 0x00000004U,
}

enum : uint
{
    NRB_OUTPUT_DATA_OVERRUN  = 0x00000005U,
    NRB_OUTPUT_DATA_UNDERRUN = 0x00000006U,
}

enum : uint
{
    NV_SEP_CACHE_PARAMETER_VERSION_1 = 0x00000001U,
    NV_SEP_CACHE_PARAMETER_VERSION   = 0x00000001U,
}

enum : uint
{
    STORAGE_DIAGNOSTIC_STATUS_SUCCESS             = 0x00000000U,
    STORAGE_DIAGNOSTIC_STATUS_BUFFER_TOO_SMALL    = 0x00000001U,
    STORAGE_DIAGNOSTIC_STATUS_UNSUPPORTED_VERSION = 0x00000002U,
    STORAGE_DIAGNOSTIC_STATUS_INVALID_PARAMETER   = 0x00000003U,
    STORAGE_DIAGNOSTIC_STATUS_INVALID_SIGNATURE   = 0x00000004U,
    STORAGE_DIAGNOSTIC_STATUS_INVALID_TARGET_TYPE = 0x00000005U,
    STORAGE_DIAGNOSTIC_STATUS_MORE_DATA           = 0x00000006U,
}

enum : uint
{
    MINIPORT_DSM_NOTIFICATION_VERSION_1 = 0x00000001U,
    MINIPORT_DSM_NOTIFICATION_VERSION   = 0x00000001U,
}

enum : uint
{
    MINIPORT_DSM_PROFILE_UNKNOWN          = 0x00000000U,
    MINIPORT_DSM_PROFILE_PAGE_FILE        = 0x00000001U,
    MINIPORT_DSM_PROFILE_HIBERNATION_FILE = 0x00000002U,
    MINIPORT_DSM_PROFILE_CRASHDUMP_FILE   = 0x00000003U,
}

enum : uint
{
    MINIPORT_DSM_NOTIFY_FLAG_BEGIN = 0x00000001U,
    MINIPORT_DSM_NOTIFY_FLAG_END   = 0x00000002U,
}

enum : uint
{
    HYBRID_FUNCTION_GET_INFO               = 0x00000001U,
    HYBRID_FUNCTION_DISABLE_CACHING_MEDIUM = 0x00000010U,
    HYBRID_FUNCTION_ENABLE_CACHING_MEDIUM  = 0x00000011U,
    HYBRID_FUNCTION_SET_DIRTY_THRESHOLD    = 0x00000012U,
    HYBRID_FUNCTION_DEMOTE_BY_SIZE         = 0x00000013U,
}

enum : uint
{
    HYBRID_STATUS_SUCCESS                 = 0x00000000U,
    HYBRID_STATUS_ILLEGAL_REQUEST         = 0x00000001U,
    HYBRID_STATUS_INVALID_PARAMETER       = 0x00000002U,
    HYBRID_STATUS_OUTPUT_BUFFER_TOO_SMALL = 0x00000003U,
}

enum uint HYBRID_STATUS_ENABLE_REFCOUNT_HOLD = 0x00000010U;
enum uint HYBRID_REQUEST_BLOCK_STRUCTURE_VERSION = 0x00000001U;
enum uint HYBRID_REQUEST_INFO_STRUCTURE_VERSION = 0x00000001U;

enum : uint
{
    FIRMWARE_FUNCTION_GET_INFO = 0x00000001U,
    FIRMWARE_FUNCTION_DOWNLOAD = 0x00000002U,
    FIRMWARE_FUNCTION_ACTIVATE = 0x00000003U,
}

enum : uint
{
    FIRMWARE_STATUS_SUCCESS                  = 0x00000000U,
    FIRMWARE_STATUS_ERROR                    = 0x00000001U,
    FIRMWARE_STATUS_ILLEGAL_REQUEST          = 0x00000002U,
    FIRMWARE_STATUS_INVALID_PARAMETER        = 0x00000003U,
    FIRMWARE_STATUS_INPUT_BUFFER_TOO_BIG     = 0x00000004U,
    FIRMWARE_STATUS_OUTPUT_BUFFER_TOO_SMALL  = 0x00000005U,
    FIRMWARE_STATUS_INVALID_SLOT             = 0x00000006U,
    FIRMWARE_STATUS_INVALID_IMAGE            = 0x00000007U,
    FIRMWARE_STATUS_CONTROLLER_ERROR         = 0x00000010U,
    FIRMWARE_STATUS_POWER_CYCLE_REQUIRED     = 0x00000020U,
    FIRMWARE_STATUS_DEVICE_ERROR             = 0x00000040U,
    FIRMWARE_STATUS_INTERFACE_CRC_ERROR      = 0x00000080U,
    FIRMWARE_STATUS_UNCORRECTABLE_DATA_ERROR = 0x00000081U,
}

enum : uint
{
    FIRMWARE_STATUS_MEDIA_CHANGE         = 0x00000082U,
    FIRMWARE_STATUS_ID_NOT_FOUND         = 0x00000083U,
    FIRMWARE_STATUS_MEDIA_CHANGE_REQUEST = 0x00000084U,
    FIRMWARE_STATUS_COMMAND_ABORT        = 0x00000085U,
    FIRMWARE_STATUS_END_OF_MEDIA         = 0x00000086U,
    FIRMWARE_STATUS_ILLEGAL_LENGTH       = 0x00000087U,
}

enum : uint
{
    FIRMWARE_REQUEST_BLOCK_STRUCTURE_VERSION               = 0x00000001U,
    FIRMWARE_REQUEST_FLAG_CONTROLLER                       = 0x00000001U,
    FIRMWARE_REQUEST_FLAG_LAST_SEGMENT                     = 0x00000002U,
    FIRMWARE_REQUEST_FLAG_FIRST_SEGMENT                    = 0x00000004U,
    FIRMWARE_REQUEST_FLAG_SWITCH_TO_FIRMWARE_WITHOUT_RESET = 0x10000000U,
    FIRMWARE_REQUEST_FLAG_REPLACE_AND_SWITCH_UPON_RESET    = 0x20000000U,
    FIRMWARE_REQUEST_FLAG_REPLACE_EXISTING_IMAGE           = 0x40000000U,
    FIRMWARE_REQUEST_FLAG_SWITCH_TO_EXISTING_FIRMWARE      = 0x80000000U,
}

enum : uint
{
    STORAGE_FIRMWARE_INFO_STRUCTURE_VERSION       = 0x00000001U,
    STORAGE_FIRMWARE_INFO_STRUCTURE_VERSION_V2    = 0x00000002U,
    STORAGE_FIRMWARE_INFO_INVALID_SLOT            = 0x000000ffU,
    STORAGE_FIRMWARE_SLOT_INFO_V2_REVISION_LENGTH = 0x00000010U,
}

enum : uint
{
    STORAGE_FIRMWARE_DOWNLOAD_STRUCTURE_VERSION    = 0x00000001U,
    STORAGE_FIRMWARE_DOWNLOAD_STRUCTURE_VERSION_V2 = 0x00000002U,
}

enum uint STORAGE_FIRMWARE_ACTIVATE_STRUCTURE_VERSION = 0x00000001U;

enum : uint
{
    DUMP_POINTERS_VERSION_1 = 0x00000001U,
    DUMP_POINTERS_VERSION_2 = 0x00000002U,
    DUMP_POINTERS_VERSION_3 = 0x00000003U,
    DUMP_POINTERS_VERSION_4 = 0x00000004U,
}

enum uint DUMP_DRIVER_NAME_LENGTH = 0x0000000fU;

enum : uint
{
    DUMP_EX_FLAG_SUPPORT_64BITMEMORY  = 0x00000001U,
    DUMP_EX_FLAG_SUPPORT_DD_TELEMETRY = 0x00000002U,
}

enum : uint
{
    DUMP_EX_FLAG_RESUME_SUPPORT           = 0x00000004U,
    DUMP_EX_FLAG_DRIVER_FULL_PATH_SUPPORT = 0x00000008U,
}

enum : uint
{
    SCSI_IOCTL_DATA_OUT           = 0x00000000U,
    SCSI_IOCTL_DATA_IN            = 0x00000001U,
    SCSI_IOCTL_DATA_UNSPECIFIED   = 0x00000002U,
    SCSI_IOCTL_DATA_BIDIRECTIONAL = 0x00000003U,
}

enum : uint
{
    MPIO_IOCTL_FLAG_USE_PATHID      = 0x00000001U,
    MPIO_IOCTL_FLAG_USE_SCSIADDRESS = 0x00000002U,
    MPIO_IOCTL_FLAG_INVOLVE_DSM     = 0x00000004U,
}

enum : uint
{
    MAX_ISCSI_HBANAME_LEN      = 0x00000100U,
    MAX_ISCSI_NAME_LEN         = 0x000000dfU,
    MAX_ISCSI_ALIAS_LEN        = 0x000000ffU,
    MAX_ISCSI_PORTAL_NAME_LEN  = 0x00000100U,
    MAX_ISCSI_PORTAL_ALIAS_LEN = 0x00000100U,
}

enum uint MAX_ISCSI_TEXT_ADDRESS_LEN = 0x00000100U;
enum uint MAX_ISCSI_PORTAL_ADDRESS_LEN = 0x00000100U;
enum uint MAX_ISCSI_DISCOVERY_DOMAIN_LEN = 0x00000100U;
enum uint MAX_RADIUS_ADDRESS_LEN = 0x00000029U;

enum : const(wchar)*
{
    // Native encoding: ansi
    ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED    = "0x00000040",
    // Native encoding: ansi
    ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED = "0x00000020",
    // Native encoding: ansi
    ISCSI_SECURITY_FLAG_PFS_ENABLED              = "0x00000010",
    // Native encoding: ansi
    ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED  = "0x00000008",
    // Native encoding: ansi
    ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED        = "0x00000004",
    // Native encoding: ansi
    ISCSI_SECURITY_FLAG_IKE_IPSEC_ENABLED        = "0x00000002",
    // Native encoding: ansi
    ISCSI_SECURITY_FLAG_VALID                    = "0x00000001",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    ISCSI_LOGIN_OPTIONS_HEADER_DIGEST         = "0x00000001",
    // Native encoding: ansi
    ISCSI_LOGIN_OPTIONS_DATA_DIGEST           = "0x00000002",
    // Native encoding: ansi
    ISCSI_LOGIN_OPTIONS_MAXIMUM_CONNECTIONS   = "0x00000004",
    // Native encoding: ansi
    ISCSI_LOGIN_OPTIONS_DEFAULT_TIME_2_WAIT   = "0x00000008",
    // Native encoding: ansi
    ISCSI_LOGIN_OPTIONS_DEFAULT_TIME_2_RETAIN = "0x00000010",
    // Native encoding: ansi
    ISCSI_LOGIN_OPTIONS_USERNAME              = "0x00000020",
    // Native encoding: ansi
    ISCSI_LOGIN_OPTIONS_PASSWORD              = "0x00000040",
    // Native encoding: ansi
    ISCSI_LOGIN_OPTIONS_AUTH_TYPE             = "0x00000080",
}

// Native encoding: ansi
enum const(wchar)* ID_IPV4_ADDR = "1";

enum : const(wchar)*
{
    // Native encoding: ansi
    ID_FQDN      = "2",
    // Native encoding: ansi
    ID_USER_FQDN = "3",
}

// Native encoding: ansi
enum const(wchar)* ID_IPV6_ADDR = "5";

enum : uint
{
    ISCSI_LOGIN_FLAG_REQUIRE_IPSEC           = 0x00000001U,
    ISCSI_LOGIN_FLAG_MULTIPATH_ENABLED       = 0x00000002U,
    ISCSI_LOGIN_FLAG_RESERVED1               = 0x00000004U,
    ISCSI_LOGIN_FLAG_ALLOW_PORTAL_HOPPING    = 0x00000008U,
    ISCSI_LOGIN_FLAG_USE_RADIUS_RESPONSE     = 0x00000010U,
    ISCSI_LOGIN_FLAG_USE_RADIUS_VERIFICATION = 0x00000020U,
}

enum uint ISCSI_LOGIN_OPTIONS_VERSION = 0x00000000U;

enum : uint
{
    ISCSI_TARGET_FLAG_HIDE_STATIC_TARGET       = 0x00000002U,
    ISCSI_TARGET_FLAG_MERGE_TARGET_INFORMATION = 0x00000004U,
}

// Callbacks

alias PDUMP_DEVICE_POWERON_ROUTINE = int function(void* Context);

// Structs


struct _ADAPTER_OBJECT
{
    ptrdiff_t Value;
}

version(X86_64)
{
    struct SCSI_PASS_THROUGH32
    {
        ushort    Length;
        ubyte     ScsiStatus;
        ubyte     PathId;
        ubyte     TargetId;
        ubyte     Lun;
        ubyte     CdbLength;
        ubyte     SenseInfoLength;
        ubyte     DataIn;
        uint      DataTransferLength;
        uint      TimeOutValue;
        uint      DataBufferOffset;
        uint      SenseInfoOffset;
        ubyte[16] Cdb;
    }
}

version(AArch64)
{
    struct SCSI_PASS_THROUGH32
    {
        ushort    Length;
        ubyte     ScsiStatus;
        ubyte     PathId;
        ubyte     TargetId;
        ubyte     Lun;
        ubyte     CdbLength;
        ubyte     SenseInfoLength;
        ubyte     DataIn;
        uint      DataTransferLength;
        uint      TimeOutValue;
        uint      DataBufferOffset;
        uint      SenseInfoOffset;
        ubyte[16] Cdb;
    }
}

version(X86_64)
{
    struct SCSI_PASS_THROUGH_DIRECT32
    {
        ushort    Length;
        ubyte     ScsiStatus;
        ubyte     PathId;
        ubyte     TargetId;
        ubyte     Lun;
        ubyte     CdbLength;
        ubyte     SenseInfoLength;
        ubyte     DataIn;
        uint      DataTransferLength;
        uint      TimeOutValue;
        void*     DataBuffer;
        uint      SenseInfoOffset;
        ubyte[16] Cdb;
    }
}

version(AArch64)
{
    struct SCSI_PASS_THROUGH_DIRECT32
    {
        ushort    Length;
        ubyte     ScsiStatus;
        ubyte     PathId;
        ubyte     TargetId;
        ubyte     Lun;
        ubyte     CdbLength;
        ubyte     SenseInfoLength;
        ubyte     DataIn;
        uint      DataTransferLength;
        uint      TimeOutValue;
        void*     DataBuffer;
        uint      SenseInfoOffset;
        ubyte[16] Cdb;
    }
}

version(X86_64)
{
    struct SCSI_PASS_THROUGH32_EX
    {
        uint     Version;
        uint     Length;
        uint     CdbLength;
        uint     StorAddressLength;
        ubyte    ScsiStatus;
        ubyte    SenseInfoLength;
        ubyte    DataDirection;
        ubyte    Reserved;
        uint     TimeOutValue;
        uint     StorAddressOffset;
        uint     SenseInfoOffset;
        uint     DataOutTransferLength;
        uint     DataInTransferLength;
        uint     DataOutBufferOffset;
        uint     DataInBufferOffset;
        ubyte[1] Cdb; // Flexible array
    }
}

version(AArch64)
{
    struct SCSI_PASS_THROUGH32_EX
    {
        uint     Version;
        uint     Length;
        uint     CdbLength;
        uint     StorAddressLength;
        ubyte    ScsiStatus;
        ubyte    SenseInfoLength;
        ubyte    DataDirection;
        ubyte    Reserved;
        uint     TimeOutValue;
        uint     StorAddressOffset;
        uint     SenseInfoOffset;
        uint     DataOutTransferLength;
        uint     DataInTransferLength;
        uint     DataOutBufferOffset;
        uint     DataInBufferOffset;
        ubyte[1] Cdb; // Flexible array
    }
}

version(X86_64)
{
    struct SCSI_PASS_THROUGH_DIRECT32_EX
    {
        uint     Version;
        uint     Length;
        uint     CdbLength;
        uint     StorAddressLength;
        ubyte    ScsiStatus;
        ubyte    SenseInfoLength;
        ubyte    DataDirection;
        ubyte    Reserved;
        uint     TimeOutValue;
        uint     StorAddressOffset;
        uint     SenseInfoOffset;
        uint     DataOutTransferLength;
        uint     DataInTransferLength;
        void*    DataOutBuffer;
        void*    DataInBuffer;
        ubyte[1] Cdb; // Flexible array
    }
}

version(AArch64)
{
    struct SCSI_PASS_THROUGH_DIRECT32_EX
    {
        uint     Version;
        uint     Length;
        uint     CdbLength;
        uint     StorAddressLength;
        ubyte    ScsiStatus;
        ubyte    SenseInfoLength;
        ubyte    DataDirection;
        ubyte    Reserved;
        uint     TimeOutValue;
        uint     StorAddressOffset;
        uint     SenseInfoOffset;
        uint     DataOutTransferLength;
        uint     DataInTransferLength;
        void*    DataOutBuffer;
        void*    DataInBuffer;
        ubyte[1] Cdb; // Flexible array
    }
}

version(X86_64)
{
    struct ATA_PASS_THROUGH_EX32
    {
        ushort   Length;
        ushort   AtaFlags;
        ubyte    PathId;
        ubyte    TargetId;
        ubyte    Lun;
        ubyte    ReservedAsUchar;
        uint     DataTransferLength;
        uint     TimeOutValue;
        uint     ReservedAsUlong;
        uint     DataBufferOffset;
        ubyte[8] PreviousTaskFile;
        ubyte[8] CurrentTaskFile;
    }
}

version(AArch64)
{
    struct ATA_PASS_THROUGH_EX32
    {
        ushort   Length;
        ushort   AtaFlags;
        ubyte    PathId;
        ubyte    TargetId;
        ubyte    Lun;
        ubyte    ReservedAsUchar;
        uint     DataTransferLength;
        uint     TimeOutValue;
        uint     ReservedAsUlong;
        uint     DataBufferOffset;
        ubyte[8] PreviousTaskFile;
        ubyte[8] CurrentTaskFile;
    }
}

version(X86_64)
{
    struct ATA_PASS_THROUGH_DIRECT32
    {
        ushort   Length;
        ushort   AtaFlags;
        ubyte    PathId;
        ubyte    TargetId;
        ubyte    Lun;
        ubyte    ReservedAsUchar;
        uint     DataTransferLength;
        uint     TimeOutValue;
        uint     ReservedAsUlong;
        void*    DataBuffer;
        ubyte[8] PreviousTaskFile;
        ubyte[8] CurrentTaskFile;
    }
}

version(AArch64)
{
    struct ATA_PASS_THROUGH_DIRECT32
    {
        ushort   Length;
        ushort   AtaFlags;
        ubyte    PathId;
        ubyte    TargetId;
        ubyte    Lun;
        ubyte    ReservedAsUchar;
        uint     DataTransferLength;
        uint     TimeOutValue;
        uint     ReservedAsUlong;
        void*    DataBuffer;
        ubyte[8] PreviousTaskFile;
        ubyte[8] CurrentTaskFile;
    }
}

version(X86_64)
{
    struct MPIO_PASS_THROUGH_PATH32
    {
        SCSI_PASS_THROUGH32 PassThrough;
        uint                Version;
        ushort              Length;
        ubyte               Flags;
        ubyte               PortNumber;
        ulong               MpioPathId;
    }
}

version(AArch64)
{
    struct MPIO_PASS_THROUGH_PATH32
    {
        SCSI_PASS_THROUGH32 PassThrough;
        uint                Version;
        ushort              Length;
        ubyte               Flags;
        ubyte               PortNumber;
        ulong               MpioPathId;
    }
}

version(X86_64)
{
    struct MPIO_PASS_THROUGH_PATH_DIRECT32
    {
        SCSI_PASS_THROUGH_DIRECT32 PassThrough;
        uint   Version;
        ushort Length;
        ubyte  Flags;
        ubyte  PortNumber;
        ulong  MpioPathId;
    }
}

version(AArch64)
{
    struct MPIO_PASS_THROUGH_PATH_DIRECT32
    {
        SCSI_PASS_THROUGH_DIRECT32 PassThrough;
        uint   Version;
        ushort Length;
        ubyte  Flags;
        ubyte  PortNumber;
        ulong  MpioPathId;
    }
}

version(X86_64)
{
    struct MPIO_PASS_THROUGH_PATH32_EX
    {
        uint   PassThroughOffset;
        uint   Version;
        ushort Length;
        ubyte  Flags;
        ubyte  PortNumber;
        ulong  MpioPathId;
    }
}

version(AArch64)
{
    struct MPIO_PASS_THROUGH_PATH32_EX
    {
        uint   PassThroughOffset;
        uint   Version;
        ushort Length;
        ubyte  Flags;
        ubyte  PortNumber;
        ulong  MpioPathId;
    }
}

version(X86_64)
{
    struct MPIO_PASS_THROUGH_PATH_DIRECT32_EX
    {
        uint   PassThroughOffset;
        uint   Version;
        ushort Length;
        ubyte  Flags;
        ubyte  PortNumber;
        ulong  MpioPathId;
    }
}

version(AArch64)
{
    struct MPIO_PASS_THROUGH_PATH_DIRECT32_EX
    {
        uint   PassThroughOffset;
        uint   Version;
        ushort Length;
        ubyte  Flags;
        ubyte  PortNumber;
        ulong  MpioPathId;
    }
}

struct SCSI_PASS_THROUGH
{
    ushort    Length;
    ubyte     ScsiStatus;
    ubyte     PathId;
    ubyte     TargetId;
    ubyte     Lun;
    ubyte     CdbLength;
    ubyte     SenseInfoLength;
    ubyte     DataIn;
    uint      DataTransferLength;
    uint      TimeOutValue;
    size_t    DataBufferOffset;
    uint      SenseInfoOffset;
    ubyte[16] Cdb;
}

struct SCSI_PASS_THROUGH_DIRECT
{
    ushort    Length;
    ubyte     ScsiStatus;
    ubyte     PathId;
    ubyte     TargetId;
    ubyte     Lun;
    ubyte     CdbLength;
    ubyte     SenseInfoLength;
    ubyte     DataIn;
    uint      DataTransferLength;
    uint      TimeOutValue;
    void*     DataBuffer;
    uint      SenseInfoOffset;
    ubyte[16] Cdb;
}

struct SCSI_PASS_THROUGH_EX
{
    uint     Version;
    uint     Length;
    uint     CdbLength;
    uint     StorAddressLength;
    ubyte    ScsiStatus;
    ubyte    SenseInfoLength;
    ubyte    DataDirection;
    ubyte    Reserved;
    uint     TimeOutValue;
    uint     StorAddressOffset;
    uint     SenseInfoOffset;
    uint     DataOutTransferLength;
    uint     DataInTransferLength;
    size_t   DataOutBufferOffset;
    size_t   DataInBufferOffset;
    ubyte[1] Cdb; // Flexible array
}

struct SCSI_PASS_THROUGH_DIRECT_EX
{
    uint     Version;
    uint     Length;
    uint     CdbLength;
    uint     StorAddressLength;
    ubyte    ScsiStatus;
    ubyte    SenseInfoLength;
    ubyte    DataDirection;
    ubyte    Reserved;
    uint     TimeOutValue;
    uint     StorAddressOffset;
    uint     SenseInfoOffset;
    uint     DataOutTransferLength;
    uint     DataInTransferLength;
    void*    DataOutBuffer;
    void*    DataInBuffer;
    ubyte[1] Cdb; // Flexible array
}

struct ATA_PASS_THROUGH_EX
{
    ushort   Length;
    ushort   AtaFlags;
    ubyte    PathId;
    ubyte    TargetId;
    ubyte    Lun;
    ubyte    ReservedAsUchar;
    uint     DataTransferLength;
    uint     TimeOutValue;
    uint     ReservedAsUlong;
    size_t   DataBufferOffset;
    ubyte[8] PreviousTaskFile;
    ubyte[8] CurrentTaskFile;
}

struct ATA_PASS_THROUGH_DIRECT
{
    ushort   Length;
    ushort   AtaFlags;
    ubyte    PathId;
    ubyte    TargetId;
    ubyte    Lun;
    ubyte    ReservedAsUchar;
    uint     DataTransferLength;
    uint     TimeOutValue;
    uint     ReservedAsUlong;
    void*    DataBuffer;
    ubyte[8] PreviousTaskFile;
    ubyte[8] CurrentTaskFile;
}

struct IDE_IO_CONTROL
{
    uint     HeaderLength;
    ubyte[8] Signature;
    uint     Timeout;
    uint     ControlCode;
    uint     ReturnStatus;
    uint     DataLength;
}

struct MPIO_PASS_THROUGH_PATH
{
    SCSI_PASS_THROUGH PassThrough;
    uint              Version;
    ushort            Length;
    ubyte             Flags;
    ubyte             PortNumber;
    ulong             MpioPathId;
}

struct MPIO_PASS_THROUGH_PATH_DIRECT
{
    SCSI_PASS_THROUGH_DIRECT PassThrough;
    uint   Version;
    ushort Length;
    ubyte  Flags;
    ubyte  PortNumber;
    ulong  MpioPathId;
}

struct MPIO_PASS_THROUGH_PATH_EX
{
    uint   PassThroughOffset;
    uint   Version;
    ushort Length;
    ubyte  Flags;
    ubyte  PortNumber;
    ulong  MpioPathId;
}

struct MPIO_PASS_THROUGH_PATH_DIRECT_EX
{
    uint   PassThroughOffset;
    uint   Version;
    ushort Length;
    ubyte  Flags;
    ubyte  PortNumber;
    ulong  MpioPathId;
}

struct SCSI_BUS_DATA
{
    ubyte NumberOfLogicalUnits;
    ubyte InitiatorBusId;
    uint  InquiryDataOffset;
}

struct SCSI_ADAPTER_BUS_INFO
{
    ubyte            NumberOfBuses;
    SCSI_BUS_DATA[1] BusData; // Flexible array
}

struct SCSI_INQUIRY_DATA
{
    ubyte    PathId;
    ubyte    TargetId;
    ubyte    Lun;
    BOOLEAN  DeviceClaimed;
    uint     InquiryDataLength;
    uint     NextInquiryDataOffset;
    ubyte[1] InquiryData; // Flexible array
}

struct SRB_IO_CONTROL
{
    uint     HeaderLength;
    ubyte[8] Signature;
    uint     Timeout;
    uint     ControlCode;
    uint     ReturnCode;
    uint     Length;
}

struct NVCACHE_REQUEST_BLOCK
{
    uint   NRBSize;
    ushort Function;
    uint   NRBFlags;
    uint   NRBStatus;
    uint   Count;
    ulong  LBA;
    uint   DataBufSize;
    uint   NVCacheStatus;
    uint   NVCacheSubStatus;
}

struct NV_FEATURE_PARAMETER
{
    ushort NVPowerModeEnabled;
    ushort NVParameterReserv1;
    ushort NVCmdEnabled;
    ushort NVParameterReserv2;
    ushort NVPowerModeVer;
    ushort NVCmdVer;
    uint   NVSize;
    ushort NVReadSpeed;
    ushort NVWrtSpeed;
    uint   DeviceSpinUpTime;
}

struct NVCACHE_HINT_PAYLOAD
{
    ubyte    Command;
    ubyte    Feature7_0;
    ubyte    Feature15_8;
    ubyte    Count15_8;
    ubyte    LBA7_0;
    ubyte    LBA15_8;
    ubyte    LBA23_16;
    ubyte    LBA31_24;
    ubyte    LBA39_32;
    ubyte    LBA47_40;
    ubyte    Auxiliary7_0;
    ubyte    Auxiliary23_16;
    ubyte[4] Reserved;
}

struct NV_SEP_CACHE_PARAMETER
{
    uint     Version;
    uint     Size;
    union Flags
    {
        struct CacheFlags
        {
            // Native bit field: WriteCacheEnabled: [0], WriteCacheChangeable: [1], WriteThroughIOSupported: [2], FlushCacheSupported: [3], ReservedBits: [4-7]
            ubyte _bitfield0;
        }
        ubyte CacheFlagsSet;
    }
    ubyte    WriteCacheType;
    ubyte    WriteCacheTypeEffective;
    ubyte[3] ParameterReserve1;
}

struct STORAGE_DIAGNOSTIC_MP_REQUEST
{
    uint     Version;
    uint     Size;
    MP_STORAGE_DIAGNOSTIC_TARGET_TYPE TargetType;
    MP_STORAGE_DIAGNOSTIC_LEVEL Level;
    GUID     ProviderId;
    uint     BufferSize;
    uint     Reserved;
    ubyte[1] DataBuffer; // Flexible array
}

struct MP_DEVICE_DATA_SET_RANGE
{
    long  StartingOffset;
    ulong LengthInBytes;
}

struct DSM_NOTIFICATION_REQUEST_BLOCK
{
    uint    Size;
    uint    Version;
    uint    NotifyFlags;
    uint    DataSetProfile;
    uint[3] Reserved;
    uint    DataSetRangesCount;
    MP_DEVICE_DATA_SET_RANGE[1] DataSetRanges; // Flexible array
}

struct HYBRID_REQUEST_BLOCK
{
    uint Version;
    uint Size;
    uint Function;
    uint Flags;
    uint DataBufferOffset;
    uint DataBufferLength;
}

struct NVCACHE_PRIORITY_LEVEL_DESCRIPTOR
{
    ubyte    PriorityLevel;
    ubyte[3] Reserved0;
    uint     ConsumedNVMSizeFraction;
    uint     ConsumedMappingResourcesFraction;
    uint     ConsumedNVMSizeForDirtyDataFraction;
    uint     ConsumedMappingResourcesForDirtyDataFraction;
    uint     Reserved1;
}

struct HYBRID_INFORMATION
{
    uint           Version;
    uint           Size;
    BOOLEAN        HybridSupported;
    NVCACHE_STATUS Status;
    NVCACHE_TYPE   CacheTypeEffective;
    NVCACHE_TYPE   CacheTypeDefault;
    uint           FractionBase;
    ulong          CacheSize;
    struct Attributes
    {
        // Native bit field: WriteCacheChangeable: [0], WriteThroughIoSupported: [1], FlushCacheSupported: [2], Removable: [3], ReservedBits: [4-31]
        uint _bitfield0;
    }
    struct Priorities
    {
        ubyte   PriorityLevelCount;
        BOOLEAN MaxPriorityBehavior;
        ubyte   OptimalWriteGranularity;
        ubyte   Reserved;
        uint    DirtyThresholdLow;
        uint    DirtyThresholdHigh;
        struct SupportedCommands
        {
            // Native bit field: CacheDisable: [0], SetDirtyThreshold: [1], PriorityDemoteBySize: [2], PriorityChangeByLbaRange: [3], Evict: [4], ReservedBits: [5-31]
            uint _bitfield1;
            uint MaxEvictCommands;
            uint MaxLbaRangeCountForEvict;
            uint MaxLbaRangeCountForChangeLba;
        }
        NVCACHE_PRIORITY_LEVEL_DESCRIPTOR[1] Priority; // Flexible array
    }
}

struct HYBRID_DIRTY_THRESHOLDS
{
    uint Version;
    uint Size;
    uint DirtyLowThreshold;
    uint DirtyHighThreshold;
}

struct HYBRID_DEMOTE_BY_SIZE
{
    uint   Version;
    uint   Size;
    ubyte  SourcePriority;
    ubyte  TargetPriority;
    ushort Reserved0;
    uint   Reserved1;
    ulong  LbaCount;
}

struct FIRMWARE_REQUEST_BLOCK
{
    uint Version;
    uint Size;
    uint Function;
    uint Flags;
    uint DataBufferOffset;
    uint DataBufferLength;
}

struct STORAGE_FIRMWARE_SLOT_INFO
{
    ubyte    SlotNumber;
    BOOLEAN  ReadOnly;
    ubyte[6] Reserved;
    union Revision
    {
        ubyte[8] Info;
        ulong    AsUlonglong;
    }
}

struct STORAGE_FIRMWARE_SLOT_INFO_V2
{
    ubyte     SlotNumber;
    BOOLEAN   ReadOnly;
    ubyte[6]  Reserved;
    ubyte[16] Revision;
}

struct STORAGE_FIRMWARE_INFO
{
    uint    Version;
    uint    Size;
    BOOLEAN UpgradeSupport;
    ubyte   SlotCount;
    ubyte   ActiveSlot;
    ubyte   PendingActivateSlot;
    uint    Reserved;
    STORAGE_FIRMWARE_SLOT_INFO[1] Slot; // Flexible array
}

struct STORAGE_FIRMWARE_INFO_V2
{
    uint     Version;
    uint     Size;
    BOOLEAN  UpgradeSupport;
    ubyte    SlotCount;
    ubyte    ActiveSlot;
    ubyte    PendingActivateSlot;
    BOOLEAN  FirmwareShared;
    ubyte[3] Reserved;
    uint     ImagePayloadAlignment;
    uint     ImagePayloadMaxSize;
    STORAGE_FIRMWARE_SLOT_INFO_V2[1] Slot; // Flexible array
}

struct STORAGE_FIRMWARE_DOWNLOAD
{
    uint     Version;
    uint     Size;
    ulong    Offset;
    ulong    BufferSize;
    ubyte[1] ImageBuffer; // Flexible array
}

struct STORAGE_FIRMWARE_DOWNLOAD_V2
{
    uint     Version;
    uint     Size;
    ulong    Offset;
    ulong    BufferSize;
    ubyte    Slot;
    ubyte[3] Reserved;
    uint     ImageSize;
    ubyte[1] ImageBuffer; // Flexible array
}

struct STORAGE_FIRMWARE_ACTIVATE
{
    uint     Version;
    uint     Size;
    ubyte    SlotToActivate;
    ubyte[3] Reserved0;
}

struct IO_SCSI_CAPABILITIES
{
    uint    Length;
    uint    MaximumTransferLength;
    uint    MaximumPhysicalPages;
    uint    SupportedAsynchronousEvents;
    uint    AlignmentMask;
    BOOLEAN TaggedQueuing;
    BOOLEAN AdapterScansDown;
    BOOLEAN AdapterUsesPio;
}

struct SCSI_ADDRESS
{
    uint  Length;
    ubyte PortNumber;
    ubyte PathId;
    ubyte TargetId;
    ubyte Lun;
}

struct DUMP_POINTERS_VERSION
{
    uint Version;
    uint Size;
}

struct DUMP_POINTERS
{
    _ADAPTER_OBJECT* AdapterObject;
    void*            MappedRegisterBase;
    void*            DumpData;
    void*            CommonBufferVa;
    long             CommonBufferPa;
    uint             CommonBufferSize;
    BOOLEAN          AllocateCommonBuffers;
    BOOLEAN          UseDiskDump;
    ubyte[2]         Spare1;
    void*            DeviceObject;
}

struct DUMP_POINTERS_EX
{
    DUMP_POINTERS_VERSION Header;
    void*    DumpData;
    void*    CommonBufferVa;
    uint     CommonBufferSize;
    BOOLEAN  AllocateCommonBuffers;
    void*    DeviceObject;
    void*    DriverList;
    uint     dwPortFlags;
    uint     MaxDeviceDumpSectionSize;
    uint     MaxDeviceDumpLevel;
    uint     MaxTransferSize;
    void*    AdapterObject;
    void*    MappedRegisterBase;
    BOOLEAN* DeviceReady;
    PDUMP_DEVICE_POWERON_ROUTINE DumpDevicePowerOn;
    void*    DumpDevicePowerOnContext;
}

struct DUMP_DRIVER
{
    void*     DumpDriverList;
    wchar[15] DriverName;
    wchar[15] BaseName;
}

struct NTSCSI_UNICODE_STRING
{
    ushort Length;
    ushort MaximumLength;
    PWSTR  Buffer;
}

struct DUMP_DRIVER_EX
{
    void*     DumpDriverList;
    wchar[15] DriverName;
    wchar[15] BaseName;
    NTSCSI_UNICODE_STRING DriverFullPath;
}

struct STORAGE_ENDURANCE_INFO
{
    uint      ValidFields;
    uint      GroupId;
    struct Flags
    {
        // Native bit field: Shared: [0], Reserved: [1-31]
        uint _bitfield0;
    }
    uint      LifePercentage;
    ubyte[16] BytesReadCount;
    ubyte[16] ByteWriteCount;
}

struct STORAGE_ENDURANCE_DATA_DESCRIPTOR
{
    uint Version;
    uint Size;
    STORAGE_ENDURANCE_INFO EnduranceInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ns-iscsidsc-iscsi_login_options
struct ISCSI_LOGIN_OPTIONS
{
    uint               Version;
    uint               InformationSpecified;
    uint               LoginFlags;
    ISCSI_AUTH_TYPES   AuthType;
    ISCSI_DIGEST_TYPES HeaderDigest;
    ISCSI_DIGEST_TYPES DataDigest;
    uint               MaximumConnections;
    uint               DefaultTime2Wait;
    uint               DefaultTime2Retain;
    uint               UsernameLength;
    uint               PasswordLength;
    ubyte*             Username;
    ubyte*             Password;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ns-iscsidsc-ike_authentication_preshared_key
struct IKE_AUTHENTICATION_PRESHARED_KEY
{
    ulong  SecurityFlags;
    ubyte  IdType;
    uint   IdLengthInBytes;
    ubyte* Id;
    uint   KeyLengthInBytes;
    ubyte* Key;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ns-iscsidsc-ike_authentication_information
struct IKE_AUTHENTICATION_INFORMATION
{
    IKE_AUTHENTICATION_METHOD AuthMethod;
    union
    {
        IKE_AUTHENTICATION_PRESHARED_KEY PsKey;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ns-iscsidsc-iscsi_unique_session_id
struct ISCSI_UNIQUE_SESSION_ID
{
    ulong AdapterUnique;
    ulong AdapterSpecific;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ns-iscsidsc-scsi_lun_list
struct SCSI_LUN_LIST
{
    uint  OSLUN;
    ulong TargetLUN;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ns-iscsidsc-iscsi_target_mappingw
struct ISCSI_TARGET_MAPPINGW
{
    wchar[256]     InitiatorName;
    wchar[224]     TargetName;
    wchar[260]     OSDeviceName;
    ISCSI_UNIQUE_SESSION_ID SessionId;
    uint           OSBusNumber;
    uint           OSTargetNumber;
    uint           LUNCount;
    SCSI_LUN_LIST* LUNList;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ns-iscsidsc-iscsi_target_mappinga
struct ISCSI_TARGET_MAPPINGA
{
    CHAR[256]      InitiatorName;
    CHAR[224]      TargetName;
    CHAR[260]      OSDeviceName;
    ISCSI_UNIQUE_SESSION_ID SessionId;
    uint           OSBusNumber;
    uint           OSTargetNumber;
    uint           LUNCount;
    SCSI_LUN_LIST* LUNList;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ns-iscsidsc-iscsi_target_portalw
struct ISCSI_TARGET_PORTALW
{
    wchar[256] SymbolicName;
    wchar[256] Address;
    ushort     Socket;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ns-iscsidsc-iscsi_target_portala
struct ISCSI_TARGET_PORTALA
{
    CHAR[256] SymbolicName;
    CHAR[256] Address;
    ushort    Socket;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ns-iscsidsc-iscsi_target_portal_infow
struct ISCSI_TARGET_PORTAL_INFOW
{
    wchar[256] InitiatorName;
    uint       InitiatorPortNumber;
    wchar[256] SymbolicName;
    wchar[256] Address;
    ushort     Socket;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ns-iscsidsc-iscsi_target_portal_infoa
struct ISCSI_TARGET_PORTAL_INFOA
{
    CHAR[256] InitiatorName;
    uint      InitiatorPortNumber;
    CHAR[256] SymbolicName;
    CHAR[256] Address;
    ushort    Socket;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ns-iscsidsc-iscsi_target_portal_info_exw
struct ISCSI_TARGET_PORTAL_INFO_EXW
{
    wchar[256]          InitiatorName;
    uint                InitiatorPortNumber;
    wchar[256]          SymbolicName;
    wchar[256]          Address;
    ushort              Socket;
    ulong               SecurityFlags;
    ISCSI_LOGIN_OPTIONS LoginOptions;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ns-iscsidsc-iscsi_target_portal_info_exa
struct ISCSI_TARGET_PORTAL_INFO_EXA
{
    CHAR[256]           InitiatorName;
    uint                InitiatorPortNumber;
    CHAR[256]           SymbolicName;
    CHAR[256]           Address;
    ushort              Socket;
    ulong               SecurityFlags;
    ISCSI_LOGIN_OPTIONS LoginOptions;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ns-iscsidsc-iscsi_target_portal_groupw
struct ISCSI_TARGET_PORTAL_GROUPW
{
    uint Count;
    ISCSI_TARGET_PORTALW[1] Portals; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ns-iscsidsc-iscsi_target_portal_groupa
struct ISCSI_TARGET_PORTAL_GROUPA
{
    uint Count;
    ISCSI_TARGET_PORTALA[1] Portals; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ns-iscsidsc-iscsi_connection_infow
struct ISCSI_CONNECTION_INFOW
{
    ISCSI_UNIQUE_SESSION_ID ConnectionId;
    PWSTR    InitiatorAddress;
    PWSTR    TargetAddress;
    ushort   InitiatorSocket;
    ushort   TargetSocket;
    ubyte[2] CID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ns-iscsidsc-iscsi_session_infow
struct ISCSI_SESSION_INFOW
{
    ISCSI_UNIQUE_SESSION_ID SessionId;
    PWSTR    InitiatorName;
    PWSTR    TargetNodeName;
    PWSTR    TargetName;
    ubyte[6] ISID;
    ubyte[2] TSID;
    uint     ConnectionCount;
    ISCSI_CONNECTION_INFOW* Connections;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ns-iscsidsc-iscsi_connection_infoa
struct ISCSI_CONNECTION_INFOA
{
    ISCSI_UNIQUE_SESSION_ID ConnectionId;
    PSTR     InitiatorAddress;
    PSTR     TargetAddress;
    ushort   InitiatorSocket;
    ushort   TargetSocket;
    ubyte[2] CID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ns-iscsidsc-iscsi_session_infoa
struct ISCSI_SESSION_INFOA
{
    ISCSI_UNIQUE_SESSION_ID SessionId;
    PSTR     InitiatorName;
    PSTR     TargetNodeName;
    PSTR     TargetName;
    ubyte[6] ISID;
    ubyte[2] TSID;
    uint     ConnectionCount;
    ISCSI_CONNECTION_INFOA* Connections;
}

struct ISCSI_CONNECTION_INFO_EX
{
    ISCSI_UNIQUE_SESSION_ID ConnectionId;
    ubyte            State;
    ubyte            Protocol;
    ubyte            HeaderDigest;
    ubyte            DataDigest;
    uint             MaxRecvDataSegmentLength;
    ISCSI_AUTH_TYPES AuthType;
    ulong            EstimatedThroughput;
    uint             MaxDatagramSize;
}

struct ISCSI_SESSION_INFO_EX
{
    ISCSI_UNIQUE_SESSION_ID SessionId;
    BOOLEAN InitialR2t;
    BOOLEAN ImmediateData;
    ubyte   Type;
    BOOLEAN DataSequenceInOrder;
    BOOLEAN DataPduInOrder;
    ubyte   ErrorRecoveryLevel;
    uint    MaxOutstandingR2t;
    uint    FirstBurstLength;
    uint    MaxBurstLength;
    uint    MaximumConnections;
    uint    ConnectionCount;
    ISCSI_CONNECTION_INFO_EX* Connections;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ns-iscsidsc-iscsi_device_on_sessionw
struct ISCSI_DEVICE_ON_SESSIONW
{
    wchar[256]   InitiatorName;
    wchar[224]   TargetName;
    SCSI_ADDRESS ScsiAddress;
    GUID         DeviceInterfaceType;
    wchar[260]   DeviceInterfaceName;
    wchar[260]   LegacyName;
    STORAGE_DEVICE_NUMBER StorageDeviceNumber;
    uint         DeviceInstance;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ns-iscsidsc-iscsi_device_on_sessiona
struct ISCSI_DEVICE_ON_SESSIONA
{
    CHAR[256]    InitiatorName;
    CHAR[224]    TargetName;
    SCSI_ADDRESS ScsiAddress;
    GUID         DeviceInterfaceType;
    CHAR[260]    DeviceInterfaceName;
    CHAR[260]    LegacyName;
    STORAGE_DEVICE_NUMBER StorageDeviceNumber;
    uint         DeviceInstance;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ns-iscsidsc-persistent_iscsi_login_infow
struct PERSISTENT_ISCSI_LOGIN_INFOW
{
    wchar[224]           TargetName;
    BOOLEAN              IsInformationalSession;
    wchar[256]           InitiatorInstance;
    uint                 InitiatorPortNumber;
    ISCSI_TARGET_PORTALW TargetPortal;
    ulong                SecurityFlags;
    ISCSI_TARGET_MAPPINGW* Mappings;
    ISCSI_LOGIN_OPTIONS  LoginOptions;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ns-iscsidsc-persistent_iscsi_login_infoa
struct PERSISTENT_ISCSI_LOGIN_INFOA
{
    CHAR[224]            TargetName;
    BOOLEAN              IsInformationalSession;
    CHAR[256]            InitiatorInstance;
    uint                 InitiatorPortNumber;
    ISCSI_TARGET_PORTALA TargetPortal;
    ulong                SecurityFlags;
    ISCSI_TARGET_MAPPINGA* Mappings;
    ISCSI_LOGIN_OPTIONS  LoginOptions;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iscsidsc/ns-iscsidsc-iscsi_version_info
struct ISCSI_VERSION_INFO
{
    uint MajorVersion;
    uint MinorVersion;
    uint BuildNumber;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint GetIScsiVersionInformation(ISCSI_VERSION_INFO* VersionInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint GetIScsiTargetInformationW(PWSTR TargetName, PWSTR DiscoveryMechanism, TARGET_INFORMATION_CLASS InfoClass, 
                                uint* BufferSize, void* Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint GetIScsiTargetInformationA(PSTR TargetName, PSTR DiscoveryMechanism, TARGET_INFORMATION_CLASS InfoClass, 
                                uint* BufferSize, void* Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint AddIScsiConnectionW(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, void* Reserved, uint InitiatorPortNumber, 
                         ISCSI_TARGET_PORTALW* TargetPortal, ulong SecurityFlags, ISCSI_LOGIN_OPTIONS* LoginOptions, 
                         uint KeySize, 
                         /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR Key, 
                         ISCSI_UNIQUE_SESSION_ID* ConnectionId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint AddIScsiConnectionA(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, void* Reserved, uint InitiatorPortNumber, 
                         ISCSI_TARGET_PORTALA* TargetPortal, ulong SecurityFlags, ISCSI_LOGIN_OPTIONS* LoginOptions, 
                         uint KeySize, 
                         /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR Key, 
                         ISCSI_UNIQUE_SESSION_ID* ConnectionId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint RemoveIScsiConnection(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, ISCSI_UNIQUE_SESSION_ID* ConnectionId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint ReportIScsiTargetsW(BOOLEAN ForceUpdate, uint* BufferSize, 
                         /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint ReportIScsiTargetsA(BOOLEAN ForceUpdate, uint* BufferSize, 
                         /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint AddIScsiStaticTargetW(PWSTR TargetName, PWSTR TargetAlias, uint TargetFlags, BOOLEAN Persist, 
                           ISCSI_TARGET_MAPPINGW* Mappings, ISCSI_LOGIN_OPTIONS* LoginOptions, 
                           ISCSI_TARGET_PORTAL_GROUPW* PortalGroup);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint AddIScsiStaticTargetA(PSTR TargetName, PSTR TargetAlias, uint TargetFlags, BOOLEAN Persist, 
                           ISCSI_TARGET_MAPPINGA* Mappings, ISCSI_LOGIN_OPTIONS* LoginOptions, 
                           ISCSI_TARGET_PORTAL_GROUPA* PortalGroup);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint RemoveIScsiStaticTargetW(PWSTR TargetName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint RemoveIScsiStaticTargetA(PSTR TargetName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint AddIScsiSendTargetPortalW(PWSTR InitiatorInstance, uint InitiatorPortNumber, 
                               ISCSI_LOGIN_OPTIONS* LoginOptions, ulong SecurityFlags, ISCSI_TARGET_PORTALW* Portal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint AddIScsiSendTargetPortalA(PSTR InitiatorInstance, uint InitiatorPortNumber, ISCSI_LOGIN_OPTIONS* LoginOptions, 
                               ulong SecurityFlags, ISCSI_TARGET_PORTALA* Portal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint RemoveIScsiSendTargetPortalW(PWSTR InitiatorInstance, uint InitiatorPortNumber, ISCSI_TARGET_PORTALW* Portal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint RemoveIScsiSendTargetPortalA(PSTR InitiatorInstance, uint InitiatorPortNumber, ISCSI_TARGET_PORTALA* Portal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint RefreshIScsiSendTargetPortalW(PWSTR InitiatorInstance, uint InitiatorPortNumber, ISCSI_TARGET_PORTALW* Portal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint RefreshIScsiSendTargetPortalA(PSTR InitiatorInstance, uint InitiatorPortNumber, ISCSI_TARGET_PORTALA* Portal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint ReportIScsiSendTargetPortalsW(uint* PortalCount, ISCSI_TARGET_PORTAL_INFOW* PortalInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint ReportIScsiSendTargetPortalsA(uint* PortalCount, ISCSI_TARGET_PORTAL_INFOA* PortalInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint ReportIScsiSendTargetPortalsExW(uint* PortalCount, uint* PortalInfoSize, 
                                     ISCSI_TARGET_PORTAL_INFO_EXW* PortalInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint ReportIScsiSendTargetPortalsExA(uint* PortalCount, uint* PortalInfoSize, 
                                     ISCSI_TARGET_PORTAL_INFO_EXA* PortalInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint LoginIScsiTargetW(PWSTR TargetName, BOOLEAN IsInformationalSession, PWSTR InitiatorInstance, 
                       uint InitiatorPortNumber, ISCSI_TARGET_PORTALW* TargetPortal, ulong SecurityFlags, 
                       ISCSI_TARGET_MAPPINGW* Mappings, ISCSI_LOGIN_OPTIONS* LoginOptions, uint KeySize, 
                       /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR Key, 
                       BOOLEAN IsPersistent, ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, 
                       ISCSI_UNIQUE_SESSION_ID* UniqueConnectionId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint LoginIScsiTargetA(PSTR TargetName, BOOLEAN IsInformationalSession, PSTR InitiatorInstance, 
                       uint InitiatorPortNumber, ISCSI_TARGET_PORTALA* TargetPortal, ulong SecurityFlags, 
                       ISCSI_TARGET_MAPPINGA* Mappings, ISCSI_LOGIN_OPTIONS* LoginOptions, uint KeySize, 
                       /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR Key, 
                       BOOLEAN IsPersistent, ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, 
                       ISCSI_UNIQUE_SESSION_ID* UniqueConnectionId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint ReportIScsiPersistentLoginsW(uint* Count, PERSISTENT_ISCSI_LOGIN_INFOW* PersistentLoginInfo, 
                                  uint* BufferSizeInBytes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint ReportIScsiPersistentLoginsA(uint* Count, PERSISTENT_ISCSI_LOGIN_INFOA* PersistentLoginInfo, 
                                  uint* BufferSizeInBytes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint LogoutIScsiTarget(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint RemoveIScsiPersistentTargetW(PWSTR InitiatorInstance, uint InitiatorPortNumber, PWSTR TargetName, 
                                  ISCSI_TARGET_PORTALW* Portal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint RemoveIScsiPersistentTargetA(PSTR InitiatorInstance, uint InitiatorPortNumber, PSTR TargetName, 
                                  ISCSI_TARGET_PORTALA* Portal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint SendScsiInquiry(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, ulong Lun, ubyte EvpdCmddt, ubyte PageCode, 
                     ubyte* ScsiStatus, uint* ResponseSize, ubyte* ResponseBuffer, uint* SenseSize, 
                     ubyte* SenseBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint SendScsiReadCapacity(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, ulong Lun, ubyte* ScsiStatus, 
                          uint* ResponseSize, ubyte* ResponseBuffer, uint* SenseSize, ubyte* SenseBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint SendScsiReportLuns(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, ubyte* ScsiStatus, uint* ResponseSize, 
                        ubyte* ResponseBuffer, uint* SenseSize, ubyte* SenseBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint ReportIScsiInitiatorListW(uint* BufferSize, 
                               /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint ReportIScsiInitiatorListA(uint* BufferSize, 
                               /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint ReportActiveIScsiTargetMappingsW(uint* BufferSize, uint* MappingCount, ISCSI_TARGET_MAPPINGW* Mappings);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint ReportActiveIScsiTargetMappingsA(uint* BufferSize, uint* MappingCount, ISCSI_TARGET_MAPPINGA* Mappings);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint SetIScsiTunnelModeOuterAddressW(PWSTR InitiatorName, uint InitiatorPortNumber, PWSTR DestinationAddress, 
                                     PWSTR OuterModeAddress, BOOLEAN Persist);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint SetIScsiTunnelModeOuterAddressA(PSTR InitiatorName, uint InitiatorPortNumber, PSTR DestinationAddress, 
                                     PSTR OuterModeAddress, BOOLEAN Persist);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint SetIScsiIKEInfoW(PWSTR InitiatorName, uint InitiatorPortNumber, IKE_AUTHENTICATION_INFORMATION* AuthInfo, 
                      BOOLEAN Persist);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint SetIScsiIKEInfoA(PSTR InitiatorName, uint InitiatorPortNumber, IKE_AUTHENTICATION_INFORMATION* AuthInfo, 
                      BOOLEAN Persist);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint GetIScsiIKEInfoW(PWSTR InitiatorName, uint InitiatorPortNumber, uint* Reserved, 
                      IKE_AUTHENTICATION_INFORMATION* AuthInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint GetIScsiIKEInfoA(PSTR InitiatorName, uint InitiatorPortNumber, uint* Reserved, 
                      IKE_AUTHENTICATION_INFORMATION* AuthInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint SetIScsiGroupPresharedKey(uint KeyLength, ubyte* Key, BOOLEAN Persist);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint SetIScsiInitiatorCHAPSharedSecret(uint SharedSecretLength, ubyte* SharedSecret);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint SetIScsiInitiatorRADIUSSharedSecret(uint SharedSecretLength, ubyte* SharedSecret);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint SetIScsiInitiatorNodeNameW(PWSTR InitiatorNodeName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint SetIScsiInitiatorNodeNameA(PSTR InitiatorNodeName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint GetIScsiInitiatorNodeNameW(/*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR InitiatorNodeName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint GetIScsiInitiatorNodeNameA(/*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR InitiatorNodeName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint AddISNSServerW(PWSTR Address);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint AddISNSServerA(PSTR Address);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint RemoveISNSServerW(PWSTR Address);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint RemoveISNSServerA(PSTR Address);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint RefreshISNSServerW(PWSTR Address);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint RefreshISNSServerA(PSTR Address);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint ReportISNSServerListW(uint* BufferSizeInChar, 
                           /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint ReportISNSServerListA(uint* BufferSizeInChar, 
                           /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint GetIScsiSessionListW(uint* BufferSize, uint* SessionCount, ISCSI_SESSION_INFOW* SessionInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint GetIScsiSessionListA(uint* BufferSize, uint* SessionCount, ISCSI_SESSION_INFOA* SessionInfo);

@DllImport("ISCSIDSC.dll")
uint GetIScsiSessionListEx(uint* BufferSize, uint* SessionCountPtr, ISCSI_SESSION_INFO_EX* SessionInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint GetDevicesForIScsiSessionW(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, uint* DeviceCount, 
                                ISCSI_DEVICE_ON_SESSIONW* Devices);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint GetDevicesForIScsiSessionA(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, uint* DeviceCount, 
                                ISCSI_DEVICE_ON_SESSIONA* Devices);

@DllImport("ISCSIDSC.dll")
uint SetupPersistentIScsiVolumes();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint SetupPersistentIScsiDevices();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint AddPersistentIScsiDeviceW(PWSTR DevicePath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint AddPersistentIScsiDeviceA(PSTR DevicePath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint RemovePersistentIScsiDeviceW(PWSTR DevicePath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint RemovePersistentIScsiDeviceA(PSTR DevicePath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint ClearPersistentIScsiDevices();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint ReportPersistentIScsiDevicesW(uint* BufferSizeInChar, 
                                   /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint ReportPersistentIScsiDevicesA(uint* BufferSizeInChar, 
                                   /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint ReportIScsiTargetPortalsW(PWSTR InitiatorName, PWSTR TargetName, ushort* TargetPortalTag, uint* ElementCount, 
                               ISCSI_TARGET_PORTALW* Portals);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint ReportIScsiTargetPortalsA(PSTR InitiatorName, PSTR TargetName, ushort* TargetPortalTag, uint* ElementCount, 
                               ISCSI_TARGET_PORTALA* Portals);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint AddRadiusServerW(PWSTR Address);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint AddRadiusServerA(PSTR Address);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint RemoveRadiusServerW(PWSTR Address);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint RemoveRadiusServerA(PSTR Address);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint ReportRadiusServerListW(uint* BufferSizeInChar, 
                             /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ISCSIDSC.dll")
uint ReportRadiusServerListA(uint* BufferSizeInChar, 
                             /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR Buffer);


