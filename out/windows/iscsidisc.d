// Written in the D programming language.

module windows.iscsidisc;

public import windows.core;
public import windows.systemservices : LARGE_INTEGER, STORAGE_DEVICE_NUMBER;

extern(Windows):


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

///The <b>ISCSI_DIGEST_TYPES</b> enumeration indicates the digest type.
alias ISCSI_DIGEST_TYPES = int;
enum : int
{
    ///No digest is in use for guaranteeing data integrity.
    ISCSI_DIGEST_TYPE_NONE   = 0x00000000,
    ISCSI_DIGEST_TYPE_CRC32C = 0x00000001,
}

///The <b>ISCSI_AUTH_TYPES</b> enumeration indicates the type of authentication method utilized.
alias ISCSI_AUTH_TYPES = int;
enum : int
{
    ///No authentication type was specified.
    ISCSI_NO_AUTH_TYPE          = 0x00000000,
    ///Challenge Handshake Authentication Protocol (CHAP) authentication.
    ISCSI_CHAP_AUTH_TYPE        = 0x00000001,
    ///Mutual (2-way) CHAP authentication.
    ISCSI_MUTUAL_CHAP_AUTH_TYPE = 0x00000002,
}

///The <b>IKE_AUTHENTICATION_METHOD</b> enumeration indicates the type of Internet Key Exchange (IKE) authentication
///method.
alias IKE_AUTHENTICATION_METHOD = int;
enum : int
{
    ///The authentication method was preshared.
    IKE_AUTHENTICATION_PRESHARED_KEY_METHOD = 0x00000001,
}

///The <b>TARGETPROTOCOLTYPE</b> enumeration indicates the type of protocol that the initiator must use to communicate
///with the target.
alias TARGETPROTOCOLTYPE = int;
enum : int
{
    ///The target uses the TCP protocol.
    ISCSI_TCP_PROTOCOL_TYPE = 0x00000000,
}

///The <b>TARGET_INFORMATION_CLASS</b> enumeration specifies information about the indicated target device that the
///GetIScsiTargetInformation function retrieves.
alias TARGET_INFORMATION_CLASS = int;
enum : int
{
    ///A value of the TARGETPROTOCOLTYPE structure, indicating the protocol that the initiator uses to communicate with
    ///the target device.
    ProtocolType             = 0x00000000,
    ///A <b>null</b>-terminated string that contains the alias of the target device.
    TargetAlias              = 0x00000001,
    ///A list of <b>null</b>-terminated strings that describe the discovery mechanisms that located the indicated
    ///target. The list is terminated by a double <b>null</b>.
    DiscoveryMechanisms      = 0x00000002,
    ///A ISCSI_TARGET_PORTAL_GROUP structure that contains descriptions of the portals in the portal group associated
    ///with the target.
    PortalGroups             = 0x00000003,
    ///An array of ISCSI_TARGET_MAPPING structures that contains information about the HBAs and buses through which the
    ///target can be reached. The array is preceded by a <b>ULONG</b> value that contains the number of elements in the
    ///array. Each <b>ISCSI_TARGET_MAPPING</b> structure is aligned on a 4-byte boundary.
    PersistentTargetMappings = 0x00000004,
    ///A <b>null</b>-terminated string that contains the initiator HBA that connects to the target.
    InitiatorName            = 0x00000005,
    ///The flags associated with the target. The following table lists the flags that can be associated with a target.
    ///<table> <tr> <th>Target Flag</th> <th>Meaning</th> </tr> <tr> <td>ISCSI_TARGET_FLAG_HIDE_STATIC_TARGET</td>
    ///<td>The target will not be reported as discovered unless it is also discovered dynamically.</td> </tr> </table>
    TargetFlags              = 0x00000006,
    ///A value of the ISCSI_LOGIN_OPTIONS structure that defines the login data.
    LoginOptions             = 0x00000007,
}

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

///The <b>ISCSI_LOGIN_OPTIONS</b> structure is used by initiators to specify the characteristics of a login session.
struct ISCSI_LOGIN_OPTIONS
{
    ///The version of login option definitions that define the data in the structure. This member must be set to
    ///ISCSI_LOGIN_OPTIONS_VERSION 0.
    uint               Version;
    ///A bitmap that indicates which parts of the <b>ISCSI_LOGIN_OPTIONS</b> structure contain valid data. <table> <tr>
    ///<th>Bit</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="ISCSI_LOGIN_OPTIONS_USERNAME"></a><a
    ///id="iscsi_login_options_username"></a><dl> <dt><b>ISCSI_LOGIN_OPTIONS_USERNAME</b></dt> </dl> </td> <td
    ///width="60%"> Specifies a user name to use in making a login connection. </td> </tr> <tr> <td width="40%"><a
    ///id="ISCSI_LOGIN_OPTIONS_PASSWORD"></a><a id="iscsi_login_options_password"></a><dl>
    ///<dt><b>ISCSI_LOGIN_OPTIONS_PASSWORD</b></dt> </dl> </td> <td width="60%"> Specifies a password to use in making a
    ///login connection. </td> </tr> <tr> <td width="40%"><a id="ISCSI_LOGIN_OPTIONS_HEADER_DIGEST"></a><a
    ///id="iscsi_login_options_header_digest"></a><dl> <dt><b>ISCSI_LOGIN_OPTIONS_HEADER_DIGEST</b></dt> </dl> </td> <td
    ///width="60%"> Specifies the type of digest in use for guaranteeing the integrity of header data. </td> </tr> <tr>
    ///<td width="40%"><a id="ISCSI_LOGIN_OPTIONS_DATA_DIGEST"></a><a id="iscsi_login_options_data_digest"></a><dl>
    ///<dt><b>ISCSI_LOGIN_OPTIONS_DATA_DIGEST</b></dt> </dl> </td> <td width="60%"> Specifies the type of digest in use
    ///for guaranteeing the integrity of header data. </td> </tr> <tr> <td width="40%"><a
    ///id="ISCSI_LOGIN_OPTIONS_MAXIMUM_CONNECTIONS"></a><a id="iscsi_login_options_maximum_connections"></a><dl>
    ///<dt><b>ISCSI_LOGIN_OPTIONS_MAXIMUM_CONNECTIONS</b></dt> </dl> </td> <td width="60%"> Specifies the maximum number
    ///of connections to target devices associated with the login session. </td> </tr> <tr> <td width="40%"><a
    ///id="ISCSI_LOGIN_OPTIONS_DEFAULT_TIME_2_WAIT"></a><a id="iscsi_login_options_default_time_2_wait"></a><dl>
    ///<dt><b>ISCSI_LOGIN_OPTIONS_DEFAULT_TIME_2_WAIT</b></dt> </dl> </td> <td width="60%"> Specifies the minimum time
    ///to wait, in seconds, before attempting to reconnect or reassign a connection that was dropped. </td> </tr> <tr>
    ///<td width="40%"><a id="ISCSI_LOGIN_OPTIONS_DEFAULT_TIME_2_RETAIN"></a><a
    ///id="iscsi_login_options_default_time_2_retain"></a><dl> <dt><b>ISCSI_LOGIN_OPTIONS_DEFAULT_TIME_2_RETAIN</b></dt>
    ///</dl> </td> <td width="60%"> Specifies the maximum time allowed to reassign commands after the initial wait
    ///indicated in <b>DefaultTime2Wait</b>. </td> </tr> <tr> <td width="40%"><a
    ///id="ISCSI_LOGIN_OPTIONS_AUTH_TYPE"></a><a id="iscsi_login_options_auth_type"></a><dl>
    ///<dt><b>ISCSI_LOGIN_OPTIONS_AUTH_TYPE</b></dt> </dl> </td> <td width="60%"> Specifies the type of authentication
    ///that establishes the login session. </td> </tr> </table>
    uint               InformationSpecified;
    ///A bitwise OR of login flags that define certain characteristics of the login session. The following table
    ///indicates the values that can be assigned to this member: <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="ISCSI_LOGIN_FLAG_RESERVED1"></a><a id="iscsi_login_flag_reserved1"></a><dl>
    ///<dt><b>ISCSI_LOGIN_FLAG_RESERVED1</b></dt> </dl> </td> <td width="60%"> Reserved for internal use. </td> </tr>
    ///<tr> <td width="40%"><a id="ISCSI_LOGIN_FLAG_ALLOW_PORTAL_HOPPING"></a><a
    ///id="iscsi_login_flag_allow_portal_hopping"></a><dl> <dt><b>ISCSI_LOGIN_FLAG_ALLOW_PORTAL_HOPPING</b></dt> </dl>
    ///</td> <td width="60%"> The RADIUS server is permitted to use the portal hopping function for a target if
    ///configured to do so. </td> </tr> <tr> <td width="40%"><a id="ISCSI_LOGIN_FLAG_REQUIRE_IPSEC"></a><a
    ///id="iscsi_login_flag_require_ipsec"></a><dl> <dt><b>ISCSI_LOGIN_FLAG_REQUIRE_IPSEC</b></dt> </dl> </td> <td
    ///width="60%"> The login session must use the IPsec protocol. </td> </tr> <tr> <td width="40%"><a
    ///id="ISCSI_LOGIN_FLAG_MULTIPATH_ENABLED"></a><a id="iscsi_login_flag_multipath_enabled"></a><dl>
    ///<dt><b>ISCSI_LOGIN_FLAG_MULTIPATH_ENABLED</b></dt> </dl> </td> <td width="60%"> Multipathing is allowed. When
    ///specified the iSCSI Initiator service will allow multiple sessions to the same target. If there are multiple
    ///sessions to the same target then there must be some sort of multipathing software installed otherwise data
    ///corruption will occur on the target. </td> </tr> </table>
    uint               LoginFlags;
    ///An enumerator value of type ISCSI_AUTH_TYPES that indicates the authentication type.
    ISCSI_AUTH_TYPES   AuthType;
    ///An enumerator value of type ISCSI_DIGEST_TYPES that indicates the type of digest for guaranteeing the integrity
    ///of header data.
    ISCSI_DIGEST_TYPES HeaderDigest;
    ///An enumerator value of type ISCSI_DIGEST_TYPES that indicates the type of digest for guaranteeing the integrity
    ///of non-header data.
    ISCSI_DIGEST_TYPES DataDigest;
    ///A value between 1 and 65535 that specifies the maximum number of connections to the target device that can be
    ///associated with the login session.
    uint               MaximumConnections;
    ///The minimum time to wait, in seconds, before attempting to reconnect or reassign a connection that has been
    ///dropped.
    uint               DefaultTime2Wait;
    ///The maximum time allowed to reassign a connection after the initial wait indicated in <b>DefaultTime2Wait</b> has
    ///elapsed.
    uint               DefaultTime2Retain;
    ///The length, in bytes, of the user name specified in the <b>Username</b> member.
    uint               UsernameLength;
    ///The length, in bytes, of the user name specified in the <b>Password</b> member.
    uint               PasswordLength;
    ///The user name to authenticate to establish the login session. This value is not necessarily a string. For more
    ///information, see the Remarks section in this document.
    ubyte*             Username;
    ///The user name to authenticate to establish the login session. This value is not necessarily a string. For more
    ///information, see the Remarks section in this document.
    ubyte*             Password;
}

///The <b>IKE_AUTHENTICATION_PRESHARED_KEY</b> structure contains information about the preshared key used in the
///Internet Key Exchange (IKE) protocol.
struct IKE_AUTHENTICATION_PRESHARED_KEY
{
    ///A bitmap that defines the security characteristics of a login connection. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED"></a><a
    ///id="iscsi_security_flag_tunnel_mode_preferred"></a><dl> <dt><b>ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED</b></dt>
    ///</dl> </td> <td width="60%"> The Host Bus Adapter (HBA) initiator should establish the TCP/IP connection to the
    ///target portal using IPsec tunnel mode. </td> </tr> <tr> <td width="40%"><a
    ///id="ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED"></a><a
    ///id="iscsi_security_flag_transport_mode_preferred"></a><dl>
    ///<dt><b>ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED</b></dt> </dl> </td> <td width="60%"> The HBA initiator
    ///should establish the TCP/IP connection to the target portal using IPsec transport mode. </td> </tr> <tr> <td
    ///width="40%"><a id="ISCSI_SECURITY_FLAG_PFS_ENABLED"></a><a id="iscsi_security_flag_pfs_enabled"></a><dl>
    ///<dt><b>ISCSI_SECURITY_FLAG_PFS_ENABLED</b></dt> </dl> </td> <td width="60%"> The HBA initiator should establish
    ///the TCP/IP connection to the target portal with Perfect Forward Secrecy (PFS) mode enabled if IPsec is required.
    ///</td> </tr> <tr> <td width="40%"><a id="ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED"></a><a
    ///id="iscsi_security_flag_aggressive_mode_enabled"></a><dl>
    ///<dt><b>ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED</b></dt> </dl> </td> <td width="60%"> The HBA initiator should
    ///establish the TCP/IP connection to the target portal with aggressive mode enabled. </td> </tr> <tr> <td
    ///width="40%"><a id="ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED"></a><a
    ///id="iscsi_security_flag_main_mode_enabled"></a><dl> <dt><b>ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED</b></dt> </dl>
    ///</td> <td width="60%"> The HBA initiator should establish the TCP/IP connection to the target portal with main
    ///mode enabled. </td> </tr> <tr> <td width="40%"><a id="ISCSI_SECURITY_FLAG_IKE_IPSEC_ENABLED"></a><a
    ///id="iscsi_security_flag_ike_ipsec_enabled"></a><dl> <dt><b>ISCSI_SECURITY_FLAG_IKE_IPSEC_ENABLED</b></dt> </dl>
    ///</td> <td width="60%"> The HBA initiator should establish the TCP/IP connection to the target portal using
    ///IKE/IPsec protocol. If not set then IPsec is not required to login to the target. </td> </tr> <tr> <td
    ///width="40%"><a id="ISCSI_SECURITY_FLAG_VALID"></a><a id="iscsi_security_flag_valid"></a><dl>
    ///<dt><b>ISCSI_SECURITY_FLAG_VALID</b></dt> </dl> </td> <td width="60%"> The other mask values are valid;
    ///otherwise, security flags are not specified. </td> </tr> </table>
    ulong  SecurityFlags;
    ///The type of key identifier. The following table specifies the values that can be assigned to this member: <table>
    ///<tr> <th>ID Types</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="ID_IPV4_ADDR"></a><a
    ///id="id_ipv4_addr"></a><dl> <dt><b>ID_IPV4_ADDR</b></dt> </dl> </td> <td width="60%"> Indicates four bytes of
    ///binary data that constitute a version 4 IP address. </td> </tr> <tr> <td width="40%"><a id="ID_FQDN"></a><a
    ///id="id_fqdn"></a><dl> <dt><b>ID_FQDN</b></dt> </dl> </td> <td width="60%"> An ANSI string that contains a fully
    ///qualified domain name. This string does not contain terminators. </td> </tr> <tr> <td width="40%"><a
    ///id="ID_USER_FQDN"></a><a id="id_user_fqdn"></a><dl> <dt><b>ID_USER_FQDN</b></dt> </dl> </td> <td width="60%"> An
    ///ANSI string that contains a fully qualified user name. This string does not contain terminators. </td> </tr> <tr>
    ///<td width="40%"><a id="ID_IPV6_ADDR"></a><a id="id_ipv6_addr"></a><dl> <dt><b>ID_IPV6_ADDR</b></dt> </dl> </td>
    ///<td width="60%"> Indicates 16 bytes of binary data that constitute a version 6 IP address. </td> </tr> </table>
    ubyte  IdType;
    ///The length, in bytes, of the key identifier.
    uint   IdLengthInBytes;
    ///The identifier of the preshared key used in the IKE protocol.
    ubyte* Id;
    ///The length, in bytes, of the preshared key.
    uint   KeyLengthInBytes;
    ubyte* Key;
}

///The <b>IKE_AUTHENTICATION_INFORMATION</b> structure contains Internet Key Exchange (IKE) authentication information
///used to establish a secure channel between two key management daemons.
struct IKE_AUTHENTICATION_INFORMATION
{
    ///A IKE_AUTHENTICATION_METHOD structure that indicates the authentication method.
    IKE_AUTHENTICATION_METHOD AuthMethod;
    union
    {
        IKE_AUTHENTICATION_PRESHARED_KEY PsKey;
    }
}

///The <b>ISCSI_UNIQUE_SESSION_ID</b> structure is an opaque entity that contains data that uniquely identifies a
///session.
struct ISCSI_UNIQUE_SESSION_ID
{
    ulong AdapterUnique;
    ulong AdapterSpecific;
}

///The <b>SCSI_LUN_LIST</b> structure is used to construct a list of logical unit numbers (LUNs) associated with target
///devices.
struct SCSI_LUN_LIST
{
    ///The LUN assigned by the operating system to the target device when it was enumerated by the initiator Host Bus
    ///Adapter (HBA).
    uint  OSLUN;
    ///The LUN assigned by the target subsystem to the target device.
    ulong TargetLUN;
}

///The ISCSI_TARGET_MAPPING structure contains information about a target and the Host-Bus Adapters (HBAs) and buses
///through which the target is reached.
struct ISCSI_TARGET_MAPPINGW
{
    ///A string representing the name of the HBA initiator through which the target is accessed.
    ushort[256]    InitiatorName;
    ///A string representing the target name.
    ushort[224]    TargetName;
    ///A string representing the device name of the HBA initiator; for example '<b>\device\ScsiPort3</b>'.
    ushort[260]    OSDeviceName;
    ///A ISCSI_UNIQUE_SESSION_ID structure containing information that uniquely identifies the session..
    ISCSI_UNIQUE_SESSION_ID SessionId;
    ///The bus number used by the initiator as the local SCSI address of the target.
    uint           OSBusNumber;
    ///The target number used by the initiator as the local SCSI address of the target.
    uint           OSTargetNumber;
    ///The number of logical units (LUN) on the target.
    uint           LUNCount;
    ///A list of SCSI_LUN_LIST structures that contain information about the LUNs associated with the target.
    SCSI_LUN_LIST* LUNList;
}

