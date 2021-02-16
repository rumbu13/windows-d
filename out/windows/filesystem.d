module windows.filesystem;

public import windows.core;
public import windows.com : HRESULT, IConnectionPointContainer, IUnknown;
public import windows.security : SID;
public import windows.systemservices : BOOL, DETECTION_TYPE, DISK_CACHE_RETENTION_PRIORITY, FILE_SEGMENT_ELEMENT,
                                       FILE_STORAGE_TIER_CLASS, HANDLE, LARGE_INTEGER, OVERLAPPED,
                                       SECURITY_ATTRIBUTES, SHRINK_VOLUME_REQUEST_TYPES, STORAGE_BUS_TYPE,
                                       ULARGE_INTEGER;
public import windows.windowsprogramming : FILETIME, SYSTEMTIME;

extern(Windows):


// Enums


enum : int
{
    FIND_FIRST_EX_CASE_SENSITIVE       = 0x00000001,
    FIND_FIRST_EX_LARGE_FETCH          = 0x00000002,
    FIND_FIRST_EX_ON_DISK_ENTRIES_ONLY = 0x00000004,
}
alias FIND_FIRST_EX_FLAGS = int;

enum : int
{
    FILE_NOTIFY_CHANGE_FILE_NAME   = 0x00000001,
    FILE_NOTIFY_CHANGE_DIR_NAME    = 0x00000002,
    FILE_NOTIFY_CHANGE_ATTRIBUTES  = 0x00000004,
    FILE_NOTIFY_CHANGE_SIZE        = 0x00000008,
    FILE_NOTIFY_CHANGE_LAST_WRITE  = 0x00000010,
    FILE_NOTIFY_CHANGE_LAST_ACCESS = 0x00000020,
    FILE_NOTIFY_CHANGE_CREATION    = 0x00000040,
    FILE_NOTIFY_CHANGE_SECURITY    = 0x00000100,
}
alias FILE_NOTIFY_CHANGE = int;

enum : int
{
    DDD_RAW_TARGET_PATH       = 0x00000001,
    DDD_REMOVE_DEFINITION     = 0x00000002,
    DDD_EXACT_MATCH_ON_REMOVE = 0x00000004,
    DDD_NO_BROADCAST_SYSTEM   = 0x00000008,
    DDD_LUID_BROADCAST_DRIVE  = 0x00000010,
}
alias DEFINE_DOS_DEVICE_FLAGS = int;

enum : int
{
    CREATE_NEW        = 0x00000001,
    CREATE_ALWAYS     = 0x00000002,
    OPEN_EXISTING     = 0x00000003,
    OPEN_ALWAYS       = 0x00000004,
    TRUNCATE_EXISTING = 0x00000005,
}
alias FILE_CREATE_FLAGS = int;

enum : int
{
    FILE_SHARE_NONE   = 0x00000000,
    FILE_SHARE_DELETE = 0x00000004,
    FILE_SHARE_READ   = 0x00000001,
    FILE_SHARE_WRITE  = 0x00000002,
}
alias FILE_SHARE_FLAGS = int;

enum : int
{
    FILE_ATTRIBUTE_READONLY              = 0x00000001,
    FILE_ATTRIBUTE_HIDDEN                = 0x00000002,
    FILE_ATTRIBUTE_SYSTEM                = 0x00000004,
    FILE_ATTRIBUTE_DIRECTORY             = 0x00000010,
    FILE_ATTRIBUTE_ARCHIVE               = 0x00000020,
    FILE_ATTRIBUTE_DEVICE                = 0x00000040,
    FILE_ATTRIBUTE_NORMAL                = 0x00000080,
    FILE_ATTRIBUTE_TEMPORARY             = 0x00000100,
    FILE_ATTRIBUTE_SPARSE_FILE           = 0x00000200,
    FILE_ATTRIBUTE_REPARSE_POINT         = 0x00000400,
    FILE_ATTRIBUTE_COMPRESSED            = 0x00000800,
    FILE_ATTRIBUTE_OFFLINE               = 0x00001000,
    FILE_ATTRIBUTE_NOT_CONTENT_INDEXED   = 0x00002000,
    FILE_ATTRIBUTE_ENCRYPTED             = 0x00004000,
    FILE_ATTRIBUTE_INTEGRITY_STREAM      = 0x00008000,
    FILE_ATTRIBUTE_VIRTUAL               = 0x00010000,
    FILE_ATTRIBUTE_NO_SCRUB_DATA         = 0x00020000,
    FILE_ATTRIBUTE_EA                    = 0x00040000,
    FILE_ATTRIBUTE_PINNED                = 0x00080000,
    FILE_ATTRIBUTE_UNPINNED              = 0x00100000,
    FILE_ATTRIBUTE_RECALL_ON_OPEN        = 0x00040000,
    FILE_ATTRIBUTE_RECALL_ON_DATA_ACCESS = 0x00400000,
}
alias FILE_FLAGS_AND_ATTRIBUTES = int;

enum : int
{
    FILE_READ_DATA            = 0x00000001,
    FILE_LIST_DIRECTORY       = 0x00000001,
    FILE_WRITE_DATA           = 0x00000002,
    FILE_ADD_FILE             = 0x00000002,
    FILE_APPEND_DATA          = 0x00000004,
    FILE_ADD_SUBDIRECTORY     = 0x00000004,
    FILE_CREATE_PIPE_INSTANCE = 0x00000004,
    FILE_READ_EA              = 0x00000008,
    FILE_WRITE_EA             = 0x00000010,
    FILE_EXECUTE              = 0x00000020,
    FILE_TRAVERSE             = 0x00000020,
    FILE_DELETE_CHILD         = 0x00000040,
    FILE_READ_ATTRIBUTES      = 0x00000080,
    FILE_WRITE_ATTRIBUTES     = 0x00000100,
    READ_CONTROL              = 0x00020000,
    SYNCHRONIZE               = 0x00100000,
    STANDARD_RIGHTS_REQUIRED  = 0x000f0000,
    STANDARD_RIGHTS_READ      = 0x00020000,
    STANDARD_RIGHTS_WRITE     = 0x00020000,
    STANDARD_RIGHTS_EXECUTE   = 0x00020000,
    STANDARD_RIGHTS_ALL       = 0x001f0000,
    SPECIFIC_RIGHTS_ALL       = 0x0000ffff,
    FILE_ALL_ACCESS           = 0x001f01ff,
    FILE_GENERIC_READ         = 0x00120089,
    FILE_GENERIC_WRITE        = 0x00120116,
    FILE_GENERIC_EXECUTE      = 0x001200a0,
}
alias FILE_ACCESS_FLAGS = int;

enum : int
{
    TransactionOutcomeUndetermined = 0x00000001,
    TransactionOutcomeCommitted    = 0x00000002,
    TransactionOutcomeAborted      = 0x00000003,
}
alias TRANSACTION_OUTCOME = int;

enum : int
{
    FindExInfoStandard     = 0x00000000,
    FindExInfoBasic        = 0x00000001,
    FindExInfoMaxInfoLevel = 0x00000002,
}
alias FINDEX_INFO_LEVELS = int;

enum : int
{
    FindExSearchNameMatch          = 0x00000000,
    FindExSearchLimitToDirectories = 0x00000001,
    FindExSearchLimitToDevices     = 0x00000002,
    FindExSearchMaxSearchOp        = 0x00000003,
}
alias FINDEX_SEARCH_OPS = int;

enum : int
{
    ReadDirectoryNotifyInformation         = 0x00000001,
    ReadDirectoryNotifyExtendedInformation = 0x00000002,
}
alias READ_DIRECTORY_NOTIFY_INFORMATION_CLASS = int;

enum : int
{
    GetFileExInfoStandard = 0x00000000,
    GetFileExMaxInfoLevel = 0x00000001,
}
alias GET_FILEEX_INFO_LEVELS = int;

enum : int
{
    FileBasicInfo                  = 0x00000000,
    FileStandardInfo               = 0x00000001,
    FileNameInfo                   = 0x00000002,
    FileRenameInfo                 = 0x00000003,
    FileDispositionInfo            = 0x00000004,
    FileAllocationInfo             = 0x00000005,
    FileEndOfFileInfo              = 0x00000006,
    FileStreamInfo                 = 0x00000007,
    FileCompressionInfo            = 0x00000008,
    FileAttributeTagInfo           = 0x00000009,
    FileIdBothDirectoryInfo        = 0x0000000a,
    FileIdBothDirectoryRestartInfo = 0x0000000b,
    FileIoPriorityHintInfo         = 0x0000000c,
    FileRemoteProtocolInfo         = 0x0000000d,
    FileFullDirectoryInfo          = 0x0000000e,
    FileFullDirectoryRestartInfo   = 0x0000000f,
    FileStorageInfo                = 0x00000010,
    FileAlignmentInfo              = 0x00000011,
    FileIdInfo                     = 0x00000012,
    FileIdExtdDirectoryInfo        = 0x00000013,
    FileIdExtdDirectoryRestartInfo = 0x00000014,
    FileDispositionInfoEx          = 0x00000015,
    FileRenameInfoEx               = 0x00000016,
    FileCaseSensitiveInfo          = 0x00000017,
    FileNormalizedNameInfo         = 0x00000018,
    MaximumFileInfoByHandleClass   = 0x00000019,
}
alias FILE_INFO_BY_HANDLE_CLASS = int;

enum : int
{
    PropertyStandardQuery   = 0x00000000,
    PropertyExistsQuery     = 0x00000001,
    PropertyMaskQuery       = 0x00000002,
    PropertyQueryMaxDefined = 0x00000003,
}
alias STORAGE_QUERY_TYPE = int;

enum : int
{
    StorageDeviceProperty                  = 0x00000000,
    StorageAdapterProperty                 = 0x00000001,
    StorageDeviceIdProperty                = 0x00000002,
    StorageDeviceUniqueIdProperty          = 0x00000003,
    StorageDeviceWriteCacheProperty        = 0x00000004,
    StorageMiniportProperty                = 0x00000005,
    StorageAccessAlignmentProperty         = 0x00000006,
    StorageDeviceSeekPenaltyProperty       = 0x00000007,
    StorageDeviceTrimProperty              = 0x00000008,
    StorageDeviceWriteAggregationProperty  = 0x00000009,
    StorageDeviceDeviceTelemetryProperty   = 0x0000000a,
    StorageDeviceLBProvisioningProperty    = 0x0000000b,
    StorageDevicePowerProperty             = 0x0000000c,
    StorageDeviceCopyOffloadProperty       = 0x0000000d,
    StorageDeviceResiliencyProperty        = 0x0000000e,
    StorageDeviceMediumProductType         = 0x0000000f,
    StorageAdapterRpmbProperty             = 0x00000010,
    StorageAdapterCryptoProperty           = 0x00000011,
    StorageDeviceIoCapabilityProperty      = 0x00000030,
    StorageAdapterProtocolSpecificProperty = 0x00000031,
    StorageDeviceProtocolSpecificProperty  = 0x00000032,
    StorageAdapterTemperatureProperty      = 0x00000033,
    StorageDeviceTemperatureProperty       = 0x00000034,
    StorageAdapterPhysicalTopologyProperty = 0x00000035,
    StorageDevicePhysicalTopologyProperty  = 0x00000036,
    StorageDeviceAttributesProperty        = 0x00000037,
    StorageDeviceManagementStatus          = 0x00000038,
    StorageAdapterSerialNumberProperty     = 0x00000039,
    StorageDeviceLocationProperty          = 0x0000003a,
    StorageDeviceNumaProperty              = 0x0000003b,
    StorageDeviceZonedDeviceProperty       = 0x0000003c,
    StorageDeviceUnsafeShutdownCount       = 0x0000003d,
    StorageDeviceEnduranceProperty         = 0x0000003e,
}
alias STORAGE_PROPERTY_ID = int;

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
alias STORAGE_PORT_CODE_SET = int;

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
alias STORAGE_PROTOCOL_TYPE = int;

enum : int
{
    NVMeDataTypeUnknown  = 0x00000000,
    NVMeDataTypeIdentify = 0x00000001,
    NVMeDataTypeLogPage  = 0x00000002,
    NVMeDataTypeFeature  = 0x00000003,
}
alias STORAGE_PROTOCOL_NVME_DATA_TYPE = int;

enum : int
{
    AtaDataTypeUnknown  = 0x00000000,
    AtaDataTypeIdentify = 0x00000001,
    AtaDataTypeLogPage  = 0x00000002,
}
alias STORAGE_PROTOCOL_ATA_DATA_TYPE = int;

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
alias STORAGE_DEVICE_FORM_FACTOR = int;

enum : int
{
    HealthStatusUnknown   = 0x00000000,
    HealthStatusNormal    = 0x00000001,
    HealthStatusThrottled = 0x00000002,
    HealthStatusWarning   = 0x00000003,
    HealthStatusDisabled  = 0x00000004,
    HealthStatusFailed    = 0x00000005,
}
alias STORAGE_COMPONENT_HEALTH_STATUS = int;

enum : int
{
    WriteCacheTypeUnknown      = 0x00000000,
    WriteCacheTypeNone         = 0x00000001,
    WriteCacheTypeWriteBack    = 0x00000002,
    WriteCacheTypeWriteThrough = 0x00000003,
}
alias WRITE_CACHE_TYPE = int;

enum : int
{
    WriteCacheEnableUnknown = 0x00000000,
    WriteCacheDisabled      = 0x00000001,
    WriteCacheEnabled       = 0x00000002,
}
alias WRITE_CACHE_ENABLE = int;

enum : int
{
    WriteCacheChangeUnknown = 0x00000000,
    WriteCacheNotChangeable = 0x00000001,
    WriteCacheChangeable    = 0x00000002,
}
alias WRITE_CACHE_CHANGE = int;

enum : int
{
    WriteThroughUnknown      = 0x00000000,
    WriteThroughNotSupported = 0x00000001,
    WriteThroughSupported    = 0x00000002,
}
alias WRITE_THROUGH = int;

enum : int
{
    StorageDevicePowerCapUnitsPercent    = 0x00000000,
    StorageDevicePowerCapUnitsMilliwatts = 0x00000001,
}
alias STORAGE_DEVICE_POWER_CAP_UNITS = int;

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
alias MEDIA_TYPE = int;

enum : int
{
    PARTITION_STYLE_MBR = 0x00000000,
    PARTITION_STYLE_GPT = 0x00000001,
    PARTITION_STYLE_RAW = 0x00000002,
}
alias PARTITION_STYLE = int;

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
}
alias CSV_CONTROL_OP = int;

enum : int
{
    FileStorageTierMediaTypeUnspecified = 0x00000000,
    FileStorageTierMediaTypeDisk        = 0x00000001,
    FileStorageTierMediaTypeSsd         = 0x00000002,
    FileStorageTierMediaTypeScm         = 0x00000004,
    FileStorageTierMediaTypeMax         = 0x00000005,
}
alias FILE_STORAGE_TIER_MEDIA_TYPE = int;

enum : int
{
    FindStreamInfoStandard     = 0x00000000,
    FindStreamInfoMaxInfoLevel = 0x00000001,
}
alias STREAM_INFO_LEVELS = int;

enum NtmsObjectsTypes : int
{
    NTMS_UNKNOWN                = 0x00000000,
    NTMS_OBJECT                 = 0x00000001,
    NTMS_CHANGER                = 0x00000002,
    NTMS_CHANGER_TYPE           = 0x00000003,
    NTMS_COMPUTER               = 0x00000004,
    NTMS_DRIVE                  = 0x00000005,
    NTMS_DRIVE_TYPE             = 0x00000006,
    NTMS_IEDOOR                 = 0x00000007,
    NTMS_IEPORT                 = 0x00000008,
    NTMS_LIBRARY                = 0x00000009,
    NTMS_LIBREQUEST             = 0x0000000a,
    NTMS_LOGICAL_MEDIA          = 0x0000000b,
    NTMS_MEDIA_POOL             = 0x0000000c,
    NTMS_MEDIA_TYPE             = 0x0000000d,
    NTMS_PARTITION              = 0x0000000e,
    NTMS_PHYSICAL_MEDIA         = 0x0000000f,
    NTMS_STORAGESLOT            = 0x00000010,
    NTMS_OPREQUEST              = 0x00000011,
    NTMS_UI_DESTINATION         = 0x00000012,
    NTMS_NUMBER_OF_OBJECT_TYPES = 0x00000013,
}

enum NtmsAsyncStatus : int
{
    NTMS_ASYNCSTATE_QUEUED        = 0x00000000,
    NTMS_ASYNCSTATE_WAIT_RESOURCE = 0x00000001,
    NTMS_ASYNCSTATE_WAIT_OPERATOR = 0x00000002,
    NTMS_ASYNCSTATE_INPROCESS     = 0x00000003,
    NTMS_ASYNCSTATE_COMPLETE      = 0x00000004,
}

enum NtmsAsyncOperations : int
{
    NTMS_ASYNCOP_MOUNT = 0x00000001,
}

enum NtmsSessionOptions : int
{
    NTMS_SESSION_QUERYEXPEDITE = 0x00000001,
}

enum NtmsMountOptions : int
{
    NTMS_MOUNT_READ                 = 0x00000001,
    NTMS_MOUNT_WRITE                = 0x00000002,
    NTMS_MOUNT_ERROR_NOT_AVAILABLE  = 0x00000004,
    NTMS_MOUNT_ERROR_IF_UNAVAILABLE = 0x00000004,
    NTMS_MOUNT_ERROR_OFFLINE        = 0x00000008,
    NTMS_MOUNT_ERROR_IF_OFFLINE     = 0x00000008,
    NTMS_MOUNT_SPECIFIC_DRIVE       = 0x00000010,
    NTMS_MOUNT_NOWAIT               = 0x00000020,
}

enum NtmsDismountOptions : int
{
    NTMS_DISMOUNT_DEFERRED  = 0x00000001,
    NTMS_DISMOUNT_IMMEDIATE = 0x00000002,
}

enum NtmsMountPriority : int
{
    NTMS_PRIORITY_DEFAULT = 0x00000000,
    NTMS_PRIORITY_HIGHEST = 0x0000000f,
    NTMS_PRIORITY_HIGH    = 0x00000007,
    NTMS_PRIORITY_NORMAL  = 0x00000000,
    NTMS_PRIORITY_LOW     = 0xfffffff9,
    NTMS_PRIORITY_LOWEST  = 0xfffffff1,
}

enum NtmsAllocateOptions : int
{
    NTMS_ALLOCATE_NEW                  = 0x00000001,
    NTMS_ALLOCATE_NEXT                 = 0x00000002,
    NTMS_ALLOCATE_ERROR_IF_UNAVAILABLE = 0x00000004,
}

enum NtmsCreateOptions : int
{
    NTMS_OPEN_EXISTING = 0x00000001,
    NTMS_CREATE_NEW    = 0x00000002,
    NTMS_OPEN_ALWAYS   = 0x00000003,
}

enum NtmsDriveState : int
{
    NTMS_DRIVESTATE_DISMOUNTED    = 0x00000000,
    NTMS_DRIVESTATE_MOUNTED       = 0x00000001,
    NTMS_DRIVESTATE_LOADED        = 0x00000002,
    NTMS_DRIVESTATE_UNLOADED      = 0x00000005,
    NTMS_DRIVESTATE_BEING_CLEANED = 0x00000006,
    NTMS_DRIVESTATE_DISMOUNTABLE  = 0x00000007,
}

enum NtmsLibraryType : int
{
    NTMS_LIBRARYTYPE_UNKNOWN    = 0x00000000,
    NTMS_LIBRARYTYPE_OFFLINE    = 0x00000001,
    NTMS_LIBRARYTYPE_ONLINE     = 0x00000002,
    NTMS_LIBRARYTYPE_STANDALONE = 0x00000003,
}

enum NtmsLibraryFlags : int
{
    NTMS_LIBRARYFLAG_FIXEDOFFLINE               = 0x00000001,
    NTMS_LIBRARYFLAG_CLEANERPRESENT             = 0x00000002,
    NTMS_LIBRARYFLAG_AUTODETECTCHANGE           = 0x00000004,
    NTMS_LIBRARYFLAG_IGNORECLEANERUSESREMAINING = 0x00000008,
    NTMS_LIBRARYFLAG_RECOGNIZECLEANERBARCODE    = 0x00000010,
}

enum NtmsInventoryMethod : int
{
    NTMS_INVENTORY_NONE    = 0x00000000,
    NTMS_INVENTORY_FAST    = 0x00000001,
    NTMS_INVENTORY_OMID    = 0x00000002,
    NTMS_INVENTORY_DEFAULT = 0x00000003,
    NTMS_INVENTORY_SLOT    = 0x00000004,
    NTMS_INVENTORY_STOP    = 0x00000005,
    NTMS_INVENTORY_MAX     = 0x00000006,
}

enum NtmsSlotState : int
{
    NTMS_SLOTSTATE_UNKNOWN        = 0x00000000,
    NTMS_SLOTSTATE_FULL           = 0x00000001,
    NTMS_SLOTSTATE_EMPTY          = 0x00000002,
    NTMS_SLOTSTATE_NOTPRESENT     = 0x00000003,
    NTMS_SLOTSTATE_NEEDSINVENTORY = 0x00000004,
}

enum NtmsDoorState : int
{
    NTMS_DOORSTATE_UNKNOWN = 0x00000000,
    NTMS_DOORSTATE_CLOSED  = 0x00000001,
    NTMS_DOORSTATE_OPEN    = 0x00000002,
}

enum NtmsPortPosition : int
{
    NTMS_PORTPOSITION_UNKNOWN   = 0x00000000,
    NTMS_PORTPOSITION_EXTENDED  = 0x00000001,
    NTMS_PORTPOSITION_RETRACTED = 0x00000002,
}

enum NtmsPortContent : int
{
    NTMS_PORTCONTENT_UNKNOWN = 0x00000000,
    NTMS_PORTCONTENT_FULL    = 0x00000001,
    NTMS_PORTCONTENT_EMPTY   = 0x00000002,
}

enum NtmsBarCodeState : int
{
    NTMS_BARCODESTATE_OK         = 0x00000001,
    NTMS_BARCODESTATE_UNREADABLE = 0x00000002,
}

enum NtmsMediaState : int
{
    NTMS_MEDIASTATE_IDLE     = 0x00000000,
    NTMS_MEDIASTATE_INUSE    = 0x00000001,
    NTMS_MEDIASTATE_MOUNTED  = 0x00000002,
    NTMS_MEDIASTATE_LOADED   = 0x00000003,
    NTMS_MEDIASTATE_UNLOADED = 0x00000004,
    NTMS_MEDIASTATE_OPERROR  = 0x00000005,
    NTMS_MEDIASTATE_OPREQ    = 0x00000006,
}

enum NtmsPartitionState : int
{
    NTMS_PARTSTATE_UNKNOWN        = 0x00000000,
    NTMS_PARTSTATE_UNPREPARED     = 0x00000001,
    NTMS_PARTSTATE_INCOMPATIBLE   = 0x00000002,
    NTMS_PARTSTATE_DECOMMISSIONED = 0x00000003,
    NTMS_PARTSTATE_AVAILABLE      = 0x00000004,
    NTMS_PARTSTATE_ALLOCATED      = 0x00000005,
    NTMS_PARTSTATE_COMPLETE       = 0x00000006,
    NTMS_PARTSTATE_FOREIGN        = 0x00000007,
    NTMS_PARTSTATE_IMPORT         = 0x00000008,
    NTMS_PARTSTATE_RESERVED       = 0x00000009,
}

enum NtmsPoolType : int
{
    NTMS_POOLTYPE_UNKNOWN     = 0x00000000,
    NTMS_POOLTYPE_SCRATCH     = 0x00000001,
    NTMS_POOLTYPE_FOREIGN     = 0x00000002,
    NTMS_POOLTYPE_IMPORT      = 0x00000003,
    NTMS_POOLTYPE_APPLICATION = 0x000003e8,
}

enum NtmsAllocationPolicy : int
{
    NTMS_ALLOCATE_FROMSCRATCH = 0x00000001,
}

