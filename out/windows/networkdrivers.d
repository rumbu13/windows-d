module windows.networkdrivers;

public import windows.core;
public import windows.systemservices : NTSTATUS;
public import windows.winsock : SCOPE_ID, SOCKET_ADDRESS, in6_addr;

extern(Windows):


// Enums


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
alias NET_IF_OPER_STATUS = int;

enum : int
{
    NET_IF_ADMIN_STATUS_UP      = 0x00000001,
    NET_IF_ADMIN_STATUS_DOWN    = 0x00000002,
    NET_IF_ADMIN_STATUS_TESTING = 0x00000003,
}
alias NET_IF_ADMIN_STATUS = int;

enum : int
{
    NET_IF_CONNECTION_DEDICATED = 0x00000001,
    NET_IF_CONNECTION_PASSIVE   = 0x00000002,
    NET_IF_CONNECTION_DEMAND    = 0x00000003,
    NET_IF_CONNECTION_MAXIMUM   = 0x00000004,
}
alias NET_IF_CONNECTION_TYPE = int;

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
alias TUNNEL_TYPE = int;

enum : int
{
    NET_IF_ACCESS_LOOPBACK             = 0x00000001,
    NET_IF_ACCESS_BROADCAST            = 0x00000002,
    NET_IF_ACCESS_POINT_TO_POINT       = 0x00000003,
    NET_IF_ACCESS_POINT_TO_MULTI_POINT = 0x00000004,
    NET_IF_ACCESS_MAXIMUM              = 0x00000005,
}
alias NET_IF_ACCESS_TYPE = int;

enum : int
{
    NET_IF_DIRECTION_SENDRECEIVE = 0x00000000,
    NET_IF_DIRECTION_SENDONLY    = 0x00000001,
    NET_IF_DIRECTION_RECEIVEONLY = 0x00000002,
    NET_IF_DIRECTION_MAXIMUM     = 0x00000003,
}
alias NET_IF_DIRECTION_TYPE = int;

enum : int
{
    MediaConnectStateUnknown      = 0x00000000,
    MediaConnectStateConnected    = 0x00000001,
    MediaConnectStateDisconnected = 0x00000002,
}
alias NET_IF_MEDIA_CONNECT_STATE = int;

enum : int
{
    MediaDuplexStateUnknown = 0x00000000,
    MediaDuplexStateHalf    = 0x00000001,
    MediaDuplexStateFull    = 0x00000002,
}
alias NET_IF_MEDIA_DUPLEX_STATE = int;

enum : int
{
    MibIfTableNormal                  = 0x00000000,
    MibIfTableRaw                     = 0x00000001,
    MibIfTableNormalWithoutStatistics = 0x00000002,
}
alias MIB_IF_TABLE_LEVEL = int;

enum : int
{
    RouteProtocolOther            = 0x00000001,
    RouteProtocolLocal            = 0x00000002,
    RouteProtocolNetMgmt          = 0x00000003,
    RouteProtocolIcmp             = 0x00000004,
    RouteProtocolEgp              = 0x00000005,
    RouteProtocolGgp              = 0x00000006,
    RouteProtocolHello            = 0x00000007,
    RouteProtocolRip              = 0x00000008,
    RouteProtocolIsIs             = 0x00000009,
    RouteProtocolEsIs             = 0x0000000a,
    RouteProtocolCisco            = 0x0000000b,
    RouteProtocolBbn              = 0x0000000c,
    RouteProtocolOspf             = 0x0000000d,
    RouteProtocolBgp              = 0x0000000e,
    RouteProtocolIdpr             = 0x0000000f,
    RouteProtocolEigrp            = 0x00000010,
    RouteProtocolDvmrp            = 0x00000011,
    RouteProtocolRpl              = 0x00000012,
    RouteProtocolDhcp             = 0x00000013,
    MIB_IPPROTO_OTHER             = 0x00000001,
    PROTO_IP_OTHER                = 0x00000001,
    MIB_IPPROTO_LOCAL             = 0x00000002,
    PROTO_IP_LOCAL                = 0x00000002,
    MIB_IPPROTO_NETMGMT           = 0x00000003,
    PROTO_IP_NETMGMT              = 0x00000003,
    MIB_IPPROTO_ICMP              = 0x00000004,
    PROTO_IP_ICMP                 = 0x00000004,
    MIB_IPPROTO_EGP               = 0x00000005,
    PROTO_IP_EGP                  = 0x00000005,
    MIB_IPPROTO_GGP               = 0x00000006,
    PROTO_IP_GGP                  = 0x00000006,
    MIB_IPPROTO_HELLO             = 0x00000007,
    PROTO_IP_HELLO                = 0x00000007,
    MIB_IPPROTO_RIP               = 0x00000008,
    PROTO_IP_RIP                  = 0x00000008,
    MIB_IPPROTO_IS_IS             = 0x00000009,
    PROTO_IP_IS_IS                = 0x00000009,
    MIB_IPPROTO_ES_IS             = 0x0000000a,
    PROTO_IP_ES_IS                = 0x0000000a,
    MIB_IPPROTO_CISCO             = 0x0000000b,
    PROTO_IP_CISCO                = 0x0000000b,
    MIB_IPPROTO_BBN               = 0x0000000c,
    PROTO_IP_BBN                  = 0x0000000c,
    MIB_IPPROTO_OSPF              = 0x0000000d,
    PROTO_IP_OSPF                 = 0x0000000d,
    MIB_IPPROTO_BGP               = 0x0000000e,
    PROTO_IP_BGP                  = 0x0000000e,
    MIB_IPPROTO_IDPR              = 0x0000000f,
    PROTO_IP_IDPR                 = 0x0000000f,
    MIB_IPPROTO_EIGRP             = 0x00000010,
    PROTO_IP_EIGRP                = 0x00000010,
    MIB_IPPROTO_DVMRP             = 0x00000011,
    PROTO_IP_DVMRP                = 0x00000011,
    MIB_IPPROTO_RPL               = 0x00000012,
    PROTO_IP_RPL                  = 0x00000012,
    MIB_IPPROTO_DHCP              = 0x00000013,
    PROTO_IP_DHCP                 = 0x00000013,
    MIB_IPPROTO_NT_AUTOSTATIC     = 0x00002712,
    PROTO_IP_NT_AUTOSTATIC        = 0x00002712,
    MIB_IPPROTO_NT_STATIC         = 0x00002716,
    PROTO_IP_NT_STATIC            = 0x00002716,
    MIB_IPPROTO_NT_STATIC_NON_DOD = 0x00002717,
    PROTO_IP_NT_STATIC_NON_DOD    = 0x00002717,
}
alias NL_ROUTE_PROTOCOL = int;

