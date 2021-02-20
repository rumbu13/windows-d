// Written in the D programming language.

module windows.networkdrivers;

public import windows.core;
public import windows.systemservices : NTSTATUS, PWSTR;
public import windows.winsock : SCOPE_ID, SOCKET_ADDRESS, in6_addr;

extern(Windows) @nogc nothrow:


// Enums


///The NET_IF_OPER_STATUS enumeration type defines the current NDIS network interface operational status.
alias NET_IF_OPER_STATUS = int;
enum : int
{
    ///Specifies that the interface is ready to transmit and receive all supported packet types.
    NET_IF_OPER_STATUS_UP               = 0x00000001,
    ///Specifies that the interface is not ready to transmit or receive data. For example, the media is disconnected or
    ///the port is not authenticated. In this state, it might be possible to transmit or receive some information. For
    ///example, if the interface is down because it has not been authenticated, 802.1<i>x</i> authentication packets can
    ///be transmitted and received.
    NET_IF_OPER_STATUS_DOWN             = 0x00000002,
    ///Specifies that the interface is in a test mode and no operational packets can be transmitted or received.
    NET_IF_OPER_STATUS_TESTING          = 0x00000003,
    ///Specifies that the operational status of the network interface cannot be determined.
    NET_IF_OPER_STATUS_UNKNOWN          = 0x00000004,
    ///Specifies that the network interface cannot send or receive packets because the interface is waiting for an
    ///external event.
    NET_IF_OPER_STATUS_DORMANT          = 0x00000005,
    ///Specifies that the network interface is not ready to transmit or receive data because a component is missing in
    ///the managed system. This state is more specific than, but similar to, the <b>NET_IF_OPER_STATUS_DOWN</b> state.
    NET_IF_OPER_STATUS_NOT_PRESENT      = 0x00000006,
    NET_IF_OPER_STATUS_LOWER_LAYER_DOWN = 0x00000007,
}

///The NET_IF_ADMIN_STATUS enumeration type specifies the NDIS network interface administrative status, as described in
///RFC 2863.
alias NET_IF_ADMIN_STATUS = int;
enum : int
{
    ///Specifies that the interface is initialized and enabled, but the interface is not necessarily ready to transmit
    ///and receive network data because that depends on the operational status of the interface. For more information
    ///about the operational status of an interface, see OID_GEN_OPERATIONAL_STATUS.
    NET_IF_ADMIN_STATUS_UP      = 0x00000001,
    ///Specifies that the interface is down, and this interface cannot be used to transmit or receive network data.
    NET_IF_ADMIN_STATUS_DOWN    = 0x00000002,
    ///Specifies that the interface is in a test mode, and no network data can be transmitted or received.
    NET_IF_ADMIN_STATUS_TESTING = 0x00000003,
}

///The NET_IF_CONNECTION_TYPE enumeration type specifies the NDIS network interface connection type.
alias NET_IF_CONNECTION_TYPE = int;
enum : int
{
    ///Specifies the dedicated connection type. The connection comes up automatically when media sense is <b>TRUE</b>.
    ///For example, an Ethernet connection is dedicated.
    NET_IF_CONNECTION_DEDICATED = 0x00000001,
    ///Specifies the passive connection type. The other end must bring up the connection to the local station. For
    ///example, the RAS interface is passive.
    NET_IF_CONNECTION_PASSIVE   = 0x00000002,
    ///Specifies the demand-dial connection type. A demand-dial connection comes up in response to a local action--for
    ///example, sending a packet.
    NET_IF_CONNECTION_DEMAND    = 0x00000003,
    NET_IF_CONNECTION_MAXIMUM   = 0x00000004,
}

