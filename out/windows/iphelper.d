module windows.iphelper;

public import windows.core;
public import windows.mib : MIB_ANYCASTIPADDRESS_ROW, MIB_ANYCASTIPADDRESS_TABLE, MIB_ICMP, MIB_ICMP_EX_XPSP1,
                            MIB_IFROW, MIB_IFSTACK_TABLE, MIB_IFTABLE, MIB_IF_ROW2, MIB_IF_TABLE2,
                            MIB_INVERTEDIFSTACK_TABLE, MIB_IPADDRTABLE, MIB_IPFORWARDROW, MIB_IPFORWARDTABLE,
                            MIB_IPFORWARD_ROW2, MIB_IPFORWARD_TABLE2, MIB_IPINTERFACE_ROW, MIB_IPINTERFACE_TABLE,
                            MIB_IPNETROW_LH, MIB_IPNETTABLE, MIB_IPNET_ROW2, MIB_IPNET_TABLE2, MIB_IPPATH_ROW,
                            MIB_IPPATH_TABLE, MIB_IPSTATS_LH, MIB_IP_NETWORK_CONNECTION_BANDWIDTH_ESTIMATES,
                            MIB_MULTICASTIPADDRESS_ROW, MIB_MULTICASTIPADDRESS_TABLE, MIB_NOTIFICATION_TYPE,
                            MIB_TCP6ROW, MIB_TCP6ROW_OWNER_MODULE, MIB_TCP6TABLE, MIB_TCP6TABLE2, MIB_TCPROW_LH,
                            MIB_TCPROW_OWNER_MODULE, MIB_TCPSTATS2, MIB_TCPSTATS_LH, MIB_TCPTABLE, MIB_TCPTABLE2,
                            MIB_UDP6ROW_OWNER_MODULE, MIB_UDP6TABLE, MIB_UDPROW_OWNER_MODULE, MIB_UDPSTATS,
                            MIB_UDPSTATS2, MIB_UDPTABLE, MIB_UNICASTIPADDRESS_ROW, MIB_UNICASTIPADDRESS_TABLE;
public import windows.networkdrivers : MIB_IF_TABLE_LEVEL, NET_IF_CONNECTION_TYPE, SOCKADDR_IN6_LH, TUNNEL_TYPE;
public import windows.systemservices : BOOL, FARPROC, HANDLE, NTSTATUS, OVERLAPPED;
public import windows.winsock : SOCKADDR, SOCKET_ADDRESS, in6_addr, in_addr, sockaddr_in;
public import windows.windowsfiltering : DL_EUI48;

extern(Windows):


// Enums


enum : int
{
    IF_ACCESS_LOOPBACK             = 0x00000001,
    IF_ACCESS_BROADCAST            = 0x00000002,
    IF_ACCESS_POINT_TO_POINT       = 0x00000003,
    IF_ACCESS_POINTTOPOINT         = 0x00000003,
    IF_ACCESS_POINT_TO_MULTI_POINT = 0x00000004,
    IF_ACCESS_POINTTOMULTIPOINT    = 0x00000004,
}
alias IF_ACCESS_TYPE = int;

enum : int
{
    IF_OPER_STATUS_NON_OPERATIONAL = 0x00000000,
    IF_OPER_STATUS_UNREACHABLE     = 0x00000001,
    IF_OPER_STATUS_DISCONNECTED    = 0x00000002,
    IF_OPER_STATUS_CONNECTING      = 0x00000003,
    IF_OPER_STATUS_CONNECTED       = 0x00000004,
    IF_OPER_STATUS_OPERATIONAL     = 0x00000005,
}
alias INTERNAL_IF_OPER_STATUS = int;

enum : int
{
    NET_IF_RCV_ADDRESS_TYPE_OTHER        = 0x00000001,
    NET_IF_RCV_ADDRESS_TYPE_VOLATILE     = 0x00000002,
    NET_IF_RCV_ADDRESS_TYPE_NON_VOLATILE = 0x00000003,
}
alias NET_IF_RCV_ADDRESS_TYPE = int;

enum : int
{
    IF_ADMINISTRATIVE_DISABLED   = 0x00000000,
    IF_ADMINISTRATIVE_ENABLED    = 0x00000001,
    IF_ADMINISTRATIVE_DEMANDDIAL = 0x00000002,
}
alias IF_ADMINISTRATIVE_STATE = int;

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
alias IF_OPER_STATUS = int;

enum : int
{
    MibIfEntryNormal                  = 0x00000000,
    MibIfEntryNormalWithoutStatistics = 0x00000002,
}
alias MIB_IF_ENTRY_LEVEL = int;

enum : int
{
    MIB_IPROUTE_TYPE_OTHER    = 0x00000001,
    MIB_IPROUTE_TYPE_INVALID  = 0x00000002,
    MIB_IPROUTE_TYPE_DIRECT   = 0x00000003,
    MIB_IPROUTE_TYPE_INDIRECT = 0x00000004,
}
alias MIB_IPFORWARD_TYPE = int;

enum : int
{
    MIB_IPNET_TYPE_OTHER   = 0x00000001,
    MIB_IPNET_TYPE_INVALID = 0x00000002,
    MIB_IPNET_TYPE_DYNAMIC = 0x00000003,
    MIB_IPNET_TYPE_STATIC  = 0x00000004,
}
alias MIB_IPNET_TYPE = int;

enum : int
{
    MIB_IP_FORWARDING     = 0x00000001,
    MIB_IP_NOT_FORWARDING = 0x00000002,
}
alias MIB_IPSTATS_FORWARDING = int;

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
alias MIB_TCP_STATE = int;

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
alias TCP_RTO_ALGORITHM = int;

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
alias TCP_TABLE_CLASS = int;

enum : int
{
    UDP_TABLE_BASIC        = 0x00000000,
    UDP_TABLE_OWNER_PID    = 0x00000001,
    UDP_TABLE_OWNER_MODULE = 0x00000002,
}
alias UDP_TABLE_CLASS = int;

enum : int
{
    TCPIP_OWNER_MODULE_INFO_BASIC = 0x00000000,
}
alias TCPIP_OWNER_MODULE_INFO_CLASS = int;

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
alias TCP_ESTATS_TYPE = int;

enum : int
{
    TcpBoolOptDisabled  = 0x00000000,
    TcpBoolOptEnabled   = 0x00000001,
    TcpBoolOptUnchanged = 0xffffffff,
}
alias TCP_BOOLEAN_OPTIONAL = int;

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
alias TCP_SOFT_ERROR = int;

