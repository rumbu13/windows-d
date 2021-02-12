module windows.mib;

public import system;
public import windows.iphelper;
public import windows.nativewifi;
public import windows.networkdrivers;
public import windows.systemservices;
public import windows.winsock;

extern(Windows):

enum MIB_NOTIFICATION_TYPE
{
    MibParameterNotification = 0,
    MibAddInstance = 1,
    MibDeleteInstance = 2,
    MibInitialNotification = 3,
}

struct MIB_IF_ROW2
{
    NET_LUID_LH InterfaceLuid;
    uint InterfaceIndex;
    Guid InterfaceGuid;
    ushort Alias;
    ushort Description;
    uint PhysicalAddressLength;
    ubyte PhysicalAddress;
    ubyte PermanentPhysicalAddress;
    uint Mtu;
    uint Type;
    TUNNEL_TYPE TunnelType;
    NDIS_MEDIUM MediaType;
    NDIS_PHYSICAL_MEDIUM PhysicalMediumType;
    NET_IF_ACCESS_TYPE AccessType;
    NET_IF_DIRECTION_TYPE DirectionType;
    _InterfaceAndOperStatusFlags_e__Struct InterfaceAndOperStatusFlags;
    IF_OPER_STATUS OperStatus;
    NET_IF_ADMIN_STATUS AdminStatus;
    NET_IF_MEDIA_CONNECT_STATE MediaConnectState;
    Guid NetworkGuid;
    NET_IF_CONNECTION_TYPE ConnectionType;
    ulong TransmitLinkSpeed;
    ulong ReceiveLinkSpeed;
    ulong InOctets;
    ulong InUcastPkts;
    ulong InNUcastPkts;
    ulong InDiscards;
    ulong InErrors;
    ulong InUnknownProtos;
    ulong InUcastOctets;
    ulong InMulticastOctets;
    ulong InBroadcastOctets;
    ulong OutOctets;
    ulong OutUcastPkts;
    ulong OutNUcastPkts;
    ulong OutDiscards;
    ulong OutErrors;
    ulong OutUcastOctets;
    ulong OutMulticastOctets;
    ulong OutBroadcastOctets;
    ulong OutQLen;
}

struct MIB_IF_TABLE2
{
    uint NumEntries;
    MIB_IF_ROW2 Table;
}

struct MIB_IPINTERFACE_ROW
{
    ushort Family;
    NET_LUID_LH InterfaceLuid;
    uint InterfaceIndex;
    uint MaxReassemblySize;
    ulong InterfaceIdentifier;
    uint MinRouterAdvertisementInterval;
    uint MaxRouterAdvertisementInterval;
    ubyte AdvertisingEnabled;
    ubyte ForwardingEnabled;
    ubyte WeakHostSend;
    ubyte WeakHostReceive;
    ubyte UseAutomaticMetric;
    ubyte UseNeighborUnreachabilityDetection;
    ubyte ManagedAddressConfigurationSupported;
    ubyte OtherStatefulConfigurationSupported;
    ubyte AdvertiseDefaultRoute;
    NL_ROUTER_DISCOVERY_BEHAVIOR RouterDiscoveryBehavior;
    uint DadTransmits;
    uint BaseReachableTime;
    uint RetransmitTime;
    uint PathMtuDiscoveryTimeout;
    NL_LINK_LOCAL_ADDRESS_BEHAVIOR LinkLocalAddressBehavior;
    uint LinkLocalAddressTimeout;
    uint ZoneIndices;
    uint SitePrefixLength;
    uint Metric;
    uint NlMtu;
    ubyte Connected;
    ubyte SupportsWakeUpPatterns;
    ubyte SupportsNeighborDiscovery;
    ubyte SupportsRouterDiscovery;
    uint ReachableTime;
    NL_INTERFACE_OFFLOAD_ROD TransmitOffload;
    NL_INTERFACE_OFFLOAD_ROD ReceiveOffload;
    ubyte DisableDefaultRoutes;
}

