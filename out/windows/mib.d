// Written in the D programming language.

module windows.mib;

public import windows.core;
public import windows.iphelper : IF_OPER_STATUS, INTERNAL_IF_OPER_STATUS, IP_ADDRESS_PREFIX,
                                 MIB_IPFORWARD_TYPE, MIB_IPNET_TYPE,
                                 MIB_IPSTATS_FORWARDING, MIB_TCP_STATE,
                                 NET_LUID_LH, NL_BANDWIDTH_INFORMATION,
                                 NL_DAD_STATE, NL_PREFIX_ORIGIN, NL_SUFFIX_ORIGIN,
                                 SOCKADDR_INET, TCP_RTO_ALGORITHM;
public import windows.nativewifi : NDIS_MEDIUM, NDIS_PHYSICAL_MEDIUM;
public import windows.networkdrivers : NET_IF_ACCESS_TYPE, NET_IF_ADMIN_STATUS,
                                       NET_IF_CONNECTION_TYPE, NET_IF_DIRECTION_TYPE,
                                       NET_IF_MEDIA_CONNECT_STATE,
                                       NL_LINK_LOCAL_ADDRESS_BEHAVIOR,
                                       NL_NEIGHBOR_STATE, NL_ROUTER_DISCOVERY_BEHAVIOR,
                                       NL_ROUTE_ORIGIN, NL_ROUTE_PROTOCOL,
                                       TUNNEL_TYPE;
public import windows.systemservices : BOOL, LARGE_INTEGER;
public import windows.winsock : SCOPE_ID, in6_addr;

extern(Windows):


// Enums


///The <b>MIB_NOTIFICATION_TYPE</b> enumeration defines the notification type passed to a callback function when a
///notification occurs.
alias MIB_NOTIFICATION_TYPE = int;
enum : int
{
    ///A parameter was changed.
    MibParameterNotification = 0x00000000,
    ///A new MIB instance was added.
    MibAddInstance           = 0x00000001,
    ///An existing MIB instance was deleted.
    MibDeleteInstance        = 0x00000002,
    ///A notification that is invoked immediately after registration for change notification completes. This initial
    ///notification does not indicate a change occurred to a MIB instance. The purpose of this initial notification type
    ///is to provide confirmation that the callback function is properly registered.
    MibInitialNotification   = 0x00000003,
}

///The <b>ICMP6_TYPE</b> enumeration defines the set of Internet Control Message Protocol for IP version 6.0 (ICMPv6)
///message types.
alias ICMP6_TYPE = int;
enum : int
{
    ///The specified destination for the message is unreachable.
    ICMP6_DST_UNREACH          = 0x00000001,
    ///The ICMPv6 packet is too large.
    ICMP6_PACKET_TOO_BIG       = 0x00000002,
    ///The ICMPv6 message has timed out.
    ICMP6_TIME_EXCEEDED        = 0x00000003,
    ///The IPv6 header is malformed or contains an incorrect value.
    ICMP6_PARAM_PROB           = 0x00000004,
    ///ICMPv6 echo request message.
    ICMP6_ECHO_REQUEST         = 0x00000080,
    ///ICMPv6 echo reply message.
    ICMP6_ECHO_REPLY           = 0x00000081,
    ///ICMPv6 group membership query message.
    ICMP6_MEMBERSHIP_QUERY     = 0x00000082,
    ///ICMPv6 group membership report message.
    ICMP6_MEMBERSHIP_REPORT    = 0x00000083,
    ///ICMPv6 group membership reduction message.
    ICMP6_MEMBERSHIP_REDUCTION = 0x00000084,
    ///ICMPv6 router solicitation message.
    ND_ROUTER_SOLICIT          = 0x00000085,
    ///ICMPv6 router advertisement message.
    ND_ROUTER_ADVERT           = 0x00000086,
    ///ICMPv6 network neighbor solicitation message.
    ND_NEIGHBOR_SOLICIT        = 0x00000087,
    ///ICMPv6 network neighbor advertisement message.
    ND_NEIGHBOR_ADVERT         = 0x00000088,
    ///ICMPv6 packet redirection message.
    ND_REDIRECT                = 0x00000089,
    ICMP6_V2_MEMBERSHIP_REPORT = 0x0000008f,
}

///The <b>ICMP4_TYPE</b> enumeration defines the set of Internet Control Message Protocol (ICMP) for IP version 4.0
///(IPv4) message types.
alias ICMP4_TYPE = int;
enum : int
{
    ///ICMP echo reply message.
    ICMP4_ECHO_REPLY        = 0x00000000,
    ///The specified destination for the message is unreachable.
    ICMP4_DST_UNREACH       = 0x00000003,
    ///ICMP source quench message.
    ICMP4_SOURCE_QUENCH     = 0x00000004,
    ///ICMP redirection message.
    ICMP4_REDIRECT          = 0x00000005,
    ///ICMP echo redirection message.
    ICMP4_ECHO_REQUEST      = 0x00000008,
    ///ICMP router advertisement message.
    ICMP4_ROUTER_ADVERT     = 0x00000009,
    ///ICMP router solicitation message.
    ICMP4_ROUTER_SOLICIT    = 0x0000000a,
    ///The ICMPv6 message has timed out.
    ICMP4_TIME_EXCEEDED     = 0x0000000b,
    ///The IPv4 header is malformed or contains an incorrect value.
    ICMP4_PARAM_PROB        = 0x0000000c,
    ///ICMP timestamp request message.
    ICMP4_TIMESTAMP_REQUEST = 0x0000000d,
    ///ICMP timestamp reply message.
    ICMP4_TIMESTAMP_REPLY   = 0x0000000e,
    ///ICMP mask request message.
    ICMP4_MASK_REQUEST      = 0x00000011,
    ///ICMP mask reply message.
    ICMP4_MASK_REPLY        = 0x00000012,
}

///The <b>TCP_CONNECTION_OFFLOAD_STATE</b> enumeration defines the possible TCP offload states for a TCP connection.
alias TCP_CONNECTION_OFFLOAD_STATE = int;
enum : int
{
    ///The TCP connection is currently owned by the network stack on the local computer, and is not offloaded
    TcpConnectionOffloadStateInHost     = 0x00000000,
    ///The TCP connection is in the process of being offloaded, but the offload has not been completed.
    TcpConnectionOffloadStateOffloading = 0x00000001,
    ///The TCP connection is offloaded to the network interface controller.
    TcpConnectionOffloadStateOffloaded  = 0x00000002,
    ///The TCP connection is in the process of being uploaded back to the network stack on the local computer, but the
    ///reinstate-to-host process has not completed.
    TcpConnectionOffloadStateUploading  = 0x00000003,
    ///The maximum possible value for the TCP_CONNECTION_OFFLOAD_STATE enumeration type. This is not a legal value for
    ///the possible TCP connection offload state.
    TcpConnectionOffloadStateMax        = 0x00000004,
}

// Structs


///The <b>MIB_IF_ROW2</b> structure stores information about a particular interface.
struct MIB_IF_ROW2
{
    ///Type: <b>NET_LUID</b> The locally unique identifier (LUID) for the network interface.
    NET_LUID_LH          InterfaceLuid;
    ///Type: <b>NET_IFINDEX</b> The index that identifies the network interface. This index value may change when a
    ///network adapter is disabled and then enabled, and should not be considered persistent.
    uint                 InterfaceIndex;
    ///Type: <b>GUID</b> The GUID for the network interface.
    GUID                 InterfaceGuid;
    ///Type: <b>WCHAR[IF_MAX_STRING_SIZE + 1]</b> A NULL-terminated Unicode string that contains the alias name of the
    ///network interface.
    ushort[257]          Alias;
    ///Type: <b>WCHAR[IF_MAX_STRING_SIZE + 1]</b> A NULL-terminated Unicode string that contains a description of the
    ///network interface.
    ushort[257]          Description;
    ///Type: <b>ULONG</b> The length, in bytes, of the physical hardware address specified by the <b>PhysicalAddress</b>
    ///member.
    uint                 PhysicalAddressLength;
    ///Type: <b> UCHAR[IF_MAX_PHYS_ADDRESS_LENGTH]</b> The physical hardware address of the adapter for this network
    ///interface.
    ubyte[32]            PhysicalAddress;
    ///Type: <b> UCHAR[IF_MAX_PHYS_ADDRESS_LENGTH]</b> The permanent physical hardware address of the adapter for this
    ///network interface.
    ubyte[32]            PermanentPhysicalAddress;
    ///Type: <b>ULONG</b> The maximum transmission unit (MTU) size, in bytes, for this network interface.
    uint                 Mtu;
    ///Type: <b>IFTYPE</b> The interface type as defined by the Internet Assigned Names Authority (IANA). For more
    ///information, see http://www.iana.org/assignments/ianaiftype-mib. Possible values for the interface type are
    ///listed in the <i>Ipifcons.h</i> header file. The table below lists common values for the interface type although
    ///many other values are possible. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="IF_TYPE_OTHER"></a><a id="if_type_other"></a><dl> <dt><b>IF_TYPE_OTHER</b></dt> <dt>1</dt> </dl> </td> <td
    ///width="60%"> Some other type of network interface. </td> </tr> <tr> <td width="40%"><a
    ///id="IF_TYPE_ETHERNET_CSMACD"></a><a id="if_type_ethernet_csmacd"></a><dl> <dt><b>IF_TYPE_ETHERNET_CSMACD</b></dt>
    ///<dt>6</dt> </dl> </td> <td width="60%"> An Ethernet network interface. </td> </tr> <tr> <td width="40%"><a
    ///id="IF_TYPE_ISO88025_TOKENRING"></a><a id="if_type_iso88025_tokenring"></a><dl>
    ///<dt><b>IF_TYPE_ISO88025_TOKENRING</b></dt> <dt>9</dt> </dl> </td> <td width="60%"> A token ring network
    ///interface. </td> </tr> <tr> <td width="40%"><a id="IF_TYPE_FDDI"></a><a id="if_type_fddi"></a><dl>
    ///<dt><b>IF_TYPE_FDDI</b></dt> <dt>15</dt> </dl> </td> <td width="60%"> A Fiber Distributed Data Interface (FDDI)
    ///network interface. </td> </tr> <tr> <td width="40%"><a id="IF_TYPE_PPP"></a><a id="if_type_ppp"></a><dl>
    ///<dt><b>IF_TYPE_PPP</b></dt> <dt>23</dt> </dl> </td> <td width="60%"> A PPP network interface. </td> </tr> <tr>
    ///<td width="40%"><a id="IF_TYPE_SOFTWARE_LOOPBACK"></a><a id="if_type_software_loopback"></a><dl>
    ///<dt><b>IF_TYPE_SOFTWARE_LOOPBACK</b></dt> <dt>24</dt> </dl> </td> <td width="60%"> A software loopback network
    ///interface. </td> </tr> <tr> <td width="40%"><a id="IF_TYPE_ATM"></a><a id="if_type_atm"></a><dl>
    ///<dt><b>IF_TYPE_ATM</b></dt> <dt>37</dt> </dl> </td> <td width="60%"> An ATM network interface. </td> </tr> <tr>
    ///<td width="40%"><a id="IF_TYPE_IEEE80211"></a><a id="if_type_ieee80211"></a><dl>
    ///<dt><b>IF_TYPE_IEEE80211</b></dt> <dt>71</dt> </dl> </td> <td width="60%"> An IEEE 802.11 wireless network
    ///interface. </td> </tr> <tr> <td width="40%"><a id="IF_TYPE_TUNNEL"></a><a id="if_type_tunnel"></a><dl>
    ///<dt><b>IF_TYPE_TUNNEL</b></dt> <dt>131</dt> </dl> </td> <td width="60%"> A tunnel type encapsulation network
    ///interface. </td> </tr> <tr> <td width="40%"><a id="IF_TYPE_IEEE1394"></a><a id="if_type_ieee1394"></a><dl>
    ///<dt><b>IF_TYPE_IEEE1394</b></dt> <dt>144</dt> </dl> </td> <td width="60%"> An IEEE 1394 (Firewire) high
    ///performance serial bus network interface. </td> </tr> <tr> <td width="40%"><a id="_IF_TYPE_IEEE80216_WMAN"></a><a
    ///id="_if_type_ieee80216_wman"></a><dl> <dt><b> IF_TYPE_IEEE80216_WMAN</b></dt> <dt>237</dt> </dl> </td> <td
    ///width="60%"> A mobile broadband interface for WiMax devices. <div class="alert"><b>Note</b> This interface type
    ///is supported on Windows 7, Windows Server 2008 R2, and later.</div> <div> </div> </td> </tr> <tr> <td
    ///width="40%"><a id="IF_TYPE_WWANPP"></a><a id="if_type_wwanpp"></a><dl> <dt><b>IF_TYPE_WWANPP</b></dt>
    ///<dt>243</dt> </dl> </td> <td width="60%"> A mobile broadband interface for GSM-based devices. <div
    ///class="alert"><b>Note</b> This interface type is supported on Windows 7, Windows Server 2008 R2, and later.</div>
    ///<div> </div> </td> </tr> <tr> <td width="40%"><a id="IF_TYPE_WWANPP2"></a><a id="if_type_wwanpp2"></a><dl>
    ///<dt><b>IF_TYPE_WWANPP2</b></dt> <dt>244</dt> </dl> </td> <td width="60%"> A mobile broadband interface for
    ///CDMA-based devices. <div class="alert"><b>Note</b> This interface type is supported on Windows 7, Windows Server
    ///2008 R2, and later.</div> <div> </div> </td> </tr> </table>
    uint                 Type;
    ///Type: <b>TUNNEL_TYPE</b> The encapsulation method used by a tunnel if the <b>Type</b> member is
    ///<b>IF_TYPE_TUNNEL</b>. The tunnel type is defined by the Internet Assigned Names Authority (IANA). For more
    ///information, see http://www.iana.org/assignments/ianaiftype-mib. This member can be one of the values from the
    ///<b>TUNNEL_TYPE</b> enumeration type defined in the <i>Ifdef.h</i> header file. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="TUNNEL_TYPE_NONE"></a><a id="tunnel_type_none"></a><dl>
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
    ///</dl> </td> <td width="60%"> Teredo encapsulation. </td> </tr> </table>
    TUNNEL_TYPE          TunnelType;
    ///Type: <b>NDIS_MEDIUM</b> The NDIS media type for the interface. This member can be one of the values from the
    ///<b>NDIS_MEDIUM</b> enumeration type defined in the <i>Ntddndis.h</i> header file. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="NdisMedium802_3"></a><a id="ndismedium802_3"></a><a
    ///id="NDISMEDIUM802_3"></a><dl> <dt><b>NdisMedium802_3</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> An Ethernet
    ///(802.3) network. </td> </tr> <tr> <td width="40%"><a id="NdisMedium802_5"></a><a id="ndismedium802_5"></a><a
    ///id="NDISMEDIUM802_5"></a><dl> <dt><b>NdisMedium802_5</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> A Token
    ///Ring (802.5) network. </td> </tr> <tr> <td width="40%"><a id="NdisMediumFddi"></a><a id="ndismediumfddi"></a><a
    ///id="NDISMEDIUMFDDI"></a><dl> <dt><b>NdisMediumFddi</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> A Fiber
    ///Distributed Data Interface (FDDI) network. </td> </tr> <tr> <td width="40%"><a id="NdisMediumWan"></a><a
    ///id="ndismediumwan"></a><a id="NDISMEDIUMWAN"></a><dl> <dt><b>NdisMediumWan</b></dt> <dt>3</dt> </dl> </td> <td
    ///width="60%"> A wide area network (WAN). This type covers various forms of point-to-point and WAN NICs, as well as
    ///variant address/header formats that must be negotiated between the protocol driver and the underlying driver
    ///after the binding is established. </td> </tr> <tr> <td width="40%"><a id="NdisMediumLocalTalk"></a><a
    ///id="ndismediumlocaltalk"></a><a id="NDISMEDIUMLOCALTALK"></a><dl> <dt><b>NdisMediumLocalTalk</b></dt> <dt>4</dt>
    ///</dl> </td> <td width="60%"> A LocalTalk network. </td> </tr> <tr> <td width="40%"><a id="NdisMediumDix"></a><a
    ///id="ndismediumdix"></a><a id="NDISMEDIUMDIX"></a><dl> <dt><b>NdisMediumDix</b></dt> <dt>5</dt> </dl> </td> <td
    ///width="60%"> An Ethernet network for which the drivers use the DIX Ethernet header format. </td> </tr> <tr> <td
    ///width="40%"><a id="NdisMediumArcnetRaw"></a><a id="ndismediumarcnetraw"></a><a id="NDISMEDIUMARCNETRAW"></a><dl>
    ///<dt><b>NdisMediumArcnetRaw</b></dt> <dt>6</dt> </dl> </td> <td width="60%"> An ARCNET network. </td> </tr> <tr>
    ///<td width="40%"><a id="NdisMediumArcnet878_2"></a><a id="ndismediumarcnet878_2"></a><a
    ///id="NDISMEDIUMARCNET878_2"></a><dl> <dt><b>NdisMediumArcnet878_2</b></dt> <dt>7</dt> </dl> </td> <td width="60%">
    ///An ARCNET (878.2) network. </td> </tr> <tr> <td width="40%"><a id="NdisMediumAtm"></a><a
    ///id="ndismediumatm"></a><a id="NDISMEDIUMATM"></a><dl> <dt><b>NdisMediumAtm</b></dt> <dt>8</dt> </dl> </td> <td
    ///width="60%"> An ATM network. Connection-oriented client protocol drivers can bind themselves to an underlying
    ///miniport driver that returns this value. Otherwise, legacy protocol drivers bind themselves to the
    ///system-supplied LanE intermediate driver, which reports its medium type as either NdisMedium802_3 or
    ///NdisMedium802_5, depending on how the LanE driver is configured by the network administrator. </td> </tr> <tr>
    ///<td width="40%"><a id="NdisMediumWirelessWan"></a><a id="ndismediumwirelesswan"></a><a
    ///id="NDISMEDIUMWIRELESSWAN"></a><dl> <dt><b>NdisMediumWirelessWan</b></dt> <dt>9</dt> </dl> </td> <td width="60%">
    ///A wireless network. NDIS 5.X miniport drivers that support wireless LAN (WLAN) or wireless WAN (WWAN) packets do
    ///not use this NDIS media type, but declare their media type as NdisMedium802_3 and emulate Ethernet to
    ///higher-level NDIS drivers. <div class="alert"><b>Note</b> This media type is supported and can be used for Mobile
    ///Broadband only on Windows 7, Windows Server 2008 R2, and later.</div> <div> </div> </td> </tr> <tr> <td
    ///width="40%"><a id="NdisMediumIrda"></a><a id="ndismediumirda"></a><a id="NDISMEDIUMIRDA"></a><dl>
    ///<dt><b>NdisMediumIrda</b></dt> <dt>10</dt> </dl> </td> <td width="60%"> An infrared (IrDA) network. </td> </tr>
    ///<tr> <td width="40%"><a id="NdisMediumBpc"></a><a id="ndismediumbpc"></a><a id="NDISMEDIUMBPC"></a><dl>
    ///<dt><b>NdisMediumBpc</b></dt> <dt>11</dt> </dl> </td> <td width="60%"> A broadcast PC network. </td> </tr> <tr>
    ///<td width="40%"><a id="NdisMediumCoWan"></a><a id="ndismediumcowan"></a><a id="NDISMEDIUMCOWAN"></a><dl>
    ///<dt><b>NdisMediumCoWan</b></dt> <dt>12</dt> </dl> </td> <td width="60%"> A wide area network in a
    ///connection-oriented environment. </td> </tr> <tr> <td width="40%"><a id="NdisMedium1394"></a><a
    ///id="ndismedium1394"></a><a id="NDISMEDIUM1394"></a><dl> <dt><b>NdisMedium1394</b></dt> <dt>13</dt> </dl> </td>
    ///<td width="60%"> An IEEE 1394 (fire wire) network. </td> </tr> <tr> <td width="40%"><a
    ///id="NdisMediumInfiniBand"></a><a id="ndismediuminfiniband"></a><a id="NDISMEDIUMINFINIBAND"></a><dl>
    ///<dt><b>NdisMediumInfiniBand</b></dt> <dt>14</dt> </dl> </td> <td width="60%"> An InfiniBand network. </td> </tr>
    ///<tr> <td width="40%"><a id="NdisMediumTunnel"></a><a id="ndismediumtunnel"></a><a id="NDISMEDIUMTUNNEL"></a><dl>
    ///<dt><b>NdisMediumTunnel</b></dt> <dt>15</dt> </dl> </td> <td width="60%"> A tunnel network. <div
    ///class="alert"><b>Note</b> This media type is supported on Windows Vista, Windows Server 2008, and later.</div>
    ///<div> </div> </td> </tr> <tr> <td width="40%"><a id="NdisMediumNative802_11"></a><a
    ///id="ndismediumnative802_11"></a><a id="NDISMEDIUMNATIVE802_11"></a><dl> <dt><b>NdisMediumNative802_11</b></dt>
    ///<dt>16</dt> </dl> </td> <td width="60%"> A native IEEE 802.11 network. <div class="alert"><b>Note</b> This media
    ///type is supported on Windows Vista, Windows Server 2008, and later.</div> <div> </div> </td> </tr> <tr> <td
    ///width="40%"><a id="NdisMediumLoopback"></a><a id="ndismediumloopback"></a><a id="NDISMEDIUMLOOPBACK"></a><dl>
    ///<dt><b>NdisMediumLoopback</b></dt> <dt>17</dt> </dl> </td> <td width="60%"> An NDIS loopback network. <div
    ///class="alert"><b>Note</b> This media type is supported on Windows Vista, Windows Server 2008, and later.</div>
    ///<div> </div> </td> </tr> <tr> <td width="40%"><a id="NdisMediumWiMax"></a><a id="ndismediumwimax"></a><a
    ///id="NDISMEDIUMWIMAX"></a><dl> <dt><b>NdisMediumWiMax</b></dt> <dt>18</dt> </dl> </td> <td width="60%"> An WiMax
    ///network. <div class="alert"><b>Note</b> This media type is supported on Windows 7, Windows Server 2008 R2, and
    ///later.</div> <div> </div> </td> </tr> </table>
    NDIS_MEDIUM          MediaType;
    ///Type: <b>NDIS_PHYSICAL_MEDIUM</b> The NDIS physical medium type. This member can be one of the values from the
    ///<b>NDIS_PHYSICAL_MEDIUM</b> enumeration type defined in the <i>Ntddndis.h</i> header file. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="NdisPhysicalMediumUnspecified"></a><a
    ///id="ndisphysicalmediumunspecified"></a><a id="NDISPHYSICALMEDIUMUNSPECIFIED"></a><dl>
    ///<dt><b>NdisPhysicalMediumUnspecified</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The physical medium is none
    ///of the below values. For example, a one-way satellite feed is an unspecified physical medium. </td> </tr> <tr>
    ///<td width="40%"><a id="NdisPhysicalMediumWirelessLan"></a><a id="ndisphysicalmediumwirelesslan"></a><a
    ///id="NDISPHYSICALMEDIUMWIRELESSLAN"></a><dl> <dt><b>NdisPhysicalMediumWirelessLan</b></dt> <dt>1</dt> </dl> </td>
    ///<td width="60%"> Packets are transferred over a wireless LAN network through a miniport driver that conforms to
    ///the 802.11 interface. </td> </tr> <tr> <td width="40%"><a id="NdisPhysicalMediumCableModem"></a><a
    ///id="ndisphysicalmediumcablemodem"></a><a id="NDISPHYSICALMEDIUMCABLEMODEM"></a><dl>
    ///<dt><b>NdisPhysicalMediumCableModem</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Packets are transferred over
    ///a DOCSIS-based cable network. </td> </tr> <tr> <td width="40%"><a id="NdisPhysicalMediumPhoneLine"></a><a
    ///id="ndisphysicalmediumphoneline"></a><a id="NDISPHYSICALMEDIUMPHONELINE"></a><dl>
    ///<dt><b>NdisPhysicalMediumPhoneLine</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> Packets are transferred over
    ///standard phone lines. This includes HomePNA media, for example. </td> </tr> <tr> <td width="40%"><a
    ///id="NdisPhysicalMediumPowerLine"></a><a id="ndisphysicalmediumpowerline"></a><a
    ///id="NDISPHYSICALMEDIUMPOWERLINE"></a><dl> <dt><b>NdisPhysicalMediumPowerLine</b></dt> <dt>4</dt> </dl> </td> <td
    ///width="60%"> Packets are transferred over wiring that is connected to a power distribution system. </td> </tr>
    ///<tr> <td width="40%"><a id="NdisPhysicalMediumDSL"></a><a id="ndisphysicalmediumdsl"></a><a
    ///id="NDISPHYSICALMEDIUMDSL"></a><dl> <dt><b>NdisPhysicalMediumDSL</b></dt> <dt>5</dt> </dl> </td> <td width="60%">
    ///Packets are transferred over a Digital Subscriber Line (DSL) network. This includes ADSL, UADSL (G.Lite), and
    ///SDSL, for example. </td> </tr> <tr> <td width="40%"><a id="NdisPhysicalMediumFibreChannel"></a><a
    ///id="ndisphysicalmediumfibrechannel"></a><a id="NDISPHYSICALMEDIUMFIBRECHANNEL"></a><dl>
    ///<dt><b>NdisPhysicalMediumFibreChannel</b></dt> <dt>6</dt> </dl> </td> <td width="60%"> Packets are transferred
    ///over a Fibre Channel interconnect. </td> </tr> <tr> <td width="40%"><a id="NdisPhysicalMedium1394"></a><a
    ///id="ndisphysicalmedium1394"></a><a id="NDISPHYSICALMEDIUM1394"></a><dl> <dt><b>NdisPhysicalMedium1394</b></dt>
    ///<dt>7</dt> </dl> </td> <td width="60%"> Packets are transferred over an IEEE 1394 bus. </td> </tr> <tr> <td
    ///width="40%"><a id="NdisPhysicalMediumWirelessWan"></a><a id="ndisphysicalmediumwirelesswan"></a><a
    ///id="NDISPHYSICALMEDIUMWIRELESSWAN"></a><dl> <dt><b>NdisPhysicalMediumWirelessWan</b></dt> <dt>8</dt> </dl> </td>
    ///<td width="60%"> Packets are transferred over a Wireless WAN link. This includes mobile broadband devices that
    ///support CDPD, CDMA, GSM, and GPRS, for example. </td> </tr> <tr> <td width="40%"><a
    ///id="NdisPhysicalMediumNative802_11"></a><a id="ndisphysicalmediumnative802_11"></a><a
    ///id="NDISPHYSICALMEDIUMNATIVE802_11"></a><dl> <dt><b>NdisPhysicalMediumNative802_11</b></dt> <dt>9</dt> </dl>
    ///</td> <td width="60%"> Packets are transferred over a wireless LAN network through a miniport driver that
    ///conforms to the Native 802.11 interface. <div class="alert"><b>Note</b> The Native 802.11 interface is supported
    ///in NDIS 6.0 and later versions.</div> <div> </div> </td> </tr> <tr> <td width="40%"><a
    ///id="NdisPhysicalMediumBluetooth"></a><a id="ndisphysicalmediumbluetooth"></a><a
    ///id="NDISPHYSICALMEDIUMBLUETOOTH"></a><dl> <dt><b>NdisPhysicalMediumBluetooth</b></dt> <dt>10</dt> </dl> </td> <td
    ///width="60%"> Packets are transferred over a Bluetooth network. Bluetooth is a short-range wireless technology
    ///that uses the 2.4 GHz spectrum. </td> </tr> <tr> <td width="40%"><a id="NdisPhysicalMediumInfiniband"></a><a
    ///id="ndisphysicalmediuminfiniband"></a><a id="NDISPHYSICALMEDIUMINFINIBAND"></a><dl>
    ///<dt><b>NdisPhysicalMediumInfiniband</b></dt> <dt>11</dt> </dl> </td> <td width="60%"> Packets are transferred
    ///over an Infiniband interconnect. </td> </tr> <tr> <td width="40%"><a id="NdisPhysicalMediumWiMax"></a><a
    ///id="ndisphysicalmediumwimax"></a><a id="NDISPHYSICALMEDIUMWIMAX"></a><dl> <dt><b>NdisPhysicalMediumWiMax</b></dt>
    ///<dt>12</dt> </dl> </td> <td width="60%"> Packets are transferred over a WiMax network. </td> </tr> <tr> <td
    ///width="40%"><a id="NdisPhysicalMediumUWB"></a><a id="ndisphysicalmediumuwb"></a><a
    ///id="NDISPHYSICALMEDIUMUWB"></a><dl> <dt><b>NdisPhysicalMediumUWB</b></dt> <dt>13</dt> </dl> </td> <td
    ///width="60%"> Packets are transferred over an ultra wide band network. </td> </tr> <tr> <td width="40%"><a
    ///id="NdisPhysicalMedium802_3"></a><a id="ndisphysicalmedium802_3"></a><a id="NDISPHYSICALMEDIUM802_3"></a><dl>
    ///<dt><b>NdisPhysicalMedium802_3</b></dt> <dt>14</dt> </dl> </td> <td width="60%"> Packets are transferred over an
    ///Ethernet (802.3) network. </td> </tr> <tr> <td width="40%"><a id="NdisPhysicalMedium802_5"></a><a
    ///id="ndisphysicalmedium802_5"></a><a id="NDISPHYSICALMEDIUM802_5"></a><dl> <dt><b>NdisPhysicalMedium802_5</b></dt>
    ///<dt>15</dt> </dl> </td> <td width="60%"> Packets are transferred over a Token Ring (802.5) network. </td> </tr>
    ///<tr> <td width="40%"><a id="NdisPhysicalMediumIrda"></a><a id="ndisphysicalmediumirda"></a><a
    ///id="NDISPHYSICALMEDIUMIRDA"></a><dl> <dt><b>NdisPhysicalMediumIrda</b></dt> <dt>16</dt> </dl> </td> <td
    ///width="60%"> Packets are transferred over an infrared (IrDA) network. </td> </tr> <tr> <td width="40%"><a
    ///id="NdisPhysicalMediumWiredWAN"></a><a id="ndisphysicalmediumwiredwan"></a><a
    ///id="NDISPHYSICALMEDIUMWIREDWAN"></a><dl> <dt><b>NdisPhysicalMediumWiredWAN</b></dt> <dt>17</dt> </dl> </td> <td
    ///width="60%"> Packets are transferred over a wired WAN network. </td> </tr> <tr> <td width="40%"><a
    ///id="NdisPhysicalMediumWiredCoWan"></a><a id="ndisphysicalmediumwiredcowan"></a><a
    ///id="NDISPHYSICALMEDIUMWIREDCOWAN"></a><dl> <dt><b>NdisPhysicalMediumWiredCoWan</b></dt> <dt>18</dt> </dl> </td>
    ///<td width="60%"> Packets are transferred over a wide area network in a connection-oriented environment. </td>
    ///</tr> <tr> <td width="40%"><a id="NdisPhysicalMediumOther"></a><a id="ndisphysicalmediumother"></a><a
    ///id="NDISPHYSICALMEDIUMOTHER"></a><dl> <dt><b>NdisPhysicalMediumOther</b></dt> <dt>19</dt> </dl> </td> <td
    ///width="60%"> Packets are transferred over a network that is not described by other possible values. </td> </tr>
    ///</table>
    NDIS_PHYSICAL_MEDIUM PhysicalMediumType;
    ///Type: <b>NET_IF_ACCESS_TYPE</b> The interface access type. This member can be one of the values from the
    ///<b>NET_IF_ACCESS_TYPE</b> enumeration type defined in the <i>Ifdef.h</i> header file. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="NET_IF_ACCESS_LOOPBACK"></a><a
    ///id="net_if_access_loopback"></a><dl> <dt><b>NET_IF_ACCESS_LOOPBACK</b></dt> <dt>1</dt> </dl> </td> <td
    ///width="60%"> Loopback access type. This access type indicates that the interface loops back transmit data as
    ///receive data. </td> </tr> <tr> <td width="40%"><a id="NET_IF_ACCESS_BROADCAST"></a><a
    ///id="net_if_access_broadcast"></a><dl> <dt><b>NET_IF_ACCESS_BROADCAST</b></dt> <dt>2</dt> </dl> </td> <td
    ///width="60%"> The LAN access type which includes Ethernet. This access type indicates that the interface provides
    ///native support for multicast or broadcast services. <div class="alert"><b>Note</b> Mobile broadband interfaces
    ///with a <b>MediaType</b> of <b>NdisMedium802_3</b> use this access type.</div> <div> </div> </td> </tr> <tr> <td
    ///width="40%"><a id="NET_IF_ACCESS_POINT_TO_POINT"></a><a id="net_if_access_point_to_point"></a><dl>
    ///<dt><b>NET_IF_ACCESS_POINT_TO_POINT</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> Point-to-point access that
    ///supports CoNDIS/WAN, except for non-broadcast multi-access (NBMA) interfaces. <div class="alert"><b>Note</b>
    ///Mobile broadband interfaces with a <b>MediaType</b> of <b>NdisMediumWirelessWan</b> use this access type.</div>
    ///<div> </div> </td> </tr> <tr> <td width="40%"><a id="NET_IF_ACCESS_POINT_TO_MULTI_POINT"></a><a
    ///id="net_if_access_point_to_multi_point"></a><dl> <dt><b>NET_IF_ACCESS_POINT_TO_MULTI_POINT</b></dt> <dt>4</dt>
    ///</dl> </td> <td width="60%"> Point-to-multipoint access that supports non-broadcast multi-access (NBMA) media,
    ///including the "RAS Internal" interface, and native (non-LANE) ATM. </td> </tr> <tr> <td width="40%"><a
    ///id="NET_IF_ACCESS_MAXIMUM"></a><a id="net_if_access_maximum"></a><dl> <dt><b>NET_IF_ACCESS_MAXIMUM</b></dt>
    ///<dt>5</dt> </dl> </td> <td width="60%"> The maximum possible value for the <b>NET_IF_ACCESS_TYPE</b> enumeration
    ///type. This is not a legal value for <i>AccessType</i> member. </td> </tr> </table>
    NET_IF_ACCESS_TYPE   AccessType;
    ///Type: <b>NET_IF_DIRECTION_TYPE</b> The interface direction type. This member can be one of the values from the
    ///<b>NET_IF_DIRECTION_TYPE</b> enumeration type defined in the <i>Ifdef.h</i> header file. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="NET_IF_DIRECTION_SENDRECEIVE"></a><a
    ///id="net_if_direction_sendreceive"></a><dl> <dt><b>NET_IF_DIRECTION_SENDRECEIVE</b></dt> <dt>0</dt> </dl> </td>
    ///<td width="60%"> The send and receive direction type. This direction type indicates that the NDIS network
    ///interface can send and receive data. </td> </tr> <tr> <td width="40%"><a id="NET_IF_DIRECTION_SENDONLY"></a><a
    ///id="net_if_direction_sendonly"></a><dl> <dt><b>NET_IF_DIRECTION_SENDONLY</b></dt> <dt>1</dt> </dl> </td> <td
    ///width="60%"> The send only direction type. This direction type indicates that the NDIS network interface can only
    ///send data. </td> </tr> <tr> <td width="40%"><a id="NET_IF_DIRECTION_RECEIVEONLY"></a><a
    ///id="net_if_direction_receiveonly"></a><dl> <dt><b>NET_IF_DIRECTION_RECEIVEONLY</b></dt> <dt>2</dt> </dl> </td>
    ///<td width="60%"> The receive only direction type. This direction type indicates that the NDIS network interface
    ///can only receive data. </td> </tr> <tr> <td width="40%"><a id="NET_IF_DIRECTION_MAXIMUM"></a><a
    ///id="net_if_direction_maximum"></a><dl> <dt><b>NET_IF_DIRECTION_MAXIMUM</b></dt> <dt>3</dt> </dl> </td> <td
    ///width="60%"> The maximum possible value for the <b>NET_IF_DIRECTION_TYPE</b> enumeration type. This is not a
    ///legal value for <i>DirectionType</i> member. </td> </tr> </table>
    NET_IF_DIRECTION_TYPE DirectionType;
    struct InterfaceAndOperStatusFlags
    {
        ubyte _bitfield70;
    }
    ///Type: <b>IF_OPER_STATUS</b> The operational status for the interface as defined in RFC 2863 as IfOperStatus. For
    ///more information, see http://www.ietf.org/rfc/rfc2863.txt. This member can be one of the values from the
    ///<b>IF_OPER_STATUS</b> enumeration type defined in the <i>Ifdef.h</i> header file. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="IfOperStatusUp"></a><a id="ifoperstatusup"></a><a
    ///id="IFOPERSTATUSUP"></a><dl> <dt><b>IfOperStatusUp</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The interface
    ///is up and able to pass packets. </td> </tr> <tr> <td width="40%"><a id="IfOperStatusDown"></a><a
    ///id="ifoperstatusdown"></a><a id="IFOPERSTATUSDOWN"></a><dl> <dt><b>IfOperStatusDown</b></dt> <dt>2</dt> </dl>
    ///</td> <td width="60%"> The interface is down and not in a condition to pass packets. The <b>IfOperStatusDown</b>
    ///state has two meanings, depending on the value of <b>AdminStatus</b> member. If <b>AdminStatus</b> is not set to
    ///<b>NET_IF_ADMIN_STATUS_DOWN</b> and <b>ifOperStatus</b> is set to <b>IfOperStatusDown</b> then a fault condition
    ///is presumed to exist on the interface. If <b>AdminStatus</b> is set to <b>IfOperStatusDown</b>, then
    ///<b>ifOperStatus</b> will normally also be set to <b>IfOperStatusDown</b> or <b>IfOperStatusNotPresent</b> and
    ///there is not necessarily a fault condition on the interface. </td> </tr> <tr> <td width="40%"><a
    ///id="IfOperStatusTesting"></a><a id="ifoperstatustesting"></a><a id="IFOPERSTATUSTESTING"></a><dl>
    ///<dt><b>IfOperStatusTesting</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> The interface is in testing mode.
    ///</td> </tr> <tr> <td width="40%"><a id="IfOperStatusUnknown"></a><a id="ifoperstatusunknown"></a><a
    ///id="IFOPERSTATUSUNKNOWN"></a><dl> <dt><b>IfOperStatusUnknown</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> The
    ///operational status of the interface is unknown. </td> </tr> <tr> <td width="40%"><a
    ///id="IfOperStatusDormant"></a><a id="ifoperstatusdormant"></a><a id="IFOPERSTATUSDORMANT"></a><dl>
    ///<dt><b>IfOperStatusDormant</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> The interface is not actually in a
    ///condition to pass packets (it is not up), but is in a pending state, waiting for some external event. For
    ///on-demand interfaces, this new state identifies the situation where the interface is waiting for events to place
    ///it in the <b>IfOperStatusUp</b> state. </td> </tr> <tr> <td width="40%"><a id="IfOperStatusNotPresent"></a><a
    ///id="ifoperstatusnotpresent"></a><a id="IFOPERSTATUSNOTPRESENT"></a><dl> <dt><b>IfOperStatusNotPresent</b></dt>
    ///<dt>6</dt> </dl> </td> <td width="60%"> A refinement on the <b>IfOperStatusDown</b> state which indicates that
    ///the relevant interface is down specifically because some component (typically, a hardware device) is not present
    ///in the managed system. </td> </tr> <tr> <td width="40%"><a id="IfOperStatusLowerLayerDown"></a><a
    ///id="ifoperstatuslowerlayerdown"></a><a id="IFOPERSTATUSLOWERLAYERDOWN"></a><dl>
    ///<dt><b>IfOperStatusLowerLayerDown</b></dt> <dt>7</dt> </dl> </td> <td width="60%"> A refinement on the
    ///<b>IfOperStatusDown</b> state. This new state indicates that this interface runs on top of one or more other
    ///interfaces and that this interface is down specifically because one or more of these lower-layer interfaces are
    ///down. </td> </tr> </table>
    IF_OPER_STATUS       OperStatus;
    ///Type: <b>NET_IF_ADMIN_STATUS</b> The administrative status for the interface as defined in RFC 2863. For more
    ///information, see http://www.ietf.org/rfc/rfc2863.txt. This member can be one of the values from the
    ///<b>NET_IF_ADMIN_STATUS</b> enumeration type defined in the <i>Ifdef.h</i> header file. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="NET_IF_ADMIN_STATUS_UP"></a><a
    ///id="net_if_admin_status_up"></a><dl> <dt><b>NET_IF_ADMIN_STATUS_UP</b></dt> <dt>1</dt> </dl> </td> <td
    ///width="60%"> The interface is initialized and enabled. But the interface is not necessarily ready to transmit and
    ///receive network data because that depends on the operational status of the interface. </td> </tr> <tr> <td
    ///width="40%"><a id="NET_IF_ADMIN_STATUS_DOWN"></a><a id="net_if_admin_status_down"></a><dl>
    ///<dt><b>NET_IF_ADMIN_STATUS_DOWN</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The interface is down, and this
    ///interface cannot be used to transmit or receive network data. </td> </tr> <tr> <td width="40%"><a
    ///id="NET_IF_ADMIN_STATUS_TESTING"></a><a id="net_if_admin_status_testing"></a><dl>
    ///<dt><b>NET_IF_ADMIN_STATUS_TESTING</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> The interface is in a test
    ///mode, and no network data can be transmitted or received. </td> </tr> </table>
    NET_IF_ADMIN_STATUS  AdminStatus;
    ///Type: <b>NET_IF_MEDIA_CONNECT_STATE</b> The connection state of the interface. This member can be one of the
    ///values from the <b>NET_IF_MEDIA_CONNECT_STATE</b> enumeration type defined in the <i>Ifdef.h</i> header file.
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MediaConnectStateUnknown"></a><a
    ///id="mediaconnectstateunknown"></a><a id="MEDIACONNECTSTATEUNKNOWN"></a><dl>
    ///<dt><b>MediaConnectStateUnknown</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The connection state of the
    ///interface is unknown. </td> </tr> <tr> <td width="40%"><a id="MediaConnectStateConnected"></a><a
    ///id="mediaconnectstateconnected"></a><a id="MEDIACONNECTSTATECONNECTED"></a><dl>
    ///<dt><b>MediaConnectStateConnected</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The interface is connected to
    ///the network. </td> </tr> <tr> <td width="40%"><a id="MediaConnectStateDisconnected"></a><a
    ///id="mediaconnectstatedisconnected"></a><a id="MEDIACONNECTSTATEDISCONNECTED"></a><dl>
    ///<dt><b>MediaConnectStateDisconnected</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The interface is not
    ///connected to the network. </td> </tr> </table>
    NET_IF_MEDIA_CONNECT_STATE MediaConnectState;
    ///Type: <b>NET_IF_NETWORK_GUID</b> The GUID that is associated with the network that the interface belongs to.
    GUID                 NetworkGuid;
    ///Type: <b>NET_IF_CONNECTION_TYPE</b> The NDIS network interface connection type. This member can be one of the
    ///values from the <b>NET_IF_CONNECTION_TYPE</b> enumeration type defined in the <i>Ifdef.h</i> header file. <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="NET_IF_CONNECTION_DEDICATED"></a><a
    ///id="net_if_connection_dedicated"></a><dl> <dt><b>NET_IF_CONNECTION_DEDICATED</b></dt> <dt>1</dt> </dl> </td> <td
    ///width="60%"> The connection type is dedicated. The connection comes up automatically when media sense is TRUE.
    ///For example, an Ethernet connection is dedicated. </td> </tr> <tr> <td width="40%"><a
    ///id="NET_IF_CONNECTION_PASSIVE"></a><a id="net_if_connection_passive"></a><dl>
    ///<dt><b>NET_IF_CONNECTION_PASSIVE</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The connection type is passive.
    ///The remote end must bring up the connection to the local station. For example, a RAS interface is passive. </td>
    ///</tr> <tr> <td width="40%"><a id="NET_IF_CONNECTION_DEMAND"></a><a id="net_if_connection_demand"></a><dl>
    ///<dt><b>NET_IF_CONNECTION_DEMAND</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> The connection type is
    ///demand-dial. A connection of this type comes up in response to a local action (sending a packet, for example).
    ///</td> </tr> <tr> <td width="40%"><a id="NET_IF_CONNECTION_MAXIMUM"></a><a id="net_if_connection_maximum"></a><dl>
    ///<dt><b>NET_IF_CONNECTION_MAXIMUM</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> The maximum possible value for
    ///the <b>NET_IF_CONNECTION_TYPE</b> enumeration type. This is not a legal value for <b>ConnectionType</b> member.
    ///</td> </tr> </table>
    NET_IF_CONNECTION_TYPE ConnectionType;
    ///Type: <b>ULONG64</b> The speed in bits per second of the transmit link.
    ulong                TransmitLinkSpeed;
    ///Type: <b>ULONG64</b> The speed in bits per second of the receive link.
    ulong                ReceiveLinkSpeed;
    ///Type: <b>ULONG64</b> The number of octets of data received without errors through this interface. This value
    ///includes octets in unicast, broadcast, and multicast packets.
    ulong                InOctets;
    ///Type: <b>ULONG64</b> The number of unicast packets received without errors through this interface.
    ulong                InUcastPkts;
    ///Type: <b>ULONG64</b> The number of non-unicast packets received without errors through this interface. This value
    ///includes broadcast and multicast packets.
    ulong                InNUcastPkts;
    ///Type: <b>ULONG64</b> The number of inbound packets which were chosen to be discarded even though no errors were
    ///detected to prevent the packets from being deliverable to a higher-layer protocol.
    ulong                InDiscards;
    ///Type: <b>ULONG64</b> The number of incoming packets that were discarded because of errors.
    ulong                InErrors;
    ///Type: <b>ULONG64</b> The number of incoming packets that were discarded because the protocol was unknown.
    ulong                InUnknownProtos;
    ///Type: <b>ULONG64</b> The number of octets of data received without errors in unicast packets through this
    ///interface.
    ulong                InUcastOctets;
    ///Type: <b>ULONG64</b> The number of octets of data received without errors in multicast packets through this
    ///interface.
    ulong                InMulticastOctets;
    ///Type: <b>ULONG64</b> The number of octets of data received without errors in broadcast packets through this
    ///interface.
    ulong                InBroadcastOctets;
    ///Type: <b>ULONG64</b> The number of octets of data transmitted without errors through this interface. This value
    ///includes octets in unicast, broadcast, and multicast packets.
    ulong                OutOctets;
    ///Type: <b>ULONG64</b> The number of unicast packets transmitted without errors through this interface.
    ulong                OutUcastPkts;
    ///Type: <b>ULONG64</b> The number of non-unicast packets transmitted without errors through this interface. This
    ///value includes broadcast and multicast packets.
    ulong                OutNUcastPkts;
    ///Type: <b>ULONG64</b> The number of outgoing packets that were discarded even though they did not have errors.
    ulong                OutDiscards;
    ///Type: <b>ULONG64</b> The number of outgoing packets that were discarded because of errors.
    ulong                OutErrors;
    ///Type: <b>ULONG64</b> The number of octets of data transmitted without errors in unicast packets through this
    ///interface.
    ulong                OutUcastOctets;
    ///Type: <b>ULONG64</b> The number of octets of data transmitted without errors in multicast packets through this
    ///interface.
    ulong                OutMulticastOctets;
    ///Type: <b>ULONG64</b> The number of octets of data transmitted without errors in broadcast packets through this
    ///interface.
    ulong                OutBroadcastOctets;
    ///Type: <b>ULONG64</b> The transmit queue length. This field is not currently used.
    ulong                OutQLen;
}