enum : int
{
    NET_ADDRESS_FORMAT_UNSPECIFIED = 0x00000000,
    NET_ADDRESS_DNS_NAME           = 0x00000001,
    NET_ADDRESS_IPV4               = 0x00000002,
    NET_ADDRESS_IPV6               = 0x00000003,
}
alias NET_ADDRESS_FORMAT = int;

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
alias SCOPE_LEVEL = int;

enum : int
{
    IpPrefixOriginOther               = 0x00000000,
    IpPrefixOriginManual              = 0x00000001,
    IpPrefixOriginWellKnown           = 0x00000002,
    IpPrefixOriginDhcp                = 0x00000003,
    IpPrefixOriginRouterAdvertisement = 0x00000004,
    IpPrefixOriginUnchanged           = 0x00000010,
}
alias NL_PREFIX_ORIGIN = int;

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
alias NL_SUFFIX_ORIGIN = int;

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
alias NL_DAD_STATE = int;

enum : int
{
    NetworkConnectivityLevelHintUnknown                   = 0x00000000,
    NetworkConnectivityLevelHintNone                      = 0x00000001,
    NetworkConnectivityLevelHintLocalAccess               = 0x00000002,
    NetworkConnectivityLevelHintInternetAccess            = 0x00000003,
    NetworkConnectivityLevelHintConstrainedInternetAccess = 0x00000004,
    NetworkConnectivityLevelHintHidden                    = 0x00000005,
}
alias NL_NETWORK_CONNECTIVITY_LEVEL_HINT = int;

enum : int
{
    NetworkConnectivityCostHintUnknown      = 0x00000000,
    NetworkConnectivityCostHintUnrestricted = 0x00000001,
    NetworkConnectivityCostHintFixed        = 0x00000002,
    NetworkConnectivityCostHintVariable     = 0x00000003,
}
alias NL_NETWORK_CONNECTIVITY_COST_HINT = int;

// Callbacks

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
alias INTERFACE_TIMESTAMP_CONFIG_CHANGE_CALLBACK = void function(void* CallerContext);
alias PINTERFACE_TIMESTAMP_CONFIG_CHANGE_CALLBACK = void function();

// Structs


alias IcmpHandle = ptrdiff_t;

struct ip_option_information
{
    ubyte  Ttl;
    ubyte  Tos;
    ubyte  Flags;
    ubyte  OptionsSize;
    ubyte* OptionsData;
}

struct icmp_echo_reply
{
    uint   Address;
    uint   Status;
    uint   RoundTripTime;
    ushort DataSize;
    ushort Reserved;
    void*  Data;
    ip_option_information Options;
}

struct IPV6_ADDRESS_EX
{
align (1):
    ushort    sin6_port;
    uint      sin6_flowinfo;
    ushort[8] sin6_addr;
    uint      sin6_scope_id;
}

struct icmpv6_echo_reply_lh
{
    IPV6_ADDRESS_EX Address;
    uint            Status;
    uint            RoundTripTime;
}

struct arp_send_reply
{
    uint DestAddress;
    uint SrcAddress;
}

struct tcp_reserve_port_range
{
    ushort UpperRange;
    ushort LowerRange;
}

struct IP_ADAPTER_INDEX_MAP
{
    uint        Index;
    ushort[128] Name;
}

struct IP_INTERFACE_INFO
{
    int NumAdapters;
    IP_ADAPTER_INDEX_MAP[1] Adapter;
}

struct IP_UNIDIRECTIONAL_ADAPTER_ADDRESS
{
    uint    NumAdapters;
    uint[1] Address;
}

struct IP_ADAPTER_ORDER_MAP
{
    uint    NumAdapters;
    uint[1] AdapterOrder;
}