struct MIB_IPINTERFACE_TABLE
{
    uint NumEntries;
    MIB_IPINTERFACE_ROW Table;
}

struct MIB_IFSTACK_ROW
{
    uint HigherLayerInterfaceIndex;
    uint LowerLayerInterfaceIndex;
}

struct MIB_INVERTEDIFSTACK_ROW
{
    uint LowerLayerInterfaceIndex;
    uint HigherLayerInterfaceIndex;
}

struct MIB_IFSTACK_TABLE
{
    uint NumEntries;
    MIB_IFSTACK_ROW Table;
}

struct MIB_INVERTEDIFSTACK_TABLE
{
    uint NumEntries;
    MIB_INVERTEDIFSTACK_ROW Table;
}

struct MIB_IP_NETWORK_CONNECTION_BANDWIDTH_ESTIMATES
{
    NL_BANDWIDTH_INFORMATION InboundBandwidthInformation;
    NL_BANDWIDTH_INFORMATION OutboundBandwidthInformation;
}

struct MIB_UNICASTIPADDRESS_ROW
{
    SOCKADDR_INET Address;
    NET_LUID_LH InterfaceLuid;
    uint InterfaceIndex;
    NL_PREFIX_ORIGIN PrefixOrigin;
    NL_SUFFIX_ORIGIN SuffixOrigin;
    uint ValidLifetime;
    uint PreferredLifetime;
    ubyte OnLinkPrefixLength;
    ubyte SkipAsSource;
    NL_DAD_STATE DadState;
    SCOPE_ID ScopeId;
    LARGE_INTEGER CreationTimeStamp;
}

struct MIB_UNICASTIPADDRESS_TABLE
{
    uint NumEntries;
    MIB_UNICASTIPADDRESS_ROW Table;
}

struct MIB_ANYCASTIPADDRESS_ROW
{
    SOCKADDR_INET Address;
    NET_LUID_LH InterfaceLuid;
    uint InterfaceIndex;
    SCOPE_ID ScopeId;
}

struct MIB_ANYCASTIPADDRESS_TABLE
{
    uint NumEntries;
    MIB_ANYCASTIPADDRESS_ROW Table;
}

struct MIB_MULTICASTIPADDRESS_ROW
{
    SOCKADDR_INET Address;
    uint InterfaceIndex;
    NET_LUID_LH InterfaceLuid;
    SCOPE_ID ScopeId;
}

struct MIB_MULTICASTIPADDRESS_TABLE
{
    uint NumEntries;
    MIB_MULTICASTIPADDRESS_ROW Table;
}

struct MIB_IPFORWARD_ROW2
{
    NET_LUID_LH InterfaceLuid;
    uint InterfaceIndex;
    IP_ADDRESS_PREFIX DestinationPrefix;
    SOCKADDR_INET NextHop;
    ubyte SitePrefixLength;
    uint ValidLifetime;
    uint PreferredLifetime;
    uint Metric;
    NL_ROUTE_PROTOCOL Protocol;
    ubyte Loopback;
    ubyte AutoconfigureAddress;
    ubyte Publish;
    ubyte Immortal;
    uint Age;
    NL_ROUTE_ORIGIN Origin;
}

struct MIB_IPFORWARD_TABLE2
{
    uint NumEntries;
    MIB_IPFORWARD_ROW2 Table;
}

struct MIB_IPPATH_ROW
{
    SOCKADDR_INET Source;
    SOCKADDR_INET Destination;
    NET_LUID_LH InterfaceLuid;
    uint InterfaceIndex;
    SOCKADDR_INET CurrentNextHop;
    uint PathMtu;
    uint RttMean;
    uint RttDeviation;
    _Anonymous_e__Union Anonymous;
    ubyte IsReachable;
    ulong LinkTransmitSpeed;
    ulong LinkReceiveSpeed;
}

struct MIB_IPPATH_TABLE
{
    uint NumEntries;
    MIB_IPPATH_ROW Table;
}

