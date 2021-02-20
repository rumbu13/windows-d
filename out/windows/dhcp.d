// Written in the D programming language.

module windows.dhcp;

public import windows.core;
public import windows.systemservices : BOOL, PWSTR;

extern(Windows) @nogc nothrow:


// Enums


///The <b>StatusCode</b> enum contains status codes for IPv6 operations.
enum StatusCode : int
{
    STATUS_NO_ERROR            = 0x00000000,
    STATUS_UNSPECIFIED_FAILURE = 0x00000001,
    STATUS_NO_BINDING          = 0x00000003,
    STATUS_NOPREFIX_AVAIL      = 0x00000006,
}

///The <b>DHCP_FORCE_FLAG</b> enumeration defines the set of flags describing the force level of a DHCP subnet element
///deletion operation.
alias DHCP_FORCE_FLAG = int;
enum : int
{
    ///The operation deletes all client records affected by the element, and then deletes the element.
    DhcpFullForce     = 0x00000000,
    ///The operation only deletes the subnet element, leaving intact any client records impacted by the change.
    DhcpNoForce       = 0x00000001,
    ///The operation deletes all client records affected by the element, and then deletes the element from the DHCP
    ///server. But it does not delete any registered DNS records associated with the deleted client records from the DNS
    ///server. This flag is only valid when passed to DhcpDeleteSubnet. Note that the minimum server OS requirement for
    ///this value is Windows Server 2012 R2 with KB 3100473 installed.
    DhcpFailoverForce = 0x00000002,
}

///The <b>DHCP_SUBNET_STATE</b> enumeration defines the set of possible states for a subnet.
alias DHCP_SUBNET_STATE = int;
enum : int
{
    ///The subnet is enabled; the server will distribute addresses, extend leases, and release addresses within the
    ///subnet range to clients.
    DhcpSubnetEnabled          = 0x00000000,
    ///The subnet is disabled; the server will not distribute addresses or extend leases within the subnet range to
    ///clients. However, the server will still release addresses within the subnet range.
    DhcpSubnetDisabled         = 0x00000001,
    ///The subnet is enabled; the server will distribute addresses, extend leases, and release addresses within the
    ///subnet range to clients. The default gateway is set to the local machine itself.
    DhcpSubnetEnabledSwitched  = 0x00000002,
    ///The subnet is disabled; the server will not distribute addresses or extend leases within the subnet range to
    ///clients. However, the server will still release addresses within the subnet range. The default gateway is set to
    ///the local machine itself.
    DhcpSubnetDisabledSwitched = 0x00000003,
    ///The subnet is in an invalid state.
    DhcpSubnetInvalidState     = 0x00000004,
}

///The <b>DHCP_SUBNET_ELEMENT_TYPE</b> enumeration defines the set of possible subnet element types.
alias DHCP_SUBNET_ELEMENT_TYPE = int;
enum : int
{
    ///The subnet element contains the range of DHCP-served IP addresses.
    DhcpIpRanges          = 0x00000000,
    ///The subnet element contains the IP addresses of secondary DHCP hosts available in the subnet.
    DhcpSecondaryHosts    = 0x00000001,
    ///The subnet element contains the individual reserved IP addresses for the subnet.
    DhcpReservedIps       = 0x00000002,
    ///The subnet element contains the IP addresses excluded from the range of DHCP-served addresses.
    DhcpExcludedIpRanges  = 0x00000003,
    DhcpIpUsedClusters    = 0x00000004,
    ///The subnet element contains the IP addresses served by DHCP to the subnet (as opposed to those served by other
    ///dynamic address services, such as BOOTP).
    DhcpIpRangesDhcpOnly  = 0x00000005,
    ///The subnet element contains the IP addresses served by both DHCP and BOOTP to the subnet.
    DhcpIpRangesDhcpBootp = 0x00000006,
    ///The subnet element contains the IP addresses served by BOOTP to the subnet (specifically excluding DHCP-served
    ///addresses).
    DhcpIpRangesBootpOnly = 0x00000007,
}

///The <b>DHCP_FILTER_LIST_TYPE</b> enumeration specifies the types of filter lists available on the DHCP server.
alias DHCP_FILTER_LIST_TYPE = int;
enum : int
{
    ///The filter list is a deny list.
    Deny    = 0x00000000,
    ///The filter list is an allow list.
    Allow   = 0x00000001,
}

///The <b>DHCP_OPTION_DATA_TYPE</b> enumeration defines the set of formats that represent DHCP option data.
alias DHCP_OPTION_DATA_TYPE = int;
enum : int
{
    ///The option data is stored as a BYTE value.
    DhcpByteOption             = 0x00000000,
    ///The option data is stored as a WORD value.
    DhcpWordOption             = 0x00000001,
    ///The option data is stored as a DWORD value.
    DhcpDWordOption            = 0x00000002,
    ///The option data is stored as a DWORD_DWORD value.
    DhcpDWordDWordOption       = 0x00000003,
    ///The option data is an IP address, stored as a DHCP_IP_ADDRESS value (DWORD).
    DhcpIpAddressOption        = 0x00000004,
    ///The option data is stored as a Unicode string.
    DhcpStringDataOption       = 0x00000005,
    ///The option data is stored as a DHCP_BINARY_DATA structure.
    DhcpBinaryDataOption       = 0x00000006,
    ///The option data is encapsulated and stored as a DHCP_BINARY_DATA structure.
    DhcpEncapsulatedDataOption = 0x00000007,
    ///The option data is stored as a Unicode string.
    DhcpIpv6AddressOption      = 0x00000008,
}

///The <b>DHCP_OPTION_TYPE</b> enumeration defines the set of possible DHCP option types.
alias DHCP_OPTION_TYPE = int;
enum : int
{
    ///The option has a single data item associated with it.
    DhcpUnaryElementTypeOption = 0x00000000,
    ///The option is an array of data items associated with it.
    DhcpArrayTypeOption        = 0x00000001,
}

///The <b>DHCP_OPTION_SCOPE_TYPE</b> enumeration defines the set of possible DHCP option scopes.
alias DHCP_OPTION_SCOPE_TYPE = int;
enum : int
{
    ///The DHCP options correspond to the default scope.
    DhcpDefaultOptions  = 0x00000000,
    ///The DHCP options correspond to the global scope.
    DhcpGlobalOptions   = 0x00000001,
    ///The DHCP options correspond to a specific subnet scope.
    DhcpSubnetOptions   = 0x00000002,
    ///The DHCP options correspond to a reserved IP address.
    DhcpReservedOptions = 0x00000003,
    ///The DHCP options correspond to a multicast scope.
    DhcpMScopeOptions   = 0x00000004,
}

///The DHCP_OPTION_SCOPE_TYPE6 enumeration defines the set of possible scopes for DHCP options.
alias DHCP_OPTION_SCOPE_TYPE6 = int;
enum : int
{
    ///The default set of DHCP options are selected.
    DhcpDefaultOptions6  = 0x00000000,
    ///Only DHCP options defined for this scope are selected.
    DhcpScopeOptions6    = 0x00000001,
    ///Only the reserved set of DHCP options are selected.
    DhcpReservedOptions6 = 0x00000002,
    DhcpGlobalOptions6   = 0x00000003,
}

///The <b>QuarantineStatus</b> enumeration specifies possible health status values for the DHCPv4 client, as validated
///at the NAP server.
enum QuarantineStatus : int
{
    ///The DHCP client is compliant with the health policies defined by the administrator and has normal access to the
    ///network.
    NOQUARANTINE       = 0x00000000,
    ///The DHCP client is not compliant with the health policies defined by the administrator and is being quarantined
    ///with restricted access to the network.
    RESTRICTEDACCESS   = 0x00000001,
    ///The DHCP client is not compliant with the health policies defined by the administrator and is being denied access
    ///to the network. The DHCP server does not grant an IP address lease to this client.
    DROPPACKET         = 0x00000002,
    ///The DHCP client is not compliant with the health policies defined by the administrator and is being granted
    ///normal access to the network for a limited time.
    PROBATION          = 0x00000003,
    ///The DHCP client is exempt from compliance with the health policies defined by the administrator and is granted
    ///normal access to the network.
    EXEMPT             = 0x00000004,
    ///The DHCP client is put into the default quarantine state configured on the DHCP NAP server. When a network policy
    ///server (NPS) is unavailable, the DHCP client can be put in any of the states NOQUARANTINE, RESTRICTEDACCESS, or
    ///DROPPACKET, depending on the default setting on the DHCP NAP server.
    DEFAULTQUARSETTING = 0x00000005,
    ///No quarantine.
    NOQUARINFO         = 0x00000006,
}

///The <b>DHCP_SEARCH_INFO_TYPE</b> enumeration defines the set of possible attributes used to search DHCP client
///information records.
alias DHCP_SEARCH_INFO_TYPE = int;
enum : int
{
    ///The search will be performed against the assigned DHCP client IP address, represented as a 32-bit unsigned
    ///integer value.
    DhcpClientIpAddress       = 0x00000000,
    ///The search will be performed against the MAC address of the DHCP client network interface device, represented as
    ///a DHCP_BINARY_DATA structure.
    DhcpClientHardwareAddress = 0x00000001,
    ///The search will be performed against the DHCP client's network name, represented as a Unicode string.
    DhcpClientName            = 0x00000002,
}

alias DHCP_PROPERTY_TYPE = int;
enum : int
{
    DhcpPropTypeByte   = 0x00000000,
    DhcpPropTypeWord   = 0x00000001,
    DhcpPropTypeDword  = 0x00000002,
    DhcpPropTypeString = 0x00000003,
    DhcpPropTypeBinary = 0x00000004,
}

alias DHCP_PROPERTY_ID = int;
enum : int
{
    DhcpPropIdPolicyDnsSuffix      = 0x00000000,
    DhcpPropIdClientAddressStateEx = 0x00000001,
}

///The <b>DHCP_SCAN_FLAG</b> enumeration defines the set of possible targets of synchronization during a database scan
///operation.
alias DHCP_SCAN_FLAG = int;
enum : int
{
    ///Indicates that the in-memory client lease cache on the DHCPv4 server does not contain the client lease IP
    ///address, but the DHCPv4 client lease database does contain it. (Note that this enumeration does not inform
    ///DhcpScanDatabase to perform a registry operation despite the name.) Any reconciliation process should update the
    ///in-memory cache.
    DhcpRegistryFix = 0x00000000,
    ///Indicates that the client lease database on the DHCPv4 server does not contain the client lease IP address, but
    ///the in-memory cache of client leases does contain it. Any reconciliation process should update the database.
    DhcpDatabaseFix = 0x00000001,
}

alias DHCP_SUBNET_ELEMENT_TYPE_V6 = int;
enum : int
{
    Dhcpv6IpRanges         = 0x00000000,
    Dhcpv6ReservedIps      = 0x00000001,
    Dhcpv6ExcludedIpRanges = 0x00000002,
}

///The <b>DHCP_SEARCH_INFO_TYPE_V6</b> enumeration defines the set of possible attributes used to search DHCPv6 client
///information records.
alias DHCP_SEARCH_INFO_TYPE_V6 = int;
enum : int
{
    ///The search will be performed against the assigned DHCPv6 client IPv6 address.
    Dhcpv6ClientIpAddress = 0x00000000,
    ///The search will be performed against the DHCPv6 client's DHCP unique ID, represented as a GUID.
    Dhcpv6ClientDUID      = 0x00000001,
    Dhcpv6ClientName      = 0x00000002,
}

///The <b>DHCP_POL_ATTR_TYPE</b> enumeration defines the attribute type for a condition in a DHCP server policy.
alias DHCP_POL_ATTR_TYPE = int;
enum : int
{
    ///The condition is based on the hardware address (MAC address) present in the <b>chaddr</b> field of the DHCP
    ///message header as defined in RFC2131.
    DhcpAttrHWAddr          = 0x00000000,
    ///The condition is based on a DHCP option.
    DhcpAttrOption          = 0x00000001,
    ///The condition is based on a DHCP sub-option
    DhcpAttrSubOption       = 0x00000002,
    DhcpAttrFqdn            = 0x00000003,
    DhcpAttrFqdnSingleLabel = 0x00000004,
}

///The <b>DHCP_POL_COMPARATOR</b> enumeration defines the comparison operator for a condition when building a DHCP
///server policy.
alias DHCP_POL_COMPARATOR = int;
enum : int
{
    ///The DHCP client message field specified by the criterion must exactly match the value supplied in the condition.
    DhcpCompEqual        = 0x00000000,
    ///The DHCP client message field specified by the criterion must not exactly match the value supplied in the
    ///condition.
    DhcpCompNotEqual     = 0x00000001,
    ///The DHCP client message field specified by the criterion must begin with the value supplied in the condition.
    DhcpCompBeginsWith   = 0x00000002,
    ///The DHCP client message field specified by the criterion must not begin with the value supplied in the condition.
    DhcpCompNotBeginWith = 0x00000003,
    DhcpCompEndsWith     = 0x00000004,
    DhcpCompNotEndWith   = 0x00000005,
}

///The <b>DHCP_POL_LOGIC_OPER</b> enumeration defines how to group the constituent conditions and sub-expressions of an
///expression in a DHCP server policy.
alias DHCP_POL_LOGIC_OPER = int;
enum : int
{
    ///The results of the constituent conditions and sub-expressions must be logically ORed to evaluate the expression.
    DhcpLogicalOr  = 0x00000000,
    ///The results of the constituent conditions and sub-expressions must be logically ANDed to evaluate the expression.
    DhcpLogicalAnd = 0x00000001,
}

///The <b>DHCP_POLICY_FIELDS_TO_UPDATE</b> enumeration defines which properties of a DHCP server policy must be updated.
alias DHCP_POLICY_FIELDS_TO_UPDATE = int;
enum : int
{
    ///Update DHCP server policy name.
    DhcpUpdatePolicyName      = 0x00000001,
    ///Update DHCP server policy order.
    DhcpUpdatePolicyOrder     = 0x00000002,
    ///Update DHCP server policy expression.
    DhcpUpdatePolicyExpr      = 0x00000004,
    ///Update DHCP server policy ranges.
    DhcpUpdatePolicyRanges    = 0x00000008,
    ///Update DHCP server policy description.
    DhcpUpdatePolicyDescr     = 0x00000010,
    ///Update DHCP server policy enabled/disabled status.
    DhcpUpdatePolicyStatus    = 0x00000020,
    DhcpUpdatePolicyDnsSuffix = 0x00000040,
}

///The <b>DHCPV6_STATELESS_PARAM_TYPE</b> enumeration defines a DHCPv6 stateless client inventory configuration
///parameter type.
alias DHCPV6_STATELESS_PARAM_TYPE = int;
enum : int
{
    ///The parameter type is the purge interval for client lease records from the DHCP server database.
    DhcpStatelessPurgeInterval = 0x00000001,
    ///The parameter type is the client inventory enabled/disabled status in the DHCP server database.
    DhcpStatelessStatus        = 0x00000002,
}

///The <b>DHCP_FAILOVER_MODE</b> enumeration defines the DHCPv4 server mode operation in a failover relationship.
alias DHCP_FAILOVER_MODE = int;
enum : int
{
    ///The DHCPv4 server failover relationship is in <i>Load Balancing</i> mode.
    LoadBalance = 0x00000000,
    ///The DHCPv4 server failover relationship is in <i>Hot Standby</i> mode.
    HotStandby  = 0x00000001,
}

///The <b>DHCP_FAILOVER_SERVER</b> enumeration defines whether the DHCP server is the primary or secondary server in a
///DHCPv4 failover relationship.
alias DHCP_FAILOVER_SERVER = int;
enum : int
{
    ///The server is a primary server in the failover relationship.
    PrimaryServer   = 0x00000000,
    ///The server is a secondary server in the failover relationship.
    SecondaryServer = 0x00000001,
}

///The <b>FSM_STATE</b> enumeration defines the set of possible failover relationship states on a DHCPv4 server.
alias FSM_STATE = int;
enum : int
{
    ///Indicates that no state is configured for the DHCPv4 failover relationship.
    NO_STATE           = 0x00000000,
    ///Indicates that the failover relationship on the DHCPv4 server is in the initialization state.
    INIT               = 0x00000001,
    ///Indicates that each server participating in the failover relationship can probe its partner server before
    ///starting the DHCP client service. A DHCPv4 server moves into the <b>STARTUP</b> state after <b>INIT</b>.
    STARTUP            = 0x00000002,
    ///Indicates that each server in the failover relationship can service <i>DHCPDISCOVER</i> messages and all other
    ///DHCP requests as defined in RFC2131. DHCPv4 servers in the <b>NORMAL</b> state can not service
    ///<i>DHCPREQUEST/RENEWAL</i> or <i>DHCPREQUEST/REBINDING</i> requests from the client set defined according to the
    ///load balancing algorithm in RFC3074. However, each server can service <i>DHCPREQUEST/RENEWAL</i> or
    ///<i>DHCPDISCOVER/REBINDING</i> requests from any client.
    NORMAL             = 0x00000003,
    ///Indicates that each server in a failover relationship is operating independently, but neither assumes that their
    ///partner is not operating. The partner server might be operating and simply unable to communicate with this
    ///server, or it might not be operating at all.
    COMMUNICATION_INT  = 0x00000004,
    ///Indicates that a server assumes its partner is not currently operating.
    PARTNER_DOWN       = 0x00000005,
    ///Indicates that a failover relationship between two DHCPv4 servers is attempting to reestablish itself.
    POTENTIAL_CONFLICT = 0x00000006,
    ///Indicates that the primary server has received all updates from the secondary server during the failover
    ///relationship reintegration process.
    CONFLICT_DONE      = 0x00000007,
    ///Indicates that two servers in the <b>POTENTIAL_CONFLICT</b> state were attempting to reintegrate their failover
    ///relationship with each other, but communications between them failed prior to completion of the reintegration.
    RESOLUTION_INT     = 0x00000008,
    ///Indicates that a server in a failover relationship has no information in its stable storage facility or that it
    ///is reintegrating with a server in the <b>PARTNER_DOWN</b> state.
    RECOVER            = 0x00000009,
    ///Indicates that the DHCPv4 server should wait for a time period equal to Maximum Client Lead Time (MCLT) before
    ///moving to the <b>RECOVER_DONE</b> state. The MCLT is the maximum time, in seconds, that one server can extend a
    ///lease for a client beyond the lease time known by the partner server.
    RECOVER_WAIT       = 0x0000000a,
    ///This value enables an interlocked transition of one server from the <b>RECOVER</b> state and another server from
    ///the <b>PARTNER_DOWN</b> or <b>COMMUNICATION-INT</b> state to the <b>NORMAL</b> state.
    RECOVER_DONE       = 0x0000000b,
    ///Reserved. Do not use.
    PAUSED             = 0x0000000c,
    ///Reserved. Do not use.
    SHUTDOWN           = 0x0000000d,
}

// Callbacks

///The <b>DhcpControlHook</b> function is called by Microsoft DHCP Server when the DHCP Server service is started,
///stopped, paused, or continued. The <b>DhcpControlHook</b> is implemented by a third-party DLL that registers for
///notification of significant Microsoft DHCP Server events. The <b>DhcpControlHook</b> function should not block.
///Params:
///    dwControlCode = Specifies the control event that triggered the notification. This parameter will be one of the following: <ul>
///                    <li>DHCP_CONTROL_START</li> <li>DHCP_CONTROL_STOP</li> <li>DHCP_CONTROL_PAUSE</li> <li>DHCP_CONTROL_CONTINUE</li>
///                    </ul>
///    lpReserved = Reserved for future use.
///Returns:
///    Return values are defined by the application providing the callback.
///    
alias LPDHCP_CONTROL = uint function(uint dwControlCode, void* lpReserved);
///The <b>DhcpNewPktHook</b> function is called by Microsoft DHCP Server shortly after it receives a DHCP packet slated
///for processing. Since the <b>DhcpNewPktHook</b> function call is in the critical path for Microsoft DHCP Server
///processing, this function should execute and return as quickly as possible or performance will be impacted. The
///<b>DhcpNewPktHook</b> function is implemented by a third-party DLL that registers for notification of significant
///Microsoft DHCP Server events.
///Params:
///    Packet = Pointer to a 4Kb character buffer that contains the packet. <div class="alert"><b>Note</b> Writing to this buffer
///             directly is not recommended.</div> <div> </div>
///    PacketSize = Pointer to the size of the <i>Packet</i> parameter.
///    IpAddress = Pointer to the IP address of the socket on which the packet was received. The IP address is in host order.
///    Reserved = Reserved for future use.
///    PktContext = Pointer provided by the third-party DLL, and used by Microsoft DHCP Server in future references to this specific
///                 packet. Third-party DLLs interested in such tracking are responsible for providing and tracking this packet
///                 context.
///    ProcessIt = Flag identifying whether Microsoft DHCP Server should continue processing the packet. Set to <b>TRUE</b> to
///                indicate processing should proceed. Set to <b>FALSE</b> to have Microsoft DHCP Server drop the packet.
///Returns:
///    Return values are defined by the application providing the callback.
///    
alias LPDHCP_NEWPKT = uint function(ubyte** Packet, uint* PacketSize, uint IpAddress, void* Reserved, 
                                    void** PktContext, int* ProcessIt);
///Params:
///    Packet = Pointer to a buffer, 4Kb in size, that contains the packet. <div class="alert"><b>Note</b> Writing to this buffer
///             directly is not recommended.</div> <div> </div>
///    PacketSize = Pointer to the size of the <i>Packet</i> parameter, in bytes.
///    ControlCode = Control code that specifies the reason for dropping. See Remarks.
///    IpAddress = Internet Protocol (IP) address of the socket on which the packet was received. The IP address is in host order.
///    Reserved = Reserved for future use.
///    PktContext = Context identifying the packet, as provided in the <i>PktContext</i> parameter of a previous DhcpNewPktHook
///                 function call.
///Returns:
///    Return values are defined by the application providing the callback.
///    
alias LPDHCP_DROP_SEND = uint function(ubyte** Packet, uint* PacketSize, uint ControlCode, uint IpAddress, 
                                       void* Reserved, void* PktContext);
///The <b>DhcpAddressDelHook</b> function is called by Microsoft DHCP Server when one of the following four defined
///events occurs: <ul> <li>DHCP_PROB_CONFLICT</li> <li>DHCP_PROB_DECLINE</li> <li>DHCP_PROB_RELEASE</li>
///<li>DHCP_PROB_NACKED</li> </ul>See Remarks for more information on these events. The <b>DhcpAddressDelHook</b>
///function is implemented by a third-party DLL that registers for notification of significant Microsoft DHCP Server
///events. The <b>DhcpAddressDelHook</b> function should not block.
///Params:
///    Packet = Buffer for the packet being processed.
///    PacketSize = Size of the <i>Packet</i> parameter, in bytes.
///    ControlCode = Specifies the event. See Remarks for control code definitions.
///    IpAddress = Internet Protocol (IP) address of the socket on which the packet was received. The IP address is in host order.
///    AltAddress = Internet Protocol (IP) address used to provide additional information about the event. The meaning of
///                 <i>AltAddress</i> varies based on the value of <i>ControlCode</i>. See Remarks.
///    Reserved = Reserve for future use.
///    PktContext = Context identifying the packet, as provided in the <i>PktContext</i> parameter of a previous DhcpNewPktHook
///                 function call.
///Returns:
///    Return values are defined by the application providing the callback.
///    
alias LPDHCP_PROB = uint function(ubyte* Packet, uint PacketSize, uint ControlCode, uint IpAddress, 
                                  uint AltAddress, void* Reserved, void* PktContext);
///The <b>DhcpAddressOfferHook</b> function is called by Microsoft DHCP Server directly before Microsoft DHCP Server
///sends an acknowledgement (ACK) to a DHCP REQUEST message. The <b>DhcpAddressOfferHook</b> is implemented by a
///third-party DLL that registers for notification of significant Microsoft DHCP Server events. The
///<b>DhcpAddressOfferHook</b> function should not block.
///Params:
///    Packet = Buffer for the packet being processed.
///    PacketSize = Size of the <i>Packet</i> parameter, in bytes.
///    ControlCode = Specifies the type of lease being approved. If the acknowledgement is for a new lease, <i>ControlCode</i> is
///                  DHCP_GIVE_ADDRESS_NEW. If the acknowledgement is for the renewal of an existing lease, <i>ControlCode</i> is
///                  DHCP_GIVE_ADDRESS_OLD.
///    IpAddress = Internet Protocol (IP) address of the socket on which the packet was received. The IP address is in host order.
///    AltAddress = Internet Protocol (IP) address being handed out in the lease.
///    AddrType = Specifies whether the address is a DHCP or BOOTP address. The default value is DHCP_CLIENT_DHCP. <table> <tr>
///               <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DHCP_CLIENT_DHCP_"></a><a
///               id="dhcp_client_dhcp_"></a><dl> <dt><b>DHCP_CLIENT_DHCP </b></dt> </dl> </td> <td width="60%"> The address is a
///               DHCP-served address. </td> </tr> <tr> <td width="40%"><a id="DHCP_CLIENT_BOOTP_"></a><a
///               id="dhcp_client_bootp_"></a><dl> <dt><b>DHCP_CLIENT_BOOTP </b></dt> </dl> </td> <td width="60%"> The address is a
///               BOOTP-served address. </td> </tr> </table>
///    LeaseTime = Lease duration being passed, in seconds.
///    Reserved = Reserve for future use.
///    PktContext = Context identifying the packet, as provided in the <i>PktContext</i> parameter of a previous DhcpNewPktHook
///                 function call.
///Returns:
///    Return values are defined by the application providing the callback.
///    
alias LPDHCP_GIVE_ADDRESS = uint function(ubyte* Packet, uint PacketSize, uint ControlCode, uint IpAddress, 
                                          uint AltAddress, uint AddrType, uint LeaseTime, void* Reserved, 
                                          void* PktContext);
///The <i>DhcpHandleOptionsHook</i> function enables third-party DLLs to obtain commonly used options from a DHCP
///packet, avoiding the need to process the entire DHCP packet. The <i>DhcpHandleOptionsHook</i> function should not
///block.
///Params:
///    Packet = Buffer for the packet being processed.
///    PacketSize = Size of the <i>Packet</i> parameter, in bytes.
///    Reserved = Reserve for future use.
///    PktContext = Context identifying the packet, as provided in the <i>PktContext</i> parameter of a previous DhcpNewPktHook
///                 function call.
///    ServerOptions = Structure of type DHCP_SERVER_OPTIONS containing the information parsed from the packet by Microsoft DHCP Server,
///                    and provided as the collection of commonly used server options.
///Returns:
///    Return values are defined by the application providing the callback.
///    
alias LPDHCP_HANDLE_OPTIONS = uint function(ubyte* Packet, uint PacketSize, void* Reserved, void* PktContext, 
                                            DHCP_SERVER_OPTIONS* ServerOptions);
///The <b>DhcpDeleteClientHook</b> function is called by Microsoft DHCP Server directly before a client lease is deleted
///from the active leases database. The <b>DhcpDeleteClientHook</b> function should not block.
///Params:
///    IpAddress = Internet Protocol (IP) address of the client lease being deleted. The IP address is in host order.
///    HwAddress = Buffer holding the Hardware address of the client, often referred to as the MAC address.
///    HwAddressLength = Length of the <i>HwAddress</i> buffer, in bytes.
///    Reserved = Reserved for future use.
///    ClientType = Reserved for future use.
///Returns:
///    Return values are defined by the application providing the callback.
///    
alias LPDHCP_DELETE_CLIENT = uint function(uint IpAddress, ubyte* HwAddress, uint HwAddressLength, uint Reserved, 
                                           uint ClientType);
///The <b>DhcpServerCalloutEntry</b> function is called by Microsoft DHCP Server to initialize a third-party DLL, and to
///discover for which events the third-party DLL wants notification. The <b>DhcpServerCalloutEntry</b> function is
///implemented by third-party DLLs.
///Params:
///    ChainDlls = Collection of remaining third-party DLLs that provided registry entries requesting notification of DHCP Server
///                events, in REG_MULTI_SZ format.
///    CalloutVersion = Version of the DHCP Server API that the third-party DLL is expected to support. The current version number is
///                     zero.
///    CalloutTbl = Cumulative set of notification hooks requested by all third-party DLLs, in the form of a DHCP_CALLOUT_TABLE
///                 structure.
///Returns:
///    Return values are defined by the application providing the callback.
///    
alias LPDHCP_ENTRY_POINT_FUNC = uint function(PWSTR ChainDlls, uint CalloutVersion, DHCP_CALLOUT_TABLE* CalloutTbl);

// Structs


///A <b>DHCPV6CAPI_PARAMS</b> structure contains a requested parameter.
struct DHCPV6CAPI_PARAMS
{
    ///Reserved for future use.
    uint   Flags;
    ///Identifier for the DHCPv6 parameter being requested. <a id="DHCPV6_OPTION_CLIENTID"></a> <a
    ///id="dhcpv6_option_clientid"></a>
    uint   OptionId;
    ///This option is set to <b>TRUE</b> if this parameter is vendor-specific. Otherwise, it is <b>FALSE</b>.
    BOOL   IsVendor;
    ///Contains the actual parameter data.
    ubyte* Data;
    uint   nBytesData;
}

///The <b>DHCPV6CAPI_PARAMS_ARRAY</b> structure contains an array of requested parameters.
struct DHCPV6CAPI_PARAMS_ARRAY
{
    ///Number of parameters in the array.
    uint               nParams;
    DHCPV6CAPI_PARAMS* Params;
}

///The <b>DHCPV6CAPI_CLASSID</b> structure defines an IPv6 client class ID.
struct DHCPV6CAPI_CLASSID
{
    ///Reserved for future use. Must be set to 0.
    uint   Flags;
    ubyte* Data;
    uint   nBytesData;
}

///The <b>DHCPV6Prefix</b> contains an IPv6 prefix.
struct DHCPV6Prefix
{
    ///128 bit prefix.
    ubyte[16]  prefix;
    ///Length of the prefix.
    uint       prefixLength;
    ///Preferred lifetime of the prefix, in seconds.
    uint       preferredLifeTime;
    ///The valid lifetime of the prefix in seconds.
    uint       validLifeTime;
    StatusCode status;
}

///The <b>DHCPV6PrefixLeaseInformation</b> structure contains information about a prefix lease.
struct DHCPV6PrefixLeaseInformation
{
    ///Number of prefixes.
    uint          nPrefixes;
    ///Pointer to a list DHCPV6Prefix structures that contain the prefixes requested or returned by the server.
    DHCPV6Prefix* prefixArray;
    ///Identity Association identifier for the prefix operation.
    uint          iaid;
    ///The renewal time for the prefix, in seconds.
    long          T1;
    ///The rebind time of the prefix, in seconds.
    long          T2;
    ///The maximum lease expiration time of all the prefix leases in this structure.
    long          MaxLeaseExpirationTime;
    ///The time at which the last renewal for the prefixes occurred.
    long          LastRenewalTime;
    ///Status code returned by the server for the IAPD. The following codes can be returned by the DHCP server for
    ///prefix delegation scenarios: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="STATUS_NO_ERROR"></a><a id="status_no_error"></a><dl> <dt><b>STATUS_NO_ERROR</b></dt> <dt>0</dt> </dl> </td>
    ///<td width="60%"> The prefix was successfully leased or renewed. </td> </tr> <tr> <td width="40%"><a
    ///id="STATUS_UNSPECIFIED_FAILURE"></a><a id="status_unspecified_failure"></a><dl>
    ///<dt><b>STATUS_UNSPECIFIED_FAILURE</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The lease or renewal action
    ///failed for an unspecified reason. </td> </tr> <tr> <td width="40%"><a id="STATUS_NO_BINDING"></a><a
    ///id="status_no_binding"></a><dl> <dt><b>STATUS_NO_BINDING</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> The
    ///DHCPv6 server does not have a binding for the prefix. </td> </tr> <tr> <td width="40%"><a
    ///id="STATUS_NOPREFIX_AVAIL"></a><a id="status_noprefix_avail"></a><dl> <dt><b>STATUS_NOPREFIX_AVAIL</b></dt>
    ///<dt>6</dt> </dl> </td> <td width="60%"> The DHCPv6 server does not have a prefix availble to offer the requesting
    ///client. </td> </tr> </table>
    StatusCode    status;
    ///The server DUID from which the prefix is received. This data is used in subsequent renews.
    ubyte*        ServerId;
    ///The length of the above DUID data.
    uint          ServerIdLen;
}

///The <b>DHCPAPI_PARAMS</b> structure is used to request DHCP parameters.
struct DHCPAPI_PARAMS
{
    ///Reserved. Must be set to zero.
    uint   Flags;
    ///Identifier for the DHCP parameter being requested.
    uint   OptionId;
    ///Specifies whether the DHCP parameter is vendor-specific. Set to <b>TRUE</b> if the parameter is vendor-specific.
    BOOL   IsVendor;
    ubyte* Data;
    ///Size of the data pointed to by <b>Data</b>, in bytes.
    uint   nBytesData;
}

///The <b>DHCPCAPI_PARAMS_ARRAY</b> structure stores an array of DHCPAPI_PARAMS structures used to query DHCP
///parameters.
struct DHCPCAPI_PARAMS_ARRAY
{
    ///Number of elements in the <b>Params</b> array.
    uint            nParams;
    DHCPAPI_PARAMS* Params;
}

///The <b>DHCPCAPI_CLASSID</b> structure defines a client Class ID.
struct DHCPCAPI_CLASSID
{
    ///Reserved. Must be set to zero.
    uint   Flags;
    ubyte* Data;
    uint   nBytesData;
}

///The <b>DHCP_SERVER_OPTIONS</b> structure specifies requested DHCP Server options.
struct DHCP_SERVER_OPTIONS
{
    ///DHCP message type.
    ubyte* MessageType;
    ///Subnet mask.
    uint*  SubnetMask;
    ///Requested IP address.
    uint*  RequestedAddress;
    ///Requested duration of the IP address lease, in seconds.
    uint*  RequestLeaseTime;
    ///Overlay fields to apply to the request.
    ubyte* OverlayFields;
    ///IP address of the default gateway.
    uint*  RouterAddress;
    ///IP address of the DHCP Server.
    uint*  Server;
    ///List of requested parameters.
    ubyte* ParameterRequestList;
    ///Length of <i>ParameterRequestList</i>, in bytes.
    uint   ParameterRequestListLength;
    ///Machine name (host name) of the computer making the request.
    byte*  MachineName;
    ///Length of <i>MachineName</i>, in bytes.
    uint   MachineNameLength;
    ///Type of hardware address expressed in <i>ClientHardwareAddress</i>.
    ubyte  ClientHardwareAddressType;
    ///Length of <i>ClientHardwareAddress</i>, in bytes.
    ubyte  ClientHardwareAddressLength;
    ///Client hardware address.
    ubyte* ClientHardwareAddress;
    ///Class identifier for the client.
    byte*  ClassIdentifier;
    ///Length of <i>ClassIdentifier</i>, in bytes.
    uint   ClassIdentifierLength;
    ///Vendor class, if applicable.
    ubyte* VendorClass;
    ///Length of <i>VendorClass</i>, in bytes.
    uint   VendorClassLength;
    ///Flags used for DNS.
    uint   DNSFlags;
    ///Length of <i>DNSName</i>, in bytes.
    uint   DNSNameLength;
    ///Pointer to the DNS name.
    ubyte* DNSName;
    ///Specifies whether the domain name is requested.
    ubyte  DSDomainNameRequested;
    ///Pointer to the domain name.
    byte*  DSDomainName;
    ///Length of <i>DSDomainName</i>, in characters.
    uint   DSDomainNameLen;
    uint*  ScopeId;
}

///The <b>DHCP_CALLOUT_TABLE</b> structure is used by Microsoft DHCP Server and third-party DLLs to send notification
///requests for DHCP Server events.
struct DHCP_CALLOUT_TABLE
{
    ///Pointer to a DhcpControlHook function, implemented in a third-party DLL, to be called when Microsoft DHCP Server
    ///is started, stopped, paused, or continued. Set to <b>NULL</b> if notification is not required.
    LPDHCP_CONTROL       DhcpControlHook;
    ///Pointer to a DhcpNewPktHook function, implemented in a third-party DLL, to be called when Microsoft DHCP Server
    ///receives a packet that it attempts to process. Set to <b>NULL</b> if notification is not required.
    LPDHCP_NEWPKT        DhcpNewPktHook;
    ///Pointer to a DhcpPktDropHook function, implemented in a third-party DLL, to be called when Microsoft DHCP Server
    ///drops a packet, and when a packet is completely processed by Microsoft DHCP Server. Set to <b>NULL</b> if
    ///notification is not required.
    LPDHCP_DROP_SEND     DhcpPktDropHook;
    ///Pointer to a DhcpPktSendHook function, implemented in a third-party DLL, to be called directly before Microsoft
    ///DHCP Server submits a response to a client inquiry. Set to <b>NULL</b> if notification is not required.
    LPDHCP_DROP_SEND     DhcpPktSendHook;
    ///Pointer to a DhcpAddressDelHook function, implemented in a third-party DLL, to be called when a specified event
    ///in Microsoft DHCP Server results in a packet being dropped. Set to <b>NULL</b> if notification is not required.
    LPDHCP_PROB          DhcpAddressDelHook;
    ///Pointer to a DhcpAddressOfferHook function, implemented in a third-party DLL, to be called directly before
    ///Microsoft DHCP Server submits a DHCP ACK message in response to a DHCP REQUEST message. Set to <b>NULL</b> if
    ///notification is not required.
    LPDHCP_GIVE_ADDRESS  DhcpAddressOfferHook;
    ///Pointer to a DhcpHandleOptionsHook function, implemented in a third-party DLL, that sends only parsed DHCP
    ///information to the third-party DLL, enabling the third-party DLL to avoid processing the entire DHCP packet. Set
    ///to <b>NULL</b> if notification is not required.
    LPDHCP_HANDLE_OPTIONS DhcpHandleOptionsHook;
    ///Pointer to a DhcpDeleteClientHook function, implemented in a third-party DLL, to be called directly before
    ///Microsoft DHCP Server deletes a client lease from its active leases database. Set to <b>NULL</b> if notification
    ///is not required.
    LPDHCP_DELETE_CLIENT DhcpDeleteClientHook;
    ///Reserved for future use.
    void*                DhcpExtensionHook;
    ///Reserved for future use.
    void*                DhcpReservedHook;
}

///The <b>DATE_TIME</b> structure defines a 64-bit integer value that contains a date/time, expressed as the number of
///ticks (100-nanosecond increments) since 12:00 midnight, January 1, 1 C.E. in the Gregorian calendar.
struct DATE_TIME
{
    ///Specifies the lower 32 bits of the time value.
    uint dwLowDateTime;
    ///Specifies the upper 32 bits of the time value.
    uint dwHighDateTime;
}

///The <b>DHCP_IP_RANGE</b> structure defines a range of IP addresses.
struct DHCP_IP_RANGE
{
    ///DHCP_IP_ADDRESS value that contains the first IP address in the range.
    uint StartAddress;
    uint EndAddress;
}

///The <b>DHCP_BINARY_DATA</b> structure defines an opaque blob of binary data.
struct DHCP_BINARY_DATA
{
    ///Specifies the size of <b>Data</b>, in bytes.
    uint   DataLength;
    ///Pointer to an opaque blob of byte (binary) data. The data is formatted as follows: <table> <tr> <th>Byte</th>
    ///<th>Format</th> </tr> <tr> <td>Byte 0 to byte 3 </td> <td>The result of a binary AND on the IP address and the
    ///subnet mask in reverse order.</td> </tr> <tr> <td>Byte 4</td> <td>Hardware identifier. This value is always
    ///0x01.</td> </tr> <tr> <td>Byte 5 to Byte 10 </td> <td>The MAC address of the client.</td> </tr> </table>
    ubyte* Data;
}

///The <b>DHCP_HOST_INFO</b> structure defines information on a DHCP server (host).
struct DHCP_HOST_INFO
{
    ///DHCP_IP_ADDRESS value that contains the IP address of the DHCP server.
    uint  IpAddress;
    ///Unicode string that contains the NetBIOS name of the DHCP server.
    PWSTR NetBiosName;
    ///Unicode string that contains the network name of the DHCP server.
    PWSTR HostName;
}

///The <b>DWORD_DWORD</b> structure defines a 64-bit integer value.
struct DWORD_DWORD
{
    ///Specifies the upper 32 bits of the value.
    uint DWord1;
    ///Specifies the lower 32 bits of the value.
    uint DWord2;
}

///The <b>DHCP_SUBNET_INFO</b> structure defines information describing a subnet.
struct DHCP_SUBNET_INFO
{
    ///DHCP_IP_ADDRESS value that specifies the subnet ID.
    uint              SubnetAddress;
    ///DHCP_IP_MASK value that specifies the subnet IP mask.
    uint              SubnetMask;
    ///Unicode string that specifies the network name of the subnet.
    PWSTR             SubnetName;
    ///Unicode string that contains an optional comment particular to this subnet.
    PWSTR             SubnetComment;
    ///DHCP_HOST_INFO structure that contains information about the DHCP server servicing this subnet.
    DHCP_HOST_INFO    PrimaryHost;
    ///DHCP_SUBNET_STATE enumeration value indicating the current state of the subnet (enabled/disabled).
    DHCP_SUBNET_STATE SubnetState;
}

///The <b>DHCP_SUBNET_INFO_VQ</b> structure defines information that describes a subnet.
struct DHCP_SUBNET_INFO_VQ
{
    ///DHCP_IP_ADDRESS value that specifies the subnet ID.
    uint              SubnetAddress;
    ///DHCP_IP_MASK value that specifies the subnet IP mask.
    uint              SubnetMask;
    ///Pointer to a Unicode string that specifies the network name of the subnet.
    PWSTR             SubnetName;
    ///Pointer to a Unicode string that contains an optional comment particular to this subnet.
    PWSTR             SubnetComment;
    ///DHCP_HOST_INFO structure that contains information about the DHCP server servicing this subnet.
    DHCP_HOST_INFO    PrimaryHost;
    ///DHCP_SUBNET_STATE enumeration value indicating the current state of the subnet (enabled/disabled).
    DHCP_SUBNET_STATE SubnetState;
    ///Integer value used as a BOOL to represent whether or not Quarantine is enabled for the subnet. If <b>TRUE</b>
    ///(0x00000001), Quarantine is turned ON on the DHCP server; if <b>FALSE</b> (0x00000000), it is turned OFF.
    uint              QuarantineOn;
    ///Reserved for future use.
    uint              Reserved1;
    ///Reserved for future use.
    uint              Reserved2;
    ///Reserved for future use.
    long              Reserved3;
    long              Reserved4;
}

///The <b>DHCP_IP_ARRAY</b> structure defines an array of IP addresses.
struct DHCP_IP_ARRAY
{
    ///Specifies the number of IP addresses in <b>Elements</b>.
    uint  NumElements;
    ///Pointer to a list of DHCP_IP_ADDRESS values.
    uint* Elements;
}

///The <b>DHCP_IP_CLUSTER</b> structure defines the address and mast for a network cluster.
struct DHCP_IP_CLUSTER
{
    ///DHCP_IP_ADDRESS value that contains the IP address of the cluster.
    uint ClusterAddress;
    uint ClusterMask;
}

///The <b>DHCP_IP_RESERVATION</b> structure defines a client IP reservation.
struct DHCP_IP_RESERVATION
{
    ///DHCP_IP_ADDRESS value that contains the reserved IP address.
    uint              ReservedIpAddress;
    ///DHCP_CLIENT_UID structure that contains information on the client holding this IP reservation.
    DHCP_BINARY_DATA* ReservedForClient;
}

///The <b>DHCP_SUBNET_ELEMENT_DATA</b> structure defines an element that describes a feature or restriction of a subnet.
///Together, a set of elements describes the set of IP addresses served for a subnet by DHCP.
struct DHCP_SUBNET_ELEMENT_DATA
{
    ///DHCP_SUBNET_ELEMENT_TYPE enumeration value describing the type of element in the subsequent field.
    DHCP_SUBNET_ELEMENT_TYPE ElementType;
union Element
    {
        DHCP_IP_RANGE*       IpRange;
        DHCP_HOST_INFO*      SecondaryHost;
        DHCP_IP_RESERVATION* ReservedIp;
        DHCP_IP_RANGE*       ExcludeIpRange;
        DHCP_IP_CLUSTER*     IpUsedCluster;
    }
}

union DHCP_SUBNET_ELEMENT_UNION
{
}

///The <b>DHCP_SUBNET_ELEMENT_INFO_ARRAY</b> structure defines an array of subnet element data.
struct DHCP_SUBNET_ELEMENT_INFO_ARRAY
{
    ///Specifies the number of elements in <b>Elements</b>.
    uint NumElements;
    ///Pointer to a list of DHCP_SUBNET_ELEMENT_DATA structures that contain the data for the corresponding subnet
    ///elements.
    DHCP_SUBNET_ELEMENT_DATA* Elements;
}

///The <b>DHCP_IPV6_ADDRESS</b> structure contains an IPv6 address.
struct DHCP_IPV6_ADDRESS
{
    ///A <b>ULONGULONG</b> value containing the higher 64 bits of the IPv6 address.
    ulong HighOrderBits;
    ///A <b>ULONGULONG</b> value containing the lower 64 bits of the IPv6 address.
    ulong LowOrderBits;
}

///The <b>DHCP_ADDR_PATTERN</b> structure contains the information regarding the link-layer address/pattern.
struct DHCP_ADDR_PATTERN
{
    ///If <b>TRUE</b>, the hardware type member (<b>HWType</b>) will be matched; if <b>FALSE</b>, the hardware type
    ///member is ignored.
    BOOL       MatchHWType;
    ///8-bit integer value that specifies the hardware type of the address, specified in the pattern. Currently, only
    ///hardware type 1 (Ethernet 10 megabit) is supported as the filtering criterion.
    ubyte      HWType;
    ///If <b>TRUE</b>, <b>Pattern</b> contains a wildcard pattern; if <b>FALSE</b>, <b>Pattern</b> contains a hardware
    ///address.
    BOOL       IsWildcard;
    ///8-bit integer value that contains the length of the pattern, in bytes.
    ubyte      Length;
    ubyte[255] Pattern;
}

///The <b>DHCP_FILTER_ADD_INFO</b> structure contains information regarding the link-layer filter to be added to the
///allow and deny filter list.
struct DHCP_FILTER_ADD_INFO
{
    ///DHCP_ADDR_PATTERN structure that contains the address/pattern-related information of the link-layer filter.
    DHCP_ADDR_PATTERN AddrPatt;
    ///Pointer to a Unicode string that contains a text comment for the filter.
    PWSTR             Comment;
    ///DHCP_FILTER_LIST_TYPE enumeration value that specifies the list type to which the filter is to be added.
    DHCP_FILTER_LIST_TYPE ListType;
}

///The <b>DHCP_FILTER_GLOBAL_INFO</b> structure contains information about the enabling and disabling of the allow and
///deny filter lists.
struct DHCP_FILTER_GLOBAL_INFO
{
    ///If <b>TRUE</b>, the allow list is enabled; if <b>FALSE</b>, it is disabled.
    BOOL EnforceAllowList;
    BOOL EnforceDenyList;
}

///The <b>DHCP_FILTER_RECORD</b> structure contains information for a specific link-layer filter.
struct DHCP_FILTER_RECORD
{
    ///DHCP_ADDR_PATTERN structure that contains the address/pattern related information of the link-layer filter.
    DHCP_ADDR_PATTERN AddrPatt;
    ///Pointer to a null-terminated Unicode string which contains the comment associated with the address/pattern.
    PWSTR             Comment;
}

///The <b>DHCP_FILTER_ENUM_INFO</b> structure contains information regarding the number of link-layer filter records.
struct DHCP_FILTER_ENUM_INFO
{
    ///Integer value that specifies the number of link-layer filter records contained in the array specified by
    ///pEnumRecords.
    uint                NumElements;
    ///Pointer to an array of DHCP_FILTER_RECORD structures that contain link-layer filter records.
    DHCP_FILTER_RECORD* pEnumRecords;
}

///The <b>DHCP_OPTION_DATA_ELEMENT</b> structure defines a data element present (either singly or as a member of an
///array) within a DHCP_OPTION_DATA structure.
struct DHCP_OPTION_DATA_ELEMENT
{
    ///A DHCP_OPTION_DATA_TYPE enumeration value that indicates the type of data that is present in the subsequent
    ///field, <b>Element</b>.
    DHCP_OPTION_DATA_TYPE OptionType;
union Element
    {
        ubyte            ByteOption;
        ushort           WordOption;
        uint             DWordOption;
        DWORD_DWORD      DWordDWordOption;
        uint             IpAddressOption;
        PWSTR            StringDataOption;
        DHCP_BINARY_DATA BinaryDataOption;
        DHCP_BINARY_DATA EncapsulatedDataOption;
        PWSTR            Ipv6AddressDataOption;
    }
}

union DHCP_OPTION_ELEMENT_UNION
{
}

///The <b>DHCP_OPTION_DATA</b> structure defines a data container for one or more data elements associated with a DHCP
///option.
struct DHCP_OPTION_DATA
{
    ///Specifies the number of option data elements listed in <b>Elements</b>.
    uint NumElements;
    ///Pointer to a list of DHCP_OPTION_DATA_ELEMENT structures that contain the data elements associated with this
    ///particular option element.
    DHCP_OPTION_DATA_ELEMENT* Elements;
}

///The <b>DHCP_OPTION</b> structure defines a single DHCP option and any data elements associated with it.
struct DHCP_OPTION
{
    ///DHCP_OPTION_ID value that specifies a unique ID number (also called a "code") for this option.
    uint             OptionID;
    ///Unicode string that contains the name of this option.
    PWSTR            OptionName;
    ///Unicode string that contains a comment about this option.
    PWSTR            OptionComment;
    ///DHCP_OPTION_DATA structure that contains the data associated with this option.
    DHCP_OPTION_DATA DefaultValue;
    ///DHCP_OPTION_TYPE enumeration value that indicates whether this option is a single unary item or an element in an
    ///array of options.
    DHCP_OPTION_TYPE OptionType;
}

///The <b>DHCP_OPTION_ARRAY</b> structure defines an array of DHCP server options.
struct DHCP_OPTION_ARRAY
{
    ///Specifies the number of option elements in <b>Options</b>.
    uint         NumElements;
    ///Pointer to a list of DHCP_OPTION structures containing DHCP server options and the associated data.
    DHCP_OPTION* Options;
}

///The <b>DHCP_OPTION_VALUE</b> structure defines a DHCP option value (just the option data with an associated ID tag).
struct DHCP_OPTION_VALUE
{
    ///DHCP_OPTION_ID value that specifies a unique ID number for the option.
    uint             OptionID;
    ///DHCP_OPTION_DATA structure that contains the data for a DHCP server option.
    DHCP_OPTION_DATA Value;
}

///The <b>DHCP_OPTION_VALUE_ARRAY</b> structure defines a list of DHCP option values (just the option data with
///associated ID tags).
struct DHCP_OPTION_VALUE_ARRAY
{
    ///Specifies the number of option values listed in <b>Values</b>.
    uint               NumElements;
    ///Pointer to a list of DHCP_OPTION_VALUE structures containing DHCP option values.
    DHCP_OPTION_VALUE* Values;
}

///The <b>DHCP_RESERVED_SCOPE</b> structure defines a reserved DHCP scope.
struct DHCP_RESERVED_SCOPE
{
    ///DHCP_IP_ADDRESS value that contains an IP address used to identify the reservation.
    uint ReservedIpAddress;
    ///DHCP_IP_ADDRESS value that specifies the subnet ID of the subnet containing the reservation.
    uint ReservedIpSubnetAddress;
}

///The <b>DHCP_OPTION_SCOPE_INFO</b> structure defines information about the options provided for a certain DHCP scope.
struct DHCP_OPTION_SCOPE_INFO
{
    ///DHCP_OPTION_SCOPE_TYPE enumeration value that defines the scope type of the associated DHCP options, and
    ///indicates which of the following fields in the union will be populated.
    DHCP_OPTION_SCOPE_TYPE ScopeType;
union ScopeInfo
    {
        void*               DefaultScopeInfo;
        void*               GlobalScopeInfo;
        uint                SubnetScopeInfo;
        DHCP_RESERVED_SCOPE ReservedScopeInfo;
        PWSTR               MScopeInfo;
    }
}

struct DHCP_RESERVED_SCOPE6
{
    DHCP_IPV6_ADDRESS ReservedIpAddress;
    DHCP_IPV6_ADDRESS ReservedIpSubnetAddress;
}

///The DHCP_OPTION_SCOPE_INFO6 structure defines the data associated with a DHCP option scope.
struct DHCP_OPTION_SCOPE_INFO6
{
    ///DHCP_OPTION_SCOPE_TYPE6 enumeration value that indicates the type of the DHCP option. This value is used as the
    ///selector for the union arms listed in the following fields.
    DHCP_OPTION_SCOPE_TYPE6 ScopeType;
union ScopeInfo
    {
        void*                DefaultScopeInfo;
        DHCP_IPV6_ADDRESS    SubnetScopeInfo;
        DHCP_RESERVED_SCOPE6 ReservedScopeInfo;
    }
}

union DHCP_OPTION_SCOPE_UNION6
{
}

///The <b>DHCP_OPTION_LIST</b> structure defines a list of DHCP option values (just the option data with associated ID
///tags).
struct DHCP_OPTION_LIST
{
    ///Specifies the number of option values listed in <b>Options</b>.
    uint               NumOptions;
    ///Pointer to a list of DHCP_OPTION_VALUE structures
    DHCP_OPTION_VALUE* Options;
}

///The <b>DHCP_CLIENT_INFO</b> structure defines a client information record used by the DHCP server.
struct DHCP_CLIENT_INFO
{
    ///DHCP_IP_ADDRESS value that contains the assigned IP address of the DHCP client.
    uint             ClientIpAddress;
    ///DHCP_IP_MASK value that contains the subnet mask value assigned to the DHCP client.
    uint             SubnetMask;
    ///DHCP_CLIENT_UID structure containing the MAC address of the client's network interface device.
    DHCP_BINARY_DATA ClientHardwareAddress;
    ///Unicode string that specifies the network name of the DHCP client. This member is optional.
    PWSTR            ClientName;
    ///Unicode string that contains a comment associated with the DHCP client. This member is optional.
    PWSTR            ClientComment;
    ///DATE_TIME structure that contains the date and time the DHCP client lease will expire, in UTC time.
    DATE_TIME        ClientLeaseExpires;
    ///DHCP_HOST_INFO structure that contains information on the DHCP server that assigned the IP address to the client.
    DHCP_HOST_INFO   OwnerHost;
}

///The <b>DHCP_CLIENT_INFO_ARRAY</b> structure defines an array of DHCP_CLIENT_INFO structures for use with enumeration
///functions.
struct DHCP_CLIENT_INFO_ARRAY
{
    ///Specifies the number of elements present in <b>Clients</b>.
    uint               NumElements;
    ///Pointer to a list of DHCP_CLIENT_INFO structures that contain information on specific DHCP subnet clients.).
    DHCP_CLIENT_INFO** Clients;
}

///The <b>DHCP_CLIENT_INFO_VQ</b> structure defines information about the DHCPv4 client.
struct DHCP_CLIENT_INFO_VQ
{
    ///DHCP_IP_ADDRESStype value that contains the DHCPv4 client's IPv4 address.
    uint             ClientIpAddress;
    ///DHCP IP_MASK type value that contains the DHCPv4 client's IPv4 subnet mask address.
    uint             SubnetMask;
    ///GUID value that contains the hardware address (MAC address) of the DHCPv4 client.
    DHCP_BINARY_DATA ClientHardwareAddress;
    ///Ppointer to a null-terminated Unicode string that represents the DHCPv4 client's machine name.
    PWSTR            ClientName;
    ///Pointer to a null-terminated Unicode string that represents the description given to the DHCPv4 client.
    PWSTR            ClientComment;
    ///DATE_TIME structure that contains the lease expiry time for the DHCPv4 client. This is UTC time represented in
    ///the FILETIME format.
    DATE_TIME        ClientLeaseExpires;
    ///DHCP_HOST_INFO structure that contains information about the host machine (DHCPv4 server machine) that has
    ///provided a lease to the DHCPv4 client.
    DHCP_HOST_INFO   OwnerHost;
    ///Possible types of the DHCPv4 client. The possible values are shown in the following table. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CLIENT_TYPE_UNSPECIFIED"></a><a
    ///id="client_type_unspecified"></a><dl> <dt><b>CLIENT_TYPE_UNSPECIFIED</b></dt> <dt>0x00</dt> </dl> </td> <td
    ///width="60%"> A DHCPv4 client other than ones defined in this table. </td> </tr> <tr> <td width="40%"><a
    ///id="CLIENT_TYPE_DHCP"></a><a id="client_type_dhcp"></a><dl> <dt><b>CLIENT_TYPE_DHCP</b></dt> <dt>0x01</dt> </dl>
    ///</td> <td width="60%"> The DHCPv4 client supports the DHCP protocol. </td> </tr> <tr> <td width="40%"><a
    ///id="CLIENT_TYPE_BOOTP"></a><a id="client_type_bootp"></a><dl> <dt><b>CLIENT_TYPE_BOOTP</b></dt> <dt>0x02</dt>
    ///</dl> </td> <td width="60%"> The DHCPv4 client supports the BOOTP protocol. </td> </tr> <tr> <td width="40%"><a
    ///id="CLIENT_TYPE_BOTH"></a><a id="client_type_both"></a><dl> <dt><b>CLIENT_TYPE_BOTH</b></dt> <dt>0x03</dt> </dl>
    ///</td> <td width="60%"> The DHCPv4 client understands both the DHCPv4 and the BOOTP protocols. </td> </tr> <tr>
    ///<td width="40%"><a id="CLIENT_TYPE_RESERVATION_FLAG"></a><a id="client_type_reservation_flag"></a><dl>
    ///<dt><b>CLIENT_TYPE_RESERVATION_FLAG</b></dt> <dt>0x04</dt> </dl> </td> <td width="60%"> There is an IPv4
    ///reservation created for the DHCPv4 client. </td> </tr> <tr> <td width="40%"><a id="CLIENT_TYPE_NONE"></a><a
    ///id="client_type_none"></a><dl> <dt><b>CLIENT_TYPE_NONE</b></dt> <dt>0x64</dt> </dl> </td> <td width="60%">
    ///Backward compatibility for manual addressing. </td> </tr> </table>
    ubyte            bClientType;
    ///Possible states of the IPv4 address given to the DHCPv4 client. The following table represents the different
    ///values and their meanings. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="ADDRESS_STATE_OFFERED"></a><a id="address_state_offered"></a><dl> <dt><b>ADDRESS_STATE_OFFERED</b></dt>
    ///<dt>0x00</dt> </dl> </td> <td width="60%"> The DHCPv4 client has been offered this IPv4 address. </td> </tr> <tr>
    ///<td width="40%"><a id="ADDRESS_STATE_ACTIVE"></a><a id="address_state_active"></a><dl>
    ///<dt><b>ADDRESS_STATE_ACTIVE</b></dt> <dt>0x01</dt> </dl> </td> <td width="60%"> The IPv4 address is active and
    ///has an active DHCPv4 client lease record. </td> </tr> <tr> <td width="40%"><a id="ADDRESS_STATE_DECLINED"></a><a
    ///id="address_state_declined"></a><dl> <dt><b>ADDRESS_STATE_DECLINED</b></dt> <dt>0x02</dt> </dl> </td> <td
    ///width="60%"> The IPv4 address request was declined by the DHCPv4 client; hence, it is a bad IPv4 address. </td>
    ///</tr> <tr> <td width="40%"><a id="ADDRESS_STATE_DOOM"></a><a id="address_state_doom"></a><dl>
    ///<dt><b>ADDRESS_STATE_DOOM</b></dt> <dt>0x03</dt> </dl> </td> <td width="60%"> The IPv4 address is in DOOMED state
    ///and is due to be deleted. </td> </tr> </table>
    ubyte            AddressState;
    ///QuarantineStatus enumeration that specifies possible health status values for the DHCPv4 client, as validated at
    ///the NAP server.
    QuarantineStatus Status;
    ///This is of type DATE_TIME, containing the end time of the probation if the DHCPv4 client is on probation. For
    ///this time period, the DHCPv4 client has full access to the network.
    DATE_TIME        ProbationEnds;
    ///If <b>TRUE</b>, the DHCPv4 client is quarantine-enabled; if <b>FALSE</b>, it is not.
    BOOL             QuarantineCapable;
}

///The <b>DHCP_CLIENT_INFO_ARRAY_VQ</b> structure specifies an array of DHCP_CLIENT_INFO_VQ structures.
struct DHCP_CLIENT_INFO_ARRAY_VQ
{
    ///The number of elements in the array.
    uint NumElements;
    ///Pointer to the first element in the array of DHCP_CLIENT_INFO_VQ structures.
    DHCP_CLIENT_INFO_VQ** Clients;
}

///The <b>DHCP_CLIENT_FILTER_STATUS_INFO</b> structure defines information about the DHCPv4 client, including filter
///status information.
struct DHCP_CLIENT_FILTER_STATUS_INFO
{
    ///DHCP_IP_ADDRESStype value that contains the DHCPv4 client's IPv4 address.
    uint             ClientIpAddress;
    ///DHCP IP_MASK type value that contains the DHCPv4 client's IPv4 subnet mask address.
    uint             SubnetMask;
    ///GUID value that contains the hardware address (MAC address) of the DHCPv4 client.
    DHCP_BINARY_DATA ClientHardwareAddress;
    ///Ppointer to a null-terminated Unicode string that represents the DHCPv4 client's machine name.
    PWSTR            ClientName;
    ///Pointer to a null-terminated Unicode string that represents the description given to the DHCPv4 client.
    PWSTR            ClientComment;
    ///DATE_TIME structure that contains the lease expiry time for the DHCPv4 client. This is UTC time represented in
    ///the FILETIME format.
    DATE_TIME        ClientLeaseExpires;
    ///DHCP_HOST_INFO structure that contains information about the host machine (DHCPv4 server machine) that has
    ///provided a lease to the DHCPv4 client.
    DHCP_HOST_INFO   OwnerHost;
    ///Possible types of the DHCPv4 client. The possible values are shown in the following table. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CLIENT_TYPE_UNSPECIFIED"></a><a
    ///id="client_type_unspecified"></a><dl> <dt><b>CLIENT_TYPE_UNSPECIFIED</b></dt> <dt>0x00</dt> </dl> </td> <td
    ///width="60%"> A DHCPv4 client other than ones defined in this table. </td> </tr> <tr> <td width="40%"><a
    ///id="CLIENT_TYPE_DHCP"></a><a id="client_type_dhcp"></a><dl> <dt><b>CLIENT_TYPE_DHCP</b></dt> <dt>0x01</dt> </dl>
    ///</td> <td width="60%"> The DHCPv4 client supports the DHCP protocol. </td> </tr> <tr> <td width="40%"><a
    ///id="CLIENT_TYPE_BOOTP"></a><a id="client_type_bootp"></a><dl> <dt><b>CLIENT_TYPE_BOOTP</b></dt> <dt>0x02</dt>
    ///</dl> </td> <td width="60%"> The DHCPv4 client supports the BOOTP protocol. </td> </tr> <tr> <td width="40%"><a
    ///id="CLIENT_TYPE_BOTH"></a><a id="client_type_both"></a><dl> <dt><b>CLIENT_TYPE_BOTH</b></dt> <dt>0x03</dt> </dl>
    ///</td> <td width="60%"> The DHCPv4 client understands both the DHCPv4 and the BOOTP protocols. </td> </tr> <tr>
    ///<td width="40%"><a id="CLIENT_TYPE_RESERVATION_FLAG"></a><a id="client_type_reservation_flag"></a><dl>
    ///<dt><b>CLIENT_TYPE_RESERVATION_FLAG</b></dt> <dt>0x04</dt> </dl> </td> <td width="60%"> There is an IPv4
    ///reservation created for the DHCPv4 client. </td> </tr> <tr> <td width="40%"><a id="CLIENT_TYPE_NONE"></a><a
    ///id="client_type_none"></a><dl> <dt><b>CLIENT_TYPE_NONE</b></dt> <dt>0x64</dt> </dl> </td> <td width="60%">
    ///Backward compatibility for manual addressing. </td> </tr> </table>
    ubyte            bClientType;
    ///Possible states of the IPv4 address given to the DHCPv4 client. The following table represents the different
    ///values and their meanings. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="ADDRESS_STATE_OFFERED"></a><a id="address_state_offered"></a><dl> <dt><b>ADDRESS_STATE_OFFERED</b></dt>
    ///<dt>0x00</dt> </dl> </td> <td width="60%"> The DHCPv4 client has been offered this IPv4 address. </td> </tr> <tr>
    ///<td width="40%"><a id="ADDRESS_STATE_ACTIVE"></a><a id="address_state_active"></a><dl>
    ///<dt><b>ADDRESS_STATE_ACTIVE</b></dt> <dt>0x01</dt> </dl> </td> <td width="60%"> The IPv4 address is active and
    ///has an active DHCPv4 client lease record. </td> </tr> <tr> <td width="40%"><a id="ADDRESS_STATE_DECLINED"></a><a
    ///id="address_state_declined"></a><dl> <dt><b>ADDRESS_STATE_DECLINED</b></dt> <dt>0x02</dt> </dl> </td> <td
    ///width="60%"> The IPv4 address request was declined by the DHCPv4 client; hence, it is a bad IPv4 address. </td>
    ///</tr> <tr> <td width="40%"><a id="ADDRESS_STATE_DOOM"></a><a id="address_state_doom"></a><dl>
    ///<dt><b>ADDRESS_STATE_DOOM</b></dt> <dt>0x03</dt> </dl> </td> <td width="60%"> The IPv4 address is in DOOMED state
    ///and is due to be deleted. </td> </tr> </table>
    ubyte            AddressState;
    ///QuarantineStatus enumeration that specifies possible health status values for the DHCPv4 client, as validated at
    ///the NAP server.
    QuarantineStatus Status;
    ///This is of type DATE_TIME, containing the end time of the probation if the DHCPv4 client is on probation. For
    ///this time period, the DHCPv4 client has full access to the network.
    DATE_TIME        ProbationEnds;
    ///If <b>TRUE</b>, the DHCPv4 client is quarantine-enabled; if <b>FALSE</b>, it is not.
    BOOL             QuarantineCapable;
    uint             FilterStatus;
}

///The <b>DHCP_CLIENT_FILTER_STATUS_INFO_ARRAY</b> structure contains an array of information elements for DHCPv4
///clients.
struct DHCP_CLIENT_FILTER_STATUS_INFO_ARRAY
{
    ///Integer value that contains the number of DHCPv4 clients in the subsequent field Clients.
    uint NumElements;
    ///Pointer to an array of DHCP_CLIENT_FILTER_STATUS_INFO structures that contain the DHCPv4 clients' information.
    DHCP_CLIENT_FILTER_STATUS_INFO** Clients;
}

///The <b>DHCP_CLIENT_INFO_PB</b> structure defines information about a DHCPv4 client, including filter status
///information and any policies that resulted in the IPv4 address assignment.
struct DHCP_CLIENT_INFO_PB
{
    ///DHCP_IP_ADDRESS structure that contains the DHCPv4 client IPv4 address.
    uint             ClientIpAddress;
    ///DHCP IP_MASK structure that contains the DHCPv4 client IPv4 subnet mask.
    uint             SubnetMask;
    ///DHCP_CLIENT_UID structure that contains the hardware address (MAC address) of the DHCPv4 client.
    DHCP_BINARY_DATA ClientHardwareAddress;
    ///Pointer to a null-terminated Unicode string that represents the DHCPv4 client machine name.
    PWSTR            ClientName;
    ///Pointer to a null-terminated Unicode string that represents the description of the DHCPv4 client.
    PWSTR            ClientComment;
    ///DATE_TIME structure that contains the lease expiry time for the DHCPv4 client. This is UTC time represented in
    ///the FILETIME format.
    DATE_TIME        ClientLeaseExpires;
    ///DHCP_HOST_INFO structure that contains information about the host machine (DHCPv4 server machine) that provided a
    ///lease to the DHCPv4 client.
    DHCP_HOST_INFO   OwnerHost;
    ///Value that specifies the DHCPv4 client type. The possible values are below: <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="CLIENT_TYPE_UNSPECIFIED"></a><a
    ///id="client_type_unspecified"></a><dl> <dt><b>CLIENT_TYPE_UNSPECIFIED</b></dt> <dt>0x00</dt> </dl> </td> <td
    ///width="60%"> The DHCPv4 client is not defined in the server database. </td> </tr> <tr> <td width="40%"><a
    ///id="CLIENT_TYPE_DHCP"></a><a id="client_type_dhcp"></a><dl> <dt><b>CLIENT_TYPE_DHCP</b></dt> <dt>0x01</dt> </dl>
    ///</td> <td width="60%"> The DHCPv4 client supports the DHCP protocol. </td> </tr> <tr> <td width="40%"><a
    ///id="CLIENT_TYPE_BOOTP"></a><a id="client_type_bootp"></a><dl> <dt><b>CLIENT_TYPE_BOOTP</b></dt> <dt>0x02</dt>
    ///</dl> </td> <td width="60%"> The DHCPv4 client supports the BOOTP protocol. </td> </tr> <tr> <td width="40%"><a
    ///id="CLIENT_TYPE_BOTH"></a><a id="client_type_both"></a><dl> <dt><b>CLIENT_TYPE_BOTH</b></dt> <dt>0x03</dt> </dl>
    ///</td> <td width="60%"> The DHCPv4 client supports both the DHCPv4 and the BOOTP protocols </td> </tr> <tr> <td
    ///width="40%"><a id="CLIENT_TYPE_RESERVATION_FLAG"></a><a id="client_type_reservation_flag"></a><dl>
    ///<dt><b>CLIENT_TYPE_RESERVATION_FLAG</b></dt> <dt>0x04</dt> </dl> </td> <td width="60%"> There is an IPv4
    ///reservation created for the DHCPv4 client. </td> </tr> <tr> <td width="40%"><a id="CLIENT_TYPE_NONE"></a><a
    ///id="client_type_none"></a><dl> <dt><b>CLIENT_TYPE_NONE</b></dt> <dt>0x64</dt> </dl> </td> <td width="60%">
    ///Backward compatibility for manual addressing. </td> </tr> </table>
    ubyte            bClientType;
    ///Value that specifies various states of the IPv4 address. The possible values are below: <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="ADDRESS_STATE_OFFERED"></a><a
    ///id="address_state_offered"></a><dl> <dt><b>ADDRESS_STATE_OFFERED</b></dt> <dt>0x0</dt> </dl> </td> <td
    ///width="60%"> The DHCPv4 client is offered this IPv4 address. </td> </tr> <tr> <td width="40%"><a
    ///id="ADDRESS_STATE_ACTIVE"></a><a id="address_state_active"></a><dl> <dt><b>ADDRESS_STATE_ACTIVE</b></dt>
    ///<dt>0x1</dt> </dl> </td> <td width="60%"> The IPv4 address is active and has an active DHCPv4 client lease
    ///record. </td> </tr> <tr> <td width="40%"><a id="ADDRESS_STATE_DECLINED"></a><a
    ///id="address_state_declined"></a><dl> <dt><b>ADDRESS_STATE_DECLINED</b></dt> <dt>0x2</dt> </dl> </td> <td
    ///width="60%"> The IPv4 address request is declined by the DHCPv4 client; hence, it is a bad IPv4 address. </td>
    ///</tr> <tr> <td width="40%"><a id="ADDRESS_STATE_DOOM"></a><a id="address_state_doom"></a><dl>
    ///<dt><b>ADDRESS_STATE_DOOM</b></dt> <dt>0x3</dt> </dl> </td> <td width="60%"> The IPv4 address is in <i>DOOMED</i>
    ///state and is due to be deleted. </td> </tr> </table>
    ubyte            AddressState;
    ///QuarantineStatus enumeration that specifies possible health status values for the DHCPv4 client, as validated at
    ///the NAP server.
    QuarantineStatus Status;
    ///DATE_TIME structure that contains the probation end time if the DHCPv4 client is on probation. The DHCPv4 client
    ///has full access to the network for this time period. This is UTC time represented in the FILETIME format.
    DATE_TIME        ProbationEnds;
    ///<b>TRUE</b>, if the DHCPv4 client is quarantine-enabled; Otherwise, it is <b>FALSE</b>.
    BOOL             QuarantineCapable;
    ///Integer flag value that specifies the status of the link-layer filter. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="FILTER_STATUS_NONE"></a><a id="filter_status_none"></a><dl>
    ///<dt><b>FILTER_STATUS_NONE</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> The DHCPv4 client MAC address
    ///does not match any filter. </td> </tr> <tr> <td width="40%"><a id="FILTER_STATUS_FULL_MATCH_IN_ALLOW_LIST"></a><a
    ///id="filter_status_full_match_in_allow_list"></a><dl> <dt><b>FILTER_STATUS_FULL_MATCH_IN_ALLOW_LIST</b></dt>
    ///<dt>0x00000002</dt> </dl> </td> <td width="60%"> The DHCv4P client MAC address fully matches an allow list
    ///filter. </td> </tr> <tr> <td width="40%"><a id="FILTER_STATUS_FULL_MATCH_IN_DENY_LIST"></a><a
    ///id="filter_status_full_match_in_deny_list"></a><dl> <dt><b>FILTER_STATUS_FULL_MATCH_IN_DENY_LIST</b></dt>
    ///<dt>0x00000004</dt> </dl> </td> <td width="60%"> The DHCPv4 client MAC address fully matches a deny list filter.
    ///</td> </tr> <tr> <td width="40%"><a id="FILTER_STATUS_WILDCARD_MATCH_IN_ALLOW_LIST"></a><a
    ///id="filter_status_wildcard_match_in_allow_list"></a><dl>
    ///<dt><b>FILTER_STATUS_WILDCARD_MATCH_IN_ALLOW_LIST</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%"> The
    ///DHCPv4 client MAC address has a wild card match in the allow list. </td> </tr> <tr> <td width="40%"><a
    ///id="FILTER_STATUS_WILDCARD_MATCH_IN_DENY_LIST_"></a><a id="filter_status_wildcard_match_in_deny_list_"></a><dl>
    ///<dt><b>FILTER_STATUS_WILDCARD_MATCH_IN_DENY_LIST </b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> The
    ///DHCPv4 client MAC address has a wild card match in the deny list. </td> </tr> </table>
    uint             FilterStatus;
    ///Pointer to a null-terminated Unicode string that represents the DHCP server policy name that resulted in the IPv4
    ///address assignment to the DHCPv4 client in the lease.
    PWSTR            PolicyName;
}

///The <b>DHCP_CLIENT_INFO_PB_ARRAY</b> structure defines an array of DHCPv4 client information elements.
struct DHCP_CLIENT_INFO_PB_ARRAY
{
    ///Integer that contains the number of DHCPv4 clients in <b>Clients</b>.
    uint NumElements;
    ///Pointer to an array of DHCP_CLIENT_INFO_PB structures that contain DHCPv4 client information.
    DHCP_CLIENT_INFO_PB** Clients;
}

///The <b>DHCP_SEARCH_INFO</b> structure defines the DHCP client record data used to search against for particular
///server operations.
struct DHCP_SEARCH_INFO
{
    ///DHCP_SEARCH_INFO_TYPE enumeration value that specifies the data included in the subsequent member of this
    ///structure.
    DHCP_SEARCH_INFO_TYPE SearchType;
union SearchInfo
    {
        uint             ClientIpAddress;
        DHCP_BINARY_DATA ClientHardwareAddress;
        PWSTR            ClientName;
    }
}

union DHCP_CLIENT_SEARCH_UNION
{
}

struct DHCP_PROPERTY
{
    DHCP_PROPERTY_ID   ID;
    DHCP_PROPERTY_TYPE Type;
union Value
    {
        ubyte            ByteValue;
        ushort           WordValue;
        uint             DWordValue;
        PWSTR            StringValue;
        DHCP_BINARY_DATA BinaryValue;
    }
}

struct DHCP_PROPERTY_ARRAY
{
    uint           NumElements;
    DHCP_PROPERTY* Elements;
}

struct DHCP_CLIENT_INFO_EX
{
    uint                 ClientIpAddress;
    uint                 SubnetMask;
    DHCP_BINARY_DATA     ClientHardwareAddress;
    PWSTR                ClientName;
    PWSTR                ClientComment;
    DATE_TIME            ClientLeaseExpires;
    DHCP_HOST_INFO       OwnerHost;
    ubyte                bClientType;
    ubyte                AddressState;
    QuarantineStatus     Status;
    DATE_TIME            ProbationEnds;
    BOOL                 QuarantineCapable;
    uint                 FilterStatus;
    PWSTR                PolicyName;
    DHCP_PROPERTY_ARRAY* Properties;
}

struct DHCP_CLIENT_INFO_EX_ARRAY
{
    uint NumElements;
    DHCP_CLIENT_INFO_EX** Clients;
}

///The <b>SCOPE_MIB_INFO</b> structure defines information about an available scope for use within returned
///DHCP-specific SNMP Management Information Block (MIB) data.
struct SCOPE_MIB_INFO
{
    ///DHCP_IP_ADDRESS value that specifies the subnet mask for this scope.
    uint Subnet;
    ///Contains the number of IP addresses currently in use for this scope.
    uint NumAddressesInuse;
    ///Contains the number of IP addresses currently available for this scope.
    uint NumAddressesFree;
    ///Contains the number of IP addresses currently in the offer state for this scope.
    uint NumPendingOffers;
}

///The <b>DHCP_MIB_INFO</b> structure defines information returned from the DHCP-specific SNMP Management Information
///Block (MIB) about the current DHCP service.
struct DHCP_MIB_INFO
{
    ///Contains the number of DHCP discovery messages received.
    uint            Discovers;
    ///Contains the number of DHCP service offer messages transmitted.
    uint            Offers;
    ///Contains the number of dynamic address request messages received.
    uint            Requests;
    ///Contains the number of DHCP ACK messages received.
    uint            Acks;
    ///Contains the number of DHCP NACK messages received.
    uint            Naks;
    ///Contains the number of dynamic address service decline messages received.
    uint            Declines;
    ///Contains the number of dynamic address release messages received.
    uint            Releases;
    ///DATE_TIME structure that contains the date and time the DHCP service started.
    DATE_TIME       ServerStartTime;
    ///Contains the number of scopes defined on the DHCP server.
    uint            Scopes;
    ///Array of SCOPE_MIB_INFO structures that contain information on each subnet defined on the server. There are
    ///exactly <b>Scopes</b> elements in this array. If no subnets are defined (<b>Scopes</b> is 0), this field will be
    ///<b>NULL</b>.
    SCOPE_MIB_INFO* ScopeInfo;
}

struct SCOPE_MIB_INFO_VQ
{
    uint Subnet;
    uint NumAddressesInuse;
    uint NumAddressesFree;
    uint NumPendingOffers;
    uint QtnNumLeases;
    uint QtnPctQtnLeases;
    uint QtnProbationLeases;
    uint QtnNonQtnLeases;
    uint QtnExemptLeases;
    uint QtnCapableClients;
}

struct DHCP_MIB_INFO_VQ
{
    uint               Discovers;
    uint               Offers;
    uint               Requests;
    uint               Acks;
    uint               Naks;
    uint               Declines;
    uint               Releases;
    DATE_TIME          ServerStartTime;
    uint               QtnNumLeases;
    uint               QtnPctQtnLeases;
    uint               QtnProbationLeases;
    uint               QtnNonQtnLeases;
    uint               QtnExemptLeases;
    uint               QtnCapableClients;
    uint               QtnIASErrors;
    uint               Scopes;
    SCOPE_MIB_INFO_VQ* ScopeInfo;
}

///The <b>SCOPE_MIB_INFO_V5</b> structure contains information about a specific DHCP scope.
struct SCOPE_MIB_INFO_V5
{
    ///DHCP_IP_ADDRESS value that contains the IP address of the subnet gateway that defines the scope.
    uint Subnet;
    ///The number of IP addresses in the scope that are currently assigned to DHCP clients.
    uint NumAddressesInuse;
    ///The number of IP addresses in the scope that are not currently assigned to DHCP clients.
    uint NumAddressesFree;
    ///The number of IP addresses in the scope that have been offered to DHCP clients but have not yet received REQUEST
    ///messages.
    uint NumPendingOffers;
}

///The <b>DHCP_MIB_INFO_V5</b> structure contains statistical information about a DHCP server.
struct DHCP_MIB_INFO_V5
{
    ///The number of DISCOVER messages received by the DHCP server.
    uint               Discovers;
    ///The number of OFFER messages sent to DHCP clients.
    uint               Offers;
    ///The number of REQUEST messages received by DHCP clients.
    uint               Requests;
    ///The number of ACK messages sent by the DHCP server.
    uint               Acks;
    ///The number of NACK messages sent by the DHCP server.
    uint               Naks;
    ///The number of DECLINE messages sent by DHCP clients.
    uint               Declines;
    ///The number of RELEASE messages received by the DHCP server.
    uint               Releases;
    ///DATE_TIME structure that contains the most recent time the DHCP server was started.
    DATE_TIME          ServerStartTime;
    ///This member is not currently used. Please set this to value 0x00000000.
    uint               QtnNumLeases;
    ///This member is not currently used. Please set this to value 0x00000000.
    uint               QtnPctQtnLeases;
    ///This member is not currently used. Please set this to value 0x00000000.
    uint               QtnProbationLeases;
    ///This member is not currently used. Please set this to value 0x00000000.
    uint               QtnNonQtnLeases;
    ///This member is not currently used. Please set this to value 0x00000000.
    uint               QtnExemptLeases;
    ///This member is not currently used. Please set this to value 0x00000000.
    uint               QtnCapableClients;
    ///This member is not currently used. Please set this to value 0x00000000.
    uint               QtnIASErrors;
    ///The number of OFFER messages sent with a specific delay by the DHCP server.
    uint               DelayedOffers;
    ///The number of scopes with a delay value greater than 0.
    uint               ScopesWithDelayedOffers;
    ///The total number of scopes configured on the DHCP server
    uint               Scopes;
    ///Pointer to a SCOPE_MIB_INFO_V5 structure that contains specific information about the scopes configured on the
    ///DHCP server.
    SCOPE_MIB_INFO_V5* ScopeInfo;
}

///The <b>DHCP_SERVER_CONFIG_INFO</b> structure defines the data used to configure the DHCP server.
struct DHCP_SERVER_CONFIG_INFO
{
    ///Specifies a set of bit flags that contain the RPC protocols supported by the DHCP server. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DHCP_SERVER_USE_RPC_OVER_TCPIP"></a><a
    ///id="dhcp_server_use_rpc_over_tcpip"></a><dl> <dt><b>DHCP_SERVER_USE_RPC_OVER_TCPIP</b></dt> <dt>0x00000001</dt>
    ///</dl> </td> <td width="60%"> TCP/IP can be used for DHCP API RPC calls. </td> </tr> <tr> <td width="40%"><a
    ///id="DHCP_SERVER_USE_RPC_OVER_NP"></a><a id="dhcp_server_use_rpc_over_np"></a><dl>
    ///<dt><b>DHCP_SERVER_USE_RPC_OVER_NP</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> Named pipes can be
    ///used for DHCP API RPC calls. </td> </tr> <tr> <td width="40%"><a id="DHCP_SERVER_USE_RPC_OVER_LPC"></a><a
    ///id="dhcp_server_use_rpc_over_lpc"></a><dl> <dt><b>DHCP_SERVER_USE_RPC_OVER_LPC</b></dt> <dt>0x00000004</dt> </dl>
    ///</td> <td width="60%"> Local Procedure Call (LPC) can be used for local DHCP API RPC calls. </td> </tr> </table>
    uint  APIProtocolSupport;
    ///Unicode string that specifies the file name of the client lease JET database.
    PWSTR DatabaseName;
    ///Unicode string that specifies the absolute path to <b>DatabaseName</b>.
    PWSTR DatabasePath;
    ///Unicode string that specifies the absolute path and file name of the backup client lease JET database.
    PWSTR BackupPath;
    ///Specifies the interval, in minutes, between backups of the client lease database.
    uint  BackupInterval;
    ///Specifies a bit flag that indicates whether or not database actions should be logged. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0x00000001</dt> </dl> </td> <td width="60%"> All database
    ///operations will be logged. </td> </tr> </table>
    uint  DatabaseLoggingFlag;
    ///Specifies a bit flag that indicates whether or not a database restore operation should be performed. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0x00000001</dt> </dl> </td> <td width="60%">
    ///The client lease database should be restored from the path and file specified in <b>BackupPath</b>. </td> </tr>
    ///</table>
    uint  RestoreFlag;
    ///Specifies the interval, in minutes, between cleanup operations performed on the client lease database.
    uint  DatabaseCleanupInterval;
    ///Reserved. This field should be set to 0x00000000.
    uint  DebugFlag;
}

///The <b>DHCP_SCAN_ITEM</b> structure defines a desynchronized client lease address stored on a DHCPv4 server, and the
///location in which it should be fixed (in-memory cache or database).
struct DHCP_SCAN_ITEM
{
    ///DHCP_IP_ADDRESS value that specifies the address whose lease status was changed during a scan operation.
    uint           IpAddress;
    ///DHCP_SCAN_FLAGenumeration value that indicates whether the supplied client lease IP address will be fixed in the
    ///DHCPv4 server's in-memory client lease cache or the client lease database proper.
    DHCP_SCAN_FLAG ScanFlag;
}

///The <b>DHCP_SCAN_LIST</b> structure defines a list of all desynchronized client lease IP address on a DHCPv4 server
///that must be fixed.
struct DHCP_SCAN_LIST
{
    ///Specifies the number of DHCP_SCAN_ITEMstructures listed in <i>ScanItems</i>.
    uint            NumScanItems;
    ///Pointer to a list of DHCP_SCAN_ITEMstructures that contain the specific client IP addresses whose leases differed
    ///between the in-memory cache of client leases and the subnet client lease database during a
    ///DhcpScanDatabaseoperation.
    DHCP_SCAN_ITEM* ScanItems;
}

///The <b>DHCP_CLASS_INFO</b> structure defines a DHCP option class.
struct DHCP_CLASS_INFO
{
    ///Unicode string that contains the name of the class.
    PWSTR  ClassName;
    ///Unicode string that contains a comment associated with the class.
    PWSTR  ClassComment;
    ///Specifies the size of <b>ClassData</b>, in bytes. When passing this structure into DhcpGetClassInfo, this value
    ///should be set to the size of the initialized buffer.
    uint   ClassDataLength;
    ///Specifies whether or not this option class is a vendor-defined option class. If <b>TRUE</b>, it is a vendor
    ///class; if not, it is not a vendor class. Vendor-defined option classes can be used by DHCP clients that are
    ///configured to optionally identify themselves by their vendor type to the DHCP server when obtaining a lease.
    BOOL   IsVendor;
    ///Specifies a bit flag that indicates whether or not the options are vendor-specific. If it is not, this parameter
    ///should be 0. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="DHCP_FLAGS_OPTION_IS_VENDOR"></a><a id="dhcp_flags_option_is_vendor"></a><dl>
    ///<dt><b>DHCP_FLAGS_OPTION_IS_VENDOR</b></dt> </dl> </td> <td width="60%"> This flag should be set if the option is
    ///provided by a vendor. </td> </tr> </table>
    uint   Flags;
    ///Pointer to a byte buffer that contains specific data for the class. When passing this structure into
    ///DhcpGetClassInfo, this buffer should be initialized to the anticipated size of the data to be returned.
    ubyte* ClassData;
}

///The <b>DHCP_CLASS_INFO_ARRAY</b> structure defines an array of elements that contain DHCP class information.
struct DHCP_CLASS_INFO_ARRAY
{
    ///Specifies the number of elements in <b>Classes</b>.
    uint             NumElements;
    ///Pointer to an array of DHCP_CLASS_INFO structures that contain DHCP class information.
    DHCP_CLASS_INFO* Classes;
}

///The <b>DHCP_CLASS_INFO_V6</b> structure contains the information for a particular DHCPv6 user class or vendor class.
struct DHCP_CLASS_INFO_V6
{
    ///A pointer to a null-terminated Unicode string that contains the class name.
    PWSTR  ClassName;
    ///A pointer to a null-terminated Unicode string that contains the comment for the class.
    PWSTR  ClassComment;
    ///The length of data as pointed to by <b>ClassData</b>.
    uint   ClassDataLength;
    ///If <b>TRUE</b>, this information applies to a vendor class; if <b>FALSE</b>, it applies to a user class.
    BOOL   IsVendor;
    ///The vendor class identifier. It is default (0x00000000) for user class.
    uint   EnterpriseNumber;
    ///This field MUST be set to zero (0x00000000) when sending and ignored on receipt.
    uint   Flags;
    ///Pointer to a BYTE blob that contains an array of bytes of length specified by <b>ClassDataLength</b>. This
    ///contains opaque data regarding a user class or a vendor class.
    ubyte* ClassData;
}

///The <b>DHCP_CLASS_INFO_ARRAY_V6</b> structure contains a list of information regarding a user class or a vendor
///class.
struct DHCP_CLASS_INFO_ARRAY_V6
{
    ///This is of type <b>DWORD</b>, specifying the number of classes whose information is contained in the array
    ///specified by Classes.
    uint                NumElements;
    ///A pointer to an array of structures DHCP_CLASS_INFO_V6 (section 2.2.1.2.70) that contains information regarding
    ///the various user classes and vendor classes.
    DHCP_CLASS_INFO_V6* Classes;
}

///The <b>DHCP_SERVER_SPECIFIC_STRINGS</b> structure contains the default string values for user and vendor class names.
struct DHCP_SERVER_SPECIFIC_STRINGS
{
    ///Pointer to a Unicode string that specifies the default vendor class name for the DHCP server.
    PWSTR DefaultVendorClassName;
    ///Pointer to a Unicode string that specifies the default user class name for the DHCP server.
    PWSTR DefaultUserClassName;
}

///The <b>DHCP_IP_RESERVATION_V4</b> structure defines a client IP reservation. This structure extends an IP reservation
///by including the type of client (DHCP or BOOTP) holding the reservation.
struct DHCP_IP_RESERVATION_V4
{
    ///DHCP_IP_ADDRESS value that contains the reserved IP address.
    uint              ReservedIpAddress;
    ///DHCP_CLIENT_UID structure that contains the hardware address (MAC address) of the DHCPv4 client that holds this
    ///reservation.
    DHCP_BINARY_DATA* ReservedForClient;
    ///Value that specifies the DHCPv4 reserved client type. The possible values are below: <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="CLIENT_TYPE_DHCP"></a><a id="client_type_dhcp"></a><dl>
    ///<dt><b>CLIENT_TYPE_DHCP</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The DHCPv4 client supports the DHCP
    ///protocol only. </td> </tr> <tr> <td width="40%"><a id="CLIENT_TYPE_BOOTP"></a><a id="client_type_bootp"></a><dl>
    ///<dt><b>CLIENT_TYPE_BOOTP</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The DHCPv4 client supports the BOOTP
    ///protocol only. </td> </tr> <tr> <td width="40%"><a id="CLIENT_TYPE_BOTH"></a><a id="client_type_both"></a><dl>
    ///<dt><b>CLIENT_TYPE_BOTH</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> The DHCPv4 client supports both the
    ///DHCPv4 and the BOOTP protocols. </td> </tr> </table>
    ubyte             bAllowedClientTypes;
}

///The <b>DHCP_IP_RESERVATION_INFO</b> structure defines an IPv4 reservation for a DHCPv4 client. It extends the
///DHCP_IP_RESERVATION_V4 structure by including the reservation client name and description.
struct DHCP_IP_RESERVATION_INFO
{
    ///DHCP_IP_ADDRESS structure that contains the reserved IP address.
    uint             ReservedIpAddress;
    ///DHCP_CLIENT_UID structure that contains the hardware address (MAC address) of the DHCPv4 client that holds this
    ///reservation.
    DHCP_BINARY_DATA ReservedForClient;
    ///Pointer to a null-terminated Unicode string that represents the DHCPv4 reserved client machine name.
    PWSTR            ReservedClientName;
    ///Pointer to a null-terminated Unicode string that represents the description of the DHCPv4 reserved client.
    PWSTR            ReservedClientDesc;
    ///Value that specifies the DHCPv4 reserved client type. The possible values are below: <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="CLIENT_TYPE_DHCP"></a><a id="client_type_dhcp"></a><dl>
    ///<dt><b>CLIENT_TYPE_DHCP</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The DHCPv4 client supports the DHCP
    ///protocol only. </td> </tr> <tr> <td width="40%"><a id="CLIENT_TYPE_BOOTP"></a><a id="client_type_bootp"></a><dl>
    ///<dt><b>CLIENT_TYPE_BOOTP</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The DHCPv4 client supports the BOOTP
    ///protocol only. </td> </tr> <tr> <td width="40%"><a id="CLIENT_TYPE_BOTH"></a><a id="client_type_both"></a><dl>
    ///<dt><b>CLIENT_TYPE_BOTH</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> The DHCPv4 client supports both the
    ///DHCPv4 and the BOOTP protocols. </td> </tr> </table>
    ubyte            bAllowedClientTypes;
    ///<b>TRUE</b> if the DHCPv4 reserved client has options configured at reservation level. Otherwise, it is
    ///<b>FALSE</b>.
    ubyte            fOptionsPresent;
}

///The <b>DHCP_RESERVATION_INFO_ARRAY</b> structure defines an array of IPv4 reservations for DHCPv4 clients.
struct DHCP_RESERVATION_INFO_ARRAY
{
    ///Integer that specifies the number of IPv4 client reservations in <b>Elements</b>.
    uint NumElements;
    ///Pointer to an array of DHCP_IP_RESERVATION_INFO structures that contain IPv4 client reservations.
    DHCP_IP_RESERVATION_INFO** Elements;
}

///The <b>DHCP_SUBNET_ELEMENT_DATA_V4</b> structure defines an element that describes a feature or restriction of a
///subnet. Together, a set of elements describes the set of IP addresses served for a subnet by DHCP.
///DHCP_SUBNET_ELEMENT_DATA_V4 specifically allows for IP reservations that take client type into consideration .
struct DHCP_SUBNET_ELEMENT_DATA_V4
{
    ///DHCP_SUBNET_ELEMENT_TYPE enumeration value describing the type of element in the subsequent field.
    DHCP_SUBNET_ELEMENT_TYPE ElementType;
union Element
    {
        DHCP_IP_RANGE*   IpRange;
        DHCP_HOST_INFO*  SecondaryHost;
        DHCP_IP_RESERVATION_V4* ReservedIp;
        DHCP_IP_RANGE*   ExcludeIpRange;
        DHCP_IP_CLUSTER* IpUsedCluster;
    }
}

union DHCP_SUBNET_ELEMENT_UNION_V4
{
}

///The <b>DHCP_SUBNET_ELEMENT_INFO_ARRAY_V4</b> structure defines an array of subnet element data. Element data in the
///V4 structure contains client type information.
struct DHCP_SUBNET_ELEMENT_INFO_ARRAY_V4
{
    ///Specifies the number of elements in <b>Elements</b>.
    uint NumElements;
    ///Pointer to a list of DHCP_SUBNET_ELEMENT_DATA_V4 structures that contain the data for the corresponding subnet
    ///elements.
    DHCP_SUBNET_ELEMENT_DATA_V4* Elements;
}

///The <b>DHCP_CLIENT_INFO_V4</b> structure defines a client information record used by the DHCP server, extending the
///definition provided in DHCP_CLIENT_INFO by including client type information.
struct DHCP_CLIENT_INFO_V4
{
    ///DHCP_IP_ADDRESS value that contains the assigned IP address of the DHCP client.
    uint             ClientIpAddress;
    ///DHCP_IP_MASK value that contains the subnet mask value assigned to the DHCP client.
    uint             SubnetMask;
    ///DHCP_CLIENT_UID structure containing the MAC address of the client's network interface device.
    DHCP_BINARY_DATA ClientHardwareAddress;
    ///Unicode string that specifies the network name of the DHCP client. This member is optional.
    PWSTR            ClientName;
    ///Unicode string that contains a comment associated with the DHCP client. This member is optional.
    PWSTR            ClientComment;
    ///DATE_TIME structure that contains the date and time the DHCP client lease will expire, in UTC time.
    DATE_TIME        ClientLeaseExpires;
    ///DHCP_HOST_INFO structure that contains information on the DHCP server that assigned the IP address to the client.
    DHCP_HOST_INFO   OwnerHost;
    ///Specifies the types of dynamic IP address service used by the client. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="CLIENT_TYPE_UNSPECIFIED"></a><a
    ///id="client_type_unspecified"></a><dl> <dt><b>CLIENT_TYPE_UNSPECIFIED</b></dt> </dl> </td> <td width="60%"> The
    ///client's dynamic IP address protocol is unknown. </td> </tr> <tr> <td width="40%"><a id="CLIENT_TYPE_DHCP"></a><a
    ///id="client_type_dhcp"></a><dl> <dt><b>CLIENT_TYPE_DHCP</b></dt> </dl> </td> <td width="60%"> The client uses DHCP
    ///for dynamic IP address service. </td> </tr> <tr> <td width="40%"><a id="CLIENT_TYPE_BOOTP"></a><a
    ///id="client_type_bootp"></a><dl> <dt><b>CLIENT_TYPE_BOOTP</b></dt> </dl> </td> <td width="60%"> The client uses
    ///BOOTP for dynamic IP address service. </td> </tr> <tr> <td width="40%"><a id="CLIENT_TYPE_BOTH"></a><a
    ///id="client_type_both"></a><dl> <dt><b>CLIENT_TYPE_BOTH</b></dt> </dl> </td> <td width="60%"> The client can use
    ///either DHCP or BOOTP for dynamic IP address service. </td> </tr> <tr> <td width="40%"><a
    ///id="CLIENT_TYPE_NONE"></a><a id="client_type_none"></a><dl> <dt><b>CLIENT_TYPE_NONE</b></dt> </dl> </td> <td
    ///width="60%"> The client does not use a supported dynamic IP address service. </td> </tr> </table>
    ubyte            bClientType;
}

///The <b>DHCP_CLIENT_INFO_ARRAY_V4</b> structure defines an array of DHCP_CLIENT_INFO_V4 structures for use with
///enumeration functions.
struct DHCP_CLIENT_INFO_ARRAY_V4
{
    ///Specifies the number of elements present in <b>Clients</b>.
    uint NumElements;
    ///Pointer to a list of DHCP_CLIENT_INFO_V4 structures that contain information on specific DHCP subnet clients,
    ///including the dynamic address type (DHCP and/or BOOTP).
    DHCP_CLIENT_INFO_V4** Clients;
}

///The <b>DHCP_SERVER_CONFIG_INFO_V4</b> structure defines the data used to configure the DHCP server.
struct DHCP_SERVER_CONFIG_INFO_V4
{
    ///Specifies a set of bit flags that contain the RPC protocols supported by the DHCP server. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DHCP_SERVER_USE_RPC_OVER_TCPIP"></a><a
    ///id="dhcp_server_use_rpc_over_tcpip"></a><dl> <dt><b>DHCP_SERVER_USE_RPC_OVER_TCPIP</b></dt> <dt>0x00000001</dt>
    ///</dl> </td> <td width="60%"> TCP/IP can be used for DHCP API RPC calls. </td> </tr> <tr> <td width="40%"><a
    ///id="DHCP_SERVER_USE_RPC_OVER_NP"></a><a id="dhcp_server_use_rpc_over_np"></a><dl>
    ///<dt><b>DHCP_SERVER_USE_RPC_OVER_NP</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> Named pipes can be
    ///used for DHCP API RPC calls. </td> </tr> <tr> <td width="40%"><a id="DHCP_SERVER_USE_RPC_OVER_LPC"></a><a
    ///id="dhcp_server_use_rpc_over_lpc"></a><dl> <dt><b>DHCP_SERVER_USE_RPC_OVER_LPC</b></dt> <dt>0x00000004</dt> </dl>
    ///</td> <td width="60%"> Local Procedure Call (LPC) can be used for local DHCP API RPC calls. </td> </tr> </table>
    uint  APIProtocolSupport;
    ///Unicode string that specifies the file name of the client lease JET database.
    PWSTR DatabaseName;
    ///Unicode string that specifies the absolute path to <b>DatabaseName</b>.
    PWSTR DatabasePath;
    ///Unicode string that specifies the absolute path and file name of the backup client lease JET database.
    PWSTR BackupPath;
    ///Specifies the interval, in minutes, between backups of the client lease database.
    uint  BackupInterval;
    ///Specifies a bit flag that indicates whether or not database actions should be logged. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0x00000001</dt> </dl> </td> <td width="60%"> All database
    ///operations will be logged. </td> </tr> </table>
    uint  DatabaseLoggingFlag;
    ///Specifies a bit flag that indicates whether or not a database restore operation should be performed. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0x00000001</dt> </dl> </td> <td width="60%">
    ///The client lease database should be restored from the path and file specified in <b>BackupPath</b>. </td> </tr>
    ///</table>
    uint  RestoreFlag;
    ///Specifies the interval, in minutes, between cleanup operations performed on the client lease database.
    uint  DatabaseCleanupInterval;
    ///Reserved. This field should be set to 0x00000000.
    uint  DebugFlag;
    ///Specifies a value equal to or greater than 0 or less than 6 that indicates the number of times to ping an
    ///unresponsive client before determining unavailability.
    uint  dwPingRetries;
    ///Specifies the size of <b>wszBootTableString</b>, in bytes.
    uint  cbBootTableString;
    ///Unicode string that contains the boot table string for the DHCP server. ?? More information needed. ??
    PWSTR wszBootTableString;
    ///Specifies whether or not to enable audit logging on the DHCP server. A value of <b>TRUE</b> indicates that an
    ///audit log is generated; <b>FALSE</b> indicates that audit logging is not performed.
    BOOL  fAuditLog;
}

///The <b>DHCP_SERVER_CONFIG_INFO_VQ</b> structure defines settings for the DHCP server.
struct DHCP_SERVER_CONFIG_INFO_VQ
{
    ///Integer value that defines the type of RPC protocol used by the DHCP server to register with RPC. Following is
    ///the set of supported types, which may be bitwise OR'd to produce valid values. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="DHCP_SERVER_USE_RPC_OVER_TCPIP"></a><a
    ///id="dhcp_server_use_rpc_over_tcpip"></a><dl> <dt><b>DHCP_SERVER_USE_RPC_OVER_TCPIP</b></dt> <dt>0x00000001</dt>
    ///</dl> </td> <td width="60%"> RPC protocol over TCP is used by the DHCP server to register. </td> </tr> <tr> <td
    ///width="40%"><a id="DHCP_SERVER_USE_RPC_OVER_NP"></a><a id="dhcp_server_use_rpc_over_np"></a><dl>
    ///<dt><b>DHCP_SERVER_USE_RPC_OVER_NP</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> RPC protocol over
    ///named pipes is used by the DHCP server to register.&lt;8&gt; </td> </tr> <tr> <td width="40%"><a
    ///id="DHCP_SERVER_USE_RPC_OVER_LPC"></a><a id="dhcp_server_use_rpc_over_lpc"></a><dl>
    ///<dt><b>DHCP_SERVER_USE_RPC_OVER_LPC</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%"> RPC protocol over
    ///LPC is used by the DHCP server to register.&lt;9&gt; </td> </tr> <tr> <td width="40%"><a
    ///id="DHCP_SERVER_USE_RPC_OVER_ALL"></a><a id="dhcp_server_use_rpc_over_all"></a><dl>
    ///<dt><b>DHCP_SERVER_USE_RPC_OVER_ALL</b></dt> <dt>0x00000007</dt> </dl> </td> <td width="60%"> The DHCP server
    ///supports all of the preceding protocols. </td> </tr> </table>
    uint  APIProtocolSupport;
    ///Pointer to a null-terminated Unicode string that represents the DHCP server database name that is used by the
    ///DHCP server for persistent storage.
    PWSTR DatabaseName;
    ///Pointer to a null-terminated Unicode string that contains the absolute path, where the DHCP server database is
    ///stored.
    PWSTR DatabasePath;
    ///Pointer to a null-terminated Unicode string that contains the absolute path for backup storage that is used by
    ///the DHCP server for backup.
    PWSTR BackupPath;
    ///Integer value that specifies the interval in minutes between backups of the DHCP server database.
    uint  BackupInterval;
    ///Integer value that indicates the transaction logging mode of the DHCP server. The value 1 indicates that the
    ///transaction log is enabled for the DHCP server, and 0 indicates that the transaction log is disabled for the DHCP
    ///server.
    uint  DatabaseLoggingFlag;
    ///Integer value used as a BOOL flag. If this setting is <b>TRUE</b> (1), the DHCP service loads the DHCP database
    ///from the backup database on DHCP service startup. The default value of this flag is <b>FALSE</b> (0).
    uint  RestoreFlag;
    ///Integer value that specifies the maximum time interval that DOOMED IPv4 DHCP client records are allowed to
    ///persist within the DHCP server database.
    uint  DatabaseCleanupInterval;
    ///Integer flag value that specifies the level of logging done by the DHCP server. The following table defines the
    ///set values that can be used. Specifying '0xFFFFFFFF' enables all types of logging. LOW WORD bitmask (0x0000FFFF)
    ///for low-frequency debug output. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="DEBUG_ADDRESS"></a><a id="debug_address"></a><dl> <dt><b>DEBUG_ADDRESS</b></dt> <dt>0x00000001</dt> </dl>
    ///</td> <td width="60%"> Enable IP-address-related logging. </td> </tr> <tr> <td width="40%"><a
    ///id="DEBUG_CLIENT"></a><a id="debug_client"></a><dl> <dt><b>DEBUG_CLIENT</b></dt> <dt>0x00000002</dt> </dl> </td>
    ///<td width="60%"> Enable DHCP-client-API-related logging. </td> </tr> <tr> <td width="40%"><a
    ///id="DEBUG_PARAMETERS"></a><a id="debug_parameters"></a><dl> <dt><b>DEBUG_PARAMETERS</b></dt> <dt>0x00000004</dt>
    ///</dl> </td> <td width="60%"> Enable DHCP-server-parameters-related logging. </td> </tr> <tr> <td width="40%"><a
    ///id="DEBUG_OPTIONS"></a><a id="debug_options"></a><dl> <dt><b>DEBUG_OPTIONS</b></dt> <dt>0x00000008</dt> </dl>
    ///</td> <td width="60%"> Enable DHCP-options-related logging. </td> </tr> <tr> <td width="40%"><a
    ///id="DEBUG_ERRORS"></a><a id="debug_errors"></a><dl> <dt><b>DEBUG_ERRORS</b></dt> <dt>0x00000010</dt> </dl> </td>
    ///<td width="60%"> Enable DHCP-errors-related logging. </td> </tr> <tr> <td width="40%"><a id="DEBUG_STOC"></a><a
    ///id="debug_stoc"></a><dl> <dt><b>DEBUG_STOC</b></dt> <dt>0x00000020</dt> </dl> </td> <td width="60%"> Enable
    ///DHCPv4 and DCHPv6-protocol-errors-related logging. </td> </tr> <tr> <td width="40%"><a id="DEBUG_INIT"></a><a
    ///id="debug_init"></a><dl> <dt><b>DEBUG_INIT</b></dt> <dt>0x00000040</dt> </dl> </td> <td width="60%"> Enable
    ///DHCP-server-initialization-related logging. </td> </tr> <tr> <td width="40%"><a id="DEBUG_SCAVENGER"></a><a
    ///id="debug_scavenger"></a><dl> <dt><b>DEBUG_SCAVENGER</b></dt> <dt>0x00000080</dt> </dl> </td> <td width="60%">
    ///Enable scavenger's-error-related logging. </td> </tr> <tr> <td width="40%"><a id="DEBUG_TIMESTAMP"></a><a
    ///id="debug_timestamp"></a><dl> <dt><b>DEBUG_TIMESTAMP</b></dt> <dt>0x00000100</dt> </dl> </td> <td width="60%">
    ///Enable timing-errors-related logging. </td> </tr> <tr> <td width="40%"><a id="DEBUG_APIS"></a><a
    ///id="debug_apis"></a><dl> <dt><b>DEBUG_APIS</b></dt> <dt>0x00000200</dt> </dl> </td> <td width="60%"> Enable
    ///DHCP-APIs-related logging. </td> </tr> <tr> <td width="40%"><a id="DEBUG_REGISTRY"></a><a
    ///id="debug_registry"></a><dl> <dt><b>DEBUG_REGISTRY</b></dt> <dt>0x00000400</dt> </dl> </td> <td width="60%">
    ///Enable the logging of errors caused by registry setting operations. </td> </tr> <tr> <td width="40%"><a
    ///id="DEBUG_JET"></a><a id="debug_jet"></a><dl> <dt><b>DEBUG_JET</b></dt> <dt>0x00000800</dt> </dl> </td> <td
    ///width="60%"> Enable the logging of the DHCP server database errors. </td> </tr> <tr> <td width="40%"><a
    ///id="DEBUG_THREADPOOL"></a><a id="debug_threadpool"></a><dl> <dt><b>DEBUG_THREADPOOL</b></dt> <dt>0x00001000</dt>
    ///</dl> </td> <td width="60%"> Enable the logging related to executing thread pool operations. </td> </tr> <tr> <td
    ///width="40%"><a id="DEBUG_AUDITLOG"></a><a id="debug_auditlog"></a><dl> <dt><b>DEBUG_AUDITLOG</b></dt>
    ///<dt>0x00002000</dt> </dl> </td> <td width="60%"> Enable the logging related to errors caused by audit log
    ///operations. </td> </tr> <tr> <td width="40%"><a id="DEBUG_QUARANTINE"></a><a id="debug_quarantine"></a><dl>
    ///<dt><b>DEBUG_QUARANTINE</b></dt> <dt>0x00004000</dt> </dl> </td> <td width="60%"> Enable the logging of errors
    ///caused by quarantine errors. </td> </tr> <tr> <td width="40%"><a id="DEBUG_MISC"></a><a id="debug_misc"></a><dl>
    ///<dt><b>DEBUG_MISC</b></dt> <dt>0x00008000</dt> </dl> </td> <td width="60%"> Enable the logging caused by
    ///miscellaneous errors. </td> </tr> </table> HIGH WORD bitmask (0xFFFF0000) for high-frequency debug output, that
    ///is, more verbose. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="DEBUG_MESSAGE"></a><a id="debug_message"></a><dl> <dt><b>DEBUG_MESSAGE</b></dt> <dt>0x00010000</dt> </dl>
    ///</td> <td width="60%"> Enable the logging related to debug messages. </td> </tr> <tr> <td width="40%"><a
    ///id="DEBUG_API_VERBOSE"></a><a id="debug_api_verbose"></a><dl> <dt><b>DEBUG_API_VERBOSE</b></dt>
    ///<dt>0x00020000</dt> </dl> </td> <td width="60%"> Enable the logging related to DHCP API verbose errors. </td>
    ///</tr> <tr> <td width="40%"><a id="DEBUG_DNS"></a><a id="debug_dns"></a><dl> <dt><b>DEBUG_DNS</b></dt>
    ///<dt>0x00040000</dt> </dl> </td> <td width="60%"> Enable the logging related to DNS messages. </td> </tr> <tr> <td
    ///width="40%"><a id="DEBUG_MSTOC"></a><a id="debug_mstoc"></a><dl> <dt><b>DEBUG_MSTOC</b></dt> <dt>0x00080000</dt>
    ///</dl> </td> <td width="60%"> Enable the logging related to multicast protocol layer errors. </td> </tr> <tr> <td
    ///width="40%"><a id="DEBUG_TRACK"></a><a id="debug_track"></a><dl> <dt><b>DEBUG_TRACK</b></dt> <dt>0x00100000</dt>
    ///</dl> </td> <td width="60%"> Enable the logging tracking specific problems. </td> </tr> <tr> <td width="40%"><a
    ///id="DEBUG_ROGUE"></a><a id="debug_rogue"></a><dl> <dt><b>DEBUG_ROGUE</b></dt> <dt>0x00200000</dt> </dl> </td> <td
    ///width="60%"> Enable the logging related to a ROGUE DHCP server. </td> </tr> <tr> <td width="40%"><a
    ///id="DEBUG_PNP"></a><a id="debug_pnp"></a><dl> <dt><b>DEBUG_PNP</b></dt> <dt>0x00400000</dt> </dl> </td> <td
    ///width="60%"> Enable the logging related to PNP interface errors. </td> </tr> <tr> <td width="40%"><a
    ///id="DEBUG_PERF"></a><a id="debug_perf"></a><dl> <dt><b>DEBUG_PERF</b></dt> <dt>0x01000000</dt> </dl> </td> <td
    ///width="60%"> Enable the logging of performance-related messages. </td> </tr> <tr> <td width="40%"><a
    ///id="DEBUG_ALLOC"></a><a id="debug_alloc"></a><dl> <dt><b>DEBUG_ALLOC</b></dt> <dt>0x02000000</dt> </dl> </td> <td
    ///width="60%"> Enable the logging of allocation-related and deallocation-related messages. </td> </tr> <tr> <td
    ///width="40%"><a id="DEBUG_PING"></a><a id="debug_ping"></a><dl> <dt><b>DEBUG_PING</b></dt> <dt>0x04000000</dt>
    ///</dl> </td> <td width="60%"> Enable the logging of synchronous ping–related messages. </td> </tr> <tr> <td
    ///width="40%"><a id="DEBUG_THREAD"></a><a id="debug_thread"></a><dl> <dt><b>DEBUG_THREAD</b></dt>
    ///<dt>0x08000000</dt> </dl> </td> <td width="60%"> Enable the logging of thread-related messages. </td> </tr> <tr>
    ///<td width="40%"><a id="DEBUG_TRACE"></a><a id="debug_trace"></a><dl> <dt><b>DEBUG_TRACE</b></dt>
    ///<dt>0x10000000</dt> </dl> </td> <td width="60%"> Enable the logging for tracing through code messages. </td>
    ///</tr> <tr> <td width="40%"><a id="DEBUG_TRACE_CALLS"></a><a id="debug_trace_calls"></a><dl>
    ///<dt><b>DEBUG_TRACE_CALLS</b></dt> <dt>0x20000000</dt> </dl> </td> <td width="60%"> Enable the logging for tracing
    ///through piles of code. </td> </tr> <tr> <td width="40%"><a id="DEBUG_STARTUP_BRK"></a><a
    ///id="debug_startup_brk"></a><dl> <dt><b>DEBUG_STARTUP_BRK</b></dt> <dt>0x40000000</dt> </dl> </td> <td
    ///width="60%"> Enable the logging related to debugger break during setup messages. </td> </tr> <tr> <td
    ///width="40%"><a id="DEBUG_LOG_IN_FILE"></a><a id="debug_log_in_file"></a><dl> <dt><b>DEBUG_LOG_IN_FILE</b></dt>
    ///<dt>0x80000000</dt> </dl> </td> <td width="60%"> Enable the logging of debug output in a file. </td> </tr>
    ///</table>
    uint  DebugFlag;
    ///Integer value that specifies the number of retries that the DHCP server can make to verify whether a particular
    ///address is already in use by any client by issuing a ping before issuing any address to the DHCP client (valid
    ///range: 0–5, inclusive).
    uint  dwPingRetries;
    ///Integer value that contains the size of the BOOT TABLE given to the DHCP client.
    uint  cbBootTableString;
    ///Pointer to a null-terminated Unicode string that contains the absolute path of the BOOTP TABLE given to the BOOTP
    ///client.
    PWSTR wszBootTableString;
    ///If <b>TRUE</b>, an audit log will be written by the DHCP server; if <b>FALSE</b>, it will not.
    BOOL  fAuditLog;
    ///If <b>TRUE</b>, Quarantine is turned ON on the DHCP server; if <b>FALSE</b>, it is turned OFF.
    BOOL  QuarantineOn;
    ///Integer value that determines the default policy for a DHCP NAP server when an NPS server is not reachable.
    ///Choices include Quarantine/unrestricted/Drop Request.
    uint  QuarDefFail;
    BOOL  QuarRuntimeStatus;
}

///The <b>DHCP_SERVER_CONFIG_INFO_V6</b> structure contains the settings for the DHCPv6 server.
struct DHCP_SERVER_CONFIG_INFO_V6
{
    ///Reserved. This must to be set to 0.
    BOOL UnicastFlag;
    ///Reserved. This must to be set to 0.
    BOOL RapidCommitFlag;
    ///Integer value that specifies the preferred lifetime for IANA addresses.
    uint PreferredLifetime;
    ///Integer value that specifies the valid lifetime for IANA addresses.
    uint ValidLifetime;
    ///Integer that specifies the value for time T1.
    uint T1;
    ///Integer that specifies the value for time T2.
    uint T2;
    ///The preferred lifetime value for a temporary IPv6 address. This is not used, and must to be set to 0.
    uint PreferredLifetimeIATA;
    ///The valid lifetime value for a temporary IPv6 address. This is not used, and must to be set to 0.
    uint ValidLifetimeIATA;
    BOOL fAuditLog;
}

///The <b>DHCP_SUPER_SCOPE_TABLE_ENTRY</b> structure defines a subnet entry within the superscope table.
struct DHCP_SUPER_SCOPE_TABLE_ENTRY
{
    ///DHCP_IP_ADDRESS value that specifies the IP address of the gateway for the subnet. This address is used to
    ///uniquely identify a subnet served by the DHCP server.
    uint  SubnetAddress;
    ///Specifies the index value assigned to this subnet entry, and its enumerated position within the super scope
    ///table.
    uint  SuperScopeNumber;
    ///Specifies the index value of the next subnet entry in the superscope table. If this value is ---, this table
    ///entry is the last one in the super scope.
    uint  NextInSuperScope;
    ///Unicode string that contains the name assigned to this subnet entry within the superscope.
    PWSTR SuperScopeName;
}

///The <b>DHCP_SUPER_SCOPE_TABLE</b> structure defines the superscope of a DHCP server.
struct DHCP_SUPER_SCOPE_TABLE
{
    ///Specifies the number of subnets (and therefore scopes) present in the super scope.
    uint cEntries;
    ///Pointer to a list of DHCP_SUPER_SCOPE_TABLE_ENTRYstructures containing the names and IP addresses of each subnet
    ///defined within the superscope.
    DHCP_SUPER_SCOPE_TABLE_ENTRY* pEntries;
}

///The <b>DHCP_CLIENT_INFO_V5</b> structure defines a client information record used by the DHCP server, extending the
///definition provided in DHCP_CLIENT_INFO by including client type and address state information.<div
///class="alert"><b>Note</b> This structure is used by the following operating system versions: Windows 2000 and
///later.</div> <div> </div>
struct DHCP_CLIENT_INFO_V5
{
    ///DHCP_IP_ADDRESS value that contains the assigned IP address of the DHCP client.
    uint             ClientIpAddress;
    ///DHCP_IP_MASK value that contains the subnet mask value assigned to the DHCP client.
    uint             SubnetMask;
    ///DHCP_CLIENT_UID structure containing the MAC address of the client's network interface device.
    DHCP_BINARY_DATA ClientHardwareAddress;
    ///Pointer to a Unicode string that specifies the network name of the DHCP client. This member is optional.
    PWSTR            ClientName;
    ///Pointer to a Unicode string that contains a comment associated with the DHCP client. This member is optional.
    PWSTR            ClientComment;
    ///DATE_TIME structure that contains the date and time the DHCP client lease will expire, in UTC time.
    DATE_TIME        ClientLeaseExpires;
    ///DHCP_HOST_INFO structure that contains information on the DHCP server that assigned the IP address to the client.
    DHCP_HOST_INFO   OwnerHost;
    ///Specifies the types of dynamic IP address service used by the client. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="CLIENT_TYPE_UNSPECIFIED"></a><a
    ///id="client_type_unspecified"></a><dl> <dt><b>CLIENT_TYPE_UNSPECIFIED</b></dt> </dl> </td> <td width="60%"> The
    ///client's dynamic IP address protocol is unknown. </td> </tr> <tr> <td width="40%"><a id="CLIENT_TYPE_DHCP"></a><a
    ///id="client_type_dhcp"></a><dl> <dt><b>CLIENT_TYPE_DHCP</b></dt> </dl> </td> <td width="60%"> The client uses DHCP
    ///for dynamic IP address service. </td> </tr> <tr> <td width="40%"><a id="CLIENT_TYPE_BOOTP"></a><a
    ///id="client_type_bootp"></a><dl> <dt><b>CLIENT_TYPE_BOOTP</b></dt> </dl> </td> <td width="60%"> The client uses
    ///BOOTP for dynamic IP address service. </td> </tr> <tr> <td width="40%"><a id="CLIENT_TYPE_BOTH"></a><a
    ///id="client_type_both"></a><dl> <dt><b>CLIENT_TYPE_BOTH</b></dt> </dl> </td> <td width="60%"> The client can use
    ///either DHCP or BOOTP for dynamic IP address service. </td> </tr> <tr> <td width="40%"><a
    ///id="CLIENT_TYPE_NONE"></a><a id="client_type_none"></a><dl> <dt><b>CLIENT_TYPE_NONE</b></dt> </dl> </td> <td
    ///width="60%"> The client does not use a supported dynamic IP address service. </td> </tr> </table>
    ubyte            bClientType;
    ///Specifies the current state of the client IP address. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="V5_ADDRESS_STATE_OFFERED"></a><a id="v5_address_state_offered"></a><dl>
    ///<dt><b>V5_ADDRESS_STATE_OFFERED</b></dt> </dl> </td> <td width="60%"> The IP address is currently offered to the
    ///client; it has not yet become active. </td> </tr> <tr> <td width="40%"><a id="V5_ADDRESS_STATE_ACTIVE"></a><a
    ///id="v5_address_state_active"></a><dl> <dt><b>V5_ADDRESS_STATE_ACTIVE</b></dt> </dl> </td> <td width="60%"> The IP
    ///address is currently in use by the client. </td> </tr> <tr> <td width="40%"><a
    ///id="V5_ADDRESS_STATE_DECLINED"></a><a id="v5_address_state_declined"></a><dl>
    ///<dt><b>V5_ADDRESS_STATE_DECLINED</b></dt> </dl> </td> <td width="60%"> The IP address has been declined by the
    ///client and has not been released back into the pool. </td> </tr> <tr> <td width="40%"><a
    ///id="V5_ADDRESS_STATE_DOOM"></a><a id="v5_address_state_doom"></a><dl> <dt><b>V5_ADDRESS_STATE_DOOM</b></dt> </dl>
    ///</td> <td width="60%"> The IP address is "doomed", indicating that it is no longer available and will be removed
    ///from the pool. </td> </tr> </table>
    ubyte            AddressState;
}

///The <b>DHCP_CLIENT_INFO_ARRAY_V5</b> structure defines an array of DHCP_CLIENT_INFO_V5 structures for use with
///enumeration functions.
struct DHCP_CLIENT_INFO_ARRAY_V5
{
    ///Specifies the number of elements present in <b>Clients</b>.
    uint NumElements;
    ///Pointer to a list of DHCP_CLIENT_INFO_V5 structures that contain information on specific DHCP subnet clients,
    ///including the dynamic address type (DHCP and/or BOOTP) and address state information.
    DHCP_CLIENT_INFO_V5** Clients;
}

///The <b>DHCP_ALL_OPTIONS</b> structure defines the set of all options available on a DHCP server.
struct DHCP_ALL_OPTIONS
{
    ///Reserved. This value should be set to 0.
    uint               Flags;
    ///DHCP_OPTION_ARRAY structure that contains the set of non-vendor options.
    DHCP_OPTION_ARRAY* NonVendorOptions;
    ///Specifies the number of vendor options listed in <b>VendorOptions</b>.
    uint               NumVendorOptions;
struct
    {
        DHCP_OPTION Option;
        PWSTR       VendorName;
        PWSTR       ClassName;
    }
}

///The <b>DHCP_ALL_OPTION_VALUES</b> structure defines the set of all option values defined on a DHCP server, organized
///according to class/vendor pairing.
struct DHCP_ALL_OPTION_VALUES
{
    ///Reserved. This field should be set to 0.
    uint Flags;
    ///Specifies the number of elements in <b>Options</b>.
    uint NumElements;
struct
    {
        PWSTR ClassName;
        PWSTR VendorName;
        BOOL  IsVendor;
        DHCP_OPTION_VALUE_ARRAY* OptionsArray;
    }
}

///The <b>DHCP_ALL_OPTION_VALUES_PB</b> structure defines the set of all option values for a DHCP server within a scope.
struct DHCP_ALL_OPTION_VALUES_PB
{
    ///Reserved. Must be 0.
    uint Flags;
    ///Integer that specifies the number of elements in <b>Options</b>.
    uint NumElements;
struct
    {
        PWSTR PolicyName;
        PWSTR VendorName;
        BOOL  IsVendor;
        DHCP_OPTION_VALUE_ARRAY* OptionsArray;
    }
}

///The <b>DHCPDS_SERVER</b> structure defines information on a DHCP server in the context of directory services.
struct DHCPDS_SERVER
{
    ///Reserved. This value should be set to 0.
    uint  Version;
    ///Unicode string that contains the unique name of the DHCP server.
    PWSTR ServerName;
    ///Specifies the IP address of the DHCP server as an unsigned 32-bit integer.
    uint  ServerAddress;
    ///Specifies a set of bit flags that describe active directory settings for the DHCP server.
    uint  Flags;
    ///Reserved. This value should be set to 0.
    uint  State;
    ///Unicode string that contains the active directory path to the DHCP server.
    PWSTR DsLocation;
    uint  DsLocType;
}

///The <b>DHCPDS_SERVERS</b> structure defines a list of DHCP servers in the context of directory services.
struct DHCPDS_SERVERS
{
    ///Reserved. This value should be 0.
    uint           Flags;
    ///Specifies the number of elements in <b>Servers</b>.
    uint           NumElements;
    DHCPDS_SERVER* Servers;
}

///The <b>DHCP_ATTRIB</b> structure defines an attribute set on the DHCP server.
struct DHCP_ATTRIB
{
    ///DHCP_ATTRIB_ID structure that uniquely identifies the DHCP server attribute.
    uint DhcpAttribId;
    ///Specifies exactly one of the following attribute types. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="DHCP_ATTRIB_BOOL_IS_ROGUE"></a><a id="dhcp_attrib_bool_is_rogue"></a><dl>
    ///<dt><b>DHCP_ATTRIB_BOOL_IS_ROGUE</b></dt> <dt>0x01</dt> </dl> </td> <td width="60%"> The DHCP server is rogue.
    ///</td> </tr> <tr> <td width="40%"><a id="DHCP_ATTRIB_BOOL_IS_DYNBOOTP"></a><a
    ///id="dhcp_attrib_bool_is_dynbootp"></a><dl> <dt><b>DHCP_ATTRIB_BOOL_IS_DYNBOOTP</b></dt> <dt>0x02</dt> </dl> </td>
    ///<td width="60%"> The DHCP server supports BOOTP for dynamic address service. </td> </tr> <tr> <td width="40%"><a
    ///id="DHCP_ATTRIB_BOOL_IS_PART_OF_DSDC"></a><a id="dhcp_attrib_bool_is_part_of_dsdc"></a><dl>
    ///<dt><b>DHCP_ATTRIB_BOOL_IS_PART_OF_DSDC</b></dt> <dt>0x03</dt> </dl> </td> <td width="60%"> The DHCP server is
    ///part of the directory service domain controller. </td> </tr> <tr> <td width="40%"><a
    ///id="DHCP_ATTRIB_BOOL_IS_BINDING_AWARE"></a><a id="dhcp_attrib_bool_is_binding_aware"></a><dl>
    ///<dt><b>DHCP_ATTRIB_BOOL_IS_BINDING_AWARE</b></dt> <dt>0x04</dt> </dl> </td> <td width="60%"> The DHCP server is
    ///binding aware. </td> </tr> <tr> <td width="40%"><a id="DHCP_ATTRIB_BOOL_IS_ADMIN"></a><a
    ///id="dhcp_attrib_bool_is_admin"></a><dl> <dt><b>DHCP_ATTRIB_BOOL_IS_ADMIN</b></dt> <dt>0x05</dt> </dl> </td> <td
    ///width="60%"> The DHCP server is the admin-level DHCP server. </td> </tr> <tr> <td width="40%"><a
    ///id="DHCP_ATTRIB_ULONG_RESTORE_STATUS"></a><a id="dhcp_attrib_ulong_restore_status"></a><dl>
    ///<dt><b>DHCP_ATTRIB_ULONG_RESTORE_STATUS</b></dt> <dt>0x06</dt> </dl> </td> <td width="60%"> The DHCP server can
    ///restore status with the provided attribute value. </td> </tr> </table>
    uint DhcpAttribType;
union
    {
        BOOL DhcpAttribBool;
        uint DhcpAttribUlong;
    }
}

///The <b>DHCP_ATTRIB_ARRAY</b> structure defines a set of DHCP server attributes.
struct DHCP_ATTRIB_ARRAY
{
    ///Specifies the number of attributes listed in <b>DhcpAttribs</b>.
    uint         NumElements;
    ///Pointer to a list of DHCP_ATTRIB structures that contain the DHCP server attributes.
    DHCP_ATTRIB* DhcpAttribs;
}

///The <b>DHCP_BOOTP_IP_RANGE</b> structure defines a suite of IPs for lease to BOOTP-specific clients.
struct DHCP_BOOTP_IP_RANGE
{
    ///DHCP_IP_ADDRESS value that specifies the start of the IP range used for BOOTP service.
    uint StartAddress;
    ///DHCP_IP_ADDRESS value that specifies the end of the IP range used for BOOTP service.
    uint EndAddress;
    ///Specifies the number of BOOTP clients with addresses served from this range.
    uint BootpAllocated;
    uint MaxBootpAllowed;
}

///The <b>DHCP_SUBNET_ELEMENT_DATA_V5</b> structure defines an element that describes a feature or restriction of a
///subnet. Together, a set of elements describes the set of IP addresses served for a subnet by DHCP or BOOTP.
///<b>DHCP_SUBNET_ELEMENT_DATA_V5</b> specifically allows for the definition of BOOTP-served addresses.
struct DHCP_SUBNET_ELEMENT_DATA_V5
{
    ///DHCP_SUBNET_ELEMENT_TYPE enumeration value describing the type of element in the subsequent field.
    DHCP_SUBNET_ELEMENT_TYPE ElementType;
union Element
    {
        DHCP_BOOTP_IP_RANGE* IpRange;
        DHCP_HOST_INFO*      SecondaryHost;
        DHCP_IP_RESERVATION_V4* ReservedIp;
        DHCP_IP_RANGE*       ExcludeIpRange;
        DHCP_IP_CLUSTER*     IpUsedCluster;
    }
}

///The <b>DHCP_SUBNET_ELEMENT_INFO_ARRAY_V5</b> structure defines an array of subnet element data. Element data in the
///V5 structure is BOOTP specific.
struct DHCP_SUBNET_ELEMENT_INFO_ARRAY_V5
{
    ///Specifies the number of elements in <b>Elements</b>.
    uint NumElements;
    ///Pointer to a list of DHCP_SUBNET_ELEMENT_DATA_V5 structures that contain the data for the corresponding subnet
    ///elements.
    DHCP_SUBNET_ELEMENT_DATA_V5* Elements;
}

struct DHCP_PERF_STATS
{
    uint dwNumPacketsReceived;
    uint dwNumPacketsDuplicate;
    uint dwNumPacketsExpired;
    uint dwNumMilliSecondsProcessed;
    uint dwNumPacketsInActiveQueue;
    uint dwNumPacketsInPingQueue;
    uint dwNumDiscoversReceived;
    uint dwNumOffersSent;
    uint dwNumRequestsReceived;
    uint dwNumInformsReceived;
    uint dwNumAcksSent;
    uint dwNumNacksSent;
    uint dwNumDeclinesReceived;
    uint dwNumReleasesReceived;
    uint dwNumDelayedOfferInQueue;
    uint dwNumPacketsProcessed;
    uint dwNumPacketsInQuarWaitingQueue;
    uint dwNumPacketsInQuarReadyQueue;
    uint dwNumPacketsInQuarDecisionQueue;
}

///The <b>DHCP_BIND_ELEMENT</b> structure defines an individual network binding for the DHCP server. A single DHCP
///server can contain multiple bindings and serve multiple networks.
struct DHCP_BIND_ELEMENT
{
    ///Specifies a set of bit flags indicating properties of the network binding. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="DHCP_ENDPOINT_FLAG_CANT_MODIFY"></a><a
    ///id="dhcp_endpoint_flag_cant_modify"></a><dl> <dt><b>DHCP_ENDPOINT_FLAG_CANT_MODIFY</b></dt> <dt>0x01</dt> </dl>
    ///</td> <td width="60%"> The binding specified in this structure cannot be modified. </td> </tr> </table>
    uint   Flags;
    ///Specifies whether or not this binding is set on the DHCP server. If <b>TRUE</b>, the binding is set; if
    ///<b>FALSE</b>, it is not.
    BOOL   fBoundToDHCPServer;
    ///DHCP_IP_ADDRESS value that specifies the IP address assigned to the ethernet adapter of the DHCP server.
    uint   AdapterPrimaryAddress;
    ///DHCP_IP_ADDRESS value that specifies the subnet IP mask used by this ethernet adapter.
    uint   AdapterSubnetAddress;
    ///Unicode string that specifies the name assigned to this network interface device.
    PWSTR  IfDescription;
    ///Specifies the size of the network interface device ID, in bytes.
    uint   IfIdSize;
    ///Specifies the network interface device ID.
    ubyte* IfId;
}

///The <b>DHCP_BIND_ELEMENT_ARRAY</b> structure defines an array of network binding elements used by a DHCP server.
struct DHCP_BIND_ELEMENT_ARRAY
{
    ///Specifies the number of network binding elements listed in <i>Elements</i>.
    uint               NumElements;
    ///Specifies an array of DHCP_BIND_ELEMENT structures
    DHCP_BIND_ELEMENT* Elements;
}

///The <b>DHCPV6_BIND_ELEMENT</b> structure defines an IPv6 interface binding for the DHCP server over which it receives
///DHCPv6 packets.
struct DHCPV6_BIND_ELEMENT
{
    ///A set of bit flags indicating properties of the interface binding. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="DHCP_ENDPOINT_FLAG_CANT_MODIFY_"></a><a
    ///id="dhcp_endpoint_flag_cant_modify_"></a><dl> <dt><b>DHCP_ENDPOINT_FLAG_CANT_MODIFY </b></dt> </dl> </td> <td
    ///width="60%"> The endpoints cannot be modified. </td> </tr> </table>
    uint              Flags;
    ///If <b>TRUE</b>, the interface is bound to the DHCPv6 server; if <b>FALSE</b>, it is not.
    BOOL              fBoundToDHCPServer;
    ///DHCP_IPV6_ADDRESS structure that contains the IPv6 address assigned to the interface over which the DHCP server
    ///is receiving DHCPv6 packets.
    DHCP_IPV6_ADDRESS AdapterPrimaryAddress;
    ///DHCP_IPV6_ADDRESS structure that contains the IPv6 prefix ID of the subnet from which this interface is receiving
    ///DHCPv6 packets.
    DHCP_IPV6_ADDRESS AdapterSubnetAddress;
    ///Pointer to a null-terminated Unicode string that specifies the name assigned to this interface.
    PWSTR             IfDescription;
    ///Integer that specifies the IPv6 interface index of the current interface.
    uint              IpV6IfIndex;
    ///Integer that specifies the size of the interface GUID stored in <b>IfId</b>.
    uint              IfIdSize;
    ///Pointer to a BYTE blob that contains the GUID value assigned to this interface.
    ubyte*            IfId;
}

///The <b>DHCPV6_BIND_ELEMENT_ARRAY</b> structure specifies an array of DHCPV6_BIND_ELEMENT structures that contain
///DHCPv6 interface bindings.
struct DHCPV6_BIND_ELEMENT_ARRAY
{
    ///Integer that contains the total number of elements in the array pointed to by <b>Elements</b>.
    uint                 NumElements;
    ///Pointer to an array of DHCPV6_BIND_ELEMENT structures that contains the DHCPv6 interface bindings.
    DHCPV6_BIND_ELEMENT* Elements;
}

///The <b>DHCP_IP_RANGE_V6</b> structure specifies a range of IPv6 addresses for use with a DHCPv6 server.
struct DHCP_IP_RANGE_V6
{
    ///DHCP_IPV6_ADDRESS structure that contains the first IPv6 address in the range.
    DHCP_IPV6_ADDRESS StartAddress;
    ///DHCP_IPV6_ADDRESS structure that contains the last IPv6 address in the range.
    DHCP_IPV6_ADDRESS EndAddress;
}

///The <b>DHCP_HOST_INFO_V6</b> structure contains network information about a DHCPv6 server (host), such as its IPv6
///address and name.
struct DHCP_HOST_INFO_V6
{
    ///DHCP_IPV6_ADDRESS structure that contains the IPv6 address of the DHCPv6 server.
    DHCP_IPV6_ADDRESS IpAddress;
    ///Pointer to a Unicode string that contains the NetBIOS name of the DHCPv6 server.
    PWSTR             NetBiosName;
    ///Pointer to a Unicode string that contains the network name of the DHCPv6 server.
    PWSTR             HostName;
}

///The <b>DHCP_SUBNET_INFO_V6</b> structure contains information about an IPv6 subnet.
struct DHCP_SUBNET_INFO_V6
{
    ///DHCP_IPV6_ADDRESS structure containing the IPv6 prefix.
    DHCP_IPV6_ADDRESS SubnetAddress;
    ///<b>ULONG</b> value that specifies the length of the IPv6 prefix.
    uint              Prefix;
    ///<b>USHORT</b> value that specifies the preference for the IPv6 prefix.
    ushort            Preference;
    ///Pointer to a null-terminated Unicode string that contains the name of the IPv6 prefix.
    PWSTR             SubnetName;
    ///Pointer to a null-terminated Unicode string that contains an optional comment for the IPv6 prefix.
    PWSTR             SubnetComment;
    ///An enumeration of the DHCP_SUBNET_STATE that indicates the current state of the IPv6 prefix.
    uint              State;
    ///A <b>DWORD</b> value that serves as the unique identifier for the IPv6 prefix. This value is generated by the
    ///DHCPv6 server.
    uint              ScopeId;
}

struct SCOPE_MIB_INFO_V6
{
    DHCP_IPV6_ADDRESS Subnet;
    ulong             NumAddressesInuse;
    ulong             NumAddressesFree;
    ulong             NumPendingAdvertises;
}

///The <b>DHCP_MIB_INFO_V6</b> structure contains statistics for the DHCPv6 server.
struct DHCP_MIB_INFO_V6
{
    ///Integer value that specifies the number of DHCPSOLICIT messages received by the DHCPv6 server from DHCPv6
    ///clients.
    uint               Solicits;
    ///Integer value that specifies the number of DHCPADVERTISE messages sent by DHCPv6 server to DHCPv6 clients.
    uint               Advertises;
    ///Integer value that specifies the number of DHCPREQUEST messages sent by DHCPv6 server to DHCPv6 clients.
    uint               Requests;
    ///Integer value that specifies the number of DHCPRENEW messages sent by DHCPv6 server to DHCPv6 clients.
    uint               Renews;
    ///Integer value that specifies the number of DHCPREBIND messages sent by DHCPv6 server to DHCPv6 clients.
    uint               Rebinds;
    ///Integer value that specifies the number of DHCPREPLY messages sent by DHCPv6 server to DHCPv6 clients.
    uint               Replies;
    ///Integer value that specifies the number of DHCPCONFIRM messages sent by DHCPv6 server to DHCPv6 clients.
    uint               Confirms;
    ///Integer value that specifies the number of DHCPDECLINE messages sent by DHCPv6 server to DHCPv6 clients.
    uint               Declines;
    ///Integer value that specifies the number of DHCPRELEASE messages sent by DHCPv6 server to DHCPv6 clients.
    uint               Releases;
    ///Integer value that specifies the number of DHCPINFORM messages sent by DHCPv6 server to DHCPv6 clients.
    uint               Informs;
    ///DATE_TIME value that specifies the time the DHCPv6 server was started.
    DATE_TIME          ServerStartTime;
    ///Integer value that contains the number of IPv6 scopes configured on the current DHCPv6 server. This member
    ///defines the number of DHCPv6 scopes in the subsequent member <b>ScopeInfo</b>.
    uint               Scopes;
    ///Pointer to an array of SCOPE_MIB_INFO structures that contain statistics on individual scopes defined on the
    ///DHCPv6 server.
    SCOPE_MIB_INFO_V6* ScopeInfo;
}

///The <b>DHCP_IP_RESERVATION_V6</b> structure defines an IPv6 reservation for a DHCPv6 client in a specific IPv6
///prefix.
struct DHCP_IP_RESERVATION_V6
{
    ///DHCP_IPV6_ADDRESS structure that contains the IPv6 address of the DHCPv6 client for which an IPv6 reservation is
    ///created.
    DHCP_IPV6_ADDRESS ReservedIpAddress;
    ///DHCP_CLIENT_UID structure that contains the hardware address (MAC address) of the DHCPv6 client for which the
    ///IPv6 reservation is created.
    DHCP_BINARY_DATA* ReservedForClient;
    ///Integer that specifies the interface identifier for which the IPv6 reservation is created.
    uint              InterfaceId;
}

///The <b>DHCP_SUBNET_ELEMENT_DATA_V6</b> structure contains definitions for the elements of the IPv6 prefix, such as
///IPv6 reservation, IPv6 exclusion range, and IPv6 range.
struct DHCP_SUBNET_ELEMENT_DATA_V6
{
    ///Defines the set of possible prefix element types. This value is used to determine which of the values are chosen
    ///from the subsequent union element.
    DHCP_SUBNET_ELEMENT_TYPE_V6 ElementType;
union Element
    {
        DHCP_IP_RANGE_V6* IpRange;
        DHCP_IP_RESERVATION_V6* ReservedIp;
        DHCP_IP_RANGE_V6* ExcludeIpRange;
    }
}

union DHCP_SUBNET_ELEMENT_UNION_V6
{
}

///The <b>DHCP_SUBNET_ELEMENT_INFO_ARRAY_V6</b> structure contains data that defines an array of
///DHCP_SUBNET_ELEMENT_DATA_V6 IPv6 prefix elements.
struct DHCP_SUBNET_ELEMENT_INFO_ARRAY_V6
{
    ///A <b>DWORD</b> value containing the number of IPv6 subnet elements in the <b>Elements</b> member.
    uint NumElements;
    ///Pointer to an array of DHCP_SUBNET_ELEMENT_DATA_V6 structures that contain IPv6 prefix elements.
    DHCP_SUBNET_ELEMENT_DATA_V6* Elements;
}

///The <b>DHCP_CLIENT_INFO_V6</b> structure contains information on DHCPv6 clients.
struct DHCP_CLIENT_INFO_V6
{
    ///This is of type DHCP_IPV6_ADDRESS (section 2.2.1.2.28), containing the DHCPv6 client's IPv6 address.
    DHCP_IPV6_ADDRESS ClientIpAddress;
    ///This is of type DHCP_CLIENT_UID (section 2.2.1.2.5), containing the DHCPv6 client identifier.
    DHCP_BINARY_DATA  ClientDUID;
    ///This is of type <b>DWORD</b>, specifying the type of IPv6 address. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="ADDRESS_TYPE_IANA"></a><a id="address_type_iana"></a><dl>
    ///<dt><b>ADDRESS_TYPE_IANA</b></dt> <dt>0x00000000</dt> </dl> </td> <td width="60%"> Indicates an IANA address.
    ///[RFC3315] </td> </tr> <tr> <td width="40%"><a id="ADDRESS_TYPE_IATA"></a><a id="address_type_iata"></a><dl>
    ///<dt><b>ADDRESS_TYPE_IATA</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> Indicates an IATA address.
    ///[RFC3315] </td> </tr> </table>
    uint              AddressType;
    ///This is of type <b>DWORD</b>, specifying the interface identifier of the DHCPv6 client interface.
    uint              IAID;
    ///A pointer to a null-terminated Unicode string containing the name of the DHCPv6 client.
    PWSTR             ClientName;
    ///A pointer to a null-terminated Unicode string containing a comment relating to the DHCPv6 client.
    PWSTR             ClientComment;
    ///This is of type DATE_TIME (section 2.2.1.2.11), containing the valid lifetime of the DHCPv6 IPv6 client lease.
    DATE_TIME         ClientValidLeaseExpires;
    ///This is of type DATE_TIME, containing the preferred lifetime of the DHCPv6 client lease.
    DATE_TIME         ClientPrefLeaseExpires;
    ///This of type DHCP_HOST_INFO_V6 (section 2.2.1.2.63), containing information about the host machine (DHCPv6 server
    ///machine) that has given this IPv6 lease to this DHCPv6 client.
    DHCP_HOST_INFO_V6 OwnerHost;
}

///The <b>DHCPV6_IP_ARRAY</b> structure contains an array of DHCP IPv6 address structures.
struct DHCPV6_IP_ARRAY
{
    ///The number of elements in <b>Elements</b>.
    uint               NumElements;
    ///An array of DHCP_IPV6_ADDRESS structures.
    DHCP_IPV6_ADDRESS* Elements;
}

///The <b>DHCP_CLIENT_INFO_ARRAY_V6</b> structure defines an array of DHCP_CLIENT_INFO_V6 structures for use with DHCPv6
///client enumeration functions.
struct DHCP_CLIENT_INFO_ARRAY_V6
{
    ///Specifies the number of elements present in <b>Clients</b>.
    uint NumElements;
    ///Pointer to a list of DHCP_CLIENT_INFO_V6 structures that contain information on specific DHCPv6 subnet clients,
    ///including the dynamic address type (DHCP and/or BOOTP) and address state information.
    DHCP_CLIENT_INFO_V6** Clients;
}

///The <b>DHCP_SEARCH_INFO_V6</b> structure contains the term or value on which the DHCPv6 server database will be
///searched.
struct DHCP_SEARCH_INFO_V6
{
    ///Enumeration value that selects the type of the value on which the DHCPv6 database will be searched.
    DHCP_SEARCH_INFO_TYPE_V6 SearchType;
union SearchInfo
    {
        DHCP_IPV6_ADDRESS ClientIpAddress;
        DHCP_BINARY_DATA  ClientDUID;
        PWSTR             ClientName;
    }
}

///The <b>DHCP_POL_COND</b> structure defines the DHCP server policy condition.
struct DHCP_POL_COND
{
    ///Integer that specifies the expression index that corresponds to this constituent condition.
    uint                ParentExpr;
    ///DHCP_POL_ATTR_TYPE enumeration that specifies the attribute type for this condition.
    DHCP_POL_ATTR_TYPE  Type;
    ///DHCP_OPTION_ID value that specifies the unique option identifier for criteria based on DHCP options or
    ///sub-options.
    uint                OptionID;
    ///DHCP_OPTION_ID value that specifies the unique sub-option identifier.
    uint                SubOptionID;
    ///A pointer to a null-terminated Unicode string that represents the vendor name.
    PWSTR               VendorName;
    ///DHCP_POL_COMPARATOR enumeration that specifies the comparison operator for the condition.
    DHCP_POL_COMPARATOR Operator;
    ///Pointer to an array of bytes that contains the value to be used for the comparison.
    ubyte*              Value;
    ///Integer that specifies the length of <b>Value</b>.
    uint                ValueLength;
}

///The <b>DHCP_POL_COND_ARRAY</b> structure defines an array of DHCP server policy conditions.
struct DHCP_POL_COND_ARRAY
{
    ///Integer that specifies the number of DHCP server policy conditions in <i>Elements</i>.
    uint           NumElements;
    ///Pointer to a list of DHCP_POL_COND structures.
    DHCP_POL_COND* Elements;
}

///The <b>DHCP_POL_EXP</b> structure defines a DHCP server policy expression.
struct DHCP_POL_EXPR
{
    ///Integer that specifies the expression index that corresponds to this constituent condition.
    uint                ParentExpr;
    ///DHCP_POL_LOGIC_OPER enumeration that specifies how the results of the constituent conditions and sub-expressions
    ///must be grouped to evaluate this expression.
    DHCP_POL_LOGIC_OPER Operator;
}

///The <b>DHCP_POL_EXPR_ARRAY</b> structure defines an array of DHCP server policy expressions.
struct DHCP_POL_EXPR_ARRAY
{
    ///Integer that specifies the number of DHCP server policy expressions in <i>Elements</i>.
    uint           NumElements;
    ///Pointer to a list of DHCP_POL_EXPR structures.
    DHCP_POL_EXPR* Elements;
}

///The <b>DHCP_IP_RANGE_ARRAY</b> structure defines an array of DHCP IPv4 ranges.
struct DHCP_IP_RANGE_ARRAY
{
    ///Integer that specifies the number of DHCP IPv4 ranges in <b>Elements.</b>
    uint           NumElements;
    ///Pointer to a list of DHCP_IP_RANGE structures.
    DHCP_IP_RANGE* Elements;
}

///The <b>DHCP_POLICY</b> structure defines a DHCP server policy.
struct DHCP_POLICY
{
    ///Pointer to a null-terminated Unicode string that represents the DHCP server policy name.
    PWSTR                PolicyName;
    ///<b>TRUE</b> if the DHCP server policy is global. Otherwise, it is <b>FALSE</b>.
    BOOL                 IsGlobalPolicy;
    ///DHCP_IP_ADDRESS structure that specifies the IPv4 subnet ID for a scope level policy.
    uint                 Subnet;
    ///Integer that specifies the processing order of the DHCP server policy. 1 indicates the highest priority and
    ///<b>MAX_DWORD</b> indicates the lowest.
    uint                 ProcessingOrder;
    ///Pointer to a DHCP_POL_EXPR_ARRAY that specifies the DHCP server policy conditions.
    DHCP_POL_COND_ARRAY* Conditions;
    ///Pointer to a DHCP_POL_EXPR_ARRAY that specifies the DHCP server policy expressions.
    DHCP_POL_EXPR_ARRAY* Expressions;
    ///Pointer to a DHCP_IP_RANGE_ARRAY that specifies the DHCP server IPv4 range associated with the policy.
    DHCP_IP_RANGE_ARRAY* Ranges;
    ///A pointer to a null-terminated Unicode string that contains the description of the DHCP server policy.
    PWSTR                Description;
    ///<b>TRUE</b> if the policy is enabled. Otherwise, it is <b>FALSE</b>.
    BOOL                 Enabled;
}

///The <b>DHCP_POLICY_ARRAY</b> structure defines an array of DHCP server policies.
struct DHCP_POLICY_ARRAY
{
    ///Integer that specifies the number of DHCP server policies in <b>Elements</b>.
    uint         NumElements;
    ///Pointer to a list of DHCP_POLICY structures.
    DHCP_POLICY* Elements;
}

struct DHCP_POLICY_EX
{
    PWSTR                PolicyName;
    BOOL                 IsGlobalPolicy;
    uint                 Subnet;
    uint                 ProcessingOrder;
    DHCP_POL_COND_ARRAY* Conditions;
    DHCP_POL_EXPR_ARRAY* Expressions;
    DHCP_IP_RANGE_ARRAY* Ranges;
    PWSTR                Description;
    BOOL                 Enabled;
    DHCP_PROPERTY_ARRAY* Properties;
}

struct DHCP_POLICY_EX_ARRAY
{
    uint            NumElements;
    DHCP_POLICY_EX* Elements;
}

///The <b>DHCPV6_STATELESS_PARAMS</b> structure defines the DHCPv6 stateless client inventory configuration settings at
///server and scope level.
struct DHCPV6_STATELESS_PARAMS
{
    ///If <b>TRUE</b> the stateless client inventory is maintained by the DHCPv6 server. Otherwise, it is <b>FALSE</b>.
    ///The default value is <b>FALSE</b>, which indicates that the stateless client inventory is disabled and is not
    ///maintained the by the server.
    BOOL Status;
    ///Integer that specifies the maximum time interval, in hours, that stateless IPv6 DHCP client lease records can
    ///persist before being deleted from the DHCP server database.
    uint PurgeInterval;
}

///The <b>DHCPV6_STATELESS_SCOPE_STATS</b> structure defines the address counters for a specific IPv6 stateless subnet.
///The number of stateless IPv6 clients added and removed from the stateless client inventory are stored in this
///structure.
struct DHCPV6_STATELESS_SCOPE_STATS
{
    ///DHCP_IPV6_ADDRESS structure that specifies the IPv6 prefix of the DHCPv6 stateless scope.
    DHCP_IPV6_ADDRESS SubnetAddress;
    ///Integer that specifies the number of IPv6 stateless clients that have been added to the DHCPv6 stateless client
    ///inventory for the prefix in <b>SubnetAddress</b>.
    ulong             NumStatelessClientsAdded;
    ///Integer that specifies the number of IPv6 stateless clients that have been removed from the DHCPv6 stateless
    ///client inventory for the prefix in <b>SubnetAddress</b>.
    ulong             NumStatelessClientsRemoved;
}

///The <b>DHCPV6_STATELESS_STATS</b> structure defines an array of stateless IPv6 subnet statistics.
struct DHCPV6_STATELESS_STATS
{
    ///Integer that specifies the number of subnet statistics in <i>ScopeStats</i>.
    uint NumScopes;
    ///Pointer to a list of DHCPV6_STATELESS_SCOPE_STATS structures.
    DHCPV6_STATELESS_SCOPE_STATS* ScopeStats;
}

///The <b>DHCP_FAILOVER_RELATIONSHIP</b> structure defines information about a DHCPv4 server failover relationship.
struct DHCP_FAILOVER_RELATIONSHIP
{
    ///DHCP_IP_ADDRESS structure that contains the primary server IP address.
    uint                 PrimaryServer;
    ///DHCP_IP_ADDRESS structure that contains the secondary server IP address.
    uint                 SecondaryServer;
    ///DHCP_FAILOVER_MODE enumeration that specifies the failover relationship mode.
    DHCP_FAILOVER_MODE   Mode;
    ///DHCP_FAILOVER_SERVER enumeration that specifies if the server is the primary or secondary server in the failover
    ///relationship
    DHCP_FAILOVER_SERVER ServerType;
    ///FSM_STATE enumeration that specifies the state of the failover relationship.
    FSM_STATE            State;
    ///FSM_STATE enumeration that specifies the previous state of the failover relationship.
    FSM_STATE            PrevState;
    ///A value that specifies the Maximum Client Lead Time (MCLT) in seconds. The MCLT is the maximum time that one
    ///server can extend a lease for a client beyond the lease time known by the partner server.
    uint                 Mclt;
    ///The time, in seconds, a server will wait before transitioning from the COMMUNICATION-INT state to a
    ///<b>PARTNER-DOWN</b> state. The timer begins when the server enters the <b>COMMUNICATION-INT</b> state.
    uint                 SafePeriod;
    ///Pointer to a null-terminated Unicode string that represents the unique failover relationship name.
    PWSTR                RelationshipName;
    ///Pointer to a null-terminated Unicode string that represents the primary server hostname.
    PWSTR                PrimaryServerName;
    ///Pointer to a null-terminated Unicode string that represents the secondary server hostname.
    PWSTR                SecondaryServerName;
    ///A pointer to an LPDHCP_IP_ARRAY structure that contains the list of IPv4 subnet addresses that are part of the
    ///failover relationship and define its scope.
    DHCP_IP_ARRAY*       pScopes;
    ///Value that specifies the ratio of the client load shared by the primary server in the failover relationship.
    ubyte                Percentage;
    ///A pointer to a null-terminated Unicode string that represents the shared secret key associated with the failover
    ///relationship.
    PWSTR                SharedSecret;
}

///The <b>DHCP_FAILOVER_RELATIONSHIP_ARRAY</b> structure defines an array of DHCPv4 failover relationships between
///partner servers.
struct DHCP_FAILOVER_RELATIONSHIP_ARRAY
{
    ///Integer that specifies the number of DHCPv4 failover relationships in <b>pRelationships.</b>
    uint NumElements;
    ///Pointer to an array of DHCP_FAILOVER_RELATIONSHIP structures.
    DHCP_FAILOVER_RELATIONSHIP* pRelationships;
}

///The <b>DHCPV4_FAILOVER_CLIENT_INFO</b> structure defines DHCP server scope statistics that are part of a failover
///relationship.
struct DHCPV4_FAILOVER_CLIENT_INFO
{
    ///DHCP_IP_ADDRESS structure that contains the DHCPv4 client IPv4 address.
    uint             ClientIpAddress;
    ///DHCP_IP_MASK structure that contains the DHCPv4 client IPv4 subnet mask.
    uint             SubnetMask;
    ///DHCP_CLIENT_UID structure that contains the hardware address (MAC address) of the DHCPv4 client.
    DHCP_BINARY_DATA ClientHardwareAddress;
    ///Pointer to a null-terminated Unicode string that represents the DHCPv4 client machine name.
    PWSTR            ClientName;
    ///Pointer to a null-terminated Unicode string that represents the description of the DHCPv4 client.
    PWSTR            ClientComment;
    ///DATE_TIME structure that contains the lease expiry time for the DHCPv4 client. This is UTC time represented in
    ///the FILETIME format.
    DATE_TIME        ClientLeaseExpires;
    ///DHCP_HOST_INFO structure that contains information about the host machine (DHCPv4 server) that provided a lease
    ///to the DHCPv4 client.
    DHCP_HOST_INFO   OwnerHost;
    ///Value that specifies the DHCPv4 client type. The possible values are below. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="CLIENT_TYPE_UNSPECIFIED"></a><a
    ///id="client_type_unspecified"></a><dl> <dt><b>CLIENT_TYPE_UNSPECIFIED</b></dt> <dt>0x00</dt> </dl> </td> <td
    ///width="60%"> The DHCPv4 client is not defined in the server database. </td> </tr> <tr> <td width="40%"><a
    ///id="CLIENT_TYPE_DHCP"></a><a id="client_type_dhcp"></a><dl> <dt><b>CLIENT_TYPE_DHCP</b></dt> <dt>0x01</dt> </dl>
    ///</td> <td width="60%"> The DHCPv4 client supports the DHCP protocol. </td> </tr> <tr> <td width="40%"><a
    ///id="CLIENT_TYPE_BOOTP"></a><a id="client_type_bootp"></a><dl> <dt><b>CLIENT_TYPE_BOOTP</b></dt> <dt>0x02</dt>
    ///</dl> </td> <td width="60%"> The DHCPv4 client supports the BOOTP protocol. </td> </tr> <tr> <td width="40%"><a
    ///id="CLIENT_TYPE_BOTH"></a><a id="client_type_both"></a><dl> <dt><b>CLIENT_TYPE_BOTH</b></dt> <dt>0x03</dt> </dl>
    ///</td> <td width="60%"> The DHCPv4 client supports both the DHCPv4 and the BOOTP protocols </td> </tr> <tr> <td
    ///width="40%"><a id="CLIENT_TYPE_RESERVATION_FLAG"></a><a id="client_type_reservation_flag"></a><dl>
    ///<dt><b>CLIENT_TYPE_RESERVATION_FLAG</b></dt> <dt>0x04</dt> </dl> </td> <td width="60%"> There is an IPv4
    ///reservation created for the DHCPv4 client. </td> </tr> <tr> <td width="40%"><a id="CLIENT_TYPE_NONE"></a><a
    ///id="client_type_none"></a><dl> <dt><b>CLIENT_TYPE_NONE</b></dt> <dt>0x64</dt> </dl> </td> <td width="60%">
    ///Backward compatibility for manual addressing. </td> </tr> </table>
    ubyte            bClientType;
    ///Value that specifies various states of the IPv4 address. The LSB is bit 0 and the MSB is bit 7. The possible
    ///values are below. BIT 0 and BIT 1 signify the DHCPv4 client IPv4 address state, as shown in the following table.
    ///<table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="ADDRESS_STATE_OFFERED"></a><a
    ///id="address_state_offered"></a><dl> <dt><b>ADDRESS_STATE_OFFERED</b></dt> <dt>0x0</dt> </dl> </td> <td
    ///width="60%"> The DHCPv4 client is offered this IPv4 address. </td> </tr> <tr> <td width="40%"><a
    ///id="ADDRESS_STATE_ACTIVE"></a><a id="address_state_active"></a><dl> <dt><b>ADDRESS_STATE_ACTIVE</b></dt>
    ///<dt>0x1</dt> </dl> </td> <td width="60%"> The IPv4 address is active and has an active DHCPv4 client lease
    ///record. </td> </tr> <tr> <td width="40%"><a id="ADDRESS_STATE_DECLINED"></a><a
    ///id="address_state_declined"></a><dl> <dt><b>ADDRESS_STATE_DECLINED</b></dt> <dt>0x2</dt> </dl> </td> <td
    ///width="60%"> The IPv4 address request is declined by the DHCPv4 client; hence, it is a bad IPv4 address. </td>
    ///</tr> <tr> <td width="40%"><a id="ADDRESS_STATE_DOOM"></a><a id="address_state_doom"></a><dl>
    ///<dt><b>ADDRESS_STATE_DOOM</b></dt> <dt>0x3</dt> </dl> </td> <td width="60%"> The IPv4 address is in <i>DOOMED</i>
    ///state and is due to be deleted. </td> </tr> </table> BIT 2 and BIT 3 signify information related to Name
    ///Protection for the leased IPv4 address, as shown in the following table. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="ADDRESS_BIT_NO_DHCID"></a><a
    ///id="address_bit_no_dhcid"></a><dl> <dt><b>ADDRESS_BIT_NO_DHCID</b></dt> <dt>0x0</dt> </dl> </td> <td width="60%">
    ///The address is leased to the DHCPv4 client without <i>DHCID</i> as defined in sections 3 and 3.5 of RFC4701.
    ///</td> </tr> <tr> <td width="40%"><a id="ADDRESS_BIT_DHCID_NO_CLIENTIDOPTION"></a><a
    ///id="address_bit_dhcid_no_clientidoption"></a><dl> <dt><b>ADDRESS_BIT_DHCID_NO_CLIENTIDOPTION</b></dt>
    ///<dt>0x1</dt> </dl> </td> <td width="60%"> The address is leased to the DHCPv4 client with <i>DHCID</i> but
    ///without the client ID option as defined in sections 3 and 3.5 of RFC4701. </td> </tr> <tr> <td width="40%"><a
    ///id="ADDRESS_BIT_DHCID_WITH_CLIENTIDOPTION"></a><a id="address_bit_dhcid_with_clientidoption"></a><dl>
    ///<dt><b>ADDRESS_BIT_DHCID_WITH_CLIENTIDOPTION</b></dt> <dt>0x2</dt> </dl> </td> <td width="60%"> The address is
    ///leased to the DHCPv4 client with <i>DHCID</i> and the client ID option as defined in sections 3 and 3.5 of
    ///RFC4701. </td> </tr> <tr> <td width="40%"><a id="ADDRESS_BIT_DHCID_WITH_DUID"></a><a
    ///id="address_bit_dhcid_with_duid"></a><dl> <dt><b>ADDRESS_BIT_DHCID_WITH_DUID</b></dt> <dt>0x3</dt> </dl> </td>
    ///<td width="60%"> The address is leased to the DHCPv4 client with <i>DHCID</i> and the client DUID and as defined
    ///in sections 3 and 3.5 of RFC4701. </td> </tr> </table> BIT 4, BIT 5, BIT 6, and BIT 7 specify information related
    ///to DNS, as shown in the following table. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="ADDRESS_BIT_CLEANUP"></a><a id="address_bit_cleanup"></a><dl>
    ///<dt><b>ADDRESS_BIT_CLEANUP</b></dt> <dt>0x1</dt> </dl> </td> <td width="60%"> The DNS update for the DHCPv4
    ///client lease record needs to be deleted from the DNS server when the lease is deleted. </td> </tr> <tr> <td
    ///width="40%"><a id="ADDRESS_BIT_BOTH_REC"></a><a id="address_bit_both_rec"></a><dl>
    ///<dt><b>ADDRESS_BIT_BOTH_REC</b></dt> <dt>0x2</dt> </dl> </td> <td width="60%"> The DNS update needs to be sent
    ///for both DNS_A_DATA and DNS_PTR_DATA type resource records. </td> </tr> <tr> <td width="40%"><a
    ///id="ADDRESS_BIT_UNREGISTERED"></a><a id="address_bit_unregistered"></a><dl>
    ///<dt><b>ADDRESS_BIT_UNREGISTERED</b></dt> <dt>0x4</dt> </dl> </td> <td width="60%"> The DNS update is not complete
    ///for the lease record. </td> </tr> <tr> <td width="40%"><a id="ADDRESS_BIT_DELETED"></a><a
    ///id="address_bit_deleted"></a><dl> <dt><b>ADDRESS_BIT_DELETED</b></dt> <dt>0x8</dt> </dl> </td> <td width="60%">
    ///The address lease is expired, but the DNS updates for the lease record have not been deleted from the DNS server.
    ///</td> </tr> </table>
    ubyte            AddressState;
    ///QuarantineStatus enumeration that specifies possible health status values for the DHCPv4 client as validated at
    ///the NAP server.
    QuarantineStatus Status;
    ///DATE_TIME structure that contains the probation end time if the DHCPv4 client is on probation. The DHCPv4 client
    ///has full access to the network for this time period. This is UTC time represented in the FILETIME format.
    DATE_TIME        ProbationEnds;
    ///<b>TRUE</b>, if the DHCPv4 client is quarantine-enabled; Otherwise, it is <b>FALSE</b>.
    BOOL             QuarantineCapable;
    ///Time, in seconds, of potential-expiration-time sent to the partner server.
    uint             SentPotExpTime;
    ///Time, in seconds, of potential-expiration-time acknowledged by the partner server.
    uint             AckPotExpTime;
    ///Time, in seconds, of potential-expiration-time received from the partner server.
    uint             RecvPotExpTime;
    ///Time, in seconds, since the client lease first entered into its current state.
    uint             StartTime;
    ///Time, in seconds, since the client-last-transaction-time.
    uint             CltLastTransTime;
    ///Time, in seconds, since the partner server last updated the DHCPv4 client lease.
    uint             LastBndUpdTime;
    ///Reserved. Do not use.
    uint             BndMsgStatus;
    ///Pointer to a null-terminated Unicode string that represents the DHCP server policy name that resulted in the IPv4
    ///address assignment to the DHCPv4 client in the lease.
    PWSTR            PolicyName;
    ///Reserved. Do not use.
    ubyte            Flags;
}

///The <b>DHCPV4_FAILOVER_CLIENT_INFO_ARRAY</b> structure defines an array of DHCP server scope statistics that are part
///of a failover relationship.
struct DHCPV4_FAILOVER_CLIENT_INFO_ARRAY
{
    ///Integer that specifies the number of DHCP server scope statistics in <b>Clients</b>.
    uint NumElements;
    ///Pointer to an array of DHCPV4_FAILOVER_CLIENT_INFO structures.
    DHCPV4_FAILOVER_CLIENT_INFO** Clients;
}

struct DHCPV4_FAILOVER_CLIENT_INFO_EX
{
    uint             ClientIpAddress;
    uint             SubnetMask;
    DHCP_BINARY_DATA ClientHardwareAddress;
    PWSTR            ClientName;
    PWSTR            ClientComment;
    DATE_TIME        ClientLeaseExpires;
    DHCP_HOST_INFO   OwnerHost;
    ubyte            bClientType;
    ubyte            AddressState;
    QuarantineStatus Status;
    DATE_TIME        ProbationEnds;
    BOOL             QuarantineCapable;
    uint             SentPotExpTime;
    uint             AckPotExpTime;
    uint             RecvPotExpTime;
    uint             StartTime;
    uint             CltLastTransTime;
    uint             LastBndUpdTime;
    uint             BndMsgStatus;
    PWSTR            PolicyName;
    ubyte            Flags;
    uint             AddressStateEx;
}

///The <b>DHCP_FAILOVER_STATISTICS</b> structure defines DHCP server scope statistics that are part of a failover
///relationship.
struct DHCP_FAILOVER_STATISTICS
{
    ///Value that specifies the total number of addresses in a DHCPv4 scope that are part of a failover relationship.
    uint NumAddr;
    ///Value that specifies the total number of free IPv4 addresses that can be leased out to clients in a DHCPv4 scope
    ///that are part of a failover relationship.
    uint AddrFree;
    ///Value that specifies the total number of IPv4 addresses that are leased out to clients in a DHCPv4 scope that are
    ///part of a failover relationship.
    uint AddrInUse;
    ///Value that specifies the number of free IPv4 addresses on the partner server that can be leased out to clients in
    ///a DHCPv4 scope that are part of a failover relationship.
    uint PartnerAddrFree;
    ///Value that specifies the number of free IPv4 addresses on the local server that can be leased out to clients in a
    ///DHCPv4 scope that are part of a failover relationship.
    uint ThisAddrFree;
    ///Value that specifies the number of IPv4 addresses on the partner server that are leased out to clients in a
    ///DHCPv4 scope that are part of a failover relationship.
    uint PartnerAddrInUse;
    ///Value that specifies the number of IPv4 addresses on the local server that are leased out to clients in a DHCPv4
    ///scope that are part of a failover relationship.
    uint ThisAddrInUse;
}

// Functions

///The <b>Dhcpv6CApiInitialize</b> function must be the first function call made by users of DHCPv6. The function
///prepares the system for all other DHCPv6 function calls. Other DHCPv6 functions should only be called if the
///<b>Dhcpv6CApiInitialize</b> function executes successfully.
///Params:
///    Version = Pointer to the DHCPv6 version implemented by the client. If a valid pointer is passed, the DHCPv6 client will be
///              returned through it.
///Returns:
///    Returns ERROR_SUCCESS upon successful completion.
///    
@DllImport("dhcpcsvc6")
void Dhcpv6CApiInitialize(uint* Version);

///The <b>Dhcpv6CApiCleanup</b> function enables DHCPv6 to properly clean up resources allocated throughout the use of
///DHCPv6 function calls. The <b>Dhcpv6CApiCleanup</b> function must only be called if a previous call to
///Dhcpv6CApiInitialize executed successfully.
@DllImport("dhcpcsvc6")
void Dhcpv6CApiCleanup();

///The Dhcpv6RequestParams function requests options from the DHCPv6 client cache or directly from the DHCPv6 server.
///Params:
///    forceNewInform = If this value is set to <b>TRUE</b>, any available cached information will be ignored and new information will be
///                     requested. Otherwise, the request is only sent if there is no cached information.
///    reserved = Reserved for future use. Must be set to <b>NULL</b>.
///    adapterName = GUID of the adapter for which this request is meant. This parameter must not be <b>NULL</b>.
///    classId = Pointer to a DHCPV6CAPI_CLASSID structure that contains the binary ClassId information to use to send on the
///              wire. This parameter is optional.
///    recdParams = A DHCPV6CAPI_PARAMS_ARRAY structure that contains the parameters to be received from the DHCPV6 server.
///    buffer = A buffer to contain information returned by some pointers in <i>recdParams</i>.
///    pSize = Size of the buffer. When the function returns ERROR_MORE_DATA, this parameter will contain the size, in bytes,
///            required to complete the operation. If the function is successful, this parameter contains the number of bytes
///            used.
@DllImport("dhcpcsvc6")
uint Dhcpv6RequestParams(BOOL forceNewInform, void* reserved, PWSTR adapterName, DHCPV6CAPI_CLASSID* classId, 
                         DHCPV6CAPI_PARAMS_ARRAY recdParams, ubyte* buffer, uint* pSize);

///The <b>Dhcpv6RequestPrefix</b> function requests a specific prefix.
///Params:
///    adapterName = GUID of the adapter on which the prefix request must be sent.
///    pclassId = Pointer to a DHCPV6CAPI_CLASSID structure that contains the binary ClassId information to send on the wire. This
///               parameter is optional. <div class="alert"><b>Note</b> DHCPv6 Option Code 15 (0x000F) is not supported by this
///               API. Typically, the User Class option is used by a client to identify the type or category of user or application
///               it represents. A server selects the configuration information for the client based on the classes identified in
///               this option.</div> <div> </div>
///    prefixleaseInfo = Pointer to a DHCPV6PrefixLeaseInformation structure that contains the prefix lease information. The following
///                      members of the DHCPV6PrefixLeaseInformation structure must follow these guidelines. <table> <tr> <th>
///                      DHCPV6PrefixLeaseInformation member</th> <th>Consideration</th> </tr> <tr> <td><b>nPrefixes</b></td> <td>Must
///                      contain a maximum value of 10. The caller should have the memory allocated in the <b>prefixArray</b> member based
///                      on the number of prefixes specified. </td> </tr> <tr> <td><b>iaid</b></td> <td>A unique positive number assigned
///                      to this member. This same value should be reused if this function is called again.This mandatory value must be
///                      set by the calling application. </td> </tr> <tr> <td><b>ServerIdLen</b></td> <td>Must contain a maximum value of
///                      128. The caller must have the memory allocated in the <b>ServerId</b> member based on the specified
///                      <b>ServerIdLen</b> value.</td> </tr> </table> The caller must follow these considerations when assigning the
///                      values of the <b>nPrefixes</b>, <b>iaid</b>, and <b>ServerIdLen</b> members of the DHCPV6PrefixLeaseInformation
///                      structure. Based on these values, memory must also be properly allocated to the <b>ServerId</b> and
///                      <b>PrefixArray</b> members before the <b>Dhcpv6RequestPrefix</b> function is called.
///    pdwTimeToWait = Contains the number of seconds a requesting application needs to wait before calling the Dhcpv6RenewPrefix
///                    function to renew its acquired prefixes. A value of 0xFFFFFFFF indicates that the application does not need to
///                    renew its lease.
@DllImport("dhcpcsvc6")
uint Dhcpv6RequestPrefix(PWSTR adapterName, DHCPV6CAPI_CLASSID* pclassId, 
                         DHCPV6PrefixLeaseInformation* prefixleaseInfo, uint* pdwTimeToWait);

///The <b>Dhcpv6RenewPrefix</b> function renews a prefix previously acquired with the Dhcpv6RequestPrefix function.
///Params:
///    adapterName = GUID of the adapter on which the prefix renewal must be sent.
///    pclassId = Pointer to a DHCPV6CAPI_CLASSID structure that contains the binary ClassId information to send on the wire. This
///               parameter is can be <b>NULL</b>. <div class="alert"><b>Note</b> DHCPv6 Option Code 15 (0x000F) is not supported
///               by this API. Typically, the User Class option is used by a client to identify the type or category of user or
///               application it represents. A server selects the configuration information for the client based on the classes
///               identified in this option.</div> <div> </div>
///    prefixleaseInfo = Pointer to a DHCPV6PrefixLeaseInformation structure that contains the prefix lease information.
///    pdwTimeToWait = Contains the number of seconds a requesting application needs to wait before calling the <b>Dhcpv6RenewPrefix</b>
///                    function to renew its acquired prefixes. A value of 0xFFFFFFFF indicates that the application does not need to
///                    renew its lease.
///    bValidatePrefix = Specifies to the DHCPv6 client whether or not to send a REBIND in order to validate the prefix bindings.
///                      <b>TRUE</b> indicates that a REBIND is required. <b>FALSE</b> indicates RENEW is required.
@DllImport("dhcpcsvc6")
uint Dhcpv6RenewPrefix(PWSTR adapterName, DHCPV6CAPI_CLASSID* pclassId, 
                       DHCPV6PrefixLeaseInformation* prefixleaseInfo, uint* pdwTimeToWait, uint bValidatePrefix);

///The Dhcpv6ReleasePrefix function releases a prefix previously acquired with the <b>Dhcpv6RequestPrefix</b> function.
///Params:
///    adapterName = Name of the adapter on which the PD request must be sent.
///    classId = Pointer to a DHCPV6CAPI_CLASSID structure that contains the binary ClassId information to use to send on the
///              wire. <div class="alert"><b>Note</b> DHCPv6 Option Code 15 (0x000F) is not supported by this API. Typically, the
///              User Class option is used by a client to identify the type or category of user or application it represents. A
///              server selects the configuration information for the client based on the classes identified in this option.</div>
///              <div> </div>
///    leaseInfo = Pointer to a DHCPV6CAPIPrefixLeaseInformation structure that is used to release the prefix.
///Returns:
///    Returns ERROR_SUCCESS upon successful completion. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> Returned if one
///    of the following conditions are true: <ul> <li><i>AdapterName</i> is <b>NULL</b>. Or no adapter is found with the
///    GUID specified.</li> <li><i>prefixleaseInfo</i> is <b>NULL</b>.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_NAME</b></dt> </dl> </td> <td width="60%"> The <i>AdapterName</i> is not in the correct
///    format. It should be in this format: {00000000-0000-0000-0000-000000000000}. </td> </tr> </table>
///    
@DllImport("dhcpcsvc6")
uint Dhcpv6ReleasePrefix(PWSTR adapterName, DHCPV6CAPI_CLASSID* classId, DHCPV6PrefixLeaseInformation* leaseInfo);

///The <b>DhcpCApiInitialize</b> function must be the first function call made by users of DHCP; it prepares the system
///for all other DHCP function calls. Other DHCP functions should only be called if the <b>DhcpCApiInitialize</b>
///function executes successfully.
///Params:
///    Version = Pointer to the DHCP version implemented by the client.
///Returns:
///    Returns ERROR_SUCCESS upon successful completion.
///    
@DllImport("dhcpcsvc")
uint DhcpCApiInitialize(uint* Version);

///The <b>DhcpCApiCleanup</b> function enables DHCP to properly clean up resources allocated throughout the use of DHCP
///function calls. The <b>DhcpCApiCleanup</b> function must only be called if a previous call to DhcpCApiInitialize
///executed successfully.
@DllImport("dhcpcsvc")
void DhcpCApiCleanup();

///The <b>DhcpRequestParams</b> function enables callers to synchronously, or synchronously and persistently obtain DHCP
///data from a DHCP server.
///Params:
///    Flags = Flags that specify the data being requested. This parameter is optional. The following possible values are
///            supported and are not mutually exclusive: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///            width="40%"><a id="DHCPCAPI_REQUEST_PERSISTENT"></a><a id="dhcpcapi_request_persistent"></a><dl>
///            <dt><b>DHCPCAPI_REQUEST_PERSISTENT</b></dt> </dl> </td> <td width="60%"> The request is persisted but no options
///            are fetched. </td> </tr> <tr> <td width="40%"><a id="DHCPCAPI_REQUEST_SYNCHRONOUS"></a><a
///            id="dhcpcapi_request_synchronous"></a><dl> <dt><b>DHCPCAPI_REQUEST_SYNCHRONOUS</b></dt> </dl> </td> <td
///            width="60%"> Options will be fetched from the server. </td> </tr> </table>
///    Reserved = Reserved for future use. Must be set to <b>NULL</b>.
///    AdapterName = GUID of the adapter on which requested data is being made. Must be under 256 characters.
///    ClassId = Class identifier (ID) that should be used if DHCP INFORM messages are being transmitted onto the network. This
///              parameter is optional.
///    SendParams = Optional data to be requested, in addition to the data requested in the <i>RecdParams</i> array. The
///                 <i>SendParams</i> parameter cannot contain any of the standard options that the DHCP client sends by default.
///    RecdParams = Array of DHCP data the caller is interested in receiving. This array must be empty prior to the
///                 <b>DhcpRequestParams</b> function call.
///    Buffer = Buffer used for storing the data associated with requests made in <i>RecdParams</i>.
///    pSize = Size of <i>Buffer</i>. Required size of the buffer, if it is insufficiently sized to hold the data, otherwise
///            indicates size of the buffer which was successfully filled.
///    RequestIdStr = Application identifier (ID) used to facilitate a persistent request. Must be a printable string with no special
///                   characters (commas, backslashes, colons, or other illegal characters may not be used). The specified application
///                   identifier (ID) is used in a subsequent <b>DhcpUndoRequestParams</b> function call to clear the persistent
///                   request, as necessary.
///Returns:
///    Returns ERROR_SUCCESS upon successful completion. Upon return, <i>RecdParams</i> is filled with pointers to
///    requested data, with corresponding data placed in <i>Buffer</i>. If <i>pSize</i> indicates that <i>Buffer</i> has
///    insufficient space to store returned data, the <b>DhcpRequestParams</b> function returns ERROR_MORE_DATA, and
///    returns the required buffer size in <i>pSize</i>. Note that the required size of <i>Buffer</i> may increase
///    during the time that elapses between the initial function call's return and a subsequent call; therefore, the
///    required size of <i>Buffer</i> (indicated in <i>pSize</i>) provides an indication of the approximate size
///    required of <i>Buffer</i>, rather than guaranteeing that subsequent calls will return successfully if
///    <i>Buffer</i> is set to the size indicated in <i>pSize</i>. Other errors return appropriate Windows error codes.
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> Returned if the AdapterName parameter is
///    over 256 characters long. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BUFFER_OVERFLOW</b></dt> </dl>
///    </td> <td width="60%"> Returned if the AdapterName parameter is over 256 characters long. </td> </tr> </table>
///    
@DllImport("dhcpcsvc")
uint DhcpRequestParams(uint Flags, void* Reserved, PWSTR AdapterName, DHCPCAPI_CLASSID* ClassId, 
                       DHCPCAPI_PARAMS_ARRAY SendParams, DHCPCAPI_PARAMS_ARRAY RecdParams, ubyte* Buffer, 
                       uint* pSize, PWSTR RequestIdStr);

///The <b>DhcpUndoRequestParams</b> function removes persistent requests previously made with a <b>DhcpRequestParams</b>
///function call.
///Params:
///    Flags = Reserved. Must be zero.
///    Reserved = Reserved for future use. Must be set to <b>NULL</b>.
///    AdapterName = GUID of the adapter for which information is no longer required. Must be under 256 characters. <div
///                  class="alert"><b>Note</b> This parameter is no longer used.</div> <div> </div>
///    RequestIdStr = Application identifier (ID) originally used to make a persistent request. This string must match the
///                   <i>RequestIdStr</i> parameter used in the <b>DhcpRequestParams</b> function call that obtained the corresponding
///                   persistent request. Note that this must match the previous application identifier (ID) used, and must be a
///                   printable string with no special characters (commas, backslashes, colons, or other illegal characters may not be
///                   used).
///Returns:
///    Returns ERROR_SUCCESS upon successful completion. Otherwise, returns a Windows error code.
///    
@DllImport("dhcpcsvc")
uint DhcpUndoRequestParams(uint Flags, void* Reserved, PWSTR AdapterName, PWSTR RequestIdStr);

///The <b>DhcpRegisterParamChange</b> function enables clients to register for notification of changes in DHCP
///configuration parameters.
///Params:
///    Flags = Reserved. Must be set to DHCPCAPI_REGISTER_HANDLE_EVENT. If it is not set to this flag value, the API call will
///            not be successful.
///    Reserved = Reserved. Must be set to <b>NULL</b>.
///    AdapterName = GUID of the adapter for which event notification is being requested. Must be under 256 characters.
///    ClassId = Reserved. Must be set to <b>NULL</b>.
///    Params = Parameters for which the client is interested in registering for notification, in the form of a
///             DHCPCAPI_PARAMS_ARRAY structure.
///    Handle = Attributes of <i>Handle</i> are determined by the value of <i>Flags</i>. In version 2 of the DHCP API,
///             <i>Flags</i> must be set to DHCPCAPI_REGISTER_HANDLE_EVENT, and therefore, <i>Handle</i> must be a pointer to a
///             <b>HANDLE</b> variable that will hold the handle to a Windows event that gets signaled when parameters specified
///             in <i>Params</i> change. Note that this <b>HANDLE</b> variable is used in a subsequent call to the
///             <b>DhcpDeRegisterParamChange</b> function to deregister event notifications associated with this particular call
///             to the <b>DhcpRegisterParamChange</b> function.
///Returns:
///    Returns ERROR_SUCCESS upon successful completion. Otherwise, returns Windows error codes. <table> <tr> <th>Return
///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl>
///    </td> <td width="60%"> Returned if the AdapterName parameter is over 256 characters long. </td> </tr> </table>
///    
@DllImport("dhcpcsvc")
uint DhcpRegisterParamChange(uint Flags, void* Reserved, PWSTR AdapterName, DHCPCAPI_CLASSID* ClassId, 
                             DHCPCAPI_PARAMS_ARRAY Params, void* Handle);

///The <b>DhcpDeRegisterParamChange</b> function releases resources associated with previously registered event
///notifications, and closes the associated event handle.
///Params:
///    Flags = Reserved. Must be set to zero.
///    Reserved = Reserved. Must be set to <b>NULL</b>.
///    Event = Must be the same value as the <b>HANDLE</b> variable in the DhcpRegisterParamChange function call for which the
///            client is deregistering event notification.
///Returns:
///    Returns ERROR_SUCCESS upon successful completion. Otherwise, returns Windows error codes.
///    
@DllImport("dhcpcsvc")
uint DhcpDeRegisterParamChange(uint Flags, void* Reserved, void* Event);

///The <b>DhcpRemoveDNSRegistrations</b> function removes all DHCP-initiated DNS registrations for the client.
///Returns:
///    Returns ERROR_SUCCESS upon successful completion.
///    
@DllImport("dhcpcsvc")
uint DhcpRemoveDNSRegistrations();

@DllImport("dhcpcsvc")
uint DhcpGetOriginalSubnetMask(const(PWSTR) sAdapterName, uint* dwSubnetMask);

///The <b>DhcpAddFilterV4</b> function adds a link-layer address or address pattern to the allow/deny lists.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    AddFilterInfo = Pointer to a DHCP_FILTER_ADD_INFO structure that contains a link-layer address or address pattern to add to the
///                    DHCP server's allow/deny list.
///    ForceFlag = If <b>TRUE</b>, any existing matching filter is overwritten; if <b>FALSE</b>, the call fails with
///                <b>ERROR_DHCP_LINKLAYER_ADDRESS_EXISTS</b>.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_LINKLAYER_ADDRESS_EXISTS</b></dt>
///    </dl> </td> <td width="60%"> The address or address pattern already exists in an allow/deny list. </td> </tr>
///    </table>
///    
@DllImport("DHCPSAPI")
uint DhcpAddFilterV4(const(PWSTR) ServerIpAddress, DHCP_FILTER_ADD_INFO* AddFilterInfo, BOOL ForceFlag);

///The <b>DhcpDeleteFilterV4</b> function deletes a link-layer address or address pattern from a DHCP server's
///allow/deny lists.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    DeleteFilterInfo = Pointer to a DHCP_ADDR_PATTERN structure that contains the link-layer address or address pattern filter to remove
///                       from the DHCP server database.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_LINKLAYER_ADDRESS_DOES_NOT_EXIST</b></dt> </dl> </td> <td width="60%"> The address or address
///    pattern does not exist in an allow/deny list. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The address or address pattern supplied in
///    <i>DeleteFilterInfo</i> is invalid. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpDeleteFilterV4(const(PWSTR) ServerIpAddress, DHCP_ADDR_PATTERN* DeleteFilterInfo);

///The <b>DhcpSetFilterV4</b> function enables or disables the allow and deny lists on a DHCP server.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    GlobalFilterInfo = Pointer to a DHCP_FILTER_GLOBAL_INFO structure that contains information used to enable or disable allow and deny
///                       lists.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One of the parameters provides an invalid value. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpSetFilterV4(const(PWSTR) ServerIpAddress, DHCP_FILTER_GLOBAL_INFO* GlobalFilterInfo);

///The <b>DhcpGetFilterV4</b> function retrieves the enable/disable settings for the DHCPv4 server's allow/deny lists.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    GlobalFilterInfo = Pointer to a DHCP_FILTER_GLOBAL_INFO structure that contains the enable/disable settings for the DHCPv6 server's
///                       allow/deny lists.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpGetFilterV4(const(PWSTR) ServerIpAddress, DHCP_FILTER_GLOBAL_INFO* GlobalFilterInfo);

///The <b>DhcpEnumFilterV4</b> function enumerates all of the filter records from the DHCP server's allow or deny list.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    ResumeHandle = Pointer to a DHCP_ADDR_PATTERN structure that identifies the enumeration operation. Initially this parameter must
///                   be set to zero (0), with a successful call returning the address/pattern value used for subsequent enumeration
///                   requests.
///    PreferredMaximum = A DWORD value that specifies the preferred maximum number of bytes to return. If the number of remaining
///                       unenumerated filter information size is less than this value, then all the filters configured on the particular
///                       list on the DHCP server are returned. The maximum value for this is 64 (kilobytes), and the minimum value is 1
///                       (kilobyte).
///    ListType = A DHCP_FILTER_LIST_TYPE that specifies the list of filters to be enumerated.
///    EnumFilterInfo = Pointer to the address of an array of DHCP_FILTER_ENUM_INFO structures that contain the returned link-layer
///                     filter information configured on the DHCP server.
///    ElementsRead = Pointer to a <b>DWORD</b> value that specifies the number of link-layer filter entries returned in
///                   <i>EnumFilterInfo</i>.
///    ElementsTotal = Pointer to a <b>DWORD</b> value that specifies the number of link-layer filter entries defined on the DHCP server
///                    that have not yet been enumerated.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> There are no more elements available for enumeration. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> There are no more elements left to enumerate.
///    </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpEnumFilterV4(const(PWSTR) ServerIpAddress, DHCP_ADDR_PATTERN* ResumeHandle, uint PreferredMaximum, 
                      DHCP_FILTER_LIST_TYPE ListType, DHCP_FILTER_ENUM_INFO** EnumFilterInfo, uint* ElementsRead, 
                      uint* ElementsTotal);

///The <b>DhcpCreateSubnet</b> function creates a new subnet on the DHCP server.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    SubnetAddress = DHCP_IP_ADDRESS value that contains the IP address of the subnet's gateway.
///    SubnetInfo = DHCP_SUBNET_INFO structure that contains specific settings for the subnet, including the subnet mask and IP
///                 address of the subnet gateway.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpCreateSubnet(const(PWSTR) ServerIpAddress, uint SubnetAddress, const(DHCP_SUBNET_INFO)* SubnetInfo);

///The <b>DhcpSetSubnetInfo</b> function sets information about a subnet defined on the DHCP server.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    SubnetAddress = DHCP_IP_ADDRESS value that specifies the IP address of the subnet gateway, as well as uniquely identifies the
///                    subnet.
///    SubnetInfo = Pointer to a DHCP_SUBNET_INFO structure that contains the information about the subnet.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpSetSubnetInfo(const(PWSTR) ServerIpAddress, uint SubnetAddress, const(DHCP_SUBNET_INFO)* SubnetInfo);

///The <b>DhcpGetSubnetInfo</b> function returns information on a specific subnet.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    SubnetAddress = DHCP_IP_ADDRESS value that specifies the subnet ID.
///    SubnetInfo = DHCP_SUBNET_INFO structure that contains the returned information for the subnet matching the ID specified by
///                 <i>SubnetAddress</i>. <div class="alert"><b>Note</b> <p class="note">The memory for this parameter must be free
///                 using DhcpRpcFreeMemory. </div> <div> </div>
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpGetSubnetInfo(const(PWSTR) ServerIpAddress, uint SubnetAddress, DHCP_SUBNET_INFO** SubnetInfo);

///The <b>DhcpEnumSubnets</b> function returns an enumerated list of subnets defined on the DHCP server.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    ResumeHandle = Pointer to a DHCP_RESUME_HANDLE value that identifies the enumeration operation. Initially, this value should be
///                   zero, with a successful call returning the handle value used for subsequent enumeration requests. For example, if
///                   <i>PreferredMaximum</i> is set to 100, and 200 subnet addresses are stored on the server, the resume handle can
///                   be used after the first 100 subnets are retrieved to obtain the next 100 on a subsequent call, and so forth.
///    PreferredMaximum = Specifies the preferred maximum number of subnet addresses to return. If the number of remaining unenumerated
///                       options is less than this value, then that amount will be returned.
///    EnumInfo = Pointer to a DHCP_IP_ARRAY structure that contains the subnet IDs available on the DHCP server. If no subnets are
///               defined, this value will be null.
///    ElementsRead = Pointer to a <b>DWORD</b> value that specifies the number of subnet addresses returned in <i>EnumInfo</i>.
///    ElementsTotal = Pointer to a <b>DWORD</b> value that specifies the number of subnets defined on the DHCP server that have not yet
///                    been enumerated.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. If a call is made with the same
///    <i>ResumeHandle</i> value and all items on the server have been enumerated, this method returns
///    <b>ERROR_NO_MORE_ITEMS</b> with <i>ElementsRead</i> and <i>ElementsTotal</i> set to 0. Otherwise, it returns one
///    of the DHCP Server Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpEnumSubnets(const(PWSTR) ServerIpAddress, uint* ResumeHandle, uint PreferredMaximum, 
                     DHCP_IP_ARRAY** EnumInfo, uint* ElementsRead, uint* ElementsTotal);

///The <b>DhcpAddSubnetElement</b> function adds an element describing a feature or aspect of the subnet to the subnet
///entry in the DHCP database.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that contains the IPv4 address of the subnet DHCP server.
///    SubnetAddress = DHCP_IP_ADDRESS structure that contains the IPv4 address of the subnet.
///    AddElementInfo = Pointer to a DHCP_SUBNET_ELEMENT_DATA structure that contains information about the subnet element corresponding
///                     to the IPv4 subnet specified in <i>SubnetAddress</i>.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl> </td>
///    <td width="60%"> The specified IPv4 subnet does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_INVALID_RANGE</b></dt> </dl> </td> <td width="60%"> The specified IPv4 address range either
///    overlaps an existing range or is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_IPRANGE_CONV_ILLEGAL</b></dt> </dl> </td> <td width="60%"> Conversion of a scope to a
///    DHCPv4-only scope or to a BOOTP-only scope is not allowed when DHCPv4 and BOOTP clients are present in the scope
///    to convert. Manually delete either the DHCPv4 or the BOOTP clients from the scope, as appropriate for the type of
///    scope being created. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_IPRANGE_EXISTS</b></dt> </dl> </td>
///    <td width="60%"> The specified IPv4 address range already exists. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_MSCOPE_RANGE_TOO_SMALL</b></dt> </dl> </td> <td width="60%"> The multicast scope range must
///    allow for at least 256 IPv4 addresses. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_NOT_RESERVED_CLIENT</b></dt> </dl> </td> <td width="60%"> The specified DHCPv4 client is not an
///    IPv4 reserverdclient. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_RESERVEDIP_EXISTS</b></dt> </dl>
///    </td> <td width="60%"> The specified IPv4 address or hardware address is in use by another DHCPv4 client. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_ADDRESS</b></dt> </dl> </td> <td width="60%"> The specified
///    address is not available. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpAddSubnetElement(const(PWSTR) ServerIpAddress, uint SubnetAddress, 
                          const(DHCP_SUBNET_ELEMENT_DATA)* AddElementInfo);

///The <b>DhcpEnumSubnetElements</b> function returns an enumerated list of elements for a specific DHCP subnet.
///Params:
///    ServerIpAddress = Unicode string that specifies the IPv4 address of the DHCP server.
///    SubnetAddress = DHCP_IP_ADDRESS value that specifies the address of the IPv4 subnet whose elements will be enumerated.
///    EnumElementType = DHCP_SUBNET_ELEMENT_TYPE enumeration value that indicates the type of subnet element to enumerate.
///    ResumeHandle = Pointer to a DHCP_RESUME_HANDLE value that identifies the enumeration operation. Initially, this value should be
///                   zero, with a successful call returning the handle value used for subsequent enumeration requests. For example, if
///                   <i>PreferredMaximum</i> is set to 1000 bytes, and 2000 bytes worth of subnet elements are stored on the server,
///                   the resume handle can be used after the first 1000 bytes are retrieved to obtain the next 1000 on a subsequent
///                   call, and so forth. The presence of additional enumerable data is indicated when this function returns
///                   ERROR_MORE_DATA. If no additional enumerable data is available on the DHCPv4 server, ERROR_NO_MORE_ITEMS is
///                   returned.
///    PreferredMaximum = Specifies the preferred maximum number of bytes of subnet elements to return. If the number of remaining
///                       unenumerated options (in bytes) is less than this value, then that amount will be returned. To retrieve all the
///                       subnet client elements for the default user and vendor class at the specified level, set this parameter to
///                       0xFFFFFFFF.
///    EnumElementInfo = Pointer to a pointer to a DHCP_SUBNET_ELEMENT_INFO_ARRAY structure containing an enumerated list of all elements
///                      available for the specified subnet. If no elements are available for enumeration, this value will be null.
///    ElementsRead = Pointer to a DWORD value that specifies the number of subnet elements returned in <i>EnumElementInfo</i>.
///    ElementsTotal = Pointer to a DWORD value that specifies the total number of as-yet unenumerated elements remaining on the server
///                    for the specified subnet.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> There are more elements available to enumerate. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> There are no more elements left to enumerate.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
///    The specified IPv4 subnet does not exist on the DHCP server. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpEnumSubnetElements(const(PWSTR) ServerIpAddress, uint SubnetAddress, 
                            DHCP_SUBNET_ELEMENT_TYPE EnumElementType, uint* ResumeHandle, uint PreferredMaximum, 
                            DHCP_SUBNET_ELEMENT_INFO_ARRAY** EnumElementInfo, uint* ElementsRead, 
                            uint* ElementsTotal);

///The <b>DhcpRemoveSubnetElement</b> function removes an IPv4 subnet element from an IPv4 subnet defined on the DHCPv4
///server.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCPv4 server.
///    SubnetAddress = DHCP_IP_ADDRESS value that specifies the IPv4 address of the subnet gateway from which elements are to be
///                    removed.
///    RemoveElementInfo = DHCP_SUBNET_ELEMENT_DATA structure that contains information used to find the element that will be removed from
///                        subnet specified in <i>SubnetAddress</i>.
///    ForceFlag = DHCP_FORCE_FLAG enumeration value that indicates whether or not the clients affected by the removal of the subnet
///                element should also be deleted. <div class="alert"><b>Note</b> If the flag is set to <b>DhcpNoForce</b> and this
///                subnet has served an IPv4 address to DHCPv4/BOOTP clients, the IPv4 range is not deleted; conversely, if the flag
///                is set to <b>DhcpFullForce</b>, the IPv4 range is deleted along with the DHCPv4 client lease record on the DHCPv4
///                server.</div> <div> </div>
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl> </td>
///    <td width="60%"> The specified IPv4 subnet is not defined on the DHCP server. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DHCP_RESERVED_CLIENT</b></dt> </dl> </td> <td width="60%"> The specified DHCP client is a
///    reserved client. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_INVALID_RANGE</b></dt> </dl> </td> <td
///    width="60%"> The specified IPv4 address range either overlaps an existing IPv4 address range, or is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_ELEMENT_CANT_REMOVE</b></dt> </dl> </td> <td
///    width="60%"> At least one multicast IPv4 address has been leased out to a MADCAP client. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpRemoveSubnetElement(const(PWSTR) ServerIpAddress, uint SubnetAddress, 
                             const(DHCP_SUBNET_ELEMENT_DATA)* RemoveElementInfo, DHCP_FORCE_FLAG ForceFlag);

///The <b>DhcpDeleteSubnet</b> function deletes a subnet from the DHCP server.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address of the subnet to delete.
///    SubnetAddress = DHCP_IP_ADDRESS value that contains the IP address of the subnet gateway used to identify the subnet.
///    ForceFlag = DHCP_FORCE_FLAG enumeration value that indicates the type of delete operation to perform (full force, failover
///                force, or no force).
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpDeleteSubnet(const(PWSTR) ServerIpAddress, uint SubnetAddress, DHCP_FORCE_FLAG ForceFlag);

///The <b>DhcpCreateOption</b> function creates an option definition for the default user and vendor class at the
///default option level.
///Params:
///    ServerIpAddress = Unicode string containing the IPv4 address of the DHCP server.
///    OptionID = DHCP_OPTION_ID value that contains the unique option ID number (also called an "option code") of the new option.
///               Many of these option ID numbers are defined; a complete list of standard DHCP and BOOTP option codes can be found
///               in DHCP Options and BOOTP Vendor Extensions.
///    OptionInfo = DHCP_OPTION structure that contains information describing the new DHCP option, including the name, an optional
///                 comment, and any related data items.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_OPTION_EXISTS</b></dt> </dl> </td> <td
///    width="60%"> The specified option definition already exists in the DHCP server database. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpCreateOption(const(PWSTR) ServerIpAddress, uint OptionID, const(DHCP_OPTION)* OptionInfo);

///The <b>DhcpSetOptionInfo</b> function modifies the option definition of the specified option for the default user
///class and vendor class at the default option level.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    OptionID = DHCP_OPTION_ID value that contains the code uniquely identifying a specific DHCP option.
///    OptionInfo = Pointer to a DHCP_OPTION structure that contains information on the option specified by <i>OptionID</i>.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_OPTION_NOT_PRESENT</b></dt> </dl> </td>
///    <td width="60%"> The specified option definition could not be found in the DHCP server database. </td> </tr>
///    </table>
///    
@DllImport("DHCPSAPI")
uint DhcpSetOptionInfo(const(PWSTR) ServerIpAddress, uint OptionID, const(DHCP_OPTION)* OptionInfo);

///The <b>DhcpGetOptionInfo</b> function returns information on a specific DHCP option for the default user and vendor
///class.
///Params:
///    ServerIpAddress = Unicode string that specifies the IPv4 address of the DHCP server.
///    OptionID = DHCP_OPTION_ID value that specifies the code for the option to retrieve information on.
///    OptionInfo = Pointer to a DHCP_OPTION structure that contains the returned information on the option specified by
///                 <i>OptionID</i>. <div class="alert"><b>Note</b> <p class="note">The memory for this parameter must be free using
///                 DhcpRpcFreeMemory. </div> <div> </div>
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_OPTION_NOT_PRESENT</b></dt> </dl> </td>
///    <td width="60%"> The specified option definition could not be found in the DHCP server database. </td> </tr>
///    </table>
///    
@DllImport("DHCPSAPI")
uint DhcpGetOptionInfo(const(PWSTR) ServerIpAddress, uint OptionID, DHCP_OPTION** OptionInfo);

///The <b>DhcpEnumOptions</b> function returns an enumerated set of options stored on the DHCPv4 server.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IPv4 address of the DHCP server.
///    ResumeHandle = Pointer to a DHCP_RESUME_HANDLE value that identifies the enumeration operation. Initially, this value should be
///                   zero, with a successful call returning the handle value used for subsequent enumeration requests. For example, if
///                   <i>PreferredMaximum</i> is set to 1000 bytes, and 2000 bytes worth of options are stored on the server, the
///                   resume handle can be used after the first 1000 bytes are retrieved to obtain the next 1000 on a subsequent call,
///                   and so forth. The presence of additional enumerable data is indicated when this function returns ERROR_MORE_DATA.
///                   If no additional enumerable data is available on the DHCPv4 server, ERROR_NO_MORE_ITEMS is returned.
///    PreferredMaximum = Specifies the preferred maximum number of bytes of options to return. If the number of remaining unenumerated
///                       options (in bytes) is less than this value, then that amount will be returned. To retrieve all the option
///                       definitions for the default user and vendor class, set this parameter to 0xFFFFFFFF.
///    Options = Pointer to a DHCP_OPTION_ARRAY structure containing the returned options. If there are no options available on
///              the DHCPv4 server, this parameter will return null.
///    OptionsRead = Pointer to a DWORD value that specifies the number of options returned in <i>Options</i>.
///    OptionsTotal = Pointer to a DWORD value that specifies the total number of remaining options stored on the DHCPv4 server.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> There are more elements available to enumerate. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> There are no more elements left to enumerate.
///    </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpEnumOptions(const(PWSTR) ServerIpAddress, uint* ResumeHandle, uint PreferredMaximum, 
                     DHCP_OPTION_ARRAY** Options, uint* OptionsRead, uint* OptionsTotal);

///The <b>DhcpRemoveOption</b> function removes the definition of a specific option for the default user class and
///vendor class at the default option level on the DHCP server.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    OptionID = DHCP_OPTION_ID value that contains the code uniquely identifying the specific option to remove from the DHCP
///               server.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_OPTION_NOT_PRESENT</b></dt> </dl> </td>
///    <td width="60%"> The specified option definition could not be found in the DHCP server database. </td> </tr>
///    </table>
///    
@DllImport("DHCPSAPI")
uint DhcpRemoveOption(const(PWSTR) ServerIpAddress, uint OptionID);

///The <b>DhcpSetOptionValue</b> function sets information for a specific option value on the DHCP server.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    OptionID = DHCP_OPTION_ID value that specifies the unique code for a DHCP option.
///    ScopeInfo = Pointer to a DHCP_OPTION_SCOPE_INFO structure that contains information describing the level (default, server,
///                scope, or IPv4 reservation) at which this option value will be set.
///    OptionValue = Pointer to a DHCP_OPTION_DATA structure that contains the data value corresponding to the DHCP option code
///                  specified by <i>OptionID</i>.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_OPTION_NOT_PRESENT</b></dt> </dl> </td>
///    <td width="60%"> The specified option definition could not be found in the DHCP server database. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl> </td> <td width="60%"> The specified
///    IPv4 subnet does not exist on the DHCP server. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_NOT_RESERVED_CLIENT</b></dt> </dl> </td> <td width="60%"> The specified DHCP client is not a
///    reserved client. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td
///    width="60%"> The multicast scope specified in <i>ScopeInfo</i> was not found on the DHCP server. </td> </tr>
///    </table>
///    
@DllImport("DHCPSAPI")
uint DhcpSetOptionValue(const(PWSTR) ServerIpAddress, uint OptionID, const(DHCP_OPTION_SCOPE_INFO)* ScopeInfo, 
                        const(DHCP_OPTION_DATA)* OptionValue);

///The <b>DhcpSetOptionValues</b> function sets option codes and their associated data values for a specific scope
///defined on the DHCP server.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    ScopeInfo = Pointer to a DHCP_OPTION_SCOPE_INFO structure that contains information describing the level (default, server,
///                scope, or IPv4 reservation) at which this option value will be set.
///    OptionValues = Pointer to a DHCP_OPTION_VALUE_ARRAY structure that contains a list of option codes and the corresponding data
///                   value that will be set for them.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_OPTION_NOT_PRESENT</b></dt> </dl> </td>
///    <td width="60%"> The specified option definition could not be found in the DHCP server database. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl> </td> <td width="60%"> The specified
///    IPv4 subnet does not exist on the DHCP server. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_NOT_RESERVED_CLIENT</b></dt> </dl> </td> <td width="60%"> The specified DHCP client is not a
///    reserved client. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td
///    width="60%"> The multicast scope specified in <i>ScopeInfo</i> was not found on the DHCP server. </td> </tr>
///    </table>
///    
@DllImport("DHCPSAPI")
uint DhcpSetOptionValues(const(PWSTR) ServerIpAddress, const(DHCP_OPTION_SCOPE_INFO)* ScopeInfo, 
                         const(DHCP_OPTION_VALUE_ARRAY)* OptionValues);

///The <b>DhcpGetOptionValue</b> function retrieves a DHCP option value (the option code and associated data) for a
///particular scope.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    OptionID = DHCP_OPTION_ID value that specifies the code for the option value to retrieve.
///    ScopeInfo = DHCP_OPTION_SCOPE_INFO structure that contains information on the scope where the option value is set.
///    OptionValue = DHCP_OPTION_VALUE structure that contains the returned option code and data. <div class="alert"><b>Note</b> <p
///                  class="note">The memory for this parameter must be free using DhcpRpcFreeMemory. </div> <div> </div>
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpGetOptionValue(const(PWSTR) ServerIpAddress, uint OptionID, const(DHCP_OPTION_SCOPE_INFO)* ScopeInfo, 
                        DHCP_OPTION_VALUE** OptionValue);

///The <b>DhcpEnumOptionValues</b> function returns an enumerated list of option values (just the option data and the
///associated ID number) for a given scope.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    ScopeInfo = DHCP_OPTION_SCOPE_INFO structure that contains the level (specifically: default, server, scope, or IPv4
///                reservation level) for which the option values are defined and should be enumerated.
///    ResumeHandle = Pointer to a DHCP_RESUME_HANDLE value that identifies the enumeration operation. Initially, this value should be
///                   zero, with a successful call returning the handle value used for subsequent enumeration requests. For example, if
///                   <i>PreferredMaximum</i> is set to 1000 bytes, and 2000 bytes worth of option values are stored on the server, the
///                   resume handle can be used after the first 1000 bytes are retrieved to obtain the next 1000 on a subsequent call,
///                   and so forth. The presence of additional enumerable data is indicated when this function returns ERROR_MORE_DATA.
///                   If no additional enumerable data is available on the DHCPv4 server, ERROR_NO_MORE_ITEMS is returned.
///    PreferredMaximum = Specifies the preferred maximum number of bytes of option values to return. If the number of remaining
///                       unenumerated options (in bytes) is less than this value, then that amount will be returned. To retrieve all the
///                       option values for the default user and vendor class at the specified level, set this parameter to 0xFFFFFFFF.
///    OptionValues = Pointer to a DHCP_OPTION_VALUE_ARRAY structure that contains the enumerated option values returned for the
///                   specified scope. If there are no option values available for this scope on the DHCP server, this parameter will
///                   return null.
///    OptionsRead = Pointer to a DWORD value that specifies the number of option values returned in <i>OptionValues</i>.
///    OptionsTotal = Pointer to a DWORD value that specifies the total number of remaining option values for this scope stored on the
///                   DHCP server.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> There are more elements available to enumerate. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> There are no more elements left to enumerate.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
///    The specified IPv4 subnet does not exist on the DHCP server. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_NOT_RESERVED_CLIENT</b></dt> </dl> </td> <td width="60%"> The specified DHCPv4 client is not an
///    IPv4 reserved client. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpEnumOptionValues(const(PWSTR) ServerIpAddress, const(DHCP_OPTION_SCOPE_INFO)* ScopeInfo, 
                          uint* ResumeHandle, uint PreferredMaximum, DHCP_OPTION_VALUE_ARRAY** OptionValues, 
                          uint* OptionsRead, uint* OptionsTotal);

///The <b>DhcpRemoveOptionValue</b> function removes the option value for a specific option on the DHCP4 server for the
///default user class and vendor class, for the specified scope.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    OptionID = DHCP_OPTION_ID value that contains the code uniquely identifying the specific option to remove from the DHCP
///               server.
///    ScopeInfo = DHCP_OPTION_SCOPE_INFO structure that contains information describing the specific scope (default, server, scope,
///                or IPv4 reservation level) from which to remove the option value.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_OPTION_NOT_PRESENT</b></dt> </dl> </td>
///    <td width="60%"> The specified option definition could not be found in the DHCP server database. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl> </td> <td width="60%"> The specified
///    IPv4 subnet is not defined on the DHCP server. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_NOT_RESERVED_CLIENT</b></dt> </dl> </td> <td width="60%"> The specified DHCP client is not a
///    reserved client. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpRemoveOptionValue(const(PWSTR) ServerIpAddress, uint OptionID, const(DHCP_OPTION_SCOPE_INFO)* ScopeInfo);

///The <b>DhcpCreateClientInfoVQ</b> function creates the provided DHCP client lease record in the DHCP server database.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    ClientInfo = Pointer to a DHCP_CLIENT_INFO_VQ structure that contains the DHCP client lease record information to set on the
///                 DHCP server. The caller must populate the <b>ClientIPAddress</b> and <b>ClientHardwareAddress</b> fields of this
///                 structure; all others are optional.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_CLIENT_EXISTS</b></dt> </dl> </td>
///    <td width="60%"> The provided DHCP client record already exists in the DHCP server database. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpCreateClientInfoVQ(const(PWSTR) ServerIpAddress, const(DHCP_CLIENT_INFO_VQ)* ClientInfo);

///The <b>DhcpSetClientInfoVQ</b> function sets or modifies an existing DHCP client lease record in the DHCP server
///record database.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    ClientInfo = Pointer to a DHCP_CLIENT_INFO_VQ structure that contains the DHCP client lease record to add to or modify in the
///                 DHCP server database.
@DllImport("DHCPSAPI")
uint DhcpSetClientInfoVQ(const(PWSTR) ServerIpAddress, const(DHCP_CLIENT_INFO_VQ)* ClientInfo);

///The <b>DhcpGetClientInfoVQ</b> function retrieves DHCP client lease record information from the DHCP server database.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    SearchInfo = Pointer to a DHCP_SEARCH_INFO structure that defines the key used to search the client lease record database on
///                 the DHCP server for a particular client record.
///    ClientInfo = Pointer to the DHCP_CLIENT_INFO_VQ structure returned by a successful search operation.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpGetClientInfoVQ(const(PWSTR) ServerIpAddress, const(DHCP_SEARCH_INFO)* SearchInfo, 
                         DHCP_CLIENT_INFO_VQ** ClientInfo);

///The <b>DhcpEnumSubnetClientsVQ</b> function retrieves all DHCP clients serviced from the specified IPv4 subnet.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    SubnetAddress = DHCP_IP_ADDRESS value that contains the IPv4 subnet for which the DHCP clients are returned. If this parameter is
///                    set to 0, the DHCP clients for all known IPv4 subnets are returned.
///    ResumeHandle = Pointer to a DHCP_RESUME_HANDLE value that identifies the enumeration operation on the DHCP server. Initially,
///                   this value must be set to 0. A successful call will return a handle value in this parameter, which can be passed
///                   to subsequent enumeration requests. The returned handle value is the last IPv4 address retrieved in the
///                   enumeration operation.
///    PreferredMaximum = Specifies the preferred maximum number of bytes to return in the enumeration operation. the minimum value is 1024
///                       bytes, and the maximum value is 65536 bytes.
///    ClientInfo = Pointer to a DHCP_CLIENT_INFO_ARRAY_VQ structure that contains the DHCP client lease record set returned by the
///                 enumeration operation.
///    ClientsRead = Pointer to a value that specifies the number of DHCP client records returned in <i>ClientInfo</i>.
///    ClientsTotal = Pointer to a value that specifies the number of DHCP client record remaining and as-yet unreturned. For example,
///                   if there are 100 DHCP client records for a given IPv4 subnet, and if 10 client records are enumerated per call,
///                   then after the first call this value would return 90.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> There are still unenumerated client lease records on the DHCP server for the provided IPv4 subnet.
///    Please call this function again with the returned resume handle to obtain more of them. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpEnumSubnetClientsVQ(const(PWSTR) ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, 
                             uint PreferredMaximum, DHCP_CLIENT_INFO_ARRAY_VQ** ClientInfo, uint* ClientsRead, 
                             uint* ClientsTotal);

///The <b>DhcpEnumSubnetClientsFilterStatusInfo</b> function enumerates all of the DHCP clients serviced on the
///specified subnet, and includes link-layer filter status for each of them.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    SubnetAddress = DHCP_IP_ADDRESS value that contains the IPv4 subnet for which the DHCP clients are returned. If this parameter is
///                    set to 0, the DHCP clients for all known IPv4 subnets are returned.
///    ResumeHandle = Pointer to a DHCP_RESUME_HANDLE value that identifies the enumeration operation on the DHCP server. Initially,
///                   this value must be set to 0. A successful call will return a handle value in this parameter, which can be passed
///                   to subsequent enumeration requests. The returned handle value is the last IPv4 address retrieved in the
///                   enumeration operation.
///    PreferredMaximum = Specifies the preferred maximum number of bytes to return in the enumeration operation. the minimum value is 1024
///                       bytes, and the maximum value is 65536 bytes.
///    ClientInfo = Pointer to a DHCP_CLIENT_FILTER_STATUS_INFO_ARRAY structure that contains all of the DHCP clients serviced on the
///                 specified subnet, as well as any associated link-layer filter status information for each of them.
///    ClientsRead = Pointer to a value that specifies the number of DHCP client records returned in <i>ClientInfo</i>.
///    ClientsTotal = Pointer to a value that specifies the number of DHCP client record remaining and as-yet unreturned. For example,
///                   if there are 100 DHCP client records for a given IPv4 subnet, and if 10 client records are enumerated per call,
///                   then after the first call this value would return 90.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> There are still unenumerated client lease records on the DHCP server for the provided IPv4 subnet.
///    Please call this function again with the returned resume handle to obtain more of them. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpEnumSubnetClientsFilterStatusInfo(const(PWSTR) ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, 
                                           uint PreferredMaximum, DHCP_CLIENT_FILTER_STATUS_INFO_ARRAY** ClientInfo, 
                                           uint* ClientsRead, uint* ClientsTotal);

///The <b>DhcpCreateClientInfo</b> function creates a client information record on the DHCP server.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    ClientInfo = DHCP_CLIENT_INFO structure that contains information about the DHCP client, including the assigned IP address,
///                 subnet mask, and host.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpCreateClientInfo(const(PWSTR) ServerIpAddress, const(DHCP_CLIENT_INFO)* ClientInfo);

///The <b>DhcpSetClientInfo</b> function sets information on a client whose IP address lease is administrated by the
///DHCP server.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    ClientInfo = Pointer to a DHCP_CLIENT_INFO structure that contains the information on a client in a subnet served by the DHCP
///                 server.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpSetClientInfo(const(PWSTR) ServerIpAddress, const(DHCP_CLIENT_INFO)* ClientInfo);

///The <b>DhcpGetClientInfo</b> function returns information about a specific DHCP client.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    SearchInfo = DHCP_SEARCH_INFO structure that contains the parameters for the search.
///    ClientInfo = Pointer to a DHCP_CLIENT_INFO structure that contains information describing the DHCP client that most closely
///                 matches the provided search parameters. If no client is found, this parameter will be null. <div
///                 class="alert"><b>Note</b> <p class="note">The memory for this parameter must be free using DhcpRpcFreeMemory.
///                 </div> <div> </div>
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpGetClientInfo(const(PWSTR) ServerIpAddress, const(DHCP_SEARCH_INFO)* SearchInfo, 
                       DHCP_CLIENT_INFO** ClientInfo);

///The <b>DhcpDeleteClientInfo</b> function deletes a client information record from the DHCP server.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    ClientInfo = DHCP_SEARCH_INFO union structure that contains one of the following items used to search the DHCP client record
///                 database: the client IP address, the client MAC address, or the client network name. All records matching the
///                 value will be deleted; for example, if a client IP address of 192.1.1.10 is supplied, all records with this
///                 address in the <b>ClientIpAddress</b> field will be deleted.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpDeleteClientInfo(const(PWSTR) ServerIpAddress, const(DHCP_SEARCH_INFO)* ClientInfo);

///The <b>DhcpEnumSubnetClients</b> function returns an enumerated list of clients with served IP addresses in the
///specified subnet.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    SubnetAddress = DHCP_IP_ADDRESS value that contains the subnet ID. See RFC 950 for more information about subnet ID.
///    ResumeHandle = Pointer to a DHCP_RESUME_HANDLE value that identifies the enumeration operation. Initially, this value should be
///                   zero, with a successful call returning the handle value used for subsequent enumeration requests. For example, if
///                   <i>PreferredMaximum</i> is set to 1000 bytes, and 2000 bytes worth of subnet client information structures are
///                   stored on the server, the resume handle can be used after the first 1000 bytes are retrieved to obtain the next
///                   1000 on a subsequent call, and so forth.
///    PreferredMaximum = Specifies the preferred maximum number of bytes of subnet client information structures to return. If the number
///                       of remaining unenumerated options (in bytes) is less than this value, then that amount will be returned. The
///                       minimum value is 1024 bytes (1KB), and the maximum value is 65536 bytes (64KB); if the input value is greater or
///                       less than this range, it will be set to the maximum or minimum value, respectively.
///    ClientInfo = Pointer to a DHCP_CLIENT_INFO_ARRAY structure that contains information on the clients served under this specific
///                 subnet. If no clients are available, this field will be null.
///    ClientsRead = Pointer to a <b>DWORD</b> value that specifies the number of clients returned in <i>ClientInfo</i>.
///    ClientsTotal = Pointer to a <b>DWORD</b> value that specifies the number of clients for the specified subnet that have not yet
///                   been enumerated. <div class="alert"><b>Note</b> This value is set to the correct value during the final
///                   enumeration call; however, prior calls to this function set the value as "0x7FFFFFFF".</div> <div> </div>
///Returns:
///    This function returns <b>ERROR_MORE_DATA</b> upon a successful call. The final call to this method with the last
///    set of subnet clients returns <b>ERROR_SUCCESS</b>. Otherwise, it returns one of the DHCP Server Management API
///    Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpEnumSubnetClients(const(PWSTR) ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, 
                           uint PreferredMaximum, DHCP_CLIENT_INFO_ARRAY** ClientInfo, uint* ClientsRead, 
                           uint* ClientsTotal);

///The <b>DhcpGetClientOptions</b> function returns only ERROR_NOT_IMPLEMENTED, as it is not used or supported.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    ClientIpAddress = DHCP_IP_ADDRESS value that specifies the IP address or hostname of the DHCP client whose option values will be
///                      returned.
///    ClientSubnetMask = DHCP_IP_MASK value that specifies the subnet mask of the DHCP client whose option values will be returned.
///    ClientOptions = Pointer to a DHCP_OPTION_LIST structure that contains the returned option values for the DHCP client. <div
///                    class="alert"><b>Note</b> <p class="note">The memory for this parameter must be free using DhcpRpcFreeMemory.
///                    </div> <div> </div>
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_NOT_IMPLEMENTED</b></dt> </dl> </td> <td width="60%"> This function is not implemented and is
///    not supported. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpGetClientOptions(const(PWSTR) ServerIpAddress, uint ClientIpAddress, uint ClientSubnetMask, 
                          DHCP_OPTION_LIST** ClientOptions);

@DllImport("DHCPSAPI")
uint DhcpGetMibInfo(const(PWSTR) ServerIpAddress, DHCP_MIB_INFO** MibInfo);

///The <b>DhcpServerSetConfig</b> function configures a DHCPv4 server with specific settings, including information on
///the JET database used to store subnet and client lease information, and the supported protocols.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    FieldsToSet = Specifies a set of bit flags that indicate which fields in <i>ConfigInfo</i> are set. If a flag is present, the
///                  corresponding field must also be populated in the DHCP_SERVER_CONFIG_INFO structure referenced by
///                  <i>ConfigInfo</i>, and will be used to set the same value on the DHCP server, <table> <tr> <th>Value</th>
///                  <th>Meaning</th> </tr> <tr> <td width="40%"><a id="Set_APIProtocolSupport"></a><a
///                  id="set_apiprotocolsupport"></a><a id="SET_APIPROTOCOLSUPPORT"></a><dl> <dt><b>Set_APIProtocolSupport</b></dt>
///                  <dt>0x00000001</dt> </dl> </td> <td width="60%"> The <b>APIProtocolSupport</b> field is populated. </td> </tr>
///                  <tr> <td width="40%"><a id="Set_DatabaseName"></a><a id="set_databasename"></a><a id="SET_DATABASENAME"></a><dl>
///                  <dt><b>Set_DatabaseName</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> The <b>DatabaseName</b> field
///                  is populated. </td> </tr> <tr> <td width="40%"><a id="Set_DatabasePath"></a><a id="set_databasepath"></a><a
///                  id="SET_DATABASEPATH"></a><dl> <dt><b>Set_DatabasePath</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%">
///                  The <b>DatabasePath</b> field is populated. </td> </tr> <tr> <td width="40%"><a id="Set_BackupPath"></a><a
///                  id="set_backuppath"></a><a id="SET_BACKUPPATH"></a><dl> <dt><b>Set_BackupPath</b></dt> <dt>0x00000008</dt> </dl>
///                  </td> <td width="60%"> The <b>BackupPath</b> field is populated. </td> </tr> <tr> <td width="40%"><a
///                  id="Set_BackupInterval"></a><a id="set_backupinterval"></a><a id="SET_BACKUPINTERVAL"></a><dl>
///                  <dt><b>Set_BackupInterval</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> The <b>BackupInterval</b>
///                  field is populated. </td> </tr> <tr> <td width="40%"><a id="Set_DatabaseLoggingFlag"></a><a
///                  id="set_databaseloggingflag"></a><a id="SET_DATABASELOGGINGFLAG"></a><dl> <dt><b>Set_DatabaseLoggingFlag</b></dt>
///                  <dt>0x00000020</dt> </dl> </td> <td width="60%"> The <b>DatabaseLoggingFlag</b> field is populated. </td> </tr>
///                  <tr> <td width="40%"><a id="Set_RestoreFlag"></a><a id="set_restoreflag"></a><a id="SET_RESTOREFLAG"></a><dl>
///                  <dt><b>Set_RestoreFlag</b></dt> <dt>0x00000040</dt> </dl> </td> <td width="60%"> The <b>RestoreFlag</b> field is
///                  populated. </td> </tr> <tr> <td width="40%"><a id="Set_DatabaseCleanupInterval"></a><a
///                  id="set_databasecleanupinterval"></a><a id="SET_DATABASECLEANUPINTERVAL"></a><dl>
///                  <dt><b>Set_DatabaseCleanupInterval</b></dt> <dt>0x00000080</dt> </dl> </td> <td width="60%"> The
///                  <b>DatabaseCleanupInterval</b> field is populated. </td> </tr> <tr> <td width="40%"><a
///                  id="Set_Set_DebugFlag"></a><a id="set_set_debugflag"></a><a id="SET_SET_DEBUGFLAG"></a><dl>
///                  <dt><b>Set_Set_DebugFlag</b></dt> <dt>0x00000100</dt> </dl> </td> <td width="60%"> The <b>DebugFlag</b> field is
///                  populated. </td> </tr> </table>
///    ConfigInfo = DHCP_SERVER_CONFIG_INFO structure that contains the specific configuration information to set on the DHCP server,
///                 as indicated by the flags specified in <i>FieldsToSet</i>.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpServerSetConfig(const(PWSTR) ServerIpAddress, uint FieldsToSet, DHCP_SERVER_CONFIG_INFO* ConfigInfo);

///The <b>DhcpServerGetConfig</b> function returns the specific configuration settings of a DHCP server. Configuration
///information includes information on the JET database used to store subnet and client lease information, and the
///supported protocols.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    ConfigInfo = Pointer to a DHCP_SERVER_CONFIG_INFO structure that contains the specific configuration information for the DHCP
///                 server. <div class="alert"><b>Note</b> <p class="note">The memory for this parameter must be free using
///                 DhcpRpcFreeMemory. </div> <div> </div>
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpServerGetConfig(const(PWSTR) ServerIpAddress, DHCP_SERVER_CONFIG_INFO** ConfigInfo);

///The <b>DhcpScanDatabase</b> function enumerates the leased DHCPv4 client IPv4 addresses that are not synchronized
///between the in-memory cache and the server database.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    SubnetAddress = DHCP_IP_ADDRESS value that specifies the subnet whose leases will be scanned for desynchronized client lease IP
///                    addresses.
///    FixFlag = Specifies a set of bit flags that indicate whether the in-memory cache or the client lease database should be the
///              definitive source for fixes when synchronizing the two on the DHCPv4 server. These flags are enumerated in
///              DHCP_SCAN_FLAG.
///    ScanList = DHCP_SCAN_LIST structure that contains the returned list of leased client IP addresses that are not in sync.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCPv4
///    server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl>
///    </td> <td width="60%"> The specified subnet is not defined on the DHCPv4 server. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpScanDatabase(const(PWSTR) ServerIpAddress, uint SubnetAddress, uint FixFlag, DHCP_SCAN_LIST** ScanList);

///The <b>DhcpRpcFreeMemory</b> function frees a block of buffer space returned as a parameter.
///Params:
///    BufferPointer = Pointer to an address that contains a structure (or structures, in the case of an array) returned as a parameter.
///Returns:
///    This function does not return a value.
///    
@DllImport("DHCPSAPI")
void DhcpRpcFreeMemory(void* BufferPointer);

///The <b>DhcpGetVersion</b> function returns the major and minor version numbers of the DHCP server.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    MajorVersion = Specifies the major version number of the DHCP server.
///    MinorVersion = Specifies the minor version number of the DHCP server.
@DllImport("DHCPSAPI")
uint DhcpGetVersion(PWSTR ServerIpAddress, uint* MajorVersion, uint* MinorVersion);

///The <b>DhcpAddSubnetElementV4</b> function adds an element describing a feature or aspect of the subnet to the subnet
///entry in the DHCP database. This function extends DhcpAddSubnetElement by incorporating subnet elements that consider
///client type. <div class="alert"><b>Note</b> This function is not available in Windows previous to Windows NT 4.0
///Service Pack 1.</div><div> </div>
///Params:
///    ServerIpAddress = Pointer to a Unicode string that contains the IP address of the subnet DHCP server.
///    SubnetAddress = DHCP_IP_ADDRESS structure that contains the IP address of the subnet.
///    AddElementInfo = DHCP_SUBNET_ELEMENT_DATA_V4 structure that contains the element data to add to the subnet. The V4 structure adds
///                     support for differentiation between DHCP and BOOTP clients.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl> </td>
///    <td width="60%"> The specified IPv4 subnet does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_OPTION_NOT_PRESENT</b></dt> </dl> </td> <td width="60%"> The specified option definition does
///    not exist in the DHCP server database. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_INVALID_RANGE</b></dt> </dl> </td> <td width="60%"> The specified IPv4 address range either
///    overlaps an existing range or is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_IPRANGE_CONV_ILLEGAL</b></dt> </dl> </td> <td width="60%"> Conversion of a scope to a
///    DHCPv4-only scope or to a BOOTP-only scope is not allowed when DHCPv4 and BOOTP clients are present in the scope
///    to convert. Manually delete either the DHCPv4 or the BOOTP clients from the scope, as appropriate for the type of
///    scope being created. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_IPRANGE_EXISTS</b></dt> </dl> </td>
///    <td width="60%"> The specified IPv4 address range already exists. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_MSCOPE_RANGE_TOO_SMALL</b></dt> </dl> </td> <td width="60%"> The multicast scope range must
///    allow for at least 256 IPv4 addresses. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_NOT_RESERVED_CLIENT</b></dt> </dl> </td> <td width="60%"> The specified DHCPv4 client is not an
///    IPv4 reserverdclient. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_RESERVEDIP_EXISTS</b></dt> </dl>
///    </td> <td width="60%"> The specified IPv4 address or hardware address is in use by another DHCPv4 client. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_ADDRESS</b></dt> </dl> </td> <td width="60%"> The specified
///    address is not available. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpAddSubnetElementV4(const(PWSTR) ServerIpAddress, uint SubnetAddress, 
                            const(DHCP_SUBNET_ELEMENT_DATA_V4)* AddElementInfo);

///The <b>DhcpEnumSubnetElementsV4</b> function returns an enumerated list of elements for a specific DHCP subnet. This
///function extends DhcpEnumSubnetElements by returning a list of DHCP_SUBNET_ELEMENT_DATA_V4 structures, which can
///contain IP reservations based on client type.
///Params:
///    ServerIpAddress = Unicode string that specifies the IPv4 address of the DHCPv4 server.
///    SubnetAddress = DHCP_IP_ADDRESS value that specifies the address of the IPv4 subnet whose elements will be enumerated.
///    EnumElementType = DHCP_SUBNET_ELEMENT_TYPE enumeration value that indicates the type of subnet element to enumerate.
///    ResumeHandle = Pointer to a DHCP_RESUME_HANDLE value that identifies the enumeration operation. Initially, this value should be
///                   zero, with a successful call returning the handle value used for subsequent enumeration requests. For example, if
///                   <i>PreferredMaximum</i> is set to 1000 bytes, and 2000 bytes worth of subnet elements are stored on the server,
///                   the resume handle can be used after the first 1000 bytes are retrieved to obtain the next 1000 on a subsequent
///                   call, and so forth. The presence of additional enumerable data is indicated when this function returns
///                   ERROR_MORE_DATA. If no additional enumerable data is available on the DHCPv4 server, ERROR_NO_MORE_ITEMS is
///                   returned.
///    PreferredMaximum = Specifies the preferred maximum number of bytes of subnet elements to return. If the number of remaining
///                       unenumerated options (in bytes) is less than this value, then that amount will be returned. To retrieve all the
///                       subnet client elements for the default user and vendor class at the specified level, set this parameter to
///                       0xFFFFFFFF.
///    EnumElementInfo = Pointer to a DHCP_SUBNET_ELEMENT_INFO_ARRAY_V4 structure containing an enumerated list of all elements available
///                      for the specified subnet. If no elements are available for enumeration, this value will be null.
///    ElementsRead = Pointer to a DWORD value that specifies the number of subnet elements returned in <i>EnumElementInfo</i>.
///    ElementsTotal = Pointer to a DWORD value that specifies the total number of as-yet unenumerated elements remaining on the server
///                    for the specified subnet.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> There are more elements available to enumerate. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> There are no more elements left to enumerate.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
///    The specified IPv4 subnet does not exist on the DHCP server. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpEnumSubnetElementsV4(const(PWSTR) ServerIpAddress, uint SubnetAddress, 
                              DHCP_SUBNET_ELEMENT_TYPE EnumElementType, uint* ResumeHandle, uint PreferredMaximum, 
                              DHCP_SUBNET_ELEMENT_INFO_ARRAY_V4** EnumElementInfo, uint* ElementsRead, 
                              uint* ElementsTotal);

///The <b>DhcpRemoveSubnetElementV4</b> function removes an IPv4 subnet element from an IPv4 subnet defined on the
///DHCPv4 server. The function extends the functionality provided by DhcpRemoveSubnetElement by allowing the
///specification of a subnet that contains client type (DHCP or BOOTP) information.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    SubnetAddress = DHCP_IP_ADDRESS value that specifies the IP address of the subnet gateway and uniquely identifies it.
///    RemoveElementInfo = DHCP_SUBNET_ELEMENT_DATA_V4 structure that contains information used to find the element that will be removed
///                        from subnet specified in <i>SubnetAddress</i>.
///    ForceFlag = DHCP_FORCE_FLAG enumeration value that indicates whether or not the clients affected by the removal of the subnet
///                element should also be deleted. <div class="alert"><b>Note</b> If the flag is set to <b>DhcpNoForce</b> and this
///                subnet has served an IPv4 address to DHCPv4/BOOTP clients, the IPv4 range is not deleted; conversely, if the flag
///                is set to <b>DhcpFullForce</b>, the IPv4 range is deleted along with the DHCPv4 client lease record on the DHCPv4
///                server.</div> <div> </div>
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl> </td>
///    <td width="60%"> The specified IPv4 subnet is not defined on the DHCP server. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DHCP_RESERVED_CLIENT</b></dt> </dl> </td> <td width="60%"> The specified DHCP client is a
///    reserved client. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_INVALID_RANGE</b></dt> </dl> </td> <td
///    width="60%"> The specified IPv4 address range either overlaps an existing IPv4 address range, or is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_ELEMENT_CANT_REMOVE</b></dt> </dl> </td> <td
///    width="60%"> At least one multicast IPv4 address has been leased out to a MADCAP client. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpRemoveSubnetElementV4(const(PWSTR) ServerIpAddress, uint SubnetAddress, 
                               const(DHCP_SUBNET_ELEMENT_DATA_V4)* RemoveElementInfo, DHCP_FORCE_FLAG ForceFlag);

///The <b>DhcpCreateClientInfoV4</b> function creates a client information record on the DHCP server, extending the
///functionality of DhcpCreateClientInfo by including the client type (DHCP or BOOTP) in the record.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    ClientInfo = Pointer to a DHCP_CLIENT_INFO_V4 structure that contains information about the DHCP client, including the
///                 assigned IP address, the subnet mask, the host, and the client type (DHCP and/or BOOTP).
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpCreateClientInfoV4(const(PWSTR) ServerIpAddress, const(DHCP_CLIENT_INFO_V4)* ClientInfo);

///The <b>DhcpSetClientInfoV4</b> function sets information on a client whose IP address lease is administrated by the
///DHCP server. This function extends the functionality provided by DhcpSetClientInfo by allowing the caller to specify
///the client type (DHCP or BOOTP).
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    ClientInfo = Pointer to a DHCP_CLIENT_INFO_V4 structure that contains the information, including client type, for a client in
///                 a subnet served by the DHCP server.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpSetClientInfoV4(const(PWSTR) ServerIpAddress, const(DHCP_CLIENT_INFO_V4)* ClientInfo);

///The <b>DhcpGetClientInfoV4</b> function returns information on a specific DHCP client. This function extends
///DhcpGetClientInfo by returning a DHCP_CLIENT_INFO_V4 structure that contains client type information.
///Params:
///    ServerIpAddress = Specifies the IP address of the DHCP server.
///    SearchInfo = DHCP_SEARCH_INFO structure that contains the search parameters used to select a specific DHCP client.
///    ClientInfo = DHCP_CLIENT_INFO_V4 structure that contains information that describes the DHCP client that most closely matches
///                 the provided search parameters. If no client could be found, this parameter will be null. <div
///                 class="alert"><b>Note</b> <p class="note">The memory for this parameter must be free using DhcpRpcFreeMemory.
///                 </div> <div> </div>
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpGetClientInfoV4(const(PWSTR) ServerIpAddress, const(DHCP_SEARCH_INFO)* SearchInfo, 
                         DHCP_CLIENT_INFO_V4** ClientInfo);

///The <b>DhcpEnumSubnetClientsV4</b> function returns an enumerated list of client lease records with served IP
///addresses in the specified subnet. This function extends the functionality provided in DhcpEnumSubnetClients by
///returning a list of DHCP_CLIENT_INFO_V4 structures that contain the specific client type (DHCP and/or BOOTP).
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    SubnetAddress = DHCP_IP_ADDRESS value containing the IP address of the subnet gateway.
///    ResumeHandle = Pointer to a DHCP_RESUME_HANDLE value that identifies the enumeration operation. Initially, this value should be
///                   zero, with a successful call returning the handle value used for subsequent enumeration requests. This parameter
///                   contains the last last IPv4 address retrieved from the DHCPv4 client. The presence of additional enumerable data
///                   is indicated when this function returns ERROR_MORE_DATA. If no additional enumerable data is available on the
///                   DHCPv4 server, ERROR_NO_MORE_ITEMS is returned.
///    PreferredMaximum = Specifies the preferred maximum number of bytes of subnet client elements to return. If the number of remaining
///                       unenumerated elements (in bytes) is less than this value, then that amount will be returned. The minimum value is
///                       1024 bytes, and the maximum value is 65536 bytes. To retrieve all the subnet client elements for the default user
///                       and vendor class at the specified level, set this parameter to 0xFFFFFFFF.
///    ClientInfo = Pointer to a DHCP_CLIENT_INFO_ARRAY_V4 structure that contains the DHCPv4 client lease record array. If no
///                 clients are available, this field will be null.
///    ClientsRead = Pointer to a DWORD value that specifies the number of client lease records returned in <i>ClientInfo</i>.
///    ClientsTotal = Pointer to a DWORD value that specifies the total number of client lease records remaining on the DHCPv4 server.
///                   For example, if there are 100 DHCPv4 lease records for an IPv4 subnet, and if 10 DHCPv4 lease records are
///                   enumerated per call, then this parameter would return a value of 90 after the first call.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td
///    width="60%"> There are more elements available to enumerate. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> There are no more elements left to enumerate.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
///    The specified IPv4 subnet does not exist on the DHCP server. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpEnumSubnetClientsV4(const(PWSTR) ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, 
                             uint PreferredMaximum, DHCP_CLIENT_INFO_ARRAY_V4** ClientInfo, uint* ClientsRead, 
                             uint* ClientsTotal);

///The <b>DhcpServerSetConfigV4</b> function configures a DHCP server with specific settings, including information on
///the JET database used to store subnet and client lease information, and the supported protocols.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    FieldsToSet = Specifies a set of bit flags that indicate which fields in <i>ConfigInfo</i> are set. If a flag is present, the
///                  corresponding field must also be populated in the DHCP_SERVER_CONFIG_INFO_V4 structure referenced by
///                  <i>ConfigInfo</i>, and will be used to set the same value on the DHCP server, <table> <tr> <th>Value</th>
///                  <th>Meaning</th> </tr> <tr> <td width="40%"><a id="Set_APIProtocolSupport"></a><a
///                  id="set_apiprotocolsupport"></a><a id="SET_APIPROTOCOLSUPPORT"></a><dl> <dt><b>Set_APIProtocolSupport</b></dt>
///                  <dt>0x00000001</dt> </dl> </td> <td width="60%"> The <b>APIProtocolSupport</b> field is populated. </td> </tr>
///                  <tr> <td width="40%"><a id="Set_DatabaseName"></a><a id="set_databasename"></a><a id="SET_DATABASENAME"></a><dl>
///                  <dt><b>Set_DatabaseName</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> The <b>DatabaseName</b> field
///                  is populated. </td> </tr> <tr> <td width="40%"><a id="Set_DatabasePath"></a><a id="set_databasepath"></a><a
///                  id="SET_DATABASEPATH"></a><dl> <dt><b>Set_DatabasePath</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%">
///                  The <b>DatabasePath</b> field is populated. </td> </tr> <tr> <td width="40%"><a id="Set_BackupPath"></a><a
///                  id="set_backuppath"></a><a id="SET_BACKUPPATH"></a><dl> <dt><b>Set_BackupPath</b></dt> <dt>0x00000008</dt> </dl>
///                  </td> <td width="60%"> The <b>BackupPath</b> field is populated. </td> </tr> <tr> <td width="40%"><a
///                  id="Set_BackupInterval"></a><a id="set_backupinterval"></a><a id="SET_BACKUPINTERVAL"></a><dl>
///                  <dt><b>Set_BackupInterval</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> The <b>BackupInterval</b>
///                  field is populated. </td> </tr> <tr> <td width="40%"><a id="Set_DatabaseLoggingFlag"></a><a
///                  id="set_databaseloggingflag"></a><a id="SET_DATABASELOGGINGFLAG"></a><dl> <dt><b>Set_DatabaseLoggingFlag</b></dt>
///                  <dt>0x00000020</dt> </dl> </td> <td width="60%"> The <b>DatabaseLoggingFlag</b> field is populated. </td> </tr>
///                  <tr> <td width="40%"><a id="Set_RestoreFlag"></a><a id="set_restoreflag"></a><a id="SET_RESTOREFLAG"></a><dl>
///                  <dt><b>Set_RestoreFlag</b></dt> <dt>0x00000040</dt> </dl> </td> <td width="60%"> The <b>RestoreFlag</b> field is
///                  populated. </td> </tr> <tr> <td width="40%"><a id="Set_DatabaseCleanupInterval"></a><a
///                  id="set_databasecleanupinterval"></a><a id="SET_DATABASECLEANUPINTERVAL"></a><dl>
///                  <dt><b>Set_DatabaseCleanupInterval</b></dt> <dt>0x00000080</dt> </dl> </td> <td width="60%"> The
///                  <b>DatabaseCleanupInterval</b> field is populated. </td> </tr> <tr> <td width="40%"><a id="Set_DebugFlag"></a><a
///                  id="set_debugflag"></a><a id="SET_DEBUGFLAG"></a><dl> <dt><b>Set_DebugFlag</b></dt> <dt>0x00000100</dt> </dl>
///                  </td> <td width="60%"> The <b>DebugFlag</b> field is populated. </td> </tr> <tr> <td width="40%"><a
///                  id="Set_PingRetries"></a><a id="set_pingretries"></a><a id="SET_PINGRETRIES"></a><dl>
///                  <dt><b>Set_PingRetries</b></dt> <dt>0x00000200</dt> </dl> </td> <td width="60%"> The <b>PingRetries</b> field is
///                  populated. </td> </tr> <tr> <td width="40%"><a id="Set_BootFileTable"></a><a id="set_bootfiletable"></a><a
///                  id="SET_BOOTFILETABLE"></a><dl> <dt><b>Set_BootFileTable</b></dt> <dt>0x00000400</dt> </dl> </td> <td
///                  width="60%"> The <b>BootFileTable</b> field is populated. </td> </tr> <tr> <td width="40%"><a
///                  id="Set_AuditLogState"></a><a id="set_auditlogstate"></a><a id="SET_AUDITLOGSTATE"></a><dl>
///                  <dt><b>Set_AuditLogState</b></dt> <dt>0x00000800</dt> </dl> </td> <td width="60%"> The <b>AuditLogState</b> field
///                  is populated. </td> </tr> </table>
///    ConfigInfo = DHCP_SERVER_CONFIG_INFO_V4 structure that contains the specific DHCP server configuration settings as indicated
///                 by the bit flags set in <i>FieldsToSet</i>.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One of the parameters provides an invalid value. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpServerSetConfigV4(const(PWSTR) ServerIpAddress, uint FieldsToSet, DHCP_SERVER_CONFIG_INFO_V4* ConfigInfo);

///The <b>DhcpServerGetConfigV4</b> function returns the specific configuration settings of a DHCP server. This function
///extends the functionality of DhcpServerGetConfig by adding configuration parameters for the number of ping retries a
///server uses to determine connectability, the settings for the boot file table, and the audit log state. Configuration
///information includes information on the JET database used to store subnet and client lease information, and the
///supported protocols.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    ConfigInfo = Pointer to a DHCP_SERVER_CONFIG_INFO_V4 structure that contains the specific configuration information for the
///                 DHCP server. <div class="alert"><b>Note</b> <p class="note">The memory for this parameter must be free using
///                 DhcpRpcFreeMemory. </div> <div> </div>
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One of the parameters provides an invalid value. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpServerGetConfigV4(const(PWSTR) ServerIpAddress, DHCP_SERVER_CONFIG_INFO_V4** ConfigInfo);

///The <b>DhcpSetSuperScopeV4</b> function sets a subnet as the superscope on a DHCP server.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    SubnetAddress = DHCP_IP_ADDRESS value that contains the IP address of the subnet that will be defined as the superscope.
///    SuperScopeName = Pointer to a Unicode string that specifies the new name of the superscope.
///    ChangeExisting = Specifies whether or not to change an existing superscope to the supplied subnet. If this parameter is
///                     <b>TRUE</b> and another subnet is set as the superscope, change the superscope to the supplied subnet; otherwise,
///                     if set to <b>FALSE</b> and another subnet is defined as the superscope, do not change it.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One of the parameters provides an invalid value. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpSetSuperScopeV4(const(PWSTR) ServerIpAddress, const(uint) SubnetAddress, const(PWSTR) SuperScopeName, 
                         const(BOOL) ChangeExisting);

///The <b>DhcpDeleteSuperScopeV4</b> function deletes a superscope from the DHCP server.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    SuperScopeName = Unicode string that specifies the name of the superscope to delete.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl>
///    </td> <td width="60%"> The specified IPv4 subnet does not exist on the DHCP server. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpDeleteSuperScopeV4(const(PWSTR) ServerIpAddress, const(PWSTR) SuperScopeName);

///The <b>DhcpGetSuperScopeInfoV4</b> function returns information on the superscope of a DHCP server.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    SuperScopeTable = DHCP_SUPER_SCOPE_TABLE structure that contains the returned information for the superscope of the supplied DHCP
///                      server. <div class="alert"><b>Note</b> <p class="note">The memory for this parameter must be free using
///                      DhcpRpcFreeMemory. </div> <div> </div>
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpGetSuperScopeInfoV4(const(PWSTR) ServerIpAddress, DHCP_SUPER_SCOPE_TABLE** SuperScopeTable);

///The <b>DhcpEnumSubnetClientsV5</b> function returns an enumerated list of clients with served IP addresses in the
///specified subnet. This function extends the features provided in the DhcpEnumSubnetClients function by returning a
///list of DHCP_CLIENT_INFO_V5 structures that contain the specific client type (DHCP and/or BOOTP) and the IP address
///state.
///Params:
///    ServerIpAddress = A UNICODE string that specifies the IP address or hostname of the DHCP server.
///    SubnetAddress = A value containing the IP address of the subnet gateway. If this parameter is set to 0, then the DHCP clients for
///                    all IPv4 subnets defined on the DHCP server are returned.
///    ResumeHandle = A pointer to a handle that identifies the enumeration operation. Initially, this value should be zero, with a
///                   successful call returning the handle value used for subsequent enumeration requests. For example, if
///                   <i>PreferredMaximum</i> is set to 1000 bytes, and 2000 bytes worth of subnet client information structures are
///                   stored on the server, the resume handle can be used after the first 1000 bytes are retrieved to obtain the next
///                   1000 on a subsequent call, and so forth.
///    PreferredMaximum = The preferred maximum number of bytes of subnet client information structures to return. If the number of
///                       remaining unenumerated options (in bytes) is less than this value, then that amount will be returned.
///    ClientInfo = A pointer to a DHCP_CLIENT_INFO_ARRAY_V5 structure containing information on the clients served under this
///                 specific subnet. If no clients are available, this field will be null.
///    ClientsRead = A pointer to a value that specifies the number of clients returned in <i>ClientInfo</i>.
///    ClientsTotal = A pointer to a value that specifies the total number of clients for the specified subnet stored on the DHCP
///                   server.
///Returns:
///    The <b>DhcpEnumSubnetClientsV5</b> function returns <b>ERROR_SUCCESS</b> upon success. On error, the function
///    returns one of the DHCP Server Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The call was
///    performed by a client who is not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while
///    accessing the DHCP server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt>
///    </dl> </td> <td width="60%"> There are still un-enumerated client lease records on the DHCP server for the
///    provided IPv4 subnet. Please call this function again with the returned resume handle to obtain more of them.
///    </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpEnumSubnetClientsV5(const(PWSTR) ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, 
                             uint PreferredMaximum, DHCP_CLIENT_INFO_ARRAY_V5** ClientInfo, uint* ClientsRead, 
                             uint* ClientsTotal);

///The <b>DhcpCreateOptionV5</b> function creates a DHCP option.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    Flags = Flag value that indicates whether the option is for a specific or default vendor class. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0x00000000</dt> </dl> </td> <td width="60%">
///            The option value is retrieved for a default vendor class. </td> </tr> <tr> <td width="40%"><a
///            id="DHCP_FLAGS_OPTION_IS_VENDOR"></a><a id="dhcp_flags_option_is_vendor"></a><dl>
///            <dt><b>DHCP_FLAGS_OPTION_IS_VENDOR</b></dt> <dt>0x00000003</dt> </dl> </td> <td width="60%"> The option value is
///            retrieved for a specific vendor class. The vendor name is supplied in <i>VendorName</i>. </td> </tr> </table>
///    OptionId = DHCP_OPTION_ID value that contains the unique option ID number (also called an "option code") of the new option.
///               Many of these option ID numbers are defined; a complete list of standard DHCP and BOOTP option codes can be found
///               in DHCP Options and BOOTP Vendor Extensions.
///    ClassName = Unicode string that specifies the name of the DHCP class that will contain this option. This field is optional.
///    VendorName = Unicode string that contains a vendor name string if the class specified in <i>ClassName</i> is a vendor-specific
///                 class.
///    OptionInfo = DHCP_OPTION structure that contains information describing the new DHCP option, including the name, an optional
///                 comment, and any related data items.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_OPTION_EXISTS</b></dt> </dl> </td>
///    <td width="60%"> The specified option definition already exists in the DHCP server database. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_DHCP_CLASS_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified class
///    name is unknown or incorrectly formed. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpCreateOptionV5(PWSTR ServerIpAddress, uint Flags, uint OptionId, PWSTR ClassName, PWSTR VendorName, 
                        DHCP_OPTION* OptionInfo);

///The <b>DhcpSetOptionInfoV5</b> function sets information for a specific DHCP option.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    Flags = Specifies a bit flag that indicates whether or not the option is vendor-specific. If it is not, this parameter
///            should be 0. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="DHCP_FLAGS_OPTION_IS_VENDOR"></a><a id="dhcp_flags_option_is_vendor"></a><dl>
///            <dt><b>DHCP_FLAGS_OPTION_IS_VENDOR</b></dt> </dl> </td> <td width="60%"> This flag should be set if the option is
///            provided by a vendor. </td> </tr> </table>
///    OptionID = DHCP_OPTION_ID value that specifies the code for a specific DHCP option.
///    ClassName = Pointer to a Unicode string that specifies the DHCP class name of the option. This parameter is optional.
///    VendorName = Pointer to a Unicode string that specifies the vendor of the option. This parameter is optional, and should be
///                 <b>NULL</b> when <i>Flags</i> is not set to DHCP_FLAGS_OPTION_IS_VENDOR.
///    OptionInfo = Pointer to a DHCP_OPTION structure that contains the information on the option specified by <i>OptionID</i>.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCPv6
///    server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_CLASS_NOT_FOUND</b></dt> </dl> </td>
///    <td width="60%"> The provided class name is either incorrect or does not exist on the DHCP server. </td> </tr>
///    </table>
///    
@DllImport("DHCPSAPI")
uint DhcpSetOptionInfoV5(PWSTR ServerIpAddress, uint Flags, uint OptionID, PWSTR ClassName, PWSTR VendorName, 
                         DHCP_OPTION* OptionInfo);

///The <b>DhcpGetOptionInfoV5</b> function returns information on a specific DHCP option.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    Flags = Specifies a bit flag that indicates whether or not the option is vendor-specific. If it is not, this parameter
///            should be 0. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0x00000000</dt>
///            </dl> </td> <td width="60%"> The option value is retrieved for a default vendor class. </td> </tr> <tr> <td
///            width="40%"><a id="DHCP_FLAGS_OPTION_IS_VENDOR"></a><a id="dhcp_flags_option_is_vendor"></a><dl>
///            <dt><b>DHCP_FLAGS_OPTION_IS_VENDOR</b></dt> <dt>0x00000003</dt> </dl> </td> <td width="60%"> The option value is
///            retrieved for a specific vendor class. The vendor name is supplied in <i>VendorName</i>. </td> </tr> </table>
///    OptionID = DHCP_OPTION_ID value that specifies the code for the option to retrieve information on.
///    ClassName = Unicode string that specifies the DHCP class name of the option. This parameter is optional.
///    VendorName = Unicode string that specifies the vendor of the option. This parameter is optional, and must be null when
///                 <i>Flags</i> is not set to DHCP_FLAGS_OPTION_IS_VENDOR. If it is not set, then the option definition for the
///                 default vendor class is returned.
///    OptionInfo = Pointer to a DHCP_OPTION structure that contains the returned information on the option specified by
///                 <i>OptionID</i>. <div class="alert"><b>Note</b> <p class="note">The memory for this parameter must be free using
///                 DhcpRpcFreeMemory. </div> <div> </div>
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl>
///    </td> <td width="60%"> The specified IPv4 subnet is not defined on the DHCP server. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_DHCP_OPTION_NOT_PRESENT</b></dt> </dl> </td> <td width="60%"> The specified option
///    definition does not exist in the DHCP server database. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_NOT_RESERVED_CLIENT</b></dt> </dl> </td> <td width="60%"> The specified DHCP client is not a
///    reserved client. o </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpGetOptionInfoV5(PWSTR ServerIpAddress, uint Flags, uint OptionID, PWSTR ClassName, PWSTR VendorName, 
                         DHCP_OPTION** OptionInfo);

///The <b>DhcpEnumOptionsV5</b> function returns an enumerated list of DHCP options for a given user or vendor class.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    Flags = A set of flags that indicate the option definition for enumeration. <table> <tr> <th>Value</th> <th>Meaning</th>
///            </tr> <tr> <td width="40%"> <dl> <dt>0x00000000</dt> </dl> </td> <td width="60%"> The option definitions are
///            enumerated for a default vendor class. </td> </tr> <tr> <td width="40%"><a
///            id="DHCP_FLAGS_OPTION_IS_VENDOR"></a><a id="dhcp_flags_option_is_vendor"></a><dl>
///            <dt><b>DHCP_FLAGS_OPTION_IS_VENDOR</b></dt> <dt>0x00000003</dt> </dl> </td> <td width="60%"> The option
///            definitions are enumerated for a specific vendor class. </td> </tr> </table>
///    ClassName = Pointer to a Unicode string that contains the name of the class whose options will be enumerated. This parameter
///                is optional.
///    VendorName = Pointer to a Unicode string that contains the name of the vendor for the class. This parameter is optional. If a
///                 vendor class name is not provided, the default vendor class name is used.
///    ResumeHandle = Pointer to a DHCP_RESUME_HANDLE value that identifies the enumeration operation. Initially, this value should be
///                   zero, with a successful call returning the handle value used for subsequent enumeration requests. For example, if
///                   <i>PreferredMaximum</i> is set to 1000 bytes, and 2000 bytes of option definitions are stored on the server, the
///                   resume handle can be used after the first 1000 bytes are retrieved to obtain the next 1000 on a subsequent call,
///                   and so forth.
///    PreferredMaximum = Specifies the preferred maximum number of bytes of options to return. If the number of remaining unenumerated
///                       option definitions (in bytes) is less than this value, all option definitions are returned.
///    Options = Pointer to a DHCP_OPTION_ARRAY structure containing the returned option definitions. If there are no option
///              definitions available on the DHCP server, this parameter will return null.
///    OptionsRead = Pointer to a DWORD value that specifies the number of option definitions returned in <i>Options</i>.
///    OptionsTotal = Pointer to a DWORD value that specifies the total number of unenumerated option definitions on the DHCP server.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_CLASS_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The supplied user or vendor class name is
///    either incorrect or unknown. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpEnumOptionsV5(PWSTR ServerIpAddress, uint Flags, PWSTR ClassName, PWSTR VendorName, uint* ResumeHandle, 
                       uint PreferredMaximum, DHCP_OPTION_ARRAY** Options, uint* OptionsRead, uint* OptionsTotal);

///The <b>DhcpRemoveOptionV5</b> function removes the definition of a specific option for a specific user class and
///vendor class at the default option level on the DHCP server. This extends the functionality in DhcpRemoveOption with
///support for specific class and vendor names.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    Flags = Specifies a bit flag that indicates whether or not the option is vendor-specific. If it is not, this parameter
///            should be 0. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0x00000000</dt>
///            </dl> </td> <td width="60%"> This flag should be set if the option is removed for the default vendor class..
///            </td> </tr> <tr> <td width="40%"><a id="DHCP_FLAGS_OPTION_IS_VENDOR"></a><a
///            id="dhcp_flags_option_is_vendor"></a><dl> <dt><b>DHCP_FLAGS_OPTION_IS_VENDOR</b></dt> <dt>0x00000003</dt> </dl>
///            </td> <td width="60%"> This flag should be set if the option is removed for a specific vendor class.. </td> </tr>
///            </table>
///    OptionID = DHCP_OPTION_ID value that specifies the code for the option to remove.
///    ClassName = Unicode string that specifies the DHCP class name of the option. This parameter is optional.
///    VendorName = Unicode string that specifies the vendor of the option. This parameter is optional, and should be <b>NULL</b>
///                 when <i>Flags</i> is not set to DHCP_FLAGS_OPTION_IS_VENDOR.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_OPTION_NOT_PRESENT</b></dt> </dl>
///    </td> <td width="60%"> The specified option definition does not exist in the DHCP server database. </td> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_CLASS_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The supplied
///    class name is either unknown or incorrect. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpRemoveOptionV5(PWSTR ServerIpAddress, uint Flags, uint OptionID, PWSTR ClassName, PWSTR VendorName);

///The <b>DhcpSetOptionValueV5</b> function sets information for a specific option value on the DHCP server. This
///function extends the functionality provided by DhcpSetOptionValue by allowing the caller to specify a class and/or
///vendor for the option.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    Flags = Specifies a bit flag that indicates whether or not the option is vendor-specific. If it is not, this parameter
///            should be 0. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="DHCP_FLAGS_OPTION_IS_VENDOR"></a><a id="dhcp_flags_option_is_vendor"></a><dl>
///            <dt><b>DHCP_FLAGS_OPTION_IS_VENDOR</b></dt> </dl> </td> <td width="60%"> This flag should be set if the option is
///            provided by a vendor. </td> </tr> </table>
///    OptionId = DHCP_OPTION_ID value that contains the unique option ID number (also called an "option code") of the option being
///               set. Many of these option ID numbers are defined; a complete list of standard DHCP and BOOTP option codes can be
///               found at http://www.ietf.org/rfc/rfc2132.txt.
///    ClassName = Unicode string that specifies the DHCP class of the option. This parameter is optional.
///    VendorName = Unicode string that specifies the vendor of the option. This parameter is optional, and should be <b>NULL</b>
///                 when <i>Flags</i> is not set to DHCP_FLAGS_OPTION_IS_VENDOR.
///    ScopeInfo = Pointer to a DHCP_OPTION_SCOPE_INFO structure that contains information describing the DHCP scope this option
///                value will be set on.
///    OptionValue = Pointer to a DHCP_OPTION_DATA structure that contains the data value corresponding to the DHCP option code
///                  specified by <i>OptionID</i>.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpSetOptionValueV5(PWSTR ServerIpAddress, uint Flags, uint OptionId, PWSTR ClassName, PWSTR VendorName, 
                          DHCP_OPTION_SCOPE_INFO* ScopeInfo, DHCP_OPTION_DATA* OptionValue);

///The <b>DhcpSetOptionValuesV5</b> function sets option codes and their associated data values for a specific scope
///defined on the DHCP server. This function extends the functionality provided by DhcpSetOptionValues by allowing the
///caller to specify a class and/or vendor for the options.
///Params:
///    ServerIpAddress = Unicode string that specifies the IPv4 address of the DHCP server.
///    Flags = This parameter must be set to 0 and ignored upon receipt.
///    ClassName = Unicode string that specifies the DHCP class of the options. This parameter is optional.
///    VendorName = Unicode string that specifies the vendor of the options. If no vendor class is specified, then the option value
///                 is set for the default vendor class. This parameter is optional.
///    ScopeInfo = Pointer to a DHCP_OPTION_SCOPE_INFO structure that contains information describing the DHCP scope these option
///                values will be set on. This parameter indicates whether the option value is set for the default, server, or scope
///                level, or for an IPv4 reservation.
///    OptionValues = Pointer to a DHCP_OPTION_VALUE_ARRAY structure that contains a list of option codes and the corresponding data
///                   value that will be set for them.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl> </td>
///    <td width="60%"> The specified IPv4 subnet does not exist on the DHCP server. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DHCP_OPTION_NOT_PRESENT</b></dt> </dl> </td> <td width="60%"> The specified option definition
///    could not be found in the DHCP server database. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_NOT_RESERVED_CLIENT</b></dt> </dl> </td> <td width="60%"> The specified DHCP client is not an
///    IPv4 reserved client. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_CLASS_NOT_FOUND</b></dt> </dl>
///    </td> <td width="60%"> The specified class name cannot be found in the DHCP server database. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpSetOptionValuesV5(PWSTR ServerIpAddress, uint Flags, PWSTR ClassName, PWSTR VendorName, 
                           DHCP_OPTION_SCOPE_INFO* ScopeInfo, DHCP_OPTION_VALUE_ARRAY* OptionValues);

///The <b>DhcpGetOptionValueV5</b> function retrieves a DHCP option value (the option code and associated data) for a
///particular scope. This function extends the functionality provided by DhcpGetOptionValue by allowing the caller to
///specify a class and/or vendor for the option.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    Flags = Flag value that indicates whether the option is for a specific or default vendor class. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0x00000000</dt> </dl> </td> <td width="60%">
///            The option value is retrieved for a default vendor class. </td> </tr> <tr> <td width="40%"><a
///            id="DHCP_FLAGS_OPTION_IS_VENDOR"></a><a id="dhcp_flags_option_is_vendor"></a><dl>
///            <dt><b>DHCP_FLAGS_OPTION_IS_VENDOR</b></dt> <dt>0x00000003</dt> </dl> </td> <td width="60%"> The option value is
///            retrieved for a specific vendor class. The vendor name is supplied in <i>VendorName</i>. </td> </tr> </table>
///    OptionID = DHCP_OPTION_ID value that specifies the code for the option value to retrieve.
///    ClassName = Unicode string that specifies the DHCP class name of the option. This parameter is optional.
///    VendorName = Unicode string that specifies the vendor of the option. This parameter is optional, and should be null when
///                 <i>Flags</i> is not set to DHCP_FLAGS_OPTION_IS_VENDOR. If the vendor class is not specified, the option value is
///                 returned for the default vendor class.
///    ScopeInfo = DHCP_OPTION_SCOPE_INFO structure that contains information on the scope where the option value is set.
///    OptionValue = DHCP_OPTION_VALUE structure that contains the returned option code and data. <div class="alert"><b>Note</b> <p
///                  class="note">The memory for this parameter must be free using DhcpRpcFreeMemory. </div> <div> </div>
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl>
///    </td> <td width="60%"> The specified IPv4 subnet is not defined on the DHCP server. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_DHCP_OPTION_NOT_PRESENT</b></dt> </dl> </td> <td width="60%"> The specified option
///    definition does not exist in the DHCP server database. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_NOT_RESERVED_CLIENT</b></dt> </dl> </td> <td width="60%"> The specified DHCP client is not a
///    reserved client. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpGetOptionValueV5(PWSTR ServerIpAddress, uint Flags, uint OptionID, PWSTR ClassName, PWSTR VendorName, 
                          DHCP_OPTION_SCOPE_INFO* ScopeInfo, DHCP_OPTION_VALUE** OptionValue);

///The <b>DhcpGetOptionValueV6</b> function retrieves the option value for a specific option defined on the DHCPv6
///server for a specific user or vendor class.
///Params:
///    ServerIpAddress = Unicode string that specifies the IPv6 address or hostname of the DHCPv6 server.
///    Flags = Flag value that indicates whether the option is for a specific or default vendor class. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0x00000000</dt> </dl> </td> <td width="60%">
///            The option value is retrieved for a default vendor class. </td> </tr> <tr> <td width="40%"><a
///            id="DHCP_FLAGS_OPTION_IS_VENDOR"></a><a id="dhcp_flags_option_is_vendor"></a><dl>
///            <dt><b>DHCP_FLAGS_OPTION_IS_VENDOR</b></dt> <dt>0x00000003</dt> </dl> </td> <td width="60%"> The option value is
///            retrieved for a specific vendor class. The vendor name is supplied in <i>VendorName</i>. </td> </tr> </table>
///    OptionID = <b>DHCP_OPTION_ID</b> value that specifies the option identifier for the option being retrieved.
///    ClassName = Pointer to a null-terminated Unicode string that contains the name of the user class for which the option value
///                is being requested. This parameter is optional.
///    VendorName = Pointer to a null-terminated Unicode string that contains the name of the vendor class for which the option value
///                 is being requested. This parameter is optional; if no value is specified, the default vendor class is assumed.
///    ScopeInfo = Pointer to a DHCP_OPTION_SCOPE_INFO6 structure that contains information about the DHCPv6 scope for which the
///                option is value is requested. Specifically, it defines whether the option is being retrieved for the default,
///                server, or scope level, or for a specific IPv6 reservation.
///    OptionValue = Pointer to the address of a DHCP_OPTION_VALUE structure returned by the operation, and which contains the option
///                  value corresponding to <i>OptionID</i>.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The system cannot find the specified file.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
///    The specified subnet is not defined on the DHCPv6 server. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_OPTION_NOT_PRESENT</b></dt> </dl> </td> <td width="60%"> The specified option is not defined at
///    the specified level on the DHCPv6 server. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_NOT_RESERVED_CLIENT</b></dt> </dl> </td> <td width="60%"> The reserved IPv6 client is not
///    defined on the DHCPv6 server. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpGetOptionValueV6(PWSTR ServerIpAddress, uint Flags, uint OptionID, PWSTR ClassName, PWSTR VendorName, 
                          DHCP_OPTION_SCOPE_INFO6* ScopeInfo, DHCP_OPTION_VALUE** OptionValue);

///The <b>DhcpEnumOptionValuesV5</b> function returns an enumerated list of option values (just the option data and the
///associated ID number) for a specific scope within a given user or vendor class.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    Flags = Specifies a bit flag that indicates whether or not the option is vendor specific. If it is not vendor specific,
///            this parameter must be 0. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///            <dt>0x00000000</dt> </dl> </td> <td width="60%"> The option values are enumerated for a default vendor class.
///            </td> </tr> <tr> <td width="40%"><a id="DHCP_FLAGS_OPTION_IS_VENDOR"></a><a
///            id="dhcp_flags_option_is_vendor"></a><dl> <dt><b>DHCP_FLAGS_OPTION_IS_VENDOR</b></dt> <dt>0x00000003</dt> </dl>
///            </td> <td width="60%"> The option values are enumerated for a specific vendor class. </td> </tr> </table>
///    ClassName = Pointer to a Unicode string that contains the name of the class whose scope option values will be enumerated.
///    VendorName = Pointer to a Unicode string that contains the name of the vendor for the class. This parameter is optional. If a
///                 vendor class name is not provided, the option values enumerated for a default vendor class.
///    ScopeInfo = Pointer to a DHCP_OPTION_SCOPE_INFO structure that contains the scope for which the option values are defined.
///                This value defines the option values that will be retrieved from the server, scope, or default level, or for an
///                IPv4 reservation.
///    ResumeHandle = Pointer to a DHCP_RESUME_HANDLE value that identifies the enumeration operation. Initially, this value should be
///                   zero, with a successful call returning the handle value used for subsequent enumeration requests. For example, if
///                   <i>PreferredMaximum</i> is set to 1000 bytes, and 2000 bytes' worth of option values are stored on the server,
///                   the resume handle can be used after the first 1000 bytes are retrieved to obtain the next 1000 on a subsequent
///                   call, and so forth.
///    PreferredMaximum = Specifies the preferred maximum number of bytes of option values to return. If the number of remaining
///                       unenumerated options (in bytes) is less than this value, all option values are returned.
///    OptionValues = Pointer to a DHCP_OPTION_VALUE_ARRAY structure that contains the enumerated option values returned for the
///                   specified scope. If there are no option values available for this scope on the DHCP server, this parameter will
///                   return null.
///    OptionsRead = Pointer to a DWORD value that specifies the number of option values returned in <i>OptionValues</i>.
///    OptionsTotal = Pointer to a DWORD value that specifies the total number of as-yet unenumerated option values for this scope
///                   stored on the DHCP server.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_CLASS_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The supplied user or vendor class name is
///    either incorrect or unknown. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt>
///    </dl> </td> <td width="60%"> The specified IPv4 subnet is not defined on the DHCP server. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_DHCP_NOT_RESERVED_CLIENT</b></dt> </dl> </td> <td width="60%"> The specified DHCP
///    client is not a reserved client. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpEnumOptionValuesV5(PWSTR ServerIpAddress, uint Flags, PWSTR ClassName, PWSTR VendorName, 
                            DHCP_OPTION_SCOPE_INFO* ScopeInfo, uint* ResumeHandle, uint PreferredMaximum, 
                            DHCP_OPTION_VALUE_ARRAY** OptionValues, uint* OptionsRead, uint* OptionsTotal);

///The <b>DhcpRemoveOptionValueV5</b> function removes an option value from a scope defined on the DHCP server.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    Flags = Specifies a bit flag that indicates whether or not the option is vendor-specific. If it is not, this parameter
///            should be zero. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="DHCP_FLAGS_OPTION_IS_VENDOR"></a><a id="dhcp_flags_option_is_vendor"></a><dl>
///            <dt><b>DHCP_FLAGS_OPTION_IS_VENDOR</b></dt> </dl> </td> <td width="60%"> This flag should be set if the option is
///            provided by a vendor. </td> </tr> </table>
///    OptionID = DHCP_OPTION_ID value that specifies the code for the option value to remove.
///    ClassName = Unicode string that specifies the DHCP class name of the option value. This parameter is optional.
///    VendorName = Unicode string that specifies the vendor of the option. This parameter is optional, and should be <b>NULL</b>
///                 when <i>Flags</i> is not set to DHCP_FLAGS_OPTION_IS_VENDOR.
///    ScopeInfo = DHCP_OPTION_SCOPE_INFO structure that contains information describing the specific scope to remove the option
///                value from.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpRemoveOptionValueV5(PWSTR ServerIpAddress, uint Flags, uint OptionID, PWSTR ClassName, PWSTR VendorName, 
                             DHCP_OPTION_SCOPE_INFO* ScopeInfo);

///The <b>DhcpCreateClass</b> function creates a custom option class.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    ReservedMustBeZero = Reserved. This field must be set to zero.
///    ClassInfo = DHCP_CLASS_INFO structure that contains the specific option class data.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_CLASS_ALREADY_EXISTS</b></dt> </dl>
///    </td> <td width="60%"> The specified class name is already defined on the DHCP server, or the class information
///    is already in use.. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpCreateClass(PWSTR ServerIpAddress, uint ReservedMustBeZero, DHCP_CLASS_INFO* ClassInfo);

///The <b>DhcpModifyClass</b> function modifies a DHCP class defined on the server.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    ReservedMustBeZero = Reserved. This value must be set to 0.
///    ClassInfo = Pointer to a DHCP_CLASS_INFO structure that contains the new information for the class.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The DHCP_CLASS_INFO structure provided in
///    <i>ClassInfo</i> has null or invalid values for the <b>ClassName</b> or <b>ClassData</b> member (or both). </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_CLASS_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> A class
///    name could not be found that matches the provided information. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_CLASS_ALREADY_EXISTS</b></dt> </dl>
///    </td> <td width="60%"> The new class name is currently in use, or the new class information is currently in use.
///    </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpModifyClass(PWSTR ServerIpAddress, uint ReservedMustBeZero, DHCP_CLASS_INFO* ClassInfo);

///The <b>DhcpDeleteClass</b> function deletes a DHCP class from the DHCP server.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that contains the IPv6 address of the DHCP server. This string is used as a handle
///                      for resolving RPC API calls.
///    ReservedMustBeZero = Reserved. This parameter must be set to 0.
///    ClassName = Unicode string that specifies the name of the DHCP class to delete.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_CLASS_NOT_FOUND</b></dt> </dl> </td>
///    <td width="60%"> The class name could not be found in the database. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_DELETE_BUILTIN_CLASS</b></dt> </dl> </td> <td width="60%"> The class is a built-in class and
///    cannot be deleted. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpDeleteClass(PWSTR ServerIpAddress, uint ReservedMustBeZero, PWSTR ClassName);

///The <b>DhcpGetClassInfo</b> function returns the user or vendor class information configured on a specific DHCP
///server.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    ReservedMustBeZero = Reserved. This parameter must be set to 0.
///    PartialClassInfo = DHCP_CLASS_INFO structure that contains data provided by the caller for the following members, with all other
///                       fields initialized. <ul> <li><b>ClassName</b></li> <li><b>ClassData</b></li> <li><b>ClassDataLength</b></li>
///                       </ul> These fields must not be null.
///    FilledClassInfo = DHCP_CLASS_INFO structure returned after lookup that contains the complete class information. <div
///                      class="alert"><b>Note</b> <p class="note">The memory for this parameter must be free using DhcpRpcFreeMemory.
///                      </div> <div> </div>
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The DHCP_CLASS_INFO structure provided in
///    <i>PartialClassInfo</i> has null or zero values for one or more of the required members. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_DHCP_CLASS_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> A class name could not
///    be found that matches the provided information. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpGetClassInfo(PWSTR ServerIpAddress, uint ReservedMustBeZero, DHCP_CLASS_INFO* PartialClassInfo, 
                      DHCP_CLASS_INFO** FilledClassInfo);

///The <b>DhcpEnumClasses</b> function enumerates the user or vendor classes configured for the DHCP server.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    ReservedMustBeZero = Reserved. This field must be set to zero.
///    ResumeHandle = Pointer to a DHCP_RESUME_HANDLE value that identifies the enumeration operation. Initially, this value should be
///                   zero, with a successful call returning the handle value used for subsequent enumeration requests. For example, if
///                   <i>PreferredMaximum</i> is set to 100 classes, and 200 classes are stored on the server, the resume handle can be
///                   used after the first 100 classes are retrieved to obtain the next 100 on a subsequent call, and so forth.
///    PreferredMaximum = Specifies the preferred maximum number of classes to return. If the number of remaining unenumerated classes is
///                       less than this value, then that amount will be returned. To retrieve all classes available on the DHCP server,
///                       set this parameter to 0xFFFFFFFF.
///    ClassInfoArray = Pointer to a DHCP_CLASS_INFO_ARRAY structure that contains the returned classes. If there are no classes
///                     available on the DHCP server, this parameter will return null.
///    nRead = Pointer to a DWORD value that specifies the number of classes returned in <i>ClassInfoArray</i>.
///    nTotal = Pointer to a DWORD value that specifies the total number of classes stored on the DHCP server.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> </table>
///    
@DllImport("dhcpcsvc")
uint DhcpEnumClasses(PWSTR ServerIpAddress, uint ReservedMustBeZero, uint* ResumeHandle, uint PreferredMaximum, 
                     DHCP_CLASS_INFO_ARRAY** ClassInfoArray, uint* nRead, uint* nTotal);

///The <b>DhcpGetAllOptions</b> function returns an array that contains all options defined on the DHCP server.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    Flags = Specifies a bit flag that indicates whether or not the options are vendor-specific. If the qualification of
///            vendor options is not necessary, this parameter should be 0. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///            <tr> <td width="40%"><a id="DHCP_FLAGS_OPTION_IS_VENDOR"></a><a id="dhcp_flags_option_is_vendor"></a><dl>
///            <dt><b>DHCP_FLAGS_OPTION_IS_VENDOR</b></dt> </dl> </td> <td width="60%"> This flag should be set if
///            vendor-specific options are desired. </td> </tr> </table>
///    OptionStruct = Pointer to a DHCP_ALL_OPTIONS structure containing every option defined for a vendor or default class. If there
///                   are no options available on the server, this value will be null. <div class="alert"><b>Note</b> <p
///                   class="note">The memory for this parameter must be free using DhcpRpcFreeMemory. </div> <div> </div>
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server database. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpGetAllOptions(PWSTR ServerIpAddress, uint Flags, DHCP_ALL_OPTIONS** OptionStruct);

///The <b>DhcpGetAllOptionsV6</b> function returns an array that contains all options defined on the DHCP server.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    Flags = Specifies a bit flag that indicates whether or not the options are vendor-specific. If the qualification of
///            vendor options is not necessary, this parameter should be 0. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///            <tr> <td width="40%"><a id="DHCP_FLAGS_OPTION_IS_VENDOR"></a><a id="dhcp_flags_option_is_vendor"></a><dl>
///            <dt><b>DHCP_FLAGS_OPTION_IS_VENDOR</b></dt> </dl> </td> <td width="60%"> This flag should be set if
///            vendor-specific options are desired. </td> </tr> </table>
///    OptionStruct = Pointer to a DHCP_ALL_OPTIONS structure containing every option defined on the DHCP server. If there are no
///                   options available on the server, this value will be null. <div class="alert"><b>Note</b> <p class="note">The
///                   memory for this parameter must be free using DhcpRpcFreeMemory. </div> <div> </div>
@DllImport("DHCPSAPI")
uint DhcpGetAllOptionsV6(PWSTR ServerIpAddress, uint Flags, DHCP_ALL_OPTIONS** OptionStruct);

///The <b>DhcpGetAllOptionValues</b> function returns an array that contains all option values defined for a specific
///scope on the DHCP server.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    Flags = Specifies a bit flag that indicates whether the options are vendor-specific. If the qualification of vendor
///            options is not necessary, this parameter should be 0. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///            width="40%"><a id="DHCP_FLAGS_OPTION_IS_VENDOR"></a><a id="dhcp_flags_option_is_vendor"></a><dl>
///            <dt><b>DHCP_FLAGS_OPTION_IS_VENDOR</b></dt> </dl> </td> <td width="60%"> This flag should be set if
///            vendor-specific options are desired. </td> </tr> </table>
///    ScopeInfo = Pointer to a DHCP_OPTION_SCOPE_INFO structure that contains information on the specific scope whose option values
///                will be returned. This information defines the option values that are being retrieved from the default, server,
///                or scope level, or for a specific IPv4 reservation.
///    Values = Pointer to a DHCP_ALL_OPTION_VALUES structure that contains the returned option values for the scope specified in
///             <i>ScopeInfo</i>. <div class="alert"><b>Note</b> <p class="note">The memory for this parameter must be free using
///             DhcpRpcFreeMemory. </div> <div> </div>
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl> </td> <td width="60%"> This specified IPv4 sunet is not
///    defined on the DHCP server. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_NOT_RESERVED_CLIENT</b></dt>
///    </dl> </td> <td width="60%"> The specified DHCP client is not a reserved client. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpGetAllOptionValues(PWSTR ServerIpAddress, uint Flags, DHCP_OPTION_SCOPE_INFO* ScopeInfo, 
                            DHCP_ALL_OPTION_VALUES** Values);

///The <b>DhcpGetAllOptionValuesV6</b> function returns an array that contains all option values defined for a specific
///scope on the DHCP server.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    Flags = Specifies a bit flag that indicates whether or not the options are vendor-specific. If the qualification of
///            vendor options is not necessary, this parameter should be 0. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///            <tr> <td width="40%"><a id="DHCP_FLAGS_OPTION_IS_VENDOR"></a><a id="dhcp_flags_option_is_vendor"></a><dl>
///            <dt><b>DHCP_FLAGS_OPTION_IS_VENDOR</b></dt> </dl> </td> <td width="60%"> This flag should be set if
///            vendor-specific options are desired. </td> </tr> </table>
///    ScopeInfo = DHCP_OPTION_SCOPE_INFO6 structure that contains information on the specific scope whose option values will be
///                returned.
///    Values = DHCP_ALL_OPTION_VALUES structure that contains the returned option values for the scope specified in
///             <i>ScopeInfo</i>. <div class="alert"><b>Note</b> <p class="note">The memory for this parameter must be free using
///             DhcpRpcFreeMemory. </div> <div> </div>
@DllImport("DHCPSAPI")
uint DhcpGetAllOptionValuesV6(PWSTR ServerIpAddress, uint Flags, DHCP_OPTION_SCOPE_INFO6* ScopeInfo, 
                              DHCP_ALL_OPTION_VALUES** Values);

///The <b>DhcpEnumServers</b> function returns an enumerated list of DHCP servers found in the directory service.
///Params:
///    Flags = Reserved for future use. This field should be set to 0.
///    IdInfo = Pointer to an address containing the server's ID block. This field should be set to null.
///    Servers = Pointer to a DHCP_SERVER_INFO_ARRAYstructure that contains the output list of DHCP servers.
///    CallbackFn = Pointer to the callback function that will be called when the server add operation completes. This field should
///                 be null.
///    CallbackData = Pointer to a data block containing the formatted structure for callback information. This field should be null.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpEnumServers(uint Flags, void* IdInfo, DHCPDS_SERVERS** Servers, void* CallbackFn, void* CallbackData);

///The <b>DhcpAddServer</b> function attempts to add a new server to the existing list of DHCP servers maintained in the
///domain directory service. If the specified DHCP server already exists in the directory service, an error is returned.
///Params:
///    Flags = Reserved for future use. This field should be set to 0x00000000.
///    IdInfo = Pointer to an address containing the server's ID block. This field should be set to null.
///    NewServer = Pointer to a DHCP_SERVER_INFO structure containing information about the new DHCP server. The <b>DsLocation</b>
///                and <b>DsLocType</b> members present in this structure are not valid in this implementation, and they should be
///                set to null. The <b>Version</b> member of this structure should be set to 0.
///    CallbackFn = Pointer to the callback function that will be called when the server add operation completes. This field should
///                 be null.
///    CallbackData = Pointer to a data block containing the formatted structure for callback information. This field should be null.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpAddServer(uint Flags, void* IdInfo, DHCPDS_SERVER* NewServer, void* CallbackFn, void* CallbackData);

///The <b>DhcpDeleteServer</b> function attempts to delete a DHCP server and any related objects (such as subnet
///information and IP reservations) from the directory service.
///Params:
///    Flags = Set to zero.
///    IdInfo = Set to null.
///    NewServer = Pointer to a DHCP_SERVER_INFO structure that contains the details of the DHCP server to delete from the directory
///                service.
///    CallbackFn = Pointer to the function to call after this operation is executed. Set to null.
///    CallbackData = Pointer to the list of data that will be passed to the callback function specified in <i>CallbackFn</i>. Set to
///                   null.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpDeleteServer(uint Flags, void* IdInfo, DHCPDS_SERVER* NewServer, void* CallbackFn, void* CallbackData);

///The <b>DhcpGetServerBindingInfo</b> function returns endpoint bindings set on the DHCP server.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    Flags = Specifies a set of flags describing the endpoints to return. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///            <tr> <td width="40%"><a id="DHCP_ENDPOINT_FLAG_CANT_MODIFY"></a><a id="dhcp_endpoint_flag_cant_modify"></a><dl>
///            <dt><b>DHCP_ENDPOINT_FLAG_CANT_MODIFY</b></dt> <dt>0x01</dt> </dl> </td> <td width="60%"> Returns unmodifiable
///            endpoints only. </td> </tr> </table>
///    BindElementsInfo = Pointer to a DHCP_BIND_ELEMENT_ARRAY structure that contains the server network endpoint bindings. <div
///                       class="alert"><b>Note</b> <p class="note">The memory for this parameter must be free using DhcpRpcFreeMemory.
///                       </div> <div> </div>
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpGetServerBindingInfo(const(PWSTR) ServerIpAddress, uint Flags, DHCP_BIND_ELEMENT_ARRAY** BindElementsInfo);

///The <b>DhcpSetServerBindingInfo</b> function sets endpoint bindings for the DHCP server.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    Flags = Specifies a set of flags describing endpoint properties. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
///            <td width="40%"><a id="DHCP_ENDPOINT_FLAG_CANT_MODIFY"></a><a id="dhcp_endpoint_flag_cant_modify"></a><dl>
///            <dt><b>DHCP_ENDPOINT_FLAG_CANT_MODIFY</b></dt> <dt>0x01</dt> </dl> </td> <td width="60%"> The endpoints cannot be
///            modified. </td> </tr> </table>
///    BindElementInfo = DHCP_BIND_ELEMENT_ARRAY structure that contains the endpoint bindings for the DHCP server.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpSetServerBindingInfo(const(PWSTR) ServerIpAddress, uint Flags, DHCP_BIND_ELEMENT_ARRAY* BindElementInfo);

///The <b>DhcpAddSubnetElementV5</b> function adds an element describing a feature or aspect of the subnet to the subnet
///entry in the DHCP database. <b>Windows 2000 and earlier: </b>This function is not available.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that contains the IP address or hostname of the subnet DHCP server.
///    SubnetAddress = DHCP_IP_ADDRESS structure that contains the IP address of the subnet.
///    AddElementInfo = Pointer to a DHCP_SUBNET_ELEMENT_DATA_V5 structure that contains the element data to add to the subnet. The V5
///                     structure adds support for BOOTP clients.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpAddSubnetElementV5(const(PWSTR) ServerIpAddress, uint SubnetAddress, 
                            const(DHCP_SUBNET_ELEMENT_DATA_V5)* AddElementInfo);

///The <b>DhcpEnumSubnetElementsV5</b> function returns an enumerated list of elements for a specific DHCP subnet.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    SubnetAddress = DHCP_IP_ADDRESS value that specifies the address of the IP subnet whose elements will be enumerated.
///    EnumElementType = DHCP_SUBNET_ELEMENT_TYPE enumeration value that indicates the type of subnet element to enumerate.
///    ResumeHandle = Pointer to a DHCP_RESUME_HANDLE value that identifies the enumeration operation. Initially, this value should be
///                   zero, with a successful call returning the handle value used for subsequent enumeration requests. For example, if
///                   <i>PreferredMaximum</i> is set to 1000 bytes, and 2000 bytes worth of subnet elements are stored on the server,
///                   the resume handle can be used after the first 1000 bytes are retrieved to obtain the next 1000 on a subsequent
///                   call, and so forth. The presence of additional enumerable data is indicated when this function returns
///                   ERROR_MORE_DATA. If no additional enumerable data is available on the DHCPv4 server, ERROR_NO_MORE_ITEMS is
///                   returned.
///    PreferredMaximum = Specifies the preferred maximum number of bytes of subnet elements to return. If the number of remaining
///                       unenumerated options (in bytes) is less than this value, then that amount will be returned. To retrieve all the
///                       subnet client elements for the default user and vendor class at the specified level, set this parameter to
///                       0xFFFFFFFF.
///    EnumElementInfo = Pointer to a DHCP_SUBNET_ELEMENT_INFO_ARRAY_V5 structure containing an enumerated list of all elements available
///                      for the specified subnet. If no elements are available for enumeration, this value will be null.
///    ElementsRead = Pointer to a DWORD value that specifies the number of subnet elements returned in <i>EnumElementInfo</i>.
///    ElementsTotal = Pointer to a DWORD value that specifies the total number of elements for the specified subnet.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. Common errors include the following: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> This error can be returned when this function is called with <i>EnumElementType</i> set to
///    <b>DhcpIpRangesDhcpOnly</b> or <b>DhcpIpRangesDhcpBootp</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> There are more elements available to enumerate.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> There are
///    no more elements left to enumerate. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpEnumSubnetElementsV5(const(PWSTR) ServerIpAddress, uint SubnetAddress, 
                              DHCP_SUBNET_ELEMENT_TYPE EnumElementType, uint* ResumeHandle, uint PreferredMaximum, 
                              DHCP_SUBNET_ELEMENT_INFO_ARRAY_V5** EnumElementInfo, uint* ElementsRead, 
                              uint* ElementsTotal);

///The <b>DhcpRemoveSubnetElementV5</b> function removes an element from a subnet defined on the DHCP server.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    SubnetAddress = DHCP_IP_ADDRESS value that specifies the IP address of the subnet gateway and uniquely identifies it.
///    RemoveElementInfo = DHCP_SUBNET_ELEMENT_DATA_V5 structure that contains information used to find the element that will be removed
///                        from subnet specified in <i>SubnetAddress</i>.
///    ForceFlag = DHCP_FORCE_FLAG enumeration value that indicates whether or not the clients affected by the removal of the subnet
///                element should also be deleted.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpRemoveSubnetElementV5(const(PWSTR) ServerIpAddress, uint SubnetAddress, 
                               const(DHCP_SUBNET_ELEMENT_DATA_V5)* RemoveElementInfo, DHCP_FORCE_FLAG ForceFlag);

///The <b>DhcpV4EnumSubnetReservations</b> function enumerates the reservations for a specific DHCP IPv4 subnet.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    SubnetAddress = DHCP_IP_ADDRESS structure that contains the IPv4 subnet address of the reservations to enumerate.
///    ResumeHandle = Pointer to a DHCP_RESUME_HANDLE structure that identifies this enumeration for use in subsequent calls to this
///                   function. Initially, this value should be zero on input. If successful, the returned value should be used for
///                   subsequent enumeration requests. For example, if <i>PreferredMaximum</i> is set to 100, and 200 reservation
///                   elements are configured on the server, the resume handle can be used after the first 100 policies are retrieved
///                   to obtain the next 100 on a subsequent call.
///    PreferredMaximum = The maximum number of bytes of subnet reservations to return in <i>EnumInfo</i>. If <i>PreferredMaximum</i> is
///                       greater than the number of remaining non-enumerated bytes of subnet reservations on the server, the remaining
///                       number of non-enumerated bytes is returned. To retrieve all the subnet reservation elements, set this parameter
///                       to 0xFFFFFFFF.
///    EnumElementInfo = Pointer to a DHCP_RESERVATION_INFO_ARRAY structure that contains the reservations elements available for the
///                      specified subnet. If no elements are configured, this value is <b>NULL</b>.
///    ElementsRead = Pointer to a <b>DWORD</b> that specifies the number of reservation elements returned in <i>EnumElementInfo</i>.
///    ElementsTotal = Pointer to a <b>DWORD</b> that specifies the number of reservations on the DHCP server that have not yet been
///                    enumerated.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td>
///    <td width="60%"> There are more elements available to enumerate. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> There are no more elements left to enumerate.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl> </td> <td width="60%">
///    IPv4 subnet does not exist on the DHCPv4 server. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4EnumSubnetReservations(const(PWSTR) ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, 
                                  uint PreferredMaximum, DHCP_RESERVATION_INFO_ARRAY** EnumElementInfo, 
                                  uint* ElementsRead, uint* ElementsTotal);

///The <b>DhcpCreateOptionV6</b> function creates a DHCP option.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    Flags = Specifies a bit flag that indicates whether or not the option is vendor-specific. If it is not, this parameter
///            should be 0. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="DHCP_FLAGS_OPTION_IS_VENDOR"></a><a id="dhcp_flags_option_is_vendor"></a><dl>
///            <dt><b>DHCP_FLAGS_OPTION_IS_VENDOR</b></dt> </dl> </td> <td width="60%"> This flag must be set if the option is
///            provided by a vendor. </td> </tr> </table>
///    OptionId = DHCP_OPTION_ID value that contains the unique option ID number (also called an "option code") of the new option.
///               Many of these option ID numbers are defined; a complete list of standard DHCP and BOOTP option codes can be found
///               at http://www.ietf.org/rfc/rfc3315.txt.
///    ClassName = Unicode string that specifies the name of the DHCP class that will contain this option. This field is optional.
///    VendorName = Unicode string that contains a vendor name string if the class specified in <i>ClassName</i> is a vendor-specific
///                 class.
///    OptionInfo = DHCP_OPTION structure that contains information describing the new DHCP option, including the name, an optional
///                 comment, and any related data items.
@DllImport("DHCPSAPI")
uint DhcpCreateOptionV6(PWSTR ServerIpAddress, uint Flags, uint OptionId, PWSTR ClassName, PWSTR VendorName, 
                        DHCP_OPTION* OptionInfo);

///The <b>DhcpRemoveOptionV6</b> function removes an option defined on the DHCP server..
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    Flags = Specifies a bit flag that indicates whether or not the option is vendor-specific. If it is not, this parameter
///            should be 0. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="DHCP_FLAGS_OPTION_IS_VENDOR"></a><a id="dhcp_flags_option_is_vendor"></a><dl>
///            <dt><b>DHCP_FLAGS_OPTION_IS_VENDOR</b></dt> </dl> </td> <td width="60%"> This flag should be set if the option is
///            provided by a vendor. </td> </tr> </table>
///    OptionID = DHCP_OPTION_ID value that specifies the code for the option to remove.
///    ClassName = Unicode string that specifies the DHCP class name of the option. This parameter is optional.
///    VendorName = Unicode string that specifies the vendor of the option. This parameter is optional, and should be <b>NULL</b>
///                 when <i>Flags</i> is not set to DHCP_FLAGS_OPTION_IS_VENDOR.
@DllImport("DHCPSAPI")
uint DhcpRemoveOptionV6(PWSTR ServerIpAddress, uint Flags, uint OptionID, PWSTR ClassName, PWSTR VendorName);

///The <b>DhcpEnumOptionsV6</b> function returns an enumerated list of DHCP options for a given class and/or vendor.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    Flags = Specifies a bit flag that indicates whether or not the option is vendor-specific. If it is not, this parameter
///            should be 0. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="DHCP_FLAGS_OPTION_IS_VENDOR"></a><a id="dhcp_flags_option_is_vendor"></a><dl>
///            <dt><b>DHCP_FLAGS_OPTION_IS_VENDOR</b></dt> </dl> </td> <td width="60%"> This flag should be set if the option is
///            provided by a vendor. </td> </tr> </table>
///    ClassName = Unicode string that contains the name of the class whose options will be enumerated.
///    VendorName = Unicode string that contains the name of the vendor for the class. This parameter is optional.
///    ResumeHandle = Pointer to a DHCP_RESUME_HANDLE value that identifies the enumeration operation. Initially, this value should be
///                   zero, with a successful call returning the handle value used for subsequent enumeration requests. For example, if
///                   <i>PreferredMaximum</i> is set to 1000 bytes, and 2000 bytes worth of options are stored on the server, the
///                   resume handle can be used after the first 1000 bytes are retrieved to obtain the next 1000 on a subsequent call,
///                   and so forth.
///    PreferredMaximum = Specifies the preferred maximum number of bytes of options to return. If the number of remaining unenumerated
///                       options (in bytes) is less than this value, then that amount will be returned.
///    Options = Pointer to a DHCP_OPTION_ARRAY structure containing the returned options. If there are no options available on
///              the DHCP server, this parameter will return null.
///    OptionsRead = Pointer to a DWORD value that specifies the number of options returned in <i>Options</i>.
///    OptionsTotal = Pointer to a DWORD value that specifies the total number of options stored on the DHCP server.
@DllImport("DHCPSAPI")
uint DhcpEnumOptionsV6(PWSTR ServerIpAddress, uint Flags, PWSTR ClassName, PWSTR VendorName, uint* ResumeHandle, 
                       uint PreferredMaximum, DHCP_OPTION_ARRAY** Options, uint* OptionsRead, uint* OptionsTotal);

///The <b>DhcpRemoveOptionValueV6</b> function removes an option value from a scope defined on the DHCP server.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    Flags = Specifies a bit flag that indicates whether or not the option is vendor-specific. If it is not, this parameter
///            should be zero. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="DHCP_FLAGS_OPTION_IS_VENDOR"></a><a id="dhcp_flags_option_is_vendor"></a><dl>
///            <dt><b>DHCP_FLAGS_OPTION_IS_VENDOR</b></dt> </dl> </td> <td width="60%"> This flag should be set if the option is
///            provided by a vendor. </td> </tr> </table>
///    OptionID = DHCP_OPTION_ID value that specifies the code for the option value to remove.
///    ClassName = Unicode string that specifies the DHCP class name of the option value. This parameter is optional.
///    VendorName = Unicode string that specifies the vendor of the option. This parameter is optional, and should be <b>NULL</b>
///                 when <i>Flags</i> is not set to DHCP_FLAGS_OPTION_IS_VENDOR.
///    ScopeInfo = DHCP_OPTION_SCOPE_INFO6 structure that contains information describing the specific scope to remove the option
///                value from.
@DllImport("DHCPSAPI")
uint DhcpRemoveOptionValueV6(PWSTR ServerIpAddress, uint Flags, uint OptionID, PWSTR ClassName, PWSTR VendorName, 
                             DHCP_OPTION_SCOPE_INFO6* ScopeInfo);

///The <b>DhcpGetOptionInfoV6</b> function returns information on a specific DHCP option.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    Flags = Specifies a bit flag that indicates whether or not the option is vendor-specific. If it is not, this parameter
///            should be 0. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="DHCP_FLAGS_OPTION_IS_VENDOR"></a><a id="dhcp_flags_option_is_vendor"></a><dl>
///            <dt><b>DHCP_FLAGS_OPTION_IS_VENDOR</b></dt> </dl> </td> <td width="60%"> This flag should be set if the option is
///            provided by a vendor. </td> </tr> </table>
///    OptionID = DHCP_OPTION_ID value that specifies the code for the option to retrieve information on.
///    ClassName = Unicode string that specifies the DHCP class name of the option. This parameter is optional.
///    VendorName = Unicode string that specifies the vendor of the option. This parameter is optional, and should be null when
///                 <i>Flags</i> is not set to DHCP_FLAGS_OPTION_IS_VENDOR.
///    OptionInfo = Pointer to a DHCP_OPTION structure that contains the returned information on the option specified by
///                 <i>OptionID</i>. <div class="alert"><b>Note</b> <p class="note">The memory for this parameter must be free using
///                 DhcpRpcFreeMemory. </div> <div> </div>
@DllImport("DHCPSAPI")
uint DhcpGetOptionInfoV6(PWSTR ServerIpAddress, uint Flags, uint OptionID, PWSTR ClassName, PWSTR VendorName, 
                         DHCP_OPTION** OptionInfo);

///The <b>DhcpSetOptionInfoV6</b> function sets information for a specific DHCP option.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    Flags = Specifies a bit flag that indicates whether or not the option is vendor-specific. If it is not, this parameter
///            should be 0. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="DHCP_FLAGS_OPTION_IS_VENDOR"></a><a id="dhcp_flags_option_is_vendor"></a><dl>
///            <dt><b>DHCP_FLAGS_OPTION_IS_VENDOR</b></dt> </dl> </td> <td width="60%"> This flag should be set if the option is
///            provided by a vendor. </td> </tr> </table>
///    OptionID = DHCP_OPTION_ID value that specifies the code for a specific DHCP option.
///    ClassName = Unicode string that specifies the DHCP class name of the option. This parameter is optional.
///    VendorName = Unicode string that specifies the vendor of the option. This parameter is optional, and should be <b>NULL</b>
///                 when <i>Flags</i> is not set to DHCP_FLAGS_OPTION_IS_VENDOR.
///    OptionInfo = Pointer to a DHCP_OPTION structure that contains the information on the option specified by <i>OptionID</i>.
@DllImport("DHCPSAPI")
uint DhcpSetOptionInfoV6(PWSTR ServerIpAddress, uint Flags, uint OptionID, PWSTR ClassName, PWSTR VendorName, 
                         DHCP_OPTION* OptionInfo);

///The <b>DhcpSetOptionValueV6</b> function sets information for a specific option value on the DHCP server.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    Flags = Specifies a bit flag that indicates whether or not the option is vendor-specific. If it is not, this parameter
///            should be 0. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="DHCP_FLAGS_OPTION_IS_VENDOR"></a><a id="dhcp_flags_option_is_vendor"></a><dl>
///            <dt><b>DHCP_FLAGS_OPTION_IS_VENDOR</b></dt> </dl> </td> <td width="60%"> This flag should be set if the option is
///            provided by a vendor. </td> </tr> </table>
///    OptionId = DHCP_OPTION_ID value that contains the unique option ID number (also called an "option code") of the option being
///               set. Many of these option ID numbers are defined; a complete list of standard DHCP and BOOTP option codes can be
///               found at http://www.ietf.org/rfc/rfc2132.txt.
///    ClassName = Unicode string that specifies the DHCP class of the option. This parameter is optional.
///    VendorName = Unicode string that specifies the vendor of the option. This parameter is optional, and should be <b>NULL</b>
///                 when <i>Flags</i> is not set to DHCP_FLAGS_OPTION_IS_VENDOR.
///    ScopeInfo = Pointer to a DHCP_OPTION_SCOPE_INFO6 structure that contains information describing the DHCP scope this option
///                value will be set on.
///    OptionValue = Pointer to a DHCP_OPTION_DATA structure that contains the data value corresponding to the DHCP option code
///                  specified by <i>OptionID</i>.
@DllImport("DHCPSAPI")
uint DhcpSetOptionValueV6(PWSTR ServerIpAddress, uint Flags, uint OptionId, PWSTR ClassName, PWSTR VendorName, 
                          DHCP_OPTION_SCOPE_INFO6* ScopeInfo, DHCP_OPTION_DATA* OptionValue);

///The <b>DhcpGetSubnetInfoVQ</b> function retrieves the information about a specific IPv4 subnet defined on the DHCP
///server.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    SubnetAddress = <b>DHCP_IP_ADDRESS</b> structure that contains the IPv4 address of the subnet for which the information will be
///                    modified.
///    SubnetInfo = A DHCP_SUBNET_INFO_VQ structure that contains the returned information for the subnet matching the IPv4 address
///                 specified by <i>SubnetAddress</i>. <div class="alert"><b>Note</b> <p class="note">The memory for this parameter
///                 must be free using DhcpRpcFreeMemory. </div> <div> </div>
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl>
///    </td> <td width="60%"> The specified subnet is not defined on the DHCP server. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the parameters provides an
///    invalid value. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpGetSubnetInfoVQ(const(PWSTR) ServerIpAddress, uint SubnetAddress, DHCP_SUBNET_INFO_VQ** SubnetInfo);

///The <b>DhcpCreateSubnetVQ</b> function creates a new IPv4 subnet and its associated NAP state information on the DHCP
///server.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    SubnetAddress = A DHCP_IP_ADDRESS value that contains the IPv4 address of the subnet's gateway.
///    SubnetInfo = Pointer to a DHCP_SUBNET_INFO_VQ structure that contains specific settings for the subnet, including the subnet
///                 mask and IPv4 address of the subnet gateway.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. Commonly returned error codes include: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td
///    width="60%"> This call was performed by a client who is not a member of the "DHCP Administrators" security group.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error
///    occurred while accessing the DHCP server's database. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_SUBNET_EXISTS</b></dt> </dl> </td> <td width="60%"> The IPv4 scope parameters specified in the
///    <i>SubnetInfo</i> parameter are incorrect. Either the IPv4 scope already exists, or its subnet address and mask
///    are inconsistent with the subnet address and mask of an existing scope. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpCreateSubnetVQ(const(PWSTR) ServerIpAddress, uint SubnetAddress, const(DHCP_SUBNET_INFO_VQ)* SubnetInfo);

///The <b>DhcpSetSubnetInfoVQ</b> function sets information about a subnet defined on the DHCP server.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    SubnetAddress = DHCP_IP_ADDRESS value that specifies the IP address of the subnet gateway, as well as uniquely identifies the
///                    subnet.
///    SubnetInfo = Pointer to a DHCP_SUBNET_INFO_VQ structure that contains the information about the subnet.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl>
///    </td> <td width="60%"> The specified IPv4 subnet is not defined on the DHCP server. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpSetSubnetInfoVQ(const(PWSTR) ServerIpAddress, uint SubnetAddress, const(DHCP_SUBNET_INFO_VQ)* SubnetInfo);

///The <b>DhcpEnumOptionValuesV6</b> function returns an enumerated list of option values (the option data and the
///associated ID number) for a specific scope within a given class.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    Flags = Specifies a bit flag that indicates whether or not the option is vendor specific. If it is not vendor specific,
///            this parameter should be 0. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///            id="DHCP_FLAGS_OPTION_IS_VENDOR"></a><a id="dhcp_flags_option_is_vendor"></a><dl>
///            <dt><b>DHCP_FLAGS_OPTION_IS_VENDOR</b></dt> </dl> </td> <td width="60%"> This flag should be set if the option is
///            provided by a vendor. </td> </tr> </table>
///    ClassName = Unicode string that contains the name of the class whose scope's option values will be enumerated.
///    VendorName = Unicode string that contains the name of the vendor for the class. This parameter is optional.
///    ScopeInfo = DHCP_OPTION_SCOPE_INFO6 structure that contains the scope for which the option values are defined.
///    ResumeHandle = Pointer to a DHCP_RESUME_HANDLE value that identifies the enumeration operation. Initially, this value should be
///                   zero, with a successful call returning the handle value used for subsequent enumeration requests. For example, if
///                   <i>PreferredMaximum</i> is set to 1000 bytes, and 2000 bytes worth of option values are stored on the server, the
///                   resume handle can be used after the first 1000 bytes are retrieved to obtain the next 1000 on a subsequent call,
///                   and so forth.
///    PreferredMaximum = Specifies the preferred maximum number of bytes of option values to return. If the number of remaining
///                       unenumerated options (in bytes) is less than this value, then that amount will be returned.
///    OptionValues = Pointer to a DHCP_OPTION_VALUE_ARRAY structure that contains the enumerated option values returned for the
///                   specified scope. If there are no option values available for this scope on the DHCP server, this parameter will
///                   return null.
///    OptionsRead = Pointer to a DWORD value that specifies the number of option values returned in <i>OptionValues</i>.
///    OptionsTotal = Pointer to a DWORD value that specifies the total number of option values for this scope stored on the DHCP
///                   server.
@DllImport("DHCPSAPI")
uint DhcpEnumOptionValuesV6(const(PWSTR) ServerIpAddress, uint Flags, PWSTR ClassName, PWSTR VendorName, 
                            DHCP_OPTION_SCOPE_INFO6* ScopeInfo, uint* ResumeHandle, uint PreferredMaximum, 
                            DHCP_OPTION_VALUE_ARRAY** OptionValues, uint* OptionsRead, uint* OptionsTotal);

///The <b>DhcpDsInit</b> function initializes memory within the directory service for a new DHCP server process.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpDsInit();

///The <b>DhcpDsCleanup</b> function frees up directory service resources allocated for DHCP services by DhcpDsInit.
///This function should be called exactly once for each corresponding DHCP service process, and only when the process is
///terminated.
@DllImport("DHCPSAPI")
void DhcpDsCleanup();

///The <b>DhcpSetThreadOptions</b> function sets options on the currently executing DHCP thread.
///Params:
///    Flags = Set of bit flags indicating thread settings. If no thread options are set, the value is 0. Currently, the only
///            bit flag that can be set is as follows. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///            width="40%"><a id="DHCP_FLAGS_DONT_ACCESS_DS"></a><a id="dhcp_flags_dont_access_ds"></a><dl>
///            <dt><b>DHCP_FLAGS_DONT_ACCESS_DS</b></dt> </dl> </td> <td width="60%"> Do not access the directory service while
///            the DHCP thread is executing. After this option is set, the only functions that can access the domain directory
///            service are as follows: <ul> <li> DhcpEnumServers </li> <li> DhcpAddServer </li> <li> DhcpDeleteServer </li>
///            </ul> </td> </tr> </table>
///    Reserved = Reserved. This parameter must be set to <b>NULL</b>.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpSetThreadOptions(uint Flags, void* Reserved);

///The <b>DhcpGetThreadOptions</b> function retrieves the current thread options as set by DhcpSetThreadOptions.
///Params:
///    pFlags = Set of bit flags as set by a previous call to DhcpSetThreadOptions. If no thread options are set, the return
///             value is 0. Currently, the only bit flag that can be set is as follows. <table> <tr> <th>Value</th>
///             <th>Meaning</th> </tr> <tr> <td width="40%"><a id="DHCP_FLAGS_DONT_ACCESS_DS"></a><a
///             id="dhcp_flags_dont_access_ds"></a><dl> <dt><b>DHCP_FLAGS_DONT_ACCESS_DS</b></dt> </dl> </td> <td width="60%"> Do
///             not access the directory service while the DHCP thread is executing. After this option is set, the only functions
///             that can access the domain directory service are: <ul> <li> DhcpEnumServers </li> <li> DhcpAddServer </li> <li>
///             DhcpDeleteServer </li> </ul> </td> </tr> </table>
///    Reserved = Reserved. This parameter must be set to null.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpGetThreadOptions(uint* pFlags, void* Reserved);

///The <b>DhcpServerQueryAttribute</b> function returns specific attribute information from the DHCP server.
///Params:
///    ServerIpAddr = Unicode string that contains the IP address of the DHCP server.
///    dwReserved = Reserved. This value must be zero.
///    DhcpAttribId = DHCP_ATTRIB_ID value that specifies the particular DHCP server attribute to retrieve.
///    pDhcpAttrib = Pointer to a DHCP_ATTRIB structure that contains the location and type of the queried DHCP server attribute.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpServerQueryAttribute(PWSTR ServerIpAddr, uint dwReserved, uint DhcpAttribId, DHCP_ATTRIB** pDhcpAttrib);

///The <b>DhcpServerQueryAttributes</b> function returns an array of attributes set on the DHCP server.
///Params:
///    ServerIpAddr = Unicode string that specifies the IP address or hostname of the DHCP server.
///    dwReserved = Reserved. This value must be set to zero.
///    dwAttribCount = Specifies the number of attributes listed in <i>pDhcpAttribArr</i>.
///    pDhcpAttribs = Specifies an array of DHCP_ATTRIB_ID values (of length <i>dwAttribCount</i>) to retrieve the corresponding
///                   attribute information from.
///    pDhcpAttribArr = Pointer to a DHCP_ATTRIB_ARRAY structure that contains the attributes directly corresponding to the attribute ID
///                     values specified in <i>pDhcpAttribs[]</i>.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpServerQueryAttributes(PWSTR ServerIpAddr, uint dwReserved, uint dwAttribCount, uint* pDhcpAttribs, 
                               DHCP_ATTRIB_ARRAY** pDhcpAttribArr);

///The <b>DhcpServerRedoAuthorization</b> function attempts to determine whether the DHCP server is authorized and
///restores leasing operations if it is not.
///Params:
///    ServerIpAddr = Unicode string that specifies the IP address or hostname of the DHCP server.
///    dwReserved = Reserved. This parameter should be set to 0.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpServerRedoAuthorization(PWSTR ServerIpAddr, uint dwReserved);

///The <b>DhcpAuditLogSetParams</b> function sets the parameters for audit log generation on a DHCP server.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    Flags = Specifies a set of bit flags for filtering the audit log. Currently, this parameter is reserved and should be set
///            to 0.
///    AuditLogDir = Unicode string that contains the specific directory and file name where the audit log will be stored. This string
///                  should contain the absolute path within the file system; for example, "C:\logs\dhcp\20031020.log".
///    DiskCheckInterval = Specifies the disk check interval for attempting to write the audit log to the specified file as the number of
///                        logged DHCP server events that should occur between checks. The default is 50 DHCP server events between checks.
///    MaxLogFilesSize = Specifies the maximum log file size, in bytes.
///    MinSpaceOnDisk = Specifies the minimum required disk space, in bytes, for audit log storage.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpAuditLogSetParams(PWSTR ServerIpAddress, uint Flags, PWSTR AuditLogDir, uint DiskCheckInterval, 
                           uint MaxLogFilesSize, uint MinSpaceOnDisk);

///The <b>DhcpAuditLogGetParams</b> function returns the audit log configuration settings from the DHCP server.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    Flags = Specifies a set of bit flags for filtering the audit log. Currently, this parameter is reserved and should be set
///            to 0.
///    AuditLogDir = Unicode string that contains the directory where the audit log is stored as an absolute path within the file
///                  system.
///    DiskCheckInterval = Specifies the disk check interval for attempting to write the audit log to the specified file as the number of
///                        logged DHCP server events that should occur between checks. The default is 50 DHCP server events between checks.
///    MaxLogFilesSize = Specifies the maximum log file size, in bytes.
///    MinSpaceOnDisk = Specifies the minimum required disk space, in bytes, for audit log storage.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpAuditLogGetParams(PWSTR ServerIpAddress, uint Flags, PWSTR* AuditLogDir, uint* DiskCheckInterval, 
                           uint* MaxLogFilesSize, uint* MinSpaceOnDisk);

///The <b>DhcpServerQueryDnsRegCredentials</b> function retrieves the current Domain Name System (DNS) credentials used
///by the DHCP server for client dynamic DNS registration.
///Params:
///    ServerIpAddress = DHCP_SRV_HANDLE that specifies the RPC binding to the DHCP server that will be queried.
///    UnameSize = Unsigned 32-bit integer that indicates the size, in bytes, to allocate for the data returned in the <i>Uname</i>
///                buffer.
///    Uname = Pointer to a null-terminated Unicode string that contains the user name for the DNS server credentials. The size
///            of this value cannot be larger than the size specified in <i>UnameSize</i>.
///    DomainSize = Unsigned 32-bit integer that indicates the size, in bytes, to allocate for the data returned in the <i>Domain</i>
///                 buffer.
///    Domain = Pointer to a null-terminated Unicode string that contains the domain name for the DNS server credentials. The
///             size of this value cannot be larger than the size specified in <i>DomainSize</i>.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpServerQueryDnsRegCredentials(PWSTR ServerIpAddress, uint UnameSize, PWSTR Uname, uint DomainSize, 
                                      PWSTR Domain);

@DllImport("DHCPSAPI")
uint DhcpServerSetDnsRegCredentials(PWSTR ServerIpAddress, PWSTR Uname, PWSTR Domain, PWSTR Passwd);

///The <b>DhcpServerSetDnsRegCredentialsV5</b> function sets the credentials used by the DHCP server to create Domain
///Name System (DNS) registrations for the DHCP client lease record.
///Params:
///    ServerIpAddress = DHCP_SRV_HANDLE that specifies the RPC binding to the DHCP server on which the DNS credentials will be set.
///    Uname = Pointer to a null-terminated Unicode string that specifies the user name for the DNS credentials.
///    Domain = Pointer to a null-terminated Unicode string that specifies the domain name for the DNS credentials.
///    Passwd = Pointer to a null-terminated Unicode string that specifies the password for the DNS credentials. The password can
///             be unencrypted.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpServerSetDnsRegCredentialsV5(PWSTR ServerIpAddress, PWSTR Uname, PWSTR Domain, PWSTR Passwd);

///The <b>DhcpServerBackupDatabase</b> function backs up the DHCP server database configuration, settings, and DHCP
///client lease record to a specified file location.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    Path = Unicode string that specifies the absolute path to the file where the DHCP server database will be backed up.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpServerBackupDatabase(PWSTR ServerIpAddress, PWSTR Path);

///The <b>DhcpServerRestoreDatabase</b> function restores the settings, configuration, and records for a client lease
///database from a specific backup location (path).
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    Path = Unicode string that specifies the full absolute path and filename to the backup file from which the registry
///           configuration file and client lease database will be restored. Note that this operation will overwrite any
///           database currently held in memory.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpServerRestoreDatabase(PWSTR ServerIpAddress, PWSTR Path);

///The <b>DhcpServerSetConfigVQ</b> function sets or updates DHCP server settings.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    FieldsToSet = Specifies a bitmask of the fields to set in the DHCP_SERVER_CONFIG_INFO_VQ structure passed to <i>ConfigInfo</i>.
///    ConfigInfo = Pointer to a DHCP_SERVER_CONFIG_INFO_VQ structure that contains the new or updated settings for the DHCP server.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpServerSetConfigVQ(const(PWSTR) ServerIpAddress, uint FieldsToSet, DHCP_SERVER_CONFIG_INFO_VQ* ConfigInfo);

///The <b>DhcpServerGetConfigVQ</b> function retrieves the current DHCP server configuration settings.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    ConfigInfo = Pointer to the address of a DHCP_SERVER_CONFIG_INFO_VQ structure that contains the returned DHCP server
///                 configuration settings.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpServerGetConfigVQ(const(PWSTR) ServerIpAddress, DHCP_SERVER_CONFIG_INFO_VQ** ConfigInfo);

///The <b>DhcpGetServerSpecificStrings</b> function retrieves the names of the default vendor class and user class.
///Params:
///    ServerIpAddress = Unicode string that specifies the IPv4 address of the DHCPv4 server.
///    ServerSpecificStrings = Pointer to a DHCP_SERVER_SPECIFIC_STRINGS structure that receives the information for the default vendor class
///                            and user class name strings. <div class="alert"><b>Note</b> <p class="note">The memory for this parameter must be
///                            free using DhcpRpcFreeMemory. </div> <div> </div>
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server database. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpGetServerSpecificStrings(const(PWSTR) ServerIpAddress, 
                                  DHCP_SERVER_SPECIFIC_STRINGS** ServerSpecificStrings);

@DllImport("DHCPSAPI")
void DhcpServerAuditlogParamsFree(DHCP_SERVER_CONFIG_INFO_VQ* ConfigInfo);

///The <b>DhcpCreateSubnetV6</b> function creates a new subnet on the DHCP server.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    SubnetAddress = DHCP_IPV6_ADDRESS value that contains the IP address of the subnet's gateway.
///    SubnetInfo = DHCP_SUBNET_INFO_V6 structure that contains specific settings for the subnet, including the subnet mask and IP
///                 address of the subnet gateway.
@DllImport("DHCPSAPI")
uint DhcpCreateSubnetV6(PWSTR ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, DHCP_SUBNET_INFO_V6* SubnetInfo);

///The <b>DhcpDeleteSubnetV6</b> function deletes a subnet from the DHCP server.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    SubnetAddress = DHCP_IPV6_ADDRESS value that contains the IP address of the subnet gateway used to identify the subnet.
///    ForceFlag = DHCP_FORCE_FLAG enumeration value that indicates the type of delete operation to perform (full force or no
///                force).
@DllImport("DHCPSAPI")
uint DhcpDeleteSubnetV6(PWSTR ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, DHCP_FORCE_FLAG ForceFlag);

///The <b>DhcpEnumSubnetsV6</b> function returns an enumerated list of subnets defined on the DHCP server.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    ResumeHandle = Pointer to a DHCP_RESUME_HANDLE value that identifies the enumeration operation. Initially, this value should be
///                   zero, with a successful call returning the handle value used for subsequent enumeration requests. For example, if
///                   <i>PreferredMaximum</i> is set to 100, and 200 subnet addresses are stored on the server, the resume handle can
///                   be used after the first 100 subnets are retrieved to obtain the next 100 on a subsequent call, and so forth.
///    PreferredMaximum = Specifies the preferred maximum number of subnet addresses to return. If the number of remaining unenumerated
///                       options is less than this value, then that amount will be returned.
///    EnumInfo = Pointer to a DHCPV6_IP_ARRAY structure that contains the subnet IDs available on the DHCP server. If no subnets
///               are defined, this value will be null.
///    ElementsRead = Pointer to a <b>DWORD</b> value that specifies the number of subnet addresses returned in <i>EnumInfo</i>.
///    ElementsTotal = Pointer to a <b>DWORD</b> value that specifies the number of subnets defined on the DHCP server that have not yet
///                    been enumerated.
@DllImport("DHCPSAPI")
uint DhcpEnumSubnetsV6(const(PWSTR) ServerIpAddress, uint* ResumeHandle, uint PreferredMaximum, 
                       DHCPV6_IP_ARRAY** EnumInfo, uint* ElementsRead, uint* ElementsTotal);

///The <b>DhcpAddSubnetElementV6</b> function adds an element describing a feature or aspect of the subnet to the subnet
///entry in the DHCP database.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    SubnetAddress = DHCP_IPV6_ADDRESS structure that contains the IP address of the subnet.
///    AddElementInfo = Pointer to a DHCP_SUBNET_ELEMENT_DATA_V6 structure that contains the element data to add to the subnet. The V5
///                     structure adds support for BOOTP clients.
@DllImport("DHCPSAPI")
uint DhcpAddSubnetElementV6(PWSTR ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, 
                            DHCP_SUBNET_ELEMENT_DATA_V6* AddElementInfo);

///The <b>DhcpRemoveSubnetElementV6</b> function removes an element from a subnet defined on the DHCP server.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    SubnetAddress = DHCP_IPV6_ADDRESS value that specifies the IP address of the subnet gateway and uniquely identifies it.
///    RemoveElementInfo = DHCP_SUBNET_ELEMENT_DATA_V6 structure that contains information used to find the element that will be removed
///                        from subnet specified in <i>SubnetAddress</i>.
///    ForceFlag = DHCP_FORCE_FLAG enumeration value that indicates whether or not the clients affected by the removal of the subnet
///                element should also be deleted.
@DllImport("DHCPSAPI")
uint DhcpRemoveSubnetElementV6(PWSTR ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, 
                               DHCP_SUBNET_ELEMENT_DATA_V6* RemoveElementInfo, DHCP_FORCE_FLAG ForceFlag);

///The <b>DhcpEnumSubnetElementsV6</b> function returns an enumerated list of elements for a specific DHCP subnet.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    SubnetAddress = DHCP_IPV6_ADDRESS value that specifies the subnet whose elements will be enumerated.
///    EnumElementType = DHCP_SUBNET_ELEMENT_TYPE_V6 enumeration value that indicates the type of subnet element to enumerate.
///    ResumeHandle = Pointer to a DHCP_RESUME_HANDLE value that identifies the enumeration operation. Initially, this value should be
///                   zero, with a successful call returning the handle value used for subsequent enumeration requests. For example, if
///                   <i>PreferredMaximum</i> is set to 1000 bytes, and 2000 bytes worth of subnet elements are stored on the server,
///                   the resume handle can be used after the first 1000 bytes are retrieved to obtain the next 1000 on a subsequent
///                   call, and so forth.
///    PreferredMaximum = Specifies the preferred maximum number of bytes of subnet elements to return. If the number of remaining
///                       unenumerated options (in bytes) is less than this value, then that amount will be returned.
///    EnumElementInfo = Pointer to a DHCP_SUBNET_ELEMENT_INFO_ARRAY_V6 structure containing an enumerated list of all elements available
///                      for the specified subnet. If no elements are available for enumeration, this value will be null.
///    ElementsRead = Pointer to a DWORD value that specifies the number of subnet elements returned in <i>EnumElementInfo</i>.
///    ElementsTotal = Pointer to a DWORD value that specifies the total number of elements for the specified subnet.
@DllImport("DHCPSAPI")
uint DhcpEnumSubnetElementsV6(PWSTR ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, 
                              DHCP_SUBNET_ELEMENT_TYPE_V6 EnumElementType, uint* ResumeHandle, uint PreferredMaximum, 
                              DHCP_SUBNET_ELEMENT_INFO_ARRAY_V6** EnumElementInfo, uint* ElementsRead, 
                              uint* ElementsTotal);

///The <b>DhcpGetSubnetInfoV6</b> function returns information on a specific subnet.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    SubnetAddress = DHCP_IPV6_ADDRESS value that specifies the subnet ID.
///    SubnetInfo = DHCP_SUBNET_INFO_V6 structure that contains the returned information for the subnet matching the ID specified by
///                 <i>SubnetAddress</i>. <div class="alert"><b>Note</b> <p class="note">The memory for this parameter must be free
///                 using DhcpRpcFreeMemory. </div> <div> </div>
@DllImport("DHCPSAPI")
uint DhcpGetSubnetInfoV6(PWSTR ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, DHCP_SUBNET_INFO_V6** SubnetInfo);

///The <b>DhcpEnumSubnetClientsV6</b> function returns an enumerated list of clients with served IP addresses in the
///specified subnet.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    SubnetAddress = DHCP_IPV6_ADDRESS value containing the IP address of the subnet gateway.
///    ResumeHandle = Pointer to a DHCP_RESUME_IPV6_HANDLE value that identifies the enumeration operation. Initially, this value
///                   should be zero, with a successful call returning the handle value used for subsequent enumeration requests. For
///                   example, if <i>PreferredMaximum</i> is set to 1000 bytes, and 2000 bytes worth of subnet client information
///                   structures are stored on the server, the resume handle can be used after the first 1000 bytes are retrieved to
///                   obtain the next 1000 on a subsequent call, and so forth.
///    PreferredMaximum = Specifies the preferred maximum number of bytes of subnet client information structures to return. If the number
///                       of remaining unenumerated options (in bytes) is less than this value, then that amount will be returned.
///    ClientInfo = Pointer to a DHCP_CLIENT_INFO_ARRAY_V6 structure containing information on the clients served under this specific
///                 subnet. If no clients are available, this field will be null.
///    ClientsRead = Pointer to a DWORD value that specifies the number of clients returned in <i>ClientInfo</i>.
///    ClientsTotal = Pointer to a DWORD value that specifies the total number of clients for the specified subnet stored on the DHCP
///                   server.
@DllImport("DHCPSAPI")
uint DhcpEnumSubnetClientsV6(const(PWSTR) ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, 
                             DHCP_IPV6_ADDRESS* ResumeHandle, uint PreferredMaximum, 
                             DHCP_CLIENT_INFO_ARRAY_V6** ClientInfo, uint* ClientsRead, uint* ClientsTotal);

///The <b>DhcpServerGetConfigV6</b> function retrieves the configuration information for the DHCPv6 server.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    ScopeInfo = Pointer to a DHCP_OPTION_SCOPE_INFO6 structure used to identify the DHCPv6 scope for which configuration
///                information will be retrieved.
///    ConfigInfo = Pointer to the address of a DHCP_SERVER_CONFIG_INFO_V6 structure that contains the requested configuration
///                 information. <div class="alert"><b>Note</b> <p class="note">The memory for this parameter must be free using
///                 DhcpRpcFreeMemory. </div> <div> </div>
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpServerGetConfigV6(const(PWSTR) ServerIpAddress, DHCP_OPTION_SCOPE_INFO6* ScopeInfo, 
                           DHCP_SERVER_CONFIG_INFO_V6** ConfigInfo);

///The <b>DhcpServerSetConfigV6</b> function sets the DHCPv6 server configuration data at the scope or server level.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    ScopeInfo = Pointer to a DHCP_OPTION_SCOPE_INFO6 structure that contains the configuration information at the scope or server
///                level.
///    FieldsToSet = Specifies the set of value that indicate the type of configuration information provided in <i>ConfigInfo</i>.
///                  Only one of these values may be set per call. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                  width="40%"><a id="Set_UnicastFlag"></a><a id="set_unicastflag"></a><a id="SET_UNICASTFLAG"></a><dl>
///                  <dt><b>Set_UnicastFlag</b></dt> <dt>0x00000001</dt> </dl> </td> <td width="60%"> Not used. </td> </tr> <tr> <td
///                  width="40%"><a id="Set_RapidCommitFlag"></a><a id="set_rapidcommitflag"></a><a id="SET_RAPIDCOMMITFLAG"></a><dl>
///                  <dt><b>Set_RapidCommitFlag</b></dt> <dt>0x00000002</dt> </dl> </td> <td width="60%"> Not used. </td> </tr> <tr>
///                  <td width="40%"><a id="Set_PreferredLifetime"></a><a id="set_preferredlifetime"></a><a
///                  id="SET_PREFERREDLIFETIME"></a><dl> <dt><b>Set_PreferredLifetime</b></dt> <dt>0x00000004</dt> </dl> </td> <td
///                  width="60%"> Sets the preferred lifetime value for a non-temporary IPv6 address. </td> </tr> <tr> <td
///                  width="40%"><a id="Set_ValidLifetime"></a><a id="set_validlifetime"></a><a id="SET_VALIDLIFETIME"></a><dl>
///                  <dt><b>Set_ValidLifetime</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%"> Sets the valid lifetime value
///                  for a non-temporary IPv6 address. </td> </tr> <tr> <td width="40%"><a id="Set_T1"></a><a id="set_t1"></a><a
///                  id="SET_T1"></a><dl> <dt><b>Set_T1</b></dt> <dt>0x00000010</dt> </dl> </td> <td width="60%"> Sets the T1 time
///                  value. </td> </tr> <tr> <td width="40%"><a id="Set_T2"></a><a id="set_t2"></a><a id="SET_T2"></a><dl>
///                  <dt><b>Set_T2</b></dt> <dt>0x00000020</dt> </dl> </td> <td width="60%"> Sets the T2 time value. </td> </tr> <tr>
///                  <td width="40%"><a id="Set_PreferredLifetimeIATA"></a><a id="set_preferredlifetimeiata"></a><a
///                  id="SET_PREFERREDLIFETIMEIATA"></a><dl> <dt><b>Set_PreferredLifetimeIATA</b></dt> <dt>0x00000040</dt> </dl> </td>
///                  <td width="60%"> Not used. </td> </tr> <tr> <td width="40%"><a id="Set_ValidLifetimeIATA"></a><a
///                  id="set_validlifetimeiata"></a><a id="SET_VALIDLIFETIMEIATA"></a><dl> <dt><b>Set_ValidLifetimeIATA</b></dt>
///                  <dt>0x00000080</dt> </dl> </td> <td width="60%"> Not used. </td> </tr> <tr> <td width="40%"><a
///                  id="Set_AuditLogState"></a><a id="set_auditlogstate"></a><a id="SET_AUDITLOGSTATE"></a><dl>
///                  <dt><b>Set_AuditLogState</b></dt> <dt>0x00000800</dt> </dl> </td> <td width="60%"> Sets the audit log state in
///                  the registry. </td> </tr> </table>
///    ConfigInfo = Pointer to a DHCP_SERVER_CONFIG_INFO_V6 structure that contains configuration information of the type indicated
///                 by the value supplied in <i>FieldsToSet</i>.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpServerSetConfigV6(const(PWSTR) ServerIpAddress, DHCP_OPTION_SCOPE_INFO6* ScopeInfo, uint FieldsToSet, 
                           DHCP_SERVER_CONFIG_INFO_V6* ConfigInfo);

///The <b>DhcpSetSubnetInfoV6</b> function sets or updates the information for an IPv6 subnet defined on the DHCPv6
///server.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    SubnetAddress = DHCP_IPV6_ADDRESS structure that contains the IPv6 address of the subnet for which the information will be
///                    modified.
///    SubnetInfo = Pointer to a DHCP_SUBNET_INFO_V6 structure that contains the new or updated information for the IPv6 subnet
///                 identified by <i>SubnetAddress</i>.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl>
///    </td> <td width="60%"> The specified subnet is not defined on the DHCP server. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpSetSubnetInfoV6(const(PWSTR) ServerIpAddress, DHCP_IPV6_ADDRESS SubnetAddress, 
                         DHCP_SUBNET_INFO_V6* SubnetInfo);

///The <b>DhcpGetMibInfoV6</b> function retrieves the IPv6 counter values of the DHCP server.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCPv6 server.
///    MibInfo = Pointed to a DHCP_MIB_INFO_V6 structure that points to the location containing the IPv6 MIB information about the
///              DHCP server. <div class="alert"><b>Note</b> <p class="note">The memory for this parameter must be free using
///              DhcpRpcFreeMemory. </div> <div> </div>
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One of the parameters provides an invalid value. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpGetMibInfoV6(const(PWSTR) ServerIpAddress, DHCP_MIB_INFO_V6** MibInfo);

///The <b>DhcpGetServerBindingInfoV6</b> function retrieves an array of IPv6 interface binding information specific to
///the DHCPv6 server.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    Flags = This parameter is not used, and must be set to 0.
///    BindElementsInfo = Pointer to the address of a DHCPV6_BIND_ELEMENT_ARRAY structure that contains the information about the IPv6
///                       interface bindings for the DHCPv6 server.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpGetServerBindingInfoV6(const(PWSTR) ServerIpAddress, uint Flags, 
                                DHCPV6_BIND_ELEMENT_ARRAY** BindElementsInfo);

///The <b>DhcpSetServerBindingInfoV6</b> function sets or modifies the IPv6 interface bindings for the DHCPv6 server.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    Flags = This parameter is not used and must be set to 0.
///    BindElementInfo = Pointer to a DHCPV6_BIND_ELEMENT_ARRAY structure that contains the IPv6 interface bindings for the DHCPv6 server.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_NETWORK_CHANGED</b></dt> </dl> </td>
///    <td width="60%"> The network has changed. Retry this operation after checking for network changes. Network
///    changes can be caused by interfaces that are either new or no longer valid, or by IPv6 addresses that are either
///    new or no longer valid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_CANNOT_MODIFY_BINDING</b></dt>
///    </dl> </td> <td width="60%"> The supplied bindings to internal IPv6 addresses cannot be modified. </td> </tr>
///    </table>
///    
@DllImport("DHCPSAPI")
uint DhcpSetServerBindingInfoV6(const(PWSTR) ServerIpAddress, uint Flags, 
                                DHCPV6_BIND_ELEMENT_ARRAY* BindElementInfo);

///The <b>DhcpSetClientInfoV6</b> function sets or modifies the reserved DHCPv6 client lease record in the DHCPv6 server
///database.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    ClientInfo = Pointer to a DHCP_CLIENT_INFO_V6 structure that contains the updated DHCPv6 client leaser record information.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpSetClientInfoV6(const(PWSTR) ServerIpAddress, const(DHCP_CLIENT_INFO_V6)* ClientInfo);

///The <b>DhcpGetClientInfoV6</b> function retrieves IPv6 address lease information for a specific IPv6 client
///reservation from the DHCPv6 server.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    SearchInfo = Pointer to a DHCP_SEARCH_INFO_V6 structure that contains the search parameters for finding the specific IPv6
///                 lease information for a client. The <b>SearchType</b> member of this structure must be set to
///                 <b>Dhcpv6ClientIpAddress</b>.
///    ClientInfo = Pointer to the address of a DHCP_CLIENT_INFO_V6 structure that contains the IPv6 address lease information that
///                 matched the parameters supplied in <i>SearchInfo</i>. <div class="alert"><b>Note</b> <p class="note">The memory
///                 for this parameter must be free using DhcpRpcFreeMemory. </div> <div> </div>
@DllImport("DHCPSAPI")
uint DhcpGetClientInfoV6(const(PWSTR) ServerIpAddress, const(DHCP_SEARCH_INFO_V6)* SearchInfo, 
                         DHCP_CLIENT_INFO_V6** ClientInfo);

///The <b>DhcpDeleteClientInfoV6</b> function deletes the specified DHCPv6 client address release record from the DHCPv6
///server database.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    ClientInfo = Pointer to a DHCP_SEARCH_INFO_V6 structure that contains the key used to search for the DHCPv6 client lease
///                 record that will be deleted.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. Commonly returned error codes include: <table> <tr> <th>Return code</th>
///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td
///    width="60%"> This call was performed by a client who is not a member of the "DHCP Administrators" security group.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error
///    occurred while accessing the DHCP server's database. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_RESERVEDIP_EXISTS</b></dt> </dl> </td> <td width="60%"> The specified client lease is a
///    reservation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The <b>SearchType</b> member of DHCP_SEARCH_INFO_V6 was not set to <b>Dhcpv6ClientIpAddress</b>.
///    </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpDeleteClientInfoV6(const(PWSTR) ServerIpAddress, const(DHCP_SEARCH_INFO_V6)* ClientInfo);

///The <b>DhcpCreateClassV6</b> function creates a custom DHCPv6 option class.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    ReservedMustBeZero = Reserved. This field must be set to zero.
///    ClassInfo = DHCP_CLASS_INFO_V6 structure that contains the specific option class data.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_CLASS_ALREADY_EXISTS</b></dt> </dl>
///    </td> <td width="60%"> The specified class name is already defined on the DHCP server, or the class information
///    is already in use. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpCreateClassV6(PWSTR ServerIpAddress, uint ReservedMustBeZero, DHCP_CLASS_INFO_V6* ClassInfo);

///The <b>DhcpModifyClassV6</b> function modifies a DHCPv6 user or vendor class defined on the server.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    ReservedMustBeZero = Reserved. This value must be set to 0.
///    ClassInfo = Pointer to a DHCP_CLASS_INFO_V6 structure that contains the new information for the class.
@DllImport("DHCPSAPI")
uint DhcpModifyClassV6(PWSTR ServerIpAddress, uint ReservedMustBeZero, DHCP_CLASS_INFO_V6* ClassInfo);

///The <b>DhcpDeleteClassV6</b> function deletes a DHCP class from the DHCPv6 server.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that contains the IPv6 address of the DHCPv6 server. This string is used as a handle
///                      for resolving RPC API calls.
///    ReservedMustBeZero = Reserved. This parameter must be set to 0.
///    ClassName = Unicode string that specifies the name of the DHCPv6 class to delete.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_CLASS_NOT_FOUND</b></dt> </dl> </td>
///    <td width="60%"> The class name could not be found in the database. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_DELETE_BUILTIN_CLASS</b></dt> </dl> </td> <td width="60%"> The class is a built-in class and
///    cannot be deleted. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpDeleteClassV6(PWSTR ServerIpAddress, uint ReservedMustBeZero, PWSTR ClassName);

///The <b>DhcpEnumClassesV6</b> function enumerates the user or vendor classes configured for the DHCPv6 server.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCPv6 server.
///    ReservedMustBeZero = Reserved. This field must be set to zero.
///    ResumeHandle = Pointer to a DHCP_RESUME_HANDLE value that identifies the enumeration operation. Initially, this value should be
///                   zero, with a successful call returning the handle value used for subsequent enumeration requests. For example, if
///                   <i>PreferredMaximum</i> is set to 100 classes, and 200 classes are stored on the server, the resume handle can be
///                   used after the first 100 classes are retrieved to obtain the next 100 on a subsequent call, and so forth.
///    PreferredMaximum = Specifies the preferred maximum number of classes to return. If the number of remaining unenumerated classes is
///                       less than this value, then that amount will be returned. To retrieve all classes available on the DHCPv6 server,
///                       set this parameter to 0xFFFFFFFF.
///    ClassInfoArray = Pointer to a DHCP_CLASS_INFO_ARRAY_V6 structure that contains the returned classes. If there are no classes
///                     available on the DHCP server, this parameter will return null.
///    nRead = Pointer to a DWORD value that specifies the number of classes returned in <i>ClassInfoArray</i>.
///    nTotal = Pointer to a DWORD value that specifies the total number of classes stored on the DHCP server.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpEnumClassesV6(PWSTR ServerIpAddress, uint ReservedMustBeZero, uint* ResumeHandle, uint PreferredMaximum, 
                       DHCP_CLASS_INFO_ARRAY_V6** ClassInfoArray, uint* nRead, uint* nTotal);

///The <b>DhcpSetSubnetDelayOffer</b> function sets the delay period for DHCP OFFER messages after a DISCOVER message is
///received, for a specific DHCP scope.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    SubnetAddress = <b>DHCP_IP_ADDRESS</b> value that contains the IP address of the subnet gateway.
///    TimeDelayInMilliseconds = Unsigned 16-bit integer value that specifies the time to delay an OFFER message after receiving a DISCOVER
///                              message, in milliseconds, and set for a particular scope. This value must be between 0 and 1000 (milliseconds).
///                              The default value is 0.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl> </td> <td width="60%"> The specified subnet is not defined on
///    the DHCP server. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_INVALID_DELAY</b></dt> </dl> </td> <td
///    width="60%"> The time delay was set to a value less than 0 or greater than 1000. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One of the parameters
///    provides an invalid value. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpSetSubnetDelayOffer(PWSTR ServerIpAddress, uint SubnetAddress, ushort TimeDelayInMilliseconds);

///The <b>DhcpGetSubnetDelayOffer</b> function obtains the delay period for DHCP OFFER messages after a DISCOVER message
///is received.
///Params:
///    ServerIpAddress = Unicode string that specifies the IP address or hostname of the DHCP server.
///    SubnetAddress = DHCP_IP_ADDRESS value that contains the IP address of the subnet gateway.
///    TimeDelayInMilliseconds = Unsigned 16-bit integer value that receive the time to delay an OFFER message after receiving a DISCOVER message
///                              as configured on the DHCP server, in milliseconds. <div class="alert"><b>Note</b> <p class="note">The memory for
///                              this parameter must be free using DhcpRpcFreeMemory. </div> <div> </div>
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl> </td> <td width="60%"> The specified subnet is not defined on
///    the DHCP server. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One of the parameters provides an invalid value. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpGetSubnetDelayOffer(PWSTR ServerIpAddress, uint SubnetAddress, ushort* TimeDelayInMilliseconds);

///The <b>DhcpGetMibInfoV5</b> function obtains a MIB data structure that contains current statistics about the
///specified DHCP server.
///Params:
///    ServerIpAddress = Pointer to a zero-delimited string that contains the IPv4 address of the DHCP server for which statistical
///                      information is to be retrieved. This value is specified in the format "*.*.*.*". If this parameter is
///                      <b>NULL</b>, then the local DHCP server process is queried.
///    MibInfo = Pointer to the address of a DHCP_MIB_INFO_V5 structure that contains statistical information about the DHCP
///              server specified in the <i>ServerIpAddress</i> parameter. <div class="alert"><b>Note</b> <p class="note">The
///              memory for this parameter must be free using DhcpRpcFreeMemory. </div> <div> </div>
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client who is
///    not a member of the "DHCP Administrators" security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error occurred while accessing the DHCP
///    server's database. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One of the parameters provides an invalid value. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpGetMibInfoV5(const(PWSTR) ServerIpAddress, DHCP_MIB_INFO_V5** MibInfo);

@DllImport("DHCPSAPI")
uint DhcpAddSecurityGroup(PWSTR pServer);

///The <b>DhcpV4GetOptionValue</b> function retrieves a DHCP option value (the option code and associated data) for a
///particular scope. This function extends the functionality provided by DhcpGetOptionValueV5 by allowing the caller to
///specify a policy for the option.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    Flags = Indicates whether the option is for a specific or default vendor. <table> <tr> <th>Flags</th> <th>Meaning</th>
///            </tr> <tr> <td width="40%"><a id=""></a><dl> <dt><b></b></dt> <dt>0x00000000</dt> </dl> </td> <td width="60%">
///            The option value is retrieved for a default vendor. </td> </tr> <tr> <td width="40%"><a
///            id="DHCP_FLAGS_OPTION_IS_VENDOR"></a><a id="dhcp_flags_option_is_vendor"></a><dl>
///            <dt><b>DHCP_FLAGS_OPTION_IS_VENDOR</b></dt> <dt>0x00000003</dt> </dl> </td> <td width="60%"> The option value is
///            retrieved for a specific vendor. The vendor is in <i>VendorName</i>. </td> </tr> </table>
///    OptionID = DHCP_OPTION_ID structure that specifies the unique option code for the option value to retrieve. A complete list
///               of standard DHCP and BOOTP option codes can be found at http://www.ietf.org/rfc/rfc2132.txt
///    PolicyName = A null-terminated Unicode string that represents the name of the policy inside the subnet of the option value to
///                 retrieve. The subnet is identified by the <b>SubnetScopeInfo</b> member of <i>ScopeInfo</i>.
///    VendorName = A null-terminated Unicode string that represents the vendor of the option. This parameter is optional, and should
///                 be <b>NULL</b> when <i>Flags</i> is not <b>DHCP_FLAGS_OPTION_IS_VENDOR</b>. If the vendor is not specified, the
///                 option value is returned for the default vendor.
///    ScopeInfo = DHCP_OPTION_SCOPE_INFO structure that contains information on the scope of the option value to retrieve.
///    OptionValue = Pointer to a DHCP_OPTION_DATA structure that contains the data value corresponding to the DHCP option code
///                  specified by <i>OptionID</i>.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt>
///    </dl> </td> <td width="60%"> The specified IPv4 subnet does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_CLASS_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The class name being used is unknown or
///    incorrect. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_POLICY_NOT_FOUND</b></dt> </dl> </td> <td
///    width="60%"> The specified policy name does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_OPTION_NOT_PRESENT</b></dt> </dl> </td> <td width="60%"> The specified option definition does
///    not exist on the DHCP server database. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4GetOptionValue(PWSTR ServerIpAddress, uint Flags, uint OptionID, PWSTR PolicyName, PWSTR VendorName, 
                          DHCP_OPTION_SCOPE_INFO* ScopeInfo, DHCP_OPTION_VALUE** OptionValue);

///The <b>DhcpV4SetOptionValue</b> function sets information for a specific option value on the DHCP server. This
///function extends the functionality provided by DhcpSetOptionValueV5 by allowing the caller to specify a policy for
///the option.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    Flags = Indicates whether the option is for a specific or default vendor. <table> <tr> <th>Flags</th> <th>Meaning</th>
///            </tr> <tr> <td width="40%"><a id=""></a><dl> <dt><b></b></dt> <dt>0x00000000</dt> </dl> </td> <td width="60%">
///            The option value is retrieved for a default vendor. </td> </tr> <tr> <td width="40%"><a
///            id="DHCP_FLAGS_OPTION_IS_VENDOR"></a><a id="dhcp_flags_option_is_vendor"></a><dl>
///            <dt><b>DHCP_FLAGS_OPTION_IS_VENDOR</b></dt> <dt>0x00000003</dt> </dl> </td> <td width="60%"> The option value is
///            retrieved for a specific vendor. The vendor is in <i>VendorName</i>. </td> </tr> </table>
///    OptionId = DHCP_OPTION_ID structure that specifies the unique option code for the option value to retrieve. A complete list
///               of standard DHCP and BOOTP option codes can be found at http://www.ietf.org/rfc/rfc2132.txt
///    PolicyName = A null-terminated Unicode string that represents the name of the policy inside the subnet of the option value to
///                 set. The subnet is identified by the <b>SubnetScopeInfo</b> member of <i>ScopeInfo</i>.
///    VendorName = A null-terminated Unicode string that represents the vendor of the option. This parameter is optional, and should
///                 be <b>NULL</b> when <i>Flags</i> is not <b>DHCP_FLAGS_OPTION_IS_VENDOR</b>. If the vendor is not specified, the
///                 option value is set for the default vendor.
///    ScopeInfo = Pointer to a DHCP_OPTION_SCOPE_INFO structure that contains information on the scope of the option value to set.
///    OptionValue = Pointer to a DHCP_OPTION_DATA structure that contains the data value corresponding to the DHCP option code
///                  specified by <i>OptionID</i>.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt>
///    </dl> </td> <td width="60%"> The specified IPv4 subnet does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_CLASS_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The class name being used is unknown or
///    incorrect. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_POLICY_NOT_FOUND</b></dt> </dl> </td> <td
///    width="60%"> The specified policy name does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_OPTION_NOT_PRESENT</b></dt> </dl> </td> <td width="60%"> The specified option definition does
///    not exist on the DHCP server database. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4SetOptionValue(PWSTR ServerIpAddress, uint Flags, uint OptionId, PWSTR PolicyName, PWSTR VendorName, 
                          DHCP_OPTION_SCOPE_INFO* ScopeInfo, DHCP_OPTION_DATA* OptionValue);

///The <b>DhcpV4SetOptionValues</b> function sets option codes and their associated data values for a specific scope
///defined on the DHCP server. This function extends the functionality provided by DhcpSetOptionValuesV5 by allowing the
///caller to specify a policy for the options.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    Flags = Reserved. Must be 0.
///    PolicyName = A null-terminated Unicode string that represents the name of the policy inside the subnet of the option value to
///                 set. The subnet is identified by the <b>SubnetScopeInfo</b> member of <i>ScopeInfo</i>.
///    VendorName = A null-terminated Unicode string that represents the vendor of the option. This parameter is optional, and if
///                 <b>NULL</b>, the option value is set for the default vendor.
///    ScopeInfo = Pointer to a DHCP_OPTION_SCOPE_INFO structure that contains information describing the DHCP scope of the option
///                values to set. This parameter specifies whether the option value is set for the default, server, or scope level,
///                or for an IPv4 reservation.
///    OptionValues = Pointer to a DHCP_OPTION_VALUE_ARRAY structure that contains a list of option codes and the corresponding data
///                   value that will be set.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt>
///    </dl> </td> <td width="60%"> The specified IPv4 subnet does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_CLASS_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The class name being used is unknown or
///    incorrect. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_POLICY_NOT_FOUND</b></dt> </dl> </td> <td
///    width="60%"> The specified policy name does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_OPTION_NOT_PRESENT</b></dt> </dl> </td> <td width="60%"> The specified option definition does
///    not exist on the DHCP server database. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_NOT_RESERVED_CLIENT</b></dt> </dl> </td> <td width="60%"> The specified DHCP client is not a
///    reserved client. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4SetOptionValues(PWSTR ServerIpAddress, uint Flags, PWSTR PolicyName, PWSTR VendorName, 
                           DHCP_OPTION_SCOPE_INFO* ScopeInfo, DHCP_OPTION_VALUE_ARRAY* OptionValues);

///The <b>DhcpV4RemoveOptionValue</b> function removes an option value from a scope defined on the DHCP server. This
///function extends the functionality provided by DhcpRemoveOptionValueV5 by allowing the caller to specify a policy for
///the option.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    Flags = Indicates whether the option value is for a specific or default vendor. <table> <tr> <th>Flags</th>
///            <th>Meaning</th> </tr> <tr> <td width="40%"><a id=""></a><dl> <dt><b></b></dt> <dt>0x00000000</dt> </dl> </td>
///            <td width="60%"> The option value is removed for a default vendor. </td> </tr> <tr> <td width="40%"><a
///            id="DHCP_FLAGS_OPTION_IS_VENDOR"></a><a id="dhcp_flags_option_is_vendor"></a><dl>
///            <dt><b>DHCP_FLAGS_OPTION_IS_VENDOR</b></dt> <dt>0x00000003</dt> </dl> </td> <td width="60%"> The option value is
///            removed for a specific vendor. The vendor is in <i>VendorName</i>. </td> </tr> </table>
///    OptionID = DHCP_OPTION_ID structure that specifies the option code for the option value to remove. A complete list of
///               standard DHCP and BOOTP option codes can be found at http://www.ietf.org/rfc/rfc2132.txt
///    PolicyName = A null-terminated Unicode string that represents the name of the policy inside the subnet of the option value to
///                 remove. The subnet is identified by the <b>SubnetScopeInfo</b> member of <i>ScopeInfo</i>.
///    VendorName = A null-terminated Unicode string that represents the vendor of the option. This parameter is optional, and should
///                 be <b>NULL</b> when <i>Flags</i> is not <b>DHCP_FLAGS_OPTION_IS_VENDOR</b>. If the vendor is not specified, the
///                 option value is set for the default vendor.
///    ScopeInfo = Pointer to a DHCP_OPTION_SCOPE_INFO structure that contains information on the scope of the option value to
///                remove
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_CLASS_NOT_FOUND</b></dt>
///    </dl> </td> <td width="60%"> The class name being used is unknown or incorrect. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DHCP_POLICY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified policy name does not
///    exist. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_OPTION_NOT_PRESENT</b></dt> </dl> </td> <td
///    width="60%"> The specified option definition does not exist on the DHCP server database or there is no value set
///    for the specified option ID on the specified policy. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl> </td> <td width="60%"> The specified IPv4 subnet does not
///    exist. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4RemoveOptionValue(PWSTR ServerIpAddress, uint Flags, uint OptionID, PWSTR PolicyName, PWSTR VendorName, 
                             DHCP_OPTION_SCOPE_INFO* ScopeInfo);

///The <b>DhcpV4GetAllOptionValues</b> function retrieves an array of DHCP option values (the option code and associated
///data) for a particular scope.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    Flags = Indicates whether the option values are for a specific or default vendor. <table> <tr> <th>Flags</th>
///            <th>Meaning</th> </tr> <tr> <td width="40%"><a id=""></a><dl> <dt><b></b></dt> <dt>0x00000000</dt> </dl> </td>
///            <td width="60%"> The option values are retrieved for a default vendor. </td> </tr> <tr> <td width="40%"><a
///            id="DHCP_FLAGS_OPTION_IS_VENDOR"></a><a id="dhcp_flags_option_is_vendor"></a><dl>
///            <dt><b>DHCP_FLAGS_OPTION_IS_VENDOR</b></dt> <dt>0x00000003</dt> </dl> </td> <td width="60%"> The option values
///            are retrieved for specific vendors. </td> </tr> </table>
///    ScopeInfo = A pointer to a DHCP_OPTION_SCOPE_INFO structure that contains information on the scope of the option values to
///                retrieve.
///    Values = Pointer to a DHCP_ALL_OPTION_VALUES_PB structure that contains the retrieved option values for the scope
///             specified in <i>ScopeInfo</i>. There is one option value in the array for each vendor/policy pair defined on the
///             DHCP server.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4GetAllOptionValues(PWSTR ServerIpAddress, uint Flags, DHCP_OPTION_SCOPE_INFO* ScopeInfo, 
                              DHCP_ALL_OPTION_VALUES_PB** Values);

///The <b>DhcpV4FailoverCreateRelationship</b> function creates a new DHCPv4 failover relationship between two servers.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    pRelationship = Pointer to a DHCP_FAILOVER_RELATIONSHIP structure that contains information about the DHCPv4 failover
///                    relationship to create.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt>
///    </dl> </td> <td width="60%"> IPv4 scope doesn't exist on the DHCPv4 server. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DHCP_FO_SCOPE_ALREADY_IN_RELATIONSHIP</b></dt> </dl> </td> <td width="60%"> IPv4 is already
///    part of another failover relationship. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_FO_RELATIONSHIP_EXISTS</b></dt> </dl> </td> <td width="60%"> A failover relationship with the
///    same name already exists on DHCPv4 server. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_FO_RELATIONSHIP_NAME_TOO_LONG</b></dt> </dl> </td> <td width="60%"> The failover relationship
///    name is longer than the expected length. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_FO_MAX_RELATIONSHIPS</b></dt> </dl> </td> <td width="60%"> The maximum number of allowed
///    failover relationship configured on the DHCP server has exceeded. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4FailoverCreateRelationship(PWSTR ServerIpAddress, DHCP_FAILOVER_RELATIONSHIP* pRelationship);

///The <b>DhcpV4FailoverSetRelationship</b> function sets or modifies the parameters of a DHCPv4 server failover
///relationship.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    Flags = A bitmask that specifies the fields to update in <i>pRelationship</i>. Each value specifies a member of the
///            DHCP_FAILOVER_RELATIONSHIP structure to be modified. <table> <tr> <th>Flag</th> <th>Meaning</th> </tr> <tr> <td
///            width="40%"><a id="MCLT"></a><a id="mclt"></a><dl> <dt><b>MCLT</b></dt> <dt>0x00000001</dt> </dl> </td> <td
///            width="60%"> The <b>mclt</b> member in <i>pRelationship</i> parameter structure is populated. </td> </tr> <tr>
///            <td width="40%"><a id="SAFEPERIOD"></a><a id="safeperiod"></a><dl> <dt><b>SAFEPERIOD</b></dt> <dt>0x00000002</dt>
///            </dl> </td> <td width="60%"> The <b>safePeriod</b> member in <i>pRelationship</i> parameter structure is
///            populated. </td> </tr> <tr> <td width="40%"><a id="CHANGESTATE"></a><a id="changestate"></a><dl>
///            <dt><b>CHANGESTATE</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%"> The <b>state</b> member in
///            <i>pRelationship</i> parameter structure is populated. </td> </tr> <tr> <td width="40%"><a id="PERCENTAGE"></a><a
///            id="percentage"></a><dl> <dt><b>PERCENTAGE</b></dt> <dt>0x00000008</dt> </dl> </td> <td width="60%"> The
///            <b>percentage</b> member in <i>pRelationship</i> parameter structure is populated. </td> </tr> <tr> <td
///            width="40%"><a id="MODE"></a><a id="mode"></a><dl> <dt><b>MODE</b></dt> <dt>0x00000010</dt> </dl> </td> <td
///            width="60%"> The <b>mode</b> member in <i>pRelationship</i> parameter structure is populated. </td> </tr> <tr>
///            <td width="40%"><a id="PREVSTATE"></a><a id="prevstate"></a><dl> <dt><b>PREVSTATE</b></dt> <dt>0x00000020</dt>
///            </dl> </td> <td width="60%"> The <b>prevState</b> member in <i>pRelationship</i> parameter structure is
///            populated. </td> </tr> </table>
///    pRelationship = Pointer to a DHCP_FAILOVER_RELATIONSHIP structure that contains update information about the fields in the DHCPv4
///                    failover relationship.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_FO_RELATIONSHIP_DOES_NOT_EXIST</b></dt> </dl> </td> <td width="60%"> The failover relationship
///    doesn’t exist. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4FailoverSetRelationship(PWSTR ServerIpAddress, uint Flags, DHCP_FAILOVER_RELATIONSHIP* pRelationship);

///The <b>DhcpV4FailoverDeleteRelationship</b> function deletes a DHCPv4 failover relationship between two servers.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    pRelationshipName = Pointer to null-terminated Unicode string that represents the name of the relationship to delete.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_FO_RELATIONSHIP_DOES_NOT_EXIST</b></dt> </dl> </td> <td width="60%"> The failover relationship
///    doesn't exist. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4FailoverDeleteRelationship(PWSTR ServerIpAddress, PWSTR pRelationshipName);

///The <b>DhcpV4FailoverGetRelationship</b> function retrieves relationship details for a specific relationship name.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    pRelationshipName = Pointer to a null-terminated Unicode string which represents the name of the relationship to retrieve.
///    pRelationship = Pointer to a DHCP_FAILOVER_RELATIONSHIP structure that contains information about the retrieved failover
///                    relationship. <div class="alert"><b>Note</b> <p class="note">The memory for this parameter must be free using
///                    DhcpRpcFreeMemory. </div> <div> </div>
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_FO_RELATIONSHIP_DOES_NOT_EXIST</b></dt> </dl> </td> <td width="60%"> The failover relationship
///    does not exist. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4FailoverGetRelationship(PWSTR ServerIpAddress, PWSTR pRelationshipName, 
                                   DHCP_FAILOVER_RELATIONSHIP** pRelationship);

///The <b>DhcpV4FailoverEnumRelationship</b> function enumerates all failover relationships present on the server.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    ResumeHandle = Pointer to a DHCP_RESUME_HANDLE structure that identifies this enumeration for use in subsequent calls to this
///                   function. Initially, this value should be zero on input. If successful, the returned value should be used for
///                   subsequent enumeration requests. For example, if <i>PreferredMaximum</i> is set to 100, and 200 reservation
///                   elements are configured on the server, the resume handle can be used after the first 100 policies are retrieved
///                   to obtain the next 100 on a subsequent call.
///    PreferredMaximum = The maximum number of failover relationship elements to return in <i>pRelationship</i>. If
///                       <i>PreferredMaximum</i> is greater than the number of remaining non-enumerated policies on the server, the
///                       remaining number of non-enumerated policies is returned.
///    pRelationship = Pointer to a DHCP_FAILOVER_RELATIONSHIP_ARRAY structure that contains an array of the failover relationships
///                    available on the DHCP server. If no relationships are configured,<i></i> this value is <b>NULL</b>.
///    RelationshipRead = Pointer to a <b>DWORD</b> that specifies the number of failover relationship elements returned in
///                       <i>pRelationship</i>.
///    RelationshipTotal = Pointer to a <b>DWORD</b> that specifies the number of failover relationships configured on the DHCP server that
///                        have not yet been enumerated.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the
///    following. or an error code from DHCP Server Management API Error Codes <table> <tr> <th>Value</th>
///    <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or more of the parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> There are more elements available to enumerate.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td width="60%"> There are
///    no more elements left to enumerate. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4FailoverEnumRelationship(PWSTR ServerIpAddress, uint* ResumeHandle, uint PreferredMaximum, 
                                    DHCP_FAILOVER_RELATIONSHIP_ARRAY** pRelationship, uint* RelationshipRead, 
                                    uint* RelationshipTotal);

///The <b>DhcpV4FailoverAddScopeToRelationship</b> function adds a DHCPv4 scope to the specified failover relationship.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    pRelationship = Pointer to a DHCP_FAILOVER_RELATIONSHIP structure that contains both the scope information to add and the
///                    failover relationship to modify.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt>
///    </dl> </td> <td width="60%"> IPv4 scope doesn't exist on the DHCPv4 server. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DHCP_FO_SCOPE_ALREADY_IN_RELATIONSHIP</b></dt> </dl> </td> <td width="60%"> IPv4 scope is
///    already part of another failover relationship. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_FO_RELATIONSHIP_DOES_NOT_EXIST</b></dt> </dl> </td> <td width="60%"> Failover relationship
///    doesn't exist. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_FO_MAX_ADD_SCOPES</b></dt> </dl> </td>
///    <td width="60%"> Number of scopes being added to the failover relationship exceeds the max number of scopes which
///    can be added to a failover relationship at one time. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4FailoverAddScopeToRelationship(PWSTR ServerIpAddress, DHCP_FAILOVER_RELATIONSHIP* pRelationship);

///The <b>DhcpV4FailoverDeleteScopeFromRelationship</b> function deletes a DHCPv4 scope from the specified failover
///relationship.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    pRelationship = Pointer to a DHCP_FAILOVER_RELATIONSHIP structure that contains the scopes to delete. The scopes are defined in
///                    the <b>pScopes</b> member of this structure.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt>
///    </dl> </td> <td width="60%"> IPv4 scope doesn't exist on the DHCPv4 server. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DHCP_FO_RELATIONSHIP_DOES_NOT_EXIST</b></dt> </dl> </td> <td width="60%"> Failover relationship
///    doesn't exist. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_FO_SCOPE_NOT_IN_RELATIONSHIP</b></dt>
///    </dl> </td> <td width="60%"> IPv4 subnet is not part of the failover relationship. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4FailoverDeleteScopeFromRelationship(PWSTR ServerIpAddress, DHCP_FAILOVER_RELATIONSHIP* pRelationship);

///The <b>DhcpV4FailoverGetScopeRelationship</b> function retrieves the failover relationship that is configured on a
///specified DHCPv4 scope.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    ScopeId = A <b>DHCP_IP_ADDRESS</b> field that contains the IPv4 scope address for which the relationship details are to be
///              retrieved.
///    pRelationship = Pointer to a DHCP_FAILOVER_RELATIONSHIP structure that contains information about the retrieved failover
///                    relationship which contains <b>scopeId</b> field in its <b>pScopes</b> member. <div class="alert"><b>Note</b> <p
///                    class="note">The memory for this parameter must be free using DhcpRpcFreeMemory. </div> <div> </div>
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_FO_SCOPE_NOT_IN_RELATIONSHIP</b></dt> </dl> </td> <td width="60%"> IPv4 subnet is not part of
///    the failover relationship. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4FailoverGetScopeRelationship(PWSTR ServerIpAddress, uint ScopeId, 
                                        DHCP_FAILOVER_RELATIONSHIP** pRelationship);

///The <b>DhcpV4FailoverGetScopeStatistics</b> function retrieves the address usage statistics of a specific scope that
///is part of a failover relationship.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    ScopeId = DHCP_IP_ADDRESS structure that contains the IPv4 scope address of the address usage statistics to retrieve.
///    pStats = Pointer to a DHCP_FAILOVER_STATISTICS structure that contains the address usage information for <i>scopeId</i>.
///             <div class="alert"><b>Note</b> <p class="note">The memory for this parameter must be free using
///             DhcpRpcFreeMemory. </div> <div> </div>
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4FailoverGetScopeStatistics(PWSTR ServerIpAddress, uint ScopeId, DHCP_FAILOVER_STATISTICS** pStats);

///The <b>DhcpV4FailoverGetClientInfo</b> function retrieves the DHCPv4 client lease information.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    SearchInfo = Pointer to a DHCP_SEARCH_INFO structure that defines the key used to search the DHCPv4 client lease record on the
///                 server. If the <b>SearchType</b> member of <i>SearchInfo</i> is <b>DhcpClientName</b> and there are multiple
///                 lease records with the same client name, the server will return client information for the client with the lowest
///                 numerical IP address.
///    ClientInfo = Pointer to a DHCPV4_FAILOVER_CLIENT_INFO structure that contains the retrieved DHCPv4 client lease record. <div
///                 class="alert"><b>Note</b> <p class="note">The memory for this parameter must be free using DhcpRpcFreeMemory.
///                 </div> <div> </div>
@DllImport("DHCPSAPI")
uint DhcpV4FailoverGetClientInfo(PWSTR ServerIpAddress, const(DHCP_SEARCH_INFO)* SearchInfo, 
                                 DHCPV4_FAILOVER_CLIENT_INFO** ClientInfo);

///The <b>DhcpV4FailoverGetSystemTime</b> function returns the current time on the DHCP server.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    pTime = Pointer to a <b>DWORD</b> that returns the current time, in seconds, elapsed since midnight, January 1, 1970,
///            Coordinated Universal Time (UTC), on the DHCP server.
///    pMaxAllowedDeltaTime = The maximum allowed delta time.
@DllImport("DHCPSAPI")
uint DhcpV4FailoverGetSystemTime(PWSTR ServerIpAddress, uint* pTime, uint* pMaxAllowedDeltaTime);

///The <b>DhcpV4FailoverGetAddressStatus</b> function returns the status of a IPv4 address.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    SubnetAddress = DHCP_IP_ADDRESS structure that contains the IPv4 address whose status is being requested.
///    pStatus = Pointer to a DWORD that returns the status of the IPv4 address as specified in the table below: <table> <tr>
///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0</dt> </dl> </td> <td width="60%"> The IPv4
///              address will be leased by a primary server. </td> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td
///              width="60%"> The IPv4 address will be leased by a secondary server. </td> </tr> <tr> <td width="40%"> <dl>
///              <dt>2</dt> </dl> </td> <td width="60%"> The IPv4 address is part of an exclusion range. </td> </tr> <tr> <td
///              width="40%"> <dl> <dt>3</dt> </dl> </td> <td width="60%"> The IPv4 address is a reservation. </td> </tr> </table>
@DllImport("DHCPSAPI")
uint DhcpV4FailoverGetAddressStatus(PWSTR ServerIpAddress, uint SubnetAddress, uint* pStatus);

///The <b>DhcpV4FailoverTriggerAddrAllocation</b> function redistributes the free addresses between the primary server
///and the secondary server that are part of a failover relationship.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    pFailRelName = Pointer to a null-terminated Unicode string that represents the name of the failover relationship for which free
///                   addresses are to be redistributed.
@DllImport("DHCPSAPI")
uint DhcpV4FailoverTriggerAddrAllocation(PWSTR ServerIpAddress, PWSTR pFailRelName);

///The <b>DhcpHlprCreateV4Policy</b> function allocates and initializes a DHCP server policy structure.
///Params:
///    PolicyName = A null-terminated unicode string that contains the name of the DHCP server policy to create.
///    fGlobalPolicy = If <b>TRUE</b> a server level policy is created. Otherwise, a scope level policy is created
///    Subnet = DHCP_IP_ADDRESS structure that contains the IPv4 subnet address of the scope level policy to create.
///    ProcessingOrder = Integer that specifies the processing order of the DHCP server policy. 1 indicates the highest priority and
///                      <b>MAX_DWORD</b> indicates the lowest.
///    RootOperator = DHCP_POL_LOGIC_OPER enumeration that defines how the policy condition is to be evaluated in terms of the results
///                   of its constituents.
///    Description = A pointer to a null-terminated Unicode string that contains the description of the DHCP server policy.
///    Enabled = <b>TRUE</b> if the policy is enabled. Otherwise, it is <b>FALSE</b>.
///    Policy = Pointer to a DHCP_POLICY structure that contains the parameters of the policy to create.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl>
///    </td> <td width="60%"> Not enough memory available. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpHlprCreateV4Policy(PWSTR PolicyName, BOOL fGlobalPolicy, uint Subnet, uint ProcessingOrder, 
                            DHCP_POL_LOGIC_OPER RootOperator, PWSTR Description, BOOL Enabled, DHCP_POLICY** Policy);

@DllImport("DHCPSAPI")
uint DhcpHlprCreateV4PolicyEx(PWSTR PolicyName, BOOL fGlobalPolicy, uint Subnet, uint ProcessingOrder, 
                              DHCP_POL_LOGIC_OPER RootOperator, PWSTR Description, BOOL Enabled, 
                              DHCP_POLICY_EX** Policy);

///The <b>DhcpHlprAddV4PolicyExpr</b> function allocates, initializes, and adds a DHCP server policy expression to a
///DHCP server policy.
///Params:
///    Policy = Pointer to a DHCP_POLICY structure that contains the policy to modify
///    ParentExpr = Integer that specifies the expression index that corresponds to this constituent condition.
///    Operator = A DHCP_POL_LOGIC_OPER enumeration that defines how the expression is to be evaluated in terms of the results of
///               its constituents.
///    ExprIndex = Pointer to a <b>DWORD</b> that contains the newly created expression's index in the DHCP server policy.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl>
///    </td> <td width="60%"> Not enough memory available. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_POLICY_BAD_PARENT_EXPR</b></dt> </dl> </td> <td width="60%"> The parent expression specified
///    does not exist. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpHlprAddV4PolicyExpr(DHCP_POLICY* Policy, uint ParentExpr, DHCP_POL_LOGIC_OPER Operator, uint* ExprIndex);

///The <b>DhcpHlprAddV4PolicyCondition</b> function allocates, initializes, and adds a DHCP server policy condition to a
///DHCP server policy.
///Params:
///    Policy = Pointer to a DHCP_POLICY structure that contains the policy to modify.
///    ParentExpr = Integer that specifies the expression index that corresponds to this constituent condition.
///    Type = DHCP_POL_ATTR_TYPE enumeration that specifies the attribute type for this condition.
///    OptionID = DHCP_OPTION_ID value that specifies the unique option identifier for criteria based on DHCP options or
///               sub-options.
///    SubOptionID = DHCP_OPTION_ID value that specifies the unique sub-option identifier for criteria based on DHCP sub-options.
///    VendorName = A pointer to a null-terminated Unicode string that represents the vendor name.
///    Operator = DHCP_POL_COMPARATOR enumeration that specifies the comparison operator for the condition.
///    Value = Pointer to an array of bytes that contains the value to be used for the comparison.
///    ValueLength = Integer that specifies the length of <b>Value</b>.
///    ConditionIndex = Pointer to a <b>DWORD</b> that contains the newly created condition's index in the DHCP server policy.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl>
///    </td> <td width="60%"> Not enough memory available. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_POLICY_BAD_PARENT_EXPR</b></dt> </dl> </td> <td width="60%"> The parent expression specified
///    does not exist. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpHlprAddV4PolicyCondition(DHCP_POLICY* Policy, uint ParentExpr, DHCP_POL_ATTR_TYPE Type, uint OptionID, 
                                  uint SubOptionID, PWSTR VendorName, DHCP_POL_COMPARATOR Operator, ubyte* Value, 
                                  uint ValueLength, uint* ConditionIndex);

///The <b>DhcpHlprAddV4PolicyRange</b> function adds a DHCP IPv4 range to a DHCP server policy.
///Params:
///    Policy = Pointer to a DHCP_POLICY structure that contains the policy to modify.
///    Range = Pointer to a DHCP_IP_RANGE structure that contains the DHCP IPv4 range to add to the DHCP server policy range
///            array.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl>
///    </td> <td width="60%"> Not enough memory available. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpHlprAddV4PolicyRange(DHCP_POLICY* Policy, DHCP_IP_RANGE* Range);

///The <b>DhcpHlprResetV4PolicyExpr</b> function resets the DHCP server policy expression in a DHCP server policy
///structure.
///Params:
///    Policy = Pointer to DHCP_POLICY structure that contains the policy to reset.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpHlprResetV4PolicyExpr(DHCP_POLICY* Policy);

///The <b>DhcpHlprModifyV4PolicyExpr</b> function modifies the DHCP server policy expression in a DHCP server policy
///structure.
///Params:
///    Policy = Pointer to DHCP_POLICY structure that contains the policy to modify.
///    Operator = A DHCP_POL_LOGIC_OPER enumeration that defines how the policy condition is to be evaluated in terms of the
///               results of its constituents.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpHlprModifyV4PolicyExpr(DHCP_POLICY* Policy, DHCP_POL_LOGIC_OPER Operator);

///The <b>DhcpHlprFreeV4Policy</b> function frees the memory of all the data structures within a DHCP server policy
///structure.
///Params:
///    Policy = Pointer to DHCP_POLICY structure that contains the policy structure to free.
///Returns:
///    This function does not return a value.
///    
@DllImport("DHCPSAPI")
void DhcpHlprFreeV4Policy(DHCP_POLICY* Policy);

@DllImport("DHCPSAPI")
void DhcpHlprFreeV4PolicyArray(DHCP_POLICY_ARRAY* PolicyArray);

@DllImport("DHCPSAPI")
void DhcpHlprFreeV4PolicyEx(DHCP_POLICY_EX* PolicyEx);

@DllImport("DHCPSAPI")
void DhcpHlprFreeV4PolicyExArray(DHCP_POLICY_EX_ARRAY* PolicyExArray);

@DllImport("DHCPSAPI")
void DhcpHlprFreeV4DhcpProperty(DHCP_PROPERTY* Property);

@DllImport("DHCPSAPI")
void DhcpHlprFreeV4DhcpPropertyArray(DHCP_PROPERTY_ARRAY* PropertyArray);

@DllImport("DHCPSAPI")
DHCP_PROPERTY* DhcpHlprFindV4DhcpProperty(DHCP_PROPERTY_ARRAY* PropertyArray, DHCP_PROPERTY_ID ID, 
                                          DHCP_PROPERTY_TYPE Type);

///The <b>DhcpHlprIsV4PolicySingleUC</b> function verifies that a DHCP server policy is based on a single user class.
///Params:
///    Policy = Pointer to a DHCP_POLICY structure that contains the policy to verify.
///Returns:
///    The API returns <b>TRUE</b> if there is a single condition associated with the specified policy. This condition
///    should be based on one of the user classes defined on the DHCP server. Otherwise, it returns <b>FALSE</b>.
///    
@DllImport("DHCPSAPI")
BOOL DhcpHlprIsV4PolicySingleUC(DHCP_POLICY* Policy);

///The <b>DhcpV4QueryPolicyEnforcement</b> function retrieves the policy enforcement state on the server or the
///specified IPv4 subnet from the DHCP Server.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    fGlobalPolicy = If <b>TRUE</b> the policy enforcement state of the server is retrieved. Otherwise, the policy enforcement state
///                    of specified Ipv4 scope is retrieved.
///    SubnetAddress = DHCP_IP_ADDRESS structure that contains the IPv4 subnet address of the policy enforcement state to retrieve.
///    Enabled = Pointer to a <b>BOOL</b> that indicates the state of policy enforcement. If <b>TRUE</b> the policy enforcement
///              state is enabled. Otherwise, the policy enforcement state is disabled. <div class="alert"><b>Note</b> The memory
///              for this must be allocated by the caller. </div> <div> </div>
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt>
///    </dl> </td> <td width="60%"> The specified IPv4 subnet does not exist. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4QueryPolicyEnforcement(PWSTR ServerIpAddress, BOOL fGlobalPolicy, uint SubnetAddress, BOOL* Enabled);

///The <b>DhcpV4SetPolicyEnforcement</b> function sets the policy enforcement state of the server or the specified IPv4
///subnet on the DHCP Server.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    fGlobalPolicy = If <b>TRUE</b> the policy enforcement state of the server is set. Otherwise, the policy enforcement state of
///                    specified Ipv4 scope is set.
///    SubnetAddress = DHCP_IP_ADDRESS structure that contains the IPv4 subnet address of the policy enforcement state to set.
///    Enable = If <b>TRUE</b> the policy enforcement state is enabled. Otherwise, the policy enforcement state is disabled.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt>
///    </dl> </td> <td width="60%"> The specified IPv4 subnet does not exist. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4SetPolicyEnforcement(PWSTR ServerIpAddress, BOOL fGlobalPolicy, uint SubnetAddress, BOOL Enable);

///The <b>DhcpHlprIsV4PolicyWellFormed</b> function verifies that a DHCP server policy structure is well formed.
///Params:
///    pPolicy = Pointer to DHCP_POLICY structure that contains the policy to verify
///Returns:
///    The API returns <b>TRUE</b> if the specified policy satisfies the conditions in the <b>Remarks</b> below.
///    Otherwise, it returns <b>FALSE</b>.
///    
@DllImport("DHCPSAPI")
BOOL DhcpHlprIsV4PolicyWellFormed(DHCP_POLICY* pPolicy);

///The <b>DhcpHlprIsV4PolicyValid</b> function verifies a DHCP server policy.
///Params:
///    pPolicy = Pointer to DHCP_POLICY structure that contains the policy to verify.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl> </td> <td width="60%"> The
///    specified IPv4 subnet does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The parameter was invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_DHCP_INVALID_POLICY_EXPRESSION</b></dt> </dl> </td> <td width="60%"> The
///    specified conditions or expressions of the policy are invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_RANGE_INVALID_IN_SERVER_POLICY</b></dt> </dl> </td> <td width="60%"> A policy range has been
///    specified for a server level policy. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_POLICY_RANGE_BAD</b></dt> </dl> </td> <td width="60%"> The specified policy range is not
///    contained within the IP address range of the scope or the specified policy range is invalid. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpHlprIsV4PolicyValid(DHCP_POLICY* pPolicy);

///The <b>DhcpV4CreatePolicy</b> function creates a new policy on the DHCP Server.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    pPolicy = Pointer to a DHCP_POLICY structure that contains the parameters of the policy to create.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl> </td> <td width="60%"> The specified IPv4 subnet does not
///    exist. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_RANGE_INVALID_IN_SERVER_POLICY</b></dt> </dl>
///    </td> <td width="60%"> A policy range has been specified for a server level policy. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_DHCP_INVALID_POLICY_EXPRESSION</b></dt> </dl> </td> <td width="60%"> The specified
///    conditions or expressions of the policy are invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_POLICY_RANGE_BAD</b></dt> </dl> </td> <td width="60%"> The specified policy IP range is not
///    contained within the IP address range of the scope or the specified policy IP range is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_DHCP_POLICY_EXISTS</b></dt> </dl> </td> <td width="60%"> The specified policy
///    name exists at the specified level (server or scope). </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_POLICY_RANGE_EXISTS</b></dt> </dl> </td> <td width="60%"> The specified policy IP range
///    overlaps with the policy IP ranges of an existing policy at the specified scope. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_DHCP_INVALID_PROCESSING_ORDER</b></dt> </dl> </td> <td width="60%"> The specified
///    processing order is greater than the maximum processing order of the existing policies at the specified level
///    (server or scope). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_CLASS_NOT_FOUND</b></dt> </dl> </td>
///    <td width="60%"> The vendor class or user class reference in the conditions of the policy does not exist. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The
///    parameters were invalid. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4CreatePolicy(PWSTR ServerIpAddress, DHCP_POLICY* pPolicy);

///The <b>DhcpV4GetPolicy</b> function retrieves a policy from the DHCP Server.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    fGlobalPolicy = If <b>TRUE</b> the server level policy is retrieved. Otherwise, the scope level policy is retrieved.
///    SubnetAddress = DHCP_IP_ADDRESS structure that contains the IPv4 subnet address of the policy to retrieve.
///    PolicyName = A null-terminated Unicode string that represents the name of the policy to retrieve.
///    Policy = Pointer to a DHCP_POLICY structure that contains the parameters of the policy requested in <i>PolicyName</i>.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt>
///    </dl> </td> <td width="60%"> The specified IPv4 subnet does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_POLICY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The DHCP server policy was not found.
///    </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4GetPolicy(PWSTR ServerIpAddress, BOOL fGlobalPolicy, uint SubnetAddress, PWSTR PolicyName, 
                     DHCP_POLICY** Policy);

///The <b>DhcpV4SetPolicy</b> function updates one or more parameters of an existing policy.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    FieldsModified = A value from the DHCP_POLICY_FIELDS_TO_UPDATE enumeration that defines the DHCPv4 policy fields to modify.
///    fGlobalPolicy = If <b>TRUE</b> the server level policy is set. Otherwise, the scope level policy is set.
///    SubnetAddress = DHCP_IP_ADDRESS structure that contains the IPv4 subnet address of the policy to modify.
///    PolicyName = A null-terminated Unicode string that represents the name of the policy to modify.
///    Policy = Pointer to a DHCP_POLICY structure that contains the parameters of the policy to modify.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt>
///    </dl> </td> <td width="60%"> The specified IPv4 subnet does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_RANGE_INVALID_IN_SERVER_POLICY</b></dt> </dl> </td> <td width="60%"> A policy range has been
///    specified for a server level policy. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_INVALID_POLICY_EXPRESSION</b></dt> </dl> </td> <td width="60%"> The specified conditions or
///    expressions of the policy are invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_POLICY_RANGE_BAD</b></dt> </dl> </td> <td width="60%"> The specified policy range is not
///    contained within the IP address range of the scope or the specified policy range is invalid. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_DHCP_POLICY_RANGE_EXISTS</b></dt> </dl> </td> <td width="60%"> The specified
///    policy range overlaps with the policy ranges of an existing policy at the specified scope. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_DHCP_INVALID_PROCESSING_ORDER</b></dt> </dl> </td> <td width="60%"> The specified
///    processing order is greater than the maximum processing order of the existing policies at the specified level
///    (server or scope). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_CLASS_NOT_FOUND</b></dt> </dl> </td>
///    <td width="60%"> The vendor class or user class reference in the conditions of the policy does not exist. </td>
///    </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4SetPolicy(PWSTR ServerIpAddress, uint FieldsModified, BOOL fGlobalPolicy, uint SubnetAddress, 
                     PWSTR PolicyName, DHCP_POLICY* Policy);

///The <b>DhcpV4DeletePolicy</b> function deletes an existing policy from the DHCP Server.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    fGlobalPolicy = If <b>TRUE</b> the server level policy is deleted. Otherwise, the scope level policy is deleted.
///    SubnetAddress = DHCP_IP_ADDRESS structure that contains the IPv4 subnet address of the policy to delete.
///    PolicyName = A null-terminated Unicode string that represents the name of the policy to delete.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    error codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl> </td> <td width="60%"> The specified IPv4 subnet does not
///    exist. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_POLICY_NOT_FOUND</b></dt> </dl> </td> <td
///    width="60%"> The DHCP server policy was not found. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The parameters were invalid. </td> </tr>
///    </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4DeletePolicy(PWSTR ServerIpAddress, BOOL fGlobalPolicy, uint SubnetAddress, PWSTR PolicyName);

///The <b>DhcpV4EnumPolicies</b> function enumerates the policies configured on the DHCP Server.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    ResumeHandle = Pointer to a DHCP_RESUME_HANDLE structure that identifies this enumeration for use in subsequent calls to this
///                   function. Initially, this value should be zero on input. If successful, the returned value should be used for
///                   subsequent enumeration requests. For example, if <i>PreferredMaximum</i> is set to 100, and 200 policies are
///                   configured on the server, the resume handle can be used after the first 100 policies are retrieved to obtain the
///                   next 100 on a subsequent call.
///    PreferredMaximum = The maximum number of policy structures to return in <i>EnumInfo</i>. If <i>PreferredMaximum</i> is greater than
///                       the number of remaining non-enumerated policies on the server, the remaining number of non-enumerated policies is
///                       returned.
///    fGlobalPolicy = If <b>TRUE</b> the server level policy is enumerated. Otherwise, the scope level policy is enumerated.
///    SubnetAddress = DHCP_IP_ADDRESS structure that contains the IPv4 subnet address of the policies to enumerate.
///    EnumInfo = Pointer to a DHCP_POLICY_ARRAY structure that contains the policies available on the DHCP server. If no policies
///               are configured, this value is <b>NULL</b>.
///    ElementsRead = Pointer to a <b>DWORD</b> that specifies the number of policies returned in <i>EnumInfo</i>.
///    ElementsTotal = Pointer to a <b>DWORD</b> that specifies the number of policies configured on the DHCP server that have not yet
///                    been enumerated.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> There are more elements
///    available to enumerate. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td>
///    <td width="60%"> There are no more elements left to enumerate. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4EnumPolicies(PWSTR ServerIpAddress, uint* ResumeHandle, uint PreferredMaximum, BOOL fGlobalPolicy, 
                        uint SubnetAddress, DHCP_POLICY_ARRAY** EnumInfo, uint* ElementsRead, uint* ElementsTotal);

///The <b>DhcpV4AddPolicyRange</b> function adds an IP address range to a policy.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    SubnetAddress = DHCP_IP_ADDRESS structure that contains the IPv4 subnet address of the policy IP address range to add.
///    PolicyName = A null-terminated Unicode string that represents the name of the policy IP address range to add.
///    Range = A pointer to a DHCP_IP_RANGE structure that contains the policy IP address range to add.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl> </td> <td width="60%"> The
///    specified IPv4 subnet does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_POLICY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified policy does not exist.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_POLICY_RANGE_EXISTS</b></dt> </dl> </td> <td
///    width="60%"> The specified policy IP range overlaps with one of the policy IP address ranges specified. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_POLICY_RANGE_BAD</b></dt> </dl> </td> <td width="60%"> The
///    specified policy IP range is not contained within the IP address range of the scope or the specified policy IP
///    range is not valid. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4AddPolicyRange(PWSTR ServerIpAddress, uint SubnetAddress, PWSTR PolicyName, DHCP_IP_RANGE* Range);

///The <b>DhcpV4RemovePolicyRange</b> function removes the specified IP address range from the list of IP address ranges
///of the policy.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    SubnetAddress = DHCP_IP_ADDRESS structure that contains the IPv4 subnet address of the policy IP address range to remove.
///    PolicyName = A null-terminated Unicode string that represents the name of the policy IP address range to remove.
///    Range = A pointer to a DHCP_IP_RANGE structure that contains the policy IP address range to remove.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt>
///    </dl> </td> <td width="60%"> The specified IPv4 subnet does not exist. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_POLICY_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified policy does not exist.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_POLICY_RANGE_BAD</b></dt> </dl> </td> <td width="60%">
///    The specified policy range is not contained within the IP address range of the scope. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4RemovePolicyRange(PWSTR ServerIpAddress, uint SubnetAddress, PWSTR PolicyName, DHCP_IP_RANGE* Range);

///The <b>DhcpV6SetStatelessStoreParams</b> function sets the DHCPv6 stateless client inventory configuration settings
///at the server or scope level.
///Params:
///    ServerIpAddress = Pointer to a Unicode string that specifies the IP address or hostname of the DHCP server.
///    fServerLevel = If <b>TRUE</b> the stateless client inventory configuration settings at server level are modified. Otherwise, the
///                   scope level configuration settings are modified.
///    SubnetAddress = A DHCP_IPV6_ADDRESS structure that contains the IPv6 subnet address of the stateless client inventory
///                    configuration settings to be modified. If the value of <i>fServerLevel</i> is <b>TRUE</b>, this must be 0.
///    FieldModified = A value from the DHCPV6_STATELESS_PARAM_TYPE enumeration that defines the DHCPv6 stateless client inventory
///                    configuration parameter type to be modified.
///    Params = Pointer to a DHCPV6_STATELESS_PARAMS structure that contains the stateless client inventory configuration
///             settings for a DHCPv6 server.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt>
///    </dl> </td> <td width="60%"> IPv6 subnet does not exist on the DHCPv6 server. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV6SetStatelessStoreParams(PWSTR ServerIpAddress, BOOL fServerLevel, DHCP_IPV6_ADDRESS SubnetAddress, 
                                   uint FieldModified, DHCPV6_STATELESS_PARAMS* Params);

///The <b>DhcpV6GetStatelessStoreParams</b> function retrieves the current DHCPv6 stateless client inventory
///configuration settings at the server or scope level.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    fServerLevel = If <b>TRUE</b> the stateless client inventory configuration settings at server level are retrieved. Otherwise,
///                   the scope level configuration settings are retrieved.
///    SubnetAddress = A DHCP_IPV6_ADDRESS structure that contains the IPv6 subnet address of the stateless client inventory
///                    configuration settings to be retrieved. If the value of <i>fServerLevel</i> is <b>TRUE</b>, this must be 0.
///    Params = Pointer to a DHCPV6_STATELESS_PARAMS structure that contains the stateless client inventory configuration
///             settings for a DHCPv6 server.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt>
///    </dl> </td> <td width="60%"> IPv6 subnet does not exist on the DHCPv6 server. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV6GetStatelessStoreParams(PWSTR ServerIpAddress, BOOL fServerLevel, DHCP_IPV6_ADDRESS SubnetAddress, 
                                   DHCPV6_STATELESS_PARAMS** Params);

///The <b>DhcpV6GetStatelessStatistics</b> function retrieves the stateless server IPv6 subnet statistics.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    StatelessStats = Pointer to a DHCPV6_STATELESS_STATS structure that contain DHCPv6 stateless server IPv6 subnet statistics.
///Returns:
///    This function returns <b>ERROR_SUCCESS</b> upon a successful call. Otherwise, it returns one of the DHCP Server
///    Management API Error Codes.
///    
@DllImport("DHCPSAPI")
uint DhcpV6GetStatelessStatistics(PWSTR ServerIpAddress, DHCPV6_STATELESS_STATS** StatelessStats);

///The <b>DhcpV4CreateClientInfo</b> function creates a DHCPv4 client lease record in the DHCP server database.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    ClientInfo = Pointer to a DHCP_CLIENT_INFO_PB structure that contains the DHCP client lease record information. The
///                 <b>ClientIpAddress</b> and <b>ClientHardwareAddress</b> fields of this structure are required, all others are
///                 optional.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl>
///    </td> <td width="60%"> This call was performed by a client who is not a member of the <i>DHCP Administrators</i>
///    security group. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl> </td>
///    <td width="60%"> The <b>ClientIpAddress</b> passed within <i>ClientInfo</i> does not match any DHCPv4 scope
///    configured on the DHCP server. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_CLIENT_EXISTS</b></dt>
///    </dl> </td> <td width="60%"> The provided DHCP client record already exists in the DHCP server database. </td>
///    </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4CreateClientInfo(const(PWSTR) ServerIpAddress, const(DHCP_CLIENT_INFO_PB)* ClientInfo);

///The <b>DhcpV4EnumSubnetClients</b> function enumerates all DHCP client records serviced from the specified IPv4
///subnet.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    SubnetAddress = DHCP_IP_ADDRESS structure that contains the IPv4 subnet address of the DHCP client records to enumerate. If set
///                    to 0, the DHCP client records for all known IPv4 subnets are returned.
///    ResumeHandle = Pointer to a DHCP_RESUME_HANDLE structure that identifies this enumeration for use in subsequent calls to this
///                   function. Initially, this value should be zero on input. If successful, the returned value should be used for
///                   subsequent enumeration requests. The returned handle value is the last IPv4 address retrieved in the enumeration
///                   operation.
///    PreferredMaximum = The maximum number of bytes of client records to return in <i>ClientInfo</i>. The minimum value is 1024 bytes,
///                       and the maximum value is 65536 bytes.
///    ClientInfo = Pointer to a DHCP_CLIENT_INFO_PB_ARRAY structure that contains the DHCP client lease records set available for
///                 the specified subnet.
///    ClientsRead = Pointer to a <b>DWORD</b> that specifies the number of DHCP client records returned in <i>ClientInfo.</i>
///    ClientsTotal = Pointer to a <b>DWORD</b> that specifies the number of client records on the DHCP server that have not yet been
///                   enumerated.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was
///    performed by a client who is not a member of the <i>DHCP Users</i> or <i>DHCP Administrators</i> security groups.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_JET_ERROR</b></dt> </dl> </td> <td width="60%"> An error
///    occurred while accessing the DHCP server's database. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_MORE_DATA</b></dt> </dl> </td> <td width="60%"> There are still non-enumerated client lease records
///    on the DHCP server for the provided IPv4 subnet. Call this function again with the returned resume handle to
///    obtain more records. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NO_MORE_ITEMS</b></dt> </dl> </td> <td
///    width="60%"> There are no client lease records on the DHCP server. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4EnumSubnetClients(const(PWSTR) ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, 
                             uint PreferredMaximum, DHCP_CLIENT_INFO_PB_ARRAY** ClientInfo, uint* ClientsRead, 
                             uint* ClientsTotal);

///The <b>DhcpV4GetClientInfo</b> function retrieves DHCP client lease record information from the DHCP server database.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    SearchInfo = Pointer to a DHCP_SEARCH_INFO structure that defines the key used to search for the client lease record on the
///                 DHCP server.
///    ClientInfo = Pointer to a DHCP_CLIENT_INFO_PB structure that returns the DHCP client lease record information.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> Invalid or NULL
///    <i>SearchInfo</i> was passed to the function. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client that is not
///    a member of the <i>DHCP Users</i> or <i>DHCP Administrators</i> security groups. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_DHCP_INVALID_DHCP_CLIENT</b></dt> </dl> </td> <td width="60%"> The DHCP client is
///    not valid. In this case, the search information passed had no corresponding IPv4 lease records. </td> </tr>
///    </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4GetClientInfo(const(PWSTR) ServerIpAddress, const(DHCP_SEARCH_INFO)* SearchInfo, 
                         DHCP_CLIENT_INFO_PB** ClientInfo);

///The <b>DhcpV6CreateClientInfo</b> function creates a DHCPv6 client lease record in the DHCP server database.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    ClientInfo = Pointer to a DHCP_CLIENT_INFO_V6 structure that contains the DHCP client lease record information. The
///                 <b>ClientIpAddress</b>, <b>ClientDUID</b> and <b>IAID</b> fields of this structure are required, all others are
///                 optional.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> <b>ClientDUID</b>
///    in the <i>ClientInfo</i> parameter was <b>NULL</b> or a zero length buffer. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> This call was performed by a client that is
///    not a member of the <i>DHCP Administrators</i> security group. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt> </dl> </td> <td width="60%"> The specified subnet does not exist.
///    In this case, there is no subnet corresponding to <b>ClientIpAddress</b> in the <i>ClientInfo</i> parameter.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_CLIENT_EXISTS</b></dt> </dl> </td> <td width="60%"> The
///    provided DHCP client record already exists in the DHCP server database. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV6CreateClientInfo(const(PWSTR) ServerIpAddress, const(DHCP_CLIENT_INFO_V6)* ClientInfo);

///The <b>DhcpV4GetFreeIPAddress</b> function retrieves the list of available IPv4 addresses that can be leased to
///clients.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    ScopeId = DHCP_IP_ADDRESS structure that specifies the IPv4 subnet ID from which available addresses to lease to clients
///              are retrieved.
///    StartIP = DHCP_IP_ADDRESS structure that specifies the scope IPv4 range's starting point address from where the available
///              addresses are retrieved. If this parameter is 0, the start address of the IPv4 subnet specified by <i>ScopeId</i>
///              is the default.
///    EndIP = DHCP_IP_ADDRESS structure that specifies the scope IPv4 range's end point address from where the available
///            addresses are retrieved. If this parameter is 0, the end address of the IPv4 subnet specified by <i>ScopeId</i>
///            parameter is taken as the default.
///    NumFreeAddrReq = Integer that specifies the number of IPv4 addresses retrieved from the specified scope in <i>IPAddrList</i>. If
///                     this parameter is 0, only one IPv4 address is returned.
///    IPAddrList = Pointer to a DHCP_IP_ARRAY structure that contains the list of available IPv4 addresses that can be leased to
///                 clients.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl>
///    </td> <td width="60%"> There are no more elements left to enumerate. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_DHCP_REACHED_END_OF_SELECTION</b></dt> </dl> </td> <td width="60%"> The specified DHCP Server has
///    reached the end of the selected range while finding the free IP address. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV4GetFreeIPAddress(PWSTR ServerIpAddress, uint ScopeId, uint StartIP, uint EndIP, uint NumFreeAddrReq, 
                            DHCP_IP_ARRAY** IPAddrList);

///The <b>DhcpV6GetFreeIPAddress</b> function retrieves the list of available IPv6 addresses that can be leased to
///clients.
///Params:
///    ServerIpAddress = Pointer to a null-terminated Unicode string that represents the IP address or hostname of the DHCP server.
///    ScopeId = DHCP_IPV6_ADDRESS structure that specifies the IPv6 subnet ID from which available addresses to lease to clients
///              are retrieved.
///    StartIP = DHCP_IPV6_ADDRESS structure that specifies the scope IPv6 range's starting point address from where the available
///              addresses are retrieved. If this parameter is 0, the start address of the IPv6 subnet specified by <i>ScopeId</i>
///              is the default.
///    EndIP = DHCP_IPV6_ADDRESS structure that specifies the scope IPv6 range's end point address from where the available
///            addresses are retrieved. If this parameter is 0, the end address of the IPv6 subnet specified by <i>ScopeId</i>
///            parameter is taken as the default.
///    NumFreeAddrReq = Integer that specifies the number of IPv6 addresses retrieved from the specified scope in <i>IPAddrList</i>. If
///                     this parameter is 0, only one IPv6 address is returned.
///    IPAddrList = Pointer to a DHCPV6_IP_ARRAY structure that contains the list of available IPv6 addresses that can be leased to
///                 clients.
///Returns:
///    If the function succeeds, it returns <b>ERROR_SUCCESS</b>. If the function fails, it returns one of the following
///    or an error code from DHCP Server Management API Error Codes. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or more of
///    the parameters were invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DHCP_SUBNET_NOT_PRESENT</b></dt>
///    </dl> </td> <td width="60%"> IPv6 subnet does not exist on the DHCP server. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_DHCP_REACHED_END_OF_SELECTION</b></dt> </dl> </td> <td width="60%"> The specified DHCP server
///    has reached the end of the selected range while finding the free IP address. </td> </tr> </table>
///    
@DllImport("DHCPSAPI")
uint DhcpV6GetFreeIPAddress(PWSTR ServerIpAddress, DHCP_IPV6_ADDRESS ScopeId, DHCP_IPV6_ADDRESS StartIP, 
                            DHCP_IPV6_ADDRESS EndIP, uint NumFreeAddrReq, DHCPV6_IP_ARRAY** IPAddrList);

@DllImport("DHCPSAPI")
uint DhcpV4CreateClientInfoEx(const(PWSTR) ServerIpAddress, const(DHCP_CLIENT_INFO_EX)* ClientInfo);

@DllImport("DHCPSAPI")
uint DhcpV4EnumSubnetClientsEx(const(PWSTR) ServerIpAddress, uint SubnetAddress, uint* ResumeHandle, 
                               uint PreferredMaximum, DHCP_CLIENT_INFO_EX_ARRAY** ClientInfo, uint* ClientsRead, 
                               uint* ClientsTotal);

@DllImport("DHCPSAPI")
uint DhcpV4GetClientInfoEx(const(PWSTR) ServerIpAddress, const(DHCP_SEARCH_INFO)* SearchInfo, 
                           DHCP_CLIENT_INFO_EX** ClientInfo);

@DllImport("DHCPSAPI")
uint DhcpV4CreatePolicyEx(PWSTR ServerIpAddress, DHCP_POLICY_EX* PolicyEx);

@DllImport("DHCPSAPI")
uint DhcpV4GetPolicyEx(PWSTR ServerIpAddress, BOOL GlobalPolicy, uint SubnetAddress, PWSTR PolicyName, 
                       DHCP_POLICY_EX** Policy);

@DllImport("DHCPSAPI")
uint DhcpV4SetPolicyEx(PWSTR ServerIpAddress, uint FieldsModified, BOOL GlobalPolicy, uint SubnetAddress, 
                       PWSTR PolicyName, DHCP_POLICY_EX* Policy);

@DllImport("DHCPSAPI")
uint DhcpV4EnumPoliciesEx(PWSTR ServerIpAddress, uint* ResumeHandle, uint PreferredMaximum, BOOL GlobalPolicy, 
                          uint SubnetAddress, DHCP_POLICY_EX_ARRAY** EnumInfo, uint* ElementsRead, 
                          uint* ElementsTotal);


