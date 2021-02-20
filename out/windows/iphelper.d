// Written in the D programming language.

module windows.iphelper;

public import windows.core;
public import windows.mib : MIB_ANYCASTIPADDRESS_ROW, MIB_ANYCASTIPADDRESS_TABLE, MIB_ICMP,
                            MIB_ICMP_EX_XPSP1, MIB_IFROW, MIB_IFSTACK_TABLE,
                            MIB_IFTABLE, MIB_IF_ROW2, MIB_IF_TABLE2,
                            MIB_INVERTEDIFSTACK_TABLE, MIB_IPADDRTABLE,
                            MIB_IPFORWARDROW, MIB_IPFORWARDTABLE,
                            MIB_IPFORWARD_ROW2, MIB_IPFORWARD_TABLE2,
                            MIB_IPINTERFACE_ROW, MIB_IPINTERFACE_TABLE,
                            MIB_IPNETROW_LH, MIB_IPNETTABLE, MIB_IPNET_ROW2,
                            MIB_IPNET_TABLE2, MIB_IPPATH_ROW, MIB_IPPATH_TABLE,
                            MIB_IPSTATS_LH, MIB_IP_NETWORK_CONNECTION_BANDWIDTH_ESTIMATES,
                            MIB_MULTICASTIPADDRESS_ROW, MIB_MULTICASTIPADDRESS_TABLE,
                            MIB_NOTIFICATION_TYPE, MIB_TCP6ROW,
                            MIB_TCP6ROW_OWNER_MODULE, MIB_TCP6TABLE,
                            MIB_TCP6TABLE2, MIB_TCPROW_LH, MIB_TCPROW_OWNER_MODULE,
                            MIB_TCPSTATS2, MIB_TCPSTATS_LH, MIB_TCPTABLE,
                            MIB_TCPTABLE2, MIB_UDP6ROW_OWNER_MODULE,
                            MIB_UDP6TABLE, MIB_UDPROW_OWNER_MODULE,
                            MIB_UDPSTATS, MIB_UDPSTATS2, MIB_UDPTABLE,
                            MIB_UNICASTIPADDRESS_ROW, MIB_UNICASTIPADDRESS_TABLE;
public import windows.networkdrivers : MIB_IF_TABLE_LEVEL, NET_IF_CONNECTION_TYPE,
                                       SOCKADDR_IN6_LH, TUNNEL_TYPE;
public import windows.systemservices : BOOL, FARPROC, HANDLE, NTSTATUS, OVERLAPPED,
                                       PSTR, PWSTR;
public import windows.winsock : SOCKADDR, SOCKET_ADDRESS, in6_addr, in_addr,
                                sockaddr_in;
public import windows.windowsfiltering : DL_EUI48;

extern(Windows) @nogc nothrow:


// Enums


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

alias NET_IF_RCV_ADDRESS_TYPE = int;
enum : int
{
    NET_IF_RCV_ADDRESS_TYPE_OTHER        = 0x00000001,
    NET_IF_RCV_ADDRESS_TYPE_VOLATILE     = 0x00000002,
    NET_IF_RCV_ADDRESS_TYPE_NON_VOLATILE = 0x00000003,
}

alias IF_ADMINISTRATIVE_STATE = int;
enum : int
{
    IF_ADMINISTRATIVE_DISABLED   = 0x00000000,
    IF_ADMINISTRATIVE_ENABLED    = 0x00000001,
    IF_ADMINISTRATIVE_DEMANDDIAL = 0x00000002,
}

///The <b>IF_OPER_STATUS</b> enumeration specifies the operational status of an interface.
alias IF_OPER_STATUS = int;
enum : int
{
    ///The interface is up and operational. The interface is able to pass packets.
    IfOperStatusUp             = 0x00000001,
    ///The interface is not down and not operational. The interface is unable to pass packets.
    IfOperStatusDown           = 0x00000002,
    ///The interface is being tested.
    IfOperStatusTesting        = 0x00000003,
    ///The interface status is unknown.
    IfOperStatusUnknown        = 0x00000004,
    ///The interface is not in a condition to pass packets. The interface is not up, but is in a pending state, waiting
    ///for some external event. This state identifies the situation where the interface is waiting for events to place
    ///it in the up state.
    IfOperStatusDormant        = 0x00000005,
    ///This state is a refinement on the down state which indicates that the interface is down specifically because some
    ///component (for example, a hardware component) is not present in the system.
    IfOperStatusNotPresent     = 0x00000006,
    ///This state is a refinement on the down state. The interface is operational, but a networking layer below the
    ///interface is not operational.
    IfOperStatusLowerLayerDown = 0x00000007,
}

alias MIB_IF_ENTRY_LEVEL = int;
enum : int
{
    MibIfEntryNormal                  = 0x00000000,
    MibIfEntryNormalWithoutStatistics = 0x00000002,
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

///The <b>TCP_TABLE_CLASS</b> enumeration defines the set of values used to indicate the type of table returned by calls
///to GetExtendedTcpTable.
alias TCP_TABLE_CLASS = int;
enum : int
{
    ///A MIB_TCPTABLE table that contains all listening (receiving only) TCP endpoints on the local computer is returned
    ///to the caller.
    TCP_TABLE_BASIC_LISTENER           = 0x00000000,
    ///A MIB_TCPTABLE table that contains all connected TCP endpoints on the local computer is returned to the caller.
    TCP_TABLE_BASIC_CONNECTIONS        = 0x00000001,
    ///A MIB_TCPTABLE table that contains all TCP endpoints on the local computer is returned to the caller.
    TCP_TABLE_BASIC_ALL                = 0x00000002,
    ///A MIB_TCPTABLE_OWNER_PID or MIB_TCP6TABLE_OWNER_PID that contains all listening (receiving only) TCP endpoints on
    ///the local computer is returned to the caller.
    TCP_TABLE_OWNER_PID_LISTENER       = 0x00000003,
    ///A MIB_TCPTABLE_OWNER_PID or MIB_TCP6TABLE_OWNER_PID that structure that contains all connected TCP endpoints on
    ///the local computer is returned to the caller.
    TCP_TABLE_OWNER_PID_CONNECTIONS    = 0x00000004,
    ///A MIB_TCPTABLE_OWNER_PID or MIB_TCP6TABLE_OWNER_PID structure that contains all TCP endpoints on the local
    ///computer is returned to the caller.
    TCP_TABLE_OWNER_PID_ALL            = 0x00000005,
    ///A MIB_TCPTABLE_OWNER_MODULE or MIB_TCP6TABLE_OWNER_MODULE structure that contains all listening (receiving only)
    ///TCP endpoints on the local computer is returned to the caller.
    TCP_TABLE_OWNER_MODULE_LISTENER    = 0x00000006,
    ///A MIB_TCPTABLE_OWNER_MODULE or MIB_TCP6TABLE_OWNER_MODULE structure that contains all connected TCP endpoints on
    ///the local computer is returned to the caller.
    TCP_TABLE_OWNER_MODULE_CONNECTIONS = 0x00000007,
    ///A MIB_TCPTABLE_OWNER_MODULE or MIB_TCP6TABLE_OWNER_MODULE structure that contains all TCP endpoints on the local
    ///computer is returned to the caller.
    TCP_TABLE_OWNER_MODULE_ALL         = 0x00000008,
}

///The <b>UDP_TABLE_CLASS</b> enumeration defines the set of values used to indicate the type of table returned by calls
///to GetExtendedUdpTable.
alias UDP_TABLE_CLASS = int;
enum : int
{
    ///A MIB_UDPTABLE structure that contains all UDP endpoints on the local computer is returned to the caller.
    UDP_TABLE_BASIC        = 0x00000000,
    ///A MIB_UDPTABLE_OWNER_PID or MIB_UDP6TABLE_OWNER_PID structure that contains all UDP endpoints on the local
    ///computer is returned to the caller.
    UDP_TABLE_OWNER_PID    = 0x00000001,
    ///A MIB_UDPTABLE_OWNER_MODULE or MIB_UDP6TABLE_OWNER_MODULE structure that contains all UDP endpoints on the local
    ///computer is returned to the caller.
    UDP_TABLE_OWNER_MODULE = 0x00000002,
}

///The <b>TCPIP_OWNER_MODULE_INFO_CLASS</b> enumeration defines the type of module information structure passed to calls
///of the <b>GetOwnerModuleFromXXXEntry</b> family.
alias TCPIP_OWNER_MODULE_INFO_CLASS = int;
enum : int
{
    TCPIP_OWNER_MODULE_INFO_BASIC = 0x00000000,
}

///The <b>TCP_ESTATS_TYPE</b> enumeration defines the type of extended statistics for a TCP connection that is requested
///or being set.
alias TCP_ESTATS_TYPE = int;
enum : int
{
    ///This value specifies SYN exchange information for a TCP connection. Only read-only static information is
    ///available for this enumeration value.
    TcpConnectionEstatsSynOpts   = 0x00000000,
    ///This value specifies extended data transfer information for a TCP connection. Only read-only dynamic information
    ///and read/write information are available for this enumeration value.
    TcpConnectionEstatsData      = 0x00000001,
    ///This value specifies sender congestion for a TCP connection. All three types of information (read-only static,
    ///read-only dynamic, and read/write information) are available for this enumeration value.
    TcpConnectionEstatsSndCong   = 0x00000002,
    ///This value specifies extended path measurement information for a TCP connection. This information is used to
    ///infer segment reordering on the path from the local sender to the remote receiver. Only read-only dynamic
    ///information and read/write information are available for this enumeration value.
    TcpConnectionEstatsPath      = 0x00000003,
    ///This value specifies extended output-queuing information for a TCP connection. Only read-only dynamic information
    ///and read/write information are available for this enumeration value.
    TcpConnectionEstatsSendBuff  = 0x00000004,
    ///This value specifies extended local-receiver information for a TCP connection. Only read-only dynamic information
    ///and read/write information are available for this enumeration value.
    TcpConnectionEstatsRec       = 0x00000005,
    ///This value specifies extended remote-receiver information for a TCP connection. Only read-only dynamic
    ///information and read/write information are available for this enumeration value.
    TcpConnectionEstatsObsRec    = 0x00000006,
    ///This value specifies bandwidth estimation statistics for a TCP connection on bandwidth. Only read-only dynamic
    ///information and read/write information are available for this enumeration value.
    TcpConnectionEstatsBandwidth = 0x00000007,
    ///This value specifies fine-grained round-trip time (RTT) estimation statistics for a TCP connection. Only
    ///read-only dynamic information and read/write information are available for this enumeration value.
    TcpConnectionEstatsFineRtt   = 0x00000008,
    ///The maximum possible value for the TCP_ESTATS_TYPE_STATE enumeration type. This is not a legal value for the
    ///possible type of extended statistics for a TCP connection.
    TcpConnectionEstatsMaximum   = 0x00000009,
}

///The <b>TCP_BOOLEAN_OPTIONAL</b> enumeration defines the states that a caller can specify when updating a member in
///the read/write information for a TCP connection.
alias TCP_BOOLEAN_OPTIONAL = int;
enum : int
{
    ///The option should be disabled.
    TcpBoolOptDisabled  = 0x00000000,
    ///The option should be enabled.
    TcpBoolOptEnabled   = 0x00000001,
    ///The option should be unchanged.
    TcpBoolOptUnchanged = 0xffffffff,
}

///The <b>TCP_SOFT_ERROR</b> enumeration defines the reason for non-fatal or soft errors recorded on a TCP connection.
alias TCP_SOFT_ERROR = int;
enum : int
{
    ///No soft errors have occurred.
    TcpErrorNone              = 0x00000000,
    ///All data in the segment is below the send unacknowledged (SND.UNA) sequence number. This soft error is normal for
    ///keep-alives and zero window probes.
    TcpErrorBelowDataWindow   = 0x00000001,
    ///Some data in the segment is above send window (SND.WND) size. This soft error indicates an implementation bug or
    ///possible attack.
    TcpErrorAboveDataWindow   = 0x00000002,
    ///An ACK was received below the SND.UNA sequence number. This soft error indicates that the return path is
    ///reordering ACKs.
    TcpErrorBelowAckWindow    = 0x00000003,
    ///An ACK was received for data that we have not sent. This soft error indicates an implementation bug or possible
    ///attack.
    TcpErrorAboveAckWindow    = 0x00000004,
    ///The Timestamp Echo Reply (TSecr) on the segment is older than the current TS.Recent (a timestamp to be echoed in
    ///TSecr whenever a segment is sent). This error is applicable to TCP connections that use the TCP Timestamps option
    ///(TSopt) defined by the IETF in RFC 1323. For more information, see http://www.ietf.org/rfc/rfc1323.txt. This soft
    ///error is normal for the rare case where the Protect Against Wrapped Sequences numbers (PAWS) mechanism detects
    ///data reordered by the network.
    TcpErrorBelowTsWindow     = 0x00000005,
    ///The TSecr on the segment is newer than the current TS.Recent. This soft error indicates an implementation bug or
    ///possible attack.
    TcpErrorAboveTsWindow     = 0x00000006,
    ///An incorrect TCP checksum was received. Note that this value is intrinsically fragile, because the header fields
    ///used to identify the connection may have been corrupted.
    TcpErrorDataChecksumError = 0x00000007,
    ///A data length error occurred. This value is not defined in the IETF draft RFC on the TCP Extended Statistics MIB.
    TcpErrorDataLengthError   = 0x00000008,
    ///The maximum possible value for the TCP_SOFT_ERROR_STATE enumeration type. This is not a legal value for the
    ///reason for a soft error for a TCP connection.
    TcpErrorMaxSoftError      = 0x00000009,
}

///The <b>NET_ADDRESS_FORMAT</b> enumeration specifies the format of a network address returned by the
///ParseNetworkString function.
alias NET_ADDRESS_FORMAT = int;
enum : int
{
    ///The format of the network address is unspecified.
    NET_ADDRESS_FORMAT_UNSPECIFIED = 0x00000000,
    ///The format of the network address is a DNS name.
    NET_ADDRESS_DNS_NAME           = 0x00000001,
    ///The format of the network address is a string in Internet standard dotted-decimal notation for IPv4.
    NET_ADDRESS_IPV4               = 0x00000002,
    ///The format of the network address is a string in Internet standard hexadecimal encoding for IPv6.
    NET_ADDRESS_IPV6               = 0x00000003,
}

///The <b>SCOPE_LEVEL</b> enumeration is used with the IP_ADAPTER_ADDRESSES structure to identify scope levels for IPv6
///addresses.
alias SCOPE_LEVEL = int;
enum : int
{
    ///The scope is interface-level.
    ScopeLevelInterface    = 0x00000001,
    ///The scope is link-level.
    ScopeLevelLink         = 0x00000002,
    ///The scope is subnet-level.
    ScopeLevelSubnet       = 0x00000003,
    ///The scope is admin-level.
    ScopeLevelAdmin        = 0x00000004,
    ///The scope is site-level.
    ScopeLevelSite         = 0x00000005,
    ///The scope is organization-level.
    ScopeLevelOrganization = 0x00000008,
    ///The scope is global.
    ScopeLevelGlobal       = 0x0000000e,
    ScopeLevelCount        = 0x00000010,
}

///The <b>IP_PREFIX_ORIGIN</b> enumeration specifies the origin of an IPv4 or IPv6 address prefix, and is used with the
///IP_ADAPTER_UNICAST_ADDRESS structure.
alias NL_PREFIX_ORIGIN = int;
enum : int
{
    ///The IP prefix was provided by a source other than those defined in this enumeration.
    IpPrefixOriginOther               = 0x00000000,
    ///The IP address prefix was manually specified.
    IpPrefixOriginManual              = 0x00000001,
    ///The IP address prefix is from a well known source.
    IpPrefixOriginWellKnown           = 0x00000002,
    ///The IP address prefix was provided by DHCP settings.
    IpPrefixOriginDhcp                = 0x00000003,
    ///The IP address prefix was obtained through a router advertisement (RA).
    IpPrefixOriginRouterAdvertisement = 0x00000004,
    ///The IP address prefix should be unchanged. This value is used when setting the properties for a unicast IP
    ///interface when the value for the IP prefix origin should be left unchanged. <div class="alert"><b>Note</b> This
    ///enumeration value is only available on Windows Vista and later.</div> <div> </div>
    IpPrefixOriginUnchanged           = 0x00000010,
}

///The <b>IP_SUFFIX_ORIGIN</b> enumeration specifies the origin of an IPv4 or IPv6 address suffix, and is used with the
///IP_ADAPTER_UNICAST_ADDRESS structure.
alias NL_SUFFIX_ORIGIN = int;
enum : int
{
    NlsoOther                      = 0x00000000,
    NlsoManual                     = 0x00000001,
    NlsoWellKnown                  = 0x00000002,
    NlsoDhcp                       = 0x00000003,
    NlsoLinkLayerAddress           = 0x00000004,
    NlsoRandom                     = 0x00000005,
    ///The IP address suffix was provided by a source other than those defined in this enumeration.
    IpSuffixOriginOther            = 0x00000000,
    ///The IP address suffix was manually specified.
    IpSuffixOriginManual           = 0x00000001,
    ///The IP address suffix is from a well-known source.
    IpSuffixOriginWellKnown        = 0x00000002,
    ///The IP address suffix was provided by DHCP settings.
    IpSuffixOriginDhcp             = 0x00000003,
    ///The IP address suffix was obtained from the link-layer address.
    IpSuffixOriginLinkLayerAddress = 0x00000004,
    ///The IP address suffix was obtained from a random source.
    IpSuffixOriginRandom           = 0x00000005,
    ///The IP address suffix should be unchanged. This value is used when setting the properties for a unicast IP
    ///interface when the value for the IP suffix origin should be left unchanged. <div class="alert"><b>Note</b> This
    ///enumeration value is only available on Windows Vista and later.</div> <div> </div>
    IpSuffixOriginUnchanged        = 0x00000010,
}

///The <b>IP_DAD_STATE</b> enumeration specifies information about the duplicate address detection (DAD) state for an
///IPv4 or IPv6 address.
alias NL_DAD_STATE = int;
enum : int
{
    NldsInvalid          = 0x00000000,
    NldsTentative        = 0x00000001,
    NldsDuplicate        = 0x00000002,
    NldsDeprecated       = 0x00000003,
    NldsPreferred        = 0x00000004,
    ///The DAD state is invalid.
    IpDadStateInvalid    = 0x00000000,
    ///The DAD state is tentative.
    IpDadStateTentative  = 0x00000001,
    ///A duplicate IP address has been detected.
    IpDadStateDuplicate  = 0x00000002,
    ///The IP address has been deprecated.
    IpDadStateDeprecated = 0x00000003,
    ///The IP address is the preferred address.
    IpDadStatePreferred  = 0x00000004,
}

///Defines constants that specify hints about a level of network connectivity.
alias NL_NETWORK_CONNECTIVITY_LEVEL_HINT = int;
enum : int
{
    ///Specifies a hint for an unknown level of connectivity. There is a short window of time during Windows (or
    ///application container) boot when this value might be returned.
    NetworkConnectivityLevelHintUnknown                   = 0x00000000,
    ///Specifies a hint for no connectivity.
    NetworkConnectivityLevelHintNone                      = 0x00000001,
    ///Specifies a hint for local network access only.
    NetworkConnectivityLevelHintLocalAccess               = 0x00000002,
    ///Specifies a hint for local and internet access.
    NetworkConnectivityLevelHintInternetAccess            = 0x00000003,
    ///Specifies a hint for limited internet access. This value indicates captive portal connectivity, where local
    ///access to a web portal is provided, but access to the internet requires that specific credentials are provided
    ///via the portal. This level of connectivity is generally encountered when using connections hosted in public
    ///locations (for example, coffee shops and book stores). This doesn't guarantee detection of a captive portal. You
    ///should be aware that when Windows reports the connectivity level hint as
    ///**NetworkConnectivityLevelHintLocalAccess**, your application's network requests might be redirected, and thus
    ///receive a different response than expected. Other protocols might also be impacted; for example, HTTPS might be
    ///redirected, and fail authentication.
    NetworkConnectivityLevelHintConstrainedInternetAccess = 0x00000004,
    ///Specifies a hint for a network interface that's hidden from normal connectivity (and is not, by default,
    ///accessible to applications). This could be because no packets are allowed at all over that network (for example,
    ///the adapter flags itself **NCF_HIDDEN**), or (by default) routes are ignored on that interface (for example, a
    ///cellular network is hidden when WiFi is connected).
    NetworkConnectivityLevelHintHidden                    = 0x00000005,
}

///Defines constants that specify hints about the usage charge for a network connection.
alias NL_NETWORK_CONNECTIVITY_COST_HINT = int;
enum : int
{
    ///Specifies a hint that cost information is not available.
    NetworkConnectivityCostHintUnknown      = 0x00000000,
    ///Specifies a hint that the connection is unlimited, and has unrestricted usage charges and capacity constraints.
    NetworkConnectivityCostHintUnrestricted = 0x00000001,
    ///Specifies a hint that the use of the connection is unrestricted up to a specific limit.
    NetworkConnectivityCostHintFixed        = 0x00000002,
    ///Specifies a hint that the connection is charged on a per-byte basis.
    NetworkConnectivityCostHintVariable     = 0x00000003,
}

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
///The **PNETWORK_CONNECTIVITY_HINT_CHANGE_CALLBACK** type is a pointer to a function that you define in your
///application. The function is called whenever there's a change in the network aggregate connectivity level and cost
///hints. Register your callback with a call to
///[NotifyNetworkConnectivityHintChange](./nf-netioapi-notifynetworkconnectivityhintchange.md).
///Params:
///    CallerContext = The user-specific caller context.
///    ConnectivityHint = A value of type [NL_NETWORK_CONNECTIVITY_HINT](../nldef/ns-nldef-nl_network_connectivity_hint.md) representing
///                       the aggregate connectivity level and cost hints.
alias PNETWORK_CONNECTIVITY_HINT_CHANGE_CALLBACK = void function(void* CallerContext, 
                                                                 NL_NETWORK_CONNECTIVITY_HINT ConnectivityHint);
///This callback is reserved for system use, and you should not use it in your code.
alias INTERFACE_TIMESTAMP_CONFIG_CHANGE_CALLBACK = void function(void* CallerContext);
alias PINTERFACE_TIMESTAMP_CONFIG_CHANGE_CALLBACK = void function();

// Structs


///The <b>IP_OPTION_INFORMATION</b> structure describes the options to be included in the header of an IP packet.
struct ip_option_information
{
    ///Type: <b>UCHAR</b> The Time to Live field in an IPv4 packet header. This is the Hop Limit field in an IPv6
    ///header.
    ubyte  Ttl;
    ///Type: <b>UCHAR</b> The type of service field in an IPv4 header. This member is currently silently ignored.
    ubyte  Tos;
    ///Type: <b>UCHAR</b> The Flags field. In IPv4, this is the Flags field in the IPv4 header. In IPv6, this field is
    ///represented by options headers. For IPv4, the possible values for the <b>Flags</b> member are a combination of
    ///the following values defined in the <i>Ipexport.h</i> header file: <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="IP_FLAG_REVERSE"></a><a id="ip_flag_reverse"></a><dl>
    ///<dt><b>IP_FLAG_REVERSE</b></dt> <dt>0x01</dt> </dl> </td> <td width="60%"> This value causes the IP packet to add
    ///in an IP routing header with the source. This value is only applicable on Windows Vistaand later. </td> </tr>
    ///<tr> <td width="40%"><a id="IP_FLAG_DF"></a><a id="ip_flag_df"></a><dl> <dt><b>IP_FLAG_DF</b></dt> <dt>0x02</dt>
    ///</dl> </td> <td width="60%"> This value indicates that the packet should not be fragmented. </td> </tr> </table>
    ubyte  Flags;
    ///Type: <b>UCHAR</b> The size, in bytes, of IP options data.
    ubyte  OptionsSize;
    ///Type: <b>PUCHAR</b> A pointer to options data.
    ubyte* OptionsData;
}

///The <b>ICMP_ECHO_REPLY</b> structure describes the data returned in response to an IPv4 echo request.
struct icmp_echo_reply
{
    ///Type: <b>IPAddr</b> The replying IPv4 address, in the form of an IPAddr structure.
    uint   Address;
    ///Type: <b>ULONG</b> The status of the echo request, in the form of an <b>IP_STATUS</b> code. The possible values
    ///for this member are defined in the <i>Ipexport.h</i> header file. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="IP_SUCCESS"></a><a id="ip_success"></a><dl> <dt><b>IP_SUCCESS</b></dt>
    ///<dt>0</dt> </dl> </td> <td width="60%"> The status was success. </td> </tr> <tr> <td width="40%"><a
    ///id="IP_BUF_TOO_SMALL"></a><a id="ip_buf_too_small"></a><dl> <dt><b>IP_BUF_TOO_SMALL</b></dt> <dt>11001</dt> </dl>
    ///</td> <td width="60%"> The reply buffer was too small. </td> </tr> <tr> <td width="40%"><a
    ///id="IP_DEST_NET_UNREACHABLE"></a><a id="ip_dest_net_unreachable"></a><dl> <dt><b>IP_DEST_NET_UNREACHABLE</b></dt>
    ///<dt>11002</dt> </dl> </td> <td width="60%"> The destination network was unreachable. </td> </tr> <tr> <td
    ///width="40%"><a id="IP_DEST_HOST_UNREACHABLE"></a><a id="ip_dest_host_unreachable"></a><dl>
    ///<dt><b>IP_DEST_HOST_UNREACHABLE</b></dt> <dt>11003</dt> </dl> </td> <td width="60%"> The destination host was
    ///unreachable. </td> </tr> <tr> <td width="40%"><a id="IP_DEST_PROT_UNREACHABLE"></a><a
    ///id="ip_dest_prot_unreachable"></a><dl> <dt><b>IP_DEST_PROT_UNREACHABLE</b></dt> <dt>11004</dt> </dl> </td> <td
    ///width="60%"> The destination protocol was unreachable. </td> </tr> <tr> <td width="40%"><a
    ///id="IP_DEST_PORT_UNREACHABLE"></a><a id="ip_dest_port_unreachable"></a><dl>
    ///<dt><b>IP_DEST_PORT_UNREACHABLE</b></dt> <dt>11005</dt> </dl> </td> <td width="60%"> The destination port was
    ///unreachable. </td> </tr> <tr> <td width="40%"><a id="IP_NO_RESOURCES"></a><a id="ip_no_resources"></a><dl>
    ///<dt><b>IP_NO_RESOURCES</b></dt> <dt>11006</dt> </dl> </td> <td width="60%"> Insufficient IP resources were
    ///available. </td> </tr> <tr> <td width="40%"><a id="IP_BAD_OPTION_"></a><a id="ip_bad_option_"></a><dl>
    ///<dt><b>IP_BAD_OPTION </b></dt> <dt>11007</dt> </dl> </td> <td width="60%"> A bad IP option was specified. </td>
    ///</tr> <tr> <td width="40%"><a id="IP_HW_ERROR"></a><a id="ip_hw_error"></a><dl> <dt><b>IP_HW_ERROR</b></dt>
    ///<dt>11008</dt> </dl> </td> <td width="60%"> A hardware error occurred. </td> </tr> <tr> <td width="40%"><a
    ///id="IP_PACKET_TOO_BIG"></a><a id="ip_packet_too_big"></a><dl> <dt><b>IP_PACKET_TOO_BIG</b></dt> <dt>11009</dt>
    ///</dl> </td> <td width="60%"> The packet was too big. </td> </tr> <tr> <td width="40%"><a
    ///id="IP_REQ_TIMED_OUT"></a><a id="ip_req_timed_out"></a><dl> <dt><b>IP_REQ_TIMED_OUT</b></dt> <dt>11010</dt> </dl>
    ///</td> <td width="60%"> The request timed out. </td> </tr> <tr> <td width="40%"><a id="IP_BAD_REQ"></a><a
    ///id="ip_bad_req"></a><dl> <dt><b>IP_BAD_REQ</b></dt> <dt>11011</dt> </dl> </td> <td width="60%"> A bad request.
    ///</td> </tr> <tr> <td width="40%"><a id="IP_BAD_ROUTE"></a><a id="ip_bad_route"></a><dl>
    ///<dt><b>IP_BAD_ROUTE</b></dt> <dt>11012</dt> </dl> </td> <td width="60%"> A bad route. </td> </tr> <tr> <td
    ///width="40%"><a id="IP_TTL_EXPIRED_TRANSIT"></a><a id="ip_ttl_expired_transit"></a><dl>
    ///<dt><b>IP_TTL_EXPIRED_TRANSIT</b></dt> <dt>11013</dt> </dl> </td> <td width="60%"> The time to live (TTL) expired
    ///in transit. </td> </tr> <tr> <td width="40%"><a id="IP_TTL_EXPIRED_REASSEM"></a><a
    ///id="ip_ttl_expired_reassem"></a><dl> <dt><b>IP_TTL_EXPIRED_REASSEM</b></dt> <dt>11014</dt> </dl> </td> <td
    ///width="60%"> The time to live expired during fragment reassembly. </td> </tr> <tr> <td width="40%"><a
    ///id="IP_PARAM_PROBLEM"></a><a id="ip_param_problem"></a><dl> <dt><b>IP_PARAM_PROBLEM</b></dt> <dt>11015</dt> </dl>
    ///</td> <td width="60%"> A parameter problem. </td> </tr> <tr> <td width="40%"><a id="IP_SOURCE_QUENCH"></a><a
    ///id="ip_source_quench"></a><dl> <dt><b>IP_SOURCE_QUENCH</b></dt> <dt>11016</dt> </dl> </td> <td width="60%">
    ///Datagrams are arriving too fast to be processed and datagrams may have been discarded. </td> </tr> <tr> <td
    ///width="40%"><a id="IP_OPTION_TOO_BIG"></a><a id="ip_option_too_big"></a><dl> <dt><b>IP_OPTION_TOO_BIG</b></dt>
    ///<dt>11017</dt> </dl> </td> <td width="60%"> An IP option was too big. </td> </tr> <tr> <td width="40%"><a
    ///id="IP_BAD_DESTINATION"></a><a id="ip_bad_destination"></a><dl> <dt><b>IP_BAD_DESTINATION</b></dt> <dt>11018</dt>
    ///</dl> </td> <td width="60%"> A bad destination. </td> </tr> <tr> <td width="40%"><a
    ///id="IP_GENERAL_FAILURE"></a><a id="ip_general_failure"></a><dl> <dt><b>IP_GENERAL_FAILURE</b></dt> <dt>11050</dt>
    ///</dl> </td> <td width="60%"> A general failure. This error can be returned for some malformed ICMP packets. </td>
    ///</tr> </table>
    uint   Status;
    ///Type: <b>ULONG</b> The round trip time, in milliseconds.
    uint   RoundTripTime;
    ///Type: <b>USHORT</b> The data size, in bytes, of the reply.
    ushort DataSize;
    ///Type: <b>USHORT</b> Reserved for system use.
    ushort Reserved;
    ///Type: <b>PVOID</b> A pointer to the reply data.
    void*  Data;
    ///Type: <b>struct ip_option_information</b> The IP options in the IP header of the reply, in the form of an
    ///IP_OPTION_INFORMATION structure.
    ip_option_information Options;
}

///The <b>IPV6_ADDRESS_EX</b> structure stores an IPv6 address.
struct IPV6_ADDRESS_EX
{
align (1):
    ///The IPv6 port number in network byte order.
    ushort    sin6_port;
    ///The IPv6 flowinfo value from the IPv6 header in network byte order.
    uint      sin6_flowinfo;
    ///The IPv6 address in network byte order.
    ushort[8] sin6_addr;
    ///The IPv6 scope ID in network byte order.
    uint      sin6_scope_id;
}

///The <b>ICMPV6_ECHO_REPLY</b> structure describes the data returned in response to an IPv6 echo request.
struct icmpv6_echo_reply_lh
{
    ///Type: <b>IPV6_ADDRESS_EX</b> The replying IPv6 address, in the form of an IPV6_ADDRESS_EX structure.
    IPV6_ADDRESS_EX Address;
    ///Type: <b>ULONG</b> The status of the echo request, in the form of an <b>IP_STATUS</b> code. The possible values
    ///for this member are defined in the <i>Ipexport.h</i> header file. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="IP_SUCCESS"></a><a id="ip_success"></a><dl> <dt><b>IP_SUCCESS</b></dt>
    ///<dt>0</dt> </dl> </td> <td width="60%"> The status was success. </td> </tr> <tr> <td width="40%"><a
    ///id="IP_BUF_TOO_SMALL"></a><a id="ip_buf_too_small"></a><dl> <dt><b>IP_BUF_TOO_SMALL</b></dt> <dt>11001</dt> </dl>
    ///</td> <td width="60%"> The reply buffer was too small. </td> </tr> <tr> <td width="40%"><a
    ///id="IP_DEST_NET_UNREACHABLE"></a><a id="ip_dest_net_unreachable"></a><dl> <dt><b>IP_DEST_NET_UNREACHABLE</b></dt>
    ///<dt>11002</dt> </dl> </td> <td width="60%"> The destination network was unreachable. In IPv6 terminology, this
    ///status value is also defined as <b>IP_DEST_NO_ROUTE</b>. </td> </tr> <tr> <td width="40%"><a
    ///id="IP_DEST_HOST_UNREACHABLE"></a><a id="ip_dest_host_unreachable"></a><dl>
    ///<dt><b>IP_DEST_HOST_UNREACHABLE</b></dt> <dt>11003</dt> </dl> </td> <td width="60%"> The destination host was
    ///unreachable. In IPv6 terminology, this status value is also defined as <b>IP_DEST_ADDR_UNREACHABLE</b>. </td>
    ///</tr> <tr> <td width="40%"><a id="IP_DEST_PROT_UNREACHABLE"></a><a id="ip_dest_prot_unreachable"></a><dl>
    ///<dt><b>IP_DEST_PROT_UNREACHABLE</b></dt> <dt>11004</dt> </dl> </td> <td width="60%"> The destination protocol was
    ///unreachable. In IPv6 terminology, this status value is also defined as <b>IP_DEST_PROHIBITED</b>. </td> </tr>
    ///<tr> <td width="40%"><a id="IP_DEST_PORT_UNREACHABLE"></a><a id="ip_dest_port_unreachable"></a><dl>
    ///<dt><b>IP_DEST_PORT_UNREACHABLE</b></dt> <dt>11005</dt> </dl> </td> <td width="60%"> The destination port was
    ///unreachable. </td> </tr> <tr> <td width="40%"><a id="IP_NO_RESOURCES"></a><a id="ip_no_resources"></a><dl>
    ///<dt><b>IP_NO_RESOURCES</b></dt> <dt>11006</dt> </dl> </td> <td width="60%"> Insufficient IP resources were
    ///available. </td> </tr> <tr> <td width="40%"><a id="IP_BAD_OPTION_"></a><a id="ip_bad_option_"></a><dl>
    ///<dt><b>IP_BAD_OPTION </b></dt> <dt>11007</dt> </dl> </td> <td width="60%"> A bad IP option was specified. </td>
    ///</tr> <tr> <td width="40%"><a id="IP_HW_ERROR"></a><a id="ip_hw_error"></a><dl> <dt><b>IP_HW_ERROR</b></dt>
    ///<dt>11008</dt> </dl> </td> <td width="60%"> A hardware error occurred. </td> </tr> <tr> <td width="40%"><a
    ///id="IP_PACKET_TOO_BIG"></a><a id="ip_packet_too_big"></a><dl> <dt><b>IP_PACKET_TOO_BIG</b></dt> <dt>11009</dt>
    ///</dl> </td> <td width="60%"> The packet was too big. </td> </tr> <tr> <td width="40%"><a
    ///id="IP_REQ_TIMED_OUT"></a><a id="ip_req_timed_out"></a><dl> <dt><b>IP_REQ_TIMED_OUT</b></dt> <dt>11010</dt> </dl>
    ///</td> <td width="60%"> The request timed out. </td> </tr> <tr> <td width="40%"><a id="IP_BAD_REQ"></a><a
    ///id="ip_bad_req"></a><dl> <dt><b>IP_BAD_REQ</b></dt> <dt>11011</dt> </dl> </td> <td width="60%"> A bad request.
    ///</td> </tr> <tr> <td width="40%"><a id="IP_BAD_ROUTE"></a><a id="ip_bad_route"></a><dl>
    ///<dt><b>IP_BAD_ROUTE</b></dt> <dt>11012</dt> </dl> </td> <td width="60%"> A bad route. </td> </tr> <tr> <td
    ///width="40%"><a id="IP_TTL_EXPIRED_TRANSIT"></a><a id="ip_ttl_expired_transit"></a><dl>
    ///<dt><b>IP_TTL_EXPIRED_TRANSIT</b></dt> <dt>11013</dt> </dl> </td> <td width="60%"> The hop limit for IPv6 expired
    ///in transit. In IPv6 terminology, this status value is also defined as <b>IP_HOP_LIMIT_EXCEEDED</b>. </td> </tr>
    ///<tr> <td width="40%"><a id="IP_TTL_EXPIRED_REASSEM"></a><a id="ip_ttl_expired_reassem"></a><dl>
    ///<dt><b>IP_TTL_EXPIRED_REASSEM</b></dt> <dt>11014</dt> </dl> </td> <td width="60%"> The hop limit for IPv6 expired
    ///during fragment reassembly. In IPv6 terminology, this status value is also defined as
    ///<b>IP_REASSEMBLY_TIME_EXCEEDED</b>. </td> </tr> <tr> <td width="40%"><a id="IP_PARAM_PROBLEM"></a><a
    ///id="ip_param_problem"></a><dl> <dt><b>IP_PARAM_PROBLEM</b></dt> <dt>11015</dt> </dl> </td> <td width="60%"> A
    ///parameter problem. In IPv6 terminology, this status value is also defined as <b>IP_PARAMETER_PROBLEM</b>. </td>
    ///</tr> <tr> <td width="40%"><a id="IP_SOURCE_QUENCH"></a><a id="ip_source_quench"></a><dl>
    ///<dt><b>IP_SOURCE_QUENCH</b></dt> <dt>11016</dt> </dl> </td> <td width="60%"> Datagrams are arriving too fast to
    ///be processed and datagrams may have been discarded. </td> </tr> <tr> <td width="40%"><a
    ///id="IP_OPTION_TOO_BIG"></a><a id="ip_option_too_big"></a><dl> <dt><b>IP_OPTION_TOO_BIG</b></dt> <dt>11017</dt>
    ///</dl> </td> <td width="60%"> An IP option was too big. </td> </tr> <tr> <td width="40%"><a
    ///id="IP_BAD_DESTINATION"></a><a id="ip_bad_destination"></a><dl> <dt><b>IP_BAD_DESTINATION</b></dt> <dt>11018</dt>
    ///</dl> </td> <td width="60%"> A bad destination. </td> </tr> <tr> <td width="40%"><a
    ///id="IP_DEST_UNREACHABLE"></a><a id="ip_dest_unreachable"></a><dl> <dt><b>IP_DEST_UNREACHABLE</b></dt>
    ///<dt>11040</dt> </dl> </td> <td width="60%"> The destination was unreachable. </td> </tr> <tr> <td width="40%"><a
    ///id="IP_TIME_EXCEEDED"></a><a id="ip_time_exceeded"></a><dl> <dt><b>IP_TIME_EXCEEDED</b></dt> <dt>11041</dt> </dl>
    ///</td> <td width="60%"> The time was exceeded. </td> </tr> <tr> <td width="40%"><a id="IP_BAD_HEADER"></a><a
    ///id="ip_bad_header"></a><dl> <dt><b>IP_BAD_HEADER</b></dt> <dt>11042</dt> </dl> </td> <td width="60%"> A bad IP
    ///header was encountered. </td> </tr> <tr> <td width="40%"><a id="IP_UNRECOGNIZED_NEXT_HEADER"></a><a
    ///id="ip_unrecognized_next_header"></a><dl> <dt><b>IP_UNRECOGNIZED_NEXT_HEADER</b></dt> <dt>11043</dt> </dl> </td>
    ///<td width="60%"> An unrecognized next header was encountered. </td> </tr> <tr> <td width="40%"><a
    ///id="IP_ICMP_ERROR"></a><a id="ip_icmp_error"></a><dl> <dt><b>IP_ICMP_ERROR</b></dt> <dt>11044</dt> </dl> </td>
    ///<td width="60%"> An ICMP error occurred. </td> </tr> <tr> <td width="40%"><a id="IP_DEST_SCOPE_MISMATCH"></a><a
    ///id="ip_dest_scope_mismatch"></a><dl> <dt><b>IP_DEST_SCOPE_MISMATCH</b></dt> <dt>11045</dt> </dl> </td> <td
    ///width="60%"> A destination scope ID mismatch occurred. </td> </tr> <tr> <td width="40%"><a
    ///id="IP_GENERAL_FAILURE"></a><a id="ip_general_failure"></a><dl> <dt><b>IP_GENERAL_FAILURE</b></dt> <dt>11050</dt>
    ///</dl> </td> <td width="60%"> A general failure. This error can be returned for some malformed ICMP packets. </td>
    ///</tr> </table>
    uint            Status;
    ///Type: <b>unsigned int</b> The round trip time, in milliseconds.
    uint            RoundTripTime;
}

///The <b>ARP_SEND_REPLY</b> structure stores information about an Address Resolution Protocol (ARP) reply messages.
struct arp_send_reply
{
    ///The destination IPv4 address to which the ARP message is sent, in the form of an IPAddr structure.
    uint DestAddress;
    ///The source IPv4 address from which the ARP message is being transmitted, in the form of an IPAddr structure.
    uint SrcAddress;
}

///The <b>TCP_RESERVE_PORT_RANGE</b> structure specifies a TCP port range to reserve.
struct tcp_reserve_port_range
{
    ///Value for the upper bound of the TCP port range to reserve.
    ushort UpperRange;
    ///Value for the lower bound of the TCP port range to reserve.
    ushort LowerRange;
}

///The <b>IP_ADAPTER_INDEX_MAP</b> structure stores the interface index associated with a network adapter with IPv4
///enabled together with the name of the network adapter.
struct IP_ADAPTER_INDEX_MAP
{
    ///The interface index associated with the network adapter.
    uint        Index;
    ///A pointer to a Unicode string that contains the name of the adapter.
    ushort[128] Name;
}

///The <b>IP_INTERFACE_INFO</b> structure contains a list of the network interface adapters with IPv4 enabled on the
///local system.
struct IP_INTERFACE_INFO
{
    ///The number of adapters listed in the array pointed to by the <b>Adapter</b> member.
    int NumAdapters;
    ///An array of IP_ADAPTER_INDEX_MAP structures. Each structure maps an adapter index to that adapter's name. The
    ///adapter index may change when an adapter is disabled and then enabled, or under other circumstances, and should
    ///not be considered persistent.
    IP_ADAPTER_INDEX_MAP[1] Adapter;
}

///The <b>IP_UNIDIRECTIONAL_ADAPTER_ADDRESS</b> structure stores the IPv4 addresses associated with a unidirectional
///adapter.
struct IP_UNIDIRECTIONAL_ADAPTER_ADDRESS
{
    ///The number of IPv4 addresses pointed to by the <b>Address</b> member.
    uint    NumAdapters;
    ///An array of variables of type IPAddr. Each element of the array specifies an IPv4 address associated with this
    ///unidirectional adapter.
    uint[1] Address;
}

///The <b>IP_ADAPTER_ORDER_MAP</b> structure stores an array of information about adapters and their relative priority
///on the local computer.
struct IP_ADAPTER_ORDER_MAP
{
    ///The number of network adapters in the <b>AdapterOrder</b> member.
    uint    NumAdapters;
    ///An array of adapter indexes on the local computer, provided in the order specified in the <b>Adapters and
    ///Bindings</b> dialog box for <b>Network Connections</b>.
    uint[1] AdapterOrder;
}

///The <b>IP_MCAST_COUNTER_INFO</b> structure stores statistical information about Multicast traffic.
struct IP_MCAST_COUNTER_INFO
{
    ///The number of multicast octets received.
    ulong InMcastOctets;
    ///The number of multicast octets transmitted.
    ulong OutMcastOctets;
    ///The number of multicast packets received.
    ulong InMcastPkts;
    ///The number of multicast packets transmitted.
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

///The <b>NET_LUID</b> union is the locally unique identifier (LUID) for a network interface.
union NET_LUID_LH
{
    ///Type: <b>ULONG64</b> A 64-bit value that represents the LUID.
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

///The <b>IP_ADDRESS_PREFIX</b> structure stores an IP address prefix.
struct IP_ADDRESS_PREFIX
{
    ///The prefix or network part of IP the address represented as an IP address. The SOCKADDR_INET union is defined in
    ///the <i>Ws2ipdef.h</i> header.
    SOCKADDR_INET Prefix;
    ///The length, in bits, of the prefix or network part of the IP address. For a unicast IPv4 address, any value
    ///greater than 32 is an illegal value. For a unicast IPv6 address, any value greater than 128 is an illegal value.
    ///A value of 255 is commonly used to represent an illegal value.
    ubyte         PrefixLength;
}

struct DNS_SETTINGS
{
    uint  Version;
    ulong Flags;
    PWSTR Hostname;
    PWSTR Domain;
    PWSTR SearchList;
}

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

///The <b>TCPIP_OWNER_MODULE_BASIC_INFO</b> structure contains pointers to the module name and module path values
///associated with a TCP connection. The <b>TCPIP_OWNER_MODULE_BASIC_INFO</b> structure is returned by the
///GetOwnerModuleFromTcpEntry and GetOwnerModuleFromTcp6Entry functions.
struct TCPIP_OWNER_MODULE_BASIC_INFO
{
    ///A pointer to the name of the module. This field should be a <b>NULL</b> pointer when passed to
    ///GetOwnerModuleFromTcpEntry or GetOwnerModuleFromTcp6Entry function.
    PWSTR pModuleName;
    ///A pointer to the full path of the module, including the module name. This field should be a <b>NULL</b> pointer
    ///when passed to GetOwnerModuleFromTcpEntry or GetOwnerModuleFromTcp6Entry function.
    PWSTR pModulePath;
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

///The <b>IP_ADDRESS_STRING</b> structure stores an IPv4 address in dotted decimal notation. The
///<b>IP_ADDRESS_STRING</b> structure definition is also the type definition for the <b>IP_MASK_STRING</b> structure.
struct IP_ADDRESS_STRING
{
    ///A character string that represents an IPv4 address or an IPv4 subnet mask in dotted decimal notation.
    byte[16] String;
}

///The <b>IP_ADDR_STRING</b> structure represents a node in a linked-list of IPv4 addresses.
struct IP_ADDR_STRING
{
    ///A pointer to the next <b>IP_ADDR_STRING</b> structure in the list.
    IP_ADDR_STRING*   Next;
    ///A value that specifies a structure type with a single member, <b>String</b>. The <b>String</b> member is a
    ///<b>char</b> array of size 16. This array holds an IPv4 address in dotted decimal notation.
    IP_ADDRESS_STRING IpAddress;
    ///A value that specifies a structure type with a single member, <b>String</b>. The <b>String</b> member is a
    ///<b>char</b> array of size 16. This array holds the IPv4 subnet mask in dotted decimal notation.
    IP_ADDRESS_STRING IpMask;
    ///A network table entry (NTE). This value corresponds to the <i>NTEContext</i> parameters in the AddIPAddress and
    ///DeleteIPAddress functions.
    uint              Context;
}

///The <b>IP_ADAPTER_INFO</b> structure contains information about a particular network adapter on the local computer.
struct IP_ADAPTER_INFO
{
    ///Type: <b>struct _IP_ADAPTER_INFO*</b> A pointer to the next adapter in the list of adapters.
    IP_ADAPTER_INFO* Next;
    ///Type: <b>DWORD</b> Reserved.
    uint             ComboIndex;
    ///Type: <b>char[MAX_ADAPTER_NAME_LENGTH + 4]</b> An ANSI character string of the name of the adapter.
    byte[260]        AdapterName;
    ///Type: <b>char[MAX_ADAPTER_DESCRIPTION_LENGTH + 4]</b> An ANSI character string that contains the description of
    ///the adapter.
    byte[132]        Description;
    ///Type: <b>UINT</b> The length, in bytes, of the hardware address for the adapter.
    uint             AddressLength;
    ///Type: <b>BYTE[MAX_ADAPTER_ADDRESS_LENGTH]</b> The hardware address for the adapter represented as a <b>BYTE</b>
    ///array.
    ubyte[8]         Address;
    ///Type: <b>DWORD</b> The adapter index. The adapter index may change when an adapter is disabled and then enabled,
    ///or under other circumstances, and should not be considered persistent.
    uint             Index;
    ///Type: <b>UINT</b> The adapter type. Possible values for the adapter type are listed in the <i>Ipifcons.h</i>
    ///header file. The table below lists common values for the adapter type although other values are possible on
    ///Windows Vista and later. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="MIB_IF_TYPE_OTHER"></a><a id="mib_if_type_other"></a><dl> <dt><b>MIB_IF_TYPE_OTHER</b></dt> <dt>1</dt> </dl>
    ///</td> <td width="60%"> Some other type of network interface. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_IF_TYPE_ETHERNET"></a><a id="mib_if_type_ethernet"></a><dl> <dt><b>MIB_IF_TYPE_ETHERNET</b></dt>
    ///<dt>6</dt> </dl> </td> <td width="60%"> An Ethernet network interface. </td> </tr> <tr> <td width="40%"><a
    ///id="IF_TYPE_ISO88025_TOKENRING"></a><a id="if_type_iso88025_tokenring"></a><dl>
    ///<dt><b>IF_TYPE_ISO88025_TOKENRING</b></dt> <dt>9</dt> </dl> </td> <td width="60%"> MIB_IF_TYPE_TOKENRING </td>
    ///</tr> <tr> <td width="40%"><a id="MIB_IF_TYPE_PPP"></a><a id="mib_if_type_ppp"></a><dl>
    ///<dt><b>MIB_IF_TYPE_PPP</b></dt> <dt>23</dt> </dl> </td> <td width="60%"> A PPP network interface. </td> </tr>
    ///<tr> <td width="40%"><a id="MIB_IF_TYPE_LOOPBACK"></a><a id="mib_if_type_loopback"></a><dl>
    ///<dt><b>MIB_IF_TYPE_LOOPBACK</b></dt> <dt>24</dt> </dl> </td> <td width="60%"> A software loopback network
    ///interface. </td> </tr> <tr> <td width="40%"><a id="MIB_IF_TYPE_SLIP"></a><a id="mib_if_type_slip"></a><dl>
    ///<dt><b>MIB_IF_TYPE_SLIP</b></dt> <dt>28</dt> </dl> </td> <td width="60%"> An ATM network interface. </td> </tr>
    ///<tr> <td width="40%"><a id="IF_TYPE_IEEE80211"></a><a id="if_type_ieee80211"></a><dl>
    ///<dt><b>IF_TYPE_IEEE80211</b></dt> <dt>71</dt> </dl> </td> <td width="60%"> An IEEE 802.11 wireless network
    ///interface. <div class="alert"><b>Note</b> This adapter type is returned on Windows Vista and later. On Windows
    ///Server 2003 and Windows XP , an IEEE 802.11 wireless network interface returns an adapter type of
    ///<b>MIB_IF_TYPE_ETHERNET</b>.</div> <div> </div> </td> </tr> </table>
    uint             Type;
    ///Type: <b>UINT</b> An option value that specifies whether the dynamic host configuration protocol (DHCP) is
    ///enabled for this adapter.
    uint             DhcpEnabled;
    ///Type: <b>PIP_ADDR_STRING</b> Reserved.
    IP_ADDR_STRING*  CurrentIpAddress;
    ///Type: <b>IP_ADDR_STRING</b> The list of IPv4 addresses associated with this adapter represented as a linked list
    ///of <b>IP_ADDR_STRING</b> structures. An adapter can have multiple IPv4 addresses assigned to it.
    IP_ADDR_STRING   IpAddressList;
    ///Type: <b>IP_ADDR_STRING</b> The IPv4 address of the gateway for this adapter represented as a linked list of
    ///<b>IP_ADDR_STRING</b> structures. An adapter can have multiple IPv4 gateway addresses assigned to it. This list
    ///usually contains a single entry for IPv4 address of the default gateway for this adapter.
    IP_ADDR_STRING   GatewayList;
    ///Type: <b>IP_ADDR_STRING</b> The IPv4 address of the DHCP server for this adapter represented as a linked list of
    ///<b>IP_ADDR_STRING</b> structures. This list contains a single entry for the IPv4 address of the DHCP server for
    ///this adapter. A value of 255.255.255.255 indicates the DHCP server could not be reached, or is in the process of
    ///being reached. This member is only valid when the <b>DhcpEnabled</b> member is nonzero.
    IP_ADDR_STRING   DhcpServer;
    ///Type: <b>BOOL</b> An option value that specifies whether this adapter uses the Windows Internet Name Service
    ///(WINS).
    BOOL             HaveWins;
    ///Type: <b>IP_ADDR_STRING</b> The IPv4 address of the primary WINS server represented as a linked list of
    ///<b>IP_ADDR_STRING</b> structures. This list contains a single entry for the IPv4 address of the primary WINS
    ///server for this adapter. This member is only valid when the <b>HaveWins</b> member is <b>TRUE</b>.
    IP_ADDR_STRING   PrimaryWinsServer;
    ///Type: <b>IP_ADDR_STRING</b> The IPv4 address of the secondary WINS server represented as a linked list of
    ///<b>IP_ADDR_STRING</b> structures. An adapter can have multiple secondary WINS server addresses assigned to it.
    ///This member is only valid when the <b>HaveWins</b> member is <b>TRUE</b>.
    IP_ADDR_STRING   SecondaryWinsServer;
    ///Type: <b>time_t</b> The time when the current DHCP lease was obtained. This member is only valid when the
    ///<b>DhcpEnabled</b> member is nonzero.
    long             LeaseObtained;
    ///Type: <b>time_t</b> The time when the current DHCP lease expires. This member is only valid when the
    ///<b>DhcpEnabled</b> member is nonzero.
    long             LeaseExpires;
}

///The <b>IP_ADAPTER_UNICAST_ADDRESS</b> structure stores a single unicast IP address in a linked list of IP addresses
///for a particular adapter.
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
    ///Type: <b>struct _IP_ADAPTER_UNICAST_ADDRESS*</b> A pointer to the next IP adapter address structure in the list.
    IP_ADAPTER_UNICAST_ADDRESS_LH* Next;
    ///Type: <b>SOCKET_ADDRESS</b> The IP address for this unicast IP address entry. This member can be an IPv6 address
    ///or an IPv4 address.
    SOCKET_ADDRESS   Address;
    ///Type: <b>IP_PREFIX_ORIGIN</b> The prefix or network part of IP the address. This member can be one of the values
    ///from the IP_PREFIX_ORIGIN enumeration type defined in the <i>Iptypes.h</i> header file.
    NL_PREFIX_ORIGIN PrefixOrigin;
    ///Type: <b>IP_SUFFIX_ORIGIN</b> The suffix or host part of the IP address. This member can be one of the values
    ///from the IP_SUFFIX_ORIGIN enumeration type defined in the <i>Iptypes.h</i> header file.
    NL_SUFFIX_ORIGIN SuffixOrigin;
    ///Type: <b>IP_DAD_STATE</b> The duplicate address detection (DAD) state. This member can be one of the values from
    ///the IP_DAD_STATE enumeration type defined in the <i>Iptypes.h</i> header file. Duplicate address detection is
    ///available for both IPv4 and IPv6 addresses.
    NL_DAD_STATE     DadState;
    ///Type: <b>ULONG</b> The maximum lifetime, in seconds, that the IP address is valid. A value of 0xffffffff is
    ///considered to be infinite.
    uint             ValidLifetime;
    ///Type: <b>ULONG</b> The preferred lifetime, in seconds, that the IP address is valid. A value of 0xffffffff is
    ///considered to be infinite.
    uint             PreferredLifetime;
    ///Type: <b>ULONG</b> The lease lifetime, in seconds, that the IP address is valid.
    uint             LeaseLifetime;
    ///Type: <b>UINT8</b> The length, in bits, of the prefix or network part of the IP address. For a unicast IPv4
    ///address, any value greater than 32 is an illegal value. For a unicast IPv6 address, any value greater than 128 is
    ///an illegal value. A value of 255 is commonly used to represent an illegal value. <div class="alert"><b>Note</b>
    ///This structure member is only available on Windows Vista and later.</div> <div> </div>
    ubyte            OnLinkPrefixLength;
}

///The <b>IP_ADAPTER_UNICAST_ADDRESS</b> structure stores a single unicast IP address in a linked list of IP addresses
///for a particular adapter.
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
    ///Type: <b>struct _IP_ADAPTER_UNICAST_ADDRESS*</b> A pointer to the next IP adapter address structure in the list.
    IP_ADAPTER_UNICAST_ADDRESS_XP* Next;
    ///Type: <b>SOCKET_ADDRESS</b> The IP address for this unicast IP address entry. This member can be an IPv6 address
    ///or an IPv4 address.
    SOCKET_ADDRESS   Address;
    ///Type: <b>IP_PREFIX_ORIGIN</b> The prefix or network part of IP the address. This member can be one of the values
    ///from the IP_PREFIX_ORIGIN enumeration type defined in the <i>Iptypes.h</i> header file.
    NL_PREFIX_ORIGIN PrefixOrigin;
    ///Type: <b>IP_SUFFIX_ORIGIN</b> The suffix or host part of the IP address. This member can be one of the values
    ///from the IP_SUFFIX_ORIGIN enumeration type defined in the <i>Iptypes.h</i> header file.
    NL_SUFFIX_ORIGIN SuffixOrigin;
    ///Type: <b>IP_DAD_STATE</b> The duplicate address detection (DAD) state. This member can be one of the values from
    ///the IP_DAD_STATE enumeration type defined in the <i>Iptypes.h</i> header file. Duplicate address detection is
    ///available for both IPv4 and IPv6 addresses.
    NL_DAD_STATE     DadState;
    ///Type: <b>ULONG</b> The maximum lifetime, in seconds, that the IP address is valid. A value of 0xffffffff is
    ///considered to be infinite.
    uint             ValidLifetime;
    ///Type: <b>ULONG</b> The preferred lifetime, in seconds, that the IP address is valid. A value of 0xffffffff is
    ///considered to be infinite.
    uint             PreferredLifetime;
    ///Type: <b>ULONG</b> The lease lifetime, in seconds, that the IP address is valid.
    uint             LeaseLifetime;
}

///The <b>IP_ADAPTER_ANYCAST_ADDRESS</b> structure stores a single anycast IP address in a linked list of addresses for
///a particular adapter.
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
    ///Type: <b>struct _IP_ADAPTER_ANYCAST_ADDRESS*</b> A pointer to the next anycast IP address structure in the list.
    IP_ADAPTER_ANYCAST_ADDRESS_XP* Next;
    ///Type: <b>SOCKET_ADDRESS</b> The IP address for this anycast IP address entry. This member can be an IPv6 address
    ///or an IPv4 address.
    SOCKET_ADDRESS Address;
}

///The <b>IP_ADAPTER_MULTICAST_ADDRESS</b> structure stores a single multicast address in a linked-list of addresses for
///a particular adapter.
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
    ///Type: <b>struct _IP_ADAPTER_MULTICAST_ADDRESS*</b> A pointer to the next multicast IP address structure in the
    ///list.
    IP_ADAPTER_MULTICAST_ADDRESS_XP* Next;
    ///Type: <b>SOCKET_ADDRESS</b> The IP address for this multicast IP address entry. This member can be an IPv6
    ///address or an IPv4 address.
    SOCKET_ADDRESS Address;
}

///The <b>IP_ADAPTER_DNS_SERVER_ADDRESS</b> structure stores a single DNS server address in a linked list of DNS server
///addresses for a particular adapter.
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
    ///A pointer to the next DNS server address structure in the list.
    IP_ADAPTER_DNS_SERVER_ADDRESS_XP* Next;
    ///The IP address for this DNS server entry. This member can be an IPv6 address or an IPv4 address.
    SOCKET_ADDRESS Address;
}

///The <b>IP_ADAPTER_WINS_SERVER_ADDRESS</b> structure stores a single Windows Internet Name Service (WINS) server
///address in a linked list of WINS server addresses for a particular adapter.
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
    ///A pointer to the next WINS server address structure in the list.
    IP_ADAPTER_WINS_SERVER_ADDRESS_LH* Next;
    ///The IP address for this WINS server entry. This member can be an IPv6 address or an IPv4 address.
    SOCKET_ADDRESS Address;
}

///The <b>IP_ADAPTER_GATEWAY_ADDRESS</b> structure stores a single gateway address in a linked list of gateway addresses
///for a particular adapter.
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
    ///A pointer to the next gateway address structure in the list.
    IP_ADAPTER_GATEWAY_ADDRESS_LH* Next;
    ///The IP address for this gateway entry. This member can be an IPv6 address or an IPv4 address.
    SOCKET_ADDRESS Address;
}

///The <b>IP_ADAPTER_PREFIX</b> structure stores an IP address prefix.
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
    ///A pointer to the next adapter prefix structure in the list.
    IP_ADAPTER_PREFIX_XP* Next;
    ///The address prefix, in the form of a SOCKET_ADDRESS structure.
    SOCKET_ADDRESS Address;
    ///The length of the prefix, in bits.
    uint           PrefixLength;
}

///The <b>IP_ADAPTER_DNS_SUFFIX</b> structure stores a DNS suffix in a linked list of DNS suffixes for a particular
///adapter.
struct IP_ADAPTER_DNS_SUFFIX
{
    ///A pointer to the next DNS suffix in the linked list.
    IP_ADAPTER_DNS_SUFFIX* Next;
    ///The DNS suffix for this DNS suffix entry.
    ushort[256] String;
}

///The <b>IP_ADAPTER_ADDRESSES</b> structure is the <i>header node</i> for a linked list of addresses for a particular
///adapter. This structure can simultaneously be used as part of a linked list of <b>IP_ADAPTER_ADDRESSES</b>
///structures.
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
    ///Type: <b>struct _IP_ADAPTER_ADDRESSES*</b> A pointer to the next adapter addresses structure in the list.
    IP_ADAPTER_ADDRESSES_LH* Next;
    ///Type: <b>PCHAR</b> An array of characters that contains the name of the adapter with which these addresses are
    ///associated. Unlike an adapter's friendly name, the adapter name specified in <b>AdapterName</b> is permanent and
    ///cannot be modified by the user.
    PSTR           AdapterName;
    ///Type: <b>PIP_ADAPTER_UNICAST_ADDRESS</b> A pointer to the first IP_ADAPTER_UNICAST_ADDRESS structure in a linked
    ///list of IP unicast addresses for the adapter.
    IP_ADAPTER_UNICAST_ADDRESS_LH* FirstUnicastAddress;
    ///Type: <b>PIP_ADAPTER_ANYCAST_ADDRESS</b> A pointer to the first IP_ADAPTER_ANYCAST_ADDRESS structure in a linked
    ///list of IP anycast addresses for the adapter.
    IP_ADAPTER_ANYCAST_ADDRESS_XP* FirstAnycastAddress;
    ///Type: <b>PIP_ADAPTER_MULTICAST_ADDRESS</b> A pointer to the first IP_ADAPTER_MULTICAST_ADDRESS structure in a
    ///list of IP multicast addresses for the adapter.
    IP_ADAPTER_MULTICAST_ADDRESS_XP* FirstMulticastAddress;
    ///Type: <b>PIP_ADAPTER_DNS_SERVER_ADDRESS</b> A pointer to the first IP_ADAPTER_DNS_SERVER_ADDRESS structure in a
    ///linked list of DNS server addresses for the adapter.
    IP_ADAPTER_DNS_SERVER_ADDRESS_XP* FirstDnsServerAddress;
    ///Type: <b>PWCHAR</b> The Domain Name System (DNS) suffix associated with this adapter.
    PWSTR          DnsSuffix;
    ///Type: <b>PWCHAR</b> A description for the adapter. This member is read-only.
    PWSTR          Description;
    ///Type: <b>PWCHAR</b> A user-friendly name for the adapter. For example: "Local Area Connection 1." This name
    ///appears in contexts such as the <b>ipconfig</b> command line program and the Connection folder. This member is
    ///read only and can't be modified using any IP Helper functions. This member is the ifAlias field used by NDIS as
    ///described in RFC 2863. The ifAlias field can be set by an NDIS interface provider when the NDIS driver is
    ///installed. For NDIS miniport drivers, this field is set by NDIS.
    PWSTR          FriendlyName;
    ///Type: <b>BYTE[MAX_ADAPTER_ADDRESS_LENGTH]</b> The Media Access Control (MAC) address for the adapter. For
    ///example, on an Ethernet network this member would specify the Ethernet hardware address.
    ubyte[8]       PhysicalAddress;
    ///Type: <b>DWORD</b> The length, in bytes, of the address specified in the <b>PhysicalAddress</b> member. For
    ///interfaces that do not have a data-link layer, this value is zero.
    uint           PhysicalAddressLength;
union
    {
        uint Flags;
struct
        {
            uint _bitfield62;
        }
    }
    ///Type: <b>DWORD</b> The maximum transmission unit (MTU) size, in bytes.
    uint           Mtu;
    ///Type: <b>DWORD</b> The interface type as defined by the Internet Assigned Names Authority (IANA). Possible values
    ///for the interface type are listed in the <i>Ipifcons.h</i> header file. The table below lists common values for
    ///the interface type although many other values are possible. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="IF_TYPE_OTHER"></a><a id="if_type_other"></a><dl> <dt><b>IF_TYPE_OTHER</b></dt>
    ///<dt>1</dt> </dl> </td> <td width="60%"> Some other type of network interface. </td> </tr> <tr> <td width="40%"><a
    ///id="IF_TYPE_ETHERNET_CSMACD"></a><a id="if_type_ethernet_csmacd"></a><dl> <dt><b>IF_TYPE_ETHERNET_CSMACD</b></dt>
    ///<dt>6</dt> </dl> </td> <td width="60%"> An Ethernet network interface. </td> </tr> <tr> <td width="40%"><a
    ///id="IF_TYPE_ISO88025_TOKENRING"></a><a id="if_type_iso88025_tokenring"></a><dl>
    ///<dt><b>IF_TYPE_ISO88025_TOKENRING</b></dt> <dt>9</dt> </dl> </td> <td width="60%"> A token ring network
    ///interface. </td> </tr> <tr> <td width="40%"><a id="IF_TYPE_PPP"></a><a id="if_type_ppp"></a><dl>
    ///<dt><b>IF_TYPE_PPP</b></dt> <dt>23</dt> </dl> </td> <td width="60%"> A PPP network interface. </td> </tr> <tr>
    ///<td width="40%"><a id="IF_TYPE_SOFTWARE_LOOPBACK"></a><a id="if_type_software_loopback"></a><dl>
    ///<dt><b>IF_TYPE_SOFTWARE_LOOPBACK</b></dt> <dt>24</dt> </dl> </td> <td width="60%"> A software loopback network
    ///interface. </td> </tr> <tr> <td width="40%"><a id="IF_TYPE_ATM"></a><a id="if_type_atm"></a><dl>
    ///<dt><b>IF_TYPE_ATM</b></dt> <dt>37</dt> </dl> </td> <td width="60%"> An ATM network interface. </td> </tr> <tr>
    ///<td width="40%"><a id="IF_TYPE_IEEE80211"></a><a id="if_type_ieee80211"></a><dl>
    ///<dt><b>IF_TYPE_IEEE80211</b></dt> <dt>71</dt> </dl> </td> <td width="60%"> An IEEE 802.11 wireless network
    ///interface. On Windows Vista and later, wireless network cards are reported as <b>IF_TYPE_IEEE80211</b>. On
    ///earlier versions of Windows, wireless network cards are reported as <b>IF_TYPE_ETHERNET_CSMACD</b>. On Windows XP
    ///with SP3 and on Windows XP with SP2 x86 with the Wireless LAN API for Windows XP with SP2 installed, the
    ///WlanEnumInterfaces function can be used to enumerate wireless interfaces on the local computer. </td> </tr> <tr>
    ///<td width="40%"><a id="IF_TYPE_TUNNEL"></a><a id="if_type_tunnel"></a><dl> <dt><b>IF_TYPE_TUNNEL</b></dt>
    ///<dt>131</dt> </dl> </td> <td width="60%"> A tunnel type encapsulation network interface. </td> </tr> <tr> <td
    ///width="40%"><a id="IF_TYPE_IEEE1394"></a><a id="if_type_ieee1394"></a><dl> <dt><b>IF_TYPE_IEEE1394</b></dt>
    ///<dt>144</dt> </dl> </td> <td width="60%"> An IEEE 1394 (Firewire) high performance serial bus network interface.
    ///</td> </tr> </table>
    uint           IfType;
    ///Type: <b>IF_OPER_STATUS</b> The operational status for the interface as defined in RFC 2863. For more
    ///information, see http://www.ietf.org/rfc/rfc2863.txt. This member can be one of the values from the
    ///<b>IF_OPER_STATUS</b> enumeration type defined in the <i>Iftypes.h</i> header file. On Windows Vista and later,
    ///the header files were reorganized and this enumeration is defined in the <i>Ifdef.h</i> header file. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IfOperStatusUp"></a><a
    ///id="ifoperstatusup"></a><a id="IFOPERSTATUSUP"></a><dl> <dt><b>IfOperStatusUp</b></dt> <dt>1</dt> </dl> </td> <td
    ///width="60%"> The interface is up and able to pass packets. </td> </tr> <tr> <td width="40%"><a
    ///id="IfOperStatusDown"></a><a id="ifoperstatusdown"></a><a id="IFOPERSTATUSDOWN"></a><dl>
    ///<dt><b>IfOperStatusDown</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The interface is down and not in a
    ///condition to pass packets. The <b>IfOperStatusDown</b> state has two meanings, depending on the value of
    ///<b>AdminStatus</b> member. If <b>AdminStatus</b> is not set to <b>NET_IF_ADMIN_STATUS_DOWN</b> and
    ///<b>ifOperStatus</b> is set to <b>IfOperStatusDown</b> then a fault condition is presumed to exist on the
    ///interface. If <b>AdminStatus</b> is set to <b>IfOperStatusDown</b>, then <b>ifOperStatus</b> will normally also
    ///be set to <b>IfOperStatusDown</b> or <b>IfOperStatusNotPresent</b> and there is not necessarily a fault condition
    ///on the interface. </td> </tr> <tr> <td width="40%"><a id="IfOperStatusTesting"></a><a
    ///id="ifoperstatustesting"></a><a id="IFOPERSTATUSTESTING"></a><dl> <dt><b>IfOperStatusTesting</b></dt> <dt>3</dt>
    ///</dl> </td> <td width="60%"> The interface is in testing mode. </td> </tr> <tr> <td width="40%"><a
    ///id="IfOperStatusUnknown"></a><a id="ifoperstatusunknown"></a><a id="IFOPERSTATUSUNKNOWN"></a><dl>
    ///<dt><b>IfOperStatusUnknown</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> The operational status of the
    ///interface is unknown. </td> </tr> <tr> <td width="40%"><a id="IfOperStatusDormant"></a><a
    ///id="ifoperstatusdormant"></a><a id="IFOPERSTATUSDORMANT"></a><dl> <dt><b>IfOperStatusDormant</b></dt> <dt>5</dt>
    ///</dl> </td> <td width="60%"> The interface is not actually in a condition to pass packets (it is not up), but is
    ///in a pending state, waiting for some external event. For on-demand interfaces, this new state identifies the
    ///situation where the interface is waiting for events to place it in the <b>IfOperStatusUp</b> state. </td> </tr>
    ///<tr> <td width="40%"><a id="IfOperStatusNotPresent"></a><a id="ifoperstatusnotpresent"></a><a
    ///id="IFOPERSTATUSNOTPRESENT"></a><dl> <dt><b>IfOperStatusNotPresent</b></dt> <dt>6</dt> </dl> </td> <td
    ///width="60%"> A refinement on the <b>IfOperStatusDown</b> state which indicates that the relevant interface is
    ///down specifically because some component (typically, a hardware component) is not present in the managed system.
    ///</td> </tr> <tr> <td width="40%"><a id="IfOperStatusLowerLayerDown"></a><a id="ifoperstatuslowerlayerdown"></a><a
    ///id="IFOPERSTATUSLOWERLAYERDOWN"></a><dl> <dt><b>IfOperStatusLowerLayerDown</b></dt> <dt>7</dt> </dl> </td> <td
    ///width="60%"> A refinement on the <b>IfOperStatusDown</b> state. This new state indicates that this interface runs
    ///on top of one or more other interfaces and that this interface is down specifically because one or more of these
    ///lower-layer interfaces are down. </td> </tr> </table>
    IF_OPER_STATUS OperStatus;
    ///Type: <b>DWORD</b> The interface index for the IPv6 IP address. This member is zero if IPv6 is not available on
    ///the interface. <div class="alert"><b>Note</b> This structure member is only available on Windows XP with SP1 and
    ///later.</div> <div> </div>
    uint           Ipv6IfIndex;
    ///Type: <b>DWORD[16]</b> An array of scope IDs for each scope level used for composing sockaddr structures. The
    ///SCOPE_LEVEL enumeration is used to index the array. On IPv6, a single interface may be assigned multiple IPv6
    ///multicast addresses based on a scope ID. <div class="alert"><b>Note</b> This structure member is only available
    ///on Windows XP with SP1 and later.</div> <div> </div>
    uint[16]       ZoneIndices;
    ///Type: <b>PIP_ADAPTER_PREFIX</b> A pointer to the first IP_ADAPTER_PREFIX structure in a linked list of IP adapter
    ///prefixes for the adapter. <div class="alert"><b>Note</b> This structure member is only available on Windows XP
    ///with SP1 and later.</div> <div> </div>
    IP_ADAPTER_PREFIX_XP* FirstPrefix;
    ///Type: <b>ULONG64</b> The current speed in bits per second of the transmit link for the adapter. <div
    ///class="alert"><b>Note</b> This structure member is only available on Windows Vista and later.</div> <div> </div>
    ulong          TransmitLinkSpeed;
    ///Type: <b>ULONG64</b> The current speed in bits per second of the receive link for the adapter. <div
    ///class="alert"><b>Note</b> This structure member is only available on Windows Vista and later.</div> <div> </div>
    ulong          ReceiveLinkSpeed;
    ///Type: <b>PIP_ADAPTER_WINS_SERVER_ADDRESS_LH</b> A pointer to the first IP_ADAPTER_WINS_SERVER_ADDRESS structure
    ///in a linked list of Windows Internet Name Service (WINS) server addresses for the adapter. <div
    ///class="alert"><b>Note</b> This structure member is only available on Windows Vista and later.</div> <div> </div>
    IP_ADAPTER_WINS_SERVER_ADDRESS_LH* FirstWinsServerAddress;
    ///Type: <b>PIP_ADAPTER_GATEWAY_ADDRESS_LH</b> A pointer to the first IP_ADAPTER_GATEWAY_ADDRESS structure in a
    ///linked list of gateways for the adapter. <div class="alert"><b>Note</b> This structure member is only available
    ///on Windows Vista and later.</div> <div> </div>
    IP_ADAPTER_GATEWAY_ADDRESS_LH* FirstGatewayAddress;
    ///Type: <b>ULONG</b> The IPv4 interface metric for the adapter address. This member is only applicable to an IPv4
    ///adapter address. The actual route metric used to compute the route preferences for IPv4 is the summation of the
    ///route metric offset specified in the <b>Metric</b> member of the MIB_IPFORWARD_ROW2 structure and the interface
    ///metric specified in this member for IPv4. <div class="alert"><b>Note</b> This structure member is only available
    ///on Windows Vista and later.</div> <div> </div>
    uint           Ipv4Metric;
    ///Type: <b>ULONG</b> The IPv6 interface metric for the adapter address. This member is only applicable to an IPv6
    ///adapter address. The actual route metric used to compute the route preferences for IPv6 is the summation of the
    ///route metric offset specified in the <b>Metric</b> member of the MIB_IPFORWARD_ROW2 structure and the interface
    ///metric specified in this member for IPv4. <div class="alert"><b>Note</b> This structure member is only available
    ///on Windows Vista and later.</div> <div> </div>
    uint           Ipv6Metric;
    ///Type: <b>IF_LUID</b> The interface LUID for the adapter address. <div class="alert"><b>Note</b> This structure
    ///member is only available on Windows Vista and later.</div> <div> </div>
    NET_LUID_LH    Luid;
    ///Type: <b>SOCKET_ADDRESS</b> The IPv4 address of the DHCP server for the adapter address. This member is only
    ///applicable to an IPv4 adapter address configured using DHCP. <div class="alert"><b>Note</b> This structure member
    ///is only available on Windows Vista and later.</div> <div> </div>
    SOCKET_ADDRESS Dhcpv4Server;
    ///Type: <b>NET_IF_COMPARTMENT_ID</b> The routing compartment ID for the adapter address. <div
    ///class="alert"><b>Note</b> This structure member is only available on Windows Vista and later. This member is not
    ///currently supported and is reserved for future use.</div> <div> </div>
    uint           CompartmentId;
    ///Type: <b>NET_IF_NETWORK_GUID</b> The <b>GUID</b> that is associated with the network that the interface belongs
    ///to. If the interface provider cannot provide the network GUID, this member can be a zero <b>GUID</b>. In this
    ///case, the interface was registered by NDIS in the default network. <div class="alert"><b>Note</b> This structure
    ///member is only available on Windows Vista and later.</div> <div> </div>
    GUID           NetworkGuid;
    ///Type: <b>NET_IF_CONNECTION_TYPE</b> The interface connection type for the adapter address. This member can be one
    ///of the values from the <b>NET_IF_CONNECTION_TYPE</b> enumeration type defined in the <i>Ifdef.h</i> header file.
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="NET_IF_CONNECTION_DEDICATED"></a><a id="net_if_connection_dedicated"></a><dl>
    ///<dt><b>NET_IF_CONNECTION_DEDICATED</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The connection type is
    ///dedicated. The connection comes up automatically when media sense is <b>TRUE</b>. For example, an Ethernet
    ///connection is dedicated. </td> </tr> <tr> <td width="40%"><a id="NET_IF_CONNECTION_PASSIVE"></a><a
    ///id="net_if_connection_passive"></a><dl> <dt><b>NET_IF_CONNECTION_PASSIVE</b></dt> <dt>2</dt> </dl> </td> <td
    ///width="60%"> The connection type is passive. The remote end must bring up the connection to the local station.
    ///For example, a RAS interface is passive. </td> </tr> <tr> <td width="40%"><a id="NET_IF_CONNECTION_DEMAND"></a><a
    ///id="net_if_connection_demand"></a><dl> <dt><b>NET_IF_CONNECTION_DEMAND</b></dt> <dt>3</dt> </dl> </td> <td
    ///width="60%"> The connection type is demand-dial. A connection of this type comes up in response to a local action
    ///(sending a packet, for example). </td> </tr> <tr> <td width="40%"><a id="NET_IF_CONNECTION_MAXIMUM"></a><a
    ///id="net_if_connection_maximum"></a><dl> <dt><b>NET_IF_CONNECTION_MAXIMUM</b></dt> <dt>4</dt> </dl> </td> <td
    ///width="60%"> The maximum possible value for the <b>NET_IF_CONNECTION_TYPE</b> enumeration type. This is not a
    ///legal value for <b>ConnectionType</b> member. </td> </tr> </table> <div class="alert"><b>Note</b> This structure
    ///member is only available on Windows Vista and later.</div> <div> </div>
    NET_IF_CONNECTION_TYPE ConnectionType;
    ///Type: <b>TUNNEL_TYPE</b> The encapsulation method used by a tunnel if the adapter address is a tunnel. <div
    ///class="alert"><b>Note</b> This structure member is only available on Windows Vista and later.</div> <div> </div>
    ///The tunnel type is defined by the Internet Assigned Names Authority (IANA). For more information, see
    ///http://www.iana.org/assignments/ianaiftype-mib. This member can be one of the values from the <b>TUNNEL_TYPE</b>
    ///enumeration type defined in the <i>Ifdef.h</i> header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="TUNNEL_TYPE_NONE"></a><a id="tunnel_type_none"></a><dl>
    ///<dt><b>TUNNEL_TYPE_NONE</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> Not a tunnel. </td> </tr> <tr> <td
    ///width="40%"><a id="TUNNEL_TYPE_OTHER"></a><a id="tunnel_type_other"></a><dl> <dt><b>TUNNEL_TYPE_OTHER</b></dt>
    ///<dt>1</dt> </dl> </td> <td width="60%"> None of the following tunnel types. </td> </tr> <tr> <td width="40%"><a
    ///id="TUNNEL_TYPE_DIRECT"></a><a id="tunnel_type_direct"></a><dl> <dt><b>TUNNEL_TYPE_DIRECT</b></dt> <dt>2</dt>
    ///</dl> </td> <td width="60%"> A packet is encapsulated directly within a normal IP header, with no intermediate
    ///header, and unicast to the remote tunnel endpoint. </td> </tr> <tr> <td width="40%"><a
    ///id="TUNNEL_TYPE_6TO4"></a><a id="tunnel_type_6to4"></a><dl> <dt><b>TUNNEL_TYPE_6TO4</b></dt> <dt>11</dt> </dl>
    ///</td> <td width="60%"> An IPv6 packet is encapsulated directly within an IPv4 header, with no intermediate
    ///header, and unicast to the destination determined by the 6to4 protocol. </td> </tr> <tr> <td width="40%"><a
    ///id="TUNNEL_TYPE_ISATAP"></a><a id="tunnel_type_isatap"></a><dl> <dt><b>TUNNEL_TYPE_ISATAP</b></dt> <dt>13</dt>
    ///</dl> </td> <td width="60%"> An IPv6 packet is encapsulated directly within an IPv4 header, with no intermediate
    ///header, and unicast to the destination determined by the ISATAP protocol. </td> </tr> <tr> <td width="40%"><a
    ///id="TUNNEL_TYPE_TEREDO"></a><a id="tunnel_type_teredo"></a><dl> <dt><b>TUNNEL_TYPE_TEREDO</b></dt> <dt>14</dt>
    ///</dl> </td> <td width="60%"> Teredo encapsulation for IPv6 packets. </td> </tr> <tr> <td width="40%"><a
    ///id="TUNNEL_TYPE_IPHTTPS"></a><a id="tunnel_type_iphttps"></a><dl> <dt><b>TUNNEL_TYPE_IPHTTPS</b></dt> <dt>15</dt>
    ///</dl> </td> <td width="60%"> IP over HTTPS encapsulation for IPv6 packets. <div class="alert"><b>Note</b> This
    ///enumeration value is only available on Windows 7, Windows Server 2008 R2, and later.</div> <div> </div> </td>
    ///</tr> </table>
    TUNNEL_TYPE    TunnelType;
    ///Type: <b>SOCKET_ADDRESS</b> The IPv6 address of the DHCPv6 server for the adapter address. This member is only
    ///applicable to an IPv6 adapter address configured using DHCPv6. This structure member is not currently supported
    ///and is reserved for future use. <div class="alert"><b>Note</b> This structure member is only available on Windows
    ///Vista and later.</div> <div> </div>
    SOCKET_ADDRESS Dhcpv6Server;
    ///Type: <b>BYTE[MAX_DHCPV6_DUID_LENGTH]</b> The DHCP unique identifier (DUID) for the DHCPv6 client. This member is
    ///only applicable to an IPv6 adapter address configured using DHCPv6. <div class="alert"><b>Note</b> This structure
    ///member is only available on Windows Vista and later.</div> <div> </div>
    ubyte[130]     Dhcpv6ClientDuid;
    ///Type: <b>ULONG</b> The length, in bytes, of the DHCP unique identifier (DUID) for the DHCPv6 client. This member
    ///is only applicable to an IPv6 adapter address configured using DHCPv6. <div class="alert"><b>Note</b> This
    ///structure member is only available on Windows Vista and later.</div> <div> </div>
    uint           Dhcpv6ClientDuidLength;
    ///Type: <b>ULONG</b> The identifier for an identity association chosen by the DHCPv6 client. This member is only
    ///applicable to an IPv6 adapter address configured using DHCPv6. <div class="alert"><b>Note</b> This structure
    ///member is only available on Windows Vista and later.</div> <div> </div>
    uint           Dhcpv6Iaid;
    ///Type: <b>PIP_ADAPTER_DNS_SUFFIX</b> A pointer to the first IP_ADAPTER_DNS_SUFFIX structure in a linked list of
    ///DNS suffixes for the adapter. <div class="alert"><b>Note</b> This structure member is only available on Windows
    ///Vista with SP1and later and on Windows Server 2008 and later.</div> <div> </div>
    IP_ADAPTER_DNS_SUFFIX* FirstDnsSuffix;
}

///The <b>IP_ADAPTER_ADDRESSES</b> structure is the <i>header node</i> for a linked list of addresses for a particular
///adapter. This structure can simultaneously be used as part of a linked list of <b>IP_ADAPTER_ADDRESSES</b>
///structures.
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
    ///Type: <b>struct _IP_ADAPTER_ADDRESSES*</b> A pointer to the next adapter addresses structure in the list.
    IP_ADAPTER_ADDRESSES_XP* Next;
    ///Type: <b>PCHAR</b> An array of characters that contains the name of the adapter with which these addresses are
    ///associated. Unlike an adapter's friendly name, the adapter name specified in <b>AdapterName</b> is permanent and
    ///cannot be modified by the user.
    PSTR           AdapterName;
    ///Type: <b>PIP_ADAPTER_UNICAST_ADDRESS</b> A pointer to the first IP_ADAPTER_UNICAST_ADDRESS structure in a linked
    ///list of IP unicast addresses for the adapter.
    IP_ADAPTER_UNICAST_ADDRESS_XP* FirstUnicastAddress;
    ///Type: <b>PIP_ADAPTER_ANYCAST_ADDRESS</b> A pointer to the first IP_ADAPTER_ANYCAST_ADDRESS structure in a linked
    ///list of IP anycast addresses for the adapter.
    IP_ADAPTER_ANYCAST_ADDRESS_XP* FirstAnycastAddress;
    ///Type: <b>PIP_ADAPTER_MULTICAST_ADDRESS</b> A pointer to the first IP_ADAPTER_MULTICAST_ADDRESS structure in a
    ///list of IP multicast addresses for the adapter.
    IP_ADAPTER_MULTICAST_ADDRESS_XP* FirstMulticastAddress;
    ///Type: <b>PIP_ADAPTER_DNS_SERVER_ADDRESS</b> A pointer to the first IP_ADAPTER_DNS_SERVER_ADDRESS structure in a
    ///linked list of DNS server addresses for the adapter.
    IP_ADAPTER_DNS_SERVER_ADDRESS_XP* FirstDnsServerAddress;
    ///Type: <b>PWCHAR</b> The Domain Name System (DNS) suffix associated with this adapter.
    PWSTR          DnsSuffix;
    ///Type: <b>PWCHAR</b> A description for the adapter. This member is read-only.
    PWSTR          Description;
    ///Type: <b>PWCHAR</b> A user-friendly name for the adapter. For example: "Local Area Connection 1." This name
    ///appears in contexts such as the <b>ipconfig</b> command line program and the Connection folder. This member is
    ///read only and can't be modified using any IP Helper functions. This member is the ifAlias field used by NDIS as
    ///described in RFC 2863. The ifAlias field can be set by an NDIS interface provider when the NDIS driver is
    ///installed. For NDIS miniport drivers, this field is set by NDIS.
    PWSTR          FriendlyName;
    ///Type: <b>BYTE[MAX_ADAPTER_ADDRESS_LENGTH]</b> The Media Access Control (MAC) address for the adapter. For
    ///example, on an Ethernet network this member would specify the Ethernet hardware address.
    ubyte[8]       PhysicalAddress;
    ///Type: <b>DWORD</b> The length, in bytes, of the address specified in the <b>PhysicalAddress</b> member. For
    ///interfaces that do not have a data-link layer, this value is zero.
    uint           PhysicalAddressLength;
    ///Type: <b>DWORD</b> A set of flags specifying various settings for the adapter. These values are defined in the
    ///<i>Iptypes.h</i> header file. Combinations of these flag bits are possible. <table> <tr> <th>Flag</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="IP_ADAPTER_DDNS_ENABLED"></a><a
    ///id="ip_adapter_ddns_enabled"></a><dl> <dt><b>IP_ADAPTER_DDNS_ENABLED</b></dt> <dt>0x0001</dt> </dl> </td> <td
    ///width="60%"> Dynamic DNS is enabled on this adapter. </td> </tr> <tr> <td width="40%"><a
    ///id="IP_ADAPTER_REGISTER_ADAPTER_SUFFIX"></a><a id="ip_adapter_register_adapter_suffix"></a><dl>
    ///<dt><b>IP_ADAPTER_REGISTER_ADAPTER_SUFFIX</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%"> Register the DNS
    ///suffix for this adapter. </td> </tr> <tr> <td width="40%"><a id="IP_ADAPTER_DHCP_ENABLED"></a><a
    ///id="ip_adapter_dhcp_enabled"></a><dl> <dt><b>IP_ADAPTER_DHCP_ENABLED</b></dt> <dt>0x0004</dt> </dl> </td> <td
    ///width="60%"> The Dynamic Host Configuration Protocol (DHCP) is enabled on this adapter. </td> </tr> <tr> <td
    ///width="40%"><a id="IP_ADAPTER_RECEIVE_ONLY"></a><a id="ip_adapter_receive_only"></a><dl>
    ///<dt><b>IP_ADAPTER_RECEIVE_ONLY</b></dt> <dt>0x0008</dt> </dl> </td> <td width="60%"> The adapter is a
    ///receive-only adapter. </td> </tr> <tr> <td width="40%"><a id="IP_ADAPTER_NO_MULTICAST"></a><a
    ///id="ip_adapter_no_multicast"></a><dl> <dt><b>IP_ADAPTER_NO_MULTICAST</b></dt> <dt>0x0010</dt> </dl> </td> <td
    ///width="60%"> The adapter is not a multicast recipient. </td> </tr> <tr> <td width="40%"><a
    ///id="IP_ADAPTER_IPV6_OTHER_STATEFUL_CONFIG"></a><a id="ip_adapter_ipv6_other_stateful_config"></a><dl>
    ///<dt><b>IP_ADAPTER_IPV6_OTHER_STATEFUL_CONFIG</b></dt> <dt>0x0020</dt> </dl> </td> <td width="60%"> The adapter
    ///contains other IPv6-specific stateful configuration information. </td> </tr> <tr> <td width="40%"><a
    ///id="IP_ADAPTER_NETBIOS_OVER_TCPIP_ENABLED"></a><a id="ip_adapter_netbios_over_tcpip_enabled"></a><dl>
    ///<dt><b>IP_ADAPTER_NETBIOS_OVER_TCPIP_ENABLED</b></dt> <dt>0x0040</dt> </dl> </td> <td width="60%"> The adapter is
    ///enabled for NetBIOS over TCP/IP. <div class="alert"><b>Note</b> This flag is only supported on Windows Vista and
    ///later when the application has been compiled for a target platform with an NTDDI version equal or greater than
    ///<b>NTDDI_LONGHORN</b>. This flag is defined in the <b>IP_ADAPTER_ADDRESSES_LH</b> structure as the
    ///<b>NetbiosOverTcpipEnabled</b> bitfield.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
    ///id="IP_ADAPTER_IPV4_ENABLED"></a><a id="ip_adapter_ipv4_enabled"></a><dl> <dt><b>IP_ADAPTER_IPV4_ENABLED</b></dt>
    ///<dt>0x0080</dt> </dl> </td> <td width="60%"> The adapter is enabled for IPv4. <div class="alert"><b>Note</b> This
    ///flag is only supported on Windows Vista and later when the application has been compiled for a target platform
    ///with an NTDDI version equal or greater than <b>NTDDI_LONGHORN</b>. This flag is defined in the
    ///<b>IP_ADAPTER_ADDRESSES_LH</b> structure as the <b>Ipv4Enabled</b> bitfield.</div> <div> </div> </td> </tr> <tr>
    ///<td width="40%"><a id="IP_ADAPTER_IPV6_ENABLED"></a><a id="ip_adapter_ipv6_enabled"></a><dl>
    ///<dt><b>IP_ADAPTER_IPV6_ENABLED</b></dt> <dt>0x0100</dt> </dl> </td> <td width="60%"> The adapter is enabled for
    ///IPv6. <div class="alert"><b>Note</b> This flag is only supported on Windows Vista and later when the application
    ///has been compiled for a target platform with an NTDDI version equal or greater than <b>NTDDI_LONGHORN</b>. This
    ///flag is defined in the <b>IP_ADAPTER_ADDRESSES_LH</b> structure as the <b>Ipv6Enabled</b> bitfield.</div> <div>
    ///</div> </td> </tr> <tr> <td width="40%"><a id="IP_ADAPTER_IPV6_MANAGE_ADDRESS_CONFIG"></a><a
    ///id="ip_adapter_ipv6_manage_address_config"></a><dl> <dt><b>IP_ADAPTER_IPV6_MANAGE_ADDRESS_CONFIG</b></dt>
    ///<dt>0x0200</dt> </dl> </td> <td width="60%"> The adapter is enabled for IPv6 managed address configuration. <div
    ///class="alert"><b>Note</b> This flag is only supported on Windows Vista and later when the application has been
    ///compiled for a target platform with an NTDDI version equal or greater than <b>NTDDI_LONGHORN</b>. This flag is
    ///defined in the <b>IP_ADAPTER_ADDRESSES_LH</b> structure as the <b>Ipv6ManagedAddressConfigurationSupported</b>
    ///bitfield.</div> <div> </div> </td> </tr> </table>
    uint           Flags;
    ///Type: <b>DWORD</b> The maximum transmission unit (MTU) size, in bytes.
    uint           Mtu;
    ///Type: <b>DWORD</b> The interface type as defined by the Internet Assigned Names Authority (IANA). Possible values
    ///for the interface type are listed in the <i>Ipifcons.h</i> header file. The table below lists common values for
    ///the interface type although many other values are possible. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///<tr> <td width="40%"><a id="IF_TYPE_OTHER"></a><a id="if_type_other"></a><dl> <dt><b>IF_TYPE_OTHER</b></dt>
    ///<dt>1</dt> </dl> </td> <td width="60%"> Some other type of network interface. </td> </tr> <tr> <td width="40%"><a
    ///id="IF_TYPE_ETHERNET_CSMACD"></a><a id="if_type_ethernet_csmacd"></a><dl> <dt><b>IF_TYPE_ETHERNET_CSMACD</b></dt>
    ///<dt>6</dt> </dl> </td> <td width="60%"> An Ethernet network interface. </td> </tr> <tr> <td width="40%"><a
    ///id="IF_TYPE_ISO88025_TOKENRING"></a><a id="if_type_iso88025_tokenring"></a><dl>
    ///<dt><b>IF_TYPE_ISO88025_TOKENRING</b></dt> <dt>9</dt> </dl> </td> <td width="60%"> A token ring network
    ///interface. </td> </tr> <tr> <td width="40%"><a id="IF_TYPE_PPP"></a><a id="if_type_ppp"></a><dl>
    ///<dt><b>IF_TYPE_PPP</b></dt> <dt>23</dt> </dl> </td> <td width="60%"> A PPP network interface. </td> </tr> <tr>
    ///<td width="40%"><a id="IF_TYPE_SOFTWARE_LOOPBACK"></a><a id="if_type_software_loopback"></a><dl>
    ///<dt><b>IF_TYPE_SOFTWARE_LOOPBACK</b></dt> <dt>24</dt> </dl> </td> <td width="60%"> A software loopback network
    ///interface. </td> </tr> <tr> <td width="40%"><a id="IF_TYPE_ATM"></a><a id="if_type_atm"></a><dl>
    ///<dt><b>IF_TYPE_ATM</b></dt> <dt>37</dt> </dl> </td> <td width="60%"> An ATM network interface. </td> </tr> <tr>
    ///<td width="40%"><a id="IF_TYPE_IEEE80211"></a><a id="if_type_ieee80211"></a><dl>
    ///<dt><b>IF_TYPE_IEEE80211</b></dt> <dt>71</dt> </dl> </td> <td width="60%"> An IEEE 802.11 wireless network
    ///interface. On Windows Vista and later, wireless network cards are reported as <b>IF_TYPE_IEEE80211</b>. On
    ///earlier versions of Windows, wireless network cards are reported as <b>IF_TYPE_ETHERNET_CSMACD</b>. On Windows XP
    ///with SP3 and on Windows XP with SP2 x86 with the Wireless LAN API for Windows XP with SP2 installed, the
    ///WlanEnumInterfaces function can be used to enumerate wireless interfaces on the local computer. </td> </tr> <tr>
    ///<td width="40%"><a id="IF_TYPE_TUNNEL"></a><a id="if_type_tunnel"></a><dl> <dt><b>IF_TYPE_TUNNEL</b></dt>
    ///<dt>131</dt> </dl> </td> <td width="60%"> A tunnel type encapsulation network interface. </td> </tr> <tr> <td
    ///width="40%"><a id="IF_TYPE_IEEE1394"></a><a id="if_type_ieee1394"></a><dl> <dt><b>IF_TYPE_IEEE1394</b></dt>
    ///<dt>144</dt> </dl> </td> <td width="60%"> An IEEE 1394 (Firewire) high performance serial bus network interface.
    ///</td> </tr> </table>
    uint           IfType;
    ///Type: <b>IF_OPER_STATUS</b> The operational status for the interface as defined in RFC 2863. For more
    ///information, see http://www.ietf.org/rfc/rfc2863.txt. This member can be one of the values from the
    ///<b>IF_OPER_STATUS</b> enumeration type defined in the <i>Iftypes.h</i> header file. On Windows Vista and later,
    ///the header files were reorganized and this enumeration is defined in the <i>Ifdef.h</i> header file. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IfOperStatusUp"></a><a
    ///id="ifoperstatusup"></a><a id="IFOPERSTATUSUP"></a><dl> <dt><b>IfOperStatusUp</b></dt> <dt>1</dt> </dl> </td> <td
    ///width="60%"> The interface is up and able to pass packets. </td> </tr> <tr> <td width="40%"><a
    ///id="IfOperStatusDown"></a><a id="ifoperstatusdown"></a><a id="IFOPERSTATUSDOWN"></a><dl>
    ///<dt><b>IfOperStatusDown</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The interface is down and not in a
    ///condition to pass packets. The <b>IfOperStatusDown</b> state has two meanings, depending on the value of
    ///<b>AdminStatus</b> member. If <b>AdminStatus</b> is not set to <b>NET_IF_ADMIN_STATUS_DOWN</b> and
    ///<b>ifOperStatus</b> is set to <b>IfOperStatusDown</b> then a fault condition is presumed to exist on the
    ///interface. If <b>AdminStatus</b> is set to <b>IfOperStatusDown</b>, then <b>ifOperStatus</b> will normally also
    ///be set to <b>IfOperStatusDown</b> or <b>IfOperStatusNotPresent</b> and there is not necessarily a fault condition
    ///on the interface. </td> </tr> <tr> <td width="40%"><a id="IfOperStatusTesting"></a><a
    ///id="ifoperstatustesting"></a><a id="IFOPERSTATUSTESTING"></a><dl> <dt><b>IfOperStatusTesting</b></dt> <dt>3</dt>
    ///</dl> </td> <td width="60%"> The interface is in testing mode. </td> </tr> <tr> <td width="40%"><a
    ///id="IfOperStatusUnknown"></a><a id="ifoperstatusunknown"></a><a id="IFOPERSTATUSUNKNOWN"></a><dl>
    ///<dt><b>IfOperStatusUnknown</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> The operational status of the
    ///interface is unknown. </td> </tr> <tr> <td width="40%"><a id="IfOperStatusDormant"></a><a
    ///id="ifoperstatusdormant"></a><a id="IFOPERSTATUSDORMANT"></a><dl> <dt><b>IfOperStatusDormant</b></dt> <dt>5</dt>
    ///</dl> </td> <td width="60%"> The interface is not actually in a condition to pass packets (it is not up), but is
    ///in a pending state, waiting for some external event. For on-demand interfaces, this new state identifies the
    ///situation where the interface is waiting for events to place it in the <b>IfOperStatusUp</b> state. </td> </tr>
    ///<tr> <td width="40%"><a id="IfOperStatusNotPresent"></a><a id="ifoperstatusnotpresent"></a><a
    ///id="IFOPERSTATUSNOTPRESENT"></a><dl> <dt><b>IfOperStatusNotPresent</b></dt> <dt>6</dt> </dl> </td> <td
    ///width="60%"> A refinement on the <b>IfOperStatusDown</b> state which indicates that the relevant interface is
    ///down specifically because some component (typically, a hardware component) is not present in the managed system.
    ///</td> </tr> <tr> <td width="40%"><a id="IfOperStatusLowerLayerDown"></a><a id="ifoperstatuslowerlayerdown"></a><a
    ///id="IFOPERSTATUSLOWERLAYERDOWN"></a><dl> <dt><b>IfOperStatusLowerLayerDown</b></dt> <dt>7</dt> </dl> </td> <td
    ///width="60%"> A refinement on the <b>IfOperStatusDown</b> state. This new state indicates that this interface runs
    ///on top of one or more other interfaces and that this interface is down specifically because one or more of these
    ///lower-layer interfaces are down. </td> </tr> </table>
    IF_OPER_STATUS OperStatus;
    ///Type: <b>DWORD</b> The interface index for the IPv6 IP address. This member is zero if IPv6 is not available on
    ///the interface. <div class="alert"><b>Note</b> This structure member is only available on Windows XP with SP1 and
    ///later.</div> <div> </div>
    uint           Ipv6IfIndex;
    ///Type: <b>DWORD[16]</b> An array of scope IDs for each scope level used for composing sockaddr structures. The
    ///SCOPE_LEVEL enumeration is used to index the array. On IPv6, a single interface may be assigned multiple IPv6
    ///multicast addresses based on a scope ID. <div class="alert"><b>Note</b> This structure member is only available
    ///on Windows XP with SP1 and later.</div> <div> </div>
    uint[16]       ZoneIndices;
    ///Type: <b>PIP_ADAPTER_PREFIX</b> A pointer to the first IP_ADAPTER_PREFIX structure in a linked list of IP adapter
    ///prefixes for the adapter. <div class="alert"><b>Note</b> This structure member is only available on Windows XP
    ///with SP1 and later.</div> <div> </div>
    IP_ADAPTER_PREFIX_XP* FirstPrefix;
}

///The <b>IP_PER_ADAPTER_INFO</b> structure contains information specific to a particular adapter.
struct IP_PER_ADAPTER_INFO_W2KSP1
{
    ///Specifies whether IP address auto-configuration (APIPA) is enabled on this adapter. See Remarks.
    uint            AutoconfigEnabled;
    ///Specifies whether this adapter's IP address is currently auto-configured by APIPA.
    uint            AutoconfigActive;
    ///Reserved. Use the <b>DnsServerList</b> member to obtain the DNS servers for the local computer.
    IP_ADDR_STRING* CurrentDnsServer;
    ///A linked list of IP_ADDR_STRING structures that specify the set of DNS servers used by the local computer.
    IP_ADDR_STRING  DnsServerList;
}

///The <b>FIXED_INFO</b> structure contains information that is the same across all the interfaces on a computer.
struct FIXED_INFO_W2KSP1
{
    ///Type: <b>char[MAX_HOSTNAME_LEN + 4]</b> The hostname for the local computer. This may be the fully qualified
    ///hostname (including the domain) for a computer that is joined to a domain.
    byte[132]       HostName;
    ///Type: <b>char[MAX_DOMAIN_NAME_LEN + 4]</b> The domain in which the local computer is registered.
    byte[132]       DomainName;
    ///Type: <b>PIP_ADDR_STRING</b> Reserved. Use the <b>DnsServerList</b> member to obtain the DNS servers for the
    ///local computer.
    IP_ADDR_STRING* CurrentDnsServer;
    ///Type: <b>IP_ADDR_STRING</b> A linked list of IP_ADDR_STRING structures that specify the set of DNS servers used
    ///by the local computer.
    IP_ADDR_STRING  DnsServerList;
    ///Type: <b>UINT</b> The node type of the local computer. These values are defined in the <i>Iptypes.h</i> header
    ///file. <table> <tr> <th>NodeType</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="BROADCAST_NODETYPE"></a><a id="broadcast_nodetype"></a><dl> <dt><b>BROADCAST_NODETYPE</b></dt>
    ///<dt>0x0001</dt> </dl> </td> <td width="60%"> A broadcast nodetype. </td> </tr> <tr> <td width="40%"><a
    ///id="PEER_TO_PEER_NODETYPE"></a><a id="peer_to_peer_nodetype"></a><dl> <dt><b>PEER_TO_PEER_NODETYPE</b></dt>
    ///<dt>0x0002</dt> </dl> </td> <td width="60%"> A peer to peer nodetype. </td> </tr> <tr> <td width="40%"><a
    ///id="MIXED_NODETYPE"></a><a id="mixed_nodetype"></a><dl> <dt><b>MIXED_NODETYPE</b></dt> <dt>0x0004</dt> </dl>
    ///</td> <td width="60%"> A mixed nodetype. </td> </tr> <tr> <td width="40%"><a id="HYBRID_NODETYPE"></a><a
    ///id="hybrid_nodetype"></a><dl> <dt><b>HYBRID_NODETYPE</b></dt> <dt>0x0008</dt> </dl> </td> <td width="60%"> A
    ///hybrid nodetype. </td> </tr> </table>
    uint            NodeType;
    ///Type: <b>char[MAX_SCOPE_ID_LEN + 4]</b> The DHCP scope name.
    byte[260]       ScopeId;
    ///Type: <b>UINT</b> A Boolean value that specifies whether routing is enabled on the local computer.
    uint            EnableRouting;
    ///Type: <b>UINT</b> A Boolean value that specifies whether the local computer is acting as an ARP proxy.
    uint            EnableProxy;
    ///Type: <b>UINT</b> A Boolean value that specifies whether DNS is enabled on the local computer.
    uint            EnableDns;
}

///The <b>IP_INTERFACE_NAME_INFO</b> structure contains information about an IPv4 interface on the local computer.
struct ip_interface_name_info_w2ksp1
{
    ///Type: <b>ULONG</b> The index of the IP interface for the active instance.
    uint  Index;
    ///Type: <b>ULONG</b> The interface type as defined by the Internet Assigned Names Authority (IANA). Possible values
    ///for the interface type are listed in the Ipifcons.h header file. The table below lists common values for the
    ///interface type; although, many other values are possible. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="IF_TYPE_OTHER"></a><a id="if_type_other"></a><dl> <dt><b>IF_TYPE_OTHER</b></dt> <dt>1</dt>
    ///</dl> </td> <td width="60%"> Some other type of network interface. </td> </tr> <tr> <td width="40%"><a
    ///id="IF_TYPE_ETHERNET_CSMACD"></a><a id="if_type_ethernet_csmacd"></a><dl> <dt><b>IF_TYPE_ETHERNET_CSMACD</b></dt>
    ///<dt>6</dt> </dl> </td> <td width="60%"> An Ethernet network interface. </td> </tr> <tr> <td width="40%"><a
    ///id="IF_TYPE_ISO88025_TOKENRING"></a><a id="if_type_iso88025_tokenring"></a><dl>
    ///<dt><b>IF_TYPE_ISO88025_TOKENRING</b></dt> <dt>9</dt> </dl> </td> <td width="60%"> A token ring network
    ///interface. </td> </tr> <tr> <td width="40%"><a id="IF_TYPE_PPP"></a><a id="if_type_ppp"></a><dl>
    ///<dt><b>IF_TYPE_PPP</b></dt> <dt>23</dt> </dl> </td> <td width="60%"> A PPP network interface. </td> </tr> <tr>
    ///<td width="40%"><a id="IF_TYPE_SOFTWARE_LOOPBACK"></a><a id="if_type_software_loopback"></a><dl>
    ///<dt><b>IF_TYPE_SOFTWARE_LOOPBACK</b></dt> <dt>24</dt> </dl> </td> <td width="60%"> A software loopback network
    ///interface. </td> </tr> <tr> <td width="40%"><a id="IF_TYPE_ATM"></a><a id="if_type_atm"></a><dl>
    ///<dt><b>IF_TYPE_ATM</b></dt> <dt>37</dt> </dl> </td> <td width="60%"> An ATM network interface. </td> </tr> <tr>
    ///<td width="40%"><a id="IF_TYPE_IEEE80211"></a><a id="if_type_ieee80211"></a><dl>
    ///<dt><b>IF_TYPE_IEEE80211</b></dt> <dt>71</dt> </dl> </td> <td width="60%"> An IEEE 802.11 wireless network
    ///interface. On Windows Vista and later, wireless network cards are reported as <b>IF_TYPE_IEEE80211</b>.
    ///<b>Windows Server 2003, Windows 2000 Server with SP1 and Windows XP/2000: </b>Wireless network cards are reported
    ///as <b>IF_TYPE_ETHERNET_CSMACD</b>. </td> </tr> <tr> <td width="40%"><a id="IF_TYPE_TUNNEL"></a><a
    ///id="if_type_tunnel"></a><dl> <dt><b>IF_TYPE_TUNNEL</b></dt> <dt>131</dt> </dl> </td> <td width="60%"> A tunnel
    ///type encapsulation network interface. </td> </tr> <tr> <td width="40%"><a id="IF_TYPE_IEEE1394"></a><a
    ///id="if_type_ieee1394"></a><dl> <dt><b>IF_TYPE_IEEE1394</b></dt> <dt>144</dt> </dl> </td> <td width="60%"> An IEEE
    ///1394 (Firewire) high performance serial bus network interface. </td> </tr> </table>
    uint  MediaType;
    ///Type: <b>UCHAR</b> The interface connection type for the adapter. The possible values for this member are defined
    ///in the Ipifcons.h header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="IF_CONNECTION_DEDICATED"></a><a id="if_connection_dedicated"></a><dl> <dt><b>IF_CONNECTION_DEDICATED</b></dt>
    ///<dt>1</dt> </dl> </td> <td width="60%"> The connection type is dedicated. The connection comes up automatically
    ///when media sense is <b>TRUE</b>. For example, an Ethernet connection is dedicated. </td> </tr> <tr> <td
    ///width="40%"><a id="IF_CONNECTION_PASSIVE"></a><a id="if_connection_passive"></a><dl>
    ///<dt><b>IF_CONNECTION_PASSIVE</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The connection type is passive. The
    ///remote end must bring up the connection to the local station. For example, a RAS interface is passive. </td>
    ///</tr> <tr> <td width="40%"><a id="IF_CONNECTION_DEMAND"></a><a id="if_connection_demand"></a><dl>
    ///<dt><b>IF_CONNECTION_DEMAND</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> The connection type is demand-dial.
    ///A connection of this type comes up in response to a local action (sending a packet, for example). </td> </tr>
    ///</table>
    ubyte ConnectionType;
    ///Type: <b>UCHAR</b> A value of the IF_ACCESS_TYPE enumeration that specifies the access type for the interface.
    ///<b>Windows Server 2003, Windows 2000 Server with SP1 and Windows XP/2000: </b>The possible values for this member
    ///are defined in the Ipifcons.h header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="IF_ACCESS_LOOPBACK"></a><a id="if_access_loopback"></a><dl> <dt><b>IF_ACCESS_LOOPBACK</b></dt>
    ///<dt>1</dt> </dl> </td> <td width="60%"> The loopback access type. This value indicates that the interface loops
    ///back transmit data as receive data. </td> </tr> <tr> <td width="40%"><a id="IF_ACCESS_BROADCAST"></a><a
    ///id="if_access_broadcast"></a><dl> <dt><b>IF_ACCESS_BROADCAST</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The
    ///LAN access type which includes Ethernet. This value indicates that the interface provides native support for
    ///multicast or broadcast services. </td> </tr> <tr> <td width="40%"><a id="IF_ACCESS_POINT_TO_POINT"></a><a
    ///id="if_access_point_to_point"></a><dl> <dt><b>IF_ACCESS_POINT_TO_POINT</b></dt> <dt>3</dt> </dl> </td> <td
    ///width="60%"> The point to point access type. This value indicates support for CoNDIS/WAN, except for
    ///non-broadcast multi-access (NBMA) interfaces. <b>Windows Server 2003, Windows 2000 Server with SP1 and Windows
    ///XP/2000: </b>This value was defined as <b>IF_ACCESS_POINTTOPOINT</b> in the Ipifcons.h header file. </td> </tr>
    ///<tr> <td width="40%"><a id="IF_ACCESS_POINT_TO_MULTI_POINT"></a><a id="if_access_point_to_multi_point"></a><dl>
    ///<dt><b>IF_ACCESS_POINT_TO_MULTI_POINT</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> The point to multipoint
    ///access type. This value indicates support for non-broadcast multi-access media, including the RAS internal
    ///interface and native ATM. <b>Windows Server 2003, Windows 2000 Server with SP1 and Windows XP/2000: </b>This
    ///value was defined as <b>IF_ACCESS_POINTTOMULTIPOINT</b> in the Ipifcons.h header file. </td> </tr> </table>
    ubyte AccessType;
    ///Type: <b>GUID</b> The GUID that identifies the underlying device for the interface. This member can be a zero
    ///GUID.
    GUID  DeviceGuid;
    ///Type: <b>GUID</b> The GUID that identifies the interface mapped to the device. Optional. This member can be a
    ///zero GUID.
    GUID  InterfaceGuid;
}

///The <b>TCP_ESTATS_SYN_OPTS_ROS_v0</b> structure contains read-only static information for extended TCP statistics on
///SYN exchange for a TCP connection.
struct TCP_ESTATS_SYN_OPTS_ROS_v0
{
    ///Type: <b>BOOLEAN</b> A value that indicates if the TCP connection was an active open. If the local connection
    ///traversed the SYN-SENT state, then this member is set to <b>TRUE</b>. Otherwise, this member is set to
    ///<b>FALSE</b>.
    ubyte ActiveOpen;
    ///Type: <b>ULONG</b> The value received in an Maximum Segment Size (MSS) option during the SYN exchange, or zero if
    ///no MSS option was received. This value is the maximum data in a single TCP datagram that the remote host can
    ///receive.
    uint  MssRcvd;
    ///Type: <b>ULONG</b> The value sent in an MSS option during the SYN exchange, or zero if no MSS option was sent.
    uint  MssSent;
}

///The <b>TCP_ESTATS_DATA_ROD_v0</b> structure contains read-only dynamic information for extended TCP statistics on
///data transfer for a TCP connection.
struct TCP_ESTATS_DATA_ROD_v0
{
    ///Type: <b>ULONG64</b> The number of octets of data contained in transmitted segments, including retransmitted
    ///data. Note that this does not include TCP headers.
    ulong DataBytesOut;
    ///Type: <b>ULONG64</b> The number of segments sent containing a positive length data segment.
    ulong DataSegsOut;
    ///Type: <b>ULONG64</b> The number of octets contained in received data segments, including retransmitted data. Note
    ///that this does not include TCP headers.
    ulong DataBytesIn;
    ///Type: <b>ULONG64</b> The number of segments received containing a positive length data segment.
    ulong DataSegsIn;
    ///Type: <b>ULONG64</b> The total number of segments sent.
    ulong SegsOut;
    ///Type: <b></b> The total number of segments received.
    ulong SegsIn;
    ///Type: <b>ULONG</b> The number of segments that fail various consistency tests during TCP input processing. Soft
    ///errors might cause the segment to be discarded but some do not. Some of these soft errors cause the generation of
    ///a TCP acknowledgment, while others are silently discarded.
    uint  SoftErrors;
    ///Type: <b>ULONG</b> A value that identifies which consistency test most recently failed during TCP input
    ///processing. This object is set every time the <b>SoftErrors</b> member is incremented.
    uint  SoftErrorReason;
    ///Type: <b>ULONG</b> The value of the oldest unacknowledged sequence number. Note that this member is a TCP state
    ///variable.
    uint  SndUna;
    ///Type: <b>ULONG</b> The next sequence number to be sent. Note that this member is not monotonic (and thus not a
    ///counter), because TCP sometimes retransmits lost data by pulling the member back to the missing data.
    uint  SndNxt;
    ///Type: <b>ULONG</b> The farthest forward (right most or largest) sequence number to be sent. Note that this will
    ///be equal to the <b>SndNxt</b> member except when the <b>SndNxt</b> member is pulled back during recovery.
    uint  SndMax;
    ///Type: <b>ULONG64</b> The number of octets for which cumulative acknowledgments have been received. Note that this
    ///will be the sum of changes to the <b>SndNxt</b> member.
    ulong ThruBytesAcked;
    ///Type: <b>ULONG</b> The next sequence number to be received. Note that this member is not monotonic (and thus not
    ///a counter), because TCP sometimes retransmits lost data by pulling the member back to the missing data.
    uint  RcvNxt;
    ///Type: <b>ULONG64</b> The number of octets for which cumulative acknowledgments have been sent. Note that this
    ///will be the sum of changes to the <b>RcvNxt</b>member.
    ulong ThruBytesReceived;
}

///The <b>TCP_ESTATS_DATA_RW_v0</b> structure contains read/write configuration information for extended TCP statistics
///on data transfer for a TCP connection.
struct TCP_ESTATS_DATA_RW_v0
{
    ///A value that indicates if extended statistics on a TCP connection should be collected for data transfer
    ///information. If this member is set to <b>TRUE</b>, extended statistics on the TCP connection are enabled. If this
    ///member is set to <b>FALSE</b>, extended statistics on the TCP connection are disabled. The default state for this
    ///member when not set is disabled.
    ubyte EnableCollection;
}

///The <b>TCP_ESTATS_SND_CONG_ROD_v0</b> structure contains read-only dynamic information for extended TCP statistics on
///sender congestion related data for a TCP connection.
struct TCP_ESTATS_SND_CONG_ROD_v0
{
    ///Type: <b>ULONG</b> The number of transitions into the "Receiver Limited" state from either the "Congestion
    ///Limited" or "Sender Limited" states. This state is entered whenever TCP transmission stops because the sender has
    ///filled the announced receiver window.
    uint   SndLimTransRwin;
    ///Type: <b>ULONG</b> The cumulative time, in milliseconds, spent in the "Receiver Limited" state where TCP
    ///transmission stops because the sender has filled the announced receiver window.
    uint   SndLimTimeRwin;
    ///Type: <b>SIZE_T</b> The total number of bytes sent in the "Receiver Limited" state.
    size_t SndLimBytesRwin;
    ///Type: <b>ULONG</b> The number of transitions into the "Congestion Limited" state from either the "Receiver
    ///Limited" or "Sender Limited" states. This state is entered whenever TCP transmission stops because the sender has
    ///reached some limit defined by TCP congestion control (the congestion window, for example) or other algorithms
    ///(retransmission timeouts) designed to control network traffic.
    uint   SndLimTransCwnd;
    ///Type: <b>ULONG</b> The cumulative time, in milliseconds, spent in the "Congestion Limited" state. When there is a
    ///retransmission timeout, it is counted in this member and not the cumulative time for some other state.
    uint   SndLimTimeCwnd;
    ///Type: <b>SIZE_T</b> The total number of bytes sent in the "Congestion Limited" state.
    size_t SndLimBytesCwnd;
    ///Type: <b>ULONG</b> The number of transitions into the "Sender Limited" state from either the "Receiver Limited"
    ///or "Congestion Limited" states. This state is entered whenever TCP transmission stops due to some sender limit
    ///such as running out of application data or other resources and the Karn algorithm. When TCP stops sending data
    ///for any reason, which cannot be classified as "Receiver Limited" or "Congestion Limited", it is treated as
    ///"Sender Limited".
    uint   SndLimTransSnd;
    ///Type: <b>ULONG</b> The cumulative time, in milliseconds, spent in the "Sender Limited" state.
    uint   SndLimTimeSnd;
    ///Type: <b>SIZE_T</b> The total number of bytes sent in the "Sender Limited" state.
    size_t SndLimBytesSnd;
    ///Type: <b>ULONG</b> The number of times the congestion window has been increased by the "Slow Start" algorithm.
    uint   SlowStart;
    ///Type: <b>ULONG</b> The number of times the congestion window has been increased by the "Congestion Avoidance"
    ///algorithm.
    uint   CongAvoid;
    ///Type: <b>ULONG</b> The number of congestion window reductions made as a result of anything other than congestion
    ///control algorithms other than "Slow Start" and "Congestion Avoidance" algorithms.
    uint   OtherReductions;
    ///Type: <b>ULONG</b> The size, in bytes, of the current congestion window.
    uint   CurCwnd;
    ///Type: <b>ULONG</b> The maximum size, in bytes, of the congestion window size used during "Slow Start."
    uint   MaxSsCwnd;
    ///Type: <b>ULONG</b> The maximum size, in bytes, of the congestion window used during "Congestion Avoidance."
    uint   MaxCaCwnd;
    ///Type: <b>ULONG</b> The current size, in bytes, of the slow start threshold.
    uint   CurSsthresh;
    ///Type: <b>ULONG</b> The maximum size, in bytes, of the slow start threshold, excluding the initial value.
    uint   MaxSsthresh;
    ///Type: <b>ULONG</b> The minimum size, in bytes, of the slow start threshold.
    uint   MinSsthresh;
}

///The <b>TCP_ESTATS_SND_CONG_ROS_v0</b> structure contains read-only static information for extended TCP statistics on
///the maximum congestion window for a TCP connection.
struct TCP_ESTATS_SND_CONG_ROS_v0
{
    ///The maximum size, in bytes, of the congestion window that may be used.
    uint LimCwnd;
}

///The <b>TCP_ESTATS_SND_CONG_RW_v0</b> structure contains read/write configuration information for extended TCP
///statistics on sender congestion for a TCP connection.
struct TCP_ESTATS_SND_CONG_RW_v0
{
    ///A value that indicates if extended statistics on a TCP connection should be collected for sender congestion. If
    ///this member is set to <b>TRUE</b>, extended statistics on the TCP connection are enabled. If this member is set
    ///to <b>FALSE</b>, extended statistics on the TCP connection are disabled. The default state for this member when
    ///not set is disabled.
    ubyte EnableCollection;
}

///The <b>TCP_ESTATS_PATH_ROD_v0</b> structure contains read-only dynamic information for extended TCP statistics on
///network path measurement for a TCP connection.
struct TCP_ESTATS_PATH_ROD_v0
{
    ///Type: <b>ULONG</b> The number of invocations of the Fast Retransmit algorithm.
    uint FastRetran;
    ///Type: <b>ULONG</b> The number of times the retransmit timeout has expired when the retransmission timer backoff
    ///multiplier is equal to one.
    uint Timeouts;
    ///Type: <b>ULONG</b> The number of times the retransmit timeout has expired after the retransmission timer has been
    ///doubled. For more information, see section 5.5 of RFC 2988 discussed in the Remarks below.
    uint SubsequentTimeouts;
    ///Type: <b>ULONG</b> The current number of times the retransmit timeout has expired without receiving an
    ///acknowledgment for new data. The <b>CurTimeoutCount</b> member is reset to zero when new data is acknowledged and
    ///incremented for each invocation of Section 5.5 of RFC 2988.
    uint CurTimeoutCount;
    ///Type: <b>ULONG</b> The number of timeouts that occurred without any immediately preceding duplicate
    ///acknowledgments or other indications of congestion. Abrupt timeouts indicate that the path lost an entire window
    ///of data or acknowledgments. Timeouts that are preceded by duplicate acknowledgments or other congestion signals
    ///(Explicit Congestion Notification, for example) are not counted as abrupt, and might have been avoided by a more
    ///sophisticated Fast Retransmit algorithm.
    uint AbruptTimeouts;
    ///Type: <b>ULONG</b> The number of segments transmitted containing at least some retransmitted data.
    uint PktsRetrans;
    ///Type: <b>ULONG</b> The number of bytes retransmitted.
    uint BytesRetrans;
    ///Type: <b>ULONG</b> The number of duplicate ACKs received.
    uint DupAcksIn;
    ///Type: <b>ULONG</b> The number of Selective Acknowledgement (SACK) options received.
    uint SacksRcvd;
    ///Type: <b>ULONG</b> The number of SACK blocks received (within SACK options).
    uint SackBlocksRcvd;
    ///Type: <b>ULONG</b> The number of multiplicative downward congestion window adjustments due to all forms of
    ///congestion signals, including Fast Retransmit, Explicit Congestion Notification (ECN), and timeouts. This member
    ///summarizes all events that invoke the Multiplicative Decrease (MD) portion of Additive Increase Multiplicative
    ///Decrease (AIMD) congestion control, and as such is the best indicator of how a congestion windows is being
    ///affected by congestion. Note that retransmission timeouts multiplicatively reduce the window implicitly by
    ///setting the slow start threshold size, and are included in the value stored in the <b>CongSignals</b> member. In
    ///order to minimize spurious congestion indications due to out-of-order segments, the <b>CongSignals</b> member is
    ///incremented in association with the Fast Retransmit algorithm.
    uint CongSignals;
    ///Type: <b>ULONG</b> The sum of the values of the congestion window, in bytes, captured each time a congestion
    ///signal is received. This member is updated each time the <b>CongSignals</b> member is incremented, such that the
    ///change in the <b>PreCongSumCwnd</b> member divided by the change in the <b>CongSignals</b> member is the average
    ///window (over some interval) just prior to a congestion signal.
    uint PreCongSumCwnd;
    ///Type: <b>ULONG</b> The sum, in milliseconds, of the last sample of the network round-trip-time (RTT) prior to the
    ///received congestion signals. The last sample of the RTT is stored in the <b>SampleRtt</b> member. The
    ///<b>PreCongSumRtt</b> member is updated each time the <b>CongSignals</b> member is incremented, such that the
    ///change in the <b>PreCongSumRtt</b> divided by the change in the <b>CongSignals</b> member is the average RTT
    ///(over some interval) just prior to a congestion signal.
    uint PreCongSumRtt;
    ///Type: <b>ULONG</b> The sum, in milliseconds, of the first sample of the network RTT (stored in the
    ///<b>SampleRtt</b> member) following each congestion signal. The change in the <b>PostCongSumRtt</b> member divided
    ///by the change in the <b>PostCongCountRtt</b> member is the average RTT (over some interval) just after a
    ///congestion signal.
    uint PostCongSumRtt;
    ///Type: <b>ULONG</b> The number of RTT samples, in bytes, included in the <b>PostCongSumRtt</b> member. The change
    ///in the <b>PostCongSumRtt</b> member divided by the change in the <b>PostCongCountRtt</b> member is the average
    ///RTT (over some interval) just after a congestion signal.
    uint PostCongCountRtt;
    ///Type: <b>ULONG</b> The number of congestion signals delivered to the TCP sender via ECN. This is typically the
    ///number of segments bearing Echo Congestion Experienced (ECE) bits, but also includes segments failing the ECN
    ///nonce check or other explicit congestion signals.
    uint EcnSignals;
    ///Type: <b>ULONG</b> The number of segments received with IP headers bearing Congestion Experienced (CE) markings.
    uint EceRcvd;
    ///Type: <b>ULONG</b> The number of interface stalls or other sender local resource limitations that are treated as
    ///congestion signals.
    uint SendStall;
    ///Type: <b>ULONG</b> Reserved for future use. This member is always set to zero.
    uint QuenchRcvd;
    ///Type: <b>ULONG</b> The number of duplicate acknowledgments required to trigger Fast Retransmit. Note that
    ///although this is constant in traditional Reno TCP implementations, it is adaptive in many newer TCP
    ///implementations.
    uint RetranThresh;
    ///Type: <b>ULONG</b> The number of Duplicate Acks Sent when prior Ack was not duplicate. This is the number of
    ///times that a contiguous series of duplicate acknowledgments have been sent. This is an indication of the number
    ///of data segments lost or reordered on the path from the remote TCP endpoint to the near TCP endpoint.
    uint SndDupAckEpisodes;
    ///Type: <b>ULONG</b> The sum of the amounts SND.UNA advances on the acknowledgment which ends a dup-ack episode
    ///without a retransmission. Note the change in the <b>SumBytesReordered</b> member divided by the change in the
    ///<b>NonRecovDaEpisodes</b> member is an estimate of the average reordering distance, over some interval.
    uint SumBytesReordered;
    ///Type: <b>ULONG</b> The number of duplicate acks (or SACKS) that did not trigger a Fast Retransmit because ACK
    ///advanced prior to the number of duplicate acknowledgments reaching the <b>RetranThresh</b>. Note that the change
    ///in the <b>NonRecovDa</b> member divided by the change in the <b>NonRecovDaEpisodes</b> member is an estimate of
    ///the average reordering distance in segments over some interval.
    uint NonRecovDa;
    ///Type: <b>ULONG</b> The number of duplicate acknowledgment episodes that did not trigger a Fast Retransmit because
    ///ACK advanced prior to the number of duplicate acknowledgments reaching the <b>RetranThresh</b>.
    uint NonRecovDaEpisodes;
    ///Type: <b>ULONG</b> Reserved for future use. This member is always set to zero.
    uint AckAfterFr;
    ///Type: <b>ULONG</b> The number of duplicate segments reported to the local host by D-SACK blocks.
    uint DsackDups;
    ///Type: <b>ULONG</b> The most recent raw network round trip time measurement, in milliseconds, used in calculation
    ///of the retransmission timer (RTO).
    uint SampleRtt;
    ///Type: <b>ULONG</b> The smoothed round trip time, in milliseconds, used in calculation of the RTO.
    uint SmoothedRtt;
    ///Type: <b>ULONG</b> The round trip time variation, in milliseconds, used in calculation of the RTO.
    uint RttVar;
    ///Type: <b>ULONG</b> The maximum sampled round trip time in milliseconds.
    uint MaxRtt;
    ///Type: <b>ULONG</b> The minimum sampled round trip time in milliseconds.
    uint MinRtt;
    ///Type: <b>ULONG</b> The sum of all sampled round trip times in milliseconds. Note that the change in the
    ///<b>SumRtt</b> member divided by the change in the <b>CountRtt</b> member is the mean RTT, uniformly averaged over
    ///an enter interval.
    uint SumRtt;
    ///Type: <b>ULONG</b> The number of round trip time samples included in the <b>SumRtt</b> member.
    uint CountRtt;
    ///Type: <b>ULONG</b> The current value, in milliseconds, of the retransmit timer.
    uint CurRto;
    ///Type: <b>ULONG</b> The maximum value, in milliseconds, of the retransmit timer.
    uint MaxRto;
    ///Type: <b>ULONG</b> The minimum value, in milliseconds, of the retransmit timer.
    uint MinRto;
    ///Type: <b>ULONG</b> The current maximum segment size (MSS), in bytes.
    uint CurMss;
    ///Type: <b>ULONG</b> The maximum MSS, in bytes.
    uint MaxMss;
    ///Type: <b>ULONG</b> The minimum MSS, in bytes.
    uint MinMss;
    ///Type: <b>ULONG</b> The number of acknowledgments reporting segments that have already been retransmitted due to a
    ///Retransmission Timeout.
    uint SpuriousRtoDetections;
}

///The <b>TCP_ESTATS_PATH_RW_v0</b> structure contains read/write configuration information for extended TCP statistics
///on path measurement for a TCP connection.
struct TCP_ESTATS_PATH_RW_v0
{
    ///A value that indicates if extended statistics on a TCP connection should be collected for path measurement
    ///information. If this member is set to <b>TRUE</b>, extended statistics on the TCP connection are enabled. If this
    ///member is set to <b>FALSE</b>, extended statistics on the TCP connection are disabled. The default state for this
    ///member when not set is disabled.
    ubyte EnableCollection;
}

///The <b>TCP_ESTATS_SEND_BUFF_ROD_v0</b> structure contains read-only dynamic information for extended TCP statistics
///on output queuing for a TCP connection.
struct TCP_ESTATS_SEND_BUFF_ROD_v0
{
    ///Type: <b>SIZE_T</b> The current number of bytes of data occupying the retransmit queue.
    size_t CurRetxQueue;
    ///Type: <b>SIZE_T</b> The maximum number of bytes of data occupying the retransmit queue.
    size_t MaxRetxQueue;
    ///Type: <b>SIZE_T</b> The current number of bytes of application data buffered by TCP, pending the first
    ///transmission (to the left of SND.NXT or SndMax). This data will generally be transmitted (and SND.NXT advanced to
    ///the left) as soon as there is an available congestion window or receiver window. This is the amount of data
    ///readily available for transmission, without scheduling the application. TCP performance may suffer if there is
    ///insufficient queued write data.
    size_t CurAppWQueue;
    ///Type: <b>SIZE_T</b> The maximum number of bytes of application data buffered by TCP, pending the first
    ///transmission. This is the maximum value of the <b>CurAppWQueue</b> member. The <b>MaxAppWQueue</b> and
    ///<b>CurAppWQueue</b> members can be used to determine if insufficient queued data is steady state (suggesting
    ///insufficient queue space) or transient (suggesting insufficient application performance or excessive CPU load or
    ///scheduler latency).
    size_t MaxAppWQueue;
}

///The <b>TCP_ESTATS_SEND_BUFF_RW_v0</b> structure contains read/write configuration information for extended TCP
///statistics on output queuing for a TCP connection.
struct TCP_ESTATS_SEND_BUFF_RW_v0
{
    ///A value that indicates if extended statistics on a TCP connection should be collected on output queuing. If this
    ///member is set to <b>TRUE</b>, extended statistics on the TCP connection are enabled. If this member is set to
    ///<b>FALSE</b>, extended statistics on the TCP connection are disabled. The default state for this member when not
    ///set is disabled.
    ubyte EnableCollection;
}

///The <b>TCP_ESTATS_REC_ROD_v0</b> structure contains read-only dynamic information for extended TCP statistics on the
///local receiver for a TCP connection.
struct TCP_ESTATS_REC_ROD_v0
{
    ///Type: <b>ULONG</b> The most recent window advertisement, in bytes, that has been sent.
    uint   CurRwinSent;
    ///Type: <b>ULONG</b> The maximum window advertisement, in bytes, that has been sent.
    uint   MaxRwinSent;
    ///Type: <b>ULONG</b> The minimum window advertisement, in bytes, that has been sent.
    uint   MinRwinSent;
    ///Type: <b>ULONG</b> The maximum window advertisement, in bytes, that may be sent.
    uint   LimRwin;
    ///Type: <b>ULONG</b> The number of Duplicate Acks Sent when prior Ack was not duplicate. This is the number of
    ///times that a contiguous series of duplicate acknowledgments have been sent. This is an indication of the number
    ///of data segments lost or reordered on the path from the remote TCP endpoint to the near TCP endpoint.
    uint   DupAckEpisodes;
    ///Type: <b>ULONG</b> The number of duplicate ACKs sent. The ratio of the change in the <b>DupAcksOut</b> member to
    ///the change in the <b>DupAckEpisodes</b> member is an indication of reorder or recovery distance over some
    ///interval.
    uint   DupAcksOut;
    ///Type: <b>ULONG</b> The number of segments received with IP headers bearing Congestion Experienced (CE) markings.
    uint   CeRcvd;
    ///Type: <b>ULONG</b> Reserved for future use. This member is always set to zero.
    uint   EcnSent;
    ///Type: <b>ULONG</b> Reserved for future use. This member is always set to zero.
    uint   EcnNoncesRcvd;
    ///Type: <b>ULONG</b> The current number of bytes of sequence space spanned by the reassembly queue. This is
    ///generally the difference between rcv.nxt and the sequence number of the right most edge of the reassembly queue.
    uint   CurReasmQueue;
    ///Type: <b>ULONG</b> The maximum number of bytes of sequence space spanned by the reassembly queue. This is the
    ///maximum value of the <b>CurReasmQueue</b> member.
    uint   MaxReasmQueue;
    ///Type: <b>SIZE_T</b> The current number of bytes of application data that has been acknowledged by TCP but not yet
    ///delivered to the application.
    size_t CurAppRQueue;
    ///Type: <b>SIZE_T</b> The maximum number of bytes of application data that has been acknowledged by TCP but not yet
    ///delivered to the application.
    size_t MaxAppRQueue;
    ///Type: <b>UCHAR</b> The value of the transmitted window scale option if one was sent; otherwise, a value of -1.
    ///Note that if both the <b>WinScaleSent</b> member and the <b>WinScaleRcvd</b> member of the
    ///TCP_ESTATS_OBS_REC_ROD_v0 structure are not -1, then Rcv.Wind.Scale will be the same as this value and used to
    ///scale receiver window announcements from the local host to the remote host.
    ubyte  WinScaleSent;
}

///The <b>TCP_ESTATS_REC_RW_v0</b> structure contains read/write configuration information for extended TCP statistics
///on the local receiver for a TCP connection.
struct TCP_ESTATS_REC_RW_v0
{
    ///A value that indicates if extended statistics on a TCP connection should be collected for local-receiver
    ///information. If this member is set to <b>TRUE</b>, extended statistics on the TCP connection are enabled. If this
    ///member is set to <b>FALSE</b>, extended statistics on the TCP connection are disabled. The default state for this
    ///member when not set is disabled.
    ubyte EnableCollection;
}

///The <b>TCP_ESTATS_OBS_REC_ROD_v0</b> structure contains read-only dynamic information for extended TCP statistics
///observed on the remote receiver for a TCP connection.
struct TCP_ESTATS_OBS_REC_ROD_v0
{
    ///Type: <b>ULONG</b> The most recent window advertisement, in bytes, received from the remote receiver.
    uint  CurRwinRcvd;
    ///Type: <b>ULONG</b> The maximum window advertisement, in bytes, received from the remote receiver.
    uint  MaxRwinRcvd;
    ///Type: <b>ULONG</b> The minimum window advertisement, in bytes, received from the remote receiver.
    uint  MinRwinRcvd;
    ///Type: <b>ULONG</b> The value of the received window scale option if one was received from the remote receiver;
    ///otherwise, a value of -1. Note that if both the <b>WinScaleSent</b> member of the TCP_ESTATS_REC_ROD_v0 structure
    ///and the <b>WinScaleRcvd</b> member are not -1, then Snd.Wind.Scale will be the same as this value and used to
    ///scale receiver window announcements from the remote host to the local host.
    ubyte WinScaleRcvd;
}

///The <b>TCP_ESTATS_OBS_REC_RW_v0</b> structure contains read/write configuration information for extended TCP
///statistics observed on the remote receiver for a TCP connection.
struct TCP_ESTATS_OBS_REC_RW_v0
{
    ///A value that indicates if extended statistics on a TCP connection should be collected for remote-receiver
    ///information. If this member is set to <b>TRUE</b>, extended statistics on the TCP connection are enabled. If this
    ///member is set to <b>FALSE</b>, extended statistics on the TCP connection are disabled. The default state for this
    ///member when not set is disabled.
    ubyte EnableCollection;
}

///The <b>TCP_ESTATS_BANDWIDTH_RW_v0</b> structure contains read/write configuration information for extended TCP
///statistics on bandwidth estimation for a TCP connection.
struct TCP_ESTATS_BANDWIDTH_RW_v0
{
    ///A value that indicates if extended statistics on a TCP connection should be collected for outbound bandwidth
    ///estimation. If this member is set to <b>TcpBoolOptEnabled</b>, extended statistics on the TCP connection for
    ///outbound bandwidth estimation are enabled. If this member is set to <b>TcpBoolOptDisabled</b>, extended
    ///statistics on the TCP connection for outbound bandwidth estimation are disabled. If this member is set to
    ///<b>TcpBoolOptUnchanged</b>, extended statistics on the TCP connection for outbound bandwidth estimation are left
    ///unchanged. The default state for this member when not set is disabled.
    TCP_BOOLEAN_OPTIONAL EnableCollectionOutbound;
    ///A value that indicates if extended statistics on a TCP connection should be collected for inbound bandwidth
    ///estimation. If this member is set to <b>TcpBoolOptEnabled</b>, extended statistics on the TCP connection for
    ///inbound bandwidth estimation are enabled. If this member is set to <b>TcpBoolOptDisabled</b>, extended statistics
    ///on the TCP connection for inbound bandwidth estimation are disabled. If this member is set to
    ///<b>TcpBoolOptUnchanged</b>, extended statistics on the TCP connection for inbound bandwidth estimation are
    ///unchanged. The default state for this member when not set is disabled.
    TCP_BOOLEAN_OPTIONAL EnableCollectionInbound;
}

///The <b>TCP_ESTATS_BANDWIDTH_ROD_v0</b> structure contains read-only dynamic information for extended TCP statistics
///on bandwidth estimation for a TCP connection.
struct TCP_ESTATS_BANDWIDTH_ROD_v0
{
    ///Type: <b>ULONG64</b> The computed outbound bandwidth estimate, in bits per second, for the network path for the
    ///TCP connection.
    ulong OutboundBandwidth;
    ///Type: <b>ULONG64</b> The computed inbound bandwidth estimate, in bits per second, for the network path for the
    ///TCP connection.
    ulong InboundBandwidth;
    ///Type: <b>ULONG64</b> A measure, in bits per second, of the instability of the outbound bandwidth estimate for the
    ///network path for the TCP connection.
    ulong OutboundInstability;
    ///Type: <b>ULONG64</b> A measure, in bits per second, of the instability of the inbound bandwidth estimate for the
    ///network path for the TCP connection.
    ulong InboundInstability;
    ///Type: <b>BOOLEAN</b> A boolean value that indicates if the computed outbound bandwidth estimate for the network
    ///path for the TCP connection has reached its peak value.
    ubyte OutboundBandwidthPeaked;
    ///Type: <b>BOOLEAN</b> A boolean value that indicates if the computed inbound bandwidth estimate for the network
    ///path for the TCP connection has reached its peak value.
    ubyte InboundBandwidthPeaked;
}

///The <b>TCP_ESTATS_FINE_RTT_RW_v0</b> structure contains read/write configuration information for extended TCP
///statistics on fine-grained round-trip time (RTT) estimation statistics for a TCP connection.
struct TCP_ESTATS_FINE_RTT_RW_v0
{
    ///A value that indicates if extended statistics on a TCP connection should be collected for fine-grained RTT
    ///estimation statistics. If this member is set to <b>TRUE</b>, extended statistics on the TCP connection are
    ///enabled. If this member is set to <b>FALSE</b>, extended statistics on the TCP connection are disabled. The
    ///default state for this member when not set is disabled.
    ubyte EnableCollection;
}

///The <b>TCP_ESTATS_FINE_RTT_ROD_v0</b> structure contains read-only dynamic information for extended TCP statistics on
///fine-grained round-trip time (RTT) estimation for a TCP connection.
struct TCP_ESTATS_FINE_RTT_ROD_v0
{
    ///Type: <b>ULONG</b> The round trip time variation, in microseconds, used in receive window auto-tuning when the
    ///TCP extended statistics feature is enabled.
    uint RttVar;
    ///Type: <b>ULONG</b> The maximum sampled round trip time, in microseconds.
    uint MaxRtt;
    ///Type: <b>ULONG</b> The minimum sampled round trip time, in microseconds.
    uint MinRtt;
    ///Type: <b>ULONG</b> A smoothed value round trip time, in microseconds, computed from all sampled round trip times.
    ///The smoothing is a weighted additive function that uses the <b>RttVar</b> member.
    uint SumRtt;
}

///This structure is reserved for system use, and you should not use it in your code.
struct INTERFACE_TIMESTAMP_CAPABILITY_FLAGS
{
    ///Reserved.
    ubyte PtpV2OverUdpIPv4EventMsgReceiveHw;
    ///Reserved.
    ubyte PtpV2OverUdpIPv4AllMsgReceiveHw;
    ///Reserved.
    ubyte PtpV2OverUdpIPv4EventMsgTransmitHw;
    ///Reserved.
    ubyte PtpV2OverUdpIPv4AllMsgTransmitHw;
    ///Reserved.
    ubyte PtpV2OverUdpIPv6EventMsgReceiveHw;
    ///Reserved.
    ubyte PtpV2OverUdpIPv6AllMsgReceiveHw;
    ///Reserved.
    ubyte PtpV2OverUdpIPv6EventMsgTransmitHw;
    ///Reserved.
    ubyte PtpV2OverUdpIPv6AllMsgTransmitHw;
    ///Reserved.
    ubyte AllReceiveHw;
    ///Reserved.
    ubyte AllTransmitHw;
    ///Reserved.
    ubyte TaggedTransmitHw;
    ///Reserved.
    ubyte AllReceiveSw;
    ///Reserved.
    ubyte AllTransmitSw;
    ubyte TaggedTransmitSw;
}

///This structure is reserved for system use, and you should not use it in your code.
struct INTERFACE_TIMESTAMP_CAPABILITIES
{
    ///Reserved.
    uint  Version;
    ///Reserved.
    ulong HardwareClockFrequencyHz;
    ///Reserved.
    ubyte CrossTimestamp;
    ///Reserved.
    ulong Reserved1;
    ///Reserved.
    ulong Reserved2;
    INTERFACE_TIMESTAMP_CAPABILITY_FLAGS TimestampFlags;
}

///This structure is reserved for system use, and you should not use it in your code.
struct INTERFACE_HARDWARE_CROSSTIMESTAMP
{
    ///Reserved.
    uint  Version;
    ///Reserved.
    uint  Flags;
    ///Reserved.
    ulong SystemTimestamp1;
    ///Reserved.
    ulong HardwareClockTimestamp;
    ulong SystemTimestamp2;
}

struct HIFTIMESTAMPCHANGE__
{
    int unused;
}

@RAIIFree!IcmpCloseHandle
struct IcmpHandle
{
    ptrdiff_t Value;
}

///The <b>NET_ADDRESS_INFO</b> structure contains IP address information returned by the ParseNetworkString function.
struct NET_ADDRESS_INFO
{
}

///The <b>SOCKADDR_INET</b> union contains an IPv4, an IPv6 address, or an address family.
union SOCKADDR_INET
{
    ///Type: <b>SOCKADDR_IN</b> An IPv4 address represented as a SOCKADDR_IN structure containing the address family and
    ///the IPv4 address. The address family is in host byte order and the IPv4 address is in network byte order. On the
    ///Windows SDK released for Windows Vista and later, the organization of header files has changed and the
    ///SOCKADDR_IN structure is defined in the <i>Ws2def.h</i> header file. Note that the <i>Ws2def.h</i> header file is
    ///automatically included in <i>Winsock2.h</i>, and should never be used directly.
    sockaddr_in     Ipv4;
    ///Type: <b>SOCKADDR_IN6</b> An IPv6 address represented as a SOCKADDR_IN6 structure containing the address family
    ///and the IPv6 address. The address family is in host byte order and the IPv6 address is in network byte order. On
    ///the Windows SDK released for Windows Vista and later, the organization of header files has changed and the
    ///SOCKADDR_IN6 structure is defined in the <i>Ws2def.h</i> header file. Note that the <i>Ws2def.h</i> header file
    ///is automatically included in <i>Winsock2.h</i>, and should never be used directly.
    SOCKADDR_IN6_LH Ipv6;
    ///Type: <b>ADDRESS_FAMILY</b> The address family. Possible values for the address family are listed in the
    ///<i>Ws2def.h</i> header file. Note that the values for the AF_ address family and PF_ protocol family constants
    ///are identical (for example, <b>AF_INET</b> and <b>PF_INET</b>), so either constant can be used. The
    ///<i>Ws2def.h</i> header file is automatically included in <i>Winsock2.h</i>, and should never be used directly.
    ///The values currently supported are <b>AF_INET</b>, <b>AF_INET6</b>, and <b>AF_UNSPEC</b>. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="AF_UNSPEC"></a><a id="af_unspec"></a><dl>
    ///<dt><b>AF_UNSPEC</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The address family is unspecified. When this
    ///parameter is specified, the <b>SOCKADDR_INET</b> union can represent either the IPv4 or IPv6 address family.
    ///</td> </tr> <tr> <td width="40%"><a id="AF_INET"></a><a id="af_inet"></a><dl> <dt><b>AF_INET</b></dt> <dt>2</dt>
    ///</dl> </td> <td width="60%"> The Internet Protocol version 4 (IPv4) address family. </td> </tr> <tr> <td
    ///width="40%"><a id="AF_INET6"></a><a id="af_inet6"></a><dl> <dt><b>AF_INET6</b></dt> <dt>23</dt> </dl> </td> <td
    ///width="60%"> The Internet Protocol version 6 (IPv6) address family. </td> </tr> </table>
    ushort          si_family;
}

///The <b>SOCKADDR_IN6_PAIR</b> structure contains pointers to a pair of IP addresses that represent a source and
///destination address pair.
struct SOCKADDR_IN6_PAIR
{
    ///A pointer to an IP source address represented as a SOCKADDR_IN6 structure. The address family is in host byte
    ///order and the IPv6 address, port, flow information, and zone ID are in network byte order.
    SOCKADDR_IN6_LH* SourceAddress;
    ///A pointer to an IP source address represented as a SOCKADDR_IN6 structure. The address family is in host byte
    ///order and the IPv6 address, port, flow information, and zone ID are in network byte order.
    SOCKADDR_IN6_LH* DestinationAddress;
}

///Describes a level of network connectivity, the usage charge for a network connection, and other members reflecting
///cost factors. The last four members of **NL_NETWORK_CONNECTIVITY_HINT** collectively work together to allow you to
///resolve the cost of using a connection. See the guidelines in [How to manage metered network cost
///constraints](/previous-versions/windows/apps/jj835821(v=win.10)).
struct NL_NETWORK_CONNECTIVITY_HINT
{
    ///Type: **[NL_NETWORK_CONNECTIVITY_LEVEL_HINT](./ne-nldef-nl_network_connectivity_level_hint.md)** The level of
    ///network connectivity.
    NL_NETWORK_CONNECTIVITY_LEVEL_HINT ConnectivityLevel;
    ///Type: **[NL_NETWORK_CONNECTIVITY_COST_HINT](./ne-nldef-nl_network_connectivity_cost_hint.md)** The usage charge
    ///for the network connection.
    NL_NETWORK_CONNECTIVITY_COST_HINT ConnectivityCost;
    ///Type: **[BOOLEAN](/windows/win32/winprog/windows-data-types)** `TRUE` if the connection is approaching its data
    ///limit, otherwise `FALSE`.
    ubyte ApproachingDataLimit;
    ///Type: **[BOOLEAN](/windows/win32/winprog/windows-data-types)** `TRUE` if the connection has exceeded its data
    ///limit, otherwise `FALSE`.
    ubyte OverDataLimit;
    ///Type: **[BOOLEAN](/windows/win32/winprog/windows-data-types)** `TRUE` if the connection is roaming, otherwise
    ///`FALSE`.
    ubyte Roaming;
}

///The <b>NL_BANDWIDTH_INFORMATION</b> structure contains read-only information on the available bandwidth estimates and
///associated variance as determined by the TCP/IP stack.
struct NL_BANDWIDTH_INFORMATION
{
    ///The estimated maximum available bandwidth, in bits per second.
    ulong Bandwidth;
    ///A measure of the variation based on recent bandwidth samples, in bits per second.
    ulong Instability;
    ///A value that indicates if the bandwidth estimate in the <b>Bandwidth</b> member has peaked and reached its
    ///maximum value for the given network conditions. The TCP/IP stack uses a heuristic to set this variable. Until
    ///this variable is set, there is no guarantee that the true available maximum bandwidth is not higher than the
    ///estimated bandwidth in the <b>Bandwidth</b> member. However, it is safe to assume that maximum available
    ///bandwidth is not lower than the estimate reported in the <b>Bandwidth</b> member.
    ubyte BandwidthPeaked;
}

// Functions

///The <b>GetIfEntry2</b> function retrieves information for the specified interface on the local computer.
///Params:
///    Row = A pointer to a MIB_IF_ROW2 structure that, on successful return, receives information for an interface on the
///          local computer. On input, the <b>InterfaceLuid</b> or the <b>InterfaceIndex</b> member of the <b>MIB_IF_ROW2</b>
///          must be set to the interface for which to retrieve information.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The system cannot find the file specified. This
///    error is returned if the network interface LUID or interface index specified by the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> member of the MIB_IF_ROW2 pointed to by the <i>Row</i> parameter was not a value on the
///    local machine. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was passed to the function. This error is returned if a <b>NULL</b> parameter
///    is passed in the <i>Row</i> parameter. This error is also returned if the both the <b>InterfaceLuid</b> and
///    <b>InterfaceIndex</b> member of the MIB_IF_ROW2 pointed to by the <i>Row</i> parameter are unspecified. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use the FormatMessage
///    function to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS GetIfEntry2(MIB_IF_ROW2* Row);

///The <b>GetIfEntry2Ex</b> function retrieves the specified level of information for the specified interface on the
///local computer.
///Params:
///    Level = The level of interface information to retrieve. This parameter can be one of the values from the
///            <b>MIB_IF_ENTRY_LEVEL</b> enumeration type defined in the <i>Netioapi.h</i> header file. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MibIfEntryNormal"></a><a
///            id="mibifentrynormal"></a><a id="MIBIFENTRYNORMAL"></a><dl> <dt><b>MibIfEntryNormal</b></dt> <dt>0</dt> </dl>
///            </td> <td width="60%"> The values of statistics and state returned in members of the MIB_IF_ROW2 structure
///            pointed to by the <i>Row</i> parameter are returned from the top of the filter stack. </td> </tr> <tr> <td
///            width="40%"><a id="MibIfEntryNormalWithoutStatistics_"></a><a id="mibifentrynormalwithoutstatistics_"></a><a
///            id="MIBIFENTRYNORMALWITHOUTSTATISTICS_"></a><dl> <dt><b>MibIfEntryNormalWithoutStatistics </b></dt> <dt>2</dt>
///            </dl> </td> <td width="60%"> The values of state (without statistics) returned in members of the MIB_IF_ROW2
///            structure pointed to by the <i>Row</i> parameter are returned from the top of the filter stack. </td> </tr>
///            </table>
///    Row = A pointer to a MIB_IF_ROW2 structure that, on successful return, receives information for an interface on the
///          local computer. On input, the <b>InterfaceLuid</b> or the <b>InterfaceIndex</b> member of the <b>MIB_IF_ROW2</b>
///          must be set to the interface for which to retrieve information.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The system cannot find the file specified. This
///    error is returned if the network interface LUID or interface index specified by the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> member of the MIB_IF_ROW2 pointed to by the <i>Row</i> parameter was not a value on the
///    local machine. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was passed to the function. This error is returned if a <b>NULL</b> parameter
///    is passed in the <i>Row</i> parameter. This error is also returned if the both the <b>InterfaceLuid</b> and
///    <b>InterfaceIndex</b> member of the MIB_IF_ROW2 pointed to by the <i>Row</i> parameter are unspecified. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use the FormatMessage
///    function to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS GetIfEntry2Ex(MIB_IF_ENTRY_LEVEL Level, MIB_IF_ROW2* Row);

///The <b>GetIfTable2</b> function retrieves the MIB-II interface table.
///Params:
///    Table = A pointer to a buffer that receives the table of interfaces in a MIB_IF_TABLE2 structure.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory resources are available
///    to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td
///    width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS GetIfTable2(MIB_IF_TABLE2** Table);

///The <b>GetIfTable2Ex</b> function retrieves the MIB-II interface table.
///Params:
///    Level = The level of interface information to retrieve. This parameter can be one of the values from the
///            <b>MIB_IF_TABLE_LEVEL</b> enumeration type defined in the <i>Netioapi.h</i> header file. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MibIfTableNormal"></a><a
///            id="mibiftablenormal"></a><a id="MIBIFTABLENORMAL"></a><dl> <dt><b>MibIfTableNormal</b></dt> </dl> </td> <td
///            width="60%"> The values of statistics and state returned in members of the MIB_IF_ROW2 structure in the
///            MIB_IF_TABLE2 structure pointed to by the <i>Table</i> parameter are returned from the top of the filter stack
///            when this parameter is specified. </td> </tr> <tr> <td width="40%"><a id="MibIfTableRaw"></a><a
///            id="mibiftableraw"></a><a id="MIBIFTABLERAW"></a><dl> <dt><b>MibIfTableRaw</b></dt> </dl> </td> <td width="60%">
///            The values of statistics and state returned in members of the MIB_IF_ROW2 structure in the MIB_IF_TABLE2
///            structure pointed to by the <i>Table</i> parameter are returned directly for the interface being queried. </td>
///            </tr> </table>
///    Table = A pointer to a buffer that receives the table of interfaces in a MIB_IF_TABLE2 structure.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed to the
///    function. This error is returned if an illegal value was passed in the <i>Level</i> parameter. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory
///    resources are available to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt>
///    </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr>
///    </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS GetIfTable2Ex(MIB_IF_TABLE_LEVEL Level, MIB_IF_TABLE2** Table);

///The <b>GetIfStackTable</b> function retrieves a table of network interface stack row entries that specify the
///relationship of the network interfaces on an interface stack.
///Params:
///    Table = A pointer to a buffer that receives the table of interface stack row entries in a MIB_IFSTACK_TABLE structure.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed to the
///    function. This error is returned if a <b>NULL</b> pointer is passed in the <i>Table</i> parameter. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient
///    memory resources are available to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No interface stack entries were found. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use the FormatMessage function to
///    obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS GetIfStackTable(MIB_IFSTACK_TABLE** Table);

///The <b>GetInvertedIfStackTable</b> function retrieves a table of inverted network interface stack row entries that
///specify the relationship of the network interfaces on an interface stack.
///Params:
///    Table = A pointer to a buffer that receives the table of inverted interface stack row entries in a
///            MIB_INVERTEDIFSTACK_TABLE structure.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed to the
///    function. This error is returned if a <b>NULL</b> pointer is passed in the <i>Table</i> parameter. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient
///    memory resources are available to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No interface stack entries were found. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use the FormatMessage function to
///    obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS GetInvertedIfStackTable(MIB_INVERTEDIFSTACK_TABLE** Table);

///The <b>GetIpInterfaceEntry</b> function retrieves IP information for the specified interface on the local computer.
///Params:
///    Row = A pointer to a MIB_IPINTERFACE_ROW structure that, on successful return, receives information for an interface on
///          the local computer. On input, the <b>InterfaceLuid</b> or <b>InterfaceIndex</b> member of the
///          <b>MIB_IPINTERFACE_ROW</b> must be set to the interface for which to retrieve information.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The system cannot find the file specified. This
///    error is returned if the network interface LUID or interface index specified by the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> member of the MIB_IPINTERFACE_ROW pointed to by the <i>Row</i> parameter was not a value on
///    the local machine. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was passed to the function. This error is returned if a <b>NULL</b> pointer is
///    passed in the <i>Row</i> parameter, the <b>Family</b> member of the MIB_IPINTERFACE_ROW pointed to by the
///    <i>Row</i> parameter was not specified as <b>AF_INET</b> or <b>AF_INET6</b>, or both the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> members of the <b>MIB_IPINTERFACE_ROW</b> pointed to by the <i>Row</i> parameter were
///    unspecified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%">
///    Element not found. This error is returned if the network interface specified by the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> member of the MIB_IPINTERFACE_ROW structure pointed to by the <i>Row</i> parameter does not
///    match the IP address family specified in the <b>Family</b> member in the <b>MIB_IPINTERFACE_ROW</b> structure.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use the FormatMessage
///    function to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS GetIpInterfaceEntry(MIB_IPINTERFACE_ROW* Row);

///The <b>GetIpInterfaceTable</b> function retrieves the IP interface entries on the local computer.
///Params:
///    Family = The address family of IP interfaces to retrieve. Possible values for the address family are listed in the
///             <i>Winsock2.h</i> header file. Note that the values for the AF_ address family and PF_ protocol family constants
///             are identical (for example, <b>AF_INET</b> and <b>PF_INET</b>), so either constant can be used. On Windows Vista
///             and later as well as on the Windows SDK, the organization of header files has changed and possible values for
///             this member are defined in the <i>Ws2def.h</i> header file. Note that the <i>Ws2def.h</i> header file is
///             automatically included in <i>Winsock2.h</i>, and should never be used directly. The values currently supported
///             are <b>AF_INET</b>, <b>AF_INET6</b>, and <b>AF_UNSPEC</b>. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///             <tr> <td width="40%"><a id="AF_UNSPEC"></a><a id="af_unspec"></a><dl> <dt><b>AF_UNSPEC</b></dt> <dt>0</dt> </dl>
///             </td> <td width="60%"> The address family is unspecified. When this parameter is specified, the
///             <b>GetIpInterfaceTable</b> function returns the IP interface table containing both IPv4 and IPv6 entries. </td>
///             </tr> <tr> <td width="40%"><a id="AF_INET"></a><a id="af_inet"></a><dl> <dt><b>AF_INET</b></dt> <dt>2</dt> </dl>
///             </td> <td width="60%"> The Internet Protocol version 4 (IPv4) address family. </td> </tr> <tr> <td width="40%"><a
///             id="AF_INET6"></a><a id="af_inet6"></a><dl> <dt><b>AF_INET6</b></dt> <dt>23</dt> </dl> </td> <td width="60%"> The
///             Internet Protocol version 6 (IPv6) address family. </td> </tr> </table>
///    Table = A pointer to a buffer that receives the table of IP interface entries in a MIB_IPINTERFACE_TABLE structure.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed to the
///    function. This error is returned if a <b>NULL</b> pointer is passed in the <i>Table</i> parameter or the
///    <i>Family</i> parameter was not specified as <b>AF_INET</b>, <b>AF_INET6</b>, or <b>AF_UNSPEC</b>. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient
///    memory resources are available to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No IP interface entries as specified in the
///    <i>Family</i> parameter were found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt>
///    </dl> </td> <td width="60%"> The function is not supported. This error is returned when the IP transport
///    specified in the <i>Address</i> parameter is not configured on the local computer. This error is also returned on
///    versions of Windows where this function is not supported. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use the FormatMessage function to obtain the message string
///    for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS GetIpInterfaceTable(ushort Family, MIB_IPINTERFACE_TABLE** Table);

///The <b>InitializeIpInterfaceEntry</b> function initializes the members of an <b>MIB_IPINTERFACE_ROW</b> entry with
///default values.
///Params:
///    Row = A pointer to a <b>MIB_IPINTERFACE_ROW</b> structure to initialize. On successful return, the fields in this
///          parameter are initialized with default information for an interface on the local computer.
///Returns:
///    This function does not return a value.
///    
@DllImport("IPHLPAPI")
void InitializeIpInterfaceEntry(MIB_IPINTERFACE_ROW* Row);

///The <b>NotifyIpInterfaceChange</b> function registers to be notified for changes to all IP interfaces, IPv4
///interfaces, or IPv6 interfaces on a local computer.
///Params:
///    Family = The address family on which to register for change notifications. Possible values for the address family are
///             listed in the <i>Winsock2.h</i> header file. Note that the values for the AF_ address family and PF_ protocol
///             family constants are identical (for example, <b>AF_INET</b> and <b>PF_INET</b>), so either constant can be used.
///             On the Windows SDK released for Windows Vista and later, the organization of header files has changed and
///             possible values for this member are defined in the <i>Ws2def.h</i> header file. Note that the <i>Ws2def.h</i>
///             header file is automatically included in <i>Winsock2.h</i>, and should never be used directly. The values
///             currently supported are <b>AF_INET</b>, <b>AF_INET6</b>, and <b>AF_UNSPEC</b>. <table> <tr> <th>Value</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="AF_UNSPEC"></a><a id="af_unspec"></a><dl>
///             <dt><b>AF_UNSPEC</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The address family is unspecified. When this
///             parameter is specified, this function registers for both IPv4 and IPv6 change notifications. </td> </tr> <tr> <td
///             width="40%"><a id="AF_INET"></a><a id="af_inet"></a><dl> <dt><b>AF_INET</b></dt> <dt>2</dt> </dl> </td> <td
///             width="60%"> The Internet Protocol version 4 (IPv4) address family. When this parameter is specified, this
///             function register for only IPv4 change notifications. </td> </tr> <tr> <td width="40%"><a id="AF_INET6"></a><a
///             id="af_inet6"></a><dl> <dt><b>AF_INET6</b></dt> <dt>23</dt> </dl> </td> <td width="60%"> The Internet Protocol
///             version 6 (IPv6) address family. When this parameter is specified, this function registers for only IPv6 change
///             notifications. </td> </tr> </table>
///    Callback = A pointer to the function to call when a change occurs. This function will be invoked when an interface
///               notification is received.
///    CallerContext = A user context passed to the callback function specified in the <i>Callback</i> parameter when an interface
///                    notification is received.
///    InitialNotification = A value that indicates whether the callback should be invoked immediately after registration for change
///                          notification completes. This initial notification does not indicate a change occurred to an IP interface. The
///                          purpose of this parameter to provide confirmation that the callback is registered.
///    NotificationHandle = A pointer used to return a handle that can be later used to deregister the change notification. On success, a
///                         notification handle is returned in this parameter. If an error occurs, <b>NULL</b> is returned.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> An internal error occurred where an invalid
///    handle was encountered. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> An invalid parameter was passed to the function. This error is returned if the
///    <i>Family</i> parameter was not either <b>AF_INET</b>, <b>AF_INET6</b>, or <b>AF_UNSPEC</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There was insufficient
///    memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use
///    FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS NotifyIpInterfaceChange(ushort Family, PIPINTERFACE_CHANGE_CALLBACK Callback, void* CallerContext, 
                                 ubyte InitialNotification, HANDLE* NotificationHandle);

///The <b>SetIpInterfaceEntry</b> function sets the properties of an IP interface on the local computer.
///Params:
///    Row = A pointer to a MIB_IPINTERFACE_ROW structure entry for an interface. On input, the <b>Family</b> member of the
///          <b>MIB_IPINTERFACE_ROW</b> must be set to <b>AF_INET6</b> or <b>AF_INET</b> and the <b>InterfaceLuid</b> or the
///          <b>InterfaceIndex</b> member of the <b>MIB_IPINTERFACE_ROW</b> must be specified. On a successful return, the
///          <b>InterfaceLuid</b> member of the <b>MIB_IPINTERFACE_ROW</b> is filled in if <b>InterfaceIndex</b> member of the
///          <b>MIB_IPINTERFACE_ROW</b> entry was specified.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error is returned under
///    several conditions that include the following: the user lacks the required administrative privileges on the local
///    computer or the application is not running in an enhanced shell as the built-in Administrator (RunAs
///    administrator). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td
///    width="60%"> The system cannot find the file specified. This error is returned if the network interface LUID or
///    interface index specified by the <b>InterfaceLuid</b> or <b>InterfaceIndex</b> member of the MIB_IPINTERFACE_ROW
///    pointed to by the <i>Row</i> parameter was not a value on the local machine. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed to the
///    function. This error is returned if a <b>NULL</b> pointer is passed in the <i>Row</i> parameter, the
///    <b>Family</b> member of the MIB_IPINTERFACE_ROW pointed to by the <i>Row</i> parameter was not specified as
///    <b>AF_INET</b> or <b>AF_INET6</b>, or both the <b>InterfaceLuid</b> or <b>InterfaceIndex</b> members of the
///    <b>MIB_IPINTERFACE_ROW</b> pointed to by the <i>Row</i> parameter were unspecified. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified interface could not
///    be found. This error is returned if the network interface specified by the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> member of the MIB_IPINTERFACE_ROW pointed to by the <i>Row</i> parameter does not match the
///    IP address family specified in the <b>Family</b> member in the <b>MIB_IPINTERFACE_ROW</b> structure. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the
///    message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS SetIpInterfaceEntry(MIB_IPINTERFACE_ROW* Row);

///The <b>GetIpNetworkConnectionBandwidthEstimates</b> function retrieves historical bandwidth estimates for a network
///connection on the specified interface.
///Params:
///    InterfaceIndex = The local index value for the network interface. This index value may change when a network adapter is disabled
///                     and then enabled, or under other circumstances, and should not be considered persistent.
///    AddressFamily = The address family. Possible values for the address family are listed in the <i>Ws2def.h</i> header file. Note
///                    that the values for the AF_ address family and PF_ protocol family constants are identical (for example,
///                    <b>AF_INET</b> and <b>PF_INET</b>), so either constant can be used. Note that the <i>Ws2def.h</i> header file is
///                    automatically included in <i>Winsock2.h</i>, and should never be used directly. The values currently supported
///                    are <b>AF_INET</b> or <b>AF_INET6</b>, which are the Internet address family formats for IPv4 and IPv6. <table>
///                    <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="AF_INET"></a><a id="af_inet"></a><dl>
///                    <dt><b>AF_INET</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The Internet Protocol version 4 (IPv4) address
///                    family. </td> </tr> <tr> <td width="40%"><a id="AF_INET6"></a><a id="af_inet6"></a><dl> <dt><b>AF_INET6</b></dt>
///                    <dt>23</dt> </dl> </td> <td width="60%"> The Internet Protocol version 6 (IPv6) address family. </td> </tr>
///                    </table>
///    BandwidthEstimates = A pointer to a buffer that returns the historical bandwidth estimates maintained for the point of attachment to
///                         which the interface is currently connected.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The system cannot find the file specified. This
///    error is returned if the interface index specified by the <i>InterfaceIndex</i> parameter was not a value on the
///    local machine. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was passed to the function. This error is returned if a <b>NULL</b> pointer is
///    passed in the <i>BandwidthEstimates</i> parameter or the <i>AddressFamily</i> parameter was not specified as
///    <b>AF_INET</b> or <b>AF_INET6</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl>
///    </td> <td width="60%"> Element not found. This error is returned if the network interface specified by the
///    <i>InterfaceIndex</i> parameter does not match the IP address family specified in the <i>AddressFamily</i>
///    parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use the
///    FormatMessage function to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS GetIpNetworkConnectionBandwidthEstimates(uint InterfaceIndex, ushort AddressFamily, 
                                                  MIB_IP_NETWORK_CONNECTION_BANDWIDTH_ESTIMATES* BandwidthEstimates);

///The <b>CreateUnicastIpAddressEntry</b> function adds a new unicast IP address entry on the local computer.
///Params:
///    Row = A pointer to a MIB_UNICASTIPADDRESS_ROW structure entry for a unicast IP address entry.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error is returned under
///    several conditions that include the following: the user lacks the required administrative privileges on the local
///    computer or the application is not running in an enhanced shell as the built-in Administrator (RunAs
///    administrator). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was passed to the function. This error is returned if a <b>NULL</b> pointer is
///    passed in the <i>Row</i> parameter, the <b>Address</b> member of the MIB_UNICASTIPADDRESS_ROW pointed to by the
///    <i>Row</i> parameter was not set to a valid unicast IPv4 or IPv6 address, or both the <b>InterfaceLuid</b> and
///    <b>InterfaceIndex</b> members of the <b>MIB_UNICASTIPADDRESS_ROW</b> pointed to by the <i>Row</i> parameter were
///    unspecified. This error is also returned for other errors in the values set for members in the
///    MIB_UNICASTIPADDRESS_ROW structure. These errors include the following: if the <b>ValidLifetime</b> member is
///    less than than the <b>PreferredLifetime</b> member, if the <b>PrefixOrigin</b> member is set to
///    <b>IpPrefixOriginUnchanged</b> and the <b>SuffixOrigin</b> is the not set to <b>IpSuffixOriginUnchanged</b>, if
///    the <b>PrefixOrigin</b> member is not set to <b>IpPrefixOriginUnchanged</b> and the <b>SuffixOrigin</b> is set to
///    <b>IpSuffixOriginUnchanged</b>, if the <b>PrefixOrigin</b> member is not set to a value from the
///    <b>NL_PREFIX_ORIGIN</b> enumeration, if the <b>SuffixOrigin</b> member is not set to a value from the
///    <b>NL_SUFFIX_ORIGIN</b> enumeration, or if the <b>OnLinkPrefixLength</b> member is set to a value greater than
///    the IP address length, in bits (32 for a unicast IPv4 address or 128 for a unicast IPv6 address). </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified interface
///    could not be found. This error is returned if the network interface specified by the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> member of the MIB_UNICASTIPADDRESS_ROW pointed to by the <i>Row</i> parameter could not be
///    found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%">
///    The request is not supported. This error is returned if no IPv4 stack is on the local computer and an IPv4
///    address was specified in the <b>Address</b> member of the MIB_UNICASTIPADDRESS_ROW pointed to by the <i>Row</i>
///    parameter. This error is also returned if no IPv6 stack is on the local computer and an IPv6 address was
///    specified in the <b>Address</b> member. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_OBJECT_ALREADY_EXISTS
///    </b></dt> </dl> </td> <td width="60%"> The object already exists. This error is returned if the <b>Address</b>
///    member of the MIB_UNICASTIPADDRESS_ROW pointed to by the <i>Row</i> parameter is a duplicate of an existing
///    unicast IP address on the interface specified by the <b>InterfaceLuid</b> or <b>InterfaceIndex</b> member of the
///    <b>MIB_UNICASTIPADDRESS_ROW</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td
///    width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS CreateUnicastIpAddressEntry(const(MIB_UNICASTIPADDRESS_ROW)* Row);

///The <b>DeleteUnicastIpAddressEntry</b> function deletes an existing unicast IP address entry on the local computer.
///Params:
///    Row = A pointer to a MIB_UNICASTIPADDRESS_ROW structure entry for an existing unicast IP address entry to delete from
///          the local computer.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error is returned under
///    several conditions that include the following: the user lacks the required administrative privileges on the local
///    computer or the application is not running in an enhanced shell as the built-in Administrator (RunAs
///    administrator). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was passed to the function. This error is returned if a <b>NULL</b> pointer is
///    passed in the <i>Row</i> parameter, the <b>Address</b> member of the MIB_UNICASTIPADDRESS_ROW pointed to by the
///    <i>Row</i> parameter was not set to a valid unicast IPv4 or IPv6 address, or both the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> members of the <b>MIB_UNICASTIPADDRESS_ROW</b> pointed to by the <i>Row</i> parameter were
///    unspecified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%">
///    The specified interface could not be found. This error is returned if the network interface specified by the
///    <b>InterfaceLuid</b> or <b>InterfaceIndex</b> member of the MIB_UNICASTIPADDRESS_ROW pointed to by the <i>Row</i>
///    parameter could not be found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl>
///    </td> <td width="60%"> The request is not supported. This error is returned if no IPv4 stack is on the local
///    computer and an IPv4 address was specified in the <b>Address</b> member MIB_UNICASTIPADDRESS_ROW pointed to by
///    the <i>Row</i> parameter. This error is also returned if no IPv6 stack is on the local computer and an IPv6
///    address was specified in the <b>Address</b> member. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt>
///    </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr>
///    </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS DeleteUnicastIpAddressEntry(const(MIB_UNICASTIPADDRESS_ROW)* Row);

///The <b>GetUnicastIpAddressEntry</b> function retrieves information for an existing unicast IP address entry on the
///local computer.
///Params:
///    Row = A pointer to a MIB_UNICASTIPADDRESS_ROW structure entry for a unicast IP address entry. On successful return,
///          this structure will be updated with the properties for an existing unicast IP address.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The system cannot find the file specified. This
///    error is returned if the network interface LUID or interface index specified by the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> member of the MIB_UNICASTIPADDRESS_ROW pointed to by the <i>Row</i> parameter is not a
///    value on the local machine. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> A parameter is incorrect. This error is returned if a <b>NULL</b> pointer is passed in the
///    <i>Row</i> parameter, the <b>Address</b> member of the MIB_UNICASTIPADDRESS_ROW pointed to by the <i>Row</i>
///    parameter is not set to a valid unicast IPv4 or IPv6 address, or both the <b>InterfaceLuid</b> and
///    <b>InterfaceIndex</b> members of the <b>MIB_UNICASTIPADDRESS_ROW</b> pointed to by the <i>Row</i> parameter are
///    unspecified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%">
///    Element not found. This error is returned if the network interface specified by the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> member of the MIB_UNICASTIPADDRESS_ROW structure pointed to by the <i>Row</i> parameter
///    does not match the IP address specified in the <b>Address</b> member in the <b>MIB_UNICASTIPADDRESS_ROW</b>
///    structure. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td
///    width="60%"> The request is not supported. This error is returned if no IPv4 stack is on the local computer and
///    an IPv4 address is specified in the <b>Address</b> member of the MIB_UNICASTIPADDRESS_ROW structure pointed to by
///    the <i>Row</i> parameter. This error is also returned if no IPv6 stack is on the local computer and an IPv6
///    address is specified in the <b>Address</b> member. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt>
///    </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr>
///    </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS GetUnicastIpAddressEntry(MIB_UNICASTIPADDRESS_ROW* Row);

///The <b>GetUnicastIpAddressTable</b> function retrieves the unicast IP address table on the local computer.
///Params:
///    Family = The address family to retrieve. Possible values for the address family are listed in the <i>Winsock2.h</i> header
///             file. Note that the values for the AF_ address family and PF_ protocol family constants are identical (for
///             example, <b>AF_INET</b> and <b>PF_INET</b>), so either constant can be used. On the Windows SDK released for
///             Windows Vista and later, the organization of header files has changed and possible values for this member are
///             defined in the <i>Ws2def.h</i> header file. Note that the <i>Ws2def.h</i> header file is automatically included
///             in <i>Winsock2.h</i>, and should never be used directly. The values currently supported are <b>AF_INET</b>,
///             <b>AF_INET6</b>, and <b>AF_UNSPEC</b>. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="AF_UNSPEC"></a><a id="af_unspec"></a><dl> <dt><b>AF_UNSPEC</b></dt> <dt>0</dt> </dl> </td> <td width="60%">
///             The address family is unspecified. When this parameter is specified, this function returns the unicast IP address
///             table containing both IPv4 and IPv6 entries. </td> </tr> <tr> <td width="40%"><a id="AF_INET"></a><a
///             id="af_inet"></a><dl> <dt><b>AF_INET</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The Internet Protocol
///             version 4 (IPv4) address family. When this parameter is specified, this function returns the unicast IP address
///             table containing only IPv4 entries. </td> </tr> <tr> <td width="40%"><a id="AF_INET6"></a><a
///             id="af_inet6"></a><dl> <dt><b>AF_INET6</b></dt> <dt>23</dt> </dl> </td> <td width="60%"> The Internet Protocol
///             version 6 (IPv6) address family. When this parameter is specified, this function returns the unicast IP address
///             table containing only IPv6 entries. </td> </tr> </table>
///    Table = A pointer to a MIB_UNICASTIPADDRESS_TABLE structure that contains a table of unicast IP address entries on the
///            local computer.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed to the
///    function. This error is returned if a <b>NULL</b> pointer is passed in the <i>Table</i> parameter or the
///    <i>Family</i> parameter was not specified as <b>AF_INET</b>, <b>AF_INET6</b>, or <b>AF_UNSPEC</b>. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient
///    memory resources are available to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> Element not found. This error is returned if no
///    unicast IP address entries as specified in the <i>Family</i> parameter were found. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not supported.
///    This error is returned if no IPv4 stack is on the local computer and <b>AF_INET</b> was specified in the
///    <b>Family</b> parameter. This error is also returned if no IPv6 stack is on the local computer and
///    <b>AF_INET6</b> was specified in the <b>Family</b> parameter. This error is also returned on versions of Windows
///    where this function is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td>
///    <td width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS GetUnicastIpAddressTable(ushort Family, MIB_UNICASTIPADDRESS_TABLE** Table);

///The <b>InitializeUnicastIpAddressEntry</b> function initializes a <b>MIB_UNICASTIPADDRESS_ROW</b> structure with
///default values for a unicast IP address entry on the local computer.
///Params:
///    Row = On entry, a pointer to a MIB_UNICASTIPADDRESS_ROW structure entry for a unicast IP address entry. On return, the
///          <b>MIB_UNICASTIPADDRESS_ROW</b> structure pointed to by this parameter is initialized with default values for a
///          unicast IP address.
///Returns:
///    This function does not return a value.
///    
@DllImport("IPHLPAPI")
void InitializeUnicastIpAddressEntry(MIB_UNICASTIPADDRESS_ROW* Row);

///The <b>NotifyUnicastIpAddressChange</b> function registers to be notified for changes to all unicast IP interfaces,
///unicast IPv4 addresses, or unicast IPv6 addresses on a local computer.
///Params:
///    Family = The address family on which to register for change notifications. Possible values for the address family are
///             listed in the <i>Winsock2.h</i> header file. Note that the values for the AF_ address family and PF_ protocol
///             family constants are identical (for example, <b>AF_INET</b> and <b>PF_INET</b>), so either constant can be used.
///             On the Windows SDK released for Windows Vista and later, the organization of header files has changed and
///             possible values for this member are defined in the <i>Ws2def.h</i> header file. Note that the <i>Ws2def.h</i>
///             header file is automatically included in <i>Winsock2.h</i>, and should never be used directly. The values
///             currently supported are <b>AF_INET</b>, <b>AF_INET6</b>, and <b>AF_UNSPEC</b>. <table> <tr> <th>Value</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="AF_INET"></a><a id="af_inet"></a><dl> <dt><b>AF_INET</b></dt>
///             </dl> </td> <td width="60%"> Register for only unicast IPv4 address change notifications. </td> </tr> <tr> <td
///             width="40%"><a id="AF_INET6"></a><a id="af_inet6"></a><dl> <dt><b>AF_INET6</b></dt> </dl> </td> <td width="60%">
///             Register for only unicast IPv6 address change notifications. </td> </tr> <tr> <td width="40%"><a
///             id="AF_UNSPEC"></a><a id="af_unspec"></a><dl> <dt><b>AF_UNSPEC</b></dt> </dl> </td> <td width="60%"> Register for
///             both unicast IPv4 and IPv6 address change notifications. </td> </tr> </table>
///    Callback = A pointer to the function to call when a change occurs. This function will be invoked when a unicast IP address
///               notification is received.
///    CallerContext = A user context passed to the callback function specified in the <i>Callback</i> parameter when an interface
///                    notification is received.
///    InitialNotification = A value that indicates whether the callback should be invoked immediately after registration for change
///                          notification completes. This initial notification does not indicate a change occurred to a unicast IP address.
///                          The purpose of this parameter to provide confirmation that the callback is registered.
///    NotificationHandle = A pointer used to return a handle that can be later used to deregister the change notification. On success, a
///                         notification handle is returned in this parameter. If an error occurs, <b>NULL</b> is returned.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> An internal error occurred where an invalid
///    handle was encountered. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> An invalid parameter was passed to the function. This error is returned if the
///    <i>Family</i> parameter was not either <b>AF_INET</b>, <b>AF_INET6</b>, or <b>AF_UNSPEC</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There was insufficient
///    memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use
///    FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS NotifyUnicastIpAddressChange(ushort Family, PUNICAST_IPADDRESS_CHANGE_CALLBACK Callback, 
                                      void* CallerContext, ubyte InitialNotification, HANDLE* NotificationHandle);

///The <b>NotifyStableUnicastIpAddressTable</b> function retrieves the stable unicast IP address table on a local
///computer.
///Params:
///    Family = The address family to retrieve. Possible values for the address family are listed in the <i>Winsock2.h</i> header
///             file. Note that the values for the AF_ address family and PF_ protocol family constants are identical (for
///             example, <b>AF_INET</b> and <b>PF_INET</b>), so either constant can be used. On the Windows SDK released for
///             Windows Vista and later, the organization of header files has changed and possible values for this member are
///             defined in the <i>Ws2def.h</i> header file. Note that the <i>Ws2def.h</i> header file is automatically included
///             in <i>Winsock2.h</i>, and should never be used directly. The values currently supported are <b>AF_INET</b>,
///             <b>AF_INET6</b>, and <b>AF_UNSPEC</b>. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="AF_UNSPEC"></a><a id="af_unspec"></a><dl> <dt><b>AF_UNSPEC</b></dt> <dt>0</dt> </dl> </td> <td width="60%">
///             The address family is unspecified. When this parameter is specified, the function retrieves the stable unicast IP
///             address table containing both IPv4 and IPv6 entries. </td> </tr> <tr> <td width="40%"><a id="AF_INET"></a><a
///             id="af_inet"></a><dl> <dt><b>AF_INET</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The Internet Protocol
///             version 4 (IPv4) address family. When this parameter is specified, the function retrieves the stable unicast IP
///             address table containing only IPv4 entries. </td> </tr> <tr> <td width="40%"><a id="AF_INET6"></a><a
///             id="af_inet6"></a><dl> <dt><b>AF_INET6</b></dt> <dt>23</dt> </dl> </td> <td width="60%"> The Internet Protocol
///             version 6 (IPv6) address family. When this parameter is specified, the function retrieves the stable unicast IP
///             address table containing only IPv6 entries. </td> </tr> </table>
///    Table = A pointer to a MIB_UNICASTIPADDRESS_TABLE structure. When <b>NotifyStableUnicastIpAddressTable</b> is successful,
///            this parameter returns the stable unicast IP address table on the local computer. When
///            <b>NotifyStableUnicastIpAddressTable</b> returns <b>ERROR_IO_PENDING</b> indicating that the I/O request is
///            pending, then the stable unicast IP address table is returned to the function in the <i>CallerCallback</i>
///            parameter.
///    CallerCallback = A pointer to the function to call with the stable unicast IP address table. This function will be invoked if
///                     <b>NotifyStableUnicastIpAddressTable</b> returns <b>ERROR_IO_PENDING</b>, indicating that the I/O request is
///                     pending.
///    CallerContext = A user context passed to the callback function specified in the <i>CallerCallback</i> parameter when the stable
///                    unicast IP address table si available.
///    NotificationHandle = A pointer used to return a handle that can be used to cancel the request to retrieve the stable unicast IP
///                         address table. This parameter is returned if the return value from <b>NotifyStableUnicastIpAddressTable</b> is
///                         <b>ERROR_IO_PENDING</b> indicating that the I/O request is pending.
///Returns:
///    If the function succeeds immediately, the return value is NO_ERROR and the stable unicast IP table is returned in
///    the <i>Table</i> parameter. If the I/O request is pending, the function returns <b>ERROR_IO_PENDING</b> and the
///    function pointed to by the <i>CallerCallback</i> parameter is called when the I/O request has completed with the
///    stable unicast IP address table. If the function fails, the return value is one of the following error codes.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> An internal error occurred where an invalid
///    handle was encountered. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> An invalid parameter was passed to the function. This error is returned if the
///    <i>Table</i> parameter was a <b>NULL</b> pointer, the <i>NotificationHandle</i> parameter was a <b>NULL</b>
///    pointer, or the <i>Family</i> parameter was not either <b>AF_INET</b>, <b>AF_INET6</b>, or <b>AF_UNSPEC</b>.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY </b></dt> </dl> </td> <td width="60%">
///    There was insufficient memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td
///    width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS NotifyStableUnicastIpAddressTable(ushort Family, MIB_UNICASTIPADDRESS_TABLE** Table, 
                                           PSTABLE_UNICAST_IPADDRESS_TABLE_CALLBACK CallerCallback, 
                                           void* CallerContext, HANDLE* NotificationHandle);

///The SetUnicastIpAddressEntry function sets the properties of an existing unicast IP address entry on the local
///computer.
///Params:
///    Row = A pointer to a MIB_UNICASTIPADDRESS_ROW structure entry for an existing unicast IP address entry.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error is returned under
///    several conditions that include the following: the user lacks the required administrative privileges on the local
///    computer or the application is not running in an enhanced shell as the built-in Administrator (RunAs
///    administrator). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was passed to the function. This error is returned if a <b>NULL</b> pointer is
///    passed in the <i>Row</i> parameter, the <b>Address</b> member of the MIB_UNICASTIPADDRESS_ROW pointed to by the
///    <i>Row</i> parameter was not set to a valid unicast IPv4 or IPv6 address, or both the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> members of the <b>MIB_UNICASTIPADDRESS_ROW</b> pointed to by the <i>Row</i> parameter were
///    unspecified. This error is also returned for other errors in the values set for members in the
///    MIB_UNICASTIPADDRESS_ROW structure. These errors include the following: if the <b>ValidLifetime</b> member is
///    less than than the <b>PreferredLifetime</b> member, if the <b>PrefixOrigin</b> member is set to
///    <b>IpPrefixOriginUnchanged</b> and the <b>SuffixOrigin</b> is the not set to <b>IpSuffixOriginUnchanged</b>, if
///    the <b>PrefixOrigin</b> member is not set to <b>IpPrefixOriginUnchanged</b> and the <b>SuffixOrigin</b> is set to
///    <b>IpSuffixOriginUnchanged</b>, if the <b>PrefixOrigin</b> member is not set to a value from the
///    <b>NL_PREFIX_ORIGIN</b> enumeration, if the <b>SuffixOrigin</b> member is not set to a value from the
///    <b>NL_SUFFIX_ORIGIN</b> enumeration, or if the <b>OnLinkPrefixLength</b> member is set to a value greater than
///    the IP address length, in bits (32 for an unicast IPv4 address or 128 for an unicast IPv6 address). </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified interface
///    could not be found. This error is returned if the network interface specified by the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> member of the MIB_UNICASTIPADDRESS_ROW pointed to by the <i>Row</i> parameter could not be
///    found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%">
///    The request is not supported. This error is returned if no IPv4 stack is on the local computer and an IPv4
///    address was specified in the <b>Address</b> member MIB_UNICASTIPADDRESS_ROW pointed to by the <i>Row</i>
///    parameter or no IPv6 stack is on the local computer and an IPv6 address was specified in the <b>Address</b>
///    member. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use
///    FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS SetUnicastIpAddressEntry(const(MIB_UNICASTIPADDRESS_ROW)* Row);

///The <b>CreateAnycastIpAddressEntry</b> function adds a new anycast IP address entry on the local computer.
///Params:
///    Row = A pointer to a MIB_ANYCASTIPADDRESS_ROW structure entry for an anycast IP address entry.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error is returned under
///    several conditions that include the following: the user lacks the required administrative privileges on the local
///    computer or the application is not running in an enhanced shell as the built-in Administrator (RunAs
///    administrator). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was passed to the function. This error is returned if a <b>NULL</b> pointer is
///    passed in the <i>Row</i> parameter, the <b>Address</b> member of the MIB_ANYCASTIPADDRESS_ROW pointed to by the
///    <i>Row</i> parameter was not set to a valid unicast IPv4 or IPv6 address, or both the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> members of the <b>MIB_ANYCASTIPADDRESS_ROW</b> pointed to by the <i>Row</i> parameter were
///    unspecified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%">
///    The specified interface could not be found. This error is returned if the network interface specified by the
///    <b>InterfaceLuid</b> or <b>InterfaceIndex</b> member of the MIB_ANYCASTIPADDRESS_ROW pointed to by the <i>Row</i>
///    parameter could not be found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl>
///    </td> <td width="60%"> The request is not supported. This error is returned if no IPv4 stack is on the local
///    computer and an IPv4 address was specified in the <b>Address</b> member of the MIB_ANYCASTIPADDRESS_ROW pointed
///    to by the <i>Row</i> parameter. This error is also returned if no IPv6 stack is on the local computer and an IPv6
///    address was specified in the <b>Address</b> member. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_OBJECT_ALREADY_EXISTS </b></dt> </dl> </td> <td width="60%"> The object already exists. This error
///    is returned if the <b>Address</b> member of the MIB_ANYCASTIPADDRESS_ROW pointed to by the <i>Row</i> parameter
///    is a duplicate of an existing anycast IP address on the interface specified by the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> member of the <b>MIB_ANYCASTIPADDRESS_ROW</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the
///    returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS CreateAnycastIpAddressEntry(const(MIB_ANYCASTIPADDRESS_ROW)* Row);

///The <b>DeleteAnycastIpAddressEntry</b> function deletes an existing anycast IP address entry on the local computer.
///Params:
///    Row = A pointer to a MIB_ANYCASTIPADDRESS_ROW structure entry for an existing anycast IP address entry to delete from
///          the local computer.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error is returned under
///    several conditions that include the following: the user lacks the required administrative privileges on the local
///    computer or the application is not running in an enhanced shell as the built-in Administrator (RunAs
///    administrator). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was passed to the function. This error is returned if a <b>NULL</b> pointer is
///    passed in the <i>Row</i> parameter, the <b>Address</b> member of the MIB_ANYCASTIPADDRESS_ROW pointed to by the
///    <i>Row</i> parameter was not set to a valid unicast IPv4 or IPv6 address, or both the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> members of the <b>MIB_ANYCASTIPADDRESS_ROW</b> pointed to by the <i>Row</i> parameter were
///    unspecified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%">
///    The specified interface could not be found. This error is returned if the network interface specified by the
///    <b>InterfaceLuid</b> or <b>InterfaceIndex</b> member of the MIB_ANYCASTIPADDRESS_ROW pointed to by the <i>Row</i>
///    parameter could not be found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl>
///    </td> <td width="60%"> The request is not supported. This error is returned if no IPv4 stack is on the local
///    computer and an IPv4 address was specified in the <b>Address</b> member MIB_ANYCASTIPADDRESS_ROW pointed to by
///    the <i>Row</i> parameter. This error is also returned if no IPv6 stack is on the local computer and an IPv6
///    address was specified in the <b>Address</b> member . </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt>
///    </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr>
///    </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS DeleteAnycastIpAddressEntry(const(MIB_ANYCASTIPADDRESS_ROW)* Row);

///The <b>GetAnycastIpAddressEntry</b> function retrieves information for an existing anycast IP address entry on the
///local computer.
///Params:
///    Row = A pointer to a MIB_ANYCASTIPADDRESS_ROW structure entry for an anycast IP address entry. On successful return,
///          this structure will be updated with the properties for an existing anycast IP address.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The system cannot find the file specified. This
///    error is returned if the network interface LUID or interface index specified by the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> member of the MIB_ANYCASTIPADDRESS_ROW pointed to by the <i>Row</i> parameter is not a
///    value on the local machine. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> A parameter is incorrect. This error is returned if a <b>NULL</b> pointer is passed in the
///    <i>Row</i> parameter, the <b>Address</b> member of the MIB_ANYCASTIPADDRESS_ROW pointed to by the <i>Row</i>
///    parameter is not set to a valid anycast IPv4 or IPv6 address, or both the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> members of the <b>MIB_ANYCASTIPADDRESS_ROW</b> pointed to by the <i>Row</i> parameter were
///    unspecified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%">
///    Element not found. This error is returned if the network interface specified by the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> member of the MIB_ANYCASTIPADDRESS_ROW structure pointed to by the <i>Row</i> parameter
///    does not match the IP address and address family specified in the <b>Address</b> member in the
///    <b>MIB_ANYCASTIPADDRESS_ROW</b> structure. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not supported. This error is
///    returned if no IPv4 stack is on the local computer and an IPv4 address is specified in the <b>Address</b> member
///    of the MIB_UNICASTIPADDRESS_ROW structure pointed to by the <i>Row</i> parameter. This error is returned if no
///    IPv6 stack is on the local computer and an IPv6 address is specified in the <b>Address</b> member. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the
///    message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS GetAnycastIpAddressEntry(MIB_ANYCASTIPADDRESS_ROW* Row);

///The <b>GetAnycastIpAddressTable</b> function retrieves the anycast IP address table on the local computer.
///Params:
///    Family = The address family to retrieve. Possible values for the address family are listed in the <i>Winsock2.h</i> header
///             file. Note that the values for the AF_ address family and PF_ protocol family constants are identical (for
///             example, <b>AF_INET</b> and <b>PF_INET</b>), so either constant can be used. On the Windows SDK released for
///             Windows Vista and later, the organization of header files has changed and possible values for this member are
///             defined in the <i>Ws2def.h</i> header file. Note that the <i>Ws2def.h</i> header file is automatically included
///             in <i>Winsock2.h</i>, and should never be used directly. The values currently supported are <b>AF_INET</b>,
///             <b>AF_INET6</b>, and <b>AF_UNSPEC</b>. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="AF_UNSPEC"></a><a id="af_unspec"></a><dl> <dt><b>AF_UNSPEC</b></dt> <dt>0</dt> </dl> </td> <td width="60%">
///             The address family is unspecified. When this parameter is specified, this function returns the anycast IP address
///             table containing both IPv4 and IPv6 entries. </td> </tr> <tr> <td width="40%"><a id="AF_INET"></a><a
///             id="af_inet"></a><dl> <dt><b>AF_INET</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The Internet Protocol
///             version 4 (IPv4) address family. When this parameter is specified, this function returns the anycast IP address
///             table containing only IPv4 entries. </td> </tr> <tr> <td width="40%"><a id="AF_INET6"></a><a
///             id="af_inet6"></a><dl> <dt><b>AF_INET6</b></dt> <dt>23</dt> </dl> </td> <td width="60%"> The Internet Protocol
///             version 6 (IPv6) address family. When this parameter is specified, this function returns the anycast IP address
///             table containing only IPv6 entries. </td> </tr> </table>
///    Table = A pointer to a MIB_ANYCASTIPADDRESS_TABLE structure that contains a table of anycast IP address entries on the
///            local computer.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed to the
///    function. This error is returned if a <b>NULL</b> pointer is passed in the <i>Table</i> parameter or the
///    <i>Family</i> parameter was not specified as <b>AF_INET</b>, <b>AF_INET6</b>, or <b>AF_UNSPEC</b>. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient
///    memory resources are available to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No anycast IP address entries as specified in the
///    <i>Family</i> parameter were found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt>
///    </dl> </td> <td width="60%"> The request is not supported. This error is returned if no IPv4 stack is on the
///    local computer and <b>AF_INET</b> was specified in the <b>Family</b> parameter. This error is also returned if no
///    IPv6 stack is on the local computer and <b>AF_INET6</b> was specified in the <b>Family</b> parameter. This error
///    is also returned on versions of Windows where this function is not supported. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the
///    returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS GetAnycastIpAddressTable(ushort Family, MIB_ANYCASTIPADDRESS_TABLE** Table);

///The <b>GetMulticastIpAddressEntry</b> function retrieves information for an existing multicast IP address entry on
///the local computer.
///Params:
///    Row = A pointer to a MIB_MULTICASTIPADDRESS_ROW structure entry for a multicast IP address entry. On successful return,
///          this structure will be updated with the properties for an existing multicast IP address.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The system cannot find the file specified. This
///    error is returned if the network interface LUID or interface index specified by the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> member of the MIB_MULTICASTIPADDRESS_ROW pointed to by the <i>Row</i> parameter is not a
///    value on the local machine. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> A parameter is incorrect. This error is returned if a <b>NULL</b> pointer is passed in the
///    <i>Row</i> parameter, the <b>Address</b> member of the MIB_MULTICASTIPADDRESS_ROW pointed to by the <i>Row</i>
///    parameter is not set to a valid multicast IPv4 or IPv6 address, or both the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> members of the <b>MIB_MULTICASTIPADDRESS_ROW</b> pointed to by the <i>Row</i> parameter are
///    unspecified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%">
///    Element not found. This error is returned if the network interface specified by the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> member of the MIB_MULTICASTIPADDRESS_ROW structure pointed to by the <i>Row</i> parameter
///    does not match the IP address and address family specified in the <b>Address</b> member in the
///    <b>MIB_MULTICASTIPADDRESS_ROW</b> structure. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not supported. This error is
///    returned if no IPv4 stack is on the local computer and an IPv4 address is specified in the <b>Address</b> member
///    MIB_MULTICASTIPADDRESS_ROW pointed to by the <i>Row</i> parameter. This error is also returned if no IPv6 stack
///    is on the local computer and an IPv6 address is specified in the <b>Address</b> member. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message
///    string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS GetMulticastIpAddressEntry(MIB_MULTICASTIPADDRESS_ROW* Row);

///The <b>GetMulticastIpAddressTable</b> function retrieves the multicast IP address table on the local computer.
///Params:
///    Family = The address family to retrieve. Possible values for the address family are listed in the <i>Winsock2.h</i> header
///             file. Note that the values for the AF_ address family and PF_ protocol family constants are identical (for
///             example, <b>AF_INET</b> and <b>PF_INET</b>), so either constant can be used. On the Windows SDK released for
///             Windows Vista and later, the organization of header files has changed and possible values for this member are
///             defined in the <i>Ws2def.h</i> header file. Note that the <i>Ws2def.h</i> header file is automatically included
///             in <i>Winsock2.h</i>, and should never be used directly. The values currently supported are <b>AF_INET</b>,
///             <b>AF_INET6</b>, and <b>AF_UNSPEC</b>. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="AF_UNSPEC"></a><a id="af_unspec"></a><dl> <dt><b>AF_UNSPEC</b></dt> <dt>0</dt> </dl> </td> <td width="60%">
///             The address family is unspecified. When this parameter is specified, this function returns the multicast IP
///             address table containing both IPv4 and IPv6 entries. </td> </tr> <tr> <td width="40%"><a id="AF_INET"></a><a
///             id="af_inet"></a><dl> <dt><b>AF_INET</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The Internet Protocol
///             version 4 (IPv4) address family. When this parameter is specified, this function returns the multicast IP address
///             table containing only IPv4 entries. </td> </tr> <tr> <td width="40%"><a id="AF_INET6"></a><a
///             id="af_inet6"></a><dl> <dt><b>AF_INET6</b></dt> <dt>23</dt> </dl> </td> <td width="60%"> The Internet Protocol
///             version 6 (IPv6) address family. When this parameter is specified, this function returns the multicast IP address
///             table containing only IPv6 entries. </td> </tr> </table>
///    Table = A pointer to a MIB_MULTICASTIPADDRESS_TABLE structure that contains a table of anycast IP address entries on the
///            local computer.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed to the
///    function. This error is returned if a <b>NULL</b> pointer is passed in the <i>Table</i> parameter or the
///    <i>Family</i> parameter was not specified as <b>AF_INET</b>, <b>AF_INET6</b>, or <b>AF_UNSPEC</b>. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient
///    memory resources are available to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No anycast IP address entries as specified in the
///    <i>Family</i> parameter were found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt>
///    </dl> </td> <td width="60%"> The request is not supported. This error is returned if no IPv4 stack is on the
///    local computer and <b>AF_INET</b> was specified in the <b>Family</b> parameter. This error is also returned if no
///    IPv6 stack is on the local computer and <b>AF_INET6</b> was specified in the <b>Family</b> parameter. This error
///    is also returned on versions of Windows where this function is not supported. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the
///    returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS GetMulticastIpAddressTable(ushort Family, MIB_MULTICASTIPADDRESS_TABLE** Table);

///The <b>CreateIpForwardEntry2</b> function creates a new IP route entry on the local computer.
///Params:
///    Row = A pointer to a MIB_IPFORWARD_ROW2 structure entry for an IP route entry.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error is returned under
///    several conditions that include the following: the user lacks the required administrative privileges on the local
///    computer or the application is not running in an enhanced shell as the built-in Administrator (RunAs
///    administrator). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was passed to the function. This error is returned if a <b>NULL</b> pointer is
///    passed in the <i>Row</i> parameter, the <b>DestinationPrefix</b> member of the MIB_IPFORWARD_ROW2 pointed to by
///    the <i>Row</i> parameter was not specified, the <b>NextHop</b> member of the <b>MIB_IPFORWARD_ROW2</b> pointed to
///    by the <i>Row</i> parameter was not specified, or both the <b>InterfaceLuid</b> or <b>InterfaceIndex</b> members
///    of the <b>MIB_IPFORWARD_ROW2</b> pointed to by the <i>Row</i> parameter were unspecified. This error is also
///    returned if the <b>PreferredLifetime</b> member specified in the <b>MIB_IPFORWARD_ROW2</b> is greater than the
///    <b>ValidLifetime</b> member or if the <b>SitePrefixLength</b> in the <b>MIB_IPFORWARD_ROW2</b> is greater than
///    the prefix length specified in the <b>DestinationPrefix</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified interface could not be found. This
///    error is returned if the network interface specified by the <b>InterfaceLuid</b> or <b>InterfaceIndex</b> member
///    of the MIB_IPNET_ROW2 pointed to by the <i>Row</i> parameter could not be found. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not supported.
///    This error is returned if the interface specified does not support routes. This error is also returned if no IPv4
///    stack is on the local computer and <b>AF_INET</b> was specified in the address family in the
///    <b>DestinationPrefix</b> member of the MIB_IPFORWARD_ROW2 pointed to by the <i>Row</i> parameter. This error is
///    also returned if no IPv6 stack is on the local computer and <b>AF_INET6</b> was specified for the address family
///    in the <b>DestinationPrefix</b> member. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_OBJECT_ALREADY_EXISTS
///    </b></dt> </dl> </td> <td width="60%"> The object already exists. This error is returned if the
///    <b>DestinationPrefix</b> member of the MIB_IPFORWARD_ROW2 pointed to by the <i>Row</i> parameter is a duplicate
///    of an existing IP route entry on the interface specified by the <b>InterfaceLuid</b> or <b>InterfaceIndex</b>
///    member of the <b>MIB_IPFORWARD_ROW2</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td>
///    <td width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS CreateIpForwardEntry2(const(MIB_IPFORWARD_ROW2)* Row);

///The <b>DeleteIpForwardEntry2</b> function deletes an IP route entry on the local computer.
///Params:
///    Row = A pointer to a MIB_IPFORWARD_ROW2 structure entry for an IP route entry. On successful return, this entry will be
///          deleted.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error is returned under
///    several conditions that include the following: the user lacks the required administrative privileges on the local
///    computer or the application is not running in an enhanced shell as the built-in Administrator (RunAs
///    administrator). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was passed to the function. This error is returned if a <b>NULL</b> pointer is
///    passed in the <i>Row</i> parameter, the <b>DestinationPrefix</b> member of the MIB_IPFORWARD_ROW2 pointed to by
///    the <i>Row</i> parameter was not specified, the <b>NextHop</b> member of the <b>MIB_IPFORWARD_ROW2</b> pointed to
///    by the <i>Row</i> parameter was not specified, or both the <b>InterfaceLuid</b> or <b>InterfaceIndex</b> members
///    of the <b>MIB_IPFORWARD_ROW2</b> pointed to by the <i>Row</i> parameter were unspecified. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified interface could not
///    be found. This error is returned if the network interface specified by the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> member of the MIB_IPFORWARD_ROW2 pointed to by the <i>Row</i> parameter could not be found.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The
///    request is not supported. This error is returned if no IPv4 stack is on the local computer and an IPv4 address
///    was specified in the <b>Address</b> member of the MIB_IPFORWARD_ROW2 pointed to by the <i>Row</i> parameter. This
///    error is also returned if no IPv6 stack is on the local computer and an IPv6 address was specified in the
///    <b>Address</b> member. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%">
///    Use FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS DeleteIpForwardEntry2(const(MIB_IPFORWARD_ROW2)* Row);

///The <b>GetBestRoute2</b> function retrieves the IP route entry on the local computer for the best route to the
///specified destination IP address.
///Params:
///    InterfaceLuid = The locally unique identifier (LUID) to specify the network interface associated with an IP route entry.
///    InterfaceIndex = The local index value to specify the network interface associated with an IP route entry. This index value may
///                     change when a network adapter is disabled and then enabled, or under other circumstances, and should not be
///                     considered persistent.
///    SourceAddress = The source IP address. This parameter may be omitted and passed as a <b>NULL</b> pointer.
///    DestinationAddress = The destination IP address.
///    AddressSortOptions = A set of options that affect how IP addresses are sorted. This parameter is not currently used.
///    BestRoute = A pointer to the MIB_IPFORWARD_ROW2 for the best route from the source IP address to the destination IP address.
///    BestSourceAddress = A pointer to the best source IP address.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed to the
///    function. This error is returned if a <b>NULL</b> pointer is passed in the <i>DestinationAddress</i>,
///    <i>BestSourceAddress</i>, or the <i>BestRoute</i> parameter. This error is also returned if the
///    <i>DestinationAddress</i> parameter does not specify an IPv4 or IPv6 address and family. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified interface could
///    not be found. This error is returned if the network interface specified by the <i>InterfaceLuid</i> or
///    <i>InterfaceIndex</i> parameter could not be found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not supported. This error is
///    returned if no IPv4 stack is on the local computer and an IPv4 address and family was specified in the
///    <i>DestinationAddress</i> parameter. This error is also returned if no IPv6 stack is on the local computer and an
///    IPv6 address and family was specified in the <i>DestinationAddress</i> parameter. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message
///    string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS GetBestRoute2(NET_LUID_LH* InterfaceLuid, uint InterfaceIndex, const(SOCKADDR_INET)* SourceAddress, 
                       const(SOCKADDR_INET)* DestinationAddress, uint AddressSortOptions, 
                       MIB_IPFORWARD_ROW2* BestRoute, SOCKADDR_INET* BestSourceAddress);

///The <b>GetIpForwardEntry2</b> function retrieves information for an IP route entry on the local computer.
///Params:
///    Row = A pointer to a MIB_IPFORWARD_ROW2 structure entry for an IP route entry. On successful return, this structure
///          will be updated with the properties for the IP route entry.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed to the
///    function. This error is returned if a <b>NULL</b> pointer is passed in the <i>Row</i> parameter, the
///    <b>DestinationPrefix</b> member of the MIB_IPFORWARD_ROW2 pointed to by the <i>Row</i> parameter was not
///    specified, the <b>NextHop</b> member of the <b>MIB_IPFORWARD_ROW2</b> pointed to by the <i>Row</i> parameter was
///    not specified, or both the <b>InterfaceLuid</b> or <b>InterfaceIndex</b> members of the <b>MIB_IPFORWARD_ROW2</b>
///    pointed to by the <i>Row</i> parameter were unspecified. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> Element not found. This error is returned if the
///    network interface specified by the <b>InterfaceLuid</b> or <b>InterfaceIndex</b> member of the MIB_IPFORWARD_ROW2
///    structure pointed to by the <i>Row</i> parameter does not match the IP address prefix and address family
///    specified in the <b>DestinationPrefix</b> member in the <b>MIB_IPFORWARD_ROW2</b> structure. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not supported.
///    This error is returned if no IPv4 stack is on the local computer and <b>AF_INET</b> was specified in the address
///    family in the <b>DestinationPrefix</b> member of the MIB_IPFORWARD_ROW2 pointed to by the <i>Row</i> parameter.
///    This error is also returned if no IPv6 stack is on the local computer and <b>AF_INET6</b> was specified for the
///    address family in the <b>DestinationPrefix</b> member. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the
///    returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS GetIpForwardEntry2(MIB_IPFORWARD_ROW2* Row);

///The <b>GetIpForwardTable2</b> function retrieves the IP route entries on the local computer.
///Params:
///    Family = The address family to retrieve. Possible values for the address family are listed in the <i>Winsock2.h</i> header
///             file. Note that the values for the AF_ address family and PF_ protocol family constants are identical (for
///             example, <b>AF_INET</b> and <b>PF_INET</b>), so either constant can be used. On the Windows SDK released for
///             Windows Vista and later, the organization of header files has changed and possible values for this member are
///             defined in the <i>Ws2def.h</i> header file. Note that the <i>Ws2def.h</i> header file is automatically included
///             in <i>Winsock2.h</i>, and should never be used directly. The values currently supported are <b>AF_INET</b>,
///             <b>AF_INET6</b>, and <b>AF_UNSPEC</b>. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="AF_UNSPEC"></a><a id="af_unspec"></a><dl> <dt><b>AF_UNSPEC</b></dt> <dt>0</dt> </dl> </td> <td width="60%">
///             The address family is unspecified. When this parameter is specified, this function returns the IP routing table
///             containing both IPv4 and IPv6 entries. </td> </tr> <tr> <td width="40%"><a id="AF_INET"></a><a
///             id="af_inet"></a><dl> <dt><b>AF_INET</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The Internet Protocol
///             version 4 (IPv4) address family. When this parameter is specified, this function returns the IP routing table
///             containing only IPv4 entries. </td> </tr> <tr> <td width="40%"><a id="AF_INET6"></a><a id="af_inet6"></a><dl>
///             <dt><b>AF_INET6</b></dt> <dt>23</dt> </dl> </td> <td width="60%"> The Internet Protocol version 6 (IPv6) address
///             family. When this parameter is specified, this function returns the IP routing table containing only IPv6
///             entries. </td> </tr> </table>
///    Table = A pointer to a MIB_IPFORWARD_TABLE2 structure that contains a table of IP route entries on the local computer.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed to the
///    function. This error is returned if a <b>NULL</b> pointer is passed in the <i>Table</i> parameter or the
///    <i>Family</i> parameter was not specified as <b>AF_INET</b>, <b>AF_INET6</b>, or <b>AF_UNSPEC</b>. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient
///    memory resources are available to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No IP route entries as specified in the
///    <i>Family</i> parameter were found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt>
///    </dl> </td> <td width="60%"> The request is not supported. This error is returned if no IPv4 stack is on the
///    local computer and <b>AF_INET</b> was specified in the <b>Family</b> parameter. This error is also returned if no
///    IPv6 stack is on the local computer and <b>AF_INET6</b> was specified in the <b>Family</b> parameter. This error
///    is also returned on versions of Windows where this function is not supported. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the
///    returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS GetIpForwardTable2(ushort Family, MIB_IPFORWARD_TABLE2** Table);

///The <b>InitializeIpForwardEntry</b> function initializes a <b>MIB_IPFORWARD_ROW2</b> structure with default values
///for an IP route entry on the local computer.
///Params:
///    Row = On entry, a pointer to a MIB_IPFORWARD_ROW2 structure entry for an IP route entry. On return, the
///          <b>MIB_IPFORWARD_ROW2</b> structure pointed to by this parameter is initialized with default values for an IP
///          route entry.
///Returns:
///    This function does not return a value.
///    
@DllImport("IPHLPAPI")
void InitializeIpForwardEntry(MIB_IPFORWARD_ROW2* Row);

///The <b>NotifyRouteChange2</b> function registers to be notified for changes to IP route entries on a local computer.
///Params:
///    AddressFamily = The address family on which to register for change notifications. Possible values for the address family are
///                    listed in the <i>Winsock2.h</i> header file. Note that the values for the AF_ address family and PF_ protocol
///                    family constants are identical (for example, <b>AF_INET</b> and <b>PF_INET</b>), so either constant can be used.
///                    On the Windows SDK released for Windows Vista and later, the organization of header files has changed and
///                    possible values for this member are defined in the <i>Ws2def.h</i> header file. Note that the <i>Ws2def.h</i>
///                    header file is automatically included in <i>Winsock2.h</i>, and should never be used directly. The values
///                    currently supported are <b>AF_INET</b>, <b>AF_INET6</b>, and <b>AF_UNSPEC</b>. <table> <tr> <th>Value</th>
///                    <th>Meaning</th> </tr> <tr> <td width="40%"><a id="AF_INET"></a><a id="af_inet"></a><dl> <dt><b>AF_INET</b></dt>
///                    </dl> </td> <td width="60%"> Register for only IPv4 route change notifications. </td> </tr> <tr> <td
///                    width="40%"><a id="AF_INET6"></a><a id="af_inet6"></a><dl> <dt><b>AF_INET6</b></dt> </dl> </td> <td width="60%">
///                    Register for only IPv6 route change notifications. </td> </tr> <tr> <td width="40%"><a id="AF_UNSPEC"></a><a
///                    id="af_unspec"></a><dl> <dt><b>AF_UNSPEC</b></dt> </dl> </td> <td width="60%"> Register for both IPv4 and IPv6
///                    route change notifications. </td> </tr> </table>
///    Callback = A pointer to the function to call when a change occurs. This function will be invoked when an IP route
///               notification is received.
///    CallerContext = A user context passed to the callback function specified in the <i>Callback</i> parameter when an IP route
///                    notification is received.
///    InitialNotification = A value that indicates whether the callback should be invoked immediately after registration for change
///                          notification completes. This initial notification does not indicate a change occurred to an IP route entry. The
///                          purpose of this parameter to provide confirmation that the callback is registered.
///    NotificationHandle = A pointer used to return a handle that can be later used to deregister the change notification. On success, a
///                         notification handle is returned in this parameter. If an error occurs, <b>NULL</b> is returned.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> An internal error occurred where an invalid
///    handle was encountered. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> An invalid parameter was passed to the function. This error is returned if the
///    <i>Family</i> parameter was not either <b>AF_INET</b>, <b>AF_INET6</b>, or <b>AF_UNSPEC</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There was insufficient
///    memory. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use
///    FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS NotifyRouteChange2(ushort AddressFamily, PIPFORWARD_CHANGE_CALLBACK Callback, void* CallerContext, 
                            ubyte InitialNotification, HANDLE* NotificationHandle);

///The <b>SetIpForwardEntry2</b> function sets the properties of an IP route entry on the local computer.
///Params:
///    Route = A pointer to a MIB_IPFORWARD_ROW2 structure entry for an IP route entry. The <b>DestinationPrefix</b> member of
///            the <b>MIB_IPFORWARD_ROW2</b> must be set to a valid IP destination prefix, the <b>NextHop</b> member of the
///            <b>MIB_IPFORWARD_ROW2</b> must be set to a valid IP address family and IP address, and the <b>InterfaceLuid</b>
///            or the <b>InterfaceIndex</b> member of the <b>MIB_IPFORWARD_ROW2</b> must be specified.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error is returned under
///    several conditions that include the following: the user lacks the required administrative privileges on the local
///    computer or the application is not running in an enhanced shell as the built-in Administrator (RunAs
///    administrator). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was passed to the function. This error is returned if a <b>NULL</b> pointer is
///    passed in the <i>Route</i> parameter, the <b>DestinationPrefix</b> member of the MIB_IPFORWARD_ROW2 pointed to by
///    the <i>Route</i> parameter was not specified, the <b>NextHop</b> member of the <b>MIB_IPFORWARD_ROW2</b> pointed
///    to by the <i>Route</i> parameter was not specified, or both the <b>InterfaceLuid</b> or <b>InterfaceIndex</b>
///    members of the <b>MIB_IPFORWARD_ROW2</b> pointed to by the <i>Route</i> parameter were unspecified. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified interface
///    could not be found. This error is returned if the network interface specified by the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> member of the MIB_IPFORWARD_ROW2 pointed to by the <i>Route</i> parameter could not be
///    found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use
///    FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS SetIpForwardEntry2(const(MIB_IPFORWARD_ROW2)* Route);

///The <b>FlushIpPathTable</b> function flushes the IP path table on the local computer.
///Params:
///    Family = The address family to flush. Possible values for the address family are listed in the <i>Winsock2.h</i> header
///             file. Note that the values for the AF_ address family and PF_ protocol family constants are identical (for
///             example, <b>AF_INET</b> and <b>PF_INET</b>), so either constant can be used. On the Windows SDK released for
///             Windows Vista and later, the organization of header files has changed and possible values for this member are
///             defined in the <i>Ws2def.h</i> header file. Note that the <i>Ws2def.h</i> header file is automatically included
///             in <i>Winsock2.h</i>, and should never be used directly. The values currently supported are <b>AF_INET</b>,
///             <b>AF_INET6</b>, and <b>AF_UNSPEC</b>. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="AF_UNSPEC"></a><a id="af_unspec"></a><dl> <dt><b>AF_UNSPEC</b></dt> <dt>0</dt> </dl> </td> <td width="60%">
///             The address family is unspecified. When this parameter is specified, this function flushes the IP path table
///             containing both IPv4 and IPv6 entries. </td> </tr> <tr> <td width="40%"><a id="AF_INET"></a><a
///             id="af_inet"></a><dl> <dt><b>AF_INET</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The Internet Protocol
///             version 4 (IPv4) address family. When this parameter is specified, this function flushes the IP path table
///             containing only IPv4 entries. </td> </tr> <tr> <td width="40%"><a id="AF_INET6"></a><a id="af_inet6"></a><dl>
///             <dt><b>AF_INET6</b></dt> <dt>23</dt> </dl> </td> <td width="60%"> The Internet Protocol version 6 (IPv6) address
///             family. When this parameter is specified, this function flushes the IP path table containing only IPv6 entries.
///             </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error is returned under
///    several conditions that include the following: the user lacks the required administrative privileges on the local
///    computer or the application is not running in an enhanced shell as the built-in Administrator (RunAs
///    administrator). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was passed to the function. This error is returned if the <i>Family</i>
///    parameter was not specified as <b>AF_INET</b>, <b>AF_INET6</b>, or <b>AF_UNSPEC</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not supported.
///    This error is returned if no IPv4 stack is on the local computer and <b>AF_INET</b> was specified in the
///    <b>Family</b> parameter. This error is also returned if no IPv6 stack is on the local computer and
///    <b>AF_INET6</b> was specified in the <b>Family</b> parameter. This error is also returned on versions of Windows
///    where this function is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td>
///    <td width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS FlushIpPathTable(ushort Family);

///The <b>GetIpPathEntry</b> function retrieves information for a IP path entry on the local computer.
///Params:
///    Row = A pointer to a MIB_IPPATH_ROW structure entry for a IP path entry. On successful return, this structure will be
///          updated with the properties for IP path entry.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The system cannot find the file specified. This
///    error is returned if the network interface LUID or interface index specified by the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> member of the MIB_IPPATH_ROW pointed to by the <i>Row</i> parameter is not a value on the
///    local machine. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> A parameter is incorrect. This error is returned if a <b>NULL</b> pointer is passed in the
///    <i>Row</i> parameter, the <b>si_family</b> member in the <b>Destination</b> member of the MIB_IPPATH_ROW pointed
///    to by the <i>Row</i> parameter is not set to <b>AF_INET</b> or <b>AF_INET6</b>, or both the <b>InterfaceLuid</b>
///    or <b>InterfaceIndex</b> members of the <b>MIB_IPPATH_ROW</b> pointed to by the <i>Row</i> parameter are
///    unspecified. This error is also returned if the <b>si_family</b> member in the <b>Source</b> member of the
///    <b>MIB_IPPATH_ROW</b> pointed to by the <i>Row</i> parameter did not match the destination IP address family and
///    the <b>si_family</b> for the source IP address is not specified as <b>AF_UNSPEC</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> Element not found. This error is
///    returned if the network interface specified by the <b>InterfaceLuid</b> or <b>InterfaceIndex</b> member of the
///    MIB_IPPATH_ROW structure pointed to by the <i>Row</i> parameter does not match the IP address and address family
///    specified in the <b>Destination</b> member in the <b>MIB_IPPATH_ROW</b> structure. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not supported.
///    This error is returned if no IPv4 stack is on the local computer and an IPv4 address is specified in the
///    <b>Source</b> and <b>Destination</b> members of the MIB_IPPATH_ROW pointed to by the <i>Row</i> parameter. This
///    error is also returned if no IPv6 stack is on the local computer and an IPv6 address is specified in the
///    <b>Source</b> and <b>Destination</b> members. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl>
///    </td> <td width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr>
///    </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS GetIpPathEntry(MIB_IPPATH_ROW* Row);

///The <b>GetIpPathTable</b> function retrieves the IP path table on the local computer.
///Params:
///    Family = The address family to retrieve. Possible values for the address family are listed in the <i>Winsock2.h</i> header
///             file. Note that the values for the AF_ address family and PF_ protocol family constants are identical (for
///             example, <b>AF_INET</b> and <b>PF_INET</b>), so either constant can be used. On the Windows SDK released for
///             Windows Vista and later, the organization of header files has changed and possible values for this member are
///             defined in the <i>Ws2def.h</i> header file. Note that the <i>Ws2def.h</i> header file is automatically included
///             in <i>Winsock2.h</i>, and should never be used directly. The values currently supported are <b>AF_INET</b>,
///             <b>AF_INET6</b>, and <b>AF_UNSPEC</b>. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="AF_UNSPEC"></a><a id="af_unspec"></a><dl> <dt><b>AF_UNSPEC</b></dt> <dt>0</dt> </dl> </td> <td width="60%">
///             The address family is unspecified. When this parameter is specified, this function returns the IP path table
///             containing both IPv4 and IPv6 entries. </td> </tr> <tr> <td width="40%"><a id="AF_INET"></a><a
///             id="af_inet"></a><dl> <dt><b>AF_INET</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The Internet Protocol
///             version 4 (IPv4) address family. When this parameter is specified, this function returns the IP path table
///             containing only IPv4 entries. </td> </tr> <tr> <td width="40%"><a id="AF_INET6"></a><a id="af_inet6"></a><dl>
///             <dt><b>AF_INET6</b></dt> <dt>23</dt> </dl> </td> <td width="60%"> The Internet Protocol version 6 (IPv6) address
///             family. When this parameter is specified, this function returns the IP path table containing only IPv6 entries.
///             </td> </tr> </table>
///    Table = A pointer to a MIB_IPPATH_TABLE structure that contains a table of IP path entries on the local computer.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed to the
///    function. This error is returned if a <b>NULL</b> pointer is passed in the <i>Table</i> parameter or the
///    <i>Family</i> parameter was not specified as <b>AF_INET</b>, <b>AF_INET6</b>, or <b>AF_UNSPEC</b>. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient
///    memory resources are available to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> No IP path entries as specified in the <i>Family</i>
///    parameter were found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td
///    width="60%"> The request is not supported. This error is returned if no IPv4 stack is on the local computer and
///    <b>AF_INET</b> was specified in the <b>Family</b> parameter. This error is also returned if no IPv6 stack is on
///    the local computer and <b>AF_INET6</b> was specified in the <b>Family</b> parameter. This error is also returned
///    on versions of Windows where this function is not supported. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the
///    returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS GetIpPathTable(ushort Family, MIB_IPPATH_TABLE** Table);

///The <b>CreateIpNetEntry2</b> function creates a new neighbor IP address entry on the local computer.
///Params:
///    Row = A pointer to a MIB_IPNET_ROW2 structure entry for a neighbor IP address entry.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error is returned under
///    several conditions that include the following: the user lacks the required administrative privileges on the local
///    computer or the application is not running in an enhanced shell as the built-in Administrator (RunAs
///    administrator). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was passed to the function. This error is returned if a <b>NULL</b> pointer is
///    passed in the <i>Row</i> parameter, the <b>Address</b> member of the MIB_IPNET_ROW2 pointed to by the <i>Row</i>
///    parameter was not set to a valid unicast, anycast, or multicast IPv4 or IPv6 address, the <b>PhysicalAddress</b>
///    and <b>PhysicalAddressLength</b> members of the <b>MIB_IPNET_ROW2</b> pointed to by the <i>Row</i> parameter were
///    not set to a valid physical address, or both the <b>InterfaceLuid</b> or <b>InterfaceIndex</b> members of the
///    <b>MIB_IPNET_ROW2</b> pointed to by the <i>Row</i> parameter were unspecified. This error is also returned if a
///    loopback address was passed in the <b>Address</b> member. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified interface could not be found. This
///    error is returned if the network interface specified by the <b>InterfaceLuid</b> or <b>InterfaceIndex</b> member
///    of the MIB_IPNET_ROW2 pointed to by the <i>Row</i> parameter could not be found. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not supported.
///    This error is returned if no IPv4 stack is on the local computer and an IPv4 address was specified in the
///    <b>Address</b> member of the MIB_IPNET_ROW2 pointed to by the <i>Row</i> parameter. This error is also returned
///    if no IPv6 stack is on the local computer and an IPv6 address was specified in the <b>Address</b> member. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_OBJECT_ALREADY_EXISTS </b></dt> </dl> </td> <td width="60%"> The
///    object already exists. This error is returned if the <b>Address</b> member of the MIB_IPNET_ROW2 pointed to by
///    the <i>Row</i> parameter is a duplicate of an existing neighbor IP address on the interface specified by the
///    <b>InterfaceLuid</b> or <b>InterfaceIndex</b> member of the <b>MIB_IPNET_ROW2</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message
///    string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS CreateIpNetEntry2(const(MIB_IPNET_ROW2)* Row);

///The <b>DeleteIpNetEntry2</b> function deletes a neighbor IP address entry on the local computer.
///Params:
///    Row = A pointer to a MIB_IPNET_ROW2 structure entry for a neighbor IP address entry. On successful return, this entry
///          will be deleted.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error is returned under
///    several conditions that include the following: the user lacks the required administrative privileges on the local
///    computer or the application is not running in an enhanced shell as the built-in Administrator (RunAs
///    administrator). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was passed to the function. This error is returned if a <b>NULL</b> pointer is
///    passed in the <i>Row</i> parameter, the <b>Address</b> member of the MIB_IPNET_ROW2 pointed to by the <i>Row</i>
///    parameter was not set to a valid neighbor IPv4 or IPv6 address, or both the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> members of the <b>MIB_IPNET_ROW2</b> pointed to by the <i>Row</i> parameter were
///    unspecified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%">
///    The specified interface could not be found. This error is returned if the network interface specified by the
///    <b>InterfaceLuid</b> or <b>InterfaceIndex</b> member of the MIB_IPNET_ROW2 pointed to by the <i>Row</i> parameter
///    could not be found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td
///    width="60%"> The request is not supported. This error is returned if no IPv4 stack is on the local computer and
///    an IPv4 address was specified in the <b>Address</b> member of the MIB_IPNET_ROW2 pointed to by the <i>Row</i>
///    parameter. This error is also returned if no IPv6 stack is on the local computer and an IPv6 address was
///    specified in the <b>Address</b> member. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td>
///    <td width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS DeleteIpNetEntry2(const(MIB_IPNET_ROW2)* Row);

///The <b>FlushIpNetTable2</b> function flushes the IP neighbor table on the local computer.
///Params:
///    Family = The address family to flush. Possible values for the address family are listed in the <i>Winsock2.h</i> header
///             file. Note that the values for the AF_ address family and PF_ protocol family constants are identical (for
///             example, <b>AF_INET</b> and <b>PF_INET</b>), so either constant can be used. On the Windows SDK released for
///             Windows Vista and later, the organization of header files has changed and possible values for this member are
///             defined in the <i>Ws2def.h</i> header file. Note that the <i>Ws2def.h</i> header file is automatically included
///             in <i>Winsock2.h</i>, and should never be used directly. The values currently supported are <b>AF_INET</b>,
///             <b>AF_INET6</b>, and <b>AF_UNSPEC</b>. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="AF_UNSPEC"></a><a id="af_unspec"></a><dl> <dt><b>AF_UNSPEC</b></dt> <dt>0</dt> </dl> </td> <td width="60%">
///             The address family is unspecified. When this parameter is specified, this function flushes the neighbor IP
///             address table containing both IPv4 and IPv6 entries. </td> </tr> <tr> <td width="40%"><a id="AF_INET"></a><a
///             id="af_inet"></a><dl> <dt><b>AF_INET</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The Internet Protocol
///             version 4 (IPv4) address family. When this parameter is specified, this function flushes the neighbor IP address
///             table containing only IPv4 entries. </td> </tr> <tr> <td width="40%"><a id="AF_INET6"></a><a
///             id="af_inet6"></a><dl> <dt><b>AF_INET6</b></dt> <dt>23</dt> </dl> </td> <td width="60%"> The Internet Protocol
///             version 6 (IPv6) address family. When this parameter is specified, this function flushes the neighbor IP address
///             table containing only IPv6 entries. </td> </tr> </table>
///    InterfaceIndex = The interface index. If the index is specified, flush the neighbor IP address entries on a specific interface,
///                     otherwise flush the neighbor IP address entries on all the interfaces. To ignore the interface, set this
///                     parameter to zero.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error is returned under
///    several conditions that include the following: the user lacks the required administrative privileges on the local
///    computer or the application is not running in an enhanced shell as the built-in Administrator (RunAs
///    administrator). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was passed to the function. This error is returned if the <i>Family</i>
///    parameter was not specified as <b>AF_INET</b>, <b>AF_INET6</b>, or <b>AF_UNSPEC</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not supported.
///    This error is returned if no IPv4 stack is on the local computer and <b>AF_INET</b> was specified in the
///    <b>Family</b> parameter. This error is also returned if no IPv6 stack is on the local computer and
///    <b>AF_INET6</b> was specified in the <b>Family</b> parameter. This error is also returned on versions of Windows
///    where this function is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td>
///    <td width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS FlushIpNetTable2(ushort Family, uint InterfaceIndex);

///The <b>GetIpNetEntry2</b> function retrieves information for a neighbor IP address entry on the local computer.
///Params:
///    Row = A pointer to a MIB_IPNET_ROW2 structure entry for a neighbor IP address entry. On successful return, this
///          structure will be updated with the properties for neighbor IP address.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The system cannot find the file specified. This
///    error is returned if the network interface LUID or interface index specified by the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> member of the MIB_IPNET_ROW2 pointed to by the <i>Row</i> parameter was not a value on the
///    local machine. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was passed to the function. This error is returned if a <b>NULL</b> pointer is
///    passed in the <i>Row</i> parameter, the <b>Address</b> member of the MIB_IPNET_ROW2 pointed to by the <i>Row</i>
///    parameter was not set to a valid neighbor IPv4 or IPv6 address, or both the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> members of the <b>MIB_IPNET_ROW2</b> pointed to by the <i>Row</i> parameter were
///    unspecified. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%">
///    Element not found. This error is returned if the network interface specified by the <b>InterfaceLuid</b> or
///    <b>InterfaceIndex</b> member of the MIB_IPNET_ROW2 structure pointed to by the <i>Row</i> parameter does not
///    match the neighbor IP address and address family specified in the <b>Address</b> member in the
///    <b>MIB_IPNET_ROW2</b> structure. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl>
///    </td> <td width="60%"> The request is not supported. This error is returned if no IPv4 stack is on the local
///    computer and an IPv4 address was specified in the <b>Address</b> member of the MIB_IPNET_ROW2 structure pointed
///    to by the <i>Row</i> parameter. This error is also returned if no IPv6 stack is on the local computer and an IPv6
///    address was specified in the <b>Address</b> member of the <b>MIB_IPNET_ROW2</b> structure. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message
///    string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS GetIpNetEntry2(MIB_IPNET_ROW2* Row);

///The <b>GetIpNetTable2</b> function retrieves the IP neighbor table on the local computer.
///Params:
///    Family = The address family to retrieve. Possible values for the address family are listed in the <i>Winsock2.h</i> header
///             file. Note that the values for the AF_ address family and PF_ protocol family constants are identical (for
///             example, <b>AF_INET</b> and <b>PF_INET</b>), so either constant can be used. On the Windows SDK released for
///             Windows Vista and later, the organization of header files has changed and possible values for this member are
///             defined in the <i>Ws2def.h</i> header file. Note that the <i>Ws2def.h</i> header file is automatically included
///             in <i>Winsock2.h</i>, and should never be used directly. The values currently supported are <b>AF_INET</b>,
///             <b>AF_INET6</b>, and <b>AF_UNSPEC</b>. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///             id="AF_UNSPEC"></a><a id="af_unspec"></a><dl> <dt><b>AF_UNSPEC</b></dt> <dt>0</dt> </dl> </td> <td width="60%">
///             The address family is unspecified. When this parameter is specified, this function returns the neighbor IP
///             address table containing both IPv4 and IPv6 entries. </td> </tr> <tr> <td width="40%"><a id="AF_INET"></a><a
///             id="af_inet"></a><dl> <dt><b>AF_INET</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The Internet Protocol
///             version 4 (IPv4) address family. When this parameter is specified, this function returns the neighbor IP address
///             table containing only IPv4 entries. </td> </tr> <tr> <td width="40%"><a id="AF_INET6"></a><a
///             id="af_inet6"></a><dl> <dt><b>AF_INET6</b></dt> <dt>23</dt> </dl> </td> <td width="60%"> The Internet Protocol
///             version 6 (IPv6) address family. When this parameter is specified, this function returns the neighbor IP address
///             table containing only IPv6 entries. </td> </tr> </table>
///    Table = A pointer to a MIB_IPNET_TABLE2 structure that contains a table of neighbor IP address entries on the local
///            computer.
///Returns:
///    If the function succeeds, the return value is NO_ERROR or ERROR_NOT_FOUND. If the function fails or returns no
///    data, the return value is one of the following error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was passed to the function. This error is returned if a <b>NULL</b> pointer is
///    passed in the <i>Table</i> parameter or the <i>Family</i> parameter was not specified as <b>AF_INET</b>,
///    <b>AF_INET6</b>, or <b>AF_UNSPEC</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Insufficient memory resources are available
///    to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td
///    width="60%"> No neighbor IP address entries as specified in the <i>Family</i> parameter were found. This return
///    value indicates that the call to the GetIpNetTable2 function succeeded, but there was no data to return. This can
///    occur when AF_INET is specified in the <i>Family</i> parameter and there are no ARP entries to return. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is
///    not supported. This error is returned if no IPv4 stack is on the local computer and <b>AF_INET</b> was specified
///    in the <b>Family</b> parameter. This error is also returned if no IPv6 stack is on the local computer and
///    <b>AF_INET6</b> was specified in the <b>Family</b> parameter. This error is also returned on versions of Windows
///    where this function is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td>
///    <td width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS GetIpNetTable2(ushort Family, MIB_IPNET_TABLE2** Table);

///The <b>ResolveIpNetEntry2</b> function resolves the physical address for a neighbor IP address entry on the local
///computer.
///Params:
///    Row = A pointer to a MIB_IPNET_ROW2 structure entry for a neighbor IP address entry. On successful return, this
///          structure will be updated with the properties for neighbor IP address.
///    SourceAddress = A pointer to a an optional source IP address used to select the interface to send the requests on for the
///                    neighbor IP address entry.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BAD_NET_NAME</b></dt> </dl> </td> <td width="60%"> The network name cannot be found. This error is
///    returned if the network with the neighbor IP address is unreachable. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed to the
///    function. This error is returned if a <b>NULL</b> pointer is passed in the <i>Row</i> parameter, the
///    <b>Address</b> member of the MIB_IPNET_ROW2 pointed to by the <i>Row</i> parameter was not set to a valid IPv4 or
///    IPv6 address, or both the <b>InterfaceLuid</b> or <b>InterfaceIndex</b> members of the <b>MIB_IPNET_ROW2</b>
///    pointed to by the <i>Row</i> parameter were unspecified. This error is also returned if a loopback address was
///    passed in the <b>Address</b> member. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl>
///    </td> <td width="60%"> The specified interface could not be found. This error is returned if the network
///    interface specified by the <b>InterfaceLuid</b> or <b>InterfaceIndex</b> member of the MIB_IPNET_ROW2 pointed to
///    by the <i>Row</i> parameter could not be found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not supported. This error is
///    returned if no IPv4 stack is on the local computer and an IPv4 address was specified in the <b>Address</b> member
///    of the MIB_IPNET_ROW2 pointed to by the <i>Row</i> parameter or no IPv6 stack is on the local computer and an
///    IPv6 address was specified in the <b>Address</b> member. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the
///    returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS ResolveIpNetEntry2(MIB_IPNET_ROW2* Row, const(SOCKADDR_INET)* SourceAddress);

///The <b>SetIpNetEntry2</b> function sets the physical address of an existing neighbor IP address entry on the local
///computer.
///Params:
///    Row = A pointer to a MIB_IPNET_ROW2 structure entry for a neighbor IP address entry.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error is returned under
///    several conditions that include the following: the user lacks the required administrative privileges on the local
///    computer or the application is not running in an enhanced shell as the built-in Administrator (RunAs
///    administrator). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was passed to the function. This error is returned if a <b>NULL</b> pointer is
///    passed in the <i>Row</i> parameter, the <b>Address</b> member of the MIB_IPNET_ROW2 pointed to by the <i>Row</i>
///    parameter was not set to a valid unicast, anycast, or multicast IPv4 or IPv6 address, the <b>PhysicalAddress</b>
///    and <b>PhysicalAddressLength</b> members of the <b>MIB_IPNET_ROW2</b> pointed to by the <i>Row</i> parameter were
///    not set to a valid physical address, or both the <b>InterfaceLuid</b> or <b>InterfaceIndex</b> members of the
///    <b>MIB_IPNET_ROW2</b> pointed to by the <i>Row</i> parameter were unspecified. This error is also returned if a
///    loopback address was passed in the <b>Address</b> member. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified interface could not be found. This
///    error is returned if the network interface specified by the <b>InterfaceLuid</b> or <b>InterfaceIndex</b> member
///    of the MIB_IPNET_ROW2 pointed to by the <i>Row</i> parameter could not be found. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not supported.
///    This error is returned if no IPv4 stack is on the local computer and an IPv4 address was specified in the
///    <b>Address</b> member of the MIB_IPNET_ROW2 pointed to by the <i>Row</i> parameter or no IPv6 stack is on the
///    local computer and an IPv6 address was specified in the <b>Address</b> member. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the
///    returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS SetIpNetEntry2(MIB_IPNET_ROW2* Row);

///The <b>NotifyTeredoPortChange</b> function registers to be notified for changes to the UDP port number used by the
///Teredo client for the Teredo service port on a local computer.
///Params:
///    Callback = A pointer to the function to call when a Teredo client port change occurs. This function will be invoked when a
///               Teredo port change notification is received.
///    CallerContext = A user context passed to the callback function specified in the <i>Callback</i> parameter when a Teredo port
///                    change notification is received.
///    InitialNotification = A value that indicates whether the callback should be invoked immediately after registration for change
///                          notification completes. This initial notification does not indicate a change occurred to the Teredo client port.
///                          The purpose of this parameter to provide confirmation that the callback is registered.
///    NotificationHandle = A pointer used to return a handle that can be later used to deregister the change notification. On success, a
///                         notification handle is returned in this parameter. If an error occurs, <b>NULL</b> is returned.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> An internal error occurred where an invalid
///    handle was encountered. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> An invalid parameter was passed to the function. This error is returned if the
///    <i>Callback</i> parameter is a <b>NULL</b> pointer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There was insufficient memory. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the
///    message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS NotifyTeredoPortChange(PTEREDO_PORT_CHANGE_CALLBACK Callback, void* CallerContext, 
                                ubyte InitialNotification, HANDLE* NotificationHandle);

///The <b>GetTeredoPort</b> function retrieves the dynamic UDP port number used by the Teredo client on the local
///computer.
///Params:
///    Port = A pointer to the UDP port number. On successful return, this parameter will be filled with the port number used
///           by the Teredo client.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed to the
///    function. This error is returned if a <b>NULL</b> pointer is passed in the <i>Port</i> parameter. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_READY</b></dt> </dl> </td> <td width="60%"> The device is not ready.
///    This error is returned if the Teredo client is not started on the local computer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not supported.
///    This error is returned if no IPv6 stack is on the local computer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the
///    returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS GetTeredoPort(ushort* Port);

///The <b>CancelMibChangeNotify2</b> function deregisters for change notifications for IP interface changes, IP address
///changes, IP route changes, Teredo port changes, and when the unicast IP address table is stable and can be retrieved.
///Params:
///    NotificationHandle = The handle returned from a notification registration or retrieval function to indicate which notification to
///                         cancel.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed to the
///    function. This error is returned if the <i>NotificationHandle</i> parameter was a <b>NULL</b> pointer. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain
///    the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS CancelMibChangeNotify2(HANDLE NotificationHandle);

///The <b>FreeMibTable</b> function frees the buffer allocated by the functions that return tables of network
///interfaces, addresses, and routes (GetIfTable2 and GetAnycastIpAddressTable, for example).
///Params:
///    Memory = A pointer to the buffer to free.
///Returns:
///    This function does not return a value.
///    
@DllImport("IPHLPAPI")
void FreeMibTable(void* Memory);

///The <b>CreateSortedAddressPairs</b> function takes a supplied list of potential IP destination addresses, pairs the
///destination addresses with the host machine's local IP addresses, and sorts the pairs according to which address pair
///is best suited for communication between the two peers.
///Params:
///    SourceAddressList = Must be <b>NULL</b>. Reserved for future use.
///    SourceAddressCount = Must be 0. Reserved for future use.
///    DestinationAddressList = A pointer to an array of SOCKADDR_IN6 structures that contain a list of potential IPv6 destination addresses. Any
///                             IPv4 addresses must be represented in the IPv4-mapped IPv6 address format which enables an IPv6 only application
///                             to communicate with an IPv4 node.
///    DestinationAddressCount = The number of destination addresses pointed to by the <i>DestinationAddressList</i> parameter.
///    AddressSortOptions = Reserved for future use.
///    SortedAddressPairList = A pointer to store an array of SOCKADDR_IN6_PAIR structures that contain a list of pairs of IPv6 addresses sorted
///                            in the preferred order of communication, if the function call is successful.
///    SortedAddressPairCount = A pointer to store the number of address pairs pointed to by the <i>SortedAddressPairList</i> parameter, if the
///                             function call is successful.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed to the
///    function. This error is returned if the <i>DestinationAddressList</i>, <i>SortedAddressPairList</i>, or
///    <i>SortedAddressPairCount</i> parameters <b>NULL</b>, or the <i>DestinationAddressCount</i> was greated than 500.
///    This error is also returned if the <i>SourceAddressList</i> is not <b>NULL</b> or the
///    <i>SourceAddressPairCount</i> parameter is not zero. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Not enough storage is available to process
///    this command. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td
///    width="60%"> The request is not supported. This error is returned if no IPv6 stack is on the local computer.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to
///    obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS CreateSortedAddressPairs(const(SOCKADDR_IN6_LH)* SourceAddressList, uint SourceAddressCount, 
                                  const(SOCKADDR_IN6_LH)* DestinationAddressList, uint DestinationAddressCount, 
                                  uint AddressSortOptions, SOCKADDR_IN6_PAIR** SortedAddressPairList, 
                                  uint* SortedAddressPairCount);

@DllImport("IPHLPAPI")
NTSTATUS ConvertCompartmentGuidToId(const(GUID)* CompartmentGuid, uint* CompartmentId);

@DllImport("IPHLPAPI")
NTSTATUS ConvertCompartmentIdToGuid(uint CompartmentId, GUID* CompartmentGuid);

///The <b>ConvertInterfaceNameToLuidA</b> function converts an ANSI network interface name to the locally unique
///identifier (LUID) for the interface.
///Params:
///    InterfaceName = A pointer to a <b>NULL</b>-terminated ANSI string containing the network interface name.
///    InterfaceLuid = A pointer to the NET_LUID for this interface.
///Returns:
///    On success, <b>ConvertInterfaceNameToLuidA</b> returns <b>NETIO_ERROR_SUCCESS</b>. Any nonzero return value
///    indicates failure. <table> <tr> <th>Error code</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BUFFER_OVERFLOW</b></dt> </dl> </td> <td width="60%"> The length of the ANSI interface name was
///    invalid. This error is returned if the <i>InterfaceName</i> parameter exceeded the maximum allowed string length
///    for this parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_NAME</b></dt> </dl> </td> <td
///    width="60%"> The interface name was invalid. This error is returned if the <i>InterfaceName</i> parameter
///    contained an invalid name. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> One of the parameters was invalid. This error is returned if the <i>InterfaceLuid</i>
///    parameter was <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS ConvertInterfaceNameToLuidA(const(byte)* InterfaceName, NET_LUID_LH* InterfaceLuid);

///The <b>ConvertInterfaceNameToLuidW</b> function converts a Unicode network interface name to the locally unique
///identifier (LUID) for the interface.
///Params:
///    InterfaceName = A pointer to a <b>NULL</b>-terminated Unicode string containing the network interface name.
///    InterfaceLuid = A pointer to the NET_LUID for this interface.
///Returns:
///    On success, <b>ConvertInterfaceNameToLuidW</b> returns <b>NETIO_ERROR_SUCCESS</b>. Any nonzero return value
///    indicates failure. <table> <tr> <th>Error code</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_NAME</b></dt> </dl> </td> <td width="60%"> The interface name was invalid. This error is
///    returned if the <i>InterfaceName</i> parameter contained an invalid name or the length of the
///    <i>InterfaceName</i> parameter exceeded the maximum allowed string length for this parameter. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the parameters
///    was invalid. This error is returned if the <i>InterfaceLuid</i> parameter was <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS ConvertInterfaceNameToLuidW(const(PWSTR) InterfaceName, NET_LUID_LH* InterfaceLuid);

///The <b>ConvertInterfaceLuidToNameA</b> function converts a locally unique identifier (LUID) for a network interface
///to the ANSI interface name.
///Params:
///    InterfaceLuid = A pointer to a NET_LUID for a network interface.
///    InterfaceName = A pointer to a buffer to hold the <b>NULL</b>-terminated ANSI string containing the interface name when the
///                    function returns successfully.
///    Length = The length, in bytes, of the buffer pointed to by the <i>InterfaceName</i> parameter. This value must be large
///             enough to accommodate the interface name and the terminating null character. The maximum required length is
///             <b>NDIS_IF_MAX_STRING_SIZE</b> + 1.
///Returns:
///    On success, <b>ConvertInterfaceLuidToNameA</b> returns <b>NETIO_ERROR_SUCCESS</b>. Any nonzero return value
///    indicates failure. <table> <tr> <th>Error code</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the parameters was invalid. This
///    error is returned if either the <i>InterfaceLuid</i> or the <i>InterfaceName</i> parameter was <b>NULL</b> or if
///    the <i>InterfaceLuid</i> parameter was invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Not enough storage is available to process
///    this command. This error is returned if the size of the buffer pointed to by <i>InterfaceName</i> parameter was
///    not large enough as specified in the <i>Length</i> parameter to hold the interface name. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS ConvertInterfaceLuidToNameA(const(NET_LUID_LH)* InterfaceLuid, PSTR InterfaceName, size_t Length);

///The <b>ConvertInterfaceLuidToNameW</b> function converts a locally unique identifier (LUID) for a network interface
///to the Unicode interface name.
///Params:
///    InterfaceLuid = A pointer to a NET_LUID for a network interface.
///    InterfaceName = A pointer to a buffer to hold the <b>NULL</b>-terminated Unicode string containing the interface name when the
///                    function returns successfully.
///    Length = The number of characters in the array pointed to by the <i>InterfaceName</i> parameter. This value must be large
///             enough to accommodate the interface name and the terminating null character. The maximum required length is
///             <b>NDIS_IF_MAX_STRING_SIZE</b> + 1.
///Returns:
///    On success, <b>ConvertInterfaceLuidToNameW</b> returns <b>NETIO_ERROR_SUCCESS</b>. Any nonzero return value
///    indicates failure. <table> <tr> <th>Error code</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the parameters was invalid. This
///    error is returned if either the <i>InterfaceLuid</i> or the <i>InterfaceName</i> parameter was <b>NULL</b> or if
///    the <i>InterfaceLuid</i> parameter was invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Not enough storage is available to process
///    this command. This error is returned if the size of the buffer pointed to by <i>InterfaceName</i> parameter was
///    not large enough as specified in the <i>Length</i> parameter to hold the interface name. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS ConvertInterfaceLuidToNameW(const(NET_LUID_LH)* InterfaceLuid, PWSTR InterfaceName, size_t Length);

///The <b>ConvertInterfaceLuidToIndex</b> function converts a locally unique identifier (LUID) for a network interface
///to the local index for the interface.
///Params:
///    InterfaceLuid = A pointer to a NET_LUID for a network interface.
///    InterfaceIndex = The local index value for the interface.
///Returns:
///    On success, <b>ConvertInterfaceLuidToIndex</b> returns NO_ERROR. Any nonzero return value indicates failure and a
///    <b>NET_IFINDEX_UNSPECIFIED</b> is returned in the <i>InterfaceIndex</i> parameter. <table> <tr> <th>Error
///    code</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td>
///    <td width="60%"> One of the parameters was invalid. This error is returned if either the <i>InterfaceLuid</i> or
///    <i>InterfaceIndex</i> parameter was <b>NULL</b> or if the <i>InterfaceLuid</i> parameter was invalid. </td> </tr>
///    </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS ConvertInterfaceLuidToIndex(const(NET_LUID_LH)* InterfaceLuid, uint* InterfaceIndex);

///The <b>ConvertInterfaceIndexToLuid</b> function converts a local index for a network interface to the locally unique
///identifier (LUID) for the interface.
///Params:
///    InterfaceIndex = The local index value for a network interface.
///    InterfaceLuid = A pointer to the NET_LUID for this interface.
///Returns:
///    On success, <b>ConvertInterfaceIndexToLuid</b> returns NO_ERROR. Any nonzero return value indicates failure and a
///    <b>NULL</b> is returned in the <i>InterfaceLuid</i> parameter. <table> <tr> <th>Error code</th> <th>Meaning</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The system
///    cannot find the file specified. This error is returned if the network interface specified by the
///    <i>InterfaceIndex</i> parameter was not a value on the local machine. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the parameters was invalid. This
///    error is returned if the <i>InterfaceLuid</i> parameter was <b>NULL</b> or if the <i>InterfaceIndex</i> parameter
///    was invalid. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS ConvertInterfaceIndexToLuid(uint InterfaceIndex, NET_LUID_LH* InterfaceLuid);

///The <b>ConvertInterfaceLuidToAlias</b> function converts a locally unique identifier (LUID) for a network interface
///to an interface alias.
///Params:
///    InterfaceLuid = A pointer to a NET_LUID for a network interface.
///    InterfaceAlias = A pointer to a buffer to hold the <b>NULL</b>-terminated Unicode string containing the alias name of the network
///                     interface when the function returns successfully.
///    Length = The length, in characters, of the buffer pointed to by the <i>InterfaceAlias</i> parameter. This value must be
///             large enough to accommodate the alias name of the network interface and the terminating <b>NULL</b> character.
///             The maximum required length is <b>NDIS_IF_MAX_STRING_SIZE</b> + 1.
///Returns:
///    On success, <b>ConvertInterfaceLuidToAlias</b> returns NO_ERROR. Any nonzero return value indicates failure.
///    <table> <tr> <th>Error code</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the parameters was invalid. This
///    error is returned if either the <i>InterfaceLuid</i> or <i>InterfaceAlias</i> parameter was <b>NULL</b> or if the
///    <i>InterfaceLuid</i> parameter was invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Not enough storage is available to process
///    this command. This error is returned if the size of the buffer pointed to by the <i>InterfaceAlias</i> parameter
///    was not large enough as specified in the <i>Length</i> parameter to hold the alias name. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS ConvertInterfaceLuidToAlias(const(NET_LUID_LH)* InterfaceLuid, PWSTR InterfaceAlias, size_t Length);

///The <b>ConvertInterfaceAliasToLuid</b> function converts an interface alias name for a network interface to the
///locally unique identifier (LUID) for the interface.
///Params:
///    InterfaceAlias = A pointer to a <b>NULL</b>-terminated Unicode string containing the alias name of the network interface.
///    InterfaceLuid = A pointer to the NET_LUID for this interface.
///Returns:
///    On success, <b>ConvertInterfaceAliasToLuid</b> returns NO_ERROR. Any nonzero return value indicates failure and a
///    <b>NULL</b> is returned in the <i>InterfaceLuid</i> parameter. <table> <tr> <th>Error code</th> <th>Meaning</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the
///    parameters was invalid. This error is returned if either the <i>InterfaceAlias</i> or <i>InterfaceLuid</i>
///    parameter was <b>NULL</b> or if the <i>InterfaceAlias</i> parameter was invalid. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS ConvertInterfaceAliasToLuid(const(PWSTR) InterfaceAlias, NET_LUID_LH* InterfaceLuid);

///The <b>ConvertInterfaceLuidToGuid</b> function converts a locally unique identifier (LUID) for a network interface to
///a globally unique identifier (GUID) for the interface.
///Params:
///    InterfaceLuid = A pointer to a NET_LUID for a network interface.
///    InterfaceGuid = A pointer to the <b>GUID</b> for this interface.
///Returns:
///    On success, <b>ConvertInterfaceLuidToGuid</b> returns NO_ERROR. Any nonzero return value indicates failure and a
///    <b>NULL</b> is returned in the <i>InterfaceGuid</i> parameter. <table> <tr> <th>Error code</th> <th>Meaning</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the
///    parameters was invalid. This error is returned if either the <i>InterfaceLuid</i> or <i>InterfaceGuid</i>
///    parameter was <b>NULL</b> or if the <i>InterfaceLuid</i> parameter was invalid. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS ConvertInterfaceLuidToGuid(const(NET_LUID_LH)* InterfaceLuid, GUID* InterfaceGuid);

///The <b>ConvertInterfaceGuidToLuid</b> function converts a globally unique identifier (GUID) for a network interface
///to the locally unique identifier (LUID) for the interface.
///Params:
///    InterfaceGuid = A pointer to a GUID for a network interface.
///    InterfaceLuid = A pointer to the NET_LUID for this interface.
///Returns:
///    On success, <b>ConvertInterfaceGuidToLuid</b> returns NO_ERROR. Any nonzero return value indicates failure and a
///    <b>NULL</b> is returned in the <i>InterfaceLuid</i> parameter. <table> <tr> <th>Error code</th> <th>Meaning</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the
///    parameters was invalid. This error is returned if either the <i>InterfaceAlias</i> or <i>InterfaceLuid</i>
///    parameter was <b>NULL</b> or if the <i>InterfaceGuid</i> parameter was invalid. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS ConvertInterfaceGuidToLuid(const(GUID)* InterfaceGuid, NET_LUID_LH* InterfaceLuid);

///The <b>if_nametoindex</b> function converts the ANSI interface name for a network interface to the local index for
///the interface.
///Params:
///    InterfaceName = A pointer to a <b>NULL</b>-terminated ANSI string containing the interface name.
///Returns:
///    On success, <b>if_nametoindex</b> returns the local interface index. On failure, zero is returned.
///    
@DllImport("IPHLPAPI")
uint if_nametoindex(const(PSTR) InterfaceName);

///The <b>if_indextoname</b> function converts the local index for a network interface to the ANSI interface name.
///Params:
///    InterfaceIndex = The local index for a network interface.
///    InterfaceName = A pointer to a buffer to hold the <b>NULL</b>-terminated ANSI string containing the interface name when the
///                    function returns successfully. The length, in bytes, of the buffer pointed to by this parameter must be equal to
///                    or greater than <b>IF_NAMESIZE</b>.
///Returns:
///    On success, <b>if_indextoname</b> returns a pointer to <b>NULL</b>-terminated ANSI string containing the
///    interface name. On failure, a <b>NULL</b> pointer is returned.
///    
@DllImport("IPHLPAPI")
PSTR if_indextoname(uint InterfaceIndex, PSTR InterfaceName);

@DllImport("IPHLPAPI")
void GetCurrentThreadCompartmentScope(uint* CompartmentScope, uint* CompartmentId);

@DllImport("IPHLPAPI")
NTSTATUS SetCurrentThreadCompartmentScope(uint CompartmentScope);

@DllImport("IPHLPAPI")
uint GetJobCompartmentId(HANDLE JobHandle);

@DllImport("IPHLPAPI")
NTSTATUS SetJobCompartmentId(HANDLE JobHandle, uint CompartmentId);

///The <b>GetDefaultCompartmentId</b> function retrieves the default network routing compartment identifier for the
///local computer.
@DllImport("IPHLPAPI")
uint GetDefaultCompartmentId();

///The <b>ConvertLengthToIpv4Mask</b> function converts an IPv4 prefix length to an IPv4 subnet mask.
///Params:
///    MaskLength = The IPv4 prefix length, in bits.
///    Mask = A pointer to a <b>LONG</b> value to hold the IPv4 subnet mask when the function returns successfully.
///Returns:
///    On success, <b>ConvertLengthToIpv4Mask</b> returns <b>NO_ERROR</b>. Any nonzero return value indicates failure
///    and the <i>Mask</i> parameter is set to <b>INADDR_NONE</b> defined in the <i>Ws2def.h</i> header file. <table>
///    <tr> <th>Error code</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the parameters was invalid. This
///    error is returned if the <i>MaskLength</i> parameter was invalid. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
NTSTATUS ConvertLengthToIpv4Mask(uint MaskLength, uint* Mask);

///The <b>ConvertIpv4MaskToLength</b> function converts an IPv4 subnet mask to an IPv4 prefix length.
///Params:
///    Mask = The IPv4 subnet mask.
///    MaskLength = A pointer to a <b>UINT8</b> value to hold the IPv4 prefix length, in bits, when the function returns
///                 successfully.
///Returns:
///    On success, <b>ConvertIpv4MaskToLength</b> returns <b>NO_ERROR</b>. Any nonzero return value indicates failure.
///    <table> <tr> <th>Error code</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the parameters was invalid. This
///    error is returned if the <i>Mask</i> parameter was invalid. </td> </tr> </table>
///    
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

///Retrieves the aggregate level and cost of network connectivity that an application or service is likely to
///experience.
///Params:
///    ConnectivityHint = A pointer to a value of type [NL_NETWORK_CONNECTIVITY_HINT](../nldef/ns-nldef-nl_network_connectivity_hint.md).
///                       The function sets this value to the aggregate connectivity level and cost hints.
///Returns:
///    In user mode, returns **NO_ERROR** on success, and an error code on failure. In kernel mode, returns
///    **STATUS_SUCCESS** on success, and an error code on failure.
///    
@DllImport("IPHLPAPI")
NTSTATUS GetNetworkConnectivityHint(NL_NETWORK_CONNECTIVITY_HINT* ConnectivityHint);

///Retrieves the level and cost of network connectivity for the specified interface.
///Params:
///    InterfaceIndex = A value of type **NET_IFINDEX** representing the index of the interface for which to retrieve connectivity
///                     information.
///    ConnectivityHint = A pointer to a value of type [NL_NETWORK_CONNECTIVITY_HINT](../nldef/ns-nldef-nl_network_connectivity_hint.md).
///                       The function sets this value to the connectivity level and cost hints for the specified interface.
///Returns:
///    In user mode, returns **NO_ERROR** on success, and an error code on failure. In kernel mode, returns
///    **STATUS_SUCCESS** on success, and an error code on failure.
///    
@DllImport("IPHLPAPI")
NTSTATUS GetNetworkConnectivityHintForInterface(uint InterfaceIndex, 
                                                NL_NETWORK_CONNECTIVITY_HINT* ConnectivityHint);

///Registers an application-defined callback function, to be called when the aggregate network connectivity level and
///cost hints change.
///Params:
///    Callback = A function pointer of type
///               [PNETWORK_CONNECTIVITY_HINT_CHANGE_CALLBACK](./nc-netioapi-pnetwork_connectivity_hint_change_callback.md), which
///               points to your application-defined callback function. The callback function will be invoked when a network
///               connectivity level or cost change occurs.
///    CallerContext = The user-specific caller context. This context will be supplied to the callback function.
///    InitialNotification = `True` if an initialization notification should be provided, otherwise `false`.
///    NotificationHandle = A pointer to a **HANDLE**. The function sets the value to a handle to the notification registration.
///Returns:
///    
///    
@DllImport("IPHLPAPI")
NTSTATUS NotifyNetworkConnectivityHintChange(PNETWORK_CONNECTIVITY_HINT_CHANGE_CALLBACK Callback, 
                                             void* CallerContext, ubyte InitialNotification, 
                                             HANDLE* NotificationHandle);

///The <b>IcmpCreateFile</b> function opens a handle on which IPv4 ICMP echo requests can be issued.
///Returns:
///    The <b>IcmpCreateFile</b> function returns an open handle on success. On failure, the function returns
///    <b>INVALID_HANDLE_VALUE</b>. Call the GetLastError function for extended error information.
///    
@DllImport("IPHLPAPI")
IcmpHandle IcmpCreateFile();

///The <b>Icmp6CreateFile</b> function opens a handle on which IPv6 ICMP echo requests can be issued.
///Returns:
///    The <b>Icmp6CreateFile</b> function returns an open handle on success. On failure, the function returns
///    <b>INVALID_HANDLE_VALUE</b>. Call the GetLastError function for extended error information.
///    
@DllImport("IPHLPAPI")
IcmpHandle Icmp6CreateFile();

///The <b>IcmpCloseHandle</b> function closes a handle opened by a call to the IcmpCreateFile or Icmp6CreateFile
///functions.
///Params:
///    IcmpHandle = The handle to close. This handle must have been returned by a call to IcmpCreateFile or Icmp6CreateFile.
///Returns:
///    If the handle is closed successfully the return value is <b>TRUE</b>, otherwise <b>FALSE</b>. Call the
///    GetLastError function for extended error information.
///    
@DllImport("IPHLPAPI")
BOOL IcmpCloseHandle(HANDLE IcmpHandle);

///The <b>IcmpSendEcho</b> function sends an IPv4 ICMP echo request and returns any echo response replies. The call
///returns when the time-out has expired or the reply buffer is filled.
///Params:
///    IcmpHandle = The open handle returned by the IcmpCreateFile function.
///    DestinationAddress = The IPv4 destination address of the echo request, in the form of an IPAddr structure.
///    RequestData = A pointer to a buffer that contains data to send in the request.
///    RequestSize = The size, in bytes, of the request data buffer pointed to by the <i>RequestData</i> parameter.
///    RequestOptions = A pointer to the IP header options for the request, in the form of an IP_OPTION_INFORMATION structure. On a
///                     64-bit platform, this parameter is in the form for an IP_OPTION_INFORMATION32 structure. This parameter may be
///                     <b>NULL</b> if no IP header options need to be specified.
///    ReplyBuffer = A buffer to hold any replies to the echo request. Upon return, the buffer contains an array of ICMP_ECHO_REPLY
///                  structures followed by the options and data for the replies. The buffer should be large enough to hold at least
///                  one <b>ICMP_ECHO_REPLY</b> structure plus <i>RequestSize</i> bytes of data.
///    ReplySize = The allocated size, in bytes, of the reply buffer. The buffer should be large enough to hold at least one
///                ICMP_ECHO_REPLY structure plus <i>RequestSize</i> bytes of data. This buffer should also be large enough to also
///                hold 8 more bytes of data (the size of an ICMP error message).
///    Timeout = The time, in milliseconds, to wait for replies.
///Returns:
///    The <b>IcmpSendEcho</b> function returns the number of ICMP_ECHO_REPLY structures stored in the
///    <i>ReplyBuffer</i>. The status of each reply is contained in the structure. If the return value is zero, call
///    GetLastError for additional error information. If the function fails, the extended error code returned by
///    GetLastError can be one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The data area
///    passed to a system call is too small. This error is returned if the <i>ReplySize</i> parameter indicates that the
///    buffer pointed to by the <i>ReplyBuffer</i> parameter is too small. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed to the
///    function. This error is returned if the <i>IcmpHandle</i> parameter contains an invalid handle. This error can
///    also be returned if the <i>ReplySize</i> parameter specifies a value less than the size of an ICMP_ECHO_REPLY
///    structure. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> Not enough memory is available to complete the operation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not supported. This error is
///    returned if no IPv4 stack is on the local computer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>IP_BUF_TOO_SMALL</b></dt> </dl> </td> <td width="60%"> The size of the <i>ReplyBuffer</i> specified in the
///    <i>ReplySize</i> parameter was too small. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl>
///    </td> <td width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr>
///    </table>
///    
@DllImport("IPHLPAPI")
uint IcmpSendEcho(HANDLE IcmpHandle, uint DestinationAddress, void* RequestData, ushort RequestSize, 
                  ip_option_information* RequestOptions, void* ReplyBuffer, uint ReplySize, uint Timeout);

///The <b>IcmpSendEcho2</b> function sends an IPv4 ICMP echo request and returns either immediately (if <i>Event</i> or
///<i>ApcRoutine</i> is non-<b>NULL</b>) or returns after the specified time-out. The <i>ReplyBuffer</i> contains the
///ICMP echo responses, if any.
///Params:
///    IcmpHandle = The open handle returned by the ICMPCreateFile function.
///    Event = An event to be signaled whenever an ICMP response arrives. If this parameter is specified, it requires a handle
///            to a valid event object. Use the CreateEvent or CreateEventEx function to create this event object. For more
///            information on using events, see Event Objects.
///    ApcRoutine = The routine that is called when the calling thread is in an alertable thread and an ICMPv4 reply arrives. On
///                 Windows Vista and later, <b>PIO_APC_ROUTINE_DEFINED</b> must be defined to force the datatype for this parameter
///                 to <b>PIO_APC_ROUTINE</b> rather than <b>FARPROC</b>. On Windows Server 2003, Windows XP, and Windows 2000,
///                 <b>PIO_APC_ROUTINE_DEFINED</b> must not be defined to force the datatype for this parameter to <b>FARPROC</b>.
///    ApcContext = An optional parameter passed to the callback routine specified in the <i>ApcRoutine</i> parameter whenever an
///                 ICMP response arrives or an error occurs.
///    DestinationAddress = The IPv4 destination of the echo request, in the form of an IPAddr structure.
///    RequestData = A pointer to a buffer that contains data to send in the request.
///    RequestSize = The size, in bytes, of the request data buffer pointed to by the <i>RequestData</i> parameter.
///    RequestOptions = A pointer to the IP header options for the request, in the form of an IP_OPTION_INFORMATION structure. On a
///                     64-bit platform, this parameter is in the form for an IP_OPTION_INFORMATION32 structure. This parameter may be
///                     <b>NULL</b> if no IP header options need to be specified.
///    ReplyBuffer = A pointer to a buffer to hold any replies to the request. Upon return, the buffer contains an array of
///                  ICMP_ECHO_REPLY structures followed by options and data. The buffer must be large enough to hold at least one
///                  <b>ICMP_ECHO_REPLY</b> structure plus <i>RequestSize</i> bytes of data. This buffer should also be large enough
///                  to also hold 8 more bytes of data (the size of an ICMP error message) plus space for an <b>IO_STATUS_BLOCK</b>
///                  structure.
///    ReplySize = The allocated size, in bytes, of the reply buffer. The buffer should be large enough to hold at least one
///                ICMP_ECHO_REPLY structure plus <i>RequestSize</i> bytes of data. This buffer should also be large enough to also
///                hold 8 more bytes of data (the size of an ICMP error message) plus space for an <b>IO_STATUS_BLOCK</b> structure.
///    Timeout = The time, in milliseconds, to wait for replies.
///Returns:
///    When called synchronously, the <b>IcmpSendEcho2</b> function returns the number of replies received and stored in
///    <i>ReplyBuffer</i>. If the return value is zero, call GetLastError for extended error information. When called
///    asynchronously, the <b>IcmpSendEcho2</b> function returns ERROR_IO_PENDING to indicate the operation is in
///    progress. The results can be retrieved later when the event specified in the <i>Event</i> parameter signals or
///    the callback function in the <i>ApcRoutine</i> parameter is called. If the return value is zero, call
///    GetLastError for extended error information. If the function fails, the extended error code returned by
///    GetLastError can be one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid
///    parameter was passed to the function. This error is returned if the <i>IcmpHandle</i> parameter contains an
///    invalid handle. This error can also be returned if the <i>ReplySize</i> parameter specifies a value less than the
///    size of an ICMP_ECHO_REPLY structure. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_IO_PENDING</b></dt>
///    </dl> </td> <td width="60%"> The operation is in progress. This value is returned by a successful asynchronous
///    call to IcmpSendEcho2 and is not an indication of an error. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available to complete
///    the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td
///    width="60%"> The request is not supported. This error is returned if no IPv4 stack is on the local computer.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IP_BUF_TOO_SMALL</b></dt> </dl> </td> <td width="60%"> The size of
///    the <i>ReplyBuffer</i> specified in the <i>ReplySize</i> parameter was too small. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message
///    string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint IcmpSendEcho2(HANDLE IcmpHandle, HANDLE Event, FARPROC ApcRoutine, void* ApcContext, uint DestinationAddress, 
                   void* RequestData, ushort RequestSize, ip_option_information* RequestOptions, void* ReplyBuffer, 
                   uint ReplySize, uint Timeout);

///The <b>IcmpSendEcho2Ex</b> function sends an IPv4 ICMP echo request and returns either immediately (if <i>Event</i>
///or <i>ApcRoutine</i> is non-<b>NULL</b>) or returns after the specified time-out. The <i>ReplyBuffer</i> contains the
///ICMP responses, if any.
///Params:
///    IcmpHandle = An open handle returned by the ICMPCreateFile function.
///    Event = An event to be signaled whenever an ICMP response arrives. If this parameter is specified, it requires a handle
///            to a valid event object. Use the CreateEvent or CreateEventEx function to create this event object. For more
///            information on using events, see Event Objects.
///    ApcRoutine = The routine that is called when the calling thread is in an alertable thread and an ICMP reply arrives.
///                 <b>PIO_APC_ROUTINE_DEFINED</b> must be defined to force the datatype for this parameter to <b>PIO_APC_ROUTINE</b>
///                 rather than <b>FARPROC</b>.
///    ApcContext = An optional parameter passed to the callback routine specified in the <i>ApcRoutine</i> parameter whenever an
///                 ICMP response arrives or an error occurs.
///    SourceAddress = The IPv4 source address on which to issue the echo request. This address is in the form of an IPAddr structure.
///    DestinationAddress = The IPv4 destination address for the echo request. This address is in the form of an IPAddr structure.
///    RequestData = A pointer to a buffer that contains data to send in the request.
///    RequestSize = The size, in bytes, of the request data buffer pointed to by the <i>RequestData</i> parameter.
///    RequestOptions = A pointer to the IP header options for the request, in the form of an IP_OPTION_INFORMATION structure. On a
///                     64-bit platform, this parameter is in the form for an IP_OPTION_INFORMATION32 structure. This parameter may be
///                     <b>NULL</b> if no IP header options need to be specified.
///    ReplyBuffer = A pointer to a buffer to hold any replies to the request. Upon return, the buffer contains an array of
///                  ICMP_ECHO_REPLY structures followed by options and data. The buffer must be large enough to hold at least one
///                  <b>ICMP_ECHO_REPLY</b> structure plus <i>RequestSize</i> bytes of data. This buffer should also be large enough
///                  to also hold 8 more bytes of data (the size of an ICMP error message) plus space for an <b>IO_STATUS_BLOCK</b>
///                  structure.
///    ReplySize = The allocated size, in bytes, of the reply buffer. The buffer should be large enough to hold at least one
///                ICMP_ECHO_REPLY structure plus <i>RequestSize</i> bytes of data. This buffer should also be large enough to also
///                hold 8 more bytes of data (the size of an ICMP error message) plus space for an <b>IO_STATUS_BLOCK</b> structure.
///    Timeout = The time, in milliseconds, to wait for replies.
///Returns:
///    When called synchronously, the <b>IcmpSendEcho2Ex</b> function returns the number of replies received and stored
///    in <i>ReplyBuffer</i>. If the return value is zero, call GetLastError for extended error information. When called
///    asynchronously, the <b>IcmpSendEcho2Ex</b> function returns ERROR_IO_PENDING to indicate the operation is in
///    progress. The results can be retrieved later when the event specified in the <i>Event</i> parameter signals or
///    the callback function in the <i>ApcRoutine</i> parameter is called. If the return value is zero, call
///    GetLastError for extended error information. If the function fails, the extended error code returned by
///    GetLastError can be one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid
///    parameter was passed to the function. This error is returned if the <i>IcmpHandle</i> parameter contains an
///    invalid handle. This error can also be returned if the <i>ReplySize</i> parameter specifies a value less than the
///    size of an ICMP_ECHO_REPLY structure. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_IO_PENDING</b></dt>
///    </dl> </td> <td width="60%"> The operation is in progress. This value is returned by a successful asynchronous
///    call to IcmpSendEcho2Ex and is not an indication of an error. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available to complete
///    the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td
///    width="60%"> The request is not supported. This error is returned if no IPv4 stack is on the local computer.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>IP_BUF_TOO_SMALL</b></dt> </dl> </td> <td width="60%"> The size of
///    the <i>ReplyBuffer</i> specified in the <i>ReplySize</i> parameter was too small. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message
///    string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint IcmpSendEcho2Ex(HANDLE IcmpHandle, HANDLE Event, FARPROC ApcRoutine, void* ApcContext, uint SourceAddress, 
                     uint DestinationAddress, void* RequestData, ushort RequestSize, 
                     ip_option_information* RequestOptions, void* ReplyBuffer, uint ReplySize, uint Timeout);

///The <b>Icmp6SendEcho2</b> function sends an IPv6 ICMPv6 echo request and returns either immediately (if <i>Event</i>
///or <i>ApcRoutine</i> is non-<b>NULL</b>) or returns after the specified time-out. The <i>ReplyBuffer</i> contains the
///IPv6 ICMPv6 echo response, if any.
///Params:
///    IcmpHandle = The open handle returned by Icmp6CreateFile.
///    Event = An event to be signaled whenever an ICMPv6 response arrives. If this parameter is specified, it requires a handle
///            to a valid event object. Use the CreateEvent or CreateEventEx function to create this event object. For more
///            information on using events, see Event Objects.
///    ApcRoutine = The routine that is called when the calling thread is in an alertable thread and an ICMPv6 reply arrives. On
///                 Windows Vista and later, <b>PIO_APC_ROUTINE_DEFINED</b> must be defined to force the datatype for this parameter
///                 to <b>PIO_APC_ROUTINE</b> rather than <b>FARPROC</b>. On Windows Server 2003 and Windows XP,
///                 <b>PIO_APC_ROUTINE_DEFINED</b> must not be defined to force the datatype for this parameter to <b>FARPROC</b>.
///    ApcContext = An optional parameter passed to the callback routine specified in the <i>ApcRoutine</i> parameter whenever an
///                 ICMPv6 response arrives or an error occurs.
///    SourceAddress = The IPv6 source address on which to issue the echo request, in the form of a sockaddr structure.
///    DestinationAddress = The IPv6 destination address of the echo request, in the form of a sockaddr structure.
///    RequestData = A pointer to a buffer that contains data to send in the request.
///    RequestSize = The size, in bytes, of the request data buffer pointed to by the <i>RequestData</i> parameter.
///    RequestOptions = A pointer to the IPv6 header options for the request, in the form of an IP_OPTION_INFORMATION structure. On a
///                     64-bit platform, this parameter is in the form for an IP_OPTION_INFORMATION32 structure. This parameter may be
///                     NULL if no IP header options need to be specified. <div class="alert"><b>Note</b> On Windows Server 2003 and
///                     Windows XP, the <i>RequestOptions</i> parameter is not optional and must not be NULL and only the <b>Ttl</b> and
///                     <b>Flags</b> members are used.</div> <div> </div>
///    ReplyBuffer = A pointer to a buffer to hold replies to the request. Upon return, the buffer contains an ICMPV6_ECHO_REPLY
///                  structure followed by the message body from the ICMPv6 echo response reply data. The buffer must be large enough
///                  to hold at least one <b>ICMPV6_ECHO_REPLY</b> structure plus the number of bytes of data specified in the
///                  <i>RequestSize</i> parameter. This buffer should also be large enough to also hold 8 more bytes of data (the size
///                  of an ICMP error message) plus space for an <b>IO_STATUS_BLOCK</b> structure.
///    ReplySize = The size, in bytes, of the reply buffer pointed to by the <i>ReplyBuffer</i> parameter. This buffer should be
///                large enough to hold at least one ICMPV6_ECHO_REPLY structure plus <i>RequestSize</i> bytes of data. This buffer
///                should also be large enough to also hold 8 more bytes of data (the size of an ICMP error message) plus space for
///                an <b>IO_STATUS_BLOCK</b> structure.
///    Timeout = The time, in milliseconds, to wait for replies. This parameter is only used if the <b>Icmp6SendEcho2</b> function
///              is called synchronously. So this parameter is not used if either the <i>ApcRoutine</i> or <i>Event</i>parameter
///              are not <b>NULL</b>.
///Returns:
///    When called synchronously, the <b>Icmp6SendEcho2</b> function returns the number of replies received and stored
///    in <i>ReplyBuffer</i>. If the return value is zero, call GetLastError for extended error information. When called
///    asynchronously, the <b>Icmp6SendEcho2</b> function returns ERROR_IO_PENDING to indicate the operation is in
///    progress. The results can be retrieved later when the event specified in the <i>Event</i> parameter signals or
///    the callback function in the <i>ApcRoutine</i> parameter is called. If the return value is zero, call
///    GetLastError for extended error information. If the function fails, the extended error code returned by
///    GetLastError can be one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_CALL_NOT_IMPLEMENTED</b></dt> </dl> </td> <td width="60%"> This function
///    is not supported on this system. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt>
///    </dl> </td> <td width="60%"> The data area passed to a system call is too small. This error is returned if the
///    <i>ReplySize</i> parameter indicates that the buffer pointed to by the <i>ReplyBuffer</i> parameter is too small.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One
///    of the parameters is invalid. This error is returned if the <i>IcmpHandle</i> parameter contains an invalid
///    handle. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_IO_PENDING</b></dt> </dl> </td> <td width="60%"> The
///    operation is in progress. This value is returned by a successful asynchronous call to Icmp6SendEcho2 and is not
///    an indication of an error. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl>
///    </td> <td width="60%"> Not enough memory is available to process this command. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not supported. This error is
///    returned if no IPv6 stack is on the local computer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>IP_BUF_TOO_SMALL</b></dt> </dl> </td> <td width="60%"> The size of the <i>ReplyBuffer</i> specified in the
///    <i>ReplySize</i> parameter was too small. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl>
///    </td> <td width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr>
///    </table>
///    
@DllImport("IPHLPAPI")
uint Icmp6SendEcho2(HANDLE IcmpHandle, HANDLE Event, FARPROC ApcRoutine, void* ApcContext, 
                    SOCKADDR_IN6_LH* SourceAddress, SOCKADDR_IN6_LH* DestinationAddress, void* RequestData, 
                    ushort RequestSize, ip_option_information* RequestOptions, void* ReplyBuffer, uint ReplySize, 
                    uint Timeout);

///The <b>IcmpParseReplies</b> function parses the reply buffer provided and returns the number of ICMP echo request
///responses found.
///Params:
///    ReplyBuffer = The buffer passed to IcmpSendEcho2. This is rewritten to hold an array of ICMP_ECHO_REPLY structures, its type is
///                  <b>PICMP_ECHO_REPLY</b>. On a 64-bit plaform, this buffer is rewritten to hold an array of ICMP_ECHO_REPLY32
///                  structures, its type is <b>PICMP_ECHO_REPLY32</b>.
///    ReplySize = The size, in bytes, of the buffer pointed to by the <i>ReplyBuffer</i> parameter.
///Returns:
///    The <b>IcmpParseReplies</b> function returns the number of ICMP responses found on success. The function returns
///    zero on error. Call GetLastError for additional error information.
///    
@DllImport("IPHLPAPI")
uint IcmpParseReplies(void* ReplyBuffer, uint ReplySize);

///The <b>Icmp6ParseReplies</b> function parses the reply buffer provided and returns an IPv6 ICMPv6 echo response reply
///if found.
///Params:
///    ReplyBuffer = A pointer to the buffer passed to the Icmp6SendEcho2 function. This parameter is points to an ICMPV6_ECHO_REPLY
///                  structure to hold the response.
///    ReplySize = The size, in bytes, of the buffer pointed to by the <i>ReplyBuffer</i> parameter.
///Returns:
///    The <b>Icmp6ParseReplies</b> function returns 1 on success. In this case, the <b>Status</b> member in the
///    ICMPV6_ECHO_REPLY structure pointed to by the <i>ReplyBuffer</i> parameter will be either <b>IP_SUCCESS</b> if
///    the target node responded or <b>IP_TTL_EXPIRED_TRANSIT</b>. If the return value is zero, extended error
///    information is available through GetLastError. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_GEN_FAILURE</b></dt> </dl> </td> <td width="60%"> A general failure occurred.
///    This error is returned if the <i>ReplyBuffer</i> parameter is a <b>NULL</b> pointer or the <i>ReplySize </i>
///    parameter is zero. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use
///    FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint Icmp6ParseReplies(void* ReplyBuffer, uint ReplySize);

///The <b>GetNumberOfInterfaces</b> functions retrieves the number of interfaces on the local computer.
///Params:
///    pdwNumIf = Pointer to a <b>DWORD</b> variable that receives the number of interfaces on the local computer.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, use FormatMessage to obtain the
///    message string for the returned error.
///    
@DllImport("IPHLPAPI")
uint GetNumberOfInterfaces(uint* pdwNumIf);

///The <b>GetIfEntry</b> function retrieves information for the specified interface on the local computer.
///Params:
///    pIfRow = A pointer to a MIB_IFROW structure that, on successful return, receives information for an interface on the local
///             computer. On input, set the <b>dwIndex</b> member of <b>MIB_IFROW</b> to the index of the interface for which to
///             retrieve information. The value for the <b>dwIndex</b> must be retrieved by a previous call to the GetIfTable,
///             GetIfTable2, or GetIfTable2Ex function.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CAN_NOT_COMPLETE</b></dt> </dl> </td> <td width="60%"> The request could not be completed. This is
///    an internal error. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td
///    width="60%"> The data is invalid. This error is returned if the network interface index specified by the
///    <b>dwIndex</b> member of the MIB_IFROW structure pointed to by the <i>pIfRow</i> parameter is not a valid
///    interface index on the local computer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed to the
///    function. This error is returned if a <b>NULL</b> pointer is passed in the <i>pIfRow</i> parameter. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified interface
///    could not be found. This error is returned if the network interface index specified by the <b>dwIndex</b> member
///    of the MIB_IFROW structure pointed to by the <i>pIfRow</i> parameter could not be found. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not supported.
///    This error is returned if IPv4 is not configured on the local computer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the
///    returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetIfEntry(MIB_IFROW* pIfRow);

///The <b>GetIfTable</b> function retrieves the MIB-II interface table.
///Params:
///    pIfTable = A pointer to a buffer that receives the interface table as a MIB_IFTABLE structure.
///    pdwSize = On input, specifies the size in bytes of the buffer pointed to by the <i>pIfTable</i> parameter. On output, if
///              the buffer is not large enough to hold the returned interface table, the function sets this parameter equal to
///              the required buffer size in bytes.
///    bOrder = A Boolean value that specifies whether the returned interface table should be sorted in ascending order by
///             interface index. If this parameter is <b>TRUE</b>, the table is sorted.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer pointed to by the
///    <i>pIfTable</i> parameter is not large enough. The required size is returned in the <b>DWORD</b> variable pointed
///    to by the <i>pdwSize</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>pdwSize</i> parameter is <b>NULL</b>,
///    or GetIfTable is unable to write to the memory pointed to by the <i>pdwSize</i> parameter. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This function is not supported
///    on the operating system in use on the local system. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt>
///    </dl> </td> <td width="60%"> Use the FormatMessage function to obtain the message string for the returned error.
///    </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetIfTable(MIB_IFTABLE* pIfTable, uint* pdwSize, BOOL bOrder);

///The <b>GetIpAddrTable</b> function retrieves the interface–to–IPv4 address mapping table.
///Params:
///    pIpAddrTable = A pointer to a buffer that receives the interface–to–IPv4 address mapping table as a MIB_IPADDRTABLE
///                   structure.
///    pdwSize = On input, specifies the size in bytes of the buffer pointed to by the <i>pIpAddrTable</i> parameter. On output,
///              if the buffer is not large enough to hold the returned mapping table, the function sets this parameter equal to
///              the required buffer size in bytes.
///    bOrder = If this parameter is <b>TRUE</b>, then the returned mapping table is sorted in ascending order by IPv4 address.
///             The sorting is performed in network byte order. For example, 10.0.0.255 comes immediately before 10.0.1.0.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer pointed to by the
///    <i>pIpAddrTable</i> parameter is not large enough. The required size is returned in the <b>DWORD</b> variable
///    pointed to by the <i>pdwSize</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>pdwSize</i> parameter is <b>NULL</b>,
///    or GetIpAddrTable is unable to write to the memory pointed to by the <i>pdwSize</i> parameter. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This function is not
///    supported on the operating system in use on the local system. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the
///    returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetIpAddrTable(MIB_IPADDRTABLE* pIpAddrTable, uint* pdwSize, BOOL bOrder);

///The <b>GetIpNetTable</b> function retrieves the IPv4 to physical address mapping table.
///Params:
///    IpNetTable = A pointer to a buffer that receives the IPv4 to physical address mapping table as a MIB_IPNETTABLE structure.
///    SizePointer = On input, specifies the size in bytes of the buffer pointed to by the <i>pIpNetTable</i> parameter. On output, if
///                  the buffer is not large enough to hold the returned mapping table, the function sets this parameter equal to the
///                  required buffer size in bytes.
///    Order = A Boolean value that specifies whether the returned mapping table should be sorted in ascending order by IP
///            address. If this parameter is <b>TRUE</b>, the table is sorted.
///Returns:
///    If the function succeeds, the return value is NO_ERROR or ERROR_NO_DATA. If the function fails or does not return
///    any data, the return value is one of the following error codes. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The buffer pointed to by the <i>pIpNetTable</i> parameter is not large enough. The required size is
///    returned in the <b>DWORD</b> variable pointed to by the <i>pdwSize</i> parameter. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was
///    passed to the function. This error is returned if the <i>pdwSize</i> parameter is <b>NULL</b>, or GetIpNetTable
///    is unable to write to the memory pointed to by the <i>pdwSize</i> parameter. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_NO_DATA</b></dt> </dl> </td> <td width="60%"> There is no data to return. The IPv4 to physical
///    address mapping table is empty. This return value indicates that the call to the GetIpNetTable function
///    succeeded, but there was no data to return. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The IPv4 transport is not configured on the
///    local computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use
///    FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetIpNetTable(MIB_IPNETTABLE* IpNetTable, uint* SizePointer, BOOL Order);

///The <b>GetIpForwardTable</b> function retrieves the IPv4 routing table.
///Params:
///    pIpForwardTable = A pointer to a buffer that receives the IPv4 routing table as a MIB_IPFORWARDTABLE structure.
///    pdwSize = On input, specifies the size in bytes of the buffer pointed to by the <i>pIpForwardTable</i> parameter. On
///              output, if the buffer is not large enough to hold the returned routing table, the function sets this parameter
///              equal to the required buffer size in bytes.
///    bOrder = A Boolean value that specifies whether the returned table should be sorted. If this parameter is <b>TRUE</b>, the
///             table is sorted in the order of: <ol> <li>Destination address</li> <li>Protocol that generated the route</li>
///             <li>Multipath routing policy</li> <li>Next-hop address</li> </ol>
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b> (zero). If the function fails, the return value is
///    one of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer pointed to by
///    the <i>pIpForwardTable</i> parameter is not large enough. The required size is returned in the <b>DWORD</b>
///    variable pointed to by the <i>pdwSize</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>pdwSize</i> parameter is <b>NULL</b>,
///    or GetIpForwardTable is unable to write to the memory pointed to by the <i>pdwSize</i> parameter. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_DATA</b></dt> </dl> </td> <td width="60%"> No data is available. This
///    error is returned if there are no routes present on the local computer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This function is not supported on the operating
///    system in use on the local system. This error is returned if there is no IP stack installed on the local
///    computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use
///    FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetIpForwardTable(MIB_IPFORWARDTABLE* pIpForwardTable, uint* pdwSize, BOOL bOrder);

///The <b>GetTcpTable</b> function retrieves the IPv4 TCP connection table.
///Params:
///    TcpTable = A pointer to a buffer that receives the TCP connection table as a MIB_TCPTABLE structure.
///    SizePointer = On input, specifies the size in bytes of the buffer pointed to by the <i>pTcpTable</i> parameter. On output, if
///                  the buffer is not large enough to hold the returned connection table, the function sets this parameter equal to
///                  the required buffer size in bytes. On the Windows SDK released for Windows Vista and later, the data type for
///                  this parameter is changed to a <b>PULONG</b> which is equivalent to a <b>PDWORD</b>.
///    Order = A Boolean value that specifies whether the TCP connection table should be sorted. If this parameter is
///            <b>TRUE</b>, the table is sorted in the order of: <ol> <li>Local IP address</li> <li>Local port</li> <li>Remote
///            IP address</li> <li>Remote port</li> </ol>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer pointed to by the
///    <i>pTcpTable</i> parameter is not large enough. The required size is returned in the <b>DWORD</b> variable
///    pointed to by the <i>pdwSize</i> parameter. This error is also returned if the <i>pTcpTable</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The <i>pdwSize</i> parameter is <b>NULL</b>, or GetTcpTable is unable to write to the memory pointed
///    to by the <i>pdwSize</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt>
///    </dl> </td> <td width="60%"> This function is not supported on the operating system in use on the local system.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>STATUS_UNSUCCESSFUL</b></dt> </dl> </td> <td width="60%"> If you
///    receive this return code then calling the function again is usually enough to clear the issue and get the desired
///    result. This return code can be a consequence of the system being under high load. For example, if the size of
///    the TCP connection table changes by more than 2 additional items 3 consecutive times. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message
///    string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetTcpTable(MIB_TCPTABLE* TcpTable, uint* SizePointer, BOOL Order);

///The <b>GetExtendedTcpTable</b> function retrieves a table that contains a list of TCP endpoints available to the
///application.
///Params:
///    pTcpTable = A pointer to the table structure that contains the filtered TCP endpoints available to the application. For
///                information about how to determine the type of table returned based on specific input parameter combinations, see
///                the Remarks section later in this document.
///    pdwSize = The estimated size of the structure returned in <i>pTcpTable</i>, in bytes. If this value is set too small,
///              <b>ERROR_INSUFFICIENT_BUFFER</b> is returned by this function, and this field will contain the correct size of
///              the structure.
///    bOrder = A value that specifies whether the TCP connection table should be sorted. If this parameter is set to
///             <b>TRUE</b>, the TCP endpoints in the table are sorted in ascending order, starting with the lowest local IP
///             address. If this parameter is set to <b>FALSE</b>, the TCP endpoints in the table appear in the order in which
///             they were retrieved. The following values are compared (as listed) when ordering the TCP endpoints:<ol> <li>Local
///             IP address</li> <li>Local scope ID (applicable when the <i>ulAf</i> parameter is set to AF_INET6)</li> <li>Local
///             TCP port</li> <li>Remote IP address</li> <li>Remote scope ID (applicable when the <i>ulAf</i> parameter is set to
///             AF_INET6)</li> <li>Remote TCP port</li> </ol>
///    ulAf = The version of IP used by the TCP endpoints. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///           width="40%"><a id="AF_INET"></a><a id="af_inet"></a><dl> <dt><b>AF_INET</b></dt> </dl> </td> <td width="60%">
///           IPv4 is used. </td> </tr> <tr> <td width="40%"><a id="AF_INET6"></a><a id="af_inet6"></a><dl>
///           <dt><b>AF_INET6</b></dt> </dl> </td> <td width="60%"> IPv6 is used. </td> </tr> </table>
///    TableClass = The type of the TCP table structure to retrieve. This parameter can be one of the values from the TCP_TABLE_CLASS
///                 enumeration. On the Windows SDK released for Windows Vista and later, the organization of header files has
///                 changed and the TCP_TABLE_CLASS enumeration is defined in the <i>Iprtrmib.h</i> header file, not in the
///                 <i>Iphlpapi.h</i> header file. The TCP_TABLE_CLASS enumeration value is combined with the value of the
///                 <i>ulAf</i> parameter to determine the extended TCP information to retrieve.
///    Reserved = Reserved. This value must be zero.
///Returns:
///    If the call is successful, the value <b>NO_ERROR</b> is returned. If the function fails, the return value is one
///    of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> An insufficient amount of space was
///    allocated for the table. The size of the table is returned in the <i>pdwSize</i> parameter, and must be used in a
///    subsequent call to this function in order to successfully retrieve the table. This error is also returned if the
///    <i>pTcpTable</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed to the
///    function. This error is returned if the <i>TableClass</i> parameter contains a value that is not defined in the
///    TCP_TABLE_CLASS enumeration. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetExtendedTcpTable(void* pTcpTable, uint* pdwSize, BOOL bOrder, uint ulAf, TCP_TABLE_CLASS TableClass, 
                         uint Reserved);

///The <b>GetOwnerModuleFromTcpEntry</b> function retrieves data about the module that issued the context bind for a
///specific IPv4 TCP endpoint in a MIB table row.
///Params:
///    pTcpEntry = A pointer to a MIB_TCPROW_OWNER_MODULE structure that contains the IPv4 TCP endpoint entry used to obtain the
///                owner module.
///    Class = A TCPIP_OWNER_MODULE_INFO_CLASS enumeration value that indicates the type of data to obtain regarding the owner
///            module. The <b>TCPIP_OWNER_MODULE_INFO_CLASS</b> enumeration is defined in the <i>Iprtrmib.h</i> header file.
///            This parameter must be set to <b>TCPIP_OWNER_MODULE_INFO_BASIC</b>.
///    pBuffer = A pointer a buffer that contains a TCPIP_OWNER_MODULE_BASIC_INFO structure with the owner module data. The type
///              of data returned in this buffer is indicated by the value of the <i>Class</i> parameter. The following structures
///              are used for the data in <i>Buffer</i> when <i>Class</i> is set to the corresponding value. <table> <tr>
///              <th><i>Class</i> enumeration value</th> <th><i>Buffer</i> data format</th> </tr> <tr>
///              <td>TCPIP_OWNER_MODULE_BASIC_INFO</td> <td> TCPIP_OWNER_MODULE_BASIC_INFO </td> </tr> </table>
///    pdwSize = The estimated size, in bytes, of the structure returned in <i>Buffer</i>. If this value is set too small,
///              <b>ERROR_INSUFFICIENT_BUFFER</b> is returned by this function, and this field will contain the correct size of
///              the buffer. The size required is the size of the corresponding structure plus an additional number of bytes equal
///              to the length of data pointed to in the structure (for example, the name and path strings).
///Returns:
///    If the function call is successful, the value <b>NO_ERROR</b> is returned. If the function fails, the return
///    value is one of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> Insufficient space was
///    allocated for the table. The size of the table is returned in the <i>pdwSize</i> parameter, and must be used in a
///    subsequent call to this function in order to successfully retrieve the table. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is incorrect. This value is
///    returned if either of the <i>pTcpEntry</i> or <i>pdwSize</i> parameters are <b>NULL</b>. This value is also
///    returned if the <i>Class</i> parameter is not equal to <b>TCPIP_OWNER_MODULE_INFO_BASIC</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is
///    available to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl>
///    </td> <td width="60%"> A element was no found. This value is returned if the <b>dwOwningPid</b> member of the
///    MIB_TCPROW_OWNER_MODULE structure pointed to by the <i>pTcpEntry</i> parameter was zero or could not be found.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_PARTIAL_COPY</b></dt> </dl> </td> <td width="60%"> Only part
///    of a request was completed. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetOwnerModuleFromTcpEntry(MIB_TCPROW_OWNER_MODULE* pTcpEntry, TCPIP_OWNER_MODULE_INFO_CLASS Class, 
                                void* pBuffer, uint* pdwSize);

///The <b>GetUdpTable</b> function retrieves the IPv4 User Datagram Protocol (UDP) listener table.
///Params:
///    UdpTable = A pointer to a buffer that receives the IPv4 UDP listener table as a MIB_UDPTABLE structure.
///    SizePointer = On input, specifies the size in bytes of the buffer pointed to by the <i>UdpTable</i> parameter. On output, if
///                  the buffer is not large enough to hold the returned listener table, the function sets this parameter equal to the
///                  required buffer size in bytes. On the Windows SDK released for Windows Vista and later, the data type for this
///                  parameter is changed to a <b>PULONG</b> which is equivalent to a <b>PDWORD</b>.
///    Order = A Boolean value that specifies whether the returned UDP listener table should be sorted. If this parameter is
///            <b>TRUE</b>, the table is sorted in the order of: <ol> <li>Local IP address</li> <li>Local port</li> </ol>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer pointed to by the
///    <i>pUdpTable</i> parameter is not large enough. The required size is returned in the <b>ULONG</b> variable
///    pointed to by the <i>pdwSize</i> parameter. This error is also returned if the <i>pUdpTable</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The <i>pdwSize</i> parameter is <b>NULL</b>, or GetUdpTable is unable to write to the memory pointed
///    to by the <i>pdwSize</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt>
///    </dl> </td> <td width="60%"> This function is not supported on the operating system in use on the local system.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to
///    obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetUdpTable(MIB_UDPTABLE* UdpTable, uint* SizePointer, BOOL Order);

///The <b>GetExtendedUdpTable</b> function retrieves a table that contains a list of UDP endpoints available to the
///application.
///Params:
///    pUdpTable = A pointer to the table structure that contains the filtered UDP endpoints available to the application. For
///                information about how to determine the type of table returned based on specific input parameter combinations, see
///                the Remarks section later in this document.
///    pdwSize = The estimated size of the structure returned in <i>pUdpTable</i>, in bytes. If this value is set too small,
///              <b>ERROR_INSUFFICIENT_BUFFER</b> is returned by this function, and this field will contain the correct size of
///              the structure.
///    bOrder = A value that specifies whether the UDP endpoint table should be sorted. If this parameter is set to <b>TRUE</b>,
///             the UDP endpoints in the table are sorted in ascending order, starting with the lowest local IP address. If this
///             parameter is set to <b>FALSE</b>, the UDP endpoints in the table appear in the order in which they were
///             retrieved. The following values are compared as listed when ordering the UDP endpoints: <ol> <li>Local IP
///             address</li> <li>Local scope ID (applicable when the <i>ulAf</i> parameter is set to AF_INET6)</li> <li>Local UDP
///             port</li> </ol>
///    ulAf = The version of IP used by the UDP endpoint. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///           width="40%"><a id="AF_INET"></a><a id="af_inet"></a><dl> <dt><b>AF_INET</b></dt> </dl> </td> <td width="60%">
///           IPv4 is used. </td> </tr> <tr> <td width="40%"><a id="AF_INET6"></a><a id="af_inet6"></a><dl>
///           <dt><b>AF_INET6</b></dt> </dl> </td> <td width="60%"> IPv6 is used. </td> </tr> </table>
///    TableClass = The type of the UDP table structure to retrieve. This parameter can be one of the values from the UDP_TABLE_CLASS
///                 enumeration. On the Windows SDK released for Windows Vista and later, the organization of header files has
///                 changed and the UDP_TABLE_CLASS enumeration is defined in the <i>Iprtrmib.h</i> header file, not in the
///                 <i>Iphlpapi.h</i> header file. The UDP_TABLE_CLASS enumeration value is combined with the value of the
///                 <i>ulAf</i> parameter to determine the extended UDP information to retrieve.
///    Reserved = Reserved. This value must be zero.
///Returns:
///    If the call is successful, the value <b>NO_ERROR</b> is returned. If the function fails, the return value is one
///    of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> An insufficient amount of space was
///    allocated for the table. The size of the table is returned in the <i>pdwSize</i> parameter, and must be used in a
///    subsequent call to this function in order to successfully retrieve the table. This error is also returned if the
///    <i>pUdpTable</i> parameter is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed to the
///    function. This error is returned if the <i>TableClass</i> parameter contains a value that is not defined in the
///    UDP_TABLE_CLASS enumeration. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetExtendedUdpTable(void* pUdpTable, uint* pdwSize, BOOL bOrder, uint ulAf, UDP_TABLE_CLASS TableClass, 
                         uint Reserved);

///The <b>GetOwnerModuleFromUdpEntry</b> function retrieves data about the module that issued the context bind for a
///specific IPv4 UDP endpoint in a MIB table row.
///Params:
///    pUdpEntry = A pointer to a MIB_UDPROW_OWNER_MODULE structure that contains the IPv4 UDP endpoint entry used to obtain the
///                owner module.
///    Class = A TCPIP_OWNER_MODULE_INFO_CLASS enumeration value that indicates the type of data to obtain regarding the owner
///            module.
///    pBuffer = The buffer that contains a TCPIP_OWNER_MODULE_BASIC_INFO structure with the owner module data. The type of data
///              returned in this buffer is indicated by the value of the <i>Class</i> parameter. The following structures are
///              used for the data in <i>Buffer</i> when <i>Class</i> is set to the corresponding value. <table> <tr>
///              <th><i>Class</i> enumeration value</th> <th><i>Buffer</i> data format</th> </tr> <tr>
///              <td>TCPIP_OWNER_MODULE_BASIC_INFO</td> <td> TCPIP_OWNER_MODULE_BASIC_INFO </td> </tr> </table>
///    pdwSize = The estimated size, in bytes, of the structure returned in <i>Buffer</i>. If this value is set too small,
///              <b>ERROR_INSUFFICIENT_BUFFER</b> is returned by this function, and this field will contain the correct structure
///              size.
///Returns:
///    If the call is successful, the value <b>NO_ERROR</b> is returned. Otherwise, the following error is returned.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> Insufficient space was allocated for the
///    table. The size of the table is returned in the <i>pdwSize</i> parameter, and must be used in a subsequent call
///    to this function in order to successfully retrieve the table. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetOwnerModuleFromUdpEntry(MIB_UDPROW_OWNER_MODULE* pUdpEntry, TCPIP_OWNER_MODULE_INFO_CLASS Class, 
                                void* pBuffer, uint* pdwSize);

///The <b>GetTcpTable2</b> function retrieves the IPv4 TCP connection table.
///Params:
///    TcpTable = A pointer to a buffer that receives the TCP connection table as a MIB_TCPTABLE2 structure.
///    SizePointer = On input, specifies the size of the buffer pointed to by the <i>TcpTable</i> parameter. On output, if the buffer
///                  is not large enough to hold the returned connection table, the function sets this parameter equal to the required
///                  buffer size.
///    Order = A value that specifies whether the TCP connection table should be sorted. If this parameter is <b>TRUE</b>, the
///            table is sorted in the order of: <ol> <li>Local IP address</li> <li>Local port</li> <li>Remote IP address</li>
///            <li>Remote port</li> </ol>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer pointed to by the
///    <i>TcpTable</i> parameter is not large enough. The required size is returned in the <b>PULONG</b> variable
///    pointed to by the <i>SizePointer</i> parameter. This error is also returned if the <i>pTcpTable</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The <i>SizePointer</i> parameter is <b>NULL</b>, or GetTcpTable2 is unable to write to the memory
///    pointed to by the <i>SizePointer</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This function is not supported on the operating
///    system in use on the local system. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td
///    width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetTcpTable2(MIB_TCPTABLE2* TcpTable, uint* SizePointer, BOOL Order);

///The <b>GetTcp6Table</b> function retrieves the TCP connection table for IPv6.
///Params:
///    TcpTable = A pointer to a buffer that receives the TCP connection table for IPv6 as a MIB_TCP6TABLE structure.
///    SizePointer = On input, specifies the size in bytes of the buffer pointed to by the <i>TcpTable</i> parameter. On output, if
///                  the buffer is not large enough to hold the returned TCP connection table, the function sets this parameter equal
///                  to the required buffer size in bytes.
///    Order = A Boolean value that specifies whether the TCP connection table should be sorted. If this parameter is
///            <b>TRUE</b>, the table is sorted in ascending order, starting with the lowest local IP address. If this parameter
///            is <b>FALSE</b>, the table appears in the order in which they were retrieved. The following values are compared
///            (as listed) when ordering the TCP endpoints: <ol> <li>Local IPv6 address</li> <li>Local scope ID</li> <li>Local
///            port</li> <li>Remote IPv6 address</li> <li>Remote scope ID</li> <li>Remote port</li> </ol>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer pointed to by the
///    <i>TcpTable</i> parameter is not large enough. The required size is returned in the variable pointed to by the
///    <i>SizePointer</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt>
///    </dl> </td> <td width="60%"> The <i>SizePointer</i> parameter is <b>NULL</b>, or GetTcp6Table is unable to write
///    to the memory pointed to by the <i>SizePointer</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This function is not supported on the operating
///    system in use on the local system. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td
///    width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetTcp6Table(MIB_TCP6TABLE* TcpTable, uint* SizePointer, BOOL Order);

///The <b>GetTcp6Table2</b> function retrieves the TCP connection table for IPv6.
///Params:
///    TcpTable = A pointer to a buffer that receives the TCP connection table for IPv6 as a MIB_TCP6TABLE2 structure.
///    SizePointer = On input, specifies the size of the buffer pointed to by the <i>TcpTable</i> parameter. On output, if the buffer
///                  is not large enough to hold the returned TCP connection table, the function sets this parameter equal to the
///                  required buffer size.
///    Order = A value that specifies whether the TCP connection table should be sorted. If this parameter is <b>TRUE</b>, the
///            table is sorted in ascending order, starting with the lowest local IP address. If this parameter is <b>FALSE</b>,
///            the table appears in the order in which they were retrieved. The following values are compared (as listed) when
///            ordering the TCP endpoints: <ol> <li>Local IPv6 address</li> <li>Local scope ID</li> <li>Local port</li>
///            <li>Remote IPv6 address</li> <li>Remote scope ID</li> <li>Remote port</li> </ol>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer pointed to by the
///    <i>TcpTable</i> parameter is not large enough. The required size is returned in the variable pointed to by the
///    <i>SizePointer</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt>
///    </dl> </td> <td width="60%"> The <i>SizePointer</i> parameter is <b>NULL</b>, or GetTcp6Table2 is unable to write
///    to the memory pointed to by the <i>SizePointer</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This function is not supported on the operating
///    system in use on the local system. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td
///    width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetTcp6Table2(MIB_TCP6TABLE2* TcpTable, uint* SizePointer, BOOL Order);

///The <b>GetPerTcpConnectionEStats</b> function retrieves extended statistics for an IPv4 TCP connection.
///Params:
///    Row = A pointer to a MIB_TCPROW structure for an IPv4 TCP connection.
///    EstatsType = The type of extended statistics for TCP requested. This parameter determines the data and format of information
///                 that is returned in the <i>Rw</i>, <i>Rod</i>, and <i>Ros</i> parameters if the call is successful. This
///                 parameter can be one of the values from the TCP_ESTATS_TYPE enumeration type defined in the <i>Tcpestats.h</i>
///                 header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                 id="TcpConnectionEstatsSynOpts"></a><a id="tcpconnectionestatssynopts"></a><a
///                 id="TCPCONNECTIONESTATSSYNOPTS"></a><dl> <dt><b>TcpConnectionEstatsSynOpts</b></dt> </dl> </td> <td width="60%">
///                 This value requests SYN exchange information for a TCP connection. Only read-only static information is available
///                 for this enumeration value. If the <i>Ros</i> parameter was not <b>NULL</b> and the function succeeds, the buffer
///                 pointed to by the <i>Ros</i> parameter should contain a TCP_ESTATS_SYN_OPTS_ROS_v0 structure. </td> </tr> <tr>
///                 <td width="40%"><a id="TcpConnectionEstatsData"></a><a id="tcpconnectionestatsdata"></a><a
///                 id="TCPCONNECTIONESTATSDATA"></a><dl> <dt><b>TcpConnectionEstatsData</b></dt> </dl> </td> <td width="60%"> This
///                 value requests extended data transfer information for a TCP connection. Only read-only dynamic information and
///                 read/write information are available for this enumeration value. If the <i>Rw</i> parameter was not <b>NULL</b>
///                 and the function succeeds, the buffer pointed to by the <i>Rw</i> parameter should contain a
///                 TCP_ESTATS_DATA_RW_v0 structure. If extended data transfer information was enabled for this TCP connection, the
///                 <i>Rod</i> parameter was not <b>NULL</b>, and the function succeeds, the buffer pointed to by the <i>Rod</i>
///                 parameter should contain a TCP_ESTATS_DATA_ROD_v0 structure. </td> </tr> <tr> <td width="40%"><a
///                 id="TcpConnectionEstatsSndCong"></a><a id="tcpconnectionestatssndcong"></a><a
///                 id="TCPCONNECTIONESTATSSNDCONG"></a><dl> <dt><b>TcpConnectionEstatsSndCong</b></dt> </dl> </td> <td width="60%">
///                 This value requests sender congestion for a TCP connection. All three types of information (read-only static,
///                 read-only dynamic, and read/write information) are available for this enumeration value. If the <i>Rw</i>
///                 parameter was not <b>NULL</b> and the function succeeds, the buffer pointed to by the <i>Rw</i> parameter should
///                 contain a TCP_ESTATS_SND_CONG_RW_v0 structure. If the <i>Ros</i> parameter was not <b>NULL</b> and the function
///                 succeeds, the buffer pointed to by the <i>Ros</i> parameter should contain a TCP_ESTATS_SND_CONG_ROS_v0
///                 structure. If sender congestion information was enabled for this TCP connection, the <i>Rod</i> parameter was not
///                 <b>NULL</b>, and the function succeeds, the buffer pointed to by the <i>Rod</i> parameter should contain a
///                 TCP_ESTATS_SND_CONG_ROD_v0 structure. </td> </tr> <tr> <td width="40%"><a id="TcpConnectionEstatsPath"></a><a
///                 id="tcpconnectionestatspath"></a><a id="TCPCONNECTIONESTATSPATH"></a><dl> <dt><b>TcpConnectionEstatsPath</b></dt>
///                 </dl> </td> <td width="60%"> This value requests extended path measurement information for a TCP connection. Only
///                 read-only dynamic information and read/write information are available for this enumeration value. If the
///                 <i>Rw</i> parameter was not <b>NULL</b> and the function succeeds, the buffer pointed to by the <i>Rw</i>
///                 parameter should contain a TCP_ESTATS_PATH_RW_v0 structure. If extended path measurement information was enabled
///                 for this TCP connection, the <i>Rod</i> parameter was not <b>NULL</b>, and the function succeeds, the buffer
///                 pointed to by the <i>Rod</i> parameter should contain a TCP_ESTATS_PATH_ROD_v0 structure. </td> </tr> <tr> <td
///                 width="40%"><a id="TcpConnectionEstatsSendBuff"></a><a id="tcpconnectionestatssendbuff"></a><a
///                 id="TCPCONNECTIONESTATSSENDBUFF"></a><dl> <dt><b>TcpConnectionEstatsSendBuff</b></dt> </dl> </td> <td
///                 width="60%"> This value requests extended output-queuing information for a TCP connection. Only read-only dynamic
///                 information and read/write information are available for this enumeration value. If the <i>Rw</i> parameter was
///                 not <b>NULL</b> and the function succeeds, the buffer pointed to by the <i>Rw</i> parameter should contain a
///                 TCP_ESTATS_SEND_BUFF_RW_v0 structure. If extended output-queuing information was enabled for this TCP connection,
///                 the <i>Rod</i> parameter was not <b>NULL</b>, and the function succeeds, the buffer pointed to by the <i>Rod</i>
///                 parameter should contain a TCP_ESTATS_SEND_BUFF_ROD_v0 structure. </td> </tr> <tr> <td width="40%"><a
///                 id="TcpConnectionEstatsRec"></a><a id="tcpconnectionestatsrec"></a><a id="TCPCONNECTIONESTATSREC"></a><dl>
///                 <dt><b>TcpConnectionEstatsRec</b></dt> </dl> </td> <td width="60%"> This value requests extended local-receiver
///                 information for a TCP connection. Only read-only dynamic information and read/write information are available for
///                 this enumeration value. If the <i>Rw</i> parameter was not <b>NULL</b> and the function succeeds, the buffer
///                 pointed to by the <i>Rw</i> parameter should contain a TCP_ESTATS_REC_RW_v0 structure. If extended local-receiver
///                 information was enabled for this TCP connection, the <i>Rod</i> parameter was not <b>NULL</b>, and the function
///                 succeeds, the buffer pointed to by the <i>Rod</i> parameter should contain a TCP_ESTATS_REC_ROD_v0 structure.
///                 </td> </tr> <tr> <td width="40%"><a id="TcpConnectionEstatsObsRec"></a><a id="tcpconnectionestatsobsrec"></a><a
///                 id="TCPCONNECTIONESTATSOBSREC"></a><dl> <dt><b>TcpConnectionEstatsObsRec</b></dt> </dl> </td> <td width="60%">
///                 This value requests extended remote-receiver information for a TCP connection. Only read-only dynamic information
///                 and read/write information are available for this enumeration value. If the <i>Rw</i> parameter was not
///                 <b>NULL</b> and the function succeeds, the buffer pointed to by the <i>Rw</i> parameter should contain a
///                 TCP_ESTATS_OBS_REC_RW_v0 structure. If extended remote-receiver information was enabled for this TCP connection,
///                 the <i>Rod</i> parameter was not <b>NULL</b>, and the function succeeds, the buffer pointed to by the <i>Rod</i>
///                 parameter should contain a TCP_ESTATS_OBS_REC_ROD_v0 structure. </td> </tr> <tr> <td width="40%"><a
///                 id="TcpConnectionEstatsBandwidth"></a><a id="tcpconnectionestatsbandwidth"></a><a
///                 id="TCPCONNECTIONESTATSBANDWIDTH"></a><dl> <dt><b>TcpConnectionEstatsBandwidth</b></dt> </dl> </td> <td
///                 width="60%"> This value requests bandwidth estimation statistics for a TCP connection on bandwidth. Only
///                 read-only dynamic information and read/write information are available for this enumeration value. If the
///                 <i>Rw</i> parameter was not <b>NULL</b> and the function succeeds, the buffer pointed to by the <i>Rw</i>
///                 parameter should contain a TCP_ESTATS_BANDWIDTH_RW_v0 structure. If bandwidth estimation statistics was enabled
///                 for this TCP connection, the <i>Rod</i> parameter was not <b>NULL</b>, and the function succeeds, the buffer
///                 pointed to by the <i>Rod</i> parameter should contain a TCP_ESTATS_BANDWIDTH_ROD_v0 structure. </td> </tr> <tr>
///                 <td width="40%"><a id="TcpConnectionEstatsFineRtt"></a><a id="tcpconnectionestatsfinertt"></a><a
///                 id="TCPCONNECTIONESTATSFINERTT"></a><dl> <dt><b>TcpConnectionEstatsFineRtt</b></dt> </dl> </td> <td width="60%">
///                 This value requests fine-grained round-trip time (RTT) estimation statistics for a TCP connection. Only read-only
///                 dynamic information and read/write information are available for this enumeration value. If the <i>Rw</i>
///                 parameter was not <b>NULL</b> and the function succeeds, the buffer pointed to by the <i>Rw</i> parameter should
///                 contain a TCP_ESTATS_FINE_RTT_RW_v0 structure. If fine-grained RTT estimation statistics was enabled for this TCP
///                 connection, the <i>Rod</i> parameter was not <b>NULL</b>, and the function succeeds, the buffer pointed to by the
///                 <i>Rod</i> parameter should contain a TCP_ESTATS_FINE_RTT_ROD_v0 structure. </td> </tr> </table>
///    Rw = A pointer to a buffer to receive the read/write information. This parameter may be a <b>NULL</b> pointer if an
///         application does not want to retrieve read/write information for the TCP connection.
///    RwVersion = The version of the read/write information requested. The current supported value is a version of zero.
///    RwSize = The size, in bytes, of the buffer pointed to by <i>Rw</i> parameter.
///    Ros = A pointer to a buffer to receive read-only static information. This parameter may be a <b>NULL</b> pointer if an
///          application does not want to retrieve read-only static information for the TCP connection.
///    RosVersion = The version of the read-only static information requested. The current supported value is a version of zero.
///    RosSize = The size, in bytes, of the buffer pointed to by the <i>Ros</i> parameter.
///    Rod = A pointer to a buffer to receive read-only dynamic information. This parameter may be a <b>NULL</b> pointer if an
///          application does not want to retrieve read-only dynamic information for the TCP connection.
///    RodVersion = The version of the read-only dynamic information requested. The current supported value is a version of zero.
///    RodSize = The size, in bytes, of the buffer pointed to by the <i>Rod</i> parameter.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> A buffer passed to a function is too
///    small. This error is returned if the buffer pointed to by the <i>Rw</i>, <i>Ros</i>, or <i>Rod</i> parameters is
///    not large enough to receive the data. This error also returned if one of the given buffers pointed to by the
///    <i>Rw</i>, <i>Ros</i>, or <i>Rod</i> parameters is <b>NULL</b>, but a length was specified in the associated
///    <i>RwSize</i>, <i>RosSize</i>, or <i>RodSize</i>. This error value is returned on Windows Vista and Windows
///    Server 2008. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The parameter is incorrect. This error is returned if the <i>Row</i> parameter is a <b>NULL</b>
///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_USER_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The supplied user buffer is not valid for the requested operation. This error is returned if one of
///    the given buffers pointed to by the <i>Rw</i>, <i>Ros</i>, or <i>Rod</i> parameters is <b>NULL</b>, but a length
///    was specified in the associated <i>RwSize</i>, <i>RosSize</i>, or <i>RodSize</i>. As a result, this error is
///    returned if any of the following conditions are met: <ul> <li>The <i>Row</i> parameter is a <b>NULL</b> pointer
///    and the <i>RwSize</i> parameter is nonzero.</li> <li>The <i>Ros</i> parameter is a <b>NULL</b> pointer and the
///    <i>RosSize</i> parameter is nonzero.</li> <li>The <i>Rod</i> parameter is a <b>NULL</b> pointer and the
///    <i>RodSize</i> parameter is nonzero.</li> </ul> This error value is returned on Windows 7 and Windows Server 2008
///    R2. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> This
///    requested entry was not found. This error is returned if the TCP connection specified in the <i>Row</i> parameter
///    could not be found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td
///    width="60%"> The request is not supported. This error is returned if the <i>RwVersion</i>, <i>RosVersion</i>, or
///    <i>RodVersion</i> parameter is not set to zero. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt>
///    </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr>
///    </table>
///    
@DllImport("IPHLPAPI")
uint GetPerTcpConnectionEStats(MIB_TCPROW_LH* Row, TCP_ESTATS_TYPE EstatsType, ubyte* Rw, uint RwVersion, 
                               uint RwSize, ubyte* Ros, uint RosVersion, uint RosSize, ubyte* Rod, uint RodVersion, 
                               uint RodSize);

///The <b>SetPerTcpConnectionEStats</b> function sets a value in the read/write information for an IPv4 TCP connection.
///This function is used to enable or disable extended statistics for an IPv4 TCP connection.
///Params:
///    Row = A pointer to a MIB_TCPROW structure for an IPv4 TCP connection.
///    EstatsType = The type of extended statistics for TCP to set. This parameter determines the data and format of information that
///                 is expected in the <i>Rw</i> parameter. This parameter can be one of the values from the TCP_ESTATS_TYPE
///                 enumeration type defined in the <i>Tcpestats.h</i> header file.
///    Rw = A pointer to a buffer that contains the read/write information to set. The buffer should contain a value from the
///         TCP_BOOLEAN_OPTIONAL enumeration for each structure member that specifies how each member should be updated.
///    RwVersion = The version of the read/write information to be set. This parameter should be set to zero for Windows Vista,
///                Windows Server 2008, and Windows 7.
///    RwSize = The size, in bytes, of the buffer pointed to by the <i>Rw</i> parameter.
///    Offset = The offset, in bytes, to the member in the structure pointed to by the <i>Rw</i> parameter to be set. This
///             parameter is currently unused and must be set to zero.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error is returned under
///    several conditions that include the following: the user lacks the required administrative privileges on the local
///    computer or the application is not running in an enhanced shell as the built-in Administrator (RunAs
///    administrator). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_USER_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The supplied user buffer is not valid for the requested operation. This error is returned if the
///    <i>Row</i> parameter is a <b>NULL</b> pointer and the <i>RwSize</i> parameter is nonzero. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The parameter is
///    incorrect. This error is returned if the <i>Row</i> parameter is a <b>NULL</b> pointer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> This requested entry was not
///    found. This error is returned if the TCP connection specified in the <i>Row</i> parameter could not be found.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The
///    request is not supported. This error is returned if the <i>RwVersion</i> or the <i>Offset</i> parameter is not
///    set to 0. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use
///    FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint SetPerTcpConnectionEStats(MIB_TCPROW_LH* Row, TCP_ESTATS_TYPE EstatsType, ubyte* Rw, uint RwVersion, 
                               uint RwSize, uint Offset);

///The <b>GetPerTcp6ConnectionEStats</b> function retrieves extended statistics for an IPv6 TCP connection.
///Params:
///    Row = A pointer to a MIB_TCP6ROW structure for an IPv6 TCP connection.
///    EstatsType = The type of extended statistics for TCP requested. This parameter determines the data and format of information
///                 that is returned in the <i>Rw</i>, <i>Rod</i>, and <i>Ros</i> parameters if the call is successful. This
///                 parameter can be one of the values from the TCP_ESTATS_TYPE enumeration type defined in the <i>Tcpestats.h</i>
///                 header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                 id="TcpConnectionEstatsSynOpts"></a><a id="tcpconnectionestatssynopts"></a><a
///                 id="TCPCONNECTIONESTATSSYNOPTS"></a><dl> <dt><b>TcpConnectionEstatsSynOpts</b></dt> </dl> </td> <td width="60%">
///                 This value requests SYN exchange information for a TCP connection. Only read-only static information is available
///                 for this enumeration value. If the <i>Ros</i> parameter was not <b>NULL</b> and the function succeeds, the buffer
///                 pointed to by the <i>Ros</i> parameter should contain a TCP_ESTATS_SYN_OPTS_ROS_v0 structure. </td> </tr> <tr>
///                 <td width="40%"><a id="TcpConnectionEstatsData"></a><a id="tcpconnectionestatsdata"></a><a
///                 id="TCPCONNECTIONESTATSDATA"></a><dl> <dt><b>TcpConnectionEstatsData</b></dt> </dl> </td> <td width="60%"> This
///                 value requests extended data transfer information for a TCP connection. Only read-only dynamic information and
///                 read/write information are available for this enumeration value. If the <i>Rw</i> parameter was not <b>NULL</b>
///                 and the function succeeds, the buffer pointed to by the <i>Rw</i> parameter should contain a
///                 TCP_ESTATS_DATA_RW_v0 structure. If extended data transfer information was enabled for this TCP connection, the
///                 <i>Rod</i> parameter was not <b>NULL</b>, and the function succeeds, the buffer pointed to by the <i>Rod</i>
///                 parameter should contain a TCP_ESTATS_DATA_ROD_v0 structure. </td> </tr> <tr> <td width="40%"><a
///                 id="TcpConnectionEstatsSndCong"></a><a id="tcpconnectionestatssndcong"></a><a
///                 id="TCPCONNECTIONESTATSSNDCONG"></a><dl> <dt><b>TcpConnectionEstatsSndCong</b></dt> </dl> </td> <td width="60%">
///                 This value requests sender congestion for a TCP connection. All three types of information (read-only static,
///                 read-only dynamic, and read/write information) are available for this enumeration value. If the <i>Rw</i>
///                 parameter was not <b>NULL</b> and the function succeeds, the buffer pointed to by the <i>Rw</i> parameter should
///                 contain a TCP_ESTATS_SND_CONG_RW_v0 structure. If the <i>Ros</i> parameter was not <b>NULL</b> and the function
///                 succeeds, the buffer pointed to by the <i>Ros</i> parameter should contain a TCP_ESTATS_SND_CONG_ROS_v0
///                 structure. If sender congestion information was enabled for this TCP connection, the <i>Rod</i> parameter was not
///                 <b>NULL</b>, and the function succeeds, the buffer pointed to by the <i>Rod</i> parameter should contain a
///                 TCP_ESTATS_SND_CONG_ROD_v0 structure. </td> </tr> <tr> <td width="40%"><a id="TcpConnectionEstatsPath"></a><a
///                 id="tcpconnectionestatspath"></a><a id="TCPCONNECTIONESTATSPATH"></a><dl> <dt><b>TcpConnectionEstatsPath</b></dt>
///                 </dl> </td> <td width="60%"> This value requests extended path measurement information for a TCP connection. Only
///                 read-only dynamic information and read/write information are available for this enumeration value. If the
///                 <i>Rw</i> parameter was not <b>NULL</b> and the function succeeds, the buffer pointed to by the <i>Rw</i>
///                 parameter should contain a TCP_ESTATS_PATH_RW_v0 structure. If extended path measurement information was enabled
///                 for this TCP connection, the <i>Rod</i> parameter was not <b>NULL</b>, and the function succeeds, the buffer
///                 pointed to by the <i>Rod</i> parameter should contain a TCP_ESTATS_PATH_ROD_v0 structure. </td> </tr> <tr> <td
///                 width="40%"><a id="TcpConnectionEstatsSendBuff"></a><a id="tcpconnectionestatssendbuff"></a><a
///                 id="TCPCONNECTIONESTATSSENDBUFF"></a><dl> <dt><b>TcpConnectionEstatsSendBuff</b></dt> </dl> </td> <td
///                 width="60%"> This value requests extended output-queuing information for a TCP connection. Only read-only dynamic
///                 information and read/write information are available for this enumeration value. If the <i>Rw</i> parameter was
///                 not <b>NULL</b> and the function succeeds, the buffer pointed to by the <i>Rw</i> parameter should contain a
///                 TCP_ESTATS_SEND_BUFF_RW_v0 structure. If extended output-queuing information was enabled for this TCP connection,
///                 the <i>Rod</i> parameter was not <b>NULL</b>, and the function succeeds, the buffer pointed to by the <i>Rod</i>
///                 parameter should contain a TCP_ESTATS_SEND_BUFF_ROD_v0 structure. </td> </tr> <tr> <td width="40%"><a
///                 id="TcpConnectionEstatsRec"></a><a id="tcpconnectionestatsrec"></a><a id="TCPCONNECTIONESTATSREC"></a><dl>
///                 <dt><b>TcpConnectionEstatsRec</b></dt> </dl> </td> <td width="60%"> This value requests extended local-receiver
///                 information for a TCP connection. Only read-only dynamic information and read/write information are available for
///                 this enumeration value. If the <i>Rw</i> parameter was not <b>NULL</b> and the function succeeds, the buffer
///                 pointed to by the <i>Rw</i> parameter should contain a TCP_ESTATS_REC_RW_v0 structure. If extended local-receiver
///                 information was enabled for this TCP connection, the <i>Rod</i> parameter was not <b>NULL</b>, and the function
///                 succeeds, the buffer pointed to by the <i>Rod</i> parameter should contain a TCP_ESTATS_REC_ROD_v0 structure.
///                 </td> </tr> <tr> <td width="40%"><a id="TcpConnectionEstatsObsRec"></a><a id="tcpconnectionestatsobsrec"></a><a
///                 id="TCPCONNECTIONESTATSOBSREC"></a><dl> <dt><b>TcpConnectionEstatsObsRec</b></dt> </dl> </td> <td width="60%">
///                 This value requests extended remote-receiver information for a TCP connection. Only read-only dynamic information
///                 and read/write information are available for this enumeration value. If the <i>Rw</i> parameter was not
///                 <b>NULL</b> and the function succeeds, the buffer pointed to by the <i>Rw</i> parameter should contain a
///                 TCP_ESTATS_OBS_REC_RW_v0 structure. If extended remote-receiver information was enabled for this TCP connection,
///                 the <i>Rod</i> parameter was not <b>NULL</b>, and the function succeeds, the buffer pointed to by the <i>Rod</i>
///                 parameter should contain a TCP_ESTATS_OBS_REC_ROD_v0 structure. </td> </tr> <tr> <td width="40%"><a
///                 id="TcpConnectionEstatsBandwidth"></a><a id="tcpconnectionestatsbandwidth"></a><a
///                 id="TCPCONNECTIONESTATSBANDWIDTH"></a><dl> <dt><b>TcpConnectionEstatsBandwidth</b></dt> </dl> </td> <td
///                 width="60%"> This value requests bandwidth estimation statistics for a TCP connection on bandwidth. Only
///                 read-only dynamic information and read/write information are available for this enumeration value. If the
///                 <i>Rw</i> parameter was not <b>NULL</b> and the function succeeds, the buffer pointed to by the <i>Rw</i>
///                 parameter should contain a TCP_ESTATS_BANDWIDTH_RW_v0 structure. If bandwidth estimation statistics was enabled
///                 for this TCP connection, the <i>Rod</i> parameter was not <b>NULL</b>, and the function succeeds, the buffer
///                 pointed to by the <i>Rod</i> parameter should contain a TCP_ESTATS_BANDWIDTH_ROD_v0 structure. </td> </tr> <tr>
///                 <td width="40%"><a id="TcpConnectionEstatsFineRtt"></a><a id="tcpconnectionestatsfinertt"></a><a
///                 id="TCPCONNECTIONESTATSFINERTT"></a><dl> <dt><b>TcpConnectionEstatsFineRtt</b></dt> </dl> </td> <td width="60%">
///                 This value requests fine-grained round-trip time (RTT) estimation statistics for a TCP connection. Only read-only
///                 dynamic information and read/write information are available for this enumeration value. If the <i>Rw</i>
///                 parameter was not <b>NULL</b> and the function succeeds, the buffer pointed to by the <i>Rw</i> parameter should
///                 contain a TCP_ESTATS_FINE_RTT_RW_v0 structure. If fine-grained RTT estimation statistics was enabled for this TCP
///                 connection, the <i>Rod</i> parameter was not <b>NULL</b>, and the function succeeds, the buffer pointed to by the
///                 <i>Rod</i> parameter should contain a TCP_ESTATS_FINE_RTT_ROD_v0 structure. </td> </tr> </table>
///    Rw = A pointer to a buffer to receive the read/write information. This parameter may be a <b>NULL</b> pointer if an
///         application does not want to retrieve read/write information for the TCP connection.
///    RwVersion = The version of the read/write information requested. The current supported value is a version of zero.
///    RwSize = The size, in bytes, of the buffer pointed to by <i>Rw</i> parameter.
///    Ros = A pointer to a buffer to receive read-only static information. This parameter may be a <b>NULL</b> pointer if an
///          application does not want to retrieve read-only static information for the TCP connection.
///    RosVersion = The version of the read-only static information requested. The current supported value is a version of zero.
///    RosSize = The size, in bytes, of the buffer pointed to by the <i>Ros</i> parameter.
///    Rod = A pointer to a buffer to receive read-only dynamic information. This parameter may be a <b>NULL</b> pointer if an
///          application does not want to retrieve read-only dynamic information for the TCP connection.
///    RodVersion = The version of the read-only dynamic information requested. The current supported value is a version of zero..
///    RodSize = The size, in bytes, of the buffer pointed to by the <i>Rod</i> parameter.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> A buffer passed to a function is too
///    small. This error is returned if the buffer pointed to by the <i>Rw</i>, <i>Ros</i>, or <i>Rod</i> parameters is
///    not large enough to receive the data. This error also returned if one of the given buffers pointed to by the
///    <i>Rw</i>, <i>Ros</i>, or <i>Rod</i> parameters is <b>NULL</b>, but a length was specified in the associated
///    <i>RwSize</i>, <i>RosSize</i>, or <i>RodSize</i>. This error value is returned on Windows Vista and Windows
///    Server 2008. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The parameter is incorrect. This error is returned if the <i>Row</i> parameter is a <b>NULL</b>
///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_USER_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The supplied user buffer is not valid for the requested operation. This error is returned if one of
///    the given buffers pointed to by the <i>Rw</i>, <i>Ros</i>, or <i>Rod</i> parameters is <b>NULL</b>, but a length
///    was specified in the associated <i>RwSize</i>, <i>RosSize</i>, or <i>RodSize</i>. As a result, this error is
///    returned if any of the following conditions are met: <ul> <li>The <i>Row</i> parameter is a <b>NULL</b> pointer
///    and the <i>RwSize</i> parameter is nonzero.</li> <li>The <i>Ros</i> parameter is a <b>NULL</b> pointer and the
///    <i>RosSize</i> parameter is nonzero.</li> <li>The <i>Rod</i> parameter is a <b>NULL</b> pointer and the
///    <i>RodSize</i> parameter is nonzero.</li> </ul> This error value is returned on Windows 7 and Windows Server 2008
///    R2. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> This
///    requested entry was not found. This error is returned if the TCP connection specified in the <i>Row</i> parameter
///    could not be found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td
///    width="60%"> The request is not supported. This error is returned if the <i>RwVersion</i>, <i>RosVersion</i>, or
///    <i>RodVersion</i> parameter is not set to zero. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt>
///    </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr>
///    </table>
///    
@DllImport("IPHLPAPI")
uint GetPerTcp6ConnectionEStats(MIB_TCP6ROW* Row, TCP_ESTATS_TYPE EstatsType, ubyte* Rw, uint RwVersion, 
                                uint RwSize, ubyte* Ros, uint RosVersion, uint RosSize, ubyte* Rod, uint RodVersion, 
                                uint RodSize);

///The <b>SetPerTcp6ConnectionEStats</b> function sets a value in the read/write information for an IPv6 TCP connection.
///This function is used to enable or disable extended statistics for an IPv6 TCP connection.
///Params:
///    Row = A pointer to a MIB_TCP6ROW structure for an IPv6 TCP connection.
///    EstatsType = The type of extended statistics for TCP to set. This parameter determines the data and format of information that
///                 is expected in the <i>Rw</i> parameter. This parameter can be one of the values from the TCP_ESTATS_TYPE
///                 enumeration type defined in the <i>Tcpestats.h</i> header file. <table> <tr> <th>Value</th> <th>Meaning</th>
///                 </tr> <tr> <td width="40%"><a id="TcpConnectionEstatsData"></a><a id="tcpconnectionestatsdata"></a><a
///                 id="TCPCONNECTIONESTATSDATA"></a><dl> <dt><b>TcpConnectionEstatsData</b></dt> </dl> </td> <td width="60%"> This
///                 value specifies extended data transfer information for a TCP connection. When this value is specified, the buffer
///                 pointed to by the <i>Rw</i> parameter should point to a TCP_ESTATS_DATA_RW_v0 structure. </td> </tr> <tr> <td
///                 width="40%"><a id="TcpConnectionEstatsSndCong"></a><a id="tcpconnectionestatssndcong"></a><a
///                 id="TCPCONNECTIONESTATSSNDCONG"></a><dl> <dt><b>TcpConnectionEstatsSndCong</b></dt> </dl> </td> <td width="60%">
///                 This value specifies sender congestion for a TCP connection. When this value is specified, the buffer pointed to
///                 by the <i>Rw</i> parameter should point to a TCP_ESTATS_SND_CONG_RW_v0 structure. </td> </tr> <tr> <td
///                 width="40%"><a id="TcpConnectionEstatsPath"></a><a id="tcpconnectionestatspath"></a><a
///                 id="TCPCONNECTIONESTATSPATH"></a><dl> <dt><b>TcpConnectionEstatsPath</b></dt> </dl> </td> <td width="60%"> This
///                 value specifies extended path measurement information for a TCP connection. When this value is specified, the
///                 buffer pointed to by the <i>Rw</i> parameter should point to a TCP_ESTATS_PATH_RW_v0 structure. </td> </tr> <tr>
///                 <td width="40%"><a id="TcpConnectionEstatsSendBuff"></a><a id="tcpconnectionestatssendbuff"></a><a
///                 id="TCPCONNECTIONESTATSSENDBUFF"></a><dl> <dt><b>TcpConnectionEstatsSendBuff</b></dt> </dl> </td> <td
///                 width="60%"> This value specifies extended output-queuing information for a TCP connection. When this value is
///                 specified, the buffer pointed to by the <i>Rw</i> parameter should point to a TCP_ESTATS_SEND_BUFF_RW_v0
///                 structure. </td> </tr> <tr> <td width="40%"><a id="TcpConnectionEstatsRec"></a><a
///                 id="tcpconnectionestatsrec"></a><a id="TCPCONNECTIONESTATSREC"></a><dl> <dt><b>TcpConnectionEstatsRec</b></dt>
///                 </dl> </td> <td width="60%"> This value specifies extended local-receiver information for a TCP connection. When
///                 this value is specified, the buffer pointed to by the <i>Rw</i> parameter should point to a TCP_ESTATS_REC_RW_v0
///                 structure. </td> </tr> <tr> <td width="40%"><a id="TcpConnectionEstatsObsRec"></a><a
///                 id="tcpconnectionestatsobsrec"></a><a id="TCPCONNECTIONESTATSOBSREC"></a><dl>
///                 <dt><b>TcpConnectionEstatsObsRec</b></dt> </dl> </td> <td width="60%"> This value specifies extended
///                 remote-receiver information for a TCP connection. When this value is specified, the buffer pointed to by the
///                 <i>Rw</i> parameter should point to a TCP_ESTATS_OBS_REC_RW_v0 structure. </td> </tr> <tr> <td width="40%"><a
///                 id="TcpConnectionEstatsBandwidth"></a><a id="tcpconnectionestatsbandwidth"></a><a
///                 id="TCPCONNECTIONESTATSBANDWIDTH"></a><dl> <dt><b>TcpConnectionEstatsBandwidth</b></dt> </dl> </td> <td
///                 width="60%"> This value specifies bandwidth estimation statistics for a TCP connection on bandwidth. When this
///                 value is specified, the buffer pointed to by the <i>Rw</i> parameter should point to a TCP_ESTATS_BANDWIDTH_RW_v0
///                 structure. </td> </tr> <tr> <td width="40%"><a id="TcpConnectionEstatsFineRtt"></a><a
///                 id="tcpconnectionestatsfinertt"></a><a id="TCPCONNECTIONESTATSFINERTT"></a><dl>
///                 <dt><b>TcpConnectionEstatsFineRtt</b></dt> </dl> </td> <td width="60%"> This value specifies fine-grained
///                 round-trip time (RTT) estimation statistics for a TCP connection. When this value is specified, the buffer
///                 pointed to by the <i>Rw</i> parameter should point to a TCP_ESTATS_FINE_RTT_RW_v0 structure. </td> </tr> </table>
///    Rw = A pointer to a buffer that contains the read/write information to set. The buffer should contain a value from the
///         TCP_BOOLEAN_OPTIONAL enumeration for each structure member that specifies how each member should be updated.
///    RwVersion = The version of the read/write information to be set. This parameter should be set to zero for Windows Vista,
///                Windows Server 2008, and Windows 7.
///    RwSize = The size, in bytes, of the buffer pointed to by the <i>Rw</i> parameter.
///    Offset = The offset, in bytes, to the member in the structure pointed to by the <i>Rw</i> parameter to be set. This
///             parameter is currently unused and must be set to zero.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error is returned under
///    several conditions that include the following: the user lacks the required administrative privileges on the local
///    computer or the application is not running in an enhanced shell as the built-in Administrator (RunAs
///    administrator). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The parameter is incorrect. This error is returned if the <i>Row</i> parameter is a <b>NULL</b>
///    pointer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_USER_BUFFER</b></dt> </dl> </td> <td
///    width="60%"> The supplied user buffer is not valid for the requested operation. This error is returned if the
///    <i>Row</i> parameter is a <b>NULL</b> pointer and the <i>RwSize</i> parameter is nonzero. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> This requested entry was not
///    found. This error is returned if the TCP connection specified in the <i>Row</i> parameter could not be found.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The
///    request is not supported. This error is returned if the <i>RwVersion</i> or the <i>Offset</i> parameter is not
///    set to 0. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use
///    FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint SetPerTcp6ConnectionEStats(MIB_TCP6ROW* Row, TCP_ESTATS_TYPE EstatsType, ubyte* Rw, uint RwVersion, 
                                uint RwSize, uint Offset);

///The <b>GetOwnerModuleFromTcp6Entry</b> function retrieves data about the module that issued the context bind for a
///specific IPv6 TCP endpoint in a MIB table row.
///Params:
///    pTcpEntry = A pointer to a MIB_TCP6ROW_OWNER_MODULE structure that contains the IPv6 TCP endpoint entry used to obtain the
///                owner module.
///    Class = A TCPIP_OWNER_MODULE_INFO_CLASS enumeration value that indicates the type of data to obtain regarding the owner
///            module. The <b>TCPIP_OWNER_MODULE_INFO_CLASS</b> enumeration is defined in the <i>Iprtrmib.h</i> header file.
///            This parameter must be set to <b>TCPIP_OWNER_MODULE_INFO_BASIC</b>.
///    pBuffer = A pointer to a buffer that contains a TCPIP_OWNER_MODULE_BASIC_INFO structure with the owner module data. The
///              type of data returned in this buffer is indicated by the value of the <i>Class</i> parameter. The following
///              structures are used for the data in <i>Buffer</i> when <i>Class</i> is set to the corresponding value. <table>
///              <tr> <th><i>Class</i> enumeration value</th> <th><i>Buffer</i> data format</th> </tr> <tr>
///              <td>TCPIP_OWNER_MODULE_BASIC_INFO</td> <td> TCPIP_OWNER_MODULE_BASIC_INFO </td> </tr> </table>
///    pdwSize = The estimated size of the structure returned in <i>Buffer</i>, in bytes. If this value is set too small,
///              <b>ERROR_INSUFFICIENT_BUFFER</b> is returned by this function, and this field will contain the correct structure
///              size.
///Returns:
///    If the function call is successful, the value <b>NO_ERROR</b> is returned. If the function fails, the return
///    value is one of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> Insufficient space was
///    allocated for the table. The size of the table is returned in the <i>pdwSize</i> parameter, and must be used in a
///    subsequent call to this function in order to successfully retrieve the table. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> A parameter is incorrect. This value is
///    returned if either of the <i>pTcpEntry</i> or <i>pdwSize</i> parameters are <b>NULL</b>. This value is also
///    returned if the <i>Class</i> parameter is not equal to <b>TCPIP_OWNER_MODULE_INFO_BASIC</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is
///    available to complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl>
///    </td> <td width="60%"> The element was not found. This value is returned if the <b>dwOwningPid</b> member of the
///    MIB_TCP6ROW_OWNER_MODULE pointed to by the <i>pTcpEntry</i> parameter was zero or could not be found. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_PARTIAL_COPY</b></dt> </dl> </td> <td width="60%"> Only part of a request
///    was completed. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetOwnerModuleFromTcp6Entry(MIB_TCP6ROW_OWNER_MODULE* pTcpEntry, TCPIP_OWNER_MODULE_INFO_CLASS Class, 
                                 void* pBuffer, uint* pdwSize);

///The <b>GetUdp6Table</b> function retrieves the IPv6 User Datagram Protocol (UDP) listener table.
///Params:
///    Udp6Table = A pointer to a buffer that receives the IPv6 UDP listener table as a MIB_UDP6TABLE structure.
///    SizePointer = On input, specifies the size in bytes of the buffer pointed to by the <i>Udp6Table</i> parameter. On output, if
///                  the buffer is not large enough to hold the returned listener table, the function sets this parameter equal to the
///                  required buffer size in bytes.
///    Order = A Boolean value that specifies whether the returned UDP listener table should be sorted. If this parameter is
///            <b>TRUE</b>, the table is sorted in the order of: <ol> <li>Local IPv6 address</li> <li>Local scope ID</li>
///            <li>Local port</li> </ol>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer pointed to by the
///    <i>Udp6Table</i> parameter is not large enough. The required size is returned in the <b>ULONG</b> variable
///    pointed to by the <i>SizePointer</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>SizePointer</i> parameter is
///    <b>NULL</b>, or GetUdp6Table is unable to write to the memory pointed to by the <i>SizePointer</i> parameter.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This
///    function is not supported on the operating system in use on the local system. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the
///    returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetUdp6Table(MIB_UDP6TABLE* Udp6Table, uint* SizePointer, BOOL Order);

///The <b>GetOwnerModuleFromUdp6Entry</b> function retrieves data about the module that issued the context bind for a
///specific IPv6 UDP endpoint in a MIB table row.
///Params:
///    pUdpEntry = A pointer to a MIB_UDP6ROW_OWNER_MODULE structure that contains the IPv6 UDP endpoint entry used to obtain the
///                owner module.
///    Class = TCPIP_OWNER_MODULE_INFO_CLASS enumeration value that indicates the type of data to obtain regarding the owner
///            module.
///    pBuffer = The buffer that contains a TCPIP_OWNER_MODULE_BASIC_INFO structure with the owner module data. The type of data
///              returned in this buffer is indicated by the value of the <i>Class</i> parameter. The following structures are
///              used for the data in <i>Buffer</i> when <i>Class</i> is set to the corresponding value. <table> <tr>
///              <th><i>Class</i> enumeration value</th> <th><i>Buffer</i> data format</th> </tr> <tr>
///              <td>TCPIP_OWNER_MODULE_BASIC_INFO</td> <td> TCPIP_OWNER_MODULE_BASIC_INFO </td> </tr> </table>
///    pdwSize = The estimated size, in bytes, of the structure returned in <i>Buffer</i>. If this value is set too small,
///              <b>ERROR_INSUFFICIENT_BUFFER</b> is returned by this function, and this field will contain the correct size of
///              the structure.
///Returns:
///    If the call is successful, the value <b>NO_ERROR</b> is returned. Otherwise, the following error is returned.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> An insufficient amount of space was
///    allocated for the table. The size of the table is returned in the <i>pdwSize</i> parameter, and must be used in a
///    subsequent call to this function in order to successfully retrieve the table. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetOwnerModuleFromUdp6Entry(MIB_UDP6ROW_OWNER_MODULE* pUdpEntry, TCPIP_OWNER_MODULE_INFO_CLASS Class, 
                                 void* pBuffer, uint* pdwSize);

@DllImport("IPHLPAPI")
uint GetOwnerModuleFromPidAndInfo(uint ulPid, ulong* pInfo, TCPIP_OWNER_MODULE_INFO_CLASS Class, void* pBuffer, 
                                  uint* pdwSize);

///The <b>GetIpStatistics</b> function retrieves the IP statistics for the current computer.
///Params:
///    Statistics = A pointer to a MIB_IPSTATS structure that receives the IP statistics for the local computer.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>pStats</i> parameter is <b>NULL</b>,
///    or GetIpStatistics is unable to write to the memory pointed to by the <i>pStats</i> parameter. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use the FormatMessage function to obtain
///    the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetIpStatistics(MIB_IPSTATS_LH* Statistics);

///The <b>GetIcmpStatistics</b> function retrieves the Internet Control Message Protocol (ICMP) for IPv4 statistics for
///the local computer.
///Params:
///    Statistics = A pointer to a MIB_ICMP structure that receives the ICMP statistics for the local computer.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>pStats</i> parameter is <b>NULL</b>,
///    or GetIcmpStatistics is unable to write to the memory pointed to by the <i>pStats</i> parameter. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use the FormatMessage function to obtain
///    the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetIcmpStatistics(MIB_ICMP* Statistics);

///The <b>GetTcpStatistics</b> function retrieves the TCP statistics for the local computer.
///Params:
///    Statistics = A pointer to a MIB_TCPSTATS structure that receives the TCP statistics for the local computer.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>pStats</i> parameter is <b>NULL</b>,
///    or GetTcpStatistics is unable to write to the memory pointed to by the <i>pStats</i> parameter. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use the FormatMessage function to obtain
///    the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetTcpStatistics(MIB_TCPSTATS_LH* Statistics);

///The <b>GetUdpStatistics</b> function retrieves the User Datagram Protocol (UDP) statistics for the local computer.
///Params:
///    Stats = Pointer to a MIB_UDPSTATS structure that receives the UDP statistics for the local computer.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, use FormatMessage to obtain the
///    message string for the returned error.
///    
@DllImport("IPHLPAPI")
uint GetUdpStatistics(MIB_UDPSTATS* Stats);

///The <b>SetIpStatisticsEx</b> function toggles IP forwarding on or off and sets the default time-to-live (TTL) value
///for the local computer.
///Params:
///    Statistics = A pointer to a MIB_IPSTATS structure. The caller should set the <b>dwForwarding</b> and <b>dwDefaultTTL</b>
///                 members of this structure to the new values. To keep one of the members at its current value, use
///                 MIB_USE_CURRENT_TTL or MIB_USE_CURRENT_FORWARDING.
///    Family = The address family for which forwarding and TTL is to be set. Possible values for the address family are listed
///             in the <i>Winsock2.h</i> header file. Note that the values for the AF_ address family and PF_ protocol family
///             constants are identical (for example, <b>AF_INET</b> and <b>PF_INET</b>), so either constant can be used. On the
///             Windows SDK released for Windows Vista and later, the organization of header files has changed and possible
///             values for this member are defined in the <i>Ws2def.h</i> header file. Note that the <i>Ws2def.h</i> header file
///             is automatically included in <i>Winsock2.h</i>, and should never be used directly. The values currently supported
///             are <b>AF_INET</b>, and <b>AF_INET6</b>. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///             width="40%"><a id="AF_INET"></a><a id="af_inet"></a><dl> <dt><b>AF_INET</b></dt> <dt>2</dt> </dl> </td> <td
///             width="60%"> The Internet Protocol version 4 (IPv4) address family. When this parameter is specified, this
///             function sets forwarding and TTL options for IPv4 entries. </td> </tr> <tr> <td width="40%"><a
///             id="AF_INET6"></a><a id="af_inet6"></a><dl> <dt><b>AF_INET6</b></dt> <dt>23</dt> </dl> </td> <td width="60%"> The
///             Internet Protocol version 6 (IPv6) address family. When this parameter is specified, this function sets
///             forwarding and TTL options for IPv6 entries. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error is returned under
///    several conditions that include the following: the user lacks the required administrative privileges on the local
///    computer or the application is not running in an enhanced shell as the built-in Administrator (RunAs
///    administrator). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was passed to the function. This error is returned if a <b>NULL</b> pointer is
///    passed in the <i>pIpStats</i> parameter or the <i>Family</i> parameter was not set to <b>AF_INET</b>, and
///    <b>AF_INET6</b>. This error is also returned if the <b>dwForwarding</b> member in the MIB_IPSTATS structure
///    pointed to by the <i>pIpStats</i> parameter contains a value other than <b>MIB_IP_NOT_FORWARDING</b>,
///    <b>MIB_IP_FORWARDING</b>, or <b>MIB_USE_CURRENT_FORWARDING</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not supported. This error is
///    returned if no IPv4 stack is on the local computer and AF_INET was specified in the <i>Family</i> parameter or no
///    IPv6 stack is on the local computer and AF_INET6 was specified in the <i>Family</i> member. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message
///    string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint SetIpStatisticsEx(MIB_IPSTATS_LH* Statistics, uint Family);

///The <b>GetIpStatisticsEx</b> function retrieves the Internet Protocol (IP) statistics for the current computer. The
///<b>GetIpStatisticsEx</b> function differs from the GetIpStatistics function in that <b>GetIpStatisticsEx</b> also
///supports the Internet Protocol version 6 (IPv6) protocol family.
///Params:
///    Statistics = A pointer to a MIB_IPSTATS structure that receives the IP statistics for the local computer.
///    Family = The protocol family for which to retrieve statistics. This parameter must be one of the following values: <table>
///             <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="AF_INET"></a><a id="af_inet"></a><dl>
///             <dt><b>AF_INET</b></dt> </dl> </td> <td width="60%"> Internet Protocol version 4 (IPv4). </td> </tr> <tr> <td
///             width="40%"><a id="AF_INET6"></a><a id="af_inet6"></a><dl> <dt><b>AF_INET6</b></dt> </dl> </td> <td width="60%">
///             Internet Protocol version 6 (IPv6). </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>pStats</i> parameter is <b>NULL</b>
///    or does not point to valid memory, or the <i>dwFamily</i> parameter is not a valid value. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This function is not supported
///    on the operating system on which the function call was made. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the
///    returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetIpStatisticsEx(MIB_IPSTATS_LH* Statistics, uint Family);

///The <b>GetIcmpStatisticsEx</b> function retrieves Internet Control Message Protocol (ICMP) statistics for the local
///computer. The <b>GetIcmpStatisticsEx</b> function is capable of retrieving IPv6 ICMP statistics.
///Params:
///    Statistics = A pointer to a MIB_ICMP_EX structure that contains ICMP statistics for the local computer.
///    Family = The protocol family for which to retrieve ICMP statistics. Must be one of the following: <table> <tr>
///             <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="AF_INET"></a><a id="af_inet"></a><dl>
///             <dt><b>AF_INET</b></dt> </dl> </td> <td width="60%"> Internet Protocol version 4 (IPv4). </td> </tr> <tr> <td
///             width="40%"><a id="AF_INET6"></a><a id="af_inet6"></a><dl> <dt><b>AF_INET6</b></dt> </dl> </td> <td width="60%">
///             Internet Protocol version 6 (IPv6). </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>pStats</i> parameter is <b>NULL</b>
///    or does not point to valid memory, or the <i>dwFamily</i> parameter is not a valid value. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This function is not supported
///    on the operating system on which the function call was made. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the
///    returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetIcmpStatisticsEx(MIB_ICMP_EX_XPSP1* Statistics, uint Family);

///The <b>GetTcpStatisticsEx</b> function retrieves the Transmission Control Protocol (TCP) statistics for the current
///computer. The <b>GetTcpStatisticsEx</b> function differs from the <b>GetTcpStatistics</b> function in that
///<b>GetTcpStatisticsEx</b> also supports the Internet Protocol version 6 (IPv6) protocol family.
///Params:
///    Statistics = A pointer to a MIB_TCPSTATS structure that receives the TCP statistics for the local computer.
///    Family = The protocol family for which to retrieve statistics. This parameter must be one of the following values: <table>
///             <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="AF_INET"></a><a id="af_inet"></a><dl>
///             <dt><b>AF_INET</b></dt> </dl> </td> <td width="60%"> Internet Protocol version 4 (IPv4). </td> </tr> <tr> <td
///             width="40%"><a id="AF_INET6"></a><a id="af_inet6"></a><dl> <dt><b>AF_INET6</b></dt> </dl> </td> <td width="60%">
///             Internet Protocol version 6 (IPv6). </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>pStats</i> parameter is <b>NULL</b>
///    or does not point to valid memory, or the <i>dwFamily</i> parameter is not a valid value. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This function is not supported
///    on the operating system on which the function call was made. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the
///    returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetTcpStatisticsEx(MIB_TCPSTATS_LH* Statistics, uint Family);

///The <b>GetUdpStatisticsEx</b> function retrieves the User Datagram Protocol (UDP) statistics for the current
///computer. The <b>GetUdpStatisticsEx</b> function differs from the <b>GetUdpStatistics</b> function in that
///<b>GetUdpStatisticsEx</b> also supports the Internet Protocol version 6 (IPv6) protocol family.
///Params:
///    Statistics = A pointer to a MIB_UDPSTATS structure that receives the UDP statistics for the local computer.
///    Family = The protocol family for which to retrieve statistics. This parameter must be one of the following values: <table>
///             <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="AF_INET"></a><a id="af_inet"></a><dl>
///             <dt><b>AF_INET</b></dt> </dl> </td> <td width="60%"> Internet Protocol version 4 (IPv4). </td> </tr> <tr> <td
///             width="40%"><a id="AF_INET6"></a><a id="af_inet6"></a><dl> <dt><b>AF_INET6</b></dt> </dl> </td> <td width="60%">
///             Internet Protocol version 6 (IPv6). </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>pStats</i> parameter is <b>NULL</b>
///    or does not point to valid memory, or the <i>dwFamily</i> parameter is not a valid value. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This function is not supported
///    on the operating system on which the function call was made. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the
///    returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetUdpStatisticsEx(MIB_UDPSTATS* Statistics, uint Family);

///The <b>GetTcpStatisticsEx2</b> function retrieves the Transmission Control Protocol (TCP) statistics for the current
///computer. The <b>GetTcpStatisticsEx2</b> function differs from the GetTcpStatisticsEx function in that it uses a new
///output structure that contains 64-bit counters, rather than 32-bit counters.
///Params:
///    Statistics = A pointer to a MIB_TCPSTATS2 structure that receives the TCP statistics for the local computer.
///    Family = The protocol family for which to retrieve statistics. This parameter must be one of the following values: <table>
///             <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="AF_INET"></a><a id="af_inet"></a><dl>
///             <dt><b>AF_INET</b></dt> </dl> </td> <td width="60%"> Internet Protocol version 4 (IPv4). </td> </tr> <tr> <td
///             width="40%"><a id="AF_INET6"></a><a id="af_inet6"></a><dl> <dt><b>AF_INET6</b></dt> </dl> </td> <td width="60%">
///             Internet Protocol version 6 (IPv6). </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>pStats</i> parameter is <b>NULL</b>
///    or does not point to valid memory, or the <i>dwFamily</i> parameter is not a valid value. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This function is not supported
///    on the operating system on which the function call was made. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the
///    returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetTcpStatisticsEx2(MIB_TCPSTATS2* Statistics, uint Family);

///The <b>GetUdpStatisticsEx2</b> function retrieves the User Datagram Protocol (UDP) statistics for the current
///computer. The <b>GetUdpStatisticsEx2</b> function differs from the GetUdpStatisticsEx function in that
///<b>GetUdpStatisticsEx2</b> uses a new output structure that contains 64-bit counters, rather than 32-bit counters.
///Params:
///    Statistics = A pointer to a MIB_UDPSTATS2 structure that receives the UDP statistics for the local computer.
///    Family = The protocol family for which to retrieve statistics. This parameter must be one of the following values: <table>
///             <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="AF_INET"></a><a id="af_inet"></a><dl>
///             <dt><b>AF_INET</b></dt> </dl> </td> <td width="60%"> Internet Protocol version 4 (IPv4). </td> </tr> <tr> <td
///             width="40%"><a id="AF_INET6"></a><a id="af_inet6"></a><dl> <dt><b>AF_INET6</b></dt> </dl> </td> <td width="60%">
///             Internet Protocol version 6 (IPv6). </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>Statistics</i> parameter is
///    <b>NULL</b> or does not point to valid memory, or the <i>Family</i> parameter is not a valid value. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> This function is not
///    supported on the operating system on which the function call was made. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the
///    returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetUdpStatisticsEx2(MIB_UDPSTATS2* Statistics, uint Family);

///The <b>SetIfEntry</b> function sets the administrative status of an interface.
///Params:
///    pIfRow = A pointer to a MIB_IFROW structure. The <b>dwIndex</b> member of this structure specifies the interface on which
///             to set administrative status. The <b>dwAdminStatus</b> member specifies the new administrative status. The
///             <b>dwAdminStatus</b> member can be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th>
///             </tr> <tr> <td width="40%"><a id="MIB_IF_ADMIN_STATUS_UP"></a><a id="mib_if_admin_status_up"></a><dl>
///             <dt><b>MIB_IF_ADMIN_STATUS_UP</b></dt> </dl> </td> <td width="60%"> The interface is administratively enabled.
///             </td> </tr> <tr> <td width="40%"><a id="MIB_IF_ADMIN_STATUS_DOWN"></a><a id="mib_if_admin_status_down"></a><dl>
///             <dt><b>MIB_IF_ADMIN_STATUS_DOWN</b></dt> </dl> </td> <td width="60%"> The interface is administratively disabled.
///             </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error is returned on
///    Windows Vista and later under several conditions that include the following: the user lacks the required
///    administrative privileges on the local computer or the application is not running in an enhanced shell as the
///    built-in Administrator (RunAs administrator). </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The system cannot find the file specified. This
///    error is returned on Windows Vista and later if the network interface specified by the <b>dwIndex</b> member of
///    the MIB_IFROW structure pointed to by the <i>pIfRow</i> parameter could not be found. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was
///    passed to the function. This error is returned if a <b>NULL</b> pointer is passed in the <i>pIfRow</i> parameter,
///    or the <b>dwIndex</b> member of the MIB_IFROW pointed to by the <i>pIfRow</i> parameter was unspecified. This
///    error is also returned on Windows Server 2003 and earlier if the network interface specified by the
///    <b>dwIndex</b> member of the <b>MIB_IFROW</b> structure pointed to by the <i>pIfRow</i> parameter could not be
///    found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%">
///    The request is not supported. This error is returned on Windows Server 2003 and earlier if no TCP/IP stack is
///    configured on the local computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td
///    width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint SetIfEntry(MIB_IFROW* pIfRow);

///The <b>CreateIpForwardEntry</b> function creates a route in the local computer's IPv4 routing table.
///Params:
///    pRoute = A pointer to a MIB_IPFORWARDROW structure that specifies the information for the new route. The caller must
///             specify values for all members of this structure. The caller must specify <b>MIB_IPPROTO_NETMGMT</b> for the
///             <b>dwForwardProto</b> member of <b>MIB_IPFORWARDROW</b>.
///Returns:
///    The function returns <b>NO_ERROR</b> (zero) if the function is successful. If the function fails, the return
///    value is one of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error
///    is returned on Windows Vista and Windows Server 2008 under several conditions that include the following: the
///    user lacks the required administrative privileges on the local computer or the application is not running in an
///    enhanced shell as the built-in Administrator (RunAs administrator). </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An input parameter is invalid, no action was
///    taken. This error is returned if the <i>pRoute</i> parameter is <b>NULL</b>, the <b>dwForwardProto</b> member of
///    MIB_IPFORWARDROW was not set to <b>MIB_IPPROTO_NETMGMT</b>, the <b>dwForwardMask</b> member of the
///    <b>PMIB_IPFORWARDROW</b> structure is not a valid IPv4 subnet mask, or one of the other members of the
///    <b>MIB_IPFORWARDROW</b> structure is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The IPv4 transport is not configured on the
///    local computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use
///    FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint CreateIpForwardEntry(MIB_IPFORWARDROW* pRoute);

///The <b>SetIpForwardEntry</b> function modifies an existing route in the local computer's IPv4 routing table.
///Params:
///    pRoute = A pointer to a MIB_IPFORWARDROW structure that specifies the new information for the existing route. The caller
///             must specify <b>MIB_IPPROTO_NETMGMT</b> for the <b>dwForwardProto</b> member of this structure. The caller must
///             also specify values for the <b>dwForwardIfIndex</b>, <b>dwForwardDest</b>, <b>dwForwardMask</b>,
///             <b>dwForwardNextHop</b>, and <b>dwForwardPolicy</b> members of the structure.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error is returned on
///    Windows Vista and Windows Server 2008 under several conditions that include the following: the user lacks the
///    required administrative privileges on the local computer or the application is not running in an enhanced shell
///    as the built-in Administrator (RunAs administrator). </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The system cannot find the file specified. This
///    error is returned on Windows Vista and later if the network interface specified by the <b>dwForwardIfIndex</b>
///    member of the MIB_IPFORWARDROW structure pointed to by the <i>pRoute</i> parameter could not be found. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The
///    <i>pRoute</i> parameter is <b>NULL</b>, or SetIpForwardEntry is unable to read from the memory pointed to by
///    <i>pRoute</i>, or one of the members of the MIB_IPFORWARDROW structure is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The element is not found. The
///    error is returned on Windows Vista and later when the DeleteIpForwardEntry function and then the
///    SetIpForwardEntry function are called for the same IPv4 route table entry. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is not supported. This value is
///    returned if the IPv4 transport is not configured on the local computer. This error is also returned on Windows
///    Server 2003 and earlier if no TCP/IP stack is configured on the local computer. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the
///    returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint SetIpForwardEntry(MIB_IPFORWARDROW* pRoute);

///The <b>DeleteIpForwardEntry</b> function deletes an existing route in the local computer's IPv4 routing table.
///Params:
///    pRoute = A pointer to an MIB_IPFORWARDROW structure. This structure specifies information that identifies the route to
///             delete. The caller must specify values for the <b>dwForwardIfIndex</b>, <b>dwForwardDest</b>,
///             <b>dwForwardMask</b>, <b>dwForwardNextHop</b>, and <b>dwForwardProto</b> members of the structure.
///Returns:
///    The function returns <b>NO_ERROR</b> (zero) if the routine is successful. If the function fails, the return value
///    is one of the following error codes. <table> <tr> <th>Error code</th> <th>Meaning</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error
///    is returned on Windows Vista and Windows Server 2008 under several conditions that include the following: the
///    user lacks the required administrative privileges on the local computer or the application is not running in an
///    enhanced shell as the built-in Administrator (RunAs administrator). </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b> ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An input parameter is invalid, no action
///    was taken. This error is returned if the <b>pRoute</b> parameter is <b>NULL</b>, the <b>dwForwardMask</b> member
///    of the PMIB_IPFORWARDROW structure is not a valid IPv4 subnet mask, the <b>dwForwardIfIndex</b> member is
///    <b>NULL</b>, or one of the other members of the <b>MIB_IPFORWARDROW</b> structure is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b> ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The <b>pRoute</b> parameter
///    points to a route entry that does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The IPv4 transport is not configured on the
///    local computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>(other)</b></dt> </dl> </td> <td width="60%"> The
///    function may return other error codes. </td> </tr> </table> If the function fails, use FormatMessage to obtain
///    the message string for the returned error.
///    
@DllImport("IPHLPAPI")
uint DeleteIpForwardEntry(MIB_IPFORWARDROW* pRoute);

///The <b>SetIpStatistics</b> function toggles IP forwarding on or off and sets the default time-to-live (TTL) value for
///the local computer.
///Params:
///    pIpStats = A pointer to a MIB_IPSTATS structure. The caller should set the <b>dwForwarding</b> and <b>dwDefaultTTL</b>
///               members of this structure to the new values. To keep one of the members at its current value, use
///               MIB_USE_CURRENT_TTL or MIB_USE_CURRENT_FORWARDING.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error is returned on
///    Windows Vista and Windows Server 2008 under several conditions that include the following: the user lacks the
///    required administrative privileges on the local computer or the application is not running in an enhanced shell
///    as the built-in Administrator (RunAs administrator). </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed to the
///    function. This error is returned if a <b>NULL</b> pointer is passed in the <i>pIpStats</i> parameter. This error
///    is also returned if the <b>dwForwarding</b> member in the MIB_IPSTATS structure pointed to by the <i>pIpStats</i>
///    parameter contains a value other than <b>MIB_IP_NOT_FORWARDING</b>, <b>MIB_IP_FORWARDING</b>, or
///    <b>MIB_USE_CURRENT_FORWARDING</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td
///    width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint SetIpStatistics(MIB_IPSTATS_LH* pIpStats);

///The <b>SetIpTTL</b> function sets the default time-to-live (TTL) value for the local computer.
///Params:
///    nTTL = The new TTL value for the local computer.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error is returned on
///    Windows Vista and Windows Server 2008 under several conditions that include the following: the user lacks the
///    required administrative privileges on the local computer or the application is not running in an enhanced shell
///    as the built-in Administrator (RunAs administrator). </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed to the
///    function. This error is returned if the <i>nTTL</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the
///    returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint SetIpTTL(uint nTTL);

///The <b>CreateIpNetEntry</b> function creates an Address Resolution Protocol (ARP) entry in the ARP table on the local
///computer.
///Params:
///    pArpEntry = A pointer to a MIB_IPNETROW structure that specifies information for the new entry. The caller must specify
///                values for all members of this structure.
///Returns:
///    The function returns <b>NO_ERROR</b> (zero) if the function is successful. If the function fails, the return
///    value is one of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error
///    is returned on Windows Vista and Windows Server 2008 under several conditions that include the following: the
///    user lacks the required administrative privileges on the local computer or the application is not running in an
///    enhanced shell as the built-in Administrator (RunAs administrator). </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An input parameter is invalid, no action was
///    taken. This error is returned if the <i>pArpEntry</i> parameter is <b>NULL</b>, the <b>dwPhysAddrLen</b> member
///    of MIB_IPNETROW is set to zero or a value greater than 8, the <b>&gt;dwAddr</b> member of the <b>MIB_IPNETROW</b>
///    structure is invalid, or one of the other members of the <b>MIB_IPNETROW</b> structure is invalid. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The IPv4 transport is
///    not configured on the local computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td>
///    <td width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint CreateIpNetEntry(MIB_IPNETROW_LH* pArpEntry);

///The <b>SetIpNetEntry</b> function modifies an existing ARP entry in the ARP table on the local computer.
///Params:
///    pArpEntry = A pointer to a MIB_IPNETROW structure. The information in this structure specifies the entry to modify and the
///                new information for the entry. The caller must specify values for all members of this structure.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error is returned on
///    Windows Vista and Windows Server 2008 under several conditions that include the following: the user lacks the
///    required administrative privileges on the local computer or the application is not running in an enhanced shell
///    as the built-in Administrator (RunAs administrator). </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>pArpEntry</i> parameter is
///    <b>NULL</b>, or <b>SetIpNetEntry</b> is unable to read from the memory pointed to by <i>pArpEntry</i>, or one of
///    the members of the MIB_IPNETROW structure is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The IPv4 transport is not configured on the
///    local computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use
///    FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint SetIpNetEntry(MIB_IPNETROW_LH* pArpEntry);

///The <b>DeleteIpNetEntry</b> function deletes an ARP entry from the ARP table on the local computer.
///Params:
///    pArpEntry = A pointer to a MIB_IPNETROW structure. The information in this structure specifies the entry to delete. The
///                caller must specify values for at least the <b>dwIndex</b> and <b>dwAddr</b> members of this structure.
///Returns:
///    The function returns <b>NO_ERROR</b> (zero) if the function is successful. If the function fails, the return
///    value is one of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error
///    is returned on Windows Vista and Windows Server 2008 under several conditions that include the following: the
///    user lacks the required administrative privileges on the local computer or the application is not running in an
///    enhanced shell as the built-in Administrator (RunAs administrator). </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An input parameter is invalid, no action was
///    taken. This error is returned if the <i>pArpEntry</i> parameter is <b>NULL</b> or a member in the MIB_IPNETROW
///    structure pointed to by the <i>pArpEntry</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The IPv4 transport is not configured on the
///    local computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use
///    FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint DeleteIpNetEntry(MIB_IPNETROW_LH* pArpEntry);

///The <b>FlushIpNetTable</b> function deletes all ARP entries for the specified interface from the ARP table on the
///local computer.
///Params:
///    dwIfIndex = The index of the interface for which to delete all ARP entries.
///Returns:
///    The function returns <b>NO_ERROR</b> (zero) if the function is successful. If the function fails, the return
///    value is one of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error
///    is returned on Windows Vista and Windows Server 2008 under several conditions that include the following: the
///    user lacks the required administrative privileges on the local computer or the application is not running in an
///    enhanced shell as the built-in Administrator (RunAs administrator). </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An input parameter is invalid, no action was
///    taken. This error is returned if the <i>dwIfIndex</i> parameter is invalid. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The IPv4 transport is not configured on the
///    local computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use
///    FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint FlushIpNetTable(uint dwIfIndex);

///The <b>CreateProxyArpEnry</b> function creates a Proxy Address Resolution Protocol (PARP) entry on the local computer
///for the specified IPv4 address.
///Params:
///    dwAddress = The IPv4 address for which this computer acts as a proxy.
///    dwMask = The subnet mask for the IPv4 address specified in <i>dwAddress</i>.
///    dwIfIndex = The index of the interface on which to proxy ARP for the IPv4 address identified by <i>dwAddress</i>. In other
///                words, when an ARP request for <i>dwAddress</i> is received on this interface, the local computer responds with
///                the physical address of this interface. If this interface is of a type that does not support ARP, such as PPP,
///                then the call fails.
///Returns:
///    The function returns <b>NO_ERROR</b> (zero) if the function is successful. If the function fails, the return
///    value is one of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error
///    is returned on Windows Vista and Windows Server 2008 under several conditions that include the following: the
///    user lacks the required administrative privileges on the local computer or the application is not running in an
///    enhanced shell as the built-in Administrator (RunAs administrator). </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An input parameter is invalid, no action was
///    taken. This error is returned if the <i>dwAddress</i> parameter is <b>zero</b> or an invalid value, one of the
///    other parameters is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl>
///    </td> <td width="60%"> The IPv4 transport is not configured on the local computer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message
///    string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint CreateProxyArpEntry(uint dwAddress, uint dwMask, uint dwIfIndex);

///The <b>DeleteProxyArpEntry</b> function deletes the PARP entry on the local computer specified by the
///<i>dwAddress</i> and <i>dwIfIndex</i> parameters.
///Params:
///    dwAddress = The IPv4 address for which this computer is acting as a proxy.
///    dwMask = The subnet mask for the IPv4 address specified in the <i>dwAddress</i> parameter.
///    dwIfIndex = The index of the interface on which this computer is supporting proxy ARP for the IP address specified by the
///                <i>dwAddress</i> parameter.
///Returns:
///    The function returns <b>NO_ERROR</b> (zero) if the function is successful. If the function fails, the return
///    value is one of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error
///    is returned on Windows Vista and Windows Server 2008 under several conditions that include the following: the
///    user lacks the required administrative privileges on the local computer or the application is not running in an
///    enhanced shell as the built-in Administrator (RunAs administrator). </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An input parameter is invalid, no action was
///    taken. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%">
///    The IPv4 transport is not configured on the local computer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the
///    returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint DeleteProxyArpEntry(uint dwAddress, uint dwMask, uint dwIfIndex);

///The <b>SetTcpEntry</b> function sets the state of a TCP connection.
///Params:
///    pTcpRow = A pointer to a MIB_TCPROW structure. This structure specifies information to identify the TCP connection to
///              modify. It also specifies the new state for the TCP connection. The caller must specify values for all the
///              members in this structure.
///Returns:
///    The function returns <b>NO_ERROR</b> (zero) if the function is successful. If the function fails, the return
///    value is one of the following error codes. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied.
///    This error is returned on Windows Vista and Windows Server 2008 under several conditions that include the
///    following: the user lacks the required administrative privileges on the local computer or the application is not
///    running in an enhanced shell as the built-in Administrator (RunAs administrator). </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An input parameter is
///    invalid, no action was taken. This error is returned if the <i>pTcpRow</i> parameter is <b>NULL</b> or the
///    <b>Row</b> member in the MIB_TCPROW structure pointed to by the <i>pTcpRow</i> parameter is not set to
///    MIB_TCP_STATE_DELETE_TCB. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td>
///    <td width="60%"> The IPv4 transport is not configured on the local computer. </td> </tr> <tr> <td width="40%">
///    <dl> <dt>317</dt> </dl> </td> <td width="60%"> The function is unable to set the TCP entry since the application
///    is running non-elevated. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td
///    width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint SetTcpEntry(MIB_TCPROW_LH* pTcpRow);

///The <b>GetInterfaceInfo</b> function obtains the list of the network interface adapters with IPv4 enabled on the
///local system.
///Params:
///    pIfTable = A pointer to a buffer that specifies an IP_INTERFACE_INFO structure that receives the list of adapters. This
///               buffer must be allocated by the caller.
///    dwOutBufLen = A pointer to a <b>DWORD</b> variable that specifies the size of the buffer pointed to by <i>pIfTable</i>
///                  parameter to receive the IP_INTERFACE_INFO structure. If this size is insufficient to hold the IPv4 interface
///                  information, <b>GetInterfaceInfo</b> fills in this variable with the required size, and returns an error code of
///                  <b>ERROR_INSUFFICIENT_BUFFER</b>.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INSUFFICIENT_BUFFER</b></dt> </dl> </td> <td width="60%"> The buffer to receive the IPv4
///    adapter information is too small. This value is returned if the <i>dwOutBufLen</i> parameter indicates that the
///    buffer pointed to by the <i>pIfTable</i> parameter is too small to retrieve the IPv4 interface information. The
///    required size is returned in the <b>DWORD</b> variable pointed to by the <i>dwOutBufLen</i> parameter. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid
///    parameter was passed to the function. This error is returned if the <i>dwOutBufLen</i> parameter is <b>NULL</b>,
///    or GetInterfaceInfo is unable to write to the memory pointed to by the <i>dwOutBufLen</i> parameter. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_DATA</b></dt> </dl> </td> <td width="60%"> There are no network
///    adapters enabled for IPv4 on the local system. This value is also returned if all network adapters on the local
///    system are disabled. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td
///    width="60%"> This function is not supported on the operating system in use on the local system. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message
///    string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetInterfaceInfo(IP_INTERFACE_INFO* pIfTable, uint* dwOutBufLen);

///The <b>GetUniDirectionalAdapterInfo</b> function retrieves information about the unidirectional adapters installed on
///the local computer. A unidirectional adapter is an adapter that can receive datagrams, but not transmit them.
///Params:
///    pIPIfInfo = Pointer to an IP_UNIDIRECTIONAL_ADAPTER_ADDRESS structure that receives information about the unidirectional
///                adapters installed on the local computer.
///    dwOutBufLen = Pointer to a <b>ULONG</b> variable that receives the size of the structure pointed to by the <i>pIPIfInfo</i>
///                  parameter.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, use FormatMessage to obtain the
///    message string for the returned error.
///    
@DllImport("IPHLPAPI")
uint GetUniDirectionalAdapterInfo(IP_UNIDIRECTIONAL_ADAPTER_ADDRESS* pIPIfInfo, uint* dwOutBufLen);

///<p class="CCE_Message">[This function is no longer available for use as of Windows Vista. Instead, use the
///GetAdaptersAddresses function and the associated IP_ADAPTER_ADDRESSES structure.] The
///<b>NhpAllocateAndGetInterfaceInfoFromStack</b> function obtains adapter information about the local computer.
///Params:
///    ppTable = An array of IP_INTERFACE_NAME_INFO structures that contains information about each adapter on the local system.
///              The array contains one element for each adapter on the system.
///    pdwCount = The number of elements in the <i>ppTable</i> array.
///    bOrder = When <b>TRUE</b>, elements in the <i>ppTable</i> array are sorted by increasing index value.
///    hHeap = A handle that specifies the heap from which <i>ppTable</i> should be allocated. This parameter can be the process
///            heap returned by a call to the GetProcessHeap function, or a private heap created by a call to the HeapCreate
///            function.
///    dwFlags = A set of flags to be passed to the HeapAlloc function when allocating memory for <i>ppTable</i>. See the
///              <b>HeapAlloc</b> function for more information.
///Returns:
///    Returns ERROR_SUCCESS upon successful completion.
///    
@DllImport("IPHLPAPI")
uint NhpAllocateAndGetInterfaceInfoFromStack(ip_interface_name_info_w2ksp1** ppTable, uint* pdwCount, BOOL bOrder, 
                                             HANDLE hHeap, uint dwFlags);

///The <b>GetBestInterface</b> function retrieves the index of the interface that has the best route to the specified
///IPv4 address.
///Params:
///    dwDestAddr = The destination IPv4 address for which to retrieve the interface that has the best route, in the form of an
///                 IPAddr structure.
///    pdwBestIfIndex = A pointer to a <b>DWORD</b> variable that receives the index of the interface that has the best route to the IPv4
///                     address specified by <i>dwDestAddr</i>.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CAN_NOT_COMPLETE</b></dt> </dl> </td> <td width="60%"> The operation could not be completed. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid
///    parameter was passed to the function. This error is returned if a <b>NULL</b> pointer is passed in the
///    <i>pdwBestIfIndex</i> parameter or if the <i>pdwBestIfIndex</i> points to memory that cannot be written. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The request is
///    not supported. This error is returned if no IPv4 stack is on the local computer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use the FormatMessage function to obtain the
///    message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetBestInterface(uint dwDestAddr, uint* pdwBestIfIndex);

///The <b>GetBestInterfaceEx</b> function retrieves the index of the interface that has the best route to the specified
///IPv4 or IPv6 address.
///Params:
///    pDestAddr = The destination IPv6 or IPv4 address for which to retrieve the interface with the best route, in the form of a
///                sockaddr structure.
///    pdwBestIfIndex = A pointer to the index of the interface with the best route to the IPv6 or IPv4 address specified by
///                     <i>pDestAddr</i>.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CAN_NOT_COMPLETE</b></dt> </dl> </td> <td width="60%"> The operation could not be completed. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid
///    parameter was passed to the function. This error is returned if a <b>NULL</b> pointer is passed in the
///    <i>pdwBestIfIndex</i> parameter or if the <i>pDestAddr </i> or <i>pdwBestIfIndex</i> parameters point to memory
///    that cannot be accessed. This error can also be returned if the <i>pdwBestIfIndex</i> parameter points to memory
///    that can't be written to. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td>
///    <td width="60%"> The request is not supported. This error is returned if no IPv4 stack is on the local computer
///    and an IPv4 address was specified in the <i>pDestAddr</i> parameter or no IPv6 stack is on the local computer and
///    an IPv6 address was specified in the <i>pDestAddr</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use the FormatMessage function to obtain the message string
///    for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetBestInterfaceEx(SOCKADDR* pDestAddr, uint* pdwBestIfIndex);

///The <b>GetBestRoute</b> function retrieves the best route to the specified destination IP address.
///Params:
///    dwDestAddr = Destination IP address for which to obtain the best route.
///    dwSourceAddr = Source IP address. This IP address corresponds to an interface on the local computer. If multiple best routes to
///                   the destination address exist, the function selects the route that uses this interface. This parameter is
///                   optional. The caller may specify zero for this parameter.
///    pBestRoute = Pointer to a MIB_IPFORWARDROW structure containing the best route for the IP address specified by
///                 <i>dwDestAddr</i>.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, use FormatMessage to obtain the
///    message string for the returned error.
///    
@DllImport("IPHLPAPI")
uint GetBestRoute(uint dwDestAddr, uint dwSourceAddr, MIB_IPFORWARDROW* pBestRoute);

///The <b>NotifyAddrChange</b> function causes a notification to be sent to the caller whenever a change occurs in the
///table that maps IPv4 addresses to interfaces.
///Params:
///    Handle = A pointer to a <b>HANDLE</b> variable that receives a file handle for use in a subsequent call to the
///             GetOverlappedResult function. <div class="alert"><b>Warning</b> Do not close this handle, and do not associate it
///             with a completion port.</div> <div> </div>
///    overlapped = A pointer to an OVERLAPPED structure that notifies the caller of any changes in the table that maps IP addresses
///                 to interfaces.
///Returns:
///    If the function succeeds, the return value is NO_ERROR if the caller specifies <b>NULL</b> for the <i>Handle</i>
///    and <i>overlapped</i> parameters. If the caller specifies non-<b>NULL</b> parameters, the return value for
///    success is ERROR_IO_PENDING. If the function fails, use FormatMessage to obtain the message string for the
///    returned error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANCELLED</b></dt> </dl> </td> <td width="60%"> The context is being deregistered, so the call was
///    canceled immediately. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td>
///    <td width="60%"> An invalid parameter was passed. This error is returned if the both the <i>Handle</i> and
///    <i>overlapped</i> parameters are not <b>NULL</b>, but the memory specified by the input parameters cannot be
///    written by the calling process. This error is also returned if the client already has made a change notification
///    request, so this duplicate request will fail. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There was insufficient memory available to
///    complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td>
///    <td width="60%"> This error is returned on versions of Windows where this function is not supported such as
///    Windows 98/95 and Windows NT 4.0. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint NotifyAddrChange(HANDLE* Handle, OVERLAPPED* overlapped);

///The <b>NotifyRouteChange</b> function causes a notification to be sent to the caller whenever a change occurs in the
///IPv4 routing table.
///Params:
///    Handle = A pointer to a <b>HANDLE</b> variable that receives a handle to use in asynchronous notification.
///    overlapped = A pointer to an OVERLAPPED structure that notifies the caller of any changes in the routing table.
///Returns:
///    If the function succeeds, the return value is NO_ERROR if the caller specifies <b>NULL</b> for the <i>Handle</i>
///    and <i>overlapped</i> parameters. If the caller specifies non-<b>NULL</b> parameters, the return value for
///    success is ERROR_IO_PENDING. If the function fails, use FormatMessage to obtain the message string for the
///    returned error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_CANCELLED</b></dt> </dl> </td> <td width="60%"> The context is being deregistered, so the call was
///    canceled immediately. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td>
///    <td width="60%"> An invalid parameter was passed. This error is returned if the both the <i>Handle</i> and
///    <i>overlapped</i> parameters are not <b>NULL</b>, but the memory specified by the input parameters cannot be
///    written by the calling process. This error is also returned if the client already has made a change notification
///    request, so this duplicate request will fail. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> There was insufficient memory available to
///    complete the operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td>
///    <td width="60%"> This error is returned on versions of Windows where this function is not supported such as
///    Windows 98/95 and Windows NT 4.0. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint NotifyRouteChange(HANDLE* Handle, OVERLAPPED* overlapped);

///The <b>CancelIPChangeNotify</b> function cancels notification of IPv4 address and route changes previously requested
///with successful calls to the NotifyAddrChange or NotifyRouteChange functions.
///Params:
///    notifyOverlapped = A pointer to the OVERLAPPED structure used in the previous call to NotifyAddrChange or NotifyRouteChange.
@DllImport("IPHLPAPI")
BOOL CancelIPChangeNotify(OVERLAPPED* notifyOverlapped);

///The <b>GetAdapterIndex</b> function obtains the index of an adapter, given its name.
///Params:
///    AdapterName = A pointer to a Unicode string that specifies the name of the adapter.
///    IfIndex = A pointer to a <b>ULONG</b> variable that points to the index of the adapter.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, use FormatMessage to obtain the
///    message string for the returned error.
///    
@DllImport("IPHLPAPI")
uint GetAdapterIndex(PWSTR AdapterName, uint* IfIndex);

///The <b>AddIPAddress</b> function adds the specified IPv4 address to the specified adapter.
///Params:
///    Address = The IPv4 address to add to the adapter, in the form of an IPAddr structure.
///    IpMask = The subnet mask for the IPv4 address specified in the <i>Address</i> parameter. The <b>IPMask</b> parameter uses
///             the same format as an IPAddr structure.
///    IfIndex = The index of the adapter on which to add the IPv4 address.
///    NTEContext = A pointer to a <b>ULONG</b> variable. On successful return, this parameter points to the Net Table Entry (NTE)
///                 context for the IPv4 address that was added. The caller can later use this context in a call to the
///                 DeleteIPAddress function.
///    NTEInstance = A pointer to a <b>ULONG</b> variable. On successful return, this parameter points to the NTE instance for the
///                  IPv4 address that was added.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DEV_NOT_EXIST</b></dt> </dl> </td> <td width="60%"> The adapter specified by the <i>IfIndex</i>
///    parameter does not exist. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DUP_DOMAINNAME</b></dt> </dl> </td>
///    <td width="60%"> The IPv4 address to add that is specified in the <i>Address</i> parameter already exists. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_GEN_FAILURE</b></dt> </dl> </td> <td width="60%"> A general
///    failure. This error is returned for some values specified in the <i>Address</i> parameter, such as an IPv4
///    address normally considered to be a broadcast addresses. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The user attempting to make the function call
///    is not an administrator. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> One or more of the parameters is invalid. This error is returned if the <i>NTEContext</i>
///    or <i>NTEInstance</i> parameters are <b>NULL</b>. This error is also returned when the IP address specified in
///    the <i>Address</i> parameter is inconsistent with the interface index specified in the <i>IfIndex</i> parameter
///    (for example, a loopback address on a non-loopback interface). </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The function call is not supported on the
///    version of Windows on which it was run. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td>
///    <td width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint AddIPAddress(uint Address, uint IpMask, uint IfIndex, uint* NTEContext, uint* NTEInstance);

///The <b>DeleteIPAddress</b> function deletes an IP address previously added using AddIPAddress.
///Params:
///    NTEContext = The Net Table Entry (NTE) context for the IP address. This context was returned by the previous call to
///                 AddIPAddress.
///Returns:
///    The function returns <b>NO_ERROR</b> (zero) if the function is successful. If the function fails, the return
///    value is one of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error
///    is returned on Windows Vista and Windows Server 2008 under several conditions that include the following: the
///    user lacks the required administrative privileges on the local computer or the application is not running in an
///    enhanced shell as the built-in Administrator (RunAs administrator). </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An input parameter is invalid, no action was
///    taken. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%">
///    The IPv4 transport is not configured on the local computer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the
///    returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint DeleteIPAddress(uint NTEContext);

///The <b>GetNetworkParams</b> function retrieves network parameters for the local computer.
///Params:
///    pFixedInfo = A pointer to a buffer that contains a FIXED_INFO structure that receives the network parameters for the local
///                 computer, if the function was successful. This buffer must be allocated by the caller prior to calling the
///                 <b>GetNetworkParams</b> function.
///    pOutBufLen = A pointer to a <b>ULONG</b> variable that specifies the size of the FIXED_INFO structure. If this size is
///                 insufficient to hold the information, <b>GetNetworkParams</b> fills in this variable with the required size, and
///                 returns an error code of <b>ERROR_BUFFER_OVERFLOW</b>.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_BUFFER_OVERFLOW</b></dt> </dl> </td> <td width="60%"> The buffer to receive the
///    network parameter information is too small. This value is returned if the <i>pOutBufLen</i> parameter is too
///    small to hold the network parameter information or the <i>pFixedInfo</i> parameter was a <b>NULL</b> pointer.
///    When this error code is returned, the <i>pOutBufLen</i> parameter points to the required buffer size. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid
///    parameter was passed to the function. This error is returned if the <i>pOutBufLen</i> parameter is a <b>NULL</b>
///    pointer, the calling process does not have read/write access to the memory pointed to by <i>pOutBufLen</i>, or
///    the calling process does not have write access to the memory pointed to by the <i>pFixedInfo</i> parameter. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_DATA</b></dt> </dl> </td> <td width="60%"> No network parameter
///    information exists for the local computer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The <b>GetNetworkParams</b> function is not
///    supported by the operating system running on the local computer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> If the function fails, use FormatMessage to obtain the message
///    string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetNetworkParams(FIXED_INFO_W2KSP1* pFixedInfo, uint* pOutBufLen);

///The <b>GetAdaptersInfo</b> function retrieves adapter information for the local computer. <b>On Windows XP and later:
///</b>Use the GetAdaptersAddresses function instead of <b>GetAdaptersInfo</b>.
///Params:
///    AdapterInfo = A pointer to a buffer that receives a linked list of IP_ADAPTER_INFO structures.
///    SizePointer = A pointer to a <b>ULONG</b> variable that specifies the size of the buffer pointed to by the <i>pAdapterInfo</i>
///                  parameter. If this size is insufficient to hold the adapter information, <b>GetAdaptersInfo</b> fills in this
///                  variable with the required size, and returns an error code of <b>ERROR_BUFFER_OVERFLOW</b>.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b> (defined to the same value as
///    <b>NO_ERROR</b>). If the function fails, the return value is one of the following error codes. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUFFER_OVERFLOW</b></dt>
///    </dl> </td> <td width="60%"> The buffer to receive the adapter information is too small. This value is returned
///    if the buffer size indicated by the <i>pOutBufLen</i> parameter is too small to hold the adapter information or
///    the <i>pAdapterInfo</i> parameter was a <b>NULL</b> pointer. When this error code is returned, the
///    <i>pOutBufLen</i> parameter points to the required buffer size. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> Invalid adapter information was retrieved. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the
///    parameters is invalid. This error is returned if the <i>pOutBufLen</i> parameter is a <b>NULL</b> pointer, or the
///    calling process does not have read/write access to the memory pointed to by <i>pOutBufLen</i> or the calling
///    process does not have write access to the memory pointed to by the <i>pAdapterInfo</i> parameter. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_DATA</b></dt> </dl> </td> <td width="60%"> No adapter information
///    exists for the local computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl>
///    </td> <td width="60%"> The GetAdaptersInfo function is not supported by the operating system running on the local
///    computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> If the
///    function fails, use FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetAdaptersInfo(IP_ADAPTER_INFO* AdapterInfo, uint* SizePointer);

///The <b>GetAdapterOrderMap</b> function obtains an adapter order map that indicates priority for interfaces on the
///local computer.
///Returns:
///    Returns an IP_ADAPTER_ORDER_MAP structure filled with adapter priority information. See the
///    <b>IP_ADAPTER_ORDER_MAP</b> structure for more information.
///    
@DllImport("IPHLPAPI")
IP_ADAPTER_ORDER_MAP* GetAdapterOrderMap();

///The <b>GetAdaptersAddresses</b> function retrieves the addresses associated with the adapters on the local computer.
///Params:
///    Family = The address family of the addresses to retrieve. This parameter must be one of the following values. <table> <tr>
///             <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="AF_UNSPEC"></a><a id="af_unspec"></a><dl>
///             <dt><b>AF_UNSPEC</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> Return both IPv4 and IPv6 addresses associated
///             with adapters with IPv4 or IPv6 enabled. </td> </tr> <tr> <td width="40%"><a id="AF_INET"></a><a
///             id="af_inet"></a><dl> <dt><b>AF_INET</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Return only IPv4 addresses
///             associated with adapters with IPv4 enabled. </td> </tr> <tr> <td width="40%"><a id="AF_INET6"></a><a
///             id="af_inet6"></a><dl> <dt><b>AF_INET6</b></dt> <dt>23</dt> </dl> </td> <td width="60%"> Return only IPv6
///             addresses associated with adapters with IPv6 enabled. </td> </tr> </table>
///    Flags = The type of addresses to retrieve. The possible values are defined in the <i>Iptypes.h</i> header file. Note that
///            the <i>Iptypes.h</i> header file is automatically included in <i>Iphlpapi.h</i>, and should never be used
///            directly. This parameter is a combination of the following values. If this parameter is zero, then unicast,
///            anycast, and multicast IP addresses will be returned. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///            width="40%"><a id="GAA_FLAG_SKIP_UNICAST"></a><a id="gaa_flag_skip_unicast"></a><dl>
///            <dt><b>GAA_FLAG_SKIP_UNICAST</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> Do not return unicast
///            addresses. </td> </tr> <tr> <td width="40%"><a id="GAA_FLAG_SKIP_ANYCAST"></a><a
///            id="gaa_flag_skip_anycast"></a><dl> <dt><b>GAA_FLAG_SKIP_ANYCAST</b></dt> <dt>0x0002</dt> </dl> </td> <td
///            width="60%"> Do not return IPv6 anycast addresses. </td> </tr> <tr> <td width="40%"><a
///            id="GAA_FLAG_SKIP_MULTICAST"></a><a id="gaa_flag_skip_multicast"></a><dl> <dt><b>GAA_FLAG_SKIP_MULTICAST</b></dt>
///            <dt>0x0004</dt> </dl> </td> <td width="60%"> Do not return multicast addresses. </td> </tr> <tr> <td
///            width="40%"><a id="GAA_FLAG_SKIP_DNS_SERVER"></a><a id="gaa_flag_skip_dns_server"></a><dl>
///            <dt><b>GAA_FLAG_SKIP_DNS_SERVER</b></dt> <dt>0x0008</dt> </dl> </td> <td width="60%"> Do not return addresses of
///            DNS servers. </td> </tr> <tr> <td width="40%"><a id="GAA_FLAG_INCLUDE_PREFIX"></a><a
///            id="gaa_flag_include_prefix"></a><dl> <dt><b>GAA_FLAG_INCLUDE_PREFIX</b></dt> <dt>0x0010</dt> </dl> </td> <td
///            width="60%"> Return a list of IP address prefixes on this adapter. When this flag is set, IP address prefixes are
///            returned for both IPv6 and IPv4 addresses. This flag is supported on Windows XP with SP1 and later. </td> </tr>
///            <tr> <td width="40%"><a id="GAA_FLAG_SKIP_FRIENDLY_NAME"></a><a id="gaa_flag_skip_friendly_name"></a><dl>
///            <dt><b>GAA_FLAG_SKIP_FRIENDLY_NAME</b></dt> <dt>0x0020</dt> </dl> </td> <td width="60%"> Do not return the
///            adapter friendly name. </td> </tr> <tr> <td width="40%"><a id="GAA_FLAG_INCLUDE_WINS_INFO"></a><a
///            id="gaa_flag_include_wins_info"></a><dl> <dt><b>GAA_FLAG_INCLUDE_WINS_INFO</b></dt> <dt>0x0040</dt> </dl> </td>
///            <td width="60%"> Return addresses of Windows Internet Name Service (WINS) servers. This flag is supported on
///            Windows Vista and later. </td> </tr> <tr> <td width="40%"><a id="GAA_FLAG_INCLUDE_GATEWAYS"></a><a
///            id="gaa_flag_include_gateways"></a><dl> <dt><b>GAA_FLAG_INCLUDE_GATEWAYS</b></dt> <dt>0x0080</dt> </dl> </td> <td
///            width="60%"> Return the addresses of default gateways. This flag is supported on Windows Vista and later. </td>
///            </tr> <tr> <td width="40%"><a id="GAA_FLAG_INCLUDE_ALL_INTERFACES"></a><a
///            id="gaa_flag_include_all_interfaces"></a><dl> <dt><b>GAA_FLAG_INCLUDE_ALL_INTERFACES</b></dt> <dt>0x0100</dt>
///            </dl> </td> <td width="60%"> Return addresses for all NDIS interfaces. This flag is supported on Windows Vista
///            and later. </td> </tr> <tr> <td width="40%"><a id="GAA_FLAG_INCLUDE_ALL_COMPARTMENTS"></a><a
///            id="gaa_flag_include_all_compartments"></a><dl> <dt><b>GAA_FLAG_INCLUDE_ALL_COMPARTMENTS</b></dt> <dt>0x0200</dt>
///            </dl> </td> <td width="60%"> Return addresses in all routing compartments. This flag is not currently supported
///            and reserved for future use. </td> </tr> <tr> <td width="40%"><a id="GAA_FLAG_INCLUDE_TUNNEL_BINDINGORDER"></a><a
///            id="gaa_flag_include_tunnel_bindingorder"></a><dl> <dt><b>GAA_FLAG_INCLUDE_TUNNEL_BINDINGORDER</b></dt>
///            <dt>0x0400</dt> </dl> </td> <td width="60%"> Return the adapter addresses sorted in tunnel binding order. This
///            flag is supported on Windows Vista and later. </td> </tr> </table>
///    Reserved = This parameter is not currently used, but is reserved for future system use. The calling application should pass
///               <b>NULL</b> for this parameter.
///    AdapterAddresses = A pointer to a buffer that contains a linked list of IP_ADAPTER_ADDRESSES structures on successful return.
///    SizePointer = A pointer to a variable that specifies the size of the buffer pointed to by <i>AdapterAddresses</i>.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b> (defined to the same value as
///    <b>NO_ERROR</b>). If the function fails, the return value is one of the following error codes. <table> <tr>
///    <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ADDRESS_NOT_ASSOCIATED</b></dt> </dl> </td> <td width="60%"> An address has not yet been associated
///    with the network endpoint. DHCP lease information was available. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BUFFER_OVERFLOW</b></dt> </dl> </td> <td width="60%"> The buffer size indicated by the
///    <i>SizePointer</i> parameter is too small to hold the adapter information or the <i>AdapterAddresses</i>
///    parameter is <b>NULL</b>. The <i>SizePointer</i> parameter returned points to the required size of the buffer to
///    hold the adapter information. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt>
///    </dl> </td> <td width="60%"> One of the parameters is invalid. This error is returned for any of the following
///    conditions: the <i>SizePointer</i> parameter is <b>NULL</b>, the <i>Address</i> parameter is not <b>AF_INET</b>,
///    <b>AF_INET6</b>, or <b>AF_UNSPEC</b>, or the address information for the parameters requested is greater than
///    <b>ULONG_MAX</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> Insufficient memory resources are available to complete the operation. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NO_DATA</b></dt> </dl> </td> <td width="60%"> No addresses were found for the
///    requested parameters. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%">
///    Use FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint GetAdaptersAddresses(uint Family, uint Flags, void* Reserved, IP_ADAPTER_ADDRESSES_LH* AdapterAddresses, 
                          uint* SizePointer);

///The <b>GetPerAdapterInfo</b> function retrieves information about the adapter corresponding to the specified
///interface.
///Params:
///    IfIndex = Index of an interface. The <b>GetPerAdapterInfo</b> function retrieves information for the adapter corresponding
///              to this interface.
///    pPerAdapterInfo = Pointer to an IP_PER_ADAPTER_INFO structure that receives information about the adapter.
///    pOutBufLen = Pointer to a <b>ULONG</b> variable that specifies the size of the IP_PER_ADAPTER_INFO structure. If this size is
///                 insufficient to hold the information, <b>GetPerAdapterInfo</b> fills in this variable with the required size, and
///                 returns an error code of ERROR_BUFFER_OVERFLOW.
///Returns:
///    If the function succeeds, the return value is ERROR_SUCCESS. If the function fails, the return value is one of
///    the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_BUFFER_OVERFLOW</b></dt> </dl> </td> <td width="60%"> The buffer size indicated by the
///    <i>pOutBufLen</i> parameter is too small to hold the adapter information. The <i>pOutBufLen</i> parameter points
///    to the required size. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td>
///    <td width="60%"> The <i>pOutBufLen</i> parameter is <b>NULL</b>, or the calling process does not have read/write
///    access to the memory pointed to by <i>pOutBufLen</i>, or the calling process does not have write access to the
///    memory pointed to by the <i>pAdapterInfo</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> GetPerAdapterInfo is not supported by the
///    operating system running on the local computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt>
///    </dl> </td> <td width="60%"> If the function fails, use FormatMessage to obtain the message string for the
///    returned error. </td> </tr> </table> <div> </div>
///    
@DllImport("IPHLPAPI")
uint GetPerAdapterInfo(uint IfIndex, IP_PER_ADAPTER_INFO_W2KSP1* pPerAdapterInfo, uint* pOutBufLen);

///This function is reserved for system use, and you should not call it from your code.
///Params:
///    InterfaceLuid = Reserved.
///    TimestampCapabilites = Reserved.
@DllImport("IPHLPAPI")
uint GetInterfaceCurrentTimestampCapabilities(const(NET_LUID_LH)* InterfaceLuid, 
                                              INTERFACE_TIMESTAMP_CAPABILITIES* TimestampCapabilites);

///This function is reserved for system use, and you should not call it from your code.
///Params:
///    InterfaceLuid = Reserved.
///    TimestampCapabilites = Reserved.
@DllImport("IPHLPAPI")
uint GetInterfaceHardwareTimestampCapabilities(const(NET_LUID_LH)* InterfaceLuid, 
                                               INTERFACE_TIMESTAMP_CAPABILITIES* TimestampCapabilites);

///This function is reserved for system use, and you should not call it from your code.
///Params:
///    InterfaceLuid = Reserved.
///    CrossTimestamp = Reserved.
@DllImport("IPHLPAPI")
uint CaptureInterfaceHardwareCrossTimestamp(const(NET_LUID_LH)* InterfaceLuid, 
                                            INTERFACE_HARDWARE_CROSSTIMESTAMP* CrossTimestamp);

///This function is reserved for system use, and you should not call it from your code.
///Params:
///    CallerContext = Reserved.
///    Callback = Reserved.
///    NotificationHandle = Reserved.
@DllImport("IPHLPAPI")
uint NotifyIfTimestampConfigChange(void* CallerContext, PINTERFACE_TIMESTAMP_CONFIG_CHANGE_CALLBACK Callback, 
                                   HIFTIMESTAMPCHANGE__** NotificationHandle);

///This function is reserved for system use, and you should not call it from your code.
///Params:
///    NotificationHandle = Reserved.
@DllImport("IPHLPAPI")
void CancelIfTimestampConfigChange(HIFTIMESTAMPCHANGE__* NotificationHandle);

///The <b>IpReleaseAddress</b> function releases an IPv4 address previously obtained through the Dynamic Host
///Configuration Protocol (DHCP).
///Params:
///    AdapterInfo = A pointer to an IP_ADAPTER_INDEX_MAP structure that specifies the adapter associated with the IPv4 address to
///                  release.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, use FormatMessage to obtain the
///    message string for the returned error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the parameters is
///    invalid. This error is returned if the <i>AdapterInfo</i> parameter is <b>NULL</b> or if the <b>Name</b> member
///    of the <b>PIP_ADAPTER_INDEX_MAP</b> structure pointed to by the <i>AdapterInfo</i> parameter is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_PROC_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> An exception
///    occurred during the request to DHCP for the release of the IPv4 address. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the
///    returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint IpReleaseAddress(IP_ADAPTER_INDEX_MAP* AdapterInfo);

///The <b>IpRenewAddress</b>function renews a lease on an IPv4 address previously obtained through Dynamic Host
///Configuration Protocol (DHCP).
///Params:
///    AdapterInfo = A pointer to an IP_ADAPTER_INDEX_MAP structure that specifies the adapter associated with the IP address to
///                  renew.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, use FormatMessage to obtain the
///    message string for the returned error. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the parameters is
///    invalid. This error is returned if the <i>AdapterInfo</i> parameter is <b>NULL</b> or if the <b>Name</b> member
///    of the <b>PIP_ADAPTER_INDEX_MAP</b> structure pointed to by the <i>AdapterInfo</i> parameter is invalid. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_PROC_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> An exception
///    occurred during the request to DHCP for the renewal of the IPv4 address. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the
///    returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint IpRenewAddress(IP_ADAPTER_INDEX_MAP* AdapterInfo);

///The <b>SendARP</b> function sends an Address Resolution Protocol (ARP) request to obtain the physical address that
///corresponds to the specified destination IPv4 address.
///Params:
///    DestIP = The destination IPv4 address, in the form of an IPAddr structure. The ARP request attempts to obtain the physical
///             address that corresponds to this IPv4 address.
///    SrcIP = The source IPv4 address of the sender, in the form of an IPAddr structure. This parameter is optional and is used
///            to select the interface to send the request on for the ARP entry. The caller may specify zero corresponding to
///            the <b>INADDR_ANY</b> IPv4 address for this parameter.
///    pMacAddr = A pointer to an array of <b>ULONG</b> variables. This array must have at least two <b>ULONG</b> elements to hold
///               an Ethernet or token ring physical address. The first six bytes of this array receive the physical address that
///               corresponds to the IPv4 address specified by the <i>DestIP</i> parameter.
///    PhyAddrLen = On input, a pointer to a <b>ULONG</b> value that specifies the maximum buffer size, in bytes, the application has
///                 set aside to receive the physical address or MAC address. The buffer size should be at least 6 bytes for an
///                 Ethernet or token ring physical address The buffer to receive the physical address is pointed to by the
///                 <i>pMacAddr</i> parameter. On successful output, this parameter points to a value that specifies the number of
///                 bytes written to the buffer pointed to by the <i>pMacAddr</i>.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_BAD_NET_NAME</b></dt> </dl> </td> <td width="60%"> The network name cannot be found. This error is
///    returned on Windows Vista and later when an ARP reply to the SendARP request was not received. This error occurs
///    if the destination IPv4 address could not be reached because it is not on the same subnet or the destination
///    computer is not operating. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUFFER_OVERFLOW</b></dt> </dl>
///    </td> <td width="60%"> The file name is too long. This error is returned on Windows Vista if the <b>ULONG</b>
///    value pointed to by the <i>PhyAddrLen</i> parameter is less than 6, the size required to store a complete
///    physical address. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_GEN_FAILURE</b></dt> </dl> </td> <td
///    width="60%"> A device attached to the system is not functioning. This error is returned on Windows Server 2003
///    and earlier when an ARP reply to the SendARP request was not received. This error can occur if destination IPv4
///    address could not be reached because it is not on the same subnet or the destination computer is not operating.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One
///    of the parameters is invalid. This error is returned on Windows Server 2003 and earlier if either the
///    <i>pMacAddr</i> or <i>PhyAddrLen</i> parameter is a <b>NULL</b> pointer. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_USER_BUFFER</b></dt> </dl> </td> <td width="60%"> The supplied user buffer is not valid for
///    the requested operation. This error is returned on Windows Server 2003 and earlier if the <b>ULONG</b> value
///    pointed to by the <i>PhyAddrLen</i> parameter is zero. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> Element not found. This error is returned on Windows
///    Vista if the the <i>SrcIp</i> parameter does not specify a source IPv4 address on an interface on the local
///    computer or the <b>INADDR_ANY</b> IP address (an IPv4 address of 0.0.0.0). </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> The SendARP function is not supported by the
///    operating system running on the local computer. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt>
///    </dl> </td> <td width="60%"> If the function fails, use FormatMessage to obtain the message string for the
///    returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint SendARP(uint DestIP, uint SrcIP, void* pMacAddr, uint* PhyAddrLen);

///The <b>GetRTTAndHopCount</b> function determines the round-trip time (RTT) and hop count to the specified
///destination.
///Params:
///    DestIpAddress = IP address of the destination for which to determine the RTT and hop count, in the form of an IPAddr structure.
///    HopCount = Pointer to a <b>ULONG</b> variable. This variable receives the hop count to the destination specified by the
///               <i>DestIpAddress</i> parameter.
///    MaxHops = Maximum number of hops to search for the destination. If the number of hops to the destination exceeds this
///              number, the function terminates the search and returns <b>FALSE</b>.
///    RTT = Round-trip time, in milliseconds, to the destination specified by <i>DestIpAddress</i>.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. Call GetLastError to obtain the error code for the failure.
///    
@DllImport("IPHLPAPI")
BOOL GetRTTAndHopCount(uint DestIpAddress, uint* HopCount, uint MaxHops, uint* RTT);

///The <b>GetFriendlyIfIndex</b> function takes an interface index and returns a backward-compatible interface index,
///that is, an index that uses only the lower 24 bits.
///Params:
///    IfIndex = The interface index from which the backward-compatible or "friendly" interface index is derived.
///Returns:
///    A backward-compatible interface index that uses only the lower 24 bits.
///    
@DllImport("IPHLPAPI")
uint GetFriendlyIfIndex(uint IfIndex);

///The <b>EnableRouter</b> function turns on IPv4 forwarding on the local computer. <b>EnableRouter</b> also increments
///a reference count that tracks the number of requests to enable IPv4 forwarding.
///Params:
///    pHandle = A pointer to a handle. This parameter is currently unused.
///    pOverlapped = A pointer to an OVERLAPPED structure. Except for the <b>hEvent</b> member, all members of this structure should
///                  be set to zero. The <b>hEvent</b> member should contain a handle to a valid event object. Use the CreateEvent
///                  function to create this event object.
///Returns:
///    If the <b>EnableRouter</b> function succeeds, the return value is ERROR_IO_PENDING. If the function fails, use
///    FormatMessage to obtain the message string for the returned error. <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One of the parameters is invalid. This error is returned if the <i>pOverlapped</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use
///    FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint EnableRouter(HANDLE* pHandle, OVERLAPPED* pOverlapped);

///The <b>UnenableRouter</b> function decrements the reference count that tracks the number of requests to enable IPv4
///forwarding. When this reference count reaches zero, <b>UnenableRouter</b> turns off IPv4 forwarding on the local
///computer.
///Params:
///    pOverlapped = A pointer to an OVERLAPPED structure. This structure should be the same as the one used in the call to the
///                  EnableRouter function.
///    lpdwEnableCount = An optional pointer to a <b>DWORD</b> variable. This variable receives the number of references remaining.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, use FormatMessage to obtain the
///    message string for the returned error.
///    
@DllImport("IPHLPAPI")
uint UnenableRouter(OVERLAPPED* pOverlapped, uint* lpdwEnableCount);

///The <b>DisableMediaSense</b> function disables the media sensing capability of the TCP/IP stack on a local computer.
///Params:
///    pHandle = A pointer to a variable that is used to store a handle. If the <i>pOverlapped</i> parameter is not <b>NULL</b>,
///              this variable will be used internally to store a handle required to call the IP driver and disable the media
///              sensing capability. An application should not use the value pointed to by this variable. This handle is for
///              internal use and should not be closed.
///    pOverLapped = A pointer to an OVERLAPPED structure. Except for the <b>hEvent</b> member, all members of this structure must be
///                  set to zero. The <b>hEvent</b> member requires a handle to a valid event object. Use the CreateEvent function to
///                  create this event object.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed to the
///    function. This error is returned if an <i>pOverlapped</i> parameter is a bad pointer. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_IO_PENDING</b></dt> </dl> </td> <td width="60%"> The operation is in progress.
///    This value is returned by a successful asynchronous call to DisableMediaSense. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_OPEN_FAILED</b></dt> </dl> </td> <td width="60%"> The handle pointed to by the <i>pHandle</i>
///    parameter was invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td
///    width="60%"> The request is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl>
///    </td> <td width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr>
///    </table>
///    
@DllImport("IPHLPAPI")
uint DisableMediaSense(HANDLE* pHandle, OVERLAPPED* pOverLapped);

///The <b>RestoreMediaSense</b> function restores the media sensing capability of the TCP/IP stack on a local computer
///on which the DisableMediaSense function was previously called.
///Params:
///    pOverlapped = A pointer to an OVERLAPPED structure. Except for the <b>hEvent</b> member, all members of this structure must be
///                  set to zero. The <b>hEvent</b> member should contain a handle to a valid event object. Use the CreateEvent
///                  function to create this event object.
///    lpdwEnableCount = An optional pointer to a DWORD variable that receives the number of references remaining if the
///                      <b>RestoreMediaSense</b> function succeeds. The variable is also used by the EnableRouter and UnenableRouter
///                      functions.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed to the
///    function. This error is returned if an <i>pOverlapped</i> parameter is a bad pointer. This error is also returned
///    if the DisableMediaSense function was not called prior to calling the RestoreMediaSense function. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_IO_PENDING</b></dt> </dl> </td> <td width="60%"> The operation is in
///    progress. This value may be returned by a successful asynchronous call to RestoreMediaSense. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_OPEN_FAILED</b></dt> </dl> </td> <td width="60%"> An internal handle to the driver
///    was invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td
///    width="60%"> The request is not supported. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl>
///    </td> <td width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr>
///    </table>
///    
@DllImport("IPHLPAPI")
uint RestoreMediaSense(OVERLAPPED* pOverlapped, uint* lpdwEnableCount);

///The <b>GetIpErrorString</b> function retrieves an IP Helper error string.
///Params:
///    ErrorCode = The error code to be retrieved. The possible values for this parameter are defined in the <i>Ipexport.h</i>
///                header file.
///    Buffer = A pointer to the buffer that contains the error code string if the function returns with NO_ERROR.
///    Size = A pointer to a <b>DWORD</b> that specifies the length, in characters, of the buffer pointed to by <i>Buffer</i>
///           parameter, excluding the terminating null (i.e. the size of Buffer in characters, minus one).
///Returns:
///    Returns NO_ERROR upon success. If the function fails, use FormatMessage to obtain the message string for the
///    returned error.
///    
@DllImport("IPHLPAPI")
uint GetIpErrorString(uint ErrorCode, PWSTR Buffer, uint* Size);

///<p class="CCE_Message">[<b>ResolveNeighbor</b> is no longer available for use as of Windows Vista. Instead, use
///ResolveIpNetEntry2.] The <b>ResolveNeighbor</b> function resolves the physical address for a neighbor IP address
///entry on the local computer.
///Params:
///    NetworkAddress = A pointer to a SOCKADDR structure that contains the neighbor IP address entry and address family.
///    PhysicalAddress = A pointer to a byte array buffer that will receive the physical address that corresponds to the IP address
///                      specified by the <i>NetworkAddress</i> parameter if the function is successful. The length of the byte array is
///                      passed in the <i>PhysicalAddressLength</i> parameter.
///    PhysicalAddressLength = On input, this parameter specifies the maximum length, in bytes, of the buffer passed in the
///                            <i>PhysicalAddress</i> parameter to receive the physical address. If the function is successful, this parameter
///                            will receive the length of the physical address returned in the buffer pointed to by the <i>PhysicalAddress</i>
///                            parameter. If <b>ERROR_BUFFER_OVERFLOW</b> is returned, this parameter contains the number of bytes required to
///                            hold the physical address.
///Returns:
///    The <b>ResolveNeighbor</b> function always fails and returns the following error code. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td>
///    <td width="60%"> The request is not supported. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint ResolveNeighbor(SOCKADDR* NetworkAddress, void* PhysicalAddress, uint* PhysicalAddressLength);

///The <b>CreatePersistentTcpPortReservation</b> function creates a persistent TCP port reservation for a consecutive
///block of TCP ports on the local computer.
///Params:
///    StartPort = The starting TCP port number in network byte order.
///    NumberOfPorts = The number of TCP port numbers to reserve.
///    Token = A pointer to a port reservation token that is returned if the function succeeds.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error is returned under
///    several conditions that include the following: the user lacks the required administrative privileges on the local
///    computer or the application is not running in an enhanced shell as the built-in Administrator (RunAs
///    administrator). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was passed to the function. This error is returned if zero is passed in the
///    <i>StartPort</i> or <i>NumberOfPorts</i> parameters. This error is also returned if the <i>NumberOfPorts</i>
///    parameter is too large a block of ports depending on the <i>StartPort</i> parameter that the allocable block of
///    ports would exceed the maximum port that can be allocated. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SHARING_VIOLATION</b></dt> </dl> </td> <td width="60%"> The process cannot access the file because
///    it is being used by another process. This error is returned if a TCP port in the block of TCP ports specified by
///    the <i>StartPort</i> and <i>NumberOfPorts</i> parameters is already being used. This error is also returned if a
///    persistent reservation for a block of TCP ports specified by the <i>StartPort</i> and <i>NumberOfPorts</i>
///    parameters matches or overlaps a persistent reservation for a block of TCP ports that was already created. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain
///    the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint CreatePersistentTcpPortReservation(ushort StartPort, ushort NumberOfPorts, ulong* Token);

///The <b>CreatePersistentUdpPortReservation</b> function creates a persistent UDP port reservation for a consecutive
///block of UDP ports on the local computer.
///Params:
///    StartPort = The starting UDP port number in network byte order.
///    NumberOfPorts = The number of UDP port numbers to reserve.
///    Token = A pointer to a port reservation token that is returned if the function succeeds.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error is returned under
///    several conditions that include the following: the user lacks the required administrative privileges on the local
///    computer or the application is not running in an enhanced shell as the built-in Administrator (RunAs
///    administrator). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was passed to the function. This error is returned if zero is passed in the
///    <i>StartPort</i> or <i>NumberOfPorts</i> parameters. This error is also returned if the <i>NumberOfPorts</i>
///    parameter is too large a block of ports depending on the <i>StartPort</i> parameter that the allocable block of
///    ports would exceed the maximum port that can be allocated. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SHARING_VIOLATION</b></dt> </dl> </td> <td width="60%"> The process cannot access the file because
///    it is being used by another process. This error is returned if a UDP port in the block of UDP ports specified by
///    the <i>StartPort</i> and <i>NumberOfPorts</i> parameters is already being used. This error is also returned if a
///    persistent reservation for a block of UDP ports specified by the <i>StartPort</i> and <i>NumberOfPorts</i>
///    parameters matches or overlaps a persistent reservation for a block of UDP ports that was already created. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain
///    the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint CreatePersistentUdpPortReservation(ushort StartPort, ushort NumberOfPorts, ulong* Token);

///The <b>DeletePersistentTcpPortReservation</b> function deletes a persistent TCP port reservation for a consecutive
///block of TCP ports on the local computer.
///Params:
///    StartPort = The starting TCP port number in network byte order.
///    NumberOfPorts = The number of TCP port numbers to delete.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error is returned under
///    several conditions that include the following: the user lacks the required administrative privileges on the local
///    computer or the application is not running in an enhanced shell as the built-in Administrator (RunAs
///    administrator). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was passed to the function. This error is returned if zero is passed in the
///    <i>StartPort</i> or <i>NumberOfPorts</i> parameters. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The element was not found. This error is returned if
///    persistent port block specified by the <i>StartPort</i> and <i>NumberOfPorts</i> parameters could not be found.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to
///    obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint DeletePersistentTcpPortReservation(ushort StartPort, ushort NumberOfPorts);

///The <b>DeletePersistentUdpPortReservation</b> function deletes a persistent TCP port reservation for a consecutive
///block of TCP ports on the local computer.
///Params:
///    StartPort = The starting UDP port number in network byte order.
///    NumberOfPorts = The number of UDP port numbers to delete.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. This error is returned under
///    several conditions that include the following: the user lacks the required administrative privileges on the local
///    computer or the application is not running in an enhanced shell as the built-in Administrator (RunAs
///    administrator). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> An invalid parameter was passed to the function. This error is returned if zero is passed in the
///    <i>StartPort</i> or <i>NumberOfPorts</i> parameters. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The element was not found. This error is returned if
///    persistent port block specified by the <i>StartPort</i> and <i>NumberOfPorts</i> parameters could not be found.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to
///    obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("IPHLPAPI")
uint DeletePersistentUdpPortReservation(ushort StartPort, ushort NumberOfPorts);

///The <b>LookupPersistentTcpPortReservation</b> function looks up the token for a persistent TCP port reservation for a
///consecutive block of TCP ports on the local computer.
///Params:
///    StartPort = The starting TCP port number in network byte order.
///    NumberOfPorts = The number of TCP port numbers that were reserved.
///    Token = A pointer to a port reservation token that is returned if the function succeeds.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed to the
///    function. This error is returned if zero is passed in the <i>StartPort</i> or <i>NumberOfPorts</i> parameters.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The element
///    was not found. This error is returned if persistent port block specified by the <i>StartPort</i> and
///    <i>NumberOfPorts</i> parameters could not be found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt>
///    </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr>
///    </table>
///    
@DllImport("IPHLPAPI")
uint LookupPersistentTcpPortReservation(ushort StartPort, ushort NumberOfPorts, ulong* Token);

///The <b>LookupPersistentUdpPortReservation</b> function looks up the token for a persistent UDP port reservation for a
///consecutive block of TCP ports on the local computer.
///Params:
///    StartPort = The starting UDP port number in network byte order.
///    NumberOfPorts = The number of UDP port numbers that were reserved.
///    Token = A pointer to a port reservation token that is returned if the function succeeds.
///Returns:
///    If the function succeeds, the return value is NO_ERROR. If the function fails, the return value is one of the
///    following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was passed to the
///    function. This error is returned if zero is passed in the <i>StartPort</i> or <i>NumberOfPorts</i> parameters.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The element
///    was not found. This error is returned if persistent port block specified by the <i>StartPort</i> and
///    <i>NumberOfPorts</i> parameters could not be found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt>
///    </dl> </td> <td width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr>
///    </table>
///    
@DllImport("IPHLPAPI")
uint LookupPersistentUdpPortReservation(ushort StartPort, ushort NumberOfPorts, ulong* Token);

///The <b>RtlIpv4AddressToString</b> function converts an IPv4 address to a string in Internet standard dotted-decimal
///format.
///Params:
///    Addr = The IPv4 address in network byte order.
///    S = A pointer to a buffer in which to store the <b>NULL</b>-terminated string representation of the IPv4 address.
///        This buffer should be large enough to hold at least 16 characters.
///Returns:
///    A pointer to the NULL character inserted at the end of the string representation of the IPv4 address. This can be
///    used by the caller to easily append more information to the string.
///    
@DllImport("ntdll")
PSTR RtlIpv4AddressToStringA(const(in_addr)* Addr, PSTR S);

///The <b>RtlIpv4AddressToString</b> function converts an IPv4 address to a string in Internet standard dotted-decimal
///format.
///Params:
///    Addr = The IPv4 address in network byte order.
///    S = A pointer to a buffer in which to store the <b>NULL</b>-terminated string representation of the IPv4 address.
///        This buffer should be large enough to hold at least 16 characters.
///Returns:
///    A pointer to the NULL character inserted at the end of the string representation of the IPv4 address. This can be
///    used by the caller to easily append more information to the string.
///    
@DllImport("ntdll")
PWSTR RtlIpv4AddressToStringW(const(in_addr)* Addr, PWSTR S);

///The <b>RtlIpv4AddressToStringEx</b> function converts an IPv4 address and port number to a string in Internet
///standard format.
///Params:
///    Address = The IPv4 address in network byte order.
///    Port = The port number in network byte order format. This parameter is optional.
///    AddressString = A pointer to the buffer to receive the <b>NULL</b>-terminated string representation of the IPv4 address and port.
///                    This buffer should be large enough to hold at least INET_ADDRSTRLEN characters. The INET_ADDRSTRLEN value is
///                    defined in the <i>Ws2ipdef.h</i> header file.
///    AddressStringLength = On input, the number of characters that fit in the buffer pointed to by the <i>AddressString</i> parameter,
///                          including the NULL terminator. On output, this parameter contains the number of characters actually written to
///                          the buffer pointed to by the <i>AddressString</i> parameter.
///Returns:
///    If the function succeeds, the return value is <b>STATUS_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>STATUS_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was
///    passed to the function. This error is returned if a <b>NULL</b> pointer is passed in the <i>AddressString</i> or
///    <i>AddressStringLength</i> parameter. This error is also returned if the length of the buffer pointed to by the
///    <i>AddressString</i> parameter is not large enough to receive the string representation of the IPv4 address and
///    port. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage
///    to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("ntdll")
int RtlIpv4AddressToStringExW(const(in_addr)* Address, ushort Port, PWSTR AddressString, uint* AddressStringLength);

///The <b>RtlIpv4StringToAddress</b> function converts a string representation of an IPv4 address to a binary IPv4
///address.
///Params:
///    S = A pointer to a buffer containing the <b>NULL</b>-terminated string representation of the IPv4 address.
///    Strict = A value that indicates whether the string must be an IPv4 address represented in strict four-part dotted-decimal
///             notation. If this parameter is <b>TRUE</b>, the string must be dotted-decimal with four parts. If this parameter
///             is <b>FALSE</b>, any of four possible forms are allowed, with decimal, octal, or hexadecimal notation. See the
///             Remarks section for details.
///    Terminator = A parameter that receives a pointer to the character that terminated the converted string. This can be used by
///                 the caller to extract more information from the string.
///    Addr = A pointer where the binary representation of the IPv4 address is to be stored.
///Returns:
///    If the function succeeds, the return value is <b>STATUS_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>STATUS_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was
///    passed to the function. This error is returned if the <i>Strict</i> parameter was set to <b>TRUE</b>, but the
///    string pointed to by the <i>S</i> parameter did not contain a four-part dotted decimal string representation of
///    an IPv4 address. This error is also returned if the string pointed to by the <i>S</i> parameter did not contain a
///    proper string representation of an IPv4 address. This error code is defined in the Ntstatus.h header file. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain
///    the message string for the returned error. </td> </tr> </table>
///    
@DllImport("ntdll")
int RtlIpv4StringToAddressA(const(PSTR) S, ubyte Strict, PSTR* Terminator, in_addr* Addr);

///The <b>RtlIpv4StringToAddress</b> function converts a string representation of an IPv4 address to a binary IPv4
///address.
///Params:
///    S = A pointer to a buffer containing the <b>NULL</b>-terminated string representation of the IPv4 address.
///    Strict = A value that indicates whether the string must be an IPv4 address represented in strict four-part dotted-decimal
///             notation. If this parameter is <b>TRUE</b>, the string must be dotted-decimal with four parts. If this parameter
///             is <b>FALSE</b>, any of four possible forms are allowed, with decimal, octal, or hexadecimal notation. See the
///             Remarks section for details.
///    Terminator = A parameter that receives a pointer to the character that terminated the converted string. This can be used by
///                 the caller to extract more information from the string.
///    Addr = A pointer where the binary representation of the IPv4 address is to be stored.
///Returns:
///    If the function succeeds, the return value is <b>STATUS_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>STATUS_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was
///    passed to the function. This error is returned if the <i>Strict</i> parameter was set to <b>TRUE</b>, but the
///    string pointed to by the <i>S</i> parameter did not contain a four-part dotted decimal string representation of
///    an IPv4 address. This error is also returned if the string pointed to by the <i>S</i> parameter did not contain a
///    proper string representation of an IPv4 address. This error code is defined in the Ntstatus.h header file. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to obtain
///    the message string for the returned error. </td> </tr> </table>
///    
@DllImport("ntdll")
int RtlIpv4StringToAddressW(const(PWSTR) S, ubyte Strict, PWSTR* Terminator, in_addr* Addr);

///The <b>RtlIpv4StringToAddressEx</b> function converts a string representation of an IPv4 address and port number to a
///binary IPv4 address and port.
///Params:
///    AddressString = A pointer to a buffer containing the <b>NULL</b>-terminated string representation of the IPv4 address followed by
///                    an optional colon and string representation of a port number.
///    Strict = A value that indicates whether the string must be an IPv4 address represented in strict four-part dotted-decimal
///             notation. If this parameter is <b>TRUE</b>, the string must be dotted-decimal with four parts. If this parameter
///             is <b>FALSE</b>, any of four forms are allowed for the string representation of the Ipv4 address, with decimal,
///             octal, or hexadecimal notation. See the Remarks section for details.
///    Address = A pointer where the binary representation of the IPv4 address is to be stored. The IPv4 address is stored in
///              network byte order.
///    Port = A pointer where the binary representation of the port number is to be stored. The port number is returned in
///           network byte order. If no port was specified in the string pointed to by the <i>AddressString</i> parameter, then
///           the <i>Port</i> parameter is set to zero.
///Returns:
///    If the function succeeds, the return value is <b>STATUS_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>STATUS_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was
///    passed to the function. This error is returned if the <i>Strict</i> parameter was set to <b>TRUE</b>, but the
///    string pointed to by the <i>AddressString</i> parameter did not contain a four-part dotted-decimal string
///    representation of an IPv4 address. This error is also returned if the string pointed to by the
///    <i>AddressString</i> parameter did not contain a proper string representation of an IPv4 address. This error code
///    is defined in the Ntstatus.h header file. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl>
///    </td> <td width="60%"> Use FormatMessage to obtain the message string for the returned error. </td> </tr>
///    </table>
///    
@DllImport("ntdll")
int RtlIpv4StringToAddressExW(const(PWSTR) AddressString, ubyte Strict, in_addr* Address, ushort* Port);

///The <b>RtlIpv6AddressToString</b> function converts an IPv6 address to a string in Internet standard format.
///Params:
///    Addr = The IPv6 address in network byte order.
///    S = A pointer to a buffer in which to store the <b>NULL</b>-terminated string representation of the IPv6 address.
///        This buffer should be large enough to hold at least 46 characters.
///Returns:
///    A pointer to the NULL character inserted at the end of the string representation of the IPv6 address. This can be
///    used by the caller to easily append more information to the string.
///    
@DllImport("ntdll")
PSTR RtlIpv6AddressToStringA(const(in6_addr)* Addr, PSTR S);

///The <b>RtlIpv6AddressToString</b> function converts an IPv6 address to a string in Internet standard format.
///Params:
///    Addr = The IPv6 address in network byte order.
///    S = A pointer to a buffer in which to store the <b>NULL</b>-terminated string representation of the IPv6 address.
///        This buffer should be large enough to hold at least 46 characters.
///Returns:
///    A pointer to the NULL character inserted at the end of the string representation of the IPv6 address. This can be
///    used by the caller to easily append more information to the string.
///    
@DllImport("ntdll")
PWSTR RtlIpv6AddressToStringW(const(in6_addr)* Addr, PWSTR S);

///The <b>RtlIpv6AddressToStringEx</b> function converts an IPv6 address, scope ID, and port number to a string.
///Params:
///    Address = The IPv6 address in network byte order.
///    ScopeId = The scope ID of the IPv6 address in network byte order. This parameter is optional.
///    Port = The port number in network byte order format. This parameter is optional.
///    AddressString = A pointer to the buffer to receive the <b>NULL</b>-terminated string representation of the IP address, scope ID,
///                    and port. This buffer should be large enough to hold at least INET6_ADDRSTRLEN characters. The INET6_ADDRSTRLEN
///                    value is defined in the <i>Ws2ipdef.h</i> header file.
///    AddressStringLength = On input, the number of characters that fit in the buffer pointed to by the <i>AddressString</i> parameter,
///                          including the NULL terminator. On output, this parameter contains the number of characters actually written to
///                          the buffer pointed to by the <i>AddressString</i> parameter.
///Returns:
///    If the function succeeds, the return value is <b>STATUS_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>STATUS_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was
///    passed to the function. This error is returned if a <b>NULL</b> pointer is passed in the <i>AddressString</i> or
///    <i>AddressStringLength</i> parameter. This error is also returned if the length of the buffer pointed to by the
///    <i>AddressString</i> parameter is not large enough to receive the string representation of the IPv6 address,
///    scope ID, and port. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use
///    FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("ntdll")
int RtlIpv6AddressToStringExW(const(in6_addr)* Address, uint ScopeId, ushort Port, PWSTR AddressString, 
                              uint* AddressStringLength);

///The <b>RtlIpv6StringToAddress</b> function converts a string representation of an IPv6 address to a binary IPv6
///address.
///Params:
///    S = A pointer to a buffer containing the <b>NULL</b>-terminated string representation of the IPv6 address.
///    Terminator = A parameter that receives a pointer to the character that terminated the converted string. This can be used by
///                 the caller to extract more information from the string.
///    Addr = A pointer where the binary representation of the IPv6 address is to be stored.
///Returns:
///    If the function succeeds, the return value is <b>STATUS_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>STATUS_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was
///    passed to the function. This error is returned if the string pointed to by the <i>S</i> parameter did not contain
///    a proper string representation of an IPv6 address. This error code is defined in the Ntstatus.h header file.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to
///    obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("ntdll")
int RtlIpv6StringToAddressA(const(PSTR) S, PSTR* Terminator, in6_addr* Addr);

///The <b>RtlIpv6StringToAddress</b> function converts a string representation of an IPv6 address to a binary IPv6
///address.
///Params:
///    S = A pointer to a buffer containing the <b>NULL</b>-terminated string representation of the IPv6 address.
///    Terminator = A parameter that receives a pointer to the character that terminated the converted string. This can be used by
///                 the caller to extract more information from the string.
///    Addr = A pointer where the binary representation of the IPv6 address is to be stored.
///Returns:
///    If the function succeeds, the return value is <b>STATUS_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>STATUS_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was
///    passed to the function. This error is returned if the string pointed to by the <i>S</i> parameter did not contain
///    a proper string representation of an IPv6 address. This error code is defined in the Ntstatus.h header file.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use FormatMessage to
///    obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("ntdll")
int RtlIpv6StringToAddressW(const(PWSTR) S, PWSTR* Terminator, in6_addr* Addr);

///The <b>RtlIpv6StringToAddressEx</b> function converts a string representation of an IPv6 address, scope ID, and port
///number to a binary IPv6 address, scope ID, and port.
///Params:
///    AddressString = A pointer to a buffer containing the <b>NULL</b>-terminated string representation of the IPv6 address, scope ID,
///                    and port number.
///    Address = A pointer where the binary representation of the IPv6 address is to be stored.
///    ScopeId = A pointer to where scope ID of the IPv6 address is stored. If <i>AddressString</i> parameter does not contain the
///              string representation of a scope ID, then zero is returned in this parameter.
///    Port = A pointer where the port number is stored. The port number is in network byte order format. If
///           <i>AddressString</i> parameter does not contain the string representation of a port number, then zero is returned
///           in this parameter.
///Returns:
///    If the function succeeds, the return value is <b>STATUS_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>STATUS_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was
///    passed to the function. This error is returned if the string pointed to by the <i>AddressString</i> parameter did
///    not contain a proper string representation of an IPv6 address. This error code is defined in the Ntstatus.h
///    header file. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use
///    FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("ntdll")
int RtlIpv6StringToAddressExW(const(PWSTR) AddressString, in6_addr* Address, uint* ScopeId, ushort* Port);

///The <b>RtlEthernetAddressToString</b> function converts a binary Ethernet address to a string representation of the
///Ethernet MAC address.
///Params:
///    Addr = The Ethernet address in binary format. The Ethernet address is in network order (bytes ordered from left to
///           right).
///    S = A pointer to a buffer in which to store the <b>NULL</b>-terminated string representation of the Ethernet address.
///        This buffer should be large enough to hold at least 18 characters.
///Returns:
///    A pointer to the NULL character inserted at the end of the string representation of the Ethernet MAC address.
///    This can be used by the caller to easily append more information to the string.
///    
@DllImport("ntdll")
PSTR RtlEthernetAddressToStringA(const(DL_EUI48)* Addr, PSTR S);

///The <b>RtlEthernetAddressToString</b> function converts a binary Ethernet address to a string representation of the
///Ethernet MAC address.
///Params:
///    Addr = The Ethernet address in binary format. The Ethernet address is in network order (bytes ordered from left to
///           right).
///    S = A pointer to a buffer in which to store the <b>NULL</b>-terminated string representation of the Ethernet address.
///        This buffer should be large enough to hold at least 18 characters.
///Returns:
///    A pointer to the NULL character inserted at the end of the string representation of the Ethernet MAC address.
///    This can be used by the caller to easily append more information to the string.
///    
@DllImport("ntdll")
PWSTR RtlEthernetAddressToStringW(const(DL_EUI48)* Addr, PWSTR S);

///The <b>RtlEthernetStringToAddress</b> function converts a string representation of an Ethernet MAC address to a
///binary format of the Ethernet address.
///Params:
///    S = A pointer to a buffer containing the <b>NULL</b>-terminated string representation of the Ethernet MAC address.
///    Terminator = A parameter that receives a pointer to the character that terminated the converted string. This can be used by
///                 the caller to extract more information from the string.
///    Addr = A pointer where the binary representation of the Ethernet MAC address is to be stored.
///Returns:
///    If the function succeeds, the return value is <b>STATUS_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>STATUS_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was
///    passed to the function. This error is returned if the string pointed to by the <i>S</i> parameter did not contain
///    a proper string representation of an Ethernet MAC address. This error code is defined in the <i>Ntstatus.h</i>
///    header file. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use
///    FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("ntdll")
int RtlEthernetStringToAddressA(const(PSTR) S, PSTR* Terminator, DL_EUI48* Addr);

///The <b>RtlEthernetStringToAddress</b> function converts a string representation of an Ethernet MAC address to a
///binary format of the Ethernet address.
///Params:
///    S = A pointer to a buffer containing the <b>NULL</b>-terminated string representation of the Ethernet MAC address.
///    Terminator = A parameter that receives a pointer to the character that terminated the converted string. This can be used by
///                 the caller to extract more information from the string.
///    Addr = A pointer where the binary representation of the Ethernet MAC address is to be stored.
///Returns:
///    If the function succeeds, the return value is <b>STATUS_SUCCESS</b>. If the function fails, the return value is
///    one of the following error codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>STATUS_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> An invalid parameter was
///    passed to the function. This error is returned if the string pointed to by the <i>S</i> parameter did not contain
///    a proper string representation of an Ethernet MAC address. This error code is defined in the <i>Ntstatus.h</i>
///    header file. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>Other</b></dt> </dl> </td> <td width="60%"> Use
///    FormatMessage to obtain the message string for the returned error. </td> </tr> </table>
///    
@DllImport("ntdll")
int RtlEthernetStringToAddressW(const(PWSTR) S, PWSTR* Terminator, DL_EUI48* Addr);


