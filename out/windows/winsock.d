module windows.winsock;

public import system;
public import windows.com;
public import windows.iphelper;
public import windows.networkdrivers;
public import windows.qualityofservice;
public import windows.systemservices;
public import windows.windowsandmessaging;

extern(Windows):

struct BLOB
{
    uint cbSize;
    ubyte* pBlobData;
}

alias HWSAEVENT = int;
struct in_addr
{
    _S_un_e__Union S_un;
}

struct SOCKADDR
{
    ushort sa_family;
    byte sa_data;
}

struct SOCKET_ADDRESS
{
    SOCKADDR* lpSockaddr;
    int iSockaddrLength;
}

struct CSADDR_INFO
{
    SOCKET_ADDRESS LocalAddr;
    SOCKET_ADDRESS RemoteAddr;
    int iSocketType;
    int iProtocol;
}

struct sockaddr_storage_xp
{
    short ss_family;
    byte __ss_pad1;
    long __ss_align;
    byte __ss_pad2;
}

struct SOCKET_PROCESSOR_AFFINITY
{
    PROCESSOR_NUMBER Processor;
    ushort NumaNodeId;
    ushort Reserved;
}

enum IPPROTO
{
    IPPROTO_HOPOPTS = 0,
    IPPROTO_ICMP = 1,
    IPPROTO_IGMP = 2,
    IPPROTO_GGP = 3,
    IPPROTO_IPV4 = 4,
    IPPROTO_ST = 5,
    IPPROTO_TCP = 6,
    IPPROTO_CBT = 7,
    IPPROTO_EGP = 8,
    IPPROTO_IGP = 9,
    IPPROTO_PUP = 12,
    IPPROTO_UDP = 17,
    IPPROTO_IDP = 22,
    IPPROTO_RDP = 27,
    IPPROTO_IPV6 = 41,
    IPPROTO_ROUTING = 43,
    IPPROTO_FRAGMENT = 44,
    IPPROTO_ESP = 50,
    IPPROTO_AH = 51,
    IPPROTO_ICMPV6 = 58,
    IPPROTO_NONE = 59,
    IPPROTO_DSTOPTS = 60,
    IPPROTO_ND = 77,
    IPPROTO_ICLFXBM = 78,
    IPPROTO_PIM = 103,
    IPPROTO_PGM = 113,
    IPPROTO_L2TP = 115,
    IPPROTO_SCTP = 132,
    IPPROTO_RAW = 255,
    IPPROTO_MAX = 256,
    IPPROTO_RESERVED_RAW = 257,
    IPPROTO_RESERVED_IPSEC = 258,
    IPPROTO_RESERVED_IPSECOFFLOAD = 259,
    IPPROTO_RESERVED_WNV = 260,
    IPPROTO_RESERVED_MAX = 261,
}

struct SCOPE_ID
{
    _Anonymous_e__Union Anonymous;
}

struct sockaddr_in
{
    ushort sin_family;
    ushort sin_port;
    in_addr sin_addr;
    byte sin_zero;
}

struct sockaddr_dl
{
    ushort sdl_family;
    ubyte sdl_data;
    ubyte sdl_zero;
}

struct WSABUF
{
    uint len;
    byte* buf;
}

struct WSAMSG
{
    SOCKADDR* name;
    int namelen;
    WSABUF* lpBuffers;
    uint dwBufferCount;
    WSABUF Control;
    uint dwFlags;
}

struct cmsghdr
{
    uint cmsg_len;
    int cmsg_level;
    int cmsg_type;
}

struct ADDRINFOA
{
    int ai_flags;
    int ai_family;
    int ai_socktype;
    int ai_protocol;
    uint ai_addrlen;
    byte* ai_canonname;
    SOCKADDR* ai_addr;
    ADDRINFOA* ai_next;
}

struct addrinfoW
{
    int ai_flags;
    int ai_family;
    int ai_socktype;
    int ai_protocol;
    uint ai_addrlen;
    const(wchar)* ai_canonname;
    SOCKADDR* ai_addr;
    addrinfoW* ai_next;
}

struct addrinfoexA
{
    int ai_flags;
    int ai_family;
    int ai_socktype;
    int ai_protocol;
    uint ai_addrlen;
    byte* ai_canonname;
    SOCKADDR* ai_addr;
    void* ai_blob;
    uint ai_bloblen;
    Guid* ai_provider;
    addrinfoexA* ai_next;
}

struct addrinfoexW
{
    int ai_flags;
    int ai_family;
    int ai_socktype;
    int ai_protocol;
    uint ai_addrlen;
    const(wchar)* ai_canonname;
    SOCKADDR* ai_addr;
    void* ai_blob;
    uint ai_bloblen;
    Guid* ai_provider;
    addrinfoexW* ai_next;
}

struct addrinfoex2A
{
    int ai_flags;
    int ai_family;
    int ai_socktype;
    int ai_protocol;
    uint ai_addrlen;
    byte* ai_canonname;
    SOCKADDR* ai_addr;
    void* ai_blob;
    uint ai_bloblen;
    Guid* ai_provider;
    addrinfoex2A* ai_next;
    int ai_version;
    byte* ai_fqdn;
}

struct addrinfoex2W
{
    int ai_flags;
    int ai_family;
    int ai_socktype;
    int ai_protocol;
    uint ai_addrlen;
    const(wchar)* ai_canonname;
    SOCKADDR* ai_addr;
    void* ai_blob;
    uint ai_bloblen;
    Guid* ai_provider;
    addrinfoex2W* ai_next;
    int ai_version;
    const(wchar)* ai_fqdn;
}

struct addrinfoex3
{
    int ai_flags;
    int ai_family;
    int ai_socktype;
    int ai_protocol;
    uint ai_addrlen;
    const(wchar)* ai_canonname;
    SOCKADDR* ai_addr;
    void* ai_blob;
    uint ai_bloblen;
    Guid* ai_provider;
    addrinfoex3* ai_next;
    int ai_version;
    const(wchar)* ai_fqdn;
    int ai_interfaceindex;
}

struct addrinfoex4
{
    int ai_flags;
    int ai_family;
    int ai_socktype;
    int ai_protocol;
    uint ai_addrlen;
    const(wchar)* ai_canonname;
    SOCKADDR* ai_addr;
    void* ai_blob;
    uint ai_bloblen;
    Guid* ai_provider;
    addrinfoex4* ai_next;
    int ai_version;
    const(wchar)* ai_fqdn;
    int ai_interfaceindex;
    HANDLE ai_resolutionhandle;
}

struct fd_set
{
    uint fd_count;
    uint fd_array;
}

struct timeval
{
    int tv_sec;
    int tv_usec;
}

struct hostent
{
    byte* h_name;
    byte** h_aliases;
    short h_addrtype;
    short h_length;
    byte** h_addr_list;
}

struct netent
{
    byte* n_name;
    byte** n_aliases;
    short n_addrtype;
    uint n_net;
}

struct servent
{
    byte* s_name;
    byte** s_aliases;
    short s_port;
    byte* s_proto;
}

struct protoent
{
    byte* p_name;
    byte** p_aliases;
    short p_proto;
}

struct WSAData
{
    ushort wVersion;
    ushort wHighVersion;
    byte szDescription;
    byte szSystemStatus;
    ushort iMaxSockets;
    ushort iMaxUdpDg;
    byte* lpVendorInfo;
}

struct sockproto
{
    ushort sp_family;
    ushort sp_protocol;
}

struct linger
{
    ushort l_onoff;
    ushort l_linger;
}

struct WSANETWORKEVENTS
{
    int lNetworkEvents;
    int iErrorCode;
}

struct WSAPROTOCOLCHAIN
{
    int ChainLen;
    uint ChainEntries;
}

struct WSAPROTOCOL_INFOA
{
    uint dwServiceFlags1;
    uint dwServiceFlags2;
    uint dwServiceFlags3;
    uint dwServiceFlags4;
    uint dwProviderFlags;
    Guid ProviderId;
    uint dwCatalogEntryId;
    WSAPROTOCOLCHAIN ProtocolChain;
    int iVersion;
    int iAddressFamily;
    int iMaxSockAddr;
    int iMinSockAddr;
    int iSocketType;
    int iProtocol;
    int iProtocolMaxOffset;
    int iNetworkByteOrder;
    int iSecurityScheme;
    uint dwMessageSize;
    uint dwProviderReserved;
    byte szProtocol;
}

struct WSAPROTOCOL_INFOW
{
    uint dwServiceFlags1;
    uint dwServiceFlags2;
    uint dwServiceFlags3;
    uint dwServiceFlags4;
    uint dwProviderFlags;
    Guid ProviderId;
    uint dwCatalogEntryId;
    WSAPROTOCOLCHAIN ProtocolChain;
    int iVersion;
    int iAddressFamily;
    int iMaxSockAddr;
    int iMinSockAddr;
    int iSocketType;
    int iProtocol;
    int iProtocolMaxOffset;
    int iNetworkByteOrder;
    int iSecurityScheme;
    uint dwMessageSize;
    uint dwProviderReserved;
    ushort szProtocol;
}

alias LPCONDITIONPROC = extern(Windows) int function(WSABUF* lpCallerId, WSABUF* lpCallerData, QOS* lpSQOS, QOS* lpGQOS, WSABUF* lpCalleeId, WSABUF* lpCalleeData, uint* g, uint dwCallbackData);
alias LPWSAOVERLAPPED_COMPLETION_ROUTINE = extern(Windows) void function(uint dwError, uint cbTransferred, OVERLAPPED* lpOverlapped, uint dwFlags);
enum WSACOMPLETIONTYPE
{
    NSP_NOTIFY_IMMEDIATELY = 0,
    NSP_NOTIFY_HWND = 1,
    NSP_NOTIFY_EVENT = 2,
    NSP_NOTIFY_PORT = 3,
    NSP_NOTIFY_APC = 4,
}

struct WSACOMPLETION
{
    WSACOMPLETIONTYPE Type;
    _Parameters_e__Union Parameters;
}

struct AFPROTOCOLS
{
    int iAddressFamily;
    int iProtocol;
}

enum WSAECOMPARATOR
{
    COMP_EQUAL = 0,
    COMP_NOTLESS = 1,
}

struct WSAVERSION
{
    uint dwVersion;
    WSAECOMPARATOR ecHow;
}

struct WSAQUERYSETA
{
    uint dwSize;
    const(char)* lpszServiceInstanceName;
    Guid* lpServiceClassId;
    WSAVERSION* lpVersion;
    const(char)* lpszComment;
    uint dwNameSpace;
    Guid* lpNSProviderId;
    const(char)* lpszContext;
    uint dwNumberOfProtocols;
    AFPROTOCOLS* lpafpProtocols;
    const(char)* lpszQueryString;
    uint dwNumberOfCsAddrs;
    CSADDR_INFO* lpcsaBuffer;
    uint dwOutputFlags;
    BLOB* lpBlob;
}

struct WSAQUERYSETW
{
    uint dwSize;
    const(wchar)* lpszServiceInstanceName;
    Guid* lpServiceClassId;
    WSAVERSION* lpVersion;
    const(wchar)* lpszComment;
    uint dwNameSpace;
    Guid* lpNSProviderId;
    const(wchar)* lpszContext;
    uint dwNumberOfProtocols;
    AFPROTOCOLS* lpafpProtocols;
    const(wchar)* lpszQueryString;
    uint dwNumberOfCsAddrs;
    CSADDR_INFO* lpcsaBuffer;
    uint dwOutputFlags;
    BLOB* lpBlob;
}

