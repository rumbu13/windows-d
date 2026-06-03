// Written in the D programming language.

module windows.win32.networking.winsock;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, CHAR, FARPROC, HANDLE, HRESULT,
                                         HWND, LPARAM, LUID, PSTR, PWSTR, WAIT_EVENT,
                                         WPARAM;
public import windows.win32.system.com : BLOB;
public import windows.win32.system.io : OVERLAPPED, OVERLAPPED_ENTRY;
public import windows.win32.system.kernel : COMPARTMENT_ID, PROCESSOR_NUMBER;

extern(Windows) @nogc nothrow:


// Enums


alias WSA_ERROR = int;
enum : int
{
    WSA_IO_PENDING              = 0x000003e5,
    WSA_IO_INCOMPLETE           = 0x000003e4,
    WSA_INVALID_HANDLE          = 0x00000006,
    WSA_INVALID_PARAMETER       = 0x00000057,
    WSA_NOT_ENOUGH_MEMORY       = 0x00000008,
    WSA_OPERATION_ABORTED       = 0x000003e3,
    WSA_WAIT_EVENT_0            = 0x00000000,
    WSA_WAIT_IO_COMPLETION      = 0x000000c0,
    WSABASEERR                  = 0x00002710,
    WSAEINTR                    = 0x00002714,
    WSAEBADF                    = 0x00002719,
    WSAEACCES                   = 0x0000271d,
    WSAEFAULT                   = 0x0000271e,
    WSAEINVAL                   = 0x00002726,
    WSAEMFILE                   = 0x00002728,
    WSAEWOULDBLOCK              = 0x00002733,
    WSAEINPROGRESS              = 0x00002734,
    WSAEALREADY                 = 0x00002735,
    WSAENOTSOCK                 = 0x00002736,
    WSAEDESTADDRREQ             = 0x00002737,
    WSAEMSGSIZE                 = 0x00002738,
    WSAEPROTOTYPE               = 0x00002739,
    WSAENOPROTOOPT              = 0x0000273a,
    WSAEPROTONOSUPPORT          = 0x0000273b,
    WSAESOCKTNOSUPPORT          = 0x0000273c,
    WSAEOPNOTSUPP               = 0x0000273d,
    WSAEPFNOSUPPORT             = 0x0000273e,
    WSAEAFNOSUPPORT             = 0x0000273f,
    WSAEADDRINUSE               = 0x00002740,
    WSAEADDRNOTAVAIL            = 0x00002741,
    WSAENETDOWN                 = 0x00002742,
    WSAENETUNREACH              = 0x00002743,
    WSAENETRESET                = 0x00002744,
    WSAECONNABORTED             = 0x00002745,
    WSAECONNRESET               = 0x00002746,
    WSAENOBUFS                  = 0x00002747,
    WSAEISCONN                  = 0x00002748,
    WSAENOTCONN                 = 0x00002749,
    WSAESHUTDOWN                = 0x0000274a,
    WSAETOOMANYREFS             = 0x0000274b,
    WSAETIMEDOUT                = 0x0000274c,
    WSAECONNREFUSED             = 0x0000274d,
    WSAELOOP                    = 0x0000274e,
    WSAENAMETOOLONG             = 0x0000274f,
    WSAEHOSTDOWN                = 0x00002750,
    WSAEHOSTUNREACH             = 0x00002751,
    WSAENOTEMPTY                = 0x00002752,
    WSAEPROCLIM                 = 0x00002753,
    WSAEUSERS                   = 0x00002754,
    WSAEDQUOT                   = 0x00002755,
    WSAESTALE                   = 0x00002756,
    WSAEREMOTE                  = 0x00002757,
    WSASYSNOTREADY              = 0x0000276b,
    WSAVERNOTSUPPORTED          = 0x0000276c,
    WSANOTINITIALISED           = 0x0000276d,
    WSAEDISCON                  = 0x00002775,
    WSAENOMORE                  = 0x00002776,
    WSAECANCELLED               = 0x00002777,
    WSAEINVALIDPROCTABLE        = 0x00002778,
    WSAEINVALIDPROVIDER         = 0x00002779,
    WSAEPROVIDERFAILEDINIT      = 0x0000277a,
    WSASYSCALLFAILURE           = 0x0000277b,
    WSASERVICE_NOT_FOUND        = 0x0000277c,
    WSATYPE_NOT_FOUND           = 0x0000277d,
    WSA_E_NO_MORE               = 0x0000277e,
    WSA_E_CANCELLED             = 0x0000277f,
    WSAEREFUSED                 = 0x00002780,
    WSAHOST_NOT_FOUND           = 0x00002af9,
    WSATRY_AGAIN                = 0x00002afa,
    WSANO_RECOVERY              = 0x00002afb,
    WSANO_DATA                  = 0x00002afc,
    WSA_QOS_RECEIVERS           = 0x00002afd,
    WSA_QOS_SENDERS             = 0x00002afe,
    WSA_QOS_NO_SENDERS          = 0x00002aff,
    WSA_QOS_NO_RECEIVERS        = 0x00002b00,
    WSA_QOS_REQUEST_CONFIRMED   = 0x00002b01,
    WSA_QOS_ADMISSION_FAILURE   = 0x00002b02,
    WSA_QOS_POLICY_FAILURE      = 0x00002b03,
    WSA_QOS_BAD_STYLE           = 0x00002b04,
    WSA_QOS_BAD_OBJECT          = 0x00002b05,
    WSA_QOS_TRAFFIC_CTRL_ERROR  = 0x00002b06,
    WSA_QOS_GENERIC_ERROR       = 0x00002b07,
    WSA_QOS_ESERVICETYPE        = 0x00002b08,
    WSA_QOS_EFLOWSPEC           = 0x00002b09,
    WSA_QOS_EPROVSPECBUF        = 0x00002b0a,
    WSA_QOS_EFILTERSTYLE        = 0x00002b0b,
    WSA_QOS_EFILTERTYPE         = 0x00002b0c,
    WSA_QOS_EFILTERCOUNT        = 0x00002b0d,
    WSA_QOS_EOBJLENGTH          = 0x00002b0e,
    WSA_QOS_EFLOWCOUNT          = 0x00002b0f,
    WSA_QOS_EUNKOWNPSOBJ        = 0x00002b10,
    WSA_QOS_EPOLICYOBJ          = 0x00002b11,
    WSA_QOS_EFLOWDESC           = 0x00002b12,
    WSA_QOS_EPSFLOWSPEC         = 0x00002b13,
    WSA_QOS_EPSFILTERSPEC       = 0x00002b14,
    WSA_QOS_ESDMODEOBJ          = 0x00002b15,
    WSA_QOS_ESHAPERATEOBJ       = 0x00002b16,
    WSA_QOS_RESERVED_PETYPE     = 0x00002b17,
    WSA_SECURE_HOST_NOT_FOUND   = 0x00002b18,
    WSA_IPSEC_NAME_POLICY_ERROR = 0x00002b19,
}

alias ADDRESS_FAMILY = ushort;
enum : ushort
{
    AF_INET   = cast(ushort) 0x0002,
    AF_INET6  = cast(ushort) 0x0017,
    AF_UNSPEC = cast(ushort) 0x0000,
}

alias SET_SERVICE_OPERATION = uint;
enum : uint
{
    SERVICE_REGISTER    = 0x00000001U,
    SERVICE_DEREGISTER  = 0x00000002U,
    SERVICE_FLUSH       = 0x00000003U,
    SERVICE_ADD_TYPE    = 0x00000004U,
    SERVICE_DELETE_TYPE = 0x00000005U,
}

alias SEND_RECV_FLAGS = int;
enum : int
{
    MSG_OOB            = 0x00000001,
    MSG_PEEK           = 0x00000002,
    MSG_DONTROUTE      = 0x00000004,
    MSG_WAITALL        = 0x00000008,
    MSG_PUSH_IMMEDIATE = 0x00000020,
}

alias RESOURCE_DISPLAY_TYPE = uint;
enum : uint
{
    RESOURCEDISPLAYTYPE_DOMAIN  = 0x00000001U,
    RESOURCEDISPLAYTYPE_FILE    = 0x00000004U,
    RESOURCEDISPLAYTYPE_GENERIC = 0x00000000U,
    RESOURCEDISPLAYTYPE_GROUP   = 0x00000005U,
    RESOURCEDISPLAYTYPE_SERVER  = 0x00000002U,
    RESOURCEDISPLAYTYPE_SHARE   = 0x00000003U,
    RESOURCEDISPLAYTYPE_TREE    = 0x0000000aU,
}

alias WSAPOLL_EVENT_FLAGS = short;
enum : short
{
    POLLRDNORM = cast(short) 0x0100,
    POLLRDBAND = cast(short) 0x0200,
    POLLIN     = cast(short) 0x0300,
    POLLPRI    = cast(short) 0x0400,
    POLLWRNORM = cast(short) 0x0010,
    POLLOUT    = cast(short) 0x0010,
    POLLWRBAND = cast(short) 0x0020,
    POLLERR    = cast(short) 0x0001,
    POLLHUP    = cast(short) 0x0002,
    POLLNVAL   = cast(short) 0x0004,
}

alias WINSOCK_SHUTDOWN_HOW = int;
enum : int
{
    SD_RECEIVE = 0x00000000,
    SD_SEND    = 0x00000001,
    SD_BOTH    = 0x00000002,
}

alias WINSOCK_SOCKET_TYPE = int;
enum : int
{
    SOCK_STREAM    = 0x00000001,
    SOCK_DGRAM     = 0x00000002,
    SOCK_RAW       = 0x00000003,
    SOCK_RDM       = 0x00000004,
    SOCK_SEQPACKET = 0x00000005,
}