///The ISCSI_TARGET_MAPPING structure contains information about a target and the Host-Bus Adapters (HBAs) and buses
///through which the target is reached.
struct ISCSI_TARGET_MAPPINGA
{
    ///A string representing the name of the HBA initiator through which the target is accessed.
    byte[256]      InitiatorName;
    ///A string representing the target name.
    byte[224]      TargetName;
    ///A string representing the device name of the HBA initiator; for example '<b>\device\ScsiPort3</b>'.
    byte[260]      OSDeviceName;
    ///A ISCSI_UNIQUE_SESSION_ID structure containing information that uniquely identifies the session..
    ISCSI_UNIQUE_SESSION_ID SessionId;
    ///The bus number used by the initiator as the local SCSI address of the target.
    uint           OSBusNumber;
    ///The target number used by the initiator as the local SCSI address of the target.
    uint           OSTargetNumber;
    ///The number of logical units (LUN) on the target.
    uint           LUNCount;
    ///A list of SCSI_LUN_LIST structures that contain information about the LUNs associated with the target.
    SCSI_LUN_LIST* LUNList;
}

///The <b>ISCSI_TARGET_PORTAL</b> structure contains information about a portal.
struct ISCSI_TARGET_PORTALW
{
    ///A string representing the name of the portal.
    ushort[256] SymbolicName;
    ///A string representing the IP address or DNS name of the portal.
    ushort[256] Address;
    ///The socket number of the portal.
    ushort      Socket;
}

///The <b>ISCSI_TARGET_PORTAL</b> structure contains information about a portal.
struct ISCSI_TARGET_PORTALA
{
    ///A string representing the name of the portal.
    byte[256] SymbolicName;
    ///A string representing the IP address or DNS name of the portal.
    byte[256] Address;
    ///The socket number of the portal.
    ushort    Socket;
}

///The <b>ISCSI_TARGET_PORTAL_INFO</b> structure contains information about a target portal.
struct ISCSI_TARGET_PORTAL_INFOW
{
    ///A string representing the name of the Host-Bus Adapter initiator.
    ushort[256] InitiatorName;
    ///The port number on the Host-Bus Adapter (HBA) associated with the portal. This port number corresponds to the
    ///source IP address on the HBA
    uint        InitiatorPortNumber;
    ///A string representing the symbolic name of the portal.
    ushort[256] SymbolicName;
    ///A string representing the IP address or DNS name of the portal.
    ushort[256] Address;
    ///The socket number.
    ushort      Socket;
}

///The <b>ISCSI_TARGET_PORTAL_INFO</b> structure contains information about a target portal.
struct ISCSI_TARGET_PORTAL_INFOA
{
    ///A string representing the name of the Host-Bus Adapter initiator.
    byte[256] InitiatorName;
    ///The port number on the Host-Bus Adapter (HBA) associated with the portal. This port number corresponds to the
    ///source IP address on the HBA
    uint      InitiatorPortNumber;
    ///A string representing the symbolic name of the portal.
    byte[256] SymbolicName;
    ///A string representing the IP address or DNS name of the portal.
    byte[256] Address;
    ///The socket number.
    ushort    Socket;
}

///The <b>ISCSI_TARGET_PORTAL_INFO_EX</b> structure contains information about login credentials to a target portal.
struct ISCSI_TARGET_PORTAL_INFO_EXW
{
    ///A string that represents the name of the Host-Bus Adapter (HBA) initiator.
    ushort[256]         InitiatorName;
    ///A <b>ULONG</b> value that represents the port number on the HBA associated with the portal.
    uint                InitiatorPortNumber;
    ///A string that represents the symbolic name associated with the portal.
    ushort[256]         SymbolicName;
    ///A string that represents the IP address or DNS name associated with the portal.
    ushort[256]         Address;
    ///A <b>USHORT</b> value that represents the socket number.
    ushort              Socket;
    ///A pointer to an <b>ISCSI_SECURITY_FLAGS</b> structure that contains a bitmap that defines the security
    ///charactaristics of a login connection. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED"></a><a id="iscsi_security_flag_tunnel_mode_preferred"></a><dl>
    ///<dt><b>ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED</b></dt> </dl> </td> <td width="60%"> When set to 1, the
    ///initiator should make the connection in IPsec tunnel mode. Caller should set this flag or the
    ///<b>ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED</b> flag, but not both. </td> </tr> <tr> <td width="40%"><a
    ///id="ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED"></a><a
    ///id="iscsi_security_flag_transport_mode_preferred"></a><dl>
    ///<dt><b>ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED</b></dt> </dl> </td> <td width="60%"> When set to 1, the
    ///initiator should make the connection in IPsec transport mode. Caller should set this flag or the
    ///<b>ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED</b> flag, but not both. </td> </tr> <tr> <td width="40%"><a
    ///id="ISCSI_SECURITY_FLAG_PFS_ENABLED"></a><a id="iscsi_security_flag_pfs_enabled"></a><dl>
    ///<dt><b>ISCSI_SECURITY_FLAG_PFS_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the initiator should
    ///make the connection with Perfect Forward Secrecy (PFS) mode enabled; otherwise, the initiator should make the
    ///connection with PFS mode disabled. </td> </tr> <tr> <td width="40%"><a
    ///id="ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED"></a><a id="iscsi_security_flag_aggressive_mode_enabled"></a><dl>
    ///<dt><b>ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the
    ///initiator should make the connection with aggressive mode enabled. Caller should set this flag or the
    ///<b>ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED</b> flag, but not both. <div class="alert"><b>Note</b> The Microsoft
    ///software initiator driver does not support aggressive mode.</div> <div> </div> </td> </tr> <tr> <td
    ///width="40%"><a id="ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED"></a><a
    ///id="iscsi_security_flag_main_mode_enabled"></a><dl> <dt><b>ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED</b></dt> </dl>
    ///</td> <td width="60%"> When set to 1, the initiator should make the connection with main mode enabled. Caller
    ///should set this flag or the <b>ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED</b> flag, but not both. </td> </tr>
    ///<tr> <td width="40%"><a id="ISCSI_SECURITY_FLAG_IKE_IPSEC_ENABLED"></a><a
    ///id="iscsi_security_flag_ike_ipsec_enabled"></a><dl> <dt><b>ISCSI_SECURITY_FLAG_IKE_IPSEC_ENABLED</b></dt> </dl>
    ///</td> <td width="60%"> When set to 1, the initiator should make the connection with the IKE/IPsec protocol
    ///enabled; otherwise, the IKE/IPsec protocol is disabled. </td> </tr> <tr> <td width="40%"><a
    ///id="ISCSI_SECURITY_FLAG_VALID"></a><a id="iscsi_security_flag_valid"></a><dl>
    ///<dt><b>ISCSI_SECURITY_FLAG_VALID</b></dt> </dl> </td> <td width="60%"> When set to 1, the other mask values are
    ///valid; otherwise, the iSCSI initiator service will use bitmap values that were previously defined for the target
    ///portal, or if none are available, the initiator service uses the default values defined in the registry. </td>
    ///</tr> </table>
    ulong               SecurityFlags;
    ///A pointer to an ISCSI_LOGIN_OPTIONS structure that defines the login data.
    ISCSI_LOGIN_OPTIONS LoginOptions;
}

///The <b>ISCSI_TARGET_PORTAL_INFO_EX</b> structure contains information about login credentials to a target portal.
struct ISCSI_TARGET_PORTAL_INFO_EXA
{
    ///A string that represents the name of the Host-Bus Adapter (HBA) initiator.
    byte[256]           InitiatorName;
    ///A <b>ULONG</b> value that represents the port number on the HBA associated with the portal.
    uint                InitiatorPortNumber;
    ///A string that represents the symbolic name associated with the portal.
    byte[256]           SymbolicName;
    ///A string that represents the IP address or DNS name associated with the portal.
    byte[256]           Address;
    ///A <b>USHORT</b> value that represents the socket number.
    ushort              Socket;
    ///A pointer to an <b>ISCSI_SECURITY_FLAGS</b> structure that contains a bitmap that defines the security
    ///charactaristics of a login connection. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED"></a><a id="iscsi_security_flag_tunnel_mode_preferred"></a><dl>
    ///<dt><b>ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED</b></dt> </dl> </td> <td width="60%"> When set to 1, the
    ///initiator should make the connection in IPsec tunnel mode. Caller should set this flag or the
    ///<b>ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED</b> flag, but not both. </td> </tr> <tr> <td width="40%"><a
    ///id="ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED"></a><a
    ///id="iscsi_security_flag_transport_mode_preferred"></a><dl>
    ///<dt><b>ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED</b></dt> </dl> </td> <td width="60%"> When set to 1, the
    ///initiator should make the connection in IPsec transport mode. Caller should set this flag or the
    ///<b>ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED</b> flag, but not both. </td> </tr> <tr> <td width="40%"><a
    ///id="ISCSI_SECURITY_FLAG_PFS_ENABLED"></a><a id="iscsi_security_flag_pfs_enabled"></a><dl>
    ///<dt><b>ISCSI_SECURITY_FLAG_PFS_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the initiator should
    ///make the connection with Perfect Forward Secrecy (PFS) mode enabled; otherwise, the initiator should make the
    ///connection with PFS mode disabled. </td> </tr> <tr> <td width="40%"><a
    ///id="ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED"></a><a id="iscsi_security_flag_aggressive_mode_enabled"></a><dl>
    ///<dt><b>ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the
    ///initiator should make the connection with aggressive mode enabled. Caller should set this flag or the
    ///<b>ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED</b> flag, but not both. <div class="alert"><b>Note</b> The Microsoft
    ///software initiator driver does not support aggressive mode.</div> <div> </div> </td> </tr> <tr> <td
    ///width="40%"><a id="ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED"></a><a
    ///id="iscsi_security_flag_main_mode_enabled"></a><dl> <dt><b>ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED</b></dt> </dl>
    ///</td> <td width="60%"> When set to 1, the initiator should make the connection with main mode enabled. Caller
    ///should set this flag or the <b>ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED</b> flag, but not both. </td> </tr>
    ///<tr> <td width="40%"><a id="ISCSI_SECURITY_FLAG_IKE_IPSEC_ENABLED"></a><a
    ///id="iscsi_security_flag_ike_ipsec_enabled"></a><dl> <dt><b>ISCSI_SECURITY_FLAG_IKE_IPSEC_ENABLED</b></dt> </dl>
    ///</td> <td width="60%"> When set to 1, the initiator should make the connection with the IKE/IPsec protocol
    ///enabled; otherwise, the IKE/IPsec protocol is disabled. </td> </tr> <tr> <td width="40%"><a
    ///id="ISCSI_SECURITY_FLAG_VALID"></a><a id="iscsi_security_flag_valid"></a><dl>
    ///<dt><b>ISCSI_SECURITY_FLAG_VALID</b></dt> </dl> </td> <td width="60%"> When set to 1, the other mask values are
    ///valid; otherwise, the iSCSI initiator service will use bitmap values that were previously defined for the target
    ///portal, or if none are available, the initiator service uses the default values defined in the registry. </td>
    ///</tr> </table>
    ulong               SecurityFlags;
    ///A pointer to an ISCSI_LOGIN_OPTIONS structure that defines the login data.
    ISCSI_LOGIN_OPTIONS LoginOptions;
}

///The <b>ISCSI_TARGET_PORTAL_GROUP</b> structure contains information about the portals associated with a portal group.
struct ISCSI_TARGET_PORTAL_GROUPW
{
    ///The number of portals in the portal group.
    uint Count;
    ///An array of ISCSI_TARGET_PORTAL structures that describe the portals associated with the portal group. Portal
    ///names and addresses are described by either wide-character or ascii strings, depending upon implementation.
    ISCSI_TARGET_PORTALW[1] Portals;
}

///The <b>ISCSI_TARGET_PORTAL_GROUP</b> structure contains information about the portals associated with a portal group.
struct ISCSI_TARGET_PORTAL_GROUPA
{
    ///The number of portals in the portal group.
    uint Count;
    ///An array of ISCSI_TARGET_PORTAL structures that describe the portals associated with the portal group. Portal
    ///names and addresses are described by either wide-character or ascii strings, depending upon implementation.
    ISCSI_TARGET_PORTALA[1] Portals;
}

///The <b>ISCSI_CONNECTION_INFO</b> structure contains information about a connection.
struct ISCSI_CONNECTION_INFOW
{
    ///A ISCSI_UNIQUE_CONNECTION_ID structure that contains the unique identifier for a connection. The LoginIScsiTarget
    ///and AddIScsiConnection functions return this value via the UniqueConnectionId parameter.
    ISCSI_UNIQUE_SESSION_ID ConnectionId;
    ///A string that represents the IP address of the initiator.
    const(wchar)* InitiatorAddress;
    ///A string that represents the IP address of the target.
    const(wchar)* TargetAddress;
    ///The socket number on the initiator that establishes the connection.
    ushort        InitiatorSocket;
    ///The socket number on the target that establishes the connection.
    ushort        TargetSocket;
    ///The connection identifier for the connection.
    ubyte[2]      CID;
}

///The <b>ISCSI_SESSION_INFO</b> structure contains session information.
struct ISCSI_SESSION_INFOW
{
    ///A ISCSI_UNIQUE_SESSION_ID structure containing a unique identifier that represents the session.
    ISCSI_UNIQUE_SESSION_ID SessionId;
    ///A string that represents the initiator name.
    const(wchar)* InitiatorName;
    ///A string that represents the target node name.
    const(wchar)* TargetNodeName;
    ///A string that represents the target name.
    const(wchar)* TargetName;
    ///The initiator-side identifier (ISID) used in the iSCSI protocol.
    ubyte[6]      ISID;
    ///The target-side identifier (TSID) used in the iSCSI protocol.
    ubyte[2]      TSID;
    ///The number of connections associated with the session.
    uint          ConnectionCount;
    ///A pointer to a ISCSI_CONNECTION_INFO structure.
    ISCSI_CONNECTION_INFOW* Connections;
}

///The <b>ISCSI_CONNECTION_INFO</b> structure contains information about a connection.
struct ISCSI_CONNECTION_INFOA
{
    ///A ISCSI_UNIQUE_CONNECTION_ID structure that contains the unique identifier for a connection. The LoginIScsiTarget
    ///and AddIScsiConnection functions return this value via the UniqueConnectionId parameter.
    ISCSI_UNIQUE_SESSION_ID ConnectionId;
    ///A string that represents the IP address of the initiator.
    const(char)* InitiatorAddress;
    ///A string that represents the IP address of the target.
    const(char)* TargetAddress;
    ///The socket number on the initiator that establishes the connection.
    ushort       InitiatorSocket;
    ///The socket number on the target that establishes the connection.
    ushort       TargetSocket;
    ///The connection identifier for the connection.
    ubyte[2]     CID;
}