struct WSAQUERYSET2A
{
    uint dwSize;
    const(char)* lpszServiceInstanceName;
    WSAVERSION* lpVersion;
    const(char)* lpszComment;
    uint dwNameSpace;
    Guid* lpNSProviderId;
    const(char)* lpszContext;
    uint dwNumberOfProtocols;
    AFPROTOCOLS* lpafpProtocols;
    const(char)* lpszQueryString;
    uint dwNumberOfCsAddrs;
    CSADDR_INFO* lpcsaBuffer;
    uint dwOutputFlags;
    BLOB* lpBlob;
}

struct WSAQUERYSET2W
{
    uint dwSize;
    const(wchar)* lpszServiceInstanceName;
    WSAVERSION* lpVersion;
    const(wchar)* lpszComment;
    uint dwNameSpace;
    Guid* lpNSProviderId;
    const(wchar)* lpszContext;
    uint dwNumberOfProtocols;
    AFPROTOCOLS* lpafpProtocols;
    const(wchar)* lpszQueryString;
    uint dwNumberOfCsAddrs;
    CSADDR_INFO* lpcsaBuffer;
    uint dwOutputFlags;
    BLOB* lpBlob;
}

enum WSAESETSERVICEOP
{
    RNRSERVICE_REGISTER = 0,
    RNRSERVICE_DEREGISTER = 1,
    RNRSERVICE_DELETE = 2,
}

struct WSANSCLASSINFOA
{
    const(char)* lpszName;
    uint dwNameSpace;
    uint dwValueType;
    uint dwValueSize;
    void* lpValue;
}

struct WSANSCLASSINFOW
{
    const(wchar)* lpszName;
    uint dwNameSpace;
    uint dwValueType;
    uint dwValueSize;
    void* lpValue;
}

struct WSASERVICECLASSINFOA
{
    Guid* lpServiceClassId;
    const(char)* lpszServiceClassName;
    uint dwCount;
    WSANSCLASSINFOA* lpClassInfos;
}

struct WSASERVICECLASSINFOW
{
    Guid* lpServiceClassId;
    const(wchar)* lpszServiceClassName;
    uint dwCount;
    WSANSCLASSINFOW* lpClassInfos;
}

struct WSANAMESPACE_INFOA
{
    Guid NSProviderId;
    uint dwNameSpace;
    BOOL fActive;
    uint dwVersion;
    const(char)* lpszIdentifier;
}

struct WSANAMESPACE_INFOW
{
    Guid NSProviderId;
    uint dwNameSpace;
    BOOL fActive;
    uint dwVersion;
    const(wchar)* lpszIdentifier;
}

struct WSANAMESPACE_INFOEXA
{
    Guid NSProviderId;
    uint dwNameSpace;
    BOOL fActive;
    uint dwVersion;
    const(char)* lpszIdentifier;
    BLOB ProviderSpecific;
}

struct WSANAMESPACE_INFOEXW
{
    Guid NSProviderId;
    uint dwNameSpace;
    BOOL fActive;
    uint dwVersion;
    const(wchar)* lpszIdentifier;
    BLOB ProviderSpecific;
}

struct WSAPOLLFD
{
    uint fd;
    short events;
    short revents;
}

struct in6_addr
{
    _u_e__Union u;
}

struct sockaddr_in6_old
{
    short sin6_family;
    ushort sin6_port;
    uint sin6_flowinfo;
    in6_addr sin6_addr;
}

struct sockaddr_gen
{
    SOCKADDR Address;
    sockaddr_in AddressIn;
    sockaddr_in6_old AddressIn6;
}

struct INTERFACE_INFO
{
    uint iiFlags;
    sockaddr_gen iiAddress;
    sockaddr_gen iiBroadcastAddress;
    sockaddr_gen iiNetmask;
}

struct INTERFACE_INFO_EX
{
    uint iiFlags;
    SOCKET_ADDRESS iiAddress;
    SOCKET_ADDRESS iiBroadcastAddress;
    SOCKET_ADDRESS iiNetmask;
}

enum PMTUD_STATE
{
    IP_PMTUDISC_NOT_SET = 0,
    IP_PMTUDISC_DO = 1,
    IP_PMTUDISC_DONT = 2,
    IP_PMTUDISC_PROBE = 3,
    IP_PMTUDISC_MAX = 4,
}

struct sockaddr_in6_w2ksp1
{
    short sin6_family;
    ushort sin6_port;
    uint sin6_flowinfo;
    in6_addr sin6_addr;
    uint sin6_scope_id;
}

enum MULTICAST_MODE_TYPE
{
    MCAST_INCLUDE = 0,
    MCAST_EXCLUDE = 1,
}

struct ip_mreq
{
    in_addr imr_multiaddr;
    in_addr imr_interface;
}

struct ip_mreq_source
{
    in_addr imr_multiaddr;
    in_addr imr_sourceaddr;
    in_addr imr_interface;
}

struct ip_msfilter
{
    in_addr imsf_multiaddr;
    in_addr imsf_interface;
    MULTICAST_MODE_TYPE imsf_fmode;
    uint imsf_numsrc;
    in_addr imsf_slist;
}

struct ipv6_mreq
{
    in6_addr ipv6mr_multiaddr;
    uint ipv6mr_interface;
}

struct group_req
{
    uint gr_interface;
    SOCKADDR_STORAGE_LH gr_group;
}

struct group_source_req
{
    uint gsr_interface;
    SOCKADDR_STORAGE_LH gsr_group;
    SOCKADDR_STORAGE_LH gsr_source;
}

struct group_filter
{
    uint gf_interface;
    SOCKADDR_STORAGE_LH gf_group;
    MULTICAST_MODE_TYPE gf_fmode;
    uint gf_numsrc;
    SOCKADDR_STORAGE_LH gf_slist;
}

struct in_pktinfo
{
    in_addr ipi_addr;
    uint ipi_ifindex;
}

struct in6_pktinfo
{
    in6_addr ipi6_addr;
    uint ipi6_ifindex;
}

struct in_pktinfo_ex
{
    in_pktinfo pkt_info;
    SCOPE_ID scope_id;
}

struct in6_pktinfo_ex
{
    in6_pktinfo pkt_info;
    SCOPE_ID scope_id;
}

struct in_recverr
{
    IPPROTO protocol;
    uint info;
    ubyte type;
    ubyte code;
}

struct icmp_error_info
{
    SOCKADDR_INET srcaddress;
    IPPROTO protocol;
    ubyte type;
    ubyte code;
}

enum eWINDOW_ADVANCE_METHOD
{
    E_WINDOW_ADVANCE_BY_TIME = 1,
    E_WINDOW_USE_AS_DATA_CACHE = 2,
}

struct RM_SEND_WINDOW
{
    uint RateKbitsPerSec;
    uint WindowSizeInMSecs;
    uint WindowSizeInBytes;
}

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

struct RM_FEC_INFO
{
    ushort FECBlockSize;
    ushort FECProActivePackets;
    ubyte FECGroupSize;
    ubyte fFECOnDemandParityEnabled;
}

struct IPX_ADDRESS_DATA
{
    int adapternum;
    ubyte netnum;
    ubyte nodenum;
    ubyte wan;
    ubyte status;
    int maxpkt;
    uint linkspeed;
}

struct IPX_NETNUM_DATA
{
    ubyte netnum;
    ushort hopcount;
    ushort netdelay;
    int cardnum;
    ubyte router;
}

struct IPX_SPXCONNSTATUS_DATA
{
    ubyte ConnectionState;
    ubyte WatchDogActive;
    ushort LocalConnectionId;
    ushort RemoteConnectionId;
    ushort LocalSequenceNumber;
    ushort LocalAckNumber;
    ushort LocalAllocNumber;
    ushort RemoteAckNumber;
    ushort RemoteAllocNumber;
    ushort LocalSocket;
    ubyte ImmediateAddress;
    ubyte RemoteNetwork;
    ubyte RemoteNode;
    ushort RemoteSocket;
    ushort RetransmissionCount;
    ushort EstimatedRoundTripDelay;
    ushort RetransmittedPackets;
    ushort SuppressedPacket;
}

struct LM_IRPARMS
{
    uint nTXDataBytes;
    uint nRXDataBytes;
    uint nBaudRate;
    uint thresholdTime;
    uint discTime;
    ushort nMSLinkTurn;
    ubyte nTXPackets;
    ubyte nRXPackets;
}

struct SOCKADDR_IRDA
{
    ushort irdaAddressFamily;
    ubyte irdaDeviceID;
    byte irdaServiceName;
}

struct WINDOWS_IRDA_DEVICE_INFO
{
    ubyte irdaDeviceID;
    byte irdaDeviceName;
    ubyte irdaDeviceHints1;
    ubyte irdaDeviceHints2;
    ubyte irdaCharSet;
}

struct WCE_IRDA_DEVICE_INFO
{
    ubyte irdaDeviceID;
    byte irdaDeviceName;
    ubyte Reserved;
}

struct WINDOWS_DEVICELIST
{
    uint numDevice;
    WINDOWS_IRDA_DEVICE_INFO Device;
}

struct WCE_DEVICELIST
{
    uint numDevice;
    WCE_IRDA_DEVICE_INFO Device;
}

struct WINDOWS_IAS_SET
{
    byte irdaClassName;
    byte irdaAttribName;
    uint irdaAttribType;
    _irdaAttribute_e__Union irdaAttribute;
}

struct WINDOWS_IAS_QUERY
{
    ubyte irdaDeviceID;
    byte irdaClassName;
    byte irdaAttribName;
    uint irdaAttribType;
    _irdaAttribute_e__Union irdaAttribute;
}

enum NL_BANDWIDTH_FLAG
{
    NlbwDisabled = 0,
    NlbwEnabled = 1,
    NlbwUnchanged = -1,
}

struct NL_PATH_BANDWIDTH_ROD
{
    ulong Bandwidth;
    ulong Instability;
    ubyte BandwidthPeaked;
}

enum NL_NETWORK_CATEGORY
{
    NetworkCategoryPublic = 0,
    NetworkCategoryPrivate = 1,
    NetworkCategoryDomainAuthenticated = 2,
    NetworkCategoryUnchanged = -1,
    NetworkCategoryUnknown = -1,
}

enum NL_INTERFACE_NETWORK_CATEGORY_STATE
{
    NlincCategoryUnknown = 0,
    NlincPublic = 1,
    NlincPrivate = 2,
    NlincDomainAuthenticated = 3,
    NlincCategoryStateMax = 4,
}

enum TCPSTATE
{
    TCPSTATE_CLOSED = 0,
    TCPSTATE_LISTEN = 1,
    TCPSTATE_SYN_SENT = 2,
    TCPSTATE_SYN_RCVD = 3,
    TCPSTATE_ESTABLISHED = 4,
    TCPSTATE_FIN_WAIT_1 = 5,
    TCPSTATE_FIN_WAIT_2 = 6,
    TCPSTATE_CLOSE_WAIT = 7,
    TCPSTATE_CLOSING = 8,
    TCPSTATE_LAST_ACK = 9,
    TCPSTATE_TIME_WAIT = 10,
    TCPSTATE_MAX = 11,
}

struct TRANSPORT_SETTING_ID
{
    Guid Guid;
}

struct tcp_keepalive
{
    uint onoff;
    uint keepalivetime;
    uint keepaliveinterval;
}

enum CONTROL_CHANNEL_TRIGGER_STATUS
{
    CONTROL_CHANNEL_TRIGGER_STATUS_INVALID = 0,
    CONTROL_CHANNEL_TRIGGER_STATUS_SOFTWARE_SLOT_ALLOCATED = 1,
    CONTROL_CHANNEL_TRIGGER_STATUS_HARDWARE_SLOT_ALLOCATED = 2,
    CONTROL_CHANNEL_TRIGGER_STATUS_POLICY_ERROR = 3,
    CONTROL_CHANNEL_TRIGGER_STATUS_SYSTEM_ERROR = 4,
    CONTROL_CHANNEL_TRIGGER_STATUS_TRANSPORT_DISCONNECTED = 5,
    CONTROL_CHANNEL_TRIGGER_STATUS_SERVICE_UNAVAILABLE = 6,
}

