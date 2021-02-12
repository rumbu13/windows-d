module windows.networkdrivers;

public import system;
public import windows.systemservices;
public import windows.winsock;

extern(Windows):

struct L2_NOTIFICATION_DATA
{
    uint NotificationSource;
    uint NotificationCode;
    Guid InterfaceGuid;
    uint dwDataSize;
    void* pData;
}

enum NET_IF_OPER_STATUS
{
    NET_IF_OPER_STATUS_UP = 1,
    NET_IF_OPER_STATUS_DOWN = 2,
    NET_IF_OPER_STATUS_TESTING = 3,
    NET_IF_OPER_STATUS_UNKNOWN = 4,
    NET_IF_OPER_STATUS_DORMANT = 5,
    NET_IF_OPER_STATUS_NOT_PRESENT = 6,
    NET_IF_OPER_STATUS_LOWER_LAYER_DOWN = 7,
}

enum NET_IF_ADMIN_STATUS
{
    NET_IF_ADMIN_STATUS_UP = 1,
    NET_IF_ADMIN_STATUS_DOWN = 2,
    NET_IF_ADMIN_STATUS_TESTING = 3,
}

enum NET_IF_CONNECTION_TYPE
{
    NET_IF_CONNECTION_DEDICATED = 1,
    NET_IF_CONNECTION_PASSIVE = 2,
    NET_IF_CONNECTION_DEMAND = 3,
    NET_IF_CONNECTION_MAXIMUM = 4,
}

enum TUNNEL_TYPE
{
    TUNNEL_TYPE_NONE = 0,
    TUNNEL_TYPE_OTHER = 1,
    TUNNEL_TYPE_DIRECT = 2,
    TUNNEL_TYPE_6TO4 = 11,
    TUNNEL_TYPE_ISATAP = 13,
    TUNNEL_TYPE_TEREDO = 14,
    TUNNEL_TYPE_IPHTTPS = 15,
}

enum NET_IF_ACCESS_TYPE
{
    NET_IF_ACCESS_LOOPBACK = 1,
    NET_IF_ACCESS_BROADCAST = 2,
    NET_IF_ACCESS_POINT_TO_POINT = 3,
    NET_IF_ACCESS_POINT_TO_MULTI_POINT = 4,
    NET_IF_ACCESS_MAXIMUM = 5,
}

enum NET_IF_DIRECTION_TYPE
{
    NET_IF_DIRECTION_SENDRECEIVE = 0,
    NET_IF_DIRECTION_SENDONLY = 1,
    NET_IF_DIRECTION_RECEIVEONLY = 2,
    NET_IF_DIRECTION_MAXIMUM = 3,
}

enum NET_IF_MEDIA_CONNECT_STATE
{
    MediaConnectStateUnknown = 0,
    MediaConnectStateConnected = 1,
    MediaConnectStateDisconnected = 2,
}

enum NET_IF_MEDIA_DUPLEX_STATE
{
    MediaDuplexStateUnknown = 0,
    MediaDuplexStateHalf = 1,
    MediaDuplexStateFull = 2,
}

struct NET_PHYSICAL_LOCATION_LH
{
    uint BusNumber;
    uint SlotNumber;
    uint FunctionNumber;
}

struct IF_COUNTED_STRING_LH
{
    ushort Length;
    ushort String;
}

struct NDIS_INTERFACE_INFORMATION
{
    NET_IF_OPER_STATUS ifOperStatus;
    uint ifOperStatusFlags;
    NET_IF_MEDIA_CONNECT_STATE MediaConnectState;
    NET_IF_MEDIA_DUPLEX_STATE MediaDuplexState;
    uint ifMtu;
    ubyte ifPromiscuousMode;
    ubyte ifDeviceWakeUpEnable;
    ulong XmitLinkSpeed;
    ulong RcvLinkSpeed;
    ulong ifLastChange;
    ulong ifCounterDiscontinuityTime;
    ulong ifInUnknownProtos;
    ulong ifInDiscards;
    ulong ifInErrors;
    ulong ifHCInOctets;
    ulong ifHCInUcastPkts;
    ulong ifHCInMulticastPkts;
    ulong ifHCInBroadcastPkts;
    ulong ifHCOutOctets;
    ulong ifHCOutUcastPkts;
    ulong ifHCOutMulticastPkts;
    ulong ifHCOutBroadcastPkts;
    ulong ifOutErrors;
    ulong ifOutDiscards;
    ulong ifHCInUcastOctets;
    ulong ifHCInMulticastOctets;
    ulong ifHCInBroadcastOctets;
    ulong ifHCOutUcastOctets;
    ulong ifHCOutMulticastOctets;
    ulong ifHCOutBroadcastOctets;
    uint CompartmentId;
    uint SupportedStatistics;
}

enum MIB_IF_TABLE_LEVEL
{
    MibIfTableNormal = 0,
    MibIfTableRaw = 1,
    MibIfTableNormalWithoutStatistics = 2,
}

@DllImport("IPHLPAPI.dll")
uint GetCurrentThreadCompartmentId();

@DllImport("IPHLPAPI.dll")
NTSTATUS SetCurrentThreadCompartmentId(uint CompartmentId);

@DllImport("IPHLPAPI.dll")
uint GetSessionCompartmentId(uint SessionId);

@DllImport("IPHLPAPI.dll")
NTSTATUS SetSessionCompartmentId(uint SessionId, uint CompartmentId);

