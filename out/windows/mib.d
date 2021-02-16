module windows.mib;

public import windows.core;
public import windows.iphelper : IF_OPER_STATUS, INTERNAL_IF_OPER_STATUS, IP_ADDRESS_PREFIX, MIB_IPFORWARD_TYPE,
                                 MIB_IPNET_TYPE, MIB_IPSTATS_FORWARDING, MIB_TCP_STATE, NET_LUID_LH,
                                 NL_BANDWIDTH_INFORMATION, NL_DAD_STATE, NL_PREFIX_ORIGIN, NL_SUFFIX_ORIGIN,
                                 SOCKADDR_INET, TCP_RTO_ALGORITHM;
public import windows.nativewifi : NDIS_MEDIUM, NDIS_PHYSICAL_MEDIUM;
public import windows.networkdrivers : NET_IF_ACCESS_TYPE, NET_IF_ADMIN_STATUS, NET_IF_CONNECTION_TYPE,
                                       NET_IF_DIRECTION_TYPE, NET_IF_MEDIA_CONNECT_STATE,
                                       NL_LINK_LOCAL_ADDRESS_BEHAVIOR, NL_NEIGHBOR_STATE,
                                       NL_ROUTER_DISCOVERY_BEHAVIOR, NL_ROUTE_ORIGIN, NL_ROUTE_PROTOCOL, TUNNEL_TYPE;
public import windows.systemservices : BOOL, LARGE_INTEGER;
public import windows.winsock : SCOPE_ID, in6_addr;

extern(Windows):


// Enums


enum : int
{
    MibParameterNotification = 0x00000000,
    MibAddInstance           = 0x00000001,
    MibDeleteInstance        = 0x00000002,
    MibInitialNotification   = 0x00000003,
}
alias MIB_NOTIFICATION_TYPE = int;

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
alias ICMP6_TYPE = int;

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
alias ICMP4_TYPE = int;

enum : int
{
    TcpConnectionOffloadStateInHost     = 0x00000000,
    TcpConnectionOffloadStateOffloading = 0x00000001,
    TcpConnectionOffloadStateOffloaded  = 0x00000002,
    TcpConnectionOffloadStateUploading  = 0x00000003,
    TcpConnectionOffloadStateMax        = 0x00000004,
}
alias TCP_CONNECTION_OFFLOAD_STATE = int;

// Structs


struct MIB_IF_ROW2
{
    NET_LUID_LH          InterfaceLuid;
    uint                 InterfaceIndex;
    GUID                 InterfaceGuid;
    ushort[257]          Alias;
    ushort[257]          Description;
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
        ubyte _bitfield70;
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

struct MIB_IF_TABLE2
{
    uint           NumEntries;
    MIB_IF_ROW2[1] Table;
}

struct MIB_IPINTERFACE_ROW
{
    ushort      Family;
    NET_LUID_LH InterfaceLuid;
    uint        InterfaceIndex;
    uint        MaxReassemblySize;
    ulong       InterfaceIdentifier;
    uint        MinRouterAdvertisementInterval;
    uint        MaxRouterAdvertisementInterval;
    ubyte       AdvertisingEnabled;
    ubyte       ForwardingEnabled;
    ubyte       WeakHostSend;
    ubyte       WeakHostReceive;
    ubyte       UseAutomaticMetric;
    ubyte       UseNeighborUnreachabilityDetection;
    ubyte       ManagedAddressConfigurationSupported;
    ubyte       OtherStatefulConfigurationSupported;
    ubyte       AdvertiseDefaultRoute;
    NL_ROUTER_DISCOVERY_BEHAVIOR RouterDiscoveryBehavior;
    uint        DadTransmits;
    uint        BaseReachableTime;
    uint        RetransmitTime;
    uint        PathMtuDiscoveryTimeout;
    NL_LINK_LOCAL_ADDRESS_BEHAVIOR LinkLocalAddressBehavior;
    uint        LinkLocalAddressTimeout;
    uint[16]    ZoneIndices;
    uint        SitePrefixLength;
    uint        Metric;
    uint        NlMtu;
    ubyte       Connected;
    ubyte       SupportsWakeUpPatterns;
    ubyte       SupportsNeighborDiscovery;
    ubyte       SupportsRouterDiscovery;
    uint        ReachableTime;
    NL_INTERFACE_OFFLOAD_ROD TransmitOffload;
    NL_INTERFACE_OFFLOAD_ROD ReceiveOffload;
    ubyte       DisableDefaultRoutes;
}

struct MIB_IPINTERFACE_TABLE
{
    uint NumEntries;
    MIB_IPINTERFACE_ROW[1] Table;
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
    uint               NumEntries;
    MIB_IFSTACK_ROW[1] Table;
}

struct MIB_INVERTEDIFSTACK_TABLE
{
    uint NumEntries;
    MIB_INVERTEDIFSTACK_ROW[1] Table;
}

struct MIB_IP_NETWORK_CONNECTION_BANDWIDTH_ESTIMATES
{
    NL_BANDWIDTH_INFORMATION InboundBandwidthInformation;
    NL_BANDWIDTH_INFORMATION OutboundBandwidthInformation;
}

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
    ubyte            SkipAsSource;
    NL_DAD_STATE     DadState;
    SCOPE_ID         ScopeId;
    LARGE_INTEGER    CreationTimeStamp;
}