enum NtmsDeallocationPolicy : int
{
    NTMS_DEALLOCATE_TOSCRATCH = 0x00000001,
}

enum NtmsReadWriteCharacteristics : int
{
    NTMS_MEDIARW_UNKNOWN    = 0x00000000,
    NTMS_MEDIARW_REWRITABLE = 0x00000001,
    NTMS_MEDIARW_WRITEONCE  = 0x00000002,
    NTMS_MEDIARW_READONLY   = 0x00000003,
}

enum NtmsLmOperation : int
{
    NTMS_LM_REMOVE         = 0x00000000,
    NTMS_LM_DISABLECHANGER = 0x00000001,
    NTMS_LM_DISABLELIBRARY = 0x00000001,
    NTMS_LM_ENABLECHANGER  = 0x00000002,
    NTMS_LM_ENABLELIBRARY  = 0x00000002,
    NTMS_LM_DISABLEDRIVE   = 0x00000003,
    NTMS_LM_ENABLEDRIVE    = 0x00000004,
    NTMS_LM_DISABLEMEDIA   = 0x00000005,
    NTMS_LM_ENABLEMEDIA    = 0x00000006,
    NTMS_LM_UPDATEOMID     = 0x00000007,
    NTMS_LM_INVENTORY      = 0x00000008,
    NTMS_LM_DOORACCESS     = 0x00000009,
    NTMS_LM_EJECT          = 0x0000000a,
    NTMS_LM_EJECTCLEANER   = 0x0000000b,
    NTMS_LM_INJECT         = 0x0000000c,
    NTMS_LM_INJECTCLEANER  = 0x0000000d,
    NTMS_LM_PROCESSOMID    = 0x0000000e,
    NTMS_LM_CLEANDRIVE     = 0x0000000f,
    NTMS_LM_DISMOUNT       = 0x00000010,
    NTMS_LM_MOUNT          = 0x00000011,
    NTMS_LM_WRITESCRATCH   = 0x00000012,
    NTMS_LM_CLASSIFY       = 0x00000013,
    NTMS_LM_RESERVECLEANER = 0x00000014,
    NTMS_LM_RELEASECLEANER = 0x00000015,
    NTMS_LM_MAXWORKITEM    = 0x00000016,
}

enum NtmsLmState : int
{
    NTMS_LM_QUEUED    = 0x00000000,
    NTMS_LM_INPROCESS = 0x00000001,
    NTMS_LM_PASSED    = 0x00000002,
    NTMS_LM_FAILED    = 0x00000003,
    NTMS_LM_INVALID   = 0x00000004,
    NTMS_LM_WAITING   = 0x00000005,
    NTMS_LM_DEFERRED  = 0x00000006,
    NTMS_LM_DEFFERED  = 0x00000006,
    NTMS_LM_CANCELLED = 0x00000007,
    NTMS_LM_STOPPED   = 0x00000008,
}

enum NtmsOpreqCommand : int
{
    NTMS_OPREQ_UNKNOWN       = 0x00000000,
    NTMS_OPREQ_NEWMEDIA      = 0x00000001,
    NTMS_OPREQ_CLEANER       = 0x00000002,
    NTMS_OPREQ_DEVICESERVICE = 0x00000003,
    NTMS_OPREQ_MOVEMEDIA     = 0x00000004,
    NTMS_OPREQ_MESSAGE       = 0x00000005,
}

enum NtmsOpreqState : int
{
    NTMS_OPSTATE_UNKNOWN    = 0x00000000,
    NTMS_OPSTATE_SUBMITTED  = 0x00000001,
    NTMS_OPSTATE_ACTIVE     = 0x00000002,
    NTMS_OPSTATE_INPROGRESS = 0x00000003,
    NTMS_OPSTATE_REFUSED    = 0x00000004,
    NTMS_OPSTATE_COMPLETE   = 0x00000005,
}

enum NtmsLibRequestFlags : int
{
    NTMS_LIBREQFLAGS_NOAUTOPURGE   = 0x00000001,
    NTMS_LIBREQFLAGS_NOFAILEDPURGE = 0x00000002,
}

enum NtmsOpRequestFlags : int
{
    NTMS_OPREQFLAGS_NOAUTOPURGE   = 0x00000001,
    NTMS_OPREQFLAGS_NOFAILEDPURGE = 0x00000002,
    NTMS_OPREQFLAGS_NOALERTS      = 0x00000010,
    NTMS_OPREQFLAGS_NOTRAYICON    = 0x00000020,
}

enum NtmsMediaPoolPolicy : int
{
    NTMS_POOLPOLICY_PURGEOFFLINESCRATCH = 0x00000001,
    NTMS_POOLPOLICY_KEEPOFFLINEIMPORT   = 0x00000002,
}

enum NtmsOperationalState : int
{
    NTMS_READY         = 0x00000000,
    NTMS_INITIALIZING  = 0x0000000a,
    NTMS_NEEDS_SERVICE = 0x00000014,
    NTMS_NOT_PRESENT   = 0x00000015,
}

enum NtmsCreateNtmsMediaOptions : int
{
    NTMS_ERROR_ON_DUPLICATE = 0x00000001,
}

enum NtmsEnumerateOption : int
{
    NTMS_ENUM_DEFAULT  = 0x00000000,
    NTMS_ENUM_ROOTPOOL = 0x00000001,
}

enum NtmsEjectOperation : int
{
    NTMS_EJECT_START     = 0x00000000,
    NTMS_EJECT_STOP      = 0x00000001,
    NTMS_EJECT_QUEUE     = 0x00000002,
    NTMS_EJECT_FORCE     = 0x00000003,
    NTMS_EJECT_IMMEDIATE = 0x00000004,
    NTMS_EJECT_ASK_USER  = 0x00000005,
}

enum NtmsInjectOperation : int
{
    NTMS_INJECT_START     = 0x00000000,
    NTMS_INJECT_STOP      = 0x00000001,
    NTMS_INJECT_RETRACT   = 0x00000002,
    NTMS_INJECT_STARTMANY = 0x00000003,
}

enum NtmsDriveType : int
{
    NTMS_UNKNOWN_DRIVE = 0x00000000,
}

enum NtmsAccessMask : int
{
    NTMS_USE_ACCESS     = 0x00000001,
    NTMS_MODIFY_ACCESS  = 0x00000002,
    NTMS_CONTROL_ACCESS = 0x00000004,
}

enum NtmsUITypes : int
{
    NTMS_UITYPE_INVALID = 0x00000000,
    NTMS_UITYPE_INFO    = 0x00000001,
    NTMS_UITYPE_REQ     = 0x00000002,
    NTMS_UITYPE_ERR     = 0x00000003,
    NTMS_UITYPE_MAX     = 0x00000004,
}

enum NtmsUIOperations : int
{
    NTMS_UIDEST_ADD       = 0x00000001,
    NTMS_UIDEST_DELETE    = 0x00000002,
    NTMS_UIDEST_DELETEALL = 0x00000003,
    NTMS_UIOPERATION_MAX  = 0x00000004,
}

enum NtmsNotificationOperations : int
{
    NTMS_OBJ_UPDATE     = 0x00000001,
    NTMS_OBJ_INSERT     = 0x00000002,
    NTMS_OBJ_DELETE     = 0x00000003,
    NTMS_EVENT_SIGNAL   = 0x00000004,
    NTMS_EVENT_COMPLETE = 0x00000005,
}

enum : int
{
    ClsContextNone     = 0x00000000,
    ClsContextUndoNext = 0x00000001,
    ClsContextPrevious = 0x00000002,
    ClsContextForward  = 0x00000003,
}
alias CLS_CONTEXT_MODE = int;

enum : int
{
    ClfsContextNone     = 0x00000000,
    ClfsContextUndoNext = 0x00000001,
    ClfsContextPrevious = 0x00000002,
    ClfsContextForward  = 0x00000003,
}
alias CLFS_CONTEXT_MODE = int;

enum : int
{
    ClfsLogBasicInformation            = 0x00000000,
    ClfsLogBasicInformationPhysical    = 0x00000001,
    ClfsLogPhysicalNameInformation     = 0x00000002,
    ClfsLogStreamIdentifierInformation = 0x00000003,
    ClfsLogSystemMarkingInformation    = 0x00000004,
    ClfsLogPhysicalLsnInformation      = 0x00000005,
}
alias CLS_LOG_INFORMATION_CLASS = int;

enum : int
{
    ClsIoStatsDefault = 0x00000000,
    ClsIoStatsMax     = 0x0000ffff,
}
alias CLS_IOSTATS_CLASS = int;

enum : int
{
    ClfsIoStatsDefault = 0x00000000,
    ClfsIoStatsMax     = 0x0000ffff,
}
alias CLFS_IOSTATS_CLASS = int;

enum : int
{
    ClfsLogArchiveEnabled  = 0x00000001,
    ClfsLogArchiveDisabled = 0x00000002,
}
alias CLFS_LOG_ARCHIVE_MODE = int;

enum : int
{
    ClfsMgmtPolicyMaximumSize           = 0x00000000,
    ClfsMgmtPolicyMinimumSize           = 0x00000001,
    ClfsMgmtPolicyNewContainerSize      = 0x00000002,
    ClfsMgmtPolicyGrowthRate            = 0x00000003,
    ClfsMgmtPolicyLogTail               = 0x00000004,
    ClfsMgmtPolicyAutoShrink            = 0x00000005,
    ClfsMgmtPolicyAutoGrow              = 0x00000006,
    ClfsMgmtPolicyNewContainerPrefix    = 0x00000007,
    ClfsMgmtPolicyNewContainerSuffix    = 0x00000008,
    ClfsMgmtPolicyNewContainerExtension = 0x00000009,
    ClfsMgmtPolicyInvalid               = 0x0000000a,
}
alias CLFS_MGMT_POLICY_TYPE = int;

enum : int
{
    ClfsMgmtAdvanceTailNotification    = 0x00000000,
    ClfsMgmtLogFullHandlerNotification = 0x00000001,
    ClfsMgmtLogUnpinnedNotification    = 0x00000002,
    ClfsMgmtLogWriteNotification       = 0x00000003,
}
alias CLFS_MGMT_NOTIFICATION_TYPE = int;

enum : int
{
    QUIC    = 0x00000000,
}
alias SERVER_CERTIFICATE_TYPE = int;

enum : int
{
    COPYFILE2_CALLBACK_NONE            = 0x00000000,
    COPYFILE2_CALLBACK_CHUNK_STARTED   = 0x00000001,
    COPYFILE2_CALLBACK_CHUNK_FINISHED  = 0x00000002,
    COPYFILE2_CALLBACK_STREAM_STARTED  = 0x00000003,
    COPYFILE2_CALLBACK_STREAM_FINISHED = 0x00000004,
    COPYFILE2_CALLBACK_POLL_CONTINUE   = 0x00000005,
    COPYFILE2_CALLBACK_ERROR           = 0x00000006,
    COPYFILE2_CALLBACK_MAX             = 0x00000007,
}
alias COPYFILE2_MESSAGE_TYPE = int;

enum : int
{
    COPYFILE2_PROGRESS_CONTINUE = 0x00000000,
    COPYFILE2_PROGRESS_CANCEL   = 0x00000001,
    COPYFILE2_PROGRESS_STOP     = 0x00000002,
    COPYFILE2_PROGRESS_QUIET    = 0x00000003,
    COPYFILE2_PROGRESS_PAUSE    = 0x00000004,
}
alias COPYFILE2_MESSAGE_ACTION = int;

enum : int
{
    COPYFILE2_PHASE_NONE              = 0x00000000,
    COPYFILE2_PHASE_PREPARE_SOURCE    = 0x00000001,
    COPYFILE2_PHASE_PREPARE_DEST      = 0x00000002,
    COPYFILE2_PHASE_READ_SOURCE       = 0x00000003,
    COPYFILE2_PHASE_WRITE_DESTINATION = 0x00000004,
    COPYFILE2_PHASE_SERVER_COPY       = 0x00000005,
    COPYFILE2_PHASE_NAMEGRAFT_COPY    = 0x00000006,
    COPYFILE2_PHASE_MAX               = 0x00000007,
}
alias COPYFILE2_COPY_PHASE = int;

enum : int
{
    IoPriorityHintVeryLow     = 0x00000000,
    IoPriorityHintLow         = 0x00000001,
    IoPriorityHintNormal      = 0x00000002,
    MaximumIoPriorityHintType = 0x00000003,
}
alias PRIORITY_HINT = int;

enum : int
{
    FileIdType         = 0x00000000,
    ObjectIdType       = 0x00000001,
    ExtendedFileIdType = 0x00000002,
    MaximumFileIdType  = 0x00000003,
}
alias FILE_ID_TYPE = int;

// Constants


enum ubyte ClfsNullRecord = 0x00;
enum ubyte ClfsRestartRecord = 0x02;

enum : uint
{
    ClsContainerInitializing        = 0x00000001,
    ClsContainerInactive            = 0x00000002,
    ClsContainerActive              = 0x00000004,
    ClsContainerActivePendingDelete = 0x00000008,
}

enum uint ClsContainerPendingArchiveAndDelete = 0x00000020;

enum : uint
{
    ClfsContainerInactive                = 0x00000002,
    ClfsContainerActive                  = 0x00000004,
    ClfsContainerActivePendingDelete     = 0x00000008,
    ClfsContainerPendingArchive          = 0x00000010,
    ClfsContainerPendingArchiveAndDelete = 0x00000020,
}

enum : ubyte
{
    CLFS_SCAN_INIT        = 0x01,
    CLFS_SCAN_FORWARD     = 0x02,
    CLFS_SCAN_BACKWARD    = 0x04,
    CLFS_SCAN_CLOSE       = 0x08,
    CLFS_SCAN_INITIALIZED = 0x10,
    CLFS_SCAN_BUFFERED    = 0x20,
}

// Callbacks

alias LPOVERLAPPED_COMPLETION_ROUTINE = void function(uint dwErrorCode, uint dwNumberOfBytesTransfered, 
                                                      OVERLAPPED* lpOverlapped);
alias MAXMEDIALABEL = uint function(uint* pMaxSize);
alias CLAIMMEDIALABEL = uint function(const(ubyte)* pBuffer, const(uint) nBufferSize, MediaLabelInfo* pLabelInfo);
alias CLAIMMEDIALABELEX = uint function(const(ubyte)* pBuffer, const(uint) nBufferSize, MediaLabelInfo* pLabelInfo, 
                                        GUID* LabelGuid);
alias CLFS_BLOCK_ALLOCATION = void* function(uint cbBufferLength, void* pvUserContext);
alias CLFS_BLOCK_DEALLOCATION = void function(void* pvBuffer, void* pvUserContext);
alias PCLFS_COMPLETION_ROUTINE = void function(void* pvOverlapped, uint ulReserved);
alias PLOG_TAIL_ADVANCE_CALLBACK = void function(HANDLE hLogFile, CLS_LSN lsnTarget, void* pvClientContext);
alias PLOG_FULL_HANDLER_CALLBACK = void function(HANDLE hLogFile, uint dwError, BOOL fLogIsPinned, 
                                                 void* pvClientContext);
alias PLOG_UNPINNED_CALLBACK = void function(HANDLE hLogFile, void* pvClientContext);
alias WofEnumEntryProc = BOOL function(const(void)* EntryInfo, void* UserData);
alias WofEnumFilesProc = BOOL function(const(wchar)* FilePath, void* ExternalFileInfo, void* UserData);
alias PFE_EXPORT_FUNC = uint function(char* pbData, void* pvCallbackContext, uint ulLength);
alias PFE_IMPORT_FUNC = uint function(char* pbData, void* pvCallbackContext, uint* ulLength);
alias LPPROGRESS_ROUTINE = uint function(LARGE_INTEGER TotalFileSize, LARGE_INTEGER TotalBytesTransferred, 
                                         LARGE_INTEGER StreamSize, LARGE_INTEGER StreamBytesTransferred, 
                                         uint dwStreamNumber, uint dwCallbackReason, HANDLE hSourceFile, 
                                         HANDLE hDestinationFile, void* lpData);
alias PCOPYFILE2_PROGRESS_ROUTINE = COPYFILE2_MESSAGE_ACTION function(const(COPYFILE2_MESSAGE)* pMessage, 
                                                                      void* pvCallbackContext);

// Structs


alias FindChangeNotifcationHandle = ptrdiff_t;

alias FindFileHandle = ptrdiff_t;

alias FindFileNameHandle = ptrdiff_t;

alias FindStreamHandle = ptrdiff_t;

alias FindVolumeHandle = ptrdiff_t;

alias FindVolumeMointPointHandle = ptrdiff_t;

struct FILE_ID_128
{
    ubyte[16] Identifier;
}

struct FILE_NOTIFY_INFORMATION
{
    uint      NextEntryOffset;
    uint      Action;
    uint      FileNameLength;
    ushort[1] FileName;
}

struct FILE_NOTIFY_EXTENDED_INFORMATION
{
    uint          NextEntryOffset;
    uint          Action;
    LARGE_INTEGER CreationTime;
    LARGE_INTEGER LastModificationTime;
    LARGE_INTEGER LastChangeTime;
    LARGE_INTEGER LastAccessTime;
    LARGE_INTEGER AllocatedLength;
    LARGE_INTEGER FileSize;
    uint          FileAttributes;
    uint          ReparsePointTag;
    LARGE_INTEGER FileId;
    LARGE_INTEGER ParentFileId;
    uint          FileNameLength;
    ushort[1]     FileName;
}

struct REPARSE_GUID_DATA_BUFFER
{
    uint   ReparseTag;
    ushort ReparseDataLength;
    ushort Reserved;
    GUID   ReparseGuid;
    struct GenericReparseBuffer
    {
        ubyte[1] DataBuffer;
    }
}

struct OVERLAPPED_ENTRY
{
    size_t      lpCompletionKey;
    OVERLAPPED* lpOverlapped;
    size_t      Internal;
    uint        dwNumberOfBytesTransferred;
}

struct WIN32_FIND_DATAA
{
    uint      dwFileAttributes;
    FILETIME  ftCreationTime;
    FILETIME  ftLastAccessTime;
    FILETIME  ftLastWriteTime;
    uint      nFileSizeHigh;
    uint      nFileSizeLow;
    uint      dwReserved0;
    uint      dwReserved1;
    byte[260] cFileName;
    byte[14]  cAlternateFileName;
}

struct WIN32_FIND_DATAW
{
    uint        dwFileAttributes;
    FILETIME    ftCreationTime;
    FILETIME    ftLastAccessTime;
    FILETIME    ftLastWriteTime;
    uint        nFileSizeHigh;
    uint        nFileSizeLow;
    uint        dwReserved0;
    uint        dwReserved1;
    ushort[260] cFileName;
    ushort[14]  cAlternateFileName;
}

struct STORAGE_PROPERTY_QUERY
{
    STORAGE_PROPERTY_ID PropertyId;
    STORAGE_QUERY_TYPE  QueryType;
    ubyte[1]            AdditionalParameters;
}

struct STORAGE_DESCRIPTOR_HEADER
{
    uint Version;
    uint Size;
}

struct STORAGE_DEVICE_DESCRIPTOR
{
    uint             Version;
    uint             Size;
    ubyte            DeviceType;
    ubyte            DeviceTypeModifier;
    ubyte            RemovableMedia;
    ubyte            CommandQueueing;
    uint             VendorIdOffset;
    uint             ProductIdOffset;
    uint             ProductRevisionOffset;
    uint             SerialNumberOffset;
    STORAGE_BUS_TYPE BusType;
    uint             RawPropertiesLength;
    ubyte[1]         RawDeviceProperties;
}

struct STORAGE_ADAPTER_DESCRIPTOR
{
    uint   Version;
    uint   Size;
    uint   MaximumTransferLength;
    uint   MaximumPhysicalPages;
    uint   AlignmentMask;
    ubyte  AdapterUsesPio;
    ubyte  AdapterScansDown;
    ubyte  CommandQueueing;
    ubyte  AcceleratedTransfer;
    ubyte  BusType;
    ushort BusMajorVersion;
    ushort BusMinorVersion;
    ubyte  SrbType;
    ubyte  AddressType;
}

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

struct STORAGE_MEDIUM_PRODUCT_TYPE_DESCRIPTOR
{
    uint Version;
    uint Size;
    uint MediumProductType;
}

struct STORAGE_MINIPORT_DESCRIPTOR
{
    uint     Version;
    uint     Size;
    STORAGE_PORT_CODE_SET Portdriver;
    ubyte    LUNResetSupported;
    ubyte    TargetResetSupported;
    ushort   IoTimeoutValue;
    ubyte    ExtraIoInfoSupported;
    ubyte[3] Reserved0;
    uint     Reserved1;
}

struct STORAGE_DEVICE_ID_DESCRIPTOR
{
    uint     Version;
    uint     Size;
    uint     NumberOfIdentifiers;
    ubyte[1] Identifiers;
}

struct DEVICE_SEEK_PENALTY_DESCRIPTOR
{
    uint  Version;
    uint  Size;
    ubyte IncursSeekPenalty;
}

struct DEVICE_WRITE_AGGREGATION_DESCRIPTOR
{
    uint  Version;
    uint  Size;
    ubyte BenefitsFromWriteAggregation;
}

struct DEVICE_TRIM_DESCRIPTOR
{
    uint  Version;
    uint  Size;
    ubyte TrimEnabled;
}

struct DEVICE_LB_PROVISIONING_DESCRIPTOR
{
    uint     Version;
    uint     Size;
    ubyte    _bitfield41;
    ubyte[7] Reserved1;
    ulong    OptimalUnmapGranularity;
    ulong    UnmapGranularityAlignment;
    uint     MaxUnmapLbaCount;
    uint     MaxUnmapBlockDescriptorCount;
}

struct DEVICE_POWER_DESCRIPTOR
{
    uint     Version;
    uint     Size;
    ubyte    DeviceAttentionSupported;
    ubyte    AsynchronousNotificationSupported;
    ubyte    IdlePowerManagementEnabled;
    ubyte    D3ColdEnabled;
    ubyte    D3ColdSupported;
    ubyte    NoVerifyDuringIdlePower;
    ubyte[2] Reserved;
    uint     IdleTimeoutInMS;
}

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
    uint Reserved;
}

struct STORAGE_PROTOCOL_DATA_DESCRIPTOR
{
    uint Version;
    uint Size;
    STORAGE_PROTOCOL_SPECIFIC_DATA ProtocolSpecificData;
}

struct STORAGE_TEMPERATURE_INFO
{
    ushort Index;
    short  Temperature;
    short  OverThreshold;
    short  UnderThreshold;
    ubyte  OverThresholdChangable;
    ubyte  UnderThresholdChangable;
    ubyte  EventGenerated;
    ubyte  Reserved0;
    uint   Reserved1;
}

struct STORAGE_TEMPERATURE_DATA_DESCRIPTOR
{
    uint     Version;
    uint     Size;
    short    CriticalTemperature;
    short    WarningTemperature;
    ushort   InfoCount;
    ubyte[2] Reserved0;
    uint[2]  Reserved1;
    STORAGE_TEMPERATURE_INFO[1] TemperatureInfo;
}

struct STORAGE_TEMPERATURE_THRESHOLD
{
    uint   Version;
    uint   Size;
    ushort Flags;
    ushort Index;
    short  Threshold;
    ubyte  OverThreshold;
    ubyte  Reserved;
}

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
    ubyte                ExpanderConnected;
    ubyte[3]             Reserved0;
    uint[3]              Reserved1;
}

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

struct STORAGE_PHYSICAL_TOPOLOGY_DESCRIPTOR
{
    uint Version;
    uint Size;
    uint NodeCount;
    uint Reserved;
    STORAGE_PHYSICAL_NODE_DATA[1] Node;
}

struct STORAGE_DEVICE_IO_CAPABILITY_DESCRIPTOR
{
    uint Version;
    uint Size;
    uint LunMaxIoCount;
    uint AdapterMaxIoCount;
}

struct STORAGE_DEVICE_ATTRIBUTES_DESCRIPTOR
{
    uint  Version;
    uint  Size;
    ulong Attributes;
}