///The <b>MIB_IF_TABLE2</b> structure contains a table of logical and physical interface entries.
struct MIB_IF_TABLE2
{
    ///The number of interface entries in the array.
    uint           NumEntries;
    ///An array of MIB_IF_ROW2 structures containing interface entries.
    MIB_IF_ROW2[1] Table;
}

///The <b>MIB_IPINTERFACE_ROW</b> structure stores interface management information for a particular IP address family
///on a network interface.
struct MIB_IPINTERFACE_ROW
{
    ///Type: <b>ADDRESS_FAMILY</b> The address family. Possible values for the address family are listed in the
    ///<i>Winsock2.h</i> header file. Note that the values for the AF_ address family and PF_ protocol family constants
    ///are identical (for example, <b>AF_INET</b> and <b>PF_INET</b>), so either constant can be used. On Windows Vista
    ///and later as well as on the Windows SDK, the organization of header files has changed and possible values for
    ///this member are defined in the <i>Ws2def.h</i> header file. Note that the <i>Ws2def.h</i> header file is
    ///automatically included in <i>Winsock2.h</i>, and should never be used directly. The values currently supported
    ///are <b>AF_INET</b> or <b>AF_INET6</b>, which are the Internet address family formats for IPv4 and IPv6. <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="AF_UNSPEC"></a><a id="af_unspec"></a><dl>
    ///<dt><b>AF_UNSPEC</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The address family is unspecified. </td> </tr>
    ///<tr> <td width="40%"><a id="AF_INET"></a><a id="af_inet"></a><dl> <dt><b>AF_INET</b></dt> <dt>2</dt> </dl> </td>
    ///<td width="60%"> The Internet Protocol version 4 (IPv4) address family. </td> </tr> <tr> <td width="40%"><a
    ///id="AF_INET6"></a><a id="af_inet6"></a><dl> <dt><b>AF_INET6</b></dt> <dt>23</dt> </dl> </td> <td width="60%"> The
    ///Internet Protocol version 6 (IPv6) address family. </td> </tr> </table>
    ushort      Family;
    ///Type: <b>NET_LUID</b> The locally unique identifier (LUID) for the network interface.
    NET_LUID_LH InterfaceLuid;
    ///Type: <b>NET_IFINDEX</b> The local index value for the network interface. This index value may change when a
    ///network adapter is disabled and then enabled, or under other circumstances, and should not be considered
    ///persistent.
    uint        InterfaceIndex;
    ///Type: <b>ULONG</b> The maximum reassembly size, in bytes, of a fragmented IP packet. This member is currently set
    ///to zero and reserved for future use.
    uint        MaxReassemblySize;
    ///Type: <b>ULONG64</b> Reserved for future use. This member is currently set to zero.
    ulong       InterfaceIdentifier;
    ///Type: <b>ULONG</b> The minimum router advertisement interval, in milliseconds, on this IP interface. This member
    ///defaults to 200 for IPv6. This member is only applicable if the <b>AdvertisingEnabled</b> member is set to
    ///<b>TRUE</b>.
    uint        MinRouterAdvertisementInterval;
    ///Type: <b>ULONG</b> The maximum router advertisement interval, in milliseconds, on this IP interface. This member
    ///defaults to 600 for IPv6. This member is only applicable if the <b>AdvertisingEnabled</b> member is set to
    ///<b>TRUE</b>.
    uint        MaxRouterAdvertisementInterval;
    ///Type: <b>BOOLEAN</b> A value that indicates if router advertising is enabled on this IP interface. The default
    ///for IPv6 is that router advertisement is enabled only if the interface is configured to act as a router. The
    ///default for IPv4 is that router advertisement is disabled.
    ubyte       AdvertisingEnabled;
    ///Type: <b>BOOLEAN</b> A value that indicates if IP forwarding is enabled on this IP interface.
    ubyte       ForwardingEnabled;
    ///Type: <b>BOOLEAN</b> A value that indicates if weak host send mode is enabled on this IP interface.
    ubyte       WeakHostSend;
    ///Type: <b>BOOLEAN</b> A value that indicates if weak host receive mode is enabled on this IP interface.
    ubyte       WeakHostReceive;
    ///Type: <b>BOOLEAN</b> A value that indicates if the IP interface uses automatic metric.
    ubyte       UseAutomaticMetric;
    ///Type: <b>BOOLEAN</b> A value that indicates if neighbor unreachability detection is enabled on this IP interface.
    ubyte       UseNeighborUnreachabilityDetection;
    ///Type: <b>BOOLEAN</b> A value that indicates if the IP interface supports managed address configuration using
    ///DHCP.
    ubyte       ManagedAddressConfigurationSupported;
    ///Type: <b>BOOLEAN</b> A value that indicates if the IP interface supports other stateful configuration (route
    ///configuration, for example).
    ubyte       OtherStatefulConfigurationSupported;
    ///Type: <b>BOOLEAN</b> A value that indicates if the IP interface advertises the default route. This member is only
    ///applicable if the <b>AdvertisingEnabled</b> member is set to <b>TRUE</b>.
    ubyte       AdvertiseDefaultRoute;
    ///Type: <b>NL_ROUTER_DISCOVERY_BEHAVIOR</b> The router discovery behavior. This member can be one of the values
    ///from the <b>NL_ROUTER_DISCOVERY_BEHAVIOR</b> enumeration type defined in the <i>Nldef.h</i> header file. The
    ///member is described in RFC 2461. For more information, see http://www.ietf.org/rfc/rfc2461.txt. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RouterDiscoveryDisabled"></a><a
    ///id="routerdiscoverydisabled"></a><a id="ROUTERDISCOVERYDISABLED"></a><dl> <dt><b>RouterDiscoveryDisabled</b></dt>
    ///<dt>0</dt> </dl> </td> <td width="60%"> Router discovery is disabled. </td> </tr> <tr> <td width="40%"><a
    ///id="RouterDiscoveryEnabled"></a><a id="routerdiscoveryenabled"></a><a id="ROUTERDISCOVERYENABLED"></a><dl>
    ///<dt><b>RouterDiscoveryEnabled</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Router discovery is enabled. This
    ///is the default value for IPv6. </td> </tr> <tr> <td width="40%"><a id="RouterDiscoveryDhcp"></a><a
    ///id="routerdiscoverydhcp"></a><a id="ROUTERDISCOVERYDHCP"></a><dl> <dt><b>RouterDiscoveryDhcp</b></dt> <dt>2</dt>
    ///</dl> </td> <td width="60%"> Router discovery is configured based on DHCP. This is the default value for IPv4.
    ///</td> </tr> <tr> <td width="40%"><a id="RouterDiscoveryUnchanged_"></a><a id="routerdiscoveryunchanged_"></a><a
    ///id="ROUTERDISCOVERYUNCHANGED_"></a><dl> <dt><b>RouterDiscoveryUnchanged </b></dt> <dt>-1</dt> </dl> </td> <td
    ///width="60%"> This value is used when setting the properties for an IP interface when the value for router
    ///discovery should be unchanged. </td> </tr> </table>
    NL_ROUTER_DISCOVERY_BEHAVIOR RouterDiscoveryBehavior;
    ///Type: <b>ULONG</b> The number of consecutive messages sent while performing duplicate address detection on a
    ///tentative IP unicast address. A value of zero indicates that duplicate address detection is not performed on
    ///tentative IP addresses. A value of one indicates a single transmission with no follow up retransmissions. For
    ///IPv4, the default for this member is 3. For IPv6, the default for this member is 1. For IPv6, these messages will
    ///sent as neighbor solicitation requests. This member is defined as DupAddrDetectTransmits in RFC 2462. For more
    ///information, see http://www.ietf.org/rfc/rfc2462.txt.
    uint        DadTransmits;
    ///Type: <b>ULONG</b> The base for random reachable time, in milliseconds. The member is described in RFC 2461. For
    ///more information, see http://www.ietf.org/rfc/rfc2461.txt.
    uint        BaseReachableTime;
    ///Type: <b>ULONG</b> The neighbor solicitation timeout, in milliseconds. The member is described in RFC 2461. For
    ///more information, see http://www.ietf.org/rfc/rfc2461.txt.
    uint        RetransmitTime;
    ///Type: <b>ULONG</b> The path MTU discovery timeout, in milliseconds.
    uint        PathMtuDiscoveryTimeout;
    ///Type: <b>NL_LINK_LOCAL_ADDRESS_BEHAVIOR</b> The link local address behavior. This member can be one of the values
    ///from the <b>NL_LINK_LOCAL_ADDRESS_BEHAVIOR</b> enumeration type defined in the <i>Nldef.h</i> header file.
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="LinkLocalAlwaysOff"></a><a
    ///id="linklocalalwaysoff"></a><a id="LINKLOCALALWAYSOFF"></a><dl> <dt><b>LinkLocalAlwaysOff</b></dt> <dt>0</dt>
    ///</dl> </td> <td width="60%"> Never use a link local IP address. </td> </tr> <tr> <td width="40%"><a
    ///id="LinkLocalDelayed"></a><a id="linklocaldelayed"></a><a id="LINKLOCALDELAYED"></a><dl>
    ///<dt><b>LinkLocalDelayed</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Use a link local IP address only if no
    ///other address is available. This is the default setting for an IPv4 interface. </td> </tr> <tr> <td
    ///width="40%"><a id="LinkLocalAlwaysOn"></a><a id="linklocalalwayson"></a><a id="LINKLOCALALWAYSON"></a><dl>
    ///<dt><b>LinkLocalAlwaysOn</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Always use a link local IP address.
    ///This is the default setting for an IPv6 interface. </td> </tr> <tr> <td width="40%"><a
    ///id="LinkLocalUnchanged"></a><a id="linklocalunchanged"></a><a id="LINKLOCALUNCHANGED"></a><dl>
    ///<dt><b>LinkLocalUnchanged</b></dt> <dt>-1</dt> </dl> </td> <td width="60%"> This value is used when setting the
    ///properties for an IP interface when the value for link local address behavior should be unchanged. </td> </tr>
    ///</table>
    NL_LINK_LOCAL_ADDRESS_BEHAVIOR LinkLocalAddressBehavior;
    ///Type: <b>ULONG</b> The link local IP address timeout, in milliseconds.
    uint        LinkLocalAddressTimeout;
    ///Type: <b>ULONG[ScopeLevelCount]</b> An array that specifies the zone part of scope IDs.
    uint[16]    ZoneIndices;
    ///Type: <b>ULONG</b> The site prefix length, in bits, of the IP interface address. The length, in bits, of the site
    ///prefix or network part of the IP interface address. For an IPv4 address, any value greater than 32 is an illegal
    ///value. For an IPv6 address, any value greater than 128 is an illegal value. A value of 255 is commonly used to
    ///represent an illegal value.
    uint        SitePrefixLength;
    ///Type: <b>ULONG</b> The interface metric. Note the actual route metric used to compute the route preference is the
    ///summation of the route metric offset specified in the <b>Metric</b> member of the MIB_IPFORWARD_ROW2 structure
    ///and the interface metric specified in this member.
    uint        Metric;
    ///Type: <b>ULONG</b> The network layer MTU size, in bytes.
    uint        NlMtu;
    ///Type: <b>BOOLEAN</b> A value that indicates if the interface is connected to a network access point.
    ubyte       Connected;
    ///Type: <b>BOOLEAN</b> A value that specifies if the network interface supports Wake on LAN.
    ubyte       SupportsWakeUpPatterns;
    ///Type: <b>BOOLEAN</b> A value that specifies if the IP interface support neighbor discovery.
    ubyte       SupportsNeighborDiscovery;
    ///Type: <b>BOOLEAN</b> A value that specifies if the IP interface support router discovery.
    ubyte       SupportsRouterDiscovery;
    ///Type: <b>ULONG</b> The reachable timeout, in milliseconds.
    uint        ReachableTime;
    ///Type: <b>NL_INTERFACE_OFFLOAD_ROD</b> A set of flags that indicate the transmit offload capabilities for the IP
    ///interface. The NL_INTERFACE_OFFLOAD_ROD structure is defined in the <i>Nldef.h</i> header file.
    NL_INTERFACE_OFFLOAD_ROD TransmitOffload;
    ///Type: <b>NL_INTERFACE_OFFLOAD_ROD</b> A set of flags that indicate the receive offload capabilities for the IP
    ///interface. The NL_INTERFACE_OFFLOAD_ROD structure is defined in the <i>Nldef.h</i> header file.
    NL_INTERFACE_OFFLOAD_ROD ReceiveOffload;
    ///Type: <b>BOOLEAN</b> A value that indicates if using default route on the interface should be disabled. This
    ///member can be used by VPN clients to restrict split tunneling.
    ubyte       DisableDefaultRoutes;
}

