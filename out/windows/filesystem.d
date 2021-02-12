module windows.filesystem;

public import system;
public import windows.com;
public import windows.security;
public import windows.systemservices;
public import windows.windowsprogramming;

extern(Windows):

enum FIND_FIRST_EX_FLAGS
{
    FIND_FIRST_EX_CASE_SENSITIVE = 1,
    FIND_FIRST_EX_LARGE_FETCH = 2,
    FIND_FIRST_EX_ON_DISK_ENTRIES_ONLY = 4,
}

enum FILE_NOTIFY_CHANGE
{
    FILE_NOTIFY_CHANGE_FILE_NAME = 1,
    FILE_NOTIFY_CHANGE_DIR_NAME = 2,
    FILE_NOTIFY_CHANGE_ATTRIBUTES = 4,
    FILE_NOTIFY_CHANGE_SIZE = 8,
    FILE_NOTIFY_CHANGE_LAST_WRITE = 16,
    FILE_NOTIFY_CHANGE_LAST_ACCESS = 32,
    FILE_NOTIFY_CHANGE_CREATION = 64,
    FILE_NOTIFY_CHANGE_SECURITY = 256,
}

enum DEFINE_DOS_DEVICE_FLAGS
{
    DDD_RAW_TARGET_PATH = 1,
    DDD_REMOVE_DEFINITION = 2,
    DDD_EXACT_MATCH_ON_REMOVE = 4,
    DDD_NO_BROADCAST_SYSTEM = 8,
    DDD_LUID_BROADCAST_DRIVE = 16,
}

enum FILE_CREATE_FLAGS
{
    CREATE_NEW = 1,
    CREATE_ALWAYS = 2,
    OPEN_EXISTING = 3,
    OPEN_ALWAYS = 4,
    TRUNCATE_EXISTING = 5,
}

enum FILE_SHARE_FLAGS
{
    FILE_SHARE_NONE = 0,
    FILE_SHARE_DELETE = 4,
    FILE_SHARE_READ = 1,
    FILE_SHARE_WRITE = 2,
}

enum FILE_FLAGS_AND_ATTRIBUTES
{
    FILE_ATTRIBUTE_READONLY = 1,
    FILE_ATTRIBUTE_HIDDEN = 2,
    FILE_ATTRIBUTE_SYSTEM = 4,
    FILE_ATTRIBUTE_DIRECTORY = 16,
    FILE_ATTRIBUTE_ARCHIVE = 32,
    FILE_ATTRIBUTE_DEVICE = 64,
    FILE_ATTRIBUTE_NORMAL = 128,
    FILE_ATTRIBUTE_TEMPORARY = 256,
    FILE_ATTRIBUTE_SPARSE_FILE = 512,
    FILE_ATTRIBUTE_REPARSE_POINT = 1024,
    FILE_ATTRIBUTE_COMPRESSED = 2048,
    FILE_ATTRIBUTE_OFFLINE = 4096,
    FILE_ATTRIBUTE_NOT_CONTENT_INDEXED = 8192,
    FILE_ATTRIBUTE_ENCRYPTED = 16384,
    FILE_ATTRIBUTE_INTEGRITY_STREAM = 32768,
    FILE_ATTRIBUTE_VIRTUAL = 65536,
    FILE_ATTRIBUTE_NO_SCRUB_DATA = 131072,
    FILE_ATTRIBUTE_EA = 262144,
    FILE_ATTRIBUTE_PINNED = 524288,
    FILE_ATTRIBUTE_UNPINNED = 1048576,
    FILE_ATTRIBUTE_RECALL_ON_OPEN = 262144,
    FILE_ATTRIBUTE_RECALL_ON_DATA_ACCESS = 4194304,
}

enum FILE_ACCESS_FLAGS
{
    FILE_READ_DATA = 1,
    FILE_LIST_DIRECTORY = 1,
    FILE_WRITE_DATA = 2,
    FILE_ADD_FILE = 2,
    FILE_APPEND_DATA = 4,
    FILE_ADD_SUBDIRECTORY = 4,
    FILE_CREATE_PIPE_INSTANCE = 4,
    FILE_READ_EA = 8,
    FILE_WRITE_EA = 16,
    FILE_EXECUTE = 32,
    FILE_TRAVERSE = 32,
    FILE_DELETE_CHILD = 64,
    FILE_READ_ATTRIBUTES = 128,
    FILE_WRITE_ATTRIBUTES = 256,
    READ_CONTROL = 131072,
    SYNCHRONIZE = 1048576,
    STANDARD_RIGHTS_REQUIRED = 983040,
    STANDARD_RIGHTS_READ = 131072,
    STANDARD_RIGHTS_WRITE = 131072,
    STANDARD_RIGHTS_EXECUTE = 131072,
    STANDARD_RIGHTS_ALL = 2031616,
    SPECIFIC_RIGHTS_ALL = 65535,
    FILE_ALL_ACCESS = 2032127,
    FILE_GENERIC_READ = 1179785,
    FILE_GENERIC_WRITE = 1179926,
    FILE_GENERIC_EXECUTE = 1179808,
}

alias FindChangeNotifcationHandle = int;
alias FindFileHandle = int;
alias FindFileNameHandle = int;
alias FindStreamHandle = int;
alias FindVolumeHandle = int;
alias FindVolumeMointPointHandle = int;
struct FILE_ID_128
{
    ubyte Identifier;
}

struct FILE_NOTIFY_INFORMATION
{
    uint NextEntryOffset;
    uint Action;
    uint FileNameLength;
    ushort FileName;
}

struct FILE_NOTIFY_EXTENDED_INFORMATION
{
    uint NextEntryOffset;
    uint Action;
    LARGE_INTEGER CreationTime;
    LARGE_INTEGER LastModificationTime;
    LARGE_INTEGER LastChangeTime;
    LARGE_INTEGER LastAccessTime;
    LARGE_INTEGER AllocatedLength;
    LARGE_INTEGER FileSize;
    uint FileAttributes;
    uint ReparsePointTag;
    LARGE_INTEGER FileId;
    LARGE_INTEGER ParentFileId;
    uint FileNameLength;
    ushort FileName;
}

struct REPARSE_GUID_DATA_BUFFER
{
    uint ReparseTag;
    ushort ReparseDataLength;
    ushort Reserved;
    Guid ReparseGuid;
    _GenericReparseBuffer_e__Struct GenericReparseBuffer;
}

enum TRANSACTION_OUTCOME
{
    TransactionOutcomeUndetermined = 1,
    TransactionOutcomeCommitted = 2,
    TransactionOutcomeAborted = 3,
}

struct OVERLAPPED_ENTRY
{
    uint lpCompletionKey;
    OVERLAPPED* lpOverlapped;
    uint Internal;
    uint dwNumberOfBytesTransferred;
}

struct WIN32_FIND_DATAA
{
    uint dwFileAttributes;
    FILETIME ftCreationTime;
    FILETIME ftLastAccessTime;
    FILETIME ftLastWriteTime;
    uint nFileSizeHigh;
    uint nFileSizeLow;
    uint dwReserved0;
    uint dwReserved1;
    byte cFileName;
    byte cAlternateFileName;
}

struct WIN32_FIND_DATAW
{
    uint dwFileAttributes;
    FILETIME ftCreationTime;
    FILETIME ftLastAccessTime;
    FILETIME ftLastWriteTime;
    uint nFileSizeHigh;
    uint nFileSizeLow;
    uint dwReserved0;
    uint dwReserved1;
    ushort cFileName;
    ushort cAlternateFileName;
}

enum FINDEX_INFO_LEVELS
{
    FindExInfoStandard = 0,
    FindExInfoBasic = 1,
    FindExInfoMaxInfoLevel = 2,
}

enum FINDEX_SEARCH_OPS
{
    FindExSearchNameMatch = 0,
    FindExSearchLimitToDirectories = 1,
    FindExSearchLimitToDevices = 2,
    FindExSearchMaxSearchOp = 3,
}

enum READ_DIRECTORY_NOTIFY_INFORMATION_CLASS
{
    ReadDirectoryNotifyInformation = 1,
    ReadDirectoryNotifyExtendedInformation = 2,
}

enum GET_FILEEX_INFO_LEVELS
{
    GetFileExInfoStandard = 0,
    GetFileExMaxInfoLevel = 1,
}

enum FILE_INFO_BY_HANDLE_CLASS
{
    FileBasicInfo = 0,
    FileStandardInfo = 1,
    FileNameInfo = 2,
    FileRenameInfo = 3,
    FileDispositionInfo = 4,
    FileAllocationInfo = 5,
    FileEndOfFileInfo = 6,
    FileStreamInfo = 7,
    FileCompressionInfo = 8,
    FileAttributeTagInfo = 9,
    FileIdBothDirectoryInfo = 10,
    FileIdBothDirectoryRestartInfo = 11,
    FileIoPriorityHintInfo = 12,
    FileRemoteProtocolInfo = 13,
    FileFullDirectoryInfo = 14,
    FileFullDirectoryRestartInfo = 15,
    FileStorageInfo = 16,
    FileAlignmentInfo = 17,
    FileIdInfo = 18,
    FileIdExtdDirectoryInfo = 19,
    FileIdExtdDirectoryRestartInfo = 20,
    FileDispositionInfoEx = 21,
    FileRenameInfoEx = 22,
    FileCaseSensitiveInfo = 23,
    FileNormalizedNameInfo = 24,
    MaximumFileInfoByHandleClass = 25,
}

alias LPOVERLAPPED_COMPLETION_ROUTINE = extern(Windows) void function(uint dwErrorCode, uint dwNumberOfBytesTransfered, OVERLAPPED* lpOverlapped);
enum STORAGE_QUERY_TYPE
{
    PropertyStandardQuery = 0,
    PropertyExistsQuery = 1,
    PropertyMaskQuery = 2,
    PropertyQueryMaxDefined = 3,
}

enum STORAGE_PROPERTY_ID
{
    StorageDeviceProperty = 0,
    StorageAdapterProperty = 1,
    StorageDeviceIdProperty = 2,
    StorageDeviceUniqueIdProperty = 3,
    StorageDeviceWriteCacheProperty = 4,
    StorageMiniportProperty = 5,
    StorageAccessAlignmentProperty = 6,
    StorageDeviceSeekPenaltyProperty = 7,
    StorageDeviceTrimProperty = 8,
    StorageDeviceWriteAggregationProperty = 9,
    StorageDeviceDeviceTelemetryProperty = 10,
    StorageDeviceLBProvisioningProperty = 11,
    StorageDevicePowerProperty = 12,
    StorageDeviceCopyOffloadProperty = 13,
    StorageDeviceResiliencyProperty = 14,
    StorageDeviceMediumProductType = 15,
    StorageAdapterRpmbProperty = 16,
    StorageAdapterCryptoProperty = 17,
    StorageDeviceIoCapabilityProperty = 48,
    StorageAdapterProtocolSpecificProperty = 49,
    StorageDeviceProtocolSpecificProperty = 50,
    StorageAdapterTemperatureProperty = 51,
    StorageDeviceTemperatureProperty = 52,
    StorageAdapterPhysicalTopologyProperty = 53,
    StorageDevicePhysicalTopologyProperty = 54,
    StorageDeviceAttributesProperty = 55,
    StorageDeviceManagementStatus = 56,
    StorageAdapterSerialNumberProperty = 57,
    StorageDeviceLocationProperty = 58,
    StorageDeviceNumaProperty = 59,
    StorageDeviceZonedDeviceProperty = 60,
    StorageDeviceUnsafeShutdownCount = 61,
    StorageDeviceEnduranceProperty = 62,
}

struct STORAGE_PROPERTY_QUERY
{
    STORAGE_PROPERTY_ID PropertyId;
    STORAGE_QUERY_TYPE QueryType;
    ubyte AdditionalParameters;
}

struct STORAGE_DESCRIPTOR_HEADER
{
    uint Version;
    uint Size;
}

struct STORAGE_DEVICE_DESCRIPTOR
{
    uint Version;
    uint Size;
    ubyte DeviceType;
    ubyte DeviceTypeModifier;
    ubyte RemovableMedia;
    ubyte CommandQueueing;
    uint VendorIdOffset;
    uint ProductIdOffset;
    uint ProductRevisionOffset;
    uint SerialNumberOffset;
    STORAGE_BUS_TYPE BusType;
    uint RawPropertiesLength;
    ubyte RawDeviceProperties;
}