struct REAL_TIME_NOTIFICATION_SETTING_INPUT
{
    TRANSPORT_SETTING_ID TransportSettingId;
    Guid BrokerEventGuid;
}

struct REAL_TIME_NOTIFICATION_SETTING_INPUT_EX
{
    TRANSPORT_SETTING_ID TransportSettingId;
    Guid BrokerEventGuid;
    ubyte Unmark;
}

struct REAL_TIME_NOTIFICATION_SETTING_OUTPUT
{
    CONTROL_CHANNEL_TRIGGER_STATUS ChannelStatus;
}

struct ASSOCIATE_NAMERES_CONTEXT_INPUT
{
    TRANSPORT_SETTING_ID TransportSettingId;
    ulong Handle;
}

enum RCVALL_VALUE
{
    RCVALL_OFF = 0,
    RCVALL_ON = 1,
    RCVALL_SOCKETLEVELONLY = 2,
    RCVALL_IPLEVEL = 3,
}

struct RCVALL_IF
{
    RCVALL_VALUE Mode;
    uint Interface;
}

struct TCP_INITIAL_RTO_PARAMETERS
{
    ushort Rtt;
    ubyte MaxSynRetransmissions;
}

enum TCP_ICW_LEVEL
{
    TCP_ICW_LEVEL_DEFAULT = 0,
    TCP_ICW_LEVEL_HIGH = 1,
    TCP_ICW_LEVEL_VERY_HIGH = 2,
    TCP_ICW_LEVEL_AGGRESSIVE = 3,
    TCP_ICW_LEVEL_EXPERIMENTAL = 4,
    TCP_ICW_LEVEL_COMPAT = 254,
    TCP_ICW_LEVEL_MAX = 255,
}

struct TCP_ICW_PARAMETERS
{
    TCP_ICW_LEVEL Level;
}

struct TCP_ACK_FREQUENCY_PARAMETERS
{
    ubyte TcpDelayedAckFrequency;
}

struct TCP_INFO_v0
{
    TCPSTATE State;
    uint Mss;
    ulong ConnectionTimeMs;
    ubyte TimestampsEnabled;
    uint RttUs;
    uint MinRttUs;
    uint BytesInFlight;
    uint Cwnd;
    uint SndWnd;
    uint RcvWnd;
    uint RcvBuf;
    ulong BytesOut;
    ulong BytesIn;
    uint BytesReordered;
    uint BytesRetrans;
    uint FastRetrans;
    uint DupAcksIn;
    uint TimeoutEpisodes;
    ubyte SynRetrans;
}

struct TCP_INFO_v1
{
    TCPSTATE State;
    uint Mss;
    ulong ConnectionTimeMs;
    ubyte TimestampsEnabled;
    uint RttUs;
    uint MinRttUs;
    uint BytesInFlight;
    uint Cwnd;
    uint SndWnd;
    uint RcvWnd;
    uint RcvBuf;
    ulong BytesOut;
    ulong BytesIn;
    uint BytesReordered;
    uint BytesRetrans;
    uint FastRetrans;
    uint DupAcksIn;
    uint TimeoutEpisodes;
    ubyte SynRetrans;
    uint SndLimTransRwin;
    uint SndLimTimeRwin;
    ulong SndLimBytesRwin;
    uint SndLimTransCwnd;
    uint SndLimTimeCwnd;
    ulong SndLimBytesCwnd;
    uint SndLimTransSnd;
    uint SndLimTimeSnd;
    ulong SndLimBytesSnd;
}

struct INET_PORT_RANGE
{
    ushort StartPort;
    ushort NumberOfPorts;
}

struct INET_PORT_RESERVATION_TOKEN
{
    ulong Token;
}

struct INET_PORT_RESERVATION_INSTANCE
{
    INET_PORT_RANGE Reservation;
    INET_PORT_RESERVATION_TOKEN Token;
}

struct INET_PORT_RESERVATION_INFORMATION
{
    uint OwningPid;
}

enum SOCKET_USAGE_TYPE
{
    SYSTEM_CRITICAL_SOCKET = 1,
}

enum SOCKET_SECURITY_PROTOCOL
{
    SOCKET_SECURITY_PROTOCOL_DEFAULT = 0,
    SOCKET_SECURITY_PROTOCOL_IPSEC = 1,
    SOCKET_SECURITY_PROTOCOL_IPSEC2 = 2,
    SOCKET_SECURITY_PROTOCOL_INVALID = 3,
}

struct SOCKET_SECURITY_SETTINGS
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    uint SecurityFlags;
}

struct SOCKET_SECURITY_SETTINGS_IPSEC
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    uint SecurityFlags;
    uint IpsecFlags;
    Guid AuthipMMPolicyKey;
    Guid AuthipQMPolicyKey;
    Guid Reserved;
    ulong Reserved2;
    uint UserNameStringLen;
    uint DomainNameStringLen;
    uint PasswordStringLen;
    ushort AllStrings;
}

struct SOCKET_PEER_TARGET_NAME
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    SOCKADDR_STORAGE_LH PeerAddress;
    uint PeerTargetNameStringLen;
    ushort AllStrings;
}

struct SOCKET_SECURITY_QUERY_TEMPLATE
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    SOCKADDR_STORAGE_LH PeerAddress;
    uint PeerTokenAccessMask;
}

struct SOCKET_SECURITY_QUERY_TEMPLATE_IPSEC2
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    SOCKADDR_STORAGE_LH PeerAddress;
    uint PeerTokenAccessMask;
    uint Flags;
    uint FieldMask;
}

struct SOCKET_SECURITY_QUERY_INFO
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    uint Flags;
    ulong PeerApplicationAccessTokenHandle;
    ulong PeerMachineAccessTokenHandle;
}

struct SOCKET_SECURITY_QUERY_INFO_IPSEC2
{
    SOCKET_SECURITY_PROTOCOL SecurityProtocol;
    uint Flags;
    ulong PeerApplicationAccessTokenHandle;
    ulong PeerMachineAccessTokenHandle;
    ulong MmSaId;
    ulong QmSaId;
    uint NegotiationWinerr;
    Guid SaLookupContext;
}

struct RSS_SCALABILITY_INFO
{
    ubyte RssEnabled;
}

enum WSA_COMPATIBILITY_BEHAVIOR_ID
{
    WsaBehaviorAll = 0,
    WsaBehaviorReceiveBuffering = 1,
    WsaBehaviorAutoTuning = 2,
}

struct WSA_COMPATIBILITY_MODE
{
    WSA_COMPATIBILITY_BEHAVIOR_ID BehaviorId;
    uint TargetOsVersion;
}

struct RIO_BUFFERID_t
{
}

struct RIO_CQ_t
{
}

struct RIO_RQ_t
{
}

struct RIORESULT
{
    int Status;
    uint BytesTransferred;
    ulong SocketContext;
    ulong RequestContext;
}

struct RIO_BUF
{
    RIO_BUFFERID_t* BufferId;
    uint Offset;
    uint Length;
}

struct RIO_CMSG_BUFFER
{
    uint TotalLength;
}

struct ATM_ADDRESS
{
    uint AddressType;
    uint NumofDigits;
    ubyte Addr;
}

struct ATM_BLLI
{
    uint Layer2Protocol;
    uint Layer2UserSpecifiedProtocol;
    uint Layer3Protocol;
    uint Layer3UserSpecifiedProtocol;
    uint Layer3IPI;
    ubyte SnapID;
}

struct ATM_BHLI
{
    uint HighLayerInfoType;
    uint HighLayerInfoLength;
    ubyte HighLayerInfo;
}

struct sockaddr_atm
{
    ushort satm_family;
    ATM_ADDRESS satm_number;
    ATM_BLLI satm_blli;
    ATM_BHLI satm_bhli;
}

enum Q2931_IE_TYPE
{
    IE_AALParameters = 0,
    IE_TrafficDescriptor = 1,
    IE_BroadbandBearerCapability = 2,
    IE_BHLI = 3,
    IE_BLLI = 4,
    IE_CalledPartyNumber = 5,
    IE_CalledPartySubaddress = 6,
    IE_CallingPartyNumber = 7,
    IE_CallingPartySubaddress = 8,
    IE_Cause = 9,
    IE_QOSClass = 10,
    IE_TransitNetworkSelection = 11,
}

struct Q2931_IE
{
    Q2931_IE_TYPE IEType;
    uint IELength;
    ubyte IE;
}

enum AAL_TYPE
{
    AALTYPE_5 = 5,
    AALTYPE_USER = 16,
}

struct AAL5_PARAMETERS
{
    uint ForwardMaxCPCSSDUSize;
    uint BackwardMaxCPCSSDUSize;
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
    _AALSpecificParameters_e__Union AALSpecificParameters;
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
    BOOL BestEffort;
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
    uint Layer2Protocol;
    ubyte Layer2Mode;
    ubyte Layer2WindowSize;
    uint Layer2UserSpecifiedProtocol;
    uint Layer3Protocol;
    ubyte Layer3Mode;
    ubyte Layer3DefaultPacketSize;
    ubyte Layer3PacketWindowSize;
    uint Layer3UserSpecifiedProtocol;
    uint Layer3IPI;
    ubyte SnapID;
}

struct ATM_CALLING_PARTY_NUMBER_IE
{
    ATM_ADDRESS ATM_Number;
    ubyte Presentation_Indication;
    ubyte Screening_Indicator;
}

struct ATM_CAUSE_IE
{
    ubyte Location;
    ubyte Cause;
    ubyte DiagnosticsLength;
    ubyte Diagnostics;
}

struct ATM_QOS_CLASS_IE
{
    ubyte QOSClassForward;
    ubyte QOSClassBackward;
}

struct ATM_TRANSIT_NETWORK_SELECTION_IE
{
    ubyte TypeOfNetworkId;
    ubyte NetworkIdPlan;
    ubyte NetworkIdLength;
    ubyte NetworkId;
}

struct ATM_CONNECTION_ID
{
    uint DeviceNumber;
    uint VPI;
    uint VCI;
}

struct ATM_PVC_PARAMS
{
    ATM_CONNECTION_ID PvcConnectionId;
    QOS PvcQos;
}

enum NAPI_PROVIDER_TYPE
{
    ProviderType_Application = 1,
    ProviderType_Service = 2,
}

enum NAPI_PROVIDER_LEVEL
{
    ProviderLevel_None = 0,
    ProviderLevel_Secondary = 1,
    ProviderLevel_Primary = 2,
}

struct NAPI_DOMAIN_DESCRIPTION_BLOB
{
    uint AuthLevel;
    uint cchDomainName;
    uint OffsetNextDomainDescription;
    uint OffsetThisDomainName;
}

struct NAPI_PROVIDER_INSTALLATION_BLOB
{
    uint dwVersion;
    uint dwProviderType;
    uint fSupportsWildCard;
    uint cDomains;
    uint OffsetFirstDomain;
}

struct TRANSMIT_FILE_BUFFERS
{
    void* Head;
    uint HeadLength;
    void* Tail;
    uint TailLength;
}