struct MIB_UNICASTIPADDRESS_TABLE
{
    uint NumEntries;
    MIB_UNICASTIPADDRESS_ROW[1] Table;
}

struct MIB_ANYCASTIPADDRESS_ROW
{
    SOCKADDR_INET Address;
    NET_LUID_LH   InterfaceLuid;
    uint          InterfaceIndex;
    SCOPE_ID      ScopeId;
}

struct MIB_ANYCASTIPADDRESS_TABLE
{
    uint NumEntries;
    MIB_ANYCASTIPADDRESS_ROW[1] Table;
}

struct MIB_MULTICASTIPADDRESS_ROW
{
    SOCKADDR_INET Address;
    uint          InterfaceIndex;
    NET_LUID_LH   InterfaceLuid;
    SCOPE_ID      ScopeId;
}

struct MIB_MULTICASTIPADDRESS_TABLE
{
    uint NumEntries;
    MIB_MULTICASTIPADDRESS_ROW[1] Table;
}

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
    ubyte             Loopback;
    ubyte             AutoconfigureAddress;
    ubyte             Publish;
    ubyte             Immortal;
    uint              Age;
    NL_ROUTE_ORIGIN   Origin;
}

struct MIB_IPFORWARD_TABLE2
{
    uint NumEntries;
    MIB_IPFORWARD_ROW2[1] Table;
}

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
    ubyte         IsReachable;
    ulong         LinkTransmitSpeed;
    ulong         LinkReceiveSpeed;
}

struct MIB_IPPATH_TABLE
{
    uint              NumEntries;
    MIB_IPPATH_ROW[1] Table;
}

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
            ubyte _bitfield71;
        }
        ubyte Flags;
    }
    union ReachabilityTime
    {
        uint LastReachable;
        uint LastUnreachable;
    }
}

struct MIB_IPNET_TABLE2
{
    uint              NumEntries;
    MIB_IPNET_ROW2[1] Table;
}

struct MIB_OPAQUE_QUERY
{
    uint    dwVarId;
    uint[1] rgdwVarIndex;
}

struct MIB_IFNUMBER
{
    uint dwValue;
}