@DllImport("IPHLPAPI.dll")
NTSTATUS GetNetworkInformation(const(Guid)* NetworkGuid, uint* CompartmentId, uint* SiteId, const(wchar)* NetworkName, uint Length);

@DllImport("IPHLPAPI.dll")
NTSTATUS SetNetworkInformation(const(Guid)* NetworkGuid, uint CompartmentId, const(wchar)* NetworkName);

struct SOCKET_ADDRESS_LIST
{
    int iAddressCount;
    SOCKET_ADDRESS Address;
}

struct SOCKADDR_STORAGE_LH
{
    ushort ss_family;
    byte __ss_pad1;
    long __ss_align;
    byte __ss_pad2;
}

struct SOCKADDR_IN6_LH
{
    ushort sin6_family;
    ushort sin6_port;
    uint sin6_flowinfo;
    in6_addr sin6_addr;
    _Anonymous_e__Union Anonymous;
}

enum NL_ROUTE_PROTOCOL
{
    RouteProtocolOther = 1,
    RouteProtocolLocal = 2,
    RouteProtocolNetMgmt = 3,
    RouteProtocolIcmp = 4,
    RouteProtocolEgp = 5,
    RouteProtocolGgp = 6,
    RouteProtocolHello = 7,
    RouteProtocolRip = 8,
    RouteProtocolIsIs = 9,
    RouteProtocolEsIs = 10,
    RouteProtocolCisco = 11,
    RouteProtocolBbn = 12,
    RouteProtocolOspf = 13,
    RouteProtocolBgp = 14,
    RouteProtocolIdpr = 15,
    RouteProtocolEigrp = 16,
    RouteProtocolDvmrp = 17,
    RouteProtocolRpl = 18,
    RouteProtocolDhcp = 19,
    MIB_IPPROTO_OTHER = 1,
    PROTO_IP_OTHER = 1,
    MIB_IPPROTO_LOCAL = 2,
    PROTO_IP_LOCAL = 2,
    MIB_IPPROTO_NETMGMT = 3,
    PROTO_IP_NETMGMT = 3,
    MIB_IPPROTO_ICMP = 4,
    PROTO_IP_ICMP = 4,
    MIB_IPPROTO_EGP = 5,
    PROTO_IP_EGP = 5,
    MIB_IPPROTO_GGP = 6,
    PROTO_IP_GGP = 6,
    MIB_IPPROTO_HELLO = 7,
    PROTO_IP_HELLO = 7,
    MIB_IPPROTO_RIP = 8,
    PROTO_IP_RIP = 8,
    MIB_IPPROTO_IS_IS = 9,
    PROTO_IP_IS_IS = 9,
    MIB_IPPROTO_ES_IS = 10,
    PROTO_IP_ES_IS = 10,
    MIB_IPPROTO_CISCO = 11,
    PROTO_IP_CISCO = 11,
    MIB_IPPROTO_BBN = 12,
    PROTO_IP_BBN = 12,
    MIB_IPPROTO_OSPF = 13,
    PROTO_IP_OSPF = 13,
    MIB_IPPROTO_BGP = 14,
    PROTO_IP_BGP = 14,
    MIB_IPPROTO_IDPR = 15,
    PROTO_IP_IDPR = 15,
    MIB_IPPROTO_EIGRP = 16,
    PROTO_IP_EIGRP = 16,
    MIB_IPPROTO_DVMRP = 17,
    PROTO_IP_DVMRP = 17,
    MIB_IPPROTO_RPL = 18,
    PROTO_IP_RPL = 18,
    MIB_IPPROTO_DHCP = 19,
    PROTO_IP_DHCP = 19,
    MIB_IPPROTO_NT_AUTOSTATIC = 10002,
    PROTO_IP_NT_AUTOSTATIC = 10002,
    MIB_IPPROTO_NT_STATIC = 10006,
    PROTO_IP_NT_STATIC = 10006,
    MIB_IPPROTO_NT_STATIC_NON_DOD = 10007,
    PROTO_IP_NT_STATIC_NON_DOD = 10007,
}

enum NL_ADDRESS_TYPE
{
    NlatUnspecified = 0,
    NlatUnicast = 1,
    NlatAnycast = 2,
    NlatMulticast = 3,
    NlatBroadcast = 4,
    NlatInvalid = 5,
}

enum NL_ROUTE_ORIGIN
{
    NlroManual = 0,
    NlroWellKnown = 1,
    NlroDHCP = 2,
    NlroRouterAdvertisement = 3,
    Nlro6to4 = 4,
}

enum NL_NEIGHBOR_STATE
{
    NlnsUnreachable = 0,
    NlnsIncomplete = 1,
    NlnsProbe = 2,
    NlnsDelay = 3,
    NlnsStale = 4,
    NlnsReachable = 5,
    NlnsPermanent = 6,
    NlnsMaximum = 7,
}

enum NL_LINK_LOCAL_ADDRESS_BEHAVIOR
{
    LinkLocalAlwaysOff = 0,
    LinkLocalDelayed = 1,
    LinkLocalAlwaysOn = 2,
    LinkLocalUnchanged = -1,
}

enum NL_ROUTER_DISCOVERY_BEHAVIOR
{
    RouterDiscoveryDisabled = 0,
    RouterDiscoveryEnabled = 1,
    RouterDiscoveryDhcp = 2,
    RouterDiscoveryUnchanged = -1,
}