struct STORAGE_ADAPTER_DESCRIPTOR
{
    uint Version;
    uint Size;
    uint MaximumTransferLength;
    uint MaximumPhysicalPages;
    uint AlignmentMask;
    ubyte AdapterUsesPio;
    ubyte AdapterScansDown;
    ubyte CommandQueueing;
    ubyte AcceleratedTransfer;
    ubyte BusType;
    ushort BusMajorVersion;
    ushort BusMinorVersion;
    ubyte SrbType;
    ubyte AddressType;
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

enum STORAGE_PORT_CODE_SET
{
    StoragePortCodeSetReserved = 0,
    StoragePortCodeSetStorport = 1,
    StoragePortCodeSetSCSIport = 2,
    StoragePortCodeSetSpaceport = 3,
    StoragePortCodeSetATAport = 4,
    StoragePortCodeSetUSBport = 5,
    StoragePortCodeSetSBP2port = 6,
    StoragePortCodeSetSDport = 7,
}

struct STORAGE_MINIPORT_DESCRIPTOR
{
    uint Version;
    uint Size;
    STORAGE_PORT_CODE_SET Portdriver;
    ubyte LUNResetSupported;
    ubyte TargetResetSupported;
    ushort IoTimeoutValue;
    ubyte ExtraIoInfoSupported;
    ubyte Reserved0;
    uint Reserved1;
}

struct STORAGE_DEVICE_ID_DESCRIPTOR
{
    uint Version;
    uint Size;
    uint NumberOfIdentifiers;
    ubyte Identifiers;
}

struct DEVICE_SEEK_PENALTY_DESCRIPTOR
{
    uint Version;
    uint Size;
    ubyte IncursSeekPenalty;
}

struct DEVICE_WRITE_AGGREGATION_DESCRIPTOR
{
    uint Version;
    uint Size;
    ubyte BenefitsFromWriteAggregation;
}

struct DEVICE_TRIM_DESCRIPTOR
{
    uint Version;
    uint Size;
    ubyte TrimEnabled;
}

struct DEVICE_LB_PROVISIONING_DESCRIPTOR
{
    uint Version;
    uint Size;
    ubyte _bitfield;
    ubyte Reserved1;
    ulong OptimalUnmapGranularity;
    ulong UnmapGranularityAlignment;
    uint MaxUnmapLbaCount;
    uint MaxUnmapBlockDescriptorCount;
}

struct DEVICE_POWER_DESCRIPTOR
{
    uint Version;
    uint Size;
    ubyte DeviceAttentionSupported;
    ubyte AsynchronousNotificationSupported;
    ubyte IdlePowerManagementEnabled;
    ubyte D3ColdEnabled;
    ubyte D3ColdSupported;
    ubyte NoVerifyDuringIdlePower;
    ubyte Reserved;
    uint IdleTimeoutInMS;
}

struct DEVICE_COPY_OFFLOAD_DESCRIPTOR
{
    uint Version;
    uint Size;
    uint MaximumTokenLifetime;
    uint DefaultTokenLifetime;
    ulong MaximumTransferSize;
    ulong OptimalTransferCount;
    uint MaximumDataDescriptors;
    uint MaximumTransferLengthPerDescriptor;
    uint OptimalTransferLengthPerDescriptor;
    ushort OptimalTransferLengthGranularity;
    ubyte Reserved;
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

enum STORAGE_PROTOCOL_TYPE
{
    ProtocolTypeUnknown = 0,
    ProtocolTypeScsi = 1,
    ProtocolTypeAta = 2,
    ProtocolTypeNvme = 3,
    ProtocolTypeSd = 4,
    ProtocolTypeUfs = 5,
    ProtocolTypeProprietary = 126,
    ProtocolTypeMaxReserved = 127,
}

enum STORAGE_PROTOCOL_NVME_DATA_TYPE
{
    NVMeDataTypeUnknown = 0,
    NVMeDataTypeIdentify = 1,
    NVMeDataTypeLogPage = 2,
    NVMeDataTypeFeature = 3,
}

enum STORAGE_PROTOCOL_ATA_DATA_TYPE
{
    AtaDataTypeUnknown = 0,
    AtaDataTypeIdentify = 1,
    AtaDataTypeLogPage = 2,
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
    short Temperature;
    short OverThreshold;
    short UnderThreshold;
    ubyte OverThresholdChangable;
    ubyte UnderThresholdChangable;
    ubyte EventGenerated;
    ubyte Reserved0;
    uint Reserved1;
}

struct STORAGE_TEMPERATURE_DATA_DESCRIPTOR
{
    uint Version;
    uint Size;
    short CriticalTemperature;
    short WarningTemperature;
    ushort InfoCount;
    ubyte Reserved0;
    uint Reserved1;
    STORAGE_TEMPERATURE_INFO TemperatureInfo;
}

struct STORAGE_TEMPERATURE_THRESHOLD
{
    uint Version;
    uint Size;
    ushort Flags;
    ushort Index;
    short Threshold;
    ubyte OverThreshold;
    ubyte Reserved;
}

enum STORAGE_DEVICE_FORM_FACTOR
{
    FormFactorUnknown = 0,
    FormFactor3_5 = 1,
    FormFactor2_5 = 2,
    FormFactor1_8 = 3,
    FormFactor1_8Less = 4,
    FormFactorEmbedded = 5,
    FormFactorMemoryCard = 6,
    FormFactormSata = 7,
    FormFactorM_2 = 8,
    FormFactorPCIeBoard = 9,
    FormFactorDimm = 10,
}

enum STORAGE_COMPONENT_HEALTH_STATUS
{
    HealthStatusUnknown = 0,
    HealthStatusNormal = 1,
    HealthStatusThrottled = 2,
    HealthStatusWarning = 3,
    HealthStatusDisabled = 4,
    HealthStatusFailed = 5,
}

struct STORAGE_SPEC_VERSION
{
    _Anonymous_e__Struct Anonymous;
    uint AsUlong;
}

struct STORAGE_PHYSICAL_DEVICE_DATA
{
    uint DeviceId;
    uint Role;
    STORAGE_COMPONENT_HEALTH_STATUS HealthStatus;
    STORAGE_PROTOCOL_TYPE CommandProtocol;
    STORAGE_SPEC_VERSION SpecVersion;
    STORAGE_DEVICE_FORM_FACTOR FormFactor;
    ubyte Vendor;
    ubyte Model;
    ubyte FirmwareRevision;
    ulong Capacity;
    ubyte PhysicalLocation;
    uint Reserved;
}

struct STORAGE_PHYSICAL_ADAPTER_DATA
{
    uint AdapterId;
    STORAGE_COMPONENT_HEALTH_STATUS HealthStatus;
    STORAGE_PROTOCOL_TYPE CommandProtocol;
    STORAGE_SPEC_VERSION SpecVersion;
    ubyte Vendor;
    ubyte Model;
    ubyte FirmwareRevision;
    ubyte PhysicalLocation;
    ubyte ExpanderConnected;
    ubyte Reserved0;
    uint Reserved1;
}

struct STORAGE_PHYSICAL_NODE_DATA
{
    uint NodeId;
    uint AdapterCount;
    uint AdapterDataLength;
    uint AdapterDataOffset;
    uint DeviceCount;
    uint DeviceDataLength;
    uint DeviceDataOffset;
    uint Reserved;
}

struct STORAGE_PHYSICAL_TOPOLOGY_DESCRIPTOR
{
    uint Version;
    uint Size;
    uint NodeCount;
    uint Reserved;
    STORAGE_PHYSICAL_NODE_DATA Node;
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
    uint Version;
    uint Size;
    ulong Attributes;
}

struct STORAGE_ADAPTER_SERIAL_NUMBER
{
    uint Version;
    uint Size;
    ushort SerialNumber;
}

enum WRITE_CACHE_TYPE
{
    WriteCacheTypeUnknown = 0,
    WriteCacheTypeNone = 1,
    WriteCacheTypeWriteBack = 2,
    WriteCacheTypeWriteThrough = 3,
}

enum WRITE_CACHE_ENABLE
{
    WriteCacheEnableUnknown = 0,
    WriteCacheDisabled = 1,
    WriteCacheEnabled = 2,
}

enum WRITE_CACHE_CHANGE
{
    WriteCacheChangeUnknown = 0,
    WriteCacheNotChangeable = 1,
    WriteCacheChangeable = 2,
}

enum WRITE_THROUGH
{
    WriteThroughUnknown = 0,
    WriteThroughNotSupported = 1,
    WriteThroughSupported = 2,
}

struct STORAGE_WRITE_CACHE_PROPERTY
{
    uint Version;
    uint Size;
    WRITE_CACHE_TYPE WriteCacheType;
    WRITE_CACHE_ENABLE WriteCacheEnabled;
    WRITE_CACHE_CHANGE WriteCacheChangeable;
    WRITE_THROUGH WriteThroughSupported;
    ubyte FlushCacheSupported;
    ubyte UserDefinedPowerProtection;
    ubyte NVCacheEnabled;
}

enum STORAGE_DEVICE_POWER_CAP_UNITS
{
    StorageDevicePowerCapUnitsPercent = 0,
    StorageDevicePowerCapUnitsMilliwatts = 1,
}

struct STORAGE_DEVICE_POWER_CAP
{
    uint Version;
    uint Size;
    STORAGE_DEVICE_POWER_CAP_UNITS Units;
    ulong MaxPower;
}

struct STORAGE_HW_FIRMWARE_DOWNLOAD
{
    uint Version;
    uint Size;
    uint Flags;
    ubyte Slot;
    ubyte Reserved;
    ulong Offset;
    ulong BufferSize;
    ubyte ImageBuffer;
}

struct STORAGE_HW_FIRMWARE_ACTIVATE
{
    uint Version;
    uint Size;
    uint Flags;
    ubyte Slot;
    ubyte Reserved0;
}

struct STORAGE_PROTOCOL_COMMAND
{
    uint Version;
    uint Length;
    STORAGE_PROTOCOL_TYPE ProtocolType;
    uint Flags;
    uint ReturnStatus;
    uint ErrorCode;
    uint CommandLength;
    uint ErrorInfoLength;
    uint DataToDeviceTransferLength;
    uint DataFromDeviceTransferLength;
    uint TimeOutValue;
    uint ErrorInfoOffset;
    uint DataToDeviceBufferOffset;
    uint DataFromDeviceBufferOffset;
    uint CommandSpecific;
    uint Reserved0;
    uint FixedProtocolReturnData;
    uint Reserved1;
    ubyte Command;
}

enum MEDIA_TYPE
{
    Unknown = 0,
    F5_1Pt2_512 = 1,
    F3_1Pt44_512 = 2,
    F3_2Pt88_512 = 3,
    F3_20Pt8_512 = 4,
    F3_720_512 = 5,
    F5_360_512 = 6,
    F5_320_512 = 7,
    F5_320_1024 = 8,
    F5_180_512 = 9,
    F5_160_512 = 10,
    RemovableMedia = 11,
    FixedMedia = 12,
    F3_120M_512 = 13,
    F3_640_512 = 14,
    F5_640_512 = 15,
    F5_720_512 = 16,
    F3_1Pt2_512 = 17,
    F3_1Pt23_1024 = 18,
    F5_1Pt23_1024 = 19,
    F3_128Mb_512 = 20,
    F3_230Mb_512 = 21,
    F8_256_128 = 22,
    F3_200Mb_512 = 23,
    F3_240M_512 = 24,
    F3_32M_512 = 25,
}

struct FORMAT_PARAMETERS
{
    MEDIA_TYPE MediaType;
    uint StartCylinderNumber;
    uint EndCylinderNumber;
    uint StartHeadNumber;
    uint EndHeadNumber;
}

struct FORMAT_EX_PARAMETERS
{
    MEDIA_TYPE MediaType;
    uint StartCylinderNumber;
    uint EndCylinderNumber;
    uint StartHeadNumber;
    uint EndHeadNumber;
    ushort FormatGapLength;
    ushort SectorsPerTrack;
    ushort SectorNumber;
}

struct DISK_GEOMETRY
{
    LARGE_INTEGER Cylinders;
    MEDIA_TYPE MediaType;
    uint TracksPerCylinder;
    uint SectorsPerTrack;
    uint BytesPerSector;
}

struct PARTITION_INFORMATION
{
    LARGE_INTEGER StartingOffset;
    LARGE_INTEGER PartitionLength;
    uint HiddenSectors;
    uint PartitionNumber;
    ubyte PartitionType;
    ubyte BootIndicator;
    ubyte RecognizedPartition;
    ubyte RewritePartition;
}

struct SET_PARTITION_INFORMATION
{
    ubyte PartitionType;
}

struct DRIVE_LAYOUT_INFORMATION
{
    uint PartitionCount;
    uint Signature;
    PARTITION_INFORMATION PartitionEntry;
}

struct VERIFY_INFORMATION
{
    LARGE_INTEGER StartingOffset;
    uint Length;
}

struct REASSIGN_BLOCKS
{
    ushort Reserved;
    ushort Count;
    uint BlockNumber;
}

struct REASSIGN_BLOCKS_EX
{
    ushort Reserved;
    ushort Count;
    LARGE_INTEGER BlockNumber;
}

enum PARTITION_STYLE
{
    PARTITION_STYLE_MBR = 0,
    PARTITION_STYLE_GPT = 1,
    PARTITION_STYLE_RAW = 2,
}

struct PARTITION_INFORMATION_GPT
{
    Guid PartitionType;
    Guid PartitionId;
    ulong Attributes;
    ushort Name;
}

struct PARTITION_INFORMATION_MBR
{
    ubyte PartitionType;
    ubyte BootIndicator;
    ubyte RecognizedPartition;
    uint HiddenSectors;
    Guid PartitionId;
}

struct CREATE_DISK_GPT
{
    Guid DiskId;
    uint MaxPartitionCount;
}

struct CREATE_DISK_MBR
{
    uint Signature;
}

struct CREATE_DISK
{
    PARTITION_STYLE PartitionStyle;
    _Anonymous_e__Union Anonymous;
}

struct GET_LENGTH_INFORMATION
{
    LARGE_INTEGER Length;
}

struct PARTITION_INFORMATION_EX
{
    PARTITION_STYLE PartitionStyle;
    LARGE_INTEGER StartingOffset;
    LARGE_INTEGER PartitionLength;
    uint PartitionNumber;
    ubyte RewritePartition;
    ubyte IsServicePartition;
    _Anonymous_e__Union Anonymous;
}

struct DRIVE_LAYOUT_INFORMATION_GPT
{
    Guid DiskId;
    LARGE_INTEGER StartingUsableOffset;
    LARGE_INTEGER UsableLength;
    uint MaxPartitionCount;
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
    _Anonymous_e__Union Anonymous;
    PARTITION_INFORMATION_EX PartitionEntry;
}

struct DISK_INT13_INFO
{
    ushort DriveSelect;
    uint MaxCylinders;
    ushort SectorsPerTrack;
    ushort MaxHeads;
    ushort NumberDrives;
}

struct DISK_EX_INT13_INFO
{
    ushort ExBufferSize;
    ushort ExFlags;
    uint ExCylinders;
    uint ExHeads;
    uint ExSectorsPerTrack;
    ulong ExSectorsPerDrive;
    ushort ExSectorSize;
    ushort ExReserved;
}

struct DISK_DETECTION_INFO
{
    uint SizeOfDetectInfo;
    DETECTION_TYPE DetectionType;
    _Anonymous_e__Union Anonymous;
}

struct DISK_PARTITION_INFO
{
    uint SizeOfPartitionInfo;
    PARTITION_STYLE PartitionStyle;
    _Anonymous_e__Union Anonymous;
}

struct DISK_GEOMETRY_EX
{
    DISK_GEOMETRY Geometry;
    LARGE_INTEGER DiskSize;
    ubyte Data;
}

struct DISK_CACHE_INFORMATION
{
    ubyte ParametersSavable;
    ubyte ReadCacheEnabled;
    ubyte WriteCacheEnabled;
    DISK_CACHE_RETENTION_PRIORITY ReadRetentionPriority;
    DISK_CACHE_RETENTION_PRIORITY WriteRetentionPriority;
    ushort DisablePrefetchTransferLength;
    ubyte PrefetchScalar;
    _Anonymous_e__Union Anonymous;
}

struct DISK_GROW_PARTITION
{
    uint PartitionNumber;
    LARGE_INTEGER BytesToGrow;
}

struct DISK_PERFORMANCE
{
    LARGE_INTEGER BytesRead;
    LARGE_INTEGER BytesWritten;
    LARGE_INTEGER ReadTime;
    LARGE_INTEGER WriteTime;
    LARGE_INTEGER IdleTime;
    uint ReadCount;
    uint WriteCount;
    uint QueueDepth;
    uint SplitCount;
    LARGE_INTEGER QueryTime;
    uint StorageDeviceNumber;
    ushort StorageManagerName;
}

struct GET_DISK_ATTRIBUTES
{
    uint Version;
    uint Reserved1;
    ulong Attributes;
}

struct SET_DISK_ATTRIBUTES
{
    uint Version;
    ubyte Persist;
    ubyte Reserved1;
    ulong Attributes;
    ulong AttributesMask;
    uint Reserved2;
}

struct NTFS_VOLUME_DATA_BUFFER
{
    LARGE_INTEGER VolumeSerialNumber;
    LARGE_INTEGER NumberSectors;
    LARGE_INTEGER TotalClusters;
    LARGE_INTEGER FreeClusters;
    LARGE_INTEGER TotalReserved;
    uint BytesPerSector;
    uint BytesPerCluster;
    uint BytesPerFileRecordSegment;
    uint ClustersPerFileRecordSegment;
    LARGE_INTEGER MftValidDataLength;
    LARGE_INTEGER MftStartLcn;
    LARGE_INTEGER Mft2StartLcn;
    LARGE_INTEGER MftZoneStart;
    LARGE_INTEGER MftZoneEnd;
}

struct NTFS_EXTENDED_VOLUME_DATA
{
    uint ByteCount;
    ushort MajorVersion;
    ushort MinorVersion;
    uint BytesPerPhysicalSector;
    ushort LfsMajorVersion;
    ushort LfsMinorVersion;
    uint MaxDeviceTrimExtentCount;
    uint MaxDeviceTrimByteCount;
    uint MaxVolumeTrimExtentCount;
    uint MaxVolumeTrimByteCount;
}

struct STARTING_LCN_INPUT_BUFFER
{
    LARGE_INTEGER StartingLcn;
}

struct VOLUME_BITMAP_BUFFER
{
    LARGE_INTEGER StartingLcn;
    LARGE_INTEGER BitmapSize;
    ubyte Buffer;
}

struct STARTING_VCN_INPUT_BUFFER
{
    LARGE_INTEGER StartingVcn;
}

struct RETRIEVAL_POINTERS_BUFFER
{
    uint ExtentCount;
    LARGE_INTEGER StartingVcn;
    _Anonymous_e__Struct Extents;
}

struct NTFS_FILE_RECORD_INPUT_BUFFER
{
    LARGE_INTEGER FileReferenceNumber;
}

struct NTFS_FILE_RECORD_OUTPUT_BUFFER
{
    LARGE_INTEGER FileReferenceNumber;
    uint FileRecordLength;
    ubyte FileRecordBuffer;
}

struct MOVE_FILE_DATA
{
    HANDLE FileHandle;
    LARGE_INTEGER StartingVcn;
    LARGE_INTEGER StartingLcn;
    uint ClusterCount;
}

struct FIND_BY_SID_DATA
{
    uint Restart;
    SID Sid;
}

struct FIND_BY_SID_OUTPUT
{
    uint NextEntryOffset;
    uint FileIndex;
    uint FileNameLength;
    ushort FileName;
}

struct MFT_ENUM_DATA_V0
{
    ulong StartFileReferenceNumber;
    long LowUsn;
    long HighUsn;
}

struct MFT_ENUM_DATA_V1
{
    ulong StartFileReferenceNumber;
    long LowUsn;
    long HighUsn;
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
    long StartUsn;
    uint ReasonMask;
    uint ReturnOnlyOnClose;
    ulong Timeout;
    ulong BytesToWaitFor;
    ulong UsnJournalID;
}

struct READ_USN_JOURNAL_DATA_V1
{
    long StartUsn;
    uint ReasonMask;
    uint ReturnOnlyOnClose;
    ulong Timeout;
    ulong BytesToWaitFor;
    ulong UsnJournalID;
    ushort MinMajorVersion;
    ushort MaxMajorVersion;
}

struct USN_TRACK_MODIFIED_RANGES
{
    uint Flags;
    uint Unused;
    ulong ChunkSize;
    long FileSizeThreshold;
}

struct USN_RANGE_TRACK_OUTPUT
{
    long Usn;
}

struct USN_RECORD_V2
{
    uint RecordLength;
    ushort MajorVersion;
    ushort MinorVersion;
    ulong FileReferenceNumber;
    ulong ParentFileReferenceNumber;
    long Usn;
    LARGE_INTEGER TimeStamp;
    uint Reason;
    uint SourceInfo;
    uint SecurityId;
    uint FileAttributes;
    ushort FileNameLength;
    ushort FileNameOffset;
    ushort FileName;
}

struct USN_RECORD_V3
{
    uint RecordLength;
    ushort MajorVersion;
    ushort MinorVersion;
    FILE_ID_128 FileReferenceNumber;
    FILE_ID_128 ParentFileReferenceNumber;
    long Usn;
    LARGE_INTEGER TimeStamp;
    uint Reason;
    uint SourceInfo;
    uint SecurityId;
    uint FileAttributes;
    ushort FileNameLength;
    ushort FileNameOffset;
    ushort FileName;
}

struct USN_RECORD_COMMON_HEADER
{
    uint RecordLength;
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
    FILE_ID_128 FileReferenceNumber;
    FILE_ID_128 ParentFileReferenceNumber;
    long Usn;
    uint Reason;
    uint SourceInfo;
    uint RemainingExtents;
    ushort NumberOfExtents;
    ushort ExtentSize;
    USN_RECORD_EXTENT Extents;
}

struct USN_JOURNAL_DATA_V0
{
    ulong UsnJournalID;
    long FirstUsn;
    long NextUsn;
    long LowestValidUsn;
    long MaxUsn;
    ulong MaximumSize;
    ulong AllocationDelta;
}

struct USN_JOURNAL_DATA_V1
{
    ulong UsnJournalID;
    long FirstUsn;
    long NextUsn;
    long LowestValidUsn;
    long MaxUsn;
    ulong MaximumSize;
    ulong AllocationDelta;
    ushort MinSupportedMajorVersion;
    ushort MaxSupportedMajorVersion;
}

struct USN_JOURNAL_DATA_V2
{
    ulong UsnJournalID;
    long FirstUsn;
    long NextUsn;
    long LowestValidUsn;
    long MaxUsn;
    ulong MaximumSize;
    ulong AllocationDelta;
    ushort MinSupportedMajorVersion;
    ushort MaxSupportedMajorVersion;
    uint Flags;
    ulong RangeTrackChunkSize;
    long RangeTrackFileSizeThreshold;
}

struct DELETE_USN_JOURNAL_DATA
{
    ulong UsnJournalID;
    uint DeleteFlags;
}

struct MARK_HANDLE_INFO
{
    _Anonymous_e__Union Anonymous;
    HANDLE VolumeHandle;
    uint HandleInfo;
}

struct FILESYSTEM_STATISTICS
{
    ushort FileSystemType;
    ushort Version;
    uint SizeOfCompleteStructure;
    uint UserFileReads;
    uint UserFileReadBytes;
    uint UserDiskReads;
    uint UserFileWrites;
    uint UserFileWriteBytes;
    uint UserDiskWrites;
    uint MetaDataReads;
    uint MetaDataReadBytes;
    uint MetaDataDiskReads;
    uint MetaDataWrites;
    uint MetaDataWriteBytes;
    uint MetaDataDiskWrites;
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
    uint LogFileFullExceptions;
    uint OtherExceptions;
    uint MftReads;
    uint MftReadBytes;
    uint MftWrites;
    uint MftWriteBytes;
    _MftWritesUserLevel_e__Struct MftWritesUserLevel;
    ushort MftWritesFlushForLogFileFull;
    ushort MftWritesLazyWriter;
    ushort MftWritesUserRequest;
    uint Mft2Writes;
    uint Mft2WriteBytes;
    _Mft2WritesUserLevel_e__Struct Mft2WritesUserLevel;
    ushort Mft2WritesFlushForLogFileFull;
    ushort Mft2WritesLazyWriter;
    ushort Mft2WritesUserRequest;
    uint RootIndexReads;
    uint RootIndexReadBytes;
    uint RootIndexWrites;
    uint RootIndexWriteBytes;
    uint BitmapReads;
    uint BitmapReadBytes;
    uint BitmapWrites;
    uint BitmapWriteBytes;
    ushort BitmapWritesFlushForLogFileFull;
    ushort BitmapWritesLazyWriter;
    ushort BitmapWritesUserRequest;
    _BitmapWritesUserLevel_e__Struct BitmapWritesUserLevel;
    uint MftBitmapReads;
    uint MftBitmapReadBytes;
    uint MftBitmapWrites;
    uint MftBitmapWriteBytes;
    ushort MftBitmapWritesFlushForLogFileFull;
    ushort MftBitmapWritesLazyWriter;
    ushort MftBitmapWritesUserRequest;
    _MftBitmapWritesUserLevel_e__Struct MftBitmapWritesUserLevel;
    uint UserIndexReads;
    uint UserIndexReadBytes;
    uint UserIndexWrites;
    uint UserIndexWriteBytes;
    uint LogFileReads;
    uint LogFileReadBytes;
    uint LogFileWrites;
    uint LogFileWriteBytes;
    _Allocate_e__Struct Allocate;
    uint DiskResourcesExhausted;
}

struct FILESYSTEM_STATISTICS_EX
{
    ushort FileSystemType;
    ushort Version;
    uint SizeOfCompleteStructure;
    ulong UserFileReads;
    ulong UserFileReadBytes;
    ulong UserDiskReads;
    ulong UserFileWrites;
    ulong UserFileWriteBytes;
    ulong UserDiskWrites;
    ulong MetaDataReads;
    ulong MetaDataReadBytes;
    ulong MetaDataDiskReads;
    ulong MetaDataWrites;
    ulong MetaDataWriteBytes;
    ulong MetaDataDiskWrites;
}

struct NTFS_STATISTICS_EX
{
    uint LogFileFullExceptions;
    uint OtherExceptions;
    ulong MftReads;
    ulong MftReadBytes;
    ulong MftWrites;
    ulong MftWriteBytes;
    _MftWritesUserLevel_e__Struct MftWritesUserLevel;
    uint MftWritesFlushForLogFileFull;
    uint MftWritesLazyWriter;
    uint MftWritesUserRequest;
    ulong Mft2Writes;
    ulong Mft2WriteBytes;
    _Mft2WritesUserLevel_e__Struct Mft2WritesUserLevel;
    uint Mft2WritesFlushForLogFileFull;
    uint Mft2WritesLazyWriter;
    uint Mft2WritesUserRequest;
    ulong RootIndexReads;
    ulong RootIndexReadBytes;
    ulong RootIndexWrites;
    ulong RootIndexWriteBytes;
    ulong BitmapReads;
    ulong BitmapReadBytes;
    ulong BitmapWrites;
    ulong BitmapWriteBytes;
    uint BitmapWritesFlushForLogFileFull;
    uint BitmapWritesLazyWriter;
    uint BitmapWritesUserRequest;
    _BitmapWritesUserLevel_e__Struct BitmapWritesUserLevel;
    ulong MftBitmapReads;
    ulong MftBitmapReadBytes;
    ulong MftBitmapWrites;
    ulong MftBitmapWriteBytes;
    uint MftBitmapWritesFlushForLogFileFull;
    uint MftBitmapWritesLazyWriter;
    uint MftBitmapWritesUserRequest;
    _MftBitmapWritesUserLevel_e__Struct MftBitmapWritesUserLevel;
    ulong UserIndexReads;
    ulong UserIndexReadBytes;
    ulong UserIndexWrites;
    ulong UserIndexWriteBytes;
    ulong LogFileReads;
    ulong LogFileReadBytes;
    ulong LogFileWrites;
    ulong LogFileWriteBytes;
    _Allocate_e__Struct Allocate;
    uint DiskResourcesExhausted;
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
    ubyte ObjectId;
    _Anonymous_e__Union Anonymous;
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
    uint ByteLength;
    uint PlexNumber;
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
    uint SparingUnitBytes;
    ubyte SoftwareSparing;
    uint TotalSpareBlocks;
    uint FreeSpareBlocks;
}

struct FILE_QUERY_ON_DISK_VOL_INFO_BUFFER
{
    LARGE_INTEGER DirectoryCount;
    LARGE_INTEGER FileCount;
    ushort FsFormatMajVersion;
    ushort FsFormatMinVersion;
    ushort FsFormatName;
    LARGE_INTEGER FormatTime;
    LARGE_INTEGER LastUpdateTime;
    ushort CopyrightInfo;
    ushort AbstractInfo;
    ushort FormattingImplementationInfo;
    ushort LastModifyingImplementationInfo;
}

struct SHRINK_VOLUME_INFORMATION
{
    SHRINK_VOLUME_REQUEST_TYPES ShrinkRequestType;
    ulong Flags;
    long NewNumberOfSectors;
}

struct TXFS_MODIFY_RM
{
    uint Flags;
    uint LogContainerCountMax;
    uint LogContainerCountMin;
    uint LogContainerCount;
    uint LogGrowthIncrement;
    uint LogAutoShrinkPercentage;
    ulong Reserved;
    ushort LoggingMode;
}

struct TXFS_QUERY_RM_INFORMATION
{
    uint BytesRequired;
    ulong TailLsn;
    ulong CurrentLsn;
    ulong ArchiveTailLsn;
    ulong LogContainerSize;
    LARGE_INTEGER HighestVirtualClock;
    uint LogContainerCount;
    uint LogContainerCountMax;
    uint LogContainerCountMin;
    uint LogGrowthIncrement;
    uint LogAutoShrinkPercentage;
    uint Flags;
    ushort LoggingMode;
    ushort Reserved;
    uint RmState;
    ulong LogCapacity;
    ulong LogFree;
    ulong TopsSize;
    ulong TopsUsed;
    ulong TransactionCount;
    ulong OnePCCount;
    ulong TwoPCCount;
    ulong NumberLogFileFull;
    ulong OldestTransactionAge;
    Guid RMName;
    uint TmLogPathOffset;
}

struct TXFS_GET_METADATA_INFO_OUT
{
    _TxfFileId_e__Struct TxfFileId;
    Guid LockingTransaction;
    ulong LastLsn;
    uint TransactionState;
}

struct TXFS_LIST_TRANSACTION_LOCKED_FILES_ENTRY
{
    ulong Offset;
    uint NameFlags;
    long FileId;
    uint Reserved1;
    uint Reserved2;
    long Reserved3;
    ushort FileName;
}

struct TXFS_LIST_TRANSACTION_LOCKED_FILES
{
    Guid KtmTransaction;
    ulong NumberOfFiles;
    ulong BufferSizeRequired;
    ulong Offset;
}

struct TXFS_LIST_TRANSACTIONS_ENTRY
{
    Guid TransactionId;
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
    _Anonymous_e__Union Anonymous;
}

struct TXFS_WRITE_BACKUP_INFORMATION
{
    ubyte Buffer;
}

struct TXFS_GET_TRANSACTED_VERSION
{
    uint ThisBaseVersion;
    uint LatestVersion;
    ushort ThisMiniVersion;
    ushort FirstMiniVersion;
    ushort LatestMiniVersion;
}

struct TXFS_SAVEPOINT_INFORMATION
{
    HANDLE KtmTransaction;
    uint ActionCode;
    uint SavepointId;
}

struct TXFS_CREATE_MINIVERSION_INFO
{
    ushort StructureVersion;
    ushort StructureLength;
    uint BaseVersion;
    ushort MiniVersion;
}

struct TXFS_TRANSACTION_ACTIVE_INFO
{
    ubyte TransactionsActiveAtSnapshot;
}

struct BOOT_AREA_INFO
{
    uint BootSectorCount;
    _Anonymous_e__Struct BootSectors;
}

struct RETRIEVAL_POINTER_BASE
{
    LARGE_INTEGER FileAreaOffset;
}

struct FILE_SYSTEM_RECOGNITION_INFORMATION
{
    byte FileSystem;
}

struct REQUEST_OPLOCK_INPUT_BUFFER
{
    ushort StructureVersion;
    ushort StructureLength;
    uint RequestedOplockLevel;
    uint Flags;
}

struct REQUEST_OPLOCK_OUTPUT_BUFFER
{
    ushort StructureVersion;
    ushort StructureLength;
    uint OriginalOplockLevel;
    uint NewOplockLevel;
    uint Flags;
    uint AccessMode;
    ushort ShareMode;
}

struct LOOKUP_STREAM_FROM_CLUSTER_INPUT
{
    uint Flags;
    uint NumberOfClusters;
    LARGE_INTEGER Cluster;
}

struct LOOKUP_STREAM_FROM_CLUSTER_OUTPUT
{
    uint Offset;
    uint NumberOfMatches;
    uint BufferSizeRequired;
}

struct LOOKUP_STREAM_FROM_CLUSTER_ENTRY
{
    uint OffsetToNext;
    uint Flags;
    LARGE_INTEGER Reserved;
    LARGE_INTEGER Cluster;
    ushort FileName;
}

struct CSV_NAMESPACE_INFO
{
    uint Version;
    uint DeviceNumber;
    LARGE_INTEGER StartingOffset;
    uint SectorSize;
}

enum CSV_CONTROL_OP
{
    CsvControlStartRedirectFile = 2,
    CsvControlStopRedirectFile = 3,
    CsvControlQueryRedirectState = 4,
    CsvControlQueryFileRevision = 6,
    CsvControlQueryMdsPath = 8,
    CsvControlQueryFileRevisionFileId128 = 9,
    CsvControlQueryVolumeRedirectState = 10,
    CsvControlEnableUSNRangeModificationTracking = 13,
    CsvControlMarkHandleLocalVolumeMount = 14,
    CsvControlUnmarkHandleLocalVolumeMount = 15,
    CsvControlGetCsvFsMdsPathV2 = 18,
    CsvControlDisableCaching = 19,
    CsvControlEnableCaching = 20,
    CsvControlStartForceDFO = 21,
    CsvControlStopForceDFO = 22,
}

struct CSV_CONTROL_PARAM
{
    CSV_CONTROL_OP Operation;
    long Unused;
}

struct CSV_QUERY_REDIRECT_STATE
{
    uint MdsNodeId;
    uint DsNodeId;
    ubyte FileRedirected;
}

struct CSV_QUERY_FILE_REVISION
{
    long FileId;
    long FileRevision;
}

struct CSV_QUERY_MDS_PATH
{
    uint MdsNodeId;
    uint DsNodeId;
    uint PathLength;
    ushort Path;
}

struct CSV_QUERY_VETO_FILE_DIRECT_IO_OUTPUT
{
    ulong VetoedFromAltitudeIntegral;
    ulong VetoedFromAltitudeDecimal;
    ushort Reason;
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
    FILE_LEVEL_TRIM_RANGE Ranges;
}

struct FILE_LEVEL_TRIM_OUTPUT
{
    uint NumRangesProcessed;
}

struct FSCTL_GET_INTEGRITY_INFORMATION_BUFFER
{
    ushort ChecksumAlgorithm;
    ushort Reserved;
    uint Flags;
    uint ChecksumChunkSizeInBytes;
    uint ClusterSizeInBytes;
}

struct FSCTL_SET_INTEGRITY_INFORMATION_BUFFER
{
    ushort ChecksumAlgorithm;
    ushort Reserved;
    uint Flags;
}

struct REPAIR_COPIES_INPUT
{
    uint Size;
    uint Flags;
    LARGE_INTEGER FileOffset;
    uint Length;
    uint SourceCopy;
    uint NumberOfRepairCopies;
    uint RepairCopies;
}

struct REPAIR_COPIES_OUTPUT
{
    uint Size;
    uint Status;
    LARGE_INTEGER ResumeFileOffset;
}

enum FILE_STORAGE_TIER_MEDIA_TYPE
{
    FileStorageTierMediaTypeUnspecified = 0,
    FileStorageTierMediaTypeDisk = 1,
    FileStorageTierMediaTypeSsd = 2,
    FileStorageTierMediaTypeScm = 4,
    FileStorageTierMediaTypeMax = 5,
}

struct FILE_STORAGE_TIER
{
    Guid Id;
    ushort Name;
    ushort Description;
    ulong Flags;
    ulong ProvisionedCapacity;
    FILE_STORAGE_TIER_MEDIA_TYPE MediaType;
    FILE_STORAGE_TIER_CLASS Class;
}

struct FSCTL_QUERY_STORAGE_CLASSES_OUTPUT
{
    uint Version;
    uint Size;
    uint Flags;
    uint TotalNumberOfTiers;
    uint NumberOfTiersReturned;
    FILE_STORAGE_TIER Tiers;
}

struct FSCTL_QUERY_REGION_INFO_INPUT
{
    uint Version;
    uint Size;
    uint Flags;
    uint NumberOfTierIds;
    Guid TierIds;
}

struct FILE_STORAGE_TIER_REGION
{
    Guid TierId;
    ulong Offset;
    ulong Length;
}

struct FSCTL_QUERY_REGION_INFO_OUTPUT
{
    uint Version;
    uint Size;
    uint Flags;
    uint Reserved;
    ulong Alignment;
    uint TotalNumberOfRegions;
    uint NumberOfRegionsReturned;
    FILE_STORAGE_TIER_REGION Regions;
}

struct DUPLICATE_EXTENTS_DATA
{
    HANDLE FileHandle;
    LARGE_INTEGER SourceFileOffset;
    LARGE_INTEGER TargetFileOffset;
    LARGE_INTEGER ByteCount;
}

struct DISK_EXTENT
{
    uint DiskNumber;
    LARGE_INTEGER StartingOffset;
    LARGE_INTEGER ExtentLength;
}

struct VOLUME_DISK_EXTENTS
{
    uint NumberOfDiskExtents;
    DISK_EXTENT Extents;
}

struct VOLUME_GET_GPT_ATTRIBUTES_INFORMATION
{
    ulong GptAttributes;
}

struct TRANSACTION_NOTIFICATION
{
    void* TransactionKey;
    uint TransactionNotification;
    LARGE_INTEGER TmVirtualClock;
    uint ArgumentLength;
}

struct TRANSACTION_NOTIFICATION_RECOVERY_ARGUMENT
{
    Guid EnlistmentId;
    Guid UOW;
}

struct TRANSACTION_NOTIFICATION_TM_ONLINE_ARGUMENT
{
    Guid TmIdentity;
    uint Flags;
}

struct TRANSACTION_NOTIFICATION_SAVEPOINT_ARGUMENT
{
    uint SavepointId;
}

struct TRANSACTION_NOTIFICATION_PROPAGATE_ARGUMENT
{
    uint PropagationCookie;
    Guid UOW;
    Guid TmIdentity;
    uint BufferLength;
}

struct TRANSACTION_NOTIFICATION_MARSHAL_ARGUMENT
{
    uint MarshalCookie;
    Guid UOW;
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
    Guid UOW;
    Guid TmIdentity;
    uint IsolationLevel;
    uint IsolationFlags;
    uint Timeout;
    ushort Description;
}

struct KCRM_PROTOCOL_BLOB
{
    Guid ProtocolId;
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
    uint SectorsPerAllocationUnit;
    uint BytesPerSector;
}

struct WIN32_FILE_ATTRIBUTE_DATA
{
    uint dwFileAttributes;
    FILETIME ftCreationTime;
    FILETIME ftLastAccessTime;
    FILETIME ftLastWriteTime;
    uint nFileSizeHigh;
    uint nFileSizeLow;
}

struct BY_HANDLE_FILE_INFORMATION
{
    uint dwFileAttributes;
    FILETIME ftCreationTime;
    FILETIME ftLastAccessTime;
    FILETIME ftLastWriteTime;
    uint dwVolumeSerialNumber;
    uint nFileSizeHigh;
    uint nFileSizeLow;
    uint nNumberOfLinks;
    uint nFileIndexHigh;
    uint nFileIndexLow;
}

struct CREATEFILE2_EXTENDED_PARAMETERS
{
    uint dwSize;
    uint dwFileAttributes;
    uint dwFileFlags;
    uint dwSecurityQosFlags;
    SECURITY_ATTRIBUTES* lpSecurityAttributes;
    HANDLE hTemplateFile;
}

enum STREAM_INFO_LEVELS
{
    FindStreamInfoStandard = 0,
    FindStreamInfoMaxInfoLevel = 1,
}

struct WIN32_FIND_STREAM_DATA
{
    LARGE_INTEGER StreamSize;
    ushort cStreamName;
}

struct EFS_CERTIFICATE_BLOB
{
    uint dwCertEncodingType;
    uint cbData;
    ubyte* pbData;
}

struct EFS_HASH_BLOB
{
    uint cbData;
    ubyte* pbData;
}

struct EFS_RPC_BLOB
{
    uint cbData;
    ubyte* pbData;
}

struct EFS_PIN_BLOB
{
    uint cbPadding;
    uint cbData;
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
    uint cbTotalLength;
    SID* pUserSid;
    EFS_HASH_BLOB* pHash;
    const(wchar)* lpDisplayInformation;
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
    uint dwEfsAccessType;
    ENCRYPTION_CERTIFICATE_HASH_LIST* pCertificatesAdded;
    ENCRYPTION_CERTIFICATE* pEncryptionCertificate;
    EFS_RPC_BLOB* pEfsStreamSignature;
}

struct ENCRYPTION_PROTECTOR
{
    uint cbTotalLength;
    SID* pUserSid;
    const(wchar)* lpProtectorDescriptor;
}

struct ENCRYPTION_PROTECTOR_LIST
{
    uint nProtectors;
    ENCRYPTION_PROTECTOR** pProtectors;
}

enum NtmsObjectsTypes
{
    NTMS_UNKNOWN = 0,
    NTMS_OBJECT = 1,
    NTMS_CHANGER = 2,
    NTMS_CHANGER_TYPE = 3,
    NTMS_COMPUTER = 4,
    NTMS_DRIVE = 5,
    NTMS_DRIVE_TYPE = 6,
    NTMS_IEDOOR = 7,
    NTMS_IEPORT = 8,
    NTMS_LIBRARY = 9,
    NTMS_LIBREQUEST = 10,
    NTMS_LOGICAL_MEDIA = 11,
    NTMS_MEDIA_POOL = 12,
    NTMS_MEDIA_TYPE = 13,
    NTMS_PARTITION = 14,
    NTMS_PHYSICAL_MEDIA = 15,
    NTMS_STORAGESLOT = 16,
    NTMS_OPREQUEST = 17,
    NTMS_UI_DESTINATION = 18,
    NTMS_NUMBER_OF_OBJECT_TYPES = 19,
}

struct NTMS_ASYNC_IO
{
    Guid OperationId;
    Guid EventId;
    uint dwOperationType;
    uint dwResult;
    uint dwAsyncState;
    HANDLE hEvent;
    BOOL bOnStateChange;
}

enum NtmsAsyncStatus
{
    NTMS_ASYNCSTATE_QUEUED = 0,
    NTMS_ASYNCSTATE_WAIT_RESOURCE = 1,
    NTMS_ASYNCSTATE_WAIT_OPERATOR = 2,
    NTMS_ASYNCSTATE_INPROCESS = 3,
    NTMS_ASYNCSTATE_COMPLETE = 4,
}

enum NtmsAsyncOperations
{
    NTMS_ASYNCOP_MOUNT = 1,
}

enum NtmsSessionOptions
{
    NTMS_SESSION_QUERYEXPEDITE = 1,
}

enum NtmsMountOptions
{
    NTMS_MOUNT_READ = 1,
    NTMS_MOUNT_WRITE = 2,
    NTMS_MOUNT_ERROR_NOT_AVAILABLE = 4,
    NTMS_MOUNT_ERROR_IF_UNAVAILABLE = 4,
    NTMS_MOUNT_ERROR_OFFLINE = 8,
    NTMS_MOUNT_ERROR_IF_OFFLINE = 8,
    NTMS_MOUNT_SPECIFIC_DRIVE = 16,
    NTMS_MOUNT_NOWAIT = 32,
}

enum NtmsDismountOptions
{
    NTMS_DISMOUNT_DEFERRED = 1,
    NTMS_DISMOUNT_IMMEDIATE = 2,
}

enum NtmsMountPriority
{
    NTMS_PRIORITY_DEFAULT = 0,
    NTMS_PRIORITY_HIGHEST = 15,
    NTMS_PRIORITY_HIGH = 7,
    NTMS_PRIORITY_NORMAL = 0,
    NTMS_PRIORITY_LOW = -7,
    NTMS_PRIORITY_LOWEST = -15,
}

struct NTMS_MOUNT_INFORMATION
{
    uint dwSize;
    void* lpReserved;
}

enum NtmsAllocateOptions
{
    NTMS_ALLOCATE_NEW = 1,
    NTMS_ALLOCATE_NEXT = 2,
    NTMS_ALLOCATE_ERROR_IF_UNAVAILABLE = 4,
}

struct NTMS_ALLOCATION_INFORMATION
{
    uint dwSize;
    void* lpReserved;
    Guid AllocatedFrom;
}

enum NtmsCreateOptions
{
    NTMS_OPEN_EXISTING = 1,
    NTMS_CREATE_NEW = 2,
    NTMS_OPEN_ALWAYS = 3,
}

enum NtmsDriveState
{
    NTMS_DRIVESTATE_DISMOUNTED = 0,
    NTMS_DRIVESTATE_MOUNTED = 1,
    NTMS_DRIVESTATE_LOADED = 2,
    NTMS_DRIVESTATE_UNLOADED = 5,
    NTMS_DRIVESTATE_BEING_CLEANED = 6,
    NTMS_DRIVESTATE_DISMOUNTABLE = 7,
}

struct NTMS_DRIVEINFORMATIONA
{
    uint Number;
    uint State;
    Guid DriveType;
    byte szDeviceName;
    byte szSerialNumber;
    byte szRevision;
    ushort ScsiPort;
    ushort ScsiBus;
    ushort ScsiTarget;
    ushort ScsiLun;
    uint dwMountCount;
    SYSTEMTIME LastCleanedTs;
    Guid SavedPartitionId;
    Guid Library;
    Guid Reserved;
    uint dwDeferDismountDelay;
}

struct NTMS_DRIVEINFORMATIONW
{
    uint Number;
    uint State;
    Guid DriveType;
    ushort szDeviceName;
    ushort szSerialNumber;
    ushort szRevision;
    ushort ScsiPort;
    ushort ScsiBus;
    ushort ScsiTarget;
    ushort ScsiLun;
    uint dwMountCount;
    SYSTEMTIME LastCleanedTs;
    Guid SavedPartitionId;
    Guid Library;
    Guid Reserved;
    uint dwDeferDismountDelay;
}

enum NtmsLibraryType
{
    NTMS_LIBRARYTYPE_UNKNOWN = 0,
    NTMS_LIBRARYTYPE_OFFLINE = 1,
    NTMS_LIBRARYTYPE_ONLINE = 2,
    NTMS_LIBRARYTYPE_STANDALONE = 3,
}

enum NtmsLibraryFlags
{
    NTMS_LIBRARYFLAG_FIXEDOFFLINE = 1,
    NTMS_LIBRARYFLAG_CLEANERPRESENT = 2,
    NTMS_LIBRARYFLAG_AUTODETECTCHANGE = 4,
    NTMS_LIBRARYFLAG_IGNORECLEANERUSESREMAINING = 8,
    NTMS_LIBRARYFLAG_RECOGNIZECLEANERBARCODE = 16,
}

enum NtmsInventoryMethod
{
    NTMS_INVENTORY_NONE = 0,
    NTMS_INVENTORY_FAST = 1,
    NTMS_INVENTORY_OMID = 2,
    NTMS_INVENTORY_DEFAULT = 3,
    NTMS_INVENTORY_SLOT = 4,
    NTMS_INVENTORY_STOP = 5,
    NTMS_INVENTORY_MAX = 6,
}

struct NTMS_LIBRARYINFORMATION
{
    uint LibraryType;
    Guid CleanerSlot;
    Guid CleanerSlotDefault;
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
    Guid Reserved;
    BOOL AutoRecovery;
    uint dwFlags;
}

struct NTMS_CHANGERINFORMATIONA
{
    uint Number;
    Guid ChangerType;
    byte szSerialNumber;
    byte szRevision;
    byte szDeviceName;
    ushort ScsiPort;
    ushort ScsiBus;
    ushort ScsiTarget;
    ushort ScsiLun;
    Guid Library;
}

struct NTMS_CHANGERINFORMATIONW
{
    uint Number;
    Guid ChangerType;
    ushort szSerialNumber;
    ushort szRevision;
    ushort szDeviceName;
    ushort ScsiPort;
    ushort ScsiBus;
    ushort ScsiTarget;
    ushort ScsiLun;
    Guid Library;
}

enum NtmsSlotState
{
    NTMS_SLOTSTATE_UNKNOWN = 0,
    NTMS_SLOTSTATE_FULL = 1,
    NTMS_SLOTSTATE_EMPTY = 2,
    NTMS_SLOTSTATE_NOTPRESENT = 3,
    NTMS_SLOTSTATE_NEEDSINVENTORY = 4,
}

struct NTMS_STORAGESLOTINFORMATION
{
    uint Number;
    uint State;
    Guid Library;
}

enum NtmsDoorState
{
    NTMS_DOORSTATE_UNKNOWN = 0,
    NTMS_DOORSTATE_CLOSED = 1,
    NTMS_DOORSTATE_OPEN = 2,
}

struct NTMS_IEDOORINFORMATION
{
    uint Number;
    uint State;
    ushort MaxOpenSecs;
    Guid Library;
}

enum NtmsPortPosition
{
    NTMS_PORTPOSITION_UNKNOWN = 0,
    NTMS_PORTPOSITION_EXTENDED = 1,
    NTMS_PORTPOSITION_RETRACTED = 2,
}

enum NtmsPortContent
{
    NTMS_PORTCONTENT_UNKNOWN = 0,
    NTMS_PORTCONTENT_FULL = 1,
    NTMS_PORTCONTENT_EMPTY = 2,
}

struct NTMS_IEPORTINFORMATION
{
    uint Number;
    uint Content;
    uint Position;
    ushort MaxExtendSecs;
    Guid Library;
}

enum NtmsBarCodeState
{
    NTMS_BARCODESTATE_OK = 1,
    NTMS_BARCODESTATE_UNREADABLE = 2,
}

enum NtmsMediaState
{
    NTMS_MEDIASTATE_IDLE = 0,
    NTMS_MEDIASTATE_INUSE = 1,
    NTMS_MEDIASTATE_MOUNTED = 2,
    NTMS_MEDIASTATE_LOADED = 3,
    NTMS_MEDIASTATE_UNLOADED = 4,
    NTMS_MEDIASTATE_OPERROR = 5,
    NTMS_MEDIASTATE_OPREQ = 6,
}

struct NTMS_PMIDINFORMATIONA
{
    Guid CurrentLibrary;
    Guid MediaPool;
    Guid Location;
    uint LocationType;
    Guid MediaType;
    Guid HomeSlot;
    byte szBarCode;
    uint BarCodeState;
    byte szSequenceNumber;
    uint MediaState;
    uint dwNumberOfPartitions;
    uint dwMediaTypeCode;
    uint dwDensityCode;
    Guid MountedPartition;
}

struct NTMS_PMIDINFORMATIONW
{
    Guid CurrentLibrary;
    Guid MediaPool;
    Guid Location;
    uint LocationType;
    Guid MediaType;
    Guid HomeSlot;
    ushort szBarCode;
    uint BarCodeState;
    ushort szSequenceNumber;
    uint MediaState;
    uint dwNumberOfPartitions;
    uint dwMediaTypeCode;
    uint dwDensityCode;
    Guid MountedPartition;
}

struct NTMS_LMIDINFORMATION
{
    Guid MediaPool;
    uint dwNumberOfPartitions;
}

enum NtmsPartitionState
{
    NTMS_PARTSTATE_UNKNOWN = 0,
    NTMS_PARTSTATE_UNPREPARED = 1,
    NTMS_PARTSTATE_INCOMPATIBLE = 2,
    NTMS_PARTSTATE_DECOMMISSIONED = 3,
    NTMS_PARTSTATE_AVAILABLE = 4,
    NTMS_PARTSTATE_ALLOCATED = 5,
    NTMS_PARTSTATE_COMPLETE = 6,
    NTMS_PARTSTATE_FOREIGN = 7,
    NTMS_PARTSTATE_IMPORT = 8,
    NTMS_PARTSTATE_RESERVED = 9,
}

struct NTMS_PARTITIONINFORMATIONA
{
    Guid PhysicalMedia;
    Guid LogicalMedia;
    uint State;
    ushort Side;
    uint dwOmidLabelIdLength;
    ubyte OmidLabelId;
    byte szOmidLabelType;
    byte szOmidLabelInfo;
    uint dwMountCount;
    uint dwAllocateCount;
    LARGE_INTEGER Capacity;
}

struct NTMS_PARTITIONINFORMATIONW
{
    Guid PhysicalMedia;
    Guid LogicalMedia;
    uint State;
    ushort Side;
    uint dwOmidLabelIdLength;
    ubyte OmidLabelId;
    ushort szOmidLabelType;
    ushort szOmidLabelInfo;
    uint dwMountCount;
    uint dwAllocateCount;
    LARGE_INTEGER Capacity;
}

enum NtmsPoolType
{
    NTMS_POOLTYPE_UNKNOWN = 0,
    NTMS_POOLTYPE_SCRATCH = 1,
    NTMS_POOLTYPE_FOREIGN = 2,
    NTMS_POOLTYPE_IMPORT = 3,
    NTMS_POOLTYPE_APPLICATION = 1000,
}

enum NtmsAllocationPolicy
{
    NTMS_ALLOCATE_FROMSCRATCH = 1,
}

enum NtmsDeallocationPolicy
{
    NTMS_DEALLOCATE_TOSCRATCH = 1,
}

struct NTMS_MEDIAPOOLINFORMATION
{
    uint PoolType;
    Guid MediaType;
    Guid Parent;
    uint AllocationPolicy;
    uint DeallocationPolicy;
    uint dwMaxAllocates;
    uint dwNumberOfPhysicalMedia;
    uint dwNumberOfLogicalMedia;
    uint dwNumberOfMediaPools;
}

enum NtmsReadWriteCharacteristics
{
    NTMS_MEDIARW_UNKNOWN = 0,
    NTMS_MEDIARW_REWRITABLE = 1,
    NTMS_MEDIARW_WRITEONCE = 2,
    NTMS_MEDIARW_READONLY = 3,
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
    byte szVendor;
    byte szProduct;
    uint NumberOfHeads;
    uint DeviceType;
}

struct NTMS_DRIVETYPEINFORMATIONW
{
    ushort szVendor;
    ushort szProduct;
    uint NumberOfHeads;
    uint DeviceType;
}

struct NTMS_CHANGERTYPEINFORMATIONA
{
    byte szVendor;
    byte szProduct;
    uint DeviceType;
}

struct NTMS_CHANGERTYPEINFORMATIONW
{
    ushort szVendor;
    ushort szProduct;
    uint DeviceType;
}

enum NtmsLmOperation
{
    NTMS_LM_REMOVE = 0,
    NTMS_LM_DISABLECHANGER = 1,
    NTMS_LM_DISABLELIBRARY = 1,
    NTMS_LM_ENABLECHANGER = 2,
    NTMS_LM_ENABLELIBRARY = 2,
    NTMS_LM_DISABLEDRIVE = 3,
    NTMS_LM_ENABLEDRIVE = 4,
    NTMS_LM_DISABLEMEDIA = 5,
    NTMS_LM_ENABLEMEDIA = 6,
    NTMS_LM_UPDATEOMID = 7,
    NTMS_LM_INVENTORY = 8,
    NTMS_LM_DOORACCESS = 9,
    NTMS_LM_EJECT = 10,
    NTMS_LM_EJECTCLEANER = 11,
    NTMS_LM_INJECT = 12,
    NTMS_LM_INJECTCLEANER = 13,
    NTMS_LM_PROCESSOMID = 14,
    NTMS_LM_CLEANDRIVE = 15,
    NTMS_LM_DISMOUNT = 16,
    NTMS_LM_MOUNT = 17,
    NTMS_LM_WRITESCRATCH = 18,
    NTMS_LM_CLASSIFY = 19,
    NTMS_LM_RESERVECLEANER = 20,
    NTMS_LM_RELEASECLEANER = 21,
    NTMS_LM_MAXWORKITEM = 22,
}

enum NtmsLmState
{
    NTMS_LM_QUEUED = 0,
    NTMS_LM_INPROCESS = 1,
    NTMS_LM_PASSED = 2,
    NTMS_LM_FAILED = 3,
    NTMS_LM_INVALID = 4,
    NTMS_LM_WAITING = 5,
    NTMS_LM_DEFERRED = 6,
    NTMS_LM_DEFFERED = 6,
    NTMS_LM_CANCELLED = 7,
    NTMS_LM_STOPPED = 8,
}

struct NTMS_LIBREQUESTINFORMATIONA
{
    uint OperationCode;
    uint OperationOption;
    uint State;
    Guid PartitionId;
    Guid DriveId;
    Guid PhysMediaId;
    Guid Library;
    Guid SlotId;
    SYSTEMTIME TimeQueued;
    SYSTEMTIME TimeCompleted;
    byte szApplication;
    byte szUser;
    byte szComputer;
    uint dwErrorCode;
    Guid WorkItemId;
    uint dwPriority;
}

struct NTMS_LIBREQUESTINFORMATIONW
{
    uint OperationCode;
    uint OperationOption;
    uint State;
    Guid PartitionId;
    Guid DriveId;
    Guid PhysMediaId;
    Guid Library;
    Guid SlotId;
    SYSTEMTIME TimeQueued;
    SYSTEMTIME TimeCompleted;
    ushort szApplication;
    ushort szUser;
    ushort szComputer;
    uint dwErrorCode;
    Guid WorkItemId;
    uint dwPriority;
}

enum NtmsOpreqCommand
{
    NTMS_OPREQ_UNKNOWN = 0,
    NTMS_OPREQ_NEWMEDIA = 1,
    NTMS_OPREQ_CLEANER = 2,
    NTMS_OPREQ_DEVICESERVICE = 3,
    NTMS_OPREQ_MOVEMEDIA = 4,
    NTMS_OPREQ_MESSAGE = 5,
}

enum NtmsOpreqState
{
    NTMS_OPSTATE_UNKNOWN = 0,
    NTMS_OPSTATE_SUBMITTED = 1,
    NTMS_OPSTATE_ACTIVE = 2,
    NTMS_OPSTATE_INPROGRESS = 3,
    NTMS_OPSTATE_REFUSED = 4,
    NTMS_OPSTATE_COMPLETE = 5,
}

struct NTMS_OPREQUESTINFORMATIONA
{
    uint Request;
    SYSTEMTIME Submitted;
    uint State;
    byte szMessage;
    uint Arg1Type;
    Guid Arg1;
    uint Arg2Type;
    Guid Arg2;
    byte szApplication;
    byte szUser;
    byte szComputer;
}

struct NTMS_OPREQUESTINFORMATIONW
{
    uint Request;
    SYSTEMTIME Submitted;
    uint State;
    ushort szMessage;
    uint Arg1Type;
    Guid Arg1;
    uint Arg2Type;
    Guid Arg2;
    ushort szApplication;
    ushort szUser;
    ushort szComputer;
}

struct NTMS_COMPUTERINFORMATION
{
    uint dwLibRequestPurgeTime;
    uint dwOpRequestPurgeTime;
    uint dwLibRequestFlags;
    uint dwOpRequestFlags;
    uint dwMediaPoolPolicy;
}

enum NtmsLibRequestFlags
{
    NTMS_LIBREQFLAGS_NOAUTOPURGE = 1,
    NTMS_LIBREQFLAGS_NOFAILEDPURGE = 2,
}

enum NtmsOpRequestFlags
{
    NTMS_OPREQFLAGS_NOAUTOPURGE = 1,
    NTMS_OPREQFLAGS_NOFAILEDPURGE = 2,
    NTMS_OPREQFLAGS_NOALERTS = 16,
    NTMS_OPREQFLAGS_NOTRAYICON = 32,
}

enum NtmsMediaPoolPolicy
{
    NTMS_POOLPOLICY_PURGEOFFLINESCRATCH = 1,
    NTMS_POOLPOLICY_KEEPOFFLINEIMPORT = 2,
}

enum NtmsOperationalState
{
    NTMS_READY = 0,
    NTMS_INITIALIZING = 10,
    NTMS_NEEDS_SERVICE = 20,
    NTMS_NOT_PRESENT = 21,
}

struct NTMS_OBJECTINFORMATIONA
{
    uint dwSize;
    uint dwType;
    SYSTEMTIME Created;
    SYSTEMTIME Modified;
    Guid ObjectGuid;
    BOOL Enabled;
    uint dwOperationalState;
    byte szName;
    byte szDescription;
    _Info_e__Union Info;
}

struct NTMS_OBJECTINFORMATIONW
{
    uint dwSize;
    uint dwType;
    SYSTEMTIME Created;
    SYSTEMTIME Modified;
    Guid ObjectGuid;
    BOOL Enabled;
    uint dwOperationalState;
    ushort szName;
    ushort szDescription;
    _Info_e__Union Info;
}

struct NTMS_I1_LIBRARYINFORMATION
{
    uint LibraryType;
    Guid CleanerSlot;
    Guid CleanerSlotDefault;
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
    Guid Reserved;
}

struct NTMS_I1_LIBREQUESTINFORMATIONA
{
    uint OperationCode;
    uint OperationOption;
    uint State;
    Guid PartitionId;
    Guid DriveId;
    Guid PhysMediaId;
    Guid Library;
    Guid SlotId;
    SYSTEMTIME TimeQueued;
    SYSTEMTIME TimeCompleted;
    byte szApplication;
    byte szUser;
    byte szComputer;
}

struct NTMS_I1_LIBREQUESTINFORMATIONW
{
    uint OperationCode;
    uint OperationOption;
    uint State;
    Guid PartitionId;
    Guid DriveId;
    Guid PhysMediaId;
    Guid Library;
    Guid SlotId;
    SYSTEMTIME TimeQueued;
    SYSTEMTIME TimeCompleted;
    ushort szApplication;
    ushort szUser;
    ushort szComputer;
}

struct NTMS_I1_PMIDINFORMATIONA
{
    Guid CurrentLibrary;
    Guid MediaPool;
    Guid Location;
    uint LocationType;
    Guid MediaType;
    Guid HomeSlot;
    byte szBarCode;
    uint BarCodeState;
    byte szSequenceNumber;
    uint MediaState;
    uint dwNumberOfPartitions;
}

struct NTMS_I1_PMIDINFORMATIONW
{
    Guid CurrentLibrary;
    Guid MediaPool;
    Guid Location;
    uint LocationType;
    Guid MediaType;
    Guid HomeSlot;
    ushort szBarCode;
    uint BarCodeState;
    ushort szSequenceNumber;
    uint MediaState;
    uint dwNumberOfPartitions;
}

struct NTMS_I1_PARTITIONINFORMATIONA
{
    Guid PhysicalMedia;
    Guid LogicalMedia;
    uint State;
    ushort Side;
    uint dwOmidLabelIdLength;
    ubyte OmidLabelId;
    byte szOmidLabelType;
    byte szOmidLabelInfo;
    uint dwMountCount;
    uint dwAllocateCount;
}

struct NTMS_I1_PARTITIONINFORMATIONW
{
    Guid PhysicalMedia;
    Guid LogicalMedia;
    uint State;
    ushort Side;
    uint dwOmidLabelIdLength;
    ubyte OmidLabelId;
    ushort szOmidLabelType;
    ushort szOmidLabelInfo;
    uint dwMountCount;
    uint dwAllocateCount;
}

struct NTMS_I1_OPREQUESTINFORMATIONA
{
    uint Request;
    SYSTEMTIME Submitted;
    uint State;
    byte szMessage;
    uint Arg1Type;
    Guid Arg1;
    uint Arg2Type;
    Guid Arg2;
    byte szApplication;
    byte szUser;
    byte szComputer;
}

struct NTMS_I1_OPREQUESTINFORMATIONW
{
    uint Request;
    SYSTEMTIME Submitted;
    uint State;
    ushort szMessage;
    uint Arg1Type;
    Guid Arg1;
    uint Arg2Type;
    Guid Arg2;
    ushort szApplication;
    ushort szUser;
    ushort szComputer;
}

struct NTMS_I1_OBJECTINFORMATIONA
{
    uint dwSize;
    uint dwType;
    SYSTEMTIME Created;
    SYSTEMTIME Modified;
    Guid ObjectGuid;
    BOOL Enabled;
    uint dwOperationalState;
    byte szName;
    byte szDescription;
    _Info_e__Union Info;
}

struct NTMS_I1_OBJECTINFORMATIONW
{
    uint dwSize;
    uint dwType;
    SYSTEMTIME Created;
    SYSTEMTIME Modified;
    Guid ObjectGuid;
    BOOL Enabled;
    uint dwOperationalState;
    ushort szName;
    ushort szDescription;
    _Info_e__Union Info;
}

enum NtmsCreateNtmsMediaOptions
{
    NTMS_ERROR_ON_DUPLICATE = 1,
}

enum NtmsEnumerateOption
{
    NTMS_ENUM_DEFAULT = 0,
    NTMS_ENUM_ROOTPOOL = 1,
}

enum NtmsEjectOperation
{
    NTMS_EJECT_START = 0,
    NTMS_EJECT_STOP = 1,
    NTMS_EJECT_QUEUE = 2,
    NTMS_EJECT_FORCE = 3,
    NTMS_EJECT_IMMEDIATE = 4,
    NTMS_EJECT_ASK_USER = 5,
}

enum NtmsInjectOperation
{
    NTMS_INJECT_START = 0,
    NTMS_INJECT_STOP = 1,
    NTMS_INJECT_RETRACT = 2,
    NTMS_INJECT_STARTMANY = 3,
}

struct NTMS_FILESYSTEM_INFO
{
    ushort FileSystemType;
    ushort VolumeName;
    uint SerialNumber;
}

enum NtmsDriveType
{
    NTMS_UNKNOWN_DRIVE = 0,
}

enum NtmsAccessMask
{
    NTMS_USE_ACCESS = 1,
    NTMS_MODIFY_ACCESS = 2,
    NTMS_CONTROL_ACCESS = 4,
}

enum NtmsUITypes
{
    NTMS_UITYPE_INVALID = 0,
    NTMS_UITYPE_INFO = 1,
    NTMS_UITYPE_REQ = 2,
    NTMS_UITYPE_ERR = 3,
    NTMS_UITYPE_MAX = 4,
}

enum NtmsUIOperations
{
    NTMS_UIDEST_ADD = 1,
    NTMS_UIDEST_DELETE = 2,
    NTMS_UIDEST_DELETEALL = 3,
    NTMS_UIOPERATION_MAX = 4,
}

enum NtmsNotificationOperations
{
    NTMS_OBJ_UPDATE = 1,
    NTMS_OBJ_INSERT = 2,
    NTMS_OBJ_DELETE = 3,
    NTMS_EVENT_SIGNAL = 4,
    NTMS_EVENT_COMPLETE = 5,
}

struct NTMS_NOTIFICATIONINFORMATION
{
    uint dwOperation;
    Guid ObjectId;
}

struct MediaLabelInfo
{
    ushort LabelType;
    uint LabelIDSize;
    ubyte LabelID;
    ushort LabelAppDescr;
}

alias MAXMEDIALABEL = extern(Windows) uint function(uint* pMaxSize);
alias CLAIMMEDIALABEL = extern(Windows) uint function(const(ubyte)* pBuffer, const(uint) nBufferSize, MediaLabelInfo* pLabelInfo);
alias CLAIMMEDIALABELEX = extern(Windows) uint function(const(ubyte)* pBuffer, const(uint) nBufferSize, MediaLabelInfo* pLabelInfo, Guid* LabelGuid);
struct CLS_LSN
{
    ulong Internal;
}

enum CLS_CONTEXT_MODE
{
    ClsContextNone = 0,
    ClsContextUndoNext = 1,
    ClsContextPrevious = 2,
    ClsContextForward = 3,
}

enum CLFS_CONTEXT_MODE
{
    ClfsContextNone = 0,
    ClfsContextUndoNext = 1,
    ClfsContextPrevious = 2,
    ClfsContextForward = 3,
}

struct CLFS_NODE_ID
{
    uint cType;
    uint cbNode;
}

struct CLS_WRITE_ENTRY
{
    void* Buffer;
    uint ByteLength;
}

struct CLS_INFORMATION
{
    long TotalAvailable;
    long CurrentAvailable;
    long TotalReservation;
    ulong BaseFileSize;
    ulong ContainerSize;
    uint TotalContainers;
    uint FreeContainers;
    uint TotalClients;
    uint Attributes;
    uint FlushThreshold;
    uint SectorSize;
    CLS_LSN MinArchiveTailLsn;
    CLS_LSN BaseLsn;
    CLS_LSN LastFlushedLsn;
    CLS_LSN LastLsn;
    CLS_LSN RestartLsn;
    Guid Identity;
}

struct CLFS_LOG_NAME_INFORMATION
{
    ushort NameLengthInBytes;
    ushort Name;
}

struct CLFS_STREAM_ID_INFORMATION
{
    ubyte StreamIdentifier;
}

struct CLFS_PHYSICAL_LSN_INFORMATION
{
    ubyte StreamIdentifier;
    CLS_LSN VirtualLsn;
    CLS_LSN PhysicalLsn;
}

struct CLS_CONTAINER_INFORMATION
{
    uint FileAttributes;
    ulong CreationTime;
    ulong LastAccessTime;
    ulong LastWriteTime;
    long ContainerSize;
    uint FileNameActualLength;
    uint FileNameLength;
    ushort FileName;
    uint State;
    uint PhysicalContainerId;
    uint LogicalContainerId;
}

enum CLS_LOG_INFORMATION_CLASS
{
    ClfsLogBasicInformation = 0,
    ClfsLogBasicInformationPhysical = 1,
    ClfsLogPhysicalNameInformation = 2,
    ClfsLogStreamIdentifierInformation = 3,
    ClfsLogSystemMarkingInformation = 4,
    ClfsLogPhysicalLsnInformation = 5,
}

enum CLS_IOSTATS_CLASS
{
    ClsIoStatsDefault = 0,
    ClsIoStatsMax = 65535,
}

enum CLFS_IOSTATS_CLASS
{
    ClfsIoStatsDefault = 0,
    ClfsIoStatsMax = 65535,
}

struct CLS_IO_STATISTICS_HEADER
{
    ubyte ubMajorVersion;
    ubyte ubMinorVersion;
    CLFS_IOSTATS_CLASS eStatsClass;
    ushort cbLength;
    uint coffData;
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
    HANDLE hLog;
    uint cIndex;
    uint cContainers;
    uint cContainersReturned;
    ubyte eScanMode;
    CLS_CONTAINER_INFORMATION* pinfoContainer;
}

struct CLS_ARCHIVE_DESCRIPTOR
{
    ulong coffLow;
    ulong coffHigh;
    CLS_CONTAINER_INFORMATION infoContainer;
}

alias CLFS_BLOCK_ALLOCATION = extern(Windows) void* function(uint cbBufferLength, void* pvUserContext);
alias CLFS_BLOCK_DEALLOCATION = extern(Windows) void function(void* pvBuffer, void* pvUserContext);
enum CLFS_LOG_ARCHIVE_MODE
{
    ClfsLogArchiveEnabled = 1,
    ClfsLogArchiveDisabled = 2,
}

alias PCLFS_COMPLETION_ROUTINE = extern(Windows) void function(void* pvOverlapped, uint ulReserved);
enum CLFS_MGMT_POLICY_TYPE
{
    ClfsMgmtPolicyMaximumSize = 0,
    ClfsMgmtPolicyMinimumSize = 1,
    ClfsMgmtPolicyNewContainerSize = 2,
    ClfsMgmtPolicyGrowthRate = 3,
    ClfsMgmtPolicyLogTail = 4,
    ClfsMgmtPolicyAutoShrink = 5,
    ClfsMgmtPolicyAutoGrow = 6,
    ClfsMgmtPolicyNewContainerPrefix = 7,
    ClfsMgmtPolicyNewContainerSuffix = 8,
    ClfsMgmtPolicyNewContainerExtension = 9,
    ClfsMgmtPolicyInvalid = 10,
}

struct CLFS_MGMT_POLICY
{
    uint Version;
    uint LengthInBytes;
    uint PolicyFlags;
    CLFS_MGMT_POLICY_TYPE PolicyType;
    _PolicyParameters_e__Union PolicyParameters;
}

enum CLFS_MGMT_NOTIFICATION_TYPE
{
    ClfsMgmtAdvanceTailNotification = 0,
    ClfsMgmtLogFullHandlerNotification = 1,
    ClfsMgmtLogUnpinnedNotification = 2,
    ClfsMgmtLogWriteNotification = 3,
}

struct CLFS_MGMT_NOTIFICATION
{
    CLFS_MGMT_NOTIFICATION_TYPE Notification;
    CLS_LSN Lsn;
    ushort LogIsPinned;
}

alias PLOG_TAIL_ADVANCE_CALLBACK = extern(Windows) void function(HANDLE hLogFile, CLS_LSN lsnTarget, void* pvClientContext);
alias PLOG_FULL_HANDLER_CALLBACK = extern(Windows) void function(HANDLE hLogFile, uint dwError, BOOL fLogIsPinned, void* pvClientContext);
alias PLOG_UNPINNED_CALLBACK = extern(Windows) void function(HANDLE hLogFile, void* pvClientContext);
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

const GUID IID_IDiskQuotaUser = {0x7988B574, 0xEC89, 0x11CF, [0x9C, 0x00, 0x00, 0xAA, 0x00, 0xA1, 0x4F, 0x56]};
@GUID(0x7988B574, 0xEC89, 0x11CF, [0x9C, 0x00, 0x00, 0xAA, 0x00, 0xA1, 0x4F, 0x56]);
interface IDiskQuotaUser : IUnknown
{
    HRESULT GetID(uint* pulID);
    HRESULT GetName(const(wchar)* pszAccountContainer, uint cchAccountContainer, const(wchar)* pszLogonName, uint cchLogonName, const(wchar)* pszDisplayName, uint cchDisplayName);
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

const GUID IID_IEnumDiskQuotaUsers = {0x7988B577, 0xEC89, 0x11CF, [0x9C, 0x00, 0x00, 0xAA, 0x00, 0xA1, 0x4F, 0x56]};
@GUID(0x7988B577, 0xEC89, 0x11CF, [0x9C, 0x00, 0x00, 0xAA, 0x00, 0xA1, 0x4F, 0x56]);
interface IEnumDiskQuotaUsers : IUnknown
{
    HRESULT Next(uint cUsers, IDiskQuotaUser* rgUsers, uint* pcUsersFetched);
    HRESULT Skip(uint cUsers);
    HRESULT Reset();
    HRESULT Clone(IEnumDiskQuotaUsers* ppEnum);
}

const GUID IID_IDiskQuotaUserBatch = {0x7988B576, 0xEC89, 0x11CF, [0x9C, 0x00, 0x00, 0xAA, 0x00, 0xA1, 0x4F, 0x56]};
@GUID(0x7988B576, 0xEC89, 0x11CF, [0x9C, 0x00, 0x00, 0xAA, 0x00, 0xA1, 0x4F, 0x56]);
interface IDiskQuotaUserBatch : IUnknown
{
    HRESULT Add(IDiskQuotaUser pUser);
    HRESULT Remove(IDiskQuotaUser pUser);
    HRESULT RemoveAll();
    HRESULT FlushToDisk();
}

const GUID IID_IDiskQuotaControl = {0x7988B572, 0xEC89, 0x11CF, [0x9C, 0x00, 0x00, 0xAA, 0x00, 0xA1, 0x4F, 0x56]};
@GUID(0x7988B572, 0xEC89, 0x11CF, [0x9C, 0x00, 0x00, 0xAA, 0x00, 0xA1, 0x4F, 0x56]);
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

const GUID IID_IDiskQuotaEvents = {0x7988B579, 0xEC89, 0x11CF, [0x9C, 0x00, 0x00, 0xAA, 0x00, 0xA1, 0x4F, 0x56]};
@GUID(0x7988B579, 0xEC89, 0x11CF, [0x9C, 0x00, 0x00, 0xAA, 0x00, 0xA1, 0x4F, 0x56]);
interface IDiskQuotaEvents : IUnknown
{
    HRESULT OnUserNameChanged(IDiskQuotaUser pUser);
}

alias WofEnumEntryProc = extern(Windows) BOOL function(const(void)* EntryInfo, void* UserData);
alias WofEnumFilesProc = extern(Windows) BOOL function(const(wchar)* FilePath, void* ExternalFileInfo, void* UserData);
struct WIM_ENTRY_INFO
{
    uint WimEntryInfoSize;
    uint WimType;
    LARGE_INTEGER DataSourceId;
    Guid WimGuid;
    const(wchar)* WimPath;
    uint WimIndex;
    uint Flags;
}

struct WIM_EXTERNAL_FILE_INFO
{
    LARGE_INTEGER DataSourceId;
    ubyte ResourceHash;
    uint Flags;
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
    _Anonymous_e__Struct Anonymous;
}

struct TXF_LOG_RECORD_BASE
{
    ushort Version;
    ushort RecordType;
    uint RecordLength;
}

struct TXF_LOG_RECORD_WRITE
{
    ushort Version;
    ushort RecordType;
    uint RecordLength;
    uint Flags;
    TXF_ID TxfFileId;
    Guid KtmGuid;
    long ByteOffsetInFile;
    uint NumBytesWritten;
    uint ByteOffsetInStructure;
    uint FileNameLength;
    uint FileNameByteOffsetInStructure;
}

struct TXF_LOG_RECORD_TRUNCATE
{
    ushort Version;
    ushort RecordType;
    uint RecordLength;
    uint Flags;
    TXF_ID TxfFileId;
    Guid KtmGuid;
    long NewFileSize;
    uint FileNameLength;
    uint FileNameByteOffsetInStructure;
}

struct TXF_LOG_RECORD_AFFECTED_FILE
{
    ushort Version;
    uint RecordLength;
    uint Flags;
    TXF_ID TxfFileId;
    Guid KtmGuid;
    uint FileNameLength;
    uint FileNameByteOffsetInStructure;
}

struct VOLUME_FAILOVER_SET
{
    uint NumberOfDisks;
    uint DiskNumbers;
}

struct VOLUME_NUMBER
{
    uint VolumeNumber;
    ushort VolumeManagerName;
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
    VOLUME_PHYSICAL_OFFSET PhysicalOffset;
}

struct VOLUME_READ_PLEX_INPUT
{
    LARGE_INTEGER ByteOffset;
    uint Length;
    uint PlexNumber;
}

struct VOLUME_SET_GPT_ATTRIBUTES_INFORMATION
{
    ulong GptAttributes;
    ubyte RevertOnClose;
    ubyte ApplyToAllConnectedVolumes;
    ushort Reserved1;
    uint Reserved2;
}

struct VOLUME_GET_BC_PROPERTIES_INPUT
{
    uint Version;
    uint Reserved1;
    ulong LowestByteOffset;
    ulong HighestByteOffset;
    uint AccessType;
    uint AccessMode;
}

struct VOLUME_GET_BC_PROPERTIES_OUTPUT
{
    uint MaximumRequestsPerPeriod;
    uint MinimumPeriod;
    ulong MaximumRequestSize;
    uint EstimatedTimePerRequest;
    uint NumOutStandingRequests;
    ulong RequestSize;
}

struct VOLUME_ALLOCATE_BC_STREAM_INPUT
{
    uint Version;
    uint RequestsPerPeriod;
    uint Period;
    ubyte RetryFailures;
    ubyte Discardable;
    ubyte Reserved1;
    ulong LowestByteOffset;
    ulong HighestByteOffset;
    uint AccessType;
    uint AccessMode;
}

struct VOLUME_ALLOCATE_BC_STREAM_OUTPUT
{
    ulong RequestSize;
    uint NumOutStandingRequests;
}

struct FILE_EXTENT
{
    ulong VolumeOffset;
    ulong ExtentLength;
}

struct VOLUME_CRITICAL_IO
{
    uint AccessType;
    uint ExtentsCount;
    FILE_EXTENT Extents;
}

struct VOLUME_ALLOCATION_HINT_INPUT
{
    uint ClusterSize;
    uint NumberOfClusters;
    long StartingClusterNumber;
}

struct VOLUME_ALLOCATION_HINT_OUTPUT
{
    uint Bitmap;
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
    uint shi1_type;
    const(wchar)* shi1_remark;
}

struct SHARE_INFO_2
{
    const(wchar)* shi2_netname;
    uint shi2_type;
    const(wchar)* shi2_remark;
    uint shi2_permissions;
    uint shi2_max_uses;
    uint shi2_current_uses;
    const(wchar)* shi2_path;
    const(wchar)* shi2_passwd;
}

struct SHARE_INFO_501
{
    const(wchar)* shi501_netname;
    uint shi501_type;
    const(wchar)* shi501_remark;
    uint shi501_flags;
}

struct SHARE_INFO_502
{
    const(wchar)* shi502_netname;
    uint shi502_type;
    const(wchar)* shi502_remark;
    uint shi502_permissions;
    uint shi502_max_uses;
    uint shi502_current_uses;
    const(wchar)* shi502_path;
    const(wchar)* shi502_passwd;
    uint shi502_reserved;
    void* shi502_security_descriptor;
}

struct SHARE_INFO_503
{
    const(wchar)* shi503_netname;
    uint shi503_type;
    const(wchar)* shi503_remark;
    uint shi503_permissions;
    uint shi503_max_uses;
    uint shi503_current_uses;
    const(wchar)* shi503_path;
    const(wchar)* shi503_passwd;
    const(wchar)* shi503_servername;
    uint shi503_reserved;
    void* shi503_security_descriptor;
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
    uint shi1501_reserved;
    void* shi1501_security_descriptor;
}

struct SHARE_INFO_1503
{
    Guid shi1503_sharefilter;
}

struct SERVER_ALIAS_INFO_0
{
    const(wchar)* srvai0_alias;
    const(wchar)* srvai0_target;
    ubyte srvai0_default;
    uint srvai0_reserved;
}

struct SESSION_INFO_0
{
    const(wchar)* sesi0_cname;
}

struct SESSION_INFO_1
{
    const(wchar)* sesi1_cname;
    const(wchar)* sesi1_username;
    uint sesi1_num_opens;
    uint sesi1_time;
    uint sesi1_idle_time;
    uint sesi1_user_flags;
}

struct SESSION_INFO_2
{
    const(wchar)* sesi2_cname;
    const(wchar)* sesi2_username;
    uint sesi2_num_opens;
    uint sesi2_time;
    uint sesi2_idle_time;
    uint sesi2_user_flags;
    const(wchar)* sesi2_cltype_name;
}

struct SESSION_INFO_10
{
    const(wchar)* sesi10_cname;
    const(wchar)* sesi10_username;
    uint sesi10_time;
    uint sesi10_idle_time;
}

struct SESSION_INFO_502
{
    const(wchar)* sesi502_cname;
    const(wchar)* sesi502_username;
    uint sesi502_num_opens;
    uint sesi502_time;
    uint sesi502_idle_time;
    uint sesi502_user_flags;
    const(wchar)* sesi502_cltype_name;
    const(wchar)* sesi502_transport;
}

struct CONNECTION_INFO_0
{
    uint coni0_id;
}

struct CONNECTION_INFO_1
{
    uint coni1_id;
    uint coni1_type;
    uint coni1_num_opens;
    uint coni1_num_users;
    uint coni1_time;
    const(wchar)* coni1_username;
    const(wchar)* coni1_netname;
}

struct FILE_INFO_2
{
    uint fi2_id;
}

struct FILE_INFO_3
{
    uint fi3_id;
    uint fi3_permissions;
    uint fi3_num_locks;
    const(wchar)* fi3_pathname;
    const(wchar)* fi3_username;
}

enum SERVER_CERTIFICATE_TYPE
{
    QUIC = 0,
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
    uint srvci0_type;
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
    uint InitiallyFailedOperations;
    uint FailedCompletionOperations;
    uint ReadOperations;
    uint RandomReadOperations;
    uint ReadSmbs;
    uint LargeReadSmbs;
    uint SmallReadSmbs;
    uint WriteOperations;
    uint RandomWriteOperations;
    uint WriteSmbs;
    uint LargeWriteSmbs;
    uint SmallWriteSmbs;
    uint RawReadsDenied;
    uint RawWritesDenied;
    uint NetworkErrors;
    uint Sessions;
    uint FailedSessions;
    uint Reconnects;
    uint CoreConnects;
    uint Lanman20Connects;
    uint Lanman21Connects;
    uint LanmanNtConnects;
    uint ServerDisconnects;
    uint HungSessions;
    uint UseCount;
    uint FailedUseCount;
    uint CurrentCommands;
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

@DllImport("KERNEL32.dll")
BOOL CreateDirectoryA(const(char)* lpPathName, SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("KERNEL32.dll")
BOOL CreateDirectoryW(const(wchar)* lpPathName, SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("KERNEL32.dll")
HANDLE CreateFileA(const(char)* lpFileName, FILE_ACCESS_FLAGS dwDesiredAccess, FILE_SHARE_FLAGS dwShareMode, SECURITY_ATTRIBUTES* lpSecurityAttributes, FILE_CREATE_FLAGS dwCreationDisposition, FILE_FLAGS_AND_ATTRIBUTES dwFlagsAndAttributes, HANDLE hTemplateFile);

@DllImport("KERNEL32.dll")
HANDLE CreateFileW(const(wchar)* lpFileName, FILE_ACCESS_FLAGS dwDesiredAccess, FILE_SHARE_FLAGS dwShareMode, SECURITY_ATTRIBUTES* lpSecurityAttributes, FILE_CREATE_FLAGS dwCreationDisposition, FILE_FLAGS_AND_ATTRIBUTES dwFlagsAndAttributes, HANDLE hTemplateFile);

@DllImport("KERNEL32.dll")
BOOL DefineDosDeviceW(DEFINE_DOS_DEVICE_FLAGS dwFlags, const(wchar)* lpDeviceName, const(wchar)* lpTargetPath);

@DllImport("KERNEL32.dll")
BOOL DeleteFileA(const(char)* lpFileName);

@DllImport("KERNEL32.dll")
BOOL DeleteFileW(const(wchar)* lpFileName);

@DllImport("KERNEL32.dll")
BOOL DeleteVolumeMountPointW(const(wchar)* lpszVolumeMountPoint);

@DllImport("KERNEL32.dll")
BOOL FindClose(HANDLE hFindFile);

@DllImport("KERNEL32.dll")
BOOL FindCloseChangeNotification(FindChangeNotifcationHandle hChangeHandle);

@DllImport("KERNEL32.dll")
FindChangeNotifcationHandle FindFirstChangeNotificationA(const(char)* lpPathName, BOOL bWatchSubtree, FILE_NOTIFY_CHANGE dwNotifyFilter);

@DllImport("KERNEL32.dll")
FindChangeNotifcationHandle FindFirstChangeNotificationW(const(wchar)* lpPathName, BOOL bWatchSubtree, uint dwNotifyFilter);

@DllImport("KERNEL32.dll")
FindFileHandle FindFirstFileA(const(char)* lpFileName, WIN32_FIND_DATAA* lpFindFileData);

@DllImport("KERNEL32.dll")
FindFileHandle FindFirstFileW(const(wchar)* lpFileName, WIN32_FIND_DATAW* lpFindFileData);

@DllImport("KERNEL32.dll")
FindFileHandle FindFirstFileExA(const(char)* lpFileName, FINDEX_INFO_LEVELS fInfoLevelId, char* lpFindFileData, FINDEX_SEARCH_OPS fSearchOp, void* lpSearchFilter, FIND_FIRST_EX_FLAGS dwAdditionalFlags);

@DllImport("KERNEL32.dll")
FindFileHandle FindFirstFileExW(const(wchar)* lpFileName, FINDEX_INFO_LEVELS fInfoLevelId, char* lpFindFileData, FINDEX_SEARCH_OPS fSearchOp, void* lpSearchFilter, FIND_FIRST_EX_FLAGS dwAdditionalFlags);

@DllImport("KERNEL32.dll")
FindVolumeHandle FindFirstVolumeW(const(wchar)* lpszVolumeName, uint cchBufferLength);

@DllImport("KERNEL32.dll")
BOOL FindNextChangeNotification(FindChangeNotifcationHandle hChangeHandle);

@DllImport("KERNEL32.dll")
BOOL FindNextFileA(FindFileHandle hFindFile, WIN32_FIND_DATAA* lpFindFileData);

@DllImport("KERNEL32.dll")
BOOL FindNextFileW(HANDLE hFindFile, WIN32_FIND_DATAW* lpFindFileData);

@DllImport("KERNEL32.dll")
BOOL FindNextVolumeW(FindVolumeHandle hFindVolume, const(wchar)* lpszVolumeName, uint cchBufferLength);

@DllImport("KERNEL32.dll")
BOOL FindVolumeClose(FindVolumeHandle hFindVolume);

@DllImport("KERNEL32.dll")
BOOL FlushFileBuffers(HANDLE hFile);

@DllImport("KERNEL32.dll")
BOOL GetDiskFreeSpaceA(const(char)* lpRootPathName, uint* lpSectorsPerCluster, uint* lpBytesPerSector, uint* lpNumberOfFreeClusters, uint* lpTotalNumberOfClusters);

@DllImport("KERNEL32.dll")
BOOL GetDiskFreeSpaceW(const(wchar)* lpRootPathName, uint* lpSectorsPerCluster, uint* lpBytesPerSector, uint* lpNumberOfFreeClusters, uint* lpTotalNumberOfClusters);

@DllImport("KERNEL32.dll")
BOOL GetDiskFreeSpaceExA(const(char)* lpDirectoryName, ULARGE_INTEGER* lpFreeBytesAvailableToCaller, ULARGE_INTEGER* lpTotalNumberOfBytes, ULARGE_INTEGER* lpTotalNumberOfFreeBytes);

@DllImport("KERNEL32.dll")
BOOL GetDiskFreeSpaceExW(const(wchar)* lpDirectoryName, ULARGE_INTEGER* lpFreeBytesAvailableToCaller, ULARGE_INTEGER* lpTotalNumberOfBytes, ULARGE_INTEGER* lpTotalNumberOfFreeBytes);

@DllImport("KERNEL32.dll")
HRESULT GetDiskSpaceInformationA(const(char)* rootPath, DISK_SPACE_INFORMATION* diskSpaceInfo);

@DllImport("KERNEL32.dll")
HRESULT GetDiskSpaceInformationW(const(wchar)* rootPath, DISK_SPACE_INFORMATION* diskSpaceInfo);

@DllImport("KERNEL32.dll")
uint GetDriveTypeA(const(char)* lpRootPathName);

@DllImport("KERNEL32.dll")
uint GetDriveTypeW(const(wchar)* lpRootPathName);

@DllImport("KERNEL32.dll")
uint GetFileAttributesA(const(char)* lpFileName);

@DllImport("KERNEL32.dll")
uint GetFileAttributesW(const(wchar)* lpFileName);

@DllImport("KERNEL32.dll")
BOOL GetFileAttributesExA(const(char)* lpFileName, GET_FILEEX_INFO_LEVELS fInfoLevelId, char* lpFileInformation);

@DllImport("KERNEL32.dll")
BOOL GetFileAttributesExW(const(wchar)* lpFileName, GET_FILEEX_INFO_LEVELS fInfoLevelId, char* lpFileInformation);

@DllImport("KERNEL32.dll")
BOOL GetFileInformationByHandle(HANDLE hFile, BY_HANDLE_FILE_INFORMATION* lpFileInformation);

@DllImport("KERNEL32.dll")
uint GetFileSize(HANDLE hFile, uint* lpFileSizeHigh);

@DllImport("KERNEL32.dll")
BOOL GetFileSizeEx(HANDLE hFile, LARGE_INTEGER* lpFileSize);

@DllImport("KERNEL32.dll")
uint GetFileType(HANDLE hFile);

@DllImport("KERNEL32.dll")
uint GetFinalPathNameByHandleA(HANDLE hFile, const(char)* lpszFilePath, uint cchFilePath, uint dwFlags);

@DllImport("KERNEL32.dll")
uint GetFinalPathNameByHandleW(HANDLE hFile, const(wchar)* lpszFilePath, uint cchFilePath, uint dwFlags);

@DllImport("KERNEL32.dll")
uint GetFullPathNameW(const(wchar)* lpFileName, uint nBufferLength, const(wchar)* lpBuffer, ushort** lpFilePart);

@DllImport("KERNEL32.dll")
uint GetFullPathNameA(const(char)* lpFileName, uint nBufferLength, const(char)* lpBuffer, byte** lpFilePart);

@DllImport("KERNEL32.dll")
uint GetLogicalDrives();

@DllImport("KERNEL32.dll")
uint GetLogicalDriveStringsW(uint nBufferLength, const(wchar)* lpBuffer);

@DllImport("KERNEL32.dll")
uint GetLongPathNameA(const(char)* lpszShortPath, const(char)* lpszLongPath, uint cchBuffer);

@DllImport("KERNEL32.dll")
uint GetLongPathNameW(const(wchar)* lpszShortPath, const(wchar)* lpszLongPath, uint cchBuffer);

@DllImport("KERNEL32.dll")
uint GetShortPathNameW(const(wchar)* lpszLongPath, const(wchar)* lpszShortPath, uint cchBuffer);

@DllImport("KERNEL32.dll")
uint GetTempFileNameW(const(wchar)* lpPathName, const(wchar)* lpPrefixString, uint uUnique, const(wchar)* lpTempFileName);

@DllImport("KERNEL32.dll")
BOOL GetVolumeInformationByHandleW(HANDLE hFile, const(wchar)* lpVolumeNameBuffer, uint nVolumeNameSize, uint* lpVolumeSerialNumber, uint* lpMaximumComponentLength, uint* lpFileSystemFlags, const(wchar)* lpFileSystemNameBuffer, uint nFileSystemNameSize);

@DllImport("KERNEL32.dll")
BOOL GetVolumeInformationW(const(wchar)* lpRootPathName, const(wchar)* lpVolumeNameBuffer, uint nVolumeNameSize, uint* lpVolumeSerialNumber, uint* lpMaximumComponentLength, uint* lpFileSystemFlags, const(wchar)* lpFileSystemNameBuffer, uint nFileSystemNameSize);

@DllImport("KERNEL32.dll")
BOOL GetVolumePathNameW(const(wchar)* lpszFileName, const(wchar)* lpszVolumePathName, uint cchBufferLength);

@DllImport("KERNEL32.dll")
BOOL LockFile(HANDLE hFile, uint dwFileOffsetLow, uint dwFileOffsetHigh, uint nNumberOfBytesToLockLow, uint nNumberOfBytesToLockHigh);

@DllImport("KERNEL32.dll")
BOOL LockFileEx(HANDLE hFile, uint dwFlags, uint dwReserved, uint nNumberOfBytesToLockLow, uint nNumberOfBytesToLockHigh, OVERLAPPED* lpOverlapped);

@DllImport("KERNEL32.dll")
uint QueryDosDeviceW(const(wchar)* lpDeviceName, const(wchar)* lpTargetPath, uint ucchMax);

@DllImport("KERNEL32.dll")
BOOL ReadFile(HANDLE hFile, char* lpBuffer, uint nNumberOfBytesToRead, uint* lpNumberOfBytesRead, OVERLAPPED* lpOverlapped);

@DllImport("KERNEL32.dll")
BOOL ReadFileEx(HANDLE hFile, char* lpBuffer, uint nNumberOfBytesToRead, OVERLAPPED* lpOverlapped, LPOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

@DllImport("KERNEL32.dll")
BOOL ReadFileScatter(HANDLE hFile, FILE_SEGMENT_ELEMENT* aSegmentArray, uint nNumberOfBytesToRead, uint* lpReserved, OVERLAPPED* lpOverlapped);

@DllImport("KERNEL32.dll")
BOOL RemoveDirectoryA(const(char)* lpPathName);

@DllImport("KERNEL32.dll")
BOOL RemoveDirectoryW(const(wchar)* lpPathName);

@DllImport("KERNEL32.dll")
BOOL SetEndOfFile(HANDLE hFile);

@DllImport("KERNEL32.dll")
BOOL SetFileAttributesA(const(char)* lpFileName, FILE_FLAGS_AND_ATTRIBUTES dwFileAttributes);

@DllImport("KERNEL32.dll")
BOOL SetFileAttributesW(const(wchar)* lpFileName, FILE_FLAGS_AND_ATTRIBUTES dwFileAttributes);

@DllImport("KERNEL32.dll")
BOOL SetFileInformationByHandle(HANDLE hFile, FILE_INFO_BY_HANDLE_CLASS FileInformationClass, char* lpFileInformation, uint dwBufferSize);

@DllImport("KERNEL32.dll")
uint SetFilePointer(HANDLE hFile, int lDistanceToMove, int* lpDistanceToMoveHigh, uint dwMoveMethod);

@DllImport("KERNEL32.dll")
BOOL SetFilePointerEx(HANDLE hFile, LARGE_INTEGER liDistanceToMove, LARGE_INTEGER* lpNewFilePointer, uint dwMoveMethod);

@DllImport("KERNEL32.dll")
BOOL SetFileValidData(HANDLE hFile, long ValidDataLength);

@DllImport("KERNEL32.dll")
BOOL UnlockFile(HANDLE hFile, uint dwFileOffsetLow, uint dwFileOffsetHigh, uint nNumberOfBytesToUnlockLow, uint nNumberOfBytesToUnlockHigh);

@DllImport("KERNEL32.dll")
BOOL UnlockFileEx(HANDLE hFile, uint dwReserved, uint nNumberOfBytesToUnlockLow, uint nNumberOfBytesToUnlockHigh, OVERLAPPED* lpOverlapped);

@DllImport("KERNEL32.dll")
BOOL WriteFile(HANDLE hFile, char* lpBuffer, uint nNumberOfBytesToWrite, uint* lpNumberOfBytesWritten, OVERLAPPED* lpOverlapped);

@DllImport("KERNEL32.dll")
BOOL WriteFileEx(HANDLE hFile, char* lpBuffer, uint nNumberOfBytesToWrite, OVERLAPPED* lpOverlapped, LPOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

@DllImport("KERNEL32.dll")
BOOL WriteFileGather(HANDLE hFile, FILE_SEGMENT_ELEMENT* aSegmentArray, uint nNumberOfBytesToWrite, uint* lpReserved, OVERLAPPED* lpOverlapped);

@DllImport("KERNEL32.dll")
uint GetTempPathW(uint nBufferLength, const(wchar)* lpBuffer);

@DllImport("KERNEL32.dll")
BOOL GetVolumeNameForVolumeMountPointW(const(wchar)* lpszVolumeMountPoint, const(wchar)* lpszVolumeName, uint cchBufferLength);

@DllImport("KERNEL32.dll")
BOOL GetVolumePathNamesForVolumeNameW(const(wchar)* lpszVolumeName, const(wchar)* lpszVolumePathNames, uint cchBufferLength, uint* lpcchReturnLength);

@DllImport("KERNEL32.dll")
HANDLE CreateFile2(const(wchar)* lpFileName, FILE_ACCESS_FLAGS dwDesiredAccess, FILE_SHARE_FLAGS dwShareMode, FILE_CREATE_FLAGS dwCreationDisposition, CREATEFILE2_EXTENDED_PARAMETERS* pCreateExParams);

@DllImport("KERNEL32.dll")
BOOL SetFileIoOverlappedRange(HANDLE FileHandle, ubyte* OverlappedRangeStart, uint Length);

@DllImport("KERNEL32.dll")
uint GetCompressedFileSizeA(const(char)* lpFileName, uint* lpFileSizeHigh);

@DllImport("KERNEL32.dll")
uint GetCompressedFileSizeW(const(wchar)* lpFileName, uint* lpFileSizeHigh);

@DllImport("KERNEL32.dll")
FindStreamHandle FindFirstStreamW(const(wchar)* lpFileName, STREAM_INFO_LEVELS InfoLevel, char* lpFindStreamData, uint dwFlags);

@DllImport("KERNEL32.dll")
BOOL FindNextStreamW(FindStreamHandle hFindStream, char* lpFindStreamData);

@DllImport("KERNEL32.dll")
BOOL AreFileApisANSI();

@DllImport("KERNEL32.dll")
uint GetTempPathA(uint nBufferLength, const(char)* lpBuffer);

@DllImport("KERNEL32.dll")
FindFileNameHandle FindFirstFileNameW(const(wchar)* lpFileName, uint dwFlags, uint* StringLength, const(wchar)* LinkName);

@DllImport("KERNEL32.dll")
BOOL FindNextFileNameW(FindFileNameHandle hFindStream, uint* StringLength, const(wchar)* LinkName);

@DllImport("KERNEL32.dll")
BOOL GetVolumeInformationA(const(char)* lpRootPathName, const(char)* lpVolumeNameBuffer, uint nVolumeNameSize, uint* lpVolumeSerialNumber, uint* lpMaximumComponentLength, uint* lpFileSystemFlags, const(char)* lpFileSystemNameBuffer, uint nFileSystemNameSize);

@DllImport("KERNEL32.dll")
uint GetTempFileNameA(const(char)* lpPathName, const(char)* lpPrefixString, uint uUnique, const(char)* lpTempFileName);

@DllImport("KERNEL32.dll")
void SetFileApisToOEM();

@DllImport("KERNEL32.dll")
void SetFileApisToANSI();

@DllImport("api-ms-win-core-file-fromapp-l1-1-0.dll")
BOOL CopyFileFromAppW(const(wchar)* lpExistingFileName, const(wchar)* lpNewFileName, BOOL bFailIfExists);

@DllImport("api-ms-win-core-file-fromapp-l1-1-0.dll")
BOOL CreateDirectoryFromAppW(const(wchar)* lpPathName, SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("api-ms-win-core-file-fromapp-l1-1-0.dll")
HANDLE CreateFileFromAppW(const(wchar)* lpFileName, uint dwDesiredAccess, uint dwShareMode, SECURITY_ATTRIBUTES* lpSecurityAttributes, uint dwCreationDisposition, uint dwFlagsAndAttributes, HANDLE hTemplateFile);

@DllImport("api-ms-win-core-file-fromapp-l1-1-0.dll")
HANDLE CreateFile2FromAppW(const(wchar)* lpFileName, uint dwDesiredAccess, uint dwShareMode, uint dwCreationDisposition, CREATEFILE2_EXTENDED_PARAMETERS* pCreateExParams);

@DllImport("api-ms-win-core-file-fromapp-l1-1-0.dll")
BOOL DeleteFileFromAppW(const(wchar)* lpFileName);

@DllImport("api-ms-win-core-file-fromapp-l1-1-0.dll")
HANDLE FindFirstFileExFromAppW(const(wchar)* lpFileName, FINDEX_INFO_LEVELS fInfoLevelId, char* lpFindFileData, FINDEX_SEARCH_OPS fSearchOp, void* lpSearchFilter, uint dwAdditionalFlags);

@DllImport("api-ms-win-core-file-fromapp-l1-1-0.dll")
BOOL GetFileAttributesExFromAppW(const(wchar)* lpFileName, GET_FILEEX_INFO_LEVELS fInfoLevelId, char* lpFileInformation);

@DllImport("api-ms-win-core-file-fromapp-l1-1-0.dll")
BOOL MoveFileFromAppW(const(wchar)* lpExistingFileName, const(wchar)* lpNewFileName);

@DllImport("api-ms-win-core-file-fromapp-l1-1-0.dll")
BOOL RemoveDirectoryFromAppW(const(wchar)* lpPathName);

@DllImport("api-ms-win-core-file-fromapp-l1-1-0.dll")
BOOL ReplaceFileFromAppW(const(wchar)* lpReplacedFileName, const(wchar)* lpReplacementFileName, const(wchar)* lpBackupFileName, uint dwReplaceFlags, void* lpExclude, void* lpReserved);

@DllImport("api-ms-win-core-file-fromapp-l1-1-0.dll")
BOOL SetFileAttributesFromAppW(const(wchar)* lpFileName, uint dwFileAttributes);

@DllImport("KERNEL32.dll")
HANDLE CreateIoCompletionPort(HANDLE FileHandle, HANDLE ExistingCompletionPort, uint CompletionKey, uint NumberOfConcurrentThreads);

@DllImport("KERNEL32.dll")
BOOL GetQueuedCompletionStatus(HANDLE CompletionPort, uint* lpNumberOfBytesTransferred, uint* lpCompletionKey, OVERLAPPED** lpOverlapped, uint dwMilliseconds);

@DllImport("KERNEL32.dll")
BOOL GetQueuedCompletionStatusEx(HANDLE CompletionPort, char* lpCompletionPortEntries, uint ulCount, uint* ulNumEntriesRemoved, uint dwMilliseconds, BOOL fAlertable);

@DllImport("KERNEL32.dll")
BOOL PostQueuedCompletionStatus(HANDLE CompletionPort, uint dwNumberOfBytesTransferred, uint dwCompletionKey, OVERLAPPED* lpOverlapped);

@DllImport("KERNEL32.dll")
BOOL CancelIoEx(HANDLE hFile, OVERLAPPED* lpOverlapped);

@DllImport("KERNEL32.dll")
BOOL CancelIo(HANDLE hFile);

@DllImport("KERNEL32.dll")
BOOL CancelSynchronousIo(HANDLE hThread);

@DllImport("KERNEL32.dll")
BOOL Wow64DisableWow64FsRedirection(void** OldValue);

@DllImport("KERNEL32.dll")
BOOL Wow64RevertWow64FsRedirection(void* OlValue);

@DllImport("api-ms-win-core-wow64-l1-1-1.dll")
ushort Wow64SetThreadDefaultGuestMachine(ushort Machine);

@DllImport("KERNEL32.dll")
uint Wow64SuspendThread(HANDLE hThread);

@DllImport("KERNEL32.dll")
int LZStart();

@DllImport("KERNEL32.dll")
void LZDone();

@DllImport("KERNEL32.dll")
int CopyLZFile(int hfSource, int hfDest);

@DllImport("KERNEL32.dll")
int LZCopy(int hfSource, int hfDest);

@DllImport("KERNEL32.dll")
int LZInit(int hfSource);

@DllImport("KERNEL32.dll")
int GetExpandedNameA(const(char)* lpszSource, const(char)* lpszBuffer);

@DllImport("KERNEL32.dll")
int GetExpandedNameW(const(wchar)* lpszSource, const(wchar)* lpszBuffer);

@DllImport("KERNEL32.dll")
int LZOpenFileA(const(char)* lpFileName, OFSTRUCT* lpReOpenBuf, ushort wStyle);

@DllImport("KERNEL32.dll")
int LZOpenFileW(const(wchar)* lpFileName, OFSTRUCT* lpReOpenBuf, ushort wStyle);

@DllImport("KERNEL32.dll")
int LZSeek(int hFile, int lOffset, int iOrigin);

@DllImport("KERNEL32.dll")
int LZRead(int hFile, char* lpBuffer, int cbRead);

@DllImport("KERNEL32.dll")
void LZClose(int hFile);

@DllImport("ADVAPI32.dll")
uint QueryUsersOnEncryptedFile(const(wchar)* lpFileName, ENCRYPTION_CERTIFICATE_HASH_LIST** pUsers);

@DllImport("ADVAPI32.dll")
uint QueryRecoveryAgentsOnEncryptedFile(const(wchar)* lpFileName, ENCRYPTION_CERTIFICATE_HASH_LIST** pRecoveryAgents);

@DllImport("ADVAPI32.dll")
uint RemoveUsersFromEncryptedFile(const(wchar)* lpFileName, ENCRYPTION_CERTIFICATE_HASH_LIST* pHashes);

@DllImport("ADVAPI32.dll")
uint AddUsersToEncryptedFile(const(wchar)* lpFileName, ENCRYPTION_CERTIFICATE_LIST* pEncryptionCertificates);

@DllImport("ADVAPI32.dll")
uint SetUserFileEncryptionKey(ENCRYPTION_CERTIFICATE* pEncryptionCertificate);

@DllImport("ADVAPI32.dll")
uint SetUserFileEncryptionKeyEx(ENCRYPTION_CERTIFICATE* pEncryptionCertificate, uint dwCapabilities, uint dwFlags, void* pvReserved);

@DllImport("ADVAPI32.dll")
void FreeEncryptionCertificateHashList(ENCRYPTION_CERTIFICATE_HASH_LIST* pUsers);

@DllImport("ADVAPI32.dll")
BOOL EncryptionDisable(const(wchar)* DirPath, BOOL Disable);

@DllImport("ADVAPI32.dll")
uint DuplicateEncryptionInfoFile(const(wchar)* SrcFileName, const(wchar)* DstFileName, uint dwCreationDistribution, uint dwAttributes, const(SECURITY_ATTRIBUTES)* lpSecurityAttributes);

@DllImport("ADVAPI32.dll")
uint GetEncryptedFileMetadata(const(wchar)* lpFileName, uint* pcbMetadata, ubyte** ppbMetadata);

@DllImport("ADVAPI32.dll")
uint SetEncryptedFileMetadata(const(wchar)* lpFileName, ubyte* pbOldMetadata, ubyte* pbNewMetadata, ENCRYPTION_CERTIFICATE_HASH* pOwnerHash, uint dwOperation, ENCRYPTION_CERTIFICATE_HASH_LIST* pCertificatesAdded);

@DllImport("ADVAPI32.dll")
void FreeEncryptedFileMetadata(ubyte* pbMetadata);

@DllImport("clfsw32.dll")
ubyte LsnEqual(const(CLS_LSN)* plsn1, const(CLS_LSN)* plsn2);

@DllImport("clfsw32.dll")
ubyte LsnLess(const(CLS_LSN)* plsn1, const(CLS_LSN)* plsn2);

@DllImport("clfsw32.dll")
ubyte LsnGreater(const(CLS_LSN)* plsn1, const(CLS_LSN)* plsn2);

@DllImport("clfsw32.dll")
ubyte LsnNull(const(CLS_LSN)* plsn);

@DllImport("clfsw32.dll")
uint LsnContainer(const(CLS_LSN)* plsn);

@DllImport("clfsw32.dll")
CLS_LSN LsnCreate(uint cidContainer, uint offBlock, uint cRecord);

@DllImport("clfsw32.dll")
uint LsnBlockOffset(const(CLS_LSN)* plsn);

@DllImport("clfsw32.dll")
uint LsnRecordSequence(const(CLS_LSN)* plsn);

@DllImport("clfsw32.dll")
ubyte LsnInvalid(const(CLS_LSN)* plsn);

@DllImport("clfsw32.dll")
CLS_LSN LsnIncrement(CLS_LSN* plsn);

@DllImport("clfsw32.dll")
HANDLE CreateLogFile(const(wchar)* pszLogFileName, uint fDesiredAccess, uint dwShareMode, SECURITY_ATTRIBUTES* psaLogFile, uint fCreateDisposition, uint fFlagsAndAttributes);

@DllImport("clfsw32.dll")
BOOL DeleteLogByHandle(HANDLE hLog);

@DllImport("clfsw32.dll")
BOOL DeleteLogFile(const(wchar)* pszLogFileName, void* pvReserved);

@DllImport("clfsw32.dll")
BOOL AddLogContainer(HANDLE hLog, ulong* pcbContainer, const(wchar)* pwszContainerPath, void* pReserved);

@DllImport("clfsw32.dll")
BOOL AddLogContainerSet(HANDLE hLog, ushort cContainer, ulong* pcbContainer, char* rgwszContainerPath, void* pReserved);

@DllImport("clfsw32.dll")
BOOL RemoveLogContainer(HANDLE hLog, const(wchar)* pwszContainerPath, BOOL fForce, void* pReserved);

@DllImport("clfsw32.dll")
BOOL RemoveLogContainerSet(HANDLE hLog, ushort cContainer, char* rgwszContainerPath, BOOL fForce, void* pReserved);

@DllImport("clfsw32.dll")
BOOL SetLogArchiveTail(HANDLE hLog, CLS_LSN* plsnArchiveTail, void* pReserved);

@DllImport("clfsw32.dll")
BOOL SetEndOfLog(HANDLE hLog, CLS_LSN* plsnEnd, OVERLAPPED* lpOverlapped);

@DllImport("clfsw32.dll")
BOOL TruncateLog(void* pvMarshal, CLS_LSN* plsnEnd, OVERLAPPED* lpOverlapped);

@DllImport("clfsw32.dll")
BOOL CreateLogContainerScanContext(HANDLE hLog, uint cFromContainer, uint cContainers, ubyte eScanMode, CLS_SCAN_CONTEXT* pcxScan, OVERLAPPED* pOverlapped);

@DllImport("clfsw32.dll")
BOOL ScanLogContainers(CLS_SCAN_CONTEXT* pcxScan, ubyte eScanMode, void* pReserved);

@DllImport("clfsw32.dll")
BOOL AlignReservedLog(void* pvMarshal, uint cReservedRecords, long* rgcbReservation, long* pcbAlignReservation);

@DllImport("clfsw32.dll")
BOOL AllocReservedLog(void* pvMarshal, uint cReservedRecords, long* pcbAdjustment);

@DllImport("clfsw32.dll")
BOOL FreeReservedLog(void* pvMarshal, uint cReservedRecords, long* pcbAdjustment);

@DllImport("clfsw32.dll")
BOOL GetLogFileInformation(HANDLE hLog, CLS_INFORMATION* pinfoBuffer, uint* cbBuffer);

@DllImport("clfsw32.dll")
BOOL SetLogArchiveMode(HANDLE hLog, CLFS_LOG_ARCHIVE_MODE eMode);

@DllImport("clfsw32.dll")
BOOL ReadLogRestartArea(void* pvMarshal, void** ppvRestartBuffer, uint* pcbRestartBuffer, CLS_LSN* plsn, void** ppvContext, OVERLAPPED* pOverlapped);

@DllImport("clfsw32.dll")
BOOL ReadPreviousLogRestartArea(void* pvReadContext, void** ppvRestartBuffer, uint* pcbRestartBuffer, CLS_LSN* plsnRestart, OVERLAPPED* pOverlapped);

@DllImport("clfsw32.dll")
BOOL WriteLogRestartArea(void* pvMarshal, void* pvRestartBuffer, uint cbRestartBuffer, CLS_LSN* plsnBase, uint fFlags, uint* pcbWritten, CLS_LSN* plsnNext, OVERLAPPED* pOverlapped);

@DllImport("clfsw32.dll")
BOOL GetLogReservationInfo(void* pvMarshal, uint* pcbRecordNumber, long* pcbUserReservation, long* pcbCommitReservation);

@DllImport("clfsw32.dll")
BOOL AdvanceLogBase(void* pvMarshal, CLS_LSN* plsnBase, uint fFlags, OVERLAPPED* pOverlapped);

@DllImport("clfsw32.dll")
BOOL CloseAndResetLogFile(HANDLE hLog);

@DllImport("clfsw32.dll")
BOOL CreateLogMarshallingArea(HANDLE hLog, CLFS_BLOCK_ALLOCATION pfnAllocBuffer, CLFS_BLOCK_DEALLOCATION pfnFreeBuffer, void* pvBlockAllocContext, uint cbMarshallingBuffer, uint cMaxWriteBuffers, uint cMaxReadBuffers, void** ppvMarshal);

@DllImport("clfsw32.dll")
BOOL DeleteLogMarshallingArea(void* pvMarshal);

@DllImport("clfsw32.dll")
BOOL ReserveAndAppendLog(void* pvMarshal, CLS_WRITE_ENTRY* rgWriteEntries, uint cWriteEntries, CLS_LSN* plsnUndoNext, CLS_LSN* plsnPrevious, uint cReserveRecords, long* rgcbReservation, uint fFlags, CLS_LSN* plsn, OVERLAPPED* pOverlapped);

@DllImport("clfsw32.dll")
BOOL ReserveAndAppendLogAligned(void* pvMarshal, CLS_WRITE_ENTRY* rgWriteEntries, uint cWriteEntries, uint cbEntryAlignment, CLS_LSN* plsnUndoNext, CLS_LSN* plsnPrevious, uint cReserveRecords, long* rgcbReservation, uint fFlags, CLS_LSN* plsn, OVERLAPPED* pOverlapped);

@DllImport("clfsw32.dll")
BOOL FlushLogBuffers(void* pvMarshal, OVERLAPPED* pOverlapped);

@DllImport("clfsw32.dll")
BOOL FlushLogToLsn(void* pvMarshalContext, CLS_LSN* plsnFlush, CLS_LSN* plsnLastFlushed, OVERLAPPED* pOverlapped);

@DllImport("clfsw32.dll")
BOOL ReadLogRecord(void* pvMarshal, CLS_LSN* plsnFirst, CLFS_CONTEXT_MODE eContextMode, void** ppvReadBuffer, uint* pcbReadBuffer, ubyte* peRecordType, CLS_LSN* plsnUndoNext, CLS_LSN* plsnPrevious, void** ppvReadContext, OVERLAPPED* pOverlapped);

@DllImport("clfsw32.dll")
BOOL ReadNextLogRecord(void* pvReadContext, void** ppvBuffer, uint* pcbBuffer, ubyte* peRecordType, CLS_LSN* plsnUser, CLS_LSN* plsnUndoNext, CLS_LSN* plsnPrevious, CLS_LSN* plsnRecord, OVERLAPPED* pOverlapped);

@DllImport("clfsw32.dll")
BOOL TerminateReadLog(void* pvCursorContext);

@DllImport("clfsw32.dll")
BOOL PrepareLogArchive(HANDLE hLog, const(wchar)* pszBaseLogFileName, uint cLen, const(CLS_LSN)* plsnLow, const(CLS_LSN)* plsnHigh, uint* pcActualLength, ulong* poffBaseLogFileData, ulong* pcbBaseLogFileLength, CLS_LSN* plsnBase, CLS_LSN* plsnLast, CLS_LSN* plsnCurrentArchiveTail, void** ppvArchiveContext);

@DllImport("clfsw32.dll")
BOOL ReadLogArchiveMetadata(void* pvArchiveContext, uint cbOffset, uint cbBytesToRead, ubyte* pbReadBuffer, uint* pcbBytesRead);

@DllImport("clfsw32.dll")
BOOL GetNextLogArchiveExtent(void* pvArchiveContext, CLS_ARCHIVE_DESCRIPTOR* rgadExtent, uint cDescriptors, uint* pcDescriptorsReturned);

@DllImport("clfsw32.dll")
BOOL TerminateLogArchive(void* pvArchiveContext);

@DllImport("clfsw32.dll")
BOOL ValidateLog(const(wchar)* pszLogFileName, SECURITY_ATTRIBUTES* psaLogFile, CLS_INFORMATION* pinfoBuffer, uint* pcbBuffer);

@DllImport("clfsw32.dll")
BOOL GetLogContainerName(HANDLE hLog, uint cidLogicalContainer, const(wchar)* pwstrContainerName, uint cLenContainerName, uint* pcActualLenContainerName);

@DllImport("clfsw32.dll")
BOOL GetLogIoStatistics(HANDLE hLog, void* pvStatsBuffer, uint cbStatsBuffer, CLFS_IOSTATS_CLASS eStatsClass, uint* pcbStatsWritten);

@DllImport("clfsw32.dll")
BOOL RegisterManageableLogClient(HANDLE hLog, LOG_MANAGEMENT_CALLBACKS* pCallbacks);

@DllImport("clfsw32.dll")
BOOL DeregisterManageableLogClient(HANDLE hLog);

@DllImport("clfsw32.dll")
BOOL ReadLogNotification(HANDLE hLog, CLFS_MGMT_NOTIFICATION* pNotification, OVERLAPPED* lpOverlapped);

@DllImport("clfsw32.dll")
BOOL InstallLogPolicy(HANDLE hLog, CLFS_MGMT_POLICY* pPolicy);

@DllImport("clfsw32.dll")
BOOL RemoveLogPolicy(HANDLE hLog, CLFS_MGMT_POLICY_TYPE ePolicyType);

@DllImport("clfsw32.dll")
BOOL QueryLogPolicy(HANDLE hLog, CLFS_MGMT_POLICY_TYPE ePolicyType, CLFS_MGMT_POLICY* pPolicyBuffer, uint* pcbPolicyBuffer);

@DllImport("clfsw32.dll")
BOOL SetLogFileSizeWithPolicy(HANDLE hLog, ulong* pDesiredSize, ulong* pResultingSize);

@DllImport("clfsw32.dll")
BOOL HandleLogFull(HANDLE hLog);

@DllImport("clfsw32.dll")
BOOL LogTailAdvanceFailure(HANDLE hLog, uint dwReason);

@DllImport("clfsw32.dll")
BOOL RegisterForLogWriteNotification(HANDLE hLog, uint cbThreshold, BOOL fEnable);

@DllImport("WOFUTIL.dll")
BOOL WofShouldCompressBinaries(const(wchar)* Volume, uint* Algorithm);

@DllImport("WOFUTIL.dll")
HRESULT WofGetDriverVersion(HANDLE FileOrVolumeHandle, uint Provider, uint* WofVersion);

@DllImport("WOFUTIL.dll")
HRESULT WofSetFileDataLocation(HANDLE FileHandle, uint Provider, void* ExternalFileInfo, uint Length);

@DllImport("WOFUTIL.dll")
HRESULT WofIsExternalFile(const(wchar)* FilePath, int* IsExternalFile, uint* Provider, void* ExternalFileInfo, uint* BufferLength);

@DllImport("WOFUTIL.dll")
HRESULT WofEnumEntries(const(wchar)* VolumeName, uint Provider, WofEnumEntryProc EnumProc, void* UserData);

@DllImport("WOFUTIL.dll")
HRESULT WofWimAddEntry(const(wchar)* VolumeName, const(wchar)* WimPath, uint WimType, uint WimIndex, LARGE_INTEGER* DataSourceId);

@DllImport("WOFUTIL.dll")
HRESULT WofWimEnumFiles(const(wchar)* VolumeName, LARGE_INTEGER DataSourceId, WofEnumFilesProc EnumProc, void* UserData);

@DllImport("WOFUTIL.dll")
HRESULT WofWimSuspendEntry(const(wchar)* VolumeName, LARGE_INTEGER DataSourceId);

@DllImport("WOFUTIL.dll")
HRESULT WofWimRemoveEntry(const(wchar)* VolumeName, LARGE_INTEGER DataSourceId);

@DllImport("WOFUTIL.dll")
HRESULT WofWimUpdateEntry(const(wchar)* VolumeName, LARGE_INTEGER DataSourceId, const(wchar)* NewWimPath);

@DllImport("WOFUTIL.dll")
HRESULT WofFileEnumFiles(const(wchar)* VolumeName, uint Algorithm, WofEnumFilesProc EnumProc, void* UserData);

@DllImport("txfw32.dll")
BOOL TxfLogCreateFileReadContext(const(wchar)* LogPath, CLS_LSN BeginningLsn, CLS_LSN EndingLsn, TXF_ID* TxfFileId, void** TxfLogContext);

@DllImport("txfw32.dll")
BOOL TxfLogCreateRangeReadContext(const(wchar)* LogPath, CLS_LSN BeginningLsn, CLS_LSN EndingLsn, LARGE_INTEGER* BeginningVirtualClock, LARGE_INTEGER* EndingVirtualClock, uint RecordTypeMask, void** TxfLogContext);

@DllImport("txfw32.dll")
BOOL TxfLogDestroyReadContext(void* TxfLogContext);

@DllImport("txfw32.dll")
BOOL TxfLogReadRecords(void* TxfLogContext, uint BufferLength, char* Buffer, uint* BytesUsed, uint* RecordCount);

@DllImport("txfw32.dll")
BOOL TxfReadMetadataInfo(HANDLE FileHandle, TXF_ID* TxfFileId, CLS_LSN* LastLsn, uint* TransactionState, Guid* LockingTransaction);

@DllImport("txfw32.dll")
BOOL TxfLogRecordGetFileName(char* RecordBuffer, uint RecordBufferLengthInBytes, const(wchar)* NameBuffer, uint* NameBufferLengthInBytes, TXF_ID* TxfId);

@DllImport("txfw32.dll")
BOOL TxfLogRecordGetGenericType(void* RecordBuffer, uint RecordBufferLengthInBytes, uint* GenericType, LARGE_INTEGER* VirtualClock);

@DllImport("txfw32.dll")
void TxfSetThreadMiniVersionForCreate(ushort MiniVersion);

@DllImport("txfw32.dll")
void TxfGetThreadMiniVersionForCreate(ushort* MiniVersion);

@DllImport("ktmw32.dll")
HANDLE CreateTransaction(SECURITY_ATTRIBUTES* lpTransactionAttributes, Guid* UOW, uint CreateOptions, uint IsolationLevel, uint IsolationFlags, uint Timeout, const(wchar)* Description);

@DllImport("ktmw32.dll")
HANDLE OpenTransaction(uint dwDesiredAccess, Guid* TransactionId);

@DllImport("ktmw32.dll")
BOOL CommitTransaction(HANDLE TransactionHandle);

@DllImport("ktmw32.dll")
BOOL CommitTransactionAsync(HANDLE TransactionHandle);

@DllImport("ktmw32.dll")
BOOL RollbackTransaction(HANDLE TransactionHandle);

@DllImport("ktmw32.dll")
BOOL RollbackTransactionAsync(HANDLE TransactionHandle);

@DllImport("ktmw32.dll")
BOOL GetTransactionId(HANDLE TransactionHandle, Guid* TransactionId);

@DllImport("ktmw32.dll")
BOOL GetTransactionInformation(HANDLE TransactionHandle, uint* Outcome, uint* IsolationLevel, uint* IsolationFlags, uint* Timeout, uint BufferLength, const(wchar)* Description);

@DllImport("ktmw32.dll")
BOOL SetTransactionInformation(HANDLE TransactionHandle, uint IsolationLevel, uint IsolationFlags, uint Timeout, const(wchar)* Description);

@DllImport("ktmw32.dll")
HANDLE CreateTransactionManager(SECURITY_ATTRIBUTES* lpTransactionAttributes, const(wchar)* LogFileName, uint CreateOptions, uint CommitStrength);

@DllImport("ktmw32.dll")
HANDLE OpenTransactionManager(const(wchar)* LogFileName, uint DesiredAccess, uint OpenOptions);

@DllImport("ktmw32.dll")
HANDLE OpenTransactionManagerById(Guid* TransactionManagerId, uint DesiredAccess, uint OpenOptions);

@DllImport("ktmw32.dll")
BOOL RenameTransactionManager(const(wchar)* LogFileName, Guid* ExistingTransactionManagerGuid);

@DllImport("ktmw32.dll")
BOOL RollforwardTransactionManager(HANDLE TransactionManagerHandle, LARGE_INTEGER* TmVirtualClock);

@DllImport("ktmw32.dll")
BOOL RecoverTransactionManager(HANDLE TransactionManagerHandle);

@DllImport("ktmw32.dll")
BOOL GetCurrentClockTransactionManager(HANDLE TransactionManagerHandle, LARGE_INTEGER* TmVirtualClock);

@DllImport("ktmw32.dll")
BOOL GetTransactionManagerId(HANDLE TransactionManagerHandle, Guid* TransactionManagerId);

@DllImport("ktmw32.dll")
HANDLE CreateResourceManager(SECURITY_ATTRIBUTES* lpResourceManagerAttributes, Guid* ResourceManagerId, uint CreateOptions, HANDLE TmHandle, const(wchar)* Description);

@DllImport("ktmw32.dll")
HANDLE OpenResourceManager(uint dwDesiredAccess, HANDLE TmHandle, Guid* ResourceManagerId);

@DllImport("ktmw32.dll")
BOOL RecoverResourceManager(HANDLE ResourceManagerHandle);

@DllImport("ktmw32.dll")
BOOL GetNotificationResourceManager(HANDLE ResourceManagerHandle, TRANSACTION_NOTIFICATION* TransactionNotification, uint NotificationLength, uint dwMilliseconds, uint* ReturnLength);

@DllImport("ktmw32.dll")
BOOL GetNotificationResourceManagerAsync(HANDLE ResourceManagerHandle, TRANSACTION_NOTIFICATION* TransactionNotification, uint TransactionNotificationLength, uint* ReturnLength, OVERLAPPED* lpOverlapped);

@DllImport("ktmw32.dll")
BOOL SetResourceManagerCompletionPort(HANDLE ResourceManagerHandle, HANDLE IoCompletionPortHandle, uint CompletionKey);

@DllImport("ktmw32.dll")
HANDLE CreateEnlistment(SECURITY_ATTRIBUTES* lpEnlistmentAttributes, HANDLE ResourceManagerHandle, HANDLE TransactionHandle, uint NotificationMask, uint CreateOptions, void* EnlistmentKey);

@DllImport("ktmw32.dll")
HANDLE OpenEnlistment(uint dwDesiredAccess, HANDLE ResourceManagerHandle, Guid* EnlistmentId);

@DllImport("ktmw32.dll")
BOOL RecoverEnlistment(HANDLE EnlistmentHandle, void* EnlistmentKey);

@DllImport("ktmw32.dll")
BOOL GetEnlistmentRecoveryInformation(HANDLE EnlistmentHandle, uint BufferSize, void* Buffer, uint* BufferUsed);

@DllImport("ktmw32.dll")
BOOL GetEnlistmentId(HANDLE EnlistmentHandle, Guid* EnlistmentId);

@DllImport("ktmw32.dll")
BOOL SetEnlistmentRecoveryInformation(HANDLE EnlistmentHandle, uint BufferSize, void* Buffer);

@DllImport("ktmw32.dll")
BOOL PrepareEnlistment(HANDLE EnlistmentHandle, LARGE_INTEGER* TmVirtualClock);

@DllImport("ktmw32.dll")
BOOL PrePrepareEnlistment(HANDLE EnlistmentHandle, LARGE_INTEGER* TmVirtualClock);

@DllImport("ktmw32.dll")
BOOL CommitEnlistment(HANDLE EnlistmentHandle, LARGE_INTEGER* TmVirtualClock);

@DllImport("ktmw32.dll")
BOOL RollbackEnlistment(HANDLE EnlistmentHandle, LARGE_INTEGER* TmVirtualClock);

@DllImport("ktmw32.dll")
BOOL PrePrepareComplete(HANDLE EnlistmentHandle, LARGE_INTEGER* TmVirtualClock);

@DllImport("ktmw32.dll")
BOOL PrepareComplete(HANDLE EnlistmentHandle, LARGE_INTEGER* TmVirtualClock);

@DllImport("ktmw32.dll")
BOOL ReadOnlyEnlistment(HANDLE EnlistmentHandle, LARGE_INTEGER* TmVirtualClock);

@DllImport("ktmw32.dll")
BOOL CommitComplete(HANDLE EnlistmentHandle, LARGE_INTEGER* TmVirtualClock);

@DllImport("ktmw32.dll")
BOOL RollbackComplete(HANDLE EnlistmentHandle, LARGE_INTEGER* TmVirtualClock);

@DllImport("ktmw32.dll")
BOOL SinglePhaseReject(HANDLE EnlistmentHandle, LARGE_INTEGER* TmVirtualClock);

@DllImport("srvcli.dll")
uint NetShareAdd(const(wchar)* servername, uint level, char* buf, uint* parm_err);

@DllImport("srvcli.dll")
uint NetShareEnum(const(wchar)* servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, uint* totalentries, uint* resume_handle);

@DllImport("srvcli.dll")
uint NetShareEnumSticky(const(wchar)* servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, uint* totalentries, uint* resume_handle);

@DllImport("srvcli.dll")
uint NetShareGetInfo(const(wchar)* servername, const(wchar)* netname, uint level, ubyte** bufptr);

@DllImport("srvcli.dll")
uint NetShareSetInfo(const(wchar)* servername, const(wchar)* netname, uint level, char* buf, uint* parm_err);

@DllImport("srvcli.dll")
uint NetShareDel(const(wchar)* servername, const(wchar)* netname, uint reserved);

@DllImport("srvcli.dll")
uint NetShareDelSticky(const(wchar)* servername, const(wchar)* netname, uint reserved);

@DllImport("srvcli.dll")
uint NetShareCheck(const(wchar)* servername, const(wchar)* device, uint* type);

@DllImport("srvcli.dll")
uint NetShareDelEx(const(wchar)* servername, uint level, char* buf);

@DllImport("srvcli.dll")
uint NetServerAliasAdd(const(wchar)* servername, uint level, char* buf);

@DllImport("srvcli.dll")
uint NetServerAliasDel(const(wchar)* servername, uint level, char* buf);

@DllImport("srvcli.dll")
uint NetServerAliasEnum(const(wchar)* servername, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, uint* totalentries, uint* resumehandle);

@DllImport("srvcli.dll")
uint NetSessionEnum(const(wchar)* servername, const(wchar)* UncClientName, const(wchar)* username, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, uint* totalentries, uint* resume_handle);

@DllImport("srvcli.dll")
uint NetSessionDel(const(wchar)* servername, const(wchar)* UncClientName, const(wchar)* username);

@DllImport("srvcli.dll")
uint NetSessionGetInfo(const(wchar)* servername, const(wchar)* UncClientName, const(wchar)* username, uint level, ubyte** bufptr);

@DllImport("srvcli.dll")
uint NetConnectionEnum(const(wchar)* servername, const(wchar)* qualifier, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, uint* totalentries, uint* resume_handle);

@DllImport("srvcli.dll")
uint NetFileClose(const(wchar)* servername, uint fileid);

@DllImport("srvcli.dll")
uint NetFileEnum(const(wchar)* servername, const(wchar)* basepath, const(wchar)* username, uint level, ubyte** bufptr, uint prefmaxlen, uint* entriesread, uint* totalentries, uint* resume_handle);

@DllImport("srvcli.dll")
uint NetFileGetInfo(const(wchar)* servername, uint fileid, uint level, ubyte** bufptr);

@DllImport("NETAPI32.dll")
uint NetStatisticsGet(byte* ServerName, byte* Service, uint Level, uint Options, ubyte** Buffer);

@DllImport("KERNEL32.dll")
uint SearchPathW(const(wchar)* lpPath, const(wchar)* lpFileName, const(wchar)* lpExtension, uint nBufferLength, const(wchar)* lpBuffer, ushort** lpFilePart);

@DllImport("KERNEL32.dll")
uint SearchPathA(const(char)* lpPath, const(char)* lpFileName, const(char)* lpExtension, uint nBufferLength, const(char)* lpBuffer, byte** lpFilePart);

@DllImport("KERNEL32.dll")
BOOL GetBinaryTypeA(const(char)* lpApplicationName, uint* lpBinaryType);

@DllImport("KERNEL32.dll")
BOOL GetBinaryTypeW(const(wchar)* lpApplicationName, uint* lpBinaryType);

@DllImport("KERNEL32.dll")
uint GetShortPathNameA(const(char)* lpszLongPath, const(char)* lpszShortPath, uint cchBuffer);

@DllImport("KERNEL32.dll")
uint GetLongPathNameTransactedA(const(char)* lpszShortPath, const(char)* lpszLongPath, uint cchBuffer, HANDLE hTransaction);

@DllImport("KERNEL32.dll")
uint GetLongPathNameTransactedW(const(wchar)* lpszShortPath, const(wchar)* lpszLongPath, uint cchBuffer, HANDLE hTransaction);

@DllImport("KERNEL32.dll")
BOOL SetFileCompletionNotificationModes(HANDLE FileHandle, ubyte Flags);

@DllImport("KERNEL32.dll")
BOOL SetFileShortNameA(HANDLE hFile, const(char)* lpShortName);

@DllImport("KERNEL32.dll")
BOOL SetFileShortNameW(HANDLE hFile, const(wchar)* lpShortName);

@DllImport("ADVAPI32.dll")
BOOL EncryptFileA(const(char)* lpFileName);

@DllImport("ADVAPI32.dll")
BOOL EncryptFileW(const(wchar)* lpFileName);

@DllImport("ADVAPI32.dll")
BOOL DecryptFileA(const(char)* lpFileName, uint dwReserved);

@DllImport("ADVAPI32.dll")
BOOL DecryptFileW(const(wchar)* lpFileName, uint dwReserved);

@DllImport("ADVAPI32.dll")
BOOL FileEncryptionStatusA(const(char)* lpFileName, uint* lpStatus);

@DllImport("ADVAPI32.dll")
BOOL FileEncryptionStatusW(const(wchar)* lpFileName, uint* lpStatus);

@DllImport("ADVAPI32.dll")
uint OpenEncryptedFileRawA(const(char)* lpFileName, uint ulFlags, void** pvContext);

@DllImport("ADVAPI32.dll")
uint OpenEncryptedFileRawW(const(wchar)* lpFileName, uint ulFlags, void** pvContext);

@DllImport("ADVAPI32.dll")
uint ReadEncryptedFileRaw(PFE_EXPORT_FUNC pfExportCallback, void* pvCallbackContext, void* pvContext);

@DllImport("ADVAPI32.dll")
uint WriteEncryptedFileRaw(PFE_IMPORT_FUNC pfImportCallback, void* pvCallbackContext, void* pvContext);

@DllImport("ADVAPI32.dll")
void CloseEncryptedFileRaw(void* pvContext);

@DllImport("KERNEL32.dll")
int OpenFile(const(char)* lpFileName, OFSTRUCT* lpReOpenBuff, uint uStyle);

@DllImport("KERNEL32.dll")
uint GetLogicalDriveStringsA(uint nBufferLength, const(char)* lpBuffer);

@DllImport("KERNEL32.dll")
ubyte Wow64EnableWow64FsRedirection(ubyte Wow64FsEnableRedirection);

@DllImport("KERNEL32.dll")
BOOL SetSearchPathMode(uint Flags);

@DllImport("KERNEL32.dll")
BOOL CreateDirectoryExA(const(char)* lpTemplateDirectory, const(char)* lpNewDirectory, SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("KERNEL32.dll")
BOOL CreateDirectoryExW(const(wchar)* lpTemplateDirectory, const(wchar)* lpNewDirectory, SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("KERNEL32.dll")
BOOL CreateDirectoryTransactedA(const(char)* lpTemplateDirectory, const(char)* lpNewDirectory, SECURITY_ATTRIBUTES* lpSecurityAttributes, HANDLE hTransaction);

@DllImport("KERNEL32.dll")
BOOL CreateDirectoryTransactedW(const(wchar)* lpTemplateDirectory, const(wchar)* lpNewDirectory, SECURITY_ATTRIBUTES* lpSecurityAttributes, HANDLE hTransaction);

@DllImport("KERNEL32.dll")
BOOL RemoveDirectoryTransactedA(const(char)* lpPathName, HANDLE hTransaction);

@DllImport("KERNEL32.dll")
BOOL RemoveDirectoryTransactedW(const(wchar)* lpPathName, HANDLE hTransaction);

@DllImport("KERNEL32.dll")
uint GetFullPathNameTransactedA(const(char)* lpFileName, uint nBufferLength, const(char)* lpBuffer, byte** lpFilePart, HANDLE hTransaction);

@DllImport("KERNEL32.dll")
uint GetFullPathNameTransactedW(const(wchar)* lpFileName, uint nBufferLength, const(wchar)* lpBuffer, ushort** lpFilePart, HANDLE hTransaction);

@DllImport("KERNEL32.dll")
BOOL DefineDosDeviceA(uint dwFlags, const(char)* lpDeviceName, const(char)* lpTargetPath);

@DllImport("KERNEL32.dll")
uint QueryDosDeviceA(const(char)* lpDeviceName, const(char)* lpTargetPath, uint ucchMax);

@DllImport("KERNEL32.dll")
HANDLE CreateFileTransactedA(const(char)* lpFileName, uint dwDesiredAccess, uint dwShareMode, SECURITY_ATTRIBUTES* lpSecurityAttributes, uint dwCreationDisposition, uint dwFlagsAndAttributes, HANDLE hTemplateFile, HANDLE hTransaction, ushort* pusMiniVersion, void* lpExtendedParameter);

@DllImport("KERNEL32.dll")
HANDLE CreateFileTransactedW(const(wchar)* lpFileName, uint dwDesiredAccess, uint dwShareMode, SECURITY_ATTRIBUTES* lpSecurityAttributes, uint dwCreationDisposition, uint dwFlagsAndAttributes, HANDLE hTemplateFile, HANDLE hTransaction, ushort* pusMiniVersion, void* lpExtendedParameter);

@DllImport("KERNEL32.dll")
HANDLE ReOpenFile(HANDLE hOriginalFile, uint dwDesiredAccess, uint dwShareMode, uint dwFlagsAndAttributes);

@DllImport("KERNEL32.dll")
BOOL SetFileAttributesTransactedA(const(char)* lpFileName, uint dwFileAttributes, HANDLE hTransaction);

@DllImport("KERNEL32.dll")
BOOL SetFileAttributesTransactedW(const(wchar)* lpFileName, uint dwFileAttributes, HANDLE hTransaction);

@DllImport("KERNEL32.dll")
BOOL GetFileAttributesTransactedA(const(char)* lpFileName, GET_FILEEX_INFO_LEVELS fInfoLevelId, char* lpFileInformation, HANDLE hTransaction);

@DllImport("KERNEL32.dll")
BOOL GetFileAttributesTransactedW(const(wchar)* lpFileName, GET_FILEEX_INFO_LEVELS fInfoLevelId, char* lpFileInformation, HANDLE hTransaction);

@DllImport("KERNEL32.dll")
uint GetCompressedFileSizeTransactedA(const(char)* lpFileName, uint* lpFileSizeHigh, HANDLE hTransaction);

@DllImport("KERNEL32.dll")
uint GetCompressedFileSizeTransactedW(const(wchar)* lpFileName, uint* lpFileSizeHigh, HANDLE hTransaction);

@DllImport("KERNEL32.dll")
BOOL DeleteFileTransactedA(const(char)* lpFileName, HANDLE hTransaction);

@DllImport("KERNEL32.dll")
BOOL DeleteFileTransactedW(const(wchar)* lpFileName, HANDLE hTransaction);

@DllImport("KERNEL32.dll")
BOOL CheckNameLegalDOS8Dot3A(const(char)* lpName, const(char)* lpOemName, uint OemNameSize, int* pbNameContainsSpaces, int* pbNameLegal);

@DllImport("KERNEL32.dll")
BOOL CheckNameLegalDOS8Dot3W(const(wchar)* lpName, const(char)* lpOemName, uint OemNameSize, int* pbNameContainsSpaces, int* pbNameLegal);

@DllImport("KERNEL32.dll")
FindFileHandle FindFirstFileTransactedA(const(char)* lpFileName, FINDEX_INFO_LEVELS fInfoLevelId, char* lpFindFileData, FINDEX_SEARCH_OPS fSearchOp, void* lpSearchFilter, uint dwAdditionalFlags, HANDLE hTransaction);

@DllImport("KERNEL32.dll")
FindFileHandle FindFirstFileTransactedW(const(wchar)* lpFileName, FINDEX_INFO_LEVELS fInfoLevelId, char* lpFindFileData, FINDEX_SEARCH_OPS fSearchOp, void* lpSearchFilter, uint dwAdditionalFlags, HANDLE hTransaction);

@DllImport("KERNEL32.dll")
BOOL CopyFileA(const(char)* lpExistingFileName, const(char)* lpNewFileName, BOOL bFailIfExists);

@DllImport("KERNEL32.dll")
BOOL CopyFileW(const(wchar)* lpExistingFileName, const(wchar)* lpNewFileName, BOOL bFailIfExists);

@DllImport("KERNEL32.dll")
BOOL CopyFileExA(const(char)* lpExistingFileName, const(char)* lpNewFileName, LPPROGRESS_ROUTINE lpProgressRoutine, void* lpData, int* pbCancel, uint dwCopyFlags);

@DllImport("KERNEL32.dll")
BOOL CopyFileExW(const(wchar)* lpExistingFileName, const(wchar)* lpNewFileName, LPPROGRESS_ROUTINE lpProgressRoutine, void* lpData, int* pbCancel, uint dwCopyFlags);

@DllImport("KERNEL32.dll")
BOOL CopyFileTransactedA(const(char)* lpExistingFileName, const(char)* lpNewFileName, LPPROGRESS_ROUTINE lpProgressRoutine, void* lpData, int* pbCancel, uint dwCopyFlags, HANDLE hTransaction);

@DllImport("KERNEL32.dll")
BOOL CopyFileTransactedW(const(wchar)* lpExistingFileName, const(wchar)* lpNewFileName, LPPROGRESS_ROUTINE lpProgressRoutine, void* lpData, int* pbCancel, uint dwCopyFlags, HANDLE hTransaction);

@DllImport("KERNEL32.dll")
HRESULT CopyFile2(const(wchar)* pwszExistingFileName, const(wchar)* pwszNewFileName, COPYFILE2_EXTENDED_PARAMETERS* pExtendedParameters);

@DllImport("KERNEL32.dll")
BOOL MoveFileA(const(char)* lpExistingFileName, const(char)* lpNewFileName);

@DllImport("KERNEL32.dll")
BOOL MoveFileW(const(wchar)* lpExistingFileName, const(wchar)* lpNewFileName);

@DllImport("KERNEL32.dll")
BOOL MoveFileExA(const(char)* lpExistingFileName, const(char)* lpNewFileName, uint dwFlags);

@DllImport("KERNEL32.dll")
BOOL MoveFileExW(const(wchar)* lpExistingFileName, const(wchar)* lpNewFileName, uint dwFlags);

@DllImport("KERNEL32.dll")
BOOL MoveFileWithProgressA(const(char)* lpExistingFileName, const(char)* lpNewFileName, LPPROGRESS_ROUTINE lpProgressRoutine, void* lpData, uint dwFlags);

@DllImport("KERNEL32.dll")
BOOL MoveFileWithProgressW(const(wchar)* lpExistingFileName, const(wchar)* lpNewFileName, LPPROGRESS_ROUTINE lpProgressRoutine, void* lpData, uint dwFlags);

@DllImport("KERNEL32.dll")
BOOL MoveFileTransactedA(const(char)* lpExistingFileName, const(char)* lpNewFileName, LPPROGRESS_ROUTINE lpProgressRoutine, void* lpData, uint dwFlags, HANDLE hTransaction);

@DllImport("KERNEL32.dll")
BOOL MoveFileTransactedW(const(wchar)* lpExistingFileName, const(wchar)* lpNewFileName, LPPROGRESS_ROUTINE lpProgressRoutine, void* lpData, uint dwFlags, HANDLE hTransaction);

@DllImport("KERNEL32.dll")
BOOL ReplaceFileA(const(char)* lpReplacedFileName, const(char)* lpReplacementFileName, const(char)* lpBackupFileName, uint dwReplaceFlags, void* lpExclude, void* lpReserved);

@DllImport("KERNEL32.dll")
BOOL ReplaceFileW(const(wchar)* lpReplacedFileName, const(wchar)* lpReplacementFileName, const(wchar)* lpBackupFileName, uint dwReplaceFlags, void* lpExclude, void* lpReserved);

@DllImport("KERNEL32.dll")
BOOL CreateHardLinkA(const(char)* lpFileName, const(char)* lpExistingFileName, SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("KERNEL32.dll")
BOOL CreateHardLinkW(const(wchar)* lpFileName, const(wchar)* lpExistingFileName, SECURITY_ATTRIBUTES* lpSecurityAttributes);

@DllImport("KERNEL32.dll")
BOOL CreateHardLinkTransactedA(const(char)* lpFileName, const(char)* lpExistingFileName, SECURITY_ATTRIBUTES* lpSecurityAttributes, HANDLE hTransaction);

@DllImport("KERNEL32.dll")
BOOL CreateHardLinkTransactedW(const(wchar)* lpFileName, const(wchar)* lpExistingFileName, SECURITY_ATTRIBUTES* lpSecurityAttributes, HANDLE hTransaction);

@DllImport("KERNEL32.dll")
FindStreamHandle FindFirstStreamTransactedW(const(wchar)* lpFileName, STREAM_INFO_LEVELS InfoLevel, char* lpFindStreamData, uint dwFlags, HANDLE hTransaction);

@DllImport("KERNEL32.dll")
FindFileNameHandle FindFirstFileNameTransactedW(const(wchar)* lpFileName, uint dwFlags, uint* StringLength, const(wchar)* LinkName, HANDLE hTransaction);

@DllImport("KERNEL32.dll")
BOOL SetVolumeLabelA(const(char)* lpRootPathName, const(char)* lpVolumeName);

@DllImport("KERNEL32.dll")
BOOL SetVolumeLabelW(const(wchar)* lpRootPathName, const(wchar)* lpVolumeName);

@DllImport("KERNEL32.dll")
BOOL SetFileBandwidthReservation(HANDLE hFile, uint nPeriodMilliseconds, uint nBytesPerPeriod, BOOL bDiscardable, uint* lpTransferSize, uint* lpNumOutstandingRequests);

@DllImport("KERNEL32.dll")
BOOL GetFileBandwidthReservation(HANDLE hFile, uint* lpPeriodMilliseconds, uint* lpBytesPerPeriod, int* pDiscardable, uint* lpTransferSize, uint* lpNumOutstandingRequests);

@DllImport("KERNEL32.dll")
BOOL ReadDirectoryChangesW(HANDLE hDirectory, char* lpBuffer, uint nBufferLength, BOOL bWatchSubtree, uint dwNotifyFilter, uint* lpBytesReturned, OVERLAPPED* lpOverlapped, LPOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

@DllImport("KERNEL32.dll")
BOOL ReadDirectoryChangesExW(HANDLE hDirectory, char* lpBuffer, uint nBufferLength, BOOL bWatchSubtree, uint dwNotifyFilter, uint* lpBytesReturned, OVERLAPPED* lpOverlapped, LPOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine, READ_DIRECTORY_NOTIFY_INFORMATION_CLASS ReadDirectoryNotifyInformationClass);

@DllImport("KERNEL32.dll")
FindVolumeHandle FindFirstVolumeA(const(char)* lpszVolumeName, uint cchBufferLength);

@DllImport("KERNEL32.dll")
BOOL FindNextVolumeA(FindVolumeHandle hFindVolume, const(char)* lpszVolumeName, uint cchBufferLength);

@DllImport("KERNEL32.dll")
FindVolumeMointPointHandle FindFirstVolumeMountPointA(const(char)* lpszRootPathName, const(char)* lpszVolumeMountPoint, uint cchBufferLength);

@DllImport("KERNEL32.dll")
FindVolumeMointPointHandle FindFirstVolumeMountPointW(const(wchar)* lpszRootPathName, const(wchar)* lpszVolumeMountPoint, uint cchBufferLength);

@DllImport("KERNEL32.dll")
BOOL FindNextVolumeMountPointA(FindVolumeMointPointHandle hFindVolumeMountPoint, const(char)* lpszVolumeMountPoint, uint cchBufferLength);

@DllImport("KERNEL32.dll")
BOOL FindNextVolumeMountPointW(FindVolumeMointPointHandle hFindVolumeMountPoint, const(wchar)* lpszVolumeMountPoint, uint cchBufferLength);

@DllImport("KERNEL32.dll")
BOOL FindVolumeMountPointClose(FindVolumeMointPointHandle hFindVolumeMountPoint);

@DllImport("KERNEL32.dll")
BOOL SetVolumeMountPointA(const(char)* lpszVolumeMountPoint, const(char)* lpszVolumeName);

@DllImport("KERNEL32.dll")
BOOL SetVolumeMountPointW(const(wchar)* lpszVolumeMountPoint, const(wchar)* lpszVolumeName);

@DllImport("KERNEL32.dll")
BOOL DeleteVolumeMountPointA(const(char)* lpszVolumeMountPoint);

@DllImport("KERNEL32.dll")
BOOL GetVolumeNameForVolumeMountPointA(const(char)* lpszVolumeMountPoint, const(char)* lpszVolumeName, uint cchBufferLength);

@DllImport("KERNEL32.dll")
BOOL GetVolumePathNameA(const(char)* lpszFileName, const(char)* lpszVolumePathName, uint cchBufferLength);

@DllImport("KERNEL32.dll")
BOOL GetVolumePathNamesForVolumeNameA(const(char)* lpszVolumeName, const(char)* lpszVolumePathNames, uint cchBufferLength, uint* lpcchReturnLength);

@DllImport("KERNEL32.dll")
BOOL GetFileInformationByHandleEx(HANDLE hFile, FILE_INFO_BY_HANDLE_CLASS FileInformationClass, char* lpFileInformation, uint dwBufferSize);

@DllImport("KERNEL32.dll")
HANDLE OpenFileById(HANDLE hVolumeHint, FILE_ID_DESCRIPTOR* lpFileId, uint dwDesiredAccess, uint dwShareMode, SECURITY_ATTRIBUTES* lpSecurityAttributes, uint dwFlagsAndAttributes);

@DllImport("KERNEL32.dll")
ubyte CreateSymbolicLinkA(const(char)* lpSymlinkFileName, const(char)* lpTargetFileName, uint dwFlags);

@DllImport("KERNEL32.dll")
ubyte CreateSymbolicLinkW(const(wchar)* lpSymlinkFileName, const(wchar)* lpTargetFileName, uint dwFlags);

@DllImport("KERNEL32.dll")
ubyte CreateSymbolicLinkTransactedA(const(char)* lpSymlinkFileName, const(char)* lpTargetFileName, uint dwFlags, HANDLE hTransaction);

@DllImport("KERNEL32.dll")
ubyte CreateSymbolicLinkTransactedW(const(wchar)* lpSymlinkFileName, const(wchar)* lpTargetFileName, uint dwFlags, HANDLE hTransaction);

struct OFSTRUCT
{
    ubyte cBytes;
    ubyte fFixedDisk;
    ushort nErrCode;
    ushort Reserved1;
    ushort Reserved2;
    byte szPathName;
}

alias PFE_EXPORT_FUNC = extern(Windows) uint function(char* pbData, void* pvCallbackContext, uint ulLength);
alias PFE_IMPORT_FUNC = extern(Windows) uint function(char* pbData, void* pvCallbackContext, uint* ulLength);
alias LPPROGRESS_ROUTINE = extern(Windows) uint function(LARGE_INTEGER TotalFileSize, LARGE_INTEGER TotalBytesTransferred, LARGE_INTEGER StreamSize, LARGE_INTEGER StreamBytesTransferred, uint dwStreamNumber, uint dwCallbackReason, HANDLE hSourceFile, HANDLE hDestinationFile, void* lpData);
enum COPYFILE2_MESSAGE_TYPE
{
    COPYFILE2_CALLBACK_NONE = 0,
    COPYFILE2_CALLBACK_CHUNK_STARTED = 1,
    COPYFILE2_CALLBACK_CHUNK_FINISHED = 2,
    COPYFILE2_CALLBACK_STREAM_STARTED = 3,
    COPYFILE2_CALLBACK_STREAM_FINISHED = 4,
    COPYFILE2_CALLBACK_POLL_CONTINUE = 5,
    COPYFILE2_CALLBACK_ERROR = 6,
    COPYFILE2_CALLBACK_MAX = 7,
}

enum COPYFILE2_MESSAGE_ACTION
{
    COPYFILE2_PROGRESS_CONTINUE = 0,
    COPYFILE2_PROGRESS_CANCEL = 1,
    COPYFILE2_PROGRESS_STOP = 2,
    COPYFILE2_PROGRESS_QUIET = 3,
    COPYFILE2_PROGRESS_PAUSE = 4,
}

enum COPYFILE2_COPY_PHASE
{
    COPYFILE2_PHASE_NONE = 0,
    COPYFILE2_PHASE_PREPARE_SOURCE = 1,
    COPYFILE2_PHASE_PREPARE_DEST = 2,
    COPYFILE2_PHASE_READ_SOURCE = 3,
    COPYFILE2_PHASE_WRITE_DESTINATION = 4,
    COPYFILE2_PHASE_SERVER_COPY = 5,
    COPYFILE2_PHASE_NAMEGRAFT_COPY = 6,
    COPYFILE2_PHASE_MAX = 7,
}

struct COPYFILE2_MESSAGE
{
    COPYFILE2_MESSAGE_TYPE Type;
    uint dwPadding;
    _Info_e__Union Info;
}

alias PCOPYFILE2_PROGRESS_ROUTINE = extern(Windows) COPYFILE2_MESSAGE_ACTION function(const(COPYFILE2_MESSAGE)* pMessage, void* pvCallbackContext);
struct COPYFILE2_EXTENDED_PARAMETERS
{
    uint dwSize;
    uint dwCopyFlags;
    int* pfCancel;
    PCOPYFILE2_PROGRESS_ROUTINE pProgressRoutine;
    void* pvCallbackContext;
}

struct FILE_BASIC_INFO
{
    LARGE_INTEGER CreationTime;
    LARGE_INTEGER LastAccessTime;
    LARGE_INTEGER LastWriteTime;
    LARGE_INTEGER ChangeTime;
    uint FileAttributes;
}

struct FILE_STANDARD_INFO
{
    LARGE_INTEGER AllocationSize;
    LARGE_INTEGER EndOfFile;
    uint NumberOfLinks;
    ubyte DeletePending;
    ubyte Directory;
}

struct FILE_NAME_INFO
{
    uint FileNameLength;
    ushort FileName;
}

struct FILE_RENAME_INFO
{
    _Anonymous_e__Union Anonymous;
    HANDLE RootDirectory;
    uint FileNameLength;
    ushort FileName;
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
    uint NextEntryOffset;
    uint StreamNameLength;
    LARGE_INTEGER StreamSize;
    LARGE_INTEGER StreamAllocationSize;
    ushort StreamName;
}

struct FILE_COMPRESSION_INFO
{
    LARGE_INTEGER CompressedFileSize;
    ushort CompressionFormat;
    ubyte CompressionUnitShift;
    ubyte ChunkShift;
    ubyte ClusterShift;
    ubyte Reserved;
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
    uint NextEntryOffset;
    uint FileIndex;
    LARGE_INTEGER CreationTime;
    LARGE_INTEGER LastAccessTime;
    LARGE_INTEGER LastWriteTime;
    LARGE_INTEGER ChangeTime;
    LARGE_INTEGER EndOfFile;
    LARGE_INTEGER AllocationSize;
    uint FileAttributes;
    uint FileNameLength;
    uint EaSize;
    byte ShortNameLength;
    ushort ShortName;
    LARGE_INTEGER FileId;
    ushort FileName;
}

struct FILE_FULL_DIR_INFO
{
    uint NextEntryOffset;
    uint FileIndex;
    LARGE_INTEGER CreationTime;
    LARGE_INTEGER LastAccessTime;
    LARGE_INTEGER LastWriteTime;
    LARGE_INTEGER ChangeTime;
    LARGE_INTEGER EndOfFile;
    LARGE_INTEGER AllocationSize;
    uint FileAttributes;
    uint FileNameLength;
    uint EaSize;
    ushort FileName;
}

enum PRIORITY_HINT
{
    IoPriorityHintVeryLow = 0,
    IoPriorityHintLow = 1,
    IoPriorityHintNormal = 2,
    MaximumIoPriorityHintType = 3,
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
    ulong VolumeSerialNumber;
    FILE_ID_128 FileId;
}

struct FILE_ID_EXTD_DIR_INFO
{
    uint NextEntryOffset;
    uint FileIndex;
    LARGE_INTEGER CreationTime;
    LARGE_INTEGER LastAccessTime;
    LARGE_INTEGER LastWriteTime;
    LARGE_INTEGER ChangeTime;
    LARGE_INTEGER EndOfFile;
    LARGE_INTEGER AllocationSize;
    uint FileAttributes;
    uint FileNameLength;
    uint EaSize;
    uint ReparsePointTag;
    FILE_ID_128 FileId;
    ushort FileName;
}

struct FILE_REMOTE_PROTOCOL_INFO
{
    ushort StructureVersion;
    ushort StructureSize;
    uint Protocol;
    ushort ProtocolMajorVersion;
    ushort ProtocolMinorVersion;
    ushort ProtocolRevision;
    ushort Reserved;
    uint Flags;
    _GenericReserved_e__Struct GenericReserved;
    _ProtocolSpecific_e__Union ProtocolSpecific;
}

enum FILE_ID_TYPE
{
    FileIdType = 0,
    ObjectIdType = 1,
    ExtendedFileIdType = 2,
    MaximumFileIdType = 3,
}

struct FILE_ID_DESCRIPTOR
{
    uint dwSize;
    FILE_ID_TYPE Type;
    _Anonymous_e__Union Anonymous;
}