struct MIB_IFROW
{
    ushort[256] wszName;
    uint        dwIndex;
    uint        dwType;
    uint        dwMtu;
    uint        dwSpeed;
    uint        dwPhysAddrLen;
    ubyte[8]    bPhysAddr;
    uint        dwAdminStatus;
    INTERNAL_IF_OPER_STATUS dwOperStatus;
    uint        dwLastChange;
    uint        dwInOctets;
    uint        dwInUcastPkts;
    uint        dwInNUcastPkts;
    uint        dwInDiscards;
    uint        dwInErrors;
    uint        dwInUnknownProtos;
    uint        dwOutOctets;
    uint        dwOutUcastPkts;
    uint        dwOutNUcastPkts;
    uint        dwOutDiscards;
    uint        dwOutErrors;
    uint        dwOutQLen;
    uint        dwDescrLen;
    ubyte[256]  bDescr;
}

struct MIB_IFTABLE
{
    uint         dwNumEntries;
    MIB_IFROW[1] table;
}

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

struct MIB_IPADDRTABLE
{
    uint                dwNumEntries;
    MIB_IPADDRROW_XP[1] table;
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

struct MIB_IPFORWARDTABLE
{
    uint                dwNumEntries;
    MIB_IPFORWARDROW[1] table;
}

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

struct MIB_IPNETROW_W2K
{
    uint     dwIndex;
    uint     dwPhysAddrLen;
    ubyte[8] bPhysAddr;
    uint     dwAddr;
    uint     dwType;
}

struct MIB_IPNETTABLE
{
    uint               dwNumEntries;
    MIB_IPNETROW_LH[1] table;
}

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
    uint      dwMsgs;
    uint      dwErrors;
    uint[256] rgdwTypeCount;
}

struct MIB_ICMP_EX_XPSP1
{
    MIBICMPSTATS_EX_XPSP1 icmpInStats;
    MIBICMPSTATS_EX_XPSP1 icmpOutStats;
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
    uint  dwOutIfIndex;
    uint  dwNextHopAddr;
    void* pvReserved;
    uint  dwReserved;
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
    MIB_IPMCAST_OIF_XP[1] rgmioOutInfo;
}

struct MIB_MFE_TABLE
{
    uint               dwNumEntries;
    MIB_IPMCAST_MFE[1] table;
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
    uint  dwOutIfIndex;
    uint  dwNextHopAddr;
    void* pvDialContext;
    uint  ulTtlTooLow;
    uint  ulFragNeeded;
    uint  ulOutPackets;
    uint  ulOutDiscards;
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
    MIB_IPMCAST_OIF_STATS_LH[1] rgmiosOutStats;
}

struct MIB_MFE_STATS_TABLE
{
    uint dwNumEntries;
    MIB_IPMCAST_MFE_STATS[1] table;
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
    MIB_IPMCAST_OIF_STATS_LH[1] rgmiosOutStats;
}

struct MIB_MFE_STATS_TABLE_EX_XP
{
    uint dwNumEntries;
    MIB_IPMCAST_MFE_STATS_EX_XP[1]* table;
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
    MIB_IPMCAST_IF_ENTRY[1] table;
}

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
    uint             dwNumEntries;
    MIB_TCPROW_LH[1] table;
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
    uint           dwNumEntries;
    MIB_TCPROW2[1] table;
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
    MIB_TCPROW_OWNER_PID[1] table;
}

struct MIB_TCPROW_OWNER_MODULE
{
    uint          dwState;
    uint          dwLocalAddr;
    uint          dwLocalPort;
    uint          dwRemoteAddr;
    uint          dwRemotePort;
    uint          dwOwningPid;
    LARGE_INTEGER liCreateTimestamp;
    ulong[16]     OwningModuleInfo;
}

struct MIB_TCPTABLE_OWNER_MODULE
{
    uint dwNumEntries;
    MIB_TCPROW_OWNER_MODULE[1] table;
}

struct MIB_TCP6ROW
{
    MIB_TCP_STATE State;
    in6_addr      LocalAddr;
    uint          dwLocalScopeId;
    uint          dwLocalPort;
    in6_addr      RemoteAddr;
    uint          dwRemoteScopeId;
    uint          dwRemotePort;
}

struct MIB_TCP6TABLE
{
    uint           dwNumEntries;
    MIB_TCP6ROW[1] table;
}