struct MIB_IPNET_ROW2
{
    SOCKADDR_INET Address;
    uint InterfaceIndex;
    NET_LUID_LH InterfaceLuid;
    ubyte PhysicalAddress;
    uint PhysicalAddressLength;
    NL_NEIGHBOR_STATE State;
    _Anonymous_e__Union Anonymous;
    _ReachabilityTime_e__Union ReachabilityTime;
}

struct MIB_IPNET_TABLE2
{
    uint NumEntries;
    MIB_IPNET_ROW2 Table;
}

struct MIB_OPAQUE_QUERY
{
    uint dwVarId;
    uint rgdwVarIndex;
}

struct MIB_IFNUMBER
{
    uint dwValue;
}

struct MIB_IFROW
{
    ushort wszName;
    uint dwIndex;
    uint dwType;
    uint dwMtu;
    uint dwSpeed;
    uint dwPhysAddrLen;
    ubyte bPhysAddr;
    uint dwAdminStatus;
    INTERNAL_IF_OPER_STATUS dwOperStatus;
    uint dwLastChange;
    uint dwInOctets;
    uint dwInUcastPkts;
    uint dwInNUcastPkts;
    uint dwInDiscards;
    uint dwInErrors;
    uint dwInUnknownProtos;
    uint dwOutOctets;
    uint dwOutUcastPkts;
    uint dwOutNUcastPkts;
    uint dwOutDiscards;
    uint dwOutErrors;
    uint dwOutQLen;
    uint dwDescrLen;
    ubyte bDescr;
}

struct MIB_IFTABLE
{
    uint dwNumEntries;
    MIB_IFROW table;
}

struct MIB_IPADDRROW_XP
{
    uint dwAddr;
    uint dwIndex;
    uint dwMask;
    uint dwBCastAddr;
    uint dwReasmSize;
    ushort unused1;
    ushort wType;
}

struct MIB_IPADDRROW_W2K
{
    uint dwAddr;
    uint dwIndex;
    uint dwMask;
    uint dwBCastAddr;
    uint dwReasmSize;
    ushort unused1;
    ushort unused2;
}

struct MIB_IPADDRTABLE
{
    uint dwNumEntries;
    MIB_IPADDRROW_XP table;
}

struct MIB_IPFORWARDNUMBER
{
    uint dwValue;
}

struct MIB_IPFORWARDROW
{
    uint dwForwardDest;
    uint dwForwardMask;
    uint dwForwardPolicy;
    uint dwForwardNextHop;
    uint dwForwardIfIndex;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    uint dwForwardAge;
    uint dwForwardNextHopAS;
    uint dwForwardMetric1;
    uint dwForwardMetric2;
    uint dwForwardMetric3;
    uint dwForwardMetric4;
    uint dwForwardMetric5;
}

struct MIB_IPFORWARDTABLE
{
    uint dwNumEntries;
    MIB_IPFORWARDROW table;
}

struct MIB_IPNETROW_LH
{
    uint dwIndex;
    uint dwPhysAddrLen;
    ubyte bPhysAddr;
    uint dwAddr;
    _Anonymous_e__Union Anonymous;
}

struct MIB_IPNETROW_W2K
{
    uint dwIndex;
    uint dwPhysAddrLen;
    ubyte bPhysAddr;
    uint dwAddr;
    uint dwType;
}

struct MIB_IPNETTABLE
{
    uint dwNumEntries;
    MIB_IPNETROW_LH table;
}