///The <b>ISCSI_SESSION_INFO</b> structure contains session information.
struct ISCSI_SESSION_INFOA
{
    ///A ISCSI_UNIQUE_SESSION_ID structure containing a unique identifier that represents the session.
    ISCSI_UNIQUE_SESSION_ID SessionId;
    ///A string that represents the initiator name.
    const(char)* InitiatorName;
    ///A string that represents the target node name.
    const(char)* TargetNodeName;
    ///A string that represents the target name.
    const(char)* TargetName;
    ///The initiator-side identifier (ISID) used in the iSCSI protocol.
    ubyte[6]     ISID;
    ///The target-side identifier (TSID) used in the iSCSI protocol.
    ubyte[2]     TSID;
    ///The number of connections associated with the session.
    uint         ConnectionCount;
    ///A pointer to a ISCSI_CONNECTION_INFO structure.
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

///The <b>ISCSI_DEVICE_ON_SESSION</b> structure specifies multiple methods for identifying a device associated with an
///iSCSI login session.
struct ISCSI_DEVICE_ON_SESSIONW
{
    ///A string that indicates the initiator name.
    ushort[256]  InitiatorName;
    ///A string that indicates the target name.
    ushort[224]  TargetName;
    ///A SCSI_ADDRESS structure that contains the SCSI address of the device.
    SCSI_ADDRESS ScsiAddress;
    ///A GUID that specifies the device interface class associated with the device. Device interface class GUIDs
    ///include, but are not limited to, the following: <table> <tr> <th>GUID</th> <th>Type of Device</th> </tr> <tr>
    ///<td>GUID_DEVINTERFACE_DISK</td> <td>Disk</td> </tr> <tr> <td>GUID_DEVINTERFACE_TAPE</td> <td>Tape</td> </tr> <tr>
    ///<td>GUID_DEVINTERFACE_CDROM</td> <td>CD-ROM</td> </tr> <tr> <td>GUID_DEVINTERFACE_WRITEONCEDISK</td> <td>Write
    ///Once Disk</td> </tr> <tr> <td>GUID_DEVINTERFACE_CDCHANGER</td> <td>CD Changer</td> </tr> <tr>
    ///<td>GUID_DEVINTERFACE_MEDIUMCHANGER</td> <td>Medium Changer</td> </tr> <tr> <td>GUID_DEVINTERFACE_FLOPPY</td>
    ///<td>Floppy</td> </tr> </table>
    GUID         DeviceInterfaceType;
    ///A string that specifies the name of the device interface class.
    ushort[260]  DeviceInterfaceName;
    ///A string that specifies the legacy device name.
    ushort[260]  LegacyName;
    ///A <b>STORAGE_DEVICE_NUMBER</b> structure containing the storage device number.
    STORAGE_DEVICE_NUMBER StorageDeviceNumber;
    ///A handle to the instance of the device in the devnode tree. For information on the cfgmgr32Xxx functions that
    ///utilize this handle, see PnP Configuration Manager Functions.
    uint         DeviceInstance;
}

///The <b>ISCSI_DEVICE_ON_SESSION</b> structure specifies multiple methods for identifying a device associated with an
///iSCSI login session.
struct ISCSI_DEVICE_ON_SESSIONA
{
    ///A string that indicates the initiator name.
    byte[256]    InitiatorName;
    ///A string that indicates the target name.
    byte[224]    TargetName;
    ///A SCSI_ADDRESS structure that contains the SCSI address of the device.
    SCSI_ADDRESS ScsiAddress;
    ///A GUID that specifies the device interface class associated with the device. Device interface class GUIDs
    ///include, but are not limited to, the following: <table> <tr> <th>GUID</th> <th>Type of Device</th> </tr> <tr>
    ///<td>GUID_DEVINTERFACE_DISK</td> <td>Disk</td> </tr> <tr> <td>GUID_DEVINTERFACE_TAPE</td> <td>Tape</td> </tr> <tr>
    ///<td>GUID_DEVINTERFACE_CDROM</td> <td>CD-ROM</td> </tr> <tr> <td>GUID_DEVINTERFACE_WRITEONCEDISK</td> <td>Write
    ///Once Disk</td> </tr> <tr> <td>GUID_DEVINTERFACE_CDCHANGER</td> <td>CD Changer</td> </tr> <tr>
    ///<td>GUID_DEVINTERFACE_MEDIUMCHANGER</td> <td>Medium Changer</td> </tr> <tr> <td>GUID_DEVINTERFACE_FLOPPY</td>
    ///<td>Floppy</td> </tr> </table>
    GUID         DeviceInterfaceType;
    ///A string that specifies the name of the device interface class.
    byte[260]    DeviceInterfaceName;
    ///A string that specifies the legacy device name.
    byte[260]    LegacyName;
    ///A <b>STORAGE_DEVICE_NUMBER</b> structure containing the storage device number.
    STORAGE_DEVICE_NUMBER StorageDeviceNumber;
    ///A handle to the instance of the device in the devnode tree. For information on the cfgmgr32Xxx functions that
    ///utilize this handle, see PnP Configuration Manager Functions.
    uint         DeviceInstance;
}

///The <b>PERSISTENT_ISCSI_LOGIN_INFO</b> structure contains information that describes a login session established by
///the Microsoft iSCSI initiator service after the machine boots up.
struct PERSISTENT_ISCSI_LOGIN_INFOW
{
    ///A string representing the name of the target the initiator will login to.
    ushort[224]          TargetName;
    ///If set <b>TRUE</b>, the login session is for informational purposes only and will not result in the enumeration
    ///of the specified target on the local computer. For an informational login session, the LUNs on the target are not
    ///reported to the Plug and Play Manager and the device drivers for the target are not loaded. A management
    ///application can still access targets not enumerated by the system via the SendScsiInquiry, SendScsiReportLuns,
    ///and SendScsiReadCapcity functions. If set <b>FALSE</b>, the LUNs on the target are reported to the Plug and Play
    ///manager for enumeration.
    ubyte                IsInformationalSession;
    ///A string representing the name of the initiator used to login to the target.
    ushort[256]          InitiatorInstance;
    ///The port number of the Host-Bus Adapter (HBA) through which the session login is established. A value of
    ///<b>ISCSI_ANY_INITIATOR_PORT</b> indicates that a port on the initiator is not currently specified.
    uint                 InitiatorPortNumber;
    ///A ISCSI_TARGET_PORTAL structure that describes the portal used by the Microsoft iSCSI initiator service to log on
    ///to the target.
    ISCSI_TARGET_PORTALW TargetPortal;
    ///A bitmap that defines the security characteristics of a login connection. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED"></a><a
    ///id="iscsi_security_flag_tunnel_mode_preferred"></a><dl> <dt><b>ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED</b></dt>
    ///</dl> </td> <td width="60%"> The Host Bus Adapter (HBA) initiator should establish the TCP/IP connection to the
    ///target portal using IPsec tunnel mode. </td> </tr> <tr> <td width="40%"><a
    ///id="ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED"></a><a
    ///id="iscsi_security_flag_transport_mode_preferred"></a><dl>
    ///<dt><b>ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED</b></dt> </dl> </td> <td width="60%"> The HBA initiator
    ///should establish the TCP/IP connection to the target portal using IPsec transport mode. </td> </tr> <tr> <td
    ///width="40%"><a id="ISCSI_SECURITY_FLAG_PFS_ENABLED"></a><a id="iscsi_security_flag_pfs_enabled"></a><dl>
    ///<dt><b>ISCSI_SECURITY_FLAG_PFS_ENABLED</b></dt> </dl> </td> <td width="60%"> The HBA initiator should establish
    ///the TCP/IP connection to the target portal with Perfect Forward Secrecy (PFS) mode enabled if IPsec is required.
    ///</td> </tr> <tr> <td width="40%"><a id="ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED"></a><a
    ///id="iscsi_security_flag_aggressive_mode_enabled"></a><dl>
    ///<dt><b>ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED</b></dt> </dl> </td> <td width="60%"> The HBA initiator should
    ///establish the TCP/IP connection to the target portal with aggressive mode enabled. </td> </tr> <tr> <td
    ///width="40%"><a id="ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED"></a><a
    ///id="iscsi_security_flag_main_mode_enabled"></a><dl> <dt><b>ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED</b></dt> </dl>
    ///</td> <td width="60%"> The HBA initiator should establish the TCP/IP connection to the target portal with main
    ///mode enabled. </td> </tr> <tr> <td width="40%"><a id="ISCSI_SECURITY_FLAG_IKE_IPSEC_ENABLED"></a><a
    ///id="iscsi_security_flag_ike_ipsec_enabled"></a><dl> <dt><b>ISCSI_SECURITY_FLAG_IKE_IPSEC_ENABLED</b></dt> </dl>
    ///</td> <td width="60%"> The HBA initiator should establish the TCP/IP connection to the target portal using
    ///IKE/IPsec protocol. If not set then IPsec is not required to login to the target. </td> </tr> <tr> <td
    ///width="40%"><a id="ISCSI_SECURITY_FLAG_VALID"></a><a id="iscsi_security_flag_valid"></a><dl>
    ///<dt><b>ISCSI_SECURITY_FLAG_VALID</b></dt> </dl> </td> <td width="60%"> The other mask values are valid;
    ///otherwise, security flags are not specified. </td> </tr> </table>
    ulong                SecurityFlags;
    ///A pointer to a ISCSI_TARGET_MAPPING structure that contains information about a target, its logical units, HBAs,
    ///and buses through which it is reached.
    ISCSI_TARGET_MAPPINGW* Mappings;
    ///An ISCSI_LOGIN_OPTIONS structure that contains the persistent login characteristics.
    ISCSI_LOGIN_OPTIONS  LoginOptions;
}

///The <b>PERSISTENT_ISCSI_LOGIN_INFO</b> structure contains information that describes a login session established by
///the Microsoft iSCSI initiator service after the machine boots up.
struct PERSISTENT_ISCSI_LOGIN_INFOA
{
    ///A string representing the name of the target the initiator will login to.
    byte[224]            TargetName;
    ///If set <b>TRUE</b>, the login session is for informational purposes only and will not result in the enumeration
    ///of the specified target on the local computer. For an informational login session, the LUNs on the target are not
    ///reported to the Plug and Play Manager and the device drivers for the target are not loaded. A management
    ///application can still access targets not enumerated by the system via the SendScsiInquiry, SendScsiReportLuns,
    ///and SendScsiReadCapcity functions. If set <b>FALSE</b>, the LUNs on the target are reported to the Plug and Play
    ///manager for enumeration.
    ubyte                IsInformationalSession;
    ///A string representing the name of the initiator used to login to the target.
    byte[256]            InitiatorInstance;
    ///The port number of the Host-Bus Adapter (HBA) through which the session login is established. A value of
    ///<b>ISCSI_ANY_INITIATOR_PORT</b> indicates that a port on the initiator is not currently specified.
    uint                 InitiatorPortNumber;
    ///A ISCSI_TARGET_PORTAL structure that describes the portal used by the Microsoft iSCSI initiator service to log on
    ///to the target.
    ISCSI_TARGET_PORTALA TargetPortal;
    ///A bitmap that defines the security characteristics of a login connection. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED"></a><a
    ///id="iscsi_security_flag_tunnel_mode_preferred"></a><dl> <dt><b>ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED</b></dt>
    ///</dl> </td> <td width="60%"> The Host Bus Adapter (HBA) initiator should establish the TCP/IP connection to the
    ///target portal using IPsec tunnel mode. </td> </tr> <tr> <td width="40%"><a
    ///id="ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED"></a><a
    ///id="iscsi_security_flag_transport_mode_preferred"></a><dl>
    ///<dt><b>ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED</b></dt> </dl> </td> <td width="60%"> The HBA initiator
    ///should establish the TCP/IP connection to the target portal using IPsec transport mode. </td> </tr> <tr> <td
    ///width="40%"><a id="ISCSI_SECURITY_FLAG_PFS_ENABLED"></a><a id="iscsi_security_flag_pfs_enabled"></a><dl>
    ///<dt><b>ISCSI_SECURITY_FLAG_PFS_ENABLED</b></dt> </dl> </td> <td width="60%"> The HBA initiator should establish
    ///the TCP/IP connection to the target portal with Perfect Forward Secrecy (PFS) mode enabled if IPsec is required.
    ///</td> </tr> <tr> <td width="40%"><a id="ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED"></a><a
    ///id="iscsi_security_flag_aggressive_mode_enabled"></a><dl>
    ///<dt><b>ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED</b></dt> </dl> </td> <td width="60%"> The HBA initiator should
    ///establish the TCP/IP connection to the target portal with aggressive mode enabled. </td> </tr> <tr> <td
    ///width="40%"><a id="ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED"></a><a
    ///id="iscsi_security_flag_main_mode_enabled"></a><dl> <dt><b>ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED</b></dt> </dl>
    ///</td> <td width="60%"> The HBA initiator should establish the TCP/IP connection to the target portal with main
    ///mode enabled. </td> </tr> <tr> <td width="40%"><a id="ISCSI_SECURITY_FLAG_IKE_IPSEC_ENABLED"></a><a
    ///id="iscsi_security_flag_ike_ipsec_enabled"></a><dl> <dt><b>ISCSI_SECURITY_FLAG_IKE_IPSEC_ENABLED</b></dt> </dl>
    ///</td> <td width="60%"> The HBA initiator should establish the TCP/IP connection to the target portal using
    ///IKE/IPsec protocol. If not set then IPsec is not required to login to the target. </td> </tr> <tr> <td
    ///width="40%"><a id="ISCSI_SECURITY_FLAG_VALID"></a><a id="iscsi_security_flag_valid"></a><dl>
    ///<dt><b>ISCSI_SECURITY_FLAG_VALID</b></dt> </dl> </td> <td width="60%"> The other mask values are valid;
    ///otherwise, security flags are not specified. </td> </tr> </table>
    ulong                SecurityFlags;
    ///A pointer to a ISCSI_TARGET_MAPPING structure that contains information about a target, its logical units, HBAs,
    ///and buses through which it is reached.
    ISCSI_TARGET_MAPPINGA* Mappings;
    ///An ISCSI_LOGIN_OPTIONS structure that contains the persistent login characteristics.
    ISCSI_LOGIN_OPTIONS  LoginOptions;
}

///The <b>ISCSI_VERSION_INFO</b> structure contains the version and build numbers of the iSCSI software initiator and
///the initiator service.
struct ISCSI_VERSION_INFO
{
    ///The major version number of the iSCSI software initiator and initiator service. This may be different from the
    ///version number of the Operating System.
    uint MajorVersion;
    ///The minor version number of the iSCSI software initiator and initiator service. This may be different from the
    ///version number of the Operating System.
    uint MinorVersion;
    uint BuildNumber;
}

// Functions

///The <b>GetIscsiVersionInformation</b> function retrieves information about the initiator version.
///Params:
///    VersionInfo = Pointer to an ISCSI_VERSION_INFO structure that contains initiator version information.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if the operation is successful. If the operation fails due to a socket connection
///    error, this function will return a Winsock error code.
///    
@DllImport("ISCSIDSC")
uint GetIScsiVersionInformation(ISCSI_VERSION_INFO* VersionInfo);

///The <b>GetIscsiTargetInformation</b> function retrieves information about the specified target.
///Params:
///    TargetName = The name of the target for which information is retrieved.
///    DiscoveryMechanism = A text description of the mechanism that was used to discover the target (for example, "iSNS:", "SendTargets:" or
///                         "HBA:"). A value of <b>null</b> indicates that no discovery mechanism is specified.
///    InfoClass = A value of type TARGET_INFORMATION_CLASS that indicates the type of information to retrieve.
///    BufferSize = A pointer to a location that, on input, contains the size (in bytes) of the buffer that <i>Buffer</i> points to.
///                 If the operation succeeds, the location receives the number of bytes retrieved. If the operation fails, the
///                 location receives the size of the buffer required to contain the output data.
///    Buffer = The buffer that contains the output data. The output data consists in <b>null</b>-terminated strings, with a
///             double <b>null</b> termination after the last string.
///Returns:
///    Returns ERROR_SUCCESS if successful and ERROR_INSUFFICIENT_BUFFER if the buffer size at Buffer was insufficient
///    to contain the output data. Otherwise, <b>GetIscsiTargetInformation</b> returns the appropriate Win32 or iSCSI
///    error code on failure.
///    
@DllImport("ISCSIDSC")
uint GetIScsiTargetInformationW(const(wchar)* TargetName, const(wchar)* DiscoveryMechanism, 
                                TARGET_INFORMATION_CLASS InfoClass, uint* BufferSize, void* Buffer);

///The <b>GetIscsiTargetInformation</b> function retrieves information about the specified target.
///Params:
///    TargetName = The name of the target for which information is retrieved.
///    DiscoveryMechanism = A text description of the mechanism that was used to discover the target (for example, "iSNS:", "SendTargets:" or
///                         "HBA:"). A value of <b>null</b> indicates that no discovery mechanism is specified.
///    InfoClass = A value of type TARGET_INFORMATION_CLASS that indicates the type of information to retrieve.
///    BufferSize = A pointer to a location that, on input, contains the size (in bytes) of the buffer that <i>Buffer</i> points to.
///                 If the operation succeeds, the location receives the number of bytes retrieved. If the operation fails, the
///                 location receives the size of the buffer required to contain the output data.
///    Buffer = The buffer that contains the output data. The output data consists in <b>null</b>-terminated strings, with a
///             double <b>null</b> termination after the last string.
///Returns:
///    Returns ERROR_SUCCESS if successful and ERROR_INSUFFICIENT_BUFFER if the buffer size at Buffer was insufficient
///    to contain the output data. Otherwise, <b>GetIscsiTargetInformation</b> returns the appropriate Win32 or iSCSI
///    error code on failure.
///    
@DllImport("ISCSIDSC")
uint GetIScsiTargetInformationA(const(char)* TargetName, const(char)* DiscoveryMechanism, 
                                TARGET_INFORMATION_CLASS InfoClass, uint* BufferSize, void* Buffer);

///The <b>AddIscsiConnection</b> function adds a new iSCSI connection to an existing session.
///Params:
///    UniqueSessionId = A pointer to a structure of type ISCSI_UNIQUE_SESSION_ID that, on input, contains the session identifier for the
///                      session that was added.
///    Reserved = This member should be <b>null</b> on input.
///    InitiatorPortNumber = The number of the port on the initiator that the initiator uses to add the connection. A value of
///                          <b>ISCSI_ANY_INITIATOR_PORT</b> indicates that the initiator can use any of its ports to add the connection.
///    TargetPortal = A pointer to an ISCSI_TARGET_PORTAL-type structure that indicates the target portal to use when adding the
///                   connection. The portal must belong to the same portal group that the initiator used to login to the target, and
///                   it must be a portal that the initiator discovered. The iSCSI initiator service does not verify that the target
///                   portal meets these requirements.
///    SecurityFlags = A bitmap that specifies the characteristics of the IPsec connection that the initiator uses to establish the
///                    connection. If IPsec security policy between the initiator and the target portal is already configured because of
///                    the portal group policy or a previous connection to the portal, the existing configuration takes precedence over
///                    the configuration specified in SecurityFlags and the security bitmap is ignored. If the
///                    <b>ISCSI_SECURITY_FLAG_VALID</b> flag is set to 0, the iSCSI initiator service uses default values for the
///                    security flags that are defined in the registry. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                    width="40%"><a id="ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED"></a><a
///                    id="iscsi_security_flag_tunnel_mode_preferred"></a><dl> <dt><b>ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED</b></dt>
///                    </dl> </td> <td width="60%"> When set to 1, the initiator should make the connection in IPsec tunnel mode. Caller
///                    should set this flag or the ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED flag, but not both. </td> </tr> <tr> <td
///                    width="40%"><a id="ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED"></a><a
///                    id="iscsi_security_flag_transport_mode_preferred"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED</b></dt> </dl> </td> <td width="60%"> When set to 1, the
///                    initiator should make the connection in IPsec transport mode. Caller should set this flag or the
///                    ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED flag, but not both. </td> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_PFS_ENABLED"></a><a id="iscsi_security_flag_pfs_enabled"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_PFS_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the initiator should
///                    make the connection with Perfect Forward Secrecy (PFS) mode enabled; otherwise, the initiator should make the
///                    connection with PFS mode disabled. </td> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED"></a><a id="iscsi_security_flag_aggressive_mode_enabled"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the
///                    initiator should make the connection with aggressive mode enabled. Caller should set this flag or the
///                    ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED flag, but not both. <div class="alert"><b>Note</b> The Microsoft software
///                    initiator driver does not support aggressive mode. </div> <div> </div> </td> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED"></a><a id="iscsi_security_flag_main_mode_enabled"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the initiator
///                    should make the connection with main mode enabled. Caller should set this flag or the
///                    ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED flag, but not both. </td> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_IKE_IPSEC_ENABLED"></a><a id="iscsi_security_flag_ike_ipsec_enabled"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_IKE_IPSEC_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the initiator
///                    should make the connection with the IKE/IPsec protocol enabled; otherwise, the IKE/IPsec protocol is disabled.
///                    </td> </tr> <tr> <td width="40%"><a id="ISCSI_SECURITY_FLAG_VALID"></a><a id="iscsi_security_flag_valid"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_VALID</b></dt> </dl> </td> <td width="60%"> When set to 1, the other mask values are
///                    valid; otherwise, the iSCSI initiator service will use bitmap values that were previously defined for the target
///                    portal, or if none are available, the initiator service uses the default values defined in the registry. </td>
///                    </tr> </table>
///    LoginOptions = A pointer to a structure of type ISCSI_LOGIN_OPTIONS that contains the options that specify the characteristics
///                   of the login session.
///    KeySize = The size, in bytes, of the preshared key that is passed to the target.
///    Key = If the IPsec security policy between the initiator and the target portal is already configured as a result of the
///          portal group policy or a previous connection to the portal, the existing key takes precedence over the key
///          currently specified in this member.
///    ConnectionId = An ISCSI_UNIQUE_CONNECTION_ID-type structure that, on output, receives an opaque value that uniquely identifies
///                   the connection that was added to the session.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint AddIScsiConnectionW(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, void* Reserved, uint InitiatorPortNumber, 
                         ISCSI_TARGET_PORTALW* TargetPortal, ulong SecurityFlags, ISCSI_LOGIN_OPTIONS* LoginOptions, 
                         uint KeySize, const(char)* Key, ISCSI_UNIQUE_SESSION_ID* ConnectionId);

