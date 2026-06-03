// Written in the D programming language.

module windows.win32.system.ioctl;

public import windows.core;
public import windows.win32.foundation : BOOLEAN, CHAR, DEVPROPKEY, HANDLE;
public import windows.win32.security : SID;
public import windows.win32.storage.filesystem : FILE_ID_128, STORAGE_BUS_TYPE;
public import windows.win32.storage.vhd : VIRTUAL_STORAGE_TYPE;

extern(Windows) @nogc nothrow:


// Enums


alias GPT_ATTRIBUTES = ulong;
enum : ulong
{
    GPT_ATTRIBUTE_PLATFORM_REQUIRED          = 0x0000000000000001UL,
    GPT_BASIC_DATA_ATTRIBUTE_NO_DRIVE_LETTER = 0x8000000000000000UL,
    GPT_BASIC_DATA_ATTRIBUTE_HIDDEN          = 0x4000000000000000UL,
    GPT_BASIC_DATA_ATTRIBUTE_SHADOW_COPY     = 0x2000000000000000UL,
    GPT_BASIC_DATA_ATTRIBUTE_READ_ONLY       = 0x1000000000000000UL,
}

alias USN_DELETE_FLAGS = uint;
enum : uint
{
    USN_DELETE_FLAG_DELETE = 0x00000001U,
    USN_DELETE_FLAG_NOTIFY = 0x00000002U,
}

alias CHANGER_FEATURES = uint;
enum : uint
{
    CHANGER_BAR_CODE_SCANNER_INSTALLED  = 0x00000001U,
    CHANGER_CARTRIDGE_MAGAZINE          = 0x00000100U,
    CHANGER_CLEANER_ACCESS_NOT_VALID    = 0x00040000U,
    CHANGER_CLEANER_SLOT                = 0x00000040U,
    CHANGER_CLOSE_IEPORT                = 0x00000004U,
    CHANGER_DEVICE_REINITIALIZE_CAPABLE = 0x08000000U,
    CHANGER_DRIVE_CLEANING_REQUIRED     = 0x00010000U,
    CHANGER_DRIVE_EMPTY_ON_DOOR_ACCESS  = 0x20000000U,
    CHANGER_EXCHANGE_MEDIA              = 0x00000020U,
    CHANGER_INIT_ELEM_STAT_WITH_RANGE   = 0x00000002U,
    CHANGER_KEYPAD_ENABLE_DISABLE       = 0x10000000U,
    CHANGER_LOCK_UNLOCK                 = 0x00000080U,
    CHANGER_MEDIUM_FLIP                 = 0x00000200U,
    CHANGER_OPEN_IEPORT                 = 0x00000008U,
    CHANGER_POSITION_TO_ELEMENT         = 0x00000400U,
    CHANGER_PREDISMOUNT_EJECT_REQUIRED  = 0x00020000U,
    CHANGER_PREMOUNT_EJECT_REQUIRED     = 0x00080000U,
    CHANGER_REPORT_IEPORT_STATE         = 0x00000800U,
    CHANGER_SERIAL_NUMBER_VALID         = 0x04000000U,
    CHANGER_STATUS_NON_VOLATILE         = 0x00000010U,
    CHANGER_STORAGE_DRIVE               = 0x00001000U,
    CHANGER_STORAGE_IEPORT              = 0x00002000U,
    CHANGER_STORAGE_SLOT                = 0x00004000U,
    CHANGER_STORAGE_TRANSPORT           = 0x00008000U,
    CHANGER_VOLUME_ASSERT               = 0x00400000U,
    CHANGER_VOLUME_IDENTIFICATION       = 0x00100000U,
    CHANGER_VOLUME_REPLACE              = 0x00800000U,
    CHANGER_VOLUME_SEARCH               = 0x00200000U,
    CHANGER_VOLUME_UNDEFINE             = 0x01000000U,
}

alias TXFS_RMF_LAGS = uint;
enum : uint
{
    TXFS_RM_FLAG_LOGGING_MODE                        = 0x00000001U,
    TXFS_RM_FLAG_RENAME_RM                           = 0x00000002U,
    TXFS_RM_FLAG_LOG_CONTAINER_COUNT_MAX             = 0x00000004U,
    TXFS_RM_FLAG_LOG_CONTAINER_COUNT_MIN             = 0x00000008U,
    TXFS_RM_FLAG_LOG_GROWTH_INCREMENT_NUM_CONTAINERS = 0x00000010U,
    TXFS_RM_FLAG_LOG_GROWTH_INCREMENT_PERCENT        = 0x00000020U,
    TXFS_RM_FLAG_LOG_AUTO_SHRINK_PERCENTAGE          = 0x00000040U,
    TXFS_RM_FLAG_LOG_NO_CONTAINER_COUNT_MAX          = 0x00000080U,
    TXFS_RM_FLAG_LOG_NO_CONTAINER_COUNT_MIN          = 0x00000100U,
    TXFS_RM_FLAG_GROW_LOG                            = 0x00000400U,
    TXFS_RM_FLAG_SHRINK_LOG                          = 0x00000800U,
    TXFS_RM_FLAG_ENFORCE_MINIMUM_SIZE                = 0x00001000U,
    TXFS_RM_FLAG_PRESERVE_CHANGES                    = 0x00002000U,
    TXFS_RM_FLAG_RESET_RM_AT_NEXT_START              = 0x00004000U,
    TXFS_RM_FLAG_DO_NOT_RESET_RM_AT_NEXT_START       = 0x00008000U,
    TXFS_RM_FLAG_PREFER_CONSISTENCY                  = 0x00010000U,
    TXFS_RM_FLAG_PREFER_AVAILABILITY                 = 0x00020000U,
}

alias FILESYSTEM_STATISTICS_TYPE = ushort;
enum : ushort
{
    FILESYSTEM_STATISTICS_TYPE_EXFAT = cast(ushort) 0x0003,
    FILESYSTEM_STATISTICS_TYPE_FAT   = cast(ushort) 0x0002,
    FILESYSTEM_STATISTICS_TYPE_NTFS  = cast(ushort) 0x0001,
}

alias USN_SOURCE_INFO_ID = uint;
enum : uint
{
    USN_SOURCE_AUXILIARY_DATA                = 0x00000002U,
    USN_SOURCE_DATA_MANAGEMENT               = 0x00000001U,
    USN_SOURCE_REPLICATION_MANAGEMENT        = 0x00000004U,
    USN_SOURCE_CLIENT_REPLICATION_MANAGEMENT = 0x00000008U,
}

alias FILE_STORAGE_TIER_FLAGS = uint;
enum : uint
{
    FILE_STORAGE_TIER_FLAG_NO_SEEK_PENALTY = 0x00020000U,
}

alias CHANGER_ELEMENT_STATUS_FLAGS = uint;
enum : uint
{
    ELEMENT_STATUS_ACCESS       = 0x00000008U,
    ELEMENT_STATUS_AVOLTAG      = 0x20000000U,
    ELEMENT_STATUS_EXCEPT       = 0x00000004U,
    ELEMENT_STATUS_EXENAB       = 0x00000010U,
    ELEMENT_STATUS_FULL         = 0x00000001U,
    ELEMENT_STATUS_ID_VALID     = 0x00002000U,
    ELEMENT_STATUS_IMPEXP       = 0x00000002U,
    ELEMENT_STATUS_INENAB       = 0x00000020U,
    ELEMENT_STATUS_INVERT       = 0x00400000U,
    ELEMENT_STATUS_LUN_VALID    = 0x00001000U,
    ELEMENT_STATUS_NOT_BUS      = 0x00008000U,
    ELEMENT_STATUS_PVOLTAG      = 0x10000000U,
    ELEMENT_STATUS_SVALID       = 0x00800000U,
    ELEMENT_STATUS_PRODUCT_DATA = 0x00000040U,
}