struct MIB_IPSTATS_LH
{
    _Anonymous_e__Union Anonymous;
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

struct MIBICMPINFO
{
    MIBICMPSTATS icmpInStats;
    MIBICMPSTATS icmpOutStats;
}

struct MIB_ICMP
{
    MIBICMPINFO stats;
}

struct MIBICMPSTATS_EX_XPSP1
{
    uint dwMsgs;
    uint dwErrors;
    uint rgdwTypeCount;
}

struct MIB_ICMP_EX_XPSP1
{
    MIBICMPSTATS_EX_XPSP1 icmpInStats;
    MIBICMPSTATS_EX_XPSP1 icmpOutStats;
}

enum ICMP6_TYPE
{
    ICMP6_DST_UNREACH = 1,
    ICMP6_PACKET_TOO_BIG = 2,
    ICMP6_TIME_EXCEEDED = 3,
    ICMP6_PARAM_PROB = 4,
    ICMP6_ECHO_REQUEST = 128,
    ICMP6_ECHO_REPLY = 129,
    ICMP6_MEMBERSHIP_QUERY = 130,
    ICMP6_MEMBERSHIP_REPORT = 131,
    ICMP6_MEMBERSHIP_REDUCTION = 132,
    ND_ROUTER_SOLICIT = 133,
    ND_ROUTER_ADVERT = 134,
    ND_NEIGHBOR_SOLICIT = 135,
    ND_NEIGHBOR_ADVERT = 136,
    ND_REDIRECT = 137,
    ICMP6_V2_MEMBERSHIP_REPORT = 143,
}

enum ICMP4_TYPE
{
    ICMP4_ECHO_REPLY = 0,
    ICMP4_DST_UNREACH = 3,
    ICMP4_SOURCE_QUENCH = 4,
    ICMP4_REDIRECT = 5,
    ICMP4_ECHO_REQUEST = 8,
    ICMP4_ROUTER_ADVERT = 9,
    ICMP4_ROUTER_SOLICIT = 10,
    ICMP4_TIME_EXCEEDED = 11,
    ICMP4_PARAM_PROB = 12,
    ICMP4_TIMESTAMP_REQUEST = 13,
    ICMP4_TIMESTAMP_REPLY = 14,
    ICMP4_MASK_REQUEST = 17,
    ICMP4_MASK_REPLY = 18,
}

struct MIB_IPMCAST_OIF_XP
{
    uint dwOutIfIndex;
    uint dwNextHopAddr;
    uint dwReserved;
    uint dwReserved1;
}

struct MIB_IPMCAST_OIF_W2K
{
    uint dwOutIfIndex;
    uint dwNextHopAddr;
    void* pvReserved;
    uint dwReserved;
}

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
    MIB_IPMCAST_OIF_XP rgmioOutInfo;
}

struct MIB_MFE_TABLE
{
    uint dwNumEntries;
    MIB_IPMCAST_MFE table;
}

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

struct MIB_IPMCAST_OIF_STATS_W2K
{
    uint dwOutIfIndex;
    uint dwNextHopAddr;
    void* pvDialContext;
    uint ulTtlTooLow;
    uint ulFragNeeded;
    uint ulOutPackets;
    uint ulOutDiscards;
}

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
    MIB_IPMCAST_OIF_STATS_LH rgmiosOutStats;
}

struct MIB_MFE_STATS_TABLE
{
    uint dwNumEntries;
    MIB_IPMCAST_MFE_STATS table;
}

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
    MIB_IPMCAST_OIF_STATS_LH rgmiosOutStats;
}

struct MIB_MFE_STATS_TABLE_EX_XP
{
    uint dwNumEntries;
    MIB_IPMCAST_MFE_STATS_EX_XP* table;
}

struct MIB_IPMCAST_GLOBAL
{
    uint dwEnable;
}

struct MIB_IPMCAST_IF_ENTRY
{
    uint dwIfIndex;
    uint dwTtl;
    uint dwProtocol;
    uint dwRateLimit;
    uint ulInMcastOctets;
    uint ulOutMcastOctets;
}

struct MIB_IPMCAST_IF_TABLE
{
    uint dwNumEntries;
    MIB_IPMCAST_IF_ENTRY table;
}

enum TCP_CONNECTION_OFFLOAD_STATE
{
    TcpConnectionOffloadStateInHost = 0,
    TcpConnectionOffloadStateOffloading = 1,
    TcpConnectionOffloadStateOffloaded = 2,
    TcpConnectionOffloadStateUploading = 3,
    TcpConnectionOffloadStateMax = 4,
}

struct MIB_TCPROW_LH
{
    _Anonymous_e__Union Anonymous;
    uint dwLocalAddr;
    uint dwLocalPort;
    uint dwRemoteAddr;
    uint dwRemotePort;
}