struct MIB_TCP6ROW2
{
    in6_addr      LocalAddr;
    uint          dwLocalScopeId;
    uint          dwLocalPort;
    in6_addr      RemoteAddr;
    uint          dwRemoteScopeId;
    uint          dwRemotePort;
    MIB_TCP_STATE State;
    uint          dwOwningPid;
    TCP_CONNECTION_OFFLOAD_STATE dwOffloadState;
}

struct MIB_TCP6TABLE2
{
    uint            dwNumEntries;
    MIB_TCP6ROW2[1] table;
}

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

struct MIB_TCP6TABLE_OWNER_PID
{
    uint dwNumEntries;
    MIB_TCP6ROW_OWNER_PID[1] table;
}

struct MIB_TCP6ROW_OWNER_MODULE
{
    ubyte[16]     ucLocalAddr;
    uint          dwLocalScopeId;
    uint          dwLocalPort;
    ubyte[16]     ucRemoteAddr;
    uint          dwRemoteScopeId;
    uint          dwRemotePort;
    uint          dwState;
    uint          dwOwningPid;
    LARGE_INTEGER liCreateTimestamp;
    ulong[16]     OwningModuleInfo;
}

struct MIB_TCP6TABLE_OWNER_MODULE
{
    uint dwNumEntries;
    MIB_TCP6ROW_OWNER_MODULE[1] table;
}

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

struct MIB_UDPROW
{
    uint dwLocalAddr;
    uint dwLocalPort;
}

struct MIB_UDPTABLE
{
    uint          dwNumEntries;
    MIB_UDPROW[1] table;
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
    MIB_UDPROW_OWNER_PID[1] table;
}

struct MIB_UDPROW_OWNER_MODULE
{
    uint          dwLocalAddr;
    uint          dwLocalPort;
    uint          dwOwningPid;
    LARGE_INTEGER liCreateTimestamp;
    union
    {
        struct
        {
            int _bitfield72;
        }
        int dwFlags;
    }
    ulong[16]     OwningModuleInfo;
}

struct MIB_UDPTABLE_OWNER_MODULE
{
    uint dwNumEntries;
    MIB_UDPROW_OWNER_MODULE[1] table;
}

struct MIB_UDP6ROW
{
    in6_addr dwLocalAddr;
    uint     dwLocalScopeId;
    uint     dwLocalPort;
}

struct MIB_UDP6TABLE
{
    uint           dwNumEntries;
    MIB_UDP6ROW[1] table;
}

struct MIB_UDP6ROW_OWNER_PID
{
    ubyte[16] ucLocalAddr;
    uint      dwLocalScopeId;
    uint      dwLocalPort;
    uint      dwOwningPid;
}

struct MIB_UDP6TABLE_OWNER_PID
{
    uint dwNumEntries;
    MIB_UDP6ROW_OWNER_PID[1] table;
}

struct MIB_UDP6ROW_OWNER_MODULE
{
    ubyte[16]     ucLocalAddr;
    uint          dwLocalScopeId;
    uint          dwLocalPort;
    uint          dwOwningPid;
    LARGE_INTEGER liCreateTimestamp;
    union
    {
        struct
        {
            int _bitfield73;
        }
        int dwFlags;
    }
    ulong[16]     OwningModuleInfo;
}

struct MIB_UDP6TABLE_OWNER_MODULE
{
    uint dwNumEntries;
    MIB_UDP6ROW_OWNER_MODULE[1] table;
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
    uint  dwNoPorts;
    uint  dwInErrors;
    ulong dw64OutDatagrams;
    uint  dwNumAddrs;
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
    MIB_IPMCAST_BOUNDARY[1] table;
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
    uint        dwGroupAddress;
    uint        dwGroupMask;
    ushort[256] snNameBuffer;
    uint        dwStatus;
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
    union
    {
        ulong    ullAlign;
        ubyte[1] rgbyData;
    }
}

struct NL_INTERFACE_OFFLOAD_ROD
{
    ubyte _bitfield74;
}