alias LPFN_TRANSMITFILE = extern(Windows) BOOL function(uint hSocket, HANDLE hFile, uint nNumberOfBytesToWrite, uint nNumberOfBytesPerSend, OVERLAPPED* lpOverlapped, TRANSMIT_FILE_BUFFERS* lpTransmitBuffers, uint dwReserved);
alias LPFN_ACCEPTEX = extern(Windows) BOOL function(uint sListenSocket, uint sAcceptSocket, char* lpOutputBuffer, uint dwReceiveDataLength, uint dwLocalAddressLength, uint dwRemoteAddressLength, uint* lpdwBytesReceived, OVERLAPPED* lpOverlapped);
alias LPFN_GETACCEPTEXSOCKADDRS = extern(Windows) void function(char* lpOutputBuffer, uint dwReceiveDataLength, uint dwLocalAddressLength, uint dwRemoteAddressLength, SOCKADDR** LocalSockaddr, int* LocalSockaddrLength, SOCKADDR** RemoteSockaddr, int* RemoteSockaddrLength);
struct TRANSMIT_PACKETS_ELEMENT
{
    uint dwElFlags;
    uint cLength;
    _Anonymous_e__Union Anonymous;
}

alias LPFN_TRANSMITPACKETS = extern(Windows) BOOL function(uint hSocket, TRANSMIT_PACKETS_ELEMENT* lpPacketArray, uint nElementCount, uint nSendSize, OVERLAPPED* lpOverlapped, uint dwFlags);
alias LPFN_CONNECTEX = extern(Windows) BOOL function(uint s, char* name, int namelen, char* lpSendBuffer, uint dwSendDataLength, uint* lpdwBytesSent, OVERLAPPED* lpOverlapped);
alias LPFN_DISCONNECTEX = extern(Windows) BOOL function(uint s, OVERLAPPED* lpOverlapped, uint dwFlags, uint dwReserved);
enum NLA_BLOB_DATA_TYPE
{
    NLA_RAW_DATA = 0,
    NLA_INTERFACE = 1,
    NLA_802_1X_LOCATION = 2,
    NLA_CONNECTIVITY = 3,
    NLA_ICS = 4,
}

enum NLA_CONNECTIVITY_TYPE
{
    NLA_NETWORK_AD_HOC = 0,
    NLA_NETWORK_MANAGED = 1,
    NLA_NETWORK_UNMANAGED = 2,
    NLA_NETWORK_UNKNOWN = 3,
}

enum NLA_INTERNET
{
    NLA_INTERNET_UNKNOWN = 0,
    NLA_INTERNET_NO = 1,
    NLA_INTERNET_YES = 2,
}

struct NLA_BLOB
{
    _header_e__Struct header;
    _data_e__Union data;
}

alias LPFN_WSARECVMSG = extern(Windows) int function(uint s, WSAMSG* lpMsg, uint* lpdwNumberOfBytesRecvd, OVERLAPPED* lpOverlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);
struct WSAPOLLDATA
{
    int result;
    uint fds;
    int timeout;
    WSAPOLLFD fdArray;
}

struct WSASENDMSG
{
    WSAMSG* lpMsg;
    uint dwFlags;
    uint* lpNumberOfBytesSent;
    OVERLAPPED* lpOverlapped;
    LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine;
}

alias LPFN_WSASENDMSG = extern(Windows) int function(uint s, WSAMSG* lpMsg, uint dwFlags, uint* lpNumberOfBytesSent, OVERLAPPED* lpOverlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);
alias LPFN_WSAPOLL = extern(Windows) int function(WSAPOLLFD* fdarray, uint nfds, int timeout);
alias LPFN_RIORECEIVE = extern(Windows) BOOL function(RIO_RQ_t* SocketQueue, char* pData, uint DataBufferCount, uint Flags, void* RequestContext);
alias LPFN_RIORECEIVEEX = extern(Windows) int function(RIO_RQ_t* SocketQueue, char* pData, uint DataBufferCount, RIO_BUF* pLocalAddress, RIO_BUF* pRemoteAddress, RIO_BUF* pControlContext, RIO_BUF* pFlags, uint Flags, void* RequestContext);
alias LPFN_RIOSEND = extern(Windows) BOOL function(RIO_RQ_t* SocketQueue, char* pData, uint DataBufferCount, uint Flags, void* RequestContext);
alias LPFN_RIOSENDEX = extern(Windows) BOOL function(RIO_RQ_t* SocketQueue, char* pData, uint DataBufferCount, RIO_BUF* pLocalAddress, RIO_BUF* pRemoteAddress, RIO_BUF* pControlContext, RIO_BUF* pFlags, uint Flags, void* RequestContext);
alias LPFN_RIOCLOSECOMPLETIONQUEUE = extern(Windows) void function(RIO_CQ_t* CQ);
enum RIO_NOTIFICATION_COMPLETION_TYPE
{
    RIO_EVENT_COMPLETION = 1,
    RIO_IOCP_COMPLETION = 2,
}

struct RIO_NOTIFICATION_COMPLETION
{
    RIO_NOTIFICATION_COMPLETION_TYPE Type;
    _Anonymous_e__Union Anonymous;
}

alias LPFN_RIOCREATECOMPLETIONQUEUE = extern(Windows) RIO_CQ_t* function(uint QueueSize, RIO_NOTIFICATION_COMPLETION* NotificationCompletion);
alias LPFN_RIOCREATEREQUESTQUEUE = extern(Windows) RIO_RQ_t* function(uint Socket, uint MaxOutstandingReceive, uint MaxReceiveDataBuffers, uint MaxOutstandingSend, uint MaxSendDataBuffers, RIO_CQ_t* ReceiveCQ, RIO_CQ_t* SendCQ, void* SocketContext);
alias LPFN_RIODEQUEUECOMPLETION = extern(Windows) uint function(RIO_CQ_t* CQ, char* Array, uint ArraySize);
alias LPFN_RIODEREGISTERBUFFER = extern(Windows) void function(RIO_BUFFERID_t* BufferId);
alias LPFN_RIONOTIFY = extern(Windows) int function(RIO_CQ_t* CQ);
alias LPFN_RIOREGISTERBUFFER = extern(Windows) RIO_BUFFERID_t* function(const(char)* DataBuffer, uint DataLength);
alias LPFN_RIORESIZECOMPLETIONQUEUE = extern(Windows) BOOL function(RIO_CQ_t* CQ, uint QueueSize);
alias LPFN_RIORESIZEREQUESTQUEUE = extern(Windows) BOOL function(RIO_RQ_t* RQ, uint MaxOutstandingReceive, uint MaxOutstandingSend);
struct RIO_EXTENSION_FUNCTION_TABLE
{
    uint cbSize;
    LPFN_RIORECEIVE RIOReceive;
    LPFN_RIORECEIVEEX RIOReceiveEx;
    LPFN_RIOSEND RIOSend;
    LPFN_RIOSENDEX RIOSendEx;
    LPFN_RIOCLOSECOMPLETIONQUEUE RIOCloseCompletionQueue;
    LPFN_RIOCREATECOMPLETIONQUEUE RIOCreateCompletionQueue;
    LPFN_RIOCREATEREQUESTQUEUE RIOCreateRequestQueue;
    LPFN_RIODEQUEUECOMPLETION RIODequeueCompletion;
    LPFN_RIODEREGISTERBUFFER RIODeregisterBuffer;
    LPFN_RIONOTIFY RIONotify;
    LPFN_RIOREGISTERBUFFER RIORegisterBuffer;
    LPFN_RIORESIZECOMPLETIONQUEUE RIOResizeCompletionQueue;
    LPFN_RIORESIZEREQUESTQUEUE RIOResizeRequestQueue;
}

struct WSPData
{
    ushort wVersion;
    ushort wHighVersion;
    ushort szDescription;
}

struct WSATHREADID
{
    HANDLE ThreadHandle;
    uint Reserved;
}

alias LPBLOCKINGCALLBACK = extern(Windows) BOOL function(uint dwContext);
alias LPWSAUSERAPC = extern(Windows) void function(uint dwContext);
alias LPWSPACCEPT = extern(Windows) uint function(uint s, char* addr, int* addrlen, LPCONDITIONPROC lpfnCondition, uint dwCallbackData, int* lpErrno);
alias LPWSPADDRESSTOSTRING = extern(Windows) int function(char* lpsaAddress, uint dwAddressLength, WSAPROTOCOL_INFOW* lpProtocolInfo, const(wchar)* lpszAddressString, uint* lpdwAddressStringLength, int* lpErrno);
alias LPWSPASYNCSELECT = extern(Windows) int function(uint s, HWND hWnd, uint wMsg, int lEvent, int* lpErrno);
alias LPWSPBIND = extern(Windows) int function(uint s, char* name, int namelen, int* lpErrno);
alias LPWSPCANCELBLOCKINGCALL = extern(Windows) int function(int* lpErrno);
alias LPWSPCLEANUP = extern(Windows) int function(int* lpErrno);
alias LPWSPCLOSESOCKET = extern(Windows) int function(uint s, int* lpErrno);
alias LPWSPCONNECT = extern(Windows) int function(uint s, char* name, int namelen, WSABUF* lpCallerData, WSABUF* lpCalleeData, QOS* lpSQOS, QOS* lpGQOS, int* lpErrno);
alias LPWSPDUPLICATESOCKET = extern(Windows) int function(uint s, uint dwProcessId, WSAPROTOCOL_INFOW* lpProtocolInfo, int* lpErrno);
alias LPWSPENUMNETWORKEVENTS = extern(Windows) int function(uint s, HANDLE hEventObject, WSANETWORKEVENTS* lpNetworkEvents, int* lpErrno);
alias LPWSPEVENTSELECT = extern(Windows) int function(uint s, HANDLE hEventObject, int lNetworkEvents, int* lpErrno);
alias LPWSPGETOVERLAPPEDRESULT = extern(Windows) BOOL function(uint s, OVERLAPPED* lpOverlapped, uint* lpcbTransfer, BOOL fWait, uint* lpdwFlags, int* lpErrno);
alias LPWSPGETPEERNAME = extern(Windows) int function(uint s, char* name, int* namelen, int* lpErrno);
alias LPWSPGETSOCKNAME = extern(Windows) int function(uint s, char* name, int* namelen, int* lpErrno);
alias LPWSPGETSOCKOPT = extern(Windows) int function(uint s, int level, int optname, char* optval, int* optlen, int* lpErrno);
alias LPWSPGETQOSBYNAME = extern(Windows) BOOL function(uint s, WSABUF* lpQOSName, QOS* lpQOS, int* lpErrno);
alias LPWSPIOCTL = extern(Windows) int function(uint s, uint dwIoControlCode, char* lpvInBuffer, uint cbInBuffer, char* lpvOutBuffer, uint cbOutBuffer, uint* lpcbBytesReturned, OVERLAPPED* lpOverlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine, WSATHREADID* lpThreadId, int* lpErrno);
alias LPWSPJOINLEAF = extern(Windows) uint function(uint s, char* name, int namelen, WSABUF* lpCallerData, WSABUF* lpCalleeData, QOS* lpSQOS, QOS* lpGQOS, uint dwFlags, int* lpErrno);
alias LPWSPLISTEN = extern(Windows) int function(uint s, int backlog, int* lpErrno);
alias LPWSPRECV = extern(Windows) int function(uint s, char* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesRecvd, uint* lpFlags, OVERLAPPED* lpOverlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine, WSATHREADID* lpThreadId, int* lpErrno);
alias LPWSPRECVDISCONNECT = extern(Windows) int function(uint s, WSABUF* lpInboundDisconnectData, int* lpErrno);
alias LPWSPRECVFROM = extern(Windows) int function(uint s, char* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesRecvd, uint* lpFlags, char* lpFrom, int* lpFromlen, OVERLAPPED* lpOverlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine, WSATHREADID* lpThreadId, int* lpErrno);
alias LPWSPSELECT = extern(Windows) int function(int nfds, fd_set* readfds, fd_set* writefds, fd_set* exceptfds, const(timeval)* timeout, int* lpErrno);
alias LPWSPSEND = extern(Windows) int function(uint s, char* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesSent, uint dwFlags, OVERLAPPED* lpOverlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine, WSATHREADID* lpThreadId, int* lpErrno);
alias LPWSPSENDDISCONNECT = extern(Windows) int function(uint s, WSABUF* lpOutboundDisconnectData, int* lpErrno);
alias LPWSPSENDTO = extern(Windows) int function(uint s, char* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesSent, uint dwFlags, char* lpTo, int iTolen, OVERLAPPED* lpOverlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine, WSATHREADID* lpThreadId, int* lpErrno);
alias LPWSPSETSOCKOPT = extern(Windows) int function(uint s, int level, int optname, char* optval, int optlen, int* lpErrno);
alias LPWSPSHUTDOWN = extern(Windows) int function(uint s, int how, int* lpErrno);
alias LPWSPSOCKET = extern(Windows) uint function(int af, int type, int protocol, WSAPROTOCOL_INFOW* lpProtocolInfo, uint g, uint dwFlags, int* lpErrno);
alias LPWSPSTRINGTOADDRESS = extern(Windows) int function(const(wchar)* AddressString, int AddressFamily, WSAPROTOCOL_INFOW* lpProtocolInfo, char* lpAddress, int* lpAddressLength, int* lpErrno);
struct WSPPROC_TABLE
{
    LPWSPACCEPT lpWSPAccept;
    LPWSPADDRESSTOSTRING lpWSPAddressToString;
    LPWSPASYNCSELECT lpWSPAsyncSelect;
    LPWSPBIND lpWSPBind;
    LPWSPCANCELBLOCKINGCALL lpWSPCancelBlockingCall;
    LPWSPCLEANUP lpWSPCleanup;
    LPWSPCLOSESOCKET lpWSPCloseSocket;
    LPWSPCONNECT lpWSPConnect;
    LPWSPDUPLICATESOCKET lpWSPDuplicateSocket;
    LPWSPENUMNETWORKEVENTS lpWSPEnumNetworkEvents;
    LPWSPEVENTSELECT lpWSPEventSelect;
    LPWSPGETOVERLAPPEDRESULT lpWSPGetOverlappedResult;
    LPWSPGETPEERNAME lpWSPGetPeerName;
    LPWSPGETSOCKNAME lpWSPGetSockName;
    LPWSPGETSOCKOPT lpWSPGetSockOpt;
    LPWSPGETQOSBYNAME lpWSPGetQOSByName;
    LPWSPIOCTL lpWSPIoctl;
    LPWSPJOINLEAF lpWSPJoinLeaf;
    LPWSPLISTEN lpWSPListen;
    LPWSPRECV lpWSPRecv;
    LPWSPRECVDISCONNECT lpWSPRecvDisconnect;
    LPWSPRECVFROM lpWSPRecvFrom;
    LPWSPSELECT lpWSPSelect;
    LPWSPSEND lpWSPSend;
    LPWSPSENDDISCONNECT lpWSPSendDisconnect;
    LPWSPSENDTO lpWSPSendTo;
    LPWSPSETSOCKOPT lpWSPSetSockOpt;
    LPWSPSHUTDOWN lpWSPShutdown;
    LPWSPSOCKET lpWSPSocket;
    LPWSPSTRINGTOADDRESS lpWSPStringToAddress;
}

