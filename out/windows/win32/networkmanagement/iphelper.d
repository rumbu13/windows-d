// Written in the D programming language.

module windows.win32.networkmanagement.iphelper;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, CHAR, HANDLE, PSTR, PWSTR,
                                         WIN32_ERROR;
public import windows.win32.networkmanagement.ndis : IF_OPER_STATUS, NDIS_MEDIUM, NDIS_PHYSICAL_MEDIUM,
                                                     NET_IF_ACCESS_TYPE, NET_IF_ADMIN_STATUS,
                                                     NET_IF_COMPARTMENT_ID,
                                                     NET_IF_CONNECTION_TYPE,
                                                     NET_IF_DIRECTION_TYPE,
                                                     NET_IF_MEDIA_CONNECT_STATE,
                                                     NET_LUID_LH, TUNNEL_TYPE;
public import windows.win32.networking.winsock : ADDRESS_FAMILY, IN6_ADDR, NL_BANDWIDTH_INFORMATION,
                                                 NL_DAD_STATE, NL_INTERFACE_OFFLOAD_ROD,
                                                 NL_LINK_LOCAL_ADDRESS_BEHAVIOR,
                                                 NL_NEIGHBOR_STATE, NL_NETWORK_CONNECTIVITY_HINT,
                                                 NL_PREFIX_ORIGIN, NL_ROUTER_DISCOVERY_BEHAVIOR,
                                                 NL_ROUTE_ORIGIN, NL_ROUTE_PROTOCOL,
                                                 NL_SUFFIX_ORIGIN, SCOPE_ID, SOCKADDR,
                                                 SOCKADDR_IN, SOCKADDR_IN6,
                                                 SOCKADDR_IN6_PAIR, SOCKADDR_INET,
                                                 SOCKET_ADDRESS;
public import windows.win32.system.io : OVERLAPPED, PIO_APC_ROUTINE;

extern(Windows) @nogc nothrow:


// Enums


alias GET_ADAPTERS_ADDRESSES_FLAGS = uint;
enum : uint
{
    GAA_FLAG_SKIP_UNICAST                = 0x00000001U,
    GAA_FLAG_SKIP_ANYCAST                = 0x00000002U,
    GAA_FLAG_SKIP_MULTICAST              = 0x00000004U,
    GAA_FLAG_SKIP_DNS_SERVER             = 0x00000008U,
    GAA_FLAG_INCLUDE_PREFIX              = 0x00000010U,
    GAA_FLAG_SKIP_FRIENDLY_NAME          = 0x00000020U,
    GAA_FLAG_INCLUDE_WINS_INFO           = 0x00000040U,
    GAA_FLAG_INCLUDE_GATEWAYS            = 0x00000080U,
    GAA_FLAG_INCLUDE_ALL_INTERFACES      = 0x00000100U,
    GAA_FLAG_INCLUDE_ALL_COMPARTMENTS    = 0x00000200U,
    GAA_FLAG_INCLUDE_TUNNEL_BINDINGORDER = 0x00000400U,
}

alias IF_ACCESS_TYPE = int;
enum : int
{
    IF_ACCESS_LOOPBACK             = 0x00000001,
    IF_ACCESS_BROADCAST            = 0x00000002,
    IF_ACCESS_POINT_TO_POINT       = 0x00000003,
    IF_ACCESS_POINTTOPOINT         = 0x00000003,
    IF_ACCESS_POINT_TO_MULTI_POINT = 0x00000004,
    IF_ACCESS_POINTTOMULTIPOINT    = 0x00000004,
}

alias INTERNAL_IF_OPER_STATUS = int;
enum : int
{
    IF_OPER_STATUS_NON_OPERATIONAL = 0x00000000,
    IF_OPER_STATUS_UNREACHABLE     = 0x00000001,
    IF_OPER_STATUS_DISCONNECTED    = 0x00000002,
    IF_OPER_STATUS_CONNECTING      = 0x00000003,
    IF_OPER_STATUS_CONNECTED       = 0x00000004,
    IF_OPER_STATUS_OPERATIONAL     = 0x00000005,
}

alias MIB_IPFORWARD_TYPE = int;
enum : int
{
    MIB_IPROUTE_TYPE_OTHER    = 0x00000001,
    MIB_IPROUTE_TYPE_INVALID  = 0x00000002,
    MIB_IPROUTE_TYPE_DIRECT   = 0x00000003,
    MIB_IPROUTE_TYPE_INDIRECT = 0x00000004,
}

alias MIB_IPNET_TYPE = int;
enum : int
{
    MIB_IPNET_TYPE_OTHER   = 0x00000001,
    MIB_IPNET_TYPE_INVALID = 0x00000002,
    MIB_IPNET_TYPE_DYNAMIC = 0x00000003,
    MIB_IPNET_TYPE_STATIC  = 0x00000004,
}

