// Written in the D programming language.

module windows.win32.networkmanagement.ndis;

public import windows.core;
public import windows.win32.foundation : BOOLEAN, CHAR, HANDLE;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ifdef/ne-ifdef-net_if_oper_status
alias NET_IF_OPER_STATUS = int;
enum : int
{
    NET_IF_OPER_STATUS_UP               = 0x00000001,
    NET_IF_OPER_STATUS_DOWN             = 0x00000002,
    NET_IF_OPER_STATUS_TESTING          = 0x00000003,
    NET_IF_OPER_STATUS_UNKNOWN          = 0x00000004,
    NET_IF_OPER_STATUS_DORMANT          = 0x00000005,
    NET_IF_OPER_STATUS_NOT_PRESENT      = 0x00000006,
    NET_IF_OPER_STATUS_LOWER_LAYER_DOWN = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ifdef/ne-ifdef-net_if_admin_status
alias NET_IF_ADMIN_STATUS = int;
enum : int
{
    NET_IF_ADMIN_STATUS_UP      = 0x00000001,
    NET_IF_ADMIN_STATUS_DOWN    = 0x00000002,
    NET_IF_ADMIN_STATUS_TESTING = 0x00000003,
}

alias NET_IF_RCV_ADDRESS_TYPE = int;
enum : int
{
    NET_IF_RCV_ADDRESS_TYPE_OTHER        = 0x00000001,
    NET_IF_RCV_ADDRESS_TYPE_VOLATILE     = 0x00000002,
    NET_IF_RCV_ADDRESS_TYPE_NON_VOLATILE = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ifdef/ne-ifdef-net_if_connection_type
alias NET_IF_CONNECTION_TYPE = int;
enum : int
{
    NET_IF_CONNECTION_DEDICATED = 0x00000001,
    NET_IF_CONNECTION_PASSIVE   = 0x00000002,
    NET_IF_CONNECTION_DEMAND    = 0x00000003,
    NET_IF_CONNECTION_MAXIMUM   = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ifdef/ne-ifdef-tunnel_type
alias TUNNEL_TYPE = int;
enum : int
{
    TUNNEL_TYPE_NONE    = 0x00000000,
    TUNNEL_TYPE_OTHER   = 0x00000001,
    TUNNEL_TYPE_DIRECT  = 0x00000002,
    TUNNEL_TYPE_6TO4    = 0x0000000b,
    TUNNEL_TYPE_ISATAP  = 0x0000000d,
    TUNNEL_TYPE_TEREDO  = 0x0000000e,
    TUNNEL_TYPE_IPHTTPS = 0x0000000f,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ifdef/ne-ifdef-net_if_access_type
alias NET_IF_ACCESS_TYPE = int;
enum : int
{
    NET_IF_ACCESS_LOOPBACK             = 0x00000001,
    NET_IF_ACCESS_BROADCAST            = 0x00000002,
    NET_IF_ACCESS_POINT_TO_POINT       = 0x00000003,
    NET_IF_ACCESS_POINT_TO_MULTI_POINT = 0x00000004,
    NET_IF_ACCESS_MAXIMUM              = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ifdef/ne-ifdef-net_if_direction_type
alias NET_IF_DIRECTION_TYPE = int;
enum : int
{
    NET_IF_DIRECTION_SENDRECEIVE = 0x00000000,
    NET_IF_DIRECTION_SENDONLY    = 0x00000001,
    NET_IF_DIRECTION_RECEIVEONLY = 0x00000002,
    NET_IF_DIRECTION_MAXIMUM     = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ifdef/ne-ifdef-net_if_media_connect_state
alias NET_IF_MEDIA_CONNECT_STATE = int;
enum : int
{
    MediaConnectStateUnknown      = 0x00000000,
    MediaConnectStateConnected    = 0x00000001,
    MediaConnectStateDisconnected = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ifdef/ne-ifdef-net_if_media_duplex_state
alias NET_IF_MEDIA_DUPLEX_STATE = int;
enum : int
{
    MediaDuplexStateUnknown = 0x00000000,
    MediaDuplexStateHalf    = 0x00000001,
    MediaDuplexStateFull    = 0x00000002,
}

alias IF_ADMINISTRATIVE_STATE = int;
enum : int
{
    IF_ADMINISTRATIVE_DISABLED   = 0x00000000,
    IF_ADMINISTRATIVE_ENABLED    = 0x00000001,
    IF_ADMINISTRATIVE_DEMANDDIAL = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ifdef/ne-ifdef-if_oper_status
alias IF_OPER_STATUS = int;
enum : int
{
    IfOperStatusUp             = 0x00000001,
    IfOperStatusDown           = 0x00000002,
    IfOperStatusTesting        = 0x00000003,
    IfOperStatusUnknown        = 0x00000004,
    IfOperStatusDormant        = 0x00000005,
    IfOperStatusNotPresent     = 0x00000006,
    IfOperStatusLowerLayerDown = 0x00000007,
}

alias NDIS_REQUEST_TYPE = int;
enum : int
{
    NdisRequestQueryInformation = 0x00000000,
    NdisRequestSetInformation   = 0x00000001,
    NdisRequestQueryStatistics  = 0x00000002,
    NdisRequestOpen             = 0x00000003,
    NdisRequestClose            = 0x00000004,
    NdisRequestSend             = 0x00000005,
    NdisRequestTransferData     = 0x00000006,
    NdisRequestReset            = 0x00000007,
    NdisRequestGeneric1         = 0x00000008,
    NdisRequestGeneric2         = 0x00000009,
    NdisRequestGeneric3         = 0x0000000a,
    NdisRequestGeneric4         = 0x0000000b,
}

alias NDIS_INTERRUPT_MODERATION = int;
enum : int
{
    NdisInterruptModerationUnknown      = 0x00000000,
    NdisInterruptModerationNotSupported = 0x00000001,
    NdisInterruptModerationEnabled      = 0x00000002,
    NdisInterruptModerationDisabled     = 0x00000003,
}

alias NDIS_802_11_STATUS_TYPE = int;
enum : int
{
    Ndis802_11StatusType_Authentication      = 0x00000000,
    Ndis802_11StatusType_MediaStreamMode     = 0x00000001,
    Ndis802_11StatusType_PMKID_CandidateList = 0x00000002,
    Ndis802_11StatusTypeMax                  = 0x00000003,
}

alias NDIS_802_11_NETWORK_TYPE = int;
enum : int
{
    Ndis802_11FH             = 0x00000000,
    Ndis802_11DS             = 0x00000001,
    Ndis802_11OFDM5          = 0x00000002,
    Ndis802_11OFDM24         = 0x00000003,
    Ndis802_11Automode       = 0x00000004,
    Ndis802_11NetworkTypeMax = 0x00000005,
}

alias NDIS_802_11_POWER_MODE = int;
enum : int
{
    Ndis802_11PowerModeCAM      = 0x00000000,
    Ndis802_11PowerModeMAX_PSP  = 0x00000001,
    Ndis802_11PowerModeFast_PSP = 0x00000002,
    Ndis802_11PowerModeMax      = 0x00000003,
}

alias NDIS_802_11_NETWORK_INFRASTRUCTURE = int;
enum : int
{
    Ndis802_11IBSS              = 0x00000000,
    Ndis802_11Infrastructure    = 0x00000001,
    Ndis802_11AutoUnknown       = 0x00000002,
    Ndis802_11InfrastructureMax = 0x00000003,
}

alias NDIS_802_11_AUTHENTICATION_MODE = int;
enum : int
{
    Ndis802_11AuthModeOpen       = 0x00000000,
    Ndis802_11AuthModeShared     = 0x00000001,
    Ndis802_11AuthModeAutoSwitch = 0x00000002,
    Ndis802_11AuthModeWPA        = 0x00000003,
    Ndis802_11AuthModeWPAPSK     = 0x00000004,
    Ndis802_11AuthModeWPANone    = 0x00000005,
    Ndis802_11AuthModeWPA2       = 0x00000006,
    Ndis802_11AuthModeWPA2PSK    = 0x00000007,
    Ndis802_11AuthModeWPA3       = 0x00000008,
    Ndis802_11AuthModeWPA3Ent192 = 0x00000008,
    Ndis802_11AuthModeWPA3SAE    = 0x00000009,
    Ndis802_11AuthModeWPA3Ent    = 0x0000000a,
    Ndis802_11AuthModeMax        = 0x0000000b,
}

alias NDIS_802_11_PRIVACY_FILTER = int;
enum : int
{
    Ndis802_11PrivFilterAcceptAll = 0x00000000,
    Ndis802_11PrivFilter8021xWEP  = 0x00000001,
}

alias NDIS_802_11_WEP_STATUS = int;
enum : int
{
    Ndis802_11WEPEnabled             = 0x00000000,
    Ndis802_11Encryption1Enabled     = 0x00000000,
    Ndis802_11WEPDisabled            = 0x00000001,
    Ndis802_11EncryptionDisabled     = 0x00000001,
    Ndis802_11WEPKeyAbsent           = 0x00000002,
    Ndis802_11Encryption1KeyAbsent   = 0x00000002,
    Ndis802_11WEPNotSupported        = 0x00000003,
    Ndis802_11EncryptionNotSupported = 0x00000003,
    Ndis802_11Encryption2Enabled     = 0x00000004,
    Ndis802_11Encryption2KeyAbsent   = 0x00000005,
    Ndis802_11Encryption3Enabled     = 0x00000006,
    Ndis802_11Encryption3KeyAbsent   = 0x00000007,
}

alias NDIS_802_11_RELOAD_DEFAULTS = int;
enum : int
{
    Ndis802_11ReloadWEPKeys = 0x00000000,
}

alias NDIS_802_11_MEDIA_STREAM_MODE = int;
enum : int
{
    Ndis802_11MediaStreamOff = 0x00000000,
    Ndis802_11MediaStreamOn  = 0x00000001,
}

alias NDIS_802_11_RADIO_STATUS = int;
enum : int
{
    Ndis802_11RadioStatusOn                  = 0x00000000,
    Ndis802_11RadioStatusHardwareOff         = 0x00000001,
    Ndis802_11RadioStatusSoftwareOff         = 0x00000002,
    Ndis802_11RadioStatusHardwareSoftwareOff = 0x00000003,
    Ndis802_11RadioStatusMax                 = 0x00000004,
}

alias OFFLOAD_OPERATION_E = int;
enum : int
{
    AUTHENTICATE = 0x00000001,
    ENCRYPT      = 0x00000002,
}

alias OFFLOAD_CONF_ALGO = int;
enum : int
{
    OFFLOAD_IPSEC_CONF_NONE     = 0x00000000,
    OFFLOAD_IPSEC_CONF_DES      = 0x00000001,
    OFFLOAD_IPSEC_CONF_RESERVED = 0x00000002,
    OFFLOAD_IPSEC_CONF_3_DES    = 0x00000003,
    OFFLOAD_IPSEC_CONF_MAX      = 0x00000004,
}

alias OFFLOAD_INTEGRITY_ALGO = int;
enum : int
{
    OFFLOAD_IPSEC_INTEGRITY_NONE = 0x00000000,
    OFFLOAD_IPSEC_INTEGRITY_MD5  = 0x00000001,
    OFFLOAD_IPSEC_INTEGRITY_SHA  = 0x00000002,
    OFFLOAD_IPSEC_INTEGRITY_MAX  = 0x00000003,
}

alias UDP_ENCAP_TYPE = int;
enum : int
{
    OFFLOAD_IPSEC_UDPESP_ENCAPTYPE_IKE   = 0x00000000,
    OFFLOAD_IPSEC_UDPESP_ENCAPTYPE_OTHER = 0x00000001,
}

alias NDIS_MEDIUM = int;
enum : int
{
    NdisMedium802_3        = 0x00000000,
    NdisMedium802_5        = 0x00000001,
    NdisMediumFddi         = 0x00000002,
    NdisMediumWan          = 0x00000003,
    NdisMediumLocalTalk    = 0x00000004,
    NdisMediumDix          = 0x00000005,
    NdisMediumArcnetRaw    = 0x00000006,
    NdisMediumArcnet878_2  = 0x00000007,
    NdisMediumAtm          = 0x00000008,
    NdisMediumWirelessWan  = 0x00000009,
    NdisMediumIrda         = 0x0000000a,
    NdisMediumBpc          = 0x0000000b,
    NdisMediumCoWan        = 0x0000000c,
    NdisMedium1394         = 0x0000000d,
    NdisMediumInfiniBand   = 0x0000000e,
    NdisMediumTunnel       = 0x0000000f,
    NdisMediumNative802_11 = 0x00000010,
    NdisMediumLoopback     = 0x00000011,
    NdisMediumWiMAX        = 0x00000012,
    NdisMediumIP           = 0x00000013,
    NdisMediumMax          = 0x00000014,
}

alias NDIS_PHYSICAL_MEDIUM = int;
enum : int
{
    NdisPhysicalMediumUnspecified    = 0x00000000,
    NdisPhysicalMediumWirelessLan    = 0x00000001,
    NdisPhysicalMediumCableModem     = 0x00000002,
    NdisPhysicalMediumPhoneLine      = 0x00000003,
    NdisPhysicalMediumPowerLine      = 0x00000004,
    NdisPhysicalMediumDSL            = 0x00000005,
    NdisPhysicalMediumFibreChannel   = 0x00000006,
    NdisPhysicalMedium1394           = 0x00000007,
    NdisPhysicalMediumWirelessWan    = 0x00000008,
    NdisPhysicalMediumNative802_11   = 0x00000009,
    NdisPhysicalMediumBluetooth      = 0x0000000a,
    NdisPhysicalMediumInfiniband     = 0x0000000b,
    NdisPhysicalMediumWiMax          = 0x0000000c,
    NdisPhysicalMediumUWB            = 0x0000000d,
    NdisPhysicalMedium802_3          = 0x0000000e,
    NdisPhysicalMedium802_5          = 0x0000000f,
    NdisPhysicalMediumIrda           = 0x00000010,
    NdisPhysicalMediumWiredWAN       = 0x00000011,
    NdisPhysicalMediumWiredCoWan     = 0x00000012,
    NdisPhysicalMediumOther          = 0x00000013,
    NdisPhysicalMediumNative802_15_4 = 0x00000014,
    NdisPhysicalMediumMax            = 0x00000015,
}

alias NDIS_HARDWARE_STATUS = int;
enum : int
{
    NdisHardwareStatusReady        = 0x00000000,
    NdisHardwareStatusInitializing = 0x00000001,
    NdisHardwareStatusReset        = 0x00000002,
    NdisHardwareStatusClosing      = 0x00000003,
    NdisHardwareStatusNotReady     = 0x00000004,
}

alias NDIS_DEVICE_POWER_STATE = int;
enum : int
{
    NdisDeviceStateUnspecified = 0x00000000,
    NdisDeviceStateD0          = 0x00000001,
    NdisDeviceStateD1          = 0x00000002,
    NdisDeviceStateD2          = 0x00000003,
    NdisDeviceStateD3          = 0x00000004,
    NdisDeviceStateMaximum     = 0x00000005,
}

alias NDIS_FDDI_ATTACHMENT_TYPE = int;
enum : int
{
    NdisFddiTypeIsolated = 0x00000001,
    NdisFddiTypeLocalA   = 0x00000002,
    NdisFddiTypeLocalB   = 0x00000003,
    NdisFddiTypeLocalAB  = 0x00000004,
    NdisFddiTypeLocalS   = 0x00000005,
    NdisFddiTypeWrapA    = 0x00000006,
    NdisFddiTypeWrapB    = 0x00000007,
    NdisFddiTypeWrapAB   = 0x00000008,
    NdisFddiTypeWrapS    = 0x00000009,
    NdisFddiTypeCWrapA   = 0x0000000a,
    NdisFddiTypeCWrapB   = 0x0000000b,
    NdisFddiTypeCWrapS   = 0x0000000c,
    NdisFddiTypeThrough  = 0x0000000d,
}

alias NDIS_FDDI_RING_MGT_STATE = int;
enum : int
{
    NdisFddiRingIsolated          = 0x00000001,
    NdisFddiRingNonOperational    = 0x00000002,
    NdisFddiRingOperational       = 0x00000003,
    NdisFddiRingDetect            = 0x00000004,
    NdisFddiRingNonOperationalDup = 0x00000005,
    NdisFddiRingOperationalDup    = 0x00000006,
    NdisFddiRingDirected          = 0x00000007,
    NdisFddiRingTrace             = 0x00000008,
}

alias NDIS_FDDI_LCONNECTION_STATE = int;
enum : int
{
    NdisFddiStateOff         = 0x00000001,
    NdisFddiStateBreak       = 0x00000002,
    NdisFddiStateTrace       = 0x00000003,
    NdisFddiStateConnect     = 0x00000004,
    NdisFddiStateNext        = 0x00000005,
    NdisFddiStateSignal      = 0x00000006,
    NdisFddiStateJoin        = 0x00000007,
    NdisFddiStateVerify      = 0x00000008,
    NdisFddiStateActive      = 0x00000009,
    NdisFddiStateMaintenance = 0x0000000a,
}

alias NDIS_WAN_MEDIUM_SUBTYPE = int;
enum : int
{
    NdisWanMediumHub        = 0x00000000,
    NdisWanMediumX_25       = 0x00000001,
    NdisWanMediumIsdn       = 0x00000002,
    NdisWanMediumSerial     = 0x00000003,
    NdisWanMediumFrameRelay = 0x00000004,
    NdisWanMediumAtm        = 0x00000005,
    NdisWanMediumSonet      = 0x00000006,
    NdisWanMediumSW56K      = 0x00000007,
    NdisWanMediumPPTP       = 0x00000008,
    NdisWanMediumL2TP       = 0x00000009,
    NdisWanMediumIrda       = 0x0000000a,
    NdisWanMediumParallel   = 0x0000000b,
    NdisWanMediumPppoe      = 0x0000000c,
    NdisWanMediumSSTP       = 0x0000000d,
    NdisWanMediumAgileVPN   = 0x0000000e,
    NdisWanMediumGre        = 0x0000000f,
    NdisWanMediumSubTypeMax = 0x00000010,
}

alias NDIS_WAN_HEADER_FORMAT = int;
enum : int
{
    NdisWanHeaderNative   = 0x00000000,
    NdisWanHeaderEthernet = 0x00000001,
}

alias NDIS_WAN_QUALITY = int;
enum : int
{
    NdisWanRaw          = 0x00000000,
    NdisWanErrorControl = 0x00000001,
    NdisWanReliable     = 0x00000002,
}

alias NDIS_802_5_RING_STATE = int;
enum : int
{
    NdisRingStateOpened      = 0x00000001,
    NdisRingStateClosed      = 0x00000002,
    NdisRingStateOpening     = 0x00000003,
    NdisRingStateClosing     = 0x00000004,
    NdisRingStateOpenFailure = 0x00000005,
    NdisRingStateRingFailure = 0x00000006,
}

alias NDIS_MEDIA_STATE = int;
enum : int
{
    NdisMediaStateConnected    = 0x00000000,
    NdisMediaStateDisconnected = 0x00000001,
}

alias NDIS_SUPPORTED_PAUSE_FUNCTIONS = int;
enum : int
{
    NdisPauseFunctionsUnsupported    = 0x00000000,
    NdisPauseFunctionsSendOnly       = 0x00000001,
    NdisPauseFunctionsReceiveOnly    = 0x00000002,
    NdisPauseFunctionsSendAndReceive = 0x00000003,
    NdisPauseFunctionsUnknown        = 0x00000004,
}

alias NDIS_PORT_TYPE = int;
enum : int
{
    NdisPortTypeUndefined       = 0x00000000,
    NdisPortTypeBridge          = 0x00000001,
    NdisPortTypeRasConnection   = 0x00000002,
    NdisPortType8021xSupplicant = 0x00000003,
    NdisPortTypeMax             = 0x00000004,
}

alias NDIS_PORT_AUTHORIZATION_STATE = int;
enum : int
{
    NdisPortAuthorizationUnknown = 0x00000000,
    NdisPortAuthorized           = 0x00000001,
    NdisPortUnauthorized         = 0x00000002,
    NdisPortReauthorizing        = 0x00000003,
}

alias NDIS_PORT_CONTROL_STATE = int;
enum : int
{
    NdisPortControlStateUnknown      = 0x00000000,
    NdisPortControlStateControlled   = 0x00000001,
    NdisPortControlStateUncontrolled = 0x00000002,
}

alias NDIS_NETWORK_CHANGE_TYPE = int;
enum : int
{
    NdisPossibleNetworkChange         = 0x00000001,
    NdisDefinitelyNetworkChange       = 0x00000002,
    NdisNetworkChangeFromMediaConnect = 0x00000003,
    NdisNetworkChangeMax              = 0x00000004,
}

alias NDIS_PROCESSOR_VENDOR = int;
enum : int
{
    NdisProcessorVendorUnknown      = 0x00000000,
    NdisProcessorVendorGenuinIntel  = 0x00000001,
    NdisProcessorVendorGenuineIntel = 0x00000001,
    NdisProcessorVendorAuthenticAMD = 0x00000002,
}

alias NDK_RDMA_TECHNOLOGY = int;
enum : int
{
    NdkUndefined     = 0x00000000,
    NdkiWarp         = 0x00000001,
    NdkInfiniBand    = 0x00000002,
    NdkRoCE          = 0x00000003,
    NdkRoCEv2        = 0x00000004,
    NdkMaxTechnology = 0x00000005,
}

// Constants


enum : uint
{
    NET_IF_COMPARTMENT_ID_UNSPECIFIED = 0x00000000U,
    NET_IF_COMPARTMENT_ID_PRIMARY     = 0x00000001U,
}

enum : uint
{
    IOCTL_NDIS_RESERVED5 = 0x00170034U,
    IOCTL_NDIS_RESERVED6 = 0x00178038U,
}

enum : uint
{
    NDIS_OBJECT_TYPE_DEFAULT                         = 0x00000080U,
    NDIS_OBJECT_TYPE_MINIPORT_INIT_PARAMETERS        = 0x00000081U,
    NDIS_OBJECT_TYPE_SG_DMA_DESCRIPTION              = 0x00000083U,
    NDIS_OBJECT_TYPE_MINIPORT_INTERRUPT              = 0x00000084U,
    NDIS_OBJECT_TYPE_DEVICE_OBJECT_ATTRIBUTES        = 0x00000085U,
    NDIS_OBJECT_TYPE_BIND_PARAMETERS                 = 0x00000086U,
    NDIS_OBJECT_TYPE_OPEN_PARAMETERS                 = 0x00000087U,
    NDIS_OBJECT_TYPE_RSS_CAPABILITIES                = 0x00000088U,
    NDIS_OBJECT_TYPE_RSS_PARAMETERS                  = 0x00000089U,
    NDIS_OBJECT_TYPE_MINIPORT_DRIVER_CHARACTERISTICS = 0x0000008aU,
}

enum : uint
{
    NDIS_OBJECT_TYPE_FILTER_DRIVER_CHARACTERISTICS                  = 0x0000008bU,
    NDIS_OBJECT_TYPE_FILTER_PARTIAL_CHARACTERISTICS                 = 0x0000008cU,
    NDIS_OBJECT_TYPE_FILTER_ATTRIBUTES                              = 0x0000008dU,
    NDIS_OBJECT_TYPE_CLIENT_CHIMNEY_OFFLOAD_GENERIC_CHARACTERISTICS = 0x0000008eU,
}

enum uint NDIS_OBJECT_TYPE_PROVIDER_CHIMNEY_OFFLOAD_GENERIC_CHARACTERISTICS = 0x0000008fU;

enum : uint
{
    NDIS_OBJECT_TYPE_CO_PROTOCOL_CHARACTERISTICS = 0x00000090U,
    NDIS_OBJECT_TYPE_CO_MINIPORT_CHARACTERISTICS = 0x00000091U,
}

enum uint NDIS_OBJECT_TYPE_MINIPORT_PNP_CHARACTERISTICS = 0x00000092U;
enum uint NDIS_OBJECT_TYPE_CLIENT_CHIMNEY_OFFLOAD_CHARACTERISTICS = 0x00000093U;
enum uint NDIS_OBJECT_TYPE_PROVIDER_CHIMNEY_OFFLOAD_CHARACTERISTICS = 0x00000094U;
enum uint NDIS_OBJECT_TYPE_PROTOCOL_DRIVER_CHARACTERISTICS = 0x00000095U;

enum : uint
{
    NDIS_OBJECT_TYPE_REQUEST_EX                                = 0x00000096U,
    NDIS_OBJECT_TYPE_TIMER_CHARACTERISTICS                     = 0x00000097U,
    NDIS_OBJECT_TYPE_STATUS_INDICATION                         = 0x00000098U,
    NDIS_OBJECT_TYPE_FILTER_ATTACH_PARAMETERS                  = 0x00000099U,
    NDIS_OBJECT_TYPE_FILTER_PAUSE_PARAMETERS                   = 0x0000009aU,
    NDIS_OBJECT_TYPE_FILTER_RESTART_PARAMETERS                 = 0x0000009bU,
    NDIS_OBJECT_TYPE_PORT_CHARACTERISTICS                      = 0x0000009cU,
    NDIS_OBJECT_TYPE_PORT_STATE                                = 0x0000009dU,
    NDIS_OBJECT_TYPE_MINIPORT_ADAPTER_REGISTRATION_ATTRIBUTES  = 0x0000009eU,
    NDIS_OBJECT_TYPE_MINIPORT_ADAPTER_GENERAL_ATTRIBUTES       = 0x0000009fU,
    NDIS_OBJECT_TYPE_MINIPORT_ADAPTER_OFFLOAD_ATTRIBUTES       = 0x000000a0U,
    NDIS_OBJECT_TYPE_MINIPORT_ADAPTER_NATIVE_802_11_ATTRIBUTES = 0x000000a1U,
}

enum uint NDIS_OBJECT_TYPE_RESTART_GENERAL_ATTRIBUTES = 0x000000a2U;
enum uint NDIS_OBJECT_TYPE_PROTOCOL_RESTART_PARAMETERS = 0x000000a3U;
enum uint NDIS_OBJECT_TYPE_MINIPORT_ADD_DEVICE_REGISTRATION_ATTRIBUTES = 0x000000a4U;

enum : uint
{
    NDIS_OBJECT_TYPE_CO_CALL_MANAGER_OPTIONAL_HANDLERS = 0x000000a5U,
    NDIS_OBJECT_TYPE_CO_CLIENT_OPTIONAL_HANDLERS       = 0x000000a6U,
}

enum : uint
{
    NDIS_OBJECT_TYPE_OFFLOAD                         = 0x000000a7U,
    NDIS_OBJECT_TYPE_OFFLOAD_ENCAPSULATION           = 0x000000a8U,
    NDIS_OBJECT_TYPE_CONFIGURATION_OBJECT            = 0x000000a9U,
    NDIS_OBJECT_TYPE_DRIVER_WRAPPER_OBJECT           = 0x000000aaU,
    NDIS_OBJECT_TYPE_HD_SPLIT_ATTRIBUTES             = 0x000000abU,
    NDIS_OBJECT_TYPE_NSI_NETWORK_RW_STRUCT           = 0x000000acU,
    NDIS_OBJECT_TYPE_NSI_COMPARTMENT_RW_STRUCT       = 0x000000adU,
    NDIS_OBJECT_TYPE_NSI_INTERFACE_PERSIST_RW_STRUCT = 0x000000aeU,
}

enum uint NDIS_OBJECT_TYPE_MINIPORT_ADAPTER_HARDWARE_ASSIST_ATTRIBUTES = 0x000000afU;
enum uint NDIS_OBJECT_TYPE_SHARED_MEMORY_PROVIDER_CHARACTERISTICS = 0x000000b0U;

enum : uint
{
    NDIS_OBJECT_TYPE_RSS_PROCESSOR_INFO           = 0x000000b1U,
    NDIS_OBJECT_TYPE_NDK_PROVIDER_CHARACTERISTICS = 0x000000b2U,
}

enum : uint
{
    NDIS_OBJECT_TYPE_MINIPORT_ADAPTER_NDK_ATTRIBUTES = 0x000000b3U,
    NDIS_OBJECT_TYPE_MINIPORT_SS_CHARACTERISTICS     = 0x000000b4U,
}

enum : uint
{
    NDIS_OBJECT_TYPE_QOS_CAPABILITIES           = 0x000000b5U,
    NDIS_OBJECT_TYPE_QOS_PARAMETERS             = 0x000000b6U,
    NDIS_OBJECT_TYPE_QOS_CLASSIFICATION_ELEMENT = 0x000000b7U,
}

enum : uint
{
    NDIS_OBJECT_TYPE_SWITCH_OPTIONAL_HANDLERS                  = 0x000000b8U,
    NDIS_OBJECT_TYPE_PD_TRANSMIT_QUEUE                         = 0x000000beU,
    NDIS_OBJECT_TYPE_PD_RECEIVE_QUEUE                          = 0x000000bfU,
    NDIS_OBJECT_TYPE_MINIPORT_ADAPTER_PACKET_DIRECT_ATTRIBUTES = 0x000000c5U,
    NDIS_OBJECT_TYPE_MINIPORT_DEVICE_POWER_NOTIFICATION        = 0x000000c6U,
}

enum : uint
{
    NDIS_OBJECT_TYPE_RSS_PARAMETERS_V2           = 0x000000c8U,
    NDIS_OBJECT_TYPE_RSS_SET_INDIRECTION_ENTRIES = 0x000000c9U,
}

enum : uint
{
    NDIS_STATISTICS_FLAGS_VALID_DIRECTED_FRAMES_RCV   = 0x00000001U,
    NDIS_STATISTICS_FLAGS_VALID_MULTICAST_FRAMES_RCV  = 0x00000002U,
    NDIS_STATISTICS_FLAGS_VALID_BROADCAST_FRAMES_RCV  = 0x00000004U,
    NDIS_STATISTICS_FLAGS_VALID_BYTES_RCV             = 0x00000008U,
    NDIS_STATISTICS_FLAGS_VALID_RCV_DISCARDS          = 0x00000010U,
    NDIS_STATISTICS_FLAGS_VALID_RCV_ERROR             = 0x00000020U,
    NDIS_STATISTICS_FLAGS_VALID_DIRECTED_FRAMES_XMIT  = 0x00000040U,
    NDIS_STATISTICS_FLAGS_VALID_MULTICAST_FRAMES_XMIT = 0x00000080U,
    NDIS_STATISTICS_FLAGS_VALID_BROADCAST_FRAMES_XMIT = 0x00000100U,
    NDIS_STATISTICS_FLAGS_VALID_BYTES_XMIT            = 0x00000200U,
    NDIS_STATISTICS_FLAGS_VALID_XMIT_ERROR            = 0x00000400U,
    NDIS_STATISTICS_FLAGS_VALID_XMIT_DISCARDS         = 0x00008000U,
    NDIS_STATISTICS_FLAGS_VALID_DIRECTED_BYTES_RCV    = 0x00010000U,
    NDIS_STATISTICS_FLAGS_VALID_MULTICAST_BYTES_RCV   = 0x00020000U,
    NDIS_STATISTICS_FLAGS_VALID_BROADCAST_BYTES_RCV   = 0x00040000U,
    NDIS_STATISTICS_FLAGS_VALID_DIRECTED_BYTES_XMIT   = 0x00080000U,
    NDIS_STATISTICS_FLAGS_VALID_MULTICAST_BYTES_XMIT  = 0x00100000U,
    NDIS_STATISTICS_FLAGS_VALID_BROADCAST_BYTES_XMIT  = 0x00200000U,
}

enum uint NDIS_STATISTICS_INFO_REVISION_1 = 0x00000001U;
enum uint NDIS_RSC_STATISTICS_REVISION_1 = 0x00000001U;

enum : uint
{
    NDIS_INTERRUPT_MODERATION_CHANGE_NEEDS_RESET        = 0x00000001U,
    NDIS_INTERRUPT_MODERATION_CHANGE_NEEDS_REINITIALIZE = 0x00000002U,
    NDIS_INTERRUPT_MODERATION_PARAMETERS_REVISION_1     = 0x00000001U,
}

enum uint NDIS_TIMEOUT_DPC_REQUEST_CAPABILITIES_REVISION_1 = 0x00000001U;

enum : uint
{
    NDIS_OBJECT_TYPE_PCI_DEVICE_CUSTOM_PROPERTIES_REVISION_1 = 0x00000001U,
    NDIS_OBJECT_TYPE_PCI_DEVICE_CUSTOM_PROPERTIES_REVISION_2 = 0x00000002U,
}

enum uint OID_GEN_SUPPORTED_LIST = 0x00010101U;
enum uint OID_GEN_HARDWARE_STATUS = 0x00010102U;

enum : uint
{
    OID_GEN_MEDIA_SUPPORTED    = 0x00010103U,
    OID_GEN_MEDIA_IN_USE       = 0x00010104U,
    OID_GEN_MAXIMUM_LOOKAHEAD  = 0x00010105U,
    OID_GEN_MAXIMUM_FRAME_SIZE = 0x00010106U,
}

enum : uint
{
    OID_GEN_LINK_SPEED            = 0x00010107U,
    OID_GEN_TRANSMIT_BUFFER_SPACE = 0x00010108U,
}

enum uint OID_GEN_RECEIVE_BUFFER_SPACE = 0x00010109U;
enum uint OID_GEN_TRANSMIT_BLOCK_SIZE = 0x0001010aU;
enum uint OID_GEN_RECEIVE_BLOCK_SIZE = 0x0001010bU;

enum : uint
{
    OID_GEN_VENDOR_ID          = 0x0001010cU,
    OID_GEN_VENDOR_DESCRIPTION = 0x0001010dU,
}

enum : uint
{
    OID_GEN_CURRENT_PACKET_FILTER = 0x0001010eU,
    OID_GEN_CURRENT_LOOKAHEAD     = 0x0001010fU,
}

enum uint OID_GEN_DRIVER_VERSION = 0x00010110U;
enum uint OID_GEN_MAXIMUM_TOTAL_SIZE = 0x00010111U;
enum uint OID_GEN_PROTOCOL_OPTIONS = 0x00010112U;

enum : uint
{
    OID_GEN_MAC_OPTIONS          = 0x00010113U,
    OID_GEN_MEDIA_CONNECT_STATUS = 0x00010114U,
}

enum uint OID_GEN_MAXIMUM_SEND_PACKETS = 0x00010115U;
enum uint OID_GEN_VENDOR_DRIVER_VERSION = 0x00010116U;
enum uint OID_GEN_SUPPORTED_GUIDS = 0x00010117U;
enum uint OID_GEN_NETWORK_LAYER_ADDRESSES = 0x00010118U;
enum uint OID_GEN_TRANSPORT_HEADER_OFFSET = 0x00010119U;
enum uint OID_GEN_MEDIA_CAPABILITIES = 0x00010201U;
enum uint OID_GEN_PHYSICAL_MEDIUM = 0x00010202U;

enum : uint
{
    OID_GEN_RECEIVE_SCALE_CAPABILITIES = 0x00010203U,
    OID_GEN_RECEIVE_SCALE_PARAMETERS   = 0x00010204U,
}

enum : uint
{
    OID_GEN_MAC_ADDRESS    = 0x00010205U,
    OID_GEN_MAX_LINK_SPEED = 0x00010206U,
}

enum : uint
{
    OID_GEN_LINK_STATE      = 0x00010207U,
    OID_GEN_LINK_PARAMETERS = 0x00010208U,
}

enum uint OID_GEN_INTERRUPT_MODERATION = 0x00010209U;

enum : uint
{
    OID_GEN_NDIS_RESERVED_3 = 0x0001020aU,
    OID_GEN_NDIS_RESERVED_4 = 0x0001020bU,
    OID_GEN_NDIS_RESERVED_5 = 0x0001020cU,
}

enum uint OID_GEN_ENUMERATE_PORTS = 0x0001020dU;

enum : uint
{
    OID_GEN_PORT_STATE                     = 0x0001020eU,
    OID_GEN_PORT_AUTHENTICATION_PARAMETERS = 0x0001020fU,
}

enum uint OID_GEN_TIMEOUT_DPC_REQUEST_CAPABILITIES = 0x00010210U;
enum uint OID_GEN_PCI_DEVICE_CUSTOM_PROPERTIES = 0x00010211U;
enum uint OID_GEN_NDIS_RESERVED_6 = 0x00010212U;
enum uint OID_GEN_PHYSICAL_MEDIUM_EX = 0x00010213U;
enum uint OID_GEN_RECEIVE_SCALE_PARAMETERS_V2 = 0x00010214U;
enum uint OID_GEN_MACHINE_NAME = 0x0001021aU;
enum uint OID_GEN_RNDIS_CONFIG_PARAMETER = 0x0001021bU;

enum : uint
{
    OID_GEN_VLAN_ID      = 0x0001021cU,
    OID_GEN_RECEIVE_HASH = 0x0001021fU,
}

enum uint OID_GEN_MINIPORT_RESTART_ATTRIBUTES = 0x0001021dU;

enum : uint
{
    OID_GEN_HD_SPLIT_PARAMETERS     = 0x0001021eU,
    OID_GEN_HD_SPLIT_CURRENT_CONFIG = 0x00010220U,
}

enum uint OID_GEN_PROMISCUOUS_MODE = 0x00010280U;

enum : uint
{
    OID_GEN_LAST_CHANGE        = 0x00010281U,
    OID_GEN_DISCONTINUITY_TIME = 0x00010282U,
}

enum uint OID_GEN_OPERATIONAL_STATUS = 0x00010283U;
enum uint OID_GEN_XMIT_LINK_SPEED = 0x00010284U;
enum uint OID_GEN_RCV_LINK_SPEED = 0x00010285U;
enum uint OID_GEN_UNKNOWN_PROTOS = 0x00010286U;
enum uint OID_GEN_INTERFACE_INFO = 0x00010287U;

enum : uint
{
    OID_GEN_ADMIN_STATUS            = 0x00010288U,
    OID_GEN_ALIAS                   = 0x00010289U,
    OID_GEN_MEDIA_CONNECT_STATUS_EX = 0x0001028aU,
}

enum uint OID_GEN_LINK_SPEED_EX = 0x0001028bU;
enum uint OID_GEN_MEDIA_DUPLEX_STATE = 0x0001028cU;
enum uint OID_GEN_IP_OPER_STATUS = 0x0001028dU;

enum : uint
{
    OID_WWAN_DRIVER_CAPS         = 0x0e010100U,
    OID_WWAN_DEVICE_CAPS         = 0x0e010101U,
    OID_WWAN_READY_INFO          = 0x0e010102U,
    OID_WWAN_RADIO_STATE         = 0x0e010103U,
    OID_WWAN_PIN                 = 0x0e010104U,
    OID_WWAN_PIN_LIST            = 0x0e010105U,
    OID_WWAN_HOME_PROVIDER       = 0x0e010106U,
    OID_WWAN_PREFERRED_PROVIDERS = 0x0e010107U,
}

enum uint OID_WWAN_VISIBLE_PROVIDERS = 0x0e010108U;
enum uint OID_WWAN_REGISTER_STATE = 0x0e010109U;
enum uint OID_WWAN_PACKET_SERVICE = 0x0e01010aU;

enum : uint
{
    OID_WWAN_SIGNAL_STATE         = 0x0e01010bU,
    OID_WWAN_CONNECT              = 0x0e01010cU,
    OID_WWAN_PROVISIONED_CONTEXTS = 0x0e01010dU,
}

enum uint OID_WWAN_SERVICE_ACTIVATION = 0x0e01010eU;

enum : uint
{
    OID_WWAN_SMS_CONFIGURATION = 0x0e01010fU,
    OID_WWAN_SMS_READ          = 0x0e010110U,
    OID_WWAN_SMS_SEND          = 0x0e010111U,
    OID_WWAN_SMS_DELETE        = 0x0e010112U,
    OID_WWAN_SMS_STATUS        = 0x0e010113U,
    OID_WWAN_VENDOR_SPECIFIC   = 0x0e010114U,
}

enum uint OID_WWAN_AUTH_CHALLENGE = 0x0e010115U;
enum uint OID_WWAN_ENUMERATE_DEVICE_SERVICES = 0x0e010116U;
enum uint OID_WWAN_SUBSCRIBE_DEVICE_SERVICE_EVENTS = 0x0e010117U;
enum uint OID_WWAN_DEVICE_SERVICE_COMMAND = 0x0e010118U;

enum : uint
{
    OID_WWAN_USSD                              = 0x0e010119U,
    OID_WWAN_PIN_EX                            = 0x0e010121U,
    OID_WWAN_ENUMERATE_DEVICE_SERVICE_COMMANDS = 0x0e010122U,
}

enum : uint
{
    OID_WWAN_DEVICE_SERVICE_SESSION       = 0x0e010123U,
    OID_WWAN_DEVICE_SERVICE_SESSION_WRITE = 0x0e010124U,
}

enum uint OID_WWAN_PREFERRED_MULTICARRIER_PROVIDERS = 0x0e010125U;

enum : uint
{
    OID_WWAN_CREATE_MAC         = 0x0e010126U,
    OID_WWAN_DELETE_MAC         = 0x0e010127U,
    OID_WWAN_UICC_FILE_STATUS   = 0x0e010128U,
    OID_WWAN_UICC_ACCESS_BINARY = 0x0e010129U,
    OID_WWAN_UICC_ACCESS_RECORD = 0x0e01012aU,
}

enum : uint
{
    OID_WWAN_PIN_EX2        = 0x0e01012bU,
    OID_WWAN_MBIM_VERSION   = 0x0e01012cU,
    OID_WWAN_SYS_CAPS       = 0x0e01012dU,
    OID_WWAN_DEVICE_CAPS_EX = 0x0e01012eU,
}

enum uint OID_WWAN_SYS_SLOTMAPPINGS = 0x0e01012fU;
enum uint OID_WWAN_SLOT_INFO_STATUS = 0x0e010130U;
enum uint OID_WWAN_DEVICE_BINDINGS = 0x0e010131U;
enum uint OID_WWAN_REGISTER_STATE_EX = 0x0e010132U;
enum uint OID_WWAN_IMS_VOICE_STATE = 0x0e010133U;
enum uint OID_WWAN_SIGNAL_STATE_EX = 0x0e010134U;
enum uint OID_WWAN_LOCATION_STATE = 0x0e010135U;

enum : uint
{
    OID_WWAN_NITZ              = 0x0e010136U,
    OID_WWAN_NETWORK_IDLE_HINT = 0x0e010137U,
}

enum : uint
{
    OID_WWAN_PRESHUTDOWN              = 0x0e010138U,
    OID_WWAN_UICC_ATR                 = 0x0e010139U,
    OID_WWAN_UICC_OPEN_CHANNEL        = 0x0e01013aU,
    OID_WWAN_UICC_CLOSE_CHANNEL       = 0x0e01013bU,
    OID_WWAN_UICC_APDU                = 0x0e01013cU,
    OID_WWAN_UICC_TERMINAL_CAPABILITY = 0x0e01013dU,
}

enum uint OID_WWAN_PS_MEDIA_CONFIG = 0x0e01013eU;

enum : uint
{
    OID_WWAN_SAR_CONFIG              = 0x0e01013fU,
    OID_WWAN_SAR_TRANSMISSION_STATUS = 0x0e010140U,
}

enum uint OID_WWAN_NETWORK_BLACKLIST = 0x0e010141U;

enum : uint
{
    OID_WWAN_LTE_ATTACH_CONFIG = 0x0e010142U,
    OID_WWAN_LTE_ATTACH_STATUS = 0x0e010143U,
}

enum uint OID_WWAN_MODEM_CONFIG_INFO = 0x0e010144U;

enum : uint
{
    OID_WWAN_PCO                = 0x0e010145U,
    OID_WWAN_UICC_RESET         = 0x0e010146U,
    OID_WWAN_DEVICE_RESET       = 0x0e010147U,
    OID_WWAN_BASE_STATIONS_INFO = 0x0e010148U,
}

enum : uint
{
    OID_WWAN_MPDP                 = 0x0e010149U,
    OID_WWAN_UICC_APP_LIST        = 0x0e01014aU,
    OID_WWAN_MODEM_LOGGING_CONFIG = 0x0e01014bU,
}

enum uint OID_WWAN_REGISTER_PARAMS = 0x0e01014cU;
enum uint OID_WWAN_NETWORK_PARAMS = 0x0e01014dU;
enum uint OID_WWAN_UE_POLICY = 0x0e01014eU;

enum : uint
{
    OID_GEN_XMIT_OK       = 0x00020101U,
    OID_GEN_RCV_OK        = 0x00020102U,
    OID_GEN_XMIT_ERROR    = 0x00020103U,
    OID_GEN_RCV_ERROR     = 0x00020104U,
    OID_GEN_RCV_NO_BUFFER = 0x00020105U,
}

enum : uint
{
    OID_GEN_STATISTICS           = 0x00020106U,
    OID_GEN_DIRECTED_BYTES_XMIT  = 0x00020201U,
    OID_GEN_DIRECTED_FRAMES_XMIT = 0x00020202U,
}

enum : uint
{
    OID_GEN_MULTICAST_BYTES_XMIT  = 0x00020203U,
    OID_GEN_MULTICAST_FRAMES_XMIT = 0x00020204U,
}

enum : uint
{
    OID_GEN_BROADCAST_BYTES_XMIT  = 0x00020205U,
    OID_GEN_BROADCAST_FRAMES_XMIT = 0x00020206U,
}

enum : uint
{
    OID_GEN_DIRECTED_BYTES_RCV  = 0x00020207U,
    OID_GEN_DIRECTED_FRAMES_RCV = 0x00020208U,
}

enum : uint
{
    OID_GEN_MULTICAST_BYTES_RCV  = 0x00020209U,
    OID_GEN_MULTICAST_FRAMES_RCV = 0x0002020aU,
}

enum : uint
{
    OID_GEN_BROADCAST_BYTES_RCV  = 0x0002020bU,
    OID_GEN_BROADCAST_FRAMES_RCV = 0x0002020cU,
}

enum uint OID_GEN_RCV_CRC_ERROR = 0x0002020dU;
enum uint OID_GEN_TRANSMIT_QUEUE_LENGTH = 0x0002020eU;

enum : uint
{
    OID_GEN_GET_TIME_CAPS    = 0x0002020fU,
    OID_GEN_GET_NETCARD_TIME = 0x00020210U,
}

enum uint OID_GEN_NETCARD_LOAD = 0x00020211U;
enum uint OID_GEN_DEVICE_PROFILE = 0x00020212U;
enum uint OID_GEN_INIT_TIME_MS = 0x00020213U;
enum uint OID_GEN_RESET_COUNTS = 0x00020214U;
enum uint OID_GEN_MEDIA_SENSE_COUNTS = 0x00020215U;
enum uint OID_GEN_FRIENDLY_NAME = 0x00020216U;

enum : uint
{
    OID_GEN_NDIS_RESERVED_1 = 0x00020217U,
    OID_GEN_NDIS_RESERVED_2 = 0x00020218U,
}

enum : uint
{
    OID_GEN_BYTES_RCV    = 0x00020219U,
    OID_GEN_BYTES_XMIT   = 0x0002021aU,
    OID_GEN_RCV_DISCARDS = 0x0002021bU,
}

enum uint OID_GEN_XMIT_DISCARDS = 0x0002021cU;
enum uint OID_TCP_RSC_STATISTICS = 0x0002021dU;
enum uint OID_GEN_NDIS_RESERVED_7 = 0x0002021eU;

enum : uint
{
    OID_GEN_CO_SUPPORTED_LIST     = 0x00010101U,
    OID_GEN_CO_HARDWARE_STATUS    = 0x00010102U,
    OID_GEN_CO_MEDIA_SUPPORTED    = 0x00010103U,
    OID_GEN_CO_MEDIA_IN_USE       = 0x00010104U,
    OID_GEN_CO_LINK_SPEED         = 0x00010107U,
    OID_GEN_CO_VENDOR_ID          = 0x0001010cU,
    OID_GEN_CO_VENDOR_DESCRIPTION = 0x0001010dU,
}

enum : uint
{
    OID_GEN_CO_DRIVER_VERSION       = 0x00010110U,
    OID_GEN_CO_PROTOCOL_OPTIONS     = 0x00010112U,
    OID_GEN_CO_MAC_OPTIONS          = 0x00010113U,
    OID_GEN_CO_MEDIA_CONNECT_STATUS = 0x00010114U,
}

enum uint OID_GEN_CO_VENDOR_DRIVER_VERSION = 0x00010116U;

enum : uint
{
    OID_GEN_CO_SUPPORTED_GUIDS    = 0x00010117U,
    OID_GEN_CO_GET_TIME_CAPS      = 0x0002020fU,
    OID_GEN_CO_GET_NETCARD_TIME   = 0x00020210U,
    OID_GEN_CO_MINIMUM_LINK_SPEED = 0x00020120U,
}

enum : uint
{
    OID_GEN_CO_XMIT_PDUS_OK          = 0x00020101U,
    OID_GEN_CO_RCV_PDUS_OK           = 0x00020102U,
    OID_GEN_CO_XMIT_PDUS_ERROR       = 0x00020103U,
    OID_GEN_CO_RCV_PDUS_ERROR        = 0x00020104U,
    OID_GEN_CO_RCV_PDUS_NO_BUFFER    = 0x00020105U,
    OID_GEN_CO_RCV_CRC_ERROR         = 0x0002020dU,
    OID_GEN_CO_TRANSMIT_QUEUE_LENGTH = 0x0002020eU,
}

enum : uint
{
    OID_GEN_CO_BYTES_XMIT             = 0x00020201U,
    OID_GEN_CO_BYTES_RCV              = 0x00020207U,
    OID_GEN_CO_NETCARD_LOAD           = 0x00020211U,
    OID_GEN_CO_DEVICE_PROFILE         = 0x00020212U,
    OID_GEN_CO_BYTES_XMIT_OUTSTANDING = 0x00020221U,
}

enum : uint
{
    OID_KDNET_ENUMERATE_PFS        = 0x00020222U,
    OID_KDNET_ADD_PF               = 0x00020223U,
    OID_KDNET_REMOVE_PF            = 0x00020224U,
    OID_KDNET_QUERY_PF_INFORMATION = 0x00020225U,
}

enum uint OID_802_3_PERMANENT_ADDRESS = 0x01010101U;
enum uint OID_802_3_CURRENT_ADDRESS = 0x01010102U;

enum : uint
{
    OID_802_3_MULTICAST_LIST    = 0x01010103U,
    OID_802_3_MAXIMUM_LIST_SIZE = 0x01010104U,
    OID_802_3_MAC_OPTIONS       = 0x01010105U,
}

enum uint NDIS_802_3_MAC_OPTION_PRIORITY = 0x00000001U;
enum uint OID_802_3_RCV_ERROR_ALIGNMENT = 0x01020101U;

enum : uint
{
    OID_802_3_XMIT_ONE_COLLISION   = 0x01020102U,
    OID_802_3_XMIT_MORE_COLLISIONS = 0x01020103U,
    OID_802_3_XMIT_DEFERRED        = 0x01020201U,
    OID_802_3_XMIT_MAX_COLLISIONS  = 0x01020202U,
}

enum : uint
{
    OID_802_3_RCV_OVERRUN            = 0x01020203U,
    OID_802_3_XMIT_UNDERRUN          = 0x01020204U,
    OID_802_3_XMIT_HEARTBEAT_FAILURE = 0x01020205U,
    OID_802_3_XMIT_TIMES_CRS_LOST    = 0x01020206U,
    OID_802_3_XMIT_LATE_COLLISIONS   = 0x01020207U,
}

enum uint OID_802_3_ADD_MULTICAST_ADDRESS = 0x01010208U;
enum uint OID_802_3_DELETE_MULTICAST_ADDRESS = 0x01010209U;
enum uint OID_802_5_PERMANENT_ADDRESS = 0x02010101U;

enum : uint
{
    OID_802_5_CURRENT_ADDRESS    = 0x02010102U,
    OID_802_5_CURRENT_FUNCTIONAL = 0x02010103U,
    OID_802_5_CURRENT_GROUP      = 0x02010104U,
    OID_802_5_LAST_OPEN_STATUS   = 0x02010105U,
}

enum : uint
{
    OID_802_5_CURRENT_RING_STATUS = 0x02010106U,
    OID_802_5_CURRENT_RING_STATE  = 0x02010107U,
}

enum : uint
{
    OID_802_5_LINE_ERRORS      = 0x02020101U,
    OID_802_5_LOST_FRAMES      = 0x02020102U,
    OID_802_5_BURST_ERRORS     = 0x02020201U,
    OID_802_5_AC_ERRORS        = 0x02020202U,
    OID_802_5_ABORT_DELIMETERS = 0x02020203U,
}

enum : uint
{
    OID_802_5_FRAME_COPIED_ERRORS = 0x02020204U,
    OID_802_5_FREQUENCY_ERRORS    = 0x02020205U,
}

enum : uint
{
    OID_802_5_TOKEN_ERRORS    = 0x02020206U,
    OID_802_5_INTERNAL_ERRORS = 0x02020207U,
}

enum : uint
{
    OID_FDDI_LONG_PERMANENT_ADDR = 0x03010101U,
    OID_FDDI_LONG_CURRENT_ADDR   = 0x03010102U,
    OID_FDDI_LONG_MULTICAST_LIST = 0x03010103U,
    OID_FDDI_LONG_MAX_LIST_SIZE  = 0x03010104U,
}

enum : uint
{
    OID_FDDI_SHORT_PERMANENT_ADDR = 0x03010105U,
    OID_FDDI_SHORT_CURRENT_ADDR   = 0x03010106U,
    OID_FDDI_SHORT_MULTICAST_LIST = 0x03010107U,
    OID_FDDI_SHORT_MAX_LIST_SIZE  = 0x03010108U,
}

enum uint OID_FDDI_ATTACHMENT_TYPE = 0x03020101U;
enum uint OID_FDDI_UPSTREAM_NODE_LONG = 0x03020102U;
enum uint OID_FDDI_DOWNSTREAM_NODE_LONG = 0x03020103U;

enum : uint
{
    OID_FDDI_FRAME_ERRORS   = 0x03020104U,
    OID_FDDI_FRAMES_LOST    = 0x03020105U,
    OID_FDDI_RING_MGT_STATE = 0x03020106U,
}

enum : uint
{
    OID_FDDI_LCT_FAILURES      = 0x03020107U,
    OID_FDDI_LEM_REJECTS       = 0x03020108U,
    OID_FDDI_LCONNECTION_STATE = 0x03020109U,
}

enum : uint
{
    OID_FDDI_SMT_STATION_ID           = 0x03030201U,
    OID_FDDI_SMT_OP_VERSION_ID        = 0x03030202U,
    OID_FDDI_SMT_HI_VERSION_ID        = 0x03030203U,
    OID_FDDI_SMT_LO_VERSION_ID        = 0x03030204U,
    OID_FDDI_SMT_MANUFACTURER_DATA    = 0x03030205U,
    OID_FDDI_SMT_USER_DATA            = 0x03030206U,
    OID_FDDI_SMT_MIB_VERSION_ID       = 0x03030207U,
    OID_FDDI_SMT_MAC_CT               = 0x03030208U,
    OID_FDDI_SMT_NON_MASTER_CT        = 0x03030209U,
    OID_FDDI_SMT_MASTER_CT            = 0x0303020aU,
    OID_FDDI_SMT_AVAILABLE_PATHS      = 0x0303020bU,
    OID_FDDI_SMT_CONFIG_CAPABILITIES  = 0x0303020cU,
    OID_FDDI_SMT_CONFIG_POLICY        = 0x0303020dU,
    OID_FDDI_SMT_CONNECTION_POLICY    = 0x0303020eU,
    OID_FDDI_SMT_T_NOTIFY             = 0x0303020fU,
    OID_FDDI_SMT_STAT_RPT_POLICY      = 0x03030210U,
    OID_FDDI_SMT_TRACE_MAX_EXPIRATION = 0x03030211U,
}

enum : uint
{
    OID_FDDI_SMT_PORT_INDEXES           = 0x03030212U,
    OID_FDDI_SMT_MAC_INDEXES            = 0x03030213U,
    OID_FDDI_SMT_BYPASS_PRESENT         = 0x03030214U,
    OID_FDDI_SMT_ECM_STATE              = 0x03030215U,
    OID_FDDI_SMT_CF_STATE               = 0x03030216U,
    OID_FDDI_SMT_HOLD_STATE             = 0x03030217U,
    OID_FDDI_SMT_REMOTE_DISCONNECT_FLAG = 0x03030218U,
}

enum : uint
{
    OID_FDDI_SMT_STATION_STATUS        = 0x03030219U,
    OID_FDDI_SMT_PEER_WRAP_FLAG        = 0x0303021aU,
    OID_FDDI_SMT_MSG_TIME_STAMP        = 0x0303021bU,
    OID_FDDI_SMT_TRANSITION_TIME_STAMP = 0x0303021cU,
}

enum : uint
{
    OID_FDDI_SMT_SET_COUNT           = 0x0303021dU,
    OID_FDDI_SMT_LAST_SET_STATION_ID = 0x0303021eU,
}

enum uint OID_FDDI_MAC_FRAME_STATUS_FUNCTIONS = 0x0303021fU;

enum : uint
{
    OID_FDDI_MAC_BRIDGE_FUNCTIONS     = 0x03030220U,
    OID_FDDI_MAC_T_MAX_CAPABILITY     = 0x03030221U,
    OID_FDDI_MAC_TVX_CAPABILITY       = 0x03030222U,
    OID_FDDI_MAC_AVAILABLE_PATHS      = 0x03030223U,
    OID_FDDI_MAC_CURRENT_PATH         = 0x03030224U,
    OID_FDDI_MAC_UPSTREAM_NBR         = 0x03030225U,
    OID_FDDI_MAC_DOWNSTREAM_NBR       = 0x03030226U,
    OID_FDDI_MAC_OLD_UPSTREAM_NBR     = 0x03030227U,
    OID_FDDI_MAC_OLD_DOWNSTREAM_NBR   = 0x03030228U,
    OID_FDDI_MAC_DUP_ADDRESS_TEST     = 0x03030229U,
    OID_FDDI_MAC_REQUESTED_PATHS      = 0x0303022aU,
    OID_FDDI_MAC_DOWNSTREAM_PORT_TYPE = 0x0303022bU,
}

enum : uint
{
    OID_FDDI_MAC_INDEX                 = 0x0303022cU,
    OID_FDDI_MAC_SMT_ADDRESS           = 0x0303022dU,
    OID_FDDI_MAC_LONG_GRP_ADDRESS      = 0x0303022eU,
    OID_FDDI_MAC_SHORT_GRP_ADDRESS     = 0x0303022fU,
    OID_FDDI_MAC_T_REQ                 = 0x03030230U,
    OID_FDDI_MAC_T_NEG                 = 0x03030231U,
    OID_FDDI_MAC_T_MAX                 = 0x03030232U,
    OID_FDDI_MAC_TVX_VALUE             = 0x03030233U,
    OID_FDDI_MAC_T_PRI0                = 0x03030234U,
    OID_FDDI_MAC_T_PRI1                = 0x03030235U,
    OID_FDDI_MAC_T_PRI2                = 0x03030236U,
    OID_FDDI_MAC_T_PRI3                = 0x03030237U,
    OID_FDDI_MAC_T_PRI4                = 0x03030238U,
    OID_FDDI_MAC_T_PRI5                = 0x03030239U,
    OID_FDDI_MAC_T_PRI6                = 0x0303023aU,
    OID_FDDI_MAC_FRAME_CT              = 0x0303023bU,
    OID_FDDI_MAC_COPIED_CT             = 0x0303023cU,
    OID_FDDI_MAC_TRANSMIT_CT           = 0x0303023dU,
    OID_FDDI_MAC_TOKEN_CT              = 0x0303023eU,
    OID_FDDI_MAC_ERROR_CT              = 0x0303023fU,
    OID_FDDI_MAC_LOST_CT               = 0x03030240U,
    OID_FDDI_MAC_TVX_EXPIRED_CT        = 0x03030241U,
    OID_FDDI_MAC_NOT_COPIED_CT         = 0x03030242U,
    OID_FDDI_MAC_LATE_CT               = 0x03030243U,
    OID_FDDI_MAC_RING_OP_CT            = 0x03030244U,
    OID_FDDI_MAC_FRAME_ERROR_THRESHOLD = 0x03030245U,
    OID_FDDI_MAC_FRAME_ERROR_RATIO     = 0x03030246U,
    OID_FDDI_MAC_NOT_COPIED_THRESHOLD  = 0x03030247U,
    OID_FDDI_MAC_NOT_COPIED_RATIO      = 0x03030248U,
    OID_FDDI_MAC_RMT_STATE             = 0x03030249U,
    OID_FDDI_MAC_DA_FLAG               = 0x0303024aU,
    OID_FDDI_MAC_UNDA_FLAG             = 0x0303024bU,
    OID_FDDI_MAC_FRAME_ERROR_FLAG      = 0x0303024cU,
    OID_FDDI_MAC_NOT_COPIED_FLAG       = 0x0303024dU,
    OID_FDDI_MAC_MA_UNITDATA_AVAILABLE = 0x0303024eU,
}

enum : uint
{
    OID_FDDI_MAC_HARDWARE_PRESENT   = 0x0303024fU,
    OID_FDDI_MAC_MA_UNITDATA_ENABLE = 0x03030250U,
}

enum : uint
{
    OID_FDDI_PATH_INDEX                   = 0x03030251U,
    OID_FDDI_PATH_RING_LATENCY            = 0x03030252U,
    OID_FDDI_PATH_TRACE_STATUS            = 0x03030253U,
    OID_FDDI_PATH_SBA_PAYLOAD             = 0x03030254U,
    OID_FDDI_PATH_SBA_OVERHEAD            = 0x03030255U,
    OID_FDDI_PATH_CONFIGURATION           = 0x03030256U,
    OID_FDDI_PATH_T_R_MODE                = 0x03030257U,
    OID_FDDI_PATH_SBA_AVAILABLE           = 0x03030258U,
    OID_FDDI_PATH_TVX_LOWER_BOUND         = 0x03030259U,
    OID_FDDI_PATH_T_MAX_LOWER_BOUND       = 0x0303025aU,
    OID_FDDI_PATH_MAX_T_REQ               = 0x0303025bU,
    OID_FDDI_PORT_MY_TYPE                 = 0x0303025cU,
    OID_FDDI_PORT_NEIGHBOR_TYPE           = 0x0303025dU,
    OID_FDDI_PORT_CONNECTION_POLICIES     = 0x0303025eU,
    OID_FDDI_PORT_MAC_INDICATED           = 0x0303025fU,
    OID_FDDI_PORT_CURRENT_PATH            = 0x03030260U,
    OID_FDDI_PORT_REQUESTED_PATHS         = 0x03030261U,
    OID_FDDI_PORT_MAC_PLACEMENT           = 0x03030262U,
    OID_FDDI_PORT_AVAILABLE_PATHS         = 0x03030263U,
    OID_FDDI_PORT_MAC_LOOP_TIME           = 0x03030264U,
    OID_FDDI_PORT_PMD_CLASS               = 0x03030265U,
    OID_FDDI_PORT_CONNECTION_CAPABILITIES = 0x03030266U,
}

enum : uint
{
    OID_FDDI_PORT_INDEX            = 0x03030267U,
    OID_FDDI_PORT_MAINT_LS         = 0x03030268U,
    OID_FDDI_PORT_BS_FLAG          = 0x03030269U,
    OID_FDDI_PORT_PC_LS            = 0x0303026aU,
    OID_FDDI_PORT_EB_ERROR_CT      = 0x0303026bU,
    OID_FDDI_PORT_LCT_FAIL_CT      = 0x0303026cU,
    OID_FDDI_PORT_LER_ESTIMATE     = 0x0303026dU,
    OID_FDDI_PORT_LEM_REJECT_CT    = 0x0303026eU,
    OID_FDDI_PORT_LEM_CT           = 0x0303026fU,
    OID_FDDI_PORT_LER_CUTOFF       = 0x03030270U,
    OID_FDDI_PORT_LER_ALARM        = 0x03030271U,
    OID_FDDI_PORT_CONNNECT_STATE   = 0x03030272U,
    OID_FDDI_PORT_PCM_STATE        = 0x03030273U,
    OID_FDDI_PORT_PC_WITHHOLD      = 0x03030274U,
    OID_FDDI_PORT_LER_FLAG         = 0x03030275U,
    OID_FDDI_PORT_HARDWARE_PRESENT = 0x03030276U,
}

enum uint OID_FDDI_SMT_STATION_ACTION = 0x03030277U;

enum : uint
{
    OID_FDDI_PORT_ACTION          = 0x03030278U,
    OID_FDDI_IF_DESCR             = 0x03030279U,
    OID_FDDI_IF_TYPE              = 0x0303027aU,
    OID_FDDI_IF_MTU               = 0x0303027bU,
    OID_FDDI_IF_SPEED             = 0x0303027cU,
    OID_FDDI_IF_PHYS_ADDRESS      = 0x0303027dU,
    OID_FDDI_IF_ADMIN_STATUS      = 0x0303027eU,
    OID_FDDI_IF_OPER_STATUS       = 0x0303027fU,
    OID_FDDI_IF_LAST_CHANGE       = 0x03030280U,
    OID_FDDI_IF_IN_OCTETS         = 0x03030281U,
    OID_FDDI_IF_IN_UCAST_PKTS     = 0x03030282U,
    OID_FDDI_IF_IN_NUCAST_PKTS    = 0x03030283U,
    OID_FDDI_IF_IN_DISCARDS       = 0x03030284U,
    OID_FDDI_IF_IN_ERRORS         = 0x03030285U,
    OID_FDDI_IF_IN_UNKNOWN_PROTOS = 0x03030286U,
    OID_FDDI_IF_OUT_OCTETS        = 0x03030287U,
    OID_FDDI_IF_OUT_UCAST_PKTS    = 0x03030288U,
    OID_FDDI_IF_OUT_NUCAST_PKTS   = 0x03030289U,
    OID_FDDI_IF_OUT_DISCARDS      = 0x0303028aU,
    OID_FDDI_IF_OUT_ERRORS        = 0x0303028bU,
    OID_FDDI_IF_OUT_QLEN          = 0x0303028cU,
    OID_FDDI_IF_SPECIFIC          = 0x0303028dU,
}

enum uint OID_WAN_PERMANENT_ADDRESS = 0x04010101U;
enum uint OID_WAN_CURRENT_ADDRESS = 0x04010102U;
enum uint OID_WAN_QUALITY_OF_SERVICE = 0x04010103U;
enum uint OID_WAN_PROTOCOL_TYPE = 0x04010104U;
enum uint OID_WAN_MEDIUM_SUBTYPE = 0x04010105U;
enum uint OID_WAN_HEADER_FORMAT = 0x04010106U;

enum : uint
{
    OID_WAN_GET_INFO      = 0x04010107U,
    OID_WAN_SET_LINK_INFO = 0x04010108U,
}

enum uint OID_WAN_GET_LINK_INFO = 0x04010109U;

enum : uint
{
    OID_WAN_LINE_COUNT    = 0x0401010aU,
    OID_WAN_PROTOCOL_CAPS = 0x0401010bU,
}

enum uint OID_WAN_GET_BRIDGE_INFO = 0x0401020aU;
enum uint OID_WAN_SET_BRIDGE_INFO = 0x0401020bU;
enum uint OID_WAN_GET_COMP_INFO = 0x0401020cU;
enum uint OID_WAN_SET_COMP_INFO = 0x0401020dU;
enum uint OID_WAN_GET_STATS_INFO = 0x0401020eU;

enum : uint
{
    OID_WAN_CO_GET_INFO       = 0x04010180U,
    OID_WAN_CO_SET_LINK_INFO  = 0x04010181U,
    OID_WAN_CO_GET_LINK_INFO  = 0x04010182U,
    OID_WAN_CO_GET_COMP_INFO  = 0x04010280U,
    OID_WAN_CO_SET_COMP_INFO  = 0x04010281U,
    OID_WAN_CO_GET_STATS_INFO = 0x04010282U,
}

enum uint OID_LTALK_CURRENT_NODE_ID = 0x05010102U;

enum : uint
{
    OID_LTALK_IN_BROADCASTS    = 0x05020101U,
    OID_LTALK_IN_LENGTH_ERRORS = 0x05020102U,
}

enum uint OID_LTALK_OUT_NO_HANDLERS = 0x05020201U;

enum : uint
{
    OID_LTALK_COLLISIONS        = 0x05020202U,
    OID_LTALK_DEFERS            = 0x05020203U,
    OID_LTALK_NO_DATA_ERRORS    = 0x05020204U,
    OID_LTALK_RANDOM_CTS_ERRORS = 0x05020205U,
}

enum uint OID_LTALK_FCS_ERRORS = 0x05020206U;
enum uint OID_ARCNET_PERMANENT_ADDRESS = 0x06010101U;

enum : uint
{
    OID_ARCNET_CURRENT_ADDRESS  = 0x06010102U,
    OID_ARCNET_RECONFIGURATIONS = 0x06020201U,
}

enum : uint
{
    OID_TAPI_ACCEPT                      = 0x07030101U,
    OID_TAPI_ANSWER                      = 0x07030102U,
    OID_TAPI_CLOSE                       = 0x07030103U,
    OID_TAPI_CLOSE_CALL                  = 0x07030104U,
    OID_TAPI_CONDITIONAL_MEDIA_DETECTION = 0x07030105U,
}

enum : uint
{
    OID_TAPI_CONFIG_DIALOG       = 0x07030106U,
    OID_TAPI_DEV_SPECIFIC        = 0x07030107U,
    OID_TAPI_DIAL                = 0x07030108U,
    OID_TAPI_DROP                = 0x07030109U,
    OID_TAPI_GET_ADDRESS_CAPS    = 0x0703010aU,
    OID_TAPI_GET_ADDRESS_ID      = 0x0703010bU,
    OID_TAPI_GET_ADDRESS_STATUS  = 0x0703010cU,
    OID_TAPI_GET_CALL_ADDRESS_ID = 0x0703010dU,
    OID_TAPI_GET_CALL_INFO       = 0x0703010eU,
    OID_TAPI_GET_CALL_STATUS     = 0x0703010fU,
    OID_TAPI_GET_DEV_CAPS        = 0x07030110U,
    OID_TAPI_GET_DEV_CONFIG      = 0x07030111U,
    OID_TAPI_GET_EXTENSION_ID    = 0x07030112U,
    OID_TAPI_GET_ID              = 0x07030113U,
    OID_TAPI_GET_LINE_DEV_STATUS = 0x07030114U,
}

enum : uint
{
    OID_TAPI_MAKE_CALL             = 0x07030115U,
    OID_TAPI_NEGOTIATE_EXT_VERSION = 0x07030116U,
}

enum : uint
{
    OID_TAPI_OPEN                = 0x07030117U,
    OID_TAPI_PROVIDER_INITIALIZE = 0x07030118U,
    OID_TAPI_PROVIDER_SHUTDOWN   = 0x07030119U,
}

enum : uint
{
    OID_TAPI_SECURE_CALL         = 0x0703011aU,
    OID_TAPI_SELECT_EXT_VERSION  = 0x0703011bU,
    OID_TAPI_SEND_USER_USER_INFO = 0x0703011cU,
}

enum : uint
{
    OID_TAPI_SET_APP_SPECIFIC            = 0x0703011dU,
    OID_TAPI_SET_CALL_PARAMS             = 0x0703011eU,
    OID_TAPI_SET_DEFAULT_MEDIA_DETECTION = 0x0703011fU,
    OID_TAPI_SET_DEV_CONFIG              = 0x07030120U,
    OID_TAPI_SET_MEDIA_MODE              = 0x07030121U,
    OID_TAPI_SET_STATUS_MESSAGES         = 0x07030122U,
}

enum : uint
{
    OID_TAPI_GATHER_DIGITS  = 0x07030123U,
    OID_TAPI_MONITOR_DIGITS = 0x07030124U,
}

enum : uint
{
    OID_ATM_SUPPORTED_VC_RATES         = 0x08010101U,
    OID_ATM_SUPPORTED_SERVICE_CATEGORY = 0x08010102U,
    OID_ATM_SUPPORTED_AAL_TYPES        = 0x08010103U,
}

enum uint OID_ATM_HW_CURRENT_ADDRESS = 0x08010104U;

enum : uint
{
    OID_ATM_MAX_ACTIVE_VCS        = 0x08010105U,
    OID_ATM_MAX_ACTIVE_VCI_BITS   = 0x08010106U,
    OID_ATM_MAX_ACTIVE_VPI_BITS   = 0x08010107U,
    OID_ATM_MAX_AAL0_PACKET_SIZE  = 0x08010108U,
    OID_ATM_MAX_AAL1_PACKET_SIZE  = 0x08010109U,
    OID_ATM_MAX_AAL34_PACKET_SIZE = 0x0801010aU,
    OID_ATM_MAX_AAL5_PACKET_SIZE  = 0x0801010bU,
}

enum uint OID_ATM_SIGNALING_VPIVCI = 0x08010201U;

enum : uint
{
    OID_ATM_ASSIGNED_VPI                 = 0x08010202U,
    OID_ATM_ACQUIRE_ACCESS_NET_RESOURCES = 0x08010203U,
}

enum uint OID_ATM_RELEASE_ACCESS_NET_RESOURCES = 0x08010204U;

enum : uint
{
    OID_ATM_ILMI_VPIVCI              = 0x08010205U,
    OID_ATM_DIGITAL_BROADCAST_VPIVCI = 0x08010206U,
}

enum uint OID_ATM_GET_NEAREST_FLOW = 0x08010207U;
enum uint OID_ATM_ALIGNMENT_REQUIRED = 0x08010208U;
enum uint OID_ATM_LECS_ADDRESS = 0x08010209U;
enum uint OID_ATM_SERVICE_ADDRESS = 0x0801020aU;

enum : uint
{
    OID_ATM_CALL_PROCEEDING = 0x0801020bU,
    OID_ATM_CALL_ALERTING   = 0x0801020cU,
}

enum uint OID_ATM_PARTY_ALERTING = 0x0801020dU;

enum : uint
{
    OID_ATM_CALL_NOTIFY      = 0x0801020eU,
    OID_ATM_MY_IP_NM_ADDRESS = 0x0801020fU,
}

enum uint OID_ATM_RCV_CELLS_OK = 0x08020101U;
enum uint OID_ATM_XMIT_CELLS_OK = 0x08020102U;

enum : uint
{
    OID_ATM_RCV_CELLS_DROPPED   = 0x08020103U,
    OID_ATM_RCV_INVALID_VPI_VCI = 0x08020201U,
}

enum uint OID_ATM_CELLS_HEC_ERROR = 0x08020202U;
enum uint OID_ATM_RCV_REASSEMBLY_ERROR = 0x08020203U;

enum : uint
{
    OID_802_11_BSSID                   = 0x0d010101U,
    OID_802_11_SSID                    = 0x0d010102U,
    OID_802_11_NETWORK_TYPES_SUPPORTED = 0x0d010203U,
    OID_802_11_NETWORK_TYPE_IN_USE     = 0x0d010204U,
}

enum : uint
{
    OID_802_11_TX_POWER_LEVEL      = 0x0d010205U,
    OID_802_11_RSSI                = 0x0d010206U,
    OID_802_11_RSSI_TRIGGER        = 0x0d010207U,
    OID_802_11_INFRASTRUCTURE_MODE = 0x0d010108U,
}

enum uint OID_802_11_FRAGMENTATION_THRESHOLD = 0x0d010209U;

enum : uint
{
    OID_802_11_RTS_THRESHOLD      = 0x0d01020aU,
    OID_802_11_NUMBER_OF_ANTENNAS = 0x0d01020bU,
}

enum uint OID_802_11_RX_ANTENNA_SELECTED = 0x0d01020cU;
enum uint OID_802_11_TX_ANTENNA_SELECTED = 0x0d01020dU;

enum : uint
{
    OID_802_11_SUPPORTED_RATES     = 0x0d01020eU,
    OID_802_11_DESIRED_RATES       = 0x0d010210U,
    OID_802_11_CONFIGURATION       = 0x0d010211U,
    OID_802_11_STATISTICS          = 0x0d020212U,
    OID_802_11_ADD_WEP             = 0x0d010113U,
    OID_802_11_REMOVE_WEP          = 0x0d010114U,
    OID_802_11_DISASSOCIATE        = 0x0d010115U,
    OID_802_11_POWER_MODE          = 0x0d010216U,
    OID_802_11_BSSID_LIST          = 0x0d010217U,
    OID_802_11_AUTHENTICATION_MODE = 0x0d010118U,
}

enum : uint
{
    OID_802_11_PRIVACY_FILTER    = 0x0d010119U,
    OID_802_11_BSSID_LIST_SCAN   = 0x0d01011aU,
    OID_802_11_WEP_STATUS        = 0x0d01011bU,
    OID_802_11_ENCRYPTION_STATUS = 0x0d01011bU,
}

enum : uint
{
    OID_802_11_RELOAD_DEFAULTS         = 0x0d01011cU,
    OID_802_11_ADD_KEY                 = 0x0d01011dU,
    OID_802_11_REMOVE_KEY              = 0x0d01011eU,
    OID_802_11_ASSOCIATION_INFORMATION = 0x0d01011fU,
}

enum : uint
{
    OID_802_11_TEST              = 0x0d010120U,
    OID_802_11_MEDIA_STREAM_MODE = 0x0d010121U,
}

enum : uint
{
    OID_802_11_CAPABILITY          = 0x0d010122U,
    OID_802_11_PMKID               = 0x0d010123U,
    OID_802_11_NON_BCAST_SSID_LIST = 0x0d010124U,
}

enum uint OID_802_11_RADIO_STATUS = 0x0d010125U;

enum : uint
{
    NDIS_ETH_TYPE_IPV4          = 0x00000800U,
    NDIS_ETH_TYPE_ARP           = 0x00000806U,
    NDIS_ETH_TYPE_IPV6          = 0x000086ddU,
    NDIS_ETH_TYPE_802_1X        = 0x0000888eU,
    NDIS_ETH_TYPE_802_1Q        = 0x00008100U,
    NDIS_ETH_TYPE_SLOW_PROTOCOL = 0x00008809U,
}

enum : uint
{
    NDIS_802_11_LENGTH_SSID                 = 0x00000020U,
    NDIS_802_11_LENGTH_RATES                = 0x00000008U,
    NDIS_802_11_LENGTH_RATES_EX             = 0x00000010U,
    NDIS_802_11_AUTH_REQUEST_AUTH_FIELDS    = 0x0000000fU,
    NDIS_802_11_AUTH_REQUEST_REAUTH         = 0x00000001U,
    NDIS_802_11_AUTH_REQUEST_KEYUPDATE      = 0x00000002U,
    NDIS_802_11_AUTH_REQUEST_PAIRWISE_ERROR = 0x00000006U,
    NDIS_802_11_AUTH_REQUEST_GROUP_ERROR    = 0x0000000eU,
}

enum uint NDIS_802_11_PMKID_CANDIDATE_PREAUTH_ENABLED = 0x00000001U;

enum : uint
{
    NDIS_802_11_AI_REQFI_CAPABILITIES     = 0x00000001U,
    NDIS_802_11_AI_REQFI_LISTENINTERVAL   = 0x00000002U,
    NDIS_802_11_AI_REQFI_CURRENTAPADDRESS = 0x00000004U,
    NDIS_802_11_AI_RESFI_CAPABILITIES     = 0x00000001U,
    NDIS_802_11_AI_RESFI_STATUSCODE       = 0x00000002U,
    NDIS_802_11_AI_RESFI_ASSOCIATIONID    = 0x00000004U,
}

enum : uint
{
    OID_IRDA_RECEIVING       = 0x0a010100U,
    OID_IRDA_TURNAROUND_TIME = 0x0a010101U,
}

enum uint OID_IRDA_SUPPORTED_SPEEDS = 0x0a010102U;

enum : uint
{
    OID_IRDA_LINK_SPEED     = 0x0a010103U,
    OID_IRDA_MEDIA_BUSY     = 0x0a010104U,
    OID_IRDA_EXTRA_RCV_BOFS = 0x0a010200U,
}

enum : uint
{
    OID_IRDA_RATE_SNIFF              = 0x0a010201U,
    OID_IRDA_UNICAST_LIST            = 0x0a010202U,
    OID_IRDA_MAX_UNICAST_LIST_SIZE   = 0x0a010203U,
    OID_IRDA_MAX_RECEIVE_WINDOW_SIZE = 0x0a010204U,
    OID_IRDA_MAX_SEND_WINDOW_SIZE    = 0x0a010205U,
}

enum : uint
{
    OID_IRDA_RESERVED1 = 0x0a01020aU,
    OID_IRDA_RESERVED2 = 0x0a01020fU,
}

enum uint OID_1394_LOCAL_NODE_INFO = 0x0c010101U;
enum uint OID_1394_VC_INFO = 0x0c010102U;

enum : uint
{
    OID_CO_ADD_PVC              = 0xfe000001U,
    OID_CO_DELETE_PVC           = 0xfe000002U,
    OID_CO_GET_CALL_INFORMATION = 0xfe000003U,
}

enum uint OID_CO_ADD_ADDRESS = 0xfe000004U;
enum uint OID_CO_DELETE_ADDRESS = 0xfe000005U;
enum uint OID_CO_GET_ADDRESSES = 0xfe000006U;
enum uint OID_CO_ADDRESS_CHANGE = 0xfe000007U;

enum : uint
{
    OID_CO_SIGNALING_ENABLED  = 0xfe000008U,
    OID_CO_SIGNALING_DISABLED = 0xfe000009U,
}

enum : uint
{
    OID_CO_AF_CLOSE                       = 0xfe00000aU,
    OID_CO_TAPI_CM_CAPS                   = 0xfe001001U,
    OID_CO_TAPI_LINE_CAPS                 = 0xfe001002U,
    OID_CO_TAPI_ADDRESS_CAPS              = 0xfe001003U,
    OID_CO_TAPI_TRANSLATE_TAPI_CALLPARAMS = 0xfe001004U,
    OID_CO_TAPI_TRANSLATE_NDIS_CALLPARAMS = 0xfe001005U,
    OID_CO_TAPI_TRANSLATE_TAPI_SAP        = 0xfe001006U,
}

enum uint OID_CO_TAPI_GET_CALL_DIAGNOSTICS = 0xfe001007U;

enum : uint
{
    OID_CO_TAPI_REPORT_DIGITS      = 0xfe001008U,
    OID_CO_TAPI_DONT_REPORT_DIGITS = 0xfe001009U,
}

enum uint OID_PNP_CAPABILITIES = 0xfd010100U;

enum : uint
{
    OID_PNP_SET_POWER           = 0xfd010101U,
    OID_PNP_QUERY_POWER         = 0xfd010102U,
    OID_PNP_ADD_WAKE_UP_PATTERN = 0xfd010103U,
}

enum uint OID_PNP_REMOVE_WAKE_UP_PATTERN = 0xfd010104U;
enum uint OID_PNP_WAKE_UP_PATTERN_LIST = 0xfd010105U;
enum uint OID_PNP_ENABLE_WAKE_UP = 0xfd010106U;

enum : uint
{
    OID_PNP_WAKE_UP_OK    = 0xfd020200U,
    OID_PNP_WAKE_UP_ERROR = 0xfd020201U,
}

enum uint OID_PM_CURRENT_CAPABILITIES = 0xfd010107U;
enum uint OID_PM_HARDWARE_CAPABILITIES = 0xfd010108U;

enum : uint
{
    OID_PM_PARAMETERS      = 0xfd010109U,
    OID_PM_ADD_WOL_PATTERN = 0xfd01010aU,
}

enum uint OID_PM_REMOVE_WOL_PATTERN = 0xfd01010bU;
enum uint OID_PM_WOL_PATTERN_LIST = 0xfd01010cU;
enum uint OID_PM_ADD_PROTOCOL_OFFLOAD = 0xfd01010dU;
enum uint OID_PM_GET_PROTOCOL_OFFLOAD = 0xfd01010eU;
enum uint OID_PM_REMOVE_PROTOCOL_OFFLOAD = 0xfd01010fU;
enum uint OID_PM_PROTOCOL_OFFLOAD_LIST = 0xfd010110U;
enum uint OID_PM_RESERVED_1 = 0xfd010111U;

enum : uint
{
    OID_RECEIVE_FILTER_HARDWARE_CAPABILITIES     = 0x00010221U,
    OID_RECEIVE_FILTER_GLOBAL_PARAMETERS         = 0x00010222U,
    OID_RECEIVE_FILTER_ALLOCATE_QUEUE            = 0x00010223U,
    OID_RECEIVE_FILTER_FREE_QUEUE                = 0x00010224U,
    OID_RECEIVE_FILTER_ENUM_QUEUES               = 0x00010225U,
    OID_RECEIVE_FILTER_QUEUE_PARAMETERS          = 0x00010226U,
    OID_RECEIVE_FILTER_SET_FILTER                = 0x00010227U,
    OID_RECEIVE_FILTER_CLEAR_FILTER              = 0x00010228U,
    OID_RECEIVE_FILTER_ENUM_FILTERS              = 0x00010229U,
    OID_RECEIVE_FILTER_PARAMETERS                = 0x0001022aU,
    OID_RECEIVE_FILTER_QUEUE_ALLOCATION_COMPLETE = 0x0001022bU,
    OID_RECEIVE_FILTER_CURRENT_CAPABILITIES      = 0x0001022dU,
}

enum : uint
{
    OID_NIC_SWITCH_HARDWARE_CAPABILITIES = 0x0001022eU,
    OID_NIC_SWITCH_CURRENT_CAPABILITIES  = 0x0001022fU,
}

enum uint OID_RECEIVE_FILTER_MOVE_FILTER = 0x00010230U;

enum : uint
{
    OID_VLAN_RESERVED1 = 0x00010231U,
    OID_VLAN_RESERVED2 = 0x00010232U,
    OID_VLAN_RESERVED3 = 0x00010233U,
    OID_VLAN_RESERVED4 = 0x00010234U,
}

enum uint OID_PACKET_COALESCING_FILTER_MATCH_COUNT = 0x00010235U;

enum : uint
{
    OID_NIC_SWITCH_CREATE_SWITCH    = 0x00010237U,
    OID_NIC_SWITCH_PARAMETERS       = 0x00010238U,
    OID_NIC_SWITCH_DELETE_SWITCH    = 0x00010239U,
    OID_NIC_SWITCH_ENUM_SWITCHES    = 0x00010240U,
    OID_NIC_SWITCH_CREATE_VPORT     = 0x00010241U,
    OID_NIC_SWITCH_VPORT_PARAMETERS = 0x00010242U,
    OID_NIC_SWITCH_ENUM_VPORTS      = 0x00010243U,
    OID_NIC_SWITCH_DELETE_VPORT     = 0x00010244U,
    OID_NIC_SWITCH_ALLOCATE_VF      = 0x00010245U,
    OID_NIC_SWITCH_FREE_VF          = 0x00010246U,
    OID_NIC_SWITCH_VF_PARAMETERS    = 0x00010247U,
    OID_NIC_SWITCH_ENUM_VFS         = 0x00010248U,
}

enum uint OID_SRIOV_HARDWARE_CAPABILITIES = 0x00010249U;
enum uint OID_SRIOV_CURRENT_CAPABILITIES = 0x00010250U;
enum uint OID_SRIOV_READ_VF_CONFIG_SPACE = 0x00010251U;
enum uint OID_SRIOV_WRITE_VF_CONFIG_SPACE = 0x00010252U;
enum uint OID_SRIOV_READ_VF_CONFIG_BLOCK = 0x00010253U;
enum uint OID_SRIOV_WRITE_VF_CONFIG_BLOCK = 0x00010254U;

enum : uint
{
    OID_SRIOV_RESET_VF           = 0x00010255U,
    OID_SRIOV_SET_VF_POWER_STATE = 0x00010256U,
}

enum uint OID_SRIOV_VF_VENDOR_DEVICE_ID = 0x00010257U;

enum : uint
{
    OID_SRIOV_PROBED_BARS      = 0x00010258U,
    OID_SRIOV_BAR_RESOURCES    = 0x00010259U,
    OID_SRIOV_PF_LUID          = 0x00010260U,
    OID_SRIOV_CONFIG_STATE     = 0x00010261U,
    OID_SRIOV_VF_SERIAL_NUMBER = 0x00010262U,
}

enum uint OID_SRIOV_OVERLYING_ADAPTER_INFO = 0x00010268U;
enum uint OID_SRIOV_VF_INVALIDATE_CONFIG_BLOCK = 0x00010269U;

enum : uint
{
    OID_SWITCH_PROPERTY_ADD         = 0x00010263U,
    OID_SWITCH_PROPERTY_UPDATE      = 0x00010264U,
    OID_SWITCH_PROPERTY_DELETE      = 0x00010265U,
    OID_SWITCH_PROPERTY_ENUM        = 0x00010266U,
    OID_SWITCH_FEATURE_STATUS_QUERY = 0x00010267U,
}

enum : uint
{
    OID_SWITCH_NIC_REQUEST                      = 0x00010270U,
    OID_SWITCH_PORT_PROPERTY_ADD                = 0x00010271U,
    OID_SWITCH_PORT_PROPERTY_UPDATE             = 0x00010272U,
    OID_SWITCH_PORT_PROPERTY_DELETE             = 0x00010273U,
    OID_SWITCH_PORT_PROPERTY_ENUM               = 0x00010274U,
    OID_SWITCH_PARAMETERS                       = 0x00010275U,
    OID_SWITCH_PORT_ARRAY                       = 0x00010276U,
    OID_SWITCH_NIC_ARRAY                        = 0x00010277U,
    OID_SWITCH_PORT_CREATE                      = 0x00010278U,
    OID_SWITCH_PORT_DELETE                      = 0x00010279U,
    OID_SWITCH_NIC_CREATE                       = 0x0001027aU,
    OID_SWITCH_NIC_CONNECT                      = 0x0001027bU,
    OID_SWITCH_NIC_DISCONNECT                   = 0x0001027cU,
    OID_SWITCH_NIC_DELETE                       = 0x0001027dU,
    OID_SWITCH_PORT_FEATURE_STATUS_QUERY        = 0x0001027eU,
    OID_SWITCH_PORT_TEARDOWN                    = 0x0001027fU,
    OID_SWITCH_NIC_SAVE                         = 0x00010290U,
    OID_SWITCH_NIC_SAVE_COMPLETE                = 0x00010291U,
    OID_SWITCH_NIC_RESTORE                      = 0x00010292U,
    OID_SWITCH_NIC_RESTORE_COMPLETE             = 0x00010293U,
    OID_SWITCH_NIC_UPDATED                      = 0x00010294U,
    OID_SWITCH_PORT_UPDATED                     = 0x00010295U,
    OID_SWITCH_NIC_DIRECT_REQUEST               = 0x00010296U,
    OID_SWITCH_NIC_SUSPEND                      = 0x00010297U,
    OID_SWITCH_NIC_RESUME                       = 0x00010298U,
    OID_SWITCH_NIC_SUSPENDED_LM_SOURCE_STARTED  = 0x00010299U,
    OID_SWITCH_NIC_SUSPENDED_LM_SOURCE_FINISHED = 0x0001029aU,
}

enum uint OID_GEN_RSS_SET_INDIRECTION_TABLE_ENTRIES = 0x000102c0U;
enum uint OID_GEN_ISOLATION_PARAMETERS = 0x00010300U;
enum uint OID_GFT_HARDWARE_CAPABILITIES = 0x00010401U;
enum uint OID_GFT_CURRENT_CAPABILITIES = 0x00010402U;
enum uint OID_GFT_GLOBAL_PARAMETERS = 0x00010403U;
enum uint OID_GFT_CREATE_TABLE = 0x00010404U;
enum uint OID_GFT_DELETE_TABLE = 0x00010405U;

enum : uint
{
    OID_GFT_ENUM_TABLES       = 0x00010406U,
    OID_GFT_ALLOCATE_COUNTERS = 0x00010407U,
}

enum uint OID_GFT_FREE_COUNTERS = 0x00010408U;
enum uint OID_GFT_ENUM_COUNTERS = 0x00010409U;
enum uint OID_GFT_COUNTER_VALUES = 0x0001040aU;

enum : uint
{
    OID_GFT_STATISTICS       = 0x0001040bU,
    OID_GFT_ADD_FLOW_ENTRIES = 0x0001040cU,
}

enum uint OID_GFT_DELETE_FLOW_ENTRIES = 0x0001040dU;
enum uint OID_GFT_ENUM_FLOW_ENTRIES = 0x0001040eU;
enum uint OID_GFT_ACTIVATE_FLOW_ENTRIES = 0x0001040fU;
enum uint OID_GFT_DEACTIVATE_FLOW_ENTRIES = 0x00010410U;
enum uint OID_GFT_FLOW_ENTRY_PARAMETERS = 0x00010411U;
enum uint OID_GFT_EXACT_MATCH_PROFILE = 0x00010412U;
enum uint OID_GFT_HEADER_TRANSPOSITION_PROFILE = 0x00010413U;
enum uint OID_GFT_WILDCARD_MATCH_PROFILE = 0x00010414U;
enum uint OID_GFT_ENUM_PROFILES = 0x00010415U;
enum uint OID_GFT_DELETE_PROFILE = 0x00010416U;
enum uint OID_GFT_VPORT_PARAMETERS = 0x00010417U;
enum uint OID_GFT_CREATE_LOGICAL_VPORT = 0x00010418U;
enum uint OID_GFT_DELETE_LOGICAL_VPORT = 0x00010419U;
enum uint OID_GFT_ENUM_LOGICAL_VPORTS = 0x0001041aU;

enum : uint
{
    OID_QOS_OFFLOAD_HARDWARE_CAPABILITIES = 0x00010601U,
    OID_QOS_OFFLOAD_CURRENT_CAPABILITIES  = 0x00010602U,
    OID_QOS_OFFLOAD_CREATE_SQ             = 0x00010603U,
    OID_QOS_OFFLOAD_DELETE_SQ             = 0x00010604U,
    OID_QOS_OFFLOAD_UPDATE_SQ             = 0x00010605U,
    OID_QOS_OFFLOAD_ENUM_SQS              = 0x00010606U,
    OID_QOS_OFFLOAD_SQ_STATS              = 0x00010607U,
}

enum uint OID_PD_OPEN_PROVIDER = 0x00010501U;
enum uint OID_PD_CLOSE_PROVIDER = 0x00010502U;
enum uint OID_PD_QUERY_CURRENT_CONFIG = 0x00010503U;

enum : uint
{
    NDIS_PNP_WAKE_UP_MAGIC_PACKET  = 0x00000001U,
    NDIS_PNP_WAKE_UP_PATTERN_MATCH = 0x00000002U,
    NDIS_PNP_WAKE_UP_LINK_CHANGE   = 0x00000004U,
}

enum : uint
{
    OID_TCP_TASK_OFFLOAD         = 0xfc010201U,
    OID_TCP_TASK_IPSEC_ADD_SA    = 0xfc010202U,
    OID_TCP_TASK_IPSEC_DELETE_SA = 0xfc010203U,
}

enum : uint
{
    OID_TCP_SAN_SUPPORT                 = 0xfc010204U,
    OID_TCP_TASK_IPSEC_ADD_UDPESP_SA    = 0xfc010205U,
    OID_TCP_TASK_IPSEC_DELETE_UDPESP_SA = 0xfc010206U,
}

enum uint OID_TCP4_OFFLOAD_STATS = 0xfc010207U;
enum uint OID_TCP6_OFFLOAD_STATS = 0xfc010208U;
enum uint OID_IP4_OFFLOAD_STATS = 0xfc010209U;
enum uint OID_IP6_OFFLOAD_STATS = 0xfc01020aU;

enum : uint
{
    OID_TCP_OFFLOAD_CURRENT_CONFIG        = 0xfc01020bU,
    OID_TCP_OFFLOAD_PARAMETERS            = 0xfc01020cU,
    OID_TCP_OFFLOAD_HARDWARE_CAPABILITIES = 0xfc01020dU,
}

enum : uint
{
    OID_TCP_CONNECTION_OFFLOAD_CURRENT_CONFIG        = 0xfc01020eU,
    OID_TCP_CONNECTION_OFFLOAD_HARDWARE_CAPABILITIES = 0xfc01020fU,
}

enum uint OID_OFFLOAD_ENCAPSULATION = 0x0101010aU;

enum : uint
{
    OID_TCP_TASK_IPSEC_OFFLOAD_V2_ADD_SA    = 0xfc030202U,
    OID_TCP_TASK_IPSEC_OFFLOAD_V2_DELETE_SA = 0xfc030203U,
    OID_TCP_TASK_IPSEC_OFFLOAD_V2_UPDATE_SA = 0xfc030204U,
    OID_TCP_TASK_IPSEC_OFFLOAD_V2_ADD_SA_EX = 0xfc030205U,
}

enum : uint
{
    OID_FFP_SUPPORT      = 0xfc010210U,
    OID_FFP_FLUSH        = 0xfc010211U,
    OID_FFP_CONTROL      = 0xfc010212U,
    OID_FFP_PARAMS       = 0xfc010213U,
    OID_FFP_DATA         = 0xfc010214U,
    OID_FFP_DRIVER_STATS = 0xfc020210U,
}

enum uint OID_FFP_ADAPTER_STATS = 0xfc020211U;
enum uint OID_TCP_CONNECTION_OFFLOAD_PARAMETERS = 0xfc030201U;

enum : uint
{
    OID_TUNNEL_INTERFACE_SET_OID     = 0x0f010106U,
    OID_TUNNEL_INTERFACE_RELEASE_OID = 0x0f010107U,
}

enum : uint
{
    OID_QOS_RESERVED1  = 0xfb010100U,
    OID_QOS_RESERVED2  = 0xfb010101U,
    OID_QOS_RESERVED3  = 0xfb010102U,
    OID_QOS_RESERVED4  = 0xfb010103U,
    OID_QOS_RESERVED5  = 0xfb010104U,
    OID_QOS_RESERVED6  = 0xfb010105U,
    OID_QOS_RESERVED7  = 0xfb010106U,
    OID_QOS_RESERVED8  = 0xfb010107U,
    OID_QOS_RESERVED9  = 0xfb010108U,
    OID_QOS_RESERVED10 = 0xfb010109U,
    OID_QOS_RESERVED11 = 0xfb01010aU,
    OID_QOS_RESERVED12 = 0xfb01010bU,
    OID_QOS_RESERVED13 = 0xfb01010cU,
    OID_QOS_RESERVED14 = 0xfb01010dU,
    OID_QOS_RESERVED15 = 0xfb01010eU,
    OID_QOS_RESERVED16 = 0xfb01010fU,
    OID_QOS_RESERVED17 = 0xfb010110U,
    OID_QOS_RESERVED18 = 0xfb010111U,
    OID_QOS_RESERVED19 = 0xfb010112U,
    OID_QOS_RESERVED20 = 0xfb010113U,
}

enum uint OID_XBOX_ACC_RESERVED0 = 0xfa000000U;

enum : uint
{
    OFFLOAD_MAX_SAS     = 0x00000003U,
    OFFLOAD_INBOUND_SA  = 0x00000001U,
    OFFLOAD_OUTBOUND_SA = 0x00000002U,
}

enum : uint
{
    NDIS_PROTOCOL_ID_DEFAULT = 0x00000000U,
    NDIS_PROTOCOL_ID_TCP_IP  = 0x00000002U,
    NDIS_PROTOCOL_ID_IP6     = 0x00000003U,
    NDIS_PROTOCOL_ID_IPX     = 0x00000006U,
    NDIS_PROTOCOL_ID_NBF     = 0x00000007U,
    NDIS_PROTOCOL_ID_MAX     = 0x0000000fU,
    NDIS_PROTOCOL_ID_MASK    = 0x0000000fU,
}

enum uint READABLE_LOCAL_CLOCK = 0x00000001U;
enum uint CLOCK_NETWORK_DERIVED = 0x00000002U;
enum uint CLOCK_PRECISION = 0x00000004U;
enum uint RECEIVE_TIME_INDICATION_CAPABLE = 0x00000008U;
enum uint TIMED_SEND_CAPABLE = 0x00000010U;
enum uint TIME_STAMP_CAPABLE = 0x00000020U;

enum : uint
{
    NDIS_DEVICE_WAKE_UP_ENABLE               = 0x00000001U,
    NDIS_DEVICE_WAKE_ON_PATTERN_MATCH_ENABLE = 0x00000002U,
    NDIS_DEVICE_WAKE_ON_MAGIC_PACKET_ENABLE  = 0x00000004U,
}

enum uint WAN_PROTOCOL_KEEPS_STATS = 0x00000001U;

enum : uint
{
    fNDIS_GUID_TO_OID                = 0x00000001U,
    fNDIS_GUID_TO_STATUS             = 0x00000002U,
    fNDIS_GUID_ANSI_STRING           = 0x00000004U,
    fNDIS_GUID_UNICODE_STRING        = 0x00000008U,
    fNDIS_GUID_ARRAY                 = 0x00000010U,
    fNDIS_GUID_ALLOW_READ            = 0x00000020U,
    fNDIS_GUID_ALLOW_WRITE           = 0x00000040U,
    fNDIS_GUID_METHOD                = 0x00000080U,
    fNDIS_GUID_NDIS_RESERVED         = 0x00000100U,
    fNDIS_GUID_SUPPORT_COMMON_HEADER = 0x00000200U,
}

enum : uint
{
    NDIS_PACKET_TYPE_DIRECTED       = 0x00000001U,
    NDIS_PACKET_TYPE_MULTICAST      = 0x00000002U,
    NDIS_PACKET_TYPE_ALL_MULTICAST  = 0x00000004U,
    NDIS_PACKET_TYPE_BROADCAST      = 0x00000008U,
    NDIS_PACKET_TYPE_SOURCE_ROUTING = 0x00000010U,
    NDIS_PACKET_TYPE_PROMISCUOUS    = 0x00000020U,
    NDIS_PACKET_TYPE_SMT            = 0x00000040U,
    NDIS_PACKET_TYPE_ALL_LOCAL      = 0x00000080U,
    NDIS_PACKET_TYPE_GROUP          = 0x00001000U,
    NDIS_PACKET_TYPE_ALL_FUNCTIONAL = 0x00002000U,
    NDIS_PACKET_TYPE_FUNCTIONAL     = 0x00004000U,
    NDIS_PACKET_TYPE_MAC_FRAME      = 0x00008000U,
    NDIS_PACKET_TYPE_NO_LOCAL       = 0x00010000U,
}

enum : uint
{
    NDIS_RING_SIGNAL_LOSS     = 0x00008000U,
    NDIS_RING_HARD_ERROR      = 0x00004000U,
    NDIS_RING_SOFT_ERROR      = 0x00002000U,
    NDIS_RING_TRANSMIT_BEACON = 0x00001000U,
}

enum uint NDIS_RING_LOBE_WIRE_FAULT = 0x00000800U;
enum uint NDIS_RING_AUTO_REMOVAL_ERROR = 0x00000400U;
enum uint NDIS_RING_REMOVE_RECEIVED = 0x00000200U;
enum uint NDIS_RING_COUNTER_OVERFLOW = 0x00000100U;

enum : uint
{
    NDIS_RING_SINGLE_STATION = 0x00000080U,
    NDIS_RING_RING_RECOVERY  = 0x00000040U,
}

enum : uint
{
    NDIS_PROT_OPTION_ESTIMATED_LENGTH  = 0x00000001U,
    NDIS_PROT_OPTION_NO_LOOPBACK       = 0x00000002U,
    NDIS_PROT_OPTION_NO_RSVD_ON_RCVPKT = 0x00000004U,
    NDIS_PROT_OPTION_SEND_RESTRICTED   = 0x00000008U,
}

enum : uint
{
    NDIS_MAC_OPTION_COPY_LOOKAHEAD_DATA            = 0x00000001U,
    NDIS_MAC_OPTION_RECEIVE_SERIALIZED             = 0x00000002U,
    NDIS_MAC_OPTION_TRANSFERS_NOT_PEND             = 0x00000004U,
    NDIS_MAC_OPTION_NO_LOOPBACK                    = 0x00000008U,
    NDIS_MAC_OPTION_FULL_DUPLEX                    = 0x00000010U,
    NDIS_MAC_OPTION_EOTX_INDICATION                = 0x00000020U,
    NDIS_MAC_OPTION_8021P_PRIORITY                 = 0x00000040U,
    NDIS_MAC_OPTION_SUPPORTS_MAC_ADDRESS_OVERWRITE = 0x00000080U,
}

enum : uint
{
    NDIS_MAC_OPTION_RECEIVE_AT_DPC = 0x00000100U,
    NDIS_MAC_OPTION_8021Q_VLAN     = 0x00000200U,
    NDIS_MAC_OPTION_RESERVED       = 0x80000000U,
}

enum : uint
{
    NDIS_MEDIA_CAP_TRANSMIT = 0x00000001U,
    NDIS_MEDIA_CAP_RECEIVE  = 0x00000002U,
}

enum uint NDIS_CO_MAC_OPTION_DYNAMIC_LINK_SPEED = 0x00000001U;
enum uint NDIS_LINK_STATE_XMIT_LINK_SPEED_AUTO_NEGOTIATED = 0x00000001U;
enum uint NDIS_LINK_STATE_RCV_LINK_SPEED_AUTO_NEGOTIATED = 0x00000002U;

enum : uint
{
    NDIS_LINK_STATE_DUPLEX_AUTO_NEGOTIATED          = 0x00000004U,
    NDIS_LINK_STATE_PAUSE_FUNCTIONS_AUTO_NEGOTIATED = 0x00000008U,
}

enum uint NDIS_LINK_STATE_REVISION_1 = 0x00000001U;
enum uint NDIS_LINK_PARAMETERS_REVISION_1 = 0x00000001U;
enum uint NDIS_OPER_STATE_REVISION_1 = 0x00000001U;
enum uint MAXIMUM_IP_OPER_STATUS_ADDRESS_FAMILIES_SUPPORTED = 0x00000020U;

enum : uint
{
    NDIS_IP_OPER_STATUS_INFO_REVISION_1 = 0x00000001U,
    NDIS_IP_OPER_STATE_REVISION_1       = 0x00000001U,
}

enum : uint
{
    NDIS_OFFLOAD_PARAMETERS_NO_CHANGE                  = 0x00000000U,
    NDIS_OFFLOAD_PARAMETERS_TX_RX_DISABLED             = 0x00000001U,
    NDIS_OFFLOAD_PARAMETERS_TX_ENABLED_RX_DISABLED     = 0x00000002U,
    NDIS_OFFLOAD_PARAMETERS_RX_ENABLED_TX_DISABLED     = 0x00000003U,
    NDIS_OFFLOAD_PARAMETERS_TX_RX_ENABLED              = 0x00000004U,
    NDIS_OFFLOAD_PARAMETERS_LSOV1_DISABLED             = 0x00000001U,
    NDIS_OFFLOAD_PARAMETERS_LSOV1_ENABLED              = 0x00000002U,
    NDIS_OFFLOAD_PARAMETERS_IPSECV1_DISABLED           = 0x00000001U,
    NDIS_OFFLOAD_PARAMETERS_IPSECV1_AH_ENABLED         = 0x00000002U,
    NDIS_OFFLOAD_PARAMETERS_IPSECV1_ESP_ENABLED        = 0x00000003U,
    NDIS_OFFLOAD_PARAMETERS_IPSECV1_AH_AND_ESP_ENABLED = 0x00000004U,
    NDIS_OFFLOAD_PARAMETERS_LSOV2_DISABLED             = 0x00000001U,
    NDIS_OFFLOAD_PARAMETERS_LSOV2_ENABLED              = 0x00000002U,
    NDIS_OFFLOAD_PARAMETERS_IPSECV2_DISABLED           = 0x00000001U,
    NDIS_OFFLOAD_PARAMETERS_IPSECV2_AH_ENABLED         = 0x00000002U,
    NDIS_OFFLOAD_PARAMETERS_IPSECV2_ESP_ENABLED        = 0x00000003U,
    NDIS_OFFLOAD_PARAMETERS_IPSECV2_AH_AND_ESP_ENABLED = 0x00000004U,
    NDIS_OFFLOAD_PARAMETERS_RSC_DISABLED               = 0x00000001U,
    NDIS_OFFLOAD_PARAMETERS_RSC_ENABLED                = 0x00000002U,
}

enum : uint
{
    NDIS_ENCAPSULATION_TYPE_GRE_MAC = 0x00000001U,
    NDIS_ENCAPSULATION_TYPE_VXLAN   = 0x00000002U,
}

enum : uint
{
    NDIS_OFFLOAD_PARAMETERS_CONNECTION_OFFLOAD_DISABLED = 0x00000001U,
    NDIS_OFFLOAD_PARAMETERS_CONNECTION_OFFLOAD_ENABLED  = 0x00000002U,
    NDIS_OFFLOAD_PARAMETERS_USO_DISABLED                = 0x00000001U,
    NDIS_OFFLOAD_PARAMETERS_USO_ENABLED                 = 0x00000002U,
    NDIS_OFFLOAD_PARAMETERS_REVISION_1                  = 0x00000001U,
    NDIS_OFFLOAD_PARAMETERS_REVISION_2                  = 0x00000002U,
    NDIS_OFFLOAD_PARAMETERS_REVISION_3                  = 0x00000003U,
    NDIS_OFFLOAD_PARAMETERS_REVISION_4                  = 0x00000004U,
    NDIS_OFFLOAD_PARAMETERS_REVISION_5                  = 0x00000005U,
    NDIS_OFFLOAD_PARAMETERS_REVISION_6                  = 0x00000006U,
    NDIS_OFFLOAD_PARAMETERS_SKIP_REGISTRY_UPDATE        = 0x00000001U,
}

enum : uint
{
    IPSEC_OFFLOAD_V2_AUTHENTICATION_MD5         = 0x00000001U,
    IPSEC_OFFLOAD_V2_AUTHENTICATION_SHA_1       = 0x00000002U,
    IPSEC_OFFLOAD_V2_AUTHENTICATION_SHA_256     = 0x00000004U,
    IPSEC_OFFLOAD_V2_AUTHENTICATION_AES_GCM_128 = 0x00000008U,
    IPSEC_OFFLOAD_V2_AUTHENTICATION_AES_GCM_192 = 0x00000010U,
    IPSEC_OFFLOAD_V2_AUTHENTICATION_AES_GCM_256 = 0x00000020U,
}

enum : uint
{
    IPSEC_OFFLOAD_V2_ENCRYPTION_NONE        = 0x00000001U,
    IPSEC_OFFLOAD_V2_ENCRYPTION_DES_CBC     = 0x00000002U,
    IPSEC_OFFLOAD_V2_ENCRYPTION_3_DES_CBC   = 0x00000004U,
    IPSEC_OFFLOAD_V2_ENCRYPTION_AES_GCM_128 = 0x00000008U,
    IPSEC_OFFLOAD_V2_ENCRYPTION_AES_GCM_192 = 0x00000010U,
    IPSEC_OFFLOAD_V2_ENCRYPTION_AES_GCM_256 = 0x00000020U,
    IPSEC_OFFLOAD_V2_ENCRYPTION_AES_CBC_128 = 0x00000040U,
    IPSEC_OFFLOAD_V2_ENCRYPTION_AES_CBC_192 = 0x00000080U,
    IPSEC_OFFLOAD_V2_ENCRYPTION_AES_CBC_256 = 0x00000100U,
}

enum uint NDIS_TCP_RECV_SEG_COALESC_OFFLOAD_REVISION_1 = 0x00000001U;

enum : uint
{
    NDIS_ENCAPSULATED_PACKET_TASK_OFFLOAD_NOT_SUPPORTED = 0x00000000U,
    NDIS_ENCAPSULATED_PACKET_TASK_OFFLOAD_INNER_IPV4    = 0x00000001U,
    NDIS_ENCAPSULATED_PACKET_TASK_OFFLOAD_OUTER_IPV4    = 0x00000002U,
    NDIS_ENCAPSULATED_PACKET_TASK_OFFLOAD_INNER_IPV6    = 0x00000004U,
    NDIS_ENCAPSULATED_PACKET_TASK_OFFLOAD_OUTER_IPV6    = 0x00000008U,
}

enum uint NDIS_OFFLOAD_FLAGS_GROUP_CHECKSUM_CAPABILITIES = 0x00000001U;

enum : uint
{
    IPSEC_OFFLOAD_V2_AND_TCP_CHECKSUM_COEXISTENCE = 0x00000002U,
    IPSEC_OFFLOAD_V2_AND_UDP_CHECKSUM_COEXISTENCE = 0x00000004U,
}

enum : uint
{
    NDIS_OFFLOAD_REVISION_1 = 0x00000001U,
    NDIS_OFFLOAD_REVISION_2 = 0x00000002U,
    NDIS_OFFLOAD_REVISION_3 = 0x00000003U,
    NDIS_OFFLOAD_REVISION_4 = 0x00000004U,
    NDIS_OFFLOAD_REVISION_5 = 0x00000005U,
    NDIS_OFFLOAD_REVISION_6 = 0x00000006U,
    NDIS_OFFLOAD_REVISION_7 = 0x00000007U,
    NDIS_OFFLOAD_REVISION_8 = 0x00000008U,
}

enum : uint
{
    NDIS_TCP_CONNECTION_OFFLOAD_REVISION_1 = 0x00000001U,
    NDIS_TCP_CONNECTION_OFFLOAD_REVISION_2 = 0x00000002U,
}

enum uint NDIS_PORT_AUTHENTICATION_PARAMETERS_REVISION_1 = 0x00000001U;
enum uint NDIS_WMI_DEFAULT_METHOD_ID = 0x00000001U;

enum : uint
{
    NDIS_WMI_OBJECT_TYPE_SET          = 0x00000001U,
    NDIS_WMI_OBJECT_TYPE_METHOD       = 0x00000002U,
    NDIS_WMI_OBJECT_TYPE_EVENT        = 0x00000003U,
    NDIS_WMI_OBJECT_TYPE_ENUM_ADAPTER = 0x00000004U,
    NDIS_WMI_OBJECT_TYPE_OUTPUT_INFO  = 0x00000005U,
}

enum uint NDIS_WMI_METHOD_HEADER_REVISION_1 = 0x00000001U;
enum uint NDIS_WMI_SET_HEADER_REVISION_1 = 0x00000001U;
enum uint NDIS_WMI_EVENT_HEADER_REVISION_1 = 0x00000001U;
enum uint NDIS_WMI_ENUM_ADAPTER_REVISION_1 = 0x00000001U;
enum uint NDIS_DEVICE_TYPE_ENDPOINT = 0x00000001U;
enum uint NDIS_HD_SPLIT_PARAMETERS_REVISION_1 = 0x00000001U;

enum : uint
{
    NDIS_HD_SPLIT_COMBINE_ALL_HEADERS       = 0x00000001U,
    NDIS_HD_SPLIT_CURRENT_CONFIG_REVISION_1 = 0x00000001U,
}

enum : uint
{
    NDIS_HD_SPLIT_CAPS_SUPPORTS_HEADER_DATA_SPLIT      = 0x00000001U,
    NDIS_HD_SPLIT_CAPS_SUPPORTS_IPV4_OPTIONS           = 0x00000002U,
    NDIS_HD_SPLIT_CAPS_SUPPORTS_IPV6_EXTENSION_HEADERS = 0x00000004U,
    NDIS_HD_SPLIT_CAPS_SUPPORTS_TCP_OPTIONS            = 0x00000008U,
}

enum uint NDIS_HD_SPLIT_ENABLE_HEADER_DATA_SPLIT = 0x00000001U;
enum uint NDIS_PM_WOL_BITMAP_PATTERN_SUPPORTED = 0x00000001U;
enum uint NDIS_PM_WOL_MAGIC_PACKET_SUPPORTED = 0x00000002U;

enum : uint
{
    NDIS_PM_WOL_IPV4_TCP_SYN_SUPPORTED            = 0x00000004U,
    NDIS_PM_WOL_IPV6_TCP_SYN_SUPPORTED            = 0x00000008U,
    NDIS_PM_WOL_IPV4_DEST_ADDR_WILDCARD_SUPPORTED = 0x00000200U,
}

enum uint NDIS_PM_WOL_IPV6_DEST_ADDR_WILDCARD_SUPPORTED = 0x00000800U;
enum uint NDIS_PM_WOL_EAPOL_REQUEST_ID_MESSAGE_SUPPORTED = 0x00010000U;

enum : uint
{
    NDIS_PM_PROTOCOL_OFFLOAD_ARP_SUPPORTED             = 0x00000001U,
    NDIS_PM_PROTOCOL_OFFLOAD_NS_SUPPORTED              = 0x00000002U,
    NDIS_PM_PROTOCOL_OFFLOAD_80211_RSN_REKEY_SUPPORTED = 0x00000080U,
}

enum : uint
{
    NDIS_PM_WAKE_ON_MEDIA_CONNECT_SUPPORTED    = 0x00000001U,
    NDIS_PM_WAKE_ON_MEDIA_DISCONNECT_SUPPORTED = 0x00000002U,
}

enum : uint
{
    NDIS_WLAN_WAKE_ON_NLO_DISCOVERY_SUPPORTED       = 0x00000001U,
    NDIS_WLAN_WAKE_ON_AP_ASSOCIATION_LOST_SUPPORTED = 0x00000002U,
}

enum uint NDIS_WLAN_WAKE_ON_GTK_HANDSHAKE_ERROR_SUPPORTED = 0x00000004U;
enum uint NDIS_WLAN_WAKE_ON_4WAY_HANDSHAKE_REQUEST_SUPPORTED = 0x00000008U;
enum uint NDIS_WLAN_WAKE_ON_INCOMING_ACTION_FRAME_SUPPORTED = 0x00000010U;
enum uint NDIS_WLAN_WAKE_ON_CLIENT_DRIVER_DIAGNOSTIC_SUPPORTED = 0x00000020U;

enum : uint
{
    NDIS_WWAN_WAKE_ON_REGISTER_STATE_SUPPORTED = 0x00000001U,
    NDIS_WWAN_WAKE_ON_SMS_RECEIVE_SUPPORTED    = 0x00000002U,
    NDIS_WWAN_WAKE_ON_USSD_RECEIVE_SUPPORTED   = 0x00000004U,
    NDIS_WWAN_WAKE_ON_PACKET_STATE_SUPPORTED   = 0x00000008U,
    NDIS_WWAN_WAKE_ON_UICC_CHANGE_SUPPORTED    = 0x00000010U,
}

enum uint NDIS_PM_WAKE_PACKET_INDICATION_SUPPORTED = 0x00000001U;
enum uint NDIS_PM_SELECTIVE_SUSPEND_SUPPORTED = 0x00000002U;
enum uint NDIS_PM_WOL_BITMAP_PATTERN_ENABLED = 0x00000001U;
enum uint NDIS_PM_WOL_MAGIC_PACKET_ENABLED = 0x00000002U;

enum : uint
{
    NDIS_PM_WOL_IPV4_TCP_SYN_ENABLED            = 0x00000004U,
    NDIS_PM_WOL_IPV6_TCP_SYN_ENABLED            = 0x00000008U,
    NDIS_PM_WOL_IPV4_DEST_ADDR_WILDCARD_ENABLED = 0x00000200U,
}

enum uint NDIS_PM_WOL_IPV6_DEST_ADDR_WILDCARD_ENABLED = 0x00000800U;
enum uint NDIS_PM_WOL_EAPOL_REQUEST_ID_MESSAGE_ENABLED = 0x00010000U;

enum : uint
{
    NDIS_PM_PROTOCOL_OFFLOAD_ARP_ENABLED             = 0x00000001U,
    NDIS_PM_PROTOCOL_OFFLOAD_NS_ENABLED              = 0x00000002U,
    NDIS_PM_PROTOCOL_OFFLOAD_80211_RSN_REKEY_ENABLED = 0x00000080U,
}

enum : uint
{
    NDIS_PM_WAKE_ON_LINK_CHANGE_ENABLED      = 0x00000001U,
    NDIS_PM_WAKE_ON_MEDIA_DISCONNECT_ENABLED = 0x00000002U,
}

enum uint NDIS_PM_SELECTIVE_SUSPEND_ENABLED = 0x00000010U;

enum : uint
{
    NDIS_WLAN_WAKE_ON_NLO_DISCOVERY_ENABLED       = 0x00000001U,
    NDIS_WLAN_WAKE_ON_AP_ASSOCIATION_LOST_ENABLED = 0x00000002U,
}

enum uint NDIS_WLAN_WAKE_ON_GTK_HANDSHAKE_ERROR_ENABLED = 0x00000004U;
enum uint NDIS_WLAN_WAKE_ON_4WAY_HANDSHAKE_REQUEST_ENABLED = 0x00000008U;
enum uint NDIS_WLAN_WAKE_ON_INCOMING_ACTION_FRAME_ENABLED = 0x00000010U;
enum uint NDIS_WLAN_WAKE_ON_CLIENT_DRIVER_DIAGNOSTIC_ENABLED = 0x00000020U;

enum : uint
{
    NDIS_WWAN_WAKE_ON_REGISTER_STATE_ENABLED = 0x00000001U,
    NDIS_WWAN_WAKE_ON_SMS_RECEIVE_ENABLED    = 0x00000002U,
    NDIS_WWAN_WAKE_ON_USSD_RECEIVE_ENABLED   = 0x00000004U,
    NDIS_WWAN_WAKE_ON_PACKET_STATE_ENABLED   = 0x00000008U,
    NDIS_WWAN_WAKE_ON_UICC_CHANGE_ENABLED    = 0x00000010U,
}

enum : uint
{
    NDIS_PM_WOL_PRIORITY_LOWEST  = 0xffffffffU,
    NDIS_PM_WOL_PRIORITY_NORMAL  = 0x10000000U,
    NDIS_PM_WOL_PRIORITY_HIGHEST = 0x00000001U,
}

enum : uint
{
    NDIS_PM_PROTOCOL_OFFLOAD_PRIORITY_LOWEST  = 0xffffffffU,
    NDIS_PM_PROTOCOL_OFFLOAD_PRIORITY_NORMAL  = 0x10000000U,
    NDIS_PM_PROTOCOL_OFFLOAD_PRIORITY_HIGHEST = 0x00000001U,
}

enum uint NDIS_PM_MAX_STRING_SIZE = 0x00000040U;

enum : uint
{
    NDIS_PM_CAPABILITIES_REVISION_1 = 0x00000001U,
    NDIS_PM_CAPABILITIES_REVISION_2 = 0x00000002U,
}

enum : uint
{
    NDIS_PM_PARAMETERS_REVISION_1 = 0x00000001U,
    NDIS_PM_PARAMETERS_REVISION_2 = 0x00000002U,
}

enum uint EAPOL_REQUEST_ID_WOL_FLAG_MUST_ENCRYPT = 0x00000001U;
enum uint NDIS_PM_MAX_PATTERN_ID = 0x0000ffffU;
enum uint NDIS_PM_PRIVATE_PATTERN_ID = 0x00000001U;

enum : uint
{
    NDIS_PM_WOL_PATTERN_REVISION_1 = 0x00000001U,
    NDIS_PM_WOL_PATTERN_REVISION_2 = 0x00000002U,
}

enum : uint
{
    DOT11_RSN_KCK_LENGTH            = 0x00000010U,
    DOT11_RSN_KEK_LENGTH            = 0x00000010U,
    DOT11_RSN_MAX_CIPHER_KEY_LENGTH = 0x00000020U,
}

enum : uint
{
    NDIS_PM_PROTOCOL_OFFLOAD_REVISION_1 = 0x00000001U,
    NDIS_PM_PROTOCOL_OFFLOAD_REVISION_2 = 0x00000002U,
}

enum uint NDIS_SIZEOF_NDIS_PM_PROTOCOL_OFFLOAD_REVISION_1 = 0x000000f0U;

enum : uint
{
    NDIS_PM_WAKE_REASON_REVISION_1 = 0x00000001U,
    NDIS_PM_WAKE_PACKET_REVISION_1 = 0x00000001U,
}

enum uint NDIS_WMI_PM_ADMIN_CONFIG_REVISION_1 = 0x00000001U;
enum uint NDIS_WMI_PM_ACTIVE_CAPABILITIES_REVISION_1 = 0x00000001U;

enum : uint
{
    NDIS_RECEIVE_FILTER_MAC_HEADER_SUPPORTED             = 0x00000001U,
    NDIS_RECEIVE_FILTER_IPV4_HEADER_SUPPORTED            = 0x00000002U,
    NDIS_RECEIVE_FILTER_IPV6_HEADER_SUPPORTED            = 0x00000004U,
    NDIS_RECEIVE_FILTER_ARP_HEADER_SUPPORTED             = 0x00000008U,
    NDIS_RECEIVE_FILTER_UDP_HEADER_SUPPORTED             = 0x00000010U,
    NDIS_RECEIVE_FILTER_MAC_HEADER_DEST_ADDR_SUPPORTED   = 0x00000001U,
    NDIS_RECEIVE_FILTER_MAC_HEADER_SOURCE_ADDR_SUPPORTED = 0x00000002U,
    NDIS_RECEIVE_FILTER_MAC_HEADER_PROTOCOL_SUPPORTED    = 0x00000004U,
    NDIS_RECEIVE_FILTER_MAC_HEADER_VLAN_ID_SUPPORTED     = 0x00000008U,
    NDIS_RECEIVE_FILTER_MAC_HEADER_PRIORITY_SUPPORTED    = 0x00000010U,
    NDIS_RECEIVE_FILTER_MAC_HEADER_PACKET_TYPE_SUPPORTED = 0x00000020U,
}

enum : uint
{
    NDIS_RECEIVE_FILTER_ARP_HEADER_OPERATION_SUPPORTED = 0x00000001U,
    NDIS_RECEIVE_FILTER_ARP_HEADER_SPA_SUPPORTED       = 0x00000002U,
    NDIS_RECEIVE_FILTER_ARP_HEADER_TPA_SUPPORTED       = 0x00000004U,
    NDIS_RECEIVE_FILTER_IPV4_HEADER_PROTOCOL_SUPPORTED = 0x00000001U,
    NDIS_RECEIVE_FILTER_IPV6_HEADER_PROTOCOL_SUPPORTED = 0x00000001U,
}

enum uint NDIS_RECEIVE_FILTER_UDP_HEADER_DEST_PORT_SUPPORTED = 0x00000001U;

enum : uint
{
    NDIS_RECEIVE_FILTER_TEST_HEADER_FIELD_EQUAL_SUPPORTED      = 0x00000001U,
    NDIS_RECEIVE_FILTER_TEST_HEADER_FIELD_MASK_EQUAL_SUPPORTED = 0x00000002U,
    NDIS_RECEIVE_FILTER_TEST_HEADER_FIELD_NOT_EQUAL_SUPPORTED  = 0x00000004U,
}

enum : uint
{
    NDIS_RECEIVE_FILTER_MSI_X_SUPPORTED                             = 0x00000001U,
    NDIS_RECEIVE_FILTER_VM_QUEUE_SUPPORTED                          = 0x00000002U,
    NDIS_RECEIVE_FILTER_LOOKAHEAD_SPLIT_SUPPORTED                   = 0x00000004U,
    NDIS_RECEIVE_FILTER_DYNAMIC_PROCESSOR_AFFINITY_CHANGE_SUPPORTED = 0x00000008U,
}

enum uint NDIS_RECEIVE_FILTER_INTERRUPT_VECTOR_COALESCING_SUPPORTED = 0x00000010U;

enum : uint
{
    NDIS_RECEIVE_FILTER_IMPLAT_MIN_OF_QUEUES_MODE                    = 0x00000040U,
    NDIS_RECEIVE_FILTER_IMPLAT_SUM_OF_QUEUES_MODE                    = 0x00000080U,
    NDIS_RECEIVE_FILTER_PACKET_COALESCING_SUPPORTED_ON_DEFAULT_QUEUE = 0x00000100U,
}

enum : uint
{
    NDIS_RECEIVE_FILTER_ANY_VLAN_SUPPORTED                                            = 0x00000020U,
    NDIS_RECEIVE_FILTER_DYNAMIC_PROCESSOR_AFFINITY_CHANGE_FOR_DEFAULT_QUEUE_SUPPORTED = 0x00000040U,
}

enum : uint
{
    NDIS_RECEIVE_FILTER_VMQ_FILTERS_ENABLED               = 0x00000001U,
    NDIS_RECEIVE_FILTER_PACKET_COALESCING_FILTERS_ENABLED = 0x00000002U,
}

enum : uint
{
    NDIS_RECEIVE_FILTER_VM_QUEUES_ENABLED       = 0x00000001U,
    NDIS_RECEIVE_FILTER_CAPABILITIES_REVISION_1 = 0x00000001U,
    NDIS_RECEIVE_FILTER_CAPABILITIES_REVISION_2 = 0x00000002U,
}

enum : uint
{
    NDIS_NIC_SWITCH_CAPS_VLAN_SUPPORTED                           = 0x00000001U,
    NDIS_NIC_SWITCH_CAPS_PER_VPORT_INTERRUPT_MODERATION_SUPPORTED = 0x00000002U,
}

enum uint NDIS_NIC_SWITCH_CAPS_ASYMMETRIC_QUEUE_PAIRS_FOR_NONDEFAULT_VPORT_SUPPORTED = 0x00000004U;

enum : uint
{
    NDIS_NIC_SWITCH_CAPS_VF_RSS_SUPPORTED                      = 0x00000008U,
    NDIS_NIC_SWITCH_CAPS_SINGLE_VPORT_POOL                     = 0x00000010U,
    NDIS_NIC_SWITCH_CAPS_RSS_PARAMETERS_PER_PF_VPORT_SUPPORTED = 0x00000020U,
}

enum uint NDIS_NIC_SWITCH_CAPS_NIC_SWITCH_WITHOUT_IOV_SUPPORTED = 0x00000040U;

enum : uint
{
    NDIS_NIC_SWITCH_CAPS_RSS_ON_PF_VPORTS_SUPPORTED                         = 0x00000080U,
    NDIS_NIC_SWITCH_CAPS_RSS_PER_PF_VPORT_INDIRECTION_TABLE_SUPPORTED       = 0x00000100U,
    NDIS_NIC_SWITCH_CAPS_RSS_PER_PF_VPORT_HASH_FUNCTION_SUPPORTED           = 0x00000200U,
    NDIS_NIC_SWITCH_CAPS_RSS_PER_PF_VPORT_HASH_TYPE_SUPPORTED               = 0x00000400U,
    NDIS_NIC_SWITCH_CAPS_RSS_PER_PF_VPORT_HASH_KEY_SUPPORTED                = 0x00000800U,
    NDIS_NIC_SWITCH_CAPS_RSS_PER_PF_VPORT_INDIRECTION_TABLE_SIZE_RESTRICTED = 0x00001000U,
}

enum : uint
{
    NDIS_NIC_SWITCH_CAPABILITIES_REVISION_1 = 0x00000001U,
    NDIS_NIC_SWITCH_CAPABILITIES_REVISION_2 = 0x00000002U,
    NDIS_NIC_SWITCH_CAPABILITIES_REVISION_3 = 0x00000003U,
}

enum uint NDIS_RECEIVE_FILTER_GLOBAL_PARAMETERS_REVISION_1 = 0x00000001U;

enum : uint
{
    NDIS_DEFAULT_RECEIVE_QUEUE_ID       = 0x00000000U,
    NDIS_DEFAULT_RECEIVE_QUEUE_GROUP_ID = 0x00000000U,
    NDIS_DEFAULT_RECEIVE_FILTER_ID      = 0x00000000U,
}

enum uint NDIS_RECEIVE_FILTER_FIELD_MAC_HEADER_VLAN_UNTAGGED_OR_ZERO = 0x00000001U;

enum : uint
{
    NDIS_RECEIVE_FILTER_RESERVED                    = 0x000000feU,
    NDIS_RECEIVE_FILTER_FIELD_PARAMETERS_REVISION_1 = 0x00000001U,
    NDIS_RECEIVE_FILTER_FIELD_PARAMETERS_REVISION_2 = 0x00000002U,
    NDIS_RECEIVE_FILTER_FLAGS_RESERVED              = 0x00000001U,
    NDIS_RECEIVE_FILTER_PACKET_ENCAPSULATION_GRE    = 0x00000002U,
    NDIS_RECEIVE_FILTER_PACKET_ENCAPSULATION        = 0x00000002U,
    NDIS_RECEIVE_FILTER_PARAMETERS_REVISION_1       = 0x00000001U,
    NDIS_RECEIVE_FILTER_PARAMETERS_REVISION_2       = 0x00000002U,
    NDIS_RECEIVE_FILTER_CLEAR_PARAMETERS_REVISION_1 = 0x00000001U,
}

enum : uint
{
    NDIS_RECEIVE_QUEUE_PARAMETERS_PER_QUEUE_RECEIVE_INDICATION           = 0x00000001U,
    NDIS_RECEIVE_QUEUE_PARAMETERS_LOOKAHEAD_SPLIT_REQUIRED               = 0x00000002U,
    NDIS_RECEIVE_QUEUE_PARAMETERS_FLAGS_CHANGED                          = 0x00010000U,
    NDIS_RECEIVE_QUEUE_PARAMETERS_PROCESSOR_AFFINITY_CHANGED             = 0x00020000U,
    NDIS_RECEIVE_QUEUE_PARAMETERS_SUGGESTED_RECV_BUFFER_NUMBERS_CHANGED  = 0x00040000U,
    NDIS_RECEIVE_QUEUE_PARAMETERS_NAME_CHANGED                           = 0x00080000U,
    NDIS_RECEIVE_QUEUE_PARAMETERS_INTERRUPT_COALESCING_DOMAIN_ID_CHANGED = 0x00100000U,
    NDIS_RECEIVE_QUEUE_PARAMETERS_QOS_SQ_ID_CHANGED                      = 0x00200000U,
    NDIS_RECEIVE_QUEUE_PARAMETERS_CHANGE_MASK                            = 0xffff0000U,
    NDIS_RECEIVE_QUEUE_PARAMETERS_REVISION_1                             = 0x00000001U,
    NDIS_RECEIVE_QUEUE_PARAMETERS_REVISION_2                             = 0x00000002U,
    NDIS_RECEIVE_QUEUE_PARAMETERS_REVISION_3                             = 0x00000003U,
    NDIS_RECEIVE_QUEUE_FREE_PARAMETERS_REVISION_1                        = 0x00000001U,
    NDIS_RECEIVE_QUEUE_INFO_REVISION_1                                   = 0x00000001U,
    NDIS_RECEIVE_QUEUE_INFO_REVISION_2                                   = 0x00000002U,
    NDIS_RECEIVE_QUEUE_INFO_ARRAY_REVISION_1                             = 0x00000001U,
}

enum : uint
{
    NDIS_RECEIVE_FILTER_INFO_REVISION_1               = 0x00000001U,
    NDIS_RECEIVE_FILTER_INFO_ARRAY_REVISION_1         = 0x00000001U,
    NDIS_RECEIVE_FILTER_INFO_ARRAY_REVISION_2         = 0x00000002U,
    NDIS_RECEIVE_FILTER_INFO_ARRAY_VPORT_ID_SPECIFIED = 0x00000001U,
}

enum : uint
{
    NDIS_RECEIVE_QUEUE_ALLOCATION_COMPLETE_PARAMETERS_REVISION_1 = 0x00000001U,
    NDIS_RECEIVE_QUEUE_ALLOCATION_COMPLETE_ARRAY_REVISION_1      = 0x00000001U,
}

enum : uint
{
    NDIS_RECEIVE_SCALE_CAPABILITIES_REVISION_1 = 0x00000001U,
    NDIS_RECEIVE_SCALE_CAPABILITIES_REVISION_2 = 0x00000002U,
    NDIS_RECEIVE_SCALE_CAPABILITIES_REVISION_3 = 0x00000003U,
}

enum : uint
{
    NDIS_RSS_CAPS_HASH_TYPE_TCP_IPV4    = 0x00000100U,
    NDIS_RSS_CAPS_HASH_TYPE_TCP_IPV6    = 0x00000200U,
    NDIS_RSS_CAPS_HASH_TYPE_TCP_IPV6_EX = 0x00000400U,
    NDIS_RSS_CAPS_HASH_TYPE_UDP_IPV4    = 0x00000800U,
    NDIS_RSS_CAPS_HASH_TYPE_UDP_IPV6    = 0x00001000U,
    NDIS_RSS_CAPS_HASH_TYPE_UDP_IPV6_EX = 0x00002000U,
}

enum uint NDIS_RSS_CAPS_MESSAGE_SIGNALED_INTERRUPTS = 0x01000000U;

enum : uint
{
    NDIS_RSS_CAPS_CLASSIFICATION_AT_ISR = 0x02000000U,
    NDIS_RSS_CAPS_CLASSIFICATION_AT_DPC = 0x04000000U,
}

enum : uint
{
    NDIS_RSS_CAPS_USING_MSI_X            = 0x08000000U,
    NDIS_RSS_CAPS_RSS_AVAILABLE_ON_PORTS = 0x10000000U,
}

enum : uint
{
    NDIS_RSS_CAPS_SUPPORTS_MSI_X                  = 0x20000000U,
    NDIS_RSS_CAPS_SUPPORTS_INDEPENDENT_ENTRY_MOVE = 0x40000000U,
}

enum : uint
{
    NDIS_RSS_PARAM_FLAG_BASE_CPU_UNCHANGED          = 0x00000001U,
    NDIS_RSS_PARAM_FLAG_HASH_INFO_UNCHANGED         = 0x00000002U,
    NDIS_RSS_PARAM_FLAG_ITABLE_UNCHANGED            = 0x00000004U,
    NDIS_RSS_PARAM_FLAG_HASH_KEY_UNCHANGED          = 0x00000008U,
    NDIS_RSS_PARAM_FLAG_DISABLE_RSS                 = 0x00000010U,
    NDIS_RSS_PARAM_FLAG_DEFAULT_PROCESSOR_UNCHANGED = 0x00000020U,
}

enum uint NDIS_RSS_INDIRECTION_TABLE_SIZE_REVISION_1 = 0x00000080U;
enum uint NDIS_RSS_HASH_SECRET_KEY_SIZE_REVISION_1 = 0x00000028U;

enum : uint
{
    NDIS_RECEIVE_SCALE_PARAMETERS_REVISION_1 = 0x00000001U,
    NDIS_RECEIVE_SCALE_PARAMETERS_REVISION_2 = 0x00000002U,
    NDIS_RECEIVE_SCALE_PARAMETERS_REVISION_3 = 0x00000003U,
}

enum uint NDIS_RSS_INDIRECTION_TABLE_MAX_SIZE_REVISION_1 = 0x00000080U;

enum : uint
{
    NDIS_RSS_HASH_SECRET_KEY_MAX_SIZE_REVISION_1 = 0x00000028U,
    NDIS_RSS_HASH_SECRET_KEY_MAX_SIZE_REVISION_2 = 0x00000028U,
    NDIS_RSS_HASH_SECRET_KEY_MAX_SIZE_REVISION_3 = 0x00000028U,
}

enum : uint
{
    NDIS_RECEIVE_SCALE_PARAMETERS_V2_REVISION_1        = 0x00000001U,
    NDIS_RECEIVE_SCALE_PARAM_ENABLE_RSS                = 0x00000001U,
    NDIS_RECEIVE_SCALE_PARAM_HASH_INFO_CHANGED         = 0x00000002U,
    NDIS_RECEIVE_SCALE_PARAM_HASH_KEY_CHANGED          = 0x00000004U,
    NDIS_RECEIVE_SCALE_PARAM_NUMBER_OF_QUEUES_CHANGED  = 0x00000008U,
    NDIS_RECEIVE_SCALE_PARAM_NUMBER_OF_ENTRIES_CHANGED = 0x00000010U,
}

enum : uint
{
    NDIS_RSS_SET_INDIRECTION_ENTRY_FLAG_PRIMARY_PROCESSOR = 0x00000001U,
    NDIS_RSS_SET_INDIRECTION_ENTRY_FLAG_DEFAULT_PROCESSOR = 0x00000002U,
    NDIS_RSS_SET_INDIRECTION_ENTRIES_REVISION_1           = 0x00000001U,
}

enum : uint
{
    NDIS_RECEIVE_HASH_FLAG_ENABLE_HASH         = 0x00000001U,
    NDIS_RECEIVE_HASH_FLAG_HASH_INFO_UNCHANGED = 0x00000002U,
    NDIS_RECEIVE_HASH_FLAG_HASH_KEY_UNCHANGED  = 0x00000004U,
    NDIS_RECEIVE_HASH_PARAMETERS_REVISION_1    = 0x00000001U,
}

enum : uint
{
    NDIS_RSS_PROCESSOR_INFO_REVISION_1 = 0x00000001U,
    NDIS_RSS_PROCESSOR_INFO_REVISION_2 = 0x00000002U,
}

enum uint NDIS_SYSTEM_PROCESSOR_INFO_EX_REVISION_1 = 0x00000001U;

enum : uint
{
    NDIS_HYPERVISOR_INFO_FLAG_HYPERVISOR_PRESENT = 0x00000001U,
    NDIS_HYPERVISOR_INFO_REVISION_1              = 0x00000001U,
}

enum : uint
{
    NDIS_WMI_RECEIVE_QUEUE_PARAMETERS_REVISION_1 = 0x00000001U,
    NDIS_WMI_RECEIVE_QUEUE_INFO_REVISION_1       = 0x00000001U,
}

enum uint NDIS_NDK_CAPABILITIES_REVISION_1 = 0x00000001U;

enum : uint
{
    OID_NDK_SET_STATE       = 0xfc040201U,
    OID_NDK_STATISTICS      = 0xfc040202U,
    OID_NDK_CONNECTIONS     = 0xfc040203U,
    OID_NDK_LOCAL_ENDPOINTS = 0xfc040204U,
}

enum : GUID
{
    GUID_NDIS_NDK_CAPABILITIES = GUID("7969ba4d-dd80-4bc7-b3e6-68043997e519"),
    GUID_NDIS_NDK_STATE        = GUID("530c69c9-2f51-49de-a1af-088d54ffa474"),
}

enum uint NDIS_NDK_STATISTICS_INFO_REVISION_1 = 0x00000001U;
enum uint NDIS_NDK_CONNECTIONS_REVISION_1 = 0x00000001U;
enum uint NDIS_NDK_LOCAL_ENDPOINTS_REVISION_1 = 0x00000001U;
enum uint OID_QOS_HARDWARE_CAPABILITIES = 0xfc050001U;
enum uint OID_QOS_CURRENT_CAPABILITIES = 0xfc050002U;

enum : uint
{
    OID_QOS_PARAMETERS             = 0xfc050003U,
    OID_QOS_OPERATIONAL_PARAMETERS = 0xfc050004U,
}

enum uint OID_QOS_REMOTE_PARAMETERS = 0xfc050005U;

enum : uint
{
    NDIS_QOS_MAXIMUM_PRIORITIES      = 0x00000008U,
    NDIS_QOS_MAXIMUM_TRAFFIC_CLASSES = 0x00000008U,
}

enum : uint
{
    NDIS_QOS_CAPABILITIES_STRICT_TSA_SUPPORTED    = 0x00000001U,
    NDIS_QOS_CAPABILITIES_MACSEC_BYPASS_SUPPORTED = 0x00000002U,
    NDIS_QOS_CAPABILITIES_CEE_DCBX_SUPPORTED      = 0x00000004U,
    NDIS_QOS_CAPABILITIES_IEEE_DCBX_SUPPORTED     = 0x00000008U,
    NDIS_QOS_CAPABILITIES_REVISION_1              = 0x00000001U,
}

enum : uint
{
    NDIS_QOS_CLASSIFICATION_SET_BY_MINIPORT_MASK = 0xff000000U,
    NDIS_QOS_CLASSIFICATION_ENFORCED_BY_MINIPORT = 0x01000000U,
}

enum : uint
{
    NDIS_QOS_CONDITION_RESERVED        = 0x00000000U,
    NDIS_QOS_CONDITION_DEFAULT         = 0x00000001U,
    NDIS_QOS_CONDITION_TCP_PORT        = 0x00000002U,
    NDIS_QOS_CONDITION_UDP_PORT        = 0x00000003U,
    NDIS_QOS_CONDITION_TCP_OR_UDP_PORT = 0x00000004U,
    NDIS_QOS_CONDITION_ETHERTYPE       = 0x00000005U,
    NDIS_QOS_CONDITION_NETDIRECT_PORT  = 0x00000006U,
    NDIS_QOS_CONDITION_MAXIMUM         = 0x00000007U,
}

enum : uint
{
    NDIS_QOS_ACTION_PRIORITY = 0x00000000U,
    NDIS_QOS_ACTION_MAXIMUM  = 0x00000001U,
}

enum uint NDIS_QOS_CLASSIFICATION_ELEMENT_REVISION_1 = 0x00000001U;

enum : uint
{
    NDIS_QOS_PARAMETERS_ETS_CHANGED               = 0x00000001U,
    NDIS_QOS_PARAMETERS_ETS_CONFIGURED            = 0x00000002U,
    NDIS_QOS_PARAMETERS_PFC_CHANGED               = 0x00000100U,
    NDIS_QOS_PARAMETERS_PFC_CONFIGURED            = 0x00000200U,
    NDIS_QOS_PARAMETERS_CLASSIFICATION_CHANGED    = 0x00010000U,
    NDIS_QOS_PARAMETERS_CLASSIFICATION_CONFIGURED = 0x00020000U,
    NDIS_QOS_PARAMETERS_WILLING                   = 0x80000000U,
}

enum : uint
{
    NDIS_QOS_TSA_STRICT            = 0x00000000U,
    NDIS_QOS_TSA_CBS               = 0x00000001U,
    NDIS_QOS_TSA_ETS               = 0x00000002U,
    NDIS_QOS_TSA_MAXIMUM           = 0x00000003U,
    NDIS_QOS_PARAMETERS_REVISION_1 = 0x00000001U,
}

enum : uint
{
    NDIS_DEFAULT_VPORT_ID  = 0x00000000U,
    NDIS_DEFAULT_SWITCH_ID = 0x00000000U,
}

enum : uint
{
    NDIS_NIC_SWITCH_PARAMETERS_CHANGE_MASK                                     = 0xffff0000U,
    NDIS_NIC_SWITCH_PARAMETERS_SWITCH_NAME_CHANGED                             = 0x00010000U,
    NDIS_NIC_SWITCH_PARAMETERS_DEFAULT_NUMBER_OF_QUEUE_PAIRS_FOR_DEFAULT_VPORT = 0x00000001U,
}

enum : uint
{
    NDIS_NIC_SWITCH_PARAMETERS_REVISION_1               = 0x00000001U,
    NDIS_NIC_SWITCH_PARAMETERS_REVISION_2               = 0x00000002U,
    NDIS_NIC_SWITCH_DELETE_SWITCH_PARAMETERS_REVISION_1 = 0x00000001U,
}

enum : uint
{
    NDIS_NIC_SWITCH_INFO_REVISION_1                         = 0x00000001U,
    NDIS_NIC_SWITCH_INFO_ARRAY_REVISION_1                   = 0x00000001U,
    NDIS_NIC_SWITCH_VPORT_PARAMS_LOOKAHEAD_SPLIT_ENABLED    = 0x00000001U,
    NDIS_NIC_SWITCH_VPORT_PARAMS_PACKET_DIRECT_RX_ONLY      = 0x00000002U,
    NDIS_NIC_SWITCH_VPORT_PARAMS_ENFORCE_MAX_SG_LIST        = 0x00008000U,
    NDIS_NIC_SWITCH_VPORT_PARAMS_CHANGE_MASK                = 0xffff0000U,
    NDIS_NIC_SWITCH_VPORT_PARAMS_FLAGS_CHANGED              = 0x00010000U,
    NDIS_NIC_SWITCH_VPORT_PARAMS_NAME_CHANGED               = 0x00020000U,
    NDIS_NIC_SWITCH_VPORT_PARAMS_INT_MOD_CHANGED            = 0x00040000U,
    NDIS_NIC_SWITCH_VPORT_PARAMS_STATE_CHANGED              = 0x00080000U,
    NDIS_NIC_SWITCH_VPORT_PARAMS_PROCESSOR_AFFINITY_CHANGED = 0x00100000U,
    NDIS_NIC_SWITCH_VPORT_PARAMS_NDK_PARAMS_CHANGED         = 0x00200000U,
    NDIS_NIC_SWITCH_VPORT_PARAMS_QOS_SQ_ID_CHANGED          = 0x00400000U,
    NDIS_NIC_SWITCH_VPORT_PARAMS_NUM_QUEUE_PAIRS_CHANGED    = 0x00800000U,
    NDIS_NIC_SWITCH_VPORT_PARAMETERS_REVISION_1             = 0x00000001U,
    NDIS_NIC_SWITCH_VPORT_PARAMETERS_REVISION_2             = 0x00000002U,
}

enum uint NDIS_NIC_SWITCH_DELETE_VPORT_PARAMETERS_REVISION_1 = 0x00000001U;

enum : uint
{
    NDIS_NIC_SWITCH_VPORT_INFO_LOOKAHEAD_SPLIT_ENABLED         = 0x00000001U,
    NDIS_NIC_SWITCH_VPORT_INFO_PACKET_DIRECT_RX_ONLY           = 0x00000002U,
    NDIS_NIC_SWITCH_VPORT_INFO_GFT_ENABLED                     = 0x00000004U,
    NDIS_NIC_SWITCH_VPORT_INFO_REVISION_1                      = 0x00000001U,
    NDIS_NIC_SWITCH_VPORT_INFO_ARRAY_ENUM_ON_SPECIFIC_FUNCTION = 0x00000001U,
    NDIS_NIC_SWITCH_VPORT_INFO_ARRAY_ENUM_ON_SPECIFIC_SWITCH   = 0x00000002U,
    NDIS_NIC_SWITCH_VPORT_INFO_ARRAY_REVISION_1                = 0x00000001U,
}

enum uint NDIS_NIC_SWITCH_VF_PARAMETERS_REVISION_1 = 0x00000001U;
enum uint NDIS_NIC_SWITCH_FREE_VF_PARAMETERS_REVISION_1 = 0x00000001U;

enum : uint
{
    NDIS_NIC_SWITCH_VF_INFO_REVISION_1                    = 0x00000001U,
    NDIS_NIC_SWITCH_VF_INFO_ARRAY_ENUM_ON_SPECIFIC_SWITCH = 0x00000001U,
    NDIS_NIC_SWITCH_VF_INFO_ARRAY_REVISION_1              = 0x00000001U,
}

enum : uint
{
    NDIS_SRIOV_CAPS_SRIOV_SUPPORTED    = 0x00000001U,
    NDIS_SRIOV_CAPS_PF_MINIPORT        = 0x00000002U,
    NDIS_SRIOV_CAPS_VF_MINIPORT        = 0x00000004U,
    NDIS_SRIOV_CAPABILITIES_REVISION_1 = 0x00000001U,
}

enum uint NDIS_SRIOV_READ_VF_CONFIG_SPACE_PARAMETERS_REVISION_1 = 0x00000001U;
enum uint NDIS_SRIOV_WRITE_VF_CONFIG_SPACE_PARAMETERS_REVISION_1 = 0x00000001U;
enum uint NDIS_SRIOV_READ_VF_CONFIG_BLOCK_PARAMETERS_REVISION_1 = 0x00000001U;
enum uint NDIS_SRIOV_WRITE_VF_CONFIG_BLOCK_PARAMETERS_REVISION_1 = 0x00000001U;
enum uint NDIS_SRIOV_RESET_VF_PARAMETERS_REVISION_1 = 0x00000001U;
enum uint NDIS_SRIOV_SET_VF_POWER_STATE_PARAMETERS_REVISION_1 = 0x00000001U;
enum uint NDIS_SRIOV_CONFIG_STATE_PARAMETERS_REVISION_1 = 0x00000001U;
enum uint NDIS_SRIOV_VF_VENDOR_DEVICE_ID_INFO_REVISION_1 = 0x00000001U;
enum uint NDIS_SRIOV_PROBED_BARS_INFO_REVISION_1 = 0x00000001U;
enum uint NDIS_RECEIVE_FILTER_MOVE_FILTER_PARAMETERS_REVISION_1 = 0x00000001U;
enum uint NDIS_SRIOV_BAR_RESOURCES_INFO_REVISION_1 = 0x00000001U;
enum uint NDIS_SRIOV_PF_LUID_INFO_REVISION_1 = 0x00000001U;
enum uint NDIS_SRIOV_VF_SERIAL_NUMBER_INFO_REVISION_1 = 0x00000001U;
enum uint NDIS_SRIOV_VF_INVALIDATE_CONFIG_BLOCK_INFO_REVISION_1 = 0x00000001U;
enum uint NDIS_SRIOV_OVERLYING_ADAPTER_INFO_VERSION_1 = 0x00000001U;
enum uint NDIS_ISOLATION_NAME_MAX_STRING_SIZE = 0x0000007fU;

enum : uint
{
    NDIS_ROUTING_DOMAIN_ISOLATION_ENTRY_REVISION_1 = 0x00000001U,
    NDIS_ROUTING_DOMAIN_ENTRY_REVISION_1           = 0x00000001U,
}

enum uint NDIS_ISOLATION_PARAMETERS_REVISION_1 = 0x00000001U;
enum uint NDIS_SWITCH_OBJECT_SERIALIZATION_VERSION_1 = 0x00000001U;

enum : uint
{
    NDIS_SWITCH_PORT_PROPERTY_SECURITY_REVISION_1          = 0x00000001U,
    NDIS_SWITCH_PORT_PROPERTY_SECURITY_REVISION_2          = 0x00000002U,
    NDIS_SWITCH_PORT_PROPERTY_VLAN_REVISION_1              = 0x00000001U,
    NDIS_SWITCH_PORT_PROPERTY_PROFILE_REVISION_1           = 0x00000001U,
    NDIS_SWITCH_PORT_PROPERTY_ISOLATION_REVISION_1         = 0x00000001U,
    NDIS_SWITCH_PORT_PROPERTY_ROUTING_DOMAIN_REVISION_1    = 0x00000001U,
    NDIS_SWITCH_PORT_PROPERTY_CUSTOM_REVISION_1            = 0x00000001U,
    NDIS_SWITCH_PORT_PROPERTY_PARAMETERS_REVISION_1        = 0x00000001U,
    NDIS_SWITCH_PORT_PROPERTY_DELETE_PARAMETERS_REVISION_1 = 0x00000001U,
    NDIS_SWITCH_PORT_PROPERTY_ENUM_PARAMETERS_REVISION_1   = 0x00000001U,
    NDIS_SWITCH_PORT_PROPERTY_ENUM_INFO_REVISION_1         = 0x00000001U,
}

enum : uint
{
    NDIS_SWITCH_PORT_FEATURE_STATUS_PARAMETERS_REVISION_1 = 0x00000001U,
    NDIS_SWITCH_PORT_FEATURE_STATUS_CUSTOM_REVISION_1     = 0x00000001U,
}

enum : uint
{
    NDIS_SWITCH_PROPERTY_CUSTOM_REVISION_1            = 0x00000001U,
    NDIS_SWITCH_PROPERTY_PARAMETERS_REVISION_1        = 0x00000001U,
    NDIS_SWITCH_PROPERTY_DELETE_PARAMETERS_REVISION_1 = 0x00000001U,
    NDIS_SWITCH_PROPERTY_ENUM_INFO_REVISION_1         = 0x00000001U,
    NDIS_SWITCH_PROPERTY_ENUM_PARAMETERS_REVISION_1   = 0x00000001U,
}

enum : uint
{
    NDIS_SWITCH_FEATURE_STATUS_PARAMETERS_REVISION_1 = 0x00000001U,
    NDIS_SWITCH_FEATURE_STATUS_CUSTOM_REVISION_1     = 0x00000001U,
}

enum uint NDIS_SWITCH_PARAMETERS_REVISION_1 = 0x00000001U;

enum : uint
{
    NDIS_SWITCH_PORT_PARAMETERS_FLAG_UNTRUSTED_INTERNAL_PORT = 0x00000001U,
    NDIS_SWITCH_PORT_PARAMETERS_FLAG_RESTORING_PORT          = 0x00000002U,
    NDIS_SWITCH_PORT_PARAMETERS_REVISION_1                   = 0x00000001U,
    NDIS_SWITCH_PORT_ARRAY_REVISION_1                        = 0x00000001U,
}

enum : uint
{
    NDIS_SWITCH_NIC_FLAGS_NIC_INITIALIZING   = 0x00000001U,
    NDIS_SWITCH_NIC_FLAGS_NIC_SUSPENDED      = 0x00000002U,
    NDIS_SWITCH_NIC_FLAGS_MAPPED_NIC_UPDATED = 0x00000004U,
    NDIS_SWITCH_NIC_FLAGS_NIC_SUSPENDED_LM   = 0x00000010U,
    NDIS_SWITCH_NIC_PARAMETERS_REVISION_1    = 0x00000001U,
    NDIS_SWITCH_NIC_PARAMETERS_REVISION_2    = 0x00000002U,
    NDIS_SWITCH_NIC_ARRAY_REVISION_1         = 0x00000001U,
    NDIS_SWITCH_NIC_OID_REQUEST_REVISION_1   = 0x00000001U,
    NDIS_SWITCH_NIC_SAVE_STATE_REVISION_1    = 0x00000001U,
    NDIS_SWITCH_NIC_SAVE_STATE_REVISION_2    = 0x00000002U,
}

enum uint NDIS_PORT_STATE_REVISION_1 = 0x00000001U;
enum uint NDIS_PORT_CHAR_USE_DEFAULT_AUTH_SETTINGS = 0x00000001U;
enum uint NDIS_PORT_CHARACTERISTICS_REVISION_1 = 0x00000001U;
enum uint NDIS_PORT_ARRAY_REVISION_1 = 0x00000001U;
enum uint ETHERNET_LENGTH_OF_ADDRESS = 0x00000006U;

enum : uint
{
    NDIS_GFP_HEADER_PRESENT_ETHERNET        = 0x00000001U,
    NDIS_GFP_HEADER_PRESENT_IPV4            = 0x00000002U,
    NDIS_GFP_HEADER_PRESENT_IPV6            = 0x00000004U,
    NDIS_GFP_HEADER_PRESENT_TCP             = 0x00000008U,
    NDIS_GFP_HEADER_PRESENT_UDP             = 0x00000010U,
    NDIS_GFP_HEADER_PRESENT_ICMP            = 0x00000020U,
    NDIS_GFP_HEADER_PRESENT_NO_ENCAP        = 0x00000040U,
    NDIS_GFP_HEADER_PRESENT_IP_IN_IP_ENCAP  = 0x00000080U,
    NDIS_GFP_HEADER_PRESENT_IP_IN_GRE_ENCAP = 0x00000100U,
    NDIS_GFP_HEADER_PRESENT_NVGRE_ENCAP     = 0x00000200U,
    NDIS_GFP_HEADER_PRESENT_VXLAN_ENCAP     = 0x00000400U,
    NDIS_GFP_HEADER_PRESENT_ESP             = 0x00000800U,
}

enum : uint
{
    NDIS_GFP_ENCAPSULATION_TYPE_NOT_ENCAPSULATED = 0x00000001U,
    NDIS_GFP_ENCAPSULATION_TYPE_IP_IN_IP         = 0x00000002U,
    NDIS_GFP_ENCAPSULATION_TYPE_IP_IN_GRE        = 0x00000004U,
    NDIS_GFP_ENCAPSULATION_TYPE_NVGRE            = 0x00000008U,
    NDIS_GFP_ENCAPSULATION_TYPE_VXLAN            = 0x00000010U,
}

enum uint NDIS_GFP_UNDEFINED_PROFILE_ID = 0x00000000U;

enum : uint
{
    NDIS_GFP_HEADER_GROUP_EXACT_MATCH_PROFILE_IS_TTL_ONE = 0x00000001U,
    NDIS_GFP_HEADER_GROUP_EXACT_MATCH_PROFILE_REVISION_1 = 0x00000001U,
}

enum : uint
{
    NDIS_GFP_EXACT_MATCH_PROFILE_RDMA_FLOW  = 0x00000001U,
    NDIS_GFP_EXACT_MATCH_PROFILE_REVISION_1 = 0x00000001U,
}

enum : uint
{
    NDIS_GFP_HEADER_GROUP_EXACT_MATCH_IS_TTL_ONE            = 0x00000001U,
    NDIS_GFP_HEADER_GROUP_EXACT_MATCH_REVISION_1            = 0x00000001U,
    NDIS_GFP_HEADER_GROUP_WILDCARD_MATCH_PROFILE_IS_TTL_ONE = 0x00000001U,
    NDIS_GFP_HEADER_GROUP_WILDCARD_MATCH_PROFILE_REVISION_1 = 0x00000001U,
}

enum uint NDIS_GFP_WILDCARD_MATCH_PROFILE_REVISION_1 = 0x00000001U;

enum : uint
{
    NDIS_GFP_HEADER_GROUP_WILDCARD_MATCH_IS_TTL_ONE = 0x00000001U,
    NDIS_GFP_HEADER_GROUP_WILDCARD_MATCH_REVISION_1 = 0x00000001U,
}

enum uint NDIS_PD_CAPS_RECEIVE_FILTER_COUNTERS_SUPPORTED = 0x00000001U;
enum uint NDIS_PD_CAPS_DRAIN_NOTIFICATIONS_SUPPORTED = 0x00000002U;

enum : uint
{
    NDIS_PD_CAPS_NOTIFICATION_MODERATION_INTERVAL_SUPPORTED = 0x00000004U,
    NDIS_PD_CAPS_NOTIFICATION_MODERATION_COUNT_SUPPORTED    = 0x00000008U,
}

enum uint NDIS_PD_CAPABILITIES_REVISION_1 = 0x00000001U;
enum uint NDIS_PD_CONFIG_REVISION_1 = 0x00000001U;

enum : uint
{
    NDIS_GFT_UNDEFINED_FLOW_ENTRY_ID = 0x00000000U,
    NDIS_GFT_UNDEFINED_TABLE_ID      = 0x00000000U,
}

enum uint NDIS_GFT_TABLE_INCLUDE_EXTERNAL_VPPORT = 0x00000001U;

enum : uint
{
    NDIS_GFT_TABLE_PARAMETERS_REVISION_1 = 0x00000001U,
    NDIS_GFT_TABLE_INFO_REVISION_1       = 0x00000001U,
    NDIS_GFT_TABLE_INFO_ARRAY_REVISION_1 = 0x00000001U,
}

enum uint NDIS_GFT_DELETE_TABLE_PARAMETERS_REVISION_1 = 0x00000001U;
enum uint NDIS_GFT_UNDEFINED_COUNTER_ID = 0x00000000U;
enum uint NDIS_GFT_MAX_COUNTER_OBJECTS_PER_FLOW_ENTRY = 0x00000008U;

enum : uint
{
    NDIS_GFT_COUNTER_PARAMETERS_CLIENT_SPECIFIED_ADDRESS = 0x00000001U,
    NDIS_GFT_COUNTER_PARAMETERS_REVISION_1               = 0x00000001U,
}

enum uint NDIS_GFT_FREE_COUNTER_PARAMETERS_REVISION_1 = 0x00000001U;

enum : uint
{
    NDIS_GFT_COUNTER_INFO_REVISION_1                           = 0x00000001U,
    NDIS_GFT_COUNTER_INFO_ARRAY_REVISION_1                     = 0x00000001U,
    NDIS_GFT_COUNTER_VALUE_ARRAY_UPDATE_MEMORY_MAPPED_COUNTERS = 0x00000001U,
    NDIS_GFT_COUNTER_VALUE_ARRAY_GET_VALUES                    = 0x00000002U,
    NDIS_GFT_COUNTER_VALUE_ARRAY_REVISION_1                    = 0x00000001U,
}

enum uint NDIS_GFT_STATISTICS_REVISION_1 = 0x00000001U;

enum : uint
{
    NDIS_GFT_HEADER_GROUP_TRANSPOSITION_PROFILE_DECREMENT_TTL_IF_NOT_ONE = 0x00000001U,
    NDIS_GFT_HEADER_GROUP_TRANSPOSITION_PROFILE_REVISION_1               = 0x00000001U,
}

enum uint NDIS_GFT_UNDEFINED_CUSTOM_ACTION = 0x00000000U;
enum uint NDIS_GFT_RESERVED_CUSTOM_ACTIONS = 0x00000100U;
enum uint NDIS_GFT_CUSTOM_ACTION_PROFILE_REVISION_1 = 0x00000001U;

enum : uint
{
    NDIS_GFT_HTP_REDIRECT_TO_INGRESS_QUEUE_OF_VPORT               = 0x00000001U,
    NDIS_GFT_HTP_REDIRECT_TO_EGRESS_QUEUE_OF_VPORT                = 0x00000002U,
    NDIS_GFT_HTP_REDIRECT_TO_INGRESS_QUEUE_OF_VPORT_IF_TTL_IS_ONE = 0x00000004U,
    NDIS_GFT_HTP_REDIRECT_TO_EGRESS_QUEUE_OF_VPORT_IF_TTL_IS_ONE  = 0x00000008U,
}

enum : uint
{
    NDIS_GFT_HTP_COPY_ALL_PACKETS       = 0x00000010U,
    NDIS_GFT_HTP_COPY_FIRST_PACKET      = 0x00000020U,
    NDIS_GFT_HTP_COPY_WHEN_TCP_FLAG_SET = 0x00000040U,
}

enum uint NDIS_GFT_HTP_CUSTOM_ACTION_PRESENT = 0x00000080U;
enum uint NDIS_GFT_HTP_META_ACTION_BEFORE_HEADER_TRANSPOSITION = 0x00000100U;
enum uint NDIS_GFT_HEADER_TRANSPOSITION_PROFILE_REVISION_1 = 0x00000001U;

enum : uint
{
    NDIS_GFT_HEADER_GROUP_TRANSPOSITION_DECREMENT_TTL_IF_NOT_ONE = 0x00000001U,
    NDIS_GFT_HEADER_GROUP_TRANSPOSITION_REVISION_1               = 0x00000001U,
}

enum : uint
{
    NDIS_GFT_CUSTOM_ACTION_LAST_ACTION = 0x00000001U,
    NDIS_GFT_CUSTOM_ACTION_REVISION_1  = 0x00000001U,
}

enum uint NDIS_GFT_EMFE_ADD_IN_ACTIVATED_STATE = 0x00000001U;
enum uint NDIS_GFT_EMFE_MATCH_AND_ACTION_MUST_BE_SUPPORTED = 0x00000002U;

enum : uint
{
    NDIS_GFT_EMFE_RDMA_FLOW                                        = 0x00000004U,
    NDIS_GFT_EMFE_REDIRECT_TO_INGRESS_QUEUE_OF_VPORT               = 0x00001000U,
    NDIS_GFT_EMFE_REDIRECT_TO_EGRESS_QUEUE_OF_VPORT                = 0x00002000U,
    NDIS_GFT_EMFE_REDIRECT_TO_INGRESS_QUEUE_OF_VPORT_IF_TTL_IS_ONE = 0x00004000U,
    NDIS_GFT_EMFE_REDIRECT_TO_EGRESS_QUEUE_OF_VPORT_IF_TTL_IS_ONE  = 0x00008000U,
}

enum : uint
{
    NDIS_GFT_EMFE_COPY_ALL_PACKETS       = 0x00010000U,
    NDIS_GFT_EMFE_COPY_FIRST_PACKET      = 0x00020000U,
    NDIS_GFT_EMFE_COPY_WHEN_TCP_FLAG_SET = 0x00040000U,
    NDIS_GFT_EMFE_CUSTOM_ACTION_PRESENT  = 0x00080000U,
}

enum uint NDIS_GFT_EMFE_META_ACTION_BEFORE_HEADER_TRANSPOSITION = 0x00100000U;

enum : uint
{
    NDIS_GFT_EMFE_COPY_AFTER_TCP_FIN_FLAG_SET = 0x00200000U,
    NDIS_GFT_EMFE_COPY_AFTER_TCP_RST_FLAG_SET = 0x00400000U,
    NDIS_GFT_EMFE_COPY_CONDITION_CHANGED      = 0x01000000U,
}

enum uint NDIS_GFT_EMFE_ALL_VPORT_FLOW_ENTRIES = 0x02000000U;

enum : uint
{
    NDIS_GFT_EMFE_COUNTER_ALLOCATE                 = 0x00000001U,
    NDIS_GFT_EMFE_COUNTER_MEMORY_MAPPED            = 0x00000002U,
    NDIS_GFT_EMFE_COUNTER_CLIENT_SPECIFIED_ADDRESS = 0x00000004U,
    NDIS_GFT_EMFE_COUNTER_TRACK_TCP_FLOW           = 0x00000008U,
}

enum uint NDIS_GFT_EXACT_MATCH_FLOW_ENTRY_REVISION_1 = 0x00000001U;
enum uint NDIS_GFT_WCFE_ADD_IN_ACTIVATED_STATE = 0x00000001U;

enum : uint
{
    NDIS_GFT_WCFE_REDIRECT_TO_INGRESS_QUEUE_OF_VPORT               = 0x00000002U,
    NDIS_GFT_WCFE_REDIRECT_TO_EGRESS_QUEUE_OF_VPORT                = 0x00000004U,
    NDIS_GFT_WCFE_REDIRECT_TO_INGRESS_QUEUE_OF_VPORT_IF_TTL_IS_ONE = 0x00000008U,
    NDIS_GFT_WCFE_REDIRECT_TO_EGRESS_QUEUE_OF_VPORT_IF_TTL_IS_ONE  = 0x00000010U,
}

enum : uint
{
    NDIS_GFT_WCFE_COPY_ALL_PACKETS                 = 0x00000020U,
    NDIS_GFT_WCFE_CUSTOM_ACTION_PRESENT            = 0x00000040U,
    NDIS_GFT_WCFE_COUNTER_ALLOCATE                 = 0x00000001U,
    NDIS_GFT_WCFE_COUNTER_MEMORY_MAPPED            = 0x00000002U,
    NDIS_GFT_WCFE_COUNTER_CLIENT_SPECIFIED_ADDRESS = 0x00000004U,
}

enum uint NDIS_GFT_WILDCARD_MATCH_FLOW_ENTRY_REVISION_1 = 0x00000001U;

enum : uint
{
    NDIS_GFT_PROFILE_INFO_REVISION_1       = 0x00000001U,
    NDIS_GFT_PROFILE_INFO_ARRAY_REVISION_1 = 0x00000001U,
}

enum : uint
{
    NDIS_GFT_DELETE_PROFILE_ALL_PROFILES          = 0x00000001U,
    NDIS_GFT_DELETE_PROFILE_PARAMETERS_REVISION_1 = 0x00000001U,
}

enum : uint
{
    NDIS_GFT_FLOW_ENTRY_ARRAY_REVISION_1               = 0x00000001U,
    NDIS_GFT_FLOW_ENTRY_INFO_ALL_FLOW_ENTRIES          = 0x00000001U,
    NDIS_GFT_FLOW_ENTRY_INFO_ARRAY_REVISION_1          = 0x00000001U,
    NDIS_GFT_FLOW_ENTRY_ID_ALL_NIC_SWITCH_FLOW_ENTRIES = 0x00000001U,
    NDIS_GFT_FLOW_ENTRY_ID_ALL_TABLE_FLOW_ENTRIES      = 0x00000002U,
    NDIS_GFT_FLOW_ENTRY_ID_ALL_VPORT_FLOW_ENTRIES      = 0x00000004U,
    NDIS_GFT_FLOW_ENTRY_ID_RANGE_DEFINED               = 0x00000008U,
    NDIS_GFT_FLOW_ENTRY_ID_ARRAY_DEFINED               = 0x00000010U,
    NDIS_GFT_FLOW_ENTRY_ID_ARRAY_COUNTER_VALUES        = 0x00010000U,
    NDIS_GFT_FLOW_ENTRY_ID_ARRAY_REVISION_1            = 0x00000001U,
}

enum : uint
{
    NDIS_GFT_OFFLOAD_PARAMETERS_ENABLE_OFFLOAD                 = 0x00000001U,
    NDIS_GFT_OFFLOAD_PARAMETERS_CUSTOM_PROVIDER_RESERVED       = 0xff000000U,
    NDIS_GFT_OFFLOAD_PARAMETERS_REVISION_1                     = 0x00000001U,
    NDIS_GFT_OFFLOAD_CAPS_ADD_FLOW_ENTRY_DEACTIVATED_PREFERRED = 0x00000001U,
}

enum : uint
{
    NDIS_GFT_OFFLOAD_CAPS_RATE_LIMITING_QUEUE_SUPPORTED          = 0x00000002U,
    NDIS_GFT_OFFLOAD_CAPS_MEMORY_MAPPED_COUNTERS                 = 0x00000001U,
    NDIS_GFT_OFFLOAD_CAPS_MEMORY_MAPPED_PAKCET_AND_BYTE_COUNTERS = 0x00000002U,
}

enum : uint
{
    NDIS_GFT_OFFLOAD_CAPS_PER_FLOW_ENTRY_COUNTERS                 = 0x00000004U,
    NDIS_GFT_OFFLOAD_CAPS_PER_PACKET_COUNTER_UPDATE               = 0x00000008U,
    NDIS_GFT_OFFLOAD_CAPS_CLIENT_SPECIFIED_MEMORY_MAPPED_COUNTERS = 0x00000010U,
}

enum : uint
{
    NDIS_GFT_OFFLOAD_CAPS_INGRESS_AGGREGATE_COUNTERS                       = 0x00000020U,
    NDIS_GFT_OFFLOAD_CAPS_EGRESS_AGGREGATE_COUNTERS                        = 0x00000040U,
    NDIS_GFT_OFFLOAD_CAPS_TRACK_TCP_FLOW_STATE                             = 0x00000080U,
    NDIS_GFT_OFFLOAD_CAPS_COMBINED_COUNTER_AND_STATE                       = 0x00000100U,
    NDIS_GFT_OFFLOAD_CAPS_INGRESS_WILDCARD_MATCH                           = 0x00000001U,
    NDIS_GFT_OFFLOAD_CAPS_EGRESS_WILDCARD_MATCH                            = 0x00000002U,
    NDIS_GFT_OFFLOAD_CAPS_INGRESS_EXACT_MATCH                              = 0x00000004U,
    NDIS_GFT_OFFLOAD_CAPS_EGRESS_EXACT_MATCH                               = 0x00000008U,
    NDIS_GFT_OFFLOAD_CAPS_EXT_VPORT_INGRESS_WILDCARD_MATCH                 = 0x00000010U,
    NDIS_GFT_OFFLOAD_CAPS_EXT_VPORT_EGRESS_WILDCARD_MATCH                  = 0x00000020U,
    NDIS_GFT_OFFLOAD_CAPS_EXT_VPORT_INGRESS_EXACT_MATCH                    = 0x00000040U,
    NDIS_GFT_OFFLOAD_CAPS_EXT_VPORT_EGRESS_EXACT_MATCH                     = 0x00000080U,
    NDIS_GFT_OFFLOAD_CAPS_POP                                              = 0x00000001U,
    NDIS_GFT_OFFLOAD_CAPS_PUSH                                             = 0x00000002U,
    NDIS_GFT_OFFLOAD_CAPS_MODIFY                                           = 0x00000004U,
    NDIS_GFT_OFFLOAD_CAPS_IGNORE_ACTION_SUPPORTED                          = 0x00000008U,
    NDIS_GFT_OFFLOAD_CAPS_REDIRECT_TO_INGRESS_QUEUE_OF_VPORT               = 0x00000010U,
    NDIS_GFT_OFFLOAD_CAPS_REDIRECT_TO_EGRESS_QUEUE_OF_VPORT                = 0x00000020U,
    NDIS_GFT_OFFLOAD_CAPS_REDIRECT_TO_INGRESS_QUEUE_OF_VPORT_IF_TTL_IS_ONE = 0x00000040U,
    NDIS_GFT_OFFLOAD_CAPS_REDIRECT_TO_EGRESS_QUEUE_OF_VPORT_IF_TTL_IS_ONE  = 0x00000080U,
}

enum : uint
{
    NDIS_GFT_OFFLOAD_CAPS_COPY_ALL                                = 0x00000100U,
    NDIS_GFT_OFFLOAD_CAPS_COPY_FIRST                              = 0x00000200U,
    NDIS_GFT_OFFLOAD_CAPS_COPY_WHEN_TCP_FLAG_SET                  = 0x00000400U,
    NDIS_GFT_OFFLOAD_CAPS_SAMPLE                                  = 0x00000800U,
    NDIS_GFT_OFFLOAD_CAPS_META_ACTION_BEFORE_HEADER_TRANSPOSITION = 0x00001000U,
    NDIS_GFT_OFFLOAD_CAPS_META_ACTION_AFTER_HEADER_TRANSPOSITION  = 0x00002000U,
}

enum : uint
{
    NDIS_GFT_OFFLOAD_CAPS_PER_VPORT_EXCEPTION_VPORT  = 0x00004000U,
    NDIS_GFT_OFFLOAD_CAPS_DESIGNATED_EXCEPTION_VPORT = 0x00008000U,
    NDIS_GFT_OFFLOAD_CAPS_DSCP_MASK                  = 0x00010000U,
    NDIS_GFT_OFFLOAD_CAPS_8021P_PRIORITY_MASK        = 0x00020000U,
    NDIS_GFT_OFFLOAD_CAPS_ALLOW                      = 0x00040000U,
    NDIS_GFT_OFFLOAD_CAPS_DROP                       = 0x00080000U,
    NDIS_GFT_OFFLOAD_CAPABILITIES_REVISION_1         = 0x00000001U,
}

enum : uint
{
    NDIS_GFT_VPORT_ENABLE                            = 0x00000001U,
    NDIS_GFT_VPORT_PARSE_VXLAN                       = 0x00000002U,
    NDIS_GFT_VPORT_PARSE_VXLAN_NOT_IN_SRC_PORT_RANGE = 0x00000004U,
}

enum : uint
{
    NDIS_GFT_VPORT_ENABLE_STATE_CHANGED    = 0x00100000U,
    NDIS_GFT_VPORT_EXCEPTION_VPORT_CHANGED = 0x00200000U,
}

enum : uint
{
    NDIS_GFT_VPORT_SAMPLING_RATE_CHANGED           = 0x00400000U,
    NDIS_GFT_VPORT_DSCP_MASK_CHANGED               = 0x00800000U,
    NDIS_GFT_VPORT_PRIORITY_MASK_CHANGED           = 0x01000000U,
    NDIS_GFT_VPORT_VXLAN_SETTINGS_CHANGED          = 0x02000000U,
    NDIS_GFT_VPORT_DSCP_FLAGS_CHANGED              = 0x04000000U,
    NDIS_GFT_VPORT_PARAMS_CHANGE_MASK              = 0xfff00000U,
    NDIS_GFT_VPORT_PARAMS_CUSTOM_PROVIDER_RESERVED = 0x000ff000U,
}

enum : uint
{
    NDIS_GFT_VPORT_MAX_DSCP_MASK_COUNTER_OBJECTS     = 0x00000040U,
    NDIS_GFT_VPORT_MAX_PRIORITY_MASK_COUNTER_OBJECTS = 0x00000008U,
}

enum : uint
{
    NDIS_GFT_VPORT_DSCP_GUARD_ENABLE_RX  = 0x00000001U,
    NDIS_GFT_VPORT_DSCP_GUARD_ENABLE_TX  = 0x00000002U,
    NDIS_GFT_VPORT_DSCP_MASK_ENABLE_RX   = 0x00000004U,
    NDIS_GFT_VPORT_DSCP_MASK_ENABLE_TX   = 0x00000008U,
    NDIS_GFT_VPORT_PARAMETERS_REVISION_1 = 0x00000001U,
}

enum : uint
{
    NDIS_QOS_DEFAULT_SQ_ID            = 0x00000000U,
    NDIS_QOS_SQ_PARAMETERS_REVISION_1 = 0x00000001U,
    NDIS_QOS_SQ_PARAMETERS_REVISION_2 = 0x00000002U,
}

enum : uint
{
    NDIS_QOS_SQ_TRANSMIT_CAP_ENABLED         = 0x00000001U,
    NDIS_QOS_SQ_TRANSMIT_RESERVATION_ENABLED = 0x00000002U,
}

enum uint NDIS_QOS_SQ_RECEIVE_CAP_ENABLED = 0x00000004U;
enum uint NDIS_QOS_SQ_PARAMETERS_ARRAY_REVISION_1 = 0x00000001U;
enum uint NDIS_QOS_SQ_ARRAY_REVISION_1 = 0x00000001U;

enum : uint
{
    NDIS_QOS_OFFLOAD_CAPABILITIES_REVISION_1 = 0x00000001U,
    NDIS_QOS_OFFLOAD_CAPABILITIES_REVISION_2 = 0x00000002U,
    NDIS_QOS_OFFLOAD_CAPS_STANDARD_SQ        = 0x00000001U,
    NDIS_QOS_OFFLOAD_CAPS_GFT_SQ             = 0x00000002U,
}

enum uint NDIS_QOS_SQ_STATS_REVISION_1 = 0x00000001U;
enum uint NDIS_TIMESTAMP_CAPABILITIES_REVISION_1 = 0x00000001U;

enum : uint
{
    OID_TIMESTAMP_CAPABILITY     = 0x00a00001U,
    OID_TIMESTAMP_CURRENT_CONFIG = 0x00a00002U,
}

enum uint NDIS_HARDWARE_CROSSTIMESTAMP_REVISION_1 = 0x00000001U;
enum uint OID_TIMESTAMP_GET_CROSSTIMESTAMP = 0x00a00003U;
enum uint OID_QUIC_CONNECTION_ENCRYPTION = 0xfc010215U;

enum : uint
{
    NdisHashFunctionToeplitz  = 0x00000001U,
    NdisHashFunctionReserved1 = 0x00000002U,
    NdisHashFunctionReserved2 = 0x00000004U,
    NdisHashFunctionReserved3 = 0x00000008U,
}

enum : uint
{
    NDIS_HASH_FUNCTION_MASK = 0x000000ffU,
    NDIS_HASH_TYPE_MASK     = 0x00ffff00U,
    NDIS_HASH_IPV4          = 0x00000100U,
    NDIS_HASH_TCP_IPV4      = 0x00000200U,
    NDIS_HASH_IPV6          = 0x00000400U,
    NDIS_HASH_IPV6_EX       = 0x00000800U,
    NDIS_HASH_TCP_IPV6      = 0x00001000U,
    NDIS_HASH_TCP_IPV6_EX   = 0x00002000U,
    NDIS_HASH_UDP_IPV4      = 0x00004000U,
    NDIS_HASH_UDP_IPV6      = 0x00008000U,
    NDIS_HASH_UDP_IPV6_EX   = 0x00010000U,
}

enum const(wchar)* DD_NDIS_DEVICE_NAME = "\\Device\\NDIS";
enum uint NDIS_MAXIMUM_PORTS = 0x01000000U;
enum uint NDIS_OBJECT_REVISION_1 = 0x00000001U;

enum : uint
{
    NDIS_OFFLOAD_NOT_SUPPORTED = 0x00000000U,
    NDIS_OFFLOAD_SUPPORTED     = 0x00000001U,
    NDIS_OFFLOAD_SET_NO_CHANGE = 0x00000000U,
    NDIS_OFFLOAD_SET_ON        = 0x00000001U,
    NDIS_OFFLOAD_SET_OFF       = 0x00000002U,
}

enum : uint
{
    NDIS_ENCAPSULATION_NOT_SUPPORTED             = 0x00000000U,
    NDIS_ENCAPSULATION_NULL                      = 0x00000001U,
    NDIS_ENCAPSULATION_IEEE_802_3                = 0x00000002U,
    NDIS_ENCAPSULATION_IEEE_802_3_P_AND_Q        = 0x00000004U,
    NDIS_ENCAPSULATION_IEEE_802_3_P_AND_Q_IN_OOB = 0x00000008U,
    NDIS_ENCAPSULATION_IEEE_LLC_SNAP_ROUTED      = 0x00000010U,
}

enum uint NDIS_OBJECT_TYPE_OID_REQUEST = 0x00000096U;

enum : uint
{
    NDIS_SUPPORT_NDIS689 = 0x00000001U,
    NDIS_SUPPORT_NDIS688 = 0x00000001U,
    NDIS_SUPPORT_NDIS687 = 0x00000001U,
    NDIS_SUPPORT_NDIS686 = 0x00000001U,
    NDIS_SUPPORT_NDIS685 = 0x00000001U,
    NDIS_SUPPORT_NDIS684 = 0x00000001U,
    NDIS_SUPPORT_NDIS683 = 0x00000001U,
    NDIS_SUPPORT_NDIS682 = 0x00000001U,
    NDIS_SUPPORT_NDIS681 = 0x00000001U,
    NDIS_SUPPORT_NDIS680 = 0x00000001U,
    NDIS_SUPPORT_NDIS670 = 0x00000001U,
    NDIS_SUPPORT_NDIS660 = 0x00000001U,
    NDIS_SUPPORT_NDIS651 = 0x00000001U,
    NDIS_SUPPORT_NDIS650 = 0x00000001U,
    NDIS_SUPPORT_NDIS640 = 0x00000001U,
    NDIS_SUPPORT_NDIS630 = 0x00000001U,
    NDIS_SUPPORT_NDIS620 = 0x00000001U,
    NDIS_SUPPORT_NDIS61  = 0x00000001U,
    NDIS_SUPPORT_NDIS6   = 0x00000001U,
}

enum GUID GUID_NDIS_LAN_CLASS = GUID("ad498944-762f-11d0-8dcb-00c04fc3358c");
enum GUID GUID_DEVINTERFACE_NET = GUID("cac88484-7515-4c03-82e6-71a87abac361");
enum GUID UNSPECIFIED_NETWORK_GUID = GUID("12ba5bde-143e-4c0d-b66d-2379bb141913");
enum GUID GUID_DEVINTERFACE_NETUIO = GUID("08336f60-0679-4c6c-85d2-ae7ced65fff7");
enum GUID GUID_NDIS_ENUMERATE_ADAPTER = GUID("981f2d7f-b1f3-11d0-8dd7-00c04fc3358c");

enum : GUID
{
    GUID_NDIS_NOTIFY_ADAPTER_REMOVAL = GUID("981f2d80-b1f3-11d0-8dd7-00c04fc3358c"),
    GUID_NDIS_NOTIFY_ADAPTER_ARRIVAL = GUID("981f2d81-b1f3-11d0-8dd7-00c04fc3358c"),
}

enum : GUID
{
    GUID_NDIS_ENUMERATE_VC              = GUID("981f2d82-b1f3-11d0-8dd7-00c04fc3358c"),
    GUID_NDIS_NOTIFY_VC_REMOVAL         = GUID("981f2d79-b1f3-11d0-8dd7-00c04fc3358c"),
    GUID_NDIS_NOTIFY_VC_ARRIVAL         = GUID("182f9e0c-b1f3-11d0-8dd7-00c04fc3358c"),
    GUID_NDIS_NOTIFY_BIND               = GUID("5413531c-b1f3-11d0-8dd7-00c04fc3358c"),
    GUID_NDIS_NOTIFY_UNBIND             = GUID("6e3ce1ec-b1f3-11d0-8dd7-00c04fc3358c"),
    GUID_NDIS_WAKE_ON_MAGIC_PACKET_ONLY = GUID("a14f1c97-8839-4f8a-9996-a28996ebbf1d"),
}

enum : GUID
{
    GUID_NDIS_NOTIFY_DEVICE_POWER_ON     = GUID("5f81cfd0-f046-4342-af61-895acedaefd9"),
    GUID_NDIS_NOTIFY_DEVICE_POWER_OFF    = GUID("81bc8189-b026-46ab-b964-f182e342934e"),
    GUID_NDIS_NOTIFY_FILTER_REMOVAL      = GUID("1f177cd9-5955-4721-9f6a-78ebdfaef889"),
    GUID_NDIS_NOTIFY_FILTER_ARRIVAL      = GUID("0b6d3c89-5917-43ca-b578-d01a7967c41c"),
    GUID_NDIS_NOTIFY_DEVICE_POWER_ON_EX  = GUID("2b440188-92ac-4f60-9b2d-20a30cbb6bbe"),
    GUID_NDIS_NOTIFY_DEVICE_POWER_OFF_EX = GUID("4159353c-5cd7-42ce-8fe4-a45a2380cc4f"),
}

enum : GUID
{
    GUID_NDIS_PM_ADMIN_CONFIG        = GUID("1528d111-708a-4ca4-9215-c05771161cda"),
    GUID_NDIS_PM_ACTIVE_CAPABILITIES = GUID("b2cf76e3-b3ae-4394-a01f-338c9870e939"),
}

enum : GUID
{
    GUID_NDIS_RSS_ENABLED               = GUID("9565cd55-3402-4e32-a5b6-2f143f2f2c30"),
    GUID_NDIS_GEN_HARDWARE_STATUS       = GUID("5ec10354-a61a-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_GEN_MEDIA_SUPPORTED       = GUID("5ec10355-a61a-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_GEN_MEDIA_IN_USE          = GUID("5ec10356-a61a-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_GEN_MAXIMUM_LOOKAHEAD     = GUID("5ec10357-a61a-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_GEN_MAXIMUM_FRAME_SIZE    = GUID("5ec10358-a61a-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_GEN_LINK_SPEED            = GUID("5ec10359-a61a-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_GEN_TRANSMIT_BUFFER_SPACE = GUID("5ec1035a-a61a-11d0-8dd4-00c04fc3358c"),
}

enum : GUID
{
    GUID_NDIS_GEN_RECEIVE_BUFFER_SPACE  = GUID("5ec1035b-a61a-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_GEN_TRANSMIT_BLOCK_SIZE   = GUID("5ec1035c-a61a-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_GEN_RECEIVE_BLOCK_SIZE    = GUID("5ec1035d-a61a-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_GEN_VENDOR_ID             = GUID("5ec1035e-a61a-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_GEN_VENDOR_DESCRIPTION    = GUID("5ec1035f-a61a-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_GEN_CURRENT_PACKET_FILTER = GUID("5ec10360-a61a-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_GEN_CURRENT_LOOKAHEAD     = GUID("5ec10361-a61a-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_GEN_DRIVER_VERSION        = GUID("5ec10362-a61a-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_GEN_MAXIMUM_TOTAL_SIZE    = GUID("5ec10363-a61a-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_GEN_MAC_OPTIONS           = GUID("5ec10365-a61a-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_GEN_MEDIA_CONNECT_STATUS  = GUID("5ec10366-a61a-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_GEN_MAXIMUM_SEND_PACKETS  = GUID("5ec10367-a61a-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_GEN_VENDOR_DRIVER_VERSION = GUID("447956f9-a61b-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_GEN_VLAN_ID               = GUID("765dc702-c5e8-4b67-843b-3f5a4ff2648b"),
    GUID_NDIS_GEN_PHYSICAL_MEDIUM       = GUID("418ca16d-3937-4208-940a-ec6196278085"),
}

enum : GUID
{
    GUID_NDIS_TCP_OFFLOAD_CURRENT_CONFIG                   = GUID("68542fed-5c74-461e-8934-91c6f9c60960"),
    GUID_NDIS_TCP_OFFLOAD_HARDWARE_CAPABILITIES            = GUID("cd5f1102-590f-4ada-ab65-5b31b1dc0172"),
    GUID_NDIS_TCP_OFFLOAD_PARAMETERS                       = GUID("8ead9a22-7f69-4bc6-949a-c8187b074e61"),
    GUID_NDIS_TCP_CONNECTION_OFFLOAD_CURRENT_CONFIG        = GUID("2ee6aef1-0851-458b-bf0d-792343d1cde1"),
    GUID_NDIS_TCP_CONNECTION_OFFLOAD_HARDWARE_CAPABILITIES = GUID("8ce71f2c-d63a-4390-a487-18fa47262ceb"),
}

enum GUID GUID_NDIS_RECEIVE_SCALE_CAPABILITIES = GUID("26c28774-4252-48fe-a610-a58a398c0eb1");

enum : GUID
{
    GUID_NDIS_GEN_LINK_STATE      = GUID("ba1f4c14-a945-4762-b916-0b5515b6f43a"),
    GUID_NDIS_GEN_LINK_PARAMETERS = GUID("8c7d3579-252b-4614-82c5-a650daa15049"),
    GUID_NDIS_GEN_STATISTICS      = GUID("368c45b5-c129-43c1-939e-7edc2d7fe621"),
    GUID_NDIS_GEN_PORT_STATE      = GUID("6fbf2a5f-8b8f-4920-8143-e6c460f52524"),
    GUID_NDIS_GEN_ENUMERATE_PORTS = GUID("f1d6abe8-15e4-4407-81b7-6b830c777cd9"),
}

enum GUID GUID_NDIS_ENUMERATE_ADAPTERS_EX = GUID("16716917-4306-4be4-9b5a-3809ae44b125");
enum GUID GUID_NDIS_GEN_PORT_AUTHENTICATION_PARAMETERS = GUID("aab6ac31-86fb-48fb-8b48-63db235ace16");

enum : GUID
{
    GUID_NDIS_GEN_INTERRUPT_MODERATION            = GUID("d9c8eea5-f16e-467c-84d5-6345a22ce213"),
    GUID_NDIS_GEN_INTERRUPT_MODERATION_PARAMETERS = GUID("d789adfa-9c56-433b-ad01-7574f3cedbe9"),
}

enum GUID GUID_NDIS_GEN_PCI_DEVICE_CUSTOM_PROPERTIES = GUID("aa39f5ab-e260-4d01-82b0-b737c880ea05");
enum GUID GUID_NDIS_GEN_PHYSICAL_MEDIUM_EX = GUID("899e7782-035b-43f9-8bb6-2b58971612e5");

enum : GUID
{
    GUID_NDIS_HD_SPLIT_CURRENT_CONFIG = GUID("81d1303c-ab00-4e49-80b1-5e6e0bf9be53"),
    GUID_NDIS_HD_SPLIT_PARAMETERS     = GUID("8c048bea-2913-4458-b68e-17f6c1e5c60e"),
}

enum GUID GUID_NDIS_TCP_RSC_STATISTICS = GUID("83104445-9b5d-4ee6-a2a5-2bd3fb3c36af");
enum GUID GUID_PM_HARDWARE_CAPABILITIES = GUID("ece5360d-3291-4a6e-8044-00511fed27ee");
enum GUID GUID_PM_CURRENT_CAPABILITIES = GUID("3abdbd14-d44a-4a3f-9a63-a0a42a51b131");

enum : GUID
{
    GUID_PM_PARAMETERS      = GUID("560245d2-e251-409c-a280-311935be3b28"),
    GUID_PM_ADD_WOL_PATTERN = GUID("6fc83ba7-52bc-4faa-ac51-7d2ffe63ba90"),
}

enum GUID GUID_PM_REMOVE_WOL_PATTERN = GUID("a037a915-c6ca-4322-b3e3-ef754ec498dc");
enum GUID GUID_PM_WOL_PATTERN_LIST = GUID("4022be37-7ee2-47be-a5a5-050fc79afc75");
enum GUID GUID_PM_ADD_PROTOCOL_OFFLOAD = GUID("0c06c112-0d93-439b-9e6d-26be130c9784");
enum GUID GUID_PM_GET_PROTOCOL_OFFLOAD = GUID("a6435cd9-149f-498e-951b-2d94bea3e3a3");
enum GUID GUID_PM_REMOVE_PROTOCOL_OFFLOAD = GUID("decd7be2-a6b0-43ca-ae45-d000d20e5265");
enum GUID GUID_PM_PROTOCOL_OFFLOAD_LIST = GUID("736ec5ab-ca8f-4043-bb58-da402a48d9cc");

enum : GUID
{
    GUID_NDIS_RECEIVE_FILTER_HARDWARE_CAPABILITIES = GUID("3f2c1419-83bc-11dd-94b8-001d09162bc3"),
    GUID_NDIS_RECEIVE_FILTER_GLOBAL_PARAMETERS     = GUID("3f2c141a-83bc-11dd-94b8-001d09162bc3"),
    GUID_NDIS_RECEIVE_FILTER_ENUM_QUEUES           = GUID("3f2c141b-83bc-11dd-94b8-001d09162bc3"),
    GUID_NDIS_RECEIVE_FILTER_QUEUE_PARAMETERS      = GUID("3f2c141c-83bc-11dd-94b8-001d09162bc3"),
    GUID_NDIS_RECEIVE_FILTER_ENUM_FILTERS          = GUID("3f2c141d-83bc-11dd-94b8-001d09162bc3"),
    GUID_NDIS_RECEIVE_FILTER_PARAMETERS            = GUID("3f2c141e-83bc-11dd-94b8-001d09162bc3"),
}

enum GUID GUID_RECEIVE_FILTER_CURRENT_CAPABILITIES = GUID("4054e80f-2bc1-4ccc-b033-4abc0c4a1e8c");

enum : GUID
{
    GUID_NIC_SWITCH_HARDWARE_CAPABILITIES = GUID("37cab40c-d1e8-4301-8c1d-58465e0c4c0f"),
    GUID_NIC_SWITCH_CURRENT_CAPABILITIES  = GUID("e76fdaf3-0be7-4d95-87e9-5aead4b590e9"),
}

enum : GUID
{
    GUID_NDIS_SWITCH_MICROSOFT_VENDOR_ID                           = GUID("202547fe-1c9c-40b9-bba1-08ada1f98b3c"),
    GUID_NDIS_SWITCH_PORT_PROPERTY_PROFILE_ID_DEFAULT_EXTERNAL_NIC = GUID("0b347846-0a0c-470a-9b7a-0d965850698f"),
}

enum : GUID
{
    GUID_NDIS_GEN_XMIT_OK                  = GUID("447956fa-a61b-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_GEN_RCV_OK                   = GUID("447956fb-a61b-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_GEN_XMIT_ERROR               = GUID("447956fc-a61b-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_GEN_RCV_ERROR                = GUID("447956fd-a61b-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_GEN_RCV_NO_BUFFER            = GUID("447956fe-a61b-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_GEN_CO_HARDWARE_STATUS       = GUID("791ad192-e35c-11d0-9692-00c04fc3358c"),
    GUID_NDIS_GEN_CO_MEDIA_SUPPORTED       = GUID("791ad193-e35c-11d0-9692-00c04fc3358c"),
    GUID_NDIS_GEN_CO_MEDIA_IN_USE          = GUID("791ad194-e35c-11d0-9692-00c04fc3358c"),
    GUID_NDIS_GEN_CO_LINK_SPEED            = GUID("791ad195-e35c-11d0-9692-00c04fc3358c"),
    GUID_NDIS_GEN_CO_VENDOR_ID             = GUID("791ad196-e35c-11d0-9692-00c04fc3358c"),
    GUID_NDIS_GEN_CO_VENDOR_DESCRIPTION    = GUID("791ad197-e35c-11d0-9692-00c04fc3358c"),
    GUID_NDIS_GEN_CO_DRIVER_VERSION        = GUID("791ad198-e35c-11d0-9692-00c04fc3358c"),
    GUID_NDIS_GEN_CO_MAC_OPTIONS           = GUID("791ad19a-e35c-11d0-9692-00c04fc3358c"),
    GUID_NDIS_GEN_CO_MEDIA_CONNECT_STATUS  = GUID("791ad19b-e35c-11d0-9692-00c04fc3358c"),
    GUID_NDIS_GEN_CO_VENDOR_DRIVER_VERSION = GUID("791ad19c-e35c-11d0-9692-00c04fc3358c"),
    GUID_NDIS_GEN_CO_MINIMUM_LINK_SPEED    = GUID("791ad19d-e35c-11d0-9692-00c04fc3358c"),
    GUID_NDIS_GEN_CO_XMIT_PDUS_OK          = GUID("0a214805-e35f-11d0-9692-00c04fc3358c"),
    GUID_NDIS_GEN_CO_RCV_PDUS_OK           = GUID("0a214806-e35f-11d0-9692-00c04fc3358c"),
    GUID_NDIS_GEN_CO_XMIT_PDUS_ERROR       = GUID("0a214807-e35f-11d0-9692-00c04fc3358c"),
    GUID_NDIS_GEN_CO_RCV_PDUS_ERROR        = GUID("0a214808-e35f-11d0-9692-00c04fc3358c"),
    GUID_NDIS_GEN_CO_RCV_PDUS_NO_BUFFER    = GUID("0a214809-e35f-11d0-9692-00c04fc3358c"),
}

enum : GUID
{
    GUID_NDIS_802_3_PERMANENT_ADDRESS    = GUID("447956ff-a61b-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_802_3_CURRENT_ADDRESS      = GUID("44795700-a61b-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_802_3_MULTICAST_LIST       = GUID("44795701-a61b-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_802_3_MAXIMUM_LIST_SIZE    = GUID("44795702-a61b-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_802_3_MAC_OPTIONS          = GUID("44795703-a61b-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_802_3_RCV_ERROR_ALIGNMENT  = GUID("44795704-a61b-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_802_3_XMIT_ONE_COLLISION   = GUID("44795705-a61b-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_802_3_XMIT_MORE_COLLISIONS = GUID("44795706-a61b-11d0-8dd4-00c04fc3358c"),
}

enum : GUID
{
    GUID_NDIS_802_5_PERMANENT_ADDRESS        = GUID("44795707-a61b-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_802_5_CURRENT_ADDRESS          = GUID("44795708-a61b-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_802_5_CURRENT_FUNCTIONAL       = GUID("44795709-a61b-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_802_5_CURRENT_GROUP            = GUID("4479570a-a61b-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_802_5_LAST_OPEN_STATUS         = GUID("4479570b-a61b-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_802_5_CURRENT_RING_STATUS      = GUID("890a36ec-a61c-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_802_5_CURRENT_RING_STATE       = GUID("acf14032-a61c-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_802_5_LINE_ERRORS              = GUID("acf14033-a61c-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_802_5_LOST_FRAMES              = GUID("acf14034-a61c-11d0-8dd4-00c04fc3358c"),
    GUID_NDIS_802_11_BSSID                   = GUID("2504b6c2-1fa5-11d4-97eb-00c04f79c403"),
    GUID_NDIS_802_11_SSID                    = GUID("7d2a90ea-2041-11d4-97eb-00c04f79c403"),
    GUID_NDIS_802_11_NETWORK_TYPES_SUPPORTED = GUID("8531d6e6-2041-11d4-97eb-00c04f79c403"),
    GUID_NDIS_802_11_NETWORK_TYPE_IN_USE     = GUID("857e2326-2041-11d4-97eb-00c04f79c403"),
    GUID_NDIS_802_11_POWER_MODE              = GUID("85be837c-2041-11d4-97eb-00c04f79c403"),
    GUID_NDIS_802_11_TX_POWER_LEVEL          = GUID("11e6ba76-2053-11d4-97eb-00c04f79c403"),
    GUID_NDIS_802_11_RSSI                    = GUID("1507db16-2053-11d4-97eb-00c04f79c403"),
    GUID_NDIS_802_11_RSSI_TRIGGER            = GUID("155689b8-2053-11d4-97eb-00c04f79c403"),
    GUID_NDIS_802_11_BSSID_LIST              = GUID("69526f9a-2062-11d4-97eb-00c04f79c403"),
    GUID_NDIS_802_11_INFRASTRUCTURE_MODE     = GUID("697d5a7e-2062-11d4-97eb-00c04f79c403"),
    GUID_NDIS_802_11_FRAGMENTATION_THRESHOLD = GUID("69aaa7c4-2062-11d4-97eb-00c04f79c403"),
    GUID_NDIS_802_11_RTS_THRESHOLD           = GUID("0134d07e-2064-11d4-97eb-00c04f79c403"),
    GUID_NDIS_802_11_NUMBER_OF_ANTENNAS      = GUID("01779336-2064-11d4-97eb-00c04f79c403"),
    GUID_NDIS_802_11_RX_ANTENNA_SELECTED     = GUID("01ac07a2-2064-11d4-97eb-00c04f79c403"),
    GUID_NDIS_802_11_TX_ANTENNA_SELECTED     = GUID("01dbb74a-2064-11d4-97eb-00c04f79c403"),
    GUID_NDIS_802_11_SUPPORTED_RATES         = GUID("49db8722-2068-11d4-97eb-00c04f79c403"),
    GUID_NDIS_802_11_DESIRED_RATES           = GUID("452ee08e-2536-11d4-97eb-00c04f79c403"),
    GUID_NDIS_802_11_CONFIGURATION           = GUID("4a4df982-2068-11d4-97eb-00c04f79c403"),
    GUID_NDIS_802_11_STATISTICS              = GUID("42bb73b0-2129-11d4-97eb-00c04f79c403"),
    GUID_NDIS_802_11_ADD_WEP                 = GUID("4307bff0-2129-11d4-97eb-00c04f79c403"),
    GUID_NDIS_802_11_REMOVE_WEP              = GUID("433c345c-2129-11d4-97eb-00c04f79c403"),
    GUID_NDIS_802_11_DISASSOCIATE            = GUID("43671f40-2129-11d4-97eb-00c04f79c403"),
    GUID_NDIS_802_11_AUTHENTICATION_MODE     = GUID("43920a24-2129-11d4-97eb-00c04f79c403"),
    GUID_NDIS_802_11_PRIVACY_FILTER          = GUID("6733c4e9-4792-11d4-97f1-00c04f79c403"),
    GUID_NDIS_802_11_BSSID_LIST_SCAN         = GUID("0d9e01e1-ba70-11d4-b675-002048570337"),
    GUID_NDIS_802_11_WEP_STATUS              = GUID("b027a21f-3cfa-4125-800b-3f7a18fddcdc"),
    GUID_NDIS_802_11_RELOAD_DEFAULTS         = GUID("748b14e8-32ee-4425-b91b-c9848c58b55a"),
    GUID_NDIS_802_11_ADD_KEY                 = GUID("ab8b5a62-1d51-49d8-ba5c-fa980be03a1d"),
    GUID_NDIS_802_11_REMOVE_KEY              = GUID("73cb28e9-3188-42d5-b553-b21237e6088c"),
    GUID_NDIS_802_11_ASSOCIATION_INFORMATION = GUID("a08d4dd0-960e-40bd-8cf6-c538af98f2e3"),
    GUID_NDIS_802_11_TEST                    = GUID("4b9ca16a-6a60-4e9d-920c-6335953fa0b5"),
    GUID_NDIS_802_11_MEDIA_STREAM_MODE       = GUID("0a56af66-d84b-49eb-a28d-5282cbb6d0cd"),
}

enum : GUID
{
    GUID_NDIS_STATUS_RESET_START                        = GUID("981f2d76-b1f3-11d0-8dd7-00c04fc3358c"),
    GUID_NDIS_STATUS_RESET_END                          = GUID("981f2d77-b1f3-11d0-8dd7-00c04fc3358c"),
    GUID_NDIS_STATUS_MEDIA_CONNECT                      = GUID("981f2d7d-b1f3-11d0-8dd7-00c04fc3358c"),
    GUID_NDIS_STATUS_MEDIA_DISCONNECT                   = GUID("981f2d7e-b1f3-11d0-8dd7-00c04fc3358c"),
    GUID_NDIS_STATUS_MEDIA_SPECIFIC_INDICATION          = GUID("981f2d84-b1f3-11d0-8dd7-00c04fc3358c"),
    GUID_NDIS_STATUS_LINK_SPEED_CHANGE                  = GUID("981f2d85-b1f3-11d0-8dd7-00c04fc3358c"),
    GUID_NDIS_STATUS_PACKET_FILTER                      = GUID("d47c5407-2e75-46dd-8146-1d7ed2d6ab1d"),
    GUID_NDIS_STATUS_NETWORK_CHANGE                     = GUID("ca8a56f9-ce81-40e6-a70f-a067a476e9e9"),
    GUID_NDIS_STATUS_TASK_OFFLOAD_CURRENT_CONFIG        = GUID("45049fc6-54d8-40c8-9c3d-b011c4e715bc"),
    GUID_NDIS_STATUS_TASK_OFFLOAD_HARDWARE_CAPABILITIES = GUID("b6b8158b-217c-4b2a-be86-6a04beea65b8"),
}

enum : GUID
{
    GUID_NDIS_STATUS_TCP_CONNECTION_OFFLOAD_CURRENT_CONFIG        = GUID("f8edaeff-24e4-4ae6-a413-0b27f76b243d"),
    GUID_NDIS_STATUS_TCP_CONNECTION_OFFLOAD_HARDWARE_CAPABILITIES = GUID("391969b6-402c-43bf-8922-39eae0da1bb5"),
}

enum : GUID
{
    GUID_NDIS_STATUS_OPER_STATUS                  = GUID("f917b663-845e-4d3d-b6d4-15eb27af81c5"),
    GUID_NDIS_STATUS_LINK_STATE                   = GUID("64c6f797-878c-4311-9246-65dba89c3a61"),
    GUID_NDIS_STATUS_PORT_STATE                   = GUID("1dac0dfe-43e5-44b7-b759-7bf46de32e81"),
    GUID_NDIS_STATUS_EXTERNAL_CONNECTIVITY_CHANGE = GUID("fd306974-c420-4433-b0fe-4cf6a613f59f"),
}

enum GUID GUID_STATUS_MEDIA_SPECIFIC_INDICATION_EX = GUID("aaacfca7-954a-4632-a16e-a8a63793a9e5");

enum : GUID
{
    GUID_NDIS_STATUS_HD_SPLIT_CURRENT_CONFIG       = GUID("6c744b0e-ee9c-4205-90a2-015f6d65f403"),
    GUID_NDIS_STATUS_PM_WOL_PATTERN_REJECTED       = GUID("f72cf68e-18d4-4d63-9a19-e69b13916b1a"),
    GUID_NDIS_STATUS_PM_OFFLOAD_REJECTED           = GUID("add1d481-711e-4d1a-92ca-a62db9329712"),
    GUID_NDIS_STATUS_PM_WAKE_REASON                = GUID("0933fd58-ca62-438f-83da-dfc1cccb8145"),
    GUID_NDIS_STATUS_DOT11_SCAN_CONFIRM            = GUID("8500591e-a0c7-4efb-9342-b674b002cbe6"),
    GUID_NDIS_STATUS_DOT11_MPDU_MAX_LENGTH_CHANGED = GUID("1d6560ec-8e48-4a3e-9fd5-a01b698db6c5"),
    GUID_NDIS_STATUS_DOT11_ASSOCIATION_START       = GUID("3927843b-6980-4b48-b15b-4de50977ac40"),
    GUID_NDIS_STATUS_DOT11_ASSOCIATION_COMPLETION  = GUID("458bbea7-45a4-4ae2-b176-e51f96fc0568"),
    GUID_NDIS_STATUS_DOT11_CONNECTION_START        = GUID("7b74299d-998f-4454-ad08-c5af28576d1b"),
    GUID_NDIS_STATUS_DOT11_CONNECTION_COMPLETION   = GUID("96efd9c9-7f1b-4a89-bc04-3e9e271765f1"),
    GUID_NDIS_STATUS_DOT11_ROAMING_START           = GUID("b2412d0d-26c8-4f4e-93df-f7b705a0b433"),
    GUID_NDIS_STATUS_DOT11_ROAMING_COMPLETION      = GUID("dd9d47d1-282b-41e4-b924-66368817fcd3"),
    GUID_NDIS_STATUS_DOT11_DISASSOCIATION          = GUID("3fbeb6fc-0fe2-43fd-b2ad-bd99b5f93e13"),
    GUID_NDIS_STATUS_DOT11_TKIPMIC_FAILURE         = GUID("442c2ae4-9bc5-4b90-a889-455ef220f4ee"),
    GUID_NDIS_STATUS_DOT11_PMKID_CANDIDATE_LIST    = GUID("26d8b8f6-db82-49eb-8bf3-4c130ef06950"),
    GUID_NDIS_STATUS_DOT11_PHY_STATE_CHANGED       = GUID("deb45316-71b5-4736-bdef-0a9e9f4e62dc"),
    GUID_NDIS_STATUS_DOT11_LINK_QUALITY            = GUID("a3285184-ea99-48ed-825e-a426b11c2754"),
}

enum : uint
{
    NDK_ADAPTER_FLAG_IN_ORDER_DMA_SUPPORTED      = 0x00000001U,
    NDK_ADAPTER_FLAG_RDMA_READ_SINK_NOT_REQUIRED = 0x00000002U,
}

enum uint NDK_ADAPTER_FLAG_CQ_INTERRUPT_MODERATION_SUPPORTED = 0x00000004U;

enum : uint
{
    NDK_ADAPTER_FLAG_MULTI_ENGINE_SUPPORTED               = 0x00000008U,
    NDK_ADAPTER_FLAG_RDMA_READ_LOCAL_INVALIDATE_SUPPORTED = 0x00000010U,
}

enum : uint
{
    NDK_ADAPTER_FLAG_CQ_RESIZE_SUPPORTED            = 0x00000100U,
    NDK_ADAPTER_FLAG_LOOPBACK_CONNECTIONS_SUPPORTED = 0x00010000U,
}

enum : uint
{
    NET_IF_OPER_STATUS_DOWN_NOT_AUTHENTICATED   = 0x00000001U,
    NET_IF_OPER_STATUS_DOWN_NOT_MEDIA_CONNECTED = 0x00000002U,
    NET_IF_OPER_STATUS_DORMANT_PAUSED           = 0x00000004U,
    NET_IF_OPER_STATUS_DORMANT_LOW_POWER        = 0x00000008U,
}

enum : uint
{
    NET_IF_OID_IF_ALIAS       = 0x00000001U,
    NET_IF_OID_COMPARTMENT_ID = 0x00000002U,
    NET_IF_OID_NETWORK_GUID   = 0x00000003U,
    NET_IF_OID_IF_ENTRY       = 0x00000004U,
}

enum : uint
{
    NET_SITEID_UNSPECIFIED = 0x00000000U,
    NET_SITEID_MAXUSER     = 0x07ffffffU,
    NET_SITEID_MAXSYSTEM   = 0x0fffffffU,
}

enum uint NET_IFLUID_UNSPECIFIED = 0x00000000U;
enum uint NIIF_HARDWARE_INTERFACE = 0x00000001U;
enum uint NIIF_FILTER_INTERFACE = 0x00000002U;

enum : uint
{
    NIIF_NDIS_RESERVED1          = 0x00000004U,
    NIIF_NDIS_RESERVED2          = 0x00000008U,
    NIIF_NDIS_RESERVED3          = 0x00000010U,
    NIIF_NDIS_WDM_INTERFACE      = 0x00000020U,
    NIIF_NDIS_ENDPOINT_INTERFACE = 0x00000040U,
}

enum uint NIIF_NDIS_ISCSI_INTERFACE = 0x00000080U;
enum uint NIIF_NDIS_RESERVED4 = 0x00000100U;
enum uint IF_MAX_STRING_SIZE = 0x00000100U;
enum uint IF_MAX_PHYS_ADDRESS_LENGTH = 0x00000020U;

// Structs


struct NET_IF_COMPARTMENT_ID
{
    uint Value;
}

struct NET_IF_RCV_ADDRESS_LH
{
    NET_IF_RCV_ADDRESS_TYPE ifRcvAddressType;
    ushort ifRcvAddressLength;
    ushort ifRcvAddressOffset;
}

struct NET_IF_ALIAS_LH
{
    ushort ifAliasLength;
    ushort ifAliasOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ifdef/ns-ifdef-net_luid_lh
union NET_LUID_LH
{
    ulong Value;
    struct Info
    {
        // Native bit field: Reserved: [0-23], NetLuidIndex: [24-47], IfType: [48-63]
        ulong _bitfield0;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ifdef/ns-ifdef-net_physical_location_lh
struct NET_PHYSICAL_LOCATION_LH
{
    uint BusNumber;
    uint SlotNumber;
    uint FunctionNumber;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ifdef/ns-ifdef-if_counted_string_lh
struct IF_COUNTED_STRING_LH
{
    ushort     Length;
    wchar[257] String;
}

struct IF_PHYSICAL_ADDRESS_LH
{
    ushort    Length;
    ubyte[32] Address;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ifdef/ns-ifdef-ndis_interface_information
struct NDIS_INTERFACE_INFORMATION
{
    NET_IF_OPER_STATUS ifOperStatus;
    uint               ifOperStatusFlags;
    NET_IF_MEDIA_CONNECT_STATE MediaConnectState;
    NET_IF_MEDIA_DUPLEX_STATE MediaDuplexState;
    uint               ifMtu;
    BOOLEAN            ifPromiscuousMode;
    BOOLEAN            ifDeviceWakeUpEnable;
    ulong              XmitLinkSpeed;
    ulong              RcvLinkSpeed;
    ulong              ifLastChange;
    ulong              ifCounterDiscontinuityTime;
    ulong              ifInUnknownProtos;
    ulong              ifInDiscards;
    ulong              ifInErrors;
    ulong              ifHCInOctets;
    ulong              ifHCInUcastPkts;
    ulong              ifHCInMulticastPkts;
    ulong              ifHCInBroadcastPkts;
    ulong              ifHCOutOctets;
    ulong              ifHCOutUcastPkts;
    ulong              ifHCOutMulticastPkts;
    ulong              ifHCOutBroadcastPkts;
    ulong              ifOutErrors;
    ulong              ifOutDiscards;
    ulong              ifHCInUcastOctets;
    ulong              ifHCInMulticastOctets;
    ulong              ifHCInBroadcastOctets;
    ulong              ifHCOutUcastOctets;
    ulong              ifHCOutMulticastOctets;
    ulong              ifHCOutBroadcastOctets;
    NET_IF_COMPARTMENT_ID CompartmentId;
    uint               SupportedStatistics;
}

struct NDIS_STATISTICS_VALUE
{
    uint     Oid;
    uint     DataLength;
    ubyte[1] Data; // Flexible array
}

struct NDIS_STATISTICS_VALUE_EX
{
    uint     Oid;
    uint     DataLength;
    uint     Length;
    ubyte[1] Data; // Flexible array
}

struct NDIS_VAR_DATA_DESC
{
    ushort Length;
    ushort MaximumLength;
    size_t Offset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/NativeWiFi/ndis-object-header
struct NDIS_OBJECT_HEADER
{
    ubyte  Type;
    ubyte  Revision;
    ushort Size;
}

struct NDIS_STATISTICS_INFO
{
    NDIS_OBJECT_HEADER Header;
    uint               SupportedStatistics;
    ulong              ifInDiscards;
    ulong              ifInErrors;
    ulong              ifHCInOctets;
    ulong              ifHCInUcastPkts;
    ulong              ifHCInMulticastPkts;
    ulong              ifHCInBroadcastPkts;
    ulong              ifHCOutOctets;
    ulong              ifHCOutUcastPkts;
    ulong              ifHCOutMulticastPkts;
    ulong              ifHCOutBroadcastPkts;
    ulong              ifOutErrors;
    ulong              ifOutDiscards;
    ulong              ifHCInUcastOctets;
    ulong              ifHCInMulticastOctets;
    ulong              ifHCInBroadcastOctets;
    ulong              ifHCOutUcastOctets;
    ulong              ifHCOutMulticastOctets;
    ulong              ifHCOutBroadcastOctets;
}

struct NDIS_INTERRUPT_MODERATION_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint               Flags;
    NDIS_INTERRUPT_MODERATION InterruptModeration;
}

struct NDIS_TIMEOUT_DPC_REQUEST_CAPABILITIES
{
    NDIS_OBJECT_HEADER Header;
    uint               Flags;
    uint               TimeoutArrayLength;
    uint[1]            TimeoutArray; // Flexible array
}

struct NDIS_PCI_DEVICE_CUSTOM_PROPERTIES
{
    NDIS_OBJECT_HEADER Header;
    uint               DeviceType;
    uint               CurrentSpeedAndMode;
    uint               CurrentPayloadSize;
    uint               MaxPayloadSize;
    uint               MaxReadRequestSize;
    uint               CurrentLinkSpeed;
    uint               CurrentLinkWidth;
    uint               MaxLinkSpeed;
    uint               MaxLinkWidth;
    uint               PciExpressVersion;
    uint               InterruptType;
    uint               MaxInterruptMessages;
}

struct NDIS_802_11_STATUS_INDICATION
{
    NDIS_802_11_STATUS_TYPE StatusType;
}

struct NDIS_802_11_AUTHENTICATION_REQUEST
{
    uint     Length;
    ubyte[6] Bssid;
    uint     Flags;
}

struct PMKID_CANDIDATE
{
    ubyte[6] BSSID;
    uint     Flags;
}

struct NDIS_802_11_PMKID_CANDIDATE_LIST
{
    uint               Version;
    uint               NumCandidates;
    PMKID_CANDIDATE[1] CandidateList; // Flexible array
}

struct NDIS_802_11_NETWORK_TYPE_LIST
{
    uint NumberOfItems;
    NDIS_802_11_NETWORK_TYPE[1] NetworkType; // Flexible array
}

struct NDIS_802_11_CONFIGURATION_FH
{
    uint Length;
    uint HopPattern;
    uint HopSet;
    uint DwellTime;
}

struct NDIS_802_11_CONFIGURATION
{
    uint Length;
    uint BeaconPeriod;
    uint ATIMWindow;
    uint DSConfig;
    NDIS_802_11_CONFIGURATION_FH FHConfig;
}

struct NDIS_802_11_STATISTICS
{
    uint Length;
    long TransmittedFragmentCount;
    long MulticastTransmittedFrameCount;
    long FailedCount;
    long RetryCount;
    long MultipleRetryCount;
    long RTSSuccessCount;
    long RTSFailureCount;
    long ACKFailureCount;
    long FrameDuplicateCount;
    long ReceivedFragmentCount;
    long MulticastReceivedFrameCount;
    long FCSErrorCount;
    long TKIPLocalMICFailures;
    long TKIPICVErrorCount;
    long TKIPCounterMeasuresInvoked;
    long TKIPReplays;
    long CCMPFormatErrors;
    long CCMPReplays;
    long CCMPDecryptErrors;
    long FourWayHandshakeFailures;
    long WEPUndecryptableCount;
    long WEPICVErrorCount;
    long DecryptSuccessCount;
    long DecryptFailureCount;
}

struct NDIS_802_11_KEY
{
    uint     Length;
    uint     KeyIndex;
    uint     KeyLength;
    ubyte[6] BSSID;
    ulong    KeyRSC;
    ubyte[1] KeyMaterial; // Flexible array
}

struct NDIS_802_11_REMOVE_KEY
{
    uint     Length;
    uint     KeyIndex;
    ubyte[6] BSSID;
}

struct NDIS_802_11_WEP
{
    uint     Length;
    uint     KeyIndex;
    uint     KeyLength;
    ubyte[1] KeyMaterial; // Flexible array
}

struct NDIS_802_11_SSID
{
    uint      SsidLength;
    ubyte[32] Ssid;
}

struct NDIS_WLAN_BSSID
{
    uint             Length;
    ubyte[6]         MacAddress;
    ubyte[2]         Reserved;
    NDIS_802_11_SSID Ssid;
    uint             Privacy;
    int              Rssi;
    NDIS_802_11_NETWORK_TYPE NetworkTypeInUse;
    NDIS_802_11_CONFIGURATION Configuration;
    NDIS_802_11_NETWORK_INFRASTRUCTURE InfrastructureMode;
    ubyte[8]         SupportedRates;
}

struct NDIS_802_11_BSSID_LIST
{
    uint               NumberOfItems;
    NDIS_WLAN_BSSID[1] Bssid; // Flexible array
}

struct NDIS_WLAN_BSSID_EX
{
    uint             Length;
    ubyte[6]         MacAddress;
    ubyte[2]         Reserved;
    NDIS_802_11_SSID Ssid;
    uint             Privacy;
    int              Rssi;
    NDIS_802_11_NETWORK_TYPE NetworkTypeInUse;
    NDIS_802_11_CONFIGURATION Configuration;
    NDIS_802_11_NETWORK_INFRASTRUCTURE InfrastructureMode;
    ubyte[16]        SupportedRates;
    uint             IELength;
    ubyte[1]         IEs; // Flexible array
}

struct NDIS_802_11_BSSID_LIST_EX
{
    uint NumberOfItems;
    NDIS_WLAN_BSSID_EX[1] Bssid; // Flexible array
}

struct NDIS_802_11_FIXED_IEs
{
    ubyte[8] Timestamp;
    ushort   BeaconInterval;
    ushort   Capabilities;
}

struct NDIS_802_11_VARIABLE_IEs
{
    ubyte    ElementID;
    ubyte    Length;
    ubyte[1] data; // Flexible array
}

struct NDIS_802_11_AI_REQFI
{
    ushort   Capabilities;
    ushort   ListenInterval;
    ubyte[6] CurrentAPAddress;
}

struct NDIS_802_11_AI_RESFI
{
    ushort Capabilities;
    ushort StatusCode;
    ushort AssociationId;
}

struct NDIS_802_11_ASSOCIATION_INFORMATION
{
    uint                 Length;
    ushort               AvailableRequestFixedIEs;
    NDIS_802_11_AI_REQFI RequestFixedIEs;
    uint                 RequestIELength;
    uint                 OffsetRequestIEs;
    ushort               AvailableResponseFixedIEs;
    NDIS_802_11_AI_RESFI ResponseFixedIEs;
    uint                 ResponseIELength;
    uint                 OffsetResponseIEs;
}

struct NDIS_802_11_AUTHENTICATION_EVENT
{
    NDIS_802_11_STATUS_INDICATION Status;
    NDIS_802_11_AUTHENTICATION_REQUEST[1] Request; // Flexible array
}

struct NDIS_802_11_TEST
{
    uint Length;
    uint Type;
    union
    {
        NDIS_802_11_AUTHENTICATION_EVENT AuthenticationEvent;
        int RssiTrigger;
    }
}

struct BSSID_INFO
{
    ubyte[6]  BSSID;
    ubyte[16] PMKID;
}

struct NDIS_802_11_PMKID
{
    uint          Length;
    uint          BSSIDInfoCount;
    BSSID_INFO[1] BSSIDInfo; // Flexible array
}

struct NDIS_802_11_AUTHENTICATION_ENCRYPTION
{
    NDIS_802_11_AUTHENTICATION_MODE AuthModeSupported;
    NDIS_802_11_WEP_STATUS EncryptStatusSupported;
}

struct NDIS_802_11_CAPABILITY
{
    uint Length;
    uint Version;
    uint NoOfPMKIDs;
    uint NoOfAuthEncryptPairsSupported;
    NDIS_802_11_AUTHENTICATION_ENCRYPTION[1] AuthenticationEncryptionSupported; // Flexible array
}

struct NDIS_802_11_NON_BCAST_SSID_LIST
{
    uint                NumberOfItems;
    NDIS_802_11_SSID[1] Non_Bcast_Ssid; // Flexible array
}

struct NDIS_CO_DEVICE_PROFILE
{
    NDIS_VAR_DATA_DESC DeviceDescription;
    NDIS_VAR_DATA_DESC DevSpecificInfo;
    uint               ulTAPISupplementaryPassThru;
    uint               ulAddressModes;
    uint               ulNumAddresses;
    uint               ulBearerModes;
    uint               ulMaxTxRate;
    uint               ulMinTxRate;
    uint               ulMaxRxRate;
    uint               ulMinRxRate;
    uint               ulMediaModes;
    uint               ulGenerateToneModes;
    uint               ulGenerateToneMaxNumFreq;
    uint               ulGenerateDigitModes;
    uint               ulMonitorToneMaxNumFreq;
    uint               ulMonitorToneMaxNumEntries;
    uint               ulMonitorDigitModes;
    uint               ulGatherDigitsMinTimeout;
    uint               ulGatherDigitsMaxTimeout;
    uint               ulDevCapFlags;
    uint               ulMaxNumActiveCalls;
    uint               ulAnswerMode;
    uint               ulUUIAcceptSize;
    uint               ulUUIAnswerSize;
    uint               ulUUIMakeCallSize;
    uint               ulUUIDropSize;
    uint               ulUUISendUserUserInfoSize;
    uint               ulUUICallInfoSize;
}

struct OFFLOAD_ALGO_INFO
{
    uint algoIdentifier;
    uint algoKeylen;
    uint algoRounds;
}

struct OFFLOAD_SECURITY_ASSOCIATION
{
    OFFLOAD_OPERATION_E Operation;
    uint                SPI;
    OFFLOAD_ALGO_INFO   IntegrityAlgo;
    OFFLOAD_ALGO_INFO   ConfAlgo;
    OFFLOAD_ALGO_INFO   Reserved;
}

struct OFFLOAD_IPSEC_ADD_SA
{
    uint     SrcAddr;
    uint     SrcMask;
    uint     DestAddr;
    uint     DestMask;
    uint     Protocol;
    ushort   SrcPort;
    ushort   DestPort;
    uint     SrcTunnelAddr;
    uint     DestTunnelAddr;
    ushort   Flags;
    short    NumSAs;
    OFFLOAD_SECURITY_ASSOCIATION[3] SecAssoc;
    HANDLE   OffloadHandle;
    uint     KeyLen;
    ubyte[1] KeyMat; // Flexible array
}

struct OFFLOAD_IPSEC_DELETE_SA
{
    HANDLE OffloadHandle;
}

struct OFFLOAD_IPSEC_UDPESP_ENCAPTYPE_ENTRY
{
    UDP_ENCAP_TYPE UdpEncapType;
    ushort         DstEncapPort;
}

struct OFFLOAD_IPSEC_ADD_UDPESP_SA
{
    uint     SrcAddr;
    uint     SrcMask;
    uint     DstAddr;
    uint     DstMask;
    uint     Protocol;
    ushort   SrcPort;
    ushort   DstPort;
    uint     SrcTunnelAddr;
    uint     DstTunnelAddr;
    ushort   Flags;
    short    NumSAs;
    OFFLOAD_SECURITY_ASSOCIATION[3] SecAssoc;
    HANDLE   OffloadHandle;
    OFFLOAD_IPSEC_UDPESP_ENCAPTYPE_ENTRY EncapTypeEntry;
    HANDLE   EncapTypeEntryOffldHandle;
    uint     KeyLen;
    ubyte[1] KeyMat; // Flexible array
}

struct OFFLOAD_IPSEC_DELETE_UDPESP_SA
{
    HANDLE OffloadHandle;
    HANDLE EncapTypeEntryOffldHandle;
}

struct TRANSPORT_HEADER_OFFSET
{
    ushort ProtocolType;
    ushort HeaderOffset;
}

struct NETWORK_ADDRESS
{
    ushort   AddressLength;
    ushort   AddressType;
    ubyte[1] Address; // Flexible array
}

struct NETWORK_ADDRESS_LIST
{
    int                AddressCount;
    ushort             AddressType;
    NETWORK_ADDRESS[1] Address; // Flexible array
}

struct NETWORK_ADDRESS_IP
{
    ushort   sin_port;
    uint     IN_ADDR;
    ubyte[8] sin_zero;
}

struct NETWORK_ADDRESS_IP6
{
    ushort    sin6_port;
    uint      sin6_flowinfo;
    ushort[8] sin6_addr;
    uint      sin6_scope_id;
}

struct NETWORK_ADDRESS_IPX
{
    uint     NetworkAddress;
    ubyte[6] NodeAddress;
    ushort   Socket;
}

struct GEN_GET_TIME_CAPS
{
    uint Flags;
    uint ClockPrecision;
}

struct GEN_GET_NETCARD_TIME
{
    ulong ReadTime;
}

struct NDIS_PM_PACKET_PATTERN
{
    uint Priority;
    uint Reserved;
    uint MaskSize;
    uint PatternOffset;
    uint PatternSize;
    uint PatternFlags;
}

struct NDIS_PM_WAKE_UP_CAPABILITIES
{
    NDIS_DEVICE_POWER_STATE MinMagicPacketWakeUp;
    NDIS_DEVICE_POWER_STATE MinPatternWakeUp;
    NDIS_DEVICE_POWER_STATE MinLinkChangeWakeUp;
}

struct NDIS_PNP_CAPABILITIES
{
    uint Flags;
    NDIS_PM_WAKE_UP_CAPABILITIES WakeUpCapabilities;
}

struct NDIS_WAN_PROTOCOL_CAPS
{
    uint Flags;
    uint Reserved;
}

struct NDIS_CO_LINK_SPEED
{
    uint Outbound;
    uint Inbound;
}

struct NDIS_LINK_SPEED
{
    ulong XmitLinkSpeed;
    ulong RcvLinkSpeed;
}

struct NDIS_GUID
{
    GUID Guid;
    union
    {
        uint Oid;
        int  Status;
    }
    uint Size;
    uint Flags;
}

struct NDIS_IRDA_PACKET_INFO
{
    uint ExtraBOFs;
    uint MinTurnAroundTime;
}

struct NDIS_LINK_STATE
{
    NDIS_OBJECT_HEADER Header;
    NET_IF_MEDIA_CONNECT_STATE MediaConnectState;
    NET_IF_MEDIA_DUPLEX_STATE MediaDuplexState;
    ulong              XmitLinkSpeed;
    ulong              RcvLinkSpeed;
    NDIS_SUPPORTED_PAUSE_FUNCTIONS PauseFunctions;
    uint               AutoNegotiationFlags;
}

struct NDIS_LINK_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    NET_IF_MEDIA_DUPLEX_STATE MediaDuplexState;
    ulong              XmitLinkSpeed;
    ulong              RcvLinkSpeed;
    NDIS_SUPPORTED_PAUSE_FUNCTIONS PauseFunctions;
    uint               AutoNegotiationFlags;
}

struct NDIS_OPER_STATE
{
    NDIS_OBJECT_HEADER Header;
    NET_IF_OPER_STATUS OperationalStatus;
    uint               OperationalStatusFlags;
}

struct NDIS_IP_OPER_STATUS
{
    uint               AddressFamily;
    NET_IF_OPER_STATUS OperationalStatus;
    uint               OperationalStatusFlags;
}

struct NDIS_IP_OPER_STATUS_INFO
{
    NDIS_OBJECT_HEADER Header;
    uint               Flags;
    uint               NumberofAddressFamiliesReturned;
    NDIS_IP_OPER_STATUS[32] IpOperationalStatus;
}

struct NDIS_IP_OPER_STATE
{
    NDIS_OBJECT_HEADER  Header;
    uint                Flags;
    NDIS_IP_OPER_STATUS IpOperationalStatus;
}

struct NDIS_OFFLOAD_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ubyte              IPv4Checksum;
    ubyte              TCPIPv4Checksum;
    ubyte              UDPIPv4Checksum;
    ubyte              TCPIPv6Checksum;
    ubyte              UDPIPv6Checksum;
    ubyte              LsoV1;
    ubyte              IPsecV1;
    ubyte              LsoV2IPv4;
    ubyte              LsoV2IPv6;
    ubyte              TcpConnectionIPv4;
    ubyte              TcpConnectionIPv6;
    uint               Flags;
}

struct NDIS_TCP_LARGE_SEND_OFFLOAD_V1
{
    struct IPv4
    {
        uint Encapsulation;
        uint MaxOffLoadSize;
        uint MinSegmentCount;
        // Native bit field: TcpOptions: [0-1], IpOptions: [2-3]
        uint _bitfield0;
    }
}

struct NDIS_TCP_IP_CHECKSUM_OFFLOAD
{
    struct IPv4Transmit
    {
        uint Encapsulation;
        // Native bit field: IpOptionsSupported: [0-1], TcpOptionsSupported: [2-3], TcpChecksum: [4-5], UdpChecksum: [6-7], IpChecksum: [8-9]
        uint _bitfield0;
    }
    struct IPv4Receive
    {
        uint Encapsulation;
        // Native bit field: IpOptionsSupported: [0-1], TcpOptionsSupported: [2-3], TcpChecksum: [4-5], UdpChecksum: [6-7], IpChecksum: [8-9]
        uint _bitfield1;
    }
    struct IPv6Transmit
    {
        uint Encapsulation;
        // Native bit field: IpExtensionHeadersSupported: [0-1], TcpOptionsSupported: [2-3], TcpChecksum: [4-5], UdpChecksum: [6-7]
        uint _bitfield2;
    }
    struct IPv6Receive
    {
        uint Encapsulation;
        // Native bit field: IpExtensionHeadersSupported: [0-1], TcpOptionsSupported: [2-3], TcpChecksum: [4-5], UdpChecksum: [6-7]
        uint _bitfield3;
    }
}

struct NDIS_IPSEC_OFFLOAD_V1
{
    struct Supported
    {
        uint Encapsulation;
        uint AhEspCombined;
        uint TransportTunnelCombined;
        uint IPv4Options;
        uint Flags;
    }
    struct IPv4AH
    {
        // Native bit field: Md5: [0-1], Sha_1: [2-3], Transport: [4-5], Tunnel: [6-7], Send: [8-9], Receive: [10-11]
        uint _bitfield0;
    }
    struct IPv4ESP
    {
        // Native bit field: Des: [0-1], Reserved: [2-3], TripleDes: [4-5], NullEsp: [6-7], Transport: [8-9], Tunnel: [10-11], Send: [12-13], Receive: [14-15]
        uint _bitfield1;
    }
}

struct NDIS_TCP_LARGE_SEND_OFFLOAD_V2
{
    struct IPv4
    {
        uint Encapsulation;
        uint MaxOffLoadSize;
        uint MinSegmentCount;
    }
    struct IPv6
    {
        uint Encapsulation;
        uint MaxOffLoadSize;
        uint MinSegmentCount;
        // Native bit field: IpExtensionHeadersSupported: [0-1], TcpOptionsSupported: [2-3]
        uint _bitfield0;
    }
}

struct NDIS_OFFLOAD
{
    NDIS_OBJECT_HEADER Header;
    NDIS_TCP_IP_CHECKSUM_OFFLOAD Checksum;
    NDIS_TCP_LARGE_SEND_OFFLOAD_V1 LsoV1;
    NDIS_IPSEC_OFFLOAD_V1 IPsecV1;
    NDIS_TCP_LARGE_SEND_OFFLOAD_V2 LsoV2;
    uint               Flags;
}

struct NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V1
{
    struct IPv4
    {
        uint Encapsulation;
        uint MaxOffLoadSize;
        uint MinSegmentCount;
        uint TcpOptions;
        uint IpOptions;
    }
}

struct NDIS_WMI_TCP_IP_CHECKSUM_OFFLOAD
{
    struct IPv4Transmit
    {
        uint Encapsulation;
        uint IpOptionsSupported;
        uint TcpOptionsSupported;
        uint TcpChecksum;
        uint UdpChecksum;
        uint IpChecksum;
    }
    struct IPv4Receive
    {
        uint Encapsulation;
        uint IpOptionsSupported;
        uint TcpOptionsSupported;
        uint TcpChecksum;
        uint UdpChecksum;
        uint IpChecksum;
    }
    struct IPv6Transmit
    {
        uint Encapsulation;
        uint IpExtensionHeadersSupported;
        uint TcpOptionsSupported;
        uint TcpChecksum;
        uint UdpChecksum;
    }
    struct IPv6Receive
    {
        uint Encapsulation;
        uint IpExtensionHeadersSupported;
        uint TcpOptionsSupported;
        uint TcpChecksum;
        uint UdpChecksum;
    }
}

struct NDIS_WMI_IPSEC_OFFLOAD_V1
{
    struct Supported
    {
        uint Encapsulation;
        uint AhEspCombined;
        uint TransportTunnelCombined;
        uint IPv4Options;
        uint Flags;
    }
    struct IPv4AH
    {
        uint Md5;
        uint Sha_1;
        uint Transport;
        uint Tunnel;
        uint Send;
        uint Receive;
    }
    struct IPv4ESP
    {
        uint Des;
        uint Reserved;
        uint TripleDes;
        uint NullEsp;
        uint Transport;
        uint Tunnel;
        uint Send;
        uint Receive;
    }
}

struct NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V2
{
    struct IPv4
    {
        uint Encapsulation;
        uint MaxOffLoadSize;
        uint MinSegmentCount;
    }
    struct IPv6
    {
        uint Encapsulation;
        uint MaxOffLoadSize;
        uint MinSegmentCount;
        uint IpExtensionHeadersSupported;
        uint TcpOptionsSupported;
    }
}

struct NDIS_WMI_OFFLOAD
{
    NDIS_OBJECT_HEADER Header;
    NDIS_WMI_TCP_IP_CHECKSUM_OFFLOAD Checksum;
    NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V1 LsoV1;
    NDIS_WMI_IPSEC_OFFLOAD_V1 IPsecV1;
    NDIS_WMI_TCP_LARGE_SEND_OFFLOAD_V2 LsoV2;
    uint               Flags;
}

struct NDIS_TCP_CONNECTION_OFFLOAD
{
    NDIS_OBJECT_HEADER Header;
    uint               Encapsulation;
    // Native bit field: SupportIPv4: [0-1], SupportIPv6: [2-3], SupportIPv6ExtensionHeaders: [4-5], SupportSack: [6-7]
    uint               _bitfield0;
    uint               TcpConnectionOffloadCapacity;
    uint               Flags;
}

struct NDIS_WMI_TCP_CONNECTION_OFFLOAD
{
    NDIS_OBJECT_HEADER Header;
    uint               Encapsulation;
    uint               SupportIPv4;
    uint               SupportIPv6;
    uint               SupportIPv6ExtensionHeaders;
    uint               SupportSack;
    uint               TcpConnectionOffloadCapacity;
    uint               Flags;
}

struct NDIS_PORT_AUTHENTICATION_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    NDIS_PORT_CONTROL_STATE SendControlState;
    NDIS_PORT_CONTROL_STATE RcvControlState;
    NDIS_PORT_AUTHORIZATION_STATE SendAuthorizationState;
    NDIS_PORT_AUTHORIZATION_STATE RcvAuthorizationState;
}

struct NDIS_WMI_METHOD_HEADER
{
    NDIS_OBJECT_HEADER Header;
    uint               PortNumber;
    NET_LUID_LH        NetLuid;
    ulong              RequestId;
    uint               Timeout;
    ubyte[4]           Padding;
}

struct NDIS_WMI_SET_HEADER
{
    NDIS_OBJECT_HEADER Header;
    uint               PortNumber;
    NET_LUID_LH        NetLuid;
    ulong              RequestId;
    uint               Timeout;
    ubyte[4]           Padding;
}

struct NDIS_WMI_EVENT_HEADER
{
    NDIS_OBJECT_HEADER Header;
    uint               IfIndex;
    NET_LUID_LH        NetLuid;
    ulong              RequestId;
    uint               PortNumber;
    uint               DeviceNameLength;
    uint               DeviceNameOffset;
    ubyte[4]           Padding;
}

struct NDIS_WMI_ENUM_ADAPTER
{
    NDIS_OBJECT_HEADER Header;
    uint               IfIndex;
    NET_LUID_LH        NetLuid;
    ushort             DeviceNameLength;
    CHAR[1]            DeviceName; // Flexible array
}

struct NDIS_WMI_OUTPUT_INFO
{
    NDIS_OBJECT_HEADER Header;
    uint               Flags;
    ubyte              SupportedRevision;
    uint               DataOffset;
}

struct NDIS_RECEIVE_SCALE_CAPABILITIES
{
    NDIS_OBJECT_HEADER Header;
    uint               CapabilitiesFlags;
    uint               NumberOfInterruptMessages;
    uint               NumberOfReceiveQueues;
}

struct NDIS_RECEIVE_SCALE_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    ushort             Flags;
    ushort             BaseCpuNumber;
    uint               HashInformation;
    ushort             IndirectionTableSize;
    uint               IndirectionTableOffset;
    ushort             HashSecretKeySize;
    uint               HashSecretKeyOffset;
}

struct NDIS_RECEIVE_HASH_PARAMETERS
{
    NDIS_OBJECT_HEADER Header;
    uint               Flags;
    uint               HashInformation;
    ushort             HashSecretKeySize;
    uint               HashSecretKeyOffset;
}

struct NDIS_PORT_STATE
{
    NDIS_OBJECT_HEADER Header;
    NET_IF_MEDIA_CONNECT_STATE MediaConnectState;
    ulong              XmitLinkSpeed;
    ulong              RcvLinkSpeed;
    NET_IF_DIRECTION_TYPE Direction;
    NDIS_PORT_CONTROL_STATE SendControlState;
    NDIS_PORT_CONTROL_STATE RcvControlState;
    NDIS_PORT_AUTHORIZATION_STATE SendAuthorizationState;
    NDIS_PORT_AUTHORIZATION_STATE RcvAuthorizationState;
    uint               Flags;
}

struct NDIS_PORT_CHARACTERISTICS
{
    NDIS_OBJECT_HEADER Header;
    uint               PortNumber;
    uint               Flags;
    NDIS_PORT_TYPE     Type;
    NET_IF_MEDIA_CONNECT_STATE MediaConnectState;
    ulong              XmitLinkSpeed;
    ulong              RcvLinkSpeed;
    NET_IF_DIRECTION_TYPE Direction;
    NDIS_PORT_CONTROL_STATE SendControlState;
    NDIS_PORT_CONTROL_STATE RcvControlState;
    NDIS_PORT_AUTHORIZATION_STATE SendAuthorizationState;
    NDIS_PORT_AUTHORIZATION_STATE RcvAuthorizationState;
}

struct NDIS_PORT
{
    NDIS_PORT* Next;
    void*      NdisReserved;
    void*      MiniportReserved;
    void*      ProtocolReserved;
    NDIS_PORT_CHARACTERISTICS PortCharacteristics;
}

struct NDIS_PORT_ARRAY
{
    NDIS_OBJECT_HEADER Header;
    uint               NumberOfPorts;
    uint               OffsetFirstPort;
    uint               ElementSize;
    NDIS_PORT_CHARACTERISTICS[1] Ports; // Flexible array
}

struct NDIS_TIMESTAMP_CAPABILITY_FLAGS
{
    BOOLEAN PtpV2OverUdpIPv4EventMsgReceiveHw;
    BOOLEAN PtpV2OverUdpIPv4AllMsgReceiveHw;
    BOOLEAN PtpV2OverUdpIPv4EventMsgTransmitHw;
    BOOLEAN PtpV2OverUdpIPv4AllMsgTransmitHw;
    BOOLEAN PtpV2OverUdpIPv6EventMsgReceiveHw;
    BOOLEAN PtpV2OverUdpIPv6AllMsgReceiveHw;
    BOOLEAN PtpV2OverUdpIPv6EventMsgTransmitHw;
    BOOLEAN PtpV2OverUdpIPv6AllMsgTransmitHw;
    BOOLEAN AllReceiveHw;
    BOOLEAN AllTransmitHw;
    BOOLEAN TaggedTransmitHw;
    BOOLEAN AllReceiveSw;
    BOOLEAN AllTransmitSw;
    BOOLEAN TaggedTransmitSw;
}

struct NDIS_TIMESTAMP_CAPABILITIES
{
    NDIS_OBJECT_HEADER Header;
    ulong              HardwareClockFrequencyHz;
    BOOLEAN            CrossTimestamp;
    ulong              Reserved1;
    ulong              Reserved2;
    NDIS_TIMESTAMP_CAPABILITY_FLAGS TimestampFlags;
}

struct NDIS_HARDWARE_CROSSTIMESTAMP
{
    NDIS_OBJECT_HEADER Header;
    uint               Flags;
    ulong              SystemTimestamp1;
    ulong              HardwareClockTimestamp;
    ulong              SystemTimestamp2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ndkinfo/ns-ndkinfo-ndk_version
struct NDK_VERSION
{
    ushort Major;
    ushort Minor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ndkinfo/ns-ndkinfo-ndk_adapter_info
struct NDK_ADAPTER_INFO
{
    NDK_VERSION         Version;
    uint                VendorId;
    uint                DeviceId;
    size_t              MaxRegistrationSize;
    size_t              MaxWindowSize;
    uint                FRMRPageCount;
    uint                MaxInitiatorRequestSge;
    uint                MaxReceiveRequestSge;
    uint                MaxReadRequestSge;
    uint                MaxTransferLength;
    uint                MaxInlineDataSize;
    uint                MaxInboundReadLimit;
    uint                MaxOutboundReadLimit;
    uint                MaxReceiveQueueDepth;
    uint                MaxInitiatorQueueDepth;
    uint                MaxSrqDepth;
    uint                MaxCqDepth;
    uint                LargeRequestThreshold;
    uint                MaxCallerData;
    uint                MaxCalleeData;
    uint                AdapterFlags;
    NDK_RDMA_TECHNOLOGY RdmaTechnology;
}

