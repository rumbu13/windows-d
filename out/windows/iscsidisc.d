module windows.iscsidisc;

public import system;
public import windows.systemservices;

extern(Windows):

struct SCSI_PASS_THROUGH
{
    ushort Length;
    ubyte ScsiStatus;
    ubyte PathId;
    ubyte TargetId;
    ubyte Lun;
    ubyte CdbLength;
    ubyte SenseInfoLength;
    ubyte DataIn;
    uint DataTransferLength;
    uint TimeOutValue;
    uint DataBufferOffset;
    uint SenseInfoOffset;
    ubyte Cdb;
}

struct SCSI_PASS_THROUGH_DIRECT
{
    ushort Length;
    ubyte ScsiStatus;
    ubyte PathId;
    ubyte TargetId;
    ubyte Lun;
    ubyte CdbLength;
    ubyte SenseInfoLength;
    ubyte DataIn;
    uint DataTransferLength;
    uint TimeOutValue;
    void* DataBuffer;
    uint SenseInfoOffset;
    ubyte Cdb;
}

struct SCSI_PASS_THROUGH_EX
{
    uint Version;
    uint Length;
    uint CdbLength;
    uint StorAddressLength;
    ubyte ScsiStatus;
    ubyte SenseInfoLength;
    ubyte DataDirection;
    ubyte Reserved;
    uint TimeOutValue;
    uint StorAddressOffset;
    uint SenseInfoOffset;
    uint DataOutTransferLength;
    uint DataInTransferLength;
    uint DataOutBufferOffset;
    uint DataInBufferOffset;
    ubyte Cdb;
}

struct SCSI_PASS_THROUGH_DIRECT_EX
{
    uint Version;
    uint Length;
    uint CdbLength;
    uint StorAddressLength;
    ubyte ScsiStatus;
    ubyte SenseInfoLength;
    ubyte DataDirection;
    ubyte Reserved;
    uint TimeOutValue;
    uint StorAddressOffset;
    uint SenseInfoOffset;
    uint DataOutTransferLength;
    uint DataInTransferLength;
    void* DataOutBuffer;
    void* DataInBuffer;
    ubyte Cdb;
}

struct ATA_PASS_THROUGH_EX
{
    ushort Length;
    ushort AtaFlags;
    ubyte PathId;
    ubyte TargetId;
    ubyte Lun;
    ubyte ReservedAsUchar;
    uint DataTransferLength;
    uint TimeOutValue;
    uint ReservedAsUlong;
    uint DataBufferOffset;
    ubyte PreviousTaskFile;
    ubyte CurrentTaskFile;
}

struct ATA_PASS_THROUGH_DIRECT
{
    ushort Length;
    ushort AtaFlags;
    ubyte PathId;
    ubyte TargetId;
    ubyte Lun;
    ubyte ReservedAsUchar;
    uint DataTransferLength;
    uint TimeOutValue;
    uint ReservedAsUlong;
    void* DataBuffer;
    ubyte PreviousTaskFile;
    ubyte CurrentTaskFile;
}

struct IDE_IO_CONTROL
{
    uint HeaderLength;
    ubyte Signature;
    uint Timeout;
    uint ControlCode;
    uint ReturnStatus;
    uint DataLength;
}

struct MPIO_PASS_THROUGH_PATH
{
    SCSI_PASS_THROUGH PassThrough;
    uint Version;
    ushort Length;
    ubyte Flags;
    ubyte PortNumber;
    ulong MpioPathId;
}

struct MPIO_PASS_THROUGH_PATH_DIRECT
{
    SCSI_PASS_THROUGH_DIRECT PassThrough;
    uint Version;
    ushort Length;
    ubyte Flags;
    ubyte PortNumber;
    ulong MpioPathId;
}

struct MPIO_PASS_THROUGH_PATH_EX
{
    uint PassThroughOffset;
    uint Version;
    ushort Length;
    ubyte Flags;
    ubyte PortNumber;
    ulong MpioPathId;
}

struct MPIO_PASS_THROUGH_PATH_DIRECT_EX
{
    uint PassThroughOffset;
    uint Version;
    ushort Length;
    ubyte Flags;
    ubyte PortNumber;
    ulong MpioPathId;
}

struct SCSI_BUS_DATA
{
    ubyte NumberOfLogicalUnits;
    ubyte InitiatorBusId;
    uint InquiryDataOffset;
}

struct SCSI_ADAPTER_BUS_INFO
{
    ubyte NumberOfBuses;
    SCSI_BUS_DATA BusData;
}

struct SCSI_INQUIRY_DATA
{
    ubyte PathId;
    ubyte TargetId;
    ubyte Lun;
    ubyte DeviceClaimed;
    uint InquiryDataLength;
    uint NextInquiryDataOffset;
    ubyte InquiryData;
}