///The <b>MIB_IPINTERFACE_TABLE</b> structure contains a table of IP interface entries.
struct MIB_IPINTERFACE_TABLE
{
    ///The number of IP interface entries in the array.
    uint NumEntries;
    ///An array of MIB_IPINTERFACE_ROW structures that contain IP interface entries.
    MIB_IPINTERFACE_ROW[1] Table;
}

///The <b>MIB_IFSTACK_ROW</b> structure represents the relationship between two network interfaces.
struct MIB_IFSTACK_ROW
{
    ///The network interface index for the interface that is higher in the interface stack table.
    uint HigherLayerInterfaceIndex;
    ///The network interface index for the interface that is lower in the interface stack table.
    uint LowerLayerInterfaceIndex;
}

///The <b>MIB_INVERTEDIFSTACK_ROW</b> structure represents the relationship between two network interfaces.
struct MIB_INVERTEDIFSTACK_ROW
{
    ///The network interface index for the interface that is lower in the interface stack table.
    uint LowerLayerInterfaceIndex;
    ///The network interface index for the interface that is higher in the interface stack table.
    uint HigherLayerInterfaceIndex;
}

///The <b>MIB_IFSTACK_TABLE</b> structure contains a table of network interface stack row entries. This specifies the
///relationship of the network interfaces on an interface stack.
struct MIB_IFSTACK_TABLE
{
    ///The number of interface stack row entries in the array.
    uint               NumEntries;
    ///An array of MIB_IFSTACK_ROW structures containing interface stack row entries.
    MIB_IFSTACK_ROW[1] Table;
}

///The <b>MIB_INVERTEDIFSTACK_TABLE</b> structure contains a table of inverted network interface stack row entries. This
///specifies the relationship of the network interfaces on an interface stack in reverse order.
struct MIB_INVERTEDIFSTACK_TABLE
{
    ///The number of inverted interface stack row entries in the array.
    uint NumEntries;
    ///An array of MIB_INVERTEDIFSTACK_ROW structures containing inverted interface stack row entries.
    MIB_INVERTEDIFSTACK_ROW[1] Table;
}

///The <b>MIB_IP_NETWORK_CONNECTION_BANDWIDTH_ESTIMATES</b> structure contains read-only information for the bandwidth
///estimates computed by the TCP/IP stack for a network connection.
struct MIB_IP_NETWORK_CONNECTION_BANDWIDTH_ESTIMATES
{
    ///Bandwidth estimates for the data being received by the host from the IP network.
    NL_BANDWIDTH_INFORMATION InboundBandwidthInformation;
    ///Bandwidth estimates for the data being sent from the host to the IP network.
    NL_BANDWIDTH_INFORMATION OutboundBandwidthInformation;
}

///The <b>MIB_UNICASTIPADDRESS_ROW</b> structure stores information about a unicast IP address.
struct MIB_UNICASTIPADDRESS_ROW
{
    ///Type: <b>SOCKADDR_INET</b> The unicast IP address. This member can be an IPv6 address or an IPv4 address.
    SOCKADDR_INET    Address;
    ///Type: <b>NET_LUID</b> The locally unique identifier (LUID) for the network interface associated with this IP
    ///address.
    NET_LUID_LH      InterfaceLuid;
    ///Type: <b>NET_IFINDEX</b> The local index value for the network interface associated with this IP address. This
    ///index value may change when a network adapter is disabled and then enabled, or under other circumstances, and
    ///should not be considered persistent.
    uint             InterfaceIndex;
    ///Type: <b>NL_PREFIX_ORIGIN</b> The origin of the prefix or network part of IP the address. This member can be one
    ///of the values from the <b>NL_PREFIX_ORIGIN</b> enumeration type defined in the <i>Nldef.h</i> header file.
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IpPrefixOriginOther"></a><a
    ///id="ipprefixoriginother"></a><a id="IPPREFIXORIGINOTHER"></a><dl> <dt><b>IpPrefixOriginOther</b></dt> <dt>0</dt>
    ///</dl> </td> <td width="60%"> The IP address prefix was configured using a source other than those defined in this
    ///enumeration. This value is applicable to an IPv6 or IPv4 address. </td> </tr> <tr> <td width="40%"><a
    ///id="IpPrefixOriginManual"></a><a id="ipprefixoriginmanual"></a><a id="IPPREFIXORIGINMANUAL"></a><dl>
    ///<dt><b>IpPrefixOriginManual</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The IP address prefix was configured
    ///manually. This value is applicable to an IPv6 or IPv4 address. </td> </tr> <tr> <td width="40%"><a
    ///id="IpPrefixOriginWellKnown"></a><a id="ipprefixoriginwellknown"></a><a id="IPPREFIXORIGINWELLKNOWN"></a><dl>
    ///<dt><b>IpPrefixOriginWellKnown</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The IP address prefix was
    ///configured using a well-known address. This value is applicable to an IPv6 link-local address or an IPv6 loopback
    ///address. </td> </tr> <tr> <td width="40%"><a id="IpPrefixOriginDhcp"></a><a id="ipprefixorigindhcp"></a><a
    ///id="IPPREFIXORIGINDHCP"></a><dl> <dt><b>IpPrefixOriginDhcp</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> The
    ///IP address prefix was configured using DHCP. This value is applicable to an IPv4 address configured using DHCP or
    ///an IPv6 address configured using DHCPv6. </td> </tr> <tr> <td width="40%"><a
    ///id="IpPrefixOriginRouterAdvertisement"></a><a id="ipprefixoriginrouteradvertisement"></a><a
    ///id="IPPREFIXORIGINROUTERADVERTISEMENT"></a><dl> <dt><b>IpPrefixOriginRouterAdvertisement</b></dt> <dt>4</dt>
    ///</dl> </td> <td width="60%"> The IP address prefix was configured using router advertisement. This value is
    ///applicable to an anonymous IPv6 address that was generated after receiving a router advertisement. </td> </tr>
    ///<tr> <td width="40%"><a id="IpPrefixOriginUnchanged"></a><a id="ipprefixoriginunchanged"></a><a
    ///id="IPPREFIXORIGINUNCHANGED"></a><dl> <dt><b>IpPrefixOriginUnchanged</b></dt> <dt>16</dt> </dl> </td> <td
    ///width="60%"> The IP address prefix should be unchanged. This value is used when setting the properties for a
    ///unicast IP interface when the value for the IP prefix origin should be unchanged. </td> </tr> </table>
    NL_PREFIX_ORIGIN PrefixOrigin;
    ///Type: <b>NL_SUFFIX_ORIGIN</b> The origin of the suffix or host part of IP the address. This member can be one of
    ///the values from the <b>NL_SUFFIX_ORIGIN</b> enumeration type defined in the <i>Nldef.h</i> header file. <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IpSuffixOriginOther"></a><a
    ///id="ipsuffixoriginother"></a><a id="IPSUFFIXORIGINOTHER"></a><dl> <dt><b>IpSuffixOriginOther</b></dt> <dt>0</dt>
    ///</dl> </td> <td width="60%"> The IP address suffix was configured using a source other than those defined in this
    ///enumeration. This value is applicable to an IPv6 or IPv4 address. </td> </tr> <tr> <td width="40%"><a
    ///id="IpSuffixOriginManual"></a><a id="ipsuffixoriginmanual"></a><a id="IPSUFFIXORIGINMANUAL"></a><dl>
    ///<dt><b>IpSuffixOriginManual</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The IP address suffix was configured
    ///manually. This value is applicable to an IPv6 or IPv4 address. </td> </tr> <tr> <td width="40%"><a
    ///id="IpSuffixOriginWellKnown"></a><a id="ipsuffixoriginwellknown"></a><a id="IPSUFFIXORIGINWELLKNOWN"></a><dl>
    ///<dt><b>IpSuffixOriginWellKnown</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The IP address suffix was
    ///configured using a well-known address. This value is applicable to an IPv6 link-local address or an IPv6 loopback
    ///address. </td> </tr> <tr> <td width="40%"><a id="IpSuffixOriginDhcp"></a><a id="ipsuffixorigindhcp"></a><a
    ///id="IPSUFFIXORIGINDHCP"></a><dl> <dt><b>IpSuffixOriginDhcp</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> The
    ///IP address suffix was configured using DHCP. This value is applicable to an IPv4 address configured using DHCP or
    ///an IPv6 address configured using DHCPv6. </td> </tr> <tr> <td width="40%"><a
    ///id="IpSuffixOriginLinkLayerAddress"></a><a id="ipsuffixoriginlinklayeraddress"></a><a
    ///id="IPSUFFIXORIGINLINKLAYERADDRESS"></a><dl> <dt><b>IpSuffixOriginLinkLayerAddress</b></dt> <dt>4</dt> </dl>
    ///</td> <td width="60%"> The IP address suffix was the link local address. This value is applicable to an IPv6
    ///link-local address or an IPv6 address where the network part was generated based on a router advertisement and
    ///the host part was based on the MAC hardware address. </td> </tr> <tr> <td width="40%"><a
    ///id="IpSuffixOriginRandom"></a><a id="ipsuffixoriginrandom"></a><a id="IPSUFFIXORIGINRANDOM"></a><dl>
    ///<dt><b>IpSuffixOriginRandom</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> The IP address suffix was generated
    ///randomly. This value is applicable to an anonymous IPv6 address where the host part of the address was generated
    ///randomly from the MAC hardware address after receiving a router advertisement. </td> </tr> <tr> <td
    ///width="40%"><a id="IpSuffixOriginUnchanged"></a><a id="ipsuffixoriginunchanged"></a><a
    ///id="IPSUFFIXORIGINUNCHANGED"></a><dl> <dt><b>IpSuffixOriginUnchanged</b></dt> <dt>16</dt> </dl> </td> <td
    ///width="60%"> The IP address suffix should be unchanged. This value is used when setting the properties for a
    ///unicast IP interface when the value for the IP suffix origin should be unchanged. </td> </tr> </table>
    NL_SUFFIX_ORIGIN SuffixOrigin;
    ///Type: <b>ULONG</b> The maximum time, in seconds, that the IP address is valid. A value of 0xffffffff is
    ///considered to be infinite.
    uint             ValidLifetime;
    ///Type: <b>ULONG</b> The preferred time, in seconds, that the IP address is valid. A value of 0xffffffff is
    ///considered to be infinite.
    uint             PreferredLifetime;
    ///Type: <b>UINT8</b> The length, in bits, of the prefix or network part of the IP address. For a unicast IPv4
    ///address, any value greater than 32 is an illegal value. For a unicast IPv6 address, any value greater than 128 is
    ///an illegal value. A value of 255 is commonly used to represent an illegal value.
    ubyte            OnLinkPrefixLength;
    ///Type: <b>BOOLEAN</b> This member specifies if the address can be used as an IP source address.
    ubyte            SkipAsSource;
    ///Type: <b>NL_DAD_STATE</b> The duplicate Address detection (DAD) state. Duplicate address detection is applicable
    ///to both IPv6 and IPv4 addresses. This member can be one of the values from the <b>NL_DAD_STATE</b> enumeration
    ///type defined in the <i>Nldef.h</i> header file. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="IpDadStateInvalid"></a><a id="ipdadstateinvalid"></a><a id="IPDADSTATEINVALID"></a><dl>
    ///<dt><b>IpDadStateInvalid</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The DAD state is invalid. </td> </tr>
    ///<tr> <td width="40%"><a id="IpDadStateTentative"></a><a id="ipdadstatetentative"></a><a
    ///id="IPDADSTATETENTATIVE"></a><dl> <dt><b>IpDadStateTentative</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The
    ///DAD state is tentative. </td> </tr> <tr> <td width="40%"><a id="IpDadStateDuplicate"></a><a
    ///id="ipdadstateduplicate"></a><a id="IPDADSTATEDUPLICATE"></a><dl> <dt><b>IpDadStateDuplicate</b></dt> <dt>2</dt>
    ///</dl> </td> <td width="60%"> A duplicate IP address has been detected. </td> </tr> <tr> <td width="40%"><a
    ///id="IpDadStateDeprecated"></a><a id="ipdadstatedeprecated"></a><a id="IPDADSTATEDEPRECATED"></a><dl>
    ///<dt><b>IpDadStateDeprecated</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> The IP address has been deprecated.
    ///</td> </tr> <tr> <td width="40%"><a id="IpDadStatePreferred"></a><a id="ipdadstatepreferred"></a><a
    ///id="IPDADSTATEPREFERRED"></a><dl> <dt><b>IpDadStatePreferred</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> The
    ///IP address is the preferred address. </td> </tr> </table>
    NL_DAD_STATE     DadState;
    ///Type: <b>SCOPE_ID</b> The scope ID of the IP address. This member is applicable only to an IPv6 address. This
    ///member cannot be set. It is automatically determined by the interface on which the address was added.
    SCOPE_ID         ScopeId;
    ///Type: <b>LARGE_INTEGER</b> The time stamp when the IP address was created.
    LARGE_INTEGER    CreationTimeStamp;
}

///The <b>MIB_UNICASTIPADDRESS_TABLE</b> structure contains a table of unicast IP address entries.
struct MIB_UNICASTIPADDRESS_TABLE
{
    ///A value that specifies the number of unicast IP address entries in the array.
    uint NumEntries;
    ///An array of MIB_UNICASTIPADDRESS_ROW structures containing unicast IP address entries.
    MIB_UNICASTIPADDRESS_ROW[1] Table;
}

///The <b>MIB_ANYCASTIPADDRESS_ROW</b> structure stores information about an anycast IP address.
struct MIB_ANYCASTIPADDRESS_ROW
{
    ///The anycast IP address. This member can be an IPv6 address or an IPv4 address.
    SOCKADDR_INET Address;
    ///The locally unique identifier (LUID) for the network interface associated with this IP address.
    NET_LUID_LH   InterfaceLuid;
    ///The local index value for the network interface associated with this IP address. This index value may change when
    ///a network adapter is disabled and then enabled, or under other circumstances, and should not be considered
    ///persistent.
    uint          InterfaceIndex;
    ///The scope ID of the anycast IP address. This member is applicable only to an IPv6 address. This member cannot be
    ///set. It is automatically determined by the interface on which the address was added.
    SCOPE_ID      ScopeId;
}

///The <b>MIB_ANYCASTIPADDRESS_TABLE</b> structure contains a table of anycast IP address entries.
struct MIB_ANYCASTIPADDRESS_TABLE
{
    ///A value that specifies the number of anycast IP address entries in the array.
    uint NumEntries;
    ///An array of MIB_ANYCASTIPADDRESS_ROW structures containing anycast IP address entries.
    MIB_ANYCASTIPADDRESS_ROW[1] Table;
}

///The <b>MIB_MULTICASTIPADDRESS_ROW</b> structure stores information about a multicast IP address.
struct MIB_MULTICASTIPADDRESS_ROW
{
    ///The multicast IP address. This member can be an IPv6 address or an IPv4 address.
    SOCKADDR_INET Address;
    ///The local index value for the network interface associated with this IP address. This index value may change when
    ///a network adapter is disabled and then enabled, or under other circumstances, and should not be considered
    ///persistent.
    uint          InterfaceIndex;
    ///The locally unique identifier (LUID) for the network interface associated with this IP address.
    NET_LUID_LH   InterfaceLuid;
    ///The scope ID of the multicast IP address. This member is applicable only to an IPv6 address. This member cannot
    ///be set. It is automatically determined by the interface on which the address was added.
    SCOPE_ID      ScopeId;
}

///The <b>MIB_MULTICASTIPADDRESS_TABLE</b> structure contains a table of multicast IP address entries.
struct MIB_MULTICASTIPADDRESS_TABLE
{
    ///A value that specifies the number of multicast IP address entries in the array.
    uint NumEntries;
    ///An array of MIB_MULTICASTIPADDRESS_ROW structures containing multicast IP address entries.
    MIB_MULTICASTIPADDRESS_ROW[1] Table;
}

///The <b>MIB_IPFORWARD_ROW2</b> structure stores information about an IP route entry.
struct MIB_IPFORWARD_ROW2
{
    ///Type: <b>NET_LUID</b> The locally unique identifier (LUID) for the network interface associated with this IP
    ///route entry.
    NET_LUID_LH       InterfaceLuid;
    ///Type: <b>NET_IFINDEX</b> The local index value for the network interface associated with this IP route entry.
    ///This index value may change when a network adapter is disabled and then enabled, or under other circumstances,
    ///and should not be considered persistent.
    uint              InterfaceIndex;
    ///Type: <b>IP_ADDRESS_PREFIX</b> The IP address prefix for the destination IP address for this route.
    IP_ADDRESS_PREFIX DestinationPrefix;
    ///Type: <b>SOCKADDR_INET</b> For a remote route, the IP address of the next system or gateway en route. If the
    ///route is to a local loopback address or an IP address on the local link, the next hop is unspecified (all zeros).
    ///For a local loopback route, this member should be an IPv4 address of 0.0.0.0 for an IPv4 route entry or an IPv6
    ///address address of 0::0 for an IPv6 route entry.
    SOCKADDR_INET     NextHop;
    ///Type: <b>UCHAR</b> The length, in bits, of the site prefix or network part of the IP address for this route. For
    ///an IPv4 route entry, any value greater than 32 is an illegal value. For an IPv6 route entry, any value greater
    ///than 128 is an illegal value. A value of 255 is commonly used to represent an illegal value.
    ubyte             SitePrefixLength;
    ///Type: <b>ULONG</b> The maximum time, in seconds, that the IP route entry is valid. A value of 0xffffffff is
    ///considered to be infinite.
    uint              ValidLifetime;
    ///Type: <b>ULONG</b> The preferred time, in seconds, that the IP route entry is valid. A value of 0xffffffff is
    ///considered to be infinite.
    uint              PreferredLifetime;
    ///Type: <b>ULONG</b> The route metric offset value for this IP route entry. Note the actual route metric used to
    ///compute the route preference is the summation of interface metric specified in the <b>Metric</b> member of the
    ///MIB_IPINTERFACE_ROW structure and the route metric offset specified in this member. The semantics of this metric
    ///are determined by the routing protocol specified in the <b>Protocol</b> member. If this metric is not used, its
    ///value should be set to -1. This value is documented in RFC 4292. For more information, see
    ///http://www.ietf.org/rfc/rfc4292.txt.
    uint              Metric;
    ///Type: <b>NL_ROUTE_PROTOCOL</b> The routing mechanism how this IP route was added. This member can be one of the
    ///values from the <b>NL_ROUTE_PROTOCOL</b> enumeration type defined in the <i>Nldef.h</i> header file. The member
    ///is described in RFC 4292. For more information, see http://www.ietf.org/rfc/rfc4292.txt. Note that the
    ///<i>Nldef.h</i> header is automatically included by the <i>Ipmib.h</i> header file which is automatically included
    ///by the <i>Iprtrmib.h</i> header. The <i>Iphlpapi.h</i> header automatically includes the <i>Iprtrmib.h</i> header
    ///file. The <i>Iprtrmib.h</i>, <i>Ipmib.h</i>, and <i>Nldef.h</i> header files should never be used directly. The
    ///following list shows the possible values for this member. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="MIB_IPPROTO_OTHER"></a><a id="mib_ipproto_other"></a><dl>
    ///<dt><b>MIB_IPPROTO_OTHER</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The routing mechanism was not
    ///specified. </td> </tr> <tr> <td width="40%"><a id="MIB_IPPROTO_LOCAL"></a><a id="mib_ipproto_local"></a><dl>
    ///<dt><b>MIB_IPPROTO_LOCAL</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> A local interface. </td> </tr> <tr> <td
    ///width="40%"><a id="MIB_IPPROTO_NETMGMT"></a><a id="mib_ipproto_netmgmt"></a><dl>
    ///<dt><b>MIB_IPPROTO_NETMGMT</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> A static route. This value is used to
    ///identify route information for IP routing set through network management such as the Dynamic Host Configuration
    ///Protocol (DCHP), the Simple Network Management Protocol (SNMP), or by calls to the CreateIpForwardEntry2,
    ///DeleteIpForwardEntry2, or SetIpForwardEntry2 functions. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_IPPROTO_ICMP"></a><a id="mib_ipproto_icmp"></a><dl> <dt><b>MIB_IPPROTO_ICMP</b></dt> <dt>4</dt> </dl>
    ///</td> <td width="60%"> The result of an ICMP redirect. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_IPPROTO_EGP"></a><a id="mib_ipproto_egp"></a><dl> <dt><b>MIB_IPPROTO_EGP</b></dt> <dt>5</dt> </dl> </td>
    ///<td width="60%"> The Exterior Gateway Protocol (EGP), a dynamic routing protocol. </td> </tr> <tr> <td
    ///width="40%"><a id="MIB_IPPROTO_GGP"></a><a id="mib_ipproto_ggp"></a><dl> <dt><b>MIB_IPPROTO_GGP</b></dt>
    ///<dt>6</dt> </dl> </td> <td width="60%"> The Gateway-to-Gateway Protocol (GGP), a dynamic routing protocol. </td>
    ///</tr> <tr> <td width="40%"><a id="MIB_IPPROTO_HELLO"></a><a id="mib_ipproto_hello"></a><dl>
    ///<dt><b>MIB_IPPROTO_HELLO</b></dt> <dt>7</dt> </dl> </td> <td width="60%"> The Hellospeak protocol, a dynamic
    ///routing protocol. This is a historical entry no longer in use and was an early routing protocol used by the
    ///original ARPANET routers that ran special software called the Fuzzball routing protocol, sometimes called
    ///Hellospeak, as described in RFC 891 and RFC 1305. For more information, see http://www.ietf.org/rfc/rfc891.txt
    ///and http://www.ietf.org/rfc/rfc1305.txt. </td> </tr> <tr> <td width="40%"><a id="MIB_IPPROTO_RIP"></a><a
    ///id="mib_ipproto_rip"></a><dl> <dt><b>MIB_IPPROTO_RIP</b></dt> <dt>8</dt> </dl> </td> <td width="60%"> The
    ///Berkeley Routing Information Protocol (RIP) or RIP-II, a dynamic routing protocol. </td> </tr> <tr> <td
    ///width="40%"><a id="MIB_IPPROTO_IS_IS"></a><a id="mib_ipproto_is_is"></a><dl> <dt><b>MIB_IPPROTO_IS_IS</b></dt>
    ///<dt>9</dt> </dl> </td> <td width="60%"> The Intermediate System-to-Intermediate System (IS-IS) protocol, a
    ///dynamic routing protocol. The IS-IS protocol was developed for use in the Open Systems Interconnection (OSI)
    ///protocol suite. </td> </tr> <tr> <td width="40%"><a id="MIB_IPPROTO_ES_IS"></a><a id="mib_ipproto_es_is"></a><dl>
    ///<dt><b>MIB_IPPROTO_ES_IS</b></dt> <dt>10</dt> </dl> </td> <td width="60%"> The End System-to-Intermediate System
    ///(ES-IS) protocol, a dynamic routing protocol. The ES-IS protocol was developed for use in the Open Systems
    ///Interconnection (OSI) protocol suite. </td> </tr> <tr> <td width="40%"><a id="MIB_IPPROTO_CISCO"></a><a
    ///id="mib_ipproto_cisco"></a><dl> <dt><b>MIB_IPPROTO_CISCO</b></dt> <dt>11</dt> </dl> </td> <td width="60%"> The
    ///Cisco Interior Gateway Routing Protocol (IGRP), a dynamic routing protocol. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_IPPROTO_BBN"></a><a id="mib_ipproto_bbn"></a><dl> <dt><b>MIB_IPPROTO_BBN</b></dt> <dt>12</dt> </dl> </td>
    ///<td width="60%"> The Bolt, Beranek, and Newman (BBN) Interior Gateway Protocol (IGP) that used the Shortest Path
    ///First (SPF) algorithm. This was an early dynamic routing protocol. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_IPPROTO_OSPF"></a><a id="mib_ipproto_ospf"></a><dl> <dt><b>MIB_IPPROTO_OSPF</b></dt> <dt>13</dt> </dl>
    ///</td> <td width="60%"> The Open Shortest Path First (OSPF) protocol, a dynamic routing protocol. </td> </tr> <tr>
    ///<td width="40%"><a id="MIB_IPPROTO_BGP"></a><a id="mib_ipproto_bgp"></a><dl> <dt><b>MIB_IPPROTO_BGP</b></dt>
    ///<dt>14</dt> </dl> </td> <td width="60%"> The Border Gateway Protocol (BGP), a dynamic routing protocol. </td>
    ///</tr> <tr> <td width="40%"><a id="MIB_IPPROTO_NT_AUTOSTATIC"></a><a id="mib_ipproto_nt_autostatic"></a><dl>
    ///<dt><b>MIB_IPPROTO_NT_AUTOSTATIC</b></dt> <dt>10002</dt> </dl> </td> <td width="60%"> A Windows specific entry
    ///added originally by a routing protocol, but which is now static. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_IPPROTO_NT_STATIC"></a><a id="mib_ipproto_nt_static"></a><dl> <dt><b>MIB_IPPROTO_NT_STATIC</b></dt>
    ///<dt>10006</dt> </dl> </td> <td width="60%"> A Windows specific entry added as a static route from the routing
    ///user interface or a routing command. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_IPPROTO_NT_STATIC_NON_DOD"></a><a id="mib_ipproto_nt_static_non_dod"></a><dl>
    ///<dt><b>MIB_IPPROTO_NT_STATIC_NON_DOD</b></dt> <dt>10007</dt> </dl> </td> <td width="60%"> A Windows specific
    ///entry added as an static route from the routing user interface or a routing command, except these routes do not
    ///cause Dial On Demand (DOD). </td> </tr> </table>
    NL_ROUTE_PROTOCOL Protocol;
    ///Type: <b>BOOLEAN</b> A value that specifies if the route is a loopback route (the gateway is on the local host).
    ubyte             Loopback;
    ///Type: <b>BOOLEAN</b> A value that specifies if the IP address is autoconfigured.
    ubyte             AutoconfigureAddress;
    ///Type: <b>BOOLEAN</b> A value that specifies if the route is published.
    ubyte             Publish;
    ///Type: <b>BOOLEAN</b> A value that specifies if the route is immortal.
    ubyte             Immortal;
    ///Type: <b>ULONG</b> The number of seconds since the route was added or modified in the network routing table.
    uint              Age;
    ///Type: <b>NL_ROUTE_ORIGIN</b> The origin of the route. This member can be one of the values from the
    ///<b>NL_ROUTE_ORIGIN</b> enumeration type defined in the <i>Nldef.h</i> header file. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="NlroManual"></a><a id="nlromanual"></a><a
    ///id="NLROMANUAL"></a><dl> <dt><b>NlroManual</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> A result of manual
    ///configuration. </td> </tr> <tr> <td width="40%"><a id="NlroWellKnown"></a><a id="nlrowellknown"></a><a
    ///id="NLROWELLKNOWN"></a><dl> <dt><b>NlroWellKnown</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> A well-known
    ///route. </td> </tr> <tr> <td width="40%"><a id="NlroDHCP"></a><a id="nlrodhcp"></a><a id="NLRODHCP"></a><dl>
    ///<dt><b>NlroDHCP</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> A result of DHCP configuration. </td> </tr> <tr>
    ///<td width="40%"><a id="NlroRouterAdvertisement"></a><a id="nlrorouteradvertisement"></a><a
    ///id="NLROROUTERADVERTISEMENT"></a><dl> <dt><b>NlroRouterAdvertisement</b></dt> <dt>3</dt> </dl> </td> <td
    ///width="60%"> The result of router advertisement. </td> </tr> <tr> <td width="40%"><a id="Nlro6to4"></a><a
    ///id="nlro6to4"></a><a id="NLRO6TO4"></a><dl> <dt><b>Nlro6to4</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> A
    ///result of 6to4 tunneling. </td> </tr> </table>
    NL_ROUTE_ORIGIN   Origin;
}