///The TUNNEL_TYPE enumeration type defines the encapsulation method used by a tunnel, as described by the Internet
///Assigned Names Authority (IANA).
alias TUNNEL_TYPE = int;
enum : int
{
    ///Indicates that a tunnel is not specified.
    TUNNEL_TYPE_NONE    = 0x00000000,
    ///Indicates that none of the following tunnel types is specified.
    TUNNEL_TYPE_OTHER   = 0x00000001,
    ///Specifies that a packet is encapsulated directly within a normal IP header, with no intermediate header, and the
    ///packet is sent unicast to the remote tunnel endpoint.
    TUNNEL_TYPE_DIRECT  = 0x00000002,
    ///Specifies that an IPv6 packet is encapsulated directly within an IPv4 header, with no intermediate header, and
    ///the packet is sent unicast to the destination determined by the 6to4 protocol.
    TUNNEL_TYPE_6TO4    = 0x0000000b,
    ///Specifies that an IPv6 packet is encapsulated directly within an IPv4 header, with no intermediate header, and
    ///the packet is sent unicast to the destination determined by the ISATAP protocol.
    TUNNEL_TYPE_ISATAP  = 0x0000000d,
    ///Specifies that the tunnel uses Teredo encapsulation.
    TUNNEL_TYPE_TEREDO  = 0x0000000e,
    ///Specifies that the tunnel uses IP over Hypertext Transfer Protocol Secure (HTTPS). This tunnel type is supported
    ///in Windows 7 and later versions of the Windows operating system.
    TUNNEL_TYPE_IPHTTPS = 0x0000000f,
}

///The NET_IF_ACCESS_TYPE enumeration type specifies the NDIS network interface access type.
alias NET_IF_ACCESS_TYPE = int;
enum : int
{
    ///Specifies the loopback access type. This access type indicates that the interface loops back transmit data as
    ///receive data.
    NET_IF_ACCESS_LOOPBACK             = 0x00000001,
    ///Specifies the LAN access type, which includes Ethernet. This access type indicates that the interface provides
    ///native support for multicast or broadcast services.
    NET_IF_ACCESS_BROADCAST            = 0x00000002,
    ///Specifies point-to-point access that supports CoNDIS and WAN, except for non-broadcast multi-access (NBMA)
    ///interfaces.
    NET_IF_ACCESS_POINT_TO_POINT       = 0x00000003,
    ///Specifies point-to-multipoint access that supports non-broadcast multi-access (NBMA) media, including the "RAS
    ///Internal" interface, and native (non-LANE) ATM.
    NET_IF_ACCESS_POINT_TO_MULTI_POINT = 0x00000004,
    NET_IF_ACCESS_MAXIMUM              = 0x00000005,
}

///The NET_IF_ACCESS_TYPE enumeration type specifies the NDIS network interface direction type.
alias NET_IF_DIRECTION_TYPE = int;
enum : int
{
    ///Indicates the send and receive direction type. This direction type indicates that the NDIS network interface can
    ///send and receive data.
    NET_IF_DIRECTION_SENDRECEIVE = 0x00000000,
    ///Indicates the send only direction type. This direction type indicates that the NDIS network interface can only
    ///send data.
    NET_IF_DIRECTION_SENDONLY    = 0x00000001,
    ///Indicates the receive only direction type. This direction type indicates that the NDIS network interface can only
    ///receive data.
    NET_IF_DIRECTION_RECEIVEONLY = 0x00000002,
    NET_IF_DIRECTION_MAXIMUM     = 0x00000003,
}

///The NET_IF_MEDIA_CONNECT_STATE enumeration type specifies the NDIS network interface connection state.
alias NET_IF_MEDIA_CONNECT_STATE = int;
enum : int
{
    ///The connection state of the interface is unknown.
    MediaConnectStateUnknown      = 0x00000000,
    ///The interface is connected to the network.
    MediaConnectStateConnected    = 0x00000001,
    ///The interface is not connected to the network.
    MediaConnectStateDisconnected = 0x00000002,
}

///The NET_IF_MEDIA_DUPLEX_STATE enumeration type specifies the NDIS network interface duplex state.
alias NET_IF_MEDIA_DUPLEX_STATE = int;
enum : int
{
    ///The duplex state of the miniport adapter is unknown.
    MediaDuplexStateUnknown = 0x00000000,
    ///The miniport adapter can transmit or receive but not both simultaneously.
    MediaDuplexStateHalf    = 0x00000001,
    ///The miniport adapter can transmit and receive simultaneously.
    MediaDuplexStateFull    = 0x00000002,
}