struct SRB_IO_CONTROL
{
    uint HeaderLength;
    ubyte Signature;
    uint Timeout;
    uint ControlCode;
    uint ReturnCode;
    uint Length;
}

struct NVCACHE_REQUEST_BLOCK
{
    uint NRBSize;
    ushort Function;
    uint NRBFlags;
    uint NRBStatus;
    uint Count;
    ulong LBA;
    uint DataBufSize;
    uint NVCacheStatus;
    uint NVCacheSubStatus;
}

struct NV_FEATURE_PARAMETER
{
    ushort NVPowerModeEnabled;
    ushort NVParameterReserv1;
    ushort NVCmdEnabled;
    ushort NVParameterReserv2;
    ushort NVPowerModeVer;
    ushort NVCmdVer;
    uint NVSize;
    ushort NVReadSpeed;
    ushort NVWrtSpeed;
    uint DeviceSpinUpTime;
}

struct NVCACHE_HINT_PAYLOAD
{
    ubyte Command;
    ubyte Feature7_0;
    ubyte Feature15_8;
    ubyte Count15_8;
    ubyte LBA7_0;
    ubyte LBA15_8;
    ubyte LBA23_16;
    ubyte LBA31_24;
    ubyte LBA39_32;
    ubyte LBA47_40;
    ubyte Auxiliary7_0;
    ubyte Auxiliary23_16;
    ubyte Reserved;
}

struct NV_SEP_CACHE_PARAMETER
{
    uint Version;
    uint Size;
    _Flags_e__Union Flags;
    ubyte WriteCacheType;
    ubyte WriteCacheTypeEffective;
    ubyte ParameterReserve1;
}

enum NV_SEP_WRITE_CACHE_TYPE
{
    NVSEPWriteCacheTypeUnknown = 0,
    NVSEPWriteCacheTypeNone = 1,
    NVSEPWriteCacheTypeWriteBack = 2,
    NVSEPWriteCacheTypeWriteThrough = 3,
}

enum MP_STORAGE_DIAGNOSTIC_LEVEL
{
    MpStorageDiagnosticLevelDefault = 0,
    MpStorageDiagnosticLevelMax = 1,
}

enum MP_STORAGE_DIAGNOSTIC_TARGET_TYPE
{
    MpStorageDiagnosticTargetTypeUndefined = 0,
    MpStorageDiagnosticTargetTypeMiniport = 2,
    MpStorageDiagnosticTargetTypeHbaFirmware = 3,
    MpStorageDiagnosticTargetTypeMax = 4,
}

struct STORAGE_DIAGNOSTIC_MP_REQUEST
{
    uint Version;
    uint Size;
    MP_STORAGE_DIAGNOSTIC_TARGET_TYPE TargetType;
    MP_STORAGE_DIAGNOSTIC_LEVEL Level;
    Guid ProviderId;
    uint BufferSize;
    uint Reserved;
    ubyte DataBuffer;
}

struct MP_DEVICE_DATA_SET_RANGE
{
    long StartingOffset;
    ulong LengthInBytes;
}