alias LPWPUCLOSEEVENT = extern(Windows) BOOL function(HANDLE hEvent, int* lpErrno);
alias LPWPUCLOSESOCKETHANDLE = extern(Windows) int function(uint s, int* lpErrno);
alias LPWPUCREATEEVENT = extern(Windows) HANDLE function(int* lpErrno);
alias LPWPUCREATESOCKETHANDLE = extern(Windows) uint function(uint dwCatalogEntryId, uint dwContext, int* lpErrno);
alias LPWPUFDISSET = extern(Windows) int function(uint s, fd_set* fdset);
alias LPWPUGETPROVIDERPATH = extern(Windows) int function(Guid* lpProviderId, char* lpszProviderDllPath, int* lpProviderDllPathLen, int* lpErrno);
alias LPWPUMODIFYIFSHANDLE = extern(Windows) uint function(uint dwCatalogEntryId, uint ProposedHandle, int* lpErrno);
alias LPWPUPOSTMESSAGE = extern(Windows) BOOL function(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);
alias LPWPUQUERYBLOCKINGCALLBACK = extern(Windows) int function(uint dwCatalogEntryId, LPBLOCKINGCALLBACK* lplpfnCallback, uint* lpdwContext, int* lpErrno);
alias LPWPUQUERYSOCKETHANDLECONTEXT = extern(Windows) int function(uint s, uint* lpContext, int* lpErrno);
alias LPWPUQUEUEAPC = extern(Windows) int function(WSATHREADID* lpThreadId, LPWSAUSERAPC lpfnUserApc, uint dwContext, int* lpErrno);
alias LPWPURESETEVENT = extern(Windows) BOOL function(HANDLE hEvent, int* lpErrno);
alias LPWPUSETEVENT = extern(Windows) BOOL function(HANDLE hEvent, int* lpErrno);
alias LPWPUOPENCURRENTTHREAD = extern(Windows) int function(WSATHREADID* lpThreadId, int* lpErrno);
alias LPWPUCLOSETHREAD = extern(Windows) int function(WSATHREADID* lpThreadId, int* lpErrno);
alias LPWPUCOMPLETEOVERLAPPEDREQUEST = extern(Windows) int function(uint s, OVERLAPPED* lpOverlapped, uint dwError, uint cbTransferred, int* lpErrno);
struct WSPUPCALLTABLE
{
    LPWPUCLOSEEVENT lpWPUCloseEvent;
    LPWPUCLOSESOCKETHANDLE lpWPUCloseSocketHandle;
    LPWPUCREATEEVENT lpWPUCreateEvent;
    LPWPUCREATESOCKETHANDLE lpWPUCreateSocketHandle;
    LPWPUFDISSET lpWPUFDIsSet;
    LPWPUGETPROVIDERPATH lpWPUGetProviderPath;
    LPWPUMODIFYIFSHANDLE lpWPUModifyIFSHandle;
    LPWPUPOSTMESSAGE lpWPUPostMessage;
    LPWPUQUERYBLOCKINGCALLBACK lpWPUQueryBlockingCallback;
    LPWPUQUERYSOCKETHANDLECONTEXT lpWPUQuerySocketHandleContext;
    LPWPUQUEUEAPC lpWPUQueueApc;
    LPWPURESETEVENT lpWPUResetEvent;
    LPWPUSETEVENT lpWPUSetEvent;
    LPWPUOPENCURRENTTHREAD lpWPUOpenCurrentThread;
    LPWPUCLOSETHREAD lpWPUCloseThread;
}

alias LPWSPSTARTUP = extern(Windows) int function(ushort wVersionRequested, WSPData* lpWSPData, WSAPROTOCOL_INFOW* lpProtocolInfo, WSPUPCALLTABLE UpcallTable, WSPPROC_TABLE* lpProcTable);
alias LPWSCENUMPROTOCOLS = extern(Windows) int function(int* lpiProtocols, char* lpProtocolBuffer, uint* lpdwBufferLength, int* lpErrno);
alias LPWSCDEINSTALLPROVIDER = extern(Windows) int function(Guid* lpProviderId, int* lpErrno);
alias LPWSCINSTALLPROVIDER = extern(Windows) int function(Guid* lpProviderId, const(wchar)* lpszProviderDllPath, char* lpProtocolInfoList, uint dwNumberOfEntries, int* lpErrno);
alias LPWSCGETPROVIDERPATH = extern(Windows) int function(Guid* lpProviderId, char* lpszProviderDllPath, int* lpProviderDllPathLen, int* lpErrno);
alias LPWSCUPDATEPROVIDER = extern(Windows) int function(Guid* lpProviderId, const(wchar)* lpszProviderDllPath, char* lpProtocolInfoList, uint dwNumberOfEntries, int* lpErrno);
enum WSC_PROVIDER_INFO_TYPE
{
    ProviderInfoLspCategories = 0,
    ProviderInfoAudit = 1,
}

struct WSC_PROVIDER_AUDIT_INFO
{
    uint RecordSize;
    void* Reserved;
}

alias LPWSCINSTALLNAMESPACE = extern(Windows) int function(const(wchar)* lpszIdentifier, const(wchar)* lpszPathName, uint dwNameSpace, uint dwVersion, Guid* lpProviderId);
alias LPWSCUNINSTALLNAMESPACE = extern(Windows) int function(Guid* lpProviderId);
alias LPWSCENABLENSPROVIDER = extern(Windows) int function(Guid* lpProviderId, BOOL fEnable);
alias LPNSPCLEANUP = extern(Windows) int function(Guid* lpProviderId);
alias LPNSPLOOKUPSERVICEBEGIN = extern(Windows) int function(Guid* lpProviderId, WSAQUERYSETW* lpqsRestrictions, WSASERVICECLASSINFOW* lpServiceClassInfo, uint dwControlFlags, int* lphLookup);
alias LPNSPLOOKUPSERVICENEXT = extern(Windows) int function(HANDLE hLookup, uint dwControlFlags, uint* lpdwBufferLength, char* lpqsResults);
alias LPNSPIOCTL = extern(Windows) int function(HANDLE hLookup, uint dwControlCode, char* lpvInBuffer, uint cbInBuffer, char* lpvOutBuffer, uint cbOutBuffer, uint* lpcbBytesReturned, WSACOMPLETION* lpCompletion, WSATHREADID* lpThreadId);
alias LPNSPLOOKUPSERVICEEND = extern(Windows) int function(HANDLE hLookup);
alias LPNSPSETSERVICE = extern(Windows) int function(Guid* lpProviderId, WSASERVICECLASSINFOW* lpServiceClassInfo, WSAQUERYSETW* lpqsRegInfo, WSAESETSERVICEOP essOperation, uint dwControlFlags);
alias LPNSPINSTALLSERVICECLASS = extern(Windows) int function(Guid* lpProviderId, WSASERVICECLASSINFOW* lpServiceClassInfo);
alias LPNSPREMOVESERVICECLASS = extern(Windows) int function(Guid* lpProviderId, Guid* lpServiceClassId);
alias LPNSPGETSERVICECLASSINFO = extern(Windows) int function(Guid* lpProviderId, uint* lpdwBufSize, WSASERVICECLASSINFOW* lpServiceClassInfo);
struct NSP_ROUTINE
{
    uint cbSize;
    uint dwMajorVersion;
    uint dwMinorVersion;
    LPNSPCLEANUP NSPCleanup;
    LPNSPLOOKUPSERVICEBEGIN NSPLookupServiceBegin;
    LPNSPLOOKUPSERVICENEXT NSPLookupServiceNext;
    LPNSPLOOKUPSERVICEEND NSPLookupServiceEnd;
    LPNSPSETSERVICE NSPSetService;
    LPNSPINSTALLSERVICECLASS NSPInstallServiceClass;
    LPNSPREMOVESERVICECLASS NSPRemoveServiceClass;
    LPNSPGETSERVICECLASSINFO NSPGetServiceClassInfo;
    LPNSPIOCTL NSPIoctl;
}