enum : int
{
    NlatUnspecified = 0x00000000,
    NlatUnicast     = 0x00000001,
    NlatAnycast     = 0x00000002,
    NlatMulticast   = 0x00000003,
    NlatBroadcast   = 0x00000004,
    NlatInvalid     = 0x00000005,
}
alias NL_ADDRESS_TYPE = int;

enum : int
{
    NlroManual              = 0x00000000,
    NlroWellKnown           = 0x00000001,
    NlroDHCP                = 0x00000002,
    NlroRouterAdvertisement = 0x00000003,
    Nlro6to4                = 0x00000004,
}
alias NL_ROUTE_ORIGIN = int;

enum : int
{
    NlnsUnreachable = 0x00000000,
    NlnsIncomplete  = 0x00000001,
    NlnsProbe       = 0x00000002,
    NlnsDelay       = 0x00000003,
    NlnsStale       = 0x00000004,
    NlnsReachable   = 0x00000005,
    NlnsPermanent   = 0x00000006,
    NlnsMaximum     = 0x00000007,
}
alias NL_NEIGHBOR_STATE = int;

enum : int
{
    LinkLocalAlwaysOff = 0x00000000,
    LinkLocalDelayed   = 0x00000001,
    LinkLocalAlwaysOn  = 0x00000002,
    LinkLocalUnchanged = 0xffffffff,
}
alias NL_LINK_LOCAL_ADDRESS_BEHAVIOR = int;

enum : int
{
    RouterDiscoveryDisabled  = 0x00000000,
    RouterDiscoveryEnabled   = 0x00000001,
    RouterDiscoveryDhcp      = 0x00000002,
    RouterDiscoveryUnchanged = 0xffffffff,
}
alias NL_ROUTER_DISCOVERY_BEHAVIOR = int;

// Structs


struct L2_NOTIFICATION_DATA
{
    uint  NotificationSource;
    uint  NotificationCode;
    GUID  InterfaceGuid;
    uint  dwDataSize;
    void* pData;
}

struct NET_PHYSICAL_LOCATION_LH
{
    uint BusNumber;
    uint SlotNumber;
    uint FunctionNumber;
}

struct IF_COUNTED_STRING_LH
{
    ushort      Length;
    ushort[257] String;
}

struct NDIS_INTERFACE_INFORMATION
{
    NET_IF_OPER_STATUS ifOperStatus;
    uint               ifOperStatusFlags;
    NET_IF_MEDIA_CONNECT_STATE MediaConnectState;
    NET_IF_MEDIA_DUPLEX_STATE MediaDuplexState;
    uint               ifMtu;
    ubyte              ifPromiscuousMode;
    ubyte              ifDeviceWakeUpEnable;
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
    uint               CompartmentId;
    uint               SupportedStatistics;
}

struct SOCKET_ADDRESS_LIST
{
    int               iAddressCount;
    SOCKET_ADDRESS[1] Address;
}

struct SOCKADDR_STORAGE_LH
{
    ushort    ss_family;
    byte[6]   __ss_pad1;
    long      __ss_align;
    byte[112] __ss_pad2;
}

struct SOCKADDR_IN6_LH
{
    ushort   sin6_family;
    ushort   sin6_port;
    uint     sin6_flowinfo;
    in6_addr sin6_addr;
    union
    {
        uint     sin6_scope_id;
        SCOPE_ID sin6_scope_struct;
    }
}

// Functions

@DllImport("IPHLPAPI")
uint GetCurrentThreadCompartmentId();

@DllImport("IPHLPAPI")
NTSTATUS SetCurrentThreadCompartmentId(uint CompartmentId);

@DllImport("IPHLPAPI")
uint GetSessionCompartmentId(uint SessionId);

@DllImport("IPHLPAPI")
NTSTATUS SetSessionCompartmentId(uint SessionId, uint CompartmentId);

@DllImport("IPHLPAPI")
NTSTATUS GetNetworkInformation(const(GUID)* NetworkGuid, uint* CompartmentId, uint* SiteId, 
                               const(wchar)* NetworkName, uint Length);

@DllImport("IPHLPAPI")
NTSTATUS SetNetworkInformation(const(GUID)* NetworkGuid, uint CompartmentId, const(wchar)* NetworkName);