struct DSM_NOTIFICATION_REQUEST_BLOCK
{
    uint Size;
    uint Version;
    uint NotifyFlags;
    uint DataSetProfile;
    uint Reserved;
    uint DataSetRangesCount;
    MP_DEVICE_DATA_SET_RANGE DataSetRanges;
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

enum NVCACHE_TYPE
{
    NvCacheTypeUnknown = 0,
    NvCacheTypeNone = 1,
    NvCacheTypeWriteBack = 2,
    NvCacheTypeWriteThrough = 3,
}

enum NVCACHE_STATUS
{
    NvCacheStatusUnknown = 0,
    NvCacheStatusDisabling = 1,
    NvCacheStatusDisabled = 2,
    NvCacheStatusEnabled = 3,
}

struct NVCACHE_PRIORITY_LEVEL_DESCRIPTOR
{
    ubyte PriorityLevel;
    ubyte Reserved0;
    uint ConsumedNVMSizeFraction;
    uint ConsumedMappingResourcesFraction;
    uint ConsumedNVMSizeForDirtyDataFraction;
    uint ConsumedMappingResourcesForDirtyDataFraction;
    uint Reserved1;
}

struct HYBRID_INFORMATION
{
    uint Version;
    uint Size;
    ubyte HybridSupported;
    NVCACHE_STATUS Status;
    NVCACHE_TYPE CacheTypeEffective;
    NVCACHE_TYPE CacheTypeDefault;
    uint FractionBase;
    ulong CacheSize;
    _Attributes_e__Struct Attributes;
    _Priorities_e__Struct Priorities;
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
    uint Version;
    uint Size;
    ubyte SourcePriority;
    ubyte TargetPriority;
    ushort Reserved0;
    uint Reserved1;
    ulong LbaCount;
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
    ubyte SlotNumber;
    ubyte ReadOnly;
    ubyte Reserved;
    _Revision_e__Union Revision;
}

struct STORAGE_FIRMWARE_SLOT_INFO_V2
{
    ubyte SlotNumber;
    ubyte ReadOnly;
    ubyte Reserved;
    ubyte Revision;
}

struct STORAGE_FIRMWARE_INFO
{
    uint Version;
    uint Size;
    ubyte UpgradeSupport;
    ubyte SlotCount;
    ubyte ActiveSlot;
    ubyte PendingActivateSlot;
    uint Reserved;
    STORAGE_FIRMWARE_SLOT_INFO Slot;
}

struct STORAGE_FIRMWARE_INFO_V2
{
    uint Version;
    uint Size;
    ubyte UpgradeSupport;
    ubyte SlotCount;
    ubyte ActiveSlot;
    ubyte PendingActivateSlot;
    ubyte FirmwareShared;
    ubyte Reserved;
    uint ImagePayloadAlignment;
    uint ImagePayloadMaxSize;
    STORAGE_FIRMWARE_SLOT_INFO_V2 Slot;
}

struct STORAGE_FIRMWARE_DOWNLOAD
{
    uint Version;
    uint Size;
    ulong Offset;
    ulong BufferSize;
    ubyte ImageBuffer;
}

struct STORAGE_FIRMWARE_DOWNLOAD_V2
{
    uint Version;
    uint Size;
    ulong Offset;
    ulong BufferSize;
    ubyte Slot;
    ubyte Reserved;
    uint ImageSize;
    ubyte ImageBuffer;
}

struct STORAGE_FIRMWARE_ACTIVATE
{
    uint Version;
    uint Size;
    ubyte SlotToActivate;
    ubyte Reserved0;
}

struct IO_SCSI_CAPABILITIES
{
    uint Length;
    uint MaximumTransferLength;
    uint MaximumPhysicalPages;
    uint SupportedAsynchronousEvents;
    uint AlignmentMask;
    ubyte TaggedQueuing;
    ubyte AdapterScansDown;
    ubyte AdapterUsesPio;
}

struct SCSI_ADDRESS
{
    uint Length;
    ubyte PortNumber;
    ubyte PathId;
    ubyte TargetId;
    ubyte Lun;
}

struct _ADAPTER_OBJECT
{
}

alias DUMP_DEVICE_POWERON_ROUTINE = extern(Windows) int function(void* Context);
alias PDUMP_DEVICE_POWERON_ROUTINE = extern(Windows) int function();
struct DUMP_POINTERS_VERSION
{
    uint Version;
    uint Size;
}

struct DUMP_POINTERS
{
    _ADAPTER_OBJECT* AdapterObject;
    void* MappedRegisterBase;
    void* DumpData;
    void* CommonBufferVa;
    LARGE_INTEGER CommonBufferPa;
    uint CommonBufferSize;
    ubyte AllocateCommonBuffers;
    ubyte UseDiskDump;
    ubyte Spare1;
    void* DeviceObject;
}

struct DUMP_POINTERS_EX
{
    DUMP_POINTERS_VERSION Header;
    void* DumpData;
    void* CommonBufferVa;
    uint CommonBufferSize;
    ubyte AllocateCommonBuffers;
    void* DeviceObject;
    void* DriverList;
    uint dwPortFlags;
    uint MaxDeviceDumpSectionSize;
    uint MaxDeviceDumpLevel;
    uint MaxTransferSize;
    void* AdapterObject;
    void* MappedRegisterBase;
    ubyte* DeviceReady;
    PDUMP_DEVICE_POWERON_ROUTINE DumpDevicePowerOn;
    void* DumpDevicePowerOnContext;
}

struct DUMP_DRIVER
{
    void* DumpDriverList;
    ushort DriverName;
    ushort BaseName;
}

struct NTSCSI_UNICODE_STRING
{
    ushort Length;
    ushort MaximumLength;
    const(wchar)* Buffer;
}

struct DUMP_DRIVER_EX
{
    void* DumpDriverList;
    ushort DriverName;
    ushort BaseName;
    NTSCSI_UNICODE_STRING DriverFullPath;
}

struct STORAGE_ENDURANCE_INFO
{
    uint ValidFields;
    uint GroupId;
    _Flags_e__Struct Flags;
    uint LifePercentage;
    ubyte BytesReadCount;
    ubyte ByteWriteCount;
}

struct STORAGE_ENDURANCE_DATA_DESCRIPTOR
{
    uint Version;
    uint Size;
    STORAGE_ENDURANCE_INFO EnduranceInfo;
}

enum ISCSI_DIGEST_TYPES
{
    ISCSI_DIGEST_TYPE_NONE = 0,
    ISCSI_DIGEST_TYPE_CRC32C = 1,
}

enum ISCSI_AUTH_TYPES
{
    ISCSI_NO_AUTH_TYPE = 0,
    ISCSI_CHAP_AUTH_TYPE = 1,
    ISCSI_MUTUAL_CHAP_AUTH_TYPE = 2,
}

struct ISCSI_LOGIN_OPTIONS
{
    uint Version;
    uint InformationSpecified;
    uint LoginFlags;
    ISCSI_AUTH_TYPES AuthType;
    ISCSI_DIGEST_TYPES HeaderDigest;
    ISCSI_DIGEST_TYPES DataDigest;
    uint MaximumConnections;
    uint DefaultTime2Wait;
    uint DefaultTime2Retain;
    uint UsernameLength;
    uint PasswordLength;
    ubyte* Username;
    ubyte* Password;
}

enum IKE_AUTHENTICATION_METHOD
{
    IKE_AUTHENTICATION_PRESHARED_KEY_METHOD = 1,
}

struct IKE_AUTHENTICATION_PRESHARED_KEY
{
    ulong SecurityFlags;
    ubyte IdType;
    uint IdLengthInBytes;
    ubyte* Id;
    uint KeyLengthInBytes;
    ubyte* Key;
}

struct IKE_AUTHENTICATION_INFORMATION
{
    IKE_AUTHENTICATION_METHOD AuthMethod;
    _Anonymous_e__Union Anonymous;
}

struct ISCSI_UNIQUE_SESSION_ID
{
    ulong AdapterUnique;
    ulong AdapterSpecific;
}

struct SCSI_LUN_LIST
{
    uint OSLUN;
    ulong TargetLUN;
}

struct ISCSI_TARGET_MAPPINGW
{
    ushort InitiatorName;
    ushort TargetName;
    ushort OSDeviceName;
    ISCSI_UNIQUE_SESSION_ID SessionId;
    uint OSBusNumber;
    uint OSTargetNumber;
    uint LUNCount;
    SCSI_LUN_LIST* LUNList;
}

struct ISCSI_TARGET_MAPPINGA
{
    byte InitiatorName;
    byte TargetName;
    byte OSDeviceName;
    ISCSI_UNIQUE_SESSION_ID SessionId;
    uint OSBusNumber;
    uint OSTargetNumber;
    uint LUNCount;
    SCSI_LUN_LIST* LUNList;
}

struct ISCSI_TARGET_PORTALW
{
    ushort SymbolicName;
    ushort Address;
    ushort Socket;
}

struct ISCSI_TARGET_PORTALA
{
    byte SymbolicName;
    byte Address;
    ushort Socket;
}

struct ISCSI_TARGET_PORTAL_INFOW
{
    ushort InitiatorName;
    uint InitiatorPortNumber;
    ushort SymbolicName;
    ushort Address;
    ushort Socket;
}

struct ISCSI_TARGET_PORTAL_INFOA
{
    byte InitiatorName;
    uint InitiatorPortNumber;
    byte SymbolicName;
    byte Address;
    ushort Socket;
}

struct ISCSI_TARGET_PORTAL_INFO_EXW
{
    ushort InitiatorName;
    uint InitiatorPortNumber;
    ushort SymbolicName;
    ushort Address;
    ushort Socket;
    ulong SecurityFlags;
    ISCSI_LOGIN_OPTIONS LoginOptions;
}

struct ISCSI_TARGET_PORTAL_INFO_EXA
{
    byte InitiatorName;
    uint InitiatorPortNumber;
    byte SymbolicName;
    byte Address;
    ushort Socket;
    ulong SecurityFlags;
    ISCSI_LOGIN_OPTIONS LoginOptions;
}

struct ISCSI_TARGET_PORTAL_GROUPW
{
    uint Count;
    ISCSI_TARGET_PORTALW Portals;
}

struct ISCSI_TARGET_PORTAL_GROUPA
{
    uint Count;
    ISCSI_TARGET_PORTALA Portals;
}

struct ISCSI_CONNECTION_INFOW
{
    ISCSI_UNIQUE_SESSION_ID ConnectionId;
    const(wchar)* InitiatorAddress;
    const(wchar)* TargetAddress;
    ushort InitiatorSocket;
    ushort TargetSocket;
    ubyte CID;
}

struct ISCSI_SESSION_INFOW
{
    ISCSI_UNIQUE_SESSION_ID SessionId;
    const(wchar)* InitiatorName;
    const(wchar)* TargetNodeName;
    const(wchar)* TargetName;
    ubyte ISID;
    ubyte TSID;
    uint ConnectionCount;
    ISCSI_CONNECTION_INFOW* Connections;
}

struct ISCSI_CONNECTION_INFOA
{
    ISCSI_UNIQUE_SESSION_ID ConnectionId;
    const(char)* InitiatorAddress;
    const(char)* TargetAddress;
    ushort InitiatorSocket;
    ushort TargetSocket;
    ubyte CID;
}

struct ISCSI_SESSION_INFOA
{
    ISCSI_UNIQUE_SESSION_ID SessionId;
    const(char)* InitiatorName;
    const(char)* TargetNodeName;
    const(char)* TargetName;
    ubyte ISID;
    ubyte TSID;
    uint ConnectionCount;
    ISCSI_CONNECTION_INFOA* Connections;
}

struct ISCSI_CONNECTION_INFO_EX
{
    ISCSI_UNIQUE_SESSION_ID ConnectionId;
    ubyte State;
    ubyte Protocol;
    ubyte HeaderDigest;
    ubyte DataDigest;
    uint MaxRecvDataSegmentLength;
    ISCSI_AUTH_TYPES AuthType;
    ulong EstimatedThroughput;
    uint MaxDatagramSize;
}

struct ISCSI_SESSION_INFO_EX
{
    ISCSI_UNIQUE_SESSION_ID SessionId;
    ubyte InitialR2t;
    ubyte ImmediateData;
    ubyte Type;
    ubyte DataSequenceInOrder;
    ubyte DataPduInOrder;
    ubyte ErrorRecoveryLevel;
    uint MaxOutstandingR2t;
    uint FirstBurstLength;
    uint MaxBurstLength;
    uint MaximumConnections;
    uint ConnectionCount;
    ISCSI_CONNECTION_INFO_EX* Connections;
}

struct ISCSI_DEVICE_ON_SESSIONW
{
    ushort InitiatorName;
    ushort TargetName;
    SCSI_ADDRESS ScsiAddress;
    Guid DeviceInterfaceType;
    ushort DeviceInterfaceName;
    ushort LegacyName;
    STORAGE_DEVICE_NUMBER StorageDeviceNumber;
    uint DeviceInstance;
}

struct ISCSI_DEVICE_ON_SESSIONA
{
    byte InitiatorName;
    byte TargetName;
    SCSI_ADDRESS ScsiAddress;
    Guid DeviceInterfaceType;
    byte DeviceInterfaceName;
    byte LegacyName;
    STORAGE_DEVICE_NUMBER StorageDeviceNumber;
    uint DeviceInstance;
}

struct PERSISTENT_ISCSI_LOGIN_INFOW
{
    ushort TargetName;
    ubyte IsInformationalSession;
    ushort InitiatorInstance;
    uint InitiatorPortNumber;
    ISCSI_TARGET_PORTALW TargetPortal;
    ulong SecurityFlags;
    ISCSI_TARGET_MAPPINGW* Mappings;
    ISCSI_LOGIN_OPTIONS LoginOptions;
}

struct PERSISTENT_ISCSI_LOGIN_INFOA
{
    byte TargetName;
    ubyte IsInformationalSession;
    byte InitiatorInstance;
    uint InitiatorPortNumber;
    ISCSI_TARGET_PORTALA TargetPortal;
    ulong SecurityFlags;
    ISCSI_TARGET_MAPPINGA* Mappings;
    ISCSI_LOGIN_OPTIONS LoginOptions;
}

enum TARGETPROTOCOLTYPE
{
    ISCSI_TCP_PROTOCOL_TYPE = 0,
}

enum TARGET_INFORMATION_CLASS
{
    ProtocolType = 0,
    TargetAlias = 1,
    DiscoveryMechanisms = 2,
    PortalGroups = 3,
    PersistentTargetMappings = 4,
    InitiatorName = 5,
    TargetFlags = 6,
    LoginOptions = 7,
}

struct ISCSI_VERSION_INFO
{
    uint MajorVersion;
    uint MinorVersion;
    uint BuildNumber;
}

@DllImport("ISCSIDSC.dll")
uint GetIScsiVersionInformation(ISCSI_VERSION_INFO* VersionInfo);

@DllImport("ISCSIDSC.dll")
uint GetIScsiTargetInformationW(const(wchar)* TargetName, const(wchar)* DiscoveryMechanism, TARGET_INFORMATION_CLASS InfoClass, uint* BufferSize, void* Buffer);

@DllImport("ISCSIDSC.dll")
uint GetIScsiTargetInformationA(const(char)* TargetName, const(char)* DiscoveryMechanism, TARGET_INFORMATION_CLASS InfoClass, uint* BufferSize, void* Buffer);

@DllImport("ISCSIDSC.dll")
uint AddIScsiConnectionW(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, void* Reserved, uint InitiatorPortNumber, ISCSI_TARGET_PORTALW* TargetPortal, ulong SecurityFlags, ISCSI_LOGIN_OPTIONS* LoginOptions, uint KeySize, const(char)* Key, ISCSI_UNIQUE_SESSION_ID* ConnectionId);

@DllImport("ISCSIDSC.dll")
uint AddIScsiConnectionA(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, void* Reserved, uint InitiatorPortNumber, ISCSI_TARGET_PORTALA* TargetPortal, ulong SecurityFlags, ISCSI_LOGIN_OPTIONS* LoginOptions, uint KeySize, const(char)* Key, ISCSI_UNIQUE_SESSION_ID* ConnectionId);

@DllImport("ISCSIDSC.dll")
uint RemoveIScsiConnection(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, ISCSI_UNIQUE_SESSION_ID* ConnectionId);

@DllImport("ISCSIDSC.dll")
uint ReportIScsiTargetsW(ubyte ForceUpdate, uint* BufferSize, const(wchar)* Buffer);

@DllImport("ISCSIDSC.dll")
uint ReportIScsiTargetsA(ubyte ForceUpdate, uint* BufferSize, const(char)* Buffer);

@DllImport("ISCSIDSC.dll")
uint AddIScsiStaticTargetW(const(wchar)* TargetName, const(wchar)* TargetAlias, uint TargetFlags, ubyte Persist, ISCSI_TARGET_MAPPINGW* Mappings, ISCSI_LOGIN_OPTIONS* LoginOptions, ISCSI_TARGET_PORTAL_GROUPW* PortalGroup);

@DllImport("ISCSIDSC.dll")
uint AddIScsiStaticTargetA(const(char)* TargetName, const(char)* TargetAlias, uint TargetFlags, ubyte Persist, ISCSI_TARGET_MAPPINGA* Mappings, ISCSI_LOGIN_OPTIONS* LoginOptions, ISCSI_TARGET_PORTAL_GROUPA* PortalGroup);

@DllImport("ISCSIDSC.dll")
uint RemoveIScsiStaticTargetW(const(wchar)* TargetName);

@DllImport("ISCSIDSC.dll")
uint RemoveIScsiStaticTargetA(const(char)* TargetName);

@DllImport("ISCSIDSC.dll")
uint AddIScsiSendTargetPortalW(const(wchar)* InitiatorInstance, uint InitiatorPortNumber, ISCSI_LOGIN_OPTIONS* LoginOptions, ulong SecurityFlags, ISCSI_TARGET_PORTALW* Portal);

@DllImport("ISCSIDSC.dll")
uint AddIScsiSendTargetPortalA(const(char)* InitiatorInstance, uint InitiatorPortNumber, ISCSI_LOGIN_OPTIONS* LoginOptions, ulong SecurityFlags, ISCSI_TARGET_PORTALA* Portal);

@DllImport("ISCSIDSC.dll")
uint RemoveIScsiSendTargetPortalW(const(wchar)* InitiatorInstance, uint InitiatorPortNumber, ISCSI_TARGET_PORTALW* Portal);

@DllImport("ISCSIDSC.dll")
uint RemoveIScsiSendTargetPortalA(const(char)* InitiatorInstance, uint InitiatorPortNumber, ISCSI_TARGET_PORTALA* Portal);

@DllImport("ISCSIDSC.dll")
uint RefreshIScsiSendTargetPortalW(const(wchar)* InitiatorInstance, uint InitiatorPortNumber, ISCSI_TARGET_PORTALW* Portal);

@DllImport("ISCSIDSC.dll")
uint RefreshIScsiSendTargetPortalA(const(char)* InitiatorInstance, uint InitiatorPortNumber, ISCSI_TARGET_PORTALA* Portal);

@DllImport("ISCSIDSC.dll")
uint ReportIScsiSendTargetPortalsW(uint* PortalCount, ISCSI_TARGET_PORTAL_INFOW* PortalInfo);

@DllImport("ISCSIDSC.dll")
uint ReportIScsiSendTargetPortalsA(uint* PortalCount, ISCSI_TARGET_PORTAL_INFOA* PortalInfo);

@DllImport("ISCSIDSC.dll")
uint ReportIScsiSendTargetPortalsExW(uint* PortalCount, uint* PortalInfoSize, ISCSI_TARGET_PORTAL_INFO_EXW* PortalInfo);

@DllImport("ISCSIDSC.dll")
uint ReportIScsiSendTargetPortalsExA(uint* PortalCount, uint* PortalInfoSize, ISCSI_TARGET_PORTAL_INFO_EXA* PortalInfo);

@DllImport("ISCSIDSC.dll")
uint LoginIScsiTargetW(const(wchar)* TargetName, ubyte IsInformationalSession, const(wchar)* InitiatorInstance, uint InitiatorPortNumber, ISCSI_TARGET_PORTALW* TargetPortal, ulong SecurityFlags, ISCSI_TARGET_MAPPINGW* Mappings, ISCSI_LOGIN_OPTIONS* LoginOptions, uint KeySize, const(char)* Key, ubyte IsPersistent, ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, ISCSI_UNIQUE_SESSION_ID* UniqueConnectionId);

@DllImport("ISCSIDSC.dll")
uint LoginIScsiTargetA(const(char)* TargetName, ubyte IsInformationalSession, const(char)* InitiatorInstance, uint InitiatorPortNumber, ISCSI_TARGET_PORTALA* TargetPortal, ulong SecurityFlags, ISCSI_TARGET_MAPPINGA* Mappings, ISCSI_LOGIN_OPTIONS* LoginOptions, uint KeySize, const(char)* Key, ubyte IsPersistent, ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, ISCSI_UNIQUE_SESSION_ID* UniqueConnectionId);

@DllImport("ISCSIDSC.dll")
uint ReportIScsiPersistentLoginsW(uint* Count, PERSISTENT_ISCSI_LOGIN_INFOW* PersistentLoginInfo, uint* BufferSizeInBytes);

@DllImport("ISCSIDSC.dll")
uint ReportIScsiPersistentLoginsA(uint* Count, PERSISTENT_ISCSI_LOGIN_INFOA* PersistentLoginInfo, uint* BufferSizeInBytes);

@DllImport("ISCSIDSC.dll")
uint LogoutIScsiTarget(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId);

@DllImport("ISCSIDSC.dll")
uint RemoveIScsiPersistentTargetW(const(wchar)* InitiatorInstance, uint InitiatorPortNumber, const(wchar)* TargetName, ISCSI_TARGET_PORTALW* Portal);

@DllImport("ISCSIDSC.dll")
uint RemoveIScsiPersistentTargetA(const(char)* InitiatorInstance, uint InitiatorPortNumber, const(char)* TargetName, ISCSI_TARGET_PORTALA* Portal);

@DllImport("ISCSIDSC.dll")
uint SendScsiInquiry(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, ulong Lun, ubyte EvpdCmddt, ubyte PageCode, ubyte* ScsiStatus, uint* ResponseSize, ubyte* ResponseBuffer, uint* SenseSize, ubyte* SenseBuffer);

@DllImport("ISCSIDSC.dll")
uint SendScsiReadCapacity(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, ulong Lun, ubyte* ScsiStatus, uint* ResponseSize, ubyte* ResponseBuffer, uint* SenseSize, ubyte* SenseBuffer);

@DllImport("ISCSIDSC.dll")
uint SendScsiReportLuns(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, ubyte* ScsiStatus, uint* ResponseSize, ubyte* ResponseBuffer, uint* SenseSize, ubyte* SenseBuffer);

@DllImport("ISCSIDSC.dll")
uint ReportIScsiInitiatorListW(uint* BufferSize, const(wchar)* Buffer);

@DllImport("ISCSIDSC.dll")
uint ReportIScsiInitiatorListA(uint* BufferSize, const(char)* Buffer);

@DllImport("ISCSIDSC.dll")
uint ReportActiveIScsiTargetMappingsW(uint* BufferSize, uint* MappingCount, ISCSI_TARGET_MAPPINGW* Mappings);

@DllImport("ISCSIDSC.dll")
uint ReportActiveIScsiTargetMappingsA(uint* BufferSize, uint* MappingCount, ISCSI_TARGET_MAPPINGA* Mappings);

@DllImport("ISCSIDSC.dll")
uint SetIScsiTunnelModeOuterAddressW(const(wchar)* InitiatorName, uint InitiatorPortNumber, const(wchar)* DestinationAddress, const(wchar)* OuterModeAddress, ubyte Persist);

@DllImport("ISCSIDSC.dll")
uint SetIScsiTunnelModeOuterAddressA(const(char)* InitiatorName, uint InitiatorPortNumber, const(char)* DestinationAddress, const(char)* OuterModeAddress, ubyte Persist);

@DllImport("ISCSIDSC.dll")
uint SetIScsiIKEInfoW(const(wchar)* InitiatorName, uint InitiatorPortNumber, IKE_AUTHENTICATION_INFORMATION* AuthInfo, ubyte Persist);

@DllImport("ISCSIDSC.dll")
uint SetIScsiIKEInfoA(const(char)* InitiatorName, uint InitiatorPortNumber, IKE_AUTHENTICATION_INFORMATION* AuthInfo, ubyte Persist);

@DllImport("ISCSIDSC.dll")
uint GetIScsiIKEInfoW(const(wchar)* InitiatorName, uint InitiatorPortNumber, uint* Reserved, IKE_AUTHENTICATION_INFORMATION* AuthInfo);

@DllImport("ISCSIDSC.dll")
uint GetIScsiIKEInfoA(const(char)* InitiatorName, uint InitiatorPortNumber, uint* Reserved, IKE_AUTHENTICATION_INFORMATION* AuthInfo);

@DllImport("ISCSIDSC.dll")
uint SetIScsiGroupPresharedKey(uint KeyLength, ubyte* Key, ubyte Persist);

@DllImport("ISCSIDSC.dll")
uint SetIScsiInitiatorCHAPSharedSecret(uint SharedSecretLength, ubyte* SharedSecret);

@DllImport("ISCSIDSC.dll")
uint SetIScsiInitiatorRADIUSSharedSecret(uint SharedSecretLength, ubyte* SharedSecret);

@DllImport("ISCSIDSC.dll")
uint SetIScsiInitiatorNodeNameW(const(wchar)* InitiatorNodeName);

@DllImport("ISCSIDSC.dll")
uint SetIScsiInitiatorNodeNameA(const(char)* InitiatorNodeName);

@DllImport("ISCSIDSC.dll")
uint GetIScsiInitiatorNodeNameW(const(wchar)* InitiatorNodeName);

@DllImport("ISCSIDSC.dll")
uint GetIScsiInitiatorNodeNameA(const(char)* InitiatorNodeName);

@DllImport("ISCSIDSC.dll")
uint AddISNSServerW(const(wchar)* Address);

@DllImport("ISCSIDSC.dll")
uint AddISNSServerA(const(char)* Address);

@DllImport("ISCSIDSC.dll")
uint RemoveISNSServerW(const(wchar)* Address);

@DllImport("ISCSIDSC.dll")
uint RemoveISNSServerA(const(char)* Address);

@DllImport("ISCSIDSC.dll")
uint RefreshISNSServerW(const(wchar)* Address);

@DllImport("ISCSIDSC.dll")
uint RefreshISNSServerA(const(char)* Address);

@DllImport("ISCSIDSC.dll")
uint ReportISNSServerListW(uint* BufferSizeInChar, const(wchar)* Buffer);

@DllImport("ISCSIDSC.dll")
uint ReportISNSServerListA(uint* BufferSizeInChar, const(char)* Buffer);

@DllImport("ISCSIDSC.dll")
uint GetIScsiSessionListW(uint* BufferSize, uint* SessionCount, ISCSI_SESSION_INFOW* SessionInfo);

@DllImport("ISCSIDSC.dll")
uint GetIScsiSessionListA(uint* BufferSize, uint* SessionCount, ISCSI_SESSION_INFOA* SessionInfo);

@DllImport("ISCSIDSC.dll")
uint GetIScsiSessionListEx(uint* BufferSize, uint* SessionCountPtr, ISCSI_SESSION_INFO_EX* SessionInfo);

@DllImport("ISCSIDSC.dll")
uint GetDevicesForIScsiSessionW(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, uint* DeviceCount, ISCSI_DEVICE_ON_SESSIONW* Devices);

@DllImport("ISCSIDSC.dll")
uint GetDevicesForIScsiSessionA(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, uint* DeviceCount, ISCSI_DEVICE_ON_SESSIONA* Devices);

@DllImport("ISCSIDSC.dll")
uint SetupPersistentIScsiVolumes();

@DllImport("ISCSIDSC.dll")
uint SetupPersistentIScsiDevices();

@DllImport("ISCSIDSC.dll")
uint AddPersistentIScsiDeviceW(const(wchar)* DevicePath);

@DllImport("ISCSIDSC.dll")
uint AddPersistentIScsiDeviceA(const(char)* DevicePath);

@DllImport("ISCSIDSC.dll")
uint RemovePersistentIScsiDeviceW(const(wchar)* DevicePath);

@DllImport("ISCSIDSC.dll")
uint RemovePersistentIScsiDeviceA(const(char)* DevicePath);

@DllImport("ISCSIDSC.dll")
uint ClearPersistentIScsiDevices();

@DllImport("ISCSIDSC.dll")
uint ReportPersistentIScsiDevicesW(uint* BufferSizeInChar, const(wchar)* Buffer);

@DllImport("ISCSIDSC.dll")
uint ReportPersistentIScsiDevicesA(uint* BufferSizeInChar, const(char)* Buffer);

@DllImport("ISCSIDSC.dll")
uint ReportIScsiTargetPortalsW(const(wchar)* InitiatorName, const(wchar)* TargetName, ushort* TargetPortalTag, uint* ElementCount, ISCSI_TARGET_PORTALW* Portals);

@DllImport("ISCSIDSC.dll")
uint ReportIScsiTargetPortalsA(const(char)* InitiatorName, const(char)* TargetName, ushort* TargetPortalTag, uint* ElementCount, ISCSI_TARGET_PORTALA* Portals);

@DllImport("ISCSIDSC.dll")
uint AddRadiusServerW(const(wchar)* Address);

@DllImport("ISCSIDSC.dll")
uint AddRadiusServerA(const(char)* Address);

@DllImport("ISCSIDSC.dll")
uint RemoveRadiusServerW(const(wchar)* Address);

@DllImport("ISCSIDSC.dll")
uint RemoveRadiusServerA(const(char)* Address);

@DllImport("ISCSIDSC.dll")
uint ReportRadiusServerListW(uint* BufferSizeInChar, const(wchar)* Buffer);

@DllImport("ISCSIDSC.dll")
uint ReportRadiusServerListA(uint* BufferSizeInChar, const(char)* Buffer);