///The <b>AddIscsiConnection</b> function adds a new iSCSI connection to an existing session.
///Params:
///    UniqueSessionId = A pointer to a structure of type ISCSI_UNIQUE_SESSION_ID that, on input, contains the session identifier for the
///                      session that was added.
///    Reserved = This member should be <b>null</b> on input.
///    InitiatorPortNumber = The number of the port on the initiator that the initiator uses to add the connection. A value of
///                          <b>ISCSI_ANY_INITIATOR_PORT</b> indicates that the initiator can use any of its ports to add the connection.
///    TargetPortal = A pointer to an ISCSI_TARGET_PORTAL-type structure that indicates the target portal to use when adding the
///                   connection. The portal must belong to the same portal group that the initiator used to login to the target, and
///                   it must be a portal that the initiator discovered. The iSCSI initiator service does not verify that the target
///                   portal meets these requirements.
///    SecurityFlags = A bitmap that specifies the characteristics of the IPsec connection that the initiator uses to establish the
///                    connection. If IPsec security policy between the initiator and the target portal is already configured because of
///                    the portal group policy or a previous connection to the portal, the existing configuration takes precedence over
///                    the configuration specified in SecurityFlags and the security bitmap is ignored. If the
///                    <b>ISCSI_SECURITY_FLAG_VALID</b> flag is set to 0, the iSCSI initiator service uses default values for the
///                    security flags that are defined in the registry. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                    width="40%"><a id="ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED"></a><a
///                    id="iscsi_security_flag_tunnel_mode_preferred"></a><dl> <dt><b>ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED</b></dt>
///                    </dl> </td> <td width="60%"> When set to 1, the initiator should make the connection in IPsec tunnel mode. Caller
///                    should set this flag or the ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED flag, but not both. </td> </tr> <tr> <td
///                    width="40%"><a id="ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED"></a><a
///                    id="iscsi_security_flag_transport_mode_preferred"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED</b></dt> </dl> </td> <td width="60%"> When set to 1, the
///                    initiator should make the connection in IPsec transport mode. Caller should set this flag or the
///                    ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED flag, but not both. </td> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_PFS_ENABLED"></a><a id="iscsi_security_flag_pfs_enabled"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_PFS_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the initiator should
///                    make the connection with Perfect Forward Secrecy (PFS) mode enabled; otherwise, the initiator should make the
///                    connection with PFS mode disabled. </td> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED"></a><a id="iscsi_security_flag_aggressive_mode_enabled"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the
///                    initiator should make the connection with aggressive mode enabled. Caller should set this flag or the
///                    ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED flag, but not both. <div class="alert"><b>Note</b> The Microsoft software
///                    initiator driver does not support aggressive mode. </div> <div> </div> </td> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED"></a><a id="iscsi_security_flag_main_mode_enabled"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the initiator
///                    should make the connection with main mode enabled. Caller should set this flag or the
///                    ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED flag, but not both. </td> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_IKE_IPSEC_ENABLED"></a><a id="iscsi_security_flag_ike_ipsec_enabled"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_IKE_IPSEC_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the initiator
///                    should make the connection with the IKE/IPsec protocol enabled; otherwise, the IKE/IPsec protocol is disabled.
///                    </td> </tr> <tr> <td width="40%"><a id="ISCSI_SECURITY_FLAG_VALID"></a><a id="iscsi_security_flag_valid"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_VALID</b></dt> </dl> </td> <td width="60%"> When set to 1, the other mask values are
///                    valid; otherwise, the iSCSI initiator service will use bitmap values that were previously defined for the target
///                    portal, or if none are available, the initiator service uses the default values defined in the registry. </td>
///                    </tr> </table>
///    LoginOptions = A pointer to a structure of type ISCSI_LOGIN_OPTIONS that contains the options that specify the characteristics
///                   of the login session.
///    KeySize = The size, in bytes, of the preshared key that is passed to the target.
///    Key = If the IPsec security policy between the initiator and the target portal is already configured as a result of the
///          portal group policy or a previous connection to the portal, the existing key takes precedence over the key
///          currently specified in this member.
///    ConnectionId = An ISCSI_UNIQUE_CONNECTION_ID-type structure that, on output, receives an opaque value that uniquely identifies
///                   the connection that was added to the session.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint AddIScsiConnectionA(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, void* Reserved, uint InitiatorPortNumber, 
                         ISCSI_TARGET_PORTALA* TargetPortal, ulong SecurityFlags, ISCSI_LOGIN_OPTIONS* LoginOptions, 
                         uint KeySize, const(char)* Key, ISCSI_UNIQUE_SESSION_ID* ConnectionId);

///The <b>RemoveIscsiConnection</b> function removes a connection from an active session.
///Params:
///    UniqueSessionId = A pointer to a structure of type ISCSI_UNIQUE_SESSION_ID that specifies the unique session identifier of the
///                      session that the connection belongs to.
///    ConnectionId = A pointer to a structure of type ISCSI_UNIQUE_CONNECTION_ID that specifies the connection to remove.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint RemoveIScsiConnection(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, ISCSI_UNIQUE_SESSION_ID* ConnectionId);

///The <b>ReportIscsiTargets</b> function retrieves the list of targets that the iSCSI initiator service has discovered,
///and can also instruct the iSCSI initiator service to refresh the list.
///Params:
///    ForceUpdate = If <b>true</b>, the iSCSI initiator service updates the list of discovered targets before returning the target
///                  list data to the caller.
///    BufferSize = A <b>ULONG</b> value that specifies the number of list elements contained by the <i>Buffer</i> parameter.
///    Buffer = Pointer to a buffer that receives and contains the list of targets. The list consists of <b>null</b>-terminated
///             strings. The last string, however, is double <b>null</b>-terminated.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds and ERROR_INSUFFICIENT_BUFFER if the buffer size is insufficient
///    to contain the output data. Otherwise, <b>ReportIscsiTargets</b> returns the appropriate Win32 or iSCSI error
///    code on failure.
///    
@DllImport("ISCSIDSC")
uint ReportIScsiTargetsW(ubyte ForceUpdate, uint* BufferSize, const(wchar)* Buffer);

///The <b>ReportIscsiTargets</b> function retrieves the list of targets that the iSCSI initiator service has discovered,
///and can also instruct the iSCSI initiator service to refresh the list.
///Params:
///    ForceUpdate = If <b>true</b>, the iSCSI initiator service updates the list of discovered targets before returning the target
///                  list data to the caller.
///    BufferSize = A <b>ULONG</b> value that specifies the number of list elements contained by the <i>Buffer</i> parameter.
///    Buffer = Pointer to a buffer that receives and contains the list of targets. The list consists of <b>null</b>-terminated
///             strings. The last string, however, is double <b>null</b>-terminated.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds and ERROR_INSUFFICIENT_BUFFER if the buffer size is insufficient
///    to contain the output data. Otherwise, <b>ReportIscsiTargets</b> returns the appropriate Win32 or iSCSI error
///    code on failure.
///    
@DllImport("ISCSIDSC")
uint ReportIScsiTargetsA(ubyte ForceUpdate, uint* BufferSize, const(char)* Buffer);

///The <b>AddIscsiStaticTarget</b> function adds a target to the list of static targets available to the iSCSI
///initiator.
///Params:
///    TargetName = The name of the target to add to the static target list.
///    TargetAlias = An alias associated with the <i>TargetName</i>.
///    TargetFlags = A bitmap of flags that affect how, and under what circumstances, a target is discovered and enumerated. The
///                  following table lists the flags that can be associated with a target and the meaning of each flag. <table> <tr>
///                  <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="ISCSI_TARGET_FLAG_HIDE_STATIC_TARGET"></a><a
///                  id="iscsi_target_flag_hide_static_target"></a><dl> <dt><b>ISCSI_TARGET_FLAG_HIDE_STATIC_TARGET</b></dt> </dl>
///                  </td> <td width="60%"> The target is added to the list of static targets. However, ReportIscsiTargets does not
///                  report the target, unless it was also discovered dynamically by the iSCSI initiator, the Internet Storage Name
///                  Service (iSNS), or a <b>SendTargets</b> request. </td> </tr> <tr> <td width="40%"><a
///                  id="ISCSI_TARGET_FLAG_MERGE_TARGET_INFORMATION"></a><a id="iscsi_target_flag_merge_target_information"></a><dl>
///                  <dt><b>ISCSI_TARGET_FLAG_MERGE_TARGET_INFORMATION</b></dt> </dl> </td> <td width="60%"> The iSCSI initiator
///                  service merges the information (if any) that it already has for this static target with the information that the
///                  caller passes to <b>AddIscsiStaticTarget</b>. If this flag is not set, the iSCSI initiator service overwrites the
///                  stored information with the information that the caller passes in. </td> </tr> </table>
///    Persist = If <b>true</b>, the target information persists across restarts of the iSCSI initiator service.
///    Mappings = A pointer to a structure of type ISCSI_TARGET_MAPPING that contains a set of mappings that the initiator uses
///               when assigning values for the bus, target, and LUN numbers to the iSCSI LUNs associated with the target. If
///               <i>Mappings</i> is <b>null</b>, the initiator will select the bus, target, and LUN numbers.
///    LoginOptions = A pointer to a structure of type ISCSI_LOGIN_OPTIONS that contains the options that specify the default login
///                   parameters that an initiator uses to login to a target.
///    PortalGroup = A pointer to a structure of type ISCSI_TARGET_PORTAL_GROUP that indicates the group of portals that an initiator
///                  can use login to the target.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint AddIScsiStaticTargetW(const(wchar)* TargetName, const(wchar)* TargetAlias, uint TargetFlags, ubyte Persist, 
                           ISCSI_TARGET_MAPPINGW* Mappings, ISCSI_LOGIN_OPTIONS* LoginOptions, 
                           ISCSI_TARGET_PORTAL_GROUPW* PortalGroup);

///The <b>AddIscsiStaticTarget</b> function adds a target to the list of static targets available to the iSCSI
///initiator.
///Params:
///    TargetName = The name of the target to add to the static target list.
///    TargetAlias = An alias associated with the <i>TargetName</i>.
///    TargetFlags = A bitmap of flags that affect how, and under what circumstances, a target is discovered and enumerated. The
///                  following table lists the flags that can be associated with a target and the meaning of each flag. <table> <tr>
///                  <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="ISCSI_TARGET_FLAG_HIDE_STATIC_TARGET"></a><a
///                  id="iscsi_target_flag_hide_static_target"></a><dl> <dt><b>ISCSI_TARGET_FLAG_HIDE_STATIC_TARGET</b></dt> </dl>
///                  </td> <td width="60%"> The target is added to the list of static targets. However, ReportIscsiTargets does not
///                  report the target, unless it was also discovered dynamically by the iSCSI initiator, the Internet Storage Name
///                  Service (iSNS), or a <b>SendTargets</b> request. </td> </tr> <tr> <td width="40%"><a
///                  id="ISCSI_TARGET_FLAG_MERGE_TARGET_INFORMATION"></a><a id="iscsi_target_flag_merge_target_information"></a><dl>
///                  <dt><b>ISCSI_TARGET_FLAG_MERGE_TARGET_INFORMATION</b></dt> </dl> </td> <td width="60%"> The iSCSI initiator
///                  service merges the information (if any) that it already has for this static target with the information that the
///                  caller passes to <b>AddIscsiStaticTarget</b>. If this flag is not set, the iSCSI initiator service overwrites the
///                  stored information with the information that the caller passes in. </td> </tr> </table>
///    Persist = If <b>true</b>, the target information persists across restarts of the iSCSI initiator service.
///    Mappings = A pointer to a structure of type ISCSI_TARGET_MAPPING that contains a set of mappings that the initiator uses
///               when assigning values for the bus, target, and LUN numbers to the iSCSI LUNs associated with the target. If
///               <i>Mappings</i> is <b>null</b>, the initiator will select the bus, target, and LUN numbers.
///    LoginOptions = A pointer to a structure of type ISCSI_LOGIN_OPTIONS that contains the options that specify the default login
///                   parameters that an initiator uses to login to a target.
///    PortalGroup = A pointer to a structure of type ISCSI_TARGET_PORTAL_GROUP that indicates the group of portals that an initiator
///                  can use login to the target.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint AddIScsiStaticTargetA(const(char)* TargetName, const(char)* TargetAlias, uint TargetFlags, ubyte Persist, 
                           ISCSI_TARGET_MAPPINGA* Mappings, ISCSI_LOGIN_OPTIONS* LoginOptions, 
                           ISCSI_TARGET_PORTAL_GROUPA* PortalGroup);

///The <b>RemoveIscsiStaticTarget</b> function removes a target from the list of static targets made available to the
///machine.
///Params:
///    TargetName = The name of the iSCSI target to remove from the static list.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint RemoveIScsiStaticTargetW(const(wchar)* TargetName);

///The <b>RemoveIscsiStaticTarget</b> function removes a target from the list of static targets made available to the
///machine.
///Params:
///    TargetName = The name of the iSCSI target to remove from the static list.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint RemoveIScsiStaticTargetA(const(char)* TargetName);

///The <b>AddIscsiSendTargetPortal</b> function adds a static target portal to the list of target portals to which the
///iSCSI initiator service transmits <b>SendTargets</b> requests.
///Params:
///    InitiatorInstance = The initiator that the iSCSI initiator service utilizes to transmit <b>SendTargets</b> requests to the specified
///                        target portal. If <b>null</b>, the iSCSI initiator service will use any initiator that can reach the target
///                        portal.
///    InitiatorPortNumber = The port number to use for the <b>SendTargets</b> request. This port number corresponds to the source IP address
///                          on the Host-Bus Adapter (HBA). A value of <b>ISCSI_ALL_INITIATOR_PORTS</b> indicates that the initiator must
///                          select the appropriate port based upon current routing information.
///    LoginOptions = A pointer to a structure of type ISCSI_LOGIN_OPTIONS that contains the login options to use with the target
///                   portal.
///    SecurityFlags = A bitmap that specifies the characteristics of the IPsec connection that the initiator adds to the session. If
///                    IPsec security policy between the initiator and the target portal is already configured as a result of the portal
///                    group policy or a previous connection to the portal, the existing configuration takes precedence over the
///                    configuration specified in SecurityFlags and the security bitmap is ignored. If the
///                    <b>ISCSI_SECURITY_FLAG_VALID</b> flag is set to 0, the iSCSI initiator service uses default values for the
///                    security flags that are defined in the registry. Caller can set any of the following flags in the bitmap: <table>
///                    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED"></a><a id="iscsi_security_flag_tunnel_mode_preferred"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED</b></dt> </dl> </td> <td width="60%"> When set to 1, the
///                    initiator should make the connection in IPsec tunnel mode. Caller should set this flag or the
///                    ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED flag, but not both. </td> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED"></a><a
///                    id="iscsi_security_flag_transport_mode_preferred"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED</b></dt> </dl> </td> <td width="60%"> When set to 1, the
///                    initiator should make the connection in IPsec transport mode. Caller should set this flag or the
///                    ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED flag, but not both. </td> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_PFS_ENABLED"></a><a id="iscsi_security_flag_pfs_enabled"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_PFS_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the initiator should
///                    make the connection with Perfect Forward Secrecy (PFS) mode enabled; otherwise, the initiator should make the
///                    connection with PFS mode disabled. </td> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED"></a><a id="iscsi_security_flag_aggressive_mode_enabled"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the
///                    initiator should make the connection with aggressive mode enabled. Caller should set this flag or the
///                    ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED flag, but not both. <div class="alert"><b>Note</b> The Microsoft software
///                    initiator driver does not support aggressive mode. </div> <div> </div> </td> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED"></a><a id="iscsi_security_flag_main_mode_enabled"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the initiator
///                    should make the connection with main mode enabled. Caller should set this flag or the
///                    ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED flag, but not both. </td> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_IKE_IPSEC_ENABLED"></a><a id="iscsi_security_flag_ike_ipsec_enabled"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_IKE_IPSEC_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the initiator
///                    should make the connection with the IKE/IPsec protocol enabled; otherwise, the IKE/IPsec protocol is disabled.
///                    </td> </tr> <tr> <td width="40%"><a id="ISCSI_SECURITY_FLAG_VALID"></a><a id="iscsi_security_flag_valid"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_VALID</b></dt> </dl> </td> <td width="60%"> When set to 1, the other mask values are
///                    valid; otherwise, the iSCSI initiator service will use bitmap values that were previously defined for the target
///                    portal, or if none are available, the initiator service uses the default values defined in the registry. </td>
///                    </tr> </table>
///    Portal = A pointer to a structure of type ISCSI_TARGET_PORTAL that indicates the portal to which SendTargets will be sent
///             for target discovery.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint AddIScsiSendTargetPortalW(const(wchar)* InitiatorInstance, uint InitiatorPortNumber, 
                               ISCSI_LOGIN_OPTIONS* LoginOptions, ulong SecurityFlags, ISCSI_TARGET_PORTALW* Portal);