alias LPNSPSTARTUP = extern(Windows) int function(Guid* lpProviderId, NSP_ROUTINE* lpnspRoutines);
alias LPNSPV2STARTUP = extern(Windows) int function(Guid* lpProviderId, void** ppvClientSessionArg);
alias LPNSPV2CLEANUP = extern(Windows) int function(Guid* lpProviderId, void* pvClientSessionArg);
alias LPNSPV2LOOKUPSERVICEBEGIN = extern(Windows) int function(Guid* lpProviderId, WSAQUERYSET2W* lpqsRestrictions, uint dwControlFlags, void* lpvClientSessionArg, int* lphLookup);
alias LPNSPV2LOOKUPSERVICENEXTEX = extern(Windows) void function(HANDLE hAsyncCall, HANDLE hLookup, uint dwControlFlags, uint* lpdwBufferLength, WSAQUERYSET2W* lpqsResults);
alias LPNSPV2LOOKUPSERVICEEND = extern(Windows) int function(HANDLE hLookup);
alias LPNSPV2SETSERVICEEX = extern(Windows) void function(HANDLE hAsyncCall, Guid* lpProviderId, WSAQUERYSET2W* lpqsRegInfo, WSAESETSERVICEOP essOperation, uint dwControlFlags, void* lpvClientSessionArg);
alias LPNSPV2CLIENTSESSIONRUNDOWN = extern(Windows) void function(Guid* lpProviderId, void* pvClientSessionArg);
struct NSPV2_ROUTINE
{
    uint cbSize;
    uint dwMajorVersion;
    uint dwMinorVersion;
    LPNSPV2STARTUP NSPv2Startup;
    LPNSPV2CLEANUP NSPv2Cleanup;
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
    const(char)* lpNameSpace;
}

struct NS_INFOW
{
    uint dwNameSpace;
    uint dwNameSpaceFlags;
    const(wchar)* lpNameSpace;
}

struct SERVICE_TYPE_VALUE
{
    uint dwNameSpace;
    uint dwValueType;
    uint dwValueSize;
    uint dwValueNameOffset;
    uint dwValueOffset;
}

struct SERVICE_TYPE_VALUE_ABSA
{
    uint dwNameSpace;
    uint dwValueType;
    uint dwValueSize;
    const(char)* lpValueName;
    void* lpValue;
}

struct SERVICE_TYPE_VALUE_ABSW
{
    uint dwNameSpace;
    uint dwValueType;
    uint dwValueSize;
    const(wchar)* lpValueName;
    void* lpValue;
}

struct SERVICE_TYPE_INFO
{
    uint dwTypeNameOffset;
    uint dwValueCount;
    SERVICE_TYPE_VALUE Values;
}

struct SERVICE_TYPE_INFO_ABSA
{
    const(char)* lpTypeName;
    uint dwValueCount;
    SERVICE_TYPE_VALUE_ABSA Values;
}

struct SERVICE_TYPE_INFO_ABSW
{
    const(wchar)* lpTypeName;
    uint dwValueCount;
    SERVICE_TYPE_VALUE_ABSW Values;
}

struct SERVICE_ADDRESS
{
    uint dwAddressType;
    uint dwAddressFlags;
    uint dwAddressLength;
    uint dwPrincipalLength;
    ubyte* lpAddress;
    ubyte* lpPrincipal;
}

struct SERVICE_ADDRESSES
{
    uint dwAddressCount;
    SERVICE_ADDRESS Addresses;
}

struct SERVICE_INFOA
{
    Guid* lpServiceType;
    const(char)* lpServiceName;
    const(char)* lpComment;
    const(char)* lpLocale;
    uint dwDisplayHint;
    uint dwVersion;
    uint dwTime;
    const(char)* lpMachineName;
    SERVICE_ADDRESSES* lpServiceAddress;
    BLOB ServiceSpecificInfo;
}

struct SERVICE_INFOW
{
    Guid* lpServiceType;
    const(wchar)* lpServiceName;
    const(wchar)* lpComment;
    const(wchar)* lpLocale;
    uint dwDisplayHint;
    uint dwVersion;
    uint dwTime;
    const(wchar)* lpMachineName;
    SERVICE_ADDRESSES* lpServiceAddress;
    BLOB ServiceSpecificInfo;
}

struct NS_SERVICE_INFOA
{
    uint dwNameSpace;
    SERVICE_INFOA ServiceInfo;
}

struct NS_SERVICE_INFOW
{
    uint dwNameSpace;
    SERVICE_INFOW ServiceInfo;
}

struct PROTOCOL_INFOA
{
    uint dwServiceFlags;
    int iAddressFamily;
    int iMaxSockAddr;
    int iMinSockAddr;
    int iSocketType;
    int iProtocol;
    uint dwMessageSize;
    const(char)* lpProtocol;
}

struct PROTOCOL_INFOW
{
    uint dwServiceFlags;
    int iAddressFamily;
    int iMaxSockAddr;
    int iMinSockAddr;
    int iSocketType;
    int iProtocol;
    uint dwMessageSize;
    const(wchar)* lpProtocol;
}

struct NETRESOURCE2A
{
    uint dwScope;
    uint dwType;
    uint dwUsage;
    uint dwDisplayType;
    const(char)* lpLocalName;
    const(char)* lpRemoteName;
    const(char)* lpComment;
    NS_INFOA ns_info;
    Guid ServiceType;
    uint dwProtocols;
    int* lpiProtocols;
}

struct NETRESOURCE2W
{
    uint dwScope;
    uint dwType;
    uint dwUsage;
    uint dwDisplayType;
    const(wchar)* lpLocalName;
    const(wchar)* lpRemoteName;
    const(wchar)* lpComment;
    NS_INFOA ns_info;
    Guid ServiceType;
    uint dwProtocols;
    int* lpiProtocols;
}

alias LPFN_NSPAPI = extern(Windows) uint function();
alias LPSERVICE_CALLBACK_PROC = extern(Windows) void function(LPARAM lParam, HANDLE hAsyncTaskHandle);
struct SERVICE_ASYNC_INFO
{
    LPSERVICE_CALLBACK_PROC lpServiceCallbackProc;
    LPARAM lParam;
    HANDLE hAsyncTaskHandle;
}

alias LPLOOKUPSERVICE_COMPLETION_ROUTINE = extern(Windows) void function(uint dwError, uint dwBytes, OVERLAPPED* lpOverlapped);
alias LPWSCWRITEPROVIDERORDER = extern(Windows) int function(uint* lpwdCatalogEntryId, uint dwNumberOfEntries);
alias LPWSCWRITENAMESPACEORDER = extern(Windows) int function(Guid* lpProviderId, uint dwNumberOfEntries);
@DllImport("WS2_32.dll")
int __WSAFDIsSet(uint fd, fd_set* param1);

@DllImport("WS2_32.dll")
uint accept(uint s, char* addr, int* addrlen);

@DllImport("WS2_32.dll")
int bind(uint s, char* name, int namelen);

@DllImport("WS2_32.dll")
int closesocket(uint s);

@DllImport("WS2_32.dll")
int connect(uint s, char* name, int namelen);

@DllImport("WS2_32.dll")
int ioctlsocket(uint s, int cmd, uint* argp);

@DllImport("WS2_32.dll")
int getpeername(uint s, char* name, int* namelen);

@DllImport("WS2_32.dll")
int getsockname(uint s, char* name, int* namelen);

@DllImport("WS2_32.dll")
int getsockopt(uint s, int level, int optname, char* optval, int* optlen);

@DllImport("WS2_32.dll")
uint htonl(uint hostlong);

@DllImport("WS2_32.dll")
ushort htons(ushort hostshort);

@DllImport("WS2_32.dll")
uint inet_addr(const(byte)* cp);

@DllImport("WS2_32.dll")
byte* inet_ntoa(in_addr in);

@DllImport("WS2_32.dll")
int listen(uint s, int backlog);

@DllImport("WS2_32.dll")
uint ntohl(uint netlong);

@DllImport("WS2_32.dll")
ushort ntohs(ushort netshort);

@DllImport("WS2_32.dll")
int recv(uint s, char* buf, int len, int flags);

@DllImport("WS2_32.dll")
int recvfrom(uint s, char* buf, int len, int flags, char* from, int* fromlen);

@DllImport("WS2_32.dll")
int select(int nfds, fd_set* readfds, fd_set* writefds, fd_set* exceptfds, const(timeval)* timeout);

@DllImport("WS2_32.dll")
int send(uint s, char* buf, int len, int flags);

@DllImport("WS2_32.dll")
int sendto(uint s, char* buf, int len, int flags, char* to, int tolen);

@DllImport("WS2_32.dll")
int setsockopt(uint s, int level, int optname, char* optval, int optlen);

@DllImport("WS2_32.dll")
int shutdown(uint s, int how);

@DllImport("WS2_32.dll")
uint socket(int af, int type, int protocol);

@DllImport("WS2_32.dll")
hostent* gethostbyaddr(char* addr, int len, int type);

@DllImport("WS2_32.dll")
hostent* gethostbyname(const(byte)* name);

@DllImport("WS2_32.dll")
int gethostname(char* name, int namelen);

@DllImport("WS2_32.dll")
int GetHostNameW(const(wchar)* name, int namelen);

@DllImport("WS2_32.dll")
servent* getservbyport(int port, const(byte)* proto);

@DllImport("WS2_32.dll")
servent* getservbyname(const(byte)* name, const(byte)* proto);

@DllImport("WS2_32.dll")
protoent* getprotobynumber(int number);

@DllImport("WS2_32.dll")
protoent* getprotobyname(const(byte)* name);

@DllImport("WS2_32.dll")
int WSAStartup(ushort wVersionRequested, WSAData* lpWSAData);

@DllImport("WS2_32.dll")
int WSACleanup();

@DllImport("WS2_32.dll")
void WSASetLastError(int iError);

@DllImport("WS2_32.dll")
int WSAGetLastError();

@DllImport("WS2_32.dll")
BOOL WSAIsBlocking();

@DllImport("WS2_32.dll")
int WSAUnhookBlockingHook();

@DllImport("WS2_32.dll")
FARPROC WSASetBlockingHook(FARPROC lpBlockFunc);

@DllImport("WS2_32.dll")
int WSACancelBlockingCall();

@DllImport("WS2_32.dll")
HANDLE WSAAsyncGetServByName(HWND hWnd, uint wMsg, const(byte)* name, const(byte)* proto, char* buf, int buflen);

@DllImport("WS2_32.dll")
HANDLE WSAAsyncGetServByPort(HWND hWnd, uint wMsg, int port, const(byte)* proto, char* buf, int buflen);

@DllImport("WS2_32.dll")
HANDLE WSAAsyncGetProtoByName(HWND hWnd, uint wMsg, const(byte)* name, char* buf, int buflen);

@DllImport("WS2_32.dll")
HANDLE WSAAsyncGetProtoByNumber(HWND hWnd, uint wMsg, int number, char* buf, int buflen);

@DllImport("WS2_32.dll")
HANDLE WSAAsyncGetHostByName(HWND hWnd, uint wMsg, const(byte)* name, char* buf, int buflen);

@DllImport("WS2_32.dll")
HANDLE WSAAsyncGetHostByAddr(HWND hWnd, uint wMsg, char* addr, int len, int type, char* buf, int buflen);

@DllImport("WS2_32.dll")
int WSACancelAsyncRequest(HANDLE hAsyncTaskHandle);

@DllImport("WS2_32.dll")
int WSAAsyncSelect(uint s, HWND hWnd, uint wMsg, int lEvent);

@DllImport("WS2_32.dll")
uint WSAAccept(uint s, char* addr, int* addrlen, LPCONDITIONPROC lpfnCondition, uint dwCallbackData);

@DllImport("WS2_32.dll")
BOOL WSACloseEvent(HANDLE hEvent);

@DllImport("WS2_32.dll")
int WSAConnect(uint s, char* name, int namelen, WSABUF* lpCallerData, WSABUF* lpCalleeData, QOS* lpSQOS, QOS* lpGQOS);