struct MIB_TCPROW_W2K
{
    uint dwState;
    uint dwLocalAddr;
    uint dwLocalPort;
    uint dwRemoteAddr;
    uint dwRemotePort;
}

struct MIB_TCPTABLE
{
    uint dwNumEntries;
    MIB_TCPROW_LH table;
}

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

struct MIB_TCPTABLE2
{
    uint dwNumEntries;
    MIB_TCPROW2 table;
}

struct MIB_TCPROW_OWNER_PID
{
    uint dwState;
    uint dwLocalAddr;
    uint dwLocalPort;
    uint dwRemoteAddr;
    uint dwRemotePort;
    uint dwOwningPid;
}

struct MIB_TCPTABLE_OWNER_PID
{
    uint dwNumEntries;
    MIB_TCPROW_OWNER_PID table;
}

struct MIB_TCPROW_OWNER_MODULE
{
    uint dwState;
    uint dwLocalAddr;
    uint dwLocalPort;
    uint dwRemoteAddr;
    uint dwRemotePort;
    uint dwOwningPid;
    LARGE_INTEGER liCreateTimestamp;
    ulong OwningModuleInfo;
}

struct MIB_TCPTABLE_OWNER_MODULE
{
    uint dwNumEntries;
    MIB_TCPROW_OWNER_MODULE table;
}

struct MIB_TCP6ROW
{
    MIB_TCP_STATE State;
    in6_addr LocalAddr;
    uint dwLocalScopeId;
    uint dwLocalPort;
    in6_addr RemoteAddr;
    uint dwRemoteScopeId;
    uint dwRemotePort;
}

struct MIB_TCP6TABLE
{
    uint dwNumEntries;
    MIB_TCP6ROW table;
}

struct MIB_TCP6ROW2
{
    in6_addr LocalAddr;
    uint dwLocalScopeId;
    uint dwLocalPort;
    in6_addr RemoteAddr;
    uint dwRemoteScopeId;
    uint dwRemotePort;
    MIB_TCP_STATE State;
    uint dwOwningPid;
    TCP_CONNECTION_OFFLOAD_STATE dwOffloadState;
}

struct MIB_TCP6TABLE2
{
    uint dwNumEntries;
    MIB_TCP6ROW2 table;
}

struct MIB_TCP6ROW_OWNER_PID
{
    ubyte ucLocalAddr;
    uint dwLocalScopeId;
    uint dwLocalPort;
    ubyte ucRemoteAddr;
    uint dwRemoteScopeId;
    uint dwRemotePort;
    uint dwState;
    uint dwOwningPid;
}

struct MIB_TCP6TABLE_OWNER_PID
{
    uint dwNumEntries;
    MIB_TCP6ROW_OWNER_PID table;
}

struct MIB_TCP6ROW_OWNER_MODULE
{
    ubyte ucLocalAddr;
    uint dwLocalScopeId;
    uint dwLocalPort;
    ubyte ucRemoteAddr;
    uint dwRemoteScopeId;
    uint dwRemotePort;
    uint dwState;
    uint dwOwningPid;
    LARGE_INTEGER liCreateTimestamp;
    ulong OwningModuleInfo;
}

struct MIB_TCP6TABLE_OWNER_MODULE
{
    uint dwNumEntries;
    MIB_TCP6ROW_OWNER_MODULE table;
}