alias MIB_IPSTATS_FORWARDING = int;
enum : int
{
    MIB_IP_FORWARDING     = 0x00000001,
    MIB_IP_NOT_FORWARDING = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ne-ipmib-icmp6_type
alias ICMP6_TYPE = int;
enum : int
{
    ICMP6_DST_UNREACH          = 0x00000001,
    ICMP6_PACKET_TOO_BIG       = 0x00000002,
    ICMP6_TIME_EXCEEDED        = 0x00000003,
    ICMP6_PARAM_PROB           = 0x00000004,
    ICMP6_ECHO_REQUEST         = 0x00000080,
    ICMP6_ECHO_REPLY           = 0x00000081,
    ICMP6_MEMBERSHIP_QUERY     = 0x00000082,
    ICMP6_MEMBERSHIP_REPORT    = 0x00000083,
    ICMP6_MEMBERSHIP_REDUCTION = 0x00000084,
    ND_ROUTER_SOLICIT          = 0x00000085,
    ND_ROUTER_ADVERT           = 0x00000086,
    ND_NEIGHBOR_SOLICIT        = 0x00000087,
    ND_NEIGHBOR_ADVERT         = 0x00000088,
    ND_REDIRECT                = 0x00000089,
    ICMP6_V2_MEMBERSHIP_REPORT = 0x0000008f,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ne-ipmib-icmp4_type
alias ICMP4_TYPE = int;
enum : int
{
    ICMP4_ECHO_REPLY        = 0x00000000,
    ICMP4_DST_UNREACH       = 0x00000003,
    ICMP4_SOURCE_QUENCH     = 0x00000004,
    ICMP4_REDIRECT          = 0x00000005,
    ICMP4_ECHO_REQUEST      = 0x00000008,
    ICMP4_ROUTER_ADVERT     = 0x00000009,
    ICMP4_ROUTER_SOLICIT    = 0x0000000a,
    ICMP4_TIME_EXCEEDED     = 0x0000000b,
    ICMP4_PARAM_PROB        = 0x0000000c,
    ICMP4_TIMESTAMP_REQUEST = 0x0000000d,
    ICMP4_TIMESTAMP_REPLY   = 0x0000000e,
    ICMP4_MASK_REQUEST      = 0x00000011,
    ICMP4_MASK_REPLY        = 0x00000012,
}

alias MIB_TCP_STATE = int;
enum : int
{
    MIB_TCP_STATE_CLOSED     = 0x00000001,
    MIB_TCP_STATE_LISTEN     = 0x00000002,
    MIB_TCP_STATE_SYN_SENT   = 0x00000003,
    MIB_TCP_STATE_SYN_RCVD   = 0x00000004,
    MIB_TCP_STATE_ESTAB      = 0x00000005,
    MIB_TCP_STATE_FIN_WAIT1  = 0x00000006,
    MIB_TCP_STATE_FIN_WAIT2  = 0x00000007,
    MIB_TCP_STATE_CLOSE_WAIT = 0x00000008,
    MIB_TCP_STATE_CLOSING    = 0x00000009,
    MIB_TCP_STATE_LAST_ACK   = 0x0000000a,
    MIB_TCP_STATE_TIME_WAIT  = 0x0000000b,
    MIB_TCP_STATE_DELETE_TCB = 0x0000000c,
    MIB_TCP_STATE_RESERVED   = 0x00000064,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpmib/ne-tcpmib-tcp_connection_offload_state
alias TCP_CONNECTION_OFFLOAD_STATE = int;
enum : int
{
    TcpConnectionOffloadStateInHost     = 0x00000000,
    TcpConnectionOffloadStateOffloading = 0x00000001,
    TcpConnectionOffloadStateOffloaded  = 0x00000002,
    TcpConnectionOffloadStateUploading  = 0x00000003,
    TcpConnectionOffloadStateMax        = 0x00000004,
}

alias TCP_RTO_ALGORITHM = int;
enum : int
{
    TcpRtoAlgorithmOther    = 0x00000001,
    TcpRtoAlgorithmConstant = 0x00000002,
    TcpRtoAlgorithmRsre     = 0x00000003,
    TcpRtoAlgorithmVanj     = 0x00000004,
    MIB_TCP_RTO_OTHER       = 0x00000001,
    MIB_TCP_RTO_CONSTANT    = 0x00000002,
    MIB_TCP_RTO_RSRE        = 0x00000003,
    MIB_TCP_RTO_VANJ        = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iprtrmib/ne-iprtrmib-tcp_table_class
alias TCP_TABLE_CLASS = int;
enum : int
{
    TCP_TABLE_BASIC_LISTENER           = 0x00000000,
    TCP_TABLE_BASIC_CONNECTIONS        = 0x00000001,
    TCP_TABLE_BASIC_ALL                = 0x00000002,
    TCP_TABLE_OWNER_PID_LISTENER       = 0x00000003,
    TCP_TABLE_OWNER_PID_CONNECTIONS    = 0x00000004,
    TCP_TABLE_OWNER_PID_ALL            = 0x00000005,
    TCP_TABLE_OWNER_MODULE_LISTENER    = 0x00000006,
    TCP_TABLE_OWNER_MODULE_CONNECTIONS = 0x00000007,
    TCP_TABLE_OWNER_MODULE_ALL         = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iprtrmib/ne-iprtrmib-udp_table_class
alias UDP_TABLE_CLASS = int;
enum : int
{
    UDP_TABLE_BASIC        = 0x00000000,
    UDP_TABLE_OWNER_PID    = 0x00000001,
    UDP_TABLE_OWNER_MODULE = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iprtrmib/ne-iprtrmib-tcpip_owner_module_info_class
alias TCPIP_OWNER_MODULE_INFO_CLASS = int;
enum : int
{
    TCPIP_OWNER_MODULE_INFO_BASIC = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpestats/ne-tcpestats-tcp_estats_type
alias TCP_ESTATS_TYPE = int;
enum : int
{
    TcpConnectionEstatsSynOpts   = 0x00000000,
    TcpConnectionEstatsData      = 0x00000001,
    TcpConnectionEstatsSndCong   = 0x00000002,
    TcpConnectionEstatsPath      = 0x00000003,
    TcpConnectionEstatsSendBuff  = 0x00000004,
    TcpConnectionEstatsRec       = 0x00000005,
    TcpConnectionEstatsObsRec    = 0x00000006,
    TcpConnectionEstatsBandwidth = 0x00000007,
    TcpConnectionEstatsFineRtt   = 0x00000008,
    TcpConnectionEstatsMaximum   = 0x00000009,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpestats/ne-tcpestats-tcp_boolean_optional
alias TCP_BOOLEAN_OPTIONAL = int;
enum : int
{
    TcpBoolOptDisabled  = 0x00000000,
    TcpBoolOptEnabled   = 0x00000001,
    TcpBoolOptUnchanged = 0xffffffff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpestats/ne-tcpestats-tcp_soft_error
alias TCP_SOFT_ERROR = int;
enum : int
{
    TcpErrorNone              = 0x00000000,
    TcpErrorBelowDataWindow   = 0x00000001,
    TcpErrorAboveDataWindow   = 0x00000002,
    TcpErrorBelowAckWindow    = 0x00000003,
    TcpErrorAboveAckWindow    = 0x00000004,
    TcpErrorBelowTsWindow     = 0x00000005,
    TcpErrorAboveTsWindow     = 0x00000006,
    TcpErrorDataChecksumError = 0x00000007,
    TcpErrorDataLengthError   = 0x00000008,
    TcpErrorMaxSoftError      = 0x00000009,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iphlpapi/ne-iphlpapi-net_address_format
alias NET_ADDRESS_FORMAT = int;
enum : int
{
    NET_ADDRESS_FORMAT_UNSPECIFIED = 0x00000000,
    NET_ADDRESS_DNS_NAME           = 0x00000001,
    NET_ADDRESS_IPV4               = 0x00000002,
    NET_ADDRESS_IPV6               = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ne-netioapi-mib_notification_type
alias MIB_NOTIFICATION_TYPE = int;
enum : int
{
    MibParameterNotification = 0x00000000,
    MibAddInstance           = 0x00000001,
    MibDeleteInstance        = 0x00000002,
    MibInitialNotification   = 0x00000003,
}

alias MIB_IF_ENTRY_LEVEL = int;
enum : int
{
    MibIfEntryNormal                  = 0x00000000,
    MibIfEntryNormalWithoutStatistics = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ne-netioapi-mib_if_table_level
alias MIB_IF_TABLE_LEVEL = int;
enum : int
{
    MibIfTableNormal                  = 0x00000000,
    MibIfTableRaw                     = 0x00000001,
    MibIfTableNormalWithoutStatistics = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ne-netioapi-dns_server_property_type
alias DNS_SERVER_PROPERTY_TYPE = int;
enum : int
{
    DnsServerInvalidProperty = 0x00000000,
    DnsServerDohProperty     = 0x00000001,
    DnsServerDotProperty     = 0x00000002,
}

alias NET_FL_VIRTUAL_INTERFACE_ORIGIN = int;
enum : int
{
    NetFlVirtualInterfaceOriginOid     = 0x00000000,
    NetFlVirtualInterfaceOriginApi     = 0x00000001,
    NetFlVirtualInterfaceOriginDefault = 0x00000002,
}

alias NET_FL_ISOLATION_MODE = int;
enum : int
{
    NetFlIsolationModeNone = 0x00000000,
    NetFlIsolationModeVlan = 0x00000001,
    NetFlIsolationModeVsid = 0x00000002,
}

alias GLOBAL_FILTER = int;
enum : int
{
    GF_FRAGMENTS  = 0x00000002,
    GF_STRONGHOST = 0x00000008,
    GF_FRAGCACHE  = 0x00000009,
}

alias PFFORWARD_ACTION = int;
enum : int
{
    PF_ACTION_FORWARD = 0x00000000,
    PF_ACTION_DROP    = 0x00000001,
}

alias PFADDRESSTYPE = int;
enum : int
{
    PF_IPV4 = 0x00000000,
    PF_IPV6 = 0x00000001,
}

alias PFFRAMETYPE = int;
enum : int
{
    PFFT_FILTER = 0x00000001,
    PFFT_FRAG   = 0x00000002,
    PFFT_SPOOF  = 0x00000003,
}

// Constants


enum uint ANY_SIZE = 0x00000001U;

enum : uint
{
    MAXLEN_PHYSADDR = 0x00000008U,
    MAXLEN_IFDESCR  = 0x00000100U,
}

enum uint MAX_INTERFACE_NAME_LEN = 0x00000100U;
enum uint MIN_IF_TYPE = 0x00000001U;

enum : uint
{
    IF_TYPE_OTHER        = 0x00000001U,
    IF_TYPE_REGULAR_1822 = 0x00000002U,
}

enum : uint
{
    IF_TYPE_HDH_1822        = 0x00000003U,
    IF_TYPE_DDN_X25         = 0x00000004U,
    IF_TYPE_RFC877_X25      = 0x00000005U,
    IF_TYPE_ETHERNET_CSMACD = 0x00000006U,
}

enum : uint
{
    IF_TYPE_IS088023_CSMACD    = 0x00000007U,
    IF_TYPE_ISO88024_TOKENBUS  = 0x00000008U,
    IF_TYPE_ISO88025_TOKENRING = 0x00000009U,
    IF_TYPE_ISO88026_MAN       = 0x0000000aU,
}

enum : uint
{
    IF_TYPE_STARLAN        = 0x0000000bU,
    IF_TYPE_PROTEON_10MBIT = 0x0000000cU,
    IF_TYPE_PROTEON_80MBIT = 0x0000000dU,
}

enum uint IF_TYPE_HYPERCHANNEL = 0x0000000eU;

enum : uint
{
    IF_TYPE_FDDI                    = 0x0000000fU,
    IF_TYPE_LAP_B                   = 0x00000010U,
    IF_TYPE_SDLC                    = 0x00000011U,
    IF_TYPE_DS1                     = 0x00000012U,
    IF_TYPE_E1                      = 0x00000013U,
    IF_TYPE_BASIC_ISDN              = 0x00000014U,
    IF_TYPE_PRIMARY_ISDN            = 0x00000015U,
    IF_TYPE_PROP_POINT2POINT_SERIAL = 0x00000016U,
}

enum : uint
{
    IF_TYPE_PPP               = 0x00000017U,
    IF_TYPE_SOFTWARE_LOOPBACK = 0x00000018U,
}

enum : uint
{
    IF_TYPE_EON            = 0x00000019U,
    IF_TYPE_ETHERNET_3MBIT = 0x0000001aU,
}

enum : uint
{
    IF_TYPE_NSIP         = 0x0000001bU,
    IF_TYPE_SLIP         = 0x0000001cU,
    IF_TYPE_ULTRA        = 0x0000001dU,
    IF_TYPE_DS3          = 0x0000001eU,
    IF_TYPE_SIP          = 0x0000001fU,
    IF_TYPE_FRAMERELAY   = 0x00000020U,
    IF_TYPE_RS232        = 0x00000021U,
    IF_TYPE_PARA         = 0x00000022U,
    IF_TYPE_ARCNET       = 0x00000023U,
    IF_TYPE_ARCNET_PLUS  = 0x00000024U,
    IF_TYPE_ATM          = 0x00000025U,
    IF_TYPE_MIO_X25      = 0x00000026U,
    IF_TYPE_SONET        = 0x00000027U,
    IF_TYPE_X25_PLE      = 0x00000028U,
    IF_TYPE_ISO88022_LLC = 0x00000029U,
}

enum : uint
{
    IF_TYPE_LOCALTALK          = 0x0000002aU,
    IF_TYPE_SMDS_DXI           = 0x0000002bU,
    IF_TYPE_FRAMERELAY_SERVICE = 0x0000002cU,
}

enum : uint
{
    IF_TYPE_V35              = 0x0000002dU,
    IF_TYPE_HSSI             = 0x0000002eU,
    IF_TYPE_HIPPI            = 0x0000002fU,
    IF_TYPE_MODEM            = 0x00000030U,
    IF_TYPE_AAL5             = 0x00000031U,
    IF_TYPE_SONET_PATH       = 0x00000032U,
    IF_TYPE_SONET_VT         = 0x00000033U,
    IF_TYPE_SMDS_ICIP        = 0x00000034U,
    IF_TYPE_PROP_VIRTUAL     = 0x00000035U,
    IF_TYPE_PROP_MULTIPLEXOR = 0x00000036U,
}

enum : uint
{
    IF_TYPE_IEEE80212    = 0x00000037U,
    IF_TYPE_FIBRECHANNEL = 0x00000038U,
}

enum uint IF_TYPE_HIPPIINTERFACE = 0x00000039U;
enum uint IF_TYPE_FRAMERELAY_INTERCONNECT = 0x0000003aU;

enum : uint
{
    IF_TYPE_AFLANE_8023  = 0x0000003bU,
    IF_TYPE_AFLANE_8025  = 0x0000003cU,
    IF_TYPE_CCTEMUL      = 0x0000003dU,
    IF_TYPE_FASTETHER    = 0x0000003eU,
    IF_TYPE_ISDN         = 0x0000003fU,
    IF_TYPE_V11          = 0x00000040U,
    IF_TYPE_V36          = 0x00000041U,
    IF_TYPE_G703_64K     = 0x00000042U,
    IF_TYPE_G703_2MB     = 0x00000043U,
    IF_TYPE_QLLC         = 0x00000044U,
    IF_TYPE_FASTETHER_FX = 0x00000045U,
}

enum : uint
{
    IF_TYPE_CHANNEL       = 0x00000046U,
    IF_TYPE_IEEE80211     = 0x00000047U,
    IF_TYPE_IBM370PARCHAN = 0x00000048U,
}

enum : uint
{
    IF_TYPE_ESCON         = 0x00000049U,
    IF_TYPE_DLSW          = 0x0000004aU,
    IF_TYPE_ISDN_S        = 0x0000004bU,
    IF_TYPE_ISDN_U        = 0x0000004cU,
    IF_TYPE_LAP_D         = 0x0000004dU,
    IF_TYPE_IPSWITCH      = 0x0000004eU,
    IF_TYPE_RSRB          = 0x0000004fU,
    IF_TYPE_ATM_LOGICAL   = 0x00000050U,
    IF_TYPE_DS0           = 0x00000051U,
    IF_TYPE_DS0_BUNDLE    = 0x00000052U,
    IF_TYPE_BSC           = 0x00000053U,
    IF_TYPE_ASYNC         = 0x00000054U,
    IF_TYPE_CNR           = 0x00000055U,
    IF_TYPE_ISO88025R_DTR = 0x00000056U,
}

enum : uint
{
    IF_TYPE_EPLRS          = 0x00000057U,
    IF_TYPE_ARAP           = 0x00000058U,
    IF_TYPE_PROP_CNLS      = 0x00000059U,
    IF_TYPE_HOSTPAD        = 0x0000005aU,
    IF_TYPE_TERMPAD        = 0x0000005bU,
    IF_TYPE_FRAMERELAY_MPI = 0x0000005cU,
}

enum : uint
{
    IF_TYPE_X213              = 0x0000005dU,
    IF_TYPE_ADSL              = 0x0000005eU,
    IF_TYPE_RADSL             = 0x0000005fU,
    IF_TYPE_SDSL              = 0x00000060U,
    IF_TYPE_VDSL              = 0x00000061U,
    IF_TYPE_ISO88025_CRFPRINT = 0x00000062U,
}

enum : uint
{
    IF_TYPE_MYRINET      = 0x00000063U,
    IF_TYPE_VOICE_EM     = 0x00000064U,
    IF_TYPE_VOICE_FXO    = 0x00000065U,
    IF_TYPE_VOICE_FXS    = 0x00000066U,
    IF_TYPE_VOICE_ENCAP  = 0x00000067U,
    IF_TYPE_VOICE_OVERIP = 0x00000068U,
}

enum : uint
{
    IF_TYPE_ATM_DXI            = 0x00000069U,
    IF_TYPE_ATM_FUNI           = 0x0000006aU,
    IF_TYPE_ATM_IMA            = 0x0000006bU,
    IF_TYPE_PPPMULTILINKBUNDLE = 0x0000006cU,
}

enum : uint
{
    IF_TYPE_IPOVER_CDLC  = 0x0000006dU,
    IF_TYPE_IPOVER_CLAW  = 0x0000006eU,
    IF_TYPE_STACKTOSTACK = 0x0000006fU,
}

enum uint IF_TYPE_VIRTUALIPADDRESS = 0x00000070U;

enum : uint
{
    IF_TYPE_MPC            = 0x00000071U,
    IF_TYPE_IPOVER_ATM     = 0x00000072U,
    IF_TYPE_ISO88025_FIBER = 0x00000073U,
}

enum : uint
{
    IF_TYPE_TDLC            = 0x00000074U,
    IF_TYPE_GIGABITETHERNET = 0x00000075U,
}

enum : uint
{
    IF_TYPE_HDLC          = 0x00000076U,
    IF_TYPE_LAP_F         = 0x00000077U,
    IF_TYPE_V37           = 0x00000078U,
    IF_TYPE_X25_MLP       = 0x00000079U,
    IF_TYPE_X25_HUNTGROUP = 0x0000007aU,
}

enum : uint
{
    IF_TYPE_TRANSPHDLC           = 0x0000007bU,
    IF_TYPE_INTERLEAVE           = 0x0000007cU,
    IF_TYPE_FAST                 = 0x0000007dU,
    IF_TYPE_IP                   = 0x0000007eU,
    IF_TYPE_DOCSCABLE_MACLAYER   = 0x0000007fU,
    IF_TYPE_DOCSCABLE_DOWNSTREAM = 0x00000080U,
    IF_TYPE_DOCSCABLE_UPSTREAM   = 0x00000081U,
}

enum uint IF_TYPE_A12MPPSWITCH = 0x00000082U;

enum : uint
{
    IF_TYPE_TUNNEL           = 0x00000083U,
    IF_TYPE_COFFEE           = 0x00000084U,
    IF_TYPE_CES              = 0x00000085U,
    IF_TYPE_ATM_SUBINTERFACE = 0x00000086U,
}

enum : uint
{
    IF_TYPE_L2_VLAN          = 0x00000087U,
    IF_TYPE_L3_IPVLAN        = 0x00000088U,
    IF_TYPE_L3_IPXVLAN       = 0x00000089U,
    IF_TYPE_DIGITALPOWERLINE = 0x0000008aU,
}

enum uint IF_TYPE_MEDIAMAILOVERIP = 0x0000008bU;

enum : uint
{
    IF_TYPE_DTM               = 0x0000008cU,
    IF_TYPE_DCN               = 0x0000008dU,
    IF_TYPE_IPFORWARD         = 0x0000008eU,
    IF_TYPE_MSDSL             = 0x0000008fU,
    IF_TYPE_IEEE1394          = 0x00000090U,
    IF_TYPE_IF_GSN            = 0x00000091U,
    IF_TYPE_DVBRCC_MACLAYER   = 0x00000092U,
    IF_TYPE_DVBRCC_DOWNSTREAM = 0x00000093U,
    IF_TYPE_DVBRCC_UPSTREAM   = 0x00000094U,
}

enum : uint
{
    IF_TYPE_ATM_VIRTUAL         = 0x00000095U,
    IF_TYPE_MPLS_TUNNEL         = 0x00000096U,
    IF_TYPE_SRP                 = 0x00000097U,
    IF_TYPE_VOICEOVERATM        = 0x00000098U,
    IF_TYPE_VOICEOVERFRAMERELAY = 0x00000099U,
}

enum : uint
{
    IF_TYPE_IDSL          = 0x0000009aU,
    IF_TYPE_COMPOSITELINK = 0x0000009bU,
}

enum : uint
{
    IF_TYPE_SS7_SIGLINK       = 0x0000009cU,
    IF_TYPE_PROP_WIRELESS_P2P = 0x0000009dU,
}

enum : uint
{
    IF_TYPE_FR_FORWARD     = 0x0000009eU,
    IF_TYPE_RFC1483        = 0x0000009fU,
    IF_TYPE_USB            = 0x000000a0U,
    IF_TYPE_IEEE8023AD_LAG = 0x000000a1U,
}

enum uint IF_TYPE_BGP_POLICY_ACCOUNTING = 0x000000a2U;
enum uint IF_TYPE_FRF16_MFR_BUNDLE = 0x000000a3U;

enum : uint
{
    IF_TYPE_H323_GATEKEEPER               = 0x000000a4U,
    IF_TYPE_H323_PROXY                    = 0x000000a5U,
    IF_TYPE_MPLS                          = 0x000000a6U,
    IF_TYPE_MF_SIGLINK                    = 0x000000a7U,
    IF_TYPE_HDSL2                         = 0x000000a8U,
    IF_TYPE_SHDSL                         = 0x000000a9U,
    IF_TYPE_DS1_FDL                       = 0x000000aaU,
    IF_TYPE_POS                           = 0x000000abU,
    IF_TYPE_DVB_ASI_IN                    = 0x000000acU,
    IF_TYPE_DVB_ASI_OUT                   = 0x000000adU,
    IF_TYPE_PLC                           = 0x000000aeU,
    IF_TYPE_NFAS                          = 0x000000afU,
    IF_TYPE_TR008                         = 0x000000b0U,
    IF_TYPE_GR303_RDT                     = 0x000000b1U,
    IF_TYPE_GR303_IDT                     = 0x000000b2U,
    IF_TYPE_ISUP                          = 0x000000b3U,
    IF_TYPE_PROP_DOCS_WIRELESS_MACLAYER   = 0x000000b4U,
    IF_TYPE_PROP_DOCS_WIRELESS_DOWNSTREAM = 0x000000b5U,
    IF_TYPE_PROP_DOCS_WIRELESS_UPSTREAM   = 0x000000b6U,
}

enum : uint
{
    IF_TYPE_HIPERLAN2     = 0x000000b7U,
    IF_TYPE_PROP_BWA_P2MP = 0x000000b8U,
}

enum uint IF_TYPE_SONET_OVERHEAD_CHANNEL = 0x000000b9U;
enum uint IF_TYPE_DIGITAL_WRAPPER_OVERHEAD_CHANNEL = 0x000000baU;

enum : uint
{
    IF_TYPE_AAL2          = 0x000000bbU,
    IF_TYPE_RADIO_MAC     = 0x000000bcU,
    IF_TYPE_ATM_RADIO     = 0x000000bdU,
    IF_TYPE_IMT           = 0x000000beU,
    IF_TYPE_MVL           = 0x000000bfU,
    IF_TYPE_REACH_DSL     = 0x000000c0U,
    IF_TYPE_FR_DLCI_ENDPT = 0x000000c1U,
}

enum uint IF_TYPE_ATM_VCI_ENDPT = 0x000000c2U;

enum : uint
{
    IF_TYPE_OPTICAL_CHANNEL   = 0x000000c3U,
    IF_TYPE_OPTICAL_TRANSPORT = 0x000000c4U,
}

enum uint IF_TYPE_IEEE80216_WMAN = 0x000000edU;

enum : uint
{
    IF_TYPE_WWANPP        = 0x000000f3U,
    IF_TYPE_WWANPP2       = 0x000000f4U,
    IF_TYPE_IEEE802154    = 0x00000103U,
    IF_TYPE_XBOX_WIRELESS = 0x00000119U,
}

enum uint MAX_IF_TYPE = 0x00000119U;

enum : uint
{
    IF_CHECK_NONE  = 0x00000000U,
    IF_CHECK_MCAST = 0x00000001U,
    IF_CHECK_SEND  = 0x00000002U,
}

enum : uint
{
    IF_CONNECTION_DEDICATED = 0x00000001U,
    IF_CONNECTION_PASSIVE   = 0x00000002U,
    IF_CONNECTION_DEMAND    = 0x00000003U,
}

enum : uint
{
    IF_ADMIN_STATUS_UP      = 0x00000001U,
    IF_ADMIN_STATUS_DOWN    = 0x00000002U,
    IF_ADMIN_STATUS_TESTING = 0x00000003U,
}

enum : uint
{
    MIB_IF_TYPE_OTHER           = 0x00000001U,
    MIB_IF_TYPE_ETHERNET        = 0x00000006U,
    MIB_IF_TYPE_TOKENRING       = 0x00000009U,
    MIB_IF_TYPE_FDDI            = 0x0000000fU,
    MIB_IF_TYPE_PPP             = 0x00000017U,
    MIB_IF_TYPE_LOOPBACK        = 0x00000018U,
    MIB_IF_TYPE_SLIP            = 0x0000001cU,
    MIB_IF_ADMIN_STATUS_UP      = 0x00000001U,
    MIB_IF_ADMIN_STATUS_DOWN    = 0x00000002U,
    MIB_IF_ADMIN_STATUS_TESTING = 0x00000003U,
}

enum : uint
{
    MIB_IPADDR_PRIMARY      = 0x00000001U,
    MIB_IPADDR_DYNAMIC      = 0x00000004U,
    MIB_IPADDR_DISCONNECTED = 0x00000008U,
    MIB_IPADDR_DELETED      = 0x00000040U,
    MIB_IPADDR_TRANSIENT    = 0x00000080U,
    MIB_IPADDR_DNS_ELIGIBLE = 0x00000100U,
}

enum uint MIB_IPROUTE_METRIC_UNUSED = 0xffffffffU;

enum : uint
{
    MIB_USE_CURRENT_TTL        = 0xffffffffU,
    MIB_USE_CURRENT_FORWARDING = 0xffffffffU,
}

enum uint ICMP6_INFOMSG_MASK = 0x00000080U;
enum uint IPRTRMGR_PID = 0x00002710U;
enum uint IF_NUMBER = 0x00000000U;
enum uint IF_TABLE = 0x00000001U;
enum uint IF_ROW = 0x00000002U;
enum uint IP_STATS = 0x00000003U;

enum : uint
{
    IP_ADDRTABLE = 0x00000004U,
    IP_ADDRROW   = 0x00000005U,
}

enum : uint
{
    IP_FORWARDNUMBER = 0x00000006U,
    IP_FORWARDTABLE  = 0x00000007U,
    IP_FORWARDROW    = 0x00000008U,
}

enum : uint
{
    IP_NETTABLE = 0x00000009U,
    IP_NETROW   = 0x0000000aU,
}

enum uint ICMP_STATS = 0x0000000bU;

enum : uint
{
    TCP_STATS = 0x0000000cU,
    TCP_TABLE = 0x0000000dU,
    TCP_ROW   = 0x0000000eU,
}

enum : uint
{
    UDP_STATS = 0x0000000fU,
    UDP_TABLE = 0x00000010U,
    UDP_ROW   = 0x00000011U,
}

enum : uint
{
    MCAST_MFE       = 0x00000012U,
    MCAST_MFE_STATS = 0x00000013U,
}

enum : uint
{
    BEST_IF    = 0x00000014U,
    BEST_ROUTE = 0x00000015U,
}

enum uint PROXY_ARP = 0x00000016U;

enum : uint
{
    MCAST_IF_ENTRY = 0x00000017U,
    MCAST_GLOBAL   = 0x00000018U,
}

enum uint IF_STATUS = 0x00000019U;

enum : uint
{
    MCAST_BOUNDARY = 0x0000001aU,
    MCAST_SCOPE    = 0x0000001bU,
}

enum uint DEST_MATCHING = 0x0000001cU;

enum : uint
{
    DEST_LONGER  = 0x0000001dU,
    DEST_SHORTER = 0x0000001eU,
}

enum : uint
{
    ROUTE_MATCHING = 0x0000001fU,
    ROUTE_LONGER   = 0x00000020U,
    ROUTE_SHORTER  = 0x00000021U,
    ROUTE_STATE    = 0x00000022U,
}

enum uint MCAST_MFE_STATS_EX = 0x00000023U;
enum uint IP6_STATS = 0x00000024U;
enum uint UDP6_STATS = 0x00000025U;
enum uint TCP6_STATS = 0x00000026U;
enum uint NUMBER_OF_EXPORTED_VARIABLES = 0x00000027U;
enum uint MAX_SCOPE_NAME_LEN = 0x000000ffU;
enum uint MAX_MIB_OFFSET = 0x00000008U;
enum uint MIB_INVALID_TEREDO_PORT_NUMBER = 0x00000000U;

enum : uint
{
    DNS_SETTINGS_VERSION1 = 0x00000001U,
    DNS_SETTINGS_VERSION2 = 0x00000002U,
}

enum : uint
{
    DNS_INTERFACE_SETTINGS_VERSION1 = 0x00000001U,
    DNS_INTERFACE_SETTINGS_VERSION2 = 0x00000002U,
    DNS_INTERFACE_SETTINGS_VERSION3 = 0x00000003U,
    DNS_INTERFACE_SETTINGS_VERSION4 = 0x00000004U,
}

enum : uint
{
    DNS_SETTING_IPV6                  = 0x00000001U,
    DNS_SETTING_NAMESERVER            = 0x00000002U,
    DNS_SETTING_SEARCHLIST            = 0x00000004U,
    DNS_SETTING_REGISTRATION_ENABLED  = 0x00000008U,
    DNS_SETTING_REGISTER_ADAPTER_NAME = 0x00000010U,
}

enum : uint
{
    DNS_SETTING_DOMAIN              = 0x00000020U,
    DNS_SETTING_HOSTNAME            = 0x00000040U,
    DNS_SETTINGS_ENABLE_LLMNR       = 0x00000080U,
    DNS_SETTINGS_QUERY_ADAPTER_NAME = 0x00000100U,
}

enum uint DNS_SETTING_PROFILE_NAMESERVER = 0x00000200U;
enum uint DNS_SETTING_DISABLE_UNCONSTRAINED_QUERIES = 0x00000400U;
enum uint DNS_SETTING_SUPPLEMENTAL_SEARCH_LIST = 0x00000800U;

enum : uint
{
    DNS_SETTING_DOH                         = 0x00001000U,
    DNS_SETTING_DOH_PROFILE                 = 0x00002000U,
    DNS_SETTING_ENCRYPTED_DNS_ADAPTER_FLAGS = 0x00004000U,
}

enum : uint
{
    DNS_SETTING_DDR         = 0x00008000U,
    DNS_SETTING_DOT         = 0x00010000U,
    DNS_SETTING_DOT_PROFILE = 0x00020000U,
}

enum uint DNS_ENABLE_DOH = 0x00000001U;

enum : uint
{
    DNS_DOH_POLICY_NOT_CONFIGURED = 0x00000004U,
    DNS_DOH_POLICY_DISABLE        = 0x00000008U,
    DNS_DOH_POLICY_AUTO           = 0x00000010U,
    DNS_DOH_POLICY_REQUIRED       = 0x00000020U,
}

enum : uint
{
    DNS_ENCRYPTION_POLICY_NOT_CONFIGURED = 0x00000004U,
    DNS_ENCRYPTION_POLICY_DISABLE        = 0x00000008U,
    DNS_ENCRYPTION_POLICY_AUTO           = 0x00000010U,
    DNS_ENCRYPTION_POLICY_REQUIRED       = 0x00000020U,
}

enum : uint
{
    DNS_ENABLE_DDR = 0x00000040U,
    DNS_ENABLE_DOT = 0x00000080U,
}

enum uint DNS_DOT_POLICY_BLOCK = 0x00000100U;
enum uint DNS_DOH_POLICY_BLOCK = 0x00000200U;
enum uint DNS_ENABLE_DNR = 0x00000400U;
enum uint DNS_SERVER_PROPERTY_VERSION1 = 0x00000001U;

enum : uint
{
    DNS_DOH_SERVER_SETTINGS_ENABLE_AUTO     = 0x00000001U,
    DNS_DOH_SERVER_SETTINGS_ENABLE          = 0x00000002U,
    DNS_DOH_SERVER_SETTINGS_FALLBACK_TO_UDP = 0x00000004U,
}

enum uint DNS_DOH_AUTO_UPGRADE_SERVER = 0x00000008U;

enum : uint
{
    DNS_DOH_SERVER_SETTINGS_ENABLE_DDR            = 0x00000010U,
    DNS_DOH_SERVER_SETTINGS_MAKE_DDR_NON_BLOCKING = 0x00000020U,
}

enum : uint
{
    DNS_DOT_SERVER_SETTINGS_ENABLE          = 0x00000001U,
    DNS_DOT_SERVER_SETTINGS_FALLBACK_TO_UDP = 0x00000002U,
}

enum uint DNS_DOT_AUTO_UPGRADE_SERVER = 0x00000004U;

enum : uint
{
    DNS_DOT_SERVER_SETTINGS_ENABLE_AUTO           = 0x00000008U,
    DNS_DOT_SERVER_SETTINGS_ENABLE_DDR            = 0x00000010U,
    DNS_DOT_SERVER_SETTINGS_MAKE_DDR_NON_BLOCKING = 0x00000020U,
}

enum : uint
{
    DNS_DDR_ADAPTER_ENABLE_DOH            = 0x00000001U,
    DNS_DDR_ADAPTER_ENABLE                = 0x00000001U,
    DNS_DDR_ADAPTER_ENABLE_UDP_FALLBACK   = 0x00000002U,
    DNS_DDR_ADAPTER_MAKE_DDR_NON_BLOCKING = 0x00000004U,
}

enum uint TCPIP_OWNING_MODULE_SIZE = 0x00000010U;

enum : ubyte
{
    FILTER_ICMP_TYPE_ANY = 0xff,
    FILTER_ICMP_CODE_ANY = 0xff,
}

enum : uint
{
    FD_FLAGS_NOSYN    = 0x00000001U,
    FD_FLAGS_ALLFLAGS = 0x00000001U,
}

enum : uint
{
    LB_SRC_ADDR_USE_SRCADDR_FLAG = 0x00000001U,
    LB_SRC_ADDR_USE_DSTADDR_FLAG = 0x00000002U,
}

enum : uint
{
    LB_DST_ADDR_USE_SRCADDR_FLAG = 0x00000004U,
    LB_DST_ADDR_USE_DSTADDR_FLAG = 0x00000008U,
}

enum uint LB_SRC_MASK_LATE_FLAG = 0x00000010U;
enum uint LB_DST_MASK_LATE_FLAG = 0x00000020U;
enum uint ERROR_BASE = 0x000059d8U;

enum : uint
{
    PFERROR_NO_PF_INTERFACE  = 0x000059d8U,
    PFERROR_NO_FILTERS_GIVEN = 0x000059d9U,
}

enum uint PFERROR_BUFFER_TOO_SMALL = 0x000059daU;
enum uint ERROR_IPV6_NOT_IMPLEMENTED = 0x000059dbU;
enum uint IP_EXPORT_INCLUDED = 0x00000001U;
enum uint MAX_ADAPTER_NAME = 0x00000080U;
enum uint IP_STATUS_BASE = 0x00002af8U;
enum uint IP_SUCCESS = 0x00000000U;
enum uint IP_BUF_TOO_SMALL = 0x00002af9U;
enum uint IP_DEST_NET_UNREACHABLE = 0x00002afaU;
enum uint IP_DEST_HOST_UNREACHABLE = 0x00002afbU;
enum uint IP_DEST_PROT_UNREACHABLE = 0x00002afcU;
enum uint IP_DEST_PORT_UNREACHABLE = 0x00002afdU;
enum uint IP_NO_RESOURCES = 0x00002afeU;
enum uint IP_BAD_OPTION = 0x00002affU;
enum uint IP_HW_ERROR = 0x00002b00U;
enum uint IP_PACKET_TOO_BIG = 0x00002b01U;
enum uint IP_REQ_TIMED_OUT = 0x00002b02U;

enum : uint
{
    IP_BAD_REQ   = 0x00002b03U,
    IP_BAD_ROUTE = 0x00002b04U,
}

enum : uint
{
    IP_TTL_EXPIRED_TRANSIT = 0x00002b05U,
    IP_TTL_EXPIRED_REASSEM = 0x00002b06U,
}

enum uint IP_PARAM_PROBLEM = 0x00002b07U;
enum uint IP_SOURCE_QUENCH = 0x00002b08U;
enum uint IP_OPTION_TOO_BIG = 0x00002b09U;
enum uint IP_BAD_DESTINATION = 0x00002b0aU;

enum : uint
{
    IP_DEST_NO_ROUTE         = 0x00002afaU,
    IP_DEST_ADDR_UNREACHABLE = 0x00002afbU,
}

enum uint IP_DEST_PROHIBITED = 0x00002afcU;
enum uint IP_HOP_LIMIT_EXCEEDED = 0x00002b05U;
enum uint IP_REASSEMBLY_TIME_EXCEEDED = 0x00002b06U;
enum uint IP_PARAMETER_PROBLEM = 0x00002b07U;
enum uint IP_DEST_UNREACHABLE = 0x00002b20U;
enum uint IP_TIME_EXCEEDED = 0x00002b21U;
enum uint IP_BAD_HEADER = 0x00002b22U;
enum uint IP_UNRECOGNIZED_NEXT_HEADER = 0x00002b23U;
enum uint IP_ICMP_ERROR = 0x00002b24U;
enum uint IP_DEST_SCOPE_MISMATCH = 0x00002b25U;
enum uint IP_ADDR_DELETED = 0x00002b0bU;
enum uint IP_SPEC_MTU_CHANGE = 0x00002b0cU;
enum uint IP_MTU_CHANGE = 0x00002b0dU;
enum uint IP_UNLOAD = 0x00002b0eU;
enum uint IP_ADDR_ADDED = 0x00002b0fU;

enum : uint
{
    IP_MEDIA_CONNECT    = 0x00002b10U,
    IP_MEDIA_DISCONNECT = 0x00002b11U,
}

enum uint IP_BIND_ADAPTER = 0x00002b12U;
enum uint IP_UNBIND_ADAPTER = 0x00002b13U;
enum uint IP_DEVICE_DOES_NOT_EXIST = 0x00002b14U;
enum uint IP_DUPLICATE_ADDRESS = 0x00002b15U;
enum uint IP_INTERFACE_METRIC_CHANGE = 0x00002b16U;
enum uint IP_RECONFIG_SECFLTR = 0x00002b17U;
enum uint IP_NEGOTIATING_IPSEC = 0x00002b18U;
enum uint IP_INTERFACE_WOL_CAPABILITY_CHANGE = 0x00002b19U;
enum uint IP_DUPLICATE_IPADD = 0x00002b1aU;
enum uint IP_GENERAL_FAILURE = 0x00002b2aU;
enum uint MAX_IP_STATUS = 0x00002b2aU;
enum uint IP_PENDING = 0x00002bf7U;

enum : uint
{
    IP_FLAG_REVERSE = 0x00000001U,
    IP_FLAG_DF      = 0x00000002U,
}

enum uint MAX_OPT_SIZE = 0x00000028U;
enum uint IOCTL_IP_RTCHANGE_NOTIFY_REQUEST = 0x00000065U;
enum uint IOCTL_IP_ADDCHANGE_NOTIFY_REQUEST = 0x00000066U;
enum uint IOCTL_ARP_SEND_REQUEST = 0x00000067U;
enum uint IOCTL_IP_INTERFACE_INFO = 0x00000068U;
enum uint IOCTL_IP_GET_BEST_INTERFACE = 0x00000069U;
enum uint IOCTL_IP_UNIDIRECTIONAL_ADAPTER_ADDRESS = 0x0000006aU;
enum uint INTERFACE_TIMESTAMP_CAPABILITIES_VERSION_1 = 0x00000001U;
enum uint INTERFACE_HARDWARE_CROSSTIMESTAMP_VERSION_1 = 0x00000001U;

enum : uint
{
    NET_STRING_IPV4_ADDRESS          = 0x00000001U,
    NET_STRING_IPV4_SERVICE          = 0x00000002U,
    NET_STRING_IPV4_NETWORK          = 0x00000004U,
    NET_STRING_IPV6_ADDRESS          = 0x00000008U,
    NET_STRING_IPV6_ADDRESS_NO_SCOPE = 0x00000010U,
    NET_STRING_IPV6_SERVICE          = 0x00000020U,
    NET_STRING_IPV6_SERVICE_NO_SCOPE = 0x00000040U,
    NET_STRING_IPV6_NETWORK          = 0x00000080U,
    NET_STRING_NAMED_ADDRESS         = 0x00000100U,
    NET_STRING_NAMED_SERVICE         = 0x00000200U,
}

enum uint MAX_ADAPTER_DESCRIPTION_LENGTH = 0x00000080U;

enum : uint
{
    MAX_ADAPTER_NAME_LENGTH    = 0x00000100U,
    MAX_ADAPTER_ADDRESS_LENGTH = 0x00000008U,
}

enum uint DEFAULT_MINIMUM_ENTITIES = 0x00000020U;
enum uint MAX_HOSTNAME_LEN = 0x00000080U;
enum uint MAX_DOMAIN_NAME_LEN = 0x00000080U;
enum uint MAX_SCOPE_ID_LEN = 0x00000100U;
enum uint MAX_DHCPV6_DUID_LENGTH = 0x00000082U;
enum uint MAX_DNS_SUFFIX_STRING_LENGTH = 0x00000100U;
enum uint BROADCAST_NODETYPE = 0x00000001U;
enum uint PEER_TO_PEER_NODETYPE = 0x00000002U;
enum uint MIXED_NODETYPE = 0x00000004U;
enum uint HYBRID_NODETYPE = 0x00000008U;

enum : uint
{
    IP_ADAPTER_ADDRESS_DNS_ELIGIBLE = 0x00000001U,
    IP_ADAPTER_ADDRESS_TRANSIENT    = 0x00000002U,
}

enum : uint
{
    IP_ADAPTER_DDNS_ENABLED            = 0x00000001U,
    IP_ADAPTER_REGISTER_ADAPTER_SUFFIX = 0x00000002U,
}

enum : uint
{
    IP_ADAPTER_DHCP_ENABLED               = 0x00000004U,
    IP_ADAPTER_RECEIVE_ONLY               = 0x00000008U,
    IP_ADAPTER_NO_MULTICAST               = 0x00000010U,
    IP_ADAPTER_IPV6_OTHER_STATEFUL_CONFIG = 0x00000020U,
}

enum uint IP_ADAPTER_NETBIOS_OVER_TCPIP_ENABLED = 0x00000040U;

enum : uint
{
    IP_ADAPTER_IPV4_ENABLED               = 0x00000080U,
    IP_ADAPTER_IPV6_ENABLED               = 0x00000100U,
    IP_ADAPTER_IPV6_MANAGE_ADDRESS_CONFIG = 0x00000200U,
}

enum uint GAA_FLAG_SKIP_DNS_INFO = 0x00000800U;
enum uint IP_ROUTER_MANAGER_VERSION = 0x00000001U;
enum uint IP_GENERAL_INFO_BASE = 0xffff0000U;
enum uint IP_IN_FILTER_INFO = 0xffff0001U;
enum uint IP_OUT_FILTER_INFO = 0xffff0002U;
enum uint IP_GLOBAL_INFO = 0xffff0003U;
enum uint IP_INTERFACE_STATUS_INFO = 0xffff0004U;
enum uint IP_ROUTE_INFO = 0xffff0005U;
enum uint IP_PROT_PRIORITY_INFO = 0xffff0006U;
enum uint IP_ROUTER_DISC_INFO = 0xffff0007U;
enum uint IP_DEMAND_DIAL_FILTER_INFO = 0xffff0009U;

enum : uint
{
    IP_MCAST_HEARBEAT_INFO = 0xffff000aU,
    IP_MCAST_BOUNDARY_INFO = 0xffff000bU,
}

enum uint IP_IPINIP_CFG_INFO = 0xffff000cU;
enum uint IP_IFFILTER_INFO = 0xffff000dU;
enum uint IP_MCAST_LIMIT_INFO = 0xffff000eU;
enum uint IPV6_GLOBAL_INFO = 0xffff000fU;
enum uint IPV6_ROUTE_INFO = 0xffff0010U;
enum uint IP_IN_FILTER_INFO_V6 = 0xffff0011U;
enum uint IP_OUT_FILTER_INFO_V6 = 0xffff0012U;
enum uint IP_DEMAND_DIAL_FILTER_INFO_V6 = 0xffff0013U;
enum uint IP_IFFILTER_INFO_V6 = 0xffff0014U;

enum : uint
{
    IP_FILTER_ENABLE_INFO    = 0xffff0015U,
    IP_FILTER_ENABLE_INFO_V6 = 0xffff0016U,
}

enum uint IP_PROT_PRIORITY_INFO_EX = 0xffff0017U;

// Callbacks

alias PINTERFACE_TIMESTAMP_CONFIG_CHANGE_CALLBACK = void function(void* CallerContext);
alias PIPINTERFACE_CHANGE_CALLBACK = void function(void* CallerContext, MIB_IPINTERFACE_ROW* Row, 
                                                   MIB_NOTIFICATION_TYPE NotificationType);
alias PUNICAST_IPADDRESS_CHANGE_CALLBACK = void function(void* CallerContext, MIB_UNICASTIPADDRESS_ROW* Row, 
                                                         MIB_NOTIFICATION_TYPE NotificationType);
alias PSTABLE_UNICAST_IPADDRESS_TABLE_CALLBACK = void function(void* CallerContext, 
                                                               MIB_UNICASTIPADDRESS_TABLE* AddressTable);
alias PIPFORWARD_CHANGE_CALLBACK = void function(void* CallerContext, MIB_IPFORWARD_ROW2* Row, 
                                                 MIB_NOTIFICATION_TYPE NotificationType);
alias PTEREDO_PORT_CHANGE_CALLBACK = void function(void* CallerContext, ushort Port, 
                                                   MIB_NOTIFICATION_TYPE NotificationType);
alias PNETWORK_CONNECTIVITY_HINT_CHANGE_CALLBACK = void function(void* CallerContext, 
                                                                 NL_NETWORK_CONNECTIVITY_HINT ConnectivityHint);

// Structs


@RAIIFree!UnregisterInterfaceTimestampConfigChange
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HIFTIMESTAMPCHANGE
{
    void* Value;
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipexport/ns-ipexport-ip_option_information32
    struct IP_OPTION_INFORMATION32
    {
        ubyte  Ttl;
        ubyte  Tos;
        ubyte  Flags;
        ubyte  OptionsSize;
        ubyte* OptionsData;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipexport/ns-ipexport-ip_option_information32
    struct IP_OPTION_INFORMATION32
    {
        ubyte  Ttl;
        ubyte  Tos;
        ubyte  Flags;
        ubyte  OptionsSize;
        ubyte* OptionsData;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipexport/ns-ipexport-icmp_echo_reply32
    struct ICMP_ECHO_REPLY32
    {
        uint   Address;
        uint   Status;
        uint   RoundTripTime;
        ushort DataSize;
        ushort Reserved;
        void*  Data;
        IP_OPTION_INFORMATION32 Options;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipexport/ns-ipexport-icmp_echo_reply32
    struct ICMP_ECHO_REPLY32
    {
        uint   Address;
        uint   Status;
        uint   RoundTripTime;
        ushort DataSize;
        ushort Reserved;
        void*  Data;
        IP_OPTION_INFORMATION32 Options;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipexport/ns-ipexport-ip_option_information
struct IP_OPTION_INFORMATION
{
    ubyte  Ttl;
    ubyte  Tos;
    ubyte  Flags;
    ubyte  OptionsSize;
    ubyte* OptionsData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipexport/ns-ipexport-icmp_echo_reply
struct ICMP_ECHO_REPLY
{
    uint   Address;
    uint   Status;
    uint   RoundTripTime;
    ushort DataSize;
    ushort Reserved;
    void*  Data;
    IP_OPTION_INFORMATION Options;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipexport/ns-ipexport-ipv6_address_ex
struct IPV6_ADDRESS_EX
{
align (1):
    ushort    sin6_port;
    uint      sin6_flowinfo;
    ushort[8] sin6_addr;
    uint      sin6_scope_id;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipexport/ns-ipexport-icmpv6_echo_reply_lh
struct ICMPV6_ECHO_REPLY_LH
{
    IPV6_ADDRESS_EX Address;
    uint            Status;
    uint            RoundTripTime;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipexport/ns-ipexport-arp_send_reply
struct ARP_SEND_REPLY
{
    uint DestAddress;
    uint SrcAddress;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipexport/ns-ipexport-tcp_reserve_port_range
struct TCP_RESERVE_PORT_RANGE
{
    ushort UpperRange;
    ushort LowerRange;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipexport/ns-ipexport-ip_adapter_index_map
struct IP_ADAPTER_INDEX_MAP
{
    uint       Index;
    wchar[128] Name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipexport/ns-ipexport-ip_interface_info
struct IP_INTERFACE_INFO
{
    int NumAdapters;
    IP_ADAPTER_INDEX_MAP[1] Adapter; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipexport/ns-ipexport-ip_unidirectional_adapter_address
struct IP_UNIDIRECTIONAL_ADAPTER_ADDRESS
{
    uint    NumAdapters;
    uint[1] Address; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipexport/ns-ipexport-ip_adapter_order_map
struct IP_ADAPTER_ORDER_MAP
{
    uint    NumAdapters;
    uint[1] AdapterOrder; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipexport/ns-ipexport-ip_mcast_counter_info
struct IP_MCAST_COUNTER_INFO
{
    ulong InMcastOctets;
    ulong OutMcastOctets;
    ulong InMcastPkts;
    ulong OutMcastPkts;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iprtrmib/ns-iprtrmib-mib_opaque_query
struct MIB_OPAQUE_QUERY
{
    uint    dwVarId;
    uint[1] rgdwVarIndex; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ifmib/ns-ifmib-mib_ifnumber
struct MIB_IFNUMBER
{
    uint dwValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ifmib/ns-ifmib-mib_ifrow
struct MIB_IFROW
{
    wchar[256] wszName;
    uint       dwIndex;
    uint       dwType;
    uint       dwMtu;
    uint       dwSpeed;
    uint       dwPhysAddrLen;
    ubyte[8]   bPhysAddr;
    uint       dwAdminStatus;
    INTERNAL_IF_OPER_STATUS dwOperStatus;
    uint       dwLastChange;
    uint       dwInOctets;
    uint       dwInUcastPkts;
    uint       dwInNUcastPkts;
    uint       dwInDiscards;
    uint       dwInErrors;
    uint       dwInUnknownProtos;
    uint       dwOutOctets;
    uint       dwOutUcastPkts;
    uint       dwOutNUcastPkts;
    uint       dwOutDiscards;
    uint       dwOutErrors;
    uint       dwOutQLen;
    uint       dwDescrLen;
    ubyte[256] bDescr;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ifmib/ns-ifmib-mib_iftable
struct MIB_IFTABLE
{
    uint         dwNumEntries;
    MIB_IFROW[1] table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mib_ipaddrrow_xp
struct MIB_IPADDRROW_XP
{
    uint   dwAddr;
    uint   dwIndex;
    uint   dwMask;
    uint   dwBCastAddr;
    uint   dwReasmSize;
    ushort unused1;
    ushort wType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mib_ipaddrrow_w2k
struct MIB_IPADDRROW_W2K
{
    uint   dwAddr;
    uint   dwIndex;
    uint   dwMask;
    uint   dwBCastAddr;
    uint   dwReasmSize;
    ushort unused1;
    ushort unused2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mib_ipaddrtable
struct MIB_IPADDRTABLE
{
    uint                dwNumEntries;
    MIB_IPADDRROW_XP[1] table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mib_ipforwardnumber
struct MIB_IPFORWARDNUMBER
{
    uint dwValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mib_ipforwardrow
struct MIB_IPFORWARDROW
{
    uint dwForwardDest;
    uint dwForwardMask;
    uint dwForwardPolicy;
    uint dwForwardNextHop;
    uint dwForwardIfIndex;
    union
    {
        uint               dwForwardType;
        MIB_IPFORWARD_TYPE ForwardType;
    }
    union
    {
        uint              dwForwardProto;
        NL_ROUTE_PROTOCOL ForwardProto;
    }
    uint dwForwardAge;
    uint dwForwardNextHopAS;
    uint dwForwardMetric1;
    uint dwForwardMetric2;
    uint dwForwardMetric3;
    uint dwForwardMetric4;
    uint dwForwardMetric5;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mib_ipforwardtable
struct MIB_IPFORWARDTABLE
{
    uint                dwNumEntries;
    MIB_IPFORWARDROW[1] table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mib_ipnetrow_lh
struct MIB_IPNETROW_LH
{
    uint     dwIndex;
    uint     dwPhysAddrLen;
    ubyte[8] bPhysAddr;
    uint     dwAddr;
    union
    {
        uint           dwType;
        MIB_IPNET_TYPE Type;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mib_ipnetrow_w2k
struct MIB_IPNETROW_W2K
{
    uint     dwIndex;
    uint     dwPhysAddrLen;
    ubyte[8] bPhysAddr;
    uint     dwAddr;
    uint     dwType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mib_ipnettable
struct MIB_IPNETTABLE
{
    uint               dwNumEntries;
    MIB_IPNETROW_LH[1] table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mib_ipstats_lh
struct MIB_IPSTATS_LH
{
    union
    {
        uint dwForwarding;
        MIB_IPSTATS_FORWARDING Forwarding;
    }
    uint dwDefaultTTL;
    uint dwInReceives;
    uint dwInHdrErrors;
    uint dwInAddrErrors;
    uint dwForwDatagrams;
    uint dwInUnknownProtos;
    uint dwInDiscards;
    uint dwInDelivers;
    uint dwOutRequests;
    uint dwRoutingDiscards;
    uint dwOutDiscards;
    uint dwOutNoRoutes;
    uint dwReasmTimeout;
    uint dwReasmReqds;
    uint dwReasmOks;
    uint dwReasmFails;
    uint dwFragOks;
    uint dwFragFails;
    uint dwFragCreates;
    uint dwNumIf;
    uint dwNumAddr;
    uint dwNumRoutes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mib_ipstats_w2k
struct MIB_IPSTATS_W2K
{
    uint dwForwarding;
    uint dwDefaultTTL;
    uint dwInReceives;
    uint dwInHdrErrors;
    uint dwInAddrErrors;
    uint dwForwDatagrams;
    uint dwInUnknownProtos;
    uint dwInDiscards;
    uint dwInDelivers;
    uint dwOutRequests;
    uint dwRoutingDiscards;
    uint dwOutDiscards;
    uint dwOutNoRoutes;
    uint dwReasmTimeout;
    uint dwReasmReqds;
    uint dwReasmOks;
    uint dwReasmFails;
    uint dwFragOks;
    uint dwFragFails;
    uint dwFragCreates;
    uint dwNumIf;
    uint dwNumAddr;
    uint dwNumRoutes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mibicmpstats
struct MIBICMPSTATS
{
    uint dwMsgs;
    uint dwErrors;
    uint dwDestUnreachs;
    uint dwTimeExcds;
    uint dwParmProbs;
    uint dwSrcQuenchs;
    uint dwRedirects;
    uint dwEchos;
    uint dwEchoReps;
    uint dwTimestamps;
    uint dwTimestampReps;
    uint dwAddrMasks;
    uint dwAddrMaskReps;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mibicmpinfo
struct MIBICMPINFO
{
    MIBICMPSTATS icmpInStats;
    MIBICMPSTATS icmpOutStats;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mib_icmp
struct MIB_ICMP
{
    MIBICMPINFO stats;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mibicmpstats_ex_xpsp1
struct MIBICMPSTATS_EX_XPSP1
{
    uint      dwMsgs;
    uint      dwErrors;
    uint[256] rgdwTypeCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mib_icmp_ex_xpsp1
struct MIB_ICMP_EX_XPSP1
{
    MIBICMPSTATS_EX_XPSP1 icmpInStats;
    MIBICMPSTATS_EX_XPSP1 icmpOutStats;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mib_ipmcast_oif_xp
struct MIB_IPMCAST_OIF_XP
{
    uint dwOutIfIndex;
    uint dwNextHopAddr;
    uint dwReserved;
    uint dwReserved1;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mib_ipmcast_oif_w2k
struct MIB_IPMCAST_OIF_W2K
{
    uint  dwOutIfIndex;
    uint  dwNextHopAddr;
    void* pvReserved;
    uint  dwReserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mib_ipmcast_mfe
struct MIB_IPMCAST_MFE
{
    uint dwGroup;
    uint dwSource;
    uint dwSrcMask;
    uint dwUpStrmNgbr;
    uint dwInIfIndex;
    uint dwInIfProtocol;
    uint dwRouteProtocol;
    uint dwRouteNetwork;
    uint dwRouteMask;
    uint ulUpTime;
    uint ulExpiryTime;
    uint ulTimeOut;
    uint ulNumOutIf;
    uint fFlags;
    uint dwReserved;
    MIB_IPMCAST_OIF_XP[1] rgmioOutInfo; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mib_mfe_table
struct MIB_MFE_TABLE
{
    uint               dwNumEntries;
    MIB_IPMCAST_MFE[1] table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mib_ipmcast_oif_stats_lh
struct MIB_IPMCAST_OIF_STATS_LH
{
    uint dwOutIfIndex;
    uint dwNextHopAddr;
    uint dwDialContext;
    uint ulTtlTooLow;
    uint ulFragNeeded;
    uint ulOutPackets;
    uint ulOutDiscards;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mib_ipmcast_oif_stats_w2k
struct MIB_IPMCAST_OIF_STATS_W2K
{
    uint  dwOutIfIndex;
    uint  dwNextHopAddr;
    void* pvDialContext;
    uint  ulTtlTooLow;
    uint  ulFragNeeded;
    uint  ulOutPackets;
    uint  ulOutDiscards;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mib_ipmcast_mfe_stats
struct MIB_IPMCAST_MFE_STATS
{
    uint dwGroup;
    uint dwSource;
    uint dwSrcMask;
    uint dwUpStrmNgbr;
    uint dwInIfIndex;
    uint dwInIfProtocol;
    uint dwRouteProtocol;
    uint dwRouteNetwork;
    uint dwRouteMask;
    uint ulUpTime;
    uint ulExpiryTime;
    uint ulNumOutIf;
    uint ulInPkts;
    uint ulInOctets;
    uint ulPktsDifferentIf;
    uint ulQueueOverflow;
    MIB_IPMCAST_OIF_STATS_LH[1] rgmiosOutStats; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mib_mfe_stats_table
struct MIB_MFE_STATS_TABLE
{
    uint dwNumEntries;
    MIB_IPMCAST_MFE_STATS[1] table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mib_ipmcast_mfe_stats_ex_xp
struct MIB_IPMCAST_MFE_STATS_EX_XP
{
    uint dwGroup;
    uint dwSource;
    uint dwSrcMask;
    uint dwUpStrmNgbr;
    uint dwInIfIndex;
    uint dwInIfProtocol;
    uint dwRouteProtocol;
    uint dwRouteNetwork;
    uint dwRouteMask;
    uint ulUpTime;
    uint ulExpiryTime;
    uint ulNumOutIf;
    uint ulInPkts;
    uint ulInOctets;
    uint ulPktsDifferentIf;
    uint ulQueueOverflow;
    uint ulUninitMfe;
    uint ulNegativeMfe;
    uint ulInDiscards;
    uint ulInHdrErrors;
    uint ulTotalOutPackets;
    MIB_IPMCAST_OIF_STATS_LH[1] rgmiosOutStats; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mib_mfe_stats_table_ex_xp
struct MIB_MFE_STATS_TABLE_EX_XP
{
    uint dwNumEntries;
    MIB_IPMCAST_MFE_STATS_EX_XP[1]* table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mib_ipmcast_global
struct MIB_IPMCAST_GLOBAL
{
    uint dwEnable;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mib_ipmcast_if_entry
struct MIB_IPMCAST_IF_ENTRY
{
    uint dwIfIndex;
    uint dwTtl;
    uint dwProtocol;
    uint dwRateLimit;
    uint ulInMcastOctets;
    uint ulOutMcastOctets;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ipmib/ns-ipmib-mib_ipmcast_if_table
struct MIB_IPMCAST_IF_TABLE
{
    uint dwNumEntries;
    MIB_IPMCAST_IF_ENTRY[1] table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpmib/ns-tcpmib-mib_tcprow_lh
struct MIB_TCPROW_LH
{
    union
    {
        uint          dwState;
        MIB_TCP_STATE State;
    }
    uint dwLocalAddr;
    uint dwLocalPort;
    uint dwRemoteAddr;
    uint dwRemotePort;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpmib/ns-tcpmib-mib_tcprow_w2k
struct MIB_TCPROW_W2K
{
    uint dwState;
    uint dwLocalAddr;
    uint dwLocalPort;
    uint dwRemoteAddr;
    uint dwRemotePort;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpmib/ns-tcpmib-mib_tcptable
struct MIB_TCPTABLE
{
    uint             dwNumEntries;
    MIB_TCPROW_LH[1] table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpmib/ns-tcpmib-mib_tcprow2
struct MIB_TCPROW2
{
    uint dwState;
    uint dwLocalAddr;
    uint dwLocalPort;
    uint dwRemoteAddr;
    uint dwRemotePort;
    uint dwOwningPid;
    TCP_CONNECTION_OFFLOAD_STATE dwOffloadState;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpmib/ns-tcpmib-mib_tcptable2
struct MIB_TCPTABLE2
{
    uint           dwNumEntries;
    MIB_TCPROW2[1] table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpmib/ns-tcpmib-mib_tcprow_owner_pid
struct MIB_TCPROW_OWNER_PID
{
    uint dwState;
    uint dwLocalAddr;
    uint dwLocalPort;
    uint dwRemoteAddr;
    uint dwRemotePort;
    uint dwOwningPid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpmib/ns-tcpmib-mib_tcptable_owner_pid
struct MIB_TCPTABLE_OWNER_PID
{
    uint dwNumEntries;
    MIB_TCPROW_OWNER_PID[1] table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpmib/ns-tcpmib-mib_tcprow_owner_module
struct MIB_TCPROW_OWNER_MODULE
{
    uint      dwState;
    uint      dwLocalAddr;
    uint      dwLocalPort;
    uint      dwRemoteAddr;
    uint      dwRemotePort;
    uint      dwOwningPid;
    long      liCreateTimestamp;
    ulong[16] OwningModuleInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpmib/ns-tcpmib-mib_tcptable_owner_module
struct MIB_TCPTABLE_OWNER_MODULE
{
    uint dwNumEntries;
    MIB_TCPROW_OWNER_MODULE[1] table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpmib/ns-tcpmib-mib_tcp6row
struct MIB_TCP6ROW
{
    MIB_TCP_STATE State;
    IN6_ADDR      LocalAddr;
    uint          dwLocalScopeId;
    uint          dwLocalPort;
    IN6_ADDR      RemoteAddr;
    uint          dwRemoteScopeId;
    uint          dwRemotePort;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpmib/ns-tcpmib-mib_tcp6table
struct MIB_TCP6TABLE
{
    uint           dwNumEntries;
    MIB_TCP6ROW[1] table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpmib/ns-tcpmib-mib_tcp6row2
struct MIB_TCP6ROW2
{
    IN6_ADDR      LocalAddr;
    uint          dwLocalScopeId;
    uint          dwLocalPort;
    IN6_ADDR      RemoteAddr;
    uint          dwRemoteScopeId;
    uint          dwRemotePort;
    MIB_TCP_STATE State;
    uint          dwOwningPid;
    TCP_CONNECTION_OFFLOAD_STATE dwOffloadState;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpmib/ns-tcpmib-mib_tcp6table2
struct MIB_TCP6TABLE2
{
    uint            dwNumEntries;
    MIB_TCP6ROW2[1] table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpmib/ns-tcpmib-mib_tcp6row_owner_pid
struct MIB_TCP6ROW_OWNER_PID
{
    ubyte[16] ucLocalAddr;
    uint      dwLocalScopeId;
    uint      dwLocalPort;
    ubyte[16] ucRemoteAddr;
    uint      dwRemoteScopeId;
    uint      dwRemotePort;
    uint      dwState;
    uint      dwOwningPid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpmib/ns-tcpmib-mib_tcp6table_owner_pid
struct MIB_TCP6TABLE_OWNER_PID
{
    uint dwNumEntries;
    MIB_TCP6ROW_OWNER_PID[1] table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpmib/ns-tcpmib-mib_tcp6row_owner_module
struct MIB_TCP6ROW_OWNER_MODULE
{
    ubyte[16] ucLocalAddr;
    uint      dwLocalScopeId;
    uint      dwLocalPort;
    ubyte[16] ucRemoteAddr;
    uint      dwRemoteScopeId;
    uint      dwRemotePort;
    uint      dwState;
    uint      dwOwningPid;
    long      liCreateTimestamp;
    ulong[16] OwningModuleInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpmib/ns-tcpmib-mib_tcp6table_owner_module
struct MIB_TCP6TABLE_OWNER_MODULE
{
    uint dwNumEntries;
    MIB_TCP6ROW_OWNER_MODULE[1] table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpmib/ns-tcpmib-mib_tcpstats_lh
struct MIB_TCPSTATS_LH
{
    union
    {
        uint              dwRtoAlgorithm;
        TCP_RTO_ALGORITHM RtoAlgorithm;
    }
    uint dwRtoMin;
    uint dwRtoMax;
    uint dwMaxConn;
    uint dwActiveOpens;
    uint dwPassiveOpens;
    uint dwAttemptFails;
    uint dwEstabResets;
    uint dwCurrEstab;
    uint dwInSegs;
    uint dwOutSegs;
    uint dwRetransSegs;
    uint dwInErrs;
    uint dwOutRsts;
    uint dwNumConns;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpmib/ns-tcpmib-mib_tcpstats_w2k
struct MIB_TCPSTATS_W2K
{
    uint dwRtoAlgorithm;
    uint dwRtoMin;
    uint dwRtoMax;
    uint dwMaxConn;
    uint dwActiveOpens;
    uint dwPassiveOpens;
    uint dwAttemptFails;
    uint dwEstabResets;
    uint dwCurrEstab;
    uint dwInSegs;
    uint dwOutSegs;
    uint dwRetransSegs;
    uint dwInErrs;
    uint dwOutRsts;
    uint dwNumConns;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpmib/ns-tcpmib-mib_tcpstats2
struct MIB_TCPSTATS2
{
    TCP_RTO_ALGORITHM RtoAlgorithm;
    uint              dwRtoMin;
    uint              dwRtoMax;
    uint              dwMaxConn;
    uint              dwActiveOpens;
    uint              dwPassiveOpens;
    uint              dwAttemptFails;
    uint              dwEstabResets;
    uint              dwCurrEstab;
    ulong             dw64InSegs;
    ulong             dw64OutSegs;
    uint              dwRetransSegs;
    uint              dwInErrs;
    uint              dwOutRsts;
    uint              dwNumConns;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/udpmib/ns-udpmib-mib_udprow
struct MIB_UDPROW
{
    uint dwLocalAddr;
    uint dwLocalPort;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/udpmib/ns-udpmib-mib_udptable
struct MIB_UDPTABLE
{
    uint          dwNumEntries;
    MIB_UDPROW[1] table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/udpmib/ns-udpmib-mib_udprow_owner_pid
struct MIB_UDPROW_OWNER_PID
{
    uint dwLocalAddr;
    uint dwLocalPort;
    uint dwOwningPid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/udpmib/ns-udpmib-mib_udptable_owner_pid
struct MIB_UDPTABLE_OWNER_PID
{
    uint dwNumEntries;
    MIB_UDPROW_OWNER_PID[1] table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/udpmib/ns-udpmib-mib_udprow_owner_module
struct MIB_UDPROW_OWNER_MODULE
{
    uint      dwLocalAddr;
    uint      dwLocalPort;
    uint      dwOwningPid;
    long      liCreateTimestamp;
    union
    {
        struct
        {
            // Native bit field: SpecificPortBind: [0]
            int _bitfield0;
        }
        int dwFlags;
    }
    ulong[16] OwningModuleInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/udpmib/ns-udpmib-mib_udptable_owner_module
struct MIB_UDPTABLE_OWNER_MODULE
{
    uint dwNumEntries;
    MIB_UDPROW_OWNER_MODULE[1] table; // Flexible array
}

struct MIB_UDPROW2
{
    uint      dwLocalAddr;
    uint      dwLocalPort;
    uint      dwOwningPid;
    long      liCreateTimestamp;
    union
    {
        struct
        {
            // Native bit field: SpecificPortBind: [0]
            int _bitfield0;
        }
        int dwFlags;
    }
    ulong[16] OwningModuleInfo;
    uint      dwRemoteAddr;
    uint      dwRemotePort;
}

struct MIB_UDPTABLE2
{
    uint           dwNumEntries;
    MIB_UDPROW2[1] table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/udpmib/ns-udpmib-mib_udp6row
struct MIB_UDP6ROW
{
    IN6_ADDR dwLocalAddr;
    uint     dwLocalScopeId;
    uint     dwLocalPort;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/udpmib/ns-udpmib-mib_udp6table
struct MIB_UDP6TABLE
{
    uint           dwNumEntries;
    MIB_UDP6ROW[1] table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/udpmib/ns-udpmib-mib_udp6row_owner_pid
struct MIB_UDP6ROW_OWNER_PID
{
    ubyte[16] ucLocalAddr;
    uint      dwLocalScopeId;
    uint      dwLocalPort;
    uint      dwOwningPid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/udpmib/ns-udpmib-mib_udp6table_owner_pid
struct MIB_UDP6TABLE_OWNER_PID
{
    uint dwNumEntries;
    MIB_UDP6ROW_OWNER_PID[1] table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/udpmib/ns-udpmib-mib_udp6row_owner_module
struct MIB_UDP6ROW_OWNER_MODULE
{
    ubyte[16] ucLocalAddr;
    uint      dwLocalScopeId;
    uint      dwLocalPort;
    uint      dwOwningPid;
    long      liCreateTimestamp;
    union
    {
        struct
        {
            // Native bit field: SpecificPortBind: [0]
            int _bitfield0;
        }
        int dwFlags;
    }
    ulong[16] OwningModuleInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/udpmib/ns-udpmib-mib_udp6table_owner_module
struct MIB_UDP6TABLE_OWNER_MODULE
{
    uint dwNumEntries;
    MIB_UDP6ROW_OWNER_MODULE[1] table; // Flexible array
}

struct MIB_UDP6ROW2
{
    ubyte[16] ucLocalAddr;
    uint      dwLocalScopeId;
    uint      dwLocalPort;
    uint      dwOwningPid;
    long      liCreateTimestamp;
    union
    {
        struct
        {
            // Native bit field: SpecificPortBind: [0]
            int _bitfield0;
        }
        int dwFlags;
    }
    ulong[16] OwningModuleInfo;
    ubyte[16] ucRemoteAddr;
    uint      dwRemoteScopeId;
    uint      dwRemotePort;
}

struct MIB_UDP6TABLE2
{
    uint            dwNumEntries;
    MIB_UDP6ROW2[1] table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/udpmib/ns-udpmib-mib_udpstats
struct MIB_UDPSTATS
{
    uint dwInDatagrams;
    uint dwNoPorts;
    uint dwInErrors;
    uint dwOutDatagrams;
    uint dwNumAddrs;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/udpmib/ns-udpmib-mib_udpstats2
struct MIB_UDPSTATS2
{
    ulong dw64InDatagrams;
    uint  dwNoPorts;
    uint  dwInErrors;
    ulong dw64OutDatagrams;
    uint  dwNumAddrs;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iprtrmib/ns-iprtrmib-tcpip_owner_module_basic_info
struct TCPIP_OWNER_MODULE_BASIC_INFO
{
    PWSTR pModuleName;
    PWSTR pModulePath;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iprtrmib/ns-iprtrmib-mib_ipmcast_boundary
struct MIB_IPMCAST_BOUNDARY
{
    uint dwIfIndex;
    uint dwGroupAddress;
    uint dwGroupMask;
    uint dwStatus;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iprtrmib/ns-iprtrmib-mib_ipmcast_boundary_table
struct MIB_IPMCAST_BOUNDARY_TABLE
{
    uint dwNumEntries;
    MIB_IPMCAST_BOUNDARY[1] table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iprtrmib/ns-iprtrmib-mib_boundaryrow
struct MIB_BOUNDARYROW
{
    uint dwGroupAddress;
    uint dwGroupMask;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iprtrmib/ns-iprtrmib-mib_mcast_limit_row
struct MIB_MCAST_LIMIT_ROW
{
    uint dwTtl;
    uint dwRateLimit;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iprtrmib/ns-iprtrmib-mib_ipmcast_scope
struct MIB_IPMCAST_SCOPE
{
    uint        dwGroupAddress;
    uint        dwGroupMask;
    ushort[256] snNameBuffer;
    uint        dwStatus;
}

struct MIB_IPDESTROW
{
    MIB_IPFORWARDROW ForwardRow;
    uint             dwForwardPreference;
    uint             dwForwardViewSet;
}

struct MIB_IPDESTTABLE
{
    uint             dwNumEntries;
    MIB_IPDESTROW[1] table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iprtrmib/ns-iprtrmib-mib_best_if
struct MIB_BEST_IF
{
    uint dwDestAddr;
    uint dwIfIndex;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iprtrmib/ns-iprtrmib-mib_proxyarp
struct MIB_PROXYARP
{
    uint dwAddress;
    uint dwMask;
    uint dwIfIndex;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iprtrmib/ns-iprtrmib-mib_ifstatus
struct MIB_IFSTATUS
{
    uint dwIfIndex;
    uint dwAdminStatus;
    uint dwOperationalStatus;
    BOOL bMHbeatActive;
    BOOL bMHbeatAlive;
}

struct MIB_ROUTESTATE
{
    BOOL bRoutesSetToStack;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iprtrmib/ns-iprtrmib-mib_opaque_info
struct MIB_OPAQUE_INFO
{
    uint dwId;
    union
    {
        ulong    ullAlign;
        ubyte[1] rgbyData; // Flexible array
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iptypes/ns-iptypes-ip_address_string
struct IP_ADDRESS_STRING
{
    CHAR[16] String;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iptypes/ns-iptypes-ip_addr_string
struct IP_ADDR_STRING
{
    IP_ADDR_STRING*   Next;
    IP_ADDRESS_STRING IpAddress;
    IP_ADDRESS_STRING IpMask;
    uint              Context;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iptypes/ns-iptypes-ip_adapter_info
struct IP_ADAPTER_INFO
{
    IP_ADAPTER_INFO* Next;
    uint             ComboIndex;
    CHAR[260]        AdapterName;
    CHAR[132]        Description;
    uint             AddressLength;
    ubyte[8]         Address;
    uint             Index;
    uint             Type;
    uint             DhcpEnabled;
    IP_ADDR_STRING*  CurrentIpAddress;
    IP_ADDR_STRING   IpAddressList;
    IP_ADDR_STRING   GatewayList;
    IP_ADDR_STRING   DhcpServer;
    BOOL             HaveWins;
    IP_ADDR_STRING   PrimaryWinsServer;
    IP_ADDR_STRING   SecondaryWinsServer;
    long             LeaseObtained;
    long             LeaseExpires;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iptypes/ns-iptypes-ip_adapter_unicast_address_lh
struct IP_ADAPTER_UNICAST_ADDRESS_LH
{
    union
    {
        ulong Alignment;
        struct
        {
            uint Length;
            uint Flags;
        }
    }
    IP_ADAPTER_UNICAST_ADDRESS_LH* Next;
    SOCKET_ADDRESS   Address;
    NL_PREFIX_ORIGIN PrefixOrigin;
    NL_SUFFIX_ORIGIN SuffixOrigin;
    NL_DAD_STATE     DadState;
    uint             ValidLifetime;
    uint             PreferredLifetime;
    uint             LeaseLifetime;
    ubyte            OnLinkPrefixLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iptypes/ns-iptypes-ip_adapter_unicast_address_xp
struct IP_ADAPTER_UNICAST_ADDRESS_XP
{
    union
    {
        ulong Alignment;
        struct
        {
            uint Length;
            uint Flags;
        }
    }
    IP_ADAPTER_UNICAST_ADDRESS_XP* Next;
    SOCKET_ADDRESS   Address;
    NL_PREFIX_ORIGIN PrefixOrigin;
    NL_SUFFIX_ORIGIN SuffixOrigin;
    NL_DAD_STATE     DadState;
    uint             ValidLifetime;
    uint             PreferredLifetime;
    uint             LeaseLifetime;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iptypes/ns-iptypes-ip_adapter_anycast_address_xp
struct IP_ADAPTER_ANYCAST_ADDRESS_XP
{
    union
    {
        ulong Alignment;
        struct
        {
            uint Length;
            uint Flags;
        }
    }
    IP_ADAPTER_ANYCAST_ADDRESS_XP* Next;
    SOCKET_ADDRESS Address;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iptypes/ns-iptypes-ip_adapter_multicast_address_xp
struct IP_ADAPTER_MULTICAST_ADDRESS_XP
{
    union
    {
        ulong Alignment;
        struct
        {
            uint Length;
            uint Flags;
        }
    }
    IP_ADAPTER_MULTICAST_ADDRESS_XP* Next;
    SOCKET_ADDRESS Address;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iptypes/ns-iptypes-ip_adapter_dns_server_address_xp
struct IP_ADAPTER_DNS_SERVER_ADDRESS_XP
{
    union
    {
        ulong Alignment;
        struct
        {
            uint Length;
            uint Reserved;
        }
    }
    IP_ADAPTER_DNS_SERVER_ADDRESS_XP* Next;
    SOCKET_ADDRESS Address;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iptypes/ns-iptypes-ip_adapter_wins_server_address_lh
struct IP_ADAPTER_WINS_SERVER_ADDRESS_LH
{
    union
    {
        ulong Alignment;
        struct
        {
            uint Length;
            uint Reserved;
        }
    }
    IP_ADAPTER_WINS_SERVER_ADDRESS_LH* Next;
    SOCKET_ADDRESS Address;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iptypes/ns-iptypes-ip_adapter_gateway_address_lh
struct IP_ADAPTER_GATEWAY_ADDRESS_LH
{
    union
    {
        ulong Alignment;
        struct
        {
            uint Length;
            uint Reserved;
        }
    }
    IP_ADAPTER_GATEWAY_ADDRESS_LH* Next;
    SOCKET_ADDRESS Address;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iptypes/ns-iptypes-ip_adapter_prefix_xp
struct IP_ADAPTER_PREFIX_XP
{
    union
    {
        ulong Alignment;
        struct
        {
            uint Length;
            uint Flags;
        }
    }
    IP_ADAPTER_PREFIX_XP* Next;
    SOCKET_ADDRESS Address;
    uint           PrefixLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iptypes/ns-iptypes-ip_adapter_dns_suffix
struct IP_ADAPTER_DNS_SUFFIX
{
    IP_ADAPTER_DNS_SUFFIX* Next;
    wchar[256] String;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iptypes/ns-iptypes-ip_adapter_addresses_lh
struct IP_ADAPTER_ADDRESSES_LH
{
    union
    {
        ulong Alignment;
        struct
        {
            uint Length;
            uint IfIndex;
        }
    }
    IP_ADAPTER_ADDRESSES_LH* Next;
    PSTR           AdapterName;
    IP_ADAPTER_UNICAST_ADDRESS_LH* FirstUnicastAddress;
    IP_ADAPTER_ANYCAST_ADDRESS_XP* FirstAnycastAddress;
    IP_ADAPTER_MULTICAST_ADDRESS_XP* FirstMulticastAddress;
    IP_ADAPTER_DNS_SERVER_ADDRESS_XP* FirstDnsServerAddress;
    PWSTR          DnsSuffix;
    PWSTR          Description;
    PWSTR          FriendlyName;
    ubyte[8]       PhysicalAddress;
    uint           PhysicalAddressLength;
    union
    {
        uint Flags;
        struct
        {
            // Native bit field: DdnsEnabled: [0], RegisterAdapterSuffix: [1], Dhcpv4Enabled: [2], ReceiveOnly: [3], NoMulticast: [4], Ipv6OtherStatefulConfig: [5], NetbiosOverTcpipEnabled: [6], Ipv4Enabled: [7], Ipv6Enabled: [8], Ipv6ManagedAddressConfigurationSupported: [9]
            uint _bitfield0;
        }
    }
    uint           Mtu;
    uint           IfType;
    IF_OPER_STATUS OperStatus;
    uint           Ipv6IfIndex;
    uint[16]       ZoneIndices;
    IP_ADAPTER_PREFIX_XP* FirstPrefix;
    ulong          TransmitLinkSpeed;
    ulong          ReceiveLinkSpeed;
    IP_ADAPTER_WINS_SERVER_ADDRESS_LH* FirstWinsServerAddress;
    IP_ADAPTER_GATEWAY_ADDRESS_LH* FirstGatewayAddress;
    uint           Ipv4Metric;
    uint           Ipv6Metric;
    NET_LUID_LH    Luid;
    SOCKET_ADDRESS Dhcpv4Server;
    NET_IF_COMPARTMENT_ID CompartmentId;
    GUID           NetworkGuid;
    NET_IF_CONNECTION_TYPE ConnectionType;
    TUNNEL_TYPE    TunnelType;
    SOCKET_ADDRESS Dhcpv6Server;
    ubyte[130]     Dhcpv6ClientDuid;
    uint           Dhcpv6ClientDuidLength;
    uint           Dhcpv6Iaid;
    IP_ADAPTER_DNS_SUFFIX* FirstDnsSuffix;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iptypes/ns-iptypes-ip_adapter_addresses_xp
struct IP_ADAPTER_ADDRESSES_XP
{
    union
    {
        ulong Alignment;
        struct
        {
            uint Length;
            uint IfIndex;
        }
    }
    IP_ADAPTER_ADDRESSES_XP* Next;
    PSTR           AdapterName;
    IP_ADAPTER_UNICAST_ADDRESS_XP* FirstUnicastAddress;
    IP_ADAPTER_ANYCAST_ADDRESS_XP* FirstAnycastAddress;
    IP_ADAPTER_MULTICAST_ADDRESS_XP* FirstMulticastAddress;
    IP_ADAPTER_DNS_SERVER_ADDRESS_XP* FirstDnsServerAddress;
    PWSTR          DnsSuffix;
    PWSTR          Description;
    PWSTR          FriendlyName;
    ubyte[8]       PhysicalAddress;
    uint           PhysicalAddressLength;
    uint           Flags;
    uint           Mtu;
    uint           IfType;
    IF_OPER_STATUS OperStatus;
    uint           Ipv6IfIndex;
    uint[16]       ZoneIndices;
    IP_ADAPTER_PREFIX_XP* FirstPrefix;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iptypes/ns-iptypes-ip_per_adapter_info_w2ksp1
struct IP_PER_ADAPTER_INFO_W2KSP1
{
    uint            AutoconfigEnabled;
    uint            AutoconfigActive;
    IP_ADDR_STRING* CurrentDnsServer;
    IP_ADDR_STRING  DnsServerList;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iptypes/ns-iptypes-fixed_info_w2ksp1
struct FIXED_INFO_W2KSP1
{
    CHAR[132]       HostName;
    CHAR[132]       DomainName;
    IP_ADDR_STRING* CurrentDnsServer;
    IP_ADDR_STRING  DnsServerList;
    uint            NodeType;
    CHAR[260]       ScopeId;
    uint            EnableRouting;
    uint            EnableProxy;
    uint            EnableDns;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iptypes/ns-iptypes-ip_interface_name_info_w2ksp1
struct IP_INTERFACE_NAME_INFO_W2KSP1
{
    uint  Index;
    uint  MediaType;
    ubyte ConnectionType;
    ubyte AccessType;
    GUID  DeviceGuid;
    GUID  InterfaceGuid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpestats/ns-tcpestats-tcp_estats_syn_opts_ros_v0
struct TCP_ESTATS_SYN_OPTS_ROS_v0
{
    BOOLEAN ActiveOpen;
    uint    MssRcvd;
    uint    MssSent;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpestats/ns-tcpestats-tcp_estats_data_rod_v0
struct TCP_ESTATS_DATA_ROD_v0
{
    ulong DataBytesOut;
    ulong DataSegsOut;
    ulong DataBytesIn;
    ulong DataSegsIn;
    ulong SegsOut;
    ulong SegsIn;
    uint  SoftErrors;
    uint  SoftErrorReason;
    uint  SndUna;
    uint  SndNxt;
    uint  SndMax;
    ulong ThruBytesAcked;
    uint  RcvNxt;
    ulong ThruBytesReceived;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpestats/ns-tcpestats-tcp_estats_data_rw_v0
struct TCP_ESTATS_DATA_RW_v0
{
    BOOLEAN EnableCollection;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpestats/ns-tcpestats-tcp_estats_snd_cong_rod_v0
struct TCP_ESTATS_SND_CONG_ROD_v0
{
    uint   SndLimTransRwin;
    uint   SndLimTimeRwin;
    size_t SndLimBytesRwin;
    uint   SndLimTransCwnd;
    uint   SndLimTimeCwnd;
    size_t SndLimBytesCwnd;
    uint   SndLimTransSnd;
    uint   SndLimTimeSnd;
    size_t SndLimBytesSnd;
    uint   SlowStart;
    uint   CongAvoid;
    uint   OtherReductions;
    uint   CurCwnd;
    uint   MaxSsCwnd;
    uint   MaxCaCwnd;
    uint   CurSsthresh;
    uint   MaxSsthresh;
    uint   MinSsthresh;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpestats/ns-tcpestats-tcp_estats_snd_cong_ros_v0
struct TCP_ESTATS_SND_CONG_ROS_v0
{
    uint LimCwnd;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpestats/ns-tcpestats-tcp_estats_snd_cong_rw_v0
struct TCP_ESTATS_SND_CONG_RW_v0
{
    BOOLEAN EnableCollection;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpestats/ns-tcpestats-tcp_estats_path_rod_v0
struct TCP_ESTATS_PATH_ROD_v0
{
    uint FastRetran;
    uint Timeouts;
    uint SubsequentTimeouts;
    uint CurTimeoutCount;
    uint AbruptTimeouts;
    uint PktsRetrans;
    uint BytesRetrans;
    uint DupAcksIn;
    uint SacksRcvd;
    uint SackBlocksRcvd;
    uint CongSignals;
    uint PreCongSumCwnd;
    uint PreCongSumRtt;
    uint PostCongSumRtt;
    uint PostCongCountRtt;
    uint EcnSignals;
    uint EceRcvd;
    uint SendStall;
    uint QuenchRcvd;
    uint RetranThresh;
    uint SndDupAckEpisodes;
    uint SumBytesReordered;
    uint NonRecovDa;
    uint NonRecovDaEpisodes;
    uint AckAfterFr;
    uint DsackDups;
    uint SampleRtt;
    uint SmoothedRtt;
    uint RttVar;
    uint MaxRtt;
    uint MinRtt;
    uint SumRtt;
    uint CountRtt;
    uint CurRto;
    uint MaxRto;
    uint MinRto;
    uint CurMss;
    uint MaxMss;
    uint MinMss;
    uint SpuriousRtoDetections;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpestats/ns-tcpestats-tcp_estats_path_rw_v0
struct TCP_ESTATS_PATH_RW_v0
{
    BOOLEAN EnableCollection;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpestats/ns-tcpestats-tcp_estats_send_buff_rod_v0
struct TCP_ESTATS_SEND_BUFF_ROD_v0
{
    size_t CurRetxQueue;
    size_t MaxRetxQueue;
    size_t CurAppWQueue;
    size_t MaxAppWQueue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpestats/ns-tcpestats-tcp_estats_send_buff_rw_v0
struct TCP_ESTATS_SEND_BUFF_RW_v0
{
    BOOLEAN EnableCollection;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpestats/ns-tcpestats-tcp_estats_rec_rod_v0
struct TCP_ESTATS_REC_ROD_v0
{
    uint   CurRwinSent;
    uint   MaxRwinSent;
    uint   MinRwinSent;
    uint   LimRwin;
    uint   DupAckEpisodes;
    uint   DupAcksOut;
    uint   CeRcvd;
    uint   EcnSent;
    uint   EcnNoncesRcvd;
    uint   CurReasmQueue;
    uint   MaxReasmQueue;
    size_t CurAppRQueue;
    size_t MaxAppRQueue;
    ubyte  WinScaleSent;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpestats/ns-tcpestats-tcp_estats_rec_rw_v0
struct TCP_ESTATS_REC_RW_v0
{
    BOOLEAN EnableCollection;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpestats/ns-tcpestats-tcp_estats_obs_rec_rod_v0
struct TCP_ESTATS_OBS_REC_ROD_v0
{
    uint  CurRwinRcvd;
    uint  MaxRwinRcvd;
    uint  MinRwinRcvd;
    ubyte WinScaleRcvd;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpestats/ns-tcpestats-tcp_estats_obs_rec_rw_v0
struct TCP_ESTATS_OBS_REC_RW_v0
{
    BOOLEAN EnableCollection;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpestats/ns-tcpestats-tcp_estats_bandwidth_rw_v0
struct TCP_ESTATS_BANDWIDTH_RW_v0
{
    TCP_BOOLEAN_OPTIONAL EnableCollectionOutbound;
    TCP_BOOLEAN_OPTIONAL EnableCollectionInbound;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpestats/ns-tcpestats-tcp_estats_bandwidth_rod_v0
struct TCP_ESTATS_BANDWIDTH_ROD_v0
{
    ulong   OutboundBandwidth;
    ulong   InboundBandwidth;
    ulong   OutboundInstability;
    ulong   InboundInstability;
    BOOLEAN OutboundBandwidthPeaked;
    BOOLEAN InboundBandwidthPeaked;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpestats/ns-tcpestats-tcp_estats_fine_rtt_rw_v0
struct TCP_ESTATS_FINE_RTT_RW_v0
{
    BOOLEAN EnableCollection;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tcpestats/ns-tcpestats-tcp_estats_fine_rtt_rod_v0
struct TCP_ESTATS_FINE_RTT_ROD_v0
{
    uint RttVar;
    uint MaxRtt;
    uint MinRtt;
    uint SumRtt;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iphlpapi/ns-iphlpapi-interface_hardware_timestamp_capabilities
struct INTERFACE_HARDWARE_TIMESTAMP_CAPABILITIES
{
    BOOLEAN PtpV2OverUdpIPv4EventMessageReceive;
    BOOLEAN PtpV2OverUdpIPv4AllMessageReceive;
    BOOLEAN PtpV2OverUdpIPv4EventMessageTransmit;
    BOOLEAN PtpV2OverUdpIPv4AllMessageTransmit;
    BOOLEAN PtpV2OverUdpIPv6EventMessageReceive;
    BOOLEAN PtpV2OverUdpIPv6AllMessageReceive;
    BOOLEAN PtpV2OverUdpIPv6EventMessageTransmit;
    BOOLEAN PtpV2OverUdpIPv6AllMessageTransmit;
    BOOLEAN AllReceive;
    BOOLEAN AllTransmit;
    BOOLEAN TaggedTransmit;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iphlpapi/ns-iphlpapi-interface_software_timestamp_capabilities
struct INTERFACE_SOFTWARE_TIMESTAMP_CAPABILITIES
{
    BOOLEAN AllReceive;
    BOOLEAN AllTransmit;
    BOOLEAN TaggedTransmit;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iphlpapi/ns-iphlpapi-interface_timestamp_capabilities
struct INTERFACE_TIMESTAMP_CAPABILITIES
{
    ulong   HardwareClockFrequencyHz;
    BOOLEAN SupportsCrossTimestamp;
    INTERFACE_HARDWARE_TIMESTAMP_CAPABILITIES HardwareCapabilities;
    INTERFACE_SOFTWARE_TIMESTAMP_CAPABILITIES SoftwareCapabilities;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iphlpapi/ns-iphlpapi-interface_hardware_crosstimestamp
struct INTERFACE_HARDWARE_CROSSTIMESTAMP
{
    ulong SystemTimestamp1;
    ulong HardwareClockTimestamp;
    ulong SystemTimestamp2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iphlpapi/ns-iphlpapi-net_address_info
struct NET_ADDRESS_INFO
{
    NET_ADDRESS_FORMAT Format;
    union
    {
        struct NamedAddress
        {
            wchar[256] Address;
            wchar[6]   Port;
        }
        SOCKADDR_IN  Ipv4Address;
        SOCKADDR_IN6 Ipv6Address;
        SOCKADDR     IpAddress;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ns-netioapi-mib_if_row2
struct MIB_IF_ROW2
{
    NET_LUID_LH          InterfaceLuid;
    uint                 InterfaceIndex;
    GUID                 InterfaceGuid;
    wchar[257]           Alias;
    wchar[257]           Description;
    uint                 PhysicalAddressLength;
    ubyte[32]            PhysicalAddress;
    ubyte[32]            PermanentPhysicalAddress;
    uint                 Mtu;
    uint                 Type;
    TUNNEL_TYPE          TunnelType;
    NDIS_MEDIUM          MediaType;
    NDIS_PHYSICAL_MEDIUM PhysicalMediumType;
    NET_IF_ACCESS_TYPE   AccessType;
    NET_IF_DIRECTION_TYPE DirectionType;
    struct InterfaceAndOperStatusFlags
    {
        // Native bit field: HardwareInterface: [0], FilterInterface: [1], ConnectorPresent: [2], NotAuthenticated: [3], NotMediaConnected: [4], Paused: [5], LowPower: [6], EndPointInterface: [7]
        ubyte _bitfield0;
    }
    IF_OPER_STATUS       OperStatus;
    NET_IF_ADMIN_STATUS  AdminStatus;
    NET_IF_MEDIA_CONNECT_STATE MediaConnectState;
    GUID                 NetworkGuid;
    NET_IF_CONNECTION_TYPE ConnectionType;
    ulong                TransmitLinkSpeed;
    ulong                ReceiveLinkSpeed;
    ulong                InOctets;
    ulong                InUcastPkts;
    ulong                InNUcastPkts;
    ulong                InDiscards;
    ulong                InErrors;
    ulong                InUnknownProtos;
    ulong                InUcastOctets;
    ulong                InMulticastOctets;
    ulong                InBroadcastOctets;
    ulong                OutOctets;
    ulong                OutUcastPkts;
    ulong                OutNUcastPkts;
    ulong                OutDiscards;
    ulong                OutErrors;
    ulong                OutUcastOctets;
    ulong                OutMulticastOctets;
    ulong                OutBroadcastOctets;
    ulong                OutQLen;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ns-netioapi-mib_if_table2
struct MIB_IF_TABLE2
{
    uint           NumEntries;
    MIB_IF_ROW2[1] Table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ns-netioapi-mib_ipinterface_row
struct MIB_IPINTERFACE_ROW
{
    ADDRESS_FAMILY Family;
    NET_LUID_LH    InterfaceLuid;
    uint           InterfaceIndex;
    uint           MaxReassemblySize;
    ulong          InterfaceIdentifier;
    uint           MinRouterAdvertisementInterval;
    uint           MaxRouterAdvertisementInterval;
    BOOLEAN        AdvertisingEnabled;
    BOOLEAN        ForwardingEnabled;
    BOOLEAN        WeakHostSend;
    BOOLEAN        WeakHostReceive;
    BOOLEAN        UseAutomaticMetric;
    BOOLEAN        UseNeighborUnreachabilityDetection;
    BOOLEAN        ManagedAddressConfigurationSupported;
    BOOLEAN        OtherStatefulConfigurationSupported;
    BOOLEAN        AdvertiseDefaultRoute;
    NL_ROUTER_DISCOVERY_BEHAVIOR RouterDiscoveryBehavior;
    uint           DadTransmits;
    uint           BaseReachableTime;
    uint           RetransmitTime;
    uint           PathMtuDiscoveryTimeout;
    NL_LINK_LOCAL_ADDRESS_BEHAVIOR LinkLocalAddressBehavior;
    uint           LinkLocalAddressTimeout;
    uint[16]       ZoneIndices;
    uint           SitePrefixLength;
    uint           Metric;
    uint           NlMtu;
    BOOLEAN        Connected;
    BOOLEAN        SupportsWakeUpPatterns;
    BOOLEAN        SupportsNeighborDiscovery;
    BOOLEAN        SupportsRouterDiscovery;
    uint           ReachableTime;
    NL_INTERFACE_OFFLOAD_ROD TransmitOffload;
    NL_INTERFACE_OFFLOAD_ROD ReceiveOffload;
    BOOLEAN        DisableDefaultRoutes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ns-netioapi-mib_ipinterface_table
struct MIB_IPINTERFACE_TABLE
{
    uint NumEntries;
    MIB_IPINTERFACE_ROW[1] Table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ns-netioapi-mib_ifstack_row
struct MIB_IFSTACK_ROW
{
    uint HigherLayerInterfaceIndex;
    uint LowerLayerInterfaceIndex;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ns-netioapi-mib_invertedifstack_row
struct MIB_INVERTEDIFSTACK_ROW
{
    uint LowerLayerInterfaceIndex;
    uint HigherLayerInterfaceIndex;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ns-netioapi-mib_ifstack_table
struct MIB_IFSTACK_TABLE
{
    uint               NumEntries;
    MIB_IFSTACK_ROW[1] Table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ns-netioapi-mib_invertedifstack_table
struct MIB_INVERTEDIFSTACK_TABLE
{
    uint NumEntries;
    MIB_INVERTEDIFSTACK_ROW[1] Table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ns-netioapi-mib_ip_network_connection_bandwidth_estimates
struct MIB_IP_NETWORK_CONNECTION_BANDWIDTH_ESTIMATES
{
    NL_BANDWIDTH_INFORMATION InboundBandwidthInformation;
    NL_BANDWIDTH_INFORMATION OutboundBandwidthInformation;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ns-netioapi-mib_unicastipaddress_row
struct MIB_UNICASTIPADDRESS_ROW
{
    SOCKADDR_INET    Address;
    NET_LUID_LH      InterfaceLuid;
    uint             InterfaceIndex;
    NL_PREFIX_ORIGIN PrefixOrigin;
    NL_SUFFIX_ORIGIN SuffixOrigin;
    uint             ValidLifetime;
    uint             PreferredLifetime;
    ubyte            OnLinkPrefixLength;
    BOOLEAN          SkipAsSource;
    NL_DAD_STATE     DadState;
    SCOPE_ID         ScopeId;
    long             CreationTimeStamp;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ns-netioapi-mib_unicastipaddress_table
struct MIB_UNICASTIPADDRESS_TABLE
{
    uint NumEntries;
    MIB_UNICASTIPADDRESS_ROW[1] Table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ns-netioapi-mib_anycastipaddress_row
struct MIB_ANYCASTIPADDRESS_ROW
{
    SOCKADDR_INET Address;
    NET_LUID_LH   InterfaceLuid;
    uint          InterfaceIndex;
    SCOPE_ID      ScopeId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ns-netioapi-mib_anycastipaddress_table
struct MIB_ANYCASTIPADDRESS_TABLE
{
    uint NumEntries;
    MIB_ANYCASTIPADDRESS_ROW[1] Table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ns-netioapi-mib_multicastipaddress_row
struct MIB_MULTICASTIPADDRESS_ROW
{
    SOCKADDR_INET Address;
    uint          InterfaceIndex;
    NET_LUID_LH   InterfaceLuid;
    SCOPE_ID      ScopeId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ns-netioapi-mib_multicastipaddress_table
struct MIB_MULTICASTIPADDRESS_TABLE
{
    uint NumEntries;
    MIB_MULTICASTIPADDRESS_ROW[1] Table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ns-netioapi-ip_address_prefix
struct IP_ADDRESS_PREFIX
{
    SOCKADDR_INET Prefix;
    ubyte         PrefixLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ns-netioapi-mib_ipforward_row2
struct MIB_IPFORWARD_ROW2
{
    NET_LUID_LH       InterfaceLuid;
    uint              InterfaceIndex;
    IP_ADDRESS_PREFIX DestinationPrefix;
    SOCKADDR_INET     NextHop;
    ubyte             SitePrefixLength;
    uint              ValidLifetime;
    uint              PreferredLifetime;
    uint              Metric;
    NL_ROUTE_PROTOCOL Protocol;
    BOOLEAN           Loopback;
    BOOLEAN           AutoconfigureAddress;
    BOOLEAN           Publish;
    BOOLEAN           Immortal;
    uint              Age;
    NL_ROUTE_ORIGIN   Origin;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ns-netioapi-mib_ipforward_table2
struct MIB_IPFORWARD_TABLE2
{
    uint NumEntries;
    MIB_IPFORWARD_ROW2[1] Table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ns-netioapi-mib_ippath_row
struct MIB_IPPATH_ROW
{
    SOCKADDR_INET Source;
    SOCKADDR_INET Destination;
    NET_LUID_LH   InterfaceLuid;
    uint          InterfaceIndex;
    SOCKADDR_INET CurrentNextHop;
    uint          PathMtu;
    uint          RttMean;
    uint          RttDeviation;
    union
    {
        uint LastReachable;
        uint LastUnreachable;
    }
    BOOLEAN       IsReachable;
    ulong         LinkTransmitSpeed;
    ulong         LinkReceiveSpeed;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ns-netioapi-mib_ippath_table
struct MIB_IPPATH_TABLE
{
    uint              NumEntries;
    MIB_IPPATH_ROW[1] Table; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ns-netioapi-mib_ipnet_row2
struct MIB_IPNET_ROW2
{
    SOCKADDR_INET     Address;
    uint              InterfaceIndex;
    NET_LUID_LH       InterfaceLuid;
    ubyte[32]         PhysicalAddress;
    uint              PhysicalAddressLength;
    NL_NEIGHBOR_STATE State;
    union
    {
        struct
        {
            // Native bit field: IsRouter: [0], IsUnreachable: [1]
            ubyte _bitfield0;
        }
        ubyte Flags;
    }
    union ReachabilityTime
    {
        uint LastReachable;
        uint LastUnreachable;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ns-netioapi-mib_ipnet_table2
struct MIB_IPNET_TABLE2
{
    uint              NumEntries;
    MIB_IPNET_ROW2[1] Table; // Flexible array
}

struct DNS_SETTINGS
{
    uint  Version;
    ulong Flags;
    PWSTR Hostname;
    PWSTR Domain;
    PWSTR SearchList;
}

struct DNS_SETTINGS2
{
    uint  Version;
    ulong Flags;
    PWSTR Hostname;
    PWSTR Domain;
    PWSTR SearchList;
    ulong SettingFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ns-netioapi-dns_doh_server_settings
struct DNS_DOH_SERVER_SETTINGS
{
    PWSTR Template;
    ulong Flags;
}

struct DNS_DOT_SERVER_SETTINGS
{
    PWSTR  Hostname;
    ulong  Flags;
    ushort Port;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ns-netioapi-dns_server_property_types
union DNS_SERVER_PROPERTY_TYPES
{
    DNS_DOH_SERVER_SETTINGS* DohSettings;
    DNS_DOT_SERVER_SETTINGS* DotSettings;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ns-netioapi-dns_server_property
struct DNS_SERVER_PROPERTY
{
    uint Version;
    uint ServerIndex;
    DNS_SERVER_PROPERTY_TYPE Type;
    DNS_SERVER_PROPERTY_TYPES Property;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ns-netioapi-dns_interface_settings
struct DNS_INTERFACE_SETTINGS
{
    uint  Version;
    ulong Flags;
    PWSTR Domain;
    PWSTR NameServer;
    PWSTR SearchList;
    uint  RegistrationEnabled;
    uint  RegisterAdapterName;
    uint  EnableLLMNR;
    uint  QueryAdapterName;
    PWSTR ProfileNameServer;
}

struct DNS_INTERFACE_SETTINGS_EX
{
    DNS_INTERFACE_SETTINGS SettingsV1;
    uint  DisableUnconstrainedQueries;
    PWSTR SupplementalSearchList;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/ns-netioapi-dns_interface_settings3
struct DNS_INTERFACE_SETTINGS3
{
    uint                 Version;
    ulong                Flags;
    PWSTR                Domain;
    PWSTR                NameServer;
    PWSTR                SearchList;
    uint                 RegistrationEnabled;
    uint                 RegisterAdapterName;
    uint                 EnableLLMNR;
    uint                 QueryAdapterName;
    PWSTR                ProfileNameServer;
    uint                 DisableUnconstrainedQueries;
    PWSTR                SupplementalSearchList;
    uint                 cServerProperties;
    DNS_SERVER_PROPERTY* ServerProperties;
    uint                 cProfileServerProperties;
    DNS_SERVER_PROPERTY* ProfileServerProperties;
}

struct DNS_INTERFACE_SETTINGS4
{
    uint                 Version;
    ulong                Flags;
    PWSTR                Domain;
    PWSTR                NameServer;
    PWSTR                SearchList;
    uint                 RegistrationEnabled;
    uint                 RegisterAdapterName;
    uint                 EnableLLMNR;
    uint                 QueryAdapterName;
    PWSTR                ProfileNameServer;
    uint                 DisableUnconstrainedQueries;
    PWSTR                SupplementalSearchList;
    uint                 cServerProperties;
    DNS_SERVER_PROPERTY* ServerProperties;
    uint                 cProfileServerProperties;
    DNS_SERVER_PROPERTY* ProfileServerProperties;
    uint                 EncryptedDnsAdapterFlags;
}

struct MIB_FL_VIRTUAL_INTERFACE_ROW
{
    ADDRESS_FAMILY Family;
    NET_LUID_LH    IfLuid;
    uint           VirtualIfId;
    GUID           CompartmentGuid;
    NET_FL_ISOLATION_MODE IsolationMode;
    NET_FL_VIRTUAL_INTERFACE_ORIGIN Origin;
    NET_LUID_LH    VirtualIfLuid;
    uint           VirtualIfIndex;
    BOOLEAN        AllowLocalNd;
    uint           AttachedFlsnpiClients;
    uint           FlsnpiClientConfigErrors;
    ulong          FlsnpiClientInjectErrors;
    ulong          FlsnpiClientCloneErrors;
    ulong          InFlsnpiIndicatedPackets;
    ulong          InFlsnpiClientReturnedPackets;
    ulong          InFlsnpiClientSilentlyDroppedPackets;
    ulong          InFlsnpiClientDroppedPackets;
    ulong          InFlsnpiClientInjectedPackets;
    ulong          InFlsnpiClientClonedPackets;
    ulong          OutFlsnpiIndicatedPackets;
    ulong          OutFlsnpiClientReturnedPackets;
    ulong          OutFlsnpiClientDroppedPackets;
    ulong          OutFlsnpiClientSilentlyDroppedPackets;
    ulong          OutFlsnpiClientInjectedPackets;
    ulong          OutFlsnpiClientClonedPackets;
    ulong          OutFlsnpiClientClonedPacketsForNbSplit;
}

struct MIB_FL_VIRTUAL_INTERFACE_TABLE
{
    uint NumEntries;
    MIB_FL_VIRTUAL_INTERFACE_ROW[1] Table; // Flexible array
}

struct PF_FILTER_DESCRIPTOR
{
    uint          dwFilterFlags;
    uint          dwRule;
    PFADDRESSTYPE pfatType;
    ubyte*        SrcAddr;
    ubyte*        SrcMask;
    ubyte*        DstAddr;
    ubyte*        DstMask;
    uint          dwProtocol;
    uint          fLateBound;
    ushort        wSrcPort;
    ushort        wDstPort;
    ushort        wSrcPortHighRange;
    ushort        wDstPortHighRange;
}

struct PF_FILTER_STATS
{
    uint                 dwNumPacketsFiltered;
    PF_FILTER_DESCRIPTOR info;
}

struct PF_INTERFACE_STATS
{
    void*              pvDriverContext;
    uint               dwFlags;
    uint               dwInDrops;
    uint               dwOutDrops;
    PFFORWARD_ACTION   eaInAction;
    PFFORWARD_ACTION   eaOutAction;
    uint               dwNumInFilters;
    uint               dwNumOutFilters;
    uint               dwFrag;
    uint               dwSpoof;
    uint               dwReserved1;
    uint               dwReserved2;
    long               liSYN;
    long               liTotalLogged;
    uint               dwLostLogEntries;
    PF_FILTER_STATS[1] FilterInfo; // Flexible array
}

struct PF_LATEBIND_INFO
{
    ubyte* SrcAddr;
    ubyte* DstAddr;
    ubyte* Mask;
}

struct PFLOGFRAME
{
    long        Timestamp;
    PFFRAMETYPE pfeTypeOfFrame;
    uint        dwTotalSizeUsed;
    uint        dwFilterRule;
    ushort      wSizeOfAdditionalData;
    ushort      wSizeOfIpHeader;
    uint        dwInterfaceName;
    uint        dwIPIndex;
    ubyte[1]    bPacketData; // Flexible array
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
HANDLE IcmpCreateFile();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("IPHLPAPI.dll")
HANDLE Icmp6CreateFile();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
BOOL IcmpCloseHandle(HANDLE IcmpHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint IcmpSendEcho(HANDLE IcmpHandle, uint DestinationAddress, 
                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* RequestData, 
                  ushort RequestSize, IP_OPTION_INFORMATION* RequestOptions, 
                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* ReplyBuffer, 
                  uint ReplySize, uint Timeout);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint IcmpSendEcho2(HANDLE IcmpHandle, HANDLE Event, PIO_APC_ROUTINE ApcRoutine, void* ApcContext, 
                   uint DestinationAddress, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* RequestData, 
                   ushort RequestSize, IP_OPTION_INFORMATION* RequestOptions, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(9)))])*/void* ReplyBuffer, 
                   uint ReplySize, uint Timeout);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
uint IcmpSendEcho2Ex(HANDLE IcmpHandle, HANDLE Event, PIO_APC_ROUTINE ApcRoutine, void* ApcContext, 
                     uint SourceAddress, uint DestinationAddress, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/void* RequestData, 
                     ushort RequestSize, IP_OPTION_INFORMATION* RequestOptions, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(10)))])*/void* ReplyBuffer, 
                     uint ReplySize, uint Timeout);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("IPHLPAPI.dll")
uint Icmp6SendEcho2(HANDLE IcmpHandle, HANDLE Event, PIO_APC_ROUTINE ApcRoutine, void* ApcContext, 
                    SOCKADDR_IN6* SourceAddress, SOCKADDR_IN6* DestinationAddress, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/void* RequestData, 
                    ushort RequestSize, IP_OPTION_INFORMATION* RequestOptions, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(10)))])*/void* ReplyBuffer, 
                    uint ReplySize, uint Timeout);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint IcmpParseReplies(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* ReplyBuffer, 
                      uint ReplySize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("IPHLPAPI.dll")
uint Icmp6ParseReplies(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* ReplyBuffer, 
                       uint ReplySize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint GetNumberOfInterfaces(uint* pdwNumIf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint GetIfEntry(MIB_IFROW* pIfRow);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint GetIfTable(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/MIB_IFTABLE* pIfTable, 
                uint* pdwSize, BOOL bOrder);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint GetIpAddrTable(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/MIB_IPADDRTABLE* pIpAddrTable, 
                    uint* pdwSize, BOOL bOrder);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint GetIpNetTable(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/MIB_IPNETTABLE* IpNetTable, 
                   uint* SizePointer, BOOL Order);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint GetIpForwardTable(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/MIB_IPFORWARDTABLE* pIpForwardTable, 
                       uint* pdwSize, BOOL bOrder);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint GetTcpTable(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/MIB_TCPTABLE* TcpTable, 
                 uint* SizePointer, BOOL Order);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
uint GetExtendedTcpTable(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pTcpTable, 
                         uint* pdwSize, BOOL bOrder, uint ulAf, TCP_TABLE_CLASS TableClass, uint Reserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
uint GetOwnerModuleFromTcpEntry(MIB_TCPROW_OWNER_MODULE* pTcpEntry, TCPIP_OWNER_MODULE_INFO_CLASS Class, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pBuffer, 
                                uint* pdwSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint GetUdpTable(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/MIB_UDPTABLE* UdpTable, 
                 uint* SizePointer, BOOL Order);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
uint GetExtendedUdpTable(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pUdpTable, 
                         uint* pdwSize, BOOL bOrder, uint ulAf, UDP_TABLE_CLASS TableClass, uint Reserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
uint GetOwnerModuleFromUdpEntry(MIB_UDPROW_OWNER_MODULE* pUdpEntry, TCPIP_OWNER_MODULE_INFO_CLASS Class, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pBuffer, 
                                uint* pdwSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
uint GetTcpTable2(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/MIB_TCPTABLE2* TcpTable, 
                  uint* SizePointer, BOOL Order);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
uint GetTcp6Table(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/MIB_TCP6TABLE* TcpTable, 
                  uint* SizePointer, BOOL Order);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
uint GetTcp6Table2(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/MIB_TCP6TABLE2* TcpTable, 
                   uint* SizePointer, BOOL Order);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
uint GetPerTcpConnectionEStats(MIB_TCPROW_LH* Row, TCP_ESTATS_TYPE EstatsType, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* Rw, 
                               uint RwVersion, uint RwSize, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/ubyte* Ros, 
                               uint RosVersion, uint RosSize, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(10)))])*/ubyte* Rod, 
                               uint RodVersion, uint RodSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
uint SetPerTcpConnectionEStats(MIB_TCPROW_LH* Row, TCP_ESTATS_TYPE EstatsType, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* Rw, 
                               uint RwVersion, uint RwSize, uint Offset);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
uint GetPerTcp6ConnectionEStats(MIB_TCP6ROW* Row, TCP_ESTATS_TYPE EstatsType, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* Rw, 
                                uint RwVersion, uint RwSize, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/ubyte* Ros, 
                                uint RosVersion, uint RosSize, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(10)))])*/ubyte* Rod, 
                                uint RodVersion, uint RodSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
uint SetPerTcp6ConnectionEStats(MIB_TCP6ROW* Row, TCP_ESTATS_TYPE EstatsType, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* Rw, 
                                uint RwVersion, uint RwSize, uint Offset);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
uint GetOwnerModuleFromTcp6Entry(MIB_TCP6ROW_OWNER_MODULE* pTcpEntry, TCPIP_OWNER_MODULE_INFO_CLASS Class, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pBuffer, 
                                 uint* pdwSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
uint GetUdp6Table(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/MIB_UDP6TABLE* Udp6Table, 
                  uint* SizePointer, BOOL Order);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
uint GetOwnerModuleFromUdp6Entry(MIB_UDP6ROW_OWNER_MODULE* pUdpEntry, TCPIP_OWNER_MODULE_INFO_CLASS Class, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pBuffer, 
                                 uint* pdwSize);

@DllImport("IPHLPAPI.dll")
uint GetOwnerModuleFromPidAndInfo(uint ulPid, ulong* pInfo, TCPIP_OWNER_MODULE_INFO_CLASS Class, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pBuffer, 
                                  uint* pdwSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint GetIpStatistics(MIB_IPSTATS_LH* Statistics);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint GetIcmpStatistics(MIB_ICMP* Statistics);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint GetTcpStatistics(MIB_TCPSTATS_LH* Statistics);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint GetUdpStatistics(MIB_UDPSTATS* Stats);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
uint SetIpStatisticsEx(MIB_IPSTATS_LH* Statistics, uint Family);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("IPHLPAPI.dll")
uint GetIpStatisticsEx(MIB_IPSTATS_LH* Statistics, uint Family);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("IPHLPAPI.dll")
uint GetIcmpStatisticsEx(MIB_ICMP_EX_XPSP1* Statistics, uint Family);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("IPHLPAPI.dll")
uint GetTcpStatisticsEx(MIB_TCPSTATS_LH* Statistics, uint Family);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("IPHLPAPI.dll")
uint GetUdpStatisticsEx(MIB_UDPSTATS* Statistics, uint Family);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("IPHLPAPI.dll")
uint GetTcpStatisticsEx2(MIB_TCPSTATS2* Statistics, uint Family);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.16299))], [])
@DllImport("IPHLPAPI.dll")
uint GetUdpStatisticsEx2(MIB_UDPSTATS2* Statistics, uint Family);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint SetIfEntry(MIB_IFROW* pIfRow);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint CreateIpForwardEntry(MIB_IPFORWARDROW* pRoute);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint SetIpForwardEntry(MIB_IPFORWARDROW* pRoute);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint DeleteIpForwardEntry(MIB_IPFORWARDROW* pRoute);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint SetIpStatistics(MIB_IPSTATS_LH* pIpStats);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint SetIpTTL(uint nTTL);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint CreateIpNetEntry(MIB_IPNETROW_LH* pArpEntry);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint SetIpNetEntry(MIB_IPNETROW_LH* pArpEntry);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint DeleteIpNetEntry(MIB_IPNETROW_LH* pArpEntry);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint FlushIpNetTable(uint dwIfIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint CreateProxyArpEntry(uint dwAddress, uint dwMask, uint dwIfIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint DeleteProxyArpEntry(uint dwAddress, uint dwMask, uint dwIfIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint SetTcpEntry(MIB_TCPROW_LH* pTcpRow);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint GetInterfaceInfo(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/IP_INTERFACE_INFO* pIfTable, 
                      uint* dwOutBufLen);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iphlpapi/nf-iphlpapi-getunidirectionaladapterinfo
@DllImport("IPHLPAPI.dll")
uint GetUniDirectionalAdapterInfo(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/IP_UNIDIRECTIONAL_ADAPTER_ADDRESS* pIPIfInfo, 
                                  uint* dwOutBufLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("IPHLPAPI.dll")
uint NhpAllocateAndGetInterfaceInfoFromStack(IP_INTERFACE_NAME_INFO_W2KSP1** ppTable, uint* pdwCount, BOOL bOrder, 
                                             HANDLE hHeap, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint GetBestInterface(uint dwDestAddr, uint* pdwBestIfIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("IPHLPAPI.dll")
uint GetBestInterfaceEx(SOCKADDR* pDestAddr, uint* pdwBestIfIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint GetBestRoute(uint dwDestAddr, uint dwSourceAddr, MIB_IPFORWARDROW* pBestRoute);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint NotifyAddrChange(HANDLE* Handle, OVERLAPPED* overlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint NotifyRouteChange(HANDLE* Handle, OVERLAPPED* overlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("IPHLPAPI.dll")
BOOL CancelIPChangeNotify(OVERLAPPED* notifyOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint GetAdapterIndex(PWSTR AdapterName, uint* IfIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint AddIPAddress(uint Address, uint IpMask, uint IfIndex, uint* NTEContext, uint* NTEInstance);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint DeleteIPAddress(uint NTEContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetNetworkParams(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/FIXED_INFO_W2KSP1* pFixedInfo, 
                             uint* pOutBufLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint GetAdaptersInfo(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/IP_ADAPTER_INFO* AdapterInfo, 
                     uint* SizePointer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("IPHLPAPI.dll")
IP_ADAPTER_ORDER_MAP* GetAdapterOrderMap();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("IPHLPAPI.dll")
uint GetAdaptersAddresses(uint Family, GET_ADAPTERS_ADDRESSES_FLAGS Flags, 
                          /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* Reserved, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/IP_ADAPTER_ADDRESSES_LH* AdapterAddresses, 
                          uint* SizePointer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint GetPerAdapterInfo(uint IfIndex, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/IP_PER_ADAPTER_INFO_W2KSP1* pPerAdapterInfo, 
                       uint* pOutBufLen);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iphlpapi/nf-iphlpapi-getinterfaceactivetimestampcapabilities
@DllImport("IPHLPAPI.dll")
uint GetInterfaceActiveTimestampCapabilities(const(NET_LUID_LH)* InterfaceLuid, 
                                             INTERFACE_TIMESTAMP_CAPABILITIES* TimestampCapabilites);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iphlpapi/nf-iphlpapi-getinterfacesupportedtimestampcapabilities
@DllImport("IPHLPAPI.dll")
uint GetInterfaceSupportedTimestampCapabilities(const(NET_LUID_LH)* InterfaceLuid, 
                                                INTERFACE_TIMESTAMP_CAPABILITIES* TimestampCapabilites);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iphlpapi/nf-iphlpapi-captureinterfacehardwarecrosstimestamp
@DllImport("IPHLPAPI.dll")
uint CaptureInterfaceHardwareCrossTimestamp(const(NET_LUID_LH)* InterfaceLuid, 
                                            INTERFACE_HARDWARE_CROSSTIMESTAMP* CrossTimestamp);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iphlpapi/nf-iphlpapi-registerinterfacetimestampconfigchange
@DllImport("IPHLPAPI.dll")
uint RegisterInterfaceTimestampConfigChange(PINTERFACE_TIMESTAMP_CONFIG_CHANGE_CALLBACK Callback, 
                                            void* CallerContext, HIFTIMESTAMPCHANGE* NotificationHandle);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iphlpapi/nf-iphlpapi-unregisterinterfacetimestampconfigchange
@DllImport("IPHLPAPI.dll")
void UnregisterInterfaceTimestampConfigChange(HIFTIMESTAMPCHANGE NotificationHandle);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iphlpapi/nf-iphlpapi-getinterfacecurrenttimestampcapabilities
@DllImport("IPHLPAPI.DLL")
uint GetInterfaceCurrentTimestampCapabilities(const(NET_LUID_LH)* InterfaceLuid, 
                                              INTERFACE_TIMESTAMP_CAPABILITIES* TimestampCapabilites);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iphlpapi/nf-iphlpapi-getinterfacehardwaretimestampcapabilities
@DllImport("IPHLPAPI.DLL")
uint GetInterfaceHardwareTimestampCapabilities(const(NET_LUID_LH)* InterfaceLuid, 
                                               INTERFACE_TIMESTAMP_CAPABILITIES* TimestampCapabilites);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iphlpapi/nf-iphlpapi-notifyiftimestampconfigchange
@DllImport("IPHLPAPI.DLL")
uint NotifyIfTimestampConfigChange(void* CallerContext, PINTERFACE_TIMESTAMP_CONFIG_CHANGE_CALLBACK Callback, 
                                   HIFTIMESTAMPCHANGE* NotificationHandle);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iphlpapi/nf-iphlpapi-canceliftimestampconfigchange
@DllImport("IPHLPAPI.DLL")
void CancelIfTimestampConfigChange(HIFTIMESTAMPCHANGE NotificationHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint IpReleaseAddress(IP_ADAPTER_INDEX_MAP* AdapterInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint IpRenewAddress(IP_ADAPTER_INDEX_MAP* AdapterInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint SendARP(uint DestIP, uint SrcIP, 
             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pMacAddr, 
             uint* PhyAddrLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
BOOL GetRTTAndHopCount(uint DestIpAddress, uint* HopCount, uint MaxHops, uint* RTT);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint GetFriendlyIfIndex(uint IfIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint EnableRouter(HANDLE* pHandle, OVERLAPPED* pOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("IPHLPAPI.dll")
uint UnenableRouter(OVERLAPPED* pOverlapped, uint* lpdwEnableCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("IPHLPAPI.dll")
uint DisableMediaSense(HANDLE* pHandle, OVERLAPPED* pOverLapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("IPHLPAPI.dll")
uint RestoreMediaSense(OVERLAPPED* pOverlapped, uint* lpdwEnableCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("IPHLPAPI.dll")
uint GetIpErrorString(uint ErrorCode, PWSTR Buffer, uint* Size);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("IPHLPAPI.dll")
uint ResolveNeighbor(SOCKADDR* NetworkAddress, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* PhysicalAddress, 
                     uint* PhysicalAddressLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
uint CreatePersistentTcpPortReservation(ushort StartPort, ushort NumberOfPorts, ulong* Token);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
uint CreatePersistentUdpPortReservation(ushort StartPort, ushort NumberOfPorts, ulong* Token);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
uint DeletePersistentTcpPortReservation(ushort StartPort, ushort NumberOfPorts);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
uint DeletePersistentUdpPortReservation(ushort StartPort, ushort NumberOfPorts);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
uint LookupPersistentTcpPortReservation(ushort StartPort, ushort NumberOfPorts, ulong* Token);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
uint LookupPersistentUdpPortReservation(ushort StartPort, ushort NumberOfPorts, ulong* Token);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
uint ParseNetworkString(const(PWSTR) NetworkString, uint Types, NET_ADDRESS_INFO* AddressInfo, ushort* PortNumber, 
                        ubyte* PrefixLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetIfEntry2(MIB_IF_ROW2* Row);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetIfEntry2Ex(MIB_IF_ENTRY_LEVEL Level, MIB_IF_ROW2* Row);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetIfTable2(MIB_IF_TABLE2** Table);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetIfTable2Ex(MIB_IF_TABLE_LEVEL Level, MIB_IF_TABLE2** Table);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetIfStackTable(MIB_IFSTACK_TABLE** Table);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetInvertedIfStackTable(MIB_INVERTEDIFSTACK_TABLE** Table);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetIpInterfaceEntry(MIB_IPINTERFACE_ROW* Row);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetIpInterfaceTable(ADDRESS_FAMILY Family, MIB_IPINTERFACE_TABLE** Table);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
void InitializeIpInterfaceEntry(MIB_IPINTERFACE_ROW* Row);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR NotifyIpInterfaceChange(ADDRESS_FAMILY Family, PIPINTERFACE_CHANGE_CALLBACK Callback, 
                                    void* CallerContext, BOOLEAN InitialNotification, HANDLE* NotificationHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR SetIpInterfaceEntry(MIB_IPINTERFACE_ROW* Row);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetIpNetworkConnectionBandwidthEstimates(uint InterfaceIndex, ADDRESS_FAMILY AddressFamily, 
                                                     MIB_IP_NETWORK_CONNECTION_BANDWIDTH_ESTIMATES* BandwidthEstimates);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR CreateUnicastIpAddressEntry(const(MIB_UNICASTIPADDRESS_ROW)* Row);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR DeleteUnicastIpAddressEntry(const(MIB_UNICASTIPADDRESS_ROW)* Row);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetUnicastIpAddressEntry(MIB_UNICASTIPADDRESS_ROW* Row);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetUnicastIpAddressTable(ADDRESS_FAMILY Family, MIB_UNICASTIPADDRESS_TABLE** Table);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
void InitializeUnicastIpAddressEntry(MIB_UNICASTIPADDRESS_ROW* Row);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR NotifyUnicastIpAddressChange(ADDRESS_FAMILY Family, PUNICAST_IPADDRESS_CHANGE_CALLBACK Callback, 
                                         void* CallerContext, BOOLEAN InitialNotification, 
                                         HANDLE* NotificationHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR NotifyStableUnicastIpAddressTable(ADDRESS_FAMILY Family, MIB_UNICASTIPADDRESS_TABLE** Table, 
                                              PSTABLE_UNICAST_IPADDRESS_TABLE_CALLBACK CallerCallback, 
                                              void* CallerContext, HANDLE* NotificationHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR SetUnicastIpAddressEntry(const(MIB_UNICASTIPADDRESS_ROW)* Row);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR CreateAnycastIpAddressEntry(const(MIB_ANYCASTIPADDRESS_ROW)* Row);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR DeleteAnycastIpAddressEntry(const(MIB_ANYCASTIPADDRESS_ROW)* Row);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetAnycastIpAddressEntry(MIB_ANYCASTIPADDRESS_ROW* Row);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetAnycastIpAddressTable(ADDRESS_FAMILY Family, MIB_ANYCASTIPADDRESS_TABLE** Table);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetMulticastIpAddressEntry(MIB_MULTICASTIPADDRESS_ROW* Row);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetMulticastIpAddressTable(ADDRESS_FAMILY Family, MIB_MULTICASTIPADDRESS_TABLE** Table);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR CreateIpForwardEntry2(const(MIB_IPFORWARD_ROW2)* Row);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR DeleteIpForwardEntry2(const(MIB_IPFORWARD_ROW2)* Row);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetBestRoute2(NET_LUID_LH* InterfaceLuid, uint InterfaceIndex, const(SOCKADDR_INET)* SourceAddress, 
                          const(SOCKADDR_INET)* DestinationAddress, uint AddressSortOptions, 
                          MIB_IPFORWARD_ROW2* BestRoute, SOCKADDR_INET* BestSourceAddress);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetIpForwardEntry2(MIB_IPFORWARD_ROW2* Row);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetIpForwardTable2(ADDRESS_FAMILY Family, MIB_IPFORWARD_TABLE2** Table);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
void InitializeIpForwardEntry(MIB_IPFORWARD_ROW2* Row);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR NotifyRouteChange2(ADDRESS_FAMILY AddressFamily, PIPFORWARD_CHANGE_CALLBACK Callback, 
                               void* CallerContext, BOOLEAN InitialNotification, HANDLE* NotificationHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR SetIpForwardEntry2(const(MIB_IPFORWARD_ROW2)* Route);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR FlushIpPathTable(ADDRESS_FAMILY Family);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetIpPathEntry(MIB_IPPATH_ROW* Row);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetIpPathTable(ADDRESS_FAMILY Family, MIB_IPPATH_TABLE** Table);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR CreateIpNetEntry2(const(MIB_IPNET_ROW2)* Row);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR DeleteIpNetEntry2(const(MIB_IPNET_ROW2)* Row);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR FlushIpNetTable2(ADDRESS_FAMILY Family, uint InterfaceIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetIpNetEntry2(MIB_IPNET_ROW2* Row);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetIpNetTable2(ADDRESS_FAMILY Family, MIB_IPNET_TABLE2** Table);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR ResolveIpNetEntry2(MIB_IPNET_ROW2* Row, const(SOCKADDR_INET)* SourceAddress);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR SetIpNetEntry2(MIB_IPNET_ROW2* Row);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR NotifyTeredoPortChange(PTEREDO_PORT_CHANGE_CALLBACK Callback, void* CallerContext, 
                                   BOOLEAN InitialNotification, HANDLE* NotificationHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetTeredoPort(ushort* Port);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR CancelMibChangeNotify2(HANDLE NotificationHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
void FreeMibTable(void* Memory);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR CreateSortedAddressPairs(const(SOCKADDR_IN6)* SourceAddressList, uint SourceAddressCount, 
                                     const(SOCKADDR_IN6)* DestinationAddressList, uint DestinationAddressCount, 
                                     uint AddressSortOptions, SOCKADDR_IN6_PAIR** SortedAddressPairList, 
                                     uint* SortedAddressPairCount);

@DllImport("IPHLPAPI.dll")
WIN32_ERROR ConvertCompartmentGuidToId(const(GUID)* CompartmentGuid, uint* CompartmentId);

@DllImport("IPHLPAPI.dll")
WIN32_ERROR ConvertCompartmentIdToGuid(NET_IF_COMPARTMENT_ID CompartmentId, GUID* CompartmentGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR ConvertInterfaceNameToLuidA(const(PSTR) InterfaceName, NET_LUID_LH* InterfaceLuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR ConvertInterfaceNameToLuidW(const(PWSTR) InterfaceName, NET_LUID_LH* InterfaceLuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR ConvertInterfaceLuidToNameA(const(NET_LUID_LH)* InterfaceLuid, PSTR InterfaceName, size_t Length);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR ConvertInterfaceLuidToNameW(const(NET_LUID_LH)* InterfaceLuid, PWSTR InterfaceName, size_t Length);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR ConvertInterfaceLuidToIndex(const(NET_LUID_LH)* InterfaceLuid, uint* InterfaceIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR ConvertInterfaceIndexToLuid(uint InterfaceIndex, NET_LUID_LH* InterfaceLuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR ConvertInterfaceLuidToAlias(const(NET_LUID_LH)* InterfaceLuid, PWSTR InterfaceAlias, size_t Length);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR ConvertInterfaceAliasToLuid(const(PWSTR) InterfaceAlias, NET_LUID_LH* InterfaceLuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR ConvertInterfaceLuidToGuid(const(NET_LUID_LH)* InterfaceLuid, GUID* InterfaceGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR ConvertInterfaceGuidToLuid(const(GUID)* InterfaceGuid, NET_LUID_LH* InterfaceLuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
uint if_nametoindex(const(PSTR) InterfaceName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
PSTR if_indextoname(uint InterfaceIndex, 
                    /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR InterfaceName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/nf-netioapi-getcurrentthreadcompartmentid
@DllImport("IPHLPAPI.dll")
NET_IF_COMPARTMENT_ID GetCurrentThreadCompartmentId();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/nf-netioapi-setcurrentthreadcompartmentid
@DllImport("IPHLPAPI.dll")
WIN32_ERROR SetCurrentThreadCompartmentId(NET_IF_COMPARTMENT_ID CompartmentId);

@DllImport("IPHLPAPI.dll")
void GetCurrentThreadCompartmentScope(uint* CompartmentScope, uint* CompartmentId);

@DllImport("IPHLPAPI.dll")
WIN32_ERROR SetCurrentThreadCompartmentScope(uint CompartmentScope);

@DllImport("IPHLPAPI.dll")
NET_IF_COMPARTMENT_ID GetJobCompartmentId(HANDLE JobHandle);

@DllImport("IPHLPAPI.dll")
WIN32_ERROR SetJobCompartmentId(HANDLE JobHandle, NET_IF_COMPARTMENT_ID CompartmentId);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/nf-netioapi-getsessioncompartmentid
@DllImport("IPHLPAPI.dll")
NET_IF_COMPARTMENT_ID GetSessionCompartmentId(uint SessionId);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/nf-netioapi-setsessioncompartmentid
@DllImport("IPHLPAPI.dll")
WIN32_ERROR SetSessionCompartmentId(uint SessionId, NET_IF_COMPARTMENT_ID CompartmentId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("IPHLPAPI.dll")
NET_IF_COMPARTMENT_ID GetDefaultCompartmentId();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/nf-netioapi-getnetworkinformation
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetNetworkInformation(const(GUID)* NetworkGuid, uint* CompartmentId, uint* SiteId, 
                                  /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR NetworkName, 
                                  uint Length);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/nf-netioapi-setnetworkinformation
@DllImport("IPHLPAPI.dll")
WIN32_ERROR SetNetworkInformation(const(GUID)* NetworkGuid, NET_IF_COMPARTMENT_ID CompartmentId, 
                                  const(PWSTR) NetworkName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR ConvertLengthToIpv4Mask(uint MaskLength, uint* Mask);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR ConvertIpv4MaskToLength(uint Mask, ubyte* MaskLength);

@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetDnsSettings(DNS_SETTINGS* Settings);

@DllImport("IPHLPAPI.dll")
void FreeDnsSettings(DNS_SETTINGS* Settings);

@DllImport("IPHLPAPI.dll")
WIN32_ERROR SetDnsSettings(const(DNS_SETTINGS)* Settings);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/nf-netioapi-getinterfacednssettings
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetInterfaceDnsSettings(GUID Interface, DNS_INTERFACE_SETTINGS* Settings);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/nf-netioapi-freeinterfacednssettings
@DllImport("IPHLPAPI.dll")
void FreeInterfaceDnsSettings(DNS_INTERFACE_SETTINGS* Settings);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/netioapi/nf-netioapi-setinterfacednssettings
@DllImport("IPHLPAPI.dll")
WIN32_ERROR SetInterfaceDnsSettings(GUID Interface, const(DNS_INTERFACE_SETTINGS)* Settings);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetNetworkConnectivityHint(NL_NETWORK_CONNECTIVITY_HINT* ConnectivityHint);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR GetNetworkConnectivityHintForInterface(uint InterfaceIndex, 
                                                   NL_NETWORK_CONNECTIVITY_HINT* ConnectivityHint);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.19041))], [])
@DllImport("IPHLPAPI.dll")
WIN32_ERROR NotifyNetworkConnectivityHintChange(PNETWORK_CONNECTIVITY_HINT_CHANGE_CALLBACK Callback, 
                                                void* CallerContext, BOOLEAN InitialNotification, 
                                                HANDLE* NotificationHandle);

@DllImport("IPHLPAPI.DLL")
uint CreateFlVirtualInterface(const(MIB_FL_VIRTUAL_INTERFACE_ROW)* Row);

@DllImport("IPHLPAPI.DLL")
uint DeleteFlVirtualInterface(const(MIB_FL_VIRTUAL_INTERFACE_ROW)* Row);

@DllImport("IPHLPAPI.DLL")
void InitializeFlVirtualInterfaceEntry(MIB_FL_VIRTUAL_INTERFACE_ROW* Row);

@DllImport("IPHLPAPI.DLL")
uint SetFlVirtualInterface(const(MIB_FL_VIRTUAL_INTERFACE_ROW)* Row);

@DllImport("IPHLPAPI.DLL")
uint GetFlVirtualInterface(MIB_FL_VIRTUAL_INTERFACE_ROW* Row);

@DllImport("IPHLPAPI.DLL")
uint GetFlVirtualInterfaceTable(ADDRESS_FAMILY Family, MIB_FL_VIRTUAL_INTERFACE_TABLE** Table);

@DllImport("IPHLPAPI.dll")
uint PfCreateInterface(uint dwName, PFFORWARD_ACTION inAction, PFFORWARD_ACTION outAction, BOOL bUseLog, 
                       BOOL bMustBeUnique, void** ppInterface);

@DllImport("IPHLPAPI.dll")
uint PfDeleteInterface(void* pInterface);

@DllImport("IPHLPAPI.dll")
uint PfAddFiltersToInterface(void* ih, uint cInFilters, PF_FILTER_DESCRIPTOR* pfiltIn, uint cOutFilters, 
                             PF_FILTER_DESCRIPTOR* pfiltOut, void** pfHandle);

@DllImport("IPHLPAPI.dll")
uint PfRemoveFiltersFromInterface(void* ih, uint cInFilters, PF_FILTER_DESCRIPTOR* pfiltIn, uint cOutFilters, 
                                  PF_FILTER_DESCRIPTOR* pfiltOut);

@DllImport("IPHLPAPI.dll")
uint PfRemoveFilterHandles(void* pInterface, uint cFilters, void** pvHandles);

@DllImport("IPHLPAPI.dll")
uint PfUnBindInterface(void* pInterface);

@DllImport("IPHLPAPI.dll")
uint PfBindInterfaceToIndex(void* pInterface, uint dwIndex, PFADDRESSTYPE pfatLinkType, ubyte* LinkIPAddress);

@DllImport("IPHLPAPI.dll")
uint PfBindInterfaceToIPAddress(void* pInterface, PFADDRESSTYPE pfatType, ubyte* IPAddress);

@DllImport("IPHLPAPI.dll")
uint PfRebindFilters(void* pInterface, PF_LATEBIND_INFO* pLateBindInfo);

@DllImport("IPHLPAPI.dll")
uint PfAddGlobalFilterToInterface(void* pInterface, GLOBAL_FILTER gfFilter);

@DllImport("IPHLPAPI.dll")
uint PfRemoveGlobalFilterFromInterface(void* pInterface, GLOBAL_FILTER gfFilter);

@DllImport("IPHLPAPI.dll")
uint PfMakeLog(HANDLE hEvent);

@DllImport("IPHLPAPI.dll")
uint PfSetLogBuffer(ubyte* pbBuffer, uint dwSize, uint dwThreshold, uint dwEntries, uint* pdwLoggedEntries, 
                    uint* pdwLostEntries, uint* pdwSizeUsed);

@DllImport("IPHLPAPI.dll")
uint PfDeleteLog();

@DllImport("IPHLPAPI.dll")
uint PfGetInterfaceStatistics(void* pInterface, PF_INTERFACE_STATS* ppfStats, uint* pdwBufferSize, 
                              BOOL fResetCounters);

@DllImport("IPHLPAPI.dll")
uint PfTestPacket(void* pInInterface, void* pOutInterface, uint cBytes, ubyte* pbPacket, 
                  PFFORWARD_ACTION* ppAction);