///The MIB_IF_TABLE_LEVEL enumeration type defines the level of interface information to retrieve.
alias MIB_IF_TABLE_LEVEL = int;
enum : int
{
    ///The values of statistics and state that are returned in members of the MIB_IF_ROW2 structure in the MIB_IF_TABLE2
    ///structure that the <i>Table</i> parameter points to in the GetIfTable2Ex function are returned from the top of
    ///the filter stack.
    MibIfTableNormal                  = 0x00000000,
    ///The values of statistics and state that are returned in members of the MIB_IF_ROW2 structure in the MIB_IF_TABLE2
    ///structure that the <i>Table</i> parameter points to in the GetIfTable2Ex function are returned directly for the
    ///interface that is being queried.
    MibIfTableRaw                     = 0x00000001,
    ///<div class="alert"><b>Note</b> This value is available starting with Windows 10, version 1703.</div> <div> </div>
    ///The values returned are the same as for the <b>MibIfTableNormal </b> value, but without the statistics.
    MibIfTableNormalWithoutStatistics = 0x00000002,
}

///The NL_ROUTE_PROTOCOL enumeration type defines the routing mechanism that an IP route was added with, as described in
///RFC 4292.
alias NL_ROUTE_PROTOCOL = int;
enum : int
{
    ///Reserved for system use. Do not use this value in your driver.
    RouteProtocolOther            = 0x00000001,
    ///Reserved for system use. Do not use this value in your driver.
    RouteProtocolLocal            = 0x00000002,
    ///Reserved for system use. Do not use this value in your driver.
    RouteProtocolNetMgmt          = 0x00000003,
    ///Reserved for system use. Do not use this value in your driver.
    RouteProtocolIcmp             = 0x00000004,
    ///Reserved for system use. Do not use this value in your driver.
    RouteProtocolEgp              = 0x00000005,
    ///Reserved for system use. Do not use this value in your driver.
    RouteProtocolGgp              = 0x00000006,
    ///Reserved for system use. Do not use this value in your driver.
    RouteProtocolHello            = 0x00000007,
    ///Reserved for system use. Do not use this value in your driver.
    RouteProtocolRip              = 0x00000008,
    ///Reserved for system use. Do not use this value in your driver.
    RouteProtocolIsIs             = 0x00000009,
    ///Reserved for system use. Do not use this value in your driver.
    RouteProtocolEsIs             = 0x0000000a,
    ///Reserved for system use. Do not use this value in your driver.
    RouteProtocolCisco            = 0x0000000b,
    ///Reserved for system use. Do not use this value in your driver.
    RouteProtocolBbn              = 0x0000000c,
    ///Reserved for system use. Do not use this value in your driver.
    RouteProtocolOspf             = 0x0000000d,
    ///Reserved for system use. Do not use this value in your driver.
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

///The NL_ADDRESS_TYPE enumeration type specifies the IP address type of the network layer.
alias NL_ADDRESS_TYPE = int;
enum : int
{
    ///The unspecified IP address. For example, for IPv4, this address is 0.0.0.0.
    NlatUnspecified = 0x00000000,
    ///Any IPv4 or IPv6 unicast address.
    NlatUnicast     = 0x00000001,
    ///An IPv6 anycast address.
    NlatAnycast     = 0x00000002,
    ///An IPv4 or IPv6 multicast address.
    NlatMulticast   = 0x00000003,
    ///An IPv4 broadcast address.
    NlatBroadcast   = 0x00000004,
    NlatInvalid     = 0x00000005,
}

///The NL_ROUTE_ORIGIN enumeration type defines the origin of the IP route.
alias NL_ROUTE_ORIGIN = int;
enum : int
{
    ///The route is a result of manual configuration.
    NlroManual              = 0x00000000,
    ///The route is a well-known route.
    NlroWellKnown           = 0x00000001,
    ///The route is a result of DHCP configuration.
    NlroDHCP                = 0x00000002,
    ///The route is a result of router advertisement.
    NlroRouterAdvertisement = 0x00000003,
    Nlro6to4                = 0x00000004,
}

///The NL_NEIGHBOR_STATE enumeration type defines the state of a network layer neighbor IP address, as described in RFC
///2461, section 7.3.2.
alias NL_NEIGHBOR_STATE = int;
enum : int
{
    ///The IP address is unreachable.
    NlnsUnreachable = 0x00000000,
    ///Address resolution is in progress and the link-layer address of the neighbor has not yet been determined.
    ///Specifically for IPv6, a Neighbor Solicitation message has been sent to the solicited-node multicast IP address
    ///of the target, but the corresponding neighbor advertisement has not yet been received.
    NlnsIncomplete  = 0x00000001,
    ///The neighbor is no longer known to be reachable, and probes are being sent to verify reachability. For IPv6, a
    ///reachability confirmation is actively being sought by regularly retransmitting unicast Neighbor Solicitation
    ///probes until a reachability confirmation is received.
    NlnsProbe       = 0x00000002,
    ///The neighbor is no longer known to be reachable, and traffic has recently been sent to the neighbor. However,
    ///instead of probing the neighbor immediately, sending probes is delayed for a short time to give upper layer
    ///protocols an opportunity to provide reachability confirmation. For IPv6, more time has elapsed than is specified
    ///in the <b>ReachabilityTime.ReachableTime</b> member of the MIB_IPNET_ROW2 structure since the last positive
    ///confirmation was received that the forward path was functioning properly and a packet was sent. If no
    ///reachability confirmation is received within a period of time (used to delay the first probe) of entering the
    ///<b>NlnsDelay</b> state, a IPv6 Neighbor Solicitation (NS) message is sent, and the <b>State</b> member of
    ///MIB_IPNET_ROW2 is changed to NlnsProbe.
    NlnsDelay       = 0x00000003,
    ///The neighbor is no longer known to be reachable, but until traffic is sent to the neighbor, no attempt should be
    ///made to verify its reachability. For IPv6, more time has elapsed than is specified in the
    ///<b>ReachabilityTime.ReachableTime</b> member of the MIB_IPNET_ROW2 structure since the last positive confirmation
    ///was received that the forward path was functioning properly. While the <b>State</b> member of MIB_IPNET_ROW2 is
    ///NlnsStale, no action occurs until a packet is sent. The <b>NlnsStale</b> state is entered upon receiving an
    ///unsolicited neighbor discovery message that updates the cached IP address. Receipt of such a message does not
    ///confirm reachability, and entering the NlnsStale state insures reachability is verified quickly if the entry is
    ///actually being used. However, reachability is not actually verified until the entry is actually used.
    NlnsStale       = 0x00000004,
    ///The neighbor is known to have been reachable recently (within tens of seconds ago). For IPv6, a positive
    ///confirmation was received within the time that is specified in the <b>ReachabilityTime.ReachableTime</b> member
    ///of the MIB_IPNET_ROW2 structure that the forward path to the neighbor was functioning properly. While the
    ///<b>State</b> member of MIB_IPNET_ROW2 is NlnsReachable, no special action occurs as packets are sent.
    NlnsReachable   = 0x00000005,
    ///The IP address is a permanent address.
    NlnsPermanent   = 0x00000006,
    ///A maximum value for testing purposes.
    NlnsMaximum     = 0x00000007,
}

///The NL_LINK_LOCAL_ADDRESS_BEHAVIOR enumeration type defines the link local address behavior.
alias NL_LINK_LOCAL_ADDRESS_BEHAVIOR = int;
enum : int
{
    ///A link local IP address should never be used.
    LinkLocalAlwaysOff = 0x00000000,
    ///A link local IP address should be used only if no other address is available. This setting is the default setting
    ///for an IPv4 interface.
    LinkLocalDelayed   = 0x00000001,
    ///A link local IP address should always be used. This setting is the default setting for an IPv6 interface.
    LinkLocalAlwaysOn  = 0x00000002,
    LinkLocalUnchanged = 0xffffffff,
}

///The NL_ROUTER_DISCOVERY_BEHAVIOR enumeration type defines the router discovery behavior, as described in RFC 2461.
alias NL_ROUTER_DISCOVERY_BEHAVIOR = int;
enum : int
{
    ///Router discovery is disabled.
    RouterDiscoveryDisabled  = 0x00000000,
    ///Router discovery is enabled. This setting is the default value for IPv6.
    RouterDiscoveryEnabled   = 0x00000001,
    ///Router discovery is configured based on DHCP. This setting is the default value for IPv4.
    RouterDiscoveryDhcp      = 0x00000002,
    ///When the properties of an IP interface are being set, the value for router discovery should be unchanged.
    RouterDiscoveryUnchanged = 0xffffffff,
}

// Structs


///The NET_PHYSICAL_LOCATION structure provides NDIS with information about the physical location of a registered
///network interface.
struct NET_PHYSICAL_LOCATION_LH
{
    ///The bus number of the physical location for hardware. If the physical location is unknown, set this member to
    ///NIIF_BUS_NUMBER_UNKNOWN. Other values are reserved for NDIS.
    uint BusNumber;
    ///The slot number of the physical location for hardware. If the physical location is unknown, set this member to
    ///NIIF_SLOT_NUMBER_UNKNOWN. Other values are reserved for NDIS.
    uint SlotNumber;
    ///The function number of the physical location for hardware. If the physical location is unknown, set this member
    ///to NIIF_FUNCTION_NUMBER_UNKNOWN. Other values are reserved for NDIS.
    uint FunctionNumber;
}

///The <b>IF_COUNTED_STRING</b> structure specifies a counted string for NDIS interfaces.
struct IF_COUNTED_STRING_LH
{
    ///A USHORT value that contains the length, in bytes, of the string.
    ushort      Length;
    ///A WCHAR buffer that contains the string. The string does not need to be null-terminated.
    ushort[257] String;
}

///The NDIS_INTERFACE_INFORMATION structure provides information about a network interface for the
///OID_GEN_INTERFACE_INFO OID.
struct NDIS_INTERFACE_INFORMATION
{
    ///The operational status of the interface. This status is the same as the value that the OID_GEN_OPERATIONAL_STATUS
    ///OID returns.
    NET_IF_OPER_STATUS ifOperStatus;
    ///The operational status flags of the interface. This field is reserved for the NDIS proxy interface provider.
    ///Other interface providers should set this member to zero.
    uint               ifOperStatusFlags;
    ///The NET_IF_MEDIA_CONNECT_STATE connection state type.
    NET_IF_MEDIA_CONNECT_STATE MediaConnectState;
    ///The media duplex state of the interface. This state is the same as the value that the OID_GEN_MEDIA_DUPLEX_STATE
    ///OID returns.
    NET_IF_MEDIA_DUPLEX_STATE MediaDuplexState;
    ///The maximum transmission unit (MTU) of the interface. This MTU is the same as the value that the
    ///OID_GEN_MAXIMUM_FRAME_SIZE OID returns.
    uint               ifMtu;
    ///A Boolean value that is <b>TRUE</b> if the interface is in promiscuous mode or <b>FALSE</b> if it is not. This
    ///value is the same as the value that OID_GEN_PROMISCUOUS_MODE OID query returns.
    ubyte              ifPromiscuousMode;
    ///A Boolean value that is <b>TRUE</b> if the interface supports wake-on-LAN capability and the capability is
    ///enabled, or <b>FALSE</b> if it does not.
    ubyte              ifDeviceWakeUpEnable;
    ///The transmit link speed, in bytes per second, of the interface. This speed is the same as the value that an
    ///OID_GEN_XMIT_LINK_SPEED OID query returns.
    ulong              XmitLinkSpeed;
    ///The receive link speed, in bytes per second, of the interface. This speed is the same as the value that an
    ///OID_GEN_RCV_LINK_SPEED OID query returns.
    ulong              RcvLinkSpeed;
    ///The time that the interface entered its current operational state. This time is the same as the value that an
    ///OID_GEN_LAST_CHANGE OID query returns.
    ulong              ifLastChange;
    ///The time of the last discontinuity of the interface's counters. This time is the same as the value that an
    ///OID_GEN_DISCONTINUITY_TIME OID query returns.
    ulong              ifCounterDiscontinuityTime;
    ///The number of packets that were received through the interface and that were discarded because of an unknown or
    ///unsupported protocol. This number is the same as the value that an OID_GEN_UNKNOWN_PROTOS OID query returns.
    ulong              ifInUnknownProtos;
    ///The number of inbound packets that were discarded even though no errors had been detected to prevent them from
    ///being deliverable to a higher-layer protocol. This number is the same as the value that an OID_GEN_RCV_DISCARDS
    ///OID query returns.
    ulong              ifInDiscards;
    ///The number of inbound packets that contained errors that prevented them from being deliverable to a higher layer
    ///protocol. This number is the same as the value that an OID_GEN_RCV_ERROR OID query returns.
    ulong              ifInErrors;
    ///The total number of bytes that are received on this interface. This number is the same as the value that an
    ///OID_GEN_BYTES_RCV OID returns.
    ulong              ifHCInOctets;
    ///The number of directed packets that are received without errors on the interface. This number is the same as the
    ///value that an OID_GEN_DIRECTED_FRAMES_RCV OID query returns.
    ulong              ifHCInUcastPkts;
    ///The number of multicast/functional packets that are received without errors on the interface. This number is the
    ///same as the value that an OID_GEN_MULTICAST_FRAMES_RCV OID query returns.
    ulong              ifHCInMulticastPkts;
    ///The number of broadcast packets that are received without errors on the interface. This number is the same as the
    ///value that an OID_GEN_BROADCAST_FRAMES_RCV OID query returns.
    ulong              ifHCInBroadcastPkts;
    ///The number of bytes that are transmitted without errors on the interface. This number is the same as the value
    ///that an OID_GEN_BYTES_XMIT OID query returns.
    ulong              ifHCOutOctets;
    ///The number of directed packets that are transmitted without errors on the interface. This number is the same as
    ///the value that an OID_GEN_DIRECTED_FRAMES_XMIT OID query returns.
    ulong              ifHCOutUcastPkts;
    ///The number of multicast/functional packets that are transmitted without errors on the interface. This number is
    ///the same as the value that an OID_GEN_MULTICAST_FRAMES_XMIT OID query returns.
    ulong              ifHCOutMulticastPkts;
    ///The number of broadcast packets that are transmitted without errors on the interface. This number is the same as
    ///the value that an OID_GEN_BROADCAST_FRAMES_XMIT OID query returns.
    ulong              ifHCOutBroadcastPkts;
    ///The number of packets that the interface fails to transmit. This number is the same as the value that an
    ///OID_GEN_XMIT_ERROR OID query returns.
    ulong              ifOutErrors;
    ///The number of packets that the interface discards. This number is the same as the value that an
    ///OID_GEN_XMIT_DISCARDS OID query returns.
    ulong              ifOutDiscards;
    ///The number of bytes in directed packets that are received without errors. This count is the same value that
    ///OID_GEN_DIRECTED_BYTES_RCV returns.
    ulong              ifHCInUcastOctets;
    ///The number of bytes in multicast/functional packets that are received without errors. This count is the same
    ///value that OID_GEN_MULTICAST_BYTES_RCV returns.
    ulong              ifHCInMulticastOctets;
    ///The number of bytes in broadcast packets that are received without errors. This count is the same value that
    ///OID_GEN_BROADCAST_BYTES_RCV returns.
    ulong              ifHCInBroadcastOctets;
    ///The number of bytes in directed packets that are transmitted without errors. This count is the same value that
    ///OID_GEN_DIRECTED_BYTES_XMIT returns.
    ulong              ifHCOutUcastOctets;
    ///The number of bytes in multicast/functional packets that are transmitted without errors. This count is the same
    ///value that OID_GEN_MULTICAST_BYTES_XMIT returns.
    ulong              ifHCOutMulticastOctets;
    ///The number of bytes in broadcast packets that are transmitted without errors. This count is the same value that
    ///OID_GEN_BROADCAST_BYTES_XMIT returns.
    ulong              ifHCOutBroadcastOctets;
    ///The compartment that the interface belongs to, if the interface provider can provide the ID of the compartment to
    ///which the interface belongs. Otherwise, it should return NET_IF_COMPARTMENT_ID_UNSPECIFIED. If the interface
    ///provider returns NET_IF_COMPARTMENT_ID_UNSPECIFIED for the compartment ID, NDIS will return the right compartment
    ///ID for this interface.
    uint               CompartmentId;
    ///The supported statistics. For more information, see the <b>SupportedStatistics</b> member of the
    ///NDIS_MINIPORT_ADAPTER_GENERAL_ATTRIBUTES structure.
    uint               SupportedStatistics;
}

///The SOCKET_ADDRESS_LIST structure defines a variable-sized list of transport addresses.
struct SOCKET_ADDRESS_LIST
{
    ///The number of transport addresses in the list.
    int               iAddressCount;
    ///A variable-sized array of SOCKET_ADDRESS structures. The SOCKET_ADDRESS structure is defined as follows: ```
    ///typedef struct _SOCKET_ADDRESS { LPSOCKADDR lpSockaddr; INT iSockaddrLength; } SOCKET_ADDRESS, *PSOCKET_ADDRESS,
    ///*LPSOCKET_ADDRESS; ```
    SOCKET_ADDRESS[1] Address;
}

///The SOCKADDR_STORAGE structure is a generic structure that specifies a transport address.
struct SOCKADDR_STORAGE_LH
{
    ///The address family for the transport address. For more information about supported address families, see WSK
    ///Address Families.
    ushort    ss_family;
    ///A padding of 6 bytes that puts the <b>__ss_align</b> member on an eight-byte boundary within the structure.
    byte[6]   __ss_pad1;
    ///A 64-bit value that forces the structure to be 8-byte aligned.
    long      __ss_align;
    ///A padding of an additional 112 bytes that brings the total size of the SOCKADDR_STORAGE structure to 128 bytes.
    byte[112] __ss_pad2;
}

///The SOCKADDR_IN6 structure specifies a transport address and port for the AF_INET6 address family.
struct SOCKADDR_IN6_LH
{
    ///The address family for the transport address. This member should always be set to AF_INET6.
    ushort   sin6_family;
    ///A transport protocol port number.
    ushort   sin6_port;
    ///The IPv6 flow information.
    uint     sin6_flowinfo;
    ///An IN6_ADDR structure that contains an IPv6 transport address.
    in6_addr sin6_addr;
union
    {
        uint     sin6_scope_id;
        SCOPE_ID sin6_scope_struct;
    }
}

///<div class="alert"><b>Important</b> The Native 802.11 Wireless LAN interface is deprecated in Windows 10 and later.
///Please use the WLAN Device Driver Interface (WDI) instead. For more information about WDI, see WLAN Universal Windows
///driver model.</div><div> </div>The L2_NOTIFICATION_DATA structure is used by the IHV Extensions DLL to send
///notifications to any service or applications that has registered for the notification.
struct L2_NOTIFICATION_DATA
{
    ///This member specifies where the notification comes from. The IHV Extensions DLL must set this member to
    ///L2_NOTIFICATION_SOURCE_WLAN_IHV.
    uint  NotificationSource;
    ///This member specifies the notification code for the status indication. This notification code must not have the
    ///bit 0x10000 set.
    uint  NotificationCode;
    ///The globally unique identifier (GUID) for the wireless LAN (WLAN) adapter. The operating system passes the GUID
    ///and other data related to the WLAN adapter through the <i>pDot11Adapter</i> parameter of the
    ///Dot11ExtIhvInitAdapter function, which the operating system calls when it detects the arrival of the WLAN
    ///adapter. For more information about this operation, see <a
    ///href="/windows/desktop/api/l2cmn/ns-l2cmn-l2_notification_data">802.11 WLAN Adapter Arrival</a>.
    GUID  InterfaceGuid;
    ///The length, in bytes, of the data within the buffer referenced by the <b>pData</b> member. The IHV Extensions DLL
    ///must set this member to zero if additional data is not required for the notification.
    uint  dwDataSize;
    void* pData;
}

// Functions

///Reserved for future use. Do not use this function.
@DllImport("IPHLPAPI")
uint GetCurrentThreadCompartmentId();

///Reserved for future use. Do not use this function.
@DllImport("IPHLPAPI")
NTSTATUS SetCurrentThreadCompartmentId(uint CompartmentId);

///Reserved for future use. Do not use this function.
@DllImport("IPHLPAPI")
uint GetSessionCompartmentId(uint SessionId);

///Reserved for future use. Do not use this function.
///Params:
///    SessionId = Reserved.
@DllImport("IPHLPAPI")
NTSTATUS SetSessionCompartmentId(uint SessionId, uint CompartmentId);

///Reserved for future use. Do not use this function.
///Params:
///    NetworkGuid = Reserved.
///    CompartmentId = Reserved.
///    SiteId = Reserved.
///    NetworkName = Reserved.
@DllImport("IPHLPAPI")
NTSTATUS GetNetworkInformation(const(GUID)* NetworkGuid, uint* CompartmentId, uint* SiteId, PWSTR NetworkName, 
                               uint Length);

///Reserved for future use. Do not use this function.
///Params:
///    NetworkGuid = Reserved.
///    CompartmentId = Reserved.
@DllImport("IPHLPAPI")
NTSTATUS SetNetworkInformation(const(GUID)* NetworkGuid, uint CompartmentId, const(PWSTR) NetworkName);