alias IPPROTO = int;
enum : int
{
    IPPROTO_HOPOPTS               = 0x00000000,
    IPPROTO_ICMP                  = 0x00000001,
    IPPROTO_IGMP                  = 0x00000002,
    IPPROTO_GGP                   = 0x00000003,
    IPPROTO_IPV4                  = 0x00000004,
    IPPROTO_ST                    = 0x00000005,
    IPPROTO_TCP                   = 0x00000006,
    IPPROTO_CBT                   = 0x00000007,
    IPPROTO_EGP                   = 0x00000008,
    IPPROTO_IGP                   = 0x00000009,
    IPPROTO_PUP                   = 0x0000000c,
    IPPROTO_UDP                   = 0x00000011,
    IPPROTO_IDP                   = 0x00000016,
    IPPROTO_RDP                   = 0x0000001b,
    IPPROTO_IPV6                  = 0x00000029,
    IPPROTO_ROUTING               = 0x0000002b,
    IPPROTO_FRAGMENT              = 0x0000002c,
    IPPROTO_ESP                   = 0x00000032,
    IPPROTO_AH                    = 0x00000033,
    IPPROTO_ICMPV6                = 0x0000003a,
    IPPROTO_NONE                  = 0x0000003b,
    IPPROTO_DSTOPTS               = 0x0000003c,
    IPPROTO_ND                    = 0x0000004d,
    IPPROTO_ICLFXBM               = 0x0000004e,
    IPPROTO_PIM                   = 0x00000067,
    IPPROTO_PGM                   = 0x00000071,
    IPPROTO_L2TP                  = 0x00000073,
    IPPROTO_SCTP                  = 0x00000084,
    IPPROTO_RAW                   = 0x000000ff,
    IPPROTO_MAX                   = 0x00000100,
    IPPROTO_RESERVED_RAW          = 0x00000101,
    IPPROTO_RESERVED_IPSEC        = 0x00000102,
    IPPROTO_RESERVED_IPSECOFFLOAD = 0x00000103,
    IPPROTO_RESERVED_WNV          = 0x00000104,
    IPPROTO_RESERVED_MAX          = 0x00000105,
    IPPROTO_IP                    = 0x00000000,
    IPPROTO_RM                    = 0x00000071,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2def/ne-ws2def-scope_level
alias SCOPE_LEVEL = int;
enum : int
{
    ScopeLevelInterface    = 0x00000001,
    ScopeLevelLink         = 0x00000002,
    ScopeLevelSubnet       = 0x00000003,
    ScopeLevelAdmin        = 0x00000004,
    ScopeLevelSite         = 0x00000005,
    ScopeLevelOrganization = 0x00000008,
    ScopeLevelGlobal       = 0x0000000e,
    ScopeLevelCount        = 0x00000010,
}

alias WSACOMPLETIONTYPE = int;
enum : int
{
    NSP_NOTIFY_IMMEDIATELY = 0x00000000,
    NSP_NOTIFY_HWND        = 0x00000001,
    NSP_NOTIFY_EVENT       = 0x00000002,
    NSP_NOTIFY_PORT        = 0x00000003,
    NSP_NOTIFY_APC         = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock2/ne-winsock2-wsaecomparator
alias WSAECOMPARATOR = int;
enum : int
{
    COMP_EQUAL   = 0x00000000,
    COMP_NOTLESS = 0x00000001,
}

alias WSAESETSERVICEOP = int;
enum : int
{
    RNRSERVICE_REGISTER   = 0x00000000,
    RNRSERVICE_DEREGISTER = 0x00000001,
    RNRSERVICE_DELETE     = 0x00000002,
}

alias PMTUD_STATE = int;
enum : int
{
    IP_PMTUDISC_NOT_SET = 0x00000000,
    IP_PMTUDISC_DO      = 0x00000001,
    IP_PMTUDISC_DONT    = 0x00000002,
    IP_PMTUDISC_PROBE   = 0x00000003,
    IP_PMTUDISC_MAX     = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2ipdef/ne-ws2ipdef-multicast_mode_type
alias MULTICAST_MODE_TYPE = int;
enum : int
{
    MCAST_INCLUDE = 0x00000000,
    MCAST_EXCLUDE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wsrm/ne-wsrm-ewindow_advance_method
alias eWINDOW_ADVANCE_METHOD = int;
enum : int
{
    E_WINDOW_ADVANCE_BY_TIME   = 0x00000001,
    E_WINDOW_USE_AS_DATA_CACHE = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nldef/ne-nldef-nl_prefix_origin
alias NL_PREFIX_ORIGIN = int;
enum : int
{
    IpPrefixOriginOther               = 0x00000000,
    IpPrefixOriginManual              = 0x00000001,
    IpPrefixOriginWellKnown           = 0x00000002,
    IpPrefixOriginDhcp                = 0x00000003,
    IpPrefixOriginRouterAdvertisement = 0x00000004,
    IpPrefixOriginUnchanged           = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nldef/ne-nldef-nl_suffix_origin
alias NL_SUFFIX_ORIGIN = int;
enum : int
{
    NlsoOther                      = 0x00000000,
    NlsoManual                     = 0x00000001,
    NlsoWellKnown                  = 0x00000002,
    NlsoDhcp                       = 0x00000003,
    NlsoLinkLayerAddress           = 0x00000004,
    NlsoRandom                     = 0x00000005,
    IpSuffixOriginOther            = 0x00000000,
    IpSuffixOriginManual           = 0x00000001,
    IpSuffixOriginWellKnown        = 0x00000002,
    IpSuffixOriginDhcp             = 0x00000003,
    IpSuffixOriginLinkLayerAddress = 0x00000004,
    IpSuffixOriginRandom           = 0x00000005,
    IpSuffixOriginUnchanged        = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nldef/ne-nldef-nl_dad_state
alias NL_DAD_STATE = int;
enum : int
{
    NldsInvalid          = 0x00000000,
    NldsTentative        = 0x00000001,
    NldsDuplicate        = 0x00000002,
    NldsDeprecated       = 0x00000003,
    NldsPreferred        = 0x00000004,
    IpDadStateInvalid    = 0x00000000,
    IpDadStateTentative  = 0x00000001,
    IpDadStateDuplicate  = 0x00000002,
    IpDadStateDeprecated = 0x00000003,
    IpDadStatePreferred  = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nldef/ne-nldef-nl_route_protocol
alias NL_ROUTE_PROTOCOL = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nldef/ne-nldef-nl_address_type
alias NL_ADDRESS_TYPE = int;
enum : int
{
    NlatUnspecified = 0x00000000,
    NlatUnicast     = 0x00000001,
    NlatAnycast     = 0x00000002,
    NlatMulticast   = 0x00000003,
    NlatBroadcast   = 0x00000004,
    NlatInvalid     = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nldef/ne-nldef-nl_route_origin
alias NL_ROUTE_ORIGIN = int;
enum : int
{
    NlroManual              = 0x00000000,
    NlroWellKnown           = 0x00000001,
    NlroDHCP                = 0x00000002,
    NlroRouterAdvertisement = 0x00000003,
    Nlro6to4                = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nldef/ne-nldef-nl_neighbor_state
alias NL_NEIGHBOR_STATE = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nldef/ne-nldef-nl_link_local_address_behavior
alias NL_LINK_LOCAL_ADDRESS_BEHAVIOR = int;
enum : int
{
    LinkLocalAlwaysOff = 0x00000000,
    LinkLocalDelayed   = 0x00000001,
    LinkLocalAlwaysOn  = 0x00000002,
    LinkLocalUnchanged = 0xffffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nldef/ne-nldef-nl_router_discovery_behavior
alias NL_ROUTER_DISCOVERY_BEHAVIOR = int;
enum : int
{
    RouterDiscoveryDisabled  = 0x00000000,
    RouterDiscoveryEnabled   = 0x00000001,
    RouterDiscoveryDhcp      = 0x00000002,
    RouterDiscoveryUnchanged = 0xffffffff,
}

alias NL_BANDWIDTH_FLAG = int;
enum : int
{
    NlbwDisabled  = 0x00000000,
    NlbwEnabled   = 0x00000001,
    NlbwUnchanged = 0xffffffff,
}

alias NL_NETWORK_CATEGORY = int;
enum : int
{
    NetworkCategoryPublic              = 0x00000000,
    NetworkCategoryPrivate             = 0x00000001,
    NetworkCategoryDomainAuthenticated = 0x00000002,
    NetworkCategoryUnchanged           = 0xffffffff,
    NetworkCategoryUnknown             = 0xffffffff,
}

alias NL_INTERFACE_NETWORK_CATEGORY_STATE = int;
enum : int
{
    NlincCategoryUnknown     = 0x00000000,
    NlincPublic              = 0x00000001,
    NlincPrivate             = 0x00000002,
    NlincDomainAuthenticated = 0x00000003,
    NlincCategoryStateMax    = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nldef/ne-nldef-nl_network_connectivity_level_hint
alias NL_NETWORK_CONNECTIVITY_LEVEL_HINT = int;
enum : int
{
    NetworkConnectivityLevelHintUnknown                   = 0x00000000,
    NetworkConnectivityLevelHintNone                      = 0x00000001,
    NetworkConnectivityLevelHintLocalAccess               = 0x00000002,
    NetworkConnectivityLevelHintInternetAccess            = 0x00000003,
    NetworkConnectivityLevelHintConstrainedInternetAccess = 0x00000004,
    NetworkConnectivityLevelHintHidden                    = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nldef/ne-nldef-nl_network_connectivity_cost_hint
alias NL_NETWORK_CONNECTIVITY_COST_HINT = int;
enum : int
{
    NetworkConnectivityCostHintUnknown      = 0x00000000,
    NetworkConnectivityCostHintUnrestricted = 0x00000001,
    NetworkConnectivityCostHintFixed        = 0x00000002,
    NetworkConnectivityCostHintVariable     = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstcpip/ne-mstcpip-tcpstate
alias TCPSTATE = int;
enum : int
{
    TCPSTATE_CLOSED      = 0x00000000,
    TCPSTATE_LISTEN      = 0x00000001,
    TCPSTATE_SYN_SENT    = 0x00000002,
    TCPSTATE_SYN_RCVD    = 0x00000003,
    TCPSTATE_ESTABLISHED = 0x00000004,
    TCPSTATE_FIN_WAIT_1  = 0x00000005,
    TCPSTATE_FIN_WAIT_2  = 0x00000006,
    TCPSTATE_CLOSE_WAIT  = 0x00000007,
    TCPSTATE_CLOSING     = 0x00000008,
    TCPSTATE_LAST_ACK    = 0x00000009,
    TCPSTATE_TIME_WAIT   = 0x0000000a,
    TCPSTATE_MAX         = 0x0000000b,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstcpip/ne-mstcpip-control_channel_trigger_status
alias CONTROL_CHANNEL_TRIGGER_STATUS = int;
enum : int
{
    CONTROL_CHANNEL_TRIGGER_STATUS_INVALID                 = 0x00000000,
    CONTROL_CHANNEL_TRIGGER_STATUS_SOFTWARE_SLOT_ALLOCATED = 0x00000001,
    CONTROL_CHANNEL_TRIGGER_STATUS_HARDWARE_SLOT_ALLOCATED = 0x00000002,
    CONTROL_CHANNEL_TRIGGER_STATUS_POLICY_ERROR            = 0x00000003,
    CONTROL_CHANNEL_TRIGGER_STATUS_SYSTEM_ERROR            = 0x00000004,
    CONTROL_CHANNEL_TRIGGER_STATUS_TRANSPORT_DISCONNECTED  = 0x00000005,
    CONTROL_CHANNEL_TRIGGER_STATUS_SERVICE_UNAVAILABLE     = 0x00000006,
}

alias SOCKET_PRIORITY_HINT = int;
enum : int
{
    SocketPriorityHintVeryLow     = 0x00000000,
    SocketPriorityHintLow         = 0x00000001,
    SocketPriorityHintNormal      = 0x00000002,
    SocketMaximumPriorityHintType = 0x00000003,
}

alias RCVALL_VALUE = int;
enum : int
{
    RCVALL_OFF             = 0x00000000,
    RCVALL_ON              = 0x00000001,
    RCVALL_SOCKETLEVELONLY = 0x00000002,
    RCVALL_IPLEVEL         = 0x00000003,
}

alias TCP_ICW_LEVEL = int;
enum : int
{
    TCP_ICW_LEVEL_DEFAULT      = 0x00000000,
    TCP_ICW_LEVEL_HIGH         = 0x00000001,
    TCP_ICW_LEVEL_VERY_HIGH    = 0x00000002,
    TCP_ICW_LEVEL_AGGRESSIVE   = 0x00000003,
    TCP_ICW_LEVEL_EXPERIMENTAL = 0x00000004,
    TCP_ICW_LEVEL_COMPAT       = 0x000000fe,
    TCP_ICW_LEVEL_MAX          = 0x000000ff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstcpip/ne-mstcpip-socket_usage_type
alias SOCKET_USAGE_TYPE = int;
enum : int
{
    SYSTEM_CRITICAL_SOCKET = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstcpip/ne-mstcpip-socket_security_protocol
alias SOCKET_SECURITY_PROTOCOL = int;
enum : int
{
    SOCKET_SECURITY_PROTOCOL_DEFAULT = 0x00000000,
    SOCKET_SECURITY_PROTOCOL_IPSEC   = 0x00000001,
    SOCKET_SECURITY_PROTOCOL_IPSEC2  = 0x00000002,
    SOCKET_SECURITY_PROTOCOL_INVALID = 0x00000003,
}

alias WSA_COMPATIBILITY_BEHAVIOR_ID = int;
enum : int
{
    WsaBehaviorAll              = 0x00000000,
    WsaBehaviorReceiveBuffering = 0x00000001,
    WsaBehaviorAutoTuning       = 0x00000002,
}

alias Q2931_IE_TYPE = int;
enum : int
{
    IE_AALParameters             = 0x00000000,
    IE_TrafficDescriptor         = 0x00000001,
    IE_BroadbandBearerCapability = 0x00000002,
    IE_BHLI                      = 0x00000003,
    IE_BLLI                      = 0x00000004,
    IE_CalledPartyNumber         = 0x00000005,
    IE_CalledPartySubaddress     = 0x00000006,
    IE_CallingPartyNumber        = 0x00000007,
    IE_CallingPartySubaddress    = 0x00000008,
    IE_Cause                     = 0x00000009,
    IE_QOSClass                  = 0x0000000a,
    IE_TransitNetworkSelection   = 0x0000000b,
}

alias AAL_TYPE = int;
enum : int
{
    AALTYPE_5    = 0x00000005,
    AALTYPE_USER = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nsemail/ne-nsemail-napi_provider_type
alias NAPI_PROVIDER_TYPE = int;
enum : int
{
    ProviderType_Application = 0x00000001,
    ProviderType_Service     = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nsemail/ne-nsemail-napi_provider_level
alias NAPI_PROVIDER_LEVEL = int;
enum : int
{
    ProviderLevel_None      = 0x00000000,
    ProviderLevel_Secondary = 0x00000001,
    ProviderLevel_Primary   = 0x00000002,
}

alias NLA_BLOB_DATA_TYPE = int;
enum : int
{
    NLA_RAW_DATA        = 0x00000000,
    NLA_INTERFACE       = 0x00000001,
    NLA_802_1X_LOCATION = 0x00000002,
    NLA_CONNECTIVITY    = 0x00000003,
    NLA_ICS             = 0x00000004,
}

alias NLA_CONNECTIVITY_TYPE = int;
enum : int
{
    NLA_NETWORK_AD_HOC    = 0x00000000,
    NLA_NETWORK_MANAGED   = 0x00000001,
    NLA_NETWORK_UNMANAGED = 0x00000002,
    NLA_NETWORK_UNKNOWN   = 0x00000003,
}

alias NLA_INTERNET = int;
enum : int
{
    NLA_INTERNET_UNKNOWN = 0x00000000,
    NLA_INTERNET_NO      = 0x00000001,
    NLA_INTERNET_YES     = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswsock/ne-mswsock-rio_notification_completion_type
alias RIO_NOTIFICATION_COMPLETION_TYPE = int;
enum : int
{
    RIO_EVENT_COMPLETION = 0x00000001,
    RIO_IOCP_COMPLETION  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2spi/ne-ws2spi-wsc_provider_info_type
alias WSC_PROVIDER_INFO_TYPE = int;
enum : int
{
    ProviderInfoLspCategories = 0x00000000,
    ProviderInfoAudit         = 0x00000001,
}

alias IPV4_OPTION_TYPE = int;
enum : int
{
    IP_OPT_EOL          = 0x00000000,
    IP_OPT_NOP          = 0x00000001,
    IP_OPT_SECURITY     = 0x00000082,
    IP_OPT_LSRR         = 0x00000083,
    IP_OPT_TS           = 0x00000044,
    IP_OPT_RR           = 0x00000007,
    IP_OPT_SSRR         = 0x00000089,
    IP_OPT_SID          = 0x00000088,
    IP_OPT_ROUTER_ALERT = 0x00000094,
    IP_OPT_MULTIDEST    = 0x00000095,
}

alias IP_OPTION_TIMESTAMP_FLAGS = int;
enum : int
{
    IP_OPTION_TIMESTAMP_ONLY             = 0x00000000,
    IP_OPTION_TIMESTAMP_ADDRESS          = 0x00000001,
    IP_OPTION_TIMESTAMP_SPECIFIC_ADDRESS = 0x00000003,
}

alias ICMP4_UNREACH_CODE = int;
enum : int
{
    ICMP4_UNREACH_NET                = 0x00000000,
    ICMP4_UNREACH_HOST               = 0x00000001,
    ICMP4_UNREACH_PROTOCOL           = 0x00000002,
    ICMP4_UNREACH_PORT               = 0x00000003,
    ICMP4_UNREACH_FRAG_NEEDED        = 0x00000004,
    ICMP4_UNREACH_SOURCEROUTE_FAILED = 0x00000005,
    ICMP4_UNREACH_NET_UNKNOWN        = 0x00000006,
    ICMP4_UNREACH_HOST_UNKNOWN       = 0x00000007,
    ICMP4_UNREACH_ISOLATED           = 0x00000008,
    ICMP4_UNREACH_NET_ADMIN          = 0x00000009,
    ICMP4_UNREACH_HOST_ADMIN         = 0x0000000a,
    ICMP4_UNREACH_NET_TOS            = 0x0000000b,
    ICMP4_UNREACH_HOST_TOS           = 0x0000000c,
    ICMP4_UNREACH_ADMIN              = 0x0000000d,
}

alias ICMP4_TIME_EXCEED_CODE = int;
enum : int
{
    ICMP4_TIME_EXCEED_TRANSIT    = 0x00000000,
    ICMP4_TIME_EXCEED_REASSEMBLY = 0x00000001,
}

alias ARP_OPCODE = int;
enum : int
{
    ARP_REQUEST  = 0x00000001,
    ARP_RESPONSE = 0x00000002,
}

alias ARP_HARDWARE_TYPE = int;
enum : int
{
    ARP_HW_ENET = 0x00000001,
    ARP_HW_802  = 0x00000006,
}

alias IGMP_MAX_RESP_CODE_TYPE = int;
enum : int
{
    IGMP_MAX_RESP_CODE_TYPE_NORMAL = 0x00000000,
    IGMP_MAX_RESP_CODE_TYPE_FLOAT  = 0x00000001,
}

alias IPV6_OPTION_TYPE = int;
enum : int
{
    IP6OPT_PAD1         = 0x00000000,
    IP6OPT_PADN         = 0x00000001,
    IP6OPT_TUNNEL_LIMIT = 0x00000004,
    IP6OPT_ROUTER_ALERT = 0x00000005,
    IP6OPT_JUMBO        = 0x000000c2,
    IP6OPT_NSAP_ADDR    = 0x000000c3,
}

alias ND_OPTION_TYPE = int;
enum : int
{
    ND_OPT_SOURCE_LINKADDR        = 0x00000001,
    ND_OPT_TARGET_LINKADDR        = 0x00000002,
    ND_OPT_PREFIX_INFORMATION     = 0x00000003,
    ND_OPT_REDIRECTED_HEADER      = 0x00000004,
    ND_OPT_MTU                    = 0x00000005,
    ND_OPT_NBMA_SHORTCUT_LIMIT    = 0x00000006,
    ND_OPT_ADVERTISEMENT_INTERVAL = 0x00000007,
    ND_OPT_HOME_AGENT_INFORMATION = 0x00000008,
    ND_OPT_SOURCE_ADDR_LIST       = 0x00000009,
    ND_OPT_TARGET_ADDR_LIST       = 0x0000000a,
    ND_OPT_ROUTE_INFO             = 0x00000018,
    ND_OPT_RDNSS                  = 0x00000019,
    ND_OPT_DNSSL                  = 0x0000001f,
    ND_OPT_PREF64                 = 0x00000026,
}

alias ND_OPT_PREF64_PREFIX_LENGTH_CODE = int;
enum : int
{
    ND_OPT_PREF64_PREFIX_LENGTH_96 = 0x00000000,
    ND_OPT_PREF64_PREFIX_LENGTH_64 = 0x00000001,
    ND_OPT_PREF64_PREFIX_LENGTH_56 = 0x00000002,
    ND_OPT_PREF64_PREFIX_LENGTH_48 = 0x00000003,
    ND_OPT_PREF64_PREFIX_LENGTH_40 = 0x00000004,
    ND_OPT_PREF64_PREFIX_LENGTH_32 = 0x00000005,
}

alias MLD_MAX_RESP_CODE_TYPE = int;
enum : int
{
    MLD_MAX_RESP_CODE_TYPE_NORMAL = 0x00000000,
    MLD_MAX_RESP_CODE_TYPE_FLOAT  = 0x00000001,
}

alias TUNNEL_SUB_TYPE = int;
enum : int
{
    TUNNEL_SUB_TYPE_NONE  = 0x00000000,
    TUNNEL_SUB_TYPE_CP    = 0x00000001,
    TUNNEL_SUB_TYPE_IPTLS = 0x00000002,
    TUNNEL_SUB_TYPE_HA    = 0x00000003,
}

alias NPI_MODULEID_TYPE = int;
enum : int
{
    MIT_GUID    = 0x00000001,
    MIT_IF_LUID = 0x00000002,
}

alias FALLBACK_INDEX = int;
enum : int
{
    FallbackIndexTcpFastopen = 0x00000000,
    FallbackIndexMax         = 0x00000001,
}

// Constants


enum GUID SOCKET_DEFAULT2_QM_POLICY = GUID("aec2ef9c-3a4d-4d3e-8842-239942e39a47");

enum : GUID
{
    REAL_TIME_NOTIFICATION_CAPABILITY    = GUID("6b59819a-5cae-492d-a901-2a3c2c50164f"),
    REAL_TIME_NOTIFICATION_CAPABILITY_EX = GUID("6843da03-154a-4616-a508-44371295f96b"),
}

enum GUID ASSOCIATE_NAMERES_CONTEXT = GUID("59a38b67-d4fe-46e1-ba3c-87ea74ca3049");

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/sio-rcvall
    SIO_RCVALL           = 0x98000001U,
    SIO_RCVALL_MCAST     = 0x98000002U,
    SIO_RCVALL_IGMPMCAST = 0x98000003U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/sio-keepalive-vals
enum uint SIO_KEEPALIVE_VALS = 0x98000004U;
enum uint SIO_ABSORB_RTRALERT = 0x98000005U;
enum uint SIO_UCAST_IF = 0x98000006U;
enum uint SIO_LIMIT_BROADCASTS = 0x98000007U;

enum : uint
{
    SIO_INDEX_BIND      = 0x98000008U,
    SIO_INDEX_MCASTIF   = 0x98000009U,
    SIO_INDEX_ADD_MCAST = 0x9800000aU,
    SIO_INDEX_DEL_MCAST = 0x9800000bU,
}

enum : uint
{
    SIO_RCVALL_MCAST_IF = 0x9800000dU,
    SIO_RCVALL_IF       = 0x9800000eU,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/sio-loopback-fast-path
enum uint SIO_LOOPBACK_FAST_PATH = 0x98000010U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/sio-tcp-initial-rto
enum uint SIO_TCP_INITIAL_RTO = 0x98000011U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/sio-apply-transport-setting
enum uint SIO_APPLY_TRANSPORT_SETTING = 0x98000013U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/sio-query-transport-setting
enum uint SIO_QUERY_TRANSPORT_SETTING = 0x98000014U;

enum : uint
{
    SIO_TCP_SET_ICW           = 0x98000016U,
    SIO_TCP_SET_ACK_FREQUENCY = 0x98000017U,
}

enum uint SIO_SET_PRIORITY_HINT = 0x98000018U;
enum uint SIO_PRIORITY_HINT = 0x98000018U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/sio-tcp-info
enum uint SIO_TCP_INFO = 0xd8000027U;
enum uint SIO_CPU_AFFINITY = 0x98000015U;
enum uint SIO_TIMESTAMPING = 0x980000ebU;

enum : uint
{
    TIMESTAMPING_FLAG_RX = 0x00000001U,
    TIMESTAMPING_FLAG_TX = 0x00000002U,
}

enum : uint
{
    SO_TIMESTAMP    = 0x0000300aU,
    SO_TIMESTAMP_ID = 0x0000300bU,
}

enum uint SIO_GET_TX_TIMESTAMP = 0x980000eaU;
enum ushort TCP_INITIAL_RTO_UNSPECIFIED_MAX_SYN_RETRANSMISSIONS = 0xffff;

enum : uint
{
    TCP_INITIAL_RTO_DEFAULT_RTT                     = 0x00000000U,
    TCP_INITIAL_RTO_DEFAULT_MAX_SYN_RETRANSMISSIONS = 0x00000000U,
}

enum ushort TCP_INITIAL_RTO_NO_SYN_RETRANSMISSIONS = 0xfffe;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/sio-acquire-port-reservation
enum uint SIO_ACQUIRE_PORT_RESERVATION = 0x98000064U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/sio-release-port-reservation
enum uint SIO_RELEASE_PORT_RESERVATION = 0x98000065U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/sio-associate-port-reservation
enum uint SIO_ASSOCIATE_PORT_RESERVATION = 0x98000066U;
enum uint SIO_SET_SECURITY = 0x980000c8U;
enum uint SIO_QUERY_SECURITY = 0xd80000c9U;
enum uint SIO_SET_PEER_TARGET_NAME = 0x980000caU;
enum uint SIO_DELETE_PEER_TARGET_NAME = 0x980000cbU;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/sio-query-wfp-connection-redirect-records
    SIO_QUERY_WFP_CONNECTION_REDIRECT_RECORDS = 0x980000dcU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/sio-query-wfp-connection-redirect-context
    SIO_QUERY_WFP_CONNECTION_REDIRECT_CONTEXT = 0x980000ddU,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/sio-set-wfp-connection-redirect-records
enum uint SIO_SET_WFP_CONNECTION_REDIRECT_RECORDS = 0x980000deU;
enum uint SIO_SOCKET_USAGE_NOTIFICATION = 0x980000ccU;

enum : uint
{
    SOCKET_SETTINGS_GUARANTEE_ENCRYPTION                      = 0x00000001U,
    SOCKET_SETTINGS_ALLOW_INSECURE                            = 0x00000002U,
    SOCKET_SETTINGS_IPSEC_SKIP_FILTER_INSTANTIATION           = 0x00000001U,
    SOCKET_SETTINGS_IPSEC_OPTIONAL_PEER_NAME_VERIFICATION     = 0x00000002U,
    SOCKET_SETTINGS_IPSEC_ALLOW_FIRST_INBOUND_PKT_UNENCRYPTED = 0x00000004U,
}

enum uint SOCKET_SETTINGS_IPSEC_PEER_NAME_IS_RAW_FORMAT = 0x00000008U;
enum uint SOCKET_QUERY_IPSEC2_ABORT_CONNECTION_ON_FIELD_CHANGE = 0x00000001U;

enum : uint
{
    SOCKET_QUERY_IPSEC2_FIELD_MASK_MM_SA_ID = 0x00000001U,
    SOCKET_QUERY_IPSEC2_FIELD_MASK_QM_SA_ID = 0x00000002U,
}

enum : uint
{
    SOCKET_INFO_CONNECTION_SECURED      = 0x00000001U,
    SOCKET_INFO_CONNECTION_ENCRYPTED    = 0x00000002U,
    SOCKET_INFO_CONNECTION_IMPERSONATED = 0x00000004U,
}

enum uint SIO_QUERY_WFP_ALE_ENDPOINT_HANDLE = 0x580000cdU;
enum uint SIO_QUERY_RSS_SCALABILITY_INFO = 0x580000d2U;

enum : uint
{
    IN4ADDR_ANY                   = 0x00000000U,
    IN4ADDR_LOOPBACK              = 0x0100007fU,
    IN4ADDR_BROADCAST             = 0xffffffffU,
    IN4ADDR_LOOPBACKPREFIX_LENGTH = 0x00000008U,
}

enum uint IN4ADDR_LINKLOCALPREFIX_LENGTH = 0x00000010U;
enum uint IN4ADDR_MULTICASTPREFIX_LENGTH = 0x00000004U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/sio-set-compatibility-mode
enum uint SIO_SET_COMPATIBILITY_MODE = 0x9800012cU;

enum : uint
{
    RIO_MSG_DONT_NOTIFY = 0x00000001U,
    RIO_MSG_DEFER       = 0x00000002U,
    RIO_MSG_WAITALL     = 0x00000004U,
    RIO_MSG_COMMIT_ONLY = 0x00000008U,
}

enum uint RIO_MAX_CQ_SIZE = 0x08000000U;
enum uint RIO_CORRUPT_CQ = 0xffffffffU;

enum : ushort
{
    AF_UNIX    = 0x0001,
    AF_IMPLINK = 0x0003,
}

enum : ushort
{
    AF_PUP   = 0x0004,
    AF_CHAOS = 0x0005,
}

enum : ushort
{
    AF_NS      = 0x0006,
    AF_IPX     = 0x0006,
    AF_ISO     = 0x0007,
    AF_OSI     = 0x0007,
    AF_ECMA    = 0x0008,
    AF_DATAKIT = 0x0009,
}

enum ushort AF_CCITT = 0x000a;

enum : ushort
{
    AF_SNA    = 0x000b,
    AF_DECnet = 0x000c,
    AF_DLI    = 0x000d,
    AF_LAT    = 0x000e,
    AF_HYLINK = 0x000f,
}

enum ushort AF_APPLETALK = 0x0010;
enum ushort AF_NETBIOS = 0x0011;
enum ushort AF_VOICEVIEW = 0x0012;
enum ushort AF_FIREFOX = 0x0013;
enum ushort AF_UNKNOWN1 = 0x0014;

enum : ushort
{
    AF_BAN     = 0x0015,
    AF_ATM     = 0x0016,
    AF_CLUSTER = 0x0018,
}

enum ushort AF_12844 = 0x0019;

enum : ushort
{
    AF_IRDA   = 0x001a,
    AF_NETDES = 0x001c,
}

enum : ushort
{
    AF_MAX        = 0x001d,
    AF_TCNPROCESS = 0x001d,
    AF_TCNMESSAGE = 0x001e,
}

enum ushort AF_ICLFXBM = 0x001f;

enum : ushort
{
    AF_LINK   = 0x0021,
    AF_HYPERV = 0x0022,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/sol-socket-socket-options
enum int SOL_SOCKET = 0x0000ffff;

enum : uint
{
    SOL_IP   = 0x0000fffbU,
    SOL_IPV6 = 0x0000fffaU,
}

enum int SO_DEBUG = 0x00000001;
enum int SO_ACCEPTCONN = 0x00000002;
enum int SO_REUSEADDR = 0x00000004;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/so-keepalive
enum int SO_KEEPALIVE = 0x00000008;
enum int SO_DONTROUTE = 0x00000010;
enum int SO_BROADCAST = 0x00000020;
enum int SO_USELOOPBACK = 0x00000040;
enum int SO_LINGER = 0x00000080;
enum int SO_OOBINLINE = 0x00000100;
enum int SO_SNDBUF = 0x00001001;
enum int SO_RCVBUF = 0x00001002;
enum int SO_SNDLOWAT = 0x00001003;
enum int SO_RCVLOWAT = 0x00001004;
enum int SO_SNDTIMEO = 0x00001005;
enum int SO_RCVTIMEO = 0x00001006;
enum int SO_ERROR = 0x00001007;

enum : int
{
    SO_TYPE      = 0x00001008,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/so-bsp-state
    SO_BSP_STATE = 0x00001009,
}

enum : int
{
    SO_GROUP_ID       = 0x00002001,
    SO_GROUP_PRIORITY = 0x00002002,
}

enum int SO_MAX_MSG_SIZE = 0x00002003;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/so-conditional-accept
enum int SO_CONDITIONAL_ACCEPT = 0x00003002;
enum uint SO_PAUSE_ACCEPT = 0x00003003U;
enum uint SO_COMPARTMENT_ID = 0x00003004U;
enum int SO_RANDOMIZE_PORT = 0x00003005;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/so-port-scalability
enum int SO_PORT_SCALABILITY = 0x00003006;

enum : int
{
    SO_REUSE_UNICASTPORT   = 0x00003007,
    SO_REUSE_MULTICASTPORT = 0x00003008,
}

enum uint SO_ORIGINAL_DST = 0x0000300fU;
enum uint IP6T_SO_ORIGINAL_DST = 0x0000300fU;

enum : uint
{
    SO_RECEIVED_HOPLIMIT  = 0x00003010U,
    SO_RECEIVED_PROCESSOR = 0x00003011U,
}

enum uint WSK_SO_BASE = 0x00004000U;
enum int TCP_NODELAY = 0x00000001;
enum uint _SS_MAXSIZE = 0x00000080U;

enum : uint
{
    IOC_UNIX     = 0x00000000U,
    IOC_WS2      = 0x08000000U,
    IOC_PROTOCOL = 0x10000000U,
}

enum uint IOC_VENDOR = 0x18000000U;
enum uint SIO_ASSOCIATE_HANDLE = 0x88000001U;
enum uint SIO_ENABLE_CIRCULAR_QUEUEING = 0x28000002U;
enum uint SIO_FIND_ROUTE = 0x48000003U;

enum : uint
{
    SIO_FLUSH                 = 0x28000004U,
    SIO_GET_BROADCAST_ADDRESS = 0x48000005U,
}

enum uint SIO_GET_EXTENSION_FUNCTION_POINTER = 0xc8000006U;

enum : uint
{
    SIO_GET_QOS       = 0xc8000007U,
    SIO_GET_GROUP_QOS = 0xc8000008U,
}

enum uint SIO_MULTIPOINT_LOOPBACK = 0x88000009U;
enum uint SIO_MULTICAST_SCOPE = 0x8800000aU;

enum : uint
{
    SIO_SET_QOS       = 0x8800000bU,
    SIO_SET_GROUP_QOS = 0x8800000cU,
}

enum uint SIO_TRANSLATE_HANDLE = 0xc800000dU;

enum : uint
{
    SIO_ROUTING_INTERFACE_QUERY  = 0xc8000014U,
    SIO_ROUTING_INTERFACE_CHANGE = 0x88000015U,
}

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/sio-address-list-query
    SIO_ADDRESS_LIST_QUERY  = 0x48000016U,
    SIO_ADDRESS_LIST_CHANGE = 0x28000017U,
}

enum uint SIO_QUERY_TARGET_PNP_HANDLE = 0x48000018U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/sio-query-rss-processor-info
enum uint SIO_QUERY_RSS_PROCESSOR_INFO = 0x48000025U;
enum uint SIO_ADDRESS_LIST_SORT = 0xc8000019U;

enum : uint
{
    SIO_RESERVED_1 = 0x8800001aU,
    SIO_RESERVED_2 = 0x88000021U,
}

enum uint SIO_GET_MULTIPLE_EXTENSION_FUNCTION_POINTER = 0xc8000024U;

enum : uint
{
    IPPORT_TCPMUX      = 0x00000001U,
    IPPORT_ECHO        = 0x00000007U,
    IPPORT_DISCARD     = 0x00000009U,
    IPPORT_SYSTAT      = 0x0000000bU,
    IPPORT_DAYTIME     = 0x0000000dU,
    IPPORT_NETSTAT     = 0x0000000fU,
    IPPORT_QOTD        = 0x00000011U,
    IPPORT_MSP         = 0x00000012U,
    IPPORT_CHARGEN     = 0x00000013U,
    IPPORT_FTP_DATA    = 0x00000014U,
    IPPORT_FTP         = 0x00000015U,
    IPPORT_TELNET      = 0x00000017U,
    IPPORT_SMTP        = 0x00000019U,
    IPPORT_TIMESERVER  = 0x00000025U,
    IPPORT_NAMESERVER  = 0x0000002aU,
    IPPORT_WHOIS       = 0x0000002bU,
    IPPORT_MTP         = 0x00000039U,
    IPPORT_TFTP        = 0x00000045U,
    IPPORT_RJE         = 0x0000004dU,
    IPPORT_FINGER      = 0x0000004fU,
    IPPORT_TTYLINK     = 0x00000057U,
    IPPORT_SUPDUP      = 0x0000005fU,
    IPPORT_POP3        = 0x0000006eU,
    IPPORT_NTP         = 0x0000007bU,
    IPPORT_EPMAP       = 0x00000087U,
    IPPORT_NETBIOS_NS  = 0x00000089U,
    IPPORT_NETBIOS_DGM = 0x0000008aU,
    IPPORT_NETBIOS_SSN = 0x0000008bU,
}

enum : uint
{
    IPPORT_IMAP         = 0x0000008fU,
    IPPORT_SNMP         = 0x000000a1U,
    IPPORT_SNMP_TRAP    = 0x000000a2U,
    IPPORT_IMAP3        = 0x000000dcU,
    IPPORT_LDAP         = 0x00000185U,
    IPPORT_HTTPS        = 0x000001bbU,
    IPPORT_MICROSOFT_DS = 0x000001bdU,
}

enum : uint
{
    IPPORT_EXECSERVER  = 0x00000200U,
    IPPORT_LOGINSERVER = 0x00000201U,
}

enum : uint
{
    IPPORT_CMDSERVER      = 0x00000202U,
    IPPORT_EFSSERVER      = 0x00000208U,
    IPPORT_BIFFUDP        = 0x00000200U,
    IPPORT_WHOSERVER      = 0x00000201U,
    IPPORT_ROUTESERVER    = 0x00000208U,
    IPPORT_RESERVED       = 0x00000400U,
    IPPORT_REGISTERED_MIN = 0x00000400U,
    IPPORT_REGISTERED_MAX = 0x0000bfffU,
}

enum : uint
{
    IPPORT_DYNAMIC_MIN = 0x0000c000U,
    IPPORT_DYNAMIC_MAX = 0x0000ffffU,
}

enum : uint
{
    IN_CLASSA_NET    = 0xff000000U,
    IN_CLASSA_NSHIFT = 0x00000018U,
    IN_CLASSA_HOST   = 0x00ffffffU,
    IN_CLASSA_MAX    = 0x00000080U,
    IN_CLASSB_NET    = 0xffff0000U,
    IN_CLASSB_NSHIFT = 0x00000010U,
    IN_CLASSB_HOST   = 0x0000ffffU,
    IN_CLASSB_MAX    = 0x00010000U,
    IN_CLASSC_NET    = 0xffffff00U,
    IN_CLASSC_NSHIFT = 0x00000008U,
    IN_CLASSC_HOST   = 0x000000ffU,
    IN_CLASSD_NET    = 0xf0000000U,
    IN_CLASSD_NSHIFT = 0x0000001cU,
    IN_CLASSD_HOST   = 0x0fffffffU,
}

enum : uint
{
    INADDR_LOOPBACK = 0x7f000001U,
    INADDR_NONE     = 0xffffffffU,
}

enum uint IOCPARM_MASK = 0x0000007fU;

enum : uint
{
    IOC_VOID = 0x20000000U,
    IOC_OUT  = 0x40000000U,
    IOC_IN   = 0x80000000U,
}

enum : uint
{
    MSG_TRUNC  = 0x00000100U,
    MSG_CTRUNC = 0x00000200U,
}

enum : uint
{
    MSG_BCAST    = 0x00000400U,
    MSG_MCAST    = 0x00000800U,
    MSG_ERRQUEUE = 0x00001000U,
}

enum uint AI_PASSIVE = 0x00000001U;
enum uint AI_CANONNAME = 0x00000002U;

enum : uint
{
    AI_NUMERICHOST = 0x00000004U,
    AI_NUMERICSERV = 0x00000008U,
}

enum uint AI_DNS_ONLY = 0x00000010U;
enum uint AI_FORCE_CLEAR_TEXT = 0x00000020U;
enum uint AI_BYPASS_DNS_CACHE = 0x00000040U;
enum uint AI_RETURN_TTL = 0x00000080U;

enum : uint
{
    AI_ALL        = 0x00000100U,
    AI_ADDRCONFIG = 0x00000400U,
}

enum uint AI_V4MAPPED = 0x00000800U;
enum uint AI_NON_AUTHORITATIVE = 0x00004000U;
enum uint AI_SECURE = 0x00008000U;
enum uint AI_RETURN_PREFERRED_NAMES = 0x00010000U;

enum : uint
{
    AI_FQDN       = 0x00020000U,
    AI_FILESERVER = 0x00040000U,
}

enum uint AI_DISABLE_IDN_ENCODING = 0x00080000U;
enum uint AI_SECURE_WITH_FALLBACK = 0x00100000U;
enum uint AI_EXCLUSIVE_CUSTOM_SERVERS = 0x00200000U;
enum uint AI_RETURN_RESPONSE_FLAGS = 0x10000000U;
enum uint AI_REQUIRE_SECURE = 0x20000000U;
enum uint AI_RESOLUTION_HANDLE = 0x40000000U;
enum uint AI_EXTENDED = 0x80000000U;

enum : uint
{
    ADDRINFOEX_VERSION_2 = 0x00000002U,
    ADDRINFOEX_VERSION_3 = 0x00000003U,
    ADDRINFOEX_VERSION_4 = 0x00000004U,
    ADDRINFOEX_VERSION_5 = 0x00000005U,
    ADDRINFOEX_VERSION_6 = 0x00000006U,
    ADDRINFOEX_VERSION_7 = 0x00000007U,
}

enum : uint
{
    AI_DNS_SERVER_TYPE_UDP     = 0x00000001U,
    AI_DNS_SERVER_TYPE_DOH     = 0x00000002U,
    AI_DNS_SERVER_TYPE_DOT     = 0x00000003U,
    AI_DNS_SERVER_UDP_FALLBACK = 0x00000001U,
}

enum : uint
{
    AI_DNS_RESPONSE_SECURE   = 0x00000001U,
    AI_DNS_RESPONSE_HOSTFILE = 0x00000002U,
}

enum ulong AI_EXTRA_DNSSEC_REQUIRED = 0x0000000000000001UL;

enum : uint
{
    NS_ALL         = 0x00000000U,
    NS_SAP         = 0x00000001U,
    NS_NDS         = 0x00000002U,
    NS_PEER_BROWSE = 0x00000003U,
}

enum : uint
{
    NS_SLP         = 0x00000005U,
    NS_DHCP        = 0x00000006U,
    NS_TCPIP_LOCAL = 0x0000000aU,
    NS_TCPIP_HOSTS = 0x0000000bU,
}

enum : uint
{
    NS_DNS   = 0x0000000cU,
    NS_NETBT = 0x0000000dU,
}

enum : uint
{
    NS_WINS  = 0x0000000eU,
    NS_NLA   = 0x0000000fU,
    NS_NBP   = 0x00000014U,
    NS_MS    = 0x0000001eU,
    NS_STDA  = 0x0000001fU,
    NS_NTDS  = 0x00000020U,
    NS_EMAIL = 0x00000025U,
}

enum : uint
{
    NS_X500    = 0x00000028U,
    NS_NIS     = 0x00000029U,
    NS_NISPLUS = 0x0000002aU,
}

enum : uint
{
    NS_WRQ    = 0x00000032U,
    NS_NETDES = 0x0000003cU,
}

enum : uint
{
    NI_NOFQDN      = 0x00000001U,
    NI_NUMERICHOST = 0x00000002U,
}

enum uint NI_NAMEREQD = 0x00000004U;
enum uint NI_NUMERICSERV = 0x00000008U;
enum uint NI_DGRAM = 0x00000010U;

enum : uint
{
    NI_MAXHOST = 0x00000401U,
    NI_MAXSERV = 0x00000020U,
}

enum : uint
{
    IFF_UP        = 0x00000001U,
    IFF_BROADCAST = 0x00000002U,
}

enum uint IFF_LOOPBACK = 0x00000004U;
enum uint IFF_POINTTOPOINT = 0x00000008U;
enum uint IFF_MULTICAST = 0x00000010U;
enum int IP_OPTIONS = 0x00000001;
enum int IP_HDRINCL = 0x00000002;

enum : int
{
    IP_TOS            = 0x00000003,
    IP_TTL            = 0x00000004,
    IP_MULTICAST_IF   = 0x00000009,
    IP_MULTICAST_TTL  = 0x0000000a,
    IP_MULTICAST_LOOP = 0x0000000b,
}

enum int IP_ADD_MEMBERSHIP = 0x0000000c;
enum int IP_DROP_MEMBERSHIP = 0x0000000d;
enum int IP_DONTFRAGMENT = 0x0000000e;
enum int IP_ADD_SOURCE_MEMBERSHIP = 0x0000000f;
enum int IP_DROP_SOURCE_MEMBERSHIP = 0x00000010;
enum int IP_BLOCK_SOURCE = 0x00000011;
enum int IP_UNBLOCK_SOURCE = 0x00000012;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/ip-pktinfo
enum int IP_PKTINFO = 0x00000013;
enum int IP_HOPLIMIT = 0x00000015;

enum : int
{
    IP_RECVTTL           = 0x00000015,
    IP_RECEIVE_BROADCAST = 0x00000016,
}

enum : int
{
    IP_RECVIF      = 0x00000018,
    IP_RECVDSTADDR = 0x00000019,
}

enum int IP_IFLIST = 0x0000001c;
enum int IP_ADD_IFLIST = 0x0000001d;
enum int IP_DEL_IFLIST = 0x0000001e;
enum int IP_UNICAST_IF = 0x0000001f;
enum int IP_RTHDR = 0x00000020;
enum int IP_GET_IFLIST = 0x00000021;
enum int IP_RECVRTHDR = 0x00000026;
enum int IP_TCLASS = 0x00000027;

enum : int
{
    IP_RECVTCLASS = 0x00000028,
    IP_RECVTOS    = 0x00000028,
}

enum int IP_ORIGINAL_ARRIVAL_IF = 0x0000002f;

enum : int
{
    IP_ECN     = 0x00000032,
    IP_RECVECN = 0x00000032,
}

enum int IP_PKTINFO_EX = 0x00000033;

enum : int
{
    IP_WFP_REDIRECT_RECORDS = 0x0000003c,
    IP_WFP_REDIRECT_CONTEXT = 0x00000046,
}

enum int IP_MTU_DISCOVER = 0x00000047;

enum : int
{
    IP_MTU           = 0x00000049,
    IP_NRT_INTERFACE = 0x0000004a,
}

enum int IP_RECVERR = 0x0000004b;
enum int IP_USER_MTU = 0x0000004c;
enum int IP_UNSPECIFIED_TYPE_OF_SERVICE = 0xffffffff;
enum uint IP_UNSPECIFIED_USER_MTU = 0xffffffffU;
enum uint IN6ADDR_LINKLOCALPREFIX_LENGTH = 0x00000040U;
enum uint IN6ADDR_MULTICASTPREFIX_LENGTH = 0x00000008U;
enum uint IN6ADDR_SOLICITEDNODEMULTICASTPREFIX_LENGTH = 0x00000068U;
enum uint IN6ADDR_V4MAPPEDPREFIX_LENGTH = 0x00000060U;
enum uint IN6ADDR_6TO4PREFIX_LENGTH = 0x00000010U;
enum uint IN6ADDR_TEREDOPREFIX_LENGTH = 0x00000020U;
enum uint MCAST_JOIN_GROUP = 0x00000029U;
enum uint MCAST_LEAVE_GROUP = 0x0000002aU;
enum uint MCAST_BLOCK_SOURCE = 0x0000002bU;
enum uint MCAST_UNBLOCK_SOURCE = 0x0000002cU;
enum uint MCAST_JOIN_SOURCE_GROUP = 0x0000002dU;
enum uint MCAST_LEAVE_SOURCE_GROUP = 0x0000002eU;

enum : int
{
    IPV6_HOPOPTS      = 0x00000001,
    IPV6_HDRINCL      = 0x00000002,
    IPV6_UNICAST_HOPS = 0x00000004,
}

enum : int
{
    IPV6_MULTICAST_IF   = 0x00000009,
    IPV6_MULTICAST_HOPS = 0x0000000a,
    IPV6_MULTICAST_LOOP = 0x0000000b,
}

enum int IPV6_ADD_MEMBERSHIP = 0x0000000c;
enum int IPV6_JOIN_GROUP = 0x0000000c;
enum int IPV6_DROP_MEMBERSHIP = 0x0000000d;
enum int IPV6_LEAVE_GROUP = 0x0000000d;
enum int IPV6_DONTFRAG = 0x0000000e;

enum : int
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/ipv6-pktinfo
    IPV6_PKTINFO  = 0x00000013,
    IPV6_HOPLIMIT = 0x00000015,
}

enum int IPV6_PROTECTION_LEVEL = 0x00000017;

enum : int
{
    IPV6_RECVIF      = 0x00000018,
    IPV6_RECVDSTADDR = 0x00000019,
}

enum int IPV6_CHECKSUM = 0x0000001a;

enum : int
{
    IPV6_V6ONLY     = 0x0000001b,
    IPV6_IFLIST     = 0x0000001c,
    IPV6_ADD_IFLIST = 0x0000001d,
}

enum int IPV6_DEL_IFLIST = 0x0000001e;
enum int IPV6_UNICAST_IF = 0x0000001f;

enum : int
{
    IPV6_RTHDR      = 0x00000020,
    IPV6_GET_IFLIST = 0x00000021,
}

enum int IPV6_RECVRTHDR = 0x00000026;

enum : int
{
    IPV6_TCLASS     = 0x00000027,
    IPV6_RECVTCLASS = 0x00000028,
}

enum : int
{
    IPV6_ECN        = 0x00000032,
    IPV6_RECVECN    = 0x00000032,
    IPV6_PKTINFO_EX = 0x00000033,
}

enum : int
{
    IPV6_WFP_REDIRECT_RECORDS = 0x0000003c,
    IPV6_WFP_REDIRECT_CONTEXT = 0x00000046,
}

enum : int
{
    IPV6_MTU_DISCOVER  = 0x00000047,
    IPV6_MTU           = 0x00000048,
    IPV6_NRT_INTERFACE = 0x0000004a,
}

enum : int
{
    IPV6_RECVERR  = 0x0000004b,
    IPV6_USER_MTU = 0x0000004c,
}

enum int IP_UNSPECIFIED_HOP_LIMIT = 0xffffffff;
enum int IP_PROTECTION_LEVEL = 0x00000017;

enum : uint
{
    PROTECTION_LEVEL_UNRESTRICTED   = 0x0000000aU,
    PROTECTION_LEVEL_EDGERESTRICTED = 0x00000014U,
    PROTECTION_LEVEL_RESTRICTED     = 0x0000001eU,
    PROTECTION_LEVEL_DEFAULT        = 0x00000014U,
}

enum uint INET_ADDRSTRLEN = 0x00000016U;
enum uint INET6_ADDRSTRLEN = 0x00000041U;

enum : int
{
    TCP_OFFLOAD_NO_PREFERENCE = 0x00000000,
    TCP_OFFLOAD_NOT_PREFERRED = 0x00000001,
    TCP_OFFLOAD_PREFERRED     = 0x00000002,
}

enum int TCP_EXPEDITED_1122 = 0x00000002;
enum int TCP_KEEPALIVE = 0x00000003;

enum : int
{
    TCP_MAXSEG = 0x00000004,
    TCP_MAXRT  = 0x00000005,
    TCP_STDURG = 0x00000006,
}

enum : int
{
    TCP_NOURG  = 0x00000007,
    TCP_ATMARK = 0x00000008,
}

enum int TCP_NOSYNRETRIES = 0x00000009;
enum int TCP_TIMESTAMPS = 0x0000000a;
enum int TCP_OFFLOAD_PREFERENCE = 0x0000000b;
enum int TCP_CONGESTION_ALGORITHM = 0x0000000c;
enum int TCP_DELAY_FIN_ACK = 0x0000000d;
enum int TCP_MAXRTMS = 0x0000000e;
enum int TCP_FASTOPEN = 0x0000000f;

enum : int
{
    TCP_KEEPCNT   = 0x00000010,
    TCP_KEEPIDLE  = 0x00000003,
    TCP_KEEPINTVL = 0x00000011,
}

enum int TCP_FAIL_CONNECT_ON_ICMP_ERROR = 0x00000012;
enum int TCP_ICMP_ERROR_INFO = 0x00000013;
enum int UDP_SEND_MSG_SIZE = 0x00000002;
enum int UDP_RECV_MAX_COALESCED_SIZE = 0x00000003;
enum uint UDP_COALESCED_INFO = 0x00000003U;

enum : uint
{
    WINDOWS_AF_IRDA = 0x0000001aU,
    WINDOWS_PF_IRDA = 0x0000001aU,
}

enum uint WCE_AF_IRDA = 0x00000016U;
enum uint WCE_PF_IRDA = 0x00000016U;
enum uint IRDA_PROTO_SOCK_STREAM = 0x00000001U;
enum ushort PF_IRDA = 0x001a;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/sol-irlmp-socket-options
enum int SOL_IRLMP = 0x000000ff;
enum int IRLMP_ENUMDEVICES = 0x00000010;

enum : int
{
    IRLMP_IAS_SET   = 0x00000011,
    IRLMP_IAS_QUERY = 0x00000012,
}

enum int IRLMP_SEND_PDU_LEN = 0x00000013;
enum int IRLMP_EXCLUSIVE_MODE = 0x00000014;
enum int IRLMP_IRLPT_MODE = 0x00000015;
enum int IRLMP_9WIRE_MODE = 0x00000016;
enum int IRLMP_TINYTP_MODE = 0x00000017;
enum int IRLMP_PARAMETERS = 0x00000018;
enum int IRLMP_DISCOVERY_MODE = 0x00000019;
enum int IRLMP_SHARP_MODE = 0x00000020;

enum : uint
{
    IAS_ATTRIB_NO_CLASS  = 0x00000010U,
    IAS_ATTRIB_NO_ATTRIB = 0x00000000U,
    IAS_ATTRIB_INT       = 0x00000001U,
    IAS_ATTRIB_OCTETSEQ  = 0x00000002U,
    IAS_ATTRIB_STR       = 0x00000003U,
}

enum : uint
{
    IAS_MAX_USER_STRING  = 0x00000100U,
    IAS_MAX_OCTET_STRING = 0x00000400U,
}

enum : uint
{
    IAS_MAX_CLASSNAME  = 0x00000040U,
    IAS_MAX_ATTRIBNAME = 0x00000100U,
}

enum : uint
{
    LmCharSetASCII      = 0x00000000U,
    LmCharSetISO_8859_1 = 0x00000001U,
    LmCharSetISO_8859_2 = 0x00000002U,
    LmCharSetISO_8859_3 = 0x00000003U,
    LmCharSetISO_8859_4 = 0x00000004U,
    LmCharSetISO_8859_5 = 0x00000005U,
    LmCharSetISO_8859_6 = 0x00000006U,
    LmCharSetISO_8859_7 = 0x00000007U,
    LmCharSetISO_8859_8 = 0x00000008U,
    LmCharSetISO_8859_9 = 0x00000009U,
    LmCharSetUNICODE    = 0x000000ffU,
}

enum : uint
{
    LM_BAUD_1200   = 0x000004b0U,
    LM_BAUD_2400   = 0x00000960U,
    LM_BAUD_9600   = 0x00002580U,
    LM_BAUD_19200  = 0x00004b00U,
    LM_BAUD_38400  = 0x00009600U,
    LM_BAUD_57600  = 0x0000e100U,
    LM_BAUD_115200 = 0x0001c200U,
    LM_BAUD_576K   = 0x0008ca00U,
    LM_BAUD_1152K  = 0x00119400U,
    LM_BAUD_4M     = 0x003d0900U,
    LM_BAUD_16M    = 0x00f42400U,
}

enum : int
{
    SO_CONNDATA = 0x00007000,
    SO_CONNOPT  = 0x00007001,
}

enum : int
{
    SO_DISCDATA = 0x00007002,
    SO_DISCOPT  = 0x00007003,
}

enum : int
{
    SO_CONNDATALEN = 0x00007004,
    SO_CONNOPTLEN  = 0x00007005,
}

enum : int
{
    SO_DISCDATALEN = 0x00007006,
    SO_DISCOPTLEN  = 0x00007007,
}

enum int SO_OPENTYPE = 0x00007008;

enum : uint
{
    SO_SYNCHRONOUS_ALERT    = 0x00000010U,
    SO_SYNCHRONOUS_NONALERT = 0x00000020U,
}

enum : int
{
    SO_MAXDG     = 0x00007009,
    SO_MAXPATHDG = 0x0000700a,
}

enum int SO_UPDATE_ACCEPT_CONTEXT = 0x0000700b;
enum int SO_CONNECT_TIME = 0x0000700c;
enum int SO_UPDATE_CONNECT_CONTEXT = 0x00007010;
enum int TCP_BSDURGENT = 0x00007000;
enum uint SIO_UDP_CONNRESET = 0x9800000cU;
enum uint SIO_SOCKET_CLOSE_NOTIFY = 0x9800000dU;
enum uint SIO_UDP_NETRESET = 0x9800000fU;
enum uint TF_DISCONNECT = 0x00000001U;
enum uint TF_REUSE_SOCKET = 0x00000002U;
enum uint TF_WRITE_BEHIND = 0x00000004U;
enum uint TF_USE_DEFAULT_WORKER = 0x00000000U;
enum uint TF_USE_SYSTEM_THREAD = 0x00000010U;
enum uint TF_USE_KERNEL_APC = 0x00000020U;
enum GUID WSAID_TRANSMITFILE = GUID("b5367df0-cbac-11cf-95ca-00805f48a192");

enum : GUID
{
    WSAID_ACCEPTEX             = GUID("b5367df1-cbac-11cf-95ca-00805f48a192"),
    WSAID_GETACCEPTEXSOCKADDRS = GUID("b5367df2-cbac-11cf-95ca-00805f48a192"),
}

enum : uint
{
    TP_ELEMENT_MEMORY = 0x00000001U,
    TP_ELEMENT_FILE   = 0x00000002U,
    TP_ELEMENT_EOP    = 0x00000004U,
}

enum uint TP_DISCONNECT = 0x00000001U;
enum uint TP_REUSE_SOCKET = 0x00000002U;
enum uint TP_USE_DEFAULT_WORKER = 0x00000000U;
enum uint TP_USE_SYSTEM_THREAD = 0x00000010U;
enum uint TP_USE_KERNEL_APC = 0x00000020U;
enum GUID WSAID_TRANSMITPACKETS = GUID("d9689da0-1f90-11d3-9971-00c04f68c876");
enum GUID WSAID_CONNECTEX = GUID("25a207b9-ddf3-4660-8ee9-76e58c74063e");
enum GUID WSAID_DISCONNECTEX = GUID("7fda2e11-8630-436f-a031-f536a6eec157");
enum uint DE_REUSE_SOCKET = 0x00000002U;
enum GUID NLA_NAMESPACE_GUID = GUID("6642243a-3ba8-4aa6-baa5-2e0bd71fdd83");
enum GUID NLA_SERVICE_CLASS_GUID = GUID("0037e515-b5c9-4a43-bada-8b48a87ad239");
enum uint NLA_ALLUSERS_NETWORK = 0x00000001U;
enum uint NLA_FRIENDLY_NAME = 0x00000002U;
enum GUID WSAID_WSARECVMSG = GUID("f689d7c8-6f1f-436b-8a53-e54fe351c322");

enum : uint
{
    SIO_BSP_HANDLE        = 0x4800001bU,
    SIO_BSP_HANDLE_SELECT = 0x4800001cU,
    SIO_BSP_HANDLE_POLL   = 0x4800001dU,
}

enum uint SIO_BASE_HANDLE = 0x48000022U;

enum : uint
{
    SIO_EXT_SELECT  = 0xc800001eU,
    SIO_EXT_POLL    = 0xc800001fU,
    SIO_EXT_SENDMSG = 0xc8000020U,
}

enum : GUID
{
    WSAID_WSASENDMSG   = GUID("a441e712-754f-43ca-84a7-0dee44cf606d"),
    WSAID_WSAPOLL      = GUID("18c76f85-dc66-4964-972e-23c27238312b"),
    WSAID_MULTIPLE_RIO = GUID("8509e081-96dd-4005-b165-9e2ee8c79e3f"),
}

enum : uint
{
    SERVICE_RESOURCE   = 0x00000001U,
    SERVICE_SERVICE    = 0x00000002U,
    SERVICE_LOCAL      = 0x00000004U,
    SERVICE_FLAG_DEFER = 0x00000001U,
    SERVICE_FLAG_HARD  = 0x00000002U,
}

enum : uint
{
    PROP_COMMENT      = 0x00000001U,
    PROP_LOCALE       = 0x00000002U,
    PROP_DISPLAY_HINT = 0x00000004U,
}

enum : uint
{
    PROP_VERSION    = 0x00000008U,
    PROP_START_TIME = 0x00000010U,
}

enum : uint
{
    PROP_MACHINE   = 0x00000020U,
    PROP_ADDRESSES = 0x00000100U,
}

enum : uint
{
    PROP_SD  = 0x00000200U,
    PROP_ALL = 0x80000000U,
}

enum : uint
{
    SERVICE_ADDRESS_FLAG_RPC_CN = 0x00000001U,
    SERVICE_ADDRESS_FLAG_RPC_DG = 0x00000002U,
    SERVICE_ADDRESS_FLAG_RPC_NB = 0x00000004U,
}

enum uint NS_DEFAULT = 0x00000000U;
enum uint NS_VNS = 0x00000032U;
enum uint NSTYPE_HIERARCHICAL = 0x00000001U;

enum : uint
{
    NSTYPE_DYNAMIC    = 0x00000002U,
    NSTYPE_ENUMERABLE = 0x00000004U,
    NSTYPE_WORKGROUP  = 0x00000008U,
}

enum uint XP_CONNECTIONLESS = 0x00000001U;

enum : uint
{
    XP_GUARANTEED_DELIVERY = 0x00000002U,
    XP_GUARANTEED_ORDER    = 0x00000004U,
}

enum uint XP_MESSAGE_ORIENTED = 0x00000008U;
enum uint XP_PSEUDO_STREAM = 0x00000010U;
enum uint XP_GRACEFUL_CLOSE = 0x00000020U;
enum uint XP_EXPEDITED_DATA = 0x00000040U;
enum uint XP_CONNECT_DATA = 0x00000080U;
enum uint XP_DISCONNECT_DATA = 0x00000100U;

enum : uint
{
    XP_SUPPORTS_BROADCAST = 0x00000200U,
    XP_SUPPORTS_MULTICAST = 0x00000400U,
}

enum uint XP_BANDWIDTH_ALLOCATION = 0x00000800U;
enum uint XP_FRAGMENTATION = 0x00001000U;
enum uint XP_ENCRYPTS = 0x00002000U;
enum uint RES_SOFT_SEARCH = 0x00000001U;
enum uint RES_FIND_MULTIPLE = 0x00000002U;
enum uint RES_SERVICE = 0x00000004U;

enum : const(wchar)*
{
    // Native encoding: ansi
    SERVICE_TYPE_VALUE_SAPIDA   = "SapId",
    SERVICE_TYPE_VALUE_SAPIDW   = "SapId",
    // Native encoding: ansi
    SERVICE_TYPE_VALUE_CONNA    = "ConnectionOriented",
    SERVICE_TYPE_VALUE_CONNW    = "ConnectionOriented",
    // Native encoding: ansi
    SERVICE_TYPE_VALUE_TCPPORTA = "TcpPort",
    SERVICE_TYPE_VALUE_TCPPORTW = "TcpPort",
    // Native encoding: ansi
    SERVICE_TYPE_VALUE_UDPPORTA = "UdpPort",
    SERVICE_TYPE_VALUE_UDPPORTW = "UdpPort",
    SERVICE_TYPE_VALUE_SAPID    = "SapId",
    SERVICE_TYPE_VALUE_CONN     = "ConnectionOriented",
    SERVICE_TYPE_VALUE_TCPPORT  = "TcpPort",
    SERVICE_TYPE_VALUE_UDPPORT  = "UdpPort",
}

enum uint SET_SERVICE_PARTIAL_SUCCESS = 0x00000001U;
enum uint FD_SETSIZE = 0x00000040U;

enum : uint
{
    IMPLINK_IP        = 0x0000009bU,
    IMPLINK_LOWEXPER  = 0x0000009cU,
    IMPLINK_HIGHEXPER = 0x0000009eU,
}

enum uint WSADESCRIPTION_LEN = 0x00000100U;
enum uint WSASYS_STATUS_LEN = 0x00000080U;

enum : uint
{
    IP_DEFAULT_MULTICAST_TTL  = 0x00000001U,
    IP_DEFAULT_MULTICAST_LOOP = 0x00000001U,
}

enum uint IP_MAX_MEMBERSHIPS = 0x00000014U;
enum int SOCKET_ERROR = 0xffffffff;

enum : ushort
{
    PF_UNIX    = 0x0001,
    PF_IMPLINK = 0x0003,
}

enum : ushort
{
    PF_PUP   = 0x0004,
    PF_CHAOS = 0x0005,
}

enum : ushort
{
    PF_NS      = 0x0006,
    PF_IPX     = 0x0006,
    PF_ISO     = 0x0007,
    PF_OSI     = 0x0007,
    PF_ECMA    = 0x0008,
    PF_DATAKIT = 0x0009,
}

enum ushort PF_CCITT = 0x000a;

enum : ushort
{
    PF_SNA    = 0x000b,
    PF_DECnet = 0x000c,
    PF_DLI    = 0x000d,
    PF_LAT    = 0x000e,
    PF_HYLINK = 0x000f,
}

enum ushort PF_APPLETALK = 0x0010;
enum ushort PF_VOICEVIEW = 0x0012;
enum ushort PF_FIREFOX = 0x0013;
enum ushort PF_UNKNOWN1 = 0x0014;

enum : ushort
{
    PF_BAN = 0x0015,
    PF_MAX = 0x001d,
}

enum uint SOMAXCONN = 0x00000005U;
enum uint MSG_MAXIOVLEN = 0x00000010U;
enum uint MSG_PARTIAL = 0x00008000U;
enum uint MAXGETHOSTSTRUCT = 0x00000400U;

enum : uint
{
    FD_READ  = 0x00000001U,
    FD_WRITE = 0x00000002U,
}

enum : uint
{
    FD_OOB    = 0x00000004U,
    FD_ACCEPT = 0x00000008U,
}

enum uint FD_CONNECT = 0x00000010U;
enum uint FD_CLOSE = 0x00000020U;

enum : uint
{
    INCL_WINSOCK_API_PROTOTYPES = 0x00000001U,
    INCL_WINSOCK_API_TYPEDEFS   = 0x00000000U,
}

enum uint ADDR_ANY = 0x00000000U;
enum int FROM_PROTOCOL_INFO = 0xffffffff;

enum : int
{
    SO_PROTOCOL_INFOA = 0x00002004,
    SO_PROTOCOL_INFOW = 0x00002005,
    SO_PROTOCOL_INFO  = 0x00002005,
}

enum int PVD_CONFIG = 0x00003001;
enum ushort PF_ATM = 0x0016;
enum uint MSG_INTERRUPT = 0x00000010U;
enum uint FD_READ_BIT = 0x00000000U;
enum uint FD_WRITE_BIT = 0x00000001U;
enum uint FD_OOB_BIT = 0x00000002U;
enum uint FD_ACCEPT_BIT = 0x00000003U;
enum uint FD_CONNECT_BIT = 0x00000004U;
enum uint FD_CLOSE_BIT = 0x00000005U;
enum uint FD_QOS_BIT = 0x00000006U;
enum uint FD_GROUP_QOS_BIT = 0x00000007U;
enum uint FD_ROUTING_INTERFACE_CHANGE_BIT = 0x00000008U;
enum uint FD_ADDRESS_LIST_CHANGE_BIT = 0x00000009U;
enum uint FD_MAX_EVENTS = 0x0000000aU;
enum uint WSA_MAXIMUM_WAIT_EVENTS = 0x00000040U;

enum : uint
{
    WSA_WAIT_FAILED  = 0xffffffffU,
    WSA_WAIT_TIMEOUT = 0x00000102U,
}

enum uint CF_ACCEPT = 0x00000000U;
enum uint CF_REJECT = 0x00000001U;
enum uint CF_DEFER = 0x00000002U;
enum uint SG_UNCONSTRAINED_GROUP = 0x00000001U;
enum uint SG_CONSTRAINED_GROUP = 0x00000002U;
enum uint MAX_PROTOCOL_CHAIN = 0x00000007U;
enum uint BASE_PROTOCOL = 0x00000001U;
enum uint LAYERED_PROTOCOL = 0x00000000U;
enum uint WSAPROTOCOL_LEN = 0x000000ffU;
enum uint PFL_MULTIPLE_PROTO_ENTRIES = 0x00000001U;
enum uint PFL_RECOMMENDED_PROTO_ENTRY = 0x00000002U;
enum uint PFL_HIDDEN = 0x00000004U;
enum uint PFL_MATCHES_PROTOCOL_ZERO = 0x00000008U;
enum uint PFL_NETWORKDIRECT_PROVIDER = 0x00000010U;
enum uint XP1_CONNECTIONLESS = 0x00000001U;

enum : uint
{
    XP1_GUARANTEED_DELIVERY = 0x00000002U,
    XP1_GUARANTEED_ORDER    = 0x00000004U,
}

enum uint XP1_MESSAGE_ORIENTED = 0x00000008U;
enum uint XP1_PSEUDO_STREAM = 0x00000010U;
enum uint XP1_GRACEFUL_CLOSE = 0x00000020U;
enum uint XP1_EXPEDITED_DATA = 0x00000040U;
enum uint XP1_CONNECT_DATA = 0x00000080U;
enum uint XP1_DISCONNECT_DATA = 0x00000100U;

enum : uint
{
    XP1_SUPPORT_BROADCAST  = 0x00000200U,
    XP1_SUPPORT_MULTIPOINT = 0x00000400U,
}

enum : uint
{
    XP1_MULTIPOINT_CONTROL_PLANE = 0x00000800U,
    XP1_MULTIPOINT_DATA_PLANE    = 0x00001000U,
}

enum uint XP1_QOS_SUPPORTED = 0x00002000U;
enum uint XP1_INTERRUPT = 0x00004000U;

enum : uint
{
    XP1_UNI_SEND = 0x00008000U,
    XP1_UNI_RECV = 0x00010000U,
}

enum uint XP1_IFS_HANDLES = 0x00020000U;
enum uint XP1_PARTIAL_MESSAGE = 0x00040000U;
enum uint XP1_SAN_SUPPORT_SDP = 0x00080000U;
enum uint BIGENDIAN = 0x00000000U;
enum uint LITTLEENDIAN = 0x00000001U;
enum uint SECURITY_PROTOCOL_NONE = 0x00000000U;
enum uint JL_SENDER_ONLY = 0x00000001U;
enum uint JL_RECEIVER_ONLY = 0x00000002U;
enum uint JL_BOTH = 0x00000004U;

enum : uint
{
    WSA_FLAG_OVERLAPPED        = 0x00000001U,
    WSA_FLAG_MULTIPOINT_C_ROOT = 0x00000002U,
    WSA_FLAG_MULTIPOINT_C_LEAF = 0x00000004U,
    WSA_FLAG_MULTIPOINT_D_ROOT = 0x00000008U,
    WSA_FLAG_MULTIPOINT_D_LEAF = 0x00000010U,
}

enum uint WSA_FLAG_ACCESS_SYSTEM_SECURITY = 0x00000040U;
enum uint WSA_FLAG_NO_HANDLE_INHERIT = 0x00000080U;
enum uint WSA_FLAG_REGISTERED_IO = 0x00000100U;
enum uint SIO_NSP_NOTIFY_CHANGE = 0x88000019U;
enum uint TH_NETDEV = 0x00000001U;
enum uint TH_TAPI = 0x00000002U;
enum uint SERVICE_MULTIPLE = 0x00000001U;
enum uint NS_LOCALNAME = 0x00000013U;
enum uint RES_UNUSED_1 = 0x00000001U;
enum uint RES_FLUSH_CACHE = 0x00000002U;

enum : const(wchar)*
{
    // Native encoding: ansi
    SERVICE_TYPE_VALUE_IPXPORTA  = "IpxSocket",
    SERVICE_TYPE_VALUE_IPXPORTW  = "IpxSocket",
    // Native encoding: ansi
    SERVICE_TYPE_VALUE_OBJECTIDA = "ObjectId",
    SERVICE_TYPE_VALUE_OBJECTIDW = "ObjectId",
    SERVICE_TYPE_VALUE_OBJECTID  = "ObjectId",
}

enum : uint
{
    LUP_DEEP       = 0x00000001U,
    LUP_CONTAINERS = 0x00000002U,
}

enum uint LUP_NOCONTAINERS = 0x00000004U;
enum uint LUP_NEAREST = 0x00000008U;

enum : uint
{
    LUP_RETURN_NAME         = 0x00000010U,
    LUP_RETURN_TYPE         = 0x00000020U,
    LUP_RETURN_VERSION      = 0x00000040U,
    LUP_RETURN_COMMENT      = 0x00000080U,
    LUP_RETURN_ADDR         = 0x00000100U,
    LUP_RETURN_BLOB         = 0x00000200U,
    LUP_RETURN_ALIASES      = 0x00000400U,
    LUP_RETURN_QUERY_STRING = 0x00000800U,
    LUP_RETURN_ALL          = 0x00000ff0U,
    LUP_RES_SERVICE         = 0x00008000U,
}

enum : uint
{
    LUP_FLUSHCACHE    = 0x00001000U,
    LUP_FLUSHPREVIOUS = 0x00002000U,
}

enum uint LUP_NON_AUTHORITATIVE = 0x00004000U;
enum uint LUP_SECURE = 0x00008000U;
enum uint LUP_RETURN_PREFERRED_NAMES = 0x00010000U;
enum uint LUP_DNS_ONLY = 0x00020000U;
enum uint LUP_RETURN_RESPONSE_FLAGS = 0x00040000U;
enum uint LUP_RESERVED_UNUSED = 0x00080000U;
enum uint LUP_ADDRCONFIG = 0x00100000U;
enum uint LUP_DUAL_ADDR = 0x00200000U;
enum uint LUP_FILESERVER = 0x00400000U;
enum uint LUP_DISABLE_IDN_ENCODING = 0x00800000U;
enum uint LUP_API_ANSI = 0x01000000U;
enum uint LUP_EXTENDED_QUERYSET = 0x02000000U;
enum uint LUP_SECURE_WITH_FALLBACK = 0x04000000U;
enum uint LUP_EXCLUSIVE_CUSTOM_SERVERS = 0x08000000U;
enum uint LUP_REQUIRE_SECURE = 0x10000000U;
enum uint LUP_RETURN_TTL = 0x20000000U;
enum uint LUP_FORCE_CLEAR_TEXT = 0x40000000U;
enum uint LUP_RESOLUTION_HANDLE = 0x80000000U;

enum : uint
{
    RESULT_IS_ALIAS   = 0x00000001U,
    RESULT_IS_ADDED   = 0x00000010U,
    RESULT_IS_CHANGED = 0x00000020U,
    RESULT_IS_DELETED = 0x00000040U,
}

enum : uint
{
    SOCK_NOTIFY_REGISTER_EVENT_NONE   = 0x00000000U,
    SOCK_NOTIFY_REGISTER_EVENT_IN     = 0x00000001U,
    SOCK_NOTIFY_REGISTER_EVENT_OUT    = 0x00000002U,
    SOCK_NOTIFY_REGISTER_EVENT_HANGUP = 0x00000004U,
}

enum : uint
{
    SOCK_NOTIFY_EVENT_IN           = 0x00000001U,
    SOCK_NOTIFY_EVENT_OUT          = 0x00000002U,
    SOCK_NOTIFY_EVENT_HANGUP       = 0x00000004U,
    SOCK_NOTIFY_EVENT_ERR          = 0x00000040U,
    SOCK_NOTIFY_EVENT_REMOVE       = 0x00000080U,
    SOCK_NOTIFY_OP_NONE            = 0x00000000U,
    SOCK_NOTIFY_OP_ENABLE          = 0x00000001U,
    SOCK_NOTIFY_OP_DISABLE         = 0x00000002U,
    SOCK_NOTIFY_OP_REMOVE          = 0x00000004U,
    SOCK_NOTIFY_TRIGGER_ONESHOT    = 0x00000001U,
    SOCK_NOTIFY_TRIGGER_PERSISTENT = 0x00000002U,
    SOCK_NOTIFY_TRIGGER_LEVEL      = 0x00000004U,
    SOCK_NOTIFY_TRIGGER_EDGE       = 0x00000008U,
}

enum : uint
{
    ATMPROTO_AALUSER = 0x00000000U,
    ATMPROTO_AAL1    = 0x00000001U,
    ATMPROTO_AAL2    = 0x00000002U,
    ATMPROTO_AAL34   = 0x00000003U,
    ATMPROTO_AAL5    = 0x00000005U,
}

enum : uint
{
    SAP_FIELD_ABSENT        = 0xfffffffeU,
    SAP_FIELD_ANY           = 0xffffffffU,
    SAP_FIELD_ANY_AESA_SEL  = 0xfffffffaU,
    SAP_FIELD_ANY_AESA_REST = 0xfffffffbU,
}

enum : uint
{
    ATM_E164      = 0x00000001U,
    ATM_NSAP      = 0x00000002U,
    ATM_AESA      = 0x00000002U,
    ATM_ADDR_SIZE = 0x00000014U,
}

enum : uint
{
    BLLI_L2_ISO_1745       = 0x00000001U,
    BLLI_L2_Q921           = 0x00000002U,
    BLLI_L2_X25L           = 0x00000006U,
    BLLI_L2_X25M           = 0x00000007U,
    BLLI_L2_ELAPB          = 0x00000008U,
    BLLI_L2_HDLC_ARM       = 0x00000009U,
    BLLI_L2_HDLC_NRM       = 0x0000000aU,
    BLLI_L2_HDLC_ABM       = 0x0000000bU,
    BLLI_L2_LLC            = 0x0000000cU,
    BLLI_L2_X75            = 0x0000000dU,
    BLLI_L2_Q922           = 0x0000000eU,
    BLLI_L2_USER_SPECIFIED = 0x00000010U,
}

enum uint BLLI_L2_ISO_7776 = 0x00000011U;

enum : uint
{
    BLLI_L3_X25            = 0x00000006U,
    BLLI_L3_ISO_8208       = 0x00000007U,
    BLLI_L3_X223           = 0x00000008U,
    BLLI_L3_SIO_8473       = 0x00000009U,
    BLLI_L3_T70            = 0x0000000aU,
    BLLI_L3_ISO_TR9577     = 0x0000000bU,
    BLLI_L3_USER_SPECIFIED = 0x00000010U,
}

enum : uint
{
    BLLI_L3_IPI_SNAP = 0x00000080U,
    BLLI_L3_IPI_IP   = 0x000000ccU,
}

enum : uint
{
    BHLI_ISO          = 0x00000000U,
    BHLI_UserSpecific = 0x00000001U,
}

enum uint BHLI_HighLayerProfile = 0x00000002U;
enum uint BHLI_VendorSpecificAppId = 0x00000003U;

enum : uint
{
    AAL5_MODE_MESSAGE   = 0x00000001U,
    AAL5_MODE_STREAMING = 0x00000002U,
}

enum : uint
{
    AAL5_SSCS_NULL              = 0x00000000U,
    AAL5_SSCS_SSCOP_ASSURED     = 0x00000001U,
    AAL5_SSCS_SSCOP_NON_ASSURED = 0x00000002U,
}

enum uint AAL5_SSCS_FRAME_RELAY = 0x00000004U;

enum : uint
{
    BCOB_A = 0x00000001U,
    BCOB_C = 0x00000003U,
    BCOB_X = 0x00000010U,
}

enum uint TT_NOIND = 0x00000000U;

enum : uint
{
    TT_CBR = 0x00000004U,
    TT_VBR = 0x00000008U,
}

enum uint TR_NOIND = 0x00000000U;
enum uint TR_END_TO_END = 0x00000001U;
enum uint TR_NO_END_TO_END = 0x00000002U;

enum : uint
{
    CLIP_NOT = 0x00000000U,
    CLIP_SUS = 0x00000020U,
}

enum : uint
{
    UP_P2P  = 0x00000000U,
    UP_P2MP = 0x00000001U,
}

enum : uint
{
    BLLI_L2_MODE_NORMAL = 0x00000040U,
    BLLI_L2_MODE_EXT    = 0x00000080U,
}

enum : uint
{
    BLLI_L3_MODE_NORMAL = 0x00000040U,
    BLLI_L3_MODE_EXT    = 0x00000080U,
    BLLI_L3_PACKET_16   = 0x00000004U,
    BLLI_L3_PACKET_32   = 0x00000005U,
    BLLI_L3_PACKET_64   = 0x00000006U,
    BLLI_L3_PACKET_128  = 0x00000007U,
    BLLI_L3_PACKET_256  = 0x00000008U,
    BLLI_L3_PACKET_512  = 0x00000009U,
    BLLI_L3_PACKET_1024 = 0x0000000aU,
    BLLI_L3_PACKET_2048 = 0x0000000bU,
    BLLI_L3_PACKET_4096 = 0x0000000cU,
}

enum uint PI_ALLOWED = 0x00000000U;
enum uint PI_RESTRICTED = 0x00000040U;
enum uint PI_NUMBER_NOT_AVAILABLE = 0x00000080U;
enum uint SI_USER_NOT_SCREENED = 0x00000000U;

enum : uint
{
    SI_USER_PASSED = 0x00000001U,
    SI_USER_FAILED = 0x00000002U,
}

enum uint SI_NETWORK = 0x00000003U;

enum : uint
{
    CAUSE_LOC_USER            = 0x00000000U,
    CAUSE_LOC_PRIVATE_LOCAL   = 0x00000001U,
    CAUSE_LOC_PUBLIC_LOCAL    = 0x00000002U,
    CAUSE_LOC_TRANSIT_NETWORK = 0x00000003U,
}

enum : uint
{
    CAUSE_LOC_PUBLIC_REMOTE         = 0x00000004U,
    CAUSE_LOC_PRIVATE_REMOTE        = 0x00000005U,
    CAUSE_LOC_INTERNATIONAL_NETWORK = 0x00000007U,
}

enum uint CAUSE_LOC_BEYOND_INTERWORKING = 0x0000000aU;
enum uint CAUSE_UNALLOCATED_NUMBER = 0x00000001U;

enum : uint
{
    CAUSE_NO_ROUTE_TO_TRANSIT_NETWORK = 0x00000002U,
    CAUSE_NO_ROUTE_TO_DESTINATION     = 0x00000003U,
}

enum uint CAUSE_VPI_VCI_UNACCEPTABLE = 0x0000000aU;
enum uint CAUSE_NORMAL_CALL_CLEARING = 0x00000010U;
enum uint CAUSE_USER_BUSY = 0x00000011U;
enum uint CAUSE_NO_USER_RESPONDING = 0x00000012U;
enum uint CAUSE_CALL_REJECTED = 0x00000015U;
enum uint CAUSE_NUMBER_CHANGED = 0x00000016U;
enum uint CAUSE_USER_REJECTS_CLIR = 0x00000017U;
enum uint CAUSE_DESTINATION_OUT_OF_ORDER = 0x0000001bU;
enum uint CAUSE_INVALID_NUMBER_FORMAT = 0x0000001cU;
enum uint CAUSE_STATUS_ENQUIRY_RESPONSE = 0x0000001eU;
enum uint CAUSE_NORMAL_UNSPECIFIED = 0x0000001fU;
enum uint CAUSE_VPI_VCI_UNAVAILABLE = 0x00000023U;
enum uint CAUSE_NETWORK_OUT_OF_ORDER = 0x00000026U;
enum uint CAUSE_TEMPORARY_FAILURE = 0x00000029U;
enum uint CAUSE_ACCESS_INFORMAION_DISCARDED = 0x0000002bU;
enum uint CAUSE_NO_VPI_VCI_AVAILABLE = 0x0000002dU;
enum uint CAUSE_RESOURCE_UNAVAILABLE = 0x0000002fU;
enum uint CAUSE_QOS_UNAVAILABLE = 0x00000031U;
enum uint CAUSE_USER_CELL_RATE_UNAVAILABLE = 0x00000033U;

enum : uint
{
    CAUSE_BEARER_CAPABILITY_UNAUTHORIZED = 0x00000039U,
    CAUSE_BEARER_CAPABILITY_UNAVAILABLE  = 0x0000003aU,
}

enum uint CAUSE_OPTION_UNAVAILABLE = 0x0000003fU;
enum uint CAUSE_BEARER_CAPABILITY_UNIMPLEMENTED = 0x00000041U;
enum uint CAUSE_UNSUPPORTED_TRAFFIC_PARAMETERS = 0x00000049U;
enum uint CAUSE_INVALID_CALL_REFERENCE = 0x00000051U;
enum uint CAUSE_CHANNEL_NONEXISTENT = 0x00000052U;
enum uint CAUSE_INCOMPATIBLE_DESTINATION = 0x00000058U;

enum : uint
{
    CAUSE_INVALID_ENDPOINT_REFERENCE        = 0x00000059U,
    CAUSE_INVALID_TRANSIT_NETWORK_SELECTION = 0x0000005bU,
}

enum uint CAUSE_TOO_MANY_PENDING_ADD_PARTY = 0x0000005cU;
enum uint CAUSE_AAL_PARAMETERS_UNSUPPORTED = 0x0000005dU;
enum uint CAUSE_MANDATORY_IE_MISSING = 0x00000060U;

enum : uint
{
    CAUSE_UNIMPLEMENTED_MESSAGE_TYPE = 0x00000061U,
    CAUSE_UNIMPLEMENTED_IE           = 0x00000063U,
}

enum : uint
{
    CAUSE_INVALID_IE_CONTENTS       = 0x00000064U,
    CAUSE_INVALID_STATE_FOR_MESSAGE = 0x00000065U,
}

enum uint CAUSE_RECOVERY_ON_TIMEOUT = 0x00000066U;
enum uint CAUSE_INCORRECT_MESSAGE_LENGTH = 0x00000068U;
enum uint CAUSE_PROTOCOL_ERROR = 0x0000006fU;

enum : uint
{
    CAUSE_COND_UNKNOWN   = 0x00000000U,
    CAUSE_COND_PERMANENT = 0x00000001U,
    CAUSE_COND_TRANSIENT = 0x00000002U,
}

enum : uint
{
    CAUSE_REASON_USER            = 0x00000000U,
    CAUSE_REASON_IE_MISSING      = 0x00000004U,
    CAUSE_REASON_IE_INSUFFICIENT = 0x00000008U,
}

enum : uint
{
    CAUSE_PU_PROVIDER = 0x00000000U,
    CAUSE_PU_USER     = 0x00000008U,
    CAUSE_NA_NORMAL   = 0x00000000U,
    CAUSE_NA_ABNORMAL = 0x00000004U,
}

enum : uint
{
    QOS_CLASS0 = 0x00000000U,
    QOS_CLASS1 = 0x00000001U,
    QOS_CLASS2 = 0x00000002U,
    QOS_CLASS3 = 0x00000003U,
    QOS_CLASS4 = 0x00000004U,
}

enum uint TNS_TYPE_NATIONAL = 0x00000040U;
enum uint TNS_PLAN_CARRIER_ID_CODE = 0x00000001U;
enum uint SIO_GET_NUMBER_OF_ATM_DEVICES = 0x50160001U;
enum uint SIO_GET_ATM_ADDRESS = 0xd0160002U;
enum uint SIO_ASSOCIATE_PVC = 0x90160003U;
enum uint SIO_GET_ATM_CONNECTION_ID = 0x50160004U;
enum uint WSPDESCRIPTION_LEN = 0x000000ffU;
enum int WSS_OPERATION_IN_PROGRESS = 0x00000103;
enum uint LSP_SYSTEM = 0x80000000U;
enum uint LSP_INSPECTOR = 0x00000001U;
enum uint LSP_REDIRECTOR = 0x00000002U;

enum : uint
{
    LSP_PROXY    = 0x00000004U,
    LSP_FIREWALL = 0x00000008U,
}

enum uint LSP_INBOUND_MODIFY = 0x00000010U;
enum uint LSP_OUTBOUND_MODIFY = 0x00000020U;
enum uint LSP_CRYPTO_COMPRESS = 0x00000040U;
enum uint LSP_LOCAL_CACHE = 0x00000080U;
enum int UDP_NOCHECKSUM = 0x00000001;
enum int UDP_CHECKSUM_COVERAGE = 0x00000014;
enum uint GAI_STRERROR_BUFFER_SIZE = 0x00000400U;

enum : int
{
    IPX_PTYPE       = 0x00004000,
    IPX_FILTERPTYPE = 0x00004001,
}

enum int IPX_STOPFILTERPTYPE = 0x00004003;
enum int IPX_DSTYPE = 0x00004002;
enum int IPX_EXTENDED_ADDRESS = 0x00004004;
enum int IPX_RECVHDR = 0x00004005;
enum int IPX_MAXSIZE = 0x00004006;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/NetMon2/ipx-address
enum int IPX_ADDRESS = 0x00004007;

enum : int
{
    IPX_GETNETINFO       = 0x00004008,
    IPX_GETNETINFO_NORIP = 0x00004009,
}

enum int IPX_SPXGETCONNECTIONSTATUS = 0x0000400b;
enum int IPX_ADDRESS_NOTIFY = 0x0000400c;
enum int IPX_MAX_ADAPTER_NUM = 0x0000400d;
enum int IPX_RERIPNETNUMBER = 0x0000400e;
enum int IPX_RECEIVE_BROADCAST = 0x0000400f;
enum int IPX_IMMEDIATESPXACK = 0x00004010;
enum uint MAX_MCAST_TTL = 0x000000ffU;
enum int RM_OPTIONSBASE = 0x000003e8;
enum int RM_RATE_WINDOW_SIZE = 0x000003e9;
enum int RM_SET_MESSAGE_BOUNDARY = 0x000003ea;
enum int RM_FLUSHCACHE = 0x000003eb;
enum int RM_SENDER_WINDOW_ADVANCE_METHOD = 0x000003ec;
enum int RM_SENDER_STATISTICS = 0x000003ed;
enum int RM_LATEJOIN = 0x000003ee;
enum int RM_SET_SEND_IF = 0x000003ef;
enum int RM_ADD_RECEIVE_IF = 0x000003f0;
enum int RM_DEL_RECEIVE_IF = 0x000003f1;
enum int RM_SEND_WINDOW_ADV_RATE = 0x000003f2;
enum int RM_USE_FEC = 0x000003f3;
enum int RM_SET_MCAST_TTL = 0x000003f4;
enum int RM_RECEIVER_STATISTICS = 0x000003f5;
enum int RM_HIGH_SPEED_INTRANET_OPT = 0x000003f6;

enum : uint
{
    SENDER_DEFAULT_RATE_KBITS_PER_SEC    = 0x00000038U,
    SENDER_DEFAULT_WINDOW_ADV_PERCENTAGE = 0x0000000fU,
}

enum uint MAX_WINDOW_INCREMENT_PERCENTAGE = 0x00000019U;
enum uint SENDER_DEFAULT_LATE_JOINER_PERCENTAGE = 0x00000000U;
enum uint SENDER_MAX_LATE_JOINER_PERCENTAGE = 0x0000004bU;
enum uint BITS_PER_BYTE = 0x00000008U;
enum uint LOG2_BITS_PER_BYTE = 0x00000003U;
enum uint UNIX_PATH_MAX = 0x0000006cU;

enum : uint
{
    SIO_AF_UNIX_GETPEERPID        = 0x58000100U,
    SIO_AF_UNIX_SETBINDPARENTPATH = 0x98000101U,
    SIO_AF_UNIX_SETCONNPARENTPATH = 0x98000102U,
}

enum : uint
{
    ISOPROTO_TP0       = 0x00000019U,
    ISOPROTO_TP1       = 0x0000001aU,
    ISOPROTO_TP2       = 0x0000001bU,
    ISOPROTO_TP3       = 0x0000001cU,
    ISOPROTO_TP4       = 0x0000001dU,
    ISOPROTO_TP        = 0x0000001dU,
    ISOPROTO_CLTP      = 0x0000001eU,
    ISOPROTO_CLNP      = 0x0000001fU,
    ISOPROTO_X25       = 0x00000020U,
    ISOPROTO_INACT_NL  = 0x00000021U,
    ISOPROTO_ESIS      = 0x00000022U,
    ISOPROTO_INTRAISIS = 0x00000023U,
}

enum uint ISO_MAX_ADDR_LENGTH = 0x00000040U;
enum uint ISO_HIERARCHICAL = 0x00000000U;
enum uint ISO_NON_HIERARCHICAL = 0x00000001U;

enum : uint
{
    ISO_EXP_DATA_USE  = 0x00000000U,
    ISO_EXP_DATA_NUSE = 0x00000001U,
}

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/nsproto-ipx-socket-options
    NSPROTO_IPX   = 0x000003e8U,
    NSPROTO_SPX   = 0x000004e8U,
    NSPROTO_SPXII = 0x000004e9U,
}

enum : uint
{
    NETBIOS_NAME_LENGTH       = 0x00000010U,
    NETBIOS_UNIQUE_NAME       = 0x00000000U,
    NETBIOS_GROUP_NAME        = 0x00000001U,
    NETBIOS_TYPE_QUICK_UNIQUE = 0x00000002U,
    NETBIOS_TYPE_QUICK_GROUP  = 0x00000003U,
}

enum : uint
{
    VNSPROTO_IPC          = 0x00000001U,
    VNSPROTO_RELIABLE_IPC = 0x00000002U,
    VNSPROTO_SPP          = 0x00000003U,
}

enum uint _LITTLE_ENDIAN = 0x000004d2U;
enum uint _BIG_ENDIAN = 0x000010e1U;
enum uint _PDP_ENDIAN = 0x00000d54U;
enum uint BYTE_ORDER = 0x000004d2U;
enum uint DL_ADDRESS_LENGTH_MAXIMUM = 0x00000020U;
enum uint DL_HEADER_LENGTH_MAXIMUM = 0x00000040U;

enum : uint
{
    SNAP_DSAP    = 0x000000aaU,
    SNAP_SSAP    = 0x000000aaU,
    SNAP_CONTROL = 0x00000003U,
    SNAP_OUI     = 0x00000000U,
}

enum : uint
{
    ETH_LENGTH_OF_HEADER      = 0x0000000eU,
    ETH_LENGTH_OF_VLAN_HEADER = 0x00000004U,
    ETH_LENGTH_OF_SNAP_HEADER = 0x00000008U,
}

enum : uint
{
    ETHERNET_TYPE_MINIMUM = 0x00000600U,
    ETHERNET_TYPE_IPV4    = 0x00000800U,
    ETHERNET_TYPE_ARP     = 0x00000806U,
    ETHERNET_TYPE_IPV6    = 0x000086ddU,
    ETHERNET_TYPE_802_1Q  = 0x00008100U,
    ETHERNET_TYPE_802_1AD = 0x000088a8U,
}

enum uint IP_VER_MASK = 0x000000f0U;
enum uint IPV4_VERSION = 0x00000004U;

enum : uint
{
    MAX_IPV4_PACKET = 0x0000ffffU,
    MAX_IPV4_HLEN   = 0x0000003cU,
}

enum : uint
{
    IPV4_MINIMUM_MTU     = 0x00000240U,
    IPV4_MIN_MINIMUM_MTU = 0x00000160U,
}

enum uint IPV4_MAX_MINIMUM_MTU = 0x00000240U;

enum : uint
{
    SIZEOF_IP_OPT_ROUTING_HEADER   = 0x00000003U,
    SIZEOF_IP_OPT_TIMESTAMP_HEADER = 0x00000004U,
    SIZEOF_IP_OPT_SECURITY         = 0x0000000bU,
    SIZEOF_IP_OPT_STREAMIDENTIFIER = 0x00000004U,
    SIZEOF_IP_OPT_ROUTERALERT      = 0x00000004U,
}

enum uint IP4_OFF_MASK = 0x0000ff1fU;
enum uint ICMPV4_INVALID_PREFERENCE_LEVEL = 0x80000000U;
enum uint IGMP_QUERY_TYPE = 0x00000011U;

enum : uint
{
    IGMP_VERSION1_REPORT_TYPE = 0x00000012U,
    IGMP_VERSION2_REPORT_TYPE = 0x00000016U,
}

enum uint IGMP_LEAVE_GROUP_TYPE = 0x00000017U;
enum uint IGMP_VERSION3_REPORT_TYPE = 0x00000022U;

enum : uint
{
    IPV6_VERSION            = 0x00000060U,
    IPV6_TRAFFIC_CLASS_MASK = 0x0000c00fU,
}

enum uint IPV6_FULL_TRAFFIC_CLASS_MASK = 0x0000f00fU;
enum uint IPV6_ECN_MASK = 0x00003000U;
enum uint IPV6_FLOW_LABEL_MASK = 0xffff0f00U;
enum uint MAX_IPV6_PAYLOAD = 0x0000ffffU;
enum uint IPV6_ECN_SHIFT = 0x0000000cU;
enum uint IPV6_MINIMUM_MTU = 0x00000500U;
enum uint IP6F_OFF_MASK = 0x0000f8ffU;
enum uint IP6F_RESERVED_MASK = 0x00000600U;
enum uint IP6F_MORE_FRAG = 0x00000100U;
enum uint EXT_LEN_UNIT = 0x00000008U;

enum : uint
{
    IP6OPT_TYPE_SKIP      = 0x00000000U,
    IP6OPT_TYPE_DISCARD   = 0x00000040U,
    IP6OPT_TYPE_FORCEICMP = 0x00000080U,
    IP6OPT_TYPE_ICMP      = 0x000000c0U,
    IP6OPT_MUTABLE        = 0x00000020U,
}

enum : uint
{
    ICMP6_DST_UNREACH_NOROUTE     = 0x00000000U,
    ICMP6_DST_UNREACH_ADMIN       = 0x00000001U,
    ICMP6_DST_UNREACH_BEYONDSCOPE = 0x00000002U,
    ICMP6_DST_UNREACH_ADDR        = 0x00000003U,
    ICMP6_DST_UNREACH_NOPORT      = 0x00000004U,
}

enum : uint
{
    ICMP6_TIME_EXCEED_TRANSIT    = 0x00000000U,
    ICMP6_TIME_EXCEED_REASSEMBLY = 0x00000001U,
}

enum : uint
{
    ICMP6_PARAMPROB_HEADER        = 0x00000000U,
    ICMP6_PARAMPROB_NEXTHEADER    = 0x00000001U,
    ICMP6_PARAMPROB_OPTION        = 0x00000002U,
    ICMP6_PARAMPROB_FIRSTFRAGMENT = 0x00000003U,
}

enum uint ICMPV6_ECHO_REQUEST_FLAG_REVERSE = 0x00000001U;

enum : uint
{
    ND_RA_FLAG_MANAGED    = 0x00000080U,
    ND_RA_FLAG_OTHER      = 0x00000040U,
    ND_RA_FLAG_HOME_AGENT = 0x00000020U,
    ND_RA_FLAG_PREFERENCE = 0x00000018U,
}

enum : uint
{
    ND_NA_FLAG_ROUTER    = 0x80000000U,
    ND_NA_FLAG_SOLICITED = 0x40000000U,
    ND_NA_FLAG_OVERRIDE  = 0x20000000U,
}

enum : uint
{
    ND_OPT_PI_FLAG_ONLINK      = 0x00000080U,
    ND_OPT_PI_FLAG_AUTO        = 0x00000040U,
    ND_OPT_PI_FLAG_ROUTER_ADDR = 0x00000020U,
    ND_OPT_PI_FLAG_SITE_PREFIX = 0x00000010U,
    ND_OPT_PI_FLAG_ROUTE       = 0x00000001U,
}

enum uint ND_OPT_RI_FLAG_PREFERENCE = 0x00000018U;
enum uint ND_OPT_RDNSS_MIN_LEN = 0x00000018U;
enum uint ND_OPT_DNSSL_MIN_LEN = 0x00000010U;

enum : uint
{
    IN6_EMBEDDEDV4_UOCTET_POSITION = 0x00000008U,
    IN6_EMBEDDEDV4_BITS_IN_BYTE    = 0x00000008U,
}

enum uint TH_MAX_LEN = 0x0000003cU;

enum : uint
{
    TH_FIN                = 0x00000001U,
    TH_SYN                = 0x00000002U,
    TH_RST                = 0x00000004U,
    TH_PSH                = 0x00000008U,
    TH_ACK                = 0x00000010U,
    TH_URG                = 0x00000020U,
    TH_ECE                = 0x00000040U,
    TH_CWR                = 0x00000080U,
    TH_OPT_EOL            = 0x00000000U,
    TH_OPT_NOP            = 0x00000001U,
    TH_OPT_MSS            = 0x00000002U,
    TH_OPT_WS             = 0x00000003U,
    TH_OPT_SACK_PERMITTED = 0x00000004U,
    TH_OPT_SACK           = 0x00000005U,
    TH_OPT_TS             = 0x00000008U,
    TH_OPT_FASTOPEN       = 0x00000022U,
}

enum const(wchar)* NMR_REG_KEY_PATH = "\\Registry\\Machine\\System\\CurrentControlSet\\Control\\NMR\\providers";
enum SOCKET INVALID_SOCKET = SOCKET(0xffffffff);
enum uint WSA_INFINITE = 0xffffffffU;
enum WSAEVENT WSA_INVALID_EVENT = WSAEVENT(0x00000000);
enum uint IOC_INOUT = 0xc0000000U;

enum : int
{
    FIONREAD = 0x4004667f,
    FIONBIO  = 0x8004667e,
    FIOASYNC = 0x8004667d,
}

enum int SIOCSHIWAT = 0x80047300;
enum int SIOCGHIWAT = 0x40047301;
enum int SIOCSLOWAT = 0x80047302;
enum int SIOCGLOWAT = 0x40047303;
enum int SIOCATMARK = 0x40047307;

enum : uint
{
    INADDR_ANY       = 0x00000000U,
    INADDR_BROADCAST = 0xffffffffU,
}

enum int SO_DONTLINGER = 0xffffff7f;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/so-exclusiveaddruse
enum int SO_EXCLUSIVEADDRUSE = 0xfffffffb;
enum int LM_HB_Extension = 0x00000080;

enum : int
{
    LM_HB1_PnP         = 0x00000001,
    LM_HB1_PDA_Palmtop = 0x00000002,
}

enum : int
{
    LM_HB1_Computer  = 0x00000004,
    LM_HB1_Printer   = 0x00000008,
    LM_HB1_Modem     = 0x00000010,
    LM_HB1_Fax       = 0x00000020,
    LM_HB1_LANAccess = 0x00000040,
}

enum : int
{
    LM_HB2_Telephony  = 0x00000001,
    LM_HB2_FileServer = 0x00000002,
}

// Callbacks

alias LPCONDITIONPROC = int function(WSABUF* lpCallerId, WSABUF* lpCallerData, QOS* lpSQOS, QOS* lpGQOS, 
                                     WSABUF* lpCalleeId, WSABUF* lpCalleeData, uint* g, size_t dwCallbackData);
alias LPWSAOVERLAPPED_COMPLETION_ROUTINE = void function(uint dwError, uint cbTransferred, 
                                                         OVERLAPPED* lpOverlapped, uint dwFlags);
alias LPFN_TRANSMITFILE = BOOL function(SOCKET hSocket, HANDLE hFile, uint nNumberOfBytesToWrite, 
                                        uint nNumberOfBytesPerSend, OVERLAPPED* lpOverlapped, 
                                        TRANSMIT_FILE_BUFFERS* lpTransmitBuffers, uint dwReserved);
alias LPFN_ACCEPTEX = BOOL function(SOCKET sListenSocket, SOCKET sAcceptSocket, void* lpOutputBuffer, 
                                    uint dwReceiveDataLength, uint dwLocalAddressLength, uint dwRemoteAddressLength, 
                                    uint* lpdwBytesReceived, OVERLAPPED* lpOverlapped);
alias LPFN_GETACCEPTEXSOCKADDRS = void function(void* lpOutputBuffer, uint dwReceiveDataLength, 
                                                uint dwLocalAddressLength, uint dwRemoteAddressLength, 
                                                SOCKADDR** LocalSockaddr, int* LocalSockaddrLength, 
                                                SOCKADDR** RemoteSockaddr, int* RemoteSockaddrLength);
alias LPFN_TRANSMITPACKETS = BOOL function(SOCKET hSocket, TRANSMIT_PACKETS_ELEMENT* lpPacketArray, 
                                           uint nElementCount, uint nSendSize, OVERLAPPED* lpOverlapped, 
                                           uint dwFlags);
alias LPFN_CONNECTEX = BOOL function(SOCKET s, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(SOCKADDR)* name, 
                                     int namelen, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* lpSendBuffer, 
                                     uint dwSendDataLength, uint* lpdwBytesSent, OVERLAPPED* lpOverlapped);
alias LPFN_DISCONNECTEX = BOOL function(SOCKET s, OVERLAPPED* lpOverlapped, uint dwFlags, uint dwReserved);
alias LPFN_WSARECVMSG = int function(SOCKET s, WSAMSG* lpMsg, uint* lpdwNumberOfBytesRecvd, 
                                     OVERLAPPED* lpOverlapped, 
                                     LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);
alias LPFN_WSASENDMSG = int function(SOCKET s, WSAMSG* lpMsg, uint dwFlags, uint* lpNumberOfBytesSent, 
                                     OVERLAPPED* lpOverlapped, 
                                     LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);
alias LPFN_WSAPOLL = int function(WSAPOLLFD* fdarray, uint nfds, int timeout);
alias LPFN_RIORECEIVE = BOOL function(RIO_RQ SocketQueue, RIO_BUF* pData, uint DataBufferCount, uint Flags, 
                                      void* RequestContext);
alias LPFN_RIORECEIVEEX = int function(RIO_RQ SocketQueue, RIO_BUF* pData, uint DataBufferCount, 
                                       RIO_BUF* pLocalAddress, RIO_BUF* pRemoteAddress, RIO_BUF* pControlContext, 
                                       RIO_BUF* pFlags, uint Flags, void* RequestContext);
alias LPFN_RIOSEND = BOOL function(RIO_RQ SocketQueue, RIO_BUF* pData, uint DataBufferCount, uint Flags, 
                                   void* RequestContext);
alias LPFN_RIOSENDEX = BOOL function(RIO_RQ SocketQueue, RIO_BUF* pData, uint DataBufferCount, 
                                     RIO_BUF* pLocalAddress, RIO_BUF* pRemoteAddress, RIO_BUF* pControlContext, 
                                     RIO_BUF* pFlags, uint Flags, void* RequestContext);
alias LPFN_RIOCLOSECOMPLETIONQUEUE = void function(RIO_CQ CQ);
alias LPFN_RIOCREATECOMPLETIONQUEUE = RIO_CQ function(uint QueueSize, 
                                                      RIO_NOTIFICATION_COMPLETION* NotificationCompletion);
alias LPFN_RIOCREATEREQUESTQUEUE = RIO_RQ function(SOCKET Socket, uint MaxOutstandingReceive, 
                                                   uint MaxReceiveDataBuffers, uint MaxOutstandingSend, 
                                                   uint MaxSendDataBuffers, RIO_CQ ReceiveCQ, RIO_CQ SendCQ, 
                                                   void* SocketContext);
alias LPFN_RIODEQUEUECOMPLETION = uint function(RIO_CQ CQ, RIORESULT* Array, uint ArraySize);
alias LPFN_RIODEREGISTERBUFFER = void function(RIO_BUFFERID BufferId);
alias LPFN_RIONOTIFY = int function(RIO_CQ CQ);
alias LPFN_RIOREGISTERBUFFER = RIO_BUFFERID function(/*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR DataBuffer, 
                                                     uint DataLength);
alias LPFN_RIORESIZECOMPLETIONQUEUE = BOOL function(RIO_CQ CQ, uint QueueSize);
alias LPFN_RIORESIZEREQUESTQUEUE = BOOL function(RIO_RQ RQ, uint MaxOutstandingReceive, uint MaxOutstandingSend);
alias LPBLOCKINGCALLBACK = BOOL function(size_t dwContext);
alias LPWSAUSERAPC = void function(size_t dwContext);
alias LPWSPACCEPT = SOCKET function(SOCKET s, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/SOCKADDR* addr, 
                                    int* addrlen, LPCONDITIONPROC lpfnCondition, size_t dwCallbackData, int* lpErrno);
alias LPWSPADDRESSTOSTRING = int function(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/SOCKADDR* lpsaAddress, 
                                          uint dwAddressLength, WSAPROTOCOL_INFOW* lpProtocolInfo, 
                                          PWSTR lpszAddressString, uint* lpdwAddressStringLength, int* lpErrno);
alias LPWSPASYNCSELECT = int function(SOCKET s, HWND hWnd, uint wMsg, int lEvent, int* lpErrno);
alias LPWSPBIND = int function(SOCKET s, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(SOCKADDR)* name, 
                               int namelen, int* lpErrno);
alias LPWSPCANCELBLOCKINGCALL = int function(int* lpErrno);
alias LPWSPCLEANUP = int function(int* lpErrno);
alias LPWSPCLOSESOCKET = int function(SOCKET s, int* lpErrno);
alias LPWSPCONNECT = int function(SOCKET s, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(SOCKADDR)* name, 
                                  int namelen, WSABUF* lpCallerData, WSABUF* lpCalleeData, QOS* lpSQOS, QOS* lpGQOS, 
                                  int* lpErrno);
alias LPWSPDUPLICATESOCKET = int function(SOCKET s, uint dwProcessId, WSAPROTOCOL_INFOW* lpProtocolInfo, 
                                          int* lpErrno);
alias LPWSPENUMNETWORKEVENTS = int function(SOCKET s, HANDLE hEventObject, WSANETWORKEVENTS* lpNetworkEvents, 
                                            int* lpErrno);
alias LPWSPEVENTSELECT = int function(SOCKET s, WSAEVENT hEventObject, int lNetworkEvents, int* lpErrno);
alias LPWSPGETOVERLAPPEDRESULT = BOOL function(SOCKET s, OVERLAPPED* lpOverlapped, uint* lpcbTransfer, BOOL fWait, 
                                               uint* lpdwFlags, int* lpErrno);
alias LPWSPGETPEERNAME = int function(SOCKET s, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/SOCKADDR* name, 
                                      int* namelen, int* lpErrno);
alias LPWSPGETSOCKNAME = int function(SOCKET s, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/SOCKADDR* name, 
                                      int* namelen, int* lpErrno);
alias LPWSPGETSOCKOPT = int function(SOCKET s, int level, int optname, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/PSTR optval, 
                                     int* optlen, int* lpErrno);
alias LPWSPGETQOSBYNAME = BOOL function(SOCKET s, WSABUF* lpQOSName, QOS* lpQOS, int* lpErrno);
alias LPWSPIOCTL = int function(SOCKET s, uint dwIoControlCode, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpvInBuffer, 
                                uint cbInBuffer, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* lpvOutBuffer, 
                                uint cbOutBuffer, uint* lpcbBytesReturned, OVERLAPPED* lpOverlapped, 
                                LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine, WSATHREADID* lpThreadId, 
                                int* lpErrno);
alias LPWSPJOINLEAF = SOCKET function(SOCKET s, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(SOCKADDR)* name, 
                                      int namelen, WSABUF* lpCallerData, WSABUF* lpCalleeData, QOS* lpSQOS, 
                                      QOS* lpGQOS, uint dwFlags, int* lpErrno);
alias LPWSPLISTEN = int function(SOCKET s, int backlog, int* lpErrno);
alias LPWSPRECV = int function(SOCKET s, WSABUF* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesRecvd, 
                               uint* lpFlags, OVERLAPPED* lpOverlapped, 
                               LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine, WSATHREADID* lpThreadId, 
                               int* lpErrno);
alias LPWSPRECVDISCONNECT = int function(SOCKET s, WSABUF* lpInboundDisconnectData, int* lpErrno);
alias LPWSPRECVFROM = int function(SOCKET s, WSABUF* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesRecvd, 
                                   uint* lpFlags, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/SOCKADDR* lpFrom, 
                                   int* lpFromlen, OVERLAPPED* lpOverlapped, 
                                   LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine, WSATHREADID* lpThreadId, 
                                   int* lpErrno);
alias LPWSPSELECT = int function(int nfds, FD_SET* readfds, FD_SET* writefds, FD_SET* exceptfds, 
                                 const(TIMEVAL)* timeout, int* lpErrno);
alias LPWSPSEND = int function(SOCKET s, WSABUF* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesSent, 
                               uint dwFlags, OVERLAPPED* lpOverlapped, 
                               LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine, WSATHREADID* lpThreadId, 
                               int* lpErrno);
alias LPWSPSENDDISCONNECT = int function(SOCKET s, WSABUF* lpOutboundDisconnectData, int* lpErrno);
alias LPWSPSENDTO = int function(SOCKET s, WSABUF* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesSent, 
                                 uint dwFlags, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/const(SOCKADDR)* lpTo, 
                                 int iTolen, OVERLAPPED* lpOverlapped, 
                                 LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine, WSATHREADID* lpThreadId, 
                                 int* lpErrno);
alias LPWSPSETSOCKOPT = int function(SOCKET s, int level, int optname, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(PSTR) optval, 
                                     int optlen, int* lpErrno);
alias LPWSPSHUTDOWN = int function(SOCKET s, int how, int* lpErrno);
alias LPWSPSOCKET = SOCKET function(int af, int type, int protocol, WSAPROTOCOL_INFOW* lpProtocolInfo, uint g, 
                                    uint dwFlags, int* lpErrno);
alias LPWSPSTRINGTOADDRESS = int function(PWSTR AddressString, int AddressFamily, 
                                          WSAPROTOCOL_INFOW* lpProtocolInfo, 
                                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/SOCKADDR* lpAddress, 
                                          int* lpAddressLength, int* lpErrno);
alias LPWPUCLOSEEVENT = BOOL function(WSAEVENT hEvent, int* lpErrno);
alias LPWPUCLOSESOCKETHANDLE = int function(SOCKET s, int* lpErrno);
alias LPWPUCREATEEVENT = WSAEVENT function(int* lpErrno);
alias LPWPUCREATESOCKETHANDLE = SOCKET function(uint dwCatalogEntryId, size_t dwContext, int* lpErrno);
alias LPWPUFDISSET = int function(SOCKET s, FD_SET* fdset);
alias LPWPUGETPROVIDERPATH = int function(GUID* lpProviderId, PWSTR lpszProviderDllPath, int* lpProviderDllPathLen, 
                                          int* lpErrno);
alias LPWPUMODIFYIFSHANDLE = SOCKET function(uint dwCatalogEntryId, SOCKET ProposedHandle, int* lpErrno);
alias LPWPUPOSTMESSAGE = BOOL function(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);
alias LPWPUQUERYBLOCKINGCALLBACK = int function(uint dwCatalogEntryId, LPBLOCKINGCALLBACK* lplpfnCallback, 
                                                size_t* lpdwContext, int* lpErrno);
alias LPWPUQUERYSOCKETHANDLECONTEXT = int function(SOCKET s, size_t* lpContext, int* lpErrno);
alias LPWPUQUEUEAPC = int function(WSATHREADID* lpThreadId, LPWSAUSERAPC lpfnUserApc, size_t dwContext, 
                                   int* lpErrno);
alias LPWPURESETEVENT = BOOL function(WSAEVENT hEvent, int* lpErrno);
alias LPWPUSETEVENT = BOOL function(WSAEVENT hEvent, int* lpErrno);
alias LPWPUOPENCURRENTTHREAD = int function(WSATHREADID* lpThreadId, int* lpErrno);
alias LPWPUCLOSETHREAD = int function(WSATHREADID* lpThreadId, int* lpErrno);
alias LPWPUCOMPLETEOVERLAPPEDREQUEST = int function(SOCKET s, OVERLAPPED* lpOverlapped, uint dwError, 
                                                    uint cbTransferred, int* lpErrno);
alias LPWSPSTARTUP = int function(ushort wVersionRequested, WSPDATA* lpWSPData, WSAPROTOCOL_INFOW* lpProtocolInfo, 
                                  WSPUPCALLTABLE UpcallTable, WSPPROC_TABLE* lpProcTable);
alias LPWSCENUMPROTOCOLS = int function(int* lpiProtocols, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WSAPROTOCOL_INFOW* lpProtocolBuffer, 
                                        uint* lpdwBufferLength, int* lpErrno);
alias LPWSCDEINSTALLPROVIDER = int function(GUID* lpProviderId, int* lpErrno);
alias LPWSCINSTALLPROVIDER = int function(GUID* lpProviderId, const(PWSTR) lpszProviderDllPath, 
                                          const(WSAPROTOCOL_INFOW)* lpProtocolInfoList, uint dwNumberOfEntries, 
                                          int* lpErrno);
alias LPWSCGETPROVIDERPATH = int function(GUID* lpProviderId, PWSTR lpszProviderDllPath, int* lpProviderDllPathLen, 
                                          int* lpErrno);
alias LPWSCUPDATEPROVIDER = int function(GUID* lpProviderId, const(PWSTR) lpszProviderDllPath, 
                                         const(WSAPROTOCOL_INFOW)* lpProtocolInfoList, uint dwNumberOfEntries, 
                                         int* lpErrno);
alias LPWSCINSTALLNAMESPACE = int function(PWSTR lpszIdentifier, PWSTR lpszPathName, uint dwNameSpace, 
                                           uint dwVersion, GUID* lpProviderId);
alias LPWSCUNINSTALLNAMESPACE = int function(GUID* lpProviderId);
alias LPWSCENABLENSPROVIDER = int function(GUID* lpProviderId, BOOL fEnable);
alias LPNSPCLEANUP = int function(GUID* lpProviderId);
alias LPNSPLOOKUPSERVICEBEGIN = int function(GUID* lpProviderId, WSAQUERYSETW* lpqsRestrictions, 
                                             WSASERVICECLASSINFOW* lpServiceClassInfo, uint dwControlFlags, 
                                             HANDLE* lphLookup);
alias LPNSPLOOKUPSERVICENEXT = int function(HANDLE hLookup, uint dwControlFlags, uint* lpdwBufferLength, 
                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WSAQUERYSETW* lpqsResults);
alias LPNSPIOCTL = int function(HANDLE hLookup, uint dwControlCode, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpvInBuffer, 
                                uint cbInBuffer, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* lpvOutBuffer, 
                                uint cbOutBuffer, uint* lpcbBytesReturned, WSACOMPLETION* lpCompletion, 
                                WSATHREADID* lpThreadId);
alias LPNSPLOOKUPSERVICEEND = int function(HANDLE hLookup);
alias LPNSPSETSERVICE = int function(GUID* lpProviderId, WSASERVICECLASSINFOW* lpServiceClassInfo, 
                                     WSAQUERYSETW* lpqsRegInfo, WSAESETSERVICEOP essOperation, uint dwControlFlags);
alias LPNSPINSTALLSERVICECLASS = int function(GUID* lpProviderId, WSASERVICECLASSINFOW* lpServiceClassInfo);
alias LPNSPREMOVESERVICECLASS = int function(GUID* lpProviderId, GUID* lpServiceClassId);
alias LPNSPGETSERVICECLASSINFO = int function(GUID* lpProviderId, uint* lpdwBufSize, 
                                              WSASERVICECLASSINFOW* lpServiceClassInfo);
alias LPNSPSTARTUP = int function(GUID* lpProviderId, NSP_ROUTINE* lpnspRoutines);
alias LPNSPV2STARTUP = int function(GUID* lpProviderId, void** ppvClientSessionArg);
alias LPNSPV2CLEANUP = int function(GUID* lpProviderId, void* pvClientSessionArg);
alias LPNSPV2LOOKUPSERVICEBEGIN = int function(GUID* lpProviderId, WSAQUERYSET2W* lpqsRestrictions, 
                                               uint dwControlFlags, void* lpvClientSessionArg, HANDLE* lphLookup);
alias LPNSPV2LOOKUPSERVICENEXTEX = void function(HANDLE hAsyncCall, HANDLE hLookup, uint dwControlFlags, 
                                                 uint* lpdwBufferLength, WSAQUERYSET2W* lpqsResults);
alias LPNSPV2LOOKUPSERVICEEND = int function(HANDLE hLookup);
alias LPNSPV2SETSERVICEEX = void function(HANDLE hAsyncCall, GUID* lpProviderId, WSAQUERYSET2W* lpqsRegInfo, 
                                          WSAESETSERVICEOP essOperation, uint dwControlFlags, 
                                          void* lpvClientSessionArg);
alias LPNSPV2CLIENTSESSIONRUNDOWN = void function(GUID* lpProviderId, void* pvClientSessionArg);
alias LPFN_NSPAPI = uint function();
alias LPSERVICE_CALLBACK_PROC = void function(LPARAM lParam, HANDLE hAsyncTaskHandle);
alias LPLOOKUPSERVICE_COMPLETION_ROUTINE = void function(uint dwError, uint dwBytes, OVERLAPPED* lpOverlapped);
alias LPWSCWRITEPROVIDERORDER = int function(uint* lpwdCatalogEntryId, uint dwNumberOfEntries);
alias LPWSCWRITENAMESPACEORDER = int function(GUID* lpProviderId, uint dwNumberOfEntries);

// Structs


@RAIIFree!WSACloseEvent
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct WSAEVENT
{
    ptrdiff_t Value;
}

@RAIIFree!closesocket
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
struct SOCKET
{
    size_t Value;
}

struct socklen_t
{
    int Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/rio-bufferid
struct RIO_BUFFERID
{
    ptrdiff_t Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/riocqueue
struct RIO_CQ
{
    ptrdiff_t Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/WinSock/riorqueue
struct RIO_RQ
{
    ptrdiff_t Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/qos/ns-qos-flowspec
struct FLOWSPEC
{
    uint TokenRate;
    uint TokenBucketSize;
    uint PeakBandwidth;
    uint Latency;
    uint DelayVariation;
    uint ServiceType;
    uint MaxSduSize;
    uint MinimumPolicedSize;
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock/ns-winsock-servent
    struct SERVENT
    {
        PSTR   s_name;
        byte** s_aliases;
        PSTR   s_proto;
        short  s_port;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock/ns-winsock-servent
    struct SERVENT
    {
        PSTR   s_name;
        byte** s_aliases;
        PSTR   s_proto;
        short  s_port;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock/ns-winsock-wsadata
    struct WSADATA
    {
        ushort    wVersion;
        ushort    wHighVersion;
        ushort    iMaxSockets;
        ushort    iMaxUdpDg;
        PSTR      lpVendorInfo;
        CHAR[257] szDescription;
        CHAR[129] szSystemStatus;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock/ns-winsock-wsadata
    struct WSADATA
    {
        ushort    wVersion;
        ushort    wHighVersion;
        ushort    iMaxSockets;
        ushort    iMaxUdpDg;
        PSTR      lpVendorInfo;
        CHAR[257] szDescription;
        CHAR[129] szSystemStatus;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/inaddr/ns-inaddr-in_addr
struct IN_ADDR
{
    union S_un
    {
        struct S_un_b
        {
            ubyte s_b1;
            ubyte s_b2;
            ubyte s_b3;
            ubyte s_b4;
        }
        struct S_un_w
        {
            ushort s_w1;
            ushort s_w2;
        }
        uint S_addr;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock/ns-winsock-sockaddr
struct SOCKADDR
{
    ADDRESS_FAMILY sa_family;
    CHAR[14]       sa_data;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-socket_address
struct SOCKET_ADDRESS
{
    SOCKADDR* lpSockaddr;
    int       iSockaddrLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-socket_address_list
struct SOCKET_ADDRESS_LIST
{
    int               iAddressCount;
    SOCKET_ADDRESS[1] Address; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nspapi/ns-nspapi-csaddr_info
struct CSADDR_INFO
{
    SOCKET_ADDRESS LocalAddr;
    SOCKET_ADDRESS RemoteAddr;
    int            iSocketType;
    int            iProtocol;
}

struct SOCKADDR_STORAGE
{
    ADDRESS_FAMILY ss_family;
    CHAR[6]        __ss_pad1;
    long           __ss_align;
    CHAR[112]      __ss_pad2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-sockaddr_storage_xp
struct SOCKADDR_STORAGE_XP
{
    short     ss_family;
    CHAR[6]   __ss_pad1;
    long      __ss_align;
    CHAR[112] __ss_pad2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-socket_processor_affinity
struct SOCKET_PROCESSOR_AFFINITY
{
    PROCESSOR_NUMBER Processor;
    ushort           NumaNodeId;
    ushort           Reserved;
}

struct SCOPE_ID
{
    union
    {
        struct
        {
            // Native bit field: Zone: [0-27], Level: [28-31]
            uint _bitfield0;
        }
        uint Value;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock/ns-winsock-sockaddr_in
struct SOCKADDR_IN
{
    ADDRESS_FAMILY sin_family;
    ushort         sin_port;
    IN_ADDR        sin_addr;
    CHAR[8]        sin_zero;
}

struct SOCKADDR_DL
{
    ADDRESS_FAMILY sdl_family;
    ubyte[8]       sdl_data;
    ubyte[4]       sdl_zero;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-wsabuf
struct WSABUF
{
    uint len;
    PSTR buf;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-wsamsg
struct WSAMSG
{
    SOCKADDR* name;
    int       namelen;
    WSABUF*   lpBuffers;
    uint      dwBufferCount;
    WSABUF    Control;
    uint      dwFlags;
}

struct CMSGHDR
{
    size_t cmsg_len;
    int    cmsg_level;
    int    cmsg_type;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-addrinfoa
struct ADDRINFOA
{
    int        ai_flags;
    int        ai_family;
    int        ai_socktype;
    int        ai_protocol;
    size_t     ai_addrlen;
    PSTR       ai_canonname;
    SOCKADDR*  ai_addr;
    ADDRINFOA* ai_next;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-addrinfow
struct ADDRINFOW
{
    int        ai_flags;
    int        ai_family;
    int        ai_socktype;
    int        ai_protocol;
    size_t     ai_addrlen;
    PWSTR      ai_canonname;
    SOCKADDR*  ai_addr;
    ADDRINFOW* ai_next;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-addrinfoexa
deprecated("ADDRINFOEXW") 
struct ADDRINFOEXA
{
    int          ai_flags;
    int          ai_family;
    int          ai_socktype;
    int          ai_protocol;
    size_t       ai_addrlen;
    PSTR         ai_canonname;
    SOCKADDR*    ai_addr;
    void*        ai_blob;
    size_t       ai_bloblen;
    GUID*        ai_provider;
    ADDRINFOEXA* ai_next;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-addrinfoexw
struct ADDRINFOEXW
{
    int          ai_flags;
    int          ai_family;
    int          ai_socktype;
    int          ai_protocol;
    size_t       ai_addrlen;
    PWSTR        ai_canonname;
    SOCKADDR*    ai_addr;
    void*        ai_blob;
    size_t       ai_bloblen;
    GUID*        ai_provider;
    ADDRINFOEXW* ai_next;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-addrinfoex2a
deprecated("ADDRINFOEX2W") 
struct ADDRINFOEX2A
{
    int           ai_flags;
    int           ai_family;
    int           ai_socktype;
    int           ai_protocol;
    size_t        ai_addrlen;
    PSTR          ai_canonname;
    SOCKADDR*     ai_addr;
    void*         ai_blob;
    size_t        ai_bloblen;
    GUID*         ai_provider;
    ADDRINFOEX2A* ai_next;
    int           ai_version;
    PSTR          ai_fqdn;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-addrinfoex2w
struct ADDRINFOEX2W
{
    int           ai_flags;
    int           ai_family;
    int           ai_socktype;
    int           ai_protocol;
    size_t        ai_addrlen;
    PWSTR         ai_canonname;
    SOCKADDR*     ai_addr;
    void*         ai_blob;
    size_t        ai_bloblen;
    GUID*         ai_provider;
    ADDRINFOEX2W* ai_next;
    int           ai_version;
    PWSTR         ai_fqdn;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-addrinfoex3
struct ADDRINFOEX3
{
    int          ai_flags;
    int          ai_family;
    int          ai_socktype;
    int          ai_protocol;
    size_t       ai_addrlen;
    PWSTR        ai_canonname;
    SOCKADDR*    ai_addr;
    void*        ai_blob;
    size_t       ai_bloblen;
    GUID*        ai_provider;
    ADDRINFOEX3* ai_next;
    int          ai_version;
    PWSTR        ai_fqdn;
    int          ai_interfaceindex;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-addrinfoex4
struct ADDRINFOEX4
{
    int          ai_flags;
    int          ai_family;
    int          ai_socktype;
    int          ai_protocol;
    size_t       ai_addrlen;
    PWSTR        ai_canonname;
    SOCKADDR*    ai_addr;
    void*        ai_blob;
    size_t       ai_bloblen;
    GUID*        ai_provider;
    ADDRINFOEX4* ai_next;
    int          ai_version;
    PWSTR        ai_fqdn;
    int          ai_interfaceindex;
    HANDLE       ai_resolutionhandle;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-addrinfoex5
struct ADDRINFOEX5
{
    int          ai_flags;
    int          ai_family;
    int          ai_socktype;
    int          ai_protocol;
    size_t       ai_addrlen;
    PWSTR        ai_canonname;
    SOCKADDR*    ai_addr;
    void*        ai_blob;
    size_t       ai_bloblen;
    GUID*        ai_provider;
    ADDRINFOEX5* ai_next;
    int          ai_version;
    PWSTR        ai_fqdn;
    int          ai_interfaceindex;
    HANDLE       ai_resolutionhandle;
    uint         ai_ttl;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-addrinfo_dns_server
struct ADDRINFO_DNS_SERVER
{
    uint      ai_servertype;
    ulong     ai_flags;
    uint      ai_addrlen;
    SOCKADDR* ai_addr;
    union
    {
        PWSTR ai_template;
        PWSTR ai_hostname;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2def/ns-ws2def-addrinfoex6
struct ADDRINFOEX6
{
    int                  ai_flags;
    int                  ai_family;
    int                  ai_socktype;
    int                  ai_protocol;
    size_t               ai_addrlen;
    PWSTR                ai_canonname;
    SOCKADDR*            ai_addr;
    void*                ai_blob;
    size_t               ai_bloblen;
    GUID*                ai_provider;
    ADDRINFOEX5*         ai_next;
    int                  ai_version;
    PWSTR                ai_fqdn;
    int                  ai_interfaceindex;
    HANDLE               ai_resolutionhandle;
    uint                 ai_ttl;
    uint                 ai_numservers;
    ADDRINFO_DNS_SERVER* ai_servers;
    ulong                ai_responseflags;
}

struct ADDRINFOEX7
{
    int                  ai_flags;
    int                  ai_family;
    int                  ai_socktype;
    int                  ai_protocol;
    size_t               ai_addrlen;
    PWSTR                ai_canonname;
    SOCKADDR*            ai_addr;
    void*                ai_blob;
    size_t               ai_bloblen;
    GUID*                ai_provider;
    ADDRINFOEX7*         ai_next;
    int                  ai_version;
    PWSTR                ai_fqdn;
    int                  ai_interfaceindex;
    HANDLE               ai_resolutionhandle;
    uint                 ai_ttl;
    uint                 ai_numservers;
    ADDRINFO_DNS_SERVER* ai_servers;
    ulong                ai_responseflags;
    ulong                ai_extraflags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock/nf-winsock-fd_set
struct FD_SET
{
    uint       fd_count;
    SOCKET[64] fd_array;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock/ns-winsock-timeval
struct TIMEVAL
{
    int tv_sec;
    int tv_usec;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock/ns-winsock-hostent
struct HOSTENT
{
    PSTR   h_name;
    byte** h_aliases;
    short  h_addrtype;
    short  h_length;
    byte** h_addr_list;
}

struct netent
{
    PSTR   n_name;
    byte** n_aliases;
    short  n_addrtype;
    uint   n_net;
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock/ns-winsock-servent
    struct SERVENT
    {
        PSTR   s_name;
        byte** s_aliases;
        short  s_port;
        PSTR   s_proto;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock/ns-winsock-protoent
struct PROTOENT
{
    PSTR   p_name;
    byte** p_aliases;
    short  p_proto;
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock/ns-winsock-wsadata
    struct WSADATA
    {
        ushort    wVersion;
        ushort    wHighVersion;
        CHAR[257] szDescription;
        CHAR[129] szSystemStatus;
        ushort    iMaxSockets;
        ushort    iMaxUdpDg;
        PSTR      lpVendorInfo;
    }
}

struct sockproto
{
    ushort sp_family;
    ushort sp_protocol;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock/ns-winsock-linger
struct LINGER
{
    ushort l_onoff;
    ushort l_linger;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-qos
struct QOS
{
    FLOWSPEC SendingFlowspec;
    FLOWSPEC ReceivingFlowspec;
    WSABUF   ProviderSpecific;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsanetworkevents
struct WSANETWORKEVENTS
{
    int     lNetworkEvents;
    int[10] iErrorCode;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsaprotocolchain
struct WSAPROTOCOLCHAIN
{
    int     ChainLen;
    uint[7] ChainEntries;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsaprotocol_infoa
deprecated("WSAPROTOCOL_INFOW") 
struct WSAPROTOCOL_INFOA
{
    uint             dwServiceFlags1;
    uint             dwServiceFlags2;
    uint             dwServiceFlags3;
    uint             dwServiceFlags4;
    uint             dwProviderFlags;
    GUID             ProviderId;
    uint             dwCatalogEntryId;
    WSAPROTOCOLCHAIN ProtocolChain;
    int              iVersion;
    int              iAddressFamily;
    int              iMaxSockAddr;
    int              iMinSockAddr;
    int              iSocketType;
    int              iProtocol;
    int              iProtocolMaxOffset;
    int              iNetworkByteOrder;
    int              iSecurityScheme;
    uint             dwMessageSize;
    uint             dwProviderReserved;
    CHAR[256]        szProtocol;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsaprotocol_infow
struct WSAPROTOCOL_INFOW
{
    uint             dwServiceFlags1;
    uint             dwServiceFlags2;
    uint             dwServiceFlags3;
    uint             dwServiceFlags4;
    uint             dwProviderFlags;
    GUID             ProviderId;
    uint             dwCatalogEntryId;
    WSAPROTOCOLCHAIN ProtocolChain;
    int              iVersion;
    int              iAddressFamily;
    int              iMaxSockAddr;
    int              iMinSockAddr;
    int              iSocketType;
    int              iProtocol;
    int              iProtocolMaxOffset;
    int              iNetworkByteOrder;
    int              iSecurityScheme;
    uint             dwMessageSize;
    uint             dwProviderReserved;
    wchar[256]       szProtocol;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsacompletion
struct WSACOMPLETION
{
    WSACOMPLETIONTYPE Type;
    union Parameters
    {
        struct WindowMessage
        {
            HWND   hWnd;
            uint   uMsg;
            WPARAM context;
        }
        struct Event
        {
            OVERLAPPED* lpOverlapped;
        }
        struct Apc
        {
            OVERLAPPED* lpOverlapped;
            LPWSAOVERLAPPED_COMPLETION_ROUTINE lpfnCompletionProc;
        }
        struct Port
        {
            OVERLAPPED* lpOverlapped;
            HANDLE      hPort;
            size_t      Key;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-afprotocols
struct AFPROTOCOLS
{
    int iAddressFamily;
    int iProtocol;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsaversion
struct WSAVERSION
{
    uint           dwVersion;
    WSAECOMPARATOR ecHow;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsaqueryseta
deprecated("WSAQUERYSETW") 
struct WSAQUERYSETA
{
    uint         dwSize;
    PSTR         lpszServiceInstanceName;
    GUID*        lpServiceClassId;
    WSAVERSION*  lpVersion;
    PSTR         lpszComment;
    uint         dwNameSpace;
    GUID*        lpNSProviderId;
    PSTR         lpszContext;
    uint         dwNumberOfProtocols;
    AFPROTOCOLS* lpafpProtocols;
    PSTR         lpszQueryString;
    uint         dwNumberOfCsAddrs;
    CSADDR_INFO* lpcsaBuffer;
    uint         dwOutputFlags;
    BLOB*        lpBlob;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsaquerysetw
struct WSAQUERYSETW
{
    uint         dwSize;
    PWSTR        lpszServiceInstanceName;
    GUID*        lpServiceClassId;
    WSAVERSION*  lpVersion;
    PWSTR        lpszComment;
    uint         dwNameSpace;
    GUID*        lpNSProviderId;
    PWSTR        lpszContext;
    uint         dwNumberOfProtocols;
    AFPROTOCOLS* lpafpProtocols;
    PWSTR        lpszQueryString;
    uint         dwNumberOfCsAddrs;
    CSADDR_INFO* lpcsaBuffer;
    uint         dwOutputFlags;
    BLOB*        lpBlob;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsaqueryset2a
deprecated("WSAQUERYSET2W") 
struct WSAQUERYSET2A
{
    uint         dwSize;
    PSTR         lpszServiceInstanceName;
    WSAVERSION*  lpVersion;
    PSTR         lpszComment;
    uint         dwNameSpace;
    GUID*        lpNSProviderId;
    PSTR         lpszContext;
    uint         dwNumberOfProtocols;
    AFPROTOCOLS* lpafpProtocols;
    PSTR         lpszQueryString;
    uint         dwNumberOfCsAddrs;
    CSADDR_INFO* lpcsaBuffer;
    uint         dwOutputFlags;
    BLOB*        lpBlob;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsaqueryset2w
struct WSAQUERYSET2W
{
    uint         dwSize;
    PWSTR        lpszServiceInstanceName;
    WSAVERSION*  lpVersion;
    PWSTR        lpszComment;
    uint         dwNameSpace;
    GUID*        lpNSProviderId;
    PWSTR        lpszContext;
    uint         dwNumberOfProtocols;
    AFPROTOCOLS* lpafpProtocols;
    PWSTR        lpszQueryString;
    uint         dwNumberOfCsAddrs;
    CSADDR_INFO* lpcsaBuffer;
    uint         dwOutputFlags;
    BLOB*        lpBlob;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsansclassinfoa
deprecated("WSANSCLASSINFOW") 
struct WSANSCLASSINFOA
{
    PSTR  lpszName;
    uint  dwNameSpace;
    uint  dwValueType;
    uint  dwValueSize;
    void* lpValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsansclassinfow
struct WSANSCLASSINFOW
{
    PWSTR lpszName;
    uint  dwNameSpace;
    uint  dwValueType;
    uint  dwValueSize;
    void* lpValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsaserviceclassinfoa
deprecated("WSASERVICECLASSINFOW") 
struct WSASERVICECLASSINFOA
{
    GUID*            lpServiceClassId;
    PSTR             lpszServiceClassName;
    uint             dwCount;
    WSANSCLASSINFOA* lpClassInfos;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsaserviceclassinfow
struct WSASERVICECLASSINFOW
{
    GUID*            lpServiceClassId;
    PWSTR            lpszServiceClassName;
    uint             dwCount;
    WSANSCLASSINFOW* lpClassInfos;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsanamespace_infoa
deprecated("WSANAMESPACE_INFOW") 
struct WSANAMESPACE_INFOA
{
    GUID NSProviderId;
    uint dwNameSpace;
    BOOL fActive;
    uint dwVersion;
    PSTR lpszIdentifier;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsanamespace_infow
struct WSANAMESPACE_INFOW
{
    GUID  NSProviderId;
    uint  dwNameSpace;
    BOOL  fActive;
    uint  dwVersion;
    PWSTR lpszIdentifier;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsanamespace_infoexa
deprecated("WSANAMESPACE_INFOEXW") 
struct WSANAMESPACE_INFOEXA
{
    GUID NSProviderId;
    uint dwNameSpace;
    BOOL fActive;
    uint dwVersion;
    PSTR lpszIdentifier;
    BLOB ProviderSpecific;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsanamespace_infoexw
struct WSANAMESPACE_INFOEXW
{
    GUID  NSProviderId;
    uint  dwNameSpace;
    BOOL  fActive;
    uint  dwVersion;
    PWSTR lpszIdentifier;
    BLOB  ProviderSpecific;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-wsapollfd
struct WSAPOLLFD
{
    SOCKET              fd;
    WSAPOLL_EVENT_FLAGS events;
    WSAPOLL_EVENT_FLAGS revents;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock2/ns-winsock2-sock_notify_registration
struct SOCK_NOTIFY_REGISTRATION
{
    SOCKET socket;
    void*  completionKey;
    ushort eventFilter;
    ubyte  operation;
    ubyte  triggerFlags;
    uint   registrationResult;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/in6addr/ns-in6addr-in6_addr
struct IN6_ADDR
{
    union u
    {
        ubyte[16] Byte;
        ushort[8] Word;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-sockaddr_in6_old
struct sockaddr_in6_old
{
    short    sin6_family;
    ushort   sin6_port;
    uint     sin6_flowinfo;
    IN6_ADDR sin6_addr;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-sockaddr_gen
union sockaddr_gen
{
    SOCKADDR         Address;
    SOCKADDR_IN      AddressIn;
    sockaddr_in6_old AddressIn6;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-interface_info
struct INTERFACE_INFO
{
    uint         iiFlags;
    sockaddr_gen iiAddress;
    sockaddr_gen iiBroadcastAddress;
    sockaddr_gen iiNetmask;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-interface_info_ex
struct INTERFACE_INFO_EX
{
    uint           iiFlags;
    SOCKET_ADDRESS iiAddress;
    SOCKET_ADDRESS iiBroadcastAddress;
    SOCKET_ADDRESS iiNetmask;
}

struct SOCKADDR_IN6
{
    ADDRESS_FAMILY sin6_family;
    ushort         sin6_port;
    uint           sin6_flowinfo;
    IN6_ADDR       sin6_addr;
    union
    {
        uint     sin6_scope_id;
        SCOPE_ID sin6_scope_struct;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-sockaddr_in6_w2ksp1
struct SOCKADDR_IN6_W2KSP1
{
    short    sin6_family;
    ushort   sin6_port;
    uint     sin6_flowinfo;
    IN6_ADDR sin6_addr;
    uint     sin6_scope_id;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-sockaddr_inet
union SOCKADDR_INET
{
    SOCKADDR_IN    Ipv4;
    SOCKADDR_IN6   Ipv6;
    ADDRESS_FAMILY si_family;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-sockaddr_in6_pair
struct SOCKADDR_IN6_PAIR
{
    SOCKADDR_IN6* SourceAddress;
    SOCKADDR_IN6* DestinationAddress;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-ip_mreq
struct IP_MREQ
{
    IN_ADDR imr_multiaddr;
    IN_ADDR imr_interface;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-ip_mreq_source
struct IP_MREQ_SOURCE
{
    IN_ADDR imr_multiaddr;
    IN_ADDR imr_sourceaddr;
    IN_ADDR imr_interface;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-ip_msfilter
struct IP_MSFILTER
{
    IN_ADDR             imsf_multiaddr;
    IN_ADDR             imsf_interface;
    MULTICAST_MODE_TYPE imsf_fmode;
    uint                imsf_numsrc;
    IN_ADDR[1]          imsf_slist; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-ipv6_mreq
struct IPV6_MREQ
{
    IN6_ADDR ipv6mr_multiaddr;
    uint     ipv6mr_interface;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-group_req
struct GROUP_REQ
{
    uint             gr_interface;
    SOCKADDR_STORAGE gr_group;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-group_source_req
struct GROUP_SOURCE_REQ
{
    uint             gsr_interface;
    SOCKADDR_STORAGE gsr_group;
    SOCKADDR_STORAGE gsr_source;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-group_filter
struct GROUP_FILTER
{
    uint                gf_interface;
    SOCKADDR_STORAGE    gf_group;
    MULTICAST_MODE_TYPE gf_fmode;
    uint                gf_numsrc;
    SOCKADDR_STORAGE[1] gf_slist; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-in_pktinfo
struct IN_PKTINFO
{
    IN_ADDR ipi_addr;
    uint    ipi_ifindex;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-in6_pktinfo
struct IN6_PKTINFO
{
    IN6_ADDR ipi6_addr;
    uint     ipi6_ifindex;
}

struct IN_PKTINFO_EX
{
    IN_PKTINFO pkt_info;
    SCOPE_ID   scope_id;
}

struct IN6_PKTINFO_EX
{
    IN6_PKTINFO pkt_info;
    SCOPE_ID    scope_id;
}

struct IN_RECVERR
{
    IPPROTO protocol;
    uint    info;
    ubyte   type;
    ubyte   code;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2ipdef/ns-ws2ipdef-icmp_error_info
struct ICMP_ERROR_INFO
{
    SOCKADDR_INET srcaddress;
    IPPROTO       protocol;
    ubyte         type;
    ubyte         code;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wsrm/ns-wsrm-rm_send_window
struct RM_SEND_WINDOW
{
    uint RateKbitsPerSec;
    uint WindowSizeInMSecs;
    uint WindowSizeInBytes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wsrm/ns-wsrm-rm_sender_stats
struct RM_SENDER_STATS
{
    ulong DataBytesSent;
    ulong TotalBytesSent;
    ulong NaksReceived;
    ulong NaksReceivedTooLate;
    ulong NumOutstandingNaks;
    ulong NumNaksAfterRData;
    ulong RepairPacketsSent;
    ulong BufferSpaceAvailable;
    ulong TrailingEdgeSeqId;
    ulong LeadingEdgeSeqId;
    ulong RateKBitsPerSecOverall;
    ulong RateKBitsPerSecLast;
    ulong TotalODataPacketsSent;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wsrm/ns-wsrm-rm_receiver_stats
struct RM_RECEIVER_STATS
{
    ulong NumODataPacketsReceived;
    ulong NumRDataPacketsReceived;
    ulong NumDuplicateDataPackets;
    ulong DataBytesReceived;
    ulong TotalBytesReceived;
    ulong RateKBitsPerSecOverall;
    ulong RateKBitsPerSecLast;
    ulong TrailingEdgeSeqId;
    ulong LeadingEdgeSeqId;
    ulong AverageSequencesInWindow;
    ulong MinSequencesInWindow;
    ulong MaxSequencesInWindow;
    ulong FirstNakSequenceNumber;
    ulong NumPendingNaks;
    ulong NumOutstandingNaks;
    ulong NumDataPacketsBuffered;
    ulong TotalSelectiveNaksSent;
    ulong TotalParityNaksSent;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wsrm/ns-wsrm-rm_fec_info
struct RM_FEC_INFO
{
    ushort  FECBlockSize;
    ushort  FECProActivePackets;
    ubyte   FECGroupSize;
    BOOLEAN fFECOnDemandParityEnabled;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wsnwlink/ns-wsnwlink-ipx_address_data
struct IPX_ADDRESS_DATA
{
    int      adapternum;
    ubyte[4] netnum;
    ubyte[6] nodenum;
    BOOLEAN  wan;
    BOOLEAN  status;
    int      maxpkt;
    uint     linkspeed;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wsnwlink/ns-wsnwlink-ipx_netnum_data
struct IPX_NETNUM_DATA
{
    ubyte[4] netnum;
    ushort   hopcount;
    ushort   netdelay;
    int      cardnum;
    ubyte[6] router;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wsnwlink/ns-wsnwlink-ipx_spxconnstatus_data
struct IPX_SPXCONNSTATUS_DATA
{
    ubyte    ConnectionState;
    ubyte    WatchDogActive;
    ushort   LocalConnectionId;
    ushort   RemoteConnectionId;
    ushort   LocalSequenceNumber;
    ushort   LocalAckNumber;
    ushort   LocalAllocNumber;
    ushort   RemoteAckNumber;
    ushort   RemoteAllocNumber;
    ushort   LocalSocket;
    ubyte[6] ImmediateAddress;
    ubyte[4] RemoteNetwork;
    ubyte[6] RemoteNode;
    ushort   RemoteSocket;
    ushort   RetransmissionCount;
    ushort   EstimatedRoundTripDelay;
    ushort   RetransmittedPackets;
    ushort   SuppressedPacket;
}

struct LM_IRPARMS
{
    uint   nTXDataBytes;
    uint   nRXDataBytes;
    uint   nBaudRate;
    uint   thresholdTime;
    uint   discTime;
    ushort nMSLinkTurn;
    ubyte  nTXPackets;
    ubyte  nRXPackets;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/af_irda/ns-af_irda-sockaddr_irda
struct SOCKADDR_IRDA
{
    ushort   irdaAddressFamily;
    ubyte[4] irdaDeviceID;
    CHAR[25] irdaServiceName;
}

struct WINDOWS_IRDA_DEVICE_INFO
{
    ubyte[4] irdaDeviceID;
    CHAR[22] irdaDeviceName;
    ubyte    irdaDeviceHints1;
    ubyte    irdaDeviceHints2;
    ubyte    irdaCharSet;
}

struct WCE_IRDA_DEVICE_INFO
{
    ubyte[4] irdaDeviceID;
    CHAR[22] irdaDeviceName;
    ubyte[2] Reserved;
}

struct WINDOWS_DEVICELIST
{
    uint numDevice;
    WINDOWS_IRDA_DEVICE_INFO[1] Device; // Flexible array
}

struct WCE_DEVICELIST
{
    uint numDevice;
    WCE_IRDA_DEVICE_INFO[1] Device; // Flexible array
}

struct WINDOWS_IAS_SET
{
    CHAR[64]  irdaClassName;
    CHAR[256] irdaAttribName;
    uint      irdaAttribType;
    union irdaAttribute
    {
        int irdaAttribInt;
        struct irdaAttribOctetSeq
        {
            ushort      Len;
            ubyte[1024] OctetSeq;
        }
        struct irdaAttribUsrStr
        {
            ubyte      Len;
            ubyte      CharSet;
            ubyte[256] UsrStr;
        }
    }
}

struct WINDOWS_IAS_QUERY
{
    ubyte[4]  irdaDeviceID;
    CHAR[64]  irdaClassName;
    CHAR[256] irdaAttribName;
    uint      irdaAttribType;
    union irdaAttribute
    {
        int irdaAttribInt;
        struct irdaAttribOctetSeq
        {
            uint        Len;
            ubyte[1024] OctetSeq;
        }
        struct irdaAttribUsrStr
        {
            uint       Len;
            uint       CharSet;
            ubyte[256] UsrStr;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nldef/ns-nldef-nl_interface_offload_rod
struct NL_INTERFACE_OFFLOAD_ROD
{
    // Native bit field: NlChecksumSupported: [0], NlOptionsSupported: [1], TlDatagramChecksumSupported: [2], TlStreamChecksumSupported: [3], TlStreamOptionsSupported: [4], FastPathCompatible: [5], TlLargeSendOffloadSupported: [6], TlGiantSendOffloadSupported: [7]
    ubyte _bitfield0;
}

struct NL_PATH_BANDWIDTH_ROD
{
    ulong   Bandwidth;
    ulong   Instability;
    BOOLEAN BandwidthPeaked;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nldef/ns-nldef-nl_network_connectivity_hint
struct NL_NETWORK_CONNECTIVITY_HINT
{
    NL_NETWORK_CONNECTIVITY_LEVEL_HINT ConnectivityLevel;
    NL_NETWORK_CONNECTIVITY_COST_HINT ConnectivityCost;
    BOOLEAN ApproachingDataLimit;
    BOOLEAN OverDataLimit;
    BOOLEAN Roaming;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nldef/ns-nldef-nl_bandwidth_information
struct NL_BANDWIDTH_INFORMATION
{
    ulong   Bandwidth;
    ulong   Instability;
    BOOLEAN BandwidthPeaked;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-transport_setting_id
struct TRANSPORT_SETTING_ID
{
    GUID Guid;
}

struct tcp_keepalive
{
    uint onoff;
    uint keepalivetime;
    uint keepaliveinterval;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-real_time_notification_setting_input
struct REAL_TIME_NOTIFICATION_SETTING_INPUT
{
    TRANSPORT_SETTING_ID TransportSettingId;
    GUID                 BrokerEventGuid;
}

struct REAL_TIME_NOTIFICATION_SETTING_INPUT_EX
{
    TRANSPORT_SETTING_ID TransportSettingId;
    GUID                 BrokerEventGuid;
    BOOLEAN              Unmark;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-real_time_notification_setting_output
struct REAL_TIME_NOTIFICATION_SETTING_OUTPUT
{
    CONTROL_CHANNEL_TRIGGER_STATUS ChannelStatus;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-associate_nameres_context_input
struct ASSOCIATE_NAMERES_CONTEXT_INPUT
{
    TRANSPORT_SETTING_ID TransportSettingId;
    ulong                Handle;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-timestamping_config
struct TIMESTAMPING_CONFIG
{
    uint   Flags;
    ushort TxTimestampsBuffered;
}

struct PRIORITY_STATUS
{
    SOCKET_PRIORITY_HINT Sender;
    SOCKET_PRIORITY_HINT Receiver;
}

struct RCVALL_IF
{
    RCVALL_VALUE Mode;
    uint         Interface;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-tcp_initial_rto_parameters
struct TCP_INITIAL_RTO_PARAMETERS
{
    ushort Rtt;
    ubyte  MaxSynRetransmissions;
}

struct TCP_ICW_PARAMETERS
{
    TCP_ICW_LEVEL Level;
}

struct TCP_ACK_FREQUENCY_PARAMETERS
{
    ubyte TcpDelayedAckFrequency;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-tcp_info_v0
struct TCP_INFO_v0
{
    TCPSTATE State;
    uint     Mss;
    ulong    ConnectionTimeMs;
    BOOLEAN  TimestampsEnabled;
    uint     RttUs;
    uint     MinRttUs;
    uint     BytesInFlight;
    uint     Cwnd;
    uint     SndWnd;
    uint     RcvWnd;
    uint     RcvBuf;
    ulong    BytesOut;
    ulong    BytesIn;
    uint     BytesReordered;
    uint     BytesRetrans;
    uint     FastRetrans;
    uint     DupAcksIn;
    uint     TimeoutEpisodes;
    ubyte    SynRetrans;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-tcp_info_v1
struct TCP_INFO_v1
{
    TCPSTATE State;
    uint     Mss;
    ulong    ConnectionTimeMs;
    BOOLEAN  TimestampsEnabled;
    uint     RttUs;
    uint     MinRttUs;
    uint     BytesInFlight;
    uint     Cwnd;
    uint     SndWnd;
    uint     RcvWnd;
    uint     RcvBuf;
    ulong    BytesOut;
    ulong    BytesIn;
    uint     BytesReordered;
    uint     BytesRetrans;
    uint     FastRetrans;
    uint     DupAcksIn;
    uint     TimeoutEpisodes;
    ubyte    SynRetrans;
    uint     SndLimTransRwin;
    uint     SndLimTimeRwin;
    ulong    SndLimBytesRwin;
    uint     SndLimTransCwnd;
    uint     SndLimTimeCwnd;
    ulong    SndLimBytesCwnd;
    uint     SndLimTransSnd;
    uint     SndLimTimeSnd;
    ulong    SndLimBytesSnd;
}

struct TCP_INFO_v2
{
    TCPSTATE State;
    uint     Mss;
    ulong    ConnectionTimeMs;
    BOOLEAN  TimestampsEnabled;
    uint     RttUs;
    uint     MinRttUs;
    uint     BytesInFlight;
    uint     Cwnd;
    uint     SndWnd;
    uint     RcvWnd;
    uint     RcvBuf;
    ulong    BytesOut;
    ulong    BytesIn;
    uint     BytesReordered;
    uint     BytesRetrans;
    uint     FastRetrans;
    uint     DupAcksIn;
    uint     TimeoutEpisodes;
    ubyte    SynRetrans;
    uint     SndLimTransRwin;
    uint     SndLimTimeRwin;
    ulong    SndLimBytesRwin;
    uint     SndLimTransCwnd;
    uint     SndLimTimeCwnd;
    ulong    SndLimBytesCwnd;
    uint     SndLimTransSnd;
    uint     SndLimTimeSnd;
    ulong    SndLimBytesSnd;
    uint     OutOfOrderPktsIn;
    BOOLEAN  EcnNegotiated;
    uint     EceAcksIn;
    uint     PtoEpisodes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-inet_port_range
struct INET_PORT_RANGE
{
    ushort StartPort;
    ushort NumberOfPorts;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-inet_port_reservation_token
struct INET_PORT_RESERVATION_TOKEN
{
    ulong Token;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-inet_port_reservation_instance
struct INET_PORT_RESERVATION_INSTANCE
{
    INET_PORT_RANGE Reservation;
    INET_PORT_RESERVATION_TOKEN Token;
}

struct INET_PORT_RESERVATION_INFORMATION
{
    uint OwningPid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-socket_security_settings
struct SOCKET_SECURITY_SETTINGS
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    uint SecurityFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-socket_security_settings_ipsec
struct SOCKET_SECURITY_SETTINGS_IPSEC
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    uint     SecurityFlags;
    uint     IpsecFlags;
    GUID     AuthipMMPolicyKey;
    GUID     AuthipQMPolicyKey;
    GUID     Reserved;
    ulong    Reserved2;
    uint     UserNameStringLen;
    uint     DomainNameStringLen;
    uint     PasswordStringLen;
    wchar[1] AllStrings; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-socket_peer_target_name
struct SOCKET_PEER_TARGET_NAME
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    SOCKADDR_STORAGE PeerAddress;
    uint             PeerTargetNameStringLen;
    wchar[1]         AllStrings; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-socket_security_query_template
struct SOCKET_SECURITY_QUERY_TEMPLATE
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    SOCKADDR_STORAGE PeerAddress;
    uint             PeerTokenAccessMask;
}

struct SOCKET_SECURITY_QUERY_TEMPLATE_IPSEC2
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    SOCKADDR_STORAGE PeerAddress;
    uint             PeerTokenAccessMask;
    uint             Flags;
    uint             FieldMask;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mstcpip/ns-mstcpip-socket_security_query_info
struct SOCKET_SECURITY_QUERY_INFO
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    uint  Flags;
    ulong PeerApplicationAccessTokenHandle;
    ulong PeerMachineAccessTokenHandle;
}

struct SOCKET_SECURITY_QUERY_INFO_IPSEC2
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    uint  Flags;
    ulong PeerApplicationAccessTokenHandle;
    ulong PeerMachineAccessTokenHandle;
    ulong MmSaId;
    ulong QmSaId;
    uint  NegotiationWinerr;
    GUID  SaLookupContext;
}

struct RSS_SCALABILITY_INFO
{
    BOOLEAN RssEnabled;
}

struct WSA_COMPATIBILITY_MODE
{
    WSA_COMPATIBILITY_BEHAVIOR_ID BehaviorId;
    uint TargetOsVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswsockdef/ns-mswsockdef-rioresult
struct RIORESULT
{
    int   Status;
    uint  BytesTransferred;
    ulong SocketContext;
    ulong RequestContext;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswsockdef/ns-mswsockdef-rio_buf
struct RIO_BUF
{
    RIO_BUFFERID BufferId;
    uint         Offset;
    uint         Length;
}

struct RIO_CMSG_BUFFER
{
    uint TotalLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2atm/ns-ws2atm-atm_address
struct ATM_ADDRESS
{
    uint      AddressType;
    uint      NumofDigits;
    ubyte[20] Addr;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2atm/ns-ws2atm-atm_blli
struct ATM_BLLI
{
    uint     Layer2Protocol;
    uint     Layer2UserSpecifiedProtocol;
    uint     Layer3Protocol;
    uint     Layer3UserSpecifiedProtocol;
    uint     Layer3IPI;
    ubyte[5] SnapID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2atm/ns-ws2atm-atm_bhli
struct ATM_BHLI
{
    uint     HighLayerInfoType;
    uint     HighLayerInfoLength;
    ubyte[8] HighLayerInfo;
}

struct SOCKADDR_ATM
{
    ushort      satm_family;
    ATM_ADDRESS satm_number;
    ATM_BLLI    satm_blli;
    ATM_BHLI    satm_bhli;
}

struct Q2931_IE
{
    Q2931_IE_TYPE IEType;
    uint          IELength;
    ubyte[1]      IE; // Flexible array
}

struct AAL5_PARAMETERS
{
    uint  ForwardMaxCPCSSDUSize;
    uint  BackwardMaxCPCSSDUSize;
    ubyte Mode;
    ubyte SSCSType;
}

struct AALUSER_PARAMETERS
{
    uint UserDefined;
}

struct AAL_PARAMETERS_IE
{
    AAL_TYPE AALType;
    union AALSpecificParameters
    {
        AAL5_PARAMETERS    AAL5Parameters;
        AALUSER_PARAMETERS AALUserParameters;
    }
}

struct ATM_TD
{
    uint PeakCellRate_CLP0;
    uint PeakCellRate_CLP01;
    uint SustainableCellRate_CLP0;
    uint SustainableCellRate_CLP01;
    uint MaxBurstSize_CLP0;
    uint MaxBurstSize_CLP01;
    BOOL Tagging;
}

struct ATM_TRAFFIC_DESCRIPTOR_IE
{
    ATM_TD Forward;
    ATM_TD Backward;
    BOOL   BestEffort;
}

struct ATM_BROADBAND_BEARER_CAPABILITY_IE
{
    ubyte BearerClass;
    ubyte TrafficType;
    ubyte TimingRequirements;
    ubyte ClippingSusceptability;
    ubyte UserPlaneConnectionConfig;
}

struct ATM_BLLI_IE
{
    uint     Layer2Protocol;
    ubyte    Layer2Mode;
    ubyte    Layer2WindowSize;
    uint     Layer2UserSpecifiedProtocol;
    uint     Layer3Protocol;
    ubyte    Layer3Mode;
    ubyte    Layer3DefaultPacketSize;
    ubyte    Layer3PacketWindowSize;
    uint     Layer3UserSpecifiedProtocol;
    uint     Layer3IPI;
    ubyte[5] SnapID;
}

struct ATM_CALLING_PARTY_NUMBER_IE
{
    ATM_ADDRESS ATM_Number;
    ubyte       Presentation_Indication;
    ubyte       Screening_Indicator;
}

struct ATM_CAUSE_IE
{
    ubyte    Location;
    ubyte    Cause;
    ubyte    DiagnosticsLength;
    ubyte[4] Diagnostics;
}

struct ATM_QOS_CLASS_IE
{
    ubyte QOSClassForward;
    ubyte QOSClassBackward;
}

struct ATM_TRANSIT_NETWORK_SELECTION_IE
{
    ubyte    TypeOfNetworkId;
    ubyte    NetworkIdPlan;
    ubyte    NetworkIdLength;
    ubyte[1] NetworkId; // Flexible array
}

struct ATM_CONNECTION_ID
{
    uint DeviceNumber;
    uint VPI;
    uint VCI;
}

struct ATM_PVC_PARAMS
{
align (4):
    ATM_CONNECTION_ID PvcConnectionId;
    QOS               PvcQos;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nsemail/ns-nsemail-napi_domain_description_blob
struct NAPI_DOMAIN_DESCRIPTION_BLOB
{
    uint AuthLevel;
    uint cchDomainName;
    uint OffsetNextDomainDescription;
    uint OffsetThisDomainName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nsemail/ns-nsemail-napi_provider_installation_blob
struct NAPI_PROVIDER_INSTALLATION_BLOB
{
    uint dwVersion;
    uint dwProviderType;
    uint fSupportsWildCard;
    uint cDomains;
    uint OffsetFirstDomain;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswsock/ns-mswsock-transmit_file_buffers
struct TRANSMIT_FILE_BUFFERS
{
    void* Head;
    uint  HeadLength;
    void* Tail;
    uint  TailLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswsock/ns-mswsock-transmit_packets_element
struct TRANSMIT_PACKETS_ELEMENT
{
    uint dwElFlags;
    uint cLength;
    union
    {
        struct
        {
            long   nFileOffset;
            HANDLE hFile;
        }
        void* pBuffer;
    }
}

struct NLA_BLOB
{
    struct header
    {
        NLA_BLOB_DATA_TYPE type;
        uint               dwSize;
        uint               nextOffset;
    }
    union data
    {
        CHAR[1] rawData;
        struct interfaceData
        {
            uint    dwType;
            uint    dwSpeed;
            CHAR[1] adapterName; // Flexible array
        }
        struct locationData
        {
            CHAR[1] information; // Flexible array
        }
        struct connectivity
        {
            NLA_CONNECTIVITY_TYPE type;
            NLA_INTERNET internet;
        }
        struct ICS
        {
            struct remote
            {
                uint       speed;
                uint       type;
                uint       state;
                wchar[256] machineName;
                wchar[256] sharedAdapterName;
            }
        }
    }
}

struct WSAPOLLDATA
{
    int          result;
    uint         fds;
    int          timeout;
    WSAPOLLFD[1] fdArray; // Flexible array
}

struct WSASENDMSG
{
    WSAMSG*     lpMsg;
    uint        dwFlags;
    uint*       lpNumberOfBytesSent;
    OVERLAPPED* lpOverlapped;
    LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswsock/ns-mswsock-rio_notification_completion
struct RIO_NOTIFICATION_COMPLETION
{
    RIO_NOTIFICATION_COMPLETION_TYPE Type;
    union
    {
        struct Event
        {
            HANDLE EventHandle;
            BOOL   NotifyReset;
        }
        struct Iocp
        {
            HANDLE IocpHandle;
            void*  CompletionKey;
            void*  Overlapped;
        }
    }
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mswsock/ns-mswsock-rio_extension_function_table
struct RIO_EXTENSION_FUNCTION_TABLE
{
    uint              cbSize;
    LPFN_RIORECEIVE   RIOReceive;
    LPFN_RIORECEIVEEX RIOReceiveEx;
    LPFN_RIOSEND      RIOSend;
    LPFN_RIOSENDEX    RIOSendEx;
    LPFN_RIOCLOSECOMPLETIONQUEUE RIOCloseCompletionQueue;
    LPFN_RIOCREATECOMPLETIONQUEUE RIOCreateCompletionQueue;
    LPFN_RIOCREATEREQUESTQUEUE RIOCreateRequestQueue;
    LPFN_RIODEQUEUECOMPLETION RIODequeueCompletion;
    LPFN_RIODEREGISTERBUFFER RIODeregisterBuffer;
    LPFN_RIONOTIFY    RIONotify;
    LPFN_RIOREGISTERBUFFER RIORegisterBuffer;
    LPFN_RIORESIZECOMPLETIONQUEUE RIOResizeCompletionQueue;
    LPFN_RIORESIZEREQUESTQUEUE RIOResizeRequestQueue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2spi/ns-ws2spi-wspdata
struct WSPDATA
{
    ushort     wVersion;
    ushort     wHighVersion;
    wchar[256] szDescription;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2spi/ns-ws2spi-wsathreadid
struct WSATHREADID
{
    HANDLE ThreadHandle;
    size_t Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2spi/ns-ws2spi-wspproc_table
struct WSPPROC_TABLE
{
    LPWSPACCEPT          lpWSPAccept;
    LPWSPADDRESSTOSTRING lpWSPAddressToString;
    LPWSPASYNCSELECT     lpWSPAsyncSelect;
    LPWSPBIND            lpWSPBind;
    LPWSPCANCELBLOCKINGCALL lpWSPCancelBlockingCall;
    LPWSPCLEANUP         lpWSPCleanup;
    LPWSPCLOSESOCKET     lpWSPCloseSocket;
    LPWSPCONNECT         lpWSPConnect;
    LPWSPDUPLICATESOCKET lpWSPDuplicateSocket;
    LPWSPENUMNETWORKEVENTS lpWSPEnumNetworkEvents;
    LPWSPEVENTSELECT     lpWSPEventSelect;
    LPWSPGETOVERLAPPEDRESULT lpWSPGetOverlappedResult;
    LPWSPGETPEERNAME     lpWSPGetPeerName;
    LPWSPGETSOCKNAME     lpWSPGetSockName;
    LPWSPGETSOCKOPT      lpWSPGetSockOpt;
    LPWSPGETQOSBYNAME    lpWSPGetQOSByName;
    LPWSPIOCTL           lpWSPIoctl;
    LPWSPJOINLEAF        lpWSPJoinLeaf;
    LPWSPLISTEN          lpWSPListen;
    LPWSPRECV            lpWSPRecv;
    LPWSPRECVDISCONNECT  lpWSPRecvDisconnect;
    LPWSPRECVFROM        lpWSPRecvFrom;
    LPWSPSELECT          lpWSPSelect;
    LPWSPSEND            lpWSPSend;
    LPWSPSENDDISCONNECT  lpWSPSendDisconnect;
    LPWSPSENDTO          lpWSPSendTo;
    LPWSPSETSOCKOPT      lpWSPSetSockOpt;
    LPWSPSHUTDOWN        lpWSPShutdown;
    LPWSPSOCKET          lpWSPSocket;
    LPWSPSTRINGTOADDRESS lpWSPStringToAddress;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2spi/ns-ws2spi-wspupcalltable
struct WSPUPCALLTABLE
{
    LPWPUCLOSEEVENT      lpWPUCloseEvent;
    LPWPUCLOSESOCKETHANDLE lpWPUCloseSocketHandle;
    LPWPUCREATEEVENT     lpWPUCreateEvent;
    LPWPUCREATESOCKETHANDLE lpWPUCreateSocketHandle;
    LPWPUFDISSET         lpWPUFDIsSet;
    LPWPUGETPROVIDERPATH lpWPUGetProviderPath;
    LPWPUMODIFYIFSHANDLE lpWPUModifyIFSHandle;
    LPWPUPOSTMESSAGE     lpWPUPostMessage;
    LPWPUQUERYBLOCKINGCALLBACK lpWPUQueryBlockingCallback;
    LPWPUQUERYSOCKETHANDLECONTEXT lpWPUQuerySocketHandleContext;
    LPWPUQUEUEAPC        lpWPUQueueApc;
    LPWPURESETEVENT      lpWPUResetEvent;
    LPWPUSETEVENT        lpWPUSetEvent;
    LPWPUOPENCURRENTTHREAD lpWPUOpenCurrentThread;
    LPWPUCLOSETHREAD     lpWPUCloseThread;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2spi/ns-ws2spi-wsc_provider_audit_info
struct WSC_PROVIDER_AUDIT_INFO
{
    uint  RecordSize;
    void* Reserved;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2spi/ns-ws2spi-nsp_routine
struct NSP_ROUTINE
{
    uint            cbSize;
    uint            dwMajorVersion;
    uint            dwMinorVersion;
    LPNSPCLEANUP    NSPCleanup;
    LPNSPLOOKUPSERVICEBEGIN NSPLookupServiceBegin;
    LPNSPLOOKUPSERVICENEXT NSPLookupServiceNext;
    LPNSPLOOKUPSERVICEEND NSPLookupServiceEnd;
    LPNSPSETSERVICE NSPSetService;
    LPNSPINSTALLSERVICECLASS NSPInstallServiceClass;
    LPNSPREMOVESERVICECLASS NSPRemoveServiceClass;
    LPNSPGETSERVICECLASSINFO NSPGetServiceClassInfo;
    LPNSPIOCTL      NSPIoctl;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ws2spi/ns-ws2spi-nspv2_routine
struct NSPV2_ROUTINE
{
    uint                cbSize;
    uint                dwMajorVersion;
    uint                dwMinorVersion;
    LPNSPV2STARTUP      NSPv2Startup;
    LPNSPV2CLEANUP      NSPv2Cleanup;
    LPNSPV2LOOKUPSERVICEBEGIN NSPv2LookupServiceBegin;
    LPNSPV2LOOKUPSERVICENEXTEX NSPv2LookupServiceNextEx;
    LPNSPV2LOOKUPSERVICEEND NSPv2LookupServiceEnd;
    LPNSPV2SETSERVICEEX NSPv2SetServiceEx;
    LPNSPV2CLIENTSESSIONRUNDOWN NSPv2ClientSessionRundown;
}

struct NS_INFOA
{
    uint dwNameSpace;
    uint dwNameSpaceFlags;
    PSTR lpNameSpace;
}

struct NS_INFOW
{
    uint  dwNameSpace;
    uint  dwNameSpaceFlags;
    PWSTR lpNameSpace;
}

struct SERVICE_TYPE_VALUE
{
    uint dwNameSpace;
    uint dwValueType;
    uint dwValueSize;
    uint dwValueNameOffset;
    uint dwValueOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nspapi/ns-nspapi-service_type_value_absa
struct SERVICE_TYPE_VALUE_ABSA
{
    uint  dwNameSpace;
    uint  dwValueType;
    uint  dwValueSize;
    PSTR  lpValueName;
    void* lpValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nspapi/ns-nspapi-service_type_value_absw
struct SERVICE_TYPE_VALUE_ABSW
{
    uint  dwNameSpace;
    uint  dwValueType;
    uint  dwValueSize;
    PWSTR lpValueName;
    void* lpValue;
}

struct SERVICE_TYPE_INFO
{
    uint dwTypeNameOffset;
    uint dwValueCount;
    SERVICE_TYPE_VALUE[1] Values; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nspapi/ns-nspapi-service_type_info_absa
struct SERVICE_TYPE_INFO_ABSA
{
    PSTR lpTypeName;
    uint dwValueCount;
    SERVICE_TYPE_VALUE_ABSA[1] Values; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nspapi/ns-nspapi-service_type_info_absw
struct SERVICE_TYPE_INFO_ABSW
{
    PWSTR lpTypeName;
    uint  dwValueCount;
    SERVICE_TYPE_VALUE_ABSW[1] Values; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nspapi/ns-nspapi-service_address
struct SERVICE_ADDRESS
{
    uint   dwAddressType;
    uint   dwAddressFlags;
    uint   dwAddressLength;
    uint   dwPrincipalLength;
    ubyte* lpAddress;
    ubyte* lpPrincipal;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nspapi/ns-nspapi-service_addresses
struct SERVICE_ADDRESSES
{
    uint               dwAddressCount;
    SERVICE_ADDRESS[1] Addresses; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nspapi/ns-nspapi-service_infoa
struct SERVICE_INFOA
{
    GUID*              lpServiceType;
    PSTR               lpServiceName;
    PSTR               lpComment;
    PSTR               lpLocale;
    RESOURCE_DISPLAY_TYPE dwDisplayHint;
    uint               dwVersion;
    uint               dwTime;
    PSTR               lpMachineName;
    SERVICE_ADDRESSES* lpServiceAddress;
    BLOB               ServiceSpecificInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nspapi/ns-nspapi-service_infow
struct SERVICE_INFOW
{
    GUID*              lpServiceType;
    PWSTR              lpServiceName;
    PWSTR              lpComment;
    PWSTR              lpLocale;
    RESOURCE_DISPLAY_TYPE dwDisplayHint;
    uint               dwVersion;
    uint               dwTime;
    PWSTR              lpMachineName;
    SERVICE_ADDRESSES* lpServiceAddress;
    BLOB               ServiceSpecificInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nspapi/ns-nspapi-ns_service_infoa
struct NS_SERVICE_INFOA
{
    uint          dwNameSpace;
    SERVICE_INFOA ServiceInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nspapi/ns-nspapi-ns_service_infow
struct NS_SERVICE_INFOW
{
    uint          dwNameSpace;
    SERVICE_INFOW ServiceInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nspapi/ns-nspapi-protocol_infoa
struct PROTOCOL_INFOA
{
    uint dwServiceFlags;
    int  iAddressFamily;
    int  iMaxSockAddr;
    int  iMinSockAddr;
    int  iSocketType;
    int  iProtocol;
    uint dwMessageSize;
    PSTR lpProtocol;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/nspapi/ns-nspapi-protocol_infow
struct PROTOCOL_INFOW
{
    uint  dwServiceFlags;
    int   iAddressFamily;
    int   iMaxSockAddr;
    int   iMinSockAddr;
    int   iSocketType;
    int   iProtocol;
    uint  dwMessageSize;
    PWSTR lpProtocol;
}

struct NETRESOURCE2A
{
    uint     dwScope;
    uint     dwType;
    uint     dwUsage;
    uint     dwDisplayType;
    PSTR     lpLocalName;
    PSTR     lpRemoteName;
    PSTR     lpComment;
    NS_INFOA ns_info;
    GUID     ServiceType;
    uint     dwProtocols;
    int*     lpiProtocols;
}

struct NETRESOURCE2W
{
    uint     dwScope;
    uint     dwType;
    uint     dwUsage;
    uint     dwDisplayType;
    PWSTR    lpLocalName;
    PWSTR    lpRemoteName;
    PWSTR    lpComment;
    NS_INFOA ns_info;
    GUID     ServiceType;
    uint     dwProtocols;
    int*     lpiProtocols;
}

struct SERVICE_ASYNC_INFO
{
    LPSERVICE_CALLBACK_PROC lpServiceCallbackProc;
    LPARAM lParam;
    HANDLE hAsyncTaskHandle;
}

struct SOCKADDR_UN
{
    ADDRESS_FAMILY sun_family;
    CHAR[108]      sun_path;
}

struct SOCKADDR_IPX
{
    short   sa_family;
    CHAR[4] sa_netnum;
    CHAR[6] sa_nodenum;
    ushort  sa_socket;
}

struct SOCKADDR_TP
{
    ushort    tp_family;
    ushort    tp_addr_type;
    ushort    tp_taddr_len;
    ushort    tp_tsel_len;
    ubyte[64] tp_addr;
}

struct SOCKADDR_NB
{
    short    snb_family;
    ushort   snb_type;
    CHAR[16] snb_name;
}

struct SOCKADDR_VNS
{
    ushort   sin_family;
    ubyte[4] net_address;
    ubyte[2] subnet_addr;
    ubyte[2] port;
    ubyte    hops;
    ubyte[5] filler;
}

union DL_OUI
{
    ubyte[3] Byte;
    struct
    {
        // Native bit field: Group: [0], Local: [1]
        ubyte _bitfield0;
    }
}

union DL_EI48
{
    ubyte[3] Byte;
}

union DL_EUI48
{
    ubyte[6] Byte;
    struct
    {
        DL_OUI  Oui;
        DL_EI48 Ei48;
    }
}

union DL_EI64
{
    ubyte[5] Byte;
}

union DL_EUI64
{
    ubyte[8] Byte;
    ulong    Value;
    struct
    {
        DL_OUI Oui;
        union
        {
            DL_EI64 Ei64;
            struct
            {
                ubyte   Type;
                ubyte   Tse;
                DL_EI48 Ei48;
            }
        }
    }
}

struct SNAP_HEADER
{
    ubyte    Dsap;
    ubyte    Ssap;
    ubyte    Control;
    ubyte[3] Oui;
    ushort   Type;
}

struct ETHERNET_HEADER
{
    DL_EUI48 Destination;
    DL_EUI48 Source;
    union
    {
        ushort Type;
        ushort Length;
    }
}

struct VLAN_TAG
{
    union
    {
        ushort Tag;
        struct
        {
            // Native bit field: VID: [0-11], CFI: [12], User_Priority: [13-15]
            ushort _bitfield0;
        }
    }
    ushort Type;
}

struct ICMP_HEADER
{
    ubyte  Type;
    ubyte  Code;
    ushort Checksum;
}

struct ICMP_MESSAGE
{
    ICMP_HEADER Header;
    union Data
    {
        uint[1]   Data32;
        ushort[2] Data16;
        ubyte[4]  Data8;
    }
}

struct IPV4_HEADER
{
    union
    {
        ubyte VersionAndHeaderLength;
        struct
        {
            // Native bit field: HeaderLength: [0-3], Version: [4-7]
            ubyte _bitfield0;
        }
    }
    union
    {
        ubyte TypeOfServiceAndEcnField;
        struct
        {
            // Native bit field: EcnField: [0-1], TypeOfService: [2-7]
            ubyte _bitfield1;
        }
    }
    ushort  TotalLength;
    ushort  Identification;
    union
    {
        ushort FlagsAndOffset;
        struct
        {
            // Native bit field: DontUse1: [0-4], MoreFragments: [5], DontFragment: [6], Reserved: [7], DontUse2: [8-15]
            ushort _bitfield2;
        }
    }
    ubyte   TimeToLive;
    ubyte   Protocol;
    ushort  HeaderChecksum;
    IN_ADDR SourceAddress;
    IN_ADDR DestinationAddress;
}

struct IPV4_OPTION_HEADER
{
    union
    {
        ubyte OptionType;
        struct
        {
            // Native bit field: OptionNumber: [0-4], OptionClass: [5-6], CopiedFlag: [7]
            ubyte _bitfield0;
        }
    }
    ubyte OptionLength;
}

struct IPV4_TIMESTAMP_OPTION
{
    IPV4_OPTION_HEADER OptionHeader;
    ubyte              Pointer;
    union
    {
        ubyte FlagsOverflow;
        struct
        {
            // Native bit field: Flags: [0-3], Overflow: [4-7]
            ubyte _bitfield0;
        }
    }
}

struct IPV4_ROUTING_HEADER
{
    IPV4_OPTION_HEADER OptionHeader;
    ubyte              Pointer;
}

struct ICMPV4_ROUTER_SOLICIT
{
    ICMP_MESSAGE RsHeader;
}

struct ICMPV4_ROUTER_ADVERT_HEADER
{
    ICMP_MESSAGE RaHeader;
}

struct ICMPV4_ROUTER_ADVERT_ENTRY
{
    IN_ADDR RouterAdvertAddr;
    int     PreferenceLevel;
}

struct ICMPV4_TIMESTAMP_MESSAGE
{
    ICMP_MESSAGE Header;
    uint         OriginateTimestamp;
    uint         ReceiveTimestamp;
    uint         TransmitTimestamp;
}

struct ICMPV4_ADDRESS_MASK_MESSAGE
{
    ICMP_MESSAGE Header;
    uint         AddressMask;
}

struct ARP_HEADER
{
    ushort   HardwareAddressSpace;
    ushort   ProtocolAddressSpace;
    ubyte    HardwareAddressLength;
    ubyte    ProtocolAddressLength;
    ushort   Opcode;
    ubyte[1] SenderHardwareAddress; // Flexible array
}

struct IGMP_HEADER
{
    union
    {
        struct
        {
            // Native bit field: Type: [0-3], Version: [4-7]
            ubyte _bitfield0;
        }
        ubyte VersionType;
    }
    union
    {
        ubyte Reserved;
        ubyte MaxRespTime;
        ubyte Code;
    }
    ushort  Checksum;
    IN_ADDR MulticastAddress;
}

struct IGMPV3_QUERY_HEADER
{
    ubyte   Type;
    union
    {
        ubyte MaxRespCode;
        struct
        {
            // Native bit field: MaxRespCodeMantissa: [0-3], MaxRespCodeExponent: [4-6], MaxRespCodeType: [7]
            ubyte _bitfield0;
        }
    }
    ushort  Checksum;
    IN_ADDR MulticastAddress;
    // Native bit field: QuerierRobustnessVariable: [0-2], SuppressRouterSideProcessing: [3], Reserved: [4-7]
    ubyte   _bitfield1;
    union
    {
        ubyte QueriersQueryInterfaceCode;
        struct
        {
            // Native bit field: QQCMantissa: [0-3], QQCExponent: [4-6], QQCType: [7]
            ubyte _bitfield2;
        }
    }
    ushort  SourceCount;
}

struct IGMPV3_REPORT_RECORD_HEADER
{
    ubyte   Type;
    ubyte   AuxillaryDataLength;
    ushort  SourceCount;
    IN_ADDR MulticastAddress;
}

struct IGMPV3_REPORT_HEADER
{
    ubyte  Type;
    ubyte  Reserved;
    ushort Checksum;
    ushort Reserved2;
    ushort RecordCount;
}

struct IPV6_HEADER
{
    union
    {
        uint VersionClassFlow;
        struct
        {
            // Native bit field: Anonymous1: [0-3], Version: [4-7], Anonymous2: [8-31]
            uint _bitfield0;
        }
    }
    ushort   PayloadLength;
    ubyte    NextHeader;
    ubyte    HopLimit;
    IN6_ADDR SourceAddress;
    IN6_ADDR DestinationAddress;
}

struct IPV6_FRAGMENT_HEADER
{
    ubyte NextHeader;
    ubyte Reserved;
    union
    {
        struct
        {
            // Native bit field: DontUse1: [0-7], MoreFragments: [8], ReservedBits: [9-10], DontUse2: [11-15]
            ushort _bitfield0;
        }
        ushort OffsetAndFlags;
    }
    uint  Id;
}

struct IPV6_EXTENSION_HEADER
{
    ubyte NextHeader;
    ubyte Length;
}

struct IPV6_OPTION_HEADER
{
    ubyte Type;
    ubyte DataLength;
}

struct IPV6_OPTION_JUMBOGRAM
{
    IPV6_OPTION_HEADER Header;
    ubyte[4]           JumbogramLength;
}

struct IPV6_OPTION_ROUTER_ALERT
{
    IPV6_OPTION_HEADER Header;
    ubyte[2]           Value;
}

struct IPV6_ROUTING_HEADER
{
    ubyte    NextHeader;
    ubyte    Length;
    ubyte    RoutingType;
    ubyte    SegmentsLeft;
    ubyte[4] Reserved;
}

struct ND_ROUTER_SOLICIT_HEADER
{
    ICMP_MESSAGE nd_rs_hdr;
}

struct ND_ROUTER_ADVERT_HEADER
{
    ICMP_MESSAGE nd_ra_hdr;
    uint         nd_ra_reachable;
    uint         nd_ra_retransmit;
}

union IPV6_ROUTER_ADVERTISEMENT_FLAGS
{
    struct
    {
        // Native bit field: Reserved: [0-2], Preference: [3-4], HomeAgent: [5], OtherStatefulConfiguration: [6], ManagedAddressConfiguration: [7]
        ubyte _bitfield0;
    }
    ubyte Value;
}

struct ND_NEIGHBOR_SOLICIT_HEADER
{
    ICMP_MESSAGE nd_ns_hdr;
    IN6_ADDR     nd_ns_target;
}

struct ND_NEIGHBOR_ADVERT_HEADER
{
    ICMP_MESSAGE nd_na_hdr;
    IN6_ADDR     nd_na_target;
}

union IPV6_NEIGHBOR_ADVERTISEMENT_FLAGS
{
    struct
    {
        // Native bit field: Reserved1: [0-4], Override: [5], Solicited: [6], Router: [7]
        ubyte    _bitfield0;
        ubyte[3] Reserved2;
    }
    uint Value;
}

struct ND_REDIRECT_HEADER
{
    ICMP_MESSAGE nd_rd_hdr;
    IN6_ADDR     nd_rd_target;
    IN6_ADDR     nd_rd_dst;
}

struct ND_OPTION_HDR
{
    ubyte nd_opt_type;
    ubyte nd_opt_len;
}

struct ND_OPTION_PREFIX_INFO
{
    ubyte    nd_opt_pi_type;
    ubyte    nd_opt_pi_len;
    ubyte    nd_opt_pi_prefix_len;
    union
    {
        ubyte nd_opt_pi_flags_reserved;
        struct Flags
        {
            // Native bit field: Route: [0], Reserved1: [1-3], SitePrefix: [4], RouterAddress: [5], Autonomous: [6], OnLink: [7]
            ubyte _bitfield0;
        }
    }
    uint     nd_opt_pi_valid_time;
    uint     nd_opt_pi_preferred_time;
    union
    {
        uint nd_opt_pi_reserved2;
        struct
        {
            ubyte[3] nd_opt_pi_reserved3;
            ubyte    nd_opt_pi_site_prefix_len;
        }
    }
    IN6_ADDR nd_opt_pi_prefix;
}

struct ND_OPTION_RD_HDR
{
    ubyte  nd_opt_rh_type;
    ubyte  nd_opt_rh_len;
    ushort nd_opt_rh_reserved1;
    uint   nd_opt_rh_reserved2;
}

struct ND_OPTION_MTU
{
    ubyte  nd_opt_mtu_type;
    ubyte  nd_opt_mtu_len;
    ushort nd_opt_mtu_reserved;
    uint   nd_opt_mtu_mtu;
}

struct ND_OPTION_ROUTE_INFO
{
    ubyte    nd_opt_ri_type;
    ubyte    nd_opt_ri_len;
    ubyte    nd_opt_ri_prefix_len;
    union
    {
        ubyte nd_opt_ri_flags_reserved;
        struct Flags
        {
            // Native bit field: Reserved: [0-2], Preference: [3-4]
            ubyte _bitfield0;
        }
    }
    uint     nd_opt_ri_route_lifetime;
    IN6_ADDR nd_opt_ri_prefix;
}

struct ND_OPTION_RDNSS
{
    ubyte  nd_opt_rdnss_type;
    ubyte  nd_opt_rdnss_len;
    ushort nd_opt_rdnss_reserved;
    uint   nd_opt_rdnss_lifetime;
}

struct ND_OPTION_DNSSL
{
    ubyte  nd_opt_dnssl_type;
    ubyte  nd_opt_dnssl_len;
    ushort nd_opt_dnssl_reserved;
    uint   nd_opt_dnssl_lifetime;
}

struct ND_OPTION_PREF64
{
    ubyte     nd_opt_p64_type;
    ubyte     nd_opt_p64_len;
    union
    {
        ushort nd_opt_p64_lifetime_plc;
        struct
        {
            // Native bit field: nd_opt_p64_prefix_length_code: [0-2], nd_opt_p64_scaled_lifetime: [3-15]
            ushort _bitfield0;
        }
    }
    ubyte[12] nd_opt_p64_prefix;
}

struct MLD_HEADER
{
    ICMP_HEADER IcmpHeader;
    ushort      MaxRespTime;
    ushort      Reserved;
    IN6_ADDR    MulticastAddress;
}

struct MLDV2_QUERY_HEADER
{
    ICMP_HEADER IcmpHeader;
    union
    {
        ushort MaxRespCode;
        struct
        {
            // Native bit field: MaxRespCodeMantissaHi: [0-3], MaxRespCodeExponent: [4-6], MaxRespCodeType: [7], MaxRespCodeMantissaLo: [8-15]
            ushort _bitfield0;
        }
    }
    ushort      Reserved;
    IN6_ADDR    MulticastAddress;
    // Native bit field: QuerierRobustnessVariable: [0-2], SuppressRouterSideProcessing: [3], QueryReserved: [4-7]
    ubyte       _bitfield1;
    union
    {
        ubyte QueriersQueryInterfaceCode;
        struct
        {
            // Native bit field: QQCMantissa: [0-3], QQCExponent: [4-6], QQCType: [7]
            ubyte _bitfield2;
        }
    }
    ushort      SourceCount;
}

struct MLDV2_REPORT_RECORD_HEADER
{
    ubyte    Type;
    ubyte    AuxillaryDataLength;
    ushort   SourceCount;
    IN6_ADDR MulticastAddress;
}

struct MLDV2_REPORT_HEADER
{
    ICMP_HEADER IcmpHeader;
    ushort      Reserved;
    ushort      RecordCount;
}

struct TCP_HDR
{
align (1):
    ushort th_sport;
    ushort th_dport;
    uint   th_seq;
    uint   th_ack;
    // Native bit field: th_x2: [0-3], th_len: [4-7]
    ubyte  _bitfield0;
    ubyte  th_flags;
    ushort th_win;
    ushort th_sum;
    ushort th_urp;
}

struct TCP_OPT_MSS
{
align (1):
    ubyte  Kind;
    ubyte  Length;
    ushort Mss;
}

struct TCP_OPT_WS
{
align (1):
    ubyte Kind;
    ubyte Length;
    ubyte ShiftCnt;
}

struct TCP_OPT_SACK_PERMITTED
{
align (1):
    ubyte Kind;
    ubyte Length;
}

struct TCP_OPT_SACK
{
align (1):
    ubyte Kind;
    ubyte Length;
    struct Block
    {
    align (1):
        uint Left;
        uint Right;
    }
}

struct TCP_OPT_TS
{
align (1):
    ubyte Kind;
    ubyte Length;
    uint  Val;
    uint  EcR;
}

struct TCP_OPT_UNKNOWN
{
align (1):
    ubyte Kind;
    ubyte Length;
}

struct TCP_OPT_FASTOPEN
{
align (1):
    ubyte    Kind;
    ubyte    Length;
    ubyte[1] Cookie; // Flexible array
}

struct DL_TUNNEL_ADDRESS
{
    COMPARTMENT_ID CompartmentId;
    SCOPE_ID       ScopeId;
    ubyte[1]       IpAddress; // Flexible array
}

struct DL_TEREDO_ADDRESS
{
align (1):
    ubyte[6] Reserved;
    union
    {
    align (1):
        DL_EUI64 Eui64;
        struct
        {
        align (1):
            ushort  Flags;
            ushort  MappedPort;
            IN_ADDR MappedAddress;
        }
    }
}

struct DL_TEREDO_ADDRESS_PRV
{
align (1):
    ubyte[6] Reserved;
    union
    {
    align (1):
        DL_EUI64 Eui64;
        struct
        {
        align (1):
            ushort   Flags;
            ushort   MappedPort;
            IN_ADDR  MappedAddress;
            IN_ADDR  LocalAddress;
            uint     InterfaceIndex;
            ushort   LocalPort;
            DL_EUI48 DlDestination;
        }
    }
}

struct IPTLS_METADATA
{
align (1):
    ulong SequenceNumber;
}

struct NPI_MODULEID
{
    ushort            Length;
    NPI_MODULEID_TYPE Type;
    union
    {
        GUID Guid;
        LUID IfLuid;
    }
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WS2_32.dll")
int WSCEnumProtocols32(int* lpiProtocols, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WSAPROTOCOL_INFOW* lpProtocolBuffer, 
                       uint* lpdwBufferLength, int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WS2_32.dll")
int WSCDeinstallProvider32(GUID* lpProviderId, int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WS2_32.dll")
int WSCInstallProvider64_32(GUID* lpProviderId, const(PWSTR) lpszProviderDllPath, 
                            const(WSAPROTOCOL_INFOW)* lpProtocolInfoList, uint dwNumberOfEntries, int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WS2_32.dll")
int WSCGetProviderPath32(GUID* lpProviderId, PWSTR lpszProviderDllPath, int* lpProviderDllPathLen, int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WS2_32.dll")
int WSCUpdateProvider32(GUID* lpProviderId, const(PWSTR) lpszProviderDllPath, 
                        const(WSAPROTOCOL_INFOW)* lpProtocolInfoList, uint dwNumberOfEntries, int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WS2_32.dll")
int WSCSetProviderInfo32(GUID* lpProviderId, WSC_PROVIDER_INFO_TYPE InfoType, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* Info, 
                         size_t InfoSize, uint Flags, int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WS2_32.dll")
int WSCGetProviderInfo32(GUID* lpProviderId, WSC_PROVIDER_INFO_TYPE InfoType, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* Info, 
                         size_t* InfoSize, uint Flags, int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WS2_32.dll")
int WSCEnumNameSpaceProviders32(uint* lpdwBufferLength, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/WSANAMESPACE_INFOW* lpnspBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WS2_32.dll")
int WSCEnumNameSpaceProvidersEx32(uint* lpdwBufferLength, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/WSANAMESPACE_INFOEXW* lpnspBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WS2_32.dll")
int WSCInstallNameSpace32(PWSTR lpszIdentifier, PWSTR lpszPathName, uint dwNameSpace, uint dwVersion, 
                          GUID* lpProviderId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WS2_32.dll")
int WSCInstallNameSpaceEx32(PWSTR lpszIdentifier, PWSTR lpszPathName, uint dwNameSpace, uint dwVersion, 
                            GUID* lpProviderId, BLOB* lpProviderSpecific);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WS2_32.dll")
int WSCUnInstallNameSpace32(GUID* lpProviderId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WS2_32.dll")
int WSCEnableNSProvider32(GUID* lpProviderId, BOOL fEnable);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WS2_32.dll")
int WSCInstallProviderAndChains64_32(GUID* lpProviderId, const(PWSTR) lpszProviderDllPath, 
                                     const(PWSTR) lpszProviderDllPath32, const(PWSTR) lpszLspName, 
                                     uint dwServiceFlags, WSAPROTOCOL_INFOW* lpProtocolInfoList, 
                                     uint dwNumberOfEntries, uint* lpdwCatalogEntryId, int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WS2_32.dll")
int WSCWriteProviderOrder32(uint* lpwdCatalogEntryId, uint dwNumberOfEntries);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WS2_32.dll")
int WSCWriteNameSpaceOrder32(GUID* lpProviderId, uint dwNumberOfEntries);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int __WSAFDIsSet(SOCKET fd, FD_SET* param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
SOCKET accept(SOCKET s, 
              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/SOCKADDR* addr, 
              int* addrlen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int bind(SOCKET s, 
         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(SOCKADDR)* name, 
         int namelen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int closesocket(SOCKET s);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WS2_32.dll")
int connect(SOCKET s, 
            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(SOCKADDR)* name, 
            int namelen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int ioctlsocket(SOCKET s, int cmd, uint* argp);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int getpeername(SOCKET s, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/SOCKADDR* name, 
                int* namelen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int getsockname(SOCKET s, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/SOCKADDR* name, 
                int* namelen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int getsockopt(SOCKET s, int level, int optname, 
               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/PSTR optval, 
               int* optlen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
uint htonl(uint hostlong);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
ushort htons(ushort hostshort);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
uint inet_addr(const(PSTR) cp);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
PSTR inet_ntoa(IN_ADDR in_);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int listen(SOCKET s, int backlog);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
uint ntohl(uint netlong);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
ushort ntohs(ushort netshort);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int recv(SOCKET s, 
         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PSTR buf, 
         int len, SEND_RECV_FLAGS flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int recvfrom(SOCKET s, 
             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PSTR buf, 
             int len, int flags, 
             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/SOCKADDR* from, 
             int* fromlen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int select(int nfds, FD_SET* readfds, FD_SET* writefds, FD_SET* exceptfds, const(TIMEVAL)* timeout);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int send(SOCKET s, 
         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(PSTR) buf, 
         int len, SEND_RECV_FLAGS flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int sendto(SOCKET s, 
           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(PSTR) buf, 
           int len, int flags, 
           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/const(SOCKADDR)* to, 
           int tolen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int setsockopt(SOCKET s, int level, int optname, 
               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(PSTR) optval, 
               int optlen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int shutdown(SOCKET s, WINSOCK_SHUTDOWN_HOW how);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
SOCKET socket(int af, WINSOCK_SOCKET_TYPE type, int protocol);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
HOSTENT* gethostbyaddr(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(PSTR) addr, 
                       int len, int type);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
HOSTENT* gethostbyname(const(PSTR) name);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int gethostname(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/PSTR name, 
                int namelen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int GetHostNameW(PWSTR name, int namelen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
SERVENT* getservbyport(int port, const(PSTR) proto);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
SERVENT* getservbyname(const(PSTR) name, const(PSTR) proto);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
PROTOENT* getprotobynumber(int number);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
PROTOENT* getprotobyname(const(PSTR) name);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSAStartup(ushort wVersionRequested, WSADATA* lpWSAData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSACleanup();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
void WSASetLastError(int iError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
WSA_ERROR WSAGetLastError();

deprecated("Winsock 2") 
@DllImport("WS2_32.dll")
BOOL WSAIsBlocking();

deprecated("Winsock 2") 
@DllImport("WS2_32.dll")
int WSAUnhookBlockingHook();

deprecated("Winsock 2") 
@DllImport("WS2_32.dll")
FARPROC WSASetBlockingHook(FARPROC lpBlockFunc);

deprecated("Winsock 2") 
@DllImport("WS2_32.dll")
int WSACancelBlockingCall();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
HANDLE WSAAsyncGetServByName(HWND hWnd, uint wMsg, const(PSTR) name, const(PSTR) proto, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/PSTR buf, 
                             int buflen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
HANDLE WSAAsyncGetServByPort(HWND hWnd, uint wMsg, int port, const(PSTR) proto, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/PSTR buf, 
                             int buflen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
HANDLE WSAAsyncGetProtoByName(HWND hWnd, uint wMsg, const(PSTR) name, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/PSTR buf, 
                              int buflen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
HANDLE WSAAsyncGetProtoByNumber(HWND hWnd, uint wMsg, int number, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/PSTR buf, 
                                int buflen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
HANDLE WSAAsyncGetHostByName(HWND hWnd, uint wMsg, const(PSTR) name, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/PSTR buf, 
                             int buflen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
HANDLE WSAAsyncGetHostByAddr(HWND hWnd, uint wMsg, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(PSTR) addr, 
                             int len, int type, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/PSTR buf, 
                             int buflen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
int WSACancelAsyncRequest(HANDLE hAsyncTaskHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
int WSAAsyncSelect(SOCKET s, HWND hWnd, uint wMsg, int lEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
SOCKET WSAAccept(SOCKET s, 
                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/SOCKADDR* addr, 
                 int* addrlen, LPCONDITIONPROC lpfnCondition, size_t dwCallbackData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
BOOL WSACloseEvent(WSAEVENT hEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSAConnect(SOCKET s, 
               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(SOCKADDR)* name, 
               int namelen, WSABUF* lpCallerData, WSABUF* lpCalleeData, QOS* lpSQOS, QOS* lpGQOS);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
BOOL WSAConnectByNameW(SOCKET s, PWSTR nodename, PWSTR servicename, uint* LocalAddressLength, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/SOCKADDR* LocalAddress, 
                       uint* RemoteAddressLength, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/SOCKADDR* RemoteAddress, 
                       const(TIMEVAL)* timeout, 
                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/OVERLAPPED* Reserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
BOOL WSAConnectByNameA(SOCKET s, const(PSTR) nodename, const(PSTR) servicename, uint* LocalAddressLength, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/SOCKADDR* LocalAddress, 
                       uint* RemoteAddressLength, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/SOCKADDR* RemoteAddress, 
                       const(TIMEVAL)* timeout, 
                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/OVERLAPPED* Reserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
BOOL WSAConnectByList(SOCKET s, SOCKET_ADDRESS_LIST* SocketAddress, uint* LocalAddressLength, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/SOCKADDR* LocalAddress, 
                      uint* RemoteAddressLength, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/SOCKADDR* RemoteAddress, 
                      const(TIMEVAL)* timeout, 
                      /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/OVERLAPPED* Reserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
WSAEVENT WSACreateEvent();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSADuplicateSocketA(SOCKET s, uint dwProcessId, WSAPROTOCOL_INFOA* lpProtocolInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSADuplicateSocketW(SOCKET s, uint dwProcessId, WSAPROTOCOL_INFOW* lpProtocolInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSAEnumNetworkEvents(SOCKET s, WSAEVENT hEventObject, WSANETWORKEVENTS* lpNetworkEvents);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSAEnumProtocolsA(int* lpiProtocols, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WSAPROTOCOL_INFOA* lpProtocolBuffer, 
                      uint* lpdwBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSAEnumProtocolsW(int* lpiProtocols, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WSAPROTOCOL_INFOW* lpProtocolBuffer, 
                      uint* lpdwBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSAEventSelect(SOCKET s, WSAEVENT hEventObject, int lNetworkEvents);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
BOOL WSAGetOverlappedResult(SOCKET s, OVERLAPPED* lpOverlapped, uint* lpcbTransfer, BOOL fWait, uint* lpdwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
BOOL WSAGetQOSByName(SOCKET s, WSABUF* lpQOSName, QOS* lpQOS);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSAHtonl(SOCKET s, uint hostlong, uint* lpnetlong);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSAHtons(SOCKET s, ushort hostshort, ushort* lpnetshort);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSAIoctl(SOCKET s, uint dwIoControlCode, 
             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpvInBuffer, 
             uint cbInBuffer, 
             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* lpvOutBuffer, 
             uint cbOutBuffer, uint* lpcbBytesReturned, OVERLAPPED* lpOverlapped, 
             LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
SOCKET WSAJoinLeaf(SOCKET s, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(SOCKADDR)* name, 
                   int namelen, WSABUF* lpCallerData, WSABUF* lpCalleeData, QOS* lpSQOS, QOS* lpGQOS, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSANtohl(SOCKET s, uint netlong, uint* lphostlong);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSANtohs(SOCKET s, ushort netshort, ushort* lphostshort);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSARecv(SOCKET s, WSABUF* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesRecvd, uint* lpFlags, 
            OVERLAPPED* lpOverlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
int WSARecvDisconnect(SOCKET s, WSABUF* lpInboundDisconnectData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSARecvFrom(SOCKET s, WSABUF* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesRecvd, uint* lpFlags, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/SOCKADDR* lpFrom, 
                int* lpFromlen, OVERLAPPED* lpOverlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
BOOL WSAResetEvent(WSAEVENT hEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSASend(SOCKET s, WSABUF* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesSent, uint dwFlags, 
            OVERLAPPED* lpOverlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSASendMsg(SOCKET Handle, WSAMSG* lpMsg, uint dwFlags, uint* lpNumberOfBytesSent, OVERLAPPED* lpOverlapped, 
               LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
int WSASendDisconnect(SOCKET s, WSABUF* lpOutboundDisconnectData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSASendTo(SOCKET s, WSABUF* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesSent, uint dwFlags, 
              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/const(SOCKADDR)* lpTo, 
              int iTolen, OVERLAPPED* lpOverlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
BOOL WSASetEvent(WSAEVENT hEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
SOCKET WSASocketA(int af, int type, int protocol, WSAPROTOCOL_INFOA* lpProtocolInfo, uint g, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
SOCKET WSASocketW(int af, int type, int protocol, WSAPROTOCOL_INFOW* lpProtocolInfo, uint g, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
WAIT_EVENT WSAWaitForMultipleEvents(uint cEvents, const(HANDLE)* lphEvents, BOOL fWaitAll, uint dwTimeout, 
                                    BOOL fAlertable);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSAAddressToStringA(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/SOCKADDR* lpsaAddress, 
                        uint dwAddressLength, WSAPROTOCOL_INFOA* lpProtocolInfo, PSTR lpszAddressString, 
                        uint* lpdwAddressStringLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSAAddressToStringW(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/SOCKADDR* lpsaAddress, 
                        uint dwAddressLength, WSAPROTOCOL_INFOW* lpProtocolInfo, PWSTR lpszAddressString, 
                        uint* lpdwAddressStringLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSAStringToAddressA(PSTR AddressString, int AddressFamily, WSAPROTOCOL_INFOA* lpProtocolInfo, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/SOCKADDR* lpAddress, 
                        int* lpAddressLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSAStringToAddressW(PWSTR AddressString, int AddressFamily, WSAPROTOCOL_INFOW* lpProtocolInfo, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/SOCKADDR* lpAddress, 
                        int* lpAddressLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSALookupServiceBeginA(WSAQUERYSETA* lpqsRestrictions, uint dwControlFlags, HANDLE* lphLookup);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSALookupServiceBeginW(WSAQUERYSETW* lpqsRestrictions, uint dwControlFlags, HANDLE* lphLookup);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSALookupServiceNextA(HANDLE hLookup, uint dwControlFlags, uint* lpdwBufferLength, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WSAQUERYSETA* lpqsResults);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSALookupServiceNextW(HANDLE hLookup, uint dwControlFlags, uint* lpdwBufferLength, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WSAQUERYSETW* lpqsResults);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSANSPIoctl(HANDLE hLookup, uint dwControlCode, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* lpvInBuffer, 
                uint cbInBuffer, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* lpvOutBuffer, 
                uint cbOutBuffer, uint* lpcbBytesReturned, WSACOMPLETION* lpCompletion);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSALookupServiceEnd(HANDLE hLookup);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
int WSAInstallServiceClassA(WSASERVICECLASSINFOA* lpServiceClassInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
int WSAInstallServiceClassW(WSASERVICECLASSINFOW* lpServiceClassInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
int WSARemoveServiceClass(GUID* lpServiceClassId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
int WSAGetServiceClassInfoA(GUID* lpProviderId, GUID* lpServiceClassId, uint* lpdwBufSize, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WSASERVICECLASSINFOA* lpServiceClassInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
int WSAGetServiceClassInfoW(GUID* lpProviderId, GUID* lpServiceClassId, uint* lpdwBufSize, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WSASERVICECLASSINFOW* lpServiceClassInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSAEnumNameSpaceProvidersA(uint* lpdwBufferLength, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/WSANAMESPACE_INFOA* lpnspBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSAEnumNameSpaceProvidersW(uint* lpdwBufferLength, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/WSANAMESPACE_INFOW* lpnspBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSAEnumNameSpaceProvidersExA(uint* lpdwBufferLength, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/WSANAMESPACE_INFOEXA* lpnspBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSAEnumNameSpaceProvidersExW(uint* lpdwBufferLength, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/WSANAMESPACE_INFOEXW* lpnspBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
int WSAGetServiceClassNameByClassIdA(GUID* lpServiceClassId, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PSTR lpszServiceClassName, 
                                     uint* lpdwBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
int WSAGetServiceClassNameByClassIdW(GUID* lpServiceClassId, 
                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PWSTR lpszServiceClassName, 
                                     uint* lpdwBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSASetServiceA(WSAQUERYSETA* lpqsRegInfo, WSAESETSERVICEOP essoperation, uint dwControlFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSASetServiceW(WSAQUERYSETW* lpqsRegInfo, WSAESETSERVICEOP essoperation, uint dwControlFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSAProviderConfigChange(HANDLE* lpNotificationHandle, OVERLAPPED* lpOverlapped, 
                            LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int WSAPoll(WSAPOLLFD* fdArray, uint fds, int timeout);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winsock2/nf-winsock2-processsocketnotifications
@DllImport("WS2_32.dll")
uint ProcessSocketNotifications(HANDLE completionPort, uint registrationCount, 
                                SOCK_NOTIFY_REGISTRATION* registrationInfos, uint timeoutMs, uint completionCount, 
                                OVERLAPPED_ENTRY* completionPortEntries, uint* receivedEntryCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ntdll.dll")
PSTR RtlIpv4AddressToStringA(const(IN_ADDR)* Addr, PSTR S);

@DllImport("ntdll.dll")
int RtlIpv4AddressToStringExA(const(IN_ADDR)* Address, ushort Port, PSTR AddressString, uint* AddressStringLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ntdll.dll")
PWSTR RtlIpv4AddressToStringW(const(IN_ADDR)* Addr, PWSTR S);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ntdll.dll")
int RtlIpv4AddressToStringExW(const(IN_ADDR)* Address, ushort Port, PWSTR AddressString, uint* AddressStringLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ntdll.dll")
int RtlIpv4StringToAddressA(const(PSTR) S, BOOLEAN Strict, const(PSTR)* Terminator, IN_ADDR* Addr);

@DllImport("ntdll.dll")
int RtlIpv4StringToAddressExA(const(PSTR) AddressString, BOOLEAN Strict, IN_ADDR* Address, ushort* Port);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ntdll.dll")
int RtlIpv4StringToAddressW(const(PWSTR) S, BOOLEAN Strict, const(PWSTR)* Terminator, IN_ADDR* Addr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ntdll.dll")
int RtlIpv4StringToAddressExW(const(PWSTR) AddressString, BOOLEAN Strict, IN_ADDR* Address, ushort* Port);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ntdll.dll")
PSTR RtlIpv6AddressToStringA(const(IN6_ADDR)* Addr, PSTR S);

@DllImport("ntdll.dll")
int RtlIpv6AddressToStringExA(const(IN6_ADDR)* Address, uint ScopeId, ushort Port, PSTR AddressString, 
                              uint* AddressStringLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ntdll.dll")
PWSTR RtlIpv6AddressToStringW(const(IN6_ADDR)* Addr, PWSTR S);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ntdll.dll")
int RtlIpv6AddressToStringExW(const(IN6_ADDR)* Address, uint ScopeId, ushort Port, PWSTR AddressString, 
                              uint* AddressStringLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ntdll.dll")
int RtlIpv6StringToAddressA(const(PSTR) S, const(PSTR)* Terminator, IN6_ADDR* Addr);

@DllImport("ntdll.dll")
int RtlIpv6StringToAddressExA(const(PSTR) AddressString, IN6_ADDR* Address, uint* ScopeId, ushort* Port);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ntdll.dll")
int RtlIpv6StringToAddressW(const(PWSTR) S, const(PWSTR)* Terminator, IN6_ADDR* Addr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ntdll.dll")
int RtlIpv6StringToAddressExW(const(PWSTR) AddressString, IN6_ADDR* Address, uint* ScopeId, ushort* Port);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("ntdll.dll")
PSTR RtlEthernetAddressToStringA(const(DL_EUI48)* Addr, PSTR S);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("ntdll.dll")
PWSTR RtlEthernetAddressToStringW(const(DL_EUI48)* Addr, PWSTR S);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("ntdll.dll")
int RtlEthernetStringToAddressA(const(PSTR) S, const(PSTR)* Terminator, DL_EUI48* Addr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("ntdll.dll")
int RtlEthernetStringToAddressW(const(PWSTR) S, const(PWSTR)* Terminator, DL_EUI48* Addr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSWSOCK.dll")
int WSARecvEx(SOCKET s, 
              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PSTR buf, 
              int len, int* flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("MSWSOCK.dll")
BOOL TransmitFile(SOCKET hSocket, HANDLE hFile, uint nNumberOfBytesToWrite, uint nNumberOfBytesPerSend, 
                  OVERLAPPED* lpOverlapped, TRANSMIT_FILE_BUFFERS* lpTransmitBuffers, uint dwReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("MSWSOCK.dll")
BOOL AcceptEx(SOCKET sListenSocket, SOCKET sAcceptSocket, void* lpOutputBuffer, uint dwReceiveDataLength, 
              uint dwLocalAddressLength, uint dwRemoteAddressLength, uint* lpdwBytesReceived, 
              OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("MSWSOCK.dll")
void GetAcceptExSockaddrs(void* lpOutputBuffer, uint dwReceiveDataLength, uint dwLocalAddressLength, 
                          uint dwRemoteAddressLength, SOCKADDR** LocalSockaddr, int* LocalSockaddrLength, 
                          SOCKADDR** RemoteSockaddr, int* RemoteSockaddrLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
int WSCEnumProtocols(int* lpiProtocols, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/WSAPROTOCOL_INFOW* lpProtocolBuffer, 
                     uint* lpdwBufferLength, int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
int WSCDeinstallProvider(GUID* lpProviderId, int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
int WSCInstallProvider(GUID* lpProviderId, const(PWSTR) lpszProviderDllPath, 
                       const(WSAPROTOCOL_INFOW)* lpProtocolInfoList, uint dwNumberOfEntries, int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
int WSCGetProviderPath(GUID* lpProviderId, PWSTR lpszProviderDllPath, int* lpProviderDllPathLen, int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("WS2_32.dll")
int WSCUpdateProvider(GUID* lpProviderId, const(PWSTR) lpszProviderDllPath, 
                      const(WSAPROTOCOL_INFOW)* lpProtocolInfoList, uint dwNumberOfEntries, int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WS2_32.dll")
int WSCSetProviderInfo(GUID* lpProviderId, WSC_PROVIDER_INFO_TYPE InfoType, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* Info, 
                       size_t InfoSize, uint Flags, int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WS2_32.dll")
int WSCGetProviderInfo(GUID* lpProviderId, WSC_PROVIDER_INFO_TYPE InfoType, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* Info, 
                       size_t* InfoSize, uint Flags, int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WS2_32.dll")
int WSCSetApplicationCategory(const(PWSTR) Path, uint PathLength, const(PWSTR) Extra, uint ExtraLength, 
                              uint PermittedLspCategories, uint* pPrevPermLspCat, int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WS2_32.dll")
int WSCGetApplicationCategory(const(PWSTR) Path, uint PathLength, const(PWSTR) Extra, uint ExtraLength, 
                              uint* pPermittedLspCategories, int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
int WPUCompleteOverlappedRequest(SOCKET s, OVERLAPPED* lpOverlapped, uint dwError, uint cbTransferred, 
                                 int* lpErrno);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
int WSCInstallNameSpace(PWSTR lpszIdentifier, PWSTR lpszPathName, uint dwNameSpace, uint dwVersion, 
                        GUID* lpProviderId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
int WSCUnInstallNameSpace(GUID* lpProviderId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WS2_32.dll")
int WSCInstallNameSpaceEx(PWSTR lpszIdentifier, PWSTR lpszPathName, uint dwNameSpace, uint dwVersion, 
                          GUID* lpProviderId, BLOB* lpProviderSpecific);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
int WSCEnableNSProvider(GUID* lpProviderId, BOOL fEnable);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WS2_32.dll")
int WSAAdvertiseProvider(const(GUID)* puuidProviderId, const(NSPV2_ROUTINE)* pNSPv2Routine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WS2_32.dll")
int WSAUnadvertiseProvider(const(GUID)* puuidProviderId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WS2_32.dll")
int WSAProviderCompleteAsyncCall(HANDLE hAsyncCall, int iRetCode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSWSOCK.dll")
int EnumProtocolsA(int* lpiProtocols, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpProtocolBuffer, 
                   uint* lpdwBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSWSOCK.dll")
int EnumProtocolsW(int* lpiProtocols, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpProtocolBuffer, 
                   uint* lpdwBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSWSOCK.dll")
int GetAddressByNameA(uint dwNameSpace, GUID* lpServiceType, PSTR lpServiceName, int* lpiProtocols, 
                      uint dwResolution, SERVICE_ASYNC_INFO* lpServiceAsyncInfo, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/void* lpCsaddrBuffer, 
                      uint* lpdwBufferLength, PSTR lpAliasBuffer, uint* lpdwAliasBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSWSOCK.dll")
int GetAddressByNameW(uint dwNameSpace, GUID* lpServiceType, PWSTR lpServiceName, int* lpiProtocols, 
                      uint dwResolution, SERVICE_ASYNC_INFO* lpServiceAsyncInfo, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/void* lpCsaddrBuffer, 
                      uint* lpdwBufferLength, PWSTR lpAliasBuffer, uint* lpdwAliasBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSWSOCK.dll")
int GetTypeByNameA(PSTR lpServiceName, GUID* lpServiceType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSWSOCK.dll")
int GetTypeByNameW(PWSTR lpServiceName, GUID* lpServiceType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSWSOCK.dll")
int GetNameByTypeA(GUID* lpServiceType, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PSTR lpServiceName, 
                   uint dwNameLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSWSOCK.dll")
int GetNameByTypeW(GUID* lpServiceType, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PWSTR lpServiceName, 
                   uint dwNameLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSWSOCK.dll")
int SetServiceA(uint dwNameSpace, SET_SERVICE_OPERATION dwOperation, uint dwFlags, SERVICE_INFOA* lpServiceInfo, 
                SERVICE_ASYNC_INFO* lpServiceAsyncInfo, uint* lpdwStatusFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSWSOCK.dll")
int SetServiceW(uint dwNameSpace, SET_SERVICE_OPERATION dwOperation, uint dwFlags, SERVICE_INFOW* lpServiceInfo, 
                SERVICE_ASYNC_INFO* lpServiceAsyncInfo, uint* lpdwStatusFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSWSOCK.dll")
int GetServiceA(uint dwNameSpace, GUID* lpGuid, PSTR lpServiceName, uint dwProperties, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* lpBuffer, 
                uint* lpdwBufferSize, SERVICE_ASYNC_INFO* lpServiceAsyncInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MSWSOCK.dll")
int GetServiceW(uint dwNameSpace, GUID* lpGuid, PWSTR lpServiceName, uint dwProperties, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* lpBuffer, 
                uint* lpdwBufferSize, SERVICE_ASYNC_INFO* lpServiceAsyncInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int getaddrinfo(const(PSTR) pNodeName, const(PSTR) pServiceName, const(ADDRINFOA)* pHints, ADDRINFOA** ppResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int GetAddrInfoW(const(PWSTR) pNodeName, const(PWSTR) pServiceName, const(ADDRINFOW)* pHints, ADDRINFOW** ppResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WS2_32.dll")
int GetAddrInfoExA(const(PSTR) pName, const(PSTR) pServiceName, uint dwNameSpace, GUID* lpNspId, 
                   const(ADDRINFOEXA)* hints, ADDRINFOEXA** ppResult, TIMEVAL* timeout, OVERLAPPED* lpOverlapped, 
                   LPLOOKUPSERVICE_COMPLETION_ROUTINE lpCompletionRoutine, HANDLE* lpNameHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WS2_32.dll")
int GetAddrInfoExW(const(PWSTR) pName, const(PWSTR) pServiceName, uint dwNameSpace, GUID* lpNspId, 
                   const(ADDRINFOEXW)* hints, ADDRINFOEXW** ppResult, TIMEVAL* timeout, OVERLAPPED* lpOverlapped, 
                   LPLOOKUPSERVICE_COMPLETION_ROUTINE lpCompletionRoutine, HANDLE* lpHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int GetAddrInfoExCancel(HANDLE* lpHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int GetAddrInfoExOverlappedResult(OVERLAPPED* lpOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int SetAddrInfoExA(const(PSTR) pName, const(PSTR) pServiceName, SOCKET_ADDRESS* pAddresses, uint dwAddressCount, 
                   BLOB* lpBlob, uint dwFlags, uint dwNameSpace, GUID* lpNspId, TIMEVAL* timeout, 
                   OVERLAPPED* lpOverlapped, LPLOOKUPSERVICE_COMPLETION_ROUTINE lpCompletionRoutine, 
                   HANDLE* lpNameHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int SetAddrInfoExW(const(PWSTR) pName, const(PWSTR) pServiceName, SOCKET_ADDRESS* pAddresses, uint dwAddressCount, 
                   BLOB* lpBlob, uint dwFlags, uint dwNameSpace, GUID* lpNspId, TIMEVAL* timeout, 
                   OVERLAPPED* lpOverlapped, LPLOOKUPSERVICE_COMPLETION_ROUTINE lpCompletionRoutine, 
                   HANDLE* lpNameHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
void freeaddrinfo(ADDRINFOA* pAddrInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
void FreeAddrInfoW(ADDRINFOW* pAddrInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
void FreeAddrInfoEx(ADDRINFOEXA* pAddrInfoEx);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
void FreeAddrInfoExW(ADDRINFOEXW* pAddrInfoEx);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int getnameinfo(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(SOCKADDR)* pSockaddr, 
                socklen_t SockaddrLength, 
                /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR pNodeBuffer, 
                uint NodeBufferSize, 
                /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR pServiceBuffer, 
                uint ServiceBufferSize, int Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int GetNameInfoW(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(SOCKADDR)* pSockaddr, 
                 socklen_t SockaddrLength, 
                 /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR pNodeBuffer, 
                 uint NodeBufferSize, 
                 /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR pServiceBuffer, 
                 uint ServiceBufferSize, int Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int inet_pton(int Family, const(PSTR) pszAddrString, void* pAddrBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
int InetPtonW(int Family, const(PWSTR) pszAddrString, void* pAddrBuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
PSTR inet_ntop(int Family, const(void)* pAddr, PSTR pStringBuf, size_t StringBufSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.1))], [])
@DllImport("WS2_32.dll")
PWSTR InetNtopW(int Family, const(void)* pAddr, PWSTR pStringBuf, size_t StringBufSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("fwpuclnt.dll")
int WSASetSocketSecurity(SOCKET Socket, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(SOCKET_SECURITY_SETTINGS)* SecuritySettings, 
                         uint SecuritySettingsLen, OVERLAPPED* Overlapped, 
                         LPWSAOVERLAPPED_COMPLETION_ROUTINE CompletionRoutine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("fwpuclnt.dll")
int WSAQuerySocketSecurity(SOCKET Socket, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(SOCKET_SECURITY_QUERY_TEMPLATE)* SecurityQueryTemplate, 
                           uint SecurityQueryTemplateLen, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/SOCKET_SECURITY_QUERY_INFO* SecurityQueryInfo, 
                           uint* SecurityQueryInfoLen, OVERLAPPED* Overlapped, 
                           LPWSAOVERLAPPED_COMPLETION_ROUTINE CompletionRoutine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("fwpuclnt.dll")
int WSASetSocketPeerTargetName(SOCKET Socket, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(SOCKET_PEER_TARGET_NAME)* PeerTargetName, 
                               uint PeerTargetNameLen, OVERLAPPED* Overlapped, 
                               LPWSAOVERLAPPED_COMPLETION_ROUTINE CompletionRoutine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("fwpuclnt.dll")
int WSADeleteSocketPeerTargetName(SOCKET Socket, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(SOCKADDR)* PeerAddr, 
                                  uint PeerAddrLen, OVERLAPPED* Overlapped, 
                                  LPWSAOVERLAPPED_COMPLETION_ROUTINE CompletionRoutine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("fwpuclnt.dll")
int WSAImpersonateSocketPeer(SOCKET Socket, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(SOCKADDR)* PeerAddr, 
                             uint PeerAddrLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("fwpuclnt.dll")
int WSARevertImpersonation();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("Windows.Networking.dll")
HRESULT SetSocketMediaStreamingMode(BOOL value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
int WSCWriteProviderOrder(uint* lpwdCatalogEntryId, uint dwNumberOfEntries);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WS2_32.dll")
int WSCWriteNameSpaceOrder(GUID* lpProviderId, uint dwNumberOfEntries);