struct IP_MCAST_COUNTER_INFO
{
    ulong InMcastOctets;
    ulong OutMcastOctets;
    ulong InMcastPkts;
    ulong OutMcastPkts;
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

union NET_LUID_LH
{
    ulong Value;
    struct Info
    {
        ulong _bitfield61;
    }
}

struct IF_PHYSICAL_ADDRESS_LH
{
    ushort    Length;
    ubyte[32] Address;
}

struct IP_ADDRESS_PREFIX
{
    SOCKADDR_INET Prefix;
    ubyte         PrefixLength;
}

struct DNS_SETTINGS
{
    uint          Version;
    ulong         Flags;
    const(wchar)* Hostname;
    const(wchar)* Domain;
    const(wchar)* SearchList;
}

struct DNS_INTERFACE_SETTINGS
{
    uint          Version;
    ulong         Flags;
    const(wchar)* Domain;
    const(wchar)* NameServer;
    const(wchar)* SearchList;
    uint          RegistrationEnabled;
    uint          RegisterAdapterName;
    uint          EnableLLMNR;
    uint          QueryAdapterName;
    const(wchar)* ProfileNameServer;
}

struct DNS_INTERFACE_SETTINGS_EX
{
    DNS_INTERFACE_SETTINGS SettingsV1;
    uint          DisableUnconstrainedQueries;
    const(wchar)* SupplementalSearchList;
}

struct TCPIP_OWNER_MODULE_BASIC_INFO
{
    const(wchar)* pModuleName;
    const(wchar)* pModulePath;
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
    MIB_IPDESTROW[1] table;
}

struct MIB_ROUTESTATE
{
    BOOL bRoutesSetToStack;
}

struct IP_ADDRESS_STRING
{
    byte[16] String;
}

struct IP_ADDR_STRING
{
    IP_ADDR_STRING*   Next;
    IP_ADDRESS_STRING IpAddress;
    IP_ADDRESS_STRING IpMask;
    uint              Context;
}

struct IP_ADAPTER_INFO
{
    IP_ADAPTER_INFO* Next;
    uint             ComboIndex;
    byte[260]        AdapterName;
    byte[132]        Description;
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

struct IP_ADAPTER_DNS_SUFFIX
{
    IP_ADAPTER_DNS_SUFFIX* Next;
    ushort[256] String;
}

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
    const(char)*   AdapterName;
    IP_ADAPTER_UNICAST_ADDRESS_LH* FirstUnicastAddress;
    IP_ADAPTER_ANYCAST_ADDRESS_XP* FirstAnycastAddress;
    IP_ADAPTER_MULTICAST_ADDRESS_XP* FirstMulticastAddress;
    IP_ADAPTER_DNS_SERVER_ADDRESS_XP* FirstDnsServerAddress;
    const(wchar)*  DnsSuffix;
    const(wchar)*  Description;
    const(wchar)*  FriendlyName;
    ubyte[8]       PhysicalAddress;
    uint           PhysicalAddressLength;
    union
    {
        uint Flags;
        struct
        {
            uint _bitfield62;
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
    uint           CompartmentId;
    GUID           NetworkGuid;
    NET_IF_CONNECTION_TYPE ConnectionType;
    TUNNEL_TYPE    TunnelType;
    SOCKET_ADDRESS Dhcpv6Server;
    ubyte[130]     Dhcpv6ClientDuid;
    uint           Dhcpv6ClientDuidLength;
    uint           Dhcpv6Iaid;
    IP_ADAPTER_DNS_SUFFIX* FirstDnsSuffix;
}

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
    const(char)*   AdapterName;
    IP_ADAPTER_UNICAST_ADDRESS_XP* FirstUnicastAddress;
    IP_ADAPTER_ANYCAST_ADDRESS_XP* FirstAnycastAddress;
    IP_ADAPTER_MULTICAST_ADDRESS_XP* FirstMulticastAddress;
    IP_ADAPTER_DNS_SERVER_ADDRESS_XP* FirstDnsServerAddress;
    const(wchar)*  DnsSuffix;
    const(wchar)*  Description;
    const(wchar)*  FriendlyName;
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

struct IP_PER_ADAPTER_INFO_W2KSP1
{
    uint            AutoconfigEnabled;
    uint            AutoconfigActive;
    IP_ADDR_STRING* CurrentDnsServer;
    IP_ADDR_STRING  DnsServerList;
}

struct FIXED_INFO_W2KSP1
{
    byte[132]       HostName;
    byte[132]       DomainName;
    IP_ADDR_STRING* CurrentDnsServer;
    IP_ADDR_STRING  DnsServerList;
    uint            NodeType;
    byte[260]       ScopeId;
    uint            EnableRouting;
    uint            EnableProxy;
    uint            EnableDns;
}

struct ip_interface_name_info_w2ksp1
{
    uint  Index;
    uint  MediaType;
    ubyte ConnectionType;
    ubyte AccessType;
    GUID  DeviceGuid;
    GUID  InterfaceGuid;
}

struct TCP_ESTATS_SYN_OPTS_ROS_v0
{
    ubyte ActiveOpen;
    uint  MssRcvd;
    uint  MssSent;
}

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

struct TCP_ESTATS_DATA_RW_v0
{
    ubyte EnableCollection;
}

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

struct TCP_ESTATS_SND_CONG_ROS_v0
{
    uint LimCwnd;
}

struct TCP_ESTATS_SND_CONG_RW_v0
{
    ubyte EnableCollection;
}

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

struct TCP_ESTATS_PATH_RW_v0
{
    ubyte EnableCollection;
}

struct TCP_ESTATS_SEND_BUFF_ROD_v0
{
    size_t CurRetxQueue;
    size_t MaxRetxQueue;
    size_t CurAppWQueue;
    size_t MaxAppWQueue;
}

struct TCP_ESTATS_SEND_BUFF_RW_v0
{
    ubyte EnableCollection;
}

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

struct TCP_ESTATS_REC_RW_v0
{
    ubyte EnableCollection;
}

struct TCP_ESTATS_OBS_REC_ROD_v0
{
    uint  CurRwinRcvd;
    uint  MaxRwinRcvd;
    uint  MinRwinRcvd;
    ubyte WinScaleRcvd;
}

struct TCP_ESTATS_OBS_REC_RW_v0
{
    ubyte EnableCollection;
}

struct TCP_ESTATS_BANDWIDTH_RW_v0
{
    TCP_BOOLEAN_OPTIONAL EnableCollectionOutbound;
    TCP_BOOLEAN_OPTIONAL EnableCollectionInbound;
}

struct TCP_ESTATS_BANDWIDTH_ROD_v0
{
    ulong OutboundBandwidth;
    ulong InboundBandwidth;
    ulong OutboundInstability;
    ulong InboundInstability;
    ubyte OutboundBandwidthPeaked;
    ubyte InboundBandwidthPeaked;
}

struct TCP_ESTATS_FINE_RTT_RW_v0
{
    ubyte EnableCollection;
}

struct TCP_ESTATS_FINE_RTT_ROD_v0
{
    uint RttVar;
    uint MaxRtt;
    uint MinRtt;
    uint SumRtt;
}

struct INTERFACE_TIMESTAMP_CAPABILITY_FLAGS
{
    ubyte PtpV2OverUdpIPv4EventMsgReceiveHw;
    ubyte PtpV2OverUdpIPv4AllMsgReceiveHw;
    ubyte PtpV2OverUdpIPv4EventMsgTransmitHw;
    ubyte PtpV2OverUdpIPv4AllMsgTransmitHw;
    ubyte PtpV2OverUdpIPv6EventMsgReceiveHw;
    ubyte PtpV2OverUdpIPv6AllMsgReceiveHw;
    ubyte PtpV2OverUdpIPv6EventMsgTransmitHw;
    ubyte PtpV2OverUdpIPv6AllMsgTransmitHw;
    ubyte AllReceiveHw;
    ubyte AllTransmitHw;
    ubyte TaggedTransmitHw;
    ubyte AllReceiveSw;
    ubyte AllTransmitSw;
    ubyte TaggedTransmitSw;
}

struct INTERFACE_TIMESTAMP_CAPABILITIES
{
    uint  Version;
    ulong HardwareClockFrequencyHz;
    ubyte CrossTimestamp;
    ulong Reserved1;
    ulong Reserved2;
    INTERFACE_TIMESTAMP_CAPABILITY_FLAGS TimestampFlags;
}

struct INTERFACE_HARDWARE_CROSSTIMESTAMP
{
    uint  Version;
    uint  Flags;
    ulong SystemTimestamp1;
    ulong HardwareClockTimestamp;
    ulong SystemTimestamp2;
}

struct HIFTIMESTAMPCHANGE__
{
    int unused;
}

struct NET_ADDRESS_INFO
{
}

union SOCKADDR_INET
{
    sockaddr_in     Ipv4;
    SOCKADDR_IN6_LH Ipv6;
    ushort          si_family;
}

struct SOCKADDR_IN6_PAIR
{
    SOCKADDR_IN6_LH* SourceAddress;
    SOCKADDR_IN6_LH* DestinationAddress;
}

struct NL_NETWORK_CONNECTIVITY_HINT
{
    NL_NETWORK_CONNECTIVITY_LEVEL_HINT ConnectivityLevel;
    NL_NETWORK_CONNECTIVITY_COST_HINT ConnectivityCost;
    ubyte ApproachingDataLimit;
    ubyte OverDataLimit;
    ubyte Roaming;
}

struct NL_BANDWIDTH_INFORMATION
{
    ulong Bandwidth;
    ulong Instability;
    ubyte BandwidthPeaked;
}

// Functions

@DllImport("IPHLPAPI")
NTSTATUS GetIfEntry2(MIB_IF_ROW2* Row);

@DllImport("IPHLPAPI")
NTSTATUS GetIfEntry2Ex(MIB_IF_ENTRY_LEVEL Level, MIB_IF_ROW2* Row);

@DllImport("IPHLPAPI")
NTSTATUS GetIfTable2(MIB_IF_TABLE2** Table);

@DllImport("IPHLPAPI")
NTSTATUS GetIfTable2Ex(MIB_IF_TABLE_LEVEL Level, MIB_IF_TABLE2** Table);

@DllImport("IPHLPAPI")
NTSTATUS GetIfStackTable(MIB_IFSTACK_TABLE** Table);

@DllImport("IPHLPAPI")
NTSTATUS GetInvertedIfStackTable(MIB_INVERTEDIFSTACK_TABLE** Table);

@DllImport("IPHLPAPI")
NTSTATUS GetIpInterfaceEntry(MIB_IPINTERFACE_ROW* Row);

@DllImport("IPHLPAPI")
NTSTATUS GetIpInterfaceTable(ushort Family, MIB_IPINTERFACE_TABLE** Table);

@DllImport("IPHLPAPI")
void InitializeIpInterfaceEntry(MIB_IPINTERFACE_ROW* Row);

@DllImport("IPHLPAPI")
NTSTATUS NotifyIpInterfaceChange(ushort Family, PIPINTERFACE_CHANGE_CALLBACK Callback, void* CallerContext, 
                                 ubyte InitialNotification, HANDLE* NotificationHandle);

@DllImport("IPHLPAPI")
NTSTATUS SetIpInterfaceEntry(MIB_IPINTERFACE_ROW* Row);

@DllImport("IPHLPAPI")
NTSTATUS GetIpNetworkConnectionBandwidthEstimates(uint InterfaceIndex, ushort AddressFamily, 
                                                  MIB_IP_NETWORK_CONNECTION_BANDWIDTH_ESTIMATES* BandwidthEstimates);

@DllImport("IPHLPAPI")
NTSTATUS CreateUnicastIpAddressEntry(const(MIB_UNICASTIPADDRESS_ROW)* Row);

@DllImport("IPHLPAPI")
NTSTATUS DeleteUnicastIpAddressEntry(const(MIB_UNICASTIPADDRESS_ROW)* Row);

@DllImport("IPHLPAPI")
NTSTATUS GetUnicastIpAddressEntry(MIB_UNICASTIPADDRESS_ROW* Row);

@DllImport("IPHLPAPI")
NTSTATUS GetUnicastIpAddressTable(ushort Family, MIB_UNICASTIPADDRESS_TABLE** Table);

@DllImport("IPHLPAPI")
void InitializeUnicastIpAddressEntry(MIB_UNICASTIPADDRESS_ROW* Row);

@DllImport("IPHLPAPI")
NTSTATUS NotifyUnicastIpAddressChange(ushort Family, PUNICAST_IPADDRESS_CHANGE_CALLBACK Callback, 
                                      void* CallerContext, ubyte InitialNotification, HANDLE* NotificationHandle);

@DllImport("IPHLPAPI")
NTSTATUS NotifyStableUnicastIpAddressTable(ushort Family, MIB_UNICASTIPADDRESS_TABLE** Table, 
                                           PSTABLE_UNICAST_IPADDRESS_TABLE_CALLBACK CallerCallback, 
                                           void* CallerContext, HANDLE* NotificationHandle);

@DllImport("IPHLPAPI")
NTSTATUS SetUnicastIpAddressEntry(const(MIB_UNICASTIPADDRESS_ROW)* Row);

@DllImport("IPHLPAPI")
NTSTATUS CreateAnycastIpAddressEntry(const(MIB_ANYCASTIPADDRESS_ROW)* Row);

@DllImport("IPHLPAPI")
NTSTATUS DeleteAnycastIpAddressEntry(const(MIB_ANYCASTIPADDRESS_ROW)* Row);

@DllImport("IPHLPAPI")
NTSTATUS GetAnycastIpAddressEntry(MIB_ANYCASTIPADDRESS_ROW* Row);

@DllImport("IPHLPAPI")
NTSTATUS GetAnycastIpAddressTable(ushort Family, MIB_ANYCASTIPADDRESS_TABLE** Table);

@DllImport("IPHLPAPI")
NTSTATUS GetMulticastIpAddressEntry(MIB_MULTICASTIPADDRESS_ROW* Row);

@DllImport("IPHLPAPI")
NTSTATUS GetMulticastIpAddressTable(ushort Family, MIB_MULTICASTIPADDRESS_TABLE** Table);

@DllImport("IPHLPAPI")
NTSTATUS CreateIpForwardEntry2(const(MIB_IPFORWARD_ROW2)* Row);

@DllImport("IPHLPAPI")
NTSTATUS DeleteIpForwardEntry2(const(MIB_IPFORWARD_ROW2)* Row);

@DllImport("IPHLPAPI")
NTSTATUS GetBestRoute2(NET_LUID_LH* InterfaceLuid, uint InterfaceIndex, const(SOCKADDR_INET)* SourceAddress, 
                       const(SOCKADDR_INET)* DestinationAddress, uint AddressSortOptions, 
                       MIB_IPFORWARD_ROW2* BestRoute, SOCKADDR_INET* BestSourceAddress);

@DllImport("IPHLPAPI")
NTSTATUS GetIpForwardEntry2(MIB_IPFORWARD_ROW2* Row);

@DllImport("IPHLPAPI")
NTSTATUS GetIpForwardTable2(ushort Family, MIB_IPFORWARD_TABLE2** Table);

@DllImport("IPHLPAPI")
void InitializeIpForwardEntry(MIB_IPFORWARD_ROW2* Row);

@DllImport("IPHLPAPI")
NTSTATUS NotifyRouteChange2(ushort AddressFamily, PIPFORWARD_CHANGE_CALLBACK Callback, void* CallerContext, 
                            ubyte InitialNotification, HANDLE* NotificationHandle);

@DllImport("IPHLPAPI")
NTSTATUS SetIpForwardEntry2(const(MIB_IPFORWARD_ROW2)* Route);

@DllImport("IPHLPAPI")
NTSTATUS FlushIpPathTable(ushort Family);

@DllImport("IPHLPAPI")
NTSTATUS GetIpPathEntry(MIB_IPPATH_ROW* Row);

@DllImport("IPHLPAPI")
NTSTATUS GetIpPathTable(ushort Family, MIB_IPPATH_TABLE** Table);

@DllImport("IPHLPAPI")
NTSTATUS CreateIpNetEntry2(const(MIB_IPNET_ROW2)* Row);

@DllImport("IPHLPAPI")
NTSTATUS DeleteIpNetEntry2(const(MIB_IPNET_ROW2)* Row);

@DllImport("IPHLPAPI")
NTSTATUS FlushIpNetTable2(ushort Family, uint InterfaceIndex);

@DllImport("IPHLPAPI")
NTSTATUS GetIpNetEntry2(MIB_IPNET_ROW2* Row);

@DllImport("IPHLPAPI")
NTSTATUS GetIpNetTable2(ushort Family, MIB_IPNET_TABLE2** Table);

@DllImport("IPHLPAPI")
NTSTATUS ResolveIpNetEntry2(MIB_IPNET_ROW2* Row, const(SOCKADDR_INET)* SourceAddress);

@DllImport("IPHLPAPI")
NTSTATUS SetIpNetEntry2(MIB_IPNET_ROW2* Row);

@DllImport("IPHLPAPI")
NTSTATUS NotifyTeredoPortChange(PTEREDO_PORT_CHANGE_CALLBACK Callback, void* CallerContext, 
                                ubyte InitialNotification, HANDLE* NotificationHandle);

@DllImport("IPHLPAPI")
NTSTATUS GetTeredoPort(ushort* Port);

@DllImport("IPHLPAPI")
NTSTATUS CancelMibChangeNotify2(HANDLE NotificationHandle);

@DllImport("IPHLPAPI")
void FreeMibTable(void* Memory);

@DllImport("IPHLPAPI")
NTSTATUS CreateSortedAddressPairs(const(SOCKADDR_IN6_LH)* SourceAddressList, uint SourceAddressCount, 
                                  const(SOCKADDR_IN6_LH)* DestinationAddressList, uint DestinationAddressCount, 
                                  uint AddressSortOptions, SOCKADDR_IN6_PAIR** SortedAddressPairList, 
                                  uint* SortedAddressPairCount);

@DllImport("IPHLPAPI")
NTSTATUS ConvertCompartmentGuidToId(const(GUID)* CompartmentGuid, uint* CompartmentId);

@DllImport("IPHLPAPI")
NTSTATUS ConvertCompartmentIdToGuid(uint CompartmentId, GUID* CompartmentGuid);

@DllImport("IPHLPAPI")
NTSTATUS ConvertInterfaceNameToLuidA(const(byte)* InterfaceName, NET_LUID_LH* InterfaceLuid);

@DllImport("IPHLPAPI")
NTSTATUS ConvertInterfaceNameToLuidW(const(wchar)* InterfaceName, NET_LUID_LH* InterfaceLuid);

@DllImport("IPHLPAPI")
NTSTATUS ConvertInterfaceLuidToNameA(const(NET_LUID_LH)* InterfaceLuid, const(char)* InterfaceName, size_t Length);

@DllImport("IPHLPAPI")
NTSTATUS ConvertInterfaceLuidToNameW(const(NET_LUID_LH)* InterfaceLuid, const(wchar)* InterfaceName, size_t Length);

@DllImport("IPHLPAPI")
NTSTATUS ConvertInterfaceLuidToIndex(const(NET_LUID_LH)* InterfaceLuid, uint* InterfaceIndex);

@DllImport("IPHLPAPI")
NTSTATUS ConvertInterfaceIndexToLuid(uint InterfaceIndex, NET_LUID_LH* InterfaceLuid);

@DllImport("IPHLPAPI")
NTSTATUS ConvertInterfaceLuidToAlias(const(NET_LUID_LH)* InterfaceLuid, const(wchar)* InterfaceAlias, 
                                     size_t Length);

@DllImport("IPHLPAPI")
NTSTATUS ConvertInterfaceAliasToLuid(const(wchar)* InterfaceAlias, NET_LUID_LH* InterfaceLuid);

@DllImport("IPHLPAPI")
NTSTATUS ConvertInterfaceLuidToGuid(const(NET_LUID_LH)* InterfaceLuid, GUID* InterfaceGuid);

@DllImport("IPHLPAPI")
NTSTATUS ConvertInterfaceGuidToLuid(const(GUID)* InterfaceGuid, NET_LUID_LH* InterfaceLuid);

@DllImport("IPHLPAPI")
uint if_nametoindex(const(char)* InterfaceName);

@DllImport("IPHLPAPI")
byte* if_indextoname(uint InterfaceIndex, const(char)* InterfaceName);

@DllImport("IPHLPAPI")
void GetCurrentThreadCompartmentScope(uint* CompartmentScope, uint* CompartmentId);

@DllImport("IPHLPAPI")
NTSTATUS SetCurrentThreadCompartmentScope(uint CompartmentScope);

@DllImport("IPHLPAPI")
uint GetJobCompartmentId(HANDLE JobHandle);

@DllImport("IPHLPAPI")
NTSTATUS SetJobCompartmentId(HANDLE JobHandle, uint CompartmentId);

@DllImport("IPHLPAPI")
uint GetDefaultCompartmentId();

@DllImport("IPHLPAPI")
NTSTATUS ConvertLengthToIpv4Mask(uint MaskLength, uint* Mask);

@DllImport("IPHLPAPI")
NTSTATUS ConvertIpv4MaskToLength(uint Mask, ubyte* MaskLength);

@DllImport("IPHLPAPI")
NTSTATUS GetDnsSettings(DNS_SETTINGS* Settings);

@DllImport("IPHLPAPI")
void FreeDnsSettings(DNS_SETTINGS* Settings);

@DllImport("IPHLPAPI")
NTSTATUS SetDnsSettings(const(DNS_SETTINGS)* Settings);

@DllImport("IPHLPAPI")
NTSTATUS GetInterfaceDnsSettings(GUID Interface, DNS_INTERFACE_SETTINGS* Settings);

@DllImport("IPHLPAPI")
void FreeInterfaceDnsSettings(DNS_INTERFACE_SETTINGS* Settings);

@DllImport("IPHLPAPI")
NTSTATUS SetInterfaceDnsSettings(GUID Interface, const(DNS_INTERFACE_SETTINGS)* Settings);

@DllImport("IPHLPAPI")
NTSTATUS GetNetworkConnectivityHint(NL_NETWORK_CONNECTIVITY_HINT* ConnectivityHint);

@DllImport("IPHLPAPI")
NTSTATUS GetNetworkConnectivityHintForInterface(uint InterfaceIndex, 
                                                NL_NETWORK_CONNECTIVITY_HINT* ConnectivityHint);

@DllImport("IPHLPAPI")
NTSTATUS NotifyNetworkConnectivityHintChange(PNETWORK_CONNECTIVITY_HINT_CHANGE_CALLBACK Callback, 
                                             void* CallerContext, ubyte InitialNotification, 
                                             ptrdiff_t* NotificationHandle);

@DllImport("IPHLPAPI")
IcmpHandle IcmpCreateFile();

@DllImport("IPHLPAPI")
IcmpHandle Icmp6CreateFile();

@DllImport("IPHLPAPI")
BOOL IcmpCloseHandle(HANDLE IcmpHandle);

@DllImport("IPHLPAPI")
uint IcmpSendEcho(HANDLE IcmpHandle, uint DestinationAddress, char* RequestData, ushort RequestSize, 
                  ip_option_information* RequestOptions, char* ReplyBuffer, uint ReplySize, uint Timeout);

@DllImport("IPHLPAPI")
uint IcmpSendEcho2(HANDLE IcmpHandle, HANDLE Event, FARPROC ApcRoutine, void* ApcContext, uint DestinationAddress, 
                   char* RequestData, ushort RequestSize, ip_option_information* RequestOptions, char* ReplyBuffer, 
                   uint ReplySize, uint Timeout);

@DllImport("IPHLPAPI")
uint IcmpSendEcho2Ex(HANDLE IcmpHandle, HANDLE Event, FARPROC ApcRoutine, void* ApcContext, uint SourceAddress, 
                     uint DestinationAddress, char* RequestData, ushort RequestSize, 
                     ip_option_information* RequestOptions, char* ReplyBuffer, uint ReplySize, uint Timeout);

@DllImport("IPHLPAPI")
uint Icmp6SendEcho2(HANDLE IcmpHandle, HANDLE Event, FARPROC ApcRoutine, void* ApcContext, 
                    SOCKADDR_IN6_LH* SourceAddress, SOCKADDR_IN6_LH* DestinationAddress, char* RequestData, 
                    ushort RequestSize, ip_option_information* RequestOptions, char* ReplyBuffer, uint ReplySize, 
                    uint Timeout);

@DllImport("IPHLPAPI")
uint IcmpParseReplies(char* ReplyBuffer, uint ReplySize);

@DllImport("IPHLPAPI")
uint Icmp6ParseReplies(char* ReplyBuffer, uint ReplySize);

@DllImport("IPHLPAPI")
uint GetNumberOfInterfaces(uint* pdwNumIf);

@DllImport("IPHLPAPI")
uint GetIfEntry(MIB_IFROW* pIfRow);

@DllImport("IPHLPAPI")
uint GetIfTable(char* pIfTable, uint* pdwSize, BOOL bOrder);

@DllImport("IPHLPAPI")
uint GetIpAddrTable(char* pIpAddrTable, uint* pdwSize, BOOL bOrder);

@DllImport("IPHLPAPI")
uint GetIpNetTable(char* IpNetTable, uint* SizePointer, BOOL Order);

@DllImport("IPHLPAPI")
uint GetIpForwardTable(char* pIpForwardTable, uint* pdwSize, BOOL bOrder);

@DllImport("IPHLPAPI")
uint GetTcpTable(char* TcpTable, uint* SizePointer, BOOL Order);

@DllImport("IPHLPAPI")
uint GetExtendedTcpTable(char* pTcpTable, uint* pdwSize, BOOL bOrder, uint ulAf, TCP_TABLE_CLASS TableClass, 
                         uint Reserved);

@DllImport("IPHLPAPI")
uint GetOwnerModuleFromTcpEntry(MIB_TCPROW_OWNER_MODULE* pTcpEntry, TCPIP_OWNER_MODULE_INFO_CLASS Class, 
                                char* pBuffer, uint* pdwSize);

@DllImport("IPHLPAPI")
uint GetUdpTable(char* UdpTable, uint* SizePointer, BOOL Order);

@DllImport("IPHLPAPI")
uint GetExtendedUdpTable(char* pUdpTable, uint* pdwSize, BOOL bOrder, uint ulAf, UDP_TABLE_CLASS TableClass, 
                         uint Reserved);

@DllImport("IPHLPAPI")
uint GetOwnerModuleFromUdpEntry(MIB_UDPROW_OWNER_MODULE* pUdpEntry, TCPIP_OWNER_MODULE_INFO_CLASS Class, 
                                char* pBuffer, uint* pdwSize);

@DllImport("IPHLPAPI")
uint GetTcpTable2(char* TcpTable, uint* SizePointer, BOOL Order);

@DllImport("IPHLPAPI")
uint GetTcp6Table(char* TcpTable, uint* SizePointer, BOOL Order);

@DllImport("IPHLPAPI")
uint GetTcp6Table2(char* TcpTable, uint* SizePointer, BOOL Order);

@DllImport("IPHLPAPI")
uint GetPerTcpConnectionEStats(MIB_TCPROW_LH* Row, TCP_ESTATS_TYPE EstatsType, char* Rw, uint RwVersion, 
                               uint RwSize, char* Ros, uint RosVersion, uint RosSize, char* Rod, uint RodVersion, 
                               uint RodSize);

@DllImport("IPHLPAPI")
uint SetPerTcpConnectionEStats(MIB_TCPROW_LH* Row, TCP_ESTATS_TYPE EstatsType, char* Rw, uint RwVersion, 
                               uint RwSize, uint Offset);

@DllImport("IPHLPAPI")
uint GetPerTcp6ConnectionEStats(MIB_TCP6ROW* Row, TCP_ESTATS_TYPE EstatsType, char* Rw, uint RwVersion, 
                                uint RwSize, char* Ros, uint RosVersion, uint RosSize, char* Rod, uint RodVersion, 
                                uint RodSize);

@DllImport("IPHLPAPI")
uint SetPerTcp6ConnectionEStats(MIB_TCP6ROW* Row, TCP_ESTATS_TYPE EstatsType, char* Rw, uint RwVersion, 
                                uint RwSize, uint Offset);

@DllImport("IPHLPAPI")
uint GetOwnerModuleFromTcp6Entry(MIB_TCP6ROW_OWNER_MODULE* pTcpEntry, TCPIP_OWNER_MODULE_INFO_CLASS Class, 
                                 char* pBuffer, uint* pdwSize);

@DllImport("IPHLPAPI")
uint GetUdp6Table(char* Udp6Table, uint* SizePointer, BOOL Order);

@DllImport("IPHLPAPI")
uint GetOwnerModuleFromUdp6Entry(MIB_UDP6ROW_OWNER_MODULE* pUdpEntry, TCPIP_OWNER_MODULE_INFO_CLASS Class, 
                                 char* pBuffer, uint* pdwSize);

@DllImport("IPHLPAPI")
uint GetOwnerModuleFromPidAndInfo(uint ulPid, ulong* pInfo, TCPIP_OWNER_MODULE_INFO_CLASS Class, char* pBuffer, 
                                  uint* pdwSize);

@DllImport("IPHLPAPI")
uint GetIpStatistics(MIB_IPSTATS_LH* Statistics);

@DllImport("IPHLPAPI")
uint GetIcmpStatistics(MIB_ICMP* Statistics);

@DllImport("IPHLPAPI")
uint GetTcpStatistics(MIB_TCPSTATS_LH* Statistics);

@DllImport("IPHLPAPI")
uint GetUdpStatistics(MIB_UDPSTATS* Stats);

@DllImport("IPHLPAPI")
uint SetIpStatisticsEx(MIB_IPSTATS_LH* Statistics, uint Family);

@DllImport("IPHLPAPI")
uint GetIpStatisticsEx(MIB_IPSTATS_LH* Statistics, uint Family);

@DllImport("IPHLPAPI")
uint GetIcmpStatisticsEx(MIB_ICMP_EX_XPSP1* Statistics, uint Family);

@DllImport("IPHLPAPI")
uint GetTcpStatisticsEx(MIB_TCPSTATS_LH* Statistics, uint Family);

@DllImport("IPHLPAPI")
uint GetUdpStatisticsEx(MIB_UDPSTATS* Statistics, uint Family);

@DllImport("IPHLPAPI")
uint GetTcpStatisticsEx2(MIB_TCPSTATS2* Statistics, uint Family);

@DllImport("IPHLPAPI")
uint GetUdpStatisticsEx2(MIB_UDPSTATS2* Statistics, uint Family);

@DllImport("IPHLPAPI")
uint SetIfEntry(MIB_IFROW* pIfRow);

@DllImport("IPHLPAPI")
uint CreateIpForwardEntry(MIB_IPFORWARDROW* pRoute);

@DllImport("IPHLPAPI")
uint SetIpForwardEntry(MIB_IPFORWARDROW* pRoute);

@DllImport("IPHLPAPI")
uint DeleteIpForwardEntry(MIB_IPFORWARDROW* pRoute);

@DllImport("IPHLPAPI")
uint SetIpStatistics(MIB_IPSTATS_LH* pIpStats);

@DllImport("IPHLPAPI")
uint SetIpTTL(uint nTTL);

@DllImport("IPHLPAPI")
uint CreateIpNetEntry(MIB_IPNETROW_LH* pArpEntry);

@DllImport("IPHLPAPI")
uint SetIpNetEntry(MIB_IPNETROW_LH* pArpEntry);

@DllImport("IPHLPAPI")
uint DeleteIpNetEntry(MIB_IPNETROW_LH* pArpEntry);

@DllImport("IPHLPAPI")
uint FlushIpNetTable(uint dwIfIndex);

@DllImport("IPHLPAPI")
uint CreateProxyArpEntry(uint dwAddress, uint dwMask, uint dwIfIndex);

@DllImport("IPHLPAPI")
uint DeleteProxyArpEntry(uint dwAddress, uint dwMask, uint dwIfIndex);

@DllImport("IPHLPAPI")
uint SetTcpEntry(MIB_TCPROW_LH* pTcpRow);

@DllImport("IPHLPAPI")
uint GetInterfaceInfo(char* pIfTable, uint* dwOutBufLen);

@DllImport("IPHLPAPI")
uint GetUniDirectionalAdapterInfo(char* pIPIfInfo, uint* dwOutBufLen);

@DllImport("IPHLPAPI")
uint NhpAllocateAndGetInterfaceInfoFromStack(ip_interface_name_info_w2ksp1** ppTable, uint* pdwCount, BOOL bOrder, 
                                             HANDLE hHeap, uint dwFlags);

@DllImport("IPHLPAPI")
uint GetBestInterface(uint dwDestAddr, uint* pdwBestIfIndex);

@DllImport("IPHLPAPI")
uint GetBestInterfaceEx(SOCKADDR* pDestAddr, uint* pdwBestIfIndex);

@DllImport("IPHLPAPI")
uint GetBestRoute(uint dwDestAddr, uint dwSourceAddr, MIB_IPFORWARDROW* pBestRoute);

@DllImport("IPHLPAPI")
uint NotifyAddrChange(ptrdiff_t* Handle, OVERLAPPED* overlapped);

@DllImport("IPHLPAPI")
uint NotifyRouteChange(ptrdiff_t* Handle, OVERLAPPED* overlapped);

@DllImport("IPHLPAPI")
BOOL CancelIPChangeNotify(OVERLAPPED* notifyOverlapped);

@DllImport("IPHLPAPI")
uint GetAdapterIndex(const(wchar)* AdapterName, uint* IfIndex);

@DllImport("IPHLPAPI")
uint AddIPAddress(uint Address, uint IpMask, uint IfIndex, uint* NTEContext, uint* NTEInstance);

@DllImport("IPHLPAPI")
uint DeleteIPAddress(uint NTEContext);

@DllImport("IPHLPAPI")
uint GetNetworkParams(char* pFixedInfo, uint* pOutBufLen);

@DllImport("IPHLPAPI")
uint GetAdaptersInfo(char* AdapterInfo, uint* SizePointer);

@DllImport("IPHLPAPI")
IP_ADAPTER_ORDER_MAP* GetAdapterOrderMap();

@DllImport("IPHLPAPI")
uint GetAdaptersAddresses(uint Family, uint Flags, void* Reserved, char* AdapterAddresses, uint* SizePointer);

@DllImport("IPHLPAPI")
uint GetPerAdapterInfo(uint IfIndex, char* pPerAdapterInfo, uint* pOutBufLen);

@DllImport("IPHLPAPI")
uint GetInterfaceCurrentTimestampCapabilities(const(NET_LUID_LH)* InterfaceLuid, 
                                              INTERFACE_TIMESTAMP_CAPABILITIES* TimestampCapabilites);

@DllImport("IPHLPAPI")
uint GetInterfaceHardwareTimestampCapabilities(const(NET_LUID_LH)* InterfaceLuid, 
                                               INTERFACE_TIMESTAMP_CAPABILITIES* TimestampCapabilites);

@DllImport("IPHLPAPI")
uint CaptureInterfaceHardwareCrossTimestamp(const(NET_LUID_LH)* InterfaceLuid, 
                                            INTERFACE_HARDWARE_CROSSTIMESTAMP* CrossTimestamp);

@DllImport("IPHLPAPI")
uint NotifyIfTimestampConfigChange(void* CallerContext, PINTERFACE_TIMESTAMP_CONFIG_CHANGE_CALLBACK Callback, 
                                   HIFTIMESTAMPCHANGE__** NotificationHandle);

@DllImport("IPHLPAPI")
void CancelIfTimestampConfigChange(HIFTIMESTAMPCHANGE__* NotificationHandle);

@DllImport("IPHLPAPI")
uint IpReleaseAddress(IP_ADAPTER_INDEX_MAP* AdapterInfo);

@DllImport("IPHLPAPI")
uint IpRenewAddress(IP_ADAPTER_INDEX_MAP* AdapterInfo);

@DllImport("IPHLPAPI")
uint SendARP(uint DestIP, uint SrcIP, char* pMacAddr, uint* PhyAddrLen);

@DllImport("IPHLPAPI")
BOOL GetRTTAndHopCount(uint DestIpAddress, uint* HopCount, uint MaxHops, uint* RTT);

@DllImport("IPHLPAPI")
uint GetFriendlyIfIndex(uint IfIndex);

@DllImport("IPHLPAPI")
uint EnableRouter(HANDLE* pHandle, OVERLAPPED* pOverlapped);

@DllImport("IPHLPAPI")
uint UnenableRouter(OVERLAPPED* pOverlapped, uint* lpdwEnableCount);

@DllImport("IPHLPAPI")
uint DisableMediaSense(HANDLE* pHandle, OVERLAPPED* pOverLapped);

@DllImport("IPHLPAPI")
uint RestoreMediaSense(OVERLAPPED* pOverlapped, uint* lpdwEnableCount);

@DllImport("IPHLPAPI")
uint GetIpErrorString(uint ErrorCode, const(wchar)* Buffer, uint* Size);

@DllImport("IPHLPAPI")
uint ResolveNeighbor(SOCKADDR* NetworkAddress, char* PhysicalAddress, uint* PhysicalAddressLength);

@DllImport("IPHLPAPI")
uint CreatePersistentTcpPortReservation(ushort StartPort, ushort NumberOfPorts, ulong* Token);

@DllImport("IPHLPAPI")
uint CreatePersistentUdpPortReservation(ushort StartPort, ushort NumberOfPorts, ulong* Token);

@DllImport("IPHLPAPI")
uint DeletePersistentTcpPortReservation(ushort StartPort, ushort NumberOfPorts);

@DllImport("IPHLPAPI")
uint DeletePersistentUdpPortReservation(ushort StartPort, ushort NumberOfPorts);

@DllImport("IPHLPAPI")
uint LookupPersistentTcpPortReservation(ushort StartPort, ushort NumberOfPorts, ulong* Token);

@DllImport("IPHLPAPI")
uint LookupPersistentUdpPortReservation(ushort StartPort, ushort NumberOfPorts, ulong* Token);

@DllImport("ntdll")
byte* RtlIpv4AddressToStringA(const(in_addr)* Addr, const(char)* S);

@DllImport("ntdll")
ushort* RtlIpv4AddressToStringW(const(in_addr)* Addr, const(wchar)* S);

@DllImport("ntdll")
int RtlIpv4AddressToStringExW(const(in_addr)* Address, ushort Port, const(wchar)* AddressString, 
                              uint* AddressStringLength);

@DllImport("ntdll")
int RtlIpv4StringToAddressA(const(char)* S, ubyte Strict, byte** Terminator, in_addr* Addr);

@DllImport("ntdll")
int RtlIpv4StringToAddressW(const(wchar)* S, ubyte Strict, ushort** Terminator, in_addr* Addr);

@DllImport("ntdll")
int RtlIpv4StringToAddressExW(const(wchar)* AddressString, ubyte Strict, in_addr* Address, ushort* Port);

@DllImport("ntdll")
byte* RtlIpv6AddressToStringA(const(in6_addr)* Addr, const(char)* S);

@DllImport("ntdll")
ushort* RtlIpv6AddressToStringW(const(in6_addr)* Addr, const(wchar)* S);

@DllImport("ntdll")
int RtlIpv6AddressToStringExW(const(in6_addr)* Address, uint ScopeId, ushort Port, const(wchar)* AddressString, 
                              uint* AddressStringLength);

@DllImport("ntdll")
int RtlIpv6StringToAddressA(const(char)* S, byte** Terminator, in6_addr* Addr);

@DllImport("ntdll")
int RtlIpv6StringToAddressW(const(wchar)* S, ushort** Terminator, in6_addr* Addr);

@DllImport("ntdll")
int RtlIpv6StringToAddressExW(const(wchar)* AddressString, in6_addr* Address, uint* ScopeId, ushort* Port);

@DllImport("ntdll")
byte* RtlEthernetAddressToStringA(const(DL_EUI48)* Addr, const(char)* S);

@DllImport("ntdll")
ushort* RtlEthernetAddressToStringW(const(DL_EUI48)* Addr, const(wchar)* S);

@DllImport("ntdll")
int RtlEthernetStringToAddressA(const(char)* S, byte** Terminator, DL_EUI48* Addr);

@DllImport("ntdll")
int RtlEthernetStringToAddressW(const(wchar)* S, ushort** Terminator, DL_EUI48* Addr);


