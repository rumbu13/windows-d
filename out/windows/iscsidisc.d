module windows.iscsidisc;

public import windows.core;
public import windows.systemservices : LARGE_INTEGER, STORAGE_DEVICE_NUMBER;

extern(Windows):


// Enums


enum : int
{
    NVSEPWriteCacheTypeUnknown      = 0x00000000,
    NVSEPWriteCacheTypeNone         = 0x00000001,
    NVSEPWriteCacheTypeWriteBack    = 0x00000002,
    NVSEPWriteCacheTypeWriteThrough = 0x00000003,
}
alias NV_SEP_WRITE_CACHE_TYPE = int;

enum : int
{
    MpStorageDiagnosticLevelDefault = 0x00000000,
    MpStorageDiagnosticLevelMax     = 0x00000001,
}
alias MP_STORAGE_DIAGNOSTIC_LEVEL = int;

enum : int
{
    MpStorageDiagnosticTargetTypeUndefined   = 0x00000000,
    MpStorageDiagnosticTargetTypeMiniport    = 0x00000002,
    MpStorageDiagnosticTargetTypeHbaFirmware = 0x00000003,
    MpStorageDiagnosticTargetTypeMax         = 0x00000004,
}
alias MP_STORAGE_DIAGNOSTIC_TARGET_TYPE = int;

enum : int
{
    NvCacheTypeUnknown      = 0x00000000,
    NvCacheTypeNone         = 0x00000001,
    NvCacheTypeWriteBack    = 0x00000002,
    NvCacheTypeWriteThrough = 0x00000003,
}
alias NVCACHE_TYPE = int;

enum : int
{
    NvCacheStatusUnknown   = 0x00000000,
    NvCacheStatusDisabling = 0x00000001,
    NvCacheStatusDisabled  = 0x00000002,
    NvCacheStatusEnabled   = 0x00000003,
}
alias NVCACHE_STATUS = int;

enum : int
{
    ISCSI_DIGEST_TYPE_NONE   = 0x00000000,
    ISCSI_DIGEST_TYPE_CRC32C = 0x00000001,
}
alias ISCSI_DIGEST_TYPES = int;

enum : int
{
    ISCSI_NO_AUTH_TYPE          = 0x00000000,
    ISCSI_CHAP_AUTH_TYPE        = 0x00000001,
    ISCSI_MUTUAL_CHAP_AUTH_TYPE = 0x00000002,
}
alias ISCSI_AUTH_TYPES = int;

enum : int
{
    IKE_AUTHENTICATION_PRESHARED_KEY_METHOD = 0x00000001,
}
alias IKE_AUTHENTICATION_METHOD = int;

enum : int
{
    ISCSI_TCP_PROTOCOL_TYPE = 0x00000000,
}
alias TARGETPROTOCOLTYPE = int;

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
alias TARGET_INFORMATION_CLASS = int;

// Callbacks

alias DUMP_DEVICE_POWERON_ROUTINE = int function(void* Context);
alias PDUMP_DEVICE_POWERON_ROUTINE = int function();

// Structs


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
    ubyte[1] Cdb;
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
    ubyte[1] Cdb;
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
    SCSI_BUS_DATA[1] BusData;
}

