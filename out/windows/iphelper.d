module windows.iphelper;

public import system;
public import windows.mib;
public import windows.networkdrivers;
public import windows.systemservices;
public import windows.winsock;
public import windows.windowsfiltering;

extern(Windows):

alias IcmpHandle = int;
struct ip_option_information
{
    ubyte Ttl;
    ubyte Tos;
    ubyte Flags;
    ubyte OptionsSize;
    ubyte* OptionsData;
}

struct icmp_echo_reply
{
    uint Address;
    uint Status;
    uint RoundTripTime;
    ushort DataSize;
    ushort Reserved;
    void* Data;
    ip_option_information Options;
}

struct IPV6_ADDRESS_EX
{
    ushort sin6_port;
    uint sin6_flowinfo;
    ushort sin6_addr;
    uint sin6_scope_id;
}

struct icmpv6_echo_reply_lh
{
    IPV6_ADDRESS_EX Address;
    uint Status;
    uint RoundTripTime;
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
    uint Index;
    ushort Name;
}

struct IP_INTERFACE_INFO
{
    int NumAdapters;
    IP_ADAPTER_INDEX_MAP Adapter;
}

struct IP_UNIDIRECTIONAL_ADAPTER_ADDRESS
{
    uint NumAdapters;
    uint Address;
}

struct IP_ADAPTER_ORDER_MAP
{
    uint NumAdapters;
    uint AdapterOrder;
}

struct IP_MCAST_COUNTER_INFO
{
    ulong InMcastOctets;
    ulong OutMcastOctets;
    ulong InMcastPkts;
    ulong OutMcastPkts;
}

enum IF_ACCESS_TYPE
{
    IF_ACCESS_LOOPBACK = 1,
    IF_ACCESS_BROADCAST = 2,
    IF_ACCESS_POINT_TO_POINT = 3,
    IF_ACCESS_POINTTOPOINT = 3,
    IF_ACCESS_POINT_TO_MULTI_POINT = 4,
    IF_ACCESS_POINTTOMULTIPOINT = 4,
}

enum INTERNAL_IF_OPER_STATUS
{
    IF_OPER_STATUS_NON_OPERATIONAL = 0,
    IF_OPER_STATUS_UNREACHABLE = 1,
    IF_OPER_STATUS_DISCONNECTED = 2,
    IF_OPER_STATUS_CONNECTING = 3,
    IF_OPER_STATUS_CONNECTED = 4,
    IF_OPER_STATUS_OPERATIONAL = 5,
}