///The <b>AddIscsiSendTargetPortal</b> function adds a static target portal to the list of target portals to which the
///iSCSI initiator service transmits <b>SendTargets</b> requests.
///Params:
///    InitiatorInstance = The initiator that the iSCSI initiator service utilizes to transmit <b>SendTargets</b> requests to the specified
///                        target portal. If <b>null</b>, the iSCSI initiator service will use any initiator that can reach the target
///                        portal.
///    InitiatorPortNumber = The port number to use for the <b>SendTargets</b> request. This port number corresponds to the source IP address
///                          on the Host-Bus Adapter (HBA). A value of <b>ISCSI_ALL_INITIATOR_PORTS</b> indicates that the initiator must
///                          select the appropriate port based upon current routing information.
///    LoginOptions = A pointer to a structure of type ISCSI_LOGIN_OPTIONS that contains the login options to use with the target
///                   portal.
///    SecurityFlags = A bitmap that specifies the characteristics of the IPsec connection that the initiator adds to the session. If
///                    IPsec security policy between the initiator and the target portal is already configured as a result of the portal
///                    group policy or a previous connection to the portal, the existing configuration takes precedence over the
///                    configuration specified in SecurityFlags and the security bitmap is ignored. If the
///                    <b>ISCSI_SECURITY_FLAG_VALID</b> flag is set to 0, the iSCSI initiator service uses default values for the
///                    security flags that are defined in the registry. Caller can set any of the following flags in the bitmap: <table>
///                    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED"></a><a id="iscsi_security_flag_tunnel_mode_preferred"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED</b></dt> </dl> </td> <td width="60%"> When set to 1, the
///                    initiator should make the connection in IPsec tunnel mode. Caller should set this flag or the
///                    ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED flag, but not both. </td> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED"></a><a
///                    id="iscsi_security_flag_transport_mode_preferred"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED</b></dt> </dl> </td> <td width="60%"> When set to 1, the
///                    initiator should make the connection in IPsec transport mode. Caller should set this flag or the
///                    ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED flag, but not both. </td> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_PFS_ENABLED"></a><a id="iscsi_security_flag_pfs_enabled"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_PFS_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the initiator should
///                    make the connection with Perfect Forward Secrecy (PFS) mode enabled; otherwise, the initiator should make the
///                    connection with PFS mode disabled. </td> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED"></a><a id="iscsi_security_flag_aggressive_mode_enabled"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the
///                    initiator should make the connection with aggressive mode enabled. Caller should set this flag or the
///                    ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED flag, but not both. <div class="alert"><b>Note</b> The Microsoft software
///                    initiator driver does not support aggressive mode. </div> <div> </div> </td> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED"></a><a id="iscsi_security_flag_main_mode_enabled"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the initiator
///                    should make the connection with main mode enabled. Caller should set this flag or the
///                    ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED flag, but not both. </td> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_IKE_IPSEC_ENABLED"></a><a id="iscsi_security_flag_ike_ipsec_enabled"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_IKE_IPSEC_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the initiator
///                    should make the connection with the IKE/IPsec protocol enabled; otherwise, the IKE/IPsec protocol is disabled.
///                    </td> </tr> <tr> <td width="40%"><a id="ISCSI_SECURITY_FLAG_VALID"></a><a id="iscsi_security_flag_valid"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_VALID</b></dt> </dl> </td> <td width="60%"> When set to 1, the other mask values are
///                    valid; otherwise, the iSCSI initiator service will use bitmap values that were previously defined for the target
///                    portal, or if none are available, the initiator service uses the default values defined in the registry. </td>
///                    </tr> </table>
///    Portal = A pointer to a structure of type ISCSI_TARGET_PORTAL that indicates the portal to which SendTargets will be sent
///             for target discovery.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint AddIScsiSendTargetPortalA(const(char)* InitiatorInstance, uint InitiatorPortNumber, 
                               ISCSI_LOGIN_OPTIONS* LoginOptions, ulong SecurityFlags, ISCSI_TARGET_PORTALA* Portal);

///The <b>RemoveIscsiSendTargetPortal</b> function removes a portal from the list of portals to which the iSCSI
///initiator service sends <b>SendTargets</b> requests for target discovery.
///Params:
///    InitiatorInstance = The name of the Host Bus Adapter (HBA) that the iSCSI initiator service uses to establish a discovery session and
///                        perform <b>SendTargets</b> requests. A value of <b>null</b> indicates that the iSCSI initiator service will use
///                        any HBA that is capable of accessing the target portal.
///    InitiatorPortNumber = The port number on the HBA that the iSCSI initiator service use to perform <b>SendTargets</b> requests.
///    Portal = A pointer to a structure of type ISCSI_TARGET_PORTAL that specifies the target portal that the iSCSI initiator
///             service removes from its list of portals.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint RemoveIScsiSendTargetPortalW(const(wchar)* InitiatorInstance, uint InitiatorPortNumber, 
                                  ISCSI_TARGET_PORTALW* Portal);

///The <b>RemoveIscsiSendTargetPortal</b> function removes a portal from the list of portals to which the iSCSI
///initiator service sends <b>SendTargets</b> requests for target discovery.
///Params:
///    InitiatorInstance = The name of the Host Bus Adapter (HBA) that the iSCSI initiator service uses to establish a discovery session and
///                        perform <b>SendTargets</b> requests. A value of <b>null</b> indicates that the iSCSI initiator service will use
///                        any HBA that is capable of accessing the target portal.
///    InitiatorPortNumber = The port number on the HBA that the iSCSI initiator service use to perform <b>SendTargets</b> requests.
///    Portal = A pointer to a structure of type ISCSI_TARGET_PORTAL that specifies the target portal that the iSCSI initiator
///             service removes from its list of portals.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint RemoveIScsiSendTargetPortalA(const(char)* InitiatorInstance, uint InitiatorPortNumber, 
                                  ISCSI_TARGET_PORTALA* Portal);

///The <b>RefreshIscsiSendTargetPortal</b> function instructs the iSCSI initiator service to establish a discovery
///session with the indicated target portal and transmit a <b>SendTargets</b> request to refresh the list of discovered
///targets for the iSCSI initiator service.
///Params:
///    InitiatorInstance = The name of the Host Bus Adapter (HBA) to use for the <b>SendTargets</b> request. If <b>null</b>, the iSCSI
///                        initiator service uses any HBA that can reach the indicated target portal is chosen.
///    InitiatorPortNumber = The port number on the HBA to use for the <b>SendTargets</b> request. If the value is
///                          <b>ISCSI_ALL_INITIATOR_PORTS</b>, the initiator HBA will choose the appropriate port based upon current routing
///                          information.
///    Portal = A pointer to a structure of type ISCSI_TARGET_PORTAL indicating the portal to which the iSCSI initiator service
///             sends the <b>SendTargets</b> request to refresh the list of targets.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint RefreshIScsiSendTargetPortalW(const(wchar)* InitiatorInstance, uint InitiatorPortNumber, 
                                   ISCSI_TARGET_PORTALW* Portal);

///The <b>RefreshIscsiSendTargetPortal</b> function instructs the iSCSI initiator service to establish a discovery
///session with the indicated target portal and transmit a <b>SendTargets</b> request to refresh the list of discovered
///targets for the iSCSI initiator service.
///Params:
///    InitiatorInstance = The name of the Host Bus Adapter (HBA) to use for the <b>SendTargets</b> request. If <b>null</b>, the iSCSI
///                        initiator service uses any HBA that can reach the indicated target portal is chosen.
///    InitiatorPortNumber = The port number on the HBA to use for the <b>SendTargets</b> request. If the value is
///                          <b>ISCSI_ALL_INITIATOR_PORTS</b>, the initiator HBA will choose the appropriate port based upon current routing
///                          information.
///    Portal = A pointer to a structure of type ISCSI_TARGET_PORTAL indicating the portal to which the iSCSI initiator service
///             sends the <b>SendTargets</b> request to refresh the list of targets.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint RefreshIScsiSendTargetPortalA(const(char)* InitiatorInstance, uint InitiatorPortNumber, 
                                   ISCSI_TARGET_PORTALA* Portal);

///The <b>ReportIscsiSendTargetPortals</b> function retrieves a list of target portals that the iSCSI initiator service
///uses to perform automatic discovery with <b>SendTarget</b> requests.
///Params:
///    PortalCount = A pointer to a location that, on input, contains the number of entries in the <i>PortalInfo</i> array. On output,
///                  this parameter specifies the number of elements that contain return data.
///    PortalInfo = Pointer to an array of elements contained in ISCSI_TARGET_PORTAL_INFO structures that describe the portals that
///                 the iSCSI initiator service utilizes to perform discovery with <b>SendTargets</b> requests.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds and ERROR_INSUFFICIENT_BUFFER if the buffer size of Buffer is
///    insufficient to contain the output data.
///    
@DllImport("ISCSIDSC")
uint ReportIScsiSendTargetPortalsW(uint* PortalCount, ISCSI_TARGET_PORTAL_INFOW* PortalInfo);

///The <b>ReportIscsiSendTargetPortals</b> function retrieves a list of target portals that the iSCSI initiator service
///uses to perform automatic discovery with <b>SendTarget</b> requests.
///Params:
///    PortalCount = A pointer to a location that, on input, contains the number of entries in the <i>PortalInfo</i> array. On output,
///                  this parameter specifies the number of elements that contain return data.
///    PortalInfo = Pointer to an array of elements contained in ISCSI_TARGET_PORTAL_INFO structures that describe the portals that
///                 the iSCSI initiator service utilizes to perform discovery with <b>SendTargets</b> requests.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds and ERROR_INSUFFICIENT_BUFFER if the buffer size of Buffer is
///    insufficient to contain the output data.
///    
@DllImport("ISCSIDSC")
uint ReportIScsiSendTargetPortalsA(uint* PortalCount, ISCSI_TARGET_PORTAL_INFOA* PortalInfo);

///The <b>ReportIscsiSendTargetPortalsEx</b> function retrieves a list of static target portals that the iSCSI initiator
///service uses to perform automatic discovery with <b>SendTarget</b> requests.
///Params:
///    PortalCount = A pointer to a location that, on input, contains the number of entries in the <i>PortalInfo</i> array. On output,
///                  this parameter specifies the number of elements that contain return data.
///    PortalInfoSize = A pointer to a location that, on input, contains the byte-size of the buffer specified by <i>PortalInfo</i>. On
///                     output, this parameter specifies the number of bytes retrieved.
///    PortalInfo = Pointer to an array of elements contained in a ISCSI_TARGET_PORTAL_INFO_EX structure that describe the portals
///                 that the iSCSI initiator service utilizes to perform discovery with <b>SendTargets</b> requests.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds and ERROR_INSUFFICIENT_BUFFER if the size of the buffer at
///    <i>PortalInfo</i> is insufficient to contain the output data. Otherwise, <b>ReportIscsiSendTargetPortalsEx</b>
///    returns the appropriate Win32 or iSCSI error code on failure.
///    
@DllImport("ISCSIDSC")
uint ReportIScsiSendTargetPortalsExW(uint* PortalCount, uint* PortalInfoSize, 
                                     ISCSI_TARGET_PORTAL_INFO_EXW* PortalInfo);

///The <b>ReportIscsiSendTargetPortalsEx</b> function retrieves a list of static target portals that the iSCSI initiator
///service uses to perform automatic discovery with <b>SendTarget</b> requests.
///Params:
///    PortalCount = A pointer to a location that, on input, contains the number of entries in the <i>PortalInfo</i> array. On output,
///                  this parameter specifies the number of elements that contain return data.
///    PortalInfoSize = A pointer to a location that, on input, contains the byte-size of the buffer specified by <i>PortalInfo</i>. On
///                     output, this parameter specifies the number of bytes retrieved.
///    PortalInfo = Pointer to an array of elements contained in a ISCSI_TARGET_PORTAL_INFO_EX structure that describe the portals
///                 that the iSCSI initiator service utilizes to perform discovery with <b>SendTargets</b> requests.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds and ERROR_INSUFFICIENT_BUFFER if the size of the buffer at
///    <i>PortalInfo</i> is insufficient to contain the output data. Otherwise, <b>ReportIscsiSendTargetPortalsEx</b>
///    returns the appropriate Win32 or iSCSI error code on failure.
///    
@DllImport("ISCSIDSC")
uint ReportIScsiSendTargetPortalsExA(uint* PortalCount, uint* PortalInfoSize, 
                                     ISCSI_TARGET_PORTAL_INFO_EXA* PortalInfo);

///The <b>LoginIscsiTarget</b> function establishes a full featured login session with the indicated target.
///Params:
///    TargetName = The name of the target with which to establish a login session. The target must already exist in the list of
///                 discovered targets for the iSCSI initiator service.
///    IsInformationalSession = If <b>true</b>, the <b>LoginIscsiTarget</b> function establishes a login session, but the operation does not
///                             report the LUNs on the target to the "Plug and Play" Manager. If the login succeeds, management applications will
///                             be able to query the target for information with the SendScsiReportLuns and SendScsiReadCapacity functions, but
///                             the storage stack will not enumerate the target or load a driver for it. If <i>IsInformationalSession</i> is
///                             <b>false</b>, <b>LoginIscsiTarget</b> reports the LUNs associated with the target to the "Plug and Play" Manager,
///                             and the system loads drivers for the LUNs.
///    InitiatorInstance = The name of the initiator that logs in to the target. If <i>InitiatorName</i> is <b>null</b>, the iSCSI initiator
///                        service selects an initiator.
///    InitiatorPortNumber = The port number of the Host Bus Adapter (HBA) that initiates the login session. If this parameter is
///                          <b>ISCSI_ANY_INITIATOR_PORT</b>, the caller did not specify a port for the initiator HBA to use when logging in
///                          to the target. If <i>InitiatorName</i> is <b>null</b>, <i>InitiatorPortNumber</i> must be
///                          <b>ISCSI_ANY_INITIATOR_PORT</b>.
///    TargetPortal = Pointer to a structure of type ISCSI_TARGET_PORTAL that indicates the portal that the initiator uses to open the
///                   session. The specified portal must belong to a portal group that is associated with the <i>TargetName</i>. If
///                   <i>TargetPortal</i> is <b>null</b>, the iSCSI initiator service instructs the initiator to use any portal through
///                   which the target is accessible to the initiator. If the caller specifies the value for <i>TargetPortal</i>, the
///                   iSCSI initiator service will not verify that the <i>TargetPortal</i> is accessible to the initiator HBA.
///    SecurityFlags = A bitmap that specifies the characteristics of the IPsec connection that the initiator adds to the session. If an
///                    IPsec security policy between the initiator and the target portal is already configured as a result of the
///                    current portal group policy or a previous connection to the target, the existing configuration takes precedence
///                    over the configuration specified in <i>SecurityFlags</i>. If the ISCSI_SECURITY_FLAG_VALID flag is set to 0, the
///                    iSCSI initiator service uses default values for the security flags that are defined in the registry. Caller can
///                    set any of the following flags in the bitmap: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                    width="40%"><a id="ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED"></a><a
///                    id="iscsi_security_flag_tunnel_mode_preferred"></a><dl> <dt><b>ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED</b></dt>
///                    </dl> </td> <td width="60%"> When set to 1, the initiator should make the connection in IPsec tunnel mode. Caller
///                    should set this flag or the ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED flag, but not both. </td> </tr> <tr> <td
///                    width="40%"><a id="ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED"></a><a
///                    id="iscsi_security_flag_transport_mode_preferred"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED</b></dt> </dl> </td> <td width="60%"> When set to 1, the
///                    initiator should make the connection in IPsec transport mode. Caller should set this flag or the
///                    ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED flag, but not both. </td> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_PFS_ENABLED"></a><a id="iscsi_security_flag_pfs_enabled"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_PFS_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the initiator should
///                    make the connection with Perfect Forward Secrecy (PFS) mode enabled; otherwise, the initiator should make the
///                    connection with PFS mode disabled. </td> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED"></a><a id="iscsi_security_flag_aggressive_mode_enabled"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the
///                    initiator should make the connection with aggressive mode enabled. Caller should set this flag or the
///                    ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED flag, but not both. <div class="alert"><b>Note</b> The Microsoft software
///                    initiator driver does not support aggressive mode. </div> <div> </div> </td> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED"></a><a id="iscsi_security_flag_main_mode_enabled"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the initiator
///                    should make the connection with main mode enabled. Caller should set this flag or the
///                    ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED flag, but not both. </td> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_IKE_IPSEC_ENABLED"></a><a id="iscsi_security_flag_ike_ipsec_enabled"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_IKE_IPSEC_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the initiator
///                    should make the connection with the IKE/IPsec protocol enabled; otherwise, the IKE/IPsec protocol is disabled.
///                    </td> </tr> <tr> <td width="40%"><a id="ISCSI_SECURITY_FLAG_VALID"></a><a id="iscsi_security_flag_valid"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_VALID</b></dt> </dl> </td> <td width="60%"> When set to 1, the other mask values are
///                    valid; otherwise, the iSCSI initiator service will use bitmap values that were previously defined for the target
///                    portal, or if none are available, the initiator service uses the default values defined in the registry. </td>
///                    </tr> </table>
///    Mappings = An array of structures of type ISCSI_TARGET_MAPPING, each of which holds information that the initiator uses to
///               assign bus, target and LUN numbers to the devices that are associated with the target. If <i>Mappings</i> is
///               <b>null</b>, the initiator will select the bus, target and LUN numbers.
///    LoginOptions = A pointer to a structure of type ISCSI_LOGIN_OPTIONS that contains the options that specify the characteristics
///                   of the login session.
///    KeySize = The size, in bytes, of the target's preshared key specified by the <i>Key</i> parameter.
///    Key = A preshared key to use when logging in to the target portal that exposes this target. <div
///          class="alert"><b>Note</b> If an IPsec policy is already associated with the target portal, the IPsec settings in
///          this call are ignored.</div> <div> </div>
///    IsPersistent = If <b>true</b>, the initiator should save the characteristics of the login session in non-volatile storage, so
///                   that the information persists across restarts of the initiator device and reboots of the operating system. The
///                   initiator should not establish the login session until after saving the persistent data. Whenever the initiator
///                   device restarts, it should automatically attempt to re-establish the login session with the same characteristics.
///                   If <b>false</b>, the initiator device simply logs in to the target without saving the characteristics of the
///                   login session.
///    UniqueSessionId = A pointer to a structure of type ISCSI_UNIQUE_SESSION_ID that, on return, contains a unique session identifier
///                      for the login session.
///    UniqueConnectionId = A pointer to a structure of type ISCSI_UNIQUE_CONNECTION_ID that, on return, contains a unique connection
///                         identifier for the login session.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint LoginIScsiTargetW(const(wchar)* TargetName, ubyte IsInformationalSession, const(wchar)* InitiatorInstance, 
                       uint InitiatorPortNumber, ISCSI_TARGET_PORTALW* TargetPortal, ulong SecurityFlags, 
                       ISCSI_TARGET_MAPPINGW* Mappings, ISCSI_LOGIN_OPTIONS* LoginOptions, uint KeySize, 
                       const(char)* Key, ubyte IsPersistent, ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, 
                       ISCSI_UNIQUE_SESSION_ID* UniqueConnectionId);