struct STORAGE_ADAPTER_SERIAL_NUMBER
{
    uint        Version;
    uint        Size;
    ushort[128] SerialNumber;
}

struct STORAGE_WRITE_CACHE_PROPERTY
{
    uint               Version;
    uint               Size;
    WRITE_CACHE_TYPE   WriteCacheType;
    WRITE_CACHE_ENABLE WriteCacheEnabled;
    WRITE_CACHE_CHANGE WriteCacheChangeable;
    WRITE_THROUGH      WriteThroughSupported;
    ubyte              FlushCacheSupported;
    ubyte              UserDefinedPowerProtection;
    ubyte              NVCacheEnabled;
}

struct STORAGE_DEVICE_POWER_CAP
{
    uint  Version;
    uint  Size;
    STORAGE_DEVICE_POWER_CAP_UNITS Units;
    ulong MaxPower;
}

struct STORAGE_HW_FIRMWARE_DOWNLOAD
{
    uint     Version;
    uint     Size;
    uint     Flags;
    ubyte    Slot;
    ubyte[3] Reserved;
    ulong    Offset;
    ulong    BufferSize;
    ubyte[1] ImageBuffer;
}

struct STORAGE_HW_FIRMWARE_ACTIVATE
{
    uint     Version;
    uint     Size;
    uint     Flags;
    ubyte    Slot;
    ubyte[3] Reserved0;
}

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
    uint[3]  Reserved1;
    ubyte[1] Command;
}

struct FORMAT_PARAMETERS
{
    MEDIA_TYPE MediaType;
    uint       StartCylinderNumber;
    uint       EndCylinderNumber;
    uint       StartHeadNumber;
    uint       EndHeadNumber;
}

struct FORMAT_EX_PARAMETERS
{
    MEDIA_TYPE MediaType;
    uint       StartCylinderNumber;
    uint       EndCylinderNumber;
    uint       StartHeadNumber;
    uint       EndHeadNumber;
    ushort     FormatGapLength;
    ushort     SectorsPerTrack;
    ushort[1]  SectorNumber;
}

struct DISK_GEOMETRY
{
    LARGE_INTEGER Cylinders;
    MEDIA_TYPE    MediaType;
    uint          TracksPerCylinder;
    uint          SectorsPerTrack;
    uint          BytesPerSector;
}

struct PARTITION_INFORMATION
{
    LARGE_INTEGER StartingOffset;
    LARGE_INTEGER PartitionLength;
    uint          HiddenSectors;
    uint          PartitionNumber;
    ubyte         PartitionType;
    ubyte         BootIndicator;
    ubyte         RecognizedPartition;
    ubyte         RewritePartition;
}

struct SET_PARTITION_INFORMATION
{
    ubyte PartitionType;
}

struct DRIVE_LAYOUT_INFORMATION
{
    uint PartitionCount;
    uint Signature;
    PARTITION_INFORMATION[1] PartitionEntry;
}

struct VERIFY_INFORMATION
{
    LARGE_INTEGER StartingOffset;
    uint          Length;
}

struct REASSIGN_BLOCKS
{
    ushort  Reserved;
    ushort  Count;
    uint[1] BlockNumber;
}

struct REASSIGN_BLOCKS_EX
{
align (1):
    ushort           Reserved;
    ushort           Count;
    LARGE_INTEGER[1] BlockNumber;
}

struct PARTITION_INFORMATION_GPT
{
    GUID       PartitionType;
    GUID       PartitionId;
    ulong      Attributes;
    ushort[36] Name;
}

struct PARTITION_INFORMATION_MBR
{
    ubyte PartitionType;
    ubyte BootIndicator;
    ubyte RecognizedPartition;
    uint  HiddenSectors;
    GUID  PartitionId;
}

struct CREATE_DISK_GPT
{
    GUID DiskId;
    uint MaxPartitionCount;
}

struct CREATE_DISK_MBR
{
    uint Signature;
}

struct CREATE_DISK
{
    PARTITION_STYLE PartitionStyle;
    union
    {
        CREATE_DISK_MBR Mbr;
        CREATE_DISK_GPT Gpt;
    }
}

struct GET_LENGTH_INFORMATION
{
    LARGE_INTEGER Length;
}

struct PARTITION_INFORMATION_EX
{
    PARTITION_STYLE PartitionStyle;
    LARGE_INTEGER   StartingOffset;
    LARGE_INTEGER   PartitionLength;
    uint            PartitionNumber;
    ubyte           RewritePartition;
    ubyte           IsServicePartition;
    union
    {
        PARTITION_INFORMATION_MBR Mbr;
        PARTITION_INFORMATION_GPT Gpt;
    }
}

struct DRIVE_LAYOUT_INFORMATION_GPT
{
    GUID          DiskId;
    LARGE_INTEGER StartingUsableOffset;
    LARGE_INTEGER UsableLength;
    uint          MaxPartitionCount;
}

struct DRIVE_LAYOUT_INFORMATION_MBR
{
    uint Signature;
    uint CheckSum;
}

struct DRIVE_LAYOUT_INFORMATION_EX
{
    uint PartitionStyle;
    uint PartitionCount;
    union
    {
        DRIVE_LAYOUT_INFORMATION_MBR Mbr;
        DRIVE_LAYOUT_INFORMATION_GPT Gpt;
    }
    PARTITION_INFORMATION_EX[1] PartitionEntry;
}

struct DISK_INT13_INFO
{
    ushort DriveSelect;
    uint   MaxCylinders;
    ushort SectorsPerTrack;
    ushort MaxHeads;
    ushort NumberDrives;
}

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

struct DISK_GEOMETRY_EX
{
    DISK_GEOMETRY Geometry;
    LARGE_INTEGER DiskSize;
    ubyte[1]      Data;
}