///The <b>MIB_IPFORWARD_TABLE2</b> structure contains a table of IP route entries.
struct MIB_IPFORWARD_TABLE2
{
    ///A value that specifies the number of IP route entries in the array.
    uint NumEntries;
    ///An array of MIB_IPFORWARD_ROW2 structures containing IP route entries.
    MIB_IPFORWARD_ROW2[1] Table;
}

///The <b>MIB_IPPATH_ROW</b> structure stores information about an IP path entry.
struct MIB_IPPATH_ROW
{
    ///Type: <b>SOCKADDR_INET</b> The source IP address for this IP path entry.
    SOCKADDR_INET Source;
    ///Type: <b>SOCKADDR_INET</b> The destination IP address for this IP path entry.
    SOCKADDR_INET Destination;
    ///Type: <b>NET_LUID</b> The locally unique identifier (LUID) for the network interface associated with this IP path
    ///entry.
    NET_LUID_LH   InterfaceLuid;
    ///Type: <b>NET_IFINDEX</b> The local index value for the network interface associated with this IP path entry. This
    ///index value may change when a network adapter is disabled and then enabled, or under other circumstances, and
    ///should not be considered persistent.
    uint          InterfaceIndex;
    ///Type: <b>SOCKADDR_INET</b> The current IP address of the next system or gateway en route. This member can change
    ///over the lifetime of a path.
    SOCKADDR_INET CurrentNextHop;
    ///Type: <b>ULONG</b> The maximum transmission unit (MTU) size, in bytes, to the destination IP address for this IP
    ///path entry.
    uint          PathMtu;
    ///Type: <b>ULONG</b> The estimated mean round-trip time (RTT), in milliseconds, to the destination IP address for
    ///this IP path entry.
    uint          RttMean;
    ///Type: <b>ULONG</b> The estimated mean deviation for the round-trip time (RTT), in milliseconds, to the
    ///destination IP address for this IP path entry.
    uint          RttDeviation;
    union
    {
        uint LastReachable;
        uint LastUnreachable;
    }
    ///Type: <b>BOOLEAN</b> A value that indicates if the destination IP address is reachable for this IP path entry.
    ubyte         IsReachable;
    ///Type: <b>ULONG64</b> The estimated speed in bits per second of the transmit link to the destination IP address
    ///for this IP path entry.
    ulong         LinkTransmitSpeed;
    ///Type: <b>ULONG64</b> The estimated speed in bits per second of the receive link from the destination IP address
    ///for this IP path entry.
    ulong         LinkReceiveSpeed;
}

///The <b>MIB_IPPATH_TABLE</b> structure contains a table of IP path entries.
struct MIB_IPPATH_TABLE
{
    ///A value that specifies the number of IP path entries in the array.
    uint              NumEntries;
    ///An array of MIB_IPPATH_ROW structures containing IP path entries.
    MIB_IPPATH_ROW[1] Table;
}