struct MIB_TCPSTATS_LH
{
    _Anonymous_e__Union Anonymous;
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

struct MIB_TCPSTATS2
{
    TCP_RTO_ALGORITHM RtoAlgorithm;
    uint dwRtoMin;
    uint dwRtoMax;
    uint dwMaxConn;
    uint dwActiveOpens;
    uint dwPassiveOpens;
    uint dwAttemptFails;
    uint dwEstabResets;
    uint dwCurrEstab;
    ulong dw64InSegs;
    ulong dw64OutSegs;
    uint dwRetransSegs;
    uint dwInErrs;
    uint dwOutRsts;
    uint dwNumConns;
}

struct MIB_UDPROW
{
    uint dwLocalAddr;
    uint dwLocalPort;
}

struct MIB_UDPTABLE
{
    uint dwNumEntries;
    MIB_UDPROW table;
}

struct MIB_UDPROW_OWNER_PID
{
    uint dwLocalAddr;
    uint dwLocalPort;
    uint dwOwningPid;
}

struct MIB_UDPTABLE_OWNER_PID
{
    uint dwNumEntries;
    MIB_UDPROW_OWNER_PID table;
}

struct MIB_UDPROW_OWNER_MODULE
{
    uint dwLocalAddr;
    uint dwLocalPort;
    uint dwOwningPid;
    LARGE_INTEGER liCreateTimestamp;
    _Anonymous_e__Union Anonymous;
    ulong OwningModuleInfo;
}

struct MIB_UDPTABLE_OWNER_MODULE
{
    uint dwNumEntries;
    MIB_UDPROW_OWNER_MODULE table;
}

struct MIB_UDP6ROW
{
    in6_addr dwLocalAddr;
    uint dwLocalScopeId;
    uint dwLocalPort;
}

struct MIB_UDP6TABLE
{
    uint dwNumEntries;
    MIB_UDP6ROW table;
}

struct MIB_UDP6ROW_OWNER_PID
{
    ubyte ucLocalAddr;
    uint dwLocalScopeId;
    uint dwLocalPort;
    uint dwOwningPid;
}

struct MIB_UDP6TABLE_OWNER_PID
{
    uint dwNumEntries;
    MIB_UDP6ROW_OWNER_PID table;
}

struct MIB_UDP6ROW_OWNER_MODULE
{
    ubyte ucLocalAddr;
    uint dwLocalScopeId;
    uint dwLocalPort;
    uint dwOwningPid;
    LARGE_INTEGER liCreateTimestamp;
    _Anonymous_e__Union Anonymous;
    ulong OwningModuleInfo;
}

struct MIB_UDP6TABLE_OWNER_MODULE
{
    uint dwNumEntries;
    MIB_UDP6ROW_OWNER_MODULE table;
}

struct MIB_UDPSTATS
{
    uint dwInDatagrams;
    uint dwNoPorts;
    uint dwInErrors;
    uint dwOutDatagrams;
    uint dwNumAddrs;
}

struct MIB_UDPSTATS2
{
    ulong dw64InDatagrams;
    uint dwNoPorts;
    uint dwInErrors;
    ulong dw64OutDatagrams;
    uint dwNumAddrs;
}

struct MIB_IPMCAST_BOUNDARY
{
    uint dwIfIndex;
    uint dwGroupAddress;
    uint dwGroupMask;
    uint dwStatus;
}

struct MIB_IPMCAST_BOUNDARY_TABLE
{
    uint dwNumEntries;
    MIB_IPMCAST_BOUNDARY table;
}

struct MIB_BOUNDARYROW
{
    uint dwGroupAddress;
    uint dwGroupMask;
}

struct MIB_MCAST_LIMIT_ROW
{
    uint dwTtl;
    uint dwRateLimit;
}

struct MIB_IPMCAST_SCOPE
{
    uint dwGroupAddress;
    uint dwGroupMask;
    ushort snNameBuffer;
    uint dwStatus;
}

struct MIB_BEST_IF
{
    uint dwDestAddr;
    uint dwIfIndex;
}

struct MIB_PROXYARP
{
    uint dwAddress;
    uint dwMask;
    uint dwIfIndex;
}

struct MIB_IFSTATUS
{
    uint dwIfIndex;
    uint dwAdminStatus;
    uint dwOperationalStatus;
    BOOL bMHbeatActive;
    BOOL bMHbeatAlive;
}

struct MIB_OPAQUE_INFO
{
    uint dwId;
    _Anonymous_e__Union Anonymous;
}

struct NL_INTERFACE_OFFLOAD_ROD
{
    ubyte _bitfield;
}