struct DISK_CACHE_INFORMATION
{
    ubyte  ParametersSavable;
    ubyte  ReadCacheEnabled;
    ubyte  WriteCacheEnabled;
    DISK_CACHE_RETENTION_PRIORITY ReadRetentionPriority;
    DISK_CACHE_RETENTION_PRIORITY WriteRetentionPriority;
    ushort DisablePrefetchTransferLength;
    ubyte  PrefetchScalar;
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

struct DISK_GROW_PARTITION
{
    uint          PartitionNumber;
    LARGE_INTEGER BytesToGrow;
}

struct DISK_PERFORMANCE
{
    LARGE_INTEGER BytesRead;
    LARGE_INTEGER BytesWritten;
    LARGE_INTEGER ReadTime;
    LARGE_INTEGER WriteTime;
    LARGE_INTEGER IdleTime;
    uint          ReadCount;
    uint          WriteCount;
    uint          QueueDepth;
    uint          SplitCount;
    LARGE_INTEGER QueryTime;
    uint          StorageDeviceNumber;
    ushort[8]     StorageManagerName;
}

struct GET_DISK_ATTRIBUTES
{
    uint  Version;
    uint  Reserved1;
    ulong Attributes;
}

struct SET_DISK_ATTRIBUTES
{
    uint     Version;
    ubyte    Persist;
    ubyte[3] Reserved1;
    ulong    Attributes;
    ulong    AttributesMask;
    uint[4]  Reserved2;
}

struct NTFS_VOLUME_DATA_BUFFER
{
    LARGE_INTEGER VolumeSerialNumber;
    LARGE_INTEGER NumberSectors;
    LARGE_INTEGER TotalClusters;
    LARGE_INTEGER FreeClusters;
    LARGE_INTEGER TotalReserved;
    uint          BytesPerSector;
    uint          BytesPerCluster;
    uint          BytesPerFileRecordSegment;
    uint          ClustersPerFileRecordSegment;
    LARGE_INTEGER MftValidDataLength;
    LARGE_INTEGER MftStartLcn;
    LARGE_INTEGER Mft2StartLcn;
    LARGE_INTEGER MftZoneStart;
    LARGE_INTEGER MftZoneEnd;
}

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

struct STARTING_LCN_INPUT_BUFFER
{
    LARGE_INTEGER StartingLcn;
}

struct VOLUME_BITMAP_BUFFER
{
    LARGE_INTEGER StartingLcn;
    LARGE_INTEGER BitmapSize;
    ubyte[1]      Buffer;
}

struct STARTING_VCN_INPUT_BUFFER
{
    LARGE_INTEGER StartingVcn;
}

struct RETRIEVAL_POINTERS_BUFFER
{
    uint          ExtentCount;
    LARGE_INTEGER StartingVcn;
    struct
    {
        LARGE_INTEGER NextVcn;
        LARGE_INTEGER Lcn;
    }
}

struct NTFS_FILE_RECORD_INPUT_BUFFER
{
    LARGE_INTEGER FileReferenceNumber;
}

struct NTFS_FILE_RECORD_OUTPUT_BUFFER
{
    LARGE_INTEGER FileReferenceNumber;
    uint          FileRecordLength;
    ubyte[1]      FileRecordBuffer;
}

struct MOVE_FILE_DATA
{
    HANDLE        FileHandle;
    LARGE_INTEGER StartingVcn;
    LARGE_INTEGER StartingLcn;
    uint          ClusterCount;
}

struct FIND_BY_SID_DATA
{
    uint Restart;
    SID  Sid;
}

struct FIND_BY_SID_OUTPUT
{
    uint      NextEntryOffset;
    uint      FileIndex;
    uint      FileNameLength;
    ushort[1] FileName;
}

struct MFT_ENUM_DATA_V0
{
    ulong StartFileReferenceNumber;
    long  LowUsn;
    long  HighUsn;
}

struct MFT_ENUM_DATA_V1
{
    ulong  StartFileReferenceNumber;
    long   LowUsn;
    long   HighUsn;
    ushort MinMajorVersion;
    ushort MaxMajorVersion;
}

struct CREATE_USN_JOURNAL_DATA
{
    ulong MaximumSize;
    ulong AllocationDelta;
}

struct READ_FILE_USN_DATA
{
    ushort MinMajorVersion;
    ushort MaxMajorVersion;
}

struct READ_USN_JOURNAL_DATA_V0
{
    long  StartUsn;
    uint  ReasonMask;
    uint  ReturnOnlyOnClose;
    ulong Timeout;
    ulong BytesToWaitFor;
    ulong UsnJournalID;
}

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

struct USN_TRACK_MODIFIED_RANGES
{
    uint  Flags;
    uint  Unused;
    ulong ChunkSize;
    long  FileSizeThreshold;
}

struct USN_RANGE_TRACK_OUTPUT
{
    long Usn;
}

struct USN_RECORD_V2
{
    uint          RecordLength;
    ushort        MajorVersion;
    ushort        MinorVersion;
    ulong         FileReferenceNumber;
    ulong         ParentFileReferenceNumber;
    long          Usn;
    LARGE_INTEGER TimeStamp;
    uint          Reason;
    uint          SourceInfo;
    uint          SecurityId;
    uint          FileAttributes;
    ushort        FileNameLength;
    ushort        FileNameOffset;
    ushort[1]     FileName;
}

struct USN_RECORD_V3
{
    uint          RecordLength;
    ushort        MajorVersion;
    ushort        MinorVersion;
    FILE_ID_128   FileReferenceNumber;
    FILE_ID_128   ParentFileReferenceNumber;
    long          Usn;
    LARGE_INTEGER TimeStamp;
    uint          Reason;
    uint          SourceInfo;
    uint          SecurityId;
    uint          FileAttributes;
    ushort        FileNameLength;
    ushort        FileNameOffset;
    ushort[1]     FileName;
}

struct USN_RECORD_COMMON_HEADER
{
    uint   RecordLength;
    ushort MajorVersion;
    ushort MinorVersion;
}

struct USN_RECORD_EXTENT
{
    long Offset;
    long Length;
}

struct USN_RECORD_V4
{
    USN_RECORD_COMMON_HEADER Header;
    FILE_ID_128          FileReferenceNumber;
    FILE_ID_128          ParentFileReferenceNumber;
    long                 Usn;
    uint                 Reason;
    uint                 SourceInfo;
    uint                 RemainingExtents;
    ushort               NumberOfExtents;
    ushort               ExtentSize;
    USN_RECORD_EXTENT[1] Extents;
}

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

struct DELETE_USN_JOURNAL_DATA
{
    ulong UsnJournalID;
    uint  DeleteFlags;
}

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

struct FILESYSTEM_STATISTICS
{
    ushort FileSystemType;
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

struct FILESYSTEM_STATISTICS_EX
{
    ushort FileSystemType;
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

struct FILE_SET_SPARSE_BUFFER
{
    ubyte SetSparse;
}

struct FILE_ZERO_DATA_INFORMATION
{
    LARGE_INTEGER FileOffset;
    LARGE_INTEGER BeyondFinalZero;
}

struct FILE_ALLOCATED_RANGE_BUFFER
{
    LARGE_INTEGER FileOffset;
    LARGE_INTEGER Length;
}

struct PLEX_READ_DATA_REQUEST
{
    LARGE_INTEGER ByteOffset;
    uint          ByteLength;
    uint          PlexNumber;
}

struct FILE_MAKE_COMPATIBLE_BUFFER
{
    ubyte CloseDisc;
}

struct FILE_SET_DEFECT_MGMT_BUFFER
{
    ubyte Disable;
}

struct FILE_QUERY_SPARING_BUFFER
{
    uint  SparingUnitBytes;
    ubyte SoftwareSparing;
    uint  TotalSpareBlocks;
    uint  FreeSpareBlocks;
}

struct FILE_QUERY_ON_DISK_VOL_INFO_BUFFER
{
    LARGE_INTEGER DirectoryCount;
    LARGE_INTEGER FileCount;
    ushort        FsFormatMajVersion;
    ushort        FsFormatMinVersion;
    ushort[12]    FsFormatName;
    LARGE_INTEGER FormatTime;
    LARGE_INTEGER LastUpdateTime;
    ushort[34]    CopyrightInfo;
    ushort[34]    AbstractInfo;
    ushort[34]    FormattingImplementationInfo;
    ushort[34]    LastModifyingImplementationInfo;
}

struct SHRINK_VOLUME_INFORMATION
{
    SHRINK_VOLUME_REQUEST_TYPES ShrinkRequestType;
    ulong Flags;
    long  NewNumberOfSectors;
}

struct TXFS_MODIFY_RM
{
    uint   Flags;
    uint   LogContainerCountMax;
    uint   LogContainerCountMin;
    uint   LogContainerCount;
    uint   LogGrowthIncrement;
    uint   LogAutoShrinkPercentage;
    ulong  Reserved;
    ushort LoggingMode;
}

struct TXFS_QUERY_RM_INFORMATION
{
    uint          BytesRequired;
    ulong         TailLsn;
    ulong         CurrentLsn;
    ulong         ArchiveTailLsn;
    ulong         LogContainerSize;
    LARGE_INTEGER HighestVirtualClock;
    uint          LogContainerCount;
    uint          LogContainerCountMax;
    uint          LogContainerCountMin;
    uint          LogGrowthIncrement;
    uint          LogAutoShrinkPercentage;
    uint          Flags;
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

struct TXFS_LIST_TRANSACTION_LOCKED_FILES_ENTRY
{
    ulong     Offset;
    uint      NameFlags;
    long      FileId;
    uint      Reserved1;
    uint      Reserved2;
    long      Reserved3;
    ushort[1] FileName;
}

struct TXFS_LIST_TRANSACTION_LOCKED_FILES
{
    GUID  KtmTransaction;
    ulong NumberOfFiles;
    ulong BufferSizeRequired;
    ulong Offset;
}

struct TXFS_LIST_TRANSACTIONS_ENTRY
{
    GUID TransactionId;
    uint TransactionState;
    uint Reserved1;
    uint Reserved2;
    long Reserved3;
}

struct TXFS_LIST_TRANSACTIONS
{
    ulong NumberOfTransactions;
    ulong BufferSizeRequired;
}

struct TXFS_READ_BACKUP_INFORMATION_OUT
{
    union
    {
        uint     BufferLength;
        ubyte[1] Buffer;
    }
}

struct TXFS_WRITE_BACKUP_INFORMATION
{
    ubyte[1] Buffer;
}

struct TXFS_GET_TRANSACTED_VERSION
{
    uint   ThisBaseVersion;
    uint   LatestVersion;
    ushort ThisMiniVersion;
    ushort FirstMiniVersion;
    ushort LatestMiniVersion;
}

struct TXFS_SAVEPOINT_INFORMATION
{
    HANDLE KtmTransaction;
    uint   ActionCode;
    uint   SavepointId;
}

struct TXFS_CREATE_MINIVERSION_INFO
{
    ushort StructureVersion;
    ushort StructureLength;
    uint   BaseVersion;
    ushort MiniVersion;
}

struct TXFS_TRANSACTION_ACTIVE_INFO
{
    ubyte TransactionsActiveAtSnapshot;
}

struct BOOT_AREA_INFO
{
    uint BootSectorCount;
    struct
    {
        LARGE_INTEGER Offset;
    }
}

struct RETRIEVAL_POINTER_BASE
{
    LARGE_INTEGER FileAreaOffset;
}

struct FILE_SYSTEM_RECOGNITION_INFORMATION
{
    byte[9] FileSystem;
}

struct REQUEST_OPLOCK_INPUT_BUFFER
{
    ushort StructureVersion;
    ushort StructureLength;
    uint   RequestedOplockLevel;
    uint   Flags;
}

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

struct LOOKUP_STREAM_FROM_CLUSTER_INPUT
{
    uint             Flags;
    uint             NumberOfClusters;
    LARGE_INTEGER[1] Cluster;
}

struct LOOKUP_STREAM_FROM_CLUSTER_OUTPUT
{
    uint Offset;
    uint NumberOfMatches;
    uint BufferSizeRequired;
}

struct LOOKUP_STREAM_FROM_CLUSTER_ENTRY
{
    uint          OffsetToNext;
    uint          Flags;
    LARGE_INTEGER Reserved;
    LARGE_INTEGER Cluster;
    ushort[1]     FileName;
}

struct CSV_NAMESPACE_INFO
{
    uint          Version;
    uint          DeviceNumber;
    LARGE_INTEGER StartingOffset;
    uint          SectorSize;
}

struct CSV_CONTROL_PARAM
{
    CSV_CONTROL_OP Operation;
    long           Unused;
}

struct CSV_QUERY_REDIRECT_STATE
{
    uint  MdsNodeId;
    uint  DsNodeId;
    ubyte FileRedirected;
}

struct CSV_QUERY_FILE_REVISION
{
    long    FileId;
    long[3] FileRevision;
}

struct CSV_QUERY_MDS_PATH
{
    uint      MdsNodeId;
    uint      DsNodeId;
    uint      PathLength;
    ushort[1] Path;
}

struct CSV_QUERY_VETO_FILE_DIRECT_IO_OUTPUT
{
    ulong       VetoedFromAltitudeIntegral;
    ulong       VetoedFromAltitudeDecimal;
    ushort[256] Reason;
}

struct CSV_IS_OWNED_BY_CSVFS
{
    ubyte OwnedByCSVFS;
}

struct FILE_LEVEL_TRIM_RANGE
{
    ulong Offset;
    ulong Length;
}

struct FILE_LEVEL_TRIM
{
    uint Key;
    uint NumRanges;
    FILE_LEVEL_TRIM_RANGE[1] Ranges;
}

struct FILE_LEVEL_TRIM_OUTPUT
{
    uint NumRangesProcessed;
}

struct FSCTL_GET_INTEGRITY_INFORMATION_BUFFER
{
    ushort ChecksumAlgorithm;
    ushort Reserved;
    uint   Flags;
    uint   ChecksumChunkSizeInBytes;
    uint   ClusterSizeInBytes;
}

struct FSCTL_SET_INTEGRITY_INFORMATION_BUFFER
{
    ushort ChecksumAlgorithm;
    ushort Reserved;
    uint   Flags;
}

struct REPAIR_COPIES_INPUT
{
    uint          Size;
    uint          Flags;
    LARGE_INTEGER FileOffset;
    uint          Length;
    uint          SourceCopy;
    uint          NumberOfRepairCopies;
    uint[1]       RepairCopies;
}

struct REPAIR_COPIES_OUTPUT
{
    uint          Size;
    uint          Status;
    LARGE_INTEGER ResumeFileOffset;
}

struct FILE_STORAGE_TIER
{
    GUID        Id;
    ushort[256] Name;
    ushort[256] Description;
    ulong       Flags;
    ulong       ProvisionedCapacity;
    FILE_STORAGE_TIER_MEDIA_TYPE MediaType;
    FILE_STORAGE_TIER_CLASS Class;
}

struct FSCTL_QUERY_STORAGE_CLASSES_OUTPUT
{
    uint                 Version;
    uint                 Size;
    uint                 Flags;
    uint                 TotalNumberOfTiers;
    uint                 NumberOfTiersReturned;
    FILE_STORAGE_TIER[1] Tiers;
}

struct FSCTL_QUERY_REGION_INFO_INPUT
{
    uint    Version;
    uint    Size;
    uint    Flags;
    uint    NumberOfTierIds;
    GUID[1] TierIds;
}

struct FILE_STORAGE_TIER_REGION
{
    GUID  TierId;
    ulong Offset;
    ulong Length;
}

struct FSCTL_QUERY_REGION_INFO_OUTPUT
{
    uint  Version;
    uint  Size;
    uint  Flags;
    uint  Reserved;
    ulong Alignment;
    uint  TotalNumberOfRegions;
    uint  NumberOfRegionsReturned;
    FILE_STORAGE_TIER_REGION[1] Regions;
}

struct DUPLICATE_EXTENTS_DATA
{
    HANDLE        FileHandle;
    LARGE_INTEGER SourceFileOffset;
    LARGE_INTEGER TargetFileOffset;
    LARGE_INTEGER ByteCount;
}

struct DISK_EXTENT
{
    uint          DiskNumber;
    LARGE_INTEGER StartingOffset;
    LARGE_INTEGER ExtentLength;
}

struct VOLUME_DISK_EXTENTS
{
    uint           NumberOfDiskExtents;
    DISK_EXTENT[1] Extents;
}

struct VOLUME_GET_GPT_ATTRIBUTES_INFORMATION
{
    ulong GptAttributes;
}

struct TRANSACTION_NOTIFICATION
{
    void*         TransactionKey;
    uint          TransactionNotification;
    LARGE_INTEGER TmVirtualClock;
    uint          ArgumentLength;
}

struct TRANSACTION_NOTIFICATION_RECOVERY_ARGUMENT
{
    GUID EnlistmentId;
    GUID UOW;
}

struct TRANSACTION_NOTIFICATION_TM_ONLINE_ARGUMENT
{
    GUID TmIdentity;
    uint Flags;
}

struct TRANSACTION_NOTIFICATION_SAVEPOINT_ARGUMENT
{
    uint SavepointId;
}

struct TRANSACTION_NOTIFICATION_PROPAGATE_ARGUMENT
{
    uint PropagationCookie;
    GUID UOW;
    GUID TmIdentity;
    uint BufferLength;
}

struct TRANSACTION_NOTIFICATION_MARSHAL_ARGUMENT
{
    uint MarshalCookie;
    GUID UOW;
}

struct KCRM_MARSHAL_HEADER
{
    uint VersionMajor;
    uint VersionMinor;
    uint NumProtocols;
    uint Unused;
}

struct KCRM_TRANSACTION_BLOB
{
    GUID       UOW;
    GUID       TmIdentity;
    uint       IsolationLevel;
    uint       IsolationFlags;
    uint       Timeout;
    ushort[64] Description;
}

struct KCRM_PROTOCOL_BLOB
{
    GUID ProtocolId;
    uint StaticInfoLength;
    uint TransactionIdInfoLength;
    uint Unused1;
    uint Unused2;
}

struct DISK_SPACE_INFORMATION
{
    ulong ActualTotalAllocationUnits;
    ulong ActualAvailableAllocationUnits;
    ulong ActualPoolUnavailableAllocationUnits;
    ulong CallerTotalAllocationUnits;
    ulong CallerAvailableAllocationUnits;
    ulong CallerPoolUnavailableAllocationUnits;
    ulong UsedAllocationUnits;
    ulong TotalReservedAllocationUnits;
    ulong VolumeStorageReserveAllocationUnits;
    ulong AvailableCommittedAllocationUnits;
    ulong PoolAvailableAllocationUnits;
    uint  SectorsPerAllocationUnit;
    uint  BytesPerSector;
}

struct WIN32_FILE_ATTRIBUTE_DATA
{
    uint     dwFileAttributes;
    FILETIME ftCreationTime;
    FILETIME ftLastAccessTime;
    FILETIME ftLastWriteTime;
    uint     nFileSizeHigh;
    uint     nFileSizeLow;
}

struct BY_HANDLE_FILE_INFORMATION
{
    uint     dwFileAttributes;
    FILETIME ftCreationTime;
    FILETIME ftLastAccessTime;
    FILETIME ftLastWriteTime;
    uint     dwVolumeSerialNumber;
    uint     nFileSizeHigh;
    uint     nFileSizeLow;
    uint     nNumberOfLinks;
    uint     nFileIndexHigh;
    uint     nFileIndexLow;
}

struct CREATEFILE2_EXTENDED_PARAMETERS
{
    uint                 dwSize;
    uint                 dwFileAttributes;
    uint                 dwFileFlags;
    uint                 dwSecurityQosFlags;
    SECURITY_ATTRIBUTES* lpSecurityAttributes;
    HANDLE               hTemplateFile;
}

struct WIN32_FIND_STREAM_DATA
{
    LARGE_INTEGER StreamSize;
    ushort[296]   cStreamName;
}

struct EFS_CERTIFICATE_BLOB
{
    uint   dwCertEncodingType;
    uint   cbData;
    ubyte* pbData;
}

struct EFS_HASH_BLOB
{
    uint   cbData;
    ubyte* pbData;
}

struct EFS_RPC_BLOB
{
    uint   cbData;
    ubyte* pbData;
}

struct EFS_PIN_BLOB
{
    uint   cbPadding;
    uint   cbData;
    ubyte* pbData;
}

struct EFS_KEY_INFO
{
    uint dwVersion;
    uint Entropy;
    uint Algorithm;
    uint KeyLength;
}

struct EFS_COMPATIBILITY_INFO
{
    uint EfsVersion;
}

struct EFS_VERSION_INFO
{
    uint EfsVersion;
    uint SubVersion;
}

struct EFS_DECRYPTION_STATUS_INFO
{
    uint dwDecryptionError;
    uint dwHashOffset;
    uint cbHash;
}

struct EFS_ENCRYPTION_STATUS_INFO
{
    BOOL bHasCurrentKey;
    uint dwEncryptionError;
}

struct ENCRYPTION_CERTIFICATE
{
    uint cbTotalLength;
    SID* pUserSid;
    EFS_CERTIFICATE_BLOB* pCertBlob;
}

struct ENCRYPTION_CERTIFICATE_HASH
{
    uint           cbTotalLength;
    SID*           pUserSid;
    EFS_HASH_BLOB* pHash;
    const(wchar)*  lpDisplayInformation;
}

struct ENCRYPTION_CERTIFICATE_HASH_LIST
{
    uint nCert_Hash;
    ENCRYPTION_CERTIFICATE_HASH** pUsers;
}

struct ENCRYPTION_CERTIFICATE_LIST
{
    uint nUsers;
    ENCRYPTION_CERTIFICATE** pUsers;
}

struct ENCRYPTED_FILE_METADATA_SIGNATURE
{
    uint          dwEfsAccessType;
    ENCRYPTION_CERTIFICATE_HASH_LIST* pCertificatesAdded;
    ENCRYPTION_CERTIFICATE* pEncryptionCertificate;
    EFS_RPC_BLOB* pEfsStreamSignature;
}

struct ENCRYPTION_PROTECTOR
{
    uint          cbTotalLength;
    SID*          pUserSid;
    const(wchar)* lpProtectorDescriptor;
}

struct ENCRYPTION_PROTECTOR_LIST
{
    uint nProtectors;
    ENCRYPTION_PROTECTOR** pProtectors;
}

struct NTMS_ASYNC_IO
{
    GUID   OperationId;
    GUID   EventId;
    uint   dwOperationType;
    uint   dwResult;
    uint   dwAsyncState;
    HANDLE hEvent;
    BOOL   bOnStateChange;
}

struct NTMS_MOUNT_INFORMATION
{
    uint  dwSize;
    void* lpReserved;
}

struct NTMS_ALLOCATION_INFORMATION
{
    uint  dwSize;
    void* lpReserved;
    GUID  AllocatedFrom;
}

struct NTMS_DRIVEINFORMATIONA
{
    uint       Number;
    uint       State;
    GUID       DriveType;
    byte[64]   szDeviceName;
    byte[32]   szSerialNumber;
    byte[32]   szRevision;
    ushort     ScsiPort;
    ushort     ScsiBus;
    ushort     ScsiTarget;
    ushort     ScsiLun;
    uint       dwMountCount;
    SYSTEMTIME LastCleanedTs;
    GUID       SavedPartitionId;
    GUID       Library;
    GUID       Reserved;
    uint       dwDeferDismountDelay;
}

struct NTMS_DRIVEINFORMATIONW
{
    uint       Number;
    uint       State;
    GUID       DriveType;
    ushort[64] szDeviceName;
    ushort[32] szSerialNumber;
    ushort[32] szRevision;
    ushort     ScsiPort;
    ushort     ScsiBus;
    ushort     ScsiTarget;
    ushort     ScsiLun;
    uint       dwMountCount;
    SYSTEMTIME LastCleanedTs;
    GUID       SavedPartitionId;
    GUID       Library;
    GUID       Reserved;
    uint       dwDeferDismountDelay;
}

struct NTMS_LIBRARYINFORMATION
{
    uint LibraryType;
    GUID CleanerSlot;
    GUID CleanerSlotDefault;
    BOOL LibrarySupportsDriveCleaning;
    BOOL BarCodeReaderInstalled;
    uint InventoryMethod;
    uint dwCleanerUsesRemaining;
    uint FirstDriveNumber;
    uint dwNumberOfDrives;
    uint FirstSlotNumber;
    uint dwNumberOfSlots;
    uint FirstDoorNumber;
    uint dwNumberOfDoors;
    uint FirstPortNumber;
    uint dwNumberOfPorts;
    uint FirstChangerNumber;
    uint dwNumberOfChangers;
    uint dwNumberOfMedia;
    uint dwNumberOfMediaTypes;
    uint dwNumberOfLibRequests;
    GUID Reserved;
    BOOL AutoRecovery;
    uint dwFlags;
}

struct NTMS_CHANGERINFORMATIONA
{
    uint     Number;
    GUID     ChangerType;
    byte[32] szSerialNumber;
    byte[32] szRevision;
    byte[64] szDeviceName;
    ushort   ScsiPort;
    ushort   ScsiBus;
    ushort   ScsiTarget;
    ushort   ScsiLun;
    GUID     Library;
}

struct NTMS_CHANGERINFORMATIONW
{
    uint       Number;
    GUID       ChangerType;
    ushort[32] szSerialNumber;
    ushort[32] szRevision;
    ushort[64] szDeviceName;
    ushort     ScsiPort;
    ushort     ScsiBus;
    ushort     ScsiTarget;
    ushort     ScsiLun;
    GUID       Library;
}

struct NTMS_STORAGESLOTINFORMATION
{
    uint Number;
    uint State;
    GUID Library;
}

struct NTMS_IEDOORINFORMATION
{
    uint   Number;
    uint   State;
    ushort MaxOpenSecs;
    GUID   Library;
}

struct NTMS_IEPORTINFORMATION
{
    uint   Number;
    uint   Content;
    uint   Position;
    ushort MaxExtendSecs;
    GUID   Library;
}

struct NTMS_PMIDINFORMATIONA
{
    GUID     CurrentLibrary;
    GUID     MediaPool;
    GUID     Location;
    uint     LocationType;
    GUID     MediaType;
    GUID     HomeSlot;
    byte[64] szBarCode;
    uint     BarCodeState;
    byte[32] szSequenceNumber;
    uint     MediaState;
    uint     dwNumberOfPartitions;
    uint     dwMediaTypeCode;
    uint     dwDensityCode;
    GUID     MountedPartition;
}

struct NTMS_PMIDINFORMATIONW
{
    GUID       CurrentLibrary;
    GUID       MediaPool;
    GUID       Location;
    uint       LocationType;
    GUID       MediaType;
    GUID       HomeSlot;
    ushort[64] szBarCode;
    uint       BarCodeState;
    ushort[32] szSequenceNumber;
    uint       MediaState;
    uint       dwNumberOfPartitions;
    uint       dwMediaTypeCode;
    uint       dwDensityCode;
    GUID       MountedPartition;
}

struct NTMS_LMIDINFORMATION
{
    GUID MediaPool;
    uint dwNumberOfPartitions;
}

struct NTMS_PARTITIONINFORMATIONA
{
    GUID          PhysicalMedia;
    GUID          LogicalMedia;
    uint          State;
    ushort        Side;
    uint          dwOmidLabelIdLength;
    ubyte[255]    OmidLabelId;
    byte[64]      szOmidLabelType;
    byte[256]     szOmidLabelInfo;
    uint          dwMountCount;
    uint          dwAllocateCount;
    LARGE_INTEGER Capacity;
}

struct NTMS_PARTITIONINFORMATIONW
{
    GUID          PhysicalMedia;
    GUID          LogicalMedia;
    uint          State;
    ushort        Side;
    uint          dwOmidLabelIdLength;
    ubyte[255]    OmidLabelId;
    ushort[64]    szOmidLabelType;
    ushort[256]   szOmidLabelInfo;
    uint          dwMountCount;
    uint          dwAllocateCount;
    LARGE_INTEGER Capacity;
}

struct NTMS_MEDIAPOOLINFORMATION
{
    uint PoolType;
    GUID MediaType;
    GUID Parent;
    uint AllocationPolicy;
    uint DeallocationPolicy;
    uint dwMaxAllocates;
    uint dwNumberOfPhysicalMedia;
    uint dwNumberOfLogicalMedia;
    uint dwNumberOfMediaPools;
}

struct NTMS_MEDIATYPEINFORMATION
{
    uint MediaType;
    uint NumberOfSides;
    uint ReadWriteCharacteristics;
    uint DeviceType;
}

struct NTMS_DRIVETYPEINFORMATIONA
{
    byte[128] szVendor;
    byte[128] szProduct;
    uint      NumberOfHeads;
    uint      DeviceType;
}

struct NTMS_DRIVETYPEINFORMATIONW
{
    ushort[128] szVendor;
    ushort[128] szProduct;
    uint        NumberOfHeads;
    uint        DeviceType;
}

struct NTMS_CHANGERTYPEINFORMATIONA
{
    byte[128] szVendor;
    byte[128] szProduct;
    uint      DeviceType;
}

struct NTMS_CHANGERTYPEINFORMATIONW
{
    ushort[128] szVendor;
    ushort[128] szProduct;
    uint        DeviceType;
}

struct NTMS_LIBREQUESTINFORMATIONA
{
    uint       OperationCode;
    uint       OperationOption;
    uint       State;
    GUID       PartitionId;
    GUID       DriveId;
    GUID       PhysMediaId;
    GUID       Library;
    GUID       SlotId;
    SYSTEMTIME TimeQueued;
    SYSTEMTIME TimeCompleted;
    byte[64]   szApplication;
    byte[64]   szUser;
    byte[64]   szComputer;
    uint       dwErrorCode;
    GUID       WorkItemId;
    uint       dwPriority;
}

struct NTMS_LIBREQUESTINFORMATIONW
{
    uint       OperationCode;
    uint       OperationOption;
    uint       State;
    GUID       PartitionId;
    GUID       DriveId;
    GUID       PhysMediaId;
    GUID       Library;
    GUID       SlotId;
    SYSTEMTIME TimeQueued;
    SYSTEMTIME TimeCompleted;
    ushort[64] szApplication;
    ushort[64] szUser;
    ushort[64] szComputer;
    uint       dwErrorCode;
    GUID       WorkItemId;
    uint       dwPriority;
}

struct NTMS_OPREQUESTINFORMATIONA
{
    uint       Request;
    SYSTEMTIME Submitted;
    uint       State;
    byte[256]  szMessage;
    uint       Arg1Type;
    GUID       Arg1;
    uint       Arg2Type;
    GUID       Arg2;
    byte[64]   szApplication;
    byte[64]   szUser;
    byte[64]   szComputer;
}

struct NTMS_OPREQUESTINFORMATIONW
{
    uint        Request;
    SYSTEMTIME  Submitted;
    uint        State;
    ushort[256] szMessage;
    uint        Arg1Type;
    GUID        Arg1;
    uint        Arg2Type;
    GUID        Arg2;
    ushort[64]  szApplication;
    ushort[64]  szUser;
    ushort[64]  szComputer;
}

struct NTMS_COMPUTERINFORMATION
{
    uint dwLibRequestPurgeTime;
    uint dwOpRequestPurgeTime;
    uint dwLibRequestFlags;
    uint dwOpRequestFlags;
    uint dwMediaPoolPolicy;
}

struct NTMS_OBJECTINFORMATIONA
{
    uint       dwSize;
    uint       dwType;
    SYSTEMTIME Created;
    SYSTEMTIME Modified;
    GUID       ObjectGuid;
    BOOL       Enabled;
    uint       dwOperationalState;
    byte[64]   szName;
    byte[127]  szDescription;
    union Info
    {
        NTMS_DRIVEINFORMATIONA Drive;
        NTMS_DRIVETYPEINFORMATIONA DriveType;
        NTMS_LIBRARYINFORMATION Library;
        NTMS_CHANGERINFORMATIONA Changer;
        NTMS_CHANGERTYPEINFORMATIONA ChangerType;
        NTMS_STORAGESLOTINFORMATION StorageSlot;
        NTMS_IEDOORINFORMATION IEDoor;
        NTMS_IEPORTINFORMATION IEPort;
        NTMS_PMIDINFORMATIONA PhysicalMedia;
        NTMS_LMIDINFORMATION LogicalMedia;
        NTMS_PARTITIONINFORMATIONA Partition;
        NTMS_MEDIAPOOLINFORMATION MediaPool;
        NTMS_MEDIATYPEINFORMATION MediaType;
        NTMS_LIBREQUESTINFORMATIONA LibRequest;
        NTMS_OPREQUESTINFORMATIONA OpRequest;
        NTMS_COMPUTERINFORMATION Computer;
    }
}

struct NTMS_OBJECTINFORMATIONW
{
    uint        dwSize;
    uint        dwType;
    SYSTEMTIME  Created;
    SYSTEMTIME  Modified;
    GUID        ObjectGuid;
    BOOL        Enabled;
    uint        dwOperationalState;
    ushort[64]  szName;
    ushort[127] szDescription;
    union Info
    {
        NTMS_DRIVEINFORMATIONW Drive;
        NTMS_DRIVETYPEINFORMATIONW DriveType;
        NTMS_LIBRARYINFORMATION Library;
        NTMS_CHANGERINFORMATIONW Changer;
        NTMS_CHANGERTYPEINFORMATIONW ChangerType;
        NTMS_STORAGESLOTINFORMATION StorageSlot;
        NTMS_IEDOORINFORMATION IEDoor;
        NTMS_IEPORTINFORMATION IEPort;
        NTMS_PMIDINFORMATIONW PhysicalMedia;
        NTMS_LMIDINFORMATION LogicalMedia;
        NTMS_PARTITIONINFORMATIONW Partition;
        NTMS_MEDIAPOOLINFORMATION MediaPool;
        NTMS_MEDIATYPEINFORMATION MediaType;
        NTMS_LIBREQUESTINFORMATIONW LibRequest;
        NTMS_OPREQUESTINFORMATIONW OpRequest;
        NTMS_COMPUTERINFORMATION Computer;
    }
}

struct NTMS_I1_LIBRARYINFORMATION
{
    uint LibraryType;
    GUID CleanerSlot;
    GUID CleanerSlotDefault;
    BOOL LibrarySupportsDriveCleaning;
    BOOL BarCodeReaderInstalled;
    uint InventoryMethod;
    uint dwCleanerUsesRemaining;
    uint FirstDriveNumber;
    uint dwNumberOfDrives;
    uint FirstSlotNumber;
    uint dwNumberOfSlots;
    uint FirstDoorNumber;
    uint dwNumberOfDoors;
    uint FirstPortNumber;
    uint dwNumberOfPorts;
    uint FirstChangerNumber;
    uint dwNumberOfChangers;
    uint dwNumberOfMedia;
    uint dwNumberOfMediaTypes;
    uint dwNumberOfLibRequests;
    GUID Reserved;
}

struct NTMS_I1_LIBREQUESTINFORMATIONA
{
    uint       OperationCode;
    uint       OperationOption;
    uint       State;
    GUID       PartitionId;
    GUID       DriveId;
    GUID       PhysMediaId;
    GUID       Library;
    GUID       SlotId;
    SYSTEMTIME TimeQueued;
    SYSTEMTIME TimeCompleted;
    byte[64]   szApplication;
    byte[64]   szUser;
    byte[64]   szComputer;
}

struct NTMS_I1_LIBREQUESTINFORMATIONW
{
    uint       OperationCode;
    uint       OperationOption;
    uint       State;
    GUID       PartitionId;
    GUID       DriveId;
    GUID       PhysMediaId;
    GUID       Library;
    GUID       SlotId;
    SYSTEMTIME TimeQueued;
    SYSTEMTIME TimeCompleted;
    ushort[64] szApplication;
    ushort[64] szUser;
    ushort[64] szComputer;
}

struct NTMS_I1_PMIDINFORMATIONA
{
    GUID     CurrentLibrary;
    GUID     MediaPool;
    GUID     Location;
    uint     LocationType;
    GUID     MediaType;
    GUID     HomeSlot;
    byte[64] szBarCode;
    uint     BarCodeState;
    byte[32] szSequenceNumber;
    uint     MediaState;
    uint     dwNumberOfPartitions;
}

struct NTMS_I1_PMIDINFORMATIONW
{
    GUID       CurrentLibrary;
    GUID       MediaPool;
    GUID       Location;
    uint       LocationType;
    GUID       MediaType;
    GUID       HomeSlot;
    ushort[64] szBarCode;
    uint       BarCodeState;
    ushort[32] szSequenceNumber;
    uint       MediaState;
    uint       dwNumberOfPartitions;
}

struct NTMS_I1_PARTITIONINFORMATIONA
{
    GUID       PhysicalMedia;
    GUID       LogicalMedia;
    uint       State;
    ushort     Side;
    uint       dwOmidLabelIdLength;
    ubyte[255] OmidLabelId;
    byte[64]   szOmidLabelType;
    byte[256]  szOmidLabelInfo;
    uint       dwMountCount;
    uint       dwAllocateCount;
}

struct NTMS_I1_PARTITIONINFORMATIONW
{
    GUID        PhysicalMedia;
    GUID        LogicalMedia;
    uint        State;
    ushort      Side;
    uint        dwOmidLabelIdLength;
    ubyte[255]  OmidLabelId;
    ushort[64]  szOmidLabelType;
    ushort[256] szOmidLabelInfo;
    uint        dwMountCount;
    uint        dwAllocateCount;
}

struct NTMS_I1_OPREQUESTINFORMATIONA
{
    uint       Request;
    SYSTEMTIME Submitted;
    uint       State;
    byte[127]  szMessage;
    uint       Arg1Type;
    GUID       Arg1;
    uint       Arg2Type;
    GUID       Arg2;
    byte[64]   szApplication;
    byte[64]   szUser;
    byte[64]   szComputer;
}

struct NTMS_I1_OPREQUESTINFORMATIONW
{
    uint        Request;
    SYSTEMTIME  Submitted;
    uint        State;
    ushort[127] szMessage;
    uint        Arg1Type;
    GUID        Arg1;
    uint        Arg2Type;
    GUID        Arg2;
    ushort[64]  szApplication;
    ushort[64]  szUser;
    ushort[64]  szComputer;
}

struct NTMS_I1_OBJECTINFORMATIONA
{
    uint       dwSize;
    uint       dwType;
    SYSTEMTIME Created;
    SYSTEMTIME Modified;
    GUID       ObjectGuid;
    BOOL       Enabled;
    uint       dwOperationalState;
    byte[64]   szName;
    byte[127]  szDescription;
    union Info
    {
        NTMS_DRIVEINFORMATIONA Drive;
        NTMS_DRIVETYPEINFORMATIONA DriveType;
        NTMS_I1_LIBRARYINFORMATION Library;
        NTMS_CHANGERINFORMATIONA Changer;
        NTMS_CHANGERTYPEINFORMATIONA ChangerType;
        NTMS_STORAGESLOTINFORMATION StorageSlot;
        NTMS_IEDOORINFORMATION IEDoor;
        NTMS_IEPORTINFORMATION IEPort;
        NTMS_I1_PMIDINFORMATIONA PhysicalMedia;
        NTMS_LMIDINFORMATION LogicalMedia;
        NTMS_I1_PARTITIONINFORMATIONA Partition;
        NTMS_MEDIAPOOLINFORMATION MediaPool;
        NTMS_MEDIATYPEINFORMATION MediaType;
        NTMS_I1_LIBREQUESTINFORMATIONA LibRequest;
        NTMS_I1_OPREQUESTINFORMATIONA OpRequest;
    }
}

struct NTMS_I1_OBJECTINFORMATIONW
{
    uint        dwSize;
    uint        dwType;
    SYSTEMTIME  Created;
    SYSTEMTIME  Modified;
    GUID        ObjectGuid;
    BOOL        Enabled;
    uint        dwOperationalState;
    ushort[64]  szName;
    ushort[127] szDescription;
    union Info
    {
        NTMS_DRIVEINFORMATIONW Drive;
        NTMS_DRIVETYPEINFORMATIONW DriveType;
        NTMS_I1_LIBRARYINFORMATION Library;
        NTMS_CHANGERINFORMATIONW Changer;
        NTMS_CHANGERTYPEINFORMATIONW ChangerType;
        NTMS_STORAGESLOTINFORMATION StorageSlot;
        NTMS_IEDOORINFORMATION IEDoor;
        NTMS_IEPORTINFORMATION IEPort;
        NTMS_I1_PMIDINFORMATIONW PhysicalMedia;
        NTMS_LMIDINFORMATION LogicalMedia;
        NTMS_I1_PARTITIONINFORMATIONW Partition;
        NTMS_MEDIAPOOLINFORMATION MediaPool;
        NTMS_MEDIATYPEINFORMATION MediaType;
        NTMS_I1_LIBREQUESTINFORMATIONW LibRequest;
        NTMS_I1_OPREQUESTINFORMATIONW OpRequest;
    }
}

struct NTMS_FILESYSTEM_INFO
{
    ushort[64]  FileSystemType;
    ushort[256] VolumeName;
    uint        SerialNumber;
}

struct NTMS_NOTIFICATIONINFORMATION
{
    uint dwOperation;
    GUID ObjectId;
}

struct MediaLabelInfo
{
    ushort[64]  LabelType;
    uint        LabelIDSize;
    ubyte[256]  LabelID;
    ushort[256] LabelAppDescr;
}

struct CLS_LSN
{
    ulong Internal;
}

struct CLFS_NODE_ID
{
    uint cType;
    uint cbNode;
}

struct CLS_WRITE_ENTRY
{
    void* Buffer;
    uint  ByteLength;
}

struct CLS_INFORMATION
{
    long    TotalAvailable;
    long    CurrentAvailable;
    long    TotalReservation;
    ulong   BaseFileSize;
    ulong   ContainerSize;
    uint    TotalContainers;
    uint    FreeContainers;
    uint    TotalClients;
    uint    Attributes;
    uint    FlushThreshold;
    uint    SectorSize;
    CLS_LSN MinArchiveTailLsn;
    CLS_LSN BaseLsn;
    CLS_LSN LastFlushedLsn;
    CLS_LSN LastLsn;
    CLS_LSN RestartLsn;
    GUID    Identity;
}

struct CLFS_LOG_NAME_INFORMATION
{
    ushort    NameLengthInBytes;
    ushort[1] Name;
}

struct CLFS_STREAM_ID_INFORMATION
{
    ubyte StreamIdentifier;
}

struct CLFS_PHYSICAL_LSN_INFORMATION
{
    ubyte   StreamIdentifier;
    CLS_LSN VirtualLsn;
    CLS_LSN PhysicalLsn;
}

struct CLS_CONTAINER_INFORMATION
{
    uint        FileAttributes;
    ulong       CreationTime;
    ulong       LastAccessTime;
    ulong       LastWriteTime;
    long        ContainerSize;
    uint        FileNameActualLength;
    uint        FileNameLength;
    ushort[256] FileName;
    uint        State;
    uint        PhysicalContainerId;
    uint        LogicalContainerId;
}

struct CLS_IO_STATISTICS_HEADER
{
    ubyte              ubMajorVersion;
    ubyte              ubMinorVersion;
    CLFS_IOSTATS_CLASS eStatsClass;
    ushort             cbLength;
    uint               coffData;
}

struct CLS_IO_STATISTICS
{
    CLS_IO_STATISTICS_HEADER hdrIoStats;
    ulong cFlush;
    ulong cbFlush;
    ulong cMetaFlush;
    ulong cbMetaFlush;
}

struct CLS_SCAN_CONTEXT
{
    CLFS_NODE_ID cidNode;
    HANDLE       hLog;
    uint         cIndex;
    uint         cContainers;
    uint         cContainersReturned;
    ubyte        eScanMode;
    CLS_CONTAINER_INFORMATION* pinfoContainer;
}

struct CLS_ARCHIVE_DESCRIPTOR
{
    ulong coffLow;
    ulong coffHigh;
    CLS_CONTAINER_INFORMATION infoContainer;
}

struct CLFS_MGMT_POLICY
{
    uint Version;
    uint LengthInBytes;
    uint PolicyFlags;
    CLFS_MGMT_POLICY_TYPE PolicyType;
    union PolicyParameters
    {
        struct MaximumSize
        {
            uint Containers;
        }
        struct MinimumSize
        {
            uint Containers;
        }
        struct NewContainerSize
        {
            uint SizeInBytes;
        }
        struct GrowthRate
        {
            uint AbsoluteGrowthInContainers;
            uint RelativeGrowthPercentage;
        }
        struct LogTail
        {
            uint MinimumAvailablePercentage;
            uint MinimumAvailableContainers;
        }
        struct AutoShrink
        {
            uint Percentage;
        }
        struct AutoGrow
        {
            uint Enabled;
        }
        struct NewContainerPrefix
        {
            ushort    PrefixLengthInBytes;
            ushort[1] PrefixString;
        }
        struct NewContainerSuffix
        {
            ulong NextContainerSuffix;
        }
        struct NewContainerExtension
        {
            ushort    ExtensionLengthInBytes;
            ushort[1] ExtensionString;
        }
    }
}

struct CLFS_MGMT_NOTIFICATION
{
    CLFS_MGMT_NOTIFICATION_TYPE Notification;
    CLS_LSN Lsn;
    ushort  LogIsPinned;
}

struct LOG_MANAGEMENT_CALLBACKS
{
    void* CallbackContext;
    PLOG_TAIL_ADVANCE_CALLBACK AdvanceTailCallback;
    PLOG_FULL_HANDLER_CALLBACK LogFullHandlerCallback;
    PLOG_UNPINNED_CALLBACK LogUnpinnedCallback;
}

struct DISKQUOTA_USER_INFORMATION
{
    long QuotaUsed;
    long QuotaThreshold;
    long QuotaLimit;
}

struct WIM_ENTRY_INFO
{
    uint          WimEntryInfoSize;
    uint          WimType;
    LARGE_INTEGER DataSourceId;
    GUID          WimGuid;
    const(wchar)* WimPath;
    uint          WimIndex;
    uint          Flags;
}

struct WIM_EXTERNAL_FILE_INFO
{
    LARGE_INTEGER DataSourceId;
    ubyte[20]     ResourceHash;
    uint          Flags;
}

struct WOF_FILE_COMPRESSION_INFO_V0
{
    uint Algorithm;
}

struct WOF_FILE_COMPRESSION_INFO_V1
{
    uint Algorithm;
    uint Flags;
}

struct TXF_ID
{
    struct
    {
    align (4):
        long LowPart;
        long HighPart;
    }
}

struct TXF_LOG_RECORD_BASE
{
    ushort Version;
    ushort RecordType;
    uint   RecordLength;
}

struct TXF_LOG_RECORD_WRITE
{
align (4):
    ushort Version;
    ushort RecordType;
    uint   RecordLength;
    uint   Flags;
    TXF_ID TxfFileId;
    GUID   KtmGuid;
    long   ByteOffsetInFile;
    uint   NumBytesWritten;
    uint   ByteOffsetInStructure;
    uint   FileNameLength;
    uint   FileNameByteOffsetInStructure;
}

struct TXF_LOG_RECORD_TRUNCATE
{
align (4):
    ushort Version;
    ushort RecordType;
    uint   RecordLength;
    uint   Flags;
    TXF_ID TxfFileId;
    GUID   KtmGuid;
    long   NewFileSize;
    uint   FileNameLength;
    uint   FileNameByteOffsetInStructure;
}

struct TXF_LOG_RECORD_AFFECTED_FILE
{
    ushort Version;
    uint   RecordLength;
    uint   Flags;
    TXF_ID TxfFileId;
    GUID   KtmGuid;
    uint   FileNameLength;
    uint   FileNameByteOffsetInStructure;
}

struct VOLUME_FAILOVER_SET
{
    uint    NumberOfDisks;
    uint[1] DiskNumbers;
}

struct VOLUME_NUMBER
{
    uint      VolumeNumber;
    ushort[8] VolumeManagerName;
}

struct VOLUME_LOGICAL_OFFSET
{
    long LogicalOffset;
}

struct VOLUME_PHYSICAL_OFFSET
{
    uint DiskNumber;
    long Offset;
}

struct VOLUME_PHYSICAL_OFFSETS
{
    uint NumberOfPhysicalOffsets;
    VOLUME_PHYSICAL_OFFSET[1] PhysicalOffset;
}

struct VOLUME_READ_PLEX_INPUT
{
    LARGE_INTEGER ByteOffset;
    uint          Length;
    uint          PlexNumber;
}

struct VOLUME_SET_GPT_ATTRIBUTES_INFORMATION
{
    ulong  GptAttributes;
    ubyte  RevertOnClose;
    ubyte  ApplyToAllConnectedVolumes;
    ushort Reserved1;
    uint   Reserved2;
}

struct VOLUME_GET_BC_PROPERTIES_INPUT
{
    uint  Version;
    uint  Reserved1;
    ulong LowestByteOffset;
    ulong HighestByteOffset;
    uint  AccessType;
    uint  AccessMode;
}

struct VOLUME_GET_BC_PROPERTIES_OUTPUT
{
    uint  MaximumRequestsPerPeriod;
    uint  MinimumPeriod;
    ulong MaximumRequestSize;
    uint  EstimatedTimePerRequest;
    uint  NumOutStandingRequests;
    ulong RequestSize;
}

struct VOLUME_ALLOCATE_BC_STREAM_INPUT
{
    uint     Version;
    uint     RequestsPerPeriod;
    uint     Period;
    ubyte    RetryFailures;
    ubyte    Discardable;
    ubyte[2] Reserved1;
    ulong    LowestByteOffset;
    ulong    HighestByteOffset;
    uint     AccessType;
    uint     AccessMode;
}

struct VOLUME_ALLOCATE_BC_STREAM_OUTPUT
{
    ulong RequestSize;
    uint  NumOutStandingRequests;
}

struct FILE_EXTENT
{
    ulong VolumeOffset;
    ulong ExtentLength;
}

struct VOLUME_CRITICAL_IO
{
    uint           AccessType;
    uint           ExtentsCount;
    FILE_EXTENT[1] Extents;
}

struct VOLUME_ALLOCATION_HINT_INPUT
{
    uint ClusterSize;
    uint NumberOfClusters;
    long StartingClusterNumber;
}

struct VOLUME_ALLOCATION_HINT_OUTPUT
{
    uint[1] Bitmap;
}

struct VOLUME_SHRINK_INFO
{
    ulong VolumeSize;
}

struct SHARE_INFO_0
{
    const(wchar)* shi0_netname;
}

struct SHARE_INFO_1
{
    const(wchar)* shi1_netname;
    uint          shi1_type;
    const(wchar)* shi1_remark;
}

struct SHARE_INFO_2
{
    const(wchar)* shi2_netname;
    uint          shi2_type;
    const(wchar)* shi2_remark;
    uint          shi2_permissions;
    uint          shi2_max_uses;
    uint          shi2_current_uses;
    const(wchar)* shi2_path;
    const(wchar)* shi2_passwd;
}

struct SHARE_INFO_501
{
    const(wchar)* shi501_netname;
    uint          shi501_type;
    const(wchar)* shi501_remark;
    uint          shi501_flags;
}

struct SHARE_INFO_502
{
    const(wchar)* shi502_netname;
    uint          shi502_type;
    const(wchar)* shi502_remark;
    uint          shi502_permissions;
    uint          shi502_max_uses;
    uint          shi502_current_uses;
    const(wchar)* shi502_path;
    const(wchar)* shi502_passwd;
    uint          shi502_reserved;
    void*         shi502_security_descriptor;
}

struct SHARE_INFO_503
{
    const(wchar)* shi503_netname;
    uint          shi503_type;
    const(wchar)* shi503_remark;
    uint          shi503_permissions;
    uint          shi503_max_uses;
    uint          shi503_current_uses;
    const(wchar)* shi503_path;
    const(wchar)* shi503_passwd;
    const(wchar)* shi503_servername;
    uint          shi503_reserved;
    void*         shi503_security_descriptor;
}

struct SHARE_INFO_1004
{
    const(wchar)* shi1004_remark;
}

struct SHARE_INFO_1005
{
    uint shi1005_flags;
}

struct SHARE_INFO_1006
{
    uint shi1006_max_uses;
}

struct SHARE_INFO_1501
{
    uint  shi1501_reserved;
    void* shi1501_security_descriptor;
}

struct SHARE_INFO_1503
{
    GUID shi1503_sharefilter;
}

struct SERVER_ALIAS_INFO_0
{
    const(wchar)* srvai0_alias;
    const(wchar)* srvai0_target;
    ubyte         srvai0_default;
    uint          srvai0_reserved;
}

struct SESSION_INFO_0
{
    const(wchar)* sesi0_cname;
}

struct SESSION_INFO_1
{
    const(wchar)* sesi1_cname;
    const(wchar)* sesi1_username;
    uint          sesi1_num_opens;
    uint          sesi1_time;
    uint          sesi1_idle_time;
    uint          sesi1_user_flags;
}

struct SESSION_INFO_2
{
    const(wchar)* sesi2_cname;
    const(wchar)* sesi2_username;
    uint          sesi2_num_opens;
    uint          sesi2_time;
    uint          sesi2_idle_time;
    uint          sesi2_user_flags;
    const(wchar)* sesi2_cltype_name;
}

struct SESSION_INFO_10
{
    const(wchar)* sesi10_cname;
    const(wchar)* sesi10_username;
    uint          sesi10_time;
    uint          sesi10_idle_time;
}

struct SESSION_INFO_502
{
    const(wchar)* sesi502_cname;
    const(wchar)* sesi502_username;
    uint          sesi502_num_opens;
    uint          sesi502_time;
    uint          sesi502_idle_time;
    uint          sesi502_user_flags;
    const(wchar)* sesi502_cltype_name;
    const(wchar)* sesi502_transport;
}

struct CONNECTION_INFO_0
{
    uint coni0_id;
}

struct CONNECTION_INFO_1
{
    uint          coni1_id;
    uint          coni1_type;
    uint          coni1_num_opens;
    uint          coni1_num_users;
    uint          coni1_time;
    const(wchar)* coni1_username;
    const(wchar)* coni1_netname;
}

struct FILE_INFO_2
{
    uint fi2_id;
}

struct FILE_INFO_3
{
    uint          fi3_id;
    uint          fi3_permissions;
    uint          fi3_num_locks;
    const(wchar)* fi3_pathname;
    const(wchar)* fi3_username;
}

struct SERVER_CERTIFICATE_INFO_0
{
    const(wchar)* srvci0_name;
    const(wchar)* srvci0_subject;
    const(wchar)* srvci0_issuer;
    const(wchar)* srvci0_thumbprint;
    const(wchar)* srvci0_friendlyname;
    const(wchar)* srvci0_notbefore;
    const(wchar)* srvci0_notafter;
    const(wchar)* srvci0_storelocation;
    const(wchar)* srvci0_storename;
    uint          srvci0_type;
}

struct STAT_WORKSTATION_0
{
    LARGE_INTEGER StatisticsStartTime;
    LARGE_INTEGER BytesReceived;
    LARGE_INTEGER SmbsReceived;
    LARGE_INTEGER PagingReadBytesRequested;
    LARGE_INTEGER NonPagingReadBytesRequested;
    LARGE_INTEGER CacheReadBytesRequested;
    LARGE_INTEGER NetworkReadBytesRequested;
    LARGE_INTEGER BytesTransmitted;
    LARGE_INTEGER SmbsTransmitted;
    LARGE_INTEGER PagingWriteBytesRequested;
    LARGE_INTEGER NonPagingWriteBytesRequested;
    LARGE_INTEGER CacheWriteBytesRequested;
    LARGE_INTEGER NetworkWriteBytesRequested;
    uint          InitiallyFailedOperations;
    uint          FailedCompletionOperations;
    uint          ReadOperations;
    uint          RandomReadOperations;
    uint          ReadSmbs;
    uint          LargeReadSmbs;
    uint          SmallReadSmbs;
    uint          WriteOperations;
    uint          RandomWriteOperations;
    uint          WriteSmbs;
    uint          LargeWriteSmbs;
    uint          SmallWriteSmbs;
    uint          RawReadsDenied;
    uint          RawWritesDenied;
    uint          NetworkErrors;
    uint          Sessions;
    uint          FailedSessions;
    uint          Reconnects;
    uint          CoreConnects;
    uint          Lanman20Connects;
    uint          Lanman21Connects;
    uint          LanmanNtConnects;
    uint          ServerDisconnects;
    uint          HungSessions;
    uint          UseCount;
    uint          FailedUseCount;
    uint          CurrentCommands;
}

struct STAT_SERVER_0
{
    uint sts0_start;
    uint sts0_fopens;
    uint sts0_devopens;
    uint sts0_jobsqueued;
    uint sts0_sopens;
    uint sts0_stimedout;
    uint sts0_serrorout;
    uint sts0_pwerrors;
    uint sts0_permerrors;
    uint sts0_syserrors;
    uint sts0_bytessent_low;
    uint sts0_bytessent_high;
    uint sts0_bytesrcvd_low;
    uint sts0_bytesrcvd_high;
    uint sts0_avresponse;
    uint sts0_reqbufneed;
    uint sts0_bigbufneed;
}

struct OFSTRUCT
{
    ubyte     cBytes;
    ubyte     fFixedDisk;
    ushort    nErrCode;
    ushort    Reserved1;
    ushort    Reserved2;
    byte[128] szPathName;
}

struct COPYFILE2_MESSAGE
{
    COPYFILE2_MESSAGE_TYPE Type;
    uint dwPadding;
    union Info
    {
        struct ChunkStarted
        {
            uint           dwStreamNumber;
            uint           dwReserved;
            HANDLE         hSourceFile;
            HANDLE         hDestinationFile;
            ULARGE_INTEGER uliChunkNumber;
            ULARGE_INTEGER uliChunkSize;
            ULARGE_INTEGER uliStreamSize;
            ULARGE_INTEGER uliTotalFileSize;
        }
        struct ChunkFinished
        {
            uint           dwStreamNumber;
            uint           dwFlags;
            HANDLE         hSourceFile;
            HANDLE         hDestinationFile;
            ULARGE_INTEGER uliChunkNumber;
            ULARGE_INTEGER uliChunkSize;
            ULARGE_INTEGER uliStreamSize;
            ULARGE_INTEGER uliStreamBytesTransferred;
            ULARGE_INTEGER uliTotalFileSize;
            ULARGE_INTEGER uliTotalBytesTransferred;
        }
        struct StreamStarted
        {
            uint           dwStreamNumber;
            uint           dwReserved;
            HANDLE         hSourceFile;
            HANDLE         hDestinationFile;
            ULARGE_INTEGER uliStreamSize;
            ULARGE_INTEGER uliTotalFileSize;
        }
        struct StreamFinished
        {
            uint           dwStreamNumber;
            uint           dwReserved;
            HANDLE         hSourceFile;
            HANDLE         hDestinationFile;
            ULARGE_INTEGER uliStreamSize;
            ULARGE_INTEGER uliStreamBytesTransferred;
            ULARGE_INTEGER uliTotalFileSize;
            ULARGE_INTEGER uliTotalBytesTransferred;
        }
        struct PollContinue
        {
            uint dwReserved;
        }
        struct Error
        {
            COPYFILE2_COPY_PHASE CopyPhase;
            uint                 dwStreamNumber;
            HRESULT              hrFailure;
            uint                 dwReserved;
            ULARGE_INTEGER       uliChunkNumber;
            ULARGE_INTEGER       uliStreamSize;
            ULARGE_INTEGER       uliStreamBytesTransferred;
            ULARGE_INTEGER       uliTotalFileSize;
            ULARGE_INTEGER       uliTotalBytesTransferred;
        }
    }
}

struct COPYFILE2_EXTENDED_PARAMETERS
{
    uint  dwSize;
    uint  dwCopyFlags;
    int*  pfCancel;
    PCOPYFILE2_PROGRESS_ROUTINE pProgressRoutine;
    void* pvCallbackContext;
}

struct FILE_BASIC_INFO
{
    LARGE_INTEGER CreationTime;
    LARGE_INTEGER LastAccessTime;
    LARGE_INTEGER LastWriteTime;
    LARGE_INTEGER ChangeTime;
    uint          FileAttributes;
}

struct FILE_STANDARD_INFO
{
    LARGE_INTEGER AllocationSize;
    LARGE_INTEGER EndOfFile;
    uint          NumberOfLinks;
    ubyte         DeletePending;
    ubyte         Directory;
}

struct FILE_NAME_INFO
{
    uint      FileNameLength;
    ushort[1] FileName;
}

struct FILE_RENAME_INFO
{
    union
    {
        ubyte ReplaceIfExists;
        uint  Flags;
    }
    HANDLE    RootDirectory;
    uint      FileNameLength;
    ushort[1] FileName;
}

struct FILE_ALLOCATION_INFO
{
    LARGE_INTEGER AllocationSize;
}

struct FILE_END_OF_FILE_INFO
{
    LARGE_INTEGER EndOfFile;
}

struct FILE_STREAM_INFO
{
    uint          NextEntryOffset;
    uint          StreamNameLength;
    LARGE_INTEGER StreamSize;
    LARGE_INTEGER StreamAllocationSize;
    ushort[1]     StreamName;
}

struct FILE_COMPRESSION_INFO
{
    LARGE_INTEGER CompressedFileSize;
    ushort        CompressionFormat;
    ubyte         CompressionUnitShift;
    ubyte         ChunkShift;
    ubyte         ClusterShift;
    ubyte[3]      Reserved;
}

struct FILE_ATTRIBUTE_TAG_INFO
{
    uint FileAttributes;
    uint ReparseTag;
}

struct FILE_DISPOSITION_INFO
{
    ubyte DeleteFileA;
}

struct FILE_ID_BOTH_DIR_INFO
{
    uint          NextEntryOffset;
    uint          FileIndex;
    LARGE_INTEGER CreationTime;
    LARGE_INTEGER LastAccessTime;
    LARGE_INTEGER LastWriteTime;
    LARGE_INTEGER ChangeTime;
    LARGE_INTEGER EndOfFile;
    LARGE_INTEGER AllocationSize;
    uint          FileAttributes;
    uint          FileNameLength;
    uint          EaSize;
    byte          ShortNameLength;
    ushort[12]    ShortName;
    LARGE_INTEGER FileId;
    ushort[1]     FileName;
}

struct FILE_FULL_DIR_INFO
{
    uint          NextEntryOffset;
    uint          FileIndex;
    LARGE_INTEGER CreationTime;
    LARGE_INTEGER LastAccessTime;
    LARGE_INTEGER LastWriteTime;
    LARGE_INTEGER ChangeTime;
    LARGE_INTEGER EndOfFile;
    LARGE_INTEGER AllocationSize;
    uint          FileAttributes;
    uint          FileNameLength;
    uint          EaSize;
    ushort[1]     FileName;
}

struct FILE_IO_PRIORITY_HINT_INFO
{
    PRIORITY_HINT PriorityHint;
}

struct FILE_ALIGNMENT_INFO
{
    uint AlignmentRequirement;
}

struct FILE_STORAGE_INFO
{
    uint LogicalBytesPerSector;
    uint PhysicalBytesPerSectorForAtomicity;
    uint PhysicalBytesPerSectorForPerformance;
    uint FileSystemEffectivePhysicalBytesPerSectorForAtomicity;
    uint Flags;
    uint ByteOffsetForSectorAlignment;
    uint ByteOffsetForPartitionAlignment;
}

struct FILE_ID_INFO
{
    ulong       VolumeSerialNumber;
    FILE_ID_128 FileId;
}

struct FILE_ID_EXTD_DIR_INFO
{
    uint          NextEntryOffset;
    uint          FileIndex;
    LARGE_INTEGER CreationTime;
    LARGE_INTEGER LastAccessTime;
    LARGE_INTEGER LastWriteTime;
    LARGE_INTEGER ChangeTime;
    LARGE_INTEGER EndOfFile;
    LARGE_INTEGER AllocationSize;
    uint          FileAttributes;
    uint          FileNameLength;
    uint          EaSize;
    uint          ReparsePointTag;
    FILE_ID_128   FileId;
    ushort[1]     FileName;
}

struct FILE_REMOTE_PROTOCOL_INFO
{
    ushort StructureVersion;
    ushort StructureSize;
    uint   Protocol;
    ushort ProtocolMajorVersion;
    ushort ProtocolMinorVersion;
    ushort ProtocolRevision;
    ushort Reserved;
    uint   Flags;
    struct GenericReserved
    {
        uint[8] Reserved;
    }
    union ProtocolSpecific
    {
        struct Smb2
        {
            struct Server
            {
                uint Capabilities;
            }
            struct Share
            {
                uint Capabilities;
                uint CachingFlags;
            }
        }
        uint[16] Reserved;
    }
}

struct FILE_ID_DESCRIPTOR
{
    uint         dwSize;
    FILE_ID_TYPE Type;
    union
    {
        LARGE_INTEGER FileId;
        GUID          ObjectId;
        FILE_ID_128   ExtendedFileId;
    }
}

// Functions

@DllImport("KERNEL32")
BOOL CreateDirectoryA(const(char)* lpPathName, SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("KERNEL32")
BOOL CreateDirectoryW(const(wchar)* lpPathName, SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("KERNEL32")
HANDLE CreateFileA(const(char)* lpFileName, FILE_ACCESS_FLAGS dwDesiredAccess, FILE_SHARE_FLAGS dwShareMode, 
                   SECURITY_ATTRIBUTES* lpSecurityAttributes, FILE_CREATE_FLAGS dwCreationDisposition, 
                   FILE_FLAGS_AND_ATTRIBUTES dwFlagsAndAttributes, HANDLE hTemplateFile);

@DllImport("KERNEL32")
HANDLE CreateFileW(const(wchar)* lpFileName, FILE_ACCESS_FLAGS dwDesiredAccess, FILE_SHARE_FLAGS dwShareMode, 
                   SECURITY_ATTRIBUTES* lpSecurityAttributes, FILE_CREATE_FLAGS dwCreationDisposition, 
                   FILE_FLAGS_AND_ATTRIBUTES dwFlagsAndAttributes, HANDLE hTemplateFile);

@DllImport("KERNEL32")
BOOL DefineDosDeviceW(DEFINE_DOS_DEVICE_FLAGS dwFlags, const(wchar)* lpDeviceName, const(wchar)* lpTargetPath);

@DllImport("KERNEL32")
BOOL DeleteFileA(const(char)* lpFileName);

@DllImport("KERNEL32")
BOOL DeleteFileW(const(wchar)* lpFileName);

@DllImport("KERNEL32")
BOOL DeleteVolumeMountPointW(const(wchar)* lpszVolumeMountPoint);

@DllImport("KERNEL32")
BOOL FindClose(HANDLE hFindFile);

@DllImport("KERNEL32")
BOOL FindCloseChangeNotification(FindChangeNotifcationHandle hChangeHandle);

@DllImport("KERNEL32")
FindChangeNotifcationHandle FindFirstChangeNotificationA(const(char)* lpPathName, BOOL bWatchSubtree, 
                                                         FILE_NOTIFY_CHANGE dwNotifyFilter);

@DllImport("KERNEL32")
FindChangeNotifcationHandle FindFirstChangeNotificationW(const(wchar)* lpPathName, BOOL bWatchSubtree, 
                                                         uint dwNotifyFilter);

@DllImport("KERNEL32")
FindFileHandle FindFirstFileA(const(char)* lpFileName, WIN32_FIND_DATAA* lpFindFileData);

@DllImport("KERNEL32")
FindFileHandle FindFirstFileW(const(wchar)* lpFileName, WIN32_FIND_DATAW* lpFindFileData);

@DllImport("KERNEL32")
FindFileHandle FindFirstFileExA(const(char)* lpFileName, FINDEX_INFO_LEVELS fInfoLevelId, char* lpFindFileData, 
                                FINDEX_SEARCH_OPS fSearchOp, void* lpSearchFilter, 
                                FIND_FIRST_EX_FLAGS dwAdditionalFlags);

@DllImport("KERNEL32")
FindFileHandle FindFirstFileExW(const(wchar)* lpFileName, FINDEX_INFO_LEVELS fInfoLevelId, char* lpFindFileData, 
                                FINDEX_SEARCH_OPS fSearchOp, void* lpSearchFilter, 
                                FIND_FIRST_EX_FLAGS dwAdditionalFlags);

@DllImport("KERNEL32")
FindVolumeHandle FindFirstVolumeW(const(wchar)* lpszVolumeName, uint cchBufferLength);

@DllImport("KERNEL32")
BOOL FindNextChangeNotification(FindChangeNotifcationHandle hChangeHandle);

@DllImport("KERNEL32")
BOOL FindNextFileA(FindFileHandle hFindFile, WIN32_FIND_DATAA* lpFindFileData);

@DllImport("KERNEL32")
BOOL FindNextFileW(HANDLE hFindFile, WIN32_FIND_DATAW* lpFindFileData);

@DllImport("KERNEL32")
BOOL FindNextVolumeW(FindVolumeHandle hFindVolume, const(wchar)* lpszVolumeName, uint cchBufferLength);

@DllImport("KERNEL32")
BOOL FindVolumeClose(FindVolumeHandle hFindVolume);

@DllImport("KERNEL32")
BOOL FlushFileBuffers(HANDLE hFile);

@DllImport("KERNEL32")
BOOL GetDiskFreeSpaceA(const(char)* lpRootPathName, uint* lpSectorsPerCluster, uint* lpBytesPerSector, 
                       uint* lpNumberOfFreeClusters, uint* lpTotalNumberOfClusters);

@DllImport("KERNEL32")
BOOL GetDiskFreeSpaceW(const(wchar)* lpRootPathName, uint* lpSectorsPerCluster, uint* lpBytesPerSector, 
                       uint* lpNumberOfFreeClusters, uint* lpTotalNumberOfClusters);

@DllImport("KERNEL32")
BOOL GetDiskFreeSpaceExA(const(char)* lpDirectoryName, ULARGE_INTEGER* lpFreeBytesAvailableToCaller, 
                         ULARGE_INTEGER* lpTotalNumberOfBytes, ULARGE_INTEGER* lpTotalNumberOfFreeBytes);

@DllImport("KERNEL32")
BOOL GetDiskFreeSpaceExW(const(wchar)* lpDirectoryName, ULARGE_INTEGER* lpFreeBytesAvailableToCaller, 
                         ULARGE_INTEGER* lpTotalNumberOfBytes, ULARGE_INTEGER* lpTotalNumberOfFreeBytes);

@DllImport("KERNEL32")
HRESULT GetDiskSpaceInformationA(const(char)* rootPath, DISK_SPACE_INFORMATION* diskSpaceInfo);

@DllImport("KERNEL32")
HRESULT GetDiskSpaceInformationW(const(wchar)* rootPath, DISK_SPACE_INFORMATION* diskSpaceInfo);

@DllImport("KERNEL32")
uint GetDriveTypeA(const(char)* lpRootPathName);

@DllImport("KERNEL32")
uint GetDriveTypeW(const(wchar)* lpRootPathName);

@DllImport("KERNEL32")
uint GetFileAttributesA(const(char)* lpFileName);

@DllImport("KERNEL32")
uint GetFileAttributesW(const(wchar)* lpFileName);

@DllImport("KERNEL32")
BOOL GetFileAttributesExA(const(char)* lpFileName, GET_FILEEX_INFO_LEVELS fInfoLevelId, char* lpFileInformation);

@DllImport("KERNEL32")
BOOL GetFileAttributesExW(const(wchar)* lpFileName, GET_FILEEX_INFO_LEVELS fInfoLevelId, char* lpFileInformation);

@DllImport("KERNEL32")
BOOL GetFileInformationByHandle(HANDLE hFile, BY_HANDLE_FILE_INFORMATION* lpFileInformation);

@DllImport("KERNEL32")
uint GetFileSize(HANDLE hFile, uint* lpFileSizeHigh);

@DllImport("KERNEL32")
BOOL GetFileSizeEx(HANDLE hFile, LARGE_INTEGER* lpFileSize);

@DllImport("KERNEL32")
uint GetFileType(HANDLE hFile);

@DllImport("KERNEL32")
uint GetFinalPathNameByHandleA(HANDLE hFile, const(char)* lpszFilePath, uint cchFilePath, uint dwFlags);

@DllImport("KERNEL32")
uint GetFinalPathNameByHandleW(HANDLE hFile, const(wchar)* lpszFilePath, uint cchFilePath, uint dwFlags);

@DllImport("KERNEL32")
uint GetFullPathNameW(const(wchar)* lpFileName, uint nBufferLength, const(wchar)* lpBuffer, ushort** lpFilePart);

@DllImport("KERNEL32")
uint GetFullPathNameA(const(char)* lpFileName, uint nBufferLength, const(char)* lpBuffer, byte** lpFilePart);

@DllImport("KERNEL32")
uint GetLogicalDrives();

@DllImport("KERNEL32")
uint GetLogicalDriveStringsW(uint nBufferLength, const(wchar)* lpBuffer);

@DllImport("KERNEL32")
uint GetLongPathNameA(const(char)* lpszShortPath, const(char)* lpszLongPath, uint cchBuffer);

@DllImport("KERNEL32")
uint GetLongPathNameW(const(wchar)* lpszShortPath, const(wchar)* lpszLongPath, uint cchBuffer);

@DllImport("KERNEL32")
uint GetShortPathNameW(const(wchar)* lpszLongPath, const(wchar)* lpszShortPath, uint cchBuffer);

@DllImport("KERNEL32")
uint GetTempFileNameW(const(wchar)* lpPathName, const(wchar)* lpPrefixString, uint uUnique, 
                      const(wchar)* lpTempFileName);

@DllImport("KERNEL32")
BOOL GetVolumeInformationByHandleW(HANDLE hFile, const(wchar)* lpVolumeNameBuffer, uint nVolumeNameSize, 
                                   uint* lpVolumeSerialNumber, uint* lpMaximumComponentLength, 
                                   uint* lpFileSystemFlags, const(wchar)* lpFileSystemNameBuffer, 
                                   uint nFileSystemNameSize);

@DllImport("KERNEL32")
BOOL GetVolumeInformationW(const(wchar)* lpRootPathName, const(wchar)* lpVolumeNameBuffer, uint nVolumeNameSize, 
                           uint* lpVolumeSerialNumber, uint* lpMaximumComponentLength, uint* lpFileSystemFlags, 
                           const(wchar)* lpFileSystemNameBuffer, uint nFileSystemNameSize);

@DllImport("KERNEL32")
BOOL GetVolumePathNameW(const(wchar)* lpszFileName, const(wchar)* lpszVolumePathName, uint cchBufferLength);

@DllImport("KERNEL32")
BOOL LockFile(HANDLE hFile, uint dwFileOffsetLow, uint dwFileOffsetHigh, uint nNumberOfBytesToLockLow, 
              uint nNumberOfBytesToLockHigh);

@DllImport("KERNEL32")
BOOL LockFileEx(HANDLE hFile, uint dwFlags, uint dwReserved, uint nNumberOfBytesToLockLow, 
                uint nNumberOfBytesToLockHigh, OVERLAPPED* lpOverlapped);

@DllImport("KERNEL32")
uint QueryDosDeviceW(const(wchar)* lpDeviceName, const(wchar)* lpTargetPath, uint ucchMax);

@DllImport("KERNEL32")
BOOL ReadFile(HANDLE hFile, char* lpBuffer, uint nNumberOfBytesToRead, uint* lpNumberOfBytesRead, 
              OVERLAPPED* lpOverlapped);

@DllImport("KERNEL32")
BOOL ReadFileEx(HANDLE hFile, char* lpBuffer, uint nNumberOfBytesToRead, OVERLAPPED* lpOverlapped, 
                LPOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

@DllImport("KERNEL32")
BOOL ReadFileScatter(HANDLE hFile, FILE_SEGMENT_ELEMENT* aSegmentArray, uint nNumberOfBytesToRead, 
                     uint* lpReserved, OVERLAPPED* lpOverlapped);

@DllImport("KERNEL32")
BOOL RemoveDirectoryA(const(char)* lpPathName);

@DllImport("KERNEL32")
BOOL RemoveDirectoryW(const(wchar)* lpPathName);

@DllImport("KERNEL32")
BOOL SetEndOfFile(HANDLE hFile);

@DllImport("KERNEL32")
BOOL SetFileAttributesA(const(char)* lpFileName, FILE_FLAGS_AND_ATTRIBUTES dwFileAttributes);

@DllImport("KERNEL32")
BOOL SetFileAttributesW(const(wchar)* lpFileName, FILE_FLAGS_AND_ATTRIBUTES dwFileAttributes);

@DllImport("KERNEL32")
BOOL SetFileInformationByHandle(HANDLE hFile, FILE_INFO_BY_HANDLE_CLASS FileInformationClass, 
                                char* lpFileInformation, uint dwBufferSize);

@DllImport("KERNEL32")
uint SetFilePointer(HANDLE hFile, int lDistanceToMove, int* lpDistanceToMoveHigh, uint dwMoveMethod);

@DllImport("KERNEL32")
BOOL SetFilePointerEx(HANDLE hFile, LARGE_INTEGER liDistanceToMove, LARGE_INTEGER* lpNewFilePointer, 
                      uint dwMoveMethod);

@DllImport("KERNEL32")
BOOL SetFileValidData(HANDLE hFile, long ValidDataLength);

@DllImport("KERNEL32")
BOOL UnlockFile(HANDLE hFile, uint dwFileOffsetLow, uint dwFileOffsetHigh, uint nNumberOfBytesToUnlockLow, 
                uint nNumberOfBytesToUnlockHigh);

@DllImport("KERNEL32")
BOOL UnlockFileEx(HANDLE hFile, uint dwReserved, uint nNumberOfBytesToUnlockLow, uint nNumberOfBytesToUnlockHigh, 
                  OVERLAPPED* lpOverlapped);

@DllImport("KERNEL32")
BOOL WriteFile(HANDLE hFile, char* lpBuffer, uint nNumberOfBytesToWrite, uint* lpNumberOfBytesWritten, 
               OVERLAPPED* lpOverlapped);

@DllImport("KERNEL32")
BOOL WriteFileEx(HANDLE hFile, char* lpBuffer, uint nNumberOfBytesToWrite, OVERLAPPED* lpOverlapped, 
                 LPOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

@DllImport("KERNEL32")
BOOL WriteFileGather(HANDLE hFile, FILE_SEGMENT_ELEMENT* aSegmentArray, uint nNumberOfBytesToWrite, 
                     uint* lpReserved, OVERLAPPED* lpOverlapped);

@DllImport("KERNEL32")
uint GetTempPathW(uint nBufferLength, const(wchar)* lpBuffer);

@DllImport("KERNEL32")
BOOL GetVolumeNameForVolumeMountPointW(const(wchar)* lpszVolumeMountPoint, const(wchar)* lpszVolumeName, 
                                       uint cchBufferLength);

@DllImport("KERNEL32")
BOOL GetVolumePathNamesForVolumeNameW(const(wchar)* lpszVolumeName, const(wchar)* lpszVolumePathNames, 
                                      uint cchBufferLength, uint* lpcchReturnLength);

@DllImport("KERNEL32")
HANDLE CreateFile2(const(wchar)* lpFileName, FILE_ACCESS_FLAGS dwDesiredAccess, FILE_SHARE_FLAGS dwShareMode, 
                   FILE_CREATE_FLAGS dwCreationDisposition, CREATEFILE2_EXTENDED_PARAMETERS* pCreateExParams);

@DllImport("KERNEL32")
BOOL SetFileIoOverlappedRange(HANDLE FileHandle, ubyte* OverlappedRangeStart, uint Length);

@DllImport("KERNEL32")
uint GetCompressedFileSizeA(const(char)* lpFileName, uint* lpFileSizeHigh);

@DllImport("KERNEL32")
uint GetCompressedFileSizeW(const(wchar)* lpFileName, uint* lpFileSizeHigh);

@DllImport("KERNEL32")
FindStreamHandle FindFirstStreamW(const(wchar)* lpFileName, STREAM_INFO_LEVELS InfoLevel, char* lpFindStreamData, 
                                  uint dwFlags);

@DllImport("KERNEL32")
BOOL FindNextStreamW(FindStreamHandle hFindStream, char* lpFindStreamData);

@DllImport("KERNEL32")
BOOL AreFileApisANSI();

@DllImport("KERNEL32")
uint GetTempPathA(uint nBufferLength, const(char)* lpBuffer);

@DllImport("KERNEL32")
FindFileNameHandle FindFirstFileNameW(const(wchar)* lpFileName, uint dwFlags, uint* StringLength, 
                                      const(wchar)* LinkName);

@DllImport("KERNEL32")
BOOL FindNextFileNameW(FindFileNameHandle hFindStream, uint* StringLength, const(wchar)* LinkName);

@DllImport("KERNEL32")
BOOL GetVolumeInformationA(const(char)* lpRootPathName, const(char)* lpVolumeNameBuffer, uint nVolumeNameSize, 
                           uint* lpVolumeSerialNumber, uint* lpMaximumComponentLength, uint* lpFileSystemFlags, 
                           const(char)* lpFileSystemNameBuffer, uint nFileSystemNameSize);

@DllImport("KERNEL32")
uint GetTempFileNameA(const(char)* lpPathName, const(char)* lpPrefixString, uint uUnique, 
                      const(char)* lpTempFileName);

@DllImport("KERNEL32")
void SetFileApisToOEM();

@DllImport("KERNEL32")
void SetFileApisToANSI();

@DllImport("api-ms-win-core-file-fromapp-l1-1-0")
BOOL CopyFileFromAppW(const(wchar)* lpExistingFileName, const(wchar)* lpNewFileName, BOOL bFailIfExists);

@DllImport("api-ms-win-core-file-fromapp-l1-1-0")
BOOL CreateDirectoryFromAppW(const(wchar)* lpPathName, SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("api-ms-win-core-file-fromapp-l1-1-0")
HANDLE CreateFileFromAppW(const(wchar)* lpFileName, uint dwDesiredAccess, uint dwShareMode, 
                          SECURITY_ATTRIBUTES* lpSecurityAttributes, uint dwCreationDisposition, 
                          uint dwFlagsAndAttributes, HANDLE hTemplateFile);

@DllImport("api-ms-win-core-file-fromapp-l1-1-0")
HANDLE CreateFile2FromAppW(const(wchar)* lpFileName, uint dwDesiredAccess, uint dwShareMode, 
                           uint dwCreationDisposition, CREATEFILE2_EXTENDED_PARAMETERS* pCreateExParams);

@DllImport("api-ms-win-core-file-fromapp-l1-1-0")
BOOL DeleteFileFromAppW(const(wchar)* lpFileName);

@DllImport("api-ms-win-core-file-fromapp-l1-1-0")
HANDLE FindFirstFileExFromAppW(const(wchar)* lpFileName, FINDEX_INFO_LEVELS fInfoLevelId, char* lpFindFileData, 
                               FINDEX_SEARCH_OPS fSearchOp, void* lpSearchFilter, uint dwAdditionalFlags);

@DllImport("api-ms-win-core-file-fromapp-l1-1-0")
BOOL GetFileAttributesExFromAppW(const(wchar)* lpFileName, GET_FILEEX_INFO_LEVELS fInfoLevelId, 
                                 char* lpFileInformation);

@DllImport("api-ms-win-core-file-fromapp-l1-1-0")
BOOL MoveFileFromAppW(const(wchar)* lpExistingFileName, const(wchar)* lpNewFileName);

@DllImport("api-ms-win-core-file-fromapp-l1-1-0")
BOOL RemoveDirectoryFromAppW(const(wchar)* lpPathName);

@DllImport("api-ms-win-core-file-fromapp-l1-1-0")
BOOL ReplaceFileFromAppW(const(wchar)* lpReplacedFileName, const(wchar)* lpReplacementFileName, 
                         const(wchar)* lpBackupFileName, uint dwReplaceFlags, void* lpExclude, void* lpReserved);

@DllImport("api-ms-win-core-file-fromapp-l1-1-0")
BOOL SetFileAttributesFromAppW(const(wchar)* lpFileName, uint dwFileAttributes);

@DllImport("KERNEL32")
HANDLE CreateIoCompletionPort(HANDLE FileHandle, HANDLE ExistingCompletionPort, size_t CompletionKey, 
                              uint NumberOfConcurrentThreads);

@DllImport("KERNEL32")
BOOL GetQueuedCompletionStatus(HANDLE CompletionPort, uint* lpNumberOfBytesTransferred, uint* lpCompletionKey, 
                               OVERLAPPED** lpOverlapped, uint dwMilliseconds);

@DllImport("KERNEL32")
BOOL GetQueuedCompletionStatusEx(HANDLE CompletionPort, char* lpCompletionPortEntries, uint ulCount, 
                                 uint* ulNumEntriesRemoved, uint dwMilliseconds, BOOL fAlertable);

@DllImport("KERNEL32")
BOOL PostQueuedCompletionStatus(HANDLE CompletionPort, uint dwNumberOfBytesTransferred, size_t dwCompletionKey, 
                                OVERLAPPED* lpOverlapped);

@DllImport("KERNEL32")
BOOL CancelIoEx(HANDLE hFile, OVERLAPPED* lpOverlapped);

@DllImport("KERNEL32")
BOOL CancelIo(HANDLE hFile);

@DllImport("KERNEL32")
BOOL CancelSynchronousIo(HANDLE hThread);

@DllImport("KERNEL32")
BOOL Wow64DisableWow64FsRedirection(void** OldValue);

@DllImport("KERNEL32")
BOOL Wow64RevertWow64FsRedirection(void* OlValue);

@DllImport("api-ms-win-core-wow64-l1-1-1")
ushort Wow64SetThreadDefaultGuestMachine(ushort Machine);

@DllImport("KERNEL32")
uint Wow64SuspendThread(HANDLE hThread);

@DllImport("KERNEL32")
int LZStart();

@DllImport("KERNEL32")
void LZDone();

@DllImport("KERNEL32")
int CopyLZFile(int hfSource, int hfDest);

@DllImport("KERNEL32")
int LZCopy(int hfSource, int hfDest);

@DllImport("KERNEL32")
int LZInit(int hfSource);

@DllImport("KERNEL32")
int GetExpandedNameA(const(char)* lpszSource, const(char)* lpszBuffer);

@DllImport("KERNEL32")
int GetExpandedNameW(const(wchar)* lpszSource, const(wchar)* lpszBuffer);

@DllImport("KERNEL32")
int LZOpenFileA(const(char)* lpFileName, OFSTRUCT* lpReOpenBuf, ushort wStyle);

@DllImport("KERNEL32")
int LZOpenFileW(const(wchar)* lpFileName, OFSTRUCT* lpReOpenBuf, ushort wStyle);

@DllImport("KERNEL32")
int LZSeek(int hFile, int lOffset, int iOrigin);

@DllImport("KERNEL32")
int LZRead(int hFile, char* lpBuffer, int cbRead);

@DllImport("KERNEL32")
void LZClose(int hFile);

@DllImport("ADVAPI32")
uint QueryUsersOnEncryptedFile(const(wchar)* lpFileName, ENCRYPTION_CERTIFICATE_HASH_LIST** pUsers);

@DllImport("ADVAPI32")
uint QueryRecoveryAgentsOnEncryptedFile(const(wchar)* lpFileName, 
                                        ENCRYPTION_CERTIFICATE_HASH_LIST** pRecoveryAgents);

@DllImport("ADVAPI32")
uint RemoveUsersFromEncryptedFile(const(wchar)* lpFileName, ENCRYPTION_CERTIFICATE_HASH_LIST* pHashes);

@DllImport("ADVAPI32")
uint AddUsersToEncryptedFile(const(wchar)* lpFileName, ENCRYPTION_CERTIFICATE_LIST* pEncryptionCertificates);

@DllImport("ADVAPI32")
uint SetUserFileEncryptionKey(ENCRYPTION_CERTIFICATE* pEncryptionCertificate);

@DllImport("ADVAPI32")
uint SetUserFileEncryptionKeyEx(ENCRYPTION_CERTIFICATE* pEncryptionCertificate, uint dwCapabilities, uint dwFlags, 
                                void* pvReserved);

@DllImport("ADVAPI32")
void FreeEncryptionCertificateHashList(ENCRYPTION_CERTIFICATE_HASH_LIST* pUsers);

@DllImport("ADVAPI32")
BOOL EncryptionDisable(const(wchar)* DirPath, BOOL Disable);

@DllImport("ADVAPI32")
uint DuplicateEncryptionInfoFile(const(wchar)* SrcFileName, const(wchar)* DstFileName, uint dwCreationDistribution, 
                                 uint dwAttributes, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes);

@DllImport("ADVAPI32")
uint GetEncryptedFileMetadata(const(wchar)* lpFileName, uint* pcbMetadata, ubyte** ppbMetadata);

@DllImport("ADVAPI32")
uint SetEncryptedFileMetadata(const(wchar)* lpFileName, ubyte* pbOldMetadata, ubyte* pbNewMetadata, 
                              ENCRYPTION_CERTIFICATE_HASH* pOwnerHash, uint dwOperation, 
                              ENCRYPTION_CERTIFICATE_HASH_LIST* pCertificatesAdded);

@DllImport("ADVAPI32")
void FreeEncryptedFileMetadata(ubyte* pbMetadata);

@DllImport("clfsw32")
ubyte LsnEqual(const(CLS_LSN)* plsn1, const(CLS_LSN)* plsn2);

@DllImport("clfsw32")
ubyte LsnLess(const(CLS_LSN)* plsn1, const(CLS_LSN)* plsn2);

@DllImport("clfsw32")
ubyte LsnGreater(const(CLS_LSN)* plsn1, const(CLS_LSN)* plsn2);

@DllImport("clfsw32")
ubyte LsnNull(const(CLS_LSN)* plsn);

@DllImport("clfsw32")
uint LsnContainer(const(CLS_LSN)* plsn);

@DllImport("clfsw32")
CLS_LSN LsnCreate(uint cidContainer, uint offBlock, uint cRecord);

@DllImport("clfsw32")
uint LsnBlockOffset(const(CLS_LSN)* plsn);

@DllImport("clfsw32")
uint LsnRecordSequence(const(CLS_LSN)* plsn);

@DllImport("clfsw32")
ubyte LsnInvalid(const(CLS_LSN)* plsn);

@DllImport("clfsw32")
CLS_LSN LsnIncrement(CLS_LSN* plsn);

@DllImport("clfsw32")
HANDLE CreateLogFile(const(wchar)* pszLogFileName, uint fDesiredAccess, uint dwShareMode, 
                     SECURITY_ATTRIBUTES* psaLogFile, uint fCreateDisposition, uint fFlagsAndAttributes);

@DllImport("clfsw32")
BOOL DeleteLogByHandle(HANDLE hLog);

@DllImport("clfsw32")
BOOL DeleteLogFile(const(wchar)* pszLogFileName, void* pvReserved);

@DllImport("clfsw32")
BOOL AddLogContainer(HANDLE hLog, ulong* pcbContainer, const(wchar)* pwszContainerPath, void* pReserved);

@DllImport("clfsw32")
BOOL AddLogContainerSet(HANDLE hLog, ushort cContainer, ulong* pcbContainer, char* rgwszContainerPath, 
                        void* pReserved);

@DllImport("clfsw32")
BOOL RemoveLogContainer(HANDLE hLog, const(wchar)* pwszContainerPath, BOOL fForce, void* pReserved);

@DllImport("clfsw32")
BOOL RemoveLogContainerSet(HANDLE hLog, ushort cContainer, char* rgwszContainerPath, BOOL fForce, void* pReserved);

@DllImport("clfsw32")
BOOL SetLogArchiveTail(HANDLE hLog, CLS_LSN* plsnArchiveTail, void* pReserved);

@DllImport("clfsw32")
BOOL SetEndOfLog(HANDLE hLog, CLS_LSN* plsnEnd, OVERLAPPED* lpOverlapped);

@DllImport("clfsw32")
BOOL TruncateLog(void* pvMarshal, CLS_LSN* plsnEnd, OVERLAPPED* lpOverlapped);

@DllImport("clfsw32")
BOOL CreateLogContainerScanContext(HANDLE hLog, uint cFromContainer, uint cContainers, ubyte eScanMode, 
                                   CLS_SCAN_CONTEXT* pcxScan, OVERLAPPED* pOverlapped);

@DllImport("clfsw32")
BOOL ScanLogContainers(CLS_SCAN_CONTEXT* pcxScan, ubyte eScanMode, void* pReserved);

@DllImport("clfsw32")
BOOL AlignReservedLog(void* pvMarshal, uint cReservedRecords, long* rgcbReservation, long* pcbAlignReservation);

@DllImport("clfsw32")
BOOL AllocReservedLog(void* pvMarshal, uint cReservedRecords, long* pcbAdjustment);

@DllImport("clfsw32")
BOOL FreeReservedLog(void* pvMarshal, uint cReservedRecords, long* pcbAdjustment);

@DllImport("clfsw32")
BOOL GetLogFileInformation(HANDLE hLog, CLS_INFORMATION* pinfoBuffer, uint* cbBuffer);

@DllImport("clfsw32")
BOOL SetLogArchiveMode(HANDLE hLog, CLFS_LOG_ARCHIVE_MODE eMode);

@DllImport("clfsw32")
BOOL ReadLogRestartArea(void* pvMarshal, void** ppvRestartBuffer, uint* pcbRestartBuffer, CLS_LSN* plsn, 
                        void** ppvContext, OVERLAPPED* pOverlapped);

@DllImport("clfsw32")
BOOL ReadPreviousLogRestartArea(void* pvReadContext, void** ppvRestartBuffer, uint* pcbRestartBuffer, 
                                CLS_LSN* plsnRestart, OVERLAPPED* pOverlapped);

@DllImport("clfsw32")
BOOL WriteLogRestartArea(void* pvMarshal, void* pvRestartBuffer, uint cbRestartBuffer, CLS_LSN* plsnBase, 
                         uint fFlags, uint* pcbWritten, CLS_LSN* plsnNext, OVERLAPPED* pOverlapped);

@DllImport("clfsw32")
BOOL GetLogReservationInfo(void* pvMarshal, uint* pcbRecordNumber, long* pcbUserReservation, 
                           long* pcbCommitReservation);

@DllImport("clfsw32")
BOOL AdvanceLogBase(void* pvMarshal, CLS_LSN* plsnBase, uint fFlags, OVERLAPPED* pOverlapped);

@DllImport("clfsw32")
BOOL CloseAndResetLogFile(HANDLE hLog);

@DllImport("clfsw32")
BOOL CreateLogMarshallingArea(HANDLE hLog, CLFS_BLOCK_ALLOCATION pfnAllocBuffer, 
                              CLFS_BLOCK_DEALLOCATION pfnFreeBuffer, void* pvBlockAllocContext, 
                              uint cbMarshallingBuffer, uint cMaxWriteBuffers, uint cMaxReadBuffers, 
                              void** ppvMarshal);

@DllImport("clfsw32")
BOOL DeleteLogMarshallingArea(void* pvMarshal);

@DllImport("clfsw32")
BOOL ReserveAndAppendLog(void* pvMarshal, CLS_WRITE_ENTRY* rgWriteEntries, uint cWriteEntries, 
                         CLS_LSN* plsnUndoNext, CLS_LSN* plsnPrevious, uint cReserveRecords, long* rgcbReservation, 
                         uint fFlags, CLS_LSN* plsn, OVERLAPPED* pOverlapped);

@DllImport("clfsw32")
BOOL ReserveAndAppendLogAligned(void* pvMarshal, CLS_WRITE_ENTRY* rgWriteEntries, uint cWriteEntries, 
                                uint cbEntryAlignment, CLS_LSN* plsnUndoNext, CLS_LSN* plsnPrevious, 
                                uint cReserveRecords, long* rgcbReservation, uint fFlags, CLS_LSN* plsn, 
                                OVERLAPPED* pOverlapped);

@DllImport("clfsw32")
BOOL FlushLogBuffers(void* pvMarshal, OVERLAPPED* pOverlapped);

@DllImport("clfsw32")
BOOL FlushLogToLsn(void* pvMarshalContext, CLS_LSN* plsnFlush, CLS_LSN* plsnLastFlushed, OVERLAPPED* pOverlapped);

@DllImport("clfsw32")
BOOL ReadLogRecord(void* pvMarshal, CLS_LSN* plsnFirst, CLFS_CONTEXT_MODE eContextMode, void** ppvReadBuffer, 
                   uint* pcbReadBuffer, ubyte* peRecordType, CLS_LSN* plsnUndoNext, CLS_LSN* plsnPrevious, 
                   void** ppvReadContext, OVERLAPPED* pOverlapped);

@DllImport("clfsw32")
BOOL ReadNextLogRecord(void* pvReadContext, void** ppvBuffer, uint* pcbBuffer, ubyte* peRecordType, 
                       CLS_LSN* plsnUser, CLS_LSN* plsnUndoNext, CLS_LSN* plsnPrevious, CLS_LSN* plsnRecord, 
                       OVERLAPPED* pOverlapped);

@DllImport("clfsw32")
BOOL TerminateReadLog(void* pvCursorContext);

@DllImport("clfsw32")
BOOL PrepareLogArchive(HANDLE hLog, const(wchar)* pszBaseLogFileName, uint cLen, const(CLS_LSN)* plsnLow, 
                       const(CLS_LSN)* plsnHigh, uint* pcActualLength, ulong* poffBaseLogFileData, 
                       ulong* pcbBaseLogFileLength, CLS_LSN* plsnBase, CLS_LSN* plsnLast, 
                       CLS_LSN* plsnCurrentArchiveTail, void** ppvArchiveContext);

@DllImport("clfsw32")
BOOL ReadLogArchiveMetadata(void* pvArchiveContext, uint cbOffset, uint cbBytesToRead, ubyte* pbReadBuffer, 
                            uint* pcbBytesRead);

@DllImport("clfsw32")
BOOL GetNextLogArchiveExtent(void* pvArchiveContext, CLS_ARCHIVE_DESCRIPTOR* rgadExtent, uint cDescriptors, 
                             uint* pcDescriptorsReturned);

@DllImport("clfsw32")
BOOL TerminateLogArchive(void* pvArchiveContext);

@DllImport("clfsw32")
BOOL ValidateLog(const(wchar)* pszLogFileName, SECURITY_ATTRIBUTES* psaLogFile, CLS_INFORMATION* pinfoBuffer, 
                 uint* pcbBuffer);

@DllImport("clfsw32")
BOOL GetLogContainerName(HANDLE hLog, uint cidLogicalContainer, const(wchar)* pwstrContainerName, 
                         uint cLenContainerName, uint* pcActualLenContainerName);

@DllImport("clfsw32")
BOOL GetLogIoStatistics(HANDLE hLog, void* pvStatsBuffer, uint cbStatsBuffer, CLFS_IOSTATS_CLASS eStatsClass, 
                        uint* pcbStatsWritten);

@DllImport("clfsw32")
BOOL RegisterManageableLogClient(HANDLE hLog, LOG_MANAGEMENT_CALLBACKS* pCallbacks);

@DllImport("clfsw32")
BOOL DeregisterManageableLogClient(HANDLE hLog);

@DllImport("clfsw32")
BOOL ReadLogNotification(HANDLE hLog, CLFS_MGMT_NOTIFICATION* pNotification, OVERLAPPED* lpOverlapped);

@DllImport("clfsw32")
BOOL InstallLogPolicy(HANDLE hLog, CLFS_MGMT_POLICY* pPolicy);

@DllImport("clfsw32")
BOOL RemoveLogPolicy(HANDLE hLog, CLFS_MGMT_POLICY_TYPE ePolicyType);

@DllImport("clfsw32")
BOOL QueryLogPolicy(HANDLE hLog, CLFS_MGMT_POLICY_TYPE ePolicyType, CLFS_MGMT_POLICY* pPolicyBuffer, 
                    uint* pcbPolicyBuffer);

@DllImport("clfsw32")
BOOL SetLogFileSizeWithPolicy(HANDLE hLog, ulong* pDesiredSize, ulong* pResultingSize);

@DllImport("clfsw32")
BOOL HandleLogFull(HANDLE hLog);

@DllImport("clfsw32")
BOOL LogTailAdvanceFailure(HANDLE hLog, uint dwReason);

@DllImport("clfsw32")
BOOL RegisterForLogWriteNotification(HANDLE hLog, uint cbThreshold, BOOL fEnable);

@DllImport("WOFUTIL")
BOOL WofShouldCompressBinaries(const(wchar)* Volume, uint* Algorithm);

@DllImport("WOFUTIL")
HRESULT WofGetDriverVersion(HANDLE FileOrVolumeHandle, uint Provider, uint* WofVersion);

@DllImport("WOFUTIL")
HRESULT WofSetFileDataLocation(HANDLE FileHandle, uint Provider, void* ExternalFileInfo, uint Length);

@DllImport("WOFUTIL")
HRESULT WofIsExternalFile(const(wchar)* FilePath, int* IsExternalFile, uint* Provider, void* ExternalFileInfo, 
                          uint* BufferLength);

@DllImport("WOFUTIL")
HRESULT WofEnumEntries(const(wchar)* VolumeName, uint Provider, WofEnumEntryProc EnumProc, void* UserData);

@DllImport("WOFUTIL")
HRESULT WofWimAddEntry(const(wchar)* VolumeName, const(wchar)* WimPath, uint WimType, uint WimIndex, 
                       LARGE_INTEGER* DataSourceId);

@DllImport("WOFUTIL")
HRESULT WofWimEnumFiles(const(wchar)* VolumeName, LARGE_INTEGER DataSourceId, WofEnumFilesProc EnumProc, 
                        void* UserData);

@DllImport("WOFUTIL")
HRESULT WofWimSuspendEntry(const(wchar)* VolumeName, LARGE_INTEGER DataSourceId);

@DllImport("WOFUTIL")
HRESULT WofWimRemoveEntry(const(wchar)* VolumeName, LARGE_INTEGER DataSourceId);

@DllImport("WOFUTIL")
HRESULT WofWimUpdateEntry(const(wchar)* VolumeName, LARGE_INTEGER DataSourceId, const(wchar)* NewWimPath);

@DllImport("WOFUTIL")
HRESULT WofFileEnumFiles(const(wchar)* VolumeName, uint Algorithm, WofEnumFilesProc EnumProc, void* UserData);

@DllImport("txfw32")
BOOL TxfLogCreateFileReadContext(const(wchar)* LogPath, CLS_LSN BeginningLsn, CLS_LSN EndingLsn, TXF_ID* TxfFileId, 
                                 void** TxfLogContext);

@DllImport("txfw32")
BOOL TxfLogCreateRangeReadContext(const(wchar)* LogPath, CLS_LSN BeginningLsn, CLS_LSN EndingLsn, 
                                  LARGE_INTEGER* BeginningVirtualClock, LARGE_INTEGER* EndingVirtualClock, 
                                  uint RecordTypeMask, void** TxfLogContext);

@DllImport("txfw32")
BOOL TxfLogDestroyReadContext(void* TxfLogContext);

@DllImport("txfw32")
BOOL TxfLogReadRecords(void* TxfLogContext, uint BufferLength, char* Buffer, uint* BytesUsed, uint* RecordCount);

@DllImport("txfw32")
BOOL TxfReadMetadataInfo(HANDLE FileHandle, TXF_ID* TxfFileId, CLS_LSN* LastLsn, uint* TransactionState, 
                         GUID* LockingTransaction);

@DllImport("txfw32")
BOOL TxfLogRecordGetFileName(char* RecordBuffer, uint RecordBufferLengthInBytes, const(wchar)* NameBuffer, 
                             uint* NameBufferLengthInBytes, TXF_ID* TxfId);

@DllImport("txfw32")
BOOL TxfLogRecordGetGenericType(void* RecordBuffer, uint RecordBufferLengthInBytes, uint* GenericType, 
                                LARGE_INTEGER* VirtualClock);

@DllImport("txfw32")
void TxfSetThreadMiniVersionForCreate(ushort MiniVersion);

@DllImport("txfw32")
void TxfGetThreadMiniVersionForCreate(ushort* MiniVersion);

@DllImport("ktmw32")
HANDLE CreateTransaction(SECURITY_ATTRIBUTES* lpTransactionAttributes, GUID* UOW, uint CreateOptions, 
                         uint IsolationLevel, uint IsolationFlags, uint Timeout, const(wchar)* Description);

@DllImport("ktmw32")
HANDLE OpenTransaction(uint dwDesiredAccess, GUID* TransactionId);

@DllImport("ktmw32")
BOOL CommitTransaction(HANDLE TransactionHandle);

@DllImport("ktmw32")
BOOL CommitTransactionAsync(HANDLE TransactionHandle);

@DllImport("ktmw32")
BOOL RollbackTransaction(HANDLE TransactionHandle);

@DllImport("ktmw32")
BOOL RollbackTransactionAsync(HANDLE TransactionHandle);

@DllImport("ktmw32")
BOOL GetTransactionId(HANDLE TransactionHandle, GUID* TransactionId);

@DllImport("ktmw32")
BOOL GetTransactionInformation(HANDLE TransactionHandle, uint* Outcome, uint* IsolationLevel, uint* IsolationFlags, 
                               uint* Timeout, uint BufferLength, const(wchar)* Description);

@DllImport("ktmw32")
BOOL SetTransactionInformation(HANDLE TransactionHandle, uint IsolationLevel, uint IsolationFlags, uint Timeout, 
                               const(wchar)* Description);

@DllImport("ktmw32")
HANDLE CreateTransactionManager(SECURITY_ATTRIBUTES* lpTransactionAttributes, const(wchar)* LogFileName, 
                                uint CreateOptions, uint CommitStrength);

@DllImport("ktmw32")
HANDLE OpenTransactionManager(const(wchar)* LogFileName, uint DesiredAccess, uint OpenOptions);

@DllImport("ktmw32")
HANDLE OpenTransactionManagerById(GUID* TransactionManagerId, uint DesiredAccess, uint OpenOptions);

@DllImport("ktmw32")
BOOL RenameTransactionManager(const(wchar)* LogFileName, GUID* ExistingTransactionManagerGuid);

@DllImport("ktmw32")
BOOL RollforwardTransactionManager(HANDLE TransactionManagerHandle, LARGE_INTEGER* TmVirtualClock);

@DllImport("ktmw32")
BOOL RecoverTransactionManager(HANDLE TransactionManagerHandle);

@DllImport("ktmw32")
BOOL GetCurrentClockTransactionManager(HANDLE TransactionManagerHandle, LARGE_INTEGER* TmVirtualClock);

@DllImport("ktmw32")
BOOL GetTransactionManagerId(HANDLE TransactionManagerHandle, GUID* TransactionManagerId);

@DllImport("ktmw32")
HANDLE CreateResourceManager(SECURITY_ATTRIBUTES* lpResourceManagerAttributes, GUID* ResourceManagerId, 
                             uint CreateOptions, HANDLE TmHandle, const(wchar)* Description);

@DllImport("ktmw32")
HANDLE OpenResourceManager(uint dwDesiredAccess, HANDLE TmHandle, GUID* ResourceManagerId);

@DllImport("ktmw32")
BOOL RecoverResourceManager(HANDLE ResourceManagerHandle);

@DllImport("ktmw32")
BOOL GetNotificationResourceManager(HANDLE ResourceManagerHandle, 
                                    TRANSACTION_NOTIFICATION* TransactionNotification, uint NotificationLength, 
                                    uint dwMilliseconds, uint* ReturnLength);

@DllImport("ktmw32")
BOOL GetNotificationResourceManagerAsync(HANDLE ResourceManagerHandle, 
                                         TRANSACTION_NOTIFICATION* TransactionNotification, 
                                         uint TransactionNotificationLength, uint* ReturnLength, 
                                         OVERLAPPED* lpOverlapped);

@DllImport("ktmw32")
BOOL SetResourceManagerCompletionPort(HANDLE ResourceManagerHandle, HANDLE IoCompletionPortHandle, 
                                      size_t CompletionKey);

@DllImport("ktmw32")
HANDLE CreateEnlistment(SECURITY_ATTRIBUTES* lpEnlistmentAttributes, HANDLE ResourceManagerHandle, 
                        HANDLE TransactionHandle, uint NotificationMask, uint CreateOptions, void* EnlistmentKey);

@DllImport("ktmw32")
HANDLE OpenEnlistment(uint dwDesiredAccess, HANDLE ResourceManagerHandle, GUID* EnlistmentId);

@DllImport("ktmw32")
BOOL RecoverEnlistment(HANDLE EnlistmentHandle, void* EnlistmentKey);

@DllImport("ktmw32")
BOOL GetEnlistmentRecoveryInformation(HANDLE EnlistmentHandle, uint BufferSize, void* Buffer, uint* BufferUsed);

@DllImport("ktmw32")
BOOL GetEnlistmentId(HANDLE EnlistmentHandle, GUID* EnlistmentId);

@DllImport("ktmw32")
BOOL SetEnlistmentRecoveryInformation(HANDLE EnlistmentHandle, uint BufferSize, void* Buffer);

@DllImport("ktmw32")
BOOL PrepareEnlistment(HANDLE EnlistmentHandle, LARGE_INTEGER* TmVirtualClock);

@DllImport("ktmw32")
BOOL PrePrepareEnlistment(HANDLE EnlistmentHandle, LARGE_INTEGER* TmVirtualClock);

@DllImport("ktmw32")
BOOL CommitEnlistment(HANDLE EnlistmentHandle, LARGE_INTEGER* TmVirtualClock);

@DllImport("ktmw32")
BOOL RollbackEnlistment(HANDLE EnlistmentHandle, LARGE_INTEGER* TmVirtualClock);

@DllImport("ktmw32")
BOOL PrePrepareComplete(HANDLE EnlistmentHandle, LARGE_INTEGER* TmVirtualClock);

@DllImport("ktmw32")
BOOL PrepareComplete(HANDLE EnlistmentHandle, LARGE_INTEGER* TmVirtualClock);

@DllImport("ktmw32")
BOOL ReadOnlyEnlistment(HANDLE EnlistmentHandle, LARGE_INTEGER* TmVirtualClock);

@DllImport("ktmw32")
BOOL CommitComplete(HANDLE EnlistmentHandle, LARGE_INTEGER* TmVirtualClock);

@DllImport("ktmw32")
BOOL RollbackComplete(HANDLE EnlistmentHandle, LARGE_INTEGER* TmVirtualClock);

@DllImport("ktmw32")
BOOL SinglePhaseReject(HANDLE EnlistmentHandle, LARGE_INTEGER* TmVirtualClock);

@DllImport("srvcli")
uint NetShareAdd(const(wchar)* servername, uint level, char* buf, uint* parm_err);

@DllImport("srvcli")
uint NetShareEnum(const(wchar)* servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                  uint* totalentries, uint* resume_handle);

@DllImport("srvcli")
uint NetShareEnumSticky(const(wchar)* servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                        uint* totalentries, uint* resume_handle);

@DllImport("srvcli")
uint NetShareGetInfo(const(wchar)* servername, const(wchar)* netname, uint level, ubyte** bufptr);

@DllImport("srvcli")
uint NetShareSetInfo(const(wchar)* servername, const(wchar)* netname, uint level, char* buf, uint* parm_err);

@DllImport("srvcli")
uint NetShareDel(const(wchar)* servername, const(wchar)* netname, uint reserved);

@DllImport("srvcli")
uint NetShareDelSticky(const(wchar)* servername, const(wchar)* netname, uint reserved);

@DllImport("srvcli")
uint NetShareCheck(const(wchar)* servername, const(wchar)* device, uint* type);

@DllImport("srvcli")
uint NetShareDelEx(const(wchar)* servername, uint level, char* buf);

@DllImport("srvcli")
uint NetServerAliasAdd(const(wchar)* servername, uint level, char* buf);

@DllImport("srvcli")
uint NetServerAliasDel(const(wchar)* servername, uint level, char* buf);

@DllImport("srvcli")
uint NetServerAliasEnum(const(wchar)* servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, 
                        uint* totalentries, uint* resumehandle);

@DllImport("srvcli")
uint NetSessionEnum(const(wchar)* servername, const(wchar)* UncClientName, const(wchar)* username, uint level, 
                    ubyte** bufptr, uint prefmaxlen, uint* entriesread, uint* totalentries, uint* resume_handle);

@DllImport("srvcli")
uint NetSessionDel(const(wchar)* servername, const(wchar)* UncClientName, const(wchar)* username);

@DllImport("srvcli")
uint NetSessionGetInfo(const(wchar)* servername, const(wchar)* UncClientName, const(wchar)* username, uint level, 
                       ubyte** bufptr);

@DllImport("srvcli")
uint NetConnectionEnum(const(wchar)* servername, const(wchar)* qualifier, uint level, ubyte** bufptr, 
                       uint prefmaxlen, uint* entriesread, uint* totalentries, uint* resume_handle);

@DllImport("srvcli")
uint NetFileClose(const(wchar)* servername, uint fileid);

@DllImport("srvcli")
uint NetFileEnum(const(wchar)* servername, const(wchar)* basepath, const(wchar)* username, uint level, 
                 ubyte** bufptr, uint prefmaxlen, uint* entriesread, uint* totalentries, size_t* resume_handle);

@DllImport("srvcli")
uint NetFileGetInfo(const(wchar)* servername, uint fileid, uint level, ubyte** bufptr);

@DllImport("NETAPI32")
uint NetStatisticsGet(byte* ServerName, byte* Service, uint Level, uint Options, ubyte** Buffer);

@DllImport("KERNEL32")
uint SearchPathW(const(wchar)* lpPath, const(wchar)* lpFileName, const(wchar)* lpExtension, uint nBufferLength, 
                 const(wchar)* lpBuffer, ushort** lpFilePart);

@DllImport("KERNEL32")
uint SearchPathA(const(char)* lpPath, const(char)* lpFileName, const(char)* lpExtension, uint nBufferLength, 
                 const(char)* lpBuffer, byte** lpFilePart);

@DllImport("KERNEL32")
BOOL GetBinaryTypeA(const(char)* lpApplicationName, uint* lpBinaryType);

@DllImport("KERNEL32")
BOOL GetBinaryTypeW(const(wchar)* lpApplicationName, uint* lpBinaryType);

@DllImport("KERNEL32")
uint GetShortPathNameA(const(char)* lpszLongPath, const(char)* lpszShortPath, uint cchBuffer);

@DllImport("KERNEL32")
uint GetLongPathNameTransactedA(const(char)* lpszShortPath, const(char)* lpszLongPath, uint cchBuffer, 
                                HANDLE hTransaction);

@DllImport("KERNEL32")
uint GetLongPathNameTransactedW(const(wchar)* lpszShortPath, const(wchar)* lpszLongPath, uint cchBuffer, 
                                HANDLE hTransaction);

@DllImport("KERNEL32")
BOOL SetFileCompletionNotificationModes(HANDLE FileHandle, ubyte Flags);

@DllImport("KERNEL32")
BOOL SetFileShortNameA(HANDLE hFile, const(char)* lpShortName);

@DllImport("KERNEL32")
BOOL SetFileShortNameW(HANDLE hFile, const(wchar)* lpShortName);

@DllImport("ADVAPI32")
BOOL EncryptFileA(const(char)* lpFileName);

@DllImport("ADVAPI32")
BOOL EncryptFileW(const(wchar)* lpFileName);

@DllImport("ADVAPI32")
BOOL DecryptFileA(const(char)* lpFileName, uint dwReserved);

@DllImport("ADVAPI32")
BOOL DecryptFileW(const(wchar)* lpFileName, uint dwReserved);

@DllImport("ADVAPI32")
BOOL FileEncryptionStatusA(const(char)* lpFileName, uint* lpStatus);

@DllImport("ADVAPI32")
BOOL FileEncryptionStatusW(const(wchar)* lpFileName, uint* lpStatus);

@DllImport("ADVAPI32")
uint OpenEncryptedFileRawA(const(char)* lpFileName, uint ulFlags, void** pvContext);

@DllImport("ADVAPI32")
uint OpenEncryptedFileRawW(const(wchar)* lpFileName, uint ulFlags, void** pvContext);

@DllImport("ADVAPI32")
uint ReadEncryptedFileRaw(PFE_EXPORT_FUNC pfExportCallback, void* pvCallbackContext, void* pvContext);

@DllImport("ADVAPI32")
uint WriteEncryptedFileRaw(PFE_IMPORT_FUNC pfImportCallback, void* pvCallbackContext, void* pvContext);

@DllImport("ADVAPI32")
void CloseEncryptedFileRaw(void* pvContext);

@DllImport("KERNEL32")
int OpenFile(const(char)* lpFileName, OFSTRUCT* lpReOpenBuff, uint uStyle);

@DllImport("KERNEL32")
uint GetLogicalDriveStringsA(uint nBufferLength, const(char)* lpBuffer);

@DllImport("KERNEL32")
ubyte Wow64EnableWow64FsRedirection(ubyte Wow64FsEnableRedirection);

@DllImport("KERNEL32")
BOOL SetSearchPathMode(uint Flags);

@DllImport("KERNEL32")
BOOL CreateDirectoryExA(const(char)* lpTemplateDirectory, const(char)* lpNewDirectory, 
                        SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("KERNEL32")
BOOL CreateDirectoryExW(const(wchar)* lpTemplateDirectory, const(wchar)* lpNewDirectory, 
                        SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("KERNEL32")
BOOL CreateDirectoryTransactedA(const(char)* lpTemplateDirectory, const(char)* lpNewDirectory, 
                                SECURITY_ATTRIBUTES* lpSecurityAttributes, HANDLE hTransaction);

@DllImport("KERNEL32")
BOOL CreateDirectoryTransactedW(const(wchar)* lpTemplateDirectory, const(wchar)* lpNewDirectory, 
                                SECURITY_ATTRIBUTES* lpSecurityAttributes, HANDLE hTransaction);

@DllImport("KERNEL32")
BOOL RemoveDirectoryTransactedA(const(char)* lpPathName, HANDLE hTransaction);

@DllImport("KERNEL32")
BOOL RemoveDirectoryTransactedW(const(wchar)* lpPathName, HANDLE hTransaction);

@DllImport("KERNEL32")
uint GetFullPathNameTransactedA(const(char)* lpFileName, uint nBufferLength, const(char)* lpBuffer, 
                                byte** lpFilePart, HANDLE hTransaction);

@DllImport("KERNEL32")
uint GetFullPathNameTransactedW(const(wchar)* lpFileName, uint nBufferLength, const(wchar)* lpBuffer, 
                                ushort** lpFilePart, HANDLE hTransaction);

@DllImport("KERNEL32")
BOOL DefineDosDeviceA(uint dwFlags, const(char)* lpDeviceName, const(char)* lpTargetPath);

@DllImport("KERNEL32")
uint QueryDosDeviceA(const(char)* lpDeviceName, const(char)* lpTargetPath, uint ucchMax);

@DllImport("KERNEL32")
HANDLE CreateFileTransactedA(const(char)* lpFileName, uint dwDesiredAccess, uint dwShareMode, 
                             SECURITY_ATTRIBUTES* lpSecurityAttributes, uint dwCreationDisposition, 
                             uint dwFlagsAndAttributes, HANDLE hTemplateFile, HANDLE hTransaction, 
                             ushort* pusMiniVersion, void* lpExtendedParameter);

@DllImport("KERNEL32")
HANDLE CreateFileTransactedW(const(wchar)* lpFileName, uint dwDesiredAccess, uint dwShareMode, 
                             SECURITY_ATTRIBUTES* lpSecurityAttributes, uint dwCreationDisposition, 
                             uint dwFlagsAndAttributes, HANDLE hTemplateFile, HANDLE hTransaction, 
                             ushort* pusMiniVersion, void* lpExtendedParameter);

@DllImport("KERNEL32")
HANDLE ReOpenFile(HANDLE hOriginalFile, uint dwDesiredAccess, uint dwShareMode, uint dwFlagsAndAttributes);

@DllImport("KERNEL32")
BOOL SetFileAttributesTransactedA(const(char)* lpFileName, uint dwFileAttributes, HANDLE hTransaction);

@DllImport("KERNEL32")
BOOL SetFileAttributesTransactedW(const(wchar)* lpFileName, uint dwFileAttributes, HANDLE hTransaction);

@DllImport("KERNEL32")
BOOL GetFileAttributesTransactedA(const(char)* lpFileName, GET_FILEEX_INFO_LEVELS fInfoLevelId, 
                                  char* lpFileInformation, HANDLE hTransaction);

@DllImport("KERNEL32")
BOOL GetFileAttributesTransactedW(const(wchar)* lpFileName, GET_FILEEX_INFO_LEVELS fInfoLevelId, 
                                  char* lpFileInformation, HANDLE hTransaction);

@DllImport("KERNEL32")
uint GetCompressedFileSizeTransactedA(const(char)* lpFileName, uint* lpFileSizeHigh, HANDLE hTransaction);

@DllImport("KERNEL32")
uint GetCompressedFileSizeTransactedW(const(wchar)* lpFileName, uint* lpFileSizeHigh, HANDLE hTransaction);

@DllImport("KERNEL32")
BOOL DeleteFileTransactedA(const(char)* lpFileName, HANDLE hTransaction);

@DllImport("KERNEL32")
BOOL DeleteFileTransactedW(const(wchar)* lpFileName, HANDLE hTransaction);

@DllImport("KERNEL32")
BOOL CheckNameLegalDOS8Dot3A(const(char)* lpName, const(char)* lpOemName, uint OemNameSize, 
                             int* pbNameContainsSpaces, int* pbNameLegal);

@DllImport("KERNEL32")
BOOL CheckNameLegalDOS8Dot3W(const(wchar)* lpName, const(char)* lpOemName, uint OemNameSize, 
                             int* pbNameContainsSpaces, int* pbNameLegal);

@DllImport("KERNEL32")
FindFileHandle FindFirstFileTransactedA(const(char)* lpFileName, FINDEX_INFO_LEVELS fInfoLevelId, 
                                        char* lpFindFileData, FINDEX_SEARCH_OPS fSearchOp, void* lpSearchFilter, 
                                        uint dwAdditionalFlags, HANDLE hTransaction);

@DllImport("KERNEL32")
FindFileHandle FindFirstFileTransactedW(const(wchar)* lpFileName, FINDEX_INFO_LEVELS fInfoLevelId, 
                                        char* lpFindFileData, FINDEX_SEARCH_OPS fSearchOp, void* lpSearchFilter, 
                                        uint dwAdditionalFlags, HANDLE hTransaction);

@DllImport("KERNEL32")
BOOL CopyFileA(const(char)* lpExistingFileName, const(char)* lpNewFileName, BOOL bFailIfExists);

@DllImport("KERNEL32")
BOOL CopyFileW(const(wchar)* lpExistingFileName, const(wchar)* lpNewFileName, BOOL bFailIfExists);

@DllImport("KERNEL32")
BOOL CopyFileExA(const(char)* lpExistingFileName, const(char)* lpNewFileName, LPPROGRESS_ROUTINE lpProgressRoutine, 
                 void* lpData, int* pbCancel, uint dwCopyFlags);

@DllImport("KERNEL32")
BOOL CopyFileExW(const(wchar)* lpExistingFileName, const(wchar)* lpNewFileName, 
                 LPPROGRESS_ROUTINE lpProgressRoutine, void* lpData, int* pbCancel, uint dwCopyFlags);

@DllImport("KERNEL32")
BOOL CopyFileTransactedA(const(char)* lpExistingFileName, const(char)* lpNewFileName, 
                         LPPROGRESS_ROUTINE lpProgressRoutine, void* lpData, int* pbCancel, uint dwCopyFlags, 
                         HANDLE hTransaction);

@DllImport("KERNEL32")
BOOL CopyFileTransactedW(const(wchar)* lpExistingFileName, const(wchar)* lpNewFileName, 
                         LPPROGRESS_ROUTINE lpProgressRoutine, void* lpData, int* pbCancel, uint dwCopyFlags, 
                         HANDLE hTransaction);

@DllImport("KERNEL32")
HRESULT CopyFile2(const(wchar)* pwszExistingFileName, const(wchar)* pwszNewFileName, 
                  COPYFILE2_EXTENDED_PARAMETERS* pExtendedParameters);

@DllImport("KERNEL32")
BOOL MoveFileA(const(char)* lpExistingFileName, const(char)* lpNewFileName);

@DllImport("KERNEL32")
BOOL MoveFileW(const(wchar)* lpExistingFileName, const(wchar)* lpNewFileName);

@DllImport("KERNEL32")
BOOL MoveFileExA(const(char)* lpExistingFileName, const(char)* lpNewFileName, uint dwFlags);

@DllImport("KERNEL32")
BOOL MoveFileExW(const(wchar)* lpExistingFileName, const(wchar)* lpNewFileName, uint dwFlags);

@DllImport("KERNEL32")
BOOL MoveFileWithProgressA(const(char)* lpExistingFileName, const(char)* lpNewFileName, 
                           LPPROGRESS_ROUTINE lpProgressRoutine, void* lpData, uint dwFlags);

@DllImport("KERNEL32")
BOOL MoveFileWithProgressW(const(wchar)* lpExistingFileName, const(wchar)* lpNewFileName, 
                           LPPROGRESS_ROUTINE lpProgressRoutine, void* lpData, uint dwFlags);

@DllImport("KERNEL32")
BOOL MoveFileTransactedA(const(char)* lpExistingFileName, const(char)* lpNewFileName, 
                         LPPROGRESS_ROUTINE lpProgressRoutine, void* lpData, uint dwFlags, HANDLE hTransaction);

@DllImport("KERNEL32")
BOOL MoveFileTransactedW(const(wchar)* lpExistingFileName, const(wchar)* lpNewFileName, 
                         LPPROGRESS_ROUTINE lpProgressRoutine, void* lpData, uint dwFlags, HANDLE hTransaction);

@DllImport("KERNEL32")
BOOL ReplaceFileA(const(char)* lpReplacedFileName, const(char)* lpReplacementFileName, 
                  const(char)* lpBackupFileName, uint dwReplaceFlags, void* lpExclude, void* lpReserved);

@DllImport("KERNEL32")
BOOL ReplaceFileW(const(wchar)* lpReplacedFileName, const(wchar)* lpReplacementFileName, 
                  const(wchar)* lpBackupFileName, uint dwReplaceFlags, void* lpExclude, void* lpReserved);

@DllImport("KERNEL32")
BOOL CreateHardLinkA(const(char)* lpFileName, const(char)* lpExistingFileName, 
                     SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("KERNEL32")
BOOL CreateHardLinkW(const(wchar)* lpFileName, const(wchar)* lpExistingFileName, 
                     SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("KERNEL32")
BOOL CreateHardLinkTransactedA(const(char)* lpFileName, const(char)* lpExistingFileName, 
                               SECURITY_ATTRIBUTES* lpSecurityAttributes, HANDLE hTransaction);

@DllImport("KERNEL32")
BOOL CreateHardLinkTransactedW(const(wchar)* lpFileName, const(wchar)* lpExistingFileName, 
                               SECURITY_ATTRIBUTES* lpSecurityAttributes, HANDLE hTransaction);

@DllImport("KERNEL32")
FindStreamHandle FindFirstStreamTransactedW(const(wchar)* lpFileName, STREAM_INFO_LEVELS InfoLevel, 
                                            char* lpFindStreamData, uint dwFlags, HANDLE hTransaction);

@DllImport("KERNEL32")
FindFileNameHandle FindFirstFileNameTransactedW(const(wchar)* lpFileName, uint dwFlags, uint* StringLength, 
                                                const(wchar)* LinkName, HANDLE hTransaction);

@DllImport("KERNEL32")
BOOL SetVolumeLabelA(const(char)* lpRootPathName, const(char)* lpVolumeName);

@DllImport("KERNEL32")
BOOL SetVolumeLabelW(const(wchar)* lpRootPathName, const(wchar)* lpVolumeName);

@DllImport("KERNEL32")
BOOL SetFileBandwidthReservation(HANDLE hFile, uint nPeriodMilliseconds, uint nBytesPerPeriod, BOOL bDiscardable, 
                                 uint* lpTransferSize, uint* lpNumOutstandingRequests);

@DllImport("KERNEL32")
BOOL GetFileBandwidthReservation(HANDLE hFile, uint* lpPeriodMilliseconds, uint* lpBytesPerPeriod, 
                                 int* pDiscardable, uint* lpTransferSize, uint* lpNumOutstandingRequests);

@DllImport("KERNEL32")
BOOL ReadDirectoryChangesW(HANDLE hDirectory, char* lpBuffer, uint nBufferLength, BOOL bWatchSubtree, 
                           uint dwNotifyFilter, uint* lpBytesReturned, OVERLAPPED* lpOverlapped, 
                           LPOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

@DllImport("KERNEL32")
BOOL ReadDirectoryChangesExW(HANDLE hDirectory, char* lpBuffer, uint nBufferLength, BOOL bWatchSubtree, 
                             uint dwNotifyFilter, uint* lpBytesReturned, OVERLAPPED* lpOverlapped, 
                             LPOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine, 
                             READ_DIRECTORY_NOTIFY_INFORMATION_CLASS ReadDirectoryNotifyInformationClass);

@DllImport("KERNEL32")
FindVolumeHandle FindFirstVolumeA(const(char)* lpszVolumeName, uint cchBufferLength);

@DllImport("KERNEL32")
BOOL FindNextVolumeA(FindVolumeHandle hFindVolume, const(char)* lpszVolumeName, uint cchBufferLength);

@DllImport("KERNEL32")
FindVolumeMointPointHandle FindFirstVolumeMountPointA(const(char)* lpszRootPathName, 
                                                      const(char)* lpszVolumeMountPoint, uint cchBufferLength);

@DllImport("KERNEL32")
FindVolumeMointPointHandle FindFirstVolumeMountPointW(const(wchar)* lpszRootPathName, 
                                                      const(wchar)* lpszVolumeMountPoint, uint cchBufferLength);

@DllImport("KERNEL32")
BOOL FindNextVolumeMountPointA(FindVolumeMointPointHandle hFindVolumeMountPoint, const(char)* lpszVolumeMountPoint, 
                               uint cchBufferLength);

@DllImport("KERNEL32")
BOOL FindNextVolumeMountPointW(FindVolumeMointPointHandle hFindVolumeMountPoint, 
                               const(wchar)* lpszVolumeMountPoint, uint cchBufferLength);

@DllImport("KERNEL32")
BOOL FindVolumeMountPointClose(FindVolumeMointPointHandle hFindVolumeMountPoint);

@DllImport("KERNEL32")
BOOL SetVolumeMountPointA(const(char)* lpszVolumeMountPoint, const(char)* lpszVolumeName);

@DllImport("KERNEL32")
BOOL SetVolumeMountPointW(const(wchar)* lpszVolumeMountPoint, const(wchar)* lpszVolumeName);

@DllImport("KERNEL32")
BOOL DeleteVolumeMountPointA(const(char)* lpszVolumeMountPoint);

@DllImport("KERNEL32")
BOOL GetVolumeNameForVolumeMountPointA(const(char)* lpszVolumeMountPoint, const(char)* lpszVolumeName, 
                                       uint cchBufferLength);

@DllImport("KERNEL32")
BOOL GetVolumePathNameA(const(char)* lpszFileName, const(char)* lpszVolumePathName, uint cchBufferLength);

@DllImport("KERNEL32")
BOOL GetVolumePathNamesForVolumeNameA(const(char)* lpszVolumeName, const(char)* lpszVolumePathNames, 
                                      uint cchBufferLength, uint* lpcchReturnLength);

@DllImport("KERNEL32")
BOOL GetFileInformationByHandleEx(HANDLE hFile, FILE_INFO_BY_HANDLE_CLASS FileInformationClass, 
                                  char* lpFileInformation, uint dwBufferSize);

@DllImport("KERNEL32")
HANDLE OpenFileById(HANDLE hVolumeHint, FILE_ID_DESCRIPTOR* lpFileId, uint dwDesiredAccess, uint dwShareMode, 
                    SECURITY_ATTRIBUTES* lpSecurityAttributes, uint dwFlagsAndAttributes);

@DllImport("KERNEL32")
ubyte CreateSymbolicLinkA(const(char)* lpSymlinkFileName, const(char)* lpTargetFileName, uint dwFlags);

@DllImport("KERNEL32")
ubyte CreateSymbolicLinkW(const(wchar)* lpSymlinkFileName, const(wchar)* lpTargetFileName, uint dwFlags);

@DllImport("KERNEL32")
ubyte CreateSymbolicLinkTransactedA(const(char)* lpSymlinkFileName, const(char)* lpTargetFileName, uint dwFlags, 
                                    HANDLE hTransaction);

@DllImport("KERNEL32")
ubyte CreateSymbolicLinkTransactedW(const(wchar)* lpSymlinkFileName, const(wchar)* lpTargetFileName, uint dwFlags, 
                                    HANDLE hTransaction);


// Interfaces

@GUID("7988B574-EC89-11CF-9C00-00AA00A14F56")
interface IDiskQuotaUser : IUnknown
{
    HRESULT GetID(uint* pulID);
    HRESULT GetName(const(wchar)* pszAccountContainer, uint cchAccountContainer, const(wchar)* pszLogonName, 
                    uint cchLogonName, const(wchar)* pszDisplayName, uint cchDisplayName);
    HRESULT GetSidLength(uint* pdwLength);
    HRESULT GetSid(ubyte* pbSidBuffer, uint cbSidBuffer);
    HRESULT GetQuotaThreshold(long* pllThreshold);
    HRESULT GetQuotaThresholdText(const(wchar)* pszText, uint cchText);
    HRESULT GetQuotaLimit(long* pllLimit);
    HRESULT GetQuotaLimitText(const(wchar)* pszText, uint cchText);
    HRESULT GetQuotaUsed(long* pllUsed);
    HRESULT GetQuotaUsedText(const(wchar)* pszText, uint cchText);
    HRESULT GetQuotaInformation(void* pbQuotaInfo, uint cbQuotaInfo);
    HRESULT SetQuotaThreshold(long llThreshold, BOOL fWriteThrough);
    HRESULT SetQuotaLimit(long llLimit, BOOL fWriteThrough);
    HRESULT Invalidate();
    HRESULT GetAccountStatus(uint* pdwStatus);
}

@GUID("7988B577-EC89-11CF-9C00-00AA00A14F56")
interface IEnumDiskQuotaUsers : IUnknown
{
    HRESULT Next(uint cUsers, IDiskQuotaUser* rgUsers, uint* pcUsersFetched);
    HRESULT Skip(uint cUsers);
    HRESULT Reset();
    HRESULT Clone(IEnumDiskQuotaUsers* ppEnum);
}

@GUID("7988B576-EC89-11CF-9C00-00AA00A14F56")
interface IDiskQuotaUserBatch : IUnknown
{
    HRESULT Add(IDiskQuotaUser pUser);
    HRESULT Remove(IDiskQuotaUser pUser);
    HRESULT RemoveAll();
    HRESULT FlushToDisk();
}

@GUID("7988B572-EC89-11CF-9C00-00AA00A14F56")
interface IDiskQuotaControl : IConnectionPointContainer
{
    HRESULT Initialize(const(wchar)* pszPath, BOOL bReadWrite);
    HRESULT SetQuotaState(uint dwState);
    HRESULT GetQuotaState(uint* pdwState);
    HRESULT SetQuotaLogFlags(uint dwFlags);
    HRESULT GetQuotaLogFlags(uint* pdwFlags);
    HRESULT SetDefaultQuotaThreshold(long llThreshold);
    HRESULT GetDefaultQuotaThreshold(long* pllThreshold);
    HRESULT GetDefaultQuotaThresholdText(const(wchar)* pszText, uint cchText);
    HRESULT SetDefaultQuotaLimit(long llLimit);
    HRESULT GetDefaultQuotaLimit(long* pllLimit);
    HRESULT GetDefaultQuotaLimitText(const(wchar)* pszText, uint cchText);
    HRESULT AddUserSid(void* pUserSid, uint fNameResolution, IDiskQuotaUser* ppUser);
    HRESULT AddUserName(const(wchar)* pszLogonName, uint fNameResolution, IDiskQuotaUser* ppUser);
    HRESULT DeleteUser(IDiskQuotaUser pUser);
    HRESULT FindUserSid(void* pUserSid, uint fNameResolution, IDiskQuotaUser* ppUser);
    HRESULT FindUserName(const(wchar)* pszLogonName, IDiskQuotaUser* ppUser);
    HRESULT CreateEnumUsers(void** rgpUserSids, uint cpSids, uint fNameResolution, IEnumDiskQuotaUsers* ppEnum);
    HRESULT CreateUserBatch(IDiskQuotaUserBatch* ppBatch);
    HRESULT InvalidateSidNameCache();
    HRESULT GiveUserNameResolutionPriority(IDiskQuotaUser pUser);
    HRESULT ShutdownNameResolution();
}

@GUID("7988B579-EC89-11CF-9C00-00AA00A14F56")
interface IDiskQuotaEvents : IUnknown
{
    HRESULT OnUserNameChanged(IDiskQuotaUser pUser);
}


// GUIDs


const GUID IID_IDiskQuotaControl   = GUIDOF!IDiskQuotaControl;
const GUID IID_IDiskQuotaEvents    = GUIDOF!IDiskQuotaEvents;
const GUID IID_IDiskQuotaUser      = GUIDOF!IDiskQuotaUser;
const GUID IID_IDiskQuotaUserBatch = GUIDOF!IDiskQuotaUserBatch;
const GUID IID_IEnumDiskQuotaUsers = GUIDOF!IEnumDiskQuotaUsers;