///The <b>MIB_IPNET_ROW2</b> structure stores information about a neighbor IP address.
struct MIB_IPNET_ROW2
{
    ///Type: <b>SOCKADDR_INET</b> The neighbor IP address. This member can be an IPv6 address or an IPv4 address.
    SOCKADDR_INET     Address;
    ///Type: <b>NET_IFINDEX</b> The local index value for the network interface associated with this IP address. This
    ///index value may change when a network adapter is disabled and then enabled, or under other circumstances, and
    ///should not be considered persistent.
    uint              InterfaceIndex;
    ///Type: <b>NET_LUID</b> The locally unique identifier (LUID) for the network interface associated with this IP
    ///address.
    NET_LUID_LH       InterfaceLuid;
    ///Type: <b> UCHAR[IF_MAX_PHYS_ADDRESS_LENGTH]</b> The physical hardware address of the adapter for the network
    ///interface associated with this IP address.
    ubyte[32]         PhysicalAddress;
    ///Type: <b>ULONG</b> The length, in bytes, of the physical hardware address specified by the <b>PhysicalAddress</b>
    ///member. The maximum value supported is 32 bytes.
    uint              PhysicalAddressLength;
    ///Type: <b>NL_NEIGHBOR_STATE</b> The state of a network neighbor IP address as defined in RFC 2461, section 7.3.2.
    ///For more information, see http://www.ietf.org/rfc/rfc2461.txt. This member can be one of the values from the
    ///<b>NL_NEIGHBOR_STATE</b> enumeration type defined in the <i>Nldef.h</i> header file. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="NlnsUnreachable"></a><a id="nlnsunreachable"></a><a
    ///id="NLNSUNREACHABLE"></a><dl> <dt><b>NlnsUnreachable</b></dt> </dl> </td> <td width="60%"> The IP address is
    ///unreachable. </td> </tr> <tr> <td width="40%"><a id="NlnsIncomplete"></a><a id="nlnsincomplete"></a><a
    ///id="NLNSINCOMPLETE"></a><dl> <dt><b>NlnsIncomplete</b></dt> </dl> </td> <td width="60%"> Address resolution is in
    ///progress and the link-layer address of the neighbor has not yet been determined. Specifically for IPv6, a
    ///Neighbor Solicitation has been sent to the solicited-node multicast IP address of the target, but the
    ///corresponding neighbor advertisement has not yet been received. </td> </tr> <tr> <td width="40%"><a
    ///id="NlnsProbe"></a><a id="nlnsprobe"></a><a id="NLNSPROBE"></a><dl> <dt><b>NlnsProbe</b></dt> </dl> </td> <td
    ///width="60%"> The neighbor is no longer known to be reachable, and probes are being sent to verify reachability.
    ///For IPv6, a reachability confirmation is actively being sought by retransmitting unicast Neighbor Solicitation
    ///probes at regular intervals until a reachability confirmation is received. </td> </tr> <tr> <td width="40%"><a
    ///id="NlnsDelay"></a><a id="nlnsdelay"></a><a id="NLNSDELAY"></a><dl> <dt><b>NlnsDelay</b></dt> </dl> </td> <td
    ///width="60%"> The neighbor is no longer known to be reachable, and traffic has recently been sent to the neighbor.
    ///Rather than probe the neighbor immediately, however, delay sending probes for a short while in order to give
    ///upper layer protocols a chance to provide reachability confirmation. For IPv6, more time has elapsed than is
    ///specified in the <b>ReachabilityTime.ReachableTime</b> member since the last positive confirmation was received
    ///that the forward path was functioning properly and a packet was sent. If no reachability confirmation is received
    ///within a period of time (used to delay the first probe) of entering the <b>NlnsDelay</b> state, then a neighbor
    ///solicitation is sent and the <b>State</b> member is changed to <b>NlnsProbe</b>. </td> </tr> <tr> <td
    ///width="40%"><a id="NlnsStale"></a><a id="nlnsstale"></a><a id="NLNSSTALE"></a><dl> <dt><b>NlnsStale</b></dt>
    ///</dl> </td> <td width="60%"> The neighbor is no longer known to be reachable but until traffic is sent to the
    ///neighbor, no attempt should be made to verify its reachability. For IPv6, more time has elapsed than is specified
    ///in the <b>ReachabilityTime.ReachableTime</b> member since the last positive confirmation was received that the
    ///forward path was functioning properly. While the <b>State</b> is <b>NlnsStale</b>, no action takes place until a
    ///packet is sent. The <b>NlnsStale</b> state is entered upon receiving an unsolicited neighbor discovery message
    ///that updates the cached IP address. Receipt of such a message does not confirm reachability, and entering the
    ///<b>NlnsStale</b> state insures reachability is verified quickly if the entry is actually being used. However,
    ///reachability is not actually verified until the entry is actually used. </td> </tr> <tr> <td width="40%"><a
    ///id="NlnsReachable"></a><a id="nlnsreachable"></a><a id="NLNSREACHABLE"></a><dl> <dt><b>NlnsReachable</b></dt>
    ///</dl> </td> <td width="60%"> The neighbor is known to have been reachable recently (within tens of seconds ago).
    ///For IPv6, a positive confirmation was received within the time specified in the
    ///<b>ReachabilityTime.ReachableTime</b> member that the forward path to the neighbor was functioning properly.
    ///While the <b>State</b> is <b>NlnsReachable</b>, no special action takes place as packets are sent. </td> </tr>
    ///<tr> <td width="40%"><a id="NlnsPermanent"></a><a id="nlnspermanent"></a><a id="NLNSPERMANENT"></a><dl>
    ///<dt><b>NlnsPermanent</b></dt> </dl> </td> <td width="60%"> The IP address is a permanent address. </td> </tr>
    ///<tr> <td width="40%"><a id="NlnsMaximum"></a><a id="nlnsmaximum"></a><a id="NLNSMAXIMUM"></a><dl>
    ///<dt><b>NlnsMaximum</b></dt> </dl> </td> <td width="60%"> The maximum possible value for the
    ///<b>NL_NEIGHBOR_STATE</b> enumeration type. This is not a legal value for the <b>State</b> member. </td> </tr>
    ///</table>
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

///The <b>MIB_IPNET_TABLE2</b> structure contains a table of neighbor IP address entries.
struct MIB_IPNET_TABLE2
{
    ///A value that specifies the number of IP network neighbor address entries in the array.
    uint              NumEntries;
    ///An array of MIB_IPNET_ROW2 structures containing IP network neighbor address entries.
    MIB_IPNET_ROW2[1] Table;
}

///The <b>MIB_OPAQUE_QUERY</b> structure contains information for a MIB opaque query.
struct MIB_OPAQUE_QUERY
{
    ///The identifier of the MIB object to query.
    uint    dwVarId;
    ///The index of the MIB object to query.
    uint[1] rgdwVarIndex;
}

///The <b>MIB_IFNUMBER</b> structure stores the number of interfaces on a particular computer.
struct MIB_IFNUMBER
{
    ///The number of interfaces on the computer.
    uint dwValue;
}

///The <b>MIB_IFROW</b> structure stores information about a particular interface.
struct MIB_IFROW
{
    ///Type: <b>WCHAR[MAX_INTERFACE_NAME_LEN]</b> A pointer to a Unicode string that contains the name of the interface.
    ushort[256] wszName;
    ///Type: <b>DWORD</b> The index that identifies the interface. This index value may change when a network adapter is
    ///disabled and then enabled, and should not be considered persistent.
    uint        dwIndex;
    ///Type: <b>DWORD</b> The interface type as defined by the Internet Assigned Names Authority (IANA). For more
    ///information, see http://www.iana.org/assignments/ianaiftype-mib. Possible values for the interface type are
    ///listed in the <i>Ipifcons.h</i> header file. The table below lists common values for the interface type although
    ///many other values are possible. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="IF_TYPE_OTHER"></a><a id="if_type_other"></a><dl> <dt><b>IF_TYPE_OTHER</b></dt> <dt>1</dt> </dl> </td> <td
    ///width="60%"> Some other type of network interface. </td> </tr> <tr> <td width="40%"><a
    ///id="IF_TYPE_ETHERNET_CSMACD"></a><a id="if_type_ethernet_csmacd"></a><dl> <dt><b>IF_TYPE_ETHERNET_CSMACD</b></dt>
    ///<dt>6</dt> </dl> </td> <td width="60%"> An Ethernet network interface. </td> </tr> <tr> <td width="40%"><a
    ///id="IF_TYPE_ISO88025_TOKENRING"></a><a id="if_type_iso88025_tokenring"></a><dl>
    ///<dt><b>IF_TYPE_ISO88025_TOKENRING</b></dt> <dt>9</dt> </dl> </td> <td width="60%"> A token ring network
    ///interface. </td> </tr> <tr> <td width="40%"><a id="IF_TYPE_FDDI"></a><a id="if_type_fddi"></a><dl>
    ///<dt><b>IF_TYPE_FDDI</b></dt> <dt>15</dt> </dl> </td> <td width="60%"> A Fiber Distributed Data Interface (FDDI)
    ///network interface. </td> </tr> <tr> <td width="40%"><a id="IF_TYPE_PPP"></a><a id="if_type_ppp"></a><dl>
    ///<dt><b>IF_TYPE_PPP</b></dt> <dt>23</dt> </dl> </td> <td width="60%"> A PPP network interface. </td> </tr> <tr>
    ///<td width="40%"><a id="IF_TYPE_SOFTWARE_LOOPBACK"></a><a id="if_type_software_loopback"></a><dl>
    ///<dt><b>IF_TYPE_SOFTWARE_LOOPBACK</b></dt> <dt>24</dt> </dl> </td> <td width="60%"> A software loopback network
    ///interface. </td> </tr> <tr> <td width="40%"><a id="IF_TYPE_ATM"></a><a id="if_type_atm"></a><dl>
    ///<dt><b>IF_TYPE_ATM</b></dt> <dt>37</dt> </dl> </td> <td width="60%"> An ATM network interface. </td> </tr> <tr>
    ///<td width="40%"><a id="IF_TYPE_IEEE80211"></a><a id="if_type_ieee80211"></a><dl>
    ///<dt><b>IF_TYPE_IEEE80211</b></dt> <dt>71</dt> </dl> </td> <td width="60%"> An IEEE 802.11 wireless network
    ///interface. </td> </tr> <tr> <td width="40%"><a id="IF_TYPE_TUNNEL"></a><a id="if_type_tunnel"></a><dl>
    ///<dt><b>IF_TYPE_TUNNEL</b></dt> <dt>131</dt> </dl> </td> <td width="60%"> A tunnel type encapsulation network
    ///interface. </td> </tr> <tr> <td width="40%"><a id="IF_TYPE_IEEE1394"></a><a id="if_type_ieee1394"></a><dl>
    ///<dt><b>IF_TYPE_IEEE1394</b></dt> <dt>144</dt> </dl> </td> <td width="60%"> An IEEE 1394 (Firewire) high
    ///performance serial bus network interface. </td> </tr> <tr> <td width="40%"><a id="_IF_TYPE_IEEE80216_WMAN"></a><a
    ///id="_if_type_ieee80216_wman"></a><dl> <dt><b> IF_TYPE_IEEE80216_WMAN</b></dt> <dt>237</dt> </dl> </td> <td
    ///width="60%"> A mobile broadband interface for WiMax devices. <div class="alert"><b>Note</b> This interface type
    ///is supported on Windows 7, Windows Server 2008 R2, and later.</div> <div> </div> </td> </tr> <tr> <td
    ///width="40%"><a id="IF_TYPE_WWANPP"></a><a id="if_type_wwanpp"></a><dl> <dt><b>IF_TYPE_WWANPP</b></dt>
    ///<dt>243</dt> </dl> </td> <td width="60%"> A mobile broadband interface for GSM-based devices. <div
    ///class="alert"><b>Note</b> This interface type is supported on Windows 7, Windows Server 2008 R2, and later.</div>
    ///<div> </div> </td> </tr> <tr> <td width="40%"><a id="IF_TYPE_WWANPP2"></a><a id="if_type_wwanpp2"></a><dl>
    ///<dt><b>IF_TYPE_WWANPP2</b></dt> <dt>244</dt> </dl> </td> <td width="60%"> An mobile broadband interface for
    ///CDMA-based devices. <div class="alert"><b>Note</b> This interface type is supported on Windows 7, Windows Server
    ///2008 R2, and later.</div> <div> </div> </td> </tr> </table>
    uint        dwType;
    ///Type: <b>DWORD</b> The Maximum Transmission Unit (MTU) size in bytes.
    uint        dwMtu;
    ///Type: <b>DWORD</b> The speed of the interface in bits per second.
    uint        dwSpeed;
    ///Type: <b>DWORD</b> The length, in bytes, of the physical address specified by the <b>bPhysAddr</b> member.
    uint        dwPhysAddrLen;
    ///Type: <b>BYTE[MAXLEN_PHYSADDR]</b> The physical address of the adapter for this interface.
    ubyte[8]    bPhysAddr;
    ///Type: <b>DWORD</b> The interface is administratively enabled or disabled.
    uint        dwAdminStatus;
    ///Type: <b>DWORD</b> The operational status of the interface. This member can be one of the following values
    ///defined in the INTERNAL_IF_OPER_STATUS enumeration defined in the <i>Ipifcons.h</i> header file. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="IF_OPER_STATUS_NON_OPERATIONAL"></a><a
    ///id="if_oper_status_non_operational"></a><dl> <dt><b>IF_OPER_STATUS_NON_OPERATIONAL</b></dt> </dl> </td> <td
    ///width="60%"> LAN adapter has been disabled, for example because of an address conflict. </td> </tr> <tr> <td
    ///width="40%"><a id="IF_OPER_STATUS_UNREACHABLE"></a><a id="if_oper_status_unreachable"></a><dl>
    ///<dt><b>IF_OPER_STATUS_UNREACHABLE</b></dt> </dl> </td> <td width="60%"> WAN adapter that is not connected. </td>
    ///</tr> <tr> <td width="40%"><a id="IF_OPER_STATUS_DISCONNECTED"></a><a id="if_oper_status_disconnected"></a><dl>
    ///<dt><b>IF_OPER_STATUS_DISCONNECTED</b></dt> </dl> </td> <td width="60%"> For LAN adapters: network cable
    ///disconnected. For WAN adapters: no carrier. </td> </tr> <tr> <td width="40%"><a
    ///id="IF_OPER_STATUS_CONNECTING"></a><a id="if_oper_status_connecting"></a><dl>
    ///<dt><b>IF_OPER_STATUS_CONNECTING</b></dt> </dl> </td> <td width="60%"> WAN adapter that is in the process of
    ///connecting. </td> </tr> <tr> <td width="40%"><a id="IF_OPER_STATUS_CONNECTED"></a><a
    ///id="if_oper_status_connected"></a><dl> <dt><b>IF_OPER_STATUS_CONNECTED</b></dt> </dl> </td> <td width="60%"> WAN
    ///adapter that is connected to a remote peer. </td> </tr> <tr> <td width="40%"><a
    ///id="IF_OPER_STATUS_OPERATIONAL"></a><a id="if_oper_status_operational"></a><dl>
    ///<dt><b>IF_OPER_STATUS_OPERATIONAL</b></dt> </dl> </td> <td width="60%"> Default status for LAN adapters </td>
    ///</tr> </table>
    INTERNAL_IF_OPER_STATUS dwOperStatus;
    ///Type: <b>DWORD</b> The length of time, in hundredths of seconds (10^-2 sec), starting from the last computer
    ///restart, when the interface entered its current operational state. This value rolls over after 2^32 hundredths of
    ///a second. The <b>dwLastChange</b> member is not currently supported by NDIS. On Windows Vista and later, NDIS
    ///returns zero for this member. On earlier versions of Windows, an arbitrary value is returned in this member for
    ///the interfaces supported by NDIS. For interfaces supported by other interface providers, they might return an
    ///appropriate value.
    uint        dwLastChange;
    ///Type: <b>DWORD</b> The number of octets of data received through this interface.
    uint        dwInOctets;
    ///Type: <b>DWORD</b> The number of unicast packets received through this interface.
    uint        dwInUcastPkts;
    ///Type: <b>DWORD</b> The number of non-unicast packets received through this interface. Broadcast and multicast
    ///packets are included.
    uint        dwInNUcastPkts;
    ///Type: <b>DWORD</b> The number of incoming packets that were discarded even though they did not have errors.
    uint        dwInDiscards;
    ///Type: <b>DWORD</b> The number of incoming packets that were discarded because of errors.
    uint        dwInErrors;
    ///Type: <b>DWORD</b> The number of incoming packets that were discarded because the protocol was unknown.
    uint        dwInUnknownProtos;
    ///Type: <b>DWORD</b> The number of octets of data sent through this interface.
    uint        dwOutOctets;
    ///Type: <b>DWORD</b> The number of unicast packets sent through this interface.
    uint        dwOutUcastPkts;
    ///Type: <b>DWORD</b> The number of non-unicast packets sent through this interface. Broadcast and multicast packets
    ///are included.
    uint        dwOutNUcastPkts;
    ///Type: <b>DWORD</b> The number of outgoing packets that were discarded even though they did not have errors.
    uint        dwOutDiscards;
    ///Type: <b>DWORD</b> The number of outgoing packets that were discarded because of errors.
    uint        dwOutErrors;
    ///Type: <b>DWORD</b> The transmit queue length. This field is not currently used.
    uint        dwOutQLen;
    ///Type: <b>DWORD</b> The length, in bytes, of the <b>bDescr</b> member.
    uint        dwDescrLen;
    ///Type: <b>BYTE[MAXLEN_IFDESCR]</b> A description of the interface.
    ubyte[256]  bDescr;
}

///The <b>MIB_IFTABLE</b> structure contains a table of interface entries.
struct MIB_IFTABLE
{
    ///The number of interface entries in the array.
    uint         dwNumEntries;
    ///An array of MIB_IFROW structures containing interface entries.
    MIB_IFROW[1] table;
}

///The <b>MIB_IPADDRROW</b>specifies information for a particular IPv4 address in the MIB_IPADDRTABLE structure.
struct MIB_IPADDRROW_XP
{
    ///Type: <b>DWORD</b> The IPv4 address in network byte order.
    uint   dwAddr;
    ///Type: <b>DWORD</b> The index of the interface associated with this IPv4 address.
    uint   dwIndex;
    ///Type: <b>DWORD</b> The subnet mask for the IPv4 address in network byte order.
    uint   dwMask;
    ///Type: <b>DWORD</b> The broadcast address in network byte order. A broadcast address is typically the IPv4 address
    ///with the host portion set to either all zeros or all ones. The proper value for this member is not returned by
    ///the GetIpAddrTable function.
    uint   dwBCastAddr;
    ///Type: <b>DWORD</b> The maximum re-assembly size for received datagrams.
    uint   dwReasmSize;
    ///Type: <b>unsigned short</b> This member is reserved.
    ushort unused1;
    ///Type: <b>unsigned short</b> The address type or state. This member can be a combination of the following values.
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MIB_IPADDR_PRIMARY"></a><a
    ///id="mib_ipaddr_primary"></a><dl> <dt><b>MIB_IPADDR_PRIMARY</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%">
    ///Primary IP address </td> </tr> <tr> <td width="40%"><a id="MIB_IPADDR_DYNAMIC"></a><a
    ///id="mib_ipaddr_dynamic"></a><dl> <dt><b>MIB_IPADDR_DYNAMIC</b></dt> <dt>0x0004</dt> </dl> </td> <td width="60%">
    ///Dynamic IP address </td> </tr> <tr> <td width="40%"><a id="MIB_IPADDR_DISCONNECTED"></a><a
    ///id="mib_ipaddr_disconnected"></a><dl> <dt><b>MIB_IPADDR_DISCONNECTED</b></dt> <dt>0x0008</dt> </dl> </td> <td
    ///width="60%"> Address is on disconnected interface </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_IPADDR_DELETED"></a><a id="mib_ipaddr_deleted"></a><dl> <dt><b>MIB_IPADDR_DELETED</b></dt>
    ///<dt>0x0040</dt> </dl> </td> <td width="60%"> Address is being deleted </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_IPADDR_TRANSIENT"></a><a id="mib_ipaddr_transient"></a><dl> <dt><b>MIB_IPADDR_TRANSIENT</b></dt>
    ///<dt>0x0080</dt> </dl> </td> <td width="60%"> Transient address </td> </tr> </table>
    ushort wType;
}

///The <b>MIB_IPADDRROW</b>specifies information for a particular IPv4 address in the MIB_IPADDRTABLE structure.
struct MIB_IPADDRROW_W2K
{
    ///Type: <b>DWORD</b> The IPv4 address in network byte order.
    uint   dwAddr;
    ///Type: <b>DWORD</b> The index of the interface associated with this IPv4 address.
    uint   dwIndex;
    ///Type: <b>DWORD</b> The subnet mask for the IPv4 address in network byte order.
    uint   dwMask;
    ///Type: <b>DWORD</b> The broadcast address in network byte order. A broadcast address is typically the IPv4 address
    ///with the host portion set to either all zeros or all ones. The proper value for this member is not returned by
    ///the GetIpAddrTable function.
    uint   dwBCastAddr;
    ///Type: <b>DWORD</b> The maximum re-assembly size for received datagrams.
    uint   dwReasmSize;
    ///Type: <b>unsigned short</b> This member is reserved.
    ushort unused1;
    ///Type: <b>unsigned short</b> This member is reserved.
    ushort unused2;
}

///The <b>MIB_IPADDRTABLE</b> structure contains a table of IPv4 address entries.
struct MIB_IPADDRTABLE
{
    ///The number of IPv4 address entries in the table.
    uint                dwNumEntries;
    ///A pointer to a table of IPv4 address entries implemented as an array of MIB_IPADDRROW structures.
    MIB_IPADDRROW_XP[1] table;
}

///The <b>MIB_IPFORWARDNUMBER</b> structure stores the number of routes in a particular IP routing table.
struct MIB_IPFORWARDNUMBER
{
    ///Specifies the number of routes in the IP routing table.
    uint dwValue;
}

///The <b>MIB_IPFORWARDROW</b> structure contains information that describes an IPv4 network route.
struct MIB_IPFORWARDROW
{
    ///Type: <b>DWORD</b> The destination IPv4 address of the route. An entry with a IPv4 address of 0.0.0.0 is
    ///considered a default route. This member cannot be set to a multicast (class D) IPv4 address.
    uint dwForwardDest;
    ///Type: <b>DWORD</b> The IPv4 subnet mask to use with the destination IPv4 address before being compared to the
    ///value in the <b>dwForwardDest</b> member. The <b>dwForwardMask</b> value should be applied to the destination
    ///IPv4 address (logical and operation) before a comparison with the value in the <b>dwForwardDest</b> member.
    uint dwForwardMask;
    ///Type: <b>DWORD</b> The set of conditions that would cause the selection of a multi-path route (the set of next
    ///hops for a given destination). This member is typically in IP TOS format. This encoding of this member is
    ///described in RFC 1354. For more information, see http://www.ietf.org/rfc/rfc1354.txt.
    uint dwForwardPolicy;
    ///Type: <b>DWORD</b> For remote routes, the IPv4 address of the next system en route. Otherwise, this member should
    ///be an IPv4 address of 0.0.0.0.
    uint dwForwardNextHop;
    ///Type: <b>DWORD</b> The index of the local interface through which the next hop of this route should be reached.
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
    ///Type: <b>DWORD</b> The number of seconds since the route was added or modified in the network routing table.
    uint dwForwardAge;
    ///Type: <b>DWORD</b> The autonomous system number of the next hop. When this member is unknown or not relevant to
    ///the protocol or routing mechanism specified in <b>dwForwardProto</b>, this value should be set to zero. This
    ///value is documented in RFC 1354. For more information, see http://www.ietf.org/rfc/rfc1354.txt
    uint dwForwardNextHopAS;
    ///Type: <b>DWORD</b> The primary routing metric value for this route. The semantics of this metric are determined
    ///by the routing protocol specified in the <b>dwForwardProto</b> member. If this metric is not used, its value
    ///should be set to -1. This value is documented in in RFC 1354. For more information, see
    ///http://www.ietf.org/rfc/rfc1354.txt
    uint dwForwardMetric1;
    ///Type: <b>DWORD</b> An alternate routing metric value for this route. The semantics of this metric are determined
    ///by the routing protocol specified in the <b>dwForwardProto</b> member. If this metric is not used, its value
    ///should be set to -1. This value is documented in RFC 1354. For more information, see
    ///http://www.ietf.org/rfc/rfc1354.txt
    uint dwForwardMetric2;
    ///Type: <b>DWORD</b> An alternate routing metric value for this route. The semantics of this metric are determined
    ///by the routing protocol specified in the <b>dwForwardProto</b> member. If this metric is not used, its value
    ///should be set to -1. This value is documented in RFC 1354. For more information, see
    ///http://www.ietf.org/rfc/rfc1354.txt
    uint dwForwardMetric3;
    ///Type: <b>DWORD</b> An alternate routing metric value for this route. The semantics of this metric are determined
    ///by the routing protocol specified in the <b>dwForwardProto</b> member. If this metric is not used, its value
    ///should be set to -1. This value is documented in RFC 1354. For more information, see
    ///http://www.ietf.org/rfc/rfc1354.txt
    uint dwForwardMetric4;
    ///Type: <b>DWORD</b> An alternate routing metric value for this route. The semantics of this metric are determined
    ///by the routing protocol specified in the <b>dwForwardProto</b> member. If this metric is not used, its value
    ///should be set to -1. This value is documented in RFC 1354. For more information, see
    ///http://www.ietf.org/rfc/rfc1354.txt
    uint dwForwardMetric5;
}

///The <b>MIB_IPFORWARDTABLE</b> structure contains a table of IPv4 route entries.
struct MIB_IPFORWARDTABLE
{
    ///The number of route entries in the table.
    uint                dwNumEntries;
    ///A pointer to a table of route entries implemented as an array of MIB_IPFORWARDROW structures.
    MIB_IPFORWARDROW[1] table;
}

///The <b>MIB_IPNETROW</b> structure contains information for an Address Resolution Protocol (ARP) table entry for an
///IPv4 address.
struct MIB_IPNETROW_LH
{
    ///Type: <b>DWORD</b> The index of the adapter.
    uint     dwIndex;
    ///Type: <b>DWORD</b> The length, in bytes, of the physical address.
    uint     dwPhysAddrLen;
    ///Type: <b>BYTE[MAXLEN_PHYSADDR]</b> The physical address.
    ubyte[8] bPhysAddr;
    ///Type: <b>DWORD</b> The IPv4 address.
    uint     dwAddr;
    union
    {
        uint           dwType;
        MIB_IPNET_TYPE Type;
    }
}

///The <b>MIB_IPNETROW</b> structure contains information for an Address Resolution Protocol (ARP) table entry for an
///IPv4 address.
struct MIB_IPNETROW_W2K
{
    ///Type: <b>DWORD</b> The index of the adapter.
    uint     dwIndex;
    ///Type: <b>DWORD</b> The length, in bytes, of the physical address.
    uint     dwPhysAddrLen;
    ///Type: <b>BYTE[MAXLEN_PHYSADDR]</b> The physical address.
    ubyte[8] bPhysAddr;
    ///Type: <b>DWORD</b> The IPv4 address.
    uint     dwAddr;
    ///Type: <b>DWORD</b> The type of ARP entry. This member can be one of the values from the <b>MIB_IPNET_TYPE</b>
    ///enumeration type defined in the <i>Ipmib.h</i> header file included in the Windows SDK released for Windows Vista
    ///and later. For use with versions of the earlier Platform SDK, this enumeration is not defined and the constants
    ///must be used. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="MIB_IPNET_TYPE_OTHER"></a><a id="mib_ipnet_type_other"></a><dl> <dt><b>MIB_IPNET_TYPE_OTHER</b></dt>
    ///<dt>1</dt> </dl> </td> <td width="60%"> Other </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_IPNET_TYPE_INVALID"></a><a id="mib_ipnet_type_invalid"></a><dl> <dt><b>MIB_IPNET_TYPE_INVALID</b></dt>
    ///<dt>2</dt> </dl> </td> <td width="60%"> An invalid ARP type. This can indicate an unreachable or incomplete ARP
    ///entry. </td> </tr> <tr> <td width="40%"><a id="MIB_IPNET_TYPE_DYNAMIC"></a><a
    ///id="mib_ipnet_type_dynamic"></a><dl> <dt><b>MIB_IPNET_TYPE_DYNAMIC</b></dt> <dt>3</dt> </dl> </td> <td
    ///width="60%"> A dynamic ARP type. </td> </tr> <tr> <td width="40%"><a id="MIB_IPNET_TYPE_STATIC"></a><a
    ///id="mib_ipnet_type_static"></a><dl> <dt><b>MIB_IPNET_TYPE_STATIC</b></dt> <dt>4</dt> </dl> </td> <td width="60%">
    ///A static ARP type. </td> </tr> </table>
    uint     dwType;
}

///The <b>MIB_IPNETTABLE</b> structure contains a table of Address Resolution Protocol (ARP) entries for IPv4 addresses.
struct MIB_IPNETTABLE
{
    ///The number of ARP entries in the table.
    uint               dwNumEntries;
    ///A pointer to a table of ARP entries implemented as an array of MIB_IPNETROW structures.
    MIB_IPNETROW_LH[1] table;
}

///The <b>MIB_IPSTATS</b> structure stores information about the IP protocol running on a particular computer.
struct MIB_IPSTATS_LH
{
    union
    {
        uint dwForwarding;
        MIB_IPSTATS_FORWARDING Forwarding;
    }
    ///Type: <b>DWORD</b> The default initial time-to-live (TTL) for datagrams originating on a particular computer.
    ///This member can be set to <b>MIB_USE_CURRENT_TTL</b> to use the current deafult TTL value when setting the
    ///forwarding and time-to-live (TTL) options using the <b>SetIpStatistics</b> and SetIpStatisticsEx functions.
    uint dwDefaultTTL;
    ///Type: <b>DWORD</b> The number of datagrams received.
    uint dwInReceives;
    ///Type: <b>DWORD</b> The number of datagrams received that have header errors.
    uint dwInHdrErrors;
    ///Type: <b>DWORD</b> The number of datagrams received that have address errors.
    uint dwInAddrErrors;
    ///Type: <b>DWORD</b> The number of datagrams forwarded.
    uint dwForwDatagrams;
    ///Type: <b>DWORD</b> The number of datagrams received that have an unknown protocol.
    uint dwInUnknownProtos;
    ///Type: <b>DWORD</b> The number of received datagrams discarded.
    uint dwInDiscards;
    ///Type: <b>DWORD</b> The number of received datagrams delivered.
    uint dwInDelivers;
    ///Type: <b>DWORD</b> The number of outgoing datagrams that IP is requested to transmit. This number does not
    ///include forwarded datagrams.
    uint dwOutRequests;
    ///Type: <b>DWORD</b> The number of outgoing datagrams discarded.
    uint dwRoutingDiscards;
    ///Type: <b>DWORD</b> The number of transmitted datagrams discarded.
    uint dwOutDiscards;
    ///Type: <b>DWORD</b> The number of datagrams for which this computer did not have a route to the destination IP
    ///address. These datagrams were discarded.
    uint dwOutNoRoutes;
    ///Type: <b>DWORD</b> The amount of time allowed for all pieces of a fragmented datagram to arrive. If all pieces do
    ///not arrive within this time, the datagram is discarded.
    uint dwReasmTimeout;
    ///Type: <b>DWORD</b> The number of datagrams that require re-assembly.
    uint dwReasmReqds;
    ///Type: <b>DWORD</b> The number of datagrams that were successfully reassembled.
    uint dwReasmOks;
    ///Type: <b>DWORD</b> The number of datagrams that cannot be reassembled.
    uint dwReasmFails;
    ///Type: <b>DWORD</b> The number of datagrams that were fragmented successfully.
    uint dwFragOks;
    ///Type: <b>DWORD</b> The number of datagrams that have not been fragmented because the IP header specifies no
    ///fragmentation. These datagrams are discarded.
    uint dwFragFails;
    ///Type: <b>DWORD</b> The number of fragments created.
    uint dwFragCreates;
    ///Type: <b>DWORD</b> The number of interfaces.
    uint dwNumIf;
    ///Type: <b>DWORD</b> The number of IP addresses associated with this computer.
    uint dwNumAddr;
    ///Type: <b>DWORD</b> The number of routes in the IP routing table.
    uint dwNumRoutes;
}

///The <b>MIB_IPSTATS</b> structure stores information about the IP protocol running on a particular computer.
struct MIB_IPSTATS_W2K
{
    ///Type: <b>DWORD</b> Specifies whether IP forwarding is enabled or disabled for a protocol (IPv4 or IPv6). On
    ///Windows Vista and later, this member is defined as a union containing a <b>DWORD dwForwarding</b> member and a
    ///<b>MIB_IPSTATS_FORWARDING Forwarding</b> member where <b>MIB_IPSTATS_FORWARDING</b> is an enumeration defined in
    ///the <i>Ipmib.h</i> header file. <div class="alert"><b>Note</b> This member applies to the entire system per
    ///protocol (IPv4 or IPv6) and doesn’t return per interface configuration for IP forwarding.</div> <div> </div>
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MIB_IP_FORWARDING"></a><a
    ///id="mib_ip_forwarding"></a><dl> <dt><b>MIB_IP_FORWARDING</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> IP
    ///forwarding is enabled. </td> </tr> <tr> <td width="40%"><a id="MIB_IP_NOT_FORWARDING"></a><a
    ///id="mib_ip_not_forwarding"></a><dl> <dt><b>MIB_IP_NOT_FORWARDING</b></dt> <dt>2</dt> </dl> </td> <td width="60%">
    ///IP forwarding is not enabled. </td> </tr> <tr> <td width="40%"><a id="MIB_USE_CURRENT_FORWARDING"></a><a
    ///id="mib_use_current_forwarding"></a><dl> <dt><b>MIB_USE_CURRENT_FORWARDING</b></dt> <dt>0xffff</dt> </dl> </td>
    ///<td width="60%"> Use the current IP forwarding setting. This value is only applicable when setting the forwarding
    ///and time-to-live (TTL) options using the <b>SetIpStatistics</b> and SetIpStatisticsEx functions. </td> </tr>
    ///</table>
    uint dwForwarding;
    ///Type: <b>DWORD</b> The default initial time-to-live (TTL) for datagrams originating on a particular computer.
    ///This member can be set to <b>MIB_USE_CURRENT_TTL</b> to use the current deafult TTL value when setting the
    ///forwarding and time-to-live (TTL) options using the <b>SetIpStatistics</b> and SetIpStatisticsEx functions.
    uint dwDefaultTTL;
    ///Type: <b>DWORD</b> The number of datagrams received.
    uint dwInReceives;
    ///Type: <b>DWORD</b> The number of datagrams received that have header errors.
    uint dwInHdrErrors;
    ///Type: <b>DWORD</b> The number of datagrams received that have address errors.
    uint dwInAddrErrors;
    ///Type: <b>DWORD</b> The number of datagrams forwarded.
    uint dwForwDatagrams;
    ///Type: <b>DWORD</b> The number of datagrams received that have an unknown protocol.
    uint dwInUnknownProtos;
    ///Type: <b>DWORD</b> The number of received datagrams discarded.
    uint dwInDiscards;
    ///Type: <b>DWORD</b> The number of received datagrams delivered.
    uint dwInDelivers;
    ///Type: <b>DWORD</b> The number of outgoing datagrams that IP is requested to transmit. This number does not
    ///include forwarded datagrams.
    uint dwOutRequests;
    ///Type: <b>DWORD</b> The number of outgoing datagrams discarded.
    uint dwRoutingDiscards;
    ///Type: <b>DWORD</b> The number of transmitted datagrams discarded.
    uint dwOutDiscards;
    ///Type: <b>DWORD</b> The number of datagrams for which this computer did not have a route to the destination IP
    ///address. These datagrams were discarded.
    uint dwOutNoRoutes;
    ///Type: <b>DWORD</b> The amount of time allowed for all pieces of a fragmented datagram to arrive. If all pieces do
    ///not arrive within this time, the datagram is discarded.
    uint dwReasmTimeout;
    ///Type: <b>DWORD</b> The number of datagrams that require re-assembly.
    uint dwReasmReqds;
    ///Type: <b>DWORD</b> The number of datagrams that were successfully reassembled.
    uint dwReasmOks;
    ///Type: <b>DWORD</b> The number of datagrams that cannot be reassembled.
    uint dwReasmFails;
    ///Type: <b>DWORD</b> The number of datagrams that were fragmented successfully.
    uint dwFragOks;
    ///Type: <b>DWORD</b> The number of datagrams that have not been fragmented because the IP header specifies no
    ///fragmentation. These datagrams are discarded.
    uint dwFragFails;
    ///Type: <b>DWORD</b> The number of fragments created.
    uint dwFragCreates;
    ///Type: <b>DWORD</b> The number of interfaces.
    uint dwNumIf;
    ///Type: <b>DWORD</b> The number of IP addresses associated with this computer.
    uint dwNumAddr;
    ///Type: <b>DWORD</b> The number of routes in the IP routing table.
    uint dwNumRoutes;
}

///The <b>MIBICMPSTATS</b> structure contains statistics for either incoming or outgoing Internet Control Message
///Protocol (ICMP) messages on a particular computer.
struct MIBICMPSTATS
{
    ///Type: <b>DWORD</b> The number of messages received or sent.
    uint dwMsgs;
    ///Type: <b>DWORD</b> The number of errors received or sent.
    uint dwErrors;
    ///Type: <b>DWORD</b> The number of destination-unreachable messages received or sent. A destination-unreachable
    ///message is sent to the originating computer when a datagram fails to reach its intended destination.
    uint dwDestUnreachs;
    ///Type: <b>DWORD</b> The number of time-to-live (TTL) exceeded messages received or sent. A time-to-live exceeded
    ///message is sent to the originating computer when a datagram is discarded because the number of routers it has
    ///passed through exceeds its time-to-live value.
    uint dwTimeExcds;
    ///Type: <b>DWORD</b> The number of parameter-problem messages received or sent. A parameter-problem message is sent
    ///to the originating computer when a router or host detects an error in a datagram's IP header.
    uint dwParmProbs;
    ///Type: <b>DWORD</b> The number of source quench messages received or sent. A source quench request is sent to a
    ///computer to request that it reduce its rate of packet transmission.
    uint dwSrcQuenchs;
    ///Type: <b>DWORD</b> The number of redirect messages received or sent. A redirect message is sent to the
    ///originating computer when a better route is discovered for a datagram sent by that computer.
    uint dwRedirects;
    ///Type: <b>DWORD</b> The number of echo requests received or sent. An echo request causes the receiving computer to
    ///send an echo reply message back to the originating computer.
    uint dwEchos;
    ///Type: <b>DWORD</b> The number of echo replies received or sent. A computer sends an echo reply in response to
    ///receiving an echo request message.
    uint dwEchoReps;
    ///Type: <b>DWORD</b> The number of time-stamp requests received or sent. A time-stamp request causes the receiving
    ///computer to send a time-stamp reply back to the originating computer.
    uint dwTimestamps;
    ///Type: <b>DWORD</b> The number of time-stamp replies received or sent. A computer sends a time-stamp reply in
    ///response to receiving a time-stamp request. Routers can use time-stamp requests and replies to measure the
    ///transmission speed of datagrams on a network.
    uint dwTimestampReps;
    ///Type: <b>DWORD</b> The number of address mask requests received or sent. A computer sends an address mask request
    ///to determine the number of bits in the subnet mask for its local subnet.
    uint dwAddrMasks;
    ///Type: <b>DWORD</b> The number of address mask responses received or sent. A computer sends an address mask
    ///response in response to an address mask request.
    uint dwAddrMaskReps;
}

///The <b>MIBICMPINFO</b> structure contains Internet Control Message Protocol (ICMP) statistics for a particular
///computer.
struct MIBICMPINFO
{
    ///An MIBICMPSTATS structure that contains the statistics for incoming ICMP messages.
    MIBICMPSTATS icmpInStats;
    ///An MIBICMPSTATS structure that contains the statistics for outgoing ICMP messages.
    MIBICMPSTATS icmpOutStats;
}

///The <b>MIB_ICMP</b> structure contains the Internet Control Message Protocol (ICMP) statistics for a particular
///computer.
struct MIB_ICMP
{
    ///A MIBICMPINFO structure that contains the ICMP statistics for the computer.
    MIBICMPINFO stats;
}

///The <b>MIBICMPSTATS_EX</b> structure contains extended statistics for either incoming or outgoing Internet Control
///Message Protocol (ICMP) messages on a particular computer.
struct MIBICMPSTATS_EX_XPSP1
{
    ///Type: <b>DWORD</b> Specifies the number of messages received or sent.
    uint      dwMsgs;
    ///Type: <b>DWORD</b> The number of errors received or sent.
    uint      dwErrors;
    ///Type: <b>DWORD[256]</b> The type count.
    uint[256] rgdwTypeCount;
}

///The <b>MIB_ICMP_EX</b> structure contains the extended Internet Control Message Protocol (ICMP) statistics for a
///particular computer.
struct MIB_ICMP_EX_XPSP1
{
    ///Specifies an MIBICMPSTATS_EX structure that contains the extended statistics for incoming ICMP messages.
    MIBICMPSTATS_EX_XPSP1 icmpInStats;
    ///Specifies an MIBICMPSTATS_EX structure that contains the extended statistics for outgoing ICMP messages.
    MIBICMPSTATS_EX_XPSP1 icmpOutStats;
}

///The <b>MIB_IPMCAST_OIF</b> structure stores the information required to send an outgoing IP multicast packet.
struct MIB_IPMCAST_OIF_XP
{
    ///The index of the interface on which to send the outgoing IP multicast packet.
    uint dwOutIfIndex;
    ///The destination address for the outgoing IPv4 multicast packet.
    uint dwNextHopAddr;
    ///Reserved. This member should be zero.
    uint dwReserved;
    ///Reserved. This member should be zero.
    uint dwReserved1;
}

///The <b>MIB_IPMCAST_OIF</b> structure stores the information required to send an outgoing IP multicast packet.
struct MIB_IPMCAST_OIF_W2K
{
    ///The index of the interface on which to send the outgoing IP multicast packet.
    uint  dwOutIfIndex;
    ///The destination address for the outgoing IPv4 multicast packet.
    uint  dwNextHopAddr;
    ///Reserved. This member should be <b>NULL</b>.
    void* pvReserved;
    ///Reserved. This member should be zero.
    uint  dwReserved;
}

///The <b>MIB_IPMCAST_MFE</b> structure stores the information for an Internet Protocol (IP) Multicast Forwarding Entry
///(MFE).
struct MIB_IPMCAST_MFE
{
    ///Type: <b>DWORD</b> The range of IPv4 multicast groups for this MFE. A value of zero indicates a wildcard group.
    uint dwGroup;
    ///Type: <b>DWORD</b> The range of IPv4 source addresses for this MFE. A value of zero indicates a wildcard source.
    uint dwSource;
    ///Type: <b>DWORD</b> The IPv4 subnet mask that corresponds to <b>dwSourceAddr</b>. The <b>dwSourceAddr</b> and
    ///<b>dwSourceMask</b> members are used together to define a range of sources.
    uint dwSrcMask;
    ///Type: <b>DWORD</b> The upstream neighbor that is related to this MFE.
    uint dwUpStrmNgbr;
    ///Type: <b>DWORD</b> The index of the interface to which this MFE is related.
    uint dwInIfIndex;
    ///Type: <b>DWORD</b> The routing protocol that owns the incoming interface to which this MFE is related.
    uint dwInIfProtocol;
    ///Type: <b>DWORD</b> The client that created the route.
    uint dwRouteProtocol;
    ///Type: <b>DWORD</b> The IPv4 address associated with the route referred to by <b>dwRouteProtocol</b>.
    uint dwRouteNetwork;
    ///Type: <b>DWORD</b> The IPv4 mask associated with the route referred to by <b>dwRouteProtocol</b>.
    uint dwRouteMask;
    ///Type: <b>ULONG</b> The time, in seconds, this MFE has been valid. This value starts from zero and is incremented
    ///until it reaches the <b>ulTimeOut</b> value, at which time the MFE is deleted.
    uint ulUpTime;
    ///Type: <b>ULONG</b> The time, in seconds, that remains before the MFE expires and is deleted. This value starts
    ///from <b>ulTimeOut</b> and is decremented until it reaches zero, at which time the MFE is deleted.
    uint ulExpiryTime;
    ///Type: <b>ULONG</b> The total length of time, in seconds, that this MFE should remain valid. After the time-out
    ///value is exceeded, the MFE is deleted. This value is static.
    uint ulTimeOut;
    ///Type: <b>ULONG</b> The number of outgoing interfaces that are associated with this MFE.
    uint ulNumOutIf;
    ///Type: <b>DWORD</b> Reserved. This member should be <b>NULL</b>.
    uint fFlags;
    ///Type: <b>DWORD</b> Reserved. This member should be <b>NULL</b>.
    uint dwReserved;
    ///Type: <b>MIB_IPMCAST_OIF[ANY_SIZE]</b> A pointer to a table of outgoing interface statistics that are implemented
    ///as an array of MIB_IPMCAST_OIF structures.
    MIB_IPMCAST_OIF_XP[1] rgmioOutInfo;
}

///The <b>MIB_MFE_TABLE</b> structure contains a table of Multicast Forwarding Entries (MFEs).
struct MIB_MFE_TABLE
{
    ///The number of MFEs in the table.
    uint               dwNumEntries;
    ///A pointer to a table of MFEs implemented as an array of MIB_IPMCAST_MFE structures.
    MIB_IPMCAST_MFE[1] table;
}

///The <b>MIB_IPMCAST_OIF_STATS</b> structure stores the statistics that are associated with an outgoing multicast
///interface.
struct MIB_IPMCAST_OIF_STATS_LH
{
    ///Type: <b>DWORD</b> Specifies the outgoing interface to which these statistics are related.
    uint dwOutIfIndex;
    ///Type: <b>DWORD</b> Specifies the address of the next hop that corresponds to <b>dwOutIfIndex</b>. The
    ///<b>dwOutIfIndex</b> and <b>dwIfNextHopIPAddr</b> members uniquely identify a next hop on point-to-multipoint
    ///interfaces, where one interface connects to multiple networks. Examples of point-to-multipoint interfaces include
    ///non-broadcast multiple-access (NBMA) interfaces, and the internal interface on which all dial-up clients connect.
    ///For Ethernet and other broadcast interfaces, specify zero. Also specify zero for point-to-point interfaces, which
    ///are identified by only <b>dwOutIfIndex</b>.
    uint dwNextHopAddr;
    ///TBD
    uint dwDialContext;
    ///Type: <b>ULONG</b> Specifies the number of packets on this outgoing interface that were discarded because the
    ///packet's time-to-live (TTL) value was too low.
    uint ulTtlTooLow;
    ///Type: <b>ULONG</b> Specifies the number of packets that required fragmentation when they were forwarded on this
    ///interface.
    uint ulFragNeeded;
    ///Type: <b>ULONG</b> Specifies the number of packets that were forwarded out this interface.
    uint ulOutPackets;
    ///Type: <b>ULONG</b> Specifies the number of packets that were discarded on this interface.
    uint ulOutDiscards;
}

///The <b>MIB_IPMCAST_OIF_STATS</b> structure stores the statistics that are associated with an outgoing multicast
///interface.
struct MIB_IPMCAST_OIF_STATS_W2K
{
    ///Type: <b>DWORD</b> Specifies the outgoing interface to which these statistics are related.
    uint  dwOutIfIndex;
    ///Type: <b>DWORD</b> Specifies the address of the next hop that corresponds to <b>dwOutIfIndex</b>. The
    ///<b>dwOutIfIndex</b> and <b>dwIfNextHopIPAddr</b> members uniquely identify a next hop on point-to-multipoint
    ///interfaces, where one interface connects to multiple networks. Examples of point-to-multipoint interfaces include
    ///non-broadcast multiple-access (NBMA) interfaces, and the internal interface on which all dial-up clients connect.
    ///For Ethernet and other broadcast interfaces, specify zero. Also specify zero for point-to-point interfaces, which
    ///are identified by only <b>dwOutIfIndex</b>.
    uint  dwNextHopAddr;
    ///Type: <b>PVOID</b> Reserved. This member should be <b>NULL</b>.
    void* pvDialContext;
    ///Type: <b>ULONG</b> Specifies the number of packets on this outgoing interface that were discarded because the
    ///packet's time-to-live (TTL) value was too low.
    uint  ulTtlTooLow;
    ///Type: <b>ULONG</b> Specifies the number of packets that required fragmentation when they were forwarded on this
    ///interface.
    uint  ulFragNeeded;
    ///Type: <b>ULONG</b> Specifies the number of packets that were forwarded out this interface.
    uint  ulOutPackets;
    ///Type: <b>ULONG</b> Specifies the number of packets that were discarded on this interface.
    uint  ulOutDiscards;
}

///The <b>MIB_IPMCAST_MFE_STATS</b> structure stores the statistics associated with a Multicast Forwarding Entry (MFE).
struct MIB_IPMCAST_MFE_STATS
{
    ///Type: <b>DWORD</b> The multicast group for this MFE. A value of zero indicates a wildcard group.
    uint dwGroup;
    ///Type: <b>DWORD</b> The range of source addresses for this MFE. A value of zero indicates a wildcard source.
    uint dwSource;
    ///Type: <b>DWORD</b> The IPv4 subnet mask that corresponds to <b>dwSourceAddr</b>. The <b>dwSourceAddr</b> and
    ///<b>dwSourceMask</b> members are used together to define a range of sources.
    uint dwSrcMask;
    ///Type: <b>DWORD</b> The upstream neighbor that is related to this MFE.
    uint dwUpStrmNgbr;
    ///Type: <b>DWORD</b> The index of the incoming interface to which this MFE is related.
    uint dwInIfIndex;
    ///Type: <b>DWORD</b> The routing protocol that owns the incoming interface to which this MFE is related.
    uint dwInIfProtocol;
    ///Type: <b>DWORD</b> The client that created the route.
    uint dwRouteProtocol;
    ///Type: <b>DWORD</b> The address associated with the route referred to by <b>dwRouteProtocol</b>.
    uint dwRouteNetwork;
    ///Type: <b>DWORD</b> The mask associated with the route referred to by <b>dwRouteProtocol</b>.
    uint dwRouteMask;
    ///Type: <b>ULONG</b> The time, in 100ths of a seconds, since the MFE was created.
    uint ulUpTime;
    ///Type: <b>ULONG</b> The time, in 100ths of a seconds, until the MFE will be deleted. A value of zero is specified
    ///if the MFE is not subject to aging requirements.
    uint ulExpiryTime;
    ///Type: <b>ULONG</b> The number of interfaces in the outgoing interface list for this MFE.
    uint ulNumOutIf;
    ///Type: <b>ULONG</b> The number of packets that have been forwarded that matched this MFE.
    uint ulInPkts;
    ///Type: <b>ULONG</b> The number of octets of data forwarded that match this MFE.
    uint ulInOctets;
    ///Type: <b>ULONG</b> The number of packets matching this MFE that were dropped due to an incoming interface check.
    uint ulPktsDifferentIf;
    ///Type: <b>ULONG</b> The number of packets matching this MFE that were dropped due to a queue overflow. There is
    ///one queue per MFE.
    uint ulQueueOverflow;
    ///Type: <b>MIB_IPMCAST_OIF_STATS[ANY_SIZE]</b> A pointer to a table of outgoing interface statistics that are
    ///implemented as an array of MIB_IPMCAST_OIF_STATS structures. The number of entries in the table is specified by
    ///the value of the <b>ulNumOutIf</b> member.
    MIB_IPMCAST_OIF_STATS_LH[1] rgmiosOutStats;
}

///The <b>MIB_MFE_STATS_TABLE</b> structure stores statistics for a group of Multicast Forwarding Entries (MFEs).
struct MIB_MFE_STATS_TABLE
{
    ///The number of MFEs in the array.
    uint dwNumEntries;
    ///A pointer to a table of MFEs that are implemented as an array of MIB_IPMCAST_MFE_STATS structures.
    MIB_IPMCAST_MFE_STATS[1] table;
}

///The <b>MIB_IPMCAST_MFE_STATS_EX</b> structure stores the extended statistics associated with a Multicast Forwarding
///Entry (MFE).
struct MIB_IPMCAST_MFE_STATS_EX_XP
{
    ///Type: <b>DWORD</b> The multicast group for this MFE. A value of zero indicates a wildcard group.
    uint dwGroup;
    ///Type: <b>DWORD</b> The range of source addresses for this MFE. A value of zero indicates a wildcard source.
    uint dwSource;
    ///Type: <b>DWORD</b> The IPv4 subnet mask that corresponds to <b>dwSourceAddr</b>. The <b>dwSourceAddr</b> and
    ///<b>dwSourceMask</b> members are used together to define a range of sources.
    uint dwSrcMask;
    ///Type: <b>DWORD</b> The upstream neighbor that is related to this MFE.
    uint dwUpStrmNgbr;
    ///Type: <b>DWORD</b> The index of the incoming interface to which this MFE is related.
    uint dwInIfIndex;
    ///Type: <b>DWORD</b> The routing protocol that owns the incoming interface to which this MFE is related.
    uint dwInIfProtocol;
    ///Type: <b>DWORD</b> The client that created the route.
    uint dwRouteProtocol;
    ///Type: <b>DWORD</b> The address associated with the route referred to by <b>dwRouteProtocol</b>.
    uint dwRouteNetwork;
    ///Type: <b>DWORD</b> The mask associated with the route referred to by <b>dwRouteProtocol</b>.
    uint dwRouteMask;
    ///Type: <b>ULONG</b> The time, in 100ths of a seconds, since the MFE was created.
    uint ulUpTime;
    ///Type: <b>ULONG</b> The time, in 100ths of a seconds, until the MFE will be deleted. Zero is specified if the MFE
    ///is not subject to aging requirements.
    uint ulExpiryTime;
    ///Type: <b>ULONG</b> The number of interfaces in the outgoing interface list for this MFE.
    uint ulNumOutIf;
    ///Type: <b>ULONG</b> The number of packets that have been forwarded that matched this MFE.
    uint ulInPkts;
    ///Type: <b>ULONG</b> The number of octets of data forwarded that match this MFE.
    uint ulInOctets;
    ///Type: <b>ULONG</b> The number of packets matching this MFE that were dropped due to an incoming interface check.
    uint ulPktsDifferentIf;
    ///Type: <b>ULONG</b> The number of packets matching this MFE that were dropped due to a queue overflow. There is
    ///one queue per MFE.
    uint ulQueueOverflow;
    ///Type: <b>ULONG</b> The number of uninitialized packets that matched this MFE.
    uint ulUninitMfe;
    ///Type: <b>ULONG</b> The number of packets matching this MFE discarded due to a negative error value.
    uint ulNegativeMfe;
    ///Type: <b>ULONG</b> The number of discarded forwarded packets that matched this MFE.
    uint ulInDiscards;
    ///Type: <b>ULONG</b> The number of packets matching this MFE discarded due to bad or malformed header values (such
    ///as a bad Time-to-Live value).
    uint ulInHdrErrors;
    ///Type: <b>ULONG</b> The total number of MFE packets transmitted across all associated interfaces. Note that one
    ///packet sent over N interfaces will count as N packets within this value.
    uint ulTotalOutPackets;
    MIB_IPMCAST_OIF_STATS_LH[1] rgmiosOutStats;
}

///The <b>MIB_MFE_STATS_TABLE_EX</b> structure contains a table of extended statistics for Multicast Forwarding Entries
///(MFEs).
struct MIB_MFE_STATS_TABLE_EX_XP
{
    ///The number of MFEs in the array.
    uint dwNumEntries;
    ///A pointer to a table of MFEs that are implemented as an array of MIB_IPMCAST_MFE_STATS_EX structures.
    MIB_IPMCAST_MFE_STATS_EX_XP[1]* table;
}

///The <b>MIB_IPMCAST_GLOBAL</b> structure stores global information for IP multicast on a particular computer.
struct MIB_IPMCAST_GLOBAL
{
    ///Specifies whether IP multicast is enabled on the computer.
    uint dwEnable;
}

///The <b>MIB_IPMCAST_IF_ENTRY</b> structure stores information about an IP multicast interface.
struct MIB_IPMCAST_IF_ENTRY
{
    ///The index of this interface.
    uint dwIfIndex;
    ///The time-to-live value for this interface.
    uint dwTtl;
    ///The multicast routing protocol that owns this interface.
    uint dwProtocol;
    ///The rate limit of this interface.
    uint dwRateLimit;
    ///The number of octets of multicast data received through this interface.
    uint ulInMcastOctets;
    ///The number of octets of multicast data sent through this interface.
    uint ulOutMcastOctets;
}

///The <b>MIB_IPMCAST_IF_TABLE</b> structure contains a table of IP multicast interface entries.
struct MIB_IPMCAST_IF_TABLE
{
    ///Specifies the number of interface entries in the table.
    uint dwNumEntries;
    ///A pointer to a table of interface entries implemented as an array of <b>MIB_IPMCAST_IF_TABLE</b> structures.
    MIB_IPMCAST_IF_ENTRY[1] table;
}

///The <b>MIB_TCPROW</b> structure contains information that descibes an IPv4 TCP connection.
struct MIB_TCPROW_LH
{
    union
    {
        uint          dwState;
        MIB_TCP_STATE State;
    }
    ///Type: <b>DWORD</b> The local IPv4 address for the TCP connection on the local computer. A value of zero indicates
    ///the listener can accept a connection on any interface.
    uint dwLocalAddr;
    ///Type: <b>DWORD</b> The local port number in network byte order for the TCP connection on the local computer. The
    ///maximum size of an IP port number is 16 bits, so only the lower 16 bits should be used. The upper 16 bits may
    ///contain uninitialized data.
    uint dwLocalPort;
    ///Type: <b>DWORD</b> The IPv4 address for the TCP connection on the remote computer. When the <b>dwState</b> member
    ///is <b>MIB_TCP_STATE_LISTEN</b>, this value has no meaning.
    uint dwRemoteAddr;
    ///Type: <b>DWORD</b> The remote port number in network byte order for the TCP connection on the remote computer.
    ///When the <b>dwState</b> member is <b>MIB_TCP_STATE_LISTEN</b>, this member has no meaning. The maximum size of an
    ///IP port number is 16 bits, so only the lower 16 bits should be used. The upper 16 bits may contain uninitialized
    ///data.
    uint dwRemotePort;
}

///The <b>MIB_TCPROW</b> structure contains information that descibes an IPv4 TCP connection.
struct MIB_TCPROW_W2K
{
    ///Type: <b>DWORD</b> The state of the TCP connection. This member can be one of the values defined in the
    ///<i>Iprtrmib.h</i> header file. On the Windows SDK released for Windows Vistaand later, the organization of header
    ///files has changed. This member can be one of the values from the <b>MIB_TCP_STATE</b> enumeration defined in the
    ///<i>Tcpmib.h</i> header file, not in the <i>Iprtrmib.h</i> header file. Note that the <i>Tcpmib.h</i> header file
    ///is automatically included in <i>Iprtrmib.h</i>, which is automatically included in the <i>Iphlpapi.h</i> header
    ///file. The <i>Tcpmib.h</i> and <i>Iprtrmib.h</i> header files should never be used directly. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_CLOSED"></a><a
    ///id="mib_tcp_state_closed"></a><dl> <dt><b>MIB_TCP_STATE_CLOSED</b></dt> <dt>1</dt> </dl> </td> <td width="60%">
    ///The TCP connection is in the CLOSED state that represents no connection state at all. </td> </tr> <tr> <td
    ///width="40%"><a id="MIB_TCP_STATE_LISTEN"></a><a id="mib_tcp_state_listen"></a><dl>
    ///<dt><b>MIB_TCP_STATE_LISTEN</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The TCP connection is in the LISTEN
    ///state waiting for a connection request from any remote TCP and port. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_SYN_SENT"></a><a id="mib_tcp_state_syn_sent"></a><dl> <dt><b>MIB_TCP_STATE_SYN_SENT</b></dt>
    ///<dt>3</dt> </dl> </td> <td width="60%"> The TCP connection is in the SYN-SENT state waiting for a matching
    ///connection request after having sent a connection request (SYN packet). </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_SYN_RCVD"></a><a id="mib_tcp_state_syn_rcvd"></a><dl> <dt><b>MIB_TCP_STATE_SYN_RCVD</b></dt>
    ///<dt>4</dt> </dl> </td> <td width="60%"> The TCP connection is in the SYN-RECEIVED state waiting for a confirming
    ///connection request acknowledgment after having both received and sent a connection request (SYN packet). </td>
    ///</tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_ESTAB"></a><a id="mib_tcp_state_estab"></a><dl>
    ///<dt><b>MIB_TCP_STATE_ESTAB</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> The TCP connection is in the
    ///ESTABLISHED state that represents an open connection, data received can be delivered to the user. This is the
    ///normal state for the data transfer phase of the TCP connection. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_FIN_WAIT1"></a><a id="mib_tcp_state_fin_wait1"></a><dl> <dt><b>MIB_TCP_STATE_FIN_WAIT1</b></dt>
    ///<dt>6</dt> </dl> </td> <td width="60%"> The TCP connection is FIN-WAIT-1 state waiting for a connection
    ///termination request from the remote TCP, or an acknowledgment of the connection termination request previously
    ///sent. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_FIN_WAIT2"></a><a
    ///id="mib_tcp_state_fin_wait2"></a><dl> <dt><b>MIB_TCP_STATE_FIN_WAIT2</b></dt> <dt>7</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is FIN-WAIT-1 state waiting for a connection termination request from the remote
    ///TCP. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_CLOSE_WAIT"></a><a
    ///id="mib_tcp_state_close_wait"></a><dl> <dt><b>MIB_TCP_STATE_CLOSE_WAIT</b></dt> <dt>8</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is in the CLOSE-WAIT state waiting for a connection termination request from the
    ///local user. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_CLOSING"></a><a
    ///id="mib_tcp_state_closing"></a><dl> <dt><b>MIB_TCP_STATE_CLOSING</b></dt> <dt>9</dt> </dl> </td> <td width="60%">
    ///The TCP connection is in the CLOSING state waiting for a connection termination request acknowledgment from the
    ///remote TCP. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_LAST_ACK"></a><a
    ///id="mib_tcp_state_last_ack"></a><dl> <dt><b>MIB_TCP_STATE_LAST_ACK</b></dt> <dt>10</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is in the LAST-ACK state waiting for an acknowledgment of the connection
    ///termination request previously sent to the remote TCP (which includes an acknowledgment of its connection
    ///termination request). </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_TIME_WAIT"></a><a
    ///id="mib_tcp_state_time_wait"></a><dl> <dt><b>MIB_TCP_STATE_TIME_WAIT</b></dt> <dt>11</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is in the TIME-WAIT state waiting for enough time to pass to be sure the remote
    ///TCP received the acknowledgment of its connection termination request. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_DELETE_TCB"></a><a id="mib_tcp_state_delete_tcb"></a><dl>
    ///<dt><b>MIB_TCP_STATE_DELETE_TCB</b></dt> <dt>12</dt> </dl> </td> <td width="60%"> The TCP connection is in the
    ///delete TCB state that represents the deletion of the Transmission Control Block (TCB), a data structure used to
    ///maintain information on each TCP entry. </td> </tr> </table>
    uint dwState;
    ///Type: <b>DWORD</b> The local IPv4 address for the TCP connection on the local computer. A value of zero indicates
    ///the listener can accept a connection on any interface.
    uint dwLocalAddr;
    ///Type: <b>DWORD</b> The local port number in network byte order for the TCP connection on the local computer. The
    ///maximum size of an IP port number is 16 bits, so only the lower 16 bits should be used. The upper 16 bits may
    ///contain uninitialized data.
    uint dwLocalPort;
    ///Type: <b>DWORD</b> The IPv4 address for the TCP connection on the remote computer. When the <b>dwState</b> member
    ///is <b>MIB_TCP_STATE_LISTEN</b>, this value has no meaning.
    uint dwRemoteAddr;
    ///Type: <b>DWORD</b> The remote port number in network byte order for the TCP connection on the remote computer.
    ///When the <b>dwState</b> member is <b>MIB_TCP_STATE_LISTEN</b>, this member has no meaning. The maximum size of an
    ///IP port number is 16 bits, so only the lower 16 bits should be used. The upper 16 bits may contain uninitialized
    ///data.
    uint dwRemotePort;
}

///The <b>MIB_TCPTABLE</b> structure contains a table of TCP connections for IPv4 on the local computer.
struct MIB_TCPTABLE
{
    ///The number of entries in the table.
    uint             dwNumEntries;
    ///A pointer to a table of TCP connections implemented as an array of MIB_TCPROW structures.
    MIB_TCPROW_LH[1] table;
}

///The <b>MIB_TCPROW2</b> structure contains information that describes an IPv4 TCP connection.
struct MIB_TCPROW2
{
    ///Type: <b>DWORD</b> The state of the TCP connection. This member can be one of the values defined in the
    ///<i>Iprtrmib.h</i> header file. On the Windows SDK released for Windows Vistaand later, the organization of header
    ///files has changed. This member can be one of the values from the <b>MIB_TCP_STATE</b> enumeration defined in the
    ///<i>Tcpmib.h</i> header file, not in the <i>Iprtrmib.h</i> header file. Note that the <i>Tcpmib.h</i> header file
    ///is automatically included in <i>Iprtrmib.h</i>, which is automatically included in the <i>Iphlpapi.h</i> header
    ///file. The <i>Tcpmib.h</i> and <i>Iprtrmib.h</i> header files should never be used directly. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_CLOSED"></a><a
    ///id="mib_tcp_state_closed"></a><dl> <dt><b>MIB_TCP_STATE_CLOSED</b></dt> <dt>1</dt> </dl> </td> <td width="60%">
    ///The TCP connection is in the CLOSED state that represents no connection state at all. </td> </tr> <tr> <td
    ///width="40%"><a id="MIB_TCP_STATE_LISTEN"></a><a id="mib_tcp_state_listen"></a><dl>
    ///<dt><b>MIB_TCP_STATE_LISTEN</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The TCP connection is in the LISTEN
    ///state waiting for a connection request from any remote TCP and port. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_SYN_SENT"></a><a id="mib_tcp_state_syn_sent"></a><dl> <dt><b>MIB_TCP_STATE_SYN_SENT</b></dt>
    ///<dt>3</dt> </dl> </td> <td width="60%"> The TCP connection is in the SYN-SENT state waiting for a matching
    ///connection request after having sent a connection request (SYN packet). </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_SYN_RCVD"></a><a id="mib_tcp_state_syn_rcvd"></a><dl> <dt><b>MIB_TCP_STATE_SYN_RCVD</b></dt>
    ///<dt>4</dt> </dl> </td> <td width="60%"> The TCP connection is in the SYN-RECEIVED state waiting for a confirming
    ///connection request acknowledgment after having both received and sent a connection request (SYN packet). </td>
    ///</tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_ESTAB"></a><a id="mib_tcp_state_estab"></a><dl>
    ///<dt><b>MIB_TCP_STATE_ESTAB</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> The TCP connection is in the
    ///ESTABLISHED state that represents an open connection, data received can be delivered to the user. This is the
    ///normal state for the data transfer phase of the TCP connection. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_FIN_WAIT1"></a><a id="mib_tcp_state_fin_wait1"></a><dl> <dt><b>MIB_TCP_STATE_FIN_WAIT1</b></dt>
    ///<dt>6</dt> </dl> </td> <td width="60%"> The TCP connection is FIN-WAIT-1 state waiting for a connection
    ///termination request from the remote TCP, or an acknowledgment of the connection termination request previously
    ///sent. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_FIN_WAIT2"></a><a
    ///id="mib_tcp_state_fin_wait2"></a><dl> <dt><b>MIB_TCP_STATE_FIN_WAIT2</b></dt> <dt>7</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is FIN-WAIT-1 state waiting for a connection termination request from the remote
    ///TCP. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_CLOSE_WAIT"></a><a
    ///id="mib_tcp_state_close_wait"></a><dl> <dt><b>MIB_TCP_STATE_CLOSE_WAIT</b></dt> <dt>8</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is in the CLOSE-WAIT state waiting for a connection termination request from the
    ///local user. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_CLOSING"></a><a
    ///id="mib_tcp_state_closing"></a><dl> <dt><b>MIB_TCP_STATE_CLOSING</b></dt> <dt>9</dt> </dl> </td> <td width="60%">
    ///The TCP connection is in the CLOSING state waiting for a connection termination request acknowledgment from the
    ///remote TCP. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_LAST_ACK"></a><a
    ///id="mib_tcp_state_last_ack"></a><dl> <dt><b>MIB_TCP_STATE_LAST_ACK</b></dt> <dt>10</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is in the LAST-ACK state waiting for an acknowledgment of the connection
    ///termination request previously sent to the remote TCP (which includes an acknowledgment of its connection
    ///termination request). </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_TIME_WAIT"></a><a
    ///id="mib_tcp_state_time_wait"></a><dl> <dt><b>MIB_TCP_STATE_TIME_WAIT</b></dt> <dt>11</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is in the TIME-WAIT state waiting for enough time to pass to be sure the remote
    ///TCP received the acknowledgment of its connection termination request. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_DELETE_TCB"></a><a id="mib_tcp_state_delete_tcb"></a><dl>
    ///<dt><b>MIB_TCP_STATE_DELETE_TCB</b></dt> <dt>12</dt> </dl> </td> <td width="60%"> The TCP connection is in the
    ///delete TCB state that represents the deletion of the Transmission Control Block (TCB), a data structure used to
    ///maintain information on each TCP entry. </td> </tr> </table>
    uint dwState;
    ///Type: <b>DWORD</b> The local IPv4 address for the TCP connection on the local computer. A value of zero indicates
    ///the listener can accept a connection on any interface.
    uint dwLocalAddr;
    ///Type: <b>DWORD</b> The local port number in network byte order for the TCP connection on the local computer. The
    ///maximum size of an IP port number is 16 bits, so only the lower 16 bits should be used. The upper 16 bits may
    ///contain uninitialized data.
    uint dwLocalPort;
    ///Type: <b>DWORD</b> The IPv4 address for the TCP connection on the remote computer. When the <b>dwState</b> member
    ///is <b>MIB_TCP_STATE_LISTEN</b>, this value has no meaning.
    uint dwRemoteAddr;
    ///Type: <b>DWORD</b> The remote port number in network byte order for the TCP connection on the remote computer.
    ///When the <b>dwState</b> member is <b>MIB_TCP_STATE_LISTEN</b>, this member has no meaning. The maximum size of an
    ///IP port number is 16 bits, so only the lower 16 bits should be used. The upper 16 bits may contain uninitialized
    ///data.
    uint dwRemotePort;
    ///Type: <b>DWORD</b> The PID of the process that issued a context bind for this TCP connection.
    uint dwOwningPid;
    ///Type: <b>TCP_CONNECTION_OFFLOAD_STATE</b> The offload state for this TCP connection. This parameter can be one of
    ///the enumeration values for the TCP_CONNECTION_OFFLOAD_STATE defined in the <i>Tcpmib.h</i> header.
    TCP_CONNECTION_OFFLOAD_STATE dwOffloadState;
}

///The <b>MIB_TCPTABLE2</b> structure contains a table of IPv4 TCP connections on the local computer.
struct MIB_TCPTABLE2
{
    ///The number of entries in the table.
    uint           dwNumEntries;
    ///A pointer to a table of TCP connections implemented as an array of MIB_TCPROW2 structures.
    MIB_TCPROW2[1] table;
}

///The <b>MIB_TCPROW_OWNER_PID</b> structure contains information that describes an IPv4 TCP connection with IPv4
///addresses, ports used by the TCP connection, and the specific process ID (PID) associated with connection.
struct MIB_TCPROW_OWNER_PID
{
    ///Type: <b>DWORD</b> The state of the TCP connection. This member can be one of the values defined in the
    ///<i>Iprtrmib.h</i> header file. On the Windows SDK released for Windows Vistaand later, the organization of header
    ///files has changed. This member can be one of the values from the <b>MIB_TCP_STATE</b> enumeration defined in the
    ///<i>Tcpmib.h</i> header file, not in the <i>Iprtrmib.h</i> header file. Note that the <i>Tcpmib.h</i> header file
    ///is automatically included in <i>Iprtrmib.h</i>, which is automatically included in the <i>Iphlpapi.h</i> header
    ///file. The <i>Tcpmib.h</i> and <i>Iprtrmib.h</i> header files should never be used directly. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_CLOSED"></a><a
    ///id="mib_tcp_state_closed"></a><dl> <dt><b>MIB_TCP_STATE_CLOSED</b></dt> <dt>1</dt> </dl> </td> <td width="60%">
    ///The TCP connection is in the CLOSED state that represents no connection state at all. </td> </tr> <tr> <td
    ///width="40%"><a id="MIB_TCP_STATE_LISTEN"></a><a id="mib_tcp_state_listen"></a><dl>
    ///<dt><b>MIB_TCP_STATE_LISTEN</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The TCP connection is in the LISTEN
    ///state waiting for a connection request from any remote TCP and port. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_SYN_SENT"></a><a id="mib_tcp_state_syn_sent"></a><dl> <dt><b>MIB_TCP_STATE_SYN_SENT</b></dt>
    ///<dt>3</dt> </dl> </td> <td width="60%"> The TCP connection is in the SYN-SENT state waiting for a matching
    ///connection request after having sent a connection request (SYN packet). </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_SYN_RCVD"></a><a id="mib_tcp_state_syn_rcvd"></a><dl> <dt><b>MIB_TCP_STATE_SYN_RCVD</b></dt>
    ///<dt>4</dt> </dl> </td> <td width="60%"> The TCP connection is in the SYN-RECEIVED state waiting for a confirming
    ///connection request acknowledgment after having both received and sent a connection request (SYN packet). </td>
    ///</tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_ESTAB"></a><a id="mib_tcp_state_estab"></a><dl>
    ///<dt><b>MIB_TCP_STATE_ESTAB</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> The TCP connection is in the
    ///ESTABLISHED state that represents an open connection, data received can be delivered to the user. This is the
    ///normal state for the data transfer phase of the TCP connection. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_FIN_WAIT1"></a><a id="mib_tcp_state_fin_wait1"></a><dl> <dt><b>MIB_TCP_STATE_FIN_WAIT1</b></dt>
    ///<dt>6</dt> </dl> </td> <td width="60%"> The TCP connection is FIN-WAIT-1 state waiting for a connection
    ///termination request from the remote TCP, or an acknowledgment of the connection termination request previously
    ///sent. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_FIN_WAIT2"></a><a
    ///id="mib_tcp_state_fin_wait2"></a><dl> <dt><b>MIB_TCP_STATE_FIN_WAIT2</b></dt> <dt>7</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is FIN-WAIT-2 state waiting for a connection termination request from the remote
    ///TCP. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_CLOSE_WAIT"></a><a
    ///id="mib_tcp_state_close_wait"></a><dl> <dt><b>MIB_TCP_STATE_CLOSE_WAIT</b></dt> <dt>8</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is in the CLOSE-WAIT state waiting for a connection termination request from the
    ///local user. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_CLOSING"></a><a
    ///id="mib_tcp_state_closing"></a><dl> <dt><b>MIB_TCP_STATE_CLOSING</b></dt> <dt>9</dt> </dl> </td> <td width="60%">
    ///The TCP connection is in the CLOSING state waiting for a connection termination request acknowledgment from the
    ///remote TCP. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_LAST_ACK"></a><a
    ///id="mib_tcp_state_last_ack"></a><dl> <dt><b>MIB_TCP_STATE_LAST_ACK</b></dt> <dt>10</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is in the LAST-ACK state waiting for an acknowledgment of the connection
    ///termination request previously sent to the remote TCP (which includes an acknowledgment of its connection
    ///termination request). </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_TIME_WAIT"></a><a
    ///id="mib_tcp_state_time_wait"></a><dl> <dt><b>MIB_TCP_STATE_TIME_WAIT</b></dt> <dt>11</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is in the TIME-WAIT state waiting for enough time to pass to be sure the remote
    ///TCP received the acknowledgment of its connection termination request. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_DELETE_TCB"></a><a id="mib_tcp_state_delete_tcb"></a><dl>
    ///<dt><b>MIB_TCP_STATE_DELETE_TCB</b></dt> <dt>12</dt> </dl> </td> <td width="60%"> The TCP connection is in the
    ///delete TCB state that represents the deletion of the Transmission Control Block (TCB), a data structure used to
    ///maintain information on each TCP entry. </td> </tr> </table>
    uint dwState;
    ///Type: <b>DWORD</b> The local IPv4 address for the TCP connection on the local computer. A value of zero indicates
    ///the listener can accept a connection on any interface.
    uint dwLocalAddr;
    ///Type: <b>DWORD</b> The local port number in network byte order for the TCP connection on the local computer.
    uint dwLocalPort;
    ///Type: <b>DWORD</b> The IPv4 address for the TCP connection on the remote computer. When the <b>dwState</b> member
    ///is <b>MIB_TCP_STATE_LISTEN</b>, this value has no meaning.
    uint dwRemoteAddr;
    ///Type: <b>DWORD</b> The remote port number in network byte order for the TCP connection on the remote computer.
    ///When the <b>dwState</b> member is <b>MIB_TCP_STATE_LISTEN</b>, this member has no meaning.
    uint dwRemotePort;
    ///Type: <b>DWORD</b> The PID of the process that issued a context bind for this TCP connection.
    uint dwOwningPid;
}

///The <b>MIB_TCPTABLE_OWNER_PID</b> structure contains a table of process IDs (PIDs) and the IPv4 TCP links that are
///context bound to these PIDs.
struct MIB_TCPTABLE_OWNER_PID
{
    ///The number of MIB_TCPROW_OWNER_PID elements in the <b>table</b>.
    uint dwNumEntries;
    ///Array of MIB_TCPROW_OWNER_PID structures returned by a call to GetExtendedTcpTable.
    MIB_TCPROW_OWNER_PID[1] table;
}

///The <b>MIB_TCPROW_OWNER_MODULE</b> structure contains information that describes an IPv4 TCP connection with
///ownership data, IPv4 addresses, ports used by the TCP connection, and the specific process ID (PID) associated with
///connection.
struct MIB_TCPROW_OWNER_MODULE
{
    ///Type: <b>DWORD</b>
    uint          dwState;
    ///Type: <b>DWORD</b> The local IPv4 address for the TCP connection on the local computer. A value of zero indicates
    ///the listener can accept a connection on any interface.
    uint          dwLocalAddr;
    ///Type: <b>DWORD</b> The local port number in network byte order for the TCP connection on the local computer.
    uint          dwLocalPort;
    ///Type: <b>DWORD</b> The IPv4 address for the TCP connection on the remote computer. When the <b>dwState</b> member
    ///is <b>MIB_TCP_STATE_LISTEN</b>, this value has no meaning.
    uint          dwRemoteAddr;
    ///Type: <b>DWORD</b> The remote port number in network byte order for the TCP connection on the remote computer.
    ///When the <b>dwState</b> member is <b>MIB_TCP_STATE_LISTEN</b>, this member has no meaning.
    uint          dwRemotePort;
    ///Type: <b>DWORD</b> The PID of the process that issued a context bind for this TCP connection.
    uint          dwOwningPid;
    ///Type: <b>LARGE_INTEGER</b> A FILETIME structure that indicates when the context bind operation that created this
    ///TCP link occurred.
    LARGE_INTEGER liCreateTimestamp;
    ///Type: <b>ULONGLONG[TCPIP_OWNING_MODULE_SIZE]</b> An array of opaque data that contains ownership information.
    ulong[16]     OwningModuleInfo;
}

///The <b>MIB_TCPTABLE_OWNER_MODULE</b> structure contains a table of process IDs (PIDs) and the IPv4 TCP links context
///bound to the PIDs, and any available ownership data.
struct MIB_TCPTABLE_OWNER_MODULE
{
    ///The number of MIB_TCPROW_OWNER_MODULE elements in the <b>table</b>.
    uint dwNumEntries;
    ///Array of MIB_TCPROW_OWNER_MODULE structures returned by a call to GetExtendedTcpTable.
    MIB_TCPROW_OWNER_MODULE[1] table;
}

///The <b>MIB_TCP6ROW</b> structure contains information that describes an IPv6 TCP connection.
struct MIB_TCP6ROW
{
    ///Type: <b>MIB_TCP_STATE</b> The state of the TCP connection. This member can be one of the values from the
    ///<b>MIB_TCP_STATE</b> enumeration type defined in the <i>Tcpmib.h</i> header file. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_CLOSED"></a><a
    ///id="mib_tcp_state_closed"></a><dl> <dt><b>MIB_TCP_STATE_CLOSED</b></dt> <dt>1</dt> </dl> </td> <td width="60%">
    ///The TCP connection is in the CLOSED state that represents no connection state at all. </td> </tr> <tr> <td
    ///width="40%"><a id="MIB_TCP_STATE_LISTEN"></a><a id="mib_tcp_state_listen"></a><dl>
    ///<dt><b>MIB_TCP_STATE_LISTEN</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The TCP connection is in the LISTEN
    ///state waiting for a connection request from any remote TCP and port. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_SYN_SENT"></a><a id="mib_tcp_state_syn_sent"></a><dl> <dt><b>MIB_TCP_STATE_SYN_SENT</b></dt>
    ///<dt>3</dt> </dl> </td> <td width="60%"> The TCP connection is in the SYN-SENT state waiting for a matching
    ///connection request after having sent a connection request (SYN packet). </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_SYN_RCVD"></a><a id="mib_tcp_state_syn_rcvd"></a><dl> <dt><b>MIB_TCP_STATE_SYN_RCVD</b></dt>
    ///<dt>4</dt> </dl> </td> <td width="60%"> The TCP connection is in the SYN-RECEIVED state waiting for a confirming
    ///connection request acknowledgment after having both received and sent a connection request (SYN packet). </td>
    ///</tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_ESTAB"></a><a id="mib_tcp_state_estab"></a><dl>
    ///<dt><b>MIB_TCP_STATE_ESTAB</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> The TCP connection is in the
    ///ESTABLISHED state that represents an open connection, data received can be delivered to the user. This is the
    ///normal state for the data transfer phase of the TCP connection. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_FIN_WAIT1"></a><a id="mib_tcp_state_fin_wait1"></a><dl> <dt><b>MIB_TCP_STATE_FIN_WAIT1</b></dt>
    ///<dt>6</dt> </dl> </td> <td width="60%"> The TCP connection is FIN-WAIT-1 state waiting for a connection
    ///termination request from the remote TCP, or an acknowledgment of the connection termination request previously
    ///sent. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_FIN_WAIT2"></a><a
    ///id="mib_tcp_state_fin_wait2"></a><dl> <dt><b>MIB_TCP_STATE_FIN_WAIT2</b></dt> <dt>7</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is FIN-WAIT-1 state waiting for a connection termination request from the remote
    ///TCP. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_CLOSE_WAIT"></a><a
    ///id="mib_tcp_state_close_wait"></a><dl> <dt><b>MIB_TCP_STATE_CLOSE_WAIT</b></dt> <dt>8</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is in the CLOSE-WAIT state waiting for a connection termination request from the
    ///local user. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_CLOSING"></a><a
    ///id="mib_tcp_state_closing"></a><dl> <dt><b>MIB_TCP_STATE_CLOSING</b></dt> <dt>9</dt> </dl> </td> <td width="60%">
    ///The TCP connection is in the CLOSING state waiting for a connection termination request acknowledgment from the
    ///remote TCP. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_LAST_ACK"></a><a
    ///id="mib_tcp_state_last_ack"></a><dl> <dt><b>MIB_TCP_STATE_LAST_ACK</b></dt> <dt>10</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is in the LAST-ACK state waiting for an acknowledgment of the connection
    ///termination request previously sent to the remote TCP (which includes an acknowledgment of its connection
    ///termination request). </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_TIME_WAIT"></a><a
    ///id="mib_tcp_state_time_wait"></a><dl> <dt><b>MIB_TCP_STATE_TIME_WAIT</b></dt> <dt>11</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is in the TIME-WAIT state waiting for enough time to pass to be sure the remote
    ///TCP received the acknowledgment of its connection termination request. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_DELETE_TCB"></a><a id="mib_tcp_state_delete_tcb"></a><dl>
    ///<dt><b>MIB_TCP_STATE_DELETE_TCB</b></dt> <dt>12</dt> </dl> </td> <td width="60%"> The TCP connection is in the
    ///delete TCB state that represents the deletion of the Transmission Control Block (TCB), a data structure used to
    ///maintain information on each TCP entry. </td> </tr> </table>
    MIB_TCP_STATE State;
    ///Type: <b>IN6_ADDR</b> The local IPv6 address for the TCP connection on the local computer. A value of zero
    ///indicates the listener can accept a connection on any interface.
    in6_addr      LocalAddr;
    ///Type: <b>DWORD</b> The local scope ID for the TCP connection on the local computer.
    uint          dwLocalScopeId;
    ///Type: <b>DWORD</b> The local port number in network byte order for the TCP connection on the local computer. The
    ///maximum size of an IP port number is 16 bits, so only the lower 16 bits should be used. The upper 16 bits may
    ///contain uninitialized data.
    uint          dwLocalPort;
    ///Type: <b>IN6_ADDR</b> The IPv6 address for the TCP connection on the remote computer. When the <b>State</b>
    ///member is <b>MIB_TCP_STATE_LISTEN</b>, this value has no meaning.
    in6_addr      RemoteAddr;
    ///Type: <b>DWORD</b> The remote scope ID for the TCP connection on the remote computer. When the <b>State</b>
    ///member is <b>MIB_TCP_STATE_LISTEN</b>, this value has no meaning.
    uint          dwRemoteScopeId;
    ///Type: <b>DWORD</b> The remote port number in network byte order for the TCP connection on the remote computer.
    ///When the <b>State</b> member is <b>MIB_TCP_STATE_LISTEN</b>, this value has no meaning. The maximum size of an IP
    ///port number is 16 bits, so only the lower 16 bits should be used. The upper 16 bits may contain uninitialized
    ///data.
    uint          dwRemotePort;
}

///The <b>MIB_TCP6TABLE</b> structure contains a table of TCP connections for IPv6 on the local computer.
struct MIB_TCP6TABLE
{
    ///A value that specifies the number of TCP connections in the array.
    uint           dwNumEntries;
    ///An array of MIB_TCP6ROW structures containing TCP connection entries.
    MIB_TCP6ROW[1] table;
}

///The <b>MIB_TCP6ROW2</b> structure contains information that describes an IPv6 TCP connection.
struct MIB_TCP6ROW2
{
    ///Type: <b>IN6_ADDR</b> The local IPv6 address for the TCP connection on the local computer. A value of zero
    ///indicates the listener can accept a connection on any interface.
    in6_addr      LocalAddr;
    ///Type: <b>DWORD</b> The local scope ID for the TCP connection on the local computer.
    uint          dwLocalScopeId;
    ///Type: <b>DWORD</b> The local port number in network byte order for the TCP connection on the local computer. The
    ///maximum size of an IP port number is 16 bits, so only the lower 16 bits should be used. The upper 16 bits may
    ///contain uninitialized data.
    uint          dwLocalPort;
    ///Type: <b>IN6_ADDR</b> The IPv6 address for the TCP connection on the remote computer. When the <b>State</b>
    ///member is <b>MIB_TCP_STATE_LISTEN</b>, this value has no meaning.
    in6_addr      RemoteAddr;
    ///Type: <b>DWORD</b> The remote scope ID for the TCP connection on the remote computer. When the <b>State</b>
    ///member is <b>MIB_TCP_STATE_LISTEN</b>, this value has no meaning.
    uint          dwRemoteScopeId;
    ///Type: <b>DWORD</b> The remote port number in network byte order for the TCP connection on the remote computer.
    ///When the <b>State</b> member is <b>MIB_TCP_STATE_LISTEN</b>, this value has no meaning. The maximum size of an IP
    ///port number is 16 bits, so only the lower 16 bits should be used. The upper 16 bits may contain uninitialized
    ///data.
    uint          dwRemotePort;
    ///Type: <b>MIB_TCP_STATE</b> The state of the TCP connection. This member can be one of the values from the
    ///<b>MIB_TCP_STATE</b> enumeration type defined in the <i>Tcpmib.h</i> header file. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_CLOSED"></a><a
    ///id="mib_tcp_state_closed"></a><dl> <dt><b>MIB_TCP_STATE_CLOSED</b></dt> <dt>1</dt> </dl> </td> <td width="60%">
    ///The TCP connection is in the CLOSED state that represents no connection state at all. </td> </tr> <tr> <td
    ///width="40%"><a id="MIB_TCP_STATE_LISTEN"></a><a id="mib_tcp_state_listen"></a><dl>
    ///<dt><b>MIB_TCP_STATE_LISTEN</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The TCP connection is in the LISTEN
    ///state waiting for a connection request from any remote TCP and port. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_SYN_SENT"></a><a id="mib_tcp_state_syn_sent"></a><dl> <dt><b>MIB_TCP_STATE_SYN_SENT</b></dt>
    ///<dt>3</dt> </dl> </td> <td width="60%"> The TCP connection is in the SYN-SENT state waiting for a matching
    ///connection request after having sent a connection request (SYN packet). </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_SYN_RCVD"></a><a id="mib_tcp_state_syn_rcvd"></a><dl> <dt><b>MIB_TCP_STATE_SYN_RCVD</b></dt>
    ///<dt>4</dt> </dl> </td> <td width="60%"> The TCP connection is in the SYN-RECEIVED state waiting for a confirming
    ///connection request acknowledgment after having both received and sent a connection request (SYN packet). </td>
    ///</tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_ESTAB"></a><a id="mib_tcp_state_estab"></a><dl>
    ///<dt><b>MIB_TCP_STATE_ESTAB</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> The TCP connection is in the
    ///ESTABLISHED state that represents an open connection, data received can be delivered to the user. This is the
    ///normal state for the data transfer phase of the TCP connection. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_FIN_WAIT1"></a><a id="mib_tcp_state_fin_wait1"></a><dl> <dt><b>MIB_TCP_STATE_FIN_WAIT1</b></dt>
    ///<dt>6</dt> </dl> </td> <td width="60%"> The TCP connection is FIN-WAIT-1 state waiting for a connection
    ///termination request from the remote TCP, or an acknowledgment of the connection termination request previously
    ///sent. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_FIN_WAIT2"></a><a
    ///id="mib_tcp_state_fin_wait2"></a><dl> <dt><b>MIB_TCP_STATE_FIN_WAIT2</b></dt> <dt>7</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is FIN-WAIT-1 state waiting for a connection termination request from the remote
    ///TCP. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_CLOSE_WAIT"></a><a
    ///id="mib_tcp_state_close_wait"></a><dl> <dt><b>MIB_TCP_STATE_CLOSE_WAIT</b></dt> <dt>8</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is in the CLOSE-WAIT state waiting for a connection termination request from the
    ///local user. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_CLOSING"></a><a
    ///id="mib_tcp_state_closing"></a><dl> <dt><b>MIB_TCP_STATE_CLOSING</b></dt> <dt>9</dt> </dl> </td> <td width="60%">
    ///The TCP connection is in the CLOSING state waiting for a connection termination request acknowledgment from the
    ///remote TCP. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_LAST_ACK"></a><a
    ///id="mib_tcp_state_last_ack"></a><dl> <dt><b>MIB_TCP_STATE_LAST_ACK</b></dt> <dt>10</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is in the LAST-ACK state waiting for an acknowledgment of the connection
    ///termination request previously sent to the remote TCP (which includes an acknowledgment of its connection
    ///termination request). </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_TIME_WAIT"></a><a
    ///id="mib_tcp_state_time_wait"></a><dl> <dt><b>MIB_TCP_STATE_TIME_WAIT</b></dt> <dt>11</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is in the TIME-WAIT state waiting for enough time to pass to be sure the remote
    ///TCP received the acknowledgment of its connection termination request. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_DELETE_TCB"></a><a id="mib_tcp_state_delete_tcb"></a><dl>
    ///<dt><b>MIB_TCP_STATE_DELETE_TCB</b></dt> <dt>12</dt> </dl> </td> <td width="60%"> The TCP connection is in the
    ///delete TCB state that represents the deletion of the Transmission Control Block (TCB), a data structure used to
    ///maintain information on each TCP entry. </td> </tr> </table>
    MIB_TCP_STATE State;
    ///Type: <b>DWORD</b> The PID of the process that issued a context bind for this TCP connection.
    uint          dwOwningPid;
    ///Type: <b>TCP_CONNECTION_OFFLOAD_STATE</b> The offload state for this TCP connection. This parameter can be one of
    ///the enumeration values for the TCP_CONNECTION_OFFLOAD_STATE defined in the <i>Tcpmib.h</i> header.
    TCP_CONNECTION_OFFLOAD_STATE dwOffloadState;
}

///The <b>MIB_TCP6TABLE2</b> structure contains a table of IPv6 TCP connections on the local computer.
struct MIB_TCP6TABLE2
{
    ///A value that specifies the number of TCP connections in the array.
    uint            dwNumEntries;
    ///An array of MIB_TCP6ROW2 structures containing TCP connection entries.
    MIB_TCP6ROW2[1] table;
}

///The <b>MIB_TCP6ROW_OWNER_PID</b> structure contains information that describes an IPv6 TCP connection associated with
///a specific process ID (PID).
struct MIB_TCP6ROW_OWNER_PID
{
    ///Type: <b>UCHAR[16]</b> The IPv6 address for the local endpoint of the TCP connection on the local computer. A
    ///value of zero indicates the listener can accept a connection on any interface.
    ubyte[16] ucLocalAddr;
    ///Type: <b>DWORD</b> The scope ID in network byte order for the local IPv6 address.
    uint      dwLocalScopeId;
    ///Type: <b>DWORD</b> The port number in network byte order for the local endpoint of the TCP connection on the
    ///local computer.
    uint      dwLocalPort;
    ///Type: <b>UCHAR[16]</b> The IPv6 address of the remote endpoint of the TCP connection on the remote computer. When
    ///the <b>dwState</b> member is <b>MIB_TCP_STATE_LISTEN</b>, this value has no meaning.
    ubyte[16] ucRemoteAddr;
    ///Type: <b>DWORD</b> The scope ID in network byte order for the remote IPv6 address.
    uint      dwRemoteScopeId;
    ///Type: <b>DWORD</b> The port number in network byte order for the remote endpoint of the TCP connection on the
    ///remote computer.
    uint      dwRemotePort;
    ///Type: <b>DWORD</b> The state of the TCP connection. This member can be one of the values from the
    ///<b>MIB_TCP_STATE</b> enumeration defined in the <i>Tcpmib.h</i> header file. Note that the <i>Tcpmib.h</i> header
    ///file is automatically included in <i>Iprtrmib.h</i>, which is automatically included in the <i>Iphlpapi.h</i>
    ///header file. The <i>Tcpmib.h</i> and <i>Iprtrmib.h</i> header files should never be used directly. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_CLOSED"></a><a
    ///id="mib_tcp_state_closed"></a><dl> <dt><b>MIB_TCP_STATE_CLOSED</b></dt> <dt>1</dt> </dl> </td> <td width="60%">
    ///The TCP connection is in the CLOSED state that represents no connection state at all. </td> </tr> <tr> <td
    ///width="40%"><a id="MIB_TCP_STATE_LISTEN"></a><a id="mib_tcp_state_listen"></a><dl>
    ///<dt><b>MIB_TCP_STATE_LISTEN</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The TCP connection is in the LISTEN
    ///state waiting for a connection request from any remote TCP and port. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_SYN_SENT"></a><a id="mib_tcp_state_syn_sent"></a><dl> <dt><b>MIB_TCP_STATE_SYN_SENT</b></dt>
    ///<dt>3</dt> </dl> </td> <td width="60%"> The TCP connection is in the SYN-SENT state waiting for a matching
    ///connection request after having sent a connection request (SYN packet). </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_SYN_RCVD"></a><a id="mib_tcp_state_syn_rcvd"></a><dl> <dt><b>MIB_TCP_STATE_SYN_RCVD</b></dt>
    ///<dt>4</dt> </dl> </td> <td width="60%"> The TCP connection is in the SYN-RECEIVED state waiting for a confirming
    ///connection request acknowledgment after having both received and sent a connection request (SYN packet). </td>
    ///</tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_ESTAB"></a><a id="mib_tcp_state_estab"></a><dl>
    ///<dt><b>MIB_TCP_STATE_ESTAB</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> The TCP connection is in the
    ///ESTABLISHED state that represents an open connection, data received can be delivered to the user. This is the
    ///normal state for the data transfer phase of the TCP connection. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_FIN_WAIT1"></a><a id="mib_tcp_state_fin_wait1"></a><dl> <dt><b>MIB_TCP_STATE_FIN_WAIT1</b></dt>
    ///<dt>6</dt> </dl> </td> <td width="60%"> The TCP connection is FIN-WAIT-1 state waiting for a connection
    ///termination request from the remote TCP, or an acknowledgment of the connection termination request previously
    ///sent. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_FIN_WAIT2"></a><a
    ///id="mib_tcp_state_fin_wait2"></a><dl> <dt><b>MIB_TCP_STATE_FIN_WAIT2</b></dt> <dt>7</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is FIN-WAIT-1 state waiting for a connection termination request from the remote
    ///TCP. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_CLOSE_WAIT"></a><a
    ///id="mib_tcp_state_close_wait"></a><dl> <dt><b>MIB_TCP_STATE_CLOSE_WAIT</b></dt> <dt>8</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is in the CLOSE-WAIT state waiting for a connection termination request from the
    ///local user. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_CLOSING"></a><a
    ///id="mib_tcp_state_closing"></a><dl> <dt><b>MIB_TCP_STATE_CLOSING</b></dt> <dt>9</dt> </dl> </td> <td width="60%">
    ///The TCP connection is in the CLOSING state waiting for a connection termination request acknowledgment from the
    ///remote TCP. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_LAST_ACK"></a><a
    ///id="mib_tcp_state_last_ack"></a><dl> <dt><b>MIB_TCP_STATE_LAST_ACK</b></dt> <dt>10</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is in the LAST-ACK state waiting for an acknowledgment of the connection
    ///termination request previously sent to the remote TCP (which includes an acknowledgment of its connection
    ///termination request). </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_TIME_WAIT"></a><a
    ///id="mib_tcp_state_time_wait"></a><dl> <dt><b>MIB_TCP_STATE_TIME_WAIT</b></dt> <dt>11</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is in the TIME-WAIT state waiting for enough time to pass to be sure the remote
    ///TCP received the acknowledgment of its connection termination request. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_DELETE_TCB"></a><a id="mib_tcp_state_delete_tcb"></a><dl>
    ///<dt><b>MIB_TCP_STATE_DELETE_TCB</b></dt> <dt>12</dt> </dl> </td> <td width="60%"> The TCP connection is in the
    ///delete TCB state that represents the deletion of the Transmission Control Block (TCB), a data structure used to
    ///maintain information on each TCP entry. </td> </tr> </table>
    uint      dwState;
    ///Type: <b>DWORD</b> The PID of the local process that issued a context bind for this TCP connection.
    uint      dwOwningPid;
}

///The <b>MIB_TCP6TABLE_OWNER_PID</b> structure contains a table of process IDs (PIDs) and the IPv6 TCP links that are
///context bound to these PIDs.
struct MIB_TCP6TABLE_OWNER_PID
{
    ///The number of MIB_TCP6ROW_OWNER_PID elements in the <b>table</b>.
    uint dwNumEntries;
    ///Array of MIB_TCP6ROW_OWNER_PID structures returned by a call to GetExtendedTcpTable.
    MIB_TCP6ROW_OWNER_PID[1] table;
}

///The <b>MIB_TCP6ROW_OWNER_MODULE</b> structure contains information that describes an IPv6 TCP connection bound to a
///specific process ID (PID) with ownership data.
struct MIB_TCP6ROW_OWNER_MODULE
{
    ///Type: <b>UCHAR[16]</b> The IPv6 address for the local endpoint of the TCP connection on the local computer. A
    ///value of zero indicates the listener can accept a connection on any interface.
    ubyte[16]     ucLocalAddr;
    ///Type: <b>DWORD</b> The scope ID in network byte order for the local IPv6 address.
    uint          dwLocalScopeId;
    ///Type: <b>DWORD</b> The port number in network byte order for the local endpoint of the TCP connection on the
    ///local computer.
    uint          dwLocalPort;
    ///Type: <b>UCHAR[16]</b> The IPv6 address of the remote endpoint of the TCP connection on the remote computer. When
    ///the <b>dwState</b> member is <b>MIB_TCP_STATE_LISTEN</b>, this value has no meaning.
    ubyte[16]     ucRemoteAddr;
    ///Type: <b>DWORD</b> The scope ID in network byte order for the remote IPv6 address.
    uint          dwRemoteScopeId;
    ///Type: <b>DWORD</b> The port number in network byte order for the remote endpoint of the TCP connection on the
    ///remote computer.
    uint          dwRemotePort;
    ///Type: <b>DWORD</b> The state of the TCP connection. This member can be one of the values from the
    ///<b>MIB_TCP_STATE</b> enumeration defined in the <i>Tcpmib.h</i> header file. Note that the <i>Tcpmib.h</i> header
    ///file is automatically included in <i>Iprtrmib.h</i>, which is automatically included in the <i>Iphlpapi.h</i>
    ///header file. The <i>Tcpmib.h</i> and <i>Iprtrmib.h</i> header files should never be used directly. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_CLOSED"></a><a
    ///id="mib_tcp_state_closed"></a><dl> <dt><b>MIB_TCP_STATE_CLOSED</b></dt> <dt>1</dt> </dl> </td> <td width="60%">
    ///The TCP connection is in the CLOSED state that represents no connection state at all. </td> </tr> <tr> <td
    ///width="40%"><a id="MIB_TCP_STATE_LISTEN"></a><a id="mib_tcp_state_listen"></a><dl>
    ///<dt><b>MIB_TCP_STATE_LISTEN</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The TCP connection is in the LISTEN
    ///state waiting for a connection request from any remote TCP and port. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_SYN_SENT"></a><a id="mib_tcp_state_syn_sent"></a><dl> <dt><b>MIB_TCP_STATE_SYN_SENT</b></dt>
    ///<dt>3</dt> </dl> </td> <td width="60%"> The TCP connection is in the SYN-SENT state waiting for a matching
    ///connection request after having sent a connection request (SYN packet). </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_SYN_RCVD"></a><a id="mib_tcp_state_syn_rcvd"></a><dl> <dt><b>MIB_TCP_STATE_SYN_RCVD</b></dt>
    ///<dt>4</dt> </dl> </td> <td width="60%"> The TCP connection is in the SYN-RECEIVED state waiting for a confirming
    ///connection request acknowledgment after having both received and sent a connection request (SYN packet). </td>
    ///</tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_ESTAB"></a><a id="mib_tcp_state_estab"></a><dl>
    ///<dt><b>MIB_TCP_STATE_ESTAB</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> The TCP connection is in the
    ///ESTABLISHED state that represents an open connection, data received can be delivered to the user. This is the
    ///normal state for the data transfer phase of the TCP connection. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_FIN_WAIT1"></a><a id="mib_tcp_state_fin_wait1"></a><dl> <dt><b>MIB_TCP_STATE_FIN_WAIT1</b></dt>
    ///<dt>6</dt> </dl> </td> <td width="60%"> The TCP connection is FIN-WAIT-1 state waiting for a connection
    ///termination request from the remote TCP, or an acknowledgment of the connection termination request previously
    ///sent. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_FIN_WAIT2"></a><a
    ///id="mib_tcp_state_fin_wait2"></a><dl> <dt><b>MIB_TCP_STATE_FIN_WAIT2</b></dt> <dt>7</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is FIN-WAIT-1 state waiting for a connection termination request from the remote
    ///TCP. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_CLOSE_WAIT"></a><a
    ///id="mib_tcp_state_close_wait"></a><dl> <dt><b>MIB_TCP_STATE_CLOSE_WAIT</b></dt> <dt>8</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is in the CLOSE-WAIT state waiting for a connection termination request from the
    ///local user. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_CLOSING"></a><a
    ///id="mib_tcp_state_closing"></a><dl> <dt><b>MIB_TCP_STATE_CLOSING</b></dt> <dt>9</dt> </dl> </td> <td width="60%">
    ///The TCP connection is in the CLOSING state waiting for a connection termination request acknowledgment from the
    ///remote TCP. </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_LAST_ACK"></a><a
    ///id="mib_tcp_state_last_ack"></a><dl> <dt><b>MIB_TCP_STATE_LAST_ACK</b></dt> <dt>10</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is in the LAST-ACK state waiting for an acknowledgment of the connection
    ///termination request previously sent to the remote TCP (which includes an acknowledgment of its connection
    ///termination request). </td> </tr> <tr> <td width="40%"><a id="MIB_TCP_STATE_TIME_WAIT"></a><a
    ///id="mib_tcp_state_time_wait"></a><dl> <dt><b>MIB_TCP_STATE_TIME_WAIT</b></dt> <dt>11</dt> </dl> </td> <td
    ///width="60%"> The TCP connection is in the TIME-WAIT state waiting for enough time to pass to be sure the remote
    ///TCP received the acknowledgment of its connection termination request. </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_STATE_DELETE_TCB"></a><a id="mib_tcp_state_delete_tcb"></a><dl>
    ///<dt><b>MIB_TCP_STATE_DELETE_TCB</b></dt> <dt>12</dt> </dl> </td> <td width="60%"> The TCP connection is in the
    ///delete TCB state that represents the deletion of the Transmission Control Block (TCB), a data structure used to
    ///maintain information on each TCP entry. </td> </tr> </table>
    uint          dwState;
    ///Type: <b>DWORD</b> The PID of the local process that issued a context bind for this TCP connection.
    uint          dwOwningPid;
    ///Type: <b>LARGE_INTEGER</b> A FILETIME structure that indicates when the context bind operation that created this
    ///TCP connection occurred.
    LARGE_INTEGER liCreateTimestamp;
    ///Type: <b>ULONGLONG[TCPIP_OWNING_MODULE_SIZE]</b> An array of opaque data that contains ownership information.
    ulong[16]     OwningModuleInfo;
}

///The <b>MIB_TCP6TABLE_OWNER_MODULE</b> structure contains a table of process IDs (PIDs) and the IPv6 TCP links context
///bound to these PIDs with any available ownership data.
struct MIB_TCP6TABLE_OWNER_MODULE
{
    ///The number of MIB_TCP6ROW_OWNER_MODULE elements in the <b>table</b>.
    uint dwNumEntries;
    ///Array of MIB_TCP6ROW_OWNER_MODULE structures returned by a call to GetExtendedTcpTable.
    MIB_TCP6ROW_OWNER_MODULE[1] table;
}

///The <b>MIB_TCPSTATS</b> structure contains statistics for the TCP protocol running on the local computer.
struct MIB_TCPSTATS_LH
{
    union
    {
        uint              dwRtoAlgorithm;
        TCP_RTO_ALGORITHM RtoAlgorithm;
    }
    ///Type: <b>DWORD</b> The minimum RTO value in milliseconds.
    uint dwRtoMin;
    ///Type: <b>DWORD</b> The maximum RTO value in milliseconds.
    uint dwRtoMax;
    ///Type: <b>DWORD</b> The maximum number of connections. If this member is -1, the maximum number of connections is
    ///variable.
    uint dwMaxConn;
    ///Type: <b>DWORD</b> The number of active opens. In an active open, the client is initiating a connection with the
    ///server.
    uint dwActiveOpens;
    ///Type: <b>DWORD</b> The number of passive opens. In a passive open, the server is listening for a connection
    ///request from a client.
    uint dwPassiveOpens;
    ///Type: <b>DWORD</b> The number of failed connection attempts.
    uint dwAttemptFails;
    ///Type: <b>DWORD</b> The number of established connections that were reset.
    uint dwEstabResets;
    ///Type: <b>DWORD</b> The number of currently established connections.
    uint dwCurrEstab;
    ///Type: <b>DWORD</b> The number of segments received.
    uint dwInSegs;
    ///Type: <b>DWORD</b> The number of segments transmitted. This number does not include retransmitted segments.
    uint dwOutSegs;
    ///Type: <b>DWORD</b> The number of segments retransmitted.
    uint dwRetransSegs;
    ///Type: <b>DWORD</b> The number of errors received.
    uint dwInErrs;
    ///Type: <b>DWORD</b> The number of segments transmitted with the reset flag set.
    uint dwOutRsts;
    ///Type: <b>DWORD</b> The number of connections that are currently present in the system. This total number includes
    ///connections in all states except listening connections.
    uint dwNumConns;
}

///The <b>MIB_TCPSTATS</b> structure contains statistics for the TCP protocol running on the local computer.
struct MIB_TCPSTATS_W2K
{
    ///Type: <b>DWORD</b> The retransmission time-out (RTO) algorithm in use. This member can be one of the following
    ///values: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MIB_TCP_RTO_OTHER"></a><a
    ///id="mib_tcp_rto_other"></a><dl> <dt><b>MIB_TCP_RTO_OTHER</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Other
    ///</td> </tr> <tr> <td width="40%"><a id="MIB_TCP_RTO_CONSTANT"></a><a id="mib_tcp_rto_constant"></a><dl>
    ///<dt><b>MIB_TCP_RTO_CONSTANT</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Constant Time-out </td> </tr> <tr>
    ///<td width="40%"><a id="MIB_TCP_RTO_RSRE"></a><a id="mib_tcp_rto_rsre"></a><dl> <dt><b>MIB_TCP_RTO_RSRE</b></dt>
    ///<dt>3</dt> </dl> </td> <td width="60%"> MIL-STD-1778 Appendix B </td> </tr> <tr> <td width="40%"><a
    ///id="MIB_TCP_RTO_VANJ"></a><a id="mib_tcp_rto_vanj"></a><dl> <dt><b>MIB_TCP_RTO_VANJ</b></dt> <dt>4</dt> </dl>
    ///</td> <td width="60%"> Van Jacobson's Algorithm </td> </tr> </table>
    uint dwRtoAlgorithm;
    ///Type: <b>DWORD</b> The minimum RTO value in milliseconds.
    uint dwRtoMin;
    ///Type: <b>DWORD</b> The maximum RTO value in milliseconds.
    uint dwRtoMax;
    ///Type: <b>DWORD</b> The maximum number of connections. If this member is -1, the maximum number of connections is
    ///variable.
    uint dwMaxConn;
    ///Type: <b>DWORD</b> The number of active opens. In an active open, the client is initiating a connection with the
    ///server.
    uint dwActiveOpens;
    ///Type: <b>DWORD</b> The number of passive opens. In a passive open, the server is listening for a connection
    ///request from a client.
    uint dwPassiveOpens;
    ///Type: <b>DWORD</b> The number of failed connection attempts.
    uint dwAttemptFails;
    ///Type: <b>DWORD</b> The number of established connections that were reset.
    uint dwEstabResets;
    ///Type: <b>DWORD</b> The number of currently established connections.
    uint dwCurrEstab;
    ///Type: <b>DWORD</b> The number of segments received.
    uint dwInSegs;
    ///Type: <b>DWORD</b> The number of segments transmitted. This number does not include retransmitted segments.
    uint dwOutSegs;
    ///Type: <b>DWORD</b> The number of segments retransmitted.
    uint dwRetransSegs;
    ///Type: <b>DWORD</b> The number of errors received.
    uint dwInErrs;
    ///Type: <b>DWORD</b> The number of segments transmitted with the reset flag set.
    uint dwOutRsts;
    ///Type: <b>DWORD</b> The number of connections that are currently present in the system. This total number includes
    ///connections in all states except listening connections.
    uint dwNumConns;
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] The <b>MIB_TCPSTATS2</b> structure contains statistics for the TCP protocol running on the local
///computer. This structure is different from MIB_TCPSTATS structure in that it uses 64-bit counters, rather than 32-bit
///counters.
struct MIB_TCPSTATS2
{
    TCP_RTO_ALGORITHM RtoAlgorithm;
    ///Type: <b>DWORD</b> The minimum RTO value in milliseconds.
    uint              dwRtoMin;
    ///Type: <b>DWORD</b> The maximum RTO value in milliseconds.
    uint              dwRtoMax;
    ///Type: <b>DWORD</b> The maximum number of connections. If this member is -1, the maximum number of connections is
    ///variable.
    uint              dwMaxConn;
    ///Type: <b>DWORD</b> The number of active opens. In an active open, the client is initiating a connection with the
    ///server.
    uint              dwActiveOpens;
    ///Type: <b>DWORD</b> The number of passive opens. In a passive open, the server is listening for a connection
    ///request from a client.
    uint              dwPassiveOpens;
    ///Type: <b>DWORD</b> The number of failed connection attempts.
    uint              dwAttemptFails;
    ///Type: <b>DWORD</b> The number of established connections that were reset.
    uint              dwEstabResets;
    ///Type: <b>DWORD</b> The number of currently established connections.
    uint              dwCurrEstab;
    ///Type: <b>DWORD</b> The number of segments received.
    ulong             dw64InSegs;
    ///Type: <b>DWORD64</b> The number of segments transmitted. This number does not include retransmitted segments.
    ulong             dw64OutSegs;
    ///Type: <b>DWORD64</b> The number of segments retransmitted.
    uint              dwRetransSegs;
    ///Type: <b>DWORD</b> The number of errors received.
    uint              dwInErrs;
    ///Type: <b>DWORD</b> The number of segments transmitted with the reset flag set.
    uint              dwOutRsts;
    ///Type: <b>DWORD</b> The number of connections that are currently present in the system. This total number includes
    ///connections in all states except listening connections.
    uint              dwNumConns;
}

///The <b>MIB_UDPROW</b> structure contains an entry from the User Datagram Protocol (UDP) listener table for IPv4 on
///the local computer.
struct MIB_UDPROW
{
    ///The IPv4 address of the UDP endpoint on the local computer. A value of zero indicates a UDP listener willing to
    ///accept datagrams for any IP interface associated with the local computer.
    uint dwLocalAddr;
    ///The port number of the UDP endpoint on the local computer. This member is stored in network byte order.
    uint dwLocalPort;
}

///The <b>MIB_UDPTABLE</b> structure contains the User Datagram Protocol (UDP) listener table for IPv4 on the local
///computer.
struct MIB_UDPTABLE
{
    ///The number of entries in the table.
    uint          dwNumEntries;
    ///A pointer to an array of MIB_UDPROW structures.
    MIB_UDPROW[1] table;
}

///The <b>MIB_UDPROW_OWNER_PID</b> structure contains an entry from the User Datagram Protocol (UDP) listener table for
///IPv4 on the local computer. The entry also includes the process ID (PID) that issued the call to the bind function
///for the UDP endpoint.
struct MIB_UDPROW_OWNER_PID
{
    ///The IPv4 address of the UDP endpoint on the local computer. A value of zero indicates a UDP listener willing to
    ///accept datagrams for any IP interface associated with the local computer.
    uint dwLocalAddr;
    ///The port number of the UDP endpoint on the local computer. This member is stored in network byte order.
    uint dwLocalPort;
    ///The PID of the process that issued the call to the bind function for the UDP endpoint. This member is set to 0
    ///when the PID is unavailable.
    uint dwOwningPid;
}

///The <b>MIB_UDPTABLE_OWNER_PID</b> structure contains the User Datagram Protocol (UDP) listener table for IPv4 on the
///local computer. The table also includes the process ID (PID) that issued the call to the bind function for each UDP
///endpoint.
struct MIB_UDPTABLE_OWNER_PID
{
    ///The number of MIB_UDPROW_OWNER_PID elements in <b>table</b>.
    uint dwNumEntries;
    ///An array of MIB_UDPROW_OWNER_PID structures returned by a call to GetExtendedUdpTable.
    MIB_UDPROW_OWNER_PID[1] table;
}

///The <b>MIB_UDPROW_OWNER_MODULE</b> structure contains an entry from the IPv4 User Datagram Protocol (UDP) listener
///table on the local computer. This entry also also includes any available ownership data and the process ID (PID) that
///issued the call to the bind function for the UDP endpoint.
struct MIB_UDPROW_OWNER_MODULE
{
    ///Type: <b>DWORD</b> The IPv4 address of the UDP endpoint on the local computer. A value of zero indicates a UDP
    ///listener willing to accept datagrams for any IP interface associated with the local computer.
    uint          dwLocalAddr;
    ///Type: <b>DWORD</b> The port number of the UDP endpoint on the local computer. This member is stored in network
    ///byte order.
    uint          dwLocalPort;
    ///Type: <b>DWORD</b> The PID of the process that issued the call to the bind function for the UDP endpoint. This
    ///member is set to 0 when the PID is unavailable.
    uint          dwOwningPid;
    ///Type: <b>LARGE_INTEGER</b> A FILETIME structure that indicates when the call to the bind function for the UDP
    ///endpoint occurred.
    LARGE_INTEGER liCreateTimestamp;
    union
    {
        struct
        {
            int _bitfield72;
        }
        int dwFlags;
    }
    ///Type: <b>ULONGLONG[TCPIP_OWNING_MODULE_SIZE]</b> An array of opaque data that contains ownership information.
    ulong[16]     OwningModuleInfo;
}

///The <b>MIB_UDPTABLE_OWNER_MODULE</b> structure contains the User Datagram Protocol (UDP) listener table for IPv4 on
///the local computer. The table also includes any available ownership data and the process ID (PID) that issued the
///call to the bind function for each UDP endpoint.
struct MIB_UDPTABLE_OWNER_MODULE
{
    ///The number of MIB_UDPROW_OWNER_MODULE elements in <b>table</b>.
    uint dwNumEntries;
    ///An array of MIB_UDPROW_OWNER_MODULE structures returned by a call to GetExtendedUdpTable.
    MIB_UDPROW_OWNER_MODULE[1] table;
}

///The <b>MIB_UDP6ROW</b> structure contains an entry from the User Datagram Protocol (UDP) listener table for IPv6 on
///the local computer.
struct MIB_UDP6ROW
{
    ///The IPv6 address of the UDP endpoint on the local computer. This member is stored in a character array in network
    ///byte order. A value of zero indicates a UDP listener willing to accept datagrams for any IP interface associated
    ///with the local computer.
    in6_addr dwLocalAddr;
    ///The scope ID for the IPv6 address of the UDP endpoint on the local computer. This member is stored in network
    ///byte order.
    uint     dwLocalScopeId;
    ///The port number of the UDP endpoint on the local computer. This member is stored in network byte order.
    uint     dwLocalPort;
}

///The <b>MIB_UDP6TABLE</b> structure contains the User Datagram Protocol (UDP) listener table for IPv6 on the local
///computer.
struct MIB_UDP6TABLE
{
    ///The number of entries in the table.
    uint           dwNumEntries;
    ///A pointer to an array of MIB_UDP6ROW structures.
    MIB_UDP6ROW[1] table;
}

///The <b>MIB_UDP6ROW_OWNER_PID</b> structure contains an entry from the User Datagram Protocol (UDP) listener table for
///IPv6 on the local computer. The entry also includes the process ID (PID) that issued the call to the bind function
///for the UDP endpoint.
struct MIB_UDP6ROW_OWNER_PID
{
    ///The IPv6 address for the local UDP endpoint. This member is stored in a character array in network byte order. A
    ///value of zero indicates a UDP listener willing to accept datagrams for any IP interface associated with the local
    ///computer.
    ubyte[16] ucLocalAddr;
    ///The scope ID for the IPv6 address of the UDP endpoint on the local computer. This member is stored in network
    ///byte order.
    uint      dwLocalScopeId;
    ///The port number of the UDP endpoint on the local computer. This member is stored in network byte order.
    uint      dwLocalPort;
    ///The PID of the process that issued a context bind for this endpoint. If this value is set to 0, the information
    ///for this endpoint is unavailable.
    uint      dwOwningPid;
}

///The <b>MIB_UDP6TABLE_OWNER_PID</b> structure contains the User Datagram Protocol (UDP) listener table for IPv6 on the
///local computer. The table also includes the process ID (PID) that issued the call to the bind function for each UDP
///endpoint.
struct MIB_UDP6TABLE_OWNER_PID
{
    ///The number of MIB_UDP6ROW_OWNER_PID elements in <b>table</b>.
    uint dwNumEntries;
    ///An array of MIB_UDP6ROW_OWNER_PID structures returned by a call to GetExtendedUdpTable.
    MIB_UDP6ROW_OWNER_PID[1] table;
}

///The <b>MIB_UDP6ROW_OWNER_MODULE</b> structure contains an entry from the User Datagram Protocol (UDP) listener table
///for IPv6 on the local computer. This entry also also includes any available ownership data and the process ID (PID)
///that issued the call to the bind function for the UDP endpoint.
struct MIB_UDP6ROW_OWNER_MODULE
{
    ///Type: <b>UCHAR[16]</b> The IPv6 address of the UDP endpoint on the local computer. This member is stored in a
    ///character array in network byte order. A value of zero indicates a UDP listener willing to accept datagrams for
    ///any IP interface associated with the local computer.
    ubyte[16]     ucLocalAddr;
    ///Type: <b>DWORD</b> The scope ID for the IPv6 address of the UDP endpoint on the local computer.
    uint          dwLocalScopeId;
    ///Type: <b>DWORD</b> The port number for the local UDP endpoint.
    uint          dwLocalPort;
    ///Type: <b>DWORD</b> The PID of the process that issued a context bind for this endpoint. If this value is set to
    ///0, the information for this endpoint is unavailable.
    uint          dwOwningPid;
    ///Type: <b>LARGE_INTEGER</b> A FILETIME structure that indicates when the context bind operation that created this
    ///endpoint occurred.
    LARGE_INTEGER liCreateTimestamp;
    union
    {
        struct
        {
            int _bitfield73;
        }
        int dwFlags;
    }
    ///Type: <b>ULONGLONG[TCPIP_OWNING_MODULE_SIZE]</b> An array of opaque data that contains ownership information.
    ulong[16]     OwningModuleInfo;
}

///The <b>MIB_UDP6TABLE_OWNER_MODULE</b> structure contains the User Datagram Protocol (UDP) listener table for IPv6 on
///the local computer. The table also includes any available ownership data and the process ID (PID) that issued the
///call to the bind function for each UDP endpoint.
struct MIB_UDP6TABLE_OWNER_MODULE
{
    ///The number of MIB_UDP6ROW_OWNER_MODULE elements in <b>table</b>.
    uint dwNumEntries;
    ///An array of MIB_UDP6ROW_OWNER_MODULE structures returned by a call to GetExtendedUdpTable.
    MIB_UDP6ROW_OWNER_MODULE[1] table;
}

///The <b>MIB_UDPSTATS</b> structure contains statistics for the User Datagram Protocol (UDP) running on the local
///computer.
struct MIB_UDPSTATS
{
    ///The number of datagrams received.
    uint dwInDatagrams;
    ///The number of datagrams received that were discarded because the port specified was invalid.
    uint dwNoPorts;
    ///The number of erroneous datagrams received. This number does not include the value contained by the
    ///<b>dwNoPorts</b> member.
    uint dwInErrors;
    ///The number of datagrams transmitted.
    uint dwOutDatagrams;
    ///The number of entries in the UDP listener table.
    uint dwNumAddrs;
}

///<p class="CCE_Message">[Some information relates to pre-released product which may be substantially modified before
///it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information
///provided here.] The <b>MIB_UDPSTATS2</b> structure contains statistics for the User Datagram Protocol (UDP) running
///on the local computer. This structure is different from MIB_UDPSTATS structure in that it uses 64-bit counters,
///rather than 32-bit counters.
struct MIB_UDPSTATS2
{
    ///The number of datagrams received.
    ulong dw64InDatagrams;
    ///The number of datagrams received that were discarded because the port specified was invalid.
    uint  dwNoPorts;
    ///The number of erroneous datagrams received. This number does not include the value contained by the
    ///<b>dwNoPorts</b> member.
    uint  dwInErrors;
    ///The number of datagrams transmitted.
    ulong dw64OutDatagrams;
    ///The number of entries in the UDP listener table.
    uint  dwNumAddrs;
}

///The <b>MIB_IPMCAST_BOUNDARY</b> structure contains a row in a MIB_IPMCAST_BOUNDARY_TABLE structure that lists a
///router's scoped IPv4 multicast address boundaries.
struct MIB_IPMCAST_BOUNDARY
{
    ///Type: <b>DWORD</b> The index value for the interface to which this boundary applies. Packets with a destination
    ///address in the associated address/mask range are not forwarded with this interface.
    uint dwIfIndex;
    ///Type: <b>DWORD</b> The 32-bit integer representation of the IPv4 group address which, when combined with the
    ///corresponding value in <b>dwGroupMask</b>, identifies the group range for which the scoped boundary exists. <div
    ///class="alert"><b>Note</b> Scoped addresses must come from the range 239.*.*.* as specified in RFC 2365.</div>
    ///<div> </div>
    uint dwGroupAddress;
    ///Type: <b>DWORD</b> The 32-bit integer representation of the IPv4 group address mask which, when combined with the
    ///corresponding value in <b>dwGroupAddress</b>, identifies the group range for which the scoped boundary exists.
    uint dwGroupMask;
    ///Type: <b>DWORD</b> A status value that describes the current status of this entry in a MFE boundary table.
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td
    ///width="60%"> The entry has <b>active</b> status. </td> </tr> <tr> <td width="40%"> <dl> <dt>2</dt> </dl> </td>
    ///<td width="60%"> The entry has <b>notInService</b> status. </td> </tr> <tr> <td width="40%"> <dl> <dt>3</dt>
    ///</dl> </td> <td width="60%"> The entry has <b>notReady</b> status. </td> </tr> <tr> <td width="40%"> <dl>
    ///<dt>4</dt> </dl> </td> <td width="60%"> The entry has <b>createAndGo</b> status. </td> </tr> <tr> <td
    ///width="40%"> <dl> <dt>5</dt> </dl> </td> <td width="60%"> The entry has <b>createAndWait</b> status. </td> </tr>
    ///<tr> <td width="40%"> <dl> <dt>6</dt> </dl> </td> <td width="60%"> The entry has <b>destroy</b> status. </td>
    ///</tr> </table>
    uint dwStatus;
}

///The <b>MIB_IPMCAST_BOUNDARY_TABLE</b> structure contains a list of a router's scoped IPv4 multicast address
///boundaries.
struct MIB_IPMCAST_BOUNDARY_TABLE
{
    ///The number of MIB_IPMCAST_BOUNDARY structures listed in <b>table[]</b>.
    uint dwNumEntries;
    ///An array of MIB_IPMCAST_BOUNDARY structures which collectively define the set of scoped IPv4 multicast address
    ///boundaries on a router.
    MIB_IPMCAST_BOUNDARY[1] table;
}

///The <b>MIB_BOUNDARYROW</b> structure contains the IPv4 group address value and mask for a multicast boundary.
struct MIB_BOUNDARYROW
{
    ///The 32-bit integer representation of the IPv4 group address which, when combined with the corresponding value in
    ///<b>dwGroupMask</b>, identifies the group range for which the scoped boundary exists. <div
    ///class="alert"><b>Note</b> Scoped addresses must come from the range 239.*.*.* as specified in RFC 2365.</div>
    ///<div> </div>
    uint dwGroupAddress;
    ///The 32-bit integer representation of the IPv4 group address mask which, when combined with the corresponding
    ///value in <b>dwGroupAddress</b>, identifies the group range for which the scoped boundary exists.
    uint dwGroupMask;
}

///The <b>MIB_MCAST_LIMIT_ROW</b> structure contains the configurable limit information from a corresponding
///MIB_IPMCAST_IF_ENTRY structure.
struct MIB_MCAST_LIMIT_ROW
{
    ///The time-to-live value for a multicast interface.
    uint dwTtl;
    ///The rate limit for a multicast interface.
    uint dwRateLimit;
}

///The <b>MIB_IPMCAST_SCOPE</b> structure contains a multicast scope name and the associated IPv4 multicast group
///address and mask that define the scope.
struct MIB_IPMCAST_SCOPE
{
    ///Type: <b>DWORD</b> A 32-bit integer representation of the IPv4 group address which, when combined with the
    ///corresponding value in <b>dwGroupMask</b>, identifies the group range for which the multicast scope exists. <div
    ///class="alert"><b>Note</b> Scoped addresses must come from the range 239.*.*.* as specified in RFC 2365.</div>
    ///<div> </div>
    uint        dwGroupAddress;
    ///Type: <b>DWORD</b> A 32-bit integer representation of the IPv4 group address mask which, when combined with the
    ///corresponding value in <b>dwGroupAddress</b>, identifies the group range for which the multicast scope exists.
    uint        dwGroupMask;
    ///Type: <b>WCHAR[256]</b> A Unicode character array that contains the text name associated with the multicast
    ///scope. The name should be suitable for display to multicast application users. If no name is specified, the
    ///default name is the string representation of the scoped address in <b>dwGroupAddress</b> with the address and
    ///mask length appended and separated by a slash "/" character, of the form "239.*.*.*.x/y", where <b>x</b> is the
    ///address length and <b>y</b> is the mask length.
    ushort[256] snNameBuffer;
    ///Type: <b>DWORD</b> A status value that describes the current status of this row in a MFE scope table. <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%"> Row
    ///has <b>active</b> status. </td> </tr> <tr> <td width="40%"> <dl> <dt>2</dt> </dl> </td> <td width="60%"> Row has
    ///<b>notInService</b> status. </td> </tr> <tr> <td width="40%"> <dl> <dt>3</dt> </dl> </td> <td width="60%"> Row
    ///has <b>notReady</b> status. </td> </tr> <tr> <td width="40%"> <dl> <dt>4</dt> </dl> </td> <td width="60%"> Row
    ///has <b>createAndGo</b> status. </td> </tr> <tr> <td width="40%"> <dl> <dt>5</dt> </dl> </td> <td width="60%"> Row
    ///has <b>createAndWait</b> status. </td> </tr> <tr> <td width="40%"> <dl> <dt>6</dt> </dl> </td> <td width="60%">
    ///Row has <b>destroy</b> status. </td> </tr> </table>
    uint        dwStatus;
}

///The <b>MIB_BEST_IF</b> structure stores the index of the interface that has the best route to a particular
///destination IPv4 address.
struct MIB_BEST_IF
{
    ///Specifies the IPv4 address of the destination.
    uint dwDestAddr;
    ///Specifies the index of the interface that has the best route to the destination address specified by the
    ///<b>dwDestAddr</b> member.
    uint dwIfIndex;
}

///The <b>MIB_PROXYARP</b> structure stores information for a Proxy Address Resolution Protocol (PARP) entry.
struct MIB_PROXYARP
{
    ///The IPv4 address for which to act as a proxy.
    uint dwAddress;
    ///The subnet mask for the IPv4 address specified by the <b>dwAddress</b> member.
    uint dwMask;
    ///The index of the interface on which to act as a proxy for the address specified by the <b>dwAddress</b> member.
    uint dwIfIndex;
}

///The <b>MIB_IFSTATUS</b> structure stores status information for a particular interface.
struct MIB_IFSTATUS
{
    ///The index that identifies the interface.
    uint dwIfIndex;
    ///The administrative status of the interface, that is, whether the interface is administratively enabled or
    ///disabled.
    uint dwAdminStatus;
    ///The operational status of the interface. This member can be one of the values defined in the
    ///ROUTER_CONNECTION_STATE enumeration defined in the <i>Mprapip.h</i> header file. See the
    ///<b>ROUTER_CONNECTION_STATE</b> enumeration for a list amd description of the possible operational states.
    uint dwOperationalStatus;
    ///Specifies whether multicast heartbeat detection is enabled. A value of <b>TRUE</b> indicates that heartbeat
    ///detection is enabled. A value of <b>FALSE</b> indicates that heartbeat detection is disabled.
    BOOL bMHbeatActive;
    ///Specifies whether the multicast heartbeat dead interval has been exceeded. A value of <b>FALSE</b> indicates that
    ///the interval has been exceeded. A value of <b>TRUE</b> indicates that the interval has not been exceeded.
    BOOL bMHbeatAlive;
}

///The <b>MIB_OPAQUE_INFO</b> structure contains information returned from a MIB opaque query.
struct MIB_OPAQUE_INFO
{
    ///The type of information returned.
    uint dwId;
    union
    {
        ulong    ullAlign;
        ubyte[1] rgbyData;
    }
}

///The <b>NL_INTERFACE_OFFLOAD_ROD</b> structure specifies a set of flags that indicate the offload capabilities for an
///IP interface.
struct NL_INTERFACE_OFFLOAD_ROD
{
    ubyte _bitfield74;
}