@DllImport("WS2_32.dll")
BOOL WSAConnectByNameW(uint s, const(wchar)* nodename, const(wchar)* servicename, uint* LocalAddressLength, char* LocalAddress, uint* RemoteAddressLength, char* RemoteAddress, const(timeval)* timeout, OVERLAPPED* Reserved);

@DllImport("WS2_32.dll")
BOOL WSAConnectByNameA(uint s, const(char)* nodename, const(char)* servicename, uint* LocalAddressLength, char* LocalAddress, uint* RemoteAddressLength, char* RemoteAddress, const(timeval)* timeout, OVERLAPPED* Reserved);

@DllImport("WS2_32.dll")
BOOL WSAConnectByList(uint s, SOCKET_ADDRESS_LIST* SocketAddress, uint* LocalAddressLength, char* LocalAddress, uint* RemoteAddressLength, char* RemoteAddress, const(timeval)* timeout, OVERLAPPED* Reserved);

@DllImport("WS2_32.dll")
HANDLE WSACreateEvent();

@DllImport("WS2_32.dll")
int WSADuplicateSocketA(uint s, uint dwProcessId, WSAPROTOCOL_INFOA* lpProtocolInfo);

@DllImport("WS2_32.dll")
int WSADuplicateSocketW(uint s, uint dwProcessId, WSAPROTOCOL_INFOW* lpProtocolInfo);

@DllImport("WS2_32.dll")
int WSAEnumNetworkEvents(uint s, HANDLE hEventObject, WSANETWORKEVENTS* lpNetworkEvents);

@DllImport("WS2_32.dll")
int WSAEnumProtocolsA(int* lpiProtocols, char* lpProtocolBuffer, uint* lpdwBufferLength);

@DllImport("WS2_32.dll")
int WSAEnumProtocolsW(int* lpiProtocols, char* lpProtocolBuffer, uint* lpdwBufferLength);

@DllImport("WS2_32.dll")
int WSAEventSelect(uint s, HANDLE hEventObject, int lNetworkEvents);

@DllImport("WS2_32.dll")
BOOL WSAGetOverlappedResult(uint s, OVERLAPPED* lpOverlapped, uint* lpcbTransfer, BOOL fWait, uint* lpdwFlags);

@DllImport("WS2_32.dll")
BOOL WSAGetQOSByName(uint s, WSABUF* lpQOSName, QOS* lpQOS);

@DllImport("WS2_32.dll")
int WSAHtonl(uint s, uint hostlong, uint* lpnetlong);

@DllImport("WS2_32.dll")
int WSAHtons(uint s, ushort hostshort, ushort* lpnetshort);