///The <b>LoginIscsiTarget</b> function establishes a full featured login session with the indicated target.
///Params:
///    TargetName = The name of the target with which to establish a login session. The target must already exist in the list of
///                 discovered targets for the iSCSI initiator service.
///    IsInformationalSession = If <b>true</b>, the <b>LoginIscsiTarget</b> function establishes a login session, but the operation does not
///                             report the LUNs on the target to the "Plug and Play" Manager. If the login succeeds, management applications will
///                             be able to query the target for information with the SendScsiReportLuns and SendScsiReadCapacity functions, but
///                             the storage stack will not enumerate the target or load a driver for it. If <i>IsInformationalSession</i> is
///                             <b>false</b>, <b>LoginIscsiTarget</b> reports the LUNs associated with the target to the "Plug and Play" Manager,
///                             and the system loads drivers for the LUNs.
///    InitiatorInstance = The name of the initiator that logs in to the target. If <i>InitiatorName</i> is <b>null</b>, the iSCSI initiator
///                        service selects an initiator.
///    InitiatorPortNumber = The port number of the Host Bus Adapter (HBA) that initiates the login session. If this parameter is
///                          <b>ISCSI_ANY_INITIATOR_PORT</b>, the caller did not specify a port for the initiator HBA to use when logging in
///                          to the target. If <i>InitiatorName</i> is <b>null</b>, <i>InitiatorPortNumber</i> must be
///                          <b>ISCSI_ANY_INITIATOR_PORT</b>.
///    TargetPortal = Pointer to a structure of type ISCSI_TARGET_PORTAL that indicates the portal that the initiator uses to open the
///                   session. The specified portal must belong to a portal group that is associated with the <i>TargetName</i>. If
///                   <i>TargetPortal</i> is <b>null</b>, the iSCSI initiator service instructs the initiator to use any portal through
///                   which the target is accessible to the initiator. If the caller specifies the value for <i>TargetPortal</i>, the
///                   iSCSI initiator service will not verify that the <i>TargetPortal</i> is accessible to the initiator HBA.
///    SecurityFlags = A bitmap that specifies the characteristics of the IPsec connection that the initiator adds to the session. If an
///                    IPsec security policy between the initiator and the target portal is already configured as a result of the
///                    current portal group policy or a previous connection to the target, the existing configuration takes precedence
///                    over the configuration specified in <i>SecurityFlags</i>. If the ISCSI_SECURITY_FLAG_VALID flag is set to 0, the
///                    iSCSI initiator service uses default values for the security flags that are defined in the registry. Caller can
///                    set any of the following flags in the bitmap: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                    width="40%"><a id="ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED"></a><a
///                    id="iscsi_security_flag_tunnel_mode_preferred"></a><dl> <dt><b>ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED</b></dt>
///                    </dl> </td> <td width="60%"> When set to 1, the initiator should make the connection in IPsec tunnel mode. Caller
///                    should set this flag or the ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED flag, but not both. </td> </tr> <tr> <td
///                    width="40%"><a id="ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED"></a><a
///                    id="iscsi_security_flag_transport_mode_preferred"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_TRANSPORT_MODE_PREFERRED</b></dt> </dl> </td> <td width="60%"> When set to 1, the
///                    initiator should make the connection in IPsec transport mode. Caller should set this flag or the
///                    ISCSI_SECURITY_FLAG_TUNNEL_MODE_PREFERRED flag, but not both. </td> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_PFS_ENABLED"></a><a id="iscsi_security_flag_pfs_enabled"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_PFS_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the initiator should
///                    make the connection with Perfect Forward Secrecy (PFS) mode enabled; otherwise, the initiator should make the
///                    connection with PFS mode disabled. </td> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED"></a><a id="iscsi_security_flag_aggressive_mode_enabled"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the
///                    initiator should make the connection with aggressive mode enabled. Caller should set this flag or the
///                    ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED flag, but not both. <div class="alert"><b>Note</b> The Microsoft software
///                    initiator driver does not support aggressive mode. </div> <div> </div> </td> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED"></a><a id="iscsi_security_flag_main_mode_enabled"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_MAIN_MODE_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the initiator
///                    should make the connection with main mode enabled. Caller should set this flag or the
///                    ISCSI_SECURITY_FLAG_AGGRESSIVE_MODE_ENABLED flag, but not both. </td> </tr> <tr> <td width="40%"><a
///                    id="ISCSI_SECURITY_FLAG_IKE_IPSEC_ENABLED"></a><a id="iscsi_security_flag_ike_ipsec_enabled"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_IKE_IPSEC_ENABLED</b></dt> </dl> </td> <td width="60%"> When set to 1, the initiator
///                    should make the connection with the IKE/IPsec protocol enabled; otherwise, the IKE/IPsec protocol is disabled.
///                    </td> </tr> <tr> <td width="40%"><a id="ISCSI_SECURITY_FLAG_VALID"></a><a id="iscsi_security_flag_valid"></a><dl>
///                    <dt><b>ISCSI_SECURITY_FLAG_VALID</b></dt> </dl> </td> <td width="60%"> When set to 1, the other mask values are
///                    valid; otherwise, the iSCSI initiator service will use bitmap values that were previously defined for the target
///                    portal, or if none are available, the initiator service uses the default values defined in the registry. </td>
///                    </tr> </table>
///    Mappings = An array of structures of type ISCSI_TARGET_MAPPING, each of which holds information that the initiator uses to
///               assign bus, target and LUN numbers to the devices that are associated with the target. If <i>Mappings</i> is
///               <b>null</b>, the initiator will select the bus, target and LUN numbers.
///    LoginOptions = A pointer to a structure of type ISCSI_LOGIN_OPTIONS that contains the options that specify the characteristics
///                   of the login session.
///    KeySize = The size, in bytes, of the target's preshared key specified by the <i>Key</i> parameter.
///    Key = A preshared key to use when logging in to the target portal that exposes this target. <div
///          class="alert"><b>Note</b> If an IPsec policy is already associated with the target portal, the IPsec settings in
///          this call are ignored.</div> <div> </div>
///    IsPersistent = If <b>true</b>, the initiator should save the characteristics of the login session in non-volatile storage, so
///                   that the information persists across restarts of the initiator device and reboots of the operating system. The
///                   initiator should not establish the login session until after saving the persistent data. Whenever the initiator
///                   device restarts, it should automatically attempt to re-establish the login session with the same characteristics.
///                   If <b>false</b>, the initiator device simply logs in to the target without saving the characteristics of the
///                   login session.
///    UniqueSessionId = A pointer to a structure of type ISCSI_UNIQUE_SESSION_ID that, on return, contains a unique session identifier
///                      for the login session.
///    UniqueConnectionId = A pointer to a structure of type ISCSI_UNIQUE_CONNECTION_ID that, on return, contains a unique connection
///                         identifier for the login session.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint LoginIScsiTargetA(const(char)* TargetName, ubyte IsInformationalSession, const(char)* InitiatorInstance, 
                       uint InitiatorPortNumber, ISCSI_TARGET_PORTALA* TargetPortal, ulong SecurityFlags, 
                       ISCSI_TARGET_MAPPINGA* Mappings, ISCSI_LOGIN_OPTIONS* LoginOptions, uint KeySize, 
                       const(char)* Key, ubyte IsPersistent, ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, 
                       ISCSI_UNIQUE_SESSION_ID* UniqueConnectionId);

///The <b>ReportIscsiPersistentLogins</b> function retrieves the list of persistent login targets.
///Params:
///    Count = A pointer to the location that receives a count of the elements specified by <i>PersistentLoginInfo</i>.
///    PersistentLoginInfo = An array of PERSISTENT_ISCSI_LOGIN_INFO structures that, on output, describe the persistent login targets.
///    BufferSizeInBytes = A pointer to a location that, on input, contains the byte-size of the buffer space that
///                        <i>PersistentLoginInfo</i> specifies. If the buffer size is insufficient, this parameter specifies what is
///                        required to contain the output data.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds and ERROR_INSUFFICIENT_BUFFER if the buffer specified by
///    <i>PersistentLoginInfo</i> is insufficient to contain the output data. Otherwise,
///    <b>ReportIscsiPersistentLogins</b> returns the appropriate Win32 or iSCSI error code on failure.
///    
@DllImport("ISCSIDSC")
uint ReportIScsiPersistentLoginsW(uint* Count, PERSISTENT_ISCSI_LOGIN_INFOW* PersistentLoginInfo, 
                                  uint* BufferSizeInBytes);

///The <b>ReportIscsiPersistentLogins</b> function retrieves the list of persistent login targets.
///Params:
///    Count = A pointer to the location that receives a count of the elements specified by <i>PersistentLoginInfo</i>.
///    PersistentLoginInfo = An array of PERSISTENT_ISCSI_LOGIN_INFO structures that, on output, describe the persistent login targets.
///    BufferSizeInBytes = A pointer to a location that, on input, contains the byte-size of the buffer space that
///                        <i>PersistentLoginInfo</i> specifies. If the buffer size is insufficient, this parameter specifies what is
///                        required to contain the output data.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds and ERROR_INSUFFICIENT_BUFFER if the buffer specified by
///    <i>PersistentLoginInfo</i> is insufficient to contain the output data. Otherwise,
///    <b>ReportIscsiPersistentLogins</b> returns the appropriate Win32 or iSCSI error code on failure.
///    
@DllImport("ISCSIDSC")
uint ReportIScsiPersistentLoginsA(uint* Count, PERSISTENT_ISCSI_LOGIN_INFOA* PersistentLoginInfo, 
                                  uint* BufferSizeInBytes);

///The <b>LogoutIscsiTarget</b> routine closes the specified login session.
///Params:
///    UniqueSessionId = A pointer to a structure of type ISCSI_UNIQUE_SESSION_ID that contains a unique session identifier for the login
///                      session end.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint LogoutIScsiTarget(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId);

///The <b>RemoveIscsiPersistentTarget</b> function removes a persistent login for the specified hardware initiator Host
///Bus Adapter (HBA), initiator port, and target portal.
///Params:
///    InitiatorInstance = The name of the initiator that maintains the persistent login to remove.
///    InitiatorPortNumber = The port number on which the initiator connects to <i>TargetName</i>. If <i>InitiatorPortNumber</i> is
///                          <b>ISCSI_ALL_INITIATOR_PORTS</b> the miniport driver for the initiator HBA removes the <i>TargetName</i> from the
///                          persistent login lists for all initiator ports.
///    TargetName = The name of the target.
///    Portal = The portal through which the initiator connects to the target. If <i>Portal</i> is <b>null</b> or contains no
///             information, the miniport driver for the initiator HBA removes persistent logins for the target on all portals.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint RemoveIScsiPersistentTargetW(const(wchar)* InitiatorInstance, uint InitiatorPortNumber, 
                                  const(wchar)* TargetName, ISCSI_TARGET_PORTALW* Portal);

///The <b>RemoveIscsiPersistentTarget</b> function removes a persistent login for the specified hardware initiator Host
///Bus Adapter (HBA), initiator port, and target portal.
///Params:
///    InitiatorInstance = The name of the initiator that maintains the persistent login to remove.
///    InitiatorPortNumber = The port number on which the initiator connects to <i>TargetName</i>. If <i>InitiatorPortNumber</i> is
///                          <b>ISCSI_ALL_INITIATOR_PORTS</b> the miniport driver for the initiator HBA removes the <i>TargetName</i> from the
///                          persistent login lists for all initiator ports.
///    TargetName = The name of the target.
///    Portal = The portal through which the initiator connects to the target. If <i>Portal</i> is <b>null</b> or contains no
///             information, the miniport driver for the initiator HBA removes persistent logins for the target on all portals.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint RemoveIScsiPersistentTargetA(const(char)* InitiatorInstance, uint InitiatorPortNumber, 
                                  const(char)* TargetName, ISCSI_TARGET_PORTALA* Portal);

///The <b>SendScsiInquiry</b> function sends a SCSI INQUIRY command to the specified target.
///Params:
///    UniqueSessionId = A pointer to a ISCSI_UNIQUE_SESSION_ID structure containing the session identifier for the login session specific
///                      to the target to which the READ CAPACITY command is sent.
///    Lun = The logical unit to query for SCSI inquiry data.
///    EvpdCmddt = The values to assign to the EVP (enable the vital product data) and CmdDt (command support data) bits in the
///                INQUIRY command. Bits 0 (EVP) and 1 (CmdDt) of the <i>EvpdCmddt</i> parameter are inserted into bits 0 and 1,
///                respectively, of the second byte of the Command Descriptor Block (CDB) of the <b>INQUIRY</b> command.
///    PageCode = The page code. This code is inserted into the third byte of the CDB of the <b>INQUIRY</b> command.
///    ScsiStatus = A pointer to a location that reports the execution status of the CDB.
///    ResponseSize = A pointer to the location that, on input, specifies the byte-size of <i>ResponseBuffer</i>. On output, this
///                   location specifies the number of bytes required to contain the response data for the READ CAPACITY command in the
///                   <i>ResponseBuffer</i>.
///    ResponseBuffer = The buffer that holds the inquiry data.
///    SenseSize = A pointer to a location that, on input, contains the byte-size of <i>SenseBuffer</i>. On output, the location
///                pointed to receives the byte-size required for <i>SenseBuffer</i> to contain the sense data. This value will
///                always be greater than or equal to 18 bytes.
///    SenseBuffer = The buffer that holds the sense data.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds and ERROR_INSUFFICIENT_BUFFER if the buffer specified by
///    <i>ResponseBuffer</i> is insufficient to contain the sense data. If the device returns a SCSI error while
///    processing the REPORT LUNS request, SendScsiReportLuns returns an error code of ISDSC_SCSI_REQUEST_FAILED, and
///    the locations pointed to by <i>ScsiStatus</i> and <i>SenseBuffer</i> contain information detailing the SCSI
///    error. Otherwise, <b>SendScsiInquiry</b> returns the appropriate Win32 or iSCSI error code on failure.
///    
@DllImport("ISCSIDSC")
uint SendScsiInquiry(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, ulong Lun, ubyte EvpdCmddt, ubyte PageCode, 
                     ubyte* ScsiStatus, uint* ResponseSize, ubyte* ResponseBuffer, uint* SenseSize, 
                     ubyte* SenseBuffer);

///The <b>SendScsiReadCapacity</b> function sends a SCSI READ CAPACITY command to the indicated target.
///Params:
///    UniqueSessionId = A pointer to a ISCSI_UNIQUE_SESSION_ID structure containing the session identifier for the login session specific
///                      to the target to which the READ CAPACITY command is sent.
///    Lun = The logical unit on the target to query with the READ CAPACITY command.
///    ScsiStatus = A pointer to a location that contains the execution status of the CDB.
///    ResponseSize = A pointer to the location that, on input, specifies the byte-size of <i>ResponseBuffer</i>. On output, this
///                   location specifies the number of bytes required to contain the response data for the READ CAPACITY command in the
///                   <i>ResponseBuffer</i>.
///    ResponseBuffer = The buffer that receives the response data from the READ CAPACITY command.
///    SenseSize = A pointer to a location that, on input, contains the byte-size of <i>SenseBuffer</i>. On output, the location
///                pointed to receives the byte-size required for <i>SenseBuffer</i> to contain the sense data. This value will
///                always be greater than or equal to 18 bytes.
///    SenseBuffer = The buffer that receives the sense data.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds and ERROR_INSUFFICIENT_BUFFER if the buffer specified by
///    <i>ResponseBuffer</i> is insufficient to contain the sense data. If the device returns a SCSI error while
///    processing the REPORT LUNS request, SendScsiReportLuns returns an error code of ISDSC_SCSI_REQUEST_FAILED, and
///    the locations pointed to by <i>ScsiStatus</i> and <i>SenseBuffer</i> contain information detailing the SCSI
///    error. Otherwise, this function returns the appropriate Win32 or iSCSI error code on failure.
///    
@DllImport("ISCSIDSC")
uint SendScsiReadCapacity(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, ulong Lun, ubyte* ScsiStatus, 
                          uint* ResponseSize, ubyte* ResponseBuffer, uint* SenseSize, ubyte* SenseBuffer);

///<b>SendScsiReportLuns</b> function sends a SCSI REPORT LUNS command to a specified target.
///Params:
///    UniqueSessionId = A pointer to a ISCSI_UNIQUE_SESSION_ID structure that contains the session identifier for the login session of
///                      the target to query with the SCSI REPORT LUNS command.
///    ScsiStatus = A pointer to the location that receives the execution status of the CDB.
///    ResponseSize = A pointer to the location that, on input, specifies the byte-size of <i>ResponseBuffer</i>. On output, this
///                   location specifies the number of bytes required to contain the response data for the READ CAPACITY command in the
///                   <i>ResponseBuffer</i>.
///    ResponseBuffer = The buffer that receives response data for the READ CAPACITY command.
///    SenseSize = A pointer to a location that, on input, contains the byte-size of <i>SenseBuffer</i>. On output, the location
///                pointed to receives the byte-size required for <i>SenseBuffer</i> to contain the sense data. This value will
///                always be greater than or equal to 18 bytes.
///    SenseBuffer = The buffer that receives the sense data.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds and ERROR_INSUFFICIENT_BUFFER if the buffer specified by
///    <i>ResponseBuffer</i> is insufficient to hold the sense data. If the device returns a SCSI error while processing
///    the REPORT LUNS request, <b>SendScsiReportLuns</b> returns an error code of ISDSC_SCSI_REQUEST_FAILED, and the
///    locations pointed to by <i>ScsiStatus</i> and <i>SenseBuffer</i> contain information detailing the SCSI error.
///    Otherwise, this function returns the appropriate Win32 or iSCSI error code on failure.
///    
@DllImport("ISCSIDSC")
uint SendScsiReportLuns(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, ubyte* ScsiStatus, uint* ResponseSize, 
                        ubyte* ResponseBuffer, uint* SenseSize, ubyte* SenseBuffer);