enum NET_IF_RCV_ADDRESS_TYPE
{
    NET_IF_RCV_ADDRESS_TYPE_OTHER = 1,
    NET_IF_RCV_ADDRESS_TYPE_VOLATILE = 2,
    NET_IF_RCV_ADDRESS_TYPE_NON_VOLATILE = 3,
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

struct NET_LUID_LH
{
    ulong Value;
    _Info_e__Struct Info;
}

struct IF_PHYSICAL_ADDRESS_LH
{
    ushort Length;
    ubyte Address;
}

enum IF_ADMINISTRATIVE_STATE
{
    IF_ADMINISTRATIVE_DISABLED = 0,
    IF_ADMINISTRATIVE_ENABLED = 1,
    IF_ADMINISTRATIVE_DEMANDDIAL = 2,
}

enum IF_OPER_STATUS
{
    IfOperStatusUp = 1,
    IfOperStatusDown = 2,
    IfOperStatusTesting = 3,
    IfOperStatusUnknown = 4,
    IfOperStatusDormant = 5,
    IfOperStatusNotPresent = 6,
    IfOperStatusLowerLayerDown = 7,
}

enum MIB_IF_ENTRY_LEVEL
{
    MibIfEntryNormal = 0,
    MibIfEntryNormalWithoutStatistics = 2,
}

alias PIPINTERFACE_CHANGE_CALLBACK = extern(Windows) void function(void* CallerContext, MIB_IPINTERFACE_ROW* Row, MIB_NOTIFICATION_TYPE NotificationType);
alias PUNICAST_IPADDRESS_CHANGE_CALLBACK = extern(Windows) void function(void* CallerContext, MIB_UNICASTIPADDRESS_ROW* Row, MIB_NOTIFICATION_TYPE NotificationType);
alias PSTABLE_UNICAST_IPADDRESS_TABLE_CALLBACK = extern(Windows) void function(void* CallerContext, MIB_UNICASTIPADDRESS_TABLE* AddressTable);
struct IP_ADDRESS_PREFIX
{
    SOCKADDR_INET Prefix;
    ubyte PrefixLength;
}

alias PIPFORWARD_CHANGE_CALLBACK = extern(Windows) void function(void* CallerContext, MIB_IPFORWARD_ROW2* Row, MIB_NOTIFICATION_TYPE NotificationType);
alias PTEREDO_PORT_CHANGE_CALLBACK = extern(Windows) void function(void* CallerContext, ushort Port, MIB_NOTIFICATION_TYPE NotificationType);
struct DNS_SETTINGS
{
    uint Version;
    ulong Flags;
    const(wchar)* Hostname;
    const(wchar)* Domain;
    const(wchar)* SearchList;
}

struct DNS_INTERFACE_SETTINGS
{
    uint Version;
    ulong Flags;
    const(wchar)* Domain;
    const(wchar)* NameServer;
    const(wchar)* SearchList;
    uint RegistrationEnabled;
    uint RegisterAdapterName;
    uint EnableLLMNR;
    uint QueryAdapterName;
    const(wchar)* ProfileNameServer;
}

struct DNS_INTERFACE_SETTINGS_EX
{
    DNS_INTERFACE_SETTINGS SettingsV1;
    uint DisableUnconstrainedQueries;
    const(wchar)* SupplementalSearchList;
}

alias PNETWORK_CONNECTIVITY_HINT_CHANGE_CALLBACK = extern(Windows) void function(void* CallerContext, NL_NETWORK_CONNECTIVITY_HINT ConnectivityHint);
enum MIB_IPFORWARD_TYPE
{
    MIB_IPROUTE_TYPE_OTHER = 1,
    MIB_IPROUTE_TYPE_INVALID = 2,
    MIB_IPROUTE_TYPE_DIRECT = 3,
    MIB_IPROUTE_TYPE_INDIRECT = 4,
}

enum MIB_IPNET_TYPE
{
    MIB_IPNET_TYPE_OTHER = 1,
    MIB_IPNET_TYPE_INVALID = 2,
    MIB_IPNET_TYPE_DYNAMIC = 3,
    MIB_IPNET_TYPE_STATIC = 4,
}

enum MIB_IPSTATS_FORWARDING
{
    MIB_IP_FORWARDING = 1,
    MIB_IP_NOT_FORWARDING = 2,
}

enum MIB_TCP_STATE
{
    MIB_TCP_STATE_CLOSED = 1,
    MIB_TCP_STATE_LISTEN = 2,
    MIB_TCP_STATE_SYN_SENT = 3,
    MIB_TCP_STATE_SYN_RCVD = 4,
    MIB_TCP_STATE_ESTAB = 5,
    MIB_TCP_STATE_FIN_WAIT1 = 6,
    MIB_TCP_STATE_FIN_WAIT2 = 7,
    MIB_TCP_STATE_CLOSE_WAIT = 8,
    MIB_TCP_STATE_CLOSING = 9,
    MIB_TCP_STATE_LAST_ACK = 10,
    MIB_TCP_STATE_TIME_WAIT = 11,
    MIB_TCP_STATE_DELETE_TCB = 12,
    MIB_TCP_STATE_RESERVED = 100,
}

enum TCP_RTO_ALGORITHM
{
    TcpRtoAlgorithmOther = 1,
    TcpRtoAlgorithmConstant = 2,
    TcpRtoAlgorithmRsre = 3,
    TcpRtoAlgorithmVanj = 4,
    MIB_TCP_RTO_OTHER = 1,
    MIB_TCP_RTO_CONSTANT = 2,
    MIB_TCP_RTO_RSRE = 3,
    MIB_TCP_RTO_VANJ = 4,
}

enum TCP_TABLE_CLASS
{
    TCP_TABLE_BASIC_LISTENER = 0,
    TCP_TABLE_BASIC_CONNECTIONS = 1,
    TCP_TABLE_BASIC_ALL = 2,
    TCP_TABLE_OWNER_PID_LISTENER = 3,
    TCP_TABLE_OWNER_PID_CONNECTIONS = 4,
    TCP_TABLE_OWNER_PID_ALL = 5,
    TCP_TABLE_OWNER_MODULE_LISTENER = 6,
    TCP_TABLE_OWNER_MODULE_CONNECTIONS = 7,
    TCP_TABLE_OWNER_MODULE_ALL = 8,
}

enum UDP_TABLE_CLASS
{
    UDP_TABLE_BASIC = 0,
    UDP_TABLE_OWNER_PID = 1,
    UDP_TABLE_OWNER_MODULE = 2,
}

enum TCPIP_OWNER_MODULE_INFO_CLASS
{
    TCPIP_OWNER_MODULE_INFO_BASIC = 0,
}

struct TCPIP_OWNER_MODULE_BASIC_INFO
{
    const(wchar)* pModuleName;
    const(wchar)* pModulePath;
}

struct MIB_IPDESTROW
{
    MIB_IPFORWARDROW ForwardRow;
    uint dwForwardPreference;
    uint dwForwardViewSet;
}

struct MIB_IPDESTTABLE
{
    uint dwNumEntries;
    MIB_IPDESTROW table;
}

struct MIB_ROUTESTATE
{
    BOOL bRoutesSetToStack;
}

struct IP_ADDRESS_STRING
{
    byte String;
}

struct IP_ADDR_STRING
{
    IP_ADDR_STRING* Next;
    IP_ADDRESS_STRING IpAddress;
    IP_ADDRESS_STRING IpMask;
    uint Context;
}

struct IP_ADAPTER_INFO
{
    IP_ADAPTER_INFO* Next;
    uint ComboIndex;
    byte AdapterName;
    byte Description;
    uint AddressLength;
    ubyte Address;
    uint Index;
    uint Type;
    uint DhcpEnabled;
    IP_ADDR_STRING* CurrentIpAddress;
    IP_ADDR_STRING IpAddressList;
    IP_ADDR_STRING GatewayList;
    IP_ADDR_STRING DhcpServer;
    BOOL HaveWins;
    IP_ADDR_STRING PrimaryWinsServer;
    IP_ADDR_STRING SecondaryWinsServer;
    long LeaseObtained;
    long LeaseExpires;
}

struct IP_ADAPTER_UNICAST_ADDRESS_LH
{
    _Anonymous_e__Union Anonymous;
    IP_ADAPTER_UNICAST_ADDRESS_LH* Next;
    SOCKET_ADDRESS Address;
    NL_PREFIX_ORIGIN PrefixOrigin;
    NL_SUFFIX_ORIGIN SuffixOrigin;
    NL_DAD_STATE DadState;
    uint ValidLifetime;
    uint PreferredLifetime;
    uint LeaseLifetime;
    ubyte OnLinkPrefixLength;
}

struct IP_ADAPTER_UNICAST_ADDRESS_XP
{
    _Anonymous_e__Union Anonymous;
    IP_ADAPTER_UNICAST_ADDRESS_XP* Next;
    SOCKET_ADDRESS Address;
    NL_PREFIX_ORIGIN PrefixOrigin;
    NL_SUFFIX_ORIGIN SuffixOrigin;
    NL_DAD_STATE DadState;
    uint ValidLifetime;
    uint PreferredLifetime;
    uint LeaseLifetime;
}

struct IP_ADAPTER_ANYCAST_ADDRESS_XP
{
    _Anonymous_e__Union Anonymous;
    IP_ADAPTER_ANYCAST_ADDRESS_XP* Next;
    SOCKET_ADDRESS Address;
}

struct IP_ADAPTER_MULTICAST_ADDRESS_XP
{
    _Anonymous_e__Union Anonymous;
    IP_ADAPTER_MULTICAST_ADDRESS_XP* Next;
    SOCKET_ADDRESS Address;
}

struct IP_ADAPTER_DNS_SERVER_ADDRESS_XP
{
    _Anonymous_e__Union Anonymous;
    IP_ADAPTER_DNS_SERVER_ADDRESS_XP* Next;
    SOCKET_ADDRESS Address;
}

struct IP_ADAPTER_WINS_SERVER_ADDRESS_LH
{
    _Anonymous_e__Union Anonymous;
    IP_ADAPTER_WINS_SERVER_ADDRESS_LH* Next;
    SOCKET_ADDRESS Address;
}

struct IP_ADAPTER_GATEWAY_ADDRESS_LH
{
    _Anonymous_e__Union Anonymous;
    IP_ADAPTER_GATEWAY_ADDRESS_LH* Next;
    SOCKET_ADDRESS Address;
}

struct IP_ADAPTER_PREFIX_XP
{
    _Anonymous_e__Union Anonymous;
    IP_ADAPTER_PREFIX_XP* Next;
    SOCKET_ADDRESS Address;
    uint PrefixLength;
}

struct IP_ADAPTER_DNS_SUFFIX
{
    IP_ADAPTER_DNS_SUFFIX* Next;
    ushort String;
}

struct IP_ADAPTER_ADDRESSES_LH
{
    _Anonymous1_e__Union Anonymous1;
    IP_ADAPTER_ADDRESSES_LH* Next;
    const(char)* AdapterName;
    IP_ADAPTER_UNICAST_ADDRESS_LH* FirstUnicastAddress;
    IP_ADAPTER_ANYCAST_ADDRESS_XP* FirstAnycastAddress;
    IP_ADAPTER_MULTICAST_ADDRESS_XP* FirstMulticastAddress;
    IP_ADAPTER_DNS_SERVER_ADDRESS_XP* FirstDnsServerAddress;
    const(wchar)* DnsSuffix;
    const(wchar)* Description;
    const(wchar)* FriendlyName;
    ubyte PhysicalAddress;
    uint PhysicalAddressLength;
    _Anonymous2_e__Union Anonymous2;
    uint Mtu;
    uint IfType;
    IF_OPER_STATUS OperStatus;
    uint Ipv6IfIndex;
    uint ZoneIndices;
    IP_ADAPTER_PREFIX_XP* FirstPrefix;
    ulong TransmitLinkSpeed;
    ulong ReceiveLinkSpeed;
    IP_ADAPTER_WINS_SERVER_ADDRESS_LH* FirstWinsServerAddress;
    IP_ADAPTER_GATEWAY_ADDRESS_LH* FirstGatewayAddress;
    uint Ipv4Metric;
    uint Ipv6Metric;
    NET_LUID_LH Luid;
    SOCKET_ADDRESS Dhcpv4Server;
    uint CompartmentId;
    Guid NetworkGuid;
    NET_IF_CONNECTION_TYPE ConnectionType;
    TUNNEL_TYPE TunnelType;
    SOCKET_ADDRESS Dhcpv6Server;
    ubyte Dhcpv6ClientDuid;
    uint Dhcpv6ClientDuidLength;
    uint Dhcpv6Iaid;
    IP_ADAPTER_DNS_SUFFIX* FirstDnsSuffix;
}

struct IP_ADAPTER_ADDRESSES_XP
{
    _Anonymous_e__Union Anonymous;
    IP_ADAPTER_ADDRESSES_XP* Next;
    const(char)* AdapterName;
    IP_ADAPTER_UNICAST_ADDRESS_XP* FirstUnicastAddress;
    IP_ADAPTER_ANYCAST_ADDRESS_XP* FirstAnycastAddress;
    IP_ADAPTER_MULTICAST_ADDRESS_XP* FirstMulticastAddress;
    IP_ADAPTER_DNS_SERVER_ADDRESS_XP* FirstDnsServerAddress;
    const(wchar)* DnsSuffix;
    const(wchar)* Description;
    const(wchar)* FriendlyName;
    ubyte PhysicalAddress;
    uint PhysicalAddressLength;
    uint Flags;
    uint Mtu;
    uint IfType;
    IF_OPER_STATUS OperStatus;
    uint Ipv6IfIndex;
    uint ZoneIndices;
    IP_ADAPTER_PREFIX_XP* FirstPrefix;
}

struct IP_PER_ADAPTER_INFO_W2KSP1
{
    uint AutoconfigEnabled;
    uint AutoconfigActive;
    IP_ADDR_STRING* CurrentDnsServer;
    IP_ADDR_STRING DnsServerList;
}

struct FIXED_INFO_W2KSP1
{
    byte HostName;
    byte DomainName;
    IP_ADDR_STRING* CurrentDnsServer;
    IP_ADDR_STRING DnsServerList;
    uint NodeType;
    byte ScopeId;
    uint EnableRouting;
    uint EnableProxy;
    uint EnableDns;
}

struct ip_interface_name_info_w2ksp1
{
    uint Index;
    uint MediaType;
    ubyte ConnectionType;
    ubyte AccessType;
    Guid DeviceGuid;
    Guid InterfaceGuid;
}

enum TCP_ESTATS_TYPE
{
    TcpConnectionEstatsSynOpts = 0,
    TcpConnectionEstatsData = 1,
    TcpConnectionEstatsSndCong = 2,
    TcpConnectionEstatsPath = 3,
    TcpConnectionEstatsSendBuff = 4,
    TcpConnectionEstatsRec = 5,
    TcpConnectionEstatsObsRec = 6,
    TcpConnectionEstatsBandwidth = 7,
    TcpConnectionEstatsFineRtt = 8,
    TcpConnectionEstatsMaximum = 9,
}

enum TCP_BOOLEAN_OPTIONAL
{
    TcpBoolOptDisabled = 0,
    TcpBoolOptEnabled = 1,
    TcpBoolOptUnchanged = -1,
}

struct TCP_ESTATS_SYN_OPTS_ROS_v0
{
    ubyte ActiveOpen;
    uint MssRcvd;
    uint MssSent;
}

enum TCP_SOFT_ERROR
{
    TcpErrorNone = 0,
    TcpErrorBelowDataWindow = 1,
    TcpErrorAboveDataWindow = 2,
    TcpErrorBelowAckWindow = 3,
    TcpErrorAboveAckWindow = 4,
    TcpErrorBelowTsWindow = 5,
    TcpErrorAboveTsWindow = 6,
    TcpErrorDataChecksumError = 7,
    TcpErrorDataLengthError = 8,
    TcpErrorMaxSoftError = 9,
}

struct TCP_ESTATS_DATA_ROD_v0
{
    ulong DataBytesOut;
    ulong DataSegsOut;
    ulong DataBytesIn;
    ulong DataSegsIn;
    ulong SegsOut;
    ulong SegsIn;
    uint SoftErrors;
    uint SoftErrorReason;
    uint SndUna;
    uint SndNxt;
    uint SndMax;
    ulong ThruBytesAcked;
    uint RcvNxt;
    ulong ThruBytesReceived;
}

struct TCP_ESTATS_DATA_RW_v0
{
    ubyte EnableCollection;
}

struct TCP_ESTATS_SND_CONG_ROD_v0
{
    uint SndLimTransRwin;
    uint SndLimTimeRwin;
    uint SndLimBytesRwin;
    uint SndLimTransCwnd;
    uint SndLimTimeCwnd;
    uint SndLimBytesCwnd;
    uint SndLimTransSnd;
    uint SndLimTimeSnd;
    uint SndLimBytesSnd;
    uint SlowStart;
    uint CongAvoid;
    uint OtherReductions;
    uint CurCwnd;
    uint MaxSsCwnd;
    uint MaxCaCwnd;
    uint CurSsthresh;
    uint MaxSsthresh;
    uint MinSsthresh;
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
    uint CurRetxQueue;
    uint MaxRetxQueue;
    uint CurAppWQueue;
    uint MaxAppWQueue;
}

struct TCP_ESTATS_SEND_BUFF_RW_v0
{
    ubyte EnableCollection;
}

struct TCP_ESTATS_REC_ROD_v0
{
    uint CurRwinSent;
    uint MaxRwinSent;
    uint MinRwinSent;
    uint LimRwin;
    uint DupAckEpisodes;
    uint DupAcksOut;
    uint CeRcvd;
    uint EcnSent;
    uint EcnNoncesRcvd;
    uint CurReasmQueue;
    uint MaxReasmQueue;
    uint CurAppRQueue;
    uint MaxAppRQueue;
    ubyte WinScaleSent;
}

struct TCP_ESTATS_REC_RW_v0
{
    ubyte EnableCollection;
}

struct TCP_ESTATS_OBS_REC_ROD_v0
{
    uint CurRwinRcvd;
    uint MaxRwinRcvd;
    uint MinRwinRcvd;
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
    uint Version;
    ulong HardwareClockFrequencyHz;
    ubyte CrossTimestamp;
    ulong Reserved1;
    ulong Reserved2;
    INTERFACE_TIMESTAMP_CAPABILITY_FLAGS TimestampFlags;
}

struct INTERFACE_HARDWARE_CROSSTIMESTAMP
{
    uint Version;
    uint Flags;
    ulong SystemTimestamp1;
    ulong HardwareClockTimestamp;
    ulong SystemTimestamp2;
}

struct HIFTIMESTAMPCHANGE__
{
    int unused;
}

alias INTERFACE_TIMESTAMP_CONFIG_CHANGE_CALLBACK = extern(Windows) void function(void* CallerContext);
alias PINTERFACE_TIMESTAMP_CONFIG_CHANGE_CALLBACK = extern(Windows) void function();
enum NET_ADDRESS_FORMAT
{
    NET_ADDRESS_FORMAT_UNSPECIFIED = 0,
    NET_ADDRESS_DNS_NAME = 1,
    NET_ADDRESS_IPV4 = 2,
    NET_ADDRESS_IPV6 = 3,
}

@DllImport("IPHLPAPI.dll")
NTSTATUS GetIfEntry2(MIB_IF_ROW2* Row);

@DllImport("IPHLPAPI.dll")
NTSTATUS GetIfEntry2Ex(MIB_IF_ENTRY_LEVEL Level, MIB_IF_ROW2* Row);

@DllImport("IPHLPAPI.dll")
NTSTATUS GetIfTable2(MIB_IF_TABLE2** Table);

@DllImport("IPHLPAPI.dll")
NTSTATUS GetIfTable2Ex(MIB_IF_TABLE_LEVEL Level, MIB_IF_TABLE2** Table);

@DllImport("IPHLPAPI.dll")
NTSTATUS GetIfStackTable(MIB_IFSTACK_TABLE** Table);

@DllImport("IPHLPAPI.dll")
NTSTATUS GetInvertedIfStackTable(MIB_INVERTEDIFSTACK_TABLE** Table);

@DllImport("IPHLPAPI.dll")
NTSTATUS GetIpInterfaceEntry(MIB_IPINTERFACE_ROW* Row);

@DllImport("IPHLPAPI.dll")
NTSTATUS GetIpInterfaceTable(ushort Family, MIB_IPINTERFACE_TABLE** Table);

@DllImport("IPHLPAPI.dll")
void InitializeIpInterfaceEntry(MIB_IPINTERFACE_ROW* Row);

@DllImport("IPHLPAPI.dll")
NTSTATUS NotifyIpInterfaceChange(ushort Family, PIPINTERFACE_CHANGE_CALLBACK Callback, void* CallerContext, ubyte InitialNotification, HANDLE* NotificationHandle);

@DllImport("IPHLPAPI.dll")
NTSTATUS SetIpInterfaceEntry(MIB_IPINTERFACE_ROW* Row);

@DllImport("IPHLPAPI.dll")
NTSTATUS GetIpNetworkConnectionBandwidthEstimates(uint InterfaceIndex, ushort AddressFamily, MIB_IP_NETWORK_CONNECTION_BANDWIDTH_ESTIMATES* BandwidthEstimates);

@DllImport("IPHLPAPI.dll")
NTSTATUS CreateUnicastIpAddressEntry(const(MIB_UNICASTIPADDRESS_ROW)* Row);

@DllImport("IPHLPAPI.dll")
NTSTATUS DeleteUnicastIpAddressEntry(const(MIB_UNICASTIPADDRESS_ROW)* Row);

@DllImport("IPHLPAPI.dll")
NTSTATUS GetUnicastIpAddressEntry(MIB_UNICASTIPADDRESS_ROW* Row);

@DllImport("IPHLPAPI.dll")
NTSTATUS GetUnicastIpAddressTable(ushort Family, MIB_UNICASTIPADDRESS_TABLE** Table);

@DllImport("IPHLPAPI.dll")
void InitializeUnicastIpAddressEntry(MIB_UNICASTIPADDRESS_ROW* Row);

@DllImport("IPHLPAPI.dll")
NTSTATUS NotifyUnicastIpAddressChange(ushort Family, PUNICAST_IPADDRESS_CHANGE_CALLBACK Callback, void* CallerContext, ubyte InitialNotification, HANDLE* NotificationHandle);

@DllImport("IPHLPAPI.dll")
NTSTATUS NotifyStableUnicastIpAddressTable(ushort Family, MIB_UNICASTIPADDRESS_TABLE** Table, PSTABLE_UNICAST_IPADDRESS_TABLE_CALLBACK CallerCallback, void* CallerContext, HANDLE* NotificationHandle);

@DllImport("IPHLPAPI.dll")
NTSTATUS SetUnicastIpAddressEntry(const(MIB_UNICASTIPADDRESS_ROW)* Row);

@DllImport("IPHLPAPI.dll")
NTSTATUS CreateAnycastIpAddressEntry(const(MIB_ANYCASTIPADDRESS_ROW)* Row);

@DllImport("IPHLPAPI.dll")
NTSTATUS DeleteAnycastIpAddressEntry(const(MIB_ANYCASTIPADDRESS_ROW)* Row);

@DllImport("IPHLPAPI.dll")
NTSTATUS GetAnycastIpAddressEntry(MIB_ANYCASTIPADDRESS_ROW* Row);

@DllImport("IPHLPAPI.dll")
NTSTATUS GetAnycastIpAddressTable(ushort Family, MIB_ANYCASTIPADDRESS_TABLE** Table);

@DllImport("IPHLPAPI.dll")
NTSTATUS GetMulticastIpAddressEntry(MIB_MULTICASTIPADDRESS_ROW* Row);

@DllImport("IPHLPAPI.dll")
NTSTATUS GetMulticastIpAddressTable(ushort Family, MIB_MULTICASTIPADDRESS_TABLE** Table);

@DllImport("IPHLPAPI.dll")
NTSTATUS CreateIpForwardEntry2(const(MIB_IPFORWARD_ROW2)* Row);

@DllImport("IPHLPAPI.dll")
NTSTATUS DeleteIpForwardEntry2(const(MIB_IPFORWARD_ROW2)* Row);

@DllImport("IPHLPAPI.dll")
NTSTATUS GetBestRoute2(NET_LUID_LH* InterfaceLuid, uint InterfaceIndex, const(SOCKADDR_INET)* SourceAddress, const(SOCKADDR_INET)* DestinationAddress, uint AddressSortOptions, MIB_IPFORWARD_ROW2* BestRoute, SOCKADDR_INET* BestSourceAddress);

@DllImport("IPHLPAPI.dll")
NTSTATUS GetIpForwardEntry2(MIB_IPFORWARD_ROW2* Row);

@DllImport("IPHLPAPI.dll")
NTSTATUS GetIpForwardTable2(ushort Family, MIB_IPFORWARD_TABLE2** Table);

@DllImport("IPHLPAPI.dll")
void InitializeIpForwardEntry(MIB_IPFORWARD_ROW2* Row);

@DllImport("IPHLPAPI.dll")
NTSTATUS NotifyRouteChange2(ushort AddressFamily, PIPFORWARD_CHANGE_CALLBACK Callback, void* CallerContext, ubyte InitialNotification, HANDLE* NotificationHandle);

@DllImport("IPHLPAPI.dll")
NTSTATUS SetIpForwardEntry2(const(MIB_IPFORWARD_ROW2)* Route);

@DllImport("IPHLPAPI.dll")
NTSTATUS FlushIpPathTable(ushort Family);

@DllImport("IPHLPAPI.dll")
NTSTATUS GetIpPathEntry(MIB_IPPATH_ROW* Row);

@DllImport("IPHLPAPI.dll")
NTSTATUS GetIpPathTable(ushort Family, MIB_IPPATH_TABLE** Table);

@DllImport("IPHLPAPI.dll")
NTSTATUS CreateIpNetEntry2(const(MIB_IPNET_ROW2)* Row);

@DllImport("IPHLPAPI.dll")
NTSTATUS DeleteIpNetEntry2(const(MIB_IPNET_ROW2)* Row);

@DllImport("IPHLPAPI.dll")
NTSTATUS FlushIpNetTable2(ushort Family, uint InterfaceIndex);

@DllImport("IPHLPAPI.dll")
NTSTATUS GetIpNetEntry2(MIB_IPNET_ROW2* Row);

@DllImport("IPHLPAPI.dll")
NTSTATUS GetIpNetTable2(ushort Family, MIB_IPNET_TABLE2** Table);

@DllImport("IPHLPAPI.dll")
NTSTATUS ResolveIpNetEntry2(MIB_IPNET_ROW2* Row, const(SOCKADDR_INET)* SourceAddress);

@DllImport("IPHLPAPI.dll")
NTSTATUS SetIpNetEntry2(MIB_IPNET_ROW2* Row);

@DllImport("IPHLPAPI.dll")
NTSTATUS NotifyTeredoPortChange(PTEREDO_PORT_CHANGE_CALLBACK Callback, void* CallerContext, ubyte InitialNotification, HANDLE* NotificationHandle);

@DllImport("IPHLPAPI.dll")
NTSTATUS GetTeredoPort(ushort* Port);

@DllImport("IPHLPAPI.dll")
NTSTATUS CancelMibChangeNotify2(HANDLE NotificationHandle);

@DllImport("IPHLPAPI.dll")
void FreeMibTable(void* Memory);

@DllImport("IPHLPAPI.dll")
NTSTATUS CreateSortedAddressPairs(const(SOCKADDR_IN6_LH)* SourceAddressList, uint SourceAddressCount, const(SOCKADDR_IN6_LH)* DestinationAddressList, uint DestinationAddressCount, uint AddressSortOptions, SOCKADDR_IN6_PAIR** SortedAddressPairList, uint* SortedAddressPairCount);

@DllImport("IPHLPAPI.dll")
NTSTATUS ConvertCompartmentGuidToId(const(Guid)* CompartmentGuid, uint* CompartmentId);

@DllImport("IPHLPAPI.dll")
NTSTATUS ConvertCompartmentIdToGuid(uint CompartmentId, Guid* CompartmentGuid);

@DllImport("IPHLPAPI.dll")
NTSTATUS ConvertInterfaceNameToLuidA(const(byte)* InterfaceName, NET_LUID_LH* InterfaceLuid);

@DllImport("IPHLPAPI.dll")
NTSTATUS ConvertInterfaceNameToLuidW(const(wchar)* InterfaceName, NET_LUID_LH* InterfaceLuid);

@DllImport("IPHLPAPI.dll")
NTSTATUS ConvertInterfaceLuidToNameA(const(NET_LUID_LH)* InterfaceLuid, const(char)* InterfaceName, uint Length);

@DllImport("IPHLPAPI.dll")
NTSTATUS ConvertInterfaceLuidToNameW(const(NET_LUID_LH)* InterfaceLuid, const(wchar)* InterfaceName, uint Length);

@DllImport("IPHLPAPI.dll")
NTSTATUS ConvertInterfaceLuidToIndex(const(NET_LUID_LH)* InterfaceLuid, uint* InterfaceIndex);

@DllImport("IPHLPAPI.dll")
NTSTATUS ConvertInterfaceIndexToLuid(uint InterfaceIndex, NET_LUID_LH* InterfaceLuid);

@DllImport("IPHLPAPI.dll")
NTSTATUS ConvertInterfaceLuidToAlias(const(NET_LUID_LH)* InterfaceLuid, const(wchar)* InterfaceAlias, uint Length);

@DllImport("IPHLPAPI.dll")
NTSTATUS ConvertInterfaceAliasToLuid(const(wchar)* InterfaceAlias, NET_LUID_LH* InterfaceLuid);

@DllImport("IPHLPAPI.dll")
NTSTATUS ConvertInterfaceLuidToGuid(const(NET_LUID_LH)* InterfaceLuid, Guid* InterfaceGuid);

@DllImport("IPHLPAPI.dll")
NTSTATUS ConvertInterfaceGuidToLuid(const(Guid)* InterfaceGuid, NET_LUID_LH* InterfaceLuid);

@DllImport("IPHLPAPI.dll")
uint if_nametoindex(const(char)* InterfaceName);

@DllImport("IPHLPAPI.dll")
byte* if_indextoname(uint InterfaceIndex, const(char)* InterfaceName);

@DllImport("IPHLPAPI.dll")
void GetCurrentThreadCompartmentScope(uint* CompartmentScope, uint* CompartmentId);

@DllImport("IPHLPAPI.dll")
NTSTATUS SetCurrentThreadCompartmentScope(uint CompartmentScope);

@DllImport("IPHLPAPI.dll")
uint GetJobCompartmentId(HANDLE JobHandle);

@DllImport("IPHLPAPI.dll")
NTSTATUS SetJobCompartmentId(HANDLE JobHandle, uint CompartmentId);

@DllImport("IPHLPAPI.dll")
uint GetDefaultCompartmentId();

@DllImport("IPHLPAPI.dll")
NTSTATUS ConvertLengthToIpv4Mask(uint MaskLength, uint* Mask);

@DllImport("IPHLPAPI.dll")
NTSTATUS ConvertIpv4MaskToLength(uint Mask, ubyte* MaskLength);

@DllImport("IPHLPAPI.dll")
NTSTATUS GetDnsSettings(DNS_SETTINGS* Settings);

@DllImport("IPHLPAPI.dll")
void FreeDnsSettings(DNS_SETTINGS* Settings);

@DllImport("IPHLPAPI.dll")
NTSTATUS SetDnsSettings(const(DNS_SETTINGS)* Settings);

@DllImport("IPHLPAPI.dll")
NTSTATUS GetInterfaceDnsSettings(Guid Interface, DNS_INTERFACE_SETTINGS* Settings);

@DllImport("IPHLPAPI.dll")
void FreeInterfaceDnsSettings(DNS_INTERFACE_SETTINGS* Settings);

@DllImport("IPHLPAPI.dll")
NTSTATUS SetInterfaceDnsSettings(Guid Interface, const(DNS_INTERFACE_SETTINGS)* Settings);

@DllImport("IPHLPAPI.dll")
NTSTATUS GetNetworkConnectivityHint(NL_NETWORK_CONNECTIVITY_HINT* ConnectivityHint);

@DllImport("IPHLPAPI.dll")
NTSTATUS GetNetworkConnectivityHintForInterface(uint InterfaceIndex, NL_NETWORK_CONNECTIVITY_HINT* ConnectivityHint);

@DllImport("IPHLPAPI.dll")
NTSTATUS NotifyNetworkConnectivityHintChange(PNETWORK_CONNECTIVITY_HINT_CHANGE_CALLBACK Callback, void* CallerContext, ubyte InitialNotification, int* NotificationHandle);

@DllImport("IPHLPAPI.dll")
IcmpHandle IcmpCreateFile();

@DllImport("IPHLPAPI.dll")
IcmpHandle Icmp6CreateFile();

@DllImport("IPHLPAPI.dll")
BOOL IcmpCloseHandle(HANDLE IcmpHandle);

@DllImport("IPHLPAPI.dll")
uint IcmpSendEcho(HANDLE IcmpHandle, uint DestinationAddress, char* RequestData, ushort RequestSize, ip_option_information* RequestOptions, char* ReplyBuffer, uint ReplySize, uint Timeout);

@DllImport("IPHLPAPI.dll")
uint IcmpSendEcho2(HANDLE IcmpHandle, HANDLE Event, FARPROC ApcRoutine, void* ApcContext, uint DestinationAddress, char* RequestData, ushort RequestSize, ip_option_information* RequestOptions, char* ReplyBuffer, uint ReplySize, uint Timeout);

@DllImport("IPHLPAPI.dll")
uint IcmpSendEcho2Ex(HANDLE IcmpHandle, HANDLE Event, FARPROC ApcRoutine, void* ApcContext, uint SourceAddress, uint DestinationAddress, char* RequestData, ushort RequestSize, ip_option_information* RequestOptions, char* ReplyBuffer, uint ReplySize, uint Timeout);

@DllImport("IPHLPAPI.dll")
uint Icmp6SendEcho2(HANDLE IcmpHandle, HANDLE Event, FARPROC ApcRoutine, void* ApcContext, SOCKADDR_IN6_LH* SourceAddress, SOCKADDR_IN6_LH* DestinationAddress, char* RequestData, ushort RequestSize, ip_option_information* RequestOptions, char* ReplyBuffer, uint ReplySize, uint Timeout);

@DllImport("IPHLPAPI.dll")
uint IcmpParseReplies(char* ReplyBuffer, uint ReplySize);

@DllImport("IPHLPAPI.dll")
uint Icmp6ParseReplies(char* ReplyBuffer, uint ReplySize);

@DllImport("IPHLPAPI.dll")
uint GetNumberOfInterfaces(uint* pdwNumIf);

@DllImport("IPHLPAPI.dll")
uint GetIfEntry(MIB_IFROW* pIfRow);

@DllImport("IPHLPAPI.dll")
uint GetIfTable(char* pIfTable, uint* pdwSize, BOOL bOrder);

@DllImport("IPHLPAPI.dll")
uint GetIpAddrTable(char* pIpAddrTable, uint* pdwSize, BOOL bOrder);

@DllImport("IPHLPAPI.dll")
uint GetIpNetTable(char* IpNetTable, uint* SizePointer, BOOL Order);

@DllImport("IPHLPAPI.dll")
uint GetIpForwardTable(char* pIpForwardTable, uint* pdwSize, BOOL bOrder);

@DllImport("IPHLPAPI.dll")
uint GetTcpTable(char* TcpTable, uint* SizePointer, BOOL Order);

@DllImport("IPHLPAPI.dll")
uint GetExtendedTcpTable(char* pTcpTable, uint* pdwSize, BOOL bOrder, uint ulAf, TCP_TABLE_CLASS TableClass, uint Reserved);

@DllImport("IPHLPAPI.dll")
uint GetOwnerModuleFromTcpEntry(MIB_TCPROW_OWNER_MODULE* pTcpEntry, TCPIP_OWNER_MODULE_INFO_CLASS Class, char* pBuffer, uint* pdwSize);

@DllImport("IPHLPAPI.dll")
uint GetUdpTable(char* UdpTable, uint* SizePointer, BOOL Order);

@DllImport("IPHLPAPI.dll")
uint GetExtendedUdpTable(char* pUdpTable, uint* pdwSize, BOOL bOrder, uint ulAf, UDP_TABLE_CLASS TableClass, uint Reserved);

@DllImport("IPHLPAPI.dll")
uint GetOwnerModuleFromUdpEntry(MIB_UDPROW_OWNER_MODULE* pUdpEntry, TCPIP_OWNER_MODULE_INFO_CLASS Class, char* pBuffer, uint* pdwSize);

@DllImport("IPHLPAPI.dll")
uint GetTcpTable2(char* TcpTable, uint* SizePointer, BOOL Order);

@DllImport("IPHLPAPI.dll")
uint GetTcp6Table(char* TcpTable, uint* SizePointer, BOOL Order);

@DllImport("IPHLPAPI.dll")
uint GetTcp6Table2(char* TcpTable, uint* SizePointer, BOOL Order);

@DllImport("IPHLPAPI.dll")
uint GetPerTcpConnectionEStats(MIB_TCPROW_LH* Row, TCP_ESTATS_TYPE EstatsType, char* Rw, uint RwVersion, uint RwSize, char* Ros, uint RosVersion, uint RosSize, char* Rod, uint RodVersion, uint RodSize);

@DllImport("IPHLPAPI.dll")
uint SetPerTcpConnectionEStats(MIB_TCPROW_LH* Row, TCP_ESTATS_TYPE EstatsType, char* Rw, uint RwVersion, uint RwSize, uint Offset);

@DllImport("IPHLPAPI.dll")
uint GetPerTcp6ConnectionEStats(MIB_TCP6ROW* Row, TCP_ESTATS_TYPE EstatsType, char* Rw, uint RwVersion, uint RwSize, char* Ros, uint RosVersion, uint RosSize, char* Rod, uint RodVersion, uint RodSize);

@DllImport("IPHLPAPI.dll")
uint SetPerTcp6ConnectionEStats(MIB_TCP6ROW* Row, TCP_ESTATS_TYPE EstatsType, char* Rw, uint RwVersion, uint RwSize, uint Offset);

@DllImport("IPHLPAPI.dll")
uint GetOwnerModuleFromTcp6Entry(MIB_TCP6ROW_OWNER_MODULE* pTcpEntry, TCPIP_OWNER_MODULE_INFO_CLASS Class, char* pBuffer, uint* pdwSize);

@DllImport("IPHLPAPI.dll")
uint GetUdp6Table(char* Udp6Table, uint* SizePointer, BOOL Order);

@DllImport("IPHLPAPI.dll")
uint GetOwnerModuleFromUdp6Entry(MIB_UDP6ROW_OWNER_MODULE* pUdpEntry, TCPIP_OWNER_MODULE_INFO_CLASS Class, char* pBuffer, uint* pdwSize);

@DllImport("IPHLPAPI.dll")
uint GetOwnerModuleFromPidAndInfo(uint ulPid, ulong* pInfo, TCPIP_OWNER_MODULE_INFO_CLASS Class, char* pBuffer, uint* pdwSize);

@DllImport("IPHLPAPI.dll")
uint GetIpStatistics(MIB_IPSTATS_LH* Statistics);

@DllImport("IPHLPAPI.dll")
uint GetIcmpStatistics(MIB_ICMP* Statistics);

@DllImport("IPHLPAPI.dll")
uint GetTcpStatistics(MIB_TCPSTATS_LH* Statistics);

@DllImport("IPHLPAPI.dll")
uint GetUdpStatistics(MIB_UDPSTATS* Stats);

@DllImport("IPHLPAPI.dll")
uint SetIpStatisticsEx(MIB_IPSTATS_LH* Statistics, uint Family);

@DllImport("IPHLPAPI.dll")
uint GetIpStatisticsEx(MIB_IPSTATS_LH* Statistics, uint Family);

@DllImport("IPHLPAPI.dll")
uint GetIcmpStatisticsEx(MIB_ICMP_EX_XPSP1* Statistics, uint Family);

@DllImport("IPHLPAPI.dll")
uint GetTcpStatisticsEx(MIB_TCPSTATS_LH* Statistics, uint Family);

@DllImport("IPHLPAPI.dll")
uint GetUdpStatisticsEx(MIB_UDPSTATS* Statistics, uint Family);

@DllImport("IPHLPAPI.dll")
uint GetTcpStatisticsEx2(MIB_TCPSTATS2* Statistics, uint Family);

@DllImport("IPHLPAPI.dll")
uint GetUdpStatisticsEx2(MIB_UDPSTATS2* Statistics, uint Family);

@DllImport("IPHLPAPI.dll")
uint SetIfEntry(MIB_IFROW* pIfRow);

@DllImport("IPHLPAPI.dll")
uint CreateIpForwardEntry(MIB_IPFORWARDROW* pRoute);

@DllImport("IPHLPAPI.dll")
uint SetIpForwardEntry(MIB_IPFORWARDROW* pRoute);

@DllImport("IPHLPAPI.dll")
uint DeleteIpForwardEntry(MIB_IPFORWARDROW* pRoute);

@DllImport("IPHLPAPI.dll")
uint SetIpStatistics(MIB_IPSTATS_LH* pIpStats);

@DllImport("IPHLPAPI.dll")
uint SetIpTTL(uint nTTL);

@DllImport("IPHLPAPI.dll")
uint CreateIpNetEntry(MIB_IPNETROW_LH* pArpEntry);

@DllImport("IPHLPAPI.dll")
uint SetIpNetEntry(MIB_IPNETROW_LH* pArpEntry);

@DllImport("IPHLPAPI.dll")
uint DeleteIpNetEntry(MIB_IPNETROW_LH* pArpEntry);

@DllImport("IPHLPAPI.dll")
uint FlushIpNetTable(uint dwIfIndex);

@DllImport("IPHLPAPI.dll")
uint CreateProxyArpEntry(uint dwAddress, uint dwMask, uint dwIfIndex);

@DllImport("IPHLPAPI.dll")
uint DeleteProxyArpEntry(uint dwAddress, uint dwMask, uint dwIfIndex);

@DllImport("IPHLPAPI.dll")
uint SetTcpEntry(MIB_TCPROW_LH* pTcpRow);

@DllImport("IPHLPAPI.dll")
uint GetInterfaceInfo(char* pIfTable, uint* dwOutBufLen);

@DllImport("IPHLPAPI.dll")
uint GetUniDirectionalAdapterInfo(char* pIPIfInfo, uint* dwOutBufLen);

@DllImport("IPHLPAPI.dll")
uint NhpAllocateAndGetInterfaceInfoFromStack(ip_interface_name_info_w2ksp1** ppTable, uint* pdwCount, BOOL bOrder, HANDLE hHeap, uint dwFlags);

@DllImport("IPHLPAPI.dll")
uint GetBestInterface(uint dwDestAddr, uint* pdwBestIfIndex);

@DllImport("IPHLPAPI.dll")
uint GetBestInterfaceEx(SOCKADDR* pDestAddr, uint* pdwBestIfIndex);

@DllImport("IPHLPAPI.dll")
uint GetBestRoute(uint dwDestAddr, uint dwSourceAddr, MIB_IPFORWARDROW* pBestRoute);

@DllImport("IPHLPAPI.dll")
uint NotifyAddrChange(int* Handle, OVERLAPPED* overlapped);

@DllImport("IPHLPAPI.dll")
uint NotifyRouteChange(int* Handle, OVERLAPPED* overlapped);

@DllImport("IPHLPAPI.dll")
BOOL CancelIPChangeNotify(OVERLAPPED* notifyOverlapped);

@DllImport("IPHLPAPI.dll")
uint GetAdapterIndex(const(wchar)* AdapterName, uint* IfIndex);

@DllImport("IPHLPAPI.dll")
uint AddIPAddress(uint Address, uint IpMask, uint IfIndex, uint* NTEContext, uint* NTEInstance);

@DllImport("IPHLPAPI.dll")
uint DeleteIPAddress(uint NTEContext);

@DllImport("IPHLPAPI.dll")
uint GetNetworkParams(char* pFixedInfo, uint* pOutBufLen);

@DllImport("IPHLPAPI.dll")
uint GetAdaptersInfo(char* AdapterInfo, uint* SizePointer);

@DllImport("IPHLPAPI.dll")
IP_ADAPTER_ORDER_MAP* GetAdapterOrderMap();

@DllImport("IPHLPAPI.dll")
uint GetAdaptersAddresses(uint Family, uint Flags, void* Reserved, char* AdapterAddresses, uint* SizePointer);

@DllImport("IPHLPAPI.dll")
uint GetPerAdapterInfo(uint IfIndex, char* pPerAdapterInfo, uint* pOutBufLen);

@DllImport("IPHLPAPI.dll")
uint GetInterfaceCurrentTimestampCapabilities(const(NET_LUID_LH)* InterfaceLuid, INTERFACE_TIMESTAMP_CAPABILITIES* TimestampCapabilites);

@DllImport("IPHLPAPI.dll")
uint GetInterfaceHardwareTimestampCapabilities(const(NET_LUID_LH)* InterfaceLuid, INTERFACE_TIMESTAMP_CAPABILITIES* TimestampCapabilites);

@DllImport("IPHLPAPI.dll")
uint CaptureInterfaceHardwareCrossTimestamp(const(NET_LUID_LH)* InterfaceLuid, INTERFACE_HARDWARE_CROSSTIMESTAMP* CrossTimestamp);

@DllImport("IPHLPAPI.dll")
uint NotifyIfTimestampConfigChange(void* CallerContext, PINTERFACE_TIMESTAMP_CONFIG_CHANGE_CALLBACK Callback, HIFTIMESTAMPCHANGE__** NotificationHandle);

@DllImport("IPHLPAPI.dll")
void CancelIfTimestampConfigChange(HIFTIMESTAMPCHANGE__* NotificationHandle);

@DllImport("IPHLPAPI.dll")
uint IpReleaseAddress(IP_ADAPTER_INDEX_MAP* AdapterInfo);

@DllImport("IPHLPAPI.dll")
uint IpRenewAddress(IP_ADAPTER_INDEX_MAP* AdapterInfo);

@DllImport("IPHLPAPI.dll")
uint SendARP(uint DestIP, uint SrcIP, char* pMacAddr, uint* PhyAddrLen);

@DllImport("IPHLPAPI.dll")
BOOL GetRTTAndHopCount(uint DestIpAddress, uint* HopCount, uint MaxHops, uint* RTT);

@DllImport("IPHLPAPI.dll")
uint GetFriendlyIfIndex(uint IfIndex);

@DllImport("IPHLPAPI.dll")
uint EnableRouter(HANDLE* pHandle, OVERLAPPED* pOverlapped);

@DllImport("IPHLPAPI.dll")
uint UnenableRouter(OVERLAPPED* pOverlapped, uint* lpdwEnableCount);

@DllImport("IPHLPAPI.dll")
uint DisableMediaSense(HANDLE* pHandle, OVERLAPPED* pOverLapped);

@DllImport("IPHLPAPI.dll")
uint RestoreMediaSense(OVERLAPPED* pOverlapped, uint* lpdwEnableCount);

@DllImport("IPHLPAPI.dll")
uint GetIpErrorString(uint ErrorCode, const(wchar)* Buffer, uint* Size);

@DllImport("IPHLPAPI.dll")
uint ResolveNeighbor(SOCKADDR* NetworkAddress, char* PhysicalAddress, uint* PhysicalAddressLength);

@DllImport("IPHLPAPI.dll")
uint CreatePersistentTcpPortReservation(ushort StartPort, ushort NumberOfPorts, ulong* Token);

@DllImport("IPHLPAPI.dll")
uint CreatePersistentUdpPortReservation(ushort StartPort, ushort NumberOfPorts, ulong* Token);

@DllImport("IPHLPAPI.dll")
uint DeletePersistentTcpPortReservation(ushort StartPort, ushort NumberOfPorts);

@DllImport("IPHLPAPI.dll")
uint DeletePersistentUdpPortReservation(ushort StartPort, ushort NumberOfPorts);

@DllImport("IPHLPAPI.dll")
uint LookupPersistentTcpPortReservation(ushort StartPort, ushort NumberOfPorts, ulong* Token);

@DllImport("IPHLPAPI.dll")
uint LookupPersistentUdpPortReservation(ushort StartPort, ushort NumberOfPorts, ulong* Token);

@DllImport("ntdll.dll")
byte* RtlIpv4AddressToStringA(const(in_addr)* Addr, const(char)* S);

@DllImport("ntdll.dll")
ushort* RtlIpv4AddressToStringW(const(in_addr)* Addr, const(wchar)* S);

@DllImport("ntdll.dll")
int RtlIpv4AddressToStringExW(const(in_addr)* Address, ushort Port, const(wchar)* AddressString, uint* AddressStringLength);

@DllImport("ntdll.dll")
int RtlIpv4StringToAddressA(const(char)* S, ubyte Strict, byte** Terminator, in_addr* Addr);

@DllImport("ntdll.dll")
int RtlIpv4StringToAddressW(const(wchar)* S, ubyte Strict, ushort** Terminator, in_addr* Addr);

@DllImport("ntdll.dll")
int RtlIpv4StringToAddressExW(const(wchar)* AddressString, ubyte Strict, in_addr* Address, ushort* Port);

@DllImport("ntdll.dll")
byte* RtlIpv6AddressToStringA(const(in6_addr)* Addr, const(char)* S);

@DllImport("ntdll.dll")
ushort* RtlIpv6AddressToStringW(const(in6_addr)* Addr, const(wchar)* S);

@DllImport("ntdll.dll")
int RtlIpv6AddressToStringExW(const(in6_addr)* Address, uint ScopeId, ushort Port, const(wchar)* AddressString, uint* AddressStringLength);

@DllImport("ntdll.dll")
int RtlIpv6StringToAddressA(const(char)* S, byte** Terminator, in6_addr* Addr);

@DllImport("ntdll.dll")
int RtlIpv6StringToAddressW(const(wchar)* S, ushort** Terminator, in6_addr* Addr);

@DllImport("ntdll.dll")
int RtlIpv6StringToAddressExW(const(wchar)* AddressString, in6_addr* Address, uint* ScopeId, ushort* Port);

@DllImport("ntdll.dll")
byte* RtlEthernetAddressToStringA(const(DL_EUI48)* Addr, const(char)* S);

@DllImport("ntdll.dll")
ushort* RtlEthernetAddressToStringW(const(DL_EUI48)* Addr, const(wchar)* S);

@DllImport("ntdll.dll")
int RtlEthernetStringToAddressA(const(char)* S, byte** Terminator, DL_EUI48* Addr);

@DllImport("ntdll.dll")
int RtlEthernetStringToAddressW(const(wchar)* S, ushort** Terminator, DL_EUI48* Addr);

struct NET_ADDRESS_INFO
{
}

enum SCOPE_LEVEL
{
    ScopeLevelInterface = 1,
    ScopeLevelLink = 2,
    ScopeLevelSubnet = 3,
    ScopeLevelAdmin = 4,
    ScopeLevelSite = 5,
    ScopeLevelOrganization = 8,
    ScopeLevelGlobal = 14,
    ScopeLevelCount = 16,
}

struct SOCKADDR_INET
{
    sockaddr_in Ipv4;
    SOCKADDR_IN6_LH Ipv6;
    ushort si_family;
}

struct SOCKADDR_IN6_PAIR
{
    SOCKADDR_IN6_LH* SourceAddress;
    SOCKADDR_IN6_LH* DestinationAddress;
}

enum NL_PREFIX_ORIGIN
{
    IpPrefixOriginOther = 0,
    IpPrefixOriginManual = 1,
    IpPrefixOriginWellKnown = 2,
    IpPrefixOriginDhcp = 3,
    IpPrefixOriginRouterAdvertisement = 4,
    IpPrefixOriginUnchanged = 16,
}

enum NL_SUFFIX_ORIGIN
{
    NlsoOther = 0,
    NlsoManual = 1,
    NlsoWellKnown = 2,
    NlsoDhcp = 3,
    NlsoLinkLayerAddress = 4,
    NlsoRandom = 5,
    IpSuffixOriginOther = 0,
    IpSuffixOriginManual = 1,
    IpSuffixOriginWellKnown = 2,
    IpSuffixOriginDhcp = 3,
    IpSuffixOriginLinkLayerAddress = 4,
    IpSuffixOriginRandom = 5,
    IpSuffixOriginUnchanged = 16,
}

enum NL_DAD_STATE
{
    NldsInvalid = 0,
    NldsTentative = 1,
    NldsDuplicate = 2,
    NldsDeprecated = 3,
    NldsPreferred = 4,
    IpDadStateInvalid = 0,
    IpDadStateTentative = 1,
    IpDadStateDuplicate = 2,
    IpDadStateDeprecated = 3,
    IpDadStatePreferred = 4,
}

enum NL_NETWORK_CONNECTIVITY_LEVEL_HINT
{
    NetworkConnectivityLevelHintUnknown = 0,
    NetworkConnectivityLevelHintNone = 1,
    NetworkConnectivityLevelHintLocalAccess = 2,
    NetworkConnectivityLevelHintInternetAccess = 3,
    NetworkConnectivityLevelHintConstrainedInternetAccess = 4,
    NetworkConnectivityLevelHintHidden = 5,
}

enum NL_NETWORK_CONNECTIVITY_COST_HINT
{
    NetworkConnectivityCostHintUnknown = 0,
    NetworkConnectivityCostHintUnrestricted = 1,
    NetworkConnectivityCostHintFixed = 2,
    NetworkConnectivityCostHintVariable = 3,
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