struct SCSI_INQUIRY_DATA
{
    ubyte    PathId;
    ubyte    TargetId;
    ubyte    Lun;
    ubyte    DeviceClaimed;
    uint     InquiryDataLength;
    uint     NextInquiryDataOffset;
    ubyte[1] InquiryData;
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
            ubyte _bitfield47;
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
    ubyte[1] DataBuffer;
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
    MP_DEVICE_DATA_SET_RANGE[1] DataSetRanges;
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
    ubyte          HybridSupported;
    NVCACHE_STATUS Status;
    NVCACHE_TYPE   CacheTypeEffective;
    NVCACHE_TYPE   CacheTypeDefault;
    uint           FractionBase;
    ulong          CacheSize;
    struct Attributes
    {
        uint _bitfield48;
    }
    struct Priorities
    {
        ubyte PriorityLevelCount;
        ubyte MaxPriorityBehavior;
        ubyte OptimalWriteGranularity;
        ubyte Reserved;
        uint  DirtyThresholdLow;
        uint  DirtyThresholdHigh;
        struct SupportedCommands
        {
            uint _bitfield49;
            uint MaxEvictCommands;
            uint MaxLbaRangeCountForEvict;
            uint MaxLbaRangeCountForChangeLba;
        }
        NVCACHE_PRIORITY_LEVEL_DESCRIPTOR[1] Priority;
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
    ubyte    ReadOnly;
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
    ubyte     ReadOnly;
    ubyte[6]  Reserved;
    ubyte[16] Revision;
}

struct STORAGE_FIRMWARE_INFO
{
    uint  Version;
    uint  Size;
    ubyte UpgradeSupport;
    ubyte SlotCount;
    ubyte ActiveSlot;
    ubyte PendingActivateSlot;
    uint  Reserved;
    STORAGE_FIRMWARE_SLOT_INFO[1] Slot;
}

struct STORAGE_FIRMWARE_INFO_V2
{
    uint     Version;
    uint     Size;
    ubyte    UpgradeSupport;
    ubyte    SlotCount;
    ubyte    ActiveSlot;
    ubyte    PendingActivateSlot;
    ubyte    FirmwareShared;
    ubyte[3] Reserved;
    uint     ImagePayloadAlignment;
    uint     ImagePayloadMaxSize;
    STORAGE_FIRMWARE_SLOT_INFO_V2[1] Slot;
}

struct STORAGE_FIRMWARE_DOWNLOAD
{
    uint     Version;
    uint     Size;
    ulong    Offset;
    ulong    BufferSize;
    ubyte[1] ImageBuffer;
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
    ubyte[1] ImageBuffer;
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
    uint  Length;
    uint  MaximumTransferLength;
    uint  MaximumPhysicalPages;
    uint  SupportedAsynchronousEvents;
    uint  AlignmentMask;
    ubyte TaggedQueuing;
    ubyte AdapterScansDown;
    ubyte AdapterUsesPio;
}

struct SCSI_ADDRESS
{
    uint  Length;
    ubyte PortNumber;
    ubyte PathId;
    ubyte TargetId;
    ubyte Lun;
}

struct _ADAPTER_OBJECT
{
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
    LARGE_INTEGER    CommonBufferPa;
    uint             CommonBufferSize;
    ubyte            AllocateCommonBuffers;
    ubyte            UseDiskDump;
    ubyte[2]         Spare1;
    void*            DeviceObject;
}

struct DUMP_POINTERS_EX
{
    DUMP_POINTERS_VERSION Header;
    void*  DumpData;
    void*  CommonBufferVa;
    uint   CommonBufferSize;
    ubyte  AllocateCommonBuffers;
    void*  DeviceObject;
    void*  DriverList;
    uint   dwPortFlags;
    uint   MaxDeviceDumpSectionSize;
    uint   MaxDeviceDumpLevel;
    uint   MaxTransferSize;
    void*  AdapterObject;
    void*  MappedRegisterBase;
    ubyte* DeviceReady;
    PDUMP_DEVICE_POWERON_ROUTINE DumpDevicePowerOn;
    void*  DumpDevicePowerOnContext;
}

struct DUMP_DRIVER
{
    void*      DumpDriverList;
    ushort[15] DriverName;
    ushort[15] BaseName;
}

struct NTSCSI_UNICODE_STRING
{
    ushort        Length;
    ushort        MaximumLength;
    const(wchar)* Buffer;
}

struct DUMP_DRIVER_EX
{
    void*      DumpDriverList;
    ushort[15] DriverName;
    ushort[15] BaseName;
    NTSCSI_UNICODE_STRING DriverFullPath;
}

struct STORAGE_ENDURANCE_INFO
{
    uint      ValidFields;
    uint      GroupId;
    struct Flags
    {
        uint _bitfield50;
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

struct IKE_AUTHENTICATION_PRESHARED_KEY
{
    ulong  SecurityFlags;
    ubyte  IdType;
    uint   IdLengthInBytes;
    ubyte* Id;
    uint   KeyLengthInBytes;
    ubyte* Key;
}

struct IKE_AUTHENTICATION_INFORMATION
{
    IKE_AUTHENTICATION_METHOD AuthMethod;
    union
    {
        IKE_AUTHENTICATION_PRESHARED_KEY PsKey;
    }
}

struct ISCSI_UNIQUE_SESSION_ID
{
    ulong AdapterUnique;
    ulong AdapterSpecific;
}

struct SCSI_LUN_LIST
{
    uint  OSLUN;
    ulong TargetLUN;
}

struct ISCSI_TARGET_MAPPINGW
{
    ushort[256]    InitiatorName;
    ushort[224]    TargetName;
    ushort[260]    OSDeviceName;
    ISCSI_UNIQUE_SESSION_ID SessionId;
    uint           OSBusNumber;
    uint           OSTargetNumber;
    uint           LUNCount;
    SCSI_LUN_LIST* LUNList;
}

struct ISCSI_TARGET_MAPPINGA
{
    byte[256]      InitiatorName;
    byte[224]      TargetName;
    byte[260]      OSDeviceName;
    ISCSI_UNIQUE_SESSION_ID SessionId;
    uint           OSBusNumber;
    uint           OSTargetNumber;
    uint           LUNCount;
    SCSI_LUN_LIST* LUNList;
}

struct ISCSI_TARGET_PORTALW
{
    ushort[256] SymbolicName;
    ushort[256] Address;
    ushort      Socket;
}

struct ISCSI_TARGET_PORTALA
{
    byte[256] SymbolicName;
    byte[256] Address;
    ushort    Socket;
}

struct ISCSI_TARGET_PORTAL_INFOW
{
    ushort[256] InitiatorName;
    uint        InitiatorPortNumber;
    ushort[256] SymbolicName;
    ushort[256] Address;
    ushort      Socket;
}

struct ISCSI_TARGET_PORTAL_INFOA
{
    byte[256] InitiatorName;
    uint      InitiatorPortNumber;
    byte[256] SymbolicName;
    byte[256] Address;
    ushort    Socket;
}

struct ISCSI_TARGET_PORTAL_INFO_EXW
{
    ushort[256]         InitiatorName;
    uint                InitiatorPortNumber;
    ushort[256]         SymbolicName;
    ushort[256]         Address;
    ushort              Socket;
    ulong               SecurityFlags;
    ISCSI_LOGIN_OPTIONS LoginOptions;
}

struct ISCSI_TARGET_PORTAL_INFO_EXA
{
    byte[256]           InitiatorName;
    uint                InitiatorPortNumber;
    byte[256]           SymbolicName;
    byte[256]           Address;
    ushort              Socket;
    ulong               SecurityFlags;
    ISCSI_LOGIN_OPTIONS LoginOptions;
}

struct ISCSI_TARGET_PORTAL_GROUPW
{
    uint Count;
    ISCSI_TARGET_PORTALW[1] Portals;
}

struct ISCSI_TARGET_PORTAL_GROUPA
{
    uint Count;
    ISCSI_TARGET_PORTALA[1] Portals;
}

struct ISCSI_CONNECTION_INFOW
{
    ISCSI_UNIQUE_SESSION_ID ConnectionId;
    const(wchar)* InitiatorAddress;
    const(wchar)* TargetAddress;
    ushort        InitiatorSocket;
    ushort        TargetSocket;
    ubyte[2]      CID;
}

struct ISCSI_SESSION_INFOW
{
    ISCSI_UNIQUE_SESSION_ID SessionId;
    const(wchar)* InitiatorName;
    const(wchar)* TargetNodeName;
    const(wchar)* TargetName;
    ubyte[6]      ISID;
    ubyte[2]      TSID;
    uint          ConnectionCount;
    ISCSI_CONNECTION_INFOW* Connections;
}

struct ISCSI_CONNECTION_INFOA
{
    ISCSI_UNIQUE_SESSION_ID ConnectionId;
    const(char)* InitiatorAddress;
    const(char)* TargetAddress;
    ushort       InitiatorSocket;
    ushort       TargetSocket;
    ubyte[2]     CID;
}

struct ISCSI_SESSION_INFOA
{
    ISCSI_UNIQUE_SESSION_ID SessionId;
    const(char)* InitiatorName;
    const(char)* TargetNodeName;
    const(char)* TargetName;
    ubyte[6]     ISID;
    ubyte[2]     TSID;
    uint         ConnectionCount;
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
    ubyte InitialR2t;
    ubyte ImmediateData;
    ubyte Type;
    ubyte DataSequenceInOrder;
    ubyte DataPduInOrder;
    ubyte ErrorRecoveryLevel;
    uint  MaxOutstandingR2t;
    uint  FirstBurstLength;
    uint  MaxBurstLength;
    uint  MaximumConnections;
    uint  ConnectionCount;
    ISCSI_CONNECTION_INFO_EX* Connections;
}

struct ISCSI_DEVICE_ON_SESSIONW
{
    ushort[256]  InitiatorName;
    ushort[224]  TargetName;
    SCSI_ADDRESS ScsiAddress;
    GUID         DeviceInterfaceType;
    ushort[260]  DeviceInterfaceName;
    ushort[260]  LegacyName;
    STORAGE_DEVICE_NUMBER StorageDeviceNumber;
    uint         DeviceInstance;
}

struct ISCSI_DEVICE_ON_SESSIONA
{
    byte[256]    InitiatorName;
    byte[224]    TargetName;
    SCSI_ADDRESS ScsiAddress;
    GUID         DeviceInterfaceType;
    byte[260]    DeviceInterfaceName;
    byte[260]    LegacyName;
    STORAGE_DEVICE_NUMBER StorageDeviceNumber;
    uint         DeviceInstance;
}

struct PERSISTENT_ISCSI_LOGIN_INFOW
{
    ushort[224]          TargetName;
    ubyte                IsInformationalSession;
    ushort[256]          InitiatorInstance;
    uint                 InitiatorPortNumber;
    ISCSI_TARGET_PORTALW TargetPortal;
    ulong                SecurityFlags;
    ISCSI_TARGET_MAPPINGW* Mappings;
    ISCSI_LOGIN_OPTIONS  LoginOptions;
}

struct PERSISTENT_ISCSI_LOGIN_INFOA
{
    byte[224]            TargetName;
    ubyte                IsInformationalSession;
    byte[256]            InitiatorInstance;
    uint                 InitiatorPortNumber;
    ISCSI_TARGET_PORTALA TargetPortal;
    ulong                SecurityFlags;
    ISCSI_TARGET_MAPPINGA* Mappings;
    ISCSI_LOGIN_OPTIONS  LoginOptions;
}

struct ISCSI_VERSION_INFO
{
    uint MajorVersion;
    uint MinorVersion;
    uint BuildNumber;
}

// Functions

@DllImport("ISCSIDSC")
uint GetIScsiVersionInformation(ISCSI_VERSION_INFO* VersionInfo);

@DllImport("ISCSIDSC")
uint GetIScsiTargetInformationW(const(wchar)* TargetName, const(wchar)* DiscoveryMechanism, 
                                TARGET_INFORMATION_CLASS InfoClass, uint* BufferSize, void* Buffer);

@DllImport("ISCSIDSC")
uint GetIScsiTargetInformationA(const(char)* TargetName, const(char)* DiscoveryMechanism, 
                                TARGET_INFORMATION_CLASS InfoClass, uint* BufferSize, void* Buffer);

@DllImport("ISCSIDSC")
uint AddIScsiConnectionW(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, void* Reserved, uint InitiatorPortNumber, 
                         ISCSI_TARGET_PORTALW* TargetPortal, ulong SecurityFlags, ISCSI_LOGIN_OPTIONS* LoginOptions, 
                         uint KeySize, const(char)* Key, ISCSI_UNIQUE_SESSION_ID* ConnectionId);

@DllImport("ISCSIDSC")
uint AddIScsiConnectionA(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, void* Reserved, uint InitiatorPortNumber, 
                         ISCSI_TARGET_PORTALA* TargetPortal, ulong SecurityFlags, ISCSI_LOGIN_OPTIONS* LoginOptions, 
                         uint KeySize, const(char)* Key, ISCSI_UNIQUE_SESSION_ID* ConnectionId);

@DllImport("ISCSIDSC")
uint RemoveIScsiConnection(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, ISCSI_UNIQUE_SESSION_ID* ConnectionId);

@DllImport("ISCSIDSC")
uint ReportIScsiTargetsW(ubyte ForceUpdate, uint* BufferSize, const(wchar)* Buffer);

@DllImport("ISCSIDSC")
uint ReportIScsiTargetsA(ubyte ForceUpdate, uint* BufferSize, const(char)* Buffer);

@DllImport("ISCSIDSC")
uint AddIScsiStaticTargetW(const(wchar)* TargetName, const(wchar)* TargetAlias, uint TargetFlags, ubyte Persist, 
                           ISCSI_TARGET_MAPPINGW* Mappings, ISCSI_LOGIN_OPTIONS* LoginOptions, 
                           ISCSI_TARGET_PORTAL_GROUPW* PortalGroup);

@DllImport("ISCSIDSC")
uint AddIScsiStaticTargetA(const(char)* TargetName, const(char)* TargetAlias, uint TargetFlags, ubyte Persist, 
                           ISCSI_TARGET_MAPPINGA* Mappings, ISCSI_LOGIN_OPTIONS* LoginOptions, 
                           ISCSI_TARGET_PORTAL_GROUPA* PortalGroup);

@DllImport("ISCSIDSC")
uint RemoveIScsiStaticTargetW(const(wchar)* TargetName);

@DllImport("ISCSIDSC")
uint RemoveIScsiStaticTargetA(const(char)* TargetName);

@DllImport("ISCSIDSC")
uint AddIScsiSendTargetPortalW(const(wchar)* InitiatorInstance, uint InitiatorPortNumber, 
                               ISCSI_LOGIN_OPTIONS* LoginOptions, ulong SecurityFlags, ISCSI_TARGET_PORTALW* Portal);

@DllImport("ISCSIDSC")
uint AddIScsiSendTargetPortalA(const(char)* InitiatorInstance, uint InitiatorPortNumber, 
                               ISCSI_LOGIN_OPTIONS* LoginOptions, ulong SecurityFlags, ISCSI_TARGET_PORTALA* Portal);

@DllImport("ISCSIDSC")
uint RemoveIScsiSendTargetPortalW(const(wchar)* InitiatorInstance, uint InitiatorPortNumber, 
                                  ISCSI_TARGET_PORTALW* Portal);

@DllImport("ISCSIDSC")
uint RemoveIScsiSendTargetPortalA(const(char)* InitiatorInstance, uint InitiatorPortNumber, 
                                  ISCSI_TARGET_PORTALA* Portal);

@DllImport("ISCSIDSC")
uint RefreshIScsiSendTargetPortalW(const(wchar)* InitiatorInstance, uint InitiatorPortNumber, 
                                   ISCSI_TARGET_PORTALW* Portal);

@DllImport("ISCSIDSC")
uint RefreshIScsiSendTargetPortalA(const(char)* InitiatorInstance, uint InitiatorPortNumber, 
                                   ISCSI_TARGET_PORTALA* Portal);

@DllImport("ISCSIDSC")
uint ReportIScsiSendTargetPortalsW(uint* PortalCount, ISCSI_TARGET_PORTAL_INFOW* PortalInfo);

@DllImport("ISCSIDSC")
uint ReportIScsiSendTargetPortalsA(uint* PortalCount, ISCSI_TARGET_PORTAL_INFOA* PortalInfo);

@DllImport("ISCSIDSC")
uint ReportIScsiSendTargetPortalsExW(uint* PortalCount, uint* PortalInfoSize, 
                                     ISCSI_TARGET_PORTAL_INFO_EXW* PortalInfo);

@DllImport("ISCSIDSC")
uint ReportIScsiSendTargetPortalsExA(uint* PortalCount, uint* PortalInfoSize, 
                                     ISCSI_TARGET_PORTAL_INFO_EXA* PortalInfo);

@DllImport("ISCSIDSC")
uint LoginIScsiTargetW(const(wchar)* TargetName, ubyte IsInformationalSession, const(wchar)* InitiatorInstance, 
                       uint InitiatorPortNumber, ISCSI_TARGET_PORTALW* TargetPortal, ulong SecurityFlags, 
                       ISCSI_TARGET_MAPPINGW* Mappings, ISCSI_LOGIN_OPTIONS* LoginOptions, uint KeySize, 
                       const(char)* Key, ubyte IsPersistent, ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, 
                       ISCSI_UNIQUE_SESSION_ID* UniqueConnectionId);

@DllImport("ISCSIDSC")
uint LoginIScsiTargetA(const(char)* TargetName, ubyte IsInformationalSession, const(char)* InitiatorInstance, 
                       uint InitiatorPortNumber, ISCSI_TARGET_PORTALA* TargetPortal, ulong SecurityFlags, 
                       ISCSI_TARGET_MAPPINGA* Mappings, ISCSI_LOGIN_OPTIONS* LoginOptions, uint KeySize, 
                       const(char)* Key, ubyte IsPersistent, ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, 
                       ISCSI_UNIQUE_SESSION_ID* UniqueConnectionId);

@DllImport("ISCSIDSC")
uint ReportIScsiPersistentLoginsW(uint* Count, PERSISTENT_ISCSI_LOGIN_INFOW* PersistentLoginInfo, 
                                  uint* BufferSizeInBytes);

@DllImport("ISCSIDSC")
uint ReportIScsiPersistentLoginsA(uint* Count, PERSISTENT_ISCSI_LOGIN_INFOA* PersistentLoginInfo, 
                                  uint* BufferSizeInBytes);

@DllImport("ISCSIDSC")
uint LogoutIScsiTarget(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId);

@DllImport("ISCSIDSC")
uint RemoveIScsiPersistentTargetW(const(wchar)* InitiatorInstance, uint InitiatorPortNumber, 
                                  const(wchar)* TargetName, ISCSI_TARGET_PORTALW* Portal);

@DllImport("ISCSIDSC")
uint RemoveIScsiPersistentTargetA(const(char)* InitiatorInstance, uint InitiatorPortNumber, 
                                  const(char)* TargetName, ISCSI_TARGET_PORTALA* Portal);

@DllImport("ISCSIDSC")
uint SendScsiInquiry(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, ulong Lun, ubyte EvpdCmddt, ubyte PageCode, 
                     ubyte* ScsiStatus, uint* ResponseSize, ubyte* ResponseBuffer, uint* SenseSize, 
                     ubyte* SenseBuffer);

@DllImport("ISCSIDSC")
uint SendScsiReadCapacity(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, ulong Lun, ubyte* ScsiStatus, 
                          uint* ResponseSize, ubyte* ResponseBuffer, uint* SenseSize, ubyte* SenseBuffer);

@DllImport("ISCSIDSC")
uint SendScsiReportLuns(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, ubyte* ScsiStatus, uint* ResponseSize, 
                        ubyte* ResponseBuffer, uint* SenseSize, ubyte* SenseBuffer);

@DllImport("ISCSIDSC")
uint ReportIScsiInitiatorListW(uint* BufferSize, const(wchar)* Buffer);

@DllImport("ISCSIDSC")
uint ReportIScsiInitiatorListA(uint* BufferSize, const(char)* Buffer);

@DllImport("ISCSIDSC")
uint ReportActiveIScsiTargetMappingsW(uint* BufferSize, uint* MappingCount, ISCSI_TARGET_MAPPINGW* Mappings);

@DllImport("ISCSIDSC")
uint ReportActiveIScsiTargetMappingsA(uint* BufferSize, uint* MappingCount, ISCSI_TARGET_MAPPINGA* Mappings);

@DllImport("ISCSIDSC")
uint SetIScsiTunnelModeOuterAddressW(const(wchar)* InitiatorName, uint InitiatorPortNumber, 
                                     const(wchar)* DestinationAddress, const(wchar)* OuterModeAddress, ubyte Persist);

@DllImport("ISCSIDSC")
uint SetIScsiTunnelModeOuterAddressA(const(char)* InitiatorName, uint InitiatorPortNumber, 
                                     const(char)* DestinationAddress, const(char)* OuterModeAddress, ubyte Persist);

@DllImport("ISCSIDSC")
uint SetIScsiIKEInfoW(const(wchar)* InitiatorName, uint InitiatorPortNumber, 
                      IKE_AUTHENTICATION_INFORMATION* AuthInfo, ubyte Persist);

@DllImport("ISCSIDSC")
uint SetIScsiIKEInfoA(const(char)* InitiatorName, uint InitiatorPortNumber, 
                      IKE_AUTHENTICATION_INFORMATION* AuthInfo, ubyte Persist);

@DllImport("ISCSIDSC")
uint GetIScsiIKEInfoW(const(wchar)* InitiatorName, uint InitiatorPortNumber, uint* Reserved, 
                      IKE_AUTHENTICATION_INFORMATION* AuthInfo);

@DllImport("ISCSIDSC")
uint GetIScsiIKEInfoA(const(char)* InitiatorName, uint InitiatorPortNumber, uint* Reserved, 
                      IKE_AUTHENTICATION_INFORMATION* AuthInfo);

@DllImport("ISCSIDSC")
uint SetIScsiGroupPresharedKey(uint KeyLength, ubyte* Key, ubyte Persist);

@DllImport("ISCSIDSC")
uint SetIScsiInitiatorCHAPSharedSecret(uint SharedSecretLength, ubyte* SharedSecret);

@DllImport("ISCSIDSC")
uint SetIScsiInitiatorRADIUSSharedSecret(uint SharedSecretLength, ubyte* SharedSecret);

@DllImport("ISCSIDSC")
uint SetIScsiInitiatorNodeNameW(const(wchar)* InitiatorNodeName);

@DllImport("ISCSIDSC")
uint SetIScsiInitiatorNodeNameA(const(char)* InitiatorNodeName);

@DllImport("ISCSIDSC")
uint GetIScsiInitiatorNodeNameW(const(wchar)* InitiatorNodeName);

@DllImport("ISCSIDSC")
uint GetIScsiInitiatorNodeNameA(const(char)* InitiatorNodeName);

@DllImport("ISCSIDSC")
uint AddISNSServerW(const(wchar)* Address);

@DllImport("ISCSIDSC")
uint AddISNSServerA(const(char)* Address);

@DllImport("ISCSIDSC")
uint RemoveISNSServerW(const(wchar)* Address);

@DllImport("ISCSIDSC")
uint RemoveISNSServerA(const(char)* Address);

@DllImport("ISCSIDSC")
uint RefreshISNSServerW(const(wchar)* Address);

@DllImport("ISCSIDSC")
uint RefreshISNSServerA(const(char)* Address);

@DllImport("ISCSIDSC")
uint ReportISNSServerListW(uint* BufferSizeInChar, const(wchar)* Buffer);

@DllImport("ISCSIDSC")
uint ReportISNSServerListA(uint* BufferSizeInChar, const(char)* Buffer);

@DllImport("ISCSIDSC")
uint GetIScsiSessionListW(uint* BufferSize, uint* SessionCount, ISCSI_SESSION_INFOW* SessionInfo);

@DllImport("ISCSIDSC")
uint GetIScsiSessionListA(uint* BufferSize, uint* SessionCount, ISCSI_SESSION_INFOA* SessionInfo);

@DllImport("ISCSIDSC")
uint GetIScsiSessionListEx(uint* BufferSize, uint* SessionCountPtr, ISCSI_SESSION_INFO_EX* SessionInfo);

@DllImport("ISCSIDSC")
uint GetDevicesForIScsiSessionW(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, uint* DeviceCount, 
                                ISCSI_DEVICE_ON_SESSIONW* Devices);

@DllImport("ISCSIDSC")
uint GetDevicesForIScsiSessionA(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, uint* DeviceCount, 
                                ISCSI_DEVICE_ON_SESSIONA* Devices);

@DllImport("ISCSIDSC")
uint SetupPersistentIScsiVolumes();

@DllImport("ISCSIDSC")
uint SetupPersistentIScsiDevices();

@DllImport("ISCSIDSC")
uint AddPersistentIScsiDeviceW(const(wchar)* DevicePath);

@DllImport("ISCSIDSC")
uint AddPersistentIScsiDeviceA(const(char)* DevicePath);

@DllImport("ISCSIDSC")
uint RemovePersistentIScsiDeviceW(const(wchar)* DevicePath);

@DllImport("ISCSIDSC")
uint RemovePersistentIScsiDeviceA(const(char)* DevicePath);

@DllImport("ISCSIDSC")
uint ClearPersistentIScsiDevices();

@DllImport("ISCSIDSC")
uint ReportPersistentIScsiDevicesW(uint* BufferSizeInChar, const(wchar)* Buffer);

@DllImport("ISCSIDSC")
uint ReportPersistentIScsiDevicesA(uint* BufferSizeInChar, const(char)* Buffer);

@DllImport("ISCSIDSC")
uint ReportIScsiTargetPortalsW(const(wchar)* InitiatorName, const(wchar)* TargetName, ushort* TargetPortalTag, 
                               uint* ElementCount, ISCSI_TARGET_PORTALW* Portals);

@DllImport("ISCSIDSC")
uint ReportIScsiTargetPortalsA(const(char)* InitiatorName, const(char)* TargetName, ushort* TargetPortalTag, 
                               uint* ElementCount, ISCSI_TARGET_PORTALA* Portals);

@DllImport("ISCSIDSC")
uint AddRadiusServerW(const(wchar)* Address);

@DllImport("ISCSIDSC")
uint AddRadiusServerA(const(char)* Address);

@DllImport("ISCSIDSC")
uint RemoveRadiusServerW(const(wchar)* Address);

@DllImport("ISCSIDSC")
uint RemoveRadiusServerA(const(char)* Address);

@DllImport("ISCSIDSC")
uint ReportRadiusServerListW(uint* BufferSizeInChar, const(wchar)* Buffer);

@DllImport("ISCSIDSC")
uint ReportRadiusServerListA(uint* BufferSizeInChar, const(char)* Buffer);