alias GET_CHANGER_PARAMETERS_FEATURES1 = uint;
enum : uint
{
    CHANGER_CLEANER_AUTODISMOUNT       = 0x80000004U,
    CHANGER_CLEANER_OPS_NOT_SUPPORTED  = 0x80000040U,
    CHANGER_IEPORT_USER_CONTROL_CLOSE  = 0x80000100U,
    CHANGER_IEPORT_USER_CONTROL_OPEN   = 0x80000080U,
    CHANGER_MOVE_EXTENDS_IEPORT        = 0x80000200U,
    CHANGER_MOVE_RETRACTS_IEPORT       = 0x80000400U,
    CHANGER_PREDISMOUNT_ALIGN_TO_DRIVE = 0x80000002U,
    CHANGER_PREDISMOUNT_ALIGN_TO_SLOT  = 0x80000001U,
    CHANGER_RTN_MEDIA_TO_ORIGINAL_ADDR = 0x80000020U,
    CHANGER_SLOTS_USE_TRAYS            = 0x80000010U,
    CHANGER_TRUE_EXCHANGE_CAPABLE      = 0x80000008U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ne-winioctl-storage_media_type
alias STORAGE_MEDIA_TYPE = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ne-winioctl-storage_query_type
alias STORAGE_QUERY_TYPE = int;
enum : int
{
    PropertyStandardQuery   = 0x00000000,
    PropertyExistsQuery     = 0x00000001,
    PropertyMaskQuery       = 0x00000002,
    PropertyQueryMaxDefined = 0x00000003,
}

alias STORAGE_SET_TYPE = int;
enum : int
{
    PropertyStandardSet   = 0x00000000,
    PropertyExistsSet     = 0x00000001,
    PropertySetMaxDefined = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ne-winioctl-storage_property_id
alias STORAGE_PROPERTY_ID = int;
enum : int
{
    StorageDeviceProperty                    = 0x00000000,
    StorageAdapterProperty                   = 0x00000001,
    StorageDeviceIdProperty                  = 0x00000002,
    StorageDeviceUniqueIdProperty            = 0x00000003,
    StorageDeviceWriteCacheProperty          = 0x00000004,
    StorageMiniportProperty                  = 0x00000005,
    StorageAccessAlignmentProperty           = 0x00000006,
    StorageDeviceSeekPenaltyProperty         = 0x00000007,
    StorageDeviceTrimProperty                = 0x00000008,
    StorageDeviceWriteAggregationProperty    = 0x00000009,
    StorageDeviceDeviceTelemetryProperty     = 0x0000000a,
    StorageDeviceLBProvisioningProperty      = 0x0000000b,
    StorageDevicePowerProperty               = 0x0000000c,
    StorageDeviceCopyOffloadProperty         = 0x0000000d,
    StorageDeviceResiliencyProperty          = 0x0000000e,
    StorageDeviceMediumProductType           = 0x0000000f,
    StorageAdapterRpmbProperty               = 0x00000010,
    StorageAdapterCryptoProperty             = 0x00000011,
    StorageDeviceIoCapabilityProperty        = 0x00000030,
    StorageAdapterProtocolSpecificProperty   = 0x00000031,
    StorageDeviceProtocolSpecificProperty    = 0x00000032,
    StorageAdapterTemperatureProperty        = 0x00000033,
    StorageDeviceTemperatureProperty         = 0x00000034,
    StorageAdapterPhysicalTopologyProperty   = 0x00000035,
    StorageDevicePhysicalTopologyProperty    = 0x00000036,
    StorageDeviceAttributesProperty          = 0x00000037,
    StorageDeviceManagementStatus            = 0x00000038,
    StorageAdapterSerialNumberProperty       = 0x00000039,
    StorageDeviceLocationProperty            = 0x0000003a,
    StorageDeviceNumaProperty                = 0x0000003b,
    StorageDeviceZonedDeviceProperty         = 0x0000003c,
    StorageDeviceUnsafeShutdownCount         = 0x0000003d,
    StorageDeviceEnduranceProperty           = 0x0000003e,
    StorageDeviceLedStateProperty            = 0x0000003f,
    StorageDeviceSelfEncryptionProperty      = 0x00000040,
    StorageFruIdProperty                     = 0x00000041,
    StorageStackProperty                     = 0x00000042,
    StorageAdapterProtocolSpecificPropertyEx = 0x00000043,
    StorageDeviceProtocolSpecificPropertyEx  = 0x00000044,
    StorageHwCryptoProperty                  = 0x00000045,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ne-winioctl-storage_port_code_set
alias STORAGE_PORT_CODE_SET = int;
enum : int
{
    StoragePortCodeSetReserved  = 0x00000000,
    StoragePortCodeSetStorport  = 0x00000001,
    StoragePortCodeSetSCSIport  = 0x00000002,
    StoragePortCodeSetSpaceport = 0x00000003,
    StoragePortCodeSetATAport   = 0x00000004,
    StoragePortCodeSetUSBport   = 0x00000005,
    StoragePortCodeSetSBP2port  = 0x00000006,
    StoragePortCodeSetSDport    = 0x00000007,
}

alias STORAGE_IDENTIFIER_CODE_SET = int;
enum : int
{
    StorageIdCodeSetReserved = 0x00000000,
    StorageIdCodeSetBinary   = 0x00000001,
    StorageIdCodeSetAscii    = 0x00000002,
    StorageIdCodeSetUtf8     = 0x00000003,
}

alias STORAGE_IDENTIFIER_TYPE = int;
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

alias STORAGE_ID_NAA_FORMAT = int;
enum : int
{
    StorageIdNAAFormatIEEEExtended            = 0x00000002,
    StorageIdNAAFormatIEEERegistered          = 0x00000003,
    StorageIdNAAFormatIEEEERegisteredExtended = 0x00000005,
}

alias STORAGE_ASSOCIATION_TYPE = int;
enum : int
{
    StorageIdAssocDevice = 0x00000000,
    StorageIdAssocPort   = 0x00000001,
    StorageIdAssocTarget = 0x00000002,
}

alias STORAGE_RPMB_FRAME_TYPE = int;
enum : int
{
    StorageRpmbFrameTypeUnknown  = 0x00000000,
    StorageRpmbFrameTypeStandard = 0x00000001,
    StorageRpmbFrameTypeMax      = 0x00000002,
}

alias STORAGE_CRYPTO_ALGORITHM_ID = int;
enum : int
{
    StorageCryptoAlgorithmUnknown         = 0x00000000,
    StorageCryptoAlgorithmXTSAES          = 0x00000001,
    StorageCryptoAlgorithmBitlockerAESCBC = 0x00000002,
    StorageCryptoAlgorithmAESECB          = 0x00000003,
    StorageCryptoAlgorithmESSIVAESCBC     = 0x00000004,
    StorageCryptoAlgorithmMax             = 0x00000005,
    StorCryptoAlgorithmUnknown            = 0x00000000,
    StorCryptoAlgorithmXTSAES             = 0x00000001,
    StorCryptoAlgorithmBitlockerAESCBC    = 0x00000002,
    StorCryptoAlgorithmAESECB             = 0x00000003,
    StorCryptoAlgorithmESSIVAESCBC        = 0x00000004,
}

alias STORAGE_CRYPTO_KEY_SIZE = int;
enum : int
{
    StorageCryptoKeySizeUnknown = 0x00000000,
    StorageCryptoKeySize128Bits = 0x00000001,
    StorageCryptoKeySize192Bits = 0x00000002,
    StorageCryptoKeySize256Bits = 0x00000003,
    StorageCryptoKeySize512Bits = 0x00000004,
    StorageCryptoKeySizeMax     = 0x00000005,
    StorCryptoKeySizeUnknown    = 0x00000000,
    StorCryptoKeySize128Bits    = 0x00000001,
    StorCryptoKeySize192Bits    = 0x00000002,
    StorCryptoKeySize256Bits    = 0x00000003,
    StorCryptoKeySize512Bits    = 0x00000004,
}

alias STORAGE_ICE_TYPE = int;
enum : int
{
    StorageIceTypeUnknown = 0x00000000,
    StorageIceTypeUfs     = 0x00000001,
    StorageIceTypeNvme    = 0x00000002,
}

alias STORAGE_TIER_MEDIA_TYPE = int;
enum : int
{
    StorageTierMediaTypeUnspecified = 0x00000000,
    StorageTierMediaTypeDisk        = 0x00000001,
    StorageTierMediaTypeSsd         = 0x00000002,
    StorageTierMediaTypeScm         = 0x00000004,
    StorageTierMediaTypeMax         = 0x00000005,
}

alias STORAGE_TIER_CLASS = int;
enum : int
{
    StorageTierClassUnspecified = 0x00000000,
    StorageTierClassCapacity    = 0x00000001,
    StorageTierClassPerformance = 0x00000002,
    StorageTierClassMax         = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ne-winioctl-storage_protocol_type
alias STORAGE_PROTOCOL_TYPE = int;
enum : int
{
    ProtocolTypeUnknown     = 0x00000000,
    ProtocolTypeScsi        = 0x00000001,
    ProtocolTypeAta         = 0x00000002,
    ProtocolTypeNvme        = 0x00000003,
    ProtocolTypeSd          = 0x00000004,
    ProtocolTypeUfs         = 0x00000005,
    ProtocolTypeProprietary = 0x0000007e,
    ProtocolTypeMaxReserved = 0x0000007f,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ne-winioctl-storage_protocol_nvme_data_type
alias STORAGE_PROTOCOL_NVME_DATA_TYPE = int;
enum : int
{
    NVMeDataTypeUnknown   = 0x00000000,
    NVMeDataTypeIdentify  = 0x00000001,
    NVMeDataTypeLogPage   = 0x00000002,
    NVMeDataTypeFeature   = 0x00000003,
    NVMeDataTypeLogPageEx = 0x00000004,
    NVMeDataTypeFeatureEx = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ne-winioctl-storage_protocol_ata_data_type
alias STORAGE_PROTOCOL_ATA_DATA_TYPE = int;
enum : int
{
    AtaDataTypeUnknown  = 0x00000000,
    AtaDataTypeIdentify = 0x00000001,
    AtaDataTypeLogPage  = 0x00000002,
}

alias STORAGE_PROTOCOL_UFS_DATA_TYPE = int;
enum : int
{
    UfsDataTypeUnknown               = 0x00000000,
    UfsDataTypeQueryDescriptor       = 0x00000001,
    UfsDataTypeQueryAttribute        = 0x00000002,
    UfsDataTypeQueryFlag             = 0x00000003,
    UfsDataTypeQueryDmeAttribute     = 0x00000004,
    UfsDataTypeQueryDmePeerAttribute = 0x00000005,
    UfsDataTypeMax                   = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ne-winioctl-storage_device_form_factor
alias STORAGE_DEVICE_FORM_FACTOR = int;
enum : int
{
    FormFactorUnknown    = 0x00000000,
    FormFactor3_5        = 0x00000001,
    FormFactor2_5        = 0x00000002,
    FormFactor1_8        = 0x00000003,
    FormFactor1_8Less    = 0x00000004,
    FormFactorEmbedded   = 0x00000005,
    FormFactorMemoryCard = 0x00000006,
    FormFactormSata      = 0x00000007,
    FormFactorM_2        = 0x00000008,
    FormFactorPCIeBoard  = 0x00000009,
    FormFactorDimm       = 0x0000000a,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ne-winioctl-storage_component_health_status
alias STORAGE_COMPONENT_HEALTH_STATUS = int;
enum : int
{
    HealthStatusUnknown   = 0x00000000,
    HealthStatusNormal    = 0x00000001,
    HealthStatusThrottled = 0x00000002,
    HealthStatusWarning   = 0x00000003,
    HealthStatusDisabled  = 0x00000004,
    HealthStatusFailed    = 0x00000005,
}

alias STORAGE_DISK_HEALTH_STATUS = int;
enum : int
{
    DiskHealthUnknown   = 0x00000000,
    DiskHealthUnhealthy = 0x00000001,
    DiskHealthWarning   = 0x00000002,
    DiskHealthHealthy   = 0x00000003,
    DiskHealthMax       = 0x00000004,
}

alias STORAGE_DISK_OPERATIONAL_STATUS = int;
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

alias STORAGE_OPERATIONAL_STATUS_REASON = int;
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

alias STORAGE_ZONED_DEVICE_TYPES = int;
enum : int
{
    ZonedDeviceTypeUnknown       = 0x00000000,
    ZonedDeviceTypeHostManaged   = 0x00000001,
    ZonedDeviceTypeHostAware     = 0x00000002,
    ZonedDeviceTypeDeviceManaged = 0x00000003,
}

alias STORAGE_ZONE_TYPES = int;
enum : int
{
    ZoneTypeUnknown                  = 0x00000000,
    ZoneTypeConventional             = 0x00000001,
    ZoneTypeSequentialWriteRequired  = 0x00000002,
    ZoneTypeSequentialWritePreferred = 0x00000003,
    ZoneTypeMax                      = 0x00000004,
}

alias STORAGE_STACK_TYPE = int;
enum : int
{
    StorageStackTypeUnknown = 0x00000000,
    StorageStackTypeScsi    = 0x00000001,
    StorageStackTypeNVMe    = 0x00000002,
}

alias STORAGE_ENCRYPTION_TYPE = int;
enum : int
{
    StorageEncryptionTypeUnknown = 0x00000000,
    StorageEncryptionTypeEDrive  = 0x00000001,
    StorageEncryptionTypeTcgOpal = 0x00000002,
}

alias STORAGE_ZONES_ATTRIBUTES = int;
enum : int
{
    ZonesAttributeTypeAndLengthMayDifferent       = 0x00000000,
    ZonesAttributeTypeSameLengthSame              = 0x00000001,
    ZonesAttributeTypeSameLastZoneLengthDifferent = 0x00000002,
    ZonesAttributeTypeMayDifferentLengthSame      = 0x00000003,
}

alias STORAGE_ZONE_CONDITION = int;
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

alias STORAGE_DIAGNOSTIC_LEVEL = int;
enum : int
{
    StorageDiagnosticLevelDefault = 0x00000000,
    StorageDiagnosticLevelMax     = 0x00000001,
}

alias STORAGE_DIAGNOSTIC_TARGET_TYPE = int;
enum : int
{
    StorageDiagnosticTargetTypeUndefined   = 0x00000000,
    StorageDiagnosticTargetTypePort        = 0x00000001,
    StorageDiagnosticTargetTypeMiniport    = 0x00000002,
    StorageDiagnosticTargetTypeHbaFirmware = 0x00000003,
    StorageDiagnosticTargetTypeMax         = 0x00000004,
}

alias DEVICE_INTERNAL_STATUS_DATA_REQUEST_TYPE = int;
enum : int
{
    DeviceInternalStatusDataRequestTypeUndefined = 0x00000000,
    DeviceCurrentInternalStatusDataHeader        = 0x00000001,
    DeviceCurrentInternalStatusData              = 0x00000002,
    DeviceSavedInternalStatusDataHeader          = 0x00000003,
    DeviceSavedInternalStatusData                = 0x00000004,
}

alias DEVICE_INTERNAL_STATUS_DATA_SET = int;
enum : int
{
    DeviceStatusDataSetUndefined = 0x00000000,
    DeviceStatusDataSet1         = 0x00000001,
    DeviceStatusDataSet2         = 0x00000002,
    DeviceStatusDataSet3         = 0x00000003,
    DeviceStatusDataSet4         = 0x00000004,
    DeviceStatusDataSetMax       = 0x00000005,
}

alias STORAGE_SANITIZE_METHOD = int;
enum : int
{
    StorageSanitizeMethodDefault     = 0x00000000,
    StorageSanitizeMethodBlockErase  = 0x00000001,
    StorageSanitizeMethodCryptoErase = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ne-winioctl-write_cache_type
alias WRITE_CACHE_TYPE = int;
enum : int
{
    WriteCacheTypeUnknown      = 0x00000000,
    WriteCacheTypeNone         = 0x00000001,
    WriteCacheTypeWriteBack    = 0x00000002,
    WriteCacheTypeWriteThrough = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ne-winioctl-write_cache_enable
alias WRITE_CACHE_ENABLE = int;
enum : int
{
    WriteCacheEnableUnknown = 0x00000000,
    WriteCacheDisabled      = 0x00000001,
    WriteCacheEnabled       = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ne-winioctl-write_cache_change
alias WRITE_CACHE_CHANGE = int;
enum : int
{
    WriteCacheChangeUnknown = 0x00000000,
    WriteCacheNotChangeable = 0x00000001,
    WriteCacheChangeable    = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ne-winioctl-write_through
alias WRITE_THROUGH = int;
enum : int
{
    WriteThroughUnknown      = 0x00000000,
    WriteThroughNotSupported = 0x00000001,
    WriteThroughSupported    = 0x00000002,
}

alias DEVICEDUMP_COLLECTION_TYPEIDE_NOTIFICATION_TYPE = int;
enum : int
{
    TCCollectionBugCheck             = 0x00000001,
    TCCollectionApplicationRequested = 0x00000002,
    TCCollectionDeviceRequested      = 0x00000003,
}

alias STORAGE_POWERUP_REASON_TYPE = int;
enum : int
{
    StoragePowerupUnknown         = 0x00000000,
    StoragePowerupIO              = 0x00000001,
    StoragePowerupDeviceAttention = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ne-winioctl-storage_device_power_cap_units
alias STORAGE_DEVICE_POWER_CAP_UNITS = int;
enum : int
{
    StorageDevicePowerCapUnitsPercent    = 0x00000000,
    StorageDevicePowerCapUnitsMilliwatts = 0x00000001,
}

alias STORAGE_RPMB_COMMAND_TYPE = int;
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

alias STORAGE_COUNTER_TYPE = int;
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

alias STORAGE_ATTRIBUTE_MGMT_ACTION = int;
enum : int
{
    StorAttributeMgmt_ClearAttribute = 0x00000000,
    StorAttributeMgmt_SetAttribute   = 0x00000001,
    StorAttributeMgmt_ResetAttribute = 0x00000002,
}

alias SCM_REGION_FLAG = int;
enum : int
{
    ScmRegionFlagNone  = 0x00000000,
    ScmRegionFlagLabel = 0x00000001,
}

alias SCM_BUS_QUERY_TYPE = int;
enum : int
{
    ScmBusQuery_Descriptor  = 0x00000000,
    ScmBusQuery_IsSupported = 0x00000001,
    ScmBusQuery_Max         = 0x00000002,
}

alias SCM_BUS_SET_TYPE = int;
enum : int
{
    ScmBusSet_Descriptor  = 0x00000000,
    ScmBusSet_IsSupported = 0x00000001,
    ScmBusSet_Max         = 0x00000002,
}

alias SCM_BUS_PROPERTY_ID = int;
enum : int
{
    ScmBusProperty_RuntimeFwActivationInfo = 0x00000000,
    ScmBusProperty_DedicatedMemoryInfo     = 0x00000001,
    ScmBusProperty_DedicatedMemoryState    = 0x00000002,
    ScmBusProperty_Max                     = 0x00000003,
}

alias SCM_BUS_FIRMWARE_ACTIVATION_STATE = int;
enum : int
{
    ScmBusFirmwareActivationState_Idle  = 0x00000000,
    ScmBusFirmwareActivationState_Armed = 0x00000001,
    ScmBusFirmwareActivationState_Busy  = 0x00000002,
}

alias SCM_PD_QUERY_TYPE = int;
enum : int
{
    ScmPhysicalDeviceQuery_Descriptor  = 0x00000000,
    ScmPhysicalDeviceQuery_IsSupported = 0x00000001,
    ScmPhysicalDeviceQuery_Max         = 0x00000002,
}

alias SCM_PD_SET_TYPE = int;
enum : int
{
    ScmPhysicalDeviceSet_Descriptor  = 0x00000000,
    ScmPhysicalDeviceSet_IsSupported = 0x00000001,
    ScmPhysicalDeviceSet_Max         = 0x00000002,
}

alias SCM_PD_PROPERTY_ID = int;
enum : int
{
    ScmPhysicalDeviceProperty_DeviceInfo                  = 0x00000000,
    ScmPhysicalDeviceProperty_ManagementStatus            = 0x00000001,
    ScmPhysicalDeviceProperty_FirmwareInfo                = 0x00000002,
    ScmPhysicalDeviceProperty_LocationString              = 0x00000003,
    ScmPhysicalDeviceProperty_DeviceSpecificInfo          = 0x00000004,
    ScmPhysicalDeviceProperty_DeviceHandle                = 0x00000005,
    ScmPhysicalDeviceProperty_FruIdString                 = 0x00000006,
    ScmPhysicalDeviceProperty_RuntimeFwActivationInfo     = 0x00000007,
    ScmPhysicalDeviceProperty_RuntimeFwActivationArmState = 0x00000008,
    ScmPhysicalDeviceProperty_Max                         = 0x00000009,
}

alias SCM_PD_HEALTH_STATUS = int;
enum : int
{
    ScmPhysicalDeviceHealth_Unknown   = 0x00000000,
    ScmPhysicalDeviceHealth_Unhealthy = 0x00000001,
    ScmPhysicalDeviceHealth_Warning   = 0x00000002,
    ScmPhysicalDeviceHealth_Healthy   = 0x00000003,
    ScmPhysicalDeviceHealth_Max       = 0x00000004,
}

alias SCM_PD_OPERATIONAL_STATUS = int;
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

alias SCM_PD_OPERATIONAL_STATUS_REASON = int;
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
    ScmPhysicalDeviceOpReason_InternalFailure              = 0x00000016,
    ScmPhysicalDeviceOpReason_Max                          = 0x00000017,
}

alias SCM_PD_LAST_FW_ACTIVATION_STATUS = int;
enum : int
{
    ScmPdLastFwActivationStatus_None                 = 0x00000000,
    ScmPdLastFwActivationStatus_Success              = 0x00000001,
    ScmPdLastFwActivationStatus_FwNotFound           = 0x00000002,
    ScmPdLastFwActivationStatus_ColdRebootRequired   = 0x00000003,
    ScmPdLastFwActivaitonStatus_ActivationInProgress = 0x00000004,
    ScmPdLastFwActivaitonStatus_Retry                = 0x00000005,
    ScmPdLastFwActivaitonStatus_FwUnsupported        = 0x00000006,
    ScmPdLastFwActivaitonStatus_UnknownError         = 0x00000007,
}

alias SCM_PD_FIRMWARE_ACTIVATION_STATE = int;
enum : int
{
    ScmPdFirmwareActivationState_Idle  = 0x00000000,
    ScmPdFirmwareActivationState_Armed = 0x00000001,
    ScmPdFirmwareActivationState_Busy  = 0x00000002,
}

alias SCM_PD_MEDIA_REINITIALIZATION_STATUS = int;
enum : int
{
    ScmPhysicalDeviceReinit_Success        = 0x00000000,
    ScmPhysicalDeviceReinit_RebootNeeded   = 0x00000001,
    ScmPhysicalDeviceReinit_ColdBootNeeded = 0x00000002,
    ScmPhysicalDeviceReinit_Max            = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ne-winioctl-media_type
alias MEDIA_TYPE = int;
enum : int
{
    Unknown        = 0x00000000,
    F5_1Pt2_512    = 0x00000001,
    F3_1Pt44_512   = 0x00000002,
    F3_2Pt88_512   = 0x00000003,
    F3_20Pt8_512   = 0x00000004,
    F3_720_512     = 0x00000005,
    F5_360_512     = 0x00000006,
    F5_320_512     = 0x00000007,
    F5_320_1024    = 0x00000008,
    F5_180_512     = 0x00000009,
    F5_160_512     = 0x0000000a,
    RemovableMedia = 0x0000000b,
    FixedMedia     = 0x0000000c,
    F3_120M_512    = 0x0000000d,
    F3_640_512     = 0x0000000e,
    F5_640_512     = 0x0000000f,
    F5_720_512     = 0x00000010,
    F3_1Pt2_512    = 0x00000011,
    F3_1Pt23_1024  = 0x00000012,
    F5_1Pt23_1024  = 0x00000013,
    F3_128Mb_512   = 0x00000014,
    F3_230Mb_512   = 0x00000015,
    F8_256_128     = 0x00000016,
    F3_200Mb_512   = 0x00000017,
    F3_240M_512    = 0x00000018,
    F3_32M_512     = 0x00000019,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ne-winioctl-partition_style
alias PARTITION_STYLE = int;
enum : int
{
    PARTITION_STYLE_MBR = 0x00000000,
    PARTITION_STYLE_GPT = 0x00000001,
    PARTITION_STYLE_RAW = 0x00000002,
}

alias DETECTION_TYPE = int;
enum : int
{
    DetectNone    = 0x00000000,
    DetectInt13   = 0x00000001,
    DetectExInt13 = 0x00000002,
}

alias DISK_CACHE_RETENTION_PRIORITY = int;
enum : int
{
    EqualPriority      = 0x00000000,
    KeepPrefetchedData = 0x00000001,
    KeepReadData       = 0x00000002,
}

alias BIN_TYPES = int;
enum : int
{
    RequestSize     = 0x00000000,
    RequestLocation = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ne-winioctl-element_type
alias ELEMENT_TYPE = int;
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

alias CHANGER_DEVICE_PROBLEM_TYPE = int;
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

alias SHRINK_VOLUME_REQUEST_TYPES = int;
enum : int
{
    ShrinkPrepare = 0x00000001,
    ShrinkCommit  = 0x00000002,
    ShrinkAbort   = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ne-winioctl-csv_control_op
alias CSV_CONTROL_OP = int;
enum : int
{
    CsvControlStartRedirectFile                  = 0x00000002,
    CsvControlStopRedirectFile                   = 0x00000003,
    CsvControlQueryRedirectState                 = 0x00000004,
    CsvControlQueryFileRevision                  = 0x00000006,
    CsvControlQueryMdsPath                       = 0x00000008,
    CsvControlQueryFileRevisionFileId128         = 0x00000009,
    CsvControlQueryVolumeRedirectState           = 0x0000000a,
    CsvControlEnableUSNRangeModificationTracking = 0x0000000d,
    CsvControlMarkHandleLocalVolumeMount         = 0x0000000e,
    CsvControlUnmarkHandleLocalVolumeMount       = 0x0000000f,
    CsvControlGetCsvFsMdsPathV2                  = 0x00000012,
    CsvControlDisableCaching                     = 0x00000013,
    CsvControlEnableCaching                      = 0x00000014,
    CsvControlStartForceDFO                      = 0x00000015,
    CsvControlStopForceDFO                       = 0x00000016,
    CsvControlQueryMdsPathNoPause                = 0x00000017,
    CsvControlSetVolumeId                        = 0x00000018,
    CsvControlQueryVolumeId                      = 0x00000019,
}

alias CSVFS_DISK_CONNECTIVITY = int;
enum : int
{
    CsvFsDiskConnectivityNone          = 0x00000000,
    CsvFsDiskConnectivityMdsNodeOnly   = 0x00000001,
    CsvFsDiskConnectivitySubsetOfNodes = 0x00000002,
    CsvFsDiskConnectivityAllNodes      = 0x00000003,
}

alias LMR_QUERY_INFO_CLASS = int;
enum : int
{
    LMRQuerySessionInfo = 0x00000001,
}

alias STORAGE_RESERVE_ID = int;
enum : int
{
    StorageReserveIdNone          = 0x00000000,
    StorageReserveIdHard          = 0x00000001,
    StorageReserveIdSoft          = 0x00000002,
    StorageReserveIdUpdateScratch = 0x00000003,
    StorageReserveIdMax           = 0x00000004,
}

alias QUERY_FILE_LAYOUT_FILTER_TYPE = int;
enum : int
{
    QUERY_FILE_LAYOUT_FILTER_TYPE_NONE               = 0x00000000,
    QUERY_FILE_LAYOUT_FILTER_TYPE_CLUSTERS           = 0x00000001,
    QUERY_FILE_LAYOUT_FILTER_TYPE_FILEID             = 0x00000002,
    QUERY_FILE_LAYOUT_FILTER_TYPE_STORAGE_RESERVE_ID = 0x00000003,
    QUERY_FILE_LAYOUT_NUM_FILTER_TYPES               = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ne-winioctl-file_storage_tier_media_type
alias FILE_STORAGE_TIER_MEDIA_TYPE = int;
enum : int
{
    FileStorageTierMediaTypeUnspecified = 0x00000000,
    FileStorageTierMediaTypeDisk        = 0x00000001,
    FileStorageTierMediaTypeSsd         = 0x00000002,
    FileStorageTierMediaTypeScm         = 0x00000004,
    FileStorageTierMediaTypeMax         = 0x00000005,
}

alias FILE_STORAGE_TIER_CLASS = int;
enum : int
{
    FileStorageTierClassUnspecified = 0x00000000,
    FileStorageTierClassCapacity    = 0x00000001,
    FileStorageTierClassPerformance = 0x00000002,
    FileStorageTierClassMax         = 0x00000003,
}

alias DUPLICATE_EXTENTS_STATE = int;
enum : int
{
    FileSnapStateInactive = 0x00000000,
    FileSnapStateSource   = 0x00000001,
    FileSnapStateTarget   = 0x00000002,
}

alias REFS_SMR_VOLUME_GC_STATE = int;
enum : int
{
    SmrGcStateInactive        = 0x00000000,
    SmrGcStatePaused          = 0x00000001,
    SmrGcStateActive          = 0x00000002,
    SmrGcStateActiveFullSpeed = 0x00000003,
}

alias REFS_SMR_VOLUME_GC_ACTION = int;
enum : int
{
    SmrGcActionStart          = 0x00000001,
    SmrGcActionStartFullSpeed = 0x00000002,
    SmrGcActionPause          = 0x00000003,
    SmrGcActionStop           = 0x00000004,
}

alias REFS_SMR_VOLUME_GC_METHOD = int;
enum : int
{
    SmrGcMethodCompaction  = 0x00000001,
    SmrGcMethodCompression = 0x00000002,
    SmrGcMethodRotation    = 0x00000003,
}

alias VIRTUAL_STORAGE_BEHAVIOR_CODE = int;
enum : int
{
    VirtualStorageBehaviorUndefined           = 0x00000000,
    VirtualStorageBehaviorCacheWriteThrough   = 0x00000001,
    VirtualStorageBehaviorCacheWriteBack      = 0x00000002,
    VirtualStorageBehaviorStopIoProcessing    = 0x00000003,
    VirtualStorageBehaviorRestartIoProcessing = 0x00000004,
}

alias FS_BPIO_OPERATIONS = int;
enum : int
{
    FS_BPIO_OP_ENABLE              = 0x00000001,
    FS_BPIO_OP_DISABLE             = 0x00000002,
    FS_BPIO_OP_QUERY               = 0x00000003,
    FS_BPIO_OP_VOLUME_STACK_PAUSE  = 0x00000004,
    FS_BPIO_OP_VOLUME_STACK_RESUME = 0x00000005,
    FS_BPIO_OP_STREAM_PAUSE        = 0x00000006,
    FS_BPIO_OP_STREAM_RESUME       = 0x00000007,
    FS_BPIO_OP_GET_INFO            = 0x00000008,
    FS_BPIO_OP_MAX_OPERATION       = 0x00000009,
}

alias FS_BPIO_INFLAGS = int;
enum : int
{
    FSBPIO_INFL_None                     = 0x00000000,
    FSBPIO_INFL_SKIP_STORAGE_STACK_QUERY = 0x00000001,
}

alias FS_BPIO_OUTFLAGS = int;
enum : int
{
    FSBPIO_OUTFL_None                       = 0x00000000,
    FSBPIO_OUTFL_VOLUME_STACK_BYPASS_PAUSED = 0x00000001,
    FSBPIO_OUTFL_STREAM_BYPASS_PAUSED       = 0x00000002,
    FSBPIO_OUTFL_FILTER_ATTACH_BLOCKED      = 0x00000004,
    FSBPIO_OUTFL_COMPATIBLE_STORAGE_DRIVER  = 0x00000008,
}

// Constants


enum uint IOCTL_STORAGE_BASE = 0x0000002dU;
enum uint IOCTL_SCMBUS_BASE = 0x00000059U;
enum uint IOCTL_DISK_BASE = 0x00000007U;
enum uint IOCTL_CHANGER_BASE = 0x00000030U;
enum uint FILE_SPECIAL_ACCESS = 0x00000000U;
enum uint FILE_DEVICE_UNKNOWN = 0x00000022U;

enum : GUID
{
    GUID_DEVINTERFACE_DISK                = GUID("53f56307-b6bf-11d0-94f2-00a0c91efb8b"),
    GUID_DEVINTERFACE_CDROM               = GUID("53f56308-b6bf-11d0-94f2-00a0c91efb8b"),
    GUID_DEVINTERFACE_PARTITION           = GUID("53f5630a-b6bf-11d0-94f2-00a0c91efb8b"),
    GUID_DEVINTERFACE_TAPE                = GUID("53f5630b-b6bf-11d0-94f2-00a0c91efb8b"),
    GUID_DEVINTERFACE_WRITEONCEDISK       = GUID("53f5630c-b6bf-11d0-94f2-00a0c91efb8b"),
    GUID_DEVINTERFACE_VOLUME              = GUID("53f5630d-b6bf-11d0-94f2-00a0c91efb8b"),
    GUID_DEVINTERFACE_MEDIUMCHANGER       = GUID("53f56310-b6bf-11d0-94f2-00a0c91efb8b"),
    GUID_DEVINTERFACE_FLOPPY              = GUID("53f56311-b6bf-11d0-94f2-00a0c91efb8b"),
    GUID_DEVINTERFACE_CDCHANGER           = GUID("53f56312-b6bf-11d0-94f2-00a0c91efb8b"),
    GUID_DEVINTERFACE_STORAGEPORT         = GUID("2accfe60-c130-11d2-b082-00a0c91efb8b"),
    GUID_DEVINTERFACE_VMLUN               = GUID("6f416619-9f29-42a5-b20b-37e219ca02b0"),
    GUID_DEVINTERFACE_SES                 = GUID("1790c9ec-47d5-4df3-b5af-9adf3cf23e48"),
    GUID_DEVINTERFACE_ZNSDISK             = GUID("b87941c5-ffdb-43c7-b6b1-20b632f0b109"),
    GUID_DEVINTERFACE_HIDDEN_DISK         = GUID("7fccc86c-228a-40ad-8a58-f590af7bfdce"),
    GUID_DEVINTERFACE_SERVICE_VOLUME      = GUID("6ead3d82-25ec-46bc-b7fd-c1f0df8f5037"),
    GUID_DEVINTERFACE_HIDDEN_VOLUME       = GUID("7f108a28-9833-4b3b-b780-2c6b5fa5c062"),
    GUID_DEVINTERFACE_UNIFIED_ACCESS_RPMB = GUID("27447c21-bcc3-4d07-a05b-a3395bb4eee7"),
}

enum : GUID
{
    GUID_DEVICEDUMP_STORAGE_DEVICE      = GUID("d8e2592f-1aab-4d56-a746-1f7585df40f4"),
    GUID_DEVICEDUMP_DRIVER_STORAGE_PORT = GUID("da82441d-7142-4bc1-b844-0807c5a4b67f"),
}

enum : DEVPROPKEY
{
    DEVPKEY_Storage_Portable         = DEVPROPKEY(GUID("4D1EBEE8-0803-4774-9842-B77DB50265E9"), 2),
    DEVPKEY_Storage_Removable_Media  = DEVPROPKEY(GUID("4D1EBEE8-0803-4774-9842-B77DB50265E9"), 3),
    DEVPKEY_Storage_System_Critical  = DEVPROPKEY(GUID("4D1EBEE8-0803-4774-9842-B77DB50265E9"), 4),
    DEVPKEY_Storage_Disk_Number      = DEVPROPKEY(GUID("4D1EBEE8-0803-4774-9842-B77DB50265E9"), 5),
    DEVPKEY_Storage_Partition_Number = DEVPROPKEY(GUID("4D1EBEE8-0803-4774-9842-B77DB50265E9"), 6),
    DEVPKEY_Storage_Mbr_Type         = DEVPROPKEY(GUID("4D1EBEE8-0803-4774-9842-B77DB50265E9"), 7),
    DEVPKEY_Storage_Gpt_Type         = DEVPROPKEY(GUID("4D1EBEE8-0803-4774-9842-B77DB50265E9"), 8),
    DEVPKEY_Storage_Gpt_Name         = DEVPROPKEY(GUID("4D1EBEE8-0803-4774-9842-B77DB50265E9"), 9),
}

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_storage_check_verify
    IOCTL_STORAGE_CHECK_VERIFY               = 0x002d4800U,
    IOCTL_STORAGE_CHECK_VERIFY2              = 0x002d0800U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_storage_media_removal
    IOCTL_STORAGE_MEDIA_REMOVAL              = 0x002d4804U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_storage_eject_media
    IOCTL_STORAGE_EJECT_MEDIA                = 0x002d4808U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_storage_load_media
    IOCTL_STORAGE_LOAD_MEDIA                 = 0x002d480cU,
    IOCTL_STORAGE_LOAD_MEDIA2                = 0x002d080cU,
    IOCTL_STORAGE_RESERVE                    = 0x002d4810U,
    IOCTL_STORAGE_RELEASE                    = 0x002d4814U,
    IOCTL_STORAGE_FIND_NEW_DEVICES           = 0x002d4818U,
    IOCTL_STORAGE_MANAGE_BYPASS_IO           = 0x002d08c0U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_storage_ejection_control
    IOCTL_STORAGE_EJECTION_CONTROL           = 0x002d0940U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_storage_mcn_control
    IOCTL_STORAGE_MCN_CONTROL                = 0x002d0944U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_storage_get_media_types
    IOCTL_STORAGE_GET_MEDIA_TYPES            = 0x002d0c00U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_storage_get_media_types_ex
    IOCTL_STORAGE_GET_MEDIA_TYPES_EX         = 0x002d0c04U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_storage_get_media_serial_number
    IOCTL_STORAGE_GET_MEDIA_SERIAL_NUMBER    = 0x002d0c10U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_storage_get_hotplug_info
    IOCTL_STORAGE_GET_HOTPLUG_INFO           = 0x002d0c14U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_storage_set_hotplug_info
    IOCTL_STORAGE_SET_HOTPLUG_INFO           = 0x002dcc18U,
    IOCTL_STORAGE_GET_SYSTEM_FEATURE_SUPPORT = 0x002d4c1cU,
}

enum : uint
{
    IOCTL_STORAGE_RESET_BUS              = 0x002d5000U,
    IOCTL_STORAGE_RESET_DEVICE           = 0x002d5004U,
    IOCTL_STORAGE_BREAK_RESERVATION      = 0x002d5014U,
    IOCTL_STORAGE_PERSISTENT_RESERVE_IN  = 0x002d5018U,
    IOCTL_STORAGE_PERSISTENT_RESERVE_OUT = 0x002dd01cU,
}

enum uint IOCTL_STORAGE_MINIPORT_PASSTHROUGH_REQUEST = 0x002dd050U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_storage_get_device_number
    IOCTL_STORAGE_GET_DEVICE_NUMBER         = 0x002d1080U,
    IOCTL_STORAGE_GET_DEVICE_NUMBER_EX      = 0x002d1084U,
    IOCTL_STORAGE_PREDICT_FAILURE           = 0x002d1100U,
    IOCTL_STORAGE_FAILURE_PREDICTION_CONFIG = 0x002d1104U,
}

enum : uint
{
    IOCTL_STORAGE_GET_COUNTERS                = 0x002d1108U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_storage_read_capacity
    IOCTL_STORAGE_READ_CAPACITY               = 0x002d5140U,
    IOCTL_STORAGE_GET_DEVICE_TELEMETRY        = 0x002dd1c0U,
    IOCTL_STORAGE_DEVICE_TELEMETRY_NOTIFY     = 0x002dd1c4U,
    IOCTL_STORAGE_DEVICE_TELEMETRY_QUERY_CAPS = 0x002dd1c8U,
}

enum uint IOCTL_STORAGE_GET_DEVICE_TELEMETRY_RAW = 0x002dd1ccU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_storage_set_temperature_threshold
enum uint IOCTL_STORAGE_SET_TEMPERATURE_THRESHOLD = 0x002dd200U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_storage_protocol_command
    IOCTL_STORAGE_PROTOCOL_COMMAND           = 0x002dd3c0U,
    IOCTL_STORAGE_SET_PROPERTY               = 0x002d93fcU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_storage_query_property
    IOCTL_STORAGE_QUERY_PROPERTY             = 0x002d1400U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_storage_manage_data_set_attributes
    IOCTL_STORAGE_MANAGE_DATA_SET_ATTRIBUTES = 0x002d9404U,
}

enum uint IOCTL_STORAGE_GET_LB_PROVISIONING_MAP_RESOURCES = 0x002d5408U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_storage_reinitialize_media
    IOCTL_STORAGE_REINITIALIZE_MEDIA          = 0x002d9640U,
    IOCTL_STORAGE_GET_BC_PROPERTIES           = 0x002d5800U,
    IOCTL_STORAGE_ALLOCATE_BC_STREAM          = 0x002dd804U,
    IOCTL_STORAGE_FREE_BC_STREAM              = 0x002dd808U,
    IOCTL_STORAGE_CHECK_PRIORITY_HINT_SUPPORT = 0x002d1880U,
}

enum uint IOCTL_STORAGE_START_DATA_INTEGRITY_CHECK = 0x002dd884U;
enum uint IOCTL_STORAGE_STOP_DATA_INTEGRITY_CHECK = 0x002dd888U;

enum : uint
{
    OBSOLETE_IOCTL_STORAGE_RESET_BUS    = 0x002dd000U,
    OBSOLETE_IOCTL_STORAGE_RESET_DEVICE = 0x002dd004U,
}

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_storage_firmware_get_info
    IOCTL_STORAGE_FIRMWARE_GET_INFO       = 0x002d1c00U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_storage_firmware_download
    IOCTL_STORAGE_FIRMWARE_DOWNLOAD       = 0x002ddc04U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_storage_firmware_activate
    IOCTL_STORAGE_FIRMWARE_ACTIVATE       = 0x002ddc08U,
    IOCTL_STORAGE_ENABLE_IDLE_POWER       = 0x002d1c80U,
    IOCTL_STORAGE_GET_IDLE_POWERUP_REASON = 0x002d1c84U,
}

enum : uint
{
    IOCTL_STORAGE_POWER_ACTIVE                = 0x002d1c88U,
    IOCTL_STORAGE_POWER_IDLE                  = 0x002d1c8cU,
    IOCTL_STORAGE_EVENT_NOTIFICATION          = 0x002d1c90U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_storage_device_power_cap
    IOCTL_STORAGE_DEVICE_POWER_CAP            = 0x002d1c94U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_storage_rpmb_command
    IOCTL_STORAGE_RPMB_COMMAND                = 0x002d1c98U,
    IOCTL_STORAGE_ATTRIBUTE_MANAGEMENT        = 0x002ddc9cU,
    IOCTL_STORAGE_DIAGNOSTIC                  = 0x002d1ca0U,
    IOCTL_STORAGE_GET_PHYSICAL_ELEMENT_STATUS = 0x002d1ca4U,
}

enum uint IOCTL_STORAGE_REMOVE_ELEMENT_AND_TRUNCATE = 0x002d1cc0U;
enum uint IOCTL_STORAGE_GET_DEVICE_INTERNAL_LOG = 0x002d1cc4U;
enum uint STORAGE_FEATURE_SUPPORT_V1 = 0x00000001U;

enum : uint
{
    STORAGE_DEVICE_FLAGS_RANDOM_DEVICEGUID_REASON_CONFLICT = 0x00000001U,
    STORAGE_DEVICE_FLAGS_RANDOM_DEVICEGUID_REASON_NOHWID   = 0x00000002U,
    STORAGE_DEVICE_FLAGS_PAGE_83_DEVICEGUID                = 0x00000004U,
}

enum uint RECOVERED_WRITES_VALID = 0x00000001U;
enum uint UNRECOVERED_WRITES_VALID = 0x00000002U;
enum uint RECOVERED_READS_VALID = 0x00000004U;
enum uint UNRECOVERED_READS_VALID = 0x00000008U;
enum uint WRITE_COMPRESSION_INFO_VALID = 0x00000010U;
enum uint READ_COMPRESSION_INFO_VALID = 0x00000020U;

enum : int
{
    TAPE_RETURN_STATISTICS = 0x00000000,
    TAPE_RETURN_ENV_INFO   = 0x00000001,
}

enum int TAPE_RESET_STATISTICS = 0x00000002;
enum uint MEDIA_ERASEABLE = 0x00000001U;
enum uint MEDIA_WRITE_ONCE = 0x00000002U;

enum : uint
{
    MEDIA_READ_ONLY  = 0x00000004U,
    MEDIA_READ_WRITE = 0x00000008U,
}

enum uint MEDIA_WRITE_PROTECTED = 0x00000100U;
enum uint MEDIA_CURRENTLY_MOUNTED = 0x80000000U;
enum uint STORAGE_FAILURE_PREDICTION_CONFIG_V1 = 0x00000001U;
enum uint SRB_TYPE_SCSI_REQUEST_BLOCK = 0x00000000U;
enum uint SRB_TYPE_STORAGE_REQUEST_BLOCK = 0x00000001U;
enum uint STORAGE_ADDRESS_TYPE_BTL8 = 0x00000000U;
enum uint STORAGE_RPMB_DESCRIPTOR_VERSION_1 = 0x00000001U;
enum uint STORAGE_RPMB_MINIMUM_RELIABLE_WRITE_SIZE = 0x00000200U;

enum : uint
{
    STORAGE_CRYPTO_CAPABILITY_VERSION_1 = 0x00000001U,
    STORAGE_CRYPTO_CAPABILITY_VERSION_2 = 0x00000002U,
    STORAGE_CRYPTO_DESCRIPTOR_VERSION_1 = 0x00000001U,
    STORAGE_CRYPTO_DESCRIPTOR_VERSION_2 = 0x00000002U,
}

enum : uint
{
    STORAGE_HW_CRYPTO_CAPABILITY_VERSION_1 = 0x00000001U,
    STORAGE_HW_CRYPTO_DESCRIPTOR_VERSION_1 = 0x00000001U,
}

enum : uint
{
    STORAGE_TIER_NAME_LENGTH           = 0x00000100U,
    STORAGE_TIER_DESCRIPTION_LENGTH    = 0x00000200U,
    STORAGE_TIER_FLAG_NO_SEEK_PENALTY  = 0x00020000U,
    STORAGE_TIER_FLAG_WRITE_BACK_CACHE = 0x00200000U,
    STORAGE_TIER_FLAG_READ_CACHE       = 0x00400000U,
    STORAGE_TIER_FLAG_PARITY           = 0x00800000U,
    STORAGE_TIER_FLAG_SMR              = 0x01000000U,
}

enum uint STORAGE_PROTOCOL_DATA_DESCRIPTOR_EXT_VERSION = 0x00000001U;

enum : uint
{
    STORAGE_TEMPERATURE_VALUE_NOT_REPORTED             = 0x00008000U,
    STORAGE_TEMPERATURE_THRESHOLD_FLAG_ADAPTER_REQUEST = 0x00000001U,
}

enum : uint
{
    STORAGE_COMPONENT_ROLE_CACHE   = 0x00000001U,
    STORAGE_COMPONENT_ROLE_TIERING = 0x00000002U,
    STORAGE_COMPONENT_ROLE_DATA    = 0x00000004U,
}

enum : uint
{
    STORAGE_ATTRIBUTE_BYTE_ADDRESSABLE_IO      = 0x00000001U,
    STORAGE_ATTRIBUTE_BLOCK_IO                 = 0x00000002U,
    STORAGE_ATTRIBUTE_DYNAMIC_PERSISTENCE      = 0x00000004U,
    STORAGE_ATTRIBUTE_VOLATILE                 = 0x00000008U,
    STORAGE_ATTRIBUTE_ASYNC_EVENT_NOTIFICATION = 0x00000010U,
    STORAGE_ATTRIBUTE_PERF_SIZE_INDEPENDENT    = 0x00000020U,
}

enum uint STORAGE_DEVICE_MAX_OPERATIONAL_STATUS = 0x00000010U;
enum uint STORAGE_ADAPTER_SERIAL_NUMBER_V1_MAX_LENGTH = 0x00000080U;
enum uint DeviceDsmActionFlag_NonDestructive = 0x80000000U;

enum : uint
{
    DEVICE_DSM_FLAG_ENTIRE_DATA_SET_RANGE = 0x00000001U,
    DEVICE_DSM_FLAG_TRIM_NOT_FS_ALLOCATED = 0x80000000U,
    DEVICE_DSM_FLAG_TRIM_BYPASS_RZAT      = 0x40000000U,
}

enum : uint
{
    DEVICE_DSM_NOTIFY_FLAG_BEGIN = 0x00000001U,
    DEVICE_DSM_NOTIFY_FLAG_END   = 0x00000002U,
}

enum : uint
{
    STORAGE_OFFLOAD_MAX_TOKEN_LENGTH      = 0x00000200U,
    STORAGE_OFFLOAD_TOKEN_ID_LENGTH       = 0x000001f8U,
    STORAGE_OFFLOAD_TOKEN_TYPE_ZERO_DATA  = 0xffff0001U,
    STORAGE_OFFLOAD_READ_RANGE_TRUNCATED  = 0x00000001U,
    STORAGE_OFFLOAD_WRITE_RANGE_TRUNCATED = 0x00000001U,
    STORAGE_OFFLOAD_TOKEN_INVALID         = 0x00000002U,
}

enum uint DEVICE_DSM_FLAG_ALLOCATION_CONSOLIDATEABLE_ONLY = 0x40000000U;
enum uint DEVICE_DSM_PARAMETERS_V1 = 0x00000001U;
enum uint DEVICE_DATA_SET_LBP_STATE_PARAMETERS_VERSION_V1 = 0x00000001U;

enum : uint
{
    DEVICE_DSM_FLAG_REPAIR_INPUT_TOPOLOGY_ID_PRESENT = 0x40000000U,
    DEVICE_DSM_FLAG_REPAIR_OUTPUT_PARITY_EXTENT      = 0x20000000U,
}

enum : uint
{
    DEVICE_DSM_FLAG_SCRUB_SKIP_IN_SYNC         = 0x10000000U,
    DEVICE_DSM_FLAG_SCRUB_OUTPUT_PARITY_EXTENT = 0x20000000U,
}

enum uint DEVICE_DSM_FLAG_PHYSICAL_ADDRESSES_OMIT_TOTAL_RANGES = 0x10000000U;

enum : uint
{
    DEVICE_DSM_PHYSICAL_ADDRESSES_OUTPUT_V1         = 0x00000001U,
    DEVICE_DSM_PHYSICAL_ADDRESSES_OUTPUT_VERSION_V1 = 0x00000001U,
}

enum uint DEVICE_STORAGE_NO_ERRORS = 0x00000001U;

enum : uint
{
    DEVICE_DSM_RANGE_ERROR_OUTPUT_V1       = 0x00000001U,
    DEVICE_DSM_RANGE_ERROR_INFO_VERSION_V1 = 0x00000001U,
}

enum uint IOCTL_STORAGE_BC_VERSION = 0x00000001U;
enum uint STORAGE_PRIORITY_HINT_SUPPORTED = 0x00000001U;
enum uint STORAGE_DIAGNOSTIC_FLAG_ADAPTER_REQUEST = 0x00000001U;
enum uint ERROR_HISTORY_DIRECTORY_ENTRY_DEFAULT_COUNT = 0x00000008U;
enum uint DEVICEDUMP_STRUCTURE_VERSION_V1 = 0x00000001U;
enum uint DEVICEDUMP_MAX_IDSTRING = 0x00000020U;
enum uint MAX_FW_BUCKET_ID_LENGTH = 0x00000084U;
enum const(wchar)* STORAGE_CRASH_TELEMETRY_REGKEY = "\\Registry\\Machine\\System\\CurrentControlSet\\Control\\CrashControl\\StorageTelemetry";
enum const(wchar)* STORAGE_DEVICE_TELEMETRY_REGKEY = "\\Registry\\Machine\\System\\CurrentControlSet\\Control\\Storage\\StorageTelemetry";
enum uint DDUMP_FLAG_DATA_READ_FROM_DEVICE = 0x00000001U;

enum : uint
{
    FW_ISSUEID_NO_ISSUE = 0x00000000U,
    FW_ISSUEID_UNKNOWN  = 0xffffffffU,
}

enum : uint
{
    TC_PUBLIC_DEVICEDUMP_CONTENT_SMART     = 0x00000001U,
    TC_PUBLIC_DEVICEDUMP_CONTENT_GPLOG     = 0x00000002U,
    TC_PUBLIC_DEVICEDUMP_CONTENT_GPLOG_MAX = 0x00000010U,
}

enum uint TC_DEVICEDUMP_SUBSECTION_DESC_LENGTH = 0x00000010U;

enum : const(wchar)*
{
    // Native encoding: ansi
    TC_PUBLIC_DATA_TYPE_ATAGP    = "ATAGPLogPages",
    // Native encoding: ansi
    TC_PUBLIC_DATA_TYPE_ATASMART = "ATASMARTPages",
}

enum uint CDB_SIZE = 0x00000010U;
enum uint TELEMETRY_COMMAND_SIZE = 0x00000010U;

enum : uint
{
    DEVICEDUMP_CAP_PRIVATE_SECTION    = 0x00000001U,
    DEVICEDUMP_CAP_RESTRICTED_SECTION = 0x00000002U,
}

enum uint STORAGE_IDLE_POWERUP_REASON_VERSION_V1 = 0x00000001U;
enum uint STORAGE_DEVICE_POWER_CAP_VERSION_V1 = 0x00000001U;
enum uint STORAGE_EVENT_NOTIFICATION_VERSION_V1 = 0x00000001U;

enum : ulong
{
    STORAGE_EVENT_MEDIA_STATUS     = 0x0000000000000001UL,
    STORAGE_EVENT_DEVICE_STATUS    = 0x0000000000000002UL,
    STORAGE_EVENT_DEVICE_OPERATION = 0x0000000000000004UL,
}

enum : uint
{
    READ_COPY_NUMBER_KEY               = 0x52434e00U,
    READ_COPY_NUMBER_BYPASS_CACHE_FLAG = 0x00000100U,
}

enum : uint
{
    STORAGE_HW_FIRMWARE_REQUEST_FLAG_CONTROLLER                       = 0x00000001U,
    STORAGE_HW_FIRMWARE_REQUEST_FLAG_LAST_SEGMENT                     = 0x00000002U,
    STORAGE_HW_FIRMWARE_REQUEST_FLAG_FIRST_SEGMENT                    = 0x00000004U,
    STORAGE_HW_FIRMWARE_REQUEST_FLAG_SWITCH_TO_FIRMWARE_WITHOUT_RESET = 0x10000000U,
    STORAGE_HW_FIRMWARE_REQUEST_FLAG_REPLACE_AND_SWITCH_UPON_RESET    = 0x20000000U,
    STORAGE_HW_FIRMWARE_REQUEST_FLAG_REPLACE_EXISTING_IMAGE           = 0x40000000U,
    STORAGE_HW_FIRMWARE_REQUEST_FLAG_SWITCH_TO_EXISTING_FIRMWARE      = 0x80000000U,
}

enum : uint
{
    STORAGE_HW_FIRMWARE_INVALID_SLOT    = 0x000000ffU,
    STORAGE_HW_FIRMWARE_REVISION_LENGTH = 0x00000010U,
}

enum : uint
{
    STORAGE_PROTOCOL_STRUCTURE_VERSION            = 0x00000001U,
    STORAGE_PROTOCOL_COMMAND_FLAG_ADAPTER_REQUEST = 0x80000000U,
}

enum : uint
{
    STORAGE_PROTOCOL_STATUS_PENDING                = 0x00000000U,
    STORAGE_PROTOCOL_STATUS_SUCCESS                = 0x00000001U,
    STORAGE_PROTOCOL_STATUS_ERROR                  = 0x00000002U,
    STORAGE_PROTOCOL_STATUS_INVALID_REQUEST        = 0x00000003U,
    STORAGE_PROTOCOL_STATUS_NO_DEVICE              = 0x00000004U,
    STORAGE_PROTOCOL_STATUS_BUSY                   = 0x00000005U,
    STORAGE_PROTOCOL_STATUS_DATA_OVERRUN           = 0x00000006U,
    STORAGE_PROTOCOL_STATUS_INSUFFICIENT_RESOURCES = 0x00000007U,
    STORAGE_PROTOCOL_STATUS_THROTTLED_REQUEST      = 0x00000008U,
    STORAGE_PROTOCOL_STATUS_NOT_SUPPORTED          = 0x000000ffU,
    STORAGE_PROTOCOL_COMMAND_LENGTH_NVME           = 0x00000040U,
    STORAGE_PROTOCOL_SPECIFIC_NVME_ADMIN_COMMAND   = 0x00000001U,
    STORAGE_PROTOCOL_SPECIFIC_NVME_NVM_COMMAND     = 0x00000002U,
}

enum : uint
{
    STORATTRIBUTE_NONE             = 0x00000000U,
    STORATTRIBUTE_MANAGEMENT_STATE = 0x00000001U,
}

enum : uint
{
    STORAGE_SUPPORTED_FEATURES_BYPASS_IO = 0x00000001U,
    STORAGE_SUPPORTED_FEATURES_MASK      = 0x00000001U,
}

enum GUID GUID_DEVINTERFACE_SCM_PHYSICAL_DEVICE = GUID("4283609d-4dc2-43be-bbb4-4f15dfce2c61");
enum GUID GUID_SCM_PD_HEALTH_NOTIFICATION = GUID("9da2d386-72f5-4ee3-8155-eca0678e3b06");
enum GUID GUID_SCM_PD_PASSTHROUGH_INVDIMM = GUID("4309ac30-0d11-11e4-9191-0800200c9a66");

enum : GUID
{
    GUID_DEVINTERFACE_COMPORT                = GUID("86e0d1e0-8089-11d0-9ce4-08003e301f73"),
    GUID_DEVINTERFACE_SERENUM_BUS_ENUMERATOR = GUID("4d36e978-e325-11ce-bfc1-08002be10318"),
}

enum : uint
{
    FILE_DEVICE_BEEP               = 0x00000001U,
    FILE_DEVICE_CD_ROM_FILE_SYSTEM = 0x00000003U,
    FILE_DEVICE_CONTROLLER         = 0x00000004U,
    FILE_DEVICE_DATALINK           = 0x00000005U,
    FILE_DEVICE_DFS                = 0x00000006U,
    FILE_DEVICE_DISK_FILE_SYSTEM   = 0x00000008U,
    FILE_DEVICE_FILE_SYSTEM        = 0x00000009U,
    FILE_DEVICE_INPORT_PORT        = 0x0000000aU,
    FILE_DEVICE_KEYBOARD           = 0x0000000bU,
    FILE_DEVICE_MAILSLOT           = 0x0000000cU,
    FILE_DEVICE_MIDI_IN            = 0x0000000dU,
    FILE_DEVICE_MIDI_OUT           = 0x0000000eU,
    FILE_DEVICE_MOUSE              = 0x0000000fU,
    FILE_DEVICE_MULTI_UNC_PROVIDER = 0x00000010U,
}

enum : uint
{
    FILE_DEVICE_NAMED_PIPE          = 0x00000011U,
    FILE_DEVICE_NETWORK             = 0x00000012U,
    FILE_DEVICE_NETWORK_BROWSER     = 0x00000013U,
    FILE_DEVICE_NETWORK_FILE_SYSTEM = 0x00000014U,
    FILE_DEVICE_NULL                = 0x00000015U,
    FILE_DEVICE_PARALLEL_PORT       = 0x00000016U,
    FILE_DEVICE_PHYSICAL_NETCARD    = 0x00000017U,
    FILE_DEVICE_PRINTER             = 0x00000018U,
    FILE_DEVICE_SCANNER             = 0x00000019U,
    FILE_DEVICE_SERIAL_MOUSE_PORT   = 0x0000001aU,
    FILE_DEVICE_SERIAL_PORT         = 0x0000001bU,
    FILE_DEVICE_SCREEN              = 0x0000001cU,
    FILE_DEVICE_SOUND               = 0x0000001dU,
    FILE_DEVICE_STREAMS             = 0x0000001eU,
    FILE_DEVICE_TAPE_FILE_SYSTEM    = 0x00000020U,
    FILE_DEVICE_TRANSPORT           = 0x00000021U,
    FILE_DEVICE_VIDEO               = 0x00000023U,
    FILE_DEVICE_VIRTUAL_DISK        = 0x00000024U,
    FILE_DEVICE_WAVE_IN             = 0x00000025U,
    FILE_DEVICE_WAVE_OUT            = 0x00000026U,
    FILE_DEVICE_8042_PORT           = 0x00000027U,
    FILE_DEVICE_NETWORK_REDIRECTOR  = 0x00000028U,
}

enum : uint
{
    FILE_DEVICE_BATTERY             = 0x00000029U,
    FILE_DEVICE_BUS_EXTENDER        = 0x0000002aU,
    FILE_DEVICE_MODEM               = 0x0000002bU,
    FILE_DEVICE_VDM                 = 0x0000002cU,
    FILE_DEVICE_MASS_STORAGE        = 0x0000002dU,
    FILE_DEVICE_SMB                 = 0x0000002eU,
    FILE_DEVICE_KS                  = 0x0000002fU,
    FILE_DEVICE_CHANGER             = 0x00000030U,
    FILE_DEVICE_ACPI                = 0x00000032U,
    FILE_DEVICE_FULLSCREEN_VIDEO    = 0x00000034U,
    FILE_DEVICE_DFS_FILE_SYSTEM     = 0x00000035U,
    FILE_DEVICE_DFS_VOLUME          = 0x00000036U,
    FILE_DEVICE_SERENUM             = 0x00000037U,
    FILE_DEVICE_TERMSRV             = 0x00000038U,
    FILE_DEVICE_KSEC                = 0x00000039U,
    FILE_DEVICE_FIPS                = 0x0000003aU,
    FILE_DEVICE_INFINIBAND          = 0x0000003bU,
    FILE_DEVICE_VMBUS               = 0x0000003eU,
    FILE_DEVICE_CRYPT_PROVIDER      = 0x0000003fU,
    FILE_DEVICE_WPD                 = 0x00000040U,
    FILE_DEVICE_BLUETOOTH           = 0x00000041U,
    FILE_DEVICE_MT_COMPOSITE        = 0x00000042U,
    FILE_DEVICE_MT_TRANSPORT        = 0x00000043U,
    FILE_DEVICE_BIOMETRIC           = 0x00000044U,
    FILE_DEVICE_PMI                 = 0x00000045U,
    FILE_DEVICE_EHSTOR              = 0x00000046U,
    FILE_DEVICE_DEVAPI              = 0x00000047U,
    FILE_DEVICE_GPIO                = 0x00000048U,
    FILE_DEVICE_USBEX               = 0x00000049U,
    FILE_DEVICE_CONSOLE             = 0x00000050U,
    FILE_DEVICE_NFP                 = 0x00000051U,
    FILE_DEVICE_SYSENV              = 0x00000052U,
    FILE_DEVICE_VIRTUAL_BLOCK       = 0x00000053U,
    FILE_DEVICE_POINT_OF_SERVICE    = 0x00000054U,
    FILE_DEVICE_STORAGE_REPLICATION = 0x00000055U,
}

enum : uint
{
    FILE_DEVICE_TRUST_ENV            = 0x00000056U,
    FILE_DEVICE_UCM                  = 0x00000057U,
    FILE_DEVICE_UCMTCPCI             = 0x00000058U,
    FILE_DEVICE_PERSISTENT_MEMORY    = 0x00000059U,
    FILE_DEVICE_NVDIMM               = 0x0000005aU,
    FILE_DEVICE_HOLOGRAPHIC          = 0x0000005bU,
    FILE_DEVICE_SDFXHCI              = 0x0000005cU,
    FILE_DEVICE_UCMUCSI              = 0x0000005dU,
    FILE_DEVICE_PRM                  = 0x0000005eU,
    FILE_DEVICE_EVENT_COLLECTOR      = 0x0000005fU,
    FILE_DEVICE_USB4                 = 0x00000060U,
    FILE_DEVICE_SOUNDWIRE            = 0x00000061U,
    FILE_DEVICE_FABRIC_NVME          = 0x00000062U,
    FILE_DEVICE_SVM                  = 0x00000063U,
    FILE_DEVICE_HARDWARE_ACCELERATOR = 0x00000064U,
}

enum uint FILE_DEVICE_I3C = 0x00000065U;

enum : uint
{
    METHOD_BUFFERED             = 0x00000000U,
    METHOD_IN_DIRECT            = 0x00000001U,
    METHOD_OUT_DIRECT           = 0x00000002U,
    METHOD_NEITHER              = 0x00000003U,
    METHOD_DIRECT_TO_HARDWARE   = 0x00000001U,
    METHOD_DIRECT_FROM_HARDWARE = 0x00000002U,
}

enum uint FILE_ANY_ACCESS = 0x00000000U;
enum uint FILE_READ_ACCESS = 0x00000001U;
enum uint FILE_WRITE_ACCESS = 0x00000002U;
enum uint STORAGE_DEVICE_NUMA_NODE_UNKNOWN = 0xffffffffU;
enum uint IOCTL_SCMBUS_DEVICE_FUNCTION_BASE = 0x00000000U;
enum uint IOCTL_SCM_LOGICAL_DEVICE_FUNCTION_BASE = 0x00000300U;
enum uint IOCTL_SCM_PHYSICAL_DEVICE_FUNCTION_BASE = 0x00000600U;

enum : uint
{
    IOCTL_SCM_BUS_GET_LOGICAL_DEVICES  = 0x00590000U,
    IOCTL_SCM_BUS_GET_PHYSICAL_DEVICES = 0x00590004U,
    IOCTL_SCM_BUS_GET_REGIONS          = 0x00590008U,
    IOCTL_SCM_BUS_QUERY_PROPERTY       = 0x0059000cU,
    IOCTL_SCM_BUS_SET_PROPERTY         = 0x00598014U,
    IOCTL_SCM_BUS_RUNTIME_FW_ACTIVATE  = 0x00598010U,
    IOCTL_SCM_BUS_REFRESH_NAMESPACE    = 0x00590018U,
}

enum uint IOCTL_SCM_LD_GET_INTERLEAVE_SET = 0x00590c00U;

enum : uint
{
    IOCTL_SCM_PD_QUERY_PROPERTY           = 0x00591800U,
    IOCTL_SCM_PD_FIRMWARE_DOWNLOAD        = 0x00599804U,
    IOCTL_SCM_PD_FIRMWARE_ACTIVATE        = 0x00599808U,
    IOCTL_SCM_PD_PASSTHROUGH              = 0x0059d80cU,
    IOCTL_SCM_PD_UPDATE_MANAGEMENT_STATUS = 0x00591810U,
}

enum : uint
{
    IOCTL_SCM_PD_REINITIALIZE_MEDIA = 0x00599814U,
    IOCTL_SCM_PD_SET_PROPERTY       = 0x00599818U,
}

enum uint SCM_MAX_SYMLINK_LEN_IN_CHARS = 0x00000100U;
enum uint MAX_INTERFACE_CODES = 0x00000008U;
enum uint SCM_PD_FIRMWARE_REVISION_LENGTH_BYTES = 0x00000020U;
enum uint SCM_PD_PROPERTY_NAME_LENGTH_IN_CHARS = 0x00000080U;
enum uint SCM_PD_MAX_OPERATIONAL_STATUS = 0x00000010U;
enum uint SCM_PD_FIRMWARE_LAST_DOWNLOAD = 0x00000001U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_get_drive_geometry
    IOCTL_DISK_GET_DRIVE_GEOMETRY = 0x00070000U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_get_partition_info
    IOCTL_DISK_GET_PARTITION_INFO = 0x00074004U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_set_partition_info
enum uint IOCTL_DISK_SET_PARTITION_INFO = 0x0007c008U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_get_drive_layout
    IOCTL_DISK_GET_DRIVE_LAYOUT    = 0x0007400cU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_set_drive_layout
    IOCTL_DISK_SET_DRIVE_LAYOUT    = 0x0007c010U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_verify
    IOCTL_DISK_VERIFY              = 0x00070014U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_format_tracks
    IOCTL_DISK_FORMAT_TRACKS       = 0x0007c018U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_reassign_blocks
    IOCTL_DISK_REASSIGN_BLOCKS     = 0x0007c01cU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_performance
    IOCTL_DISK_PERFORMANCE         = 0x00070020U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_is_writable
    IOCTL_DISK_IS_WRITABLE         = 0x00070024U,
    IOCTL_DISK_LOGGING             = 0x00070028U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_format_tracks_ex
    IOCTL_DISK_FORMAT_TRACKS_EX    = 0x0007c02cU,
    IOCTL_DISK_HISTOGRAM_STRUCTURE = 0x00070030U,
    IOCTL_DISK_HISTOGRAM_DATA      = 0x00070034U,
    IOCTL_DISK_HISTOGRAM_RESET     = 0x00070038U,
    IOCTL_DISK_REQUEST_STRUCTURE   = 0x0007003cU,
    IOCTL_DISK_REQUEST_DATA        = 0x00070040U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_performance_off
    IOCTL_DISK_PERFORMANCE_OFF     = 0x00070060U,
    IOCTL_DISK_CONTROLLER_NUMBER   = 0x00070044U,
}

enum uint SMART_GET_VERSION = 0x00074080U;
enum uint SMART_SEND_DRIVE_COMMAND = 0x0007c084U;

enum : uint
{
    SMART_RCV_DRIVE_DATA    = 0x0007c088U,
    SMART_RCV_DRIVE_DATA_EX = 0x0007008cU,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_get_partition_info_ex
enum uint IOCTL_DISK_GET_PARTITION_INFO_EX = 0x00070048U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_set_partition_info_ex
enum uint IOCTL_DISK_SET_PARTITION_INFO_EX = 0x0007c04cU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_get_drive_layout_ex
enum uint IOCTL_DISK_GET_DRIVE_LAYOUT_EX = 0x00070050U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_set_drive_layout_ex
enum uint IOCTL_DISK_SET_DRIVE_LAYOUT_EX = 0x0007c054U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_create_disk
    IOCTL_DISK_CREATE_DISK           = 0x0007c058U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_get_length_info
    IOCTL_DISK_GET_LENGTH_INFO       = 0x0007405cU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_get_drive_geometry_ex
    IOCTL_DISK_GET_DRIVE_GEOMETRY_EX = 0x000700a0U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_reassign_blocks_ex
enum uint IOCTL_DISK_REASSIGN_BLOCKS_EX = 0x0007c0a4U;
enum uint IOCTL_DISK_UPDATE_DRIVE_SIZE = 0x0007c0c8U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_grow_partition
    IOCTL_DISK_GROW_PARTITION        = 0x0007c0d0U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_get_cache_information
    IOCTL_DISK_GET_CACHE_INFORMATION = 0x000740d4U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_set_cache_information
enum uint IOCTL_DISK_SET_CACHE_INFORMATION = 0x0007c0d8U;
enum uint IOCTL_DISK_GET_WRITE_CACHE_STATE = 0x000740dcU;
enum uint OBSOLETE_DISK_GET_WRITE_CACHE_STATE = 0x000740dcU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_delete_drive_layout
enum uint IOCTL_DISK_DELETE_DRIVE_LAYOUT = 0x0007c100U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_update_properties
enum uint IOCTL_DISK_UPDATE_PROPERTIES = 0x00070140U;

enum : uint
{
    IOCTL_DISK_FORMAT_DRIVE     = 0x0007c3ccU,
    IOCTL_DISK_SENSE_DEVICE     = 0x000703e0U,
    IOCTL_DISK_CHECK_VERIFY     = 0x00074800U,
    IOCTL_DISK_MEDIA_REMOVAL    = 0x00074804U,
    IOCTL_DISK_EJECT_MEDIA      = 0x00074808U,
    IOCTL_DISK_LOAD_MEDIA       = 0x0007480cU,
    IOCTL_DISK_RESERVE          = 0x00074810U,
    IOCTL_DISK_RELEASE          = 0x00074814U,
    IOCTL_DISK_FIND_NEW_DEVICES = 0x00074818U,
    IOCTL_DISK_GET_MEDIA_TYPES  = 0x00070c00U,
}

enum : uint
{
    PARTITION_ENTRY_UNUSED    = 0x00000000U,
    PARTITION_FAT_12          = 0x00000001U,
    PARTITION_XENIX_1         = 0x00000002U,
    PARTITION_XENIX_2         = 0x00000003U,
    PARTITION_FAT_16          = 0x00000004U,
    PARTITION_EXTENDED        = 0x00000005U,
    PARTITION_HUGE            = 0x00000006U,
    PARTITION_IFS             = 0x00000007U,
    PARTITION_OS2BOOTMGR      = 0x0000000aU,
    PARTITION_FAT32           = 0x0000000bU,
    PARTITION_FAT32_XINT13    = 0x0000000cU,
    PARTITION_XINT13          = 0x0000000eU,
    PARTITION_XINT13_EXTENDED = 0x0000000fU,
}

enum : uint
{
    PARTITION_MSFT_RECOVERY = 0x00000027U,
    PARTITION_MAIN_OS       = 0x00000028U,
}

enum uint PARTIITON_OS_DATA = 0x00000029U;

enum : uint
{
    PARTITION_PRE_INSTALLED  = 0x0000002aU,
    PARTITION_BSP            = 0x0000002bU,
    PARTITION_DPP            = 0x0000002cU,
    PARTITION_WINDOWS_SYSTEM = 0x0000002dU,
    PARTITION_PREP           = 0x00000041U,
    PARTITION_LDM            = 0x00000042U,
    PARTITION_DM             = 0x00000054U,
    PARTITION_EZDRIVE        = 0x00000055U,
    PARTITION_UNIX           = 0x00000063U,
    PARTITION_SPACES_DATA    = 0x000000d7U,
    PARTITION_SPACES         = 0x000000e7U,
    PARTITION_GPT            = 0x000000eeU,
    PARTITION_SYSTEM         = 0x000000efU,
}

enum uint VALID_NTFT = 0x000000c0U;
enum uint PARTITION_NTFT = 0x00000080U;
enum GUID WMI_DISK_GEOMETRY_GUID = GUID("25007f51-57c2-11d1-a528-00a0c9062910");

enum : ulong
{
    GPT_ATTRIBUTE_NO_BLOCK_IO_PROTOCOL = 0x0000000000000002UL,
    GPT_ATTRIBUTE_LEGACY_BIOS_BOOTABLE = 0x0000000000000004UL,
}

enum : ulong
{
    GPT_BASIC_DATA_ATTRIBUTE_OFFLINE = 0x0800000000000000UL,
    GPT_BASIC_DATA_ATTRIBUTE_DAX     = 0x0400000000000000UL,
    GPT_BASIC_DATA_ATTRIBUTE_SERVICE = 0x0200000000000000UL,
}

enum ulong GPT_SPACES_ATTRIBUTE_NO_METADATA = 0x8000000000000000UL;
enum uint HIST_NO_OF_BUCKETS = 0x00000018U;

enum : uint
{
    DISK_LOGGING_START = 0x00000000U,
    DISK_LOGGING_STOP  = 0x00000001U,
    DISK_LOGGING_DUMP  = 0x00000002U,
}

enum uint DISK_BINNING = 0x00000003U;

enum : uint
{
    CAP_ATA_ID_CMD   = 0x00000001U,
    CAP_ATAPI_ID_CMD = 0x00000002U,
}

enum uint CAP_SMART_CMD = 0x00000004U;
enum uint ATAPI_ID_CMD = 0x000000a1U;
enum uint ID_CMD = 0x000000ecU;

enum : uint
{
    SMART_CMD             = 0x000000b0U,
    SMART_CYL_LOW         = 0x0000004fU,
    SMART_CYL_HI          = 0x000000c2U,
    SMART_NO_ERROR        = 0x00000000U,
    SMART_IDE_ERROR       = 0x00000001U,
    SMART_INVALID_FLAG    = 0x00000002U,
    SMART_INVALID_COMMAND = 0x00000003U,
    SMART_INVALID_BUFFER  = 0x00000004U,
    SMART_INVALID_DRIVE   = 0x00000005U,
    SMART_INVALID_IOCTL   = 0x00000006U,
}

enum uint SMART_ERROR_NO_MEM = 0x00000007U;
enum uint SMART_INVALID_REGISTER = 0x00000008U;

enum : uint
{
    SMART_NOT_SUPPORTED = 0x00000009U,
    SMART_NO_IDE_DEVICE = 0x0000000aU,
}

enum uint SMART_OFFLINE_ROUTINE_OFFLINE = 0x00000000U;
enum uint SMART_SHORT_SELFTEST_OFFLINE = 0x00000001U;
enum uint SMART_EXTENDED_SELFTEST_OFFLINE = 0x00000002U;
enum uint SMART_ABORT_OFFLINE_SELFTEST = 0x0000007fU;
enum uint SMART_SHORT_SELFTEST_CAPTIVE = 0x00000081U;
enum uint SMART_EXTENDED_SELFTEST_CAPTIVE = 0x00000082U;
enum uint READ_ATTRIBUTE_BUFFER_SIZE = 0x00000200U;
enum uint IDENTIFY_BUFFER_SIZE = 0x00000200U;
enum uint READ_THRESHOLD_BUFFER_SIZE = 0x00000200U;
enum uint SMART_LOG_SECTOR_SIZE = 0x00000200U;
enum uint READ_ATTRIBUTES = 0x000000d0U;
enum uint READ_THRESHOLDS = 0x000000d1U;
enum uint ENABLE_DISABLE_AUTOSAVE = 0x000000d2U;
enum uint SAVE_ATTRIBUTE_VALUES = 0x000000d3U;
enum uint EXECUTE_OFFLINE_DIAGS = 0x000000d4U;

enum : uint
{
    SMART_READ_LOG  = 0x000000d5U,
    SMART_WRITE_LOG = 0x000000d6U,
}

enum uint ENABLE_SMART = 0x000000d8U;
enum uint DISABLE_SMART = 0x000000d9U;
enum uint RETURN_SMART_STATUS = 0x000000daU;
enum uint ENABLE_DISABLE_AUTO_OFFLINE = 0x000000dbU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_get_disk_attributes
enum uint IOCTL_DISK_GET_DISK_ATTRIBUTES = 0x000700f0U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_set_disk_attributes
enum uint IOCTL_DISK_SET_DISK_ATTRIBUTES = 0x0007c0f4U;

enum : ulong
{
    DISK_ATTRIBUTE_OFFLINE   = 0x0000000000000001UL,
    DISK_ATTRIBUTE_READ_ONLY = 0x0000000000000002UL,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_disk_reset_snapshot_info
enum uint IOCTL_DISK_RESET_SNAPSHOT_INFO = 0x0007c210U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_changer_get_parameters
    IOCTL_CHANGER_GET_PARAMETERS            = 0x00304000U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_changer_get_status
    IOCTL_CHANGER_GET_STATUS                = 0x00304004U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_changer_get_product_data
    IOCTL_CHANGER_GET_PRODUCT_DATA          = 0x00304008U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_changer_set_access
    IOCTL_CHANGER_SET_ACCESS                = 0x0030c010U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_changer_get_element_status
    IOCTL_CHANGER_GET_ELEMENT_STATUS        = 0x0030c014U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_changer_initialize_element_status
    IOCTL_CHANGER_INITIALIZE_ELEMENT_STATUS = 0x00304018U,
}

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_changer_set_position
    IOCTL_CHANGER_SET_POSITION           = 0x0030401cU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_changer_exchange_medium
    IOCTL_CHANGER_EXCHANGE_MEDIUM        = 0x00304020U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_changer_move_medium
    IOCTL_CHANGER_MOVE_MEDIUM            = 0x00304024U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_changer_reinitialize_transport
    IOCTL_CHANGER_REINITIALIZE_TRANSPORT = 0x00304028U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_changer_query_volume_tags
enum uint IOCTL_CHANGER_QUERY_VOLUME_TAGS = 0x0030c02cU;

enum : uint
{
    MAX_VOLUME_ID_SIZE       = 0x00000024U,
    MAX_VOLUME_TEMPLATE_SIZE = 0x00000028U,
}

enum uint VENDOR_ID_LENGTH = 0x00000008U;
enum uint PRODUCT_ID_LENGTH = 0x00000010U;
enum uint REVISION_LENGTH = 0x00000004U;
enum uint SERIAL_NUMBER_LENGTH = 0x00000020U;
enum uint CHANGER_RESERVED_BIT = 0x80000000U;

enum : uint
{
    CHANGER_TO_TRANSPORT = 0x00000001U,
    CHANGER_TO_SLOT      = 0x00000002U,
    CHANGER_TO_IEPORT    = 0x00000004U,
    CHANGER_TO_DRIVE     = 0x00000008U,
}

enum : uint
{
    LOCK_UNLOCK_IEPORT = 0x00000001U,
    LOCK_UNLOCK_DOOR   = 0x00000002U,
    LOCK_UNLOCK_KEYPAD = 0x00000004U,
}

enum uint LOCK_ELEMENT = 0x00000000U;
enum uint UNLOCK_ELEMENT = 0x00000001U;
enum uint EXTEND_IEPORT = 0x00000002U;
enum uint RETRACT_IEPORT = 0x00000003U;

enum : uint
{
    ERROR_LABEL_UNREADABLE   = 0x00000001U,
    ERROR_LABEL_QUESTIONABLE = 0x00000002U,
}

enum uint ERROR_SLOT_NOT_PRESENT = 0x00000004U;
enum uint ERROR_DRIVE_NOT_INSTALLED = 0x00000008U;
enum uint ERROR_TRAY_MALFUNCTION = 0x00000010U;
enum uint ERROR_INIT_STATUS_NEEDED = 0x00000011U;
enum uint ERROR_UNHANDLED_ERROR = 0xffffffffU;

enum : uint
{
    SEARCH_ALL        = 0x00000000U,
    SEARCH_PRIMARY    = 0x00000001U,
    SEARCH_ALTERNATE  = 0x00000002U,
    SEARCH_ALL_NO_SEQ = 0x00000004U,
    SEARCH_PRI_NO_SEQ = 0x00000005U,
    SEARCH_ALT_NO_SEQ = 0x00000006U,
}

enum : uint
{
    ASSERT_PRIMARY   = 0x00000008U,
    ASSERT_ALTERNATE = 0x00000009U,
}

enum : uint
{
    REPLACE_PRIMARY   = 0x0000000aU,
    REPLACE_ALTERNATE = 0x0000000bU,
}

enum : uint
{
    UNDEFINE_PRIMARY   = 0x0000000cU,
    UNDEFINE_ALTERNATE = 0x0000000dU,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-ioctl_serial_lsrmst_insert
enum uint IOCTL_SERIAL_LSRMST_INSERT = 0x001b007cU;

enum : uint
{
    IOCTL_SERENUM_EXPOSE_HARDWARE = 0x00370200U,
    IOCTL_SERENUM_REMOVE_HARDWARE = 0x00370204U,
    IOCTL_SERENUM_PORT_DESC       = 0x00370208U,
    IOCTL_SERENUM_GET_PORT_NAME   = 0x0037020cU,
}

enum : uint
{
    SERIAL_IOC_FCR_FIFO_ENABLE      = 0x00000001U,
    SERIAL_IOC_FCR_RCVR_RESET       = 0x00000002U,
    SERIAL_IOC_FCR_XMIT_RESET       = 0x00000004U,
    SERIAL_IOC_FCR_DMA_MODE         = 0x00000008U,
    SERIAL_IOC_FCR_RES1             = 0x00000010U,
    SERIAL_IOC_FCR_RES2             = 0x00000020U,
    SERIAL_IOC_FCR_RCVR_TRIGGER_LSB = 0x00000040U,
    SERIAL_IOC_FCR_RCVR_TRIGGER_MSB = 0x00000080U,
}

enum : uint
{
    SERIAL_IOC_MCR_DTR  = 0x00000001U,
    SERIAL_IOC_MCR_RTS  = 0x00000002U,
    SERIAL_IOC_MCR_OUT1 = 0x00000004U,
    SERIAL_IOC_MCR_OUT2 = 0x00000008U,
    SERIAL_IOC_MCR_LOOP = 0x00000010U,
}

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_request_oplock_level_1
    FSCTL_REQUEST_OPLOCK_LEVEL_1 = 0x00090000U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_request_oplock_level_2
    FSCTL_REQUEST_OPLOCK_LEVEL_2 = 0x00090004U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_request_batch_oplock
    FSCTL_REQUEST_BATCH_OPLOCK   = 0x00090008U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_oplock_break_acknowledge
enum uint FSCTL_OPLOCK_BREAK_ACKNOWLEDGE = 0x0009000cU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_opbatch_ack_close_pending
enum uint FSCTL_OPBATCH_ACK_CLOSE_PENDING = 0x00090010U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_oplock_break_notify
enum uint FSCTL_OPLOCK_BREAK_NOTIFY = 0x00090014U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_lock_volume
enum uint FSCTL_LOCK_VOLUME = 0x00090018U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_unlock_volume
enum uint FSCTL_UNLOCK_VOLUME = 0x0009001cU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_dismount_volume
enum uint FSCTL_DISMOUNT_VOLUME = 0x00090020U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_is_volume_mounted
enum uint FSCTL_IS_VOLUME_MOUNTED = 0x00090028U;
enum uint FSCTL_IS_PATHNAME_VALID = 0x0009002cU;
enum uint FSCTL_MARK_VOLUME_DIRTY = 0x00090030U;
enum uint FSCTL_QUERY_RETRIEVAL_POINTERS = 0x0009003bU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_get_compression
enum uint FSCTL_GET_COMPRESSION = 0x0009003cU;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_set_compression
    FSCTL_SET_COMPRESSION         = 0x0009c040U,
    FSCTL_SET_BOOTLOADER_ACCESSED = 0x0009004fU,
}

enum uint FSCTL_MARK_AS_SYSTEM_HIVE = 0x0009004fU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_oplock_break_ack_no_2
enum uint FSCTL_OPLOCK_BREAK_ACK_NO_2 = 0x00090050U;
enum uint FSCTL_INVALIDATE_VOLUMES = 0x00090054U;
enum uint FSCTL_QUERY_FAT_BPB = 0x00090058U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_request_filter_oplock
enum uint FSCTL_REQUEST_FILTER_OPLOCK = 0x0009005cU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_filesystem_get_statistics
enum uint FSCTL_FILESYSTEM_GET_STATISTICS = 0x00090060U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_get_ntfs_volume_data
    FSCTL_GET_NTFS_VOLUME_DATA = 0x00090064U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_get_ntfs_file_record
    FSCTL_GET_NTFS_FILE_RECORD = 0x00090068U,
}

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_get_volume_bitmap
    FSCTL_GET_VOLUME_BITMAP      = 0x0009006fU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_get_retrieval_pointers
    FSCTL_GET_RETRIEVAL_POINTERS = 0x00090073U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_move_file
enum uint FSCTL_MOVE_FILE = 0x00090074U;
enum uint FSCTL_IS_VOLUME_DIRTY = 0x00090078U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_allow_extended_dasd_io
enum uint FSCTL_ALLOW_EXTENDED_DASD_IO = 0x00090083U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_find_files_by_sid
enum uint FSCTL_FIND_FILES_BY_SID = 0x0009008fU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_set_object_id
enum uint FSCTL_SET_OBJECT_ID = 0x00090098U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_get_object_id
enum uint FSCTL_GET_OBJECT_ID = 0x0009009cU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_delete_object_id
enum uint FSCTL_DELETE_OBJECT_ID = 0x000900a0U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_set_reparse_point
enum uint FSCTL_SET_REPARSE_POINT = 0x000900a4U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_get_reparse_point
enum uint FSCTL_GET_REPARSE_POINT = 0x000900a8U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_delete_reparse_point
enum uint FSCTL_DELETE_REPARSE_POINT = 0x000900acU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_enum_usn_data
enum uint FSCTL_ENUM_USN_DATA = 0x000900b3U;
enum uint FSCTL_SECURITY_ID_CHECK = 0x000940b7U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_read_usn_journal
enum uint FSCTL_READ_USN_JOURNAL = 0x000900bbU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_set_object_id_extended
enum uint FSCTL_SET_OBJECT_ID_EXTENDED = 0x000900bcU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_create_or_get_object_id
enum uint FSCTL_CREATE_OR_GET_OBJECT_ID = 0x000900c0U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_set_sparse
    FSCTL_SET_SPARSE    = 0x000900c4U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_set_zero_data
    FSCTL_SET_ZERO_DATA = 0x000980c8U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_query_allocated_ranges
enum uint FSCTL_QUERY_ALLOCATED_RANGES = 0x000940cfU;
enum uint FSCTL_ENABLE_UPGRADE = 0x000980d0U;
enum uint FSCTL_SET_ENCRYPTION = 0x000900d7U;
enum uint FSCTL_ENCRYPTION_FSCTL_IO = 0x000900dbU;
enum uint FSCTL_WRITE_RAW_ENCRYPTED = 0x000900dfU;
enum uint FSCTL_READ_RAW_ENCRYPTED = 0x000900e3U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_create_usn_journal
enum uint FSCTL_CREATE_USN_JOURNAL = 0x000900e7U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_read_file_usn_data
enum uint FSCTL_READ_FILE_USN_DATA = 0x000900ebU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_write_usn_close_record
enum uint FSCTL_WRITE_USN_CLOSE_RECORD = 0x000900efU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_extend_volume
enum uint FSCTL_EXTEND_VOLUME = 0x000900f0U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_query_usn_journal
enum uint FSCTL_QUERY_USN_JOURNAL = 0x000900f4U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_delete_usn_journal
enum uint FSCTL_DELETE_USN_JOURNAL = 0x000900f8U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_mark_handle
enum uint FSCTL_MARK_HANDLE = 0x000900fcU;

enum : uint
{
    FSCTL_SIS_COPYFILE   = 0x00090100U,
    FSCTL_SIS_LINK_FILES = 0x0009c104U,
}

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_recall_file
    FSCTL_RECALL_FILE    = 0x00090117U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_read_from_plex
    FSCTL_READ_FROM_PLEX = 0x0009411eU,
}

enum uint FSCTL_FILE_PREFETCH = 0x00090120U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_make_media_compatible
enum uint FSCTL_MAKE_MEDIA_COMPATIBLE = 0x00098130U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_set_defect_management
enum uint FSCTL_SET_DEFECT_MANAGEMENT = 0x00098134U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_query_sparing_info
    FSCTL_QUERY_SPARING_INFO        = 0x00090138U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_query_on_disk_volume_info
    FSCTL_QUERY_ON_DISK_VOLUME_INFO = 0x0009013cU,
}

enum uint FSCTL_SET_VOLUME_COMPRESSION_STATE = 0x00090140U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_txfs_modify_rm
    FSCTL_TXFS_MODIFY_RM            = 0x00098144U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_txfs_query_rm_information
    FSCTL_TXFS_QUERY_RM_INFORMATION = 0x00094148U,
}

enum : uint
{
    FSCTL_TXFS_ROLLFORWARD_REDO        = 0x00098150U,
    FSCTL_TXFS_ROLLFORWARD_UNDO        = 0x00098154U,
    FSCTL_TXFS_START_RM                = 0x00098158U,
    FSCTL_TXFS_SHUTDOWN_RM             = 0x0009815cU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_txfs_read_backup_information
    FSCTL_TXFS_READ_BACKUP_INFORMATION = 0x00094160U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_txfs_write_backup_information
enum uint FSCTL_TXFS_WRITE_BACKUP_INFORMATION = 0x00098164U;
enum uint FSCTL_TXFS_CREATE_SECONDARY_RM = 0x00098168U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_txfs_get_metadata_info
    FSCTL_TXFS_GET_METADATA_INFO      = 0x0009416cU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_txfs_get_transacted_version
    FSCTL_TXFS_GET_TRANSACTED_VERSION = 0x00094170U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_txfs_savepoint_information
enum uint FSCTL_TXFS_SAVEPOINT_INFORMATION = 0x00098178U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_txfs_create_miniversion
enum uint FSCTL_TXFS_CREATE_MINIVERSION = 0x0009817cU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_txfs_transaction_active
enum uint FSCTL_TXFS_TRANSACTION_ACTIVE = 0x0009418cU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_set_zero_on_deallocation
enum uint FSCTL_SET_ZERO_ON_DEALLOCATION = 0x00090194U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_set_repair
enum uint FSCTL_SET_REPAIR = 0x00090198U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_get_repair
enum uint FSCTL_GET_REPAIR = 0x0009019cU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_wait_for_repair
enum uint FSCTL_WAIT_FOR_REPAIR = 0x000901a0U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_initiate_repair
enum uint FSCTL_INITIATE_REPAIR = 0x000901a8U;
enum uint FSCTL_CSC_INTERNAL = 0x000901afU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_shrink_volume
enum uint FSCTL_SHRINK_VOLUME = 0x000901b0U;
enum uint FSCTL_SET_SHORT_NAME_BEHAVIOR = 0x000901b4U;
enum uint FSCTL_DFSR_SET_GHOST_HANDLE_STATE = 0x000901b8U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_txfs_list_transaction_locked_files
    FSCTL_TXFS_LIST_TRANSACTION_LOCKED_FILES = 0x000941e0U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_txfs_list_transactions
    FSCTL_TXFS_LIST_TRANSACTIONS             = 0x000941e4U,
}

enum uint FSCTL_QUERY_PAGEFILE_ENCRYPTION = 0x000901e8U;
enum uint FSCTL_RESET_VOLUME_ALLOCATION_HINTS = 0x000901ecU;
enum uint FSCTL_QUERY_DEPENDENT_VOLUME = 0x000901f0U;
enum uint FSCTL_SD_GLOBAL_CHANGE = 0x000901f4U;
enum uint FSCTL_TXFS_READ_BACKUP_INFORMATION2 = 0x000901f8U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_lookup_stream_from_cluster
enum uint FSCTL_LOOKUP_STREAM_FROM_CLUSTER = 0x000901fcU;
enum uint FSCTL_TXFS_WRITE_BACKUP_INFORMATION2 = 0x00090200U;
enum uint FSCTL_FILE_TYPE_NOTIFICATION = 0x00090204U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_file_level_trim
enum uint FSCTL_FILE_LEVEL_TRIM = 0x00098208U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_get_boot_area_info
    FSCTL_GET_BOOT_AREA_INFO         = 0x00090230U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_get_retrieval_pointer_base
    FSCTL_GET_RETRIEVAL_POINTER_BASE = 0x00090234U,
}

enum uint FSCTL_SET_PERSISTENT_VOLUME_STATE = 0x00090238U;
enum uint FSCTL_QUERY_PERSISTENT_VOLUME_STATE = 0x0009023cU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_request_oplock
enum uint FSCTL_REQUEST_OPLOCK = 0x00090240U;
enum uint FSCTL_CSV_TUNNEL_REQUEST = 0x00090244U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_is_csv_file
enum uint FSCTL_IS_CSV_FILE = 0x00090248U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_query_file_system_recognition
enum uint FSCTL_QUERY_FILE_SYSTEM_RECOGNITION = 0x0009024cU;

enum : uint
{
    FSCTL_CSV_GET_VOLUME_PATH_NAME                   = 0x00090250U,
    FSCTL_CSV_GET_VOLUME_NAME_FOR_VOLUME_MOUNT_POINT = 0x00090254U,
    FSCTL_CSV_GET_VOLUME_PATH_NAMES_FOR_VOLUME_NAME  = 0x00090258U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_is_file_on_csv_volume
enum uint FSCTL_IS_FILE_ON_CSV_VOLUME = 0x0009025cU;
enum uint FSCTL_CORRUPTION_HANDLING = 0x00090260U;

enum : uint
{
    FSCTL_OFFLOAD_READ  = 0x00094264U,
    FSCTL_OFFLOAD_WRITE = 0x00098268U,
}

enum uint FSCTL_CSV_INTERNAL = 0x0009026cU;
enum uint FSCTL_SET_PURGE_FAILURE_MODE = 0x00090270U;
enum uint FSCTL_QUERY_FILE_LAYOUT = 0x00090277U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_is_volume_owned_bycsvfs
enum uint FSCTL_IS_VOLUME_OWNED_BYCSVFS = 0x00090278U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_get_integrity_information
enum uint FSCTL_GET_INTEGRITY_INFORMATION = 0x0009027cU;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_set_integrity_information
enum uint FSCTL_SET_INTEGRITY_INFORMATION = 0x0009c280U;
enum uint FSCTL_QUERY_FILE_REGIONS = 0x00090284U;
enum uint FSCTL_RKF_INTERNAL = 0x000902afU;
enum uint FSCTL_SCRUB_DATA = 0x000902b0U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_repair_copies
enum uint FSCTL_REPAIR_COPIES = 0x0009c2b4U;
enum uint FSCTL_DISABLE_LOCAL_BUFFERING = 0x000902b8U;

enum : uint
{
    FSCTL_CSV_MGMT_LOCK                                    = 0x000902bcU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_csv_query_down_level_file_system_characteristics
    FSCTL_CSV_QUERY_DOWN_LEVEL_FILE_SYSTEM_CHARACTERISTICS = 0x000902c0U,
}

enum uint FSCTL_ADVANCE_FILE_ID = 0x000902c4U;
enum uint FSCTL_CSV_SYNC_TUNNEL_REQUEST = 0x000902c8U;
enum uint FSCTL_CSV_QUERY_VETO_FILE_DIRECT_IO = 0x000902ccU;
enum uint FSCTL_WRITE_USN_REASON = 0x000902d0U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_csv_control
enum uint FSCTL_CSV_CONTROL = 0x000902d4U;
enum uint FSCTL_GET_REFS_VOLUME_DATA = 0x000902d8U;
enum uint FSCTL_CSV_H_BREAKING_SYNC_TUNNEL_REQUEST = 0x000902e4U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_query_storage_classes
    FSCTL_QUERY_STORAGE_CLASSES = 0x000902ecU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_query_region_info
    FSCTL_QUERY_REGION_INFO     = 0x000902f0U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_usn_track_modified_ranges
enum uint FSCTL_USN_TRACK_MODIFIED_RANGES = 0x000902f4U;
enum uint FSCTL_QUERY_SHARED_VIRTUAL_DISK_SUPPORT = 0x00090300U;

enum : uint
{
    FSCTL_SVHDX_SYNC_TUNNEL_REQUEST       = 0x00090304U,
    FSCTL_SVHDX_SET_INITIATOR_INFORMATION = 0x00090308U,
}

enum uint FSCTL_SET_EXTERNAL_BACKING = 0x0009030cU;
enum uint FSCTL_GET_EXTERNAL_BACKING = 0x00090310U;
enum uint FSCTL_DELETE_EXTERNAL_BACKING = 0x00090314U;

enum : uint
{
    FSCTL_ENUM_EXTERNAL_BACKING = 0x00090318U,
    FSCTL_ENUM_OVERLAY          = 0x0009031fU,
}

enum uint FSCTL_ADD_OVERLAY = 0x00098330U;
enum uint FSCTL_REMOVE_OVERLAY = 0x00098334U;
enum uint FSCTL_UPDATE_OVERLAY = 0x00098338U;
enum uint FSCTL_SHUFFLE_FILE = 0x0009c340U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_duplicate_extents_to_file
enum uint FSCTL_DUPLICATE_EXTENTS_TO_FILE = 0x00098344U;
enum uint FSCTL_SPARSE_OVERALLOCATE = 0x0009034cU;
enum uint FSCTL_STORAGE_QOS_CONTROL = 0x00090350U;
enum uint FSCTL_INITIATE_FILE_METADATA_OPTIMIZATION = 0x0009035cU;
enum uint FSCTL_QUERY_FILE_METADATA_OPTIMIZATION = 0x00090360U;
enum uint FSCTL_SVHDX_ASYNC_TUNNEL_REQUEST = 0x00090364U;
enum uint FSCTL_GET_WOF_VERSION = 0x00090368U;
enum uint FSCTL_HCS_SYNC_TUNNEL_REQUEST = 0x0009036cU;
enum uint FSCTL_HCS_ASYNC_TUNNEL_REQUEST = 0x00090370U;
enum uint FSCTL_QUERY_EXTENT_READ_CACHE_INFO = 0x00090377U;
enum uint FSCTL_QUERY_REFS_VOLUME_COUNTER_INFO = 0x0009037bU;
enum uint FSCTL_CLEAN_VOLUME_METADATA = 0x0009037cU;
enum uint FSCTL_SET_INTEGRITY_INFORMATION_EX = 0x00090380U;
enum uint FSCTL_SUSPEND_OVERLAY = 0x00090384U;
enum uint FSCTL_VIRTUAL_STORAGE_QUERY_PROPERTY = 0x00090388U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ni-winioctl-fsctl_filesystem_get_statistics_ex
enum uint FSCTL_FILESYSTEM_GET_STATISTICS_EX = 0x0009038cU;
enum uint FSCTL_QUERY_VOLUME_CONTAINER_STATE = 0x00090390U;
enum uint FSCTL_SET_LAYER_ROOT = 0x00090394U;
enum uint FSCTL_QUERY_DIRECT_ACCESS_EXTENTS = 0x0009039bU;
enum uint FSCTL_NOTIFY_STORAGE_SPACE_ALLOCATION = 0x0009039cU;
enum uint FSCTL_SSDI_STORAGE_REQUEST = 0x000903a0U;
enum uint FSCTL_QUERY_DIRECT_IMAGE_ORIGINAL_BASE = 0x000903a4U;
enum uint FSCTL_READ_UNPRIVILEGED_USN_JOURNAL = 0x000903abU;
enum uint FSCTL_GHOST_FILE_EXTENTS = 0x000983acU;
enum uint FSCTL_QUERY_GHOSTED_FILE_EXTENTS = 0x000903b0U;
enum uint FSCTL_UNMAP_SPACE = 0x000903b4U;
enum uint FSCTL_HCS_SYNC_NO_WRITE_TUNNEL_REQUEST = 0x000903b8U;
enum uint FSCTL_START_VIRTUALIZATION_INSTANCE = 0x000903c0U;
enum uint FSCTL_GET_FILTER_FILE_IDENTIFIER = 0x000903c4U;

enum : uint
{
    FSCTL_STREAMS_QUERY_PARAMETERS = 0x000903c4U,
    FSCTL_STREAMS_ASSOCIATE_ID     = 0x000903c8U,
    FSCTL_STREAMS_QUERY_ID         = 0x000903ccU,
}

enum uint FSCTL_GET_RETRIEVAL_POINTERS_AND_REFCOUNT = 0x000903d3U;
enum uint FSCTL_QUERY_VOLUME_NUMA_INFO = 0x000903d4U;
enum uint FSCTL_REFS_DEALLOCATE_RANGES = 0x000903d8U;
enum uint FSCTL_QUERY_REFS_SMR_VOLUME_INFO = 0x000903dcU;
enum uint FSCTL_SET_REFS_SMR_VOLUME_GC_PARAMETERS = 0x000903e0U;
enum uint FSCTL_SET_REFS_FILE_STRICTLY_SEQUENTIAL = 0x000903e4U;
enum uint FSCTL_DUPLICATE_EXTENTS_TO_FILE_EX = 0x000983e8U;
enum uint FSCTL_QUERY_BAD_RANGES = 0x000903ecU;
enum uint FSCTL_SET_DAX_ALLOC_ALIGNMENT_HINT = 0x000903f0U;
enum uint FSCTL_DELETE_CORRUPTED_REFS_CONTAINER = 0x000903f4U;
enum uint FSCTL_SCRUB_UNDISCOVERABLE_ID = 0x000903f8U;
enum uint FSCTL_NOTIFY_DATA_CHANGE = 0x000903fcU;
enum uint FSCTL_START_VIRTUALIZATION_INSTANCE_EX = 0x00090400U;
enum uint FSCTL_ENCRYPTION_KEY_CONTROL = 0x00090404U;
enum uint FSCTL_VIRTUAL_STORAGE_SET_BEHAVIOR = 0x00090408U;
enum uint FSCTL_SET_REPARSE_POINT_EX = 0x0009040cU;
enum uint FSCTL_REARRANGE_FILE = 0x0009c420U;
enum uint FSCTL_VIRTUAL_STORAGE_PASSTHROUGH = 0x00090424U;
enum uint FSCTL_GET_RETRIEVAL_POINTER_COUNT = 0x0009042bU;
enum uint FSCTL_ENABLE_PER_IO_FLAGS = 0x0009042cU;
enum uint FSCTL_QUERY_ASYNC_DUPLICATE_EXTENTS_STATUS = 0x00090430U;
enum uint FSCTL_SMB_SHARE_FLUSH_AND_PURGE = 0x0009043cU;
enum uint FSCTL_REFS_STREAM_SNAPSHOT_MANAGEMENT = 0x00090440U;
enum uint FSCTL_MANAGE_BYPASS_IO = 0x00090448U;
enum uint FSCTL_REFS_DEALLOCATE_RANGES_EX = 0x0009044cU;
enum uint FSCTL_SET_CACHED_RUNS_STATE = 0x00090450U;
enum uint FSCTL_REFS_SET_VOLUME_COMPRESSION_INFO = 0x00090454U;
enum uint FSCTL_REFS_QUERY_VOLUME_COMPRESSION_INFO = 0x00090458U;
enum uint FSCTL_DUPLICATE_CLUSTER = 0x0009045cU;
enum uint FSCTL_CREATE_LCN_WEAK_REFERENCE = 0x00090460U;
enum uint FSCTL_CLEAR_LCN_WEAK_REFERENCE = 0x00090464U;
enum uint FSCTL_QUERY_LCN_WEAK_REFERENCE = 0x00090468U;
enum uint FSCTL_CLEAR_ALL_LCN_WEAK_REFERENCES = 0x0009046cU;
enum uint FSCTL_REFS_SET_VOLUME_DEDUP_INFO = 0x00090470U;
enum uint FSCTL_REFS_QUERY_VOLUME_DEDUP_INFO = 0x00090474U;
enum uint FSCTL_LMR_QUERY_INFO = 0x00090478U;
enum uint FSCTL_REFS_CHECKPOINT_VOLUME = 0x0009047cU;
enum uint FSCTL_REFS_QUERY_VOLUME_TOTAL_SHARED_LCNS = 0x00090480U;
enum uint FSCTL_UPGRADE_VOLUME = 0x00090484U;
enum uint FSCTL_REFS_SET_VOLUME_IO_METRICS_INFO = 0x00090488U;
enum uint FSCTL_REFS_QUERY_VOLUME_IO_METRICS_INFO = 0x0009048cU;
enum uint FSCTL_REFS_SET_ROLLBACK_PROTECTION_INFO = 0x00090490U;
enum uint FSCTL_REFS_QUERY_ROLLBACK_PROTECTION_INFO = 0x00090494U;
enum uint FSCTL_FILE_SOV_CHECK_RANGE = 0x00090498U;
enum uint FSCTL_CASCADES_REFS_SET_FILE_REMOTE = 0x0009049cU;
enum uint GET_VOLUME_BITMAP_FLAG_MASK_METADATA = 0x00000001U;
enum uint FLAG_USN_TRACK_MODIFIED_RANGES_ENABLE = 0x00000001U;
enum uint USN_PAGE_SIZE = 0x00001000U;

enum : uint
{
    USN_REASON_DATA_OVERWRITE        = 0x00000001U,
    USN_REASON_DATA_EXTEND           = 0x00000002U,
    USN_REASON_DATA_TRUNCATION       = 0x00000004U,
    USN_REASON_NAMED_DATA_OVERWRITE  = 0x00000010U,
    USN_REASON_NAMED_DATA_EXTEND     = 0x00000020U,
    USN_REASON_NAMED_DATA_TRUNCATION = 0x00000040U,
}

enum : uint
{
    USN_REASON_FILE_CREATE       = 0x00000100U,
    USN_REASON_FILE_DELETE       = 0x00000200U,
    USN_REASON_EA_CHANGE         = 0x00000400U,
    USN_REASON_SECURITY_CHANGE   = 0x00000800U,
    USN_REASON_RENAME_OLD_NAME   = 0x00001000U,
    USN_REASON_RENAME_NEW_NAME   = 0x00002000U,
    USN_REASON_INDEXABLE_CHANGE  = 0x00004000U,
    USN_REASON_BASIC_INFO_CHANGE = 0x00008000U,
}

enum : uint
{
    USN_REASON_HARD_LINK_CHANGE   = 0x00010000U,
    USN_REASON_COMPRESSION_CHANGE = 0x00020000U,
}

enum uint USN_REASON_ENCRYPTION_CHANGE = 0x00040000U;

enum : uint
{
    USN_REASON_OBJECT_ID_CHANGE     = 0x00080000U,
    USN_REASON_REPARSE_POINT_CHANGE = 0x00100000U,
}

enum : uint
{
    USN_REASON_STREAM_CHANGE     = 0x00200000U,
    USN_REASON_TRANSACTED_CHANGE = 0x00400000U,
}

enum : uint
{
    USN_REASON_INTEGRITY_CHANGE             = 0x00800000U,
    USN_REASON_DESIRED_STORAGE_CLASS_CHANGE = 0x01000000U,
}

enum uint USN_REASON_CLOSE = 0x80000000U;
enum uint USN_DELETE_VALID_FLAGS = 0x00000003U;

enum : uint
{
    MARK_HANDLE_PROTECT_CLUSTERS   = 0x00000001U,
    MARK_HANDLE_TXF_SYSTEM_LOG     = 0x00000004U,
    MARK_HANDLE_NOT_TXF_SYSTEM_LOG = 0x00000008U,
}

enum : uint
{
    MARK_HANDLE_REALTIME             = 0x00000020U,
    MARK_HANDLE_NOT_REALTIME         = 0x00000040U,
    MARK_HANDLE_CLOUD_SYNC           = 0x00000800U,
    MARK_HANDLE_READ_COPY            = 0x00000080U,
    MARK_HANDLE_NOT_READ_COPY        = 0x00000100U,
    MARK_HANDLE_FILTER_METADATA      = 0x00000200U,
    MARK_HANDLE_RETURN_PURGE_FAILURE = 0x00000400U,
}

enum uint MARK_HANDLE_DISABLE_FILE_METADATA_OPTIMIZATION = 0x00001000U;
enum uint MARK_HANDLE_ENABLE_USN_SOURCE_ON_PAGING_IO = 0x00002000U;
enum uint MARK_HANDLE_SKIP_COHERENCY_SYNC_DISALLOW_WRITES = 0x00004000U;
enum uint MARK_HANDLE_SUPPRESS_VOLUME_OPEN_FLUSH = 0x00008000U;
enum uint MARK_HANDLE_ENABLE_CPU_CACHE = 0x10000000U;

enum : uint
{
    VOLUME_IS_DIRTY          = 0x00000001U,
    VOLUME_UPGRADE_SCHEDULED = 0x00000002U,
}

enum uint VOLUME_SESSION_OPEN = 0x00000004U;

enum : uint
{
    FILE_PREFETCH_TYPE_FOR_CREATE     = 0x00000001U,
    FILE_PREFETCH_TYPE_FOR_DIRENUM    = 0x00000002U,
    FILE_PREFETCH_TYPE_FOR_CREATE_EX  = 0x00000003U,
    FILE_PREFETCH_TYPE_FOR_DIRENUM_EX = 0x00000004U,
    FILE_PREFETCH_TYPE_MAX            = 0x00000004U,
}

enum uint FILESYSTEM_STATISTICS_TYPE_REFS = 0x00000004U;
enum uint FILE_ZERO_DATA_INFORMATION_FLAG_PRESERVE_CACHED_DATA = 0x00000001U;
enum uint FILE_SET_ENCRYPTION = 0x00000001U;
enum uint FILE_CLEAR_ENCRYPTION = 0x00000002U;
enum uint STREAM_SET_ENCRYPTION = 0x00000003U;
enum uint STREAM_CLEAR_ENCRYPTION = 0x00000004U;
enum uint MAXIMUM_ENCRYPTION_VALUE = 0x00000004U;
enum uint ENCRYPTION_FORMAT_DEFAULT = 0x00000001U;

enum : uint
{
    ENCRYPTED_DATA_INFO_SPARSE_FILE    = 0x00000001U,
    ENCRYPTED_DATA_INFO_SPARSE_DATA    = 0x00000002U,
    ENCRYPTED_DATA_INFO_4K_SPARSE_UNIT = 0x00000004U,
}

enum : uint
{
    COPYFILE_SIS_LINK    = 0x00000001U,
    COPYFILE_SIS_REPLACE = 0x00000002U,
    COPYFILE_SIS_FLAGS   = 0x00000003U,
}

enum : uint
{
    SET_REPAIR_ENABLED              = 0x00000001U,
    SET_REPAIR_WARN_ABOUT_DATA_LOSS = 0x00000008U,
}

enum uint SET_REPAIR_DISABLED_AND_BUGCHECK_ON_CORRUPT = 0x00000010U;
enum uint SET_REPAIR_VALID_MASK = 0x00000019U;

enum : ulong
{
    FILE_INITIATE_REPAIR_HINT1_FILE_RECORD_NOT_IN_USE             = 0x0000000000000001UL,
    FILE_INITIATE_REPAIR_HINT1_FILE_RECORD_REUSED                 = 0x0000000000000002UL,
    FILE_INITIATE_REPAIR_HINT1_FILE_RECORD_NOT_EXIST              = 0x0000000000000004UL,
    FILE_INITIATE_REPAIR_HINT1_FILE_RECORD_NOT_BASE_RECORD        = 0x0000000000000008UL,
    FILE_INITIATE_REPAIR_HINT1_SYSTEM_FILE                        = 0x0000000000000010UL,
    FILE_INITIATE_REPAIR_HINT1_NOT_IMPLEMENTED                    = 0x0000000000000020UL,
    FILE_INITIATE_REPAIR_HINT1_UNABLE_TO_REPAIR                   = 0x0000000000000040UL,
    FILE_INITIATE_REPAIR_HINT1_REPAIR_DISABLED                    = 0x0000000000000080UL,
    FILE_INITIATE_REPAIR_HINT1_RECURSIVELY_CORRUPTED              = 0x0000000000000100UL,
    FILE_INITIATE_REPAIR_HINT1_ORPHAN_GENERATED                   = 0x0000000000000200UL,
    FILE_INITIATE_REPAIR_HINT1_REPAIRED                           = 0x0000000000000400UL,
    FILE_INITIATE_REPAIR_HINT1_NOTHING_WRONG                      = 0x0000000000000800UL,
    FILE_INITIATE_REPAIR_HINT1_ATTRIBUTE_NOT_FOUND                = 0x0000000000001000UL,
    FILE_INITIATE_REPAIR_HINT1_POTENTIAL_CROSSLINK                = 0x0000000000002000UL,
    FILE_INITIATE_REPAIR_HINT1_STALE_INFORMATION                  = 0x0000000000004000UL,
    FILE_INITIATE_REPAIR_HINT1_CLUSTERS_ALREADY_IN_USE            = 0x0000000000008000UL,
    FILE_INITIATE_REPAIR_HINT1_LCN_NOT_EXIST                      = 0x0000000000010000UL,
    FILE_INITIATE_REPAIR_HINT1_INVALID_RUN_LENGTH                 = 0x0000000000020000UL,
    FILE_INITIATE_REPAIR_HINT1_FILE_RECORD_NOT_ORPHAN             = 0x0000000000040000UL,
    FILE_INITIATE_REPAIR_HINT1_FILE_RECORD_IS_BASE_RECORD         = 0x0000000000080000UL,
    FILE_INITIATE_REPAIR_HINT1_INVALID_ARRAY_LENGTH_COUNT         = 0x0000000000100000UL,
    FILE_INITIATE_REPAIR_HINT1_SID_VALID                          = 0x0000000000200000UL,
    FILE_INITIATE_REPAIR_HINT1_SID_MISMATCH                       = 0x0000000000400000UL,
    FILE_INITIATE_REPAIR_HINT1_INVALID_PARENT                     = 0x0000000000800000UL,
    FILE_INITIATE_REPAIR_HINT1_PARENT_FILE_RECORD_NOT_IN_USE      = 0x0000000001000000UL,
    FILE_INITIATE_REPAIR_HINT1_PARENT_FILE_RECORD_REUSED          = 0x0000000002000000UL,
    FILE_INITIATE_REPAIR_HINT1_PARENT_FILE_RECORD_NOT_EXIST       = 0x0000000004000000UL,
    FILE_INITIATE_REPAIR_HINT1_PARENT_FILE_RECORD_NOT_BASE_RECORD = 0x0000000008000000UL,
    FILE_INITIATE_REPAIR_HINT1_PARENT_FILE_RECORD_NOT_INDEX       = 0x0000000010000000UL,
    FILE_INITIATE_REPAIR_HINT1_VALID_INDEX_ENTRY                  = 0x0000000020000000UL,
    FILE_INITIATE_REPAIR_HINT1_OUT_OF_GENERIC_NAMES               = 0x0000000040000000UL,
    FILE_INITIATE_REPAIR_HINT1_OUT_OF_RESOURCE                    = 0x0000000080000000UL,
    FILE_INITIATE_REPAIR_HINT1_INVALID_LCN                        = 0x0000000100000000UL,
    FILE_INITIATE_REPAIR_HINT1_INVALID_VCN                        = 0x0000000200000000UL,
    FILE_INITIATE_REPAIR_HINT1_NAME_CONFLICT                      = 0x0000000400000000UL,
    FILE_INITIATE_REPAIR_HINT1_ORPHAN                             = 0x0000000800000000UL,
    FILE_INITIATE_REPAIR_HINT1_ATTRIBUTE_TOO_SMALL                = 0x0000001000000000UL,
    FILE_INITIATE_REPAIR_HINT1_ATTRIBUTE_NON_RESIDENT             = 0x0000002000000000UL,
    FILE_INITIATE_REPAIR_HINT1_DENY_DEFRAG                        = 0x0000004000000000UL,
    FILE_INITIATE_REPAIR_HINT1_PREVIOUS_PARENT_STILL_VALID        = 0x0000008000000000UL,
    FILE_INITIATE_REPAIR_HINT1_INDEX_ENTRY_MISMATCH               = 0x0000010000000000UL,
    FILE_INITIATE_REPAIR_HINT1_INVALID_ORPHAN_RECOVERY_NAME       = 0x0000020000000000UL,
    FILE_INITIATE_REPAIR_HINT1_MULTIPLE_FILE_NAME_ATTRIBUTES      = 0x0000040000000000UL,
}

enum : uint
{
    TXFS_LOGGING_MODE_SIMPLE = 0x00000001U,
    TXFS_LOGGING_MODE_FULL   = 0x00000002U,
}

enum : uint
{
    TXFS_TRANSACTION_STATE_NONE      = 0x00000000U,
    TXFS_TRANSACTION_STATE_ACTIVE    = 0x00000001U,
    TXFS_TRANSACTION_STATE_PREPARED  = 0x00000002U,
    TXFS_TRANSACTION_STATE_NOTACTIVE = 0x00000003U,
}

enum : uint
{
    TXFS_RM_STATE_NOT_STARTED   = 0x00000000U,
    TXFS_RM_STATE_STARTING      = 0x00000001U,
    TXFS_RM_STATE_ACTIVE        = 0x00000002U,
    TXFS_RM_STATE_SHUTTING_DOWN = 0x00000003U,
}

enum : uint
{
    TXFS_ROLLFORWARD_REDO_FLAG_USE_LAST_REDO_LSN      = 0x00000001U,
    TXFS_ROLLFORWARD_REDO_FLAG_USE_LAST_VIRTUAL_CLOCK = 0x00000002U,
}

enum : uint
{
    TXFS_START_RM_FLAG_LOG_CONTAINER_COUNT_MAX             = 0x00000001U,
    TXFS_START_RM_FLAG_LOG_CONTAINER_COUNT_MIN             = 0x00000002U,
    TXFS_START_RM_FLAG_LOG_CONTAINER_SIZE                  = 0x00000004U,
    TXFS_START_RM_FLAG_LOG_GROWTH_INCREMENT_NUM_CONTAINERS = 0x00000008U,
    TXFS_START_RM_FLAG_LOG_GROWTH_INCREMENT_PERCENT        = 0x00000010U,
    TXFS_START_RM_FLAG_LOG_AUTO_SHRINK_PERCENTAGE          = 0x00000020U,
    TXFS_START_RM_FLAG_LOG_NO_CONTAINER_COUNT_MAX          = 0x00000040U,
    TXFS_START_RM_FLAG_LOG_NO_CONTAINER_COUNT_MIN          = 0x00000080U,
    TXFS_START_RM_FLAG_RECOVER_BEST_EFFORT                 = 0x00000200U,
    TXFS_START_RM_FLAG_LOGGING_MODE                        = 0x00000400U,
    TXFS_START_RM_FLAG_PRESERVE_CHANGES                    = 0x00000800U,
    TXFS_START_RM_FLAG_PREFER_CONSISTENCY                  = 0x00001000U,
    TXFS_START_RM_FLAG_PREFER_AVAILABILITY                 = 0x00002000U,
}

enum : uint
{
    TXFS_LIST_TRANSACTION_LOCKED_FILES_ENTRY_FLAG_CREATED = 0x00000001U,
    TXFS_LIST_TRANSACTION_LOCKED_FILES_ENTRY_FLAG_DELETED = 0x00000002U,
}

enum : uint
{
    TXFS_TRANSACTED_VERSION_NONTRANSACTED = 0xfffffffeU,
    TXFS_TRANSACTED_VERSION_UNCOMMITTED   = 0xffffffffU,
}

enum : uint
{
    TXFS_SAVEPOINT_SET       = 0x00000001U,
    TXFS_SAVEPOINT_ROLLBACK  = 0x00000002U,
    TXFS_SAVEPOINT_CLEAR     = 0x00000004U,
    TXFS_SAVEPOINT_CLEAR_ALL = 0x00000010U,
}

enum : uint
{
    PERSISTENT_VOLUME_STATE_SHORT_NAME_CREATION_DISABLED    = 0x00000001U,
    PERSISTENT_VOLUME_STATE_VOLUME_SCRUB_DISABLED           = 0x00000002U,
    PERSISTENT_VOLUME_STATE_GLOBAL_METADATA_NO_SEEK_PENALTY = 0x00000004U,
    PERSISTENT_VOLUME_STATE_LOCAL_METADATA_NO_SEEK_PENALTY  = 0x00000008U,
    PERSISTENT_VOLUME_STATE_NO_HEAT_GATHERING               = 0x00000010U,
    PERSISTENT_VOLUME_STATE_CONTAINS_BACKING_WIM            = 0x00000020U,
    PERSISTENT_VOLUME_STATE_BACKED_BY_WIM                   = 0x00000040U,
    PERSISTENT_VOLUME_STATE_NO_WRITE_AUTO_TIERING           = 0x00000080U,
    PERSISTENT_VOLUME_STATE_TXF_DISABLED                    = 0x00000100U,
    PERSISTENT_VOLUME_STATE_REALLOCATE_ALL_DATA_WRITES      = 0x00000200U,
    PERSISTENT_VOLUME_STATE_CHKDSK_RAN_ONCE                 = 0x00000400U,
    PERSISTENT_VOLUME_STATE_MODIFIED_BY_CHKDSK              = 0x00000800U,
    PERSISTENT_VOLUME_STATE_DAX_FORMATTED                   = 0x00001000U,
    PERSISTENT_VOLUME_STATE_DEV_VOLUME                      = 0x00002000U,
    PERSISTENT_VOLUME_STATE_TRUSTED_VOLUME                  = 0x00004000U,
}

enum : uint
{
    OPLOCK_LEVEL_CACHE_READ   = 0x00000001U,
    OPLOCK_LEVEL_CACHE_HANDLE = 0x00000002U,
    OPLOCK_LEVEL_CACHE_WRITE  = 0x00000004U,
}

enum : uint
{
    REQUEST_OPLOCK_INPUT_FLAG_REQUEST               = 0x00000001U,
    REQUEST_OPLOCK_INPUT_FLAG_ACK                   = 0x00000002U,
    REQUEST_OPLOCK_INPUT_FLAG_COMPLETE_ACK_ON_CLOSE = 0x00000004U,
}

enum : uint
{
    REQUEST_OPLOCK_CURRENT_VERSION                      = 0x00000001U,
    REQUEST_OPLOCK_OUTPUT_FLAG_ACK_REQUIRED             = 0x00000001U,
    REQUEST_OPLOCK_OUTPUT_FLAG_MODES_PROVIDED           = 0x00000002U,
    REQUEST_OPLOCK_OUTPUT_FLAG_WRITABLE_SECTION_PRESENT = 0x00000004U,
}

enum : uint
{
    QUERY_DEPENDENT_VOLUME_REQUEST_FLAG_HOST_VOLUMES  = 0x00000001U,
    QUERY_DEPENDENT_VOLUME_REQUEST_FLAG_GUEST_VOLUMES = 0x00000002U,
}

enum : uint
{
    SD_GLOBAL_CHANGE_TYPE_MACHINE_SID = 0x00000001U,
    SD_GLOBAL_CHANGE_TYPE_QUERY_STATS = 0x00010000U,
    SD_GLOBAL_CHANGE_TYPE_ENUM_SDS    = 0x00020000U,
}

enum : uint
{
    LOOKUP_STREAM_FROM_CLUSTER_ENTRY_FLAG_PAGE_FILE       = 0x00000001U,
    LOOKUP_STREAM_FROM_CLUSTER_ENTRY_FLAG_DENY_DEFRAG_SET = 0x00000002U,
    LOOKUP_STREAM_FROM_CLUSTER_ENTRY_FLAG_FS_SYSTEM_FILE  = 0x00000004U,
    LOOKUP_STREAM_FROM_CLUSTER_ENTRY_FLAG_TXF_SYSTEM_FILE = 0x00000008U,
    LOOKUP_STREAM_FROM_CLUSTER_ENTRY_ATTRIBUTE_MASK       = 0xff000000U,
    LOOKUP_STREAM_FROM_CLUSTER_ENTRY_ATTRIBUTE_DATA       = 0x01000000U,
    LOOKUP_STREAM_FROM_CLUSTER_ENTRY_ATTRIBUTE_INDEX      = 0x02000000U,
    LOOKUP_STREAM_FROM_CLUSTER_ENTRY_ATTRIBUTE_SYSTEM     = 0x03000000U,
}

enum : uint
{
    FILE_TYPE_NOTIFICATION_FLAG_USAGE_BEGIN = 0x00000001U,
    FILE_TYPE_NOTIFICATION_FLAG_USAGE_END   = 0x00000002U,
}

enum : GUID
{
    FILE_TYPE_NOTIFICATION_GUID_PAGE_FILE        = GUID("0d0a64a1-38fc-4db8-9fe7-3f4352cd7c5c"),
    FILE_TYPE_NOTIFICATION_GUID_HIBERNATION_FILE = GUID("b7624d64-b9a3-4cf8-8011-5b86c940e7b7"),
    FILE_TYPE_NOTIFICATION_GUID_CRASHDUMP_FILE   = GUID("9d453eb7-d2a6-4dbd-a2e3-fbd0ed9109a9"),
}

enum uint CSV_MGMTLOCK_CHECK_VOLUME_REDIRECTED = 0x00000001U;
enum uint CSV_INVALID_DEVICE_NUMBER = 0xffffffffU;

enum : uint
{
    CSV_QUERY_MDS_PATH_V2_VERSION_1                           = 0x00000001U,
    CSV_QUERY_MDS_PATH_FLAG_STORAGE_ON_THIS_NODE_IS_CONNECTED = 0x00000001U,
    CSV_QUERY_MDS_PATH_FLAG_CSV_DIRECT_IO_ENABLED             = 0x00000002U,
    CSV_QUERY_MDS_PATH_FLAG_SMB_BYPASS_CSV_ENABLED            = 0x00000004U,
}

enum : uint
{
    QUERY_FILE_LAYOUT_RESTART                                          = 0x00000001U,
    QUERY_FILE_LAYOUT_INCLUDE_NAMES                                    = 0x00000002U,
    QUERY_FILE_LAYOUT_INCLUDE_STREAMS                                  = 0x00000004U,
    QUERY_FILE_LAYOUT_INCLUDE_EXTENTS                                  = 0x00000008U,
    QUERY_FILE_LAYOUT_INCLUDE_EXTRA_INFO                               = 0x00000010U,
    QUERY_FILE_LAYOUT_INCLUDE_STREAMS_WITH_NO_CLUSTERS_ALLOCATED       = 0x00000020U,
    QUERY_FILE_LAYOUT_INCLUDE_FULL_PATH_IN_NAMES                       = 0x00000040U,
    QUERY_FILE_LAYOUT_INCLUDE_STREAM_INFORMATION                       = 0x00000080U,
    QUERY_FILE_LAYOUT_INCLUDE_STREAM_INFORMATION_FOR_DSC_ATTRIBUTE     = 0x00000100U,
    QUERY_FILE_LAYOUT_INCLUDE_STREAM_INFORMATION_FOR_TXF_ATTRIBUTE     = 0x00000200U,
    QUERY_FILE_LAYOUT_INCLUDE_STREAM_INFORMATION_FOR_EFS_ATTRIBUTE     = 0x00000400U,
    QUERY_FILE_LAYOUT_INCLUDE_ONLY_FILES_WITH_SPECIFIC_ATTRIBUTES      = 0x00000800U,
    QUERY_FILE_LAYOUT_INCLUDE_FILES_WITH_DSC_ATTRIBUTE                 = 0x00001000U,
    QUERY_FILE_LAYOUT_INCLUDE_STREAM_INFORMATION_FOR_DATA_ATTRIBUTE    = 0x00002000U,
    QUERY_FILE_LAYOUT_INCLUDE_STREAM_INFORMATION_FOR_REPARSE_ATTRIBUTE = 0x00004000U,
    QUERY_FILE_LAYOUT_INCLUDE_STREAM_INFORMATION_FOR_EA_ATTRIBUTE      = 0x00008000U,
}

enum uint QUERY_FILE_LAYOUT_SINGLE_INSTANCED = 0x00000001U;

enum : uint
{
    FILE_LAYOUT_NAME_ENTRY_PRIMARY = 0x00000001U,
    FILE_LAYOUT_NAME_ENTRY_DOS     = 0x00000002U,
}

enum : uint
{
    STREAM_LAYOUT_ENTRY_IMMOVABLE             = 0x00000001U,
    STREAM_LAYOUT_ENTRY_PINNED                = 0x00000002U,
    STREAM_LAYOUT_ENTRY_RESIDENT              = 0x00000004U,
    STREAM_LAYOUT_ENTRY_NO_CLUSTERS_ALLOCATED = 0x00000008U,
    STREAM_LAYOUT_ENTRY_HAS_INFORMATION       = 0x00000010U,
}

enum : uint
{
    STREAM_EXTENT_ENTRY_AS_RETRIEVAL_POINTERS = 0x00000001U,
    STREAM_EXTENT_ENTRY_ALL_EXTENTS           = 0x00000002U,
}

enum : uint
{
    CHECKSUM_TYPE_NONE              = 0x00000000U,
    CHECKSUM_TYPE_CRC32             = 0x00000001U,
    CHECKSUM_TYPE_CRC64             = 0x00000002U,
    CHECKSUM_TYPE_ECC               = 0x00000003U,
    CHECKSUM_TYPE_SHA256            = 0x00000004U,
    CHECKSUM_TYPE_XXH64             = 0x00000005U,
    CHECKSUM_TYPE_FIRST_UNUSED_TYPE = 0x00000006U,
}

enum uint FSCTL_INTEGRITY_FLAG_CHECKSUM_ENFORCEMENT_OFF = 0x00000001U;
enum uint OFFLOAD_READ_FLAG_ALL_ZERO_BEYOND_CURRENT_RANGE = 0x00000001U;

enum : uint
{
    SET_PURGE_FAILURE_MODE_ENABLED  = 0x00000001U,
    SET_PURGE_FAILURE_MODE_DISABLED = 0x00000002U,
}

enum : uint
{
    FILE_REGION_USAGE_VALID_CACHED_DATA    = 0x00000001U,
    FILE_REGION_USAGE_VALID_NONCACHED_DATA = 0x00000002U,
    FILE_REGION_USAGE_OTHER_PAGE_ALIGNMENT = 0x00000004U,
    FILE_REGION_USAGE_LARGE_PAGE_ALIGNMENT = 0x00000008U,
    FILE_REGION_USAGE_HUGE_PAGE_ALIGNMENT  = 0x00000010U,
    FILE_REGION_USAGE_QUERY_ALIGNMENT      = 0x00000008U,
}

enum : uint
{
    FILE_STORAGE_TIER_NAME_LENGTH           = 0x00000100U,
    FILE_STORAGE_TIER_DESCRIPTION_LENGTH    = 0x00000200U,
    FILE_STORAGE_TIER_FLAG_WRITE_BACK_CACHE = 0x00200000U,
    FILE_STORAGE_TIER_FLAG_READ_CACHE       = 0x00400000U,
    FILE_STORAGE_TIER_FLAG_PARITY           = 0x00800000U,
    FILE_STORAGE_TIER_FLAG_SMR              = 0x01000000U,
}

enum : uint
{
    QUERY_STORAGE_CLASSES_FLAGS_MEASURE_WRITE    = 0x80000000U,
    QUERY_STORAGE_CLASSES_FLAGS_MEASURE_READ     = 0x40000000U,
    QUERY_STORAGE_CLASSES_FLAGS_NO_DEFRAG_VOLUME = 0x20000000U,
}

enum : uint
{
    QUERY_FILE_LAYOUT_REPARSE_DATA_INVALID = 0x00000001U,
    QUERY_FILE_LAYOUT_REPARSE_TAG_INVALID  = 0x00000002U,
}

enum : uint
{
    DUPLICATE_EXTENTS_DATA_EX_SOURCE_ATOMIC = 0x00000001U,
    DUPLICATE_EXTENTS_DATA_EX_ASYNC         = 0x00000002U,
}

enum : uint
{
    REFS_SMR_VOLUME_INFO_OUTPUT_VERSION_V0   = 0x00000000U,
    REFS_SMR_VOLUME_INFO_OUTPUT_VERSION_V1   = 0x00000001U,
    REFS_SMR_VOLUME_GC_PARAMETERS_VERSION_V1 = 0x00000001U,
}

enum : uint
{
    STREAMS_INVALID_ID         = 0x00000000U,
    STREAMS_MAX_ID             = 0x0000ffffU,
    STREAMS_ASSOCIATE_ID_CLEAR = 0x00000001U,
    STREAMS_ASSOCIATE_ID_SET   = 0x00000002U,
}

enum : uint
{
    DAX_ALLOC_ALIGNMENT_FLAG_MANDATORY          = 0x00000001U,
    DAX_ALLOC_ALIGNMENT_FLAG_FALLBACK_SPECIFIED = 0x00000002U,
}

enum uint WOF_CURRENT_VERSION = 0x00000001U;
enum uint WOF_PROVIDER_CLOUD = 0x00000003U;

enum : uint
{
    WIM_PROVIDER_CURRENT_VERSION          = 0x00000001U,
    WIM_PROVIDER_EXTERNAL_FLAG_NOT_ACTIVE = 0x00000001U,
    WIM_PROVIDER_EXTERNAL_FLAG_SUSPENDED  = 0x00000002U,
}

enum : uint
{
    FILE_PROVIDER_CURRENT_VERSION        = 0x00000001U,
    FILE_PROVIDER_SINGLE_FILE            = 0x00000001U,
    FILE_PROVIDER_COMPRESSION_MAXIMUM    = 0x00000004U,
    FILE_PROVIDER_FLAG_COMPRESS_ON_WRITE = 0x00000001U,
}

enum uint CONTAINER_VOLUME_STATE_HOSTING_CONTAINER = 0x00000001U;

enum : uint
{
    CONTAINER_ROOT_INFO_FLAG_SCRATCH_ROOT                  = 0x00000001U,
    CONTAINER_ROOT_INFO_FLAG_LAYER_ROOT                    = 0x00000002U,
    CONTAINER_ROOT_INFO_FLAG_VIRTUALIZATION_ROOT           = 0x00000004U,
    CONTAINER_ROOT_INFO_FLAG_VIRTUALIZATION_TARGET_ROOT    = 0x00000008U,
    CONTAINER_ROOT_INFO_FLAG_VIRTUALIZATION_EXCEPTION_ROOT = 0x00000010U,
    CONTAINER_ROOT_INFO_FLAG_BIND_ROOT                     = 0x00000020U,
    CONTAINER_ROOT_INFO_FLAG_BIND_TARGET_ROOT              = 0x00000040U,
    CONTAINER_ROOT_INFO_FLAG_BIND_EXCEPTION_ROOT           = 0x00000080U,
    CONTAINER_ROOT_INFO_FLAG_BIND_DO_NOT_MAP_NAME          = 0x00000100U,
    CONTAINER_ROOT_INFO_FLAG_UNION_LAYER_ROOT              = 0x00000200U,
    CONTAINER_ROOT_INFO_VALID_FLAGS                        = 0x000003ffU,
}

enum uint PROJFS_PROTOCOL_VERSION = 0x00000003U;
enum uint EFS_TRACKED_OFFSET_HEADER_FLAG = 0x00000001U;
enum uint SPACES_TRACKED_OFFSET_HEADER_FLAG = 0x00000002U;

// Callbacks

alias PIO_IRP_EXT_PROCESS_TRACKED_OFFSET_CALLBACK = void function(IO_IRP_EXT_TRACK_OFFSET_HEADER* SourceContext, 
                                                                  IO_IRP_EXT_TRACK_OFFSET_HEADER* TargetContext, 
                                                                  long RelativeOffset);

// Structs


version(X86_64)
{
    struct MOVE_FILE_DATA32
    {
        uint FileHandle;
        long StartingVcn;
        long StartingLcn;
        uint ClusterCount;
    }
}

version(AArch64)
{
    struct MOVE_FILE_DATA32
    {
        uint FileHandle;
        long StartingVcn;
        long StartingLcn;
        uint ClusterCount;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-mark_handle_info32
    struct MARK_HANDLE_INFO32
    {
        union
        {
            uint UsnSourceInfo;
            uint CopyNumber;
        }
        uint VolumeHandle;
        uint HandleInfo;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-mark_handle_info32
    struct MARK_HANDLE_INFO32
    {
        union
        {
            uint UsnSourceInfo;
            uint CopyNumber;
        }
        uint VolumeHandle;
        uint HandleInfo;
    }
}

version(X86_64)
{
    struct DUPLICATE_EXTENTS_DATA32
    {
        uint FileHandle;
        long SourceFileOffset;
        long TargetFileOffset;
        long ByteCount;
    }
}

version(AArch64)
{
    struct DUPLICATE_EXTENTS_DATA32
    {
        uint FileHandle;
        long SourceFileOffset;
        long TargetFileOffset;
        long ByteCount;
    }
}

version(X86_64)
{
    struct DUPLICATE_EXTENTS_DATA_EX32
    {
        uint Size;
        uint FileHandle;
        long SourceFileOffset;
        long TargetFileOffset;
        long ByteCount;
        uint Flags;
    }
}

version(AArch64)
{
    struct DUPLICATE_EXTENTS_DATA_EX32
    {
        uint Size;
        uint FileHandle;
        long SourceFileOffset;
        long TargetFileOffset;
        long ByteCount;
        uint Flags;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_hotplug_info
struct STORAGE_HOTPLUG_INFO
{
    uint    Size;
    BOOLEAN MediaRemovable;
    BOOLEAN MediaHotplug;
    BOOLEAN DeviceHotplug;
    BOOLEAN WriteCacheEnableOverride;
}

struct STORAGE_FEATURE_SUPPORT
{
    uint     Size;
    uint     Version;
    union Flags
    {
        struct
        {
            // Native bit field: StorMQMiniportsSupported: [0], Reserved: [1-63]
            ulong _bitfield0;
        }
        ulong AsUlonglong;
    }
    ulong[6] Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_device_number
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
    STORAGE_DEVICE_NUMBER[1] Devices; // Flexible array
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-prevent_media_removal
struct PREVENT_MEDIA_REMOVAL
{
    BOOLEAN PreventMediaRemoval;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-class_media_change_context
struct CLASS_MEDIA_CHANGE_CONTEXT
{
    uint MediaChangeCount;
    uint NewState;
}

struct TAPE_STATISTICS
{
    uint  Version;
    uint  Flags;
    long  RecoveredWrites;
    long  UnrecoveredWrites;
    long  RecoveredReads;
    long  UnrecoveredReads;
    ubyte CompressionRatioReads;
    ubyte CompressionRatioWrites;
}

struct TAPE_GET_STATISTICS
{
    uint Operation;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-device_media_info
struct DEVICE_MEDIA_INFO
{
    union DeviceSpecific
    {
        struct DiskInfo
        {
            long               Cylinders;
            STORAGE_MEDIA_TYPE MediaType;
            uint               TracksPerCylinder;
            uint               SectorsPerTrack;
            uint               BytesPerSector;
            uint               NumberMediaSides;
            uint               MediaCharacteristics;
        }
        struct RemovableDiskInfo
        {
            long               Cylinders;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-get_media_types
struct GET_MEDIA_TYPES
{
    uint                 DeviceType;
    uint                 MediaInfoCount;
    DEVICE_MEDIA_INFO[1] MediaInfo; // Flexible array
}

struct STORAGE_PREDICT_FAILURE
{
    uint       PredictFailure;
    ubyte[512] VendorSpecific;
}

struct STORAGE_FAILURE_PREDICTION_CONFIG
{
    uint    Version;
    uint    Size;
    BOOLEAN Set;
    BOOLEAN Enabled;
    ushort  Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_property_query
struct STORAGE_PROPERTY_QUERY
{
    STORAGE_PROPERTY_ID PropertyId;
    STORAGE_QUERY_TYPE  QueryType;
    ubyte[1]            AdditionalParameters; // Flexible array
}

struct STORAGE_PROPERTY_SET
{
    STORAGE_PROPERTY_ID PropertyId;
    STORAGE_SET_TYPE    SetType;
    ubyte[1]            AdditionalParameters; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_descriptor_header
struct STORAGE_DESCRIPTOR_HEADER
{
    uint Version;
    uint Size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_device_descriptor
struct STORAGE_DEVICE_DESCRIPTOR
{
    uint             Version;
    uint             Size;
    ubyte            DeviceType;
    ubyte            DeviceTypeModifier;
    BOOLEAN          RemovableMedia;
    BOOLEAN          CommandQueueing;
    uint             VendorIdOffset;
    uint             ProductIdOffset;
    uint             ProductRevisionOffset;
    uint             SerialNumberOffset;
    STORAGE_BUS_TYPE BusType;
    uint             RawPropertiesLength;
    ubyte[1]         RawDeviceProperties; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_adapter_descriptor
struct STORAGE_ADAPTER_DESCRIPTOR
{
    uint    Version;
    uint    Size;
    uint    MaximumTransferLength;
    uint    MaximumPhysicalPages;
    uint    AlignmentMask;
    BOOLEAN AdapterUsesPio;
    BOOLEAN AdapterScansDown;
    BOOLEAN CommandQueueing;
    BOOLEAN AcceleratedTransfer;
    ubyte   BusType;
    ushort  BusMajorVersion;
    ushort  BusMinorVersion;
    ubyte   SrbType;
    ubyte   AddressType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_access_alignment_descriptor
struct STORAGE_ACCESS_ALIGNMENT_DESCRIPTOR
{
    uint Version;
    uint Size;
    uint BytesPerCacheLine;
    uint BytesOffsetForCacheAlignment;
    uint BytesPerLogicalSector;
    uint BytesPerPhysicalSector;
    uint BytesOffsetForSectorAlignment;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_medium_product_type_descriptor
struct STORAGE_MEDIUM_PRODUCT_TYPE_DESCRIPTOR
{
    uint Version;
    uint Size;
    uint MediumProductType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_miniport_descriptor
struct STORAGE_MINIPORT_DESCRIPTOR
{
    uint     Version;
    uint     Size;
    STORAGE_PORT_CODE_SET Portdriver;
    BOOLEAN  LUNResetSupported;
    BOOLEAN  TargetResetSupported;
    ushort   IoTimeoutValue;
    BOOLEAN  ExtraIoInfoSupported;
    union Flags
    {
        struct
        {
            // Native bit field: LogicalPoFxForDisk: [0], ForwardIo: [1], Reserved: [2-7]
            ubyte _bitfield0;
        }
        ubyte AsBYTE;
    }
    ubyte[2] Reserved0;
    uint     Reserved1;
}

struct STORAGE_IDENTIFIER
{
    STORAGE_IDENTIFIER_CODE_SET CodeSet;
    STORAGE_IDENTIFIER_TYPE Type;
    ushort   IdentifierSize;
    ushort   NextOffset;
    STORAGE_ASSOCIATION_TYPE Association;
    ubyte[1] Identifier; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_device_id_descriptor
struct STORAGE_DEVICE_ID_DESCRIPTOR
{
    uint     Version;
    uint     Size;
    uint     NumberOfIdentifiers;
    ubyte[1] Identifiers; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-device_seek_penalty_descriptor
struct DEVICE_SEEK_PENALTY_DESCRIPTOR
{
    uint    Version;
    uint    Size;
    BOOLEAN IncursSeekPenalty;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-device_write_aggregation_descriptor
struct DEVICE_WRITE_AGGREGATION_DESCRIPTOR
{
    uint    Version;
    uint    Size;
    BOOLEAN BenefitsFromWriteAggregation;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-device_trim_descriptor
struct DEVICE_TRIM_DESCRIPTOR
{
    uint    Version;
    uint    Size;
    BOOLEAN TrimEnabled;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-device_lb_provisioning_descriptor
struct DEVICE_LB_PROVISIONING_DESCRIPTOR
{
    uint     Version;
    uint     Size;
    // Native bit field: ThinProvisioningEnabled: [0], ThinProvisioningReadZeros: [1], AnchorSupported: [2-4], UnmapGranularityAlignmentValid: [5], GetFreeSpaceSupported: [6], MapSupported: [7]
    ubyte    _bitfield0;
    ubyte[7] Reserved1;
    ulong    OptimalUnmapGranularity;
    ulong    UnmapGranularityAlignment;
    uint     MaxUnmapLbaCount;
    uint     MaxUnmapBlockDescriptorCount;
}

struct STORAGE_LB_PROVISIONING_MAP_RESOURCES
{
    uint     Size;
    uint     Version;
    // Native bit field: AvailableMappingResourcesValid: [0], UsedMappingResourcesValid: [1], Reserved0: [2-7]
    ubyte    _bitfield1;
    ubyte[3] Reserved1;
    // Native bit field: AvailableMappingResourcesScope: [0-1], UsedMappingResourcesScope: [2-3], Reserved2: [4-7]
    ubyte    _bitfield2;
    ubyte[3] Reserved3;
    ulong    AvailableMappingResources;
    ulong    UsedMappingResources;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-device_power_descriptor
struct DEVICE_POWER_DESCRIPTOR
{
    uint     Version;
    uint     Size;
    BOOLEAN  DeviceAttentionSupported;
    BOOLEAN  AsynchronousNotificationSupported;
    BOOLEAN  IdlePowerManagementEnabled;
    BOOLEAN  D3ColdEnabled;
    BOOLEAN  D3ColdSupported;
    BOOLEAN  NoVerifyDuringIdlePower;
    ubyte[2] Reserved;
    uint     IdleTimeoutInMS;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-device_copy_offload_descriptor
struct DEVICE_COPY_OFFLOAD_DESCRIPTOR
{
    uint     Version;
    uint     Size;
    uint     MaximumTokenLifetime;
    uint     DefaultTokenLifetime;
    ulong    MaximumTransferSize;
    ulong    OptimalTransferCount;
    uint     MaximumDataDescriptors;
    uint     MaximumTransferLengthPerDescriptor;
    uint     OptimalTransferLengthPerDescriptor;
    ushort   OptimalTransferLengthGranularity;
    ubyte[2] Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_device_resiliency_descriptor
struct STORAGE_DEVICE_RESILIENCY_DESCRIPTOR
{
    uint Version;
    uint Size;
    uint NameOffset;
    uint NumberOfLogicalCopies;
    uint NumberOfPhysicalCopies;
    uint PhysicalDiskRedundancy;
    uint NumberOfColumns;
    uint Interleave;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_rpmb_descriptor
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

union STORAGE_SECURITY_COMPLIANCE_BITMASK
{
    struct
    {
        // Native bit field: FIPS: [0], Reserved: [1-7]
        ubyte _bitfield0;
    }
    ubyte AsUchar;
}

union STORAGE_CRYPTO_KEY_TYPE
{
    struct
    {
        // Native bit field: DirectKey: [0], PlatformWrappedKey: [1], PlutonWrappedKey: [2], Reserved: [3-7]
        ubyte _bitfield0;
    }
    ubyte AsUchar;
}

struct STORAGE_CRYPTO_CAPABILITY_V2
{
    uint   Version;
    uint   Size;
    uint   CryptoCapabilityIndex;
    STORAGE_CRYPTO_ALGORITHM_ID AlgorithmId;
    STORAGE_CRYPTO_KEY_SIZE KeySize;
    uint   DataUnitSizeBitmask;
    ushort MaxIVBitSize;
    ushort Reserved;
    STORAGE_SECURITY_COMPLIANCE_BITMASK SecurityComplianceBitmask;
}

struct STORAGE_CRYPTO_DESCRIPTOR
{
    uint Version;
    uint Size;
    uint NumKeysSupported;
    uint NumCryptoCapabilities;
    STORAGE_CRYPTO_CAPABILITY[1] CryptoCapabilities; // Flexible array
}

struct STORAGE_CRYPTO_DESCRIPTOR_V2
{
    uint             Version;
    uint             Size;
    uint             NumKeysSupported;
    uint             NumCryptoCapabilities;
    STORAGE_ICE_TYPE IceType;
    STORAGE_SECURITY_COMPLIANCE_BITMASK SecurityComplianceBitmask;
    STORAGE_CRYPTO_KEY_TYPE KeyTypeBitmask;
    STORAGE_CRYPTO_CAPABILITY_V2[1] CryptoCapabilities; // Flexible array
}

struct STORAGE_HW_CRYPTO_CAPABILITY
{
    uint   Version;
    uint   Size;
    uint   CryptoCapabilityIndex;
    STORAGE_CRYPTO_ALGORITHM_ID AlgorithmId;
    STORAGE_CRYPTO_KEY_SIZE KeySize;
    uint   DataUnitSizeBitmask;
    ushort MaxIVBitSize;
    ushort Reserved;
    STORAGE_SECURITY_COMPLIANCE_BITMASK SecurityComplianceBitmask;
}

struct STORAGE_HW_CRYPTO_DESCRIPTOR
{
    STORAGE_DESCRIPTOR_HEADER Header;
    uint             NumKeysSupported;
    uint             NumCryptoCapabilities;
    uint             OffsetToCryptoCapabilities;
    uint             SizeOfCryptoCapability;
    STORAGE_ICE_TYPE IceType;
    STORAGE_SECURITY_COMPLIANCE_BITMASK SecurityComplianceBitmask;
    STORAGE_CRYPTO_KEY_TYPE KeyTypeBitmask;
}

struct STORAGE_TIER
{
    GUID               Id;
    wchar[256]         Name;
    wchar[256]         Description;
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
    STORAGE_TIER[1] Tiers; // Flexible array
}

struct STORAGE_DEVICE_FAULT_DOMAIN_DESCRIPTOR
{
    uint    Version;
    uint    Size;
    uint    NumberOfFaultDomains;
    GUID[1] FaultDomainIds; // Flexible array
}

union STORAGE_PROTOCOL_DATA_SUBVALUE_GET_LOG_PAGE
{
    struct
    {
        // Native bit field: RetainAsynEvent: [0], LogSpecificField: [1-4], Reserved0: [5-7], UUIDIndex: [8-14], Reserved: [15-31]
        uint _bitfield0;
    }
    uint AsUlong;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_protocol_specific_data
struct STORAGE_PROTOCOL_SPECIFIC_DATA
{
    STORAGE_PROTOCOL_TYPE ProtocolType;
    uint DataType;
    uint ProtocolDataRequestValue;
    uint ProtocolDataRequestSubValue;
    uint ProtocolDataOffset;
    uint ProtocolDataLength;
    uint FixedProtocolReturnData;
    uint ProtocolDataRequestSubValue2;
    uint ProtocolDataRequestSubValue3;
    uint ProtocolDataRequestSubValue4;
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
    uint    ProtocolDataSubValue6;
    uint[4] Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_protocol_data_descriptor
struct STORAGE_PROTOCOL_DATA_DESCRIPTOR
{
    uint Version;
    uint Size;
    STORAGE_PROTOCOL_SPECIFIC_DATA ProtocolSpecificData;
}

struct STORAGE_PROTOCOL_DATA_DESCRIPTOR_EXT
{
    uint Version;
    uint Size;
    STORAGE_PROTOCOL_SPECIFIC_DATA_EXT ProtocolSpecificData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_temperature_info
struct STORAGE_TEMPERATURE_INFO
{
    ushort  Index;
    short   Temperature;
    short   OverThreshold;
    short   UnderThreshold;
    BOOLEAN OverThresholdChangable;
    BOOLEAN UnderThresholdChangable;
    BOOLEAN EventGenerated;
    ubyte   Reserved0;
    uint    Reserved1;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_temperature_data_descriptor
struct STORAGE_TEMPERATURE_DATA_DESCRIPTOR
{
    uint     Version;
    uint     Size;
    short    CriticalTemperature;
    short    WarningTemperature;
    ushort   InfoCount;
    ubyte[2] Reserved0;
    uint[2]  Reserved1;
    STORAGE_TEMPERATURE_INFO[1] TemperatureInfo; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_temperature_threshold
struct STORAGE_TEMPERATURE_THRESHOLD
{
    uint    Version;
    uint    Size;
    ushort  Flags;
    ushort  Index;
    short   Threshold;
    BOOLEAN OverThreshold;
    ubyte   Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_spec_version
union STORAGE_SPEC_VERSION
{
    struct
    {
        union MinorVersion
        {
            struct
            {
                ubyte SubMinor;
                ubyte Minor;
            }
            ushort AsUshort;
        }
        ushort MajorVersion;
    }
    uint AsUlong;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_physical_device_data
struct STORAGE_PHYSICAL_DEVICE_DATA
{
    uint                 DeviceId;
    uint                 Role;
    STORAGE_COMPONENT_HEALTH_STATUS HealthStatus;
    STORAGE_PROTOCOL_TYPE CommandProtocol;
    STORAGE_SPEC_VERSION SpecVersion;
    STORAGE_DEVICE_FORM_FACTOR FormFactor;
    ubyte[8]             Vendor;
    ubyte[40]            Model;
    ubyte[16]            FirmwareRevision;
    ulong                Capacity;
    ubyte[32]            PhysicalLocation;
    uint[2]              Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_physical_adapter_data
struct STORAGE_PHYSICAL_ADAPTER_DATA
{
    uint                 AdapterId;
    STORAGE_COMPONENT_HEALTH_STATUS HealthStatus;
    STORAGE_PROTOCOL_TYPE CommandProtocol;
    STORAGE_SPEC_VERSION SpecVersion;
    ubyte[8]             Vendor;
    ubyte[40]            Model;
    ubyte[16]            FirmwareRevision;
    ubyte[32]            PhysicalLocation;
    BOOLEAN              ExpanderConnected;
    ubyte[3]             Reserved0;
    uint[3]              Reserved1;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_physical_node_data
struct STORAGE_PHYSICAL_NODE_DATA
{
    uint    NodeId;
    uint    AdapterCount;
    uint    AdapterDataLength;
    uint    AdapterDataOffset;
    uint    DeviceCount;
    uint    DeviceDataLength;
    uint    DeviceDataOffset;
    uint[3] Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_physical_topology_descriptor
struct STORAGE_PHYSICAL_TOPOLOGY_DESCRIPTOR
{
    uint Version;
    uint Size;
    uint NodeCount;
    uint Reserved;
    STORAGE_PHYSICAL_NODE_DATA[1] Node; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_device_io_capability_descriptor
struct STORAGE_DEVICE_IO_CAPABILITY_DESCRIPTOR
{
    uint Version;
    uint Size;
    uint LunMaxIoCount;
    uint AdapterMaxIoCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_device_attributes_descriptor
struct STORAGE_DEVICE_ATTRIBUTES_DESCRIPTOR
{
    uint  Version;
    uint  Size;
    ulong Attributes;
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
    STORAGE_OPERATIONAL_REASON[1] AdditionalReasons; // Flexible array
}

struct STORAGE_ADAPTER_SERIAL_NUMBER
{
    uint       Version;
    uint       Size;
    wchar[128] SerialNumber;
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
            BOOLEAN  UnrestrictedRead;
            ubyte[3] Reserved;
        }
        struct SequentialPreferredZone
        {
            uint OptimalOpenZoneCount;
            uint Reserved;
        }
    }
    uint ZoneGroupCount;
    STORAGE_ZONE_GROUP[1] ZoneGroup; // Flexible array
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
        // Native bit field: Shared: [0], Reserved: [1-31]
        uint _bitfield0;
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

struct STORAGE_STACK_DESCRIPTOR
{
    uint               Version;
    uint               Size;
    STORAGE_STACK_TYPE StorageStackType;
}

struct STORAGE_DEVICE_LED_STATE_DESCRIPTOR
{
    uint  Version;
    uint  Size;
    ulong State;
}

struct STORAGE_DEVICE_SELF_ENCRYPTION_PROPERTY
{
    uint    Version;
    uint    Size;
    BOOLEAN SupportsSelfEncryption;
}

struct STORAGE_DEVICE_SELF_ENCRYPTION_PROPERTY_V2
{
    uint    Version;
    uint    Size;
    BOOLEAN SupportsSelfEncryption;
    STORAGE_ENCRYPTION_TYPE EncryptionType;
}

struct STORAGE_FRU_ID_DESCRIPTOR
{
    uint     Version;
    uint     Size;
    uint     IdentifierSize;
    ubyte[1] Identifier; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-device_data_set_range
struct DEVICE_DATA_SET_RANGE
{
    long  StartingOffset;
    ulong LengthInBytes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-device_manage_data_set_attributes
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-device_manage_data_set_attributes_output
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
    uint    Action;
    BOOLEAN SingleRange;
    uint    ParameterBlockAlignment;
    uint    ParameterBlockLength;
    BOOLEAN HasOutput;
    uint    OutputBlockAlignment;
    uint    OutputBlockLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-device_dsm_notification_parameters
struct DEVICE_DSM_NOTIFICATION_PARAMETERS
{
    uint    Size;
    uint    Flags;
    uint    NumFileTypeIDs;
    GUID[1] FileTypeID; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_offload_token
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-device_dsm_offload_read_parameters
struct DEVICE_DSM_OFFLOAD_READ_PARAMETERS
{
    uint    Flags;
    uint    TimeToLive;
    uint[2] Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_offload_read_output
struct STORAGE_OFFLOAD_READ_OUTPUT
{
    uint  OffloadReadFlags;
    uint  Reserved;
    ulong LengthProtected;
    uint  TokenLength;
    STORAGE_OFFLOAD_TOKEN Token;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-device_dsm_offload_write_parameters
struct DEVICE_DSM_OFFLOAD_WRITE_PARAMETERS
{
    uint  Flags;
    uint  Reserved;
    ulong TokenOffset;
    STORAGE_OFFLOAD_TOKEN Token;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_offload_write_output
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-device_data_set_lb_provisioning_state
struct DEVICE_DATA_SET_LB_PROVISIONING_STATE
{
    uint    Size;
    uint    Version;
    ulong   SlabSizeInBytes;
    uint    SlabOffsetDeltaInBytes;
    uint    SlabAllocationBitMapBitCount;
    uint    SlabAllocationBitMapLength;
    uint[1] SlabAllocationBitMap; // Flexible array
}

struct DEVICE_DATA_SET_LB_PROVISIONING_STATE_V2
{
    uint    Size;
    uint    Version;
    ulong   SlabSizeInBytes;
    ulong   SlabOffsetDeltaInBytes;
    uint    SlabAllocationBitMapBitCount;
    uint    SlabAllocationBitMapLength;
    uint[1] SlabAllocationBitMap; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-device_data_set_repair_parameters
struct DEVICE_DATA_SET_REPAIR_PARAMETERS
{
    uint    NumberOfRepairCopies;
    uint    SourceCopy;
    uint[1] RepairCopies; // Flexible array
}

struct DEVICE_DATA_SET_REPAIR_OUTPUT
{
    DEVICE_DATA_SET_RANGE ParityExtent;
}

struct DEVICE_DSM_QUERY_PREFER_LOCAL_REPAIR_OUTPUT
{
    uint    Version;
    BOOLEAN PreferLocalRepair;
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
    ulong BytesScrubbed;
}

struct DEVICE_DSM_TIERING_QUERY_INPUT
{
    uint    Version;
    uint    Size;
    uint    Flags;
    uint    NumberOfTierIds;
    GUID[1] TierIds; // Flexible array
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
    STORAGE_TIER_REGION[1] Regions; // Flexible array
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
    DEVICE_STORAGE_ADDRESS_RANGE[1] Ranges; // Flexible array
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
    BOOLEAN            ResetWritePointerRecommend;
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
    STORAGE_ZONE_DESCRIPTOR[1] ZoneDescriptors; // Flexible array
}

struct DEVICE_STORAGE_RANGE_ATTRIBUTES
{
    ulong LengthInBytes;
    union
    {
        uint AllFlags;
        struct
        {
            // Native bit field: IsRangeBad: [0]
            uint _bitfield0;
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
    DEVICE_STORAGE_RANGE_ATTRIBUTES[1] Ranges; // Flexible array
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
    uint[1] BitMap; // Flexible array
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
    uint       Version;
    uint       RequestsPerPeriod;
    uint       Period;
    BOOLEAN    RetryFailures;
    BOOLEAN    Discardable;
    BOOLEAN[2] Reserved1;
    uint       AccessType;
    uint       AccessMode;
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
    uint Flags;
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
    ubyte[1] DiagnosticDataBuffer; // Flexible array
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
    PHYSICAL_ELEMENT_STATUS_DESCRIPTOR[1] Descriptors; // Flexible array
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
    ubyte[1]   StatusData; // Flexible array
}

struct STORAGE_REINITIALIZE_MEDIA
{
    uint Version;
    uint Size;
    uint TimeoutInSeconds;
    struct SanitizeOption
    {
        // Native bit field: SanitizeMethod: [0-3], DisallowUnrestrictedSanitizeExit: [4], Reserved: [5-31]
        uint _bitfield0;
    }
}

struct STORAGE_MEDIA_SERIAL_NUMBER_DATA
{
    ushort   Reserved;
    ushort   SerialNumberLength;
    ubyte[1] SerialNumber; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/DevIO/storage-read-capacity
struct STORAGE_READ_CAPACITY
{
    uint Version;
    uint Size;
    uint BlockLength;
    long NumberOfBlocks;
    long DiskLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_write_cache_property
struct STORAGE_WRITE_CACHE_PROPERTY
{
    uint               Version;
    uint               Size;
    WRITE_CACHE_TYPE   WriteCacheType;
    WRITE_CACHE_ENABLE WriteCacheEnabled;
    WRITE_CACHE_CHANGE WriteCacheChangeable;
    WRITE_THROUGH      WriteThroughSupported;
    BOOLEAN            FlushCacheSupported;
    BOOLEAN            UserDefinedPowerProtection;
    BOOLEAN            NVCacheEnabled;
}

struct PERSISTENT_RESERVE_COMMAND
{
    uint Version;
    uint Size;
    union
    {
        struct PR_IN
        {
            // Native bit field: ServiceAction: [0-4], Reserved1: [5-7]
            ubyte  _bitfield0;
            ushort AllocationLength;
        }
        struct PR_OUT
        {
            // Native bit field: ServiceAction: [0-4], Reserved1: [5-7]
            ubyte    _bitfield1;
            // Native bit field: Type: [0-3], Scope: [4-7]
            ubyte    _bitfield2;
            ubyte[1] ParameterList; // Flexible array
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
    CHAR[16] szDescription;
    ubyte[1] bData; // Flexible array
}

struct DEVICEDUMP_RESTRICTED_SUBSECTION
{
    ubyte[1] bData; // Flexible array
}

struct DEVICEDUMP_PRIVATE_SUBSECTION
{
align (1):
    uint     dwFlags;
    GP_LOG_PAGE_DESCRIPTOR GPLogId;
    ubyte[1] bData; // Flexible array
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
    DEVICEDUMP_STORAGESTACK_PUBLIC_STATE_RECORD[1] RecordArray; // Flexible array
}

struct STORAGE_IDLE_POWER
{
    uint Version;
    uint Size;
    // Native bit field: WakeCapableHint: [0], D3ColdSupported: [1], Reserved: [2-31]
    uint _bitfield0;
    uint D3IdleTimeout;
}

struct STORAGE_IDLE_POWERUP_REASON
{
    uint Version;
    uint Size;
    STORAGE_POWERUP_REASON_TYPE PowerupReason;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_device_power_cap
struct STORAGE_DEVICE_POWER_CAP
{
    uint  Version;
    uint  Size;
    STORAGE_DEVICE_POWER_CAP_UNITS Units;
    ulong MaxPower;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_rpmb_data_frame
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
    STORAGE_COUNTER[1] Counters; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/FileIO/storage-hw-firmware-info-query
struct STORAGE_HW_FIRMWARE_INFO_QUERY
{
    uint Version;
    uint Size;
    uint Flags;
    uint Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/FileIO/storage-hw-firmware-slot-info
struct STORAGE_HW_FIRMWARE_SLOT_INFO
{
    uint      Version;
    uint      Size;
    ubyte     SlotNumber;
    // Native bit field: ReadOnly: [0], Reserved0: [1-7]
    ubyte     _bitfield0;
    ubyte[6]  Reserved1;
    ubyte[16] Revision;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/FileIO/storage-hw-firmware-info
struct STORAGE_HW_FIRMWARE_INFO
{
    uint     Version;
    uint     Size;
    // Native bit field: SupportUpgrade: [0], Reserved0: [1-7]
    ubyte    _bitfield0;
    ubyte    SlotCount;
    ubyte    ActiveSlot;
    ubyte    PendingActivateSlot;
    BOOLEAN  FirmwareShared;
    ubyte[3] Reserved;
    uint     ImagePayloadAlignment;
    uint     ImagePayloadMaxSize;
    STORAGE_HW_FIRMWARE_SLOT_INFO[1] Slot; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_hw_firmware_download
struct STORAGE_HW_FIRMWARE_DOWNLOAD
{
    uint     Version;
    uint     Size;
    uint     Flags;
    ubyte    Slot;
    ubyte[3] Reserved;
    ulong    Offset;
    ulong    BufferSize;
    ubyte[1] ImageBuffer; // Flexible array
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
    ubyte[1] ImageBuffer; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_hw_firmware_activate
struct STORAGE_HW_FIRMWARE_ACTIVATE
{
    uint     Version;
    uint     Size;
    uint     Flags;
    ubyte    Slot;
    ubyte[3] Reserved0;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-storage_protocol_command
struct STORAGE_PROTOCOL_COMMAND
{
    uint     Version;
    uint     Length;
    STORAGE_PROTOCOL_TYPE ProtocolType;
    uint     Flags;
    uint     ReturnStatus;
    uint     ErrorCode;
    uint     CommandLength;
    uint     ErrorInfoLength;
    uint     DataToDeviceTransferLength;
    uint     DataFromDeviceTransferLength;
    uint     TimeOutValue;
    uint     ErrorInfoOffset;
    uint     DataToDeviceBufferOffset;
    uint     DataFromDeviceBufferOffset;
    uint     CommandSpecific;
    uint     Reserved0;
    uint     FixedProtocolReturnData;
    uint     FixedProtocolReturnData2;
    uint[2]  Reserved1;
    ubyte[1] Command; // Flexible array
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
    uint       Version;
    uint       Size;
    GUID       DeviceGuid;
    wchar[256] SymbolicLink;
}

struct SCM_LOGICAL_DEVICES
{
    uint Version;
    uint Size;
    uint DeviceCount;
    SCM_LOGICAL_DEVICE_INSTANCE[1] Devices; // Flexible array
}

struct SCM_PHYSICAL_DEVICE_INSTANCE
{
    uint       Version;
    uint       Size;
    uint       NfitHandle;
    wchar[256] SymbolicLink;
}

struct SCM_PHYSICAL_DEVICES
{
    uint Version;
    uint Size;
    uint DeviceCount;
    SCM_PHYSICAL_DEVICE_INSTANCE[1] Devices; // Flexible array
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
    SCM_REGION[1] Regions; // Flexible array
}

struct SCM_BUS_PROPERTY_QUERY
{
    uint                Version;
    uint                Size;
    SCM_BUS_PROPERTY_ID PropertyId;
    SCM_BUS_QUERY_TYPE  QueryType;
    ubyte[1]            AdditionalParameters; // Flexible array
}

struct SCM_BUS_RUNTIME_FW_ACTIVATION_INFO
{
    uint    Version;
    uint    Size;
    BOOLEAN RuntimeFwActivationSupported;
    SCM_BUS_FIRMWARE_ACTIVATION_STATE FirmwareActivationState;
    struct FirmwareActivationCapability
    {
        // Native bit field: FwManagedIoQuiesceFwActivationSupported: [0], OsManagedIoQuiesceFwActivationSupported: [1], WarmResetBasedFwActivationSupported: [2], Reserved: [3-31]
        uint _bitfield0;
    }
    ulong   EstimatedFirmwareActivationTimeInUSecs;
    ulong   EstimatedProcessorAccessQuiesceTimeInUSecs;
    ulong   EstimatedIOAccessQuiesceTimeInUSecs;
    ulong   PlatformSupportedMaxIOAccessQuiesceTimeInUSecs;
}

struct SCM_BUS_DEDICATED_MEMORY_DEVICE_INFO
{
    GUID  DeviceGuid;
    uint  DeviceNumber;
    struct Flags
    {
        // Native bit field: ForcedByRegistry: [0], Initialized: [1], Reserved: [2-31]
        uint _bitfield0;
    }
    ulong DeviceSize;
}

struct SCM_BUS_DEDICATED_MEMORY_DEVICES_INFO
{
    uint Version;
    uint Size;
    uint DeviceCount;
    SCM_BUS_DEDICATED_MEMORY_DEVICE_INFO[1] Devices; // Flexible array
}

struct SCM_BUS_PROPERTY_SET
{
    uint                Version;
    uint                Size;
    SCM_BUS_PROPERTY_ID PropertyId;
    SCM_BUS_SET_TYPE    SetType;
    ubyte[1]            AdditionalParameters; // Flexible array
}

struct SCM_BUS_DEDICATED_MEMORY_STATE
{
    BOOLEAN ActivateState;
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
    SCM_INTERLEAVED_PD_INFO[1] InterleaveSet; // Flexible array
}

struct SCM_PD_PROPERTY_QUERY
{
    uint               Version;
    uint               Size;
    SCM_PD_PROPERTY_ID PropertyId;
    SCM_PD_QUERY_TYPE  QueryType;
    ubyte[1]           AdditionalParameters; // Flexible array
}

struct SCM_PD_PROPERTY_SET
{
    uint               Version;
    uint               Size;
    SCM_PD_PROPERTY_ID PropertyId;
    SCM_PD_SET_TYPE    SetType;
    ubyte[1]           AdditionalParameters; // Flexible array
}

struct SCM_PD_RUNTIME_FW_ACTIVATION_ARM_STATE
{
    BOOLEAN ArmState;
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
    CHAR[1]   SerialNumber; // Flexible array
}

struct SCM_PD_DEVICE_SPECIFIC_PROPERTY
{
    wchar[128] Name;
    long       Value;
}

struct SCM_PD_DEVICE_SPECIFIC_INFO
{
    uint Version;
    uint Size;
    uint NumberOfProperties;
    SCM_PD_DEVICE_SPECIFIC_PROPERTY[1] DeviceSpecificProperties; // Flexible array
}

struct SCM_PD_FIRMWARE_SLOT_INFO
{
    uint      Version;
    uint      Size;
    ubyte     SlotNumber;
    // Native bit field: ReadOnly: [0], Reserved0: [1-7]
    ubyte     _bitfield0;
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
    SCM_PD_FIRMWARE_SLOT_INFO[1] Slots; // Flexible array
}

struct SCM_PD_MANAGEMENT_STATUS
{
    uint                 Version;
    uint                 Size;
    SCM_PD_HEALTH_STATUS Health;
    uint                 NumberOfOperationalStatus;
    uint                 NumberOfAdditionalReasons;
    SCM_PD_OPERATIONAL_STATUS[16] OperationalStatus;
    SCM_PD_OPERATIONAL_STATUS_REASON[1] AdditionalReasons; // Flexible array
}

struct SCM_PD_LOCATION_STRING
{
    uint     Version;
    uint     Size;
    wchar[1] Location; // Flexible array
}

struct SCM_PD_FRU_ID_STRING
{
    uint     Version;
    uint     Size;
    uint     IdentifierSize;
    ubyte[1] Identifier; // Flexible array
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
    ubyte[1] FirmwareImage; // Flexible array
}

struct SCM_PD_FIRMWARE_ACTIVATE
{
    uint  Version;
    uint  Size;
    uint  Flags;
    ubyte Slot;
}

struct SCM_PD_RUNTIME_FW_ACTIVATION_INFO
{
    uint Version;
    uint Size;
    SCM_PD_LAST_FW_ACTIVATION_STATUS LastFirmwareActivationStatus;
    SCM_PD_FIRMWARE_ACTIVATION_STATE FirmwareActivationState;
}

struct SCM_PD_PASSTHROUGH_INPUT
{
    uint     Version;
    uint     Size;
    GUID     ProtocolGuid;
    uint     DataSize;
    ubyte[1] Data; // Flexible array
}

struct SCM_PD_PASSTHROUGH_OUTPUT
{
    uint     Version;
    uint     Size;
    GUID     ProtocolGuid;
    uint     DataSize;
    ubyte[1] Data; // Flexible array
}

struct SCM_PD_PASSTHROUGH_INVDIMM_INPUT
{
    uint     Opcode;
    uint     OpcodeParametersLength;
    ubyte[1] OpcodeParameters; // Flexible array
}

struct SCM_PD_PASSTHROUGH_INVDIMM_OUTPUT
{
    ushort   GeneralStatus;
    ushort   ExtendedStatus;
    uint     OutputDataLength;
    ubyte[1] OutputData; // Flexible array
}

struct SCM_PD_REINITIALIZE_MEDIA_INPUT
{
    uint Version;
    uint Size;
    struct Options
    {
        // Native bit field: Overwrite: [0]
        uint _bitfield0;
    }
}

struct SCM_PD_REINITIALIZE_MEDIA_OUTPUT
{
    uint Version;
    uint Size;
    SCM_PD_MEDIA_REINITIALIZATION_STATUS Status;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-format_parameters
struct FORMAT_PARAMETERS
{
    MEDIA_TYPE MediaType;
    uint       StartCylinderNumber;
    uint       EndCylinderNumber;
    uint       StartHeadNumber;
    uint       EndHeadNumber;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-format_ex_parameters
struct FORMAT_EX_PARAMETERS
{
    MEDIA_TYPE MediaType;
    uint       StartCylinderNumber;
    uint       EndCylinderNumber;
    uint       StartHeadNumber;
    uint       EndHeadNumber;
    ushort     FormatGapLength;
    ushort     SectorsPerTrack;
    ushort[1]  SectorNumber; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-disk_geometry
struct DISK_GEOMETRY
{
    long       Cylinders;
    MEDIA_TYPE MediaType;
    uint       TracksPerCylinder;
    uint       SectorsPerTrack;
    uint       BytesPerSector;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-partition_information
struct PARTITION_INFORMATION
{
    long    StartingOffset;
    long    PartitionLength;
    uint    HiddenSectors;
    uint    PartitionNumber;
    ubyte   PartitionType;
    BOOLEAN BootIndicator;
    BOOLEAN RecognizedPartition;
    BOOLEAN RewritePartition;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-set_partition_information
struct SET_PARTITION_INFORMATION
{
    ubyte PartitionType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-drive_layout_information
struct DRIVE_LAYOUT_INFORMATION
{
    uint PartitionCount;
    uint Signature;
    PARTITION_INFORMATION[1] PartitionEntry; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-verify_information
struct VERIFY_INFORMATION
{
    long StartingOffset;
    uint Length;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-reassign_blocks
struct REASSIGN_BLOCKS
{
    ushort  Reserved;
    ushort  Count;
    uint[1] BlockNumber; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-reassign_blocks_ex
struct REASSIGN_BLOCKS_EX
{
align (1):
    ushort  Reserved;
    ushort  Count;
    long[1] BlockNumber; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-partition_information_gpt
struct PARTITION_INFORMATION_GPT
{
    GUID           PartitionType;
    GUID           PartitionId;
    GPT_ATTRIBUTES Attributes;
    wchar[36]      Name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-partition_information_mbr
struct PARTITION_INFORMATION_MBR
{
    ubyte   PartitionType;
    BOOLEAN BootIndicator;
    BOOLEAN RecognizedPartition;
    uint    HiddenSectors;
    GUID    PartitionId;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-create_disk_gpt
struct CREATE_DISK_GPT
{
    GUID DiskId;
    uint MaxPartitionCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-create_disk_mbr
struct CREATE_DISK_MBR
{
    uint Signature;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-create_disk
struct CREATE_DISK
{
    PARTITION_STYLE PartitionStyle;
    union
    {
        CREATE_DISK_MBR Mbr;
        CREATE_DISK_GPT Gpt;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-get_length_information
struct GET_LENGTH_INFORMATION
{
    long Length;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-partition_information_ex
struct PARTITION_INFORMATION_EX
{
    PARTITION_STYLE PartitionStyle;
    long            StartingOffset;
    long            PartitionLength;
    uint            PartitionNumber;
    BOOLEAN         RewritePartition;
    BOOLEAN         IsServicePartition;
    union
    {
        PARTITION_INFORMATION_MBR Mbr;
        PARTITION_INFORMATION_GPT Gpt;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-drive_layout_information_gpt
struct DRIVE_LAYOUT_INFORMATION_GPT
{
    GUID DiskId;
    long StartingUsableOffset;
    long UsableLength;
    uint MaxPartitionCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-drive_layout_information_mbr
struct DRIVE_LAYOUT_INFORMATION_MBR
{
    uint Signature;
    uint CheckSum;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-drive_layout_information_ex
struct DRIVE_LAYOUT_INFORMATION_EX
{
    uint PartitionStyle;
    uint PartitionCount;
    union
    {
        DRIVE_LAYOUT_INFORMATION_MBR Mbr;
        DRIVE_LAYOUT_INFORMATION_GPT Gpt;
    }
    PARTITION_INFORMATION_EX[1] PartitionEntry; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-disk_int13_info
struct DISK_INT13_INFO
{
    ushort DriveSelect;
    uint   MaxCylinders;
    ushort SectorsPerTrack;
    ushort MaxHeads;
    ushort NumberDrives;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-disk_ex_int13_info
struct DISK_EX_INT13_INFO
{
    ushort ExBufferSize;
    ushort ExFlags;
    uint   ExCylinders;
    uint   ExHeads;
    uint   ExSectorsPerTrack;
    ulong  ExSectorsPerDrive;
    ushort ExSectorSize;
    ushort ExReserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-disk_detection_info
struct DISK_DETECTION_INFO
{
    uint           SizeOfDetectInfo;
    DETECTION_TYPE DetectionType;
    union
    {
        struct
        {
            DISK_INT13_INFO    Int13;
            DISK_EX_INT13_INFO ExInt13;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-disk_partition_info
struct DISK_PARTITION_INFO
{
    uint            SizeOfPartitionInfo;
    PARTITION_STYLE PartitionStyle;
    union
    {
        struct Mbr
        {
            uint Signature;
            uint CheckSum;
        }
        struct Gpt
        {
            GUID DiskId;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-disk_geometry_ex
struct DISK_GEOMETRY_EX
{
    DISK_GEOMETRY Geometry;
    long          DiskSize;
    ubyte[1]      Data; // Flexible array
}

struct DISK_CONTROLLER_NUMBER
{
    uint ControllerNumber;
    uint DiskNumber;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-disk_cache_information
struct DISK_CACHE_INFORMATION
{
    BOOLEAN ParametersSavable;
    BOOLEAN ReadCacheEnabled;
    BOOLEAN WriteCacheEnabled;
    DISK_CACHE_RETENTION_PRIORITY ReadRetentionPriority;
    DISK_CACHE_RETENTION_PRIORITY WriteRetentionPriority;
    ushort  DisablePrefetchTransferLength;
    BOOLEAN PrefetchScalar;
    union
    {
        struct ScalarPrefetch
        {
            ushort Minimum;
            ushort Maximum;
            ushort MaximumBlocks;
        }
        struct BlockPrefetch
        {
            ushort Minimum;
            ushort Maximum;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-disk_grow_partition
struct DISK_GROW_PARTITION
{
    uint PartitionNumber;
    long BytesToGrow;
}

struct HISTOGRAM_BUCKET
{
    uint Reads;
    uint Writes;
}

struct DISK_HISTOGRAM
{
    long              DiskSize;
    long              Start;
    long              End;
    long              Average;
    long              AverageRead;
    long              AverageWrite;
    uint              Granularity;
    uint              Size;
    uint              ReadCount;
    uint              WriteCount;
    HISTOGRAM_BUCKET* Histogram;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-disk_performance
struct DISK_PERFORMANCE
{
    long     BytesRead;
    long     BytesWritten;
    long     ReadTime;
    long     WriteTime;
    long     IdleTime;
    uint     ReadCount;
    uint     WriteCount;
    uint     QueueDepth;
    uint     SplitCount;
    long     QueryTime;
    uint     StorageDeviceNumber;
    wchar[8] StorageManagerName;
}

struct DISK_RECORD
{
    long    ByteOffset;
    long    StartTime;
    long    EndTime;
    void*   VirtualAddress;
    uint    NumberOfBytes;
    ubyte   DeviceNumber;
    BOOLEAN ReadRequest;
}

struct DISK_LOGGING
{
    ubyte Function;
    void* BufferAddress;
    uint  BufferSize;
}

struct BIN_RANGE
{
    long StartValue;
    long Length;
}

struct PERF_BIN
{
    uint         NumberOfBins;
    uint         TypeOfBin;
    BIN_RANGE[1] BinsRanges; // Flexible array
}

struct BIN_COUNT
{
    BIN_RANGE BinRange;
    uint      BinCount;
}

struct BIN_RESULTS
{
    uint         NumberOfBins;
    BIN_COUNT[1] BinCounts; // Flexible array
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
    ubyte[1] bBuffer; // Flexible array
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
    ubyte[1]     bBuffer; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-get_disk_attributes
struct GET_DISK_ATTRIBUTES
{
    uint  Version;
    uint  Reserved1;
    ulong Attributes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-set_disk_attributes
struct SET_DISK_ATTRIBUTES
{
    uint     Version;
    BOOLEAN  Persist;
    ubyte[3] Reserved1;
    ulong    Attributes;
    ulong    AttributesMask;
    uint[4]  Reserved2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-changer_element
struct CHANGER_ELEMENT
{
    ELEMENT_TYPE ElementType;
    uint         ElementAddress;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-changer_element_list
struct CHANGER_ELEMENT_LIST
{
    CHANGER_ELEMENT Element;
    uint            NumberOfElements;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-get_changer_parameters
struct GET_CHANGER_PARAMETERS
{
    uint             Size;
    ushort           NumberTransportElements;
    ushort           NumberStorageElements;
    ushort           NumberCleanerSlots;
    ushort           NumberIEElements;
    ushort           NumberDataTransferElements;
    ushort           NumberOfDoors;
    ushort           FirstSlotNumber;
    ushort           FirstDriveNumber;
    ushort           FirstTransportNumber;
    ushort           FirstIEPortNumber;
    ushort           FirstCleanerSlotAddress;
    ushort           MagazineSize;
    uint             DriveCleanTimeout;
    CHANGER_FEATURES Features0;
    GET_CHANGER_PARAMETERS_FEATURES1 Features1;
    ubyte            MoveFromTransport;
    ubyte            MoveFromSlot;
    ubyte            MoveFromIePort;
    ubyte            MoveFromDrive;
    ubyte            ExchangeFromTransport;
    ubyte            ExchangeFromSlot;
    ubyte            ExchangeFromIePort;
    ubyte            ExchangeFromDrive;
    ubyte            LockUnlockCapabilities;
    ubyte            PositionCapabilities;
    ubyte[2]         Reserved1;
    uint[2]          Reserved2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-changer_product_data
struct CHANGER_PRODUCT_DATA
{
    ubyte[8]  VendorId;
    ubyte[16] ProductId;
    ubyte[4]  Revision;
    ubyte[32] SerialNumber;
    ubyte     DeviceType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-changer_set_access
struct CHANGER_SET_ACCESS
{
    CHANGER_ELEMENT Element;
    uint            Control;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-changer_read_element_status
struct CHANGER_READ_ELEMENT_STATUS
{
    CHANGER_ELEMENT_LIST ElementList;
    BOOLEAN              VolumeTagInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-changer_element_status
struct CHANGER_ELEMENT_STATUS
{
    CHANGER_ELEMENT Element;
    CHANGER_ELEMENT SrcElementAddress;
    CHANGER_ELEMENT_STATUS_FLAGS Flags;
    uint            ExceptionCode;
    ubyte           TargetId;
    ubyte           Lun;
    ushort          Reserved;
    ubyte[36]       PrimaryVolumeID;
    ubyte[36]       AlternateVolumeID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-changer_element_status_ex
struct CHANGER_ELEMENT_STATUS_EX
{
    CHANGER_ELEMENT Element;
    CHANGER_ELEMENT SrcElementAddress;
    CHANGER_ELEMENT_STATUS_FLAGS Flags;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-changer_initialize_element_status
struct CHANGER_INITIALIZE_ELEMENT_STATUS
{
    CHANGER_ELEMENT_LIST ElementList;
    BOOLEAN              BarCodeScan;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-changer_set_position
struct CHANGER_SET_POSITION
{
    CHANGER_ELEMENT Transport;
    CHANGER_ELEMENT Destination;
    BOOLEAN         Flip;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-changer_exchange_medium
struct CHANGER_EXCHANGE_MEDIUM
{
    CHANGER_ELEMENT Transport;
    CHANGER_ELEMENT Source;
    CHANGER_ELEMENT Destination1;
    CHANGER_ELEMENT Destination2;
    BOOLEAN         Flip1;
    BOOLEAN         Flip2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-changer_move_medium
struct CHANGER_MOVE_MEDIUM
{
    CHANGER_ELEMENT Transport;
    CHANGER_ELEMENT Source;
    CHANGER_ELEMENT Destination;
    BOOLEAN         Flip;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-changer_send_volume_tag_information
struct CHANGER_SEND_VOLUME_TAG_INFORMATION
{
    CHANGER_ELEMENT StartingElement;
    uint            ActionCode;
    ubyte[40]       VolumeIDTemplate;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-read_element_address_info
struct READ_ELEMENT_ADDRESS_INFO
{
    uint NumberOfElements;
    CHANGER_ELEMENT_STATUS[1] ElementStatus; // Flexible array
}

struct PATHNAME_BUFFER
{
    uint     PathNameLength;
    wchar[1] Name; // Flexible array
}

struct FSCTL_QUERY_FAT_BPB_BUFFER
{
    ubyte[36] First0x24BytesOfBootSector;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-ntfs_volume_data_buffer
struct NTFS_VOLUME_DATA_BUFFER
{
    long VolumeSerialNumber;
    long NumberSectors;
    long TotalClusters;
    long FreeClusters;
    long TotalReserved;
    uint BytesPerSector;
    uint BytesPerCluster;
    uint BytesPerFileRecordSegment;
    uint ClustersPerFileRecordSegment;
    long MftValidDataLength;
    long MftStartLcn;
    long Mft2StartLcn;
    long MftZoneStart;
    long MftZoneEnd;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-ntfs_extended_volume_data
struct NTFS_EXTENDED_VOLUME_DATA
{
    uint   ByteCount;
    ushort MajorVersion;
    ushort MinorVersion;
    uint   BytesPerPhysicalSector;
    ushort LfsMajorVersion;
    ushort LfsMinorVersion;
    uint   MaxDeviceTrimExtentCount;
    uint   MaxDeviceTrimByteCount;
    uint   MaxVolumeTrimExtentCount;
    uint   MaxVolumeTrimByteCount;
}

struct REFS_VOLUME_DATA_BUFFER
{
    uint     ByteCount;
    uint     MajorVersion;
    uint     MinorVersion;
    uint     BytesPerPhysicalSector;
    long     VolumeSerialNumber;
    long     NumberSectors;
    long     TotalClusters;
    long     FreeClusters;
    long     TotalReserved;
    uint     BytesPerSector;
    uint     BytesPerCluster;
    long     MaximumSizeOfResidentFile;
    ushort   FastTierDataFillRatio;
    ushort   SlowTierDataFillRatio;
    uint     DestagesFastTierToSlowTierRate;
    ushort   MetadataChecksumType;
    ubyte[6] Reserved0;
    uint     DriverMajorVersion;
    uint     DriverMinorVersion;
    long[7]  Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-starting_lcn_input_buffer
struct STARTING_LCN_INPUT_BUFFER
{
    long StartingLcn;
}

struct STARTING_LCN_INPUT_BUFFER_EX
{
    long StartingLcn;
    uint Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-volume_bitmap_buffer
struct VOLUME_BITMAP_BUFFER
{
    long     StartingLcn;
    long     BitmapSize;
    ubyte[1] Buffer; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-starting_vcn_input_buffer
struct STARTING_VCN_INPUT_BUFFER
{
    long StartingVcn;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-retrieval_pointers_buffer
struct RETRIEVAL_POINTERS_BUFFER
{
    uint ExtentCount;
    long StartingVcn;
    struct
    {
        long NextVcn;
        long Lcn;
    }
}

struct RETRIEVAL_POINTERS_AND_REFCOUNT_BUFFER
{
    uint ExtentCount;
    long StartingVcn;
    struct
    {
        long NextVcn;
        long Lcn;
        uint ReferenceCount;
    }
}

struct RETRIEVAL_POINTER_COUNT
{
    uint ExtentCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-ntfs_file_record_input_buffer
struct NTFS_FILE_RECORD_INPUT_BUFFER
{
    long FileReferenceNumber;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-ntfs_file_record_output_buffer
struct NTFS_FILE_RECORD_OUTPUT_BUFFER
{
    long     FileReferenceNumber;
    uint     FileRecordLength;
    ubyte[1] FileRecordBuffer; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-move_file_data
struct MOVE_FILE_DATA
{
    HANDLE FileHandle;
    long   StartingVcn;
    long   StartingLcn;
    uint   ClusterCount;
}

struct MOVE_FILE_RECORD_DATA
{
    HANDLE FileHandle;
    long   SourceFileRecord;
    long   TargetFileRecord;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-find_by_sid_data
struct FIND_BY_SID_DATA
{
    uint Restart;
    SID  Sid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-find_by_sid_output
struct FIND_BY_SID_OUTPUT
{
    uint     NextEntryOffset;
    uint     FileIndex;
    uint     FileNameLength;
    wchar[1] FileName; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-mft_enum_data_v0
struct MFT_ENUM_DATA_V0
{
    ulong StartFileReferenceNumber;
    long  LowUsn;
    long  HighUsn;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-mft_enum_data_v1
struct MFT_ENUM_DATA_V1
{
    ulong  StartFileReferenceNumber;
    long   LowUsn;
    long   HighUsn;
    ushort MinMajorVersion;
    ushort MaxMajorVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-create_usn_journal_data
struct CREATE_USN_JOURNAL_DATA
{
    ulong MaximumSize;
    ulong AllocationDelta;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-read_file_usn_data
struct READ_FILE_USN_DATA
{
    ushort MinMajorVersion;
    ushort MaxMajorVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-read_usn_journal_data_v0
struct READ_USN_JOURNAL_DATA_V0
{
    long  StartUsn;
    uint  ReasonMask;
    uint  ReturnOnlyOnClose;
    ulong Timeout;
    ulong BytesToWaitFor;
    ulong UsnJournalID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-read_usn_journal_data_v1
struct READ_USN_JOURNAL_DATA_V1
{
    long   StartUsn;
    uint   ReasonMask;
    uint   ReturnOnlyOnClose;
    ulong  Timeout;
    ulong  BytesToWaitFor;
    ulong  UsnJournalID;
    ushort MinMajorVersion;
    ushort MaxMajorVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-usn_track_modified_ranges
struct USN_TRACK_MODIFIED_RANGES
{
    uint  Flags;
    uint  Unused;
    ulong ChunkSize;
    long  FileSizeThreshold;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-usn_range_track_output
struct USN_RANGE_TRACK_OUTPUT
{
    long Usn;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-usn_record_v2
struct USN_RECORD_V2
{
    uint     RecordLength;
    ushort   MajorVersion;
    ushort   MinorVersion;
    ulong    FileReferenceNumber;
    ulong    ParentFileReferenceNumber;
    long     Usn;
    long     TimeStamp;
    uint     Reason;
    uint     SourceInfo;
    uint     SecurityId;
    uint     FileAttributes;
    ushort   FileNameLength;
    ushort   FileNameOffset;
    wchar[1] FileName; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-usn_record_v3
struct USN_RECORD_V3
{
    uint        RecordLength;
    ushort      MajorVersion;
    ushort      MinorVersion;
    FILE_ID_128 FileReferenceNumber;
    FILE_ID_128 ParentFileReferenceNumber;
    long        Usn;
    long        TimeStamp;
    uint        Reason;
    uint        SourceInfo;
    uint        SecurityId;
    uint        FileAttributes;
    ushort      FileNameLength;
    ushort      FileNameOffset;
    wchar[1]    FileName; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-usn_record_common_header
struct USN_RECORD_COMMON_HEADER
{
    uint   RecordLength;
    ushort MajorVersion;
    ushort MinorVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-usn_record_extent
struct USN_RECORD_EXTENT
{
    long Offset;
    long Length;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-usn_record_v4
struct USN_RECORD_V4
{
    USN_RECORD_COMMON_HEADER Header;
    FILE_ID_128          FileReferenceNumber;
    FILE_ID_128          ParentFileReferenceNumber;
    long                 Usn;
    uint                 Reason;
    USN_SOURCE_INFO_ID   SourceInfo;
    uint                 RemainingExtents;
    ushort               NumberOfExtents;
    ushort               ExtentSize;
    USN_RECORD_EXTENT[1] Extents; // Flexible array
}

union USN_RECORD_UNION
{
    USN_RECORD_COMMON_HEADER Header;
    USN_RECORD_V2 V2;
    USN_RECORD_V3 V3;
    USN_RECORD_V4 V4;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-usn_journal_data_v0
struct USN_JOURNAL_DATA_V0
{
    ulong UsnJournalID;
    long  FirstUsn;
    long  NextUsn;
    long  LowestValidUsn;
    long  MaxUsn;
    ulong MaximumSize;
    ulong AllocationDelta;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-usn_journal_data_v1
struct USN_JOURNAL_DATA_V1
{
    ulong  UsnJournalID;
    long   FirstUsn;
    long   NextUsn;
    long   LowestValidUsn;
    long   MaxUsn;
    ulong  MaximumSize;
    ulong  AllocationDelta;
    ushort MinSupportedMajorVersion;
    ushort MaxSupportedMajorVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-usn_journal_data_v2
struct USN_JOURNAL_DATA_V2
{
    ulong  UsnJournalID;
    long   FirstUsn;
    long   NextUsn;
    long   LowestValidUsn;
    long   MaxUsn;
    ulong  MaximumSize;
    ulong  AllocationDelta;
    ushort MinSupportedMajorVersion;
    ushort MaxSupportedMajorVersion;
    uint   Flags;
    ulong  RangeTrackChunkSize;
    long   RangeTrackFileSizeThreshold;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-delete_usn_journal_data
struct DELETE_USN_JOURNAL_DATA
{
    ulong            UsnJournalID;
    USN_DELETE_FLAGS DeleteFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-mark_handle_info
struct MARK_HANDLE_INFO
{
    union
    {
        uint UsnSourceInfo;
        uint CopyNumber;
    }
    HANDLE VolumeHandle;
    uint   HandleInfo;
}

struct BULK_SECURITY_TEST_DATA
{
    uint    DesiredAccess;
    uint[1] SecurityIds; // Flexible array
}

struct FILE_PREFETCH
{
    uint     Type;
    uint     Count;
    ulong[1] Prefetch; // Flexible array
}

struct FILE_PREFETCH_EX
{
    uint     Type;
    uint     Count;
    void*    Context;
    ulong[1] Prefetch; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-filesystem_statistics
struct FILESYSTEM_STATISTICS
{
    FILESYSTEM_STATISTICS_TYPE FileSystemType;
    ushort Version;
    uint   SizeOfCompleteStructure;
    uint   UserFileReads;
    uint   UserFileReadBytes;
    uint   UserDiskReads;
    uint   UserFileWrites;
    uint   UserFileWriteBytes;
    uint   UserDiskWrites;
    uint   MetaDataReads;
    uint   MetaDataReadBytes;
    uint   MetaDataDiskReads;
    uint   MetaDataWrites;
    uint   MetaDataWriteBytes;
    uint   MetaDataDiskWrites;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-fat_statistics
struct FAT_STATISTICS
{
    uint CreateHits;
    uint SuccessfulCreates;
    uint FailedCreates;
    uint NonCachedReads;
    uint NonCachedReadBytes;
    uint NonCachedWrites;
    uint NonCachedWriteBytes;
    uint NonCachedDiskReads;
    uint NonCachedDiskWrites;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-exfat_statistics
struct EXFAT_STATISTICS
{
    uint CreateHits;
    uint SuccessfulCreates;
    uint FailedCreates;
    uint NonCachedReads;
    uint NonCachedReadBytes;
    uint NonCachedWrites;
    uint NonCachedWriteBytes;
    uint NonCachedDiskReads;
    uint NonCachedDiskWrites;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-ntfs_statistics
struct NTFS_STATISTICS
{
    uint   LogFileFullExceptions;
    uint   OtherExceptions;
    uint   MftReads;
    uint   MftReadBytes;
    uint   MftWrites;
    uint   MftWriteBytes;
    struct MftWritesUserLevel
    {
        ushort Write;
        ushort Create;
        ushort SetInfo;
        ushort Flush;
    }
    ushort MftWritesFlushForLogFileFull;
    ushort MftWritesLazyWriter;
    ushort MftWritesUserRequest;
    uint   Mft2Writes;
    uint   Mft2WriteBytes;
    struct Mft2WritesUserLevel
    {
        ushort Write;
        ushort Create;
        ushort SetInfo;
        ushort Flush;
    }
    ushort Mft2WritesFlushForLogFileFull;
    ushort Mft2WritesLazyWriter;
    ushort Mft2WritesUserRequest;
    uint   RootIndexReads;
    uint   RootIndexReadBytes;
    uint   RootIndexWrites;
    uint   RootIndexWriteBytes;
    uint   BitmapReads;
    uint   BitmapReadBytes;
    uint   BitmapWrites;
    uint   BitmapWriteBytes;
    ushort BitmapWritesFlushForLogFileFull;
    ushort BitmapWritesLazyWriter;
    ushort BitmapWritesUserRequest;
    struct BitmapWritesUserLevel
    {
        ushort Write;
        ushort Create;
        ushort SetInfo;
    }
    uint   MftBitmapReads;
    uint   MftBitmapReadBytes;
    uint   MftBitmapWrites;
    uint   MftBitmapWriteBytes;
    ushort MftBitmapWritesFlushForLogFileFull;
    ushort MftBitmapWritesLazyWriter;
    ushort MftBitmapWritesUserRequest;
    struct MftBitmapWritesUserLevel
    {
        ushort Write;
        ushort Create;
        ushort SetInfo;
        ushort Flush;
    }
    uint   UserIndexReads;
    uint   UserIndexReadBytes;
    uint   UserIndexWrites;
    uint   UserIndexWriteBytes;
    uint   LogFileReads;
    uint   LogFileReadBytes;
    uint   LogFileWrites;
    uint   LogFileWriteBytes;
    struct Allocate
    {
        uint Calls;
        uint Clusters;
        uint Hints;
        uint RunsReturned;
        uint HintsHonored;
        uint HintsClusters;
        uint Cache;
        uint CacheClusters;
        uint CacheMiss;
        uint CacheMissClusters;
    }
    uint   DiskResourcesExhausted;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-filesystem_statistics_ex
struct FILESYSTEM_STATISTICS_EX
{
    FILESYSTEM_STATISTICS_TYPE FileSystemType;
    ushort Version;
    uint   SizeOfCompleteStructure;
    ulong  UserFileReads;
    ulong  UserFileReadBytes;
    ulong  UserDiskReads;
    ulong  UserFileWrites;
    ulong  UserFileWriteBytes;
    ulong  UserDiskWrites;
    ulong  MetaDataReads;
    ulong  MetaDataReadBytes;
    ulong  MetaDataDiskReads;
    ulong  MetaDataWrites;
    ulong  MetaDataWriteBytes;
    ulong  MetaDataDiskWrites;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-ntfs_statistics_ex
struct NTFS_STATISTICS_EX
{
    uint  LogFileFullExceptions;
    uint  OtherExceptions;
    ulong MftReads;
    ulong MftReadBytes;
    ulong MftWrites;
    ulong MftWriteBytes;
    struct MftWritesUserLevel
    {
        uint Write;
        uint Create;
        uint SetInfo;
        uint Flush;
    }
    uint  MftWritesFlushForLogFileFull;
    uint  MftWritesLazyWriter;
    uint  MftWritesUserRequest;
    ulong Mft2Writes;
    ulong Mft2WriteBytes;
    struct Mft2WritesUserLevel
    {
        uint Write;
        uint Create;
        uint SetInfo;
        uint Flush;
    }
    uint  Mft2WritesFlushForLogFileFull;
    uint  Mft2WritesLazyWriter;
    uint  Mft2WritesUserRequest;
    ulong RootIndexReads;
    ulong RootIndexReadBytes;
    ulong RootIndexWrites;
    ulong RootIndexWriteBytes;
    ulong BitmapReads;
    ulong BitmapReadBytes;
    ulong BitmapWrites;
    ulong BitmapWriteBytes;
    uint  BitmapWritesFlushForLogFileFull;
    uint  BitmapWritesLazyWriter;
    uint  BitmapWritesUserRequest;
    struct BitmapWritesUserLevel
    {
        uint Write;
        uint Create;
        uint SetInfo;
        uint Flush;
    }
    ulong MftBitmapReads;
    ulong MftBitmapReadBytes;
    ulong MftBitmapWrites;
    ulong MftBitmapWriteBytes;
    uint  MftBitmapWritesFlushForLogFileFull;
    uint  MftBitmapWritesLazyWriter;
    uint  MftBitmapWritesUserRequest;
    struct MftBitmapWritesUserLevel
    {
        uint Write;
        uint Create;
        uint SetInfo;
        uint Flush;
    }
    ulong UserIndexReads;
    ulong UserIndexReadBytes;
    ulong UserIndexWrites;
    ulong UserIndexWriteBytes;
    ulong LogFileReads;
    ulong LogFileReadBytes;
    ulong LogFileWrites;
    ulong LogFileWriteBytes;
    struct Allocate
    {
        uint  Calls;
        uint  RunsReturned;
        uint  Hints;
        uint  HintsHonored;
        uint  Cache;
        uint  CacheMiss;
        ulong Clusters;
        ulong HintsClusters;
        ulong CacheClusters;
        ulong CacheMissClusters;
    }
    uint  DiskResourcesExhausted;
    ulong VolumeTrimCount;
    ulong VolumeTrimTime;
    ulong VolumeTrimByteCount;
    ulong FileLevelTrimCount;
    ulong FileLevelTrimTime;
    ulong FileLevelTrimByteCount;
    ulong VolumeTrimSkippedCount;
    ulong VolumeTrimSkippedByteCount;
    ulong NtfsFillStatInfoFromMftRecordCalledCount;
    ulong NtfsFillStatInfoFromMftRecordBailedBecauseOfAttributeListCount;
    ulong NtfsFillStatInfoFromMftRecordBailedBecauseOfNonResReparsePointCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-file_objectid_buffer
struct FILE_OBJECTID_BUFFER
{
    ubyte[16] ObjectId;
    union
    {
        struct
        {
            ubyte[16] BirthVolumeId;
            ubyte[16] BirthObjectId;
            ubyte[16] DomainId;
        }
        ubyte[48] ExtendedInfo;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-file_set_sparse_buffer
struct FILE_SET_SPARSE_BUFFER
{
    BOOLEAN SetSparse;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-file_zero_data_information
struct FILE_ZERO_DATA_INFORMATION
{
    long FileOffset;
    long BeyondFinalZero;
}

struct FILE_ZERO_DATA_INFORMATION_EX
{
    long FileOffset;
    long BeyondFinalZero;
    uint Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-file_allocated_range_buffer
struct FILE_ALLOCATED_RANGE_BUFFER
{
    long FileOffset;
    long Length;
}

struct ENCRYPTION_BUFFER
{
    uint     EncryptionOperation;
    ubyte[1] Private; // Flexible array
}

struct DECRYPTION_STATUS_BUFFER
{
    BOOLEAN NoEncryptedStreams;
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
    uint[1] DataBlockSize; // Flexible array
}

struct EXTENDED_ENCRYPTED_DATA_INFO
{
    uint ExtendedCode;
    uint Length;
    uint Flags;
    uint Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-plex_read_data_request
struct PLEX_READ_DATA_REQUEST
{
    long ByteOffset;
    uint ByteLength;
    uint PlexNumber;
}

struct SI_COPYFILE
{
    uint     SourceFileNameLength;
    uint     DestinationFileNameLength;
    uint     Flags;
    wchar[1] FileNameBuffer; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-file_make_compatible_buffer
struct FILE_MAKE_COMPATIBLE_BUFFER
{
    BOOLEAN CloseDisc;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-file_set_defect_mgmt_buffer
struct FILE_SET_DEFECT_MGMT_BUFFER
{
    BOOLEAN Disable;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-file_query_sparing_buffer
struct FILE_QUERY_SPARING_BUFFER
{
    uint    SparingUnitBytes;
    BOOLEAN SoftwareSparing;
    uint    TotalSpareBlocks;
    uint    FreeSpareBlocks;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-file_query_on_disk_vol_info_buffer
struct FILE_QUERY_ON_DISK_VOL_INFO_BUFFER
{
    long      DirectoryCount;
    long      FileCount;
    ushort    FsFormatMajVersion;
    ushort    FsFormatMinVersion;
    wchar[12] FsFormatName;
    long      FormatTime;
    long      LastUpdateTime;
    wchar[34] CopyrightInfo;
    wchar[34] AbstractInfo;
    wchar[34] FormattingImplementationInfo;
    wchar[34] LastModifyingImplementationInfo;
}

struct FILE_INITIATE_REPAIR_OUTPUT_BUFFER
{
    ulong Hint1;
    ulong Hint2;
    ulong Clsn;
    uint  Status;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-shrink_volume_information
struct SHRINK_VOLUME_INFORMATION
{
    SHRINK_VOLUME_REQUEST_TYPES ShrinkRequestType;
    ulong Flags;
    long  NewNumberOfSectors;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-txfs_modify_rm
struct TXFS_MODIFY_RM
{
    TXFS_RMF_LAGS Flags;
    uint          LogContainerCountMax;
    uint          LogContainerCountMin;
    uint          LogContainerCount;
    uint          LogGrowthIncrement;
    uint          LogAutoShrinkPercentage;
    ulong         Reserved;
    ushort        LoggingMode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-txfs_query_rm_information
struct TXFS_QUERY_RM_INFORMATION
{
    uint          BytesRequired;
    ulong         TailLsn;
    ulong         CurrentLsn;
    ulong         ArchiveTailLsn;
    ulong         LogContainerSize;
    long          HighestVirtualClock;
    uint          LogContainerCount;
    uint          LogContainerCountMax;
    uint          LogContainerCountMin;
    uint          LogGrowthIncrement;
    uint          LogAutoShrinkPercentage;
    TXFS_RMF_LAGS Flags;
    ushort        LoggingMode;
    ushort        Reserved;
    uint          RmState;
    ulong         LogCapacity;
    ulong         LogFree;
    ulong         TopsSize;
    ulong         TopsUsed;
    ulong         TransactionCount;
    ulong         OnePCCount;
    ulong         TwoPCCount;
    ulong         NumberLogFileFull;
    ulong         OldestTransactionAge;
    GUID          RMName;
    uint          TmLogPathOffset;
}

struct TXFS_ROLLFORWARD_REDO_INFORMATION
{
    long  LastVirtualClock;
    ulong LastRedoLsn;
    ulong HighestRecoveryLsn;
    uint  Flags;
}

struct TXFS_START_RM_INFORMATION
{
    uint     Flags;
    ulong    LogContainerSize;
    uint     LogContainerCountMin;
    uint     LogContainerCountMax;
    uint     LogGrowthIncrement;
    uint     LogAutoShrinkPercentage;
    uint     TmLogPathOffset;
    ushort   TmLogPathLength;
    ushort   LoggingMode;
    ushort   LogPathLength;
    ushort   Reserved;
    wchar[1] LogPath; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-txfs_get_metadata_info_out
struct TXFS_GET_METADATA_INFO_OUT
{
    struct TxfFileId
    {
        long LowPart;
        long HighPart;
    }
    GUID  LockingTransaction;
    ulong LastLsn;
    uint  TransactionState;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-txfs_list_transaction_locked_files_entry
struct TXFS_LIST_TRANSACTION_LOCKED_FILES_ENTRY
{
    ulong    Offset;
    uint     NameFlags;
    long     FileId;
    uint     Reserved1;
    uint     Reserved2;
    long     Reserved3;
    wchar[1] FileName; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-txfs_list_transaction_locked_files
struct TXFS_LIST_TRANSACTION_LOCKED_FILES
{
    GUID  KtmTransaction;
    ulong NumberOfFiles;
    ulong BufferSizeRequired;
    ulong Offset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-txfs_list_transactions_entry
struct TXFS_LIST_TRANSACTIONS_ENTRY
{
    GUID TransactionId;
    uint TransactionState;
    uint Reserved1;
    uint Reserved2;
    long Reserved3;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-txfs_list_transactions
struct TXFS_LIST_TRANSACTIONS
{
    ulong NumberOfTransactions;
    ulong BufferSizeRequired;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-txfs_read_backup_information_out
struct TXFS_READ_BACKUP_INFORMATION_OUT
{
    union
    {
        uint     BufferLength;
        ubyte[1] Buffer; // Flexible array
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-txfs_write_backup_information
struct TXFS_WRITE_BACKUP_INFORMATION
{
    ubyte[1] Buffer; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-txfs_get_transacted_version
struct TXFS_GET_TRANSACTED_VERSION
{
    uint   ThisBaseVersion;
    uint   LatestVersion;
    ushort ThisMiniVersion;
    ushort FirstMiniVersion;
    ushort LatestMiniVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-txfs_savepoint_information
struct TXFS_SAVEPOINT_INFORMATION
{
    HANDLE KtmTransaction;
    uint   ActionCode;
    uint   SavepointId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-txfs_create_miniversion_info
struct TXFS_CREATE_MINIVERSION_INFO
{
    ushort StructureVersion;
    ushort StructureLength;
    uint   BaseVersion;
    ushort MiniVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-txfs_transaction_active_info
struct TXFS_TRANSACTION_ACTIVE_INFO
{
    BOOLEAN TransactionsActiveAtSnapshot;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-boot_area_info
struct BOOT_AREA_INFO
{
    uint BootSectorCount;
    struct
    {
        long Offset;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-retrieval_pointer_base
struct RETRIEVAL_POINTER_BASE
{
    long FileAreaOffset;
}

struct FILE_FS_PERSISTENT_VOLUME_INFORMATION
{
    uint VolumeFlags;
    uint FlagMask;
    uint Version;
    uint Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-file_system_recognition_information
struct FILE_SYSTEM_RECOGNITION_INFORMATION
{
    CHAR[9] FileSystem;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-request_oplock_input_buffer
struct REQUEST_OPLOCK_INPUT_BUFFER
{
    ushort StructureVersion;
    ushort StructureLength;
    uint   RequestedOplockLevel;
    uint   Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-request_oplock_output_buffer
struct REQUEST_OPLOCK_OUTPUT_BUFFER
{
    ushort StructureVersion;
    ushort StructureLength;
    uint   OriginalOplockLevel;
    uint   NewOplockLevel;
    uint   Flags;
    uint   AccessMode;
    ushort ShareMode;
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
        STORAGE_QUERY_DEPENDENT_VOLUME_LEV1_ENTRY[1] Lev1Depends;
        STORAGE_QUERY_DEPENDENT_VOLUME_LEV2_ENTRY[1] Lev2Depends;
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
    ubyte[1] Descriptor; // Flexible array
}

struct SD_ENUM_SDS_OUTPUT
{
    ulong                NextOffset;
    ulong                NumSDEntriesReturned;
    ulong                NumSDBytesReturned;
    SD_ENUM_SDS_ENTRY[1] SDEntry; // Flexible array
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-lookup_stream_from_cluster_input
struct LOOKUP_STREAM_FROM_CLUSTER_INPUT
{
    uint    Flags;
    uint    NumberOfClusters;
    long[1] Cluster; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-lookup_stream_from_cluster_output
struct LOOKUP_STREAM_FROM_CLUSTER_OUTPUT
{
    uint Offset;
    uint NumberOfMatches;
    uint BufferSizeRequired;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-lookup_stream_from_cluster_entry
struct LOOKUP_STREAM_FROM_CLUSTER_ENTRY
{
    uint     OffsetToNext;
    uint     Flags;
    long     Reserved;
    long     Cluster;
    wchar[1] FileName; // Flexible array
}

struct FILE_TYPE_NOTIFICATION_INPUT
{
    uint    Flags;
    uint    NumFileTypeIDs;
    GUID[1] FileTypeID; // Flexible array
}

struct CSV_MGMT_LOCK
{
    uint Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-csv_namespace_info
struct CSV_NAMESPACE_INFO
{
    uint Version;
    uint DeviceNumber;
    long StartingOffset;
    uint SectorSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-csv_control_param
struct CSV_CONTROL_PARAM
{
    CSV_CONTROL_OP Operation;
    long           Unused;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-csv_query_redirect_state
struct CSV_QUERY_REDIRECT_STATE
{
    uint    MdsNodeId;
    uint    DsNodeId;
    BOOLEAN FileRedirected;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-csv_query_file_revision
struct CSV_QUERY_FILE_REVISION
{
    long    FileId;
    long[3] FileRevision;
}

struct CSV_QUERY_FILE_REVISION_FILE_ID_128
{
    FILE_ID_128 FileId;
    long[3]     FileRevision;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-csv_query_mds_path
struct CSV_QUERY_MDS_PATH
{
    uint     MdsNodeId;
    uint     DsNodeId;
    uint     PathLength;
    wchar[1] Path; // Flexible array
}

struct CSV_QUERY_VOLUME_REDIRECT_STATE
{
    uint    MdsNodeId;
    uint    DsNodeId;
    BOOLEAN IsDiskConnected;
    BOOLEAN ClusterEnableDirectIo;
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

struct CSV_SET_VOLUME_ID
{
    GUID VolumeId;
}

struct CSV_QUERY_VOLUME_ID
{
    GUID VolumeId;
}

struct LMR_QUERY_INFO_PARAM
{
    LMR_QUERY_INFO_CLASS Operation;
}

struct LMR_QUERY_SESSION_INFO
{
    ulong SessionId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-csv_query_veto_file_direct_io_output
struct CSV_QUERY_VETO_FILE_DIRECT_IO_OUTPUT
{
    ulong      VetoedFromAltitudeIntegral;
    ulong      VetoedFromAltitudeDecimal;
    wchar[256] Reason;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-csv_is_owned_by_csvfs
struct CSV_IS_OWNED_BY_CSVFS
{
    BOOLEAN OwnedByCSVFS;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-file_level_trim_range
struct FILE_LEVEL_TRIM_RANGE
{
    ulong Offset;
    ulong Length;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-file_level_trim
struct FILE_LEVEL_TRIM
{
    uint Key;
    uint NumRanges;
    FILE_LEVEL_TRIM_RANGE[1] Ranges; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-file_level_trim_output
struct FILE_LEVEL_TRIM_OUTPUT
{
    uint NumRangesProcessed;
}

struct CLUSTER_RANGE
{
    long StartingCluster;
    long ClusterCount;
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
        STORAGE_RESERVE_ID[1] StorageReserveIds; // Flexible array
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
    uint     NextNameOffset;
    uint     Flags;
    ulong    ParentFileReferenceNumber;
    uint     FileNameLength;
    uint     Reserved;
    wchar[1] FileName; // Flexible array
}

struct FILE_LAYOUT_INFO_ENTRY
{
    struct BasicInformation
    {
        long CreationTime;
        long LastAccessTime;
        long LastWriteTime;
        long ChangeTime;
        uint FileAttributes;
    }
    uint               OwnerId;
    uint               SecurityId;
    long               Usn;
    STORAGE_RESERVE_ID StorageReserveId;
}

struct STREAM_LAYOUT_ENTRY
{
    uint     Version;
    uint     NextStreamOffset;
    uint     Flags;
    uint     ExtentInformationOffset;
    long     AllocationSize;
    long     EndOfFile;
    uint     StreamInformationOffset;
    uint     AttributeTypeCode;
    uint     AttributeFlags;
    uint     StreamIdentifierLength;
    wchar[1] StreamIdentifier; // Flexible array
}

struct STREAM_EXTENT_ENTRY
{
    uint Flags;
    union ExtentInformation
    {
        RETRIEVAL_POINTERS_BUFFER RetrievalPointers;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-fsctl_get_integrity_information_buffer
struct FSCTL_GET_INTEGRITY_INFORMATION_BUFFER
{
    ushort ChecksumAlgorithm;
    ushort Reserved;
    uint   Flags;
    uint   ChecksumChunkSizeInBytes;
    uint   ClusterSizeInBytes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-fsctl_set_integrity_information_buffer
struct FSCTL_SET_INTEGRITY_INFORMATION_BUFFER
{
    ushort ChecksumAlgorithm;
    ushort Reserved;
    uint   Flags;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-repair_copies_input
struct REPAIR_COPIES_INPUT
{
    uint    Size;
    uint    Flags;
    long    FileOffset;
    uint    Length;
    uint    SourceCopy;
    uint    NumberOfRepairCopies;
    uint[1] RepairCopies; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-repair_copies_output
struct REPAIR_COPIES_OUTPUT
{
    uint Size;
    uint Status;
    long ResumeFileOffset;
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
    FILE_REGION_INFO[1] Region; // Flexible array
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-file_storage_tier
struct FILE_STORAGE_TIER
{
    GUID       Id;
    wchar[256] Name;
    wchar[256] Description;
    ulong      Flags;
    ulong      ProvisionedCapacity;
    FILE_STORAGE_TIER_MEDIA_TYPE MediaType;
    FILE_STORAGE_TIER_CLASS Class;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-fsctl_query_storage_classes_output
struct FSCTL_QUERY_STORAGE_CLASSES_OUTPUT
{
    uint                 Version;
    uint                 Size;
    FILE_STORAGE_TIER_FLAGS Flags;
    uint                 TotalNumberOfTiers;
    uint                 NumberOfTiersReturned;
    FILE_STORAGE_TIER[1] Tiers; // Flexible array
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-fsctl_query_region_info_input
struct FSCTL_QUERY_REGION_INFO_INPUT
{
    uint    Version;
    uint    Size;
    uint    Flags;
    uint    NumberOfTierIds;
    GUID[1] TierIds; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-file_storage_tier_region
struct FILE_STORAGE_TIER_REGION
{
    GUID  TierId;
    ulong Offset;
    ulong Length;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-fsctl_query_region_info_output
struct FSCTL_QUERY_REGION_INFO_OUTPUT
{
    uint  Version;
    uint  Size;
    uint  Flags;
    uint  Reserved;
    ulong Alignment;
    uint  TotalNumberOfRegions;
    uint  NumberOfRegionsReturned;
    FILE_STORAGE_TIER_REGION[1] Regions; // Flexible array
}

struct FILE_DESIRED_STORAGE_CLASS_INFORMATION
{
    FILE_STORAGE_TIER_CLASS Class;
    uint Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-duplicate_extents_data
struct DUPLICATE_EXTENTS_DATA
{
    HANDLE FileHandle;
    long   SourceFileOffset;
    long   TargetFileOffset;
    long   ByteCount;
}

struct DUPLICATE_EXTENTS_DATA_EX
{
    size_t Size;
    HANDLE FileHandle;
    long   SourceFileOffset;
    long   TargetFileOffset;
    long   ByteCount;
    uint   Flags;
}

struct ASYNC_DUPLICATE_EXTENTS_STATUS
{
    uint  Version;
    DUPLICATE_EXTENTS_STATE State;
    ulong SourceFileOffset;
    ulong TargetFileOffset;
    ulong ByteCount;
    ulong BytesDuplicated;
}

struct REFS_SMR_VOLUME_INFO_OUTPUT
{
    uint     Version;
    uint     Flags;
    long     SizeOfRandomlyWritableTier;
    long     FreeSpaceInRandomlyWritableTier;
    long     SizeofSMRTier;
    long     FreeSpaceInSMRTier;
    long     UsableFreeSpaceInSMRTier;
    REFS_SMR_VOLUME_GC_STATE VolumeGcState;
    uint     VolumeGcLastStatus;
    uint     CurrentGcBandFillPercentage;
    ulong[6] Unused;
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
    QUERY_BAD_RANGES_INPUT_RANGE[1] Ranges; // Flexible array
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
    QUERY_BAD_RANGES_OUTPUT_RANGE[1] BadRanges; // Flexible array
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
    uint      Version;
    uint      Flags;
    long      DataSourceId;
    ubyte[20] ResourceHash;
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
    long DataSourceId;
    uint WimFileNameOffset;
    uint WimFileNameLength;
}

struct WIM_PROVIDER_REMOVE_OVERLAY_INPUT
{
    long DataSourceId;
}

struct WIM_PROVIDER_SUSPEND_OVERLAY_INPUT
{
    long DataSourceId;
}

struct WIM_PROVIDER_OVERLAY_ENTRY
{
    uint NextEntryOffset;
    long DataSourceId;
    GUID WimGuid;
    uint WimFileNameOffset;
    uint WimType;
    uint WimIndex;
    uint Flags;
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
    ubyte[1] ContainerRootId; // Flexible array
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
    ushort   AltitudeLength;
    wchar[1] Altitude; // Flexible array
}

struct GET_FILTER_FILE_IDENTIFIER_OUTPUT
{
    ushort   FilterFileIdentifierLength;
    ubyte[1] FilterFileIdentifier; // Flexible array
}

struct FS_BPIO_INPUT
{
    FS_BPIO_OPERATIONS Operation;
    FS_BPIO_INFLAGS    InFlags;
    ulong              Reserved1;
    ulong              Reserved2;
}

struct FS_BPIO_RESULTS
{
    uint       OpStatus;
    ushort     FailingDriverNameLen;
    wchar[32]  FailingDriverName;
    ushort     FailureReasonLen;
    wchar[128] FailureReason;
}

struct FS_BPIO_INFO
{
    uint      ActiveBypassIoCount;
    ushort    StorageDriverNameLen;
    wchar[32] StorageDriverName;
}

struct FS_BPIO_OUTPUT
{
    FS_BPIO_OPERATIONS Operation;
    FS_BPIO_OUTFLAGS   OutFlags;
    ulong              Reserved1;
    ulong              Reserved2;
    union
    {
        FS_BPIO_RESULTS Enable;
        FS_BPIO_RESULTS Query;
        FS_BPIO_RESULTS VolumeStackResume;
        FS_BPIO_RESULTS StreamResume;
        FS_BPIO_INFO    GetInfo;
    }
}

struct SMB_SHARE_FLUSH_AND_PURGE_INPUT
{
    ushort Version;
}

struct SMB_SHARE_FLUSH_AND_PURGE_OUTPUT
{
    uint cEntriesPurged;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-disk_extent
struct DISK_EXTENT
{
    uint DiskNumber;
    long StartingOffset;
    long ExtentLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-volume_disk_extents
struct VOLUME_DISK_EXTENTS
{
    uint           NumberOfDiskExtents;
    DISK_EXTENT[1] Extents; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winioctl/ns-winioctl-volume_get_gpt_attributes_information
struct VOLUME_GET_GPT_ATTRIBUTES_INFORMATION
{
    ulong GptAttributes;
}

struct IO_IRP_EXT_TRACK_OFFSET_HEADER
{
    ushort Validation;
    ushort Flags;
    PIO_IRP_EXT_PROCESS_TRACKED_OFFSET_CALLBACK TrackedOffsetCallback;
}