@DllImport("WS2_32.dll")
int WSAIoctl(uint s, uint dwIoControlCode, char* lpvInBuffer, uint cbInBuffer, char* lpvOutBuffer, uint cbOutBuffer, uint* lpcbBytesReturned, OVERLAPPED* lpOverlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

@DllImport("WS2_32.dll")
uint WSAJoinLeaf(uint s, char* name, int namelen, WSABUF* lpCallerData, WSABUF* lpCalleeData, QOS* lpSQOS, QOS* lpGQOS, uint dwFlags);

@DllImport("WS2_32.dll")
int WSANtohl(uint s, uint netlong, uint* lphostlong);

@DllImport("WS2_32.dll")
int WSANtohs(uint s, ushort netshort, ushort* lphostshort);

@DllImport("WS2_32.dll")
int WSARecv(uint s, char* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesRecvd, uint* lpFlags, OVERLAPPED* lpOverlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

@DllImport("WS2_32.dll")
int WSARecvDisconnect(uint s, WSABUF* lpInboundDisconnectData);

@DllImport("WS2_32.dll")
int WSARecvFrom(uint s, char* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesRecvd, uint* lpFlags, char* lpFrom, int* lpFromlen, OVERLAPPED* lpOverlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

@DllImport("WS2_32.dll")
BOOL WSAResetEvent(HANDLE hEvent);

@DllImport("WS2_32.dll")
int WSASend(uint s, char* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesSent, uint dwFlags, OVERLAPPED* lpOverlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

@DllImport("WS2_32.dll")
int WSASendMsg(uint Handle, WSAMSG* lpMsg, uint dwFlags, uint* lpNumberOfBytesSent, OVERLAPPED* lpOverlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

@DllImport("WS2_32.dll")
int WSASendDisconnect(uint s, WSABUF* lpOutboundDisconnectData);

@DllImport("WS2_32.dll")
int WSASendTo(uint s, char* lpBuffers, uint dwBufferCount, uint* lpNumberOfBytesSent, uint dwFlags, char* lpTo, int iTolen, OVERLAPPED* lpOverlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

@DllImport("WS2_32.dll")
BOOL WSASetEvent(HANDLE hEvent);

@DllImport("WS2_32.dll")
uint WSASocketA(int af, int type, int protocol, WSAPROTOCOL_INFOA* lpProtocolInfo, uint g, uint dwFlags);

@DllImport("WS2_32.dll")
uint WSASocketW(int af, int type, int protocol, WSAPROTOCOL_INFOW* lpProtocolInfo, uint g, uint dwFlags);

@DllImport("WS2_32.dll")
uint WSAWaitForMultipleEvents(uint cEvents, char* lphEvents, BOOL fWaitAll, uint dwTimeout, BOOL fAlertable);

@DllImport("WS2_32.dll")
int WSAAddressToStringA(char* lpsaAddress, uint dwAddressLength, WSAPROTOCOL_INFOA* lpProtocolInfo, const(char)* lpszAddressString, uint* lpdwAddressStringLength);

@DllImport("WS2_32.dll")
int WSAAddressToStringW(char* lpsaAddress, uint dwAddressLength, WSAPROTOCOL_INFOW* lpProtocolInfo, const(wchar)* lpszAddressString, uint* lpdwAddressStringLength);

@DllImport("WS2_32.dll")
int WSAStringToAddressA(const(char)* AddressString, int AddressFamily, WSAPROTOCOL_INFOA* lpProtocolInfo, char* lpAddress, int* lpAddressLength);

@DllImport("WS2_32.dll")
int WSAStringToAddressW(const(wchar)* AddressString, int AddressFamily, WSAPROTOCOL_INFOW* lpProtocolInfo, char* lpAddress, int* lpAddressLength);

@DllImport("WS2_32.dll")
int WSALookupServiceBeginA(WSAQUERYSETA* lpqsRestrictions, uint dwControlFlags, int* lphLookup);

@DllImport("WS2_32.dll")
int WSALookupServiceBeginW(WSAQUERYSETW* lpqsRestrictions, uint dwControlFlags, int* lphLookup);

@DllImport("WS2_32.dll")
int WSALookupServiceNextA(HANDLE hLookup, uint dwControlFlags, uint* lpdwBufferLength, char* lpqsResults);

@DllImport("WS2_32.dll")
int WSALookupServiceNextW(HANDLE hLookup, uint dwControlFlags, uint* lpdwBufferLength, char* lpqsResults);

@DllImport("WS2_32.dll")
int WSANSPIoctl(HANDLE hLookup, uint dwControlCode, char* lpvInBuffer, uint cbInBuffer, char* lpvOutBuffer, uint cbOutBuffer, uint* lpcbBytesReturned, WSACOMPLETION* lpCompletion);

@DllImport("WS2_32.dll")
int WSALookupServiceEnd(HANDLE hLookup);

@DllImport("WS2_32.dll")
int WSAInstallServiceClassA(WSASERVICECLASSINFOA* lpServiceClassInfo);

@DllImport("WS2_32.dll")
int WSAInstallServiceClassW(WSASERVICECLASSINFOW* lpServiceClassInfo);

@DllImport("WS2_32.dll")
int WSARemoveServiceClass(Guid* lpServiceClassId);

@DllImport("WS2_32.dll")
int WSAGetServiceClassInfoA(Guid* lpProviderId, Guid* lpServiceClassId, uint* lpdwBufSize, char* lpServiceClassInfo);

@DllImport("WS2_32.dll")
int WSAGetServiceClassInfoW(Guid* lpProviderId, Guid* lpServiceClassId, uint* lpdwBufSize, char* lpServiceClassInfo);

@DllImport("WS2_32.dll")
int WSAEnumNameSpaceProvidersA(uint* lpdwBufferLength, char* lpnspBuffer);

@DllImport("WS2_32.dll")
int WSAEnumNameSpaceProvidersW(uint* lpdwBufferLength, char* lpnspBuffer);

@DllImport("WS2_32.dll")
int WSAEnumNameSpaceProvidersExA(uint* lpdwBufferLength, char* lpnspBuffer);

@DllImport("WS2_32.dll")
int WSAEnumNameSpaceProvidersExW(uint* lpdwBufferLength, char* lpnspBuffer);

@DllImport("WS2_32.dll")
int WSAGetServiceClassNameByClassIdA(Guid* lpServiceClassId, const(char)* lpszServiceClassName, uint* lpdwBufferLength);

@DllImport("WS2_32.dll")
int WSAGetServiceClassNameByClassIdW(Guid* lpServiceClassId, const(wchar)* lpszServiceClassName, uint* lpdwBufferLength);

@DllImport("WS2_32.dll")
int WSASetServiceA(WSAQUERYSETA* lpqsRegInfo, WSAESETSERVICEOP essoperation, uint dwControlFlags);

@DllImport("WS2_32.dll")
int WSASetServiceW(WSAQUERYSETW* lpqsRegInfo, WSAESETSERVICEOP essoperation, uint dwControlFlags);

@DllImport("WS2_32.dll")
int WSAProviderConfigChange(int* lpNotificationHandle, OVERLAPPED* lpOverlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE lpCompletionRoutine);

@DllImport("WS2_32.dll")
int WSAPoll(WSAPOLLFD* fdArray, uint fds, int timeout);

@DllImport("ntdll.dll")
int RtlIpv4AddressToStringExA(const(in_addr)* Address, ushort Port, const(char)* AddressString, uint* AddressStringLength);

@DllImport("ntdll.dll")
int RtlIpv4StringToAddressExA(const(char)* AddressString, ubyte Strict, in_addr* Address, ushort* Port);

@DllImport("ntdll.dll")
int RtlIpv6AddressToStringExA(const(in6_addr)* Address, uint ScopeId, ushort Port, const(char)* AddressString, uint* AddressStringLength);

@DllImport("ntdll.dll")
int RtlIpv6StringToAddressExA(const(char)* AddressString, in6_addr* Address, uint* ScopeId, ushort* Port);

@DllImport("MSWSOCK.dll")
int WSARecvEx(uint s, char* buf, int len, int* flags);

@DllImport("MSWSOCK.dll")
BOOL TransmitFile(uint hSocket, HANDLE hFile, uint nNumberOfBytesToWrite, uint nNumberOfBytesPerSend, OVERLAPPED* lpOverlapped, TRANSMIT_FILE_BUFFERS* lpTransmitBuffers, uint dwReserved);

@DllImport("MSWSOCK.dll")
BOOL AcceptEx(uint sListenSocket, uint sAcceptSocket, char* lpOutputBuffer, uint dwReceiveDataLength, uint dwLocalAddressLength, uint dwRemoteAddressLength, uint* lpdwBytesReceived, OVERLAPPED* lpOverlapped);

@DllImport("MSWSOCK.dll")
void GetAcceptExSockaddrs(char* lpOutputBuffer, uint dwReceiveDataLength, uint dwLocalAddressLength, uint dwRemoteAddressLength, SOCKADDR** LocalSockaddr, int* LocalSockaddrLength, SOCKADDR** RemoteSockaddr, int* RemoteSockaddrLength);

@DllImport("WS2_32.dll")
int WSCEnumProtocols(int* lpiProtocols, char* lpProtocolBuffer, uint* lpdwBufferLength, int* lpErrno);

@DllImport("WS2_32.dll")
int WSCDeinstallProvider(Guid* lpProviderId, int* lpErrno);

@DllImport("WS2_32.dll")
int WSCInstallProvider(Guid* lpProviderId, const(wchar)* lpszProviderDllPath, char* lpProtocolInfoList, uint dwNumberOfEntries, int* lpErrno);

@DllImport("WS2_32.dll")
int WSCGetProviderPath(Guid* lpProviderId, char* lpszProviderDllPath, int* lpProviderDllPathLen, int* lpErrno);

@DllImport("WS2_32.dll")
int WSCUpdateProvider(Guid* lpProviderId, const(wchar)* lpszProviderDllPath, char* lpProtocolInfoList, uint dwNumberOfEntries, int* lpErrno);

@DllImport("WS2_32.dll")
int WSCSetProviderInfo(Guid* lpProviderId, WSC_PROVIDER_INFO_TYPE InfoType, char* Info, uint InfoSize, uint Flags, int* lpErrno);

@DllImport("WS2_32.dll")
int WSCGetProviderInfo(Guid* lpProviderId, WSC_PROVIDER_INFO_TYPE InfoType, char* Info, uint* InfoSize, uint Flags, int* lpErrno);

@DllImport("WS2_32.dll")
int WSCSetApplicationCategory(const(wchar)* Path, uint PathLength, const(wchar)* Extra, uint ExtraLength, uint PermittedLspCategories, uint* pPrevPermLspCat, int* lpErrno);

@DllImport("WS2_32.dll")
int WSCGetApplicationCategory(const(wchar)* Path, uint PathLength, const(wchar)* Extra, uint ExtraLength, uint* pPermittedLspCategories, int* lpErrno);

@DllImport("WS2_32.dll")
int WPUCompleteOverlappedRequest(uint s, OVERLAPPED* lpOverlapped, uint dwError, uint cbTransferred, int* lpErrno);

@DllImport("WS2_32.dll")
int WSCInstallNameSpace(const(wchar)* lpszIdentifier, const(wchar)* lpszPathName, uint dwNameSpace, uint dwVersion, Guid* lpProviderId);

@DllImport("WS2_32.dll")
int WSCUnInstallNameSpace(Guid* lpProviderId);

@DllImport("WS2_32.dll")
int WSCInstallNameSpaceEx(const(wchar)* lpszIdentifier, const(wchar)* lpszPathName, uint dwNameSpace, uint dwVersion, Guid* lpProviderId, BLOB* lpProviderSpecific);

@DllImport("WS2_32.dll")
int WSCEnableNSProvider(Guid* lpProviderId, BOOL fEnable);

@DllImport("WS2_32.dll")
int WSAAdvertiseProvider(const(Guid)* puuidProviderId, const(NSPV2_ROUTINE)* pNSPv2Routine);

@DllImport("WS2_32.dll")
int WSAUnadvertiseProvider(const(Guid)* puuidProviderId);

@DllImport("WS2_32.dll")
int WSAProviderCompleteAsyncCall(HANDLE hAsyncCall, int iRetCode);

@DllImport("MSWSOCK.dll")
int EnumProtocolsA(int* lpiProtocols, char* lpProtocolBuffer, uint* lpdwBufferLength);

@DllImport("MSWSOCK.dll")
int EnumProtocolsW(int* lpiProtocols, char* lpProtocolBuffer, uint* lpdwBufferLength);

@DllImport("MSWSOCK.dll")
int GetAddressByNameA(uint dwNameSpace, Guid* lpServiceType, const(char)* lpServiceName, int* lpiProtocols, uint dwResolution, SERVICE_ASYNC_INFO* lpServiceAsyncInfo, char* lpCsaddrBuffer, uint* lpdwBufferLength, const(char)* lpAliasBuffer, uint* lpdwAliasBufferLength);

@DllImport("MSWSOCK.dll")
int GetAddressByNameW(uint dwNameSpace, Guid* lpServiceType, const(wchar)* lpServiceName, int* lpiProtocols, uint dwResolution, SERVICE_ASYNC_INFO* lpServiceAsyncInfo, char* lpCsaddrBuffer, uint* lpdwBufferLength, const(wchar)* lpAliasBuffer, uint* lpdwAliasBufferLength);

@DllImport("MSWSOCK.dll")
int GetTypeByNameA(const(char)* lpServiceName, Guid* lpServiceType);

@DllImport("MSWSOCK.dll")
int GetTypeByNameW(const(wchar)* lpServiceName, Guid* lpServiceType);

@DllImport("MSWSOCK.dll")
int GetNameByTypeA(Guid* lpServiceType, const(char)* lpServiceName, uint dwNameLength);

@DllImport("MSWSOCK.dll")
int GetNameByTypeW(Guid* lpServiceType, const(wchar)* lpServiceName, uint dwNameLength);

@DllImport("MSWSOCK.dll")
int SetServiceA(uint dwNameSpace, uint dwOperation, uint dwFlags, SERVICE_INFOA* lpServiceInfo, SERVICE_ASYNC_INFO* lpServiceAsyncInfo, uint* lpdwStatusFlags);

@DllImport("MSWSOCK.dll")
int SetServiceW(uint dwNameSpace, uint dwOperation, uint dwFlags, SERVICE_INFOW* lpServiceInfo, SERVICE_ASYNC_INFO* lpServiceAsyncInfo, uint* lpdwStatusFlags);

@DllImport("MSWSOCK.dll")
int GetServiceA(uint dwNameSpace, Guid* lpGuid, const(char)* lpServiceName, uint dwProperties, char* lpBuffer, uint* lpdwBufferSize, SERVICE_ASYNC_INFO* lpServiceAsyncInfo);

@DllImport("MSWSOCK.dll")
int GetServiceW(uint dwNameSpace, Guid* lpGuid, const(wchar)* lpServiceName, uint dwProperties, char* lpBuffer, uint* lpdwBufferSize, SERVICE_ASYNC_INFO* lpServiceAsyncInfo);

@DllImport("WS2_32.dll")
int getaddrinfo(const(char)* pNodeName, const(char)* pServiceName, const(ADDRINFOA)* pHints, ADDRINFOA** ppResult);

@DllImport("WS2_32.dll")
int GetAddrInfoW(const(wchar)* pNodeName, const(wchar)* pServiceName, const(addrinfoW)* pHints, addrinfoW** ppResult);

@DllImport("WS2_32.dll")
int GetAddrInfoExA(const(char)* pName, const(char)* pServiceName, uint dwNameSpace, Guid* lpNspId, const(addrinfoexA)* hints, addrinfoexA** ppResult, timeval* timeout, OVERLAPPED* lpOverlapped, LPLOOKUPSERVICE_COMPLETION_ROUTINE lpCompletionRoutine, int* lpNameHandle);

@DllImport("WS2_32.dll")
int GetAddrInfoExW(const(wchar)* pName, const(wchar)* pServiceName, uint dwNameSpace, Guid* lpNspId, const(addrinfoexW)* hints, addrinfoexW** ppResult, timeval* timeout, OVERLAPPED* lpOverlapped, LPLOOKUPSERVICE_COMPLETION_ROUTINE lpCompletionRoutine, int* lpHandle);

@DllImport("WS2_32.dll")
int GetAddrInfoExCancel(int* lpHandle);

@DllImport("WS2_32.dll")
int GetAddrInfoExOverlappedResult(OVERLAPPED* lpOverlapped);

@DllImport("WS2_32.dll")
int SetAddrInfoExA(const(char)* pName, const(char)* pServiceName, SOCKET_ADDRESS* pAddresses, uint dwAddressCount, BLOB* lpBlob, uint dwFlags, uint dwNameSpace, Guid* lpNspId, timeval* timeout, OVERLAPPED* lpOverlapped, LPLOOKUPSERVICE_COMPLETION_ROUTINE lpCompletionRoutine, int* lpNameHandle);

@DllImport("WS2_32.dll")
int SetAddrInfoExW(const(wchar)* pName, const(wchar)* pServiceName, SOCKET_ADDRESS* pAddresses, uint dwAddressCount, BLOB* lpBlob, uint dwFlags, uint dwNameSpace, Guid* lpNspId, timeval* timeout, OVERLAPPED* lpOverlapped, LPLOOKUPSERVICE_COMPLETION_ROUTINE lpCompletionRoutine, int* lpNameHandle);

@DllImport("WS2_32.dll")
void freeaddrinfo(ADDRINFOA* pAddrInfo);

@DllImport("WS2_32.dll")
void FreeAddrInfoW(addrinfoW* pAddrInfo);

@DllImport("WS2_32.dll")
void FreeAddrInfoEx(addrinfoexA* pAddrInfoEx);

@DllImport("WS2_32.dll")
void FreeAddrInfoExW(addrinfoexW* pAddrInfoEx);

@DllImport("WS2_32.dll")
int getnameinfo(char* pSockaddr, int SockaddrLength, const(char)* pNodeBuffer, uint NodeBufferSize, const(char)* pServiceBuffer, uint ServiceBufferSize, int Flags);

@DllImport("WS2_32.dll")
int GetNameInfoW(char* pSockaddr, int SockaddrLength, const(wchar)* pNodeBuffer, uint NodeBufferSize, const(wchar)* pServiceBuffer, uint ServiceBufferSize, int Flags);

@DllImport("WS2_32.dll")
int inet_pton(int Family, const(char)* pszAddrString, char* pAddrBuf);

@DllImport("WS2_32.dll")
int InetPtonW(int Family, const(wchar)* pszAddrString, char* pAddrBuf);

@DllImport("WS2_32.dll")
byte* inet_ntop(int Family, const(void)* pAddr, const(char)* pStringBuf, uint StringBufSize);

@DllImport("WS2_32.dll")
ushort* InetNtopW(int Family, const(void)* pAddr, const(wchar)* pStringBuf, uint StringBufSize);

@DllImport("fwpuclnt.dll")
int WSASetSocketSecurity(uint Socket, char* SecuritySettings, uint SecuritySettingsLen, OVERLAPPED* Overlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE CompletionRoutine);

@DllImport("fwpuclnt.dll")
int WSAQuerySocketSecurity(uint Socket, char* SecurityQueryTemplate, uint SecurityQueryTemplateLen, char* SecurityQueryInfo, uint* SecurityQueryInfoLen, OVERLAPPED* Overlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE CompletionRoutine);

@DllImport("fwpuclnt.dll")
int WSASetSocketPeerTargetName(uint Socket, char* PeerTargetName, uint PeerTargetNameLen, OVERLAPPED* Overlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE CompletionRoutine);

@DllImport("fwpuclnt.dll")
int WSADeleteSocketPeerTargetName(uint Socket, char* PeerAddr, uint PeerAddrLen, OVERLAPPED* Overlapped, LPWSAOVERLAPPED_COMPLETION_ROUTINE CompletionRoutine);

@DllImport("fwpuclnt.dll")
int WSAImpersonateSocketPeer(uint Socket, char* PeerAddr, uint PeerAddrLen);

@DllImport("fwpuclnt.dll")
int WSARevertImpersonation();

@DllImport("Windows.dll")
HRESULT SetSocketMediaStreamingMode(BOOL value);

@DllImport("WS2_32.dll")
int WSCWriteProviderOrder(uint* lpwdCatalogEntryId, uint dwNumberOfEntries);

@DllImport("WS2_32.dll")
int WSCWriteNameSpaceOrder(Guid* lpProviderId, uint dwNumberOfEntries);