///The <b>ReportIscsiInitiatorList</b> function retrieves the list of initiator Host Bus Adapters that are running on
///the machine.
///Params:
///    BufferSize = A <b>ULONG</b> value that specifies the number of list elements contained by the <i>Buffer</i> parameter. If the
///                 operation succeeds, this location receives the size, represented by a number of elements, that corresponds to the
///                 retreived data.
///    Buffer = A buffer that, on output, is filled with the list of initiator names. Each initiator name is a
///             <b>null</b>-terminated string, except for the last initiator name, which is double-<b>null</b> terminated.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds and ERROR_INSUFFICIENT_BUFFER if the buffer size of Buffer is
///    insufficient to contain the output data. Otherwise, <b>ReportIscsiInitiatorList</b> returns the appropriate Win32
///    or iSCSI error code on failure.
///    
@DllImport("ISCSIDSC")
uint ReportIScsiInitiatorListW(uint* BufferSize, const(wchar)* Buffer);

///The <b>ReportIscsiInitiatorList</b> function retrieves the list of initiator Host Bus Adapters that are running on
///the machine.
///Params:
///    BufferSize = A <b>ULONG</b> value that specifies the number of list elements contained by the <i>Buffer</i> parameter. If the
///                 operation succeeds, this location receives the size, represented by a number of elements, that corresponds to the
///                 retreived data.
///    Buffer = A buffer that, on output, is filled with the list of initiator names. Each initiator name is a
///             <b>null</b>-terminated string, except for the last initiator name, which is double-<b>null</b> terminated.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds and ERROR_INSUFFICIENT_BUFFER if the buffer size of Buffer is
///    insufficient to contain the output data. Otherwise, <b>ReportIscsiInitiatorList</b> returns the appropriate Win32
///    or iSCSI error code on failure.
///    
@DllImport("ISCSIDSC")
uint ReportIScsiInitiatorListA(uint* BufferSize, const(char)* Buffer);

///<b>ReportActiveIscsiTargetMappings</b> function retrieves the target mappings that are currently active for all
///initiators on the computer.
///Params:
///    BufferSize = A pointer to a location that, on input, contains the size, in bytes, of the buffer that <i>Mappings</i> points
///                 to. If the operation succeeds, the location receives the size, in bytes, of the mapping data that was retrieved.
///                 If the buffer that <i>Mappings</i> points to is not sufficient to contain the output data, the location receives
///                 the buffer size, in bytes, that is required.
///    MappingCount = If the operation succeeds, the location pointed to by <i>MappingCount</i> receives the number of mappings that
///                   were retrieved.
///    Mappings = A pointer to an array of type ISCSI_TARGET_MAPPING that, on output, is filled with the active target mappings for
///               all initiators.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds and ERROR_INSUFFICIENT_BUFFER if the buffer is not large enough.
///    Otherwise, <b>ReportActiveIscsiTargetMappings</b> returns the appropriate Win32 or iSCSI error code on failure.
///    
@DllImport("ISCSIDSC")
uint ReportActiveIScsiTargetMappingsW(uint* BufferSize, uint* MappingCount, ISCSI_TARGET_MAPPINGW* Mappings);

///<b>ReportActiveIscsiTargetMappings</b> function retrieves the target mappings that are currently active for all
///initiators on the computer.
///Params:
///    BufferSize = A pointer to a location that, on input, contains the size, in bytes, of the buffer that <i>Mappings</i> points
///                 to. If the operation succeeds, the location receives the size, in bytes, of the mapping data that was retrieved.
///                 If the buffer that <i>Mappings</i> points to is not sufficient to contain the output data, the location receives
///                 the buffer size, in bytes, that is required.
///    MappingCount = If the operation succeeds, the location pointed to by <i>MappingCount</i> receives the number of mappings that
///                   were retrieved.
///    Mappings = A pointer to an array of type ISCSI_TARGET_MAPPING that, on output, is filled with the active target mappings for
///               all initiators.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds and ERROR_INSUFFICIENT_BUFFER if the buffer is not large enough.
///    Otherwise, <b>ReportActiveIscsiTargetMappings</b> returns the appropriate Win32 or iSCSI error code on failure.
///    
@DllImport("ISCSIDSC")
uint ReportActiveIScsiTargetMappingsA(uint* BufferSize, uint* MappingCount, ISCSI_TARGET_MAPPINGA* Mappings);

///<b>SetIscsiTunnelModeOuterAddress</b> function establishes the tunnel-mode outer address that the indicated initiator
///Host Bus Adapter (HBA) uses when communicating in IPsec tunnel mode through the specified port.
///Params:
///    InitiatorName = The name of the initiator with which the tunnel-mode outer address will be associated. If this parameter is
///                    <b>null</b>, all HBA initiators are configured to use the indicated tunnel-mode outer address.
///    InitiatorPortNumber = Indicates the number of the port with which the tunnel-mode outer address is associated. If this parameter
///                          contains <b>ISCSI_ALL_PORTS</b>, all ports on the indicated initiator are associated with the tunnel-mode outer
///                          address.
///    DestinationAddress = The destination address to associate with the tunnel-mode outer address indicated by <i>OuterModeAddress</i>.
///    OuterModeAddress = The tunnel-mode outer address to associate with indicated initiators and ports.
///    Persist = When <b>true</b>, this parameter indicates that the iSCSI initiator service stores the tunnel-mode outer address
///              in non-volatile memory and that the address will persist across restarts of the initiator and the iSCSI initiator
///              service.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds.Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint SetIScsiTunnelModeOuterAddressW(const(wchar)* InitiatorName, uint InitiatorPortNumber, 
                                     const(wchar)* DestinationAddress, const(wchar)* OuterModeAddress, ubyte Persist);

///<b>SetIscsiTunnelModeOuterAddress</b> function establishes the tunnel-mode outer address that the indicated initiator
///Host Bus Adapter (HBA) uses when communicating in IPsec tunnel mode through the specified port.
///Params:
///    InitiatorName = The name of the initiator with which the tunnel-mode outer address will be associated. If this parameter is
///                    <b>null</b>, all HBA initiators are configured to use the indicated tunnel-mode outer address.
///    InitiatorPortNumber = Indicates the number of the port with which the tunnel-mode outer address is associated. If this parameter
///                          contains <b>ISCSI_ALL_PORTS</b>, all ports on the indicated initiator are associated with the tunnel-mode outer
///                          address.
///    DestinationAddress = The destination address to associate with the tunnel-mode outer address indicated by <i>OuterModeAddress</i>.
///    OuterModeAddress = The tunnel-mode outer address to associate with indicated initiators and ports.
///    Persist = When <b>true</b>, this parameter indicates that the iSCSI initiator service stores the tunnel-mode outer address
///              in non-volatile memory and that the address will persist across restarts of the initiator and the iSCSI initiator
///              service.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds.Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint SetIScsiTunnelModeOuterAddressA(const(char)* InitiatorName, uint InitiatorPortNumber, 
                                     const(char)* DestinationAddress, const(char)* OuterModeAddress, ubyte Persist);

///The <b>SetIscsiIKEInfo</b> function establishes the IPsec policy and preshared key for the indicated initiator to use
///when performing iSCSI connections.
///Params:
///    InitiatorName = The name of the initiator HBA for which the IPsec policy is established.
///    InitiatorPortNumber = The port on the initiator HBA with which to associate the key. If this parameter contains a value of
///                          <b>ISCSI_ALL_INITIATOR_PORTS</b>, all ports on the initiator are associated with the key.
///    AuthInfo = A pointer to a IKE_AUTHENTICATION_INFORMATION structure that contains the authentication method. Currently, only
///               the IKE_AUTHENTICATION_PRESHARED_KEY_METHOD is supported.
///    Persist = If <b>true</b>, this parameter indicates that the preshared key information will be stored in non-volatile memory
///              and will persist across restarts of the computer or the iSCSI initiator service.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint SetIScsiIKEInfoW(const(wchar)* InitiatorName, uint InitiatorPortNumber, 
                      IKE_AUTHENTICATION_INFORMATION* AuthInfo, ubyte Persist);

///The <b>SetIscsiIKEInfo</b> function establishes the IPsec policy and preshared key for the indicated initiator to use
///when performing iSCSI connections.
///Params:
///    InitiatorName = The name of the initiator HBA for which the IPsec policy is established.
///    InitiatorPortNumber = The port on the initiator HBA with which to associate the key. If this parameter contains a value of
///                          <b>ISCSI_ALL_INITIATOR_PORTS</b>, all ports on the initiator are associated with the key.
///    AuthInfo = A pointer to a IKE_AUTHENTICATION_INFORMATION structure that contains the authentication method. Currently, only
///               the IKE_AUTHENTICATION_PRESHARED_KEY_METHOD is supported.
///    Persist = If <b>true</b>, this parameter indicates that the preshared key information will be stored in non-volatile memory
///              and will persist across restarts of the computer or the iSCSI initiator service.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint SetIScsiIKEInfoA(const(char)* InitiatorName, uint InitiatorPortNumber, 
                      IKE_AUTHENTICATION_INFORMATION* AuthInfo, ubyte Persist);

///The <b>GetIscsiIKEInfo</b> function retrieves the IPsec policy and any established pre-shared key values associated
///with an initiator Host-Bus Adapter (HBA).
///Params:
///    InitiatorName = A string that represents the name of the initiator HBA for which the IPsec policy is established.
///    InitiatorPortNumber = A <b>ULONG</b> value that represents the port on the initiator HBA with which to associate the key. If this
///                          parameter specifies a value of <b>ISCSI_ALL_INITIATOR_PORTS</b>, all ports on the initiator are associated with
///                          the key.
///    Reserved = This value is reserved.
///    AuthInfo = A pointer to an IKE_AUTHENTICATION_INFORMATION structure that contains data specifying the authentication method.
///               Currently, only the <b>IKE_AUTHENTICATION_PRESHARED_KEY_METHOD</b> is supported.
///Returns:
///    Returns ERROR_SUCCESS if the operation is successful. If the operation fails due to a socket connection error,
///    this function will return a Winsock error code.
///    
@DllImport("ISCSIDSC")
uint GetIScsiIKEInfoW(const(wchar)* InitiatorName, uint InitiatorPortNumber, uint* Reserved, 
                      IKE_AUTHENTICATION_INFORMATION* AuthInfo);

///The <b>GetIscsiIKEInfo</b> function retrieves the IPsec policy and any established pre-shared key values associated
///with an initiator Host-Bus Adapter (HBA).
///Params:
///    InitiatorName = A string that represents the name of the initiator HBA for which the IPsec policy is established.
///    InitiatorPortNumber = A <b>ULONG</b> value that represents the port on the initiator HBA with which to associate the key. If this
///                          parameter specifies a value of <b>ISCSI_ALL_INITIATOR_PORTS</b>, all ports on the initiator are associated with
///                          the key.
///    Reserved = This value is reserved.
///    AuthInfo = A pointer to an IKE_AUTHENTICATION_INFORMATION structure that contains data specifying the authentication method.
///               Currently, only the <b>IKE_AUTHENTICATION_PRESHARED_KEY_METHOD</b> is supported.
///Returns:
///    Returns ERROR_SUCCESS if the operation is successful. If the operation fails due to a socket connection error,
///    this function will return a Winsock error code.
///    
@DllImport("ISCSIDSC")
uint GetIScsiIKEInfoA(const(char)* InitiatorName, uint InitiatorPortNumber, uint* Reserved, 
                      IKE_AUTHENTICATION_INFORMATION* AuthInfo);

///The <b>SetIscsiGroupPresharedKey</b> function establishes the default group preshared key for all initiators on the
///computer.
///Params:
///    KeyLength = The size, in bytes, of the preshared key.
///    Key = The buffer that contains the preshared key.
///    Persist = If <b>true</b>, this parameter indicates that the preshared key information will be stored in non-volatile memory
///              and will persist across restarts of the computer or the iSCSI initiator service.
@DllImport("ISCSIDSC")
uint SetIScsiGroupPresharedKey(uint KeyLength, ubyte* Key, ubyte Persist);

///The <b>SetIscsiInitiatorCHAPSharedSecret</b> function establishes the default Challenge Handshake Authentication
///Protocol (CHAP) shared secret for all initiators on the computer.
///Params:
///    SharedSecretLength = The size, in bytes, of the shared secret contained by the buffer specified by <i>SharedSecret</i>. The shared
///                         secret must be at least 96 bits (12 bytes) for non-IPsec connections, at least 8 bits (1 byte) for IPsec
///                         connections, and less than 128 bits (16 bytes) for all connection types.
///    SharedSecret = The buffer that contains the shared secret.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint SetIScsiInitiatorCHAPSharedSecret(uint SharedSecretLength, ubyte* SharedSecret);

///The <b>SetIscsiInitiatorRADIUSSharedSecret</b> function establishes the Remote Authentication Dial-In User Service
///(RADIUS) shared secret.
///Params:
///    SharedSecretLength = A <b>ULONG</b> value that represents the size, in bytes, of the shared secret contained by the buffer specified
///                         by SharedSecret. The shared secret must be at least 22 bytes, and less than, or equal to, 26 bytes in size.
///    SharedSecret = A string that specifies the buffer containing the shared secret.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if the operation is successful. If the operation fails due to a socket connection
///    error, this function will return a Winsock error code.
///    
@DllImport("ISCSIDSC")
uint SetIScsiInitiatorRADIUSSharedSecret(uint SharedSecretLength, ubyte* SharedSecret);

///The <b>SetIscsiInitiatorNodeName</b> function establishes an initiator node name for the computer. This name is
///utilized by any initiator nodes on the computer that are communicating with other nodes.
///Params:
///    InitiatorNodeName = The initiator node name. If this parameter is <b>null</b>, initiators use a default initiator node name based
///                        upon the computer name.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint SetIScsiInitiatorNodeNameW(const(wchar)* InitiatorNodeName);

///The <b>SetIscsiInitiatorNodeName</b> function establishes an initiator node name for the computer. This name is
///utilized by any initiator nodes on the computer that are communicating with other nodes.
///Params:
///    InitiatorNodeName = The initiator node name. If this parameter is <b>null</b>, initiators use a default initiator node name based
///                        upon the computer name.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint SetIScsiInitiatorNodeNameA(const(char)* InitiatorNodeName);

///The <b>GetIscsiInitiatorNodeName</b> function retrieves the common initiator node name that is used when establishing
///sessions from the local machine.
///Params:
///    InitiatorNodeName = A caller-allocated buffer that, on output, receives the node name. The buffer must be large enough to hold
///                        <b>MAX_ISCSI_NAME_LEN+1</b> bytes.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds and the appropriate Win32 or iSCSI error code if the operation
///    fails.
///    
@DllImport("ISCSIDSC")
uint GetIScsiInitiatorNodeNameW(const(wchar)* InitiatorNodeName);

///The <b>GetIscsiInitiatorNodeName</b> function retrieves the common initiator node name that is used when establishing
///sessions from the local machine.
///Params:
///    InitiatorNodeName = A caller-allocated buffer that, on output, receives the node name. The buffer must be large enough to hold
///                        <b>MAX_ISCSI_NAME_LEN+1</b> bytes.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds and the appropriate Win32 or iSCSI error code if the operation
///    fails.
///    
@DllImport("ISCSIDSC")
uint GetIScsiInitiatorNodeNameA(const(char)* InitiatorNodeName);

///The <b>AddIsnsServer</b> function adds a new server to the list of Internet Storage Name Service (iSNS) servers that
///the iSCSI initiator service uses to discover targets.
///Params:
///    Address = IP address or the DNS name of the server.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. If the operation fails, because of a problem with a socket
///    connection, <b>AddIsnsServer</b> returns a Winsock error code. If the Address parameter does not point to a valid
///    iSNS server name, the <b>AddIsnsServer</b> routine returns ERROR_INVALID_PARAMETER.
///    
@DllImport("ISCSIDSC")
uint AddISNSServerW(const(wchar)* Address);

///The <b>AddIsnsServer</b> function adds a new server to the list of Internet Storage Name Service (iSNS) servers that
///the iSCSI initiator service uses to discover targets.
///Params:
///    Address = IP address or the DNS name of the server.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. If the operation fails, because of a problem with a socket
///    connection, <b>AddIsnsServer</b> returns a Winsock error code. If the Address parameter does not point to a valid
///    iSNS server name, the <b>AddIsnsServer</b> routine returns ERROR_INVALID_PARAMETER.
///    
@DllImport("ISCSIDSC")
uint AddISNSServerA(const(char)* Address);

///The <b>RemoveIsnsServer</b> function removes a server from the list of Internet Storage Name Service (iSNS) servers
///that the iSCSI initiator service uses to discover targets.
///Params:
///    Address = The DNS or IP Address of the server to remove.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint RemoveISNSServerW(const(wchar)* Address);

///The <b>RemoveIsnsServer</b> function removes a server from the list of Internet Storage Name Service (iSNS) servers
///that the iSCSI initiator service uses to discover targets.
///Params:
///    Address = The DNS or IP Address of the server to remove.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint RemoveISNSServerA(const(char)* Address);

///The <b>RefreshIsnsServer</b> function instructs the iSCSI initiator service to query the indicated Internet Storage
///Name Service (iSNS) server to refresh the list of discovered targets for the iSCSI initiator service.
///Params:
///    Address = The DNS or IP Address of the iSNS server.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint RefreshISNSServerW(const(wchar)* Address);

///The <b>RefreshIsnsServer</b> function instructs the iSCSI initiator service to query the indicated Internet Storage
///Name Service (iSNS) server to refresh the list of discovered targets for the iSCSI initiator service.
///Params:
///    Address = The DNS or IP Address of the iSNS server.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint RefreshISNSServerA(const(char)* Address);

///The <b>ReportIsnsServerList</b> function retrieves the list of Internet Storage Name Service (iSNS) servers that the
///iSCSI initiator service queries for discovered targets.
///Params:
///    BufferSizeInChar = A <b>ULONG</b> value that specifies the number of list elements contained by the <i>Buffer</i> parameter. If the
///                       operation succeeds, this location receives the size, represented by a number of elements, that corresponds to the
///                       number of retrieved iSNS servrs.
///    Buffer = The buffer that holds the list of iSNS servers on output. Each server name is <b>null</b> terminated, except for
///             the last server name, which is double <b>null</b> terminated.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds and ERROR_INSUFFICIENT_BUFFER if the buffer is too small to hold
///    the output data. Otherwise, <b>ReportIsnsServerList</b> returns the appropriate Win32 or iSCSI error code on
///    failure.
///    
@DllImport("ISCSIDSC")
uint ReportISNSServerListW(uint* BufferSizeInChar, const(wchar)* Buffer);

///The <b>ReportIsnsServerList</b> function retrieves the list of Internet Storage Name Service (iSNS) servers that the
///iSCSI initiator service queries for discovered targets.
///Params:
///    BufferSizeInChar = A <b>ULONG</b> value that specifies the number of list elements contained by the <i>Buffer</i> parameter. If the
///                       operation succeeds, this location receives the size, represented by a number of elements, that corresponds to the
///                       number of retrieved iSNS servrs.
///    Buffer = The buffer that holds the list of iSNS servers on output. Each server name is <b>null</b> terminated, except for
///             the last server name, which is double <b>null</b> terminated.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds and ERROR_INSUFFICIENT_BUFFER if the buffer is too small to hold
///    the output data. Otherwise, <b>ReportIsnsServerList</b> returns the appropriate Win32 or iSCSI error code on
///    failure.
///    
@DllImport("ISCSIDSC")
uint ReportISNSServerListA(uint* BufferSizeInChar, const(char)* Buffer);

///The <b>GetIscsiSessionList</b> function retrieves the list of active iSCSI sessions.
///Params:
///    BufferSize = A pointer to a location that, on input, contains the size, in bytes, of the caller-allocated buffer that
///                 <i>SessionInfo</i> points to. If the operation succeeds, the location receives the size, in bytes, of the session
///                 information data that was retrieved. If the operation fails because the output buffer size was insufficient, the
///                 location receives the size, in bytes, of the buffer size required to contain the output data.
///    SessionCount = A pointer to a location that, on input, contains the number of ISCSI_SESSION_INFO structures that the buffer that
///                   <i>SessionInfo</i> points to can contain. If the operation succeeds, the location receives the number of
///                   <b>ISCSI_SESSION_INFO</b> structures that were retrieved.
///    SessionInfo = A pointer to a buffer that contains a series of contiguous structures of type ISCSI_SESSION_INFO that describe
///                  the active login sessions.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds and ERROR_INSUFFICIENT_BUFFER if the size of the buffer at
///    <i>SessionInfo</i> was insufficient to hold the output data. Otherwise, <b>GetIscsiSessionList</b> returns the
///    appropriate Win32 or iSCSI error code on failure.
///    
@DllImport("ISCSIDSC")
uint GetIScsiSessionListW(uint* BufferSize, uint* SessionCount, ISCSI_SESSION_INFOW* SessionInfo);

///The <b>GetIscsiSessionList</b> function retrieves the list of active iSCSI sessions.
///Params:
///    BufferSize = A pointer to a location that, on input, contains the size, in bytes, of the caller-allocated buffer that
///                 <i>SessionInfo</i> points to. If the operation succeeds, the location receives the size, in bytes, of the session
///                 information data that was retrieved. If the operation fails because the output buffer size was insufficient, the
///                 location receives the size, in bytes, of the buffer size required to contain the output data.
///    SessionCount = A pointer to a location that, on input, contains the number of ISCSI_SESSION_INFO structures that the buffer that
///                   <i>SessionInfo</i> points to can contain. If the operation succeeds, the location receives the number of
///                   <b>ISCSI_SESSION_INFO</b> structures that were retrieved.
///    SessionInfo = A pointer to a buffer that contains a series of contiguous structures of type ISCSI_SESSION_INFO that describe
///                  the active login sessions.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds and ERROR_INSUFFICIENT_BUFFER if the size of the buffer at
///    <i>SessionInfo</i> was insufficient to hold the output data. Otherwise, <b>GetIscsiSessionList</b> returns the
///    appropriate Win32 or iSCSI error code on failure.
///    
@DllImport("ISCSIDSC")
uint GetIScsiSessionListA(uint* BufferSize, uint* SessionCount, ISCSI_SESSION_INFOA* SessionInfo);

@DllImport("ISCSIDSC")
uint GetIScsiSessionListEx(uint* BufferSize, uint* SessionCountPtr, ISCSI_SESSION_INFO_EX* SessionInfo);

///The <b>GetDevicesForIscsiSession</b> function retrieves information about the devices associated with the current
///session.
///Params:
///    UniqueSessionId = A pointer to a structure of type ISCSI_UNIQUE_SESSION_ID that contains the session identifier for the session.
///    DeviceCount = A pointer to a location that, on input, contains the number of elements of type ISCSI_DEVICE_ON_SESSION that can
///                  fit in the buffer that <i>Devices</i> points to. If the operation succeeds, the location receives the number of
///                  elements retrieved. If <b>GetDevicesForIscsiSession</b> returns ERROR_INSUFFICIENT_BUFFER, the location still
///                  receives the number of elements the buffer is capable of containing.
///    Devices = An array of ISCSI_DEVICE_ON_SESSION-type structures that, on output, receives information about each device
///              associated with the session.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds and ERROR_INSUFFICIENT_BUFFER if the caller allocated
///    insufficient buffer space for the array in Devices. Otherwise, <b>GetDevicesForIscsiSession</b> returns the
///    appropriate Win32 or iSCSI error code on failure.
///    
@DllImport("ISCSIDSC")
uint GetDevicesForIScsiSessionW(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, uint* DeviceCount, 
                                ISCSI_DEVICE_ON_SESSIONW* Devices);

///The <b>GetDevicesForIscsiSession</b> function retrieves information about the devices associated with the current
///session.
///Params:
///    UniqueSessionId = A pointer to a structure of type ISCSI_UNIQUE_SESSION_ID that contains the session identifier for the session.
///    DeviceCount = A pointer to a location that, on input, contains the number of elements of type ISCSI_DEVICE_ON_SESSION that can
///                  fit in the buffer that <i>Devices</i> points to. If the operation succeeds, the location receives the number of
///                  elements retrieved. If <b>GetDevicesForIscsiSession</b> returns ERROR_INSUFFICIENT_BUFFER, the location still
///                  receives the number of elements the buffer is capable of containing.
///    Devices = An array of ISCSI_DEVICE_ON_SESSION-type structures that, on output, receives information about each device
///              associated with the session.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds and ERROR_INSUFFICIENT_BUFFER if the caller allocated
///    insufficient buffer space for the array in Devices. Otherwise, <b>GetDevicesForIscsiSession</b> returns the
///    appropriate Win32 or iSCSI error code on failure.
///    
@DllImport("ISCSIDSC")
uint GetDevicesForIScsiSessionA(ISCSI_UNIQUE_SESSION_ID* UniqueSessionId, uint* DeviceCount, 
                                ISCSI_DEVICE_ON_SESSIONA* Devices);

@DllImport("ISCSIDSC")
uint SetupPersistentIScsiVolumes();

///The <b>SetupPersistentIscsiDevices</b> function builds the list of devices and volumes assigned to iSCSI targets that
///are connected to the computer, and saves this list in non-volatile cache of the iSCSI initiator service.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns the appropriate Win32 or iSCSI error code.
///    
@DllImport("ISCSIDSC")
uint SetupPersistentIScsiDevices();

///The <b>AddPersistentIscsiDevice</b> function adds a volume device name, drive letter, or mount point symbolic link to
///the list of iSCSI persistently bound volumes and devices.
///Params:
///    DevicePath = A drive letter or symbolic link for a mount point of the volume.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns one of the following: <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ISDSC_DEVICE_NOT_ISCSI_OR_PERSISTENT</b></dt> </dl> </td> <td width="60%"> The volume or device is not
///    located on a iSCSI target or the session to the iSCSI target is not persistent. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ISDSC_VOLUME_ALREADY_PERSISTENTLY_BOUND</b></dt> </dl> </td> <td width="60%"> The volume or device is
///    already in the persistent volume or device list. </td> </tr> </table>
///    
@DllImport("ISCSIDSC")
uint AddPersistentIScsiDeviceW(const(wchar)* DevicePath);

///The <b>AddPersistentIscsiDevice</b> function adds a volume device name, drive letter, or mount point symbolic link to
///the list of iSCSI persistently bound volumes and devices.
///Params:
///    DevicePath = A drive letter or symbolic link for a mount point of the volume.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds. Otherwise, it returns one of the following: <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ISDSC_DEVICE_NOT_ISCSI_OR_PERSISTENT</b></dt> </dl> </td> <td width="60%"> The volume or device is not
///    located on a iSCSI target or the session to the iSCSI target is not persistent. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ISDSC_VOLUME_ALREADY_PERSISTENTLY_BOUND</b></dt> </dl> </td> <td width="60%"> The volume or device is
///    already in the persistent volume or device list. </td> </tr> </table>
///    
@DllImport("ISCSIDSC")
uint AddPersistentIScsiDeviceA(const(char)* DevicePath);

///The <b>RemovePersistentIscsiDevice</b> function removes a device or volume from the list of persistently bound iSCSI
///volumes.
///Params:
///    DevicePath = A drive letter, mount point, or device path for the volume or device.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds and ISDSC_DEVICE_NOT_FOUND if the volume that is specified by
///    <i>VolumePath</i> is not in the list of persistently bound volumes. Otherwise, <b>RemovePersistentIscsiDevice</b>
///    returns the appropriate Win32 or iSCSI error code on failure.
///    
@DllImport("ISCSIDSC")
uint RemovePersistentIScsiDeviceW(const(wchar)* DevicePath);

///The <b>RemovePersistentIscsiDevice</b> function removes a device or volume from the list of persistently bound iSCSI
///volumes.
///Params:
///    DevicePath = A drive letter, mount point, or device path for the volume or device.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds and ISDSC_DEVICE_NOT_FOUND if the volume that is specified by
///    <i>VolumePath</i> is not in the list of persistently bound volumes. Otherwise, <b>RemovePersistentIscsiDevice</b>
///    returns the appropriate Win32 or iSCSI error code on failure.
///    
@DllImport("ISCSIDSC")
uint RemovePersistentIScsiDeviceA(const(char)* DevicePath);

///The <b>ClearPersistentIscsiDevices</b> function removes all volumes and devices from the list of persistently bound
///iSCSI volumes.
///Returns:
///    returns ERROR_SUCCESS if the operation succeeds and the appropriate Win32 or iSCSI error code if the operation
///    fails.
///    
@DllImport("ISCSIDSC")
uint ClearPersistentIScsiDevices();

///The <b>ReportPersistentIscsiDevices</b> function retrieves the list of persistently bound volumes and devices.
///Params:
///    BufferSizeInChar = A <b>ULONG</b> value that specifies the number of list elements contained by the <i>Buffer</i> parameter.
///    Buffer = Pointer to a buffer that receives the list of volumes and devices that are persistently bound. The list consists
///             of <b>null</b>-terminated strings. The last string, however, is double <b>null</b>-terminated.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds or ERROR_INSUFFICIENT_BUFFER if the buffer was insufficient to
///    receive the output data. Otherwise, <b>ReportPersistentiScsiDevices</b> returns the appropriate Win32 or iSCSI
///    error code on failure.
///    
@DllImport("ISCSIDSC")
uint ReportPersistentIScsiDevicesW(uint* BufferSizeInChar, const(wchar)* Buffer);

///The <b>ReportPersistentIscsiDevices</b> function retrieves the list of persistently bound volumes and devices.
///Params:
///    BufferSizeInChar = A <b>ULONG</b> value that specifies the number of list elements contained by the <i>Buffer</i> parameter.
///    Buffer = Pointer to a buffer that receives the list of volumes and devices that are persistently bound. The list consists
///             of <b>null</b>-terminated strings. The last string, however, is double <b>null</b>-terminated.
///Returns:
///    Returns ERROR_SUCCESS if the operation succeeds or ERROR_INSUFFICIENT_BUFFER if the buffer was insufficient to
///    receive the output data. Otherwise, <b>ReportPersistentiScsiDevices</b> returns the appropriate Win32 or iSCSI
///    error code on failure.
///    
@DllImport("ISCSIDSC")
uint ReportPersistentIScsiDevicesA(uint* BufferSizeInChar, const(char)* Buffer);

///The <b>ReportIscsiTargetPortals</b> function retrieves target portal information discovered by the iSCSI initiator
///service.
///Params:
///    InitiatorName = A string that represents the name of the initiator node.
///    TargetName = A string that represents the name of the target for which the portal information is retrieved.
///    TargetPortalTag = A <b>USHORT</b> value that represents a tag associated with the portal.
///    ElementCount = A <b>ULONG</b> value that specifies the number of portals currently reported for the specified target.
///    Portals = A variable-length array of an <b>ISCSI_TARGET_PORTALW</b> structure. The number of elements contained in this
///              array is specified by the value of <i>ElementCount</i>.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if the operation is successful. If the operation fails due to a socket connection
///    error, this function will return a Winsock error code.
///    
@DllImport("ISCSIDSC")
uint ReportIScsiTargetPortalsW(const(wchar)* InitiatorName, const(wchar)* TargetName, ushort* TargetPortalTag, 
                               uint* ElementCount, ISCSI_TARGET_PORTALW* Portals);

///The <b>ReportIscsiTargetPortals</b> function retrieves target portal information discovered by the iSCSI initiator
///service.
///Params:
///    InitiatorName = A string that represents the name of the initiator node.
///    TargetName = A string that represents the name of the target for which the portal information is retrieved.
///    TargetPortalTag = A <b>USHORT</b> value that represents a tag associated with the portal.
///    ElementCount = A <b>ULONG</b> value that specifies the number of portals currently reported for the specified target.
///    Portals = A variable-length array of an <b>ISCSI_TARGET_PORTALW</b> structure. The number of elements contained in this
///              array is specified by the value of <i>ElementCount</i>.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if the operation is successful. If the operation fails due to a socket connection
///    error, this function will return a Winsock error code.
///    
@DllImport("ISCSIDSC")
uint ReportIScsiTargetPortalsA(const(char)* InitiatorName, const(char)* TargetName, ushort* TargetPortalTag, 
                               uint* ElementCount, ISCSI_TARGET_PORTALA* Portals);

///The <b>AddRadiusServer</b> function adds a new Remote Authentication Dial-In User Service (RADIUS) server to the list
///referenced by the iSCSI initiator service during authentication.
///Params:
///    Address = A string that represents the IP address or DNS name associated with the RADIUS server.
///Returns:
///    Returns ERROR_SUCCESS if the operation is successful. If the operation fails due to a socket connection error,
///    this function will return a Winsock error code. Other possible error values include: <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> The supplied <i>Address</i> is invalid. </td> </tr> </table>
///    
@DllImport("ISCSIDSC")
uint AddRadiusServerW(const(wchar)* Address);

///The <b>AddRadiusServer</b> function adds a new Remote Authentication Dial-In User Service (RADIUS) server to the list
///referenced by the iSCSI initiator service during authentication.
///Params:
///    Address = A string that represents the IP address or DNS name associated with the RADIUS server.
///Returns:
///    Returns ERROR_SUCCESS if the operation is successful. If the operation fails due to a socket connection error,
///    this function will return a Winsock error code. Other possible error values include: <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> The supplied <i>Address</i> is invalid. </td> </tr> </table>
///    
@DllImport("ISCSIDSC")
uint AddRadiusServerA(const(char)* Address);

///The <b>RemoveRadiusServer</b> function removes a Remote Authentication Dial-In User Service (RADIUS) server entry
///from the RADIUS server list with which an iSCSI initiator is configured.
///Params:
///    Address = A string that represents the IP address or RADIUS server name.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if the operation is successful. If the operation fails due to a socket connection
///    error, this function will return a Winsock error code.
///    
@DllImport("ISCSIDSC")
uint RemoveRadiusServerW(const(wchar)* Address);

///The <b>RemoveRadiusServer</b> function removes a Remote Authentication Dial-In User Service (RADIUS) server entry
///from the RADIUS server list with which an iSCSI initiator is configured.
///Params:
///    Address = A string that represents the IP address or RADIUS server name.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if the operation is successful. If the operation fails due to a socket connection
///    error, this function will return a Winsock error code.
///    
@DllImport("ISCSIDSC")
uint RemoveRadiusServerA(const(char)* Address);

///The <b>ReportRadiusServerList</b> function retrieves the list of Remote Authentication Dail-In Service (RADIUS)
///servers the iSCSI initiator service uses during authentication.
///Params:
///    BufferSizeInChar = A <b>ULONG</b> value that specifies the number of list elements contained by the <i>Buffer</i> parameter.
///    Buffer = Pointer to a buffer that receives the list of Remote Authentication Dail-In Service (RADIUS) servers on output.
///             Each server name is null terminated, except for the last server name, which is double null-terminated.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if the operation is successful. If the operation fails due to a socket connection
///    error, this function will return a Winsock error code.
///    
@DllImport("ISCSIDSC")
uint ReportRadiusServerListW(uint* BufferSizeInChar, const(wchar)* Buffer);

///The <b>ReportRadiusServerList</b> function retrieves the list of Remote Authentication Dail-In Service (RADIUS)
///servers the iSCSI initiator service uses during authentication.
///Params:
///    BufferSizeInChar = A <b>ULONG</b> value that specifies the number of list elements contained by the <i>Buffer</i> parameter.
///    Buffer = Pointer to a buffer that receives the list of Remote Authentication Dail-In Service (RADIUS) servers on output.
///             Each server name is null terminated, except for the last server name, which is double null-terminated.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if the operation is successful. If the operation fails due to a socket connection
///    error, this function will return a Winsock error code.
///    
@DllImport("ISCSIDSC")
uint ReportRadiusServerListA(uint* BufferSizeInChar, const(char)* Buffer);


